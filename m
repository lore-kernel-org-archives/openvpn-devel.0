From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 25 Jul 2012 11:45:12 +0200
Message-ID: <1438202.PdG2Mf5RXu@...1526...>
In-Reply-To: <500FB0B4.4020306@...515...>
References: <500FB0B4.4020306@...515...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.3_alpha3 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: "openvpn-announce@lists.sourceforge.net" <openvpn-announce@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

On Wednesday 25 July 2012 11:39:16 Samuli Sepp=E4nen wrote:
> This release fixes a major problem in "tap server" mode (Trac #216),
> adds support for querying proxy information via the management interface
> and fixes some smaller issues. In addition, the Windows installer comes
> with tap-windows-9.9.2 (fixes the "DHCP NAK bomb on Windows 7" bug, Trac
> #97) and  openvpn-gui-1.0.5.

I also want to mention that the GUI is now correctly supplying the HTTPS an=
d=20
SOCKS proxy server system settings to openvpn. The info is queried from the=
=20
control panel internet settings. If WPAD or a PAC file are configured there=
,=20
it uses automatic proxy detection as well.

I would like to ask people to give this a try and report any shortcomings b=
ack=20
to the -devel list.

Thanks, Heiko
--=20
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


