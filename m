Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B72CD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bOxEfXDctF+7msFwYPYYja8RYju07gauHFsXircW6KU=; b=CGHoP56DJhYrCZ5FKUJKs/p7QA
	WbTNAJvD5gyb7dmI/7nWX927zKPJzyCleDNgwd4kOK4VeRVgCKnPtQc8rIEyhbMvzlNkKA1BzNkbh
	eGUr69hiuJQvlKmNlzwMhfNT0vSb9AplZKjcfi/OwqX8XzmZYC0Yzo8YdGKbeYWYAEE0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgl4-0002Xw-U8;
	Mon, 22 Jun 2026 15:40:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgl2-0002Xo-RW
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:40:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=o7fhW08MWxaQ41TBgOFh1PL0Qw7b9BsBElWTmVZClBU=; b=FzwWnRlXG2jns6UliQBCk0YeOl
 a0t5EnIj0TFZJZOQGWwrvFcuyeDRgfxg3kb87+lT92cYaeemhtaqQS8WcI5Nu7YmxIHgGrA+hRIdD
 5vr900ajkeYdJTRBA7AfshePGNYb46WAdNqfILSO+JobcB8/yxE9MLf5G8D8oG6vGfgw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=o7fhW08MWxaQ41TBgOFh1PL0Qw7b9BsBElWTmVZClBU=; b=U
 YIefrodq6gZUBbvFi0Rt4Rpf/Sn1cNGz4O0VHiVV+c8B0BzR11LTv+FEUqgZuZ98oOlBFB9VM+e1B
 QTy7CofTtbGMgMzBuWEk0XapLvPLfmAIHx8TXwmxhtsbs0YP7u2kVDhp6K60bEKya/VEBCSECwcJU
 B+/vJc6OX0vVF49M=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgkw-0008Fc-Ue for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:40:18 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-45ef779c1c2so3527090f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782142804; x=1782747604; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o7fhW08MWxaQ41TBgOFh1PL0Qw7b9BsBElWTmVZClBU=;
 b=dP8lGtYYiAgvUK8NOx7UHqTiy4tnWsEc5QXMRADX954rwSRd/mprcWLhiJU+fMpLft
 dp0vlG2GOY2ZTrOb5rxi9WnqKPZQIrx50dwLqVcYb+PPuwpSUvQ2MiWn9byBplircKgb
 rqf0UybqiQUAn8cAljSewVtIE3ey2xh248rDHdkbxKOXMCSogrHZBmsLT3nlrriNXghq
 36uhZaSOO+EWxaJ3hCS0Lq1o47d6URmwA41eGanZKli7peIN71o4gQxFhBVDNyuRQ5vH
 e73oiAL+hhEQCtUZNnsSwUsVfsqCd9ykum9dLSFp2W6HWTDjkDmD4Xfti4OBWzvh7pPh
 nXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142804; x=1782747604;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o7fhW08MWxaQ41TBgOFh1PL0Qw7b9BsBElWTmVZClBU=;
 b=DFiGgLrl95IIeyzmWHxUqffwv3luIv+4byAIUuftD7sQrPnNM+bgT46z3gqBwZrHcz
 pKWD7VjNzWY4BwrkLyLqsI5yPjsSxuF7pJA1kPZHvMCC3WGZ5r6QNSagV11sjqcbcs6j
 OfuOzU2C859GSRVyDGNWLv7yhV0Y+MSY40SUoeQoqs7sY45kVmy9S227duPeJ+03PNf0
 vK2GQoy3JvOB+exIHiEkPg9Jhr8oEKqreDtgvj0Jl/Mq+gs4IuNPPygXn+Bq9DLSN1sp
 5eKRpkuGW4Vdd5yBw1UtVCLJUEi4NnbZftnmyqrltdoRz2Ec02r2vmtzaCxRbUsfPsFN
 6/GQ==
