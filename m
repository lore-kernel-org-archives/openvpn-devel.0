Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3644C982FA
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+qCXKNYrmwwmzW1HzbWl10AH9Cp/a5aHSvKjgcxe2eU=; b=SZUlIzdcQs4T2g5J6pQa2H6fBn
	S4Yzaf7BRTh/2+cIbte9pMwDrpiky1latci+zoL8wRrsRHBpWjdzR5oWcSRxCmoiyuvEYiTAcYJwS
	Z60mxLOnqZJ0U7g6fdiydP9FayJdEJfn2G2LmPZjEZTX/Oj5bgXxY996BipaPW/wMkSU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8zYA-0000F3-OO;
	Tue, 22 Sep 2026 12:24:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8zY9-0000EZ-R9
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:24:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UUaMMfxQGVaqYsCWtIJm0K45AS9SWg4KO2Ze0P1/tlI=; b=AtyUWeELS/6mzXYaAGBtbGYQ+w
 kDrycSBfOo01peAZtDtiF9nGwwKoNnRlcRB8/bgG6QHreyx2QB/KQIFT5aTM4NQ2c2p6eKFRsr5Ma
 QmFQ3JoUcBbUrJ8n69613Nlq8jp2BnRmB8qxepzGkppLwNcNs2BBqG/4LgJT1zZewN8M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UUaMMfxQGVaqYsCWtIJm0K45AS9SWg4KO2Ze0P1/tlI=; b=O
 28xR9ayMTL7swItv86YgDhygW4i1PoCzrtYTk38qkXFMH97MvgYY3o5UYgj24YCx/qWgD9cTanCfq
 HlXBhlrpZkH+oBGfcebPQQmM6WCFY0SL/AvFvax/veeB/4dvB2nHw2kgScO965HYN5E/t+PPcby4M
 9umtvkCrHC9RQ940=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8zY8-0002zw-Ow for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:24:42 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6356256so1358451f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790079874; x=1790684674; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UUaMMfxQGVaqYsCWtIJm0K45AS9SWg4KO2Ze0P1/tlI=;
 b=Q40AuYcduYlvhrDnGAbzfDU1pNcVzuUob7bK0BRX74aVx0xS5BX0C+wVfpBeG8eY4h
 q2Tn5xgqWWrLte6L6kg6CP2LnvF6fgr4oO3MqaVh/wypuQEOkj4UB0Zy3UWFKO+0qKzz
 LYM5DxVmf4slI/JrvynV+XPmlJq7NFSvxzF5hmZOKoqlAIZw23Be9DnmcVe5dFwXy5ds
 6zVait82OZQGKIgoZOWxBVT5HqOto7zYoGc2vWWFmn6lMMtdiVWgs0ctFAP6tOxeBMrp
 8lEt33O/XzYVKlemceztgxXa3EP4sD0dCc37GNavh//6ugGVoCyBy/I4myNJO8idbeGU
 hyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790079874; x=1790684674;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UUaMMfxQGVaqYsCWtIJm0K45AS9SWg4KO2Ze0P1/tlI=;
 b=shrcGYTc13/TDjJFPIM1yhsO8s5Qlvdkdwr+FJ8lDDukV8Kx/nNIqYTkY/y6wQu3mO
 wHRgYwS90xPfAJCiecjR28Cj29bXIquMUlm/Bqzb1D/WmVUn3s2AMi3hUpSBFywo7nqS
 bb1+dcD5k8JbjF8B+5995TIDpB9kf+uKVRjNmI+UubHryNpKxJga0IP+7j02UJNE5p7w
 4KDIMGeg+fKXJba9SsNbLK+W1L6r0kngaGRt47Spo+W4YMeRVQD01PSKrlGCKnXBbp2u
 u3HbL69ltv3v2FVGqnWYYBLESFFWmLNRwe0I+8oJrjJAXXAIqg6b4ohjcWVmr2M2+ykZ
 VkuA==
X-Gm-Message-State: AFuF++kw3g96qTlxs5Wpc+eVPUEuf1zF1FGBJ+DAJ8g6c+WxDZIq4ilU
 +EcJeKG2Q9HBxH3qZxCKRRLe3nb6YS8L9+AS25EVu5zZK6vSTseZfEgEKc/vlplA7XW+//jwE/3
 BjFKK1bP/GRKGOwzGk1B6K6PJ9ayXq0e3CrDxltXnqyky9R3LL3gFa12kbSPNkMTzRcNzEYrCm/
 Keshn/6A==
