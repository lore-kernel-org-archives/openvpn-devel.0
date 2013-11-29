Date: Fri, 29 Nov 2013 20:57:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131129195713.GN161@...1296...>
References: <1354303076-13606-1-git-send-email-arne@...1227...>
	<1354303076-13606-10-git-send-email-arne@...1227...>
	<50CC4FB8.8040005@...1790...> <20121215120924.GU22465@...1296...>
	<50CEDE97.6020808@...515...> <51C580F4.8040804@...1790...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jd2S1KeUgTREicAB"
Content-Disposition: inline
In-Reply-To: <51C580F4.8040804@...1790...>
Subject: Re: [Openvpn-devel] [PATCH 10/10] Implement dual stack client
	support for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tore Anderson <tore@...1790...>
Cc: openvpn-devel@lists.sourceforge.net

--Jd2S1KeUgTREicAB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Tore,

On Sat, Jun 22, 2013 at 12:48:20PM +0200, Tore Anderson wrote:
> >> On Sat, Dec 15, 2012 at 11:23:52AM +0100, Tore Anderson wrote:
> >> [..]
> >>> ACK, I tested several different fail-over scenarios and all worked fi=
ne.
> >>> Also all my pre-existing VPNs (maintained by GNOME NetworkManager)
> >>> worked just fine.
[..]
>=20
> It's been half a year, so I was wondering if this patch has been
> forgotten about? I don't see it in either the master branch of either
> the openvpn or openvpn-testing git repo.

Thanks for your patience :-) - indeed, it has been way too long, but
(insert long list of excuses)...

I have just pushed 23d61c56b9fd218c39ad151b01b7e2d6690e6093 to master,
which has the "latest generation" of the dual-stack patches - the basic
stuff is what you have reviewed and tested, but during the intermediate
year of heavy Android user testing, some more fixes have been found and
integrated, and when reviewing, I found a few warts of my own...  so it
should be even better.

> FWIW, I'd like to push the GNOME NetworkManager folks some more to
> implement IPv6 support in their OpenVPN plugin, which is currently IPv4
> only. This patch breaks one of the assumptions made there, in particular
> that IPv4 transport will always be used when OpenVPN is started
> "--remote <dns-hostname> --proto [tcp|udp]". I'm hoping that when
> dealing with that, which they'll have to do anyway, they'll seize the
> opportunity to implement IPv6 payload support as well.

There!  I'll take you up on this now :-)  (thanks!)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Jd2S1KeUgTREicAB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUpjxmakuBuNlUUl1AQIJhQQAkdpd0c5Mv7SVncCIgOcqS8H2xZMNWC8i
U+pJ1JFKPbrvt8H4dKwsHg9izpJkAAm/96GPbu4Z2y8JsoBEJafGh1VXXsE+/KdM
FxY5wR7E9ZvcGjt2VnF7WpWLHUwaWNpiIQ0SVmK80ULx3UgrxvTjX9hYUER4anmR
0CDNBEHKg3Y=
=TqLp
-----END PGP SIGNATURE-----

--Jd2S1KeUgTREicAB--

