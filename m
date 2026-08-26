Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57646C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rPGFz7T+SITOnpK5tdUeoHJkwQsxomYiuUGje+e+AA4=; b=aOAUDOhPDKTYm9qNTO71IFHqLm
	XTMLWbp3bFKTIFAnAviXZkyvc74HOSPiMgPib6p+dj0Xanh021DQLpFBu+VppsnrIgxMF1zj+0is3
	2SWgP2E/ECj44onAb84xTTYlU4VD9tgrpJgRCWTAkCV1D3v/LCtleA0mMEvcwscTa348=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzIn7-0007d9-3l;
	Wed, 26 Aug 2026 18:56:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzIn6-0007d3-8n
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 18:56:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pb3+jQNRrRi/t1El04TkardLupxq+xn5tQheyyhkLNA=; b=izEx4t3mErnvfTn3Jbf3LiAqXl
 1c2MXOvLHL1UJogIA0dSj/Bbpz3HKA9m6U/SFy1w4qrssDo4Fuumy6ovg8Vsoc3LqCF+QuAVP/f4M
 ev3jkzgIX/Abddk/vxdJO5P/zFF84ZkO15y/kGWvWUUu0QHSyqQ/Exox/Sp70/UssaxY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pb3+jQNRrRi/t1El04TkardLupxq+xn5tQheyyhkLNA=; b=m
 K14hhZQ9qRHkZ32qpf7wnW5Id7MZTDAtkBnfrP+QdC0sMLnFiW+y1ydLoqw3AVMTERM3IdWU+TJo+
 o239wJ01OymTdDVWpIFisn0/Yy0G2hcX12GcPobywuiGgEQr2QFTthVGGWojZBWHU1wn7kZovtVxh
 KSkdtrelpgAEoX+w=;
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzIn5-0006U7-0g for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 18:56:04 +0000
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c252c7270faso136609166b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787770556; x=1788375356; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pb3+jQNRrRi/t1El04TkardLupxq+xn5tQheyyhkLNA=;
 b=asM6b6nUrrkReZB8E9QUULGOH4qnteUg8NglTNQrzrKAC+RH0/RUZYZYuVKVXZgJ/u
 Lfv2OyhkAXC/piTYYM525U4Vr4xcPKfl6hwb97TQEfgRvfYKIIq8d1t2RmzN4uWJurta
 O8W5syAiV5mJ+J9vKDpKOuI58ouhEEVwVY7kABprj8r/vVzpdTyLSVQ5SjwU5s/V17bS
 PTnAEUCKMj60m7Lnezp/PDj5mLxUfgW/xzNo8q/kBO9IgDtxAlFVX+LPPPUGObJje14T
 eN4TO7xTgmvIeRvw/SLCVXcMIQxd7COqtoJF5a382tAYQKcwAoliChB59ZWbji1t8FcO
 6sWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787770556; x=1788375356;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pb3+jQNRrRi/t1El04TkardLupxq+xn5tQheyyhkLNA=;
 b=opgA3spkmmoq+mRbHGTiCjWIcoMWlWTYn6Y4B0x305Wg+XMHl+SmX+UeMqakaGNpDZ
 TiFqu8+io+2uqCnSS7a+eNkyE+lyazGqdH/F4MNNgo69Dl0tG4ucCLUBWeZ8aBjYxOou
 2zXnfIg2nq4cRy0aZVO772+/zWAAQnMlS6Qk8zHhfgoVvaGrxOyGjmPpeZN7E41qxd4w
 lcu4aK/Ilhd0XjW6X4Z7M2QYTfPve16TCZmRVa9fbjtf5GmEpWN9SPMkPp7odTheB0KJ
 5U7MBGHi16F0aS9WSU1YWWkPXLYZFN8LSGqMCXxE5Tl8XYr8lrsRI8RZ9bYJaEZ27zP7
 9UGg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+75AgRiSBW6N8rkbDWszrqUFYqwi72w34usUi/qgl1REm7RCJxmeTZCrP/HDhdTSHe4PCK02UZ1PjgfQK@lists.sourceforge.net
