From: Ian Pilcher <i.pilcher@...164...>
Message-ID: <c08jv9$jut$1@...165...>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060409010003070602000402"
Subject: [Openvpn-devel] nice() return value is unreliable
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Feb 10 10:41:04 2004
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060409010003070602000402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a small patch to set_nice() in misc.c that uses errno,
rather than nice()'s return value to determine if the call succeeded.
See 'man 2 nice' on a recent Linux distribution for why checking the
return value is unreliable.

-- 
========================================================================
Ian Pilcher                                        i.pilcher@...164...
========================================================================

--------------060409010003070602000402
Content-Type: text/plain;
 name="openvpn-set_nice.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-set_nice.patch"

diff -urNp ../openvpn-1.5.0-orig/misc.c ./misc.c
--- ../openvpn-1.5.0-orig/misc.c	2004-02-09 11:38:59.000000000 -0600
+++ ./misc.c	2004-02-09 12:25:08.000000000 -0600
@@ -139,7 +139,9 @@ set_nice (int niceval)
   if (niceval)
     {
 #ifdef HAVE_NICE
-      if (nice (niceval) < 0)
+      errno = 0;
+      nice (niceval);
+      if (errno != 0)
 	msg (M_WARN | M_ERRNO, "WARNING: nice %d failed", niceval);
       else
 	msg (M_INFO, "nice %d succeeded", niceval);

--------------060409010003070602000402--



