From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20030219212128.GB5358@...33...>
References: <20030219181048.GA21087@...33...> <Pine.LNX.4.44.0302191128560.12503-100000@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.44.0302191128560.12503-100000@...41...>
Subject: [Openvpn-devel] warnings quencher #1
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Feb 19 13:22:14 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

against current CVS:

Index: thread.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/thread.h,v
retrieving revision 1.3
diff -u -r1.3 thread.h
--- thread.h	25 Jun 2002 06:56:16 -0000	1.3
+++ thread.h	19 Feb 2003 21:21:03 -0000
@@ -136,6 +136,8 @@
 static inline void
 work_thread_create (void *(*start_routine) (void *), void* arg)
 {
+    (void)start_routine;
+    (void)arg;
 }
 
 static inline void
@@ -146,16 +148,19 @@
 static inline void
 mutex_lock (int type)
 {
+    (void)type;
 }
 
 static inline void
 mutex_unlock (int type)
 {
+    (void)type;
 }
 
 static inline void
 mutex_cycle (int type)
 {
+    (void)type;
 }
 
 #endif /* USE_PTHREAD */

