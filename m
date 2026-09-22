Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5E8C982F1
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=LZfOQDKArXMqyJ3A5YECHWRzMMN7Z+kUKgsM9bzwW54=; b=LRpjFqQrUSzUIb
	jR5+8pbRAzS0+rJLCqh5FpqEcfYXq+FgvUrQlxc/Oj+LEuqmxHAvFJPw8Cwu24oIxvteQuwrrNTek
	LJEkmgd4G2b3xQKel4/DooFFhA2XOwhEdTFb3hw+GGUKDV/PWJ2x6jrPU/ykX6W/ouDub3CoW8QOL
	2ZI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8xbk-0005vv-Kr;
	Tue, 22 Sep 2026 10:20:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8xbj-0005vn-Bv
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 10:20:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NDevqkkTbDZwLgA4Ur5xCUXR6tFmgQ7iX9kjxmM0rfU=; b=kVHF3Di/K+InHUf+am/hJMTPuv
 CYeaxmFQE9G7V6NNeRa3INhbuSuZJW+6RRVsykwN2oawyP7PKN3xj5d4DSf4bo2CucpxYJf/E8dZL
 KpUXcMsRLwSeJpy6Po/1k3964TzaRojUTZY0xEdulumlZ3KyVH++/am/zHIDQPbPjIWo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NDevqkkTbDZwLgA4Ur5xCUXR6tFmgQ7iX9kjxmM0rfU=; b=h
 kBvdnSNRXoNt6jDjsxs5q9pFpJAIe5lR+a88q7/Czo5XkbBG6Wj88tzcfjisvYRmT2G5SNcQZcp1Z
 I5BML6XpwcQxRdUxEbY0PWcKXZf2PudhOwkTvsqDx2akeNJImg2M1UPYQZ9G4LmSDZDp1VdF87lpn
 6fztfH0CwvxBcWTs=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8xbg-0005Qy-Qv for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 10:20:14 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso33552805e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 03:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790072405; x=1790677205; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NDevqkkTbDZwLgA4Ur5xCUXR6tFmgQ7iX9kjxmM0rfU=;
 b=OTF1FTycT5WXk2YvxnIoafD8h1ffNJbmuDBMK1UWXnOnAUy6txm5uyl11pMcbNRjke
 Rc+zIOlWM/0hMZHFKU5hLmF7TaSxu/cdMMDidfS9m+BU3ofUIo20jyD6TaNiqc3asvDj
 nsRov5/Qlm2Cp9nrAfLaC2yxZQrLwFAKmSfI/M+4r0QfdPT2GlDOLGmIQ3l46Z4olr39
 bwPZEI7hBJx7gRl9qtWEB3SW/KYZS54Kf/LXpF2HXTOLQ2N/9u8swfBvM7lOfCosMjq9
 2vqbAZSY5cIhmKVmAyb0yotLZF2LIvMOI1dXJNlWvL3sMh41ooqOtFUUH4tYvqLE0m0D
 7JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790072405; x=1790677205;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NDevqkkTbDZwLgA4Ur5xCUXR6tFmgQ7iX9kjxmM0rfU=;
 b=U3BQeLlOWEXTDyljFEdZ7VAflhR2Gxzieo6YwUFOrrwOnGxHFP6ngJhlPMhl0CjMgV
 p6K6uDyzCIPtV8V3KU/8JQR1wU47SCFw2BrnKl198wasHXOLmdWM32YuMO7oJKILleFM
 QxbYY5VNj2QYqAVc9HIvf70pDoN7uhDxAUGQOUnlxAgbR/vx9KefyU8e/GIU5NDTocZY
 eqdwMesI2qa5l3jZvYEGhTcWCtJIIIJrba+6l97H2nxEFr2GtVnHiP8brEGNj37Neeri
 hMXZEdKfaPsd2D80FyOFCnMVq1TdphnnJf+HiPqWgtQyLHGw6epuhHviyqspGvP+IcCA
 c4vg==
X-Gm-Message-State: AFuF++mBoLm4EjZSs+qA2s80E7JYfU0jzDmhA8C2WQ+w3SXxf98I5uv7
 UwyPQcGfvfSdubEhkt1OizDOC0z3zS77fYGtNu1HhgMY/cubPA5E30kdQxoeZe77f/SMfJ1RI1I
 u5LpJi6tv2stwXLg645cFFRlOg28NVc9gM/jAcZBcFRNjFzc1N6PY0R3c2R+8iWvpPyJaWGdD3S
 lf046sTw==
