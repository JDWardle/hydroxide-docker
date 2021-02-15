# Hydroxide Docker
Docker image for the [Hydroxide](https://github.com/emersion/hydroxide)
ProtonMail bridge built on the [LinuxServer.io](https://linuxserver.io/) Alpine
base image.

## Supported Archictures

| Architecture | Tag|
| :----: | --- |
| x86-64 | amd64-latest |

## Parameters

| Parameter | Function |
| :----: | --- |
| `-p 1025` | Default SMTP port. |
| `-p 1143` | Default IMAP port. |
| `-p 8080` | Default CardDAV port. |
| `-e HYDROXIDE_CMD=serve` | Specifify the command passed to Hydroxide (`serve`, `imap`, `smpt`, `carddav`). |
| `-e HYDROXIDE_FLAGS` | Flags passed to Hydroxide, used to override default settings. |
| `-e PUID=1000` | for UserID - see below for explanation. |
| `-e PGID=1000` | for GroupID - see below for explanation. |
| `-e TZ=America/Denver` | Specify a timezone to use (e.g. America/Denver). |
| `-v /config/hydroxide` | Hydroxide configuration volume. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS
and the container, we avoid this issue by allowing you to specify the user
`PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify
and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as
below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Application Setup

Hydroxide requires manual user input for adding ProtonMail accounts. This can be
done after launching a container but it is recommended to have an `auth.json`
file already configured and placed in the `/config/hydroxide` volume.

### Running Container
You just need to run `docker exec -it [CONTAINER] hydroxide auth` and follow the
displayed prompts. The config file that is saved from running that command will
be available under the `/config/hydroxide` volume.

### Existing Volume
Alternatively an already created `auth.json` file can be added to a volume
manually but the volume must first be created with `docker volume create hydroxide-config`
and attached to the container with `docker run -v hydroxide-config:/config/hydroxide`.
