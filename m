Date: Wed, 20 Aug 2014 11:29:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140820092928.GX1118@...1296...>
References: <CAFLxGvy77WaHhrsqSfm2Va4fbD_y5Ta5ykMsczCQ=-Z9AkNjnQ@...278...>
	<20140820081530.GW1118@...1296...>
	<CAFLxGvwEEVZvpkR446Ye+aPLFw0YW=MJivYZsL2e9h2gKDrPzA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wjWNL9V9zRMIopmA"
Content-Disposition: inline
In-Reply-To: <CAFLxGvwEEVZvpkR446Ye+aPLFw0YW=MJivYZsL2e9h2gKDrPzA@...278...>
Subject: Re: [Openvpn-devel] Ongoing Windoes 8 issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Richard Weinberger <richard.weinberger@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--wjWNL9V9zRMIopmA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 20, 2014 at 10:17:01AM +0200, Richard Weinberger wrote:
> On Wed, Aug 20, 2014 at 10:15 AM, Gert Doering <gert@...1296...> wrote:
> > On Wed, Aug 20, 2014 at 09:32:46AM +0200, Richard Weinberger wrote:
> >> This bug exists for almost 14 months (!!) without a solution.
> >> Some hacks work some not.
> >> https://community.openvpn.net/openvpn/ticket/316
> >>
> >> I really wonder why this issue is ignored by the OpenVPN developers.
> >
> > We'll send you a refund for the money you've paid.
>=20
> Nice attempt to be funny.

I wasn't trying to be funny.  Complaining about "it's not happening fast
enough" with lots of expclamation marks about something you didn't pay
anything for isn't really motivating volunteers to spend their free time
on your issues.

> > Seriously: because the amount of free time people can invest is limited,
> > and Windows RT isn't high on the personal pain list for one of the Comm=
unity
> > developers.  If it bothers you so much, take the source and fix the iss=
ue,
> > we're happy to review and merge the fixes.
>=20
> Windows RT !=3D Windows 8.

Last thing I saw in the ticket was about Windows RT on a tablet.=20=20

OTOH, for regular Win 8, this has been fairly tricky to reproduce - I use
OpenVPN in a commercial environment with users on Win 8 and 8.1 (64bit),
and have received no single complaint from any of them.  So it's not like
"it does not work on Win 8, period" but "something is different here".

Plus, you nicely overlooked this bit here:

> > OTOH, OpenVPN Tech *has* started tackling the issue and funded work for=
 a
> > NDIS6 tap driver (which is more than "just recompile") - which nobody
> > tested for about half a year, so the remaining bugs have only been
> > uncovered recently when Samuli started to ship all the windows installe=
rs
> > "for Vista and up" with the NDIS6 driver by default.

... so, you might want to give this a try.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wjWNL9V9zRMIopmA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU/RqeKkuBuNlUUl1AQLDLgQAnxF7FcdXZMD0mog+FZeTywgODVGTBqTI
YOnxtJhqJIxCgneslC9CdbqLM8ZfUIeqrsx256e5II3gPLId/VfAPExgfRn1CQiu
V3dhACV7IvxQQArsfoV3YpMbSQSdr6MCMJkchK2zKUvsS5CfqZxgFyzN6g9NUZ8S
965u8M2QyMU=
=GP1z
-----END PGP SIGNATURE-----

--wjWNL9V9zRMIopmA--

