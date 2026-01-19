From: Gert Doering <gert@...1296...>
Date: Mon, 19 Jan 2026 22:49:22 +0100
Message-ID: <20260119214927.27766-1-gert@...1296...>
In-Reply-To: <gerrit.1767808679000.Ib517457015b754d59aeb70827c4795aa6154728c@...2715...>
References: <gerrit.1767808679000.Ib517457015b754d59aeb70827c4795aa6154728c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] openvpnserv: Factor out the string
 conversion from GetItfDnsDomains
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

Mostly so that we can actually test it. Since that
code does some in-place conversions a test would be
good.

Change-Id: Ib517457015b754d59aeb70827c4795aa6154728c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Heiko Hund <heiko@...515...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1458
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1458
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@...515...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index b53207bc..5c00eef 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2143,6 +2143,106 @@
 }
 
 /**
+ * Convert interface specific domain suffix(es) from comma-separated
+ * string to MULTI_SZ string.
+ *
+ * The \p domains paramter will be set to a MULTI_SZ domains string.
+ * In case of an error \p size is set to 0 and the contents of \p domains
+ * are invalid.
+ * Note that domains are deleted from the string if they match a search domain.
+ *
+ * @param[in]     search_domains  optional list of search domains
+ * @param[in,out] domains         buffer that contains the input comma-separated
+ *                                string and will contain the MULTI_SZ output string
+ * @param[in,out] size            pointer to size of the input string in bytes. Will be
+ *                                set to the size of the string returned, including
+ *                                the terminating zeros or 0.
+ * @param[in]     buf_size        size of the \p domains buffer
+ *
+ * @return LSTATUS NO_ERROR if the domain suffix(es) were read successfully,
+ *         ERROR_FILE_NOT_FOUND if no domain was found for the interface,
+ *         ERROR_MORE_DATA if the list did not fit into the buffer
+ */
+static LSTATUS
+ConvertItfDnsDomains(PCWSTR search_domains, PWSTR domains, PDWORD size, const DWORD buf_size)
+{
+    const DWORD glyph_size = sizeof(*domains);
+    const DWORD buf_len = buf_size / glyph_size;
+
+    /*
+     * Found domain(s), now convert them:
+     *   - prefix each domain with a dot
+     *   - convert comma separated list to MULTI_SZ
+     */
+    PWCHAR pos = domains;
+    while (TRUE)
+    {
+        /* Terminate the domain at the next comma */
+        PWCHAR comma = wcschr(pos, ',');
+        if (comma)
+        {
+            *comma = '\0';
+        }
+
+        DWORD domain_len = (DWORD)wcslen(pos);
+        DWORD domain_size = domain_len * glyph_size;
+        DWORD converted_size = (DWORD)(pos - domains) * glyph_size;
+
+        /* Ignore itf domains which match a pushed search domain */
+        if (ListContainsDomain(search_domains, pos, domain_len))
+        {
+            if (comma)
+            {
+                /* Overwrite the ignored domain with remaining one(s) */
+                memmove(pos, comma + 1, buf_size - converted_size);
+                *size -= domain_size + glyph_size;
+                continue;
+            }
+            else
+            {
+                /* This was the last domain */
+                *pos = '\0';
+                *size -= domain_size;
+                return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;
+            }
+        }
+
+        /* Add space for the leading dot */
+        domain_len += 1;
+        domain_size += glyph_size;
+
+        /* Space for the terminating zeros */
+        const DWORD extra_size = 2 * glyph_size;
+
+        /* Check for enough space to convert this domain */
+        if (converted_size + domain_size + extra_size > buf_size)
+        {
+            /* Domain doesn't fit, bad luck if it's the first one */
+            *pos = '\0';
+            *size = converted_size == 0 ? 0 : converted_size + glyph_size;
+            return ERROR_MORE_DATA;
+        }
+
+        /* Prefix domain at pos with the dot */
+        memmove(pos + 1, pos, buf_size - converted_size - glyph_size);
+        domains[buf_len - 1] = '\0';
+        *pos = '.';
+        *size += glyph_size;
+
+        if (!comma)
+        {
+            /* Conversion is done */
+            *(pos + domain_len) = '\0';
+            *size += glyph_size;
+            return NO_ERROR;
+        }
+
+        /* Comma pos is now +1 after adding leading dot */
+        pos = comma + 2;
+    }
+}
+
+/**
  * Return interface specific domain suffix(es)
  *
  * The \p domains paramter will be set to a MULTI_SZ domains string.
@@ -2174,7 +2274,6 @@
     LSTATUS err = ERROR_FILE_NOT_FOUND;
     const DWORD buf_size = *size;
     const DWORD glyph_size = sizeof(*domains);
-    const DWORD buf_len = buf_size / glyph_size;
     PWSTR values[] = { L"SearchList", L"Domain", L"DhcpDomainSearchList", L"DhcpDomain", NULL };
 
     for (int i = 0; values[i]; i++)
@@ -2183,77 +2282,7 @@
         err = RegGetValueW(itf, NULL, values[i], RRF_RT_REG_SZ, NULL, (PBYTE)domains, size);
         if (!err && *size > glyph_size && domains[(*size / glyph_size) - 1] == '\0' && wcschr(domains, '.'))
         {
-            /*
-             * Found domain(s), now convert them:
-             *   - prefix each domain with a dot
-             *   - convert comma separated list to MULTI_SZ
-             */
-            PWCHAR pos = domains;
-            while (TRUE)
-            {
-                /* Terminate the domain at the next comma */
-                PWCHAR comma = wcschr(pos, ',');
-                if (comma)
-                {
-                    *comma = '\0';
-                }
-
-                DWORD domain_len = (DWORD)wcslen(pos);
-                DWORD domain_size = domain_len * glyph_size;
-                DWORD converted_size = (DWORD)(pos - domains) * glyph_size;
-
-                /* Ignore itf domains which match a pushed search domain */
-                if (ListContainsDomain(search_domains, pos, domain_len))
-                {
-                    if (comma)
-                    {
-                        /* Overwrite the ignored domain with remaining one(s) */
-                        memmove(pos, comma + 1, buf_size - converted_size);
-                        *size -= domain_size + glyph_size;
-                        continue;
-                    }
-                    else
-                    {
-                        /* This was the last domain */
-                        *pos = '\0';
-                        *size -= domain_size;
-                        return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;
-                    }
-                }
-
-                /* Add space for the leading dot */
-                domain_len += 1;
-                domain_size += glyph_size;
-
-                /* Space for the terminating zeros */
-                const DWORD extra_size = 2 * glyph_size;
-
-                /* Check for enough space to convert this domain */
-                if (converted_size + domain_size + extra_size > buf_size)
-                {
-                    /* Domain doesn't fit, bad luck if it's the first one */
-                    *pos = '\0';
-                    *size = converted_size == 0 ? 0 : converted_size + glyph_size;
-                    return ERROR_MORE_DATA;
-                }
-
-                /* Prefix domain at pos with the dot */
-                memmove(pos + 1, pos, buf_size - converted_size - glyph_size);
-                domains[buf_len - 1] = '\0';
-                *pos = '.';
-                *size += glyph_size;
-
-                if (!comma)
-                {
-                    /* Conversion is done */
-                    *(pos + domain_len) = '\0';
-                    *size += glyph_size;
-                    return NO_ERROR;
-                }
-
-                /* Comma pos is now +1 after adding leading dot */
-                pos = comma + 2;
-            }
+            return ConvertItfDnsDomains(search_domains, domains, size, buf_size);
         }
     }
 

