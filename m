From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 11 Feb 2026 16:06:48 +0100
Message-ID: <20260211150648.113547-1-frank@...2641...>
In-Reply-To: <gerrit.1770799998000.I14395665f197349e374a81b56f28536ff88937a8@...2715...>
References: <gerrit.1770799998000.I14395665f197349e374a81b56f28536ff88937a8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] rework all occurrences of 'M_ERR |
 M_ERRNO'
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
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne-openvpn@...1227...>

From: Gert Doering <gert@...1296...>

M_ERR is defined as (M_FATAL | M_ERRNO), so 'msg(M_ERR | M_ERRNO, ...)'
is just the same as 'msg(M_ERR, ...)'.

The occurances in tun.c and dco_freebsd.c are really "if this happens,
we can not go on" errors, so 'M_ERR' (= FATAL, plus log errno string)
is the correct thing to do.

The occurances in dns.c do come with error handling and cleanup after
the msg() call, so the right thing is 'M_WARN | M_ERRNO' instead
(warning, plus log errno string).

Github: fixes OpenVPN/openvpn#939

Change-Id: I14395665f197349e374a81b56f28536ff88937a8
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1517
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1517
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index d1ad092..ee3a5d0 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -177,7 +177,7 @@
     ret = ioctl(dco->fd, SIOCSDRVSPEC, &drv);
     if (ret)
     {
-        msg(M_ERR | M_ERRNO, "Failed to create new peer");
+        msg(M_ERR, "Failed to create new peer");
     }
 
     free(drv.ifd_data);
@@ -317,7 +317,7 @@
     ret = ioctl(tt->dco.fd, SIOCIFDESTROY, &ifr);
     if (ret)
     {
-        msg(M_ERR | M_ERRNO, "Failed to remove interface %s", ifr.ifr_name);
+        msg(M_ERR, "Failed to remove interface %s", ifr.ifr_name);
     }
 
     tt->dco.ifname[0] = 0;
@@ -473,7 +473,7 @@
     ret = ioctl(dco->fd, SIOCSDRVSPEC, &drv);
     if (ret)
     {
-        msg(M_ERR | M_ERRNO, "Failed to start vpn");
+        msg(M_ERR, "Failed to start vpn");
     }
 
     return ret;
@@ -511,7 +511,7 @@
     ret = ioctl(dco->fd, SIOCSDRVSPEC, &drv);
     if (ret)
     {
-        msg(M_ERR | M_ERRNO, "Failed to set key");
+        msg(M_ERR, "Failed to set key");
     }
     else
     {
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index c00d4b9..3d24050 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -611,13 +611,13 @@
     int ack_pipe_fd[2];
     if (pipe(dns_pipe_fd) != 0 || pipe(ack_pipe_fd) != 0)
     {
-        msg(M_ERR | M_ERRNO, "run_dns_up_down: unable to create pipes");
+        msg(M_WARN | M_ERRNO, "run_dns_up_down: unable to create pipes");
         return false;
     }
     updown_runner->pid = fork();
     if (updown_runner->pid == -1)
     {
-        msg(M_ERR | M_ERRNO, "run_dns_up_down: unable to fork");
+        msg(M_WARN | M_ERRNO, "run_dns_up_down: unable to fork");
         close(dns_pipe_fd[0]);
         close(dns_pipe_fd[1]);
         close(ack_pipe_fd[0]);
@@ -747,7 +747,7 @@
                 {
                     continue;
                 }
-                msg(M_ERR | M_ERRNO, "could not send dns vars filename");
+                msg(M_WARN | M_ERRNO, "could not send dns vars filename");
             }
             break;
         }
@@ -762,7 +762,7 @@
                 {
                     continue;
                 }
-                msg(M_ERR | M_ERRNO, "could not receive dns updown status");
+                msg(M_WARN | M_ERRNO, "could not receive dns updown status");
             }
             break;
         }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e38df3e..3f9ee5d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3011,7 +3011,7 @@
     /* Retrieve the assigned interface name. */
     if (getsockopt(fd, SYSPROTO_CONTROL, UTUN_OPT_IFNAME, utunname, &utunname_len))
     {
-        msg(M_ERR | M_ERRNO, "Error retrieving utun interface name");
+        msg(M_ERR, "Error retrieving utun interface name");
     }
 
     tt->actual_name = string_alloc(utunname, NULL);

