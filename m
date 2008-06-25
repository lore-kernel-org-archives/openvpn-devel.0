From: Sistemas <sistemas@...1112...>
Date: Wed, 25 Jun 2008 09:30:56 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1241869.liDo7Ikio6";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200806250930.56519.sistemas@...1112...>
Subject: [Openvpn-devel] Revoking bug
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--nextPart1241869.liDo7Ikio6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi:

I've a problem that I could not find using Google nor openvpn-user mailing=
=20
list. I've revoked a client certificate using revoke-full:

$ revoke-full fjr001
Using configuration from /home/sistemas/easy-rsa-2.0/openssl.cnf
Adding Entry with serial number 02 to DB=20
for /C=3DES/ST=3DMalaga/L=3DMalaga/O=3DExample,=20
S.L./CN=3Dfjr001/emailAddress=3Dwebmaster@...1113...
Revoking Certificate 02.
Data Base Updated
Using configuration from /home/sistemas/easy-rsa-2.0/openssl.cnf
fjr001.crt: /C=3DES/ST=3DMalaga/L=3DMalaga/O=3DExample,=20
S.L./CN=3Dfjr001/emailAddress=3Dwebmaster@...1113...
error 23 at 0 depth lookup:certificate revoked

But when I added "crl-verify crl.pem" to the OpenVPN configuration in the=20
server, I found that when I restarted OpenVPN, all the other client=20
certificates began to be revokated too:

CRL CHECK=20
OK: /C=3DES/ST=3DMalaga/L=3DMalaga/O=3DEjemplo__S.L./OU=3DInternet_Services=
/CN=3Durano.example.com/emailAddress=3Dsistemas@...1112...
VERIFY OK:=20
depth=3D1, /C=3DES/ST=3DMalaga/L=3DMalaga/O=3DEjemplo__S.L./OU=3DInternet_S=
ervices/CN=3Durano.example.com/emailAddress=3Dsistemas@...1112...
CRL CHECK=20
FAILED: /C=3DES/ST=3DMalaga/L=3DMalaga/O=3DEjemplo__S.L./CN=3Dgam001/emailA=
ddress=3Dwebmaster@...1113...=20
is REVOKED
TLS_ERROR: BIO read tls_read_plaintext error: error:140890B2:SSL=20
routines:SSL3_GET_CLIENT_CERTIFICATE:no certificate returned
TLS Error: TLS object -> incoming plaintext read error
TLS Error: TLS handshake failed
SIGUSR1[soft,tls-error] received, client-instance restarting

The only thing that I don't know if is a good practice, is that I created e=
ach=20
certificate doing a clean-all before and putting the ca files in the key=20
subdirectory (so index.txt is newly created every time).

Does anybody know where is the bug?

Greets and thanks in advance.
Rafael J. Alc=C3=A1ntara P=C3=A9rez.
--=20
+----------
| Departamento de Sistemas <sistemas@...1112...>
| Tel=C3=A9fono fijo: 952 602 959
| Fax: 952 602 959
| Direcci=C3=B3n: C/ Afligidos 2, 3=C2=BA Derecha, 29015 M=C3=A1laga
| D=C3=A9dalo Ingenieros, S.L.: http://www.dedaloingenieros.com/
| PGP: http://pgp.rediris.es:11371/pks/lookup?op=3Dindex&search=3D0x1899F325
+---------------------

--nextPart1241869.liDo7Ikio6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIYfQwhSGgsxiZ8yURAjJeAJ4ssyLtTg/L6cViUBnvczQMHA40ewCeL1L1
X5yhySIRcAf/WkeZ5NfPgR0=
=nWxH
-----END PGP SIGNATURE-----

--nextPart1241869.liDo7Ikio6--

