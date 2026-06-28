Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB92CC43458
	for <openvpn-devel@archiver.kernel.org>; Sun, 28 Jun 2026 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eNRYkIgdjUg4oNCxi9bKIuEwVKNlKy2nmm794TN146o=; b=lJn2cLdEA5bJdJEqQGppzJa4gp
	4D7SVajGbPDXQNa4ycVd9FpodI6FnQcg80tJdfXX2r0RG374ks2V4ekQGk5XNAgtOm2do6oYoRIhk
	Zst9HGlIA7ZJ6EnjHqmW9RQKlui0fmhNYDX9LGVTxcvjDfLugdxqDRLrgKQR2Ox0KuKg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdpAC-0000jB-Tl;
	Sun, 28 Jun 2026 13:03:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wdpAB-0000j5-HX
 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 13:03:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y25TNpAxfnCsX62zXDqlzuG1G6KtZ+sk6GMJbdAmtS8=; b=CHOZ+OmgQkO2D6PYw99Erzawwi
 nsbjdFFS7HD0ffV3FZEnsjGFmCMSVqXj29Z7erBz0GlNEl32ZYQb81ao6COrFdvi8Bnk1Es7jS9lA
 PDpfTiF+iuEuQNfDfsOYq4LLomF1aBA+UH13NsG7zoYZl7a1I/1tKiXw5X5N8nK75Htw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y25TNpAxfnCsX62zXDqlzuG1G6KtZ+sk6GMJbdAmtS8=; b=D6pZigRJR/GcK/bQ8cGFZaBpLj
 lg7GKXuiRnDsoKb2heo6WXybbTyq4cIZx6vO2A9icdKoGj+CI8nCHvR7pTHsV0tmY6+6VihNnwC9B
 PHnlP0IMv1wqhJEEDjgKvefESAacTBblxskMosL/txqqZycLpNTOtz/anO59oCPc3iRQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wdpA6-0007GG-KB for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 13:03:05 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65SD2tCP025472
 for <openvpn-devel@lists.sourceforge.net>; Sun, 28 Jun 2026 15:02:55 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65SD2tSP025471
 for openvpn-devel@lists.sourceforge.net; Sun, 28 Jun 2026 15:02:55 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 28 Jun 2026 15:02:50 +0200
Message-ID: <20260628130255.25452-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782264341000.I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938@gerrit.openvpn.net>
References: <gerrit.1782264341000.I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wdpA6-0007GG-KB
Subject: [Openvpn-devel] [PATCH v5] openvpnserv: rework ConvertItfDnsDomains
 and tests
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Heiko Hund <heiko@ist.eigentlich.net>

Since there were issues with in-place modification of the buffer
repeatedly, re-implement ConvertItfDnsDomains() to use a internal
temporary buffer to prevent use of memmove and the length calculations
that come with it. Code should be easier to grasp since we're dealing
with one set of lengths (WCHARs) instead of two (WCHARs + octets) now.

The unit tests did not actually test the MULTI_SZs correctly, fixed
that and also added some more tests to cover more scenarios.

Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Lev Stipakov <lstipakov@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1730
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1730
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@gmail.com>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 788a578..516a469 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -33,6 +33,7 @@
 #include <shellapi.h>
 #include <mstcpip.h>
 #include <inttypes.h>
+#include <malloc.h>
 
 #include <versionhelpers.h>
 
@@ -2130,22 +2131,20 @@
 static BOOL
 ListContainsDomain(PCWSTR list, PCWSTR domain, size_t len)
 {
-    PCWSTR match = list;
-    while (match)
+    PCWSTR entry = list;
+    while (entry && *entry)
     {
-        match = wcsstr(match, domain);
-        if (!match)
+        PCWSTR comma = wcschr(entry, L',');
+        size_t entry_len = comma ? (size_t)(comma - entry) : wcslen(entry);
+        if (entry_len == len && wcsncmp(entry, domain, len) == 0)
         {
-            /* Domain has not matched */
-            break;
-        }
-        if ((match == list || *(match - 1) == ',')
-            && (*(match + len) == ',' || *(match + len) == '\0'))
-        {
-            /* Domain has matched fully */
             return TRUE;
         }
-        match += len;
+        if (!comma)
+        {
+            break;
+        }
+        entry = comma + 1;
     }
     return FALSE;
 }
@@ -2159,95 +2158,94 @@
  * are invalid.
  * Note that domains are deleted from the string if they match a search domain.
  *
- * @param[in]     search_domains  optional list of search domains
+ * @param[in]     search_domains  optional string of comma separated search domains
  * @param[in,out] domains         buffer that contains the input comma-separated
  *                                string and will contain the MULTI_SZ output string
  * @param[in,out] size            pointer to size of the input string in bytes. Will be
  *                                set to the size of the string returned, including
  *                                the terminating zeros or 0.
