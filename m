From: Simon Perreault <nomis80@...401...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
References: <200506141234.50171.nomis80@...401...> <200506191243.23137.nomis80@...422...> <20050619224221.GC19819@...33...>
In-Reply-To: <20050619224221.GC19819@...33...>
MIME-Version: 1.0
Message-Id: <200506200817.05804.nomis80@...401...>
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
Date: Mon Jun 20 05:18:43 2005
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sunday 19 June 2005 18:42, Matthias Andree wrote:
> > .so's are only included in -devel packages because their only use is when
> > linking.
>
> False.

True. Let me explain why.

> The linker, when linking a shared object, just writes a line 
> "bind library libfoo.so.4.2 at run time" into the program, and this
> exact library (for ELF, use readelf or objdump to look for "SONAME" and
> "NEEDED" attributes) is then linked when the program is run.

That is true.

> The .so file without .4.2 suffix (the exact numbers are an arbitrary
> example here) is indeed only needed at link time, but the variant that
> matches the SONAME of the library that was linked against is also needed
> at runtime.

That is also true.

> Emulating the library search characteristics of the particular system's
> linker is a different task though, and doing this incompletely can
> indeed cause trouble finding runtime libraries.

That's also true.

> So you may have:
>
> libfoo-1.2.3-4.rpm containing:
> lib/libfoo.so.4.2
> man/man7/foo.7.gz
> share/doc/foo/README
>
> libfoo-devel-1.2.3-4.rpm containing:
> lib/libfoo.a (static lib)
> lib/libfoo.so (convenience link to libfoo.so.4.2)
> man/man3/foo.3.gz
> include/foo.h

That's also true.

You haven't explained why my statement ".so's are only included in -devel 
packages because their only use is when linking" is false. I have agreed with 
everything you have written, and I seem to be missing that critical part. You 
have even provided an example where libfoo.so is in the -devel rpm, just as I 
said.

