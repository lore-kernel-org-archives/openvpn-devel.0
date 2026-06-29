Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895A8C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f68wJmbkhXZfMkFEHSMoeQctzphDBbZu+jZH7sAr6sw=; b=bZJino+TwZntEiOBGaEKRcC7w2
	07EnWl5WO5qMPue2ZsoWyX7nk5cEoLlYYLaU9GEWTr5oE5BQ0KOefRwdU+jzrb98/ZJCYRrXx/JcR
	MPCn5IErCNw5pRXLK3MqL1cvUWzSoIgSp65rMvAeK4bWk1g/f/Kj3XebLd17nTt9vCto=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we5wK-0002Xx-Fi;
	Mon, 29 Jun 2026 06:57:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we5wJ-0002Xr-QS
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 06:57:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=a3KtWHz4Jg72luu7f1JD8EB0k+t9GLDGA63VqukWA1U=; b=ZYqOSC9R/T7qgI+P10fyjuZVdM
 L+7nfrBB3+5e+iJ3bpO/0MV4zt816snAE3gToAKHh0IR88czU1rCQfe/snWTqm77wdiLJiGHkJBBQ
 HRxn+lS0fOaFADldQ96gNPueIFmyjqy4fJZIV0Aow5wGFYe2zF0LDUwLmnU5P06kLVos=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=a3KtWHz4Jg72luu7f1JD8EB0k+t9GLDGA63VqukWA1U=; b=L
 Mo2iuo3g0k2qCW4tGAPKEJhcGPl2+ulBusrur17lFeq/S3Q/v1dSzGMOSdhBn7SHkgsZt3dVv6nQ/
 atqiyAvQ43Ps6YrA09SMdT4UVl8cR5Ec30E+yUb5SQice1QHMW8zITHNh/Pxh/LjwtkP6TlpTWmZB
 tYFQVHEP4fdZAxGc=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we5wF-0004XF-0l for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 06:57:53 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4624a44e152so2664125f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 28 Jun 2026 23:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782716265; x=1783321065; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a3KtWHz4Jg72luu7f1JD8EB0k+t9GLDGA63VqukWA1U=;
 b=EA8hRkGnIbKVluetrBdtKhqXxOw+Wfh8R2rfcbFpR9AtD7FMpR1CSYYXlwTlggA/j3
 qtZSVuxMrkSTHAYcURe365tMNcNSB72gKMGIxy+B9cN/US2wr2Q9FSeigW7qxr6dJfeD
 tIf3p6Jy+WBueV1sdJlOnRzgQyxOG4BLa9ZMgaPvPgoRsPteFD16BhXDwiW3darlHoWe
 JbJxT3jM0s9cbvW8KMkrG8Rif9d5nnbFfPyE1c2LsEkPcd2K30y20XKppJMJ1RGrRNMa
 cNE9NHia6Wxe7kA06AFfZEma01CunpMurEE5l/vp3pc8XEXVhnvenOWXW5DjDxMbIa3G
 tueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782716265; x=1783321065;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a3KtWHz4Jg72luu7f1JD8EB0k+t9GLDGA63VqukWA1U=;
 b=S/qlzcQgsJIlYjFWCfJ9ZDERi9PeZ2+rOcvTn/ESF8T7GgO0wiBUmamxNB/75IrlcS
 NPhx6xkdITACf0TaslCw6aE9Onh3F3QDDwUHOII4vAu0OS6TF828FFqO0ttoabhuw4lE
 aU1rsYIMkQbFpKQxKNS3GunD/DUlS/YDrevlXCUNxIMxynxCGC5sIlFNCuDDHwv+GpJu
 tZ6MKKv7P1HvHZweJUBjZRoOEWxZaOG8n3x2yhCNgpwqVRY1I9Et+0QBLDT4bVs09Kw7
 AYVGKsKB7eCRSISg0QU39ndvP1EVUKdTN4h2ZE/xr1nfznR9AbjMcjm6pv83fZ6QJ62s
 TnAA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGAus5eTw5MQ9Zn76l12uAT41KzfIGlzGnF3pvR1tSDGS1ypKLUBhMTj6cnTP/EfZpFZvP6taf3CpbHKJo@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxGx/lTH/i/6ugZiFaT5AwriTn+7Wodd/GrdZwEOIr699K4ffVc
 SWJiOT6RGvECNEVwCtwx+1wRHPqKY5JyvFPBkoo4TLOcW2KoVjbpubBs+OjKvMrhg54XFaqspMh
 5DFQpsvqnwmD5Xv1pmVzLJl9T0P7R25nUQBeBZyrOiUoYyLJ5PukAl9pYqWy3c+WpwQIjr3ujC6
 bcaJ5Olw==
