Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073FBC44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ie2mQKGAhYZHz5b+sbh+JmA8mt7IPcF29AbUejiR8Jc=; b=ZGRuP5s5mxcumktpQRJJ3cw4so
	t9xnlRsMDzKcqA4nZPtINl49/ugJPogEPgEZnRybyGb1IjIgQobxSErKiQTBvZ/1lGlqCEiFCl3oL
	XwYidTyZ6ZJ/Oda92xc2mNiRnP/HUmAzkQLLLZemTYyqlIGKtzZUrSU2Ix+B5zt19j5U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmWEM-0002JQ-6Z;
	Wed, 22 Jul 2026 12:39:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmWEK-0002JI-78
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 12:39:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3GW3GO+Mt1XO6tecie1fAyMreXcpsv4PWfTivGes5GM=; b=PvvDY5VD6cf5V4RWWSYMlqAuXy
 zVDLgHfPTNjcPdMebj640GSbNS4drZ6m4BQxq1Js/gS4hbLCUv7uRCAudNp4j9GDONNORDZzkYZqB
 +7L6gEPdkkUG/8Tx9W7HzfPAKoSTsCmr5HJj82s5wMGw2EfktF4qamPqVQY8mQNMvRFw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3GW3GO+Mt1XO6tecie1fAyMreXcpsv4PWfTivGes5GM=; b=i
 lLpJ5l/0ebysyLpaIjp0f893vv5cNfSm0tOz0tbvt0BPPmsFaCBguxe7DRsf9TPS5mqTGN4pMjP06
 Jt/w1xV1PPI62iFK9f/QszxQWWn83QKNdvWK/RFi899ZZZPTtV+fmRNjobIwFvaWQ2MqINZbuAmQn
 hhLil/qfDraanUZA=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmWEI-0005Bf-UW for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 12:39:20 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso46604985e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784723947; x=1785328747; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3GW3GO+Mt1XO6tecie1fAyMreXcpsv4PWfTivGes5GM=;
 b=SRAPSrN9acwevEHOUSg9rkQW91IM3Fsho7YOVi/vhs3B8uWCDDtObxe2EMdQQo6/pL
 VKDX2tmEny9prcNGgIzarPV3xVQvhhQ7/0ERS8ftzo1jUDP5pk4G4kgFLZSEzoVewkD9
 nFFG+wUPF0KbLWFhFWRqFkhWcffqxuZW0kLemQKv3WkaRDR4YuIEnSk+KQFQ/jwiGC8f
 SWm1UeeharPBa1qjSNDpjgSX7qRYwJzGYqa9uzqh9JSf+t9nbyn40xW/fKFTxjjiFBB4
 QYbPGbE0k/i9wk+Uzd4CXHy/FQZyuwjozS+gQ4Q1ePvtbDRdiOYiveD4MQ/VBttS+bV0
 4nNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784723947; x=1785328747;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3GW3GO+Mt1XO6tecie1fAyMreXcpsv4PWfTivGes5GM=;
 b=Dk+/InA51VE2ncDjqoff4tpAUVneqsJpxFRjliECOdF6ctKrZuHsRdAHfTwwuyi5H9
 UT2yxg7IVmSuEfxDzaEjVjRvvlqWrkSD4y1VdVvM058mTzn6IJkBNY/m4cOp4jz8k1so
 1j9zbOEnrD/0Kpi5emcM/mI5w4feoVWI4PKUfqvKBN2ZjJXJqAAR1OXFo5WAJduaxWke
 0WNtnEwI7MSiEBGcsZDPknA+xn1jighPVXnHy6NKIM6hyyrN42yfLaJircuFNlxjxDpz
 RKyDwMolOt3VhErWkjG/z8gVkCJfLLp+owDONw3DQrEmeO9jlexTBAdx17pLJ7ZaD8GU
 Ypbw==
X-Gm-Message-State: AOJu0YxY2Fklxw0QS0Uetbqnen9lomXaq+cc0jCljkuQ6L78/r4e3AzN
 oInERRRt7jw99EQekWD/odKOx+l9z32sAwMjg+0ZMbqltFPTx6ruBwQMOa5UbWsxRf8c4DjgN4j
 JCMn78ovi0ftTVNVe5OAORv45BL/KF5muidt6FqIABzuNh6uW5LRiLUvpn6WWdnXz9nXpsrd6hc
 2RfTQdZw==
