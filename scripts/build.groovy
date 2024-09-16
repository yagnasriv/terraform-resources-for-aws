// build.groovy
def build() {
    println "Building project..."
    sh './gradlew build'
}

return this