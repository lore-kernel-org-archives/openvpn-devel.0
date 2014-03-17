Date: Mon, 17 Mar 2014 09:40:40 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140317084040.GD16637@...1296...>
References: <1394186298-226674-1-git-send-email-vvk@...1868...>
	<53199C4F.6050006@...1227...> <255951394194357@...1873...>
	<20140307122043.GL16637@...1296...>
	<988771394532734@...1876...>
	<1577061395032793@...1877...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ugi+wePcfTbLzKlB"
Content-Disposition: inline
In-Reply-To: <1577061395032793@...1877...>
Subject: Re: [Openvpn-devel] [PATCH] Flood unicast packet with unknown
	destination to all clients
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladimir Kamarzin <vvk@...1868...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Ugi+wePcfTbLzKlB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 17, 2014 at 11:06:33AM +0600, Vladimir Kamarzin wrote:
> 11.03.2014, 16:16, "Vladimir Kamarzin" <vvk@...1868...>:
> > Here is corrected patch for master.
> What about this patch? It was in attachment.

Sorry, sometimes it takes a while for stuff to get reviewed.  I was out
with a bad case of flu all of last week, and there's not so many developers
who understand the packet flow and can review something like that.

"It will happen", but we can't promise when.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Ugi+wePcfTbLzKlB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUya1CKkuBuNlUUl1AQKSEQP/Wl6cq8DvjwyquhhM0Of4grFL+LTgeizO
sJ14apzlVyM4xgBLa56ohAJ2hDCE+W9N7JdnBpB6jyoOqmJ7kaydEPx5lAG7zQ0w
HEyULqUcqylcbB9GEXn8rrFtRwx2Yd6oesJijBM3meSyT7rWe3bGfL5CSFq0h0P4
g8m9wK/IFSQ=
=o9wH
-----END PGP SIGNATURE-----

--Ugi+wePcfTbLzKlB--

