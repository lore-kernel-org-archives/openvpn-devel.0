MIME-Version: 1.0
In-Reply-To: <4F4B402F.70507@...515...>
References: <CAOazyz2Rr6JgnmojZ3Naht6eybdq1KnooEAbARSS=3ZM-iLVJg@...278...>
	<4F4B402F.70507@...515...>
Date: Mon, 27 Feb 2012 16:01:25 +0200
Message-ID: <CAOazyz1xxbxSzHRvS1+3my_86iOQh0Jsvk-G_0+kMLERr0UXog@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] openvpn windows gui
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, Heiko Hund <heiko.hund@...1489...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

2012/2/27 Samuli Sepp=C3=A4nen <samuli@...515...>:
>
>> Hello,
>>
>> A stupid question....
>> Which GUI is embedded in the installer?
>> What is GUI and what is XGUI?
>> All I found is[1].
>>
> In 2.2.x installers the GUI is the old one from here, just signed:
>
> <http://openvpn.se>
>
> In 2.3-alpha1 we use the latest snapshot from here:
>
> <http://sourceforge.net/projects/openvpn-gui>
>
> XGUI is obsolete, it can be ignored. I removed all of the XGUI-related
> stuff from the Python-based buildsystem, but it's still lurking in the
> old "domake-win" buildscripts/.nsi files.
>

Hello Heiko,

I am going to re-write your build system :)
It uses autoconf but not automake and looks some rewrite is needed.
We should probably write an installer.

Is that OK?

Alon.

