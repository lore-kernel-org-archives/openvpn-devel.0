Message-ID: <20100913182543.12172.qmail@...1287...>
Date: Mon, 13 Sep 2010 20:25:43 +0200
From: Peter Stuge <peter@...1287...>
References: <AANLkTin2N8TOJ9H+kDFVojiTaaG+AxM+dNc9xFM9XpuF@...278...>
MIME-Version: 1.0
In-Reply-To: <AANLkTin2N8TOJ9H+kDFVojiTaaG+AxM+dNc9xFM9XpuF@...278...>
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

Alon Bar-Lev wrote:
> The whole build environment of openvpn is malformed, using two
> separate build systems for windows and posix,

Only two? Oh that's nothing. We're having lots of fun with build
systems in libusb-1.0, where each contributing Windows developer
actually requires a separate build system. So we have stuff for VC6,
VS2005, VS2008, DDK/WDK, MinGW and Cygwin. :) Fortunately at least
the last two use autotools, and I do consider that the canonical
build method since it covers all supported systems, and allows
automated packaging on a POSIX host, which is what still dominates in
the project. But the Windows support is important, as are the
developers, and as long as someone agrees to maintain a particular
build method then I think it's fine to offer it on some kind of
best-effort basis.

autotools is absolutely alien in Windows, and to be honest a bit of a
hassle to set up if you're already a VS wizard.


> and the mixture of different projects: openvpn, tap, windows
> installer, easy-rsa.

How can the installer situation be improved? I want to make an NSIS
installer as well, and I would quite like to keep it *within* the
project..? Is there a much better way?


//Peter

