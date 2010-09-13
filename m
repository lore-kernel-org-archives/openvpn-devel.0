Message-Id: <D361C0BE-FCDA-4DA0-BA44-E344D33242B0@...1348...>
From: Toby Thain <toby@...1348...>
In-Reply-To: <20100913182543.12172.qmail@...1287...>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Mon, 13 Sep 2010 14:59:32 -0400
References: <AANLkTin2N8TOJ9H+kDFVojiTaaG+AxM+dNc9xFM9XpuF@...278...>
	<20100913182543.12172.qmail@...1287...>
Subject: Re: [Openvpn-devel] Windows build was messed up!
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Peter Stuge <peter@...1287...>
Cc: openvpn-devel@lists.sourceforge.net


On 13-Sep-10, at 2:25 PM, Peter Stuge wrote:

> Alon Bar-Lev wrote:
>> The whole build environment of openvpn is malformed, using two
>> separate build systems for windows and posix,
>
> Only two? Oh that's nothing. We're having lots of fun with build
> systems in libusb-1.0, where each contributing Windows developer
> actually requires a separate build system. So we have stuff for VC6,
> VS2005, VS2008, DDK/WDK, MinGW and Cygwin. :)

I consider diversity of working build environments a net benefit to  
the project. It's another useful axis of portability and helps rub off  
non-portable burrs.


> Fortunately at least
> the last two use autotools, and I do consider that the canonical
> build method since it covers all supported systems, and allows
> automated packaging on a POSIX host, which is what still dominates in
> the project. But the Windows support is important, as are the
> developers, and as long as someone agrees to maintain a particular
> build method then I think it's fine to offer it on some kind of
> best-effort basis.
>
> autotools is absolutely alien in Windows, and to be honest a bit of a
> hassle to set up if you're already a VS wizard.

NMAKE is convenient for Windows builds as it will also happily run  
under Linux/WINE, targeting both 32 and 64 bit Windows runtimes with  
the 'freely downloadable' Express toolchain. It may even be possible  
to combine autotools with the Microsoft compiler, though I haven't  
tried it (CC="wine cl", etc).

--Toby


>
>
>> and the mixture of different projects: openvpn, tap, windows
>> installer, easy-rsa.
>
> How can the installer situation be improved? I want to make an NSIS
> installer as well, and I would quite like to keep it *within* the
> project..? Is there a much better way?
>
>
> //Peter
>
> ------------------------------------------------------------------------------
> Start uncovering the many advantages of virtual appliances
> and start using them to simplify application deployment and
> accelerate your shift to cloud computing
> http://p.sf.net/sfu/novell-sfdev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