X-Gm-Gg: AR+sD13F5gA4nLt18ofzI95syWPB5mwLl3fuBokjkRA4vFAKemQVq9OrQ+TK9WLT6fx
 yJUNxRxYWuyPb/LisOQKl8lFUKacAa7hzFe33VPvdvSZYoveQ15yyTYqPSw/Q9iVrCYH9SraBpa
 OXU8zWiK8bc3NDZmccmigPFTslNVHTQIUjHVhaxpWv/ZETB0E25xGik8l7UOzjkl0Zqat7d/Ev1
 rzCM2n5sbADraMbHsUvlldBrq93yVXCtDtNuS450Ov/od1U7wC+2UAZSs7+gRl4zMzWlLkaQLPS
 O/uDY+hxI3o6kXE0yJitCGieF4qySkXeFThA+tZmSnMuwOvflYGpHRHKPMUkXfuyhB2g5aLMhlf
 6Q9IXFBs+joe5KuRDl1GPUBfoHwljvep9mfW45QzVrJIIzA4USMBfispO6VkScUBLLqzIMsbzfD
 gs8VRxJ1+UuMb85r+t5WOrXAaQCMLVdJvg/gXy/hoxBk23kzN0tDDy5K7jj53AQ1M2efvGTiBrN
 UpQCIsFAURxb9uOsZDxbGXrr26MeQdejQVuyXNNNxS4EA8L3IzjB9uWdxUktqcd/dY86GdXEmuN
 Qsc=
X-Received: by 2002:a05:600c:1c28:b0:493:bd2a:93bb with SMTP id
 5b1f17b1804b1-4954a3d0be6mr268682215e9.3.1784723947050; 
 Wed, 22 Jul 2026 05:39:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b01a758sm58756115e9.4.2026.07.22.05.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 05:39:06 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 12:39:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
X-Gerrit-Change-Number: 1800
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1800?usp=email>
X-Gerrit-Commit: b087a96b8d7aba941aed49a12d12652cc777e913
In-Reply-To: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
References: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzIyNzQ0MDAwLklhZDk0ZTdhOWQwYjNiZThhOGRiMDllOWEyMGVhYWM2MDQxNDcwYWI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a4dffe606ce2be78a1176126bee58104e980a99b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmWEI-0005Bf-UW
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
Content-Type: multipart/mixed; boundary="===============5440366797423043059=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5440366797423043059==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="17JN42l+Ns0="; charset=UTF-8

--17JN42l+Ns0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#2)=2E ( http://gerrit=2Eopenvpn=2E=
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
pn refs/changes/00/1800/2

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
index 1a69e6f=2E=2E49faefa 100644
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
+ * @parm field          name of t=
he field to be extracted
+ * @parm default_value  value to return if not fo=
und or cannot be extracted
+ */
+unsigned int
+peer_info_extract_uint(const=
 char *peer_info, const char *field, unsigned int default_value);
+
+/**
  =
* Extracts a variable from peer info, the returned string will be allocated=

  * using the supplied gc_arena
  *
  * @param peer_info     The peer's pe=
er_info
- * @param var           The variable *including* =3D, e=2Eg=2E IV_=
CIPHERS=3D
+ * @param var           The variable *excluding* =3D, e=2Eg=2E =
IV_CIPHERS
  * @param gc            GC arena to allocate return value in
  =
*
  * @return  The content of the variable as NULL terminated string or NUL=
L if the
@@ -51,8 +62,11 @@
  *
  * @param peer_info     peer info string t=
o search for IV_PROTO
  */
-unsigned int extract_iv_proto(const char *peer_=
info);
-
+static inline unsigned int
+extract_iv_proto(const char *peer_inf=
o)
+{
+    return peer_info_extract_uint(peer_info, "IV_PROTO", 0);
+}
 
 /=
**
  * Extracts the ID variable and returns its value or
diff --git a/src/o=
penvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 162f68f=2E=2E33173=
80 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec=

