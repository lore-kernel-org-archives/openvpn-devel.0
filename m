Message-Id: <1506797785.3933973.1123579944.40D80593@...2307...>
From: logcabin@...2306...
MIME-Version: 1.0
In-Reply-To: <20170930181555.GA70062@...1296...>
Date: Sat, 30 Sep 2017 14:56:25 -0400
References: <1506735276.3927298.1123095944.62A302FF@...2307...>
 <20170930074629.GT70062@...1296...>
 <20170930161910.GX70062@...1296...>
 <1506794899.87173.1123548520.4DA7A99E@...2307...>
 <20170930181555.GA70062@...1296...>
Subject: Re: [Openvpn-devel] Unreferenced function in 2.4.4 Linux build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This has solved the problem:

./configure LZ4_CFLAGS=-I/usr/local/include LZ4_LIBS="-L/usr/local/lib
-llz4"

My mistake was to assume that since ./configure had found LZ4 version >=
1.7.1, it would also locate the latest lz4 library. My bad.

Thanks for all your help!

On Sat, Sep 30, 2017, at 02:15 PM, Gert Doering wrote:
> Hi,
> 
> On Sat, Sep 30, 2017 at 02:08:19PM -0400, logcabin@...2306... wrote:
> > Here's the output from the locate command:
> > 
> > /usr/lib/arm-linux-gnueabihf/liblz4.a
> > /usr/lib/arm-linux-gnueabihf/liblz4.so
> > /usr/lib/arm-linux-gnueabihf/liblz4.so.1
> > /usr/lib/arm-linux-gnueabihf/liblz4.so.1.3.0
> > /usr/lib/arm-linux-gnueabihf/pkgconfig/liblz4.pc
> > /usr/local/lib/liblz4.a
> > /usr/local/lib/liblz4.so
> > /usr/local/lib/liblz4.so.1
> > /usr/local/lib/liblz4.so.1.8.0
> > /usr/local/lib/pkgconfig/liblz4.pc
> 
> This is likely the issue here.  You have a very old version in the 
> system linking path (1.3.0), and a recent version in /usr/local/lib/ -
> but
> to use that, the compiler would need a "-L/usr/local/lib" directive.
> 
> Unfortunately, even if our configure script had checked for the
> LZ4_compress_default() function, it might have still bombed later, as
> "which -I and -L directives end up in the final compile/link call"
> is not always those that are used for a certain test.
> 
> 
> > Since I could not locate LZ4_compress_default() in the openvpn source, I
> e pulled lz4.c from the lz4 source tree, snipped out that function from
> > the file, and then inserted it into comp_lz4.c. This does not work
> > because there are many dependencies in this function.
> > 
> > So I made a horrible hack and simply included lz4.c in comp_lz4.c. This
> > solved the dependencies, but is most likely the wrong way to solve this
> > problem :-)
> 
> Well, it is :-) - the "best" way might have been to explicitely tell
> configure where to find the new library
> 
>  ./configure LZ4_CFLAGS=-I/usr/local/include LZ4_LIBS="-L/usr/local/lib
>  -llz4"
> 
> (the quote "" characters are needed due to the "-l").
> 
> Alternatively, rename the system "lz4.h" before running configure, in
> which case OpenVPN will fall back to using its own copy, bundled in 
> src/compat/compat-lz4*.
> 
> gert
> -- 
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~gert/
> Gert Doering - Munich, Germany                            
> gert@...1296...
> fax: +49-89-35655025                       
> gert@...1297...
> Email had 1 attachment:
> + signature.asc
>   1k (application/pgp-signature)

