Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14214C44532
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1GRteG/NasWhjnL3+oJF7lEgJ3GciHTzcLGd8ZFQ06w=; b=MuxtOQULi/D49pDXwxClqM1l2i
	ozE3l9lsPxddyApN6Q1M1L166jDYLJb1U0nxlXRBgkzzIWGbzsOXkQ/7WLNkzdmjL89wQ4t/cSVTT
	QNEGlctn+7FX+9BwKX3fLFX6rr1RvsquW5WOEP1uxqjhbkXrm+XijzwuktxVxlj0MieM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmaX3-0008CG-4r;
	Wed, 22 Jul 2026 17:14:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmaX2-0008CA-0I
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 17:14:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZqbVapkzRkIefggXEJX0FfppTAkoogj+WR8DeJ61GQg=; b=XO3aL5fZ4l7tqcuQXeptN6M088
 9YexXdew3B/fZydB5nKno4ECu99ynXRK2Cv3va8Zh+6RV2DNIDHcflT5eO5EsOingsVYU03lfxdH5
 o5ZxiaPR7HofQxDyA+qK00t/BMgqXMCHbxTYdTF46bNn5Y1JwqJcNJAOEKhQCnh8PrbE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZqbVapkzRkIefggXEJX0FfppTAkoogj+WR8DeJ61GQg=; b=C
 thzuXKjUB67FLhN0HOtpOgXkpEwOCAcqZVBN3M7lFPZM4q1c5rSjhCjRsyeLcS5q2yWKU4aQlzqza
 FkIyHb9v9zNS1hicW6Nr7so3rMMY6IC4+8vaq/ehn9WYIMwCQj1mU6A2D2h5bDXz58b0ImEbR2VGt
 UN4RiOKl+/eYb6p0=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmaWz-0004jm-Ol for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 17:14:56 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so68902345e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784740487; x=1785345287; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZqbVapkzRkIefggXEJX0FfppTAkoogj+WR8DeJ61GQg=;
 b=dNcgnLa/s6QbY4Uvq6v1AZDfBnprA6JDjW4JpzR0MvNKmzWbOvSGcqgpwy2ytiujoz
 4Nixt4ZDZSNs0erCIAvHfwsCxwUnNc5Ko57YJ9yT/auQBYUFDpyq6konBnBQHpyN0vzN
 mKG4th5MSlJUehWT5nLJRvzoflJeElzD0XJ6n3gzGlsDmy+aJZDMwJi9MsvzL+FP/jbH
 0t3iuqMn9ufMzxiZGuoFUNsA+620Pz3S6SvmAR3CXEqh3w4QUlT5veXJTtEg6qyVDJ29
 w0A5Moa2Bywa5+hWwS1nX8gm/XU8dNNc4S6aImqQuM8JCaYF/nHb0xN6m+5L//vVPLlY
 CMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784740487; x=1785345287;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZqbVapkzRkIefggXEJX0FfppTAkoogj+WR8DeJ61GQg=;
 b=jGkPKWiAgQ+EoNvGF6rYPlqWc1JXj4zlUSjKMl3bIds4o2vsbjTXCKVb6q6Rr7jGDI
 21PrDcQv7wmOXxKO6CW9/0fdZ7m5rEsyJDEfG6+wHH5/e1QWVwNLZ6w1GLCDP5NNt3lu
 /8YqhJH5gM+XBspEIqkBDCHTwrF2ViAOZ2SIWHjQ9civ7U8WVDbNdjxjL7LNDJKVEmEG
 xlWpV3OQ95JldEeCgX5E/EHqQ2YmEg93yd92/s9NjNhgxP79U8/tq+rIJkML7edkv6bA
 +61IwdCE9yoTfxmO4RMqX15jtIMj1KltCXD1xwBNMifuwjsvtOtmQlN2VgtvA67r1UOh
 XV9Q==
X-Gm-Message-State: AOJu0YyOewsEuTTrO6T6IVpPuMgGzjqf3SWuMsR5lc1mBl/bTLOoWywL
 JVt7irAitHAiG1XefD+b7jSOhuphrEdvYquqpY9nrovX3vqWkXYj6u4TWMLvT2DQSuuOGzPfo2L
 ibND9bWdCZhOED7SK5Z8G2rXAvt7lYbEzuqbigl1GC8cW7e2GCgBI7jGyB5iGWkCImGdyMFo9Kx
 O7guWmgg==
X-Gm-Gg: AR+sD10ygT5N/hXpBySaGcqeDrPR/31ZP/pNU2MwIHSTDIZ1cPH03SIOZ4jTS+D5B5X
 NIfzqEmk1tztm632X+tNMryhShu06SOAI2DIzpL+zpLPf3dCGkOzdUDng8BEzgUrYTgJ99cflBP
 xSO5o1g50tTjqgnF3QGCNPofaU9G5OpRmHQUoiT7dCYQe3Jzr5AntZtOtgWAp1egcamYAVeoxcZ
 xfzcARhfHPJy8a8a/Lm8Jpo6ep1OBqy2rDbPlHxiowXEqYRhTAxjyD5fDz2cxiWSLxaWws5gUGs
 DCciL3oL063dodEjuhAz3AYKEP3wlMKO4EP8jXqI7UG6/ZYuqEKDdDymttIahSXli2sg9OGzJOz
 0iCYypGpqffKkKg4Eef076AUvT2MxQJXAvraxOtn4T6EmUIHM/oUPf2vSjVsIr635TBLUK8zhuM
 VkDfdNh3408ju4uP438xKRVPMEXZWDCkpuksQ2vHCI2yYcZAIrcRbZouV/v9UX+pW2olYiy6ikf
 hLDVeb2iH2SCCjC5Qx6VCw2UJ0PcnapgNs7QP3TiaZyU6/XOVTbT99kwp6St0+UhuvA
