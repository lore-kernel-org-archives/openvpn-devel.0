Message-Id: <201404241452.s3OEqvZi009848@...309...>
In-Reply-To: Your message of "Thu, 24 Apr 2014 09:23:59 EDT."
	<5359106F.7020202@...1901...>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1398351177_8243P";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Apr 2014 15:52:57 +0100
From: George Ross <gdmr@...308...>
Subject: Re: [Openvpn-devel] Topics for today's community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timothe Litt <litt@...1901...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--==_Exmh_1398351177_8243P
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sorry, I'm in meeting mode at the moment.  Just time to fire in a quick=20
comment here...

> George's is not known - but the best guess is that he may be using=20
> another external key loader (such as pkcs11, or maybe an android/ios=20
> client.

Nope.  Just the following:

# TLS parameters
dh /etc/openvpn/dh1024.pem
tls-server
ca /etc/openvpn/EdUniRootCA.crt
cert /etc/openvpn/openvpn.crt+chain
extra-certs /etc/openvpn/openvpn.chain
key /etc/openvpn/openvpn.key
tls-verify /usr/lib/openvpn/dice-kx509-verify
tls-auth /etc/openvpn/tls.auth

SL6.something Linux on both ends, on a Dell server and a Dell laptop.

On our server side the certificate chain goes: University CA -> School CA ->
service-signing CA -> service cert.  The first two of these are kept=20
off-line.  On the client side it goes: University CA -> School CA -> KCA ->=
=20
kx509-cert.

I wonder if that's just longer than most people use?
--=20
George D M Ross MSc PhD CEng MBCS CITP, University of Edinburgh,
School of Informatics, 10 Crichton Street, Edinburgh, Scotland, EH8 9AB
Mail: gdmr@...308...   Voice: 0131 650 5147   Fax: 0131 650 6899
PGP: 1024D/AD758CC5  B91E D430 1E0D 5883 EF6A  426C B676 5C2B AD75 8CC5

The University of Edinburgh is a charitable body, registered in
Scotland, with registration number SC005336.



--==_Exmh_1398351177_8243P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Exmh version 2.7.2 2005/01/04

iEYEARECAAYFAlNZJUkACgkQtnZcK611jMXxUACggIvo5ytwVXAWIQUNVGGqYLCp
kuEAoKEbH4OSPTSIu0i8ljmNCNKx0FXA
=CeCG
-----END PGP SIGNATURE-----

--==_Exmh_1398351177_8243P--

