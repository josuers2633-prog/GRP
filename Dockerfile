# ===== 1) BUILD STAGE (Ant + JDK) =====
FROM eclipse-temurin:17-jdk AS build

RUN apt-get update \
 && apt-get install -y ant \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Compila el WAR usando Ant (NetBeans/Ant project)
RUN ant -noinput -buildfile build.xml clean dist \
 && ls -la dist

# ===== 2) RUNTIME STAGE (Tomcat) =====
FROM tomcat:10.1-jdk17-temurin

# Render recomienda escuchar en PORT (default 10000)
ENV PORT=10000
EXPOSE 10000

# Copiamos el WAR generado a ROOT.war para que abra en /
COPY --from=build /app/dist/*.war /usr/local/tomcat/webapps/ROOT.war

# Cambia Tomcat a PORT y arranca
CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT}\\\"/\" $CATALINA_HOME/conf/server.xml && catalina.sh run"]

