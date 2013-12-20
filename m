Date: Fri, 20 Dec 2013 09:19:22 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131220081922.GT161@...1296...>
References: <D9FC2C20-7EBE-4C8E-98DF-A48BE87936C4@...1837...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jLXd6P2OOUVH51K5"
Content-Disposition: inline
In-Reply-To: <D9FC2C20-7EBE-4C8E-98DF-A48BE87936C4@...1837...>
Subject: Re: [Openvpn-devel] question about openvpn_ethhdr and openvpn_iphdr
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Abdullah Alshalan <aalshala@...1837...>
Cc: openvpn-devel@lists.sourceforge.net

--jLXd6P2OOUVH51K5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 19, 2013 at 06:56:19PM -0700, Abdullah Alshalan wrote:
> I tried to print out the ethernet and IP headers of the packets in the in=
coming_tun buffer. The methods that does the printing is mentioned below.
> I run the modified openvpn code and established a VPN tunnel.. I establis=
hed an FTP connection between machine A (running openvpn client and ftp cli=
ent ) tun ip is 10.0.8.2 and machine B running FTP server whose IP is 10.0.=
0.2.

If it's a *tun* interface, it won't have ethernet headers.  That's just
plain IP(v6), no ethernet.

> The printed packet info showed incorrect mac addresses, incorrect SRC and=
 DEST IPs.The only thing that was printed correctly was the IP protocol. it=
's always showing 20 or 21.

IP protocol should be "6" for TCP.=20=20

20/21 would be the tcp port numbers for FTP.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jLXd6P2OOUVH51K5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUrP9iqkuBuNlUUl1AQK+YwP9GfApeYbqzd93liqtOqcQtuqP3nklIAp5
woiQtpn1llwflypcl5zLZcss4cYTnNEAC2OcDFz2US1lNI/GICrHB/1vkWxuunwI
g+YoHbxax0wcLCS7hqMjmKUbanb5skPtoxGqgCdFn9mHlUve6qpSPSzoJiSHJk1F
sil94n91AU8=
=o828
-----END PGP SIGNATURE-----

--jLXd6P2OOUVH51K5--

