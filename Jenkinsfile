pipeline {

    agent any

    stages {

        stage('Test') {

            steps {
                parallel(
                    'check': {
                        sh "gradle check --stacktrace"
                    },
                    'echo': {
                        echo "Executing Unit Tests"
                    }
                    'ENV': {
                         echo "ENV " $ENV
                    }
                    'GRADLE_HOME': {
                        echo "GRADLE_HOME " $GRADLE_HOME
                    }
                    'PATH': {
                        echo "PATH " $PATH
                    }
                )
            }
        }
        stage('Build') {

            steps {
                checkout scm
                sh "gradle clean"
                sh "gradle bootJar"
                sh 'jarFile=`ls build/libs | grep -v original` && mkdir -p deployments && cp build/libs/$jarFile deployments/'
            }
        }
        stage('Build image') {
            steps {
                script {
                    docker.build("itau-hello")
                }
            }
        }
    }
//        stage('Build image') {
//            agent { label 'gradle' }
//            steps {
//                script {
//                    openshift.withCluster() {
//                        openshift.withProject('dev') {
//                            // create docker build
//                            def buildTemplate = readYaml file: 'openshift/demo-docker-build.yml'
//                            def resources = openshift.process(buildTemplate)
//                            def buildCfg = openshift.apply(resources).narrow('bc')
//                            // create app template
//                            def template = readYaml file: 'openshift/demo-template.yml'
//                            openshift.apply(openshift.process(template))
//
//                            def buildSelector = buildCfg.startBuild('--from-dir=ocp')
//                            timeout(5) {
//                                buildSelector.untilEach(1) {
//                                    return it.object().status.phase == "Complete"
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        stage('Deploy') {
//            agent { label 'gradle' }
//            steps {
//                script {
//                    openshift.withCluster() {
//                        openshift.withProject('dev') {
//                            // TODO: replace it when https://github.com/openshift/jenkins-client-plugin/issues/84 will be solved
//                            // deployment is triggered by imagestream here
//                            openshiftVerifyDeployment depCfg: "demo", namespace: "dev"
//                            sh "curl -L http://demo.dev.svc.cluster.local:8080/health"
//                        }
//                    }
//                }
//            }
//        }
    
} > git rev-list --no-walk 29f9614a4797c12a73078ba6a90dd077936cc3df # timeout=10
