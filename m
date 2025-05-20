From: Gert Doering <gert@...1296...>
Date: Tue, 20 May 2025 12:51:12 +0200
Message-ID: <20250520105119.10431-1-gert@...1296...>
In-Reply-To: <gerrit.1741315174000.I4919af2b845a47787c08f454b108ef376ea5c0f6@...2715...>
References: <gerrit.1741315174000.I4919af2b845a47787c08f454b108ef376ea5c0f6@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v20] win: match search domains when creating
 exclude rules
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

From: Heiko Hund <heiko@...2662...>

Compare local domains for exclude rules to search domains and skip
matching ones. This prevents the creation of exclude rules when the
server indicates that the domain should be resolved via the VPN, by
pushing the search domain.

Change-Id: I4919af2b845a47787c08f454b108ef376ea5c0f6
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/905
This mail reflects revision 20 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 5f842bd..a1581a6 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2126,18 +2126,52 @@
 }
 
 /**
+ * Check if a domain is contained in a comma separated list of domains
+ *
+ * @param list      Comma separated list of domains
+ * @param domain    Domain string to search for
+ * @param len       Length of the domain string, excluding the '\0'
+ *
+ * @return TRUE when the domain was found in the list, FALSE otherwise.
+ */
+static BOOL
+ListContainsDomain(PCWSTR list, PCWSTR domain, size_t len)
+{
+    PCWSTR match = list;
+    while (TRUE)
+    {
+        match = wcsstr(match, domain);
+        if (!match)
+        {
+            /* Domain has not matched */
+            break;
+        }
+        if ((match == list || *(match - 1) == ',')
+            && (*(match + len) == ',' || *(match + len) == '\0'))
+        {
+            /* Domain has matched fully */
+            return TRUE;
+        }
+        match += len;
+    }
+    return FALSE;
+}
+
+/**
  * Return interface specific domain suffix(es)
  *
  * The \p domains paramter will be set to a MULTI_SZ domains string.
  * In case of an error or if no domains are found for the interface
  * \p size is set to 0 and the contents of \p domains are invalid.
  * Note that the domains could have been set by DHCP or manually.
+ * Note that domains are ignored if they match a pushed search domain.
  *
- * @param  itf        HKEY of the interface to read from
- * @param  domains    PWSTR buffer to return the domain(s) in
- * @param  size       pointer to size of the domains buffer in bytes. Will be
- *                    set to the size of the string returned, including
- *                    the terminating zeros or 0.
+ * @param  itf             HKEY of the interface to read from
+ * @param  search_domains  optional list of search domains
+ * @param  domains         PWSTR buffer to return the domain(s) in
+ * @param  size            pointer to size of the domains buffer in bytes. Will be
+ *                         set to the size of the string returned, including
+ *                         the terminating zeros or 0.
  *
  * @return LSTATUS NO_ERROR if the domain suffix(es) were read successfully,
  *         ERROR_FILE_NOT_FOUND if no domain was found for the interface,
@@ -2145,7 +2179,7 @@
  *         any other error indicates an error while reading from the registry.
  */
 static LSTATUS