X-Gm-Gg: AYBFou3lEoU2TmVW9JPZIk22NNNaLZXKwUFDWl7DxJltxATLMaJIEsugSQP2DpTqShJ
 1rzwOV81qyxELhJinuGeX1s08numxuB9oVox153ysw8qYLVI9iRm7U7jJrq3VKFgdnJQ/yAbIPZ
 tkL88nAcqbBf348QmFcPMoyjX39eG0bOOHTn8AF2q7CVYsUwArhvBN/CvwyE8gFa6ec/c7WRcov
 MpHV/lUf/CQx06jacpSCo5QAxV8pJGshpjD7sRlUX3v5ZhDkQ/L4rWIeFJ0b4B2CfkA3uqLpW4X
 YjormwEyBqHvGZT6oVK2cUa5Wf9jRcy2vVWtdyCPUxMoyRE1VCMnoJtawC5Lu0F0rGFrrvCc3Ct
 8p1vXerzXIAJGUDy49/afP5Prx4sRkhs2o+GOIacV2PaELK8r1QF7oedZ7SRA8PYPFZGmUHkfEJ
 JtcGRWiUeNlyUTq3QqoXFRY1eUCwyBPBlnxF0x622y4NMPq50sCRLEFCeb5XvxpndRuwmQuWFcm
 O/5S0YOSn/KmZcb/E1QWTHVCfSRzdJRxKhtiOonuCM4yYUfLTYwG5P6v0Y3/ICrPB0wSxjDsSLJ
 Kd3gzNpsCX0Mc7mjaXBaxy9xF7Wx5PRUftT69RNX5U/+hKwjGHS46JZX/Hx4qDLOV+7G1vXEOA=
 =
X-Received: by 2002:a05:600c:6308:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-49fc5728e35mr181707885e9.20.1790072405316; 
 Tue, 22 Sep 2026 03:20:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8cc05e9sm64265345e9.5.2026.09.22.03.20.03
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 03:20:03 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 10:20:01 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iecffd01567376960c9393770ffe05665073b067a
X-Gerrit-Change-Number: 1941
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1941?usp=email>
X-Gerrit-Commit: 37159f78714976787a539a3b50df37b288312abd
References: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDcyMzk4MDAwLkllY2ZmZDAxNTY3Mzc2OTYwYzkzOTM3NzBmZmUwNTY2NTA3M2IwNjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c2bea34ef89e02f6e11e6a89c39ad33b6ea1c0b4-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x8xbg-0005Qy-Qv
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
Content-Type: multipart/mixed; boundary="===============7866608889740819836=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7866608889740819836==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EpHB+p9Mon4="; charset=UTF-8

--EpHB+p9Mon4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1941?usp=3Demail )


Change subject: Add --debug-aead-us=
age-limit-override option
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

5 files changed, 34 insertions(+), 3 deletions(-)



  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1941/1

diff --git a/src/o=
penvpn/init=2Ec b/src/openvpn/init=2Ec
index 8a449e8=2E=2E8bfa5d1 100644
--=
- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3286,6 +3286,7 @@
 =
    to=2Epacket_timeout =3D options->tls_timeout;
     to=2Erenegotiate_byt=
es =3D options->renegotiate_bytes;
     to=2Erenegotiate_packets =3D option=
