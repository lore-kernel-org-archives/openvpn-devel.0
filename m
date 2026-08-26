Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23416C5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U8qnEDiqmtTAr6z4wlRgOtZWRcr/56sHsySXHgyOcgw=; b=W5VCDYKgtk6ShDS71ed3MBye5x
	XAyFpdd+3p7LFa6q2SdvibzH0jfPVSU0wBofQ+/kjvFpPQ6Todf+/A2e4yYkzhF7KTTFe7JNtVoRI
	N59A0+AjgfJK3JUCM+T394fGDn8YyzOlXTrm7vIpE1emi9kp2zy6Sfc7qwExMV7AO2io=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzIn9-0006w4-HV;
	Wed, 26 Aug 2026 18:56:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzIn7-0006vw-IP
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 18:56:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=v02ajqsYxti3BzcEMm654ElPmByKfOW6OWV+ZRrK6/c=; b=hC0U86HO3MM6PiEihWYWL2UctM
 5Bj26DChROKUdAdw0U63HT6OW/7WjtSLe8AOnEL4dPWwr8EZXRBpAvrJYXW49dpg7XG3I6ajU+Y5U
 2DR4xAHuslHh5PGGZ4A7We2LrAuuliB/orsuWaSI0H7WNT+ZiYvp01/MhVjjfxdx3NKY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=v02ajqsYxti3BzcEMm654ElPmByKfOW6OWV+ZRrK6/c=; b=S
 sfOpvow3w2YL+7WlvMZJCooY9HBhU/ea6hYX5Etc93Lwa+vpyj0KtgmPQuDrBXM4Vkqju7wyNjHRv
 TtxN8oKaKkymoZlpJZKOtAxFt79na4RhZme2AonhmU/uVU/YIyaia6uPodIbYQp2+Khrl2HYYPAZV
 UMUVJairl3VBhoLM=;
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzIn6-0006U9-30 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 18:56:05 +0000
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so170086266b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787770557; x=1788375357; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v02ajqsYxti3BzcEMm654ElPmByKfOW6OWV+ZRrK6/c=;
 b=I16MRqzfkINPz8IXBVUSg5jcTE+DPzkmwZVSPIwzxNrzuQkGomertoHbjH/wSqN+I5
 f8Cql9HHJGVlJRb/uwJqdMPdk9CgtL0qQfeBmUOHTq1XZHFZjvbaL9f5IvuG1ybCqKQC
 dphkbwoe4qAXsspulqFanzfArpBM+Dcs336LP9pdxGZHKuaHxYfBbwQ6+QMyxdPOXWVW
 9+AUCXADGcc1WV91yj6s4Fxz7y5BXHRIIZZ5iC1OzP/KP31Se6QgA1apzYEhX+Pq9eTm
 HDIwcABuOmwBdImYWdBnMWHa4bHcqwOwB3ugFOo9E8aRMfOb7binyee1dn+RpS0lgeht
 nEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787770557; x=1788375357;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=v02ajqsYxti3BzcEMm654ElPmByKfOW6OWV+ZRrK6/c=;
 b=XMP2NyB2m4xhg18hiRi71tt2ikQDzMD7wmDpPuM40pql4DdBD6/wXJ6HNa5Ca8kb1W
 xSLM2Fb9ToI300DtheRVznEamPRENjKB2Sc+H7cknlWABkPTiGUdfvvLiWv1r8/rurg3
 qjflS3gF6LpJgPwmKA3S3J48vNiT0CkgAV59i2aG/ds1y0bjZrQhNQKCVfZqndG/0Jzp
 gZf0R8UH7LH5RL4+HsYuYJzFWgegn85a+Xe+muKcQ+MuQ2+WNlnB43PAXi1PW2yo8Rkt
 tQy5b1Mk5JAUBoh0sdaZEwllEP+YYgpkgpiQEep/gdx5qm6zHEA2mc5PriaZVh6DRkMc
 DKVA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkUzx8dE9MjU5smqjypd6vMYvFHbfiMOOhZ2q7SBWKLDQytB/XWv/xpDsA+R250UzmGTvdbqyGe3zUWJu/@lists.sourceforge.net
