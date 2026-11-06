Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2145D606A32C
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TNBEmvjV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WJVootav;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FYa28rIY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Klg7fm7gAk/awtGjaFON4PRE1iGr0TpI+rnL3B6N4qg=; b=TNBEmvjVaG9YeR
	TjnErgVSPqC2I3+8w8z/k5os0iBBm/nw7ldgoOrutwdl9S6qSR8Ose0PkoT8iRJRDE4YfGu/3qdzY
	uZ3jedYkDTIYMO066qxjBW/BzAeSz9AmlufzWDwqbkag2uIZ9jNlhN8u1Vjt+giwQ9sNSxiOfRpIW
	zDM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPJWC-000000006a4-1ZM2;
	Fri, 06 Nov 2026 12:58:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xPJWB-000000006Zv-2nUE for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 12:58:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=felU8o3aVy4aldhOsPipRtOzzSZIO1sWCjl1sZql39g=; b=WJVootavixuzHtGIDezJN+dBkO
 E+xZs70lrxthWDuj1i++8JWXvKauxeegONRA1JgBgN1ZbvyMmeTyHQmX9YDVMx03Z0g7lV8rc6tVw
 EirFuu29jcsAeHoUrqnEFgK7/zaaoP0XbijJ05w0xecWuzI3whFYk7A0djF+fchgzPv4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=felU8o3aVy4aldhOsPipRtOzzSZIO1sWCjl1sZql39g=; b=FYa28rIY1pj/+1bPMsimFPWhyN
 tKUSSFQdD/ABx+Dlnh8KiBsXgVlVpFD6Umus5lKrc+OiwmkZS0v+Lj5HJA+s95prN0NB43Q4kq0Hs
 LOaLbp73whzRkYDBsH3rIAb1sSJRnJP85RVj19kh37/KtOEbZXSxS6Z3xRJZfaFl/vgY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xPJW8-000000005r6-1jAU for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 12:58:07 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A6Cvvw2014732
 for <openvpn-devel@lists.sourceforge.net>; Fri, 6 Nov 2026 13:57:57 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A6Cvve8014731
 for openvpn-devel@lists.sourceforge.net; Fri, 6 Nov 2026 13:57:57 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  6 Nov 2026 13:57:50 +0100
Message-ID: <20261106125757.14721-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793947607000.I784f3ffe17ecadabf96caad11fe9f774aa00b7cc@gerrit.openvpn.net>
References: <gerrit.1793947607000.I784f3ffe17ecadabf96caad11fe9f774aa00b7cc@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xPJW8-000000005r6-1jAU
Subject: [Openvpn-devel] [PATCH v1] comp: use the wire byte when escaping v2
 uncompressed packets
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

compv2_escape_data_ifneeded() wrote COMP_ALGV2_UNCOMPRESSED (the
algorithm id, 10) instead of COMP_ALGV2_UNCOMPRESSED_BYTE (0) after
the 0x50 indicator. Receivers reject that header, so packets whose
first byte is 0x50 were dropped with stub-v2 and lz4-v2, e.g. tap
frames to a MAC address starting with 0x50.

Broken since a75bb2e4 ("Implement the compression V2 data format for
stub and lz4.").

Change-Id: I784f3ffe17ecadabf96caad11fe9f774aa00b7cc
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2142
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2142
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 387a7c4..513a766 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -100,7 +100,7 @@
 
     head = BPTR(buf);
     head[0] = COMP_ALGV2_INDICATOR_BYTE;
-    head[1] = COMP_ALGV2_UNCOMPRESSED;
+    head[1] = COMP_ALGV2_UNCOMPRESSED_BYTE;
 }
 
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
