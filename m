Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10F606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=inMKeXWP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dnK8KpKC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W6ByHlY5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NciJNDna5rk1eLGHN3ZdYAJtM/yVZPI9i+tfnjGi48o=; b=inMKeXWP+a4/b1
	e/cCn8DKPZSmyjxg8fTnuAsncVRaklEg1Mipa3d1lSooPxfpmDYM/IaQ6nl34sHCUAErerraF+Kgg
	BvgaWWz5AMMYcrVjuYmwcqeeyGXbwuHEIzd9qnv64oonA0JNCr8X69pUpU8fSiX2Fe2NtSohvhRs5
	2PE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQl66-000000001dJ-2Zr3;
	Tue, 10 Nov 2026 12:37:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xQl65-000000001dD-1H06 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:37:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CpERbxW2My/+7fODDn23CK7qQQEjrfA47yC2vxBycW4=; b=dnK8KpKCdW4aynaE2YxoU2OFox
 vyUfkwXgLda7IbXNyWIPFwJVthj+GdG2BEx5yW4r4EB8E7fixOoi/WuX8IuYbY5a9UvNa3UKBuj1N
 p7EQ8Y7qvKaSM1ow3nW0yYNqhUI0EuY9aKLZKNyR7SykXCMp7SNIgjo2sLFFiRxY1tJw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CpERbxW2My/+7fODDn23CK7qQQEjrfA47yC2vxBycW4=; b=W6ByHlY5+AP1qBd08Xoz8bC7CL
 uuKZOcHCS6KpMVA3stwoIFJQP2DwI++nHhofNWUajQrO8xL6AMy9S6iGh2X2y23nSjQyNvR0Z9Xhe
 DMxsy9yLyJMgW//cNPTSkHj0NLCBYDPSDoxsm+7ZV3Ejwcg/IzQ0V4czXfvkujqMl+ig=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQl62-000000005k9-1rwO for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:37:09 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AACaxCQ004695
 for <openvpn-devel@lists.sourceforge.net>; Tue, 10 Nov 2026 13:36:59 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AACaxbr004694
 for openvpn-devel@lists.sourceforge.net; Tue, 10 Nov 2026 13:36:59 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 13:36:53 +0100
Message-ID: <20261110123659.4683-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794313546000.Ie2d784272184261a62c848e6ad3b7a4570ae6dc7@gerrit.openvpn.net>
References: <gerrit.1794313546000.Ie2d784272184261a62c848e6ad3b7a4570ae6dc7@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xQl62-000000005k9-1rwO
Subject: [Openvpn-devel] [PATCH v1] buffer: Change return type of
 buf_forward_capacity_total to size_t
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

From: Frank Lichtenheld <frank@lichtenheld.com>

All callers already want a size_t, so make the
conversion implicit.

Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2165
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2165
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 5f21de8..a4e2809 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -275,7 +275,7 @@
     if (buf_forward_capacity(buf) <= 1)
     {
         size_t len = strlen(str) + 1;
-        if (buf_size_valid(len) && (int)len < buf_forward_capacity_total(buf))
+        if (buf_size_valid(len) && len < buf_forward_capacity_total(buf))
         {
             memcpy(buf->data + buf->capacity - len, str, len);
         }
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index ede3066..ae6dcb7 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1068,7 +1068,7 @@
  *
  * @return Capacity minus offset, or 0 if \c buf is invalid.
  */
-static inline int
+static inline size_t
 buf_forward_capacity_total(const struct buffer *buf)
 {
     if (buf_valid(buf))
@@ -1078,7 +1078,7 @@
         {
             ret = 0;
         }
-        return ret;
+        return (size_t)ret;
     }
     else
     {
diff --git a/tests/unit_tests/openvpn/test_dhcp.c b/tests/unit_tests/openvpn/test_dhcp.c
index e331d3d..3a84e1e 100644
--- a/tests/unit_tests/openvpn/test_dhcp.c
+++ b/tests/unit_tests/openvpn/test_dhcp.c
@@ -50,11 +50,6 @@
     return "dummy";
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static void
 test_write_dhcp_search_str(void **state)
 {
@@ -146,10 +141,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 main(void)
 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