X-Gm-Message-State: AFuF++lXbG2GIc1ijzyVwWkTD9mfslRfVOXhjZ1WG1gnDaboRDDsOFbE
 2Y1f2ttOGiIHBk23Qk2zHGzd0J9Sca+IJD0Hazlvo5KwSuG/bpYLM5le5FKqrejpN5TKLgglVGp
 eTTX/HbXaFYcpXDC1O1QOXqDKOmW8FH4+iqVCre42MvMW6aPIpsCuZ0Tkqkl/hNN9a7/k
X-Gm-Gg: AR+sD12kbT4BHiFwuM0YVMX8KxGYAftGi2vR3qapnYNQ4qkbjeo57fC1zCLoM21cxc2
 zrul4cNof3ayt+IEqvUCY1+pp70eLOwFc5TP79ulUBIc0AQDy1pJFTkg+/K7v36yIJlEzIc7IaU
 uC+8eQ3RMt4uDAZHuqMgHg333cG2RQty342iZ+P3y6Z0/sZyr/0fUFKjl/VTbIi2Fx5qB3ox43I
 awbETXhFkDWJMq/Nxn3NqrjYlZi3s+YQz1cH8HeCKz5r9r54koGFQ08F2KlU5mAIsizb4a0V5fP
 v3vb/3Q0we/1pzOeMp9Yf7a895bqyYskpbG4pDGWjX3Jc0KakMkKVjqp99g/n/C+esGD8N9ep6C
 j9cvesk2jqu443C/lX1OtsVJnZc10Q+A1UIaHD6w6X0BVzZXfUZ9vQT7D2DlnHXFfwbJEzECPzV
 y0UW0J3/LFRQtZQvpRR9cvQZr7hF5NokJjfBJ1gMxL0eiR3ixE7UkL4r6TyX8JHbzAO6+yxZOv2
 TW7KUwa/swO9rrp3A3H4PRojH4CPoiWZ74mmYuF1IK3N+vT16OJYnfRQ5rF7t9Q4EivYX9rI9SO
 s8bOwqtj19cigamB4B6+rAcRHLvsUERCk4FS8Ktwvvd7bZHQW2w=
X-Received: by 2002:a17:907:ea94:b0:c16:6a42:c7d6 with SMTP id
 a640c23a62f3a-c250bb4efe6mr1007470566b.9.1787770557271; 
 Wed, 26 Aug 2026 11:55:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25127b66e5sm625087066b.45.2026.08.26.11.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:55:56 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 18:55:56 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I41b9f7686180f2549bd4984cbbf66059f0ba2b15
X-Gerrit-Change-Number: 1259
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1259?usp=email>
X-Gerrit-Commit: 2508b2d749f3cd4d951867156700af30c0db7eae
In-Reply-To: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@gerrit.openvpn.net>
References: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU5OTM5OTE3MDAwLkk0MWI5Zjc2ODYxODBmMjU0OWJkNDk4NGNiYmY2NjA1OWYwYmEyYjE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6bb91f9e786dd148a507c5f39ed6b403275c980d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzIn6-0006U9-30
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8804582045581569222=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8804582045581569222==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ehWaieWjGRk="; charset=UTF-8

--ehWaieWjGRk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1259?usp=3Demail )

Change subject: init: Fix conversion warnings
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: Fix conver=
sion warnings

Can be separated in mostly two classes of issues:
 - Return =
type of get_random is int64_t, but we ensure that value
   is in range so w=
e can cast it to whatever we need=2E
 - Doing MTU match in size_t even thou=
gh most of the input
   values are int=2E

Change-Id: I41b9f7686180f2549bd4=
984cbbf66059f0ba2b15
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259
Message-Id: <20260826123346=2E145=
35-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg38722=2Ehtml
Signed-off-by: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
1 file changed, 20 i=
nsertions(+), 28 deletions(-)




diff --git a/src/openvpn/init=2Ec b/src/o=
penvpn/init=2Ec
index a8e041d=2E=2E1109a13 100644
--- a/src/openvpn/init=2E=
c
+++ b/src/openvpn/init=2Ec
@@ -456,12 +456,7 @@
 }
 #endif /* ENABLE_MANA=
