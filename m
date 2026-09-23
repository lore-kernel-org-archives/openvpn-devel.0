Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F296BC9830B
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MWYdAqgUhECtSHFPPEmkFMOjhHfOvU5qqrOJbw2i2K0=; b=XzAk4LK9QMg9e8IKKxJtrU6ub6
	4JigVQnSPYMjx9UsAZGX+oWylvcemVQi4uQ62WVNO0xhZSJhkMxx5UXGLVFa/a515tlgsR1f1nVJ6
	Cl+LAY+U9S6omSc/CGWdHoEId/w6jkJZ03fxucjRt3HdHbQo3pbwEMlvkLOkQMt+MLv4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9PDi-0005qB-Cw;
	Wed, 23 Sep 2026 15:49:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9PDh-0005q2-7h
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 15:49:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mRoWz9fVCdRCmwQFkUbSC00RIiqWDcqhoRdZ5z65IOo=; b=hydpe/EA6LydwME+Z3jCkrSRU1
 0vY/zB+LyQTFTZdyRFSRX2pC78tG12Hk0+EPqEibEokkh4NFQO8KbsVUGy1fPuDHIPDTz0sI874jm
 UT0NN+DT12lK1CKOiPCThHonwCn+nClkYjo95woBGKBxV48hkq7w+Cu3l7FXZTIwwVJ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mRoWz9fVCdRCmwQFkUbSC00RIiqWDcqhoRdZ5z65IOo=; b=X
 NR/TidUlwANrIsn/vu40/6UV/jRW8CkM1ENa8ypREg580I+q/QWBI0dS+OvkPZ05ljhUKOHSoGQXn
 sIdYQEo9Sqvffv4GWYRElgA5jYae3vgmALBNNXCBCWOlyaLbUoFxyhbPr2Lfku5CWaYNaTjgDY8rM
 V1POir6oPe5Uo0KU=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9PDZ-00040Q-6E for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 15:49:12 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f633ece3so914653f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790178543; x=1790783343; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mRoWz9fVCdRCmwQFkUbSC00RIiqWDcqhoRdZ5z65IOo=;
 b=HBx3NLUTTdi+0fAAhtrlbVL7AGsUBYQy3SHN1s1jnezlaENFsi+BsywK8jeCE3c0EK
 Fplp2mKShrFD876wS0mmNAIuPChQiHJAxtd5VuP4Ngi+J1ydJRqkHMrQ2Ot+6cPFs3fr
 9gV/quvWSgQxPT3okXowdIVXdPNaGUcJwg1mRYWieySU4AFJ6PU5vAgHrhmk2MmlngNj
 bTkRWXNJ14tO7v2MiwXqMc/O9wuQemCieQIMXmqsPUoxWPWUwYq52q9UqrowvY1+o5m5
 B34h4N1dnaAovVLmNc3JgZ+xHJMoRfof3Hy50Qml8eqiXxfS++wOvfEx1GgV9Yim9x0+
 x4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178543; x=1790783343;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mRoWz9fVCdRCmwQFkUbSC00RIiqWDcqhoRdZ5z65IOo=;
 b=Zz2hghb5RTJ4W3rS6jxeyNih8Lu9GdOl/hDFuAZF6WXWcCCMREabDdPPJ8pAjsOdQn
 AONg6eRuo+vmMnPOZnbLv59MBENRq5Zg2eHqxLTAbNMYAdPuAGbJEQHDzCgfVzKOBsGc
 pU9LOWUznV6U6/WZNMsIg/deReFc5KYhny2RQkDqCIVtkbMaklcRD6QkXpRByCC63UIV
 6mKQiE6PQ7/lrh3eaGLTAEZFgbXK1XToJioFkwuQ2LPWtMPUCfJGIjXWG2pvWr1q4fKF
 IHI4Z+N7N6CY2NKoNKIlN3yBOGGkxlZRPO61J2vn2krJReMDSwH0GdJHAQeY7L/xADh2
 O2HQ==
X-Gm-Message-State: AFuF++midcIXDA7XZ7C5Na6fBoJnIjBcz/3x80ffY5jJeTnhGBbBptjS
 gF4bxWNsquXWp5zdHWGrUibIqr5Iowb6DhV4X9uEPNg+0+vJIDYUhhfWHEfNOs8jbZpnyZBG893
 uxJK+BEYfdT+Dc/YArbF4XaLIva3v7QIjYncKkAUWqVzaArATXaf3MVmDPhhLQErCjZ4xMfaItq
 Pi84q3Cg==
