Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAF8CCF2C1
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+g/JiOILnyTjXUcDiRXg+uNu9W2GPiuVVmz3d587E8k=; b=Eng7pvVtkDvSwYBfnIuzrKfoCN
	+XdRY5x7vQUBsb9nJBt1TRm4FLfE80lM1/A57n8dqC3kord7xnwW3xirxoWNM/LgCnctBKPW1K9AJ
	R5lv7Nza3doIBfrD4rMvzBOfl9Pjr6CpsC/zHzVCR5YIVioIi7j75TOHF3TdTFLr8CI8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI1lT-0006xJ-5X;
	Sat, 17 Oct 2026 10:35:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI1lS-0006xB-N2
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 10:35:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rhDcMTfR+DvYfrWKaUvWHqefw5Sdqoep6YPQBeFPpoA=; b=B2CtUGX7rPli7jzZ6w94ZuSp7B
 nOcQm+WrQgULS2Cglj9Rdgwpsn7TR/bw61GOppczZO9cuXyH+5G20E9ejr0occe0Icyp3d471vJUk
 eldDBNtNgCIpbh7z+a3M12iUa+r9x4Tne7nskJkPmDSXewkJfW43ILcHxWoCbyE1CKlo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rhDcMTfR+DvYfrWKaUvWHqefw5Sdqoep6YPQBeFPpoA=; b=D
 tGrbGTFlrWzmy1hDV9csE1FQdzi9po529uxeLfMwlOP1BdtBeARgxFtbxnCUARcsZxPH6qEh8c86J
 OyAOkw9m1uaQOzBU9RM5KUrBHgEzr864/7qCLqMYMDqGrf3662yzNQmYS7b3VMUIdorHFhC1NEl7q
 o2kNOtV9VBZvSJko=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI1lR-00072x-JN for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 10:35:47 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so8639645e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 03:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792233339; x=1792838139; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rhDcMTfR+DvYfrWKaUvWHqefw5Sdqoep6YPQBeFPpoA=;
 b=McbyMAROWb35lyGtAOhEjbLHyj1AZH+5wX7+1US+vXCf1yplD5W5/HWIXRjuZmB6Ks
 9uHwHi/AC9i6A9QgpYTqYQ81+fhSHUp2EqpkUroNKil2r0PCG7DT7Zg3LXUG52Xu/OMd
 bsCE1Ri9SQ65W+EfMfru0YKQ24u4t6HZgsSe9qxtfjVXGzgn77PRuwX2EyC1PoMi1fPd
 LTmz7yd7cR7a7tErYu8mZdw9waDGPxQXMpeTzYTh5UFj5vTbaaNqEF/1bRtXsCtX5TUG
 wY5I8ehcwgsiWCYRmqvwWKWHizaq6ixjJuz9cC/P2FTI+xmn3YrM+7E0b0hbv3R6veyI
 x/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792233339; x=1792838139;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rhDcMTfR+DvYfrWKaUvWHqefw5Sdqoep6YPQBeFPpoA=;
 b=QWv7j6os0UmUEKanHYGFluK4fNaWjAv/8bbgcuHphx7X0nQl+AwCl1qBKJsuhzvvP7
 VI/DSADuS2b6LdFG5rSuqH+mDRllWV07beDHCzOqGc6Jd418ugcfdC3n9JJmxZQmujCc
 jfcpWTK5zwtXIMYFvlZqdUebRIXDFyAdsun1rLne2nmFGhOx9j7wcV/Di7isn+aIy0cv
 oe8a0kEJuVUshn63x4YXaRV+ousozGPb/AMoYnrqqUUhcRS9HXKpTdrXTDHusYsnLP5X
 nkGkqPN7LMhJjRPlHNO8Qnu3vQY4VnGf/XSY2ZkzPkG95GyeibPk+wBxH7lOalcBMR28
 BnAA==
