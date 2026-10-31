Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F221606A31C
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hmwrkmID;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GHgKHMOt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Uq0pQUMx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rpX2bCbIWgydgoJURJs6RdOjw1hAXyokWU3bOJOApnA=; b=hmwrkmID1wWZOX
	sw3UUBM7SnDdAjYDsNy1bJvoC0VFiKxfe7x9pl3v4X/RMPplfaHAOPp3aA9oHpl4FBjF703Hk7nzd
	nu86RDPbb/GgW/yeq5Yvz3miiqywLiSIHAC3kmjxaKcapWlkXtIa4aGGV6JECMHWNP79MAwXZRI/u
	+Q8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNI01-000000000oF-1usZ;
	Sat, 31 Oct 2026 22:56:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNHzz-000000000la-3cyo for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 22:56:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9MLDqBGlypKCVuNAZyrT/gW0unbNo1C4boAe3AiJMU0=; b=GHgKHMOtmcJAtCr+52NSHVzhum
 nU/36CcLkxRvPfm+R93ySTNWfs+Ofvhq+05DAVzjYGIqdT7qIFHt7RCcfGV0xyy8O8qTLMuzZp2CF
 8rkl3qHeQ5tuK9dgQQIjt+FZPH2Qt4/saoz40UO8Cqd+p499rGVTKwTJxD0Wu0huMvK0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9MLDqBGlypKCVuNAZyrT/gW0unbNo1C4boAe3AiJMU0=; b=Uq0pQUMxAjlubKi0HpnV1JeBfe
 D97zSFhIgvIT3qPL4bD3jH+fO0zlMJON7nCarosmn81v5AiW1tWyhAsHJDx+d8hpDR514FgKzUT4C
 lhcELQiXkc9SGpXAZWKrnFkJMnC8KGx6MzmyUgGDOneAFJKZg+AewtTQfBRoAH3ytcQY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNHzq-000000002Tr-3SXu for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 22:56:24 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69VMuFq5018631
 for <openvpn-devel@lists.sourceforge.net>; Sat, 31 Oct 2026 23:56:15 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69VMuF36018628
 for openvpn-devel@lists.sourceforge.net; Sat, 31 Oct 2026 23:56:15 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 31 Oct 2026 23:56:09 +0100
Message-ID: <20261031225615.18613-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792329007000.Id21a6b106c49d6647783e09a506add0726a1a6d2@gerrit.openvpn.net>
References: <gerrit.1792329007000.Id21a6b106c49d6647783e09a506add0726a1a6d2@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNHzq-000000002Tr-3SXu
Subject: [Openvpn-devel] [PATCH v2] openvpnserv: skip conversion of empty
 domain names
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Heiko Hund <heiko@ist.eigentlich.net>

Empty entries in an interface's comma separated domain list, were
converted to "." in the resulting MULTI_SZ and used as a match all
in the resulting NRPT rules, so all DNS queries would be sent
to that adapter's name server(s) instead of only the ones for its
domains. Such lists are not expected to be found in the registry,
but skip empty entries anyway, just to be sure.

Also rework the ConvertItfDnsDomains() unit tests to use a helper
that runs the conversion on an individually sized heap buffer with
everything after the input poisoned. This detects terminators that
are counted but not written, which zero-initialized stack buffers
hid. Also add more tests for empty entries and buffer size boundaries.

Bonus: fix typo in related doxygen comment.

Reported-by: Marc Heuse <marc@srlabs.de>
Change-Id: Id21a6b106c49d6647783e09a506add0726a1a6d2
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2016
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2016
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ed163a4..1a441ec 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2272,6 +2272,7 @@
  * In case of an error \p size is set to 0 and the contents of \p domains
  * are invalid.
  * Note that domains are deleted from the string if they match a search domain.
+ * Empty entries (e.g. from leading, trailing or double commas) are skipped.
  *
  * @param[in]     search_domains  optional string of comma separated search domains
  * @param[in,out] domains         buffer that contains the input comma-separated
@@ -2313,7 +2314,7 @@
         PWCHAR comma = wcschr(domain, L',');
         size_t domain_len = comma ? (size_t)(comma - domain) : wcslen(domain);
 
