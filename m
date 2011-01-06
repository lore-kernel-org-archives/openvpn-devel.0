Message-ID: <4D264C44.1090908@...1030...>
Date: Thu, 06 Jan 2011 23:12:04 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <jb2PkGhmqClC.rQXy2JmT@...1444...>
	<4D260407.9090004@...1030...> <4D260739.1030201@...68...>
	<4D262940.5020104@...1030...> <4D262C21.6080905@...68...>
	<4D263D2C.2090708@...1030...> <4D264928.3010701@...68...>
In-Reply-To: <4D264928.3010701@...68...>
Subject: Re: [Openvpn-devel] bugfix2.1: automake support for plugin build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Matthias Andree <matthias.andree@...68...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> If the patch is applied, the libtoolize tool has populated m4/* and you've
> regenerated the aclocal.m4 with aclocal, the configure and Makefile.in, then it
> should suffice, yes.
>   
I am more than willing to send you my spec file for you to look at and 
can also attach instructions on how to try to build this from source if 
you wish - just let me know. But it definitely isn't working!

> That's what I understood, however this is an easy case as most x86_64 build
> systems I know can support i686 executables if the necessary libraries are
> installed, and I found this particular situation (build for i686 on x86_64) to
> be particularly convenient on Fedora.
>   
That's not the point. The point is to build a clean i686 package, which 
is free from any build-machine-arch dependencies (like libgc-x86_64 
etc). With the patch I attached (which even though quite basic and 
rudimentary) this is done, though I think a better solution needs to be 
found.

> I think you could. ./configure CC="gcc -m32" would normally do, but I haven't
> gotten around to test drive things on F14.
>   
The arch-dependent flags (line -mXX, -mtune etc) are handled 
'automatically' when I specify the --target parameter (i.e. 
--target=i686 'automatically' sets a bunch of CCFLAGS/LDFLAGS which are 
arch-dependent) - these are stored in a pretty standard way through 1) 
the appropriate environment variables (CCFLAGS, LDFLAGS etc); and 2) via 
the Makefile generated after ./configure is run/executed.

This works for 99% of all cases, except where the appropriate CCFLAGS or 
LDFLAGS are hard-coded (which is very bad program practice by the way) 
in a propriety Makefile as is the case with the OpenVPN plugins.

> Well, for patch testing that's the thing.  For the next releases, we'll have to
> wait what James, David, Samuli decide.
>   
So be it then.