X-Gm-Message-State: AFq9FYJLELouyu3HKaOHnQv0lDIiVEfVeYipnmjNpYH7rhbRq4JrMvEa
 wfz7UeYNXGKs2mZNeRCgRJwTJ3H7XafpA8wIt7ARcD9VIaxSoSKneZW8jL+R87+BNNxFWpTg42t
 YIyKbfILk4ZHAnV1KXx5B06VJDp2r23OhjMA0wP5Ape3vOVc88W3225ef15Il4xuF2Kz57vKyEd
 Ie/eS3KA==
X-Gm-Gg: AYBFou1cCTVyt99EPiuxxJtyoBpa0ciRKW7Nhe0GDmwKeQ0RHsTmFoKXR92t1KjQJzX
 RUWAlm6/ZntlZUJrtA5muH4/fT3d8XSz7DwTeufJ+B9HMez+Ycknp/A5b0+9hUKCXDg0HTmdaTG
 GLTnhn6z25qOlDH2RpfDTL4pJPuKNMJhp8IYiZmLoc8iRy8AAdN1Ere1svDBwtfb8zTBRmkxDXB
 xkqm3QaMTFPDV8Vv2E6/3SluifKtH7WaVxXb7e3V3eTwHPmWbLOI9bvrzDHT4FBnvvMcExOsmIl
 VJOg5l+S4eBwY+8ppVgVHBuq+IazRRCSeCgXw+XjCFWfjoUfN72ixCRc3V0YFPqhTGEqWh6FEBV
 mkd7cqT1RYWt/pLZREAuFv6GNuJaejZZgEx1xAEiRBUIvzj8j5Dwts26BxNDZjA+5iuo8T6MICo
 6cePLDQUaaIMuwp9Mkn5RHg6bZG56FNJQYWVGxrV5jfgMw4KCQdW1IZuGEHuVRnlaiXchvDZKIj
 4NJgYR0zyEAqWE37+rmirpigDOuww84HRLo3uQcn8LHTP8dzjitwHEvJrl4UJWJ4+xT4+Ib57WR
 vxvaN4qV5zgvlKIh6mgPLQfNX79IMYe0usPfuqtOIRxdelMVuPXFMmQ5k+r0
X-Received: by 2002:a05:600c:8709:b0:4a1:ac66:6ac8 with SMTP id
 5b1f17b1804b1-4a1d75aa710mr51736795e9.4.1792233338776; 
 Sat, 17 Oct 2026 03:35:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8a56233sm103698605e9.0.2026.10.17.03.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 03:35:38 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 10:35:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Iecffd01567376960c9393770ffe05665073b067a
X-Gerrit-Change-Number: 1941
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1941?usp=email>
X-Gerrit-Commit: b56c4fe2bae49eeac19fd31523ab8a607461172d
In-Reply-To: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
References: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDcyMzk4MDAwLkllY2ZmZDAxNTY3Mzc2OTYwYzkzOTM3NzBmZmUwNTY2NTA3M2IwNjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5acb508fac879d9bccf99d728f0225163972c6d9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI1lR-00072x-JN
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2039940067975268847=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2039940067975268847==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/F0uRA5MKSA="; charset=UTF-8

--/F0uRA5MKSA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded a new patch set (#5)=2E ( https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1941?usp=3Demail )


Change subject: Add --debug-aead-u=
sage-limit-override option
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Add --debug-aead-usage-limit-override option

Normal users sh=
ould not touch this option since there is normally
no reason to mess with t=
he number of safely encrypted packets=2E

However, during to check if the e=
poch key rollover works as expected
it is helpful to trigger this mechanism=
 early=2E Since constantly
patching OpenVPN to do this in tests is messy, i=
ntroduce an undocumented
option to allow enabling this behaviour=2E

Change=
-Id: Iecffd01567376960c9393770ffe05665073b067a
Signed-off-by: Arne Schwabe =
<arne@rfc2549=2Eorg>
---
M src/openvpn/init=2Ec
M src/openvpn/options=2Ec
M=
 src/openvpn/options=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh=

5 files changed, 36 insertions(+), 3 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1941/5

diff --git a/src/op=
envpn/init=2Ec b/src/openvpn/init=2Ec
index 3c2ebf9=2E=2E06effe2 100644
---=
 a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3286,6 +3286,7 @@
  =
   to=2Epacket_timeout =3D options->tls_timeout;
     to=2Erenegotiate_byte=
s =3D options->renegotiate_bytes;
     to=2Erenegotiate_packets =3D options=
->renegotiate_packets;
+    to=2Eaead_usage_limit_override =3D options->aea=
d_usage_limit_override;
     if (options->renegotiate_seconds_min < 0)
    =
 {
         /* Add 10% jitter to reneg-sec by default (server side only) */=

diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 7fc86=
14=2E=2E1630731 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/opti=
ons=2Ec
@@ -7609,6 +7609,20 @@
             options->renegotiate_seconds_mi=
n =3D positive_atoi(p[2], msglevel);
         }
     }