X-Gm-Message-State: AOJu0YxQdxSG4AtcwtdepxIENVDVzXBCcX/votGTG1S95z4A8wCYK+kR
 qpP+tnliEwzElQPlxSBHep3vPgOs7/tWduYaBYFDq4/zMPWtVfZ2qvSkQliO075i1itvKN9rfdV
 vuwE3HRnoRHDeymePV8ZGY8oQ25dPgS0bHO5twGYE3G9SvfL8w0Lfd/PBKuL0cgTH0RHQRGVF6v
 QhMU76fA==
X-Gm-Gg: AfdE7cmeiPic5gf7IOGwyAOdLzeKBElbV7TYLj8+Y2l+XpnhrmJWpN9sfCh0qfL4Iu3
 FWsp6rjhQO80R9xUVQCRIJRixwkaCeg74sgps51lBQI4afhjzrHzsRV2YGKmztcA1tq55J5Tmtj
 3AaTTkhj9WlUxv45/Iy8NkA2b2/UI3PANVCB11H+v1AVfjvg4w/Cu+WhYfpWBQCtj7+8rF8njGr
 ibNN3t4lQD7uOA2I4wdbVFzc47bPiYfk7h5YLCrYrr6Pgd4I+91+JnzQ45AVrojj8QwqIXfj+2k
 N5+b/7xBc5bkFnPROfZL8mx6eP/Xh7pYA4Kow4TDAMoKgUBIAvnGLNCxjrdGRDwum8Ht0BXc6g0
 fQhNpnHqpPH++MwJCfmFvbP1FpO6390Zl803yvNwnxQp7EhmcLD+xtt44G70RHhMFfQ+a+zCHqP
 8luCHzxtqnHDfqPletZ+VDh7YtFlgkNXH1vKUFlWtMlSpdPPSCbbMp19Zo2bT3AU4jcXgRkJ9OH
 vxb/zddaKuBSPaxUfZVbFBPtjRlBeRXlqTgH/JPk4b2c/vMIsJli4l+VB2v8zRdSmL66HdLDSvc
 Ttg=
X-Received: by 2002:a5d:5846:0:b0:461:a169:f965 with SMTP id
 ffacd0b85a97d-465091bc7b6mr29352011f8f.34.1782142802618; 
 Mon, 22 Jun 2026 08:40:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4ee6sm26239168f8f.5.2026.06.22.08.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:40:02 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:40:00 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 8308e2cf037d771e82d12eeb570c1d3b2670a8e8
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <60e8ff33bab327d673c62989e56c1c32e477eac9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgkw-0008Fc-Ue
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 dynamically allocated ctx
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4144757829423320976=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4144757829423320976==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t7/wVzNdgCc="; charset=UTF-8

--t7/wVzNdgCc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail

to look at the new pa=
tch set (#8)=2E

The following approvals got outdated and were removed:
Cod=
e-Review-1 by flichtenheld


Change subject: Change hash iv to a dynamicall=
y allocated ctx
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Change hash iv to a dynamically allocated ctx

While for our own hash =
function, always using an uint32_t works well, it does
not work very well i=
f we move to another hash function=2E Move the context of
a hardcoded uint3=
2_t iv to a void pointer to a real ctx=2E

Change-Id: If47c7d920b2fa4047b7d=
b03fcde821899839324d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M=
 src/openvpn/list=2Ec
M src/openvpn/list=2Eh
M src/openvpn/mroute=2Ec
M src=
/openvpn/mroute=2Eh
M src/openvpn/multi=2Ec
M tests/unit_tests/openvpn/test=
_misc=2Ec
6 files changed, 45 insertions(+), 23 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1571/8

diff --gi=
t a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index c07e764=2E=2E36d8ede =
100644
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -29,13 +29,=
16 @@
 
 #include "integer=2Eh"
 #include "list=2Eh"
+
+#include "crypto=2E=
h"
 #include "misc=2Eh"
 
 #include "memdbg=2Eh"
 
 struct hash *
-hash_ini=
t(const uint32_t n_buckets, const uint32_t iv,
-          uint64_t (*hash_f=
unction)(const void *key, uint32_t iv),
+hash_init(const uint32_t n_buckets=
, void *ctx,
+          void (*free_hash_ctx)(void *ctx),
+          uint64=
_t (*hash_function)(const void *key, void *ctx),
           bool (*compare_=
function)(const void *key1, const void *key2))
 {
     struct hash *h;
@@ -=
46,7 +49,8 @@
     h->mask =3D h->n_buckets - 1;
     h->hash_function =3D =
hash_function;
     h->compare_function =3D compare_function;
-    h->iv =
=3D iv;
+    h->free_ctx =3D free_hash_ctx;
+    h->ctx =3D ctx;
     ALLOC=
_ARRAY(h->buckets, struct hash_bucket, h->n_buckets);
     for (uint32_t i =
=3D 0; i < h->n_buckets; ++i)
     {
@@ -71,6 +75,7 @@
             he =3D =
next;
         }
     }
+    hash->free_ctx(hash->ctx);
     free(hash->buc=
kets);
     free(hash);
 }
@@ -412,6 +417,14 @@
         c ^=3D (b >> 15); =
\
     }
 
