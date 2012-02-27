Message-ID: <4F4B4660.5020108@...1114...>
Date: Mon, 27 Feb 2012 10:01:20 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
	<1329787361-26096-8-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-8-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 07/35] build: tests do not work disable
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/02/12 02:22, Alon Bar-Lev wrote:
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- Makefile.am |
> 5 +++-- 1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am index 26b80f3..f96eb45 100644 
> --- a/Makefile.am +++ b/Makefile.am @@ -57,16 +57,17 @@ SUBDIRS = \ 
> service-win32 \ install-win32
> 
> -TESTS = t_client.sh t_lpback.sh t_cltsrv.sh +test_scripts =
> t_client.sh t_lpback.sh t_cltsrv.sh +#TESTS = $(test_scripts) 
> sbin_PROGRAMS = openvpn
> 
> dist_doc_DATA = \ management/management-notes.txt
> 
> dist_noinst_SCRIPTS = \ -	$(TESTS) \ doclean \ domake-win \ +
> $(test_scripts) \ t_cltsrv-down.sh \ configure_h.awk
> configure_log.awk
> 

Which of these tests are not working?  And how do they fail?

I'm running 'make check' before pushing a new git tree, and it passes
fine for me.  The only "exception" is t_client.sh (generated via
t_client.sh.in) which depends on a configuration file (t_client.rc) -
otherwise it is just skipped.  This test is however run in our buildbot
farm, AFAIR.  Gert also runs this test in his development repos.  So it's
rather odd to hear that these tests fail.


kind regards,

David Sommerseth



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9LRl4ACgkQDC186MBRfrrWcQCgklcEZ8ATjLQqsQ9mxOFLbMjM
2FAAoI2cJAVd7GVdv9hO7TvkSSVCAPmK
=xG/s
-----END PGP SIGNATURE-----