X-Gm-Gg: AfdE7ckWH22Pr/XtV5lqtOp4kfC9fpUP6uRe+DTXzpVWEuqJPbPpHO9s7OHvl5W6u+Y
 WaOKcrjPWjfn7SaGODGJONu3glwYzRYz9ODO/nQ3Sp0O0RqAGgth+Nm4LMtCIwR7XjTlxI7KXaT
 nBLFPM/ebkp2Kg18cbjorWSa+OFte1gvdIp0l0MvyXeBVIspTK9Tq8sOSr9GUj89VdzCNeKxdKS
 glkzYMdH5JGo2A9nktJnLH77DXvY532cSq8v5XWXpMDpa7LBKqPYr5s4H2dCBu7h/NvmGCeJ0Mq
 zy9hd/lHWlF2B74ByrFVOBh63hqtHeiP9kuE9baFWg0gQoATEmFh+i5tgSLdpT16VbLkb+yjED5
 gd9x7EX3eP8keZxmUy+NecUQ3qj3SysmT4xvyRHJeNfpIDX87/V4/5th78z1Z9LGvE+GCK1c8hW
 TO3J5Kp2D4e5af6o9CCbZ/kws36vVBJ6PQubXH37KROz+xcpB5w13X6gD9NfFL0buWexqWSsTFo
 5Fi9qsugQu45umBv5bOsmB3kS+sHGjbZ6h4Yi5sE5c/282nx2vX3FJMzfdigvs46Fq3dhB8xrCJ
 +nc=
X-Received: by 2002:a05:6000:2f8a:b0:46d:d6c1:8383 with SMTP id
 ffacd0b85a97d-46dd6c18494mr24172309f8f.44.1782716264753; 
 Sun, 28 Jun 2026 23:57:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4728072188fsm13715008f8f.29.2026.06.28.23.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 23:57:44 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 06:57:43 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
X-Gerrit-Change-Number: 1570
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1570?usp=email>
X-Gerrit-Commit: d8536b34d39507a878db107a2098846faf932778
In-Reply-To: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@gerrit.openvpn.net>
References: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkliODE0MDEwN2Y5ODE2NGQyYTJlMTc2OGE2ZDhhYzY1MDE2Y2Q3ZjdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aa6b053f7035051d0c9d277f8375ddd5c2ea55a6-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we5wF-0004XF-0l
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash values
 in our hash map from uint32_t to uint64_t
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0911540378206608019=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0911540378206608019==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0ksCQhI8CN4="; charset=UTF-8

--0ksCQhI8CN4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1570?usp=3Demail )

Change subject: Change hash values in our hash map =
from uint32_t to uint64_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Change hash values in our hash map from uint32_t to uint64_t
=

32 bit architectures are playing a very small role today, so the differenc=
e
between 64 bit and 32 bit hash values is not expected to be large anymore=
=2E

This is also in preparation to replace our hash function with a more m=
odern
replacement=2E

Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
=
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1570
Message-Id: <20260628210033=2E4583-1-gert=
@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg37349=2Ehtml
Signed-off-by: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
---
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
M src/=
openvpn/mroute=2Ec
M src/openvpn/mroute=2Eh
M src/openvpn/mtcp=2Ec
M src/op=
envpn/mudp=2Ec
M src/openvpn/multi=2Ec
M tests/unit_tests/openvpn/test_misc=
=2Ec
8 files changed, 29 insertions(+), 29 deletions(-)




diff --git a/sr=
c/openvpn/list=2Ec b/src/openvpn/list=2Ec
index f0e9908=2E=2Ec07e764 100644=

--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -35,7 +35,7 @@
 