+void *
+hash_func_new_ctx(void)
+{
+    uint32_t *ctx =3D mallo=
c(sizeof(uint32_t));
+    *ctx =3D (uint32_t)get_random();
+    return ctx;=

+}
+
 uint64_t
 hash_func(const uint8_t *k, uint32_t length, uint32_t init=
val)
 {
diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh
index 0637=
7c6=2E=2Eea6f47a 100644
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn/list=
=2Eh
@@ -54,14 +54,17 @@
     uint32_t n_buckets;
     uint32_t n_elements;=

     uint32_t mask;
-    uint32_t iv;
-    uint64_t (*hash_function)(const=
 void *key, uint32_t iv);
+    void *ctx;
+    uint64_t (*hash_function)(co=
nst void *key, void *ctx);
     bool (*compare_function)(const void *key1, =
const void *key2); /* return true if equal */
+    void (*free_ctx)(void *c=
tx);
+    void *free_ctx_arg;
     struct hash_bucket *buckets;
 };
 
-stru=
ct hash *hash_init(const uint32_t n_buckets, const uint32_t iv,
-          =
             uint64_t (*hash_function)(const void *key, uint32_t iv),
+stru=
ct hash *hash_init(const uint32_t n_buckets, void *ctx,
+                  =
     void (*free_hash_ctx)(void *ctx),
+                       uint64_t (*h=
ash_function)(const void *key, void *ctx),
                        bool (*c=
ompare_function)(const void *key1, const void *key2));
 
 void hash_free(st=
ruct hash *hash);
@@ -100,10 +103,12 @@
 
 uint64_t hash_func(const uint8_t=
 *k, uint32_t length, uint32_t initval);
 
+void *hash_func_new_ctx(void);
=
+
 static inline uint64_t
 hash_value(const struct hash *hash, const void *=
key)
 {
-    return (*hash->hash_function)(key, hash->iv);
+    return (*ha=
sh->hash_function)(key, hash->ctx);
 }
 
 static inline uint32_t
diff --git=
 a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index 78c689e=2E=2E89b3e=
cc 100644
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -355=
,10 +355,11 @@
  * and the actual address=2E
  */
 uint64_t
-mroute_addr_ha=
sh_function(const void *key, uint32_t iv)
+mroute_addr_hash_function(const =
void *key, void *ctx)
 {
+    uint32_t *iv =3D ctx;
     return hash_func(m=
route_addr_hash_ptr((const struct mroute_addr *)key),
-                    =
 mroute_addr_hash_len((const struct mroute_addr *)key), iv);
+             =
        mroute_addr_hash_len((const struct mroute_addr *)key), *iv);
 }
 
 =
bool
diff --git a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh
index 2f5=
d019=2E=2E51b62d2 100644
--- a/src/openvpn/mroute=2Eh
+++ b/src/openvpn/mro=
ute=2Eh
@@ -144,7 +144,7 @@
 
 bool mroute_learnable_address(const struct m=
route_addr *addr, struct gc_arena *gc);
 
