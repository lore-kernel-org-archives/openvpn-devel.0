From: David Stipp <dstipp@...507...>
Message-ID: <20051122162842.GK32660@...507...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN AutoConf macro bug
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
Date: Tue Nov 22 08:30:02 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: dstipp@...507...

Hi all,

There's a bug in the autoconf macros that cause the compile to fail on
Sun Studio 9.  One of the tests (empty array support) is not escaped
properly, so the macro int bar[0] expands to int bar0, which won't
exactly test what it needs to be testing...

Patch below.  (basically put the bar[0] brackets within brackets.)

********************************************************************************
--- acinclude.m4.orig   2005-11-21 17:13:48.214828000 -0600
+++ acinclude.m4        2005-11-21 17:12:51.172087000 -0600
@@ -19,7 +19,7 @@
   AC_MSG_RESULT([checking for C compiler empty array support])
   AC_COMPILE_IFELSE(
     [
-        struct { int foo; int bar[0]; } mystruct;
+        struct { int foo; int bar[[0]]; } mystruct;
     ], [
         AC_DEFINE_UNQUOTED(EMPTY_ARRAY_SIZE, 0, [Dimension to use for
empty array declaration])
     ], [
********************************************************************************

I checked trunk in svn last night and noticed the same problem.  It's be
nice if this change could be included.

Please CC me on any additional correspondence as I am not on the mailing
list.

Thanks!

David

-- 
David Stipp <dstipp@...507...>

