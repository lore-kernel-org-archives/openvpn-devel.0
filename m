References: <1466784101-20655-1-git-send-email-heiko.hund@...1489...>
	<20161009150659.GP78279@...1296...>
	<20161009152550.GQ78279@...1296...>
	<4d267ceb-f72e-b0e5-477b-2d408f4d71de@...515...>
From: debbie10t <debbie10t@...277...>
Message-ID: <f61044eb-3cff-afef-69af-03e23237a71d@...277...>
Date: Mon, 10 Oct 2016 16:09:58 +0100
MIME-Version: 1.0
In-Reply-To: <4d267ceb-f72e-b0e5-477b-2d408f4d71de@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Windows: do_ifconfig() after open_tun()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi

On 10/10/16 14:42, Samuli Sepp=E4nen wrote:

> Installers with the attached patch:
>
> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3_git-do-ifcon=
fig-after-tun-v2-I601-i686.exe>
> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3_git-do-ifcon=
fig-after-tun-v2-I601-x86_64.exe>
>

For the hell of it I tested -i686 on WXP ..
It successfully installs but then fails to run, missing fwpuclnt.dll

You may want to include a refusal to install on WXP ?

Regards


