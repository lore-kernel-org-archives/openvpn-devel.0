Date: Wed, 2 Nov 2016 20:58:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161102195835.GQ28918@...1296...>
References: <1474105652-5672-1-git-send-email-lstipakov@...277...>
	<201611021941.uA2JfCls015655@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRf5ADanJIrukZc5"
Content-Disposition: inline
In-Reply-To: <201611021941.uA2JfCls015655@...2054...>
Subject: Re: [Openvpn-devel] NAK on Re: Drop recursively routed packets
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

--wRf5ADanJIrukZc5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 02, 2016 at 08:41:12PM +0100, Gert Doering wrote:
> ACK, thanks.  Took us long enough.

Bah.  I wanted to do everything right, but missed one crucial test: that
it "does what it says" in tap mode as well - well, it doesn't.=20=20

Unlike v2, this will not break tap (or p2p server or --inetd) mode, but
the functionality is not right.

This code:

      /* make sure we got whole IP header */
      if (BLEN (buf) < (int) sizeof (struct openvpn_iphdr))
        return;

      /* skip ipv4 packets for ipv6 tun */
      if (tun_sa.addr.sa.sa_family !=3D AF_INET)
        return;

      pip =3D (struct openvpn_iphdr *) BPTR (buf);

      /* drop packets with same dest addr as gateway */
      if (tun_sa.addr.in4.sin_addr.s_addr =3D=3D pip->daddr)
        drop =3D true;


... does not take "if it's TAP, skip the ethernet header" into account,
so is comparing tun_sa...s_addr with "something", but not with the=20
IP address in the IP packet inside the ethernet frame.


So, unfortunately, another NAK.

But I noticed before pushing, so just totally ignore my previous mail -
this is not in the official tree (and won't make 2.3.13, meh).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wRf5ADanJIrukZc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWBpFaqkuBuNlUUl1AQJHRgQAxopVC8JuZP/SntrXJAIC2MLlc7WQUOR/
PoxA5aSL9enQ3jSsVGeFkayyUH6MkboHK6FWRBMJtmG6W1v8nnFKeJbkWWF+Fnej
0ctoFZRgnpCZ818M9Q1AA37eQJcTWSMVy0fu9MgCNZl3mzSxZk+GxgVDBuuDL3mp
pwZI4V7vTVg=
=abIP
-----END PGP SIGNATURE-----

--wRf5ADanJIrukZc5--

