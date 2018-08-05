pipeline {
  agent any
  stages {
    stage('编译') {
      steps {
        git(url: 'git@github.com:leeyan85/company-news.git', branch: 'master')
        withMaven(maven: 'maven-3.3.9', publisherStrategy: 'EXPLICIT') {
          sh 'mvn clean package -Dmaven.test.skip=true'
        }

      }
    }
    stage('部署测试环境') {
      steps {
        sh 'ansible uat -m copy -a \'src=target/hello.war dest=/root/tomcat8/webapps\''
        
      }
    }
    stage('上传版本到版本库') {
      steps {
        input(message: '测试是否成功了 ?  按yes按钮，将会生成归档文件，上传到nexus', submitter: 'admin', ok: 'YES', submitterParameter: 'testok')
        sh 'echo upload package to nexus'
        archiveArtifacts(allowEmptyArchive: true, artifacts: 'target/hello.war', fingerprint: true)
        
      }
    }
    stage('发布灰度环境') {
      steps {
        input(message: '是否发布到灰度环境？ ', ok: 'YES', submitter: 'admin', submitterParameter: 'deploy')
        sh 'ansible staging -m copy -a \'src=target/hello.war dest=/root/tomcat8/webapps\''
      }
    }
    stage('发布生产环境') {
      steps {
        input(message: '是否发布到生产环境？ ', ok: 'YES', submitter: 'admin', submitterParameter: 'deploy')
        sh 'ansible prod -m copy -a \'src=target/hello.war dest=/root/tomcat8/webapps\''
      }
    }
  }
}
