Resent-Message-ID: <20200205133027.GN1431@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
Date: Wed, 5 Feb 2020 14:18:28 +0100
From: Domagoj Pensa <domagoj@...2540...>
Message-ID: <20200205131828.GA16251@...2540...>
References: <20200205124615.15758-1-domagoj@...2540...>
 <20200205124615.15758-3-domagoj@...2540...>
 <20200205130511.GM1431@...1296...>
MIME-Version: 1.0
In-Reply-To: <20200205130511.GM1431@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix linking issues on MinGW
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>

Hi!

On Wed, Feb 05, 2020 at 02:05:11PM +0100, Gert Doering wrote:
> Hi,
> 
> On Wed, Feb 05, 2020 at 01:46:15PM +0100, Domagoj Pensa wrote:
> > MinGW linking fails for several files due to a missing "static"
> > declaration in functions tuntap_is_wintun() and tuntap_ring_empty().
> 
> It does not fail for us.  So what MinGW version on what OS are you using
> to exhibit this error?

I've mentioned that in first mail:

I'm using Ubuntu 19.04 with mingw-w64 from official repository (version 
6.0.0-3) and for build process script generic/build from openvpn-build 
repository.

I've also included linker output same mail:

/usr/bin/x86_64-w64-mingw32-ld: forward.o:forward.c:(.text+0x5fec): 
undefined reference to `tuntap_is_wintun'
/usr/bin/x86_64-w64-mingw32-ld: mtcp.o:mtcp.c:(.text+0x8a4): undefined reference to `tuntap_is_wintun'
/usr/bin/x86_64-w64-mingw32-ld: mtcp.o:mtcp.c:(.text+0x1362): undefined reference to `tuntap_is_wintun'
/usr/bin/x86_64-w64-mingw32-ld: mtcp.o:mtcp.c:(.text+0x1379): undefined reference to `tuntap_ring_empty'
/usr/bin/x86_64-w64-mingw32-ld: mudp.o:mudp.c:(.text+0x536): undefined reference to `tuntap_is_wintun'
/usr/bin/x86_64-w64-mingw32-ld: mudp.o:mudp.c:(.text+0xf53): undefined reference to `tuntap_ring_empty'
/usr/bin/x86_64-w64-mingw32-ld: openvpn.o:openvpn.c:(.text+0x1b6): undefined reference to `tuntap_ring_empty'
/usr/bin/x86_64-w64-mingw32-ld: openvpn.o:openvpn.c:(.text+0x261): undefined reference to `tuntap_is_wintun'
collect2: error: ld returned 1 exit status

Here are versions for some tools from that package:

$ /usr/bin/x86_64-w64-mingw32-ld -v
GNU ld (GNU Binutils) 2.32

$ x86_64-w64-mingw32-gcc -v
Using built-in specs.
COLLECT_GCC=x86_64-w64-mingw32-gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-w64-mingw32/8.3-win32/lto-wrapper
Target: x86_64-w64-mingw32
Configured with: ../../src/configure --build=x86_64-linux-gnu --prefix=/usr --includedir='/usr/include' --mandir='/usr/share/man' --infodir='/usr/share/info' --sysconfdir=/etc --localstatedir=/var --disable-silent-rules --libdir='/usr/lib/x86_64-linux-gnu' --libexecdir='/usr/lib/x86_64-linux-gnu' --disable-maintainer-mode --disable-dependency-tracking --prefix=/usr --enable-shared --enable-static --disable-multilib --with-system-zlib --libexecdir=/usr/lib --without-included-gettext --libdir=/usr/lib --enable-libstdcxx-time=yes --with-tune=generic --with-headers=/usr/x86_64-w64-mingw32/include --enable-version-specific-runtime-libs --enable-fully-dynamic-string --enable-libgomp --enable-languages=c,c++,fortran,objc,obj-c++,ada --enable-lto --with-plugin-ld --enable-threads=win32 --program-suffix=-win32 --program-prefix=x86_64-w64-mingw32- --target=x86_64-w64-mingw32 --with-as=/usr/bin/x86_64-w64-mingw32-as --with-ld=/usr/bin/x86_64-w64-mingw32-ld --enable-libatomic
Thread model: win32
gcc version 8.3-win32 20190406 (GCC)

Domagoj


