Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364F5CCA490
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LMbet943gz1WIqqdZPj+hwhGOmzAlkFO2wpn6n9pqwY=; b=KqW4tfvIn8913MePSmU2A7JV7N
	BNPhGfquRNfQZcuz1lmh2byNuECwvtYsjt9CUf3RKa+xmA0lMtnJQWtG2HzLo7QD+engD1aMzpSZ0
	VWPMDJgFwk+oZCI+6QSeEpAnOWELBZWi/0GCAhfHUNXw2iTcM/7t+MrLfPo+iQg6GiS4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIRDF-0007n8-Eu;
	Sun, 18 Oct 2026 13:46:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIRDE-0007n2-Dm
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:46:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=w+5obu4un2qlLB6bXzNKzl7LY/rQZui4vJtiW+CbgU4=; b=a/rJTr+o8CMMsix4cJMxvsoC6B
 kckd0ibF+WE2/oDmtMFtBuJ7aKu78tEb0oSAOV7ra5zWv8lEa/Ueq4tbLJOT9tSMStrRgWIE4yDKk
 SlAteKA8mAjKmYpYDw2VohcuxiB5ANUrIzNF/C9aKETVqrQbyLeNNm8j5p9u44UEK2aw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=w+5obu4un2qlLB6bXzNKzl7LY/rQZui4vJtiW+CbgU4=; b=l
 d/bQiRggEtihdBTOMdNzmN+VX1NFf12rU0RCiCWjIlt+8PMabhLd02VUcF2ThGliMEWUOf9BCBJy9
 boyaRsv6+XZyGTbxS6bnOeXFM725eWuPcMlQH7vgCPVOLZSsizzNEyH9BtA5ZPaQZTw2CtBKju9KN
 iER47M2EhrhuIC+Q=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIRDC-0005FM-Jd for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:46:08 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48b0584ad71so770332f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 06:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792331160; x=1792935960; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w+5obu4un2qlLB6bXzNKzl7LY/rQZui4vJtiW+CbgU4=;
 b=dbJztVqL+m3ID1SSRlYBqrQ8GuwWVx9+Eq9p6clsdZHU9AfvmdNalDJQZ00yfNjQwh
 hcxZKVgJHm+iCmHpHJte3YPisrbNLn988k82IZZ8dPv30fn1zmpE41/t4aIhytnvM0tu
 Q8NCtVjul/mILmrD2BTvFCGwBGLb/GT/zZ2TY9GyD4Iro8Xp0baZeXnRjTOUXSZpL3FS
 h7BGWn1QpI4g3UoDYPoP4sCodiBiAnCGJqq+iMjHw3txb/McQznQ9VFT0mNq6t1Nh8WR
 1YUvJbHocK2mKiiYCJjdbpUdOohnfu3eX3CCnBs7k5jByCHR+dButzDNTh5u3SH72KZG
 Ld7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792331160; x=1792935960;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w+5obu4un2qlLB6bXzNKzl7LY/rQZui4vJtiW+CbgU4=;
 b=2FuPbd/CFAFTbcqV1aTukPQiwzd+X4s4lGUIV7Ww2AVSOMTkXy1o/5OwMhf2mHzoSB
 JTmhOI+73e7RNX4sB7jGeD3OM+0cfBqoyQ9cmABfN2bSf8/uARj3DDXJ9PCiFiOn4QZ/
 7qAgC3bzR+8zSwBqZsL5R/05z/VEnA2mXmw7mfrAjIgXhn0JpzLkJnb+yTj8Gt4AaPc8
 iIPQFsZWaObPO4wA2vKRM0FiOgNe0gh1zJdRhnCJExB+7lUEvjpgOGUsVorVKEYlveeY
 znFL4/lmO/JmX3Qn8XQlV+VvaWzcISoKxNhNOjFItJSCydwk0Z4/CJGAGrWu8W4+i6tF
 BVnA==