-        if (ListContainsDomain(search_domains, domain, domain_len))
+        if (domain_len == 0 || ListContainsDomain(search_domains, domain, domain_len))
         {
             /* Skip this domain */
             domain = comma ? comma + 1 : domain + domain_len;
@@ -2366,7 +2367,7 @@
 /**
  * Return interface specific domain suffix(es)
  *
- * The \p domains paramter will be set to a MULTI_SZ domains string.
+ * The \p domains parameter will be set to a MULTI_SZ domains string.
  * In case of an error or if no domains are found for the interface
  * \p size is set to 0 and the contents of \p domains are invalid.
  * Note that the domains could have been set by DHCP or manually.
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv.c b/tests/unit_tests/openvpnserv/test_openvpnserv.c
index 4ca715b..a99a6f1 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnserv.c
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv.c
@@ -56,101 +56,102 @@
     assert_false(ListContainsDomain(L"internal.openvpn.net,openvpn.com", domain, domain_len));
 }
 
+/*
+ * Run ConvertItfDnsDomains() on a heap buffer of exactly capacity bytes,
+ * so that ASAN can detect overruns, with everything after the input string
+ * poisoned, so that terminators which are counted but not written show.
+ */
+static void
+check_convert(PCWSTR search_domains, PCWSTR input, DWORD capacity,
+              LSTATUS expected_err, PCWSTR expected)
+{
+    const DWORD glyph_size = sizeof(wchar_t);
+
+    /* Size of the expected MULTI_SZ including both terminators, or 0 */
+    DWORD expected_size = 0;
+    if (expected)
+    {
+        PCWSTR end = expected;
+        while (*end)
+        {
+            end += wcslen(end) + 1;
+        }
+        expected_size = (DWORD)(end - expected + 1) * glyph_size;
+    }
+
+    DWORD size = (DWORD)(wcslen(input) + 1) * glyph_size;
+    assert_true(size <= capacity);
+
+    wchar_t *domains = malloc(capacity);
+    assert_non_null(domains);
+    memset(domains, 0x41, capacity);
+    memcpy(domains, input, size);
+
+    LSTATUS err = ConvertItfDnsDomains(search_domains, domains, &size, capacity);
+    assert_int_equal(err, expected_err);
+    assert_int_equal(size, expected_size);
+    if (expected_size)
+    {
+        assert_memory_equal(domains, expected, expected_size);
+    }
+    free(domains);
+}
+
 #define BUF_SIZE 64
 static void
 test_convert_itf_dns_domains(void **state)
 {
-    DWORD size, len;
-    LSTATUS err;
     const DWORD glyph_size = sizeof(wchar_t);
+    const DWORD cap = BUF_SIZE * glyph_size;
 
     /* Remove the domain from a single-entry list */
-    wchar_t domains_0[BUF_SIZE] = L"openvpn.com";
-    len = (DWORD)wcslen(domains_0) + 1;
-    size = len * glyph_size;
-    err = ConvertItfDnsDomains(L"openvpn.com", domains_0, &size, sizeof(domains_0));
-    assert_int_equal(size, 0);
-    assert_int_equal(err, ERROR_FILE_NOT_FOUND);
+    check_convert(L"openvpn.com", L"openvpn.com", cap, ERROR_FILE_NOT_FOUND, NULL);
 
     /* Remove no domain from a single-entry list */
-    wchar_t domains_1[BUF_SIZE] = L"openvpn.com";
-    len = (DWORD)wcslen(domains_1) + 1;
-    size = len * glyph_size;
-    wchar_t domains_1_res[] = L".openvpn.com\0";
-    err = ConvertItfDnsDomains(L"openvpn.net", domains_1, &size, sizeof(domains_1));
-    assert_memory_equal(domains_1, domains_1_res, size);
-    assert_int_equal(size, sizeof(domains_1_res));
-    assert_int_equal(err, NO_ERROR);
+    check_convert(L"openvpn.net", L"openvpn.com", cap, NO_ERROR, L".openvpn.com\0");
 
     /* Remove the second domain from a two-entry list */
-    wchar_t domains_2[BUF_SIZE] = L"openvpn.com,openvpn.net";
-    len = (DWORD)wcslen(domains_2) + 1;
-    size = len * glyph_size;
-    wchar_t domains_2_res[] = L".openvpn.com\0";
-    err = ConvertItfDnsDomains(L"openvpn.net", domains_2, &size, sizeof(domains_2));
-    assert_memory_equal(domains_2, domains_2_res, size);
-    assert_int_equal(size, sizeof(domains_2_res));
-    assert_int_equal(err, NO_ERROR);
+    check_convert(L"openvpn.net", L"openvpn.com,openvpn.net", cap, NO_ERROR, L".openvpn.com\0");
 
     /* Remove the first domain from a two-entry list */
-    wchar_t domains_3[BUF_SIZE] = L"openvpn.com,openvpn.net";
-    len = (DWORD)wcslen(domains_3) + 1;
-    size = len * glyph_size;
-    wchar_t domains_3_res[] = L".openvpn.net\0";
-    err = ConvertItfDnsDomains(L"openvpn.com", domains_3, &size, sizeof(domains_3));
-    assert_memory_equal(domains_3, domains_3_res, size);
-    assert_int_equal(size, sizeof(domains_3_res));
-    assert_int_equal(err, NO_ERROR);
+    check_convert(L"openvpn.com", L"openvpn.com,openvpn.net", cap, NO_ERROR, L".openvpn.net\0");
 
     /* Remove no domain from a two-entry list */
-    wchar_t domains_4[BUF_SIZE] = L"openvpn.com,openvpn.net";
-    len = (DWORD)wcslen(domains_4) + 1;
-    size = len * glyph_size;
-    wchar_t domains_4_res[] = L".openvpn.com\0.openvpn.net\0";
-    err = ConvertItfDnsDomains(NULL, domains_4, &size, sizeof(domains_4));
-    assert_memory_equal(domains_4, domains_4_res, size);
-    assert_int_equal(size, sizeof(domains_4_res));
-    assert_int_equal(err, NO_ERROR);
+    check_convert(NULL, L"openvpn.com,openvpn.net", cap, NO_ERROR, L".openvpn.com\0.openvpn.net\0");
 
     /* Remove the first domain from a three-entry list */
-    wchar_t domains_5[BUF_SIZE] = L"openvpn.com,openvpn.net,openvpn.org";
-    len = (DWORD)wcslen(domains_5) + 1;
-    size = len * glyph_size;
-    wchar_t domains_5_res[] = L".openvpn.net\0.openvpn.org\0";
-    err = ConvertItfDnsDomains(L"openvpn.com", domains_5, &size, sizeof(domains_5));
-    assert_memory_equal(domains_5, domains_5_res, size);
-    assert_int_equal(size, sizeof(domains_5_res));
-    assert_int_equal(err, NO_ERROR);
+    check_convert(L"openvpn.com", L"openvpn.com,openvpn.net,openvpn.org", cap, NO_ERROR,
+                  L".openvpn.net\0.openvpn.org\0");
 
     /* Remove the middle domain from a three-entry list */
-    wchar_t domains_6[BUF_SIZE] = L"openvpn.com,openvpn.net,openvpn.org";
-    len = (DWORD)wcslen(domains_6) + 1;
-    size = len * glyph_size;
-    wchar_t domains_6_res[] = L".openvpn.com\0.openvpn.org\0";
-    err = ConvertItfDnsDomains(L"openvpn.net", domains_6, &size, sizeof(domains_6));
-    assert_memory_equal(domains_6, domains_6_res, size);
-    assert_int_equal(size, sizeof(domains_6_res));
-    assert_int_equal(err, NO_ERROR);
+    check_convert(L"openvpn.net", L"openvpn.com,openvpn.net,openvpn.org", cap, NO_ERROR,
+                  L".openvpn.com\0.openvpn.org\0");
 
     /* Remove the last domain from a three-entry list */
-    wchar_t domains_7[BUF_SIZE] = L"openvpn.com,openvpn.net,openvpn.org";
-    len = (DWORD)wcslen(domains_7) + 1;
-    size = len * glyph_size;
-    wchar_t domains_7_res[] = L".openvpn.com\0.openvpn.net\0";
-    err = ConvertItfDnsDomains(L"openvpn.org", domains_7, &size, sizeof(domains_7));
-    assert_memory_equal(domains_7, domains_7_res, size);
-    assert_int_equal(size, sizeof(domains_7_res));
-    assert_int_equal(err, NO_ERROR);
+    check_convert(L"openvpn.org", L"openvpn.com,openvpn.net,openvpn.org", cap, NO_ERROR,
+                  L".openvpn.com\0.openvpn.net\0");
 
-    /* Remove the last domain from a four-entry list because of size constraints*/
-    wchar_t domains_8[BUF_SIZE] = L"openvpn.com,openvpn.net,openvpn.org,am-ende-noch-eine-lange.de";
-    len = (DWORD)wcslen(domains_8) + 1;
-    size = len * glyph_size;
-    wchar_t domains_8_res[] = L".openvpn.com\0.openvpn.net\0.openvpn.org\0";
-    err = ConvertItfDnsDomains(NULL, domains_8, &size, sizeof(domains_8));
-    assert_memory_equal(domains_8, domains_8_res, size);
-    assert_int_equal(size, sizeof(domains_8_res));
-    assert_int_equal(err, ERROR_MORE_DATA);
+    /* Empty entries are skipped */
+    check_convert(NULL, L",a.com", cap, NO_ERROR, L".a.com\0");
+    check_convert(NULL, L"a.com,", cap, NO_ERROR, L".a.com\0");
+    check_convert(NULL, L"a.com,,b.com", cap, NO_ERROR, L".a.com\0.b.com\0");
+    check_convert(L"a.com", L",a.com,", cap, ERROR_FILE_NOT_FOUND, NULL);
+    check_convert(NULL, L",,,", cap, ERROR_FILE_NOT_FOUND, NULL);
+    check_convert(NULL, L"", cap, ERROR_FILE_NOT_FOUND, NULL);
+
+    /* Size is 0 if all domains are removed */
+    check_convert(L"a.com,b.com", L"b.com,a.com", cap, ERROR_FILE_NOT_FOUND, NULL);
+
+    /* Output exactly fills the buffer: 2 * (dot + 5 + NUL) + NUL */
+    check_convert(NULL, L"a.com,b.com", 15 * glyph_size, NO_ERROR, L".a.com\0.b.com\0");
+
+    /* Remove the last domain from a four-entry list because of size constraints,
+     * all four would need 3 * 13 + 28 + 1 = 68 glyphs, the buffer is one glyph short */
+    check_convert(NULL, L"openvpn.com,openvpn.net,openvpn.org,am-ende-noch-eine-lange.de",
+                  67 * glyph_size, ERROR_MORE_DATA, L".openvpn.com\0.openvpn.net\0.openvpn.org\0");
+
+    /* Input fills the buffer, no space for dot and terminators */
+    check_convert(NULL, L"a.com", 6 * glyph_size, ERROR_MORE_DATA, NULL);
 }
 
 static void


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
