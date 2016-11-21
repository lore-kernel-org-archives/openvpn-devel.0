References: <CAFHpkQHK_VtPoEbWzno+z5C67tYfo3fZNi5ibLgaPpXE5-o5Ug@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <412be705-14ff-4f00-93cb-9478487400c7@...515...>
Date: Mon, 21 Nov 2016 13:51:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHK_VtPoEbWzno+z5C67tYfo3fZNi5ibLgaPpXE5-o5Ug@...278...>
Subject: Re: [Openvpn-devel] multi language / unicode installer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 21/11/2016 13:32, Илья Шипицин ha scritto:
> Hello,
>
> I see different languages in openvpn.nsi, for example
>
> https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/openvpn.nsi#L97
>
>
> we roll our own installer using nsis-2.50-unicode, and I'm not sure it
> is available for Linux.
> but I guess there might be some interest from community to have
> multilanguage installer (for, example, even for openvpn-nl).
>
> can we switch to "unicode" nsis and start translating openvpn.nsi  ?

I think having proper internationalization (i18n) support would be good 
to have. We will just have to ensure that openvpn-build is capable of 
handling it. As for NSIS version availability: I have not checked what 
is the latest NSIS version available for *NIX, but I suspect it is the 
same as for Windows - we're speaking of a single project, not two 
separate ones, right?

Samuli

