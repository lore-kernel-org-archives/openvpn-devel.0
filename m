Message-ID: <35FDB1800B804FEA86A7068D91CAB8D8@...2089...>
From: <debbie10t@...277...>
References: <564AFAF5.4030004@...515...><SN1PR08MB1391C054994551CB11B84DADB91D0@...2065...>
	<564B69FF.2080902@...515...>
Date: Tue, 17 Nov 2015 21:21:47 -0000
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN-GUI now on GitHub + other Windows team
	things
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format="flowed"; charset="windows-1252"; reply-type="original"
Content-Transfer-Encoding: quoted-printable
To: "Morris, Russell" <rmorris@...1315...>, openvpn-devel@lists.sourceforge.net, =?Windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>

Today - I _finally_ managed to cross-compile openvpn for windows (including
GUI+service) I strongly recommend, *if* you try this, use Ubuntu 14.04 64bi=
t=20
!
I tried and failed with other *nix.

https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem

Building for Linux with Linux is relatively simple by comparison.

Regards

----- Original Message -----=20
From: "Samuli Sepp=E4nen" <samuli@...515...>
To: "Morris, Russell" <rmorris@...1315...>;=20
<openvpn-devel@lists.sourceforge.net>
Sent: Tuesday, November 17, 2015 5:55 PM
Subject: Re: [Openvpn-devel] OpenVPN-GUI now on GitHub + other Windows team=
=20
things


Hi,

I personally don't build openvpn-gui as-is. Instead, it gets built
during the openvpn-build build process, which builds OpenVPN and all its
dependencies.

We should definitely document this option in the openvpn-gui readme.
Currently it's only documented in Trac.

Samuli



> Hi,
>
> I do see the notes about " Building OpenVPN GUI from source" - but is=20
> there a way to build this under Linux (may be easier for some)?
>
> Thanks,
> ... Russell
>
>
> -----Original Message-----
> From: Samuli Sepp=E4nen [mailto:samuli@...515...]
> Sent: Tuesday, November 17, 2015 4:01 AM
> To: openvpn-devel@lists.sourceforge.net
> Subject: [Openvpn-devel] OpenVPN-GUI now on GitHub + other Windows team=20
> things
>
> Hi all,
>
> I migrated my private fork of openvpn-gui on GitHub to the OpenVPN
> organization:
>
> <https://github.com/OpenVPN/openvpn-gui>
>
> You can now issue pull requests and all that. An official
> CONTRIBUTING.rst file is still missing so we need to create one.
>
> ---
>
> I also officially announced the #openvpn-windows IRC channel on forums:
>
> <https://forums.openvpn.net/topic20238.html>
>
> I also asked opinions about having a separate forum board for Windows
> questions:
>
> <https://forums.openvpn.net/topic20240.html>
>
> Feel free to chime in!
>
> Best regards,
>



---------------------------------------------------------------------------=
---
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel=20


