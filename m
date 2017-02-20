Date: Mon, 20 Feb 2017 17:18:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170220161842.GL93896@...1296...>
References: <1483905658-25267-1-git-send-email-selva.nair@...277...>
	<1484428589-7882-1-git-send-email-selva.nair@...277...>
	<20170220121852.GW93896@...1296...>
	<CAKuzo_jFiNfL4mVBmYhVAi4GyWB3PVG=WgWiZCdZ_A8UH7ri=g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XkdrZ7OMnakiJ6dL"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jFiNfL4mVBmYhVAi4GyWB3PVG=WgWiZCdZ_A8UH7ri=g@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix user's group membership check in
 interactive service to work with domains
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--XkdrZ7OMnakiJ6dL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 20, 2017 at 11:13:49AM -0500, Selva Nair wrote:
> > MS documentation for GetTokenInformation() suggests that group membersh=
ip
> > tests should be done with "CheckTokenMembership()", which sounds more
> > convenient than "extract them all and walk the list" - so maybe this
> > is done to avoid domain controller contact?
>=20
> Thanks for the review :)
>=20
> CheckTokenMembership() returns true only if the SID is present and enable=
d.
> That means when UAC is active it will not detect that the user is a member
> of administrators group as the SID will not be enabled. In other words, o=
ur
> usage of group membership is somewhat special -- we only care user is a
> member of admin or ovpn_admin groups, not that the corresponding rights be
> enabled in the token.

Oh, wow.

Thanks for the explanation - indeed, that makes sense :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XkdrZ7OMnakiJ6dL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYqxbiAAoJEB2Cnv7KVigSf5UL/iX9OFRPC54uaa+c3epT9Yc/
m9gNQc/dI3RckXRXFYz3dNYuWfiN0Ju/x7iN+jRWpfV61zQYZLwD03akBdZm2wq4
FzhdgUWwyJbe4eaKK7Jefoq/ccl6isYc3XWeRbxFUfPLpU/B7sEQ55jG98wvGgTZ
Xcamzi0Smp82UoTQ/O5ZeUzGCLAeNXR0B10Zw5wR1AsBNOFGYdy6YnLzPKKAQ/LW
GsjSUfiVmWbn6SssVsWbzMNX0IdWidgFXDVqQ6uhom86/IswpL2AApyDuTgaCkgC
zFB/susnCWrM3l8mJ7WlVhHOt/C0JsVRc+JISvR9KhVsC4OzdQntRrF7a3/hcxb2
6MJe7eL65qmQn2ufOJIvO2aICI+siuyQuaD/w3JcqSk1y5xKyU+IV+1iLtlE7EBu
cDNlSc0r9Z1JGQvwWeE5RaEJ0POmj5lyXmef6jW7kYjyaY0APaij352TmGmr+KWq
mmHCQeNU6rJzFr3LU3mamaPmjKmOYxjTJhDhJMuyKw==
=mIkd
-----END PGP SIGNATURE-----

--XkdrZ7OMnakiJ6dL--