X-Gm-Gg: AYBFou1DV8rKvQEiqHrc4pQGEWKEzU26m331XU9dNDLbT7ZIbeyV7ZIBsK2DMuKfs6M
 nJSB0FxbNDOMoet0kl8d7w5lKJ/DInD2MnjWTg8YEI7LUDSTlq/UglCioOyNbt9qQtrDcoPSTwI
 hsyNuYmcfU2JM3RzOpy6l36jEnVo08OiteZ3wrG/3NB5+LhDwmsbMjFRWAjX7MPAnJHGcuAN2C5
 LD7r2jzYi5wxvm8yB63rffgWcwNvKYe4KZHZAnOBKiaZkPoRWJFbHEl1/i25ZmNf81mRCp7reYe
 NiRxO4upuaaxiSdyZgpVDTaqhnJQFQ0OIqF96ZNWlmlx+CSSBHUA+178bv6CWyYgWG75T4nmGjQ
 DtXDs7nVEsK51b+ItEfOy1OdlTP620HOM8l3c7YK7pJH0DZ1ViZT0xBDp0duA9cMeZzRc+S4bqv
 D2KDkS8Yz5QwK440U0upyab7qXSLsaan2+PSww2CMD7zrOsxYfMlQbzqH9q6XxVwGozz6sJH9YE
 6OCtRdOsuQW6ozZlxUOMDE4Ek0ofZIqkZJLBm5BUUKKQ6DUh1WLyz46FyQUaBuBrvnQHmrImbMT
 BMTV+SOBVNGh2nzjFj0dW9sF8wHHo1B5hvrQ/2octdrJKxYjGzFlqfPb4MAq
X-Received: by 2002:a05:600c:3544:b0:49e:7c8c:bc77 with SMTP id
 5b1f17b1804b1-49fd8868d52mr43092875e9.7.1790079873844; 
 Tue, 22 Sep 2026 05:24:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdad36542sm55315275e9.7.2026.09.22.05.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:24:33 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 12:24:28 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iecffd01567376960c9393770ffe05665073b067a
X-Gerrit-Change-Number: 1941
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1941?usp=email>
X-Gerrit-Commit: 80dcf6096a4e458e4112e1efb6d013ac30242750
In-Reply-To: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
References: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDcyMzk4MDAwLkllY2ZmZDAxNTY3Mzc2OTYwYzkzOTM3NzBmZmUwNTY2NTA3M2IwNjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7c8c7663b4e33e5cce2b3d1ddc34291ee4f580a7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x8zY8-0002zw-Ow
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
Content-Type: multipart/mixed; boundary="===============3386879474542145210=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3386879474542145210==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ViotDjdqNHM="; charset=UTF-8

--ViotDjdqNHM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#2)=2E ( http://gerrit=2Eopenvpn=2E=
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
M src/openvpn/init=2Ec
M src/openvpn/options=2Ec
M sr=
c/openvpn/options=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
5 =
files changed, 36 insertions(+), 3 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1941/2

diff --git a/src/ope=
nvpn/init=2Ec b/src/openvpn/init=2Ec
index 8a449e8=2E=2E8bfa5d1 100644
--- =
a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3286,6 +3286,7 @@
   =
  to=2Epacket_timeout =3D options->tls_timeout;
     to=2Erenegotiate_bytes=
 =3D options->renegotiate_bytes;
     to=2Erenegotiate_packets =3D options-=
>renegotiate_packets;
+    to=2Eaead_usage_limit_override =3D options->aead=
_usage_limit_override;
     if (options->renegotiate_seconds_min < 0)
     =
{
         /* Add 10% jitter to reneg-sec by default (server side only) */
=
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index e3cd52=
7=2E=2E133c035 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/optio=
ns=2Ec
@@ -7578,6 +7578,20 @@
             options->renegotiate_seconds_min=
 =3D positive_atoi(p[2], msglevel);
         }
     }
