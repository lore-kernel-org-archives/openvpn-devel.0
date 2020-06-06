Date: Sat, 6 Jun 2020 13:28:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200606112817.GZ1431@...1296...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
 <31d467d4-59da-08b2-166b-13f62a59b82f@...1227...>
 <1591374528.4728.53.camel@...2316...>
 <1591377595.4728.67.camel@...2316...>
 <47ddb948-d12f-6372-1ca9-34b70dee3f25@...1227...>
 <20200606084110.GY1431@...1296...>
 <fe88bc2f-948d-d0c1-8969-b81ccfe1dba2@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Le3yVhSw7EsY9a+i"
Content-Disposition: inline
In-Reply-To: <fe88bc2f-948d-d0c1-8969-b81ccfe1dba2@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v6 3/3] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--Le3yVhSw7EsY9a+i
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 06, 2020 at 12:43:10PM +0200, Arne Schwabe wrote:
> > Naive question - can we not just use a .so on Mac?  Like, consistent,
> > build .so, request .so from openssl.cnf?
>=20
> I thought I tested that and it didn't work but I tested it again and
> that also works.

Then let's just do that, and simplifiy the test stuff :-)

(Building a "production quality" OpenSSL engine would need to do what
the platform wants, but for "this is really just to test the OpenVPN code",
I think "less autoconf hoops is better")

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Le3yVhSw7EsY9a+i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe233RAAoJEB2Cnv7KVigS/TsL/35VzLhHFRl76XT3t7/XHgjk
wuE8l1jtjb9RhinUO3MZHE/zvnkyZgXzs/M43wK2T+5JNot5MRA8tekdyMxe90H2
7aES9Fzb3WYQ7vLVT9GV4MOktP6wXQ4OKDBUvAgnd+S1yfKuj+NCYsT9pCsXtXvs
FPdtVaqYjoNkdXIliJ31MopHRrIpgPi3ZgvSO2mEQLfSTfx8Vnkt6a2c60+qjwiR
wifHqNIgxLD0Zq0DFKpXvxuQ6N3hKdIf1aAwff6tBNSY0IzrEk5/AeYV769cRF9k
mA1uBh19IdyRLVBYmeIatIpVqq5cdFF6CSsoRV6D6SmYNE5Vi0ZVaihwTnyQ52to
vCPh7mGSN2xugDm3+vLM3fFx+ees0iEGpaKDRE5gnCkQi2ntpVeDoe8WuZKUXk3N
RpSBcPvKakwDo+FumiiqD9Wl4IJcu5BqDgt8OBQATqRRCeVoqMAJfkQ5flvZI0gh
77klnQbh3zI+hAU8asTxf2kJC5vOzvPYZKbPYjIw4w==
=Tykr
-----END PGP SIGNATURE-----

--Le3yVhSw7EsY9a+i--

