Message-ID: <4FE98517.90200@...1114...>
Date: Tue, 26 Jun 2012 11:47:03 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1337035323-27465-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1337035323-27465-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: integrate plugins build into
	core build
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 15/05/12 00:42, Alon Bar-Lev wrote:
> As disucssed[1], keep plugins in repository.
> 
> 1, Proper automake/libtool build.
> 
> 2. Move example plugins to samples/sample-plugins.
> 
> 3. Plugins are installed at LIBDIR/openvpn/plugins.
> 
> [1] http://comments.gmane.org/gmane.network.openvpn.devel/6436
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- 
> configure.ac                            |   63 +++++++ 
> distro/rpm/openvpn.spec.in              |   47 +----- 
> doc/Makefile.am                         |    5 +- 
> doc/README.plugins                      |   47 +++++ 
> sample/Makefile.am                      |    1 + 
> sample/sample-plugins/defer/README      |   16 ++ 
> sample/sample-plugins/defer/build       |   15 ++ 
> sample/sample-plugins/defer/simple.c    |  305
> +++++++++++++++++++++++++++++++ 
> sample/sample-plugins/defer/simple.def  |    6 + 
> sample/sample-plugins/defer/winbuild    |   18 ++ 
> sample/sample-plugins/log/build         |   15 ++ 
> sample/sample-plugins/log/log.c         |  184 +++++++++++++++++++ 
> sample/sample-plugins/log/log_v3.c      |  247
> +++++++++++++++++++++++++ sample/sample-plugins/log/winbuild      |
> 18 ++ sample/sample-plugins/simple/README     |   16 ++ 
> sample/sample-plugins/simple/build      |   15 ++ 
> sample/sample-plugins/simple/simple.c   |  120 ++++++++++++ 
> sample/sample-plugins/simple/simple.def |    6 + 
> sample/sample-plugins/simple/winbuild   |   18 ++ src/Makefile.am
> |    5 +- src/plugins/Makefile.am                 |   15 ++ 
> src/plugins/README                      |   47 ----- 
> src/plugins/auth-pam/Makefile           |   32 ---- 
> src/plugins/auth-pam/Makefile.am        |   27 +++ 
> src/plugins/auth-pam/README             |   74 -------- 
> src/plugins/auth-pam/README.auth-pam    |   74 ++++++++ 
> src/plugins/auth-pam/auth-pam.c         |   18 +- 
> src/plugins/auth-pam/auth-pam.exports   |    4 + 
> src/plugins/auth-pam/pamdl.c            |    8 +- 
> src/plugins/auth-pam/pamdl.h            |    4 +- 
> src/plugins/defer/README                |   16 -- 
> src/plugins/defer/build                 |   15 -- 
> src/plugins/defer/simple.c              |  305
> ------------------------------- src/plugins/defer/simple.def
> |    6 - src/plugins/defer/winbuild              |   18 -- 
> src/plugins/down-root/Makefile          |   18 -- 
> src/plugins/down-root/Makefile.am       |   23 +++ 
> src/plugins/down-root/README            |   29 --- 
> src/plugins/down-root/README.down-root  |   29 +++ 
> src/plugins/down-root/down-root.c       |    6 +- 
> src/plugins/down-root/down-root.exports |    4 + 
> src/plugins/examples/README             |   16 -- 
> src/plugins/examples/build              |   15 -- 
> src/plugins/examples/log.c              |  184 ------------------- 
> src/plugins/examples/log_v3.c           |  247
> ------------------------- src/plugins/examples/simple.c           |
> 120 ------------ src/plugins/examples/simple.def         |    6 - 
> src/plugins/examples/winbuild           |   18 -- 48 files changed,
> 1317 insertions(+), 1228 deletions(-) create mode 100644
> doc/README.plugins create mode 100644
> sample/sample-plugins/defer/README create mode 100755
> sample/sample-plugins/defer/build create mode 100644
> sample/sample-plugins/defer/simple.c create mode 100755
> sample/sample-plugins/defer/simple.def create mode 100755
> sample/sample-plugins/defer/winbuild create mode 100755
> sample/sample-plugins/log/build create mode 100644
> sample/sample-plugins/log/log.c create mode 100644
> sample/sample-plugins/log/log_v3.c create mode 100755
> sample/sample-plugins/log/winbuild create mode 100644
> sample/sample-plugins/simple/README create mode 100755
> sample/sample-plugins/simple/build create mode 100644
> sample/sample-plugins/simple/simple.c create mode 100755
> sample/sample-plugins/simple/simple.def create mode 100755
> sample/sample-plugins/simple/winbuild create mode 100644
> src/plugins/Makefile.am delete mode 100644 src/plugins/README 
> delete mode 100755 src/plugins/auth-pam/Makefile create mode 100644
> src/plugins/auth-pam/Makefile.am delete mode 100644
> src/plugins/auth-pam/README create mode 100644
> src/plugins/auth-pam/README.auth-pam create mode 100644
> src/plugins/auth-pam/auth-pam.exports delete mode 100644
> src/plugins/defer/README delete mode 100755
> src/plugins/defer/build delete mode 100644
> src/plugins/defer/simple.c delete mode 100755
> src/plugins/defer/simple.def delete mode 100755
> src/plugins/defer/winbuild delete mode 100755
> src/plugins/down-root/Makefile create mode 100644
> src/plugins/down-root/Makefile.am delete mode 100644
> src/plugins/down-root/README create mode 100644
> src/plugins/down-root/README.down-root create mode 100644
> src/plugins/down-root/down-root.exports delete mode 100644
> src/plugins/examples/README delete mode 100755
> src/plugins/examples/build delete mode 100644
> src/plugins/examples/log.c delete mode 100644
> src/plugins/examples/log_v3.c delete mode 100644
> src/plugins/examples/simple.c delete mode 100755
> src/plugins/examples/simple.def delete mode 100755
> src/plugins/examples/winbuild

I'm sorry about this one, it fell of my radar when all my tags got
reset in my mail client.  Anyhow!

ACK.  Applied to master.

commit ce8271f5d435be963c79945f8d7eb6ea2e4369fa
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Tue May 15 01:42:03 2012 +0300

    build: integrate plugins build into core build

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1337035323-27465-1-git-send-email-alon.barlev@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6591
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/phRQACgkQDC186MBRfrpJgQCglB3RE2z83zmXOWlYIKtOcEm3
H9IAniuDMQ7g8mk4xwdqY2uJ7uz0d5kz
=mPIo
-----END PGP SIGNATURE-----

