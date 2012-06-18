From: Arne Schwabe <arne@...1227...>
Date: Mon, 18 Jun 2012 20:39:03 +0200
Message-Id: <1340044749-10694-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 0/6] misc cleanup patches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

A few clean up patches that I have local. Some of these might be useful in a 2.3 release.

Arne Schwabe (6):
  Only use tmpdir if tmp_dir is really used.
  Completely remove ancient IANA port warning.
  Remove ENABLE_INLINE_FILES conditionals, this code is always enabled
    and removing the #ifdef make the code a little bit clearer
  Remove ENABLE_CONNECTIONS ifdefs, connections were always on for a
    long time.     Not that ENABLE_MAMAGEMENT_REMOTE was only depending
    on ENABLE_CONNECTIONS and is removed as well
  Fix most of the clang warnings, mostly unused variables and
    comparisons which were always true
  Fix clang warnings for conversion from unsigned<->signed

 src/openvpn/common.h             |    2 -
 src/openvpn/crypto.c             |    8 -----
 src/openvpn/httpdigest.c         |   44 ++++++++++++++--------------
 src/openvpn/init.c               |   22 --------------
 src/openvpn/manage.c             |    8 -----
 src/openvpn/manage.h             |    6 ----
 src/openvpn/misc.c               |    6 ----
 src/openvpn/mroute.c             |   28 +++++++----------
 src/openvpn/multi.c              |    7 +----
 src/openvpn/ntlm.c               |    8 ++--
 src/openvpn/options.c            |   60 +++----------------------------------
 src/openvpn/options.h            |   30 ++-----------------
 src/openvpn/route.c              |    1 -
 src/openvpn/ssl.c                |    4 --
 src/openvpn/ssl_backend.h        |   36 ++++++----------------
 src/openvpn/ssl_openssl.c        |   40 ++++---------------------
 src/openvpn/ssl_polarssl.c       |   34 ++++-----------------
 src/openvpn/ssl_verify_openssl.c |    2 +-
 src/openvpn/syshead.h            |   24 +--------------
 19 files changed, 72 insertions(+), 298 deletions(-)

-- 
1.7.7.5 (Apple Git-26)


