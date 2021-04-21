From: Arne Schwabe <arne@...1227...>
Date: Wed, 21 Apr 2021 15:43:46 +0200
Message-Id: <20210421134348.1950392-5-arne@...1227...>
In-Reply-To: <20210421134348.1950392-1-arne@...1227...>
References: <20210421134348.1950392-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/7] Remove support for blocking connect()
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

It is hard to imagine that we still have any supported OS that does
not support non-blocking connect while still supporting non-blocking
sockets in general.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/socket.c  |  8 --------
 src/openvpn/syshead.h | 11 -----------
 2 files changed, 19 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8a6e42cc6..4e13c65e8 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1459,7 +1459,6 @@ openvpn_connect(socket_descriptor_t sd,
     protect_fd_nonlocal(sd, remote);
 #endif
 
-#ifdef CONNECT_NONBLOCK
     set_nonblock(sd);
     status = connect(sd, remote, af_addr_size(remote->sa_family));
     if (status)
@@ -1540,13 +1539,6 @@ openvpn_connect(socket_descriptor_t sd,
             }
         }
     }
-#else  /* ifdef CONNECT_NONBLOCK */
-    status = connect(sd, remote, af_addr_size(remote->sa_family));
-    if (status)
-    {
-        status = openvpn_errno();
-    }
-#endif /* ifdef CONNECT_NONBLOCK */
 
     return status;
 }
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index f29c63c73..a964ffd35 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -155,10 +155,6 @@
 #include <poll.h>
 #endif
 
-#ifdef HAVE_SYS_EPOLL_H
-#include <sys/epoll.h>
-#endif
-
 #ifdef ENABLE_SELINUX
 #include <selinux/selinux.h>
 #endif
@@ -545,13 +541,6 @@ socket_defined(const socket_descriptor_t sd)
 #define EPOLL 0
 #endif
 
-/*
- * Is non-blocking connect() supported?
- */
-#if defined(SOL_SOCKET) && defined(SO_ERROR) && defined(EINPROGRESS) && defined(ETIMEDOUT)
-#define CONNECT_NONBLOCK
-#endif
-
 /*
  * Compression support
  */
-- 
2.31.1


