From: Arne Schwabe <arne@...1227...>
Date: Fri, 26 Apr 2013 21:54:04 +0200
Message-Id: <1367006045-13576-2-git-send-email-arne@...1227...>
In-Reply-To: <1367006045-13576-1-git-send-email-arne@...1227...>
References: <1367006045-13576-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [[Patch v3] 2/3] add ability to send/receive file
	descriptors via management interface,
	only used in android so. For now under #ifdef ANDROID
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

---
 src/openvpn/manage.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/manage.h |    4 +++
 2 files changed, 91 insertions(+)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0a4542a..80c469e 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1779,6 +1779,78 @@ man_io_error (struct management *man, const char *prefix)
     return false;
 }
 
+#ifdef TARGET_ANDROID
+static ssize_t man_send_with_fd (int fd, void *ptr, size_t nbytes, int flags, int sendfd)
+{
+  struct msghdr msg;
+  struct iovec iov[1];
+    
+  union {
+    struct cmsghdr cm;
+    char    control[CMSG_SPACE(sizeof(int))];
+  } control_un;
+  struct cmsghdr *cmptr;
+    
+  msg.msg_control = control_un.control;
+  msg.msg_controllen = sizeof(control_un.control);
+    
+  cmptr = CMSG_FIRSTHDR(&msg);
+  cmptr->cmsg_len = CMSG_LEN(sizeof(int));
+  cmptr->cmsg_level = SOL_SOCKET;
+  cmptr->cmsg_type = SCM_RIGHTS;
+  *((int *) CMSG_DATA(cmptr)) = sendfd;
+    
+  msg.msg_name = NULL;
+  msg.msg_namelen = 0;
+    
+  iov[0].iov_base = ptr;
+  iov[0].iov_len = nbytes;
+  msg.msg_iov = iov;
+  msg.msg_iovlen = 1;
+    
+  return (sendmsg(fd, &msg, flags));
+}
+
+static ssize_t man_recv_with_fd (int fd, void *ptr, size_t nbytes, int flags, int *recvfd)
+{
+  struct msghdr msghdr;
+  struct iovec iov[1];
+  ssize_t n;
+    
+  union {
+    struct cmsghdr cm;
+    char     control[CMSG_SPACE(sizeof (int))];
+  } control_un;
+  struct cmsghdr  *cmptr;
+    
+  msghdr.msg_control  = control_un.control;
+  msghdr.msg_controllen = sizeof(control_un.control);
+    
+  msghdr.msg_name = NULL;
+  msghdr.msg_namelen = 0;
+    
+  iov[0].iov_base = ptr;
+  iov[0].iov_len = nbytes;
+  msghdr.msg_iov = iov;
+  msghdr.msg_iovlen = 1;
+    
+  if ( (n = recvmsg(fd, &msghdr, flags)) <= 0)
+    return (n);
+    
+  if ( (cmptr = CMSG_FIRSTHDR(&msghdr)) != NULL &&
+       cmptr->cmsg_len == CMSG_LEN(sizeof(int))) {
+    if (cmptr->cmsg_level != SOL_SOCKET)
+      msg (M_ERR, "control level != SOL_SOCKET");
+    if (cmptr->cmsg_type != SCM_RIGHTS)
+      msg (M_ERR, "control type != SCM_RIGHTS");
+    *recvfd = *((int *) CMSG_DATA(cmptr));
+  } else
+    *recvfd = -1;           /* descriptor was not passed */
+    
+  return (n);
+}
+#endif
+
 static int
 man_read (struct management *man)
 {
@@ -1788,7 +1860,15 @@ man_read (struct management *man)
   unsigned char buf[256];
   int len = 0;
 
+#ifdef TARGET_ANDROID
+  int fd;
+  len = man_recv_with_fd (man->connection.sd_cli, buf, sizeof (buf), MSG_NOSIGNAL, &fd);
+  if(fd >= 0) 
+     man->connection.lastfdreceived = fd;
+#else
   len = recv (man->connection.sd_cli, buf, sizeof (buf), MSG_NOSIGNAL);
+#endif
+
   if (len == 0)
     {
       man_reset_client_socket (man, false);
@@ -1865,6 +1945,13 @@ man_write (struct management *man)
   if (buf && BLEN (buf))
     {
       const int len = min_int (size_hint, BLEN (buf));
+#ifdef TARGET_ANDROID
+      if (man->connection.fdtosend > 0) 
+        {
+         sent = man_send_with_fd (man->connection.sd_cli, BPTR (buf), len, MSG_NOSIGNAL,man->connection.fdtosend);
+            man->connection.fdtosend = -1;
+        } else
+#endif
       sent = send (man->connection.sd_cli, BPTR (buf), len, MSG_NOSIGNAL);
       if (sent >= 0)
 	{
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 28da69f..f5d776e 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -299,6 +299,10 @@ struct man_connection {
 #ifdef MANAGMENT_EXTERNAL_KEY
   struct buffer_list *rsa_sig;
 #endif
+#ifdef TARGET_ANDROID
+  int fdtosend;
+  int lastfdreceived;
+#endif
 };
 
 struct management
-- 
1.7.9.5


