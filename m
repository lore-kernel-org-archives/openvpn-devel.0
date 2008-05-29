Message-ID: <483ED0A6.5030708@...1104...>
Date: Thu, 29 May 2008 11:49:58 -0400
From: Martin Gadbois <martin.gadbois@...1104...>
MIME-Version: 1.0
References: <483DA4E4.1030308@...1104...>
In-Reply-To: <483DA4E4.1030308@...1104...>
Content-Type: multipart/mixed; boundary="------------080804030702000801010309"
Subject: Re: [Openvpn-devel] Memory of server keeps increasing with
	key	negotiations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080804030702000801010309
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Martin Gadbois wrote:

> Using OpenVPN 2.0.5 and 2.0.9, I notice that an somewhat idle connection
> increases the RSS of the server process linearly with time.
> 

Here is my patch to fix this issue. It does create (according to
valgrind) a memory leak, but it does not increase with time. Feel free
to fix it better...

I short, environments values were allocated using gc*(), and every key
change the environement list changes, but the allocated values stayed in
the context's gc.

I modified the environement values to always allocate using malloc() and
always free() values when the env list changes.


- --
==============         +---------------------------------------------+
Martin Gadbois         |    You are            -- J. Steakley,       |
Sr. SW Designer        |    What you do             Armor, 1984      |
Colubris Networks Inc. |    When it counts.                          |
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIPtCmMPkSU9icdA0RAiXTAJ4g3qzaubnyRTOCsCEF9Iz3BU+2AQCeMzzE
/7mbJluQBOfzjy4jph4T4RI=
=fksj
-----END PGP SIGNATURE-----

--------------080804030702000801010309
Content-Type: text/plain;
 name="no-env-gc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="no-env-gc.patch"

diff -ur openvpn-2.0.5-org/misc.c openvpn-2.0.5/misc.c
--- openvpn-2.0.5-org/misc.c	2005-11-01 06:06:11.000000000 -0500
+++ openvpn-2.0.5/misc.c	2008-05-29 11:37:05.000000000 -0400
@@ -651,7 +652,7 @@
 	    prev->next = current->next;
 	  else
 	    *list = current->next;
-	  if (do_free)
+//	  if (do_free)
 	    {
 	      memset (current->string, 0, strlen (current->string));
 	      free (current->string);
@@ -671,9 +672,10 @@
 
   ASSERT (str);
   ASSERT (list);
-
-  ALLOC_OBJ_GC (item, struct env_item, gc);
-  item->string = do_alloc ? string_alloc (str, gc): str;
+	dmsg(M_WARN,"ENV: Adding %s %s",str,do_alloc?"Alloc":"");
+  ALLOC_OBJ (item, struct env_item);
+//  item->string = do_alloc ? string_alloc (str, gc): str;
+  item->string = strdup(str);
   item->next = *list;
   *list = item;
 }


--------------080804030702000801010309--