GEMENT */
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagn=
ostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-/*
+/*=
*
  * Initialize and possibly randomize the connection list=2E
  *
  * Appl=
ies the Fisher-Yates shuffle algorithm to ensure all permutations
@@ -480,1=
0 +475,9 @@
     l->current =3D -1;
     if (c->options=2Eremote_random)
  =
   {
-        int i;
-        for (i =3D l->len - 1; i > 0; --i)
+        f=
or (int i =3D l->len - 1; i > 0; --i)
         {
-            const int j =
=3D get_random() % (i + 1);
+            const int64_t j =3D get_random() %=
 (i + 1);
             if (i !=3D j)
             {
                 struct=
 connection_entry *tmp;
@@ -838,7 +832,7 @@
     struct timeval tv;
     if=
 (!gettimeofday(&tv, NULL))
     {
-        const unsigned int seed =3D (un=
signed int)tv=2Etv_sec ^ tv=2Etv_usec;
+        const unsigned int seed =3D=
 (unsigned int)(tv=2Etv_sec ^ tv=2Etv_usec);
         srandom(seed);
     }=

 
@@ -2839,7 +2833,7 @@
     }
 }
 
-static size_t
+static int
 get_frame_=
mtu(struct context *c, const struct options *o)
 {
     size_t mtu;
@@ -286=
3,7 +2857,12 @@
         msg(M_WARN, "TUN MTU value (%zu) must be at least =
%d", mtu, TUN_MTU_MIN);
         frame_print(&c->c2=2Eframe, M_FATAL, "MTU =
is too small");
     }
-    return mtu;
+    if (mtu > TUN_MTU_MAX)
+    {
=
+        msg(M_WARN, "TUN MTU value (%zu) clamped to %d", mtu, TUN_MTU_MAX)=
;
+        mtu =3D TUN_MTU_MAX;
+    }
+    return (int)mtu;
 }
 
 /*
@@ -2=
889,11 +2888,11 @@
      * space to allow server to push "baby giant" MTU s=
izes */
     frame->tun_max_mtu =3D max_int(TUN_MTU_MAX_MIN, frame->tun_max=
_mtu);
 
-    size_t payload_size =3D frame->tun_max_mtu;
+    unsigned int=
 payload_size =3D frame->tun_max_mtu;
 
     /* we need to be also large en=
ough to hold larger control channel packets
      * if configured */
-    p=
ayload_size =3D max_int(payload_size, o->ce=2Etls_mtu);
+    payload_size =
=3D max_uint(payload_size, o->ce=2Etls_mtu);
 
     /* The extra tun needs =
to be added to the payload size */
     if (o->ce=2Etun_mtu_defined)
@@ -29=
08,7 +2907,7 @@
 
     /* the space that is reserved before the payload to =
add extra headers to it
      * we always reserve the space for the worst c=
ase */
-    size_t headroom =3D 0;
+    unsigned int headroom =3D 0;
 
    =
 /* includes IV and packet ID */
     headroom +=3D crypto_max_overhead();
=
@@ -2932,11 +2931,11 @@
     /* the space after the payload, this needs som=
e extra buffer space for
      * encryption so headroom is probably too muc=
h but we do not really care
      * the few extra bytes */
-    size_t tail=
room =3D headroom;
+    unsigned int tailroom =3D headroom;
 
 #ifdef USE_C=
OMP
     msg(D_MTU_DEBUG,
-        "MTU: adding %zu buffer tailroom for com=
pression for %zu "
+        "MTU: adding %u buffer tailroom for compression=
 for %u "
         "bytes of payload",
         COMP_EXTRA_BUFFER(payload_s=
ize), payload_size);
     tailroom +=3D COMP_EXTRA_BUFFER(payload_size);
@@=
 -3278,18 +3277,15 @@
     if (options->renegotiate_seconds_min < 0)
     {=

         /* Add 10% jitter to reneg-sec by default (server side only) */
-=
        int auto_jitter =3D options->mode !=3D MODE_SERVER
-               =
               ? 0
-                              : get_random() % max_int(=
options->renegotiate_seconds / 10, 1);
+        int jitter_max =3D max_int(=
options->renegotiate_seconds / 10, 1);
+        int auto_jitter =3D options=
->mode !=3D MODE_SERVER ? 0 : (int)(get_random() % jitter_max);
         to=
=2Erenegotiate_seconds =3D options->renegotiate_seconds - auto_jitter;
    =
 }
     else
     {
         /* Add user-specified jitter to reneg-sec */
-=
        to=2Erenegotiate_seconds =3D
-            options->renegotiate_seco=
nds
-            - (get_random()
-               % max_int(options->renegot=
iate_seconds - options->renegotiate_seconds_min, 1));
+        int jitter_m=
ax =3D max_int(options->renegotiate_seconds - options->renegotiate_seconds_=
min, 1);
+        to=2Erenegotiate_seconds =3D options->renegotiate_seconds=
 - (int)(get_random() % jitter_max);
     }
     to=2Esingle_session =3D op=
