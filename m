References: <CAFHpkQGrube6hF3+hab3NdNhcifjV15ZSefdUWCcXJPg_CApKw@...278...>
	<20160629081109.GU78279@...1296...>
	<CAFHpkQGD10-N=fX6osaMKE4SN+S55A8EN+8byw6aTM9Aosd1Mw@...278...>
	<20160629090025.GV78279@...1296...>
	<51c19384-4814-c63e-f515-ea0f3ce8791e@...515...>
	<CAFHpkQFMs3OsBoV8LP1BZnZpomMFwp6pvw_bx58UrLK20dyF0Q@...278...>
	<224018c8-c3a7-6a7e-0d46-2f44d87b2990@...515...>
	<CAFHpkQEsEj70wZxdXs9fd8W8j3QfuyWBjJAHXvzUGVTPt50_CQ@...278...>
	<1920c5bf-c449-3a79-5331-c8df691705d8@...515...>
	<20160629102122.GW78279@...1296...>
	<f102cd48-d5d4-ef1c-2ad4-a9313f5488d9@...515...>
	<CAKuzo_hX8EKmX9mF63NhhoH0Wyb7d1cKKu+exvTmKX6wf2OyLA@...278...>
	<b76e82ae-d092-f05a-a6b0-43b66dc18c80@...515...>
	<7ce3c612-9cf9-92b4-49ac-5ac873ebe19b@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <7d485ae4-a178-ed06-07c2-9341017917ad@...515...>
Date: Tue, 5 Jul 2016 12:04:01 +0300
MIME-Version: 1.0
In-Reply-To: <7ce3c612-9cf9-92b4-49ac-5ac873ebe19b@...515...>
Subject: Re: [Openvpn-devel] git master: no more WinXP ?
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

Il 05/07/2016 11:45, Samuli Sepp=C3=A4nen ha scritto:
> Il 05/07/2016 10:02, Samuli Sepp=C3=A4nen ha scritto:
>> Hi,
>>
>>> Hi,
>>>
>>> On Mon, Jul 4, 2016 at 7:33 AM, Samuli Sepp=C3=A4nen <samuli@...515...
>>> <mailto:samuli@...515...>> wrote:
>>>
>>>     Here is an installer that includes all the necessary bits to make
>>>     openvpnserv2/interactive service things work nicely:
>>>
>>>     <http://build.openvpn.net/downloads/snapshots/openvpn-install-2.3_g=
it-I905-x86_64.exe>
>>>
>>>
>>> Tested this installer on windows 7. Works as expected with two minor is=
sues:
>>>
>>> (i) If service installation checkbox is unselected, interactive service
>>> remain selected and obviously fails in the end as no service binaries
>>> get installed
>>
>> Ah yes, I see what you mean. I'll create a dependency between these two
>> selections.
>>
>>> (ii) If GUI is running, the installer offers to stop it but in that case
>>> it also offers to restart it at the end of installation. That's not good
>>> as it gets started as admin (as installer runs as admin) which is not
>>> ideal -- at least not what I wanted. I would say just do not offer to
>>> start the GUI at all even if it was stopped by the installer -- let the
>>> user restart it after installation.
>>
>> Agreed.
>>
>
> Hi,
>
> Fixed the issues you identified:
>
> <https://github.com/OpenVPN/openvpn-build/pull/23>
> <http://build.openvpn.net/downloads/snapshots/openvpn-install-2.3_git-I90=
7-x86_64.exe>
>
> Based on brief testing everything now seems to work correctly. If the
> user deselects SecService, then SecInteractiveService is deselected
> automatically.
>
> Right now, when SecService is not selected, clicking on the
> SecInteractiveService checkbox does not do anything. This would be nice
> to fix, but it is also in line with what we have now. Plus fixing it
> might not be as trivial as adding yet another ${If} to the .onSelChange
> function.

Maybe rewording this a bit is in order. If SecService is disabled,=20
enabling SecInteractiveService is not possible.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

