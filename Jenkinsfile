pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        git(url: 'git@github.com:leeyan85/company-news.git', branch: 'master')
        withMaven(maven: 'maven-3.3.9', publisherStrategy: 'EXPLICIT') {
          sh 'mvn clean package -Dmaven.test.skip=true'
        }

      }
    }
    stage('deploy to test ENV') {
      steps {
        sh 'ansible uat -m copy -a \'src=target/hello.war dest=/root/tomcat8/webapps\''
        
      }
    }
    stage('upload to nexus') {
      steps {
        input(message: 'Is testing pass? Press YES button,it will archive the code and upload to nexus', submitter: 'admin', ok: 'YES', submitterParameter: 'testok')
        sh 'echo upload package to nexus'
        archiveArtifacts(allowEmptyArchive: true, artifacts: 'target/hello.war', fingerprint: true)
        
      }
    }
    stage('deplpy to staging') {
      steps {
        input(message: 'Deploy to staging ?', ok: 'YES', submitter: 'admin', submitterParameter: 'deploy')
        sh 'ansible staging -m copy -a \'src=target/hello.war dest=/root/tomcat8/webapps\''
      }
    }
    stage('deploy to prod') {
      steps {
        input(message: 'Deploy to PROD ? ', ok: 'YES', submitter: 'admin', submitterParameter: 'deploy')
        sh 'ansible prod -m copy -a \'src=target/hello.war dest=/root/tomcat8/webapps\''
      }
    }
  }
}
