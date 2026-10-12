Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061D9CA9ED0
	for <openvpn-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+4U8o7A0HQCEp7K7afJOlZw/ulqb5ij+tHZQRjrYEBU=; b=FPGXhjIeim1fugTQMGrHuzEF1h
	odxR3RSKt+RB84pg0kE1RBxvNXyMkZQkY6bTCvuI2FTomJ8RGG+8QI5MShcTpZexgkDMlX7rAolXO
	NuEFM9mJNoHY6CTzA1YKQYRgYv1CS0bE388A2OSWii1wR40hFWTJxEQaAwZ50z6B+FfQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGDFo-0008Hg-G6;
	Mon, 12 Oct 2026 10:27:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xGDFW-0008HL-6D
 for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 10:27:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lcuga+tjJGsxwloRF+N+Kf0dhgUd1X8H1hf9gNWk6ls=; b=juQ+Vt6b/u8+nPrUN6O8grLs55
 A4QFQpwIPXUSPI9lf/J39sPph2mGfkrFfrhcwYXyHaWVood8afLKR5GjCY94HpSaw+PB8n3XfZ8Zx
 A0saGoMWp+Fbl/qs+YjHp3+OONBFgESU4mvNztbvU4kOAGHD2fK4uKSwNNmaU/MwvQpA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Lcuga+tjJGsxwloRF+N+Kf0dhgUd1X8H1hf9gNWk6ls=; b=dxwt3196d666NXxUgf+cAuTorO
 2BKaiUN5slPN/LnssDJdw0io3QbmT3f2B8U+l60bJ2te5KWPo3z3x9J1RffcsxbQN3X1RCcWjFwg2
 jmnhtfiJu85kSfelUXh485gY7FLlSbzCy7VDxJH0sz+8XdqTGEzxlUoYoPDUFzJ9bOtc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGDFJ-0007G4-K1 for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 10:27:06 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69CAQwLp013629
 for <openvpn-devel@lists.sourceforge.net>; Mon, 12 Oct 2026 12:26:58 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69CAQwMt013628
 for openvpn-devel@lists.sourceforge.net; Mon, 12 Oct 2026 12:26:58 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 12 Oct 2026 12:26:47 +0200
Message-ID: <20261012102657.13611-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1791790522000.Ib74788b0365f6b44383ce09cf7d4914bbe500f8a@gerrit.openvpn.net>
References: <gerrit.1791790522000.Ib74788b0365f6b44383ce09cf7d4914bbe500f8a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xGDFJ-0007G4-K1
Subject: [Openvpn-devel] [PATCH v1] Make CRL reload EOF detection
 independent of stale error queue entries
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

From: Drew Blokzyl <drew@linuxkids.com>

backend_tls_ctx_reload_crl() treats a NULL from PEM_read_bio_X509_CRL()
as EOF when ERR_peek_error() shows PEM_R_NO_START_LINE. ERR_peek_error()
returns the OLDEST queued error, so any entry left behind earlier in the
thread turns a clean EOF into a "CRL: cannot read CRL from file" warning,
prints the unrelated errors as if they came from the CRL file, and still
installs the CRLs already parsed. The previous commit removes the
leftover that triggered this in practice; this one stops the loop from
depending on the queue being clean at all.

If the queue is not empty when the CRL is loaded, say so at D_LOW with
the queued errors, since that is a bug somewhere else worth seeing, then
start the loop from an empty queue so only errors raised by
PEM_read_bio_X509_CRL() are visible. Test the error it raised last
rather than the oldest one, and clear the queue on the EOF path instead
of popping a single entry.

Change-Id: Ib74788b0365f6b44383ce09cf7d4914bbe500f8a
Signed-off-by: Drew Blokzyl <drew@linuxkids.com>
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1990
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1990
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b88e1d9..96e90f82 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1360,6 +1360,19 @@
     }
 
     int num_crls_loaded = 0;
+    /*
+     * The EOF test below must only see errors raised by
+     * PEM_read_bio_X509_CRL(). Anything already queued was left by an
+     * earlier operation in this thread and would otherwise be what
+     * ERR_peek_error() returns, turning a clean EOF into "cannot read CRL".
+     * Report it, since that is a bug elsewhere, then start from an empty
+     * queue (crypto_msg() drains the queue while printing it).
+     */
+    if (ERR_peek_error() != 0)
+    {
+        crypto_msg(D_LOW, "CRL: OpenSSL error queue not empty on CRL load");
+    }
+    ERR_clear_error();
     while (true)
     {
         X509_CRL *crl = PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
@@ -1367,13 +1380,15 @@
         {
             /*
              * PEM_R_NO_START_LINE can be considered equivalent to EOF.
+             * ERR_peek_last_error() is the error PEM_read_bio_X509_CRL()
+             * raised last; ERR_peek_error() would be the oldest queued one.
              */
-            bool eof = ERR_GET_REASON(ERR_peek_error()) == PEM_R_NO_START_LINE;
+            bool eof = ERR_GET_REASON(ERR_peek_last_error()) == PEM_R_NO_START_LINE;
             /* but warn if no CRLs have been loaded */
             if (num_crls_loaded > 0 && eof)
             {
                 /* remove that error from error stack */
-                (void)ERR_get_error();
+                ERR_clear_error();
                 break;
             }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