@@ -861,7 +861,7 @@
 {
     struct gc_arena gc =3D gc_new();
 
-    char *=
iv_sso =3D extract_var_peer_info(peer_info, "IV_SSO=3D", &gc);
+    char *i=
v_sso =3D extract_var_peer_info(peer_info, "IV_SSO", &gc);
     if (!iv_sso=
)
     {
         gc_free(&gc);
diff --git a/tests/unit_tests/openvpn/Makef=
ile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index d861ef9=2E=2E5ccf3c=
e 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_test=
s/openvpn/Makefile=2Eam
@@ -395,7 +395,8 @@
 	$(top_srcdir)/src/openvpn/pla=
tform=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \
 	$(top_srcdir)/=
src/openvpn/otime=2Ec \
-	$(top_srcdir)/src/openvpn/list=2Ec
+	$(top_srcdir=
)/src/openvpn/list=2Ec \
+	$(top_srcdir)/src/openvpn/ssl_util=2Ec
 
 socket=
_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/com=
pat -I$(top_srcdir)/src/openvpn \
diff --git a/tests/unit_tests/openvpn/tes=
t_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
i=
ndex 219b476=2E=2E389fa09 100644
--- a/tests/unit_tests/openvpn/test_push_u=
pdate_msg=2Ec
+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
@@ -1=
88,12 +188,6 @@
 {
     return true;
 }
-
-unsigned int
-extract_iv_proto(c=
onst char *peer_info)
-{
-    return IV_PROTO_PUSH_UPDATE;
-}
 #endif /* if=
def ENABLE_MANAGEMENT */
 
 /* tests */
@@ -650,6 +644,7 @@
     m->instanc=
es =3D calloc(1, sizeof(struct multi_instance *));
     struct multi_instan=
ce *mi =3D calloc(1, sizeof(struct multi_instance));
     mi->context=2Ec2=
=2Etls_multi =3D calloc(1, sizeof(struct tls_multi));
+    mi->context=2Ec2=
=2Etls_multi->peer_info =3D "IV_PROTO=3D4096";  // IV_PROTO_PUSH_UPDATE
   =
  *(m->instances) =3D mi;
     m->top=2Eoptions=2Edisable_dco =3D true;
   =
  *state =3D m;
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/=
unit_tests/openvpn/test_ssl=2Ec
index 0e9cecf=2E=2E9c2a99d 100644
--- a/tes=
ts/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=
=2Ec
@@ -48,7 +48,9 @@
 #include "buffer=2Eh"
 #include "cert_data=2Eh"
 #i=
nclude "packet_id=2Eh"
+#include "ssl_util=2Eh"
 #include "ssl_verify=2Eh"
=
+#include "openvpn=2Eh"
 
 /* Mock function to be allowed to include win32=
=2Ec which is required for
  * getting the temp directory */
@@ -829,6 +831=
,61 @@
     free_certificate(cert);
 }
 
+void
+ssl_test_extract_peer_info(=
void **state)
+{
+    const char *peer_info_normal =3D
+        "IV_VER=3D2=
=2E6_git\nIV_PLAT=3Dmac\nIV_TCPNL=3D1\nIV_NCP=3D2\n"
+        "IV_CIPHERS=
=3DAES-256-GCM:AES-128-GCM:CHACHA20-POLY1305\n"
+        "IV_PROTO=3D94\nIV=
_LZO_STUB=3D1\nIV_COMP_STUB=3D1\nP=3D78\nIV_COMP_STUBv2=3D1\n"
+        "IV=
_SSL=3DOpenSSL_3=2E0=2E5_5_Jul_2022\nIV_LZ4v2=3D1";
+
+    const char *empt=
y =3D "";
+    const char *invalid_proto =3D "IV_PROTO=3Dseven\nIV_SSL=3D7\=
nP=3D300\nID=3Dxyz";
+    const char *test_prefix =3D "UV_IV_PROTO=3D773\nN=
P=3D112\nPD=3D8\n";
+
+
+    assert_int_equal(extract_iv_proto(peer_info_no=
rmal), 94);
+    assert_int_equal(extract_iv_proto(empty), 0);
+    assert_=
int_equal(extract_iv_proto(invalid_proto), 0);
+    /* This should not pick=
 up the UV_IV_PROTO that has the extra prefix */
+    assert_int_equal(extr=
act_iv_proto(test_prefix), 0);
+
+    assert_int_equal(peer_info_extract_ui=
nt(peer_info_normal, "IV_COMP_STUB", 0), 1);
+    assert_int_equal(peer_inf=
o_extract_uint(empty, "IV_COMP_STUB", 0xfe0d0d), 0xfe0d0d);
+    assert_int=
_equal(peer_info_extract_uint(invalid_proto, "IV_COMP_STUB", 5), 5);
+
+   =
 assert_int_equal(peer_info_extract_uint(test_prefix, "NP", 23), 112);
+   =
 assert_int_equal(peer_info_extract_uint(test_prefix, "PD", 23), 8);
+    a=
ssert_int_equal(peer_info_extract_uint(test_prefix, "P", 0xfe0d0d), 0xfe0d0=
d);
+    assert_int_equal(peer_info_extract_uint(peer_info_normal, "P", 23)=
, 78);
+    assert_int_equal(peer_info_extract_uint(test_prefix, "UV_IV_PRO=
TO", 23), 773);
+
+    struct gc_arena gc =3D gc_new();
+
+    const char *=
peer_ciphers =3D extract_var_peer_info(peer_info_normal, "IV_CIPHERS", &gc)=
;
+    assert_string_equal(peer_ciphers, "AES-256-GCM:AES-128-GCM:CHACHA20-=
POLY1305");
+
+    /* with the extra =3D this should not extract anything *=
/
+    const char *proto =3D extract_var_peer_info(peer_info_normal, "IV_PR=
OTO=3D", &gc);
+    assert_null(proto);
+
+    const char *double_eq_info =
=3D "FOO=3D7\nFOO=3D=3Dnew";
+    const char *foo_eq =3D extract_var_peer_i=
nfo(double_eq_info, "FOO=3D", &gc);
+    const char *foo =3D extract_var_pe=
er_info(double_eq_info, "FOO", &gc);
+    assert_string_equal(foo, "7");
+ =
   assert_string_equal(foo_eq, "new");
+
+    assert_int_equal(extract_asym=
metric_peer_id(double_eq_info), MAX_PEER_ID);
+    assert_int_equal(extract=
_asymmetric_peer_id(peer_info_normal), MAX_PEER_ID);
+    assert_int_equal(=
extract_asymmetric_peer_id(invalid_proto), MAX_PEER_ID);
+    assert_int_eq=
ual(extract_asymmetric_peer_id("ID=3Df7"), 0xf7);
+    assert_int_equal(ext=
ract_asymmetric_peer_id("X=3Dfoo\nID=3D12ab"), 0x12ab);
+    assert_int_equ=
al(extract_asymmetric_peer_id("X=3Dfoo\nID=3D34dd\nY=3Dbar"), 0x34dd);
+   =
 assert_int_equal(extract_asymmetric_peer_id("X=3Dfoo\nID=3D12345678"), MAX=
_PEER_ID);
+
+    gc_free(&gc);
+}
 
 int
 main(void)
@@ -853,7 +910,8 @@
 =
        cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),
         cmoc=
ka_unit_test(test_data_channel_known_vectors_epoch),
         cmocka_unit_t=
est(test_data_channel_known_vectors_shortpktid),
-        cmocka_unit_test(=
crypto_test_print_cert_details)
+        cmocka_unit_test(crypto_test_print=
_cert_details),
+        cmocka_unit_test(ssl_test_extract_peer_info)
 
   =
  };
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad94e7a9d=
0b3be8a8db09e9a20eaac6041470ab6
Gerrit-Change-Number: 1800
Gerrit-PatchSet:=
 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>

--17JN42l+Ns0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://g=
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
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/00/1800/2<=
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
ndex 1a69e6f=2E=2E49faefa 100644</span><br><span>--- a/src/openvpn/ssl_util=
=2Eh</span><br><span>+++ b/src/openvpn/ssl_util=2Eh</span><br><span>@@ -33,=
11 +33,22 @@</span><br><span> #include &quot;buffer=2Eh&quot;</span><br><sp=
an> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Extracts the named variable and returns its value or default_value=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * if it cannot be =
extracted=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param peer_info     =
peer info string to search in</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @parm field          name of the field to be extracted</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @parm default_value  val=
ue to return if not found or cannot be extracted</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+peer_info_extract_uint(const char *peer_info, const char *field, unsi=
gned int default_value);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span>  * Extracts a variable from peer info, the returned string will be a=
llocated</span><br><span>  * using the supplied gc_arena</span><br><span>  =
*</span><br><span>  * @param peer_info     The peer&#39;s peer_info</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @param var           The v=
ariable *including* =3D, e=2Eg=2E IV_CIPHERS=3D</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param var           The variable *excluding=
* =3D, e=2Eg=2E IV_CIPHERS</span><br><span>  * @param gc            GC aren=
a to allocate return value in</span><br><span>  *</span><br><span>  * @retu=
rn  The content of the variable as NULL terminated string or NULL if the</s=
pan><br><span>@@ -51,8 +62,11 @@</span><br><span>  *</span><br><span>  * @p=
aram peer_info     peer info string to search for IV_PROTO</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int extr=
act_iv_proto(const char *peer_info);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic inline unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+extract_iv_proto(const char *peer_info)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return peer_info_extract_uint(peer_info, &quot;IV_PROTO&quot;, 0);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> =
</span><br><span> /**</span><br><span>  * Extracts the ID variable and retu=
rns its value or</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/=
src/openvpn/ssl_verify=2Ec</span><br><span>index 162f68f=2E=2E3317380 10064=
4</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/sr=
c/openvpn/ssl_verify=2Ec</span><br><span>@@ -861,7 +861,7 @@</span><br><spa=
n> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *iv_sso =3D=
 extract_var_peer_info(peer_info, &quot;IV_SSO=3D&quot;, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    char *iv_sso =3D extract=
_var_peer_info(peer_info, &quot;IV_SSO&quot;, &amp;gc);</span><br><span>   =
  if (!iv_sso)</span><br><span>     {</span><br><span>         gc_free(&amp=
;gc);</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b=
/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index d861ef9=2E=2E=
5ccf3ce 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam=
</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><sp=
an>@@ -395,7 +395,8 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platform=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/options_util=2Ec \</span=
><br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/list=2Ec</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/lis=
t=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdi=
r)/src/openvpn/ssl_util=2Ec</span><br><span> </span><br><span> socket_testd=
river_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdi=
r)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span>diff --git a/te=
sts/unit_tests/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/=
test_push_update_msg=2Ec</span><br><span>index 219b476=2E=2E389fa09 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_push_update_msg=2Ec</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span>=
<br><span>@@ -188,12 +188,6 @@</span><br><span> {</span><br><span>     retu=
rn true;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-extract_iv_proto(const c=
har *peer_info)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return IV_PROTO_PUSH_U=
PDATE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><span>=
 /* tests */</span><br><span>@@ -650,6 +644,7 @@</span><br><span>     m-&gt=
;instances =3D calloc(1, sizeof(struct multi_instance *));</span><br><span>=
     struct multi_instance *mi =3D calloc(1, sizeof(struct multi_instance))=
;</span><br><span>     mi-&gt;context=2Ec2=2Etls_multi =3D calloc(1, sizeof=
(struct tls_multi));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D409=
6&quot;;  // IV_PROTO_PUSH_UPDATE</span><br><span>     *(m-&gt;instances) =
=3D mi;</span><br><span>     m-&gt;top=2Eoptions=2Edisable_dco =3D true;</s=
pan><br><span>     *state =3D m;</span><br><span>diff --git a/tests/unit_te=
sts/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br>=
<span>index 0e9cecf=2E=2E9c2a99d 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_ssl=2Ec</span><br><span>@@ -48,7 +48,9 @@</span><br><span> #include &quot=
;buffer=2Eh&quot;</span><br><span> #include &quot;cert_data=2Eh&quot;</span=
><br><span> #include &quot;packet_id=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;ssl_util=2Eh&quot;</span><br><spa=
n> #include &quot;ssl_verify=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</span><br><span> </span=
><br><span> /* Mock function to be allowed to include win32=2Ec which is re=
quired for</span><br><span>  * getting the temp directory */</span><br><spa=
n>@@ -829,6 +831,61 @@</span><br><span>     free_certificate(cert);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_t=
est_extract_peer_info(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *peer_info_normal =3D</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        &quot;IV_VER=3D2=2E6_git\nIV_PLAT=3Dmac\nIV_TCPNL=3D=
1\nIV_NCP=3D2\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        &quot;IV_CIPHERS=3DAES-256-GCM:AES-128-GCM:CHACHA20-POLY1305\n&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;IV=
_PROTO=3D94\nIV_LZO_STUB=3D1\nIV_COMP_STUB=3D1\nP=3D78\nIV_COMP_STUBv2=3D1\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quo=
t;IV_SSL=3DOpenSSL_3=2E0=2E5_5_Jul_2022\nIV_LZ4v2=3D1&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char *empty =3D &quot;&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const char *invalid_proto =3D=
 &quot;IV_PROTO=3Dseven\nIV_SSL=3D7\nP=3D300\nID=3Dxyz&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const char *test_prefix =3D &=
quot;UV_IV_PROTO=3D773\nNP=3D112\nPD=3D8\n&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(extract_iv_proto(peer_info_normal), 94);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(extract_iv_proto(emp=
ty), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(extract_iv_proto(invalid_proto), 0);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* This should not pick up the UV_IV_PROTO t=
hat has the extra prefix */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(extract_iv_proto(test_prefix), 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(peer_info_extract_uint(peer_i=
nfo_normal, &quot;IV_COMP_STUB&quot;, 0), 1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(peer_info_extract_uint(empty=
, &quot;IV_COMP_STUB&quot;, 0xfe0d0d), 0xfe0d0d);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(peer_info_extract_uint(i=
nvalid_proto, &quot;IV_COMP_STUB&quot;, 5), 5);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(peer_info_extract_uint(test_prefix, &quot;NP&=
quot;, 23), 112);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(peer_info_extract_uint(test_prefix, &quot;PD&quot;, 23),=
 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(peer_info_extract_uint(test_prefix, &quot;P&quot;, 0xfe0d0d), 0xfe0d0=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(peer_info_extract_uint(peer_info_normal, &quot;P&quot;, 23), 78);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(pee=
r_info_extract_uint(test_prefix, &quot;UV_IV_PROTO&quot;, 23), 773);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const char *peer_ciphers =3D extract_var_pe=
er_info(peer_info_normal, &quot;IV_CIPHERS&quot;, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(peer_cipher=
s, &quot;AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* with the extra =3D this should not extract anyth=
ing */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *proto =3D extract_var_peer_info(peer_info_normal, &quot;IV_PROTO=3D&quot=
;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_null(proto);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *double=
_eq_info =3D &quot;FOO=3D7\nFOO=3D=3Dnew&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const char *foo_eq =3D extract_var_peer_inf=
o(double_eq_info, &quot;FOO=3D&quot;, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const char *foo =3D extract_var_peer_info(d=
ouble_eq_info, &quot;FOO&quot;, &amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_string_equal(foo, &quot;7&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(foo_=
eq, &quot;new&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(extract_asymmetric_peer_id(double_eq_info), MAX_PEER_ID);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(extract_asym=
metric_peer_id(peer_info_normal), MAX_PEER_ID);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(extract_asymmetric_peer_id=
(invalid_proto), MAX_PEER_ID);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(extract_asymmetric_peer_id(&quot;ID=3Df7&qu=
ot;), 0xf7);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(extract_asymmetric_peer_id(&quot;X=3Dfoo\nID=3D12ab&quot;), 0=
x12ab);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(extract_asymmetric_peer_id(&quot;X=3Dfoo\nID=3D34dd\nY=3Dbar&quot;=
), 0x34dd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(extract_asymmetric_peer_id(&quot;X=3Dfoo\nID=3D12345678&quot;)=
, MAX_PEER_ID);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </=
span><br><span> int</span><br><span> main(void)</span><br><span>@@ -853,7 +=
910,8 @@</span><br><span>         cmocka_unit_test(test_data_channel_roundt=
rip_bf_cbc),</span><br><span>         cmocka_unit_test(test_data_channel_kn=
own_vectors_epoch),</span><br><span>         cmocka_unit_test(test_data_cha=
nnel_known_vectors_shortpktid),</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        cmocka_unit_test(crypto_test_print_cert_details)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(cry=
pto_test_print_cert_details),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(ssl_test_extract_peer_info)</span><br><s=
pan> </span><br><span>     };</span><br><span> </span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1800?usp=3Demail">change 1800</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1800?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1800 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--17JN42l+Ns0=--


--===============5440366797423043059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5440366797423043059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5440366797423043059==--

