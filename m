From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 22 Jan 2013 12:36:53 +0100
Message-ID: <1358854613-7150-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] ignore UTF-8 byte order mark
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

Currently openvpn exits when reading configuration from a file
that has an UTF-8 byte order mark (EF BB BF) at its start.

While it is useless to put a BOM into UTF-8 encoded files, the
Unicode standard [1] permits it (on page 36):

  "Use of a BOM is neither required nor recommended for UTF-8,
  but may be encountered in contexts where UTF-8 data is converted
  from other encoding forms that use a BOM or where the BOM is
  used as a UTF-8 signature."

Notepad.exe, the default text editor on Windows, always puts the BOM
into UTF-8 encoded files when saving them. Others may do as well.

Just ignoring the UTF-8 BOM will make config files with UTF-8 BOM
readable.

[1] http://www.unicode.org/versions/Unicode5.0.0/ch02.pdf

Signed-off-by: Heiko Hund <heiko.hund@...1489...>

---
 src/openvpn/options.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 99f70ad..46f6f26 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3773,6 +3773,9 @@ read_config_file (struct options *options,
 	    {
 	      CLEAR (p);
 	      ++line_num;
+              /* Ignore UTF-8 BOM at start of stream */
+              if (line_num == 1 && strncmp (line, "\xEF\xBB\xBF", 3) == 0)
+                memmove (line, line + 3, strlen (line) - 2);
 	      if (parse_line (line, p, SIZE (p), file, line_num, msglevel, &options->gc))
 		{
 		  bypass_doubledash (&p[0]);
-- 
tg: (77fb72e..) t/0005/ignore_utf8_bom (depends on: t/0004/utf8_compatibility)

