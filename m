Date: Fri, 2 Mar 2012 15:57:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120302145712.GE1359@...1296...>
References: <4F4CE4FE.3010009@...515...>
	<20120229154604.GA7024@...1296...>
	<CAP+U6t+pQXzvU-kGWDSZo6cQB6mf+LPd3LyLaowdB0xakbzjAQ@...278...>
	<1677482.aKjq4FLfA1@...1526...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <1677482.aKjq4FLfA1@...1526...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: Carsten =?iso-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 01, 2012 at 11:58:39AM +0100, Heiko Hund wrote:
> Is there a use case for --route on the client?

I've used "--route-nopull" together with specific "--route" statements
to work around VPN setups that didn't work under specific circumstances
(the server pushes a heap of routes, some of which caused problems in
my setup [*], and I only wanted to reach a specific subnet via the VPN).

gert

(*) specifically: some of the hosts in my scenario can be reached=20
through the VPN, and without VPN.  Firing up the VPN and routing these
hosts through the VPN would break existing SSH sessions, as further
packets would get routed through the VPN, and the VPN server would not
accept the existing source address (not from VPN range).  Yes, not
your daily issue, but I was quite happy to have that knob to fiddle.

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT1DfyKkuBuNlUUl1AQLZpQQAnNBzQ38ibSYr2QPNJOSU4bST7iLe+KHm
XSSFVmn659b5HMgSnzLVTRU+tpVMUgzjzBh/MpTRtFXrRbwcPMuigqMOsbPgxyY2
bzLUQNHNfFvCunuIMYoM+pc8XJEshcY/O/0zP1zZLsEi70kJ3ECMKSS64N41vfkh
h+MGiL3KhiU=
=fb7Z
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--

