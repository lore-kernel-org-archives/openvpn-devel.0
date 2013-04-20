Message-ID: <51726D65.8010405@...1227...>
Date: Sat, 20 Apr 2013 12:26:45 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1366393268-27392-1-git-send-email-gert@...1296...>
	<1366393268-27392-4-git-send-email-gert@...1296...>
In-Reply-To: <1366393268-27392-4-git-send-email-gert@...1296...>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms040502090100090106060107"
Subject: Re: [Openvpn-devel] [PATCH 3/5] Minor fix to process_ipv4_header so
 that any combination of options can be defined.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: James Yonan <james@...515...>, openvpn-devel@lists.sourceforge.net

Dies ist eine kryptografisch unterzeichnete Nachricht im MIME-Format.

--------------ms040502090100090106060107
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

Am 19.04.13 19:41, schrieb Gert Doering:
> From: James Yonan <james@...515...>
>
> OpenVPN SVN r8219, slightly adapted for conflicts brought in by
> commit f0e8997a874a89b3 (IPv6 MSSFIX implementation).
I don't think this patch is a good idea. If PASSTOS_CAPABILITY is not=20
defined the if will always be true since PIPV4_PASSTOS is always=20
included in flags. See my patch from today too.

> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>   src/openvpn/forward.c | 6 +-----
>   src/openvpn/forward.h | 4 +++-
>   2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 447b86d..8f1f1e5 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1026,11 +1026,7 @@ process_ip_header (struct context *c, unsigned int=
 flags, struct buffer *buf)
