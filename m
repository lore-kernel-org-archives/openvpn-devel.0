Date: Thu, 29 Dec 2011 20:29:00 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111229192859.GC5060@...1296...>
References: <A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
	<20111213092241.GO18948@...1296...>
	<1CED409804E2164C8104F9E623B08B90128ACE5B0A@...1436...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005928@...1531...>
	<4EE863A2.5010302@...1114...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005B6D@...1531...>
	<0E891FB5E6304C73BB4338093E409304@...139...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005C00@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D00A3D3@...1534...>
	<A273A2F6519C0D42BFF02CA9C6A825112D011FFF@...1534...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A2x6GFCQWVc4i5ud"
Content-Disposition: inline
In-Reply-To: <A273A2F6519C0D42BFF02CA9C6A825112D011FFF@...1534...>
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tiran Kaskas <Tiran.Kaskas@...1530...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--A2x6GFCQWVc4i5ud
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 29, 2011 at 07:21:41PM +0000, Tiran Kaskas wrote:
> Well, the vpn server runs on windows.

Why would you want to do that?  But even though - you need to enable
routing on the box, if you want it to be a router.

> You mean that every packet received from the outside should be forwarded =
to the tun?

No.  Only packets destined to the tun interface.

> The problem is that i do not see this reply from the outside coming into =
the vpn server(listenning on the physical link using wireshark).

You didn't listen.  If the box is not operating as a router, it will NOT
forward packets for IP adresses not belonging to itself, but silently
drop the packet ("this is not for me, I am not a router, to hell with it").

Now I wouldn't know how to enable ip forwarding on Windows, and I wouldn't
even think of running an OpenVPN server on Windows, but supposedly it can
be done.  Let someone else chime in and answer that...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--A2x6GFCQWVc4i5ud
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTvy/e6kuBuNlUUl1AQLQ/AQAvi9c63pgvwzo3J/nr1eHxEMBtuVGL2W/
1Pi1wvTsLO0AvgS6N/cx4bWHkvuC0ToGUhrFo74SFirRQ81R7SK8qsR1bvrZbd3Q
XxsNT38tNOCMv/waNHbb7+3HdcNxgL0/Z5GaL1H0MhRD78FG3yZNmVZq9Bbhwt+3
u3NeiitVjpk=
=2sJU
-----END PGP SIGNATURE-----

--A2x6GFCQWVc4i5ud--