X-Gm-Gg: AYBFou336dcg+Qpz00Clx0Xn/JvmkrKEpGmZenJN9nJiAK9+ohYh+YgcNWxrtfTfv+d
 PaQ22Mv1BLeHdhXtC3EsSVlAvStN5Fo29uecHbrr9VQkodl/Yu5QuqYsXAf7PzaFICFWeSbDjDf
 vScPOrK8C/zq3YV5C6it7w8nRBUXvcbtuDMJBMAQLxjRVKi5Gjn1KR/3k0iONnG8/Xs3pAquIup
 vpOV744638zCiK5FGhYpNsnjvbg5IrH0pTI+xggf2CVYbsMUoYcy2qoSzdMWaMvCGS8M1lwxHJR
 QwbAZJ9Bj3eDTHhwLV792DXSq0mX1feT/6noqF433iaVDiY/jfitGPAVxsnjzjYZTtI5gnW30J8
 KOV07WMSs5mbjHTucJVsaGDQ1PWfswOaZke+qhqJp3+anRIoTBXJ+K+HGhRpDjUF3jqAFqCPBOV
 0tuzZTkusQj+HsxXy1u18WZ5Gj6JtDfLcpyGwXbbaMpIrIj+Rjxxl+Vh0kVz1PKkCG6p8d00nh1
 9eqQVB7QOTvX/O3+q/Q32JPBgj/WKp8lTS1f/IPZxeqZw2Q9ag3/uxEMHs1Mzk+5e7IX70jEGep
 wGjx4t1wdLKGYP2dZYo69bNMR9o6YzwWINk4vT7Xnyl1De+73F4Z5F+SxGEs
X-Received: by 2002:a05:6000:250f:b0:487:b32:9d6f with SMTP id
 ffacd0b85a97d-4886706fd15mr5216618f8f.22.1790178542335; 
 Wed, 23 Sep 2026 08:49:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48867b49661sm7442605f8f.0.2026.09.23.08.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:49:01 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 15:48:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iecffd01567376960c9393770ffe05665073b067a
X-Gerrit-Change-Number: 1941
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1941?usp=email>
X-Gerrit-Commit: 6a23f537c6972869cdde1ed6a998d2aec87d7263
In-Reply-To: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
References: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDcyMzk4MDAwLkllY2ZmZDAxNTY3Mzc2OTYwYzkzOTM3NzBmZmUwNTY2NTA3M2IwNjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5917db1208787b27832f89579a05c2f6c341c07c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9PDZ-00040Q-6E
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add
 --debug-aead-usage-limit-override option
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2757294582813247886=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2757294582813247886==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="COr+Rw2VhoU="; charset=UTF-8

--COr+Rw2VhoU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#3)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1941?usp=3Demail )


Change subject: Add --debug-aead-usage=
-limit-override option
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Add --debug-aead-usage-limit-override option

Normal users shoul=
d not touch this option since there is normally
no reason to mess with the =
number of safely encrypted packets=2E

However, during to check if the epoc=
h key rollover works as expected
it is helpful to trigger this mechanism ea=
rly=2E Since constantly
patching OpenVPN to do this in tests is messy, intr=
oduce an undocumented
option to allow enabling this behaviour=2E

Change-Id=
: Iecffd01567376960c9393770ffe05665073b067a
Signed-off-by: Arne Schwabe <ar=
ne@rfc2549=2Eorg>
---
M Changes=2Emd
M src/openvpn/init=2Ec
M src/openvpn/o=
ptions=2Ec
M src/openvpn/options=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ss=
l_common=2Eh
6 files changed, 37 insertions(+), 6 deletions(-)


  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1941/3

diff --=
git a/Changes=2Emd b/Changes=2Emd
index f46d1a3=2E=2E5c3270b 100644
--- a/C=
hanges=2Emd
+++ b/Changes=2Emd
@@ -25,9 +25,9 @@
 
 ## Maintainer-visible c=
hanges
 
