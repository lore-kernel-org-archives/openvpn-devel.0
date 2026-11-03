Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86B606A334
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FFc5X3jD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bPgEdjtG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iHmmaQpa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qSxwvTH8K1iqLMQk6vEd8O8St8zqYtBxT2qMihvImSo=; b=FFc5X3jDI/UXSA
	bgs6cvL2YOjttFPFjXrMHlHuALBBSEnfOFJcOoMfWIqaFUt5dSrWCdWcrlHYL//PQFEq+LeCakHOq
	Up8nml11j6PdP5VftFSPbr0eB0mSp3eXs+PdY71HAFN7jTGMTbMYAt2z0BWF8UAf7YFZoBNLTPc6k
	3Tg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKAZ-000000001CI-1zgd;
	Tue, 03 Nov 2026 19:27:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOKAX-000000001CB-44Uh for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:27:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Je1r2xv4UIWSLFtpcEjmz92vZ0iJg9NNiok3+IcvbjU=; b=bPgEdjtGBoC0EJjBsNtjw4V/Jo
 yLDxatVZ2JelQVVQXA+Hku+qTVwil7Ijf/ODNjMhVobSsSF4WlyvW6Uzby5cN+33/J6oYeNI74QPp
 DWVOVpMAM0fm4Tj1plRjDm+rVSqjG2l9M1rkpa7HK6TiWDhbuewTJFPfqvzlOrAz4O48=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Je1r2xv4UIWSLFtpcEjmz92vZ0iJg9NNiok3+IcvbjU=; b=iHmmaQpada00Ogycwl7QeGuOBz
 dVv54yHzsKHSOdpLY++2KfsX5UjaPIGDQJ2I/epxgF2WeLJ5gVqX0pkoUo3m1X0aQHElS35FaMYZD
 eJn/ZY2deqSZN9pbE9CBhJAIh835t3CoBrv85/1vWP6XcBu7FL0eROxiHU/N+RQGnCO0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOKAW-000000004PU-07EZ for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:27:41 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A3JRXx4013669
 for <openvpn-devel@lists.sourceforge.net>; Tue, 3 Nov 2026 20:27:33 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3JRXIH013668
 for openvpn-devel@lists.sourceforge.net; Tue, 3 Nov 2026 20:27:33 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  3 Nov 2026 20:27:24 +0100
Message-ID: <20261103192732.13656-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
References: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOKAW-000000004PU-07EZ
Subject: [Openvpn-devel] [PATCH v3] Do not look up the "none" cipher in
 OpenSSL
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

From: Drew Blokzyl <drew@linuxkids.com>

cipher_get() hands EVP_CIPHER_fetch() whatever name it is given, and the
callers that only ask whether a cipher exists or which mode it has
(cipher_kt_mode_cbc/ofb_cfb/aead(), cipher_kt_block_size(),
cipher_kt_insecure()) treat NULL as "not that". For the "none" cipher
that is the expected answer, but under OpenSSL 3 the failed fetch also
pushes EVP_R_UNSUPPORTED ("digital envelope routines::unsupported,
Algorithm (none : 0)") onto the thread's error queue, and nothing pops
it.

"none" is what every server without --cipher carries in its
pre-negotiation key_type: the legacy BF-CBC default is not in
--data-ciphers, so do_init_crypto_tls() initialises the key_type with
cipher "none". Each new client instance walks it in init_instance() ->
do_init_crypto_tls() -> cipher_kt_mode_ofb_cfb("none") and in the frame
and OCC calculations, and tls_ctx_reload_crl() runs right after. Before
commit 15a1465f ("Make CRL reload EOF detection independent of stale
error queue entries") that stale entry made the first handshake after a
CRL change log "CRL: cannot read CRL from file" for a CRL it loaded fine
(GitHub #1103); since then the reload reports it at D_LOW as "CRL:
OpenSSL error queue not empty on CRL load" and clears it.

Return NULL for "none" before touching OpenSSL, as cipher_kt_name()
already does. Real cipher names behave as before, and
cipher_valid_reason() still finds the OpenSSL reason on the queue when
it reports an unknown cipher.

Left alone on purpose: cipher_kt_block_size()'s probe for the CBC
sibling of an AEAD cipher (CHACHA20-POLY1305 -> "CHACHA20-CBC") and
md_valid() leave the same kind of entry, but neither runs between
client instance creation and the CRL reload.

With this change the queue is empty when the CRL reload runs for UDP
and TCP clients, and CRL replacements give clean reloads with no
"error queue not empty" report (current master: one per replacement).

Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438
Signed-off-by: Drew Blokzyl <drew@linuxkids.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1950
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1950
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 3c708c2..b7f2ef3 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -569,6 +569,15 @@
 {
     ASSERT(ciphername);
 
+    /* "none" is a valid OpenVPN cipher name that OpenSSL does not know.
+     * Return NULL without asking OpenSSL: a failed EVP_CIPHER_fetch() would
+     * leave an "unsupported" entry on the error queue that the cipher_kt_*()
+     * callers never clear. */
+    if (strcmp("none", ciphername) == 0)
+    {
+        return NULL;
+    }
+
     ciphername = translate_cipher_name_from_openvpn(ciphername);
     return EVP_CIPHER_fetch(NULL, ciphername, NULL);
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
