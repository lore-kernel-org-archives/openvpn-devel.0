Message-ID: <4F4B4962.2040704@...1114...>
Date: Mon, 27 Feb 2012 10:14:10 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
	<1329787361-26096-10-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-10-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 09/35] build: rename plugin directory to
 plugins
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
> This to avoid conflit with plugin.c rules
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- Makefile.am
> |    3 +- plugin/README                 |   47 --- 
> plugin/auth-pam/.svnignore    |    1 - plugin/auth-pam/Makefile      |
> 30 -- plugin/auth-pam/README        |   74 ---- 
> plugin/auth-pam/auth-pam.c    |  804
> ----------------------------------------- plugin/auth-pam/pamdl.c
> |  180 --------- plugin/auth-pam/pamdl.h       |    7 - 
> plugin/defer/README           |   16 - plugin/defer/build            |
> 14 - plugin/defer/simple.c         |  305 ---------------- 
> plugin/defer/simple.def       |    6 - plugin/defer/winbuild         |
> 18 - plugin/down-root/Makefile     |   17 - plugin/down-root/README
> |   29 -- plugin/down-root/down-root.c  |  553
> ---------------------------- plugin/examples/README        |   16 - 
> plugin/examples/build         |   14 - plugin/examples/log.c         |
> 184 ---------- plugin/examples/log_v3.c      |  249 ------------- 
> plugin/examples/simple.c      |  120 ------ plugin/examples/simple.def
> |    6 - plugin/examples/winbuild      |   18 - plugins/README
> |   47 +++ plugins/auth-pam/.svnignore   |    1 + 
> plugins/auth-pam/Makefile     |   30 ++ plugins/auth-pam/README
> |   74 ++++ plugins/auth-pam/auth-pam.c   |  804
> +++++++++++++++++++++++++++++++++++++++++ plugins/auth-pam/pamdl.c
> |  180 +++++++++ plugins/auth-pam/pamdl.h      |    7 + 
> plugins/defer/README          |   16 + plugins/defer/build           |
> 14 + plugins/defer/simple.c        |  305 ++++++++++++++++ 
> plugins/defer/simple.def      |    6 + plugins/defer/winbuild        |
> 18 + plugins/down-root/Makefile    |   17 + plugins/down-root/README
> |   29 ++ plugins/down-root/down-root.c |  553
> ++++++++++++++++++++++++++++ plugins/examples/README       |   16 + 
> plugins/examples/build        |   14 + plugins/examples/log.c        |
> 184 ++++++++++ plugins/examples/log_v3.c     |  249 +++++++++++++ 
> plugins/examples/simple.c     |  120 ++++++ 
> plugins/examples/simple.def   |    6 + plugins/examples/winbuild     |
> 18 + 45 files changed, 2709 insertions(+), 2710 deletions(-) delete
> mode 100644 plugin/README delete mode 100644
> plugin/auth-pam/.svnignore delete mode 100755
> plugin/auth-pam/Makefile delete mode 100644 plugin/auth-pam/README 
> delete mode 100644 plugin/auth-pam/auth-pam.c delete mode 100644
> plugin/auth-pam/pamdl.c delete mode 100644 plugin/auth-pam/pamdl.h 
> delete mode 100644 plugin/defer/README delete mode 100755
> plugin/defer/build delete mode 100644 plugin/defer/simple.c delete
> mode 100755 plugin/defer/simple.def delete mode 100755
> plugin/defer/winbuild delete mode 100755 plugin/down-root/Makefile 
> delete mode 100644 plugin/down-root/README delete mode 100644
> plugin/down-root/down-root.c delete mode 100644
> plugin/examples/README delete mode 100755 plugin/examples/build delete
> mode 100644 plugin/examples/log.c delete mode 100644
> plugin/examples/log_v3.c delete mode 100644 plugin/examples/simple.c 
> delete mode 100755 plugin/examples/simple.def delete mode 100755
> plugin/examples/winbuild create mode 100644 plugins/README create mode
> 100644 plugins/auth-pam/.svnignore create mode 100755
> plugins/auth-pam/Makefile create mode 100644 plugins/auth-pam/README 
> create mode 100644 plugins/auth-pam/auth-pam.c create mode 100644
> plugins/auth-pam/pamdl.c create mode 100644 plugins/auth-pam/pamdl.h 
> create mode 100644 plugins/defer/README create mode 100755
> plugins/defer/build create mode 100644 plugins/defer/simple.c create
> mode 100755 plugins/defer/simple.def create mode 100755
> plugins/defer/winbuild create mode 100755 plugins/down-root/Makefile 
> create mode 100644 plugins/down-root/README create mode 100644
> plugins/down-root/down-root.c create mode 100644
> plugins/examples/README create mode 100755 plugins/examples/build 
> create mode 100644 plugins/examples/log.c create mode 100644
> plugins/examples/log_v3.c create mode 100644
> plugins/examples/simple.c create mode 100755
> plugins/examples/simple.def create mode 100755
> plugins/examples/winbuild


ACK.  I've not checked that files are not modified, but will check that
more carefully when it is pulled into the tree.


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9LSWIACgkQDC186MBRfrofjACcDmONwrtbSxSR1kAqGA2QHVjn
6IQAni6jfx/gPtGsv1ousJKaj84XAICP
=NvNR
-----END PGP SIGNATURE-----

