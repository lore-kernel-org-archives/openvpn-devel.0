From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
Message-ID: <20050619224221.GC19819@...33...>
References: <200506141234.50171.nomis80@...401...> <200506150712.01979.nomis80@...401...> <Pine.LNX.4.58.0506161121140.907@...41...> <200506191243.23137.nomis80@...422...>
Mime-Version: 1.0
In-Reply-To: <200506191243.23137.nomis80@...422...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Jun 19 15:44:07 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sun, 19 Jun 2005, Simon Perreault wrote:

> ...which is wrong. If you try to use the auth-pam plugin when pam-devel isn't 
> installed, it will not find libpam.so.
> 
> .so's are only included in -devel packages because their only use is when 
> linking.

False. The linker, when linking a shared object, just writes a line
"bind library libfoo.so.4.2 at run time" into the program, and this
exact library (for ELF, use readelf or objdump to look for "SONAME" and
"NEEDED" attributes) is then linked when the program is run.

The .so file without .4.2 suffix (the exact numbers are an arbitrary
example here) is indeed only needed at link time, but the variant that
matches the SONAME of the library that was linked against is also needed
at runtime.

Emulating the library search characteristics of the particular system's
linker is a different task though, and doing this incompletely can
indeed cause trouble finding runtime libraries.

So you may have:

libfoo-1.2.3-4.rpm containing:
lib/libfoo.so.4.2
man/man7/foo.7.gz
share/doc/foo/README

libfoo-devel-1.2.3-4.rpm containing:
lib/libfoo.a (static lib)
lib/libfoo.so (convenience link to libfoo.so.4.2)
man/man3/foo.3.gz
include/foo.h

-- 
Matthias Andree