X-Received: by 2002:a05:600c:3506:b0:492:6447:7a7f with SMTP id
 5b1f17b1804b1-4954a3d0070mr274126225e9.6.1784740486923; 
 Wed, 22 Jul 2026 10:14:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6e9a2sm7795807f8f.35.2026.07.22.10.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:14:46 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 17:14:44 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
X-Gerrit-Change-Number: 1800
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1800?usp=email>
X-Gerrit-Commit: 1ecf48732b06b461ef608e4f3509d49b8bdc6317
In-Reply-To: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
References: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzIyNzQ0MDAwLklhZDk0ZTdhOWQwYjNiZThhOGRiMDllOWEyMGVhYWM2MDQxNDcwYWI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6704325abce978c725343398455df3ef8593a2a1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmaWz-0004jm-Ol
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7852759959491906420=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7852759959491906420==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aLzJ71xI2QA="; charset=UTF-8

--aLzJ71xI2QA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

Hello cron2, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1800?usp=3Demail

to look at the new patch set (#4)=
=2E

The following approvals got outdated and were removed:
Code-Review-1 b=
y cron2


Change subject: Allow extracing other integers from peer info and=
 add a unit test for it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Allow extracing other integers from peer info and add a unit tes=
t for it

This also ensure that we only really extract the variable we are =
looking
for=2E The old code would also consider UV_IV_NCP to be IV_NCP=2E

=
Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
Signed-off-by: Arne Sc=
hwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M src/openvpn/push=2Ec
M =
src/openvpn/ssl_ncp=2Ec
M src/openvpn/ssl_util=2Ec
M src/openvpn/ssl_util=
=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/te=
st_push_update_msg=2Ec
M tests/unit_tests/openvpn/test_ssl=2Ec
8 files chan=
ged, 158 insertions(+), 54 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/00/1800/4

diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt
index 7473f15=2E=2E21bcb91 100644
--- a/CMakeLists=2Etxt=

+++ b/CMakeLists=2Etxt
@@ -908,7 +908,8 @@
         src/openvpn/options_ut=
il=2Ec
         src/openvpn/otime=2Ec
         src/openvpn/list=2Ec
-      =
  )
