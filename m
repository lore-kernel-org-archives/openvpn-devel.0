Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62841606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iiKuQxuf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BKhOQwXj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mEjl5pWS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tzJQyNySTg9D7N6gW1jvvKT/C4QjJ74+HC4ebMUkY8g=; b=iiKuQxufcvW1XyJ4AJKjeoZ1t4
	0DtQ3OwxZq176WPTbOqWy7sXlGWo8sVPJV46yyxo83ZTjKDX+6hcfvjtdcQhX8JwHkWag7vu61dHJ
	tmSKmmz8/dgtSr+XBKJlwaoLzj+JsfHIii2WUDFmuBRa01DidOUzBb/NoE81NMMpvEOI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJ9iU-0008I0-EY;
	Tue, 20 Oct 2026 13:17:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xJ9iS-0008Hr-Or
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 13:17:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2oT1IbWF3qddHaq1KeMxNT6S9pjHL2HokAkSxongUgs=; b=BKhOQwXjU2hmug+I6qOf/2Nc/s
 GDwaRIc+g00/rHeQ7jdusKGC8BS6cNSNKIT/1dK5Bo6aobbYQsikKc4q99qCw2qXEbfKADNSxjaA6
 awYE9Hr851kKquxC0WWESrD1b5zJQcTxinXq43nYjLSSghIDm2SttcTwA4oCzGS/GULo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2oT1IbWF3qddHaq1KeMxNT6S9pjHL2HokAkSxongUgs=; b=mEjl5pWS0nOgnVFAKmJICmdX5s
 hQdORN5dJIUJS2sDO4nCLl4+iXm6QhSUZbfum9IGyBu/08YO3UuYsk5UXUdgT/P1F0S2PqG0vz6rE
 TryY+yl8BFN6H4uWP/2eRaQDh+xYUED3J1i3Z30nkfimOM1u5hEMtN0Xnez/djiHWjWM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xJ9iP-0004t2-2r for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 13:17:21 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69KDHAaX024594
 for <openvpn-devel@lists.sourceforge.net>; Tue, 20 Oct 2026 15:17:10 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69KDHAkp024593
 for openvpn-devel@lists.sourceforge.net; Tue, 20 Oct 2026 15:17:10 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 20 Oct 2026 15:17:04 +0200
Message-ID: <20261020131709.24574-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792501753000.Ib99618742929fd96562884d071f3bedc5ca309e4@gerrit.openvpn.net>
References: <gerrit.1792501753000.Ib99618742929fd96562884d071f3bedc5ca309e4@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xJ9iP-0004t2-2r
Subject: [Openvpn-devel] [PATCH v1] test_pkt: Correct comment about which
 systems use ushort sin_family
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Lichtenheld <frank@lichtenheld.com>

I found out due to an unrelated problem that the comment
is wrong. So let's fix it before it confuses the next
person.

Change-Id: Ib99618742929fd96562884d071f3bedc5ca309e4
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2025
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2025
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 51c73d8..fbbb40f 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -579,13 +579,14 @@
 
     struct session_id expected_server_id = { { 0xec, 0xa3, 0xd5, 0xcc, 0xb4, 0x7c, 0xa1, 0xee } };
     /* We have to deal with different structs here annoyingly */
-    /* Linux has an unsigned short int as family_t and this is field is always
+    /* Some systems have an unsigned short int as family_t and the field is always
      * stored in host endianness even though the rest of the struct isn't...,
-     * so Linux little endian differs from all BSD and Linux big endian */
+     * This affects at least Linux, Windows, and OpenIndiana.
+     */
     if (sizeof(addr.addr.in4.sin_family) == sizeof(unsigned short int) && ntohs(AF_INET) != AF_INET)
     {
-        struct session_id linuxle = { { 0x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, 0x85, 0x12 } };
-        expected_server_id = linuxle;
+        struct session_id short_le = { { 0x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, 0x85, 0x12 } };
+        expected_server_id = short_le;
     }
     assert_memory_equal(expected_server_id.id, server_id.id, SID_SIZE);
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
