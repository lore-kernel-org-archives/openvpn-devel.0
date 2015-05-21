Date: Thu, 21 May 2015 20:31:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150521183108.GZ382@...1296...>
References: <555BF270.3090706@...1147...> <20150521181409.GY382@...1296...>
	<555E21F7.4030002@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NsYpzUZ4z5mp8BBz"
Content-Disposition: inline
In-Reply-To: <555E21F7.4030002@...1147...>
Subject: Re: [Openvpn-devel] patch for bug #93: up-restart env vars
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--NsYpzUZ4z5mp8BBz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 21, 2015 at 08:20:39PM +0200, Jan Just Keijser wrote:
> On 21/05/15 20:14, Gert Doering wrote:
> >On Wed, May 20, 2015 at 04:33:20AM +0200, Jan Just Keijser wrote:
> >>here's my patch for bug #93: missing ifconfig_* env vars after
> >>up-restart. Tested with both IPv4, IPv6, topology subnet and topology=20
> >>net30
> >Reading through #93, I'm wondering - what about the other environment
> >variables mentioned, like "route_gateway" etc.?
> >
> >In other words, your patch looks like it will nicely fix the missing
> >ifconfig_* variables (by ensuring that what close_instance() destroyed
> >is re-initialized even if not calling init_tun() - and cleaning up that
> >one a bit while at it :-) ), but I wonder if more needs to be done?
>
> I did look into that - a 'restart' occurs only if 'persist-tun' is used=20
> and in that case  the routes are not re-added . If you look at the flow=20
> of code of 'do_open_tun' in init.c you'll see that all routing stuff is=20
> *not* re-run, hence those environment variables are not present anymore=20
> - but then again, the routes are still there, as the system routing=20
> tables were not affected because the tun device was never closed in the=20
> first place.

OK, so these get lost, but are set elsewhere, and would need an extra
patch...

> My guestimation was that there are no other *important* env vars that=20
> get lost during a soft restart.

Well, what's important to some is not to others (I could care less about
"ifconfig_local", as tun.c does that for me :-) )...  this ticket is all
about consistency, *or* documenting that --up-restart will not see the
environment variables that --up has "because you do not need them"...

I'm not sure what the best path forward is, TBH...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--NsYpzUZ4z5mp8BBz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVV4kbKkuBuNlUUl1AQKCIwQAobmTsqNkoX1M8dClT9h+nG1Y3wV2Pufl
cWSb1SIBwsTFSD0NWzyhQBDxSFTzWdcGbazLgG5hIBI2APcL2ALGe+UTiaAlQQ8M
SamHmWaah5b9jQ+dmAC92VVDJiXukRwEp4IahGJaAYMZB0S9DJBWCYEuSCpa8vNF
NiaNQuwNv9o=
=QUjo
-----END PGP SIGNATURE-----

--NsYpzUZ4z5mp8BBz--

