From: Gert Doering <gert@...1296...>
Date: Tue, 26 Aug 2025 20:50:00 +0200
Message-ID: <20250826185007.22157-1-gert@...1296...>
In-Reply-To: <gerrit.1753360288000.I6a0d352a039a0936cb9bbedf6168cd6eecd053ea@...2715...>
References: <gerrit.1753360288000.I6a0d352a039a0936cb9bbedf6168cd6eecd053ea@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] comp: Make sure comp flags are treated
 as unsigned
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

From: Frank Lichtenheld <frank@...2641...>

compress_options.flags is already unsigned. Make sure
the individual flags are as well to avoid spurious
conversion warnings.

Change-Id: I6a0d352a039a0936cb9bbedf6168cd6eecd053ea
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1102
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 265e15d..0354896 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -32,23 +32,23 @@
 
 /* Compression flags */
 /* Removed
- #define COMP_F_ADAPTIVE             (1<<0) / * COMP_ALG_LZO only * /
- #define COMP_F_ALLOW_COMPRESS       (1<<1) / * not only incoming is compressed but also outgoing *
+ #define COMP_F_ADAPTIVE             (1u<<0) / * COMP_ALG_LZO only * /
+ #define COMP_F_ALLOW_COMPRESS       (1u<<1) / * not only incoming is compressed but also outgoing *
  /
  */
 /** initial command byte is swapped with last byte in buffer to preserve payload alignment */
-#define COMP_F_SWAP                 (1 << 2)
+#define COMP_F_SWAP                 (1u << 2)
 /** tell server that we only support compression stubs */
-#define COMP_F_ADVERTISE_STUBS_ONLY (1 << 3)
+#define COMP_F_ADVERTISE_STUBS_ONLY (1u << 3)
 /** Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
  * we still accept other compressions to be pushed */
-#define COMP_F_ALLOW_STUB_ONLY      (1 << 4)
+#define COMP_F_ALLOW_STUB_ONLY      (1u << 4)
 /** push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */
-#define COMP_F_MIGRATE              (1 << 5)
+#define COMP_F_MIGRATE              (1u << 5)
 /** Compression was explicitly set to allow asymetric compression */
-#define COMP_F_ALLOW_ASYM           (1 << 6)
+#define COMP_F_ALLOW_ASYM           (1u << 6)
 /** Do not allow compression framing (breaks DCO) */
-#define COMP_F_ALLOW_NOCOMP_ONLY    (1 << 7)
+#define COMP_F_ALLOW_NOCOMP_ONLY    (1u << 7)
 
 /* algorithms */
 #define COMP_ALG_UNDEF  0

