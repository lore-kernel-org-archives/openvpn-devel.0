Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B871C44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S74jOKJ+VJrgf1dmxKnYhjeq2PJBKOVlFp9fGgddBmM=; b=OALTFfgHCfwnpZXdr2p2CDvZd+
	v0WAHP50dsT3ex5FonOkkxzfJcOTqCKPHg7HaxiH+Iy8OUJ55cFZEbiB8vJzSWuKILX2X0XbCIgrt
	/G91Lr0KnBepx0FOEZcm6bUgd0V/hS5mr0R3e6wqejLQKd55pY8ny7+ir3r2UcGdLGCI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmWaJ-0007hS-KV;
	Wed, 22 Jul 2026 13:02:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmWaI-0007hL-TM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:02:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZO7CrVi9omM/AWMr8D/DWX91TeGHhytMKa7Ql7K1JMw=; b=d6yTWTDuyekAmfzAwiSyCfZtQz
 Jyh3fVYjk1HukvLJeFPQWnaoCTYO9a8lHF+Pd+dVBP360pGP9+S1S5usWwQmti7l1c4Wvda6yFAiU
 KHPdW3f9JF15UvL7rXKYjWX1N+MKFkvV6hhwdHmkTEia+hmAroqNwNcmlZ5HRiAbWiBc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZO7CrVi9omM/AWMr8D/DWX91TeGHhytMKa7Ql7K1JMw=; b=l
 0FzwvkTx/hVliC4TOdxXHAQV6kMe+4AtsedDHpTrgVjfgH/2nqPy2dNn6vBx+NubIwPDptDlhbEWH
 UtvqlMwTa6k0JzQTDHcZT6WRHXTDTht756N3JltKrOHfPo4nHY60bh+n9dXC5EH+l9ZTTfkGPjMdc
 Gybj32Ct3XWpw4rA=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmWaG-0006DO-JM for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:02:02 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so91520585e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784725309; x=1785330109; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZO7CrVi9omM/AWMr8D/DWX91TeGHhytMKa7Ql7K1JMw=;
 b=epUyf+37CtJKcXC7CJt7zweC2KOtRNB7vYicB6UzhOWkosiFC+8ob1mLdQQ7wrRXvy
 U8PEed4fzj0v2HG40CvKPUhTbLLQkePEEp1Ocr0Y6wXbyEUDFFw5ygPRsoTGRTAIoV2/
 asNrB5Hnyb3ekf1ivllK67K2+4Jc8V+SmLqg0luWuCv6boZpG07O8oIbCKhyvMzLfC+k
 C8NrUQ/QRXSdNHw5o35pvkORXdu6ZE5wf4DJ4FQqijPKsrSKAILnR1Laqa///irRUCZf
 I708FmDIueZfun2jUz7LguAQ9FL4Ucch5vtA0SO/8b70uk7sjh6lVu+wiI0IOI0wuksk
 cUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784725309; x=1785330109;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZO7CrVi9omM/AWMr8D/DWX91TeGHhytMKa7Ql7K1JMw=;
 b=NoPXf0HC1d7wzl9kSLe0A9JE0YB+xVXZeQYQJi1TSnk5dy5RKMLx9u4rRKNUwuTIxd
 NeL7xLC5idlGScuK/bHu3vT6ZrLDlA0kw/tzNQiCItJjr6CKb32fsIh2H0QurOD2mFD2
 TcGBsfIXsEMX0HNbJeI+O0dd07DeTQ7wMtq4rmbg/mNk3a45OFxA7QKoxNIfUWisI531
 qAd5P14wJR4KwQ1uUbeyajvEBY0twkudbjVX0YBxay4ty/53WhXFtnX/+Uteb1eG9N8H
 lpQn8t/XnrO5bycfgfE2VWVHVZWyGWBI7t8rAezqOcwEHYjh6bFpwA8wISjpcllOYlmj
 0hCg==
X-Gm-Message-State: AOJu0YyGOfoi06TZ8f5h3DyS11d1lPhkZ9j3iF3h3ceN40KV0qFX5kY4
 iNU4+uQjg94xiaoAqVlHpeYdRr+Qyn1qSG7mFssHYlGltHA65R7hM6DXXWh3Zy4/MWZ82rSBro7
 KaaQjfJqEgIjmkEQEw7g6a+pyVsRs1MIRbCgJejsR3pb+9s5Vj/k5lUbrTR1SXoGjEMmENxv5LN
 JLxc57uQ==
X-Gm-Gg: AR+sD11zCzVVwPipp5jxNWwFzbqu5C7HY+7ywXB4G/tz58YRe+WSqXm3yNsARXVED7+
 umtgWIvbkbQMnogdJuPDHhAtHuyDHUanr2WUhv/ZRZbFsm78rORO/46JUM/yl6wgMok9lkqO6P3
 W3KQ7Cu/FVd56131/imOCwhuJkl0WXHyZGGcWs19ZhQxn5WF7C2qlA7uTTcxgqXjVuT8pE+7beN
 tzfpPdg4cj5i+UKMYO40SSDDtL3Rc7Z7xPutEy6pJGDSIxGaFANyWiYPLQA9AWx3axKAe57d3h4
 EvsbHkINJW5HtUUFyYgDxq+RQJF5YFCwgefxRc0MP1ynm+A3TMuFIOo/DlfNeyGSNafmJquXJxw
 4cg2+0XYzf0dxojoedMY6fdBjPm1Kdbm/FWm751hJbk06DVRtx3QK3Hn77bxtsARHWHmgh7eWz1
 j5lrybDq2jkLgGTmG6d7ay+eBUhDVP2Qp4PsxH+m9zIV+Pg6EkWKhsrD0s8S9O/WfixY91+cQRs
 qxOJJ9uJL+8I+pQIy4S8qGxk7RYF+JWE6EZgSr53aP1GssY7Mx1OooMr/NSfhIl3VBBCdk47d/j
 6ag=
