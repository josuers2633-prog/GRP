# ===== BUILD: compilar clases Java (servlets/repos/model) =====
FROM eclipse-temurin:17-jdk AS build

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Jakarta Servlet API (Tomcat 10.1 usa jakarta.servlet 6.x)
RUN curl -L -o /tmp/jakarta-servlet.jar \
  https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar

# Compilar Java (src/) hacia WEB-INF/classes
RUN mkdir -p /out/WEB-INF/classes \
 && javac -encoding UTF-8 -cp /tmp/jakarta-servlet.jar \
    -d /out/WEB-INF/classes \
    $(find src -name "*.java")

# Copiar recursos web (JSP, WEB-INF, resources, etc.)
# (En tu repo: carpeta "web" existe al mismo nivel que src)
RUN cp -R web/* /out/

# ===== RUNTIME: Tomcat =====
FROM tomcat:10.1-jdk17-temurin

ENV PORT=10000
EXPOSE 10000

# Desplegar la app en ROOT
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=build /out /usr/local/tomcat/webapps/ROOT

# Cambiar Tomcat a PORT y arrancar
CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT}\\\"/\" $CATALINA_HOME/conf/server.xml && catalina.sh run"]
