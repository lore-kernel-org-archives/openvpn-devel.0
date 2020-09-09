From: Gert Doering <gert@...1296...>
Date: Wed,  9 Sep 2020 14:29:26 +0200
Message-Id: <20200909122926.9523-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix description of --client-disconnect
 calling convention in manpage.
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

The man page claimed that --client-disconnect "is passed the same
pathname as the corresponding --client-connect command", which is
not what the code does.  Fix.

Reported-By: hvenev in Trac
Trac: #884

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/man-sections/script-options.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index b4bbf52f..a4df6732 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -157,9 +157,8 @@ SCRIPT HOOKS
   where some of the related client-connect functions returned an error
   status.
 
-  The ``--client-disconnect`` command is passed the same pathname as the
-  corresponding ``--client-connect`` command as its last argument (after
-  any arguments specified in ``cmd``).
+  The ``--client-disconnect`` command is not passed any extra arguments
+  (only those arguments specified in cmd, if any).
 
 --down cmd
   Run command ``cmd`` after TUN/TAP device close (post ``--user`` UID
-- 
2.26.2


