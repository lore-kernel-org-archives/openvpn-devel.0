From: davids@...1347...
Date: Wed, 16 Apr 2014 17:43:41 +0200
Message-Id: <1397663021-18815-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Improve error reporting on file access to
	--client-config-dir and --ccd-exclusive
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

OpenVPN will do some simple sanity checking at startup to ensure the expected
files and directories is in place.  However, with --client-config-dir and
--ccd-exclusive, things are slightly different.  In both cases it is perfectly
fine that files does not exists, and we cannot know any file names beforehand
due to these filenames being based upon the certificate's CN field.

The problem arises when OpenVPN cannot open files inside a directory because
the directory permissions are too restrictive, have wrong ownership (triggered
by the usage of --user/--group) or other security mechanisms the OS uses.

When a client connects, the test_file() function is used to check if a client
config file has been prepared.  And if not, it continues without trying to read
it.  So, if the privileges of the running OpenVPN process is not allowed to
open and read an existing file, OpenVPN will treat this as a non-existing file
without saying anything.  This is clearly wrong.  So this patch adds an warning
message in the OpenVPN log if it could not open the file due to lack of
permissions.

This will work fine on all *nix based OSes.  Windows however reports 'no such
file or directory' (errno=2/-ENOENT) even on privilege access errors when the
directory this file resides is too restrictive.  But there is no easy way to
work around that.  However, I believe that the initial sanity checking at
startup will catch that one, as it will check if the directories it needs
exists.

This patch has not been thoroughly tested, so please test!

Trac: #277
Trac-URL: https://community.openvpn.net/openvpn/ticket/277
Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/misc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 7483184..7d7fda8 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -861,6 +861,12 @@ test_file (const char *filename)
 	  fclose (fp);
 	  ret = true;
 	}
+      else
+	{
+	  if( errno == EACCES ) {
+	    msg( M_WARN | M_ERRNO, "Could not access file '%s'", filename);
+	  }
+	}
     }
 
   dmsg (D_TEST_FILE, "TEST FILE '%s' [%d]",
-- 
1.8.3.1


