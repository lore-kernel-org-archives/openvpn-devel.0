Message-ID: <54677113.70507@...515...>
Date: Sat, 15 Nov 2014 16:28:19 +0100
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1414016163-21102-1-git-send-email-steffan@...1856...>
	<CAA1AbxKZr_E6Wk9GBbB3xpLyJzyBxSa1k21UDXnC90d8refUzw@...278...>
In-Reply-To: <CAA1AbxKZr_E6Wk9GBbB3xpLyJzyBxSa1k21UDXnC90d8refUzw@...278...>
Content-Type: multipart/alternative;
	boundary="------------060807030303030606060902"
Subject: Re: [Openvpn-devel] [PATCH] Modernize sample keys and sample configs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060807030303030606060902
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Steffan,

I tested the key generation script with /bin/bash and /bin/dash on
Linux, and using /bin/sh on FreeBSD. The rest of the patch looked fine, too.

ACK.

Samuli

> Attached a v2 of this patch that adds an extra check whether openssl is actually available.
>
> -Steffan
>
> On Thu, Oct 23, 2014 at 12:16 AM, Steffan Karger <steffan@...1856...
<mailto:steffan@...1856...>> wrote:
>
>     I kept most of the certificate properties equal to the old
>     certs, since some people's test scripts might rely on them (and
>     it does not require any creativity from my part).
>
>     Changes:
>      * Add script to generate fresh test/sample keys
>        (but keep sample keys in git for simple testing)
>      * Switch from 1024 to 4096 bits RSA CA
>      * Switch from 1024 to 2048 bits client/server RSA keys
>      * Switch from 1024 to 2048 bits Diffie-Hellman parameters
>      * Generate EC client and server cert, but sign with RSA CA
>        (lets us test EC <-> RSA interoperability)
>      * Remove 3DES cipher from 'sample' config
>      * Add 'remote-cert-tls server' to client config
>      * Update config files to deprecate nsCertType in favour of the
>        keyUsage and extendedKeyUsage extensions.
>      * Make naming more consistent
>
>     Signed-off-by: Steffan Karger <steffan@...1856...
<mailto:steffan@...1856...>>
>     ---
>      sample/sample-config-files/client.conf     |  17 ++--
>      sample/sample-config-files/loopback-client |   2 +-
>      sample/sample-config-files/loopback-server |   3 +-
>      sample/sample-config-files/server.conf     |   6 +-
>      sample/sample-config-files/tls-office.conf |   2 +-
>      sample/sample-keys/.gitignore              |   1 +
>      sample/sample-keys/README                  |  17 ++--
>      sample/sample-keys/ca.crt                  |  48 ++++++----
>      sample/sample-keys/ca.key                  |  67 ++++++++++----
>      sample/sample-keys/client-ec.crt           |  85 ++++++++++++++++++
>      sample/sample-keys/client-ec.key           |   5 ++
>      sample/sample-keys/client-pass.key         |  30 +++++++
>      sample/sample-keys/client.crt              | 126
+++++++++++++++++---------
>      sample/sample-keys/client.key              |  43 +++++----
>      sample/sample-keys/client.p12              | Bin 0 -> 4533 bytes
>      sample/sample-keys/dh1024.pem              |   5 --
>      sample/sample-keys/dh2048.pem              |   8 ++
>      sample/sample-keys/ec-ca.crt               |  13 ---
>      sample/sample-keys/ec-ca.key               |   6 --
>      sample/sample-keys/ec-client.crt           |  61 -------------
>      sample/sample-keys/ec-client.key           |   6 --
>      sample/sample-keys/ec-server.crt           |  61 -------------
>      sample/sample-keys/ec-server.key           |   6 --
>      sample/sample-keys/gen-sample-keys.sh      |  74 +++++++++++++++
>      sample/sample-keys/openssl.cnf             | 139
+++++++++++++++++++++++++++++
>      sample/sample-keys/pass.crt                |  65 --------------
>      sample/sample-keys/pass.key                |  18 ----
>      sample/sample-keys/pkcs12.p12              | Bin 2685 -> 0 bytes
>      sample/sample-keys/server-ec.crt           |  96 ++++++++++++++++++++
>      sample/sample-keys/server-ec.key           |   5 ++
>      sample/sample-keys/server.crt              | 130
++++++++++++++++++---------
>      sample/sample-keys/server.key              |  43 +++++----
>      32 files changed, 778 insertions(+), 410 deletions(-)
>      create mode 100644 sample/sample-keys/.gitignore
>      create mode 100644 sample/sample-keys/client-ec.crt
>      create mode 100644 sample/sample-keys/client-ec.key
>      create mode 100644 sample/sample-keys/client-pass.key
>      create mode 100644 sample/sample-keys/client.p12
>      delete mode 100644 sample/sample-keys/dh1024.pem
>      create mode 100644 sample/sample-keys/dh2048.pem
>      delete mode 100644 sample/sample-keys/ec-ca.crt
>      delete mode 100644 sample/sample-keys/ec-ca.key
>      delete mode 100644 sample/sample-keys/ec-client.crt
>      delete mode 100644 sample/sample-keys/ec-client.key
>      delete mode 100644 sample/sample-keys/ec-server.crt
>      delete mode 100644 sample/sample-keys/ec-server.key
>      create mode 100755 sample/sample-keys/gen-sample-keys.sh
>      create mode 100644 sample/sample-keys/openssl.cnf
>      delete mode 100644 sample/sample-keys/pass.crt
>      delete mode 100644 sample/sample-keys/pass.key
>      delete mode 100644 sample/sample-keys/pkcs12.p12
>      create mode 100644 sample/sample-keys/server-ec.crt
>      create mode 100644 sample/sample-keys/server-ec.key
>
>     diff --git a/sample/sample-config-files/client.conf
b/sample/sample-config-files/client.conf
>     index 58b2038..050ef60 100644
>     --- a/sample/sample-config-files/client.conf
>     +++ b/sample/sample-config-files/client.conf
>     @@ -89,18 +89,19 @@ ca ca.crt
>      cert client.crt
>      key client.key
>
>     -# Verify server certificate by checking
>     -# that the certicate has the nsCertType
>     -# field set to "server".  This is an
>     -# important precaution to protect against
>     +# Verify server certificate by checking that the
>     +# certicate has the correct key usage set.
>     +# This is an important precaution to protect against
>      # a potential attack discussed here:
>      #  http://openvpn.net/howto.html#mitm
>      #
>      # To use this feature, you will need to generate
>     -# your server certificates with the nsCertType
>     -# field set to "server".  The build-key-server
>     -# script in the easy-rsa folder will do this.
>     -ns-cert-type server
>     +# your server certificates with the keyUsage set to
>     +#   digitalSignature, keyEncipherment
>     +# and the extendedKeyUsage to
>     +#   serverAuth
>     +# EasyRSA can do this for you.
>     +remote-cert-tls server
>
>      # If a tls-auth key is used on the server
>      # then every client must also have the key.
>     diff --git a/sample/sample-config-files/loopback-client
b/sample/sample-config-files/loopback-client
>     index d7f59e6..ebbd1cf 100644
>     --- a/sample/sample-config-files/loopback-client
>     +++ b/sample/sample-config-files/loopback-client
>     @@ -17,9 +17,9 @@ dev null
>      verb 3
>      reneg-sec 10
>      tls-client
>     +remote-cert-tls server
>      ca sample-keys/ca.crt
>      key sample-keys/client.key
>      cert sample-keys/client.crt
>     -cipher DES-EDE3-CBC
>      ping 1
>      inactive 120 10000000
>     diff --git a/sample/sample-config-files/loopback-server
b/sample/sample-config-files/loopback-server
>     index 9d21bce..8cb97be 100644
>     --- a/sample/sample-config-files/loopback-server
>     +++ b/sample/sample-config-files/loopback-server
>     @@ -17,10 +17,9 @@ dev null
>      verb 3
>      reneg-sec 10
>      tls-server
>     -dh sample-keys/dh1024.pem
>     +dh sample-keys/dh2048.pem
>      ca sample-keys/ca.crt
>      key sample-keys/server.key
>      cert sample-keys/server.crt
>     -cipher DES-EDE3-CBC
>      ping 1
>      inactive 120 10000000
>     diff --git a/sample/sample-config-files/server.conf
b/sample/sample-config-files/server.conf
>     index 467d5b8..701be3c 100644
>     --- a/sample/sample-config-files/server.conf
>     +++ b/sample/sample-config-files/server.conf
>     @@ -81,10 +81,8 @@ key server.key  # This file should be kept secret
>
>      # Diffie hellman parameters.
>      # Generate your own with:
>     -#   openssl dhparam -out dh1024.pem 1024
>     -# Substitute 2048 for 1024 if you are using
>     -# 2048 bit keys.
>     -dh dh1024.pem
>     +#   openssl dhparam -out dh2048.pem 2048
>     +dh dh2048.pem
>
>      # Network topology
>      # Should be subnet (addressing via IP)
>     diff --git a/sample/sample-config-files/tls-office.conf
b/sample/sample-config-files/tls-office.conf
>     index f790f46..d196144 100644
>     --- a/sample/sample-config-files/tls-office.conf
>     +++ b/sample/sample-config-files/tls-office.conf
>     @@ -26,7 +26,7 @@ up ./office.up
>      tls-server
>
>      # Diffie-Hellman Parameters (tls-server only)
>     -dh dh1024.pem
>     +dh dh2048.pem
>
>      # Certificate Authority file
>      ca my-ca.crt
>     diff --git a/sample/sample-keys/.gitignore
b/sample/sample-keys/.gitignore
>     new file mode 100644
>     index 0000000..f148752
>     --- /dev/null
>     +++ b/sample/sample-keys/.gitignore
>     @@ -0,0 +1 @@
>     +sample-ca/
>     diff --git a/sample/sample-keys/README b/sample/sample-keys/README
>     index 9f4f918..66dd945 100644
>     --- a/sample/sample-keys/README
>     +++ b/sample/sample-keys/README
>     @@ -1,14 +1,19 @@
>      Sample RSA and EC keys.
>
>     +Run ./gen-sample-keys.sh to generate fresh test keys.
>     +
>      See the examples section of the man page for usage examples.
>
>      NOTE: THESE KEYS ARE FOR TESTING PURPOSES ONLY.
>            DON'T USE THEM FOR ANY REAL WORK BECAUSE
>            THEY ARE TOTALLY INSECURE!
>
>     -ca.{crt,key}     -- sample CA key/cert
>     -client.{crt,key} -- sample client key/cert
>     -server.{crt,key} -- sample server key/cert (nsCertType=server)
>     -pass.{crt,key}   -- sample client key/cert with
password-encrypted key
>     -                    password = "password"
>     -ec-*.{crt,key}   -- sample elliptic curve variants of the above
>     +ca.{crt,key}        -- sample CA key/cert
>     +server.{crt,key}    -- sample server key/cert
>     +client.{crt,key}    -- sample client key/cert
>     +client-pass.key     -- sample client key with password-encrypted key
>     +                       password = "password"
>     +client.p12          -- sample client pkcs12 bundle
>     +                       password = "password"
>     +client-ec.{crt,key} -- sample elliptic curve client key/cert
>     +server-ec.{crt,key} -- sample elliptic curve server key/cert
>     diff --git a/sample/sample-keys/ca.crt b/sample/sample-keys/ca.crt
>     index e063ccc..a11bafa 100644
>     --- a/sample/sample-keys/ca.crt
>     +++ b/sample/sample-keys/ca.crt
>     @@ -1,19 +1,35 @@
>      -----BEGIN CERTIFICATE-----
>     -MIIDBjCCAm+gAwIBAgIBADANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL
>     +MIIGKDCCBBCgAwIBAgIJAKFO3vqQ8q6BMA0GCSqGSIb3DQEBCwUAMGYxCzAJBgNV
>     +BAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMM
>     +T3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4w
>     +HhcNMTQxMDIyMjE1OTUyWhcNMjQxMDE5MjE1OTUyWjBmMQswCQYDVQQGEwJLRzEL
>      MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
>     -VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy
>     -NTE0NDA1NVoXDTE0MTEyMzE0NDA1NVowZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
>     -Ak5BMRAwDgYDVQQHEwdCSVNIS0VLMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxITAf
>     -BgkqhkiG9w0BCQEWEm1lQG15aG9zdC5teWRvbWFpbjCBnzANBgkqhkiG9w0BAQEF
>     -AAOBjQAwgYkCgYEAqPjWJnesPu6bR/iec4FMz3opVaPdBHxg+ORKNmrnVZPh0t8/
>     -ZT34KXkYoI9B82scurp8UlZVXG8JdUsz+yai8ti9+g7vcuyKUtcCIjn0HLgmdPu5
>     -gFX25lB0pXw+XIU031dOfPvtROdG5YZN5yCErgCy7TE7zntLnkEDuRmyU6cCAwEA
>     -AaOBwzCBwDAdBgNVHQ4EFgQUiaZg47rqPq/8ZH9MvYzSSI3gzEYwgZAGA1UdIwSB
>     -iDCBhYAUiaZg47rqPq/8ZH9MvYzSSI3gzEahaqRoMGYxCzAJBgNVBAYTAktHMQsw
>     -CQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMMT3BlblZQTi1U
>     -RVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CAQAwDAYDVR0T
>     -BAUwAwEB/zANBgkqhkiG9w0BAQQFAAOBgQBfJoiWYrYdjM0mKPEzUQk0nLYTovBP
>     -I0es/2rfGrin1zbcFY+4dhVBd1E/StebnG+CP8r7QeEIwu7x8gYDdOLLsZn+2vBL
>     -e4jNU1ClI6Q0L7jrzhhunQ5mAaZztVyYwFB15odYcdN2iO0tP7jtEsvrRqxICNy3
>     -8itzViPTf5W4sA==
>     +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMIICIjANBgkq
>     +hkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAsJVPCqt3vtoDW2U0DII1QIh2Qs0dqh88
>     +8nivxAIm2LTq93e9fJhsq3P/UVYAYSeCIrekXypR0EQgSgcNTvGBMe20BoHO5yvb
>     +GjKPmjfLj6XRotCOGy8EDl/hLgRY9efiA8wsVfuvF2q/FblyJQPR/gPiDtTmUiqF
>     +qXa7AJmMrqFsnWppOuGd7Qc6aTsae4TF1e/gUTCTraa7NeHowDaKhdyFmEEnCYR5
>     +CeUsx2JlFWAH8PCrxBpHYbmGyvS0kH3+rQkaSM/Pzc2bS4ayHaOYRK5XsGq8XiNG
>     +KTTLnSaCdPeHsI+3xMHmEh+u5Og2DFGgvyD22gde6W2ezvEKCUDrzR7bsnYqqyUy
>     +n7LxnkPXGyvR52T06G8KzLKQRmDlPIXhzKMO07qkHmIonXTdF7YI1azwHpAtN4dS
>     +rUe1bvjiTSoEsQPfOAyvD0RMK/CBfgEZUzAB50e/IlbZ84c0DJfUMOm4xCyft1HF
>     +YpYeyCf5dxoIjweCPOoP426+aTXM7kqq0ieIr6YxnKV6OGGLKEY+VNZh1DS7enqV
>     +HP5i8eimyuUYPoQhbK9xtDGMgghnc6Hn8BldPMcvz98HdTEH4rBfA3yNuCxLSNow
>     +4jJuLjNXh2QeiUtWtkXja7ec+P7VqKTduJoRaX7cs+8E3ImigiRnvmK+npk7Nt1y
>     +YE9hBRhSoLsCAwEAAaOB2DCB1TAdBgNVHQ4EFgQUK0DlyX319JY46S/jL9lAZMmO
>     +BZswgZgGA1UdIwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRoMGYxCzAJ
>     +BgNVBAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UE
>     +ChMMT3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21h
>     +aW6CCQChTt76kPKugTAMBgNVHRMEBTADAQH/MAsGA1UdDwQEAwIBBjANBgkqhkiG
>     +9w0BAQsFAAOCAgEABc77f4C4P8fIS+V8qCJmVNSDU44UZBc+D+J6ZTgW8JeOHUIj
>     +Bh++XDg3gwat7pIWQ8AU5R7h+fpBI9n3dadyIsMHGwSogHY9Gw7di2RVtSFajEth
>     +rvrq0JbzpwoYedMh84sJ2qI/DGKW9/Is9+O52fR+3z3dY3gNRDPQ5675BQ5CQW9I
>     +AJgLOqzD8Q0qrXYi7HaEqzNx6p7RDTuhFgvTd+vS5d5+28Z5fm2umnq+GKHF8W5P
>     +ylp2Js119FTVO7brusAMKPe5emc7tC2ov8OFFemQvfHR41PLryap2VD81IOgmt/J
>     +kX/j/y5KGux5HZ3lxXqdJbKcAq4NKYQT0mCkRD4l6szaCEJ+k0SiM9DdTcBDefhR
>     +9q+pCOyMh7d8QjQ1075mF7T+PGkZQUW1DUjEfrZhICnKgq+iEoUmM0Ee5WtRqcnu
>     +5BTGQ2mSfc6rV+Vr+eYXqcg7Nxb3vFXYSTod1UhefonVqwdmyJ2sC79zp36Tbo2+
>     +65NW2WJK7KzPUyOJU0U9bcu0utvDOvGWmG+aHbymJgcoFzvZmlXqMXn97pSFn4jV
>     +y3SLRgJXOw1QLXL2Y5abcuoBVr4gCOxxk2vBeVxOMRXNqSWZOFIF1bu/PxuDA+Sa
>     +hEi44aHbPXt9opdssz/hdGfd8Wo7vEJrbg7c6zR6C/Akav1Rzy9oohIdgOw=
>      -----END CERTIFICATE-----
>     diff --git a/sample/sample-keys/ca.key b/sample/sample-keys/ca.key
>     index b4bf792..8b11bc2 100644
>     --- a/sample/sample-keys/ca.key
>     +++ b/sample/sample-keys/ca.key
>     @@ -1,15 +1,52 @@
>     ------BEGIN RSA PRIVATE KEY-----
>     -MIICXQIBAAKBgQCo+NYmd6w+7ptH+J5zgUzPeilVo90EfGD45Eo2audVk+HS3z9l
>     -PfgpeRigj0Hzaxy6unxSVlVcbwl1SzP7JqLy2L36Du9y7IpS1wIiOfQcuCZ0+7mA
>     -VfbmUHSlfD5chTTfV058++1E50blhk3nIISuALLtMTvOe0ueQQO5GbJTpwIDAQAB
>     -AoGAQuVREyWp4bhhbZr2UFBOco2ws6EOLWp4kdD/uI+WSoEjlHKiDJj+GJ1CrL5K
>     -o+4yD5MpCQf4/4FOQ0ukprfjJpDwDinTG6vzuWSLTHNiTgvksW3vy7IsNMJx97hT
>     -4D2QOOl9HhA50Qqg70teMPYXOgLRMVsdCIV7p7zDNy4nM+ECQQDX8m5ZcQmPtUDA
>     -38dPTfpL4U7kMB94FItJYH/Lk5kMW1/J33xymNhL+BHaG064ol9n2ubGW4XEO5t2
>     -qE1IOsVpAkEAyE/x/OBVSI1s75aYGlEwMd87p3qaDdtXT7WzujjRY7r8Y1ynkMU6
>     -GtMeneBX/lk4BY/6I+5bhAzce+hqhaXejwJBAL5Wg+c4GApf41xdogqHm7doNyYw
>     -OHyZ9w9NDDc+uGbI30xLPSCxEe0cEXgiG6foDpm2uzRZFTWaqHPU8pFYpAkCQGNX
>     -cpWM0/7VVK9Fqk1y8knpgfY/UWOJ4jU/0dCLGR0ywLSuYNPlXDmtdkOp3TnhGW14
>     -x/9F2NEWZ8pzq1B4wHUCQQC5ztD4m/rpiIpinoewUJODoeBJXYBKqx1+mdrALCq6
>     -ESvK1WRiusMaY3xmsdv4J2TB5iUPryELbn3jU12WGcQc
>     ------END RSA PRIVATE KEY-----
>     +-----BEGIN PRIVATE KEY-----
>     +MIIJQwIBADANBgkqhkiG9w0BAQEFAASCCS0wggkpAgEAAoICAQCwlU8Kq3e+2gNb
>     +ZTQMgjVAiHZCzR2qHzzyeK/EAibYtOr3d718mGyrc/9RVgBhJ4Iit6RfKlHQRCBK
>     +Bw1O8YEx7bQGgc7nK9saMo+aN8uPpdGi0I4bLwQOX+EuBFj15+IDzCxV+68Xar8V
>     +uXIlA9H+A+IO1OZSKoWpdrsAmYyuoWydamk64Z3tBzppOxp7hMXV7+BRMJOtprs1
>     +4ejANoqF3IWYQScJhHkJ5SzHYmUVYAfw8KvEGkdhuYbK9LSQff6tCRpIz8/NzZtL
>     +hrIdo5hErlewarxeI0YpNMudJoJ094ewj7fEweYSH67k6DYMUaC/IPbaB17pbZ7O
>     +8QoJQOvNHtuydiqrJTKfsvGeQ9cbK9HnZPTobwrMspBGYOU8heHMow7TuqQeYiid
>     +dN0XtgjVrPAekC03h1KtR7Vu+OJNKgSxA984DK8PREwr8IF+ARlTMAHnR78iVtnz
>     +hzQMl9Qw6bjELJ+3UcVilh7IJ/l3GgiPB4I86g/jbr5pNczuSqrSJ4ivpjGcpXo4
>     +YYsoRj5U1mHUNLt6epUc/mLx6KbK5Rg+hCFsr3G0MYyCCGdzoefwGV08xy/P3wd1
>     +MQfisF8DfI24LEtI2jDiMm4uM1eHZB6JS1a2ReNrt5z4/tWopN24mhFpftyz7wTc
>     +iaKCJGe+Yr6emTs23XJgT2EFGFKguwIDAQABAoICAQCEYPqnihI0PqZjnwQdGIQp
>     +g+P8gl7pyY9cS0OhUueicEbyDI8+V9qn0kcmx61zKDY0Jq4QNd6tnlUCijTc6Mot
>     +DwF2G1xsC4GvKxZiy89MOkhloanXETEeQZzDbbjvaM4UgL0AHLWPfZQRCjxbKXkE
>     +0A5phgvAr2YSvBLHCVXhGN0fScXnwXouVsvgVdGtpcTWdIUa+KrNdQBGDbz6VCkW
>     +31I76SQFy40d8PPX6ZjUJHDvnM14LycySO6XOkofRIVnXTqaOUiVBb2VKj5fX+Ro
>     +ILdWZz4d6J3RiGXYwyTr4SGVKLjgxWfgUGZB7x+NrqgugNzuaLYrkuWKSEN42nWq
>     +yoP6x6xtbAsmB6Fvdqwm/d8BmLhUweaVc0L7AYzXNsOBuT3kubJHMmu3Jv4xgyWk
>     +l/MAGJQc7i7QQweGgsYZgR8WlbkWkSFpUcgQBDzDibb6nsD2jnYijQrnrrmiEjEI
>     +R7MO551V+nFw9utiM8U9WIWwqzY0d98ujWkGjVe7uz9ZBVyg0DEAEj/zRi9T54aG
>     +1V6CB2Cjyw+HzzsDw7yWroWzo4U9YfjbPKCoBsXlqQFLFwY8oL6mEZ7UOobaV1Zl
>     +WtuHyYw3UNFxuSGPPyxJkFePIQLLvfKvh2R+V0DrT3UJRoKKlt9RejRSN0tOh0Cm
>     +2YD6d7T/DXnQHomIQKhKEQKCAQEA3sgsDg0eKDK8pUyVE+9wW5kql12nTzpBtnCM
>     +eg5J9OJcXKhCD/NIyUTIMXoMvZQpLwGUAYLgu4gE04zKWHDouf7MRSFltD5LJ7F2
>     +7nuYKHZXk0BhgMhdnQot3FKcOMrKCnZcM+RWX9ZJa8wO6whCaYCw7DtS0SSVODQk
>     +9EwAgX6/Hq60V7ujPZJCyNd3o0bIdAA/0AQRTZUADP3AHgUzh71aysYJt+UKt1v0
>     +Xc7l6hn7Dn7Ewzpf+WdZ2pV7d3JUSBVKiTDxLV904nDBNOxjMhz0rW01ojR6bzpn
>     +XhkFPqnmh+yEYGRgfSAAzkvSsSJEAtBFSicupA/6n83Lo2YvswKCAQEAyumuxP4Z
>     +a7s8x8DFba7vuQ+KVxpkKgEz1sxnGRNQJm18/ss/Y5JiaLFYT3E72VkQfBQ2ngu+
>     +GrJL3OhiNhzy1KLGS6mrwULtKiuud5MMQDL0Pvkncr9NTy4rBnWzhp2XyPeETu8n
>     +JpL2i2OK6lY/lgpBckXuap9gAl0fXk+y+BkZ71OoYaGnKpPjs+Xcq/qgPgZ7O3NW
>     +1g+Bd2AVPSxQpXjuy5rgtQURCN733vkNBzFedKREx7Z6l8UPlK/Exuc7BMIHfn5V
>     +dd0R3Th+82fkMNVJz6MKmHJ6CJI53M7co/YdAvIkxOFRIPGbO3arL2R69nRgAZBE
>     +zLawx1JJTRIG2QKCAQATtZXgMFzopYR3A011FAvWrrhL5+czZS4HG/Hxom38kkIl
>     +mGUv0BAybjlf1zJlW0RBelxDvfZv4Nq8dIo6RNLyEY601v2OcqxneJXTB3AwtDeP
>     +OXTm1dMiX5IrGcvkYlx5jHsfxCW4GNcqCEWRmYt2lgIRBDaRdjEVZdeXHVo2GqaB
>     +6mbeFCWe/t+VsSpOcaauTI9YseNt/66fd5uVjFRAwAnWQqr9b/AAxMvbuMAyc9X4
>     +NFLoCrQO9ovGgM8JhD3cmrWbaY8MupM2rU8KhZdJCbLD3ROPpCDo0jvu4TvLjXBt
>     +ugkEFh1LNJedqKudLDDkJtTaeJjxvtAnbyeC7zltAoIBAC9TIyzUqq8io0FfZ2x2
>     +cXiy9CvuftABKcr+L0l85KOhw5ZVZvpdKNCMFDGrEi9WA28886QWzwbA8Mqb9FP0
>     +mnoXYLJC50kSx+ee+nju9dt/RtHtIFM15N0DwosmJnHODZmUiOo0AuiPPCs0UzDm
>     +Xrwqtirlvn5ln2nNuEQxyGbuy8qys0HaBvf6OBA8GySNNpRgxJsQAn+4bBSgdzOm
>     +Q0TkmKUqASCXBusPvbXmVjCIRiRkL5p4p8z/6+tct0NAqNYqPr80zc/IeKMkyw8P
>     ++vucszNXLmBxyp53JEGoiXNAMnH+ca7tchOB5hePTMun3rneWInk0PcB4OcL/QaZ
>     +nrkCggEBAN67+SvcWtM1BoLXSz5/apFAE+DicCv94PrvMBOhfvu1oBrElR1rBjiN
>     +2B83SktkF4WhCXr10GP+RUpjaqPBtT7NW4r3fL5B8EPsHeabL+pg9e6wG1rH8GqG
>     +toWecmfC9uqK7l1A59h5Oveq5K19bZTRZRjQtv2e4KQknlJR6cwy+TGUU5kAUlMt
>     +vcivyjzxc0UQwq7zKktJq+xW/TZiSLgd3B32p0sXX378qFUJ4SO2UZ1OCh8R7PY1
>     +Fx25K/89Q1yGdbYiXb/Dx0a2WB9rP+b6alMl/dxPdqDKj2QXXkdh8+yvhVpQTyZw
>     +B1RaqQXwzqrCH0F/vw3lRceYhcQvzcQ=
>     +-----END PRIVATE KEY-----
>     diff --git a/sample/sample-keys/client-ec.crt
b/sample/sample-keys/client-ec.crt
>     new file mode 100644
>     index 0000000..edc6fe3
>     --- /dev/null
>     +++ b/sample/sample-keys/client-ec.crt
>     @@ -0,0 +1,85 @@
>     +Certificate:
>     +    Data:
>     +        Version: 3 (0x2)
>     +        Serial Number: 4 (0x4)
>     +    Signature Algorithm: sha256WithRSAEncryption
>     +        Issuer: C=KG, ST=NA, L=BISHKEK,
O=OpenVPN-TEST/emailAddress=me@...430...
>     +        Validity
>     +            Not Before: Oct 22 21:59:53 2014 GMT
>     +            Not After : Oct 19 21:59:53 2024 GMT
>     +        Subject: C=KG, ST=NA, O=OpenVPN-TEST,
CN=Test-Client-EC/emailAddress=me@...430...
>     +        Subject Public Key Info:
>     +            Public Key Algorithm: id-ecPublicKey
>     +                Public-Key: (256 bit)
>     +                pub:
>     +                    04:3b:ce:62:5d:6f:87:82:75:24:c2:58:f5:0e:88:
>     +                    4d:57:0d:06:b2:71:88:87:58:19:bb:de:5f:7f:52:
>     +                    62:51:a2:48:91:83:48:91:90:3e:87:02:0f:15:51:
>     +                    f9:68:97:12:0a:fd:d2:3c:87:83:4b:65:54:00:44:
>     +                    8d:28:76:49:05
>     +                ASN1 OID: secp256k1
>     +        X509v3 extensions:
>     +            X509v3 Basic Constraints:
>     +                CA:FALSE
>     +            X509v3 Subject Key Identifier:
>     +               
64:F6:49:88:E7:74:C1:AB:A5:FA:4F:2B:71:3C:25:13:3D:C8:94:C5
>     +            X509v3 Authority Key Identifier:
>     +               
keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
>     +               
DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
>     +                serial:A1:4E:DE:FA:90:F2:AE:81
>     +
>     +    Signature Algorithm: sha256WithRSAEncryption
>     +         32:3d:f0:08:67:dd:03:73:76:cc:76:52:0a:f6:97:d1:c6:fa:
>     +         5f:d3:e6:28:c9:75:a7:08:a8:34:49:69:cf:eb:ab:da:86:b3:
>     +         2e:65:17:ee:7e:b6:b5:6b:15:0b:dc:11:3a:b9:5a:b3:80:b8:
>     +         bb:f4:6c:cf:88:3a:10:83:7e:10:a0:82:87:6e:06:ec:78:62:
>     +         d4:d1:44:27:dd:2c:19:d8:1a:a1:ae:f4:a0:00:7f:53:5a:40:
>     +         8a:c2:83:77:4b:26:7d:53:b0:d3:0f:2f:7c:28:70:ef:74:58:
>     +         5b:de:81:94:4c:63:19:f0:79:cb:6c:b2:ec:32:1b:4b:e4:62:
>     +         22:4f:ad:ac:4a:6f:a9:6e:c4:2a:8d:8a:88:19:09:fd:88:93:
>     +         3c:27:4d:91:95:ff:57:84:13:fd:4a:68:db:20:df:10:e6:81:
>     +         1d:fd:e7:1d:35:fb:19:02:dd:b5:5f:a0:c1:07:ec:74:b4:ef:
>     +         8b:f9:33:9a:f2:a6:3b:6e:b6:4a:52:ab:5d:99:76:64:62:c4:
>     +         d5:3a:c6:81:8d:eb:c8:4b:02:af:e1:ca:60:e9:8d:c7:a9:2b:
>     +         ea:4f:56:31:d3:9a:11:c2:9c:83:5c:a2:8d:98:fe:cc:a5:ad:
>     +         1f:51:c4:6e:cf:ff:a0:51:64:c8:7f:7f:32:05:4c:8d:7f:bf:
>     +         b8:ed:e5:81:5f:81:bd:1d:9b:3f:8a:83:27:26:b4:69:84:8b:
>     +         e5:d9:ea:fd:08:a8:aa:e4:3a:dc:29:4d:80:6c:13:f7:45:ce:
>     +         92:f2:a9:f3:5f:90:83:d6:23:0f:50:e5:40:09:4c:6b:f2:73:
>     +         aa:d8:49:a7:a9:81:6e:bb:f2:e4:a5:7f:19:39:1d:65:f3:11:
>     +         97:b1:2b:7c:2f:36:77:7f:75:fd:88:44:90:7c:f2:33:8d:cd:
>     +         2c:f6:76:60:33:d3:f4:b3:8c:81:d7:85:89:cc:d7:d5:2c:94:
>     +         a9:31:3f:d3:63:a7:dc:82:3f:0a:d8:c5:71:97:69:3b:c1:69:
>     +         cb:f0:1b:be:15:c0:be:aa:fd:e8:13:2c:0c:3f:72:7b:7d:9c:
>     +         3b:7f:b8:82:36:4b:ad:4d:16:19:b9:1c:b3:2d:d7:5f:8b:f8:
>     +         14:ce:d4:13:e5:82:7a:1d:40:28:08:65:4a:19:d7:7a:35:09:
>     +         db:36:48:4b:96:44:bd:1f:12:b2:39:08:1e:5b:66:25:9b:e0:
>     +         16:d3:79:05:e3:f6:90:da:95:95:33:a1:53:a8:3c:a9:f0:b2:
>     +         f5:d0:aa:80:a0:96:ca:8c:45:62:c2:74:04:91:68:27:fb:e9:
>     +         97:be:3a:87:8a:85:28:2d:6e:a9:60:9b:63:ba:65:98:5e:bb:
>     +         02:ee:ac:ba:be:f6:42:26
>     +-----BEGIN CERTIFICATE-----
>     +MIIESTCCAjGgAwIBAgIBBDANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL
>     +MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
>     +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy
>     +MjIxNTk1M1oXDTI0MTAxOTIxNTk1M1owbTELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
>     +Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFzAVBgNVBAMTDlRlc3QtQ2xpZW50
>     +LUVDMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wVjAQBgcqhkjO
>     +PQIBBgUrgQQACgNCAAQ7zmJdb4eCdSTCWPUOiE1XDQaycYiHWBm73l9/UmJRokiR
>     +g0iRkD6HAg8VUflolxIK/dI8h4NLZVQARI0odkkFo4HIMIHFMAkGA1UdEwQCMAAw
>     +HQYDVR0OBBYEFGT2SYjndMGrpfpPK3E8JRM9yJTFMIGYBgNVHSMEgZAwgY2AFCtA
>     +5cl99fSWOOkv4y/ZQGTJjgWboWqkaDBmMQswCQYDVQQGEwJLRzELMAkGA1UECBMC
>     +TkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4tVEVTVDEhMB8G
>     +CSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluggkAoU7e+pDyroEwDQYJKoZI
>     +hvcNAQELBQADggIBADI98Ahn3QNzdsx2Ugr2l9HG+l/T5ijJdacIqDRJac/rq9qG
>     +sy5lF+5+trVrFQvcETq5WrOAuLv0bM+IOhCDfhCggoduBux4YtTRRCfdLBnYGqGu
>     +9KAAf1NaQIrCg3dLJn1TsNMPL3wocO90WFvegZRMYxnwectssuwyG0vkYiJPraxK
>     +b6luxCqNiogZCf2IkzwnTZGV/1eEE/1KaNsg3xDmgR395x01+xkC3bVfoMEH7HS0
>     +74v5M5rypjtutkpSq12ZdmRixNU6xoGN68hLAq/hymDpjcepK+pPVjHTmhHCnINc
>     +oo2Y/sylrR9RxG7P/6BRZMh/fzIFTI1/v7jt5YFfgb0dmz+KgycmtGmEi+XZ6v0I
>     +qKrkOtwpTYBsE/dFzpLyqfNfkIPWIw9Q5UAJTGvyc6rYSaepgW678uSlfxk5HWXz
>     +EZexK3wvNnd/df2IRJB88jONzSz2dmAz0/SzjIHXhYnM19UslKkxP9Njp9yCPwrY
>     +xXGXaTvBacvwG74VwL6q/egTLAw/cnt9nDt/uII2S61NFhm5HLMt11+L+BTO1BPl
>     +gnodQCgIZUoZ13o1Cds2SEuWRL0fErI5CB5bZiWb4BbTeQXj9pDalZUzoVOoPKnw
>     +svXQqoCglsqMRWLCdASRaCf76Ze+OoeKhSgtbqlgm2O6ZZheuwLurLq+9kIm
>     +-----END CERTIFICATE-----
>     diff --git a/sample/sample-keys/client-ec.key
b/sample/sample-keys/client-ec.key
>     new file mode 100644
>     index 0000000..8131380
>     --- /dev/null
>     +++ b/sample/sample-keys/client-ec.key
>     @@ -0,0 +1,5 @@
>     +-----BEGIN PRIVATE KEY-----
>     +MIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQg2RVk/d0yok086M9bLPIi
>     +eu4DfcBUwphOnkje1/7VSY+hRANCAAQ7zmJdb4eCdSTCWPUOiE1XDQaycYiHWBm7
>     +3l9/UmJRokiRg0iRkD6HAg8VUflolxIK/dI8h4NLZVQARI0odkkF
>     +-----END PRIVATE KEY-----
>     diff --git a/sample/sample-keys/client-pass.key
b/sample/sample-keys/client-pass.key
>     new file mode 100644
>     index 0000000..2bb8d4e
>     --- /dev/null
>     +++ b/sample/sample-keys/client-pass.key
>     @@ -0,0 +1,30 @@
>     +-----BEGIN RSA PRIVATE KEY-----
>     +Proc-Type: 4,ENCRYPTED
>     +DEK-Info: AES-256-CBC,ECC1F209896FC2621233FFF6F1FFD045
>     +
>     +i6t7VKTyNNELTvrBO464e02nFg9rvYwumxd0sfqcPtaKmRK2mrZmEd/Xh0Nv1WyB
>     +PyuJo78qQixAtxObRbkSNINzTr5C8IDrE6+wQYCJinvO54U0o+ksv0tsyLngz1cb
>     +is8ZqHXrRgJ3qGFQWmFRtFKFQvSXOTDX3fLkEB53HfeblQCxBCnJ82Sp7ivnVR/j
>     +Q8qQRy1RMbzIN0trEGf0Zi4tHEvXL1u7Y+olQzSlmWWaQt20hhXUOMLhMtlRsAo7
>     +AwjlE94JjAfJ1q1dwIcRN4c9Lk8GkiX6w7nDpRACDpk2S8ifCqi69eGe4+g7owhL
>     +74bgs64PmM9a2sNXy1v6WE3c/t6sSrZiMvrGsqMo4sBlrQ9WXe0Naon7heBkPcdS
>     +px0YJjnyBXHMIH+ASmALSJ5JXq9vt2xRFf0dOsGapxhP+7bZJ5Pwyk/yUu5uHFbM
>     +/aBemlrZJzlKeYiiwpwx2whQAtDwN41zMG+r27EzSU/AaDV40NPiwwycpWt/Bp1e
>     +z1ag0JuS0an+PK4jmREtzT5U5BeAVM91x8YttOPpmUIpahAa1zwdYPRAIkbmPJ4z
>     +ZH+9YoPH4hoBQKdIhshYktjdI++xNiKXAUGUz5YoX8S68SsLdmKvhnQ7fu5VvOkA
>     +2pb7taXGy7zfn+a/fWauhuceV9HPlAXMIu3GsssODoNly3vpcFeiMySKppygJ3Eg
>     +A3o9n8UepD+jXflKG/R/t7U3hT6LqSIvQWqBqYMEVFMCNzSsJ/ce/4veFvx343zT
>     +qdxuzYqyiXM74cynpfqHdVa9SFICTesNdVDI0FdOXhSQ4bHJc7Xp9FFJdS0lMRw4
>     +ACwKxvs8lo4Gx1WFyCqH5OxosKtDHQYzdUJfSWVJlhhOFR3GncR9qSe3O5fkhJfs
>     +TALnC+xTJyCkSB2k0/bxVLIhlkPdCwzsrN/B6X2CDBdg0mQIo0LaPzGF8VneM20d
>     +XebYn751XSiL3HKyq8G5AEFwj9AO3Q8gKuP2fPoWdngJ2GT+mt1m2fIw9Igu39J0
>     +ZMegyUN0wSIiA5AkgryK9U+PJEiJmLzOJ/NGr7E5tPF18eZWapK4KZ8TXC4RNiye
>     +g+apGa+xZJz2VQp/Mrcdj9D4UDJFQjrvKaS0PXJDoYUXFBoMv3rxijzRVxlhhuJY
>     +yZ0At+UqZD5wpuWW6DRrgJIpy0HNhbaLmgsU0Co0HKviB0x8hvMJbi/uCoPTOdPz
>     +sPB7CN2i3oXe7xw1HfSTSFWb4leqjlKwNgfV42ox0QUjkkADeeuY+56g/B2+QmdE
>     +vXrc6sDwfNUwRUzeMn8yfum/aW1y/wrqF/qPTBQqFd85vlzS+NfXIKDg04cAljTu
>     ++2BLzvizh9Bb68iG4PykNXbjbAir1EbQG1tCzq1eKhERjgrxdv6+XqAmvchMCeL5
>     +L6hvfQFBPCo/4xnMpU5wooFarO/kGdKlGr5rXOydgfL618Td18BIX+FHQFb3zzVU
>     +y2NR4++DslJAZgAU+512zzpW1m3JtaRoyqyoLE2YFPlW804Xc1PBB3Ix6Wyzcegy
>     +D4qMk5qxjBkXEsBBSCYfVbWoMBeMhnvxkz0b9wkPtAW/jEJCB2Kkn/5yMC0DkePO
>     +-----END RSA PRIVATE KEY-----
>     diff --git a/sample/sample-keys/client.crt
b/sample/sample-keys/client.crt
>     index c047446..1744cb2 100644
>     --- a/sample/sample-keys/client.crt
>     +++ b/sample/sample-keys/client.crt
>     @@ -2,64 +2,102 @@ Certificate:
>          Data:
>              Version: 3 (0x2)
>              Serial Number: 2 (0x2)
>     -        Signature Algorithm: md5WithRSAEncryption
>     +    Signature Algorithm: sha256WithRSAEncryption
>              Issuer: C=KG, ST=NA, L=BISHKEK,
O=OpenVPN-TEST/emailAddress=me@...430...
>              Validity
>     -            Not Before: Nov 25 14:46:49 2004 GMT
>     -            Not After : Nov 23 14:46:49 2014 GMT
>     +            Not Before: Oct 22 21:59:53 2014 GMT
>     +            Not After : Oct 19 21:59:53 2024 GMT
>              Subject: C=KG, ST=NA, O=OpenVPN-TEST,
CN=Test-Client/emailAddress=me@...430...
>              Subject Public Key Info:
>                  Public Key Algorithm: rsaEncryption
>     -            RSA Public Key: (1024 bit)
>     -                Modulus (1024 bit):
>     -                    00:d2:12:5c:c6:4d:13:34:ae:cf:fa:ab:fe:cb:de:
>     -                    8c:f1:4b:4a:95:28:60:87:82:2c:b8:c1:e5:8e:c6:
>     -                    5d:11:58:61:a4:a5:f1:42:d7:86:74:6c:9d:9c:7a:
>     -                    f0:3a:5c:29:e6:53:3b:5e:6d:d8:f0:45:06:2c:23:
>     -                    ee:09:bc:02:8f:0e:b8:d5:33:1f:c3:4a:11:02:48:
>     -                    0b:cc:4b:ad:6e:74:e0:a2:53:b1:d6:cc:89:b9:e2:
>     -                    6f:db:15:b3:19:1e:57:04:79:48:3a:da:76:31:fc:
>     -                    bf:d3:34:21:e7:32:d8:9e:06:4e:be:f3:e3:79:b0:
>     -                    54:fd:d1:42:32:aa:3e:7a:c1
>     +                Public-Key: (2048 bit)
>     +                Modulus:
>     +                    00:ec:65:8f:e9:12:c2:1a:5b:e6:56:2a:08:a9:82:
>     +                    3a:2d:44:78:a3:00:3b:b0:9f:e7:27:10:40:93:ef:
>     +                    f1:cc:3e:a0:aa:04:a2:80:1b:13:a9:e6:fe:81:d6:
>     +                    70:90:a8:d8:d4:de:30:d8:35:00:d2:be:62:f0:48:
>     +                    da:fc:15:8d:c4:c6:6d:0b:99:f1:2b:83:00:0a:d3:
>     +                    2a:23:0b:e5:cd:f9:35:df:43:61:15:72:ad:95:98:
>     +                    f6:73:21:41:5e:a0:dd:47:27:a0:d5:9a:d4:41:a8:
>     +                    1c:1d:57:20:71:17:8f:f7:28:9e:3e:07:ce:ec:d5:
>     +                    0e:42:4f:1e:74:47:8e:47:9d:d2:14:28:27:2c:14:
>     +                    10:f5:d1:96:b5:93:74:84:ef:f9:04:de:8d:4a:6f:
>     +                    df:77:ab:ea:d1:58:d3:44:fe:5a:04:01:ff:06:7a:
>     +                    97:f7:fd:e3:57:48:e1:f0:df:40:13:9f:66:23:5a:
>     +                    e3:55:54:3d:54:39:ee:00:f9:12:f1:d2:df:74:2e:
>     +                    ba:d7:f0:8d:c6:dd:18:58:1c:93:22:0b:75:fa:a8:
>     +                    d6:e0:b5:2f:2d:b9:d4:fe:b9:4f:86:e2:75:48:16:
>     +                    60:fb:3f:c9:b4:30:42:29:fb:3b:b3:2b:b9:59:81:
>     +                    6a:46:f3:45:83:bf:fd:d5:1a:ff:37:0c:6f:5b:fd:
>     +                    61:f1
>                      Exponent: 65537 (0x10001)
>              X509v3 extensions:
>                  X509v3 Basic Constraints:
>                      CA:FALSE
>     -            Netscape Comment:
>     -                OpenSSL Generated Certificate
>                  X509v3 Subject Key Identifier:
>     -               
17:B7:3F:C7:62:A0:A9:FD:A4:31:0E:58:D7:D9:94:7B:4B:3F:CB:56
>     +               
D2:B4:36:0F:B1:FC:DD:A5:EA:2A:F7:C7:23:89:FA:E3:FA:7A:44:1D
>                  X509v3 Authority Key Identifier:
>     -               
keyid:89:A6:60:E3:BA:EA:3E:AF:FC:64:7F:4C:BD:8C:D2:48:8D:E0:CC:46
>     +               
keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
>                     
DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
>     -                serial:00
>     +                serial:A1:4E:DE:FA:90:F2:AE:81
>
>     -    Signature Algorithm: md5WithRSAEncryption
>     -        61:c6:d1:fa:24:0f:c7:be:09:3b:d8:04:17:63:31:17:07:f9:
>     -        56:99:af:4c:67:fa:db:cb:94:cf:55:a5:7b:16:20:8b:42:64:
>     -        13:23:62:45:28:93:5e:36:f7:db:02:95:a1:e9:fd:e3:0f:8d:
>     -        73:a1:7b:0e:55:78:4d:a5:c4:b7:22:12:a0:ee:55:e0:b8:0e:
>     -        c9:9b:12:e3:b0:ef:9b:68:93:57:6e:6c:ad:16:68:8e:8d:30:
>     -        33:fe:2a:1b:c3:03:8f:b6:0a:2d:0c:b1:3c:bb:f9:58:3f:8c:
>     -        81:59:6b:14:dd:62:b5:c2:93:ed:5d:c6:19:0f:9b:4b:52:b3:
>     -        7c:78
>     +    Signature Algorithm: sha256WithRSAEncryption
>     +         7f:e0:fe:84:a7:ec:df:62:a5:cd:3c:c1:e6:42:b1:31:12:f0:
>     +         b9:da:a7:9e:3f:bd:96:52:b6:fc:55:74:64:3e:e4:ff:7e:aa:
>     +         f7:3e:06:18:5f:73:85:f8:c8:e0:67:1b:4d:97:ca:05:d0:37:
>     +         07:33:64:9b:e6:78:77:14:9a:55:bb:2a:ac:c3:7f:c9:15:08:
>     +         83:5c:c8:c2:61:d3:71:4c:05:0b:2b:cb:a3:87:6d:a0:32:ed:
>     +         b0:b3:27:97:4a:55:8d:01:2a:30:56:68:ab:f2:da:5c:10:73:
>     +         c9:aa:0a:9c:4b:4c:a0:5b:51:6e:0a:7e:6c:53:80:b0:00:e1:
>     +         1e:9a:4c:0a:37:9e:20:89:bc:c5:e5:79:58:b7:45:ff:d3:c4:
>     +         a1:fd:d9:78:3d:45:16:74:df:82:44:1d:1d:81:50:5a:b9:32:
>     +         4c:e2:4f:3f:0e:3a:65:5a:64:83:3b:29:31:c4:99:88:bc:c5:
>     +         84:39:f2:19:12:e1:66:d0:ea:fb:75:b1:d2:27:be:91:59:a3:
>     +         2b:09:d5:5c:bf:46:8e:d6:67:d6:0b:ec:da:ab:f0:80:19:87:
>     +         64:07:a9:77:b1:5e:0c:e2:c5:1d:6a:ac:5d:23:f3:30:75:36:
>     +         4e:ca:c3:4e:b0:4d:8c:2c:ce:52:61:63:de:d5:f5:ef:ef:0a:
>     +         6b:23:25:26:3c:3a:f2:c3:c2:16:19:3f:a9:32:ba:68:f9:c9:
>     +         12:3c:3e:c6:1f:ff:9b:4e:f4:90:b0:63:f5:d1:33:00:30:5a:
>     +         e8:24:fa:35:44:9b:6a:80:f3:a6:cc:7b:3c:73:5f:50:c4:30:
>     +         71:d8:74:90:27:0a:01:4e:a5:5e:b1:f8:da:c2:61:81:11:ae:
>     +         29:a3:8f:fa:7e:4c:4e:62:b1:00:de:92:e3:8f:6a:2e:da:d9:
>     +         38:5d:6b:7c:0d:e4:01:aa:c8:c6:6d:8b:cd:c0:c8:6e:e4:57:
>     +         21:8a:f6:46:30:d9:ad:51:a1:87:96:a6:53:c9:1e:c6:bb:c3:
>     +         eb:55:fe:8c:d6:5c:d5:c6:f3:ca:b0:60:d2:d4:2a:1f:88:94:
>     +         d3:4c:1a:da:0c:94:fe:c1:5d:0d:2a:db:99:29:5d:f6:dd:16:
>     +         c4:c8:4d:74:9e:80:d9:d0:aa:ed:7b:e3:30:e4:47:d8:f5:15:
>     +         c1:71:b8:c6:fd:ee:fc:9e:b2:5f:b5:b7:92:ed:ff:ca:37:f6:
>     +         c7:82:b4:54:13:9b:83:cd:87:8b:7e:64:f6:2e:54:3a:22:b1:
>     +         c5:c1:f4:a5:25:53:9a:4d:a8:0f:e7:35:4b:89:df:19:83:66:
>     +         64:d9:db:d1:61:2b:24:1b:1d:44:44:fb:49:30:87:b7:49:23:
>     +         08:02:8a:e0:25:f3:f4:43
>      -----BEGIN CERTIFICATE-----
>     -MIIDNTCCAp6gAwIBAgIBAjANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL
>     +MIIFFDCCAvygAwIBAgIBAjANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL
>      MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
>     -VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy
>     -NTE0NDY0OVoXDTE0MTEyMzE0NDY0OVowajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
>     +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy
>     +MjIxNTk1M1oXDTI0MTAxOTIxNTk1M1owajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
>      Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFDASBgNVBAMTC1Rlc3QtQ2xpZW50
>     -MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wgZ8wDQYJKoZIhvcN
>     -AQEBBQADgY0AMIGJAoGBANISXMZNEzSuz/qr/svejPFLSpUoYIeCLLjB5Y7GXRFY
>     -YaSl8ULXhnRsnZx68DpcKeZTO15t2PBFBiwj7gm8Ao8OuNUzH8NKEQJIC8xLrW50
>     -4KJTsdbMibnib9sVsxkeVwR5SDradjH8v9M0Iecy2J4GTr7z43mwVP3RQjKqPnrB
>     -AgMBAAGjge4wgeswCQYDVR0TBAIwADAsBglghkgBhvhCAQ0EHxYdT3BlblNTTCBH
>     -ZW5lcmF0ZWQgQ2VydGlmaWNhdGUwHQYDVR0OBBYEFBe3P8dioKn9pDEOWNfZlHtL
>     -P8tWMIGQBgNVHSMEgYgwgYWAFImmYOO66j6v/GR/TL2M0kiN4MxGoWqkaDBmMQsw
>     -CQYDVQQGEwJLRzELMAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNV
>     -BAoTDE9wZW5WUE4tVEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9t
>     -YWluggEAMA0GCSqGSIb3DQEBBAUAA4GBAGHG0fokD8e+CTvYBBdjMRcH+VaZr0xn
>     -+tvLlM9VpXsWIItCZBMjYkUok14299sClaHp/eMPjXOhew5VeE2lxLciEqDuVeC4
>     -DsmbEuOw75tok1dubK0WaI6NMDP+KhvDA4+2Ci0MsTy7+Vg/jIFZaxTdYrXCk+1d
>     -xhkPm0tSs3x4
>     +MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wggEiMA0GCSqGSIb3
>     +DQEBAQUAA4IBDwAwggEKAoIBAQDsZY/pEsIaW+ZWKgipgjotRHijADuwn+cnEECT
>     +7/HMPqCqBKKAGxOp5v6B1nCQqNjU3jDYNQDSvmLwSNr8FY3Exm0LmfErgwAK0yoj
>     +C+XN+TXfQ2EVcq2VmPZzIUFeoN1HJ6DVmtRBqBwdVyBxF4/3KJ4+B87s1Q5CTx50
>     +R45HndIUKCcsFBD10Za1k3SE7/kE3o1Kb993q+rRWNNE/loEAf8Gepf3/eNXSOHw
>     +30ATn2YjWuNVVD1UOe4A+RLx0t90LrrX8I3G3RhYHJMiC3X6qNbgtS8tudT+uU+G
>     +4nVIFmD7P8m0MEIp+zuzK7lZgWpG80WDv/3VGv83DG9b/WHxAgMBAAGjgcgwgcUw
>     +CQYDVR0TBAIwADAdBgNVHQ4EFgQU0rQ2D7H83aXqKvfHI4n64/p6RB0wgZgGA1Ud
>     +IwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRoMGYxCzAJBgNVBAYTAktH
>     +MQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMMT3BlblZQ
>     +Ti1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CCQChTt76
>     +kPKugTANBgkqhkiG9w0BAQsFAAOCAgEAf+D+hKfs32KlzTzB5kKxMRLwudqnnj+9
>     +llK2/FV0ZD7k/36q9z4GGF9zhfjI4GcbTZfKBdA3BzNkm+Z4dxSaVbsqrMN/yRUI
>     +g1zIwmHTcUwFCyvLo4dtoDLtsLMnl0pVjQEqMFZoq/LaXBBzyaoKnEtMoFtRbgp+
>     +bFOAsADhHppMCjeeIIm8xeV5WLdF/9PEof3ZeD1FFnTfgkQdHYFQWrkyTOJPPw46
>     +ZVpkgzspMcSZiLzFhDnyGRLhZtDq+3Wx0ie+kVmjKwnVXL9GjtZn1gvs2qvwgBmH
>     +ZAepd7FeDOLFHWqsXSPzMHU2TsrDTrBNjCzOUmFj3tX17+8KayMlJjw68sPCFhk/
>     +qTK6aPnJEjw+xh//m070kLBj9dEzADBa6CT6NUSbaoDzpsx7PHNfUMQwcdh0kCcK
>     +AU6lXrH42sJhgRGuKaOP+n5MTmKxAN6S449qLtrZOF1rfA3kAarIxm2LzcDIbuRX
>     +IYr2RjDZrVGhh5amU8kexrvD61X+jNZc1cbzyrBg0tQqH4iU00wa2gyU/sFdDSrb
>     +mSld9t0WxMhNdJ6A2dCq7XvjMORH2PUVwXG4xv3u/J6yX7W3ku3/yjf2x4K0VBOb
>     +g82Hi35k9i5UOiKxxcH0pSVTmk2oD+c1S4nfGYNmZNnb0WErJBsdRET7STCHt0kj
>     +CAKK4CXz9EM=
>      -----END CERTIFICATE-----
>     diff --git a/sample/sample-keys/client.key
b/sample/sample-keys/client.key
>     index 17b9509..6d31489 100644
>     --- a/sample/sample-keys/client.key
>     +++ b/sample/sample-keys/client.key
>     @@ -1,15 +1,28 @@
>     ------BEGIN RSA PRIVATE KEY-----
>     -MIICXAIBAAKBgQDSElzGTRM0rs/6q/7L3ozxS0qVKGCHgiy4weWOxl0RWGGkpfFC
>     -14Z0bJ2cevA6XCnmUztebdjwRQYsI+4JvAKPDrjVMx/DShECSAvMS61udOCiU7HW
>     -zIm54m/bFbMZHlcEeUg62nYx/L/TNCHnMtieBk6+8+N5sFT90UIyqj56wQIDAQAB
>     -AoGBAK8RoIGekCfym99DYYfTg9A/t/tQeAnWYaDj7oSrKbqf1lgZ91OGPEZgkoVr
>     -KzLnxf9uU+bhUs8CJx+4HdO8/L9rAJA+oD9QNuMp0elN4AKuEGE1Eq3a0e3cmgPI
>     -+VIoXM6WVAGgK9I03Zu/UerYQ/DdXWGOIsKhFe8qyQoG9pKxAkEA9ld6O9MHQt3d
>     -JAjJkgCNn4psozxjrfLWy2huXd3H3CRqGMjLITDGzdkVSgXjHokBYroi0+TZTu4M
>     -ulJSJaWwBQJBANpO2DAexH2zRHw5Z6QyeEVxz7B3/FzU4GgJx9BH+FSBh+F0G5Ln
>     -ir5Vst8vZ/LGcgpYjHQLNAvZVgUjiQ4Y6I0CQGvwMJL+CHR4GmmroAblTyjU0n1D
>     -/Lk/anZ+L73Za7U+D28ErFzCrpmLwRRKOBYtGfpUbOZDpCQ9kj4hy/TLALECQCcL
>     -9ysUNbzt9Y/qjJkX1d9F7gn4TBEmmkTBixW76bTjvjQbGlt6Qpyso2O8DPGlgPxM
>     -vkJ7RoHgC7y7kGYPGnkCQBVxSNGIjLx4NQBgN4HD0y4+fars1PTUGnckBcS4npb9
>     -onLNyerBlWdBwbARyBS7WPIbyyf5VCrn3yIqWxaARO0=
>     ------END RSA PRIVATE KEY-----
>     +-----BEGIN PRIVATE KEY-----
>     +MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDsZY/pEsIaW+ZW
>     +KgipgjotRHijADuwn+cnEECT7/HMPqCqBKKAGxOp5v6B1nCQqNjU3jDYNQDSvmLw
>     +SNr8FY3Exm0LmfErgwAK0yojC+XN+TXfQ2EVcq2VmPZzIUFeoN1HJ6DVmtRBqBwd
>     +VyBxF4/3KJ4+B87s1Q5CTx50R45HndIUKCcsFBD10Za1k3SE7/kE3o1Kb993q+rR
>     +WNNE/loEAf8Gepf3/eNXSOHw30ATn2YjWuNVVD1UOe4A+RLx0t90LrrX8I3G3RhY
>     +HJMiC3X6qNbgtS8tudT+uU+G4nVIFmD7P8m0MEIp+zuzK7lZgWpG80WDv/3VGv83
>     +DG9b/WHxAgMBAAECggEBAIOdaCpUD02trOh8LqZxowJhBOl7z7/ex0uweMPk67LT
>     +i5AdVHwOlzwZJ8oSIknoOBEMRBWcLQEojt1JMuL2/R95emzjIKshHHzqZKNulFvB
>     +TIUpdnwChTKtH0mqUkLlPU3Ienty4IpNlpmfUKimfbkWHERdBJBHbtDsTABhdo3X
>     +9pCF/yRKqJS2Fy/Mkl3gv1y/NB1OL4Jhl7vQbf+kmgfQN2qdOVe2BOKQ8NlPUDmE
>     +/1XNIDaE3s6uvUaoFfwowzsCCwN2/8QrRMMKkjvV+lEVtNmQdYxj5Xj5IwS0vkK0
>     +6icsngW87cpZxxc1zsRWcSTloy5ohub4FgKhlolmigECgYEA+cBlxzLvaMzMlBQY
>     +kCac9KQMvVL+DIFHlZA5i5L/9pRVp4JJwj3GUoehFJoFhsxnKr8HZyLwBKlCmUVm
>     +VxnshRWiAU18emUmeAtSGawlAS3QXhikVZDdd/L20YusLT+DXV81wlKR97/r9+17
>     +klQOLkSdPm9wcMDOWMNHX8bUg8kCgYEA8k+hQv6+TR/+Beao2IIctFtw/EauaJiJ
>     +wW5ql1cpCLPMAOQUvjs0Km3zqctfBF8mUjdkcyJ4uhL9FZtfywY22EtRIXOJ/8VR
>     +we65mVo6RLR8YVM54sihanuFOnlyF9LIBWB+9pUfh1/Y7DSebh7W73uxhAxQhi3Y
>     +QwfIQIFd8OkCgYBalH4VXhLYhpaYCiXSej6ot6rrK2N6c5Tb2MAWMA1nh+r84tMP
>     +gMoh+pDgYPAqMI4mQbxUmqZEeoLuBe6VHpDav7rPECRaW781AJ4ZM4cEQ3Jz/inz
>     +4qOAMn10CF081/Ez9ykPPlU0bsYNWHNd4eB2xWnmUBKOwk7UgJatVPaUiQKBgQCI
>     +f18CVGpzG9CHFnaK8FCnMNOm6VIaTcNcGY0mD81nv5Dt943P054BQMsAHTY7SjZW
>     +HioRyZtkhonXAB2oSqnekh7zzxgv4sG5k3ct8evdBCcE1FNJc2eqikZ0uDETRoOy
>     +s7cRxNNr+QxDkyikM+80HOPU1PMPgwfOSrX90GJQ8QKBgEBKohGMV/sNa4t14Iau
>     +qO8aagoqh/68K9GFXljsl3/iCSa964HIEREtW09Qz1w3dotEgp2w8bsDa+OwWrLy
>     +0SY7T5jRViM3cDWRlUBLrGGiL0FiwsfqiRiji60y19erJgrgyGVIb1kIgIBRkgFM
>     +2MMweASzTmZcri4PA/5C0HYb
>     +-----END PRIVATE KEY-----
>     diff --git a/sample/sample-keys/client.p12
b/sample/sample-keys/client.p12
>     new file mode 100644
>     index
0000000000000000000000000000000000000000..8458c79770a08e832e10205ae1c43e8059cca082
>     GIT binary patch
>     literal 4533
>     zcmV;m5lZebf)TL-0Ru3C5qAa&Duzgg_YDCD0ic2rXas^0WH5peU@(FV7X}F`hDe6@
>     z4FLxRpn?ntFoFyO0s#Opf(!iy2`Yw2hW8Bt2LUh~1_~;MNQU<f0So~KFb)I=o?0Gd
>     zI2*;=0s;sCfPxFqP42^P0Fo+4$NqJRddSJSl#H$YLRhM0*>KZ1!3FrYzVTx;+~<9X
>     zHC&0kC=Q)Zxu{oL`xLM;b_oD>(X&8Ta-#O3&p;;Aa3+^0d5fSLOs3>{(_@...1940...
>     z2?mB_IU!{$1Sf&CfNA0|znHybfRqP5blsg?Z{1w#hHzm2WPm@...1941...>~Fs9L`8P!8d0*
>     zf18!wochm&3uJ;eC{gw3d+=?v`?TP`azbPA8uS#SvF>zu7QrQ#$t<4KatJksK>dI*
>     ziMISYR+%EK<vdQWAH_>GJw7P#F#ep~$fBbb6Y*_W)JH+UB%-XoF0lb%KM36b^Ml3z
>     zdI#>W)o{)xhylZ4OHKChQ3@...1942...{v(AQB@...1943...?ARCe`Ss=S%-q5T5+I3#R#G1YJlYRV
>     zDTZ`@`U38{@bSL;>xUioK!F94XIBfJNFiIhM&9nvb{1l0O6GqR&cLY4NFEuZS(DxH
>     z=W!uJ(?gK8gs^*{5_cl5Z(=wW&Q)XqS-~>m0O$kp(m_Cz>zwzHL-IYyDH=}xGVl+4
>     zq3STnMt<?Hu(MKc@...150...}O=+SOgwb9ciM@...1944...>7Am$3#DF7{7%Lk3imYa+y7?D;AsNHiG
>     zn<Pk<=8L8O8bLSWTRMYjAr147E?9!=!8xCjW&Rt}P1G4yKA2el8%Z#!i?O-I%bY3u
>     ze}EeqFzNG`%%2`feCA2|669L4WH3axOzLsnR{2`^v?3Sf>YdO(f@...1615...<&g*jh|95N+F
>     zs_~5PPb?@91h)&uXAR5t`>ZG>Uz4i)rF)c|;osz49745f=)!}UDtm5M!ZPf8NHf-q
>     zBu9VT(aN+vpUdkJ*gO8FPMV2QD1&zIpdi0sGch)W2;I$z%}w_LA6?gziR|D2-^A$7
>     zK+7hz{knM@...1945...{VXU4Jr29-tm$-2M^>mnD_r5Lj>iwRX!<9CFRg
>     z9{(YStoDvOuR@(O4i9CiwMU(U-1=C!cAqZ-t@...1946...)@bc}
>     zgo@...1947...=MyVE1)F@...1948...()zN_MxMHwJS(AR3ip3I+3Rm(|=OM&()I982?Ca-YME*$jcai
>     z5>TYla+%{gDkflN^F;$b#Qn!EsPXE?fs@...1644...=Sd<B``<<chZC5b5VFKbh2K6kY7?K3;
>     zv5_F`(^P~!G1NikPncT9r#;SmMJ@...1949...%Prj#Uc{m7xeQANV0K8+ojXQSMT1t*R&uV`S
>     z-a_ZWh-DQno_e$da>VMjI=w_}8&SK!u012g>$5F;owS>RW$?|5{~rl&$f}d%d>$9i
>     z7(P0*PhMARQef&fdz)sTC<Lxa5`F2&hqQLcJp#ikxf;udtXqUu6cOT-BO(BK`7h=?
>     zDbI?zgxg*~0$om9lkR)a-7%wHj&G~`U*39UJOt~jxs$VpQaqb)Y!11<7NJ;nxwK+f
>     zimu>$;%$WGWRFUiOQ+WO;A%{B*ZINIEs08%b-Fb1;6M5Z<_`ge4ELfx*V8?Qo?OBP
>     zB<m3&JH7$rGqlacJDUb4J^aF+$1F5Fq1BEWLf~B?AU5ccNREIEhWWFpY~t?SmGZi!
>     z+_Bv45Wnp@^L9d#ov%dRyPva3GUZyOBKdi&t0zyQ-jp*M&n!<8>?YAsG0gnH9<Z0S
>     z34D1$5L-hatRI$@6j43xOX~=Ue!pzJ_)e*2;oPP-Jt%B~H*490;ChZmyCq4v3R}?{
>     zc%U{&f8?Nh&k>6b5g@>h2#}&DOvoiL8%)<~q7ehzHh_`~a2Izn=bjHq;TkMIoDt-)
>     z$u8yg;zHv$;?HL0J6h2aH`EK>az+?|SAZS7*?6)?BsZ8yxec)dO^fx~b|xRBKv@!>
>     zN|H@...1594...@OZPg_<ybv-HNQS5$N@=J{hvL<!M_~BR7$uR)1P?SUJk^fttz^d1%ND_VN$$
>     z28yu4B=;NI-W7y*sy2dS6^$EJ{)yWxMf7wfvI_wsZ89XZlK~8n%r4)^eonEw2DGo~
>     zjKS~WOnU}9sPh2P#+I2oX4TWo2NAs$hrb8{T^kZeI@...1611...}Jtc8o?@wh2ORT%pAFfSL4
>     zF1~~3hhzo^be)F{>Xe6%y9Pyj1HI_jCpGGJ+r}qJ(Qm^(w#q#n4;fGT9J)MId6%;&
>     zhPes$n_zQIQ!}^}4G`^Wz7CGC@!ARFDKj^9@...1950...!~Q664CYzu=8Ev-yow*fp9UOsLHG
>     z-BX<D-hZ6KxIA%F5~CWcz|%QmBCt0vMQK#PYY9XsaJ3(}e;=lyMTDz8NEu@...1951...
>     zBTx_4BwT-RH%(I350dV3ea|XNP6YEOFyDzqfWrv_j6~`PF4!_puV5C_RkWVl#=LzN
>     zCn~sV+ht*A?D_2ZTy;=F_fv8<_4f`NjG$iQJ`jYg1O#mw4EYb0Mh#@$sjRlQkKJQo
>     zCbD(tZmv8Qv$&NNhSgU}$`rTnqcvf`wxr^&C&;Fp=5Yh`(eE{7KCj6?xingFo(wqh
>     zsvrza+Q>cmrr~=}pV<`ImbU@...1952...;g_=@a)XeuKL1x92`ruL2r&K(ct*Kk@...1953...
>     zG_=`43h3M^{O*UA{yi2s5fjtWXMOov>#rUwy(A49RjMsrwLLq>wy(A6bJnieJpm*K
>     zLL!(_!FKzh-$!YZdEcBK1F(>@we-M9%w^x#=H#}9Lc8NQ<BjftBjnh4ar}b3i+vXc
>     z{W>X2580FRsm3z}$v|1;BqjKiO00Ft{;FSiOWy|y=&D|>#PfODLKzOym9LWY;M#(=
>     z`T4NzCiGy4Je$gf+HwRg2c<5NBvatkd<oeEbqXy8^TV#bM^e&RCYW(w9gO&yYjX5?
>     z%nQKFIXw{H7UJzU>mb+(-NL)S<-&!Jq+i>}L3McC!=`WXZgNw}W3)t-k4o9(UzHmA
>     zq`4KU&&3!B$jn*}C9IgPAZDOKa4d3Z!m^><O=W&A+i>_uvW(Gg?u{!Zc28~KnlZY|
>     zW><Tb!KwKt8QoTnbcG?7D028`)ggh1eeM8r@...1954...%|k0fBmAmT5c(1mQ9lEXQ5OXd?;
>     z^CHjw%k!RCxFaT~aUa_d{oq#QOssTE3<rMFyeZ`^PjPynYR_KVSN@...1955...#b>Ouf
>     zWGfR@...1956...$;AzQkfiya1EQ_>+Bl-?jKt}^_7hPmkxyS@...1957...~^h=708E3`{=Wth%v-
>     z?@iOBIjVj4-#bcG%9d)#)>ITY*E8dBUmpjRV)C+>Jt32pJ`o-1#>e3Um|*mUJl)zl
>     zzj+A{saen+`EP}bD_BH@...1958...(cb-`Ha9p{rll@#k}4#rAwI;U5&{_(dvPfry4r*OR(g
>     zir1=%D70<3l-Vmdno7L-k9AWle8;LS6163q{gLq<MLcS_5kCD+V@...1959...)Z4K_T+}0D
>     z^did?rKv`zAu@...1960...}c$!y9^Lh|+tz8}+Z%B~F4O}J=a=6}v>ZK?WsvR6Z`rzHr@<!Tg
>     zr!DhMH=-r9Uq71K!AtPC3zo{oX3n#EYevQcL9~(v;6h5Pq%J*^gs-6!fq3Gog$<8b
>     z9g5=S4zlZ?y%K!>Mc&6F6kj#?qqpe;SHD(h=!j(z@^CR=i=KDGw>Bgokqi9zPX(uX
>     z|8`K|fAgElC|rkyhB5@...1961...+@}LZAfPl$+hDkByi%)V5=IaI1H{6vl7?ZBye!AqHLicO
>     zaCsg%BIm|>MA3R@|GjKRc3d&Xa4bb>L3UelPWRoILk&ICGoo4lwV@...1962...{{fLLaZL&+
>     znSPhW04KckjD)a}19>2aT|WH_ltW=y7#46Gu!-xzwtb6TmG$I_MlQkGWG4!7F2!_C
>     z^ngv5DN5VpziF0tnU2m8BpCW*8j$_TsVU%Wf(C_FTqJpP%DVRx*1n=yY6jVZP^~&u
>     zj+O<-)gVFOKz}2cqLfZKD1W%|44A(?o?C-zVkbOT+V1eU!Th4e58g?qy0IDLgSs@(
>     z>a3QZ_~$!6a_yYA03n@...1963...;&JCvDXIMz74j$40}k$6D5*AIe~-NPq>l=p{+`{qB*E
>     z)dA_uyb!%xms+1|*hgXfvXAI&FoFd^1_>&LNQU<f0S5t~f(0@...1964...(0%xf(0rtf(0f9
>     z3o3?4hW8Bt3<?1Ppn?SMFoFc?FdPO7Duzgg_YDCI0Ru1&1PH71K9D&o|1tss2ml0v
>     z1jw3_VuA6wE@...1965...*qp8m7%=>t!ahU6DY<c$m^W{&SL-}Av-!V6Mej({Vh^I65-r7>jl
>     zj#2E$@cqS#ot;itB65=}T$c#Fvn6>(Hu7jv5#?nqND^i{<zGDn+bGDInORh%$|<TU
>     z)0ArgXLA;(_k}K_mlCfE0Y&Ec4gxI|biRQj4^q@...1966...>4Z%>zfnT?a?P>WmWgPqNu
>     zt;=6U3*t>n)oqy#bC<px2zJip8afy*7*z$B{ma3e57nY2u4{E__iFC0=vmJwi1VYX
>     zJ^u9%A=Rjf0y-*9fV{WtT;tb1T0|T~;c%SH5qJ2+_GKkn#{LX}MbS`UJ+#@hq#_P@
>     z=VN$u@...1967...|?(z7UQ*UT5!yd!df-`=;Pg3G;+}!@XBTK@(XtDanPon_36N?ceJ<?w0
>     zNK3soS#I5O8%nUS5XWVt%LptQsfi0a{wtPGi{fq;)jwb;5tx!nQZ5RBwItDChWNTA
>     zj>Fo89J#H&5w(j6)Gb05d4Wuav-;Ae*N4CvCH7Bf7qsT7$-eiNbQFjxma-5lFy&Kf
>     zuGdIbq=SxP#B5y9i$6kWIXa%j=^H(Q8<<q_M*`R%ZVP8(B}EBCF@...1968...?w
>     z@...1969...$yFWg(e-HC0;102vJ;ImFQO7@...1970...<i79$sGU(S!1~*(w+q4OwO-ox
>     zWwM2kH5?dxWXufo3Q9ZIy_U`Ql+5rjkKA=C7U__H<)N5z$Rb{}rn?dsvsv@...1971...=<
>     zU%-OKA3|-2osy2Vwh#)*s+9to<L%b6U5k5Fzx|JW;HHBRq|s|t(&(g4xMFzgvvtbc
>     zQ-TBf=dLqXp>pKX1|T1Ncg_%F+OOU1K%=lJvk25edtPll^?C8iOY4l+gHVw-jwS{5
>     zc1H%A0AcxAK4?I%10%GT9KyndW;=S4Hs$Bt3ppdV?5;*?C+IU>_jrB|%iA@^j-Ydr
>     zP#Vq!z4lf1B59em!RbNV^|P^F7)gXU({v-B^T{ObdazrO(+w5OWS;WuWNRLYYIn{T
>     z*P_`Mm4F+5C)d0&C_P&q3l;Vwjmo9lrsR8}rTM}q1!7wAp-KZ++#udhr|@C8HVGgC
>     z^(J(<tv$K47<r2(#bphive7uMRA&}ky@...1972...~lV4``Zu%!1BUIf_Z=)*`CBf-+5F
>     zTyVg}@k=0bc9s}%M9iRHnOdEO4AU3z0GZg~26X=;y_v(F&Px}&8ufGahoEQe_>Wa-
>     zy{M9YD^`ZYTH01LwfQ?{ZuZQ~vaO&Jq$O&~PN%MO(9m%~EMFTMC(A&MRujojT{YuB
>     z`u5e(@~<aXbTu5Xpgn-u0;$_2;&dZV4?%UszI6qIM+zSz->|Ph<<tw;;-I!bhQUfx
>     z-T|#dTHlxbD@...1554...~1qB#O+9=PN}23-_|*ehcIXa5a)>w_vbRv_LVvmsQhWA5OYqtUvR
>     zb2`hE@>8knqkGmwqPuasz=MUx2NN7PM|$lkN60Vj_=3UYPS<Wb*D(aS{nk}POUoch
>     z5<OVHe&P<YCYq5dQgsKygF+90>r6ZIGje(Qd3rIw(m)l~LebaOD9`;d#2Rt>_%?X|
>     z;FA9GDiVuwAnk9Bh!BAEfMz{Mdq$b`Xzrmam}W60Fe3&DDuzgg_YDCF6)_eB6jtCP
>     zdB1(YHnjhMGVV2R_)j7)j4&}UAutIB1uG5%0vZJX1Qaaz-GykChO4Gdh~Eic3wrIs
>     TMJxme++Sbdrv3y90s;sCVF#Wx
>
>     literal 0
>     HcmV?d00001
>
>     diff --git a/sample/sample-keys/dh1024.pem
b/sample/sample-keys/dh1024.pem
>     deleted file mode 100644
>     index 7ce05f0..0000000
>     --- a/sample/sample-keys/dh1024.pem
>     +++ /dev/null
>     @@ -1,5 +0,0 @@
>     ------BEGIN DH PARAMETERS-----
>     -MIGHAoGBAJ419DBEOgmQTzo5qXl5fQcN9TN455wkOL7052HzxxRVMyhYmwQcgJvh
>     -1sa18fyfR9OiVEMYglOpkqVoGLN7qd5aQNNi5W7/C+VBdHTBJcGZJyyP5B3qcz32
>     -9mLJKudlVudV0Qxk5qUJaPZ/xupz0NyoVpviuiBOI1gNi8ovSXWzAgEC
>     ------END DH PARAMETERS-----
>     diff --git a/sample/sample-keys/dh2048.pem
b/sample/sample-keys/dh2048.pem
>     new file mode 100644
>     index 0000000..8eda59a
>     --- /dev/null
>     +++ b/sample/sample-keys/dh2048.pem
>     @@ -0,0 +1,8 @@
>     +-----BEGIN DH PARAMETERS-----
>     +MIIBCAKCAQEArdnA32xujHPlPI+jPffHSoMUZ+b5gRz1H1Lw9//Gugm5TAsRiYrB
>     +t2BDSsMKvAjyqN+i5SJv4TOk98kRRKB27iPvyXmiL945VaDQl/UehCySjYlGFUjW
>     +9nuo+JwQxeSbw0TLiSYoYJZQ8X1CxPl9mgJl277O4cW1Gc8I/bWa+ipU/4K5wv3h
>     +GI8nt+6A0jN3M/KebotMP101G4k0l0qsY4oRMTmP+z3oAP0qU9NZ1jiuMFVzRlNp
>     +5FdYF7ctrH+tBF+QmyT4SRKSED4wE4oX6gp420NaBhIEQifIj75wlMDtxQlpkN+x
>     +QkjsEbPlaPKHGQ4uupssChVUi8IM2yq5EwIBAg==
>     +-----END DH PARAMETERS-----
>     diff --git a/sample/sample-keys/ec-ca.crt
b/sample/sample-keys/ec-ca.crt
>     deleted file mode 100644
>     index e190801..0000000
>     --- a/sample/sample-keys/ec-ca.crt
>     +++ /dev/null
>     @@ -1,13 +0,0 @@
>     ------BEGIN CERTIFICATE-----
>     -MIIB4jCCAWmgAwIBAgIJALGEGB2g6cAXMAoGCCqGSM49BAMCMBUxEzARBgNVBAMT
>     -CkVDLVRlc3QgQ0EwHhcNMTQwMTE4MTYwMTUzWhcNMjQwMTE2MTYwMTUzWjAVMRMw
>     -EQYDVQQDEwpFQy1UZXN0IENBMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAE2S4AZT7j
>     -ZlPG/CXpT12CzCNSySyKmJt+fWyW/wzbRulVJpGHXRHpZZj2VNOUE72kqGUeshh6
>     -Um1o7lHGDSAkHOJpeW5FtryiKhwFc+4dsOCLTNLVFXQsEtY3gY14Uquio4GEMIGB
>     -MB0GA1UdDgQWBBS0mkFcuCZ8SLWZRAD/8LpBQcgGPDBFBgNVHSMEPjA8gBS0mkFc
>     -uCZ8SLWZRAD/8LpBQcgGPKEZpBcwFTETMBEGA1UEAxMKRUMtVGVzdCBDQYIJALGE
>     -GB2g6cAXMAwGA1UdEwQFMAMBAf8wCwYDVR0PBAQDAgEGMAoGCCqGSM49BAMCA2cA
>     -MGQCMHWlVTi0xNZstR8ZNH+7z0WlyIXyZe23ne3EXkO0thZLdv86kpxFMPW/llB+
>     -RMRKuQIweN97n7FQy5DTenr91U98KDFJ5Av4mDFRL1mkXiu3W1//4XD8yEYDQTRz
>     -/GARuOLL
>     ------END CERTIFICATE-----
>     diff --git a/sample/sample-keys/ec-ca.key
b/sample/sample-keys/ec-ca.key
>     deleted file mode 100644
>     index 51a72e1..0000000
>     --- a/sample/sample-keys/ec-ca.key
>     +++ /dev/null
>     @@ -1,6 +0,0 @@
>     ------BEGIN PRIVATE KEY-----
>     -MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDASU6X/mh2m2PayviL3
>     -teoml5soyIUcZfwZpVn6oNtnrLcAbIRsAJbM4xyGVp77G/6hZANiAATZLgBlPuNm
>     -U8b8JelPXYLMI1LJLIqYm359bJb/DNtG6VUmkYddEellmPZU05QTvaSoZR6yGHpS
>     -bWjuUcYNICQc4ml5bkW2vKIqHAVz7h2w4ItM0tUVdCwS1jeBjXhSq6I=
>     ------END PRIVATE KEY-----
>     diff --git a/sample/sample-keys/ec-client.crt
b/sample/sample-keys/ec-client.crt
>     deleted file mode 100644
>     index b797b02..0000000
>     --- a/sample/sample-keys/ec-client.crt
>     +++ /dev/null
>     @@ -1,61 +0,0 @@
>     -Certificate:
>     -    Data:
>     -        Version: 3 (0x2)
>     -        Serial Number: 2 (0x2)
>     -    Signature Algorithm: ecdsa-with-SHA256
>     -        Issuer: CN=EC-Test CA
>     -        Validity
>     -            Not Before: Jan 18 16:02:37 2014 GMT
>     -            Not After : Jan 16 16:02:37 2024 GMT
>     -        Subject: CN=ec-client
>     -        Subject Public Key Info:
>     -            Public Key Algorithm: id-ecPublicKey
>     -                Public-Key: (384 bit)
>     -                pub:
>     -                    04:40:d9:b9:a2:44:1b:01:39:2c:14:ee:aa:70:6b:
>     -                    31:98:28:44:c9:61:bc:b7:0b:b5:53:49:c2:c0:0a:
>     -                    43:b0:08:50:cd:80:2f:5d:a4:89:f1:ff:7d:11:78:
>     -                    f5:0c:b2:86:e2:59:f8:17:76:1b:22:f2:23:67:e7:
>     -                    55:90:ea:ce:0a:aa:da:05:f4:85:19:c9:ed:ae:6d:
>     -                    a3:ad:56:7a:f6:33:c6:cf:bb:c7:39:fa:e4:d3:67:
>     -                    df:f0:b8:4a:88:57:98
>     -                ASN1 OID: secp384r1
>     -        X509v3 extensions:
>     -            X509v3 Basic Constraints:
>     -                CA:FALSE
>     -            X509v3 Subject Key Identifier:
>     -               
D8:E2:35:7B:CA:66:71:6B:D8:5B:F5:12:13:82:2D:ED:CD:E5:ED:7F
>     -            X509v3 Authority Key Identifier:
>     -               
keyid:B4:9A:41:5C:B8:26:7C:48:B5:99:44:00:FF:F0:BA:41:41:C8:06:3C
>     -                DirName:/CN=EC-Test CA
>     -                serial:B1:84:18:1D:A0:E9:C0:17
>     -
>     -            X509v3 Extended Key Usage:
>     -                TLS Web Client Authentication
>     -            X509v3 Key Usage:
>     -                Digital Signature
>     -            Netscape Comment:
>     -                Easy-RSA Generated Certificate
>     -            Netscape Cert Type:
>     -                SSL Client
>     -    Signature Algorithm: ecdsa-with-SHA256
>     -         30:64:02:30:41:8b:1a:fd:97:a8:bb:7c:d0:eb:1c:a2:ba:c0:
>     -         ac:2f:6d:80:07:5b:5c:ef:55:59:1a:92:56:66:94:ce:49:6a:
>     -         a9:57:49:b2:41:73:64:7e:01:ac:31:3a:7c:2a:bf:a5:02:30:
>     -         2b:c4:a6:b1:0c:03:82:e3:e4:03:39:fb:19:d7:76:21:1b:7e:
>     -         7f:aa:22:5d:90:a4:e1:2e:cd:ca:92:0f:b6:3f:80:dc:26:d2:
>     -         09:34:8c:d1:61:bb:9d:ac:6d:8f:68:f0
>     ------BEGIN CERTIFICATE-----
>     -MIICLTCCAbSgAwIBAgIBAjAKBggqhkjOPQQDAjAVMRMwEQYDVQQDEwpFQy1UZXN0
>     -IENBMB4XDTE0MDExODE2MDIzN1oXDTI0MDExNjE2MDIzN1owFDESMBAGA1UEAxMJ
>     -ZWMtY2xpZW50MHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEQNm5okQbATksFO6qcGsx
>     -mChEyWG8twu1U0nCwApDsAhQzYAvXaSJ8f99EXj1DLKG4ln4F3YbIvIjZ+dVkOrO
>     -CqraBfSFGcntrm2jrVZ69jPGz7vHOfrk02ff8LhKiFeYo4HYMIHVMAkGA1UdEwQC
>     -MAAwHQYDVR0OBBYEFNjiNXvKZnFr2Fv1EhOCLe3N5e1/MEUGA1UdIwQ+MDyAFLSa
>     -QVy4JnxItZlEAP/wukFByAY8oRmkFzAVMRMwEQYDVQQDEwpFQy1UZXN0IENBggkA
>     -sYQYHaDpwBcwEwYDVR0lBAwwCgYIKwYBBQUHAwIwCwYDVR0PBAQDAgeAMC0GCWCG
>     -SAGG+EIBDQQgFh5FYXN5LVJTQSBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwEQYJYIZI
>     -AYb4QgEBBAQDAgeAMAoGCCqGSM49BAMCA2cAMGQCMEGLGv2XqLt80OscorrArC9t
>     -gAdbXO9VWRqSVmaUzklqqVdJskFzZH4BrDE6fCq/pQIwK8SmsQwDguPkAzn7Gdd2
>     -IRt+f6oiXZCk4S7NypIPtj+A3CbSCTSM0WG7naxtj2jw
>     ------END CERTIFICATE-----
>     diff --git a/sample/sample-keys/ec-client.key
b/sample/sample-keys/ec-client.key
>     deleted file mode 100644
>     index 60636ed..0000000
>     --- a/sample/sample-keys/ec-client.key
>     +++ /dev/null
>     @@ -1,6 +0,0 @@
>     ------BEGIN PRIVATE KEY-----
>     -MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDD9Agj8nr/8sIr0XHky
>     -mcn1oMb3vqOh2axFBaIvmOHYmqs11SIH1tKYelkNYy9zHTChZANiAARA2bmiRBsB
>     -OSwU7qpwazGYKETJYby3C7VTScLACkOwCFDNgC9dpInx/30RePUMsobiWfgXdhsi
>     -8iNn51WQ6s4KqtoF9IUZye2ubaOtVnr2M8bPu8c5+uTTZ9/wuEqIV5g=
>     ------END PRIVATE KEY-----
>     diff --git a/sample/sample-keys/ec-server.crt
b/sample/sample-keys/ec-server.crt
>     deleted file mode 100644
>     index 9999472..0000000
>     --- a/sample/sample-keys/ec-server.crt
>     +++ /dev/null
>     @@ -1,61 +0,0 @@
>     -Certificate:
>     -    Data:
>     -        Version: 3 (0x2)
>     -        Serial Number: 1 (0x1)
>     -    Signature Algorithm: ecdsa-with-SHA256
>     -        Issuer: CN=EC-Test CA
>     -        Validity
>     -            Not Before: Jan 18 16:02:31 2014 GMT
>     -            Not After : Jan 16 16:02:31 2024 GMT
>     -        Subject: CN=ec-server
>     -        Subject Public Key Info:
>     -            Public Key Algorithm: id-ecPublicKey
>     -                Public-Key: (384 bit)
>     -                pub:
>     -                    04:bd:8c:3a:af:2e:2f:2e:de:cf:d2:39:8d:b9:a6:
>     -                    13:96:80:6d:b5:b2:ee:97:62:3b:a2:32:38:77:1e:
>     -                    fb:2a:ef:86:4b:d0:9e:4b:55:e0:9b:07:f9:64:2f:
>     -                    6b:a7:17:fd:65:dd:50:3f:1c:fa:fa:2f:39:2e:97:
>     -                    d4:86:e5:4e:5a:d2:50:0b:f4:d7:08:62:67:53:44:
>     -                    62:e3:25:f2:fa:36:84:87:1d:03:e3:e9:9d:d9:66:
>     -                    51:dd:b4:c4:db:0b:05
>     -                ASN1 OID: secp384r1
>     -        X509v3 extensions:
>     -            X509v3 Basic Constraints:
>     -                CA:FALSE
>     -            X509v3 Subject Key Identifier:
>     -               
EA:DF:7E:A3:D4:61:73:D7:01:AF:6E:0A:38:8D:33:D0:BD:24:4B:E1
>     -            X509v3 Authority Key Identifier:
>     -               
keyid:B4:9A:41:5C:B8:26:7C:48:B5:99:44:00:FF:F0:BA:41:41:C8:06:3C
>     -                DirName:/CN=EC-Test CA
>     -                serial:B1:84:18:1D:A0:E9:C0:17
>     -
>     -            X509v3 Extended Key Usage:
>     -                TLS Web Server Authentication
>     -            X509v3 Key Usage:
>     -                Digital Signature, Key Encipherment
>     -            Netscape Comment:
>     -                Easy-RSA Generated Certificate
>     -            Netscape Cert Type:
>     -                SSL Server
>     -    Signature Algorithm: ecdsa-with-SHA256
>     -         30:64:02:30:20:39:12:92:cc:a2:ca:45:b9:1a:8f:e0:c1:e7:
>     -         b7:4a:79:4d:07:07:81:72:08:b4:d4:7b:46:53:d7:72:32:d0:
>     -         d7:3e:e8:88:2b:c9:ba:8b:d5:94:4f:41:6c:d0:2e:a4:02:30:
>     -         75:ff:c3:8a:c1:f5:79:1c:1a:08:16:31:c2:c1:6e:d4:33:dc:
>     -         9f:04:0f:90:94:d9:75:c1:6d:71:28:62:cc:f6:89:7c:91:86:
>     -         a4:96:45:34:a0:8d:92:7e:dd:e3:da:4d
>     ------BEGIN CERTIFICATE-----
>     -MIICLTCCAbSgAwIBAgIBATAKBggqhkjOPQQDAjAVMRMwEQYDVQQDEwpFQy1UZXN0
>     -IENBMB4XDTE0MDExODE2MDIzMVoXDTI0MDExNjE2MDIzMVowFDESMBAGA1UEAxMJ
>     -ZWMtc2VydmVyMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEvYw6ry4vLt7P0jmNuaYT
>     -loBttbLul2I7ojI4dx77Ku+GS9CeS1Xgmwf5ZC9rpxf9Zd1QPxz6+i85LpfUhuVO
>     -WtJQC/TXCGJnU0Ri4yXy+jaEhx0D4+md2WZR3bTE2wsFo4HYMIHVMAkGA1UdEwQC
>     -MAAwHQYDVR0OBBYEFOrffqPUYXPXAa9uCjiNM9C9JEvhMEUGA1UdIwQ+MDyAFLSa
>     -QVy4JnxItZlEAP/wukFByAY8oRmkFzAVMRMwEQYDVQQDEwpFQy1UZXN0IENBggkA
>     -sYQYHaDpwBcwEwYDVR0lBAwwCgYIKwYBBQUHAwEwCwYDVR0PBAQDAgWgMC0GCWCG
>     -SAGG+EIBDQQgFh5FYXN5LVJTQSBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwEQYJYIZI
>     -AYb4QgEBBAQDAgZAMAoGCCqGSM49BAMCA2cAMGQCMCA5EpLMospFuRqP4MHnt0p5
>     -TQcHgXIItNR7RlPXcjLQ1z7oiCvJuovVlE9BbNAupAIwdf/DisH1eRwaCBYxwsFu
>     -1DPcnwQPkJTZdcFtcShizPaJfJGGpJZFNKCNkn7d49pN
>     ------END CERTIFICATE-----
>     diff --git a/sample/sample-keys/ec-server.key
b/sample/sample-keys/ec-server.key
>     deleted file mode 100644
>     index bb3cdf1..0000000
>     --- a/sample/sample-keys/ec-server.key
>     +++ /dev/null
>     @@ -1,6 +0,0 @@
>     ------BEGIN PRIVATE KEY-----
>     -MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDD8bQlwrFrXHPmem0bt
>     -cBcU6nYfaZQbPdIDAB7edOOyevvzYH0qMtbaW95iSZLMRVWhZANiAAS9jDqvLi8u
>     -3s/SOY25phOWgG21su6XYjuiMjh3Hvsq74ZL0J5LVeCbB/lkL2unF/1l3VA/HPr6
>     -Lzkul9SG5U5a0lAL9NcIYmdTRGLjJfL6NoSHHQPj6Z3ZZlHdtMTbCwU=
>     ------END PRIVATE KEY-----
>     diff --git a/sample/sample-keys/gen-sample-keys.sh
b/sample/sample-keys/gen-sample-keys.sh
>     new file mode 100755
>     index 0000000..87bde1d
>     --- /dev/null
>     +++ b/sample/sample-keys/gen-sample-keys.sh
>     @@ -0,0 +1,74 @@
>     +#!/bin/sh
>     +#
>     +# Run this script to set up a test CA, and test key-certificate
pair for a
>     +# server, and various clients.
>     +#
>     +# Copyright (C) 2014 Steffan Karger <steffan@...1856...
<mailto:steffan@...1856...>>
>     +set -eu
>     +
>     +if [ ! -f openssl.cnf ]
>     +then
>     +    echo "Please run this script from the sample directory"
>     +    exit 1
>     +fi
>     +
>     +# Create required directories and files
>     +mkdir -p sample-ca
>     +rm -f sample-ca/index.txt
>     +touch sample-ca/index.txt
>     +echo "01" > sample-ca/serial
>     +
>     +# Generate CA key and cert
>     +openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 \
>     +    -extensions easyrsa_ca -keyout sample-ca/ca.key -out
sample-ca/ca.crt \
>     +    -subj
"/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430..." \
>     +    -config openssl.cnf
>     +
>     +# Create server key and cert
>     +openssl req -new -nodes -config openssl.cnf -extensions server \
>     +    -keyout sample-ca/server.key -out sample-ca/server.csr \
>     +    -subj
"/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Server/emailAddress=me@...430..."
>     +openssl ca -batch -config openssl.cnf -extensions server \
>     +    -out sample-ca/server.crt -in sample-ca/server.csr
>     +
>     +# Create client key and cert
>     +openssl req -new -nodes -config openssl.cnf \
>     +    -keyout sample-ca/client.key -out sample-ca/client.csr \
>     +    -subj
"/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Client/emailAddress=me@...430..."
>     +openssl ca -batch -config openssl.cnf \
>     +    -out sample-ca/client.crt -in sample-ca/client.csr
>     +
>     +# Create password protected key file
>     +openssl rsa -aes256 -passout pass:password \
>     +    -in sample-ca/client.key -out sample-ca/client-pass.key
>     +
>     +# Create pkcs#12 client bundle
>     +openssl pkcs12 -export -nodes -password pass:password \
>     +    -out sample-ca/client.p12 -inkey sample-ca/client.key \
>     +    -in sample-ca/client.crt -certfile sample-ca/ca.crt
>     +
>     +
>     +# Create EC server and client cert (signed by 'regular' RSA CA)
>     +openssl ecparam -out sample-ca/secp256k1.pem -name secp256k1
>     +
>     +openssl req -new -newkey ec:sample-ca/secp256k1.pem -nodes
-config openssl.cnf \
>     +    -extensions server \
>     +    -keyout sample-ca/server-ec.key -out sample-ca/server-ec.csr \
>     +    -subj
"/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Server-EC/emailAddress=me@...430..."
>     +openssl ca -batch -config openssl.cnf -extensions server \
>     +    -out sample-ca/server-ec.crt -in sample-ca/server-ec.csr
>     +
>     +openssl req -new -newkey ec:sample-ca/secp256k1.pem -nodes
-config openssl.cnf \
>     +    -keyout sample-ca/client-ec.key -out sample-ca/client-ec.csr \
>     +    -subj
"/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Client-EC/emailAddress=me@...430..."
>     +openssl ca -batch -config openssl.cnf \
>     +    -out sample-ca/client-ec.crt -in sample-ca/client-ec.csr
>     +
>     +# Generate DH parameters
>     +openssl dhparam -out dh2048.pem 2048
>     +
>     +# Copy keys and certs to working directory
>     +cp sample-ca/*.key .
>     +cp sample-ca/*.crt .
>     +cp sample-ca/*.p12 .
>     +
>     diff --git a/sample/sample-keys/openssl.cnf
b/sample/sample-keys/openssl.cnf
>     new file mode 100644
>     index 0000000..aabfd48
>     --- /dev/null
>     +++ b/sample/sample-keys/openssl.cnf
>     @@ -0,0 +1,139 @@
>     +# Heavily borrowed from EasyRSA 3, for use with OpenSSL 1.0.*
>     +
>     +####################################################################
>     +[ ca ]
>     +default_ca     = CA_default            # The default ca section
>     +
>     +####################################################################
>     +[ CA_default ]
>     +
>     +dir            = sample-ca             # Where everything is kept
>     +certs          = $dir                  # Where the issued certs
are kept
>     +crl_dir                = $dir                  # Where the issued
crl are kept
>     +database       = $dir/index.txt        # database index file.
>     +new_certs_dir  = $dir                  # default place for new certs.
>     +
>     +certificate    = $dir/ca.crt           # The CA certificate
>     +serial         = $dir/serial           # The current serial number
>     +crl            = $dir/crl.pem          # The current CRL
>     +private_key    = $dir/ca.key           # The private key
>     +RANDFILE       = $dir/.rand            # private random number file
>     +
>     +x509_extensions        = basic_exts            # The extentions
to add to the cert
>     +
>     +# This allows a V2 CRL. Ancient browsers don't like it, but
anything Easy-RSA
>     +# is designed for will. In return, we get the Issuer attached to
CRLs.
>     +crl_extensions = crl_ext
>     +
>     +default_days   = 3650                  # how long to certify for
>     +default_crl_days= 30                   # how long before next CRL
>     +default_md     = sha256                # use public key default MD
>     +preserve       = no                    # keep passed DN ordering
>     +
>     +# A few difference way of specifying how similar the request
should look
>     +# For type CA, the listed attributes must be the same, and the
optional
>     +# and supplied fields are just that :-)
>     +policy         = policy_anything
>     +
>     +# For the 'anything' policy, which defines allowed DN fields
>     +[ policy_anything ]
>     +countryName            = optional
>     +stateOrProvinceName    = optional
>     +localityName           = optional
>     +organizationName       = optional
>     +organizationalUnitName = optional
>     +commonName             = supplied
>     +name                   = optional
>     +emailAddress           = optional
>     +
>     +####################################################################
>     +# Easy-RSA request handling
>     +# We key off $DN_MODE to determine how to format the DN
>     +[ req ]
>     +default_bits           = 2048
>     +default_keyfile                = privkey.pem
>     +default_md             = sha256
>     +distinguished_name     = cn_only
>     +x509_extensions                = easyrsa_ca    # The extentions
to add to the self signed cert
>     +
>     +# A placeholder to handle the $EXTRA_EXTS feature:
>     +#%EXTRA_EXTS%  # Do NOT remove or change this line as $EXTRA_EXTS
support requires it
>     +
>     +####################################################################
>     +# Easy-RSA DN (Subject) handling
>     +
>     +# Easy-RSA DN for cn_only support:
>     +[ cn_only ]
>     +commonName             = Common Name (eg: your user, host, or
server name)
>     +commonName_max         = 64
>     +commonName_default     = changeme
>     +
>     +# Easy-RSA DN for org support:
>     +[ org ]
>     +countryName                    = Country Name (2 letter code)
>     +countryName_default            = KG
>     +countryName_min                        = 2
>     +countryName_max                        = 2
>     +
>     +stateOrProvinceName            = State or Province Name (full name)
>     +stateOrProvinceName_default    = NA
>     +
>     +localityName                   = Locality Name (eg, city)
>     +localityName_default           = BISHKEK
>     +
>     +0.organizationName             = Organization Name (eg, company)
>     +0.organizationName_default     = OpenVPN-TEST
>     +
>     +organizationalUnitName         = Organizational Unit Name (eg,
section)
>     +organizationalUnitName_default =
>     +
>     +commonName                     = Common Name (eg: your user,
host, or server name)
>     +commonName_max                 = 64
>     +commonName_default             =
>     +
>     +emailAddress                   = Email Address
>     +emailAddress_default           = me@...430...
>     +emailAddress_max               = 64
>     +
>     +####################################################################
>     +
>     +[ basic_exts ]
>     +basicConstraints       = CA:FALSE
>     +subjectKeyIdentifier   = hash
>     +authorityKeyIdentifier = keyid,issuer:always
>     +
>     +# The Easy-RSA CA extensions
>     +[ easyrsa_ca ]
>     +
>     +# PKIX recommendations:
>     +
>     +subjectKeyIdentifier=hash
>     +authorityKeyIdentifier=keyid:always,issuer:always
>     +
>     +# This could be marked critical, but it's nice to support reading
by any
>     +# broken clients who attempt to do so.
>     +basicConstraints = CA:true
>     +
>     +# Limit key usage to CA tasks. If you really want to use the
generated pair as
>     +# a self-signed cert, comment this out.
>     +keyUsage = cRLSign, keyCertSign
>     +
>     +# CRL extensions.
>     +[ crl_ext ]
>     +
>     +# Only issuerAltName and authorityKeyIdentifier make any sense in
a CRL.
>     +
>     +# issuerAltName=issuer:copy
>     +authorityKeyIdentifier=keyid:always,issuer:always
>     +
>     +
>     +# Server extensions.
>     +[ server ]
>     +
>     +basicConstraints       = CA:FALSE
>     +nsCertType             = server
>     +nsComment              = "OpenSSL Generated Server Certificate"
>     +subjectKeyIdentifier   = hash
>     +authorityKeyIdentifier = keyid,issuer:always
>     +extendedKeyUsage       = serverAuth
>     +keyUsage               = digitalSignature, keyEncipherment
>     diff --git a/sample/sample-keys/pass.crt b/sample/sample-keys/pass.crt
>     deleted file mode 100644
>     index 8bb7b17..0000000
>     --- a/sample/sample-keys/pass.crt
>     +++ /dev/null
>     @@ -1,65 +0,0 @@
>     -Certificate:
>     -    Data:
>     -        Version: 3 (0x2)
>     -        Serial Number: 3 (0x3)
>     -        Signature Algorithm: md5WithRSAEncryption
>     -        Issuer: C=KG, ST=NA, L=BISHKEK,
O=OpenVPN-TEST/emailAddress=me@...430...
>     -        Validity
>     -            Not Before: Nov 25 14:48:55 2004 GMT
>     -            Not After : Nov 23 14:48:55 2014 GMT
>     -        Subject: C=KG, ST=NA, O=OpenVPN-TEST,
CN=Test-Client-Password/emailAddress=me@...430...
>     -        Subject Public Key Info:
>     -            Public Key Algorithm: rsaEncryption
>     -            RSA Public Key: (1024 bit)
>     -                Modulus (1024 bit):
>     -                    00:ca:b4:05:67:7b:51:c1:d2:fe:21:57:b1:a5:57:
>     -                    5c:c0:86:38:05:a8:91:cf:e7:a4:bd:7a:76:d8:3b:
>     -                    cf:fe:f3:78:65:24:d6:72:7d:1b:6d:b6:da:04:f2:
>     -                    a8:f6:b4:04:78:d2:24:a7:21:2f:ca:29:46:96:0f:
>     -                    0b:91:31:66:1e:4d:22:9a:5d:05:17:99:9c:a0:7e:
>     -                    e0:2a:be:78:0c:a1:b9:d4:04:c4:ec:f8:61:79:62:
>     -                    b5:52:2d:f5:41:af:db:9f:8c:ab:08:1b:b7:95:b8:
>     -                    c1:f0:29:d3:da:fb:00:3f:8e:5c:27:e3:8d:fa:ee:
>     -                    dc:b4:3b:0b:8b:e0:ab:c1:c1
>     -                Exponent: 65537 (0x10001)
>     -        X509v3 extensions:
>     -            X509v3 Basic Constraints:
>     -                CA:FALSE
>     -            Netscape Comment:
>     -                OpenSSL Generated Certificate
>     -            X509v3 Subject Key Identifier:
>     -               
40:57:F1:8C:9C:86:B2:DA:E0:3F:A7:B8:D7:85:43:45:07:8A:40:73
>     -            X509v3 Authority Key Identifier:
>     -               
keyid:89:A6:60:E3:BA:EA:3E:AF:FC:64:7F:4C:BD:8C:D2:48:8D:E0:CC:46
>     -               
DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
>     -                serial:00
>     -
>     -    Signature Algorithm: md5WithRSAEncryption
>     -        a5:79:72:7f:a2:08:28:8e:66:da:e1:d0:be:bb:97:3d:65:9f:
>     -        ab:1e:19:ac:f1:66:44:14:8f:4e:7c:eb:ea:1e:2f:57:ea:44:
>     -        46:4c:b9:56:5b:c0:0c:58:d2:45:87:26:6d:82:de:8c:64:b8:
>     -        8b:22:61:61:c6:68:36:08:9d:5a:fd:2f:e5:21:e1:a2:0c:7f:
>     -        3e:ca:e1:06:ea:9f:81:62:3d:a0:ce:f1:1e:0d:ab:86:89:ed:
>     -        9a:89:34:32:c9:e9:6d:7d:f5:11:c3:5d:7e:a5:f7:f1:a6:83:
>     -        77:1b:94:67:d9:0f:5c:ac:0e:08:4a:88:98:65:49:eb:66:9e:
>     -        2d:28
>     ------BEGIN CERTIFICATE-----
>     -MIIDPjCCAqegAwIBAgIBAzANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL
>     -MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
>     -VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy
>     -NTE0NDg1NVoXDTE0MTEyMzE0NDg1NVowczELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
>     -Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxHTAbBgNVBAMTFFRlc3QtQ2xpZW50
>     -LVBhc3N3b3JkMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wgZ8w
>     -DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMq0BWd7UcHS/iFXsaVXXMCGOAWokc/n
>     -pL16dtg7z/7zeGUk1nJ9G2222gTyqPa0BHjSJKchL8opRpYPC5ExZh5NIppdBReZ
>     -nKB+4Cq+eAyhudQExOz4YXlitVIt9UGv25+Mqwgbt5W4wfAp09r7AD+OXCfjjfru
>     -3LQ7C4vgq8HBAgMBAAGjge4wgeswCQYDVR0TBAIwADAsBglghkgBhvhCAQ0EHxYd
>     -T3BlblNTTCBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwHQYDVR0OBBYEFEBX8YychrLa
>     -4D+nuNeFQ0UHikBzMIGQBgNVHSMEgYgwgYWAFImmYOO66j6v/GR/TL2M0kiN4MxG
>     -oWqkaDBmMQswCQYDVQQGEwJLRzELMAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hL
>     -RUsxFTATBgNVBAoTDE9wZW5WUE4tVEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlo
>     -b3N0Lm15ZG9tYWluggEAMA0GCSqGSIb3DQEBBAUAA4GBAKV5cn+iCCiOZtrh0L67
>     -lz1ln6seGazxZkQUj0586+oeL1fqREZMuVZbwAxY0kWHJm2C3oxkuIsiYWHGaDYI
>     -nVr9L+Uh4aIMfz7K4Qbqn4FiPaDO8R4Nq4aJ7ZqJNDLJ6W199RHDXX6l9/Gmg3cb
>     -lGfZD1ysDghKiJhlSetmni0o
>     ------END CERTIFICATE-----
>     diff --git a/sample/sample-keys/pass.key b/sample/sample-keys/pass.key
>     deleted file mode 100644
>     index 4916364..0000000
>     --- a/sample/sample-keys/pass.key
>     +++ /dev/null
>     @@ -1,18 +0,0 @@
>     ------BEGIN RSA PRIVATE KEY-----
>     -Proc-Type: 4,ENCRYPTED
>     -DEK-Info: DES-EDE3-CBC,959F7365DBBFDB77
>     -
>     -nGm57l+rR/8dAZOHL/1x/6dt11zUca7rphjsgw6XRnSf3M/CWmHvHVjApWcNLEs5
>     -SWNMp1xfUogtGzsKoMBbnlZLDA7RVHUYD6dVMyCpc64UjzT08LmdZhtQYLAKmlUC
>     -PT1VXS4Ae+SrqCPUqJkw1xP3kr0F1EVCXNu0nhOBAuuTGOS7PPEyW2N+k4nRHtsR
>     -IaPp8GCuIeoR6CdymTFTq6d/GeCiEcyrUM4BNrG4GtRRrURxxOrzQFEOS5sjBPSg
>     -Km1lwa6zBQFRLg9dKjRBL4teKuPY5Z2Nmpcml/aN4CkdkVEso4lW6/UHLE/joOMQ
>     -0MdpdYtu8wnt1WI/Z4immQfl3MF+QcPMkqXXzCEhGG/5SbAo89KC46UXvu1Z5OhS
>     -8XFHhvYBivOYWgZ3XUQqyZ0ulF60mFX7aE1Ph/eEbhWBHmU39hGjxzop1UoPwqLx
>     -ahvtfvCkR3ZeqlWO9SHzCA3MlrKwQ1p1UL6nG6AJhNN9jSevH6by+8wr07NBZOqX
>     -fJx+J/8EdVsUCFG2UJxPwM83ZSwAsvKRqph6CuWEl9ndUb7rw6khmRIoY0Iz3LbU
>     -1MlcDoJNcJas6lYDr1UeFSk86g0SiGCHXZIqsjyUgq6HIy4YrAYiQUthnlF8tp2Q
>     -nNQBPLo1GsHf0dC2MqKfDFASu7ST+Bl+yajHcIiUXvUJPxWbjkWYG9Q2p2ZBLzZD
>     -uqeRr66OKxTzUS4go/QbHDNsAulXl61gQIEOdZw5uy/Jl11kyAI6EQbzmehagKdH
>     -EshTgKp8ks62y0bBHgy3FMKyidJ5Hm58ZDhBxrwN0w+vhRoTGOepTA==
>     ------END RSA PRIVATE KEY-----
>     diff --git a/sample/sample-keys/pkcs12.p12
b/sample/sample-keys/pkcs12.p12
>     deleted file mode 100644
>     index
253d4081a3aeffab7d17e8c0a308ee1e85d6456f..0000000000000000000000000000000000000000
>     GIT binary patch
>     literal 0
>     HcmV?d00001
>
>     literal 2685
>     zcmY+FX*3j!8pmgb83vhTUnbc_G)!b{*|LOW9U`x+nHmjQ1`%T<W0xfcjmmCh7ugCC
>     zdJ&0)EMrR;Yxb*i?!E85AD;7^^ZTFY`Sd^Mhaj*7f`AMN0?QQ$ROYea<DFALCLo2t
>     zf?y=DTsXnf2m+JTKM{mNVB$MLTp%FeWS#ma0V0GTEdTz%281Bk8JTZzui!YHif({F
>     z%z!Wg<cF6_a`HQ&-}0i(xAKxjpEU+B5NPvT7ptk55iSO@...1973...#^pTwD>)*8*R!qdL
>     z42fKOorCYJc=T4J+l;Z>x@...1974...{LvCNkwZ7MJ{eDgmCW|XX+3GT!YUko$TXTGuE6Cmo
>     z9@...1975...=9<6!6cWi%@u>Dp-$JP2s6t=kvz6-OMl@~mEaEXG22le(Tfl@...1976...{VQ#pue@...1635...
>     z$S`$H)k#B#icbEdGUTOJNtg8r2HVyl<L=KiZIZ{}D6=w)Cr?cr?f_CJAI>~u|5a%&
>     z|9r54eca0dbeyd4`o{LK4N|e%U2!+rmvxC_ve9`q;d+UYx?t$mH)yUk-qpOnl`yp`
>     z6mivqIZ>KlXGlc!9*DRZGrJ8ENY!3w!PQRJQYJN)m0bubO9Gq)!dpG`51#4fNteWj
>     z)Uy{{o)tgT)cfGn@(n)(as)Oir2jGwc=aG2L+~IbIcV%&c5G|@P{*{Jd?#H>P7lkl
>     zqLP8(ve$BRfwQ=WmCMw1W!aWKiK;iH%ej(rhXL~D<1btDIJpqh`U$seQ1fvjn;X@~
>     zYBzzfQFps3x>N1~k|{r05Ej#luDsl5o+E5o6W}y((|9?EHOt+r>fDQx&b7jzQ$DN>
>     zB}mx=v1cW#Y}5;W1wVL}RxO)q&@+=uH(=%CV{+~qJFCmm>+q;_TVOBY$s0EFSdS;7
>     z&mqBKauOn(=lG*zP=4q^v2<1rBH%Edi*`-;3;k~BXqk@...1977...`Zs~A
>     z*lzbt<Lz*?oKpFwtf0bMAHn6Pn_bV_(qucN^dt>kpmn`Y<JKcdnQLS<@1i>h@...1978...
>     zEdZh~R0=kRsU4vUgW$I1u@|raEQEzz&hBqHE<e_`V*VvwZZK_?v#9@...1979...(OGuds8
>     zq@`uGfPUcv*)58>tEs$w^vz4cAHezuzgvmuh)lb`_LM{yoz0Ij*wf}VZB9stQ6roq
>     zhXDK5d)_MN2W5P|{wWcWta=?Is<$R6Ihym*+(~37OaRsIhbf-b8ck`;d~mN-TmSKH
>     zAkCx?E}l3w*$}9L3^26R;TBK#i@...1620...|Af(ggGixifT9?AFEFm1R)6{ia%&96Y_^kl<Z
>     zO|2vnP&e9h$B#-ZOGJ})^bdG_L!CP?tY@...1980...)+zmUojTmJjmc4zn6DhJtkU*2
>     zTyOtzc?4-O5*u>1WMq;EV3-lRXEM}xv(^O~!7!1)I|9!h9%_2p<}KW$RKr|`YcLw}
>     z<t#*oq1A`dE={byczot?YG(pSA(HR+V9kE4w4CN#78PlH7@...1981...#)P^RUmeu>0
>     zVEA183^cHZa*3$N9%A*|4roE^WV?ltK2PQvtg$I&eq(wH*W%4sXR2^rp@?LgRIi$c
>     z6%zNK^m$$X@&e`@P3O2H0YrU%8V)t=MmkiK;#rsB0!5%g)<#Kehh}i@<=mHXsKMvG
>     z>eU}MNQy!ZO;oXNw(nZ<bk2lI6SjTIljmfn0{qR9p3ED1Sz&?R`~alg3@...1982...#^Z
>     z`}cg57$n3>+J6q@)D4;l+}O_xHM_Z5tKoRYcpNO)&2;YaS1hNtXHcG&rv)Y1tsGBu
>     zH@@nN^V!H%fJ=zM7xONAJ@...1983...*$%sBw&?k)KQXv{!oF~wZcUek*9AzOQ5GBOcPsmu
>     zx>J0`U(5@...1984...>CkbfL4%WYBl*?wB7@...1985...+%J1>zfC|fk<4tarku$KHFg`)
>     z32;tRbzJ8+W1aCRdY>%w%VrGgsHNyd4EbT#Qqh=VeTVcd!bI2!ts#EONaY-#AwEJ$
>     zmV8E7g}dIaW$9T6mz_<cPyHH)vI(Gj!HGil32(YPF#3E^f5PEvZ8`K+AeaNE4Y{JZ
>     zq+-*=9IuO>@2(aI>^megR`|b;#<jFHG7)`Rd8LiIqXgc}@<>#4x0GX*bjvl8tur0T
>     zFi`8aRMRgtF^;s*U;`8O&uP@...1952...(S@...1986...;o#rX^|4v%b5bALTjthLt;I)IZQOg5sH58X
>     z@...1987...>)V+B%k!v42GexdYt2hT)KhBqlrh)t$to8;ngHput4!Yrk-gY=}e^$|C-Y@...1988...=
>     z-l_T>3@=KG>-JMVvEsG%_OrA4k@...1989...$RFdzXTFsv^5fJuNl`nhSt&uYLCr>Z
>     z%rdbJyB06(7buBJ`C6EtGF<4J?VJGCxLiP)aL?oQ96Llg9qZ6=h3stpHJ6e={Ewg1
>     zK+RSh?@GwJkQg&4zkgxJv+S4#fuv~Wlw&XBTWrIZVu<M<6^$$4j9FZSxaRM>_7~R1
>     z1hL~0b#})ulH*=gO69)OAwLx|pJlgtw5t9Z)?-pY?gb~g{M^?K=_s7xMG!!{|06^S
>     z0kp(O0L`7?>64j&u>MDnEI`mnn12Fa{GT-${#f&L#3IK5UMTvHHBZjN(4|GIJ8#*0
>     zEL~S%gL8a#5<fZ6(5MkHV?G~ynw>P7p0Bg+ozfQ|)o`WbEdFq=Pn+~*x}eSHDn>}0
>     za#bssC46DP>glYKit?*q(ylFaU(}~Odzjx2#k+auqmLOM8@...1598...)YFzplKD0QtM(F_Uu
>     zRHv^yDq*$`c$xNo;O1uEWTg5NnUR9^wRyLx4G&J3O$l?Ff&Sgd*Ux|{yu}Tc_kRAx
>     zZ4_A@...1990...$)Ek?$5BMzMT0ZfU+`%1_OIaTg-c`D3Utjws&do{_7d*j_LS6U+DKir
>     z@...1991...#p!oOstM}_SmVJ?vyvMMumfm9By?=?AtkFJ4R`)DJQf3HPtrO>CLF*ghb-Z{VT
>     z@&g3d`$hMvAw9wa-+X=cZug%2QLG(iT8okLHeD64iE06J24#}WG;%v0qN;o~J#X}X
>     zYrX|$IsBw!A%<DK8BxUAB#r~6R2VbwU(5j!Z&%wNb{;g|?T5+<F1~+I0vu7#x&Fvm
>     ze1ONAR~^|B&Qq0=ujo8B;e~P=3$o9GB)Cn*7-hG1(ZUGyCPoz>gBYC6=L-yXI_1c)
>     z+V2@}l1I9@^i#Ub8wuxSinPw-x7vv^wsW3}5xqf+AKwPmn+)MXcW9$*)7<p)X-4r0
>     z(}vuxaH}l=5mD9p6kTY6tV<=+{T09Rcf}dj;zzR*T|iIve0t3uU^!skyK<X(@4$hD
>     zjLKXu4dS7hQnxGPoJKwgMg4@...1992...^3R(;eyD;4^ur4ohCZxY|q1QA*+PG
>     z$SOGWw^n~{mai?yyFC!zxHo3~sLTIe)p*v~5PJ8vr85%;Nxo4%n<t_$^k`z?bVG;}
>     z=Y3=zfQmI$kU)t2x7AQ?1s+B&c~qWv*&*FkE5g%9wN}Fw%x7DNP(X+vpb)SuI|E1n
>     p3}EC!RO5XI2(vRh7cV|04Ibx-bA*{OGGFY`Qh)u6xbdgm{{pfR_hSG6
>
>     diff --git a/sample/sample-keys/server-ec.crt
b/sample/sample-keys/server-ec.crt
>     new file mode 100644
>     index 0000000..a72c341
>     --- /dev/null
>     +++ b/sample/sample-keys/server-ec.crt
>     @@ -0,0 +1,96 @@
>     +Certificate:
>     +    Data:
>     +        Version: 3 (0x2)
>     +        Serial Number: 3 (0x3)
>     +    Signature Algorithm: sha256WithRSAEncryption
>     +        Issuer: C=KG, ST=NA, L=BISHKEK,
O=OpenVPN-TEST/emailAddress=me@...430...
>     +        Validity
>     +            Not Before: Oct 22 21:59:53 2014 GMT
>     +            Not After : Oct 19 21:59:53 2024 GMT
>     +        Subject: C=KG, ST=NA, O=OpenVPN-TEST,
CN=Test-Server-EC/emailAddress=me@...430...
>     +        Subject Public Key Info:
>     +            Public Key Algorithm: id-ecPublicKey
>     +                Public-Key: (256 bit)
>     +                pub:
>     +                    04:21:09:ac:27:e6:00:3a:57:f4:f6:c7:78:a9:b1:
>     +                    f4:d7:d7:45:59:39:e4:a3:d3:2c:94:f9:61:4a:e6:
>     +                    b9:e9:87:57:c8:0f:88:03:a0:56:ee:34:e7:e4:4e:
>     +                    20:63:6c:c1:6e:c1:04:ac:b9:2f:a9:76:69:d3:7d:
>     +                    49:ff:f1:34:cb
>     +                ASN1 OID: secp256k1
>     +        X509v3 extensions:
>     +            X509v3 Basic Constraints:
>     +                CA:FALSE
>     +            Netscape Cert Type:
>     +                SSL Server
>     +            Netscape Comment:
>     +                OpenSSL Generated Server Certificate
>     +            X509v3 Subject Key Identifier:
>     +               
33:1A:42:61:9E:88:08:3F:6F:1F:98:88:3A:DD:2D:C7:07:3D:F6:9B
>     +            X509v3 Authority Key Identifier:
>     +               
keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
>     +               
DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
>     +                serial:A1:4E:DE:FA:90:F2:AE:81
>     +
>     +            X509v3 Extended Key Usage:
>     +                TLS Web Server Authentication
>     +            X509v3 Key Usage:
>     +                Digital Signature, Key Encipherment
>     +    Signature Algorithm: sha256WithRSAEncryption
>     +         9d:89:f6:7e:0b:43:05:22:63:e5:b3:45:a8:d9:ef:33:3c:b7:
>     +         19:37:28:87:27:43:43:86:a3:3f:b9:23:27:0f:96:4f:de:01:
>     +         80:38:6b:d9:c8:94:77:1f:06:08:34:65:77:ad:57:0c:23:99:
>     +         f1:51:12:5f:32:d8:9c:7c:93:f1:f6:72:2a:05:61:ff:62:aa:
>     +         33:aa:ef:a3:4d:d6:93:56:40:ff:38:2e:73:1c:69:fb:71:a1:
>     +         fa:64:19:6a:04:1c:8b:20:a8:ee:a5:18:63:f8:84:f4:ca:84:
>     +         8e:b6:05:48:c6:f3:f7:81:90:4d:9e:00:cd:4a:92:83:d4:93:
>     +         67:05:dc:16:8b:78:fa:b1:82:48:c6:86:74:44:b1:06:7e:8a:
>     +         c8:64:0b:82:3a:e2:f5:56:60:ea:50:70:03:da:9f:fc:28:20:
>     +         6b:7d:04:e0:eb:8d:e2:f1:be:82:2f:ba:51:50:2b:6c:d2:fc:
>     +         11:cd:69:85:3b:9e:14:19:dd:bc:14:cf:61:b0:7a:07:cb:e8:
>     +         e0:fc:c3:1f:a4:cb:cf:c1:e9:62:0f:d2:53:f8:ce:06:f4:f8:
>     +         2f:55:13:aa:67:44:b6:b8:e8:3e:82:af:66:f5:f0:7c:fe:41:
>     +         e6:9d:c0:9f:78:fd:00:85:02:40:63:37:fa:00:e6:3c:a6:9f:
>     +         35:4f:1d:a6:f1:cb:8b:04:e0:67:98:56:d1:87:58:b6:39:f6:
>     +         d3:fe:a8:40:50:80:7f:e6:4a:36:d0:c0:a5:61:64:1d:3a:87:
>     +         ad:78:72:c9:3f:98:44:35:f9:cf:32:b2:18:4c:b0:72:fa:5e:
>     +         6c:62:1e:d4:31:0c:c8:9b:74:f0:00:9e:70:c3:1e:c7:a4:9d:
>     +         03:a4:ac:1a:09:1f:86:23:65:51:34:50:86:68:1e:68:4d:9a:
>     +         4b:78:10:1c:bd:51:09:bb:fe:16:a3:c7:19:b4:05:44:a1:e6:
>     +         c6:23:76:d5:b8:3a:eb:a5:17:1d:2b:2e:fe:85:7c:88:4f:f1:
>     +         e8:34:32:e0:c5:96:87:c3:e8:c9:5f:89:24:10:0e:1e:07:0b:
>     +         2c:f8:d0:49:1b:63:5e:63:44:e9:2a:43:e2:9c:d6:f2:43:99:
>     +         47:f8:9b:49:1a:a7:d1:e0:53:67:1d:cb:14:b6:b0:2c:4d:b3:
>     +         f2:c5:62:c2:a6:09:7a:c0:6c:59:3e:73:83:0c:6c:de:30:77:
>     +         4d:1b:ed:b0:7f:77:87:8d:55:1d:d3:ed:f7:66:bd:06:2a:f8:
>     +         fd:00:e7:c0:31:e2:ff:53:9e:25:97:c6:64:84:9d:8d:61:8e:
>     +         c9:1f:6c:55:a1:7c:59:aa:eb:e8:2a:b2:2d:c7:09:cd:b5:3d:
>     +         d8:74:4f:6e:9c:3b:d5:6d
>     +-----BEGIN CERTIFICATE-----
>     +MIIEtTCCAp2gAwIBAgIBAzANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL
>     +MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
>     +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy
>     +MjIxNTk1M1oXDTI0MTAxOTIxNTk1M1owbTELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
>     +Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFzAVBgNVBAMTDlRlc3QtU2VydmVy
>     +LUVDMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wVjAQBgcqhkjO
>     +PQIBBgUrgQQACgNCAAQhCawn5gA6V/T2x3ipsfTX10VZOeSj0yyU+WFK5rnph1fI
>     +D4gDoFbuNOfkTiBjbMFuwQSsuS+pdmnTfUn/8TTLo4IBMzCCAS8wCQYDVR0TBAIw
>     +ADARBglghkgBhvhCAQEEBAMCBkAwMwYJYIZIAYb4QgENBCYWJE9wZW5TU0wgR2Vu
>     +ZXJhdGVkIFNlcnZlciBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQUMxpCYZ6ICD9vH5iI
>     +Ot0txwc99pswgZgGA1UdIwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRo
>     +MGYxCzAJBgNVBAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEV
>     +MBMGA1UEChMMT3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3Qu
>     +bXlkb21haW6CCQChTt76kPKugTATBgNVHSUEDDAKBggrBgEFBQcDATALBgNVHQ8E
>     +BAMCBaAwDQYJKoZIhvcNAQELBQADggIBAJ2J9n4LQwUiY+WzRajZ7zM8txk3KIcn
>     +Q0OGoz+5IycPlk/eAYA4a9nIlHcfBgg0ZXetVwwjmfFREl8y2Jx8k/H2cioFYf9i
>     +qjOq76NN1pNWQP84LnMcaftxofpkGWoEHIsgqO6lGGP4hPTKhI62BUjG8/eBkE2e
>     +AM1KkoPUk2cF3BaLePqxgkjGhnREsQZ+ishkC4I64vVWYOpQcAPan/woIGt9BODr
>     +jeLxvoIvulFQK2zS/BHNaYU7nhQZ3bwUz2GwegfL6OD8wx+ky8/B6WIP0lP4zgb0
>     ++C9VE6pnRLa46D6Cr2b18Hz+QeadwJ94/QCFAkBjN/oA5jymnzVPHabxy4sE4GeY
>     +VtGHWLY59tP+qEBQgH/mSjbQwKVhZB06h614csk/mEQ1+c8yshhMsHL6XmxiHtQx
>     +DMibdPAAnnDDHseknQOkrBoJH4YjZVE0UIZoHmhNmkt4EBy9UQm7/hajxxm0BUSh
>     +5sYjdtW4OuulFx0rLv6FfIhP8eg0MuDFlofD6MlfiSQQDh4HCyz40EkbY15jROkq
>     +Q+Kc1vJDmUf4m0kap9HgU2cdyxS2sCxNs/LFYsKmCXrAbFk+c4MMbN4wd00b7bB/
>     +d4eNVR3T7fdmvQYq+P0A58Ax4v9TniWXxmSEnY1hjskfbFWhfFmq6+gqsi3HCc21
>     +Pdh0T26cO9Vt
>     +-----END CERTIFICATE-----
>     diff --git a/sample/sample-keys/server-ec.key
b/sample/sample-keys/server-ec.key
>     new file mode 100644
>     index 0000000..8f2c914
>     --- /dev/null
>     +++ b/sample/sample-keys/server-ec.key
>     @@ -0,0 +1,5 @@
>     +-----BEGIN PRIVATE KEY-----
>     +MIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQgLHGYqSlzoRaogmJfrC+E
>     +ozTothB9bORaQ1C/3FmeQ6ehRANCAAQhCawn5gA6V/T2x3ipsfTX10VZOeSj0yyU
>     ++WFK5rnph1fID4gDoFbuNOfkTiBjbMFuwQSsuS+pdmnTfUn/8TTL
>     +-----END PRIVATE KEY-----
>     diff --git a/sample/sample-keys/server.crt
b/sample/sample-keys/server.crt
>     index 28bb4d9..03e2023 100644
>     --- a/sample/sample-keys/server.crt
>     +++ b/sample/sample-keys/server.crt
>     @@ -2,25 +2,34 @@ Certificate:
>          Data:
>              Version: 3 (0x2)
>              Serial Number: 1 (0x1)
>     -        Signature Algorithm: md5WithRSAEncryption
>     +    Signature Algorithm: sha256WithRSAEncryption
>              Issuer: C=KG, ST=NA, L=BISHKEK,
O=OpenVPN-TEST/emailAddress=me@...430...
>              Validity
>     -            Not Before: Nov 25 14:42:22 2004 GMT
>     -            Not After : Nov 23 14:42:22 2014 GMT
>     +            Not Before: Oct 22 21:59:52 2014 GMT
>     +            Not After : Oct 19 21:59:52 2024 GMT
>              Subject: C=KG, ST=NA, O=OpenVPN-TEST,
CN=Test-Server/emailAddress=me@...430...
>              Subject Public Key Info:
>                  Public Key Algorithm: rsaEncryption
>     -            RSA Public Key: (1024 bit)
>     -                Modulus (1024 bit):
>     -                    00:cb:4e:ac:f9:83:57:f6:69:d2:32:29:b4:bc:ad:
>     -                    e6:f7:26:21:89:33:30:43:40:a3:35:d9:de:26:01:
>     -                    d6:b4:f0:bc:0a:19:55:99:3b:f1:4c:91:60:b6:fd:
>     -                    74:34:8d:5a:c7:62:ec:ce:f2:d6:02:ce:57:32:f4:
>     -                    35:8c:71:a0:6d:65:2a:e7:80:ae:29:59:cf:36:73:
>     -                    f8:7c:4a:73:90:fc:30:28:d5:46:7d:35:a4:4e:c9:
>     -                    9f:90:7b:e2:09:21:36:c5:a8:ec:85:82:9a:32:b4:
>     -                    91:3b:c1:d6:4f:9f:d1:f8:6f:68:f4:1d:d2:06:91:
>     -                    32:cc:9a:48:fd:cd:98:7f:2f
>     +                Public-Key: (2048 bit)
>     +                Modulus:
>     +                    00:a5:b8:a2:ee:ce:b1:a6:0f:6a:b2:9f:d3:22:17:
>     +                    79:de:09:98:71:78:fa:a7:ce:36:51:54:57:c7:31:
>     +                    99:56:d1:8a:d6:c5:fd:52:e6:88:0e:7b:f9:ea:27:
>     +                    7a:bf:3f:14:ec:aa:d2:ff:8b:56:58:ac:ca:51:77:
>     +                    c5:3c:b6:e4:83:6f:22:06:2d:5b:eb:e7:59:d4:ab:
>     +                    42:c8:d5:a9:87:73:b3:73:36:51:2f:a5:d0:90:a2:
>     +                    87:64:54:6c:12:d3:b8:76:47:69:af:ae:8f:00:b3:
>     +                    70:b9:e7:67:3f:8c:6a:3d:79:5f:81:27:a3:0e:aa:
>     +                    a7:3d:81:48:10:b1:18:6c:38:2e:8f:7a:7b:c5:3d:
>     +                    21:c8:f9:a0:7f:17:2b:88:4f:ba:f2:ec:6d:24:8e:
>     +                    6c:f1:0a:5c:d9:5b:b1:b0:fc:49:cb:4a:d2:58:c6:
>     +                    2a:25:b0:97:84:c3:9e:ff:34:8c:10:46:7f:0f:fb:
>     +                    3c:59:7a:a6:29:0c:ae:8e:50:3a:f2:53:84:40:2d:
>     +                    d5:91:7b:0a:37:8e:82:77:ce:66:2f:34:77:5c:a5:
>     +                    45:3b:00:19:a7:07:d1:92:e6:66:b9:3b:4e:e9:63:
>     +                    fc:33:98:1a:ae:7b:08:7d:0a:df:7a:ba:aa:59:6d:
>     +                    86:82:0a:64:2b:da:59:a7:4c:4e:ef:3d:bd:04:a2:
>     +                    4b:31
>                      Exponent: 65537 (0x10001)
>              X509v3 extensions:
>                  X509v3 Basic Constraints:
>     @@ -30,38 +39,75 @@ Certificate:
>                  Netscape Comment:
>                      OpenSSL Generated Server Certificate
>                  X509v3 Subject Key Identifier:
>     -               
69:11:FE:E7:9F:89:7B:71:34:69:C0:DC:82:F8:D0:5D:4D:FB:78:DF
>     +               
B3:9D:81:E6:16:92:64:C4:86:87:F5:29:10:1B:5E:2F:74:F7:ED:B1
>                  X509v3 Authority Key Identifier:
>     -               
keyid:89:A6:60:E3:BA:EA:3E:AF:FC:64:7F:4C:BD:8C:D2:48:8D:E0:CC:46
>     +               
keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
>                     
DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
>     -                serial:00
>     +                serial:A1:4E:DE:FA:90:F2:AE:81
>
>     -    Signature Algorithm: md5WithRSAEncryption
>     -        35:5c:75:da:57:ef:b5:79:f2:a2:db:36:e4:75:e8:c7:bc:73:
>     -        26:cf:30:36:4b:2e:51:46:37:60:2f:4e:2b:f6:71:a2:23:db:
>     -        8e:d8:5c:d5:af:2e:22:28:dd:30:a8:89:66:3a:cc:5b:3c:0f:
>     -        96:12:20:de:5e:41:52:74:35:ed:4c:26:40:19:ca:73:df:54:
>     -        b1:30:96:9c:a5:14:d0:38:28:3f:ab:30:07:d7:de:98:d2:7f:
>     -        7f:90:b2:52:1d:e5:95:88:ed:ba:8a:6a:14:85:66:76:ec:75:
>     -        30:e8:ae:94:f4:e1:76:fa:4b:0e:f1:53:d7:95:be:fb:69:fa:
>     -        3d:32
>     +            X509v3 Extended Key Usage:
>     +                TLS Web Server Authentication
>     +            X509v3 Key Usage:
>     +                Digital Signature, Key Encipherment
>     +    Signature Algorithm: sha256WithRSAEncryption
>     +         4e:25:80:1b:cb:b0:42:ff:bb:3f:e8:0d:58:c1:80:db:cf:d0:
>     +         90:df:ca:c1:e6:41:e1:48:7f:a7:1e:c7:35:9f:9c:6d:7c:3e:
>     +         82:e8:de:7e:ae:82:16:00:33:0f:02:23:f1:9d:fe:2b:06:16:
>     +         05:55:16:89:dc:63:ac:5f:1a:31:13:79:21:a3:6e:60:28:e8:
>     +         e7:6b:54:00:22:a1:b7:69:5a:17:31:ce:0f:c2:a6:dd:a3:6f:
>     +         de:ea:19:6c:d2:d2:cb:35:9d:dd:87:51:33:68:cd:c3:9b:90:
>     +         55:f1:80:3d:5c:b8:09:b6:e1:3c:13:a4:5d:4a:ce:a5:11:9e:
>     +         f9:08:ee:be:e3:54:1d:06:4c:bb:1b:72:13:ee:7d:a0:45:cc:
>     +         fe:d1:3b:02:03:c1:d4:ea:45:2d:a8:c9:97:e7:f3:8a:7a:a0:
>     +         2f:dd:48:3a:75:c9:42:28:94:fc:af:44:52:16:68:98:d6:ad:
>     +         a8:65:b1:cd:ac:60:41:70:e5:44:e8:5a:f2:e7:fc:3b:fe:45:
>     +         89:17:1d:6d:85:c6:f0:fc:69:87:d1:1d:07:f3:cb:7b:54:8d:
>     +         aa:a3:cc:e3:c6:fc:d6:05:76:35:d0:26:63:8e:d1:a8:b7:ff:
>     +         61:42:8a:2c:63:1f:d4:ec:14:47:6b:1e:e3:81:61:12:3b:8c:
>     +         16:b5:cf:87:6a:2d:42:21:83:9c:0e:3a:90:3a:1e:c1:36:61:
>     +         41:f9:fb:4e:5d:ea:f4:df:23:92:33:2b:9b:14:9f:a0:f5:d3:
>     +         c4:f8:1f:2f:9c:11:36:af:2a:22:61:95:32:0b:c4:1c:2d:b1:
>     +         c1:0a:2a:97:c0:43:4a:6c:3e:db:00:cd:29:15:9e:7e:41:75:
>     +         36:a8:56:86:8c:82:9e:46:20:e5:06:1e:60:d2:03:5f:9f:9e:
>     +         69:bb:bf:c2:b4:43:e2:7d:85:17:83:18:41:b0:cb:a9:04:1b:
>     +         18:52:9f:89:8b:76:9f:94:59:81:4f:60:5b:33:18:fc:c7:52:
>     +         d0:d2:69:fc:0b:a2:63:32:75:43:99:e9:d7:f8:6d:c7:55:31:
>     +         0c:f3:ef:1a:71:e1:0a:57:e1:9d:13:b2:1e:fe:1d:ef:e4:f1:
>     +         51:d9:95:b3:fd:28:28:93:91:4a:29:c5:37:0e:ab:d8:85:6a:
>     +         fe:a8:83:1f:7b:80:5d:1f:04:79:b7:a9:08:6e:0d:d6:2e:aa:
>     +         7c:f6:63:7d:41:de:70:13:32:ce:dd:58:cc:a6:73:d4:72:7e:
>     +         d7:ac:74:a8:35:ba:c3:1b:2a:64:d7:5a:37:97:56:94:34:2b:
>     +         2a:71:60:bc:69:ab:00:85:b9:4f:67:32:17:51:c3:da:57:3a:
>     +         37:89:66:c4:7a:51:da:5f
>      -----BEGIN CERTIFICATE-----
>     -MIIDUTCCArqgAwIBAgIBATANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL
>     +MIIFgDCCA2igAwIBAgIBATANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL
>      MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
>     -VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy
>     -NTE0NDIyMloXDTE0MTEyMzE0NDIyMlowajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
>     +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy
>     +MjIxNTk1MloXDTI0MTAxOTIxNTk1MlowajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
>      Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFDASBgNVBAMTC1Rlc3QtU2VydmVy
>     -MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wgZ8wDQYJKoZIhvcN
>     -AQEBBQADgY0AMIGJAoGBAMtOrPmDV/Zp0jIptLyt5vcmIYkzMENAozXZ3iYB1rTw
>     -vAoZVZk78UyRYLb9dDSNWsdi7M7y1gLOVzL0NYxxoG1lKueArilZzzZz+HxKc5D8
>     -MCjVRn01pE7Jn5B74gkhNsWo7IWCmjK0kTvB1k+f0fhvaPQd0gaRMsyaSP3NmH8v
>     -AgMBAAGjggEJMIIBBTAJBgNVHRMEAjAAMBEGCWCGSAGG+EIBAQQEAwIGQDAzBglg
>     -hkgBhvhCAQ0EJhYkT3BlblNTTCBHZW5lcmF0ZWQgU2VydmVyIENlcnRpZmljYXRl
>     -MB0GA1UdDgQWBBRpEf7nn4l7cTRpwNyC+NBdTft43zCBkAYDVR0jBIGIMIGFgBSJ
>     -pmDjuuo+r/xkf0y9jNJIjeDMRqFqpGgwZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
>     -Ak5BMRAwDgYDVQQHEwdCSVNIS0VLMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxITAf
>     -BgkqhkiG9w0BCQEWEm1lQG15aG9zdC5teWRvbWFpboIBADANBgkqhkiG9w0BAQQF
>     -AAOBgQA1XHXaV++1efKi2zbkdejHvHMmzzA2Sy5RRjdgL04r9nGiI9uO2FzVry4i
>     -KN0wqIlmOsxbPA+WEiDeXkFSdDXtTCZAGcpz31SxMJacpRTQOCg/qzAH196Y0n9/
>     -kLJSHeWViO26imoUhWZ27HUw6K6U9OF2+ksO8VPXlb77afo9Mg==
>     +MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wggEiMA0GCSqGSIb3
>     +DQEBAQUAA4IBDwAwggEKAoIBAQCluKLuzrGmD2qyn9MiF3neCZhxePqnzjZRVFfH
>     +MZlW0YrWxf1S5ogOe/nqJ3q/PxTsqtL/i1ZYrMpRd8U8tuSDbyIGLVvr51nUq0LI
>     +1amHc7NzNlEvpdCQoodkVGwS07h2R2mvro8As3C552c/jGo9eV+BJ6MOqqc9gUgQ
>     +sRhsOC6PenvFPSHI+aB/FyuIT7ry7G0kjmzxClzZW7Gw/EnLStJYxiolsJeEw57/
>     +NIwQRn8P+zxZeqYpDK6OUDryU4RALdWRewo3joJ3zmYvNHdcpUU7ABmnB9GS5ma5
>     +O07pY/wzmBquewh9Ct96uqpZbYaCCmQr2lmnTE7vPb0EoksxAgMBAAGjggEzMIIB
>     +LzAJBgNVHRMEAjAAMBEGCWCGSAGG+EIBAQQEAwIGQDAzBglghkgBhvhCAQ0EJhYk
>     +T3BlblNTTCBHZW5lcmF0ZWQgU2VydmVyIENlcnRpZmljYXRlMB0GA1UdDgQWBBSz
>     +nYHmFpJkxIaH9SkQG14vdPftsTCBmAYDVR0jBIGQMIGNgBQrQOXJffX0ljjpL+Mv
>     +2UBkyY4Fm6FqpGgwZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgTAk5BMRAwDgYDVQQH
>     +EwdCSVNIS0VLMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxITAfBgkqhkiG9w0BCQEW
>     +Em1lQG15aG9zdC5teWRvbWFpboIJAKFO3vqQ8q6BMBMGA1UdJQQMMAoGCCsGAQUF
>     +BwMBMAsGA1UdDwQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAgEATiWAG8uwQv+7P+gN
>     +WMGA28/QkN/KweZB4Uh/px7HNZ+cbXw+gujefq6CFgAzDwIj8Z3+KwYWBVUWidxj
>     +rF8aMRN5IaNuYCjo52tUACKht2laFzHOD8Km3aNv3uoZbNLSyzWd3YdRM2jNw5uQ
>     +VfGAPVy4CbbhPBOkXUrOpRGe+QjuvuNUHQZMuxtyE+59oEXM/tE7AgPB1OpFLajJ
>     +l+fzinqgL91IOnXJQiiU/K9EUhZomNatqGWxzaxgQXDlROha8uf8O/5FiRcdbYXG
>     +8Pxph9EdB/PLe1SNqqPM48b81gV2NdAmY47RqLf/YUKKLGMf1OwUR2se44FhEjuM
>     +FrXPh2otQiGDnA46kDoewTZhQfn7Tl3q9N8jkjMrmxSfoPXTxPgfL5wRNq8qImGV
>     +MgvEHC2xwQoql8BDSmw+2wDNKRWefkF1NqhWhoyCnkYg5QYeYNIDX5+eabu/wrRD
>     +4n2FF4MYQbDLqQQbGFKfiYt2n5RZgU9gWzMY/MdS0NJp/AuiYzJ1Q5np1/htx1Ux
>     +DPPvGnHhClfhnROyHv4d7+TxUdmVs/0oKJORSinFNw6r2IVq/qiDH3uAXR8Eebep
>     +CG4N1i6qfPZjfUHecBMyzt1YzKZz1HJ+16x0qDW6wxsqZNdaN5dWlDQrKnFgvGmr
>     +AIW5T2cyF1HD2lc6N4lmxHpR2l8=
>      -----END CERTIFICATE-----
>     diff --git a/sample/sample-keys/server.key
b/sample/sample-keys/server.key
>     index 976acab..011df12 100644
>     --- a/sample/sample-keys/server.key
>     +++ b/sample/sample-keys/server.key
>     @@ -1,15 +1,28 @@
>     ------BEGIN RSA PRIVATE KEY-----
>     -MIICXgIBAAKBgQDLTqz5g1f2adIyKbS8reb3JiGJMzBDQKM12d4mAda08LwKGVWZ
>     -O/FMkWC2/XQ0jVrHYuzO8tYCzlcy9DWMcaBtZSrngK4pWc82c/h8SnOQ/DAo1UZ9
>     -NaROyZ+Qe+IJITbFqOyFgpoytJE7wdZPn9H4b2j0HdIGkTLMmkj9zZh/LwIDAQAB
>     -AoGBAKP1ljA/iY/zNY447kZ/5NWKzd7tBk4mcbl7M9no/7O6tZtbZRoIKoi6cYoC
>     -C1ZabUyBbkNTud5XdCFmq0zRUjOWvoFMZ9VZfd2kRPvl4TGczBtJAq65b+EYMGui
>     -q6T9p61xPdtzu0vM+Ecj127pAMk5XcJyxu8XQK7lZWmG5UoJAkEA8CxXNZN+A3qD
>     -bMBPI3VdwKCNSjNVEQEnygMbNgw7VLdxPpspzZziqJEGdzsM4dsnOBwKxIWFLN2h
>     -lbGBOquAswJBANi0atGWM8VUxDjvqqHCTS9RUXWgnvYhee4/xraJBQPBSivjC9P0
>     -vKT7PjBHU6djtKSLKGaHn1vHqmyY7PCMjZUCQQCNVSqExqSzG1dXmdt4PErNXi2G
>     -6qo2dX2arTVIGu6XLdQgSWLSMm5XT/CEHWW5SyPLKwVTHFeATXQXCPvJML9tAkEA
>     -k0yXax0g1ZoXwufN4SQUmPw6Va03P/BjU/nP1ZVvbiz9gLVU/d7WN4J7tA9XomkY
>     -idv5OzAmtxkSE70jGSNAvQJAWhCf9+iHkzOHRyKKOYlh1DHUwDfSEp+hlZYg9H03
>     -P2sraQzUxgWDY/DIY63KvW78ny863baFz7onz21MYGgJXg==
>     ------END RSA PRIVATE KEY-----
>     +-----BEGIN PRIVATE KEY-----
>     +MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCluKLuzrGmD2qy
>     +n9MiF3neCZhxePqnzjZRVFfHMZlW0YrWxf1S5ogOe/nqJ3q/PxTsqtL/i1ZYrMpR
>     +d8U8tuSDbyIGLVvr51nUq0LI1amHc7NzNlEvpdCQoodkVGwS07h2R2mvro8As3C5
>     +52c/jGo9eV+BJ6MOqqc9gUgQsRhsOC6PenvFPSHI+aB/FyuIT7ry7G0kjmzxClzZ
>     +W7Gw/EnLStJYxiolsJeEw57/NIwQRn8P+zxZeqYpDK6OUDryU4RALdWRewo3joJ3
>     +zmYvNHdcpUU7ABmnB9GS5ma5O07pY/wzmBquewh9Ct96uqpZbYaCCmQr2lmnTE7v
>     +Pb0EoksxAgMBAAECggEAPMOMin+jR75TYxeTNObiunVOPh0b2zeTVxLT9KfND7ZZ
>     +cBK8pg79SEJRCnhbW5BnvbeNEkIm8PC6ZlDCM1bkRwUStq0fDUqQ95esLzOYq5/S
>     +5qW98viblszhU/pYfja/Zi8dI1uf96PT63Zbt0NnGQ9N42+DLDeKhtTGdchZqiQA
>     +LeSR0bQanY4tUUtCNYvBT8E3pzhoIsUzVwzIK53oovRpcOX3pMXVYZsmNhXdFFRy
>     +YkjMXpj7fGyaAJK0QsC+PsgrKuhXDzDttsG2lI/mq9+7RXB3d/pzhmBVWynVH2lw
>     +iQ7ONkSz7akDz/4I4WmxJep+FfQJYgK6rnLAlQqauQKBgQDammSAprnvDvNhSEp8
>     +W+xt7jQnFqaENbGgP0/D/OZMXc4khgexqlKFmSnBCRDmQ6JvLTWqDXC4+aqAbFQz
>     +zAIjiKaT+so8xvFRob+rBMJY5JLYKNa+zUUanfORUNYLFJPvFqnrWGaJ9uufdaM7
>     +0a5bu95PN74NXee3DBbpBv8HLwKBgQDCEk+IjNbjMT+Neq0ywUeM5rFrUKi92abe
>     +AgsVpjbighRV+6jA2lZFJcize+xYJ9wiOR1/TEI9PZ2OtBkqpwVdvTEHTagRLcvd
>     +NfGcptREDnNLoNWA22buQpztiEduutACWQsrd+JQmqbUicUdW4zw86/oCMbYCW3V
>     +QmYOLns7nwKBgHHUX20WZE91S4pmqFKlUzHTDdkk1ESX6Qx2q0R01j8BwawHFs6O
>     +0DW9EZ7w55nfsh+OPRl1sjK/3ubMgfQO0TZLm+IGf3Sya0qEnVeiPMkpDMX+TgRA
>     +wzEe+ou6uho+9uFSvdxMxeglaYA5M2ycvNwLsbEyZ4ZyVYxdgTiKahYFAoGAcIfP
>     +iD0qKQiYcj/tB94cz+3AeJqHjbYT1O1YYhBECOkmQ4kuG80+cs/q5W/45lEOiuWV
>     +Xgfo7Lu6jVGOujWoneci87oqtvNYH4e09oGh2WiLoBG9Wv9dWtBTUERSLzmxfXsG
>     +SAk2uEhEbj8IhfJc8iZLHH9iVUh6YEslBBodqL8CgYEAlAhvcqAvw5SzsfBR5Mcu
>     +4Nql6mXEVhHCvS4hdFCGaNF0z9A6eBORKJpdLWnqhpquDQDsghWE+Ga4QKSNFIi1
>     +fnAaykmZuY3ToqNOIaVlYM6HpMEz0wHQbTWfDLGcTFcElLZgMAk7VlDyiYVOco+E
>     +QX9lXOO1PGpLzXhlDxSe63Y=
>     +-----END PRIVATE KEY-----
>     --
>     1.9.1
>
>
>
>
>
------------------------------------------------------------------------------
> Comprehensive Server Monitoring with Site24x7.
> Monitor 10 servers for $9/Month.
> Get alerted through email, SMS, voice calls or mobile push notifications.
> Take corrective actions from your mobile device.
>
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlRncRIACgkQwp2X7RmNIqO9gACglDoO+mMUHDl2z+G6doMe0pYp
vUYAn1fyUOEfVje+/fUZhLzeD/4oRCmV
=VmdE
-----END PGP SIGNATURE-----


--------------060807030303030606060902
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <br>
    -----BEGIN PGP SIGNED MESSAGE-----<br>
    Hash: SHA1<br>
    <br>
    Hi Steffan,<br>
    <br>
    I tested the key generation script with /bin/bash and /bin/dash on
    Linux, and using /bin/sh on FreeBSD. The rest of the patch looked
    fine, too.<br>
    <br>
    ACK.<br>
    <br>
    Samuli<br>
    <br>
    <span style=3D"white-space: pre;">&gt; Attached a v2 of this patch
      that adds an extra check whether openssl is actually available.<br>
      &gt;<br>
      &gt; -Steffan<br>
      &gt;<br>
      &gt; On Thu, Oct 23, 2014 at 12:16 AM, Steffan Karger
      &lt;<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:steffan@...1386...=
856...">steffan@...1856...</a> <a class=3D"moz-txt-link-rfc2396E" href=3D"m=
ailto:steffan@...1856...">&lt;mailto:steffan@...1856...&gt;</a>&gt; wrote:<=
br>
      &gt;<br>
      &gt;=A0=A0=A0=A0 I kept most of the certificate properties equal to t=
he
      old<br>
      &gt;=A0=A0=A0=A0 certs, since some people's test scripts might rely on
      them (and<br>
      &gt;=A0=A0=A0=A0 it does not require any creativity from my part).<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0 Changes:<br>
      &gt;=A0=A0=A0=A0=A0 * Add script to generate fresh test/sample keys<b=
r>
      &gt;=A0=A0=A0=A0=A0=A0=A0 (but keep sample keys in git for simple tes=
ting)<br>
      &gt;=A0=A0=A0=A0=A0 * Switch from 1024 to 4096 bits RSA CA<br>
      &gt;=A0=A0=A0=A0=A0 * Switch from 1024 to 2048 bits client/server RSA=
 keys<br>
      &gt;=A0=A0=A0=A0=A0 * Switch from 1024 to 2048 bits Diffie-Hellman
      parameters<br>
      &gt;=A0=A0=A0=A0=A0 * Generate EC client and server cert, but sign wi=
th RSA
      CA<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0 (lets us test EC &lt;-&gt; RSA interoperabi=
lity)<br>
      &gt;=A0=A0=A0=A0=A0 * Remove 3DES cipher from 'sample' config<br>
      &gt;=A0=A0=A0=A0=A0 * Add 'remote-cert-tls server' to client config<b=
r>
      &gt;=A0=A0=A0=A0=A0 * Update config files to deprecate nsCertType in =
favour
      of the<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0 keyUsage and extendedKeyUsage extensions.<b=
r>
      &gt;=A0=A0=A0=A0=A0 * Make naming more consistent<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0 Signed-off-by: Steffan Karger &lt;<a class=3D"moz-tx=
t-link-abbreviated" href=3D"mailto:steffan@...1856...">steffan@...1856...</=
a>
      <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:steffan@...1856..."=
>&lt;mailto:steffan@...1856...&gt;</a>&gt;<br>
      &gt;=A0=A0=A0=A0 ---<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-config-files/client.conf=A0=A0=A0=
=A0 |=A0 17 ++--<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-config-files/loopback-client |=A0=
=A0 2 +-<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-config-files/loopback-server |=A0=
=A0 3 +-<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-config-files/server.conf=A0=A0=A0=
=A0 |=A0=A0 6 +-<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-config-files/tls-office.conf |=A0=
=A0 2 +-<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/.gitignore=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/README=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 17 ++--<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/ca.crt=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 48
      ++++++----<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/ca.key=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 67
      ++++++++++----<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/client-ec.crt=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 85
      ++++++++++++++++++<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/client-ec.key=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0 5 ++<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/client-pass.key=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0 30 +++++++<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/client.crt=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 | 126
      +++++++++++++++++---------<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/client.key=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0 43
      +++++----<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/client.p12=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 | Bin 0 -&gt;
      4533 bytes<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/dh1024.pem=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 5 --<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/dh2048.pem=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 8 ++<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/ec-ca.crt=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0 13 ---<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/ec-ca.key=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 6 --<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/ec-client.crt=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 61
      -------------<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/ec-client.key=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0 6 --<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/ec-server.crt=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 61
      -------------<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/ec-server.key=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0 6 --<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/gen-sample-keys.sh=A0=A0=A0=A0=
=A0 |=A0 74
      +++++++++++++++<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/openssl.cnf=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 | 139
      +++++++++++++++++++++++++++++<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/pass.crt=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 65
      --------------<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/pass.key=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 18 ----<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/pkcs12.p12=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 | Bin 2685
      -&gt; 0 bytes<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/server-ec.crt=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 96
      ++++++++++++++++++++<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/server-ec.key=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0 5 ++<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/server.crt=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 | 130
      ++++++++++++++++++---------<br>
      &gt;=A0=A0=A0=A0=A0 sample/sample-keys/server.key=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0 43
      +++++----<br>
      &gt;=A0=A0=A0=A0=A0 32 files changed, 778 insertions(+), 410 deletion=
s(-)<br>
      &gt;=A0=A0=A0=A0=A0 create mode 100644 sample/sample-keys/.gitignore<=
br>
      &gt;=A0=A0=A0=A0=A0 create mode 100644 sample/sample-keys/client-ec.c=
rt<br>
      &gt;=A0=A0=A0=A0=A0 create mode 100644 sample/sample-keys/client-ec.k=
ey<br>
      &gt;=A0=A0=A0=A0=A0 create mode 100644 sample/sample-keys/client-pass=
.key<br>
      &gt;=A0=A0=A0=A0=A0 create mode 100644 sample/sample-keys/client.p12<=
br>
      &gt;=A0=A0=A0=A0=A0 delete mode 100644 sample/sample-keys/dh1024.pem<=
br>
      &gt;=A0=A0=A0=A0=A0 create mode 100644 sample/sample-keys/dh2048.pem<=
br>
      &gt;=A0=A0=A0=A0=A0 delete mode 100644 sample/sample-keys/ec-ca.crt<b=
r>
      &gt;=A0=A0=A0=A0=A0 delete mode 100644 sample/sample-keys/ec-ca.key<b=
r>
      &gt;=A0=A0=A0=A0=A0 delete mode 100644 sample/sample-keys/ec-client.c=
rt<br>
      &gt;=A0=A0=A0=A0=A0 delete mode 100644 sample/sample-keys/ec-client.k=
ey<br>
      &gt;=A0=A0=A0=A0=A0 delete mode 100644 sample/sample-keys/ec-server.c=
rt<br>
      &gt;=A0=A0=A0=A0=A0 delete mode 100644 sample/sample-keys/ec-server.k=
ey<br>
      &gt;=A0=A0=A0=A0=A0 create mode 100755 sample/sample-keys/gen-sample-=
keys.sh<br>
      &gt;=A0=A0=A0=A0=A0 create mode 100644 sample/sample-keys/openssl.cnf=
<br>
      &gt;=A0=A0=A0=A0=A0 delete mode 100644 sample/sample-keys/pass.crt<br>
      &gt;=A0=A0=A0=A0=A0 delete mode 100644 sample/sample-keys/pass.key<br>
      &gt;=A0=A0=A0=A0=A0 delete mode 100644 sample/sample-keys/pkcs12.p12<=
br>
      &gt;=A0=A0=A0=A0=A0 create mode 100644 sample/sample-keys/server-ec.c=
rt<br>
      &gt;=A0=A0=A0=A0=A0 create mode 100644 sample/sample-keys/server-ec.k=
ey<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-config-files/client.conf
      b/sample/sample-config-files/client.conf<br>
      &gt;=A0=A0=A0=A0 index 58b2038..050ef60 100644<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-config-files/client.conf<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-config-files/client.conf<br>
      &gt;=A0=A0=A0=A0 @@ -89,18 +89,19 @@ ca ca.crt<br>
      &gt;=A0=A0=A0=A0=A0 cert client.crt<br>
      &gt;=A0=A0=A0=A0=A0 key client.key<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0 -# Verify server certificate by checking<br>
      &gt;=A0=A0=A0=A0 -# that the certicate has the nsCertType<br>
      &gt;=A0=A0=A0=A0 -# field set to "server".=A0 This is an<br>
      &gt;=A0=A0=A0=A0 -# important precaution to protect against<br>
      &gt;=A0=A0=A0=A0 +# Verify server certificate by checking that the<br>
      &gt;=A0=A0=A0=A0 +# certicate has the correct key usage set.<br>
      &gt;=A0=A0=A0=A0 +# This is an important precaution to protect agains=
t<br>
      &gt;=A0=A0=A0=A0=A0 # a potential attack discussed here:<br>
      &gt;=A0=A0=A0=A0=A0 #=A0 <a class=3D"moz-txt-link-freetext" href=3D"h=
ttp://openvpn.net/howto.html#mitm">http://openvpn.net/howto.html#mitm</a><b=
r>
      &gt;=A0=A0=A0=A0=A0 #<br>
      &gt;=A0=A0=A0=A0=A0 # To use this feature, you will need to generate<=
br>
      &gt;=A0=A0=A0=A0 -# your server certificates with the nsCertType<br>
      &gt;=A0=A0=A0=A0 -# field set to "server".=A0 The build-key-server<br>
      &gt;=A0=A0=A0=A0 -# script in the easy-rsa folder will do this.<br>
      &gt;=A0=A0=A0=A0 -ns-cert-type server<br>
      &gt;=A0=A0=A0=A0 +# your server certificates with the keyUsage set to=
<br>
      &gt;=A0=A0=A0=A0 +#=A0=A0 digitalSignature, keyEncipherment<br>
      &gt;=A0=A0=A0=A0 +# and the extendedKeyUsage to<br>
      &gt;=A0=A0=A0=A0 +#=A0=A0 serverAuth<br>
      &gt;=A0=A0=A0=A0 +# EasyRSA can do this for you.<br>
      &gt;=A0=A0=A0=A0 +remote-cert-tls server<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0=A0 # If a tls-auth key is used on the server<br>
      &gt;=A0=A0=A0=A0=A0 # then every client must also have the key.<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-config-files/loopback-cli=
ent
      b/sample/sample-config-files/loopback-client<br>
      &gt;=A0=A0=A0=A0 index d7f59e6..ebbd1cf 100644<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-config-files/loopback-client<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-config-files/loopback-client<br>
      &gt;=A0=A0=A0=A0 @@ -17,9 +17,9 @@ dev null<br>
      &gt;=A0=A0=A0=A0=A0 verb 3<br>
      &gt;=A0=A0=A0=A0=A0 reneg-sec 10<br>
      &gt;=A0=A0=A0=A0=A0 tls-client<br>
      &gt;=A0=A0=A0=A0 +remote-cert-tls server<br>
      &gt;=A0=A0=A0=A0=A0 ca sample-keys/ca.crt<br>
      &gt;=A0=A0=A0=A0=A0 key sample-keys/client.key<br>
      &gt;=A0=A0=A0=A0=A0 cert sample-keys/client.crt<br>
      &gt;=A0=A0=A0=A0 -cipher DES-EDE3-CBC<br>
      &gt;=A0=A0=A0=A0=A0 ping 1<br>
      &gt;=A0=A0=A0=A0=A0 inactive 120 10000000<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-config-files/loopback-ser=
ver
      b/sample/sample-config-files/loopback-server<br>
      &gt;=A0=A0=A0=A0 index 9d21bce..8cb97be 100644<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-config-files/loopback-server<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-config-files/loopback-server<br>
      &gt;=A0=A0=A0=A0 @@ -17,10 +17,9 @@ dev null<br>
      &gt;=A0=A0=A0=A0=A0 verb 3<br>
      &gt;=A0=A0=A0=A0=A0 reneg-sec 10<br>
      &gt;=A0=A0=A0=A0=A0 tls-server<br>
      &gt;=A0=A0=A0=A0 -dh sample-keys/dh1024.pem<br>
      &gt;=A0=A0=A0=A0 +dh sample-keys/dh2048.pem<br>
      &gt;=A0=A0=A0=A0=A0 ca sample-keys/ca.crt<br>
      &gt;=A0=A0=A0=A0=A0 key sample-keys/server.key<br>
      &gt;=A0=A0=A0=A0=A0 cert sample-keys/server.crt<br>
      &gt;=A0=A0=A0=A0 -cipher DES-EDE3-CBC<br>
      &gt;=A0=A0=A0=A0=A0 ping 1<br>
      &gt;=A0=A0=A0=A0=A0 inactive 120 10000000<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-config-files/server.conf
      b/sample/sample-config-files/server.conf<br>
      &gt;=A0=A0=A0=A0 index 467d5b8..701be3c 100644<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-config-files/server.conf<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-config-files/server.conf<br>
      &gt;=A0=A0=A0=A0 @@ -81,10 +81,8 @@ key server.key=A0 # This file sho=
uld be
      kept secret<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0=A0 # Diffie hellman parameters.<br>
      &gt;=A0=A0=A0=A0=A0 # Generate your own with:<br>
      &gt;=A0=A0=A0=A0 -#=A0=A0 openssl dhparam -out dh1024.pem 1024<br>
      &gt;=A0=A0=A0=A0 -# Substitute 2048 for 1024 if you are using<br>
      &gt;=A0=A0=A0=A0 -# 2048 bit keys.<br>
      &gt;=A0=A0=A0=A0 -dh dh1024.pem<br>
      &gt;=A0=A0=A0=A0 +#=A0=A0 openssl dhparam -out dh2048.pem 2048<br>
      &gt;=A0=A0=A0=A0 +dh dh2048.pem<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0=A0 # Network topology<br>
      &gt;=A0=A0=A0=A0=A0 # Should be subnet (addressing via IP)<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-config-files/tls-office.c=
onf
      b/sample/sample-config-files/tls-office.conf<br>
      &gt;=A0=A0=A0=A0 index f790f46..d196144 100644<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-config-files/tls-office.conf<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-config-files/tls-office.conf<br>
      &gt;=A0=A0=A0=A0 @@ -26,7 +26,7 @@ up ./office.up<br>
      &gt;=A0=A0=A0=A0=A0 tls-server<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0=A0 # Diffie-Hellman Parameters (tls-server only)<br>
      &gt;=A0=A0=A0=A0 -dh dh1024.pem<br>
      &gt;=A0=A0=A0=A0 +dh dh2048.pem<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0=A0 # Certificate Authority file<br>
      &gt;=A0=A0=A0=A0=A0 ca my-ca.crt<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/.gitignore
      b/sample/sample-keys/.gitignore<br>
      &gt;=A0=A0=A0=A0 new file mode 100644<br>
      &gt;=A0=A0=A0=A0 index 0000000..f148752<br>
      &gt;=A0=A0=A0=A0 --- /dev/null<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/.gitignore<br>
      &gt;=A0=A0=A0=A0 @@ -0,0 +1 @@<br>
      &gt;=A0=A0=A0=A0 +sample-ca/<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/README
      b/sample/sample-keys/README<br>
      &gt;=A0=A0=A0=A0 index 9f4f918..66dd945 100644<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/README<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/README<br>
      &gt;=A0=A0=A0=A0 @@ -1,14 +1,19 @@<br>
      &gt;=A0=A0=A0=A0=A0 Sample RSA and EC keys.<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0 +Run ./gen-sample-keys.sh to generate fresh test key=
s.<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0=A0 See the examples section of the man page for usage
      examples.<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0=A0 NOTE: THESE KEYS ARE FOR TESTING PURPOSES ONLY.<b=
r>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DON'T USE THEM FOR ANY REAL WOR=
K BECAUSE<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 THEY ARE TOTALLY INSECURE!<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0 -ca.{crt,key}=A0=A0=A0=A0 -- sample CA key/cert<br>
      &gt;=A0=A0=A0=A0 -client.{crt,key} -- sample client key/cert<br>
      &gt;=A0=A0=A0=A0 -server.{crt,key} -- sample server key/cert
      (nsCertType=3Dserver)<br>
      &gt;=A0=A0=A0=A0 -pass.{crt,key}=A0=A0 -- sample client key/cert with
      password-encrypted key<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 password =3D "password"<br>
      &gt;=A0=A0=A0=A0 -ec-*.{crt,key}=A0=A0 -- sample elliptic curve varia=
nts of
      the above<br>
      &gt;=A0=A0=A0=A0 +ca.{crt,key}=A0=A0=A0=A0=A0=A0=A0 -- sample CA key/=
cert<br>
      &gt;=A0=A0=A0=A0 +server.{crt,key}=A0=A0=A0 -- sample server key/cert=
<br>
      &gt;=A0=A0=A0=A0 +client.{crt,key}=A0=A0=A0 -- sample client key/cert=
<br>
      &gt;=A0=A0=A0=A0 +client-pass.key=A0=A0=A0=A0 -- sample client key wi=
th
      password-encrypted key<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 password =3D "password"<br>
      &gt;=A0=A0=A0=A0 +client.p12=A0=A0=A0=A0=A0=A0=A0=A0=A0 -- sample cli=
ent pkcs12 bundle<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 password =3D "password"<br>
      &gt;=A0=A0=A0=A0 +client-ec.{crt,key} -- sample elliptic curve client
      key/cert<br>
      &gt;=A0=A0=A0=A0 +server-ec.{crt,key} -- sample elliptic curve server
      key/cert<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/ca.crt
      b/sample/sample-keys/ca.crt<br>
      &gt;=A0=A0=A0=A0 index e063ccc..a11bafa 100644<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/ca.crt<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/ca.crt<br>
      &gt;=A0=A0=A0=A0 @@ -1,19 +1,35 @@<br>
      &gt;=A0=A0=A0=A0=A0 -----BEGIN CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0
      -MIIDBjCCAm+gAwIBAgIBADANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL<br>
      &gt;=A0=A0=A0=A0
      +MIIGKDCCBBCgAwIBAgIJAKFO3vqQ8q6BMA0GCSqGSIb3DQEBCwUAMGYxCzAJBgNV<br>
      &gt;=A0=A0=A0=A0
      +BAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMM<br>
      &gt;=A0=A0=A0=A0
      +T3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4w<br>
      &gt;=A0=A0=A0=A0
      +HhcNMTQxMDIyMjE1OTUyWhcNMjQxMDE5MjE1OTUyWjBmMQswCQYDVQQGEwJLRzEL<br>
      &gt;=A0=A0=A0=A0=A0
      MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t<br>
      &gt;=A0=A0=A0=A0
      -VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy<br>
      &gt;=A0=A0=A0=A0
      -NTE0NDA1NVoXDTE0MTEyMzE0NDA1NVowZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
      &gt;=A0=A0=A0=A0
      -Ak5BMRAwDgYDVQQHEwdCSVNIS0VLMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxITAf<br>
      &gt;=A0=A0=A0=A0
      -BgkqhkiG9w0BCQEWEm1lQG15aG9zdC5teWRvbWFpbjCBnzANBgkqhkiG9w0BAQEF<br>
      &gt;=A0=A0=A0=A0
      -AAOBjQAwgYkCgYEAqPjWJnesPu6bR/iec4FMz3opVaPdBHxg+ORKNmrnVZPh0t8/<br>
      &gt;=A0=A0=A0=A0
      -ZT34KXkYoI9B82scurp8UlZVXG8JdUsz+yai8ti9+g7vcuyKUtcCIjn0HLgmdPu5<br>
      &gt;=A0=A0=A0=A0
      -gFX25lB0pXw+XIU031dOfPvtROdG5YZN5yCErgCy7TE7zntLnkEDuRmyU6cCAwEA<br>
      &gt;=A0=A0=A0=A0
      -AaOBwzCBwDAdBgNVHQ4EFgQUiaZg47rqPq/8ZH9MvYzSSI3gzEYwgZAGA1UdIwSB<br>
      &gt;=A0=A0=A0=A0
      -iDCBhYAUiaZg47rqPq/8ZH9MvYzSSI3gzEahaqRoMGYxCzAJBgNVBAYTAktHMQsw<br>
      &gt;=A0=A0=A0=A0
      -CQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMMT3BlblZQTi1U<br>
      &gt;=A0=A0=A0=A0
      -RVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CAQAwDAYDVR0T<br>
      &gt;=A0=A0=A0=A0
      -BAUwAwEB/zANBgkqhkiG9w0BAQQFAAOBgQBfJoiWYrYdjM0mKPEzUQk0nLYTovBP<br>
      &gt;=A0=A0=A0=A0
      -I0es/2rfGrin1zbcFY+4dhVBd1E/StebnG+CP8r7QeEIwu7x8gYDdOLLsZn+2vBL<br>
      &gt;=A0=A0=A0=A0
      -e4jNU1ClI6Q0L7jrzhhunQ5mAaZztVyYwFB15odYcdN2iO0tP7jtEsvrRqxICNy3<br>
      &gt;=A0=A0=A0=A0 -8itzViPTf5W4sA=3D=3D<br>
      &gt;=A0=A0=A0=A0
      +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMIICIjANBgkq<br>
      &gt;=A0=A0=A0=A0
      +hkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAsJVPCqt3vtoDW2U0DII1QIh2Qs0dqh88<br>
      &gt;=A0=A0=A0=A0
      +8nivxAIm2LTq93e9fJhsq3P/UVYAYSeCIrekXypR0EQgSgcNTvGBMe20BoHO5yvb<br>
      &gt;=A0=A0=A0=A0
      +GjKPmjfLj6XRotCOGy8EDl/hLgRY9efiA8wsVfuvF2q/FblyJQPR/gPiDtTmUiqF<br>
      &gt;=A0=A0=A0=A0
      +qXa7AJmMrqFsnWppOuGd7Qc6aTsae4TF1e/gUTCTraa7NeHowDaKhdyFmEEnCYR5<br>
      &gt;=A0=A0=A0=A0
      +CeUsx2JlFWAH8PCrxBpHYbmGyvS0kH3+rQkaSM/Pzc2bS4ayHaOYRK5XsGq8XiNG<br>
      &gt;=A0=A0=A0=A0
      +KTTLnSaCdPeHsI+3xMHmEh+u5Og2DFGgvyD22gde6W2ezvEKCUDrzR7bsnYqqyUy<br>
      &gt;=A0=A0=A0=A0
      +n7LxnkPXGyvR52T06G8KzLKQRmDlPIXhzKMO07qkHmIonXTdF7YI1azwHpAtN4dS<br>
      &gt;=A0=A0=A0=A0
      +rUe1bvjiTSoEsQPfOAyvD0RMK/CBfgEZUzAB50e/IlbZ84c0DJfUMOm4xCyft1HF<br>
      &gt;=A0=A0=A0=A0
      +YpYeyCf5dxoIjweCPOoP426+aTXM7kqq0ieIr6YxnKV6OGGLKEY+VNZh1DS7enqV<br>
      &gt;=A0=A0=A0=A0
      +HP5i8eimyuUYPoQhbK9xtDGMgghnc6Hn8BldPMcvz98HdTEH4rBfA3yNuCxLSNow<br>
      &gt;=A0=A0=A0=A0
      +4jJuLjNXh2QeiUtWtkXja7ec+P7VqKTduJoRaX7cs+8E3ImigiRnvmK+npk7Nt1y<br>
      &gt;=A0=A0=A0=A0
      +YE9hBRhSoLsCAwEAAaOB2DCB1TAdBgNVHQ4EFgQUK0DlyX319JY46S/jL9lAZMmO<br>
      &gt;=A0=A0=A0=A0
      +BZswgZgGA1UdIwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRoMGYxCzAJ<br>
      &gt;=A0=A0=A0=A0
      +BgNVBAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UE<br>
      &gt;=A0=A0=A0=A0
      +ChMMT3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21h<br>
      &gt;=A0=A0=A0=A0
      +aW6CCQChTt76kPKugTAMBgNVHRMEBTADAQH/MAsGA1UdDwQEAwIBBjANBgkqhkiG<br>
      &gt;=A0=A0=A0=A0
      +9w0BAQsFAAOCAgEABc77f4C4P8fIS+V8qCJmVNSDU44UZBc+D+J6ZTgW8JeOHUIj<br>
      &gt;=A0=A0=A0=A0
      +Bh++XDg3gwat7pIWQ8AU5R7h+fpBI9n3dadyIsMHGwSogHY9Gw7di2RVtSFajEth<br>
      &gt;=A0=A0=A0=A0
      +rvrq0JbzpwoYedMh84sJ2qI/DGKW9/Is9+O52fR+3z3dY3gNRDPQ5675BQ5CQW9I<br>
      &gt;=A0=A0=A0=A0
      +AJgLOqzD8Q0qrXYi7HaEqzNx6p7RDTuhFgvTd+vS5d5+28Z5fm2umnq+GKHF8W5P<br>
      &gt;=A0=A0=A0=A0
      +ylp2Js119FTVO7brusAMKPe5emc7tC2ov8OFFemQvfHR41PLryap2VD81IOgmt/J<br>
      &gt;=A0=A0=A0=A0
      +kX/j/y5KGux5HZ3lxXqdJbKcAq4NKYQT0mCkRD4l6szaCEJ+k0SiM9DdTcBDefhR<br>
      &gt;=A0=A0=A0=A0
      +9q+pCOyMh7d8QjQ1075mF7T+PGkZQUW1DUjEfrZhICnKgq+iEoUmM0Ee5WtRqcnu<br>
      &gt;=A0=A0=A0=A0
      +5BTGQ2mSfc6rV+Vr+eYXqcg7Nxb3vFXYSTod1UhefonVqwdmyJ2sC79zp36Tbo2+<br>
      &gt;=A0=A0=A0=A0
      +65NW2WJK7KzPUyOJU0U9bcu0utvDOvGWmG+aHbymJgcoFzvZmlXqMXn97pSFn4jV<br>
      &gt;=A0=A0=A0=A0
      +y3SLRgJXOw1QLXL2Y5abcuoBVr4gCOxxk2vBeVxOMRXNqSWZOFIF1bu/PxuDA+Sa<br>
      &gt;=A0=A0=A0=A0
      +hEi44aHbPXt9opdssz/hdGfd8Wo7vEJrbg7c6zR6C/Akav1Rzy9oohIdgOw=3D<br>
      &gt;=A0=A0=A0=A0=A0 -----END CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/ca.key
      b/sample/sample-keys/ca.key<br>
      &gt;=A0=A0=A0=A0 index b4bf792..8b11bc2 100644<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/ca.key<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/ca.key<br>
      &gt;=A0=A0=A0=A0 @@ -1,15 +1,52 @@<br>
      &gt;=A0=A0=A0=A0 ------BEGIN RSA PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0
      -MIICXQIBAAKBgQCo+NYmd6w+7ptH+J5zgUzPeilVo90EfGD45Eo2audVk+HS3z9l<br>
      &gt;=A0=A0=A0=A0
      -PfgpeRigj0Hzaxy6unxSVlVcbwl1SzP7JqLy2L36Du9y7IpS1wIiOfQcuCZ0+7mA<br>
      &gt;=A0=A0=A0=A0
      -VfbmUHSlfD5chTTfV058++1E50blhk3nIISuALLtMTvOe0ueQQO5GbJTpwIDAQAB<br>
      &gt;=A0=A0=A0=A0
      -AoGAQuVREyWp4bhhbZr2UFBOco2ws6EOLWp4kdD/uI+WSoEjlHKiDJj+GJ1CrL5K<br>
      &gt;=A0=A0=A0=A0
      -o+4yD5MpCQf4/4FOQ0ukprfjJpDwDinTG6vzuWSLTHNiTgvksW3vy7IsNMJx97hT<br>
      &gt;=A0=A0=A0=A0
      -4D2QOOl9HhA50Qqg70teMPYXOgLRMVsdCIV7p7zDNy4nM+ECQQDX8m5ZcQmPtUDA<br>
      &gt;=A0=A0=A0=A0
      -38dPTfpL4U7kMB94FItJYH/Lk5kMW1/J33xymNhL+BHaG064ol9n2ubGW4XEO5t2<br>
      &gt;=A0=A0=A0=A0
      -qE1IOsVpAkEAyE/x/OBVSI1s75aYGlEwMd87p3qaDdtXT7WzujjRY7r8Y1ynkMU6<br>
      &gt;=A0=A0=A0=A0
      -GtMeneBX/lk4BY/6I+5bhAzce+hqhaXejwJBAL5Wg+c4GApf41xdogqHm7doNyYw<br>
      &gt;=A0=A0=A0=A0
      -OHyZ9w9NDDc+uGbI30xLPSCxEe0cEXgiG6foDpm2uzRZFTWaqHPU8pFYpAkCQGNX<br>
      &gt;=A0=A0=A0=A0
      -cpWM0/7VVK9Fqk1y8knpgfY/UWOJ4jU/0dCLGR0ywLSuYNPlXDmtdkOp3TnhGW14<br>
      &gt;=A0=A0=A0=A0
      -x/9F2NEWZ8pzq1B4wHUCQQC5ztD4m/rpiIpinoewUJODoeBJXYBKqx1+mdrALCq6<br>
      &gt;=A0=A0=A0=A0 -ESvK1WRiusMaY3xmsdv4J2TB5iUPryELbn3jU12WGcQc<br>
      &gt;=A0=A0=A0=A0 ------END RSA PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 +-----BEGIN PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0
      +MIIJQwIBADANBgkqhkiG9w0BAQEFAASCCS0wggkpAgEAAoICAQCwlU8Kq3e+2gNb<br>
      &gt;=A0=A0=A0=A0
      +ZTQMgjVAiHZCzR2qHzzyeK/EAibYtOr3d718mGyrc/9RVgBhJ4Iit6RfKlHQRCBK<br>
      &gt;=A0=A0=A0=A0
      +Bw1O8YEx7bQGgc7nK9saMo+aN8uPpdGi0I4bLwQOX+EuBFj15+IDzCxV+68Xar8V<br>
      &gt;=A0=A0=A0=A0
      +uXIlA9H+A+IO1OZSKoWpdrsAmYyuoWydamk64Z3tBzppOxp7hMXV7+BRMJOtprs1<br>
      &gt;=A0=A0=A0=A0
      +4ejANoqF3IWYQScJhHkJ5SzHYmUVYAfw8KvEGkdhuYbK9LSQff6tCRpIz8/NzZtL<br>
      &gt;=A0=A0=A0=A0
      +hrIdo5hErlewarxeI0YpNMudJoJ094ewj7fEweYSH67k6DYMUaC/IPbaB17pbZ7O<br>
      &gt;=A0=A0=A0=A0
      +8QoJQOvNHtuydiqrJTKfsvGeQ9cbK9HnZPTobwrMspBGYOU8heHMow7TuqQeYiid<br>
      &gt;=A0=A0=A0=A0
      +dN0XtgjVrPAekC03h1KtR7Vu+OJNKgSxA984DK8PREwr8IF+ARlTMAHnR78iVtnz<br>
      &gt;=A0=A0=A0=A0
      +hzQMl9Qw6bjELJ+3UcVilh7IJ/l3GgiPB4I86g/jbr5pNczuSqrSJ4ivpjGcpXo4<br>
      &gt;=A0=A0=A0=A0
      +YYsoRj5U1mHUNLt6epUc/mLx6KbK5Rg+hCFsr3G0MYyCCGdzoefwGV08xy/P3wd1<br>
      &gt;=A0=A0=A0=A0
      +MQfisF8DfI24LEtI2jDiMm4uM1eHZB6JS1a2ReNrt5z4/tWopN24mhFpftyz7wTc<br>
      &gt;=A0=A0=A0=A0
      +iaKCJGe+Yr6emTs23XJgT2EFGFKguwIDAQABAoICAQCEYPqnihI0PqZjnwQdGIQp<br>
      &gt;=A0=A0=A0=A0
      +g+P8gl7pyY9cS0OhUueicEbyDI8+V9qn0kcmx61zKDY0Jq4QNd6tnlUCijTc6Mot<br>
      &gt;=A0=A0=A0=A0
      +DwF2G1xsC4GvKxZiy89MOkhloanXETEeQZzDbbjvaM4UgL0AHLWPfZQRCjxbKXkE<br>
      &gt;=A0=A0=A0=A0
      +0A5phgvAr2YSvBLHCVXhGN0fScXnwXouVsvgVdGtpcTWdIUa+KrNdQBGDbz6VCkW<br>
      &gt;=A0=A0=A0=A0
      +31I76SQFy40d8PPX6ZjUJHDvnM14LycySO6XOkofRIVnXTqaOUiVBb2VKj5fX+Ro<br>
      &gt;=A0=A0=A0=A0
      +ILdWZz4d6J3RiGXYwyTr4SGVKLjgxWfgUGZB7x+NrqgugNzuaLYrkuWKSEN42nWq<br>
      &gt;=A0=A0=A0=A0
      +yoP6x6xtbAsmB6Fvdqwm/d8BmLhUweaVc0L7AYzXNsOBuT3kubJHMmu3Jv4xgyWk<br>
      &gt;=A0=A0=A0=A0
      +l/MAGJQc7i7QQweGgsYZgR8WlbkWkSFpUcgQBDzDibb6nsD2jnYijQrnrrmiEjEI<br>
      &gt;=A0=A0=A0=A0
      +R7MO551V+nFw9utiM8U9WIWwqzY0d98ujWkGjVe7uz9ZBVyg0DEAEj/zRi9T54aG<br>
      &gt;=A0=A0=A0=A0
      +1V6CB2Cjyw+HzzsDw7yWroWzo4U9YfjbPKCoBsXlqQFLFwY8oL6mEZ7UOobaV1Zl<br>
      &gt;=A0=A0=A0=A0
      +WtuHyYw3UNFxuSGPPyxJkFePIQLLvfKvh2R+V0DrT3UJRoKKlt9RejRSN0tOh0Cm<br>
      &gt;=A0=A0=A0=A0
      +2YD6d7T/DXnQHomIQKhKEQKCAQEA3sgsDg0eKDK8pUyVE+9wW5kql12nTzpBtnCM<br>
      &gt;=A0=A0=A0=A0
      +eg5J9OJcXKhCD/NIyUTIMXoMvZQpLwGUAYLgu4gE04zKWHDouf7MRSFltD5LJ7F2<br>
      &gt;=A0=A0=A0=A0
      +7nuYKHZXk0BhgMhdnQot3FKcOMrKCnZcM+RWX9ZJa8wO6whCaYCw7DtS0SSVODQk<br>
      &gt;=A0=A0=A0=A0
      +9EwAgX6/Hq60V7ujPZJCyNd3o0bIdAA/0AQRTZUADP3AHgUzh71aysYJt+UKt1v0<br>
      &gt;=A0=A0=A0=A0
      +Xc7l6hn7Dn7Ewzpf+WdZ2pV7d3JUSBVKiTDxLV904nDBNOxjMhz0rW01ojR6bzpn<br>
      &gt;=A0=A0=A0=A0
      +XhkFPqnmh+yEYGRgfSAAzkvSsSJEAtBFSicupA/6n83Lo2YvswKCAQEAyumuxP4Z<br>
      &gt;=A0=A0=A0=A0
      +a7s8x8DFba7vuQ+KVxpkKgEz1sxnGRNQJm18/ss/Y5JiaLFYT3E72VkQfBQ2ngu+<br>
      &gt;=A0=A0=A0=A0
      +GrJL3OhiNhzy1KLGS6mrwULtKiuud5MMQDL0Pvkncr9NTy4rBnWzhp2XyPeETu8n<br>
      &gt;=A0=A0=A0=A0
      +JpL2i2OK6lY/lgpBckXuap9gAl0fXk+y+BkZ71OoYaGnKpPjs+Xcq/qgPgZ7O3NW<br>
      &gt;=A0=A0=A0=A0
      +1g+Bd2AVPSxQpXjuy5rgtQURCN733vkNBzFedKREx7Z6l8UPlK/Exuc7BMIHfn5V<br>
      &gt;=A0=A0=A0=A0
      +dd0R3Th+82fkMNVJz6MKmHJ6CJI53M7co/YdAvIkxOFRIPGbO3arL2R69nRgAZBE<br>
      &gt;=A0=A0=A0=A0
      +zLawx1JJTRIG2QKCAQATtZXgMFzopYR3A011FAvWrrhL5+czZS4HG/Hxom38kkIl<br>
      &gt;=A0=A0=A0=A0
      +mGUv0BAybjlf1zJlW0RBelxDvfZv4Nq8dIo6RNLyEY601v2OcqxneJXTB3AwtDeP<br>
      &gt;=A0=A0=A0=A0
      +OXTm1dMiX5IrGcvkYlx5jHsfxCW4GNcqCEWRmYt2lgIRBDaRdjEVZdeXHVo2GqaB<br>
      &gt;=A0=A0=A0=A0
      +6mbeFCWe/t+VsSpOcaauTI9YseNt/66fd5uVjFRAwAnWQqr9b/AAxMvbuMAyc9X4<br>
      &gt;=A0=A0=A0=A0
      +NFLoCrQO9ovGgM8JhD3cmrWbaY8MupM2rU8KhZdJCbLD3ROPpCDo0jvu4TvLjXBt<br>
      &gt;=A0=A0=A0=A0
      +ugkEFh1LNJedqKudLDDkJtTaeJjxvtAnbyeC7zltAoIBAC9TIyzUqq8io0FfZ2x2<br>
      &gt;=A0=A0=A0=A0
      +cXiy9CvuftABKcr+L0l85KOhw5ZVZvpdKNCMFDGrEi9WA28886QWzwbA8Mqb9FP0<br>
      &gt;=A0=A0=A0=A0
      +mnoXYLJC50kSx+ee+nju9dt/RtHtIFM15N0DwosmJnHODZmUiOo0AuiPPCs0UzDm<br>
      &gt;=A0=A0=A0=A0
      +Xrwqtirlvn5ln2nNuEQxyGbuy8qys0HaBvf6OBA8GySNNpRgxJsQAn+4bBSgdzOm<br>
      &gt;=A0=A0=A0=A0
      +Q0TkmKUqASCXBusPvbXmVjCIRiRkL5p4p8z/6+tct0NAqNYqPr80zc/IeKMkyw8P<br>
      &gt;=A0=A0=A0=A0
      ++vucszNXLmBxyp53JEGoiXNAMnH+ca7tchOB5hePTMun3rneWInk0PcB4OcL/QaZ<br>
      &gt;=A0=A0=A0=A0
      +nrkCggEBAN67+SvcWtM1BoLXSz5/apFAE+DicCv94PrvMBOhfvu1oBrElR1rBjiN<br>
      &gt;=A0=A0=A0=A0
      +2B83SktkF4WhCXr10GP+RUpjaqPBtT7NW4r3fL5B8EPsHeabL+pg9e6wG1rH8GqG<br>
      &gt;=A0=A0=A0=A0
      +toWecmfC9uqK7l1A59h5Oveq5K19bZTRZRjQtv2e4KQknlJR6cwy+TGUU5kAUlMt<br>
      &gt;=A0=A0=A0=A0
      +vcivyjzxc0UQwq7zKktJq+xW/TZiSLgd3B32p0sXX378qFUJ4SO2UZ1OCh8R7PY1<br>
      &gt;=A0=A0=A0=A0
      +Fx25K/89Q1yGdbYiXb/Dx0a2WB9rP+b6alMl/dxPdqDKj2QXXkdh8+yvhVpQTyZw<br>
      &gt;=A0=A0=A0=A0 +B1RaqQXwzqrCH0F/vw3lRceYhcQvzcQ=3D<br>
      &gt;=A0=A0=A0=A0 +-----END PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/client-ec.crt
      b/sample/sample-keys/client-ec.crt<br>
      &gt;=A0=A0=A0=A0 new file mode 100644<br>
      &gt;=A0=A0=A0=A0 index 0000000..edc6fe3<br>
      &gt;=A0=A0=A0=A0 --- /dev/null<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/client-ec.crt<br>
      &gt;=A0=A0=A0=A0 @@ -0,0 +1,85 @@<br>
      &gt;=A0=A0=A0=A0 +Certificate:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 Data:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 Version: 3 (0x2)<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 Serial Number: 4 (0x4)<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 Signature Algorithm: sha256WithRSAEncrypt=
ion<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 Issuer: C=3DKG, ST=3DNA, L=3D=
BISHKEK,
      <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:O=3DOpenVPN-TEST=
/emailAddress=3Dme@...430...">O=3DOpenVPN-TEST/emailAddress=3Dme@...430...<=
/a><br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 Validity<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not Before: Oct 2=
2 21:59:53 2014 GMT<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not After : Oct 1=
9 21:59:53 2024 GMT<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 Subject: C=3DKG, ST=3DNA, O=
=3DOpenVPN-TEST,
      <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:CN=3DTest-Client=
-EC/emailAddress=3Dme@...430...">CN=3DTest-Client-EC/emailAddress=3Dme@...1998...=
30...</a><br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 Subject Public Key Info:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Public Key Algori=
thm: id-ecPublicKey<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Publi=
c-Key: (256 bit)<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pub:<=
br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      04:3b:ce:62:5d:6f:87:82:75:24:c2:58:f5:0e:88:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      4d:57:0d:06:b2:71:88:87:58:19:bb:de:5f:7f:52:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      62:51:a2:48:91:83:48:91:90:3e:87:02:0f:15:51:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      f9:68:97:12:0a:fd:d2:3c:87:83:4b:65:54:00:44:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 8d:28:76:49:05<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ASN1 =
OID: secp256k1<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 X509v3 extensions:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Basic Cons=
traints:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CA:FA=
LSE<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Subject Ke=
y Identifier:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      64:F6:49:88:E7:74:C1:AB:A5:FA:4F:2B:71:3C:25:13:3D:C8:94:C5<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Authority =
Key Identifier:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:DirName:/C=3DKG/ST=3DN=
A/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...">DirName:/C=3DKG=
/ST=3DNA/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...</a><br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seria=
l:A1:4E:DE:FA:90:F2:AE:81<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 Signature Algorithm: sha256WithRSAEncrypt=
ion<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      32:3d:f0:08:67:dd:03:73:76:cc:76:52:0a:f6:97:d1:c6:fa:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      5f:d3:e6:28:c9:75:a7:08:a8:34:49:69:cf:eb:ab:da:86:b3:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      2e:65:17:ee:7e:b6:b5:6b:15:0b:dc:11:3a:b9:5a:b3:80:b8:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      bb:f4:6c:cf:88:3a:10:83:7e:10:a0:82:87:6e:06:ec:78:62:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      d4:d1:44:27:dd:2c:19:d8:1a:a1:ae:f4:a0:00:7f:53:5a:40:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      8a:c2:83:77:4b:26:7d:53:b0:d3:0f:2f:7c:28:70:ef:74:58:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      5b:de:81:94:4c:63:19:f0:79:cb:6c:b2:ec:32:1b:4b:e4:62:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      22:4f:ad:ac:4a:6f:a9:6e:c4:2a:8d:8a:88:19:09:fd:88:93:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      3c:27:4d:91:95:ff:57:84:13:fd:4a:68:db:20:df:10:e6:81:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      1d:fd:e7:1d:35:fb:19:02:dd:b5:5f:a0:c1:07:ec:74:b4:ef:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      8b:f9:33:9a:f2:a6:3b:6e:b6:4a:52:ab:5d:99:76:64:62:c4:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      d5:3a:c6:81:8d:eb:c8:4b:02:af:e1:ca:60:e9:8d:c7:a9:2b:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      ea:4f:56:31:d3:9a:11:c2:9c:83:5c:a2:8d:98:fe:cc:a5:ad:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      1f:51:c4:6e:cf:ff:a0:51:64:c8:7f:7f:32:05:4c:8d:7f:bf:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      b8:ed:e5:81:5f:81:bd:1d:9b:3f:8a:83:27:26:b4:69:84:8b:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      e5:d9:ea:fd:08:a8:aa:e4:3a:dc:29:4d:80:6c:13:f7:45:ce:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      92:f2:a9:f3:5f:90:83:d6:23:0f:50:e5:40:09:4c:6b:f2:73:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      aa:d8:49:a7:a9:81:6e:bb:f2:e4:a5:7f:19:39:1d:65:f3:11:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      97:b1:2b:7c:2f:36:77:7f:75:fd:88:44:90:7c:f2:33:8d:cd:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      2c:f6:76:60:33:d3:f4:b3:8c:81:d7:85:89:cc:d7:d5:2c:94:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      a9:31:3f:d3:63:a7:dc:82:3f:0a:d8:c5:71:97:69:3b:c1:69:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      cb:f0:1b:be:15:c0:be:aa:fd:e8:13:2c:0c:3f:72:7b:7d:9c:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      3b:7f:b8:82:36:4b:ad:4d:16:19:b9:1c:b3:2d:d7:5f:8b:f8:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      14:ce:d4:13:e5:82:7a:1d:40:28:08:65:4a:19:d7:7a:35:09:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      db:36:48:4b:96:44:bd:1f:12:b2:39:08:1e:5b:66:25:9b:e0:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      16:d3:79:05:e3:f6:90:da:95:95:33:a1:53:a8:3c:a9:f0:b2:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      f5:d0:aa:80:a0:96:ca:8c:45:62:c2:74:04:91:68:27:fb:e9:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      97:be:3a:87:8a:85:28:2d:6e:a9:60:9b:63:ba:65:98:5e:bb:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0 02:ee:ac:ba:be:f6:42:26<br>
      &gt;=A0=A0=A0=A0 +-----BEGIN CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0
      +MIIESTCCAjGgAwIBAgIBBDANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL<br>
      &gt;=A0=A0=A0=A0
      +MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t<br>
      &gt;=A0=A0=A0=A0
      +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy<br>
      &gt;=A0=A0=A0=A0
      +MjIxNTk1M1oXDTI0MTAxOTIxNTk1M1owbTELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
      &gt;=A0=A0=A0=A0
      +Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFzAVBgNVBAMTDlRlc3QtQ2xpZW50<br>
      &gt;=A0=A0=A0=A0
      +LUVDMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wVjAQBgcqhkjO<br>
      &gt;=A0=A0=A0=A0
      +PQIBBgUrgQQACgNCAAQ7zmJdb4eCdSTCWPUOiE1XDQaycYiHWBm73l9/UmJRokiR<br>
      &gt;=A0=A0=A0=A0
      +g0iRkD6HAg8VUflolxIK/dI8h4NLZVQARI0odkkFo4HIMIHFMAkGA1UdEwQCMAAw<br>
      &gt;=A0=A0=A0=A0
      +HQYDVR0OBBYEFGT2SYjndMGrpfpPK3E8JRM9yJTFMIGYBgNVHSMEgZAwgY2AFCtA<br>
      &gt;=A0=A0=A0=A0
      +5cl99fSWOOkv4y/ZQGTJjgWboWqkaDBmMQswCQYDVQQGEwJLRzELMAkGA1UECBMC<br>
      &gt;=A0=A0=A0=A0
      +TkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4tVEVTVDEhMB8G<br>
      &gt;=A0=A0=A0=A0
      +CSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluggkAoU7e+pDyroEwDQYJKoZI<br>
      &gt;=A0=A0=A0=A0
      +hvcNAQELBQADggIBADI98Ahn3QNzdsx2Ugr2l9HG+l/T5ijJdacIqDRJac/rq9qG<br>
      &gt;=A0=A0=A0=A0
      +sy5lF+5+trVrFQvcETq5WrOAuLv0bM+IOhCDfhCggoduBux4YtTRRCfdLBnYGqGu<br>
      &gt;=A0=A0=A0=A0
      +9KAAf1NaQIrCg3dLJn1TsNMPL3wocO90WFvegZRMYxnwectssuwyG0vkYiJPraxK<br>
      &gt;=A0=A0=A0=A0
      +b6luxCqNiogZCf2IkzwnTZGV/1eEE/1KaNsg3xDmgR395x01+xkC3bVfoMEH7HS0<br>
      &gt;=A0=A0=A0=A0
      +74v5M5rypjtutkpSq12ZdmRixNU6xoGN68hLAq/hymDpjcepK+pPVjHTmhHCnINc<br>
      &gt;=A0=A0=A0=A0
      +oo2Y/sylrR9RxG7P/6BRZMh/fzIFTI1/v7jt5YFfgb0dmz+KgycmtGmEi+XZ6v0I<br>
      &gt;=A0=A0=A0=A0
      +qKrkOtwpTYBsE/dFzpLyqfNfkIPWIw9Q5UAJTGvyc6rYSaepgW678uSlfxk5HWXz<br>
      &gt;=A0=A0=A0=A0
      +EZexK3wvNnd/df2IRJB88jONzSz2dmAz0/SzjIHXhYnM19UslKkxP9Njp9yCPwrY<br>
      &gt;=A0=A0=A0=A0
      +xXGXaTvBacvwG74VwL6q/egTLAw/cnt9nDt/uII2S61NFhm5HLMt11+L+BTO1BPl<br>
      &gt;=A0=A0=A0=A0
      +gnodQCgIZUoZ13o1Cds2SEuWRL0fErI5CB5bZiWb4BbTeQXj9pDalZUzoVOoPKnw<br>
      &gt;=A0=A0=A0=A0
      +svXQqoCglsqMRWLCdASRaCf76Ze+OoeKhSgtbqlgm2O6ZZheuwLurLq+9kIm<br>
      &gt;=A0=A0=A0=A0 +-----END CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/client-ec.key
      b/sample/sample-keys/client-ec.key<br>
      &gt;=A0=A0=A0=A0 new file mode 100644<br>
      &gt;=A0=A0=A0=A0 index 0000000..8131380<br>
      &gt;=A0=A0=A0=A0 --- /dev/null<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/client-ec.key<br>
      &gt;=A0=A0=A0=A0 @@ -0,0 +1,5 @@<br>
      &gt;=A0=A0=A0=A0 +-----BEGIN PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0
      +MIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQg2RVk/d0yok086M9bLPIi<br>
      &gt;=A0=A0=A0=A0
      +eu4DfcBUwphOnkje1/7VSY+hRANCAAQ7zmJdb4eCdSTCWPUOiE1XDQaycYiHWBm7<br>
      &gt;=A0=A0=A0=A0 +3l9/UmJRokiRg0iRkD6HAg8VUflolxIK/dI8h4NLZVQARI0odkk=
F<br>
      &gt;=A0=A0=A0=A0 +-----END PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/client-pass.key
      b/sample/sample-keys/client-pass.key<br>
      &gt;=A0=A0=A0=A0 new file mode 100644<br>
      &gt;=A0=A0=A0=A0 index 0000000..2bb8d4e<br>
      &gt;=A0=A0=A0=A0 --- /dev/null<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/client-pass.key<br>
      &gt;=A0=A0=A0=A0 @@ -0,0 +1,30 @@<br>
      &gt;=A0=A0=A0=A0 +-----BEGIN RSA PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 +Proc-Type: 4,ENCRYPTED<br>
      &gt;=A0=A0=A0=A0 +DEK-Info: AES-256-CBC,ECC1F209896FC2621233FFF6F1FFD=
045<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0
      +i6t7VKTyNNELTvrBO464e02nFg9rvYwumxd0sfqcPtaKmRK2mrZmEd/Xh0Nv1WyB<br>
      &gt;=A0=A0=A0=A0
      +PyuJo78qQixAtxObRbkSNINzTr5C8IDrE6+wQYCJinvO54U0o+ksv0tsyLngz1cb<br>
      &gt;=A0=A0=A0=A0
      +is8ZqHXrRgJ3qGFQWmFRtFKFQvSXOTDX3fLkEB53HfeblQCxBCnJ82Sp7ivnVR/j<br>
      &gt;=A0=A0=A0=A0
      +Q8qQRy1RMbzIN0trEGf0Zi4tHEvXL1u7Y+olQzSlmWWaQt20hhXUOMLhMtlRsAo7<br>
      &gt;=A0=A0=A0=A0
      +AwjlE94JjAfJ1q1dwIcRN4c9Lk8GkiX6w7nDpRACDpk2S8ifCqi69eGe4+g7owhL<br>
      &gt;=A0=A0=A0=A0
      +74bgs64PmM9a2sNXy1v6WE3c/t6sSrZiMvrGsqMo4sBlrQ9WXe0Naon7heBkPcdS<br>
      &gt;=A0=A0=A0=A0
      +px0YJjnyBXHMIH+ASmALSJ5JXq9vt2xRFf0dOsGapxhP+7bZJ5Pwyk/yUu5uHFbM<br>
      &gt;=A0=A0=A0=A0
      +/aBemlrZJzlKeYiiwpwx2whQAtDwN41zMG+r27EzSU/AaDV40NPiwwycpWt/Bp1e<br>
      &gt;=A0=A0=A0=A0
      +z1ag0JuS0an+PK4jmREtzT5U5BeAVM91x8YttOPpmUIpahAa1zwdYPRAIkbmPJ4z<br>
      &gt;=A0=A0=A0=A0
      +ZH+9YoPH4hoBQKdIhshYktjdI++xNiKXAUGUz5YoX8S68SsLdmKvhnQ7fu5VvOkA<br>
      &gt;=A0=A0=A0=A0
      +2pb7taXGy7zfn+a/fWauhuceV9HPlAXMIu3GsssODoNly3vpcFeiMySKppygJ3Eg<br>
      &gt;=A0=A0=A0=A0
      +A3o9n8UepD+jXflKG/R/t7U3hT6LqSIvQWqBqYMEVFMCNzSsJ/ce/4veFvx343zT<br>
      &gt;=A0=A0=A0=A0
      +qdxuzYqyiXM74cynpfqHdVa9SFICTesNdVDI0FdOXhSQ4bHJc7Xp9FFJdS0lMRw4<br>
      &gt;=A0=A0=A0=A0
      +ACwKxvs8lo4Gx1WFyCqH5OxosKtDHQYzdUJfSWVJlhhOFR3GncR9qSe3O5fkhJfs<br>
      &gt;=A0=A0=A0=A0
      +TALnC+xTJyCkSB2k0/bxVLIhlkPdCwzsrN/B6X2CDBdg0mQIo0LaPzGF8VneM20d<br>
      &gt;=A0=A0=A0=A0
      +XebYn751XSiL3HKyq8G5AEFwj9AO3Q8gKuP2fPoWdngJ2GT+mt1m2fIw9Igu39J0<br>
      &gt;=A0=A0=A0=A0
      +ZMegyUN0wSIiA5AkgryK9U+PJEiJmLzOJ/NGr7E5tPF18eZWapK4KZ8TXC4RNiye<br>
      &gt;=A0=A0=A0=A0
      +g+apGa+xZJz2VQp/Mrcdj9D4UDJFQjrvKaS0PXJDoYUXFBoMv3rxijzRVxlhhuJY<br>
      &gt;=A0=A0=A0=A0
      +yZ0At+UqZD5wpuWW6DRrgJIpy0HNhbaLmgsU0Co0HKviB0x8hvMJbi/uCoPTOdPz<br>
      &gt;=A0=A0=A0=A0
      +sPB7CN2i3oXe7xw1HfSTSFWb4leqjlKwNgfV42ox0QUjkkADeeuY+56g/B2+QmdE<br>
      &gt;=A0=A0=A0=A0
      +vXrc6sDwfNUwRUzeMn8yfum/aW1y/wrqF/qPTBQqFd85vlzS+NfXIKDg04cAljTu<br>
      &gt;=A0=A0=A0=A0
      ++2BLzvizh9Bb68iG4PykNXbjbAir1EbQG1tCzq1eKhERjgrxdv6+XqAmvchMCeL5<br>
      &gt;=A0=A0=A0=A0
      +L6hvfQFBPCo/4xnMpU5wooFarO/kGdKlGr5rXOydgfL618Td18BIX+FHQFb3zzVU<br>
      &gt;=A0=A0=A0=A0
      +y2NR4++DslJAZgAU+512zzpW1m3JtaRoyqyoLE2YFPlW804Xc1PBB3Ix6Wyzcegy<br>
      &gt;=A0=A0=A0=A0
      +D4qMk5qxjBkXEsBBSCYfVbWoMBeMhnvxkz0b9wkPtAW/jEJCB2Kkn/5yMC0DkePO<br>
      &gt;=A0=A0=A0=A0 +-----END RSA PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/client.crt
      b/sample/sample-keys/client.crt<br>
      &gt;=A0=A0=A0=A0 index c047446..1744cb2 100644<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/client.crt<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/client.crt<br>
      &gt;=A0=A0=A0=A0 @@ -2,64 +2,102 @@ Certificate:<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0 Data:<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Version: 3 (0x2)<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Serial Number: 2 (0x2)<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Signature Algorithm: md5WithR=
SAEncryption<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 Signature Algorithm: sha256WithRSAEncrypt=
ion<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Issuer: C=3DKG, ST=3DNA, =
L=3DBISHKEK,
      <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:O=3DOpenVPN-TEST=
/emailAddress=3Dme@...430...">O=3DOpenVPN-TEST/emailAddress=3Dme@...430...<=
/a><br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Validity<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not Before: Nov 2=
5 14:46:49 2004 GMT<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not After : Nov 2=
3 14:46:49 2014 GMT<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not Before: Oct 2=
2 21:59:53 2014 GMT<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not After : Oct 1=
9 21:59:53 2024 GMT<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Subject: C=3DKG, ST=3DNA,=
 O=3DOpenVPN-TEST,
      <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:CN=3DTest-Client=
/emailAddress=3Dme@...430...">CN=3DTest-Client/emailAddress=3Dme@...430...<=
/a><br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Subject Public Key Info:<=
br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Public Key Al=
gorithm: rsaEncryption<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RSA Public Key: (=
1024 bit)<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Modul=
us (1024 bit):<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      00:d2:12:5c:c6:4d:13:34:ae:cf:fa:ab:fe:cb:de:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      8c:f1:4b:4a:95:28:60:87:82:2c:b8:c1:e5:8e:c6:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      5d:11:58:61:a4:a5:f1:42:d7:86:74:6c:9d:9c:7a:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      f0:3a:5c:29:e6:53:3b:5e:6d:d8:f0:45:06:2c:23:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      ee:09:bc:02:8f:0e:b8:d5:33:1f:c3:4a:11:02:48:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      0b:cc:4b:ad:6e:74:e0:a2:53:b1:d6:cc:89:b9:e2:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      6f:db:15:b3:19:1e:57:04:79:48:3a:da:76:31:fc:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      bf:d3:34:21:e7:32:d8:9e:06:4e:be:f3:e3:79:b0:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 54:fd:d1:42:32:aa:3e:7a:c1<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Publi=
c-Key: (2048 bit)<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Modul=
us:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      00:ec:65:8f:e9:12:c2:1a:5b:e6:56:2a:08:a9:82:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      3a:2d:44:78:a3:00:3b:b0:9f:e7:27:10:40:93:ef:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      f1:cc:3e:a0:aa:04:a2:80:1b:13:a9:e6:fe:81:d6:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      70:90:a8:d8:d4:de:30:d8:35:00:d2:be:62:f0:48:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      da:fc:15:8d:c4:c6:6d:0b:99:f1:2b:83:00:0a:d3:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      2a:23:0b:e5:cd:f9:35:df:43:61:15:72:ad:95:98:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      f6:73:21:41:5e:a0:dd:47:27:a0:d5:9a:d4:41:a8:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      1c:1d:57:20:71:17:8f:f7:28:9e:3e:07:ce:ec:d5:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      0e:42:4f:1e:74:47:8e:47:9d:d2:14:28:27:2c:14:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      10:f5:d1:96:b5:93:74:84:ef:f9:04:de:8d:4a:6f:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      df:77:ab:ea:d1:58:d3:44:fe:5a:04:01:ff:06:7a:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      97:f7:fd:e3:57:48:e1:f0:df:40:13:9f:66:23:5a:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      e3:55:54:3d:54:39:ee:00:f9:12:f1:d2:df:74:2e:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      ba:d7:f0:8d:c6:dd:18:58:1c:93:22:0b:75:fa:a8:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      d6:e0:b5:2f:2d:b9:d4:fe:b9:4f:86:e2:75:48:16:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      60:fb:3f:c9:b4:30:42:29:fb:3b:b3:2b:b9:59:81:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      6a:46:f3:45:83:bf:fd:d5:1a:ff:37:0c:6f:5b:fd:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 61:f1<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xponent: 65537 (0x10001)<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 extensions:<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Basic =
Constraints:<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
A:FALSE<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Netscape Comment:=
<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 OpenS=
SL Generated Certificate<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Subjec=
t Key Identifier:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      17:B7:3F:C7:62:A0:A9:FD:A4:31:0E:58:D7:D9:94:7B:4B:3F:CB:56<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      D2:B4:36:0F:B1:FC:DD:A5:EA:2A:F7:C7:23:89:FA:E3:FA:7A:44:1D<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Author=
ity Key Identifier:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      keyid:89:A6:60:E3:BA:EA:3E:AF:FC:64:7F:4C:BD:8C:D2:48:8D:E0:CC:46<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:DirName:/C=3DKG/ST=3DN=
A/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...">DirName:/C=3DKG=
/ST=3DNA/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...</a><br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seria=
l:00<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seria=
l:A1:4E:DE:FA:90:F2:AE:81<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0 Signature Algorithm: md5WithRSAEncryption=
<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      61:c6:d1:fa:24:0f:c7:be:09:3b:d8:04:17:63:31:17:07:f9:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      56:99:af:4c:67:fa:db:cb:94:cf:55:a5:7b:16:20:8b:42:64:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      13:23:62:45:28:93:5e:36:f7:db:02:95:a1:e9:fd:e3:0f:8d:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      73:a1:7b:0e:55:78:4d:a5:c4:b7:22:12:a0:ee:55:e0:b8:0e:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      c9:9b:12:e3:b0:ef:9b:68:93:57:6e:6c:ad:16:68:8e:8d:30:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      33:fe:2a:1b:c3:03:8f:b6:0a:2d:0c:b1:3c:bb:f9:58:3f:8c:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      81:59:6b:14:dd:62:b5:c2:93:ed:5d:c6:19:0f:9b:4b:52:b3:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 7c:78<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 Signature Algorithm: sha256WithRSAEncrypt=
ion<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      7f:e0:fe:84:a7:ec:df:62:a5:cd:3c:c1:e6:42:b1:31:12:f0:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      b9:da:a7:9e:3f:bd:96:52:b6:fc:55:74:64:3e:e4:ff:7e:aa:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      f7:3e:06:18:5f:73:85:f8:c8:e0:67:1b:4d:97:ca:05:d0:37:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      07:33:64:9b:e6:78:77:14:9a:55:bb:2a:ac:c3:7f:c9:15:08:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      83:5c:c8:c2:61:d3:71:4c:05:0b:2b:cb:a3:87:6d:a0:32:ed:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      b0:b3:27:97:4a:55:8d:01:2a:30:56:68:ab:f2:da:5c:10:73:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      c9:aa:0a:9c:4b:4c:a0:5b:51:6e:0a:7e:6c:53:80:b0:00:e1:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      1e:9a:4c:0a:37:9e:20:89:bc:c5:e5:79:58:b7:45:ff:d3:c4:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      a1:fd:d9:78:3d:45:16:74:df:82:44:1d:1d:81:50:5a:b9:32:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      4c:e2:4f:3f:0e:3a:65:5a:64:83:3b:29:31:c4:99:88:bc:c5:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      84:39:f2:19:12:e1:66:d0:ea:fb:75:b1:d2:27:be:91:59:a3:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      2b:09:d5:5c:bf:46:8e:d6:67:d6:0b:ec:da:ab:f0:80:19:87:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      64:07:a9:77:b1:5e:0c:e2:c5:1d:6a:ac:5d:23:f3:30:75:36:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      4e:ca:c3:4e:b0:4d:8c:2c:ce:52:61:63:de:d5:f5:ef:ef:0a:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      6b:23:25:26:3c:3a:f2:c3:c2:16:19:3f:a9:32:ba:68:f9:c9:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      12:3c:3e:c6:1f:ff:9b:4e:f4:90:b0:63:f5:d1:33:00:30:5a:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      e8:24:fa:35:44:9b:6a:80:f3:a6:cc:7b:3c:73:5f:50:c4:30:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      71:d8:74:90:27:0a:01:4e:a5:5e:b1:f8:da:c2:61:81:11:ae:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      29:a3:8f:fa:7e:4c:4e:62:b1:00:de:92:e3:8f:6a:2e:da:d9:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      38:5d:6b:7c:0d:e4:01:aa:c8:c6:6d:8b:cd:c0:c8:6e:e4:57:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      21:8a:f6:46:30:d9:ad:51:a1:87:96:a6:53:c9:1e:c6:bb:c3:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      eb:55:fe:8c:d6:5c:d5:c6:f3:ca:b0:60:d2:d4:2a:1f:88:94:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      d3:4c:1a:da:0c:94:fe:c1:5d:0d:2a:db:99:29:5d:f6:dd:16:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      c4:c8:4d:74:9e:80:d9:d0:aa:ed:7b:e3:30:e4:47:d8:f5:15:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      c1:71:b8:c6:fd:ee:fc:9e:b2:5f:b5:b7:92:ed:ff:ca:37:f6:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      c7:82:b4:54:13:9b:83:cd:87:8b:7e:64:f6:2e:54:3a:22:b1:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      c5:c1:f4:a5:25:53:9a:4d:a8:0f:e7:35:4b:89:df:19:83:66:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      64:d9:db:d1:61:2b:24:1b:1d:44:44:fb:49:30:87:b7:49:23:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0 08:02:8a:e0:25:f3:f4:43<br>
      &gt;=A0=A0=A0=A0=A0 -----BEGIN CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0
      -MIIDNTCCAp6gAwIBAgIBAjANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL<br>
      &gt;=A0=A0=A0=A0
      +MIIFFDCCAvygAwIBAgIBAjANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL<br>
      &gt;=A0=A0=A0=A0=A0
      MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t<br>
      &gt;=A0=A0=A0=A0
      -VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy<br>
      &gt;=A0=A0=A0=A0
      -NTE0NDY0OVoXDTE0MTEyMzE0NDY0OVowajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
      &gt;=A0=A0=A0=A0
      +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy<br>
      &gt;=A0=A0=A0=A0
      +MjIxNTk1M1oXDTI0MTAxOTIxNTk1M1owajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
      &gt;=A0=A0=A0=A0=A0
      Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFDASBgNVBAMTC1Rlc3QtQ2xpZW50<br>
      &gt;=A0=A0=A0=A0
      -MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wgZ8wDQYJKoZIhvcN<br>
      &gt;=A0=A0=A0=A0
      -AQEBBQADgY0AMIGJAoGBANISXMZNEzSuz/qr/svejPFLSpUoYIeCLLjB5Y7GXRFY<br>
      &gt;=A0=A0=A0=A0
      -YaSl8ULXhnRsnZx68DpcKeZTO15t2PBFBiwj7gm8Ao8OuNUzH8NKEQJIC8xLrW50<br>
      &gt;=A0=A0=A0=A0
      -4KJTsdbMibnib9sVsxkeVwR5SDradjH8v9M0Iecy2J4GTr7z43mwVP3RQjKqPnrB<br>
      &gt;=A0=A0=A0=A0
      -AgMBAAGjge4wgeswCQYDVR0TBAIwADAsBglghkgBhvhCAQ0EHxYdT3BlblNTTCBH<br>
      &gt;=A0=A0=A0=A0
      -ZW5lcmF0ZWQgQ2VydGlmaWNhdGUwHQYDVR0OBBYEFBe3P8dioKn9pDEOWNfZlHtL<br>
      &gt;=A0=A0=A0=A0
      -P8tWMIGQBgNVHSMEgYgwgYWAFImmYOO66j6v/GR/TL2M0kiN4MxGoWqkaDBmMQsw<br>
      &gt;=A0=A0=A0=A0
      -CQYDVQQGEwJLRzELMAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNV<br>
      &gt;=A0=A0=A0=A0
      -BAoTDE9wZW5WUE4tVEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9t<br>
      &gt;=A0=A0=A0=A0
      -YWluggEAMA0GCSqGSIb3DQEBBAUAA4GBAGHG0fokD8e+CTvYBBdjMRcH+VaZr0xn<br>
      &gt;=A0=A0=A0=A0
      -+tvLlM9VpXsWIItCZBMjYkUok14299sClaHp/eMPjXOhew5VeE2lxLciEqDuVeC4<br>
      &gt;=A0=A0=A0=A0
      -DsmbEuOw75tok1dubK0WaI6NMDP+KhvDA4+2Ci0MsTy7+Vg/jIFZaxTdYrXCk+1d<br>
      &gt;=A0=A0=A0=A0 -xhkPm0tSs3x4<br>
      &gt;=A0=A0=A0=A0
      +MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wggEiMA0GCSqGSIb3<br>
      &gt;=A0=A0=A0=A0
      +DQEBAQUAA4IBDwAwggEKAoIBAQDsZY/pEsIaW+ZWKgipgjotRHijADuwn+cnEECT<br>
      &gt;=A0=A0=A0=A0
      +7/HMPqCqBKKAGxOp5v6B1nCQqNjU3jDYNQDSvmLwSNr8FY3Exm0LmfErgwAK0yoj<br>
      &gt;=A0=A0=A0=A0
      +C+XN+TXfQ2EVcq2VmPZzIUFeoN1HJ6DVmtRBqBwdVyBxF4/3KJ4+B87s1Q5CTx50<br>
      &gt;=A0=A0=A0=A0
      +R45HndIUKCcsFBD10Za1k3SE7/kE3o1Kb993q+rRWNNE/loEAf8Gepf3/eNXSOHw<br>
      &gt;=A0=A0=A0=A0
      +30ATn2YjWuNVVD1UOe4A+RLx0t90LrrX8I3G3RhYHJMiC3X6qNbgtS8tudT+uU+G<br>
      &gt;=A0=A0=A0=A0
      +4nVIFmD7P8m0MEIp+zuzK7lZgWpG80WDv/3VGv83DG9b/WHxAgMBAAGjgcgwgcUw<br>
      &gt;=A0=A0=A0=A0
      +CQYDVR0TBAIwADAdBgNVHQ4EFgQU0rQ2D7H83aXqKvfHI4n64/p6RB0wgZgGA1Ud<br>
      &gt;=A0=A0=A0=A0
      +IwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRoMGYxCzAJBgNVBAYTAktH<br>
      &gt;=A0=A0=A0=A0
      +MQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMMT3BlblZQ<br>
      &gt;=A0=A0=A0=A0
      +Ti1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CCQChTt76<br>
      &gt;=A0=A0=A0=A0
      +kPKugTANBgkqhkiG9w0BAQsFAAOCAgEAf+D+hKfs32KlzTzB5kKxMRLwudqnnj+9<br>
      &gt;=A0=A0=A0=A0
      +llK2/FV0ZD7k/36q9z4GGF9zhfjI4GcbTZfKBdA3BzNkm+Z4dxSaVbsqrMN/yRUI<br>
      &gt;=A0=A0=A0=A0
      +g1zIwmHTcUwFCyvLo4dtoDLtsLMnl0pVjQEqMFZoq/LaXBBzyaoKnEtMoFtRbgp+<br>
      &gt;=A0=A0=A0=A0
      +bFOAsADhHppMCjeeIIm8xeV5WLdF/9PEof3ZeD1FFnTfgkQdHYFQWrkyTOJPPw46<br>
      &gt;=A0=A0=A0=A0
      +ZVpkgzspMcSZiLzFhDnyGRLhZtDq+3Wx0ie+kVmjKwnVXL9GjtZn1gvs2qvwgBmH<br>
      &gt;=A0=A0=A0=A0
      +ZAepd7FeDOLFHWqsXSPzMHU2TsrDTrBNjCzOUmFj3tX17+8KayMlJjw68sPCFhk/<br>
      &gt;=A0=A0=A0=A0
      +qTK6aPnJEjw+xh//m070kLBj9dEzADBa6CT6NUSbaoDzpsx7PHNfUMQwcdh0kCcK<br>
      &gt;=A0=A0=A0=A0
      +AU6lXrH42sJhgRGuKaOP+n5MTmKxAN6S449qLtrZOF1rfA3kAarIxm2LzcDIbuRX<br>
      &gt;=A0=A0=A0=A0
      +IYr2RjDZrVGhh5amU8kexrvD61X+jNZc1cbzyrBg0tQqH4iU00wa2gyU/sFdDSrb<br>
      &gt;=A0=A0=A0=A0
      +mSld9t0WxMhNdJ6A2dCq7XvjMORH2PUVwXG4xv3u/J6yX7W3ku3/yjf2x4K0VBOb<br>
      &gt;=A0=A0=A0=A0
      +g82Hi35k9i5UOiKxxcH0pSVTmk2oD+c1S4nfGYNmZNnb0WErJBsdRET7STCHt0kj<br>
      &gt;=A0=A0=A0=A0 +CAKK4CXz9EM=3D<br>
      &gt;=A0=A0=A0=A0=A0 -----END CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/client.key
      b/sample/sample-keys/client.key<br>
      &gt;=A0=A0=A0=A0 index 17b9509..6d31489 100644<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/client.key<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/client.key<br>
      &gt;=A0=A0=A0=A0 @@ -1,15 +1,28 @@<br>
      &gt;=A0=A0=A0=A0 ------BEGIN RSA PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0
      -MIICXAIBAAKBgQDSElzGTRM0rs/6q/7L3ozxS0qVKGCHgiy4weWOxl0RWGGkpfFC<br>
      &gt;=A0=A0=A0=A0
      -14Z0bJ2cevA6XCnmUztebdjwRQYsI+4JvAKPDrjVMx/DShECSAvMS61udOCiU7HW<br>
      &gt;=A0=A0=A0=A0
      -zIm54m/bFbMZHlcEeUg62nYx/L/TNCHnMtieBk6+8+N5sFT90UIyqj56wQIDAQAB<br>
      &gt;=A0=A0=A0=A0
      -AoGBAK8RoIGekCfym99DYYfTg9A/t/tQeAnWYaDj7oSrKbqf1lgZ91OGPEZgkoVr<br>
      &gt;=A0=A0=A0=A0
      -KzLnxf9uU+bhUs8CJx+4HdO8/L9rAJA+oD9QNuMp0elN4AKuEGE1Eq3a0e3cmgPI<br>
      &gt;=A0=A0=A0=A0
      -+VIoXM6WVAGgK9I03Zu/UerYQ/DdXWGOIsKhFe8qyQoG9pKxAkEA9ld6O9MHQt3d<br>
      &gt;=A0=A0=A0=A0
      -JAjJkgCNn4psozxjrfLWy2huXd3H3CRqGMjLITDGzdkVSgXjHokBYroi0+TZTu4M<br>
      &gt;=A0=A0=A0=A0
      -ulJSJaWwBQJBANpO2DAexH2zRHw5Z6QyeEVxz7B3/FzU4GgJx9BH+FSBh+F0G5Ln<br>
      &gt;=A0=A0=A0=A0
      -ir5Vst8vZ/LGcgpYjHQLNAvZVgUjiQ4Y6I0CQGvwMJL+CHR4GmmroAblTyjU0n1D<br>
      &gt;=A0=A0=A0=A0
      -/Lk/anZ+L73Za7U+D28ErFzCrpmLwRRKOBYtGfpUbOZDpCQ9kj4hy/TLALECQCcL<br>
      &gt;=A0=A0=A0=A0
      -9ysUNbzt9Y/qjJkX1d9F7gn4TBEmmkTBixW76bTjvjQbGlt6Qpyso2O8DPGlgPxM<br>
      &gt;=A0=A0=A0=A0
      -vkJ7RoHgC7y7kGYPGnkCQBVxSNGIjLx4NQBgN4HD0y4+fars1PTUGnckBcS4npb9<br>
      &gt;=A0=A0=A0=A0 -onLNyerBlWdBwbARyBS7WPIbyyf5VCrn3yIqWxaARO0=3D<br>
      &gt;=A0=A0=A0=A0 ------END RSA PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 +-----BEGIN PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0
      +MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDsZY/pEsIaW+ZW<br>
      &gt;=A0=A0=A0=A0
      +KgipgjotRHijADuwn+cnEECT7/HMPqCqBKKAGxOp5v6B1nCQqNjU3jDYNQDSvmLw<br>
      &gt;=A0=A0=A0=A0
      +SNr8FY3Exm0LmfErgwAK0yojC+XN+TXfQ2EVcq2VmPZzIUFeoN1HJ6DVmtRBqBwd<br>
      &gt;=A0=A0=A0=A0
      +VyBxF4/3KJ4+B87s1Q5CTx50R45HndIUKCcsFBD10Za1k3SE7/kE3o1Kb993q+rR<br>
      &gt;=A0=A0=A0=A0
      +WNNE/loEAf8Gepf3/eNXSOHw30ATn2YjWuNVVD1UOe4A+RLx0t90LrrX8I3G3RhY<br>
      &gt;=A0=A0=A0=A0
      +HJMiC3X6qNbgtS8tudT+uU+G4nVIFmD7P8m0MEIp+zuzK7lZgWpG80WDv/3VGv83<br>
      &gt;=A0=A0=A0=A0
      +DG9b/WHxAgMBAAECggEBAIOdaCpUD02trOh8LqZxowJhBOl7z7/ex0uweMPk67LT<br>
      &gt;=A0=A0=A0=A0
      +i5AdVHwOlzwZJ8oSIknoOBEMRBWcLQEojt1JMuL2/R95emzjIKshHHzqZKNulFvB<br>
      &gt;=A0=A0=A0=A0
      +TIUpdnwChTKtH0mqUkLlPU3Ienty4IpNlpmfUKimfbkWHERdBJBHbtDsTABhdo3X<br>
      &gt;=A0=A0=A0=A0
      +9pCF/yRKqJS2Fy/Mkl3gv1y/NB1OL4Jhl7vQbf+kmgfQN2qdOVe2BOKQ8NlPUDmE<br>
      &gt;=A0=A0=A0=A0
      +/1XNIDaE3s6uvUaoFfwowzsCCwN2/8QrRMMKkjvV+lEVtNmQdYxj5Xj5IwS0vkK0<br>
      &gt;=A0=A0=A0=A0
      +6icsngW87cpZxxc1zsRWcSTloy5ohub4FgKhlolmigECgYEA+cBlxzLvaMzMlBQY<br>
      &gt;=A0=A0=A0=A0
      +kCac9KQMvVL+DIFHlZA5i5L/9pRVp4JJwj3GUoehFJoFhsxnKr8HZyLwBKlCmUVm<br>
      &gt;=A0=A0=A0=A0
      +VxnshRWiAU18emUmeAtSGawlAS3QXhikVZDdd/L20YusLT+DXV81wlKR97/r9+17<br>
      &gt;=A0=A0=A0=A0
      +klQOLkSdPm9wcMDOWMNHX8bUg8kCgYEA8k+hQv6+TR/+Beao2IIctFtw/EauaJiJ<br>
      &gt;=A0=A0=A0=A0
      +wW5ql1cpCLPMAOQUvjs0Km3zqctfBF8mUjdkcyJ4uhL9FZtfywY22EtRIXOJ/8VR<br>
      &gt;=A0=A0=A0=A0
      +we65mVo6RLR8YVM54sihanuFOnlyF9LIBWB+9pUfh1/Y7DSebh7W73uxhAxQhi3Y<br>
      &gt;=A0=A0=A0=A0
      +QwfIQIFd8OkCgYBalH4VXhLYhpaYCiXSej6ot6rrK2N6c5Tb2MAWMA1nh+r84tMP<br>
      &gt;=A0=A0=A0=A0
      +gMoh+pDgYPAqMI4mQbxUmqZEeoLuBe6VHpDav7rPECRaW781AJ4ZM4cEQ3Jz/inz<br>
      &gt;=A0=A0=A0=A0
      +4qOAMn10CF081/Ez9ykPPlU0bsYNWHNd4eB2xWnmUBKOwk7UgJatVPaUiQKBgQCI<br>
      &gt;=A0=A0=A0=A0
      +f18CVGpzG9CHFnaK8FCnMNOm6VIaTcNcGY0mD81nv5Dt943P054BQMsAHTY7SjZW<br>
      &gt;=A0=A0=A0=A0
      +HioRyZtkhonXAB2oSqnekh7zzxgv4sG5k3ct8evdBCcE1FNJc2eqikZ0uDETRoOy<br>
      &gt;=A0=A0=A0=A0
      +s7cRxNNr+QxDkyikM+80HOPU1PMPgwfOSrX90GJQ8QKBgEBKohGMV/sNa4t14Iau<br>
      &gt;=A0=A0=A0=A0
      +qO8aagoqh/68K9GFXljsl3/iCSa964HIEREtW09Qz1w3dotEgp2w8bsDa+OwWrLy<br>
      &gt;=A0=A0=A0=A0
      +0SY7T5jRViM3cDWRlUBLrGGiL0FiwsfqiRiji60y19erJgrgyGVIb1kIgIBRkgFM<br>
      &gt;=A0=A0=A0=A0 +2MMweASzTmZcri4PA/5C0HYb<br>
      &gt;=A0=A0=A0=A0 +-----END PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/client.p12
      b/sample/sample-keys/client.p12<br>
      &gt;=A0=A0=A0=A0 new file mode 100644<br>
      &gt;=A0=A0=A0=A0 index
0000000000000000000000000000000000000000..8458c79770a08e832e10205ae1c43e805=
9cca082<br>
      &gt;=A0=A0=A0=A0 GIT binary patch<br>
      &gt;=A0=A0=A0=A0 literal 4533<br>
      &gt;=A0=A0=A0=A0
      zcmV;m5lZebf)TL-0Ru3C5qAa&amp;Duzgg_YDCD0ic2rXas^0WH5peU@(FV7X}F`hDe6=
@<br>
      &gt;=A0=A0=A0=A0
      z4FLxRpn?ntFoFyO0s#Opf(!iy2`Yw2hW8Bt2LUh~1_~;MNQU&lt;f0So~KFb)I=3Do?0=
Gd<br>
      &gt;=A0=A0=A0=A0
      zI2*;=3D0s;sCfPxFqP42^P0Fo+4$NqJRddSJSl#H$YLRhM0*&gt;KZ1!3FrYzVTx;+~&=
lt;9X<br>
      &gt;=A0=A0=A0=A0
zHC&amp;0kC=3DQ)Zxu{oL`xLM;b_oD&gt;(X&amp;8Ta-#O3&amp;p;;Aa3+^0d5fSLOs3&gt;=
{(_@...1940...<br>
      &gt;=A0=A0=A0=A0
z2?mB_IU!{$1Sf&amp;CfNA0|znHybfRqP5blsg?Z{1w#hHzm2WPm@...1941...&gt;~Fs9L`8=
P!8d0*<br>
      &gt;=A0=A0=A0=A0
zf18!wochm&amp;3uJ;eC{gw3d+=3D?v`?TP`azbPA8uS#SvF&gt;zu7QrQ#$t&lt;4KatJksK&=
gt;dI*<br>
      &gt;=A0=A0=A0=A0
      ziMISYR+%EK&lt;vdQWAH_&gt;GJw7P#F#ep~$fBbb6Y*_W)JH+UB%-XoF0lb%KM36b^M=
l3z<br>
      &gt;=A0=A0=A0=A0
      zdI#&gt;W)o{)xhylZ4OHKChQ3@...1942...{v(AQB@...1943...?ARCe`Ss=3DS%-q=
5T5+I3#R#G1YJlYRV<br>
      &gt;=A0=A0=A0=A0
zDTZ`@`U38{@bSL;&gt;xUioK!F94XIBfJNFiIhM&amp;9nvb{1l0O6GqR&amp;cLY4NFEuZS(D=
xH<br>
      &gt;=A0=A0=A0=A0
z=3DW!uJ(?gK8gs^*{5_cl5Z(=3DwW&amp;Q)XqS-~&gt;m0O$kp(m_Cz&gt;zwzHL-IYyDH=3D=
}xGVl+4<br>
      &gt;=A0=A0=A0=A0
      zq3STnMt&lt;?Hu(MKc@...150...}O=3D+SOgwb9ciM@...1944...&gt;7Am$3#DF7{=
7%Lk3imYa+y7?D;AsNHiG<br>
      &gt;=A0=A0=A0=A0
zn&lt;Pk&lt;=3D8L8O8bLSWTRMYjAr147E?9!=3D!8xCjW&amp;Rt}P1G4yKA2el8%Z#!i?O-I=
%bY3u<br>
      &gt;=A0=A0=A0=A0
ze}EeqFzNG`%%2`feCA2|669L4WH3axOzLsnR{2`^v?3Sf&gt;YdO(f@...1615...&lt;&amp;=
g*jh|95N+F<br>
      &gt;=A0=A0=A0=A0
zs_~5PPb?@91h)&amp;uXAR5t`&gt;ZG&gt;Uz4i)rF)c|;osz49745f=3D)!}UDtm5M!ZPf8NH=
f-q<br>
      &gt;=A0=A0=A0=A0
      zBu9VT(aN+vpUdkJ*gO8FPMV2QD1&amp;zIpdi0sGch)W2;I$z%}w_LA6?gziR|D2-^A$=
7<br>
      &gt;=A0=A0=A0=A0
zK+7hz{knM@...1945...{VXU4Jr29-tm$-2M^&gt;mnD_r5Lj&gt;iwRX!&lt;9CFRg<br>
      &gt;=A0=A0=A0=A0
      z9{(YStoDvOuR@(O4i9CiwMU(U-1=3DC!cAqZ-t@...1946...)@bc}<br>
      &gt;=A0=A0=A0=A0
      zgo@...1947...=3DMyVE1)F@...1948...()zN_MxMHwJS(AR3ip3I+3Rm(|=3DOM&am=
p;()I982?Ca-YME*$jcai<br>
      &gt;=A0=A0=A0=A0
z5&gt;TYla+%{gDkflN^F;$b#Qn!EsPXE?fs@...1644...=3DSd&lt;B``&lt;&lt;chZC5b5V=
FKbh2K6kY7?K3;<br>
      &gt;=A0=A0=A0=A0
      zv5_F`(^P~!G1NikPncT9r#;SmMJ@...1949...%Prj#Uc{m7xeQANV0K8+ojXQSMT1t*=
R&amp;uV`S<br>
      &gt;=A0=A0=A0=A0
z-a_ZWh-DQno_e$da&gt;VMjI=3Dw_}8&amp;SK!u012g&gt;$5F;owS&gt;RW$?|5{~rl&amp;=
$f}d%d&gt;$9i<br>
      &gt;=A0=A0=A0=A0
z7(P0*PhMARQef&amp;fdz)sTC&lt;Lxa5`F2&amp;hqQLcJp#ikxf;udtXqUu6cOT-BO(BK`7h=
=3D?<br>
      &gt;=A0=A0=A0=A0
zDbI?zgxg*~0$om9lkR)a-7%wHj&amp;G~`U*39UJOt~jxs$VpQaqb)Y!11&lt;7NJ;nxwK+f<b=
r>
      &gt;=A0=A0=A0=A0
      zimu&gt;$;%$WGWRFUiOQ+WO;A%{B*ZINIEs08%b-Fb1;6M5Z&lt;_`ge4ELfx*V8?Qo?=
OBP<br>
      &gt;=A0=A0=A0=A0
zB&lt;m3&amp;JH7$rGqlacJDUb4J^aF+$1F5Fq1BEWLf~B?AU5ccNREIEhWWFpY~t?SmGZi!<b=
r>
      &gt;=A0=A0=A0=A0
z+_Bv45Wnp@^L9d#ov%dRyPva3GUZyOBKdi&amp;t0zyQ-jp*M&amp;n!&lt;8&gt;?YAsG0gnH=
9&lt;Z0S<br>
      &gt;=A0=A0=A0=A0
      z34D1$5L-hatRI$@6j43xOX~=3DUe!pzJ_)e*2;oPP-Jt%B~H*490;ChZmyCq4v3R}?{<=
br>
      &gt;=A0=A0=A0=A0
zc%U{&amp;f8?Nh&amp;k&gt;6b5g@&gt;h2#}&amp;DOvoiL8%)&lt;~q7ehzHh_`~a2Izn=3D=
bjHq;TkMIoDt-)<br>
      &gt;=A0=A0=A0=A0
      z$u8yg;zHv$;?HL0J6h2aH`EK&gt;az+?|SAZS7*?6)?BsZ8yxec)dO^fx~b|xRBKv@!&=
gt;<br>
      &gt;=A0=A0=A0=A0
      zN|H@...1594...@OZPg_&lt;ybv-HNQS5$N@=3DJ{hvL&lt;!M_~BR7$uR)1P?SUJk^f=
ttz^d1%ND_VN$$<br>
      &gt;=A0=A0=A0=A0
      z28yu4B=3D;NI-W7y*sy2dS6^$EJ{)yWxMf7wfvI_wsZ89XZlK~8n%r4)^eonEw2DGo~<=
br>
      &gt;=A0=A0=A0=A0
      zjKS~WOnU}9sPh2P#+I2oX4TWo2NAs$hrb8{T^kZeI@...1611...}Jtc8o?@wh2ORT%p=
AFfSL4<br>
      &gt;=A0=A0=A0=A0
zF1~~3hhzo^be)F{&gt;Xe6%y9Pyj1HI_jCpGGJ+r}qJ(Qm^(w#q#n4;fGT9J)MId6%;&amp;<b=
r>
      &gt;=A0=A0=A0=A0
      zhPes$n_zQIQ!}^}4G`^Wz7CGC@!ARFDKj^9@...1950...!~Q664CYzu=3D8Ev-yow*f=
p9UOsLHG<br>
      &gt;=A0=A0=A0=A0
      z-BX&lt;D-hZ6KxIA%F5~CWcz|%QmBCt0vMQK#PYY9XsaJ3(}e;=3DlyMTDz8NEu@...1386...=
951...<br>
      &gt;=A0=A0=A0=A0
      zBTx_4BwT-RH%(I350dV3ea|XNP6YEOFyDzqfWrv_j6~`PF4!_puV5C_RkWVl#=3DLzN<=
br>
      &gt;=A0=A0=A0=A0
      zCn~sV+ht*A?D_2ZTy;=3DF_fv8&lt;_4f`NjG$iQJ`jYg1O#mw4EYb0Mh#@$sjRlQkKJ=
Qo<br>
      &gt;=A0=A0=A0=A0
zCbD(tZmv8Qv$&amp;NNhSgU}$`rTnqcvf`wxr^&amp;C&amp;;Fp=3D5Yh`(eE{7KCj6?xingF=
o(wqh<br>
      &gt;=A0=A0=A0=A0
zsvrza+Q&gt;cmrr~=3D}pV&lt;`ImbU@...1952...;g_=3D@...1993...)XeuKL1x92`ruL2r&amp;K(c=
t*Kk@...1953...<br>
      &gt;=A0=A0=A0=A0
      zG_=3D`43h3M^{O*UA{yi2s5fjtWXMOov&gt;#rUwy(A49RjMsrwLLq&gt;wy(A6bJnie=
Jpm*K<br>
      &gt;=A0=A0=A0=A0
      zLL!(_!FKzh-$!YZdEcBK1F(&gt;@we-M9%w^x#=3DH#}9Lc8NQ&lt;BjftBjnh4ar}b3=
i+vXc<br>
      &gt;=A0=A0=A0=A0
z{W&gt;X2580FRsm3z}$v|1;BqjKiO00Ft{;FSiOWy|y=3D&amp;D|&gt;#PfODLKzOym9LWY;M=
#(=3D<br>
      &gt;=A0=A0=A0=A0
z`T4NzCiGy4Je$gf+HwRg2c&lt;5NBvatkd&lt;oeEbqXy8^TV#bM^e&amp;RCYW(w9gO&amp;y=
YjX5?<br>
      &gt;=A0=A0=A0=A0
z%nQKFIXw{H7UJzU&gt;mb+(-NL)S&lt;-&amp;!Jq+i&gt;}L3McC!=3D`WXZgNw}W3)t-k4o9=
(UzHmA<br>
      &gt;=A0=A0=A0=A0
zq`4KU&amp;&amp;3!B$jn*}C9IgPAZDOKa4d3Z!m^&gt;&lt;O=3DW&amp;A+i&gt;_uvW(Gg?=
u{!Zc28~KnlZY|<br>
      &gt;=A0=A0=A0=A0
      zW&gt;&lt;Tb!KwKt8QoTnbcG?7D028`)ggh1eeM8r@...1954...%|k0fBmAmT5c(1mQ=
9lEXQ5OXd?;<br>
      &gt;=A0=A0=A0=A0
      z^CHjw%k!RCxFaT~aUa_d{oq#QOssTE3&lt;rMFyeZ`^PjPynYR_KVSN@...1955...#b=
&gt;Ouf<br>
      &gt;=A0=A0=A0=A0
      zWGfR@...1956...$;AzQkfiya1EQ_&gt;+Bl-?jKt}^_7hPmkxyS@...1957...~^h=
=3D708E3`{=3DWth%v-<br>
      &gt;=A0=A0=A0=A0
z?@iOBIjVj4-#bcG%9d)#)&gt;ITY*E8dBUmpjRV)C+&gt;Jt32pJ`o-1#&gt;e3Um|*mUJl)zl=
<br>
      &gt;=A0=A0=A0=A0
      zzj+A{saen+`EP}bD_BH@...1958...(cb-`Ha9p{rll@#k}4#rAwI;U5&amp;{_(dvPf=
ry4r*OR(g<br>
      &gt;=A0=A0=A0=A0
      zir1=3D%D70&lt;3l-Vmdno7L-k9AWle8;LS6163q{gLq&lt;MLcS_5kCD+V@...1999...=
..)Z4K_T+}0D<br>
      &gt;=A0=A0=A0=A0
      z^did?rKv`zAu@...1960...}c$!y9^Lh|+tz8}+Z%B~F4O}J=3Da=3D6}v&gt;ZK?Wsv=
R6Z`rzHr@&lt;!Tg<br>
      &gt;=A0=A0=A0=A0
      zr!DhMH=3D-r9Uq71K!AtPC3zo{oX3n#EYevQcL9~(v;6h5Pq%J*^gs-6!fq3Gog$&lt;=
8b<br>
      &gt;=A0=A0=A0=A0
z9g5=3DS4zlZ?y%K!&gt;Mc&amp;6F6kj#?qqpe;SHD(h=3D!j(z@^CR=3Di=3DKDGw&gt;Bgok=
qi9zPX(uX<br>
      &gt;=A0=A0=A0=A0
      z|8`K|fAgElC|rkyhB5@...1961...+@}LZAfPl$+hDkByi%)V5=3DIaI1H{6vl7?ZBye=
!AqHLicO<br>
      &gt;=A0=A0=A0=A0
zaCsg%BIm|&gt;MA3R@|GjKRc3d&amp;Xa4bb&gt;L3UelPWRoILk&amp;ICGoo4lwV@...1994...=
...{{fLLaZL&amp;+<br>
      &gt;=A0=A0=A0=A0
      znSPhW04KckjD)a}19&gt;2aT|WH_ltW=3Dy7#46Gu!-xzwtb6TmG$I_MlQkGWG4!7F2!=
_C<br>
      &gt;=A0=A0=A0=A0
      z^ngv5DN5VpziF0tnU2m8BpCW*8j$_TsVU%Wf(C_FTqJpP%DVRx*1n=3DyY6jVZP^~&am=
p;u<br>
      &gt;=A0=A0=A0=A0
      zj+O&lt;-)gVFOKz}2cqLfZKD1W%|44A(?o?C-zVkbOT+V1eU!Th4e58g?qy0IDLgSs@(=
<br>
      &gt;=A0=A0=A0=A0
z&gt;a3QZ_~$!6a_yYA03n@...1963...;&amp;JCvDXIMz74j$40}k$6D5*AIe~-NPq&gt;l=
=3Dp{+`{qB*E<br>
      &gt;=A0=A0=A0=A0
z)dA_uyb!%xms+1|*hgXfvXAI&amp;FoFd^1_&gt;&amp;LNQU&lt;f0S5t~f(0@...1964...(=
0%xf(0rtf(0f9<br>
      &gt;=A0=A0=A0=A0
z3o3?4hW8Bt3&lt;?1Ppn?SMFoFc?FdPO7Duzgg_YDCI0Ru1&amp;1PH71K9D&amp;o|1tss2ml=
0v<br>
      &gt;=A0=A0=A0=A0
z1jw3_VuA6wE@...1965...*qp8m7%=3D&gt;t!ahU6DY&lt;c$m^W{&amp;SL-}Av-!V6Mej({=
Vh^I65-r7&gt;jl<br>
      &gt;=A0=A0=A0=A0
zj#2E$@cqS#ot;itB65=3D}T$c#Fvn6&gt;(Hu7jv5#?nqND^i{&lt;zGDn+bGDInORh%$|&lt;=
TU<br>
      &gt;=A0=A0=A0=A0
z)0ArgXLA;(_k}K_mlCfE0Y&amp;Ec4gxI|biRQj4^q@...1966...&gt;4Z%&gt;zfnT?a?P&g=
t;WmWgPqNu<br>
      &gt;=A0=A0=A0=A0
      zt;=3D6U3*t&gt;n)oqy#bC&lt;px2zJip8afy*7*z$B{ma3e57nY2u4{E__iFC0=3Dvm=
Jwi1VYX<br>
      &gt;=A0=A0=A0=A0
      zJ^u9%A=3DRjf0y-*9fV{WtT;tb1T0|T~;c%SH5qJ2+_GKkn#{LX}MbS`UJ+#@hq#_P@<=
br>
      &gt;=A0=A0=A0=A0
      z=3DVN$u@...1967...|?(z7UQ*UT5!yd!df-`=3D;Pg3G;+}!@XBTK@(XtDanPon_36N=
?ceJ&lt;?w0<br>
      &gt;=A0=A0=A0=A0
      zNK3soS#I5O8%nUS5XWVt%LptQsfi0a{wtPGi{fq;)jwb;5tx!nQZ5RBwItDChWNTA<br>
      &gt;=A0=A0=A0=A0
zj&gt;Fo89J#H&amp;5w(j6)Gb05d4Wuav-;Ae*N4CvCH7Bf7qsT7$-eiNbQFjxma-5lFy&amp;=
Kf<br>
      &gt;=A0=A0=A0=A0
      zuGdIbq=3DSxP#B5y9i$6kWIXa%j=3D^H(Q8&lt;&lt;q_M*`R%ZVP8(B}EBCF@...2000...=
8...?w<br>
      &gt;=A0=A0=A0=A0
      z@...1969...$yFWg(e-HC0;102vJ;ImFQO7@...1970...&lt;i79$sGU(S!1~*(w+q4=
OwO-ox<br>
      &gt;=A0=A0=A0=A0
      zWwM2kH5?dxWXufo3Q9ZIy_U`Ql+5rjkKA=3DC7U__H&lt;)N5z$Rb{}rn?dsvsv@...1386...=
971...=3D&lt;<br>
      &gt;=A0=A0=A0=A0
zU%-OKA3|-2osy2Vwh#)*s+9to&lt;L%b6U5k5Fzx|JW;HHBRq|s|t(&amp;(g4xMFzgvvtbc<b=
r>
      &gt;=A0=A0=A0=A0
      zQ-TBf=3DdLqXp&gt;pKX1|T1Ncg_%F+OOU1K%=3DlJvk25edtPll^?C8iOY4l+gHVw-j=
wS{5<br>
      &gt;=A0=A0=A0=A0
      zc1H%A0AcxAK4?I%10%GT9KyndW;=3DS4Hs$Bt3ppdV?5;*?C+IU&gt;_jrB|%iA@^j-Y=
dr<br>
      &gt;=A0=A0=A0=A0
      zP#Vq!z4lf1B59em!RbNV^|P^F7)gXU({v-B^T{ObdazrO(+w5OWS;WuWNRLYYIn{T<br>
      &gt;=A0=A0=A0=A0
z*P_`Mm4F+5C)d0&amp;C_P&amp;q3l;Vwjmo9lrsR8}rTM}q1!7wAp-KZ++#udhr|@C8HVGgC<=
br>
      &gt;=A0=A0=A0=A0
z^(J(&lt;tv$K47&lt;r2(#bphive7uMRA&amp;}ky@...1972...~lV4``Zu%!1BUIf_Z=3D)*=
`CBf-+5F<br>
      &gt;=A0=A0=A0=A0
zTyVg}@k=3D0bc9s}%M9iRHnOdEO4AU3z0GZg~26X=3D;y_v(F&amp;Px}&amp;8ufGahoEQe_&=
gt;Wa-<br>
      &gt;=A0=A0=A0=A0
zy{M9YD^`ZYTH01LwfQ?{ZuZQ~vaO&amp;Jq$O&amp;~PN%MO(9m%~EMFTMC(A&amp;MRujojT{=
YuB<br>
      &gt;=A0=A0=A0=A0
z`u5e(@~&lt;aXbTu5Xpgn-u0;$_2;&amp;dZV4?%UszI6qIM+zSz-&gt;|Ph&lt;&lt;tw;;-I=
!bhQUfx<br>
      &gt;=A0=A0=A0=A0
      z-T|#dTHlxbD@...1554...~1qB#O+9=3DPN}23-_|*ehcIXa5a)&gt;w_vbRv_LVvmsQ=
hWA5OYqtUvR<br>
      &gt;=A0=A0=A0=A0
      zb2`hE@&gt;8knqkGmwqPuasz=3DMUx2NN7PM|$lkN60Vj_=3D3UYPS&lt;Wb*D(aS{nk=
}POUoch<br>
      &gt;=A0=A0=A0=A0
z5&lt;OVHe&amp;P&lt;YCYq5dQgsKygF+90&gt;r6ZIGje(Qd3rIw(m)l~LebaOD9`;d#2Rt&g=
t;_%?X|<br>
      &gt;=A0=A0=A0=A0
      z;FA9GDiVuwAnk9Bh!BAEfMz{Mdq$b`Xzrmam}W60Fe3&amp;DDuzgg_YDCF6)_eB6jtC=
P<br>
      &gt;=A0=A0=A0=A0
      zdB1(YHnjhMGVV2R_)j7)j4&amp;}UAutIB1uG5%0vZJX1Qaaz-GykChO4Gdh~Eic3wrI=
s<br>
      &gt;=A0=A0=A0=A0 TMJxme++Sbdrv3y90s;sCVF#Wx<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0 literal 0<br>
      &gt;=A0=A0=A0=A0 HcmV?d00001<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/dh1024.pem
      b/sample/sample-keys/dh1024.pem<br>
      &gt;=A0=A0=A0=A0 deleted file mode 100644<br>
      &gt;=A0=A0=A0=A0 index 7ce05f0..0000000<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/dh1024.pem<br>
      &gt;=A0=A0=A0=A0 +++ /dev/null<br>
      &gt;=A0=A0=A0=A0 @@ -1,5 +0,0 @@<br>
      &gt;=A0=A0=A0=A0 ------BEGIN DH PARAMETERS-----<br>
      &gt;=A0=A0=A0=A0
      -MIGHAoGBAJ419DBEOgmQTzo5qXl5fQcN9TN455wkOL7052HzxxRVMyhYmwQcgJvh<br>
      &gt;=A0=A0=A0=A0
      -1sa18fyfR9OiVEMYglOpkqVoGLN7qd5aQNNi5W7/C+VBdHTBJcGZJyyP5B3qcz32<br>
      &gt;=A0=A0=A0=A0 -9mLJKudlVudV0Qxk5qUJaPZ/xupz0NyoVpviuiBOI1gNi8ovSXW=
zAgEC<br>
      &gt;=A0=A0=A0=A0 ------END DH PARAMETERS-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/dh2048.pem
      b/sample/sample-keys/dh2048.pem<br>
      &gt;=A0=A0=A0=A0 new file mode 100644<br>
      &gt;=A0=A0=A0=A0 index 0000000..8eda59a<br>
      &gt;=A0=A0=A0=A0 --- /dev/null<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/dh2048.pem<br>
      &gt;=A0=A0=A0=A0 @@ -0,0 +1,8 @@<br>
      &gt;=A0=A0=A0=A0 +-----BEGIN DH PARAMETERS-----<br>
      &gt;=A0=A0=A0=A0
      +MIIBCAKCAQEArdnA32xujHPlPI+jPffHSoMUZ+b5gRz1H1Lw9//Gugm5TAsRiYrB<br>
      &gt;=A0=A0=A0=A0
      +t2BDSsMKvAjyqN+i5SJv4TOk98kRRKB27iPvyXmiL945VaDQl/UehCySjYlGFUjW<br>
      &gt;=A0=A0=A0=A0
      +9nuo+JwQxeSbw0TLiSYoYJZQ8X1CxPl9mgJl277O4cW1Gc8I/bWa+ipU/4K5wv3h<br>
      &gt;=A0=A0=A0=A0
      +GI8nt+6A0jN3M/KebotMP101G4k0l0qsY4oRMTmP+z3oAP0qU9NZ1jiuMFVzRlNp<br>
      &gt;=A0=A0=A0=A0
      +5FdYF7ctrH+tBF+QmyT4SRKSED4wE4oX6gp420NaBhIEQifIj75wlMDtxQlpkN+x<br>
      &gt;=A0=A0=A0=A0 +QkjsEbPlaPKHGQ4uupssChVUi8IM2yq5EwIBAg=3D=3D<br>
      &gt;=A0=A0=A0=A0 +-----END DH PARAMETERS-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/ec-ca.crt
      b/sample/sample-keys/ec-ca.crt<br>
      &gt;=A0=A0=A0=A0 deleted file mode 100644<br>
      &gt;=A0=A0=A0=A0 index e190801..0000000<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/ec-ca.crt<br>
      &gt;=A0=A0=A0=A0 +++ /dev/null<br>
      &gt;=A0=A0=A0=A0 @@ -1,13 +0,0 @@<br>
      &gt;=A0=A0=A0=A0 ------BEGIN CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0
      -MIIB4jCCAWmgAwIBAgIJALGEGB2g6cAXMAoGCCqGSM49BAMCMBUxEzARBgNVBAMT<br>
      &gt;=A0=A0=A0=A0
      -CkVDLVRlc3QgQ0EwHhcNMTQwMTE4MTYwMTUzWhcNMjQwMTE2MTYwMTUzWjAVMRMw<br>
      &gt;=A0=A0=A0=A0
      -EQYDVQQDEwpFQy1UZXN0IENBMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAE2S4AZT7j<br>
      &gt;=A0=A0=A0=A0
      -ZlPG/CXpT12CzCNSySyKmJt+fWyW/wzbRulVJpGHXRHpZZj2VNOUE72kqGUeshh6<br>
      &gt;=A0=A0=A0=A0
      -Um1o7lHGDSAkHOJpeW5FtryiKhwFc+4dsOCLTNLVFXQsEtY3gY14Uquio4GEMIGB<br>
      &gt;=A0=A0=A0=A0
      -MB0GA1UdDgQWBBS0mkFcuCZ8SLWZRAD/8LpBQcgGPDBFBgNVHSMEPjA8gBS0mkFc<br>
      &gt;=A0=A0=A0=A0
      -uCZ8SLWZRAD/8LpBQcgGPKEZpBcwFTETMBEGA1UEAxMKRUMtVGVzdCBDQYIJALGE<br>
      &gt;=A0=A0=A0=A0
      -GB2g6cAXMAwGA1UdEwQFMAMBAf8wCwYDVR0PBAQDAgEGMAoGCCqGSM49BAMCA2cA<br>
      &gt;=A0=A0=A0=A0
      -MGQCMHWlVTi0xNZstR8ZNH+7z0WlyIXyZe23ne3EXkO0thZLdv86kpxFMPW/llB+<br>
      &gt;=A0=A0=A0=A0
      -RMRKuQIweN97n7FQy5DTenr91U98KDFJ5Av4mDFRL1mkXiu3W1//4XD8yEYDQTRz<br>
      &gt;=A0=A0=A0=A0 -/GARuOLL<br>
      &gt;=A0=A0=A0=A0 ------END CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/ec-ca.key
      b/sample/sample-keys/ec-ca.key<br>
      &gt;=A0=A0=A0=A0 deleted file mode 100644<br>
      &gt;=A0=A0=A0=A0 index 51a72e1..0000000<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/ec-ca.key<br>
      &gt;=A0=A0=A0=A0 +++ /dev/null<br>
      &gt;=A0=A0=A0=A0 @@ -1,6 +0,0 @@<br>
      &gt;=A0=A0=A0=A0 ------BEGIN PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0
      -MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDASU6X/mh2m2PayviL3<br>
      &gt;=A0=A0=A0=A0
      -teoml5soyIUcZfwZpVn6oNtnrLcAbIRsAJbM4xyGVp77G/6hZANiAATZLgBlPuNm<br>
      &gt;=A0=A0=A0=A0
      -U8b8JelPXYLMI1LJLIqYm359bJb/DNtG6VUmkYddEellmPZU05QTvaSoZR6yGHpS<br>
      &gt;=A0=A0=A0=A0 -bWjuUcYNICQc4ml5bkW2vKIqHAVz7h2w4ItM0tUVdCwS1jeBjXh=
Sq6I=3D<br>
      &gt;=A0=A0=A0=A0 ------END PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/ec-client.crt
      b/sample/sample-keys/ec-client.crt<br>
      &gt;=A0=A0=A0=A0 deleted file mode 100644<br>
      &gt;=A0=A0=A0=A0 index b797b02..0000000<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/ec-client.crt<br>
      &gt;=A0=A0=A0=A0 +++ /dev/null<br>
      &gt;=A0=A0=A0=A0 @@ -1,61 +0,0 @@<br>
      &gt;=A0=A0=A0=A0 -Certificate:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0 Data:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Version: 3 (0x2)<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Serial Number: 2 (0x2)<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0 Signature Algorithm: ecdsa-with-SHA256<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Issuer: CN=3DEC-Test CA<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Validity<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not Before: Jan 1=
8 16:02:37 2014 GMT<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not After : Jan 1=
6 16:02:37 2024 GMT<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Subject: CN=3Dec-client<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Subject Public Key Info:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Public Key Algori=
thm: id-ecPublicKey<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Publi=
c-Key: (384 bit)<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pub:<=
br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      04:40:d9:b9:a2:44:1b:01:39:2c:14:ee:aa:70:6b:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      31:98:28:44:c9:61:bc:b7:0b:b5:53:49:c2:c0:0a:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      43:b0:08:50:cd:80:2f:5d:a4:89:f1:ff:7d:11:78:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      f5:0c:b2:86:e2:59:f8:17:76:1b:22:f2:23:67:e7:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      55:90:ea:ce:0a:aa:da:05:f4:85:19:c9:ed:ae:6d:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      a3:ad:56:7a:f6:33:c6:cf:bb:c7:39:fa:e4:d3:67:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 df:f0:b8:4a:88:57:98<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ASN1 =
OID: secp384r1<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 X509v3 extensions:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Basic Cons=
traints:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CA:FA=
LSE<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Subject Ke=
y Identifier:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      D8:E2:35:7B:CA:66:71:6B:D8:5B:F5:12:13:82:2D:ED:CD:E5:ED:7F<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Authority =
Key Identifier:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      keyid:B4:9A:41:5C:B8:26:7C:48:B5:99:44:00:FF:F0:BA:41:41:C8:06:3C<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DirNa=
me:/CN=3DEC-Test CA<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seria=
l:B1:84:18:1D:A0:E9:C0:17<br>
      &gt;=A0=A0=A0=A0 -<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Extended K=
ey Usage:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 TLS W=
eb Client Authentication<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Key Usage:=
<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Digit=
al Signature<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Netscape Comment:=
<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Easy-=
RSA Generated Certificate<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Netscape Cert Typ=
e:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SSL C=
lient<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0 Signature Algorithm: ecdsa-with-SHA256<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0
      30:64:02:30:41:8b:1a:fd:97:a8:bb:7c:d0:eb:1c:a2:ba:c0:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0
      ac:2f:6d:80:07:5b:5c:ef:55:59:1a:92:56:66:94:ce:49:6a:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0
      a9:57:49:b2:41:73:64:7e:01:ac:31:3a:7c:2a:bf:a5:02:30:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0
      2b:c4:a6:b1:0c:03:82:e3:e4:03:39:fb:19:d7:76:21:1b:7e:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0
      7f:aa:22:5d:90:a4:e1:2e:cd:ca:92:0f:b6:3f:80:dc:26:d2:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0 09:34:8c:d1:61:bb:9d:ac:6d=
:8f:68:f0<br>
      &gt;=A0=A0=A0=A0 ------BEGIN CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0
      -MIICLTCCAbSgAwIBAgIBAjAKBggqhkjOPQQDAjAVMRMwEQYDVQQDEwpFQy1UZXN0<br>
      &gt;=A0=A0=A0=A0
      -IENBMB4XDTE0MDExODE2MDIzN1oXDTI0MDExNjE2MDIzN1owFDESMBAGA1UEAxMJ<br>
      &gt;=A0=A0=A0=A0
      -ZWMtY2xpZW50MHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEQNm5okQbATksFO6qcGsx<br>
      &gt;=A0=A0=A0=A0
      -mChEyWG8twu1U0nCwApDsAhQzYAvXaSJ8f99EXj1DLKG4ln4F3YbIvIjZ+dVkOrO<br>
      &gt;=A0=A0=A0=A0
      -CqraBfSFGcntrm2jrVZ69jPGz7vHOfrk02ff8LhKiFeYo4HYMIHVMAkGA1UdEwQC<br>
      &gt;=A0=A0=A0=A0
      -MAAwHQYDVR0OBBYEFNjiNXvKZnFr2Fv1EhOCLe3N5e1/MEUGA1UdIwQ+MDyAFLSa<br>
      &gt;=A0=A0=A0=A0
      -QVy4JnxItZlEAP/wukFByAY8oRmkFzAVMRMwEQYDVQQDEwpFQy1UZXN0IENBggkA<br>
      &gt;=A0=A0=A0=A0
      -sYQYHaDpwBcwEwYDVR0lBAwwCgYIKwYBBQUHAwIwCwYDVR0PBAQDAgeAMC0GCWCG<br>
      &gt;=A0=A0=A0=A0
      -SAGG+EIBDQQgFh5FYXN5LVJTQSBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwEQYJYIZI<br>
      &gt;=A0=A0=A0=A0
      -AYb4QgEBBAQDAgeAMAoGCCqGSM49BAMCA2cAMGQCMEGLGv2XqLt80OscorrArC9t<br>
      &gt;=A0=A0=A0=A0
      -gAdbXO9VWRqSVmaUzklqqVdJskFzZH4BrDE6fCq/pQIwK8SmsQwDguPkAzn7Gdd2<br>
      &gt;=A0=A0=A0=A0 -IRt+f6oiXZCk4S7NypIPtj+A3CbSCTSM0WG7naxtj2jw<br>
      &gt;=A0=A0=A0=A0 ------END CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/ec-client.key
      b/sample/sample-keys/ec-client.key<br>
      &gt;=A0=A0=A0=A0 deleted file mode 100644<br>
      &gt;=A0=A0=A0=A0 index 60636ed..0000000<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/ec-client.key<br>
      &gt;=A0=A0=A0=A0 +++ /dev/null<br>
      &gt;=A0=A0=A0=A0 @@ -1,6 +0,0 @@<br>
      &gt;=A0=A0=A0=A0 ------BEGIN PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0
      -MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDD9Agj8nr/8sIr0XHky<br>
      &gt;=A0=A0=A0=A0
      -mcn1oMb3vqOh2axFBaIvmOHYmqs11SIH1tKYelkNYy9zHTChZANiAARA2bmiRBsB<br>
      &gt;=A0=A0=A0=A0
      -OSwU7qpwazGYKETJYby3C7VTScLACkOwCFDNgC9dpInx/30RePUMsobiWfgXdhsi<br>
      &gt;=A0=A0=A0=A0 -8iNn51WQ6s4KqtoF9IUZye2ubaOtVnr2M8bPu8c5+uTTZ9/wuEq=
IV5g=3D<br>
      &gt;=A0=A0=A0=A0 ------END PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/ec-server.crt
      b/sample/sample-keys/ec-server.crt<br>
      &gt;=A0=A0=A0=A0 deleted file mode 100644<br>
      &gt;=A0=A0=A0=A0 index 9999472..0000000<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/ec-server.crt<br>
      &gt;=A0=A0=A0=A0 +++ /dev/null<br>
      &gt;=A0=A0=A0=A0 @@ -1,61 +0,0 @@<br>
      &gt;=A0=A0=A0=A0 -Certificate:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0 Data:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Version: 3 (0x2)<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Serial Number: 1 (0x1)<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0 Signature Algorithm: ecdsa-with-SHA256<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Issuer: CN=3DEC-Test CA<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Validity<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not Before: Jan 1=
8 16:02:31 2014 GMT<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not After : Jan 1=
6 16:02:31 2024 GMT<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Subject: CN=3Dec-server<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Subject Public Key Info:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Public Key Algori=
thm: id-ecPublicKey<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Publi=
c-Key: (384 bit)<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pub:<=
br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      04:bd:8c:3a:af:2e:2f:2e:de:cf:d2:39:8d:b9:a6:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      13:96:80:6d:b5:b2:ee:97:62:3b:a2:32:38:77:1e:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      fb:2a:ef:86:4b:d0:9e:4b:55:e0:9b:07:f9:64:2f:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      6b:a7:17:fd:65:dd:50:3f:1c:fa:fa:2f:39:2e:97:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      d4:86:e5:4e:5a:d2:50:0b:f4:d7:08:62:67:53:44:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      62:e3:25:f2:fa:36:84:87:1d:03:e3:e9:9d:d9:66:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 51:dd:b4:c4:db:0b:05<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ASN1 =
OID: secp384r1<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 X509v3 extensions:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Basic Cons=
traints:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CA:FA=
LSE<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Subject Ke=
y Identifier:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      EA:DF:7E:A3:D4:61:73:D7:01:AF:6E:0A:38:8D:33:D0:BD:24:4B:E1<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Authority =
Key Identifier:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      keyid:B4:9A:41:5C:B8:26:7C:48:B5:99:44:00:FF:F0:BA:41:41:C8:06:3C<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DirNa=
me:/CN=3DEC-Test CA<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seria=
l:B1:84:18:1D:A0:E9:C0:17<br>
      &gt;=A0=A0=A0=A0 -<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Extended K=
ey Usage:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 TLS W=
eb Server Authentication<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Key Usage:=
<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Digit=
al Signature, Key Encipherment<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Netscape Comment:=
<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Easy-=
RSA Generated Certificate<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Netscape Cert Typ=
e:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SSL S=
erver<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0 Signature Algorithm: ecdsa-with-SHA256<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0
      30:64:02:30:20:39:12:92:cc:a2:ca:45:b9:1a:8f:e0:c1:e7:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0
      b7:4a:79:4d:07:07:81:72:08:b4:d4:7b:46:53:d7:72:32:d0:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0
      d7:3e:e8:88:2b:c9:ba:8b:d5:94:4f:41:6c:d0:2e:a4:02:30:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0
      75:ff:c3:8a:c1:f5:79:1c:1a:08:16:31:c2:c1:6e:d4:33:dc:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0
      9f:04:0f:90:94:d9:75:c1:6d:71:28:62:cc:f6:89:7c:91:86:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0 a4:96:45:34:a0:8d:92:7e:dd=
:e3:da:4d<br>
      &gt;=A0=A0=A0=A0 ------BEGIN CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0
      -MIICLTCCAbSgAwIBAgIBATAKBggqhkjOPQQDAjAVMRMwEQYDVQQDEwpFQy1UZXN0<br>
      &gt;=A0=A0=A0=A0
      -IENBMB4XDTE0MDExODE2MDIzMVoXDTI0MDExNjE2MDIzMVowFDESMBAGA1UEAxMJ<br>
      &gt;=A0=A0=A0=A0
      -ZWMtc2VydmVyMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEvYw6ry4vLt7P0jmNuaYT<br>
      &gt;=A0=A0=A0=A0
      -loBttbLul2I7ojI4dx77Ku+GS9CeS1Xgmwf5ZC9rpxf9Zd1QPxz6+i85LpfUhuVO<br>
      &gt;=A0=A0=A0=A0
      -WtJQC/TXCGJnU0Ri4yXy+jaEhx0D4+md2WZR3bTE2wsFo4HYMIHVMAkGA1UdEwQC<br>
      &gt;=A0=A0=A0=A0
      -MAAwHQYDVR0OBBYEFOrffqPUYXPXAa9uCjiNM9C9JEvhMEUGA1UdIwQ+MDyAFLSa<br>
      &gt;=A0=A0=A0=A0
      -QVy4JnxItZlEAP/wukFByAY8oRmkFzAVMRMwEQYDVQQDEwpFQy1UZXN0IENBggkA<br>
      &gt;=A0=A0=A0=A0
      -sYQYHaDpwBcwEwYDVR0lBAwwCgYIKwYBBQUHAwEwCwYDVR0PBAQDAgWgMC0GCWCG<br>
      &gt;=A0=A0=A0=A0
      -SAGG+EIBDQQgFh5FYXN5LVJTQSBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwEQYJYIZI<br>
      &gt;=A0=A0=A0=A0
      -AYb4QgEBBAQDAgZAMAoGCCqGSM49BAMCA2cAMGQCMCA5EpLMospFuRqP4MHnt0p5<br>
      &gt;=A0=A0=A0=A0
      -TQcHgXIItNR7RlPXcjLQ1z7oiCvJuovVlE9BbNAupAIwdf/DisH1eRwaCBYxwsFu<br>
      &gt;=A0=A0=A0=A0 -1DPcnwQPkJTZdcFtcShizPaJfJGGpJZFNKCNkn7d49pN<br>
      &gt;=A0=A0=A0=A0 ------END CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/ec-server.key
      b/sample/sample-keys/ec-server.key<br>
      &gt;=A0=A0=A0=A0 deleted file mode 100644<br>
      &gt;=A0=A0=A0=A0 index bb3cdf1..0000000<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/ec-server.key<br>
      &gt;=A0=A0=A0=A0 +++ /dev/null<br>
      &gt;=A0=A0=A0=A0 @@ -1,6 +0,0 @@<br>
      &gt;=A0=A0=A0=A0 ------BEGIN PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0
      -MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDD8bQlwrFrXHPmem0bt<br>
      &gt;=A0=A0=A0=A0
      -cBcU6nYfaZQbPdIDAB7edOOyevvzYH0qMtbaW95iSZLMRVWhZANiAAS9jDqvLi8u<br>
      &gt;=A0=A0=A0=A0
      -3s/SOY25phOWgG21su6XYjuiMjh3Hvsq74ZL0J5LVeCbB/lkL2unF/1l3VA/HPr6<br>
      &gt;=A0=A0=A0=A0 -Lzkul9SG5U5a0lAL9NcIYmdTRGLjJfL6NoSHHQPj6Z3ZZlHdtMT=
bCwU=3D<br>
      &gt;=A0=A0=A0=A0 ------END PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/gen-sample-keys.sh
      b/sample/sample-keys/gen-sample-keys.sh<br>
      &gt;=A0=A0=A0=A0 new file mode 100755<br>
      &gt;=A0=A0=A0=A0 index 0000000..87bde1d<br>
      &gt;=A0=A0=A0=A0 --- /dev/null<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/gen-sample-keys.sh<br>
      &gt;=A0=A0=A0=A0 @@ -0,0 +1,74 @@<br>
      &gt;=A0=A0=A0=A0 +#!/bin/sh<br>
      &gt;=A0=A0=A0=A0 +#<br>
      &gt;=A0=A0=A0=A0 +# Run this script to set up a test CA, and test
      key-certificate pair for a<br>
      &gt;=A0=A0=A0=A0 +# server, and various clients.<br>
      &gt;=A0=A0=A0=A0 +#<br>
      &gt;=A0=A0=A0=A0 +# Copyright (C) 2014 Steffan Karger
      &lt;<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:steffan@...1386...=
856...">steffan@...1856...</a> <a class=3D"moz-txt-link-rfc2396E" href=3D"m=
ailto:steffan@...1856...">&lt;mailto:steffan@...1856...&gt;</a>&gt;<br>
      &gt;=A0=A0=A0=A0 +set -eu<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +if [ ! -f openssl.cnf ]<br>
      &gt;=A0=A0=A0=A0 +then<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 echo "Please run this script from the sam=
ple
      directory"<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 exit 1<br>
      &gt;=A0=A0=A0=A0 +fi<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# Create required directories and files<br>
      &gt;=A0=A0=A0=A0 +mkdir -p sample-ca<br>
      &gt;=A0=A0=A0=A0 +rm -f sample-ca/index.txt<br>
      &gt;=A0=A0=A0=A0 +touch sample-ca/index.txt<br>
      &gt;=A0=A0=A0=A0 +echo "01" &gt; sample-ca/serial<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# Generate CA key and cert<br>
      &gt;=A0=A0=A0=A0 +openssl req -new -newkey rsa:4096 -days 3650 -nodes
      -x509 \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -extensions easyrsa_ca -keyout sample-ca/=
ca.key -out
      sample-ca/ca.crt \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -subj
      <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:/C=3DKG/ST=3DNA/L=
=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...">"/C=3DKG/ST=3DNA/L=
=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430..."</a>
      \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -config openssl.cnf<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# Create server key and cert<br>
      &gt;=A0=A0=A0=A0 +openssl req -new -nodes -config openssl.cnf -extens=
ions
      server \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -keyout sample-ca/server.key -out
      sample-ca/server.csr \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -subj
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:/C=3DKG/ST=3DNA/O=3DOpenV=
PN-TEST/CN=3DTest-Server/emailAddress=3Dme@...430...">"/C=3DKG/ST=3DNA/O=3D=
OpenVPN-TEST/CN=3DTest-Server/emailAddress=3Dme@...430..."</a><br>
      &gt;=A0=A0=A0=A0 +openssl ca -batch -config openssl.cnf -extensions s=
erver
      \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -out sample-ca/server.crt -in sample-ca/s=
erver.csr<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# Create client key and cert<br>
      &gt;=A0=A0=A0=A0 +openssl req -new -nodes -config openssl.cnf \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -keyout sample-ca/client.key -out
      sample-ca/client.csr \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -subj
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:/C=3DKG/ST=3DNA/O=3DOpenV=
PN-TEST/CN=3DTest-Client/emailAddress=3Dme@...430...">"/C=3DKG/ST=3DNA/O=3D=
OpenVPN-TEST/CN=3DTest-Client/emailAddress=3Dme@...430..."</a><br>
      &gt;=A0=A0=A0=A0 +openssl ca -batch -config openssl.cnf \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -out sample-ca/client.crt -in sample-ca/c=
lient.csr<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# Create password protected key file<br>
      &gt;=A0=A0=A0=A0 +openssl rsa -aes256 -passout pass:password \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -in sample-ca/client.key -out
      sample-ca/client-pass.key<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# Create pkcs#12 client bundle<br>
      &gt;=A0=A0=A0=A0 +openssl pkcs12 -export -nodes -password pass:passwo=
rd \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -out sample-ca/client.p12 -inkey
      sample-ca/client.key \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -in sample-ca/client.crt -certfile sample=
-ca/ca.crt<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# Create EC server and client cert (signed by 'regu=
lar'
      RSA CA)<br>
      &gt;=A0=A0=A0=A0 +openssl ecparam -out sample-ca/secp256k1.pem -name
      secp256k1<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +openssl req -new -newkey ec:sample-ca/secp256k1.pem
      -nodes -config openssl.cnf \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -extensions server \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -keyout sample-ca/server-ec.key -out
      sample-ca/server-ec.csr \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -subj
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:/C=3DKG/ST=3DNA/O=3DOpenV=
PN-TEST/CN=3DTest-Server-EC/emailAddress=3Dme@...430...">"/C=3DKG/ST=3DNA/O=
=3DOpenVPN-TEST/CN=3DTest-Server-EC/emailAddress=3Dme@...430..."</a><br>
      &gt;=A0=A0=A0=A0 +openssl ca -batch -config openssl.cnf -extensions s=
erver
      \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -out sample-ca/server-ec.crt -in
      sample-ca/server-ec.csr<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +openssl req -new -newkey ec:sample-ca/secp256k1.pem
      -nodes -config openssl.cnf \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -keyout sample-ca/client-ec.key -out
      sample-ca/client-ec.csr \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -subj
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:/C=3DKG/ST=3DNA/O=3DOpenV=
PN-TEST/CN=3DTest-Client-EC/emailAddress=3Dme@...430...">"/C=3DKG/ST=3DNA/O=
=3DOpenVPN-TEST/CN=3DTest-Client-EC/emailAddress=3Dme@...430..."</a><br>
      &gt;=A0=A0=A0=A0 +openssl ca -batch -config openssl.cnf \<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 -out sample-ca/client-ec.crt -in
      sample-ca/client-ec.csr<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# Generate DH parameters<br>
      &gt;=A0=A0=A0=A0 +openssl dhparam -out dh2048.pem 2048<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# Copy keys and certs to working directory<br>
      &gt;=A0=A0=A0=A0 +cp sample-ca/*.key .<br>
      &gt;=A0=A0=A0=A0 +cp sample-ca/*.crt .<br>
      &gt;=A0=A0=A0=A0 +cp sample-ca/*.p12 .<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/openssl.cnf
      b/sample/sample-keys/openssl.cnf<br>
      &gt;=A0=A0=A0=A0 new file mode 100644<br>
      &gt;=A0=A0=A0=A0 index 0000000..aabfd48<br>
      &gt;=A0=A0=A0=A0 --- /dev/null<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/openssl.cnf<br>
      &gt;=A0=A0=A0=A0 @@ -0,0 +1,139 @@<br>
      &gt;=A0=A0=A0=A0 +# Heavily borrowed from EasyRSA 3, for use with Ope=
nSSL
      1.0.*<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0
      +####################################################################=
<br>
      &gt;=A0=A0=A0=A0 +[ ca ]<br>
      &gt;=A0=A0=A0=A0 +default_ca=A0=A0=A0=A0 =3D CA_default=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 # The default ca
      section<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0
      +####################################################################=
<br>
      &gt;=A0=A0=A0=A0 +[ CA_default ]<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +dir=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D sample-ca=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # Where
      everything is kept<br>
      &gt;=A0=A0=A0=A0 +certs=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D $dir=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # Where the
      issued certs are kept<br>
      &gt;=A0=A0=A0=A0 +crl_dir=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D $dir=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # Where
      the issued crl are kept<br>
      &gt;=A0=A0=A0=A0 +database=A0=A0=A0=A0=A0=A0 =3D $dir/index.txt=A0=A0=
=A0=A0=A0=A0=A0 # database index
      file.<br>
      &gt;=A0=A0=A0=A0 +new_certs_dir=A0 =3D $dir=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 # default place
      for new certs.<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +certificate=A0=A0=A0 =3D $dir/ca.crt=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 # The CA
      certificate<br>
      &gt;=A0=A0=A0=A0 +serial=A0=A0=A0=A0=A0=A0=A0=A0 =3D $dir/serial=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 # The current
      serial number<br>
      &gt;=A0=A0=A0=A0 +crl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D $dir/crl.p=
em=A0=A0=A0=A0=A0=A0=A0=A0=A0 # The current CRL<br>
      &gt;=A0=A0=A0=A0 +private_key=A0=A0=A0 =3D $dir/ca.key=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 # The private key<br>
      &gt;=A0=A0=A0=A0 +RANDFILE=A0=A0=A0=A0=A0=A0 =3D $dir/.rand=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 # private random
      number file<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +x509_extensions=A0=A0=A0=A0=A0=A0=A0 =3D basic_exts=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # The
      extentions to add to the cert<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# This allows a V2 CRL. Ancient browsers don't like=
 it,
      but anything Easy-RSA<br>
      &gt;=A0=A0=A0=A0 +# is designed for will. In return, we get the Issuer
      attached to CRLs.<br>
      &gt;=A0=A0=A0=A0 +crl_extensions =3D crl_ext<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +default_days=A0=A0 =3D 3650=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 # how long to
      certify for<br>
      &gt;=A0=A0=A0=A0 +default_crl_days=3D 30=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 # how long before
      next CRL<br>
      &gt;=A0=A0=A0=A0 +default_md=A0=A0=A0=A0 =3D sha256=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 # use public key
      default MD<br>
      &gt;=A0=A0=A0=A0 +preserve=A0=A0=A0=A0=A0=A0 =3D no=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # keep passed DN
      ordering<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# A few difference way of specifying how similar the
      request should look<br>
      &gt;=A0=A0=A0=A0 +# For type CA, the listed attributes must be the sa=
me,
      and the optional<br>
      &gt;=A0=A0=A0=A0 +# and supplied fields are just that :-)<br>
      &gt;=A0=A0=A0=A0 +policy=A0=A0=A0=A0=A0=A0=A0=A0 =3D policy_anything<=
br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# For the 'anything' policy, which defines allowed =
DN
      fields<br>
      &gt;=A0=A0=A0=A0 +[ policy_anything ]<br>
      &gt;=A0=A0=A0=A0 +countryName=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D op=
tional<br>
      &gt;=A0=A0=A0=A0 +stateOrProvinceName=A0=A0=A0 =3D optional<br>
      &gt;=A0=A0=A0=A0 +localityName=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D opti=
onal<br>
      &gt;=A0=A0=A0=A0 +organizationName=A0=A0=A0=A0=A0=A0 =3D optional<br>
      &gt;=A0=A0=A0=A0 +organizationalUnitName =3D optional<br>
      &gt;=A0=A0=A0=A0 +commonName=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
supplied<br>
      &gt;=A0=A0=A0=A0 +name=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D optional<br>
      &gt;=A0=A0=A0=A0 +emailAddress=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D opti=
onal<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0
      +####################################################################=
<br>
      &gt;=A0=A0=A0=A0 +# Easy-RSA request handling<br>
      &gt;=A0=A0=A0=A0 +# We key off $DN_MODE to determine how to format th=
e DN<br>
      &gt;=A0=A0=A0=A0 +[ req ]<br>
      &gt;=A0=A0=A0=A0 +default_bits=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 2048=
<br>
      &gt;=A0=A0=A0=A0 +default_keyfile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D privkey.pem<br>
      &gt;=A0=A0=A0=A0 +default_md=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
sha256<br>
      &gt;=A0=A0=A0=A0 +distinguished_name=A0=A0=A0=A0 =3D cn_only<br>
      &gt;=A0=A0=A0=A0 +x509_extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D easyrsa_ca=A0=A0=A0 # The
      extentions to add to the self signed cert<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# A placeholder to handle the $EXTRA_EXTS feature:<=
br>
      &gt;=A0=A0=A0=A0 +#%EXTRA_EXTS%=A0 # Do NOT remove or change this lin=
e as
      $EXTRA_EXTS support requires it<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0
      +####################################################################=
<br>
      &gt;=A0=A0=A0=A0 +# Easy-RSA DN (Subject) handling<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# Easy-RSA DN for cn_only support:<br>
      &gt;=A0=A0=A0=A0 +[ cn_only ]<br>
      &gt;=A0=A0=A0=A0 +commonName=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
Common Name (eg: your user,
      host, or server name)<br>
      &gt;=A0=A0=A0=A0 +commonName_max=A0=A0=A0=A0=A0=A0=A0=A0 =3D 64<br>
      &gt;=A0=A0=A0=A0 +commonName_default=A0=A0=A0=A0 =3D changeme<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# Easy-RSA DN for org support:<br>
      &gt;=A0=A0=A0=A0 +[ org ]<br>
      &gt;=A0=A0=A0=A0 +countryName=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D Country Name (2 letter
      code)<br>
      &gt;=A0=A0=A0=A0 +countryName_default=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D KG<br>
      &gt;=A0=A0=A0=A0 +countryName_min=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 2<br>
      &gt;=A0=A0=A0=A0 +countryName_max=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 2<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +stateOrProvinceName=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D State or Province Name
      (full name)<br>
      &gt;=A0=A0=A0=A0 +stateOrProvinceName_default=A0=A0=A0 =3D NA<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +localityName=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D Locality Name (eg,
      city)<br>
      &gt;=A0=A0=A0=A0 +localityName_default=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D BISHKEK<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +0.organizationName=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D Organization Name (eg,
      company)<br>
      &gt;=A0=A0=A0=A0 +0.organizationName_default=A0=A0=A0=A0 =3D OpenVPN-=
TEST<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +organizationalUnitName=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
Organizational Unit
      Name (eg, section)<br>
      &gt;=A0=A0=A0=A0 +organizationalUnitName_default =3D<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +commonName=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =3D Common Name (eg: your
      user, host, or server name)<br>
      &gt;=A0=A0=A0=A0 +commonName_max=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D 64<br>
      &gt;=A0=A0=A0=A0 +commonName_default=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +emailAddress=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D Email Address<br>
      &gt;=A0=A0=A0=A0 +emailAddress_default=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:me@...430...">me@...220...=
..430...</a><br>
      &gt;=A0=A0=A0=A0 +emailAddress_max=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D 64<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0
      +####################################################################=
<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +[ basic_exts ]<br>
      &gt;=A0=A0=A0=A0 +basicConstraints=A0=A0=A0=A0=A0=A0 =3D CA:FALSE<br>
      &gt;=A0=A0=A0=A0 +subjectKeyIdentifier=A0=A0 =3D hash<br>
      &gt;=A0=A0=A0=A0 +authorityKeyIdentifier =3D keyid,issuer:always<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# The Easy-RSA CA extensions<br>
      &gt;=A0=A0=A0=A0 +[ easyrsa_ca ]<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# PKIX recommendations:<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +subjectKeyIdentifier=3Dhash<br>
      &gt;=A0=A0=A0=A0 +authorityKeyIdentifier=3Dkeyid:always,issuer:always=
<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# This could be marked critical, but it's nice to
      support reading by any<br>
      &gt;=A0=A0=A0=A0 +# broken clients who attempt to do so.<br>
      &gt;=A0=A0=A0=A0 +basicConstraints =3D CA:true<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# Limit key usage to CA tasks. If you really want t=
o use
      the generated pair as<br>
      &gt;=A0=A0=A0=A0 +# a self-signed cert, comment this out.<br>
      &gt;=A0=A0=A0=A0 +keyUsage =3D cRLSign, keyCertSign<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# CRL extensions.<br>
      &gt;=A0=A0=A0=A0 +[ crl_ext ]<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# Only issuerAltName and authorityKeyIdentifier mak=
e any
      sense in a CRL.<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# issuerAltName=3Dissuer:copy<br>
      &gt;=A0=A0=A0=A0 +authorityKeyIdentifier=3Dkeyid:always,issuer:always=
<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +# Server extensions.<br>
      &gt;=A0=A0=A0=A0 +[ server ]<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +basicConstraints=A0=A0=A0=A0=A0=A0 =3D CA:FALSE<br>
      &gt;=A0=A0=A0=A0 +nsCertType=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
server<br>
      &gt;=A0=A0=A0=A0 +nsComment=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D "OpenSSL Generated Server
      Certificate"<br>
      &gt;=A0=A0=A0=A0 +subjectKeyIdentifier=A0=A0 =3D hash<br>
      &gt;=A0=A0=A0=A0 +authorityKeyIdentifier =3D keyid,issuer:always<br>
      &gt;=A0=A0=A0=A0 +extendedKeyUsage=A0=A0=A0=A0=A0=A0 =3D serverAuth<b=
r>
      &gt;=A0=A0=A0=A0 +keyUsage=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D digitalSignature,
      keyEncipherment<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/pass.crt
      b/sample/sample-keys/pass.crt<br>
      &gt;=A0=A0=A0=A0 deleted file mode 100644<br>
      &gt;=A0=A0=A0=A0 index 8bb7b17..0000000<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/pass.crt<br>
      &gt;=A0=A0=A0=A0 +++ /dev/null<br>
      &gt;=A0=A0=A0=A0 @@ -1,65 +0,0 @@<br>
      &gt;=A0=A0=A0=A0 -Certificate:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0 Data:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Version: 3 (0x2)<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Serial Number: 3 (0x3)<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Signature Algorithm: md5WithR=
SAEncryption<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Issuer: C=3DKG, ST=3DNA, L=3D=
BISHKEK,
      <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:O=3DOpenVPN-TEST=
/emailAddress=3Dme@...430...">O=3DOpenVPN-TEST/emailAddress=3Dme@...430...<=
/a><br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Validity<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not Before: Nov 2=
5 14:48:55 2004 GMT<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not After : Nov 2=
3 14:48:55 2014 GMT<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Subject: C=3DKG, ST=3DNA, O=
=3DOpenVPN-TEST,
      <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:CN=3DTest-Client=
-Password/emailAddress=3Dme@...430...">CN=3DTest-Client-Password/emailAddre=
ss=3Dme@...430...</a><br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Subject Public Key Info:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Public Key Algori=
thm: rsaEncryption<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RSA Public Key: (=
1024 bit)<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Modul=
us (1024 bit):<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      00:ca:b4:05:67:7b:51:c1:d2:fe:21:57:b1:a5:57:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      5c:c0:86:38:05:a8:91:cf:e7:a4:bd:7a:76:d8:3b:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      cf:fe:f3:78:65:24:d6:72:7d:1b:6d:b6:da:04:f2:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      a8:f6:b4:04:78:d2:24:a7:21:2f:ca:29:46:96:0f:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      0b:91:31:66:1e:4d:22:9a:5d:05:17:99:9c:a0:7e:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      e0:2a:be:78:0c:a1:b9:d4:04:c4:ec:f8:61:79:62:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      b5:52:2d:f5:41:af:db:9f:8c:ab:08:1b:b7:95:b8:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      c1:f0:29:d3:da:fb:00:3f:8e:5c:27:e3:8d:fa:ee:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 dc:b4:3b:0b:8b:e0:ab:c1:c1<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Expon=
ent: 65537 (0x10001)<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 X509v3 extensions:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Basic Cons=
traints:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CA:FA=
LSE<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Netscape Comment:=
<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 OpenS=
SL Generated Certificate<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Subject Ke=
y Identifier:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      40:57:F1:8C:9C:86:B2:DA:E0:3F:A7:B8:D7:85:43:45:07:8A:40:73<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Authority =
Key Identifier:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      keyid:89:A6:60:E3:BA:EA:3E:AF:FC:64:7F:4C:BD:8C:D2:48:8D:E0:CC:46<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:DirName:/C=3DKG/ST=3DN=
A/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...">DirName:/C=3DKG=
/ST=3DNA/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...</a><br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seria=
l:00<br>
      &gt;=A0=A0=A0=A0 -<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0 Signature Algorithm: md5WithRSAEncryption=
<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      a5:79:72:7f:a2:08:28:8e:66:da:e1:d0:be:bb:97:3d:65:9f:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      ab:1e:19:ac:f1:66:44:14:8f:4e:7c:eb:ea:1e:2f:57:ea:44:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      46:4c:b9:56:5b:c0:0c:58:d2:45:87:26:6d:82:de:8c:64:b8:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      8b:22:61:61:c6:68:36:08:9d:5a:fd:2f:e5:21:e1:a2:0c:7f:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      3e:ca:e1:06:ea:9f:81:62:3d:a0:ce:f1:1e:0d:ab:86:89:ed:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      9a:89:34:32:c9:e9:6d:7d:f5:11:c3:5d:7e:a5:f7:f1:a6:83:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      77:1b:94:67:d9:0f:5c:ac:0e:08:4a:88:98:65:49:eb:66:9e:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 2d:28<br>
      &gt;=A0=A0=A0=A0 ------BEGIN CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0
      -MIIDPjCCAqegAwIBAgIBAzANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL<br>
      &gt;=A0=A0=A0=A0
      -MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t<br>
      &gt;=A0=A0=A0=A0
      -VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy<br>
      &gt;=A0=A0=A0=A0
      -NTE0NDg1NVoXDTE0MTEyMzE0NDg1NVowczELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
      &gt;=A0=A0=A0=A0
      -Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxHTAbBgNVBAMTFFRlc3QtQ2xpZW50<br>
      &gt;=A0=A0=A0=A0
      -LVBhc3N3b3JkMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wgZ8w<br>
      &gt;=A0=A0=A0=A0
      -DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMq0BWd7UcHS/iFXsaVXXMCGOAWokc/n<br>
      &gt;=A0=A0=A0=A0
      -pL16dtg7z/7zeGUk1nJ9G2222gTyqPa0BHjSJKchL8opRpYPC5ExZh5NIppdBReZ<br>
      &gt;=A0=A0=A0=A0
      -nKB+4Cq+eAyhudQExOz4YXlitVIt9UGv25+Mqwgbt5W4wfAp09r7AD+OXCfjjfru<br>
      &gt;=A0=A0=A0=A0
      -3LQ7C4vgq8HBAgMBAAGjge4wgeswCQYDVR0TBAIwADAsBglghkgBhvhCAQ0EHxYd<br>
      &gt;=A0=A0=A0=A0
      -T3BlblNTTCBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwHQYDVR0OBBYEFEBX8YychrLa<br>
      &gt;=A0=A0=A0=A0
      -4D+nuNeFQ0UHikBzMIGQBgNVHSMEgYgwgYWAFImmYOO66j6v/GR/TL2M0kiN4MxG<br>
      &gt;=A0=A0=A0=A0
      -oWqkaDBmMQswCQYDVQQGEwJLRzELMAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hL<br>
      &gt;=A0=A0=A0=A0
      -RUsxFTATBgNVBAoTDE9wZW5WUE4tVEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlo<br>
      &gt;=A0=A0=A0=A0
      -b3N0Lm15ZG9tYWluggEAMA0GCSqGSIb3DQEBBAUAA4GBAKV5cn+iCCiOZtrh0L67<br>
      &gt;=A0=A0=A0=A0
      -lz1ln6seGazxZkQUj0586+oeL1fqREZMuVZbwAxY0kWHJm2C3oxkuIsiYWHGaDYI<br>
      &gt;=A0=A0=A0=A0
      -nVr9L+Uh4aIMfz7K4Qbqn4FiPaDO8R4Nq4aJ7ZqJNDLJ6W199RHDXX6l9/Gmg3cb<br>
      &gt;=A0=A0=A0=A0 -lGfZD1ysDghKiJhlSetmni0o<br>
      &gt;=A0=A0=A0=A0 ------END CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/pass.key
      b/sample/sample-keys/pass.key<br>
      &gt;=A0=A0=A0=A0 deleted file mode 100644<br>
      &gt;=A0=A0=A0=A0 index 4916364..0000000<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/pass.key<br>
      &gt;=A0=A0=A0=A0 +++ /dev/null<br>
      &gt;=A0=A0=A0=A0 @@ -1,18 +0,0 @@<br>
      &gt;=A0=A0=A0=A0 ------BEGIN RSA PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 -Proc-Type: 4,ENCRYPTED<br>
      &gt;=A0=A0=A0=A0 -DEK-Info: DES-EDE3-CBC,959F7365DBBFDB77<br>
      &gt;=A0=A0=A0=A0 -<br>
      &gt;=A0=A0=A0=A0
      -nGm57l+rR/8dAZOHL/1x/6dt11zUca7rphjsgw6XRnSf3M/CWmHvHVjApWcNLEs5<br>
      &gt;=A0=A0=A0=A0
      -SWNMp1xfUogtGzsKoMBbnlZLDA7RVHUYD6dVMyCpc64UjzT08LmdZhtQYLAKmlUC<br>
      &gt;=A0=A0=A0=A0
      -PT1VXS4Ae+SrqCPUqJkw1xP3kr0F1EVCXNu0nhOBAuuTGOS7PPEyW2N+k4nRHtsR<br>
      &gt;=A0=A0=A0=A0
      -IaPp8GCuIeoR6CdymTFTq6d/GeCiEcyrUM4BNrG4GtRRrURxxOrzQFEOS5sjBPSg<br>
      &gt;=A0=A0=A0=A0
      -Km1lwa6zBQFRLg9dKjRBL4teKuPY5Z2Nmpcml/aN4CkdkVEso4lW6/UHLE/joOMQ<br>
      &gt;=A0=A0=A0=A0
      -0MdpdYtu8wnt1WI/Z4immQfl3MF+QcPMkqXXzCEhGG/5SbAo89KC46UXvu1Z5OhS<br>
      &gt;=A0=A0=A0=A0
      -8XFHhvYBivOYWgZ3XUQqyZ0ulF60mFX7aE1Ph/eEbhWBHmU39hGjxzop1UoPwqLx<br>
      &gt;=A0=A0=A0=A0
      -ahvtfvCkR3ZeqlWO9SHzCA3MlrKwQ1p1UL6nG6AJhNN9jSevH6by+8wr07NBZOqX<br>
      &gt;=A0=A0=A0=A0
      -fJx+J/8EdVsUCFG2UJxPwM83ZSwAsvKRqph6CuWEl9ndUb7rw6khmRIoY0Iz3LbU<br>
      &gt;=A0=A0=A0=A0
      -1MlcDoJNcJas6lYDr1UeFSk86g0SiGCHXZIqsjyUgq6HIy4YrAYiQUthnlF8tp2Q<br>
      &gt;=A0=A0=A0=A0
      -nNQBPLo1GsHf0dC2MqKfDFASu7ST+Bl+yajHcIiUXvUJPxWbjkWYG9Q2p2ZBLzZD<br>
      &gt;=A0=A0=A0=A0
      -uqeRr66OKxTzUS4go/QbHDNsAulXl61gQIEOdZw5uy/Jl11kyAI6EQbzmehagKdH<br>
      &gt;=A0=A0=A0=A0 -EshTgKp8ks62y0bBHgy3FMKyidJ5Hm58ZDhBxrwN0w+vhRoTGOe=
pTA=3D=3D<br>
      &gt;=A0=A0=A0=A0 ------END RSA PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/pkcs12.p12
      b/sample/sample-keys/pkcs12.p12<br>
      &gt;=A0=A0=A0=A0 deleted file mode 100644<br>
      &gt;=A0=A0=A0=A0 index
253d4081a3aeffab7d17e8c0a308ee1e85d6456f..000000000000000000000000000000000=
0000000<br>
      &gt;=A0=A0=A0=A0 GIT binary patch<br>
      &gt;=A0=A0=A0=A0 literal 0<br>
      &gt;=A0=A0=A0=A0 HcmV?d00001<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0 literal 2685<br>
      &gt;=A0=A0=A0=A0
      zcmY+FX*3j!8pmgb83vhTUnbc_G)!b{*|LOW9U`x+nHmjQ1`%T&lt;W0xfcjmmCh7ugCC=
<br>
      &gt;=A0=A0=A0=A0
zdJ&amp;0)EMrR;Yxb*i?!E85AD;7^^ZTFY`Sd^Mhaj*7f`AMN0?QQ$ROYea&lt;DFALCLo2t<b=
r>
      &gt;=A0=A0=A0=A0
      zf?y=3DDTsXnf2m+JTKM{mNVB$MLTp%FeWS#ma0V0GTEdTz%281Bk8JTZzui!YHif({F<=
br>
      &gt;=A0=A0=A0=A0
z%z!Wg&lt;cF6_a`HQ&amp;-}0i(xAKxjpEU+B5NPvT7ptk55iSO@...1973...#^pTwD&gt;)*=
8*R!qdL<br>
      &gt;=A0=A0=A0=A0
      z42fKOorCYJc=3DT4J+l;Z&gt;x@...1974...{LvCNkwZ7MJ{eDgmCW|XX+3GT!YUko$=
TXTGuE6Cmo<br>
      &gt;=A0=A0=A0=A0
      z9@...1975...=3D9&lt;6!6cWi%@u&gt;Dp-$JP2s6t=3Dkvz6-OMl@~mEaEXG22le(T=
fl@...1976...{VQ#pue@...1635...<br>
      &gt;=A0=A0=A0=A0
z$S`$H)k#B#icbEdGUTOJNtg8r2HVyl&lt;L=3DKiZIZ{}D6=3Dw)Cr?cr?f_CJAI&gt;~u|5a%=
&amp;<br>
      &gt;=A0=A0=A0=A0
      z|9r54eca0dbeyd4`o{LK4N|e%U2!+rmvxC_ve9`q;d+UYx?t$mH)yUk-qpOnl`yp`<br>
      &gt;=A0=A0=A0=A0
      z6mivqIZ&gt;KlXGlc!9*DRZGrJ8ENY!3w!PQRJQYJN)m0bubO9Gq)!dpG`51#4fNteWj=
<br>
      &gt;=A0=A0=A0=A0
z)Uy{{o)tgT)cfGn@(n)(as)Oir2jGwc=3DaG2L+~IbIcV%&amp;c5G|@P{*{Jd?#H&gt;P7lkl=
<br>
      &gt;=A0=A0=A0=A0
      zqLP8(ve$BRfwQ=3DWmCMw1W!aWKiK;iH%ej(rhXL~D&lt;1btDIJpqh`U$seQ1fvjn;X=
@~<br>
      &gt;=A0=A0=A0=A0
zYBzzfQFps3x&gt;N1~k|{r05Ej#luDsl5o+E5o6W}y((|9?EHOt+r&gt;fDQx&amp;b7jzQ$DN=
&gt;<br>
      &gt;=A0=A0=A0=A0
zB}mx=3Dv1cW#Y}5;W1wVL}RxO)q&amp;@+=3DuH(=3D%CV{+~qJFCmm&gt;+q;_TVOBY$s0EFS=
dS;7<br>
      &gt;=A0=A0=A0=A0
z&amp;mqBKauOn(=3DlG*zP=3D4q^v2&lt;1rBH%Edi*`-;3;k~BXqk@...1977...`Zs~A<br>
      &gt;=A0=A0=A0=A0
z*lzbt&lt;Lz*?oKpFwtf0bMAHn6Pn_bV_(qucN^dt&gt;kpmn`Y&lt;JKcdnQLS&lt;@1i&gt;=
h@...1978...<br>
      &gt;=A0=A0=A0=A0
zEdZh~R0=3DkRsU4vUgW$I1u@|raEQEzz&amp;hBqHE&lt;e_`V*VvwZZK_?v#9@...1979...(=
OGuds8<br>
      &gt;=A0=A0=A0=A0
      zq@`uGfPUcv*)58&gt;tEs$w^vz4cAHezuzgvmuh)lb`_LM{yoz0Ij*wf}VZB9stQ6roq=
<br>
      &gt;=A0=A0=A0=A0
      zhXDK5d)_MN2W5P|{wWcWta=3D?Is&lt;$R6Ihym*+(~37OaRsIhbf-b8ck`;d~mN-TmS=
KH<br>
      &gt;=A0=A0=A0=A0
zAkCx?E}l3w*$}9L3^26R;TBK#i@...1620...|Af(ggGixifT9?AFEFm1R)6{ia%&amp;96Y_^=
kl&lt;Z<br>
      &gt;=A0=A0=A0=A0
      zO|2vnP&amp;e9h$B#-ZOGJ})^bdG_L!CP?tY@...1980...)+zmUojTmJjmc4zn6DhJt=
kU*2<br>
      &gt;=A0=A0=A0=A0
      zTyOtzc?4-O5*u&gt;1WMq;EV3-lRXEM}xv(^O~!7!1)I|9!h9%_2p&lt;}KW$RKr|`Yc=
Lw}<br>
      &gt;=A0=A0=A0=A0
      z&lt;t#*oq1A`dE=3D{byczot?YG(pSA(HR+V9kE4w4CN#78PlH7@...1981...#)P^RU=
meu&gt;0<br>
      &gt;=A0=A0=A0=A0
      zVEA183^cHZa*3$N9%A*|4roE^WV?ltK2PQvtg$I&amp;eq(wH*W%4sXR2^rp@?LgRIi$=
c<br>
      &gt;=A0=A0=A0=A0
z6%zNK^m$$X@&amp;e`@P3O2H0YrU%8V)t=3DMmkiK;#rsB0!5%g)&lt;#Kehh}i@&lt;=3DmHX=
sKMvG<br>
      &gt;=A0=A0=A0=A0
z&gt;eU}MNQy!ZO;oXNw(nZ&lt;bk2lI6SjTIljmfn0{qR9p3ED1Sz&amp;?R`~alg3@...1997...=
...#^Z<br>
      &gt;=A0=A0=A0=A0
z`}cg57$n3&gt;+J6q@)D4;l+}O_xHM_Z5tKoRYcpNO)&amp;2;YaS1hNtXHcG&amp;rv)Y1tsG=
Bu<br>
      &gt;=A0=A0=A0=A0
      zH@@nN^V!H%fJ=3DzM7xONAJ@...1983...*$%sBw&amp;?k)KQXv{!oF~wZcUek*9AzO=
Q5GBOcPsmu<br>
      &gt;=A0=A0=A0=A0
zx&gt;J0`U(5@...1984...&gt;CkbfL4%WYBl*?wB7@...1985...+%J1&gt;zfC|fk&lt;4ta=
rku$KHFg`)<br>
      &gt;=A0=A0=A0=A0
      z32;tRbzJ8+W1aCRdY&gt;%w%VrGgsHNyd4EbT#Qqh=3DVeTVcd!bI2!ts#EONaY-#AwE=
J$<br>
      &gt;=A0=A0=A0=A0
      zmV8E7g}dIaW$9T6mz_&lt;cPyHH)vI(Gj!HGil32(YPF#3E^f5PEvZ8`K+AeaNE4Y{JZ=
<br>
      &gt;=A0=A0=A0=A0
zq+-*=3D9IuO&gt;@2(aI&gt;^megR`|b;#&lt;jFHG7)`Rd8LiIqXgc}@&lt;&gt;#4x0GX*bj=
vl8tur0T<br>
      &gt;=A0=A0=A0=A0
      zFi`8aRMRgtF^;s*U;`8O&amp;uP@...1952...(S@...1986...;o#rX^|4v%b5bALTj=
thLt;I)IZQOg5sH58X<br>
      &gt;=A0=A0=A0=A0
      z@...1987...&gt;)V+B%k!v42GexdYt2hT)KhBqlrh)t$to8;ngHput4!Yrk-gY=3D}e=
^$|C-Y@...1988...=3D<br>
      &gt;=A0=A0=A0=A0
z-l_T&gt;3@=3DKG&gt;-JMVvEsG%_OrA4k@...1989...$RFdzXTFsv^5fJuNl`nhSt&amp;uY=
LCr&gt;Z<br>
      &gt;=A0=A0=A0=A0
      z%rdbJyB06(7buBJ`C6EtGF&lt;4J?VJGCxLiP)aL?oQ96Llg9qZ6=3Dh3stpHJ6e=3D{=
Ewg1<br>
      &gt;=A0=A0=A0=A0
zK+RSh?@GwJkQg&amp;4zkgxJv+S4#fuv~Wlw&amp;XBTWrIZVu&lt;M&lt;6^$$4j9FZSxaRM&=
gt;_7~R1<br>
      &gt;=A0=A0=A0=A0
      z1hL~0b#})ulH*=3DgO69)OAwLx|pJlgtw5t9Z)?-pY?gb~g{M^?K=3D_s7xMG!!{|06^=
S<br>
      &gt;=A0=A0=A0=A0
z0kp(O0L`7?&gt;64j&amp;u&gt;MDnEI`mnn12Fa{GT-${#f&amp;L#3IK5UMTvHHBZjN(4|GI=
J8#*0<br>
      &gt;=A0=A0=A0=A0
zEL~S%gL8a#5&lt;fZ6(5MkHV?G~ynw&gt;P7p0Bg+ozfQ|)o`WbEdFq=3DPn+~*x}eSHDn&gt;=
}0<br>
      &gt;=A0=A0=A0=A0
      za#bssC46DP&gt;glYKit?*q(ylFaU(}~Odzjx2#k+auqmLOM8@...1598...)YFzplKD=
0QtM(F_Uu<br>
      &gt;=A0=A0=A0=A0
zRHv^yDq*$`c$xNo;O1uEWTg5NnUR9^wRyLx4G&amp;J3O$l?Ff&amp;Sgd*Ux|{yu}Tc_kRAx<=
br>
      &gt;=A0=A0=A0=A0
      zZ4_A@...1990...$)Ek?$5BMzMT0ZfU+`%1_OIaTg-c`D3Utjws&amp;do{_7d*j_LS6=
U+DKir<br>
      &gt;=A0=A0=A0=A0
      z@...1991...#p!oOstM}_SmVJ?vyvMMumfm9By?=3D?AtkFJ4R`)DJQf3HPtrO&gt;CL=
F*ghb-Z{VT<br>
      &gt;=A0=A0=A0=A0
      z@&amp;g3d`$hMvAw9wa-+X=3DcZug%2QLG(iT8okLHeD64iE06J24#}WG;%v0qN;o~J#=
X}X<br>
      &gt;=A0=A0=A0=A0
zYrX|$IsBw!A%&lt;DK8BxUAB#r~6R2VbwU(5j!Z&amp;%wNb{;g|?T5+&lt;F1~+I0vu7#x&am=
p;Fvm<br>
      &gt;=A0=A0=A0=A0
ze1ONAR~^|B&amp;Qq0=3Dujo8B;e~P=3D3$o9GB)Cn*7-hG1(ZUGyCPoz&gt;gBYC6=3DL-yXI=
_1c)<br>
      &gt;=A0=A0=A0=A0
      z+V2@}l1I9@^i#Ub8wuxSinPw-x7vv^wsW3}5xqf+AKwPmn+)MXcW9$*)7&lt;p)X-4r0=
<br>
      &gt;=A0=A0=A0=A0
      z(}vuxaH}l=3D5mD9p6kTY6tV&lt;=3D+{T09Rcf}dj;zzR*T|iIve0t3uU^!skyK&lt;=
X(@4$hD<br>
      &gt;=A0=A0=A0=A0
      zjLKXu4dS7hQnxGPoJKwgMg4@...1992...^3R(;eyD;4^ur4ohCZxY|q1QA*+PG<br>
      &gt;=A0=A0=A0=A0
      z$SOGWw^n~{mai?yyFC!zxHo3~sLTIe)p*v~5PJ8vr85%;Nxo4%n&lt;t_$^k`z?bVG;}=
<br>
      &gt;=A0=A0=A0=A0
z=3DY3=3DzfQmI$kU)t2x7AQ?1s+B&amp;c~qWv*&amp;*FkE5g%9wN}Fw%x7DNP(X+vpb)SuI|=
E1n<br>
      &gt;=A0=A0=A0=A0 p3}EC!RO5XI2(vRh7cV|04Ibx-bA*{OGGFY`Qh)u6xbdgm{{pfR_=
hSG6<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/server-ec.crt
      b/sample/sample-keys/server-ec.crt<br>
      &gt;=A0=A0=A0=A0 new file mode 100644<br>
      &gt;=A0=A0=A0=A0 index 0000000..a72c341<br>
      &gt;=A0=A0=A0=A0 --- /dev/null<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/server-ec.crt<br>
      &gt;=A0=A0=A0=A0 @@ -0,0 +1,96 @@<br>
      &gt;=A0=A0=A0=A0 +Certificate:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 Data:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 Version: 3 (0x2)<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 Serial Number: 3 (0x3)<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 Signature Algorithm: sha256WithRSAEncrypt=
ion<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 Issuer: C=3DKG, ST=3DNA, L=3D=
BISHKEK,
      <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:O=3DOpenVPN-TEST=
/emailAddress=3Dme@...430...">O=3DOpenVPN-TEST/emailAddress=3Dme@...430...<=
/a><br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 Validity<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not Before: Oct 2=
2 21:59:53 2014 GMT<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not After : Oct 1=
9 21:59:53 2024 GMT<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 Subject: C=3DKG, ST=3DNA, O=
=3DOpenVPN-TEST,
      <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:CN=3DTest-Server=
-EC/emailAddress=3Dme@...430...">CN=3DTest-Server-EC/emailAddress=3Dme@...1998...=
30...</a><br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 Subject Public Key Info:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Public Key Algori=
thm: id-ecPublicKey<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Publi=
c-Key: (256 bit)<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pub:<=
br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      04:21:09:ac:27:e6:00:3a:57:f4:f6:c7:78:a9:b1:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      f4:d7:d7:45:59:39:e4:a3:d3:2c:94:f9:61:4a:e6:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      b9:e9:87:57:c8:0f:88:03:a0:56:ee:34:e7:e4:4e:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      20:63:6c:c1:6e:c1:04:ac:b9:2f:a9:76:69:d3:7d:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 49:ff:f1:34:cb<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ASN1 =
OID: secp256k1<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 X509v3 extensions:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Basic Cons=
traints:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CA:FA=
LSE<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Netscape Cert Typ=
e:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SSL S=
erver<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Netscape Comment:=
<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 OpenS=
SL Generated Server Certificate<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Subject Ke=
y Identifier:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      33:1A:42:61:9E:88:08:3F:6F:1F:98:88:3A:DD:2D:C7:07:3D:F6:9B<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Authority =
Key Identifier:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:DirName:/C=3DKG/ST=3DN=
A/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...">DirName:/C=3DKG=
/ST=3DNA/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...</a><br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seria=
l:A1:4E:DE:FA:90:F2:AE:81<br>
      &gt;=A0=A0=A0=A0 +<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Extended K=
ey Usage:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 TLS W=
eb Server Authentication<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Key Usage:=
<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Digit=
al Signature, Key Encipherment<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 Signature Algorithm: sha256WithRSAEncrypt=
ion<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      9d:89:f6:7e:0b:43:05:22:63:e5:b3:45:a8:d9:ef:33:3c:b7:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      19:37:28:87:27:43:43:86:a3:3f:b9:23:27:0f:96:4f:de:01:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      80:38:6b:d9:c8:94:77:1f:06:08:34:65:77:ad:57:0c:23:99:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      f1:51:12:5f:32:d8:9c:7c:93:f1:f6:72:2a:05:61:ff:62:aa:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      33:aa:ef:a3:4d:d6:93:56:40:ff:38:2e:73:1c:69:fb:71:a1:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      fa:64:19:6a:04:1c:8b:20:a8:ee:a5:18:63:f8:84:f4:ca:84:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      8e:b6:05:48:c6:f3:f7:81:90:4d:9e:00:cd:4a:92:83:d4:93:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      67:05:dc:16:8b:78:fa:b1:82:48:c6:86:74:44:b1:06:7e:8a:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      c8:64:0b:82:3a:e2:f5:56:60:ea:50:70:03:da:9f:fc:28:20:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      6b:7d:04:e0:eb:8d:e2:f1:be:82:2f:ba:51:50:2b:6c:d2:fc:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      11:cd:69:85:3b:9e:14:19:dd:bc:14:cf:61:b0:7a:07:cb:e8:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      e0:fc:c3:1f:a4:cb:cf:c1:e9:62:0f:d2:53:f8:ce:06:f4:f8:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      2f:55:13:aa:67:44:b6:b8:e8:3e:82:af:66:f5:f0:7c:fe:41:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      e6:9d:c0:9f:78:fd:00:85:02:40:63:37:fa:00:e6:3c:a6:9f:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      35:4f:1d:a6:f1:cb:8b:04:e0:67:98:56:d1:87:58:b6:39:f6:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      d3:fe:a8:40:50:80:7f:e6:4a:36:d0:c0:a5:61:64:1d:3a:87:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      ad:78:72:c9:3f:98:44:35:f9:cf:32:b2:18:4c:b0:72:fa:5e:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      6c:62:1e:d4:31:0c:c8:9b:74:f0:00:9e:70:c3:1e:c7:a4:9d:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      03:a4:ac:1a:09:1f:86:23:65:51:34:50:86:68:1e:68:4d:9a:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      4b:78:10:1c:bd:51:09:bb:fe:16:a3:c7:19:b4:05:44:a1:e6:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      c6:23:76:d5:b8:3a:eb:a5:17:1d:2b:2e:fe:85:7c:88:4f:f1:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      e8:34:32:e0:c5:96:87:c3:e8:c9:5f:89:24:10:0e:1e:07:0b:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      2c:f8:d0:49:1b:63:5e:63:44:e9:2a:43:e2:9c:d6:f2:43:99:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      47:f8:9b:49:1a:a7:d1:e0:53:67:1d:cb:14:b6:b0:2c:4d:b3:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      f2:c5:62:c2:a6:09:7a:c0:6c:59:3e:73:83:0c:6c:de:30:77:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      4d:1b:ed:b0:7f:77:87:8d:55:1d:d3:ed:f7:66:bd:06:2a:f8:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      fd:00:e7:c0:31:e2:ff:53:9e:25:97:c6:64:84:9d:8d:61:8e:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      c9:1f:6c:55:a1:7c:59:aa:eb:e8:2a:b2:2d:c7:09:cd:b5:3d:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0 d8:74:4f:6e:9c:3b:d5:6d<br>
      &gt;=A0=A0=A0=A0 +-----BEGIN CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0
      +MIIEtTCCAp2gAwIBAgIBAzANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL<br>
      &gt;=A0=A0=A0=A0
      +MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t<br>
      &gt;=A0=A0=A0=A0
      +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy<br>
      &gt;=A0=A0=A0=A0
      +MjIxNTk1M1oXDTI0MTAxOTIxNTk1M1owbTELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
      &gt;=A0=A0=A0=A0
      +Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFzAVBgNVBAMTDlRlc3QtU2VydmVy<br>
      &gt;=A0=A0=A0=A0
      +LUVDMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wVjAQBgcqhkjO<br>
      &gt;=A0=A0=A0=A0
      +PQIBBgUrgQQACgNCAAQhCawn5gA6V/T2x3ipsfTX10VZOeSj0yyU+WFK5rnph1fI<br>
      &gt;=A0=A0=A0=A0
      +D4gDoFbuNOfkTiBjbMFuwQSsuS+pdmnTfUn/8TTLo4IBMzCCAS8wCQYDVR0TBAIw<br>
      &gt;=A0=A0=A0=A0
      +ADARBglghkgBhvhCAQEEBAMCBkAwMwYJYIZIAYb4QgENBCYWJE9wZW5TU0wgR2Vu<br>
      &gt;=A0=A0=A0=A0
      +ZXJhdGVkIFNlcnZlciBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQUMxpCYZ6ICD9vH5iI<br>
      &gt;=A0=A0=A0=A0
      +Ot0txwc99pswgZgGA1UdIwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRo<br>
      &gt;=A0=A0=A0=A0
      +MGYxCzAJBgNVBAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEV<br>
      &gt;=A0=A0=A0=A0
      +MBMGA1UEChMMT3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3Qu<br>
      &gt;=A0=A0=A0=A0
      +bXlkb21haW6CCQChTt76kPKugTATBgNVHSUEDDAKBggrBgEFBQcDATALBgNVHQ8E<br>
      &gt;=A0=A0=A0=A0
      +BAMCBaAwDQYJKoZIhvcNAQELBQADggIBAJ2J9n4LQwUiY+WzRajZ7zM8txk3KIcn<br>
      &gt;=A0=A0=A0=A0
      +Q0OGoz+5IycPlk/eAYA4a9nIlHcfBgg0ZXetVwwjmfFREl8y2Jx8k/H2cioFYf9i<br>
      &gt;=A0=A0=A0=A0
      +qjOq76NN1pNWQP84LnMcaftxofpkGWoEHIsgqO6lGGP4hPTKhI62BUjG8/eBkE2e<br>
      &gt;=A0=A0=A0=A0
      +AM1KkoPUk2cF3BaLePqxgkjGhnREsQZ+ishkC4I64vVWYOpQcAPan/woIGt9BODr<br>
      &gt;=A0=A0=A0=A0
      +jeLxvoIvulFQK2zS/BHNaYU7nhQZ3bwUz2GwegfL6OD8wx+ky8/B6WIP0lP4zgb0<br>
      &gt;=A0=A0=A0=A0
      ++C9VE6pnRLa46D6Cr2b18Hz+QeadwJ94/QCFAkBjN/oA5jymnzVPHabxy4sE4GeY<br>
      &gt;=A0=A0=A0=A0
      +VtGHWLY59tP+qEBQgH/mSjbQwKVhZB06h614csk/mEQ1+c8yshhMsHL6XmxiHtQx<br>
      &gt;=A0=A0=A0=A0
      +DMibdPAAnnDDHseknQOkrBoJH4YjZVE0UIZoHmhNmkt4EBy9UQm7/hajxxm0BUSh<br>
      &gt;=A0=A0=A0=A0
      +5sYjdtW4OuulFx0rLv6FfIhP8eg0MuDFlofD6MlfiSQQDh4HCyz40EkbY15jROkq<br>
      &gt;=A0=A0=A0=A0
      +Q+Kc1vJDmUf4m0kap9HgU2cdyxS2sCxNs/LFYsKmCXrAbFk+c4MMbN4wd00b7bB/<br>
      &gt;=A0=A0=A0=A0
      +d4eNVR3T7fdmvQYq+P0A58Ax4v9TniWXxmSEnY1hjskfbFWhfFmq6+gqsi3HCc21<br>
      &gt;=A0=A0=A0=A0 +Pdh0T26cO9Vt<br>
      &gt;=A0=A0=A0=A0 +-----END CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/server-ec.key
      b/sample/sample-keys/server-ec.key<br>
      &gt;=A0=A0=A0=A0 new file mode 100644<br>
      &gt;=A0=A0=A0=A0 index 0000000..8f2c914<br>
      &gt;=A0=A0=A0=A0 --- /dev/null<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/server-ec.key<br>
      &gt;=A0=A0=A0=A0 @@ -0,0 +1,5 @@<br>
      &gt;=A0=A0=A0=A0 +-----BEGIN PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0
      +MIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQgLHGYqSlzoRaogmJfrC+E<br>
      &gt;=A0=A0=A0=A0
      +ozTothB9bORaQ1C/3FmeQ6ehRANCAAQhCawn5gA6V/T2x3ipsfTX10VZOeSj0yyU<br>
      &gt;=A0=A0=A0=A0 ++WFK5rnph1fID4gDoFbuNOfkTiBjbMFuwQSsuS+pdmnTfUn/8TT=
L<br>
      &gt;=A0=A0=A0=A0 +-----END PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/server.crt
      b/sample/sample-keys/server.crt<br>
      &gt;=A0=A0=A0=A0 index 28bb4d9..03e2023 100644<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/server.crt<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/server.crt<br>
      &gt;=A0=A0=A0=A0 @@ -2,25 +2,34 @@ Certificate:<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0 Data:<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Version: 3 (0x2)<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Serial Number: 1 (0x1)<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 Signature Algorithm: md5WithR=
SAEncryption<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 Signature Algorithm: sha256WithRSAEncrypt=
ion<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Issuer: C=3DKG, ST=3DNA, =
L=3DBISHKEK,
      <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:O=3DOpenVPN-TEST=
/emailAddress=3Dme@...430...">O=3DOpenVPN-TEST/emailAddress=3Dme@...430...<=
/a><br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Validity<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not Before: Nov 2=
5 14:42:22 2004 GMT<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not After : Nov 2=
3 14:42:22 2014 GMT<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not Before: Oct 2=
2 21:59:52 2014 GMT<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Not After : Oct 1=
9 21:59:52 2024 GMT<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Subject: C=3DKG, ST=3DNA,=
 O=3DOpenVPN-TEST,
      <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:CN=3DTest-Server=
/emailAddress=3Dme@...430...">CN=3DTest-Server/emailAddress=3Dme@...430...<=
/a><br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Subject Public Key Info:<=
br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Public Key Al=
gorithm: rsaEncryption<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RSA Public Key: (=
1024 bit)<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Modul=
us (1024 bit):<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      00:cb:4e:ac:f9:83:57:f6:69:d2:32:29:b4:bc:ad:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      e6:f7:26:21:89:33:30:43:40:a3:35:d9:de:26:01:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      d6:b4:f0:bc:0a:19:55:99:3b:f1:4c:91:60:b6:fd:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      74:34:8d:5a:c7:62:ec:ce:f2:d6:02:ce:57:32:f4:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      35:8c:71:a0:6d:65:2a:e7:80:ae:29:59:cf:36:73:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      f8:7c:4a:73:90:fc:30:28:d5:46:7d:35:a4:4e:c9:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      9f:90:7b:e2:09:21:36:c5:a8:ec:85:82:9a:32:b4:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      91:3b:c1:d6:4f:9f:d1:f8:6f:68:f4:1d:d2:06:91:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 32:cc:9a:48:fd:cd:98:7f:2f<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Publi=
c-Key: (2048 bit)<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Modul=
us:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      00:a5:b8:a2:ee:ce:b1:a6:0f:6a:b2:9f:d3:22:17:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      79:de:09:98:71:78:fa:a7:ce:36:51:54:57:c7:31:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      99:56:d1:8a:d6:c5:fd:52:e6:88:0e:7b:f9:ea:27:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      7a:bf:3f:14:ec:aa:d2:ff:8b:56:58:ac:ca:51:77:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      c5:3c:b6:e4:83:6f:22:06:2d:5b:eb:e7:59:d4:ab:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      42:c8:d5:a9:87:73:b3:73:36:51:2f:a5:d0:90:a2:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      87:64:54:6c:12:d3:b8:76:47:69:af:ae:8f:00:b3:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      70:b9:e7:67:3f:8c:6a:3d:79:5f:81:27:a3:0e:aa:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      a7:3d:81:48:10:b1:18:6c:38:2e:8f:7a:7b:c5:3d:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      21:c8:f9:a0:7f:17:2b:88:4f:ba:f2:ec:6d:24:8e:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      6c:f1:0a:5c:d9:5b:b1:b0:fc:49:cb:4a:d2:58:c6:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      2a:25:b0:97:84:c3:9e:ff:34:8c:10:46:7f:0f:fb:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      3c:59:7a:a6:29:0c:ae:8e:50:3a:f2:53:84:40:2d:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      d5:91:7b:0a:37:8e:82:77:ce:66:2f:34:77:5c:a5:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      45:3b:00:19:a7:07:d1:92:e6:66:b9:3b:4e:e9:63:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      fc:33:98:1a:ae:7b:08:7d:0a:df:7a:ba:aa:59:6d:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
      86:82:0a:64:2b:da:59:a7:4c:4e:ef:3d:bd:04:a2:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 4b:31<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xponent: 65537 (0x10001)<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 extensions:<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Basic =
Constraints:<br>
      &gt;=A0=A0=A0=A0 @@ -30,38 +39,75 @@ Certificate:<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Netscape Comm=
ent:<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 O=
penSSL Generated Server Certificate<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Subjec=
t Key Identifier:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      69:11:FE:E7:9F:89:7B:71:34:69:C0:DC:82:F8:D0:5D:4D:FB:78:DF<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      B3:9D:81:E6:16:92:64:C4:86:87:F5:29:10:1B:5E:2F:74:F7:ED:B1<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Author=
ity Key Identifier:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      keyid:89:A6:60:E3:BA:EA:3E:AF:FC:64:7F:4C:BD:8C:D2:48:8D:E0:CC:46<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
      keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B<br>
      &gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:DirName:/C=3DKG/ST=3DN=
A/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...">DirName:/C=3DKG=
/ST=3DNA/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@...430...</a><br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seria=
l:00<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seria=
l:A1:4E:DE:FA:90:F2:AE:81<br>
      &gt;<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0 Signature Algorithm: md5WithRSAEncryption=
<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      35:5c:75:da:57:ef:b5:79:f2:a2:db:36:e4:75:e8:c7:bc:73:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      26:cf:30:36:4b:2e:51:46:37:60:2f:4e:2b:f6:71:a2:23:db:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      8e:d8:5c:d5:af:2e:22:28:dd:30:a8:89:66:3a:cc:5b:3c:0f:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      96:12:20:de:5e:41:52:74:35:ed:4c:26:40:19:ca:73:df:54:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      b1:30:96:9c:a5:14:d0:38:28:3f:ab:30:07:d7:de:98:d2:7f:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      7f:90:b2:52:1d:e5:95:88:ed:ba:8a:6a:14:85:66:76:ec:75:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0
      30:e8:ae:94:f4:e1:76:fa:4b:0e:f1:53:d7:95:be:fb:69:fa:<br>
      &gt;=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 3d:32<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Extended K=
ey Usage:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 TLS W=
eb Server Authentication<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X509v3 Key Usage:=
<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Digit=
al Signature, Key Encipherment<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0 Signature Algorithm: sha256WithRSAEncrypt=
ion<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      4e:25:80:1b:cb:b0:42:ff:bb:3f:e8:0d:58:c1:80:db:cf:d0:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      90:df:ca:c1:e6:41:e1:48:7f:a7:1e:c7:35:9f:9c:6d:7c:3e:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      82:e8:de:7e:ae:82:16:00:33:0f:02:23:f1:9d:fe:2b:06:16:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      05:55:16:89:dc:63:ac:5f:1a:31:13:79:21:a3:6e:60:28:e8:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      e7:6b:54:00:22:a1:b7:69:5a:17:31:ce:0f:c2:a6:dd:a3:6f:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      de:ea:19:6c:d2:d2:cb:35:9d:dd:87:51:33:68:cd:c3:9b:90:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      55:f1:80:3d:5c:b8:09:b6:e1:3c:13:a4:5d:4a:ce:a5:11:9e:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      f9:08:ee:be:e3:54:1d:06:4c:bb:1b:72:13:ee:7d:a0:45:cc:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      fe:d1:3b:02:03:c1:d4:ea:45:2d:a8:c9:97:e7:f3:8a:7a:a0:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      2f:dd:48:3a:75:c9:42:28:94:fc:af:44:52:16:68:98:d6:ad:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      a8:65:b1:cd:ac:60:41:70:e5:44:e8:5a:f2:e7:fc:3b:fe:45:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      89:17:1d:6d:85:c6:f0:fc:69:87:d1:1d:07:f3:cb:7b:54:8d:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      aa:a3:cc:e3:c6:fc:d6:05:76:35:d0:26:63:8e:d1:a8:b7:ff:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      61:42:8a:2c:63:1f:d4:ec:14:47:6b:1e:e3:81:61:12:3b:8c:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      16:b5:cf:87:6a:2d:42:21:83:9c:0e:3a:90:3a:1e:c1:36:61:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      41:f9:fb:4e:5d:ea:f4:df:23:92:33:2b:9b:14:9f:a0:f5:d3:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      c4:f8:1f:2f:9c:11:36:af:2a:22:61:95:32:0b:c4:1c:2d:b1:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      c1:0a:2a:97:c0:43:4a:6c:3e:db:00:cd:29:15:9e:7e:41:75:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      36:a8:56:86:8c:82:9e:46:20:e5:06:1e:60:d2:03:5f:9f:9e:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      69:bb:bf:c2:b4:43:e2:7d:85:17:83:18:41:b0:cb:a9:04:1b:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      18:52:9f:89:8b:76:9f:94:59:81:4f:60:5b:33:18:fc:c7:52:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      d0:d2:69:fc:0b:a2:63:32:75:43:99:e9:d7:f8:6d:c7:55:31:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      0c:f3:ef:1a:71:e1:0a:57:e1:9d:13:b2:1e:fe:1d:ef:e4:f1:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      51:d9:95:b3:fd:28:28:93:91:4a:29:c5:37:0e:ab:d8:85:6a:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      fe:a8:83:1f:7b:80:5d:1f:04:79:b7:a9:08:6e:0d:d6:2e:aa:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      7c:f6:63:7d:41:de:70:13:32:ce:dd:58:cc:a6:73:d4:72:7e:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      d7:ac:74:a8:35:ba:c3:1b:2a:64:d7:5a:37:97:56:94:34:2b:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0
      2a:71:60:bc:69:ab:00:85:b9:4f:67:32:17:51:c3:da:57:3a:<br>
      &gt;=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0 37:89:66:c4:7a:51:da:5f<br>
      &gt;=A0=A0=A0=A0=A0 -----BEGIN CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0
      -MIIDUTCCArqgAwIBAgIBATANBgkqhkiG9w0BAQQFADBmMQswCQYDVQQGEwJLRzEL<br>
      &gt;=A0=A0=A0=A0
      +MIIFgDCCA2igAwIBAgIBATANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL<br>
      &gt;=A0=A0=A0=A0=A0
      MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t<br>
      &gt;=A0=A0=A0=A0
      -VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTA0MTEy<br>
      &gt;=A0=A0=A0=A0
      -NTE0NDIyMloXDTE0MTEyMzE0NDIyMlowajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
      &gt;=A0=A0=A0=A0
      +VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy<br>
      &gt;=A0=A0=A0=A0
      +MjIxNTk1MloXDTI0MTAxOTIxNTk1MlowajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
      &gt;=A0=A0=A0=A0=A0
      Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFDASBgNVBAMTC1Rlc3QtU2VydmVy<br>
      &gt;=A0=A0=A0=A0
      -MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wgZ8wDQYJKoZIhvcN<br>
      &gt;=A0=A0=A0=A0
      -AQEBBQADgY0AMIGJAoGBAMtOrPmDV/Zp0jIptLyt5vcmIYkzMENAozXZ3iYB1rTw<br>
      &gt;=A0=A0=A0=A0
      -vAoZVZk78UyRYLb9dDSNWsdi7M7y1gLOVzL0NYxxoG1lKueArilZzzZz+HxKc5D8<br>
      &gt;=A0=A0=A0=A0
      -MCjVRn01pE7Jn5B74gkhNsWo7IWCmjK0kTvB1k+f0fhvaPQd0gaRMsyaSP3NmH8v<br>
      &gt;=A0=A0=A0=A0
      -AgMBAAGjggEJMIIBBTAJBgNVHRMEAjAAMBEGCWCGSAGG+EIBAQQEAwIGQDAzBglg<br>
      &gt;=A0=A0=A0=A0
      -hkgBhvhCAQ0EJhYkT3BlblNTTCBHZW5lcmF0ZWQgU2VydmVyIENlcnRpZmljYXRl<br>
      &gt;=A0=A0=A0=A0
      -MB0GA1UdDgQWBBRpEf7nn4l7cTRpwNyC+NBdTft43zCBkAYDVR0jBIGIMIGFgBSJ<br>
      &gt;=A0=A0=A0=A0
      -pmDjuuo+r/xkf0y9jNJIjeDMRqFqpGgwZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgT<br>
      &gt;=A0=A0=A0=A0
      -Ak5BMRAwDgYDVQQHEwdCSVNIS0VLMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxITAf<br>
      &gt;=A0=A0=A0=A0
      -BgkqhkiG9w0BCQEWEm1lQG15aG9zdC5teWRvbWFpboIBADANBgkqhkiG9w0BAQQF<br>
      &gt;=A0=A0=A0=A0
      -AAOBgQA1XHXaV++1efKi2zbkdejHvHMmzzA2Sy5RRjdgL04r9nGiI9uO2FzVry4i<br>
      &gt;=A0=A0=A0=A0
      -KN0wqIlmOsxbPA+WEiDeXkFSdDXtTCZAGcpz31SxMJacpRTQOCg/qzAH196Y0n9/<br>
      &gt;=A0=A0=A0=A0 -kLJSHeWViO26imoUhWZ27HUw6K6U9OF2+ksO8VPXlb77afo9Mg=
=3D=3D<br>
      &gt;=A0=A0=A0=A0
      +MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wggEiMA0GCSqGSIb3<br>
      &gt;=A0=A0=A0=A0
      +DQEBAQUAA4IBDwAwggEKAoIBAQCluKLuzrGmD2qyn9MiF3neCZhxePqnzjZRVFfH<br>
      &gt;=A0=A0=A0=A0
      +MZlW0YrWxf1S5ogOe/nqJ3q/PxTsqtL/i1ZYrMpRd8U8tuSDbyIGLVvr51nUq0LI<br>
      &gt;=A0=A0=A0=A0
      +1amHc7NzNlEvpdCQoodkVGwS07h2R2mvro8As3C552c/jGo9eV+BJ6MOqqc9gUgQ<br>
      &gt;=A0=A0=A0=A0
      +sRhsOC6PenvFPSHI+aB/FyuIT7ry7G0kjmzxClzZW7Gw/EnLStJYxiolsJeEw57/<br>
      &gt;=A0=A0=A0=A0
      +NIwQRn8P+zxZeqYpDK6OUDryU4RALdWRewo3joJ3zmYvNHdcpUU7ABmnB9GS5ma5<br>
      &gt;=A0=A0=A0=A0
      +O07pY/wzmBquewh9Ct96uqpZbYaCCmQr2lmnTE7vPb0EoksxAgMBAAGjggEzMIIB<br>
      &gt;=A0=A0=A0=A0
      +LzAJBgNVHRMEAjAAMBEGCWCGSAGG+EIBAQQEAwIGQDAzBglghkgBhvhCAQ0EJhYk<br>
      &gt;=A0=A0=A0=A0
      +T3BlblNTTCBHZW5lcmF0ZWQgU2VydmVyIENlcnRpZmljYXRlMB0GA1UdDgQWBBSz<br>
      &gt;=A0=A0=A0=A0
      +nYHmFpJkxIaH9SkQG14vdPftsTCBmAYDVR0jBIGQMIGNgBQrQOXJffX0ljjpL+Mv<br>
      &gt;=A0=A0=A0=A0
      +2UBkyY4Fm6FqpGgwZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgTAk5BMRAwDgYDVQQH<br>
      &gt;=A0=A0=A0=A0
      +EwdCSVNIS0VLMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxITAfBgkqhkiG9w0BCQEW<br>
      &gt;=A0=A0=A0=A0
      +Em1lQG15aG9zdC5teWRvbWFpboIJAKFO3vqQ8q6BMBMGA1UdJQQMMAoGCCsGAQUF<br>
      &gt;=A0=A0=A0=A0
      +BwMBMAsGA1UdDwQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAgEATiWAG8uwQv+7P+gN<br>
      &gt;=A0=A0=A0=A0
      +WMGA28/QkN/KweZB4Uh/px7HNZ+cbXw+gujefq6CFgAzDwIj8Z3+KwYWBVUWidxj<br>
      &gt;=A0=A0=A0=A0
      +rF8aMRN5IaNuYCjo52tUACKht2laFzHOD8Km3aNv3uoZbNLSyzWd3YdRM2jNw5uQ<br>
      &gt;=A0=A0=A0=A0
      +VfGAPVy4CbbhPBOkXUrOpRGe+QjuvuNUHQZMuxtyE+59oEXM/tE7AgPB1OpFLajJ<br>
      &gt;=A0=A0=A0=A0
      +l+fzinqgL91IOnXJQiiU/K9EUhZomNatqGWxzaxgQXDlROha8uf8O/5FiRcdbYXG<br>
      &gt;=A0=A0=A0=A0
      +8Pxph9EdB/PLe1SNqqPM48b81gV2NdAmY47RqLf/YUKKLGMf1OwUR2se44FhEjuM<br>
      &gt;=A0=A0=A0=A0
      +FrXPh2otQiGDnA46kDoewTZhQfn7Tl3q9N8jkjMrmxSfoPXTxPgfL5wRNq8qImGV<br>
      &gt;=A0=A0=A0=A0
      +MgvEHC2xwQoql8BDSmw+2wDNKRWefkF1NqhWhoyCnkYg5QYeYNIDX5+eabu/wrRD<br>
      &gt;=A0=A0=A0=A0
      +4n2FF4MYQbDLqQQbGFKfiYt2n5RZgU9gWzMY/MdS0NJp/AuiYzJ1Q5np1/htx1Ux<br>
      &gt;=A0=A0=A0=A0
      +DPPvGnHhClfhnROyHv4d7+TxUdmVs/0oKJORSinFNw6r2IVq/qiDH3uAXR8Eebep<br>
      &gt;=A0=A0=A0=A0
      +CG4N1i6qfPZjfUHecBMyzt1YzKZz1HJ+16x0qDW6wxsqZNdaN5dWlDQrKnFgvGmr<br>
      &gt;=A0=A0=A0=A0 +AIW5T2cyF1HD2lc6N4lmxHpR2l8=3D<br>
      &gt;=A0=A0=A0=A0=A0 -----END CERTIFICATE-----<br>
      &gt;=A0=A0=A0=A0 diff --git a/sample/sample-keys/server.key
      b/sample/sample-keys/server.key<br>
      &gt;=A0=A0=A0=A0 index 976acab..011df12 100644<br>
      &gt;=A0=A0=A0=A0 --- a/sample/sample-keys/server.key<br>
      &gt;=A0=A0=A0=A0 +++ b/sample/sample-keys/server.key<br>
      &gt;=A0=A0=A0=A0 @@ -1,15 +1,28 @@<br>
      &gt;=A0=A0=A0=A0 ------BEGIN RSA PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0
      -MIICXgIBAAKBgQDLTqz5g1f2adIyKbS8reb3JiGJMzBDQKM12d4mAda08LwKGVWZ<br>
      &gt;=A0=A0=A0=A0
      -O/FMkWC2/XQ0jVrHYuzO8tYCzlcy9DWMcaBtZSrngK4pWc82c/h8SnOQ/DAo1UZ9<br>
      &gt;=A0=A0=A0=A0
      -NaROyZ+Qe+IJITbFqOyFgpoytJE7wdZPn9H4b2j0HdIGkTLMmkj9zZh/LwIDAQAB<br>
      &gt;=A0=A0=A0=A0
      -AoGBAKP1ljA/iY/zNY447kZ/5NWKzd7tBk4mcbl7M9no/7O6tZtbZRoIKoi6cYoC<br>
      &gt;=A0=A0=A0=A0
      -C1ZabUyBbkNTud5XdCFmq0zRUjOWvoFMZ9VZfd2kRPvl4TGczBtJAq65b+EYMGui<br>
      &gt;=A0=A0=A0=A0
      -q6T9p61xPdtzu0vM+Ecj127pAMk5XcJyxu8XQK7lZWmG5UoJAkEA8CxXNZN+A3qD<br>
      &gt;=A0=A0=A0=A0
      -bMBPI3VdwKCNSjNVEQEnygMbNgw7VLdxPpspzZziqJEGdzsM4dsnOBwKxIWFLN2h<br>
      &gt;=A0=A0=A0=A0
      -lbGBOquAswJBANi0atGWM8VUxDjvqqHCTS9RUXWgnvYhee4/xraJBQPBSivjC9P0<br>
      &gt;=A0=A0=A0=A0
      -vKT7PjBHU6djtKSLKGaHn1vHqmyY7PCMjZUCQQCNVSqExqSzG1dXmdt4PErNXi2G<br>
      &gt;=A0=A0=A0=A0
      -6qo2dX2arTVIGu6XLdQgSWLSMm5XT/CEHWW5SyPLKwVTHFeATXQXCPvJML9tAkEA<br>
      &gt;=A0=A0=A0=A0
      -k0yXax0g1ZoXwufN4SQUmPw6Va03P/BjU/nP1ZVvbiz9gLVU/d7WN4J7tA9XomkY<br>
      &gt;=A0=A0=A0=A0
      -idv5OzAmtxkSE70jGSNAvQJAWhCf9+iHkzOHRyKKOYlh1DHUwDfSEp+hlZYg9H03<br>
      &gt;=A0=A0=A0=A0 -P2sraQzUxgWDY/DIY63KvW78ny863baFz7onz21MYGgJXg=3D=
=3D<br>
      &gt;=A0=A0=A0=A0 ------END RSA PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 +-----BEGIN PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0
      +MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCluKLuzrGmD2qy<br>
      &gt;=A0=A0=A0=A0
      +n9MiF3neCZhxePqnzjZRVFfHMZlW0YrWxf1S5ogOe/nqJ3q/PxTsqtL/i1ZYrMpR<br>
      &gt;=A0=A0=A0=A0
      +d8U8tuSDbyIGLVvr51nUq0LI1amHc7NzNlEvpdCQoodkVGwS07h2R2mvro8As3C5<br>
      &gt;=A0=A0=A0=A0
      +52c/jGo9eV+BJ6MOqqc9gUgQsRhsOC6PenvFPSHI+aB/FyuIT7ry7G0kjmzxClzZ<br>
      &gt;=A0=A0=A0=A0
      +W7Gw/EnLStJYxiolsJeEw57/NIwQRn8P+zxZeqYpDK6OUDryU4RALdWRewo3joJ3<br>
      &gt;=A0=A0=A0=A0
      +zmYvNHdcpUU7ABmnB9GS5ma5O07pY/wzmBquewh9Ct96uqpZbYaCCmQr2lmnTE7v<br>
      &gt;=A0=A0=A0=A0
      +Pb0EoksxAgMBAAECggEAPMOMin+jR75TYxeTNObiunVOPh0b2zeTVxLT9KfND7ZZ<br>
      &gt;=A0=A0=A0=A0
      +cBK8pg79SEJRCnhbW5BnvbeNEkIm8PC6ZlDCM1bkRwUStq0fDUqQ95esLzOYq5/S<br>
      &gt;=A0=A0=A0=A0
      +5qW98viblszhU/pYfja/Zi8dI1uf96PT63Zbt0NnGQ9N42+DLDeKhtTGdchZqiQA<br>
      &gt;=A0=A0=A0=A0
      +LeSR0bQanY4tUUtCNYvBT8E3pzhoIsUzVwzIK53oovRpcOX3pMXVYZsmNhXdFFRy<br>
      &gt;=A0=A0=A0=A0
      +YkjMXpj7fGyaAJK0QsC+PsgrKuhXDzDttsG2lI/mq9+7RXB3d/pzhmBVWynVH2lw<br>
      &gt;=A0=A0=A0=A0
      +iQ7ONkSz7akDz/4I4WmxJep+FfQJYgK6rnLAlQqauQKBgQDammSAprnvDvNhSEp8<br>
      &gt;=A0=A0=A0=A0
      +W+xt7jQnFqaENbGgP0/D/OZMXc4khgexqlKFmSnBCRDmQ6JvLTWqDXC4+aqAbFQz<br>
      &gt;=A0=A0=A0=A0
      +zAIjiKaT+so8xvFRob+rBMJY5JLYKNa+zUUanfORUNYLFJPvFqnrWGaJ9uufdaM7<br>
      &gt;=A0=A0=A0=A0
      +0a5bu95PN74NXee3DBbpBv8HLwKBgQDCEk+IjNbjMT+Neq0ywUeM5rFrUKi92abe<br>
      &gt;=A0=A0=A0=A0
      +AgsVpjbighRV+6jA2lZFJcize+xYJ9wiOR1/TEI9PZ2OtBkqpwVdvTEHTagRLcvd<br>
      &gt;=A0=A0=A0=A0
      +NfGcptREDnNLoNWA22buQpztiEduutACWQsrd+JQmqbUicUdW4zw86/oCMbYCW3V<br>
      &gt;=A0=A0=A0=A0
      +QmYOLns7nwKBgHHUX20WZE91S4pmqFKlUzHTDdkk1ESX6Qx2q0R01j8BwawHFs6O<br>
      &gt;=A0=A0=A0=A0
      +0DW9EZ7w55nfsh+OPRl1sjK/3ubMgfQO0TZLm+IGf3Sya0qEnVeiPMkpDMX+TgRA<br>
      &gt;=A0=A0=A0=A0
      +wzEe+ou6uho+9uFSvdxMxeglaYA5M2ycvNwLsbEyZ4ZyVYxdgTiKahYFAoGAcIfP<br>
      &gt;=A0=A0=A0=A0
      +iD0qKQiYcj/tB94cz+3AeJqHjbYT1O1YYhBECOkmQ4kuG80+cs/q5W/45lEOiuWV<br>
      &gt;=A0=A0=A0=A0
      +Xgfo7Lu6jVGOujWoneci87oqtvNYH4e09oGh2WiLoBG9Wv9dWtBTUERSLzmxfXsG<br>
      &gt;=A0=A0=A0=A0
      +SAk2uEhEbj8IhfJc8iZLHH9iVUh6YEslBBodqL8CgYEAlAhvcqAvw5SzsfBR5Mcu<br>
      &gt;=A0=A0=A0=A0
      +4Nql6mXEVhHCvS4hdFCGaNF0z9A6eBORKJpdLWnqhpquDQDsghWE+Ga4QKSNFIi1<br>
      &gt;=A0=A0=A0=A0
      +fnAaykmZuY3ToqNOIaVlYM6HpMEz0wHQbTWfDLGcTFcElLZgMAk7VlDyiYVOco+E<br>
      &gt;=A0=A0=A0=A0 +QX9lXOO1PGpLzXhlDxSe63Y=3D<br>
      &gt;=A0=A0=A0=A0 +-----END PRIVATE KEY-----<br>
      &gt;=A0=A0=A0=A0 --<br>
      &gt;=A0=A0=A0=A0 1.9.1<br>
      &gt;<br>
      &gt;<br>
      &gt;<br>
      &gt;<br>
      &gt;
---------------------------------------------------------------------------=
---<br>
      &gt; Comprehensive Server Monitoring with Site24x7.<br>
      &gt; Monitor 10 servers for $9/Month.<br>
      &gt; Get alerted through email, SMS, voice calls or mobile push
      notifications.<br>
      &gt; Take corrective actions from your mobile device.<br>
      &gt;
<a class=3D"moz-txt-link-freetext" href=3D"http://pubads.g.doubleclick.net/=
gampad/clk?id=3D154624111&amp;iu=3D/4140/ostg.clktrk">http://pubads.g.doubl=
eclick.net/gampad/clk?id=3D154624111&amp;iu=3D/4140/ostg.clktrk</a><br>
      &gt;<br>
      &gt;<br>
      &gt; _______________________________________________<br>
      &gt; Openvpn-devel mailing list<br>
      &gt; <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Openvpn-dev=
el@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a><br>
      &gt; <a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourcef=
orge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/=
listinfo/openvpn-devel</a></span><br>
    <br>
    <br>
    -----BEGIN PGP SIGNATURE-----<br>
    Version: GnuPG v1<br>
    <br>
    iEYEARECAAYFAlRncRIACgkQwp2X7RmNIqO9gACglDoO+mMUHDl2z+G6doMe0pYp<br>
    vUYAn1fyUOEfVje+/fUZhLzeD/4oRCmV<br>
    =3DVmdE<br>
    -----END PGP SIGNATURE-----<br>
    <br>
  </body>
</html>

--------------060807030303030606060902--

