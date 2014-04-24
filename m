Message-ID: <535935F7.6040802@...515...>
Date: Thu, 24 Apr 2014 19:04:07 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CABBOjCJuPbKa-ocaqVQDtFT3PreE=GrZPm0Dv_12o1A14ZNkBA@...278...>	<CABBOjC+m6LTk+TYtCXswYH017GAh7CFe8tSqOOr-idR+q_dTfg@...278...>	<1398345955.723.137.camel@...1904...>
	<20140424145929.GS16637@...1296...>
In-Reply-To: <20140424145929.GS16637@...1296...>
Subject: Re: [Openvpn-devel] TAP adapter detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, David Woodhouse <dwmw2@...1866...>
Cc: Greg Toombs <gtoombs@...1905...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openconnect-devel@...1906..." <openconnect-devel@...1906...>


> Hi,
>
> On Thu, Apr 24, 2014 at 02:25:55PM +0100, David Woodhouse wrote:
>> Hm, really "tapoas"? Where did that driver come from?
> Looking more closely, I see
>
>         if self.opt.oas:
>             kv['PRODUCT_NAME'] =3D "OpenVPNAS"
>             kv['PRODUCT_TAP_WIN_DEVICE_DESCRIPTION'] =3D "TAP-Win32 Adapt=
er OAS (NDIS 6.0)"
>             kv['PRODUCT_TAP_WIN_PROVIDER'] =3D "TAP-Win32 Provider OAS"
>             kv['PRODUCT_TAP_WIN_COMPONENT_ID'] =3D "tapoas"
>
> in the tap-windows6 build script...   so I'd assume that there is a=20
> commercial OpenVPN client (Connect or PrivateTunnel) on that machine,=20
> and it brought the new driver with it.
>
> But that's pure guesswork.
>
> gert
I think you guessed it exactly right. I suspect "tapoas" means "TAP
OpenVPN Access Server", which is understandable as OpenVPN Connect
clients are bundled with the Access Server.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


