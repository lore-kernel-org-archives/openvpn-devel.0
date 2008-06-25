Message-ID: <48624C42.9080205@...1085...>
Date: Wed, 25 Jun 2008 08:46:42 -0500
From: Josh Cepek <josh.cepek@...1085...>
MIME-Version: 1.0
References: <200806250930.56519.sistemas@...1112...>
In-Reply-To: <200806250930.56519.sistemas@...1112...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigED01666B8D2B1869408392EB"
Subject: Re: [Openvpn-devel] Revoking bug
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Sistemas <sistemas@...1112...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigED01666B8D2B1869408392EB
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

Sistemas wrote:
> Hi:
>
> I've a problem that I could not find using Google nor openvpn-user mailin=
g=20
> list. I've revoked a client certificate using revoke-full:
>
> $ revoke-full fjr001
> Using configuration from /home/sistemas/easy-rsa-2.0/openssl.cnf
> Adding Entry with serial number 02 to DB=20
> for /C=3DES/ST=3DMalaga/L=3DMalaga/O=3DExample,=20
> S.L./CN=3Dfjr001/emailAddress=3Dwebmaster@...1113...
> Revoking Certificate 02.
> Data Base Updated
> Using configuration from /home/sistemas/easy-rsa-2.0/openssl.cnf
> fjr001.crt: /C=3DES/ST=3DMalaga/L=3DMalaga/O=3DExample,=20
> S.L./CN=3Dfjr001/emailAddress=3Dwebmaster@...1113...
> error 23 at 0 depth lookup:certificate revoked
>
> But when I added "crl-verify crl.pem" to the OpenVPN configuration in the=
=20
> server, I found that when I restarted OpenVPN, all the other client=20
> certificates began to be revokated too:
>
> CRL CHECK=20
> OK: /C=3DES/ST=3DMalaga/L=3DMalaga/O=3DEjemplo__S.L./OU=3DInternet_Servic=
es/CN=3Durano.example.com/emailAddress=3Dsistemas@...1112...
> VERIFY OK:=20
> depth=3D1, /C=3DES/ST=3DMalaga/L=3DMalaga/O=3DEjemplo__S.L./OU=3DInternet=
_Services/CN=3Durano.example.com/emailAddress=3Dsistemas@...1112...
> CRL CHECK=20
> FAILED: /C=3DES/ST=3DMalaga/L=3DMalaga/O=3DEjemplo__S.L./CN=3Dgam001/emai=
lAddress=3Dwebmaster@...1113...=20
> is REVOKED
> TLS_ERROR: BIO read tls_read_plaintext error: error:140890B2:SSL=20
> routines:SSL3_GET_CLIENT_CERTIFICATE:no certificate returned
> TLS Error: TLS object -> incoming plaintext read error
> TLS Error: TLS handshake failed
> SIGUSR1[soft,tls-error] received, client-instance restarting
>
> The only thing that I don't know if is a good practice, is that I created=
 each=20
> certificate doing a clean-all before and putting the ca files in the key=
=20
> subdirectory (so index.txt is newly created every time).
>
> Does anybody know where is the bug?

You shouldn't run clean-all unless you want to completely start your PKI=20
over.  By running this script prior to each certificate signing you have=20
effectively given all your certs a serial number of 1 but with different=20
common names.  Revoking is handled by serial number, not common name, so=20
revoking a certificate with serial 01 it disables all your=20
certificates.  The index.txt file is the table that keeps track of the=20
signed certificates.

The solution to this problem is to re-issue your certificates to all=20
nodes and do not run clean-all each time.  I'd also recommend=20
re-creating your CA since you have signed certificates out there that=20
will no longer correspond to any certificate in the index.txt file.

--=20
Josh



--------------enigED01666B8D2B1869408392EB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkhiTEYACgkQHSSgJy5aUSfGSgCfaYw0Bp71kxUQKd4WL/DZ4cC+
KrkAn13vFv7xbj0HuP4NxlInoAMfq1ol
=GVwN
-----END PGP SIGNATURE-----

--------------enigED01666B8D2B1869408392EB--


