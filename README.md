# Alpine SSHD (Dropbear)

[![Docker Repository on Quay](https://quay.io/repository/0xff/alpine-sshd/status "Docker Repository on Quay")](https://quay.io/repository/0xff/alpine-sshd)

This is a small Alpine-based container containung [Dropbear SSH](https://matt.ucc.asn.au/dropbear/dropbear.html).

## Usecases

- Accessing shared volumes via SSH/SFTP.
- Accessing a docker network via SSH tunnel.

## Usage

- Set `USER` and `PASSWORD` environment variables (in cleartext).
- Redirect TCP/22 port

example:

    docker run -d --rm \
    -e USER=myusername \
    -e PASSWORD=mypassword \
    -p 2222:22 \
    quay.io/0xff/alpine-sshd


## Passwordles

To use key based authentication, set the `AUTHORIZED_KEYS` environment variable.  
In that case you can omit setting `PASSWORD`.

See [docker-compose.yml](docker-compose.yml).

## Dropbear Notes

Options used in this container:

```
-R              Create hostkeys as required
-F              Don't fork into background
-E              Log to stderr rather than syslog
-w              Disallow root logins
-g              Disable password logins for root
```
