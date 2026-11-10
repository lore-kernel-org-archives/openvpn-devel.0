Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B24606A32A
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DIEhugKd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jj14vu6l;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bFbOx2es
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2Z4XaUBz7dNxMDE58VHBnzWRgrUi0+1DBKdsesAn8mE=; b=DIEhugKd1w/2xB
	5ZsOkwxpGeRO4oB1DZWPosoC30pasIe7Sdwog9M0ZpuTg7QFLhbYPU4V5/LUpBh+kYBtZonqFNlGG
	ARwaSLTAlmWvVQjDjYJ9PazrD9+H9UABTepbJAFyUA8EjZvLrigka7DXWAzniu3CWKDZWlpSq6kX2
	KiA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQkUr-000000000bs-06l0;
	Tue, 10 Nov 2026 11:58:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xQkUm-000000000bP-2hcs for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:58:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OYZM0HM2hY1pSi1agBag/Kk88rB4daG/VyHLOrO/gng=; b=jj14vu6lIeujqYkrWcWafrKnpv
 94UytxrKOmfP+b0I7Om7bKV1tCVk+ZDPNdBN9CyippaJvNGnLNGNlvBdQAgIMwCq3Jm5ONKHoy9D4
 VlefxM0oZfm2vwlSj5FnRjKXauVVutS8STvy8XvIT1ks/y52CWebl0KfVppYsdVjCtsc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OYZM0HM2hY1pSi1agBag/Kk88rB4daG/VyHLOrO/gng=; b=bFbOx2esyyhvTKta1TQlbBScVn
 rsCqUQkGuRBFaL6slueFvCbg8V9LGZOA+/J0cQmtgkaEGhjIzTK8yPNXZohuJUclbOMdlzd7B0g0n
 ilHo2XG8TzZHPn1qchxNaxbxoM7/+4si/72zbrTHy/z+eL9zzs3qFUXSzBgdQgSb183s=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQkUk-0000000052Z-36QW for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:58:36 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AABwR5P001661
 for <openvpn-devel@lists.sourceforge.net>; Tue, 10 Nov 2026 12:58:27 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AABwRwk001660
 for openvpn-devel@lists.sourceforge.net; Tue, 10 Nov 2026 12:58:27 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 12:58:22 +0100
Message-ID: <20261110115827.1649-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
References: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xQkUk-0000000052Z-36QW
Subject: [Openvpn-devel] [PATCH v6] tls: reject incoming reneg request if
 primary key is not fully valid
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

From: Ralf Lici <ralf@mandelbit.com>

Incoming P_CONTROL_SOFT_RESET_V1 can arrive while the active key is not
yet fully valid for renegotiation. This includes the window where we are
still waiting for auth_deferred_expire (derived from handshake/reneg
timing), as well as cases where deferred or mid-session auth later
leaves the key non-authenticated even though state is S_GENERATED_KEYS.

This patch keeps read_control_auth as the first gate, then rejects the
incoming renegotiation requests unless the primary key is KS_AUTH_TRUE
and auth_deferred_expire has passed.

The rejected request is not counted as a TLS error, since soft TLS
errors trigger an instance restart in TCP mode.

Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1478
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1478
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 420daef..54223da 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3951,6 +3951,21 @@
                 goto error;
             }
 
+            /*
+             * Do not allow incoming renegotiation unless our primary key is
+             * fully authenticated and past the deferred-auth/transition gate.
+             */
+            time_t auth_deferred_left = ks->auth_deferred_expire - now;
+            if (ks->authenticated != KS_AUTH_TRUE || auth_deferred_left > 0)
+            {
+                msg(D_TLS_ERRORS,
+                    "TLS: refusing premature incoming renegotiation request for key-id %d: "
+                    "auth=%s, auth_deferred_expire in %d seconds",
+                    ks->key_id, ks_auth_name(ks->authenticated),
+                    auth_deferred_left > 0 ? (int)auth_deferred_left : 0);
+                goto done;
+            }
+
             key_state_soft_reset(session, NULL);
 
             dmsg(D_TLS_DEBUG, "TLS: received P_CONTROL_SOFT_RESET_V1 s=%d sid=%s", i,


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