X-Received: by 2002:a05:600c:1f82:b0:495:607e:5ee7 with SMTP id
 5b1f17b1804b1-495607e635amr126188625e9.17.1784725308590; 
 Wed, 22 Jul 2026 06:01:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c98ebsm134563035e9.13.2026.07.22.06.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:01:48 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 13:01:46 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
X-Gerrit-Change-Number: 1800
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1800?usp=email>
X-Gerrit-Commit: e21e74e8ed27c6187d4e72b83c1be1ca1a08deca
In-Reply-To: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
References: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzIyNzQ0MDAwLklhZDk0ZTdhOWQwYjNiZThhOGRiMDllOWEyMGVhYWM2MDQxNDcwYWI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a6524d3cfec8fcb1bd7d476865044eb052015dc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmWaG-0006DO-JM
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow extracing
 other integers from peer info and add a unit test for it
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
Content-Type: multipart/mixed; boundary="===============4685736142122552153=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4685736142122552153==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="StxcUFGPkB4="; charset=UTF-8

--StxcUFGPkB4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#3)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1800?usp=3Demail )


Change subject: Allow extracing other =
integers from peer info and add a unit test for it
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Allow extracing other integers from p=
eer info and add a unit test for it

This also ensure that we only really e=
xtract the variable we are looking
for=2E The old code would also consider =
UV_IV_NCP to be IV_NCP=2E

Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac604147=
0ab6
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etx=
t
M src/openvpn/push=2Ec
M src/openvpn/ssl_ncp=2Ec
M src/openvpn/ssl_util=
=2Ec
M src/openvpn/ssl_util=2Eh
M src/openvpn/ssl_verify=2Ec
M tests/unit_t=
ests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_push_update_msg=
=2Ec
M tests/unit_tests/openvpn/test_ssl=2Ec
9 files changed, 129 insertion=
s(+), 43 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/00/1800/3

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt=

index 7473f15=2E=2Ef419eee 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=
=2Etxt
@@ -906,9 +906,11 @@
         tests/unit_tests/openvpn/mock_msg=2Ec
=
         tests/unit_tests/openvpn/mock_get_random=2Ec
         src/openvpn/=
options_util=2Ec
+        src/openvpn/ssl_util=2Ec
         src/openvpn/oti=
me=2Ec
         src/openvpn/list=2Ec