X-Gm-Message-State: AFuF++kS5ZKc5kb1+7Lm3Zt/PDCZovVQoHT/fAaztr1iCCSSrCZtbUDM
 tgdVwHQHjGlnThv8caE4AEluXPuIiAPyUuN8J5PmNSmyLuMoT1m8UZRyoAbX3AcvpqZIfPTdFwS
 tF79rNrnz75GupbDVu+hUsfL+nw7mCbgPAhy3CNd2Auwt7kZfwDcLusuuZEAvpN38Mbo3
X-Gm-Gg: AR+sD126QLootGrMWWOj4tZVIM05UEq3B5NS+N4YxAsZFVOjqh+LEk9c37ewIDdHx82
 hCNTXROpcRExaKKB6afvDEIZzeMBxtOQ/lkqw9mULY8R7wMjT68c5qqnFSBM+v5bpUrfo6rPF3H
 UKJnZOrGPu6/NN/1dn/QzdNbZaUxe2j1XO4YVvm/I9bjzsNnrk7exyP+FNKja2fZfTXUz9C5TAU
 rYzwF7c0/YQJ13pQ+sj9LLyXR8fNdDoc3B94D8Kkgsiinsgpb4pPl59WGVXAlc7/tv+rlzGGXkJ
 gA39La7A7nphYBxqwdLHU1R+FA7yqdp3eWa2XtSAmOxAf2yESAmnmz6w3PWKs4lIDp53YM4ngnq
 /QW1BOg6HA7Y9a2/qf6P6IEQponEB57Hc1fGiOOAsqbteu4ZOKmXS0mb7dcKEPx/Rvt4QrNahAj
 w2xmW8TJVTfMyD1EOuFtEVA0cEF7RjK53KpwKnS3kRZ2y12fb2WkKOEmoP2VJJFvevmKGoopxOs
 aSocrr5ripRhA78RrXzjkJEU81Tkzr4T53uXCqmdJ+xOBGf9gdvyIrT6sLNpJpSdUW8xDj6DXZy
 9eVz4i1hXauLPfDFKeknVa3YjXSico1/J5T34JmoJ4uE+CTvocc=
X-Received: by 2002:a17:907:3ccb:b0:c20:1db7:f486 with SMTP id
 a640c23a62f3a-c250bac7f57mr548784166b.4.1787770556277; 
 Wed, 26 Aug 2026 11:55:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88aa0asm697452266b.35.2026.08.26.11.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:55:55 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 18:55:54 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I41b9f7686180f2549bd4984cbbf66059f0ba2b15
X-Gerrit-Change-Number: 1259
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1259?usp=email>
X-Gerrit-Commit: 2508b2d749f3cd4d951867156700af30c0db7eae
In-Reply-To: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@gerrit.openvpn.net>
References: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU5OTM5OTE3MDAwLkk0MWI5Zjc2ODYxODBmMjU0OWJkNDk4NGNiYmY2NjA1OWYwYmEyYjE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6bb91f9e786dd148a507c5f39ed6b403275c980d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzIn5-0006U7-0g
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: Fix conversion
 warnings
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7252424909450627551=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7252424909450627551==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ymuqdoqUPr8="; charset=UTF-8

--ymuqdoqUPr8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#21) to the change originally created b=
y flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Dem=
ail )

The following approvals got outdated and were removed:
Code-Review+2=
 by plaisthos


Change subject: init: Fix conversion warnings
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: Fix conversion warn=
ings

Can be separated in mostly two classes of issues:
 - Return type of g=
et_random is int64_t, but we ensure that value
   is in range so we can cas=
t it to whatever we need=2E
 - Doing MTU match in size_t even though most o=
f the input
   values are int=2E

Change-Id: I41b9f7686180f2549bd4984cbbf66=
059f0ba2b15
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acke=
d-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1259
Message-Id: <20260826123346=2E14535-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg38722=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
1 file changed, 20 insertion=
s(+), 28 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/59/1259/21

