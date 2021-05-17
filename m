Date: Mon, 17 May 2021 17:31:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210517153133.GH976@...1296...>
References: <TGB05j2zTgH3-jDRcHubPFmTAQrG1hHgF4XtWb8Ytc14RY1RFusKL-QJFkyzi6H849DfuoutjhVZfRkiqAhGyHs9lLnI5tnWKDpaOrRfQv8=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IzRJq6eger+qLsbL"
Content-Disposition: inline
In-Reply-To: <TGB05j2zTgH3-jDRcHubPFmTAQrG1hHgF4XtWb8Ytc14RY1RFusKL-QJFkyzi6H849DfuoutjhVZfRkiqAhGyHs9lLnI5tnWKDpaOrRfQv8=@protonmail.com>
Subject: Re: [Openvpn-devel] Feature request - Allow comments inside
 <peer-fingerprint> markers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincantech <tincantech@...2282...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--IzRJq6eger+qLsbL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 17, 2021 at 02:57:32PM +0000, tincantech via Openvpn-devel wrot=
e:
> I think it would useful to allow comment inside the <peer-fingerprint> ma=
rkers.

I've run across this as well, and share that sentiment.  It would be nice.

That said, I'm not sure how easy it is to implement (the inline-config
parser is used for all inline stuff, not only for peer-fingerprint).

> EG:
>=20
> <peer-fingerprint>
> # alice
> 67:1F:A5:CA:26:98:BA:40:D9:EB:6A:5B:C1:64:8C:8E:66:6E:7A:22:26:73:96:6A:5=
E:9B:B3:17:8F:F8:C6:9C
> # bob
> 55:B6:3F:AD:BC:A0:8C:EF:00:B3:2F:A5:46:46:83:82:6F:34:86:8D:23:2B:AC:79:3=
9:E2:26:0B:FC:1A:86:38
> </peer-fingerprint>

As a workaround, you can put "per user" peer-fingerprint lines into the=20
config:

# alice
peer-fingerprint 67:1F:A5:CA:26:98:BA:40:D9:EB:6A:5B:C1:64:8C:8E:66:6E:7A:2=
2:26:73:96:6A:5E:9B:B3:17:8F:F8:C6:9C
# bob
peer-fingerprint 55:B6:3F:AD:BC:A0:8C:EF:00:B3:2F:A5:46:46:83:82:6F:34:86:8=
D:23:2B:AC:79:39:E2:26:0B:FC:1A:86:38

the config option - and the inline block - can appear multiple times.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--IzRJq6eger+qLsbL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgoowsAAoJEB2Cnv7KVigSd9oL/0wg+kle5VrDIn/IZ9OzQrTW
wTkqqQWivwm6r57Tv3/fnocUQjDBnFgtdLeRoec/OdDwAE9YAtwaDU8VWBseH8Et
Cu9MButYtKrPiZmJvvqQuQrF36vZ/rn4yi4NfciDfrgmYF13u6QwpEPQd+FtKN/n
Ez4n8HElYaCmkbntpmEg2ZMidoD6PZoP8x0SK7ymBOGBBQva98ZLGSL3U8OZEbY2
FVI+kNa5m/d5i7yewDjRkmghsJipxTHyaFLZjETAlHnKiA65t+Hqusznk1c5MW6O
qmV2VWk4hCsjA52gHt1g5z/FFrYuCLdbRdz1t6Wcs7s3n4eZ0CgrWgiPtQv1Q0d5
iYJ92j0hgnEoFuu+LOejWHj2MuDPCZQYQcAYP5OZf3LtKfQiwokUaX0T6yT/S6QZ
6aaWQzb2KnWMUbct6yN19XwrzxiGfnYa7TY8PjfOwUcjiW58m2wr9LxZxFpV6oOO
U+egpPDBIf7g8XJewlGYr2mioVZE/ol80VsqaYQiCg==
=Jihr
-----END PGP SIGNATURE-----

--IzRJq6eger+qLsbL--

