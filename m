Date: Thu, 23 Feb 2017 21:57:07 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20170223215707.60e567de@...1799...>
In-Reply-To: <cover.1487859361.git.logout@...260...>
References: <20170220160816.114598d9@...1799...>
	<cover.1487859361.git.logout@...260...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/y4N5rm/Vvh2b=m7cA0Hd7QI";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH v3 00/15] Add support for OpenSSL 1.1.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/y4N5rm/Vvh2b=m7cA0Hd7QI
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Emmanuel Deloget <logout@...260...> on Thu, 2017/02/23 15:35:
> This is v3 of the remaining patches for the "Add support for OpenSSL=20
> 1.1.x" series. This series is partial: only the modified patches are=20
> sent to the ML -- the other have not changed. The stats are a bit off=20
> so I don't include them in this mail.
>=20
> They have been generated after a rebase from the master tree. Individual
> commits can be viewed at
>=20
>   https://github.com/emmanuel-deloget/openvpn/commits/openssl-1.1-v3
>=20
> (This time, the branch name is correct :))
>=20
> Changes v2 --> v3:=20
>=20
> * RSA_METHOD (04/15): rsa_meth->name is now a dup of the name parameter;=
=20
>   it's freed in RSA_meth_free().=20
>=20
> * RSA (07/15): calling RSA_set_method() in rsa_finish() is both a Bad=20
>   Idea and not required so it has been removed.
>=20=20=20
> Changes v1 --> v2:
>=20
> * EVP_PKEY (06/15): add missing function EVP_PKEY_id() for 0.9.8.
>=20
> * replace patch 15/15 with a new patch to use EVP_CipherInit_ex()=20
>   instead of EVP_CipherInit() when a full init is not needed.
>=20
>=20
> Emmanuel Deloget (15):
>   [commited] OpenSSL: don't use direct access to the internal of SSL_CTX
>   [commited] OpenSSL: don't use direct access to the internal of X509_STO=
RE
>   [commited] OpenSSL: don't use direct access to the internal of X509_OBJ=
ECT
>   OpenSSL: don't use direct access to the internal of RSA_METHOD
>   OpenSSL: don't use direct access to the internal of X509
>   OpenSSL: don't use direct access to the internal of EVP_PKEY
>   OpenSSL: don't use direct access to the internal of RSA
>   OpenSSL: don't use direct access to the internal of DSA
>   [commited] OpenSSL: don't use direct access to the internal of
> X509_STORE_CTX OpenSSL: don't use direct access to the internal of
> EVP_MD_CTX OpenSSL: don't use direct access to the internal of
> EVP_CIPHER_CTX OpenSSL: don't use direct access to the internal of HMAC_C=
TX
>   OpenSSL: SSLeay symbols are no longer available in OpenSSL 1.1
>   OpenSSL: constify getbio() parameters
>   OpenSSL: use EVP_CipherInit_ex() instead of EVP_CipherInit()

Built v3 against openssl 1.0.2k without issues, tests succeed and two
instanced successfully established vpn connection (with server version 2.3.=
12
and 2.4.0).

Built against openssl 1.1.0e without issues, tests succeed. Did not test wi=
th
real world connectivity, though.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/y4N5rm/Vvh2b=m7cA0Hd7QI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlivTKMACgkQiUUh18yA
9HYg4Af/R3jH+5TeDGVD/QVBaf9t/zbEI55xAS4UEPR21dHFVfMciJyqhjbAvL/b
zMVuTLeRDT+TX6mTn8n46UtzoYItCLSGe6oQlvDBApqOvHxplRtfgkbO4qAFybm5
Mkgy/3bZZmm8eP1f7g2ZBeGkBesDEp4kRYl/x9epPFSRmH2dxLgRe4yGtCNl92UN
DaFSDtAb1I33JsU4lJCE4N/SsWDN2ORojYRxBicmNj1BSndWtbWjUMy7efzlcUUc
dtRTrQ2MvjNgvoKc4w7Lm9o+iOym8RkhktG17LT1cnfWqOeQZMwli+loGUbxIob/
3yPjvQvfVEaV5++YrlId1d+ch/HiIA==
=L1VT
-----END PGP SIGNATURE-----

--Sig_/y4N5rm/Vvh2b=m7cA0Hd7QI--

