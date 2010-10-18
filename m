Date: Mon, 18 Oct 2010 18:41:39 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20101018164138.GB16573@...1330...>
References: <4CBC6CD4.7000103@...1418...>
MIME-Version: 1.0
In-Reply-To: <4CBC6CD4.7000103@...1418...>
Subject: Re: [Openvpn-devel] Errors adding routes on Windows 7 with OpenVPN
 2.1.3
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
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Mon, Oct 18, 2010 at 05:50:44PM +0200, Christian Rank wrote:
> Hello,
>=20
> we noticed a strange problem with OpenVPN 2.1.3 on a Windows 7 client
> here: The VPN tunnel to an OpenVPN server does no longer work since the
> OpenVPN 2.1.3 software tries to insert many strange routes into the
> Windows 7 routing tables. With OpenVPN 2.1.1, all goes well. Our OpenVPN
> server is running on OpenVPN 2.1_rc15 i686-pc-linux-gnu.
>=20
> I have attached the Windows OpenVPN log file (with verbosity 4).
>=20
> Maybe this is a bug in the Windows implementation of OpenVPN 2.1.3?
>=20

Hi Christian,

It's not a bug in the Windows implementation but in OpenVPN 2.1.3
itself. The bug is reported and it is being worked in.
I think you're using 'remote_host' on your client configuration (or
pushing it from the server). If that's the case, try changing that with
the IP of the VPN server and see if that fixes it in the meantime.

Cheers,

Alberto


--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

