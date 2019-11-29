Date: Fri, 29 Nov 2019 13:29:22 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191129122922.GX40538@...1296...>
References: <20191128080631.117-1-lstipakov@...277...>
 <E1iaLck-0000Aj-5c@...2508...>
 <CAKuzo_jR6WYsM9QZhdyp8sW6avFGhDnFzx_dNN63JD4iiSmFag@...278...>
 <20191128194320.GM40538@...1296...>
 <2aa50cbc-cc17-81d5-ec9a-98fd5e8ba503@...2080...>
 <20191129105207.GU40538@...1296...>
 <f9930229-0e7c-a03d-3050-dae11e59b2c6@...2080...>
 <20191129113740.GV40538@...1296...>
 <28596834-0999-e5f3-e4c3-272feb0b88e6@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PhLx+pu1xklN7F+E"
Content-Disposition: inline
In-Reply-To: <28596834-0999-e5f3-e4c3-272feb0b88e6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] fix clang warning about missing braces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PhLx+pu1xklN7F+E
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 29, 2019 at 01:22:26PM +0100, David Sommerseth wrote:
> > I'm just not going to care very much about the warnings it might throw
> > (and I might object to any patches that are "just for the benefit of
> > suppressing warnings from gcc-4").
>=20
> Fair enough.  But that will actually restrain us from adding -Werror by
> default for some time forward, unless we want to make package maintenance=
 a
> bit more tricky - needing to revert a -Werror chage or add
> -Wno-missing-braces.  If we have status quo for the moment, I can live wi=
th
> that until RHEL-7 is EOL.

I don't think we can add -Werror as "on by default" for any platform
in the foreseeable future - we'll always hit "old" or "too new" compilers
that cause build breakage and lots of extra effort to work around it.

Now, well-defined environments ("travis, clang-9, Linux") I'm all for it :)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--PhLx+pu1xklN7F+E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGbBAEBAgAGBQJd4Q8iAAoJEB2Cnv7KVigSqjML+MsxawoOP+uaLdH2d13sEM/F
Ur+COLjgK3KXkldpM1FzdO/4CebmbltuEFfOpQAdZywFAk+IB9RT8X/K1k/7ikqt
88iFo8hyvzpXvWfkCQAQxbcqciCICE+rnGKSfn4yNNu66fFTzB6dxnzvQEqFr2ut
HcmICt9nSl/DCDVVE/S/lXsCP3dwVKqwgqYaN0yCJJuUhG7mY9BR52VNrPM6kjCL
Rq8QO/VB1muQos0Ll33RAvhzoKJOhIS80aZ8I1LTlx1LK8s22kHtbVTw7djHTS7V
/fzsUVy1XO09mTgtdDnvOWhCp9Z95xFc5De7yLLNrDnltu5Bk0krZYkT286Af55u
svWthK1hUt0jBXYKhfMDWaSLENBAWOtaf84ZQG3vclP42PAm/je4NINPaKuBR70s
cmYYcPvG7lRcEsLOxnnw+qKBWChIqAlH7PAl9w9cNqinrXsyiC5qamD2xn2K//KZ
GqRcpY+jLoPrNYpkpn0zdvaKu0+Tryq+7EK9yv//
=usXZ
-----END PGP SIGNATURE-----

--PhLx+pu1xklN7F+E--