=
 struct hash *
 hash_init(const uint32_t n_buckets, const uint32_t iv,
-   =
       uint32_t (*hash_function)(const void *key, uint32_t iv),
+          =
uint64_t (*hash_function)(const void *key, uint32_t iv),
           bool (*=
compare_function)(const void *key1, const void *key2))
 {
     struct hash =
*h;
@@ -76,7 +76,7 @@
 }
 
 struct hash_element *
-hash_lookup_fast(struct =
hash *hash, struct hash_bucket *bucket, const void *key, uint32_t hv)
+hash=
_lookup_fast(struct hash *hash, struct hash_bucket *bucket, const void *key=
, uint64_t hv)
 {
     struct hash_element *he;
     struct hash_element *p=
rev =3D NULL;
@@ -104,7 +104,7 @@
 }
 
 bool
-hash_remove_fast(struct hash =
*hash, struct hash_bucket *bucket, const void *key, uint32_t hv)
+hash_remo=
ve_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uin=
t64_t hv)
 {
     struct hash_element *he;
     struct hash_element *prev =
=3D NULL;
@@ -136,7 +136,7 @@
 bool
 hash_add(struct hash *hash, const void=
 *key, void *value, bool replace)
 {
-    uint32_t hv;
+    uint64_t hv;
  =
   struct hash_bucket *bucket;
     struct hash_element *he;
     bool ret =
=3D false;
@@ -412,7 +412,7 @@
         c ^=3D (b >> 15); \
     }
 
-uint3=
2_t
+uint64_t
 hash_func(const uint8_t *k, uint32_t length, uint32_t initva=
l)
 {
     uint32_t a, b, c, len;
diff --git a/src/openvpn/list=2Eh b/src/o=
penvpn/list=2Eh
index 04cc3ab=2E=2E06377c6 100644
--- a/src/openvpn/list=2E=
h
+++ b/src/openvpn/list=2Eh
@@ -40,7 +40,7 @@
 {
     void *value;
     co=
nst void *key;
-    uint32_t hash_value;
+    uint64_t hash_value;
     str=
uct hash_element *next;
 };
 
@@ -55,13 +55,13 @@
     uint32_t n_elements;=

     uint32_t mask;
     uint32_t iv;
-    uint32_t (*hash_function)(const=
 void *key, uint32_t iv);
+    uint64_t (*hash_function)(const void *key, u=
int32_t iv);
     bool (*compare_function)(const void *key1, const void *ke=
y2); /* return true if equal */
     struct hash_bucket *buckets;
 };
 
 st=
ruct hash *hash_init(const uint32_t n_buckets, const uint32_t iv,
-        =
               uint32_t (*hash_function)(const void *key, uint32_t iv),
+  =
                     uint64_t (*hash_function)(const void *key, uint32_t iv=
),
                        bool (*compare_function)(const void *key1, const=
 void *key2));
 
 void hash_free(struct hash *hash);
@@ -69,9 +69,9 @@
 boo=
l hash_add(struct hash *hash, const void *key, void *value, bool replace);
=
 
 struct hash_element *hash_lookup_fast(struct hash *hash, struct hash_buc=
ket *bucket,
-                                      const void *key, uint32=
_t hv);
+                                      const void *key, uint64_t hv=
);
 
-bool hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, =
const void *key, uint32_t hv);
+bool hash_remove_fast(struct hash *hash, st=
ruct hash_bucket *bucket, const void *key, uint64_t hv);
 
 void hash_remov=
e_by_value(struct hash *hash, void *value);
 
@@ -98,9 +98,9 @@
 
 void has=
h_iterator_free(struct hash_iterator *hi);
 
-uint32_t hash_func(const uint=
8_t *k, uint32_t length, uint32_t initval);
+uint64_t hash_func(const uint8=
_t *k, uint32_t length, uint32_t initval);
 
-static inline uint32_t
+stati=
c inline uint64_t
 hash_value(const struct hash *hash, const void *key)
 {
=
     return (*hash->hash_function)(key, hash->iv);
@@ -119,7 +119,7 @@
 }
 =

 static inline struct hash_bucket *
-hash_bucket(struct hash *hash, uint32=
_t hv)
+hash_bucket(struct hash *hash, uint64_t hv)
 {
     return &hash->b=
uckets[hv & hash->mask];
 }