-uint64_t mroute_addr_hash_functi=
on(const void *key, uint32_t iv);
+uint64_t mroute_addr_hash_function(const=
 void *key, void *ctx);
 
 bool mroute_addr_compare_function(const void *ke=
y1, const void *key2);
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/m=
ulti=2Ec
index e1c9c80=2E=2E8052100 100644
--- a/src/openvpn/multi=2Ec
+++ =
b/src/openvpn/multi=2Ec
@@ -229,7 +229,7 @@
 #ifdef ENABLE_MANAGEMENT
 
 st=
atic uint64_t
-cid_hash_function(const void *key, uint32_t iv)
+cid_hash_fu=
nction(const void *key, void *ctx)
 {
     const unsigned long *k =3D (cons=
t unsigned long *)key;
     return (uint64_t)*k;
@@ -250,7 +250,7 @@
 /*
  =
* inotify watcher descriptors are used as hash value
  */
-int_hash_functio=
n(const void *key, uint32_t iv)
+int_hash_function(const void *key, void *c=
tx)
 {
     return (uintptr_t)key;
 }
@@ -290,27 +290,30 @@
      * to dete=
rmine which client sent an incoming packet
      * which is seen on the TCP=
/UDP socket=2E
      */
-    m->hash =3D hash_init(t->options=2Ereal_hash_s=
ize, (uint32_t)get_random(),
+    m->hash =3D hash_init(t->options=2Ereal_h=
ash_size, hash_func_new_ctx(), free,
                         mroute_addr_h=
ash_function, mroute_addr_compare_function);
 
     /*
      * Virtual addr=
ess hash table=2E  Used to determine
      * which client to route a packet=
 to=2E
      */
-    m->vhash =3D hash_init(t->options=2Evirtual_hash_size,=
 (uint32_t)get_random(),
+    m->vhash =3D hash_init(t->options=2Evirtual_h=
ash_size, hash_func_new_ctx(), free,
                          mroute_addr_=
hash_function, mroute_addr_compare_function);
 
 #ifdef ENABLE_MANAGEMENT
-=
    m->cid_hash =3D hash_init(t->options=2Ereal_hash_size, 0, cid_hash_func=
tion, cid_compare_function);
+    m->cid_hash =3D hash_init(t->options=2Ere=
al_hash_size, NULL, free, cid_hash_function, cid_compare_function);
 #endif=

 
 #ifdef ENABLE_ASYNC_PUSH
     /*
      * Mapping between inotify watch =
descriptors and
      * multi_instances=2E
+     *
+     * Note we use a cu=
stom hash function here so we use dummy
+     * value and function for the =
context parameters=2E
      */
-    m->inotify_watchers =3D hash_init(t->op=
tions=2Ereal_hash_size, (uint32_t)get_random(),
-                          =
          int_hash_function, int_compare_function);
+    m->inotify_watcher=
s =3D
+        hash_init(t->options=2Ereal_hash_size, NULL, free, int_hash_=
function, int_compare_function);
 #endif
 
     /*
diff --git a/tests/unit_=
tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index =
ccdfdee=2E=2E24bf22d 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
++=
+ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -125,11 +125,12 @@
 
 
 stati=
c uint64_t
-word_hash_function(const void *key, uint32_t iv)
+word_hash_fun=
ction(const void *key, void *ctx)
 {
+    uint32_t *iv =3D (uint32_t *)ctx;=

     const char *str =3D (const char *)key;
     const uint32_t len =3D (u=
int32_t)strlen(str);
-    return hash_func((const uint8_t *)str, len, iv);
=
+    return hash_func((const uint8_t *)str, len, *iv);
 }
 
 static bool
@@=
 -171,10 +172,9 @@
      * Test the hash code by implementing a simple
    =
  * word frequency algorithm=2E
      */
-
     struct gc_arena gc =3D gc_n=
ew();
-    struct hash *hash =3D hash_init(10000, get_random(), word_hash_f=
unction, word_compare_function);
-    struct hash *nhash =3D hash_init(256,=
 get_random(), word_hash_function, word_compare_function);
+    struct hash=
 *hash =3D hash_init(10000, hash_func_new_ctx(), free, word_hash_function, =
word_compare_function);
+    struct hash *nhash =3D hash_init(256, hash_fun=
c_new_ctx(), free, word_hash_function, word_compare_function);
 
     print=
f("hash_init n_buckets=3D%u mask=3D0x%08x\n", hash->n_buckets, hash->mask);=

 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If47c7d920b2=
fa4047b7db03fcde821899839324d
Gerrit-Change-Number: 1571
Gerrit-PatchSet: 8=

Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--t7/wVzNdgCc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #8</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>Th=
e following approvals got outdated and were removed:
Code-Review-1 by flich=
tenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">Change hash iv to a dynamically allocated ctx<br><=
br>While for our own hash function, always using an uint32_t works well, it=
 does<br>not work very well if we move to another hash function=2E Move the=
 context of<br>a hardcoded uint32_t iv to a void pointer to a real ctx=2E<b=
r><br>Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d<br>Signed-off-by=
: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/list=2Ec<=
br>M src/openvpn/list=2Eh<br>M src/openvpn/mroute=2Ec<br>M src/openvpn/mrou=
te=2Eh<br>M src/openvpn/multi=2Ec<br>M tests/unit_tests/openvpn/test_misc=
=2Ec<br>6 files changed, 45 insertions(+), 23 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/71/1571/8</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec=
</span><br><span>index c07e764=2E=2E36d8ede 100644</span><br><span>--- a/sr=
c/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</span><br><sp=
an>@@ -29,13 +29,16 @@</span><br><span> </span><br><span> #include &quot;in=
teger=2Eh&quot;</span><br><span> #include &quot;list=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><br><span> #i=
nclude &quot;misc=2Eh&quot;</span><br><span> </span><br><span> #include &qu=
ot;memdbg=2Eh&quot;</span><br><span> </span><br><span> struct hash *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-hash_init(const uint32_t n_b=
uckets, const uint32_t iv,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-          uint64_t (*hash_function)(const void *key, uint32_t iv),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_init(const uint32_=
t n_buckets, void *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+          void (*free_hash_ctx)(void *ctx),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+          uint64_t (*hash_function)(const void =
*key, void *ctx),</span><br><span>           bool (*compare_function)(const=
 void *key1, const void *key2))</span><br><span> {</span><br><span>     str=
uct hash *h;</span><br><span>@@ -46,7 +49,8 @@</span><br><span>     h-&gt;m=
ask =3D h-&gt;n_buckets - 1;</span><br><span>     h-&gt;hash_function =3D h=
ash_function;</span><br><span>     h-&gt;compare_function =3D compare_funct=
ion;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    h-&gt;iv =3D =
iv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    h-&gt;free_c=
tx =3D free_hash_ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    h-&gt;ctx =3D ctx;</span><br><span>     ALLOC_ARRAY(h-&gt;buckets, st=
ruct hash_bucket, h-&gt;n_buckets);</span><br><span>     for (uint32_t i =
=3D 0; i &lt; h-&gt;n_buckets; ++i)</span><br><span>     {</span><br><span>=
@@ -71,6 +75,7 @@</span><br><span>             he =3D next;</span><br><span=
>         }</span><br><span>     }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    hash-&gt;free_ctx(hash-&gt;ctx);</span><br><span>     fr=
ee(hash-&gt;buckets);</span><br><span>     free(hash);</span><br><span> }</=
span><br><span>@@ -412,6 +417,14 @@</span><br><span>         c ^=3D (b &gt;=
&gt; 15); \</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+hash_func_new_ctx(void)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint32_t *ctx =3D malloc(sizeof(uint32_t));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    *ctx =3D (uint32_t)get_random();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ctx;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> uint64_t</span><br><span> h=
ash_func(const uint8_t *k, uint32_t length, uint32_t initval)</span><br><sp=
an> {</span><br><span>diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=
=2Eh</span><br><span>index 06377c6=2E=2Eea6f47a 100644</span><br><span>--- =
a/src/openvpn/list=2Eh</span><br><span>+++ b/src/openvpn/list=2Eh</span><br=
><span>@@ -54,14 +54,17 @@</span><br><span>     uint32_t n_buckets;</span><=
br><span>     uint32_t n_elements;</span><br><span>     uint32_t mask;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t iv;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    uint64_t (*hash_function)(c=
onst void *key, uint32_t iv);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    void *ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    uint64_t (*hash_function)(const void *key, void *ctx);</span><br><=
span>     bool (*compare_function)(const void *key1, const void *key2); /* =
return true if equal */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    void (*free_ctx)(void *ctx);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    void *free_ctx_arg;</span><br><span>     struct hash_b=
ucket *buckets;</span><br><span> };</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-struct hash *hash_init(const uint32_t n_buc=
kets, const uint32_t iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                       uint64_t (*hash_function)(const void *key, uint32=
_t iv),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct hash =
*hash_init(const uint32_t n_buckets, void *ctx,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                       void (*free_hash_ctx)(vo=
id *ctx),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
             uint64_t (*hash_function)(const void *key, void *ctx),</span><=
br><span>                        bool (*compare_function)(const void *key1,=
 const void *key2));</span><br><span> </span><br><span> void hash_free(stru=
ct hash *hash);</span><br><span>@@ -100,10 +103,12 @@</span><br><span> </sp=
an><br><span> uint64_t hash_func(const uint8_t *k, uint32_t length, uint32_=
t initval);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void *hash_func_new_ctx(void);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static inline uint64_t</span><br><sp=
an> hash_value(const struct hash *hash, const void *key)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (*hash-&gt=
;hash_function)(key, hash-&gt;iv);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return (*hash-&gt;hash_function)(key, hash-&gt;ctx);</sp=
an><br><span> }</span><br><span> </span><br><span> static inline uint32_t</=
span><br><span>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec=
</span><br><span>index 78c689e=2E=2E89b3ecc 100644</span><br><span>--- a/sr=
c/openvpn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</span><br=
><span>@@ -355,10 +355,11 @@</span><br><span>  * and the actual address=2E<=
/span><br><span>  */</span><br><span> uint64_t</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-mroute_addr_hash_function(const void *key, uint32_=
t iv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mroute_addr_ha=
sh_function(const void *key, void *ctx)</span><br><span> {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    uint32_t *iv =3D ctx;</span><br>=
<span>     return hash_func(mroute_addr_hash_ptr((const struct mroute_addr =
*)key),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
       mroute_addr_hash_len((const struct mroute_addr *)key), iv);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                     mroute_=
addr_hash_len((const struct mroute_addr *)key), *iv);</span><br><span> }</s=
pan><br><span> </span><br><span> bool</span><br><span>diff --git a/src/open=
vpn/mroute=2Eh b/src/openvpn/mroute=2Eh</span><br><span>index 2f5d019=2E=2E=
51b62d2 100644</span><br><span>--- a/src/openvpn/mroute=2Eh</span><br><span=
>+++ b/src/openvpn/mroute=2Eh</span><br><span>@@ -144,7 +144,7 @@</span><br=
><span> </span><br><span> bool mroute_learnable_address(const struct mroute=
_addr *addr, struct gc_arena *gc);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-uint64_t mroute_addr_hash_function(const vo=
id *key, uint32_t iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+uint64_t mroute_addr_hash_function(const void *key, void *ctx);</span><b=
r><span> </span><br><span> bool mroute_addr_compare_function(const void *ke=
y1, const void *key2);</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e1c9c80=2E=
=2E8052100 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><sp=
an>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -229,7 +229,7 @@</span><b=
r><span> #ifdef ENABLE_MANAGEMENT</span><br><span> </span><br><span> static=
 uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cid_hash_fun=
ction(const void *key, uint32_t iv)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+cid_hash_function(const void *key, void *ctx)</span><br><sp=
an> {</span><br><span>     const unsigned long *k =3D (const unsigned long =
*)key;</span><br><span>     return (uint64_t)*k;</span><br><span>@@ -250,7 =
+250,7 @@</span><br><span> /*</span><br><span>  * inotify watcher descripto=
rs are used as hash value</span><br><span>  */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-int_hash_function(const void *key, uint32_t iv)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+int_hash_function(cons=
t void *key, void *ctx)</span><br><span> {</span><br><span>     return (uin=
tptr_t)key;</span><br><span> }</span><br><span>@@ -290,27 +290,30 @@</span>=
<br><span>      * to determine which client sent an incoming packet</span><=
br><span>      * which is seen on the TCP/UDP socket=2E</span><br><span>   =
   */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;hash =
=3D hash_init(t-&gt;options=2Ereal_hash_size, (uint32_t)get_random(),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;hash =3D hash_i=
nit(t-&gt;options=2Ereal_hash_size, hash_func_new_ctx(), free,</span><br><s=
pan>                         mroute_addr_hash_function, mroute_addr_compare=
_function);</span><br><span> </span><br><span>     /*</span><br><span>     =
 * Virtual address hash table=2E  Used to determine</span><br><span>      *=
 which client to route a packet to=2E</span><br><span>      */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;vhash =3D hash_init(t-&g=
t;options=2Evirtual_hash_size, (uint32_t)get_random(),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    m-&gt;vhash =3D hash_init(t-&gt;opti=
ons=2Evirtual_hash_size, hash_func_new_ctx(), free,</span><br><span>       =
                   mroute_addr_hash_function, mroute_addr_compare_function)=
;</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;cid_hash =3D hash_init(t-=
&gt;options=2Ereal_hash_size, 0, cid_hash_function, cid_compare_function);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;cid_hash =
=3D hash_init(t-&gt;options=2Ereal_hash_size, NULL, free, cid_hash_function=
, cid_compare_function);</span><br><span> #endif</span><br><span> </span><b=
r><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>     /*</span><br><span> =
     * Mapping between inotify watch descriptors and</span><br><span>      =
* multi_instances=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Note =
we use a custom hash function here so we use dummy</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * value and function for the context pa=
rameters=2E</span><br><span>      */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    m-&gt;inotify_watchers =3D hash_init(t-&gt;options=2Erea=
l_hash_size, (uint32_t)get_random(),</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                    int_hash_function, int_c=
ompare_function);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  m-&gt;inotify_watchers =3D</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        hash_init(t-&gt;options=2Ereal_hash_size, NULL, free, int_=
hash_function, int_compare_function);</span><br><span> #endif</span><br><sp=
an> </span><br><span>     /*</span><br><span>diff --git a/tests/unit_tests/=
openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><s=
pan>index ccdfdee=2E=2E24bf22d 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test=
_misc=2Ec</span><br><span>@@ -125,11 +125,12 @@</span><br><span> </span><br=
><span> </span><br><span> static uint64_t</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-word_hash_function(const void *key, uint32_t iv)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+word_hash_function(const v=
oid *key, void *ctx)</span><br><span> {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    uint32_t *iv =3D (uint32_t *)ctx;</span><br><span> =
    const char *str =3D (const char *)key;</span><br><span>     const uint3=
2_t len =3D (uint32_t)strlen(str);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return hash_func((const uint8_t *)str, len, iv);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return hash_func((const u=
int8_t *)str, len, *iv);</span><br><span> }</span><br><span> </span><br><sp=
an> static bool</span><br><span>@@ -171,10 +172,9 @@</span><br><span>      =
* Test the hash code by implementing a simple</span><br><span>      * word =
frequency algorithm=2E</span><br><span>      */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>     struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash =
*hash =3D hash_init(10000, get_random(), word_hash_function, word_compare_f=
unction);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct h=
ash *nhash =3D hash_init(256, get_random(), word_hash_function, word_compar=
e_function);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct hash *hash =3D hash_init(10000, hash_func_new_ctx(), free, word_hash_fu=
nction, word_compare_function);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct hash *nhash =3D hash_init(256, hash_func_new_ctx(), =
free, word_hash_function, word_compare_function);</span><br><span> </span><=
br><span>     printf(&quot;hash_init n_buckets=3D%u mask=3D0x%08x\n&quot;, =
hash-&gt;n_buckets, hash-&gt;mask);</span><br><span> </span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1571?usp=3Demail">change 1571</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde8218998=
39324d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1571 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>

</body></html>
--t7/wVzNdgCc=--


--===============4144757829423320976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4144757829423320976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4144757829423320976==--

