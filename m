From: Arne Schwabe <arne@...1227...>
Date: Thu, 22 Apr 2021 17:29:37 +0200
Message-Id: <20210422152939.2134046-4-arne@...1227...>
In-Reply-To: <20210422152939.2134046-1-arne@...1227...>
References: <20210422152939.2134046-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 4/6] Remove support for blocking connect()
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

Patch V2: remove epoll.h removal that should have been in other patch.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/socket.c  | 8 --------
 src/openvpn/syshead.h | 7 -------
 2 files changed, 15 deletions(-)

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
index f29c63c73..3f2e563b7 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -545,13 +545,6 @@ socket_defined(const socket_descriptor_t sd)
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


