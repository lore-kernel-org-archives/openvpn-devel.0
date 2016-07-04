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
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <f102cd48-d5d4-ef1c-2ad4-a9313f5488d9@...515...>
Date: Mon, 4 Jul 2016 14:33:35 +0300
MIME-Version: 1.0
In-Reply-To: <20160629102122.GW78279@...1296...>
Subject: Re: [Openvpn-devel] git master: no more WinXP ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Wed, Jun 29, 2016 at 01:17:10PM +0300, Samuli Sepp=E4nen wrote:
>> We can definitely add a checkbox for the interactive service. However, I
>> would make it opt-out to reduce the impact on support. Only a handful of
>> people know that in order to run OpenVPN-GUI without admin privileges
>> requires OpenVPNServiceInteractive to be running, and trying to educate
>> users is probably a lost cause :).
>
> This was about what I wanted to suggest - checkbox, but default to
> "yes, I want to have it installed and started" (like with the tap driver
> today).
>
> gert
>

Hi,

This has now been implemented:

<https://github.com/OpenVPN/openvpn-build/pull/23/commits/2a6d3fcf623d1a3db=
4c130f04a1ee931b0c96874>

Based on testing on Windows 7 64-bit the changes work as expected. A=20
review of the PR would be most welcome.

Here is an installer that includes all the necessary bits to make=20
openvpnserv2/interactive service things work nicely:

<http://build.openvpn.net/downloads/snapshots/openvpn-install-2.3_git-I905-=
x86_64.exe>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

