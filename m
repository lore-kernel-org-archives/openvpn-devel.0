Date: Sat, 13 Sep 2025 19:18:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aMWnSmCWxa_m8F1r@...1296...>
References: <65233605-9738-4B2C-8401-37AA5C43D797@...2913...>
 <aMWICpJmVFAVXlKc@...1296...>
 <599E5024-02A6-418D-AB2C-599D03BE1111@...2913...>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha-256; boundary="Svsdo92/+pQo9wiG"
Content-Disposition: inline
In-Reply-To: <599E5024-02A6-418D-AB2C-599D03BE1111@...2913...>
Subject: Re: [Openvpn-devel] [PATCH] Bugfix: Set broadcast address on
 interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Sebastian Marsching <sebastian@...2913...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--Svsdo92/+pQo9wiG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 13, 2025 at 06:14:03PM +0200, Sebastian Marsching wrote:
> > Should Linux not be able to auto-calculate that, based on IP address
> > and netmask?
> You would think so, but it does not???

It seems so.  Thanks for the output examples.  Weird.

[..]
> It implements the way how the broadcast address is calculated slightly di=
fferently. For my patch, I took the inspiration from how iproute2 implement=
s it instead.

It's a bit unfortunate that *this* piece of code does not have the netmask
around anymore (having converted it carefully to a /netbits value...)

I'll leave this to Antonio to ACK, as it's all his code.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Svsdo92/+pQo9wiG
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename=smime.p7s
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
oIHkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDkxMzE3
MTgwMlowLwYJKoZIhvcNAQkEMSIEIHTBdzt7bxljbRfx4vYl9uysKLVWhhqGOF2q/NeMyBSN
MHkGCSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQME
AQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIH
MA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAIzbAhhOJiGUwbHpLP+xEjIYvGCw
IJsMHmwuxGuu6cKHYXiHHIP7Km23ktruMGNYdXaxksyRqUS55KewGgQELvIEdYZrAob1KvOO
8rPi0s/bjo6NJ5Uqj25Dclr9B2aSsTq4iJM43MZsjYrszbZQdgWKWFovLZjDO8XeI5+X8cCT
l24wWxvwFXJKMGpR+ynUvINJdyaINu4thMPryzX732yWXCyKNd6FcB+pFxtxiPzYnBH68krs
gDYhVZxKOJcMZBzt6Mkh2CaPlQv8/KiKJfg7D2Knq7sCkDiv8pL6bhOZfppywYe7SZaSIWIc
2nY78HBot3V9+HUxQtxIitAD0nc=

--Svsdo92/+pQo9wiG--