tions->single_session;
     to=2Emode =3D options->mode;
@@ -3482,10 +3478,=
6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC =
diagnostic pop
-#endif
-
 /*
  * No encryption or authentication=2E
  */

-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I41b9f7686180f2549bd4984=
cbbf66059f0ba2b15
Gerrit-Change-Number: 1259
Gerrit-PatchSet: 21
Gerrit-Own=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@gre=
enie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC:=
 razvanc <razvanc@mailbox=2Eorg>

--ehWaieWjGRk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1259?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">init: Fix conversion warnings<br><br>Can b=
e separated in mostly two classes of issues:<br> - Return type of get_rando=
m is int64_t, but we ensure that value<br>   is in range so we can cast it =
to whatever we need=2E<br> - Doing MTU match in size_t even though most of =
the input<br>   values are int=2E<br><br>Change-Id: I41b9f7686180f2549bd498=
4cbbf66059f0ba2b15<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br=
>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259<br>Message-Id:=
 &lt;20260826123346=2E14535-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38722=2E=
html<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<=
br>M src/openvpn/init=2Ec<br>1 file changed, 20 insertions(+), 28 deletions=
(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec</span><br><span>index a8e041d=2E=2E1109a13 100644</span><br><span>--- =
a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br=
><span>@@ -456,12 +456,7 @@</span><br><span> }</span><br><span> #endif /* E=
NABLE_MANAGEMENT */</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored =
&quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span>  * Initialize and possibly ra=
ndomize the connection list=2E</span><br><span>  *</span><br><span>  * Appl=
ies the Fisher-Yates shuffle algorithm to ensure all permutations</span><br=
><span>@@ -480,10 +475,9 @@</span><br><span>     l-&gt;current =3D -1;</spa=
n><br><span>     if (c-&gt;options=2Eremote_random)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D l-&gt;len =
- 1; i &gt; 0; --i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        for (int i =3D l-&gt;len - 1; i &gt; 0; --i)</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const=
 int j =3D get_random() % (i + 1);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            const int64_t j =3D get_random() % (i + 1);</spa=
n><br><span>             if (i !=3D j)</span><br><span>             {</span=
><br><span>                 struct connection_entry *tmp;</span><br><span>@=
@ -838,7 +832,7 @@</span><br><span>     struct timeval tv;</span><br><span>=
     if (!gettimeofday(&amp;tv, NULL))</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        const unsigned int seed =3D=
 (unsigned int)tv=2Etv_sec ^ tv=2Etv_usec;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        const unsigned int seed =3D (unsigned int)(t=
v=2Etv_sec ^ tv=2Etv_usec);</span><br><span>         srandom(seed);</span><=
br><span>     }</span><br><span> </span><br><span>@@ -2839,7 +2833,7 @@</sp=
an><br><span>     }</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static size_t</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static int</span><br><span> get_frame_mtu(stru=
ct context *c, const struct options *o)</span><br><span> {</span><br><span>=
     size_t mtu;</span><br><span>@@ -2863,7 +2857,12 @@</span><br><span>   =
      msg(M_WARN, &quot;TUN MTU value (%zu) must be at least %d&quot;, mtu,=
 TUN_MTU_MIN);</span><br><span>         frame_print(&amp;c-&gt;c2=2Eframe, =
M_FATAL, &quot;MTU is too small&quot;);</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return mtu;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (mtu &gt; TUN_MTU_MAX)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;TUN MTU value (=
%zu) clamped to %d&quot;, mtu, TUN_MTU_MAX);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        mtu =3D TUN_MTU_MAX;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return (int)mtu;</span><br><span> }</span><br><span=
> </span><br><span> /*</span><br><span>@@ -2889,11 +2888,11 @@</span><br><s=
pan>      * space to allow server to push &quot;baby giant&quot; MTU sizes =
*/</span><br><span>     frame-&gt;tun_max_mtu =3D max_int(TUN_MTU_MAX_MIN, =
frame-&gt;tun_max_mtu);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    size_t payload_size =3D frame-&gt;tun_max_mtu;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int payload=
_size =3D frame-&gt;tun_max_mtu;</span><br><span> </span><br><span>     /* =
we need to be also large enough to hold larger control channel packets</spa=
n><br><span>      * if configured */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    payload_size =3D max_int(payload_size, o-&gt;ce=2Etls_mt=
u);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    payload_size=
 =3D max_uint(payload_size, o-&gt;ce=2Etls_mtu);</span><br><span> </span><b=
