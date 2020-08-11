Date: Tue, 11 Aug 2020 11:13:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200811091328.GB75094@...1296...>
References: <20200810143707.5834-1-arne@...1227...>
 <20200810143707.5834-3-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7gQyIpR7q4QSXYu+"
Content-Disposition: inline
In-Reply-To: <20200810143707.5834-3-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 02/17] Cleanup tls_pre_decrypt_lite and
 tls_pre_encrypt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--7gQyIpR7q4QSXYu+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 10, 2020 at 04:36:52PM +0200, Arne Schwabe wrote:
> Mostly C90 -> C99 cleanups and again immediately instead
> wrapping function body into if.
>=20
> (Review with ignore whitespace)

This does not apply without 01, and since I just asked for changes on 01,=20
I'm putting this one to "changes requested" as well...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7gQyIpR7q4QSXYu+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfMmE3AAoJEB2Cnv7KVigSpNML/3+7bmpLh7Pk7/WO42T9O760
/teudn/IATP1hzRKZ8WYL9Lk/37X2fNRvw5V87FZqp+sBgePdS/RlXePPTlt1jtJ
HpwUYaFUAYSptKphYPmWmidZRIQ6RTKeFTbakCmA/HBO8Imos2xkal6WGy1SD4Fk
QC2oXutJJyBF4/GQUVqLJ/PwWnSchD/vA6YChhLTSnCfmGsw6zZHZkz3mhI22uVg
RTMQS7KeIs65ffwyvt8Sc6qLsFiw3sdrqK983VkTFxpAs7rIrpiBlPa2MZQ3Q61Z
0Dng7MUiezNxg8AHmHS1mso2xGB9kuIKr2bjQFBle6Eqm1l8tdxwwmrIS7pSVa/3
nCUJJ9aJ0BEE8QTws9FMmWB2RbvCqFF17aijA0dpiC1NrmwghNZZ0KjpOxdEkwW1
8bl1HdoOFCMxHjBdADWA7bg2NgcKZxKxDxmWuSVYBA6AFN1zQXqGb0usL9ZvSE5k
bfOPhvFOeFP9v0ZJemKhc7AquF7Cg1sfon9Kp2w1hQ==
=5la9
-----END PGP SIGNATURE-----

--7gQyIpR7q4QSXYu+--

