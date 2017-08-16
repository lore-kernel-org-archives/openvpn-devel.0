From: Antonio Quartulli <a@...2181...>
Date: Wed, 16 Aug 2017 09:01:05 +0800
Message-Id: <20170816010105.21777-1-a@...2181...>
In-Reply-To: <20170816005815.16376-1-a@...2181...>
References: <20170816005815.16376-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] ntlm: avoid breaking anti-aliasing rules
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

The problem is visible when compiling with -O2:

ntlm.c: In function ‘ntlm_phase_3’:
ntlm.c:305:9: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
         if ((*((long *)&buf2[0x14]) & 0x00800000) == 0x00800000)

The spec suggests to interpret those 4 bytes as a long, but
this needs to be done carefully.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---

v2: remove htonl/ntohl conversion as there is none in the original code
v3: correct author's email

 src/openvpn/ntlm.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 167c10b8..658c875e 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -302,7 +302,19 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
         /* Add target information block to the blob */
 
         /* Check for Target Information block */
-        if ((*((long *)&buf2[0x14]) & 0x00800000) == 0x00800000)
+        /* The NTLM spec instructs to interpret these 4 consecutive bytes as a
+         * 32bit long integer. However, no endianness is specified.
+         * The code here and that found in other NTLM implementations point
+         * towards the assumption that the byte order on the wire has to
+         * match the order on the sending and receiving hosts. Probably NTLM has
+         * been thought to be always running on x86_64/i386 machine thus
+         * implying Little-Endian everywhere.
+         *
+         * This said, in case of future changes, we should keep in mind that the
+         * byte order on the wire for the NTLM header is LE.
+         */
+        unsigned long *flags = (unsigned long *)(buf2 + 0x14);
+        if ((*flags & 0x00800000) == 0x00800000)
         {
             tib_len = buf2[0x28];            /* Get Target Information block size */
             if (tib_len > 96)
-- 
2.14.0


