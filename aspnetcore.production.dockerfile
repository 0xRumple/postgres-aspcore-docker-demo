FROM microsoft/dotnet:2.1-sdk-alpine AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.csproj .
RUN dotnet restore

# copy everything else and build app
COPY . .
WORKDIR /app
RUN dotnet build


FROM build AS publish
WORKDIR /app
RUN dotnet publish -c Release -o out


FROM microsoft/dotnet:2.1-runtime-alpine AS runtime
WORKDIR /app
COPY --from=publish /app/out ./
ENV ASPNETCORE_URLS=http://+:80
CMD dotnet PostgreSQL.Demo.dll
