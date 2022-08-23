Date: Tue, 23 Aug 2022 20:31:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YwUdBFqHp0vdeVEz@...1296...>
References: <20220728034508.15180-2-selva.nair@...277...>
 <202208021202.272C2dmm071125@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="y1L16Uv/sRCX0/GY"
Content-Disposition: inline
In-Reply-To: <202208021202.272C2dmm071125@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Allow a few levels of
 recursion in virtual_output_callback()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--y1L16Uv/sRCX0/GY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 02, 2022 at 02:02:39PM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> commit 4dfd592ff1ee18aa4859264c8a341dfa1a291988

... and after some reminding, to release/2.5 as well.

commit 468f53ae3bfcfca6563acbf648e7a0bc6f94b038 (HEAD -> release/2.5)
Author: Selva Nair <selva.nair@...277...>
Date:   Wed Jul 27 23:45:08 2022 -0400

    Allow a few levels of recursion in virtual_output_callback()
...
    (cherry picked from commit 4dfd592ff1ee18aa4859264c8a341dfa1a291988)


Since this code is virtually unchanged "since ever", it cherrypicked
smoothly, diff looks good, and a small client-side test run worked=20
just fine (same caveat as for the "master" patch, I have nothing
which triggers this problem today).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--y1L16Uv/sRCX0/GY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjBR0EAAoJEB2Cnv7KVigSrEwL/iUs2cyVqHjsingnRozV9xtG
9xVgIDUo7CzJm+SBYgINA02931LyrCfE89gdHVZucCxSaoWBqJFMTKFqtGzQF+Lc
BjikIoGj0fPIN79Rpx6b06qSiBV9j2j7QIJVXDxs4248rY3Rtp6NxhMnWd76toPc
/SqVwC3dM7/uCUZs3ru86BIoOqCy5PNhkvPYXpWKGkdW03xz4Q+oivlrUU7UiYvo
wRA8zDriYgO9AaHecJbGKMhY0T+x4KSq0xFZ6QMbTPHWXLtX4k0Ny05jfUtivr8F
ldf4oqPWmFeiz5j6o8lfv7s34ulK48M/BM0+cUdVIHzjoWBgzvB5paYlQHe8Tpsj
roXZOZAbRujsT03DQrlNUVOyAdpVR1B5yPj7k/DyEON+PAjsScuNaPJg0yAkCVcm
x08fiAEZxICAXBoFxErNQqRIsWG6uYUyICw0pGSoObDawBTmdaL4nFFabm/epLIu
1frBSYYcMOz7maKWTiBC3N+IXggspjlU+KCmdP5t7g==
=kfip
-----END PGP SIGNATURE-----

--y1L16Uv/sRCX0/GY--

