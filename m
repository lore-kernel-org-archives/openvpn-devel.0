Message-ID: <4CE05EB5.6090809@...1114...>
Date: Sun, 14 Nov 2010 23:12:05 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1283027520-26460-1-git-send-email-dazo@...384...>
In-Reply-To: <1283027520-26460-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH 0/3] Code clean-up - removing "dead"
	code.
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/08/10 22:31, David Sommerseth wrote:
> This is a patch series which tries to do some source code clean-up.
> After having noticed that ./configure --enable-pthread was simply doing
> *nothing*, as it was forcefully being disabled in syshead.h, I went through
> the code and began cleaning up this and some of the related code.
> 
> As threading is not buildable in the current code base and OpenVPN 3.x most
> likely will have a brand new design in regards to the threading, it seemed to
> be better to clean up this code.  This is also to remove false presumptions
> that OpenVPN supports threads.
> 
> 
> kind regards,
> 
> David Sommerseth
> 
> *** BLURB HERE ***
> 
> David Sommerseth (3):
>   Clean-up: Remove pthread and mutex locking code
>   Clean-up: Remove more dead and inactive code paths
>   Clean-up: Removing useless code - hash related functions
> 
>  Makefile.am    |    1 -
>  acinclude.m4   |  224 -----------------------------------------------------
>  buffer.c       |    5 -
>  buffer.h       |    1 -
>  config-win32.h |    5 -
>  configure.ac   |   38 +---------
>  crypto.c       |    3 -
>  error.c        |   39 ---------
>  error.h        |   17 ----
>  forward.c      |   10 ---
>  init.c         |   50 ------------
>  list.c         |   24 +-----
>  list.h         |   33 +-------
>  mbuf.c         |   16 +----
>  mbuf.h         |    3 +-
>  misc.c         |   23 ------
>  mroute.c       |    6 --
>  mroute.h       |   13 ---
>  mtcp.c         |    5 +-
>  mudp.c         |    3 -
>  multi.c        |   32 +++-----
>  multi.h        |    2 -
>  openvpn.h      |    3 -
>  options.c      |   36 ---------
>  options.h      |    5 -
>  otime.c        |    2 -
>  otime.h        |    1 -
>  perf.c         |    4 -
>  pf.c           |    2 +-
>  plugin.c       |    4 -
>  pool.h         |    1 -
>  schedule.c     |    4 -
>  schedule.h     |    8 --
>  socket.c       |    7 --
>  ssl.c          |    5 -
>  ssl.h          |    4 -
>  syshead.h      |   18 ----
>  thread.c       |  156 -------------------------------------
>  thread.h       |  235 --------------------------------------------------------
>  39 files changed, 26 insertions(+), 1022 deletions(-)
>  delete mode 100644 thread.c
>  delete mode 100644 thread.h


Seems like this patch set was never really added to the tree.  It
received an ACK in the weekly IRC meeting Sept. 2, 2010.  Applied to
feat_misc, to be merged into allmerged and beta2.2.

commit 6af422162fbc1c505526157ecf630e37694dbc7b
Author: David Sommerseth <dazo@...384...>
Date:   Sat Aug 28 20:52:19 2010 +0200

    Clean-up: Removing useless code - hash related functions

    Removed even more function which where practically empty and took
    away some function arguments which were not used.

    Signed-off-by: David Sommerseth <dazo@...384...>
    Acked-by: James Yonan <james@...515...>

commit cc88a2695f4a54e27143efeae62de24fec8e26a1
Author: David Sommerseth <dazo@...384...>
Date:   Sat Aug 28 20:44:07 2010 +0200

    Clean-up: Remove more dead and inactive code paths

    These code paths was practically not needed with no locking
    mechanisms enabled and was just bloating the source code.

    Signed-off-by: David Sommerseth <dazo@...384...>
    Acked-by: James Yonan <james@...515...>

commit 7aa6c12a4424d00ea0add0a849f8a5b31a2de6a1
Author: David Sommerseth <dazo@...384...>
Date:   Sat Aug 28 20:14:36 2010 +0200

    Clean-up: Remove pthread and mutex locking code

    This code was not activated at all, and hard coded as disabled in
    syshead.h with this code snippet:

       /*
        * Pthread support is currently experimental (and quite
        * unfinished).
        */
       #if 1 /* JYFIXME -- if defined, disable pthread */
       #undef USE_PTHREAD
       #endif

    So no matter if --enable-pthread when running ./configure or not,
    this feature was never enabled in reality.  Further, by removing
    the blocker code above made OpenVPN uncompilable in the current
    state.

    As the threading part needs to be completely rewritten and
    pthreading will not be supported in OpenVPN 2.x, removing this code
    seems most reasonable.

    In addition, a lot of mutex locking code was also removed, as they
    were practically NOP functions, due to pthreading being forcefully
    disabled

    Signed-off-by: David Sommerseth <dazo@...384...>
    Acked-by: James Yonan <james@...515...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzgXrUACgkQDC186MBRfrrPhwCeIEuhScmqsTjL2+bnyhTkbO3i
8DcAn3THx0jIiYt7dDv/e4+HFopMae71
=+VXi
-----END PGP SIGNATURE-----

