Message-ID: <53F48118.30905@...1114...>
Date: Wed, 20 Aug 2014 13:06:00 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAFLxGvy77WaHhrsqSfm2Va4fbD_y5Ta5ykMsczCQ=-Z9AkNjnQ@...278...>	<20140820081530.GW1118@...1296...>	<CAFLxGvwEEVZvpkR446Ye+aPLFw0YW=MJivYZsL2e9h2gKDrPzA@...278...>	<20140820092928.GX1118@...1296...>
	<CAFLxGvy9yyxRnuwAAcLxPp+ZzyP42CXWQLDpzr34pH3XNsBoXg@...278...>
In-Reply-To: <CAFLxGvy9yyxRnuwAAcLxPp+ZzyP42CXWQLDpzr34pH3XNsBoXg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="slphOWAEFeUFI6V3O65mF0gNXqGK3i6EA"
Subject: Re: [Openvpn-devel] Ongoing Windoes 8 issues
Reply-To: openvpn-devel@lists.sourceforge.net
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--slphOWAEFeUFI6V3O65mF0gNXqGK3i6EA
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 20/08/14 11:51, Richard Weinberger wrote:
>=20
> But if there is an issue with almost no reaction from developers
> within 14 months
> I begin to wonder WTF is going on.
> A simple "We're working on it..." would not harm.

Fair enough, and I can fully grasp this.  But I'll give you a glimpse of
the bigger perspective.

There are now 3-5 active _community_ developers, and only one of them
really plays with Windows.  And almost none of them are paid to do
OpenVPN.  Then you have the users, and there are insanely many of them,
 Many of those finds bugs or issues and some of them actually do report
them.  Unfortunately the list of bugs just seems to increase, some with
really important issues to fix.

So what really happens is that when some of the community developers
have some time to hack on OpenVPN, the attention is mostly given to the
areas where they have issues too, or have promised to fix things.  And
if all that is done (which is quite seldom), we tend to look at the
areas of the code base which we know best.  However, if patches which
fixes things arrives on the ML, then they do get reviewed at some point,
especially if there are good descriptions of the patches and good test
descriptions.  When this happens, patches are accepted much quicker.  If
there's just a patch without much additional comments, the patch might
linger for a long time unless some of the developers knows the code
paths quite well.

What I'm trying to say is that we need more people who understands
coding to submit good patches with fixes, so that others can help review
or test them easily.  Then you'll get a quicker turn-around on these
reports.

And that is why we tend to be touchy when people complain too loud.  But
if you want to gain respect and get gratitude from the developers,
sending patches is the very best cure.


--=20
kind regards,

David Sommerseth



--slphOWAEFeUFI6V3O65mF0gNXqGK3i6EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlP0gRgACgkQDC186MBRfrqN7QCgsaq3fNEDxCyTFC8SCRPNsn3l
SdYAnirqju7/rYq5FVbzyXzwx63Ort0L
=H+p7
-----END PGP SIGNATURE-----

--slphOWAEFeUFI6V3O65mF0gNXqGK3i6EA--

