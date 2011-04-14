Message-ID: <4DA76B1D.7090309@...1114...>
Date: Thu, 14 Apr 2011 23:46:05 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <A6E7264D7DC743ADA5DB898E03F6B624@...139...>
In-Reply-To: <A6E7264D7DC743ADA5DB898E03F6B624@...139...>
Subject: Re: [Openvpn-devel] [Patch] config-win32.h (actually
	win/config-win32.h.in)
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
To: Gisle Vanem <gvanem@...139...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/04/11 14:56, Gisle Vanem wrote:
> Sorry for the noise. I just discovered you've switchd to Git since I was involved
> with OpenVPN. With the SVN-repo still there, I wrongfully assumed that was the
> trunk (latest top) of developement. Here is an updated patch:

Thanks a lot!  I've ACKed and committed your changes to the git tree now.
I've done a quick smoketest using mingw32 on Fedora 14, and it compiles and
generates a usable binary (just smoke tested it).

commit 6a8270c29120473570ec6da4003226f36a4b71eb
Author: Gisle Vanem <gvanem@...139...>
Date:   Sat Apr 9 12:56:52 2011 +0000

    Avoid re-defining uint32_t when using mingw compiler

    Since MingW for quite a long time (since 3.2 in 2008?) has defined
    'uint32_t' etc. in it's <stdint.h>, we need to guard against defining
    them again. Ideally we should figure out in what version of MingW
    this happened. But for now:

    Signed-off-by: Gisle Vanem <gvanem@...139...>
    Acked-by: David Sommerseth <dazo@...384...>
    Signed-off-by: David Sommerseth <dazo@...384...>


For the future, I would appreciate if you could commit your changes to your
local tree (git add <file(s)> ; git commit -s) and then use
git format-patch to generate the patch file(s).  The patch you sent was not
really well accepted by git, so I had to do these changes manually.

More information about our git process can be found here:
<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>
<https://community.openvpn.net/openvpn/wiki/GitCrashCourse>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2nax0ACgkQDC186MBRfrp7OgCeKaOuvWRcg+qCQF4eIjN/ZVUH
8ucAn30EufoV5yyxjQNJez+fpNXM/fxZ
=4R5V
-----END PGP SIGNATURE-----

