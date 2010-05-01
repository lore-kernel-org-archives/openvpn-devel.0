Message-ID: <4BDC2F8C.1010206@...1114...>
Date: Sat, 01 May 2010 15:41:32 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <B23F897A-5ADC-4A29-A34B-3BB16C18B4F3@...1360...>
	<4BD7DB78.2010704@...1114...>
	<C5DC4FDD-13FA-45AC-9D17-35BE15E03C1D@...1360...>
In-Reply-To: <C5DC4FDD-13FA-45AC-9D17-35BE15E03C1D@...1360...>
Subject: Re: [Openvpn-devel] [PATCH] Mac OSX Keychain certificate support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Brian Raderman <brian@...1360...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/05/10 08:18, Brian Raderman wrote:
> Hi David,
> 
> Thank you for taking a look at the patch and providing such thorough feedback so 
> quickly.

You're welcome!  I'm happy to see you updating the patch and bringing it
one step closer for inclusion!  The further progress now will be to get
some more people to test out this patch on OSX and hopefully they can
report back.  If you know anyone who is willing to help out doing that,
that will make things quicker as well!

Also, as I don't have OSX available, I'm not able to really compile test
this patch further.  So it will need to get an ACK by someone else who
have access and can do a proper review with OSX in mind.

> I have done everything that you asked:
> 
> * Changed printf() calls to use msg().  The prints are not actually used right
> now, but they are a part of the debug code that I wrote for testing
> the certificate reading functions.  They were actually tested in a
separate
> application, but I thought I should keep them with the rest of the code in
> case the certificate lookup functionality needs to be debugged inside
of openvpn
> at a later date.

Looking good!  You also have dmsg() I believe for debugging as well.
But then I believe the logging will only be enabled if configured with
- --enable-debug, iirc.  Anyway, that was just a side note.  If you want
it like it is now, we don't need to change anything in this regard.

> * Changed malloc calls to the gc_arena api.

Seems good to me.  Have you tried running a patched OpenVPN through
valgrind?  Just to make sure you don't have any memory leaks.  It's
important to also check how it reacts when re-negotiating the tunnel
encryption (--reneg-* arguments can be tweaked to make this happen more
often).  And also if there are any leaks in error situations.

> * Removed the XCode project and updated configure.ac and Makefile.am to properly
> build the changes.  I was well aware that this is what needed to be
done, I only
> included the XCode project in the first patch in the hopes that
someone with
> XCode and Automake knowledge would take a look at it and give me some
pointers.
> You were correct, though, it was not as bad as I thought it was going
to be.  The
> information you provided was very useful.

Good to hear!  Even though, autotools are tricky too - and it's easy to
step wrong too.  But in this case, it looks sensible what you have done!

> * Removed the dummy1() function from keychain.c.  Keychain.c/.h are based on
> cryptoapi.c/.h in the openvpn source tree.  When editing the original
> file to work with the Keychain services libraries instead of the
> Windows Crypto API, I decided to change as little as possible, the
> theory being that what was there was approved and accepted.  You will
> see a static dummy() function defined at the bottom of that file as
> well.  I had no idea what it was there for, but I figured there was a
> reason for it so I left it alone.  I think I tacked on the 1 to the
> end without thinking too hard because I was being very defensive and
> trying to prevent a scope problem, which was silly of me because the
> function is static and you would never compile Windows-only and
> Mac-only code at the same time.  If you grep for "dummy" in the
> source tree, you will see a number of places where this paradigm is
> used.  Perhaps because some compilers will not compile a file that
> has had all of its code ifdef'd out?  I tested this theory on my mac
> and no error occurred, so I went ahead and removed the function per
> your request.

Good!  Yeah, I saw Toby Thain's answer, which relates these dummy
functions to a (dare I say it?) silly Microsoft linker who gives
warnings about compiling "empty" files.  As this seems to be related to
Windows only, it makes sense to skip these dummy functions when not
absolutely needed - and this code is for OSX only.

Anyhow, we should give these places which needs these silly functions a
more decent comment with a reason why they are there.

> I should also point out that cryptoapi.c makes calls
> to calloc, which you may want to change at some point if you are
> trying to standardize on the gc_arena API.

Ahh, good catch!  I've not spent much time at all in the windows code at
all (I'm primarily working on Linux).  So this should be cleaned up.
I've added this to the "Open tasks" list for OpenVPN [1].


Thanks again for job well done!  As I said in the beginning, we're
getting closer to inclusion now.  I just need to get some confirmations
from some others in addition who will try out this patch on OSX.  What's
interesting in this next round now is to get confirmation that it
compiles cleanly and behaves as initially expected.  Then I'd like to
hear more about if any memory leaks have been found or not.

When they give a positive response on the compilation and usability,
I'll give you a feature branch in openvpn-testing.git.  And when we feel
pretty safe that no memory leaks are found, we can look at merging it
into the allmerged branch.  Does this sound reasonable to you?


kind regards,

David Sommerseth


[1] <https://community.openvpn.net/openvpn/wiki/OpenTasks>



> On Apr 28, 2010, at 2:53 AM, David Sommerseth wrote:
> 
> Hi Brian,
> 
> Thanks a lot for your patch!  This is indeed a neat feature we want to
> really consider for inclusion!  But there are of course a few things I
> spotted which I'd like to see being improved.
> 
> I am not familiar with OSX details at all, but I hope someone else with
> better OSX understanding can review those parts more thoroughly.  My
> comments will be of the more generic type.
> 
> * usage of printf()
> Please use the msg() function instead.  Don't print things to console
> directly via {f,}printf() directly.  There are plenty of places in the
> code where you can see msg() being used for a lot of logging.
> 
> * malloc()
> You use malloc() several places.  If possible try to make use of the
> gc_arena API instead.  This API is also used a lot of places in the
> code, so you'll most likely find some good examples there as well.
> 
> * static void dummy1() function
> In osx/keychain.c you define a rather silly function, which is not used
> anywhere.  Please take this one out.
> 
> * xcode files and migration to autotools
> Even though Xcode is probably a very good tool on OSX, it's not what we
> can base OpenVPN on.  I would like to see this migrated over to
> autotools.  It's not as hard and difficult as you might think
> immediately, but there are several traps on the way.  Some traps more
> visible than others.
> 
> First of all, it's a pretty good autotools tutorial [1] which is worth
> going through to understand the concept and how to get started.
> 
> Then you'll need to modify configure.ac and Makefile.am.  And that's
> basically it.  Have a look for SOCKS in configure.ac to get an idea.
> Further, you'll also need to add the source files of our osx/ C and H
> files to openvpn_SOURCES.  But! These files should probably be depending
> on if this OSX feature is enabled or not.  There's probably several ways
> how to solve this, and I'm not sure what's the best solution right now.
> But digging into automake docs[2] might be the proper place to start.
> 
> When you think you're done, ./configure works and it seems to compile
> flawlessly by running 'make', try runnning 'make distcheck' to be sure
> it will package itself properly, that the test compilation and test run
> works as expected as well.
> 
> 
> That's basically all I had to comment so far.  But thanks again for your
> patch!  Looking forward to hear from you again with further updates as well.
> 
> 
> kind regards,
> 
> David Sommerseth
> 
> 
> [1] <http://www.lrde.epita.fr/~adl/autotools.html>
> [2] <http://sources.redhat.com/automake/automake.html>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvcL4sACgkQDC186MBRfrrWKACgkNVMoso/8N7cyJYnErPhMOlp
XGMAn2AdyX9IQz3q1I7CKkr2trxny1iP
=6Mzr
-----END PGP SIGNATURE-----

