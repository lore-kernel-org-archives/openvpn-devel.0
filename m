From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0-test26 released
Message-ID: <20040502090309.GA7550@...33...>
References: <twig.1083217597.4062@...41...> <twig.1083468383.41361@...41...>
Mime-Version: 1.0
In-Reply-To: <twig.1083468383.41361@...41...>
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
Date: Sun May  2 02:04:02 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, 02 May 2004, James Yonan wrote:

> You didn't bracket it with #ifdef TARGET_LINUX -- does that mean it's
> appropriate on all platforms?

> What about this (from the glibc manual): "If your program defines _BSD_SOURCE,
> you must give the option `-lbsd-compat' to the compiler or linker when linking
> the program, to tell it to find functions in this special compatibility
> library before looking for them in the normal C library."

Ouch, that one hurt, so _BSD_SOURCE doesn't look right.

I see this deserves revision and explanation - and maybe no code change
at all.

I came across this compiling with -std=c99 and -pedantic in CFLAGS:

../tun.c: In function `open_tun':
../tun.c:836: error: storage size of 'ifr' isn't known
../tun.c:902: error: `IFNAMSIZ' undeclared (first use in this function)
../tun.c:902: error: (Each undeclared identifier is reported only once
../tun.c:902: error: for each function it appears in.)
../tun.c:921: error: storage size of 'netifr' isn't known
make[1]: *** [tun.o] Error 1
make: *** [all] Error 2

These compiler flags (and similar except the -std=gnuXX) prevent the
definition of __USE_MISC in <features.h>, hence IFNAMSIZ and struct ifr
aren't defined. gcc -std=gnu99 is fine.

/One/ way to define these symbol and struct them is to use _BSD_SOURCE,
but I wasn't aware of the glibc "override POSIX with BSD, require
-lbsd-compat" behaviour, so it make more sense to use _GNU_SOURCE (or
_SVID_SOURCE) instead.

HTH,

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95

