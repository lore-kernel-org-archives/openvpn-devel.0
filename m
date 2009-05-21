Message-ID: <4A1507CB.9040702@...1114...>
Date: Thu, 21 May 2009 09:50:35 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4A13BBB4.8020101@...41...>	<9e0cf0bf0905200345w3d0f7314m75cabed0b6220653@...278...>
	<9e0cf0bf0905200600k2f0a4fe8x3f0d015cd8286fb8@...278...>
In-Reply-To: <9e0cf0bf0905200600k2f0a4fe8x3f0d015cd8286fb8@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.1_rc16 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>, OpenVpn-Users <openvpn-users@lists.sourceforge.net>

> You also forgot the following patch.
> This avoid clash with MS constant, exists in psdk and mingw64.
> Instead of #undef it, use another name.
> 

+1 to this patch.  If there is a conflict with one platform, it's far
better to use another #define name instead, IMHO.


kind regards,

David Sommerseth



Index: a/ssl.c
===================================================================
--- a/ssl.c	(revision 3450)
+++ b/ssl.c	(working copy)
@@ -1653,8 +1653,8 @@
       return "S_GOT_KEY";
     case S_ACTIVE:
       return "S_ACTIVE";
-    case S_NORMAL:
-      return "S_NORMAL";
+    case S_NORMAL_OP:
+      return "S_NORMAL_OP";
     case S_ERROR:
       return "S_ERROR";
     default:
@@ -3564,8 +3564,8 @@
 		}
 	      else /* assume that ks->state == S_ACTIVE */
 		{
-		  dmsg (D_TLS_DEBUG_MED, "STATE S_NORMAL");
-		  ks->state = S_NORMAL;
+		  dmsg (D_TLS_DEBUG_MED, "STATE S_NORMAL_OP");
+		  ks->state = S_NORMAL_OP;
 		  ks->must_negotiate = 0;
 		}
 	    }
Index: a/ssl.h
===================================================================
--- a/ssl.h	(revision 3450)
+++ b/ssl.h	(working copy)
@@ -230,7 +230,7 @@
 #define S_SENT_KEY        4	/* client does S_SENT_KEY -> S_GOT_KEY */
 #define S_GOT_KEY         5	/* server does S_GOT_KEY -> S_SENT_KEY */
 #define S_ACTIVE          6	/* ready to exchange data channel packets */
-#define S_NORMAL          7	/* normal operations */
+#define S_NORMAL_OP       7	/* normal operations */

 /*
  * Are we ready to receive data channel packets?
Index: a/config-win32.h.in
===================================================================
--- a/config-win32.h.in	(revision 3450)
+++ b/config-win32.h.in	(working copy)
@@ -318,7 +318,6 @@
 #define S_IRUSR 0
 #define S_IWUSR 0
 typedef int intptr_t;
-#undef S_NORMAL
 /* Visual Studio 2005 supports vararg macros */
 #if _MSC_VER >= 1400
 #define HAVE_CPP_VARARG_MACRO_ISO 1


