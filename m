MIME-Version: 1.0
In-Reply-To: <1414016163-21102-1-git-send-email-steffan@...1856...>
References: <1414016163-21102-1-git-send-email-steffan@...1856...>
From: Steffan Karger <steffan@...1856...>
Date: Sat, 15 Nov 2014 15:06:47 +0100
Message-ID: <CAA1AbxKZr_E6Wk9GBbB3xpLyJzyBxSa1k21UDXnC90d8refUzw@...278...>
Content-Type: multipart/mixed; boundary=089e0149c9b4d5b8c40507e642c2
Subject: Re: [Openvpn-devel] [PATCH] Modernize sample keys and sample configs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--089e0149c9b4d5b8c40507e642c2
Content-Type: multipart/alternative; boundary=089e0149c9b4d5b8bf0507e642c0

--089e0149c9b4d5b8bf0507e642c0
Content-Type: text/plain; charset=UTF-8

Attached a v2 of this patch that adds an extra check whether openssl is
actually available.

-Steffan

On Thu, Oct 23, 2014 at 12:16 AM, Steffan Karger <steffan@...1856...> wrote:

> I kept most of the certificate properties equal to the old
> certs, since some people's test scripts might rely on them (and
> it does not require any creativity from my part).
>
> Changes:
>  * Add script to generate fresh test/sample keys
>    (but keep sample keys in git for simple testing)
>  * Switch from 1024 to 4096 bits RSA CA
>  * Switch from 1024 to 2048 bits client/server RSA keys
>  * Switch from 1024 to 2048 bits Diffie-Hellman parameters
>  * Generate EC client and server cert, but sign with RSA CA
>    (lets us test EC <-> RSA interoperability)
>  * Remove 3DES cipher from 'sample' config
>  * Add 'remote-cert-tls server' to client config
>  * Update config files to deprecate nsCertType in favour of the
>    keyUsage and extendedKeyUsage extensions.
>  * Make naming more consistent
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  sample/sample-config-files/client.conf     |  17 ++--
>  sample/sample-config-files/loopback-client |   2 +-
>  sample/sample-config-files/loopback-server |   3 +-
>  sample/sample-config-files/server.conf     |   6 +-
>  sample/sample-config-files/tls-office.conf |   2 +-
>  sample/sample-keys/.gitignore              |   1 +
>  sample/sample-keys/README                  |  17 ++--
>  sample/sample-keys/ca.crt                  |  48 ++++++----
>  sample/sample-keys/ca.key                  |  67 ++++++++++----
>  sample/sample-keys/client-ec.crt           |  85 ++++++++++++++++++
>  sample/sample-keys/client-ec.key           |   5 ++
>  sample/sample-keys/client-pass.key         |  30 +++++++
>  sample/sample-keys/client.crt              | 126
> +++++++++++++++++---------
>  sample/sample-keys/client.key              |  43 +++++----
>  sample/sample-keys/client.p12              | Bin 0 -> 4533 bytes
>  sample/sample-keys/dh1024.pem              |   5 --
>  sample/sample-keys/dh2048.pem              |   8 ++
>  sample/sample-keys/ec-ca.crt               |  13 ---
>  sample/sample-keys/ec-ca.key               |   6 --
>  sample/sample-keys/ec-client.crt           |  61 -------------
>  sample/sample-keys/ec-client.key           |   6 --
>  sample/sample-keys/ec-server.crt           |  61 -------------
>  sample/sample-keys/ec-server.key           |   6 --
>  sample/sample-keys/gen-sample-keys.sh      |  74 +++++++++++++++
>  sample/sample-keys/openssl.cnf             | 139
> +++++++++++++++++++++++++++++
>  sample/sample-keys/pass.crt                |  65 --------------
>  sample/sample-keys/pass.key                |  18 ----
>  sample/sample-keys/pkcs12.p12              | Bin 2685 -> 0 bytes
>  sample/sample-keys/server-ec.crt           |  96 ++++++++++++++++++++
>  sample/sample-keys/server-ec.key           |   5 ++
>  sample/sample-keys/server.crt              | 130
> ++++++++++++++++++---------
>  sample/sample-keys/server.key              |  43 +++++----
>  32 files changed, 778 insertions(+), 410 deletions(-)
>  create mode 100644 sample/sample-keys/.gitignore
>  create mode 100644 sample/sample-keys/client-ec.crt
>  create mode 100644 sample/sample-keys/client-ec.key
>  create mode 100644 sample/sample-keys/client-pass.key
>  create mode 100644 sample/sample-keys/client.p12
>  delete mode 100644 sample/sample-keys/dh1024.pem
>  create mode 100644 sample/sample-keys/dh2048.pem
>  delete mode 100644 sample/sample-keys/ec-ca.crt
>  delete mode 100644 sample/sample-keys/ec-ca.key
>  delete mode 100644 sample/sample-keys/ec-client.crt
>  delete mode 100644 sample/sample-keys/ec-client.key
>  delete mode 100644 sample/sample-keys/ec-server.crt
>  delete mode 100644 sample/sample-keys/ec-server.key
>  create mode 100755 sample/sample-keys/gen-sample-keys.sh
>  create mode 100644 sample/sample-keys/openssl.cnf
>  delete mode 100644 sample/sample-keys/pass.crt
>  delete mode 100644 sample/sample-keys/pass.key
>  delete mode 100644 sample/sample-keys/pkcs12.p12
>  create mode 100644 sample/sample-keys/server-ec.crt
>  create mode 100644 sample/sample-keys/server-ec.key
>
> diff --git a/sample/sample-config-files/client.conf
> b/sample/sample-config-files/client.conf
> index 58b2038..050ef60 100644
> --- a/sample/sample-config-files/client.conf
> +++ b/sample/sample-config-files/client.conf
> @@ -89,18 +89,19 @@ ca ca.crt
>  cert client.crt
>  key client.key
>
> -# Verify server certificate by checking
> -# that the certicate has the nsCertType
> -# field set to "server".  This is an
> -# important precaution to protect against
> +# Verify server certificate by checking that the
> +# certicate has the correct key usage set.
> +# This is an important precaution to protect against
>  # a potential attack discussed here:
>  #  http://openvpn.net/howto.html#mitm
>  #
>  # To use this feature, you will need to generate
> -# your server certificates with the nsCertType
> -# field set to "server".  The build-key-server
> -# script in the easy-rsa folder will do this.
> -ns-cert-type server
> +# your server certificates with the keyUsage set to
> +#   digitalSignature, keyEncipherment
> +# and the extendedKeyUsage to
> +#   serverAuth
> +# EasyRSA can do this for you.
> +remote-cert-tls server
>
>  # If a tls-auth key is used on the server
>  # then every client must also have the key.
> diff --git a/sample/sample-config-files/loopback-client
> b/sample/sample-config-files/loopback-client
> index d7f59e6..ebbd1cf 100644
> --- a/sample/sample-config-files/loopback-client
> +++ b/sample/sample-config-files/loopback-client
> @@ -17,9 +17,9 @@ dev null
>  verb 3
>  reneg-sec 10
>  tls-client
> +remote-cert-tls server
>  ca sample-keys/ca.crt
>  key sample-keys/client.key
>  cert sample-keys/client.crt
> -cipher DES-EDE3-CBC
>  ping 1
>  inactive 120 10000000
> diff --git a/sample/sample-config-files/loopback-server
> b/sample/sample-config-files/loopback-server
> index 9d21bce..8cb97be 100644
> --- a/sample/sample-config-files/loopback-server
> +++ b/sample/sample-config-files/loopback-server
> @@ -17,10 +17,9 @@ dev null
>  verb 3
>  reneg-sec 10
>  tls-server
> -dh sample-keys/dh1024.pem
> +dh sample-keys/dh2048.pem
>  ca sample-keys/ca.crt
>  key sample-keys/server.key
>  cert sample-keys/server.crt
> -cipher DES-EDE3-CBC
>  ping 1
>  inactive 120 10000000
> diff --git a/sample/sample-config-files/server.conf
> b/sample/sample-config-files/server.conf
> index 467d5b8..701be3c 100644
> --- a/sample/sample-config-files/server.conf
> +++ b/sample/sample-config-files/server.conf
> @@ -81,10 +81,8 @@ key server.key  # This file should be kept secret
>
>  # Diffie hellman parameters.
>  # Generate your own with:
> -#   openssl dhparam -out dh1024.pem 1024
> -# Substitute 2048 for 1024 if you are using
> -# 2048 bit keys.
> -dh dh1024.pem
> +#   openssl dhparam -out dh2048.pem 2048
> +dh dh2048.pem
>
>  # Network topology
>  # Should be subnet (addressing via IP)
> diff --git a/sample/sample-config-files/tls-office.conf
> b/sample/sample-config-files/tls-office.conf
> index f790f46..d196144 100644
> --- a/sample/sample-config-files/tls-office.conf
> +++ b/sample/sample-config-files/tls-office.conf
> @@ -26,7 +26,7 @@ up ./office.up
>  tls-server
>
>  # Diffie-Hellman Parameters (tls-server only)
> -dh dh1024.pem
> +dh dh2048.pem
>
>  # Certificate Authority file
>  ca my-ca.crt
> diff --git a/sample/sample-keys/.gitignore b/sample/sample-keys/.gitignore
> new file mode 100644
> index 0000000..f148752
> --- /dev/null
> +++ b/sample/sample-keys/.gitignore
> @@ -0,0 +1 @@
> +sample-ca/
> diff --git a/sample/sample-keys/README b/sample/sample-keys/README
> index 9f4f918..66dd945 100644
> --- a/sample/sample-keys/README
> +++ b/sample/sample-keys/README
> @@ -1,14 +1,19 @@
>  Sample RSA and EC keys.
>
> +Run ./gen-sample-keys.sh to generate fresh test keys.
> +
>  See the examples section of the man page for usage examples.
>
>  NOTE: THESE KEYS ARE FOR TESTING PURPOSES ONLY.
>        DON'T USE THEM FOR ANY REAL WORK BECAUSE
>        THEY ARE TOTALLY INSECURE!
>
> -ca.{crt,key}     -- sample CA key/cert
> -client.{crt,key} -- sample client key/cert
> -server.{crt,key} -- sample server key/cert (nsCertType=server)
> -pass.{crt,key}   -- sample client key/cert with password-encrypted key
> -                    password = "password"
> -ec-*.{crt,key}   -- sample elliptic curve variants of the above
> +ca.{crt,key}        -- sample CA key/cert
> +server.{crt,key}    -- sample server key/cert
> +client.{crt,key}    -- sample client key/cert
> +client-pass.key     -- sample client key with password-encrypted key
> +                       password = "password"
> +client.p12          -- sample client pkcs12 bundle
> +                       password = "password"
> +client-ec.{crt,key} -- sample elliptic curve client key/cert
> +server-ec.{crt,key} -- sample elliptic curve server key/cert
> diff --git a/sample/sample-keys/ca.crt b/sample/sample-keys/ca.crt
> index e063ccc..a11bafa 100644
> --- a/sample/sample-keys/ca.crt
> +++ b/sample/sample-keys/ca.crt
> @@ -1,19 +1,35 @@
>  -----BEGIN CERTIFICATE-----
> -MIIDBjCCAm+gAwIBAgIBADANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL
> +MIIGKDCCBBCgAwIBAgIJAKFO3vqQ8q6BMA0GCSqGSIb3DQEBCwUAMGYxCzAJBgNV
> +BAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMM
> +T3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4w
> +HhcNMTQxMDIyMjE1OTUyWhcNMjQxMDE5MjE1OTUyWjBmMQswCQYDVQQGEwJLRzEL
>  MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
> -VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy
> -NTE0NDA1NVoXDTE0MTEyMzE0NDA1NVowZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
> -Ak5BMRAwDgYDVQQHEwdCSVNIS0VLMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxITAf
> -BgkqhkiG9w0BCQEWEm1lQG15aG9zdC5teWRvbWFpbjCBnzANBgkqhkiG9w0BAQEF
> -AAOBjQAwgYkCgYEAqPjWJnesPu6bR/iec4FMz3opVaPdBHxg+ORKNmrnVZPh0t8/
> -ZT34KXkYoI9B82scurp8UlZVXG8JdUsz+yai8ti9+g7vcuyKUtcCIjn0HLgmdPu5
> -gFX25lB0pXw+XIU031dOfPvtROdG5YZN5yCErgCy7TE7zntLnkEDuRmyU6cCAwEA
> -AaOBwzCBwDAdBgNVHQ4EFgQUiaZg47rqPq/8ZH9MvYzSSI3gzEYwgZAGA1UdIwSB
> -iDCBhYAUiaZg47rqPq/8ZH9MvYzSSI3gzEahaqRoMGYxCzAJBgNVBAYTAktHMQsw
> -CQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMMT3BlblZQTi1U
> -RVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CAQAwDAYDVR0T
> -BAUwAwEB/zANBgkqhkiG9w0BAQQFAAOBgQBfJoiWYrYdjM0mKPEzUQk0nLYTovBP
> -I0es/2rfGrin1zbcFY+4dhVBd1E/StebnG+CP8r7QeEIwu7x8gYDdOLLsZn+2vBL
> -e4jNU1ClI6Q0L7jrzhhunQ5mAaZztVyYwFB15odYcdN2iO0tP7jtEsvrRqxICNy3
> -8itzViPTf5W4sA==
> +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMIICIjANBgkq
> +hkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAsJVPCqt3vtoDW2U0DII1QIh2Qs0dqh88
> +8nivxAIm2LTq93e9fJhsq3P/UVYAYSeCIrekXypR0EQgSgcNTvGBMe20BoHO5yvb
> +GjKPmjfLj6XRotCOGy8EDl/hLgRY9efiA8wsVfuvF2q/FblyJQPR/gPiDtTmUiqF
> +qXa7AJmMrqFsnWppOuGd7Qc6aTsae4TF1e/gUTCTraa7NeHowDaKhdyFmEEnCYR5
> +CeUsx2JlFWAH8PCrxBpHYbmGyvS0kH3+rQkaSM/Pzc2bS4ayHaOYRK5XsGq8XiNG
> +KTTLnSaCdPeHsI+3xMHmEh+u5Og2DFGgvyD22gde6W2ezvEKCUDrzR7bsnYqqyUy
> +n7LxnkPXGyvR52T06G8KzLKQRmDlPIXhzKMO07qkHmIonXTdF7YI1azwHpAtN4dS
> +rUe1bvjiTSoEsQPfOAyvD0RMK/CBfgEZUzAB50e/IlbZ84c0DJfUMOm4xCyft1HF
> +YpYeyCf5dxoIjweCPOoP426+aTXM7kqq0ieIr6YxnKV6OGGLKEY+VNZh1DS7enqV
> +HP5i8eimyuUYPoQhbK9xtDGMgghnc6Hn8BldPMcvz98HdTEH4rBfA3yNuCxLSNow
> +4jJuLjNXh2QeiUtWtkXja7ec+P7VqKTduJoRaX7cs+8E3ImigiRnvmK+npk7Nt1y
> +YE9hBRhSoLsCAwEAAaOB2DCB1TAdBgNVHQ4EFgQUK0DlyX319JY46S/jL9lAZMmO
> +BZswgZgGA1UdIwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRoMGYxCzAJ
> +BgNVBAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UE
> +ChMMT3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21h
> +aW6CCQChTt76kPKugTAMBgNVHRMEBTADAQH/MAsGA1UdDwQEAwIBBjANBgkqhkiG
> +9w0BAQsFAAOCAgEABc77f4C4P8fIS+V8qCJmVNSDU44UZBc+D+J6ZTgW8JeOHUIj
> +Bh++XDg3gwat7pIWQ8AU5R7h+fpBI9n3dadyIsMHGwSogHY9Gw7di2RVtSFajEth
> +rvrq0JbzpwoYedMh84sJ2qI/DGKW9/Is9+O52fR+3z3dY3gNRDPQ5675BQ5CQW9I
> +AJgLOqzD8Q0qrXYi7HaEqzNx6p7RDTuhFgvTd+vS5d5+28Z5fm2umnq+GKHF8W5P
> +ylp2Js119FTVO7brusAMKPe5emc7tC2ov8OFFemQvfHR41PLryap2VD81IOgmt/J
> +kX/j/y5KGux5HZ3lxXqdJbKcAq4NKYQT0mCkRD4l6szaCEJ+k0SiM9DdTcBDefhR
> +9q+pCOyMh7d8QjQ1075mF7T+PGkZQUW1DUjEfrZhICnKgq+iEoUmM0Ee5WtRqcnu
> +5BTGQ2mSfc6rV+Vr+eYXqcg7Nxb3vFXYSTod1UhefonVqwdmyJ2sC79zp36Tbo2+
> +65NW2WJK7KzPUyOJU0U9bcu0utvDOvGWmG+aHbymJgcoFzvZmlXqMXn97pSFn4jV
> +y3SLRgJXOw1QLXL2Y5abcuoBVr4gCOxxk2vBeVxOMRXNqSWZOFIF1bu/PxuDA+Sa
> +hEi44aHbPXt9opdssz/hdGfd8Wo7vEJrbg7c6zR6C/Akav1Rzy9oohIdgOw=
>  -----END CERTIFICATE-----
> diff --git a/sample/sample-keys/ca.key b/sample/sample-keys/ca.key
> index b4bf792..8b11bc2 100644
> --- a/sample/sample-keys/ca.key
> +++ b/sample/sample-keys/ca.key
> @@ -1,15 +1,52 @@
> ------BEGIN RSA PRIVATE KEY-----
> -MIICXQIBAAKBgQCo+NYmd6w+7ptH+J5zgUzPeilVo90EfGD45Eo2audVk+HS3z9l
> -PfgpeRigj0Hzaxy6unxSVlVcbwl1SzP7JqLy2L36Du9y7IpS1wIiOfQcuCZ0+7mA
> -VfbmUHSlfD5chTTfV058++1E50blhk3nIISuALLtMTvOe0ueQQO5GbJTpwIDAQAB
> -AoGAQuVREyWp4bhhbZr2UFBOco2ws6EOLWp4kdD/uI+WSoEjlHKiDJj+GJ1CrL5K
> -o+4yD5MpCQf4/4FOQ0ukprfjJpDwDinTG6vzuWSLTHNiTgvksW3vy7IsNMJx97hT
> -4D2QOOl9HhA50Qqg70teMPYXOgLRMVsdCIV7p7zDNy4nM+ECQQDX8m5ZcQmPtUDA
> -38dPTfpL4U7kMB94FItJYH/Lk5kMW1/J33xymNhL+BHaG064ol9n2ubGW4XEO5t2
> -qE1IOsVpAkEAyE/x/OBVSI1s75aYGlEwMd87p3qaDdtXT7WzujjRY7r8Y1ynkMU6
> -GtMeneBX/lk4BY/6I+5bhAzce+hqhaXejwJBAL5Wg+c4GApf41xdogqHm7doNyYw
> -OHyZ9w9NDDc+uGbI30xLPSCxEe0cEXgiG6foDpm2uzRZFTWaqHPU8pFYpAkCQGNX
> -cpWM0/7VVK9Fqk1y8knpgfY/UWOJ4jU/0dCLGR0ywLSuYNPlXDmtdkOp3TnhGW14
> -x/9F2NEWZ8pzq1B4wHUCQQC5ztD4m/rpiIpinoewUJODoeBJXYBKqx1+mdrALCq6
> -ESvK1WRiusMaY3xmsdv4J2TB5iUPryELbn3jU12WGcQc
> ------END RSA PRIVATE KEY-----
> +-----BEGIN PRIVATE KEY-----
> +MIIJQwIBADANBgkqhkiG9w0BAQEFAASCCS0wggkpAgEAAoICAQCwlU8Kq3e+2gNb
> +ZTQMgjVAiHZCzR2qHzzyeK/EAibYtOr3d718mGyrc/9RVgBhJ4Iit6RfKlHQRCBK
> +Bw1O8YEx7bQGgc7nK9saMo+aN8uPpdGi0I4bLwQOX+EuBFj15+IDzCxV+68Xar8V
> +uXIlA9H+A+IO1OZSKoWpdrsAmYyuoWydamk64Z3tBzppOxp7hMXV7+BRMJOtprs1
> +4ejANoqF3IWYQScJhHkJ5SzHYmUVYAfw8KvEGkdhuYbK9LSQff6tCRpIz8/NzZtL
> +hrIdo5hErlewarxeI0YpNMudJoJ094ewj7fEweYSH67k6DYMUaC/IPbaB17pbZ7O
> +8QoJQOvNHtuydiqrJTKfsvGeQ9cbK9HnZPTobwrMspBGYOU8heHMow7TuqQeYiid
> +dN0XtgjVrPAekC03h1KtR7Vu+OJNKgSxA984DK8PREwr8IF+ARlTMAHnR78iVtnz
> +hzQMl9Qw6bjELJ+3UcVilh7IJ/l3GgiPB4I86g/jbr5pNczuSqrSJ4ivpjGcpXo4
> +YYsoRj5U1mHUNLt6epUc/mLx6KbK5Rg+hCFsr3G0MYyCCGdzoefwGV08xy/P3wd1
> +MQfisF8DfI24LEtI2jDiMm4uM1eHZB6JS1a2ReNrt5z4/tWopN24mhFpftyz7wTc
> +iaKCJGe+Yr6emTs23XJgT2EFGFKguwIDAQABAoICAQCEYPqnihI0PqZjnwQdGIQp
> +g+P8gl7pyY9cS0OhUueicEbyDI8+V9qn0kcmx61zKDY0Jq4QNd6tnlUCijTc6Mot
> +DwF2G1xsC4GvKxZiy89MOkhloanXETEeQZzDbbjvaM4UgL0AHLWPfZQRCjxbKXkE
> +0A5phgvAr2YSvBLHCVXhGN0fScXnwXouVsvgVdGtpcTWdIUa+KrNdQBGDbz6VCkW
> +31I76SQFy40d8PPX6ZjUJHDvnM14LycySO6XOkofRIVnXTqaOUiVBb2VKj5fX+Ro
> +ILdWZz4d6J3RiGXYwyTr4SGVKLjgxWfgUGZB7x+NrqgugNzuaLYrkuWKSEN42nWq
> +yoP6x6xtbAsmB6Fvdqwm/d8BmLhUweaVc0L7AYzXNsOBuT3kubJHMmu3Jv4xgyWk
> +l/MAGJQc7i7QQweGgsYZgR8WlbkWkSFpUcgQBDzDibb6nsD2jnYijQrnrrmiEjEI
> +R7MO551V+nFw9utiM8U9WIWwqzY0d98ujWkGjVe7uz9ZBVyg0DEAEj/zRi9T54aG
> +1V6CB2Cjyw+HzzsDw7yWroWzo4U9YfjbPKCoBsXlqQFLFwY8oL6mEZ7UOobaV1Zl
> +WtuHyYw3UNFxuSGPPyxJkFePIQLLvfKvh2R+V0DrT3UJRoKKlt9RejRSN0tOh0Cm
> +2YD6d7T/DXnQHomIQKhKEQKCAQEA3sgsDg0eKDK8pUyVE+9wW5kql12nTzpBtnCM
> +eg5J9OJcXKhCD/NIyUTIMXoMvZQpLwGUAYLgu4gE04zKWHDouf7MRSFltD5LJ7F2
> +7nuYKHZXk0BhgMhdnQot3FKcOMrKCnZcM+RWX9ZJa8wO6whCaYCw7DtS0SSVODQk
> +9EwAgX6/Hq60V7ujPZJCyNd3o0bIdAA/0AQRTZUADP3AHgUzh71aysYJt+UKt1v0
> +Xc7l6hn7Dn7Ewzpf+WdZ2pV7d3JUSBVKiTDxLV904nDBNOxjMhz0rW01ojR6bzpn
> +XhkFPqnmh+yEYGRgfSAAzkvSsSJEAtBFSicupA/6n83Lo2YvswKCAQEAyumuxP4Z
> +a7s8x8DFba7vuQ+KVxpkKgEz1sxnGRNQJm18/ss/Y5JiaLFYT3E72VkQfBQ2ngu+
> +GrJL3OhiNhzy1KLGS6mrwULtKiuud5MMQDL0Pvkncr9NTy4rBnWzhp2XyPeETu8n
> +JpL2i2OK6lY/lgpBckXuap9gAl0fXk+y+BkZ71OoYaGnKpPjs+Xcq/qgPgZ7O3NW
> +1g+Bd2AVPSxQpXjuy5rgtQURCN733vkNBzFedKREx7Z6l8UPlK/Exuc7BMIHfn5V
> +dd0R3Th+82fkMNVJz6MKmHJ6CJI53M7co/YdAvIkxOFRIPGbO3arL2R69nRgAZBE
> +zLawx1JJTRIG2QKCAQATtZXgMFzopYR3A011FAvWrrhL5+czZS4HG/Hxom38kkIl
> +mGUv0BAybjlf1zJlW0RBelxDvfZv4Nq8dIo6RNLyEY601v2OcqxneJXTB3AwtDeP
> +OXTm1dMiX5IrGcvkYlx5jHsfxCW4GNcqCEWRmYt2lgIRBDaRdjEVZdeXHVo2GqaB
> +6mbeFCWe/t+VsSpOcaauTI9YseNt/66fd5uVjFRAwAnWQqr9b/AAxMvbuMAyc9X4
> +NFLoCrQO9ovGgM8JhD3cmrWbaY8MupM2rU8KhZdJCbLD3ROPpCDo0jvu4TvLjXBt
> +ugkEFh1LNJedqKudLDDkJtTaeJjxvtAnbyeC7zltAoIBAC9TIyzUqq8io0FfZ2x2
> +cXiy9CvuftABKcr+L0l85KOhw5ZVZvpdKNCMFDGrEi9WA28886QWzwbA8Mqb9FP0
> +mnoXYLJC50kSx+ee+nju9dt/RtHtIFM15N0DwosmJnHODZmUiOo0AuiPPCs0UzDm
> +Xrwqtirlvn5ln2nNuEQxyGbuy8qys0HaBvf6OBA8GySNNpRgxJsQAn+4bBSgdzOm
> +Q0TkmKUqASCXBusPvbXmVjCIRiRkL5p4p8z/6+tct0NAqNYqPr80zc/IeKMkyw8P
> ++vucszNXLmBxyp53JEGoiXNAMnH+ca7tchOB5hePTMun3rneWInk0PcB4OcL/QaZ
> +nrkCggEBAN67+SvcWtM1BoLXSz5/apFAE+DicCv94PrvMBOhfvu1oBrElR1rBjiN
> +2B83SktkF4WhCXr10GP+RUpjaqPBtT7NW4r3fL5B8EPsHeabL+pg9e6wG1rH8GqG
> +toWecmfC9uqK7l1A59h5Oveq5K19bZTRZRjQtv2e4KQknlJR6cwy+TGUU5kAUlMt
> +vcivyjzxc0UQwq7zKktJq+xW/TZiSLgd3B32p0sXX378qFUJ4SO2UZ1OCh8R7PY1
> +Fx25K/89Q1yGdbYiXb/Dx0a2WB9rP+b6alMl/dxPdqDKj2QXXkdh8+yvhVpQTyZw
> +B1RaqQXwzqrCH0F/vw3lRceYhcQvzcQ=
> +-----END PRIVATE KEY-----
> diff --git a/sample/sample-keys/client-ec.crt
> b/sample/sample-keys/client-ec.crt
> new file mode 100644
> index 0000000..edc6fe3
> --- /dev/null
> +++ b/sample/sample-keys/client-ec.crt
> @@ -0,0 +1,85 @@
> +Certificate:
> +    Data:
> +        Version: 3 (0x2)
> +        Serial Number: 4 (0x4)
> +    Signature Algorithm: sha256WithRSAEncryption
> +        Issuer: C=KG, ST=NA, L=BISHKEK,
> O=OpenVPN-TEST/emailAddress=me@...430...
> +        Validity
> +            Not Before: Oct 22 21:59:53 2014 GMT
> +            Not After : Oct 19 21:59:53 2024 GMT
> +        Subject: C=KG, ST=NA, O=OpenVPN-TEST,
> CN=Test-Client-EC/emailAddress=me@...430...
> +        Subject Public Key Info:
> +            Public Key Algorithm: id-ecPublicKey
> +                Public-Key: (256 bit)
> +                pub:
> +                    04:3b:ce:62:5d:6f:87:82:75:24:c2:58:f5:0e:88:
> +                    4d:57:0d:06:b2:71:88:87:58:19:bb:de:5f:7f:52:
> +                    62:51:a2:48:91:83:48:91:90:3e:87:02:0f:15:51:
> +                    f9:68:97:12:0a:fd:d2:3c:87:83:4b:65:54:00:44:
> +                    8d:28:76:49:05
> +                ASN1 OID: secp256k1
> +        X509v3 extensions:
> +            X509v3 Basic Constraints:
> +                CA:FALSE
> +            X509v3 Subject Key Identifier:
> +
> 64:F6:49:88:E7:74:C1:AB:A5:FA:4F:2B:71:3C:25:13:3D:C8:94:C5
> +            X509v3 Authority Key Identifier:
> +
> keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
> +
> DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
> +                serial:A1:4E:DE:FA:90:F2:AE:81
> +
> +    Signature Algorithm: sha256WithRSAEncryption
> +         32:3d:f0:08:67:dd:03:73:76:cc:76:52:0a:f6:97:d1:c6:fa:
> +         5f:d3:e6:28:c9:75:a7:08:a8:34:49:69:cf:eb:ab:da:86:b3:
> +         2e:65:17:ee:7e:b6:b5:6b:15:0b:dc:11:3a:b9:5a:b3:80:b8:
> +         bb:f4:6c:cf:88:3a:10:83:7e:10:a0:82:87:6e:06:ec:78:62:
> +         d4:d1:44:27:dd:2c:19:d8:1a:a1:ae:f4:a0:00:7f:53:5a:40:
> +         8a:c2:83:77:4b:26:7d:53:b0:d3:0f:2f:7c:28:70:ef:74:58:
> +         5b:de:81:94:4c:63:19:f0:79:cb:6c:b2:ec:32:1b:4b:e4:62:
> +         22:4f:ad:ac:4a:6f:a9:6e:c4:2a:8d:8a:88:19:09:fd:88:93:
> +         3c:27:4d:91:95:ff:57:84:13:fd:4a:68:db:20:df:10:e6:81:
> +         1d:fd:e7:1d:35:fb:19:02:dd:b5:5f:a0:c1:07:ec:74:b4:ef:
> +         8b:f9:33:9a:f2:a6:3b:6e:b6:4a:52:ab:5d:99:76:64:62:c4:
> +         d5:3a:c6:81:8d:eb:c8:4b:02:af:e1:ca:60:e9:8d:c7:a9:2b:
> +         ea:4f:56:31:d3:9a:11:c2:9c:83:5c:a2:8d:98:fe:cc:a5:ad:
> +         1f:51:c4:6e:cf:ff:a0:51:64:c8:7f:7f:32:05:4c:8d:7f:bf:
> +         b8:ed:e5:81:5f:81:bd:1d:9b:3f:8a:83:27:26:b4:69:84:8b:
> +         e5:d9:ea:fd:08:a8:aa:e4:3a:dc:29:4d:80:6c:13:f7:45:ce:
> +         92:f2:a9:f3:5f:90:83:d6:23:0f:50:e5:40:09:4c:6b:f2:73:
> +         aa:d8:49:a7:a9:81:6e:bb:f2:e4:a5:7f:19:39:1d:65:f3:11:
> +         97:b1:2b:7c:2f:36:77:7f:75:fd:88:44:90:7c:f2:33:8d:cd:
> +         2c:f6:76:60:33:d3:f4:b3:8c:81:d7:85:89:cc:d7:d5:2c:94:
> +         a9:31:3f:d3:63:a7:dc:82:3f:0a:d8:c5:71:97:69:3b:c1:69:
> +         cb:f0:1b:be:15:c0:be:aa:fd:e8:13:2c:0c:3f:72:7b:7d:9c:
> +         3b:7f:b8:82:36:4b:ad:4d:16:19:b9:1c:b3:2d:d7:5f:8b:f8:
> +         14:ce:d4:13:e5:82:7a:1d:40:28:08:65:4a:19:d7:7a:35:09:
> +         db:36:48:4b:96:44:bd:1f:12:b2:39:08:1e:5b:66:25:9b:e0:
> +         16:d3:79:05:e3:f6:90:da:95:95:33:a1:53:a8:3c:a9:f0:b2:
> +         f5:d0:aa:80:a0:96:ca:8c:45:62:c2:74:04:91:68:27:fb:e9:
> +         97:be:3a:87:8a:85:28:2d:6e:a9:60:9b:63:ba:65:98:5e:bb:
> +         02:ee:ac:ba:be:f6:42:26
> +-----BEGIN CERTIFICATE-----
> +MIIESTCCAjGgAwIBAgIBBDANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL
> +MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
> +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy
> +MjIxNTk1M1oXDTI0MTAxOTIxNTk1M1owbTELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
> +Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFzAVBgNVBAMTDlRlc3QtQ2xpZW50
> +LUVDMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wVjAQBgcqhkjO
> +PQIBBgUrgQQACgNCAAQ7zmJdb4eCdSTCWPUOiE1XDQaycYiHWBm73l9/UmJRokiR
> +g0iRkD6HAg8VUflolxIK/dI8h4NLZVQARI0odkkFo4HIMIHFMAkGA1UdEwQCMAAw
> +HQYDVR0OBBYEFGT2SYjndMGrpfpPK3E8JRM9yJTFMIGYBgNVHSMEgZAwgY2AFCtA
> +5cl99fSWOOkv4y/ZQGTJjgWboWqkaDBmMQswCQYDVQQGEwJLRzELMAkGA1UECBMC
> +TkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4tVEVTVDEhMB8G
> +CSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluggkAoU7e+pDyroEwDQYJKoZI
> +hvcNAQELBQADggIBADI98Ahn3QNzdsx2Ugr2l9HG+l/T5ijJdacIqDRJac/rq9qG
> +sy5lF+5+trVrFQvcETq5WrOAuLv0bM+IOhCDfhCggoduBux4YtTRRCfdLBnYGqGu
> +9KAAf1NaQIrCg3dLJn1TsNMPL3wocO90WFvegZRMYxnwectssuwyG0vkYiJPraxK
> +b6luxCqNiogZCf2IkzwnTZGV/1eEE/1KaNsg3xDmgR395x01+xkC3bVfoMEH7HS0
> +74v5M5rypjtutkpSq12ZdmRixNU6xoGN68hLAq/hymDpjcepK+pPVjHTmhHCnINc
> +oo2Y/sylrR9RxG7P/6BRZMh/fzIFTI1/v7jt5YFfgb0dmz+KgycmtGmEi+XZ6v0I
> +qKrkOtwpTYBsE/dFzpLyqfNfkIPWIw9Q5UAJTGvyc6rYSaepgW678uSlfxk5HWXz
> +EZexK3wvNnd/df2IRJB88jONzSz2dmAz0/SzjIHXhYnM19UslKkxP9Njp9yCPwrY
> +xXGXaTvBacvwG74VwL6q/egTLAw/cnt9nDt/uII2S61NFhm5HLMt11+L+BTO1BPl
> +gnodQCgIZUoZ13o1Cds2SEuWRL0fErI5CB5bZiWb4BbTeQXj9pDalZUzoVOoPKnw
> +svXQqoCglsqMRWLCdASRaCf76Ze+OoeKhSgtbqlgm2O6ZZheuwLurLq+9kIm
> +-----END CERTIFICATE-----
> diff --git a/sample/sample-keys/client-ec.key
> b/sample/sample-keys/client-ec.key
> new file mode 100644
> index 0000000..8131380
> --- /dev/null
> +++ b/sample/sample-keys/client-ec.key
> @@ -0,0 +1,5 @@
> +-----BEGIN PRIVATE KEY-----
> +MIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQg2RVk/d0yok086M9bLPIi
> +eu4DfcBUwphOnkje1/7VSY+hRANCAAQ7zmJdb4eCdSTCWPUOiE1XDQaycYiHWBm7
> +3l9/UmJRokiRg0iRkD6HAg8VUflolxIK/dI8h4NLZVQARI0odkkF
> +-----END PRIVATE KEY-----
> diff --git a/sample/sample-keys/client-pass.key
> b/sample/sample-keys/client-pass.key
> new file mode 100644
> index 0000000..2bb8d4e
> --- /dev/null
> +++ b/sample/sample-keys/client-pass.key
> @@ -0,0 +1,30 @@
> +-----BEGIN RSA PRIVATE KEY-----
> +Proc-Type: 4,ENCRYPTED
> +DEK-Info: AES-256-CBC,ECC1F209896FC2621233FFF6F1FFD045
> +
> +i6t7VKTyNNELTvrBO464e02nFg9rvYwumxd0sfqcPtaKmRK2mrZmEd/Xh0Nv1WyB
> +PyuJo78qQixAtxObRbkSNINzTr5C8IDrE6+wQYCJinvO54U0o+ksv0tsyLngz1cb
> +is8ZqHXrRgJ3qGFQWmFRtFKFQvSXOTDX3fLkEB53HfeblQCxBCnJ82Sp7ivnVR/j
> +Q8qQRy1RMbzIN0trEGf0Zi4tHEvXL1u7Y+olQzSlmWWaQt20hhXUOMLhMtlRsAo7
> +AwjlE94JjAfJ1q1dwIcRN4c9Lk8GkiX6w7nDpRACDpk2S8ifCqi69eGe4+g7owhL
> +74bgs64PmM9a2sNXy1v6WE3c/t6sSrZiMvrGsqMo4sBlrQ9WXe0Naon7heBkPcdS
> +px0YJjnyBXHMIH+ASmALSJ5JXq9vt2xRFf0dOsGapxhP+7bZJ5Pwyk/yUu5uHFbM
> +/aBemlrZJzlKeYiiwpwx2whQAtDwN41zMG+r27EzSU/AaDV40NPiwwycpWt/Bp1e
> +z1ag0JuS0an+PK4jmREtzT5U5BeAVM91x8YttOPpmUIpahAa1zwdYPRAIkbmPJ4z
> +ZH+9YoPH4hoBQKdIhshYktjdI++xNiKXAUGUz5YoX8S68SsLdmKvhnQ7fu5VvOkA
> +2pb7taXGy7zfn+a/fWauhuceV9HPlAXMIu3GsssODoNly3vpcFeiMySKppygJ3Eg
> +A3o9n8UepD+jXflKG/R/t7U3hT6LqSIvQWqBqYMEVFMCNzSsJ/ce/4veFvx343zT
> +qdxuzYqyiXM74cynpfqHdVa9SFICTesNdVDI0FdOXhSQ4bHJc7Xp9FFJdS0lMRw4
> +ACwKxvs8lo4Gx1WFyCqH5OxosKtDHQYzdUJfSWVJlhhOFR3GncR9qSe3O5fkhJfs
> +TALnC+xTJyCkSB2k0/bxVLIhlkPdCwzsrN/B6X2CDBdg0mQIo0LaPzGF8VneM20d
> +XebYn751XSiL3HKyq8G5AEFwj9AO3Q8gKuP2fPoWdngJ2GT+mt1m2fIw9Igu39J0
> +ZMegyUN0wSIiA5AkgryK9U+PJEiJmLzOJ/NGr7E5tPF18eZWapK4KZ8TXC4RNiye
> +g+apGa+xZJz2VQp/Mrcdj9D4UDJFQjrvKaS0PXJDoYUXFBoMv3rxijzRVxlhhuJY
> +yZ0At+UqZD5wpuWW6DRrgJIpy0HNhbaLmgsU0Co0HKviB0x8hvMJbi/uCoPTOdPz
> +sPB7CN2i3oXe7xw1HfSTSFWb4leqjlKwNgfV42ox0QUjkkADeeuY+56g/B2+QmdE
> +vXrc6sDwfNUwRUzeMn8yfum/aW1y/wrqF/qPTBQqFd85vlzS+NfXIKDg04cAljTu
> ++2BLzvizh9Bb68iG4PykNXbjbAir1EbQG1tCzq1eKhERjgrxdv6+XqAmvchMCeL5
> +L6hvfQFBPCo/4xnMpU5wooFarO/kGdKlGr5rXOydgfL618Td18BIX+FHQFb3zzVU
> +y2NR4++DslJAZgAU+512zzpW1m3JtaRoyqyoLE2YFPlW804Xc1PBB3Ix6Wyzcegy
> +D4qMk5qxjBkXEsBBSCYfVbWoMBeMhnvxkz0b9wkPtAW/jEJCB2Kkn/5yMC0DkePO
> +-----END RSA PRIVATE KEY-----
> diff --git a/sample/sample-keys/client.crt b/sample/sample-keys/client.crt
> index c047446..1744cb2 100644
> --- a/sample/sample-keys/client.crt
> +++ b/sample/sample-keys/client.crt
> @@ -2,64 +2,102 @@ Certificate:
>      Data:
>          Version: 3 (0x2)
>          Serial Number: 2 (0x2)
> -        Signature Algorithm: md5WithRSAEncryption
> +    Signature Algorithm: sha256WithRSAEncryption
>          Issuer: C=KG, ST=NA, L=BISHKEK,
> O=OpenVPN-TEST/emailAddress=me@...430...
>          Validity
> -            Not Before: Nov 25 14:46:49 2004 GMT
> -            Not After : Nov 23 14:46:49 2014 GMT
> +            Not Before: Oct 22 21:59:53 2014 GMT
> +            Not After : Oct 19 21:59:53 2024 GMT
>          Subject: C=KG, ST=NA, O=OpenVPN-TEST,
> CN=Test-Client/emailAddress=me@...430...
>          Subject Public Key Info:
>              Public Key Algorithm: rsaEncryption
> -            RSA Public Key: (1024 bit)
> -                Modulus (1024 bit):
> -                    00:d2:12:5c:c6:4d:13:34:ae:cf:fa:ab:fe:cb:de:
> -                    8c:f1:4b:4a:95:28:60:87:82:2c:b8:c1:e5:8e:c6:
> -                    5d:11:58:61:a4:a5:f1:42:d7:86:74:6c:9d:9c:7a:
> -                    f0:3a:5c:29:e6:53:3b:5e:6d:d8:f0:45:06:2c:23:
> -                    ee:09:bc:02:8f:0e:b8:d5:33:1f:c3:4a:11:02:48:
> -                    0b:cc:4b:ad:6e:74:e0:a2:53:b1:d6:cc:89:b9:e2:
> -                    6f:db:15:b3:19:1e:57:04:79:48:3a:da:76:31:fc:
> -                    bf:d3:34:21:e7:32:d8:9e:06:4e:be:f3:e3:79:b0:
> -                    54:fd:d1:42:32:aa:3e:7a:c1
> +                Public-Key: (2048 bit)
> +                Modulus:
> +                    00:ec:65:8f:e9:12:c2:1a:5b:e6:56:2a:08:a9:82:
> +                    3a:2d:44:78:a3:00:3b:b0:9f:e7:27:10:40:93:ef:
> +                    f1:cc:3e:a0:aa:04:a2:80:1b:13:a9:e6:fe:81:d6:
> +                    70:90:a8:d8:d4:de:30:d8:35:00:d2:be:62:f0:48:
> +                    da:fc:15:8d:c4:c6:6d:0b:99:f1:2b:83:00:0a:d3:
> +                    2a:23:0b:e5:cd:f9:35:df:43:61:15:72:ad:95:98:
> +                    f6:73:21:41:5e:a0:dd:47:27:a0:d5:9a:d4:41:a8:
> +                    1c:1d:57:20:71:17:8f:f7:28:9e:3e:07:ce:ec:d5:
> +                    0e:42:4f:1e:74:47:8e:47:9d:d2:14:28:27:2c:14:
> +                    10:f5:d1:96:b5:93:74:84:ef:f9:04:de:8d:4a:6f:
> +                    df:77:ab:ea:d1:58:d3:44:fe:5a:04:01:ff:06:7a:
> +                    97:f7:fd:e3:57:48:e1:f0:df:40:13:9f:66:23:5a:
> +                    e3:55:54:3d:54:39:ee:00:f9:12:f1:d2:df:74:2e:
> +                    ba:d7:f0:8d:c6:dd:18:58:1c:93:22:0b:75:fa:a8:
> +                    d6:e0:b5:2f:2d:b9:d4:fe:b9:4f:86:e2:75:48:16:
> +                    60:fb:3f:c9:b4:30:42:29:fb:3b:b3:2b:b9:59:81:
> +                    6a:46:f3:45:83:bf:fd:d5:1a:ff:37:0c:6f:5b:fd:
> +                    61:f1
>                  Exponent: 65537 (0x10001)
>          X509v3 extensions:
>              X509v3 Basic Constraints:
>                  CA:FALSE
> -            Netscape Comment:
> -                OpenSSL Generated Certificate
>              X509v3 Subject Key Identifier:
> -
> 17:B7:3F:C7:62:A0:A9:FD:A4:31:0E:58:D7:D9:94:7B:4B:3F:CB:56
> +
> D2:B4:36:0F:B1:FC:DD:A5:EA:2A:F7:C7:23:89:FA:E3:FA:7A:44:1D
>              X509v3 Authority Key Identifier:
> -
> keyid:89:A6:60:E3:BA:EA:3E:AF:FC:64:7F:4C:BD:8C:D2:48:8D:E0:CC:46
> +
> keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
>
>  DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
> -                serial:00
> +                serial:A1:4E:DE:FA:90:F2:AE:81
>
> -    Signature Algorithm: md5WithRSAEncryption
> -        61:c6:d1:fa:24:0f:c7:be:09:3b:d8:04:17:63:31:17:07:f9:
> -        56:99:af:4c:67:fa:db:cb:94:cf:55:a5:7b:16:20:8b:42:64:
> -        13:23:62:45:28:93:5e:36:f7:db:02:95:a1:e9:fd:e3:0f:8d:
> -        73:a1:7b:0e:55:78:4d:a5:c4:b7:22:12:a0:ee:55:e0:b8:0e:
> -        c9:9b:12:e3:b0:ef:9b:68:93:57:6e:6c:ad:16:68:8e:8d:30:
> -        33:fe:2a:1b:c3:03:8f:b6:0a:2d:0c:b1:3c:bb:f9:58:3f:8c:
> -        81:59:6b:14:dd:62:b5:c2:93:ed:5d:c6:19:0f:9b:4b:52:b3:
> -        7c:78
> +    Signature Algorithm: sha256WithRSAEncryption
> +         7f:e0:fe:84:a7:ec:df:62:a5:cd:3c:c1:e6:42:b1:31:12:f0:
> +         b9:da:a7:9e:3f:bd:96:52:b6:fc:55:74:64:3e:e4:ff:7e:aa:
> +         f7:3e:06:18:5f:73:85:f8:c8:e0:67:1b:4d:97:ca:05:d0:37:
> +         07:33:64:9b:e6:78:77:14:9a:55:bb:2a:ac:c3:7f:c9:15:08:
> +         83:5c:c8:c2:61:d3:71:4c:05:0b:2b:cb:a3:87:6d:a0:32:ed:
> +         b0:b3:27:97:4a:55:8d:01:2a:30:56:68:ab:f2:da:5c:10:73:
> +         c9:aa:0a:9c:4b:4c:a0:5b:51:6e:0a:7e:6c:53:80:b0:00:e1:
> +         1e:9a:4c:0a:37:9e:20:89:bc:c5:e5:79:58:b7:45:ff:d3:c4:
> +         a1:fd:d9:78:3d:45:16:74:df:82:44:1d:1d:81:50:5a:b9:32:
> +         4c:e2:4f:3f:0e:3a:65:5a:64:83:3b:29:31:c4:99:88:bc:c5:
> +         84:39:f2:19:12:e1:66:d0:ea:fb:75:b1:d2:27:be:91:59:a3:
> +         2b:09:d5:5c:bf:46:8e:d6:67:d6:0b:ec:da:ab:f0:80:19:87:
> +         64:07:a9:77:b1:5e:0c:e2:c5:1d:6a:ac:5d:23:f3:30:75:36:
> +         4e:ca:c3:4e:b0:4d:8c:2c:ce:52:61:63:de:d5:f5:ef:ef:0a:
> +         6b:23:25:26:3c:3a:f2:c3:c2:16:19:3f:a9:32:ba:68:f9:c9:
> +         12:3c:3e:c6:1f:ff:9b:4e:f4:90:b0:63:f5:d1:33:00:30:5a:
> +         e8:24:fa:35:44:9b:6a:80:f3:a6:cc:7b:3c:73:5f:50:c4:30:
> +         71:d8:74:90:27:0a:01:4e:a5:5e:b1:f8:da:c2:61:81:11:ae:
> +         29:a3:8f:fa:7e:4c:4e:62:b1:00:de:92:e3:8f:6a:2e:da:d9:
> +         38:5d:6b:7c:0d:e4:01:aa:c8:c6:6d:8b:cd:c0:c8:6e:e4:57:
> +         21:8a:f6:46:30:d9:ad:51:a1:87:96:a6:53:c9:1e:c6:bb:c3:
> +         eb:55:fe:8c:d6:5c:d5:c6:f3:ca:b0:60:d2:d4:2a:1f:88:94:
> +         d3:4c:1a:da:0c:94:fe:c1:5d:0d:2a:db:99:29:5d:f6:dd:16:
> +         c4:c8:4d:74:9e:80:d9:d0:aa:ed:7b:e3:30:e4:47:d8:f5:15:
> +         c1:71:b8:c6:fd:ee:fc:9e:b2:5f:b5:b7:92:ed:ff:ca:37:f6:
> +         c7:82:b4:54:13:9b:83:cd:87:8b:7e:64:f6:2e:54:3a:22:b1:
> +         c5:c1:f4:a5:25:53:9a:4d:a8:0f:e7:35:4b:89:df:19:83:66:
> +         64:d9:db:d1:61:2b:24:1b:1d:44:44:fb:49:30:87:b7:49:23:
> +         08:02:8a:e0:25:f3:f4:43
>  -----BEGIN CERTIFICATE-----
> -MIIDNTCCAp6gAwIBAgIBAjANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL
> +MIIFFDCCAvygAwIBAgIBAjANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL
>  MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
> -VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy
> -NTE0NDY0OVoXDTE0MTEyMzE0NDY0OVowajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
> +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy
> +MjIxNTk1M1oXDTI0MTAxOTIxNTk1M1owajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
>  Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFDASBgNVBAMTC1Rlc3QtQ2xpZW50
> -MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wgZ8wDQYJKoZIhvcN
> -AQEBBQADgY0AMIGJAoGBANISXMZNEzSuz/qr/svejPFLSpUoYIeCLLjB5Y7GXRFY
> -YaSl8ULXhnRsnZx68DpcKeZTO15t2PBFBiwj7gm8Ao8OuNUzH8NKEQJIC8xLrW50
> -4KJTsdbMibnib9sVsxkeVwR5SDradjH8v9M0Iecy2J4GTr7z43mwVP3RQjKqPnrB
> -AgMBAAGjge4wgeswCQYDVR0TBAIwADAsBglghkgBhvhCAQ0EHxYdT3BlblNTTCBH
> -ZW5lcmF0ZWQgQ2VydGlmaWNhdGUwHQYDVR0OBBYEFBe3P8dioKn9pDEOWNfZlHtL
> -P8tWMIGQBgNVHSMEgYgwgYWAFImmYOO66j6v/GR/TL2M0kiN4MxGoWqkaDBmMQsw
> -CQYDVQQGEwJLRzELMAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNV
> -BAoTDE9wZW5WUE4tVEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9t
> -YWluggEAMA0GCSqGSIb3DQEBBAUAA4GBAGHG0fokD8e+CTvYBBdjMRcH+VaZr0xn
> -+tvLlM9VpXsWIItCZBMjYkUok14299sClaHp/eMPjXOhew5VeE2lxLciEqDuVeC4
> -DsmbEuOw75tok1dubK0WaI6NMDP+KhvDA4+2Ci0MsTy7+Vg/jIFZaxTdYrXCk+1d
> -xhkPm0tSs3x4
> +MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wggEiMA0GCSqGSIb3
> +DQEBAQUAA4IBDwAwggEKAoIBAQDsZY/pEsIaW+ZWKgipgjotRHijADuwn+cnEECT
> +7/HMPqCqBKKAGxOp5v6B1nCQqNjU3jDYNQDSvmLwSNr8FY3Exm0LmfErgwAK0yoj
> +C+XN+TXfQ2EVcq2VmPZzIUFeoN1HJ6DVmtRBqBwdVyBxF4/3KJ4+B87s1Q5CTx50
> +R45HndIUKCcsFBD10Za1k3SE7/kE3o1Kb993q+rRWNNE/loEAf8Gepf3/eNXSOHw
> +30ATn2YjWuNVVD1UOe4A+RLx0t90LrrX8I3G3RhYHJMiC3X6qNbgtS8tudT+uU+G
> +4nVIFmD7P8m0MEIp+zuzK7lZgWpG80WDv/3VGv83DG9b/WHxAgMBAAGjgcgwgcUw
> +CQYDVR0TBAIwADAdBgNVHQ4EFgQU0rQ2D7H83aXqKvfHI4n64/p6RB0wgZgGA1Ud
> +IwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRoMGYxCzAJBgNVBAYTAktH
> +MQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMMT3BlblZQ
> +Ti1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CCQChTt76
> +kPKugTANBgkqhkiG9w0BAQsFAAOCAgEAf+D+hKfs32KlzTzB5kKxMRLwudqnnj+9
> +llK2/FV0ZD7k/36q9z4GGF9zhfjI4GcbTZfKBdA3BzNkm+Z4dxSaVbsqrMN/yRUI
> +g1zIwmHTcUwFCyvLo4dtoDLtsLMnl0pVjQEqMFZoq/LaXBBzyaoKnEtMoFtRbgp+
> +bFOAsADhHppMCjeeIIm8xeV5WLdF/9PEof3ZeD1FFnTfgkQdHYFQWrkyTOJPPw46
> +ZVpkgzspMcSZiLzFhDnyGRLhZtDq+3Wx0ie+kVmjKwnVXL9GjtZn1gvs2qvwgBmH
> +ZAepd7FeDOLFHWqsXSPzMHU2TsrDTrBNjCzOUmFj3tX17+8KayMlJjw68sPCFhk/
> +qTK6aPnJEjw+xh//m070kLBj9dEzADBa6CT6NUSbaoDzpsx7PHNfUMQwcdh0kCcK
> +AU6lXrH42sJhgRGuKaOP+n5MTmKxAN6S449qLtrZOF1rfA3kAarIxm2LzcDIbuRX
> +IYr2RjDZrVGhh5amU8kexrvD61X+jNZc1cbzyrBg0tQqH4iU00wa2gyU/sFdDSrb
> +mSld9t0WxMhNdJ6A2dCq7XvjMORH2PUVwXG4xv3u/J6yX7W3ku3/yjf2x4K0VBOb
> +g82Hi35k9i5UOiKxxcH0pSVTmk2oD+c1S4nfGYNmZNnb0WErJBsdRET7STCHt0kj
> +CAKK4CXz9EM=
>  -----END CERTIFICATE-----
> diff --git a/sample/sample-keys/client.key b/sample/sample-keys/client.key
> index 17b9509..6d31489 100644
> --- a/sample/sample-keys/client.key
> +++ b/sample/sample-keys/client.key
> @@ -1,15 +1,28 @@
> ------BEGIN RSA PRIVATE KEY-----
> -MIICXAIBAAKBgQDSElzGTRM0rs/6q/7L3ozxS0qVKGCHgiy4weWOxl0RWGGkpfFC
> -14Z0bJ2cevA6XCnmUztebdjwRQYsI+4JvAKPDrjVMx/DShECSAvMS61udOCiU7HW
> -zIm54m/bFbMZHlcEeUg62nYx/L/TNCHnMtieBk6+8+N5sFT90UIyqj56wQIDAQAB
> -AoGBAK8RoIGekCfym99DYYfTg9A/t/tQeAnWYaDj7oSrKbqf1lgZ91OGPEZgkoVr
> -KzLnxf9uU+bhUs8CJx+4HdO8/L9rAJA+oD9QNuMp0elN4AKuEGE1Eq3a0e3cmgPI
> -+VIoXM6WVAGgK9I03Zu/UerYQ/DdXWGOIsKhFe8qyQoG9pKxAkEA9ld6O9MHQt3d
> -JAjJkgCNn4psozxjrfLWy2huXd3H3CRqGMjLITDGzdkVSgXjHokBYroi0+TZTu4M
> -ulJSJaWwBQJBANpO2DAexH2zRHw5Z6QyeEVxz7B3/FzU4GgJx9BH+FSBh+F0G5Ln
> -ir5Vst8vZ/LGcgpYjHQLNAvZVgUjiQ4Y6I0CQGvwMJL+CHR4GmmroAblTyjU0n1D
> -/Lk/anZ+L73Za7U+D28ErFzCrpmLwRRKOBYtGfpUbOZDpCQ9kj4hy/TLALECQCcL
> -9ysUNbzt9Y/qjJkX1d9F7gn4TBEmmkTBixW76bTjvjQbGlt6Qpyso2O8DPGlgPxM
> -vkJ7RoHgC7y7kGYPGnkCQBVxSNGIjLx4NQBgN4HD0y4+fars1PTUGnckBcS4npb9
> -onLNyerBlWdBwbARyBS7WPIbyyf5VCrn3yIqWxaARO0=
> ------END RSA PRIVATE KEY-----
> +-----BEGIN PRIVATE KEY-----
> +MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDsZY/pEsIaW+ZW
> +KgipgjotRHijADuwn+cnEECT7/HMPqCqBKKAGxOp5v6B1nCQqNjU3jDYNQDSvmLw
> +SNr8FY3Exm0LmfErgwAK0yojC+XN+TXfQ2EVcq2VmPZzIUFeoN1HJ6DVmtRBqBwd
> +VyBxF4/3KJ4+B87s1Q5CTx50R45HndIUKCcsFBD10Za1k3SE7/kE3o1Kb993q+rR
> +WNNE/loEAf8Gepf3/eNXSOHw30ATn2YjWuNVVD1UOe4A+RLx0t90LrrX8I3G3RhY
> +HJMiC3X6qNbgtS8tudT+uU+G4nVIFmD7P8m0MEIp+zuzK7lZgWpG80WDv/3VGv83
> +DG9b/WHxAgMBAAECggEBAIOdaCpUD02trOh8LqZxowJhBOl7z7/ex0uweMPk67LT
> +i5AdVHwOlzwZJ8oSIknoOBEMRBWcLQEojt1JMuL2/R95emzjIKshHHzqZKNulFvB
> +TIUpdnwChTKtH0mqUkLlPU3Ienty4IpNlpmfUKimfbkWHERdBJBHbtDsTABhdo3X
> +9pCF/yRKqJS2Fy/Mkl3gv1y/NB1OL4Jhl7vQbf+kmgfQN2qdOVe2BOKQ8NlPUDmE
> +/1XNIDaE3s6uvUaoFfwowzsCCwN2/8QrRMMKkjvV+lEVtNmQdYxj5Xj5IwS0vkK0
> +6icsngW87cpZxxc1zsRWcSTloy5ohub4FgKhlolmigECgYEA+cBlxzLvaMzMlBQY
> +kCac9KQMvVL+DIFHlZA5i5L/9pRVp4JJwj3GUoehFJoFhsxnKr8HZyLwBKlCmUVm
> +VxnshRWiAU18emUmeAtSGawlAS3QXhikVZDdd/L20YusLT+DXV81wlKR97/r9+17
> +klQOLkSdPm9wcMDOWMNHX8bUg8kCgYEA8k+hQv6+TR/+Beao2IIctFtw/EauaJiJ
> +wW5ql1cpCLPMAOQUvjs0Km3zqctfBF8mUjdkcyJ4uhL9FZtfywY22EtRIXOJ/8VR
> +we65mVo6RLR8YVM54sihanuFOnlyF9LIBWB+9pUfh1/Y7DSebh7W73uxhAxQhi3Y
> +QwfIQIFd8OkCgYBalH4VXhLYhpaYCiXSej6ot6rrK2N6c5Tb2MAWMA1nh+r84tMP
> +gMoh+pDgYPAqMI4mQbxUmqZEeoLuBe6VHpDav7rPECRaW781AJ4ZM4cEQ3Jz/inz
> +4qOAMn10CF081/Ez9ykPPlU0bsYNWHNd4eB2xWnmUBKOwk7UgJatVPaUiQKBgQCI
> +f18CVGpzG9CHFnaK8FCnMNOm6VIaTcNcGY0mD81nv5Dt943P054BQMsAHTY7SjZW
> +HioRyZtkhonXAB2oSqnekh7zzxgv4sG5k3ct8evdBCcE1FNJc2eqikZ0uDETRoOy
> +s7cRxNNr+QxDkyikM+80HOPU1PMPgwfOSrX90GJQ8QKBgEBKohGMV/sNa4t14Iau
> +qO8aagoqh/68K9GFXljsl3/iCSa964HIEREtW09Qz1w3dotEgp2w8bsDa+OwWrLy
> +0SY7T5jRViM3cDWRlUBLrGGiL0FiwsfqiRiji60y19erJgrgyGVIb1kIgIBRkgFM
> +2MMweASzTmZcri4PA/5C0HYb
> +-----END PRIVATE KEY-----
> diff --git a/sample/sample-keys/client.p12 b/sample/sample-keys/client.p12
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..8458c79770a08e832e10205ae1c43e8059cca082
> GIT binary patch
> literal 4533
> zcmV;m5lZebf)TL-0Ru3C5qAa&Duzgg_YDCD0ic2rXas^0WH5peU@(FV7X}F`hDe6@
> z4FLxRpn?ntFoFyO0s#Opf(!iy2`Yw2hW8Bt2LUh~1_~;MNQU<f0So~KFb)I=o?0Gd
> zI2*;=0s;sCfPxFqP42^P0Fo+4$NqJRddSJSl#H$YLRhM0*>KZ1!3FrYzVTx;+~<9X
> zHC&0kC=Q)Zxu{oL`xLM;b_oD>(X&8Ta-#O3&p;;Aa3+^0d5fSLOs3>{(_@...1940...
> z2?mB_IU!{$1Sf&CfNA0|znHybfRqP5blsg?Z{1w#hHzm2WPm@...1941...>~Fs9L`8P!8d0*
> zf18!wochm&3uJ;eC{gw3d+=?v`?TP`azbPA8uS#SvF>zu7QrQ#$t<4KatJksK>dI*
> ziMISYR+%EK<vdQWAH_>GJw7P#F#ep~$fBbb6Y*_W)JH+UB%-XoF0lb%KM36b^Ml3z
> zdI#>W)o{)xhylZ4OHKChQ3@...1942...{v(AQB@...1943...?ARCe`Ss=S%-q5T5+I3#R#G1YJlYRV
> zDTZ`@`U38{@bSL;>xUioK!F94XIBfJNFiIhM&9nvb{1l0O6GqR&cLY4NFEuZS(DxH
> z=W!uJ(?gK8gs^*{5_cl5Z(=wW&Q)XqS-~>m0O$kp(m_Cz>zwzHL-IYyDH=}xGVl+4
> zq3STnMt<?Hu(MKc@...150...}O=+SOgwb9ciM@...1944...>7Am$3#DF7{7%Lk3imYa+y7?D;AsNHiG
> zn<Pk<=8L8O8bLSWTRMYjAr147E?9!=!8xCjW&Rt}P1G4yKA2el8%Z#!i?O-I%bY3u
> ze}EeqFzNG`%%2`feCA2|669L4WH3axOzLsnR{2`^v?3Sf>YdO(f@...1615...<&g*jh|95N+F
> zs_~5PPb?@91h)&uXAR5t`>ZG>Uz4i)rF)c|;osz49745f=)!}UDtm5M!ZPf8NHf-q
> zBu9VT(aN+vpUdkJ*gO8FPMV2QD1&zIpdi0sGch)W2;I$z%}w_LA6?gziR|D2-^A$7
> zK+7hz{knM@...1945...{VXU4Jr29-tm$-2M^>mnD_r5Lj>iwRX!<9CFRg
> z9{(YStoDvOuR@(O4i9CiwMU(U-1=C!cAqZ-t@...1946...)@bc}
> zgo@...1947...=MyVE1)F@...1948...()zN_MxMHwJS(AR3ip3I+3Rm(|=OM&()I982?Ca-YME*$jcai
> z5>TYla+%{gDkflN^F;$b#Qn!EsPXE?fs@...1644...=Sd<B``<<chZC5b5VFKbh2K6kY7?K3;
> zv5_F`(^P~!G1NikPncT9r#;SmMJ@...1949...%Prj#Uc{m7xeQANV0K8+ojXQSMT1t*R&uV`S
> z-a_ZWh-DQno_e$da>VMjI=w_}8&SK!u012g>$5F;owS>RW$?|5{~rl&$f}d%d>$9i
> z7(P0*PhMARQef&fdz)sTC<Lxa5`F2&hqQLcJp#ikxf;udtXqUu6cOT-BO(BK`7h=?
> zDbI?zgxg*~0$om9lkR)a-7%wHj&G~`U*39UJOt~jxs$VpQaqb)Y!11<7NJ;nxwK+f
> zimu>$;%$WGWRFUiOQ+WO;A%{B*ZINIEs08%b-Fb1;6M5Z<_`ge4ELfx*V8?Qo?OBP
> zB<m3&JH7$rGqlacJDUb4J^aF+$1F5Fq1BEWLf~B?AU5ccNREIEhWWFpY~t?SmGZi!
> z+_Bv45Wnp@^L9d#ov%dRyPva3GUZyOBKdi&t0zyQ-jp*M&n!<8>?YAsG0gnH9<Z0S
> z34D1$5L-hatRI$@6j43xOX~=Ue!pzJ_)e*2;oPP-Jt%B~H*490;ChZmyCq4v3R}?{
> zc%U{&f8?Nh&k>6b5g@>h2#}&DOvoiL8%)<~q7ehzHh_`~a2Izn=bjHq;TkMIoDt-)
> z$u8yg;zHv$;?HL0J6h2aH`EK>az+?|SAZS7*?6)?BsZ8yxec)dO^fx~b|xRBKv@!>
> zN|H@...1594...@OZPg_<ybv-HNQS5$N@=J{hvL<!M_~BR7$uR)1P?SUJk^fttz^d1%ND_VN$$
> z28yu4B=;NI-W7y*sy2dS6^$EJ{)yWxMf7wfvI_wsZ89XZlK~8n%r4)^eonEw2DGo~
> zjKS~WOnU}9sPh2P#+I2oX4TWo2NAs$hrb8{T^kZeI@...1611...}Jtc8o?@wh2ORT%pAFfSL4
> zF1~~3hhzo^be)F{>Xe6%y9Pyj1HI_jCpGGJ+r}qJ(Qm^(w#q#n4;fGT9J)MId6%;&
> zhPes$n_zQIQ!}^}4G`^Wz7CGC@!ARFDKj^9@...1950...!~Q664CYzu=8Ev-yow*fp9UOsLHG
> z-BX<D-hZ6KxIA%F5~CWcz|%QmBCt0vMQK#PYY9XsaJ3(}e;=lyMTDz8NEu@...1951...
> zBTx_4BwT-RH%(I350dV3ea|XNP6YEOFyDzqfWrv_j6~`PF4!_puV5C_RkWVl#=LzN
> zCn~sV+ht*A?D_2ZTy;=F_fv8<_4f`NjG$iQJ`jYg1O#mw4EYb0Mh#@$sjRlQkKJQo
> zCbD(tZmv8Qv$&NNhSgU}$`rTnqcvf`wxr^&C&;Fp=5Yh`(eE{7KCj6?xingFo(wqh
> zsvrza+Q>cmrr~=}pV<`ImbU@...1952...;g_=@a)XeuKL1x92`ruL2r&K(ct*Kk@...1953...
> zG_=`43h3M^{O*UA{yi2s5fjtWXMOov>#rUwy(A49RjMsrwLLq>wy(A6bJnieJpm*K
> zLL!(_!FKzh-$!YZdEcBK1F(>@we-M9%w^x#=H#}9Lc8NQ<BjftBjnh4ar}b3i+vXc
> z{W>X2580FRsm3z}$v|1;BqjKiO00Ft{;FSiOWy|y=&D|>#PfODLKzOym9LWY;M#(=
> z`T4NzCiGy4Je$gf+HwRg2c<5NBvatkd<oeEbqXy8^TV#bM^e&RCYW(w9gO&yYjX5?
> z%nQKFIXw{H7UJzU>mb+(-NL)S<-&!Jq+i>}L3McC!=`WXZgNw}W3)t-k4o9(UzHmA
> zq`4KU&&3!B$jn*}C9IgPAZDOKa4d3Z!m^><O=W&A+i>_uvW(Gg?u{!Zc28~KnlZY|
> zW><Tb!KwKt8QoTnbcG?7D028`)ggh1eeM8r@...1954...%|k0fBmAmT5c(1mQ9lEXQ5OXd?;
> z^CHjw%k!RCxFaT~aUa_d{oq#QOssTE3<rMFyeZ`^PjPynYR_KVSN@...1955...#b>Ouf
> zWGfR@...1956...$;AzQkfiya1EQ_>+Bl-?jKt}^_7hPmkxyS@...1957...~^h=708E3`{=Wth%v-
> z?@iOBIjVj4-#bcG%9d)#)>ITY*E8dBUmpjRV)C+>Jt32pJ`o-1#>e3Um|*mUJl)zl
> zzj+A{saen+`EP}bD_BH@...1958...(cb-`Ha9p{rll@#k}4#rAwI;U5&{_(dvPfry4r*OR(g
> zir1=%D70<3l-Vmdno7L-k9AWle8;LS6163q{gLq<MLcS_5kCD+V@...1959...)Z4K_T+}0D
> z^did?rKv`zAu@...1960...}c$!y9^Lh|+tz8}+Z%B~F4O}J=a=6}v>ZK?WsvR6Z`rzHr@<!Tg
> zr!DhMH=-r9Uq71K!AtPC3zo{oX3n#EYevQcL9~(v;6h5Pq%J*^gs-6!fq3Gog$<8b
> z9g5=S4zlZ?y%K!>Mc&6F6kj#?qqpe;SHD(h=!j(z@^CR=i=KDGw>Bgokqi9zPX(uX
> z|8`K|fAgElC|rkyhB5@...1961...+@}LZAfPl$+hDkByi%)V5=IaI1H{6vl7?ZBye!AqHLicO
> zaCsg%BIm|>MA3R@|GjKRc3d&Xa4bb>L3UelPWRoILk&ICGoo4lwV@...1962...{{fLLaZL&+
> znSPhW04KckjD)a}19>2aT|WH_ltW=y7#46Gu!-xzwtb6TmG$I_MlQkGWG4!7F2!_C
> z^ngv5DN5VpziF0tnU2m8BpCW*8j$_TsVU%Wf(C_FTqJpP%DVRx*1n=yY6jVZP^~&u
> zj+O<-)gVFOKz}2cqLfZKD1W%|44A(?o?C-zVkbOT+V1eU!Th4e58g?qy0IDLgSs@(
> z>a3QZ_~$!6a_yYA03n@...1963...;&JCvDXIMz74j$40}k$6D5*AIe~-NPq>l=p{+`{qB*E
> z)dA_uyb!%xms+1|*hgXfvXAI&FoFd^1_>&LNQU<f0S5t~f(0@...1964...(0%xf(0rtf(0f9
> z3o3?4hW8Bt3<?1Ppn?SMFoFc?FdPO7Duzgg_YDCI0Ru1&1PH71K9D&o|1tss2ml0v
> z1jw3_VuA6wE@...1965...*qp8m7%=>t!ahU6DY<c$m^W{&SL-}Av-!V6Mej({Vh^I65-r7>jl
> zj#2E$@cqS#ot;itB65=}T$c#Fvn6>(Hu7jv5#?nqND^i{<zGDn+bGDInORh%$|<TU
> z)0ArgXLA;(_k}K_mlCfE0Y&Ec4gxI|biRQj4^q@...1966...>4Z%>zfnT?a?P>WmWgPqNu
> zt;=6U3*t>n)oqy#bC<px2zJip8afy*7*z$B{ma3e57nY2u4{E__iFC0=vmJwi1VYX
> zJ^u9%A=Rjf0y-*9fV{WtT;tb1T0|T~;c%SH5qJ2+_GKkn#{LX}MbS`UJ+#@hq#_P@
> z=VN$u@...1967...|?(z7UQ*UT5!yd!df-`=;Pg3G;+}!@XBTK@(XtDanPon_36N?ceJ<?w0
> zNK3soS#I5O8%nUS5XWVt%LptQsfi0a{wtPGi{fq;)jwb;5tx!nQZ5RBwItDChWNTA
> zj>Fo89J#H&5w(j6)Gb05d4Wuav-;Ae*N4CvCH7Bf7qsT7$-eiNbQFjxma-5lFy&Kf
> zuGdIbq=SxP#B5y9i$6kWIXa%j=^H(Q8<<q_M*`R%ZVP8(B}EBCF@...1968...?w
> z@...1969...$yFWg(e-HC0;102vJ;ImFQO7@...1970...<i79$sGU(S!1~*(w+q4OwO-ox
> zWwM2kH5?dxWXufo3Q9ZIy_U`Ql+5rjkKA=C7U__H<)N5z$Rb{}rn?dsvsv@...1971...=<
> zU%-OKA3|-2osy2Vwh#)*s+9to<L%b6U5k5Fzx|JW;HHBRq|s|t(&(g4xMFzgvvtbc
> zQ-TBf=dLqXp>pKX1|T1Ncg_%F+OOU1K%=lJvk25edtPll^?C8iOY4l+gHVw-jwS{5
> zc1H%A0AcxAK4?I%10%GT9KyndW;=S4Hs$Bt3ppdV?5;*?C+IU>_jrB|%iA@^j-Ydr
> zP#Vq!z4lf1B59em!RbNV^|P^F7)gXU({v-B^T{ObdazrO(+w5OWS;WuWNRLYYIn{T
> z*P_`Mm4F+5C)d0&C_P&q3l;Vwjmo9lrsR8}rTM}q1!7wAp-KZ++#udhr|@C8HVGgC
> z^(J(<tv$K47<r2(#bphive7uMRA&}ky@...1972...~lV4``Zu%!1BUIf_Z=)*`CBf-+5F
> zTyVg}@k=0bc9s}%M9iRHnOdEO4AU3z0GZg~26X=;y_v(F&Px}&8ufGahoEQe_>Wa-
> zy{M9YD^`ZYTH01LwfQ?{ZuZQ~vaO&Jq$O&~PN%MO(9m%~EMFTMC(A&MRujojT{YuB
> z`u5e(@~<aXbTu5Xpgn-u0;$_2;&dZV4?%UszI6qIM+zSz->|Ph<<tw;;-I!bhQUfx
> z-T|#dTHlxbD@...1554...~1qB#O+9=PN}23-_|*ehcIXa5a)>w_vbRv_LVvmsQhWA5OYqtUvR
> zb2`hE@>8knqkGmwqPuasz=MUx2NN7PM|$lkN60Vj_=3UYPS<Wb*D(aS{nk}POUoch
> z5<OVHe&P<YCYq5dQgsKygF+90>r6ZIGje(Qd3rIw(m)l~LebaOD9`;d#2Rt>_%?X|
> z;FA9GDiVuwAnk9Bh!BAEfMz{Mdq$b`Xzrmam}W60Fe3&DDuzgg_YDCF6)_eB6jtCP
> zdB1(YHnjhMGVV2R_)j7)j4&}UAutIB1uG5%0vZJX1Qaaz-GykChO4Gdh~Eic3wrIs
> TMJxme++Sbdrv3y90s;sCVF#Wx
>
> literal 0
> HcmV?d00001
>
> diff --git a/sample/sample-keys/dh1024.pem b/sample/sample-keys/dh1024.pem
> deleted file mode 100644
> index 7ce05f0..0000000
> --- a/sample/sample-keys/dh1024.pem
> +++ /dev/null
> @@ -1,5 +0,0 @@
> ------BEGIN DH PARAMETERS-----
> -MIGHAoGBAJ419DBEOgmQTzo5qXl5fQcN9TN455wkOL7052HzxxRVMyhYmwQcgJvh
> -1sa18fyfR9OiVEMYglOpkqVoGLN7qd5aQNNi5W7/C+VBdHTBJcGZJyyP5B3qcz32
> -9mLJKudlVudV0Qxk5qUJaPZ/xupz0NyoVpviuiBOI1gNi8ovSXWzAgEC
> ------END DH PARAMETERS-----
> diff --git a/sample/sample-keys/dh2048.pem b/sample/sample-keys/dh2048.pem
> new file mode 100644
> index 0000000..8eda59a
> --- /dev/null
> +++ b/sample/sample-keys/dh2048.pem
> @@ -0,0 +1,8 @@
> +-----BEGIN DH PARAMETERS-----
> +MIIBCAKCAQEArdnA32xujHPlPI+jPffHSoMUZ+b5gRz1H1Lw9//Gugm5TAsRiYrB
> +t2BDSsMKvAjyqN+i5SJv4TOk98kRRKB27iPvyXmiL945VaDQl/UehCySjYlGFUjW
> +9nuo+JwQxeSbw0TLiSYoYJZQ8X1CxPl9mgJl277O4cW1Gc8I/bWa+ipU/4K5wv3h
> +GI8nt+6A0jN3M/KebotMP101G4k0l0qsY4oRMTmP+z3oAP0qU9NZ1jiuMFVzRlNp
> +5FdYF7ctrH+tBF+QmyT4SRKSED4wE4oX6gp420NaBhIEQifIj75wlMDtxQlpkN+x
> +QkjsEbPlaPKHGQ4uupssChVUi8IM2yq5EwIBAg==
> +-----END DH PARAMETERS-----
> diff --git a/sample/sample-keys/ec-ca.crt b/sample/sample-keys/ec-ca.crt
> deleted file mode 100644
> index e190801..0000000
> --- a/sample/sample-keys/ec-ca.crt
> +++ /dev/null
> @@ -1,13 +0,0 @@
> ------BEGIN CERTIFICATE-----
> -MIIB4jCCAWmgAwIBAgIJALGEGB2g6cAXMAoGCCqGSM49BAMCMBUxEzARBgNVBAMT
> -CkVDLVRlc3QgQ0EwHhcNMTQwMTE4MTYwMTUzWhcNMjQwMTE2MTYwMTUzWjAVMRMw
> -EQYDVQQDEwpFQy1UZXN0IENBMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAE2S4AZT7j
> -ZlPG/CXpT12CzCNSySyKmJt+fWyW/wzbRulVJpGHXRHpZZj2VNOUE72kqGUeshh6
> -Um1o7lHGDSAkHOJpeW5FtryiKhwFc+4dsOCLTNLVFXQsEtY3gY14Uquio4GEMIGB
> -MB0GA1UdDgQWBBS0mkFcuCZ8SLWZRAD/8LpBQcgGPDBFBgNVHSMEPjA8gBS0mkFc
> -uCZ8SLWZRAD/8LpBQcgGPKEZpBcwFTETMBEGA1UEAxMKRUMtVGVzdCBDQYIJALGE
> -GB2g6cAXMAwGA1UdEwQFMAMBAf8wCwYDVR0PBAQDAgEGMAoGCCqGSM49BAMCA2cA
> -MGQCMHWlVTi0xNZstR8ZNH+7z0WlyIXyZe23ne3EXkO0thZLdv86kpxFMPW/llB+
> -RMRKuQIweN97n7FQy5DTenr91U98KDFJ5Av4mDFRL1mkXiu3W1//4XD8yEYDQTRz
> -/GARuOLL
> ------END CERTIFICATE-----
> diff --git a/sample/sample-keys/ec-ca.key b/sample/sample-keys/ec-ca.key
> deleted file mode 100644
> index 51a72e1..0000000
> --- a/sample/sample-keys/ec-ca.key
> +++ /dev/null
> @@ -1,6 +0,0 @@
> ------BEGIN PRIVATE KEY-----
> -MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDASU6X/mh2m2PayviL3
> -teoml5soyIUcZfwZpVn6oNtnrLcAbIRsAJbM4xyGVp77G/6hZANiAATZLgBlPuNm
> -U8b8JelPXYLMI1LJLIqYm359bJb/DNtG6VUmkYddEellmPZU05QTvaSoZR6yGHpS
> -bWjuUcYNICQc4ml5bkW2vKIqHAVz7h2w4ItM0tUVdCwS1jeBjXhSq6I=
> ------END PRIVATE KEY-----
> diff --git a/sample/sample-keys/ec-client.crt
> b/sample/sample-keys/ec-client.crt
> deleted file mode 100644
> index b797b02..0000000
> --- a/sample/sample-keys/ec-client.crt
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -Certificate:
> -    Data:
> -        Version: 3 (0x2)
> -        Serial Number: 2 (0x2)
> -    Signature Algorithm: ecdsa-with-SHA256
> -        Issuer: CN=EC-Test CA
> -        Validity
> -            Not Before: Jan 18 16:02:37 2014 GMT
> -            Not After : Jan 16 16:02:37 2024 GMT
> -        Subject: CN=ec-client
> -        Subject Public Key Info:
> -            Public Key Algorithm: id-ecPublicKey
> -                Public-Key: (384 bit)
> -                pub:
> -                    04:40:d9:b9:a2:44:1b:01:39:2c:14:ee:aa:70:6b:
> -                    31:98:28:44:c9:61:bc:b7:0b:b5:53:49:c2:c0:0a:
> -                    43:b0:08:50:cd:80:2f:5d:a4:89:f1:ff:7d:11:78:
> -                    f5:0c:b2:86:e2:59:f8:17:76:1b:22:f2:23:67:e7:
> -                    55:90:ea:ce:0a:aa:da:05:f4:85:19:c9:ed:ae:6d:
> -                    a3:ad:56:7a:f6:33:c6:cf:bb:c7:39:fa:e4:d3:67:
> -                    df:f0:b8:4a:88:57:98
> -                ASN1 OID: secp384r1
> -        X509v3 extensions:
> -            X509v3 Basic Constraints:
> -                CA:FALSE
> -            X509v3 Subject Key Identifier:
> -
> D8:E2:35:7B:CA:66:71:6B:D8:5B:F5:12:13:82:2D:ED:CD:E5:ED:7F
> -            X509v3 Authority Key Identifier:
> -
> keyid:B4:9A:41:5C:B8:26:7C:48:B5:99:44:00:FF:F0:BA:41:41:C8:06:3C
> -                DirName:/CN=EC-Test CA
> -                serial:B1:84:18:1D:A0:E9:C0:17
> -
> -            X509v3 Extended Key Usage:
> -                TLS Web Client Authentication
> -            X509v3 Key Usage:
> -                Digital Signature
> -            Netscape Comment:
> -                Easy-RSA Generated Certificate
> -            Netscape Cert Type:
> -                SSL Client
> -    Signature Algorithm: ecdsa-with-SHA256
> -         30:64:02:30:41:8b:1a:fd:97:a8:bb:7c:d0:eb:1c:a2:ba:c0:
> -         ac:2f:6d:80:07:5b:5c:ef:55:59:1a:92:56:66:94:ce:49:6a:
> -         a9:57:49:b2:41:73:64:7e:01:ac:31:3a:7c:2a:bf:a5:02:30:
> -         2b:c4:a6:b1:0c:03:82:e3:e4:03:39:fb:19:d7:76:21:1b:7e:
> -         7f:aa:22:5d:90:a4:e1:2e:cd:ca:92:0f:b6:3f:80:dc:26:d2:
> -         09:34:8c:d1:61:bb:9d:ac:6d:8f:68:f0
> ------BEGIN CERTIFICATE-----
> -MIICLTCCAbSgAwIBAgIBAjAKBggqhkjOPQQDAjAVMRMwEQYDVQQDEwpFQy1UZXN0
> -IENBMB4XDTE0MDExODE2MDIzN1oXDTI0MDExNjE2MDIzN1owFDESMBAGA1UEAxMJ
> -ZWMtY2xpZW50MHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEQNm5okQbATksFO6qcGsx
> -mChEyWG8twu1U0nCwApDsAhQzYAvXaSJ8f99EXj1DLKG4ln4F3YbIvIjZ+dVkOrO
> -CqraBfSFGcntrm2jrVZ69jPGz7vHOfrk02ff8LhKiFeYo4HYMIHVMAkGA1UdEwQC
> -MAAwHQYDVR0OBBYEFNjiNXvKZnFr2Fv1EhOCLe3N5e1/MEUGA1UdIwQ+MDyAFLSa
> -QVy4JnxItZlEAP/wukFByAY8oRmkFzAVMRMwEQYDVQQDEwpFQy1UZXN0IENBggkA
> -sYQYHaDpwBcwEwYDVR0lBAwwCgYIKwYBBQUHAwIwCwYDVR0PBAQDAgeAMC0GCWCG
> -SAGG+EIBDQQgFh5FYXN5LVJTQSBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwEQYJYIZI
> -AYb4QgEBBAQDAgeAMAoGCCqGSM49BAMCA2cAMGQCMEGLGv2XqLt80OscorrArC9t
> -gAdbXO9VWRqSVmaUzklqqVdJskFzZH4BrDE6fCq/pQIwK8SmsQwDguPkAzn7Gdd2
> -IRt+f6oiXZCk4S7NypIPtj+A3CbSCTSM0WG7naxtj2jw
> ------END CERTIFICATE-----
> diff --git a/sample/sample-keys/ec-client.key
> b/sample/sample-keys/ec-client.key
> deleted file mode 100644
> index 60636ed..0000000
> --- a/sample/sample-keys/ec-client.key
> +++ /dev/null
> @@ -1,6 +0,0 @@
> ------BEGIN PRIVATE KEY-----
> -MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDD9Agj8nr/8sIr0XHky
> -mcn1oMb3vqOh2axFBaIvmOHYmqs11SIH1tKYelkNYy9zHTChZANiAARA2bmiRBsB
> -OSwU7qpwazGYKETJYby3C7VTScLACkOwCFDNgC9dpInx/30RePUMsobiWfgXdhsi
> -8iNn51WQ6s4KqtoF9IUZye2ubaOtVnr2M8bPu8c5+uTTZ9/wuEqIV5g=
> ------END PRIVATE KEY-----
> diff --git a/sample/sample-keys/ec-server.crt
> b/sample/sample-keys/ec-server.crt
> deleted file mode 100644
> index 9999472..0000000
> --- a/sample/sample-keys/ec-server.crt
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -Certificate:
> -    Data:
> -        Version: 3 (0x2)
> -        Serial Number: 1 (0x1)
> -    Signature Algorithm: ecdsa-with-SHA256
> -        Issuer: CN=EC-Test CA
> -        Validity
> -            Not Before: Jan 18 16:02:31 2014 GMT
> -            Not After : Jan 16 16:02:31 2024 GMT
> -        Subject: CN=ec-server
> -        Subject Public Key Info:
> -            Public Key Algorithm: id-ecPublicKey
> -                Public-Key: (384 bit)
> -                pub:
> -                    04:bd:8c:3a:af:2e:2f:2e:de:cf:d2:39:8d:b9:a6:
> -                    13:96:80:6d:b5:b2:ee:97:62:3b:a2:32:38:77:1e:
> -                    fb:2a:ef:86:4b:d0:9e:4b:55:e0:9b:07:f9:64:2f:
> -                    6b:a7:17:fd:65:dd:50:3f:1c:fa:fa:2f:39:2e:97:
> -                    d4:86:e5:4e:5a:d2:50:0b:f4:d7:08:62:67:53:44:
> -                    62:e3:25:f2:fa:36:84:87:1d:03:e3:e9:9d:d9:66:
> -                    51:dd:b4:c4:db:0b:05
> -                ASN1 OID: secp384r1
> -        X509v3 extensions:
> -            X509v3 Basic Constraints:
> -                CA:FALSE
> -            X509v3 Subject Key Identifier:
> -
> EA:DF:7E:A3:D4:61:73:D7:01:AF:6E:0A:38:8D:33:D0:BD:24:4B:E1
> -            X509v3 Authority Key Identifier:
> -
> keyid:B4:9A:41:5C:B8:26:7C:48:B5:99:44:00:FF:F0:BA:41:41:C8:06:3C
> -                DirName:/CN=EC-Test CA
> -                serial:B1:84:18:1D:A0:E9:C0:17
> -
> -            X509v3 Extended Key Usage:
> -                TLS Web Server Authentication
> -            X509v3 Key Usage:
> -                Digital Signature, Key Encipherment
> -            Netscape Comment:
> -                Easy-RSA Generated Certificate
> -            Netscape Cert Type:
> -                SSL Server
> -    Signature Algorithm: ecdsa-with-SHA256
> -         30:64:02:30:20:39:12:92:cc:a2:ca:45:b9:1a:8f:e0:c1:e7:
> -         b7:4a:79:4d:07:07:81:72:08:b4:d4:7b:46:53:d7:72:32:d0:
> -         d7:3e:e8:88:2b:c9:ba:8b:d5:94:4f:41:6c:d0:2e:a4:02:30:
> -         75:ff:c3:8a:c1:f5:79:1c:1a:08:16:31:c2:c1:6e:d4:33:dc:
> -         9f:04:0f:90:94:d9:75:c1:6d:71:28:62:cc:f6:89:7c:91:86:
> -         a4:96:45:34:a0:8d:92:7e:dd:e3:da:4d
> ------BEGIN CERTIFICATE-----
> -MIICLTCCAbSgAwIBAgIBATAKBggqhkjOPQQDAjAVMRMwEQYDVQQDEwpFQy1UZXN0
> -IENBMB4XDTE0MDExODE2MDIzMVoXDTI0MDExNjE2MDIzMVowFDESMBAGA1UEAxMJ
> -ZWMtc2VydmVyMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEvYw6ry4vLt7P0jmNuaYT
> -loBttbLul2I7ojI4dx77Ku+GS9CeS1Xgmwf5ZC9rpxf9Zd1QPxz6+i85LpfUhuVO
> -WtJQC/TXCGJnU0Ri4yXy+jaEhx0D4+md2WZR3bTE2wsFo4HYMIHVMAkGA1UdEwQC
> -MAAwHQYDVR0OBBYEFOrffqPUYXPXAa9uCjiNM9C9JEvhMEUGA1UdIwQ+MDyAFLSa
> -QVy4JnxItZlEAP/wukFByAY8oRmkFzAVMRMwEQYDVQQDEwpFQy1UZXN0IENBggkA
> -sYQYHaDpwBcwEwYDVR0lBAwwCgYIKwYBBQUHAwEwCwYDVR0PBAQDAgWgMC0GCWCG
> -SAGG+EIBDQQgFh5FYXN5LVJTQSBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwEQYJYIZI
> -AYb4QgEBBAQDAgZAMAoGCCqGSM49BAMCA2cAMGQCMCA5EpLMospFuRqP4MHnt0p5
> -TQcHgXIItNR7RlPXcjLQ1z7oiCvJuovVlE9BbNAupAIwdf/DisH1eRwaCBYxwsFu
> -1DPcnwQPkJTZdcFtcShizPaJfJGGpJZFNKCNkn7d49pN
> ------END CERTIFICATE-----
> diff --git a/sample/sample-keys/ec-server.key
> b/sample/sample-keys/ec-server.key
> deleted file mode 100644
> index bb3cdf1..0000000
> --- a/sample/sample-keys/ec-server.key
> +++ /dev/null
> @@ -1,6 +0,0 @@
> ------BEGIN PRIVATE KEY-----
> -MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDD8bQlwrFrXHPmem0bt
> -cBcU6nYfaZQbPdIDAB7edOOyevvzYH0qMtbaW95iSZLMRVWhZANiAAS9jDqvLi8u
> -3s/SOY25phOWgG21su6XYjuiMjh3Hvsq74ZL0J5LVeCbB/lkL2unF/1l3VA/HPr6
> -Lzkul9SG5U5a0lAL9NcIYmdTRGLjJfL6NoSHHQPj6Z3ZZlHdtMTbCwU=
> ------END PRIVATE KEY-----
> diff --git a/sample/sample-keys/gen-sample-keys.sh
> b/sample/sample-keys/gen-sample-keys.sh
> new file mode 100755
> index 0000000..87bde1d
> --- /dev/null
> +++ b/sample/sample-keys/gen-sample-keys.sh
> @@ -0,0 +1,74 @@
> +#!/bin/sh
> +#
> +# Run this script to set up a test CA, and test key-certificate pair for a
> +# server, and various clients.
> +#
> +# Copyright (C) 2014 Steffan Karger <steffan@...1856...>
> +set -eu
> +
> +if [ ! -f openssl.cnf ]
> +then
> +    echo "Please run this script from the sample directory"
> +    exit 1
> +fi
> +
> +# Create required directories and files
> +mkdir -p sample-ca
> +rm -f sample-ca/index.txt
> +touch sample-ca/index.txt
> +echo "01" > sample-ca/serial
> +
> +# Generate CA key and cert
> +openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 \
> +    -extensions easyrsa_ca -keyout sample-ca/ca.key -out sample-ca/ca.crt
> \
> +    -subj
> "/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430..." \
> +    -config openssl.cnf
> +
> +# Create server key and cert
> +openssl req -new -nodes -config openssl.cnf -extensions server \
> +    -keyout sample-ca/server.key -out sample-ca/server.csr \
> +    -subj
> "/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Server/emailAddress=me@...430...
> "
> +openssl ca -batch -config openssl.cnf -extensions server \
> +    -out sample-ca/server.crt -in sample-ca/server.csr
> +
> +# Create client key and cert
> +openssl req -new -nodes -config openssl.cnf \
> +    -keyout sample-ca/client.key -out sample-ca/client.csr \
> +    -subj
> "/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Client/emailAddress=me@...430...
> "
> +openssl ca -batch -config openssl.cnf \
> +    -out sample-ca/client.crt -in sample-ca/client.csr
> +
> +# Create password protected key file
> +openssl rsa -aes256 -passout pass:password \
> +    -in sample-ca/client.key -out sample-ca/client-pass.key
> +
> +# Create pkcs#12 client bundle
> +openssl pkcs12 -export -nodes -password pass:password \
> +    -out sample-ca/client.p12 -inkey sample-ca/client.key \
> +    -in sample-ca/client.crt -certfile sample-ca/ca.crt
> +
> +
> +# Create EC server and client cert (signed by 'regular' RSA CA)
> +openssl ecparam -out sample-ca/secp256k1.pem -name secp256k1
> +
> +openssl req -new -newkey ec:sample-ca/secp256k1.pem -nodes -config
> openssl.cnf \
> +    -extensions server \
> +    -keyout sample-ca/server-ec.key -out sample-ca/server-ec.csr \
> +    -subj
> "/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Server-EC/emailAddress=me@...430...
> "
> +openssl ca -batch -config openssl.cnf -extensions server \
> +    -out sample-ca/server-ec.crt -in sample-ca/server-ec.csr
> +
> +openssl req -new -newkey ec:sample-ca/secp256k1.pem -nodes -config
> openssl.cnf \
> +    -keyout sample-ca/client-ec.key -out sample-ca/client-ec.csr \
> +    -subj
> "/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Client-EC/emailAddress=me@...430...
> "
> +openssl ca -batch -config openssl.cnf \
> +    -out sample-ca/client-ec.crt -in sample-ca/client-ec.csr
> +
> +# Generate DH parameters
> +openssl dhparam -out dh2048.pem 2048
> +
> +# Copy keys and certs to working directory
> +cp sample-ca/*.key .
> +cp sample-ca/*.crt .
> +cp sample-ca/*.p12 .
> +
> diff --git a/sample/sample-keys/openssl.cnf
> b/sample/sample-keys/openssl.cnf
> new file mode 100644
> index 0000000..aabfd48
> --- /dev/null
> +++ b/sample/sample-keys/openssl.cnf
> @@ -0,0 +1,139 @@
> +# Heavily borrowed from EasyRSA 3, for use with OpenSSL 1.0.*
> +
> +####################################################################
> +[ ca ]
> +default_ca     = CA_default            # The default ca section
> +
> +####################################################################
> +[ CA_default ]
> +
> +dir            = sample-ca             # Where everything is kept
> +certs          = $dir                  # Where the issued certs are kept
> +crl_dir                = $dir                  # Where the issued crl are
> kept
> +database       = $dir/index.txt        # database index file.
> +new_certs_dir  = $dir                  # default place for new certs.
> +
> +certificate    = $dir/ca.crt           # The CA certificate
> +serial         = $dir/serial           # The current serial number
> +crl            = $dir/crl.pem          # The current CRL
> +private_key    = $dir/ca.key           # The private key
> +RANDFILE       = $dir/.rand            # private random number file
> +
> +x509_extensions        = basic_exts            # The extentions to add to
> the cert
> +
> +# This allows a V2 CRL. Ancient browsers don't like it, but anything
> Easy-RSA
> +# is designed for will. In return, we get the Issuer attached to CRLs.
> +crl_extensions = crl_ext
> +
> +default_days   = 3650                  # how long to certify for
> +default_crl_days= 30                   # how long before next CRL
> +default_md     = sha256                # use public key default MD
> +preserve       = no                    # keep passed DN ordering
> +
> +# A few difference way of specifying how similar the request should look
> +# For type CA, the listed attributes must be the same, and the optional
> +# and supplied fields are just that :-)
> +policy         = policy_anything
> +
> +# For the 'anything' policy, which defines allowed DN fields
> +[ policy_anything ]
> +countryName            = optional
> +stateOrProvinceName    = optional
> +localityName           = optional
> +organizationName       = optional
> +organizationalUnitName = optional
> +commonName             = supplied
> +name                   = optional
> +emailAddress           = optional
> +
> +####################################################################
> +# Easy-RSA request handling
> +# We key off $DN_MODE to determine how to format the DN
> +[ req ]
> +default_bits           = 2048
> +default_keyfile                = privkey.pem
> +default_md             = sha256
> +distinguished_name     = cn_only
> +x509_extensions                = easyrsa_ca    # The extentions to add to
> the self signed cert
> +
> +# A placeholder to handle the $EXTRA_EXTS feature:
> +#%EXTRA_EXTS%  # Do NOT remove or change this line as $EXTRA_EXTS support
> requires it
> +
> +####################################################################
> +# Easy-RSA DN (Subject) handling
> +
> +# Easy-RSA DN for cn_only support:
> +[ cn_only ]
> +commonName             = Common Name (eg: your user, host, or server name)
> +commonName_max         = 64
> +commonName_default     = changeme
> +
> +# Easy-RSA DN for org support:
> +[ org ]
> +countryName                    = Country Name (2 letter code)
> +countryName_default            = KG
> +countryName_min                        = 2
> +countryName_max                        = 2
> +
> +stateOrProvinceName            = State or Province Name (full name)
> +stateOrProvinceName_default    = NA
> +
> +localityName                   = Locality Name (eg, city)
> +localityName_default           = BISHKEK
> +
> +0.organizationName             = Organization Name (eg, company)
> +0.organizationName_default     = OpenVPN-TEST
> +
> +organizationalUnitName         = Organizational Unit Name (eg, section)
> +organizationalUnitName_default =
> +
> +commonName                     = Common Name (eg: your user, host, or
> server name)
> +commonName_max                 = 64
> +commonName_default             =
> +
> +emailAddress                   = Email Address
> +emailAddress_default           = me@...430...
> +emailAddress_max               = 64
> +
> +####################################################################
> +
> +[ basic_exts ]
> +basicConstraints       = CA:FALSE
> +subjectKeyIdentifier   = hash
> +authorityKeyIdentifier = keyid,issuer:always
> +
> +# The Easy-RSA CA extensions
> +[ easyrsa_ca ]
> +
> +# PKIX recommendations:
> +
> +subjectKeyIdentifier=hash
> +authorityKeyIdentifier=keyid:always,issuer:always
> +
> +# This could be marked critical, but it's nice to support reading by any
> +# broken clients who attempt to do so.
> +basicConstraints = CA:true
> +
> +# Limit key usage to CA tasks. If you really want to use the generated
> pair as
> +# a self-signed cert, comment this out.
> +keyUsage = cRLSign, keyCertSign
> +
> +# CRL extensions.
> +[ crl_ext ]
> +
> +# Only issuerAltName and authorityKeyIdentifier make any sense in a CRL.
> +
> +# issuerAltName=issuer:copy
> +authorityKeyIdentifier=keyid:always,issuer:always
> +
> +
> +# Server extensions.
> +[ server ]
> +
> +basicConstraints       = CA:FALSE
> +nsCertType             = server
> +nsComment              = "OpenSSL Generated Server Certificate"
> +subjectKeyIdentifier   = hash
> +authorityKeyIdentifier = keyid,issuer:always
> +extendedKeyUsage       = serverAuth
> +keyUsage               = digitalSignature, keyEncipherment
> diff --git a/sample/sample-keys/pass.crt b/sample/sample-keys/pass.crt
> deleted file mode 100644
> index 8bb7b17..0000000
> --- a/sample/sample-keys/pass.crt
> +++ /dev/null
> @@ -1,65 +0,0 @@
> -Certificate:
> -    Data:
> -        Version: 3 (0x2)
> -        Serial Number: 3 (0x3)
> -        Signature Algorithm: md5WithRSAEncryption
> -        Issuer: C=KG, ST=NA, L=BISHKEK,
> O=OpenVPN-TEST/emailAddress=me@...430...
> -        Validity
> -            Not Before: Nov 25 14:48:55 2004 GMT
> -            Not After : Nov 23 14:48:55 2014 GMT
> -        Subject: C=KG, ST=NA, O=OpenVPN-TEST,
> CN=Test-Client-Password/emailAddress=me@...430...
> -        Subject Public Key Info:
> -            Public Key Algorithm: rsaEncryption
> -            RSA Public Key: (1024 bit)
> -                Modulus (1024 bit):
> -                    00:ca:b4:05:67:7b:51:c1:d2:fe:21:57:b1:a5:57:
> -                    5c:c0:86:38:05:a8:91:cf:e7:a4:bd:7a:76:d8:3b:
> -                    cf:fe:f3:78:65:24:d6:72:7d:1b:6d:b6:da:04:f2:
> -                    a8:f6:b4:04:78:d2:24:a7:21:2f:ca:29:46:96:0f:
> -                    0b:91:31:66:1e:4d:22:9a:5d:05:17:99:9c:a0:7e:
> -                    e0:2a:be:78:0c:a1:b9:d4:04:c4:ec:f8:61:79:62:
> -                    b5:52:2d:f5:41:af:db:9f:8c:ab:08:1b:b7:95:b8:
> -                    c1:f0:29:d3:da:fb:00:3f:8e:5c:27:e3:8d:fa:ee:
> -                    dc:b4:3b:0b:8b:e0:ab:c1:c1
> -                Exponent: 65537 (0x10001)
> -        X509v3 extensions:
> -            X509v3 Basic Constraints:
> -                CA:FALSE
> -            Netscape Comment:
> -                OpenSSL Generated Certificate
> -            X509v3 Subject Key Identifier:
> -
> 40:57:F1:8C:9C:86:B2:DA:E0:3F:A7:B8:D7:85:43:45:07:8A:40:73
> -            X509v3 Authority Key Identifier:
> -
> keyid:89:A6:60:E3:BA:EA:3E:AF:FC:64:7F:4C:BD:8C:D2:48:8D:E0:CC:46
> -
> DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
> -                serial:00
> -
> -    Signature Algorithm: md5WithRSAEncryption
> -        a5:79:72:7f:a2:08:28:8e:66:da:e1:d0:be:bb:97:3d:65:9f:
> -        ab:1e:19:ac:f1:66:44:14:8f:4e:7c:eb:ea:1e:2f:57:ea:44:
> -        46:4c:b9:56:5b:c0:0c:58:d2:45:87:26:6d:82:de:8c:64:b8:
> -        8b:22:61:61:c6:68:36:08:9d:5a:fd:2f:e5:21:e1:a2:0c:7f:
> -        3e:ca:e1:06:ea:9f:81:62:3d:a0:ce:f1:1e:0d:ab:86:89:ed:
> -        9a:89:34:32:c9:e9:6d:7d:f5:11:c3:5d:7e:a5:f7:f1:a6:83:
> -        77:1b:94:67:d9:0f:5c:ac:0e:08:4a:88:98:65:49:eb:66:9e:
> -        2d:28
> ------BEGIN CERTIFICATE-----
> -MIIDPjCCAqegAwIBAgIBAzANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL
> -MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
> -VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy
> -NTE0NDg1NVoXDTE0MTEyMzE0NDg1NVowczELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
> -Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxHTAbBgNVBAMTFFRlc3QtQ2xpZW50
> -LVBhc3N3b3JkMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wgZ8w
> -DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMq0BWd7UcHS/iFXsaVXXMCGOAWokc/n
> -pL16dtg7z/7zeGUk1nJ9G2222gTyqPa0BHjSJKchL8opRpYPC5ExZh5NIppdBReZ
> -nKB+4Cq+eAyhudQExOz4YXlitVIt9UGv25+Mqwgbt5W4wfAp09r7AD+OXCfjjfru
> -3LQ7C4vgq8HBAgMBAAGjge4wgeswCQYDVR0TBAIwADAsBglghkgBhvhCAQ0EHxYd
> -T3BlblNTTCBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwHQYDVR0OBBYEFEBX8YychrLa
> -4D+nuNeFQ0UHikBzMIGQBgNVHSMEgYgwgYWAFImmYOO66j6v/GR/TL2M0kiN4MxG
> -oWqkaDBmMQswCQYDVQQGEwJLRzELMAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hL
> -RUsxFTATBgNVBAoTDE9wZW5WUE4tVEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlo
> -b3N0Lm15ZG9tYWluggEAMA0GCSqGSIb3DQEBBAUAA4GBAKV5cn+iCCiOZtrh0L67
> -lz1ln6seGazxZkQUj0586+oeL1fqREZMuVZbwAxY0kWHJm2C3oxkuIsiYWHGaDYI
> -nVr9L+Uh4aIMfz7K4Qbqn4FiPaDO8R4Nq4aJ7ZqJNDLJ6W199RHDXX6l9/Gmg3cb
> -lGfZD1ysDghKiJhlSetmni0o
> ------END CERTIFICATE-----
> diff --git a/sample/sample-keys/pass.key b/sample/sample-keys/pass.key
> deleted file mode 100644
> index 4916364..0000000
> --- a/sample/sample-keys/pass.key
> +++ /dev/null
> @@ -1,18 +0,0 @@
> ------BEGIN RSA PRIVATE KEY-----
> -Proc-Type: 4,ENCRYPTED
> -DEK-Info: DES-EDE3-CBC,959F7365DBBFDB77
> -
> -nGm57l+rR/8dAZOHL/1x/6dt11zUca7rphjsgw6XRnSf3M/CWmHvHVjApWcNLEs5
> -SWNMp1xfUogtGzsKoMBbnlZLDA7RVHUYD6dVMyCpc64UjzT08LmdZhtQYLAKmlUC
> -PT1VXS4Ae+SrqCPUqJkw1xP3kr0F1EVCXNu0nhOBAuuTGOS7PPEyW2N+k4nRHtsR
> -IaPp8GCuIeoR6CdymTFTq6d/GeCiEcyrUM4BNrG4GtRRrURxxOrzQFEOS5sjBPSg
> -Km1lwa6zBQFRLg9dKjRBL4teKuPY5Z2Nmpcml/aN4CkdkVEso4lW6/UHLE/joOMQ
> -0MdpdYtu8wnt1WI/Z4immQfl3MF+QcPMkqXXzCEhGG/5SbAo89KC46UXvu1Z5OhS
> -8XFHhvYBivOYWgZ3XUQqyZ0ulF60mFX7aE1Ph/eEbhWBHmU39hGjxzop1UoPwqLx
> -ahvtfvCkR3ZeqlWO9SHzCA3MlrKwQ1p1UL6nG6AJhNN9jSevH6by+8wr07NBZOqX
> -fJx+J/8EdVsUCFG2UJxPwM83ZSwAsvKRqph6CuWEl9ndUb7rw6khmRIoY0Iz3LbU
> -1MlcDoJNcJas6lYDr1UeFSk86g0SiGCHXZIqsjyUgq6HIy4YrAYiQUthnlF8tp2Q
> -nNQBPLo1GsHf0dC2MqKfDFASu7ST+Bl+yajHcIiUXvUJPxWbjkWYG9Q2p2ZBLzZD
> -uqeRr66OKxTzUS4go/QbHDNsAulXl61gQIEOdZw5uy/Jl11kyAI6EQbzmehagKdH
> -EshTgKp8ks62y0bBHgy3FMKyidJ5Hm58ZDhBxrwN0w+vhRoTGOepTA==
> ------END RSA PRIVATE KEY-----
> diff --git a/sample/sample-keys/pkcs12.p12 b/sample/sample-keys/pkcs12.p12
> deleted file mode 100644
> index
> 253d4081a3aeffab7d17e8c0a308ee1e85d6456f..0000000000000000000000000000000000000000
> GIT binary patch
> literal 0
> HcmV?d00001
>
> literal 2685
> zcmY+FX*3j!8pmgb83vhTUnbc_G)!b{*|LOW9U`x+nHmjQ1`%T<W0xfcjmmCh7ugCC
> zdJ&0)EMrR;Yxb*i?!E85AD;7^^ZTFY`Sd^Mhaj*7f`AMN0?QQ$ROYea<DFALCLo2t
> zf?y=DTsXnf2m+JTKM{mNVB$MLTp%FeWS#ma0V0GTEdTz%281Bk8JTZzui!YHif({F
> z%z!Wg<cF6_a`HQ&-}0i(xAKxjpEU+B5NPvT7ptk55iSO@...1973...#^pTwD>)*8*R!qdL
> z42fKOorCYJc=T4J+l;Z>x@...1974...{LvCNkwZ7MJ{eDgmCW|XX+3GT!YUko$TXTGuE6Cmo
> z9@...1975...=9<6!6cWi%@u>Dp-$JP2s6t=kvz6-OMl@~mEaEXG22le(Tfl@...1976...{VQ#pue@...1635...
> z$S`$H)k#B#icbEdGUTOJNtg8r2HVyl<L=KiZIZ{}D6=w)Cr?cr?f_CJAI>~u|5a%&
> z|9r54eca0dbeyd4`o{LK4N|e%U2!+rmvxC_ve9`q;d+UYx?t$mH)yUk-qpOnl`yp`
> z6mivqIZ>KlXGlc!9*DRZGrJ8ENY!3w!PQRJQYJN)m0bubO9Gq)!dpG`51#4fNteWj
> z)Uy{{o)tgT)cfGn@(n)(as)Oir2jGwc=aG2L+~IbIcV%&c5G|@P{*{Jd?#H>P7lkl
> zqLP8(ve$BRfwQ=WmCMw1W!aWKiK;iH%ej(rhXL~D<1btDIJpqh`U$seQ1fvjn;X@~
> zYBzzfQFps3x>N1~k|{r05Ej#luDsl5o+E5o6W}y((|9?EHOt+r>fDQx&b7jzQ$DN>
> zB}mx=v1cW#Y}5;W1wVL}RxO)q&@+=uH(=%CV{+~qJFCmm>+q;_TVOBY$s0EFSdS;7
> z&mqBKauOn(=lG*zP=4q^v2<1rBH%Edi*`-;3;k~BXqk@...1977...`Zs~A
> z*lzbt<Lz*?oKpFwtf0bMAHn6Pn_bV_(qucN^dt>kpmn`Y<JKcdnQLS<@1i>h@...1978...
> zEdZh~R0=kRsU4vUgW$I1u@|raEQEzz&hBqHE<e_`V*VvwZZK_?v#9@...1979...(OGuds8
> zq@`uGfPUcv*)58>tEs$w^vz4cAHezuzgvmuh)lb`_LM{yoz0Ij*wf}VZB9stQ6roq
> zhXDK5d)_MN2W5P|{wWcWta=?Is<$R6Ihym*+(~37OaRsIhbf-b8ck`;d~mN-TmSKH
> zAkCx?E}l3w*$}9L3^26R;TBK#i@...1620...|Af(ggGixifT9?AFEFm1R)6{ia%&96Y_^kl<Z
> zO|2vnP&e9h$B#-ZOGJ})^bdG_L!CP?tY@...1980...)+zmUojTmJjmc4zn6DhJtkU*2
> zTyOtzc?4-O5*u>1WMq;EV3-lRXEM}xv(^O~!7!1)I|9!h9%_2p<}KW$RKr|`YcLw}
> z<t#*oq1A`dE={byczot?YG(pSA(HR+V9kE4w4CN#78PlH7@...1981...#)P^RUmeu>0
> zVEA183^cHZa*3$N9%A*|4roE^WV?ltK2PQvtg$I&eq(wH*W%4sXR2^rp@?LgRIi$c
> z6%zNK^m$$X@&e`@P3O2H0YrU%8V)t=MmkiK;#rsB0!5%g)<#Kehh}i@<=mHXsKMvG
> z>eU}MNQy!ZO;oXNw(nZ<bk2lI6SjTIljmfn0{qR9p3ED1Sz&?R`~alg3@...1982...#^Z
> z`}cg57$n3>+J6q@)D4;l+}O_xHM_Z5tKoRYcpNO)&2;YaS1hNtXHcG&rv)Y1tsGBu
> zH@@nN^V!H%fJ=zM7xONAJ@...1983...*$%sBw&?k)KQXv{!oF~wZcUek*9AzOQ5GBOcPsmu
> zx>J0`U(5@...1984...>CkbfL4%WYBl*?wB7@...1985...+%J1>zfC|fk<4tarku$KHFg`)
> z32;tRbzJ8+W1aCRdY>%w%VrGgsHNyd4EbT#Qqh=VeTVcd!bI2!ts#EONaY-#AwEJ$
> zmV8E7g}dIaW$9T6mz_<cPyHH)vI(Gj!HGil32(YPF#3E^f5PEvZ8`K+AeaNE4Y{JZ
> zq+-*=9IuO>@2(aI>^megR`|b;#<jFHG7)`Rd8LiIqXgc}@<>#4x0GX*bjvl8tur0T
> zFi`8aRMRgtF^;s*U;`8O&uP@...1952...(S@...1986...;o#rX^|4v%b5bALTjthLt;I)IZQOg5sH58X
> z@...1987...>)V+B%k!v42GexdYt2hT)KhBqlrh)t$to8;ngHput4!Yrk-gY=}e^$|C-Y@...1988...=
> z-l_T>3@=KG>-JMVvEsG%_OrA4k@...1989...$RFdzXTFsv^5fJuNl`nhSt&uYLCr>Z
> z%rdbJyB06(7buBJ`C6EtGF<4J?VJGCxLiP)aL?oQ96Llg9qZ6=h3stpHJ6e={Ewg1
> zK+RSh?@GwJkQg&4zkgxJv+S4#fuv~Wlw&XBTWrIZVu<M<6^$$4j9FZSxaRM>_7~R1
> z1hL~0b#})ulH*=gO69)OAwLx|pJlgtw5t9Z)?-pY?gb~g{M^?K=_s7xMG!!{|06^S
> z0kp(O0L`7?>64j&u>MDnEI`mnn12Fa{GT-${#f&L#3IK5UMTvHHBZjN(4|GIJ8#*0
> zEL~S%gL8a#5<fZ6(5MkHV?G~ynw>P7p0Bg+ozfQ|)o`WbEdFq=Pn+~*x}eSHDn>}0
> za#bssC46DP>glYKit?*q(ylFaU(}~Odzjx2#k+auqmLOM8@...1598...)YFzplKD0QtM(F_Uu
> zRHv^yDq*$`c$xNo;O1uEWTg5NnUR9^wRyLx4G&J3O$l?Ff&Sgd*Ux|{yu}Tc_kRAx
> zZ4_A@...1990...$)Ek?$5BMzMT0ZfU+`%1_OIaTg-c`D3Utjws&do{_7d*j_LS6U+DKir
> z@...1991...#p!oOstM}_SmVJ?vyvMMumfm9By?=?AtkFJ4R`)DJQf3HPtrO>CLF*ghb-Z{VT
> z@&g3d`$hMvAw9wa-+X=cZug%2QLG(iT8okLHeD64iE06J24#}WG;%v0qN;o~J#X}X
> zYrX|$IsBw!A%<DK8BxUAB#r~6R2VbwU(5j!Z&%wNb{;g|?T5+<F1~+I0vu7#x&Fvm
> ze1ONAR~^|B&Qq0=ujo8B;e~P=3$o9GB)Cn*7-hG1(ZUGyCPoz>gBYC6=L-yXI_1c)
> z+V2@}l1I9@^i#Ub8wuxSinPw-x7vv^wsW3}5xqf+AKwPmn+)MXcW9$*)7<p)X-4r0
> z(}vuxaH}l=5mD9p6kTY6tV<=+{T09Rcf}dj;zzR*T|iIve0t3uU^!skyK<X(@4$hD
> zjLKXu4dS7hQnxGPoJKwgMg4@...1992...^3R(;eyD;4^ur4ohCZxY|q1QA*+PG
> z$SOGWw^n~{mai?yyFC!zxHo3~sLTIe)p*v~5PJ8vr85%;Nxo4%n<t_$^k`z?bVG;}
> z=Y3=zfQmI$kU)t2x7AQ?1s+B&c~qWv*&*FkE5g%9wN}Fw%x7DNP(X+vpb)SuI|E1n
> p3}EC!RO5XI2(vRh7cV|04Ibx-bA*{OGGFY`Qh)u6xbdgm{{pfR_hSG6
>
> diff --git a/sample/sample-keys/server-ec.crt
> b/sample/sample-keys/server-ec.crt
> new file mode 100644
> index 0000000..a72c341
> --- /dev/null
> +++ b/sample/sample-keys/server-ec.crt
> @@ -0,0 +1,96 @@
> +Certificate:
> +    Data:
> +        Version: 3 (0x2)
> +        Serial Number: 3 (0x3)
> +    Signature Algorithm: sha256WithRSAEncryption
> +        Issuer: C=KG, ST=NA, L=BISHKEK,
> O=OpenVPN-TEST/emailAddress=me@...430...
> +        Validity
> +            Not Before: Oct 22 21:59:53 2014 GMT
> +            Not After : Oct 19 21:59:53 2024 GMT
> +        Subject: C=KG, ST=NA, O=OpenVPN-TEST,
> CN=Test-Server-EC/emailAddress=me@...430...
> +        Subject Public Key Info:
> +            Public Key Algorithm: id-ecPublicKey
> +                Public-Key: (256 bit)
> +                pub:
> +                    04:21:09:ac:27:e6:00:3a:57:f4:f6:c7:78:a9:b1:
> +                    f4:d7:d7:45:59:39:e4:a3:d3:2c:94:f9:61:4a:e6:
> +                    b9:e9:87:57:c8:0f:88:03:a0:56:ee:34:e7:e4:4e:
> +                    20:63:6c:c1:6e:c1:04:ac:b9:2f:a9:76:69:d3:7d:
> +                    49:ff:f1:34:cb
> +                ASN1 OID: secp256k1
> +        X509v3 extensions:
> +            X509v3 Basic Constraints:
> +                CA:FALSE
> +            Netscape Cert Type:
> +                SSL Server
> +            Netscape Comment:
> +                OpenSSL Generated Server Certificate
> +            X509v3 Subject Key Identifier:
> +
> 33:1A:42:61:9E:88:08:3F:6F:1F:98:88:3A:DD:2D:C7:07:3D:F6:9B
> +            X509v3 Authority Key Identifier:
> +
> keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
> +
> DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
> +                serial:A1:4E:DE:FA:90:F2:AE:81
> +
> +            X509v3 Extended Key Usage:
> +                TLS Web Server Authentication
> +            X509v3 Key Usage:
> +                Digital Signature, Key Encipherment
> +    Signature Algorithm: sha256WithRSAEncryption
> +         9d:89:f6:7e:0b:43:05:22:63:e5:b3:45:a8:d9:ef:33:3c:b7:
> +         19:37:28:87:27:43:43:86:a3:3f:b9:23:27:0f:96:4f:de:01:
> +         80:38:6b:d9:c8:94:77:1f:06:08:34:65:77:ad:57:0c:23:99:
> +         f1:51:12:5f:32:d8:9c:7c:93:f1:f6:72:2a:05:61:ff:62:aa:
> +         33:aa:ef:a3:4d:d6:93:56:40:ff:38:2e:73:1c:69:fb:71:a1:
> +         fa:64:19:6a:04:1c:8b:20:a8:ee:a5:18:63:f8:84:f4:ca:84:
> +         8e:b6:05:48:c6:f3:f7:81:90:4d:9e:00:cd:4a:92:83:d4:93:
> +         67:05:dc:16:8b:78:fa:b1:82:48:c6:86:74:44:b1:06:7e:8a:
> +         c8:64:0b:82:3a:e2:f5:56:60:ea:50:70:03:da:9f:fc:28:20:
> +         6b:7d:04:e0:eb:8d:e2:f1:be:82:2f:ba:51:50:2b:6c:d2:fc:
> +         11:cd:69:85:3b:9e:14:19:dd:bc:14:cf:61:b0:7a:07:cb:e8:
> +         e0:fc:c3:1f:a4:cb:cf:c1:e9:62:0f:d2:53:f8:ce:06:f4:f8:
> +         2f:55:13:aa:67:44:b6:b8:e8:3e:82:af:66:f5:f0:7c:fe:41:
> +         e6:9d:c0:9f:78:fd:00:85:02:40:63:37:fa:00:e6:3c:a6:9f:
> +         35:4f:1d:a6:f1:cb:8b:04:e0:67:98:56:d1:87:58:b6:39:f6:
> +         d3:fe:a8:40:50:80:7f:e6:4a:36:d0:c0:a5:61:64:1d:3a:87:
> +         ad:78:72:c9:3f:98:44:35:f9:cf:32:b2:18:4c:b0:72:fa:5e:
> +         6c:62:1e:d4:31:0c:c8:9b:74:f0:00:9e:70:c3:1e:c7:a4:9d:
> +         03:a4:ac:1a:09:1f:86:23:65:51:34:50:86:68:1e:68:4d:9a:
> +         4b:78:10:1c:bd:51:09:bb:fe:16:a3:c7:19:b4:05:44:a1:e6:
> +         c6:23:76:d5:b8:3a:eb:a5:17:1d:2b:2e:fe:85:7c:88:4f:f1:
> +         e8:34:32:e0:c5:96:87:c3:e8:c9:5f:89:24:10:0e:1e:07:0b:
> +         2c:f8:d0:49:1b:63:5e:63:44:e9:2a:43:e2:9c:d6:f2:43:99:
> +         47:f8:9b:49:1a:a7:d1:e0:53:67:1d:cb:14:b6:b0:2c:4d:b3:
> +         f2:c5:62:c2:a6:09:7a:c0:6c:59:3e:73:83:0c:6c:de:30:77:
> +         4d:1b:ed:b0:7f:77:87:8d:55:1d:d3:ed:f7:66:bd:06:2a:f8:
> +         fd:00:e7:c0:31:e2:ff:53:9e:25:97:c6:64:84:9d:8d:61:8e:
> +         c9:1f:6c:55:a1:7c:59:aa:eb:e8:2a:b2:2d:c7:09:cd:b5:3d:
> +         d8:74:4f:6e:9c:3b:d5:6d
> +-----BEGIN CERTIFICATE-----
> +MIIEtTCCAp2gAwIBAgIBAzANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL
> +MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
> +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy
> +MjIxNTk1M1oXDTI0MTAxOTIxNTk1M1owbTELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
> +Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFzAVBgNVBAMTDlRlc3QtU2VydmVy
> +LUVDMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wVjAQBgcqhkjO
> +PQIBBgUrgQQACgNCAAQhCawn5gA6V/T2x3ipsfTX10VZOeSj0yyU+WFK5rnph1fI
> +D4gDoFbuNOfkTiBjbMFuwQSsuS+pdmnTfUn/8TTLo4IBMzCCAS8wCQYDVR0TBAIw
> +ADARBglghkgBhvhCAQEEBAMCBkAwMwYJYIZIAYb4QgENBCYWJE9wZW5TU0wgR2Vu
> +ZXJhdGVkIFNlcnZlciBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQUMxpCYZ6ICD9vH5iI
> +Ot0txwc99pswgZgGA1UdIwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRo
> +MGYxCzAJBgNVBAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEV
> +MBMGA1UEChMMT3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3Qu
> +bXlkb21haW6CCQChTt76kPKugTATBgNVHSUEDDAKBggrBgEFBQcDATALBgNVHQ8E
> +BAMCBaAwDQYJKoZIhvcNAQELBQADggIBAJ2J9n4LQwUiY+WzRajZ7zM8txk3KIcn
> +Q0OGoz+5IycPlk/eAYA4a9nIlHcfBgg0ZXetVwwjmfFREl8y2Jx8k/H2cioFYf9i
> +qjOq76NN1pNWQP84LnMcaftxofpkGWoEHIsgqO6lGGP4hPTKhI62BUjG8/eBkE2e
> +AM1KkoPUk2cF3BaLePqxgkjGhnREsQZ+ishkC4I64vVWYOpQcAPan/woIGt9BODr
> +jeLxvoIvulFQK2zS/BHNaYU7nhQZ3bwUz2GwegfL6OD8wx+ky8/B6WIP0lP4zgb0
> ++C9VE6pnRLa46D6Cr2b18Hz+QeadwJ94/QCFAkBjN/oA5jymnzVPHabxy4sE4GeY
> +VtGHWLY59tP+qEBQgH/mSjbQwKVhZB06h614csk/mEQ1+c8yshhMsHL6XmxiHtQx
> +DMibdPAAnnDDHseknQOkrBoJH4YjZVE0UIZoHmhNmkt4EBy9UQm7/hajxxm0BUSh
> +5sYjdtW4OuulFx0rLv6FfIhP8eg0MuDFlofD6MlfiSQQDh4HCyz40EkbY15jROkq
> +Q+Kc1vJDmUf4m0kap9HgU2cdyxS2sCxNs/LFYsKmCXrAbFk+c4MMbN4wd00b7bB/
> +d4eNVR3T7fdmvQYq+P0A58Ax4v9TniWXxmSEnY1hjskfbFWhfFmq6+gqsi3HCc21
> +Pdh0T26cO9Vt
> +-----END CERTIFICATE-----
> diff --git a/sample/sample-keys/server-ec.key
> b/sample/sample-keys/server-ec.key
> new file mode 100644
> index 0000000..8f2c914
> --- /dev/null
> +++ b/sample/sample-keys/server-ec.key
> @@ -0,0 +1,5 @@
> +-----BEGIN PRIVATE KEY-----
> +MIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQgLHGYqSlzoRaogmJfrC+E
> +ozTothB9bORaQ1C/3FmeQ6ehRANCAAQhCawn5gA6V/T2x3ipsfTX10VZOeSj0yyU
> ++WFK5rnph1fID4gDoFbuNOfkTiBjbMFuwQSsuS+pdmnTfUn/8TTL
> +-----END PRIVATE KEY-----
> diff --git a/sample/sample-keys/server.crt b/sample/sample-keys/server.crt
> index 28bb4d9..03e2023 100644
> --- a/sample/sample-keys/server.crt
> +++ b/sample/sample-keys/server.crt
> @@ -2,25 +2,34 @@ Certificate:
>      Data:
>          Version: 3 (0x2)
>          Serial Number: 1 (0x1)
> -        Signature Algorithm: md5WithRSAEncryption
> +    Signature Algorithm: sha256WithRSAEncryption
>          Issuer: C=KG, ST=NA, L=BISHKEK,
> O=OpenVPN-TEST/emailAddress=me@...430...
>          Validity
> -            Not Before: Nov 25 14:42:22 2004 GMT
> -            Not After : Nov 23 14:42:22 2014 GMT
> +            Not Before: Oct 22 21:59:52 2014 GMT
> +            Not After : Oct 19 21:59:52 2024 GMT
>          Subject: C=KG, ST=NA, O=OpenVPN-TEST,
> CN=Test-Server/emailAddress=me@...430...
>          Subject Public Key Info:
>              Public Key Algorithm: rsaEncryption
> -            RSA Public Key: (1024 bit)
> -                Modulus (1024 bit):
> -                    00:cb:4e:ac:f9:83:57:f6:69:d2:32:29:b4:bc:ad:
> -                    e6:f7:26:21:89:33:30:43:40:a3:35:d9:de:26:01:
> -                    d6:b4:f0:bc:0a:19:55:99:3b:f1:4c:91:60:b6:fd:
> -                    74:34:8d:5a:c7:62:ec:ce:f2:d6:02:ce:57:32:f4:
> -                    35:8c:71:a0:6d:65:2a:e7:80:ae:29:59:cf:36:73:
> -                    f8:7c:4a:73:90:fc:30:28:d5:46:7d:35:a4:4e:c9:
> -                    9f:90:7b:e2:09:21:36:c5:a8:ec:85:82:9a:32:b4:
> -                    91:3b:c1:d6:4f:9f:d1:f8:6f:68:f4:1d:d2:06:91:
> -                    32:cc:9a:48:fd:cd:98:7f:2f
> +                Public-Key: (2048 bit)
> +                Modulus:
> +                    00:a5:b8:a2:ee:ce:b1:a6:0f:6a:b2:9f:d3:22:17:
> +                    79:de:09:98:71:78:fa:a7:ce:36:51:54:57:c7:31:
> +                    99:56:d1:8a:d6:c5:fd:52:e6:88:0e:7b:f9:ea:27:
> +                    7a:bf:3f:14:ec:aa:d2:ff:8b:56:58:ac:ca:51:77:
> +                    c5:3c:b6:e4:83:6f:22:06:2d:5b:eb:e7:59:d4:ab:
> +                    42:c8:d5:a9:87:73:b3:73:36:51:2f:a5:d0:90:a2:
> +                    87:64:54:6c:12:d3:b8:76:47:69:af:ae:8f:00:b3:
> +                    70:b9:e7:67:3f:8c:6a:3d:79:5f:81:27:a3:0e:aa:
> +                    a7:3d:81:48:10:b1:18:6c:38:2e:8f:7a:7b:c5:3d:
> +                    21:c8:f9:a0:7f:17:2b:88:4f:ba:f2:ec:6d:24:8e:
> +                    6c:f1:0a:5c:d9:5b:b1:b0:fc:49:cb:4a:d2:58:c6:
> +                    2a:25:b0:97:84:c3:9e:ff:34:8c:10:46:7f:0f:fb:
> +                    3c:59:7a:a6:29:0c:ae:8e:50:3a:f2:53:84:40:2d:
> +                    d5:91:7b:0a:37:8e:82:77:ce:66:2f:34:77:5c:a5:
> +                    45:3b:00:19:a7:07:d1:92:e6:66:b9:3b:4e:e9:63:
> +                    fc:33:98:1a:ae:7b:08:7d:0a:df:7a:ba:aa:59:6d:
> +                    86:82:0a:64:2b:da:59:a7:4c:4e:ef:3d:bd:04:a2:
> +                    4b:31
>                  Exponent: 65537 (0x10001)
>          X509v3 extensions:
>              X509v3 Basic Constraints:
> @@ -30,38 +39,75 @@ Certificate:
>              Netscape Comment:
>                  OpenSSL Generated Server Certificate
>              X509v3 Subject Key Identifier:
> -
> 69:11:FE:E7:9F:89:7B:71:34:69:C0:DC:82:F8:D0:5D:4D:FB:78:DF
> +
> B3:9D:81:E6:16:92:64:C4:86:87:F5:29:10:1B:5E:2F:74:F7:ED:B1
>              X509v3 Authority Key Identifier:
> -
> keyid:89:A6:60:E3:BA:EA:3E:AF:FC:64:7F:4C:BD:8C:D2:48:8D:E0:CC:46
> +
> keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
>
>  DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
> -                serial:00
> +                serial:A1:4E:DE:FA:90:F2:AE:81
>
> -    Signature Algorithm: md5WithRSAEncryption
> -        35:5c:75:da:57:ef:b5:79:f2:a2:db:36:e4:75:e8:c7:bc:73:
> -        26:cf:30:36:4b:2e:51:46:37:60:2f:4e:2b:f6:71:a2:23:db:
> -        8e:d8:5c:d5:af:2e:22:28:dd:30:a8:89:66:3a:cc:5b:3c:0f:
> -        96:12:20:de:5e:41:52:74:35:ed:4c:26:40:19:ca:73:df:54:
> -        b1:30:96:9c:a5:14:d0:38:28:3f:ab:30:07:d7:de:98:d2:7f:
> -        7f:90:b2:52:1d:e5:95:88:ed:ba:8a:6a:14:85:66:76:ec:75:
> -        30:e8:ae:94:f4:e1:76:fa:4b:0e:f1:53:d7:95:be:fb:69:fa:
> -        3d:32
> +            X509v3 Extended Key Usage:
> +                TLS Web Server Authentication
> +            X509v3 Key Usage:
> +                Digital Signature, Key Encipherment
> +    Signature Algorithm: sha256WithRSAEncryption
> +         4e:25:80:1b:cb:b0:42:ff:bb:3f:e8:0d:58:c1:80:db:cf:d0:
> +         90:df:ca:c1:e6:41:e1:48:7f:a7:1e:c7:35:9f:9c:6d:7c:3e:
> +         82:e8:de:7e:ae:82:16:00:33:0f:02:23:f1:9d:fe:2b:06:16:
> +         05:55:16:89:dc:63:ac:5f:1a:31:13:79:21:a3:6e:60:28:e8:
> +         e7:6b:54:00:22:a1:b7:69:5a:17:31:ce:0f:c2:a6:dd:a3:6f:
> +         de:ea:19:6c:d2:d2:cb:35:9d:dd:87:51:33:68:cd:c3:9b:90:
> +         55:f1:80:3d:5c:b8:09:b6:e1:3c:13:a4:5d:4a:ce:a5:11:9e:
> +         f9:08:ee:be:e3:54:1d:06:4c:bb:1b:72:13:ee:7d:a0:45:cc:
> +         fe:d1:3b:02:03:c1:d4:ea:45:2d:a8:c9:97:e7:f3:8a:7a:a0:
> +         2f:dd:48:3a:75:c9:42:28:94:fc:af:44:52:16:68:98:d6:ad:
> +         a8:65:b1:cd:ac:60:41:70:e5:44:e8:5a:f2:e7:fc:3b:fe:45:
> +         89:17:1d:6d:85:c6:f0:fc:69:87:d1:1d:07:f3:cb:7b:54:8d:
> +         aa:a3:cc:e3:c6:fc:d6:05:76:35:d0:26:63:8e:d1:a8:b7:ff:
> +         61:42:8a:2c:63:1f:d4:ec:14:47:6b:1e:e3:81:61:12:3b:8c:
> +         16:b5:cf:87:6a:2d:42:21:83:9c:0e:3a:90:3a:1e:c1:36:61:
> +         41:f9:fb:4e:5d:ea:f4:df:23:92:33:2b:9b:14:9f:a0:f5:d3:
> +         c4:f8:1f:2f:9c:11:36:af:2a:22:61:95:32:0b:c4:1c:2d:b1:
> +         c1:0a:2a:97:c0:43:4a:6c:3e:db:00:cd:29:15:9e:7e:41:75:
> +         36:a8:56:86:8c:82:9e:46:20:e5:06:1e:60:d2:03:5f:9f:9e:
> +         69:bb:bf:c2:b4:43:e2:7d:85:17:83:18:41:b0:cb:a9:04:1b:
> +         18:52:9f:89:8b:76:9f:94:59:81:4f:60:5b:33:18:fc:c7:52:
> +         d0:d2:69:fc:0b:a2:63:32:75:43:99:e9:d7:f8:6d:c7:55:31:
> +         0c:f3:ef:1a:71:e1:0a:57:e1:9d:13:b2:1e:fe:1d:ef:e4:f1:
> +         51:d9:95:b3:fd:28:28:93:91:4a:29:c5:37:0e:ab:d8:85:6a:
> +         fe:a8:83:1f:7b:80:5d:1f:04:79:b7:a9:08:6e:0d:d6:2e:aa:
> +         7c:f6:63:7d:41:de:70:13:32:ce:dd:58:cc:a6:73:d4:72:7e:
> +         d7:ac:74:a8:35:ba:c3:1b:2a:64:d7:5a:37:97:56:94:34:2b:
> +         2a:71:60:bc:69:ab:00:85:b9:4f:67:32:17:51:c3:da:57:3a:
> +         37:89:66:c4:7a:51:da:5f
>  -----BEGIN CERTIFICATE-----
> -MIIDUTCCArqgAwIBAgIBATANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL
> +MIIFgDCCA2igAwIBAgIBATANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL
>  MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
> -VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy
> -NTE0NDIyMloXDTE0MTEyMzE0NDIyMlowajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
> +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy
> +MjIxNTk1MloXDTI0MTAxOTIxNTk1MlowajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
>  Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFDASBgNVBAMTC1Rlc3QtU2VydmVy
> -MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wgZ8wDQYJKoZIhvcN
> -AQEBBQADgY0AMIGJAoGBAMtOrPmDV/Zp0jIptLyt5vcmIYkzMENAozXZ3iYB1rTw
> -vAoZVZk78UyRYLb9dDSNWsdi7M7y1gLOVzL0NYxxoG1lKueArilZzzZz+HxKc5D8
> -MCjVRn01pE7Jn5B74gkhNsWo7IWCmjK0kTvB1k+f0fhvaPQd0gaRMsyaSP3NmH8v
> -AgMBAAGjggEJMIIBBTAJBgNVHRMEAjAAMBEGCWCGSAGG+EIBAQQEAwIGQDAzBglg
> -hkgBhvhCAQ0EJhYkT3BlblNTTCBHZW5lcmF0ZWQgU2VydmVyIENlcnRpZmljYXRl
> -MB0GA1UdDgQWBBRpEf7nn4l7cTRpwNyC+NBdTft43zCBkAYDVR0jBIGIMIGFgBSJ
> -pmDjuuo+r/xkf0y9jNJIjeDMRqFqpGgwZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
> -Ak5BMRAwDgYDVQQHEwdCSVNIS0VLMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxITAf
> -BgkqhkiG9w0BCQEWEm1lQG15aG9zdC5teWRvbWFpboIBADANBgkqhkiG9w0BAQQF
> -AAOBgQA1XHXaV++1efKi2zbkdejHvHMmzzA2Sy5RRjdgL04r9nGiI9uO2FzVry4i
> -KN0wqIlmOsxbPA+WEiDeXkFSdDXtTCZAGcpz31SxMJacpRTQOCg/qzAH196Y0n9/
> -kLJSHeWViO26imoUhWZ27HUw6K6U9OF2+ksO8VPXlb77afo9Mg==
> +MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wggEiMA0GCSqGSIb3
> +DQEBAQUAA4IBDwAwggEKAoIBAQCluKLuzrGmD2qyn9MiF3neCZhxePqnzjZRVFfH
> +MZlW0YrWxf1S5ogOe/nqJ3q/PxTsqtL/i1ZYrMpRd8U8tuSDbyIGLVvr51nUq0LI
> +1amHc7NzNlEvpdCQoodkVGwS07h2R2mvro8As3C552c/jGo9eV+BJ6MOqqc9gUgQ
> +sRhsOC6PenvFPSHI+aB/FyuIT7ry7G0kjmzxClzZW7Gw/EnLStJYxiolsJeEw57/
> +NIwQRn8P+zxZeqYpDK6OUDryU4RALdWRewo3joJ3zmYvNHdcpUU7ABmnB9GS5ma5
> +O07pY/wzmBquewh9Ct96uqpZbYaCCmQr2lmnTE7vPb0EoksxAgMBAAGjggEzMIIB
> +LzAJBgNVHRMEAjAAMBEGCWCGSAGG+EIBAQQEAwIGQDAzBglghkgBhvhCAQ0EJhYk
> +T3BlblNTTCBHZW5lcmF0ZWQgU2VydmVyIENlcnRpZmljYXRlMB0GA1UdDgQWBBSz
> +nYHmFpJkxIaH9SkQG14vdPftsTCBmAYDVR0jBIGQMIGNgBQrQOXJffX0ljjpL+Mv
> +2UBkyY4Fm6FqpGgwZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgTAk5BMRAwDgYDVQQH
> +EwdCSVNIS0VLMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxITAfBgkqhkiG9w0BCQEW
> +Em1lQG15aG9zdC5teWRvbWFpboIJAKFO3vqQ8q6BMBMGA1UdJQQMMAoGCCsGAQUF
> +BwMBMAsGA1UdDwQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAgEATiWAG8uwQv+7P+gN
> +WMGA28/QkN/KweZB4Uh/px7HNZ+cbXw+gujefq6CFgAzDwIj8Z3+KwYWBVUWidxj
> +rF8aMRN5IaNuYCjo52tUACKht2laFzHOD8Km3aNv3uoZbNLSyzWd3YdRM2jNw5uQ
> +VfGAPVy4CbbhPBOkXUrOpRGe+QjuvuNUHQZMuxtyE+59oEXM/tE7AgPB1OpFLajJ
> +l+fzinqgL91IOnXJQiiU/K9EUhZomNatqGWxzaxgQXDlROha8uf8O/5FiRcdbYXG
> +8Pxph9EdB/PLe1SNqqPM48b81gV2NdAmY47RqLf/YUKKLGMf1OwUR2se44FhEjuM
> +FrXPh2otQiGDnA46kDoewTZhQfn7Tl3q9N8jkjMrmxSfoPXTxPgfL5wRNq8qImGV
> +MgvEHC2xwQoql8BDSmw+2wDNKRWefkF1NqhWhoyCnkYg5QYeYNIDX5+eabu/wrRD
> +4n2FF4MYQbDLqQQbGFKfiYt2n5RZgU9gWzMY/MdS0NJp/AuiYzJ1Q5np1/htx1Ux
> +DPPvGnHhClfhnROyHv4d7+TxUdmVs/0oKJORSinFNw6r2IVq/qiDH3uAXR8Eebep
> +CG4N1i6qfPZjfUHecBMyzt1YzKZz1HJ+16x0qDW6wxsqZNdaN5dWlDQrKnFgvGmr
> +AIW5T2cyF1HD2lc6N4lmxHpR2l8=
>  -----END CERTIFICATE-----
> diff --git a/sample/sample-keys/server.key b/sample/sample-keys/server.key
> index 976acab..011df12 100644
> --- a/sample/sample-keys/server.key
> +++ b/sample/sample-keys/server.key
> @@ -1,15 +1,28 @@
> ------BEGIN RSA PRIVATE KEY-----
> -MIICXgIBAAKBgQDLTqz5g1f2adIyKbS8reb3JiGJMzBDQKM12d4mAda08LwKGVWZ
> -O/FMkWC2/XQ0jVrHYuzO8tYCzlcy9DWMcaBtZSrngK4pWc82c/h8SnOQ/DAo1UZ9
> -NaROyZ+Qe+IJITbFqOyFgpoytJE7wdZPn9H4b2j0HdIGkTLMmkj9zZh/LwIDAQAB
> -AoGBAKP1ljA/iY/zNY447kZ/5NWKzd7tBk4mcbl7M9no/7O6tZtbZRoIKoi6cYoC
> -C1ZabUyBbkNTud5XdCFmq0zRUjOWvoFMZ9VZfd2kRPvl4TGczBtJAq65b+EYMGui
> -q6T9p61xPdtzu0vM+Ecj127pAMk5XcJyxu8XQK7lZWmG5UoJAkEA8CxXNZN+A3qD
> -bMBPI3VdwKCNSjNVEQEnygMbNgw7VLdxPpspzZziqJEGdzsM4dsnOBwKxIWFLN2h
> -lbGBOquAswJBANi0atGWM8VUxDjvqqHCTS9RUXWgnvYhee4/xraJBQPBSivjC9P0
> -vKT7PjBHU6djtKSLKGaHn1vHqmyY7PCMjZUCQQCNVSqExqSzG1dXmdt4PErNXi2G
> -6qo2dX2arTVIGu6XLdQgSWLSMm5XT/CEHWW5SyPLKwVTHFeATXQXCPvJML9tAkEA
> -k0yXax0g1ZoXwufN4SQUmPw6Va03P/BjU/nP1ZVvbiz9gLVU/d7WN4J7tA9XomkY
> -idv5OzAmtxkSE70jGSNAvQJAWhCf9+iHkzOHRyKKOYlh1DHUwDfSEp+hlZYg9H03
> -P2sraQzUxgWDY/DIY63KvW78ny863baFz7onz21MYGgJXg==
> ------END RSA PRIVATE KEY-----
> +-----BEGIN PRIVATE KEY-----
> +MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCluKLuzrGmD2qy
> +n9MiF3neCZhxePqnzjZRVFfHMZlW0YrWxf1S5ogOe/nqJ3q/PxTsqtL/i1ZYrMpR
> +d8U8tuSDbyIGLVvr51nUq0LI1amHc7NzNlEvpdCQoodkVGwS07h2R2mvro8As3C5
> +52c/jGo9eV+BJ6MOqqc9gUgQsRhsOC6PenvFPSHI+aB/FyuIT7ry7G0kjmzxClzZ
> +W7Gw/EnLStJYxiolsJeEw57/NIwQRn8P+zxZeqYpDK6OUDryU4RALdWRewo3joJ3
> +zmYvNHdcpUU7ABmnB9GS5ma5O07pY/wzmBquewh9Ct96uqpZbYaCCmQr2lmnTE7v
> +Pb0EoksxAgMBAAECggEAPMOMin+jR75TYxeTNObiunVOPh0b2zeTVxLT9KfND7ZZ
> +cBK8pg79SEJRCnhbW5BnvbeNEkIm8PC6ZlDCM1bkRwUStq0fDUqQ95esLzOYq5/S
> +5qW98viblszhU/pYfja/Zi8dI1uf96PT63Zbt0NnGQ9N42+DLDeKhtTGdchZqiQA
> +LeSR0bQanY4tUUtCNYvBT8E3pzhoIsUzVwzIK53oovRpcOX3pMXVYZsmNhXdFFRy
> +YkjMXpj7fGyaAJK0QsC+PsgrKuhXDzDttsG2lI/mq9+7RXB3d/pzhmBVWynVH2lw
> +iQ7ONkSz7akDz/4I4WmxJep+FfQJYgK6rnLAlQqauQKBgQDammSAprnvDvNhSEp8
> +W+xt7jQnFqaENbGgP0/D/OZMXc4khgexqlKFmSnBCRDmQ6JvLTWqDXC4+aqAbFQz
> +zAIjiKaT+so8xvFRob+rBMJY5JLYKNa+zUUanfORUNYLFJPvFqnrWGaJ9uufdaM7
> +0a5bu95PN74NXee3DBbpBv8HLwKBgQDCEk+IjNbjMT+Neq0ywUeM5rFrUKi92abe
> +AgsVpjbighRV+6jA2lZFJcize+xYJ9wiOR1/TEI9PZ2OtBkqpwVdvTEHTagRLcvd
> +NfGcptREDnNLoNWA22buQpztiEduutACWQsrd+JQmqbUicUdW4zw86/oCMbYCW3V
> +QmYOLns7nwKBgHHUX20WZE91S4pmqFKlUzHTDdkk1ESX6Qx2q0R01j8BwawHFs6O
> +0DW9EZ7w55nfsh+OPRl1sjK/3ubMgfQO0TZLm+IGf3Sya0qEnVeiPMkpDMX+TgRA
> +wzEe+ou6uho+9uFSvdxMxeglaYA5M2ycvNwLsbEyZ4ZyVYxdgTiKahYFAoGAcIfP
> +iD0qKQiYcj/tB94cz+3AeJqHjbYT1O1YYhBECOkmQ4kuG80+cs/q5W/45lEOiuWV
> +Xgfo7Lu6jVGOujWoneci87oqtvNYH4e09oGh2WiLoBG9Wv9dWtBTUERSLzmxfXsG
> +SAk2uEhEbj8IhfJc8iZLHH9iVUh6YEslBBodqL8CgYEAlAhvcqAvw5SzsfBR5Mcu
> +4Nql6mXEVhHCvS4hdFCGaNF0z9A6eBORKJpdLWnqhpquDQDsghWE+Ga4QKSNFIi1
> +fnAaykmZuY3ToqNOIaVlYM6HpMEz0wHQbTWfDLGcTFcElLZgMAk7VlDyiYVOco+E
> +QX9lXOO1PGpLzXhlDxSe63Y=
> +-----END PRIVATE KEY-----
> --
> 1.9.1
>
>

--089e0149c9b4d5b8bf0507e642c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Attached a v2 of this patch that adds an extra check =
whether openssl is actually available.<br><br></div>-Steffan<br><div><div><=
div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, =
Oct 23, 2014 at 12:16 AM, Steffan Karger <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">I kept most of the certificate =
properties equal to the old<br>
certs, since some people&#39;s test scripts might rely on them (and<br>
it does not require any creativity from my part).<br>
<br>
Changes:<br>
=C2=A0* Add script to generate fresh test/sample keys<br>
=C2=A0 =C2=A0(but keep sample keys in git for simple testing)<br>
=C2=A0* Switch from 1024 to 4096 bits RSA CA<br>
=C2=A0* Switch from 1024 to 2048 bits client/server RSA keys<br>
=C2=A0* Switch from 1024 to 2048 bits Diffie-Hellman parameters<br>
=C2=A0* Generate EC client and server cert, but sign with RSA CA<br>
=C2=A0 =C2=A0(lets us test EC &lt;-&gt; RSA interoperability)<br>
=C2=A0* Remove 3DES cipher from &#39;sample&#39; config<br>
=C2=A0* Add &#39;remote-cert-tls server&#39; to client config<br>
=C2=A0* Update config files to deprecate nsCertType in favour of the<br>
=C2=A0 =C2=A0keyUsage and extendedKeyUsage extensions.<br>
=C2=A0* Make naming more consistent<br>
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan@...1856...">ste=
ffan@...1856...</a>&gt;<br>
---<br>
=C2=A0sample/sample-config-files/client.conf=C2=A0 =C2=A0 =C2=A0|=C2=A0 17 =
++--<br>
=C2=A0sample/sample-config-files/loopback-client |=C2=A0 =C2=A02 +-<br>
=C2=A0sample/sample-config-files/loopback-server |=C2=A0 =C2=A03 +-<br>
=C2=A0sample/sample-config-files/server.conf=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A06 +-<br>
=C2=A0sample/sample-config-files/tls-office.conf |=C2=A0 =C2=A02 +-<br>
=C2=A0sample/sample-keys/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0sample/sample-keys/README=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 17 ++--<br>
=C2=A0sample/sample-keys/ca.crt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 48 ++++++----<br>
=C2=A0sample/sample-keys/ca.key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 67 ++++++++++----<br>
=C2=A0sample/sample-keys/client-ec.crt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 85 ++++++++++++++++++<br>
=C2=A0sample/sample-keys/client-ec.key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A05 ++<br>
=C2=A0sample/sample-keys/client-pass.key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 30 +++++++<br>
=C2=A0sample/sample-keys/client.crt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 126 +++++++++++++++++---------<br>
=C2=A0sample/sample-keys/client.key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 43 +++++----<br>
=C2=A0sample/sample-keys/client.p12=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | Bin 0 -&gt; 4533 bytes<br>
=C2=A0sample/sample-keys/dh1024.pem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A05 --<br>
=C2=A0sample/sample-keys/dh2048.pem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A08 ++<br>
=C2=A0sample/sample-keys/ec-ca.crt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 13 ---<br>
=C2=A0sample/sample-keys/ec-ca.key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A06 --<br>
=C2=A0sample/sample-keys/ec-client.crt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 61 -------------<br>
=C2=A0sample/sample-keys/ec-client.key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A06 --<br>
=C2=A0sample/sample-keys/ec-server.crt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 61 -------------<br>
=C2=A0sample/sample-keys/ec-server.key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A06 --<br>
=C2=A0sample/sample-keys/gen-sample-keys.sh=C2=A0 =C2=A0 =C2=A0 |=C2=A0 74 =
+++++++++++++++<br>
=C2=A0sample/sample-keys/openssl.cnf=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 139 +++++++++++++++++++++++++++++<br>
=C2=A0sample/sample-keys/pass.crt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 65 --------------<br>
=C2=A0sample/sample-keys/pass.key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 18 ----<br>
=C2=A0sample/sample-keys/pkcs12.p12=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | Bin 2685 -&gt; 0 bytes<br>
=C2=A0sample/sample-keys/server-ec.crt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 96 ++++++++++++++++++++<br>
=C2=A0sample/sample-keys/server-ec.key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A05 ++<br>
=C2=A0sample/sample-keys/server.crt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 130 ++++++++++++++++++---------<br>
=C2=A0sample/sample-keys/server.key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 43 +++++----<br>
=C2=A032 files changed, 778 insertions(+), 410 deletions(-)<br>
=C2=A0create mode 100644 sample/sample-keys/.gitignore<br>
=C2=A0create mode 100644 sample/sample-keys/client-ec.crt<br>
=C2=A0create mode 100644 sample/sample-keys/client-ec.key<br>
=C2=A0create mode 100644 sample/sample-keys/client-pass.key<br>
=C2=A0create mode 100644 sample/sample-keys/client.p12<br>
=C2=A0delete mode 100644 sample/sample-keys/dh1024.pem<br>
=C2=A0create mode 100644 sample/sample-keys/dh2048.pem<br>
=C2=A0delete mode 100644 sample/sample-keys/ec-ca.crt<br>
=C2=A0delete mode 100644 sample/sample-keys/ec-ca.key<br>
=C2=A0delete mode 100644 sample/sample-keys/ec-client.crt<br>
=C2=A0delete mode 100644 sample/sample-keys/ec-client.key<br>
=C2=A0delete mode 100644 sample/sample-keys/ec-server.crt<br>
=C2=A0delete mode 100644 sample/sample-keys/ec-server.key<br>
=C2=A0create mode 100755 sample/sample-keys/gen-sample-keys.sh<br>
=C2=A0create mode 100644 sample/sample-keys/openssl.cnf<br>
=C2=A0delete mode 100644 sample/sample-keys/pass.crt<br>
=C2=A0delete mode 100644 sample/sample-keys/pass.key<br>
=C2=A0delete mode 100644 sample/sample-keys/pkcs12.p12<br>
=C2=A0create mode 100644 sample/sample-keys/server-ec.crt<br>
=C2=A0create mode 100644 sample/sample-keys/server-ec.key<br>
<br>
diff --git a/sample/sample-config-files/client.conf b/sample/sample-config-=
files/client.conf<br>
index 58b2038..050ef60 100644<br>
--- a/sample/sample-config-files/client.conf<br>
+++ b/sample/sample-config-files/client.conf<br>
@@ -89,18 +89,19 @@ ca ca.crt<br>
=C2=A0cert client.crt<br>
=C2=A0key client.key<br>
<br>
-# Verify server certificate by checking<br>
-# that the certicate has the nsCertType<br>
-# field set to &quot;server&quot;.=C2=A0 This is an<br>
-# important precaution to protect against<br>
+# Verify server certificate by checking that the<br>
+# certicate has the correct key usage set.<br>
+# This is an important precaution to protect against<br>
=C2=A0# a potential attack discussed here:<br>
=C2=A0#=C2=A0 <a href=3D"http://openvpn.net/howto.html#mitm" target=3D"_bla=
nk">http://openvpn.net/howto.html#mitm</a><br>
=C2=A0#<br>
=C2=A0# To use this feature, you will need to generate<br>
-# your server certificates with the nsCertType<br>
-# field set to &quot;server&quot;.=C2=A0 The build-key-server<br>
-# script in the easy-rsa folder will do this.<br>
-ns-cert-type server<br>
+# your server certificates with the keyUsage set to<br>
+#=C2=A0 =C2=A0digitalSignature, keyEncipherment<br>
+# and the extendedKeyUsage to<br>
+#=C2=A0 =C2=A0serverAuth<br>
+# EasyRSA can do this for you.<br>
+remote-cert-tls server<br>
<br>
=C2=A0# If a tls-auth key is used on the server<br>
=C2=A0# then every client must also have the key.<br>
diff --git a/sample/sample-config-files/loopback-client b/sample/sample-con=
fig-files/loopback-client<br>
index d7f59e6..ebbd1cf 100644<br>
--- a/sample/sample-config-files/loopback-client<br>
+++ b/sample/sample-config-files/loopback-client<br>
@@ -17,9 +17,9 @@ dev null<br>
=C2=A0verb 3<br>
=C2=A0reneg-sec 10<br>
=C2=A0tls-client<br>
+remote-cert-tls server<br>
=C2=A0ca sample-keys/ca.crt<br>
=C2=A0key sample-keys/client.key<br>
=C2=A0cert sample-keys/client.crt<br>
-cipher DES-EDE3-CBC<br>
=C2=A0ping 1<br>
=C2=A0inactive 120 10000000<br>
diff --git a/sample/sample-config-files/loopback-server b/sample/sample-con=
fig-files/loopback-server<br>
index 9d21bce..8cb97be 100644<br>
--- a/sample/sample-config-files/loopback-server<br>
+++ b/sample/sample-config-files/loopback-server<br>
@@ -17,10 +17,9 @@ dev null<br>
=C2=A0verb 3<br>
=C2=A0reneg-sec 10<br>
=C2=A0tls-server<br>
-dh sample-keys/dh1024.pem<br>
+dh sample-keys/dh2048.pem<br>
=C2=A0ca sample-keys/ca.crt<br>
=C2=A0key sample-keys/server.key<br>
=C2=A0cert sample-keys/server.crt<br>
-cipher DES-EDE3-CBC<br>
=C2=A0ping 1<br>
=C2=A0inactive 120 10000000<br>
diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-=
files/server.conf<br>
index 467d5b8..701be3c 100644<br>
--- a/sample/sample-config-files/server.conf<br>
+++ b/sample/sample-config-files/server.conf<br>
@@ -81,10 +81,8 @@ key server.key=C2=A0 # This file should be kept secret<b=
r>
<br>
=C2=A0# Diffie hellman parameters.<br>
=C2=A0# Generate your own with:<br>
-#=C2=A0 =C2=A0openssl dhparam -out dh1024.pem 1024<br>
-# Substitute 2048 for 1024 if you are using<br>
-# 2048 bit keys.<br>
-dh dh1024.pem<br>
+#=C2=A0 =C2=A0openssl dhparam -out dh2048.pem 2048<br>
+dh dh2048.pem<br>
<br>
=C2=A0# Network topology<br>
=C2=A0# Should be subnet (addressing via IP)<br>
diff --git a/sample/sample-config-files/tls-office.conf b/sample/sample-con=
fig-files/tls-office.conf<br>
index f790f46..d196144 100644<br>
--- a/sample/sample-config-files/tls-office.conf<br>
+++ b/sample/sample-config-files/tls-office.conf<br>
@@ -26,7 +26,7 @@ up ./office.up<br>
=C2=A0tls-server<br>
<br>
=C2=A0# Diffie-Hellman Parameters (tls-server only)<br>
-dh dh1024.pem<br>
+dh dh2048.pem<br>
<br>
=C2=A0# Certificate Authority file<br>
=C2=A0ca my-ca.crt<br>
diff --git a/sample/sample-keys/.gitignore b/sample/sample-keys/.gitignore<=
br>
new file mode 100644<br>
index 0000000..f148752<br>
--- /dev/null<br>
+++ b/sample/sample-keys/.gitignore<br>
@@ -0,0 +1 @@<br>
+sample-ca/<br>
diff --git a/sample/sample-keys/README b/sample/sample-keys/README<br>
index 9f4f918..66dd945 100644<br>
--- a/sample/sample-keys/README<br>
+++ b/sample/sample-keys/README<br>
@@ -1,14 +1,19 @@<br>
=C2=A0Sample RSA and EC keys.<br>
<br>
+Run ./gen-sample-keys.sh to generate fresh test keys.<br>
+<br>
=C2=A0See the examples section of the man page for usage examples.<br>
<br>
=C2=A0NOTE: THESE KEYS ARE FOR TESTING PURPOSES ONLY.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0DON&#39;T USE THEM FOR ANY REAL WORK BECAUSE<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0THEY ARE TOTALLY INSECURE!<br>
<br>
-ca.{crt,key}=C2=A0 =C2=A0 =C2=A0-- sample CA key/cert<br>
-client.{crt,key} -- sample client key/cert<br>
-server.{crt,key} -- sample server key/cert (nsCertType=3Dserver)<br>
-pass.{crt,key}=C2=A0 =C2=A0-- sample client key/cert with password-encrypt=
ed key<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass=
word =3D &quot;password&quot;<br>
-ec-*.{crt,key}=C2=A0 =C2=A0-- sample elliptic curve variants of the above<=
br>
+ca.{crt,key}=C2=A0 =C2=A0 =C2=A0 =C2=A0 -- sample CA key/cert<br>
+server.{crt,key}=C2=A0 =C2=A0 -- sample server key/cert<br>
+client.{crt,key}=C2=A0 =C2=A0 -- sample client key/cert<br>
+client-pass.key=C2=A0 =C2=A0 =C2=A0-- sample client key with password-encr=
ypted key<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0password =3D &quot;password&quot;<br>
+client.p12=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -- sample client pkcs12 bundl=
e<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0password =3D &quot;password&quot;<br>
+client-ec.{crt,key} -- sample elliptic curve client key/cert<br>
+server-ec.{crt,key} -- sample elliptic curve server key/cert<br>
diff --git a/sample/sample-keys/ca.crt b/sample/sample-keys/ca.crt<br>
index e063ccc..a11bafa 100644<br>
--- a/sample/sample-keys/ca.crt<br>
+++ b/sample/sample-keys/ca.crt<br>
@@ -1,19 +1,35 @@<br>
=C2=A0-----BEGIN CERTIFICATE-----<br>
-MIIDBjCCAm+gAwIBAgIBADANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL<br>
+MIIGKDCCBBCgAwIBAgIJAKFO3vqQ8q6BMA0GCSqGSIb3DQEBCwUAMGYxCzAJBgNV<br>
+BAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMM<br>
+T3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4w<br>
+HhcNMTQxMDIyMjE1OTUyWhcNMjQxMDE5MjE1OTUyWjBmMQswCQYDVQQGEwJLRzEL<br>
=C2=A0MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t<br>
-VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy<br>
-NTE0NDA1NVoXDTE0MTEyMzE0NDA1NVowZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
-Ak5BMRAwDgYDVQQHEwdCSVNIS0VLMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxITAf<br>
-BgkqhkiG9w0BCQEWEm1lQG15aG9zdC5teWRvbWFpbjCBnzANBgkqhkiG9w0BAQEF<br>
-AAOBjQAwgYkCgYEAqPjWJnesPu6bR/iec4FMz3opVaPdBHxg+ORKNmrnVZPh0t8/<br>
-ZT34KXkYoI9B82scurp8UlZVXG8JdUsz+yai8ti9+g7vcuyKUtcCIjn0HLgmdPu5<br>
-gFX25lB0pXw+XIU031dOfPvtROdG5YZN5yCErgCy7TE7zntLnkEDuRmyU6cCAwEA<br>
-AaOBwzCBwDAdBgNVHQ4EFgQUiaZg47rqPq/8ZH9MvYzSSI3gzEYwgZAGA1UdIwSB<br>
-iDCBhYAUiaZg47rqPq/8ZH9MvYzSSI3gzEahaqRoMGYxCzAJBgNVBAYTAktHMQsw<br>
-CQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMMT3BlblZQTi1U<br>
-RVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CAQAwDAYDVR0T<br>
-BAUwAwEB/zANBgkqhkiG9w0BAQQFAAOBgQBfJoiWYrYdjM0mKPEzUQk0nLYTovBP<br>
-I0es/2rfGrin1zbcFY+4dhVBd1E/StebnG+CP8r7QeEIwu7x8gYDdOLLsZn+2vBL<br>
-e4jNU1ClI6Q0L7jrzhhunQ5mAaZztVyYwFB15odYcdN2iO0tP7jtEsvrRqxICNy3<br>
-8itzViPTf5W4sA=3D=3D<br>
+VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMIICIjANBgkq<br>
+hkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAsJVPCqt3vtoDW2U0DII1QIh2Qs0dqh88<br>
+8nivxAIm2LTq93e9fJhsq3P/UVYAYSeCIrekXypR0EQgSgcNTvGBMe20BoHO5yvb<br>
+GjKPmjfLj6XRotCOGy8EDl/hLgRY9efiA8wsVfuvF2q/FblyJQPR/gPiDtTmUiqF<br>
+qXa7AJmMrqFsnWppOuGd7Qc6aTsae4TF1e/gUTCTraa7NeHowDaKhdyFmEEnCYR5<br>
+CeUsx2JlFWAH8PCrxBpHYbmGyvS0kH3+rQkaSM/Pzc2bS4ayHaOYRK5XsGq8XiNG<br>
+KTTLnSaCdPeHsI+3xMHmEh+u5Og2DFGgvyD22gde6W2ezvEKCUDrzR7bsnYqqyUy<br>
+n7LxnkPXGyvR52T06G8KzLKQRmDlPIXhzKMO07qkHmIonXTdF7YI1azwHpAtN4dS<br>
+rUe1bvjiTSoEsQPfOAyvD0RMK/CBfgEZUzAB50e/IlbZ84c0DJfUMOm4xCyft1HF<br>
+YpYeyCf5dxoIjweCPOoP426+aTXM7kqq0ieIr6YxnKV6OGGLKEY+VNZh1DS7enqV<br>
+HP5i8eimyuUYPoQhbK9xtDGMgghnc6Hn8BldPMcvz98HdTEH4rBfA3yNuCxLSNow<br>
+4jJuLjNXh2QeiUtWtkXja7ec+P7VqKTduJoRaX7cs+8E3ImigiRnvmK+npk7Nt1y<br>
+YE9hBRhSoLsCAwEAAaOB2DCB1TAdBgNVHQ4EFgQUK0DlyX319JY46S/jL9lAZMmO<br>
+BZswgZgGA1UdIwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRoMGYxCzAJ<br>
+BgNVBAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UE<br>
+ChMMT3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21h<br>
+aW6CCQChTt76kPKugTAMBgNVHRMEBTADAQH/MAsGA1UdDwQEAwIBBjANBgkqhkiG<br>
+9w0BAQsFAAOCAgEABc77f4C4P8fIS+V8qCJmVNSDU44UZBc+D+J6ZTgW8JeOHUIj<br>
+Bh++XDg3gwat7pIWQ8AU5R7h+fpBI9n3dadyIsMHGwSogHY9Gw7di2RVtSFajEth<br>
+rvrq0JbzpwoYedMh84sJ2qI/DGKW9/Is9+O52fR+3z3dY3gNRDPQ5675BQ5CQW9I<br>
+AJgLOqzD8Q0qrXYi7HaEqzNx6p7RDTuhFgvTd+vS5d5+28Z5fm2umnq+GKHF8W5P<br>
+ylp2Js119FTVO7brusAMKPe5emc7tC2ov8OFFemQvfHR41PLryap2VD81IOgmt/J<br>
+kX/j/y5KGux5HZ3lxXqdJbKcAq4NKYQT0mCkRD4l6szaCEJ+k0SiM9DdTcBDefhR<br>
+9q+pCOyMh7d8QjQ1075mF7T+PGkZQUW1DUjEfrZhICnKgq+iEoUmM0Ee5WtRqcnu<br>
+5BTGQ2mSfc6rV+Vr+eYXqcg7Nxb3vFXYSTod1UhefonVqwdmyJ2sC79zp36Tbo2+<br>
+65NW2WJK7KzPUyOJU0U9bcu0utvDOvGWmG+aHbymJgcoFzvZmlXqMXn97pSFn4jV<br>
+y3SLRgJXOw1QLXL2Y5abcuoBVr4gCOxxk2vBeVxOMRXNqSWZOFIF1bu/PxuDA+Sa<br>
+hEi44aHbPXt9opdssz/hdGfd8Wo7vEJrbg7c6zR6C/Akav1Rzy9oohIdgOw=3D<br>
=C2=A0-----END CERTIFICATE-----<br>
diff --git a/sample/sample-keys/ca.key b/sample/sample-keys/ca.key<br>
index b4bf792..8b11bc2 100644<br>
--- a/sample/sample-keys/ca.key<br>
+++ b/sample/sample-keys/ca.key<br>
@@ -1,15 +1,52 @@<br>
------BEGIN RSA PRIVATE KEY-----<br>
-MIICXQIBAAKBgQCo+NYmd6w+7ptH+J5zgUzPeilVo90EfGD45Eo2audVk+HS3z9l<br>
-PfgpeRigj0Hzaxy6unxSVlVcbwl1SzP7JqLy2L36Du9y7IpS1wIiOfQcuCZ0+7mA<br>
-VfbmUHSlfD5chTTfV058++1E50blhk3nIISuALLtMTvOe0ueQQO5GbJTpwIDAQAB<br>
-AoGAQuVREyWp4bhhbZr2UFBOco2ws6EOLWp4kdD/uI+WSoEjlHKiDJj+GJ1CrL5K<br>
-o+4yD5MpCQf4/4FOQ0ukprfjJpDwDinTG6vzuWSLTHNiTgvksW3vy7IsNMJx97hT<br>
-4D2QOOl9HhA50Qqg70teMPYXOgLRMVsdCIV7p7zDNy4nM+ECQQDX8m5ZcQmPtUDA<br>
-38dPTfpL4U7kMB94FItJYH/Lk5kMW1/J33xymNhL+BHaG064ol9n2ubGW4XEO5t2<br>
-qE1IOsVpAkEAyE/x/OBVSI1s75aYGlEwMd87p3qaDdtXT7WzujjRY7r8Y1ynkMU6<br>
-GtMeneBX/lk4BY/6I+5bhAzce+hqhaXejwJBAL5Wg+c4GApf41xdogqHm7doNyYw<br>
-OHyZ9w9NDDc+uGbI30xLPSCxEe0cEXgiG6foDpm2uzRZFTWaqHPU8pFYpAkCQGNX<br>
-cpWM0/7VVK9Fqk1y8knpgfY/UWOJ4jU/0dCLGR0ywLSuYNPlXDmtdkOp3TnhGW14<br>
-x/9F2NEWZ8pzq1B4wHUCQQC5ztD4m/rpiIpinoewUJODoeBJXYBKqx1+mdrALCq6<br>
-ESvK1WRiusMaY3xmsdv4J2TB5iUPryELbn3jU12WGcQc<br>
------END RSA PRIVATE KEY-----<br>
+-----BEGIN PRIVATE KEY-----<br>
+MIIJQwIBADANBgkqhkiG9w0BAQEFAASCCS0wggkpAgEAAoICAQCwlU8Kq3e+2gNb<br>
+ZTQMgjVAiHZCzR2qHzzyeK/EAibYtOr3d718mGyrc/9RVgBhJ4Iit6RfKlHQRCBK<br>
+Bw1O8YEx7bQGgc7nK9saMo+aN8uPpdGi0I4bLwQOX+EuBFj15+IDzCxV+68Xar8V<br>
+uXIlA9H+A+IO1OZSKoWpdrsAmYyuoWydamk64Z3tBzppOxp7hMXV7+BRMJOtprs1<br>
+4ejANoqF3IWYQScJhHkJ5SzHYmUVYAfw8KvEGkdhuYbK9LSQff6tCRpIz8/NzZtL<br>
+hrIdo5hErlewarxeI0YpNMudJoJ094ewj7fEweYSH67k6DYMUaC/IPbaB17pbZ7O<br>
+8QoJQOvNHtuydiqrJTKfsvGeQ9cbK9HnZPTobwrMspBGYOU8heHMow7TuqQeYiid<br>
+dN0XtgjVrPAekC03h1KtR7Vu+OJNKgSxA984DK8PREwr8IF+ARlTMAHnR78iVtnz<br>
+hzQMl9Qw6bjELJ+3UcVilh7IJ/l3GgiPB4I86g/jbr5pNczuSqrSJ4ivpjGcpXo4<br>
+YYsoRj5U1mHUNLt6epUc/mLx6KbK5Rg+hCFsr3G0MYyCCGdzoefwGV08xy/P3wd1<br>
+MQfisF8DfI24LEtI2jDiMm4uM1eHZB6JS1a2ReNrt5z4/tWopN24mhFpftyz7wTc<br>
+iaKCJGe+Yr6emTs23XJgT2EFGFKguwIDAQABAoICAQCEYPqnihI0PqZjnwQdGIQp<br>
+g+P8gl7pyY9cS0OhUueicEbyDI8+V9qn0kcmx61zKDY0Jq4QNd6tnlUCijTc6Mot<br>
+DwF2G1xsC4GvKxZiy89MOkhloanXETEeQZzDbbjvaM4UgL0AHLWPfZQRCjxbKXkE<br>
+0A5phgvAr2YSvBLHCVXhGN0fScXnwXouVsvgVdGtpcTWdIUa+KrNdQBGDbz6VCkW<br>
+31I76SQFy40d8PPX6ZjUJHDvnM14LycySO6XOkofRIVnXTqaOUiVBb2VKj5fX+Ro<br>
+ILdWZz4d6J3RiGXYwyTr4SGVKLjgxWfgUGZB7x+NrqgugNzuaLYrkuWKSEN42nWq<br>
+yoP6x6xtbAsmB6Fvdqwm/d8BmLhUweaVc0L7AYzXNsOBuT3kubJHMmu3Jv4xgyWk<br>
+l/MAGJQc7i7QQweGgsYZgR8WlbkWkSFpUcgQBDzDibb6nsD2jnYijQrnrrmiEjEI<br>
+R7MO551V+nFw9utiM8U9WIWwqzY0d98ujWkGjVe7uz9ZBVyg0DEAEj/zRi9T54aG<br>
+1V6CB2Cjyw+HzzsDw7yWroWzo4U9YfjbPKCoBsXlqQFLFwY8oL6mEZ7UOobaV1Zl<br>
+WtuHyYw3UNFxuSGPPyxJkFePIQLLvfKvh2R+V0DrT3UJRoKKlt9RejRSN0tOh0Cm<br>
+2YD6d7T/DXnQHomIQKhKEQKCAQEA3sgsDg0eKDK8pUyVE+9wW5kql12nTzpBtnCM<br>
+eg5J9OJcXKhCD/NIyUTIMXoMvZQpLwGUAYLgu4gE04zKWHDouf7MRSFltD5LJ7F2<br>
+7nuYKHZXk0BhgMhdnQot3FKcOMrKCnZcM+RWX9ZJa8wO6whCaYCw7DtS0SSVODQk<br>
+9EwAgX6/Hq60V7ujPZJCyNd3o0bIdAA/0AQRTZUADP3AHgUzh71aysYJt+UKt1v0<br>
+Xc7l6hn7Dn7Ewzpf+WdZ2pV7d3JUSBVKiTDxLV904nDBNOxjMhz0rW01ojR6bzpn<br>
+XhkFPqnmh+yEYGRgfSAAzkvSsSJEAtBFSicupA/6n83Lo2YvswKCAQEAyumuxP4Z<br>
+a7s8x8DFba7vuQ+KVxpkKgEz1sxnGRNQJm18/ss/Y5JiaLFYT3E72VkQfBQ2ngu+<br>
+GrJL3OhiNhzy1KLGS6mrwULtKiuud5MMQDL0Pvkncr9NTy4rBnWzhp2XyPeETu8n<br>
+JpL2i2OK6lY/lgpBckXuap9gAl0fXk+y+BkZ71OoYaGnKpPjs+Xcq/qgPgZ7O3NW<br>
+1g+Bd2AVPSxQpXjuy5rgtQURCN733vkNBzFedKREx7Z6l8UPlK/Exuc7BMIHfn5V<br>
+dd0R3Th+82fkMNVJz6MKmHJ6CJI53M7co/YdAvIkxOFRIPGbO3arL2R69nRgAZBE<br>
+zLawx1JJTRIG2QKCAQATtZXgMFzopYR3A011FAvWrrhL5+czZS4HG/Hxom38kkIl<br>
+mGUv0BAybjlf1zJlW0RBelxDvfZv4Nq8dIo6RNLyEY601v2OcqxneJXTB3AwtDeP<br>
+OXTm1dMiX5IrGcvkYlx5jHsfxCW4GNcqCEWRmYt2lgIRBDaRdjEVZdeXHVo2GqaB<br>
+6mbeFCWe/t+VsSpOcaauTI9YseNt/66fd5uVjFRAwAnWQqr9b/AAxMvbuMAyc9X4<br>
+NFLoCrQO9ovGgM8JhD3cmrWbaY8MupM2rU8KhZdJCbLD3ROPpCDo0jvu4TvLjXBt<br>
+ugkEFh1LNJedqKudLDDkJtTaeJjxvtAnbyeC7zltAoIBAC9TIyzUqq8io0FfZ2x2<br>
+cXiy9CvuftABKcr+L0l85KOhw5ZVZvpdKNCMFDGrEi9WA28886QWzwbA8Mqb9FP0<br>
+mnoXYLJC50kSx+ee+nju9dt/RtHtIFM15N0DwosmJnHODZmUiOo0AuiPPCs0UzDm<br>
+Xrwqtirlvn5ln2nNuEQxyGbuy8qys0HaBvf6OBA8GySNNpRgxJsQAn+4bBSgdzOm<br>
+Q0TkmKUqASCXBusPvbXmVjCIRiRkL5p4p8z/6+tct0NAqNYqPr80zc/IeKMkyw8P<br>
++vucszNXLmBxyp53JEGoiXNAMnH+ca7tchOB5hePTMun3rneWInk0PcB4OcL/QaZ<br>
+nrkCggEBAN67+SvcWtM1BoLXSz5/apFAE+DicCv94PrvMBOhfvu1oBrElR1rBjiN<br>
+2B83SktkF4WhCXr10GP+RUpjaqPBtT7NW4r3fL5B8EPsHeabL+pg9e6wG1rH8GqG<br>
+toWecmfC9uqK7l1A59h5Oveq5K19bZTRZRjQtv2e4KQknlJR6cwy+TGUU5kAUlMt<br>
+vcivyjzxc0UQwq7zKktJq+xW/TZiSLgd3B32p0sXX378qFUJ4SO2UZ1OCh8R7PY1<br>
+Fx25K/89Q1yGdbYiXb/Dx0a2WB9rP+b6alMl/dxPdqDKj2QXXkdh8+yvhVpQTyZw<br>
+B1RaqQXwzqrCH0F/vw3lRceYhcQvzcQ=3D<br>
+-----END PRIVATE KEY-----<br>
diff --git a/sample/sample-keys/client-ec.crt b/sample/sample-keys/client-e=
c.crt<br>
new file mode 100644<br>
index 0000000..edc6fe3<br>
--- /dev/null<br>
+++ b/sample/sample-keys/client-ec.crt<br>
@@ -0,0 +1,85 @@<br>
+Certificate:<br>
+=C2=A0 =C2=A0 Data:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Version: 3 (0x2)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Serial Number: 4 (0x4)<br>
+=C2=A0 =C2=A0 Signature Algorithm: sha256WithRSAEncryption<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Issuer: C=3DKG, ST=3DNA, L=3DBISHKEK, O=3DOpen=
VPN-TEST/emailAddress=3Dme@...430...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Validity<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not Before: Oct 22 21:59:53 2014=
 GMT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not After : Oct 19 21:59:53 2024=
 GMT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subject: C=3DKG, ST=3DNA, O=3DOpenVPN-TEST, CN=
=3DTest-Client-EC/emailAddress=3Dme@...430...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subject Public Key Info:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Public Key Algorithm: id-ecPubli=
cKey<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Public-Key: (256 b=
it)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pub:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 04:3=
b:ce:62:5d:6f:87:82:75:24:c2:58:f5:0e:88:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4d:5=
7:0d:06:b2:71:88:87:58:19:bb:de:5f:7f:52:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 62:5=
1:a2:48:91:83:48:91:90:3e:87:02:0f:15:51:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f9:6=
8:97:12:0a:fd:d2:3c:87:83:4b:65:54:00:44:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8d:2=
8:76:49:05<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASN1 OID: secp256k=
1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 extensions:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Basic Constraints:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CA:FALSE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Subject Key Identifier:<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 64:F6:49:88:E7:74:=
C1:AB:A5:FA:4F:2B:71:3C:25:13:3D:C8:94:C5<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Authority Key Identifier:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyid:2B:40:E5:C9:=
7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DirName:/C=3DKG/ST=
=3DNA/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial:A1:4E:DE:FA=
:90:F2:AE:81<br>
+<br>
+=C2=A0 =C2=A0 Signature Algorithm: sha256WithRSAEncryption<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A032:3d:f0:08:67:dd:03:73:76:cc:76:52:0a:f=
6:97:d1:c6:fa:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05f:d3:e6:28:c9:75:a7:08:a8:34:49:69:cf:e=
b:ab:da:86:b3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02e:65:17:ee:7e:b6:b5:6b:15:0b:dc:11:3a:b=
9:5a:b3:80:b8:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb:f4:6c:cf:88:3a:10:83:7e:10:a0:82:87:6=
e:06:ec:78:62:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d4:d1:44:27:dd:2c:19:d8:1a:a1:ae:f4:a0:0=
0:7f:53:5a:40:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08a:c2:83:77:4b:26:7d:53:b0:d3:0f:2f:7c:2=
8:70:ef:74:58:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05b:de:81:94:4c:63:19:f0:79:cb:6c:b2:ec:3=
2:1b:4b:e4:62:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A022:4f:ad:ac:4a:6f:a9:6e:c4:2a:8d:8a:88:1=
9:09:fd:88:93:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03c:27:4d:91:95:ff:57:84:13:fd:4a:68:db:2=
0:df:10:e6:81:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01d:fd:e7:1d:35:fb:19:02:dd:b5:5f:a0:c1:0=
7:ec:74:b4:ef:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08b:f9:33:9a:f2:a6:3b:6e:b6:4a:52:ab:5d:9=
9:76:64:62:c4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d5:3a:c6:81:8d:eb:c8:4b:02:af:e1:ca:60:e=
9:8d:c7:a9:2b:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ea:4f:56:31:d3:9a:11:c2:9c:83:5c:a2:8d:9=
8:fe:cc:a5:ad:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01f:51:c4:6e:cf:ff:a0:51:64:c8:7f:7f:32:0=
5:4c:8d:7f:bf:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b8:ed:e5:81:5f:81:bd:1d:9b:3f:8a:83:27:2=
6:b4:69:84:8b:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e5:d9:ea:fd:08:a8:aa:e4:3a:dc:29:4d:80:6=
c:13:f7:45:ce:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A092:f2:a9:f3:5f:90:83:d6:23:0f:50:e5:40:0=
9:4c:6b:f2:73:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aa:d8:49:a7:a9:81:6e:bb:f2:e4:a5:7f:19:3=
9:1d:65:f3:11:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A097:b1:2b:7c:2f:36:77:7f:75:fd:88:44:90:7=
c:f2:33:8d:cd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02c:f6:76:60:33:d3:f4:b3:8c:81:d7:85:89:c=
c:d7:d5:2c:94:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a9:31:3f:d3:63:a7:dc:82:3f:0a:d8:c5:71:9=
7:69:3b:c1:69:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cb:f0:1b:be:15:c0:be:aa:fd:e8:13:2c:0c:3=
f:72:7b:7d:9c:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03b:7f:b8:82:36:4b:ad:4d:16:19:b9:1c:b3:2=
d:d7:5f:8b:f8:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A014:ce:d4:13:e5:82:7a:1d:40:28:08:65:4a:1=
9:d7:7a:35:09:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0db:36:48:4b:96:44:bd:1f:12:b2:39:08:1e:5=
b:66:25:9b:e0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016:d3:79:05:e3:f6:90:da:95:95:33:a1:53:a=
8:3c:a9:f0:b2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f5:d0:aa:80:a0:96:ca:8c:45:62:c2:74:04:9=
1:68:27:fb:e9:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A097:be:3a:87:8a:85:28:2d:6e:a9:60:9b:63:b=
a:65:98:5e:bb:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A002:ee:ac:ba:be:f6:42:26<br>
+-----BEGIN CERTIFICATE-----<br>
+MIIESTCCAjGgAwIBAgIBBDANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL<br>
+MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t<br>
+VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy<br>
+MjIxNTk1M1oXDTI0MTAxOTIxNTk1M1owbTELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
+Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFzAVBgNVBAMTDlRlc3QtQ2xpZW50<br>
+LUVDMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wVjAQBgcqhkjO<br>
+PQIBBgUrgQQACgNCAAQ7zmJdb4eCdSTCWPUOiE1XDQaycYiHWBm73l9/UmJRokiR<br>
+g0iRkD6HAg8VUflolxIK/dI8h4NLZVQARI0odkkFo4HIMIHFMAkGA1UdEwQCMAAw<br>
+HQYDVR0OBBYEFGT2SYjndMGrpfpPK3E8JRM9yJTFMIGYBgNVHSMEgZAwgY2AFCtA<br>
+5cl99fSWOOkv4y/ZQGTJjgWboWqkaDBmMQswCQYDVQQGEwJLRzELMAkGA1UECBMC<br>
+TkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4tVEVTVDEhMB8G<br>
+CSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluggkAoU7e+pDyroEwDQYJKoZI<br>
+hvcNAQELBQADggIBADI98Ahn3QNzdsx2Ugr2l9HG+l/T5ijJdacIqDRJac/rq9qG<br>
+sy5lF+5+trVrFQvcETq5WrOAuLv0bM+IOhCDfhCggoduBux4YtTRRCfdLBnYGqGu<br>
+9KAAf1NaQIrCg3dLJn1TsNMPL3wocO90WFvegZRMYxnwectssuwyG0vkYiJPraxK<br>
+b6luxCqNiogZCf2IkzwnTZGV/1eEE/1KaNsg3xDmgR395x01+xkC3bVfoMEH7HS0<br>
+74v5M5rypjtutkpSq12ZdmRixNU6xoGN68hLAq/hymDpjcepK+pPVjHTmhHCnINc<br>
+oo2Y/sylrR9RxG7P/6BRZMh/fzIFTI1/v7jt5YFfgb0dmz+KgycmtGmEi+XZ6v0I<br>
+qKrkOtwpTYBsE/dFzpLyqfNfkIPWIw9Q5UAJTGvyc6rYSaepgW678uSlfxk5HWXz<br>
+EZexK3wvNnd/df2IRJB88jONzSz2dmAz0/SzjIHXhYnM19UslKkxP9Njp9yCPwrY<br>
+xXGXaTvBacvwG74VwL6q/egTLAw/cnt9nDt/uII2S61NFhm5HLMt11+L+BTO1BPl<br>
+gnodQCgIZUoZ13o1Cds2SEuWRL0fErI5CB5bZiWb4BbTeQXj9pDalZUzoVOoPKnw<br>
+svXQqoCglsqMRWLCdASRaCf76Ze+OoeKhSgtbqlgm2O6ZZheuwLurLq+9kIm<br>
+-----END CERTIFICATE-----<br>
diff --git a/sample/sample-keys/client-ec.key b/sample/sample-keys/client-e=
c.key<br>
new file mode 100644<br>
index 0000000..8131380<br>
--- /dev/null<br>
+++ b/sample/sample-keys/client-ec.key<br>
@@ -0,0 +1,5 @@<br>
+-----BEGIN PRIVATE KEY-----<br>
+MIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQg2RVk/d0yok086M9bLPIi<br>
+eu4DfcBUwphOnkje1/7VSY+hRANCAAQ7zmJdb4eCdSTCWPUOiE1XDQaycYiHWBm7<br>
+3l9/UmJRokiRg0iRkD6HAg8VUflolxIK/dI8h4NLZVQARI0odkkF<br>
+-----END PRIVATE KEY-----<br>
diff --git a/sample/sample-keys/client-pass.key b/sample/sample-keys/client=
-pass.key<br>
new file mode 100644<br>
index 0000000..2bb8d4e<br>
--- /dev/null<br>
+++ b/sample/sample-keys/client-pass.key<br>
@@ -0,0 +1,30 @@<br>
+-----BEGIN RSA PRIVATE KEY-----<br>
+Proc-Type: 4,ENCRYPTED<br>
+DEK-Info: AES-256-CBC,ECC1F209896FC2621233FFF6F1FFD045<br>
+<br>
+i6t7VKTyNNELTvrBO464e02nFg9rvYwumxd0sfqcPtaKmRK2mrZmEd/Xh0Nv1WyB<br>
+PyuJo78qQixAtxObRbkSNINzTr5C8IDrE6+wQYCJinvO54U0o+ksv0tsyLngz1cb<br>
+is8ZqHXrRgJ3qGFQWmFRtFKFQvSXOTDX3fLkEB53HfeblQCxBCnJ82Sp7ivnVR/j<br>
+Q8qQRy1RMbzIN0trEGf0Zi4tHEvXL1u7Y+olQzSlmWWaQt20hhXUOMLhMtlRsAo7<br>
+AwjlE94JjAfJ1q1dwIcRN4c9Lk8GkiX6w7nDpRACDpk2S8ifCqi69eGe4+g7owhL<br>
+74bgs64PmM9a2sNXy1v6WE3c/t6sSrZiMvrGsqMo4sBlrQ9WXe0Naon7heBkPcdS<br>
+px0YJjnyBXHMIH+ASmALSJ5JXq9vt2xRFf0dOsGapxhP+7bZJ5Pwyk/yUu5uHFbM<br>
+/aBemlrZJzlKeYiiwpwx2whQAtDwN41zMG+r27EzSU/AaDV40NPiwwycpWt/Bp1e<br>
+z1ag0JuS0an+PK4jmREtzT5U5BeAVM91x8YttOPpmUIpahAa1zwdYPRAIkbmPJ4z<br>
+ZH+9YoPH4hoBQKdIhshYktjdI++xNiKXAUGUz5YoX8S68SsLdmKvhnQ7fu5VvOkA<br>
+2pb7taXGy7zfn+a/fWauhuceV9HPlAXMIu3GsssODoNly3vpcFeiMySKppygJ3Eg<br>
+A3o9n8UepD+jXflKG/R/t7U3hT6LqSIvQWqBqYMEVFMCNzSsJ/ce/4veFvx343zT<br>
+qdxuzYqyiXM74cynpfqHdVa9SFICTesNdVDI0FdOXhSQ4bHJc7Xp9FFJdS0lMRw4<br>
+ACwKxvs8lo4Gx1WFyCqH5OxosKtDHQYzdUJfSWVJlhhOFR3GncR9qSe3O5fkhJfs<br>
+TALnC+xTJyCkSB2k0/bxVLIhlkPdCwzsrN/B6X2CDBdg0mQIo0LaPzGF8VneM20d<br>
+XebYn751XSiL3HKyq8G5AEFwj9AO3Q8gKuP2fPoWdngJ2GT+mt1m2fIw9Igu39J0<br>
+ZMegyUN0wSIiA5AkgryK9U+PJEiJmLzOJ/NGr7E5tPF18eZWapK4KZ8TXC4RNiye<br>
+g+apGa+xZJz2VQp/Mrcdj9D4UDJFQjrvKaS0PXJDoYUXFBoMv3rxijzRVxlhhuJY<br>
+yZ0At+UqZD5wpuWW6DRrgJIpy0HNhbaLmgsU0Co0HKviB0x8hvMJbi/uCoPTOdPz<br>
+sPB7CN2i3oXe7xw1HfSTSFWb4leqjlKwNgfV42ox0QUjkkADeeuY+56g/B2+QmdE<br>
+vXrc6sDwfNUwRUzeMn8yfum/aW1y/wrqF/qPTBQqFd85vlzS+NfXIKDg04cAljTu<br>
++2BLzvizh9Bb68iG4PykNXbjbAir1EbQG1tCzq1eKhERjgrxdv6+XqAmvchMCeL5<br>
+L6hvfQFBPCo/4xnMpU5wooFarO/kGdKlGr5rXOydgfL618Td18BIX+FHQFb3zzVU<br>
+y2NR4++DslJAZgAU+512zzpW1m3JtaRoyqyoLE2YFPlW804Xc1PBB3Ix6Wyzcegy<br>
+D4qMk5qxjBkXEsBBSCYfVbWoMBeMhnvxkz0b9wkPtAW/jEJCB2Kkn/5yMC0DkePO<br>
+-----END RSA PRIVATE KEY-----<br>
diff --git a/sample/sample-keys/client.crt b/sample/sample-keys/client.crt<=
br>
index c047446..1744cb2 100644<br>
--- a/sample/sample-keys/client.crt<br>
+++ b/sample/sample-keys/client.crt<br>
@@ -2,64 +2,102 @@ Certificate:<br>
=C2=A0 =C2=A0 =C2=A0Data:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Version: 3 (0x2)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Serial Number: 2 (0x2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Signature Algorithm: md5WithRSAEncryption<br>
+=C2=A0 =C2=A0 Signature Algorithm: sha256WithRSAEncryption<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Issuer: C=3DKG, ST=3DNA, L=3DBISHKEK, O=
=3DOpenVPN-TEST/emailAddress=3Dme@...430...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Validity<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not Before: Nov 25 14:46:49 2004=
 GMT<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not After : Nov 23 14:46:49 2014=
 GMT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not Before: Oct 22 21:59:53 2014=
 GMT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not After : Oct 19 21:59:53 2024=
 GMT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Subject: C=3DKG, ST=3DNA, O=3DOpenVPN-TES=
T, CN=3DTest-Client/emailAddress=3Dme@...430...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Subject Public Key Info:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Public Key Algorithm: rsaEn=
cryption<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RSA Public Key: (1024 bit)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Modulus (1024 bit)=
:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 00:d=
2:12:5c:c6:4d:13:34:ae:cf:fa:ab:fe:cb:de:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8c:f=
1:4b:4a:95:28:60:87:82:2c:b8:c1:e5:8e:c6:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5d:1=
1:58:61:a4:a5:f1:42:d7:86:74:6c:9d:9c:7a:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f0:3=
a:5c:29:e6:53:3b:5e:6d:d8:f0:45:06:2c:23:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ee:0=
9:bc:02:8f:0e:b8:d5:33:1f:c3:4a:11:02:48:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0b:c=
c:4b:ad:6e:74:e0:a2:53:b1:d6:cc:89:b9:e2:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6f:d=
b:15:b3:19:1e:57:04:79:48:3a:da:76:31:fc:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bf:d=
3:34:21:e7:32:d8:9e:06:4e:be:f3:e3:79:b0:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 54:f=
d:d1:42:32:aa:3e:7a:c1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Public-Key: (2048 =
bit)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Modulus:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 00:e=
c:65:8f:e9:12:c2:1a:5b:e6:56:2a:08:a9:82:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3a:2=
d:44:78:a3:00:3b:b0:9f:e7:27:10:40:93:ef:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f1:c=
c:3e:a0:aa:04:a2:80:1b:13:a9:e6:fe:81:d6:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 70:9=
0:a8:d8:d4:de:30:d8:35:00:d2:be:62:f0:48:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 da:f=
c:15:8d:c4:c6:6d:0b:99:f1:2b:83:00:0a:d3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2a:2=
3:0b:e5:cd:f9:35:df:43:61:15:72:ad:95:98:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f6:7=
3:21:41:5e:a0:dd:47:27:a0:d5:9a:d4:41:a8:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1c:1=
d:57:20:71:17:8f:f7:28:9e:3e:07:ce:ec:d5:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0e:4=
2:4f:1e:74:47:8e:47:9d:d2:14:28:27:2c:14:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10:f=
5:d1:96:b5:93:74:84:ef:f9:04:de:8d:4a:6f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 df:7=
7:ab:ea:d1:58:d3:44:fe:5a:04:01:ff:06:7a:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 97:f=
7:fd:e3:57:48:e1:f0:df:40:13:9f:66:23:5a:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e3:5=
5:54:3d:54:39:ee:00:f9:12:f1:d2:df:74:2e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ba:d=
7:f0:8d:c6:dd:18:58:1c:93:22:0b:75:fa:a8:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d6:e=
0:b5:2f:2d:b9:d4:fe:b9:4f:86:e2:75:48:16:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 60:f=
b:3f:c9:b4:30:42:29:fb:3b:b3:2b:b9:59:81:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6a:4=
6:f3:45:83:bf:fd:d5:1a:ff:37:0c:6f:5b:fd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 61:f=
1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Exponent: 655=
37 (0x10001)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0X509v3 extensions:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0X509v3 Basic Constraints:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CA:FALSE<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Netscape Comment:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OpenSSL Generated =
Certificate<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0X509v3 Subject Key Identifi=
er:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 17:B7:3F:C7:62:A0:=
A9:FD:A4:31:0E:58:D7:D9:94:7B:4B:3F:CB:56<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 D2:B4:36:0F:B1:FC:=
DD:A5:EA:2A:F7:C7:23:89:FA:E3:FA:7A:44:1D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0X509v3 Authority Key Identi=
fier:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyid:89:A6:60:E3:=
BA:EA:3E:AF:FC:64:7F:4C:BD:8C:D2:48:8D:E0:CC:46<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyid:2B:40:E5:C9:=
7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DirName:/C=3D=
KG/ST=3DNA/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial:00<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial:A1:4E:DE:FA=
:90:F2:AE:81<br>
<br>
-=C2=A0 =C2=A0 Signature Algorithm: md5WithRSAEncryption<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 61:c6:d1:fa:24:0f:c7:be:09:3b:d8:04:17:63:31:1=
7:07:f9:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 56:99:af:4c:67:fa:db:cb:94:cf:55:a5:7b:16:20:8=
b:42:64:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 13:23:62:45:28:93:5e:36:f7:db:02:95:a1:e9:fd:e=
3:0f:8d:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 73:a1:7b:0e:55:78:4d:a5:c4:b7:22:12:a0:ee:55:e=
0:b8:0e:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 c9:9b:12:e3:b0:ef:9b:68:93:57:6e:6c:ad:16:68:8=
e:8d:30:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 33:fe:2a:1b:c3:03:8f:b6:0a:2d:0c:b1:3c:bb:f9:5=
8:3f:8c:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 81:59:6b:14:dd:62:b5:c2:93:ed:5d:c6:19:0f:9b:4=
b:52:b3:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 7c:78<br>
+=C2=A0 =C2=A0 Signature Algorithm: sha256WithRSAEncryption<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07f:e0:fe:84:a7:ec:df:62:a5:cd:3c:c1:e6:4=
2:b1:31:12:f0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b9:da:a7:9e:3f:bd:96:52:b6:fc:55:74:64:3=
e:e4:ff:7e:aa:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f7:3e:06:18:5f:73:85:f8:c8:e0:67:1b:4d:9=
7:ca:05:d0:37:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A007:33:64:9b:e6:78:77:14:9a:55:bb:2a:ac:c=
3:7f:c9:15:08:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A083:5c:c8:c2:61:d3:71:4c:05:0b:2b:cb:a3:8=
7:6d:a0:32:ed:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b0:b3:27:97:4a:55:8d:01:2a:30:56:68:ab:f=
2:da:5c:10:73:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c9:aa:0a:9c:4b:4c:a0:5b:51:6e:0a:7e:6c:5=
3:80:b0:00:e1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01e:9a:4c:0a:37:9e:20:89:bc:c5:e5:79:58:b=
7:45:ff:d3:c4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a1:fd:d9:78:3d:45:16:74:df:82:44:1d:1d:8=
1:50:5a:b9:32:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04c:e2:4f:3f:0e:3a:65:5a:64:83:3b:29:31:c=
4:99:88:bc:c5:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A084:39:f2:19:12:e1:66:d0:ea:fb:75:b1:d2:2=
7:be:91:59:a3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02b:09:d5:5c:bf:46:8e:d6:67:d6:0b:ec:da:a=
b:f0:80:19:87:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A064:07:a9:77:b1:5e:0c:e2:c5:1d:6a:ac:5d:2=
3:f3:30:75:36:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04e:ca:c3:4e:b0:4d:8c:2c:ce:52:61:63:de:d=
5:f5:ef:ef:0a:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06b:23:25:26:3c:3a:f2:c3:c2:16:19:3f:a9:3=
2:ba:68:f9:c9:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A012:3c:3e:c6:1f:ff:9b:4e:f4:90:b0:63:f5:d=
1:33:00:30:5a:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e8:24:fa:35:44:9b:6a:80:f3:a6:cc:7b:3c:7=
3:5f:50:c4:30:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A071:d8:74:90:27:0a:01:4e:a5:5e:b1:f8:da:c=
2:61:81:11:ae:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A029:a3:8f:fa:7e:4c:4e:62:b1:00:de:92:e3:8=
f:6a:2e:da:d9:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A038:5d:6b:7c:0d:e4:01:aa:c8:c6:6d:8b:cd:c=
0:c8:6e:e4:57:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A021:8a:f6:46:30:d9:ad:51:a1:87:96:a6:53:c=
9:1e:c6:bb:c3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eb:55:fe:8c:d6:5c:d5:c6:f3:ca:b0:60:d2:d=
4:2a:1f:88:94:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d3:4c:1a:da:0c:94:fe:c1:5d:0d:2a:db:99:2=
9:5d:f6:dd:16:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c4:c8:4d:74:9e:80:d9:d0:aa:ed:7b:e3:30:e=
4:47:d8:f5:15:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c1:71:b8:c6:fd:ee:fc:9e:b2:5f:b5:b7:92:e=
d:ff:ca:37:f6:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c7:82:b4:54:13:9b:83:cd:87:8b:7e:64:f6:2=
e:54:3a:22:b1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c5:c1:f4:a5:25:53:9a:4d:a8:0f:e7:35:4b:8=
9:df:19:83:66:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A064:d9:db:d1:61:2b:24:1b:1d:44:44:fb:49:3=
0:87:b7:49:23:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A008:02:8a:e0:25:f3:f4:43<br>
=C2=A0-----BEGIN CERTIFICATE-----<br>
-MIIDNTCCAp6gAwIBAgIBAjANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL<br>
+MIIFFDCCAvygAwIBAgIBAjANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL<br>
=C2=A0MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t<br>
-VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy<br>
-NTE0NDY0OVoXDTE0MTEyMzE0NDY0OVowajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
+VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy<br>
+MjIxNTk1M1oXDTI0MTAxOTIxNTk1M1owajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
=C2=A0Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFDASBgNVBAMTC1Rlc3QtQ2xpZW50<br>
-MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wgZ8wDQYJKoZIhvcN<br>
-AQEBBQADgY0AMIGJAoGBANISXMZNEzSuz/qr/svejPFLSpUoYIeCLLjB5Y7GXRFY<br>
-YaSl8ULXhnRsnZx68DpcKeZTO15t2PBFBiwj7gm8Ao8OuNUzH8NKEQJIC8xLrW50<br>
-4KJTsdbMibnib9sVsxkeVwR5SDradjH8v9M0Iecy2J4GTr7z43mwVP3RQjKqPnrB<br>
-AgMBAAGjge4wgeswCQYDVR0TBAIwADAsBglghkgBhvhCAQ0EHxYdT3BlblNTTCBH<br>
-ZW5lcmF0ZWQgQ2VydGlmaWNhdGUwHQYDVR0OBBYEFBe3P8dioKn9pDEOWNfZlHtL<br>
-P8tWMIGQBgNVHSMEgYgwgYWAFImmYOO66j6v/GR/TL2M0kiN4MxGoWqkaDBmMQsw<br>
-CQYDVQQGEwJLRzELMAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNV<br>
-BAoTDE9wZW5WUE4tVEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9t<br>
-YWluggEAMA0GCSqGSIb3DQEBBAUAA4GBAGHG0fokD8e+CTvYBBdjMRcH+VaZr0xn<br>
-+tvLlM9VpXsWIItCZBMjYkUok14299sClaHp/eMPjXOhew5VeE2lxLciEqDuVeC4<br>
-DsmbEuOw75tok1dubK0WaI6NMDP+KhvDA4+2Ci0MsTy7+Vg/jIFZaxTdYrXCk+1d<br>
-xhkPm0tSs3x4<br>
+MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wggEiMA0GCSqGSIb3<br>
+DQEBAQUAA4IBDwAwggEKAoIBAQDsZY/pEsIaW+ZWKgipgjotRHijADuwn+cnEECT<br>
+7/HMPqCqBKKAGxOp5v6B1nCQqNjU3jDYNQDSvmLwSNr8FY3Exm0LmfErgwAK0yoj<br>
+C+XN+TXfQ2EVcq2VmPZzIUFeoN1HJ6DVmtRBqBwdVyBxF4/3KJ4+B87s1Q5CTx50<br>
+R45HndIUKCcsFBD10Za1k3SE7/kE3o1Kb993q+rRWNNE/loEAf8Gepf3/eNXSOHw<br>
+30ATn2YjWuNVVD1UOe4A+RLx0t90LrrX8I3G3RhYHJMiC3X6qNbgtS8tudT+uU+G<br>
+4nVIFmD7P8m0MEIp+zuzK7lZgWpG80WDv/3VGv83DG9b/WHxAgMBAAGjgcgwgcUw<br>
+CQYDVR0TBAIwADAdBgNVHQ4EFgQU0rQ2D7H83aXqKvfHI4n64/p6RB0wgZgGA1Ud<br>
+IwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRoMGYxCzAJBgNVBAYTAktH<br>
+MQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMMT3BlblZQ<br>
+Ti1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CCQChTt76<br>
+kPKugTANBgkqhkiG9w0BAQsFAAOCAgEAf+D+hKfs32KlzTzB5kKxMRLwudqnnj+9<br>
+llK2/FV0ZD7k/36q9z4GGF9zhfjI4GcbTZfKBdA3BzNkm+Z4dxSaVbsqrMN/yRUI<br>
+g1zIwmHTcUwFCyvLo4dtoDLtsLMnl0pVjQEqMFZoq/LaXBBzyaoKnEtMoFtRbgp+<br>
+bFOAsADhHppMCjeeIIm8xeV5WLdF/9PEof3ZeD1FFnTfgkQdHYFQWrkyTOJPPw46<br>
+ZVpkgzspMcSZiLzFhDnyGRLhZtDq+3Wx0ie+kVmjKwnVXL9GjtZn1gvs2qvwgBmH<br>
+ZAepd7FeDOLFHWqsXSPzMHU2TsrDTrBNjCzOUmFj3tX17+8KayMlJjw68sPCFhk/<br>
+qTK6aPnJEjw+xh//m070kLBj9dEzADBa6CT6NUSbaoDzpsx7PHNfUMQwcdh0kCcK<br>
+AU6lXrH42sJhgRGuKaOP+n5MTmKxAN6S449qLtrZOF1rfA3kAarIxm2LzcDIbuRX<br>
+IYr2RjDZrVGhh5amU8kexrvD61X+jNZc1cbzyrBg0tQqH4iU00wa2gyU/sFdDSrb<br>
+mSld9t0WxMhNdJ6A2dCq7XvjMORH2PUVwXG4xv3u/J6yX7W3ku3/yjf2x4K0VBOb<br>
+g82Hi35k9i5UOiKxxcH0pSVTmk2oD+c1S4nfGYNmZNnb0WErJBsdRET7STCHt0kj<br>
+CAKK4CXz9EM=3D<br>
=C2=A0-----END CERTIFICATE-----<br>
diff --git a/sample/sample-keys/client.key b/sample/sample-keys/client.key<=
br>
index 17b9509..6d31489 100644<br>
--- a/sample/sample-keys/client.key<br>
+++ b/sample/sample-keys/client.key<br>
@@ -1,15 +1,28 @@<br>
------BEGIN RSA PRIVATE KEY-----<br>
-MIICXAIBAAKBgQDSElzGTRM0rs/6q/7L3ozxS0qVKGCHgiy4weWOxl0RWGGkpfFC<br>
-14Z0bJ2cevA6XCnmUztebdjwRQYsI+4JvAKPDrjVMx/DShECSAvMS61udOCiU7HW<br>
-zIm54m/bFbMZHlcEeUg62nYx/L/TNCHnMtieBk6+8+N5sFT90UIyqj56wQIDAQAB<br>
-AoGBAK8RoIGekCfym99DYYfTg9A/t/tQeAnWYaDj7oSrKbqf1lgZ91OGPEZgkoVr<br>
-KzLnxf9uU+bhUs8CJx+4HdO8/L9rAJA+oD9QNuMp0elN4AKuEGE1Eq3a0e3cmgPI<br>
-+VIoXM6WVAGgK9I03Zu/UerYQ/DdXWGOIsKhFe8qyQoG9pKxAkEA9ld6O9MHQt3d<br>
-JAjJkgCNn4psozxjrfLWy2huXd3H3CRqGMjLITDGzdkVSgXjHokBYroi0+TZTu4M<br>
-ulJSJaWwBQJBANpO2DAexH2zRHw5Z6QyeEVxz7B3/FzU4GgJx9BH+FSBh+F0G5Ln<br>
-ir5Vst8vZ/LGcgpYjHQLNAvZVgUjiQ4Y6I0CQGvwMJL+CHR4GmmroAblTyjU0n1D<br>
-/Lk/anZ+L73Za7U+D28ErFzCrpmLwRRKOBYtGfpUbOZDpCQ9kj4hy/TLALECQCcL<br>
-9ysUNbzt9Y/qjJkX1d9F7gn4TBEmmkTBixW76bTjvjQbGlt6Qpyso2O8DPGlgPxM<br>
-vkJ7RoHgC7y7kGYPGnkCQBVxSNGIjLx4NQBgN4HD0y4+fars1PTUGnckBcS4npb9<br>
-onLNyerBlWdBwbARyBS7WPIbyyf5VCrn3yIqWxaARO0=3D<br>
------END RSA PRIVATE KEY-----<br>
+-----BEGIN PRIVATE KEY-----<br>
+MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDsZY/pEsIaW+ZW<br>
+KgipgjotRHijADuwn+cnEECT7/HMPqCqBKKAGxOp5v6B1nCQqNjU3jDYNQDSvmLw<br>
+SNr8FY3Exm0LmfErgwAK0yojC+XN+TXfQ2EVcq2VmPZzIUFeoN1HJ6DVmtRBqBwd<br>
+VyBxF4/3KJ4+B87s1Q5CTx50R45HndIUKCcsFBD10Za1k3SE7/kE3o1Kb993q+rR<br>
+WNNE/loEAf8Gepf3/eNXSOHw30ATn2YjWuNVVD1UOe4A+RLx0t90LrrX8I3G3RhY<br>
+HJMiC3X6qNbgtS8tudT+uU+G4nVIFmD7P8m0MEIp+zuzK7lZgWpG80WDv/3VGv83<br>
+DG9b/WHxAgMBAAECggEBAIOdaCpUD02trOh8LqZxowJhBOl7z7/ex0uweMPk67LT<br>
+i5AdVHwOlzwZJ8oSIknoOBEMRBWcLQEojt1JMuL2/R95emzjIKshHHzqZKNulFvB<br>
+TIUpdnwChTKtH0mqUkLlPU3Ienty4IpNlpmfUKimfbkWHERdBJBHbtDsTABhdo3X<br>
+9pCF/yRKqJS2Fy/Mkl3gv1y/NB1OL4Jhl7vQbf+kmgfQN2qdOVe2BOKQ8NlPUDmE<br>
+/1XNIDaE3s6uvUaoFfwowzsCCwN2/8QrRMMKkjvV+lEVtNmQdYxj5Xj5IwS0vkK0<br>
+6icsngW87cpZxxc1zsRWcSTloy5ohub4FgKhlolmigECgYEA+cBlxzLvaMzMlBQY<br>
+kCac9KQMvVL+DIFHlZA5i5L/9pRVp4JJwj3GUoehFJoFhsxnKr8HZyLwBKlCmUVm<br>
+VxnshRWiAU18emUmeAtSGawlAS3QXhikVZDdd/L20YusLT+DXV81wlKR97/r9+17<br>
+klQOLkSdPm9wcMDOWMNHX8bUg8kCgYEA8k+hQv6+TR/+Beao2IIctFtw/EauaJiJ<br>
+wW5ql1cpCLPMAOQUvjs0Km3zqctfBF8mUjdkcyJ4uhL9FZtfywY22EtRIXOJ/8VR<br>
+we65mVo6RLR8YVM54sihanuFOnlyF9LIBWB+9pUfh1/Y7DSebh7W73uxhAxQhi3Y<br>
+QwfIQIFd8OkCgYBalH4VXhLYhpaYCiXSej6ot6rrK2N6c5Tb2MAWMA1nh+r84tMP<br>
+gMoh+pDgYPAqMI4mQbxUmqZEeoLuBe6VHpDav7rPECRaW781AJ4ZM4cEQ3Jz/inz<br>
+4qOAMn10CF081/Ez9ykPPlU0bsYNWHNd4eB2xWnmUBKOwk7UgJatVPaUiQKBgQCI<br>
+f18CVGpzG9CHFnaK8FCnMNOm6VIaTcNcGY0mD81nv5Dt943P054BQMsAHTY7SjZW<br>
+HioRyZtkhonXAB2oSqnekh7zzxgv4sG5k3ct8evdBCcE1FNJc2eqikZ0uDETRoOy<br>
+s7cRxNNr+QxDkyikM+80HOPU1PMPgwfOSrX90GJQ8QKBgEBKohGMV/sNa4t14Iau<br>
+qO8aagoqh/68K9GFXljsl3/iCSa964HIEREtW09Qz1w3dotEgp2w8bsDa+OwWrLy<br>
+0SY7T5jRViM3cDWRlUBLrGGiL0FiwsfqiRiji60y19erJgrgyGVIb1kIgIBRkgFM<br>
+2MMweASzTmZcri4PA/5C0HYb<br>
+-----END PRIVATE KEY-----<br>
diff --git a/sample/sample-keys/client.p12 b/sample/sample-keys/client.p12<=
br>
new file mode 100644<br>
index 0000000000000000000000000000000000000000..8458c79770a08e832e10205ae1c=
43e8059cca082<br>
GIT binary patch<br>
literal 4533<br>
zcmV;m5lZebf)TL-0Ru3C5qAa&amp;Duzgg_YDCD0ic2rXas^0WH5peU@(FV7X}F`hDe6@<br>
z4FLxRpn?ntFoFyO0s#Opf(!iy2`Yw2hW8Bt2LUh~1_~;MNQU&lt;f0So~KFb)I=3Do?0Gd<br>
zI2*;=3D0s;sCfPxFqP42^P0Fo+4$NqJRddSJSl#H$YLRhM0*&gt;KZ1!3FrYzVTx;+~&lt;9X<=
br>
zHC&amp;0kC=3DQ)Zxu{oL`xLM;b_oD&gt;(X&amp;8Ta-#O3&amp;p;;Aa3+^0d5fSLOs3&gt;=
{(_@...1940...<br>
z2?mB_IU!{$1Sf&amp;CfNA0|znHybfRqP5blsg?Z{1w#hHzm2WPm@...1941...&gt;~Fs9L`8=
P!8d0*<br>
zf18!wochm&amp;3uJ;eC{gw3d+=3D?v`?TP`azbPA8uS#SvF&gt;zu7QrQ#$t&lt;4KatJksK&=
gt;dI*<br>
ziMISYR+%EK&lt;vdQWAH_&gt;GJw7P#F#ep~$fBbb6Y*_W)JH+UB%-XoF0lb%KM36b^Ml3z<br>
zdI#&gt;W)o{)xhylZ4OHKChQ3@...1942...{v(AQB@...1943...?ARCe`Ss=3DS%-q5T5+I3=
#R#G1YJlYRV<br>
zDTZ`@`U38{@bSL;&gt;xUioK!F94XIBfJNFiIhM&amp;9nvb{1l0O6GqR&amp;cLY4NFEuZS(D=
xH<br>
z=3DW!uJ(?gK8gs^*{5_cl5Z(=3DwW&amp;Q)XqS-~&gt;m0O$kp(m_Cz&gt;zwzHL-IYyDH=3D=
}xGVl+4<br>
zq3STnMt&lt;?Hu(MKc@...150...}O=3D+SOgwb9ciM@...1944...&gt;7Am$3#DF7{7%Lk3i=
mYa+y7?D;AsNHiG<br>
zn&lt;Pk&lt;=3D8L8O8bLSWTRMYjAr147E?9!=3D!8xCjW&amp;Rt}P1G4yKA2el8%Z#!i?O-I=
%bY3u<br>
ze}EeqFzNG`%%2`feCA2|669L4WH3axOzLsnR{2`^v?3Sf&gt;YdO(f@...1615...&lt;&amp;=
g*jh|95N+F<br>
zs_~5PPb?@91h)&amp;uXAR5t`&gt;ZG&gt;Uz4i)rF)c|;osz49745f=3D)!}UDtm5M!ZPf8NH=
f-q<br>
zBu9VT(aN+vpUdkJ*gO8FPMV2QD1&amp;zIpdi0sGch)W2;I$z%}w_LA6?gziR|D2-^A$7<br>
zK+7hz{knM@...1945...{VXU4Jr29-tm$-2M^&gt;mnD_r5Lj&gt;iwRX!&lt;9CFRg<br>
z9{(YStoDvOuR@(O4i9CiwMU(U-1=3DC!cAqZ-t@...1946...)@bc}<br>
zgo@...1947...=3DMyVE1)F@...1948...()zN_MxMHwJS(AR3ip3I+3Rm(|=3DOM&amp;()I9=
82?Ca-YME*$jcai<br>
z5&gt;TYla+%{gDkflN^F;$b#Qn!EsPXE?fs@...1644...=3DSd&lt;B``&lt;&lt;chZC5b5V=
FKbh2K6kY7?K3;<br>
zv5_F`(^P~!G1NikPncT9r#;SmMJ@...1949...%Prj#Uc{m7xeQANV0K8+ojXQSMT1t*R&amp;=
uV`S<br>
z-a_ZWh-DQno_e$da&gt;VMjI=3Dw_}8&amp;SK!u012g&gt;$5F;owS&gt;RW$?|5{~rl&amp;=
$f}d%d&gt;$9i<br>
z7(P0*PhMARQef&amp;fdz)sTC&lt;Lxa5`F2&amp;hqQLcJp#ikxf;udtXqUu6cOT-BO(BK`7h=
=3D?<br>
zDbI?zgxg*~0$om9lkR)a-7%wHj&amp;G~`U*39UJOt~jxs$VpQaqb)Y!11&lt;7NJ;nxwK+f<b=
r>
zimu&gt;$;%$WGWRFUiOQ+WO;A%{B*ZINIEs08%b-Fb1;6M5Z&lt;_`ge4ELfx*V8?Qo?OBP<br>
zB&lt;m3&amp;JH7$rGqlacJDUb4J^aF+$1F5Fq1BEWLf~B?AU5ccNREIEhWWFpY~t?SmGZi!<b=
r>
z+_Bv45Wnp@^L9d#ov%dRyPva3GUZyOBKdi&amp;t0zyQ-jp*M&amp;n!&lt;8&gt;?YAsG0gnH=
9&lt;Z0S<br>
z34D1$5L-hatRI$@6j43xOX~=3DUe!pzJ_)e*2;oPP-Jt%B~H*490;ChZmyCq4v3R}?{<br>
zc%U{&amp;f8?Nh&amp;k&gt;6b5g@&gt;h2#}&amp;DOvoiL8%)&lt;~q7ehzHh_`~a2Izn=3D=
bjHq;TkMIoDt-)<br>
z$u8yg;zHv$;?HL0J6h2aH`EK&gt;az+?|SAZS7*?6)?BsZ8yxec)dO^fx~b|xRBKv@!&gt;<br>
zN|H@...1594...@OZPg_&lt;ybv-HNQS5$N@=3DJ{hvL&lt;!M_~BR7$uR)1P?SUJk^fttz^d1=
%ND_VN$$<br>
z28yu4B=3D;NI-W7y*sy2dS6^$EJ{)yWxMf7wfvI_wsZ89XZlK~8n%r4)^eonEw2DGo~<br>
zjKS~WOnU}9sPh2P#+I2oX4TWo2NAs$hrb8{T^kZeI@...1611...}Jtc8o?@wh2ORT%pAFfSL4=
<br>
zF1~~3hhzo^be)F{&gt;Xe6%y9Pyj1HI_jCpGGJ+r}qJ(Qm^(w#q#n4;fGT9J)MId6%;&amp;<b=
r>
zhPes$n_zQIQ!}^}4G`^Wz7CGC@!ARFDKj^9@...1950...!~Q664CYzu=3D8Ev-yow*fp9UOsL=
HG<br>
z-BX&lt;D-hZ6KxIA%F5~CWcz|%QmBCt0vMQK#PYY9XsaJ3(}e;=3DlyMTDz8NEu@...1951...=
<br>
zBTx_4BwT-RH%(I350dV3ea|XNP6YEOFyDzqfWrv_j6~`PF4!_puV5C_RkWVl#=3DLzN<br>
zCn~sV+ht*A?D_2ZTy;=3DF_fv8&lt;_4f`NjG$iQJ`jYg1O#mw4EYb0Mh#@$sjRlQkKJQo<br>
zCbD(tZmv8Qv$&amp;NNhSgU}$`rTnqcvf`wxr^&amp;C&amp;;Fp=3D5Yh`(eE{7KCj6?xingF=
o(wqh<br>
zsvrza+Q&gt;cmrr~=3D}pV&lt;`ImbU@...1952...;g_=3D@...1993...)XeuKL1x92`ruL2r&amp;K(c=
t*Kk@...1953...<br>
zG_=3D`43h3M^{O*UA{yi2s5fjtWXMOov&gt;#rUwy(A49RjMsrwLLq&gt;wy(A6bJnieJpm*K<=
br>
zLL!(_!FKzh-$!YZdEcBK1F(&gt;@we-M9%w^x#=3DH#}9Lc8NQ&lt;BjftBjnh4ar}b3i+vXc<=
br>
z{W&gt;X2580FRsm3z}$v|1;BqjKiO00Ft{;FSiOWy|y=3D&amp;D|&gt;#PfODLKzOym9LWY;M=
#(=3D<br>
z`T4NzCiGy4Je$gf+HwRg2c&lt;5NBvatkd&lt;oeEbqXy8^TV#bM^e&amp;RCYW(w9gO&amp;y=
YjX5?<br>
z%nQKFIXw{H7UJzU&gt;mb+(-NL)S&lt;-&amp;!Jq+i&gt;}L3McC!=3D`WXZgNw}W3)t-k4o9=
(UzHmA<br>
zq`4KU&amp;&amp;3!B$jn*}C9IgPAZDOKa4d3Z!m^&gt;&lt;O=3DW&amp;A+i&gt;_uvW(Gg?=
u{!Zc28~KnlZY|<br>
zW&gt;&lt;Tb!KwKt8QoTnbcG?7D028`)ggh1eeM8r@...1954...%|k0fBmAmT5c(1mQ9lEXQ5=
OXd?;<br>
z^CHjw%k!RCxFaT~aUa_d{oq#QOssTE3&lt;rMFyeZ`^PjPynYR_KVSN@...1955...#b&gt;Ou=
f<br>
zWGfR@...1956...$;AzQkfiya1EQ_&gt;+Bl-?jKt}^_7hPmkxyS@...1957...~^h=3D708E3=
`{=3DWth%v-<br>
z?@iOBIjVj4-#bcG%9d)#)&gt;ITY*E8dBUmpjRV)C+&gt;Jt32pJ`o-1#&gt;e3Um|*mUJl)zl=
<br>
zzj+A{saen+`EP}bD_BH@...1958...(cb-`Ha9p{rll@#k}4#rAwI;U5&amp;{_(dvPfry4r*O=
R(g<br>
zir1=3D%D70&lt;3l-Vmdno7L-k9AWle8;LS6163q{gLq&lt;MLcS_5kCD+V@...1959...)Z4K=
_T+}0D<br>
z^did?rKv`zAu@...1960...}c$!y9^Lh|+tz8}+Z%B~F4O}J=3Da=3D6}v&gt;ZK?WsvR6Z`rz=
Hr@&lt;!Tg<br>
zr!DhMH=3D-r9Uq71K!AtPC3zo{oX3n#EYevQcL9~(v;6h5Pq%J*^gs-6!fq3Gog$&lt;8b<br>
z9g5=3DS4zlZ?y%K!&gt;Mc&amp;6F6kj#?qqpe;SHD(h=3D!j(z@^CR=3Di=3DKDGw&gt;Bgok=
qi9zPX(uX<br>
z|8`K|fAgElC|rkyhB5@...1961...+@}LZAfPl$+hDkByi%)V5=3DIaI1H{6vl7?ZBye!AqHLi=
cO<br>
zaCsg%BIm|&gt;MA3R@|GjKRc3d&amp;Xa4bb&gt;L3UelPWRoILk&amp;ICGoo4lwV@...1994...=
...{{fLLaZL&amp;+<br>
znSPhW04KckjD)a}19&gt;2aT|WH_ltW=3Dy7#46Gu!-xzwtb6TmG$I_MlQkGWG4!7F2!_C<br>
z^ngv5DN5VpziF0tnU2m8BpCW*8j$_TsVU%Wf(C_FTqJpP%DVRx*1n=3DyY6jVZP^~&amp;u<br>
zj+O&lt;-)gVFOKz}2cqLfZKD1W%|44A(?o?C-zVkbOT+V1eU!Th4e58g?qy0IDLgSs@(<br>
z&gt;a3QZ_~$!6a_yYA03n@...1963...;&amp;JCvDXIMz74j$40}k$6D5*AIe~-NPq&gt;l=
=3Dp{+`{qB*E<br>
z)dA_uyb!%xms+1|*hgXfvXAI&amp;FoFd^1_&gt;&amp;LNQU&lt;f0S5t~f(0@...1964...(=
0%xf(0rtf(0f9<br>
z3o3?4hW8Bt3&lt;?1Ppn?SMFoFc?FdPO7Duzgg_YDCI0Ru1&amp;1PH71K9D&amp;o|1tss2ml=
0v<br>
z1jw3_VuA6wE@...1965...*qp8m7%=3D&gt;t!ahU6DY&lt;c$m^W{&amp;SL-}Av-!V6Mej({=
Vh^I65-r7&gt;jl<br>
zj#2E$@cqS#ot;itB65=3D}T$c#Fvn6&gt;(Hu7jv5#?nqND^i{&lt;zGDn+bGDInORh%$|&lt;=
TU<br>
z)0ArgXLA;(_k}K_mlCfE0Y&amp;Ec4gxI|biRQj4^q@...1966...&gt;4Z%&gt;zfnT?a?P&g=
t;WmWgPqNu<br>
zt;=3D6U3*t&gt;n)oqy#bC&lt;px2zJip8afy*7*z$B{ma3e57nY2u4{E__iFC0=3DvmJwi1VY=
X<br>
zJ^u9%A=3DRjf0y-*9fV{WtT;tb1T0|T~;c%SH5qJ2+_GKkn#{LX}MbS`UJ+#@hq#_P@<br>
z=3DVN$u@...1967...|?(z7UQ*UT5!yd!df-`=3D;Pg3G;+}!@XBTK@(XtDanPon_36N?ceJ&l=
t;?w0<br>
zNK3soS#I5O8%nUS5XWVt%LptQsfi0a{wtPGi{fq;)jwb;5tx!nQZ5RBwItDChWNTA<br>
zj&gt;Fo89J#H&amp;5w(j6)Gb05d4Wuav-;Ae*N4CvCH7Bf7qsT7$-eiNbQFjxma-5lFy&amp;=
Kf<br>
zuGdIbq=3DSxP#B5y9i$6kWIXa%j=3D^H(Q8&lt;&lt;q_M*`R%ZVP8(B}EBCF@...1968...?w=
<br>
z@...1969...$yFWg(e-HC0;102vJ;ImFQO7@...1970...&lt;i79$sGU(S!1~*(w+q4OwO-ox=
<br>
zWwM2kH5?dxWXufo3Q9ZIy_U`Ql+5rjkKA=3DC7U__H&lt;)N5z$Rb{}rn?dsvsv@...1971...=
=3D&lt;<br>
zU%-OKA3|-2osy2Vwh#)*s+9to&lt;L%b6U5k5Fzx|JW;HHBRq|s|t(&amp;(g4xMFzgvvtbc<b=
r>
zQ-TBf=3DdLqXp&gt;pKX1|T1Ncg_%F+OOU1K%=3DlJvk25edtPll^?C8iOY4l+gHVw-jwS{5<b=
r>
zc1H%A0AcxAK4?I%10%GT9KyndW;=3DS4Hs$Bt3ppdV?5;*?C+IU&gt;_jrB|%iA@^j-Ydr<br>
zP#Vq!z4lf1B59em!RbNV^|P^F7)gXU({v-B^T{ObdazrO(+w5OWS;WuWNRLYYIn{T<br>
z*P_`Mm4F+5C)d0&amp;C_P&amp;q3l;Vwjmo9lrsR8}rTM}q1!7wAp-KZ++#udhr|@C8HVGgC<=
br>
z^(J(&lt;tv$K47&lt;r2(#bphive7uMRA&amp;}ky@...1972...~lV4``Zu%!1BUIf_Z=3D)*=
`CBf-+5F<br>
zTyVg}@k=3D0bc9s}%M9iRHnOdEO4AU3z0GZg~26X=3D;y_v(F&amp;Px}&amp;8ufGahoEQe_&=
gt;Wa-<br>
zy{M9YD^`ZYTH01LwfQ?{ZuZQ~vaO&amp;Jq$O&amp;~PN%MO(9m%~EMFTMC(A&amp;MRujojT{=
YuB<br>
z`u5e(@~&lt;aXbTu5Xpgn-u0;$_2;&amp;dZV4?%UszI6qIM+zSz-&gt;|Ph&lt;&lt;tw;;-I=
!bhQUfx<br>
z-T|#dTHlxbD@...1554...~1qB#O+9=3DPN}23-_|*ehcIXa5a)&gt;w_vbRv_LVvmsQhWA5OY=
qtUvR<br>
zb2`hE@&gt;8knqkGmwqPuasz=3DMUx2NN7PM|$lkN60Vj_=3D3UYPS&lt;Wb*D(aS{nk}POUoc=
h<br>
z5&lt;OVHe&amp;P&lt;YCYq5dQgsKygF+90&gt;r6ZIGje(Qd3rIw(m)l~LebaOD9`;d#2Rt&g=
t;_%?X|<br>
z;FA9GDiVuwAnk9Bh!BAEfMz{Mdq$b`Xzrmam}W60Fe3&amp;DDuzgg_YDCF6)_eB6jtCP<br>
zdB1(YHnjhMGVV2R_)j7)j4&amp;}UAutIB1uG5%0vZJX1Qaaz-GykChO4Gdh~Eic3wrIs<br>
TMJxme++Sbdrv3y90s;sCVF#Wx<br>
<br>
literal 0<br>
HcmV?d00001<br>
<br>
diff --git a/sample/sample-keys/dh1024.pem b/sample/sample-keys/dh1024.pem<=
br>
deleted file mode 100644<br>
index 7ce05f0..0000000<br>
--- a/sample/sample-keys/dh1024.pem<br>
+++ /dev/null<br>
@@ -1,5 +0,0 @@<br>
------BEGIN DH PARAMETERS-----<br>
-MIGHAoGBAJ419DBEOgmQTzo5qXl5fQcN9TN455wkOL7052HzxxRVMyhYmwQcgJvh<br>
-1sa18fyfR9OiVEMYglOpkqVoGLN7qd5aQNNi5W7/C+VBdHTBJcGZJyyP5B3qcz32<br>
-9mLJKudlVudV0Qxk5qUJaPZ/xupz0NyoVpviuiBOI1gNi8ovSXWzAgEC<br>
------END DH PARAMETERS-----<br>
diff --git a/sample/sample-keys/dh2048.pem b/sample/sample-keys/dh2048.pem<=
br>
new file mode 100644<br>
index 0000000..8eda59a<br>
--- /dev/null<br>
+++ b/sample/sample-keys/dh2048.pem<br>
@@ -0,0 +1,8 @@<br>
+-----BEGIN DH PARAMETERS-----<br>
+MIIBCAKCAQEArdnA32xujHPlPI+jPffHSoMUZ+b5gRz1H1Lw9//Gugm5TAsRiYrB<br>
+t2BDSsMKvAjyqN+i5SJv4TOk98kRRKB27iPvyXmiL945VaDQl/UehCySjYlGFUjW<br>
+9nuo+JwQxeSbw0TLiSYoYJZQ8X1CxPl9mgJl277O4cW1Gc8I/bWa+ipU/4K5wv3h<br>
+GI8nt+6A0jN3M/KebotMP101G4k0l0qsY4oRMTmP+z3oAP0qU9NZ1jiuMFVzRlNp<br>
+5FdYF7ctrH+tBF+QmyT4SRKSED4wE4oX6gp420NaBhIEQifIj75wlMDtxQlpkN+x<br>
+QkjsEbPlaPKHGQ4uupssChVUi8IM2yq5EwIBAg=3D=3D<br>
+-----END DH PARAMETERS-----<br>
diff --git a/sample/sample-keys/ec-ca.crt b/sample/sample-keys/ec-ca.crt<br>
deleted file mode 100644<br>
index e190801..0000000<br>
--- a/sample/sample-keys/ec-ca.crt<br>
+++ /dev/null<br>
@@ -1,13 +0,0 @@<br>
------BEGIN CERTIFICATE-----<br>
-MIIB4jCCAWmgAwIBAgIJALGEGB2g6cAXMAoGCCqGSM49BAMCMBUxEzARBgNVBAMT<br>
-CkVDLVRlc3QgQ0EwHhcNMTQwMTE4MTYwMTUzWhcNMjQwMTE2MTYwMTUzWjAVMRMw<br>
-EQYDVQQDEwpFQy1UZXN0IENBMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAE2S4AZT7j<br>
-ZlPG/CXpT12CzCNSySyKmJt+fWyW/wzbRulVJpGHXRHpZZj2VNOUE72kqGUeshh6<br>
-Um1o7lHGDSAkHOJpeW5FtryiKhwFc+4dsOCLTNLVFXQsEtY3gY14Uquio4GEMIGB<br>
-MB0GA1UdDgQWBBS0mkFcuCZ8SLWZRAD/8LpBQcgGPDBFBgNVHSMEPjA8gBS0mkFc<br>
-uCZ8SLWZRAD/8LpBQcgGPKEZpBcwFTETMBEGA1UEAxMKRUMtVGVzdCBDQYIJALGE<br>
-GB2g6cAXMAwGA1UdEwQFMAMBAf8wCwYDVR0PBAQDAgEGMAoGCCqGSM49BAMCA2cA<br>
-MGQCMHWlVTi0xNZstR8ZNH+7z0WlyIXyZe23ne3EXkO0thZLdv86kpxFMPW/llB+<br>
-RMRKuQIweN97n7FQy5DTenr91U98KDFJ5Av4mDFRL1mkXiu3W1//4XD8yEYDQTRz<br>
-/GARuOLL<br>
------END CERTIFICATE-----<br>
diff --git a/sample/sample-keys/ec-ca.key b/sample/sample-keys/ec-ca.key<br>
deleted file mode 100644<br>
index 51a72e1..0000000<br>
--- a/sample/sample-keys/ec-ca.key<br>
+++ /dev/null<br>
@@ -1,6 +0,0 @@<br>
------BEGIN PRIVATE KEY-----<br>
-MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDASU6X/mh2m2PayviL3<br>
-teoml5soyIUcZfwZpVn6oNtnrLcAbIRsAJbM4xyGVp77G/6hZANiAATZLgBlPuNm<br>
-U8b8JelPXYLMI1LJLIqYm359bJb/DNtG6VUmkYddEellmPZU05QTvaSoZR6yGHpS<br>
-bWjuUcYNICQc4ml5bkW2vKIqHAVz7h2w4ItM0tUVdCwS1jeBjXhSq6I=3D<br>
------END PRIVATE KEY-----<br>
diff --git a/sample/sample-keys/ec-client.crt b/sample/sample-keys/ec-clien=
t.crt<br>
deleted file mode 100644<br>
index b797b02..0000000<br>
--- a/sample/sample-keys/ec-client.crt<br>
+++ /dev/null<br>
@@ -1,61 +0,0 @@<br>
-Certificate:<br>
-=C2=A0 =C2=A0 Data:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Version: 3 (0x2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Serial Number: 2 (0x2)<br>
-=C2=A0 =C2=A0 Signature Algorithm: ecdsa-with-SHA256<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Issuer: CN=3DEC-Test CA<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Validity<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not Before: Jan 18 16:02:37 2014=
 GMT<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not After : Jan 16 16:02:37 2024=
 GMT<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subject: CN=3Dec-client<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subject Public Key Info:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Public Key Algorithm: id-ecPubli=
cKey<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Public-Key: (384 b=
it)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pub:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 04:4=
0:d9:b9:a2:44:1b:01:39:2c:14:ee:aa:70:6b:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 31:9=
8:28:44:c9:61:bc:b7:0b:b5:53:49:c2:c0:0a:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 43:b=
0:08:50:cd:80:2f:5d:a4:89:f1:ff:7d:11:78:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f5:0=
c:b2:86:e2:59:f8:17:76:1b:22:f2:23:67:e7:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 55:9=
0:ea:ce:0a:aa:da:05:f4:85:19:c9:ed:ae:6d:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a3:a=
d:56:7a:f6:33:c6:cf:bb:c7:39:fa:e4:d3:67:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 df:f=
0:b8:4a:88:57:98<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASN1 OID: secp384r=
1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 extensions:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Basic Constraints:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CA:FALSE<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Subject Key Identifier:<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 D8:E2:35:7B:CA:66:=
71:6B:D8:5B:F5:12:13:82:2D:ED:CD:E5:ED:7F<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Authority Key Identifier:=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyid:B4:9A:41:5C:=
B8:26:7C:48:B5:99:44:00:FF:F0:BA:41:41:C8:06:3C<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DirName:/CN=3DEC-T=
est CA<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial:B1:84:18:1D=
:A0:E9:C0:17<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Extended Key Usage:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TLS Web Client Aut=
hentication<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Key Usage:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Digital Signature<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Netscape Comment:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Easy-RSA Generated=
 Certificate<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Netscape Cert Type:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SSL Client<br>
-=C2=A0 =C2=A0 Signature Algorithm: ecdsa-with-SHA256<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A030:64:02:30:41:8b:1a:fd:97:a8:bb:7c:d0:e=
b:1c:a2:ba:c0:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ac:2f:6d:80:07:5b:5c:ef:55:59:1a:92:56:6=
6:94:ce:49:6a:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a9:57:49:b2:41:73:64:7e:01:ac:31:3a:7c:2=
a:bf:a5:02:30:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02b:c4:a6:b1:0c:03:82:e3:e4:03:39:fb:19:d=
7:76:21:1b:7e:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07f:aa:22:5d:90:a4:e1:2e:cd:ca:92:0f:b6:3=
f:80:dc:26:d2:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A009:34:8c:d1:61:bb:9d:ac:6d:8f:68:f0<br>
------BEGIN CERTIFICATE-----<br>
-MIICLTCCAbSgAwIBAgIBAjAKBggqhkjOPQQDAjAVMRMwEQYDVQQDEwpFQy1UZXN0<br>
-IENBMB4XDTE0MDExODE2MDIzN1oXDTI0MDExNjE2MDIzN1owFDESMBAGA1UEAxMJ<br>
-ZWMtY2xpZW50MHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEQNm5okQbATksFO6qcGsx<br>
-mChEyWG8twu1U0nCwApDsAhQzYAvXaSJ8f99EXj1DLKG4ln4F3YbIvIjZ+dVkOrO<br>
-CqraBfSFGcntrm2jrVZ69jPGz7vHOfrk02ff8LhKiFeYo4HYMIHVMAkGA1UdEwQC<br>
-MAAwHQYDVR0OBBYEFNjiNXvKZnFr2Fv1EhOCLe3N5e1/MEUGA1UdIwQ+MDyAFLSa<br>
-QVy4JnxItZlEAP/wukFByAY8oRmkFzAVMRMwEQYDVQQDEwpFQy1UZXN0IENBggkA<br>
-sYQYHaDpwBcwEwYDVR0lBAwwCgYIKwYBBQUHAwIwCwYDVR0PBAQDAgeAMC0GCWCG<br>
-SAGG+EIBDQQgFh5FYXN5LVJTQSBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwEQYJYIZI<br>
-AYb4QgEBBAQDAgeAMAoGCCqGSM49BAMCA2cAMGQCMEGLGv2XqLt80OscorrArC9t<br>
-gAdbXO9VWRqSVmaUzklqqVdJskFzZH4BrDE6fCq/pQIwK8SmsQwDguPkAzn7Gdd2<br>
-IRt+f6oiXZCk4S7NypIPtj+A3CbSCTSM0WG7naxtj2jw<br>
------END CERTIFICATE-----<br>
diff --git a/sample/sample-keys/ec-client.key b/sample/sample-keys/ec-clien=
t.key<br>
deleted file mode 100644<br>
index 60636ed..0000000<br>
--- a/sample/sample-keys/ec-client.key<br>
+++ /dev/null<br>
@@ -1,6 +0,0 @@<br>
------BEGIN PRIVATE KEY-----<br>
-MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDD9Agj8nr/8sIr0XHky<br>
-mcn1oMb3vqOh2axFBaIvmOHYmqs11SIH1tKYelkNYy9zHTChZANiAARA2bmiRBsB<br>
-OSwU7qpwazGYKETJYby3C7VTScLACkOwCFDNgC9dpInx/30RePUMsobiWfgXdhsi<br>
-8iNn51WQ6s4KqtoF9IUZye2ubaOtVnr2M8bPu8c5+uTTZ9/wuEqIV5g=3D<br>
------END PRIVATE KEY-----<br>
diff --git a/sample/sample-keys/ec-server.crt b/sample/sample-keys/ec-serve=
r.crt<br>
deleted file mode 100644<br>
index 9999472..0000000<br>
--- a/sample/sample-keys/ec-server.crt<br>
+++ /dev/null<br>
@@ -1,61 +0,0 @@<br>
-Certificate:<br>
-=C2=A0 =C2=A0 Data:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Version: 3 (0x2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Serial Number: 1 (0x1)<br>
-=C2=A0 =C2=A0 Signature Algorithm: ecdsa-with-SHA256<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Issuer: CN=3DEC-Test CA<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Validity<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not Before: Jan 18 16:02:31 2014=
 GMT<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not After : Jan 16 16:02:31 2024=
 GMT<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subject: CN=3Dec-server<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subject Public Key Info:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Public Key Algorithm: id-ecPubli=
cKey<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Public-Key: (384 b=
it)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pub:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 04:b=
d:8c:3a:af:2e:2f:2e:de:cf:d2:39:8d:b9:a6:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 13:9=
6:80:6d:b5:b2:ee:97:62:3b:a2:32:38:77:1e:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fb:2=
a:ef:86:4b:d0:9e:4b:55:e0:9b:07:f9:64:2f:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6b:a=
7:17:fd:65:dd:50:3f:1c:fa:fa:2f:39:2e:97:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d4:8=
6:e5:4e:5a:d2:50:0b:f4:d7:08:62:67:53:44:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 62:e=
3:25:f2:fa:36:84:87:1d:03:e3:e9:9d:d9:66:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 51:d=
d:b4:c4:db:0b:05<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASN1 OID: secp384r=
1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 extensions:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Basic Constraints:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CA:FALSE<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Subject Key Identifier:<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EA:DF:7E:A3:D4:61:=
73:D7:01:AF:6E:0A:38:8D:33:D0:BD:24:4B:E1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Authority Key Identifier:=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyid:B4:9A:41:5C:=
B8:26:7C:48:B5:99:44:00:FF:F0:BA:41:41:C8:06:3C<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DirName:/CN=3DEC-T=
est CA<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial:B1:84:18:1D=
:A0:E9:C0:17<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Extended Key Usage:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TLS Web Server Aut=
hentication<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Key Usage:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Digital Signature,=
 Key Encipherment<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Netscape Comment:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Easy-RSA Generated=
 Certificate<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Netscape Cert Type:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SSL Server<br>
-=C2=A0 =C2=A0 Signature Algorithm: ecdsa-with-SHA256<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A030:64:02:30:20:39:12:92:cc:a2:ca:45:b9:1=
a:8f:e0:c1:e7:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b7:4a:79:4d:07:07:81:72:08:b4:d4:7b:46:5=
3:d7:72:32:d0:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d7:3e:e8:88:2b:c9:ba:8b:d5:94:4f:41:6c:d=
0:2e:a4:02:30:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A075:ff:c3:8a:c1:f5:79:1c:1a:08:16:31:c2:c=
1:6e:d4:33:dc:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A09f:04:0f:90:94:d9:75:c1:6d:71:28:62:cc:f=
6:89:7c:91:86:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a4:96:45:34:a0:8d:92:7e:dd:e3:da:4d<br>
------BEGIN CERTIFICATE-----<br>
-MIICLTCCAbSgAwIBAgIBATAKBggqhkjOPQQDAjAVMRMwEQYDVQQDEwpFQy1UZXN0<br>
-IENBMB4XDTE0MDExODE2MDIzMVoXDTI0MDExNjE2MDIzMVowFDESMBAGA1UEAxMJ<br>
-ZWMtc2VydmVyMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEvYw6ry4vLt7P0jmNuaYT<br>
-loBttbLul2I7ojI4dx77Ku+GS9CeS1Xgmwf5ZC9rpxf9Zd1QPxz6+i85LpfUhuVO<br>
-WtJQC/TXCGJnU0Ri4yXy+jaEhx0D4+md2WZR3bTE2wsFo4HYMIHVMAkGA1UdEwQC<br>
-MAAwHQYDVR0OBBYEFOrffqPUYXPXAa9uCjiNM9C9JEvhMEUGA1UdIwQ+MDyAFLSa<br>
-QVy4JnxItZlEAP/wukFByAY8oRmkFzAVMRMwEQYDVQQDEwpFQy1UZXN0IENBggkA<br>
-sYQYHaDpwBcwEwYDVR0lBAwwCgYIKwYBBQUHAwEwCwYDVR0PBAQDAgWgMC0GCWCG<br>
-SAGG+EIBDQQgFh5FYXN5LVJTQSBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwEQYJYIZI<br>
-AYb4QgEBBAQDAgZAMAoGCCqGSM49BAMCA2cAMGQCMCA5EpLMospFuRqP4MHnt0p5<br>
-TQcHgXIItNR7RlPXcjLQ1z7oiCvJuovVlE9BbNAupAIwdf/DisH1eRwaCBYxwsFu<br>
-1DPcnwQPkJTZdcFtcShizPaJfJGGpJZFNKCNkn7d49pN<br>
------END CERTIFICATE-----<br>
diff --git a/sample/sample-keys/ec-server.key b/sample/sample-keys/ec-serve=
r.key<br>
deleted file mode 100644<br>
index bb3cdf1..0000000<br>
--- a/sample/sample-keys/ec-server.key<br>
+++ /dev/null<br>
@@ -1,6 +0,0 @@<br>
------BEGIN PRIVATE KEY-----<br>
-MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDD8bQlwrFrXHPmem0bt<br>
-cBcU6nYfaZQbPdIDAB7edOOyevvzYH0qMtbaW95iSZLMRVWhZANiAAS9jDqvLi8u<br>
-3s/SOY25phOWgG21su6XYjuiMjh3Hvsq74ZL0J5LVeCbB/lkL2unF/1l3VA/HPr6<br>
-Lzkul9SG5U5a0lAL9NcIYmdTRGLjJfL6NoSHHQPj6Z3ZZlHdtMTbCwU=3D<br>
------END PRIVATE KEY-----<br>
diff --git a/sample/sample-keys/gen-sample-keys.sh b/sample/sample-keys/gen=
-sample-keys.sh<br>
new file mode 100755<br>
index 0000000..87bde1d<br>
--- /dev/null<br>
+++ b/sample/sample-keys/gen-sample-keys.sh<br>
@@ -0,0 +1,74 @@<br>
+#!/bin/sh<br>
+#<br>
+# Run this script to set up a test CA, and test key-certificate pair for a=
<br>
+# server, and various clients.<br>
+#<br>
+# Copyright (C) 2014 Steffan Karger &lt;<a href=3D"mailto:steffan@...1995...=
..">steffan@...1856...</a>&gt;<br>
+set -eu<br>
+<br>
+if [ ! -f openssl.cnf ]<br>
+then<br>
+=C2=A0 =C2=A0 echo &quot;Please run this script from the sample directory&=
quot;<br>
+=C2=A0 =C2=A0 exit 1<br>
+fi<br>
+<br>
+# Create required directories and files<br>
+mkdir -p sample-ca<br>
+rm -f sample-ca/index.txt<br>
+touch sample-ca/index.txt<br>
+echo &quot;01&quot; &gt; sample-ca/serial<br>
+<br>
+# Generate CA key and cert<br>
+openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 \<br>
+=C2=A0 =C2=A0 -extensions easyrsa_ca -keyout sample-ca/ca.key -out sample-=
ca/ca.crt \<br>
+=C2=A0 =C2=A0 -subj &quot;/C=3DKG/ST=3DNA/L=3DBISHKEK/O=3DOpenVPN-TEST/ema=
ilAddress=3Dme@...430...&quot; \<br>
+=C2=A0 =C2=A0 -config openssl.cnf<br>
+<br>
+# Create server key and cert<br>
+openssl req -new -nodes -config openssl.cnf -extensions server \<br>
+=C2=A0 =C2=A0 -keyout sample-ca/server.key -out sample-ca/server.csr \<br>
+=C2=A0 =C2=A0 -subj &quot;/C=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Serve=
r/emailAddress=3Dme@...430...&quot;<br>
+openssl ca -batch -config openssl.cnf -extensions server \<br>
+=C2=A0 =C2=A0 -out sample-ca/server.crt -in sample-ca/server.csr<br>
+<br>
+# Create client key and cert<br>
+openssl req -new -nodes -config openssl.cnf \<br>
+=C2=A0 =C2=A0 -keyout sample-ca/client.key -out sample-ca/client.csr \<br>
+=C2=A0 =C2=A0 -subj &quot;/C=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Clien=
t/emailAddress=3Dme@...430...&quot;<br>
+openssl ca -batch -config openssl.cnf \<br>
+=C2=A0 =C2=A0 -out sample-ca/client.crt -in sample-ca/client.csr<br>
+<br>
+# Create password protected key file<br>
+openssl rsa -aes256 -passout pass:password \<br>
+=C2=A0 =C2=A0 -in sample-ca/client.key -out sample-ca/client-pass.key<br>
+<br>
+# Create pkcs#12 client bundle<br>
+openssl pkcs12 -export -nodes -password pass:password \<br>
+=C2=A0 =C2=A0 -out sample-ca/client.p12 -inkey sample-ca/client.key \<br>
+=C2=A0 =C2=A0 -in sample-ca/client.crt -certfile sample-ca/ca.crt<br>
+<br>
+<br>
+# Create EC server and client cert (signed by &#39;regular&#39; RSA CA)<br>
+openssl ecparam -out sample-ca/secp256k1.pem -name secp256k1<br>
+<br>
+openssl req -new -newkey ec:sample-ca/secp256k1.pem -nodes -config openssl=
.cnf \<br>
+=C2=A0 =C2=A0 -extensions server \<br>
+=C2=A0 =C2=A0 -keyout sample-ca/server-ec.key -out sample-ca/server-ec.csr=
 \<br>
+=C2=A0 =C2=A0 -subj &quot;/C=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Serve=
r-EC/emailAddress=3Dme@...430...&quot;<br>
+openssl ca -batch -config openssl.cnf -extensions server \<br>
+=C2=A0 =C2=A0 -out sample-ca/server-ec.crt -in sample-ca/server-ec.csr<br>
+<br>
+openssl req -new -newkey ec:sample-ca/secp256k1.pem -nodes -config openssl=
.cnf \<br>
+=C2=A0 =C2=A0 -keyout sample-ca/client-ec.key -out sample-ca/client-ec.csr=
 \<br>
+=C2=A0 =C2=A0 -subj &quot;/C=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Clien=
t-EC/emailAddress=3Dme@...430...&quot;<br>
+openssl ca -batch -config openssl.cnf \<br>
+=C2=A0 =C2=A0 -out sample-ca/client-ec.crt -in sample-ca/client-ec.csr<br>
+<br>
+# Generate DH parameters<br>
+openssl dhparam -out dh2048.pem 2048<br>
+<br>
+# Copy keys and certs to working directory<br>
+cp sample-ca/*.key .<br>
+cp sample-ca/*.crt .<br>
+cp sample-ca/*.p12 .<br>
+<br>
diff --git a/sample/sample-keys/openssl.cnf b/sample/sample-keys/openssl.cn=
f<br>
new file mode 100644<br>
index 0000000..aabfd48<br>
--- /dev/null<br>
+++ b/sample/sample-keys/openssl.cnf<br>
@@ -0,0 +1,139 @@<br>
+# Heavily borrowed from EasyRSA 3, for use with OpenSSL 1.0.*<br>
+<br>
+####################################################################<br>
+[ ca ]<br>
+default_ca=C2=A0 =C2=A0 =C2=A0=3D CA_default=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 # The default ca section<br>
+<br>
+####################################################################<br>
+[ CA_default ]<br>
+<br>
+dir=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D sample-ca=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Where everything is kept<br>
+certs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D $dir=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Where the issued certs are kept<br>
+crl_dir=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D $dir=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Where the iss=
ued crl are kept<br>
+database=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D $dir/index.txt=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # database index file.<br>
+new_certs_dir=C2=A0 =3D $dir=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 # default place for new certs.<br>
+<br>
+certificate=C2=A0 =C2=A0 =3D $dir/ca.crt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0# The CA certificate<br>
+serial=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D $dir/serial=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0# The current serial number<br>
+crl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D $dir/crl.pem=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 # The current CRL<br>
+private_key=C2=A0 =C2=A0 =3D $dir/ca.key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0# The private key<br>
+RANDFILE=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D $dir/.rand=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 # private random number file<br>
+<br>
+x509_extensions=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D basic_exts=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 # The extentions to add to the cert<br>
+<br>
+# This allows a V2 CRL. Ancient browsers don&#39;t like it, but anything E=
asy-RSA<br>
+# is designed for will. In return, we get the Issuer attached to CRLs.<br>
+crl_extensions =3D crl_ext<br>
+<br>
+default_days=C2=A0 =C2=A0=3D 3650=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 # how long to certify for<br>
+default_crl_days=3D 30=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0# how long before next CRL<br>
+default_md=C2=A0 =C2=A0 =C2=A0=3D sha256=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 # use public key default MD<br>
+preserve=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D no=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # keep passed DN ordering<br>
+<br>
+# A few difference way of specifying how similar the request should look<b=
r>
+# For type CA, the listed attributes must be the same, and the optional<br>
+# and supplied fields are just that :-)<br>
+policy=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D policy_anything<br>
+<br>
+# For the &#39;anything&#39; policy, which defines allowed DN fields<br>
+[ policy_anything ]<br>
+countryName=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D optional<br>
+stateOrProvinceName=C2=A0 =C2=A0 =3D optional<br>
+localityName=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D optional<br>
+organizationName=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D optional<br>
+organizationalUnitName =3D optional<br>
+commonName=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D supplied<br>
+name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D optional<br>
+emailAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D optional<br>
+<br>
+####################################################################<br>
+# Easy-RSA request handling<br>
+# We key off $DN_MODE to determine how to format the DN<br>
+[ req ]<br>
+default_bits=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 2048<br>
+default_keyfile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 privkey.pem<br>
+default_md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D sha256<br>
+distinguished_name=C2=A0 =C2=A0 =C2=A0=3D cn_only<br>
+x509_extensions=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 easyrsa_ca=C2=A0 =C2=A0 # The extentions to add to the self signed cert<br>
+<br>
+# A placeholder to handle the $EXTRA_EXTS feature:<br>
+#%EXTRA_EXTS%=C2=A0 # Do NOT remove or change this line as $EXTRA_EXTS sup=
port requires it<br>
+<br>
+####################################################################<br>
+# Easy-RSA DN (Subject) handling<br>
+<br>
+# Easy-RSA DN for cn_only support:<br>
+[ cn_only ]<br>
+commonName=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D Common Name =
(eg: your user, host, or server name)<br>
+commonName_max=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 64<br>
+commonName_default=C2=A0 =C2=A0 =C2=A0=3D changeme<br>
+<br>
+# Easy-RSA DN for org support:<br>
+[ org ]<br>
+countryName=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D Country Name (2 letter code)<br>
+countryName_default=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D KG<br>
+countryName_min=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D 2<br>
+countryName_max=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D 2<br>
+<br>
+stateOrProvinceName=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D State or =
Province Name (full name)<br>
+stateOrProvinceName_default=C2=A0 =C2=A0 =3D NA<br>
+<br>
+localityName=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D Locality Name (eg, city)<br>
+localityName_default=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D BISHKEK<b=
r>
+<br>
+0.organizationName=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D Orga=
nization Name (eg, company)<br>
+0.organizationName_default=C2=A0 =C2=A0 =C2=A0=3D OpenVPN-TEST<br>
+<br>
+organizationalUnitName=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D Organizational=
 Unit Name (eg, section)<br>
+organizationalUnitName_default =3D<br>
+<br>
+commonName=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D Common Name (eg: your user, host, or server name)<br>
+commonName_max=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D 64<br>
+commonName_default=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+<br>
+emailAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D Email Address<br>
+emailAddress_default=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D me@...1996...=
...<br>
+emailAddress_max=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 64<br>
+<br>
+####################################################################<br>
+<br>
+[ basic_exts ]<br>
+basicConstraints=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D CA:FALSE<br>
+subjectKeyIdentifier=C2=A0 =C2=A0=3D hash<br>
+authorityKeyIdentifier =3D keyid,issuer:always<br>
+<br>
+# The Easy-RSA CA extensions<br>
+[ easyrsa_ca ]<br>
+<br>
+# PKIX recommendations:<br>
+<br>
+subjectKeyIdentifier=3Dhash<br>
+authorityKeyIdentifier=3Dkeyid:always,issuer:always<br>
+<br>
+# This could be marked critical, but it&#39;s nice to support reading by a=
ny<br>
+# broken clients who attempt to do so.<br>
+basicConstraints =3D CA:true<br>
+<br>
+# Limit key usage to CA tasks. If you really want to use the generated pai=
r as<br>
+# a self-signed cert, comment this out.<br>
+keyUsage =3D cRLSign, keyCertSign<br>
+<br>
+# CRL extensions.<br>
+[ crl_ext ]<br>
+<br>
+# Only issuerAltName and authorityKeyIdentifier make any sense in a CRL.<b=
r>
+<br>
+# issuerAltName=3Dissuer:copy<br>
+authorityKeyIdentifier=3Dkeyid:always,issuer:always<br>
+<br>
+<br>
+# Server extensions.<br>
+[ server ]<br>
+<br>
+basicConstraints=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D CA:FALSE<br>
+nsCertType=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D server<br>
+nsComment=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;OpenSS=
L Generated Server Certificate&quot;<br>
+subjectKeyIdentifier=C2=A0 =C2=A0=3D hash<br>
+authorityKeyIdentifier =3D keyid,issuer:always<br>
+extendedKeyUsage=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D serverAuth<br>
+keyUsage=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D digital=
Signature, keyEncipherment<br>
diff --git a/sample/sample-keys/pass.crt b/sample/sample-keys/pass.crt<br>
deleted file mode 100644<br>
index 8bb7b17..0000000<br>
--- a/sample/sample-keys/pass.crt<br>
+++ /dev/null<br>
@@ -1,65 +0,0 @@<br>
-Certificate:<br>
-=C2=A0 =C2=A0 Data:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Version: 3 (0x2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Serial Number: 3 (0x3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Signature Algorithm: md5WithRSAEncryption<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Issuer: C=3DKG, ST=3DNA, L=3DBISHKEK, O=3DOpen=
VPN-TEST/emailAddress=3Dme@...430...<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Validity<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not Before: Nov 25 14:48:55 2004=
 GMT<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not After : Nov 23 14:48:55 2014=
 GMT<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subject: C=3DKG, ST=3DNA, O=3DOpenVPN-TEST, CN=
=3DTest-Client-Password/emailAddress=3Dme@...430...<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subject Public Key Info:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Public Key Algorithm: rsaEncrypt=
ion<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RSA Public Key: (1024 bit)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Modulus (1024 bit)=
:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 00:c=
a:b4:05:67:7b:51:c1:d2:fe:21:57:b1:a5:57:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5c:c=
0:86:38:05:a8:91:cf:e7:a4:bd:7a:76:d8:3b:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cf:f=
e:f3:78:65:24:d6:72:7d:1b:6d:b6:da:04:f2:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a8:f=
6:b4:04:78:d2:24:a7:21:2f:ca:29:46:96:0f:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0b:9=
1:31:66:1e:4d:22:9a:5d:05:17:99:9c:a0:7e:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e0:2=
a:be:78:0c:a1:b9:d4:04:c4:ec:f8:61:79:62:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b5:5=
2:2d:f5:41:af:db:9f:8c:ab:08:1b:b7:95:b8:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c1:f=
0:29:d3:da:fb:00:3f:8e:5c:27:e3:8d:fa:ee:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dc:b=
4:3b:0b:8b:e0:ab:c1:c1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Exponent: 65537 (0=
x10001)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 extensions:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Basic Constraints:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CA:FALSE<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Netscape Comment:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OpenSSL Generated =
Certificate<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Subject Key Identifier:<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 40:57:F1:8C:9C:86:=
B2:DA:E0:3F:A7:B8:D7:85:43:45:07:8A:40:73<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Authority Key Identifier:=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyid:89:A6:60:E3:=
BA:EA:3E:AF:FC:64:7F:4C:BD:8C:D2:48:8D:E0:CC:46<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DirName:/C=3DKG/ST=
=3DNA/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial:00<br>
-<br>
-=C2=A0 =C2=A0 Signature Algorithm: md5WithRSAEncryption<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 a5:79:72:7f:a2:08:28:8e:66:da:e1:d0:be:bb:97:3=
d:65:9f:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ab:1e:19:ac:f1:66:44:14:8f:4e:7c:eb:ea:1e:2f:5=
7:ea:44:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 46:4c:b9:56:5b:c0:0c:58:d2:45:87:26:6d:82:de:8=
c:64:b8:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 8b:22:61:61:c6:68:36:08:9d:5a:fd:2f:e5:21:e1:a=
2:0c:7f:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 3e:ca:e1:06:ea:9f:81:62:3d:a0:ce:f1:1e:0d:ab:8=
6:89:ed:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 9a:89:34:32:c9:e9:6d:7d:f5:11:c3:5d:7e:a5:f7:f=
1:a6:83:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 77:1b:94:67:d9:0f:5c:ac:0e:08:4a:88:98:65:49:e=
b:66:9e:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 2d:28<br>
------BEGIN CERTIFICATE-----<br>
-MIIDPjCCAqegAwIBAgIBAzANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL<br>
-MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t<br>
-VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy<br>
-NTE0NDg1NVoXDTE0MTEyMzE0NDg1NVowczELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
-Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxHTAbBgNVBAMTFFRlc3QtQ2xpZW50<br>
-LVBhc3N3b3JkMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wgZ8w<br>
-DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMq0BWd7UcHS/iFXsaVXXMCGOAWokc/n<br>
-pL16dtg7z/7zeGUk1nJ9G2222gTyqPa0BHjSJKchL8opRpYPC5ExZh5NIppdBReZ<br>
-nKB+4Cq+eAyhudQExOz4YXlitVIt9UGv25+Mqwgbt5W4wfAp09r7AD+OXCfjjfru<br>
-3LQ7C4vgq8HBAgMBAAGjge4wgeswCQYDVR0TBAIwADAsBglghkgBhvhCAQ0EHxYd<br>
-T3BlblNTTCBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwHQYDVR0OBBYEFEBX8YychrLa<br>
-4D+nuNeFQ0UHikBzMIGQBgNVHSMEgYgwgYWAFImmYOO66j6v/GR/TL2M0kiN4MxG<br>
-oWqkaDBmMQswCQYDVQQGEwJLRzELMAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hL<br>
-RUsxFTATBgNVBAoTDE9wZW5WUE4tVEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlo<br>
-b3N0Lm15ZG9tYWluggEAMA0GCSqGSIb3DQEBBAUAA4GBAKV5cn+iCCiOZtrh0L67<br>
-lz1ln6seGazxZkQUj0586+oeL1fqREZMuVZbwAxY0kWHJm2C3oxkuIsiYWHGaDYI<br>
-nVr9L+Uh4aIMfz7K4Qbqn4FiPaDO8R4Nq4aJ7ZqJNDLJ6W199RHDXX6l9/Gmg3cb<br>
-lGfZD1ysDghKiJhlSetmni0o<br>
------END CERTIFICATE-----<br>
diff --git a/sample/sample-keys/pass.key b/sample/sample-keys/pass.key<br>
deleted file mode 100644<br>
index 4916364..0000000<br>
--- a/sample/sample-keys/pass.key<br>
+++ /dev/null<br>
@@ -1,18 +0,0 @@<br>
------BEGIN RSA PRIVATE KEY-----<br>
-Proc-Type: 4,ENCRYPTED<br>
-DEK-Info: DES-EDE3-CBC,959F7365DBBFDB77<br>
-<br>
-nGm57l+rR/8dAZOHL/1x/6dt11zUca7rphjsgw6XRnSf3M/CWmHvHVjApWcNLEs5<br>
-SWNMp1xfUogtGzsKoMBbnlZLDA7RVHUYD6dVMyCpc64UjzT08LmdZhtQYLAKmlUC<br>
-PT1VXS4Ae+SrqCPUqJkw1xP3kr0F1EVCXNu0nhOBAuuTGOS7PPEyW2N+k4nRHtsR<br>
-IaPp8GCuIeoR6CdymTFTq6d/GeCiEcyrUM4BNrG4GtRRrURxxOrzQFEOS5sjBPSg<br>
-Km1lwa6zBQFRLg9dKjRBL4teKuPY5Z2Nmpcml/aN4CkdkVEso4lW6/UHLE/joOMQ<br>
-0MdpdYtu8wnt1WI/Z4immQfl3MF+QcPMkqXXzCEhGG/5SbAo89KC46UXvu1Z5OhS<br>
-8XFHhvYBivOYWgZ3XUQqyZ0ulF60mFX7aE1Ph/eEbhWBHmU39hGjxzop1UoPwqLx<br>
-ahvtfvCkR3ZeqlWO9SHzCA3MlrKwQ1p1UL6nG6AJhNN9jSevH6by+8wr07NBZOqX<br>
-fJx+J/8EdVsUCFG2UJxPwM83ZSwAsvKRqph6CuWEl9ndUb7rw6khmRIoY0Iz3LbU<br>
-1MlcDoJNcJas6lYDr1UeFSk86g0SiGCHXZIqsjyUgq6HIy4YrAYiQUthnlF8tp2Q<br>
-nNQBPLo1GsHf0dC2MqKfDFASu7ST+Bl+yajHcIiUXvUJPxWbjkWYG9Q2p2ZBLzZD<br>
-uqeRr66OKxTzUS4go/QbHDNsAulXl61gQIEOdZw5uy/Jl11kyAI6EQbzmehagKdH<br>
-EshTgKp8ks62y0bBHgy3FMKyidJ5Hm58ZDhBxrwN0w+vhRoTGOepTA=3D=3D<br>
------END RSA PRIVATE KEY-----<br>
diff --git a/sample/sample-keys/pkcs12.p12 b/sample/sample-keys/pkcs12.p12<=
br>
deleted file mode 100644<br>
index 253d4081a3aeffab7d17e8c0a308ee1e85d6456f..000000000000000000000000000=
0000000000000<br>
GIT binary patch<br>
literal 0<br>
HcmV?d00001<br>
<br>
literal 2685<br>
zcmY+FX*3j!8pmgb83vhTUnbc_G)!b{*|LOW9U`x+nHmjQ1`%T&lt;W0xfcjmmCh7ugCC<br>
zdJ&amp;0)EMrR;Yxb*i?!E85AD;7^^ZTFY`Sd^Mhaj*7f`AMN0?QQ$ROYea&lt;DFALCLo2t<b=
r>
zf?y=3DDTsXnf2m+JTKM{mNVB$MLTp%FeWS#ma0V0GTEdTz%281Bk8JTZzui!YHif({F<br>
z%z!Wg&lt;cF6_a`HQ&amp;-}0i(xAKxjpEU+B5NPvT7ptk55iSO@...1973...#^pTwD&gt;)*=
8*R!qdL<br>
z42fKOorCYJc=3DT4J+l;Z&gt;x@...1974...{LvCNkwZ7MJ{eDgmCW|XX+3GT!YUko$TXTGuE=
6Cmo<br>
z9@...1975...=3D9&lt;6!6cWi%@u&gt;Dp-$JP2s6t=3Dkvz6-OMl@~mEaEXG22le(Tfl@...493...=
1976...{VQ#pue@...1635...<br>
z$S`$H)k#B#icbEdGUTOJNtg8r2HVyl&lt;L=3DKiZIZ{}D6=3Dw)Cr?cr?f_CJAI&gt;~u|5a%=
&amp;<br>
z|9r54eca0dbeyd4`o{LK4N|e%U2!+rmvxC_ve9`q;d+UYx?t$mH)yUk-qpOnl`yp`<br>
z6mivqIZ&gt;KlXGlc!9*DRZGrJ8ENY!3w!PQRJQYJN)m0bubO9Gq)!dpG`51#4fNteWj<br>
z)Uy{{o)tgT)cfGn@(n)(as)Oir2jGwc=3DaG2L+~IbIcV%&amp;c5G|@P{*{Jd?#H&gt;P7lkl=
<br>
zqLP8(ve$BRfwQ=3DWmCMw1W!aWKiK;iH%ej(rhXL~D&lt;1btDIJpqh`U$seQ1fvjn;X@~<br>
zYBzzfQFps3x&gt;N1~k|{r05Ej#luDsl5o+E5o6W}y((|9?EHOt+r&gt;fDQx&amp;b7jzQ$DN=
&gt;<br>
zB}mx=3Dv1cW#Y}5;W1wVL}RxO)q&amp;@+=3DuH(=3D%CV{+~qJFCmm&gt;+q;_TVOBY$s0EFS=
dS;7<br>
z&amp;mqBKauOn(=3DlG*zP=3D4q^v2&lt;1rBH%Edi*`-;3;k~BXqk@...1977...`Zs~A<br>
z*lzbt&lt;Lz*?oKpFwtf0bMAHn6Pn_bV_(qucN^dt&gt;kpmn`Y&lt;JKcdnQLS&lt;@1i&gt;=
h@...1978...<br>
zEdZh~R0=3DkRsU4vUgW$I1u@|raEQEzz&amp;hBqHE&lt;e_`V*VvwZZK_?v#9@...1979...(=
OGuds8<br>
zq@`uGfPUcv*)58&gt;tEs$w^vz4cAHezuzgvmuh)lb`_LM{yoz0Ij*wf}VZB9stQ6roq<br>
zhXDK5d)_MN2W5P|{wWcWta=3D?Is&lt;$R6Ihym*+(~37OaRsIhbf-b8ck`;d~mN-TmSKH<br>
zAkCx?E}l3w*$}9L3^26R;TBK#i@...1620...|Af(ggGixifT9?AFEFm1R)6{ia%&amp;96Y_^=
kl&lt;Z<br>
zO|2vnP&amp;e9h$B#-ZOGJ})^bdG_L!CP?tY@...1980...)+zmUojTmJjmc4zn6DhJtkU*2<b=
r>
zTyOtzc?4-O5*u&gt;1WMq;EV3-lRXEM}xv(^O~!7!1)I|9!h9%_2p&lt;}KW$RKr|`YcLw}<br>
z&lt;t#*oq1A`dE=3D{byczot?YG(pSA(HR+V9kE4w4CN#78PlH7@...1981...#)P^RUmeu&gt=
;0<br>
zVEA183^cHZa*3$N9%A*|4roE^WV?ltK2PQvtg$I&amp;eq(wH*W%4sXR2^rp@?LgRIi$c<br>
z6%zNK^m$$X@&amp;e`@P3O2H0YrU%8V)t=3DMmkiK;#rsB0!5%g)&lt;#Kehh}i@&lt;=3DmHX=
sKMvG<br>
z&gt;eU}MNQy!ZO;oXNw(nZ&lt;bk2lI6SjTIljmfn0{qR9p3ED1Sz&amp;?R`~alg3@...1997...=
...#^Z<br>
z`}cg57$n3&gt;+J6q@)D4;l+}O_xHM_Z5tKoRYcpNO)&amp;2;YaS1hNtXHcG&amp;rv)Y1tsG=
Bu<br>
zH@@nN^V!H%fJ=3DzM7xONAJ@...1983...*$%sBw&amp;?k)KQXv{!oF~wZcUek*9AzOQ5GBOc=
Psmu<br>
zx&gt;J0`U(5@...1984...&gt;CkbfL4%WYBl*?wB7@...1985...+%J1&gt;zfC|fk&lt;4ta=
rku$KHFg`)<br>
z32;tRbzJ8+W1aCRdY&gt;%w%VrGgsHNyd4EbT#Qqh=3DVeTVcd!bI2!ts#EONaY-#AwEJ$<br>
zmV8E7g}dIaW$9T6mz_&lt;cPyHH)vI(Gj!HGil32(YPF#3E^f5PEvZ8`K+AeaNE4Y{JZ<br>
zq+-*=3D9IuO&gt;@2(aI&gt;^megR`|b;#&lt;jFHG7)`Rd8LiIqXgc}@&lt;&gt;#4x0GX*bj=
vl8tur0T<br>
zFi`8aRMRgtF^;s*U;`8O&amp;uP@...1952...(S@...1986...;o#rX^|4v%b5bALTjthLt;I=
)IZQOg5sH58X<br>
z@...1987...&gt;)V+B%k!v42GexdYt2hT)KhBqlrh)t$to8;ngHput4!Yrk-gY=3D}e^$|C-Y=
@...1988...=3D<br>
z-l_T&gt;3@=3DKG&gt;-JMVvEsG%_OrA4k@...1989...$RFdzXTFsv^5fJuNl`nhSt&amp;uY=
LCr&gt;Z<br>
z%rdbJyB06(7buBJ`C6EtGF&lt;4J?VJGCxLiP)aL?oQ96Llg9qZ6=3Dh3stpHJ6e=3D{Ewg1<b=
r>
zK+RSh?@GwJkQg&amp;4zkgxJv+S4#fuv~Wlw&amp;XBTWrIZVu&lt;M&lt;6^$$4j9FZSxaRM&=
gt;_7~R1<br>
z1hL~0b#})ulH*=3DgO69)OAwLx|pJlgtw5t9Z)?-pY?gb~g{M^?K=3D_s7xMG!!{|06^S<br>
z0kp(O0L`7?&gt;64j&amp;u&gt;MDnEI`mnn12Fa{GT-${#f&amp;L#3IK5UMTvHHBZjN(4|GI=
J8#*0<br>
zEL~S%gL8a#5&lt;fZ6(5MkHV?G~ynw&gt;P7p0Bg+ozfQ|)o`WbEdFq=3DPn+~*x}eSHDn&gt;=
}0<br>
za#bssC46DP&gt;glYKit?*q(ylFaU(}~Odzjx2#k+auqmLOM8@...1598...)YFzplKD0QtM(F=
_Uu<br>
zRHv^yDq*$`c$xNo;O1uEWTg5NnUR9^wRyLx4G&amp;J3O$l?Ff&amp;Sgd*Ux|{yu}Tc_kRAx<=
br>
zZ4_A@...1990...$)Ek?$5BMzMT0ZfU+`%1_OIaTg-c`D3Utjws&amp;do{_7d*j_LS6U+DKir=
<br>
z@...1991...#p!oOstM}_SmVJ?vyvMMumfm9By?=3D?AtkFJ4R`)DJQf3HPtrO&gt;CLF*ghb-=
Z{VT<br>
z@&amp;g3d`$hMvAw9wa-+X=3DcZug%2QLG(iT8okLHeD64iE06J24#}WG;%v0qN;o~J#X}X<br>
zYrX|$IsBw!A%&lt;DK8BxUAB#r~6R2VbwU(5j!Z&amp;%wNb{;g|?T5+&lt;F1~+I0vu7#x&am=
p;Fvm<br>
ze1ONAR~^|B&amp;Qq0=3Dujo8B;e~P=3D3$o9GB)Cn*7-hG1(ZUGyCPoz&gt;gBYC6=3DL-yXI=
_1c)<br>
z+V2@}l1I9@^i#Ub8wuxSinPw-x7vv^wsW3}5xqf+AKwPmn+)MXcW9$*)7&lt;p)X-4r0<br>
z(}vuxaH}l=3D5mD9p6kTY6tV&lt;=3D+{T09Rcf}dj;zzR*T|iIve0t3uU^!skyK&lt;X(@4$h=
D<br>
zjLKXu4dS7hQnxGPoJKwgMg4@...1992...^3R(;eyD;4^ur4ohCZxY|q1QA*+PG<br>
z$SOGWw^n~{mai?yyFC!zxHo3~sLTIe)p*v~5PJ8vr85%;Nxo4%n&lt;t_$^k`z?bVG;}<br>
z=3DY3=3DzfQmI$kU)t2x7AQ?1s+B&amp;c~qWv*&amp;*FkE5g%9wN}Fw%x7DNP(X+vpb)SuI|=
E1n<br>
p3}EC!RO5XI2(vRh7cV|04Ibx-bA*{OGGFY`Qh)u6xbdgm{{pfR_hSG6<br>
<br>
diff --git a/sample/sample-keys/server-ec.crt b/sample/sample-keys/server-e=
c.crt<br>
new file mode 100644<br>
index 0000000..a72c341<br>
--- /dev/null<br>
+++ b/sample/sample-keys/server-ec.crt<br>
@@ -0,0 +1,96 @@<br>
+Certificate:<br>
+=C2=A0 =C2=A0 Data:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Version: 3 (0x2)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Serial Number: 3 (0x3)<br>
+=C2=A0 =C2=A0 Signature Algorithm: sha256WithRSAEncryption<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Issuer: C=3DKG, ST=3DNA, L=3DBISHKEK, O=3DOpen=
VPN-TEST/emailAddress=3Dme@...430...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Validity<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not Before: Oct 22 21:59:53 2014=
 GMT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not After : Oct 19 21:59:53 2024=
 GMT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subject: C=3DKG, ST=3DNA, O=3DOpenVPN-TEST, CN=
=3DTest-Server-EC/emailAddress=3Dme@...430...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subject Public Key Info:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Public Key Algorithm: id-ecPubli=
cKey<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Public-Key: (256 b=
it)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pub:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 04:2=
1:09:ac:27:e6:00:3a:57:f4:f6:c7:78:a9:b1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f4:d=
7:d7:45:59:39:e4:a3:d3:2c:94:f9:61:4a:e6:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b9:e=
9:87:57:c8:0f:88:03:a0:56:ee:34:e7:e4:4e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 20:6=
3:6c:c1:6e:c1:04:ac:b9:2f:a9:76:69:d3:7d:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 49:f=
f:f1:34:cb<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASN1 OID: secp256k=
1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 extensions:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Basic Constraints:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CA:FALSE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Netscape Cert Type:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SSL Server<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Netscape Comment:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OpenSSL Generated =
Server Certificate<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Subject Key Identifier:<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 33:1A:42:61:9E:88:=
08:3F:6F:1F:98:88:3A:DD:2D:C7:07:3D:F6:9B<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Authority Key Identifier:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyid:2B:40:E5:C9:=
7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DirName:/C=3DKG/ST=
=3DNA/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial:A1:4E:DE:FA=
:90:F2:AE:81<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Extended Key Usage:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TLS Web Server Aut=
hentication<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Key Usage:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Digital Signature,=
 Key Encipherment<br>
+=C2=A0 =C2=A0 Signature Algorithm: sha256WithRSAEncryption<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A09d:89:f6:7e:0b:43:05:22:63:e5:b3:45:a8:d=
9:ef:33:3c:b7:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A019:37:28:87:27:43:43:86:a3:3f:b9:23:27:0=
f:96:4f:de:01:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A080:38:6b:d9:c8:94:77:1f:06:08:34:65:77:a=
d:57:0c:23:99:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f1:51:12:5f:32:d8:9c:7c:93:f1:f6:72:2a:0=
5:61:ff:62:aa:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A033:aa:ef:a3:4d:d6:93:56:40:ff:38:2e:73:1=
c:69:fb:71:a1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fa:64:19:6a:04:1c:8b:20:a8:ee:a5:18:63:f=
8:84:f4:ca:84:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08e:b6:05:48:c6:f3:f7:81:90:4d:9e:00:cd:4=
a:92:83:d4:93:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A067:05:dc:16:8b:78:fa:b1:82:48:c6:86:74:4=
4:b1:06:7e:8a:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c8:64:0b:82:3a:e2:f5:56:60:ea:50:70:03:d=
a:9f:fc:28:20:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06b:7d:04:e0:eb:8d:e2:f1:be:82:2f:ba:51:5=
0:2b:6c:d2:fc:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A011:cd:69:85:3b:9e:14:19:dd:bc:14:cf:61:b=
0:7a:07:cb:e8:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e0:fc:c3:1f:a4:cb:cf:c1:e9:62:0f:d2:53:f=
8:ce:06:f4:f8:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02f:55:13:aa:67:44:b6:b8:e8:3e:82:af:66:f=
5:f0:7c:fe:41:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e6:9d:c0:9f:78:fd:00:85:02:40:63:37:fa:0=
0:e6:3c:a6:9f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A035:4f:1d:a6:f1:cb:8b:04:e0:67:98:56:d1:8=
7:58:b6:39:f6:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d3:fe:a8:40:50:80:7f:e6:4a:36:d0:c0:a5:6=
1:64:1d:3a:87:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ad:78:72:c9:3f:98:44:35:f9:cf:32:b2:18:4=
c:b0:72:fa:5e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06c:62:1e:d4:31:0c:c8:9b:74:f0:00:9e:70:c=
3:1e:c7:a4:9d:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A003:a4:ac:1a:09:1f:86:23:65:51:34:50:86:6=
8:1e:68:4d:9a:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04b:78:10:1c:bd:51:09:bb:fe:16:a3:c7:19:b=
4:05:44:a1:e6:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c6:23:76:d5:b8:3a:eb:a5:17:1d:2b:2e:fe:8=
5:7c:88:4f:f1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e8:34:32:e0:c5:96:87:c3:e8:c9:5f:89:24:1=
0:0e:1e:07:0b:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02c:f8:d0:49:1b:63:5e:63:44:e9:2a:43:e2:9=
c:d6:f2:43:99:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A047:f8:9b:49:1a:a7:d1:e0:53:67:1d:cb:14:b=
6:b0:2c:4d:b3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f2:c5:62:c2:a6:09:7a:c0:6c:59:3e:73:83:0=
c:6c:de:30:77:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04d:1b:ed:b0:7f:77:87:8d:55:1d:d3:ed:f7:6=
6:bd:06:2a:f8:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd:00:e7:c0:31:e2:ff:53:9e:25:97:c6:64:8=
4:9d:8d:61:8e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c9:1f:6c:55:a1:7c:59:aa:eb:e8:2a:b2:2d:c=
7:09:cd:b5:3d:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d8:74:4f:6e:9c:3b:d5:6d<br>
+-----BEGIN CERTIFICATE-----<br>
+MIIEtTCCAp2gAwIBAgIBAzANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL<br>
+MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t<br>
+VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy<br>
+MjIxNTk1M1oXDTI0MTAxOTIxNTk1M1owbTELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
+Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFzAVBgNVBAMTDlRlc3QtU2VydmVy<br>
+LUVDMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wVjAQBgcqhkjO<br>
+PQIBBgUrgQQACgNCAAQhCawn5gA6V/T2x3ipsfTX10VZOeSj0yyU+WFK5rnph1fI<br>
+D4gDoFbuNOfkTiBjbMFuwQSsuS+pdmnTfUn/8TTLo4IBMzCCAS8wCQYDVR0TBAIw<br>
+ADARBglghkgBhvhCAQEEBAMCBkAwMwYJYIZIAYb4QgENBCYWJE9wZW5TU0wgR2Vu<br>
+ZXJhdGVkIFNlcnZlciBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQUMxpCYZ6ICD9vH5iI<br>
+Ot0txwc99pswgZgGA1UdIwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRo<br>
+MGYxCzAJBgNVBAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEV<br>
+MBMGA1UEChMMT3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3Qu<br>
+bXlkb21haW6CCQChTt76kPKugTATBgNVHSUEDDAKBggrBgEFBQcDATALBgNVHQ8E<br>
+BAMCBaAwDQYJKoZIhvcNAQELBQADggIBAJ2J9n4LQwUiY+WzRajZ7zM8txk3KIcn<br>
+Q0OGoz+5IycPlk/eAYA4a9nIlHcfBgg0ZXetVwwjmfFREl8y2Jx8k/H2cioFYf9i<br>
+qjOq76NN1pNWQP84LnMcaftxofpkGWoEHIsgqO6lGGP4hPTKhI62BUjG8/eBkE2e<br>
+AM1KkoPUk2cF3BaLePqxgkjGhnREsQZ+ishkC4I64vVWYOpQcAPan/woIGt9BODr<br>
+jeLxvoIvulFQK2zS/BHNaYU7nhQZ3bwUz2GwegfL6OD8wx+ky8/B6WIP0lP4zgb0<br>
++C9VE6pnRLa46D6Cr2b18Hz+QeadwJ94/QCFAkBjN/oA5jymnzVPHabxy4sE4GeY<br>
+VtGHWLY59tP+qEBQgH/mSjbQwKVhZB06h614csk/mEQ1+c8yshhMsHL6XmxiHtQx<br>
+DMibdPAAnnDDHseknQOkrBoJH4YjZVE0UIZoHmhNmkt4EBy9UQm7/hajxxm0BUSh<br>
+5sYjdtW4OuulFx0rLv6FfIhP8eg0MuDFlofD6MlfiSQQDh4HCyz40EkbY15jROkq<br>
+Q+Kc1vJDmUf4m0kap9HgU2cdyxS2sCxNs/LFYsKmCXrAbFk+c4MMbN4wd00b7bB/<br>
+d4eNVR3T7fdmvQYq+P0A58Ax4v9TniWXxmSEnY1hjskfbFWhfFmq6+gqsi3HCc21<br>
+Pdh0T26cO9Vt<br>
+-----END CERTIFICATE-----<br>
diff --git a/sample/sample-keys/server-ec.key b/sample/sample-keys/server-e=
c.key<br>
new file mode 100644<br>
index 0000000..8f2c914<br>
--- /dev/null<br>
+++ b/sample/sample-keys/server-ec.key<br>
@@ -0,0 +1,5 @@<br>
+-----BEGIN PRIVATE KEY-----<br>
+MIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQgLHGYqSlzoRaogmJfrC+E<br>
+ozTothB9bORaQ1C/3FmeQ6ehRANCAAQhCawn5gA6V/T2x3ipsfTX10VZOeSj0yyU<br>
++WFK5rnph1fID4gDoFbuNOfkTiBjbMFuwQSsuS+pdmnTfUn/8TTL<br>
+-----END PRIVATE KEY-----<br>
diff --git a/sample/sample-keys/server.crt b/sample/sample-keys/server.crt<=
br>
index 28bb4d9..03e2023 100644<br>
--- a/sample/sample-keys/server.crt<br>
+++ b/sample/sample-keys/server.crt<br>
@@ -2,25 +2,34 @@ Certificate:<br>
=C2=A0 =C2=A0 =C2=A0Data:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Version: 3 (0x2)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Serial Number: 1 (0x1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Signature Algorithm: md5WithRSAEncryption<br>
+=C2=A0 =C2=A0 Signature Algorithm: sha256WithRSAEncryption<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Issuer: C=3DKG, ST=3DNA, L=3DBISHKEK, O=
=3DOpenVPN-TEST/emailAddress=3Dme@...430...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Validity<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not Before: Nov 25 14:42:22 2004=
 GMT<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not After : Nov 23 14:42:22 2014=
 GMT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not Before: Oct 22 21:59:52 2014=
 GMT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Not After : Oct 19 21:59:52 2024=
 GMT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Subject: C=3DKG, ST=3DNA, O=3DOpenVPN-TES=
T, CN=3DTest-Server/emailAddress=3Dme@...430...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Subject Public Key Info:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Public Key Algorithm: rsaEn=
cryption<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RSA Public Key: (1024 bit)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Modulus (1024 bit)=
:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 00:c=
b:4e:ac:f9:83:57:f6:69:d2:32:29:b4:bc:ad:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e6:f=
7:26:21:89:33:30:43:40:a3:35:d9:de:26:01:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d6:b=
4:f0:bc:0a:19:55:99:3b:f1:4c:91:60:b6:fd:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 74:3=
4:8d:5a:c7:62:ec:ce:f2:d6:02:ce:57:32:f4:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 35:8=
c:71:a0:6d:65:2a:e7:80:ae:29:59:cf:36:73:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f8:7=
c:4a:73:90:fc:30:28:d5:46:7d:35:a4:4e:c9:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 9f:9=
0:7b:e2:09:21:36:c5:a8:ec:85:82:9a:32:b4:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 91:3=
b:c1:d6:4f:9f:d1:f8:6f:68:f4:1d:d2:06:91:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 32:c=
c:9a:48:fd:cd:98:7f:2f<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Public-Key: (2048 =
bit)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Modulus:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 00:a=
5:b8:a2:ee:ce:b1:a6:0f:6a:b2:9f:d3:22:17:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 79:d=
e:09:98:71:78:fa:a7:ce:36:51:54:57:c7:31:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 99:5=
6:d1:8a:d6:c5:fd:52:e6:88:0e:7b:f9:ea:27:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7a:b=
f:3f:14:ec:aa:d2:ff:8b:56:58:ac:ca:51:77:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c5:3=
c:b6:e4:83:6f:22:06:2d:5b:eb:e7:59:d4:ab:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 42:c=
8:d5:a9:87:73:b3:73:36:51:2f:a5:d0:90:a2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 87:6=
4:54:6c:12:d3:b8:76:47:69:af:ae:8f:00:b3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 70:b=
9:e7:67:3f:8c:6a:3d:79:5f:81:27:a3:0e:aa:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a7:3=
d:81:48:10:b1:18:6c:38:2e:8f:7a:7b:c5:3d:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 21:c=
8:f9:a0:7f:17:2b:88:4f:ba:f2:ec:6d:24:8e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6c:f=
1:0a:5c:d9:5b:b1:b0:fc:49:cb:4a:d2:58:c6:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2a:2=
5:b0:97:84:c3:9e:ff:34:8c:10:46:7f:0f:fb:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3c:5=
9:7a:a6:29:0c:ae:8e:50:3a:f2:53:84:40:2d:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d5:9=
1:7b:0a:37:8e:82:77:ce:66:2f:34:77:5c:a5:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 45:3=
b:00:19:a7:07:d1:92:e6:66:b9:3b:4e:e9:63:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fc:3=
3:98:1a:ae:7b:08:7d:0a:df:7a:ba:aa:59:6d:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 86:8=
2:0a:64:2b:da:59:a7:4c:4e:ef:3d:bd:04:a2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4b:3=
1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Exponent: 655=
37 (0x10001)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0X509v3 extensions:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0X509v3 Basic Constraints:<b=
r>
@@ -30,38 +39,75 @@ Certificate:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Netscape Comment:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OpenSSL Gener=
ated Server Certificate<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0X509v3 Subject Key Identifi=
er:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 69:11:FE:E7:9F:89:=
7B:71:34:69:C0:DC:82:F8:D0:5D:4D:FB:78:DF<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 B3:9D:81:E6:16:92:=
64:C4:86:87:F5:29:10:1B:5E:2F:74:F7:ED:B1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0X509v3 Authority Key Identi=
fier:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyid:89:A6:60:E3:=
BA:EA:3E:AF:FC:64:7F:4C:BD:8C:D2:48:8D:E0:CC:46<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyid:2B:40:E5:C9:=
7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DirName:/C=3D=
KG/ST=3DNA/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial:00<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial:A1:4E:DE:FA=
:90:F2:AE:81<br>
<br>
-=C2=A0 =C2=A0 Signature Algorithm: md5WithRSAEncryption<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 35:5c:75:da:57:ef:b5:79:f2:a2:db:36:e4:75:e8:c=
7:bc:73:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 26:cf:30:36:4b:2e:51:46:37:60:2f:4e:2b:f6:71:a=
2:23:db:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 8e:d8:5c:d5:af:2e:22:28:dd:30:a8:89:66:3a:cc:5=
b:3c:0f:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 96:12:20:de:5e:41:52:74:35:ed:4c:26:40:19:ca:7=
3:df:54:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 b1:30:96:9c:a5:14:d0:38:28:3f:ab:30:07:d7:de:9=
8:d2:7f:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 7f:90:b2:52:1d:e5:95:88:ed:ba:8a:6a:14:85:66:7=
6:ec:75:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 30:e8:ae:94:f4:e1:76:fa:4b:0e:f1:53:d7:95:be:f=
b:69:fa:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 3d:32<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Extended Key Usage:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TLS Web Server Aut=
hentication<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509v3 Key Usage:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Digital Signature,=
 Key Encipherment<br>
+=C2=A0 =C2=A0 Signature Algorithm: sha256WithRSAEncryption<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04e:25:80:1b:cb:b0:42:ff:bb:3f:e8:0d:58:c=
1:80:db:cf:d0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A090:df:ca:c1:e6:41:e1:48:7f:a7:1e:c7:35:9=
f:9c:6d:7c:3e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A082:e8:de:7e:ae:82:16:00:33:0f:02:23:f1:9=
d:fe:2b:06:16:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A005:55:16:89:dc:63:ac:5f:1a:31:13:79:21:a=
3:6e:60:28:e8:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e7:6b:54:00:22:a1:b7:69:5a:17:31:ce:0f:c=
2:a6:dd:a3:6f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0de:ea:19:6c:d2:d2:cb:35:9d:dd:87:51:33:6=
8:cd:c3:9b:90:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A055:f1:80:3d:5c:b8:09:b6:e1:3c:13:a4:5d:4=
a:ce:a5:11:9e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f9:08:ee:be:e3:54:1d:06:4c:bb:1b:72:13:e=
e:7d:a0:45:cc:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fe:d1:3b:02:03:c1:d4:ea:45:2d:a8:c9:97:e=
7:f3:8a:7a:a0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02f:dd:48:3a:75:c9:42:28:94:fc:af:44:52:1=
6:68:98:d6:ad:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a8:65:b1:cd:ac:60:41:70:e5:44:e8:5a:f2:e=
7:fc:3b:fe:45:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A089:17:1d:6d:85:c6:f0:fc:69:87:d1:1d:07:f=
3:cb:7b:54:8d:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aa:a3:cc:e3:c6:fc:d6:05:76:35:d0:26:63:8=
e:d1:a8:b7:ff:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A061:42:8a:2c:63:1f:d4:ec:14:47:6b:1e:e3:8=
1:61:12:3b:8c:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016:b5:cf:87:6a:2d:42:21:83:9c:0e:3a:90:3=
a:1e:c1:36:61:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A041:f9:fb:4e:5d:ea:f4:df:23:92:33:2b:9b:1=
4:9f:a0:f5:d3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c4:f8:1f:2f:9c:11:36:af:2a:22:61:95:32:0=
b:c4:1c:2d:b1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c1:0a:2a:97:c0:43:4a:6c:3e:db:00:cd:29:1=
5:9e:7e:41:75:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A036:a8:56:86:8c:82:9e:46:20:e5:06:1e:60:d=
2:03:5f:9f:9e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A069:bb:bf:c2:b4:43:e2:7d:85:17:83:18:41:b=
0:cb:a9:04:1b:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A018:52:9f:89:8b:76:9f:94:59:81:4f:60:5b:3=
3:18:fc:c7:52:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d0:d2:69:fc:0b:a2:63:32:75:43:99:e9:d7:f=
8:6d:c7:55:31:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00c:f3:ef:1a:71:e1:0a:57:e1:9d:13:b2:1e:f=
e:1d:ef:e4:f1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A051:d9:95:b3:fd:28:28:93:91:4a:29:c5:37:0=
e:ab:d8:85:6a:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fe:a8:83:1f:7b:80:5d:1f:04:79:b7:a9:08:6=
e:0d:d6:2e:aa:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07c:f6:63:7d:41:de:70:13:32:ce:dd:58:cc:a=
6:73:d4:72:7e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d7:ac:74:a8:35:ba:c3:1b:2a:64:d7:5a:37:9=
7:56:94:34:2b:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02a:71:60:bc:69:ab:00:85:b9:4f:67:32:17:5=
1:c3:da:57:3a:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A037:89:66:c4:7a:51:da:5f<br>
=C2=A0-----BEGIN CERTIFICATE-----<br>
-MIIDUTCCArqgAwIBAgIBATANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL<br>
+MIIFgDCCA2igAwIBAgIBATANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL<br>
=C2=A0MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t<br>
-VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy<br>
-NTE0NDIyMloXDTE0MTEyMzE0NDIyMlowajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
+VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy<br>
+MjIxNTk1MloXDTI0MTAxOTIxNTk1MlowajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
=C2=A0Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFDASBgNVBAMTC1Rlc3QtU2VydmVy<br>
-MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wgZ8wDQYJKoZIhvcN<br>
-AQEBBQADgY0AMIGJAoGBAMtOrPmDV/Zp0jIptLyt5vcmIYkzMENAozXZ3iYB1rTw<br>
-vAoZVZk78UyRYLb9dDSNWsdi7M7y1gLOVzL0NYxxoG1lKueArilZzzZz+HxKc5D8<br>
-MCjVRn01pE7Jn5B74gkhNsWo7IWCmjK0kTvB1k+f0fhvaPQd0gaRMsyaSP3NmH8v<br>
-AgMBAAGjggEJMIIBBTAJBgNVHRMEAjAAMBEGCWCGSAGG+EIBAQQEAwIGQDAzBglg<br>
-hkgBhvhCAQ0EJhYkT3BlblNTTCBHZW5lcmF0ZWQgU2VydmVyIENlcnRpZmljYXRl<br>
-MB0GA1UdDgQWBBRpEf7nn4l7cTRpwNyC+NBdTft43zCBkAYDVR0jBIGIMIGFgBSJ<br>
-pmDjuuo+r/xkf0y9jNJIjeDMRqFqpGgwZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
-Ak5BMRAwDgYDVQQHEwdCSVNIS0VLMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxITAf<br>
-BgkqhkiG9w0BCQEWEm1lQG15aG9zdC5teWRvbWFpboIBADANBgkqhkiG9w0BAQQF<br>
-AAOBgQA1XHXaV++1efKi2zbkdejHvHMmzzA2Sy5RRjdgL04r9nGiI9uO2FzVry4i<br>
-KN0wqIlmOsxbPA+WEiDeXkFSdDXtTCZAGcpz31SxMJacpRTQOCg/qzAH196Y0n9/<br>
-kLJSHeWViO26imoUhWZ27HUw6K6U9OF2+ksO8VPXlb77afo9Mg=3D=3D<br>
+MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wggEiMA0GCSqGSIb3<br>
+DQEBAQUAA4IBDwAwggEKAoIBAQCluKLuzrGmD2qyn9MiF3neCZhxePqnzjZRVFfH<br>
+MZlW0YrWxf1S5ogOe/nqJ3q/PxTsqtL/i1ZYrMpRd8U8tuSDbyIGLVvr51nUq0LI<br>
+1amHc7NzNlEvpdCQoodkVGwS07h2R2mvro8As3C552c/jGo9eV+BJ6MOqqc9gUgQ<br>
+sRhsOC6PenvFPSHI+aB/FyuIT7ry7G0kjmzxClzZW7Gw/EnLStJYxiolsJeEw57/<br>
+NIwQRn8P+zxZeqYpDK6OUDryU4RALdWRewo3joJ3zmYvNHdcpUU7ABmnB9GS5ma5<br>
+O07pY/wzmBquewh9Ct96uqpZbYaCCmQr2lmnTE7vPb0EoksxAgMBAAGjggEzMIIB<br>
+LzAJBgNVHRMEAjAAMBEGCWCGSAGG+EIBAQQEAwIGQDAzBglghkgBhvhCAQ0EJhYk<br>
+T3BlblNTTCBHZW5lcmF0ZWQgU2VydmVyIENlcnRpZmljYXRlMB0GA1UdDgQWBBSz<br>
+nYHmFpJkxIaH9SkQG14vdPftsTCBmAYDVR0jBIGQMIGNgBQrQOXJffX0ljjpL+Mv<br>
+2UBkyY4Fm6FqpGgwZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgTAk5BMRAwDgYDVQQH<br>
+EwdCSVNIS0VLMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxITAfBgkqhkiG9w0BCQEW<br>
+Em1lQG15aG9zdC5teWRvbWFpboIJAKFO3vqQ8q6BMBMGA1UdJQQMMAoGCCsGAQUF<br>
+BwMBMAsGA1UdDwQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAgEATiWAG8uwQv+7P+gN<br>
+WMGA28/QkN/KweZB4Uh/px7HNZ+cbXw+gujefq6CFgAzDwIj8Z3+KwYWBVUWidxj<br>
+rF8aMRN5IaNuYCjo52tUACKht2laFzHOD8Km3aNv3uoZbNLSyzWd3YdRM2jNw5uQ<br>
+VfGAPVy4CbbhPBOkXUrOpRGe+QjuvuNUHQZMuxtyE+59oEXM/tE7AgPB1OpFLajJ<br>
+l+fzinqgL91IOnXJQiiU/K9EUhZomNatqGWxzaxgQXDlROha8uf8O/5FiRcdbYXG<br>
+8Pxph9EdB/PLe1SNqqPM48b81gV2NdAmY47RqLf/YUKKLGMf1OwUR2se44FhEjuM<br>
+FrXPh2otQiGDnA46kDoewTZhQfn7Tl3q9N8jkjMrmxSfoPXTxPgfL5wRNq8qImGV<br>
+MgvEHC2xwQoql8BDSmw+2wDNKRWefkF1NqhWhoyCnkYg5QYeYNIDX5+eabu/wrRD<br>
+4n2FF4MYQbDLqQQbGFKfiYt2n5RZgU9gWzMY/MdS0NJp/AuiYzJ1Q5np1/htx1Ux<br>
+DPPvGnHhClfhnROyHv4d7+TxUdmVs/0oKJORSinFNw6r2IVq/qiDH3uAXR8Eebep<br>
+CG4N1i6qfPZjfUHecBMyzt1YzKZz1HJ+16x0qDW6wxsqZNdaN5dWlDQrKnFgvGmr<br>
+AIW5T2cyF1HD2lc6N4lmxHpR2l8=3D<br>
=C2=A0-----END CERTIFICATE-----<br>
diff --git a/sample/sample-keys/server.key b/sample/sample-keys/server.key<=
br>
index 976acab..011df12 100644<br>
--- a/sample/sample-keys/server.key<br>
+++ b/sample/sample-keys/server.key<br>
@@ -1,15 +1,28 @@<br>
------BEGIN RSA PRIVATE KEY-----<br>
-MIICXgIBAAKBgQDLTqz5g1f2adIyKbS8reb3JiGJMzBDQKM12d4mAda08LwKGVWZ<br>
-O/FMkWC2/XQ0jVrHYuzO8tYCzlcy9DWMcaBtZSrngK4pWc82c/h8SnOQ/DAo1UZ9<br>
-NaROyZ+Qe+IJITbFqOyFgpoytJE7wdZPn9H4b2j0HdIGkTLMmkj9zZh/LwIDAQAB<br>
-AoGBAKP1ljA/iY/zNY447kZ/5NWKzd7tBk4mcbl7M9no/7O6tZtbZRoIKoi6cYoC<br>
-C1ZabUyBbkNTud5XdCFmq0zRUjOWvoFMZ9VZfd2kRPvl4TGczBtJAq65b+EYMGui<br>
-q6T9p61xPdtzu0vM+Ecj127pAMk5XcJyxu8XQK7lZWmG5UoJAkEA8CxXNZN+A3qD<br>
-bMBPI3VdwKCNSjNVEQEnygMbNgw7VLdxPpspzZziqJEGdzsM4dsnOBwKxIWFLN2h<br>
-lbGBOquAswJBANi0atGWM8VUxDjvqqHCTS9RUXWgnvYhee4/xraJBQPBSivjC9P0<br>
-vKT7PjBHU6djtKSLKGaHn1vHqmyY7PCMjZUCQQCNVSqExqSzG1dXmdt4PErNXi2G<br>
-6qo2dX2arTVIGu6XLdQgSWLSMm5XT/CEHWW5SyPLKwVTHFeATXQXCPvJML9tAkEA<br>
-k0yXax0g1ZoXwufN4SQUmPw6Va03P/BjU/nP1ZVvbiz9gLVU/d7WN4J7tA9XomkY<br>
-idv5OzAmtxkSE70jGSNAvQJAWhCf9+iHkzOHRyKKOYlh1DHUwDfSEp+hlZYg9H03<br>
-P2sraQzUxgWDY/DIY63KvW78ny863baFz7onz21MYGgJXg=3D=3D<br>
------END RSA PRIVATE KEY-----<br>
+-----BEGIN PRIVATE KEY-----<br>
+MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCluKLuzrGmD2qy<br>
+n9MiF3neCZhxePqnzjZRVFfHMZlW0YrWxf1S5ogOe/nqJ3q/PxTsqtL/i1ZYrMpR<br>
+d8U8tuSDbyIGLVvr51nUq0LI1amHc7NzNlEvpdCQoodkVGwS07h2R2mvro8As3C5<br>
+52c/jGo9eV+BJ6MOqqc9gUgQsRhsOC6PenvFPSHI+aB/FyuIT7ry7G0kjmzxClzZ<br>
+W7Gw/EnLStJYxiolsJeEw57/NIwQRn8P+zxZeqYpDK6OUDryU4RALdWRewo3joJ3<br>
+zmYvNHdcpUU7ABmnB9GS5ma5O07pY/wzmBquewh9Ct96uqpZbYaCCmQr2lmnTE7v<br>
+Pb0EoksxAgMBAAECggEAPMOMin+jR75TYxeTNObiunVOPh0b2zeTVxLT9KfND7ZZ<br>
+cBK8pg79SEJRCnhbW5BnvbeNEkIm8PC6ZlDCM1bkRwUStq0fDUqQ95esLzOYq5/S<br>
+5qW98viblszhU/pYfja/Zi8dI1uf96PT63Zbt0NnGQ9N42+DLDeKhtTGdchZqiQA<br>
+LeSR0bQanY4tUUtCNYvBT8E3pzhoIsUzVwzIK53oovRpcOX3pMXVYZsmNhXdFFRy<br>
+YkjMXpj7fGyaAJK0QsC+PsgrKuhXDzDttsG2lI/mq9+7RXB3d/pzhmBVWynVH2lw<br>
+iQ7ONkSz7akDz/4I4WmxJep+FfQJYgK6rnLAlQqauQKBgQDammSAprnvDvNhSEp8<br>
+W+xt7jQnFqaENbGgP0/D/OZMXc4khgexqlKFmSnBCRDmQ6JvLTWqDXC4+aqAbFQz<br>
+zAIjiKaT+so8xvFRob+rBMJY5JLYKNa+zUUanfORUNYLFJPvFqnrWGaJ9uufdaM7<br>
+0a5bu95PN74NXee3DBbpBv8HLwKBgQDCEk+IjNbjMT+Neq0ywUeM5rFrUKi92abe<br>
+AgsVpjbighRV+6jA2lZFJcize+xYJ9wiOR1/TEI9PZ2OtBkqpwVdvTEHTagRLcvd<br>
+NfGcptREDnNLoNWA22buQpztiEduutACWQsrd+JQmqbUicUdW4zw86/oCMbYCW3V<br>
+QmYOLns7nwKBgHHUX20WZE91S4pmqFKlUzHTDdkk1ESX6Qx2q0R01j8BwawHFs6O<br>
+0DW9EZ7w55nfsh+OPRl1sjK/3ubMgfQO0TZLm+IGf3Sya0qEnVeiPMkpDMX+TgRA<br>
+wzEe+ou6uho+9uFSvdxMxeglaYA5M2ycvNwLsbEyZ4ZyVYxdgTiKahYFAoGAcIfP<br>
+iD0qKQiYcj/tB94cz+3AeJqHjbYT1O1YYhBECOkmQ4kuG80+cs/q5W/45lEOiuWV<br>
+Xgfo7Lu6jVGOujWoneci87oqtvNYH4e09oGh2WiLoBG9Wv9dWtBTUERSLzmxfXsG<br>
+SAk2uEhEbj8IhfJc8iZLHH9iVUh6YEslBBodqL8CgYEAlAhvcqAvw5SzsfBR5Mcu<br>
+4Nql6mXEVhHCvS4hdFCGaNF0z9A6eBORKJpdLWnqhpquDQDsghWE+Ga4QKSNFIi1<br>
+fnAaykmZuY3ToqNOIaVlYM6HpMEz0wHQbTWfDLGcTFcElLZgMAk7VlDyiYVOco+E<br>
+QX9lXOO1PGpLzXhlDxSe63Y=3D<br>
+-----END PRIVATE KEY-----<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br></div></div></div></div></div></div>

--089e0149c9b4d5b8bf0507e642c0--

--089e0149c9b4d5b8c40507e642c2
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Modernize-sample-keys-and-sample-configs-v2.patch"
Content-Disposition: attachment; 
	filename="0001-Modernize-sample-keys-and-sample-configs-v2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i2j1suwp0

RnJvbSAwZWI2ZTA4NDIxZWE1NmUwMDk5MjcxYjBhODRlZGEyYmYzZThiNjY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmZmFuIEthcmdlciA8c3RlZmZhbkBrYXJnZXIubWU+CkRh
dGU6IFRodSwgMjMgT2N0IDIwMTQgMDA6MTQ6MjkgKzAyMDAKU3ViamVjdDogW1BBVENIXSBNb2Rl
cm5pemUgc2FtcGxlIGtleXMgYW5kIHNhbXBsZSBjb25maWdzCgpJIGtlcHQgbW9zdCBvZiB0aGUg
Y2VydGlmaWNhdGUgcHJvcGVydGllcyBlcXVhbCB0byB0aGUgb2xkCmNlcnRzLCBzaW5jZSBzb21l
IHBlb3BsZSdzIHRlc3Qgc2NyaXB0cyBtaWdodCByZWx5IG9uIHRoZW0gKGFuZAppdCBkb2VzIG5v
dCByZXF1aXJlIGFueSBjcmVhdGl2aXR5IGZyb20gbXkgcGFydCkuCgpDaGFuZ2VzOgogKiBBZGQg
c2NyaXB0IHRvIGdlbmVyYXRlIGZyZXNoIHRlc3Qvc2FtcGxlIGtleXMKICAgKGJ1dCBrZWVwIHNh
bXBsZSBrZXlzIGluIGdpdCBmb3Igc2ltcGxlIHRlc3RpbmcpCiAqIFN3aXRjaCBmcm9tIDEwMjQg
dG8gNDA5NiBiaXRzIFJTQSBDQQogKiBTd2l0Y2ggZnJvbSAxMDI0IHRvIDIwNDggYml0cyBjbGll
bnQvc2VydmVyIFJTQSBrZXlzCiAqIFN3aXRjaCBmcm9tIDEwMjQgdG8gMjA0OCBiaXRzIERpZmZp
ZS1IZWxsbWFuIHBhcmFtZXRlcnMKICogR2VuZXJhdGUgRUMgY2xpZW50IGFuZCBzZXJ2ZXIgY2Vy
dCwgYnV0IHNpZ24gd2l0aCBSU0EgQ0EKICAgKGxldHMgdXMgdGVzdCBFQyA8LT4gUlNBIGludGVy
b3BlcmFiaWxpdHkpCiAqIFJlbW92ZSAzREVTIGNpcGhlciBmcm9tICdzYW1wbGUnIGNvbmZpZwog
KiBBZGQgJ3JlbW90ZS1jZXJ0LXRscyBzZXJ2ZXInIHRvIGNsaWVudCBjb25maWcKICogVXBkYXRl
IGNvbmZpZyBmaWxlcyB0byBkZXByZWNhdGUgbnNDZXJ0VHlwZSBpbiBmYXZvdXIgb2YgdGhlCiAg
IGtleVVzYWdlIGFuZCBleHRlbmRlZEtleVVzYWdlIGV4dGVuc2lvbnMuCiAqIE1ha2UgbmFtaW5n
IG1vcmUgY29uc2lzdGVudAoKU2lnbmVkLW9mZi1ieTogU3RlZmZhbiBLYXJnZXIgPHN0ZWZmYW5A
a2FyZ2VyLm1lPgotLS0KIHNhbXBsZS9zYW1wbGUtY29uZmlnLWZpbGVzL2NsaWVudC5jb25mICAg
ICB8ICAxNyArKy0tCiBzYW1wbGUvc2FtcGxlLWNvbmZpZy1maWxlcy9sb29wYmFjay1jbGllbnQg
fCAgIDIgKy0KIHNhbXBsZS9zYW1wbGUtY29uZmlnLWZpbGVzL2xvb3BiYWNrLXNlcnZlciB8ICAg
MyArLQogc2FtcGxlL3NhbXBsZS1jb25maWctZmlsZXMvc2VydmVyLmNvbmYgICAgIHwgICA2ICst
CiBzYW1wbGUvc2FtcGxlLWNvbmZpZy1maWxlcy90bHMtb2ZmaWNlLmNvbmYgfCAgIDIgKy0KIHNh
bXBsZS9zYW1wbGUta2V5cy8uZ2l0aWdub3JlICAgICAgICAgICAgICB8ICAgMSArCiBzYW1wbGUv
c2FtcGxlLWtleXMvUkVBRE1FICAgICAgICAgICAgICAgICAgfCAgMTcgKystLQogc2FtcGxlL3Nh
bXBsZS1rZXlzL2NhLmNydCAgICAgICAgICAgICAgICAgIHwgIDQ4ICsrKysrKy0tLS0KIHNhbXBs
ZS9zYW1wbGUta2V5cy9jYS5rZXkgICAgICAgICAgICAgICAgICB8ICA2NyArKysrKysrKysrLS0t
LQogc2FtcGxlL3NhbXBsZS1rZXlzL2NsaWVudC1lYy5jcnQgICAgICAgICAgIHwgIDg1ICsrKysr
KysrKysrKysrKysrKwogc2FtcGxlL3NhbXBsZS1rZXlzL2NsaWVudC1lYy5rZXkgICAgICAgICAg
IHwgICA1ICsrCiBzYW1wbGUvc2FtcGxlLWtleXMvY2xpZW50LXBhc3Mua2V5ICAgICAgICAgfCAg
MzAgKysrKysrKwogc2FtcGxlL3NhbXBsZS1rZXlzL2NsaWVudC5jcnQgICAgICAgICAgICAgIHwg
MTI2ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tCiBzYW1wbGUvc2FtcGxlLWtleXMvY2xpZW50
LmtleSAgICAgICAgICAgICAgfCAgNDMgKysrKystLS0tCiBzYW1wbGUvc2FtcGxlLWtleXMvY2xp
ZW50LnAxMiAgICAgICAgICAgICAgfCBCaW4gMCAtPiA0NTMzIGJ5dGVzCiBzYW1wbGUvc2FtcGxl
LWtleXMvZGgxMDI0LnBlbSAgICAgICAgICAgICAgfCAgIDUgLS0KIHNhbXBsZS9zYW1wbGUta2V5
cy9kaDIwNDgucGVtICAgICAgICAgICAgICB8ICAgOCArKwogc2FtcGxlL3NhbXBsZS1rZXlzL2Vj
LWNhLmNydCAgICAgICAgICAgICAgIHwgIDEzIC0tLQogc2FtcGxlL3NhbXBsZS1rZXlzL2VjLWNh
LmtleSAgICAgICAgICAgICAgIHwgICA2IC0tCiBzYW1wbGUvc2FtcGxlLWtleXMvZWMtY2xpZW50
LmNydCAgICAgICAgICAgfCAgNjEgLS0tLS0tLS0tLS0tLQogc2FtcGxlL3NhbXBsZS1rZXlzL2Vj
LWNsaWVudC5rZXkgICAgICAgICAgIHwgICA2IC0tCiBzYW1wbGUvc2FtcGxlLWtleXMvZWMtc2Vy
dmVyLmNydCAgICAgICAgICAgfCAgNjEgLS0tLS0tLS0tLS0tLQogc2FtcGxlL3NhbXBsZS1rZXlz
L2VjLXNlcnZlci5rZXkgICAgICAgICAgIHwgICA2IC0tCiBzYW1wbGUvc2FtcGxlLWtleXMvZ2Vu
LXNhbXBsZS1rZXlzLnNoICAgICAgfCAgNzYgKysrKysrKysrKysrKysrKwogc2FtcGxlL3NhbXBs
ZS1rZXlzL29wZW5zc2wuY25mICAgICAgICAgICAgIHwgMTM5ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCiBzYW1wbGUvc2FtcGxlLWtleXMvcGFzcy5jcnQgICAgICAgICAgICAgICAgfCAg
NjUgLS0tLS0tLS0tLS0tLS0KIHNhbXBsZS9zYW1wbGUta2V5cy9wYXNzLmtleSAgICAgICAgICAg
ICAgICB8ICAxOCAtLS0tCiBzYW1wbGUvc2FtcGxlLWtleXMvcGtjczEyLnAxMiAgICAgICAgICAg
ICAgfCBCaW4gMjY4NSAtPiAwIGJ5dGVzCiBzYW1wbGUvc2FtcGxlLWtleXMvc2VydmVyLWVjLmNy
dCAgICAgICAgICAgfCAgOTYgKysrKysrKysrKysrKysrKysrKysKIHNhbXBsZS9zYW1wbGUta2V5
cy9zZXJ2ZXItZWMua2V5ICAgICAgICAgICB8ICAgNSArKwogc2FtcGxlL3NhbXBsZS1rZXlzL3Nl
cnZlci5jcnQgICAgICAgICAgICAgIHwgMTMwICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQog
c2FtcGxlL3NhbXBsZS1rZXlzL3NlcnZlci5rZXkgICAgICAgICAgICAgIHwgIDQzICsrKysrLS0t
LQogMzIgZmlsZXMgY2hhbmdlZCwgNzgwIGluc2VydGlvbnMoKyksIDQxMCBkZWxldGlvbnMoLSkK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBzYW1wbGUvc2FtcGxlLWtleXMvLmdpdGlnbm9yZQogY3JlYXRl
IG1vZGUgMTAwNjQ0IHNhbXBsZS9zYW1wbGUta2V5cy9jbGllbnQtZWMuY3J0CiBjcmVhdGUgbW9k
ZSAxMDA2NDQgc2FtcGxlL3NhbXBsZS1rZXlzL2NsaWVudC1lYy5rZXkKIGNyZWF0ZSBtb2RlIDEw
MDY0NCBzYW1wbGUvc2FtcGxlLWtleXMvY2xpZW50LXBhc3Mua2V5CiBjcmVhdGUgbW9kZSAxMDA2
NDQgc2FtcGxlL3NhbXBsZS1rZXlzL2NsaWVudC5wMTIKIGRlbGV0ZSBtb2RlIDEwMDY0NCBzYW1w
bGUvc2FtcGxlLWtleXMvZGgxMDI0LnBlbQogY3JlYXRlIG1vZGUgMTAwNjQ0IHNhbXBsZS9zYW1w
bGUta2V5cy9kaDIwNDgucGVtCiBkZWxldGUgbW9kZSAxMDA2NDQgc2FtcGxlL3NhbXBsZS1rZXlz
L2VjLWNhLmNydAogZGVsZXRlIG1vZGUgMTAwNjQ0IHNhbXBsZS9zYW1wbGUta2V5cy9lYy1jYS5r
ZXkKIGRlbGV0ZSBtb2RlIDEwMDY0NCBzYW1wbGUvc2FtcGxlLWtleXMvZWMtY2xpZW50LmNydAog
ZGVsZXRlIG1vZGUgMTAwNjQ0IHNhbXBsZS9zYW1wbGUta2V5cy9lYy1jbGllbnQua2V5CiBkZWxl
dGUgbW9kZSAxMDA2NDQgc2FtcGxlL3NhbXBsZS1rZXlzL2VjLXNlcnZlci5jcnQKIGRlbGV0ZSBt
b2RlIDEwMDY0NCBzYW1wbGUvc2FtcGxlLWtleXMvZWMtc2VydmVyLmtleQogY3JlYXRlIG1vZGUg
MTAwNzU1IHNhbXBsZS9zYW1wbGUta2V5cy9nZW4tc2FtcGxlLWtleXMuc2gKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBzYW1wbGUvc2FtcGxlLWtleXMvb3BlbnNzbC5jbmYKIGRlbGV0ZSBtb2RlIDEwMDY0
NCBzYW1wbGUvc2FtcGxlLWtleXMvcGFzcy5jcnQKIGRlbGV0ZSBtb2RlIDEwMDY0NCBzYW1wbGUv
c2FtcGxlLWtleXMvcGFzcy5rZXkKIGRlbGV0ZSBtb2RlIDEwMDY0NCBzYW1wbGUvc2FtcGxlLWtl
eXMvcGtjczEyLnAxMgogY3JlYXRlIG1vZGUgMTAwNjQ0IHNhbXBsZS9zYW1wbGUta2V5cy9zZXJ2
ZXItZWMuY3J0CiBjcmVhdGUgbW9kZSAxMDA2NDQgc2FtcGxlL3NhbXBsZS1rZXlzL3NlcnZlci1l
Yy5rZXkKCmRpZmYgLS1naXQgYS9zYW1wbGUvc2FtcGxlLWNvbmZpZy1maWxlcy9jbGllbnQuY29u
ZiBiL3NhbXBsZS9zYW1wbGUtY29uZmlnLWZpbGVzL2NsaWVudC5jb25mCmluZGV4IDU4YjIwMzgu
LjA1MGVmNjAgMTAwNjQ0Ci0tLSBhL3NhbXBsZS9zYW1wbGUtY29uZmlnLWZpbGVzL2NsaWVudC5j
b25mCisrKyBiL3NhbXBsZS9zYW1wbGUtY29uZmlnLWZpbGVzL2NsaWVudC5jb25mCkBAIC04OSwx
OCArODksMTkgQEAgY2EgY2EuY3J0CiBjZXJ0IGNsaWVudC5jcnQKIGtleSBjbGllbnQua2V5CiAK
LSMgVmVyaWZ5IHNlcnZlciBjZXJ0aWZpY2F0ZSBieSBjaGVja2luZwotIyB0aGF0IHRoZSBjZXJ0
aWNhdGUgaGFzIHRoZSBuc0NlcnRUeXBlCi0jIGZpZWxkIHNldCB0byAic2VydmVyIi4gIFRoaXMg
aXMgYW4KLSMgaW1wb3J0YW50IHByZWNhdXRpb24gdG8gcHJvdGVjdCBhZ2FpbnN0CisjIFZlcmlm
eSBzZXJ2ZXIgY2VydGlmaWNhdGUgYnkgY2hlY2tpbmcgdGhhdCB0aGUKKyMgY2VydGljYXRlIGhh
cyB0aGUgY29ycmVjdCBrZXkgdXNhZ2Ugc2V0LgorIyBUaGlzIGlzIGFuIGltcG9ydGFudCBwcmVj
YXV0aW9uIHRvIHByb3RlY3QgYWdhaW5zdAogIyBhIHBvdGVudGlhbCBhdHRhY2sgZGlzY3Vzc2Vk
IGhlcmU6CiAjICBodHRwOi8vb3BlbnZwbi5uZXQvaG93dG8uaHRtbCNtaXRtCiAjCiAjIFRvIHVz
ZSB0aGlzIGZlYXR1cmUsIHlvdSB3aWxsIG5lZWQgdG8gZ2VuZXJhdGUKLSMgeW91ciBzZXJ2ZXIg
Y2VydGlmaWNhdGVzIHdpdGggdGhlIG5zQ2VydFR5cGUKLSMgZmllbGQgc2V0IHRvICJzZXJ2ZXIi
LiAgVGhlIGJ1aWxkLWtleS1zZXJ2ZXIKLSMgc2NyaXB0IGluIHRoZSBlYXN5LXJzYSBmb2xkZXIg
d2lsbCBkbyB0aGlzLgotbnMtY2VydC10eXBlIHNlcnZlcgorIyB5b3VyIHNlcnZlciBjZXJ0aWZp
Y2F0ZXMgd2l0aCB0aGUga2V5VXNhZ2Ugc2V0IHRvCisjICAgZGlnaXRhbFNpZ25hdHVyZSwga2V5
RW5jaXBoZXJtZW50CisjIGFuZCB0aGUgZXh0ZW5kZWRLZXlVc2FnZSB0bworIyAgIHNlcnZlckF1
dGgKKyMgRWFzeVJTQSBjYW4gZG8gdGhpcyBmb3IgeW91LgorcmVtb3RlLWNlcnQtdGxzIHNlcnZl
cgogCiAjIElmIGEgdGxzLWF1dGgga2V5IGlzIHVzZWQgb24gdGhlIHNlcnZlcgogIyB0aGVuIGV2
ZXJ5IGNsaWVudCBtdXN0IGFsc28gaGF2ZSB0aGUga2V5LgpkaWZmIC0tZ2l0IGEvc2FtcGxlL3Nh
bXBsZS1jb25maWctZmlsZXMvbG9vcGJhY2stY2xpZW50IGIvc2FtcGxlL3NhbXBsZS1jb25maWct
ZmlsZXMvbG9vcGJhY2stY2xpZW50CmluZGV4IGQ3ZjU5ZTYuLmViYmQxY2YgMTAwNjQ0Ci0tLSBh
L3NhbXBsZS9zYW1wbGUtY29uZmlnLWZpbGVzL2xvb3BiYWNrLWNsaWVudAorKysgYi9zYW1wbGUv
c2FtcGxlLWNvbmZpZy1maWxlcy9sb29wYmFjay1jbGllbnQKQEAgLTE3LDkgKzE3LDkgQEAgZGV2
IG51bGwKIHZlcmIgMwogcmVuZWctc2VjIDEwCiB0bHMtY2xpZW50CityZW1vdGUtY2VydC10bHMg
c2VydmVyCiBjYSBzYW1wbGUta2V5cy9jYS5jcnQKIGtleSBzYW1wbGUta2V5cy9jbGllbnQua2V5
CiBjZXJ0IHNhbXBsZS1rZXlzL2NsaWVudC5jcnQKLWNpcGhlciBERVMtRURFMy1DQkMKIHBpbmcg
MQogaW5hY3RpdmUgMTIwIDEwMDAwMDAwCmRpZmYgLS1naXQgYS9zYW1wbGUvc2FtcGxlLWNvbmZp
Zy1maWxlcy9sb29wYmFjay1zZXJ2ZXIgYi9zYW1wbGUvc2FtcGxlLWNvbmZpZy1maWxlcy9sb29w
YmFjay1zZXJ2ZXIKaW5kZXggOWQyMWJjZS4uOGNiOTdiZSAxMDA2NDQKLS0tIGEvc2FtcGxlL3Nh
bXBsZS1jb25maWctZmlsZXMvbG9vcGJhY2stc2VydmVyCisrKyBiL3NhbXBsZS9zYW1wbGUtY29u
ZmlnLWZpbGVzL2xvb3BiYWNrLXNlcnZlcgpAQCAtMTcsMTAgKzE3LDkgQEAgZGV2IG51bGwKIHZl
cmIgMwogcmVuZWctc2VjIDEwCiB0bHMtc2VydmVyCi1kaCBzYW1wbGUta2V5cy9kaDEwMjQucGVt
CitkaCBzYW1wbGUta2V5cy9kaDIwNDgucGVtCiBjYSBzYW1wbGUta2V5cy9jYS5jcnQKIGtleSBz
YW1wbGUta2V5cy9zZXJ2ZXIua2V5CiBjZXJ0IHNhbXBsZS1rZXlzL3NlcnZlci5jcnQKLWNpcGhl
ciBERVMtRURFMy1DQkMKIHBpbmcgMQogaW5hY3RpdmUgMTIwIDEwMDAwMDAwCmRpZmYgLS1naXQg
YS9zYW1wbGUvc2FtcGxlLWNvbmZpZy1maWxlcy9zZXJ2ZXIuY29uZiBiL3NhbXBsZS9zYW1wbGUt
Y29uZmlnLWZpbGVzL3NlcnZlci5jb25mCmluZGV4IDQ2N2Q1YjguLjcwMWJlM2MgMTAwNjQ0Ci0t
LSBhL3NhbXBsZS9zYW1wbGUtY29uZmlnLWZpbGVzL3NlcnZlci5jb25mCisrKyBiL3NhbXBsZS9z
YW1wbGUtY29uZmlnLWZpbGVzL3NlcnZlci5jb25mCkBAIC04MSwxMCArODEsOCBAQCBrZXkgc2Vy
dmVyLmtleSAgIyBUaGlzIGZpbGUgc2hvdWxkIGJlIGtlcHQgc2VjcmV0CiAKICMgRGlmZmllIGhl
bGxtYW4gcGFyYW1ldGVycy4KICMgR2VuZXJhdGUgeW91ciBvd24gd2l0aDoKLSMgICBvcGVuc3Ns
IGRocGFyYW0gLW91dCBkaDEwMjQucGVtIDEwMjQKLSMgU3Vic3RpdHV0ZSAyMDQ4IGZvciAxMDI0
IGlmIHlvdSBhcmUgdXNpbmcKLSMgMjA0OCBiaXQga2V5cy4KLWRoIGRoMTAyNC5wZW0KKyMgICBv
cGVuc3NsIGRocGFyYW0gLW91dCBkaDIwNDgucGVtIDIwNDgKK2RoIGRoMjA0OC5wZW0KIAogIyBO
ZXR3b3JrIHRvcG9sb2d5CiAjIFNob3VsZCBiZSBzdWJuZXQgKGFkZHJlc3NpbmcgdmlhIElQKQpk
aWZmIC0tZ2l0IGEvc2FtcGxlL3NhbXBsZS1jb25maWctZmlsZXMvdGxzLW9mZmljZS5jb25mIGIv
c2FtcGxlL3NhbXBsZS1jb25maWctZmlsZXMvdGxzLW9mZmljZS5jb25mCmluZGV4IGY3OTBmNDYu
LmQxOTYxNDQgMTAwNjQ0Ci0tLSBhL3NhbXBsZS9zYW1wbGUtY29uZmlnLWZpbGVzL3Rscy1vZmZp
Y2UuY29uZgorKysgYi9zYW1wbGUvc2FtcGxlLWNvbmZpZy1maWxlcy90bHMtb2ZmaWNlLmNvbmYK
QEAgLTI2LDcgKzI2LDcgQEAgdXAgLi9vZmZpY2UudXAKIHRscy1zZXJ2ZXIKIAogIyBEaWZmaWUt
SGVsbG1hbiBQYXJhbWV0ZXJzICh0bHMtc2VydmVyIG9ubHkpCi1kaCBkaDEwMjQucGVtCitkaCBk
aDIwNDgucGVtCiAKICMgQ2VydGlmaWNhdGUgQXV0aG9yaXR5IGZpbGUKIGNhIG15LWNhLmNydApk
aWZmIC0tZ2l0IGEvc2FtcGxlL3NhbXBsZS1rZXlzLy5naXRpZ25vcmUgYi9zYW1wbGUvc2FtcGxl
LWtleXMvLmdpdGlnbm9yZQpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5mMTQ4
NzUyCi0tLSAvZGV2L251bGwKKysrIGIvc2FtcGxlL3NhbXBsZS1rZXlzLy5naXRpZ25vcmUKQEAg
LTAsMCArMSBAQAorc2FtcGxlLWNhLwpkaWZmIC0tZ2l0IGEvc2FtcGxlL3NhbXBsZS1rZXlzL1JF
QURNRSBiL3NhbXBsZS9zYW1wbGUta2V5cy9SRUFETUUKaW5kZXggOWY0ZjkxOC4uNjZkZDk0NSAx
MDA2NDQKLS0tIGEvc2FtcGxlL3NhbXBsZS1rZXlzL1JFQURNRQorKysgYi9zYW1wbGUvc2FtcGxl
LWtleXMvUkVBRE1FCkBAIC0xLDE0ICsxLDE5IEBACiBTYW1wbGUgUlNBIGFuZCBFQyBrZXlzLgog
CitSdW4gLi9nZW4tc2FtcGxlLWtleXMuc2ggdG8gZ2VuZXJhdGUgZnJlc2ggdGVzdCBrZXlzLgor
CiBTZWUgdGhlIGV4YW1wbGVzIHNlY3Rpb24gb2YgdGhlIG1hbiBwYWdlIGZvciB1c2FnZSBleGFt
cGxlcy4KIAogTk9URTogVEhFU0UgS0VZUyBBUkUgRk9SIFRFU1RJTkcgUFVSUE9TRVMgT05MWS4K
ICAgICAgIERPTidUIFVTRSBUSEVNIEZPUiBBTlkgUkVBTCBXT1JLIEJFQ0FVU0UKICAgICAgIFRI
RVkgQVJFIFRPVEFMTFkgSU5TRUNVUkUhCiAKLWNhLntjcnQsa2V5fSAgICAgLS0gc2FtcGxlIENB
IGtleS9jZXJ0Ci1jbGllbnQue2NydCxrZXl9IC0tIHNhbXBsZSBjbGllbnQga2V5L2NlcnQKLXNl
cnZlci57Y3J0LGtleX0gLS0gc2FtcGxlIHNlcnZlciBrZXkvY2VydCAobnNDZXJ0VHlwZT1zZXJ2
ZXIpCi1wYXNzLntjcnQsa2V5fSAgIC0tIHNhbXBsZSBjbGllbnQga2V5L2NlcnQgd2l0aCBwYXNz
d29yZC1lbmNyeXB0ZWQga2V5Ci0gICAgICAgICAgICAgICAgICAgIHBhc3N3b3JkID0gInBhc3N3
b3JkIgotZWMtKi57Y3J0LGtleX0gICAtLSBzYW1wbGUgZWxsaXB0aWMgY3VydmUgdmFyaWFudHMg
b2YgdGhlIGFib3ZlCitjYS57Y3J0LGtleX0gICAgICAgIC0tIHNhbXBsZSBDQSBrZXkvY2VydAor
c2VydmVyLntjcnQsa2V5fSAgICAtLSBzYW1wbGUgc2VydmVyIGtleS9jZXJ0CitjbGllbnQue2Ny
dCxrZXl9ICAgIC0tIHNhbXBsZSBjbGllbnQga2V5L2NlcnQKK2NsaWVudC1wYXNzLmtleSAgICAg
LS0gc2FtcGxlIGNsaWVudCBrZXkgd2l0aCBwYXNzd29yZC1lbmNyeXB0ZWQga2V5CisgICAgICAg
ICAgICAgICAgICAgICAgIHBhc3N3b3JkID0gInBhc3N3b3JkIgorY2xpZW50LnAxMiAgICAgICAg
ICAtLSBzYW1wbGUgY2xpZW50IHBrY3MxMiBidW5kbGUKKyAgICAgICAgICAgICAgICAgICAgICAg
cGFzc3dvcmQgPSAicGFzc3dvcmQiCitjbGllbnQtZWMue2NydCxrZXl9IC0tIHNhbXBsZSBlbGxp
cHRpYyBjdXJ2ZSBjbGllbnQga2V5L2NlcnQKK3NlcnZlci1lYy57Y3J0LGtleX0gLS0gc2FtcGxl
IGVsbGlwdGljIGN1cnZlIHNlcnZlciBrZXkvY2VydApkaWZmIC0tZ2l0IGEvc2FtcGxlL3NhbXBs
ZS1rZXlzL2NhLmNydCBiL3NhbXBsZS9zYW1wbGUta2V5cy9jYS5jcnQKaW5kZXggZTA2M2NjYy4u
YTExYmFmYSAxMDA2NDQKLS0tIGEvc2FtcGxlL3NhbXBsZS1rZXlzL2NhLmNydAorKysgYi9zYW1w
bGUvc2FtcGxlLWtleXMvY2EuY3J0CkBAIC0xLDE5ICsxLDM1IEBACiAtLS0tLUJFR0lOIENFUlRJ
RklDQVRFLS0tLS0KLU1JSURCakNDQW0rZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRUUZBREJt
TVFzd0NRWURWUVFHRXdKTFJ6RUwKK01JSUdLRENDQkJDZ0F3SUJBZ0lKQUtGTzN2cVE4cTZCTUEw
R0NTcUdTSWIzRFFFQkN3VUFNR1l4Q3pBSkJnTlYKK0JBWVRBa3RITVFzd0NRWURWUVFJRXdKT1FU
RVFNQTRHQTFVRUJ4TUhRa2xUU0V0RlN6RVZNQk1HQTFVRUNoTU0KK1QzQmxibFpRVGkxVVJWTlVN
U0V3SHdZSktvWklodmNOQVFrQkZoSnRaVUJ0ZVdodmMzUXViWGxrYjIxaGFXNHcKK0hoY05NVFF4
TURJeU1qRTFPVFV5V2hjTk1qUXhNREU1TWpFMU9UVXlXakJtTVFzd0NRWURWUVFHRXdKTFJ6RUwK
IE1Ba0dBMVVFQ0JNQ1RrRXhFREFPQmdOVkJBY1RCMEpKVTBoTFJVc3hGVEFUQmdOVkJBb1RERTl3
Wlc1V1VFNHQKLVZFVlRWREVoTUI4R0NTcUdTSWIzRFFFSkFSWVNiV1ZBYlhsb2IzTjBMbTE1Wkc5
dFlXbHVNQjRYRFRBME1URXkKLU5URTBOREExTlZvWERURTBNVEV5TXpFME5EQTFOVm93WmpFTE1B
a0dBMVVFQmhNQ1MwY3hDekFKQmdOVkJBZ1QKLUFrNUJNUkF3RGdZRFZRUUhFd2RDU1ZOSVMwVkxN
UlV3RXdZRFZRUUtFd3hQY0dWdVZsQk9MVlJGVTFReElUQWYKLUJna3Foa2lHOXcwQkNRRVdFbTFs
UUcxNWFHOXpkQzV0ZVdSdmJXRnBiakNCbnpBTkJna3Foa2lHOXcwQkFRRUYKLUFBT0JqUUF3Z1lr
Q2dZRUFxUGpXSm5lc1B1NmJSL2llYzRGTXozb3BWYVBkQkh4ZytPUktObXJuVlpQaDB0OC8KLVpU
MzRLWGtZb0k5Qjgyc2N1cnA4VWxaVlhHOEpkVXN6K3lhaTh0aTkrZzd2Y3V5S1V0Y0NJam4wSExn
bWRQdTUKLWdGWDI1bEIwcFh3K1hJVTAzMWRPZlB2dFJPZEc1WVpONXlDRXJnQ3k3VEU3em50TG5r
RUR1Um15VTZjQ0F3RUEKLUFhT0J3ekNCd0RBZEJnTlZIUTRFRmdRVWlhWmc0N3JxUHEvOFpIOU12
WXpTU0kzZ3pFWXdnWkFHQTFVZEl3U0IKLWlEQ0JoWUFVaWFaZzQ3cnFQcS84Wkg5TXZZelNTSTNn
ekVhaGFxUm9NR1l4Q3pBSkJnTlZCQVlUQWt0SE1Rc3cKLUNRWURWUVFJRXdKT1FURVFNQTRHQTFV
RUJ4TUhRa2xUU0V0RlN6RVZNQk1HQTFVRUNoTU1UM0JsYmxaUVRpMVUKLVJWTlVNU0V3SHdZSktv
WklodmNOQVFrQkZoSnRaVUJ0ZVdodmMzUXViWGxrYjIxaGFXNkNBUUF3REFZRFZSMFQKLUJBVXdB
d0VCL3pBTkJna3Foa2lHOXcwQkFRUUZBQU9CZ1FCZkpvaVdZcllkak0wbUtQRXpVUWswbkxZVG92
QlAKLUkwZXMvMnJmR3JpbjF6YmNGWSs0ZGhWQmQxRS9TdGVibkcrQ1A4cjdRZUVJd3U3eDhnWURk
T0xMc1puKzJ2QkwKLWU0ak5VMUNsSTZRMEw3anJ6aGh1blE1bUFhWnp0VnlZd0ZCMTVvZFljZE4y
aU8wdFA3anRFc3ZyUnF4SUNOeTMKLThpdHpWaVBUZjVXNHNBPT0KK1ZFVlRWREVoTUI4R0NTcUdT
SWIzRFFFSkFSWVNiV1ZBYlhsb2IzTjBMbTE1Wkc5dFlXbHVNSUlDSWpBTkJna3EKK2hraUc5dzBC
QVFFRkFBT0NBZzhBTUlJQ0NnS0NBZ0VBc0pWUENxdDN2dG9EVzJVMERJSTFRSWgyUXMwZHFoODgK
KzhuaXZ4QUltMkxUcTkzZTlmSmhzcTNQL1VWWUFZU2VDSXJla1h5cFIwRVFnU2djTlR2R0JNZTIw
Qm9ITzV5dmIKK0dqS1BtamZMajZYUm90Q09HeThFRGwvaExnUlk5ZWZpQTh3c1ZmdXZGMnEvRmJs
eUpRUFIvZ1BpRHRUbVVpcUYKK3FYYTdBSm1NcnFGc25XcHBPdUdkN1FjNmFUc2FlNFRGMWUvZ1VU
Q1RyYWE3TmVIb3dEYUtoZHlGbUVFbkNZUjUKK0NlVXN4MkpsRldBSDhQQ3J4QnBIWWJtR3l2UzBr
SDMrclFrYVNNL1B6YzJiUzRheUhhT1lSSzVYc0dxOFhpTkcKK0tUVExuU2FDZFBlSHNJKzN4TUht
RWgrdTVPZzJERkdndnlEMjJnZGU2VzJlenZFS0NVRHJ6Ujdic25ZcXF5VXkKK243THhua1BYR3l2
UjUyVDA2RzhLekxLUVJtRGxQSVhoektNTzA3cWtIbUlvblhUZEY3WUkxYXp3SHBBdE40ZFMKK3JV
ZTFidmppVFNvRXNRUGZPQXl2RDBSTUsvQ0JmZ0VaVXpBQjUwZS9JbGJaODRjMERKZlVNT200eEN5
ZnQxSEYKK1lwWWV5Q2Y1ZHhvSWp3ZUNQT29QNDI2K2FUWE03a3FxMGllSXI2WXhuS1Y2T0dHTEtF
WStWTlpoMURTN2VucVYKK0hQNWk4ZWlteXVVWVBvUWhiSzl4dERHTWdnaG5jNkhuOEJsZFBNY3Z6
OThIZFRFSDRyQmZBM3lOdUN4TFNOb3cKKzRqSnVMak5YaDJRZWlVdFd0a1hqYTdlYytQN1ZxS1Rk
dUpvUmFYN2NzKzhFM0ltaWdpUm52bUsrbnBrN050MXkKK1lFOWhCUmhTb0xzQ0F3RUFBYU9CMkRD
QjFUQWRCZ05WSFE0RUZnUVVLMERseVgzMTlKWTQ2Uy9qTDlsQVpNbU8KK0Jac3dnWmdHQTFVZEl3
U0JrRENCallBVUswRGx5WDMxOUpZNDZTL2pMOWxBWk1tT0JadWhhcVJvTUdZeEN6QUoKK0JnTlZC
QVlUQWt0SE1Rc3dDUVlEVlFRSUV3Sk9RVEVRTUE0R0ExVUVCeE1IUWtsVFNFdEZTekVWTUJNR0Ex
VUUKK0NoTU1UM0JsYmxaUVRpMVVSVk5VTVNFd0h3WUpLb1pJaHZjTkFRa0JGaEp0WlVCdGVXaHZj
M1F1Ylhsa2IyMWgKK2FXNkNDUUNoVHQ3NmtQS3VnVEFNQmdOVkhSTUVCVEFEQVFIL01Bc0dBMVVk
RHdRRUF3SUJCakFOQmdrcWhraUcKKzl3MEJBUXNGQUFPQ0FnRUFCYzc3ZjRDNFA4ZklTK1Y4cUNK
bVZOU0RVNDRVWkJjK0QrSjZaVGdXOEplT0hVSWoKK0JoKytYRGczZ3dhdDdwSVdROEFVNVI3aCtm
cEJJOW4zZGFkeUlzTUhHd1NvZ0hZOUd3N2RpMlJWdFNGYWpFdGgKK3J2cnEwSmJ6cHdvWWVkTWg4
NHNKMnFJL0RHS1c5L0lzOStPNTJmUiszejNkWTNnTlJEUFE1Njc1QlE1Q1FXOUkKK0FKZ0xPcXpE
OFEwcXJYWWk3SGFFcXpOeDZwN1JEVHVoRmd2VGQrdlM1ZDUrMjhaNWZtMnVtbnErR0tIRjhXNVAK
K3lscDJKczExOUZUVk83YnJ1c0FNS1BlNWVtYzd0QzJvdjhPRkZlbVF2ZkhSNDFQTHJ5YXAyVkQ4
MUlPZ210L0oKK2tYL2oveTVLR3V4NUhaM2x4WHFkSmJLY0FxNE5LWVFUMG1Da1JENGw2c3phQ0VK
K2swU2lNOURkVGNCRGVmaFIKKzlxK3BDT3lNaDdkOFFqUTEwNzVtRjdUK1BHa1pRVVcxRFVqRWZy
WmhJQ25LZ3EraUVvVW1NMEVlNVd0UnFjbnUKKzVCVEdRMm1TZmM2clYrVnIrZVlYcWNnN054YjN2
RlhZU1RvZDFVaGVmb25WcXdkbXlKMnNDNzl6cDM2VGJvMisKKzY1TlcyV0pLN0t6UFV5T0pVMFU5
YmN1MHV0dkRPdkdXbUcrYUhieW1KZ2NvRnp2Wm1sWHFNWG45N3BTRm40alYKK3kzU0xSZ0pYT3cx
UUxYTDJZNWFiY3VvQlZyNGdDT3h4azJ2QmVWeE9NUlhOcVNXWk9GSUYxYnUvUHh1REErU2EKK2hF
aTQ0YUhiUFh0OW9wZHNzei9oZEdmZDhXbzd2RUpyYmc3YzZ6UjZDL0FrYXYxUnp5OW9vaElkZ093
PQogLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQpkaWZmIC0tZ2l0IGEvc2FtcGxlL3NhbXBsZS1r
ZXlzL2NhLmtleSBiL3NhbXBsZS9zYW1wbGUta2V5cy9jYS5rZXkKaW5kZXggYjRiZjc5Mi4uOGIx
MWJjMiAxMDA2NDQKLS0tIGEvc2FtcGxlL3NhbXBsZS1rZXlzL2NhLmtleQorKysgYi9zYW1wbGUv
c2FtcGxlLWtleXMvY2Eua2V5CkBAIC0xLDE1ICsxLDUyIEBACi0tLS0tLUJFR0lOIFJTQSBQUklW
QVRFIEtFWS0tLS0tCi1NSUlDWFFJQkFBS0JnUUNvK05ZbWQ2dys3cHRIK0o1emdVelBlaWxWbzkw
RWZHRDQ1RW8yYXVkVmsrSFMzejlsCi1QZmdwZVJpZ2owSHpheHk2dW54U1ZsVmNid2wxU3pQN0px
THkyTDM2RHU5eTdJcFMxd0lpT2ZRY3VDWjArN21BCi1WZmJtVUhTbGZENWNoVFRmVjA1OCsrMUU1
MGJsaGszbklJU3VBTEx0TVR2T2UwdWVRUU81R2JKVHB3SURBUUFCCi1Bb0dBUXVWUkV5V3A0Ymho
YlpyMlVGQk9jbzJ3czZFT0xXcDRrZEQvdUkrV1NvRWpsSEtpREpqK0dKMUNyTDVLCi1vKzR5RDVN
cENRZjQvNEZPUTB1a3ByZmpKcER3RGluVEc2dnp1V1NMVEhOaVRndmtzVzN2eTdJc05NSng5N2hU
Ci00RDJRT09sOUhoQTUwUXFnNzB0ZU1QWVhPZ0xSTVZzZENJVjdwN3pETnk0bk0rRUNRUURYOG01
WmNRbVB0VURBCi0zOGRQVGZwTDRVN2tNQjk0Rkl0SllIL0xrNWtNVzEvSjMzeHltTmhMK0JIYUcw
NjRvbDluMnViR1c0WEVPNXQyCi1xRTFJT3NWcEFrRUF5RS94L09CVlNJMXM3NWFZR2xFd01kODdw
M3FhRGR0WFQ3V3p1ampSWTdyOFkxeW5rTVU2Ci1HdE1lbmVCWC9sazRCWS82SSs1YmhBemNlK2hx
aGFYZWp3SkJBTDVXZytjNEdBcGY0MXhkb2dxSG03ZG9OeVl3Ci1PSHlaOXc5TkREYyt1R2JJMzB4
TFBTQ3hFZTBjRVhnaUc2Zm9EcG0ydXpSWkZUV2FxSFBVOHBGWXBBa0NRR05YCi1jcFdNMC83VlZL
OUZxazF5OGtucGdmWS9VV09KNGpVLzBkQ0xHUjB5d0xTdVlOUGxYRG10ZGtPcDNUbmhHVzE0Ci14
LzlGMk5FV1o4cHpxMUI0d0hVQ1FRQzV6dEQ0bS9ycGlJcGlub2V3VUpPRG9lQkpYWUJLcXgxK21k
ckFMQ3E2Ci1FU3ZLMVdSaXVzTWFZM3htc2R2NEoyVEI1aVVQcnlFTGJuM2pVMTJXR2NRYwotLS0t
LS1FTkQgUlNBIFBSSVZBVEUgS0VZLS0tLS0KKy0tLS0tQkVHSU4gUFJJVkFURSBLRVktLS0tLQor
TUlJSlF3SUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NDUzB3Z2drcEFnRUFBb0lDQVFDd2xVOEtx
M2UrMmdOYgorWlRRTWdqVkFpSFpDelIycUh6enllSy9FQWliWXRPcjNkNzE4bUd5cmMvOVJWZ0Jo
SjRJaXQ2UmZLbEhRUkNCSworQncxTzhZRXg3YlFHZ2M3bks5c2FNbythTjh1UHBkR2kwSTRiTHdR
T1grRXVCRmoxNStJRHpDeFYrNjhYYXI4VgordVhJbEE5SCtBK0lPMU9aU0tvV3BkcnNBbVl5dW9X
eWRhbWs2NFozdEJ6cHBPeHA3aE1YVjcrQlJNSk90cHJzMQorNGVqQU5vcUYzSVdZUVNjSmhIa0o1
U3pIWW1VVllBZnc4S3ZFR2tkaHVZYks5TFNRZmY2dENScEl6OC9Oelp0TAoraHJJZG81aEVybGV3
YXJ4ZUkwWXBOTXVkSm9KMDk0ZXdqN2ZFd2VZU0g2N2s2RFlNVWFDL0lQYmFCMTdwYlo3TworOFFv
SlFPdk5IdHV5ZGlxckpUS2ZzdkdlUTljYks5SG5aUFRvYndyTXNwQkdZT1U4aGVITW93N1R1cVFl
WWlpZAorZE4wWHRnalZyUEFla0MwM2gxS3RSN1Z1K09KTktnU3hBOTg0REs4UFJFd3I4SUYrQVJs
VE1BSG5SNzhpVnRuegoraHpRTWw5UXc2YmpFTEorM1VjVmlsaDdJSi9sM0dnaVBCNEk4NmcvamJy
NXBOY3p1U3FyU0o0aXZwakdjcFhvNAorWVlzb1JqNVUxbUhVTkx0NmVwVWMvbUx4NktiSzVSZyto
Q0ZzcjNHME1ZeUNDR2R6b2Vmd0dWMDh4eS9QM3dkMQorTVFmaXNGOERmSTI0TEV0STJqRGlNbTR1
TTFlSFpCNkpTMWEyUmVOcnQ1ejQvdFdvcE4yNG1oRnBmdHl6N3dUYworaWFLQ0pHZStZcjZlbVRz
MjNYSmdUMkVGR0ZLZ3V3SURBUUFCQW9JQ0FRQ0VZUHFuaWhJMFBxWmpud1FkR0lRcAorZytQOGds
N3B5WTljUzBPaFV1ZWljRWJ5REk4K1Y5cW4wa2NteDYxektEWTBKcTRRTmQ2dG5sVUNpalRjNk1v
dAorRHdGMkcxeHNDNEd2S3haaXk4OU1Pa2hsb2FuWEVURWVRWnpEYmJqdmFNNFVnTDBBSExXUGZa
UVJDanhiS1hrRQorMEE1cGhndkFyMllTdkJMSENWWGhHTjBmU2NYbndYb3VWc3ZnVmRHdHBjVFdk
SVVhK0tyTmRRQkdEYno2VkNrVworMzFJNzZTUUZ5NDBkOFBQWDZaalVKSER2bk0xNEx5Y3lTTzZY
T2tvZlJJVm5YVHFhT1VpVkJiMlZLajVmWCtSbworSUxkV1p6NGQ2SjNSaUdYWXd5VHI0U0dWS0xq
Z3hXZmdVR1pCN3grTnJxZ3VnTnp1YUxZcmt1V0tTRU40Mm5XcQoreW9QNng2eHRiQXNtQjZGdmRx
d20vZDhCbUxoVXdlYVZjMEw3QVl6WE5zT0J1VDNrdWJKSE1tdTNKdjR4Z3lXaworbC9NQUdKUWM3
aTdRUXdlR2dzWVpnUjhXbGJrV2tTRnBVY2dRQkR6RGliYjZuc0Qyam5ZaWpRcm5ycm1pRWpFSQor
UjdNTzU1MVYrbkZ3OXV0aU04VTlXSVd3cXpZMGQ5OHVqV2tHalZlN3V6OVpCVnlnMERFQUVqL3pS
aTlUNTRhRworMVY2Q0IyQ2p5dytIenpzRHc3eVdyb1d6bzRVOVlmamJQS0NvQnNYbHFRRkxGd1k4
b0w2bUVaN1VPb2JhVjFabAorV3R1SHlZdzNVTkZ4dVNHUFB5eEprRmVQSVFMTHZmS3ZoMlIrVjBE
clQzVUpSb0tLbHQ5UmVqUlNOMHRPaDBDbQorMllENmQ3VC9EWG5RSG9tSVFLaEtFUUtDQVFFQTNz
Z3NEZzBlS0RLOHBVeVZFKzl3VzVrcWwxMm5UenBCdG5DTQorZWc1SjlPSmNYS2hDRC9OSXlVVElN
WG9NdlpRcEx3R1VBWUxndTRnRTA0ektXSERvdWY3TVJTRmx0RDVMSjdGMgorN251WUtIWlhrMEJo
Z01oZG5Rb3QzRktjT01yS0NuWmNNK1JXWDlaSmE4d082d2hDYVlDdzdEdFMwU1NWT0RRaworOUV3
QWdYNi9IcTYwVjd1alBaSkN5TmQzbzBiSWRBQS8wQVFSVFpVQURQM0FIZ1V6aDcxYXlzWUp0K1VL
dDF2MAorWGM3bDZobjdEbjdFd3pwZitXZFoycFY3ZDNKVVNCVktpVER4TFY5MDRuREJOT3hqTWh6
MHJXMDFvalI2YnpwbgorWGhrRlBxbm1oK3lFWUdSZ2ZTQUF6a3ZTc1NKRUF0QkZTaWN1cEEvNm44
M0xvMll2c3dLQ0FRRUF5dW11eFA0WgorYTdzOHg4REZiYTd2dVErS1Z4cGtLZ0V6MXN4bkdSTlFK
bTE4L3NzL1k1SmlhTEZZVDNFNzJWa1FmQlEybmd1KworR3JKTDNPaGlOaHp5MUtMR1M2bXJ3VUx0
S2l1dWQ1TU1RREwwUHZrbmNyOU5UeTRyQm5XemhwMlh5UGVFVHU4bgorSnBMMmkyT0s2bFkvbGdw
QmNrWHVhcDlnQWwwZlhrK3krQmtaNzFPb1lhR25LcFBqcytYY3EvcWdQZ1o3TzNOVworMWcrQmQy
QVZQU3hRcFhqdXk1cmd0UVVSQ043MzN2a05CekZlZEtSRXg3WjZsOFVQbEsvRXh1YzdCTUlIZm41
VgorZGQwUjNUaCs4MmZrTU5WSno2TUttSEo2Q0pJNTNNN2NvL1lkQXZJa3hPRlJJUEdiTzNhckwy
UjY5blJnQVpCRQorekxhd3gxSkpUUklHMlFLQ0FRQVR0WlhnTUZ6b3BZUjNBMDExRkF2V3JyaEw1
K2N6WlM0SEcvSHhvbTM4a2tJbAorbUdVdjBCQXliamxmMXpKbFcwUkJlbHhEdmZadjROcThkSW82
Uk5MeUVZNjAxdjJPY3F4bmVKWFRCM0F3dERlUAorT1hUbTFkTWlYNUlyR2N2a1lseDVqSHNmeENX
NEdOY3FDRVdSbVl0MmxnSVJCRGFSZGpFVlpkZVhIVm8yR3FhQgorNm1iZUZDV2UvdCtWc1NwT2Nh
YXVUSTlZc2VOdC82NmZkNXVWakZSQXdBbldRcXI5Yi9BQXhNdmJ1TUF5YzlYNAorTkZMb0NyUU85
b3ZHZ004SmhEM2NtcldiYVk4TXVwTTJyVThLaFpkSkNiTEQzUk9QcENEbzBqdnU0VHZMalhCdAor
dWdrRUZoMUxOSmVkcUt1ZExERGtKdFRhZUpqeHZ0QW5ieWVDN3psdEFvSUJBQzlUSXl6VXFxOGlv
MEZmWjJ4MgorY1hpeTlDdnVmdEFCS2NyK0wwbDg1S09odzVaVlp2cGRLTkNNRkRHckVpOVdBMjg4
ODZRV3p3YkE4TXFiOUZQMAorbW5vWFlMSkM1MGtTeCtlZStuanU5ZHQvUnRIdElGTTE1TjBEd29z
bUpuSE9EWm1VaU9vMEF1aVBQQ3MwVXpEbQorWHJ3cXRpcmx2bjVsbjJuTnVFUXh5R2J1eThxeXMw
SGFCdmY2T0JBOEd5U05OcFJneEpzUUFuKzRiQlNnZHpPbQorUTBUa21LVXFBU0NYQnVzUHZiWG1W
akNJUmlSa0w1cDRwOHovNit0Y3QwTkFxTllxUHI4MHpjL0llS01reXc4UAorK3Z1Y3N6TlhMbUJ4
eXA1M0pFR29pWE5BTW5IK2NhN3RjaE9CNWhlUFRNdW4zcm5lV0luazBQY0I0T2NML1FhWgorbnJr
Q2dnRUJBTjY3K1N2Y1d0TTFCb0xYU3o1L2FwRkFFK0RpY0N2OTRQcnZNQk9oZnZ1MW9CckVsUjFy
QmppTgorMkI4M1NrdGtGNFdoQ1hyMTBHUCtSVXBqYXFQQnRUN05XNHIzZkw1QjhFUHNIZWFiTCtw
ZzllNndHMXJIOEdxRwordG9XZWNtZkM5dXFLN2wxQTU5aDVPdmVxNUsxOWJaVFJaUmpRdHYyZTRL
UWtubEpSNmN3eStUR1VVNWtBVWxNdAordmNpdnlqenhjMFVRd3E3ektrdEpxK3hXL1RaaVNMZ2Qz
QjMycDBzWFgzNzhxRlVKNFNPMlVaMU9DaDhSN1BZMQorRngyNUsvODlRMXlHZGJZaVhiL0R4MGEy
V0I5clArYjZhbE1sL2R4UGRxREtqMlFYWGtkaDgreXZoVnBRVHladworQjFSYXFRWHd6cXJDSDBG
L3Z3M2xSY2VZaGNRdnpjUT0KKy0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0KZGlmZiAtLWdpdCBh
L3NhbXBsZS9zYW1wbGUta2V5cy9jbGllbnQtZWMuY3J0IGIvc2FtcGxlL3NhbXBsZS1rZXlzL2Ns
aWVudC1lYy5jcnQKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uZWRjNmZlMwot
LS0gL2Rldi9udWxsCisrKyBiL3NhbXBsZS9zYW1wbGUta2V5cy9jbGllbnQtZWMuY3J0CkBAIC0w
LDAgKzEsODUgQEAKK0NlcnRpZmljYXRlOgorICAgIERhdGE6CisgICAgICAgIFZlcnNpb246IDMg
KDB4MikKKyAgICAgICAgU2VyaWFsIE51bWJlcjogNCAoMHg0KQorICAgIFNpZ25hdHVyZSBBbGdv
cml0aG06IHNoYTI1NldpdGhSU0FFbmNyeXB0aW9uCisgICAgICAgIElzc3VlcjogQz1LRywgU1Q9
TkEsIEw9QklTSEtFSywgTz1PcGVuVlBOLVRFU1QvZW1haWxBZGRyZXNzPW1lQG15aG9zdC5teWRv
bWFpbgorICAgICAgICBWYWxpZGl0eQorICAgICAgICAgICAgTm90IEJlZm9yZTogT2N0IDIyIDIx
OjU5OjUzIDIwMTQgR01UCisgICAgICAgICAgICBOb3QgQWZ0ZXIgOiBPY3QgMTkgMjE6NTk6NTMg
MjAyNCBHTVQKKyAgICAgICAgU3ViamVjdDogQz1LRywgU1Q9TkEsIE89T3BlblZQTi1URVNULCBD
Tj1UZXN0LUNsaWVudC1FQy9lbWFpbEFkZHJlc3M9bWVAbXlob3N0Lm15ZG9tYWluCisgICAgICAg
IFN1YmplY3QgUHVibGljIEtleSBJbmZvOgorICAgICAgICAgICAgUHVibGljIEtleSBBbGdvcml0
aG06IGlkLWVjUHVibGljS2V5CisgICAgICAgICAgICAgICAgUHVibGljLUtleTogKDI1NiBiaXQp
CisgICAgICAgICAgICAgICAgcHViOiAKKyAgICAgICAgICAgICAgICAgICAgMDQ6M2I6Y2U6NjI6
NWQ6NmY6ODc6ODI6NzU6MjQ6YzI6NTg6ZjU6MGU6ODg6CisgICAgICAgICAgICAgICAgICAgIDRk
OjU3OjBkOjA2OmIyOjcxOjg4Ojg3OjU4OjE5OmJiOmRlOjVmOjdmOjUyOgorICAgICAgICAgICAg
ICAgICAgICA2Mjo1MTphMjo0ODo5MTo4Mzo0ODo5MTo5MDozZTo4NzowMjowZjoxNTo1MToKKyAg
ICAgICAgICAgICAgICAgICAgZjk6Njg6OTc6MTI6MGE6ZmQ6ZDI6M2M6ODc6ODM6NGI6NjU6NTQ6
MDA6NDQ6CisgICAgICAgICAgICAgICAgICAgIDhkOjI4Ojc2OjQ5OjA1CisgICAgICAgICAgICAg
ICAgQVNOMSBPSUQ6IHNlY3AyNTZrMQorICAgICAgICBYNTA5djMgZXh0ZW5zaW9uczoKKyAgICAg
ICAgICAgIFg1MDl2MyBCYXNpYyBDb25zdHJhaW50czogCisgICAgICAgICAgICAgICAgQ0E6RkFM
U0UKKyAgICAgICAgICAgIFg1MDl2MyBTdWJqZWN0IEtleSBJZGVudGlmaWVyOiAKKyAgICAgICAg
ICAgICAgICA2NDpGNjo0OTo4ODpFNzo3NDpDMTpBQjpBNTpGQTo0RjoyQjo3MTozQzoyNToxMzoz
RDpDODo5NDpDNQorICAgICAgICAgICAgWDUwOXYzIEF1dGhvcml0eSBLZXkgSWRlbnRpZmllcjog
CisgICAgICAgICAgICAgICAga2V5aWQ6MkI6NDA6RTU6Qzk6N0Q6RjU6RjQ6OTY6Mzg6RTk6MkY6
RTM6MkY6RDk6NDA6NjQ6Qzk6OEU6MDU6OUIKKyAgICAgICAgICAgICAgICBEaXJOYW1lOi9DPUtH
L1NUPU5BL0w9QklTSEtFSy9PPU9wZW5WUE4tVEVTVC9lbWFpbEFkZHJlc3M9bWVAbXlob3N0Lm15
ZG9tYWluCisgICAgICAgICAgICAgICAgc2VyaWFsOkExOjRFOkRFOkZBOjkwOkYyOkFFOjgxCisK
KyAgICBTaWduYXR1cmUgQWxnb3JpdGhtOiBzaGEyNTZXaXRoUlNBRW5jcnlwdGlvbgorICAgICAg
ICAgMzI6M2Q6ZjA6MDg6Njc6ZGQ6MDM6NzM6NzY6Y2M6NzY6NTI6MGE6ZjY6OTc6ZDE6YzY6ZmE6
CisgICAgICAgICA1ZjpkMzplNjoyODpjOTo3NTphNzowODphODozNDo0OTo2OTpjZjplYjphYjpk
YTo4NjpiMzoKKyAgICAgICAgIDJlOjY1OjE3OmVlOjdlOmI2OmI1OjZiOjE1OjBiOmRjOjExOjNh
OmI5OjVhOmIzOjgwOmI4OgorICAgICAgICAgYmI6ZjQ6NmM6Y2Y6ODg6M2E6MTA6ODM6N2U6MTA6
YTA6ODI6ODc6NmU6MDY6ZWM6Nzg6NjI6CisgICAgICAgICBkNDpkMTo0NDoyNzpkZDoyYzoxOTpk
ODoxYTphMTphZTpmNDphMDowMDo3Zjo1Mzo1YTo0MDoKKyAgICAgICAgIDhhOmMyOjgzOjc3OjRi
OjI2OjdkOjUzOmIwOmQzOjBmOjJmOjdjOjI4OjcwOmVmOjc0OjU4OgorICAgICAgICAgNWI6ZGU6
ODE6OTQ6NGM6NjM6MTk6ZjA6Nzk6Y2I6NmM6YjI6ZWM6MzI6MWI6NGI6ZTQ6NjI6CisgICAgICAg
ICAyMjo0ZjphZDphYzo0YTo2ZjphOTo2ZTpjNDoyYTo4ZDo4YTo4ODoxOTowOTpmZDo4ODo5MzoK
KyAgICAgICAgIDNjOjI3OjRkOjkxOjk1OmZmOjU3Ojg0OjEzOmZkOjRhOjY4OmRiOjIwOmRmOjEw
OmU2OjgxOgorICAgICAgICAgMWQ6ZmQ6ZTc6MWQ6MzU6ZmI6MTk6MDI6ZGQ6YjU6NWY6YTA6YzE6
MDc6ZWM6NzQ6YjQ6ZWY6CisgICAgICAgICA4YjpmOTozMzo5YTpmMjphNjozYjo2ZTpiNjo0YTo1
MjphYjo1ZDo5OTo3Njo2NDo2MjpjNDoKKyAgICAgICAgIGQ1OjNhOmM2OjgxOjhkOmViOmM4OjRi
OjAyOmFmOmUxOmNhOjYwOmU5OjhkOmM3OmE5OjJiOgorICAgICAgICAgZWE6NGY6NTY6MzE6ZDM6
OWE6MTE6YzI6OWM6ODM6NWM6YTI6OGQ6OTg6ZmU6Y2M6YTU6YWQ6CisgICAgICAgICAxZjo1MTpj
NDo2ZTpjZjpmZjphMDo1MTo2NDpjODo3Zjo3ZjozMjowNTo0Yzo4ZDo3ZjpiZjoKKyAgICAgICAg
IGI4OmVkOmU1OjgxOjVmOjgxOmJkOjFkOjliOjNmOjhhOjgzOjI3OjI2OmI0OjY5Ojg0OjhiOgor
ICAgICAgICAgZTU6ZDk6ZWE6ZmQ6MDg6YTg6YWE6ZTQ6M2E6ZGM6Mjk6NGQ6ODA6NmM6MTM6Zjc6
NDU6Y2U6CisgICAgICAgICA5MjpmMjphOTpmMzo1Zjo5MDo4MzpkNjoyMzowZjo1MDplNTo0MDow
OTo0Yzo2YjpmMjo3MzoKKyAgICAgICAgIGFhOmQ4OjQ5OmE3OmE5OjgxOjZlOmJiOmYyOmU0OmE1
OjdmOjE5OjM5OjFkOjY1OmYzOjExOgorICAgICAgICAgOTc6YjE6MmI6N2M6MmY6MzY6Nzc6N2Y6
NzU6ZmQ6ODg6NDQ6OTA6N2M6ZjI6MzM6OGQ6Y2Q6CisgICAgICAgICAyYzpmNjo3Njo2MDozMzpk
MzpmNDpiMzo4Yzo4MTpkNzo4NTo4OTpjYzpkNzpkNToyYzo5NDoKKyAgICAgICAgIGE5OjMxOjNm
OmQzOjYzOmE3OmRjOjgyOjNmOjBhOmQ4OmM1OjcxOjk3OjY5OjNiOmMxOjY5OgorICAgICAgICAg
Y2I6ZjA6MWI6YmU6MTU6YzA6YmU6YWE6ZmQ6ZTg6MTM6MmM6MGM6M2Y6NzI6N2I6N2Q6OWM6Cisg
ICAgICAgICAzYjo3ZjpiODo4MjozNjo0YjphZDo0ZDoxNjoxOTpiOToxYzpiMzoyZDpkNzo1Zjo4
YjpmODoKKyAgICAgICAgIDE0OmNlOmQ0OjEzOmU1OjgyOjdhOjFkOjQwOjI4OjA4OjY1OjRhOjE5
OmQ3OjdhOjM1OjA5OgorICAgICAgICAgZGI6MzY6NDg6NGI6OTY6NDQ6YmQ6MWY6MTI6YjI6Mzk6
MDg6MWU6NWI6NjY6MjU6OWI6ZTA6CisgICAgICAgICAxNjpkMzo3OTowNTplMzpmNjo5MDpkYTo5
NTo5NTozMzphMTo1MzphODozYzphOTpmMDpiMjoKKyAgICAgICAgIGY1OmQwOmFhOjgwOmEwOjk2
OmNhOjhjOjQ1OjYyOmMyOjc0OjA0OjkxOjY4OjI3OmZiOmU5OgorICAgICAgICAgOTc6YmU6M2E6
ODc6OGE6ODU6Mjg6MmQ6NmU6YTk6NjA6OWI6NjM6YmE6NjU6OTg6NWU6YmI6CisgICAgICAgICAw
MjplZTphYzpiYTpiZTpmNjo0MjoyNgorLS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCitNSUlF
U1RDQ0FqR2dBd0lCQWdJQkJEQU5CZ2txaGtpRzl3MEJBUXNGQURCbU1Rc3dDUVlEVlFRR0V3SkxS
ekVMCitNQWtHQTFVRUNCTUNUa0V4RURBT0JnTlZCQWNUQjBKSlUwaExSVXN4RlRBVEJnTlZCQW9U
REU5d1pXNVdVRTR0CitWRVZUVkRFaE1COEdDU3FHU0liM0RRRUpBUllTYldWQWJYbG9iM04wTG0x
NVpHOXRZV2x1TUI0WERURTBNVEF5CitNakl4TlRrMU0xb1hEVEkwTVRBeE9USXhOVGsxTTFvd2JU
RUxNQWtHQTFVRUJoTUNTMGN4Q3pBSkJnTlZCQWdUCitBazVCTVJVd0V3WURWUVFLRXd4UGNHVnVW
bEJPTFZSRlUxUXhGekFWQmdOVkJBTVREbFJsYzNRdFEyeHBaVzUwCitMVVZETVNFd0h3WUpLb1pJ
aHZjTkFRa0JGaEp0WlVCdGVXaHZjM1F1Ylhsa2IyMWhhVzR3VmpBUUJnY3Foa2pPCitQUUlCQmdV
cmdRUUFDZ05DQUFRN3ptSmRiNGVDZFNUQ1dQVU9pRTFYRFFheWNZaUhXQm03M2w5L1VtSlJva2lS
CitnMGlSa0Q2SEFnOFZVZmxvbHhJSy9kSThoNE5MWlZRQVJJMG9ka2tGbzRISU1JSEZNQWtHQTFV
ZEV3UUNNQUF3CitIUVlEVlIwT0JCWUVGR1QyU1lqbmRNR3JwZnBQSzNFOEpSTTl5SlRGTUlHWUJn
TlZIU01FZ1pBd2dZMkFGQ3RBCis1Y2w5OWZTV09Pa3Y0eS9aUUdUSmpnV2JvV3FrYURCbU1Rc3dD
UVlEVlFRR0V3SkxSekVMTUFrR0ExVUVDQk1DCitUa0V4RURBT0JnTlZCQWNUQjBKSlUwaExSVXN4
RlRBVEJnTlZCQW9UREU5d1pXNVdVRTR0VkVWVFZERWhNQjhHCitDU3FHU0liM0RRRUpBUllTYldW
QWJYbG9iM04wTG0xNVpHOXRZV2x1Z2drQW9VN2UrcER5cm9Fd0RRWUpLb1pJCitodmNOQVFFTEJR
QURnZ0lCQURJOThBaG4zUU56ZHN4MlVncjJsOUhHK2wvVDVpakpkYWNJcURSSmFjL3JxOXFHCitz
eTVsRis1K3RyVnJGUXZjRVRxNVdyT0F1THYwYk0rSU9oQ0RmaENnZ29kdUJ1eDRZdFRSUkNmZExC
bllHcUd1Cis5S0FBZjFOYVFJckNnM2RMSm4xVHNOTVBMM3dvY085MFdGdmVnWlJNWXhud2VjdHNz
dXd5RzB2a1lpSlByYXhLCitiNmx1eENxTmlvZ1pDZjJJa3p3blRaR1YvMWVFRS8xS2FOc2czeERt
Z1IzOTV4MDEreGtDM2JWZm9NRUg3SFMwCis3NHY1TTVyeXBqdHV0a3BTcTEyWmRtUml4TlU2eG9H
TjY4aExBcS9oeW1EcGpjZXBLK3BQVmpIVG1oSENuSU5jCitvbzJZL3N5bHJSOVJ4RzdQLzZCUlpN
aC9meklGVEkxL3Y3anQ1WUZmZ2IwZG16K0tneWNtdEdtRWkrWFo2djBJCitxS3JrT3R3cFRZQnNF
L2RGenBMeXFmTmZrSVBXSXc5UTVVQUpUR3Z5YzZyWVNhZXBnVzY3OHVTbGZ4azVIV1h6CitFWmV4
SzN3dk5uZC9kZjJJUkpCODhqT056U3oyZG1BejAvU3pqSUhYaFluTTE5VXNsS2t4UDlOanA5eUNQ
d3JZCit4WEdYYVR2QmFjdndHNzRWd0w2cS9lZ1RMQXcvY250OW5EdC91SUkyUzYxTkZobTVITE10
MTErTCtCVE8xQlBsCitnbm9kUUNnSVpVb1oxM28xQ2RzMlNFdVdSTDBmRXJJNUNCNWJaaVdiNEJi
VGVRWGo5cERhbFpVem9WT29QS253CitzdlhRcW9DZ2xzcU1SV0xDZEFTUmFDZjc2WmUrT29lS2hT
Z3RicWxnbTJPNlpaaGV1d0x1ckxxKzlrSW0KKy0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0KZGlm
ZiAtLWdpdCBhL3NhbXBsZS9zYW1wbGUta2V5cy9jbGllbnQtZWMua2V5IGIvc2FtcGxlL3NhbXBs
ZS1rZXlzL2NsaWVudC1lYy5rZXkKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4u
ODEzMTM4MAotLS0gL2Rldi9udWxsCisrKyBiL3NhbXBsZS9zYW1wbGUta2V5cy9jbGllbnQtZWMu
a2V5CkBAIC0wLDAgKzEsNSBAQAorLS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCitNSUdFQWdF
QU1CQUdCeXFHU000OUFnRUdCU3VCQkFBS0JHMHdhd0lCQVFRZzJSVmsvZDB5b2swODZNOWJMUElp
CitldTREZmNCVXdwaE9ua2plMS83VlNZK2hSQU5DQUFRN3ptSmRiNGVDZFNUQ1dQVU9pRTFYRFFh
eWNZaUhXQm03CiszbDkvVW1KUm9raVJnMGlSa0Q2SEFnOFZVZmxvbHhJSy9kSThoNE5MWlZRQVJJ
MG9ka2tGCistLS0tLUVORCBQUklWQVRFIEtFWS0tLS0tCmRpZmYgLS1naXQgYS9zYW1wbGUvc2Ft
cGxlLWtleXMvY2xpZW50LXBhc3Mua2V5IGIvc2FtcGxlL3NhbXBsZS1rZXlzL2NsaWVudC1wYXNz
LmtleQpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4yYmI4ZDRlCi0tLSAvZGV2
L251bGwKKysrIGIvc2FtcGxlL3NhbXBsZS1rZXlzL2NsaWVudC1wYXNzLmtleQpAQCAtMCwwICsx
LDMwIEBACistLS0tLUJFR0lOIFJTQSBQUklWQVRFIEtFWS0tLS0tCitQcm9jLVR5cGU6IDQsRU5D
UllQVEVECitERUstSW5mbzogQUVTLTI1Ni1DQkMsRUNDMUYyMDk4OTZGQzI2MjEyMzNGRkY2RjFG
RkQwNDUKKworaTZ0N1ZLVHlOTkVMVHZyQk80NjRlMDJuRmc5cnZZd3VteGQwc2ZxY1B0YUttUksy
bXJabUVkL1hoME52MVd5QgorUHl1Sm83OHFRaXhBdHhPYlJia1NOSU56VHI1QzhJRHJFNit3UVlD
Smludk81NFUwbytrc3YwdHN5TG5nejFjYgoraXM4WnFIWHJSZ0ozcUdGUVdtRlJ0RktGUXZTWE9U
RFgzZkxrRUI1M0hmZWJsUUN4QkNuSjgyU3A3aXZuVlIvagorUThxUVJ5MVJNYnpJTjB0ckVHZjBa
aTR0SEV2WEwxdTdZK29sUXpTbG1XV2FRdDIwaGhYVU9NTGhNdGxSc0FvNworQXdqbEU5NEpqQWZK
MXExZHdJY1JONGM5TGs4R2tpWDZ3N25EcFJBQ0RwazJTOGlmQ3FpNjllR2U0K2c3b3doTAorNzRi
Z3M2NFBtTTlhMnNOWHkxdjZXRTNjL3Q2c1NyWmlNdnJHc3FNbzRzQmxyUTlXWGUwTmFvbjdoZUJr
UGNkUworcHgwWUpqbnlCWEhNSUgrQVNtQUxTSjVKWHE5dnQyeFJGZjBkT3NHYXB4aFArN2JaSjVQ
d3lrL3lVdTV1SEZiTQorL2FCZW1sclpKemxLZVlpaXdwd3gyd2hRQXREd040MXpNRytyMjdFelNV
L0FhRFY0ME5QaXd3eWNwV3QvQnAxZQorejFhZzBKdVMwYW4rUEs0am1SRXR6VDVVNUJlQVZNOTF4
OFl0dE9QcG1VSXBhaEFhMXp3ZFlQUkFJa2JtUEo0egorWkgrOVlvUEg0aG9CUUtkSWhzaFlrdGpk
SSsreE5pS1hBVUdVejVZb1g4UzY4U3NMZG1LdmhuUTdmdTVWdk9rQQorMnBiN3RhWEd5N3pmbith
L2ZXYXVodWNlVjlIUGxBWE1JdTNHc3NzT0RvTmx5M3ZwY0ZlaU15U0twcHlnSjNFZworQTNvOW44
VWVwRCtqWGZsS0cvUi90N1UzaFQ2THFTSXZRV3FCcVlNRVZGTUNOelNzSi9jZS80dmVGdngzNDN6
VAorcWR4dXpZcXlpWE03NGN5bnBmcUhkVmE5U0ZJQ1Rlc05kVkRJMEZkT1hoU1E0YkhKYzdYcDlG
RkpkUzBsTVJ3NAorQUN3S3h2czhsbzRHeDFXRnlDcUg1T3hvc0t0REhRWXpkVUpmU1dWSmxoaE9G
UjNHbmNSOXFTZTNPNWZraEpmcworVEFMbkMreFRKeUNrU0IyazAvYnhWTElobGtQZEN3enNyTi9C
NlgyQ0RCZGcwbVFJbzBMYVB6R0Y4Vm5lTTIwZAorWGViWW43NTFYU2lMM0hLeXE4RzVBRUZ3ajlB
TzNROGdLdVAyZlBvV2RuZ0oyR1QrbXQxbTJmSXc5SWd1MzlKMAorWk1lZ3lVTjB3U0lpQTVBa2dy
eUs5VStQSkVpSm1Mek9KL05HcjdFNXRQRjE4ZVpXYXBLNEtaOFRYQzRSTml5ZQorZythcEdhK3ha
SnoyVlFwL01yY2RqOUQ0VURKRlFqcnZLYVMwUFhKRG9ZVVhGQm9NdjNyeGlqelJWeGxoaHVKWQor
eVowQXQrVXFaRDV3cHVXVzZEUnJnSklweTBITmhiYUxtZ3NVMENvMEhLdmlCMHg4aHZNSmJpL3VD
b1BUT2RQegorc1BCN0NOMmkzb1hlN3h3MUhmU1RTRldiNGxlcWpsS3dOZ2ZWNDJveDBRVWpra0FE
ZWV1WSs1NmcvQjIrUW1kRQordlhyYzZzRHdmTlV3UlV6ZU1uOHlmdW0vYVcxeS93cnFGL3FQVEJR
cUZkODV2bHpTK05mWElLRGcwNGNBbGpUdQorKzJCTHp2aXpoOUJiNjhpRzRQeWtOWGJqYkFpcjFF
YlFHMXRDenExZUtoRVJqZ3J4ZHY2K1hxQW12Y2hNQ2VMNQorTDZodmZRRkJQQ28vNHhuTXBVNXdv
b0Zhck8va0dkS2xHcjVyWE95ZGdmTDYxOFRkMThCSVgrRkhRRmIzenpWVQoreTJOUjQrK0RzbEpB
WmdBVSs1MTJ6enBXMW0zSnRhUm95cXlvTEUyWUZQbFc4MDRYYzFQQkIzSXg2V3l6Y2VneQorRDRx
TWs1cXhqQmtYRXNCQlNDWWZWYldvTUJlTWhudnhrejBiOXdrUHRBVy9qRUpDQjJLa24vNXlNQzBE
a2VQTworLS0tLS1FTkQgUlNBIFBSSVZBVEUgS0VZLS0tLS0KZGlmZiAtLWdpdCBhL3NhbXBsZS9z
YW1wbGUta2V5cy9jbGllbnQuY3J0IGIvc2FtcGxlL3NhbXBsZS1rZXlzL2NsaWVudC5jcnQKaW5k
ZXggYzA0NzQ0Ni4uMTc0NGNiMiAxMDA2NDQKLS0tIGEvc2FtcGxlL3NhbXBsZS1rZXlzL2NsaWVu
dC5jcnQKKysrIGIvc2FtcGxlL3NhbXBsZS1rZXlzL2NsaWVudC5jcnQKQEAgLTIsNjQgKzIsMTAy
IEBAIENlcnRpZmljYXRlOgogICAgIERhdGE6CiAgICAgICAgIFZlcnNpb246IDMgKDB4MikKICAg
ICAgICAgU2VyaWFsIE51bWJlcjogMiAoMHgyKQotICAgICAgICBTaWduYXR1cmUgQWxnb3JpdGht
OiBtZDVXaXRoUlNBRW5jcnlwdGlvbgorICAgIFNpZ25hdHVyZSBBbGdvcml0aG06IHNoYTI1Nldp
dGhSU0FFbmNyeXB0aW9uCiAgICAgICAgIElzc3VlcjogQz1LRywgU1Q9TkEsIEw9QklTSEtFSywg
Tz1PcGVuVlBOLVRFU1QvZW1haWxBZGRyZXNzPW1lQG15aG9zdC5teWRvbWFpbgogICAgICAgICBW
YWxpZGl0eQotICAgICAgICAgICAgTm90IEJlZm9yZTogTm92IDI1IDE0OjQ2OjQ5IDIwMDQgR01U
Ci0gICAgICAgICAgICBOb3QgQWZ0ZXIgOiBOb3YgMjMgMTQ6NDY6NDkgMjAxNCBHTVQKKyAgICAg
ICAgICAgIE5vdCBCZWZvcmU6IE9jdCAyMiAyMTo1OTo1MyAyMDE0IEdNVAorICAgICAgICAgICAg
Tm90IEFmdGVyIDogT2N0IDE5IDIxOjU5OjUzIDIwMjQgR01UCiAgICAgICAgIFN1YmplY3Q6IEM9
S0csIFNUPU5BLCBPPU9wZW5WUE4tVEVTVCwgQ049VGVzdC1DbGllbnQvZW1haWxBZGRyZXNzPW1l
QG15aG9zdC5teWRvbWFpbgogICAgICAgICBTdWJqZWN0IFB1YmxpYyBLZXkgSW5mbzoKICAgICAg
ICAgICAgIFB1YmxpYyBLZXkgQWxnb3JpdGhtOiByc2FFbmNyeXB0aW9uCi0gICAgICAgICAgICBS
U0EgUHVibGljIEtleTogKDEwMjQgYml0KQotICAgICAgICAgICAgICAgIE1vZHVsdXMgKDEwMjQg
Yml0KToKLSAgICAgICAgICAgICAgICAgICAgMDA6ZDI6MTI6NWM6YzY6NGQ6MTM6MzQ6YWU6Y2Y6
ZmE6YWI6ZmU6Y2I6ZGU6Ci0gICAgICAgICAgICAgICAgICAgIDhjOmYxOjRiOjRhOjk1OjI4OjYw
Ojg3OjgyOjJjOmI4OmMxOmU1OjhlOmM2OgotICAgICAgICAgICAgICAgICAgICA1ZDoxMTo1ODo2
MTphNDphNTpmMTo0MjpkNzo4Njo3NDo2Yzo5ZDo5Yzo3YToKLSAgICAgICAgICAgICAgICAgICAg
ZjA6M2E6NWM6Mjk6ZTY6NTM6M2I6NWU6NmQ6ZDg6ZjA6NDU6MDY6MmM6MjM6Ci0gICAgICAgICAg
ICAgICAgICAgIGVlOjA5OmJjOjAyOjhmOjBlOmI4OmQ1OjMzOjFmOmMzOjRhOjExOjAyOjQ4Ogot
ICAgICAgICAgICAgICAgICAgICAwYjpjYzo0YjphZDo2ZTo3NDplMDphMjo1MzpiMTpkNjpjYzo4
OTpiOTplMjoKLSAgICAgICAgICAgICAgICAgICAgNmY6ZGI6MTU6YjM6MTk6MWU6NTc6MDQ6Nzk6
NDg6M2E6ZGE6NzY6MzE6ZmM6Ci0gICAgICAgICAgICAgICAgICAgIGJmOmQzOjM0OjIxOmU3OjMy
OmQ4OjllOjA2OjRlOmJlOmYzOmUzOjc5OmIwOgotICAgICAgICAgICAgICAgICAgICA1NDpmZDpk
MTo0MjozMjphYTozZTo3YTpjMQorICAgICAgICAgICAgICAgIFB1YmxpYy1LZXk6ICgyMDQ4IGJp
dCkKKyAgICAgICAgICAgICAgICBNb2R1bHVzOgorICAgICAgICAgICAgICAgICAgICAwMDplYzo2
NTo4ZjplOToxMjpjMjoxYTo1YjplNjo1NjoyYTowODphOTo4MjoKKyAgICAgICAgICAgICAgICAg
ICAgM2E6MmQ6NDQ6Nzg6YTM6MDA6M2I6YjA6OWY6ZTc6Mjc6MTA6NDA6OTM6ZWY6CisgICAgICAg
ICAgICAgICAgICAgIGYxOmNjOjNlOmEwOmFhOjA0OmEyOjgwOjFiOjEzOmE5OmU2OmZlOjgxOmQ2
OgorICAgICAgICAgICAgICAgICAgICA3MDo5MDphODpkODpkNDpkZTozMDpkODozNTowMDpkMjpi
ZTo2MjpmMDo0ODoKKyAgICAgICAgICAgICAgICAgICAgZGE6ZmM6MTU6OGQ6YzQ6YzY6NmQ6MGI6
OTk6ZjE6MmI6ODM6MDA6MGE6ZDM6CisgICAgICAgICAgICAgICAgICAgIDJhOjIzOjBiOmU1OmNk
OmY5OjM1OmRmOjQzOjYxOjE1OjcyOmFkOjk1Ojk4OgorICAgICAgICAgICAgICAgICAgICBmNjo3
MzoyMTo0MTo1ZTphMDpkZDo0NzoyNzphMDpkNTo5YTpkNDo0MTphODoKKyAgICAgICAgICAgICAg
ICAgICAgMWM6MWQ6NTc6MjA6NzE6MTc6OGY6Zjc6Mjg6OWU6M2U6MDc6Y2U6ZWM6ZDU6CisgICAg
ICAgICAgICAgICAgICAgIDBlOjQyOjRmOjFlOjc0OjQ3OjhlOjQ3OjlkOmQyOjE0OjI4OjI3OjJj
OjE0OgorICAgICAgICAgICAgICAgICAgICAxMDpmNTpkMTo5NjpiNTo5Mzo3NDo4NDplZjpmOTow
NDpkZTo4ZDo0YTo2ZjoKKyAgICAgICAgICAgICAgICAgICAgZGY6Nzc6YWI6ZWE6ZDE6NTg6ZDM6
NDQ6ZmU6NWE6MDQ6MDE6ZmY6MDY6N2E6CisgICAgICAgICAgICAgICAgICAgIDk3OmY3OmZkOmUz
OjU3OjQ4OmUxOmYwOmRmOjQwOjEzOjlmOjY2OjIzOjVhOgorICAgICAgICAgICAgICAgICAgICBl
Mzo1NTo1NDozZDo1NDozOTplZTowMDpmOToxMjpmMTpkMjpkZjo3NDoyZToKKyAgICAgICAgICAg
ICAgICAgICAgYmE6ZDc6ZjA6OGQ6YzY6ZGQ6MTg6NTg6MWM6OTM6MjI6MGI6NzU6ZmE6YTg6Cisg
ICAgICAgICAgICAgICAgICAgIGQ2OmUwOmI1OjJmOjJkOmI5OmQ0OmZlOmI5OjRmOjg2OmUyOjc1
OjQ4OjE2OgorICAgICAgICAgICAgICAgICAgICA2MDpmYjozZjpjOTpiNDozMDo0MjoyOTpmYjoz
YjpiMzoyYjpiOTo1OTo4MToKKyAgICAgICAgICAgICAgICAgICAgNmE6NDY6ZjM6NDU6ODM6YmY6
ZmQ6ZDU6MWE6ZmY6Mzc6MGM6NmY6NWI6ZmQ6CisgICAgICAgICAgICAgICAgICAgIDYxOmYxCiAg
ICAgICAgICAgICAgICAgRXhwb25lbnQ6IDY1NTM3ICgweDEwMDAxKQogICAgICAgICBYNTA5djMg
ZXh0ZW5zaW9uczoKICAgICAgICAgICAgIFg1MDl2MyBCYXNpYyBDb25zdHJhaW50czogCiAgICAg
ICAgICAgICAgICAgQ0E6RkFMU0UKLSAgICAgICAgICAgIE5ldHNjYXBlIENvbW1lbnQ6IAotICAg
ICAgICAgICAgICAgIE9wZW5TU0wgR2VuZXJhdGVkIENlcnRpZmljYXRlCiAgICAgICAgICAgICBY
NTA5djMgU3ViamVjdCBLZXkgSWRlbnRpZmllcjogCi0gICAgICAgICAgICAgICAgMTc6Qjc6M0Y6
Qzc6NjI6QTA6QTk6RkQ6QTQ6MzE6MEU6NTg6RDc6RDk6OTQ6N0I6NEI6M0Y6Q0I6NTYKKyAgICAg
ICAgICAgICAgICBEMjpCNDozNjowRjpCMTpGQzpERDpBNTpFQToyQTpGNzpDNzoyMzo4OTpGQTpF
MzpGQTo3QTo0NDoxRAogICAgICAgICAgICAgWDUwOXYzIEF1dGhvcml0eSBLZXkgSWRlbnRpZmll
cjogCi0gICAgICAgICAgICAgICAga2V5aWQ6ODk6QTY6NjA6RTM6QkE6RUE6M0U6QUY6RkM6NjQ6
N0Y6NEM6QkQ6OEM6RDI6NDg6OEQ6RTA6Q0M6NDYKKyAgICAgICAgICAgICAgICBrZXlpZDoyQjo0
MDpFNTpDOTo3RDpGNTpGNDo5NjozODpFOToyRjpFMzoyRjpEOTo0MDo2NDpDOTo4RTowNTo5Qgog
ICAgICAgICAgICAgICAgIERpck5hbWU6L0M9S0cvU1Q9TkEvTD1CSVNIS0VLL089T3BlblZQTi1U
RVNUL2VtYWlsQWRkcmVzcz1tZUBteWhvc3QubXlkb21haW4KLSAgICAgICAgICAgICAgICBzZXJp
YWw6MDAKKyAgICAgICAgICAgICAgICBzZXJpYWw6QTE6NEU6REU6RkE6OTA6RjI6QUU6ODEKIAot
ICAgIFNpZ25hdHVyZSBBbGdvcml0aG06IG1kNVdpdGhSU0FFbmNyeXB0aW9uCi0gICAgICAgIDYx
OmM2OmQxOmZhOjI0OjBmOmM3OmJlOjA5OjNiOmQ4OjA0OjE3OjYzOjMxOjE3OjA3OmY5OgotICAg
ICAgICA1Njo5OTphZjo0Yzo2NzpmYTpkYjpjYjo5NDpjZjo1NTphNTo3YjoxNjoyMDo4Yjo0Mjo2
NDoKLSAgICAgICAgMTM6MjM6NjI6NDU6Mjg6OTM6NWU6MzY6Zjc6ZGI6MDI6OTU6YTE6ZTk6ZmQ6
ZTM6MGY6OGQ6Ci0gICAgICAgIDczOmExOjdiOjBlOjU1Ojc4OjRkOmE1OmM0OmI3OjIyOjEyOmEw
OmVlOjU1OmUwOmI4OjBlOgotICAgICAgICBjOTo5YjoxMjplMzpiMDplZjo5Yjo2ODo5Mzo1Nzo2
ZTo2YzphZDoxNjo2ODo4ZTo4ZDozMDoKLSAgICAgICAgMzM6ZmU6MmE6MWI6YzM6MDM6OGY6YjY6
MGE6MmQ6MGM6YjE6M2M6YmI6Zjk6NTg6M2Y6OGM6Ci0gICAgICAgIDgxOjU5OjZiOjE0OmRkOjYy
OmI1OmMyOjkzOmVkOjVkOmM2OjE5OjBmOjliOjRiOjUyOmIzOgotICAgICAgICA3Yzo3OAorICAg
IFNpZ25hdHVyZSBBbGdvcml0aG06IHNoYTI1NldpdGhSU0FFbmNyeXB0aW9uCisgICAgICAgICA3
ZjplMDpmZTo4NDphNzplYzpkZjo2MjphNTpjZDozYzpjMTplNjo0MjpiMTozMToxMjpmMDoKKyAg
ICAgICAgIGI5OmRhOmE3OjllOjNmOmJkOjk2OjUyOmI2OmZjOjU1Ojc0OjY0OjNlOmU0OmZmOjdl
OmFhOgorICAgICAgICAgZjc6M2U6MDY6MTg6NWY6NzM6ODU6Zjg6Yzg6ZTA6Njc6MWI6NGQ6OTc6
Y2E6MDU6ZDA6Mzc6CisgICAgICAgICAwNzozMzo2NDo5YjplNjo3ODo3NzoxNDo5YTo1NTpiYjoy
YTphYzpjMzo3ZjpjOToxNTowODoKKyAgICAgICAgIDgzOjVjOmM4OmMyOjYxOmQzOjcxOjRjOjA1
OjBiOjJiOmNiOmEzOjg3OjZkOmEwOjMyOmVkOgorICAgICAgICAgYjA6YjM6Mjc6OTc6NGE6NTU6
OGQ6MDE6MmE6MzA6NTY6Njg6YWI6ZjI6ZGE6NWM6MTA6NzM6CisgICAgICAgICBjOTphYTowYTo5
Yzo0Yjo0YzphMDo1Yjo1MTo2ZTowYTo3ZTo2Yzo1Mzo4MDpiMDowMDplMToKKyAgICAgICAgIDFl
OjlhOjRjOjBhOjM3OjllOjIwOjg5OmJjOmM1OmU1Ojc5OjU4OmI3OjQ1OmZmOmQzOmM0OgorICAg
ICAgICAgYTE6ZmQ6ZDk6Nzg6M2Q6NDU6MTY6NzQ6ZGY6ODI6NDQ6MWQ6MWQ6ODE6NTA6NWE6Yjk6
MzI6CisgICAgICAgICA0YzplMjo0ZjozZjowZTozYTo2NTo1YTo2NDo4MzozYjoyOTozMTpjNDo5
OTo4ODpiYzpjNToKKyAgICAgICAgIDg0OjM5OmYyOjE5OjEyOmUxOjY2OmQwOmVhOmZiOjc1OmIx
OmQyOjI3OmJlOjkxOjU5OmEzOgorICAgICAgICAgMmI6MDk6ZDU6NWM6YmY6NDY6OGU6ZDY6Njc6
ZDY6MGI6ZWM6ZGE6YWI6ZjA6ODA6MTk6ODc6CisgICAgICAgICA2NDowNzphOTo3NzpiMTo1ZTow
YzplMjpjNToxZDo2YTphYzo1ZDoyMzpmMzozMDo3NTozNjoKKyAgICAgICAgIDRlOmNhOmMzOjRl
OmIwOjRkOjhjOjJjOmNlOjUyOjYxOjYzOmRlOmQ1OmY1OmVmOmVmOjBhOgorICAgICAgICAgNmI6
MjM6MjU6MjY6M2M6M2E6ZjI6YzM6YzI6MTY6MTk6M2Y6YTk6MzI6YmE6Njg6Zjk6Yzk6CisgICAg
ICAgICAxMjozYzozZTpjNjoxZjpmZjo5Yjo0ZTpmNDo5MDpiMDo2MzpmNTpkMTozMzowMDozMDo1
YToKKyAgICAgICAgIGU4OjI0OmZhOjM1OjQ0OjliOjZhOjgwOmYzOmE2OmNjOjdiOjNjOjczOjVm
OjUwOmM0OjMwOgorICAgICAgICAgNzE6ZDg6NzQ6OTA6Mjc6MGE6MDE6NGU6YTU6NWU6YjE6Zjg6
ZGE6YzI6NjE6ODE6MTE6YWU6CisgICAgICAgICAyOTphMzo4ZjpmYTo3ZTo0Yzo0ZTo2MjpiMTow
MDpkZTo5MjplMzo4Zjo2YToyZTpkYTpkOToKKyAgICAgICAgIDM4OjVkOjZiOjdjOjBkOmU0OjAx
OmFhOmM4OmM2OjZkOjhiOmNkOmMwOmM4OjZlOmU0OjU3OgorICAgICAgICAgMjE6OGE6ZjY6NDY6
MzA6ZDk6YWQ6NTE6YTE6ODc6OTY6YTY6NTM6Yzk6MWU6YzY6YmI6YzM6CisgICAgICAgICBlYjo1
NTpmZTo4YzpkNjo1YzpkNTpjNjpmMzpjYTpiMDo2MDpkMjpkNDoyYToxZjo4ODo5NDoKKyAgICAg
ICAgIGQzOjRjOjFhOmRhOjBjOjk0OmZlOmMxOjVkOjBkOjJhOmRiOjk5OjI5OjVkOmY2OmRkOjE2
OgorICAgICAgICAgYzQ6Yzg6NGQ6NzQ6OWU6ODA6ZDk6ZDA6YWE6ZWQ6N2I6ZTM6MzA6ZTQ6NDc6
ZDg6ZjU6MTU6CisgICAgICAgICBjMTo3MTpiODpjNjpmZDplZTpmYzo5ZTpiMjo1ZjpiNTpiNzo5
MjplZDpmZjpjYTozNzpmNjoKKyAgICAgICAgIGM3OjgyOmI0OjU0OjEzOjliOjgzOmNkOjg3Ojhi
OjdlOjY0OmY2OjJlOjU0OjNhOjIyOmIxOgorICAgICAgICAgYzU6YzE6ZjQ6YTU6MjU6NTM6OWE6
NGQ6YTg6MGY6ZTc6MzU6NGI6ODk6ZGY6MTk6ODM6NjY6CisgICAgICAgICA2NDpkOTpkYjpkMTo2
MToyYjoyNDoxYjoxZDo0NDo0NDpmYjo0OTozMDo4NzpiNzo0OToyMzoKKyAgICAgICAgIDA4OjAy
OjhhOmUwOjI1OmYzOmY0OjQzCiAtLS0tLUJFR0lOIENFUlRJRklDQVRFLS0tLS0KLU1JSUROVEND
QXA2Z0F3SUJBZ0lCQWpBTkJna3Foa2lHOXcwQkFRUUZBREJtTVFzd0NRWURWUVFHRXdKTFJ6RUwK
K01JSUZGRENDQXZ5Z0F3SUJBZ0lCQWpBTkJna3Foa2lHOXcwQkFRc0ZBREJtTVFzd0NRWURWUVFH
RXdKTFJ6RUwKIE1Ba0dBMVVFQ0JNQ1RrRXhFREFPQmdOVkJBY1RCMEpKVTBoTFJVc3hGVEFUQmdO
VkJBb1RERTl3Wlc1V1VFNHQKLVZFVlRWREVoTUI4R0NTcUdTSWIzRFFFSkFSWVNiV1ZBYlhsb2Iz
TjBMbTE1Wkc5dFlXbHVNQjRYRFRBME1URXkKLU5URTBORFkwT1ZvWERURTBNVEV5TXpFME5EWTBP
Vm93YWpFTE1Ba0dBMVVFQmhNQ1MwY3hDekFKQmdOVkJBZ1QKK1ZFVlRWREVoTUI4R0NTcUdTSWIz
RFFFSkFSWVNiV1ZBYlhsb2IzTjBMbTE1Wkc5dFlXbHVNQjRYRFRFME1UQXkKK01qSXhOVGsxTTFv
WERUSTBNVEF4T1RJeE5UazFNMW93YWpFTE1Ba0dBMVVFQmhNQ1MwY3hDekFKQmdOVkJBZ1QKIEFr
NUJNUlV3RXdZRFZRUUtFd3hQY0dWdVZsQk9MVlJGVTFReEZEQVNCZ05WQkFNVEMxUmxjM1F0UTJ4
cFpXNTAKLU1TRXdId1lKS29aSWh2Y05BUWtCRmhKdFpVQnRlV2h2YzNRdWJYbGtiMjFoYVc0d2da
OHdEUVlKS29aSWh2Y04KLUFRRUJCUUFEZ1kwQU1JR0pBb0dCQU5JU1hNWk5FelN1ei9xci9zdmVq
UEZMU3BVb1lJZUNMTGpCNVk3R1hSRlkKLVlhU2w4VUxYaG5Sc25aeDY4RHBjS2VaVE8xNXQyUEJG
Qml3ajdnbThBbzhPdU5Vekg4TktFUUpJQzh4THJXNTAKLTRLSlRzZGJNaWJuaWI5c1ZzeGtlVndS
NVNEcmFkakg4djlNMEllY3kySjRHVHI3ejQzbXdWUDNSUWpLcVBuckIKLUFnTUJBQUdqZ2U0d2dl
c3dDUVlEVlIwVEJBSXdBREFzQmdsZ2hrZ0JodmhDQVEwRUh4WWRUM0JsYmxOVFRDQkgKLVpXNWxj
bUYwWldRZ1EyVnlkR2xtYVdOaGRHVXdIUVlEVlIwT0JCWUVGQmUzUDhkaW9LbjlwREVPV05mWmxI
dEwKLVA4dFdNSUdRQmdOVkhTTUVnWWd3Z1lXQUZJbW1ZT082Nmo2di9HUi9UTDJNMGtpTjRNeEdv
V3FrYURCbU1Rc3cKLUNRWURWUVFHRXdKTFJ6RUxNQWtHQTFVRUNCTUNUa0V4RURBT0JnTlZCQWNU
QjBKSlUwaExSVXN4RlRBVEJnTlYKLUJBb1RERTl3Wlc1V1VFNHRWRVZUVkRFaE1COEdDU3FHU0li
M0RRRUpBUllTYldWQWJYbG9iM04wTG0xNVpHOXQKLVlXbHVnZ0VBTUEwR0NTcUdTSWIzRFFFQkJB
VUFBNEdCQUdIRzBmb2tEOGUrQ1R2WUJCZGpNUmNIK1ZhWnIweG4KLSt0dkxsTTlWcFhzV0lJdENa
Qk1qWWtVb2sxNDI5OXNDbGFIcC9lTVBqWE9oZXc1VmVFMmx4TGNpRXFEdVZlQzQKLURzbWJFdU93
NzV0b2sxZHViSzBXYUk2Tk1EUCtLaHZEQTQrMkNpME1zVHk3K1ZnL2pJRlpheFRkWXJYQ2srMWQK
LXhoa1BtMHRTczN4NAorTVNFd0h3WUpLb1pJaHZjTkFRa0JGaEp0WlVCdGVXaHZjM1F1Ylhsa2Iy
MWhhVzR3Z2dFaU1BMEdDU3FHU0liMworRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFEc1pZL3BF
c0lhVytaV0tnaXBnam90UkhpakFEdXduK2NuRUVDVAorNy9ITVBxQ3FCS0tBR3hPcDV2NkIxbkNR
cU5qVTNqRFlOUURTdm1Md1NOcjhGWTNFeG0wTG1mRXJnd0FLMHlvagorQytYTitUWGZRMkVWY3Ey
Vm1QWnpJVUZlb04xSEo2RFZtdFJCcUJ3ZFZ5QnhGNC8zS0o0K0I4N3MxUTVDVHg1MAorUjQ1SG5k
SVVLQ2NzRkJEMTBaYTFrM1NFNy9rRTNvMUtiOTkzcStyUldOTkUvbG9FQWY4R2VwZjMvZU5YU09I
dworMzBBVG4yWWpXdU5WVkQxVU9lNEErUkx4MHQ5MExyclg4STNHM1JoWUhKTWlDM1g2cU5iZ3RT
OHR1ZFQrdVUrRworNG5WSUZtRDdQOG0wTUVJcCt6dXpLN2xaZ1dwRzgwV0R2LzNWR3Y4M0RHOWIv
V0h4QWdNQkFBR2pnY2d3Z2NVdworQ1FZRFZSMFRCQUl3QURBZEJnTlZIUTRFRmdRVTByUTJEN0g4
M2FYcUt2ZkhJNG42NC9wNlJCMHdnWmdHQTFVZAorSXdTQmtEQ0JqWUFVSzBEbHlYMzE5Slk0NlMv
akw5bEFaTW1PQlp1aGFxUm9NR1l4Q3pBSkJnTlZCQVlUQWt0SAorTVFzd0NRWURWUVFJRXdKT1FU
RVFNQTRHQTFVRUJ4TUhRa2xUU0V0RlN6RVZNQk1HQTFVRUNoTU1UM0JsYmxaUQorVGkxVVJWTlVN
U0V3SHdZSktvWklodmNOQVFrQkZoSnRaVUJ0ZVdodmMzUXViWGxrYjIxaGFXNkNDUUNoVHQ3Ngor
a1BLdWdUQU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FnRUFmK0QraEtmczMyS2x6VHpCNWtLeE1STHd1
ZHFubmorOQorbGxLMi9GVjBaRDdrLzM2cTl6NEdHRjl6aGZqSTRHY2JUWmZLQmRBM0J6TmttK1o0
ZHhTYVZic3FyTU4veVJVSQorZzF6SXdtSFRjVXdGQ3l2TG80ZHRvREx0c0xNbmwwcFZqUUVxTUZa
b3EvTGFYQkJ6eWFvS25FdE1vRnRSYmdwKworYkZPQXNBRGhIcHBNQ2plZUlJbTh4ZVY1V0xkRi85
UEVvZjNaZUQxRkZuVGZna1FkSFlGUVdya3lUT0pQUHc0NgorWlZwa2d6c3BNY1NaaUx6RmhEbnlH
UkxoWnREcSszV3gwaWUra1Ztakt3blZYTDlHanRabjFndnMycXZ3Z0JtSAorWkFlcGQ3RmVET0xG
SFdxc1hTUHpNSFUyVHNyRFRyQk5qQ3pPVW1GajN0WDE3KzhLYXlNbEpqdzY4c1BDRmhrLworcVRL
NmFQbkpFancreGgvL20wNzBrTEJqOWRFekFEQmE2Q1Q2TlVTYmFvRHpwc3g3UEhOZlVNUXdjZGgw
a0NjSworQVU2bFhySDQyc0poZ1JHdUthT1ArbjVNVG1LeEFONlM0NDlxTHRyWk9GMXJmQTNrQWFy
SXhtMkx6Y0RJYnVSWAorSVlyMlJqRFpyVkdoaDVhbVU4a2V4cnZENjFYK2pOWmMxY2J6eXJCZzB0
UXFINGlVMDB3YTJneVUvc0ZkRFNyYgorbVNsZDl0MFd4TWhOZEo2QTJkQ3E3WHZqTU9SSDJQVVZ3
WEc0eHYzdS9KNnlYN1cza3UzL3lqZjJ4NEswVkJPYgorZzgySGkzNWs5aTVVT2lLeHhjSDBwU1ZU
bWsyb0QrYzFTNG5mR1lObVpObmIwV0VySkJzZFJFVDdTVENIdDBragorQ0FLSzRDWHo5RU09CiAt
LS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCmRpZmYgLS1naXQgYS9zYW1wbGUvc2FtcGxlLWtleXMv
Y2xpZW50LmtleSBiL3NhbXBsZS9zYW1wbGUta2V5cy9jbGllbnQua2V5CmluZGV4IDE3Yjk1MDku
LjZkMzE0ODkgMTAwNjQ0Ci0tLSBhL3NhbXBsZS9zYW1wbGUta2V5cy9jbGllbnQua2V5CisrKyBi
L3NhbXBsZS9zYW1wbGUta2V5cy9jbGllbnQua2V5CkBAIC0xLDE1ICsxLDI4IEBACi0tLS0tLUJF
R0lOIFJTQSBQUklWQVRFIEtFWS0tLS0tCi1NSUlDWEFJQkFBS0JnUURTRWx6R1RSTTBycy82cS83
TDNvenhTMHFWS0dDSGdpeTR3ZVdPeGwwUldHR2twZkZDCi0xNFowYkoyY2V2QTZYQ25tVXp0ZWJk
andSUVlzSSs0SnZBS1BEcmpWTXgvRFNoRUNTQXZNUzYxdWRPQ2lVN0hXCi16SW01NG0vYkZiTVpI
bGNFZVVnNjJuWXgvTC9UTkNIbk10aWVCazYrOCtONXNGVDkwVUl5cWo1NndRSURBUUFCCi1Bb0dC
QUs4Um9JR2VrQ2Z5bTk5RFlZZlRnOUEvdC90UWVBbldZYURqN29TckticWYxbGdaOTFPR1BFWmdr
b1ZyCi1LekxueGY5dVUrYmhVczhDSngrNEhkTzgvTDlyQUpBK29EOVFOdU1wMGVsTjRBS3VFR0Ux
RXEzYTBlM2NtZ1BJCi0rVklvWE02V1ZBR2dLOUkwM1p1L1VlcllRL0RkWFdHT0lzS2hGZThxeVFv
RzlwS3hBa0VBOWxkNk85TUhRdDNkCi1KQWpKa2dDTm40cHNvenhqcmZMV3kyaHVYZDNIM0NScUdN
akxJVERHemRrVlNnWGpIb2tCWXJvaTArVFpUdTRNCi11bEpTSmFXd0JRSkJBTnBPMkRBZXhIMnpS
SHc1WjZReWVFVnh6N0IzL0Z6VTRHZ0p4OUJIK0ZTQmgrRjBHNUxuCi1pcjVWc3Q4dlovTEdjZ3BZ
akhRTE5BdlpWZ1VqaVE0WTZJMENRR3Z3TUpMK0NIUjRHbW1yb0FibFR5alUwbjFECi0vTGsvYW5a
K0w3M1phN1UrRDI4RXJGekNycG1Md1JSS09CWXRHZnBVYk9aRHBDUTlrajRoeS9UTEFMRUNRQ2NM
Ci05eXNVTmJ6dDlZL3FqSmtYMWQ5RjdnbjRUQkVtbWtUQml4Vzc2YlRqdmpRYkdsdDZRcHlzbzJP
OERQR2xnUHhNCi12a0o3Um9IZ0M3eTdrR1lQR25rQ1FCVnhTTkdJakx4NE5RQmdONEhEMHk0K2Zh
cnMxUFRVR25ja0JjUzRucGI5Ci1vbkxOeWVyQmxXZEJ3YkFSeUJTN1dQSWJ5eWY1VkNybjN5SXFX
eGFBUk8wPQotLS0tLS1FTkQgUlNBIFBSSVZBVEUgS0VZLS0tLS0KKy0tLS0tQkVHSU4gUFJJVkFU
RSBLRVktLS0tLQorTUlJRXZnSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NCS2d3Z2dTa0FnRUFB
b0lCQVFEc1pZL3BFc0lhVytaVworS2dpcGdqb3RSSGlqQUR1d24rY25FRUNUNy9ITVBxQ3FCS0tB
R3hPcDV2NkIxbkNRcU5qVTNqRFlOUURTdm1MdworU05yOEZZM0V4bTBMbWZFcmd3QUsweW9qQytY
TitUWGZRMkVWY3EyVm1QWnpJVUZlb04xSEo2RFZtdFJCcUJ3ZAorVnlCeEY0LzNLSjQrQjg3czFR
NUNUeDUwUjQ1SG5kSVVLQ2NzRkJEMTBaYTFrM1NFNy9rRTNvMUtiOTkzcStyUgorV05ORS9sb0VB
ZjhHZXBmMy9lTlhTT0h3MzBBVG4yWWpXdU5WVkQxVU9lNEErUkx4MHQ5MExyclg4STNHM1JoWQor
SEpNaUMzWDZxTmJndFM4dHVkVCt1VStHNG5WSUZtRDdQOG0wTUVJcCt6dXpLN2xaZ1dwRzgwV0R2
LzNWR3Y4MworREc5Yi9XSHhBZ01CQUFFQ2dnRUJBSU9kYUNwVUQwMnRyT2g4THFaeG93SmhCT2w3
ejcvZXgwdXdlTVBrNjdMVAoraTVBZFZId09sendaSjhvU0lrbm9PQkVNUkJXY0xRRW9qdDFKTXVM
Mi9SOTVlbXpqSUtzaEhIenFaS051bEZ2QgorVElVcGRud0NoVEt0SDBtcVVrTGxQVTNJZW50eTRJ
cE5scG1mVUtpbWZia1dIRVJkQkpCSGJ0RHNUQUJoZG8zWAorOXBDRi95UktxSlMyRnkvTWtsM2d2
MXkvTkIxT0w0SmhsN3ZRYmYra21nZlFOMnFkT1ZlMkJPS1E4TmxQVURtRQorLzFYTklEYUUzczZ1
dlVhb0Zmd293enNDQ3dOMi84UXJSTU1La2p2VitsRVZ0Tm1RZFl4ajVYajVJd1MwdmtLMAorNmlj
c25nVzg3Y3BaeHhjMXpzUldjU1Rsb3k1b2h1YjRGZ0tobG9sbWlnRUNnWUVBK2NCbHh6THZhTXpN
bEJRWQora0NhYzlLUU12VkwrRElGSGxaQTVpNUwvOXBSVnA0Skp3ajNHVW9laEZKb0Zoc3huS3I4
SFp5THdCS2xDbVVWbQorVnhuc2hSV2lBVTE4ZW1VbWVBdFNHYXdsQVMzUVhoaWtWWkRkZC9MMjBZ
dXNMVCtEWFY4MXdsS1I5Ny9yOSsxNwora2xRT0xrU2RQbTl3Y01ET1dNTkhYOGJVZzhrQ2dZRUE4
aytoUXY2K1RSLytCZWFvMklJY3RGdHcvRWF1YUppSgord1c1cWwxY3BDTFBNQU9RVXZqczBLbTN6
cWN0ZkJGOG1VamRrY3lKNHVoTDlGWnRmeXdZMjJFdFJJWE9KLzhWUgord2U2NW1WbzZSTFI4WVZN
NTRzaWhhbnVGT25seUY5TElCV0IrOXBVZmgxL1k3RFNlYmg3VzczdXhoQXhRaGkzWQorUXdmSVFJ
RmQ4T2tDZ1lCYWxINFZYaExZaHBhWUNpWFNlajZvdDZycksyTjZjNVRiMk1BV01BMW5oK3I4NHRN
UAorZ01vaCtwRGdZUEFxTUk0bVFieFVtcVpFZW9MdUJlNlZIcERhdjdyUEVDUmFXNzgxQUo0Wk00
Y0VRM0p6L2luegorNHFPQU1uMTBDRjA4MS9Fejl5a1BQbFUwYnNZTldITmQ0ZUIyeFdubVVCS093
azdVZ0phdFZQYVVpUUtCZ1FDSQorZjE4Q1ZHcHpHOUNIRm5hSzhGQ25NTk9tNlZJYVRjTmNHWTBt
RDgxbnY1RHQ5NDNQMDU0QlFNc0FIVFk3U2paVworSGlvUnladGtob25YQUIyb1NxbmVraDd6enhn
djRzRzVrM2N0OGV2ZEJDY0UxRk5KYzJlcWlrWjB1REVUUm9PeQorczdjUnhOTnIrUXhEa3lpa00r
ODBIT1BVMVBNUGd3Zk9Tclg5MEdKUThRS0JnRUJLb2hHTVYvc05hNHQxNElhdQorcU84YWFnb3Fo
LzY4SzlHRlhsanNsMy9pQ1NhOTY0SElFUkV0VzA5UXoxdzNkb3RFZ3Aydzhic0RhK093V3JMeQor
MFNZN1Q1alJWaU0zY0RXUmxVQkxyR0dpTDBGaXdzZnFpUmlqaTYweTE5ZXJKZ3JneUdWSWIxa0ln
SUJSa2dGTQorMk1Nd2VBU3pUbVpjcmk0UEEvNUMwSFliCistLS0tLUVORCBQUklWQVRFIEtFWS0t
LS0tCmRpZmYgLS1naXQgYS9zYW1wbGUvc2FtcGxlLWtleXMvY2xpZW50LnAxMiBiL3NhbXBsZS9z
YW1wbGUta2V5cy9jbGllbnQucDEyCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAuLjg0NThjNzk3NzBhMDhlODMyZTEwMjA1
YWUxYzQzZTgwNTljY2EwODIKR0lUIGJpbmFyeSBwYXRjaApsaXRlcmFsIDQ1MzMKemNtVjttNWxa
ZWJmKVRMLTBSdTNDNXFBYSZEdXpnZ19ZRENEMGljMnJYYXNeMFdINXBlVUAoRlY3WH1GYGhEZTZA
Cno0Rkx4UnBuP250Rm9GeU8wcyNPcGYoIWl5MmBZdzJoVzhCdDJMVWh+MV9+O01OUVU8ZjBTb35L
RmIpST1vPzBHZAp6STIqOz0wcztzQ2ZQeEZxUDQyXlAwRm8rNCROcUpSZGRTSlNsI0gkWUxSaE0w
Kj5LWjEhM0ZyWXpWVHg7K348OVgKekhDJjBrQz1RKVp4dXtvTGB4TE07Yl9vRD4oWCY4VGEtI08z
JnA7O0FhMyteMGQ1ZlNMT3MzPnsoX0BTeXhIREdLCnoyP21CX0lVIXskMVNmJkNmTkEwfHpuSHli
ZlJxUDVibHNnP1p7MXcjaEh6bTJXUG1ALWs+fkZzOUxgOFAhOGQwKgp6ZjE4IXdvY2htJjN1Sjtl
Q3tndzNkKz0/dmA/VFBgYXpiUEE4dVMjU3ZGPnp1N1FyUSMkdDw0S2F0SmtzSz5kSSoKemlNSVNZ
UislRUs8dmRRV0FIXz5HSnc3UCNGI2VwfiRmQmJiNlkqX1cpSkgrVUIlLVhvRjBsYiVLTTM2Yl5N
bDN6CnpkSSM+Vylveyl4aHlsWjRPSEtDaFEzQHFTe3YoQVFCQFZhSj9BUkNlYFNzPVMlLXE1VDUr
STMjUiNHMVlKbFlSVgp6RFRaYEBgVTM4e0BiU0w7PnhVaW9LIUY5NFhJQmZKTkZpSWhNJjludmJ7
MWwwTzZHcVImY0xZNE5GRXVaUyhEeEgKej1XIXVKKD9nSzhnc14qezVfY2w1Wig9d1cmUSlYcVMt
fj5tME8ka3AobV9Dej56d3pITC1JWXlESD19eEdWbCs0CnpxM1NUbk10PD9IdShNS2NAMH1PPStT
T2d3YjljaU1ATTQ+N0FtJDMjREY3ezclTGszaW1ZYSt5Nz9EO0FzTkhpRwp6bjxQazw9OEw4Tzhi
TFNXVFJNWWpBcjE0N0U/OSE9ITh4Q2pXJlJ0fVAxRzR5S0EyZWw4JVojIWk/Ty1JJWJZM3UKemV9
RWVxRnpOR2AlJTJgZmVDQTJ8NjY5TDRXSDNheE96THNuUnsyYF52PzNTZj5ZZE8oZkBNPCZnKmpo
fDk1TitGCnpzX341UFBiP0A5MWgpJnVYQVI1dGA+Wkc+VXo0aSlyRiljfDtvc3o0OTc0NWY9KSF9
VUR0bTVNIVpQZjhOSGYtcQp6QnU5VlQoYU4rdnBVZGtKKmdPOEZQTVYyUUQxJnpJcGRpMHNHY2gp
VzI7SSR6JX13X0xBNj9nemlSfEQyLV5BJDcKeksrN2h6e2tuTUBCcXdmeDNkaXJFTmNWU0doVntW
WFU0SnIyOS10bSQtMk1ePm1uRF9yNUxqPml3UlghPDlDRlJnCno5eyhZU3RvRHZPdVJAKE80aTlD
aXdNVShVLTE9QyFjQXFaLXRASWZYRFh4Y2JhTGVMWUxjbVl1eURjMzcpQGJjfQp6Z29AV2tXPU15
VkUxKUZAQigpek5fTXhNSHdKUyhBUjNpcDNJKzNSbSh8PU9NJigpSTk4Mj9DYS1ZTUUqJGpjYWkK
ejU+VFlsYSsle2dEa2ZsTl5GOyRiI1FuIUVzUFhFP2ZzQEQ9U2Q8QmBgPDxjaFpDNWI1VkZLYmgy
SzZrWTc/SzM7Cnp2NV9GYCheUH4hRzFOaWtQbmNUOXIjO1NtTUpAZiVQcmojVWN7bTd4ZVFBTlYw
Szgrb2pYUVNNVDF0KlImdVZgUwp6LWFfWldoLURRbm9fZSRkYT5WTWpJPXdffTgmU0shdTAxMmc+
JDVGO293Uz5SVyQ/fDV7fnJsJiRmfWQlZD4kOWkKejcoUDAqUGhNQVJRZWYmZmR6KXNUQzxMeGE1
YEYyJmhxUUxjSnAjaWt4Zjt1ZHRYcVV1NmNPVC1CTyhCS2A3aD0/CnpEYkk/emd4Zyp+MCRvbTls
a1IpYS03JXdIaiZHfmBVKjM5VUpPdH5qeHMkVnBRYXFiKVkhMTE8N05KO254d0srZgp6aW11PiQ7
JSRXR1dSRlVpT1ErV087QSV7QipaSU5JRXMwOCViLUZiMTs2TTVaPF9gZ2U0RUxmeCpWOD9Rbz9P
QlAKekI8bTMmSkg3JHJHcWxhY0pEVWI0Sl5hRiskMUY1RnExQkVXTGZ+Qj9BVTVjY05SRUlFaFdX
RnBZfnQ/U21HWmkhCnorX0J2NDVXbnBAXkw5ZCNvdiVkUnlQdmEzR1VaeU9CS2RpJnQwenlRLWpw
Kk0mbiE8OD4/WUFzRzBnbkg5PFowUwp6MzREMSQ1TC1oYXRSSSRANmo0M3hPWH49VWUhcHpKXyll
KjI7b1BQLUp0JUJ+SCo0OTA7Q2habXlDcTR2M1J9P3sKemMlVXsmZjg/Tmgmaz42YjVnQD5oMiN9
JkRPdm9pTDglKTx+cTdlaHpIaF9gfmEySXpuPWJqSHE7VGtNSW9EdC0pCnokdTh5Zzt6SHYkOz9I
TDBKNmgyYUhgRUs+YXorP3xTQVpTNyo/Nik/QnNaOHl4ZWMpZE9eZnh+Ynx4UkJLdkAhPgp6TnxI
QGpAT1pQZ188eWJ2LUhOUVM1JE5APUp7aHZMPCFNX35CUjckdVIpMVA/U1VKa15mdHR6XmQxJU5E
X1ZOJCQKejI4eXU0Qj07TkktVzd5KnN5MmRTNl4kRUp7KXlXeE1mN3dmdklfd3NaODlYWmxLfjhu
JXI0KV5lb25FdzJER29+CnpqS1N+V09uVX05c1BoMlAjK0kyb1g0VFdvMk5BcyRocmI4e1Rea1pl
SUAyfUp0YzhvP0B3aDJPUlQlcEFGZlNMNAp6RjF+fjNoaHpvXmJlKUZ7PlhlNiV5OVB5ajFISV9q
Q3BHR0orcn1xSihRbV4odyNxI240O2ZHVDlKKU1JZDYlOyYKemhQZXMkbl96UUlRIX1efTRHYF5X
ejdDR0NAIUFSRkRLal45QEwhflE2NjRDWXp1PThFdi15b3cqZnA5VU9zTEhHCnotQlg8RC1oWjZL
eElBJUY1fkNXY3p8JVFtQkN0MHZNUUsjUFlZOVhzYUozKH1lOz1seU1URHo4TkV1QE0zelVOUgp6
QlR4XzRCd1QtUkglKEkzNTBkVjNlYXxYTlA2WUVPRnlEenFmV3J2X2o2fmBQRjQhX3B1VjVDX1Jr
V1ZsIz1Mek4KekNufnNWK2h0KkE/RF8yWlR5Oz1GX2Z2ODxfNGZgTmpHJGlRSmBqWWcxTyNtdzRF
WWIwTWgjQCRzalJsUWtLSlFvCnpDYkQodFptdjhRdiQmTk5oU2dVfSRgclRucWN2ZmB3eHJeJkMm
O0ZwPTVZaGAoZUV7N0tDajY/eGluZ0ZvKHdxaAp6c3ZyemErUT5jbXJyfj19cFY8YEltYlVAZTtn
Xz1AYSlYZXVLTDF4OTJgcnVMMnImSyhjdCpLa0BJamVzbUNmY2gKekdfPWA0M2gzTV57TypVQXt5
aTJzNWZqdFdYTU9vdj4jclV3eShBNDlSak1zcndMTHE+d3koQTZiSm5pZUpwbSpLCnpMTCEoXyFG
S3poLSQhWVpkRWNCSzFGKD5Ad2UtTTkld154Iz1II305TGM4TlE8QmpmdEJqbmg0YXJ9YjNpK3ZY
Ywp6e1c+WDI1ODBGUnNtM3p9JHZ8MTtCcWpLaU8wMEZ0eztGU2lPV3l8eT0mRHw+I1BmT0RMS3pP
eW05TFdZO00jKD0KemBUNE56Q2lHeTRKZSRnZitId1JnMmM8NU5CdmF0a2Q8b2VFYnFYeTheVFYj
Yk1eZSZSQ1lXKHc5Z08meVlqWDU/CnolblFLRklYd3tIN1VKelU+bWIrKC1OTClTPC0mIUpxK2k+
fUwzTWNDIT1gV1haZ053fVczKXQtazRvOShVekhtQQp6cWA0S1UmJjMhQiRqbip9QzlJZ1BBWkRP
S2E0ZDNaIW1ePjxPPVcmQStpPl91dlcoR2c/dXshWmMyOH5LbmxaWXwKelc+PFRiIUt3S3Q4UW9U
bmJjRz83RDAyOGApZ2doMWVlTThyQHVDJXxrMGZCbUFtVDVjKDFtUTlsRVhRNU9YZD87CnpeQ0hq
dyVrIVJDeEZhVH5hVWFfZHtvcSNRT3NzVEUzPHJNRnllWmBeUGpQeW5ZUl9LVlNOQGVRRGJKMSNi
Pk91Zgp6V0dmUkA5X2k1VDgkO0F6UWtmaXlhMUVRXz4rQmwtP2pLdH1eXzdoUG1reHlTQGR+Xmg9
NzA4RTNgez1XdGgldi0Kej9AaU9CSWpWajQtI2JjRyU5ZCkjKT5JVFkqRThkQlVtcGpSVilDKz5K
dDMycEpgby0xIz5lM1VtfCptVUpsKXpsCnp6aitBe3NhZW4rYEVQfWJEX0JIQEl0KGNiLWBIYTlw
e3JsbEAja300I3JBd0k7VTUme18oZHZQZnJ5NHIqT1IoZwp6aXIxPSVENzA8M2wtVm1kbm83TC1r
OUFXbGU4O0xTNjE2M3F7Z0xxPE1MY1NfNWtDRCtWQGpwMylaNEtfVCt9MEQKel5kaWQ/ckt2YHpB
dUByfWMkIXk5XkxofCt0ejh9K1olQn5GNE99Sj1hPTZ9dj5aSz9Xc3ZSNlpgcnpIckA8IVRnCnpy
IURoTUg9LXI5VXE3MUshQXRQQzN6b3tvWDNuI0VZZXZRY0w5fih2OzZoNVBxJUoqXmdzLTYhZnEz
R29nJDw4Ygp6OWc1PVM0emxaP3klSyE+TWMmNkY2a2ojP3FxcGU7U0hEKGg9IWooekBeQ1I9aT1L
REd3PkJnb2txaTl6UFgodVgKenw4YEt8ZkFnRWxDfHJreWhCNUBiK0B9TFpBZlBsJCtoRGtCeWkl
KVY1PUlhSTFIezZ2bDc/WkJ5ZSFBcUhMaWNPCnphQ3NnJUJJbXw+TUEzUkB8R2pLUmMzZCZYYTRi
Yj5MM1VlbFBXUm9JTGsmSUNHb280bHdWQHpQe3tmTExhWkwmKwp6blNQaFcwNEtja2pEKWF9MTk+
MmFUfFdIX2x0Vz15NyM0Nkd1IS14end0YjZUbUckSV9NbFFrR1dHNCE3RjIhX0MKel5uZ3Y1RE41
VnB6aUYwdG5VMm04QnBDVyo4aiRfVHNWVSVXZihDX0ZUcUpwUCVEVlJ4KjFuPXlZNmpWWlBefiZ1
CnpqK088LSlnVkZPS3p9MmNxTGZaS0QxVyV8NDRBKD9vP0MtelZrYk9UK1YxZVUhVGg0ZTU4Zz9x
eTBJRExnU3NAKAp6PmEzUVpffiQhNmFfeVlBMDNuQFFkcDsmSkN2RFhJTXo3NGokNDB9ayQ2RDUq
QUllfi1OUHE+bD1weytge3FCKkUKeilkQV91eWIhJXhtcysxfCpoZ1hmdlhBSSZGb0ZkXjFfPiZM
TlFVPGYwUzV0fmYoMEBKZigwJXhmKDBydGYoMGY5CnozbzM/NGhXOEJ0Mzw/MVBwbj9TTUZvRmM/
RmRQTzdEdXpnZ19ZRENJMFJ1MSYxUEg3MUs5RCZvfDF0c3MybWwwdgp6MWp3M19WdUE2d0VAVypx
cDhtNyU9PnQhYWhVNkRZPGMkbV5XeyZTTC19QXYtIVY2TWVqKHtWaF5JNjUtcjc+amwKemojMkUk
QGNxUyNvdDtpdEI2NT19VCRjI0Z2bjY+KEh1N2p2NSM/bnFORF5pezx6R0RuK2JHREluT1JoJSR8
PFRVCnopMEFyZ1hMQTsoX2t9S19tbENmRTBZJkVjNGd4SXxiaVJRajRecUB6bHVIPjRaJT56Zm5U
P2E/UD5XbVdnUHFOdQp6dDs9NlUzKnQ+bilvcXkjYkM8cHgyekppcDhhZnkqNyp6JEJ7bWEzZTU3
blkydTR7RV9faUZDMD12bUp3aTFWWVgKekpedTklQT1SamYweS0qOWZWe1d0VDt0YjFUMHxUfjtj
JVNINXFKMitfR0trbiN7TFh9TWJTYFVKKyNAaHEjX1BACno9Vk4kdUBZN058Pyh6N1VRKlVUNSF5
ZCFkZi1gPTtQZzNHOyt9IUBYQlRLQChYdERhblBvbl8zNk4/Y2VKPD93MAp6Tkszc29TI0k1Tzgl
blVTNVhXVnQlTHB0UXNmaTBhe3d0UEdpe2ZxOylqd2I7NXR4IW5RWjVSQndJdERDaFdOVEEKemo+
Rm84OUojSCY1dyhqNilHYjA1ZDRXdWF2LTtBZSpONEN2Q0g3QmY3cXNUNyQtZWlOYlFGanhtYS01
bEZ5JktmCnp1R2RJYnE9U3hQI0I1eTlpJDZrV0lYYSVqPV5IKFE4PDxxX00qYFIlWlZQOChCfUVC
Q0ZAVTU4dGtDOWpPdFE/dwp6QFcyanBzd0pEQ3RIJHlGV2coZS1IQzA7MTAydko7SW1GUU83QDFN
SjxpNzkkc0dVKFMhMX4qKHcrcTRPd08tb3gKeld3TTJrSDU/ZHhXWHVmbzNROVpJeV9VYFFsKzVy
amtLQT1DN1VfX0g8KU41eiRSYnt9cm4/ZHN2c3ZAeXdvVT08CnpVJS1PS0EzfC0yb3N5MlZ3aCMp
KnMrOXRvPEwlYjZVNWs1Rnp4fEpXO0hIQlJxfHN8dCgmKGc0eE1Gemd2dnRiYwp6US1UQmY9ZExx
WHA+cEtYMXxUMU5jZ18lRitPT1UxSyU9bEp2azI1ZWR0UGxsXj9DOGlPWTRsK2dIVnctandTezUK
emMxSCVBMEFjeEFLND9JJTEwJUdUOUt5bmRXOz1TNEhzJEJ0M3BwZFY/NTsqP0MrSVU+X2pyQnwl
aUFAXmotWWRyCnpQI1ZxIXo0bGYxQjU5ZW0hUmJOVl58UF5GNylnWFUoe3YtQl5Ue09iZGF6ck8o
K3c1T1dTO1d1V05STFlZSW57VAp6KlBfYE1tNEYrNUMpZDAmQ19QJnEzbDtWd2ptbzlscnNSOH1y
VE19cTEhN3dBcC1LWisrI3VkaHJ8QEM4SFZHZ0MKel4oSig8dHYkSzQ3PHIyKCNicGhpdmU3dU1S
QSZ9a3lAdHFhQzd+bFY0YGBadSUhMUJVSWZfWj0pKmBDQmYtKzVGCnpUeVZnfUBrPTBiYzlzfSVN
OWlSSG5PZEVPNEFVM3owR1pnfjI2WD07eV92KEYmUHh9Jjh1ZkdhaG9FUWVfPldhLQp6eXtNOVlE
XmBaWVRIMDFMd2ZRP3tadVpRfnZhTyZKcSRPJn5QTiVNTyg5bSV+RU1GVE1DKEEmTVJ1am9qVHtZ
dUIKemB1NWUoQH48YVhiVHU1WHBnbi11MDskXzI7JmRaVjQ/JVVzekk2cUlNK3pTei0+fFBoPDx0
dzs7LUkhYmhRVWZ4CnotVHwjZFRIbHhiREAzfjFxQiNPKzk9UE59MjMtX3wqZWhjSVhhNWEpPndf
dmJSdl9MVnZtc1FoV0E1T1lxdFV2Ugp6YjJgaEVAPjhrbnFrR213cVB1YXN6PU1VeDJOTjdQTXwk
bGtONjBWal89M1VZUFM8V2IqRChhU3tua31QT1VvY2gKejU8T1ZIZSZQPFlDWXE1ZFFnc0t5Z0Yr
OTA+cjZaSUdqZShRZDNySXcobSlsfkxlYmFPRDlgO2QjMlJ0Pl8lP1h8Cno7RkE5R0RpVnV3QW5r
OUJoIUJBRWZNentNZHEkYmBYenJtYW19VzYwRmUzJkREdXpnZ19ZRENGNilfZUI2anRDUAp6ZEIx
KFlIbmpoTUdWVjJSXylqNylqNCZ9VUF1dElCMXVHNSUwdlpKWDFRYWF6LUd5a0NoTzRHZGh+RWlj
M3dySXMKVE1KeG1lKytTYmRydjN5OTBzO3NDVkYjV3gKCmxpdGVyYWwgMApIY21WP2QwMDAwMQoK
ZGlmZiAtLWdpdCBhL3NhbXBsZS9zYW1wbGUta2V5cy9kaDEwMjQucGVtIGIvc2FtcGxlL3NhbXBs
ZS1rZXlzL2RoMTAyNC5wZW0KZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDdjZTA1ZjAu
LjAwMDAwMDAKLS0tIGEvc2FtcGxlL3NhbXBsZS1rZXlzL2RoMTAyNC5wZW0KKysrIC9kZXYvbnVs
bApAQCAtMSw1ICswLDAgQEAKLS0tLS0tQkVHSU4gREggUEFSQU1FVEVSUy0tLS0tCi1NSUdIQW9H
QkFKNDE5REJFT2dtUVR6bzVxWGw1ZlFjTjlUTjQ1NXdrT0w3MDUySHp4eFJWTXloWW13UWNnSnZo
Ci0xc2ExOGZ5ZlI5T2lWRU1ZZ2xPcGtxVm9HTE43cWQ1YVFOTmk1VzcvQytWQmRIVEJKY0daSnl5
UDVCM3FjejMyCi05bUxKS3VkbFZ1ZFYwUXhrNXFVSmFQWi94dXB6ME55b1Zwdml1aUJPSTFnTmk4
b3ZTWFd6QWdFQwotLS0tLS1FTkQgREggUEFSQU1FVEVSUy0tLS0tCmRpZmYgLS1naXQgYS9zYW1w
bGUvc2FtcGxlLWtleXMvZGgyMDQ4LnBlbSBiL3NhbXBsZS9zYW1wbGUta2V5cy9kaDIwNDgucGVt
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjhlZGE1OWEKLS0tIC9kZXYvbnVs
bAorKysgYi9zYW1wbGUvc2FtcGxlLWtleXMvZGgyMDQ4LnBlbQpAQCAtMCwwICsxLDggQEAKKy0t
LS0tQkVHSU4gREggUEFSQU1FVEVSUy0tLS0tCitNSUlCQ0FLQ0FRRUFyZG5BMzJ4dWpIUGxQSStq
UGZmSFNvTVVaK2I1Z1J6MUgxTHc5Ly9HdWdtNVRBc1JpWXJCCit0MkJEU3NNS3ZBanlxTitpNVNK
djRUT2s5OGtSUktCMjdpUHZ5WG1pTDk0NVZhRFFsL1VlaEN5U2pZbEdGVWpXCis5bnVvK0p3UXhl
U2J3MFRMaVNZb1lKWlE4WDFDeFBsOW1nSmwyNzdPNGNXMUdjOEkvYldhK2lwVS80SzV3djNoCitH
SThudCs2QTBqTjNNL0tlYm90TVAxMDFHNGswbDBxc1k0b1JNVG1QK3ozb0FQMHFVOU5aMWppdU1G
VnpSbE5wCis1RmRZRjdjdHJIK3RCRitRbXlUNFNSS1NFRDR3RTRvWDZncDQyME5hQmhJRVFpZklq
NzV3bE1EdHhRbHBrTit4CitRa2pzRWJQbGFQS0hHUTR1dXBzc0NoVlVpOElNMnlxNUV3SUJBZz09
CistLS0tLUVORCBESCBQQVJBTUVURVJTLS0tLS0KZGlmZiAtLWdpdCBhL3NhbXBsZS9zYW1wbGUt
a2V5cy9lYy1jYS5jcnQgYi9zYW1wbGUvc2FtcGxlLWtleXMvZWMtY2EuY3J0CmRlbGV0ZWQgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCBlMTkwODAxLi4wMDAwMDAwCi0tLSBhL3NhbXBsZS9zYW1wbGUt
a2V5cy9lYy1jYS5jcnQKKysrIC9kZXYvbnVsbApAQCAtMSwxMyArMCwwIEBACi0tLS0tLUJFR0lO
IENFUlRJRklDQVRFLS0tLS0KLU1JSUI0akNDQVdtZ0F3SUJBZ0lKQUxHRUdCMmc2Y0FYTUFvR0ND
cUdTTTQ5QkFNQ01CVXhFekFSQmdOVkJBTVQKLUNrVkRMVlJsYzNRZ1EwRXdIaGNOTVRRd01URTRN
VFl3TVRVeldoY05NalF3TVRFMk1UWXdNVFV6V2pBVk1STXcKLUVRWURWUVFERXdwRlF5MVVaWE4w
SUVOQk1IWXdFQVlIS29aSXpqMENBUVlGSzRFRUFDSURZZ0FFMlM0QVpUN2oKLVpsUEcvQ1hwVDEy
Q3pDTlN5U3lLbUp0K2ZXeVcvd3piUnVsVkpwR0hYUkhwWlpqMlZOT1VFNzJrcUdVZXNoaDYKLVVt
MW83bEhHRFNBa0hPSnBlVzVGdHJ5aUtod0ZjKzRkc09DTFROTFZGWFFzRXRZM2dZMTRVcXVpbzRH
RU1JR0IKLU1CMEdBMVVkRGdRV0JCUzBta0ZjdUNaOFNMV1pSQUQvOExwQlFjZ0dQREJGQmdOVkhT
TUVQakE4Z0JTMG1rRmMKLXVDWjhTTFdaUkFELzhMcEJRY2dHUEtFWnBCY3dGVEVUTUJFR0ExVUVB
eE1LUlVNdFZHVnpkQ0JEUVlJSkFMR0UKLUdCMmc2Y0FYTUF3R0ExVWRFd1FGTUFNQkFmOHdDd1lE
VlIwUEJBUURBZ0VHTUFvR0NDcUdTTTQ5QkFNQ0EyY0EKLU1HUUNNSFdsVlRpMHhOWnN0UjhaTkgr
N3owV2x5SVh5WmUyM25lM0VYa08wdGhaTGR2ODZrcHhGTVBXL2xsQisKLVJNUkt1UUl3ZU45N243
RlF5NURUZW5yOTFVOThLREZKNUF2NG1ERlJMMW1rWGl1M1cxLy80WEQ4eUVZRFFUUnoKLS9HQVJ1
T0xMCi0tLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCmRpZmYgLS1naXQgYS9zYW1wbGUvc2FtcGxl
LWtleXMvZWMtY2Eua2V5IGIvc2FtcGxlL3NhbXBsZS1rZXlzL2VjLWNhLmtleQpkZWxldGVkIGZp
bGUgbW9kZSAxMDA2NDQKaW5kZXggNTFhNzJlMS4uMDAwMDAwMAotLS0gYS9zYW1wbGUvc2FtcGxl
LWtleXMvZWMtY2Eua2V5CisrKyAvZGV2L251bGwKQEAgLTEsNiArMCwwIEBACi0tLS0tLUJFR0lO
IFBSSVZBVEUgS0VZLS0tLS0KLU1JRzJBZ0VBTUJBR0J5cUdTTTQ5QWdFR0JTdUJCQUFpQklHZU1J
R2JBZ0VCQkRBU1U2WC9taDJtMlBheXZpTDMKLXRlb21sNXNveUlVY1pmd1pwVm42b050bnJMY0Fi
SVJzQUpiTTR4eUdWcDc3Ry82aFpBTmlBQVRaTGdCbFB1Tm0KLVU4YjhKZWxQWFlMTUkxTEpMSXFZ
bTM1OWJKYi9ETnRHNlZVbWtZZGRFZWxsbVBaVTA1UVR2YVNvWlI2eUdIcFMKLWJXanVVY1lOSUNR
YzRtbDVia1cydktJcUhBVno3aDJ3NEl0TTB0VVZkQ3dTMWplQmpYaFNxNkk9Ci0tLS0tLUVORCBQ
UklWQVRFIEtFWS0tLS0tCmRpZmYgLS1naXQgYS9zYW1wbGUvc2FtcGxlLWtleXMvZWMtY2xpZW50
LmNydCBiL3NhbXBsZS9zYW1wbGUta2V5cy9lYy1jbGllbnQuY3J0CmRlbGV0ZWQgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCBiNzk3YjAyLi4wMDAwMDAwCi0tLSBhL3NhbXBsZS9zYW1wbGUta2V5cy9l
Yy1jbGllbnQuY3J0CisrKyAvZGV2L251bGwKQEAgLTEsNjEgKzAsMCBAQAotQ2VydGlmaWNhdGU6
Ci0gICAgRGF0YToKLSAgICAgICAgVmVyc2lvbjogMyAoMHgyKQotICAgICAgICBTZXJpYWwgTnVt
YmVyOiAyICgweDIpCi0gICAgU2lnbmF0dXJlIEFsZ29yaXRobTogZWNkc2Etd2l0aC1TSEEyNTYK
LSAgICAgICAgSXNzdWVyOiBDTj1FQy1UZXN0IENBCi0gICAgICAgIFZhbGlkaXR5Ci0gICAgICAg
ICAgICBOb3QgQmVmb3JlOiBKYW4gMTggMTY6MDI6MzcgMjAxNCBHTVQKLSAgICAgICAgICAgIE5v
dCBBZnRlciA6IEphbiAxNiAxNjowMjozNyAyMDI0IEdNVAotICAgICAgICBTdWJqZWN0OiBDTj1l
Yy1jbGllbnQKLSAgICAgICAgU3ViamVjdCBQdWJsaWMgS2V5IEluZm86Ci0gICAgICAgICAgICBQ
dWJsaWMgS2V5IEFsZ29yaXRobTogaWQtZWNQdWJsaWNLZXkKLSAgICAgICAgICAgICAgICBQdWJs
aWMtS2V5OiAoMzg0IGJpdCkKLSAgICAgICAgICAgICAgICBwdWI6Ci0gICAgICAgICAgICAgICAg
ICAgIDA0OjQwOmQ5OmI5OmEyOjQ0OjFiOjAxOjM5OjJjOjE0OmVlOmFhOjcwOjZiOgotICAgICAg
ICAgICAgICAgICAgICAzMTo5ODoyODo0NDpjOTo2MTpiYzpiNzowYjpiNTo1Mzo0OTpjMjpjMDow
YToKLSAgICAgICAgICAgICAgICAgICAgNDM6YjA6MDg6NTA6Y2Q6ODA6MmY6NWQ6YTQ6ODk6ZjE6
ZmY6N2Q6MTE6Nzg6Ci0gICAgICAgICAgICAgICAgICAgIGY1OjBjOmIyOjg2OmUyOjU5OmY4OjE3
Ojc2OjFiOjIyOmYyOjIzOjY3OmU3OgotICAgICAgICAgICAgICAgICAgICA1NTo5MDplYTpjZTow
YTphYTpkYTowNTpmNDo4NToxOTpjOTplZDphZTo2ZDoKLSAgICAgICAgICAgICAgICAgICAgYTM6
YWQ6NTY6N2E6ZjY6MzM6YzY6Y2Y6YmI6Yzc6Mzk6ZmE6ZTQ6ZDM6Njc6Ci0gICAgICAgICAgICAg
ICAgICAgIGRmOmYwOmI4OjRhOjg4OjU3Ojk4Ci0gICAgICAgICAgICAgICAgQVNOMSBPSUQ6IHNl
Y3AzODRyMQotICAgICAgICBYNTA5djMgZXh0ZW5zaW9uczoKLSAgICAgICAgICAgIFg1MDl2MyBC
YXNpYyBDb25zdHJhaW50czoKLSAgICAgICAgICAgICAgICBDQTpGQUxTRQotICAgICAgICAgICAg
WDUwOXYzIFN1YmplY3QgS2V5IElkZW50aWZpZXI6Ci0gICAgICAgICAgICAgICAgRDg6RTI6MzU6
N0I6Q0E6NjY6NzE6NkI6RDg6NUI6RjU6MTI6MTM6ODI6MkQ6RUQ6Q0Q6RTU6RUQ6N0YKLSAgICAg
ICAgICAgIFg1MDl2MyBBdXRob3JpdHkgS2V5IElkZW50aWZpZXI6Ci0gICAgICAgICAgICAgICAg
a2V5aWQ6QjQ6OUE6NDE6NUM6Qjg6MjY6N0M6NDg6QjU6OTk6NDQ6MDA6RkY6RjA6QkE6NDE6NDE6
Qzg6MDY6M0MKLSAgICAgICAgICAgICAgICBEaXJOYW1lOi9DTj1FQy1UZXN0IENBCi0gICAgICAg
ICAgICAgICAgc2VyaWFsOkIxOjg0OjE4OjFEOkEwOkU5OkMwOjE3Ci0KLSAgICAgICAgICAgIFg1
MDl2MyBFeHRlbmRlZCBLZXkgVXNhZ2U6Ci0gICAgICAgICAgICAgICAgVExTIFdlYiBDbGllbnQg
QXV0aGVudGljYXRpb24KLSAgICAgICAgICAgIFg1MDl2MyBLZXkgVXNhZ2U6Ci0gICAgICAgICAg
ICAgICAgRGlnaXRhbCBTaWduYXR1cmUKLSAgICAgICAgICAgIE5ldHNjYXBlIENvbW1lbnQ6Ci0g
ICAgICAgICAgICAgICAgRWFzeS1SU0EgR2VuZXJhdGVkIENlcnRpZmljYXRlCi0gICAgICAgICAg
ICBOZXRzY2FwZSBDZXJ0IFR5cGU6Ci0gICAgICAgICAgICAgICAgU1NMIENsaWVudAotICAgIFNp
Z25hdHVyZSBBbGdvcml0aG06IGVjZHNhLXdpdGgtU0hBMjU2Ci0gICAgICAgICAzMDo2NDowMjoz
MDo0MTo4YjoxYTpmZDo5NzphODpiYjo3YzpkMDplYjoxYzphMjpiYTpjMDoKLSAgICAgICAgIGFj
OjJmOjZkOjgwOjA3OjViOjVjOmVmOjU1OjU5OjFhOjkyOjU2OjY2Ojk0OmNlOjQ5OjZhOgotICAg
ICAgICAgYTk6NTc6NDk6YjI6NDE6NzM6NjQ6N2U6MDE6YWM6MzE6M2E6N2M6MmE6YmY6YTU6MDI6
MzA6Ci0gICAgICAgICAyYjpjNDphNjpiMTowYzowMzo4MjplMzplNDowMzozOTpmYjoxOTpkNzo3
NjoyMToxYjo3ZToKLSAgICAgICAgIDdmOmFhOjIyOjVkOjkwOmE0OmUxOjJlOmNkOmNhOjkyOjBm
OmI2OjNmOjgwOmRjOjI2OmQyOgotICAgICAgICAgMDk6MzQ6OGM6ZDE6NjE6YmI6OWQ6YWM6NmQ6
OGY6Njg6ZjAKLS0tLS0tQkVHSU4gQ0VSVElGSUNBVEUtLS0tLQotTUlJQ0xUQ0NBYlNnQXdJQkFn
SUJBakFLQmdncWhrak9QUVFEQWpBVk1STXdFUVlEVlFRREV3cEZReTFVWlhOMAotSUVOQk1CNFhE
VEUwTURFeE9ERTJNREl6TjFvWERUSTBNREV4TmpFMk1ESXpOMW93RkRFU01CQUdBMVVFQXhNSgot
WldNdFkyeHBaVzUwTUhZd0VBWUhLb1pJemowQ0FRWUZLNEVFQUNJRFlnQUVRTm01b2tRYkFUa3NG
TzZxY0dzeAotbUNoRXlXRzh0d3UxVTBuQ3dBcERzQWhRellBdlhhU0o4Zjk5RVhqMURMS0c0bG40
RjNZYkl2SWpaK2RWa09yTwotQ3FyYUJmU0ZHY250cm0yanJWWjY5alBHejd2SE9mcmswMmZmOExo
S2lGZVlvNEhZTUlIVk1Ba0dBMVVkRXdRQwotTUFBd0hRWURWUjBPQkJZRUZOamlOWHZLWm5GcjJG
djFFaE9DTGUzTjVlMS9NRVVHQTFVZEl3UStNRHlBRkxTYQotUVZ5NEpueEl0WmxFQVAvd3VrRkJ5
QVk4b1Jta0Z6QVZNUk13RVFZRFZRUURFd3BGUXkxVVpYTjBJRU5CZ2drQQotc1lRWUhhRHB3QmN3
RXdZRFZSMGxCQXd3Q2dZSUt3WUJCUVVIQXdJd0N3WURWUjBQQkFRREFnZUFNQzBHQ1dDRwotU0FH
RytFSUJEUVFnRmg1RllYTjVMVkpUUVNCSFpXNWxjbUYwWldRZ1EyVnlkR2xtYVdOaGRHVXdFUVlK
WUlaSQotQVliNFFnRUJCQVFEQWdlQU1Bb0dDQ3FHU000OUJBTUNBMmNBTUdRQ01FR0xHdjJYcUx0
ODBPc2NvcnJBckM5dAotZ0FkYlhPOVZXUnFTVm1hVXprbHFxVmRKc2tGelpINEJyREU2ZkNxL3BR
SXdLOFNtc1F3RGd1UGtBem43R2RkMgotSVJ0K2Y2b2lYWkNrNFM3TnlwSVB0aitBM0NiU0NUU00w
V0c3bmF4dGoyancKLS0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0KZGlmZiAtLWdpdCBhL3NhbXBs
ZS9zYW1wbGUta2V5cy9lYy1jbGllbnQua2V5IGIvc2FtcGxlL3NhbXBsZS1rZXlzL2VjLWNsaWVu
dC5rZXkKZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDYwNjM2ZWQuLjAwMDAwMDAKLS0t
IGEvc2FtcGxlL3NhbXBsZS1rZXlzL2VjLWNsaWVudC5rZXkKKysrIC9kZXYvbnVsbApAQCAtMSw2
ICswLDAgQEAKLS0tLS0tQkVHSU4gUFJJVkFURSBLRVktLS0tLQotTUlHMkFnRUFNQkFHQnlxR1NN
NDlBZ0VHQlN1QkJBQWlCSUdlTUlHYkFnRUJCREQ5QWdqOG5yLzhzSXIwWEhreQotbWNuMW9NYjN2
cU9oMmF4RkJhSXZtT0hZbXFzMTFTSUgxdEtZZWxrTll5OXpIVENoWkFOaUFBUkEyYm1pUkJzQgot
T1N3VTdxcHdhekdZS0VUSllieTNDN1ZUU2NMQUNrT3dDRkROZ0M5ZHBJbngvMzBSZVBVTXNvYmlX
ZmdYZGhzaQotOGlObjUxV1E2czRLcXRvRjlJVVp5ZTJ1YmFPdFZucjJNOGJQdThjNSt1VFRaOS93
dUVxSVY1Zz0KLS0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0KZGlmZiAtLWdpdCBhL3NhbXBsZS9z
YW1wbGUta2V5cy9lYy1zZXJ2ZXIuY3J0IGIvc2FtcGxlL3NhbXBsZS1rZXlzL2VjLXNlcnZlci5j
cnQKZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDk5OTk0NzIuLjAwMDAwMDAKLS0tIGEv
c2FtcGxlL3NhbXBsZS1rZXlzL2VjLXNlcnZlci5jcnQKKysrIC9kZXYvbnVsbApAQCAtMSw2MSAr
MCwwIEBACi1DZXJ0aWZpY2F0ZToKLSAgICBEYXRhOgotICAgICAgICBWZXJzaW9uOiAzICgweDIp
Ci0gICAgICAgIFNlcmlhbCBOdW1iZXI6IDEgKDB4MSkKLSAgICBTaWduYXR1cmUgQWxnb3JpdGht
OiBlY2RzYS13aXRoLVNIQTI1NgotICAgICAgICBJc3N1ZXI6IENOPUVDLVRlc3QgQ0EKLSAgICAg
ICAgVmFsaWRpdHkKLSAgICAgICAgICAgIE5vdCBCZWZvcmU6IEphbiAxOCAxNjowMjozMSAyMDE0
IEdNVAotICAgICAgICAgICAgTm90IEFmdGVyIDogSmFuIDE2IDE2OjAyOjMxIDIwMjQgR01UCi0g
ICAgICAgIFN1YmplY3Q6IENOPWVjLXNlcnZlcgotICAgICAgICBTdWJqZWN0IFB1YmxpYyBLZXkg
SW5mbzoKLSAgICAgICAgICAgIFB1YmxpYyBLZXkgQWxnb3JpdGhtOiBpZC1lY1B1YmxpY0tleQot
ICAgICAgICAgICAgICAgIFB1YmxpYy1LZXk6ICgzODQgYml0KQotICAgICAgICAgICAgICAgIHB1
YjoKLSAgICAgICAgICAgICAgICAgICAgMDQ6YmQ6OGM6M2E6YWY6MmU6MmY6MmU6ZGU6Y2Y6ZDI6
Mzk6OGQ6Yjk6YTY6Ci0gICAgICAgICAgICAgICAgICAgIDEzOjk2OjgwOjZkOmI1OmIyOmVlOjk3
OjYyOjNiOmEyOjMyOjM4Ojc3OjFlOgotICAgICAgICAgICAgICAgICAgICBmYjoyYTplZjo4Njo0
YjpkMDo5ZTo0Yjo1NTplMDo5YjowNzpmOTo2NDoyZjoKLSAgICAgICAgICAgICAgICAgICAgNmI6
YTc6MTc6ZmQ6NjU6ZGQ6NTA6M2Y6MWM6ZmE6ZmE6MmY6Mzk6MmU6OTc6Ci0gICAgICAgICAgICAg
ICAgICAgIGQ0Ojg2OmU1OjRlOjVhOmQyOjUwOjBiOmY0OmQ3OjA4OjYyOjY3OjUzOjQ0OgotICAg
ICAgICAgICAgICAgICAgICA2MjplMzoyNTpmMjpmYTozNjo4NDo4NzoxZDowMzplMzplOTo5ZDpk
OTo2NjoKLSAgICAgICAgICAgICAgICAgICAgNTE6ZGQ6YjQ6YzQ6ZGI6MGI6MDUKLSAgICAgICAg
ICAgICAgICBBU04xIE9JRDogc2VjcDM4NHIxCi0gICAgICAgIFg1MDl2MyBleHRlbnNpb25zOgot
ICAgICAgICAgICAgWDUwOXYzIEJhc2ljIENvbnN0cmFpbnRzOgotICAgICAgICAgICAgICAgIENB
OkZBTFNFCi0gICAgICAgICAgICBYNTA5djMgU3ViamVjdCBLZXkgSWRlbnRpZmllcjoKLSAgICAg
ICAgICAgICAgICBFQTpERjo3RTpBMzpENDo2MTo3MzpENzowMTpBRjo2RTowQTozODo4RDozMzpE
MDpCRDoyNDo0QjpFMQotICAgICAgICAgICAgWDUwOXYzIEF1dGhvcml0eSBLZXkgSWRlbnRpZmll
cjoKLSAgICAgICAgICAgICAgICBrZXlpZDpCNDo5QTo0MTo1QzpCODoyNjo3Qzo0ODpCNTo5OTo0
NDowMDpGRjpGMDpCQTo0MTo0MTpDODowNjozQwotICAgICAgICAgICAgICAgIERpck5hbWU6L0NO
PUVDLVRlc3QgQ0EKLSAgICAgICAgICAgICAgICBzZXJpYWw6QjE6ODQ6MTg6MUQ6QTA6RTk6QzA6
MTcKLQotICAgICAgICAgICAgWDUwOXYzIEV4dGVuZGVkIEtleSBVc2FnZToKLSAgICAgICAgICAg
ICAgICBUTFMgV2ViIFNlcnZlciBBdXRoZW50aWNhdGlvbgotICAgICAgICAgICAgWDUwOXYzIEtl
eSBVc2FnZToKLSAgICAgICAgICAgICAgICBEaWdpdGFsIFNpZ25hdHVyZSwgS2V5IEVuY2lwaGVy
bWVudAotICAgICAgICAgICAgTmV0c2NhcGUgQ29tbWVudDoKLSAgICAgICAgICAgICAgICBFYXN5
LVJTQSBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUKLSAgICAgICAgICAgIE5ldHNjYXBlIENlcnQgVHlw
ZToKLSAgICAgICAgICAgICAgICBTU0wgU2VydmVyCi0gICAgU2lnbmF0dXJlIEFsZ29yaXRobTog
ZWNkc2Etd2l0aC1TSEEyNTYKLSAgICAgICAgIDMwOjY0OjAyOjMwOjIwOjM5OjEyOjkyOmNjOmEy
OmNhOjQ1OmI5OjFhOjhmOmUwOmMxOmU3OgotICAgICAgICAgYjc6NGE6Nzk6NGQ6MDc6MDc6ODE6
NzI6MDg6YjQ6ZDQ6N2I6NDY6NTM6ZDc6NzI6MzI6ZDA6Ci0gICAgICAgICBkNzozZTplODo4ODoy
YjpjOTpiYTo4YjpkNTo5NDo0Zjo0MTo2YzpkMDoyZTphNDowMjozMDoKLSAgICAgICAgIDc1OmZm
OmMzOjhhOmMxOmY1Ojc5OjFjOjFhOjA4OjE2OjMxOmMyOmMxOjZlOmQ0OjMzOmRjOgotICAgICAg
ICAgOWY6MDQ6MGY6OTA6OTQ6ZDk6NzU6YzE6NmQ6NzE6Mjg6NjI6Y2M6ZjY6ODk6N2M6OTE6ODY6
Ci0gICAgICAgICBhNDo5Njo0NTozNDphMDo4ZDo5Mjo3ZTpkZDplMzpkYTo0ZAotLS0tLS1CRUdJ
TiBDRVJUSUZJQ0FURS0tLS0tCi1NSUlDTFRDQ0FiU2dBd0lCQWdJQkFUQUtCZ2dxaGtqT1BRUURB
akFWTVJNd0VRWURWUVFERXdwRlF5MVVaWE4wCi1JRU5CTUI0WERURTBNREV4T0RFMk1ESXpNVm9Y
RFRJME1ERXhOakUyTURJek1Wb3dGREVTTUJBR0ExVUVBeE1KCi1aV010YzJWeWRtVnlNSFl3RUFZ
SEtvWkl6ajBDQVFZRks0RUVBQ0lEWWdBRXZZdzZyeTR2THQ3UDBqbU51YVlUCi1sb0J0dGJMdWwy
STdvakk0ZHg3N0t1K0dTOUNlUzFYZ213ZjVaQzlycHhmOVpkMVFQeHo2K2k4NUxwZlVodVZPCi1X
dEpRQy9UWENHSm5VMFJpNHlYeStqYUVoeDBENCttZDJXWlIzYlRFMndzRm80SFlNSUhWTUFrR0Ex
VWRFd1FDCi1NQUF3SFFZRFZSME9CQllFRk9yZmZxUFVZWFBYQWE5dUNqaU5NOUM5SkV2aE1FVUdB
MVVkSXdRK01EeUFGTFNhCi1RVnk0Sm54SXRabEVBUC93dWtGQnlBWThvUm1rRnpBVk1STXdFUVlE
VlFRREV3cEZReTFVWlhOMElFTkJnZ2tBCi1zWVFZSGFEcHdCY3dFd1lEVlIwbEJBd3dDZ1lJS3dZ
QkJRVUhBd0V3Q3dZRFZSMFBCQVFEQWdXZ01DMEdDV0NHCi1TQUdHK0VJQkRRUWdGaDVGWVhONUxW
SlRRU0JIWlc1bGNtRjBaV1FnUTJWeWRHbG1hV05oZEdVd0VRWUpZSVpJCi1BWWI0UWdFQkJBUURB
Z1pBTUFvR0NDcUdTTTQ5QkFNQ0EyY0FNR1FDTUNBNUVwTE1vc3BGdVJxUDRNSG50MHA1Ci1UUWNI
Z1hJSXROUjdSbFBYY2pMUTF6N29pQ3ZKdW92VmxFOUJiTkF1cEFJd2RmL0Rpc0gxZVJ3YUNCWXh3
c0Z1Ci0xRFBjbndRUGtKVFpkY0Z0Y1NoaXpQYUpmSkdHcEpaRk5LQ05rbjdkNDlwTgotLS0tLS1F
TkQgQ0VSVElGSUNBVEUtLS0tLQpkaWZmIC0tZ2l0IGEvc2FtcGxlL3NhbXBsZS1rZXlzL2VjLXNl
cnZlci5rZXkgYi9zYW1wbGUvc2FtcGxlLWtleXMvZWMtc2VydmVyLmtleQpkZWxldGVkIGZpbGUg
bW9kZSAxMDA2NDQKaW5kZXggYmIzY2RmMS4uMDAwMDAwMAotLS0gYS9zYW1wbGUvc2FtcGxlLWtl
eXMvZWMtc2VydmVyLmtleQorKysgL2Rldi9udWxsCkBAIC0xLDYgKzAsMCBAQAotLS0tLS1CRUdJ
TiBQUklWQVRFIEtFWS0tLS0tCi1NSUcyQWdFQU1CQUdCeXFHU000OUFnRUdCU3VCQkFBaUJJR2VN
SUdiQWdFQkJERDhiUWx3ckZyWEhQbWVtMGJ0Ci1jQmNVNm5ZZmFaUWJQZElEQUI3ZWRPT3lldnZ6
WUgwcU10YmFXOTVpU1pMTVJWV2haQU5pQUFTOWpEcXZMaTh1Ci0zcy9TT1kyNXBoT1dnRzIxc3U2
WFlqdWlNamgzSHZzcTc0WkwwSjVMVmVDYkIvbGtMMnVuRi8xbDNWQS9IUHI2Ci1Memt1bDlTRzVV
NWEwbEFMOU5jSVltZFRSR0xqSmZMNk5vU0hIUVBqNlozWlpsSGR0TVRiQ3dVPQotLS0tLS1FTkQg
UFJJVkFURSBLRVktLS0tLQpkaWZmIC0tZ2l0IGEvc2FtcGxlL3NhbXBsZS1rZXlzL2dlbi1zYW1w
bGUta2V5cy5zaCBiL3NhbXBsZS9zYW1wbGUta2V5cy9nZW4tc2FtcGxlLWtleXMuc2gKbmV3IGZp
bGUgbW9kZSAxMDA3NTUKaW5kZXggMDAwMDAwMC4uMmNkNDQ1ZQotLS0gL2Rldi9udWxsCisrKyBi
L3NhbXBsZS9zYW1wbGUta2V5cy9nZW4tc2FtcGxlLWtleXMuc2gKQEAgLTAsMCArMSw3NiBAQAor
IyEvYmluL3NoCisjCisjIFJ1biB0aGlzIHNjcmlwdCB0byBzZXQgdXAgYSB0ZXN0IENBLCBhbmQg
dGVzdCBrZXktY2VydGlmaWNhdGUgcGFpciBmb3IgYQorIyBzZXJ2ZXIsIGFuZCB2YXJpb3VzIGNs
aWVudHMuCisjCisjIENvcHlyaWdodCAoQykgMjAxNCBTdGVmZmFuIEthcmdlciA8c3RlZmZhbkBr
YXJnZXIubWU+CitzZXQgLWV1CisKK2NvbW1hbmQgLXYgb3BlbnNzbCA+L2Rldi9udWxsIDI+JjEg
fHwgeyBlY2hvID4mMiAiVW5hYmxlIHRvIGZpbmQgb3BlbnNzbC4gUGxlYXNlIG1ha2Ugc3VyZSBv
cGVuc3NsIGlzIGluc3RhbGxlZCBhbmQgaW4geW91ciBwYXRoLiI7IGV4aXQgMTsgfQorCitpZiBb
ICEgLWYgb3BlbnNzbC5jbmYgXQordGhlbgorICAgIGVjaG8gIlBsZWFzZSBydW4gdGhpcyBzY3Jp
cHQgZnJvbSB0aGUgc2FtcGxlIGRpcmVjdG9yeSIKKyAgICBleGl0IDEKK2ZpCisKKyMgQ3JlYXRl
IHJlcXVpcmVkIGRpcmVjdG9yaWVzIGFuZCBmaWxlcworbWtkaXIgLXAgc2FtcGxlLWNhCitybSAt
ZiBzYW1wbGUtY2EvaW5kZXgudHh0Cit0b3VjaCBzYW1wbGUtY2EvaW5kZXgudHh0CitlY2hvICIw
MSIgPiBzYW1wbGUtY2Evc2VyaWFsCisKKyMgR2VuZXJhdGUgQ0Ega2V5IGFuZCBjZXJ0CitvcGVu
c3NsIHJlcSAtbmV3IC1uZXdrZXkgcnNhOjQwOTYgLWRheXMgMzY1MCAtbm9kZXMgLXg1MDkgXAor
ICAgIC1leHRlbnNpb25zIGVhc3lyc2FfY2EgLWtleW91dCBzYW1wbGUtY2EvY2Eua2V5IC1vdXQg
c2FtcGxlLWNhL2NhLmNydCBcCisgICAgLXN1YmogIi9DPUtHL1NUPU5BL0w9QklTSEtFSy9PPU9w
ZW5WUE4tVEVTVC9lbWFpbEFkZHJlc3M9bWVAbXlob3N0Lm15ZG9tYWluIiBcCisgICAgLWNvbmZp
ZyBvcGVuc3NsLmNuZgorCisjIENyZWF0ZSBzZXJ2ZXIga2V5IGFuZCBjZXJ0CitvcGVuc3NsIHJl
cSAtbmV3IC1ub2RlcyAtY29uZmlnIG9wZW5zc2wuY25mIC1leHRlbnNpb25zIHNlcnZlciBcCisg
ICAgLWtleW91dCBzYW1wbGUtY2Evc2VydmVyLmtleSAtb3V0IHNhbXBsZS1jYS9zZXJ2ZXIuY3Ny
IFwKKyAgICAtc3ViaiAiL0M9S0cvU1Q9TkEvTz1PcGVuVlBOLVRFU1QvQ049VGVzdC1TZXJ2ZXIv
ZW1haWxBZGRyZXNzPW1lQG15aG9zdC5teWRvbWFpbiIKK29wZW5zc2wgY2EgLWJhdGNoIC1jb25m
aWcgb3BlbnNzbC5jbmYgLWV4dGVuc2lvbnMgc2VydmVyIFwKKyAgICAtb3V0IHNhbXBsZS1jYS9z
ZXJ2ZXIuY3J0IC1pbiBzYW1wbGUtY2Evc2VydmVyLmNzcgorCisjIENyZWF0ZSBjbGllbnQga2V5
IGFuZCBjZXJ0CitvcGVuc3NsIHJlcSAtbmV3IC1ub2RlcyAtY29uZmlnIG9wZW5zc2wuY25mIFwK
KyAgICAta2V5b3V0IHNhbXBsZS1jYS9jbGllbnQua2V5IC1vdXQgc2FtcGxlLWNhL2NsaWVudC5j
c3IgXAorICAgIC1zdWJqICIvQz1LRy9TVD1OQS9PPU9wZW5WUE4tVEVTVC9DTj1UZXN0LUNsaWVu
dC9lbWFpbEFkZHJlc3M9bWVAbXlob3N0Lm15ZG9tYWluIgorb3BlbnNzbCBjYSAtYmF0Y2ggLWNv
bmZpZyBvcGVuc3NsLmNuZiBcCisgICAgLW91dCBzYW1wbGUtY2EvY2xpZW50LmNydCAtaW4gc2Ft
cGxlLWNhL2NsaWVudC5jc3IKKworIyBDcmVhdGUgcGFzc3dvcmQgcHJvdGVjdGVkIGtleSBmaWxl
CitvcGVuc3NsIHJzYSAtYWVzMjU2IC1wYXNzb3V0IHBhc3M6cGFzc3dvcmQgXAorICAgIC1pbiBz
YW1wbGUtY2EvY2xpZW50LmtleSAtb3V0IHNhbXBsZS1jYS9jbGllbnQtcGFzcy5rZXkKKworIyBD
cmVhdGUgcGtjcyMxMiBjbGllbnQgYnVuZGxlCitvcGVuc3NsIHBrY3MxMiAtZXhwb3J0IC1ub2Rl
cyAtcGFzc3dvcmQgcGFzczpwYXNzd29yZCBcCisgICAgLW91dCBzYW1wbGUtY2EvY2xpZW50LnAx
MiAtaW5rZXkgc2FtcGxlLWNhL2NsaWVudC5rZXkgXAorICAgIC1pbiBzYW1wbGUtY2EvY2xpZW50
LmNydCAtY2VydGZpbGUgc2FtcGxlLWNhL2NhLmNydAorCisKKyMgQ3JlYXRlIEVDIHNlcnZlciBh
bmQgY2xpZW50IGNlcnQgKHNpZ25lZCBieSAncmVndWxhcicgUlNBIENBKQorb3BlbnNzbCBlY3Bh
cmFtIC1vdXQgc2FtcGxlLWNhL3NlY3AyNTZrMS5wZW0gLW5hbWUgc2VjcDI1NmsxCisKK29wZW5z
c2wgcmVxIC1uZXcgLW5ld2tleSBlYzpzYW1wbGUtY2Evc2VjcDI1NmsxLnBlbSAtbm9kZXMgLWNv
bmZpZyBvcGVuc3NsLmNuZiBcCisgICAgLWV4dGVuc2lvbnMgc2VydmVyIFwKKyAgICAta2V5b3V0
IHNhbXBsZS1jYS9zZXJ2ZXItZWMua2V5IC1vdXQgc2FtcGxlLWNhL3NlcnZlci1lYy5jc3IgXAor
ICAgIC1zdWJqICIvQz1LRy9TVD1OQS9PPU9wZW5WUE4tVEVTVC9DTj1UZXN0LVNlcnZlci1FQy9l
bWFpbEFkZHJlc3M9bWVAbXlob3N0Lm15ZG9tYWluIgorb3BlbnNzbCBjYSAtYmF0Y2ggLWNvbmZp
ZyBvcGVuc3NsLmNuZiAtZXh0ZW5zaW9ucyBzZXJ2ZXIgXAorICAgIC1vdXQgc2FtcGxlLWNhL3Nl
cnZlci1lYy5jcnQgLWluIHNhbXBsZS1jYS9zZXJ2ZXItZWMuY3NyCisKK29wZW5zc2wgcmVxIC1u
ZXcgLW5ld2tleSBlYzpzYW1wbGUtY2Evc2VjcDI1NmsxLnBlbSAtbm9kZXMgLWNvbmZpZyBvcGVu
c3NsLmNuZiBcCisgICAgLWtleW91dCBzYW1wbGUtY2EvY2xpZW50LWVjLmtleSAtb3V0IHNhbXBs
ZS1jYS9jbGllbnQtZWMuY3NyIFwKKyAgICAtc3ViaiAiL0M9S0cvU1Q9TkEvTz1PcGVuVlBOLVRF
U1QvQ049VGVzdC1DbGllbnQtRUMvZW1haWxBZGRyZXNzPW1lQG15aG9zdC5teWRvbWFpbiIKK29w
ZW5zc2wgY2EgLWJhdGNoIC1jb25maWcgb3BlbnNzbC5jbmYgXAorICAgIC1vdXQgc2FtcGxlLWNh
L2NsaWVudC1lYy5jcnQgLWluIHNhbXBsZS1jYS9jbGllbnQtZWMuY3NyCisKKyMgR2VuZXJhdGUg
REggcGFyYW1ldGVycworb3BlbnNzbCBkaHBhcmFtIC1vdXQgZGgyMDQ4LnBlbSAyMDQ4CisKKyMg
Q29weSBrZXlzIGFuZCBjZXJ0cyB0byB3b3JraW5nIGRpcmVjdG9yeQorY3Agc2FtcGxlLWNhLyou
a2V5IC4KK2NwIHNhbXBsZS1jYS8qLmNydCAuCitjcCBzYW1wbGUtY2EvKi5wMTIgLgorCmRpZmYg
LS1naXQgYS9zYW1wbGUvc2FtcGxlLWtleXMvb3BlbnNzbC5jbmYgYi9zYW1wbGUvc2FtcGxlLWtl
eXMvb3BlbnNzbC5jbmYKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uYWFiZmQ0
OAotLS0gL2Rldi9udWxsCisrKyBiL3NhbXBsZS9zYW1wbGUta2V5cy9vcGVuc3NsLmNuZgpAQCAt
MCwwICsxLDEzOSBAQAorIyBIZWF2aWx5IGJvcnJvd2VkIGZyb20gRWFzeVJTQSAzLCBmb3IgdXNl
IHdpdGggT3BlblNTTCAxLjAuKgorCisjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIworWyBjYSBdCitkZWZhdWx0X2NhCT0g
Q0FfZGVmYXVsdAkJIyBUaGUgZGVmYXVsdCBjYSBzZWN0aW9uCisKKyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCitbIENB
X2RlZmF1bHQgXQorCitkaXIJCT0gc2FtcGxlLWNhCQkjIFdoZXJlIGV2ZXJ5dGhpbmcgaXMga2Vw
dAorY2VydHMJCT0gJGRpcgkJCSMgV2hlcmUgdGhlIGlzc3VlZCBjZXJ0cyBhcmUga2VwdAorY3Js
X2RpcgkJPSAkZGlyCQkJIyBXaGVyZSB0aGUgaXNzdWVkIGNybCBhcmUga2VwdAorZGF0YWJhc2UJ
PSAkZGlyL2luZGV4LnR4dAkjIGRhdGFiYXNlIGluZGV4IGZpbGUuCituZXdfY2VydHNfZGlyCT0g
JGRpcgkJCSMgZGVmYXVsdCBwbGFjZSBmb3IgbmV3IGNlcnRzLgorCitjZXJ0aWZpY2F0ZQk9ICRk
aXIvY2EuY3J0CSAJIyBUaGUgQ0EgY2VydGlmaWNhdGUKK3NlcmlhbAkJPSAkZGlyL3NlcmlhbCAJ
CSMgVGhlIGN1cnJlbnQgc2VyaWFsIG51bWJlcgorY3JsCQk9ICRkaXIvY3JsLnBlbSAJCSMgVGhl
IGN1cnJlbnQgQ1JMCitwcml2YXRlX2tleQk9ICRkaXIvY2Eua2V5CQkjIFRoZSBwcml2YXRlIGtl
eQorUkFOREZJTEUJPSAkZGlyLy5yYW5kCQkjIHByaXZhdGUgcmFuZG9tIG51bWJlciBmaWxlCisK
K3g1MDlfZXh0ZW5zaW9ucwk9IGJhc2ljX2V4dHMJCSMgVGhlIGV4dGVudGlvbnMgdG8gYWRkIHRv
IHRoZSBjZXJ0CisKKyMgVGhpcyBhbGxvd3MgYSBWMiBDUkwuIEFuY2llbnQgYnJvd3NlcnMgZG9u
J3QgbGlrZSBpdCwgYnV0IGFueXRoaW5nIEVhc3ktUlNBCisjIGlzIGRlc2lnbmVkIGZvciB3aWxs
LiBJbiByZXR1cm4sIHdlIGdldCB0aGUgSXNzdWVyIGF0dGFjaGVkIHRvIENSTHMuCitjcmxfZXh0
ZW5zaW9ucwk9IGNybF9leHQKKworZGVmYXVsdF9kYXlzCT0gMzY1MAkJCSMgaG93IGxvbmcgdG8g
Y2VydGlmeSBmb3IKK2RlZmF1bHRfY3JsX2RheXM9IDMwCQkJIyBob3cgbG9uZyBiZWZvcmUgbmV4
dCBDUkwKK2RlZmF1bHRfbWQJPSBzaGEyNTYJCSMgdXNlIHB1YmxpYyBrZXkgZGVmYXVsdCBNRAor
cHJlc2VydmUJPSBubwkJCSMga2VlcCBwYXNzZWQgRE4gb3JkZXJpbmcKKworIyBBIGZldyBkaWZm
ZXJlbmNlIHdheSBvZiBzcGVjaWZ5aW5nIGhvdyBzaW1pbGFyIHRoZSByZXF1ZXN0IHNob3VsZCBs
b29rCisjIEZvciB0eXBlIENBLCB0aGUgbGlzdGVkIGF0dHJpYnV0ZXMgbXVzdCBiZSB0aGUgc2Ft
ZSwgYW5kIHRoZSBvcHRpb25hbAorIyBhbmQgc3VwcGxpZWQgZmllbGRzIGFyZSBqdXN0IHRoYXQg
Oi0pCitwb2xpY3kJCT0gcG9saWN5X2FueXRoaW5nCisKKyMgRm9yIHRoZSAnYW55dGhpbmcnIHBv
bGljeSwgd2hpY2ggZGVmaW5lcyBhbGxvd2VkIEROIGZpZWxkcworWyBwb2xpY3lfYW55dGhpbmcg
XQorY291bnRyeU5hbWUJCT0gb3B0aW9uYWwKK3N0YXRlT3JQcm92aW5jZU5hbWUJPSBvcHRpb25h
bAorbG9jYWxpdHlOYW1lCQk9IG9wdGlvbmFsCitvcmdhbml6YXRpb25OYW1lCT0gb3B0aW9uYWwK
K29yZ2FuaXphdGlvbmFsVW5pdE5hbWUJPSBvcHRpb25hbAorY29tbW9uTmFtZQkJPSBzdXBwbGll
ZAorbmFtZQkJCT0gb3B0aW9uYWwKK2VtYWlsQWRkcmVzcwkJPSBvcHRpb25hbAorCisjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIworIyBFYXN5LVJTQSByZXF1ZXN0IGhhbmRsaW5nCisjIFdlIGtleSBvZmYgJEROX01PREUg
dG8gZGV0ZXJtaW5lIGhvdyB0byBmb3JtYXQgdGhlIEROCitbIHJlcSBdCitkZWZhdWx0X2JpdHMJ
CT0gMjA0OAorZGVmYXVsdF9rZXlmaWxlCQk9IHByaXZrZXkucGVtCitkZWZhdWx0X21kCQk9IHNo
YTI1NgorZGlzdGluZ3Vpc2hlZF9uYW1lCT0gY25fb25seQoreDUwOV9leHRlbnNpb25zCQk9IGVh
c3lyc2FfY2EJIyBUaGUgZXh0ZW50aW9ucyB0byBhZGQgdG8gdGhlIHNlbGYgc2lnbmVkIGNlcnQK
KworIyBBIHBsYWNlaG9sZGVyIHRvIGhhbmRsZSB0aGUgJEVYVFJBX0VYVFMgZmVhdHVyZToKKyMl
RVhUUkFfRVhUUyUJIyBEbyBOT1QgcmVtb3ZlIG9yIGNoYW5nZSB0aGlzIGxpbmUgYXMgJEVYVFJB
X0VYVFMgc3VwcG9ydCByZXF1aXJlcyBpdAorCisjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIworIyBFYXN5LVJTQSBETiAo
U3ViamVjdCkgaGFuZGxpbmcKKworIyBFYXN5LVJTQSBETiBmb3IgY25fb25seSBzdXBwb3J0Ogor
WyBjbl9vbmx5IF0KK2NvbW1vbk5hbWUJCT0gQ29tbW9uIE5hbWUgKGVnOiB5b3VyIHVzZXIsIGhv
c3QsIG9yIHNlcnZlciBuYW1lKQorY29tbW9uTmFtZV9tYXgJCT0gNjQKK2NvbW1vbk5hbWVfZGVm
YXVsdAk9IGNoYW5nZW1lCisKKyMgRWFzeS1SU0EgRE4gZm9yIG9yZyBzdXBwb3J0OgorWyBvcmcg
XQorY291bnRyeU5hbWUJCQk9IENvdW50cnkgTmFtZSAoMiBsZXR0ZXIgY29kZSkKK2NvdW50cnlO
YW1lX2RlZmF1bHQJCT0gS0cKK2NvdW50cnlOYW1lX21pbgkJCT0gMgorY291bnRyeU5hbWVfbWF4
CQkJPSAyCisKK3N0YXRlT3JQcm92aW5jZU5hbWUJCT0gU3RhdGUgb3IgUHJvdmluY2UgTmFtZSAo
ZnVsbCBuYW1lKQorc3RhdGVPclByb3ZpbmNlTmFtZV9kZWZhdWx0CT0gTkEKKworbG9jYWxpdHlO
YW1lCQkJPSBMb2NhbGl0eSBOYW1lIChlZywgY2l0eSkKK2xvY2FsaXR5TmFtZV9kZWZhdWx0CQk9
IEJJU0hLRUsKKworMC5vcmdhbml6YXRpb25OYW1lCQk9IE9yZ2FuaXphdGlvbiBOYW1lIChlZywg
Y29tcGFueSkKKzAub3JnYW5pemF0aW9uTmFtZV9kZWZhdWx0CT0gT3BlblZQTi1URVNUCisKK29y
Z2FuaXphdGlvbmFsVW5pdE5hbWUJCT0gT3JnYW5pemF0aW9uYWwgVW5pdCBOYW1lIChlZywgc2Vj
dGlvbikKK29yZ2FuaXphdGlvbmFsVW5pdE5hbWVfZGVmYXVsdAk9CisKK2NvbW1vbk5hbWUJCQk9
IENvbW1vbiBOYW1lIChlZzogeW91ciB1c2VyLCBob3N0LCBvciBzZXJ2ZXIgbmFtZSkKK2NvbW1v
bk5hbWVfbWF4CQkJPSA2NAorY29tbW9uTmFtZV9kZWZhdWx0CQk9CisKK2VtYWlsQWRkcmVzcwkJ
CT0gRW1haWwgQWRkcmVzcworZW1haWxBZGRyZXNzX2RlZmF1bHQJCT0gbWVAbXlob3N0Lm15ZG9t
YWluCitlbWFpbEFkZHJlc3NfbWF4CQk9IDY0CisKKyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCisKK1sgYmFzaWNfZXh0
cyBdCitiYXNpY0NvbnN0cmFpbnRzCT0gQ0E6RkFMU0UKK3N1YmplY3RLZXlJZGVudGlmaWVyCT0g
aGFzaAorYXV0aG9yaXR5S2V5SWRlbnRpZmllcgk9IGtleWlkLGlzc3VlcjphbHdheXMKKworIyBU
aGUgRWFzeS1SU0EgQ0EgZXh0ZW5zaW9ucworWyBlYXN5cnNhX2NhIF0KKworIyBQS0lYIHJlY29t
bWVuZGF0aW9uczoKKworc3ViamVjdEtleUlkZW50aWZpZXI9aGFzaAorYXV0aG9yaXR5S2V5SWRl
bnRpZmllcj1rZXlpZDphbHdheXMsaXNzdWVyOmFsd2F5cworCisjIFRoaXMgY291bGQgYmUgbWFy
a2VkIGNyaXRpY2FsLCBidXQgaXQncyBuaWNlIHRvIHN1cHBvcnQgcmVhZGluZyBieSBhbnkKKyMg
YnJva2VuIGNsaWVudHMgd2hvIGF0dGVtcHQgdG8gZG8gc28uCitiYXNpY0NvbnN0cmFpbnRzID0g
Q0E6dHJ1ZQorCisjIExpbWl0IGtleSB1c2FnZSB0byBDQSB0YXNrcy4gSWYgeW91IHJlYWxseSB3
YW50IHRvIHVzZSB0aGUgZ2VuZXJhdGVkIHBhaXIgYXMKKyMgYSBzZWxmLXNpZ25lZCBjZXJ0LCBj
b21tZW50IHRoaXMgb3V0Lgora2V5VXNhZ2UgPSBjUkxTaWduLCBrZXlDZXJ0U2lnbgorCisjIENS
TCBleHRlbnNpb25zLgorWyBjcmxfZXh0IF0KKworIyBPbmx5IGlzc3VlckFsdE5hbWUgYW5kIGF1
dGhvcml0eUtleUlkZW50aWZpZXIgbWFrZSBhbnkgc2Vuc2UgaW4gYSBDUkwuCisKKyMgaXNzdWVy
QWx0TmFtZT1pc3N1ZXI6Y29weQorYXV0aG9yaXR5S2V5SWRlbnRpZmllcj1rZXlpZDphbHdheXMs
aXNzdWVyOmFsd2F5cworCisKKyMgU2VydmVyIGV4dGVuc2lvbnMuCitbIHNlcnZlciBdCisKK2Jh
c2ljQ29uc3RyYWludHMgICAgICAgPSBDQTpGQUxTRQorbnNDZXJ0VHlwZSAgICAgICAgICAgICA9
IHNlcnZlcgorbnNDb21tZW50ICAgICAgICAgICAgICA9ICJPcGVuU1NMIEdlbmVyYXRlZCBTZXJ2
ZXIgQ2VydGlmaWNhdGUiCitzdWJqZWN0S2V5SWRlbnRpZmllciAgID0gaGFzaAorYXV0aG9yaXR5
S2V5SWRlbnRpZmllciA9IGtleWlkLGlzc3VlcjphbHdheXMKK2V4dGVuZGVkS2V5VXNhZ2UgICAg
ICAgPSBzZXJ2ZXJBdXRoCitrZXlVc2FnZSAgICAgICAgICAgICAgID0gZGlnaXRhbFNpZ25hdHVy
ZSwga2V5RW5jaXBoZXJtZW50CmRpZmYgLS1naXQgYS9zYW1wbGUvc2FtcGxlLWtleXMvcGFzcy5j
cnQgYi9zYW1wbGUvc2FtcGxlLWtleXMvcGFzcy5jcnQKZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDhiYjdiMTcuLjAwMDAwMDAKLS0tIGEvc2FtcGxlL3NhbXBsZS1rZXlzL3Bhc3MuY3J0
CisrKyAvZGV2L251bGwKQEAgLTEsNjUgKzAsMCBAQAotQ2VydGlmaWNhdGU6Ci0gICAgRGF0YToK
LSAgICAgICAgVmVyc2lvbjogMyAoMHgyKQotICAgICAgICBTZXJpYWwgTnVtYmVyOiAzICgweDMp
Ci0gICAgICAgIFNpZ25hdHVyZSBBbGdvcml0aG06IG1kNVdpdGhSU0FFbmNyeXB0aW9uCi0gICAg
ICAgIElzc3VlcjogQz1LRywgU1Q9TkEsIEw9QklTSEtFSywgTz1PcGVuVlBOLVRFU1QvZW1haWxB
ZGRyZXNzPW1lQG15aG9zdC5teWRvbWFpbgotICAgICAgICBWYWxpZGl0eQotICAgICAgICAgICAg
Tm90IEJlZm9yZTogTm92IDI1IDE0OjQ4OjU1IDIwMDQgR01UCi0gICAgICAgICAgICBOb3QgQWZ0
ZXIgOiBOb3YgMjMgMTQ6NDg6NTUgMjAxNCBHTVQKLSAgICAgICAgU3ViamVjdDogQz1LRywgU1Q9
TkEsIE89T3BlblZQTi1URVNULCBDTj1UZXN0LUNsaWVudC1QYXNzd29yZC9lbWFpbEFkZHJlc3M9
bWVAbXlob3N0Lm15ZG9tYWluCi0gICAgICAgIFN1YmplY3QgUHVibGljIEtleSBJbmZvOgotICAg
ICAgICAgICAgUHVibGljIEtleSBBbGdvcml0aG06IHJzYUVuY3J5cHRpb24KLSAgICAgICAgICAg
IFJTQSBQdWJsaWMgS2V5OiAoMTAyNCBiaXQpCi0gICAgICAgICAgICAgICAgTW9kdWx1cyAoMTAy
NCBiaXQpOgotICAgICAgICAgICAgICAgICAgICAwMDpjYTpiNDowNTo2Nzo3Yjo1MTpjMTpkMjpm
ZToyMTo1NzpiMTphNTo1NzoKLSAgICAgICAgICAgICAgICAgICAgNWM6YzA6ODY6Mzg6MDU6YTg6
OTE6Y2Y6ZTc6YTQ6YmQ6N2E6NzY6ZDg6M2I6Ci0gICAgICAgICAgICAgICAgICAgIGNmOmZlOmYz
Ojc4OjY1OjI0OmQ2OjcyOjdkOjFiOjZkOmI2OmRhOjA0OmYyOgotICAgICAgICAgICAgICAgICAg
ICBhODpmNjpiNDowNDo3ODpkMjoyNDphNzoyMToyZjpjYToyOTo0Njo5NjowZjoKLSAgICAgICAg
ICAgICAgICAgICAgMGI6OTE6MzE6NjY6MWU6NGQ6MjI6OWE6NWQ6MDU6MTc6OTk6OWM6YTA6N2U6
Ci0gICAgICAgICAgICAgICAgICAgIGUwOjJhOmJlOjc4OjBjOmExOmI5OmQ0OjA0OmM0OmVjOmY4
OjYxOjc5OjYyOgotICAgICAgICAgICAgICAgICAgICBiNTo1MjoyZDpmNTo0MTphZjpkYjo5Zjo4
YzphYjowODoxYjpiNzo5NTpiODoKLSAgICAgICAgICAgICAgICAgICAgYzE6ZjA6Mjk6ZDM6ZGE6
ZmI6MDA6M2Y6OGU6NWM6Mjc6ZTM6OGQ6ZmE6ZWU6Ci0gICAgICAgICAgICAgICAgICAgIGRjOmI0
OjNiOjBiOjhiOmUwOmFiOmMxOmMxCi0gICAgICAgICAgICAgICAgRXhwb25lbnQ6IDY1NTM3ICgw
eDEwMDAxKQotICAgICAgICBYNTA5djMgZXh0ZW5zaW9uczoKLSAgICAgICAgICAgIFg1MDl2MyBC
YXNpYyBDb25zdHJhaW50czogCi0gICAgICAgICAgICAgICAgQ0E6RkFMU0UKLSAgICAgICAgICAg
IE5ldHNjYXBlIENvbW1lbnQ6IAotICAgICAgICAgICAgICAgIE9wZW5TU0wgR2VuZXJhdGVkIENl
cnRpZmljYXRlCi0gICAgICAgICAgICBYNTA5djMgU3ViamVjdCBLZXkgSWRlbnRpZmllcjogCi0g
ICAgICAgICAgICAgICAgNDA6NTc6RjE6OEM6OUM6ODY6QjI6REE6RTA6M0Y6QTc6Qjg6RDc6ODU6
NDM6NDU6MDc6OEE6NDA6NzMKLSAgICAgICAgICAgIFg1MDl2MyBBdXRob3JpdHkgS2V5IElkZW50
aWZpZXI6IAotICAgICAgICAgICAgICAgIGtleWlkOjg5OkE2OjYwOkUzOkJBOkVBOjNFOkFGOkZD
OjY0OjdGOjRDOkJEOjhDOkQyOjQ4OjhEOkUwOkNDOjQ2Ci0gICAgICAgICAgICAgICAgRGlyTmFt
ZTovQz1LRy9TVD1OQS9MPUJJU0hLRUsvTz1PcGVuVlBOLVRFU1QvZW1haWxBZGRyZXNzPW1lQG15
aG9zdC5teWRvbWFpbgotICAgICAgICAgICAgICAgIHNlcmlhbDowMAotCi0gICAgU2lnbmF0dXJl
IEFsZ29yaXRobTogbWQ1V2l0aFJTQUVuY3J5cHRpb24KLSAgICAgICAgYTU6Nzk6NzI6N2Y6YTI6
MDg6Mjg6OGU6NjY6ZGE6ZTE6ZDA6YmU6YmI6OTc6M2Q6NjU6OWY6Ci0gICAgICAgIGFiOjFlOjE5
OmFjOmYxOjY2OjQ0OjE0OjhmOjRlOjdjOmViOmVhOjFlOjJmOjU3OmVhOjQ0OgotICAgICAgICA0
Njo0YzpiOTo1Njo1YjpjMDowYzo1ODpkMjo0NTo4NzoyNjo2ZDo4MjpkZTo4Yzo2NDpiODoKLSAg
ICAgICAgOGI6MjI6NjE6NjE6YzY6Njg6MzY6MDg6OWQ6NWE6ZmQ6MmY6ZTU6MjE6ZTE6YTI6MGM6
N2Y6Ci0gICAgICAgIDNlOmNhOmUxOjA2OmVhOjlmOjgxOjYyOjNkOmEwOmNlOmYxOjFlOjBkOmFi
Ojg2Ojg5OmVkOgotICAgICAgICA5YTo4OTozNDozMjpjOTplOTo2ZDo3ZDpmNToxMTpjMzo1ZDo3
ZTphNTpmNzpmMTphNjo4MzoKLSAgICAgICAgNzc6MWI6OTQ6Njc6ZDk6MGY6NWM6YWM6MGU6MDg6
NGE6ODg6OTg6NjU6NDk6ZWI6NjY6OWU6Ci0gICAgICAgIDJkOjI4Ci0tLS0tLUJFR0lOIENFUlRJ
RklDQVRFLS0tLS0KLU1JSURQakNDQXFlZ0F3SUJBZ0lCQXpBTkJna3Foa2lHOXcwQkFRUUZBREJt
TVFzd0NRWURWUVFHRXdKTFJ6RUwKLU1Ba0dBMVVFQ0JNQ1RrRXhFREFPQmdOVkJBY1RCMEpKVTBo
TFJVc3hGVEFUQmdOVkJBb1RERTl3Wlc1V1VFNHQKLVZFVlRWREVoTUI4R0NTcUdTSWIzRFFFSkFS
WVNiV1ZBYlhsb2IzTjBMbTE1Wkc5dFlXbHVNQjRYRFRBME1URXkKLU5URTBORGcxTlZvWERURTBN
VEV5TXpFME5EZzFOVm93Y3pFTE1Ba0dBMVVFQmhNQ1MwY3hDekFKQmdOVkJBZ1QKLUFrNUJNUlV3
RXdZRFZRUUtFd3hQY0dWdVZsQk9MVlJGVTFReEhUQWJCZ05WQkFNVEZGUmxjM1F0UTJ4cFpXNTAK
LUxWQmhjM04zYjNKa01TRXdId1lKS29aSWh2Y05BUWtCRmhKdFpVQnRlV2h2YzNRdWJYbGtiMjFo
YVc0d2daOHcKLURRWUpLb1pJaHZjTkFRRUJCUUFEZ1kwQU1JR0pBb0dCQU1xMEJXZDdVY0hTL2lG
WHNhVlhYTUNHT0FXb2tjL24KLXBMMTZkdGc3ei83emVHVWsxbko5RzIyMjJnVHlxUGEwQkhqU0pL
Y2hMOG9wUnBZUEM1RXhaaDVOSXBwZEJSZVoKLW5LQis0Q3ErZUF5aHVkUUV4T3o0WVhsaXRWSXQ5
VUd2MjUrTXF3Z2J0NVc0d2ZBcDA5cjdBRCtPWENmampmcnUKLTNMUTdDNHZncThIQkFnTUJBQUdq
Z2U0d2dlc3dDUVlEVlIwVEJBSXdBREFzQmdsZ2hrZ0JodmhDQVEwRUh4WWQKLVQzQmxibE5UVENC
SFpXNWxjbUYwWldRZ1EyVnlkR2xtYVdOaGRHVXdIUVlEVlIwT0JCWUVGRUJYOFl5Y2hyTGEKLTRE
K251TmVGUTBVSGlrQnpNSUdRQmdOVkhTTUVnWWd3Z1lXQUZJbW1ZT082Nmo2di9HUi9UTDJNMGtp
TjRNeEcKLW9XcWthREJtTVFzd0NRWURWUVFHRXdKTFJ6RUxNQWtHQTFVRUNCTUNUa0V4RURBT0Jn
TlZCQWNUQjBKSlUwaEwKLVJVc3hGVEFUQmdOVkJBb1RERTl3Wlc1V1VFNHRWRVZUVkRFaE1COEdD
U3FHU0liM0RRRUpBUllTYldWQWJYbG8KLWIzTjBMbTE1Wkc5dFlXbHVnZ0VBTUEwR0NTcUdTSWIz
RFFFQkJBVUFBNEdCQUtWNWNuK2lDQ2lPWnRyaDBMNjcKLWx6MWxuNnNlR2F6eFprUVVqMDU4Nitv
ZUwxZnFSRVpNdVZaYndBeFkwa1dISm0yQzNveGt1SXNpWVdIR2FEWUkKLW5WcjlMK1VoNGFJTWZ6
N0s0UWJxbjRGaVBhRE84UjROcTRhSjdacUpORExKNlcxOTlSSERYWDZsOS9HbWczY2IKLWxHZlpE
MXlzRGdoS2lKaGxTZXRtbmkwbwotLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQpkaWZmIC0tZ2l0
IGEvc2FtcGxlL3NhbXBsZS1rZXlzL3Bhc3Mua2V5IGIvc2FtcGxlL3NhbXBsZS1rZXlzL3Bhc3Mu
a2V5CmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NAppbmRleCA0OTE2MzY0Li4wMDAwMDAwCi0tLSBh
L3NhbXBsZS9zYW1wbGUta2V5cy9wYXNzLmtleQorKysgL2Rldi9udWxsCkBAIC0xLDE4ICswLDAg
QEAKLS0tLS0tQkVHSU4gUlNBIFBSSVZBVEUgS0VZLS0tLS0KLVByb2MtVHlwZTogNCxFTkNSWVBU
RUQKLURFSy1JbmZvOiBERVMtRURFMy1DQkMsOTU5RjczNjVEQkJGREI3NwotCi1uR201N2wrclIv
OGRBWk9ITC8xeC82ZHQxMXpVY2E3cnBoanNndzZYUm5TZjNNL0NXbUh2SFZqQXBXY05MRXM1Ci1T
V05NcDF4ZlVvZ3RHenNLb01CYm5sWkxEQTdSVkhVWUQ2ZFZNeUNwYzY0VWp6VDA4TG1kWmh0UVlM
QUttbFVDCi1QVDFWWFM0QWUrU3JxQ1BVcUprdzF4UDNrcjBGMUVWQ1hOdTBuaE9CQXV1VEdPUzdQ
UEV5VzJOK2s0blJIdHNSCi1JYVBwOEdDdUllb1I2Q2R5bVRGVHE2ZC9HZUNpRWN5clVNNEJOckc0
R3RSUnJVUnh4T3J6UUZFT1M1c2pCUFNnCi1LbTFsd2E2ekJRRlJMZzlkS2pSQkw0dGVLdVBZNVoy
Tm1wY21sL2FONENrZGtWRXNvNGxXNi9VSExFL2pvT01RCi0wTWRwZFl0dTh3bnQxV0kvWjRpbW1R
ZmwzTUYrUWNQTWtxWFh6Q0VoR0cvNVNiQW84OUtDNDZVWHZ1MVo1T2hTCi04WEZIaHZZQml2T1lX
Z1ozWFVRcXlaMHVsRjYwbUZYN2FFMVBoL2VFYmhXQkhtVTM5aEdqeHpvcDFVb1B3cUx4Ci1haHZ0
ZnZDa1IzWmVxbFdPOVNIekNBM01sckt3UTFwMVVMNm5HNkFKaE5OOWpTZXZINmJ5Kzh3cjA3TkJa
T3FYCi1mSngrSi84RWRWc1VDRkcyVUp4UHdNODNaU3dBc3ZLUnFwaDZDdVdFbDluZFViN3J3Nmto
bVJJb1kwSXozTGJVCi0xTWxjRG9KTmNKYXM2bFlEcjFVZUZTazg2ZzBTaUdDSFhaSXFzanlVZ3E2
SEl5NFlyQVlpUVV0aG5sRjh0cDJRCi1uTlFCUExvMUdzSGYwZEMyTXFLZkRGQVN1N1NUK0JsK3lh
akhjSWlVWHZVSlB4V2Jqa1dZRzlRMnAyWkJMelpECi11cWVScjY2T0t4VHpVUzRnby9RYkhETnNB
dWxYbDYxZ1FJRU9kWnc1dXkvSmwxMWt5QUk2RVFiem1laGFnS2RICi1Fc2hUZ0twOGtzNjJ5MGJC
SGd5M0ZNS3lpZEo1SG01OFpEaEJ4cndOMHcrdmhSb1RHT2VwVEE9PQotLS0tLS1FTkQgUlNBIFBS
SVZBVEUgS0VZLS0tLS0KZGlmZiAtLWdpdCBhL3NhbXBsZS9zYW1wbGUta2V5cy9wa2NzMTIucDEy
IGIvc2FtcGxlL3NhbXBsZS1rZXlzL3BrY3MxMi5wMTIKZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDI1M2Q0MDgxYTNhZWZmYWI3ZDE3ZThjMGEzMDhlZTFlODVkNjQ1NmYuLjAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAKR0lUIGJpbmFyeSBwYXRjaApsaXRlcmFs
IDAKSGNtVj9kMDAwMDEKCmxpdGVyYWwgMjY4NQp6Y21ZK0ZYKjNqIThwbWdiODN2aFRVbmJjX0cp
IWJ7KnxMT1c5VWB4K25IbWpRMWAlVDxXMHhmY2ptbUNoN3VnQ0MKemRKJjApRU1yUjtZeGIqaT8h
RTg1QUQ7N15eWlRGWWBTZF5NaGFqKjdmYEFNTjA/UVEkUk9ZZWE8REZBTENMbzJ0CnpmP3k9RFRz
WG5mMm0rSlRLTXttTlZCJE1MVHAlRmVXUyNtYTBWMEdURWRUeiUyODFCazhKVFp6dWkhWUhpZih7
Rgp6JXohV2c8Y0Y2X2FgSFEmLX0waSh4QUt4anBFVStCNU5QdlQ3cHRrNTVpU09AYllsRCNecFR3
RD4pKjgqUiFxZEwKejQyZktPb3JDWUpjPVQ0SitsO1o+eEA3MntMdkNOa3daN01Ke2VEZ21DV3xY
WCszR1QhWVVrbyRUWFRHdUU2Q21vCno5QEYtPTk8NiE2Y1dpJUB1PkRwLSRKUDJzNnQ9a3Z6Ni1P
TWxAfm1FYUVYRzIybGUoVGZsQHloVXtWUSNwdWVAdgp6JFNgJEgpayNCI2ljYkVkR1VUT0pOdGc4
cjJIVnlsPEw9S2laSVp7fUQ2PXcpQ3I/Y3I/Zl9DSkFJPn51fDVhJSYKenw5cjU0ZWNhMGRiZXlk
NGBve0xLNE58ZSVVMiErcm12eENfdmU5YHE7ZCtVWXg/dCRtSCl5VWstcXBPbmxgeXBgCno2bWl2
cUlaPktsWEdsYyE5KkRSWkdySjhFTlkhM3chUFFSSlFZSk4pbTBidWJPOUdxKSFkcEdgNTEjNGZO
dGVXagp6KVV5e3tvKXRnVCljZkduQChuKShhcylPaXIyakd3Yz1hRzJMK35JYkljViUmYzVHfEBQ
eyp7SmQ/I0g+UDdsa2wKenFMUDgodmUkQlJmd1E9V21DTXcxVyFhV0tpSztpSCVlaihyaFhMfkQ8
MWJ0RElKcHFoYFUkc2VRMWZ2am47WEB+CnpZQnp6ZlFGcHMzeD5OMX5rfHtyMDVFaiNsdURzbDVv
K0U1bzZXfXkoKHw5P0VIT3Qrcj5mRFF4JmI3anpRJEROPgp6Qn1teD12MWNXI1l9NTtXMXdWTH1S
eE8pcSZAKz11SCg9JUNWeyt+cUpGQ21tPitxO19UVk9CWSRzMEVGU2RTOzcKeiZtcUJLYXVPbig9
bEcqelA9NHFedjI8MXJCSCVFZGkqYC07MztrfkJYcWtAaHpEMG9fVlhWUXdWd2ZqRGBac35BCnoq
bHpidDxMeio/b0twRnd0ZjBiTUFIbjZQbl9iVl8ocXVjTl5kdD5rcG1uYFk8SktjZG5RTFM8QDFp
PmhAR3R6Nwp6RWRaaH5SMD1rUnNVNHZVZ1ckSTF1QHxyYUVRRXp6JmhCcUhFPGVfYFYqVnZ3WlpL
Xz92IzlAWVJlTihPR3VkczgKenFAYHVHZlBVY3YqKTU4PnRFcyR3XnZ6NGNBSGV6dXpndm11aCls
YmBfTE17eW96MElqKndmfVZaQjlzdFE2cm9xCnpoWERLNWQpX01OMlc1UHx7d1djV3RhPT9Jczwk
UjZJaHltKisofjM3T2FSc0loYmYtYjhja2A7ZH5tTi1UbVNLSAp6QWtDeD9FfWwzdyokfTlMM14y
NlI7VEJLI2lAbnxBZihnZ0dpeGlmVDk/QUZFRm0xUik2e2lhJSY5NllfXmtsPFoKek98MnZuUCZl
OWgkQiMtWk9HSn0pXmJkR19MIUNQP3RZQHBhM21IekEpK3ptVW9qVG1Kam1jNHpuNkRoSnRrVSoy
CnpUeU90emM/NC1PNSp1PjFXTXE7RVYzLWxSWEVNfXh2KF5PfiE3ITEpSXw5IWg5JV8ycDx9S1ck
UktyfGBZY0x3fQp6PHQjKm9xMUFgZEU9e2J5Y3pvdD9ZRyhwU0EoSFIrVjlrRTR3NENOIzc4UGxI
N0B5NjBybUU2IylQXlJVbWV1PjAKelZFQTE4M15jSFphKjMkTjklQSp8NHJvRV5XVj9sdEsyUFF2
dGckSSZlcSh3SCpXJTRzWFIyXnJwQD9MZ1JJaSRjCno2JXpOS15tJCRYQCZlYEBQM08ySDBZclUl
OFYpdD1NbWtpSzsjcnNCMCE1JWcpPCNLZWhofWlAPD1tSFhzS012Rwp6PmVVfU1OUXkhWk87b1hO
dyhuWjxiazJsSTZTalRJbGptZm4we3FSOXAzRUQxU3omP1JgfmFsZzNAQTZZZUsjXloKemB9Y2c1
NyRuMz4rSjZxQClENDtsK31PX3hITV9aNXRLb1JZY3BOTykmMjtZYVMxaE50WEhjRyZydilZMXRz
R0J1CnpIQEBuTl5WIUglZko9ek03eE9OQUpAaExIKiQlc0J3Jj9rKUtRWHZ7IW9GfndaY1Vlayo5
QXpPUTVHQk9jUHNtdQp6eD5KMGBVKDVAOU4zQj5Da2JmTDQlV1lCbCo/d0I3QFZiRHhTVTdmZysl
SjE+emZDfGZrPDR0YXJrdSRLSEZnYCkKejMyO3RSYnpKOCtXMWFDUmRZPiV3JVZyR2dzSE55ZDRF
YlQjUXFoPVZlVFZjZCFiSTIhdHMjRU9OYVktI0F3RUokCnptVjhFN2d9ZElhVyQ5VDZtel88Y1B5
SEgpdkkoR2ohSEdpbDMyKFlQRiMzRV5mNVBFdlo4YEsrQWVhTkU0WXtKWgp6cSstKj05SXVPPkAy
KGFJPl5tZWdSYHxiOyM8akZIRzcpYFJkOExpSXFYZ2N9QDw+IzR4MEdYKmJqdmw4dHVyMFQKekZp
YDhhUk1SZ3RGXjtzKlU7YDhPJnVQQGUoU0AzNjtvI3JYXnw0diViNWJBTFRqdGhMdDtJKUlaUU9n
NXNINThYCnpAM2VEPilWK0IlayF2NDJHZXhkWXQyaFQpS2hCcWxyaCl0JHRvODtuZ0hwdXQ0IVly
ay1nWT19ZV4kfEMtWUBpPQp6LWxfVD4zQD1LRz4tSk1WdkVzRyVfT3JBNGtAWllqUkxicUMkUkZk
elhURnN2XjVmSnVObGBuaFN0JnVZTENyPloKeiVyZGJKeUIwNig3YnVCSmBDNkV0R0Y8NEo/VkpH
Q3hMaVApYUw/b1E5NkxsZzlxWjY9aDNzdHBISjZlPXtFd2cxCnpLK1JTaD9AR3dKa1FnJjR6a2d4
SnYrUzQjZnV2fldsdyZYQlRXcklaVnU8TTw2XiQkNGo5RlpTeGFSTT5fN35SMQp6MWhMfjBiI30p
dWxIKj1nTzY5KU9Bd0x4fHBKbGd0dzV0OVopPy1wWT9nYn5ne01eP0s9X3M3eE1HISF7fDA2XlMK
ejBrcChPMExgNz8+NjRqJnU+TURuRUlgbW5uMTJGYXtHVC0keyNmJkwjM0lLNVVNVHZISEJaak4o
NHxHSUo4IyowCnpFTH5TJWdMOGEjNTxmWjYoNU1rSFY/R355bnc+UDdwMEJnK296ZlF8KW9gV2JF
ZEZxPVBuK34qeH1lU0hEbj59MAp6YSNic3NDNDZEUD5nbFlLaXQ/KnEoeWxGYVUofX5PZHpqeDIj
aythdXFtTE9NOEB0KVlGenBsS0QwUXRNKEZfVXUKelJIdl55RHEqJGBjJHhObztPMXVFV1RnNU5u
VVI5XndSeUx4NEcmSjNPJGw/RmYmU2dkKlV4fHt5dX1UY19rUkF4CnpaNF9BQDROdUVwJClFaz8k
NUJNek1UMFpmVStgJTFfT0lhVGctY2BEM1V0andzJmRve183ZCpqX0xTNlUrREtpcgp6QEU2I3Ah
b09zdE19X1NtVko/dnl2TU11bWZtOUJ5Pz0/QXRrRko0UmApREpRZjNIUHRyTz5DTEYqZ2hiLVp7
VlQKekAmZzNkYCRoTXZBdzl3YS0rWD1jWnVnJTJRTEcoaVQ4b2tMSGVENjRpRTA2SjI0I31XRzsl
djBxTjtvfkojWH1YCnpZclh8JElzQnchQSU8REs4QnhVQUIjcn42UjJWYndVKDVqIVomJXdOYns7
Z3w/VDUrPEYxfitJMHZ1NyN4JkZ2bQp6ZTFPTkFSfl58QiZRcTA9dWpvOEI7ZX5QPTMkbzlHQilD
bio3LWhHMShaVUd5Q1Bvej5nQllDNj1MLXlYSV8xYykKeitWMkB9bDFJOUBeaSNVYjh3dXhTaW5Q
dy14N3Z2XndzVzN9NXhxZitBS3dQbW4rKU1YY1c5JCopNzxwKVgtNHIwCnoofXZ1eGFIfWw9NW1E
OXA2a1RZNnRWPD0re1QwOVJjZn1kajt6elIqVHxpSXZlMHQzdVVeIXNreUs8WChANCRoRAp6akxL
WHU0ZFM3aFFueEdQb0pLd2dNZzRAS3E0MUFDTHJxZ1Y1XjNSKDtleUQ7NF51cjRvaENaeFl8cTFR
QSorUEcKeiRTT0dXd15ufnttYWk/eXlGQyF6eEhvM35zTFRJZSlwKnZ+NVBKOHZyODUlO054bzQl
bjx0XyRea2B6P2JWRzt9Cno9WTM9emZRbUkka1UpdDJ4N0FRPzFzK0ImY35xV3YqJipGa0U1ZyU5
d059RncleDdETlAoWCt2cGIpU3VJfEUxbgpwM31FQyFSTzVYSTIodlJoN2NWfDA0SWJ4LWJBKntP
R0dGWWBRaCl1NnhiZGdte3twZlJfaFNHNgoKZGlmZiAtLWdpdCBhL3NhbXBsZS9zYW1wbGUta2V5
cy9zZXJ2ZXItZWMuY3J0IGIvc2FtcGxlL3NhbXBsZS1rZXlzL3NlcnZlci1lYy5jcnQKbmV3IGZp
bGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uYTcyYzM0MQotLS0gL2Rldi9udWxsCisrKyBi
L3NhbXBsZS9zYW1wbGUta2V5cy9zZXJ2ZXItZWMuY3J0CkBAIC0wLDAgKzEsOTYgQEAKK0NlcnRp
ZmljYXRlOgorICAgIERhdGE6CisgICAgICAgIFZlcnNpb246IDMgKDB4MikKKyAgICAgICAgU2Vy
aWFsIE51bWJlcjogMyAoMHgzKQorICAgIFNpZ25hdHVyZSBBbGdvcml0aG06IHNoYTI1NldpdGhS
U0FFbmNyeXB0aW9uCisgICAgICAgIElzc3VlcjogQz1LRywgU1Q9TkEsIEw9QklTSEtFSywgTz1P
cGVuVlBOLVRFU1QvZW1haWxBZGRyZXNzPW1lQG15aG9zdC5teWRvbWFpbgorICAgICAgICBWYWxp
ZGl0eQorICAgICAgICAgICAgTm90IEJlZm9yZTogT2N0IDIyIDIxOjU5OjUzIDIwMTQgR01UCisg
ICAgICAgICAgICBOb3QgQWZ0ZXIgOiBPY3QgMTkgMjE6NTk6NTMgMjAyNCBHTVQKKyAgICAgICAg
U3ViamVjdDogQz1LRywgU1Q9TkEsIE89T3BlblZQTi1URVNULCBDTj1UZXN0LVNlcnZlci1FQy9l
bWFpbEFkZHJlc3M9bWVAbXlob3N0Lm15ZG9tYWluCisgICAgICAgIFN1YmplY3QgUHVibGljIEtl
eSBJbmZvOgorICAgICAgICAgICAgUHVibGljIEtleSBBbGdvcml0aG06IGlkLWVjUHVibGljS2V5
CisgICAgICAgICAgICAgICAgUHVibGljLUtleTogKDI1NiBiaXQpCisgICAgICAgICAgICAgICAg
cHViOiAKKyAgICAgICAgICAgICAgICAgICAgMDQ6MjE6MDk6YWM6Mjc6ZTY6MDA6M2E6NTc6ZjQ6
ZjY6Yzc6Nzg6YTk6YjE6CisgICAgICAgICAgICAgICAgICAgIGY0OmQ3OmQ3OjQ1OjU5OjM5OmU0
OmEzOmQzOjJjOjk0OmY5OjYxOjRhOmU2OgorICAgICAgICAgICAgICAgICAgICBiOTplOTo4Nzo1
NzpjODowZjo4ODowMzphMDo1NjplZTozNDplNzplNDo0ZToKKyAgICAgICAgICAgICAgICAgICAg
MjA6NjM6NmM6YzE6NmU6YzE6MDQ6YWM6Yjk6MmY6YTk6NzY6Njk6ZDM6N2Q6CisgICAgICAgICAg
ICAgICAgICAgIDQ5OmZmOmYxOjM0OmNiCisgICAgICAgICAgICAgICAgQVNOMSBPSUQ6IHNlY3Ay
NTZrMQorICAgICAgICBYNTA5djMgZXh0ZW5zaW9uczoKKyAgICAgICAgICAgIFg1MDl2MyBCYXNp
YyBDb25zdHJhaW50czogCisgICAgICAgICAgICAgICAgQ0E6RkFMU0UKKyAgICAgICAgICAgIE5l
dHNjYXBlIENlcnQgVHlwZTogCisgICAgICAgICAgICAgICAgU1NMIFNlcnZlcgorICAgICAgICAg
ICAgTmV0c2NhcGUgQ29tbWVudDogCisgICAgICAgICAgICAgICAgT3BlblNTTCBHZW5lcmF0ZWQg
U2VydmVyIENlcnRpZmljYXRlCisgICAgICAgICAgICBYNTA5djMgU3ViamVjdCBLZXkgSWRlbnRp
ZmllcjogCisgICAgICAgICAgICAgICAgMzM6MUE6NDI6NjE6OUU6ODg6MDg6M0Y6NkY6MUY6OTg6
ODg6M0E6REQ6MkQ6Qzc6MDc6M0Q6RjY6OUIKKyAgICAgICAgICAgIFg1MDl2MyBBdXRob3JpdHkg
S2V5IElkZW50aWZpZXI6IAorICAgICAgICAgICAgICAgIGtleWlkOjJCOjQwOkU1OkM5OjdEOkY1
OkY0Ojk2OjM4OkU5OjJGOkUzOjJGOkQ5OjQwOjY0OkM5OjhFOjA1OjlCCisgICAgICAgICAgICAg
ICAgRGlyTmFtZTovQz1LRy9TVD1OQS9MPUJJU0hLRUsvTz1PcGVuVlBOLVRFU1QvZW1haWxBZGRy
ZXNzPW1lQG15aG9zdC5teWRvbWFpbgorICAgICAgICAgICAgICAgIHNlcmlhbDpBMTo0RTpERTpG
QTo5MDpGMjpBRTo4MQorCisgICAgICAgICAgICBYNTA5djMgRXh0ZW5kZWQgS2V5IFVzYWdlOiAK
KyAgICAgICAgICAgICAgICBUTFMgV2ViIFNlcnZlciBBdXRoZW50aWNhdGlvbgorICAgICAgICAg
ICAgWDUwOXYzIEtleSBVc2FnZTogCisgICAgICAgICAgICAgICAgRGlnaXRhbCBTaWduYXR1cmUs
IEtleSBFbmNpcGhlcm1lbnQKKyAgICBTaWduYXR1cmUgQWxnb3JpdGhtOiBzaGEyNTZXaXRoUlNB
RW5jcnlwdGlvbgorICAgICAgICAgOWQ6ODk6ZjY6N2U6MGI6NDM6MDU6MjI6NjM6ZTU6YjM6NDU6
YTg6ZDk6ZWY6MzM6M2M6Yjc6CisgICAgICAgICAxOTozNzoyODo4NzoyNzo0Mzo0Mzo4NjphMzoz
ZjpiOToyMzoyNzowZjo5Njo0ZjpkZTowMToKKyAgICAgICAgIDgwOjM4OjZiOmQ5OmM4Ojk0Ojc3
OjFmOjA2OjA4OjM0OjY1Ojc3OmFkOjU3OjBjOjIzOjk5OgorICAgICAgICAgZjE6NTE6MTI6NWY6
MzI6ZDg6OWM6N2M6OTM6ZjE6ZjY6NzI6MmE6MDU6NjE6ZmY6NjI6YWE6CisgICAgICAgICAzMzph
YTplZjphMzo0ZDpkNjo5Mzo1Njo0MDpmZjozODoyZTo3MzoxYzo2OTpmYjo3MTphMToKKyAgICAg
ICAgIGZhOjY0OjE5OjZhOjA0OjFjOjhiOjIwOmE4OmVlOmE1OjE4OjYzOmY4Ojg0OmY0OmNhOjg0
OgorICAgICAgICAgOGU6YjY6MDU6NDg6YzY6ZjM6Zjc6ODE6OTA6NGQ6OWU6MDA6Y2Q6NGE6OTI6
ODM6ZDQ6OTM6CisgICAgICAgICA2NzowNTpkYzoxNjo4Yjo3ODpmYTpiMTo4Mjo0ODpjNjo4Njo3
NDo0NDpiMTowNjo3ZTo4YToKKyAgICAgICAgIGM4OjY0OjBiOjgyOjNhOmUyOmY1OjU2OjYwOmVh
OjUwOjcwOjAzOmRhOjlmOmZjOjI4OjIwOgorICAgICAgICAgNmI6N2Q6MDQ6ZTA6ZWI6OGQ6ZTI6
ZjE6YmU6ODI6MmY6YmE6NTE6NTA6MmI6NmM6ZDI6ZmM6CisgICAgICAgICAxMTpjZDo2OTo4NToz
Yjo5ZToxNDoxOTpkZDpiYzoxNDpjZjo2MTpiMDo3YTowNzpjYjplODoKKyAgICAgICAgIGUwOmZj
OmMzOjFmOmE0OmNiOmNmOmMxOmU5OjYyOjBmOmQyOjUzOmY4OmNlOjA2OmY0OmY4OgorICAgICAg
ICAgMmY6NTU6MTM6YWE6Njc6NDQ6YjY6Yjg6ZTg6M2U6ODI6YWY6NjY6ZjU6ZjA6N2M6ZmU6NDE6
CisgICAgICAgICBlNjo5ZDpjMDo5Zjo3ODpmZDowMDo4NTowMjo0MDo2MzozNzpmYTowMDplNjoz
YzphNjo5ZjoKKyAgICAgICAgIDM1OjRmOjFkOmE2OmYxOmNiOjhiOjA0OmUwOjY3Ojk4OjU2OmQx
Ojg3OjU4OmI2OjM5OmY2OgorICAgICAgICAgZDM6ZmU6YTg6NDA6NTA6ODA6N2Y6ZTY6NGE6MzY6
ZDA6YzA6YTU6NjE6NjQ6MWQ6M2E6ODc6CisgICAgICAgICBhZDo3ODo3MjpjOTozZjo5ODo0NDoz
NTpmOTpjZjozMjpiMjoxODo0YzpiMDo3MjpmYTo1ZToKKyAgICAgICAgIDZjOjYyOjFlOmQ0OjMx
OjBjOmM4OjliOjc0OmYwOjAwOjllOjcwOmMzOjFlOmM3OmE0OjlkOgorICAgICAgICAgMDM6YTQ6
YWM6MWE6MDk6MWY6ODY6MjM6NjU6NTE6MzQ6NTA6ODY6Njg6MWU6Njg6NGQ6OWE6CisgICAgICAg
ICA0Yjo3ODoxMDoxYzpiZDo1MTowOTpiYjpmZToxNjphMzpjNzoxOTpiNDowNTo0NDphMTplNjoK
KyAgICAgICAgIGM2OjIzOjc2OmQ1OmI4OjNhOmViOmE1OjE3OjFkOjJiOjJlOmZlOjg1OjdjOjg4
OjRmOmYxOgorICAgICAgICAgZTg6MzQ6MzI6ZTA6YzU6OTY6ODc6YzM6ZTg6Yzk6NWY6ODk6MjQ6
MTA6MGU6MWU6MDc6MGI6CisgICAgICAgICAyYzpmODpkMDo0OToxYjo2Mzo1ZTo2Mzo0NDplOToy
YTo0MzplMjo5YzpkNjpmMjo0Mzo5OToKKyAgICAgICAgIDQ3OmY4OjliOjQ5OjFhOmE3OmQxOmUw
OjUzOjY3OjFkOmNiOjE0OmI2OmIwOjJjOjRkOmIzOgorICAgICAgICAgZjI6YzU6NjI6YzI6YTY6
MDk6N2E6YzA6NmM6NTk6M2U6NzM6ODM6MGM6NmM6ZGU6MzA6Nzc6CisgICAgICAgICA0ZDoxYjpl
ZDpiMDo3Zjo3Nzo4Nzo4ZDo1NToxZDpkMzplZDpmNzo2NjpiZDowNjoyYTpmODoKKyAgICAgICAg
IGZkOjAwOmU3OmMwOjMxOmUyOmZmOjUzOjllOjI1Ojk3OmM2OjY0Ojg0OjlkOjhkOjYxOjhlOgor
ICAgICAgICAgYzk6MWY6NmM6NTU6YTE6N2M6NTk6YWE6ZWI6ZTg6MmE6YjI6MmQ6Yzc6MDk6Y2Q6
YjU6M2Q6CisgICAgICAgICBkODo3NDo0Zjo2ZTo5YzozYjpkNTo2ZAorLS0tLS1CRUdJTiBDRVJU
SUZJQ0FURS0tLS0tCitNSUlFdFRDQ0FwMmdBd0lCQWdJQkF6QU5CZ2txaGtpRzl3MEJBUXNGQURC
bU1Rc3dDUVlEVlFRR0V3SkxSekVMCitNQWtHQTFVRUNCTUNUa0V4RURBT0JnTlZCQWNUQjBKSlUw
aExSVXN4RlRBVEJnTlZCQW9UREU5d1pXNVdVRTR0CitWRVZUVkRFaE1COEdDU3FHU0liM0RRRUpB
UllTYldWQWJYbG9iM04wTG0xNVpHOXRZV2x1TUI0WERURTBNVEF5CitNakl4TlRrMU0xb1hEVEkw
TVRBeE9USXhOVGsxTTFvd2JURUxNQWtHQTFVRUJoTUNTMGN4Q3pBSkJnTlZCQWdUCitBazVCTVJV
d0V3WURWUVFLRXd4UGNHVnVWbEJPTFZSRlUxUXhGekFWQmdOVkJBTVREbFJsYzNRdFUyVnlkbVZ5
CitMVVZETVNFd0h3WUpLb1pJaHZjTkFRa0JGaEp0WlVCdGVXaHZjM1F1Ylhsa2IyMWhhVzR3VmpB
UUJnY3Foa2pPCitQUUlCQmdVcmdRUUFDZ05DQUFRaENhd241Z0E2Vi9UMngzaXBzZlRYMTBWWk9l
U2oweXlVK1dGSzVybnBoMWZJCitENGdEb0ZidU5PZmtUaUJqYk1GdXdRU3N1UytwZG1uVGZVbi84
VFRMbzRJQk16Q0NBUzh3Q1FZRFZSMFRCQUl3CitBREFSQmdsZ2hrZ0JodmhDQVFFRUJBTUNCa0F3
TXdZSllJWklBWWI0UWdFTkJDWVdKRTl3Wlc1VFUwd2dSMlZ1CitaWEpoZEdWa0lGTmxjblpsY2lC
RFpYSjBhV1pwWTJGMFpUQWRCZ05WSFE0RUZnUVVNeHBDWVo2SUNEOXZINWlJCitPdDB0eHdjOTlw
c3dnWmdHQTFVZEl3U0JrRENCallBVUswRGx5WDMxOUpZNDZTL2pMOWxBWk1tT0JadWhhcVJvCitN
R1l4Q3pBSkJnTlZCQVlUQWt0SE1Rc3dDUVlEVlFRSUV3Sk9RVEVRTUE0R0ExVUVCeE1IUWtsVFNF
dEZTekVWCitNQk1HQTFVRUNoTU1UM0JsYmxaUVRpMVVSVk5VTVNFd0h3WUpLb1pJaHZjTkFRa0JG
aEp0WlVCdGVXaHZjM1F1CitiWGxrYjIxaGFXNkNDUUNoVHQ3NmtQS3VnVEFUQmdOVkhTVUVEREFL
QmdnckJnRUZCUWNEQVRBTEJnTlZIUThFCitCQU1DQmFBd0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dJ
QkFKMko5bjRMUXdVaVkrV3pSYWpaN3pNOHR4azNLSWNuCitRME9Hb3orNUl5Y1Bsay9lQVlBNGE5
bklsSGNmQmdnMFpYZXRWd3dqbWZGUkVsOHkySng4ay9IMmNpb0ZZZjlpCitxak9xNzZOTjFwTldR
UDg0TG5NY2FmdHhvZnBrR1dvRUhJc2dxTzZsR0dQNGhQVEtoSTYyQlVqRzgvZUJrRTJlCitBTTFL
a29QVWsyY0YzQmFMZVBxeGdrakdoblJFc1FaK2lzaGtDNEk2NHZWV1lPcFFjQVBhbi93b0lHdDlC
T0RyCitqZUx4dm9JdnVsRlFLMnpTL0JITmFZVTduaFFaM2J3VXoyR3dlZ2ZMNk9EOHd4K2t5OC9C
NldJUDBsUDR6Z2IwCisrQzlWRTZwblJMYTQ2RDZDcjJiMThIeitRZWFkd0o5NC9RQ0ZBa0JqTi9v
QTVqeW1uelZQSGFieHk0c0U0R2VZCitWdEdIV0xZNTl0UCtxRUJRZ0gvbVNqYlF3S1ZoWkIwNmg2
MTRjc2svbUVRMStjOHlzaGhNc0hMNlhteGlIdFF4CitETWliZFBBQW5uRERIc2VrblFPa3JCb0pI
NFlqWlZFMFVJWm9IbWhObWt0NEVCeTlVUW03L2hhanh4bTBCVVNoCis1c1lqZHRXNE91dWxGeDBy
THY2RmZJaFA4ZWcwTXVERmxvZkQ2TWxmaVNRUURoNEhDeXo0MEVrYlkxNWpST2txCitRK0tjMXZK
RG1VZjRtMGthcDlIZ1UyY2R5eFMyc0N4TnMvTEZZc0ttQ1hyQWJGaytjNE1NYk40d2QwMGI3YkIv
CitkNGVOVlIzVDdmZG12UVlxK1AwQTU4QXg0djlUbmlXWHhtU0VuWTFoanNrZmJGV2hmRm1xNitn
cXNpM0hDYzIxCitQZGgwVDI2Y085VnQKKy0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0KZGlmZiAt
LWdpdCBhL3NhbXBsZS9zYW1wbGUta2V5cy9zZXJ2ZXItZWMua2V5IGIvc2FtcGxlL3NhbXBsZS1r
ZXlzL3NlcnZlci1lYy5rZXkKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uOGYy
YzkxNAotLS0gL2Rldi9udWxsCisrKyBiL3NhbXBsZS9zYW1wbGUta2V5cy9zZXJ2ZXItZWMua2V5
CkBAIC0wLDAgKzEsNSBAQAorLS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCitNSUdFQWdFQU1C
QUdCeXFHU000OUFnRUdCU3VCQkFBS0JHMHdhd0lCQVFRZ0xIR1lxU2x6b1Jhb2dtSmZyQytFCitv
elRvdGhCOWJPUmFRMUMvM0ZtZVE2ZWhSQU5DQUFRaENhd241Z0E2Vi9UMngzaXBzZlRYMTBWWk9l
U2oweXlVCisrV0ZLNXJucGgxZklENGdEb0ZidU5PZmtUaUJqYk1GdXdRU3N1UytwZG1uVGZVbi84
VFRMCistLS0tLUVORCBQUklWQVRFIEtFWS0tLS0tCmRpZmYgLS1naXQgYS9zYW1wbGUvc2FtcGxl
LWtleXMvc2VydmVyLmNydCBiL3NhbXBsZS9zYW1wbGUta2V5cy9zZXJ2ZXIuY3J0CmluZGV4IDI4
YmI0ZDkuLjAzZTIwMjMgMTAwNjQ0Ci0tLSBhL3NhbXBsZS9zYW1wbGUta2V5cy9zZXJ2ZXIuY3J0
CisrKyBiL3NhbXBsZS9zYW1wbGUta2V5cy9zZXJ2ZXIuY3J0CkBAIC0yLDI1ICsyLDM0IEBAIENl
cnRpZmljYXRlOgogICAgIERhdGE6CiAgICAgICAgIFZlcnNpb246IDMgKDB4MikKICAgICAgICAg
U2VyaWFsIE51bWJlcjogMSAoMHgxKQotICAgICAgICBTaWduYXR1cmUgQWxnb3JpdGhtOiBtZDVX
aXRoUlNBRW5jcnlwdGlvbgorICAgIFNpZ25hdHVyZSBBbGdvcml0aG06IHNoYTI1NldpdGhSU0FF
bmNyeXB0aW9uCiAgICAgICAgIElzc3VlcjogQz1LRywgU1Q9TkEsIEw9QklTSEtFSywgTz1PcGVu
VlBOLVRFU1QvZW1haWxBZGRyZXNzPW1lQG15aG9zdC5teWRvbWFpbgogICAgICAgICBWYWxpZGl0
eQotICAgICAgICAgICAgTm90IEJlZm9yZTogTm92IDI1IDE0OjQyOjIyIDIwMDQgR01UCi0gICAg
ICAgICAgICBOb3QgQWZ0ZXIgOiBOb3YgMjMgMTQ6NDI6MjIgMjAxNCBHTVQKKyAgICAgICAgICAg
IE5vdCBCZWZvcmU6IE9jdCAyMiAyMTo1OTo1MiAyMDE0IEdNVAorICAgICAgICAgICAgTm90IEFm
dGVyIDogT2N0IDE5IDIxOjU5OjUyIDIwMjQgR01UCiAgICAgICAgIFN1YmplY3Q6IEM9S0csIFNU
PU5BLCBPPU9wZW5WUE4tVEVTVCwgQ049VGVzdC1TZXJ2ZXIvZW1haWxBZGRyZXNzPW1lQG15aG9z
dC5teWRvbWFpbgogICAgICAgICBTdWJqZWN0IFB1YmxpYyBLZXkgSW5mbzoKICAgICAgICAgICAg
IFB1YmxpYyBLZXkgQWxnb3JpdGhtOiByc2FFbmNyeXB0aW9uCi0gICAgICAgICAgICBSU0EgUHVi
bGljIEtleTogKDEwMjQgYml0KQotICAgICAgICAgICAgICAgIE1vZHVsdXMgKDEwMjQgYml0KToK
LSAgICAgICAgICAgICAgICAgICAgMDA6Y2I6NGU6YWM6Zjk6ODM6NTc6ZjY6Njk6ZDI6MzI6Mjk6
YjQ6YmM6YWQ6Ci0gICAgICAgICAgICAgICAgICAgIGU2OmY3OjI2OjIxOjg5OjMzOjMwOjQzOjQw
OmEzOjM1OmQ5OmRlOjI2OjAxOgotICAgICAgICAgICAgICAgICAgICBkNjpiNDpmMDpiYzowYTox
OTo1NTo5OTozYjpmMTo0Yzo5MTo2MDpiNjpmZDoKLSAgICAgICAgICAgICAgICAgICAgNzQ6MzQ6
OGQ6NWE6Yzc6NjI6ZWM6Y2U6ZjI6ZDY6MDI6Y2U6NTc6MzI6ZjQ6Ci0gICAgICAgICAgICAgICAg
ICAgIDM1OjhjOjcxOmEwOjZkOjY1OjJhOmU3OjgwOmFlOjI5OjU5OmNmOjM2OjczOgotICAgICAg
ICAgICAgICAgICAgICBmODo3Yzo0YTo3Mzo5MDpmYzozMDoyODpkNTo0Njo3ZDozNTphNDo0ZTpj
OToKLSAgICAgICAgICAgICAgICAgICAgOWY6OTA6N2I6ZTI6MDk6MjE6MzY6YzU6YTg6ZWM6ODU6
ODI6OWE6MzI6YjQ6Ci0gICAgICAgICAgICAgICAgICAgIDkxOjNiOmMxOmQ2OjRmOjlmOmQxOmY4
OjZmOjY4OmY0OjFkOmQyOjA2OjkxOgotICAgICAgICAgICAgICAgICAgICAzMjpjYzo5YTo0ODpm
ZDpjZDo5ODo3ZjoyZgorICAgICAgICAgICAgICAgIFB1YmxpYy1LZXk6ICgyMDQ4IGJpdCkKKyAg
ICAgICAgICAgICAgICBNb2R1bHVzOgorICAgICAgICAgICAgICAgICAgICAwMDphNTpiODphMjpl
ZTpjZTpiMTphNjowZjo2YTpiMjo5ZjpkMzoyMjoxNzoKKyAgICAgICAgICAgICAgICAgICAgNzk6
ZGU6MDk6OTg6NzE6Nzg6ZmE6YTc6Y2U6MzY6NTE6NTQ6NTc6Yzc6MzE6CisgICAgICAgICAgICAg
ICAgICAgIDk5OjU2OmQxOjhhOmQ2OmM1OmZkOjUyOmU2Ojg4OjBlOjdiOmY5OmVhOjI3OgorICAg
ICAgICAgICAgICAgICAgICA3YTpiZjozZjoxNDplYzphYTpkMjpmZjo4Yjo1Njo1ODphYzpjYTo1
MTo3NzoKKyAgICAgICAgICAgICAgICAgICAgYzU6M2M6YjY6ZTQ6ODM6NmY6MjI6MDY6MmQ6NWI6
ZWI6ZTc6NTk6ZDQ6YWI6CisgICAgICAgICAgICAgICAgICAgIDQyOmM4OmQ1OmE5Ojg3OjczOmIz
OjczOjM2OjUxOjJmOmE1OmQwOjkwOmEyOgorICAgICAgICAgICAgICAgICAgICA4Nzo2NDo1NDo2
YzoxMjpkMzpiODo3Njo0Nzo2OTphZjphZTo4ZjowMDpiMzoKKyAgICAgICAgICAgICAgICAgICAg
NzA6Yjk6ZTc6Njc6M2Y6OGM6NmE6M2Q6Nzk6NWY6ODE6Mjc6YTM6MGU6YWE6CisgICAgICAgICAg
ICAgICAgICAgIGE3OjNkOjgxOjQ4OjEwOmIxOjE4OjZjOjM4OjJlOjhmOjdhOjdiOmM1OjNkOgor
ICAgICAgICAgICAgICAgICAgICAyMTpjODpmOTphMDo3ZjoxNzoyYjo4ODo0ZjpiYTpmMjplYzo2
ZDoyNDo4ZToKKyAgICAgICAgICAgICAgICAgICAgNmM6ZjE6MGE6NWM6ZDk6NWI6YjE6YjA6ZmM6
NDk6Y2I6NGE6ZDI6NTg6YzY6CisgICAgICAgICAgICAgICAgICAgIDJhOjI1OmIwOjk3Ojg0OmMz
OjllOmZmOjM0OjhjOjEwOjQ2OjdmOjBmOmZiOgorICAgICAgICAgICAgICAgICAgICAzYzo1OTo3
YTphNjoyOTowYzphZTo4ZTo1MDozYTpmMjo1Mzo4NDo0MDoyZDoKKyAgICAgICAgICAgICAgICAg
ICAgZDU6OTE6N2I6MGE6Mzc6OGU6ODI6Nzc6Y2U6NjY6MmY6MzQ6Nzc6NWM6YTU6CisgICAgICAg
ICAgICAgICAgICAgIDQ1OjNiOjAwOjE5OmE3OjA3OmQxOjkyOmU2OjY2OmI5OjNiOjRlOmU5OjYz
OgorICAgICAgICAgICAgICAgICAgICBmYzozMzo5ODoxYTphZTo3YjowODo3ZDowYTpkZjo3YTpi
YTphYTo1OTo2ZDoKKyAgICAgICAgICAgICAgICAgICAgODY6ODI6MGE6NjQ6MmI6ZGE6NTk6YTc6
NGM6NGU6ZWY6M2Q6YmQ6MDQ6YTI6CisgICAgICAgICAgICAgICAgICAgIDRiOjMxCiAgICAgICAg
ICAgICAgICAgRXhwb25lbnQ6IDY1NTM3ICgweDEwMDAxKQogICAgICAgICBYNTA5djMgZXh0ZW5z
aW9uczoKICAgICAgICAgICAgIFg1MDl2MyBCYXNpYyBDb25zdHJhaW50czogCkBAIC0zMCwzOCAr
MzksNzUgQEAgQ2VydGlmaWNhdGU6CiAgICAgICAgICAgICBOZXRzY2FwZSBDb21tZW50OiAKICAg
ICAgICAgICAgICAgICBPcGVuU1NMIEdlbmVyYXRlZCBTZXJ2ZXIgQ2VydGlmaWNhdGUKICAgICAg
ICAgICAgIFg1MDl2MyBTdWJqZWN0IEtleSBJZGVudGlmaWVyOiAKLSAgICAgICAgICAgICAgICA2
OToxMTpGRTpFNzo5Rjo4OTo3Qjo3MTozNDo2OTpDMDpEQzo4MjpGODpEMDo1RDo0RDpGQjo3ODpE
RgorICAgICAgICAgICAgICAgIEIzOjlEOjgxOkU2OjE2OjkyOjY0OkM0Ojg2Ojg3OkY1OjI5OjEw
OjFCOjVFOjJGOjc0OkY3OkVEOkIxCiAgICAgICAgICAgICBYNTA5djMgQXV0aG9yaXR5IEtleSBJ
ZGVudGlmaWVyOiAKLSAgICAgICAgICAgICAgICBrZXlpZDo4OTpBNjo2MDpFMzpCQTpFQTozRTpB
RjpGQzo2NDo3Rjo0QzpCRDo4QzpEMjo0ODo4RDpFMDpDQzo0NgorICAgICAgICAgICAgICAgIGtl
eWlkOjJCOjQwOkU1OkM5OjdEOkY1OkY0Ojk2OjM4OkU5OjJGOkUzOjJGOkQ5OjQwOjY0OkM5OjhF
OjA1OjlCCiAgICAgICAgICAgICAgICAgRGlyTmFtZTovQz1LRy9TVD1OQS9MPUJJU0hLRUsvTz1P
cGVuVlBOLVRFU1QvZW1haWxBZGRyZXNzPW1lQG15aG9zdC5teWRvbWFpbgotICAgICAgICAgICAg
ICAgIHNlcmlhbDowMAorICAgICAgICAgICAgICAgIHNlcmlhbDpBMTo0RTpERTpGQTo5MDpGMjpB
RTo4MQogCi0gICAgU2lnbmF0dXJlIEFsZ29yaXRobTogbWQ1V2l0aFJTQUVuY3J5cHRpb24KLSAg
ICAgICAgMzU6NWM6NzU6ZGE6NTc6ZWY6YjU6Nzk6ZjI6YTI6ZGI6MzY6ZTQ6NzU6ZTg6Yzc6YmM6
NzM6Ci0gICAgICAgIDI2OmNmOjMwOjM2OjRiOjJlOjUxOjQ2OjM3OjYwOjJmOjRlOjJiOmY2Ojcx
OmEyOjIzOmRiOgotICAgICAgICA4ZTpkODo1YzpkNTphZjoyZToyMjoyODpkZDozMDphODo4OTo2
NjozYTpjYzo1YjozYzowZjoKLSAgICAgICAgOTY6MTI6MjA6ZGU6NWU6NDE6NTI6NzQ6MzU6ZWQ6
NGM6MjY6NDA6MTk6Y2E6NzM6ZGY6NTQ6Ci0gICAgICAgIGIxOjMwOjk2OjljOmE1OjE0OmQwOjM4
OjI4OjNmOmFiOjMwOjA3OmQ3OmRlOjk4OmQyOjdmOgotICAgICAgICA3Zjo5MDpiMjo1MjoxZDpl
NTo5NTo4ODplZDpiYTo4YTo2YToxNDo4NTo2Njo3NjplYzo3NToKLSAgICAgICAgMzA6ZTg6YWU6
OTQ6ZjQ6ZTE6NzY6ZmE6NGI6MGU6ZjE6NTM6ZDc6OTU6YmU6ZmI6Njk6ZmE6Ci0gICAgICAgIDNk
OjMyCisgICAgICAgICAgICBYNTA5djMgRXh0ZW5kZWQgS2V5IFVzYWdlOiAKKyAgICAgICAgICAg
ICAgICBUTFMgV2ViIFNlcnZlciBBdXRoZW50aWNhdGlvbgorICAgICAgICAgICAgWDUwOXYzIEtl
eSBVc2FnZTogCisgICAgICAgICAgICAgICAgRGlnaXRhbCBTaWduYXR1cmUsIEtleSBFbmNpcGhl
cm1lbnQKKyAgICBTaWduYXR1cmUgQWxnb3JpdGhtOiBzaGEyNTZXaXRoUlNBRW5jcnlwdGlvbgor
ICAgICAgICAgNGU6MjU6ODA6MWI6Y2I6YjA6NDI6ZmY6YmI6M2Y6ZTg6MGQ6NTg6YzE6ODA6ZGI6
Y2Y6ZDA6CisgICAgICAgICA5MDpkZjpjYTpjMTplNjo0MTplMTo0ODo3ZjphNzoxZTpjNzozNTo5
Zjo5Yzo2ZDo3YzozZToKKyAgICAgICAgIDgyOmU4OmRlOjdlOmFlOjgyOjE2OjAwOjMzOjBmOjAy
OjIzOmYxOjlkOmZlOjJiOjA2OjE2OgorICAgICAgICAgMDU6NTU6MTY6ODk6ZGM6NjM6YWM6NWY6
MWE6MzE6MTM6Nzk6MjE6YTM6NmU6NjA6Mjg6ZTg6CisgICAgICAgICBlNzo2Yjo1NDowMDoyMjph
MTpiNzo2OTo1YToxNzozMTpjZTowZjpjMjphNjpkZDphMzo2ZjoKKyAgICAgICAgIGRlOmVhOjE5
OjZjOmQyOmQyOmNiOjM1OjlkOmRkOjg3OjUxOjMzOjY4OmNkOmMzOjliOjkwOgorICAgICAgICAg
NTU6ZjE6ODA6M2Q6NWM6Yjg6MDk6YjY6ZTE6M2M6MTM6YTQ6NWQ6NGE6Y2U6YTU6MTE6OWU6Cisg
ICAgICAgICBmOTowODplZTpiZTplMzo1NDoxZDowNjo0YzpiYjoxYjo3MjoxMzplZTo3ZDphMDo0
NTpjYzoKKyAgICAgICAgIGZlOmQxOjNiOjAyOjAzOmMxOmQ0OmVhOjQ1OjJkOmE4OmM5Ojk3OmU3
OmYzOjhhOjdhOmEwOgorICAgICAgICAgMmY6ZGQ6NDg6M2E6NzU6Yzk6NDI6Mjg6OTQ6ZmM6YWY6
NDQ6NTI6MTY6Njg6OTg6ZDY6YWQ6CisgICAgICAgICBhODo2NTpiMTpjZDphYzo2MDo0MTo3MDpl
NTo0NDplODo1YTpmMjplNzpmYzozYjpmZTo0NToKKyAgICAgICAgIDg5OjE3OjFkOjZkOjg1OmM2
OmYwOmZjOjY5Ojg3OmQxOjFkOjA3OmYzOmNiOjdiOjU0OjhkOgorICAgICAgICAgYWE6YTM6Y2M6
ZTM6YzY6ZmM6ZDY6MDU6NzY6MzU6ZDA6MjY6NjM6OGU6ZDE6YTg6Yjc6ZmY6CisgICAgICAgICA2
MTo0Mjo4YToyYzo2MzoxZjpkNDplYzoxNDo0Nzo2YjoxZTplMzo4MTo2MToxMjozYjo4YzoKKyAg
ICAgICAgIDE2OmI1OmNmOjg3OjZhOjJkOjQyOjIxOjgzOjljOjBlOjNhOjkwOjNhOjFlOmMxOjM2
OjYxOgorICAgICAgICAgNDE6Zjk6ZmI6NGU6NWQ6ZWE6ZjQ6ZGY6MjM6OTI6MzM6MmI6OWI6MTQ6
OWY6YTA6ZjU6ZDM6CisgICAgICAgICBjNDpmODoxZjoyZjo5YzoxMTozNjphZjoyYToyMjo2MTo5
NTozMjowYjpjNDoxYzoyZDpiMToKKyAgICAgICAgIGMxOjBhOjJhOjk3OmMwOjQzOjRhOjZjOjNl
OmRiOjAwOmNkOjI5OjE1OjllOjdlOjQxOjc1OgorICAgICAgICAgMzY6YTg6NTY6ODY6OGM6ODI6
OWU6NDY6MjA6ZTU6MDY6MWU6NjA6ZDI6MDM6NWY6OWY6OWU6CisgICAgICAgICA2OTpiYjpiZjpj
MjpiNDo0MzplMjo3ZDo4NToxNzo4MzoxODo0MTpiMDpjYjphOTowNDoxYjoKKyAgICAgICAgIDE4
OjUyOjlmOjg5OjhiOjc2OjlmOjk0OjU5OjgxOjRmOjYwOjViOjMzOjE4OmZjOmM3OjUyOgorICAg
ICAgICAgZDA6ZDI6Njk6ZmM6MGI6YTI6NjM6MzI6NzU6NDM6OTk6ZTk6ZDc6Zjg6NmQ6Yzc6NTU6
MzE6CisgICAgICAgICAwYzpmMzplZjoxYTo3MTplMTowYTo1NzplMTo5ZDoxMzpiMjoxZTpmZTox
ZDplZjplNDpmMToKKyAgICAgICAgIDUxOmQ5Ojk1OmIzOmZkOjI4OjI4OjkzOjkxOjRhOjI5OmM1
OjM3OjBlOmFiOmQ4Ojg1OjZhOgorICAgICAgICAgZmU6YTg6ODM6MWY6N2I6ODA6NWQ6MWY6MDQ6
Nzk6Yjc6YTk6MDg6NmU6MGQ6ZDY6MmU6YWE6CisgICAgICAgICA3YzpmNjo2Mzo3ZDo0MTpkZTo3
MDoxMzozMjpjZTpkZDo1ODpjYzphNjo3MzpkNDo3Mjo3ZToKKyAgICAgICAgIGQ3OmFjOjc0OmE4
OjM1OmJhOmMzOjFiOjJhOjY0OmQ3OjVhOjM3Ojk3OjU2Ojk0OjM0OjJiOgorICAgICAgICAgMmE6
NzE6NjA6YmM6Njk6YWI6MDA6ODU6Yjk6NGY6Njc6MzI6MTc6NTE6YzM6ZGE6NTc6M2E6CisgICAg
ICAgICAzNzo4OTo2NjpjNDo3YTo1MTpkYTo1ZgogLS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0t
Ci1NSUlEVVRDQ0FycWdBd0lCQWdJQkFUQU5CZ2txaGtpRzl3MEJBUVFGQURCbU1Rc3dDUVlEVlFR
R0V3SkxSekVMCitNSUlGZ0RDQ0EyaWdBd0lCQWdJQkFUQU5CZ2txaGtpRzl3MEJBUXNGQURCbU1R
c3dDUVlEVlFRR0V3SkxSekVMCiBNQWtHQTFVRUNCTUNUa0V4RURBT0JnTlZCQWNUQjBKSlUwaExS
VXN4RlRBVEJnTlZCQW9UREU5d1pXNVdVRTR0Ci1WRVZUVkRFaE1COEdDU3FHU0liM0RRRUpBUllT
YldWQWJYbG9iM04wTG0xNVpHOXRZV2x1TUI0WERUQTBNVEV5Ci1OVEUwTkRJeU1sb1hEVEUwTVRF
eU16RTBOREl5TWxvd2FqRUxNQWtHQTFVRUJoTUNTMGN4Q3pBSkJnTlZCQWdUCitWRVZUVkRFaE1C
OEdDU3FHU0liM0RRRUpBUllTYldWQWJYbG9iM04wTG0xNVpHOXRZV2x1TUI0WERURTBNVEF5CitN
akl4TlRrMU1sb1hEVEkwTVRBeE9USXhOVGsxTWxvd2FqRUxNQWtHQTFVRUJoTUNTMGN4Q3pBSkJn
TlZCQWdUCiBBazVCTVJVd0V3WURWUVFLRXd4UGNHVnVWbEJPTFZSRlUxUXhGREFTQmdOVkJBTVRD
MVJsYzNRdFUyVnlkbVZ5Ci1NU0V3SHdZSktvWklodmNOQVFrQkZoSnRaVUJ0ZVdodmMzUXViWGxr
YjIxaGFXNHdnWjh3RFFZSktvWklodmNOCi1BUUVCQlFBRGdZMEFNSUdKQW9HQkFNdE9yUG1EVi9a
cDBqSXB0THl0NXZjbUlZa3pNRU5Bb3pYWjNpWUIxclR3Ci12QW9aVlprNzhVeVJZTGI5ZERTTldz
ZGk3TTd5MWdMT1Z6TDBOWXh4b0cxbEt1ZUFyaWxaenpaeitIeEtjNUQ4Ci1NQ2pWUm4wMXBFN0pu
NUI3NGdraE5zV283SVdDbWpLMGtUdkIxaytmMGZodmFQUWQwZ2FSTXN5YVNQM05tSDh2Ci1BZ01C
QUFHamdnRUpNSUlCQlRBSkJnTlZIUk1FQWpBQU1CRUdDV0NHU0FHRytFSUJBUVFFQXdJR1FEQXpC
Z2xnCi1oa2dCaHZoQ0FRMEVKaFlrVDNCbGJsTlRUQ0JIWlc1bGNtRjBaV1FnVTJWeWRtVnlJRU5s
Y25ScFptbGpZWFJsCi1NQjBHQTFVZERnUVdCQlJwRWY3bm40bDdjVFJwd055QytOQmRUZnQ0M3pD
QmtBWURWUjBqQklHSU1JR0ZnQlNKCi1wbURqdXVvK3IveGtmMHk5ak5KSWplRE1ScUZxcEdnd1pq
RUxNQWtHQTFVRUJoTUNTMGN4Q3pBSkJnTlZCQWdUCi1BazVCTVJBd0RnWURWUVFIRXdkQ1NWTklT
MFZMTVJVd0V3WURWUVFLRXd4UGNHVnVWbEJPTFZSRlUxUXhJVEFmCi1CZ2txaGtpRzl3MEJDUUVX
RW0xbFFHMTVhRzl6ZEM1dGVXUnZiV0ZwYm9JQkFEQU5CZ2txaGtpRzl3MEJBUVFGCi1BQU9CZ1FB
MVhIWGFWKysxZWZLaTJ6YmtkZWpIdkhNbXp6QTJTeTVSUmpkZ0wwNHI5bkdpSTl1TzJGelZyeTRp
Ci1LTjB3cUlsbU9zeGJQQStXRWlEZVhrRlNkRFh0VENaQUdjcHozMVN4TUphY3BSVFFPQ2cvcXpB
SDE5NlkwbjkvCi1rTEpTSGVXVmlPMjZpbW9VaFdaMjdIVXc2SzZVOU9GMitrc084VlBYbGI3N2Fm
bzlNZz09CitNU0V3SHdZSktvWklodmNOQVFrQkZoSnRaVUJ0ZVdodmMzUXViWGxrYjIxaGFXNHdn
Z0VpTUEwR0NTcUdTSWIzCitEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUUNsdUtMdXpyR21EMnF5
bjlNaUYzbmVDWmh4ZVBxbnpqWlJWRmZICitNWmxXMFlyV3hmMVM1b2dPZS9ucUozcS9QeFRzcXRM
L2kxWllyTXBSZDhVOHR1U0RieUlHTFZ2cjUxblVxMExJCisxYW1IYzdOek5sRXZwZENRb29ka1ZH
d1MwN2gyUjJtdnJvOEFzM0M1NTJjL2pHbzllVitCSjZNT3FxYzlnVWdRCitzUmhzT0M2UGVudkZQ
U0hJK2FCL0Z5dUlUN3J5N0cwa2ptenhDbHpaVzdHdy9FbkxTdEpZeGlvbHNKZUV3NTcvCitOSXdR
Um44UCt6eFplcVlwREs2T1VEcnlVNFJBTGRXUmV3bzNqb0ozem1Zdk5IZGNwVVU3QUJtbkI5R1M1
bWE1CitPMDdwWS93em1CcXVld2g5Q3Q5NnVxcFpiWWFDQ21RcjJsbW5URTd2UGIwRW9rc3hBZ01C
QUFHamdnRXpNSUlCCitMekFKQmdOVkhSTUVBakFBTUJFR0NXQ0dTQUdHK0VJQkFRUUVBd0lHUURB
ekJnbGdoa2dCaHZoQ0FRMEVKaFlrCitUM0JsYmxOVFRDQkhaVzVsY21GMFpXUWdVMlZ5ZG1WeUlF
TmxjblJwWm1sallYUmxNQjBHQTFVZERnUVdCQlN6CituWUhtRnBKa3hJYUg5U2tRRzE0dmRQZnRz
VENCbUFZRFZSMGpCSUdRTUlHTmdCUXJRT1hKZmZYMGxqanBMK012CisyVUJreVk0Rm02RnFwR2d3
WmpFTE1Ba0dBMVVFQmhNQ1MwY3hDekFKQmdOVkJBZ1RBazVCTVJBd0RnWURWUVFICitFd2RDU1ZO
SVMwVkxNUlV3RXdZRFZRUUtFd3hQY0dWdVZsQk9MVlJGVTFReElUQWZCZ2txaGtpRzl3MEJDUUVX
CitFbTFsUUcxNWFHOXpkQzV0ZVdSdmJXRnBib0lKQUtGTzN2cVE4cTZCTUJNR0ExVWRKUVFNTUFv
R0NDc0dBUVVGCitCd01CTUFzR0ExVWREd1FFQXdJRm9EQU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0Fn
RUFUaVdBRzh1d1F2KzdQK2dOCitXTUdBMjgvUWtOL0t3ZVpCNFVoL3B4N0hOWitjYlh3K2d1amVm
cTZDRmdBekR3SWo4WjMrS3dZV0JWVVdpZHhqCityRjhhTVJONUlhTnVZQ2pvNTJ0VUFDS2h0Mmxh
RnpIT0Q4S20zYU52M3VvWmJOTFN5eldkM1lkUk0yak53NXVRCitWZkdBUFZ5NENiYmhQQk9rWFVy
T3BSR2UrUWp1dnVOVUhRWk11eHR5RSs1OW9FWE0vdEU3QWdQQjFPcEZMYWpKCitsK2Z6aW5xZ0w5
MUlPblhKUWlpVS9LOUVVaFpvbU5hdHFHV3h6YXhnUVhEbFJPaGE4dWY4Ty81RmlSY2RiWVhHCis4
UHhwaDlFZEIvUExlMVNOcXFQTTQ4YjgxZ1YyTmRBbVk0N1JxTGYvWVVLS0xHTWYxT3dVUjJzZTQ0
RmhFanVNCitGclhQaDJvdFFpR0RuQTQ2a0RvZXdUWmhRZm43VGwzcTlOOGprak1ybXhTZm9QWFR4
UGdmTDV3Uk5xOHFJbUdWCitNZ3ZFSEMyeHdRb3FsOEJEU213KzJ3RE5LUldlZmtGMU5xaFdob3lD
bmtZZzVRWWVZTklEWDUrZWFidS93clJECis0bjJGRjRNWVFiRExxUVFiR0ZLZmlZdDJuNVJaZ1U5
Z1d6TVkvTWRTME5KcC9BdWlZekoxUTVucDEvaHR4MVV4CitEUFB2R25IaENsZmhuUk95SHY0ZDcr
VHhVZG1Wcy8wb0tKT1JTaW5GTnc2cjJJVnEvcWlESDN1QVhSOEVlYmVwCitDRzROMWk2cWZQWmpm
VUhlY0JNeXp0MVl6S1p6MUhKKzE2eDBxRFc2d3hzcVpOZGFONWRXbERRcktuRmd2R21yCitBSVc1
VDJjeUYxSEQybGM2TjRsbXhIcFIybDg9CiAtLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCmRpZmYg
LS1naXQgYS9zYW1wbGUvc2FtcGxlLWtleXMvc2VydmVyLmtleSBiL3NhbXBsZS9zYW1wbGUta2V5
cy9zZXJ2ZXIua2V5CmluZGV4IDk3NmFjYWIuLjAxMWRmMTIgMTAwNjQ0Ci0tLSBhL3NhbXBsZS9z
YW1wbGUta2V5cy9zZXJ2ZXIua2V5CisrKyBiL3NhbXBsZS9zYW1wbGUta2V5cy9zZXJ2ZXIua2V5
CkBAIC0xLDE1ICsxLDI4IEBACi0tLS0tLUJFR0lOIFJTQSBQUklWQVRFIEtFWS0tLS0tCi1NSUlD
WGdJQkFBS0JnUURMVHF6NWcxZjJhZEl5S2JTOHJlYjNKaUdKTXpCRFFLTTEyZDRtQWRhMDhMd0tH
VldaCi1PL0ZNa1dDMi9YUTBqVnJIWXV6Tzh0WUN6bGN5OURXTWNhQnRaU3JuZ0s0cFdjODJjL2g4
U25PUS9EQW8xVVo5Ci1OYVJPeVorUWUrSUpJVGJGcU95Rmdwb3l0SkU3d2RaUG45SDRiMmowSGRJ
R2tUTE1ta2o5elpoL0x3SURBUUFCCi1Bb0dCQUtQMWxqQS9pWS96Tlk0NDdrWi81TldLemQ3dEJr
NG1jYmw3TTluby83TzZ0WnRiWlJvSUtvaTZjWW9DCi1DMVphYlV5QmJrTlR1ZDVYZENGbXEwelJV
ak9Xdm9GTVo5VlpmZDJrUlB2bDRUR2N6QnRKQXE2NWIrRVlNR3VpCi1xNlQ5cDYxeFBkdHp1MHZN
K0VjajEyN3BBTWs1WGNKeXh1OFhRSzdsWldtRzVVb0pBa0VBOEN4WE5aTitBM3FECi1iTUJQSTNW
ZHdLQ05Tak5WRVFFbnlnTWJOZ3c3VkxkeFBwc3B6WnppcUpFR2R6c000ZHNuT0J3S3hJV0ZMTjJo
Ci1sYkdCT3F1QXN3SkJBTmkwYXRHV004VlV4RGp2cXFIQ1RTOVJVWFdnbnZZaGVlNC94cmFKQlFQ
QlNpdmpDOVAwCi12S1Q3UGpCSFU2ZGp0S1NMS0dhSG4xdkhxbXlZN1BDTWpaVUNRUUNOVlNxRXhx
U3pHMWRYbWR0NFBFck5YaTJHCi02cW8yZFgyYXJUVklHdTZYTGRRZ1NXTFNNbTVYVC9DRUhXVzVT
eVBMS3dWVEhGZUFUWFFYQ1B2Sk1MOXRBa0VBCi1rMHlYYXgwZzFab1h3dWZONFNRVW1QdzZWYTAz
UC9CalUvblAxWlZ2Yml6OWdMVlUvZDdXTjRKN3RBOVhvbWtZCi1pZHY1T3pBbXR4a1NFNzBqR1NO
QXZRSkFXaENmOStpSGt6T0hSeUtLT1lsaDFESFV3RGZTRXAraGxaWWc5SDAzCi1QMnNyYVF6VXhn
V0RZL0RJWTYzS3ZXNzhueTg2M2JhRno3b256MjFNWUdnSlhnPT0KLS0tLS0tRU5EIFJTQSBQUklW
QVRFIEtFWS0tLS0tCistLS0tLUJFR0lOIFBSSVZBVEUgS0VZLS0tLS0KK01JSUV2UUlCQURBTkJn
a3Foa2lHOXcwQkFRRUZBQVNDQktjd2dnU2pBZ0VBQW9JQkFRQ2x1S0x1enJHbUQycXkKK245TWlG
M25lQ1poeGVQcW56alpSVkZmSE1abFcwWXJXeGYxUzVvZ09lL25xSjNxL1B4VHNxdEwvaTFaWXJN
cFIKK2Q4VTh0dVNEYnlJR0xWdnI1MW5VcTBMSTFhbUhjN056TmxFdnBkQ1Fvb2RrVkd3UzA3aDJS
Mm12cm84QXMzQzUKKzUyYy9qR285ZVYrQko2TU9xcWM5Z1VnUXNSaHNPQzZQZW52RlBTSEkrYUIv
Rnl1SVQ3cnk3RzBram16eENseloKK1c3R3cvRW5MU3RKWXhpb2xzSmVFdzU3L05Jd1FSbjhQK3p4
WmVxWXBESzZPVURyeVU0UkFMZFdSZXdvM2pvSjMKK3ptWXZOSGRjcFVVN0FCbW5COUdTNW1hNU8w
N3BZL3d6bUJxdWV3aDlDdDk2dXFwWmJZYUNDbVFyMmxtblRFN3YKK1BiMEVva3N4QWdNQkFBRUNn
Z0VBUE1PTWluK2pSNzVUWXhlVE5PYml1blZPUGgwYjJ6ZVRWeExUOUtmTkQ3WloKK2NCSzhwZzc5
U0VKUkNuaGJXNUJudmJlTkVrSW04UEM2WmxEQ00xYmtSd1VTdHEwZkRVcVE5NWVzTHpPWXE1L1MK
KzVxVzk4dmlibHN6aFUvcFlmamEvWmk4ZEkxdWY5NlBUNjNaYnQwTm5HUTlONDIrRExEZUtodFRH
ZGNoWnFpUUEKK0xlU1IwYlFhblk0dFVVdENOWXZCVDhFM3B6aG9Jc1V6Vnd6SUs1M29vdlJwY09Y
M3BNWFZZWnNtTmhYZEZGUnkKK1lrak1YcGo3Zkd5YUFKSzBRc0MrUHNnckt1aFhEekR0dHNHMmxJ
L21xOSs3UlhCM2QvcHpobUJWV3luVkgybHcKK2lRN09Oa1N6N2FrRHovNEk0V214SmVwK0ZmUUpZ
Z0s2cm5MQWxRcWF1UUtCZ1FEYW1tU0Fwcm52RHZOaFNFcDgKK1creHQ3alFuRnFhRU5iR2dQMC9E
L09aTVhjNGtoZ2V4cWxLRm1TbkJDUkRtUTZKdkxUV3FEWEM0K2FxQWJGUXoKK3pBSWppS2FUK3Nv
OHh2RlJvYityQk1KWTVKTFlLTmErelVVYW5mT1JVTllMRkpQdkZxbnJXR2FKOXV1ZmRhTTcKKzBh
NWJ1OTVQTjc0TlhlZTNEQmJwQnY4SEx3S0JnUURDRWsrSWpOYmpNVCtOZXEweXdVZU01ckZyVUtp
OTJhYmUKK0Fnc1ZwamJpZ2hSVis2akEybFpGSmNpemUreFlKOXdpT1IxL1RFSTlQWjJPdEJrcXB3
VmR2VEVIVGFnUkxjdmQKK05mR2NwdFJFRG5OTG9OV0EyMmJ1UXB6dGlFZHV1dEFDV1FzcmQrSlFt
cWJVaWNVZFc0enc4Ni9vQ01iWUNXM1YKK1FtWU9MbnM3bndLQmdISFVYMjBXWkU5MVM0cG1xRkts
VXpIVERka2sxRVNYNlF4MnEwUjAxajhCd2F3SEZzNk8KKzBEVzlFWjd3NTVuZnNoK09QUmwxc2pL
LzN1Yk1nZlFPMFRaTG0rSUdmM1N5YTBxRW5WZWlQTWtwRE1YK1RnUkEKK3d6RWUrb3U2dWhvKzl1
RlN2ZHhNeGVnbGFZQTVNMnljdk53THNiRXlaNFp5Vll4ZGdUaUthaFlGQW9HQWNJZlAKK2lEMHFL
UWlZY2ovdEI5NGN6KzNBZUpxSGpiWVQxTzFZWWhCRUNPa21RNGt1RzgwK2NzL3E1Vy80NWxFT2l1
V1YKK1hnZm83THU2alZHT3VqV29uZWNpODdvcXR2TllINGUwOW9HaDJXaUxvQkc5V3Y5ZFd0QlRV
RVJTTHpteGZYc0cKK1NBazJ1RWhFYmo4SWhmSmM4aVpMSEg5aVZVaDZZRXNsQkJvZHFMOENnWUVB
bEFodmNxQXZ3NVN6c2ZCUjVNY3UKKzROcWw2bVhFVmhIQ3ZTNGhkRkNHYU5GMHo5QTZlQk9SS0pw
ZExXbnFocHF1RFFEc2doV0UrR2E0UUtTTkZJaTEKK2ZuQWF5a21adVkzVG9xTk9JYVZsWU02SHBN
RXowd0hRYlRXZkRMR2NURmNFbExaZ01BazdWbER5aVlWT2NvK0UKK1FYOWxYT08xUEdwTHpYaGxE
eFNlNjNZPQorLS0tLS1FTkQgUFJJVkFURSBLRVktLS0tLQotLSAKMS45LjEKCg==
--089e0149c9b4d5b8c40507e642c2--

