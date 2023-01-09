Date: Mon, 9 Jan 2023 22:54:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y7yNMl7fFjW4X09+@greenie.muc.de>
References: <20230105175614.405385-1-arne@...1227...>
 <20230109161521.886055-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1Tzfs1tzw5cizYaY"
Content-Disposition: inline
In-Reply-To: <20230109161521.886055-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4] Add connect-freq-initial option to
 limit initial connection responses
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--1Tzfs1tzw5cizYaY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 09, 2023 at 05:15:21PM +0100, Arne Schwabe wrote:
> This limits the nubmer of packets OpenVPN will respond to. This avoid
> OpenVPN server being abused for refelection attacks in a large scale
> as we gotten a lot more efficient with the cookie approach in our
> initial connection approach.

v4 works perfectly well for unixy platforms, but breaks Windows
compilation, due to "there is a new source module that MSVC does not
know about".

https://github.com/cron2/openvpn/actions/runs/3878016110/jobs/6613714099

:(

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--1Tzfs1tzw5cizYaY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjvI0yAAoJEB2Cnv7KVigSqTAL/jXIWGR2Aw0ebpN3vxUw8SgO
yuxK+b39aulfOXW2UUTLXiS+yq8LIGPk07CUWC/MqlNGzHM59Db0mg7T4nLekSmg
F5wkIQV8p0T2xMJnxB/rXUJRLfIVTM6RN/qWNxc+0d8Di4pusZzIYN0NBBB4g8vq
+oMPvmzpPO55grd2i5I1JlDQYNkwFIWntbKVZ4V49vBW0HyrTHq6xwQhtBJr88+c
MLI362MNQyQTjjzlgTab98kgyBuDO6L+t1LUl1E2DUp1shQmS5rZbOw5bsRiOSPx
5i4dzgVlmHo+dgfxcXqVjWWoUSDLfQghqDbEG9gPu3ultSqB2VWfoHU45UB7RO7u
shdtedTwuDnpibkrUTGjnflnU1Lpd3m516JlwQlYKXpJIuITc3xgQx7oyNCCBZon
9B6xhX5k2V08kZ0Ok9Ro8Ibylr2PugdtNcwLGmJo6lV4elyTQkFM34ZN/pbKIpXb
2/bCOYrGMgVvXmBQrKppJRzD+MEHSLyTPFjhiwFKZw==
=eAds
-----END PGP SIGNATURE-----

--1Tzfs1tzw5cizYaY--

