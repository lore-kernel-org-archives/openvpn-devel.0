Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB72CD8CB9
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bD06jgc+ArpEAhhqXVYQ5kCpku6Y+XC0bu1hjUi4UeE=; b=fLFVpPe3k8ldt/ZRKdvJQJw/f1
	Rzwk4SZIELZJMUQRXUEwnVuOCP9EHERDSGvLSx0TGnLAkClDtuaLLzyWR/v00AM5oNfBrSyHjrFBL
	5ul8jp0OpaTRWLoBegcMm2aR4nOaLFPEJeLm1jtGxuO3Weg1gCmOQ4f7J1F8W85HpavI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxIp-0005P9-J0;
	Tue, 09 Jun 2026 14:19:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wWxIn-0005Os-IF
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:19:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G5Xcgl6XqC++o8CaxxkzZuS2cneGU5OlFaWEl1o9r2E=; b=NC+ew0V5p9Szp4qCjkHiWXUZRQ
 V1DTuwvP+VYHBxaaMJF4rJtg0V6gbR4Fk6BkcYNQPHDsJ6nKQRYGG7xXwPaJYboUkwWYAEmIxGQmt
 xjKP+qIRHevdxWba3vmL0yzYx9wnNK6Y4bU3i7ooGn0qyFa/JhKgMOEA1nSR59TCzFiA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G5Xcgl6XqC++o8CaxxkzZuS2cneGU5OlFaWEl1o9r2E=; b=Cu7w3fP9jUsQaPN26K/EVQbIaO
 LehO5m6Pyj+QABxwGoaRbYjHVnvvHrN2m8dy8vz9/2x9p2KUSgG5SkZZ0eicNuOodRi3f0WmlBs4O
 Ommuatz3z0nFT47Q6M1rSFNlfUxo8UPtSHd5MBM+K6ALfHQW1c2ScsQQhXkcM05MrYPo=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWxIj-00014z-HX for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:19:38 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 659AO82O032620
 for <openvpn-devel@lists.sourceforge.net>; Tue, 9 Jun 2026 12:24:08 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 659AO8tQ032619
 for openvpn-devel@lists.sourceforge.net; Tue, 9 Jun 2026 12:24:08 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  9 Jun 2026 12:24:01 +0200
Message-ID: <20260609102407.32590-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1779381787000.I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5@gerrit.openvpn.net>
References: <gerrit.1779381787000.I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wWxIj-00014z-HX
Subject: [Openvpn-devel] [PATCH v1] Null-terminate tls-crypt client keys
 when testing
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

From: Max Fillinger <maximilian.fillinger@sentyron.com>

After generating a tls-crypt-v2 client key, OpenVPN will try to load the
generated key to verify that it was generated correctly. If the client
key is not written to disk but printed out on the command line, the PEM
encoded key is stored in memory and read_pem_key_file is called with
key_file_inline = true. However, this key is not a null-terminated
string, so we end up calling strlen on a buffer that isn't
null-terminated.

This commit adds a null-byte at the end of the key.

Change-Id: I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5
Signed-off-by: Max Fillinger <maximilian.fillinger@sentyron.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1701
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1701
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index e91f80c..8c3d722 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -758,9 +758,10 @@
 
     if (!filename || streq(filename, ""))
     {
-        printf("%.*s\n", BLEN(&client_key_pem), BPTR(&client_key_pem));
+        buf_null_terminate(&client_key_pem);
         client_file = (const char *)BPTR(&client_key_pem);
         client_inline = true;
+        printf("%s\n", client_file);
     }
     else if (!buffer_write_file(filename, &client_key_pem))
     {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
