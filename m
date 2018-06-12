Date: Tue, 12 Jun 2018 13:17:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180612111710.GB57262@...1296...>
References: <20180608052017.6696-2-a@...2181...>
 <20180612074240.18865-1-a@...2181...>
 <20180612092937.GA57262@...1296...>
 <830e09cf-7902-4144-bce7-5ff6c5081225@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="DoqoDKVG8/W9HA34"
Content-Disposition: inline
In-Reply-To: <830e09cf-7902-4144-bce7-5ff6c5081225@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3] **Android** note: tun: ensure
 interface can be configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--DoqoDKVG8/W9HA34
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 12, 2018 at 12:14:27PM +0200, Arne Schwabe wrote:
> > The existing Android code is different from all the other platforms,
> > as it sends IPv6 info ("IFCONFIG6") *before* IPv4 info.
> >=20
> > Arne, do I have to assume that this is intentional, and your client will
> > explode if it receives IFCONFIG first and IFCONFIG6 second, or no
> > IFCONFIG at all?
>=20
> No ifconfig at at all will produce an error since ANdroid itself will
> not like to have no ifconfig at all. For the Android client it is only
> important that ifconfig/routes/etc. all happen before opening the tun
> device.
>=20
> IPv6 only should be fine with my client.

So, to paraphrase this: you will handle IFCONFIG and IFCONFIG6 in
either order or "just one of them" fine?

I was sort of assuming the code waits for an incoming IFCONFIG and then
fires up the VPN API with "IFCONFIG and optional IFCONFIG6" - in which
case, sending IFCONFIG first would have caused "fun effects with IFCONFIG6",
and "not sending IFCONFIG at all" would cause interesting effects :-)

... but now I do seem to remember that you collect *all* information
first (IFCONFIG* and ROUTE*), so it doesn't really matter in which order
the "core" sends it...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--DoqoDKVG8/W9HA34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbH6u1AAoJEB2Cnv7KVigSRrAL/1sXJ7kSXom97zbuzA/vD+CB
zrICT3Wxd3P3eAH21qKZSHo+dJQLk5Yy3DjSNakK7Ay2wlmVk22nvIah09fkvtgQ
MPaIN66y8wGnOuLLgsfOcJ6RHPOKH/ba2SCKMt+7qDKiiXzwvQ6RczZKLk7R0lQZ
4nKPgtd+mZvV6G4E+oyq1pDaN3hyM177ZBql3pdl3ZFTAMP+iRo/AJehx+DjTMfr
wlTYdrt5/ohJrahmU1OIs/aJ9ymdfYj8Uln7MPuMpCeFzI5a7bNkmjbd1Ux/wxri
8GGRbFGf+v+P6uXd9qKnNqGHjBoxzpq5fQcbH7zZ+kJROveIxu3KE8dRb2u2mGAC
l3FRCuCfRznj7i7RyHTys9R3++9ztIqYwnzioxghr3TjzTMXdXJ85tqFkIBdxi67
jiZ303yJ1h83zIGz9xLMBuRhD573rMH3RXtZ4SNLBR1qwMgvhPcj2o1uUqfrytgo
AJ4tKt1Hj6ef5OyBFTB9FvxsNsQvfWXxMuVBKFRVkA==
=4pRC
-----END PGP SIGNATURE-----

--DoqoDKVG8/W9HA34--

