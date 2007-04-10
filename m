Message-ID: <461B6F01.5020207@...260...>
Date: Tue, 10 Apr 2007 13:03:29 +0200
From: Valentin LAB <vaab@...260...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090408030202050700070801"
Subject: [Openvpn-devel] patch for "plugin/down-root/down-root.c" correcting
	restart issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090408030202050700070801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm not sure I must post this patch here. It corrects a strange behavior 
of openvpn and its plugin openvpn-down-root upon some restart occasion :

On the client side, openvpn fails and quit after failure of its plugin 
when the server is restarted. This is quite annoying in large VPN, 
requiring to "start" again the openvpn process on all clients everytime 
you do a "restart" of the vpn server node.

These are the logs (in verbose level 7):

...
PLUGIN_CALL: POST /usr/lib/openvpn/openvpn-down-root.so/PLUGIN_UP status=1
PLUGIN_CALL: plugin function PLUGIN_UP failed with status 1: 
/usr/lib/openvpn/openvpn-down-root.so
ERROR: up/down plugin call failed
Exiting
DOWN-ROOT: BACKGROUND: received command code: 1
DOWN-ROOT: BACKGROUND: EXIT


I tracked down the problem in the plugin, right in the function 
openvpn_plugin_func_v1, it seemed to me that the case

(type == OPENVPN_PLUGIN_UP && context->foreground_fd >= 0)

wasn't handled and thus, at the end of this function, this special case 
triggers OPENVPN_PLUGIN_FUNC_ERROR which in turn will end up exiting 
openvpn.

This special case is only triggered on restart : the condition
(type == OPENVPN_PLUGIN_UP) is true at start and is used to fork a 
process (with root perms) that will wait for openvpn signal to launch 
it's command.

context->foreground_fd is set to the communication socket between the 
forked process and openvpn. This is "-1" when no process have been 
created BUT is >= 0 when it has been created.

My patch handles the special case : (type == OPENVPN_PLUGIN_UP && 
context->foreground_fd >= 0) which occurs at restart condition : forked 
process and communication socket are already present, but PLUGIN_UP is 
called.

My patch will test that the process is still valid by sending a "ping 
command", and return that all is ok if process answered correctly to the 
ping.

I'm not a confirmed developper, so this patch needs review.

Hope this will help...

(The patch is the result of a "svn diff" from the openvpn root directory)

Valentin LAB


--------------090408030202050700070801
Content-Type: text/x-patch;
 name="plugin-down-root.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="plugin-down-root.patch"

Index: plugin/down-root/down-root.c
===================================================================
--- plugin/down-root/down-root.c	(revision 1820)
+++ plugin/down-root/down-root.c	(working copy)
@@ -44,12 +44,14 @@
 /* Command codes for foreground -> background communication */
 #define COMMAND_RUN_SCRIPT 0
 #define COMMAND_EXIT       1
+#define COMMAND_PING       2
 
 /* Response codes for background -> foreground communication */
 #define RESPONSE_INIT_SUCCEEDED   10
 #define RESPONSE_INIT_FAILED      11
 #define RESPONSE_SCRIPT_SUCCEEDED 12
 #define RESPONSE_SCRIPT_FAILED    13
+#define RESPONSE_PING_REQUEST     14
 
 /* Background process function */
 static void down_root_server (const int fd, char *command, const char *argv[], const char *envp[], const int verb);
@@ -386,6 +388,28 @@
 	  return 0; /* NOTREACHED */
 	}
     }
+  else if (type == OPENVPN_PLUGIN_UP && context->foreground_fd >= 0) /* no need to fork a second process */
+    {
+
+      /* Check process communication */      
+
+      if (send_control (context->foreground_fd, COMMAND_PING) == -1)
+	{
+	  fprintf (stderr, "DOWN-ROOT: Error sending ping request signal to background process\n");
+	}
+      else
+	{
+	  const int status = recv_control (context->foreground_fd);
+	  if (status == RESPONSE_PING_REQUEST) 
+	    {
+	      return OPENVPN_PLUGIN_FUNC_SUCCESS;
+	    }
+	  else
+	    {
+	      fprintf (stderr, "DOWN-ROOT: Error receiving ping reception confirmation from background process\n");
+	    }
+	}
+    }
   else if (type == OPENVPN_PLUGIN_DOWN && context->foreground_fd >= 0)
     {
       if (send_control (context->foreground_fd, COMMAND_RUN_SCRIPT) == -1)
@@ -401,6 +425,7 @@
 	    fprintf (stderr, "DOWN-ROOT: Error receiving script execution confirmation from background process\n");
 	}
     }
+  
   return OPENVPN_PLUGIN_FUNC_ERROR;
 }
 
@@ -525,6 +550,17 @@
 	    }
 	  break;
 
+	case COMMAND_PING: /* allows to check if process is listening */
+
+	  if (send_control (fd, RESPONSE_PING_REQUEST) == -1)
+	    {
+	      fprintf (stderr, "DOWN-ROOT: BACKGROUND: write error on response socket [4]\n");
+	      goto done;
+	    }
+
+	  break;
+
+
 	case COMMAND_EXIT:
 	  goto done;
 

--------------090408030202050700070801--

