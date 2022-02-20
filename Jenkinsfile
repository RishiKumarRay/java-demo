@Library('my-maven-library')_
pipeline{

    agent {
             label 'slave'
           }

     tools   {
                jdk 'jdk'
                 maven 'Maven' 
              }  
   
    environment {
                image_built=''
                image_tag='rishiray/hello-world:1.0'
                dockerhub=credentials('dockerhub')
                  } 
    
    stages{
        stage('Build')
          {   
            steps {
                     mavenBuild()
                  }
           }
       
        stage('test')
          {
            steps
                {
                   runTests()
                }
           }   
  
        stage('"Packaging, pushing to DockerHub')
        {
             when  {
                     branch "Production"
                   }
            stages
            {  
                stage("Packaging the application into executable jar")
                
                  {   
                    steps
                        {
                          mavenPackage()
                        }
                   }
                
                stage("Building the docker image")
                 {

                   steps
                        {
                          script
                             {
                               image_built=docker.build image_tag
                    
                              }
                         }
                 } 
                stage("Push the Image to DockerHub")
                {
                    steps
                         {
                              script
                               {
                                 docker.withRegistry('', 'dockerhub')
                                  {
                                    image_built.push()
                                     image_built.push('latest')
                                  }
                               }
                           }
                 }
           }
        } 
     }  
      post {

          always
             {
                 emailext attachLog: true, body: '$DEFAULT_CONTENT', subject: '$DEFAULT_SUBJECT', to: 'rishirai.iimt@gmail.com'  
             }
       }
   }
