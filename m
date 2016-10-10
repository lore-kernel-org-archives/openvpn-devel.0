References: <f315ec02-c70b-0793-f29f-4fd03794c4eb@...515...>
	<f48dd34a-40c8-f30d-99ae-7261f3d5ee3b@...515...>
From: debbie10t <debbie10t@...277...>
Message-ID: <04e0da3b-6d7b-5bc7-f0af-314162066284@...277...>
Date: Tue, 11 Oct 2016 00:01:13 +0100
MIME-Version: 1.0
In-Reply-To: <f48dd34a-40c8-f30d-99ae-7261f3d5ee3b@...515...>
Subject: Re: [Openvpn-devel] Summary of today's (Monday,
 10th Oct 2016) community meeting
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



On 10/10/16 21:26, Samuli Sepp=E4nen wrote:
> Discussed testing procedures for the "Windows: do_ifconfig() after
> open_tun()" patch version 2. While the patch passed cron2's test
> scripts, it was agreed that we should give people a chance to test the
> patch in their environments before releasing 2.4-alpha1.
>
> Installers that contain the patch are already available here:
>
> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3_git-do-ifcon=
fig-after-tun-v2-I601-i686.exe>
>
> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3_git-do-ifcon=
fig-after-tun-v2-I601-x86_64.exe>
>
>
> Things/use-cases that should be tested in particular are:
>
> - Running without OpenVPN-GUI
> - Running without the Interactive Service
> - Running --server (on Windows)
> - Using more than one tap adapter
> - General openvpnserv2 testing
>
> Mattock will make announcements about these installers (and subsequent
> installers) to the mailing lists as well as forums.
>

I am now running
openvpn-install-2.3_git-do-ifconfig-after-tun-v2-I601-x86_64
on Win10Pro OVPN Server with half a dozen mixed win/linux clients
and also running as a client with second TAP adapter
Using openvpnserv2

So far: No problems!

Regards

