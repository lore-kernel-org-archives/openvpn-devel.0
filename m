Message-ID: <52491AFC.2000105@...1420...>
Date: Mon, 30 Sep 2013 08:32:28 +0200
From: Christian Rank <christian.rank@...1420...>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms000501090307040107060601"
Subject: [Openvpn-devel] [PATCH] OpenVPN Windows uninstallation does not
	remove TAP driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--------------ms000501090307040107060601
Content-Type: multipart/mixed; boundary="------------060203080907070006010900"

This is a multi-part message in MIME format.
--------------060203080907070006010900
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Author: Christian Rank <christian.rank@...1420...>

32-bit Windows version of OpenVPN installed on a 64-bit Windows does not
remove TAP driver on uninstallation.

If you install OpenVPN on a 64-bit Windows using the 32-bit installer from
> http://swupdate.openvpn.org/community/releases/openvpn-install-2.3.2-I003=
-i686.exe
the TAP driver gets installed by default (if not deselected during
installation).

However, uninstalling the OpenVPN software leaves the TAP driver installed.

Here is patch for the NSIS configuration file which corrects this
installer issue.

Signed-off-by: Christian Rank <christian.rank@...1420...>

--=20
Dr. Christian Rank
Rechenzentrum Universit=E4t Passau
Bereich Netzwerk und Telekommunikation
IT-Sicherheitsbeauftragter der Universit=E4t
Innstr. 33
D-94032 Passau
GERMANY
Tel.: 0851/509-1838
Fax:  0851/509-1802


--------------060203080907070006010900
Content-Type: text/x-patch;
 name="openvpn.nsi.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn.nsi.patch"

*** openvpn.nsi	2013-09-26 11:19:46.000000000 +0200
--- openvpn-20130926.nsi	2013-09-26 14:26:16.000000000 +0200
***************
*** 509,516 ****
--- 509,519 ----
  	Sleep 3000
 =20
  	!ifdef USE_TAP_WINDOWS
+                 SetRegView 64
  		ReadRegStr $R0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninst=
all\${PACKAGE_NAME}" "tap"
+ 		ReadRegStr $R1 HKLM "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVe=
rsion\Uninstall\${PACKAGE_NAME}" "tap"
  		${If} $R0 =3D=3D "installed"
+ 		${OrIf} $R1 =3D=3D "installed"
  			ReadRegStr $R0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Unins=
tall\TAP-Windows" "UninstallString"
  			${If} $R0 !=3D ""
  				DetailPrint "TAP UNINSTALL"
***************
*** 518,523 ****
--- 521,527 ----
  				Pop $R0 # return value/error/timeout
  			${EndIf}
  		${EndIf}
+                 SetRegView lastused
  	!endif
 =20
  	${un.EnvVarUpdate} $R0 "PATH" "R" "HKLM" "$INSTDIR\bin"


--------------060203080907070006010900--