>          * The --passtos and --mssfix options require
>          * us to examine the IPv4 header.
>          */
> -#if PASSTOS_CAPABILITY
> -      if (flags & (PIPV4_PASSTOS|PIP_MSSFIX))
> -#else
> -      if (flags & PIP_MSSFIX)
> -#endif
> +      if (flags & PIP_OPT_MASK)
>   	{
>   	  struct buffer ipbuf =3D *buf;
>   	  if (is_ipv4 (TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
> diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
> index 1830a00..0ece01e 100644
> --- a/src/openvpn/forward.h
> +++ b/src/openvpn/forward.h
> @@ -229,9 +229,11 @@ bool send_control_channel_string (struct context *c,=
 const char *str, int msglev
>=20=20=20
>   #define PIPV4_PASSTOS         (1<<0)
>   #define PIP_MSSFIX            (1<<1)         /* v4 and v6 */
> -#define PIPV4_OUTGOING        (1<<2)
>   #define PIPV4_EXTRACT_DHCP_ROUTER (1<<3)
>   #define PIPV4_CLIENT_NAT      (1<<4)
> +#define PIP_OPT_MASK          0xFFFF         /* all possible options for=
 */
> +                                             /* process_ip_header() */
> +#define PIPV4_OUTGOING        (1<<16)
>=20=20=20
>   void process_ip_header (struct context *c, unsigned int flags, struct b=
uffer *buf);
>=20=20=20



--------------ms040502090100090106060107
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Kryptografische Unterschrift

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIP5DCC
BCEwggMJoAMCAQICAgDHMA0GCSqGSIb3DQEBBQUAMHExCzAJBgNVBAYTAkRFMRwwGgYDVQQK
ExNEZXV0c2NoZSBUZWxla29tIEFHMR8wHQYDVQQLExZULVRlbGVTZWMgVHJ1c3QgQ2VudGVy
MSMwIQYDVQQDExpEZXV0c2NoZSBUZWxla29tIFJvb3QgQ0EgMjAeFw0wNjEyMTkxMDI5MDBa
Fw0xOTA2MzAyMzU5MDBaMFoxCzAJBgNVBAYTAkRFMRMwEQYDVQQKEwpERk4tVmVyZWluMRAw
DgYDVQQLEwdERk4tUEtJMSQwIgYDVQQDExtERk4tVmVyZWluIFBDQSBHbG9iYWwgLSBHMDEw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDpm8NnhfkNrvWNVMOWUDU9YuluTO2U
1wBblSJ01CDrNI/W7MAxBAuZgeKmFNJSoCgjhIt0iQReW+DieMF4yxbLKDU5ey2QRdDtoAB6
fL9KDhsAw4bpXCsxEXsM84IkQ4wcOItqaACa7txPeKvSxhObdq3u3ibo7wGvdA/BCaL2a869
080UME/15eOkyGKbghoDJzANAmVgTe3RCSMqljVYJ9N2xnG2kB3E7f81hn1vM7PbD8URwoqD
oZRdQWvY0hD1TP3KUazZve+Sg7va64sWVlZDz+HVEz2mHycwzUlU28kTNJpxdcVs6qcLmPkh
nSevPqM5OUhqjK3JmfvDEvK9AgMBAAGjgdkwgdYwcAYDVR0fBGkwZzBloGOgYYZfaHR0cDov
L3BraS50ZWxlc2VjLmRlL2NnaS1iaW4vc2VydmljZS9hZl9Eb3dubG9hZEFSTC5jcmw/LWNy
bF9mb3JtYXQ9WF81MDkmLWlzc3Vlcj1EVF9ST09UX0NBXzIwHQYDVR0OBBYEFEm3xs/oPR9/
6kR7Eyn38QpwPt5kMB8GA1UdIwQYMBaAFDHDeRu69VPXF+CJei0XbAqzK50zMA4GA1UdDwEB
/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgECMA0GCSqGSIb3DQEBBQUAA4IBAQA74Vp3wEgX
3KkY7IGvWonwvSiSpspZGBJw7Cjy565/lizn8l0ZMfYTK3S9vYCyufdnyTmieTvhERHua3iR
M347XyYndVNljjNj7s9zw7CSI0khUHUjoR8Y4pSFPT8z6XcgjaK95qGFKUD2P3MyWA0Ja6ba
hWzAP7uNZmRWJE6uDT8yNQFb6YyC2XJZT7GGhfF0hVblw/hc843uR7NTBXDn5U2KaYMo4RMJ
hp5eyOpYHgwf+aTUWgRo/Sg+iwK2WLX2oSw3VwBnqyNojWOl75lrXP1LVvarQIc01BGSbOyH
xQoLBzNytG8MHVQs2FHHzL8w00Ny8TK/jM5JY6gA9/IcMIIFTjCCBDagAwIBAgIEC4nvvjAN
BgkqhkiG9w0BAQUFADBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZOLVZlcmVpbjEQMA4G
A1UECxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xvYmFsIC0gRzAxMB4X
DTA3MTIyMDEzNDYyNFoXDTE5MDYzMDAwMDAwMFowgb4xCzAJBgNVBAYTAkRFMR8wHQYDVQQK
ExZVbml2ZXJzaXRhZXQgUGFkZXJib3JuMUAwPgYDVQQLEzdJTVQgKFplbnRydW0gZnVlciBJ
bmZvcm1hdGlvbnMtIHVuZCBNZWRpZW50ZWNobm9sb2dpZW4pMSgwJgYDVQQDEx9Vbml2ZXJz
aXRhZXQgUGFkZXJib3JuIENBIC0gRzAxMSIwIAYJKoZIhvcNAQkBFhNjYUB1bmktcGFkZXJi
b3JuLmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApyEfhJPUiCaLTtclTNlw
rHd4MT4ygOzcUD7zDRElXdILoAEQeUs9qpMZDpPXLeSK6DNukMnURrCRUIr+lYX/kmT6ompB
GMJgDepewHa97XS3uvE46NW2V8OdIiNddYIoDa8ZRd9lwIsnVWl9QaM9f7l5dhrSQT6ogboy
byOqJcmb+hlxgQcMWdLzZsOXRkldl5YXUCvC6zbulszlqMt5hPjsQmbQu0nInJmNwUrYCw9c
ctS2i0m9LaVwZxSov16/eQAJOM7bDV9CpZicgCkHACP5paKvlukP9glkvfNdS54grkPmGFNp
uIc13W6pL1+8nTp03AlyW/GU2zsnX5pWdwIDAQABo4IBtTCCAbEwEgYDVR0TAQH/BAgwBgEB
/wIBATALBgNVHQ8EBAMCAQYwHQYDVR0OBBYEFIHPTJq8rw/LvuzgIidOKe+uMMUeMB8GA1Ud
IwQYMBaAFEm3xs/oPR9/6kR7Eyn38QpwPt5kMB4GA1UdEQQXMBWBE2NhQHVuaS1wYWRlcmJv
cm4uZGUwgYgGA1UdHwSBgDB+MD2gO6A5hjdodHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2Jh
bC1yb290LWNhL3B1Yi9jcmwvY2FjcmwuY3JsMD2gO6A5hjdodHRwOi8vY2RwMi5wY2EuZGZu
LmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jcmwvY2FjcmwuY3JsMIGiBggrBgEFBQcBAQSBlTCB
kjBHBggrBgEFBQcwAoY7aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9w
dWIvY2FjZXJ0L2NhY2VydC5jcnQwRwYIKwYBBQUHMAKGO2h0dHA6Ly9jZHAyLnBjYS5kZm4u
ZGUvZ2xvYmFsLXJvb3QtY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0MA0GCSqGSIb3DQEBBQUA
A4IBAQAaomheE7QGeiZFxhmjRI97H/eQUUjp2RL2N4BQmulz56nwTFfgGN1v9kJmBuM2se7F
TSfQ0ZsKYJhZYwZYCb4Ob57h5zpsyMtZhWqz6n5+ewT/Wl7jc6sLGl3zquMZRfS1N3nIOWsN
rAZz4lxpjcOJwQHQevWpJT2NxTHHtHKA83QWLFAFs65ZIVAVxqYlRd9Yrr/ljK42ZzEaZgg8
vSqDzHOwvWX5m3apWe3ZW+2eqjDGZxwfWnWBMSGYN0QIFdaZLR1JbILLfYYHyAUixHUFA+76
2E9gufC2CySlXhNSPRTwqwPQIDTFDi2VIsafaivs7kVKPaKSq1Dh6SDfV2raMIIGaTCCBVGg
AwIBAgIEES7tRDANBgkqhkiG9w0BAQUFADCBvjELMAkGA1UEBhMCREUxHzAdBgNVBAoTFlVu
aXZlcnNpdGFldCBQYWRlcmJvcm4xQDA+BgNVBAsTN0lNVCAoWmVudHJ1bSBmdWVyIEluZm9y
bWF0aW9ucy0gdW5kIE1lZGllbnRlY2hub2xvZ2llbikxKDAmBgNVBAMTH1VuaXZlcnNpdGFl
dCBQYWRlcmJvcm4gQ0EgLSBHMDExIjAgBgkqhkiG9w0BCQEWE2NhQHVuaS1wYWRlcmJvcm4u
ZGUwHhcNMTAxMjIwMTUwMTA5WhcNMTMxMjE5MTUwMTA5WjBFMQswCQYDVQQGEwJERTEfMB0G
A1UEChMWVW5pdmVyc2l0YWV0IFBhZGVyYm9ybjEVMBMGA1UEAxMMQXJuZSBTY2h3YWJlMIIC
IjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAnPJmVFDViSIHhAokNLoZ4oFd0W4hFiC4
KopjqHhHEBynYMD56GYnxXm5ie4ngil1e69r02M6eyB1VIhRPFRSqD3ejVHRdNLKnEzWgAbT
o0Kkr2s7P1iPe8Cj55mSuOxplxcsxL8jU0U/ENtIaIEaI7sVlmYBmCT0fGfrpUcRj21ucDx9
zw1CJN6VEUmlLtvDzscJg3bUvttbxA+IMUDMTd0nUgLy5lNAg17f3QUc7SrXj8QItjPGjOU3
EnIka1D2ak+FT12j2GWVpbqkV2Pfow6fePda19xcjFs1A3MsfU4ouTfJ5Xx6OBM1/BRwB0Sg
79LcmCRtWjGkN7boXmxi5MUXMl96l7UzGEy49O39Ct41N96T4bJDqRKFaUcZVVvW7pBX+rVd
JrXXstiJ1HYGKU2yOgiqoLNIbhn1i3JoFP1SRSEYJb1okeL9Ewr0SoyM/suVuGg5YnMLHOjn
oH3XzMM0vRdEk7F1KaJvcvPDe/5fAAaOokjOIdOFwwhJkvOF/P1oS1RzvmTzwXTvojBbWZnr
+eL+zwTUVpOwJ+rfLdJzw+ER18RbpH/TPzOszvAAuTxZAQdEE+SOlk2aDIHs+eFYsk6QBh1b
jqOMDhlmElVROTv+w260iVGfcq4fTt1C8vzMcRx95y5rR5+GVQpGJb5WlZlbo3o/FCxClvt7
3SUCAwEAAaOCAeUwggHhMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgXgMCkGA1UdJQQiMCAGCCsG
AQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAjAdBgNVHQ4EFgQUWh2256whSHo0mgJ5hvYj
UacnOekwHwYDVR0jBBgwFoAUgc9MmryvD8u+7OAiJ04p764wxR4wIwYDVR0RBBwwGoEYc2No
d2FiZUB1bmktcGFkZXJib3JuLmRlMIGNBgNVHR8EgYUwgYIwP6A9oDuGOWh0dHA6Ly9jZHAx
LnBjYS5kZm4uZGUvdW5pLXBhZGVyYm9ybi1jYS9wdWIvY3JsL2NhY3JsLmNybDA/oD2gO4Y5
aHR0cDovL2NkcDIucGNhLmRmbi5kZS91bmktcGFkZXJib3JuLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMIGmBggrBgEFBQcBAQSBmTCBljBJBggrBgEFBQcwAoY9aHR0cDovL2NkcDEucGNhLmRm
bi5kZS91bmktcGFkZXJib3JuLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBJBggrBgEFBQcw
AoY9aHR0cDovL2NkcDIucGNhLmRmbi5kZS91bmktcGFkZXJib3JuLWNhL3B1Yi9jYWNlcnQv
Y2FjZXJ0LmNydDANBgkqhkiG9w0BAQUFAAOCAQEAgaSs5nrXX49tNOF1ISWT4U4yEpbkiXBu
1YmhBUz+zLFWvh8uNlfllgMZqVV94ftgyizWOesc+vxL0ulNmdXhOAB+zSyT2qgQ9vv9GSV8
cgkEGMrwMpyJQksI/UvdZ1+SyUxpW2mSMm/N6y3QVefv6HajWju63tGXAXX1ohsxfisWQC7h
51dnhLVwTf5yVEbl0uoLv236V0IlhoPcVMaNiLv9W5P13vwYLMRxhzvgQPAB8GwyQ4X2k9tS
naLB/AXfOZpvPx0XvpW5+dY9Lyo7EJFYMl+S0WMsD4XEj18VJWmTrvIO7ZGhU1En8+9OEwjZ
NlrBHSSoHZ8AtjaqRf+DwTGCBXYwggVyAgEBMIHHMIG+MQswCQYDVQQGEwJERTEfMB0GA1UE
ChMWVW5pdmVyc2l0YWV0IFBhZGVyYm9ybjFAMD4GA1UECxM3SU1UIChaZW50cnVtIGZ1ZXIg
SW5mb3JtYXRpb25zLSB1bmQgTWVkaWVudGVjaG5vbG9naWVuKTEoMCYGA1UEAxMfVW5pdmVy
c2l0YWV0IFBhZGVyYm9ybiBDQSAtIEcwMTEiMCAGCSqGSIb3DQEJARYTY2FAdW5pLXBhZGVy
Ym9ybi5kZQIEES7tRDAJBgUrDgMCGgUAoIICgzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0xMzA0MjAxMDI2NDVaMCMGCSqGSIb3DQEJBDEWBBSKhkCD6gjI
gxNKlTo5RLPxJiu6sDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQME
AQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIH
MA0GCCqGSIb3DQMCAgEoMIHYBgkrBgEEAYI3EAQxgcowgccwgb4xCzAJBgNVBAYTAkRFMR8w
HQYDVQQKExZVbml2ZXJzaXRhZXQgUGFkZXJib3JuMUAwPgYDVQQLEzdJTVQgKFplbnRydW0g
ZnVlciBJbmZvcm1hdGlvbnMtIHVuZCBNZWRpZW50ZWNobm9sb2dpZW4pMSgwJgYDVQQDEx9V
bml2ZXJzaXRhZXQgUGFkZXJib3JuIENBIC0gRzAxMSIwIAYJKoZIhvcNAQkBFhNjYUB1bmkt
cGFkZXJib3JuLmRlAgQRLu1EMIHaBgsqhkiG9w0BCRACCzGByqCBxzCBvjELMAkGA1UEBhMC
REUxHzAdBgNVBAoTFlVuaXZlcnNpdGFldCBQYWRlcmJvcm4xQDA+BgNVBAsTN0lNVCAoWmVu
dHJ1bSBmdWVyIEluZm9ybWF0aW9ucy0gdW5kIE1lZGllbnRlY2hub2xvZ2llbikxKDAmBgNV
BAMTH1VuaXZlcnNpdGFldCBQYWRlcmJvcm4gQ0EgLSBHMDExIjAgBgkqhkiG9w0BCQEWE2Nh
QHVuaS1wYWRlcmJvcm4uZGUCBBEu7UQwDQYJKoZIhvcNAQEBBQAEggIAZJm5Oz8ef0o8+4nV
ViB8++uz1DETxnOTAuwvU5j9CioPfiCC36w7lU2KT2fINZ/xyb1ouTR4tVxs3sFVCiYL/o5e
yEGsgMfI5JjzhJuAzaT+yFqBvmilzXQ4zP5FHeHOPMvleUe6LA5XfCAFAxSnLga/M6pXuwY0
5Jwgdd4moPZVkXOqWLcpXrGhKD8RtpiQ8np5FopbCf8ntv+ec1Q0FvYifQUFptkcFy8O43jq
9kpsF9V7eZHpGjgQkOwoXvZt2mKa1J3kTazav/ekDnbwapUN4tU02rFRliPvDmDlXqy6cGAh
Am3biQplE8470CBmu9M2KrBRuW5UzQx/SciQFr2hQtpxPYxnHELDh7D1bwkcKRNI9+oIycnk
OBZNvEa4Klhqu3WHY7HgDfsO1F3AkMavU3I5boUdFqcDi5CCrOZUzRWR1OOCY7AQA2IYQfkl
bXz06JnY9QhSq6oELxekgt0Xe25fMOkG4isXpucrYvJAN9LgYyl08uztmcmh+jNF05LeabJ7
oo+vjSIja7rPt8LAt1W2SyEbRj/1dW4aXQRCqlpa7JiIMYO+ZDce5H3oBaTrbIySdGQfuqK2
b9maFYcO3hrtIAYqBp6hpftgxmx9YnxxyaAZl2KydpZj1MMTEOnxu/WvftB2vuApt5fWLFuv
0stfNZ816qyF1TudOv8AAAAAAAA=
--------------ms040502090100090106060107--

