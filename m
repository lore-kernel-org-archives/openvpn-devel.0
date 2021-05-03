From: Arne Schwabe <arne@...1227...>
Date: Mon,  3 May 2021 12:58:50 +0200
Message-Id: <20210503105850.3903732-1-arne@...1227...>
In-Reply-To: <20210503061454.GT976@...1296...>
References: <20210503061454.GT976@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Remove support for blocking connect()
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
Patch V3: remove another instance in socket.c that I misseds in v1

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/socket.c  | 13 -------------
 src/openvpn/syshead.h |  7 -------
 2 files changed, 20 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 23b12560b..407e411c0 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1451,7 +1451,6 @@ openvpn_connect(socket_descriptor_t sd,
     protect_fd_nonlocal(sd, remote);
 #endif
 
-#ifdef CONNECT_NONBLOCK
     set_nonblock(sd);
     status = connect(sd, remote, af_addr_size(remote->sa_family));
     if (status)
@@ -1532,13 +1531,6 @@ openvpn_connect(socket_descriptor_t sd,
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
@@ -1575,13 +1567,8 @@ socket_connect(socket_descriptor_t *sd,
     struct gc_arena gc = gc_new();
     int status;
 
-#ifdef CONNECT_NONBLOCK
-    msg(M_INFO, "Attempting to establish TCP connection with %s [nonblock]",
-        print_sockaddr(dest, &gc));
-#else
     msg(M_INFO, "Attempting to establish TCP connection with %s",
         print_sockaddr(dest, &gc));
-#endif
 
 #ifdef ENABLE_MANAGEMENT
     if (management)
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 321e20f5b..a9680f72f 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -535,13 +535,6 @@ socket_defined(const socket_descriptor_t sd)
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