- * @param[in]     buf_size        size of the \p domains buffer
+ * @param[in]     capacity        capacity of the \p domains buffer in bytes
  *
- * @return LSTATUS NO_ERROR if the domain suffix(es) were read successfully,
- *         ERROR_FILE_NOT_FOUND if no domain was found for the interface,
- *         ERROR_MORE_DATA if the list did not fit into the buffer
+ * @return LSTATUS NO_ERROR if all domain suffix(es) were converted successfully,
+ *         ERROR_FILE_NOT_FOUND if no domain was left after the conversion,
+ *         ERROR_MORE_DATA if not all converted domains did fit into the buffer.
+ *         ERROR_OUTOFMEMORY if the temporary buffer could not be allocated.
  */
 static LSTATUS
-ConvertItfDnsDomains(PCWSTR search_domains, PWSTR domains, PDWORD size, const DWORD buf_size)
+ConvertItfDnsDomains(PCWSTR search_domains, PWSTR domains, PDWORD size, const DWORD capacity)
 {
-    const DWORD glyph_size = sizeof(*domains);
-    const DWORD buf_len = buf_size / glyph_size;
+    const size_t glyph_size = sizeof(*domains);
+    const size_t max_len = (size_t)capacity / glyph_size;
 
-    /*
-     * Found domain(s), now convert them:
-     *   - prefix each domain with a dot
-     *   - convert comma separated list to MULTI_SZ
-     */
-    PWCHAR pos = domains;
-    while (TRUE)
+    /* Space required for leading dot and two terminating zeros */
+    const size_t dot_len = 1;
+    const size_t term_len = 2;
+
+    LSTATUS ret = NO_ERROR;
+    size_t tmp_len = 0;
+    WCHAR *tmp = malloc(capacity);
+    if (tmp == NULL)
     {
-        /* Terminate the domain at the next comma */
-        PWCHAR comma = wcschr(pos, ',');
-        if (comma)
+        ret = ERROR_OUTOFMEMORY;
+        goto done;
+    }
+
+    PWCHAR tmp_pos = tmp;
+    PCWCHAR domain = domains;
+
+    while (domain && *domain)
+    {
+        PWCHAR comma = wcschr(domain, L',');
+        size_t domain_len = comma ? (size_t)(comma - domain) : wcslen(domain);
+
+        if (ListContainsDomain(search_domains, domain, domain_len))
         {
-            *comma = '\0';
+            /* Skip this domain */
+            domain = comma ? comma + 1 : domain + domain_len;
+            continue;
         }
 
-        DWORD domain_len = (DWORD)wcslen(pos);
-        DWORD domain_size = domain_len * glyph_size;
-        DWORD converted_size = (DWORD)(pos - domains) * glyph_size;
-
-        /* Ignore itf domains which match a pushed search domain */
-        if (ListContainsDomain(search_domains, pos, domain_len))
-        {
-            if (comma)
-            {
-                /* Overwrite the ignored domain with remaining one(s) */
-                memmove(pos, comma + 1, buf_size - converted_size);
-                *size -= domain_size + glyph_size;
-                continue;
-            }
-            else
-            {
-                /* This was the last domain */
-                *pos = '\0';
-                *size -= domain_size;
-                return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;
-            }
-        }
-
-        /* Add space for the leading dot */
-        domain_len += 1;
-        domain_size += glyph_size;
-
-        /* Space for the terminating zeros */
-        const DWORD extra_size = 2 * glyph_size;
-
         /* Check for enough space to convert this domain */
-        if (converted_size + domain_size + extra_size > buf_size)
+        if (tmp_len + dot_len + domain_len + term_len > max_len)
         {
             /* Domain doesn't fit, bad luck if it's the first one */
-            *pos = '\0';
-            *size = converted_size == 0 ? 0 : converted_size + glyph_size;
-            return ERROR_MORE_DATA;
+            *tmp_pos = L'\0';
+            if (tmp_len > 0)
+            {
+                tmp_len += 1;
+            }
+            ret = ERROR_MORE_DATA;
+            goto done;
         }
 
-        /* Prefix domain at pos with the dot */
-        memmove(pos + 1, pos, buf_size - converted_size - glyph_size);
-        domains[buf_len - 1] = '\0';
-        *pos = '.';
-        *size += glyph_size;
+        /* Write leading dot and domain into tmp buffer */
+        *tmp_pos++ = L'.';
+        wcsncpy(tmp_pos, domain, domain_len);
+        tmp_pos += domain_len;
+        *tmp_pos++ = L'\0';
+        tmp_len += dot_len + domain_len + 1;
 
-        if (!comma)
-        {
-            /* Conversion is done */
-            *(pos + domain_len) = '\0';
-            *size += glyph_size;
-            return NO_ERROR;
-        }
-
-        /* Comma pos is now +1 after adding leading dot */
-        pos = comma + 2;
+        domain = comma ? comma + 1 : domain + domain_len;
     }
+
+    if (tmp_len == 0)
+    {
+        ret = ERROR_FILE_NOT_FOUND;
+        goto done;
+    }
+
+    /* REG_MULTI_SZ second zero terminator */
+    *tmp_pos = L'\0';
+    tmp_len += 1;
+
+done:
+    if (tmp)
+    {
+        wmemcpy(domains, tmp, tmp_len);
+        free(tmp);
+    }
+    *size = (DWORD)(tmp_len * glyph_size);
+    return ret;
 }
 
 /**
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv.c b/tests/unit_tests/openvpnserv/test_openvpnserv.c
index 45096a1..e432f44 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnserv.c
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv.c
@@ -48,58 +48,109 @@
     assert_true(ListContainsDomain(domain, domain, domain_len));
     assert_true(ListContainsDomain(L"openvpn.com,openvpn.net", domain, domain_len));
     assert_true(ListContainsDomain(L"openvpn.net,openvpn.com", domain, domain_len));
+    assert_true(ListContainsDomain(L"openvpn.org,openvpn.net,openvpn.com", domain, domain_len));
 
     assert_false(ListContainsDomain(L"openvpn.com", domain, domain_len));
     assert_false(ListContainsDomain(L"internal.openvpn.net", domain, domain_len));
+    assert_false(ListContainsDomain(L"openvpn.com,internal.openvpn.net", domain, domain_len));
+    assert_false(ListContainsDomain(L"internal.openvpn.net,openvpn.com", domain, domain_len));
 }
 
 #define BUF_SIZE 64
 static void
 test_convert_itf_dns_domains(void **state)
 {
-    DWORD size, orig_size, len, res_len;
+    DWORD size, len;
     LSTATUS err;
     const DWORD glyph_size = sizeof(wchar_t);
 
+    /* Remove the domain from a single-entry list */
+    wchar_t domains_0[BUF_SIZE] = L"openvpn.com";
+    len = (DWORD)wcslen(domains_0) + 1;
+    size = len * glyph_size;
+    err = ConvertItfDnsDomains(L"openvpn.com", domains_0, &size, sizeof(domains_0));
+    assert_int_equal(size, 0);
+    assert_int_equal(err, ERROR_FILE_NOT_FOUND);
+
+    /* Remove no domain from a single-entry list */
     wchar_t domains_1[BUF_SIZE] = L"openvpn.com";
     len = (DWORD)wcslen(domains_1) + 1;
