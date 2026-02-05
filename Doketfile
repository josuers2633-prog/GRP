# ===== Build (Ant) =====
FROM eclipse-temurin:17-jdk AS build
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY . .
RUN ant -noinput -buildfile build.xml clean dist

# ===== Run (WAR) =====
FROM eclipse-temurin:17-jre
WORKDIR /app

# Descarga un runner de WAR (Tomcat embebido)
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
 && curl -L -o webapp-runner.jar \
    https://repo1.maven.org/maven2/com/github/jsimone/webapp-runner/9.0.90.0/webapp-runner-9.0.90.0.jar

# Copia el WAR generado por Ant
COPY --from=build /app/dist/*.war app.war

# Render inyecta PORT; webapp-runner lo usa
CMD ["sh","-c","java -jar webapp-runner.jar --port $PORT app.war"]
