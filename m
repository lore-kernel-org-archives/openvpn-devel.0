Date: Mon, 6 Jan 2020 09:55:30 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20200106095530.1820a5cc@...1799...>
In-Reply-To: <BN7PR04MB5251B27BE1C62779CA7B4876FD3C0@...2532...>
References: <20200106080426.40701-1-list@...1798...>
 <BN7PR04MB5251B27BE1C62779CA7B4876FD3C0@...2532...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZYIIWpTTaklsQVjz=joROr7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Subject: Re: [Openvpn-devel] [PATCH 1/1] configure.ac: replace set with env
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom Yan <tom.ty89@...277...>
Cc: OpenVPN Development <openvpn-devel@lists.sourceforge.net>, Christian Hesse <mail@...1798...>

--Sig_/ZYIIWpTTaklsQVjz=joROr7
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Tom Yan <tom.ty89@...277...> on Mon, 2020/01/06 08:48:
> How about printenv (without grep)?

The variables are not known in advance. This needs to match all variables
starting with "enable_" and "with_".
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/ZYIIWpTTaklsQVjz=joROr7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAl4S9gIACgkQiUUh18yA
9HaGUAf/XZr03fiMu6TCx2LinVuDcd/yOzJ/t+dBmBezckNxd/kVeXkyTi5hsvR/
hJI8FYeC/kGZcqZUtx5e9OeMW255/+P9FX5I6jzhXmHKVWLJucTb7L143Qlvb5n8
Lp62LhGNYMCcmqn0tophcgPYmAymuKFYZADwSMHFykGSWiT7aEMadLLcr260ZJqV
lPTWesFVoCze9UPv3ynWP0DmvNpexrfVQbhpnvIkezGRKBz7qFgEgvS+GyaRw9Fu
Z18XmXXH6p8lHbAQOuxGPqSMbyf7r22n0mzDqu1eXr2+4V+QAlO1xypZgx2i7ktz
rLhPJMQOrRMFYV43SixQEvAgdLeWJw==
=3W4b
-----END PGP SIGNATURE-----

--Sig_/ZYIIWpTTaklsQVjz=joROr7--

