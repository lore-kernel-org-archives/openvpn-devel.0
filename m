From: David Sommerseth <dazo@...384...>
Date: Fri, 16 Nov 2012 12:02:06 +0100
Message-Id: <1353063726-25113-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] Avoid recursion in
	virtual_output_callback_func()
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

From: David Sommerseth <davids@...1347...>

This solves a SEGV situation when using the management API while OpenVPN
is closing down.

The situation happens when the management socket has closed and OpenVPN
tries to write an error about this to the management socket.  What happens
is that

 virtual_output_callback_func() is called, which then calls
 -> man_output_list_push_finalize()
    -> man_output_standalone()
       -> man_write()  <-- this does the socket write
          -> man_io_error()
             -> x_msg()
                -> virtual_output_print()
                   -> virtual_output_callback_func() (recursion start)

virtual_output_callback_func() do have a mechanism to avoid recursion,
but that did not keep the recurse counter when man_output_list_push_finalize()
is called.

This patch just reorganise the recursion block to also keep the counter while
calling the other functions from virtual_output_callback_func()

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/manage.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index d0bb416..0a4542a 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -287,13 +287,13 @@ virtual_output_callback_func (void *arg, const unsigned int flags, const char *s
 
 # define AF_DID_PUSH  (1<<0)
 # define AF_DID_RESET (1<<1)
-  unsigned int action_flags = 0;
 
   if (!recursive_level) /* don't allow recursion */
     {
       struct gc_arena gc = gc_new ();
       struct log_entry e;
       const char *out = NULL;
+      unsigned int action_flags = 0;
 
       ++recursive_level;
 
@@ -334,14 +334,15 @@ virtual_output_callback_func (void *arg, const unsigned int flags, const char *s
 	    }
 	}
 
-      --recursive_level;
       gc_free (&gc);
-    }
 
-  if (action_flags & AF_DID_PUSH)
-    man_output_list_push_finalize (man);
-  if (action_flags & AF_DID_RESET)
-    man_reset_client_socket (man, true);
+      if (action_flags & AF_DID_PUSH)
+        man_output_list_push_finalize (man);
+      if (action_flags & AF_DID_RESET)
+        man_reset_client_socket (man, true);
+
+      --recursive_level;
+    }
 }
 
 /*
-- 
1.7.10.2


