# NuGet Stack

An Okinta Stack that hosts a NuGet server.

## What is an Okinta Stack?

An Okinta stack is a deployable unit for Alga that runs within Okinta's
infrastructure. Stacks describe all necessary information to deploy a service.

For more information about Alga, refer to the [alga-infra repository][1].

[1]: https://github.com/okinta/alga-infra

## What is this Stack?

Runs [s3proxy][1] in front of an S3 bucket that hosts internal C# libraries via
NuGet. NuGet packages are uploaded to S3 via [Sleet][2].

[1]: https://github.com/okinta/s3proxy
[2]: https://github.com/emgarten/Sleet

## Dependencies

This stack is dependent on the [vault stack][1] in order to retrieve bucket
information. It makes use of the [okinta/s3proxy][2] container.

[1]: https://github.com/okinta/stack-vault
[2]: https://github.com/okinta/s3proxy

## Development

### Build

    docker build -t okinta/stack-nuget .

### Run

    docker run -p 8080:8080 okinta/stack-nuget

### Check FCOS Config Syntax

    fcct --strict < coreos.fcc > /dev/null

### Connecting to Vault

To connect to Vault locally, establish an SSH tunnel:

    ssh -N -o ServerAliveInterval=60 -o ExitOnForwardFailure=yes -L 7020:127.0.0.1:7020 <VAULT HOST>

Then to allow access to Vault inside the container, use:

    docker run --add-host "vault.in.okinta.ge:$(docker run alpine getent hosts host.docker.internal | cut -d' ' -f1)" -p 8080:8080 okinta/stack-nuget
