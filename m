Date: Wed, 7 Mar 2018 15:21:55 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180307142155.GH69387@...1296...>
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1512734870-17133-8-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ey7axMtC4Hj1PEsG"
Content-Disposition: inline
In-Reply-To: <1512734870-17133-8-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 07/10] Move env helper functions into
 their own module/file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--ey7axMtC4Hj1PEsG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 08, 2017 at 01:07:47PM +0100, Steffan Karger wrote:
> To avoid a dependency on misc.c - which is a dependency mess - in the
> tls-crypt unit tests, split the env_set functionality out into it's own
> file.
>=20
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

*sigh*

Not exactly sure what to do with this one - I was about to ACK and merge
this, but it fails cmocka building

tls_crypt_testdriver-env_set.o: In function `env_allowed':
/tmp/openvpn-236/tests/unit_tests/openvpn/../../../src/openvpn/env_set.c:41=
7: undefined reference to `script_security'
/tmp/openvpn-236/tests/unit_tests/openvpn/../../../src/openvpn/env_set.c:41=
7: undefined reference to `script_security'

... because *that* change is in 9/10...


So while the change itself is fine (besides the "%lld" to PRIi64 change
in setenv_long_long() that came in with 06ad53e067d9a8b) it will cause
lots of build fails for the foreseeable future, so I'm not sure it's=20
a good plan.

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--ey7axMtC4Hj1PEsG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJan/WCAAoJEB2Cnv7KVigSmxkL/2M5vuQa9gyfXw8MDxfDiTVi
0QzBRIeiTEzNBN7rlMdBq+Y51s/omfXetRaPYO5mYYoiuN3pcPrkoL/5eoxT0YkC
lzCiJsZxty2Fd/Xg/yy6ds8TLJFBVosBCqEHWUBtKZcSIOzjj/cQAqxBzR8xgUCF
rW5GgzlGZR9ijHZ3P1TlVTJXCTFezK4pGlVEgF/oajV0E0Rc/WKMTI+WnUpUZilr
fsCe+qmVYlVWmySq8PTnI8qUBz6USiUWGaaEES/kQ40/t+vLgK8omSfN3Z+ihlr1
6UaKc8g9CqaF6fdXVUWLtgc9EZGDsL9+KDCdt5RLyWOuAbkwPC81KhGM8mCCPsNS
H1+9r0tc/l1W6K57dxKBPdugVR/w7CmOzjFjf8IRqvafm/i90sScc6CIVJXDYAmu
gg34zWBsNqqEmnMV9UWrr1HJdFcvetTYpEvhZh1kHIoxlI+sXAuSKRNk6jRyQCTP
Z9opvfG+v3+rD7orfl5dSIuESg0s64pJOLH2REtk+Q==
=a/pf
-----END PGP SIGNATURE-----

--ey7axMtC4Hj1PEsG--

