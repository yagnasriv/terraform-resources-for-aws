// docker.groovy
def dockerBuild() {
    println "Building Docker image..."
    sh 'docker build -t your-image-name:latest .'
}

def dockerPush() {
    println "Pushing Docker image to registry..."
    sh 'docker tag your-image-name:latest $DOCKER_REGISTRY_URL/your-image-name:latest'
    sh 'docker push $DOCKER_REGISTRY_URL/your-image-name:latest'
}

dockerBuild()
dockerPush()

return this