Date: Wed, 5 Oct 2016 20:15:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20161005181524.GV78279@...1296...>
References: <1475613736-1529-1-git-send-email-lstipakov@...277...>
	<842a27b1-8ce3-db91-2c76-71cfc705e1eb@...1435...>
	<20161005123444.GS78279@...1296...>
	<CAGyAFMUvHvgFTH4=M2OrcpnZFKuXq3r6Rb4DcL4KHXS353wcGg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8IgpUc3zahWtfmuT"
Content-Disposition: inline
In-Reply-To: <CAGyAFMUvHvgFTH4=M2OrcpnZFKuXq3r6Rb4DcL4KHXS353wcGg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2.3] Fix compilation in pedantic mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--8IgpUc3zahWtfmuT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 05, 2016 at 05:29:46PM +0200, Lev Stipakov wrote:
> I noticed that in few places indentation is a bit off - like 8 whitespaces
> instead of tab so I decided to "fix" it.
>=20
> Should I just ignore those things or do it in separate PR?

Please do not intermix whitespace changes with "other changes" - this
makes it harder to track what really changed in a patch.

We are planning to do a massive re-indentation before 2.4 release
(right when we branch off the release/2.4 branch, or so) - so I'd not
bother right now.

If you do actual code changes to a line that has funny whitespace, of
course feel free to fix that as well ;-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8IgpUc3zahWtfmuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV/VDO6kuBuNlUUl1AQJ1pgP5Ab970RxVMV0cCIRdBZb5AjZUjKWXNaBL
+9TiqOxrA7BAdP5wPCIDn9GKqqVppsX6Fr5ff9/grxnbhQDMOjOl5DMJia5Vda/+
p7OOMpPThPZIrHwAA8Qb8L6b5/ONEIryNVK42cYE6LF1iA7fQXPbeJM0HTgO74nr
oBhRbISo25g=
=PuuG
-----END PGP SIGNATURE-----

--8IgpUc3zahWtfmuT--

