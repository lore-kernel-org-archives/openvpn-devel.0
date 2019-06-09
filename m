Date: Sun, 9 Jun 2019 23:11:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190609211125.GD1097@...1296...>
References: <CAFHpkQG=oJzBFcipDjTtJJs1Bvz=0jP2kV2M+zRwVZxnMxaiOA@...278...>
 <20190609203731.GC1097@...1296...>
 <CAFHpkQGUW8=vpSyX0YP=7AdRCayjx2BmwzjsJKCGOYG3DTrGBQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UJEqbsikIZBgizPR"
Content-Disposition: inline
In-Reply-To: <CAFHpkQGUW8=vpSyX0YP=7AdRCayjx2BmwzjsJKCGOYG3DTrGBQ@...278...>
Subject: Re: [Openvpn-devel] state of sitnl patchset ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UJEqbsikIZBgizPR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 10, 2019 at 02:06:47AM +0500, ???????? ?????????????? wrote:
> > On Mon, Jun 10, 2019 at 12:05:52AM +0500, ???????? ?????????????? wrote:
> > > https://patchwork.openvpn.net/project/openvpn2/list/?series=3D428 says
> > "new"
> > > however, I see patchset is applied (and travis-ci is somewhat broken)
> > >
> > > are all paches applied already ?
> >
> > Patch status is communicated via the list - and my comments can be
> > nicely seen when clicking on each individual patch.
>=20
> it is complicated to view every patch and it's comments.
> is there a way to change status to "applied" on patchwork ?

I'm leaving them in their current state as a reminder that there is
more work to do - clean up the code where needed, fix the regression
in 5/7, fix the buildslave blowup in 7/7.

(5/7 is actually fine in itself, the problem is an earlier patch which=20
already got applied, but where the code was never activated - so when
that code is fixed, 5/7 could be applied "as is".  OTOH there are code
warts in 5/7, so maybe a v4 will come)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--UJEqbsikIZBgizPR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJc/XX9AAoJEB2Cnv7KVigSoSEL/idF3FaBcWQiEWEw5UhQWYsV
tThyXEEH7GePdsZcHQ7fufCNrIEXmZ6pbJVgfGdQhf/RCcszCHQo7Lkur3RG315W
vziB7zrE/u3c+rXpugRfD1bBYtqQXu4bzhn83go/2q9iVz/YQm2u6Tb7YJ8gUO4J
/2xJR1mXo+KWPiKgh4mimTpzdpwvBHXjwCEr0g+wx/IR+5XHv4WwHcLhpoqlRV5Q
3rU9mmuEe/+GVD9rHmO3H+qhwOqLgdZtVse95bwtyY0mWuz0sX1V8Nim4knGfU7V
jBD04a+NjSNtajal1gOJfFfsPX/woLuY375EQrYiTHATQCWwSwsd+V6Tl9Wt0fVt
mLDUNdlPrwoVCTsfFQYQ29Z8N7fA9Sv7gjoc+lzfGUiLnzgzut1bbjncgpD+2YmH
ywnFPrmIR7ijSTLjrFMVuK9bmxi0+AoPfXJMx/55n9WrcMCfUGnITRCEA33s8Jqh
2jL/snCDnmjGz61/jNLTouGdv1fwLyhG2AWDR/x0Ag==
=PAA5
-----END PGP SIGNATURE-----

--UJEqbsikIZBgizPR--