r><span>     /* The extra tun needs to be added to the payload size */</spa=
n><br><span>     if (o-&gt;ce=2Etun_mtu_defined)</span><br><span>@@ -2908,7=
 +2907,7 @@</span><br><span> </span><br><span>     /* the space that is res=
erved before the payload to add extra headers to it</span><br><span>      *=
 we always reserve the space for the worst case */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    size_t headroom =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    unsigned int headroom =3D 0;</span>=
<br><span> </span><br><span>     /* includes IV and packet ID */</span><br>=
<span>     headroom +=3D crypto_max_overhead();</span><br><span>@@ -2932,11=
 +2931,11 @@</span><br><span>     /* the space after the payload, this need=
s some extra buffer space for</span><br><span>      * encryption so headroo=
m is probably too much but we do not really care</span><br><span>      * th=
e few extra bytes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   size_t tailroom =3D headroom;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    unsigned int tailroom =3D headroom;</span><br><span> </spa=
n><br><span> #ifdef USE_COMP</span><br><span>     msg(D_MTU_DEBUG,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        &quot;MTU: adding %zu =
buffer tailroom for compression for %zu &quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        &quot;MTU: adding %u buffer tailroom for=
 compression for %u &quot;</span><br><span>         &quot;bytes of payload&=
quot;,</span><br><span>         COMP_EXTRA_BUFFER(payload_size), payload_si=
ze);</span><br><span>     tailroom +=3D COMP_EXTRA_BUFFER(payload_size);</s=
pan><br><span>@@ -3278,18 +3277,15 @@</span><br><span>     if (options-&gt;=
renegotiate_seconds_min &lt; 0)</span><br><span>     {</span><br><span>    =
     /* Add 10% jitter to reneg-sec by default (server side only) */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        int auto_jitter =3D =
options-&gt;mode !=3D MODE_SERVER</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                              ? 0</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                              : get_random() % max_=
int(options-&gt;renegotiate_seconds / 10, 1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        int jitter_max =3D max_int(options-&gt;re=
negotiate_seconds / 10, 1);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        int auto_jitter =3D options-&gt;mode !=3D MODE_SERVER ? 0 :=
 (int)(get_random() % jitter_max);</span><br><span>         to=2Erenegotiat=
e_seconds =3D options-&gt;renegotiate_seconds - auto_jitter;</span><br><spa=
n>     }</span><br><span>     else</span><br><span>     {</span><br><span> =
        /* Add user-specified jitter to reneg-sec */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        to=2Erenegotiate_seconds =3D</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;rene=
gotiate_seconds</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      - (get_random()</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
               % max_int(options-&gt;renegotiate_seconds - options-&gt;rene=
gotiate_seconds_min, 1));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        int jitter_max =3D max_int(options-&gt;renegotiate_seconds - =
options-&gt;renegotiate_seconds_min, 1);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        to=2Erenegotiate_seconds =3D options-&gt;reneg=
otiate_seconds - (int)(get_random() % jitter_max);</span><br><span>     }</=
span><br><span>     to=2Esingle_session =3D options-&gt;single_session;</sp=
an><br><span>     to=2Emode =3D options-&gt;mode;</span><br><span>@@ -3482,=
10 +3478,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> /*</span><br><span>  * No encryption or authentication=2E</span><br>=
<span>  */</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail">change 1259</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I41b9f7686=
180f2549bd4984cbbf66059f0ba2b15 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1259 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: c=
ron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &=
lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--ehWaieWjGRk=--


--===============8804582045581569222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8804582045581569222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8804582045581569222==--

