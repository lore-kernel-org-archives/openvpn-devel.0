Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D40C531C9
	for <openvpn-devel@archiver.kernel.org>; Sat, 25 Jul 2026 15:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=42L35zBt4gdm2zelpmc7Pmi5xmeO2uMkjVO5fXs3iBw=; b=BpjJEnYVmbD8t6l2Li1+EiAAYG
	RO0Ma3QBj8AwHmzfiB8b13pFES8zy9Dre/HNAOm9B6BUE735WFX7bZVbBByDCUbaxTFftATPH5pxK
	ESrzTNjiDzMqXHILANobfHMLSGvD5qcGORInNlsmKV9lzssOpd/v7L7KpJq5XAE2IHwQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wne4r-0004s6-OF;
	Sat, 25 Jul 2026 15:14:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wne4q-0004s0-CK
 for openvpn-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 15:14:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ihWbyyouS7F+xQ9J1qJBWHwEM8JHVyRpfe84JNyO1YA=; b=D3dlW/8ACdSvrupcHZh1OUQI1f
 8T4tE6AUKpvY0U54Y79AVEQ6KBD0qWEuayBB9Nw78e9pz8pjBROq3hRsSZ1LLMbYuUtAShF8p3IWq
 QqCXQ6Nee0ziiod6NyYS1LWZUIB8+zC+VLkhYGq3VEseIiKHiueW2s3VGbDRUuB/UsZs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ihWbyyouS7F+xQ9J1qJBWHwEM8JHVyRpfe84JNyO1YA=; b=h
 1q+5VT0E9vF3DyRAPCIxouYBQ06wcLHgqpvDLvurAdaBEsitvWbfvUsPlf0SDGF9vRmhTTUfGqRhZ
 N+m0X4azHZ4jAlD+lPWPtkhhRpwnqq/7i+GB7wX30hBy6ii6Y4Grp/E6J2cn/tqAtL3hpDRIEQ9jO
 ju8YMQyNHGbOlrDA=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wne4r-0007Wd-Gc for openvpn-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 15:14:12 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so828319f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784992443; x=1785597243; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ihWbyyouS7F+xQ9J1qJBWHwEM8JHVyRpfe84JNyO1YA=;
 b=CR2mXClFyUhtZmBNL+AYLqRlnMLp0ZfZKIGg2Ub0BA/9teoNzqCgIvoU+LIrIz5v5E
 K7TIJd17xHd3FXBRWN2QqZ+IM397MXrEObBeEOLsYYpgKFeVei1IuobXgBrjjsJ3i4Qx
 ufYqBzv/x0j7dszuClNZ8R40cIwYkBPjvVMfIKi6SskWX4kbK66NAzP1QMJSFyy/Wl0Q
 nI6qWnDhmjHV06VPBUWIhMxmRXYfCg06VFxXcObyeqAKBFxkNw8fzkbihGAlqjPZCJT7
 drW9MrOinXOJjjpdBpfWuvYvMyddHxq8f47HFgi1LODopJiSgWPU6d4HzQycRsOI2w9J
 mQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784992443; x=1785597243;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ihWbyyouS7F+xQ9J1qJBWHwEM8JHVyRpfe84JNyO1YA=;
 b=EVR3HuorbGMoSuzcLo9esuPvCWcbJrIZcXlvcJCbiy5tqz/qJIiYgXTytJgHuPpP+y
 fu722FaqnbIvIM8QMJoRsiA3SqHObm1u5J2V8eY18t+Yl9ayLnlxCci3WaFMMlMLW/AN
 4XoiO4GvGgkp1R5RyZyL1j0r71dgFrWcHiPt4QJFic0BaCZNUmgNlLFZCaIKaoA3C2q1
 veMeItHRMF+cW7CkgiR1y0N/nAUmPkPTrkWOtrkRKNanialcEjOaLURgghySnNu6mbux
 RxfNGV+v/fr36zUIWLcMikjsSMNGJx13BFcSToaN7yepWH3/gOvwZZ1VcWhPXfErQSu7
 mhGg==