--------------ms000501090307040107060601
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIO7TCC
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
xQoLBzNytG8MHVQs2FHHzL8w00Ny8TK/jM5JY6gA9/IcMIIFLDCCBBSgAwIBAgIECfk9uzAN
BgkqhkiG9w0BAQUFADBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZOLVZlcmVpbjEQMA4G
A1UECxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xvYmFsIC0gRzAxMB4X
DTA3MDIxOTE1MjAxMloXDTE5MDIxODAwMDAwMFowgZ8xCzAJBgNVBAYTAkRFMQ8wDQYDVQQH
EwZQYXNzYXUxHDAaBgNVBAoTE1VuaXZlcnNpdGFldCBQYXNzYXUxFjAUBgNVBAsTDVJlY2hl
bnplbnRydW0xJTAjBgNVBAMTHFVuaXZlcnNpdGFldCBQYXNzYXUgQ0EgLSBHMDExIjAgBgkq
hkiG9w0BCQEWE2NhQHJ6LnVuaS1wYXNzYXUuZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQCHgNE07AUUNYr1fFuo47bkmM/6R+SPTDHZxa9+glXCbOrBEqZwT/GumzG3Xr2I
XimOX66uURF5JSZGIxi0B2QoE28g+mFSer03waQPBWshdB76F9FUTCgau/mVJ9DzFNk6x8h9
goOchMdwbbA2uVPb/UTfnGfzE+qqI9hLDQS/1D750pXNJcu4CpM7ly8fYW0n8GAlq3RFNkL8
ugPP9kvMxNhOzTVdOFsRhHR3Z+q5jh+zPB08SRmFOyJ4MMwR9wh4AqxwhoGNG5rmc6SqvNLk
epgidtTfiMVjcC9dD7JniSe8BDVvX8cx3XsObhsJVnlbFnqlbSZbc9ylwyM1JOvPAgMBAAGj
ggGyMIIBrjAPBgNVHRMBAf8EBTADAQH/MAsGA1UdDwQEAwIBBjAdBgNVHQ4EFgQUCbHfoehh
XaHNxvSDeTosBgyM7AgwHwYDVR0jBBgwFoAUSbfGz+g9H3/qRHsTKffxCnA+3mQwHgYDVR0R
BBcwFYETY2FAcnoudW5pLXBhc3NhdS5kZTCBiAYDVR0fBIGAMH4wPaA7oDmGN2h0dHA6Ly9j
ZHAxLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3QtY2EvcHViL2NybC9jYWNybC5jcmwwPaA7oDmG
N2h0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3QtY2EvcHViL2NybC9jYWNybC5j
cmwwgaIGCCsGAQUFBwEBBIGVMIGSMEcGCCsGAQUFBzAChjtodHRwOi8vY2RwMS5wY2EuZGZu
LmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBHBggrBgEFBQcwAoY7
aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY2FjZXJ0L2NhY2Vy
dC5jcnQwDQYJKoZIhvcNAQEFBQADggEBANhmIUVwpozSS3zYWc4IEtC5XNkraTGAWjORLd3i
nLJ15ps9u0yypoAorDWMZN2VRdh5/YzVli2VWF9sEKQeyzJ70Ds9cVauFoVH94R7vYZvHR8k
xytLa8DTSWDL8SgEoiI9C5BrA7ek1kFeH/nNVFFrkk+xC6amVgVQbWpyI4Z+5YH/Ku7oHtwb
ujpa5tibheotJBuz6uSkM2cqEUHyD/s8IJOCnRq8MUBIcYTua2j1u6RYir9djaq4ykUBnH5I
59Gout3bnhQn7sRZ0KQB/YsuYxQyTJbyPK0uiBQ6MWDwoRAUkwXR6/zduEOY+C6tOv6JgdDg
R9GdkSpOV6f+CPEwggWUMIIEfKADAgECAgcVtXzOm9uDMA0GCSqGSIb3DQEBBQUAMIGfMQsw
CQYDVQQGEwJERTEPMA0GA1UEBxMGUGFzc2F1MRwwGgYDVQQKExNVbml2ZXJzaXRhZXQgUGFz
c2F1MRYwFAYDVQQLEw1SZWNoZW56ZW50cnVtMSUwIwYDVQQDExxVbml2ZXJzaXRhZXQgUGFz
c2F1IENBIC0gRzAxMSIwIAYJKoZIhvcNAQkBFhNjYUByei51bmktcGFzc2F1LmRlMB4XDTEz
MDUxNzA5NTgyMloXDTE0MDUxNzA5NTgyMlowcTELMAkGA1UEBhMCREUxDzANBgNVBAcTBlBh
c3NhdTEcMBoGA1UEChMTVW5pdmVyc2l0YWV0IFBhc3NhdTEWMBQGA1UECxMNUmVjaGVuemVu
dHJ1bTEbMBkGA1UEAxMSRHIuIENocmlzdGlhbiBSYW5rMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA8vSpMfUHFtLfsLSIjBmuxt9ZrIsSweqwjDn/rJZGTRjXUf4JR8yQAAum
SFnqATS2jb6aAwkUW5Db3dz4hYmrUauS6yViKhW6l2TM7lAlTjkUiLYJGAVjEDX5+izK7sDL
+qH4XTxZNzavi/uEUuxY6ovUu9oqyCk74b7Xw0f2IX2gnZ+AyTdb9BvaqMoTylRi3+WLrRDh
eYC343KIzX5nJ6LNz+zt+8A5aad0NMTMXUBbthmGycMxegH+OHSvqaozDpow1HysXPMA657F
11tixXArWVYW6CqyDOmJ40A+ot0efARf7w61W7U76uFMl7CfXjLZdGO+z4rNyydMWjpx+QID
AQABo4ICADCCAfwwLwYDVR0gBCgwJjARBg8rBgEEAYGtIYIsAQEEAwAwEQYPKwYBBAGBrSGC
LAIBBAMAMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggr
BgEFBQcDBDAdBgNVHQ4EFgQUUyjHXQcCpfyG2WROug3Bdenmhd0wHwYDVR0jBBgwFoAUCbHf
oehhXaHNxvSDeTosBgyM7AgwJwYDVR0RBCAwHoEcY2hyaXN0aWFuLnJhbmtAdW5pLXBhc3Nh
dS5kZTCBhQYDVR0fBH4wfDA8oDqgOIY2aHR0cDovL2NkcDEucGNhLmRmbi5kZS91bmktcGFz
c2F1LWNhL3B1Yi9jcmwvY2FjcmwuY3JsMDygOqA4hjZodHRwOi8vY2RwMi5wY2EuZGZuLmRl
L3VuaS1wYXNzYXUtY2EvcHViL2NybC9jYWNybC5jcmwwgaAGCCsGAQUFBwEBBIGTMIGQMEYG
CCsGAQUFBzAChjpodHRwOi8vY2RwMS5wY2EuZGZuLmRlL3VuaS1wYXNzYXUtY2EvcHViL2Nh
Y2VydC9jYWNlcnQuY3J0MEYGCCsGAQUFBzAChjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL3Vu
aS1wYXNzYXUtY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0MA0GCSqGSIb3DQEBBQUAA4IBAQAH
aNsv/oaVwcWLlu5vU/YSxc64vOiH6s03I3qEIWCXL8O6JsJdhjKiWsUNrtbBkNK+IwMPs5rN
U6jsS1FLO0xK866VBCgov9+3UN2bjWeWZmvAyMLPYu9dkk0ijRjgwOCmivpYwiyT15UZtRMN
PQOdIEHkaU2A2RT01rUsdzReerVn0nGxGn9Og6EiJqENdkC77G2D5sdI8IaOzqaOLeG2uFab
bpbp+HKkVGJtsgsexM79kzUSWS6MFgGRvyL2h7plU1AHJjmTbM39fKxXtwPznam1Y4RMspdr
wwJT8Vvp+OXv80hSg08bPIB8i1ek1Vk82asQHrbka7GV/rvw+4bxMYIEIjCCBB4CAQEwgasw
gZ8xCzAJBgNVBAYTAkRFMQ8wDQYDVQQHEwZQYXNzYXUxHDAaBgNVBAoTE1VuaXZlcnNpdGFl
dCBQYXNzYXUxFjAUBgNVBAsTDVJlY2hlbnplbnRydW0xJTAjBgNVBAMTHFVuaXZlcnNpdGFl
dCBQYXNzYXUgQ0EgLSBHMDExIjAgBgkqhkiG9w0BCQEWE2NhQHJ6LnVuaS1wYXNzYXUuZGUC
BxW1fM6b24MwCQYFKw4DAhoFAKCCAkswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMTMwOTMwMDYzMjI4WjAjBgkqhkiG9w0BCQQxFgQUdIPCDxYMEQ1hi9lQ
D+BRn35Kv9cwbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASowCwYJYIZIAWUDBAECMAoG
CCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggq
hkiG9w0DAgIBKDCBvAYJKwYBBAGCNxAEMYGuMIGrMIGfMQswCQYDVQQGEwJERTEPMA0GA1UE
BxMGUGFzc2F1MRwwGgYDVQQKExNVbml2ZXJzaXRhZXQgUGFzc2F1MRYwFAYDVQQLEw1SZWNo
ZW56ZW50cnVtMSUwIwYDVQQDExxVbml2ZXJzaXRhZXQgUGFzc2F1IENBIC0gRzAxMSIwIAYJ
KoZIhvcNAQkBFhNjYUByei51bmktcGFzc2F1LmRlAgcVtXzOm9uDMIG+BgsqhkiG9w0BCRAC
CzGBrqCBqzCBnzELMAkGA1UEBhMCREUxDzANBgNVBAcTBlBhc3NhdTEcMBoGA1UEChMTVW5p
dmVyc2l0YWV0IFBhc3NhdTEWMBQGA1UECxMNUmVjaGVuemVudHJ1bTElMCMGA1UEAxMcVW5p
dmVyc2l0YWV0IFBhc3NhdSBDQSAtIEcwMTEiMCAGCSqGSIb3DQEJARYTY2FAcnoudW5pLXBh
c3NhdS5kZQIHFbV8zpvbgzANBgkqhkiG9w0BAQEFAASCAQCUDyW/js/khx93R5GJ9l6K5dYQ
k4lVt4Y2t+wgmE06QhiW9hOo2xJ2howdOervkqQa0sfWmuV7tUoJBbUDDAlkVdliYYBHngFW
c6RnPtUvch0qs1ZOOWLZfdm75Syf+3B081i1KRpi/L8utYpA48RZiMxjJ7b+YAoR8DCpto0I
I+jCXCmUTF/sBFe1BUCnfCs2TNkASHeKlvseRT7vNsaYt6QpHlsUkNcdWgtxL1a/Au+vXebk
6Xuwgiyq+DWx6gy/dxAlxuAGRmsDvjR8YRoEjq6GZ4UBy6PIKxB7wooBY0GD32jagWtSurVW
Y7X3Q1qCahSzTvZnHBdOSone38VWAAAAAAAA
--------------ms000501090307040107060601--