-        )
+        src/openvpn/ssl_ut=
il=2Ec
+    )
 
     target_sources(test_argv PRIVATE
         tests/unit_t=
ests/openvpn/mock_get_random=2Ec
diff --git a/src/openvpn/push=2Ec b/src/op=
envpn/push=2Ec
index 633c007d=2E=2E88b499f 100644
--- a/src/openvpn/push=2E=
c
+++ b/src/openvpn/push=2Ec
@@ -718,7 +718,7 @@
 
     /* Push our mtu to =
the peer if it supports pushable MTUs */
     int client_max_mtu =3D 0;
-  =
  const char *iv_mtu =3D extract_var_peer_info(tls_multi->peer_info, "IV_MT=
U=3D", gc);
+    const char *iv_mtu =3D extract_var_peer_info(tls_multi->pe=
er_info, "IV_MTU", gc);
 
     if (iv_mtu && sscanf(iv_mtu, "%d", &client_m=
ax_mtu) =3D=3D 1)
     {
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn=
/ssl_ncp=2Ec
index b450de8=2E=2E8148396 100644
--- a/src/openvpn/ssl_ncp=2E=
c
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -55,20 +55,10 @@
  * Return the Negotiab=
le Crypto Parameters version advertised in the peer info
  * string, or 0 i=
f none specified=2E
  */
-static int
+static unsigned int
 tls_peer_info_nc=
p_ver(const char *peer_info)
 {
-    const char *ncpstr =3D peer_info ? str=
str(peer_info, "IV_NCP=3D") : NULL;
-    if (ncpstr)
-    {
-        int nc=
p =3D 0;
-        int r =3D sscanf(ncpstr, "IV_NCP=3D%d", &ncp);
-        i=
f (r =3D=3D 1)
-        {
-            return ncp;
-        }
-    }
-    r=
eturn 0;
+    return peer_info_extract_uint(peer_info, "IV_NCP", 0);
 }
 
 =
/**
@@ -227,7 +217,7 @@
 tls_peer_ncp_list(const char *peer_info, struct gc=
_arena *gc)
 {
     /* Check if the peer sends the IV_CIPHERS list */
-    =
const char *iv_ciphers =3D extract_var_peer_info(peer_info, "IV_CIPHERS=3D"=
, gc);
+    const char *iv_ciphers =3D extract_var_peer_info(peer_info, "IV=
_CIPHERS", gc);
     if (iv_ciphers)
     {
         return iv_ciphers;
@@ =
-358,7 +348,7 @@
 {
     /* we use a local gc arena to keep the temporary s=
trings needed by strsep */
     struct gc_arena gc_local =3D gc_new();
-   =
 const char *peer_ciphers =3D extract_var_peer_info(peer_info, "IV_CIPHERS=
=3D", &gc_local);
+    const char *peer_ciphers =3D extract_var_peer_info(p=
eer_info, "IV_CIPHERS", &gc_local);
 
     if (!peer_ciphers)
     {
diff -=
-git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
index 2f01f8a=2E=
=2Ea4c2910 100644
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/openvpn/ssl_util=
=2Ec
@@ -27,6 +27,32 @@
 #include "openvpn=2Eh"
 #include "ssl_util=2Eh"
 
=
+static const char *
+peer_info_extract_varstr(const char *peer_info, const=
 char *field)
+{
+    char buf[32];
+    snprintf(buf, sizeof(buf), "%s=3D"=
, field);
+
+    const char *optstr =3D NULL;
+
+    /* peer info starts wi=
th this field */
+    if (peer_info && strncmp(peer_info, buf, strlen(buf))=
 =3D=3D 0)
+    {
+        optstr =3D peer_info;
+    }
+    else
+    {
+ =
       snprintf(buf, sizeof(buf), "\n%s=3D", field);
+        optstr =3D pe=
er_info ? strstr(peer_info, buf) : NULL;
+        if (optstr)
+        {
+ =
           /* skip the \n */
+            optstr++;
+        }
+    }
+    =
return optstr;
+}
+
 char *
 extract_var_peer_info(const char *peer_info, c=
onst char *var, struct gc_arena *gc)
 {
@@ -35,14 +61,15 @@
         return=
 NULL;
     }
 
-    const char *var_start =3D strstr(peer_info, var);
+   =
 const char *var_start =3D peer_info_extract_varstr(peer_info, var);
     i=
f (!var_start)
     {
         /* variable not found in peer info */
      =
   return NULL;
     }
 
-    var_start +=3D strlen(var);
+    /* one extra=
 byte forward for the =3D */
+    var_start +=3D strlen(var) + 1;
     cons=
t char *var_end =3D strstr(var_start, "\n");
     if (!var_end)
     {
@@ -=
56,36 +83,35 @@
     return var_value;
 }
 
+
 unsigned int
-extract_iv_pro=
to(const char *peer_info)
+peer_info_extract_uint(const char *peer_info, co=
nst char *field, unsigned int default_value)
 {
-    const char *optstr =3D=
 peer_info ? strstr(peer_info, "IV_PROTO=3D") : NULL;
+    const char *opts=
tr =3D peer_info_extract_varstr(peer_info, field);
     if (optstr)
     {
=
+        char buf[32];
+        snprintf(buf, sizeof(buf), "%s=3D%%d", fiel=
d);
         int proto =3D 0;
-        int r =3D sscanf(optstr, "IV_PROTO=
=3D%d", &proto);
+        int r =3D sscanf(optstr, buf, &proto);
         i=
f (r =3D=3D 1 && proto > 0)
         {
             return proto;
         =
}
     }
-    return 0;
+    return default_value;
 }
 
 uint32_t
 extract_=
asymmetric_peer_id(const char *peer_info)
 {
-    for (const char *p =3D pe=
er_info; p && (p =3D strstr(p, "ID=3D")); p +=3D 3)
+    const char *optstr=
 =3D peer_info_extract_varstr(peer_info, "ID");
+    if (optstr)
     {
-  =
      /* only accept "ID=3D" at the start of a line, so it does not match
-=
         * substrings like "UV_ID=3D" or "GUID=3D" */
-        if (p =3D=3D=
 peer_info || p[-1] =3D=3D '\n')
+        uint32_t peer_id =3D 0;
+        =
if (sscanf(optstr, "ID=3D%x", &peer_id) =3D=3D 1 && peer_id < MAX_PEER_ID)
=
         {
-            uint32_t peer_id =3D 0;
-            if (sscanf(p, =
"ID=3D%x", &peer_id) =3D=3D 1 && peer_id < MAX_PEER_ID)
-            {
-   =
             return peer_id;
-            }
+            return peer_id;
  =
       }
     }
     return MAX_PEER_ID;
diff --git a/src/openvpn/ssl_util=
=2Eh b/src/openvpn/ssl_util=2Eh
index 1a69e6f=2E=2E05d8adc 100644
--- a/src=
/openvpn/ssl_util=2Eh
+++ b/src/openvpn/ssl_util=2Eh
@@ -33,11 +33,22 @@
 #=
include "buffer=2Eh"
 
 /**
+ * Extracts the named variable and returns its=
 value or default_value
+ * if it cannot be extracted=2E
+ *
+ * @param pee=
r_info     peer info string to search in
+ * @param field          name of =
the field to be extracted
+ * @param default_value  value to return if not =
found or cannot be extracted
+ */
+unsigned int
+peer_info_extract_uint(con=
st char *peer_info, const char *field, unsigned int default_value);
+
+/**
=
  * Extracts a variable from peer info, the returned string will be allocat=
ed
  * using the supplied gc_arena
  *
  * @param peer_info     The peer's =
peer_info
- * @param var           The variable *including* =3D, e=2Eg=2E I=
V_CIPHERS=3D
+ * @param var           The variable *excluding* =3D, e=2Eg=
=2E IV_CIPHERS
  * @param gc            GC arena to allocate return value i=
n
  *
  * @return  The content of the variable as NULL terminated string or=
 NULL if the
@@ -51,8 +62,11 @@
  *
  * @param peer_info     peer info stri=
ng to search for IV_PROTO
  */
-unsigned int extract_iv_proto(const char *p=
eer_info);
-
+static inline unsigned int
+extract_iv_proto(const char *peer=
_info)
+{
+    return peer_info_extract_uint(peer_info, "IV_PROTO", 0);
+}
=
 
 /**
  * Extracts the ID variable and returns its value or
diff --git a/s=
rc/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 162f68f=2E=2E3=
317380 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=
=2Ec
@@ -861,7 +861,7 @@
 {
     struct gc_arena gc =3D gc_new();
 
-    ch=
ar *iv_sso =3D extract_var_peer_info(peer_info, "IV_SSO=3D", &gc);
+    cha=
r *iv_sso =3D extract_var_peer_info(peer_info, "IV_SSO", &gc);
     if (!iv=
_sso)
     {
         gc_free(&gc);
diff --git a/tests/unit_tests/openvpn/M=
akefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index d861ef9=2E=2E5c=
cf3ce 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_=
tests/openvpn/Makefile=2Eam
@@ -395,7 +395,8 @@
 	$(top_srcdir)/src/openvpn=
/platform=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \
 	$(top_srcd=
ir)/src/openvpn/otime=2Ec \
-	$(top_srcdir)/src/openvpn/list=2Ec
+	$(top_sr=
cdir)/src/openvpn/list=2Ec \
+	$(top_srcdir)/src/openvpn/ssl_util=2Ec
 
 so=
cket_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src=
/compat -I$(top_srcdir)/src/openvpn \
diff --git a/tests/unit_tests/openvpn=
/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=
=2Ec
index 219b476=2E=2E389fa09 100644
--- a/tests/unit_tests/openvpn/test_=
push_update_msg=2Ec
+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec=

@@ -188,12 +188,6 @@
 {
     return true;
 }
-
-unsigned int
-extract_iv_p=
roto(const char *peer_info)
-{
-    return IV_PROTO_PUSH_UPDATE;
-}
 #endif=
 /* ifdef ENABLE_MANAGEMENT */
 
 /* tests */
@@ -650,6 +644,7 @@
     m->i=
nstances =3D calloc(1, sizeof(struct multi_instance *));
     struct multi_=
instance *mi =3D calloc(1, sizeof(struct multi_instance));
     mi->context=
=2Ec2=2Etls_multi =3D calloc(1, sizeof(struct tls_multi));
+    mi->context=
=2Ec2=2Etls_multi->peer_info =3D "IV_PROTO=3D4096";  // IV_PROTO_PUSH_UPDAT=
E
     *(m->instances) =3D mi;
     m->top=2Eoptions=2Edisable_dco =3D true=
;
     *state =3D m;
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/t=
ests/unit_tests/openvpn/test_ssl=2Ec
index 0e9cecf=2E=2E9c2a99d 100644
--- =
a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test=
_ssl=2Ec
@@ -48,7 +48,9 @@
 #include "buffer=2Eh"
 #include "cert_data=2Eh"=

 #include "packet_id=2Eh"
+#include "ssl_util=2Eh"
 #include "ssl_verify=
=2Eh"
+#include "openvpn=2Eh"
 
 /* Mock function to be allowed to include =
win32=2Ec which is required for
  * getting the temp directory */
@@ -829,6=
 +831,61 @@
     free_certificate(cert);
 }
 
+void
+ssl_test_extract_peer_=
info(void **state)
+{
+    const char *peer_info_normal =3D
+        "IV_VE=
R=3D2=2E6_git\nIV_PLAT=3Dmac\nIV_TCPNL=3D1\nIV_NCP=3D2\n"
+        "IV_CIPH=
ERS=3DAES-256-GCM:AES-128-GCM:CHACHA20-POLY1305\n"
+        "IV_PROTO=3D94\=
nIV_LZO_STUB=3D1\nIV_COMP_STUB=3D1\nP=3D78\nIV_COMP_STUBv2=3D1\n"
+        =
"IV_SSL=3DOpenSSL_3=2E0=2E5_5_Jul_2022\nIV_LZ4v2=3D1";
+
+    const char *e=
mpty =3D "";
+    const char *invalid_proto =3D "IV_PROTO=3Dseven\nIV_SSL=
=3D7\nP=3D300\nID=3Dxyz";
+    const char *test_prefix =3D "UV_IV_PROTO=3D7=
73\nNP=3D112\nPD=3D8\n";
+
+
+    assert_int_equal(extract_iv_proto(peer_in=
fo_normal), 94);
+    assert_int_equal(extract_iv_proto(empty), 0);
+    as=
sert_int_equal(extract_iv_proto(invalid_proto), 0);
+    /* This should not=
 pick up the UV_IV_PROTO that has the extra prefix */
+    assert_int_equal=
(extract_iv_proto(test_prefix), 0);
+
+    assert_int_equal(peer_info_extra=
ct_uint(peer_info_normal, "IV_COMP_STUB", 0), 1);
+    assert_int_equal(pee=
r_info_extract_uint(empty, "IV_COMP_STUB", 0xfe0d0d), 0xfe0d0d);
+    asser=
t_int_equal(peer_info_extract_uint(invalid_proto, "IV_COMP_STUB", 5), 5);
+=

+    assert_int_equal(peer_info_extract_uint(test_prefix, "NP", 23), 112);=

+    assert_int_equal(peer_info_extract_uint(test_prefix, "PD", 23), 8);
+=
    assert_int_equal(peer_info_extract_uint(test_prefix, "P", 0xfe0d0d), 0x=
fe0d0d);
+    assert_int_equal(peer_info_extract_uint(peer_info_normal, "P"=
, 23), 78);
+    assert_int_equal(peer_info_extract_uint(test_prefix, "UV_I=
V_PROTO", 23), 773);
+
+    struct gc_arena gc =3D gc_new();
+
+    const c=
har *peer_ciphers =3D extract_var_peer_info(peer_info_normal, "IV_CIPHERS",=
 &gc);
+    assert_string_equal(peer_ciphers, "AES-256-GCM:AES-128-GCM:CHAC=
HA20-POLY1305");
+
+    /* with the extra =3D this should not extract anyth=
ing */
+    const char *proto =3D extract_var_peer_info(peer_info_normal, "=
IV_PROTO=3D", &gc);
+    assert_null(proto);
+
+    const char *double_eq_i=
nfo =3D "FOO=3D7\nFOO=3D=3Dnew";
+    const char *foo_eq =3D extract_var_pe=
er_info(double_eq_info, "FOO=3D", &gc);
+    const char *foo =3D extract_va=
r_peer_info(double_eq_info, "FOO", &gc);
+    assert_string_equal(foo, "7")=
;
+    assert_string_equal(foo_eq, "new");
+
+    assert_int_equal(extract_=
asymmetric_peer_id(double_eq_info), MAX_PEER_ID);
+    assert_int_equal(ext=
ract_asymmetric_peer_id(peer_info_normal), MAX_PEER_ID);
+    assert_int_eq=
ual(extract_asymmetric_peer_id(invalid_proto), MAX_PEER_ID);
+    assert_in=
t_equal(extract_asymmetric_peer_id("ID=3Df7"), 0xf7);
+    assert_int_equal=
(extract_asymmetric_peer_id("X=3Dfoo\nID=3D12ab"), 0x12ab);
+    assert_int=
_equal(extract_asymmetric_peer_id("X=3Dfoo\nID=3D34dd\nY=3Dbar"), 0x34dd);
=
+    assert_int_equal(extract_asymmetric_peer_id("X=3Dfoo\nID=3D12345678"),=
 MAX_PEER_ID);
+
+    gc_free(&gc);
+}
 
 int
 main(void)
@@ -853,7 +910,8 =
@@
         cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),
         =
cmocka_unit_test(test_data_channel_known_vectors_epoch),
         cmocka_un=
it_test(test_data_channel_known_vectors_shortpktid),
-        cmocka_unit_t=
est(crypto_test_print_cert_details)
+        cmocka_unit_test(crypto_test_p=
rint_cert_details),
+        cmocka_unit_test(ssl_test_extract_peer_info)
 =

     };
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
00?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad94e=
7a9d0b3be8a8db09e9a20eaac6041470ab6
Gerrit-Change-Number: 1800
Gerrit-Patch=
Set: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--StxcUFGPkB4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Allow extracing other integers from peer info and add a unit test=
 for it<br><br>This also ensure that we only really extract the variable we=
 are looking<br>for=2E The old code would also consider UV_IV_NCP to be IV_=
NCP=2E<br><br>Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6<br>Signe=
d-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2E=
txt<br>M src/openvpn/push=2Ec<br>M src/openvpn/ssl_ncp=2Ec<br>M src/openvpn=
/ssl_util=2Ec<br>M src/openvpn/ssl_util=2Eh<br>M src/openvpn/ssl_verify=2Ec=
<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/=
test_push_update_msg=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>9 fi=
les changed, 129 insertions(+), 43 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/00/1800/3<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>in=
dex 7473f15=2E=2Ef419eee 100644</span><br><span>--- a/CMakeLists=2Etxt</spa=
n><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -906,9 +906,11 @@</sp=
an><br><span>         tests/unit_tests/openvpn/mock_msg=2Ec</span><br><span=
>         tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span>    =
     src/openvpn/options_util=2Ec</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        src/openvpn/ssl_util=2Ec</span><br><span>         src=
/openvpn/otime=2Ec</span><br><span>         src/openvpn/list=2Ec</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        )</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ssl_util=2Ec</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span> </spa=
n><br><span>     target_sources(test_argv PRIVATE</span><br><span>         =
tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span>diff --git a/s=
rc/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 633c007d=
=2E=2E88b499f 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><=
span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -718,7 +718,7 @@</span><=
br><span> </span><br><span>     /* Push our mtu to the peer if it supports =
pushable MTUs */</span><br><span>     int client_max_mtu =3D 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    const char *iv_mtu =3D extrac=
t_var_peer_info(tls_multi-&gt;peer_info, &quot;IV_MTU=3D&quot;, gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *iv_mtu =3D=
 extract_var_peer_info(tls_multi-&gt;peer_info, &quot;IV_MTU&quot;, gc);</s=
pan><br><span> </span><br><span>     if (iv_mtu &amp;&amp; sscanf(iv_mtu, &=
quot;%d&quot;, &amp;client_max_mtu) =3D=3D 1)</span><br><span>     {</span>=
<br><span>diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</s=
pan><br><span>index b450de8=2E=2E8148396 100644</span><br><span>--- a/src/o=
penvpn/ssl_ncp=2Ec</span><br><span>+++ b/src/openvpn/ssl_ncp=2Ec</span><br>=
<span>@@ -55,20 +55,10 @@</span><br><span>  * Return the Negotiable Crypto =
Parameters version advertised in the peer info</span><br><span>  * string, =
or 0 if none specified=2E</span><br><span>  */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static unsigned int</span><br><span> tls_peer_info_ncp_ver(=
const char *peer_info)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const char *ncpstr =3D peer_info ? strstr(peer_info=
, &quot;IV_NCP=3D&quot;) : NULL;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (ncpstr)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int=
 ncp =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in=
t r =3D sscanf(ncpstr, &quot;IV_NCP=3D%d&quot;, &amp;ncp);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (r =3D=3D 1)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            return ncp;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn peer_info_extract_uint(peer_info, &quot;IV_NCP&quot;, 0);</span><br><=
span> }</span><br><span> </span><br><span> /**</span><br><span>@@ -227,7 +2=
17,7 @@</span><br><span> tls_peer_ncp_list(const char *peer_info, struct gc=
_arena *gc)</span><br><span> {</span><br><span>     /* Check if the peer se=
nds the IV_CIPHERS list */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    const char *iv_ciphers =3D extract_var_peer_info(peer_info, &quot;=
IV_CIPHERS=3D&quot;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *iv_ciphers =3D extract_var_peer_info(peer_info, &quot=
;IV_CIPHERS&quot;, gc);</span><br><span>     if (iv_ciphers)</span><br><spa=
n>     {</span><br><span>         return iv_ciphers;</span><br><span>@@ -35=
8,7 +348,7 @@</span><br><span> {</span><br><span>     /* we use a local gc =
arena to keep the temporary strings needed by strsep */</span><br><span>   =
  struct gc_arena gc_local =3D gc_new();</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const char *peer_ciphers =3D extract_var_peer_info(p=
eer_info, &quot;IV_CIPHERS=3D&quot;, &amp;gc_local);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *peer_ciphers =3D extract_=
var_peer_info(peer_info, &quot;IV_CIPHERS&quot;, &amp;gc_local);</span><br>=
<span> </span><br><span>     if (!peer_ciphers)</span><br><span>     {</spa=
n><br><span>diff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2E=
c</span><br><span>index 2f01f8a=2E=2Ea4c2910 100644</span><br><span>--- a/s=
rc/openvpn/ssl_util=2Ec</span><br><span>+++ b/src/openvpn/ssl_util=2Ec</spa=
n><br><span>@@ -27,6 +27,32 @@</span><br><span> #include &quot;openvpn=2Eh&=
quot;</span><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+peer_info_extract_va=
rstr(const char *peer_info, const char *field)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    char buf[32];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    snprintf(buf, sizeof(buf), &quot;%s=3D&quot;, field);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *optstr =3D NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* peer info starts with this field */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (peer_info &amp;&amp; str=
ncmp(peer_info, buf, strlen(buf)) =3D=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        optstr =3D peer_info;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(bu=
f, sizeof(buf), &quot;\n%s=3D&quot;, field);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        optstr =3D peer_info ? strstr(peer_info, b=
uf) : NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (optstr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* ski=
p the \n */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    optstr++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return optstr;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> char *</span><br><span> extract=
_var_peer_info(const char *peer_info, const char *var, struct gc_arena *gc)=
</span><br><span> {</span><br><span>@@ -35,14 +61,15 @@</span><br><span>   =
      return NULL;</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    const char *var_start =3D strstr(=
peer_info, var);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *var_start =3D peer_info_extract_varstr(peer_info, var);</span>=
<br><span>     if (!var_start)</span><br><span>     {</span><br><span>     =
    /* variable not found in peer info */</span><br><span>         return N=
ULL;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    var_start +=3D strlen(var);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* one extra byte forward for the =
=3D */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    var_start=
 +=3D strlen(var) + 1;</span><br><span>     const char *var_end =3D strstr(=
var_start, &quot;\n&quot;);</span><br><span>     if (!var_end)</span><br><s=
pan>     {</span><br><span>@@ -56,36 +83,35 @@</span><br><span>     return =
var_value;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> unsigned int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-extract_iv_proto(const char *peer_info=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+peer_info_extract_=
uint(const char *peer_info, const char *field, unsigned int default_value)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 const char *optstr =3D peer_info ? strstr(peer_info, &quot;IV_PROTO=3D&quo=
t;) : NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *optstr =3D peer_info_extract_varstr(peer_info, field);</span><br><s=
pan>     if (optstr)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        char buf[32];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        snprintf(buf, sizeof(buf), &quot;%s=3D%%d=
&quot;, field);</span><br><span>         int proto =3D 0;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        int r =3D sscanf(optstr, &quot;=
IV_PROTO=3D%d&quot;, &amp;proto);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        int r =3D sscanf(optstr, buf, &amp;proto);</span><br>=
<span>         if (r =3D=3D 1 &amp;&amp; proto &gt; 0)</span><br><span>    =
     {</span><br><span>             return proto;</span><br><span>         =
}</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return default_value;</span><br><span> }</span><br><span> </span><br><span=
> uint32_t</span><br><span> extract_asymmetric_peer_id(const char *peer_inf=
o)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    for (const char *p =3D peer_info; p &amp;&amp; (p =3D strstr(p, &quot;I=
D=3D&quot;)); p +=3D 3)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *optstr =3D peer_info_extract_varstr(peer_info, &quot;ID=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt=
str)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        /* only accept &quot;ID=3D&quot; at the start of a line, so i=
t does not match</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
    * substrings like &quot;UV_ID=3D&quot; or &quot;GUID=3D&quot; */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p =3D=3D peer_in=
fo || p[-1] =3D=3D &#39;\n&#39;)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        uint32_t peer_id =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (sscanf(optstr, &quot;ID=3D%x&quot;, &a=
mp;peer_id) =3D=3D 1 &amp;&amp; peer_id &lt; MAX_PEER_ID)</span><br><span> =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
uint32_t peer_id =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            if (sscanf(p, &quot;ID=3D%x&quot;, &amp;peer_id) =3D=3D 1 &am=
p;&amp; peer_id &lt; MAX_PEER_ID)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                return peer_id;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            return peer_id;</span><br><span>         }</span><br><s=
pan>     }</span><br><span>     return MAX_PEER_ID;</span><br><span>diff --=
git a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh</span><br><span>i=
ndex 1a69e6f=2E=2E05d8adc 100644</span><br><span>--- a/src/openvpn/ssl_util=
=2Eh</span><br><span>+++ b/src/openvpn/ssl_util=2Eh</span><br><span>@@ -33,=
11 +33,22 @@</span><br><span> #include &quot;buffer=2Eh&quot;</span><br><sp=
an> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Extracts the named variable and returns its value or default_value=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * if it cannot be =
extracted=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param peer_info     =
peer info string to search in</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param field          name of the field to be extracted</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param default_value  v=
alue to return if not found or cannot be extracted</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+peer_info_extract_uint(const char *peer_info, const char *field, un=
signed int default_value);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><b=
r><span>  * Extracts a variable from peer info, the returned string will be=
 allocated</span><br><span>  * using the supplied gc_arena</span><br><span>=
  *</span><br><span>  * @param peer_info     The peer&#39;s peer_info</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param var           The=
 variable *including* =3D, e=2Eg=2E IV_CIPHERS=3D</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param var           The variable *excludi=
ng* =3D, e=2Eg=2E IV_CIPHERS</span><br><span>  * @param gc            GC ar=
ena to allocate return value in</span><br><span>  *</span><br><span>  * @re=
turn  The content of the variable as NULL terminated string or NULL if the<=
/span><br><span>@@ -51,8 +62,11 @@</span><br><span>  *</span><br><span>  * =
@param peer_info     peer info string to search for IV_PROTO</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int ex=
tract_iv_proto(const char *peer_info);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic inline unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+extract_iv_proto(const char *peer_info)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return peer_info_extract_uint(peer_info, &quot;IV_PROTO&quot;, 0=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
> </span><br><span> /**</span><br><span>  * Extracts the ID variable and re=
turns its value or</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec =
b/src/openvpn/ssl_verify=2Ec</span><br><span>index 162f68f=2E=2E3317380 100=
644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/=
src/openvpn/ssl_verify=2Ec</span><br><span>@@ -861,7 +861,7 @@</span><br><s=
pan> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *iv_sso =
=3D extract_var_peer_info(peer_info, &quot;IV_SSO=3D&quot;, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *iv_sso =3D extr=
act_var_peer_info(peer_info, &quot;IV_SSO&quot;, &amp;gc);</span><br><span>=
     if (!iv_sso)</span><br><span>     {</span><br><span>         gc_free(&=
amp;gc);</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Ea=
m b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index d861ef9=2E=
=2E5ccf3ce 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><b=
r><span>@@ -395,7 +395,8 @@</span><br><span> 	$(top_srcdir)/src/openvpn/pla=
tform=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/options_util=2Ec \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/list=2Ec</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvp=
n/list=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_=
srcdir)/src/openvpn/ssl_util=2Ec</span><br><span> </span><br><span> socket_=
testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/include -I$(top_=
srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/ope=
nvpn/test_push_update_msg=2Ec</span><br><span>index 219b476=2E=2E389fa09 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/test_push_update_msg=2E=
c</span><br><span>+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec</=
span><br><span>@@ -188,12 +188,6 @@</span><br><span> {</span><br><span>    =
 return true;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-extract_iv_proto(co=
nst char *peer_info)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return IV_PROTO_P=
USH_UPDATE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><=
span> /* tests */</span><br><span>@@ -650,6 +644,7 @@</span><br><span>     =
m-&gt;instances =3D calloc(1, sizeof(struct multi_instance *));</span><br><=
span>     struct multi_instance *mi =3D calloc(1, sizeof(struct multi_insta=
nce));</span><br><span>     mi-&gt;context=2Ec2=2Etls_multi =3D calloc(1, s=
izeof(struct tls_multi));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=
=3D4096&quot;;  // IV_PROTO_PUSH_UPDATE</span><br><span>     *(m-&gt;instan=
ces) =3D mi;</span><br><span>     m-&gt;top=2Eoptions=2Edisable_dco =3D tru=
e;</span><br><span>     *state =3D m;</span><br><span>diff --git a/tests/un=
it_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span=
><br><span>index 0e9cecf=2E=2E9c2a99d 100644</span><br><span>--- a/tests/un=
it_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_ssl=2Ec</span><br><span>@@ -48,7 +48,9 @@</span><br><span> #include =
&quot;buffer=2Eh&quot;</span><br><span> #include &quot;cert_data=2Eh&quot;<=
/span><br><span> #include &quot;packet_id=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util=2Eh&quot;</span><=
br><span> #include &quot;ssl_verify=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</span><br><span>=
 </span><br><span> /* Mock function to be allowed to include win32=2Ec whic=
h is required for</span><br><span>  * getting the temp directory */</span><=
br><span>@@ -829,6 +831,61 @@</span><br><span>     free_certificate(cert);<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ssl_test_extract_peer_info(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const char *peer_info_normal =3D</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        &quot;IV_VER=3D2=2E6_git\nIV_PLAT=3Dmac\nIV_T=
CPNL=3D1\nIV_NCP=3D2\n&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        &quot;IV_CIPHERS=3DAES-256-GCM:AES-128-GCM:CHACHA20-POLY13=
05\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &=
quot;IV_PROTO=3D94\nIV_LZO_STUB=3D1\nIV_COMP_STUB=3D1\nP=3D78\nIV_COMP_STUB=
v2=3D1\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   &quot;IV_SSL=3DOpenSSL_3=2E0=2E5_5_Jul_2022\nIV_LZ4v2=3D1&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *empty =3D &quot;&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *invalid_pr=
oto =3D &quot;IV_PROTO=3Dseven\nIV_SSL=3D7\nP=3D300\nID=3Dxyz&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *test_prefi=
x =3D &quot;UV_IV_PROTO=3D773\nNP=3D112\nPD=3D8\n&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(extract_iv_proto(peer_info_normal), 94);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(extract_iv_pr=
oto(empty), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(extract_iv_proto(invalid_proto), 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* This should not pick up the UV_IV_=
PROTO that has the extra prefix */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(extract_iv_proto(test_prefix), 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(peer_info_extract_ui=
nt(peer_info_normal, &quot;IV_COMP_STUB&quot;, 0), 1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(peer_info_extract_u=
int(empty, &quot;IV_COMP_STUB&quot;, 0xfe0d0d), 0xfe0d0d);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(peer_info_extra=
ct_uint(invalid_proto, &quot;IV_COMP_STUB&quot;, 5), 5);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(peer_info_extract_uint(test_prefix, =
&quot;NP&quot;, 23), 112);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(peer_info_extract_uint(test_prefix, &quot;PD&qu=
ot;, 23), 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(peer_info_extract_uint(test_prefix, &quot;P&quot;, 0xfe0d0d)=
, 0xfe0d0d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(peer_info_extract_uint(peer_info_normal, &quot;P&quot;, 23), =
78);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(peer_info_extract_uint(test_prefix, &quot;UV_IV_PROTO&quot;, 23), 773=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *peer_ciphers =3D extra=
ct_var_peer_info(peer_info_normal, &quot;IV_CIPHERS&quot;, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(pe=
er_ciphers, &quot;AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* with the extra =3D this should not extr=
act anything */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char *proto =3D extract_var_peer_info(peer_info_normal, &quot;IV_PROT=
O=3D&quot;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_null(proto);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *double_eq_info =3D &quot;FOO=3D7\nFOO=3D=3Dnew&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *foo_eq =3D extract_var=
_peer_info(double_eq_info, &quot;FOO=3D&quot;, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *foo =3D extract_var_pe=
er_info(double_eq_info, &quot;FOO&quot;, &amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_string_equal(foo, &quot;7&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(foo_eq, &quot;new&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(extract_asymmetric_peer_id(double_eq_info), MAX_PEER_ID);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ext=
ract_asymmetric_peer_id(peer_info_normal), MAX_PEER_ID);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(extract_asymmetri=
c_peer_id(invalid_proto), MAX_PEER_ID);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(extract_asymmetric_peer_id(&quot;I=
D=3Df7&quot;), 0xf7);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(extract_asymmetric_peer_id(&quot;X=3Dfoo\nID=3D12ab&=
quot;), 0x12ab);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(extract_asymmetric_peer_id(&quot;X=3Dfoo\nID=3D34dd\nY=3D=
bar&quot;), 0x34dd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(extract_asymmetric_peer_id(&quot;X=3Dfoo\nID=3D123456=
78&quot;), MAX_PEER_ID);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span> </span><br><span> int</span><br><span> main(void)</span><br><span>@@=
 -853,7 +910,8 @@</span><br><span>         cmocka_unit_test(test_data_chann=
el_roundtrip_bf_cbc),</span><br><span>         cmocka_unit_test(test_data_c=
hannel_known_vectors_epoch),</span><br><span>         cmocka_unit_test(test=
_data_channel_known_vectors_shortpktid),</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        cmocka_unit_test(crypto_test_print_cert_details)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit=
_test(crypto_test_print_cert_details),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(ssl_test_extract_peer_info)</sp=
an><br><span> </span><br><span>     };</span><br><span> </span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1800?usp=3Demail">change 1800</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1800?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041=
470ab6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1800 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>

</body></html>
--StxcUFGPkB4=--


--===============4685736142122552153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4685736142122552153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4685736142122552153==--

