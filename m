Date: Mon, 25 Nov 2019 20:39:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191125193951.GV40538@...1296...>
References: <CAKuzo_g7kyhuoDNAC3dbg=HHZO4iSpR+zKQrd0Lpcn8cj9tH=Q@...278...>
 <CAGyAFMVdYrTgcA6kRawsVXjj48DXUqKw2Z0F7EpWQBOrTKrEFg@...278...>
 <CAKuzo_i0BouG604qJAO--qoX5TeTmYi_2CskF3FfqzOTO6dEWQ@...278...>
 <CAGyAFMWeN-G7qf=MJfuuZK5M72VJ_03ahdAFsi6aLDcUT_me6g@...278...>
 <CAKuzo_h4hbQmaQrPHdDTkPjGOdGS55tsGDKm4RfHY0vWuqF5Fw@...278...>
 <99D61A626FDA8A4B90A270669121BE10C9AF9896@...2294...>
 <CAGyAFMWEc0c_GRiphD+=zikh2BkMckxD4rjZXrmQfmLUejAkgA@...278...>
 <CAKuzo_howdUtX86vj9kTYga=r8Ce0rbnrSiciqfCNtVVVeFwbw@...278...>
 <CAGyAFMWc=A=D_HRUpHJTXcPZSqxWKK44Hvd1ykAyb8JgQZD_2Q@...278...>
 <99D61A626FDA8A4B90A270669121BE10C9B08A55@...2294...>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha-256; boundary="96Fzkco6h7mx3UO9"
Content-Disposition: inline
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10C9B08A55@...2294...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/7] wintun: implement opening wintun
 device
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: Lev Stipakov <lstipakov@...277...>, Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--96Fzkco6h7mx3UO9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 25, 2019 at 09:44:19AM +0000, Simon Rozman wrote:
> 1.	if adapter "My VPN Connection" doesn't exist, create it.
> 2.	else enable it
> 3.	use it
> 4.	disable it

> An annoyance here is, the adapters pile up over time. On multi-user=20
> computers, OpenVPN GUI don't have a complete overview which one are=20
> stale (no corresponding .ovpn file exist anymore) to clean them.=20

I like the initial approach, but the "pile-up" is annoying.

What about "do this for .ovpn configs that contain a --dev-node setting,
and otherwise just try to enumerate 'OpenVPN Wintun 1', 'OpenVPN Wintun 2',
... and create those as-needed?

