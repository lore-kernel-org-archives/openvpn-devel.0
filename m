Date: Fri, 16 Aug 2013 23:21:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130816212112.GW16543@...1296...>
References: <kt8j7m$c5m$1@...1062...> <20130730145731.GW13127@...1152...>
	<20130730151406.GQ16543@...1296...>
	<51FA324F.1090108@...1147...>
	<20130801143058.GM16543@...1296...>
	<51FA79C6.1020405@...1147...> <51FEA1BF.9000905@...515...>
	<A3805A26-5FA4-461D-88C3-45E018208FD7@...277...>
	<5200C76B.5030008@...1114...> <5200CB9D.1020101@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UNrMg7q4I5bA1PGX"
Content-Disposition: inline
In-Reply-To: <5200CB9D.1020101@...1147...>
Subject: Re: [Openvpn-devel] [Openvpn-users] why doesn't openvpn negotiate
	settings?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: dan farmer <zenfish@...277...>, openvpn-devel@lists.sourceforge.net, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

--UNrMg7q4I5bA1PGX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 06, 2013 at 12:10:37PM +0200, Jan Just Keijser wrote:
> Configuring openvpn can be daunting at first, but it is not nearly as=20
> bad as configuring PPTP , or - GASP! - IPSec+L2TP.

PPTP is actually way easier than OpenVPN :-) - why?  Because you have
much less choices regarding IP addresses and routing...  unless you
try to link two full networks (as opposed to client-to-server) with
PPTP, then it will get ... interesting :-)

[..]
> Dan also has a point however: we should watch out for introducing new=20
> features that nobody really understands how to use or why you would use=20
> them - the docs should be kept up to par with the features. My cookbook,=
=20
> for example, does not cover any of the features found in 2.3 like IPv6 -=
=20
> I hope I can write an update in the near future.=20

That update would be appreciated - while nobody wants to understand IPv6,
I consider it unavoidable in the near-term future (3-5 years at the=20
latest), so cooking recipes should cover it...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--UNrMg7q4I5bA1PGX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUg6XyKkuBuNlUUl1AQJXLgQAjIGY0h4iWpojckVLZ23tlSsaz6lqHZLC
YSfPlraD+i8vrz/kblv20lT230Da+2ruZkjpekQ74C9l8NSL5K7bnPPwMr9Su1m4
f6sh0Gn04dFYtFr+1dF5O04i95G7B3WIVsGZ+m41sKIikJjUbVN6fjmULqbkbbTf
e/7sVdjG8N0=
=lNTw
-----END PGP SIGNATURE-----

--UNrMg7q4I5bA1PGX--