s->renegotiate_packets;
+    to=2Eaead_usage_limit_override =3D options->ae=
ad_usage_limit_override;
     if (options->renegotiate_seconds_min < 0)
   =
  {
         /* Add 10% jitter to reneg-sec by default (server side only) *=
/
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index e3cd=
527=2E=2E9454982 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/opt=
ions=2Ec
@@ -7578,6 +7578,18 @@
             options->renegotiate_seconds_m=
in =3D positive_atoi(p[2], msglevel);
         }
     }
+    else if (streq=
(p[0], "debug-aead-usage-limit-override"))
+    {
+        /* This option i=
s undocumented since it should not be used by normal
+         * users */
+=
        VERIFY_PERMISSION(OPT_P_TLS_PARMS);
+        if (!positive_atoll(p[=
1], &options->aead_usage_limit_override, p[0], msglevel))
+        {
+     =
       msg(M_VERB0, "Warning: --debug-aead-usage-limit-override should "
+ =
                        "only be used by developers and in specific tests=
=2E");
+            goto err;
+        }
+    }
     else if (streq(p[0], "=
hand-window") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS=
_PARMS);
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
ind=
ex f472676=2E=2Ea0a08d5 100644
--- a/src/openvpn/options=2Eh
+++ b/src/open=
vpn/options=2Eh
@@ -646,6 +646,9 @@
     int renegotiate_seconds;
     int =
renegotiate_seconds_min;
 
+    /** Debug override to trigger AEAD usage li=
mit early */
+    int64_t aead_usage_limit_override;
+
     /* Data channel=
 key handshake must finalize
      * within n seconds of handshake initiati=
on=2E */
     int handshake_window;
diff --git a/src/openvpn/ssl=2Ec b/src/=
openvpn/ssl=2Ec
index b6595ab=2E=2Ecb53f9f 100644
--- a/src/openvpn/ssl=2Ec=

+++ b/src/openvpn/ssl=2Ec
@@ -126,11 +126,11 @@
 }
 
 static uint64_t
-tls=
_get_limit_aead(const char *ciphername)
+tls_get_limit_aead(const char *cip=
hername, uint64_t override)
 {
     uint64_t limit =3D cipher_get_aead_limi=
ts(ciphername);
 
-    if (limit =3D=3D 0)
+    if (limit =3D=3D 0 && overr=
ide =3D=3D 0)
     {
         return 0;
     }
@@ -139,6 +139,11 @@
      *=
 we go over the limit */
     limit =3D limit / 8 * 7;
 
+    if (override =
> 0)
+    {
+        limit =3D override;
+    }
+
     msg(D_SHOW_KEYS,
   =
      "Note: AEAD cipher %s will trigger a renegotiation"
         " at a s=
um of %" PRIi64 " blocks and packets=2E",
@@ -1397,6 +1402,11 @@
      * */=

     epoch_init_key_ctx(co, key_type, &e1_send, &e1_recv, future_key_count=
);
 
+    if (multi->opt=2Eaead_usage_limit_override)
+    {
+        co->a=
ead_usage_limit =3D multi->opt=2Eaead_usage_limit_override;
+    }
+
     s=
ecure_memzero(&e1_send, sizeof(e1_send));
     secure_memzero(&e1_recv, siz=
eof(e1_recv));
 }
@@ -1619,7 +1629,7 @@
     }
     tls_limit_reneg_bytes(s=
ession->opt->key_type=2Ecipher, &session->opt->renegotiate_bytes);
 
-    s=
ession->opt->aead_usage_limit =3D tls_get_limit_aead(session->opt->key_type=
=2Ecipher);
+    session->opt->aead_usage_limit =3D tls_get_limit_aead(sess=
ion->opt->key_type=2Ecipher, session->opt->aead_usage_limit_override);
 
  =
   /* set the state of the keys for the session to generated */
     ks->st=
ate =3D S_GENERATED_KEYS;
diff --git a/src/openvpn/ssl_common=2Eh b/src/ope=
nvpn/ssl_common=2Eh
index f6392f9=2E=2E579f46c 100644
--- a/src/openvpn/ssl=
_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -346,6 +346,11 @@
     /** =
limit for AEAD cipher when not running in epoch data key mode,
      *  thi=
s is the sum of packets + blocks that are allowed to be used */
     uint64=
_t aead_usage_limit;
+    /**
+     * Debug only option that allows overrid=
ing the usage limit
+     * This allows testing key rotation by using very =
small limits
+     */
+    uint64_t aead_usage_limit_override;
     interva=
l_t renegotiate_seconds;
 
     /* cert verification parms */

-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: Iecffd01567376960c9393770ffe0566=
5073b067a
Gerrit-Change-Number: 1941
Gerrit-PatchSet: 1
Gerrit-Owner: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>

--EpHB+p9Mon4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Add --debug-aead-usage-limit-override option<br><br>Normal users s=
hould not touch this option since there is normally<br>no reason to mess wi=
th the number of safely encrypted packets=2E<br><br>However, during to chec=
k if the epoch key rollover works as expected<br>it is helpful to trigger t=
his mechanism early=2E Since constantly<br>patching OpenVPN to do this in t=
ests is messy, introduce an undocumented<br>option to allow enabling this b=
ehaviour=2E<br><br>Change-Id: Iecffd01567376960c9393770ffe05665073b067a<br>=
Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/open=
vpn/init=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M=
 src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>5 files changed, 34=
 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1941/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 8a4=
49e8=2E=2E8bfa5d1 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><=
br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -3286,6 +3286,7 @@</=
span><br><span>     to=2Epacket_timeout =3D options-&gt;tls_timeout;</span>=
<br><span>     to=2Erenegotiate_bytes =3D options-&gt;renegotiate_bytes;</s=
pan><br><span>     to=2Erenegotiate_packets =3D options-&gt;renegotiate_pac=
kets;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2Eaead_=
usage_limit_override =3D options-&gt;aead_usage_limit_override;</span><br><=
span>     if (options-&gt;renegotiate_seconds_min &lt; 0)</span><br><span> =
    {</span><br><span>         /* Add 10% jitter to reneg-sec by default (s=
erver side only) */</span><br><span>diff --git a/src/openvpn/options=2Ec b/=
src/openvpn/options=2Ec</span><br><span>index e3cd527=2E=2E9454982 100644</=
span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/open=
vpn/options=2Ec</span><br><span>@@ -7578,6 +7578,18 @@</span><br><span>    =
         options-&gt;renegotiate_seconds_min =3D positive_atoi(p[2], msglev=
el);</span><br><span>         }</span><br><span>     }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;debug-aea=
d-usage-limit-override&quot;))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* This option is undocumented since it should not be used by normal</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * users */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMIS=
SION(OPT_P_TLS_PARMS);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (!positive_atoll(p[1], &amp;options-&gt;aead_usage_limit_over=
ride, p[0], msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(M_VERB0, &quot;Warning: --debug-aead-usage-limit-override should &=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
           &quot;only be used by developers and in specific tests=2E&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto e=
rr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>    =
 else if (streq(p[0], &quot;hand-window&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT=
_P_TLS_PARMS);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/o=
penvpn/options=2Eh</span><br><span>index f472676=2E=2Ea0a08d5 100644</span>=
<br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/o=
ptions=2Eh</span><br><span>@@ -646,6 +646,9 @@</span><br><span>     int ren=
egotiate_seconds;</span><br><span>     int renegotiate_seconds_min;</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** D=
ebug override to trigger AEAD usage limit early */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int64_t aead_usage_limit_override;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* =
Data channel key handshake must finalize</span><br><span>      * within n s=
econds of handshake initiation=2E */</span><br><span>     int handshake_win=
dow;</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec=
</span><br><span>index b6595ab=2E=2Ecb53f9f 100644</span><br><span>--- a/sr=
c/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span=
>@@ -126,11 +126,11 @@</span><br><span> }</span><br><span> </span><br><span=
> static uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_=
get_limit_aead(const char *ciphername)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+tls_get_limit_aead(const char *ciphername, uint64_t over=
ride)</span><br><span> {</span><br><span>     uint64_t limit =3D cipher_get=
_aead_limits(ciphername);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (limit =3D=3D 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (limit =3D=3D 0 &amp;&amp; override =3D=3D=
 0)</span><br><span>     {</span><br><span>         return 0;</span><br><sp=
an>     }</span><br><span>@@ -139,6 +139,11 @@</span><br><span>      * we g=
o over the limit */</span><br><span>     limit =3D limit / 8 * 7;</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ove=
rride &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        limit =3D ov=
erride;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     msg(=
D_SHOW_KEYS,</span><br><span>         &quot;Note: AEAD cipher %s will trigg=
er a renegotiation&quot;</span><br><span>         &quot; at a sum of %&quot=
; PRIi64 &quot; blocks and packets=2E&quot;,</span><br><span>@@ -1397,6 +14=
02,11 @@</span><br><span>      * */</span><br><span>     epoch_init_key_ctx=
(co, key_type, &amp;e1_send, &amp;e1_recv, future_key_count);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&=
gt;opt=2Eaead_usage_limit_override)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        co-&gt;aead_usage_limit =3D multi-&gt;opt=2Eaead_usage_limit_over=
ride;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     secure=
_memzero(&amp;e1_send, sizeof(e1_send));</span><br><span>     secure_memzer=
o(&amp;e1_recv, sizeof(e1_recv));</span><br><span> }</span><br><span>@@ -16=
19,7 +1629,7 @@</span><br><span>     }</span><br><span>     tls_limit_reneg=
_bytes(session-&gt;opt-&gt;key_type=2Ecipher, &amp;session-&gt;opt-&gt;rene=
gotiate_bytes);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    session-&gt;opt-&gt;aead_usage_limit =3D tls_get_limit_aead=
(session-&gt;opt-&gt;key_type=2Ecipher);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    session-&gt;opt-&gt;aead_usage_limit =3D tls_get_l=
imit_aead(session-&gt;opt-&gt;key_type=2Ecipher, session-&gt;opt-&gt;aead_u=
sage_limit_override);</span><br><span> </span><br><span>     /* set the sta=
te of the keys for the session to generated */</span><br><span>     ks-&gt;=
state =3D S_GENERATED_KEYS;</span><br><span>diff --git a/src/openvpn/ssl_co=
mmon=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index f6392f9=2E=2E57=
9f46c 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><sp=
an>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -346,6 +346,11 @@</s=
pan><br><span>     /** limit for AEAD cipher when not running in epoch data=
 key mode,</span><br><span>      *  this is the sum of packets + blocks tha=
t are allowed to be used */</span><br><span>     uint64_t aead_usage_limit;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * Debug only option that a=
llows overriding the usage limit</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * This allows testing key rotation by using very small li=
mits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t aead_usage_lim=
it_override;</span><br><span>     interval_t renegotiate_seconds;</span><br=
><span> </span><br><span>     /* cert verification parms */</span><br></pre=
><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/194=
1?usp=3Demail">change 1941</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1941?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: Iecffd01567376960c9393770ffe05665073b067a </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1941 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit=
-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>

</body></html>
--EpHB+p9Mon4=--


--===============7866608889740819836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7866608889740819836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7866608889740819836==--