+#ifdef ENABLE_DEBUG=

+    else if (streq(p[0], "debug-aead-usage-limit-override"))
+    {
+    =
    /* This option is undocumented since it should not be used by normal
+ =
        * users */
+        VERIFY_PERMISSION(OPT_P_TLS_PARMS);
+        if=
 (!positive_atoll(p[1], &options->aead_usage_limit_override, p[0], msglevel=
))
+        {
+            msg(M_VERB0, "Warning: --debug-aead-usage-limit-=
override should "
+                         "only be used by developers and=
 in specific tests=2E");
+            goto err;
+        }
+    }
+#endif
 =
    else if (streq(p[0], "hand-window") && p[1] && !p[2])
     {
         V=
ERIFY_PERMISSION(OPT_P_TLS_PARMS);
diff --git a/src/openvpn/options=2Eh b/s=
rc/openvpn/options=2Eh
index d347830=2E=2E693d9cf 100644
--- a/src/openvpn/=
options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -647,6 +647,9 @@
     int rene=
gotiate_seconds;
     int renegotiate_seconds_min;
 
+    /** Debug overrid=
e to trigger AEAD usage limit early */
+    int64_t aead_usage_limit_overri=
de;
+
     /* Data channel key handshake must finalize
      * within n sec=
onds of handshake initiation=2E */
     int handshake_window;
diff --git a/=
src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 3594871=2E=2E3fd52f0 100644=

--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -126,11 +126,11 @@
=
 }
 
 static uint64_t
-tls_get_limit_aead(const char *ciphername)
+tls_get_=
limit_aead(const char *ciphername, uint64_t override)
 {
     uint64_t limi=
t =3D cipher_get_aead_limits(ciphername);
 
-    if (limit =3D=3D 0)
+    i=
f (limit =3D=3D 0 && override =3D=3D 0)
     {
         return 0;
     }
@@=
 -139,6 +139,11 @@
      * we go over the limit */
     limit =3D limit / 8=
 * 7;
 
+    if (override > 0)
+    {
+        limit =3D override;
+    }
+=

     msg(D_SHOW_KEYS,
         "Note: AEAD cipher %s will trigger a renego=
tiation"
         " at a sum of %" PRIi64 " blocks and packets=2E",
@@ -139=
7,6 +1402,11 @@
      * */
     epoch_init_key_ctx(co, key_type, &e1_send, =
&e1_recv, future_key_count);
 
+    if (multi->opt=2Eaead_usage_limit_overr=
ide)
+    {
+        co->aead_usage_limit =3D multi->opt=2Eaead_usage_limit=
_override;
+    }
+
     secure_memzero(&e1_send, sizeof(e1_send));
     se=
cure_memzero(&e1_recv, sizeof(e1_recv));
 }
@@ -1619,7 +1629,7 @@
     }
  =
   tls_limit_reneg_bytes(session->opt->key_type=2Ecipher, &session->opt->re=
negotiate_bytes);
 
-    session->opt->aead_usage_limit =3D tls_get_limit_a=
ead(session->opt->key_type=2Ecipher);
+    session->opt->aead_usage_limit =
=3D tls_get_limit_aead(session->opt->key_type=2Ecipher, session->opt->aead_=
usage_limit_override);
 
     /* set the state of the keys for the session =
to generated */
     ks->state =3D S_GENERATED_KEYS;
diff --git a/src/openv=
pn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index f6392f9=2E=2E579f46c 1=
00644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ =
-346,6 +346,11 @@
     /** limit for AEAD cipher when not running in epoch =
data key mode,
      *  this is the sum of packets + blocks that are allowe=
d to be used */
     uint64_t aead_usage_limit;
+    /**
+     * Debug only=
 option that allows overriding the usage limit
+     * This allows testing =
key rotation by using very small limits
+     */
+    uint64_t aead_usage_l=
imit_override;
     interval_t renegotiate_seconds;
 
     /* cert verifica=
tion parms */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1941?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
ecffd01567376960c9393770ffe05665073b067a
Gerrit-Change-Number: 1941
Gerrit-=
PatchSet: 5
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--/F0uRA5MKSA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe <str=
ong>uploaded patch set #5</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add --debug-aead-usage-limit-override option<br><br>Normal us=
ers should not touch this option since there is normally<br>no reason to me=
ss with the number of safely encrypted packets=2E<br><br>However, during to=
 check if the epoch key rollover works as expected<br>it is helpful to trig=
ger this mechanism early=2E Since constantly<br>patching OpenVPN to do this=
 in tests is messy, introduce an undocumented<br>option to allow enabling t=
his behaviour=2E<br><br>Change-Id: Iecffd01567376960c9393770ffe05665073b067=
a<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src=
/openvpn/init=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh=
<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>5 files change=
d, 36 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1941/5</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index =
3c2ebf9=2E=2E06effe2 100644</span><br><span>--- a/src/openvpn/init=2Ec</spa=
n><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -3286,6 +3286,7 @=
@</span><br><span>     to=2Epacket_timeout =3D options-&gt;tls_timeout;</sp=
an><br><span>     to=2Erenegotiate_bytes =3D options-&gt;renegotiate_bytes;=
</span><br><span>     to=2Erenegotiate_packets =3D options-&gt;renegotiate_=
packets;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2Eae=
ad_usage_limit_override =3D options-&gt;aead_usage_limit_override;</span><b=
r><span>     if (options-&gt;renegotiate_seconds_min &lt; 0)</span><br><spa=
n>     {</span><br><span>         /* Add 10% jitter to reneg-sec by default=
 (server side only) */</span><br><span>diff --git a/src/openvpn/options=2Ec=
 b/src/openvpn/options=2Ec</span><br><span>index 7fc8614=2E=2E1630731 10064=
4</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/o=
penvpn/options=2Ec</span><br><span>@@ -7609,6 +7609,20 @@</span><br><span> =
            options-&gt;renegotiate_seconds_min =3D positive_atoi(p[2], msg=
level);</span><br><span>         }</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_DEBUG</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;debug-=
aead-usage-limit-override&quot;))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* This option is undocumented since it should not be used by norma=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * users *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PER=
MISSION(OPT_P_TLS_PARMS);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (!positive_atoll(p[1], &amp;options-&gt;aead_usage_limit_o=
verride, p[0], msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(M_VERB0, &quot;Warning: --debug-aead-usage-limit-override shoul=
d &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
              &quot;only be used by developers and in specific tests=2E&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            got=
o err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     else if (=
streq(p[0], &quot;hand-window&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</spa=
n><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_TLS_PAR=
MS);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/opt=
ions=2Eh</span><br><span>index d347830=2E=2E693d9cf 100644</span><br><span>=
--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh=
</span><br><span>@@ -647,6 +647,9 @@</span><br><span>     int renegotiate_s=
econds;</span><br><span>     int renegotiate_seconds_min;</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Debug overr=
ide to trigger AEAD usage limit early */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int64_t aead_usage_limit_override;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Data chann=
el key handshake must finalize</span><br><span>      * within n seconds of =
handshake initiation=2E */</span><br><span>     int handshake_window;</span=
><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br=
><span>index 3594871=2E=2E3fd52f0 100644</span><br><span>--- a/src/openvpn/=
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
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3De=
mail">change 1941</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1941?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Iecffd01567376960c9393770ffe05665073b067a </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1941 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>

</body></html>
--/F0uRA5MKSA=--


--===============2039940067975268847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2039940067975268847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2039940067975268847==--

