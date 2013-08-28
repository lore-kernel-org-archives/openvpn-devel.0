Message-ID: <521DCE10.1080009@...515...>
Date: Wed, 28 Aug 2013 13:16:48 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <CAFHpkQEryg2E4dWYoL9PkFMFwpmsggJEEZ2G=+5XO39xyVJGug@...278...>
In-Reply-To: <CAFHpkQEryg2E4dWYoL9PkFMFwpmsggJEEZ2G=+5XO39xyVJGug@...278...>
Subject: Re: [Openvpn-devel] lzo-2.06 ?
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Openvpn-build is using lzo-2.05 because 2.06 did not build, and because
2.06 didn't provide any clear benefits over 2.05. The fix to support
2.06 is probably fairly trivial - nobody just hasn't taken the time to
do it.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




> Hello!
>
> I've found that openvpn build system (taken from
> https://github.com/OpenVPN/openvpn-build) uses lzo-2.05 and one local
> patch against it.
>
> any reason for not using 2.06?
>
> Cheers,
> Ilya Shipitsin
>
> -------------------------------------------------------------------------=
-----
> Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
> Discover the easy way to master current and previous Microsoft technologi=
es
> and advance your career. Get an incredible 1,500+ hours of step-by-step
> tutorial videos with LearnDevNow. Subscribe today and save!
> http://pubads.g.doubleclick.net/gampad/clk?id=3D58040911&iu=3D/4140/ostg.=
clktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