-- The configure-time option `--enable-debug` is no longer  availa=
ble 
-  and the verbose logging is now always included unless `--enable-sma=
ll` 
-  is enabled=2E 
+- The configure-time option `--enable-debug` is no =
longer  available
+  and the verbose logging is now always included unless =
`--enable-small`
+  is enabled=2E
 
 # Overview of changes in 2=2E7
 
diff =
--git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 8a449e8=2E=2E8bfa=
5d1 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3286,6=
 +3286,7 @@
     to=2Epacket_timeout =3D options->tls_timeout;
     to=2Ere=
negotiate_bytes =3D options->renegotiate_bytes;
     to=2Erenegotiate_packe=
ts =3D options->renegotiate_packets;
+    to=2Eaead_usage_limit_override =
=3D options->aead_usage_limit_override;
     if (options->renegotiate_secon=
ds_min < 0)
     {
         /* Add 10% jitter to reneg-sec by default (serv=
er side only) */
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec
index d53c2c5=2E=2E83b4991 100644
--- a/src/openvpn/options=2Ec
+++ b/=
src/openvpn/options=2Ec
@@ -7579,6 +7579,18 @@
             options->renego=
tiate_seconds_min =3D positive_atoi(p[2], msglevel);
         }
     }
+   =
 else if (streq(p[0], "debug-aead-usage-limit-override"))
