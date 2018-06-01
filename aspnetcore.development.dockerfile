FROM microsoft/dotnet:2.0-sdk

WORKDIR /var/www/aspnetcoreapp
COPY . /var/www/aspnetcoreapp
RUN dotnet restore
RUN dotnet build

ENV ASPNETCORE_URLS=http://+:80
CMD dotnet PostgreSQL.Demo.dll
