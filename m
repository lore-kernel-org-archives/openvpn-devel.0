Message-ID: <20100913191405.18425.qmail@...1287...>
Date: Mon, 13 Sep 2010 21:14:05 +0200
From: Peter Stuge <peter@...1287...>
References: <AANLkTin2N8TOJ9H+kDFVojiTaaG+AxM+dNc9xFM9XpuF@...278...>
	<20100913182543.12172.qmail@...1287...>
	<D361C0BE-FCDA-4DA0-BA44-E344D33242B0@...1348...>
MIME-Version: 1.0
In-Reply-To: <D361C0BE-FCDA-4DA0-BA44-E344D33242B0@...1348...>
Subject: Re: [Openvpn-devel] Windows build was messed up!
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Toby Thain wrote:
> > So we have stuff for VC6, VS2005, VS2008, DDK/WDK, MinGW and Cygwin. :)
> 
> I consider diversity of working build environments a net benefit to
> the project. It's another useful axis of portability and helps rub
> off non-portable burrs.

I see your point and I agree in part, but personally I would e.g.
prefer to ignore VC6, since it requires a fair amount source code
workarounds because it's *so* old.

Also, someone needs to maintain these build methods, and I wish
people didn't have to spend time on that part so much.


> > autotools is absolutely alien in Windows, and to be honest a bit
> > of a hassle to set up if you're already a VS wizard.
> 
> NMAKE is convenient for Windows builds as it will also happily run
> under Linux/WINE, targeting both 32 and 64 bit Windows runtimes with
> the 'freely downloadable' Express toolchain. It may even be possible
> to combine autotools with the Microsoft compiler, though I haven't
> tried it (CC="wine cl", etc).

Maybe it works for cross-compiling, but then MinGW(-w64) will be way
better tested so why bother, when for people on Windows it's no real
help, they want the GUI stuff. Also, being a library, there are some
more build options like e.g. enable debugging or not. This is
typically a separate target in VS but only a configure switch with
autotools, and while this case is easy enough, I don't think those
targets scale so well..

Personally I'm missing a way to do some build-time scripting also on
Windows. The best idea I've come up with so far is a .cmd which does
some of what autoconf does, e.g. "sed" version number from
configure.ac into .rc files and create a config.h, but that doesn't
mean it's a very good idea. :\


//Peter

