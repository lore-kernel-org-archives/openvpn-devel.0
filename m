Date: Thu, 9 Oct 2014 23:40:49 +0200
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20141009214049.GB4106@...1818...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH] Fix temporary file leak
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Our openvpn server got out of free inodes in /tmp, making it quite
completely nonworking.  This is due to some codepath in multi.c which
does not remove its temporary file (when a plugin callback returns an
error, or a client-connect script returns an error).  Please see the
attached patch which fixes this.

Samuel

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 5910154..d0ed147 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1699,6 +1705,9 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	    {
 	      msg (M_WARN, "WARNING: client-connect plugin call failed");
 	      cc_succeeded = false;
+	      if (!platform_unlink (dc_file))
+		msg (D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
+		     dc_file);
 	    }
 	  else
 	    {
@@ -1757,7 +1766,12 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	      ++cc_succeeded_count;
 	    }
 	  else
-	    cc_succeeded = false;
+	    {
+	      cc_succeeded = false;
+	      if (!platform_unlink (dc_file))
+		msg (D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
+		     dc_file);
+	    }
         script_failed:
 	  argv_reset (&argv);
 	}

--7JfCtLOvnd9MIVvH--