X-Gm-Message-State: AOJu0YyFnVG0iq1lIT24Suz9FrRc3uwoVbXqCCAojJG3NLLD3xYTiCsb
 ogMpPpAZt/IheAjUUch/uRwf3iJiCgAJOeLPm597bTwRO7/UnfVvBdqDy8Kf33qztQYukJmZoEG
 7KJbCIkn8m/fJiGmG15twnrYci8HCxGRDaYLjxxkOFAfzfcQVCCEJFxgd/ne5hyiAir4rGb+rrY
 w6KL6D9A==
X-Gm-Gg: AR+sD12UiktjfNxVLgO6LUwGOmkOM/HXo9GFYb04mNKVTy8+nv15OUQjhjwe+rdAtGI
 U8BV0Wr18ZNG6hl957pzHaN4ggZL7qQJ5ENGMjLVdI50bo7CNeFVGbhoTuySkjvc7lblTU0OFdy
 T9ugZEmysmXpHbA0CW/IAgY7sDbeMOglEl0mRCwO86Qdd5oYtU5BDUmNPEKSyKdTPh6aGBNXKtO
 RSkEVMsRo2m+1UILF/jqNX3czDKEX8vxaD0bAbzHWXgoxgbTMeB4hhTI4ai+OgcmUeSIE3Pbv27
 Q0inHhfMOWuE2y1OcJDxKdfLJw+EPimuouThhXwDfYrsiKcV+7cYn8heNuDtP4peci5KpDUKvb2
 bkbvUHnw2D7qFZlcHUCEsrGs0z09etRm9uAz/N6qRbhguIXPbs2qn2DbjWGsOWtj47nGAxTFCWp
 Xj59bI7P1/vQCUXr+fgCODQGvcrLYUIwcVJlSLUfl2n9mch6AnHAOtbkYB2tPhfKgjXP4r3yKw2
 Zt0DcqHgKMYIvj39aEaubXVDd2SWu2CkrgnmPL9Rt4hP70dYkd9y9Lvk46h2sy85/M171Oc5R16
 Zio=
X-Received: by 2002:a5d:64eb:0:b0:47f:93ea:cf47 with SMTP id
 ffacd0b85a97d-47f9fe97d00mr2970226f8f.37.1784992442572; 
 Sat, 25 Jul 2026 08:14:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm35763650f8f.7.2026.07.25.08.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 08:14:01 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 25 Jul 2026 15:13:54 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 2044d26efe0add6157f4b3d69b43df74345377b2
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <037e22e0dbb21906f45ca54696926e1f548b1df4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wne4r-0007Wd-Gc
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 be a fixed sized array
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
Content-Type: multipart/mixed; boundary="===============6389005385582552038=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6389005385582552038==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y6DP65qmRxQ="; charset=UTF-8

--y6DP65qmRxQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail

to look at the new pa=
tch set (#16)=2E


Change subject: Change hash iv to a be a fixed sized arr=
ay
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Change has=
h iv to a be a fixed sized array

While for our own hash function, always u=
sing an uint32_t works well, it does
not work very well if we move to anoth=
er hash function like siphash that
requires a larger key=2E

To avoid alloc=
ating a specific context, change the API to be a fixed size
array of size 4=
=2E This define allows use to easily change it to a larger
value if we use =
hash functions that require larger keys=2E

Change-Id: If47c7d920b2fa4047b7=
db03fcde821899839324d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
=
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
M src/openvpn/mroute=2Ec
M sr=
c/openvpn/mroute=2Eh
M src/openvpn/multi=2Ec
M tests/unit_tests/openvpn/tes=
t_misc=2Ec
6 files changed, 47 insertions(+), 23 deletions(-)


  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1571/16

diff --=
git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index c07e764=2E=2E6fc822=
8 100644
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -29,13 +2=
9,15 @@
 
 #include "integer=2Eh"
 #include "list=2Eh"
+
+#include "crypto=
=2Eh"
 #include "misc=2Eh"
 
 #include "memdbg=2Eh"
 
 struct hash *
-hash_=
init(const uint32_t n_buckets, const uint32_t iv,
-          uint64_t (*has=
h_function)(const void *key, uint32_t iv),
+hash_init(const uint32_t n_buck=
ets,
+          uint64_t (*hash_function)(const void *key, const uint8_t ha=
sh_key[HASH_KEY_LEN]),
           bool (*compare_function)(const void *key1=
, const void *key2))
 {
     struct hash *h;
@@ -46,7 +48,10 @@
     h->mas=
k =3D h->n_buckets - 1;
     h->hash_function =3D hash_function;
     h->co=
mpare_function =3D compare_function;
-    h->iv =3D iv;
+
+    /* create ra=
ndom hash key */
+    prng_bytes(h->hash_key, sizeof(h->hash_key));
+
     =
ALLOC_ARRAY(h->buckets, struct hash_bucket, h->n_buckets);
     for (uint32=
_t i =3D 0; i < h->n_buckets; ++i)
     {
@@ -412,6 +417,18 @@
         c ^=
=3D (b >> 15); \
     }
 
+/**
+ * Creates a context that allows to use the=
 hash function (hash_func) and
+ * @return a new context for the use with h=
ash_func
+ */
+void *
+hash_func_new_ctx(void)
+{
+    uint32_t *ctx =3D ma=
lloc(sizeof(uint32_t));
+    *ctx =3D (uint32_t)get_random();
+    return c=
tx;
+}
+
 uint64_t
 hash_func(const uint8_t *k, uint32_t length, uint32_t i=
nitval)
 {
diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh
index 0=
6377c6=2E=2Ecbf1abf 100644
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn/lis=
t=2Eh
@@ -49,19 +49,24 @@
     struct hash_element *list;
 };
 
+
+#define =
HASH_KEY_LEN 4
+
 struct hash
 {
     uint32_t n_buckets;
     uint32_t n_e=
lements;
     uint32_t mask;
-    uint32_t iv;
-    uint64_t (*hash_functio=
n)(const void *key, uint32_t iv);
+    /** key/iv used for the hash functio=
n=2E No to be confused with the (key, value)
+     * keys for the actual ha=
sh map entries */
+    uint8_t hash_key[HASH_KEY_LEN];
+    uint64_t (*hash=
_function)(const void *key, const uint8_t hash_key[HASH_KEY_LEN]);
     boo=
l (*compare_function)(const void *key1, const void *key2); /* return true i=
f equal */
     struct hash_bucket *buckets;
 };
 
-struct hash *hash_init(=
const uint32_t n_buckets, const uint32_t iv,
-                       uint64=
_t (*hash_function)(const void *key, uint32_t iv),
+struct hash *hash_init(=
const uint32_t n_buckets,
+                       uint64_t (*hash_function)=
(const void *key, const uint8_t hash_key[HASH_KEY_LEN]),
                  =
      bool (*compare_function)(const void *key1, const void *key2));
 
 voi=
d hash_free(struct hash *hash);
@@ -103,7 +108,7 @@
 static inline uint64_t=

 hash_value(const struct hash *hash, const void *key)
 {
-    return (*has=
h->hash_function)(key, hash->iv);
+    return (*hash->hash_function)(key, h=
ash->hash_key);
 }
 
 static inline uint32_t
diff --git a/src/openvpn/mrout=
e=2Ec b/src/openvpn/mroute=2Ec
index 78c689e=2E=2E62f655f 100644
--- a/src/=
openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -355,10 +355,10 @@
  * a=
nd the actual address=2E
  */
 uint64_t
-mroute_addr_hash_function(const vo=
id *key, uint32_t iv)
+mroute_addr_hash_function(const void *key, const uin=
t8_t hash_key[HASH_KEY_LEN])
 {
     return hash_func(mroute_addr_hash_ptr(=
(const struct mroute_addr *)key),
-                     mroute_addr_hash_le=
n((const struct mroute_addr *)key), iv);
+                     mroute_addr_=
hash_len((const struct mroute_addr *)key), *(int32_t *)hash_key);
 }
 
 boo=
l
diff --git a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh
index 2f5d01=
9=2E=2E639281b 100644
--- a/src/openvpn/mroute=2Eh
+++ b/src/openvpn/mroute=
=2Eh
@@ -144,7 +144,7 @@
 
 bool mroute_learnable_address(const struct mrou=
te_addr *addr, struct gc_arena *gc);
 
-uint64_t mroute_addr_hash_function(=
const void *key, uint32_t iv);
+uint64_t mroute_addr_hash_function(const vo=
id *key, const uint8_t hash_key[HASH_KEY_LEN]);
 
 bool mroute_addr_compare=
_function(const void *key1, const void *key2);
 
diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec
index f823f5b=2E=2Eaddad59 100644
--- a/sr=
c/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -229,7 +229,7 @@
 #ifdef=
 ENABLE_MANAGEMENT
 
 static uint64_t
-cid_hash_function(const void *key, u=
int32_t iv)
+cid_hash_function(const void *key, const uint8_t hash_key[HASH=
_KEY_LEN])
 {
     const unsigned long *k =3D (const unsigned long *)key;
 =
    return (uint64_t)*k;
@@ -250,7 +250,7 @@
 /*
  * inotify watcher descri=
ptors are used as hash value
  */
-int_hash_function(const void *key, uint3=
2_t iv)
+int_hash_function(const void *key, const uint8_t hash_key[HASH_KEY=
_LEN])
 {
     return (uintptr_t)key;
 }
@@ -290,27 +290,30 @@
      * to d=
etermine which client sent an incoming packet
      * which is seen on the =
TCP/UDP socket=2E
      */
-    m->hash =3D hash_init(t->options=2Ereal_has=
h_size, (uint32_t)get_random(),
+    m->hash =3D hash_init(t->options=2Erea=
l_hash_size,
                         mroute_addr_hash_function, mroute_add=
r_compare_function);
 
     /*
      * Virtual address hash table=2E  Used =
to determine
      * which client to route a packet to=2E
      */
-    m->=
vhash =3D hash_init(t->options=2Evirtual_hash_size, (uint32_t)get_random(),=

+    m->vhash =3D hash_init(t->options=2Evirtual_hash_size,
              =
            mroute_addr_hash_function, mroute_addr_compare_function);
 
 #i=
fdef ENABLE_MANAGEMENT
-    m->cid_hash =3D hash_init(t->options=2Ereal_has=
h_size, 0, cid_hash_function, cid_compare_function);
+    m->cid_hash =3D h=
ash_init(t->options=2Ereal_hash_size, cid_hash_function, cid_compare_functi=
on);
 #endif
 
 #ifdef ENABLE_ASYNC_PUSH
     /*
      * Mapping between in=
otify watch descriptors and
      * multi_instances=2E
+     *
+     * Note=
 we use a custom hash function here so we use dummy
+     * value and funct=
ion for the context parameters=2E
      */
-    m->inotify_watchers =3D has=
h_init(t->options=2Ereal_hash_size, (uint32_t)get_random(),
-              =
                      int_hash_function, int_compare_function);
+    m->ino=
tify_watchers =3D
+        hash_init(t->options=2Ereal_hash_size, int_hash_=
function, int_compare_function);
 #endif
 
     /*
diff --git a/tests/unit_=
tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index =
fc9840a=2E=2Ec0a49ab 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
++=
+ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -128,11 +128,11 @@
 
 
 stati=
c uint64_t
-word_hash_function(const void *key, uint32_t iv)
+word_hash_fun=
ction(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
     const =
char *str =3D (const char *)key;
     const uint32_t len =3D (uint32_t)strl=
en(str);
-    return hash_func((const uint8_t *)str, len, iv);
+    return =
hash_func((const uint8_t *)str, len, *(int32_t *)(hash_key));
 }
 
 static =
bool
@@ -174,10 +174,9 @@
      * Test the hash code by implementing a simp=
le
      * word frequency algorithm=2E
      */
-
     struct gc_arena gc =
=3D gc_new();
-    struct hash *hash =3D hash_init(10000, get_random(), wor=
d_hash_function, word_compare_function);
-    struct hash *nhash =3D hash_i=
nit(256, get_random(), word_hash_function, word_compare_function);
+    str=
uct hash *hash =3D hash_init(10000, word_hash_function, word_compare_functi=
on);
+    struct hash *nhash =3D hash_init(256, word_hash_function, word_co=
mpare_function);
 
     printf("hash_init n_buckets=3D%u mask=3D0x%08x\n", =
hash->n_buckets, hash->mask);
 

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1571?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
Gerrit-Change-Numb=
er: 1571
Gerrit-PatchSet: 16
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank=
@lichtenheld=2Ecom>

--y6DP65qmRxQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #16</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Change hash iv to a be a fixed sized array<br><br>While for our o=
wn hash function, always using an uint32_t works well, it does<br>not work =
very well if we move to another hash function like siphash that<br>requires=
 a larger key=2E<br><br>To avoid allocating a specific context, change the =
API to be a fixed size<br>array of size 4=2E This define allows use to easi=
ly change it to a larger<br>value if we use hash functions that require lar=
ger keys=2E<br><br>Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d<br>=
Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/open=
vpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/mroute=2Ec<br>M src=
/openvpn/mroute=2Eh<br>M src/openvpn/multi=2Ec<br>M tests/unit_tests/openvp=
n/test_misc=2Ec<br>6 files changed, 47 insertions(+), 23 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/71/1571/16</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/list=2Ec b/src/open=
vpn/list=2Ec</span><br><span>index c07e764=2E=2E6fc8228 100644</span><br><s=
pan>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</=
span><br><span>@@ -29,13 +29,15 @@</span><br><span> </span><br><span> #incl=
ude &quot;integer=2Eh&quot;</span><br><span> #include &quot;list=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><=
br><span> #include &quot;misc=2Eh&quot;</span><br><span> </span><br><span> =
#include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span> struct h=
ash *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_init(const =
uint32_t n_buckets, const uint32_t iv,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-          uint64_t (*hash_function)(const void *key, uint3=
2_t iv),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_init(c=
onst uint32_t n_buckets,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+          uint64_t (*hash_function)(const void *key, const uint8_t has=
h_key[HASH_KEY_LEN]),</span><br><span>           bool (*compare_function)(c=
onst void *key1, const void *key2))</span><br><span> {</span><br><span>    =
 struct hash *h;</span><br><span>@@ -46,7 +48,10 @@</span><br><span>     h-=
&gt;mask =3D h-&gt;n_buckets - 1;</span><br><span>     h-&gt;hash_function =
=3D hash_function;</span><br><span>     h-&gt;compare_function =3D compare_=
function;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    h-&gt;iv=
 =3D iv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* create random hash key =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prng_bytes(h-=
&gt;hash_key, sizeof(h-&gt;hash_key));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     ALLOC_ARRAY(h-&gt;buckets, struct =
hash_bucket, h-&gt;n_buckets);</span><br><span>     for (uint32_t i =3D 0; =
i &lt; h-&gt;n_buckets; ++i)</span><br><span>     {</span><br><span>@@ -412=
,6 +417,18 @@</span><br><span>         c ^=3D (b &gt;&gt; 15); \</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Cr=
eates a context that allows to use the hash function (hash_func) and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return a new context f=
or the use with hash_func</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_func_new_ctx(void)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    uint32_t *ctx =3D malloc(sizeof(u=
int32_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *ctx =
=3D (uint32_t)get_random();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> uint64_t</span><br><span> hash_func(const uint8_t *k, uint32_t length, =
uint32_t initval)</span><br><span> {</span><br><span>diff --git a/src/openv=
pn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>index 06377c6=2E=2Ecbf1a=
bf 100644</span><br><span>--- a/src/openvpn/list=2Eh</span><br><span>+++ b/=
src/openvpn/list=2Eh</span><br><span>@@ -49,19 +49,24 @@</span><br><span>  =
   struct hash_element *list;</span><br><span> };</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define HASH_KEY_LEN 4</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct hash</span><br><=
span> {</span><br><span>     uint32_t n_buckets;</span><br><span>     uint3=
2_t n_elements;</span><br><span>     uint32_t mask;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint32_t iv;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    uint64_t (*hash_function)(const void *key, u=
int32_t iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**=
 key/iv used for the hash function=2E No to be confused with the (key, valu=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * keys for t=
he actual hash map entries */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint8_t hash_key[HASH_KEY_LEN];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint64_t (*hash_function)(const void *key, co=
nst uint8_t hash_key[HASH_KEY_LEN]);</span><br><span>     bool (*compare_fu=
nction)(const void *key1, const void *key2); /* return true if equal */</sp=
an><br><span>     struct hash_bucket *buckets;</span><br><span> };</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct hash =
*hash_init(const uint32_t n_buckets, const uint32_t iv,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                       uint64_t (*hash_fu=
nction)(const void *key, uint32_t iv),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+struct hash *hash_init(const uint32_t n_buckets,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                       uint=
64_t (*hash_function)(const void *key, const uint8_t hash_key[HASH_KEY_LEN]=
),</span><br><span>                        bool (*compare_function)(const v=
oid *key1, const void *key2));</span><br><span> </span><br><span> void hash=
_free(struct hash *hash);</span><br><span>@@ -103,7 +108,7 @@</span><br><sp=
an> static inline uint64_t</span><br><span> hash_value(const struct hash *h=
ash, const void *key)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return (*hash-&gt;hash_function)(key, hash-&gt;iv);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (*hash-&g=
t;hash_function)(key, hash-&gt;hash_key);</span><br><span> }</span><br><spa=
n> </span><br><span> static inline uint32_t</span><br><span>diff --git a/sr=
c/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br><span>index 78c689e=
=2E=2E62f655f 100644</span><br><span>--- a/src/openvpn/mroute=2Ec</span><br=
><span>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@ -355,10 +355,10 @@</=
span><br><span>  * and the actual address=2E</span><br><span>  */</span><br=
><span> uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mrout=
e_addr_hash_function(const void *key, uint32_t iv)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+mroute_addr_hash_function(const void *key, c=
onst uint8_t hash_key[HASH_KEY_LEN])</span><br><span> {</span><br><span>   =
  return hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     mr=
oute_addr_hash_len((const struct mroute_addr *)key), iv);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     mroute_addr_hash=
_len((const struct mroute_addr *)key), *(int32_t *)hash_key);</span><br><sp=
an> }</span><br><span> </span><br><span> bool</span><br><span>diff --git a/=
src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh</span><br><span>index 2f5d0=
19=2E=2E639281b 100644</span><br><span>--- a/src/openvpn/mroute=2Eh</span><=
br><span>+++ b/src/openvpn/mroute=2Eh</span><br><span>@@ -144,7 +144,7 @@</=
span><br><span> </span><br><span> bool mroute_learnable_address(const struc=
t mroute_addr *addr, struct gc_arena *gc);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-uint64_t mroute_addr_hash_function(c=
onst void *key, uint32_t iv);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+uint64_t mroute_addr_hash_function(const void *key, const uint8_t=
 hash_key[HASH_KEY_LEN]);</span><br><span> </span><br><span> bool mroute_ad=
dr_compare_function(const void *key1, const void *key2);</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec<=
/span><br><span>index f823f5b=2E=2Eaddad59 100644</span><br><span>--- a/src=
/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><s=
pan>@@ -229,7 +229,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br=
><span> </span><br><span> static uint64_t</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-cid_hash_function(const void *key, uint32_t iv)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+cid_hash_function(const voi=
d *key, const uint8_t hash_key[HASH_KEY_LEN])</span><br><span> {</span><br>=
<span>     const unsigned long *k =3D (const unsigned long *)key;</span><br=
><span>     return (uint64_t)*k;</span><br><span>@@ -250,7 +250,7 @@</span>=
<br><span> /*</span><br><span>  * inotify watcher descriptors are used as h=
ash value</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-int_hash_function(const void *key, uint32_t iv)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+int_hash_function(const void *key, con=
st uint8_t hash_key[HASH_KEY_LEN])</span><br><span> {</span><br><span>     =
return (uintptr_t)key;</span><br><span> }</span><br><span>@@ -290,27 +290,3=
0 @@</span><br><span>      * to determine which client sent an incoming pac=
ket</span><br><span>      * which is seen on the TCP/UDP socket=2E</span><b=
r><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
-&gt;hash =3D hash_init(t-&gt;options=2Ereal_hash_size, (uint32_t)get_rando=
m(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;hash =
=3D hash_init(t-&gt;options=2Ereal_hash_size,</span><br><span>             =
            mroute_addr_hash_function, mroute_addr_compare_function);</span=
><br><span> </span><br><span>     /*</span><br><span>      * Virtual addres=
s hash table=2E  Used to determine</span><br><span>      * which client to =
route a packet to=2E</span><br><span>      */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    m-&gt;vhash =3D hash_init(t-&gt;options=2Evirtu=
al_hash_size, (uint32_t)get_random(),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    m-&gt;vhash =3D hash_init(t-&gt;options=2Evirtual_has=
h_size,</span><br><span>                          mroute_addr_hash_function=
, mroute_addr_compare_function);</span><br><span> </span><br><span> #ifdef =
ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_size, 0, cid_hash_fu=
nction, cid_compare_function);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_size,=
 cid_hash_function, cid_compare_function);</span><br><span> #endif</span><b=
r><span> </span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>     /*=
</span><br><span>      * Mapping between inotify watch descriptors and</spa=
n><br><span>      * multi_instances=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * Note we use a custom hash function here so we use dummy</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * value and function =
for the context parameters=2E</span><br><span>      */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    m-&gt;inotify_watchers =3D hash_init(t=
-&gt;options=2Ereal_hash_size, (uint32_t)get_random(),</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                    int_ha=
sh_function, int_compare_function);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    m-&gt;inotify_watchers =3D</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        hash_init(t-&gt;options=2Ereal_hash_size=
, int_hash_function, int_compare_function);</span><br><span> #endif</span><=
br><span> </span><br><span>     /*</span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span>=
<br><span>index fc9840a=2E=2Ec0a49ab 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_misc=2Ec</span><br><span>@@ -128,11 +128,11 @@</span><br><span> </sp=
an><br><span> </span><br><span> static uint64_t</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-word_hash_function(const void *key, uint32_t iv)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+word_hash_function(c=
onst void *key, const uint8_t hash_key[HASH_KEY_LEN])</span><br><span> {</s=
pan><br><span>     const char *str =3D (const char *)key;</span><br><span> =
    const uint32_t len =3D (uint32_t)strlen(str);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return hash_func((const uint8_t *)str, len,=
 iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return has=
h_func((const uint8_t *)str, len, *(int32_t *)(hash_key));</span><br><span>=
 }</span><br><span> </span><br><span> static bool</span><br><span>@@ -174,1=
0 +174,9 @@</span><br><span>      * Test the hash code by implementing a si=
mple</span><br><span>      * word frequency algorithm=2E</span><br><span>  =
    */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n>     struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct hash *hash =3D hash_init(10000, get_random(), =
word_hash_function, word_compare_function);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct hash *nhash =3D hash_init(256, get_random(=
), word_hash_function, word_compare_function);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct hash *hash =3D hash_init(10000, word_=
hash_function, word_compare_function);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct hash *nhash =3D hash_init(256, word_hash_func=
tion, word_compare_function);</span><br><span> </span><br><span>     printf=
(&quot;hash_init n_buckets=3D%u mask=3D0x%08x\n&quot;, hash-&gt;n_buckets, =
hash-&gt;mask);</span><br><span> </span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3De=
mail">change 1571</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1571?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1571 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-Owner=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>

</body></html>
--y6DP65qmRxQ=--


--===============6389005385582552038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6389005385582552038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6389005385582552038==--

