Message-ID: <4BD7DB78.2010704@...1114...>
Date: Wed, 28 Apr 2010 08:53:44 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <B23F897A-5ADC-4A29-A34B-3BB16C18B4F3@...1360...>
In-Reply-To: <B23F897A-5ADC-4A29-A34B-3BB16C18B4F3@...1360...>
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

On 28/04/10 07:17, Brian Raderman wrote:
> Hello,
> 
> This patch adds support for using certificates stored in the Mac OSX Keychain
> to authenticate with the OpenVPN server.  This works with certificates
stored
> on the computer as well as certificates on hardware tokens that
support Apple's
> tokend interface.  It has been tested with an Aladdin eToken on
> Mac OSX Leopard and with software only certificates on
> Mac OSX Leopard and Snow Leopard.  Aladdin has not yet released
> drivers for Snow Leopard.  The patch is very similar to, and also
> based on, the Windows Crypto API certificate functionality that
> currently exists in OpenVPN.

> I did not know how to adjust the automake/autoconf configuration
> files, so I have included the XCode project I used to build and test
> openvpn in this patch.  All new files were added in an "osx" subdirectory.
> 
> Please let me know if you have any questions or if there are any changes
> (I suspect there will be many) that I need to complete before this patch
> can be accepted.
> 

Hi Brian,

Thanks a lot for your patch!  This is indeed a neat feature we want to
really consider for inclusion!  But there are of course a few things I
spotted which I'd like to see being improved.

I am not familiar with OSX details at all, but I hope someone else with
better OSX understanding can review those parts more thoroughly.  My
comments will be of the more generic type.

* usage of printf()
Please use the msg() function instead.  Don't print things to console
directly via {f,}printf() directly.  There are plenty of places in the
code where you can see msg() being used for a lot of logging.

* malloc()
You use malloc() several places.  If possible try to make use of the
gc_arena API instead.  This API is also used a lot of places in the
code, so you'll most likely find some good examples there as well.

* static void dummy1() function
In osx/keychain.c you define a rather silly function, which is not used
anywhere.  Please take this one out.

* xcode files and migration to autotools
Even though Xcode is probably a very good tool on OSX, it's not what we
can base OpenVPN on.  I would like to see this migrated over to
autotools.  It's not as hard and difficult as you might think
immediately, but there are several traps on the way.  Some traps more
visible than others.

First of all, it's a pretty good autotools tutorial [1] which is worth
going through to understand the concept and how to get started.

Then you'll need to modify configure.ac and Makefile.am.  And that's
basically it.  Have a look for SOCKS in configure.ac to get an idea.
Further, you'll also need to add the source files of our osx/ C and H
files to openvpn_SOURCES.  But! These files should probably be depending
on if this OSX feature is enabled or not.  There's probably several ways
how to solve this, and I'm not sure what's the best solution right now.
 But digging into automake docs[2] might be the proper place to start.

When you think you're done, ./configure works and it seems to compile
flawlessly by running 'make', try runnning 'make distcheck' to be sure
it will package itself properly, that the test compilation and test run
works as expected as well.


That's basically all I had to comment so far.  But thanks again for your
patch!  Looking forward to hear from you again with further updates as well.


kind regards,

David Sommerseth


[1] <http://www.lrde.epita.fr/~adl/autotools.html>
[2] <http://sources.redhat.com/automake/automake.html>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvX23gACgkQDC186MBRfroWXgCfeZUA1pFrSsu55MMk3gg9TIcJ
M0EAoKO/OYi2v5YMNDankep5vqMEX7hC
=sXAB
-----END PGP SIGNATURE-----