@@ -129,7 +129,7 @@
 {
     void *ret =3D NULL;=

     struct hash_element *he;
-    uint32_t hv =3D hash_value(hash, key);
=
+    uint64_t hv =3D hash_value(hash, key);
     struct hash_bucket *bucket=
 =3D &hash->buckets[hv & hash->mask];
 
     he =3D hash_lookup_fast(hash, =
bucket, key, hv);
@@ -143,7 +143,7 @@
 
 /* NOTE: assumes that key is not a=
 duplicate */
 static inline void
-hash_add_fast(struct hash *hash, struct =
hash_bucket *bucket, const void *key, uint32_t hv,
+hash_add_fast(struct ha=
sh *hash, struct hash_bucket *bucket, const void *key, uint64_t hv,
       =
        void *value)
 {
     struct hash_element *he;
@@ -160,7 +160,7 @@
 =
static inline bool
 hash_remove(struct hash *hash, const void *key)
 {
-   =
 uint32_t hv;
+    uint64_t hv;
     struct hash_bucket *bucket;
     bool =
ret;
 
diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index 6=
fa70a3=2E=2E78c689e 100644
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvpn/m=
route=2Ec
@@ -354,7 +354,7 @@
  * address type, number of bits in the netwo=
rk address,
  * and the actual address=2E
  */
-uint32_t
+uint64_t
 mroute_=
addr_hash_function(const void *key, uint32_t iv)
 {
     return hash_func(m=
route_addr_hash_ptr((const struct mroute_addr *)key),
diff --git a/src/open=
vpn/mroute=2Eh b/src/openvpn/mroute=2Eh
index c8daa15=2E=2E2f5d019 100644
-=
-- a/src/openvpn/mroute=2Eh
+++ b/src/openvpn/mroute=2Eh
@@ -144,7 +144,7 @=
@
 
 bool mroute_learnable_address(const struct mroute_addr *addr, struct g=
c_arena *gc);
 
-uint32_t mroute_addr_hash_function(const void *key, uint32=
_t iv);
+uint64_t mroute_addr_hash_function(const void *key, uint32_t iv);
=
 
 bool mroute_addr_compare_function(const void *key1, const void *key2);
 =

diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 7651b4d=2E=
=2Ef000283 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ =
-49,7 +49,7 @@
     {
         mi->real=2Eproto =3D sock->info=2Eproto;
   =
      struct hash_element *he;
-        const uint32_t hv =3D hash_value(ha=
sh, &mi->real);
+        const uint64_t hv =3D hash_value(hash, &mi->real);=

         struct hash_bucket *bucket =3D hash_bucket(hash, hv);
 
         =
multi_assign_peer_id(m, mi);
diff --git a/src/openvpn/mudp=2Ec b/src/openvp=
n/mudp=2Ec
index f919b67=2E=2E9acf297 100644
--- a/src/openvpn/mudp=2Ec
+++=
 b/src/openvpn/mudp=2Ec
@@ -281,7 +281,7 @@
     if (mroute_extract_openvpn=
_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=2El=
en > 0)
     {
         struct hash_element *he;
-        const uint32_t hv=
 =3D hash_value(hash, &real);
+        const uint64_t hv =3D hash_value(has=
h, &real);
         struct hash_bucket *bucket =3D hash_bucket(hash, hv);
 =
        uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
         uint8_t op =3D =
ptr[0] >> P_OPCODE_SHIFT;
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/=
multi=2Ec
index 8b36cf7=2E=2Ec4293a7 100644
--- a/src/openvpn/multi=2Ec
+++=
 b/src/openvpn/multi=2Ec
@@ -228,11 +228,11 @@
 
 #ifdef ENABLE_MANAGEMENT
=
 
-static uint32_t
+static uint64_t
 cid_hash_function(const void *key, uin=
t32_t iv)
 {
     const unsigned long *k =3D (const unsigned long *)key;
- =
   return (uint32_t)*k;
+    return (uint64_t)*k;
 }
 
 static bool
@@ -246=
,19 +246,19 @@
 #endif
 
 #ifdef ENABLE_ASYNC_PUSH
-static uint32_t
+static=
 uint64_t
 /*
  * inotify watcher descriptors are used as hash value
  */
 =
int_hash_function(const void *key, uint32_t iv)
 {
-    return (uint32_t)(u=
intptr_t)key;
+    return (uintptr_t)key;
 }
 
 static bool
 int_compare_fu=
nction(const void *key1, const void *key2)
 {
-    return (unsigned long)ke=
y1 =3D=3D (unsigned long)key2;
+    return (uintptr_t)key1 =3D=3D (uintptr_=
t)key2;
 }
 #endif
 
@@ -1012,7 +1012,7 @@
                  const unsigned=
 int flags)
 {
     struct hash_element *he;
-    const uint32_t hv =3D has=
h_value(m->vhash, addr);
+    const uint64_t hv =3D hash_value(m->vhash, ad=
dr);
     struct hash_bucket *bucket =3D hash_bucket(m->vhash, hv);
     st=
ruct multi_route *oldroute =3D NULL;
     struct multi_instance *owner =3D =
NULL;
@@ -3094,7 +3094,7 @@
         goto done;
     }
 
-    const uint32_=
t hv =3D hash_value(hash, &real);
+    const uint64_t hv =3D hash_value(has=
h, &real);
     struct hash_bucket *bucket =3D hash_bucket(hash, hv);
 
   =
  /* make sure that we don't float to an address taken by another client */=

@@ -4230,7 +4230,7 @@
 multi_unlearn_addr(struct multi_context *m, struct =
multi_instance *mi, const struct mroute_addr *addr)
 {
     struct hash_ele=
ment *he;
-    const uint32_t hv =3D hash_value(m->vhash, addr);
+    const=
 uint64_t hv =3D hash_value(m->vhash, addr);
     struct hash_bucket *bucke=
t =3D hash_bucket(m->vhash, hv);
     struct multi_route *r =3D NULL;
 
dif=
f --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn=
/test_misc=2Ec
index a9ae33f=2E=2Eccdfdee 100644
--- a/tests/unit_tests/ope=
nvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -124,7 +=
124,7 @@
 };
 
 
-static uint32_t
+static uint64_t
 word_hash_function(cons=
t void *key, uint32_t iv)
 {
     const char *str =3D (const char *)key;

-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1570?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib8140107f98164d2a2e1768=
a6d8ac65016cd7f7c
Gerrit-Change-Number: 1570
Gerrit-PatchSet: 9
Gerrit-Owne=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--0ksCQhI8CN4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1570?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Change hash values in our hash map from ui=
nt32_t to uint64_t<br><br>32 bit architectures are playing a very small rol=
e today, so the difference<br>between 64 bit and 32 bit hash values is not =
expected to be large anymore=2E<br><br>This is also in preparation to repla=
ce our hash function with a more modern<br>replacement=2E<br><br>Change-Id:=
 Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c<br>Signed-off-by: Arne Schwabe &=
lt;arne@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1570<br>Message-Id: &lt;20260628210033=2E4583-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg37349=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=
=2Eh<br>M src/openvpn/mroute=2Ec<br>M src/openvpn/mroute=2Eh<br>M src/openv=
pn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M tests=
/unit_tests/openvpn/test_misc=2Ec<br>8 files changed, 29 insertions(+), 29 =
deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/list=2Ec b/src/openv=
pn/list=2Ec</span><br><span>index f0e9908=2E=2Ec07e764 100644</span><br><sp=
an>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</s=
pan><br><span>@@ -35,7 +35,7 @@</span><br><span> </span><br><span> struct h=
ash *</span><br><span> hash_init(const uint32_t n_buckets, const uint32_t i=
v,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          uint32_t =
(*hash_function)(const void *key, uint32_t iv),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+          uint64_t (*hash_function)(const void =
*key, uint32_t iv),</span><br><span>           bool (*compare_function)(con=
st void *key1, const void *key2))</span><br><span> {</span><br><span>     s=
truct hash *h;</span><br><span>@@ -76,7 +76,7 @@</span><br><span> }</span><=
br><span> </span><br><span> struct hash_element *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-hash_lookup_fast(struct hash *hash, struct hash=
_bucket *bucket, const void *key, uint32_t hv)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+hash_lookup_fast(struct hash *hash, struct hash_=
bucket *bucket, const void *key, uint64_t hv)</span><br><span> {</span><br>=
<span>     struct hash_element *he;</span><br><span>     struct hash_elemen=
t *prev =3D NULL;</span><br><span>@@ -104,7 +104,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-hash_remove_fast(struct hash *hash, struct hash_bucket *buc=
ket, const void *key, uint32_t hv)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+hash_remove_fast(struct hash *hash, struct hash_bucket *buck=
et, const void *key, uint64_t hv)</span><br><span> {</span><br><span>     s=
truct hash_element *he;</span><br><span>     struct hash_element *prev =3D =
NULL;</span><br><span>@@ -136,7 +136,7 @@</span><br><span> bool</span><br><=
span> hash_add(struct hash *hash, const void *key, void *value, bool replac=
e)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    uint32_t hv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 uint64_t hv;</span><br><span>     struct hash_bucket *bucket;</span><br><s=
pan>     struct hash_element *he;</span><br><span>     bool ret =3D false;<=
/span><br><span>@@ -412,7 +412,7 @@</span><br><span>         c ^=3D (b &gt;=
&gt; 15); \</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-uint32_t</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+uint64_t</span><br><span> hash_func(const uint8_t *k, =
uint32_t length, uint32_t initval)</span><br><span> {</span><br><span>     =
uint32_t a, b, c, len;</span><br><span>diff --git a/src/openvpn/list=2Eh b/=
src/openvpn/list=2Eh</span><br><span>index 04cc3ab=2E=2E06377c6 100644</spa=
n><br><span>--- a/src/openvpn/list=2Eh</span><br><span>+++ b/src/openvpn/li=
st=2Eh</span><br><span>@@ -40,7 +40,7 @@</span><br><span> {</span><br><span=
>     void *value;</span><br><span>     const void *key;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    uint32_t hash_value;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uint64_t hash_value;</span><br>=
<span>     struct hash_element *next;</span><br><span> };</span><br><span> =
</span><br><span>@@ -55,13 +55,13 @@</span><br><span>     uint32_t n_elemen=
ts;</span><br><span>     uint32_t mask;</span><br><span>     uint32_t iv;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t (*hash_fun=
ction)(const void *key, uint32_t iv);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint64_t (*hash_function)(const void *key, uint32_t i=
v);</span><br><span>     bool (*compare_function)(const void *key1, const v=
oid *key2); /* return true if equal */</span><br><span>     struct hash_buc=
ket *buckets;</span><br><span> };</span><br><span> </span><br><span> struct=
 hash *hash_init(const uint32_t n_buckets, const uint32_t iv,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                       uint32_t (*h=
ash_function)(const void *key, uint32_t iv),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                       uint64_t (*hash_function)(c=
onst void *key, uint32_t iv),</span><br><span>                        bool =
(*compare_function)(const void *key1, const void *key2));</span><br><span> =
</span><br><span> void hash_free(struct hash *hash);</span><br><span>@@ -69=
,9 +69,9 @@</span><br><span> bool hash_add(struct hash *hash, const void *k=
ey, void *value, bool replace);</span><br><span> </span><br><span> struct h=
ash_element *hash_lookup_fast(struct hash *hash, struct hash_bucket *bucket=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
                  const void *key, uint32_t hv);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                      const vo=
id *key, uint64_t hv);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-bool hash_remove_fast(struct hash *hash, struct hash_buc=
ket *bucket, const void *key, uint32_t hv);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool hash_remove_fast(struct hash *hash, struct has=
h_bucket *bucket, const void *key, uint64_t hv);</span><br><span> </span><b=
r><span> void hash_remove_by_value(struct hash *hash, void *value);</span><=
br><span> </span><br><span>@@ -98,9 +98,9 @@</span><br><span> </span><br><s=
pan> void hash_iterator_free(struct hash_iterator *hi);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint32_t hash_func(cons=
t uint8_t *k, uint32_t length, uint32_t initval);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+uint64_t hash_func(const uint8_t *k, uint32_t=
 length, uint32_t initval);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static inline uint32_t</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static inline uint64_t</span><br><span> hash_val=
ue(const struct hash *hash, const void *key)</span><br><span> {</span><br><=
span>     return (*hash-&gt;hash_function)(key, hash-&gt;iv);</span><br><sp=
an>@@ -119,7 +119,7 @@</span><br><span> }</span><br><span> </span><br><span=
> static inline struct hash_bucket *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-hash_bucket(struct hash *hash, uint32_t hv)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+hash_bucket(struct hash *hash, uint6=
4_t hv)</span><br><span> {</span><br><span>     return &amp;hash-&gt;bucket=
s[hv &amp; hash-&gt;mask];</span><br><span> }</span><br><span>@@ -129,7 +12=
9,7 @@</span><br><span> {</span><br><span>     void *ret =3D NULL;</span><b=
r><span>     struct hash_element *he;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    uint32_t hv =3D hash_value(hash, key);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    uint64_t hv =3D hash_value(hash,=
 key);</span><br><span>     struct hash_bucket *bucket =3D &amp;hash-&gt;bu=
ckets[hv &amp; hash-&gt;mask];</span><br><span> </span><br><span>     he =
=3D hash_lookup_fast(hash, bucket, key, hv);</span><br><span>@@ -143,7 +143=
,7 @@</span><br><span> </span><br><span> /* NOTE: assumes that key is not a=
 duplicate */</span><br><span> static inline void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-hash_add_fast(struct hash *hash, struct hash_bu=
cket *bucket, const void *key, uint32_t hv,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+hash_add_fast(struct hash *hash, struct hash_bucket=
 *bucket, const void *key, uint64_t hv,</span><br><span>               void=
 *value)</span><br><span> {</span><br><span>     struct hash_element *he;</=
span><br><span>@@ -160,7 +160,7 @@</span><br><span> static inline bool</spa=
n><br><span> hash_remove(struct hash *hash, const void *key)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t hv;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t hv;</sp=
an><br><span>     struct hash_bucket *bucket;</span><br><span>     bool ret=
;</span><br><span> </span><br><span>diff --git a/src/openvpn/mroute=2Ec b/s=
rc/openvpn/mroute=2Ec</span><br><span>index 6fa70a3=2E=2E78c689e 100644</sp=
an><br><span>--- a/src/openvpn/mroute=2Ec</span><br><span>+++ b/src/openvpn=
/mroute=2Ec</span><br><span>@@ -354,7 +354,7 @@</span><br><span>  * address=
 type, number of bits in the network address,</span><br><span>  * and the a=
ctual address=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-uint32_t</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+uint64_t</span><br><span> mroute_addr_hash_function(const void *key, u=
int32_t iv)</span><br><span> {</span><br><span>     return hash_func(mroute=
_addr_hash_ptr((const struct mroute_addr *)key),</span><br><span>diff --git=
 a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh</span><br><span>index c8=
daa15=2E=2E2f5d019 100644</span><br><span>--- a/src/openvpn/mroute=2Eh</spa=
n><br><span>+++ b/src/openvpn/mroute=2Eh</span><br><span>@@ -144,7 +144,7 @=
@</span><br><span> </span><br><span> bool mroute_learnable_address(const st=
ruct mroute_addr *addr, struct gc_arena *gc);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-uint32_t mroute_addr_hash_functio=
n(const void *key, uint32_t iv);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+uint64_t mroute_addr_hash_function(const void *key, uint32_t i=
v);</span><br><span> </span><br><span> bool mroute_addr_compare_function(co=
nst void *key1, const void *key2);</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index 76=
51b4d=2E=2Ef000283 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</span>=
<br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -49,7 +49,7 @@</spa=
n><br><span>     {</span><br><span>         mi-&gt;real=2Eproto =3D sock-&g=
t;info=2Eproto;</span><br><span>         struct hash_element *he;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        const uint32_t hv =3D h=
ash_value(hash, &amp;mi-&gt;real);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const uint64_t hv =3D hash_value(hash, &amp;mi-&gt;r=
eal);</span><br><span>         struct hash_bucket *bucket =3D hash_bucket(h=
ash, hv);</span><br><span> </span><br><span>         multi_assign_peer_id(m=
, mi);</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=
=2Ec</span><br><span>index f919b67=2E=2E9acf297 100644</span><br><span>--- =
a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br=
><span>@@ -281,7 +281,7 @@</span><br><span>     if (mroute_extract_openvpn_=
sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&=
gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span>     {</span><br><span>    =
     struct hash_element *he;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        const uint32_t hv =3D hash_value(hash, &amp;real);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        const uint64_t hv =
=3D hash_value(hash, &amp;real);</span><br><span>         struct hash_bucke=
t *bucket =3D hash_bucket(hash, hv);</span><br><span>         uint8_t *ptr =
=3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>         uint8_t op =
=3D ptr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><span>diff --git a/src/openvp=
n/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 8b36cf7=2E=2Ec429=
3a7 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ =
b/src/openvpn/multi=2Ec</span><br><span>@@ -228,11 +228,11 @@</span><br><sp=
an> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static uint32_t</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static uint64_t</span><br><span> cid=
_hash_function(const void *key, uint32_t iv)</span><br><span> {</span><br><=
span>     const unsigned long *k =3D (const unsigned long *)key;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return (uint32_t)*k;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return (uint64_t)*k;</s=
pan><br><span> }</span><br><span> </span><br><span> static bool</span><br><=
span>@@ -246,19 +246,19 @@</span><br><span> #endif</span><br><span> </span>=
<br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static uint32_t</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static uint64_t</span><br><span> /*</span><br><span>  * inotify w=
atcher descriptors are used as hash value</span><br><span>  */</span><br><s=
pan> int_hash_function(const void *key, uint32_t iv)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (uint32_t)(uin=
tptr_t)key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn (uintptr_t)key;</span><br><span> }</span><br><span> </span><br><span> st=
atic bool</span><br><span> int_compare_function(const void *key1, const voi=
d *key2)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return (unsigned long)key1 =3D=3D (unsigned long)key2;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return (uintptr_t)key1 =3D=
=3D (uintptr_t)key2;</span><br><span> }</span><br><span> #endif</span><br><=
span> </span><br><span>@@ -1012,7 +1012,7 @@</span><br><span>              =
    const unsigned int flags)</span><br><span> {</span><br><span>     struc=
t hash_element *he;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const uint32_t hv =3D hash_value(m-&gt;vhash, addr);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(m-&=
gt;vhash, addr);</span><br><span>     struct hash_bucket *bucket =3D hash_b=
ucket(m-&gt;vhash, hv);</span><br><span>     struct multi_route *oldroute =
=3D NULL;</span><br><span>     struct multi_instance *owner =3D NULL;</span=
><br><span>@@ -3094,7 +3094,7 @@</span><br><span>         goto done;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    const uint32_t hv =3D hash_value(hash, &amp;real);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D h=
ash_value(hash, &amp;real);</span><br><span>     struct hash_bucket *bucket=
 =3D hash_bucket(hash, hv);</span><br><span> </span><br><span>     /* make =
sure that we don&#39;t float to an address taken by another client */</span=
><br><span>@@ -4230,7 +4230,7 @@</span><br><span> multi_unlearn_addr(struct=
 multi_context *m, struct multi_instance *mi, const struct mroute_addr *add=
r)</span><br><span> {</span><br><span>     struct hash_element *he;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    const uint32_t hv =3D has=
h_value(m-&gt;vhash, addr);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const uint64_t hv =3D hash_value(m-&gt;vhash, addr);</span><br>=
<span>     struct hash_bucket *bucket =3D hash_bucket(m-&gt;vhash, hv);</sp=
an><br><span>     struct multi_route *r =3D NULL;</span><br><span> </span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_t=
ests/openvpn/test_misc=2Ec</span><br><span>index a9ae33f=2E=2Eccdfdee 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><s=
pan>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -124,7 =
+124,7 @@</span><br><span> };</span><br><span> </span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static uint32_t</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static uint64_t</span><br><span> wo=
rd_hash_function(const void *key, uint32_t iv)</span><br><span> {</span><br=
><span>     const char *str =3D (const char *)key;</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1570?usp=3Demail">change 1570</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1570?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1570 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> =
Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--0ksCQhI8CN4=--


--===============0911540378206608019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0911540378206608019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0911540378206608019==--