+#ifdef ENABLE_DEBUG
=
+    else if (streq(p[0], "debug-aead-usage-limit-override"))
+    {
+     =
   /* This option is undocumented since it should not be used by normal
+  =
       * users */
+        VERIFY_PERMISSION(OPT_P_TLS_PARMS);
+        if =
(!positive_atoll(p[1], &options->aead_usage_limit_override, p[0], msglevel)=
)
+        {
+            msg(M_VERB0, "Warning: --debug-aead-usage-limit-o=
verride should "
+                         "only be used by developers and =
in specific tests=2E");
+            goto err;
+        }
+    }
+#endif
  =
   else if (streq(p[0], "hand-window") && p[1] && !p[2])
     {
         VE=
RIFY_PERMISSION(OPT_P_TLS_PARMS);
diff --git a/src/openvpn/options=2Eh b/sr=
c/openvpn/options=2Eh
index f472676=2E=2Ea0a08d5 100644
--- a/src/openvpn/o=
ptions=2Eh
+++ b/src/openvpn/options=2Eh
@@ -646,6 +646,9 @@
     int reneg=
otiate_seconds;
     int renegotiate_seconds_min;
 
+    /** Debug override=
 to trigger AEAD usage limit early */
+    int64_t aead_usage_limit_overrid=
e;
+
     /* Data channel key handshake must finalize
      * within n seco=
nds of handshake initiation=2E */
     int handshake_window;
diff --git a/s=
rc/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index b6595ab=2E=2Ecb53f9f 100644
=
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -126,11 +126,11 @@
 =
}
 
 static uint64_t
-tls_get_limit_aead(const char *ciphername)
+tls_get_l=
imit_aead(const char *ciphername, uint64_t override)
 {
     uint64_t limit=
 =3D cipher_get_aead_limits(ciphername);
 
-    if (limit =3D=3D 0)
+    if=
 (limit =3D=3D 0 && override =3D=3D 0)
     {
         return 0;
     }
@@ =
-139,6 +139,11 @@
      * we go over the limit */
     limit =3D limit / 8 =
* 7;
 
+    if (override > 0)
+    {
+        limit =3D override;
+    }
+
=
     msg(D_SHOW_KEYS,
         "Note: AEAD cipher %s will trigger a renegot=
iation"
         " at a sum of %" PRIi64 " blocks and packets=2E",
@@ -1397=
,6 +1402,11 @@
      * */
     epoch_init_key_ctx(co, key_type, &e1_send, &=
e1_recv, future_key_count);
 
+    if (multi->opt=2Eaead_usage_limit_overri=
de)
+    {
+        co->aead_usage_limit =3D multi->opt=2Eaead_usage_limit_=
override;
+    }
+
     secure_memzero(&e1_send, sizeof(e1_send));
     sec=
ure_memzero(&e1_recv, sizeof(e1_recv));
 }
@@ -1619,7 +1629,7 @@
     }
   =
  tls_limit_reneg_bytes(session->opt->key_type=2Ecipher, &session->opt->ren=
egotiate_bytes);
 
-    session->opt->aead_usage_limit =3D tls_get_limit_ae=
ad(session->opt->key_type=2Ecipher);
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
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1941?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iec=
ffd01567376960c9393770ffe05665073b067a
Gerrit-Change-Number: 1941
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ViotDjdqNHM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Add --debug-aead-usage-limit-override option<br><br>Normal users =
should not touch this option since there is normally<br>no reason to mess w=
ith the number of safely encrypted packets=2E<br><br>However, during to che=
ck if the epoch key rollover works as expected<br>it is helpful to trigger =
this mechanism early=2E Since constantly<br>patching OpenVPN to do this in =
tests is messy, introduce an undocumented<br>option to allow enabling this =
behaviour=2E<br><br>Change-Id: Iecffd01567376960c9393770ffe05665073b067a<br=
>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/ope=
nvpn/init=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>=
M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>5 files changed, 3=
6 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1941/2</pre><pre style=
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
src/openvpn/options=2Ec</span><br><span>index e3cd527=2E=2E133c035 100644</=
span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/open=
vpn/options=2Ec</span><br><span>@@ -7578,6 +7578,20 @@</span><br><span>    =
         options-&gt;renegotiate_seconds_min =3D positive_atoi(p[2], msglev=
el);</span><br><span>         }</span><br><span>     }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_DEBUG</span><br><span styl=
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
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     else if (str=
eq(p[0], &quot;hand-window&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><=
br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_TLS_PARMS)=
;</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/option=
s=2Eh</span><br><span>index f472676=2E=2Ea0a08d5 100644</span><br><span>---=
 a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</s=
pan><br><span>@@ -646,6 +646,9 @@</span><br><span>     int renegotiate_seco=
nds;</span><br><span>     int renegotiate_seconds_min;</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Debug override=
 to trigger AEAD usage limit early */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int64_t aead_usage_limit_override;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Data channel =
key handshake must finalize</span><br><span>      * within n seconds of han=
dshake initiation=2E */</span><br><span>     int handshake_window;</span><b=
r><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><s=
pan>index b6595ab=2E=2Ecb53f9f 100644</span><br><span>--- a/src/openvpn/ssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -126,11 +=
126,11 @@</span><br><span> }</span><br><span> </span><br><span> static uint=
64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_get_limit_aea=
d(const char *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+tls_get_limit_aead(const char *ciphername, uint64_t override)</span><=
br><span> {</span><br><span>     uint64_t limit =3D cipher_get_aead_limits(=
ciphername);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (limit =3D=3D 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (limit =3D=3D 0 &amp;&amp; override =3D=3D 0)</span><br=
><span>     {</span><br><span>         return 0;</span><br><span>     }</sp=
an><br><span>@@ -139,6 +139,11 @@</span><br><span>      * we go over the li=
mit */</span><br><span>     limit =3D limit / 8 * 7;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (override &gt; 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        limit =3D override;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     msg(D_SHOW_KEYS,<=
/span><br><span>         &quot;Note: AEAD cipher %s will trigger a renegoti=
ation&quot;</span><br><span>         &quot; at a sum of %&quot; PRIi64 &quo=
t; blocks and packets=2E&quot;,</span><br><span>@@ -1397,6 +1402,11 @@</spa=
n><br><span>      * */</span><br><span>     epoch_init_key_ctx(co, key_type=
, &amp;e1_send, &amp;e1_recv, future_key_count);</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;opt=2Eaead=
_usage_limit_override)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co-=
&gt;aead_usage_limit =3D multi-&gt;opt=2Eaead_usage_limit_override;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     secure_memzero(&amp=
;e1_send, sizeof(e1_send));</span><br><span>     secure_memzero(&amp;e1_rec=
v, sizeof(e1_recv));</span><br><span> }</span><br><span>@@ -1619,7 +1629,7 =
@@</span><br><span>     }</span><br><span>     tls_limit_reneg_bytes(sessio=
n-&gt;opt-&gt;key_type=2Ecipher, &amp;session-&gt;opt-&gt;renegotiate_bytes=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   session-&gt;opt-&gt;aead_usage_limit =3D tls_get_limit_aead(session-&gt;=
opt-&gt;key_type=2Ecipher);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    session-&gt;opt-&gt;aead_usage_limit =3D tls_get_limit_aead(ses=
sion-&gt;opt-&gt;key_type=2Ecipher, session-&gt;opt-&gt;aead_usage_limit_ov=
erride);</span><br><span> </span><br><span>     /* set the state of the key=
s for the session to generated */</span><br><span>     ks-&gt;state =3D S_G=
ENERATED_KEYS;</span><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/sr=
c/openvpn/ssl_common=2Eh</span><br><span>index f6392f9=2E=2E579f46c 100644<=
/span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/=
openvpn/ssl_common=2Eh</span><br><span>@@ -346,6 +346,11 @@</span><br><span=
>     /** limit for AEAD cipher when not running in epoch data key mode,</s=
pan><br><span>      *  this is the sum of packets + blocks that are allowed=
 to be used */</span><br><span>     uint64_t aead_usage_limit;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * Debug only option that allows overrid=
ing the usage limit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * This allows testing key rotation by using very small limits</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint64_t aead_usage_limit_override;<=
/span><br><span>     interval_t renegotiate_seconds;</span><br><span> </spa=
n><br><span>     /* cert verification parms */</span><br></pre><p>To view, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3Demail=
">change 1941</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/194=
1?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Iecffd01567376960c9393770ffe05665073b067a </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1941 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>

</body></html>
--ViotDjdqNHM=--


--===============3386879474542145210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3386879474542145210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3386879474542145210==--

