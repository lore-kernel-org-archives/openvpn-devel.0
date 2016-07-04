References: <f66c1367-1b63-fe29-1522-3ecd59eb53b8@...515...>
	<CAKuzo_jOYoE6NA=zC7cvt5Zm0KekO-1wu=z8R5Qjp+5-=kXvpQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <ab45d6d7-f7c5-2770-dcdd-1ebf04d54705@...515...>
Date: Mon, 4 Jul 2016 09:59:48 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jOYoE6NA=zC7cvt5Zm0KekO-1wu=z8R5Qjp+5-=kXvpQ@...278...>
Subject: Re: [Openvpn-devel] Windows service changes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

>
> On Thu, Jun 30, 2016 at 11:04 AM, Samuli Sepp=C3=A4nen <samuli@...515...
> <mailto:samuli@...515...>> wrote:
>
>     The installer linked to above implement all of the above. However, th=
ese
>     three changes are required for things to work properly:
>
>     <https://github.com/OpenVPN/openvpn-build/pull/23>
>     <https://github.com/xkjyeah/openvpnserv2/pull/7>
>
>
> Alternatively the startup mode may be changed from the installer using
>
> sc config OpenVPNServiceInteractive start=3Dauto

Yeah, I was planning on using sc.exe for managing Interactive Service.=20
I've heard sc.exe is available on all of our supported platforms, and=20
also in a predictable path.

> Something like this to change the mode at install time will be required
> to support the checkbox mentioned below.
>
>
>     <https://github.com/OpenVPN/openvpn/pull/57>
>
>     The only thing missing is launching the "Interactive Service" at inst=
all
>     time, and adding a checkbox "Enable Interactive Service" to the
>     installer, as agreed upon in this email thread:
>
>
> Oh I missed this paragraph on the first read -- hence my stupid question
> in the previous email.. Anyway, once the startup mode is set as
> automatic it will anyway start after next reboot, so is there a need to
> have that checkbox? Unless unchecking it also means the mode will be
> changed to manual.

The "Enable Interactive Service" checkbox would control the state of the=20
Interactive service:

Yes -> service mode set to automatic, start at OpenVPN install
No  -> service mode set to manual, do not start at OpenVPN install

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

