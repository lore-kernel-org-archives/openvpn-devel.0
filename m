Date: Fri, 13 Jul 2012 15:23:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120713132302.GG22125@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dex7YdYhTh9daYX7"
Content-Disposition: inline
Subject: Re: [Openvpn-devel] [OpenVPN Community] #97: OpenVPN produces DCHP
	NAK bomb on Win 7 64bit
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Dex7YdYhTh9daYX7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

forwarding something from a Trac ticket so "someone with time at his
hands" (and understanding of the code) could look into this...

gert

----- Forwarded message from OpenVPN Trac instance <trac@...1739...> -----

#97: OpenVPN produces DCHP NAK bomb on Win 7 64bit
--------------------------------------------------+-------------------------
 Reporter:  janjust                               |        Owner:=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
     Type:  Bug / Defect                          |       Status:  closed=
=20=20=20=20=20=20=20
 Priority:  major                                 |    Milestone:  release =
2.2.2
Component:  Networking                            |      Version:  2.1.4=20=
=20=20=20=20=20=20=20
 Severity:  Not set (if unsure, select this one)  |   Resolution:  fixed=20=
=20=20=20=20=20=20=20
 Keywords:  win7 tap-win32 dhcpnak                |=20=20
--------------------------------------------------+-------------------------

Comment(by ert):

 Seems to be a bug in the TAP driver. It's happening after you try to
 refresh the DHCP lease 3 times (after resume from hibernation, Windows
 tries to acquire a DHCP lease too).
 I think the reason for this is a programming error in dhcp.c in function
 ProcessDHCP:


   // Is this a bad DHCPREQUEST?
   if (msg_type =3D=3D DHCPREQUEST && dhcp->ciaddr !=3D p_Adapter->m_dhcp_a=
ddr)
     ++p_Adapter->m_dhcp_bad_requests;


 should be:

   if (dhcp->ciaddr && msg_type =3D=3D DHCPREQUEST && dhcp->ciaddr !=3D
 p_Adapter->m_dhcp_addr)
     ++p_Adapter->m_dhcp_bad_requests;

 as the win32 DHCP client always requests with all fields set to 0, so this
 increases the error counter even though it isn't a bad request and as
 BAD_DHCPREQUEST_NAK_THRESHOLD is 3, it fails after the third renew
 attempt.
 Could someone please fix this in the TAP driver and provide a signed copy?
 We need the driver for production use...

 Regards.

--=20
Ticket URL: <https://community.openvpn.net/openvpn/ticket/97#comment:8>
OpenVPN Community <http://openvpn.net>
OpenVPN is a layer 2/3 SSL VPN


----- End forwarded message -----

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Dex7YdYhTh9daYX7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUAAhNakuBuNlUUl1AQLOZwP9EIN8quKkIndb2Jm8zB77NObe+3JqUg5O
1EgZ9ofJYMzkCY1mzoxPOJhcF6Tj4r3j+MVmM2awvdfnAOx7e5i2Ru+SnPiyv/eV
TmVfDWeP4ZgLz7Rt8w6dpzn8wf68u+HBCoeXkTo2ZqVc+hnMFgUdDQPkGDGaOrSN
DII7vBEtHis=
=OIOf
-----END PGP SIGNATURE-----

--Dex7YdYhTh9daYX7--

