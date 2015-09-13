Date: Sun, 13 Sep 2015 14:27:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150913122726.GI34798@...1296...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
	<1441985627-14822-7-git-send-email-gert@...1296...>
	<55F54134.1010902@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CPQPFrYXiKmg9EuQ"
Content-Disposition: inline
In-Reply-To: <55F54134.1010902@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 06/10] Implement handling of overlapping
 IPv6 routes with IPv6 remote VPN server address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--CPQPFrYXiKmg9EuQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Sep 13, 2015 at 11:26:12AM +0200, Arne Schwabe wrote:
> I think we may need an (explicit) opt out of the mechanism. Currently
> the code that inserts the IPv6 host route will always run.

It will only insert the host route if you connect over IPv6, and you=20
try to install IPv6 routes that overlap with the server address=20
(need_remote_ipv6_route=3Dtrue in init_route_ipv6_list()).  If there=20
is no overlap, or you connect over IPv4, it won't do anything (just=20
re-tested to ensure that I did not forget the "we don't need this now"=20
case :-) )

That it auto-activates is intentional - with IPv4, if you do not set=20
--redirect-private, and have overlapping pushed routes with the VPN server=
=20
address, it will silently fail due to recursive routing (unless you
have a VPN API to do the right thing).  So I wanted this to do the=20
right thing automatically on the other platforms as well...

But I can be convinced to add an opt-out switch - what use case do you
have in mind where this would be needed?  In some cases, the logic is=20
not actually *necessary* (if you have a more-specific route for the VPN=20
server than what is pushed), but it won't do *harm* in that case either=20
(tested with /64 routes and pushing /32).


(In any case, thanks for reviewing the first few patches in the set and
the feedback)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CPQPFrYXiKmg9EuQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVfVrrakuBuNlUUl1AQK3egQAiWkGpoVu5N8OmAg1K+YAq42JK0cdQXEN
lcERl3FsyStwSGvA7z5/9B0V2Tod6BNPiWtPmj434+V/PO3RvvIT9WI1w0Ptnzvt
UsLI/mg3Akd5Bmimc55GOuBAunfSnUP/Ozv9QdspCWGwZsz5lomRX3Tl6kSorShS
5w7b8S+nsHY=
=jk9G
-----END PGP SIGNATURE-----

--CPQPFrYXiKmg9EuQ--