+        src/openvpn/ssl_util=2Ec
+    )
 
     target_sources(test_arg=
v PRIVATE
         tests/unit_tests/openvpn/mock_get_random=2Ec
diff --git =
a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 633c007d=2E=2Ece2baf2 1=
00644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -718,9 +718,=
9 @@
 
     /* Push our mtu to the peer if it supports pushable MTUs */
   =
  int client_max_mtu =3D 0;
-    const char *iv_mtu =3D extract_var_peer_in=
fo(tls_multi->peer_info, "IV_MTU=3D", gc);
+    unsigned int iv_mtu =3D pee=
r_info_extract_uint(tls_multi->peer_info, "IV_MTU=3D");
 
-    if (iv_mtu &=
& sscanf(iv_mtu, "%d", &client_max_mtu) =3D=3D 1)
+    if (iv_mtu !=3D 0)
 =
    {
         push_option_fmt(gc, push_list, M_USAGE, "tun-mtu %d", o->ce=
=2Etun_mtu);
         if (client_max_mtu < o->ce=2Etun_mtu)
diff --git a/sr=
c/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index b450de8=2E=2E8b0f28d =
100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -55,2=
0 +55,10 @@
  * Return the Negotiable Crypto Parameters version advertised =
in the peer info
  * string, or 0 if none specified=2E
  */
-static int
+st=
atic unsigned int
 tls_peer_info_ncp_ver(const char *peer_info)
 {
-    con=
st char *ncpstr =3D peer_info ? strstr(peer_info, "IV_NCP=3D") : NULL;
-   =
 if (ncpstr)
-    {
-        int ncp =3D 0;
-        int r =3D sscanf(ncpst=
r, "IV_NCP=3D%d", &ncp);
-        if (r =3D=3D 1)
-        {
-            r=
eturn ncp;
-        }
-    }
-    return 0;
+    return peer_info_extract_u=
int(peer_info, "IV_NCP=3D");
 }
 
 /**
diff --git a/src/openvpn/ssl_util=2E=
c b/src/openvpn/ssl_util=2Ec
index 2f01f8a=2E=2Ee6af145 100644
--- a/src/op=
envpn/ssl_util=2Ec
+++ b/src/openvpn/ssl_util=2Ec
@@ -27,28 +27,55 @@
 #inc=
lude "openvpn=2Eh"
 #include "ssl_util=2Eh"
 
-char *
-extract_var_peer_inf=
o(const char *peer_info, const char *var, struct gc_arena *gc)
+/**
+ * Loo=
ks for the string field at the start of peer_info or
+ * after any new line=
 and returns a pointer to the start of the field
+ * or NULL if not found=
=2E
+ */
+static const char *
+peer_info_extract_varstr(const char *peer_in=
fo, const char *field)
 {
     if (!peer_info)
     {
         return NULL;=

     }
 
-    const char *var_start =3D strstr(peer_info, var);
+    while=
 (peer_info)
+    {
+        /* peer info starts with this field */
+      =
  if (strncmp(peer_info, field, strlen(field)) =3D=3D 0)
+        {
+      =
      return peer_info;
+        }
+
+        /* skip to the next line */
+=
        peer_info =3D strchr(peer_info, '\n');
+        if (peer_info)
+   =
     {
+            /* skip the '\n' itself */
+            peer_info++;
+ =
       }
+    }
+    return NULL;
+}
+
+char *
+extract_var_peer_info(const=
 char *peer_info, const char *var, struct gc_arena *gc)
+{
+    const char =
*var_start =3D peer_info_extract_varstr(peer_info, var);
     if (!var_star=
t)
     {
-        /* variable not found in peer info */
+        /* variab=
le hasn't been found in peer info */
         return NULL;
     }
 
+    /*=
 skip over the variable name (includes the =3D as per API)*/
     var_start=
 +=3D strlen(var);
-    const char *var_end =3D strstr(var_start, "\n");
- =
   if (!var_end)
-    {
-        /* var is at end of the peer_info list and=
 no '\n' follows */
-        var_end =3D var_start + strlen(var_start);
-  =
  }
+
+    /* returns the location of the next '\n' or the end of the
+    =
 * string if the variable is already on the last line */
+    const char *v=
ar_end =3D strchrnul(var_start, '\n');
+
 
     char *var_value =3D string_=
alloc(var_start, gc);
     /* NULL terminate the copy at the right position=
 */
@@ -56,38 +83,40 @@
     return var_value;
 }
 
+
 unsigned int
-extrac=
t_iv_proto(const char *peer_info)
+peer_info_extract_int(const char *peer_i=
nfo, const char *field, const char *format, unsigned int default_value)
 {
=
-    const char *optstr =3D peer_info ? strstr(peer_info, "IV_PROTO=3D") : =
NULL;
+    const char *optstr =3D peer_info_extract_varstr(peer_info, field=
);
     if (optstr)
     {
-        int proto =3D 0;
-        int r =3D ssc=
anf(optstr, "IV_PROTO=3D%d", &proto);
-        if (r =3D=3D 1 && proto > 0)=

+        optstr +=3D strlen(field);
+
+        int value =3D 0;
+        i=
nt r =3D sscanf(optstr, format, &value);
+        if (r =3D=3D 1 && value >=
=3D 0)
         {
-            return proto;
+            return value;
   =
      }
     }
-    return 0;
+    return default_value;
+}
+
+unsigned int=

+peer_info_extract_uint(const char *peer_info, const char *field)
+{
+    =
return peer_info_extract_int(peer_info, field, "%u", 0);
 }
 
 uint32_t
 ex=
tract_asymmetric_peer_id(const char *peer_info)
 {
-    for (const char *p =
=3D peer_info; p && (p =3D strstr(p, "ID=3D")); p +=3D 3)
+    uint32_t pee=
r_id =3D peer_info_extract_int(peer_info, "ID=3D", "%x", MAX_PEER_ID);
+   =
 if (peer_id < MAX_PEER_ID)
     {
-        /* only accept "ID=3D" at the s=
tart of a line, so it does not match
-         * substrings like "UV_ID=3D"=
 or "GUID=3D" */
-        if (p =3D=3D peer_info || p[-1] =3D=3D '\n')
-   =
     {
-            uint32_t peer_id =3D 0;
-            if (sscanf(p, "ID=
=3D%x", &peer_id) =3D=3D 1 && peer_id < MAX_PEER_ID)
-            {
-      =
          return peer_id;
-            }
-        }
+        return peer_id=
;
     }
+
     return MAX_PEER_ID;
 }
 
diff --git a/src/openvpn/ssl_util=
=2Eh b/src/openvpn/ssl_util=2Eh
index 1a69e6f=2E=2E751af85 100644
--- a/src=
/openvpn/ssl_util=2Eh
+++ b/src/openvpn/ssl_util=2Eh
@@ -33,11 +33,31 @@
 #=
include "buffer=2Eh"
 
 /**
+ * Extracts the named integer variable and ret=
urns its value or default_value
+ * if it cannot be extracted=2E
+ *
+ * @p=
aram peer_info     peer info string to search in
+ * @param field          =
name of the field to be extracted
+ */
+unsigned int
+peer_info_extract_int=
(const char *peer_info, const char *field, const char *format, unsigned int=
 default_value);
+
+/**
+ * Extracts the named integer variable and returns=
 its value or 0
+ * if it cannot be extracted=2E
+ *
+ * @param peer_info  =
   peer info string to search in
+ * @param field          name of the fiel=
d to be extracted
+ */
+unsigned int
+peer_info_extract_uint(const char *pe=
er_info, const char *field);
+
+/**
  * Extracts a variable from peer info,=
 the returned string will be allocated
  * using the supplied gc_arena
  *
=
  * @param peer_info     The peer's peer_info
- * @param var           The =
variable *including* =3D, e=2Eg=2E IV_CIPHERS=3D
+ * @param var           T=
he variable including =3D, e=2Eg=2E IV_CIPHERS=3D
  * @param gc            =
GC arena to allocate return value in
  *
  * @return  The content of the va=
riable as NULL terminated string or NULL if the
@@ -51,8 +71,11 @@
  *
  * =
@param peer_info     peer info string to search for IV_PROTO
  */
-unsigned=
 int extract_iv_proto(const char *peer_info);
-
+static inline unsigned int=

+extract_iv_proto(const char *peer_info)
+{
+    return peer_info_extract_=
uint(peer_info, "IV_PROTO=3D");
+}
 
 /**
  * Extracts the ID variable and =
returns its value or
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/=
tests/unit_tests/openvpn/Makefile=2Eam
index d861ef9=2E=2E5ccf3ce 100644
--=
- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/M=
akefile=2Eam
@@ -395,7 +395,8 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec \=

 	$(top_srcdir)/src/openvpn/options_util=2Ec \
 	$(top_srcdir)/src/openvpn=
/otime=2Ec \
-	$(top_srcdir)/src/openvpn/list=2Ec
+	$(top_srcdir)/src/openv=
pn/list=2Ec \
+	$(top_srcdir)/src/openvpn/ssl_util=2Ec
 
 socket_testdriver=
_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top=
_srcdir)/src/openvpn \
diff --git a/tests/unit_tests/openvpn/test_push_upda=
te_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
index 219b47=
6=2E=2E389fa09 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg=
=2Ec
+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
@@ -188,12 +18=
8,6 @@
 {
     return true;
 }
-
-unsigned int
-extract_iv_proto(const char=
 *peer_info)
-{
-    return IV_PROTO_PUSH_UPDATE;
-}
 #endif /* ifdef ENABL=
E_MANAGEMENT */
 
 /* tests */
@@ -650,6 +644,7 @@
     m->instances =3D ca=
lloc(1, sizeof(struct multi_instance *));
     struct multi_instance *mi =
=3D calloc(1, sizeof(struct multi_instance));
     mi->context=2Ec2=2Etls_m=
ulti =3D calloc(1, sizeof(struct tls_multi));
+    mi->context=2Ec2=2Etls_m=
ulti->peer_info =3D "IV_PROTO=3D4096";  // IV_PROTO_PUSH_UPDATE
     *(m->i=
nstances) =3D mi;
     m->top=2Eoptions=2Edisable_dco =3D true;
     *state=
 =3D m;
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tes=
ts/openvpn/test_ssl=2Ec
index 0e9cecf=2E=2E03544ea 100644
--- a/tests/unit_=
tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -=
48,7 +48,9 @@
 #include "buffer=2Eh"
 #include "cert_data=2Eh"
 #include "p=
acket_id=2Eh"
+#include "ssl_util=2Eh"
 #include "ssl_verify=2Eh"
+#include=
 "openvpn=2Eh"
 
 /* Mock function to be allowed to include win32=2Ec which=
 is required for
  * getting the temp directory */
@@ -829,6 +831,68 @@
   =
  free_certificate(cert);
 }
 
+void
+ssl_test_extract_peer_info(void **sta=
te)
+{
+    const char *peer_info_normal =3D
+        "IV_VER=3D2=2E6_git\n=
IV_PLAT=3Dmac\nIV_TCPNL=3D1\nIV_NCP=3D2\n"
+        "IV_CIPHERS=3DAES-256-G=
CM:AES-128-GCM:CHACHA20-POLY1305\n"
+        "IV_PROTO=3D94\nIV_LZO_STUB=3D=
1\nIV_COMP_STUB=3D1\nP=3D78\nIV_COMP_STUBv2=3D1\n"
+        "IV_SSL=3DOpenS=
SL_3=2E0=2E5_5_Jul_2022\nIV_LZ4v2=3D1";
+
+    const char *empty =3D "";
+ =
   const char *invalid_proto =3D "IV_PROTO=3Dseven\nIV_SSL=3D7\nP=3D300\nID=
=3Dxyz";
+    const char *test_prefix =3D "UV_IV_PROTO=3D773\nNP=3D112\nPD=
=3D8\n";
+
+
+    assert_int_equal(extract_iv_proto(peer_info_normal), 94);=

+    assert_int_equal(extract_iv_proto(empty), 0);
+    assert_int_equal(e=
xtract_iv_proto(invalid_proto), 0);
+    /* This should not pick up the UV_=
IV_PROTO that has the extra prefix */
+    assert_int_equal(extract_iv_prot=
o(test_prefix), 0);
+
+    assert_int_equal(peer_info_extract_uint(peer_inf=
o_normal, "IV_COMP_STUB=3D"), 1);
+    assert_int_equal(peer_info_extract_i=
nt(empty, "IV_COMP_STUB=3D", "%d", 0xfe0d0d), 0xfe0d0d);
+    assert_int_eq=
ual(peer_info_extract_uint(invalid_proto, "IV_COMP_STUB=3D"), 0);
+
+    as=
sert_int_equal(peer_info_extract_int(test_prefix, "NP=3D", "%d", 23), 112);=

+    assert_int_equal(peer_info_extract_uint(test_prefix, "PD=3D"), 8);
+ =
   assert_int_equal(peer_info_extract_int(test_prefix, "P=3D", "%x", 0xfe0d=
0d), 0xfe0d0d);
+    assert_int_equal(peer_info_extract_uint(peer_info_norm=
al, "P=3D"), 78);
+    assert_int_equal(peer_info_extract_uint(test_prefix,=
 "UV_IV_PROTO=3D"), 773);
+
+    struct gc_arena gc =3D gc_new();
+
+    co=
nst char *peer_ciphers =3D extract_var_peer_info(peer_info_normal, "IV_CIPH=
ERS=3D", &gc);
+    assert_string_equal(peer_ciphers, "AES-256-GCM:AES-128-=
GCM:CHACHA20-POLY1305");
+
+    /* with the extra =3D this should not extra=
ct anything */
+    const char *proto =3D extract_var_peer_info(peer_info_n=
ormal, "IV_PROTO=3D=3D", &gc);
+    assert_null(proto);
+
+    proto =3D ex=
tract_var_peer_info(peer_info_normal, "IV_PROTO=3D", &gc);
+    assert_stri=
ng_equal(proto, "94");
+
+
+    const char *double_eq_info =3D "FOO=3D7\nFO=
O=3D=3Dnew";
+    const char *foo_eq =3D extract_var_peer_info(double_eq_in=
fo, "FOO=3D", &gc);
+    const char *foo =3D extract_var_peer_info(double_e=
q_info, "FOO", &gc);
+    const char *foo_2eq =3D extract_var_peer_info(dou=
ble_eq_info, "FOO=3D=3D", &gc);
+
+    assert_string_equal(foo, "=3D7");
+ =
   assert_string_equal(foo_eq, "7");
+    assert_string_equal(foo_2eq, "new=
");
+
+    assert_int_equal(extract_asymmetric_peer_id(double_eq_info), MAX=
_PEER_ID);
+    assert_int_equal(extract_asymmetric_peer_id(peer_info_norma=
l), MAX_PEER_ID);
+    assert_int_equal(extract_asymmetric_peer_id(invalid_=
proto), MAX_PEER_ID);
+    assert_int_equal(extract_asymmetric_peer_id("ID=
=3Df7"), 0xf7);
+    assert_int_equal(extract_asymmetric_peer_id("X=3Dfoo\n=
ID=3D12ab"), 0x12ab);
+    assert_int_equal(extract_asymmetric_peer_id("X=
=3Dfoo\nID=3D34dd\nY=3Dbar"), 0x34dd);
+    assert_int_equal(extract_asymme=
tric_peer_id("X=3Dfoo\nID=3D12345678"), MAX_PEER_ID);
+
+    gc_free(&gc);
=
+}
 
 int
 main(void)
@@ -853,7 +917,8 @@
         cmocka_unit_test(test_da=
ta_channel_roundtrip_bf_cbc),
         cmocka_unit_test(test_data_channel_k=
nown_vectors_epoch),
         cmocka_unit_test(test_data_channel_known_vect=
ors_shortpktid),
-        cmocka_unit_test(crypto_test_print_cert_details)
=
+        cmocka_unit_test(crypto_test_print_cert_details),
+        cmocka_=
unit_test(ssl_test_extract_peer_info)
 
     };
 

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
=
Gerrit-Change-Number: 1800
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <ger=
t@greenie=2Emuc=2Ede>

--aLzJ71xI2QA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p>plaisthos <strong>uploade=
d patch set #4</strong> to this change=2E</p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1800?usp=3Demail">View Change</a></p><p>The follo=
wing approvals got outdated and were removed:
Code-Review-1 by cron2</p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">Allow extracing other integers from peer info and add a unit tes=
t for it<br><br>This also ensure that we only really extract the variable w=
e are looking<br>for=2E The old code would also consider UV_IV_NCP to be IV=
_NCP=2E<br><br>Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6<br>Sign=
ed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=
=2Etxt<br>M src/openvpn/push=2Ec<br>M src/openvpn/ssl_ncp=2Ec<br>M src/open=
vpn/ssl_util=2Ec<br>M src/openvpn/ssl_util=2Eh<br>M tests/unit_tests/openvp=
n/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_push_update_msg=2Ec<br>M=
 tests/unit_tests/openvpn/test_ssl=2Ec<br>8 files changed, 158 insertions(+=
), 54 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/00/1800/4</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLis=
ts=2Etxt b/CMakeLists=2Etxt</span><br><span>index 7473f15=2E=2E21bcb91 1006=
44</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -908,7 +908,8 @@</span><br><span>         src/ope=
nvpn/options_util=2Ec</span><br><span>         src/openvpn/otime=2Ec</span>=
<br><span>         src/openvpn/list=2Ec</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        )</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        src/openvpn/ssl_util=2Ec</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    )</span><br><span> </span><br><span>     target_so=
urces(test_argv PRIVATE</span><br><span>         tests/unit_tests/openvpn/m=
ock_get_random=2Ec</span><br><span>diff --git a/src/openvpn/push=2Ec b/src/=
openvpn/push=2Ec</span><br><span>index 633c007d=2E=2Ece2baf2 100644</span><=
br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=
=2Ec</span><br><span>@@ -718,9 +718,9 @@</span><br><span> </span><br><span>=
     /* Push our mtu to the peer if it supports pushable MTUs */</span><br>=
<span>     int client_max_mtu =3D 0;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    const char *iv_mtu =3D extract_var_peer_info(tls_multi-&=
gt;peer_info, &quot;IV_MTU=3D&quot;, gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    unsigned int iv_mtu =3D peer_info_extract_uint(tl=
s_multi-&gt;peer_info, &quot;IV_MTU=3D&quot;);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (iv_mtu &amp;&amp; sscanf=
(iv_mtu, &quot;%d&quot;, &amp;client_max_mtu) =3D=3D 1)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (iv_mtu !=3D 0)</span><br><span>=
     {</span><br><span>         push_option_fmt(gc, push_list, M_USAGE, &qu=
ot;tun-mtu %d&quot;, o-&gt;ce=2Etun_mtu);</span><br><span>         if (clie=
nt_max_mtu &lt; o-&gt;ce=2Etun_mtu)</span><br><span>diff --git a/src/openvp=
n/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index b450de8=2E=2E=
8b0f28d 100644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><spa=
n>+++ b/src/openvpn/ssl_ncp=2Ec</span><br><span>@@ -55,20 +55,10 @@</span><=
br><span>  * Return the Negotiable Crypto Parameters version advertised in =
the peer info</span><br><span>  * string, or 0 if none specified=2E</span><=
br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static i=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static unsigned i=
nt</span><br><span> tls_peer_info_ncp_ver(const char *peer_info)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const cha=
r *ncpstr =3D peer_info ? strstr(peer_info, &quot;IV_NCP=3D&quot;) : NULL;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ncpstr)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        int ncp =3D 0;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        int r =3D sscanf(ncpstr, &quot;IV_=
NCP=3D%d&quot;, &amp;ncp);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (r =3D=3D 1)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       return ncp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return peer_info_extract_uint(pee=
r_info, &quot;IV_NCP=3D&quot;);</span><br><span> }</span><br><span> </span>=
<br><span> /**</span><br><span>diff --git a/src/openvpn/ssl_util=2Ec b/src/=
openvpn/ssl_util=2Ec</span><br><span>index 2f01f8a=2E=2Ee6af145 100644</spa=
n><br><span>--- a/src/openvpn/ssl_util=2Ec</span><br><span>+++ b/src/openvp=
n/ssl_util=2Ec</span><br><span>@@ -27,28 +27,55 @@</span><br><span> #includ=
e &quot;openvpn=2Eh&quot;</span><br><span> #include &quot;ssl_util=2Eh&quot=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ch=
ar *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-extract_var_peer_=
info(const char *peer_info, const char *var, struct gc_arena *gc)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Looks for the string field at the start of=
 peer_info or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * aft=
er any new line and returns a pointer to the start of the field</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * or NULL if not found=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static const char *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+peer_info_extract_varstr(const char *pee=
r_info, const char *field)</span><br><span> {</span><br><span>     if (!pee=
r_info)</span><br><span>     {</span><br><span>         return NULL;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    const char *var_start =3D strstr(peer_info, var);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    while (peer_info)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* peer info starts with this fi=
eld */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (s=
trncmp(peer_info, field, strlen(field)) =3D=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return peer_info;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* skip to the next line */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        peer_info =3D strchr(peer_info, &#39;\n&#39;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (peer_info)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            /* skip the &#39;\=
n&#39; itself */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         peer_info++;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+extract_var_peer_info(const char *peer_info, const char *var, struct gc_a=
rena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *var_start =
=3D peer_info_extract_varstr(peer_info, var);</span><br><span>     if (!var=
_start)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        /* variable not found in peer info */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* variable hasn&#39;t been foun=
d in peer info */</span><br><span>         return NULL;</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* skip over the variable name (includes the =3D as per API)*/</span>=
<br><span>     var_start +=3D strlen(var);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const char *var_end =3D strstr(var_start, &quot;\n=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!var_=
end)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /* var is at end of the p=
eer_info list and no &#39;\n&#39; follows */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        var_end =3D var_start + strlen(var_start);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* returns the location of the next &#39;\n&#39; or =
the end of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* string if the variable is already on the last line */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *var_end =3D strchrnul(v=
ar_start, &#39;\n&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> </span><br><span>     char *var_value =3D string_all=
oc(var_start, gc);</span><br><span>     /* NULL terminate the copy at the r=
ight position */</span><br><span>@@ -56,38 +83,40 @@</span><br><span>     r=
eturn var_value;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> unsigned int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-extract_iv_proto(const char *pee=
r_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+peer_info_ex=
tract_int(const char *peer_info, const char *field, const char *format, uns=
igned int default_value)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const char *optstr =3D peer_info ? strstr(peer_in=
fo, &quot;IV_PROTO=3D&quot;) : NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const char *optstr =3D peer_info_extract_varstr(peer_i=
nfo, field);</span><br><span>     if (optstr)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        int proto =3D 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        int r =3D sscanf(=
optstr, &quot;IV_PROTO=3D%d&quot;, &amp;proto);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (r =3D=3D 1 &amp;&amp; proto &gt; 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        optstr +=3D s=
trlen(field);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        int value =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int r =3D ss=
canf(optstr, format, &amp;value);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (r =3D=3D 1 &amp;&amp; value &gt;=3D 0)</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       return proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return value;</span><br><span>         }</span><br><span>     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return default_value;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+unsigned int</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+peer_info_extract_uint(const char *peer_info, const char *field)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return peer_info_extract_int(peer=
_info, field, &quot;%u&quot;, 0);</span><br><span> }</span><br><span> </spa=
n><br><span> uint32_t</span><br><span> extract_asymmetric_peer_id(const cha=
r *peer_info)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    for (const char *p =3D peer_info; p &amp;&amp; (p =3D strstr=
(p, &quot;ID=3D&quot;)); p +=3D 3)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint32_t peer_id =3D peer_info_extract_int(peer_info, &q=
uot;ID=3D&quot;, &quot;%x&quot;, MAX_PEER_ID);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (peer_id &lt; MAX_PEER_ID)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* on=
ly accept &quot;ID=3D&quot; at the start of a line, so it does not match</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-         * substrings li=
ke &quot;UV_ID=3D&quot; or &quot;GUID=3D&quot; */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (p =3D=3D peer_info || p[-1] =3D=3D =
&#39;\n&#39;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            uint32_t=
 peer_id =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      if (sscanf(p, &quot;ID=3D%x&quot;, &amp;peer_id) =3D=3D 1 &amp;&amp; =
peer_id &lt; MAX_PEER_ID)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            return peer_id;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn peer_id;</span><br><span>     }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     return MAX_PEER_ID;</span><br><span> }=
</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_util=2Eh b/=
src/openvpn/ssl_util=2Eh</span><br><span>index 1a69e6f=2E=2E751af85 100644<=
/span><br><span>--- a/src/openvpn/ssl_util=2Eh</span><br><span>+++ b/src/op=
envpn/ssl_util=2Eh</span><br><span>@@ -33,11 +33,31 @@</span><br><span> #in=
clude &quot;buffer=2Eh&quot;</span><br><span> </span><br><span> /**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Extracts the named integ=
er variable and returns its value or default_value</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * if it cannot be extracted=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param peer_info     peer info string to searc=
h in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param field=
          name of the field to be extracted</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+peer_info_extract_int(const char *peer_info, const char *field, const char=
 *format, unsigned int default_value);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Extracts the =
named integer variable and returns its value or 0</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * if it cannot be extracted=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param peer_info     peer info string to search=
 in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param field =
         name of the field to be extracted</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
peer_info_extract_uint(const char *peer_info, const char *field);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span>  * Extracts a variable from=
 peer info, the returned string will be allocated</span><br><span>  * using=
 the supplied gc_arena</span><br><span>  *</span><br><span>  * @param peer_=
info     The peer&#39;s peer_info</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * @param var           The variable *including* =3D, e=2Eg=2E =
IV_CIPHERS=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram var           The variable including =3D, e=2Eg=2E IV_CIPHERS=3D</span>=
<br><span>  * @param gc            GC arena to allocate return value in</sp=
an><br><span>  *</span><br><span>  * @return  The content of the variable a=
s NULL terminated string or NULL if the</span><br><span>@@ -51,8 +71,11 @@<=
/span><br><span>  *</span><br><span>  * @param peer_info     peer info stri=
ng to search for IV_PROTO</span><br><span>  */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-unsigned int extract_iv_proto(const char *peer_inf=
o);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static inline unsigned int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+extract_iv_proto(const char *p=
eer_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return peer_info_extract=
_uint(peer_info, &quot;IV_PROTO=3D&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> /**</span><br><=
span>  * Extracts the ID variable and returns its value or</span><br><span>=
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/open=
vpn/Makefile=2Eam</span><br><span>index d861ef9=2E=2E5ccf3ce 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b=
/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -395,7 +395,8 @@=
</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span=
> 	$(top_srcdir)/src/openvpn/options_util=2Ec \</span><br><span> 	$(top_src=
dir)/src/openvpn/otime=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	$(top_srcdir)/src/openvpn/list=2Ec</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/list=2Ec \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/ssl_uti=
l=2Ec</span><br><span> </span><br><span> socket_testdriver_CFLAGS  =3D \</s=
pan><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_=
srcdir)/src/openvpn \</span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=
=2Ec</span><br><span>index 219b476=2E=2E389fa09 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>+++ b/t=
ests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>@@ -188,12=
 +188,6 @@</span><br><span> {</span><br><span>     return true;</span><br><=
span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-unsigned int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-extract_iv_proto(const char *peer_info)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return IV_PROTO_PUSH_UPDATE;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span> #endif /* ifd=
ef ENABLE_MANAGEMENT */</span><br><span> </span><br><span> /* tests */</spa=
n><br><span>@@ -650,6 +644,7 @@</span><br><span>     m-&gt;instances =3D ca=
lloc(1, sizeof(struct multi_instance *));</span><br><span>     struct multi=
_instance *mi =3D calloc(1, sizeof(struct multi_instance));</span><br><span=
>     mi-&gt;context=2Ec2=2Etls_multi =3D calloc(1, sizeof(struct tls_multi=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;conte=
xt=2Ec2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4096&quot;;  // IV_P=
ROTO_PUSH_UPDATE</span><br><span>     *(m-&gt;instances) =3D mi;</span><br>=
<span>     m-&gt;top=2Eoptions=2Edisable_dco =3D true;</span><br><span>    =
 *state =3D m;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_s=
sl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index 0e9cec=
f=2E=2E03544ea 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_s=
sl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><b=
r><span>@@ -48,7 +48,9 @@</span><br><span> #include &quot;buffer=2Eh&quot;<=
/span><br><span> #include &quot;cert_data=2Eh&quot;</span><br><span> #inclu=
de &quot;packet_id=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot;=
ssl_verify=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;openvpn=2Eh&quot;</span><br><span> </span><br><span> /* Moc=
k function to be allowed to include win32=2Ec which is required for</span><=
br><span>  * getting the temp directory */</span><br><span>@@ -829,6 +831,6=
8 @@</span><br><span>     free_certificate(cert);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_test_extract_peer_i=
nfo(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *peer=
_info_normal =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     &quot;IV_VER=3D2=2E6_git\nIV_PLAT=3Dmac\nIV_TCPNL=3D1\nIV_NCP=3D2\n&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;IV=
_CIPHERS=3DAES-256-GCM:AES-128-GCM:CHACHA20-POLY1305\n&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        &quot;IV_PROTO=3D94\nIV_LZ=
O_STUB=3D1\nIV_COMP_STUB=3D1\nP=3D78\nIV_COMP_STUBv2=3D1\n&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        &quot;IV_SSL=3DOpenSSL=
_3=2E0=2E5_5_Jul_2022\nIV_LZ4v2=3D1&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *empty =3D &quot;&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const char *invalid_proto =3D &quot;IV_PROTO=3D=
seven\nIV_SSL=3D7\nP=3D300\nID=3Dxyz&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const char *test_prefix =3D &quot;UV_IV_PROTO=
=3D773\nNP=3D112\nPD=3D8\n&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ext=
ract_iv_proto(peer_info_normal), 94);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(extract_iv_proto(empty), 0);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(extrac=
t_iv_proto(invalid_proto), 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* This should not pick up the UV_IV_PROTO that has the extr=
a prefix */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(extract_iv_proto(test_prefix), 0);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(peer_info_extract_uint(peer_info_normal, &quo=
t;IV_COMP_STUB=3D&quot;), 1);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(peer_info_extract_int(empty, &quot;IV_COMP_S=
TUB=3D&quot;, &quot;%d&quot;, 0xfe0d0d), 0xfe0d0d);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(peer_info_extract_ui=
nt(invalid_proto, &quot;IV_COMP_STUB=3D&quot;), 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(peer_info_extract_int(test_prefix, &quo=
t;NP=3D&quot;, &quot;%d&quot;, 23), 112);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(peer_info_extract_uint(test_pref=
ix, &quot;PD=3D&quot;), 8);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(peer_info_extract_int(test_prefix, &quot;P=3D&=
quot;, &quot;%x&quot;, 0xfe0d0d), 0xfe0d0d);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(peer_info_extract_uint(peer_i=
nfo_normal, &quot;P=3D&quot;), 78);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(peer_info_extract_uint(test_prefix, &q=
uot;UV_IV_PROTO=3D&quot;), 773);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *peer_ciphers =3D extract_var_peer_info(peer_info_normal, &quot;IV_C=
IPHERS=3D&quot;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_string_equal(peer_ciphers, &quot;AES-256-GCM:AES-128-GCM:=
CHACHA20-POLY1305&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* with t=
he extra =3D this should not extract anything */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *proto =3D extract_var_peer_inf=
o(peer_info_normal, &quot;IV_PROTO=3D=3D&quot;, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_null(proto);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    proto =3D extract_var_peer_info(peer_info_normal=
, &quot;IV_PROTO=3D&quot;, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(proto, &quot;94&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *double_eq_info =3D &quot;FOO=3D7\nFOO=3D=3Dnew&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *fo=
o_eq =3D extract_var_peer_info(double_eq_info, &quot;FOO=3D&quot;, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *fo=
o =3D extract_var_peer_info(double_eq_info, &quot;FOO&quot;, &amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *foo_2eq =
=3D extract_var_peer_info(double_eq_info, &quot;FOO=3D=3D&quot;, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(foo, &quot;=3D7=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(foo_eq, &quot;7&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(foo_2eq, &quot;new&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(extract_asymmetric_peer_i=
d(double_eq_info), MAX_PEER_ID);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(extract_asymmetric_peer_id(peer_info_norm=
al), MAX_PEER_ID);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(extract_asymmetric_peer_id(invalid_proto), MAX_PEER_ID)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(extract_asymmetric_peer_id(&quot;ID=3Df7&quot;), 0xf7);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(extract_asymmet=
ric_peer_id(&quot;X=3Dfoo\nID=3D12ab&quot;), 0x12ab);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(extract_asymmetric_p=
eer_id(&quot;X=3Dfoo\nID=3D34dd\nY=3Dbar&quot;), 0x34dd);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(extract_asymmetr=
ic_peer_id(&quot;X=3Dfoo\nID=3D12345678&quot;), MAX_PEER_ID);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> int</span><br=
><span> main(void)</span><br><span>@@ -853,7 +917,8 @@</span><br><span>    =
     cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),</span><br><span>=
         cmocka_unit_test(test_data_channel_known_vectors_epoch),</span><br=
><span>         cmocka_unit_test(test_data_channel_known_vectors_shortpktid=
),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit=
_test(crypto_test_print_cert_details)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(crypto_test_print_cert_details),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit=
_test(ssl_test_extract_peer_info)</span><br><span> </span><br><span>     };=
</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3Demail">change 18=
00</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1800 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--aLzJ71xI2QA=--


--===============7852759959491906420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7852759959491906420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7852759959491906420==--

