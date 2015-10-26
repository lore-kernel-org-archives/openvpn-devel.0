Date: Mon, 26 Oct 2015 13:12:23 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Message-ID: <20151026111223.GL23835@...1281...>
References: <56211F0D.2010806@...515...>
MIME-Version: 1.0
In-Reply-To: <56211F0D.2010806@...515...>
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
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
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Fri, Oct 16, 2015 at 07:00:13PM +0300, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> In Delft we talked about issues with Windows version of OpenVPN quite a=20
> lot. Of the top of my hat I can recall the following isuses:
>=20
> - The tap-windows/tap-windows6 drivers have fairly bad performance
> - In Windows 10 there are DNS leaks
> - The service wrapper (openvpnserv.exe) is effectively broken for=20
> Windows 8 and later
> - The service wrapper has very limited functionality
> - The OpenVPN-GUI we bundle has several major issues, most related to=20
> having to run it as an admin
>

Please add this to the list of missing features:

- Windows OpenVPN-GUI needs to be able to read config files from under user=
's profile directory, not only from the system-wide c:\program files\openvp=
n\config\ directory.



Thanks,

-- Pasi



