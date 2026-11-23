Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD71606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z7K6s88M;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ekFRATH8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CWw9IIvc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=v1RVg0VyVWz44w1fXCXMRkseWYdJPg3L9eUwz0m0vfs=; b=Z7K6s88MkhoQd5
	nuFeM10/S+jY8N3X05NFJ0c7T53NOWzGQ0ZuXjQsXc+OZRiN/epNwt1qPAEL4aBk5mCmPHxgXBfNB
	JmM72LZaavC2g0NjUpPr9/WvbXJf2iqrVqrNgEXlAoDZeOUdh1/MSuYja9IQXNHwRXUI4LuGx4ef8
	XVI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVUPP-000000007aJ-3WOP;
	Mon, 23 Nov 2026 13:48:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVUPO-000000007aD-2lYD for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 13:48:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UogQICnWarntW8xUw7Eb/FPgN0DDWqNeJY3adkxdRgE=; b=ekFRATH8VC5rW3/YOg7D0IpD81
 QleEtZulNjNHHz6Tj1YA/gFBB4Su/4uT1OfCxfdoX8BQqZeAFuB/B6NETphg1oCA3EzNeA8POq6W5
 uQvX+yJYvmfgD83pIk16W1gsC2xoF82cxIGxIZK8NH88CrND4G1d7lVkGMb4EtRLJsy0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UogQICnWarntW8xUw7Eb/FPgN0DDWqNeJY3adkxdRgE=; b=CWw9IIvcm7MnsxsAOPaE7D2SE+
 DdEk7RFBi/NAEWXJXlVJ9VGglbc50SDHhD+dYCNINAwe/AF+SZkw2CzimNDHKfxthsklDHZrL326y
 EcBq55gwrsDcJeD/eVN++QTuS8PwqbjflntliGpbffDuZ7W/VZAFH5/Fp9HPABntUvRg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVUPM-000000003Yv-2edN for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 13:48:38 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ANDmTuI031572
 for <openvpn-devel@lists.sourceforge.net>; Mon, 23 Nov 2026 14:48:29 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANDmTWd031571
 for openvpn-devel@lists.sourceforge.net; Mon, 23 Nov 2026 14:48:29 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 23 Nov 2026 14:48:23 +0100
Message-ID: <20261123134829.31554-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795190994000.I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b@gerrit.openvpn.net>
References: <gerrit.1795190994000.I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVUPM-000000003Yv-2edN
Subject: [Openvpn-devel] [PATCH v2] manage: merge the two multiline flatten
 helpers
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

From: Razvan Cojocaru <razvanc@mailbox.org>

management_query_multiline_flatten_newline() differed only in the
aggregate length and separator; pass those as parameters instead.

Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2232
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2232
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 86c498e..3505d6b 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3905,45 +3905,17 @@
 }
 
 static char *
-/* returns allocated base64 signature */
-management_query_multiline_flatten_newline(struct management *man, const char *b64_data,
-                                           const char *prompt, const char *cmd, int *state,
-                                           struct buffer_list **input)
-{
-    int ok;
-    char *result = NULL;
-
-    ok = management_query_multiline(man, b64_data, prompt, cmd, state);
-    if (ok && buffer_list_defined(*input))
-    {
-        buffer_list_aggregate_separator(*input, 10000, "\n");
-        const struct buffer *buf = buffer_list_peek(*input);
-        if (buf && BLEN(buf) > 0)
-        {
-            result = (char *)malloc(BLENZ(buf) + 1);
-            check_malloc_return(result);
-            memcpy(result, buf->data, BLENZ(buf));
-            result[BLEN(buf)] = '\0';
-        }
-    }
-
-    buffer_list_free(*input);
-    *input = NULL;
-
-    return result;
-}
-
-static char *
-/* returns allocated base64 signature */
+/* returns allocated, flattened multiline input */
 management_query_multiline_flatten(struct management *man, const char *b64_data, const char *prompt,
-                                   const char *cmd, int *state, struct buffer_list **input)
+                                   const char *cmd, int *state, struct buffer_list **input,
+                                   const size_t max_len, const char *sep)
 {
     char *result = NULL;
 
     const int ok = management_query_multiline(man, b64_data, prompt, cmd, state);
     if (ok && buffer_list_defined(*input))
     {
-        buffer_list_aggregate(*input, 2048);
+        buffer_list_aggregate_separator(*input, max_len, sep);
         const struct buffer *buf = buffer_list_peek(*input);
         if (buf && BLEN(buf) > 0)
         {
@@ -3982,7 +3954,7 @@
     }
     char *ret = management_query_multiline_flatten(man, (char *)buf_bptr(&buf_data), prompt, desc,
                                                    &man->connection.ext_key_state,
-                                                   &man->connection.ext_key_input);
+                                                   &man->connection.ext_key_input, 2048, "");
     free_buf(&buf_data);
     return ret;
 }
@@ -3995,10 +3967,9 @@
     buf_write(&buf_prompt, prompt_1, strlen(prompt_1));
     buf_write(&buf_prompt, cert_name, strlen(cert_name) + 1); /* +1 for \0 */
 
-    char *result;
-    result = management_query_multiline_flatten_newline(
+    char *result = management_query_multiline_flatten(
         man, NULL, (char *)buf_bptr(&buf_prompt), "certificate", &man->connection.ext_cert_state,
-        &man->connection.ext_cert_input);
+        &man->connection.ext_cert_input, 10000, "\n");
     free_buf(&buf_prompt);
     return result;
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