-GetItfDnsDomains(HKEY itf, PWSTR domains, PDWORD size)
+GetItfDnsDomains(HKEY itf, PCWSTR search_domains, PWSTR domains, PDWORD size)
 {
     if (domains == NULL || size == 0)
     {
@@ -2179,9 +2213,27 @@
                     *comma = '\0';
                 }
 
+                /* Ignore itf domains which match a pushed search domain */
+                size_t domain_len = wcslen(pos);
+                if (ListContainsDomain(search_domains, pos, domain_len))
+                {
+                    if (comma)
+                    {
+                        pos = comma + 1;
+                        continue;
+                    }
+                    else
+                    {
+                        /* This was the last domain */
+                        *pos = '\0';
+                        *size += 1;
+                        return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;
+                    }
+                }
+
                 /* Check for enough space to convert this domain */
+                domain_len += 1; /* leading dot */
                 size_t converted_size = pos - domains;
-                size_t domain_len = wcslen(pos) + 1;
                 size_t domain_size = domain_len * one_glyph;
                 size_t extra_size = 2 * one_glyph;
                 if (converted_size + domain_size + extra_size > buf_size)
@@ -2265,11 +2317,12 @@
  * needed so that local DNS keeps working even when a catch all NRPT rule is
  * installed by a VPN connection.
  *
- * @param  data       pointer to the data structures the values are returned in
- * @param  data_size  number of exclude data structures pointed to
+ * @param  search_domains  optional list of search domains
+ * @param  data            pointer to the data structures the values are returned in
+ * @param  data_size       number of exclude data structures pointed to
  */
 static void
-GetNrptExcludeData(nrpt_exclude_data_t *data, size_t data_size)
+GetNrptExcludeData(PCWSTR search_domains, nrpt_exclude_data_t *data, size_t data_size)
 {
     HKEY v4_itfs = INVALID_HANDLE_VALUE;
     HKEY v6_itfs = INVALID_HANDLE_VALUE;
@@ -2313,7 +2366,7 @@
         /* Get the DNS domain(s) for exclude routing */
         data[i].domains_size = sizeof(data[0].domains);
         memset(data[i].domains, 0, data[i].domains_size);
-        err = GetItfDnsDomains(v4_itf, data[i].domains, &data[i].domains_size);
+        err = GetItfDnsDomains(v4_itf, search_domains, data[i].domains, &data[i].domains_size);
         if (err)
         {
             if (err != ERROR_FILE_NOT_FOUND)
@@ -2471,15 +2524,16 @@
  * local resolution of names is not interfered with in case the VPN resolves
  * all names.
  *
- * @param  nrpt_key   the registry key to set the rules under
- * @param  ovpn_pid   the PID of the openvpn process
+ * @param  nrpt_key        the registry key to set the rules under
+ * @param  ovpn_pid        the PID of the openvpn process
+ * @param  search_domains  optional list of search domains
  */
 static void
-SetNrptExcludeRules(HKEY nrpt_key, DWORD ovpn_pid)
+SetNrptExcludeRules(HKEY nrpt_key, DWORD ovpn_pid, PCWSTR search_domains)
 {
     nrpt_exclude_data_t data[8]; /* data from up to 8 interfaces */
     memset(data, 0, sizeof(data));
-    GetNrptExcludeData(data, _countof(data));
+    GetNrptExcludeData(search_domains, data, _countof(data));
 
     unsigned n = 0;
     for (int i = 0; i < _countof(data); ++i)
@@ -2504,17 +2558,18 @@
 /**
  * Set NRPT rules for a openvpn process
  *
- * @param  nrpt_key   the registry key to set the rules under
- * @param  addresses  name server addresses
- * @param  domains    optional list of split routing domains
- * @param  dnssec     boolean whether DNSSEC is to be used
- * @param  ovpn_pid   the PID of the openvpn process
+ * @param  nrpt_key          the registry key to set the rules under
+ * @param  addresses         name server addresses
+ * @param  domains           optional list of split routing domains
+ * @param  search_domains    optional list of search domains
+ * @param  dnssec            boolean whether DNSSEC is to be used
+ * @param  ovpn_pid          the PID of the openvpn process
  *
  * @return NO_ERROR on success, or a Windows error code
  */
 static DWORD
-SetNrptRules(HKEY nrpt_key, const nrpt_address_t *addresses,
-             const char *domains, BOOL dnssec, DWORD ovpn_pid)
+SetNrptRules(HKEY nrpt_key, const nrpt_address_t *addresses, const char *domains,
+             const char *search_domains, BOOL dnssec, DWORD ovpn_pid)
 {
     DWORD err = NO_ERROR;
     PWSTR wide_domains = L".\0"; /* DNS route everything by default */
@@ -2543,7 +2598,14 @@
     }
     else
     {
-        SetNrptExcludeRules(nrpt_key, ovpn_pid);
+        PWSTR wide_search_domains;
+        wide_search_domains = utf8to16(search_domains);
+        if (!wide_search_domains)
+        {
+            return ERROR_OUTOFMEMORY;
+        }
+        SetNrptExcludeRules(nrpt_key, ovpn_pid, wide_search_domains);
+        free(wide_search_domains);
     }
 
     /* Create address string list */
@@ -2803,7 +2865,7 @@
 
     /* Set NRPT rules */
     BOOL dnssec = (msg->flags & nrpt_dnssec) != 0;
-    err = SetNrptRules(key, msg->addresses, msg->resolve_domains, dnssec, ovpn_pid);
+    err = SetNrptRules(key, msg->addresses, msg->resolve_domains, msg->search_domains, dnssec, ovpn_pid);
     if (err)
     {
         goto out;

