Message-ID: <4D264FEB.5030504@...68...>
Date: Fri, 07 Jan 2011 00:27:39 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <jb2PkGhmqClC.rQXy2JmT@...1444...>
	<4D260407.9090004@...1030...> <4D260739.1030201@...68...>
	<4D262940.5020104@...1030...> <4D262C21.6080905@...68...>
	<4D263D2C.2090708@...1030...> <4D264928.3010701@...68...>
	<4D264C44.1090908@...1030...>
In-Reply-To: <4D264C44.1090908@...1030...>
Subject: Re: [Openvpn-devel] bugfix2.1: automake support for plugin build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Mr Dash Four <mr.dash.four@...1030...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 07.01.2011 00:12, schrieb Mr Dash Four:
> 
>> If the patch is applied, the libtoolize tool has populated m4/* and you've
>> regenerated the aclocal.m4 with aclocal, the configure and Makefile.in, then it
>> should suffice, yes.
>>   
> I am more than willing to send you my spec file for you to look at and 
> can also attach instructions on how to try to build this from source if 
> you wish - just let me know. But it definitely isn't working!

Please do. It works for me on FreeBSD amd64 (that's how they call x86_64) with
an arcane configure call to tweak everything for a 32-bit build,  like this:

../configure -C \
	CPPFLAGS="-I/usr/local/include -m32" \
	LDFLAGS="-L/usr/local/lib -L/usr/lib32 -m32 -B /usr/lib32" \
	--disable-lzo

I was too lazy to compile 32-bit lzo for now, hence the --disable. There is no
technical reason though.

> That's not the point. The point is to build a clean i686 package, which 
> is free from any build-machine-arch dependencies (like libgc-x86_64 
> etc). With the patch I attached (which even though quite basic and 
> rudimentary) this is done, though I think a better solution needs to be 
> found.

That's what I get:

$ uname -m
amd64

$ find . -type f | xargs file | grep ELF | grep -v \\.o: | cut -f1 -d: | xargs file
./.libs/down-root.so: ELF 32-bit LSB shared object, Intel 80386, version 1
(FreeBSD), dynamically linked, not stripped
./.libs/auth-pam.so:  ELF 32-bit LSB shared object, Intel 80386, version 1
(FreeBSD), dynamically linked, not stripped
./openvpn:            ELF 32-bit LSB executable, Intel 80386, version 1
(FreeBSD), dynamically linked (uses shared libs), for FreeBSD 8.1 (801500), not
stripped

$ find . -type f | xargs file | grep ELF | grep -v \\.o: | cut -f1 -d: | xargs ldd
./.libs/down-root.so:
        libssl.so.6 => /usr/lib32/libssl.so.6 (0x281ad000)
        libcrypto.so.6 => /usr/lib32/libcrypto.so.6 (0x28400000)
        libc.so.7 => /usr/lib32/libc.so.7 (0x28090000)
./.libs/auth-pam.so:
        libpam.so.5 => /usr/lib32/libpam.so.5 (0x281ae000)
        libssl.so.6 => /usr/lib32/libssl.so.6 (0x281b5000)
        libcrypto.so.6 => /usr/lib32/libcrypto.so.6 (0x28400000)
        libc.so.7 => /usr/lib32/libc.so.7 (0x28090000)
./openvpn:
        libssl.so.6 => /usr/lib32/libssl.so.6 (0x28100000)
        libcrypto.so.6 => /usr/lib32/libcrypto.so.6 (0x28149000)
        libc.so.7 => /usr/lib32/libc.so.7 (0x282a5000)

> The arch-dependent flags (line -mXX, -mtune etc) are handled 
> 'automatically' when I specify the --target parameter (i.e. 
> --target=i686 'automatically' sets a bunch of CCFLAGS/LDFLAGS which are 
> arch-dependent) - these are stored in a pretty standard way through 1) 
> the appropriate environment variables (CCFLAGS, LDFLAGS etc); and 2) via 
> the Makefile generated after ./configure is run/executed.

I know that --target= triggers macro expansion in various places, but my point
is that if you can build openvpn, you get these two plugins for free with the
same "make call", and automake takes care to propagate all the needed flags.

> This works for 99% of all cases, except where the appropriate CCFLAGS or 
> LDFLAGS are hard-coded (which is very bad program practice by the way) 
> in a propriety Makefile as is the case with the OpenVPN plugins.

Which means that it's still somehow in your build.

-- 
Matthias Andree

