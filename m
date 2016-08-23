Date: Tue, 23 Aug 2016 15:43:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160823134336.GE78279@...1296...>
References: <1451908945-12244-1-git-send-email-lstipakov@...277...>
	<1451911424-12970-1-git-send-email-lstipakov@...277...>
	<20160822191828.GT78279@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hV9LobOkkIdnlvrX"
Content-Disposition: inline
In-Reply-To: <20160822191828.GT78279@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Drop recursively routed packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--hV9LobOkkIdnlvrX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 22, 2016 at 09:18:28PM +0200, Gert Doering wrote:
> On Mon, Jan 04, 2016 at 02:43:44PM +0200, Lev Stipakov wrote:
> > v2: better method naming
[..]
> > Trac #642
> >=20
> > Signed-off-by: Lev Stipakov <lstipakov@...277...>
>=20
> ACK.

As stupid as this feels - we need to back this out again, because it
breaks TAP mode.  Buildbot complained that all tap tests failed, and
manually bisecting master nailed it to *this* patch, and release/2.3
is similarily broken.

On the server side, for a t_client test with --dev tap, with this patch,
you see "the source mac is rotating"

Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx=
 MULTI: Learn: 20:00:40:01:d8:7a -> cron2-gentoo-i386/193.xx.xx.xx
Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx=
 MULTI: Learn: 20:b9:40:01:d7:c1 -> cron2-gentoo-i386/193.xx.xx.xx
Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx=
 MULTI: bad source address from client [01:72:40:01:fc:a0], packet dropped
Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx=
 MULTI: Learn: 20:00:40:01:3e:b1 -> cron2-gentoo-i386/193.xx.xx.xx
Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx=
 MULTI: Learn: 20:b9:40:01:3d:f8 -> cron2-gentoo-i386/193.xx.xx.xx
Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx=
 MULTI: bad source address from client [01:72:40:01:62:d7], packet dropped
Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx=
 MULTI: Learn: 20:00:40:01:d7:d8 -> cron2-gentoo-i386/193.xx.xx.xx

... which looks like "the IP header ends up where the ethernet header
should be" (every ping packet shows up as "new source address" on the
openvpn server).

I have no idea what this could be, but since we want 2.3.12 out *today*,
we'll need to back it out of 2.3 for the time being.

Lev, do you have time to investigate?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--hV9LobOkkIdnlvrX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV7xTCKkuBuNlUUl1AQI/xgP/YXtWDgKtMHGkLp+r8LI/8/rkWQBNSzhJ
/i8gpgHHMPFQ8B+s5kt5aq9MNnhsCCsLh7+coy36fwPuLwZ5VNcTBPrZnsBTsjOQ
+SZsOXOGz5d4CiATb+R1xele5+DUERk0jHQEP0InmWrFv+jt7W4N9Ii7rde6dSQi
fmWlBWHeYZ8=
=Y4gj
-----END PGP SIGNATURE-----

--hV9LobOkkIdnlvrX--