diff --git a/src/openvpn/init=2Ec b/src/openvpn=
/init=2Ec
index a8e041d=2E=2E1109a13 100644
--- a/src/openvpn/init=2Ec
+++ =
b/src/openvpn/init=2Ec
@@ -456,12 +456,7 @@
 }
 #endif /* ENABLE_MANAGEMENT=
 */
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic =
push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-/*
+/**
  * =
Initialize and possibly randomize the connection list=2E
  *
  * Applies th=
e Fisher-Yates shuffle algorithm to ensure all permutations
@@ -480,10 +475=
,9 @@
     l->current =3D -1;
     if (c->options=2Eremote_random)
     {
-=
        int i;
-        for (i =3D l->len - 1; i > 0; --i)
+        for (in=
t i =3D l->len - 1; i > 0; --i)
         {
-            const int j =3D get=
_random() % (i + 1);
+            const int64_t j =3D get_random() % (i + 1=
);
             if (i !=3D j)
             {
                 struct connec=
tion_entry *tmp;
@@ -838,7 +832,7 @@
     struct timeval tv;
     if (!gett=
imeofday(&tv, NULL))
     {
-        const unsigned int seed =3D (unsigned =
int)tv=2Etv_sec ^ tv=2Etv_usec;
+        const unsigned int seed =3D (unsig=
ned int)(tv=2Etv_sec ^ tv=2Etv_usec);
         srandom(seed);
     }
 
@@ -=
2839,7 +2833,7 @@
     }
 }
 
-static size_t
+static int
 get_frame_mtu(str=
uct context *c, const struct options *o)
 {
     size_t mtu;
@@ -2863,7 +28=
57,12 @@
         msg(M_WARN, "TUN MTU value (%zu) must be at least %d", mt=
u, TUN_MTU_MIN);
         frame_print(&c->c2=2Eframe, M_FATAL, "MTU is too =
small");
     }
-    return mtu;
+    if (mtu > TUN_MTU_MAX)
+    {
+      =
  msg(M_WARN, "TUN MTU value (%zu) clamped to %d", mtu, TUN_MTU_MAX);
+    =
    mtu =3D TUN_MTU_MAX;
+    }
+    return (int)mtu;
 }
 
 /*
@@ -2889,11 =
+2888,11 @@
      * space to allow server to push "baby giant" MTU sizes */=

     frame->tun_max_mtu =3D max_int(TUN_MTU_MAX_MIN, frame->tun_max_mtu);
=
 
-    size_t payload_size =3D frame->tun_max_mtu;
+    unsigned int payloa=
d_size =3D frame->tun_max_mtu;
 
     /* we need to be also large enough to=
 hold larger control channel packets
      * if configured */
-    payload_=
size =3D max_int(payload_size, o->ce=2Etls_mtu);
+    payload_size =3D max_=
uint(payload_size, o->ce=2Etls_mtu);
 
     /* The extra tun needs to be ad=
ded to the payload size */
     if (o->ce=2Etun_mtu_defined)
@@ -2908,7 +29=
07,7 @@
 
     /* the space that is reserved before the payload to add extr=
a headers to it
      * we always reserve the space for the worst case */
-=
    size_t headroom =3D 0;
+    unsigned int headroom =3D 0;
 
     /* incl=
udes IV and packet ID */
     headroom +=3D crypto_max_overhead();
@@ -2932=
,11 +2931,11 @@
     /* the space after the payload, this needs some extra =
buffer space for
      * encryption so headroom is probably too much but we=
 do not really care
      * the few extra bytes */
-    size_t tailroom =3D=
 headroom;
+    unsigned int tailroom =3D headroom;
 
 #ifdef USE_COMP
    =
 msg(D_MTU_DEBUG,
-        "MTU: adding %zu buffer tailroom for compression=
 for %zu "
+        "MTU: adding %u buffer tailroom for compression for %u =
"
         "bytes of payload",
         COMP_EXTRA_BUFFER(payload_size), pa=
yload_size);
     tailroom +=3D COMP_EXTRA_BUFFER(payload_size);
@@ -3278,1=
8 +3277,15 @@
     if (options->renegotiate_seconds_min < 0)
     {
       =
  /* Add 10% jitter to reneg-sec by default (server side only) */
-        =
int auto_jitter =3D options->mode !=3D MODE_SERVER
-                       =
       ? 0
-                              : get_random() % max_int(options-=
>renegotiate_seconds / 10, 1);
+        int jitter_max =3D max_int(options-=
>renegotiate_seconds / 10, 1);
+        int auto_jitter =3D options->mode !=
=3D MODE_SERVER ? 0 : (int)(get_random() % jitter_max);
         to=2Ereneg=
otiate_seconds =3D options->renegotiate_seconds - auto_jitter;
     }
     =
