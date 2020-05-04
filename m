Date: Mon, 4 May 2020 19:11:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200504171142.GS1431@...1296...>
References: <CAFHpkQEvQkC0NokWG-16x-R_zq9qG=2MyO2JV8m1nvNUhwU3Vw@...278...>
 <0de39489-f2a8-514e-763f-c037ba2afbcb@...515...>
 <CAFHpkQELzeh5AQYXmQeNMP-9CXPjdGc=BM1qVbOCtH5QByO4iA@...278...>
 <40ee3e318f8fbb18b8e11126659eaa59.squirrel@...2556...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sv7mMOfu7jJXjzBS"
Content-Disposition: inline
In-Reply-To: <40ee3e318f8fbb18b8e11126659eaa59.squirrel@...2556...>
Subject: Re: [Openvpn-devel] is anybody running tests on Fedora ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: "\"???????? ??????????????\"" <chipitsine@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sv7mMOfu7jJXjzBS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 04, 2020 at 03:59:32PM +0200, Simon Matter via Openvpn-devel wr=
ote:
> I don't know about the EPEL packages but with recent fping builds, there
> is no such thing like an fping6 - it's gone.

That's what I said.  Old versions of fping needed the same source to=20
be built with different options ("-DINET6"), leading to two distinct=20
binaries.  New versions have one binary that can do both, and can be
called as "fping -6" or as "fping6" (symlinked to "fping", implying -6
from the invocation)

Getting this right in t_client is somewhat nontrivial, as you can't
just always call "fping -6" on all systems, as this will not work
(and assuming "if there is no fping6, just call fping -6" will not
work either, systems had two distinct packages for "fping" and "fping6").

So something along the lines of

- if there is fping
- and there is no fping6
- and "fping -6 ::1" works
- then use the latter for "FPING6", otherwise barf

will be needed.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--sv7mMOfu7jJXjzBS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJesEzNAAoJEB2Cnv7KVigSNm4L/1vHQv3bkSQ7jORMOpo77aao
zw27VgV4UXzq1FamRedy/9ozmroDjePpxLC1SvtlLzGfWy/BugbvEGL+XmWIa2DD
xeZQXm6l39807B6meVsC3tolESdeRVw3sW5Y/N+YNppdJFUtccYp2t1KEJwJXiRi
/RLoxrusE0IJj9+/+shDSZ/WBRaa6kHvfH+HWs4ukUoBPvdaz4ssRnv+06c2bdZn
adt+SPNaAntOmvzKutfqSnTOaKKDoYfpn8tV+0RHc6PXyRr5sWaPK6+3OFed38Xk
sgMKJMRK8VLDm+bA3Sce7CAF62tBYR7L03xWo44Nz4CZWDXsa7WgZ01fOeyHePP9
PeTdO4aZZh/ritxkbGpW3CDEZIV58VHzVL8gYEWbYP4w1R8AA6J/FgK9E2vPJ+7h
+35oETPot2vArtQLPPWmzwQI7jAUSD10PgpPKn+sjy16++RXle+HJ86kEh5vQ+zO
lDgST0K1zBN++cRS/6JRcnUI4BuAQzMyGvuWld2ctg==
=vIZX
-----END PGP SIGNATURE-----

--sv7mMOfu7jJXjzBS--