-    size = orig_size = len * glyph_size;
-    wchar_t domains_1_res[BUF_SIZE] = L".openvpn.com";
-    res_len = len + 2; /* adds . and \0 */
-    err = ConvertItfDnsDomains(L"openvpn.net", domains_1, &size, BUF_SIZE);
+    size = len * glyph_size;
+    wchar_t domains_1_res[] = L".openvpn.com\0";
+    err = ConvertItfDnsDomains(L"openvpn.net", domains_1, &size, sizeof(domains_1));
     assert_memory_equal(domains_1, domains_1_res, size);
-    assert_int_equal(size, res_len * glyph_size);
+    assert_int_equal(size, sizeof(domains_1_res));
     assert_int_equal(err, NO_ERROR);
 
+    /* Remove the second domain from a two-entry list */
     wchar_t domains_2[BUF_SIZE] = L"openvpn.com,openvpn.net";
     len = (DWORD)wcslen(domains_2) + 1;
-    size = orig_size = len * glyph_size;
-    wchar_t domains_2_res[BUF_SIZE] = L".openvpn.com";
-    res_len = (DWORD)wcslen(domains_2_res) + 2;
-    err = ConvertItfDnsDomains(L"openvpn.net", domains_2, &size, BUF_SIZE);
+    size = len * glyph_size;
+    wchar_t domains_2_res[] = L".openvpn.com\0";
+    err = ConvertItfDnsDomains(L"openvpn.net", domains_2, &size, sizeof(domains_2));
     assert_memory_equal(domains_2, domains_2_res, size);
-    assert_int_equal(size, res_len * glyph_size);
+    assert_int_equal(size, sizeof(domains_2_res));
     assert_int_equal(err, NO_ERROR);
 
