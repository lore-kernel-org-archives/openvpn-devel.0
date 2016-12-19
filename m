References: <CAFHpkQGN61ikifN6b+ukKuT-xX5o8k2V4WyOJXOx7deQr4VAaQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <45031966-d411-018a-a1c8-091d2089c484@...515...>
Date: Mon, 19 Dec 2016 11:41:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQGN61ikifN6b+ukKuT-xX5o8k2V4WyOJXOx7deQr4VAaQ@...278...>
Subject: Re: [Openvpn-devel] Google Summer of Code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Il 17/12/2016 16:44, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
> Hello,
>
> I discussed this earlier with @mattock, however, there are more ideas :)
>
> 1) what do you think of participating GSoC in general ?

In general that is probably a good idea. That said, we'd need somebody=20
to mentor the student, and that can take quite a lot of time.

OpenVPN itself is probably too much for a student that may have fairly=20
limited C programming/networking/cross-platform experience. Our other=20
projects might be better candidates for a GSoC student.

> 2) there are at least 2 ideas which I wished to be done with GSoC
>
> 2a) "import ovpn from URL for network-manager-openvpn" (actually, it is
> perfect way to deliver config to android/ios/whatever", but linux
> network-manager is missing that

So one could give an URL to network-manager and it would import the=20
configuration? Can network-manager-openvpn import configuration files today?

I also wonder if this should be a GSoC project for network-manager, not=20
OpenVPN...

>
> 2b) "Start before logon" thing for openvpn-gui

Do you mean "Start on logon", as in

   "Automatically run openvpn-gui.exe --connect <config-file> on login"

Best regards,

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