else
     {
         /* Add user-specified jitter to reneg-sec */
-        =
to=2Erenegotiate_seconds =3D
-            options->renegotiate_seconds
-   =
         - (get_random()
-               % max_int(options->renegotiate_sec=
onds - options->renegotiate_seconds_min, 1));
+        int jitter_max =3D m=
ax_int(options->renegotiate_seconds - options->renegotiate_seconds_min, 1);=

+        to=2Erenegotiate_seconds =3D options->renegotiate_seconds - (int)=
(get_random() % jitter_max);
     }
     to=2Esingle_session =3D options->s=
ingle_session;
     to=2Emode =3D options->mode;
@@ -3482,10 +3478,6 @@
   =
  }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnost=
ic pop
-#endif
-
 /*
  * No encryption or authentication=2E
  */

-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I41b9f7686180f2549bd4984c=
bbf66059f0ba2b15
Gerrit-Change-Number: 1259
Gerrit-PatchSet: 21
Gerrit-Owne=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@gree=
nie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: =
razvanc <razvanc@mailbox=2Eorg>

--ymuqdoqUPr8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #21</strong> to the change originally created by flichtenhe=
ld=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">init: Fix conversio=
n warnings<br><br>Can be separated in mostly two classes of issues:<br> - R=
eturn type of get_random is int64_t, but we ensure that value<br>   is in r=
ange so we can cast it to whatever we need=2E<br> - Doing MTU match in size=
_t even though most of the input<br>   values are int=2E<br><br>Change-Id: =
I41b9f7686180f2549bd4984cbbf66059f0ba2b15<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1259<br>Message-Id: &lt;20260826123346=2E14535-1-gert@greenie=2Emuc=2Ed=
e&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg38722=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/init=2Ec<br>1 file changed, 20 inse=
rtions(+), 28 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/1259/21</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index a8e041d=
=2E=2E1109a13 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><=
span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -456,12 +456,7 @@</span>=
<br><span> }</span><br><span> #endif /* ENABLE_MANAGEMENT */</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span>  * Initialize and possibly randomize the connection list=2E</sp=
an><br><span>  *</span><br><span>  * Applies the Fisher-Yates shuffle algor=
ithm to ensure all permutations</span><br><span>@@ -480,10 +475,9 @@</span>=
<br><span>     l-&gt;current =3D -1;</span><br><span>     if (c-&gt;options=
=2Eremote_random)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        int i;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        for (i =3D l-&gt;len - 1; i &gt; 0; --i)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D l-&gt;len -=
 1; i &gt; 0; --i)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            const int j =3D get_random() % (i + 1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const i=
nt64_t j =3D get_random() % (i + 1);</span><br><span>             if (i !=
=3D j)</span><br><span>             {</span><br><span>                 stru=
ct connection_entry *tmp;</span><br><span>@@ -838,7 +832,7 @@</span><br><sp=
an>     struct timeval tv;</span><br><span>     if (!gettimeofday(&amp;tv, =
NULL))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        const unsigned int seed =3D (unsigned int)tv=2Etv_sec ^ tv=
=2Etv_usec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
const unsigned int seed =3D (unsigned int)(tv=2Etv_sec ^ tv=2Etv_usec);</sp=
an><br><span>         srandom(seed);</span><br><span>     }</span><br><span=
> </span><br><span>@@ -2839,7 +2833,7 @@</span><br><span>     }</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-static size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic int</span><br><span> get_frame_mtu(struct context *c, const struct opt=
ions *o)</span><br><span> {</span><br><span>     size_t mtu;</span><br><spa=
n>@@ -2863,7 +2857,12 @@</span><br><span>         msg(M_WARN, &quot;TUN MTU=
 value (%zu) must be at least %d&quot;, mtu, TUN_MTU_MIN);</span><br><span>=
         frame_print(&amp;c-&gt;c2=2Eframe, M_FATAL, &quot;MTU is too small=
&quot;);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    return mtu;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (mtu &gt; TUN_MTU_MAX)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(M_WARN, &quot;TUN MTU value (%zu) clamped to %d&quot;, mtu, T=
UN_MTU_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 mtu =3D TUN_MTU_MAX;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (=
int)mtu;</span><br><span> }</span><br><span> </span><br><span> /*</span><br=
><span>@@ -2889,11 +2888,11 @@</span><br><span>      * space to allow serve=
r to push &quot;baby giant&quot; MTU sizes */</span><br><span>     frame-&g=
t;tun_max_mtu =3D max_int(TUN_MTU_MAX_MIN, frame-&gt;tun_max_mtu);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t p=
ayload_size =3D frame-&gt;tun_max_mtu;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    unsigned int payload_size =3D frame-&gt;tun_max_mtu;=
</span><br><span> </span><br><span>     /* we need to be also large enough =
to hold larger control channel packets</span><br><span>      * if configure=
d */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    payload_size =
=3D max_int(payload_size, o-&gt;ce=2Etls_mtu);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    payload_size =3D max_uint(payload_size, o-&g=
t;ce=2Etls_mtu);</span><br><span> </span><br><span>     /* The extra tun ne=
eds to be added to the payload size */</span><br><span>     if (o-&gt;ce=2E=
tun_mtu_defined)</span><br><span>@@ -2908,7 +2907,7 @@</span><br><span> </s=
pan><br><span>     /* the space that is reserved before the payload to add =
extra headers to it</span><br><span>      * we always reserve the space for=
 the worst case */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 size_t headroom =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    unsigned int headroom =3D 0;</span><br><span> </span><br><span>    =
 /* includes IV and packet ID */</span><br><span>     headroom +=3D crypto_=
max_overhead();</span><br><span>@@ -2932,11 +2931,11 @@</span><br><span>   =
  /* the space after the payload, this needs some extra buffer space for</s=
pan><br><span>      * encryption so headroom is probably too much but we do=
 not really care</span><br><span>      * the few extra bytes */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    size_t tailroom =3D headroom;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int ta=
ilroom =3D headroom;</span><br><span> </span><br><span> #ifdef USE_COMP</sp=
an><br><span>     msg(D_MTU_DEBUG,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        &quot;MTU: adding %zu buffer tailroom for compression =
for %zu &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   &quot;MTU: adding %u buffer tailroom for compression for %u &quot;</span=
><br><span>         &quot;bytes of payload&quot;,</span><br><span>         =
COMP_EXTRA_BUFFER(payload_size), payload_size);</span><br><span>     tailro=
om +=3D COMP_EXTRA_BUFFER(payload_size);</span><br><span>@@ -3278,18 +3277,=
15 @@</span><br><span>     if (options-&gt;renegotiate_seconds_min &lt; 0)<=
/span><br><span>     {</span><br><span>         /* Add 10% jitter to reneg-=
sec by default (server side only) */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        int auto_jitter =3D options-&gt;mode !=3D MODE_SERVE=
R</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
          ? 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                      : get_random() % max_int(options-&gt;renegotiate_seco=
nds / 10, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  int jitter_max =3D max_int(options-&gt;renegotiate_seconds / 10, 1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        int auto_jitter =
=3D options-&gt;mode !=3D MODE_SERVER ? 0 : (int)(get_random() % jitter_max=
);</span><br><span>         to=2Erenegotiate_seconds =3D options-&gt;renego=
tiate_seconds - auto_jitter;</span><br><span>     }</span><br><span>     el=
se</span><br><span>     {</span><br><span>         /* Add user-specified ji=
tter to reneg-sec */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       to=2Erenegotiate_seconds =3D</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            options-&gt;renegotiate_seconds</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            - (get_random()</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-               % max_int(options-=
&gt;renegotiate_seconds - options-&gt;renegotiate_seconds_min, 1));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        int jitter_max =3D =
max_int(options-&gt;renegotiate_seconds - options-&gt;renegotiate_seconds_m=
in, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        to=
=2Erenegotiate_seconds =3D options-&gt;renegotiate_seconds - (int)(get_rand=
om() % jitter_max);</span><br><span>     }</span><br><span>     to=2Esingle=
_session =3D options-&gt;single_session;</span><br><span>     to=2Emode =3D=
 options-&gt;mode;</span><br><span>@@ -3482,10 +3478,6 @@</span><br><span> =
    }</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * N=
o encryption or authentication=2E</span><br><span>  */</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1259?usp=3Demail">change 1259</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1259?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I41b9f7686180f2549bd4984cbbf66059f0=
ba2b15 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1259 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&=
gt; </div>

</body></html>
--ymuqdoqUPr8=--


--===============7252424909450627551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7252424909450627551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7252424909450627551==--