X-Gm-Message-State: AFq9FYIVzlrLKNmAHit6seULNzr32dzcNiyrRj95BIq8PY3EBLmhVxFQ
 9fyT7Ukc13vZMOkiw/brfS7yra/VOhnA2sqwLg7LlkVVZc5clGtuXlhVZIVEXPZGsC1bwbJArJn
 xM+GaXEKyqJXypGmXEAcNIdubfAAQBBgnao/xZSluuRPr95lDdKCvw4U5coK7T0F06swX
X-Gm-Gg: AYBFou1ZwEIL5/qV4bWf3S8hDhtqPN+aazL8rUOa5PZNGRdD/y21IWymLI0EBQOV/Jy
 /3dKmUR7dNkgLp5DTrCD2li1GWI4w9QNOjyEkK1OrbGCVm4dZwqOWiXN4e/0qPfRIsnpSJYQBCC
 432sQL8Pefv83c7JESCA2CDhPRcO8UCnwtlslz84hKnEmcviqRFAATFf3yACUrnzxa+lXAeUQmy
 rDyt+Bx4V1J5ANSKgls+DfEIuhXnqT5HfOmbJR5VZcHLB6FTeGoptAs1TBp0JnPsjPAJiR+IldR
 K2cJo4BqdvExu9X/vrkJdEWm+KlrtATQgIXLYIncxtwXH7Ir3+EL5QBfQKtmOKYEuQrHOBSTAd6
 hIJHma13eNn8xPWMvj1h2LJtodr0OXaY8imGx02CrpQHqBqNnwvxIzyUbYMezE/pi35Tt1KgieI
 IejLpEuLNQpTb1xxKtBNKME+ctJdrm4nnFJ1fswag63Y8OBbKxHJzY4X+GSVYv+V6J8DhUjPbVY
 ZYUFwEOeDwjkpKvrRGfJUyaHyWsetkHOclFYOWRReK0tJMhpSmcjq3JvL7w1Zyj5xaSEi/bBJ/k
 xQLOTDk9iKQAvUr40rQVTq4QOOvB5+fUYILXowz1dpZWXnllcIGIqsCm8P6jhc9eJqqLJ84=
X-Received: by 2002:a05:600c:310d:b0:49f:ce78:3567 with SMTP id
 5b1f17b1804b1-4a1d760d9e2mr108204675e9.24.1792331159910; 
 Sun, 18 Oct 2026 06:45:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8ce32absm139495585e9.1.2026.10.18.06.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:45:59 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 13:45:58 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Iecffd01567376960c9393770ffe05665073b067a
X-Gerrit-Change-Number: 1941
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1941?usp=email>
X-Gerrit-Commit: 43aee864957280d3fd060d477f90cb977708ddf9
In-Reply-To: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
References: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDcyMzk4MDAwLkllY2ZmZDAxNTY3Mzc2OTYwYzkzOTM3NzBmZmUwNTY2NTA3M2IwNjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b326a3b8e4a102fc8357feeca0d0bbf9703960ec-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIRDC-0005FM-Jd
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3057424203152523682=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3057424203152523682==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EMedxWHm5SE="; charset=UTF-8

--EMedxWHm5SE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#6) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1941?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by Antonio Quartulli


Change subject: Add --debug-aead-usage-limit=
-override option
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Add --debug-aead-usage-limit-override option

Normal users should not =
touch this option since there is normally
no reason to mess with the number=
 of safely encrypted packets=2E

However, during to check if the epoch key =
rollover works as expected
it is helpful to trigger this mechanism early=2E=
 Since constantly
patching OpenVPN to do this in tests is messy, introduce =
an undocumented
option to allow enabling this behaviour=2E

Change-Id: Iecf=
fd01567376960c9393770ffe05665073b067a
Signed-off-by: Arne Schwabe <arne@rfc=
2549=2Eorg>
Acked-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1941
Message-Id: <20261017163=
328=2E12832-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg39949=2Ehtml
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
M src/openv=
pn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/ssl=2Ec
M src/openvp=
n/ssl_common=2Eh
5 files changed, 36 insertions(+), 3 deletions(-)


  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1941/6

