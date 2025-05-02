# Use the official .NET SDK image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the csproj and restore any dependencies (via nuget)
COPY HelloWorldApp/*.csproj ./HelloWorldApp/
RUN dotnet restore HelloWorldApp.csproj

# Copy the rest of the app
COPY . .

# Build the app
RUN dotnet publish HelloWorldApp.csproj -c Release -o /app/publish

# Generate the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/publish .

# Set the entry point for the application
ENTRYPOINT ["dotnet", "HelloWorldApp.dll"]
