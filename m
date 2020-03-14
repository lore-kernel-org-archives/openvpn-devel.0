Date: Sat, 14 Mar 2020 13:44:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200314124428.GE1431@...1296...>
References: <20200310094822.588-1-simon@...2293...>
 <20200310094822.588-2-simon@...2293...>
 <CAGyAFMX-vanP-DQbige7GjhV7oHdez_aX09i6W6BEbng57tQag@...278...>
 <99D61A626FDA8A4B90A270669121BE10D082286F@...2294...>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha-256; boundary="jiG1sp+CfApzbQkA"
Content-Disposition: inline
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10D082286F@...2294...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] tun.c: revise the IPv4 ifconfig
 flow on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: Lev Stipakov <lstipakov@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jiG1sp+CfApzbQkA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 13, 2020 at 02:47:39AM +0000, Simon Rozman wrote:
> True. I'm sure I got this in the original commit back then. Found it... W=
hen rebasing onto the current master, it conflicted and I dropped that chan=
ge rather than fixing it. Wrong choice, sorry.

Am I reading this correctly, a v2 version of this patch is coming?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jiG1sp+CfApzbQkA
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIOaAYJKoZIhvcNAQcCoIIOWTCCDlUCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgggt3MIIGgzCCBGugAwIBAgIQT94QS+2VW96LrWWHzEFe4zANBgkqhkiG9w0BAQsFADBr
MQswCQYDVQQGEwJJVDEOMAwGA1UEBwwFTWlsYW4xIzAhBgNVBAoMGkFjdGFsaXMgUy5wLkEu
LzAzMzU4NTIwOTY3MScwJQYDVQQDDB5BY3RhbGlzIEF1dGhlbnRpY2F0aW9uIFJvb3QgQ0Ew
HhcNMTkwOTIwMDcxMjA1WhcNMzAwOTIyMTEyMjAyWjCBjTELMAkGA1UEBhMCSVQxEDAOBgNV
BAgMB0JlcmdhbW8xGTAXBgNVBAcMEFBvbnRlIFNhbiBQaWV0cm8xIzAhBgNVBAoMGkFjdGFs
aXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50
aWNhdGlvbiBDQSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALdoc3rZPNQv
+9xnyj3OlHz/iRnO2hpj8xlHkCdYKNwnRabAT6J0RA11A3ZkQiEZEw66B99ES7Ezv9IRBYmI
wsr720lUptObF5L3yVzl3nzaittXwWsq+CQoDEci1cKkWF5SiO22+Np2Epu2HFxkw5nXMnZi
brqnC6hUGsFogTDUUVRIuLlublwWYFhpqvDaCh//ucRgRW3+rTU1nBoT1XHkXrLsCteefjoh
+o01tNTWvGi4+3OyABidGPXuoYh7UbYX1u0sG1O8rO92t5zV7/Cr/Vza9EbySh6DrCqsY333
sNxikKzFyBwebZv43t1xJyMVE/CRt7BLJOyHxd1Yq0sCAwEAAaOCAf4wggH6MA8GA1UdEwEB
/wQFMAMBAf8wHwYDVR0jBBgwFoAUUtiIOsifeGbtifN7OHCUyQICNtAwQQYIKwYBBQUHAQEE
NTAzMDEGCCsGAQUFBzABhiVodHRwOi8vb2NzcDA1LmFjdGFsaXMuaXQvVkEvQVVUSC1ST09U
MEUGA1UdIAQ+MDwwOgYEVR0gADAyMDAGCCsGAQUFBwIBFiRodHRwczovL3d3dy5hY3RhbGlz
Lml0L2FyZWEtZG93bmxvYWQwJwYDVR0lBCAwHgYIKwYBBQUHAwIGCCsGAQUFBwMEBggrBgEF
BQcDCTCB4wYDVR0fBIHbMIHYMIGWoIGToIGQhoGNbGRhcDovL2xkYXAwNS5hY3RhbGlzLml0
L2NuJTNkQWN0YWxpcyUyMEF1dGhlbnRpY2F0aW9uJTIwUm9vdCUyMENBLG8lM2RBY3RhbGlz
JTIwUy5wLkEuJTJmMDMzNTg1MjA5NjcsYyUzZElUP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxp
c3Q7YmluYXJ5MD2gO6A5hjdodHRwOi8vY3JsMDUuYWN0YWxpcy5pdC9SZXBvc2l0b3J5L0FV
VEgtUk9PVC9nZXRMYXN0Q1JMMB0GA1UdDgQWBBRr8o2eaMElBB9RNFf2FlyU6k1pGjAOBgNV
HQ8BAf8EBAMCAQYwDQYJKoZIhvcNAQELBQADggIBAGBEuhmiq3L7DkGaRMG6FTm9na4v3ya3
KW+xkhFvSZgPinqeBi5qfV+dCL/BCuO/JMH9mgI5z57DnYiLQC3CIHnEtalcTfhGPleRgjRM
uFQLAeYM5UAZiiPT+D8S7faZ0CZ3glRLw51QTGQJZSC+bN7mgoiBG/HmGahvLWjlkjNZ6o6A
mVC3HIV1mGowamiYNEVDmen+SAdJW9uhwP+xFFZodZ0lYJQ6FHg+3pSDVx6YdM94n9e9tlMn
XKB+CY92WmPXbUOMCUjYUmTsxEu9lJEusHv+eehThrO6HiVrkHvEathHnkhphpYmSlG2KOIw
fwtqJjJ9C+EMCOcDDa1ndhUTVFMMTAZmyWLRGg0U0O9hzwPA520ZL0Q0iZI7E6KlOmaQZQX+
LORMK4V6hVW9qzPZhgjw2SYux8N8vAWA/3d4ky+j1uVIzk0qRXJ0iD+B1uTyOjEx15fmm+mo
wp7ycOhNUxi4d8ycqb+QkPBbZtM+zCi7eWa9hOI6I2V3mZ9bFKUqonWcqfZhvy2DEZhzJLYQ
0Zw5ztrR7+fmDjuHFBG07eQcMBOUT46qL7J3ncneUooyCvpNTAlxSzE3xEc96lDd4v38Lnl3
BsuIxH9p/xb2LBGNxgR12QjFVj33wX25fyE47PUPTRt+2wBJv5oNsjatNjS4w20CCoLfVtGg
VPUrMIIE7DCCA9SgAwIBAgIQGCZm32y61wz2BKsCnLiHNTANBgkqhkiG9w0BAQsFADCBjTEL
MAkGA1UEBhMCSVQxEDAOBgNVBAgMB0JlcmdhbW8xGTAXBgNVBAcMEFBvbnRlIFNhbiBQaWV0
cm8xIzAhBgNVBAoMGkFjdGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3Rh
bGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBHMjAeFw0yMDAxMTkwOTUxMzdaFw0yMTAx
MTkwOTUxMzdaMB4xHDAaBgNVBAMME2dlcnRAZ3JlZW5pZS5tdWMuZGUwggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQCeqqrUTXC5aC8lE8wh50lzOCH/VVMNH8tWA6bQK7P3kbV5
MiAEKyZxwHew5o3CX47QCyVVdZ1ZqudJetIluwLgJEy4TaoPVJpu47nPm+XehREIZKGIVACS
BZBD3Z9km+kRAEVh4kGwvFKyDBPDhr9rgliESE/i1WH5Vee4x6P19UE0f4q85H8HS/ImdRpU
iHS5O/rgzKrcZMxLH+X1dz82qLM6q9WdTNBb/M1W8KEc99K2ryFgzR9e3xM8qUHZegTFcFer
o1cEnvDTVCAeL9qT3+PFwCCaFQVi/sFFzHzcMoPJopMIrdRxk+La0rgz7GHdP12QuwohqXXm
I3qUZC57AgMBAAGjggG0MIIBsDAMBgNVHRMBAf8EAjAAMB8GA1UdIwQYMBaAFGvyjZ5owSUE
H1E0V/YWXJTqTWkaMH4GCCsGAQUFBwEBBHIwcDA7BggrBgEFBQcwAoYvaHR0cDovL2NhY2Vy
dC5hY3RhbGlzLml0L2NlcnRzL2FjdGFsaXMtYXV0Y2xpZzIwMQYIKwYBBQUHMAGGJWh0dHA6
Ly9vY3NwMDkuYWN0YWxpcy5pdC9WQS9BVVRIQ0wtRzIwHgYDVR0RBBcwFYETZ2VydEBncmVl
bmllLm11Yy5kZTBHBgNVHSAEQDA+MDwGBiuBHwEYATAyMDAGCCsGAQUFBwIBFiRodHRwczov
L3d3dy5hY3RhbGlzLml0L2FyZWEtZG93bmxvYWQwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsG
AQUFBwMEMEgGA1UdHwRBMD8wPaA7oDmGN2h0dHA6Ly9jcmwwOS5hY3RhbGlzLml0L1JlcG9z
aXRvcnkvQVVUSENMLUcyL2dldExhc3RDUkwwHQYDVR0OBBYEFJymozH746LrHExdIQiOJQ0+
tMWCMA4GA1UdDwEB/wQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAQEApgPrWd43/VMOMwFroz8G
qyjanZ2kADvySpLAfedPxaw+H2awyVPSB3rRa/xBKNzb8Onjq1qyjLlntZNbb9FyUZlmcQfv
UNSRORGPjSkwXam+n6zf+HPSEeTGzcWx5FaIIFLCAuyvJR5nNagLFT1I8O37AjuqwTy1qmp3
LrmPzzguhSN6MGmyQ/U1dJctSUevJ5bCEg6psCW2lKKdoV0Iqk7nRUgUYh+ZdoyQTGppOaY6
hEoohc5MfFiy3TC/6J0ug7wa/6vMYGpoTz+cETEWewYKjAE9b/o8GTUwlWnpUjal/Y28En1m
ouzEluy985yWo9ODjDKfPKVp8Y/wR3wvvjGCArUwggKxAgEBMIGiMIGNMQswCQYDVQQGEwJJ
VDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUgU2FuIFBpZXRybzEjMCEGA1UE
CgwaQWN0YWxpcyBTLnAuQS4vMDMzNTg1MjA5NjcxLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50
IEF1dGhlbnRpY2F0aW9uIENBIEcyAhAYJmbfbLrXDPYEqwKcuIc1MA0GCWCGSAFlAwQCAQUA
oIHkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDMxNDEy
NDQyOFowLwYJKoZIhvcNAQkEMSIEIAXIUG80U5B/h/UxbTTw0KZepNVF38hrWGTVSkpbjlwF
MHkGCSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQME
AQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIH
MA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBACq4mstHTr6LlXXnJ+o6VpbzhcSq
GlkXOsZD1Gz+kFXisyRiy9eiqTYVy1oPHxRRH8BdyZPqRmCXpmJY6MBktjyy/FLp54cxzi68
YHdOJ9hXB9Y8D5YrrLNpNAM9lvYio9eLLsZEFgmeNx3h1BO9ZX6aUS/OIa+3xCSSqcj5Qmt0
dARzsP72cAiYOdS1PBgljRgoq/aXPB14cC7s0zv9xSJ+YgH61HI1DN9wN1da3QTGcbk5uVSj
5Mg2JnzJtqG6aTkVe4qmEopahQPooNnCuekTmKiv5B8vFb2XpOh2RjbPnmJR5HVzjx4zqffd
5vSF954GNVgwJNQbx80XzEl3oI0=

--jiG1sp+CfApzbQkA--