+    {
+        /=
* This option is undocumented since it should not be used by normal
+      =
   * users */
+        VERIFY_PERMISSION(OPT_P_TLS_PARMS);
+        if (!po=
sitive_atoll(p[1], &options->aead_usage_limit_override, p[0], msglevel))
+ =
       {
+            msg(M_VERB0, "Warning: --debug-aead-usage-limit-overr=
ide should "
+                         "only be used by developers and in s=
pecific tests=2E");
+            goto err;
+        }
+    }
     else if (=
streq(p[0], "hand-window") && p[1] && !p[2])
     {
         VERIFY_PERMISS=
ION(OPT_P_TLS_PARMS);
diff --git a/src/openvpn/options=2Eh b/src/openvpn/op=
tions=2Eh
index f472676=2E=2Ea0a08d5 100644
--- a/src/openvpn/options=2Eh
+=
++ b/src/openvpn/options=2Eh
@@ -646,6 +646,9 @@
     int renegotiate_secon=
ds;
     int renegotiate_seconds_min;
 
+    /** Debug override to trigger =
AEAD usage limit early */
+    int64_t aead_usage_limit_override;
+
     /*=
 Data channel key handshake must finalize
      * within n seconds of hands=
hake initiation=2E */
     int handshake_window;
diff --git a/src/openvpn/s=
sl=2Ec b/src/openvpn/ssl=2Ec
index b6595ab=2E=2Ecb53f9f 100644
--- a/src/op=
envpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -126,11 +126,11 @@
 }
 
 static =
uint64_t
-tls_get_limit_aead(const char *ciphername)
+tls_get_limit_aead(co=
nst char *ciphername, uint64_t override)
 {
     uint64_t limit =3D cipher_=
get_aead_limits(ciphername);
 
-    if (limit =3D=3D 0)
+    if (limit =3D=
=3D 0 && override =3D=3D 0)
     {
         return 0;
     }
@@ -139,6 +139=
,11 @@
      * we go over the limit */
     limit =3D limit / 8 * 7;
 
+   =
 if (override > 0)
+    {
+        limit =3D override;
+    }
+
     msg(D_=
SHOW_KEYS,
         "Note: AEAD cipher %s will trigger a renegotiation"
   =
      " at a sum of %" PRIi64 " blocks and packets=2E",
@@ -1397,6 +1402,11=
 @@
      * */
     epoch_init_key_ctx(co, key_type, &e1_send, &e1_recv, fu=
ture_key_count);
 
+    if (multi->opt=2Eaead_usage_limit_override)
+    {
=
+        co->aead_usage_limit =3D multi->opt=2Eaead_usage_limit_override;
+=
    }
+
     secure_memzero(&e1_send, sizeof(e1_send));
     secure_memzero=
(&e1_recv, sizeof(e1_recv));
 }
@@ -1619,7 +1629,7 @@
     }
     tls_limit=
_reneg_bytes(session->opt->key_type=2Ecipher, &session->opt->renegotiate_by=
tes);
 
-    session->opt->aead_usage_limit =3D tls_get_limit_aead(session-=
>opt->key_type=2Ecipher);
+    session->opt->aead_usage_limit =3D tls_get_l=
imit_aead(session->opt->key_type=2Ecipher, session->opt->aead_usage_limit_o=
verride);
 
     /* set the state of the keys for the session to generated =
*/
     ks->state =3D S_GENERATED_KEYS;
diff --git a/src/openvpn/ssl_common=
=2Eh b/src/openvpn/ssl_common=2Eh
index f6392f9=2E=2E579f46c 100644
--- a/s=
rc/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -346,6 +346,1=
1 @@
     /** limit for AEAD cipher when not running in epoch data key mode=
,
      *  this is the sum of packets + blocks that are allowed to be used =
*/
     uint64_t aead_usage_limit;
+    /**
+     * Debug only option that =
allows overriding the usage limit
+     * This allows testing key rotation =
by using very small limits
+     */
+    uint64_t aead_usage_limit_override=
;
     interval_t renegotiate_seconds;
 
     /* cert verification parms */=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iecffd015673769=
60c9393770ffe05665073b067a
Gerrit-Change-Number: 1941
Gerrit-PatchSet: 3
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>

--COr+Rw2VhoU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Add --debug-aead-usage-limit-override option<br><br>Normal users =
should not touch this option since there is normally<br>no reason to mess w=
ith the number of safely encrypted packets=2E<br><br>However, during to che=
ck if the epoch key rollover works as expected<br>it is helpful to trigger =
this mechanism early=2E Since constantly<br>patching OpenVPN to do this in =
tests is messy, introduce an undocumented<br>option to allow enabling this =
behaviour=2E<br><br>Change-Id: Iecffd01567376960c9393770ffe05665073b067a<br=
>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M Changes=
=2Emd<br>M src/openvpn/init=2Ec<br>M src/openvpn/options=2Ec<br>M src/openv=
pn/options=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>=
6 files changed, 37 insertions(+), 6 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/194=
1/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index =
f46d1a3=2E=2E5c3270b 100644</span><br><span>--- a/Changes=2Emd</span><br><s=
pan>+++ b/Changes=2Emd</span><br><span>@@ -25,9 +25,9 @@</span><br><span> <=
/span><br><span> ## Maintainer-visible changes</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-- The configure-time option `--e=
nable-debug` is no longer  available </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  and the verbose logging is now always included unless `--=
enable-small` </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  is en=
abled=2E </span><br><span style=3D"color: hsl(120, 100%, 40%);">+- The conf=
igure-time option `--enable-debug` is no longer  available</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  and the verbose logging is now alw=
ays included unless `--enable-small`</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  is enabled=2E</span><br><span> </span><br><span> # Overv=
iew of changes in 2=2E7</span><br><span> </span><br><span>diff --git a/src/=
openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 8a449e8=2E=2E=
8bfa5d1 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+=
++ b/src/openvpn/init=2Ec</span><br><span>@@ -3286,6 +3286,7 @@</span><br><=
span>     to=2Epacket_timeout =3D options-&gt;tls_timeout;</span><br><span>=
     to=2Erenegotiate_bytes =3D options-&gt;renegotiate_bytes;</span><br><s=
pan>     to=2Erenegotiate_packets =3D options-&gt;renegotiate_packets;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2Eaead_usage_limi=
t_override =3D options-&gt;aead_usage_limit_override;</span><br><span>     =
if (options-&gt;renegotiate_seconds_min &lt; 0)</span><br><span>     {</spa=
n><br><span>         /* Add 10% jitter to reneg-sec by default (server side=
 only) */</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvp=
n/options=2Ec</span><br><span>index d53c2c5=2E=2E83b4991 100644</span><br><=
span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/option=
s=2Ec</span><br><span>@@ -7579,6 +7579,18 @@</span><br><span>             o=
ptions-&gt;renegotiate_seconds_min =3D positive_atoi(p[2], msglevel);</span=
><br><span>         }</span><br><span>     }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;debug-aead-usage-li=
mit-override&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Th=
is option is undocumented since it should not be used by normal</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         * users */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P=
_TLS_PARMS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!positive_atoll(p[1], &amp;options-&gt;aead_usage_limit_override, p[0]=
, msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M=
_VERB0, &quot;Warning: --debug-aead-usage-limit-override should &quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
 &quot;only be used by developers and in specific tests=2E&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (=
streq(p[0], &quot;hand-window&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</spa=
n><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_TLS_PAR=
MS);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/opt=
ions=2Eh</span><br><span>index f472676=2E=2Ea0a08d5 100644</span><br><span>=
--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh=
</span><br><span>@@ -646,6 +646,9 @@</span><br><span>     int renegotiate_s=
econds;</span><br><span>     int renegotiate_seconds_min;</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Debug overr=
ide to trigger AEAD usage limit early */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int64_t aead_usage_limit_override;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Data chann=
el key handshake must finalize</span><br><span>      * within n seconds of =
handshake initiation=2E */</span><br><span>     int handshake_window;</span=
><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br=
><span>index b6595ab=2E=2Ecb53f9f 100644</span><br><span>--- a/src/openvpn/=
ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -126,1=
1 +126,11 @@</span><br><span> }</span><br><span> </span><br><span> static u=
int64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_get_limit_=
aead(const char *ciphername)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+tls_get_limit_aead(const char *ciphername, uint64_t override)</spa=
n><br><span> {</span><br><span>     uint64_t limit =3D cipher_get_aead_limi=
ts(ciphername);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (limit =3D=3D 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (limit =3D=3D 0 &amp;&amp; override =3D=3D 0)</span>=
<br><span>     {</span><br><span>         return 0;</span><br><span>     }<=
/span><br><span>@@ -139,6 +139,11 @@</span><br><span>      * we go over the=
 limit */</span><br><span>     limit =3D limit / 8 * 7;</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (override &gt;=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        limit =3D override;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     msg(D_SHOW_KEY=
S,</span><br><span>         &quot;Note: AEAD cipher %s will trigger a reneg=
otiation&quot;</span><br><span>         &quot; at a sum of %&quot; PRIi64 &=
quot; blocks and packets=2E&quot;,</span><br><span>@@ -1397,6 +1402,11 @@</=
span><br><span>      * */</span><br><span>     epoch_init_key_ctx(co, key_t=
ype, &amp;e1_send, &amp;e1_recv, future_key_count);</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;opt=2Ea=
ead_usage_limit_override)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
co-&gt;aead_usage_limit =3D multi-&gt;opt=2Eaead_usage_limit_override;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     secure_memzero(&=
amp;e1_send, sizeof(e1_send));</span><br><span>     secure_memzero(&amp;e1_=
recv, sizeof(e1_recv));</span><br><span> }</span><br><span>@@ -1619,7 +1629=
,7 @@</span><br><span>     }</span><br><span>     tls_limit_reneg_bytes(ses=
sion-&gt;opt-&gt;key_type=2Ecipher, &amp;session-&gt;opt-&gt;renegotiate_by=
tes);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    session-&gt;opt-&gt;aead_usage_limit =3D tls_get_limit_aead(session-&=
gt;opt-&gt;key_type=2Ecipher);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    session-&gt;opt-&gt;aead_usage_limit =3D tls_get_limit_aead(=
session-&gt;opt-&gt;key_type=2Ecipher, session-&gt;opt-&gt;aead_usage_limit=
_override);</span><br><span> </span><br><span>     /* set the state of the =
keys for the session to generated */</span><br><span>     ks-&gt;state =3D =
S_GENERATED_KEYS;</span><br><span>diff --git a/src/openvpn/ssl_common=2Eh b=
/src/openvpn/ssl_common=2Eh</span><br><span>index f6392f9=2E=2E579f46c 1006=
44</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/s=
rc/openvpn/ssl_common=2Eh</span><br><span>@@ -346,6 +346,11 @@</span><br><s=
pan>     /** limit for AEAD cipher when not running in epoch data key mode,=
</span><br><span>      *  this is the sum of packets + blocks that are allo=
wed to be used */</span><br><span>     uint64_t aead_usage_limit;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * Debug only option that allows over=
riding the usage limit</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * This allows testing key rotation by using very small limits</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    uint64_t aead_usage_limit_overrid=
e;</span><br><span>     interval_t renegotiate_seconds;</span><br><span> </=
span><br><span>     /* cert verification parms */</span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3Dem=
ail">change 1941</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1941?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: Iecffd01567376960c9393770ffe05665073b067a </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1941 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>

</body></html>
--COr+Rw2VhoU=--


--===============2757294582813247886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2757294582813247886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2757294582813247886==--

