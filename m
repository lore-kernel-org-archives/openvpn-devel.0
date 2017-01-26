Date: Thu, 26 Jan 2017 09:05:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170126080519.GN940@...1296...>
References: <20170125201947.17197-1-list@...1798...>
	<20170125211623.2019-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fpolVoprVozDR81Y"
Content-Disposition: inline
In-Reply-To: <20170125211623.2019-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] Clean up plugin path handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: mail@...1798..., openvpn-devel@lists.sourceforge.net

--fpolVoprVozDR81Y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 25, 2017 at 10:16:23PM +0100, David Sommerseth wrote:
> ACK.  This have been through enough rounds, and I currently don't
> see a better approach to the openvpn-plugin.h generation either.  If
> we find better ways later on, lets fix it then.

This needs a bit of polishing... as you've undoubtly already seen,
this change broke building on everything that is not Linux or MacOS...

Since we'll see this more often if developers cannot test on "other
platforms", I'm happy to offer accounts on my FreeBSD 10.3 buildslave
to regular contributors that want to test their patches on at least
one BSD system to ensure there is no hidden bashism or GNU Make-ism
(which seems to be the problem here).

Thinking of you and Christian here :-) - so if interested, please mail me=20
a ssh pubkey and a static source IPv4/IPv6 network so I can create an=20
account and open the ACLs (the buildslaves have fairly restricted network=20
access and reachability).

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fpolVoprVozDR81Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYia2/AAoJEB2Cnv7KVigSCHQL/33ii0cCucHBwih4wh3WCXOC
9gkBRNvFMwpiFiVzhHq6vx0sZPT7wqZbOe+8h68HCg2kMjs6PSQcaH5uW6bBEBiA
o/o12mWjJdtvdQoht+ymx/nPWBg7so2Z/X6VziYrAlCHjjfnLaUKyLOjmPfuWv1H
WUbGlqQ441ujgbISvYeyDvjSz3Awg77XJ2OjCmX/0psDzrggjbtXbcjq0oIDXh16
3TuZIBAVzRjjf+EfdNvKan+r5oyGJdW1RdIabL8kUNfWC3+gEaDX/s/YWWNXTCT/
k3HjDZo2Nb2f9td6oI8AQGgJw7HGRKKgDvqDyrjzJGCCG7Qv0ir82+D7D02mQ8an
o9Zj9nb4P98ujzDC2IDykxm9zxyA0S8Db1m70lQtnvIarha6XyGDZfNtMozhjE1F
gD6a5v3Bixxds0CefGEORRrWylPa9iUDMW5EmcNYcOlXRJb28Ygwz/zFXrHQ1Y37
xSh1isydT4ySpAj7uEBgQNZeI0UW5Fly8i/UgunisQ==
=s7+P
-----END PGP SIGNATURE-----

--fpolVoprVozDR81Y--