+    /* Remove the first domain from a two-entry list */
     wchar_t domains_3[BUF_SIZE] = L"openvpn.com,openvpn.net";
     len = (DWORD)wcslen(domains_3) + 1;
-    size = orig_size = len * glyph_size;
-    wchar_t domains_3_res[BUF_SIZE] = L".openvpn.net";
-    res_len = (DWORD)wcslen(domains_3_res) + 2;
-    err = ConvertItfDnsDomains(L"openvpn.com", domains_3, &size, BUF_SIZE);
+    size = len * glyph_size;
+    wchar_t domains_3_res[] = L".openvpn.net\0";
+    err = ConvertItfDnsDomains(L"openvpn.com", domains_3, &size, sizeof(domains_3));
     assert_memory_equal(domains_3, domains_3_res, size);
-    assert_int_equal(size, res_len * glyph_size);
+    assert_int_equal(size, sizeof(domains_3_res));
     assert_int_equal(err, NO_ERROR);
 
+    /* Remove no domain from a two-entry list */
     wchar_t domains_4[BUF_SIZE] = L"openvpn.com,openvpn.net";
     len = (DWORD)wcslen(domains_4) + 1;
-    size = orig_size = len * glyph_size;
-    wchar_t domains_4_res[BUF_SIZE] = L".openvpn.com\0.openvpn.net";
-    res_len = len + 3; /* adds two . and one \0 */
-    err = ConvertItfDnsDomains(NULL, domains_4, &size, BUF_SIZE);
+    size = len * glyph_size;
+    wchar_t domains_4_res[] = L".openvpn.com\0.openvpn.net\0";
+    err = ConvertItfDnsDomains(NULL, domains_4, &size, sizeof(domains_4));
     assert_memory_equal(domains_4, domains_4_res, size);
-    assert_int_equal(size, res_len * glyph_size);
+    assert_int_equal(size, sizeof(domains_4_res));
     assert_int_equal(err, NO_ERROR);
+
+    /* Remove the first domain from a three-entry list */
+    wchar_t domains_5[BUF_SIZE] = L"openvpn.com,openvpn.net,openvpn.org";
+    len = (DWORD)wcslen(domains_5) + 1;
+    size = len * glyph_size;
+    wchar_t domains_5_res[] = L".openvpn.net\0.openvpn.org\0";
+    err = ConvertItfDnsDomains(L"openvpn.com", domains_5, &size, sizeof(domains_5));
+    assert_memory_equal(domains_5, domains_5_res, size);
+    assert_int_equal(size, sizeof(domains_5_res));
+    assert_int_equal(err, NO_ERROR);
+
+    /* Remove the middle domain from a three-entry list */
+    wchar_t domains_6[BUF_SIZE] = L"openvpn.com,openvpn.net,openvpn.org";
+    len = (DWORD)wcslen(domains_6) + 1;
+    size = len * glyph_size;
+    wchar_t domains_6_res[] = L".openvpn.com\0.openvpn.org\0";
+    err = ConvertItfDnsDomains(L"openvpn.net", domains_6, &size, sizeof(domains_6));
+    assert_memory_equal(domains_6, domains_6_res, size);
+    assert_int_equal(size, sizeof(domains_6_res));
+    assert_int_equal(err, NO_ERROR);
+
+    /* Remove the last domain from a three-entry list */
+    wchar_t domains_7[BUF_SIZE] = L"openvpn.com,openvpn.net,openvpn.org";
+    len = (DWORD)wcslen(domains_7) + 1;
+    size = len * glyph_size;
+    wchar_t domains_7_res[] = L".openvpn.com\0.openvpn.net\0";
+    err = ConvertItfDnsDomains(L"openvpn.org", domains_7, &size, sizeof(domains_7));
+    assert_memory_equal(domains_7, domains_7_res, size);
+    assert_int_equal(size, sizeof(domains_7_res));
+    assert_int_equal(err, NO_ERROR);
+
+    /* Remove the last domain from a four-entry list because of size constraints*/
+    wchar_t domains_8[BUF_SIZE] = L"openvpn.com,openvpn.net,openvpn.org,am-ende-noch-eine-lange.de";
+    len = (DWORD)wcslen(domains_8) + 1;
+    size = len * glyph_size;
+    wchar_t domains_8_res[] = L".openvpn.com\0.openvpn.net\0.openvpn.org\0";
+    err = ConvertItfDnsDomains(NULL, domains_8, &size, sizeof(domains_8));
+    assert_memory_equal(domains_8, domains_8_res, size);
+    assert_int_equal(size, sizeof(domains_8_res));
+    assert_int_equal(err, ERROR_MORE_DATA);
 }
 
 int


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
