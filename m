Message-ID: <4F42CB9E.8060207@...1114...>
Date: Mon, 20 Feb 2012 23:39:26 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz08kLGKyq-Wcd1KTQ9akdQCAYPP9b1aMVne-b9TArMKDQ@...278...>
	<1329749121-24501-1-git-send-email-alon.barlev@...277...>
	<4F426F81.6040201@...1114...>
	<CAOazyz1DhzxPf3GS1dqhYKXSkL5NeSDy03z340VYibKWBKxPRQ@...278...>
In-Reply-To: <CAOazyz1DhzxPf3GS1dqhYKXSkL5NeSDy03z340VYibKWBKxPRQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] windows: do not use X_OK as it is
	unsupported
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 20/02/12 20:35, Alon Bar-Lev wrote:
> David,
> 
> Again, This has nothing to do with POSIX. mingw *DOES* define this
> constant in *WINDOWS*.

You seem to ignore the fact that mingw provides an access() function
which *behaves* like the rest of the POSIX world.  MSVS does not do that,
but decides to choke when its own "support variant", which is even
renamed to to _access(), is used with a value which is defined in POSIX
[1].  This has everything to do with POSIX compliance.  If MSVS had been
compliant, we would not have had this discussion.

[1] <http://pubs.opengroup.org/onlinepubs/9699919799/>

And you may try to compile this little snippet in different environments.
- ----8<-------------------------------------------------------------------

#include <stdio.h>
#include <unistd.h>

#ifndef F_OK
#define F_OK 0
#endif

int main(int argc, char **argv)
{
	if( argc != 2 ) {
		fprintf(stderr, "Usage: %s <file>\n", argv[0]);
		return 1;
	}

	if( access(argv[1], F_OK) == 0 ) {
		printf("%s exists\n", argv[1]);
	} else {
		printf("Failure when checking %s\n", argv[1]);
		perror("access");
		return 2;
	}
	return 0;
}
- ----8<-------------------------------------------------------------------

Compile this in mingw, and it works as expected.  Compile this with MSVS,
and it will complain about using deprecated functions, and using
_access() instead will make it happier.  However, it will most like like
not behave as expected.  And for the extra fun of it, you can always try
to use _waccess() instead too.  That will definitely not behave as expected.

> We do not want to have a different constants (and different values)
> at the MSVC and mingw build.

I beg to differ.  The MSVS and mingw compiler environments are two very
different compiler environments - as desc.  And as I said, mingw is
somewhere in between a POSIX compliant compiler environment and MSVS.  It
is not a clearly drawn line between what is supported and not in mingw
unfortunately, and a lot of things around the mingw compiler environment
is debatable.  However, in the case of access() and the [RWXF]_OK macros,
mingw is far closer to the POSIX standard than MSVS.  From the mingw web
site:

   "Unlike Cygwin, MinGW doesn't provide Linux or Unix system calls or a
    POSIX emulation layer. *Some POSIX compatibility* is provided by the
    supported runtime library, msvcrt.dll. A few additional functions are
    provided to help with portability"
    <http://mingw.org/wiki/MinGW>

> Build should be consistent when possible, but not override environment
> SDK.

There *is no override* of the SDK environment.  Because the [RWXF]_OK
macros *does not exist* in the MSVS.  Further, mingw *does* define these
macros in the mingw header files (try to remove the #ifdef block in the
example above).  So we just define a *missing* macro with a sane value
which doesn't make the openvpn binary built with MSVS choke and die due
to an invalid value.  Which is *why* I mean the proper place for this
definition is in win/config.h.in, which is *only* used by the python
build environment written *explicitly* for the MSVS build environment.

> Anyway, If this will not enter here it will enter my rewrite... I 
> thought it is better to do this sooner than later.
> 
> The definition of PLATFORM_X_OK will be moved to autoconf.

You may attempt to try to force them in.  That is purely your choice, Alon.

But remember that all your patches *will* go through review as for
everyone else in the community.  That means either *1)* patch reviews on
the mailing list, or *2)* reviewed through a sprint review in a
developers meeting on the IRC.  You are free to choose between which
approach fits you best.  But I will not accept patches into the tree
unless it has been clearly ACKed publicly.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9Cy5wACgkQDC186MBRfrprOgCfeAOtyy5Ln+34dgOxPAt9y44D
2OIAnR2/pTxvkEOOK/yaYvwLEfQdDCYo
=/iMB
-----END PGP SIGNATURE-----