This should keep the numbers down...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--96Fzkco6h7mx3UO9
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIOGgYJKoZIhvcNAQcCoIIOCzCCDgcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgggsfMIIF5jCCA86gAwIBAgIQapvhODv/K2ufAdXZuKdSVjANBgkqhkiG9w0BAQwFADCB
hTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMH
U2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBS
U0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1
OTU5WjCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
A1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENP
TU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+s55XrCh2dUAWxzgDmNPGGHYhUPMleQtM
taDRfTpYPpynMS6n9jR22YRq2tA9NEjk6vW7rN/5sYFLIP1of3l0NKZ6fLWfF2VgJ5cijKYy
/qlAckY1wgOkUMgzKlWlVJGyK+UlNEQ1/5ErCsHq9x9aU/x1KwTdF/LCrT03Rl/FwFrf1XTC
wa2QZYL55AqLPikFlgqOtzk06kb2qvGlnHJvijjI03BOrNpo+kZGpcHsgyO1/u1OZTaOo8wv
EU17VVeP1cHWse9tGKTDyUGg2hJZjrqck39UIm/nKbpDSZ0JsMoIw/JtOOg0JC56VzQgBo7i
ctReTQE5LFLG3yQK+xS1AgMBAAGjggE8MIIBODAfBgNVHSMEGDAWgBS7r34CPfqm8TyEjq3u
OJjs2TIy1DAdBgNVHQ4EFgQUgq9sjPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGG
MBIGA1UdEwEB/wQIMAYBAf8CAQAwEQYDVR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/
oD2GO2h0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRpb25BdXRo
b3JpdHkuY3JsMHEGCCsGAQUFBwEBBGUwYzA7BggrBgEFBQcwAoYvaHR0cDovL2NydC5jb21v
ZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1c3RDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAeFyygSg0TzzuX1bOn5dW7I+i
axf28/ZJCAbU2C81zd9A/tNx4+jsQgwRGiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzW
f/Lvx7/hk6zSPwIal9v5IkDcZoFD7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4
qQNqbGWlnhMpIMwpWZT89RY0wpJO+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp
2oY6dyNmNppI4ZNMUH4Tam85S1j6E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade
2022O/tUU1gb4jfWCcyvB8czm12FgX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztveBdvUCIYZ
ojTq/OCR6MvnzS6X72HP0PRLRTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDAfd9yI+O+IMMAj1Kc
L/Zo9jzJ16HO5m60ttl1Enk8MQkz/W3JlHaeI5iKFn4UJu1/cP2YHXYPiWf2JyBzsLBrGk1I
I+3yL8aorYew6CQvdVifC3HtwlSam9V1niiCfOBe2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggy
h/TqvXG5v7zmEVDNXFnHn9tFpMpOUvxhcsjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk
6h9KVkfKehIwggUxMIIEGaADAgECAhBoKGrilYL+DkBaaHjtexKaMA0GCSqGSIb3DQEBCwUA
MIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQH
EwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xODA4
MDYwMDAwMDBaFw0xOTA4MDYyMzU5NTlaMCQxIjAgBgkqhkiG9w0BCQEWE2dlcnRAZ3JlZW5p
ZS5tdWMuZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC/rjWbYvcc/uWCRkcT
MKbIJr4+mp2vJ7hS5iesOTfDb/BslZgSV9eK7k2QAVETO4w//HxmOzEWVSvoHHxE7blHw+QA
cECqc+O23z6BSHWi2WUe71IfljudN/aViJ1NAYvJy7Wa+3jinfy5fl8yl74o5L0L0Y8TJPOy
DZkCtzuGx6iG6ge0NC0wc+gzA0oXDmfPktmcE/YQhI+U+hoZHrKy/QyYXRHfi80wtdVJe6Zb
b226rg1Q2qLSgJ+OAQPhvzIo7qMYM3dzHJeZSoAW12t7TvKg8WlmgiVXdTk1Cs/WcCA7GS4l
V9NRAlznqgNHIQJHJe0jCqMxzOp9T7DgtZuxAgMBAAGjggHpMIIB5TAfBgNVHSMEGDAWgBSC
r2yM+MX+lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQU1XAEqUTyLyKp+6Tm4jnm5ioJ+dUwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYIKwYBBQUHAwQGCysGAQQB
sjEBAwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEBATAr
MCkGCCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBR
ME+gTaBLhklodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50
aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUH
MAKGSWh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0
aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9k
b2NhLmNvbTAeBgNVHREEFzAVgRNnZXJ0QGdyZWVuaWUubXVjLmRlMA0GCSqGSIb3DQEBCwUA
A4IBAQA/8e5BhoX7/1uR8xJIU9Bgr1kRHHYS0pwDwBb2qmVqwCVDj2wuV6YdN20xl3p23Fad
3e/Hf1riXhma9wnQKon/qhDjgVEKUcbXINtYTeuaF8v6zgEyo0VQqiEMQDwCTrxfZqZejjiB
0CO+TOtdTknb4EMYREHw+D8GZLa9/+6JyagLJLNUsganHfAl6d50iQMifqzyXSN0BFLXcdnp
0+99Ulo6k1aiAy8+83tK6Ludd5DY94bFCIdFub6z6nuqQIeWML5LPatzakdMFZLy1L9a9ePq
QEyhed3KH2jk23+2elJPGr/vs5ASGNtgBTbgM7n9aQR9xPAt0kLNwLI5byujMYICvzCCArsC
AQEwgawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAO
BgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRD
T01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhBo
KGrilYL+DkBaaHjtexKaMA0GCWCGSAFlAwQCAQUAoIHkMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MTEyNTE5Mzk1MVowLwYJKoZIhvcNAQkEMSIEICu8
AVdK8wezPPcFsTOb8GG+Qf7GuqEsX6setML4zKt6MHkGCSqGSIb3DQEJDzFsMGowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcN
AwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3
DQEBAQUABIIBAHbVfZok3XWAo5MY9hbSZLKen2Uv2KFEhFrFDFXzNLOEwoq/3NW2O51+O1/F
mcpK7IRbvPZXfIKChzd3rA+cETrC3Hh5xFtJNp9paOgz6cSMjVeStHAxrxMFHHCmqDf5qDEB
qFpvSDYTM2o9I+EZ2X5fZLFl7k7jfqX1xulavcBd68FYI5BXFVeXGRMx1ahyUcKuUSql3Wd9
ADTzHdsYnprCUgY35RkF6NfA6+j5hGMc9VUTEJ7XcqDYEqJJdyh7hV6UVVsM8GX4ukF+OMfv
RUQVn6pCbDVDqThJ8BpTHM9p7XLyNJgQ1koqf9kiLwK+SmutRLhcZqQ+rlFwpxj6GGE=

--96Fzkco6h7mx3UO9--

