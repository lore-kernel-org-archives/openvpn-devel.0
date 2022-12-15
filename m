From: Arne Schwabe <arne@...1227...>
Date: Thu, 15 Dec 2022 20:01:35 +0100
Message-Id: <20221215190143.2107896-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/8] Improvement/fixes based on Trail of
 Bits audit
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This patch set addresses some issues found by Trail of Bits in an
audit of OpenVPN 2.x. This audit is currently not public but the
intention is to publish it.

The audit contained no vulnerability or problem that was deemed a
vulnerability that needed a CVE or coordinated release. Therefore,
this patch set is send to the public mailing list instead of going
through a closed review only on the security@...515... list that
we would have done otherwise.

This patch set also includes another security patch that is unrelated to
the audit (Make management password check constant time) that was reported
by Connor Edwards <cedw@...2705...>.


Arne Schwabe (7):
  Make management password check constant time
  Ensure that argument to parse_line has always space for final sentinel
  Improve documentation on user/password requirement and unicodize
    function
  Eliminate or comment empty blocks and switch fallthrough
  Remove unused gc_arena
  Fix corner case that might lead to leaked file descriptor
  Deprecate NTLMv1 proxy auth method.

David Sommerseth (1):
  ssl_verify: Fix memleak if creating deferred auth control files fails

 src/openvpn/comp-lz4.c    |  1 +
 src/openvpn/crypto.c      |  1 +
 src/openvpn/forward.c     |  3 --
 src/openvpn/init.c        |  1 +
 src/openvpn/lzo.c         |  1 +
 src/openvpn/manage.c      |  6 +++-
 src/openvpn/misc.c        |  1 +
 src/openvpn/misc.h        |  1 +
 src/openvpn/multi.c       |  2 --
 src/openvpn/ntlm.c        | 13 ++++++++
 src/openvpn/options.c     | 14 +++-----
 src/openvpn/proxy.c       |  2 ++
 src/openvpn/push.c        |  4 +--
 src/openvpn/ssl_openssl.c | 68 ++++++++++++++++++---------------------
 src/openvpn/ssl_verify.c  |  6 ++--
 15 files changed, 68 insertions(+), 56 deletions(-)

-- 
2.37.1 (Apple Git-137.1)


