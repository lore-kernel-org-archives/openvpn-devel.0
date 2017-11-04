Date: Sat, 4 Nov 2017 18:47:56 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171104174756.GX958@...1296...>
References: <1498913642-32459-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aYKnuo739dxkFWAR"
Content-Disposition: inline
In-Reply-To: <1498913642-32459-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] buffer_list_aggregate_separator():
 add unit tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--aYKnuo739dxkFWAR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 01, 2017 at 02:53:58PM +0200, Steffan Karger wrote:
> Before refactoring this function, add tests to verify the new
> implementation.
>=20
> While writing the tests, it became clear that this function is not
> behaving very well.  We'll fix that in follow-up commits.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  tests/unit_tests/openvpn/test_buffer.c | 181 +++++++++++++++++++++++++++=
+++++-

Working on my heap of old stuff, I've decided to ACK this ("test code
is good!") but it doesn't pass - with just 1/5 applied to master, the
test code fails:

[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 9 test(s).
[ RUN      ] test_buffer_strprefix
[       OK ] test_buffer_strprefix
[ RUN      ] test_buffer_list_full
[       OK ] test_buffer_list_full
[ RUN      ] test_buffer_list_aggregate_separator_empty
[       OK ] test_buffer_list_aggregate_separator_empty
[ RUN      ] test_buffer_list_aggregate_separator_noop
[       OK ] test_buffer_list_aggregate_separator_noop
[ RUN      ] test_buffer_list_aggregate_separator_two
[       OK ] test_buffer_list_aggregate_separator_two
[ RUN      ] test_buffer_list_aggregate_separator_all
[       OK ] test_buffer_list_aggregate_separator_all
[ RUN      ] test_buffer_list_aggregate_separator_nosep
[  ERROR   ] --- "onetwothreeee," !=3D "onetwothree"
[   LINE   ] --- test_buffer.c:169: error: Failure!
[  FAILED  ] test_buffer_list_aggregate_separator_nosep


... so, waiting for a v2...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--aYKnuo739dxkFWAR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ/f09AAoJEB2Cnv7KVigSvU8L/0S3BjHCv8oI4m8Xdk3QId3B
LVdaSSPtHqxbB81tkggvaRZTB74eAJZhZ7Y9YFmAV0Dbqne3jba4riAB0riPogQA
minlLIuw0bxAlzXaqyjdzVQO1tt8++NxF1P03TvB6nuyaKGEEuVYtTKLc2w+UY5F
FReUKQVuFaoWnV5oYgfH+UJZLP8buT+w1+VpUv75EBG04DuUkoUlltOxZjvxE9Oh
GXzB6aDkh4r0TAIP+urZzfQTOSqVynHxKWW+1HzMm9aMMnNUum6OYH7pC12cJPO0
OgPcuSY+xUM8XRmKfV5X8MF2nZe/+oCuwOP1HZMrcPF6zrdqouBzjdfY8XcurUH1
XTAmFec9vxP8NRrblfH2UKznUoEGytYc+RLibo/QXw3UZrGSiWD/RZO/9ia96wJ9
IRwR6NDOmaew8xO7fGk879u9JiEzwA92Dw9iYz4qqCEVBS0V034tj3Mb37nOEO7Y
L6w1ge+u9uzLN98oaeQLq0CcKF7z8kJngg9c/55mcg==
=svoR
-----END PGP SIGNATURE-----

--aYKnuo739dxkFWAR--

