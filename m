Message-ID: <4D2656EF.8090908@...1114...>
Date: Fri, 07 Jan 2011 00:57:35 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1294334039-28892-1-git-send-email-matthias.andree@...68...>
	<4D263917.80908@...1114...> <4D2647FB.4070302@...68...>
In-Reply-To: <4D2647FB.4070302@...68...>
Subject: Re: [Openvpn-devel] beta2.2: automake support for plugin build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Matthias Andree <matthias.andree@...68...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/01/11 23:53, Matthias Andree wrote:
| Am 06.01.2011 22:50, schrieb David Sommerseth:
|> On 06/01/11 18:13, Matthias Andree wrote:
|> | Greetings,
|> |
|> | this is the beta2.2 patch pair for hooking the auth-pam and down-root
|> | plugins to the build.
|> |
|> | The bugfix2.1 patch pair has been sent earlier.
|> |
|> | Looking for review, ACK and NAK.
|> |
|>
|> Hi Matthias,
|>
|> And thanks a lot for your patches.  Just one question.  I see you try to do
|> all the Makefile generation in the main/root Makefile.am.  That is for sure a
|> fast-track to get started.  But I'm concerned if that might backfire in the
|> long run.
|
| Yes, but in my experience with autotools, the fewer SUBDIRS you have the better
| it works, the faster and more reliably everything builds.  SUBDIRS should only
| be used as a last resort.
|
|> Why not to use the SUBDIRS variable in the root Makefile.am, and then have
|> separate Makefile.am per plugin?  That way, each plug-in can more easily
|> control the build independently.
|
| SUBDIRS is one of the worst ideas I've seen in autotools, and I try to avoid
| that wherever reasonable.  SUBDIRS breaks dependencies because you run multiple
| "make" processes that all only have a partial view. It is inefficient, leads to
| autotools bloat, and other reasons are given in "Recursive make considered
| harmful" by Peter Miller of "cook" fame (URL below).  Old as it may seem its
| points still stand.
|
| Automake allows for per-target build control through _LDADD, _DEPENDENCIES and
| all sorts of options, and if that fails you can still hand-code the build rules,
| automake passes them through.
|
| http://miller.emu.id.au/pmiller/books/rmch/

Thanks for that link, that was a good and enlightening read, and one of the
better arguments I've heard in a long long time.  I can agree to a lot of the
issues here (I have even experienced many of these issues in other projects).
~ However the examples he brings up are not directly comparable to the OpenVPN
build process.

* OpenVPN is mainly single directory/single Makefile oriented, considering the
build process.  Even though, we have been discussing about to separate the
bits and pieces a little bit into separate directories, to make the source
tree more readable.  If we slice it up a bit, that still does not mean that we
can't use a single Makefile approach for building OpenVPN executable itself.

* The OpenVPN plug-ins are to be considered third-party plug-ins, even though
some plug-ins are shipped with the source tree.  However, the *only* thing
they depend on is openvpn-plugin.h in the root directory.  Nothing more and it
will not be anything else they should need to compile in, even in the future.
~ The plug-in system is a pure API, which is all defined in that header file
(it's kind of what /usr/include/stdio.h is to glibc).  If this header file is
modified, it is irrelevant if OpenVPN is rebuilt or the plug-ins are rebuilt
first.


So when taking into account this and what is mentioned in the summary on
page 13:

~    "Because make can only operate correctly with a complete DAG, the error
~     is in segmenting the Makefile into incomplete pieces."

I would say that this should not be a problem for OpenVPN.  The core OpenVPN
executable and the plug-ins are really segmented into individual and complete
pieces.

Yes, Make does not tackle all kind of Makefile setups well, and especially
when sliced into incomplete pieces which depends on each other.  This is not
the case for OpenVPN (at least 2.x)

Therefore I am still of the opinion that SUBDIRS are not that bad or risky for
OpenVPN as in other more "sliced up" projects.  But it is important to beware
of this pitfall.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0mVu8ACgkQDC186MBRfromWACgr1mgkUR+GZ4UgohM9linIgm0
2RcAmgL25F+s9B4tstihWsaYt3bjaiqe
=F5Qq
-----END PGP SIGNATURE-----