dif=
f --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index d8fd844=2E=2Edd=
cfaf4 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3286=
,6 +3286,7 @@
     to=2Epacket_timeout =3D options->tls_timeout;
     to=2E=
renegotiate_bytes =3D options->renegotiate_bytes;
     to=2Erenegotiate_pac=
kets =3D options->renegotiate_packets;
+    to=2Eaead_usage_limit_override =
=3D options->aead_usage_limit_override;
     if (options->renegotiate_secon=
ds_min < 0)
     {
         /* Add 10% jitter to reneg-sec by default (serv=
er side only) */
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec
index 7fc8614=2E=2E1630731 100644
--- a/src/openvpn/options=2Ec
+++ b/=
src/openvpn/options=2Ec
@@ -7609,6 +7609,20 @@
             options->renego=
tiate_seconds_min =3D positive_atoi(p[2], msglevel);
         }
     }
+#if=
def ENABLE_DEBUG
+    else if (streq(p[0], "debug-aead-usage-limit-override=
"))
+    {
+        /* This option is undocumented since it should not be u=
sed by normal
+         * users */
+        VERIFY_PERMISSION(OPT_P_TLS_PAR=
MS);
+        if (!positive_atoll(p[1], &options->aead_usage_limit_override=
, p[0], msglevel))
+        {
+            msg(M_VERB0, "Warning: --debug-a=
ead-usage-limit-override should "
+                         "only be used b=
y developers and in specific tests=2E");
+            goto err;
+        }
=
+    }
+#endif
     else if (streq(p[0], "hand-window") && p[1] && !p[2])
 =
    {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
diff --git a/src/openvpn=
/options=2Eh b/src/openvpn/options=2Eh
index d347830=2E=2E693d9cf 100644
--=
- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -647,6 +647,9 =
@@
     int renegotiate_seconds;
     int renegotiate_seconds_min;
 
+    /=
** Debug override to trigger AEAD usage limit early */
+    int64_t aead_us=
age_limit_override;
+
     /* Data channel key handshake must finalize
    =
  * within n seconds of handshake initiation=2E */
     int handshake_windo=
w;
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 49a9cb6=2E=
=2E086a6fc 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1=
26,11 +126,11 @@
 }
 
 static uint64_t
-tls_get_limit_aead(const char *ciph=
ername)
+tls_get_limit_aead(const char *ciphername, uint64_t override)
 {
 =
    uint64_t limit =3D cipher_get_aead_limits(ciphername);
 
-    if (limit=
 =3D=3D 0)
+    if (limit =3D=3D 0 && override =3D=3D 0)
     {
         re=
turn 0;
     }
@@ -139,6 +139,11 @@
      * we go over the limit */
     li=
mit =3D limit / 8 * 7;
 
+    if (override > 0)
+    {
+        limit =3D o=
verride;
+    }
+
     msg(D_SHOW_KEYS,
         "Note: AEAD cipher %s will=
 trigger a renegotiation"
         " at a sum of %" PRIi64 " blocks and pac=
kets=2E",
@@ -1397,6 +1402,11 @@
      * */
     epoch_init_key_ctx(co, key=
_type, &e1_send, &e1_recv, future_key_count);
 
+    if (multi->opt=2Eaead_=
usage_limit_override)
+    {
+        co->aead_usage_limit =3D multi->opt=
=2Eaead_usage_limit_override;
+    }
+
     secure_memzero(&e1_send, sizeof=
(e1_send));
     secure_memzero(&e1_recv, sizeof(e1_recv));
 }
@@ -1619,7 +=
1629,7 @@
     }
     tls_limit_reneg_bytes(session->opt->key_type=2Ecipher=
, &session->opt->renegotiate_bytes);
 
-    session->opt->aead_usage_limit =
=3D tls_get_limit_aead(session->opt->key_type=2Ecipher);
+    session->opt-=
>aead_usage_limit =3D tls_get_limit_aead(session->opt->key_type=2Ecipher, s=
ession->opt->aead_usage_limit_override);
 
     /* set the state of the key=
s for the session to generated */
     ks->state =3D S_GENERATED_KEYS;
diff=
 --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index f639=
2f9=2E=2E579f46c 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/=
ssl_common=2Eh
@@ -346,6 +346,11 @@
     /** limit for AEAD cipher when not=
 running in epoch data key mode,
      *  this is the sum of packets + bloc=
ks that are allowed to be used */
     uint64_t aead_usage_limit;
+    /**
=
+     * Debug only option that allows overriding the usage limit
+     * Th=
is allows testing key rotation by using very small limits
+     */
+    uin=
t64_t aead_usage_limit_override;
     interval_t renegotiate_seconds;
 
   =
  /* cert verification parms */

-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1941?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Iecffd01567376960c9393770ffe05665073b067a
Gerrit-Change-Nu=
mber: 1941
Gerrit-PatchSet: 6
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--EMedxWHm5SE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #6</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/194=
1?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by Antonio Quartulli</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Add --=
debug-aead-usage-limit-override option<br><br>Normal users should not touch=
 this option since there is normally<br>no reason to mess with the number o=
f safely encrypted packets=2E<br><br>However, during to check if the epoch =
key rollover works as expected<br>it is helpful to trigger this mechanism e=
arly=2E Since constantly<br>patching OpenVPN to do this in tests is messy, =
introduce an undocumented<br>option to allow enabling this behaviour=2E<br>=
<br>Change-Id: Iecffd01567376960c9393770ffe05665073b067a<br>Signed-off-by: =
Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Antonio Quartulli &lt;=
antonio@mandelbit=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1941<br>Message-Id: &lt;20261017163328=2E12832-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg39949=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/=
options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/=
openvpn/ssl_common=2Eh<br>5 files changed, 36 insertions(+), 3 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/41/1941/6</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src=
/openvpn/init=2Ec</span><br><span>index d8fd844=2E=2Eddcfaf4 100644</span><=
br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=
=2Ec</span><br><span>@@ -3286,6 +3286,7 @@</span><br><span>     to=2Epacket=
_timeout =3D options-&gt;tls_timeout;</span><br><span>     to=2Erenegotiate=
_bytes =3D options-&gt;renegotiate_bytes;</span><br><span>     to=2Erenegot=
iate_packets =3D options-&gt;renegotiate_packets;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    to=2Eaead_usage_limit_override =3D option=
s-&gt;aead_usage_limit_override;</span><br><span>     if (options-&gt;reneg=
otiate_seconds_min &lt; 0)</span><br><span>     {</span><br><span>         =
/* Add 10% jitter to reneg-sec by default (server side only) */</span><br><=
span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><=
br><span>index 7fc8614=2E=2E1630731 100644</span><br><span>--- a/src/openvp=
n/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span=
>@@ -7609,6 +7609,20 @@</span><br><span>             options-&gt;renegotiat=
e_seconds_min =3D positive_atoi(p[2], msglevel);</span><br><span>         }=
</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else if (streq(p[0], &quot;debug-aead-usage-limit-override&quot;))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* This option is undocume=
nted since it should not be used by normal</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * users */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!positive_atoll(=
p[1], &amp;options-&gt;aead_usage_limit_override, p[0], msglevel))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            msg(M_VERB0, &quot;Warning=
: --debug-aead-usage-limit-override should &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                         &quot;only be used b=
y developers and in specific tests=2E&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span>     else if (streq(p[0], &quot;hand-window&quot=
;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span=
>         VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span><br><span>diff --git a/=
src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index d34=
7830=2E=2E693d9cf 100644</span><br><span>--- a/src/openvpn/options=2Eh</spa=
n><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -647,6 +647,9 =
@@</span><br><span>     int renegotiate_seconds;</span><br><span>     int r=
enegotiate_seconds_min;</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /** Debug override to trigger AEAD usage limit ea=
rly */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int64_t a=
ead_usage_limit_override;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>     /* Data channel key handshake must finalize</sp=
an><br><span>      * within n seconds of handshake initiation=2E */</span><=
br><span>     int handshake_window;</span><br><span>diff --git a/src/openvp=
n/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 49a9cb6=2E=2E086a6fc =
100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/=
openvpn/ssl=2Ec</span><br><span>@@ -126,11 +126,11 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static uint64_t</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-tls_get_limit_aead(const char *ciphername)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_get_limit_aead(const =
char *ciphername, uint64_t override)</span><br><span> {</span><br><span>   =
  uint64_t limit =3D cipher_get_aead_limits(ciphername);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (limit =3D=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (limit =3D=
=3D 0 &amp;&amp; override =3D=3D 0)</span><br><span>     {</span><br><span>=
         return 0;</span><br><span>     }</span><br><span>@@ -139,6 +139,11=
 @@</span><br><span>      * we go over the limit */</span><br><span>     li=
mit =3D limit / 8 * 7;</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (override &gt; 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        limit =3D override;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>     msg(D_SHOW_KEYS,</span><br><span>         &quot=
;Note: AEAD cipher %s will trigger a renegotiation&quot;</span><br><span>  =
       &quot; at a sum of %&quot; PRIi64 &quot; blocks and packets=2E&quot;=
,</span><br><span>@@ -1397,6 +1402,11 @@</span><br><span>      * */</span><=
br><span>     epoch_init_key_ctx(co, key_type, &amp;e1_send, &amp;e1_recv, =
future_key_count);</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (multi-&gt;opt=2Eaead_usage_limit_override)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        co-&gt;aead_usage_limit =3D multi=
-&gt;opt=2Eaead_usage_limit_override;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     secure_memzero(&amp;e1_send, sizeof(e1_send));</s=
pan><br><span>     secure_memzero(&amp;e1_recv, sizeof(e1_recv));</span><br=
><span> }</span><br><span>@@ -1619,7 +1629,7 @@</span><br><span>     }</spa=
n><br><span>     tls_limit_reneg_bytes(session-&gt;opt-&gt;key_type=2Eciphe=
r, &amp;session-&gt;opt-&gt;renegotiate_bytes);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    session-&gt;opt-&gt;aead_us=
age_limit =3D tls_get_limit_aead(session-&gt;opt-&gt;key_type=2Ecipher);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;opt-&g=
t;aead_usage_limit =3D tls_get_limit_aead(session-&gt;opt-&gt;key_type=2Eci=
pher, session-&gt;opt-&gt;aead_usage_limit_override);</span><br><span> </sp=
an><br><span>     /* set the state of the keys for the session to generated=
 */</span><br><span>     ks-&gt;state =3D S_GENERATED_KEYS;</span><br><span=
>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span=
><br><span>index f6392f9=2E=2E579f46c 100644</span><br><span>--- a/src/open=
vpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><=
br><span>@@ -346,6 +346,11 @@</span><br><span>     /** limit for AEAD ciphe=
r when not running in epoch data key mode,</span><br><span>      *  this is=
 the sum of packets + blocks that are allowed to be used */</span><br><span=
>     uint64_t aead_usage_limit;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * Debug only option that allows overriding the usage limit</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * This allows testing key=
 rotation by using very small limits</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    uint64_t aead_usage_limit_override;</span><br><span>     interval_=
t renegotiate_seconds;</span><br><span> </span><br><span>     /* cert verif=
ication parms */</span><br></pre><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3Demail">change 1941</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iecffd0156737=
6960c9393770ffe05665073b067a </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1941 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: An=
tonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>

</body></html>
--EMedxWHm5SE=--


--===============3057424203152523682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3057424203152523682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3057424203152523682==--

