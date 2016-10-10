References: <1466784101-20655-1-git-send-email-heiko.hund@...1489...>
	<20161009150659.GP78279@...1296...>
	<20161009152550.GQ78279@...1296...>
	<4d267ceb-f72e-b0e5-477b-2d408f4d71de@...515...>
	<f61044eb-3cff-afef-69af-03e23237a71d@...277...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <fa97aae6-fe54-33f1-d419-1b96d463e1f1@...515...>
Date: Mon, 10 Oct 2016 20:44:24 +0300
MIME-Version: 1.0
In-Reply-To: <f61044eb-3cff-afef-69af-03e23237a71d@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Windows: do_ifconfig() after open_tun()
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
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

Il 10/10/2016 18:09, debbie10t ha scritto:
> Hi
>
> On 10/10/16 14:42, Samuli Sepp=E4nen wrote:
>
>> Installers with the attached patch:
>>
>> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3_git-do-ifco=
nfig-after-tun-v2-I601-i686.exe>
>> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3_git-do-ifco=
nfig-after-tun-v2-I601-x86_64.exe>
>>
>
> For the hell of it I tested -i686 on WXP ..
> It successfully installs but then fails to run, missing fwpuclnt.dll
>
> You may want to include a refusal to install on WXP ?
>

Hi,

We did exactly that in "Fail if trying to run I60x installer on Windows=20
XP" commit:

<https://github.com/OpenVPN/openvpn-build/commit/65e328c89182c47d1a93398e04=
ca92199bf17af3>=20


Even though that change was crafted pretty carefully, it made all=20
installers - including I00x ones - fail on Windows XP. So we had to=20
revert the change:

<https://github.com/OpenVPN/openvpn-build/commit/42aed3b6e1267258830a6a071b=
477b5524500a4b>

I have not had time to look into that issue again. If somebody has a=20
clue why the NSI code in commit 65e328c89 did not work please let me know.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

