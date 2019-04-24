MIME-Version: 1.0
References: <9f75757c-6668-c521-af6f-b18e8db3fa72@...515...>
In-Reply-To: <9f75757c-6668-c521-af6f-b18e8db3fa72@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 24 Apr 2019 08:46:44 -0400
Message-ID: <CAKuzo_gwpPebkt_+o9paaR_MFy7c_BJOFW=0CB7K5YT7LVD+bQ@...278...>
Subject: Re: [Openvpn-devel] New OpenVPN 2.4.7 Windows installers released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Apr 24, 2019 at 6:50 AM Samuli Sepp=C3=A4nen <samuli@...515...> wro=
te:
>
> Hi,
>
> New OpenVPN Windows installers have been released. The release
> highlights are:
>
> - Latest openvpn-gui
> - Latest openvpnserv2 (OpenVPNService)
> - Latest tap-windows6 driver
>   - ARM64 support
>   - NDIS 6.30 support
>   - other enhancements
>   - fix to local privilege exploit vulnerability
>
> The installers come in two flavors. Windows 7/8/8.1/Server 2012r2:
>
> <https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.7-I6=
06-Win7.exe>
>
> Windows 10 (any version):
>
> <https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.7-I6=
06-Win10.exe>
>
> We're unable to release a version for Windows Server 2016 at this point,
>  so you need to use the old installer:
>
> <https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.7-I6=
03.exe>
>
> We're working on getting tap-windows6 pass the HLK test suite on Windows
> Server 2016. This will allow us to get a signature from Microsoft and
> release an updated tap-windows6 on that platform as well. While waiting
> please avoid running OpenVPN on nodes where all users are not trusted.
>
> For further details see the download page:
>
> <https://openvpn.net/community-downloads/>

I think we were supposed to continue using openvpnserv2 version
1.3.0 until the MSI installer is ready. Version 1.4.0 included here
requires some logic in the installer to create the new config_dir location
if missing, and move contents from the old location.

See also this PR:
https://github.com/OpenVPN/openvpn-build/pull/141/commits/9c2774ca3841763ad=
a64986b18d1df7634c59a20


Selva

