Date: Wed, 24 Aug 2016 15:13:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160824131315.GL78279@...1296...>
References: <1451908945-12244-1-git-send-email-lstipakov@...277...>
	<1451911424-12970-1-git-send-email-lstipakov@...277...>
	<20160822191828.GT78279@...1296...>
	<20160823134336.GE78279@...1296...>
	<57BD5706.2080305@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pi1ad4bzbEMsC2x1"
Content-Disposition: inline
In-Reply-To: <57BD5706.2080305@...1147...>
Subject: Re: [Openvpn-devel] [PATCH v2] Drop recursively routed packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--Pi1ad4bzbEMsC2x1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 24, 2016 at 10:12:54AM +0200, Jan Just Keijser wrote:
> may I suggest to make this configurable,=20

Well...

> i.e. the user can specify=20
> whether rec routed packets should be dropped?  I'm afraid that we might=20
> end up with code that drops packets that really should not be dropped -=20
> people do weird things with routing: in 99% of the cases in error, but=20
> in 1% of the cases because they want to do something funky.

There is no way that this might ever work(*).

If your tunnel gateway is 1.2.3.4, and you send packets to 1.2.3.4 into
the tunnel, how are these going to arrive?=20=20

Packet goes to TUN, is ecapsulated, and sent to 1.2.3.4.

1.2.3.4 route points to TUN, so packet goes to TUN, gets another layer
of openvpn, and is sent to 1.2.3.4.

1.2.3.4 route points to TUN, so packet goes to TUN, gets a *third* layer
of openvpn, and is sent to 1.2.3.4.

repeat, until the packet hits 1500 byte MTU, and gets fragmented into
*two* packets that loop forever...

gert


(*) it will work if and only if there are multiple routing tables involved,
that is, packets sent by openvpn itself are not subject to the routing=20
tables that would move packets *into* the tunnel - so the Android client
wouldn't need it (VPN API takes care of this), and with the work on
Github #13 to suport network name spaces on linux and multiple routing=20
tables on *BSD, there are indeed scenarios where this makes sense...

... so you're right, v3 needs to have an option...

(This started out really small and simple :-) )
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Pi1ad4bzbEMsC2x1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV72da6kuBuNlUUl1AQJj3wP9FOu1yEOLGjQkArYmZOTSzbLlA0B2hDn5
sRW7jzC54EHZuNBkRT/2y6Kx0e0F/IkrQxKySBfMMrk1WXEg7NzWl5mF6EKaypyo
yTymV0yRiPoJOMyNC10MYA+GnnP4AVUHgyFWEOpUMPeoFM8dNglLKinQ/g5cfkhe
kbj3ymsiRn4=
=R/Hr
-----END PGP SIGNATURE-----

--Pi1ad4bzbEMsC2x1--

