From: Gert Doering <gert@...1296...>
Date: Tue, 28 Oct 2025 21:31:50 +0100
Message-ID: <20251028203156.11697-1-gert@...1296...>
In-Reply-To: <gerrit.1761676579000.I7f4c7b0ca748975defca1e5104e7077a761cd49c@...2715...>
References: <gerrit.1761676579000.I7f4c7b0ca748975defca1e5104e7077a761cd49c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] zeroize struct image in
 packet_id_persist_save() before writing to disk
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

while this really is only a debug function, ensuring that no uninitialized
heap content ends up in padding in the structure and thus to disk is good
practice.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)

Change-Id: I7f4c7b0ca748975defca1e5104e7077a761cd49c
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1323
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1323
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 880eee1..08d9d9b 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -511,6 +511,7 @@
         && (p->time != p->time_last_written || p->id != p->id_last_written))
     {
         struct packet_id_persist_file_image image;
+        CLEAR(image);
         ssize_t n;
         off_t seek_ret;
         struct gc_arena gc = gc_new();

