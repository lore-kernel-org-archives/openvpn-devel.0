References: <4e9afe58-f398-7163-18fe-9113bf0cdfbc@...277...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <283c21d2-c51c-b2e6-0c5e-5055b6bec3cd@...515...>
Date: Thu, 22 Sep 2016 16:32:18 +0300
MIME-Version: 1.0
In-Reply-To: <4e9afe58-f398-7163-18fe-9113bf0cdfbc@...277...>
Subject: Re: [Openvpn-devel] Linux: Use /tmp for log problem ?
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
To: debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 22/09/2016 16:07, debbie10t ha scritto:
> Hi
>
> posting in devel because I am asking for clarification of
> what the source code really does.
>
> Re: https://forums.openvpn.net/viewtopic.php?f=3D30&t=3D22485
>
> Config:
> |---
> server *normal stuff*
> log-append /tmp/openvpn.log
> ---
>
> I have just tried with Ubuntu1604 myself and observe that:
> (My basic config I added: --log /tmp/client1.log)
>
> 1. $ sudo systemctl start openvpn@...2166... =3D log file *not* created
> 2. $ sudo openvpn client1.conf =3D log file created normally in /tmp
>
> Obviously, systemctl start openvpn@...2166... appends more options when
> starting openvpn (in my hand written service the only addition is
> --daemon client1) So I presume that by daemonizing something changes
> with regard to writing the log file to /tmp ??
>
> Also note, in the forum post --daemon is used within the config file.
>
> I did grep -E "/tmp" src/openvpn/* and found some code in init.c
> (line 664) but it's all C, foo, bar to me (Sea food bar ;-) )
>
> Anyhoo, can anybody provide a brief and simple explanation ?
>
> Many thanks
>

Hi,

I did some testing on my Ubuntu 16.04 VM, and this seems like a=20
permission issue, probably related to the capabilities set in the=20
openvpn unit file:

/lib/systemd/system/openvpn@...1685...

Basically --log and --log-append will work, if the logfile is stored=20
under /etc/openvpn. If you try to put the it under /tmp, it will never=20
appear.

That said, you probably would not need a logfile, as you can view them with

$ journalctl /usr/sbin/openvpn

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

