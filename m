From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Pre-1.3.3 beta available for testing
Message-ID: <20030219181048.GA21087@...33...>
References: <20030219154840.GB32749@...33...> <200302191650.h1JGouf04085@...41...>
Mime-Version: 1.0
In-Reply-To: <200302191650.h1JGouf04085@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Feb 19 10:14:13 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, 19 Feb 2003, James Yonan wrote:

> Hey, thanks for the patch and all the testing work on different platforms. 

You're welcome. I thought if I give it a whirl, I'd spin it until it was
dizzy :-)

> You raise a number of good points which I will address below:

There were more warnings that I haven't reported because I think they
didn't warrant fixes at this time, some "unused parameter" warnings. Try

make clean
make CFLAGS="-W -Wall"

to see more warnings :-)

> (3) On the issue of including generated files in the CVS -- it seemed in the
> early days of OpenVPN that people wanted the CVS to mirror a tarball and build
> without the required dependencies of automake/autoconf.  But I would have to
> agree with you that eliminating these files makes a lot of sense and nicely
> simplifies things.
> 
> (4) pre-touch -- a bit of a kludge which was added because cvs was not
> committing files which had a later modification date but null diffs (as one
> might argue is correct behaviour).  Because of this there were some
> automake/autoconf problems.  This is probably no longer an issue if generated
> files are removed from the CVS.

Shipping generated files will usually break things one way or another. I
found a few issues in many packages by doing

make distclean
mkdir ../openvpn-build
cd ../openvpn-build
../openvpn/configure -C
make check

or something. I bit myself by accidentally shipping a file I'd think was
generated with leafnode, so I have got some first-hand burn marks ;-)

> (6) Solaris net/if_tun.h missing produces undefined TUNNEWPPA -- will add a
> check to configure.ac.

Thanks.

> (7) Problems with variadic msg() macros on some compilers --  Writing msg() as
> a macro is important for efficiency, to avoid a function call during the vast
> majority of cases where msg() is a noop.  Do you think many people use
> compilers which do not support this?  I suppose one could replace with msg1,
> msg2, msg3, etc. based on the number of arguments, but that would be terribly
> ugly.  I am inclined to leave this as-is, unless you can think of a better way.

I have no profiles, sorry, neither of the function call overhead
incurred or avoided, nor of the compilers.

Hum. <BRAINSTORMING>

## idea #1:
One thing commonly used to hide prototypes away from compilers that
don't support them is enclosing the whole function call in a macro, say:

#ifdef SUPPORT_PROTOS
#define D(p) p
#else
#define D(p) ()
#endif

void myfunc D((int name, char name2));

The important thing is that you pass double parentheses here.

However, the "flags" you use probably prevents us from using this approach.


## idea #2:
Convert the msg macro that you have now to an __inline
function and compile with -finline-functions or -O3 and let the global
optimizer inline the if (debuglevel high enough) checks. I fear though
that the varargs breaks this as well and prevents inlining.


## idea #3:
Use a fixed-argument msg macro big enough to hold all arguments and fill
the unused with NULL (rather than doing a dozen macros on your own).


## idea #4:
profile if calling the function really slows down things that much.

</BRAINSTORMING>

> (9) The Patch -- looks good, I will test and let you know if I see any
> problems.  BTW, does your changes to the automake/autoconf scripts raise the
> required version number for automake/autoconf from 1.6/2.50?

Not that I'm aware of.

I tested aclocal/automake 1.6.3, they look fine on my machine. (I
usually use 1.7.2 though).

autoconf 2.50 should be fine as well, all the relevant checks I added
are documented in autoconf's ChangeLog.2 which "ends" (topmost entry)
with the release of 2.50. I'm using 2.57.

However, I've found that later software (automake 1.7.x and autoconf
2.5x) usually give less bogus warnings and are more robust.

