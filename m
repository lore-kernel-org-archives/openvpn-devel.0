Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D28C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8AmW7u3SQRyvNNCr9+ZP6f3RbXq+QFIe4reRXaU8twc=; b=dbwJvYX+A5iJTP3hXBYO7FqDzM
	4rCPTWz8Gzu/3i198My5dAgPIOFeAFQZqIcBKhBnFAY78pJwMiNzVvBjIM6H2r74xDdAHC4tf4p+u
	Qm3hZxdSaEiz4WUPRH3VdnWV6ka2QueZ6NDqkCsSHazdBzFdwmI9w5ovZGhSlhtnnVlc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we5wM-0004y7-KO;
	Mon, 29 Jun 2026 06:57:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we5wK-0004xq-Ty
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 06:57:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ppmVIiG/fsLgz8OsKyakHozStJkDZPp1zALdbzyZbkk=; b=LL7y22RL2yC0eLpT6oeru2fjBF
 /TsEv2ID+/jP9bSDopr23VD4hMFlu3+YD69A8yal2RM0sw1gg4kUFuNn0BKCftVdd/zJSTgZpsjTR
 aKI8m4RjmaoCRPOpuw746hQZhjhsOSd3rv2ZcYGDXaVo4Exg5b03wkXxv6+7c2vN7L20=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ppmVIiG/fsLgz8OsKyakHozStJkDZPp1zALdbzyZbkk=; b=F
 70xmxO+Vq008buUmfjnDlkFZB9QvMawCiOHcKyBdXLDQ18MpHIYxoXMXfDySKxLt0S1GQj6MMQej4
 YJIIbxn+nBBYH6rDRRQ5/ro8iyYkj91t30f1rwATS1nkhacEZ3wZbTCmvgY9QIJnK//G0stxZ11JK
 SBkI45UVaVEoO9LU=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we5wJ-0004XO-J1 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 06:57:57 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so576396f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 28 Jun 2026 23:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782716264; x=1783321064; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ppmVIiG/fsLgz8OsKyakHozStJkDZPp1zALdbzyZbkk=;
 b=E3hGOjKvt+nPoeYUa08RzoRHEJ//uDX6uZbX7ldSYAnxlzBiiOuXE1N9X7M7OcaUBn
 R0FZQjBq7tCyvKv43ZF55OSmfqtm/9RNk6UB3S5Av5KqE9d9f65BhsggqFZXW6XJo7x6
 d9Gwu/UDqMl4YxvLL2QK1iPX7ynxfTRbibW4r9tRrhXD4k1qmI3uMmuH4WvzlthCWZ5t
 /U8twaTOlLjx6H0GXHyiEXQfXzXxDi6VX863qLmlnTkoyckfdUOQ2ChcLbo8eHQAtsBK
 DvX9k45xEPWFfvJ+vJz4JXzqGi6pJHYLWvDcXcn6NS89yWOvThi1hZWjxhepFT8uOqo4
 yUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782716264; x=1783321064;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ppmVIiG/fsLgz8OsKyakHozStJkDZPp1zALdbzyZbkk=;
 b=fEVQqc8B1AThrY2GAVpVxVwV7Ku4v1zQUEUwzfkQ6uQdeRzsObnYTyOeDmRYsrxvex
 3HkaSu2fbvPFI232ibSNhAhH7AvUF6SqmuoSA7DthvJgzBs0T52sWR+pBtY3+K4FL5Qt
 aWyhygdbVugGrUWqesXRRBsNLlsB9DIWHmwYsktWdPlk7doMYbvBacWJ7f0ubsOIQHTL
 SLfDSiomQLlKfbfCXF7Een4nZD9kkPPOTB73vKjP8/W1N4D9dPdA4paLzNtuaSmE7d2K
 NoO43P5jvAvr0rBT5e7yrGOxqrtbId8gZSu1xAkEaVZSMsLff1Y0YqbsoKISMA+nLdYE
 YdRg==
X-Gm-Message-State: AOJu0YzolRPk20oX6PScAfBbZMagZai0Mk97ZrDf+AglHzeU97y5ZGNL
 TnoCi+j3+ZrceblDQPTJe68G8IUV1gC0Bwznil4z9sDyRqsOjWTo0o9zJJCNyOM+1sHmmSBofE4
 i9IaWTfuB6DovVoYdRPw6bf3+biwlhQmQPi8SMgvH4/59INMIZXaQgPsBSmXGMn92ORg3
X-Gm-Gg: AfdE7cmfbjTrPl4lFxtclLhf6NWYItCAPQo85R+3a1n9uPKjovt+aE0D+f5uOvG3/ai
 nLp8HzoPiSUKXUmoVmOlKtxksQZ5Qf0/H9g1WXXc6IkLVZh79R7Sm+KOpsbbuKH+0TQDm75O1FN
 IIUxoeVsTT4cdQt5BGyUiuyWLLNwg/yAXYLjUljKglW3hLob71lhk2h5cCOqQ4uFDgr1HQ8Tjoj
 5L6euFXjC9nwAqMcllD6eY2F6peB7Ps6LUZ9TW6CNlYopNmg4kY28irStujpYNRgi0d7TAQw+PN
 dYJgR/282O4bKeFKYJIUXS3Izyp7TqC5RXs4DojKed1Fz4fKOI7MlYCeCMlXcdY1LeWYgCI4YLY
 Zf300YI2QUaDscsuxAFT/j+OLlkVxcvQF5jdCMX6qqXG6b6flguyTJln8slCopNjxyUqjmY2yu5
 aVR0jkdpzWlwTHJXmTUu1DbfRgI5XEQH1GAUXPzki3V4ic3b29nBgxNvyHgjpHhdk/W62RryhCn
 bVlHSS0ZUKiPOCWxjm2aB0m39B4YteqvBLEmhdqZXMykgiBW1MEFQeQFlNsAQ+rBfe5HYMWaGVl
 xvU=
X-Received: by 2002:a05:600c:1614:b0:492:4c2e:9613 with SMTP id
 5b1f17b1804b1-4926fc78b99mr114048885e9.18.1782716263726; 
 Sun, 28 Jun 2026 23:57:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49392c991aesm117402915e9.0.2026.06.28.23.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 23:57:43 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 06:57:40 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
X-Gerrit-Change-Number: 1570
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1570?usp=email>
X-Gerrit-Commit: d8536b34d39507a878db107a2098846faf932778
In-Reply-To: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@gerrit.openvpn.net>
References: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkliODE0MDEwN2Y5ODE2NGQyYTJlMTc2OGE2ZDhhYzY1MDE2Y2Q3ZjdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aa6b053f7035051d0c9d277f8375ddd5c2ea55a6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we5wJ-0004XO-J1
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
Content-Type: multipart/mixed; boundary="===============0208533532605615984=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0208533532605615984==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b8fBZZ2i1ZI="; charset=UTF-8

--b8fBZZ2i1ZI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#9) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1570?usp=3Demail =
)


Change subject: Change hash values in our hash map from uint32_t to uin=
t64_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Change =
hash values in our hash map from uint32_t to uint64_t

32 bit architectures=
 are playing a very small role today, so the difference
between 64 bit and =
32 bit hash values is not expected to be large anymore=2E

This is also in =
preparation to replace our hash function with a more modern
replacement=2E
=

Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
Signed-off-by: Arne S=
chwabe <arne@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1570
Message-Id: <20260628210033=2E4583-1-gert@greenie=2Emuc=2Ede>
=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg37349=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
--=
-
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
M src/openvpn/mroute=2Ec
M =
src/openvpn/mroute=2Eh
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/=
openvpn/multi=2Ec
M tests/unit_tests/openvpn/test_misc=2Ec
8 files changed,=
 29 insertions(+), 29 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/70/1570/9

diff --git a/src/openvpn/list=2Ec b=
/src/openvpn/list=2Ec
index f0e9908=2E=2Ec07e764 100644
--- a/src/openvpn/l=
ist=2Ec
+++ b/src/openvpn/list=2Ec
@@ -35,7 +35,7 @@
 
 struct hash *
 hash=
_init(const uint32_t n_buckets, const uint32_t iv,
-          uint32_t (*ha=
sh_function)(const void *key, uint32_t iv),
+          uint64_t (*hash_func=
tion)(const void *key, uint32_t iv),
           bool (*compare_function)(co=
nst void *key1, const void *key2))
 {
     struct hash *h;
@@ -76,7 +76,7 @=
@
 }
 
 struct hash_element *
-hash_lookup_fast(struct hash *hash, struct h=
ash_bucket *bucket, const void *key, uint32_t hv)
+hash_lookup_fast(struct =
hash *hash, struct hash_bucket *bucket, const void *key, uint64_t hv)
 {
  =
   struct hash_element *he;
     struct hash_element *prev =3D NULL;
@@ -10=
4,7 +104,7 @@
 }
 
 bool
-hash_remove_fast(struct hash *hash, struct hash_b=
ucket *bucket, const void *key, uint32_t hv)
+hash_remove_fast(struct hash =
*hash, struct hash_bucket *bucket, const void *key, uint64_t hv)
 {
     st=
ruct hash_element *he;
     struct hash_element *prev =3D NULL;
@@ -136,7 +=
136,7 @@
 bool
 hash_add(struct hash *hash, const void *key, void *value, b=
ool replace)
 {
-    uint32_t hv;
+    uint64_t hv;
     struct hash_bucket=
 *bucket;
     struct hash_element *he;
     bool ret =3D false;
@@ -412,7 =
+412,7 @@
         c ^=3D (b >> 15); \
     }
 
-uint32_t
+uint64_t
 hash_f=
unc(const uint8_t *k, uint32_t length, uint32_t initval)
 {
     uint32_t a=
, b, c, len;
diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh
index=
 04cc3ab=2E=2E06377c6 100644
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn/l=
ist=2Eh
@@ -40,7 +40,7 @@
 {
     void *value;
     const void *key;
-    u=
int32_t hash_value;
+    uint64_t hash_value;
     struct hash_element *nex=
t;
 };
 
@@ -55,13 +55,13 @@
     uint32_t n_elements;
     uint32_t mask;
=
     uint32_t iv;
-    uint32_t (*hash_function)(const void *key, uint32_t =
iv);
+    uint64_t (*hash_function)(const void *key, uint32_t iv);
     boo=
l (*compare_function)(const void *key1, const void *key2); /* return true i=
f equal */
     struct hash_bucket *buckets;
 };
 
 struct hash *hash_init(=
const uint32_t n_buckets, const uint32_t iv,
-                       uint32=
_t (*hash_function)(const void *key, uint32_t iv),
+                       =
uint64_t (*hash_function)(const void *key, uint32_t iv),
                  =
      bool (*compare_function)(const void *key1, const void *key2));
 
 voi=
d hash_free(struct hash *hash);
@@ -69,9 +69,9 @@
 bool hash_add(struct has=
h *hash, const void *key, void *value, bool replace);
 
 struct hash_elemen=
t *hash_lookup_fast(struct hash *hash, struct hash_bucket *bucket,
-       =
                               const void *key, uint32_t hv);
+            =
                          const void *key, uint64_t hv);
 
-bool hash_remov=
e_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uint=
32_t hv);
+bool hash_remove_fast(struct hash *hash, struct hash_bucket *buc=
ket, const void *key, uint64_t hv);
 
 void hash_remove_by_value(struct has=
h *hash, void *value);
 
@@ -98,9 +98,9 @@
 
 void hash_iterator_free(struc=
t hash_iterator *hi);
 
-uint32_t hash_func(const uint8_t *k, uint32_t leng=
th, uint32_t initval);
+uint64_t hash_func(const uint8_t *k, uint32_t lengt=
h, uint32_t initval);
 
-static inline uint32_t
+static inline uint64_t
 ha=
sh_value(const struct hash *hash, const void *key)
 {
     return (*hash->h=
ash_function)(key, hash->iv);
@@ -119,7 +119,7 @@
 }
 
 static inline struc=
t hash_bucket *
-hash_bucket(struct hash *hash, uint32_t hv)
+hash_bucket(s=
truct hash *hash, uint64_t hv)
 {
     return &hash->buckets[hv & hash->mas=
k];
 }
@@ -129,7 +129,7 @@
 {
     void *ret =3D NULL;
     struct hash_ele=
ment *he;
-    uint32_t hv =3D hash_value(hash, key);
+    uint64_t hv =3D =
hash_value(hash, key);
     struct hash_bucket *bucket =3D &hash->buckets[h=
v & hash->mask];
 
     he =3D hash_lookup_fast(hash, bucket, key, hv);
@@ =
-143,7 +143,7 @@
 
 /* NOTE: assumes that key is not a duplicate */
 static=
 inline void
-hash_add_fast(struct hash *hash, struct hash_bucket *bucket, =
const void *key, uint32_t hv,
+hash_add_fast(struct hash *hash, struct hash=
_bucket *bucket, const void *key, uint64_t hv,
               void *value)
=
 {
     struct hash_element *he;
@@ -160,7 +160,7 @@
 static inline bool
 h=
ash_remove(struct hash *hash, const void *key)
 {
-    uint32_t hv;
+    ui=
nt64_t hv;
     struct hash_bucket *bucket;
     bool ret;
 
diff --git a/s=
rc/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index 6fa70a3=2E=2E78c689e 1=
00644
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -354,7 +=
354,7 @@
  * address type, number of bits in the network address,
  * and t=
he actual address=2E
  */
-uint32_t
+uint64_t
 mroute_addr_hash_function(co=
nst void *key, uint32_t iv)
 {
     return hash_func(mroute_addr_hash_ptr((=
const struct mroute_addr *)key),
diff --git a/src/openvpn/mroute=2Eh b/src/=
openvpn/mroute=2Eh
index c8daa15=2E=2E2f5d019 100644
--- a/src/openvpn/mrou=
te=2Eh
+++ b/src/openvpn/mroute=2Eh
@@ -144,7 +144,7 @@
 
 bool mroute_lear=
nable_address(const struct mroute_addr *addr, struct gc_arena *gc);
 
-uint=
32_t mroute_addr_hash_function(const void *key, uint32_t iv);
+uint64_t mro=
ute_addr_hash_function(const void *key, uint32_t iv);
 
 bool mroute_addr_c=
ompare_function(const void *key1, const void *key2);
 
diff --git a/src/ope=
nvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 7651b4d=2E=2Ef000283 100644
--- =
a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -49,7 +49,7 @@
     {
=
         mi->real=2Eproto =3D sock->info=2Eproto;
         struct hash_elem=
ent *he;
-        const uint32_t hv =3D hash_value(hash, &mi->real);
+     =
   const uint64_t hv =3D hash_value(hash, &mi->real);
         struct hash_=
bucket *bucket =3D hash_bucket(hash, hv);
 
         multi_assign_peer_id(m=
, mi);
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index f919b=
67=2E=2E9acf297 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2E=
c
@@ -281,7 +281,7 @@
     if (mroute_extract_openvpn_sockaddr(&real, &m->t=
op=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
     {
       =
  struct hash_element *he;
-        const uint32_t hv =3D hash_value(hash, =
&real);
+        const uint64_t hv =3D hash_value(hash, &real);
         st=
ruct hash_bucket *bucket =3D hash_bucket(hash, hv);
         uint8_t *ptr =
=3D BPTR(&m->top=2Ec2=2Ebuf);
         uint8_t op =3D ptr[0] >> P_OPCODE_SH=
IFT;
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 8b36c=
f7=2E=2Ec4293a7 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=
=2Ec
@@ -228,11 +228,11 @@
 
 #ifdef ENABLE_MANAGEMENT
 
-static uint32_t
+=
static uint64_t
 cid_hash_function(const void *key, uint32_t iv)
 {
     co=
nst unsigned long *k =3D (const unsigned long *)key;
-    return (uint32_t)=
*k;
+    return (uint64_t)*k;
 }
 
 static bool
@@ -246,19 +246,19 @@
 #end=
if
 
 #ifdef ENABLE_ASYNC_PUSH
-static uint32_t
+static uint64_t
 /*
  * in=
otify watcher descriptors are used as hash value
  */
 int_hash_function(co=
nst void *key, uint32_t iv)
 {
-    return (uint32_t)(uintptr_t)key;
+    r=
eturn (uintptr_t)key;
 }
 
 static bool
 int_compare_function(const void *k=
ey1, const void *key2)
 {
-    return (unsigned long)key1 =3D=3D (unsigned =
long)key2;
+    return (uintptr_t)key1 =3D=3D (uintptr_t)key2;
 }
 #endif
 =

@@ -1012,7 +1012,7 @@
                  const unsigned int flags)
 {
     =
struct hash_element *he;
-    const uint32_t hv =3D hash_value(m->vhash, ad=
dr);
+    const uint64_t hv =3D hash_value(m->vhash, addr);
     struct has=
h_bucket *bucket =3D hash_bucket(m->vhash, hv);
     struct multi_route *ol=
droute =3D NULL;
     struct multi_instance *owner =3D NULL;
@@ -3094,7 +30=
94,7 @@
         goto done;
     }
 
-    const uint32_t hv =3D hash_value(=
hash, &real);
+    const uint64_t hv =3D hash_value(hash, &real);
     stru=
ct hash_bucket *bucket =3D hash_bucket(hash, hv);
 
     /* make sure that =
we don't float to an address taken by another client */
@@ -4230,7 +4230,7 =
@@
 multi_unlearn_addr(struct multi_context *m, struct multi_instance *mi, =
const struct mroute_addr *addr)
 {
     struct hash_element *he;
-    const=
 uint32_t hv =3D hash_value(m->vhash, addr);
+    const uint64_t hv =3D has=
h_value(m->vhash, addr);
     struct hash_bucket *bucket =3D hash_bucket(m-=
>vhash, hv);
     struct multi_route *r =3D NULL;
 
diff --git a/tests/unit=
_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index=
 a9ae33f=2E=2Eccdfdee 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+=
++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -124,7 +124,7 @@
 };
 
 
-st=
atic uint32_t
+static uint64_t
 word_hash_function(const void *key, uint32_=
t iv)
 {
     const char *str =3D (const char *)key;

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1570?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f=
7c
Gerrit-Change-Number: 1570
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--b8fBZZ2i1ZI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #9</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1570?usp=3De=
mail">View Change</a></p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">Change hash values in our hash map f=
rom uint32_t to uint64_t<br><br>32 bit architectures are playing a very sma=
ll role today, so the difference<br>between 64 bit and 32 bit hash values i=
s not expected to be large anymore=2E<br><br>This is also in preparation to=
 replace our hash function with a more modern<br>replacement=2E<br><br>Chan=
ge-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c<br>Signed-off-by: Arne Sch=
wabe &lt;arne@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1570<br>Message-Id: &lt;20260628210033=2E4583-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg37349=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/list=2Ec<br>M src/openvpn=
/list=2Eh<br>M src/openvpn/mroute=2Ec<br>M src/openvpn/mroute=2Eh<br>M src/=
openvpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M =
tests/unit_tests/openvpn/test_misc=2Ec<br>8 files changed, 29 insertions(+)=
, 29 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/70/1570/9</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/list=2Ec b/src/openvpn/list=2Ec</span><br><span>index f0e9908=2E=2Ec07e7=
64 100644</span><br><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/=
src/openvpn/list=2Ec</span><br><span>@@ -35,7 +35,7 @@</span><br><span> </s=
pan><br><span> struct hash *</span><br><span> hash_init(const uint32_t n_bu=
ckets, const uint32_t iv,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-          uint32_t (*hash_function)(const void *key, uint32_t iv),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+          uint64_t (*has=
h_function)(const void *key, uint32_t iv),</span><br><span>           bool =
(*compare_function)(const void *key1, const void *key2))</span><br><span> {=
</span><br><span>     struct hash *h;</span><br><span>@@ -76,7 +76,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> struct hash_element *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_lookup_fast(struct =
hash *hash, struct hash_bucket *bucket, const void *key, uint32_t hv)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_lookup_fast(struct h=
ash *hash, struct hash_bucket *bucket, const void *key, uint64_t hv)</span>=
<br><span> {</span><br><span>     struct hash_element *he;</span><br><span>=
     struct hash_element *prev =3D NULL;</span><br><span>@@ -104,7 +104,7 @=
@</span><br><span> }</span><br><span> </span><br><span> bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-hash_remove_fast(struct hash *hash, =
struct hash_bucket *bucket, const void *key, uint32_t hv)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+hash_remove_fast(struct hash *hash, s=
truct hash_bucket *bucket, const void *key, uint64_t hv)</span><br><span> {=
</span><br><span>     struct hash_element *he;</span><br><span>     struct =
hash_element *prev =3D NULL;</span><br><span>@@ -136,7 +136,7 @@</span><br>=
<span> bool</span><br><span> hash_add(struct hash *hash, const void *key, v=
oid *value, bool replace)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    uint32_t hv;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    uint64_t hv;</span><br><span>     struct hash_bucke=
t *bucket;</span><br><span>     struct hash_element *he;</span><br><span>  =
   bool ret =3D false;</span><br><span>@@ -412,7 +412,7 @@</span><br><span>=
         c ^=3D (b &gt;&gt; 15); \</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint32_t</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br><span> hash_f=
unc(const uint8_t *k, uint32_t length, uint32_t initval)</span><br><span> {=
</span><br><span>     uint32_t a, b, c, len;</span><br><span>diff --git a/s=
rc/openvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>index 04cc3ab=2E=
=2E06377c6 100644</span><br><span>--- a/src/openvpn/list=2Eh</span><br><spa=
n>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -40,7 +40,7 @@</span><br><s=
pan> {</span><br><span>     void *value;</span><br><span>     const void *k=
ey;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t hash_=
value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t =
hash_value;</span><br><span>     struct hash_element *next;</span><br><span=
> };</span><br><span> </span><br><span>@@ -55,13 +55,13 @@</span><br><span>=
     uint32_t n_elements;</span><br><span>     uint32_t mask;</span><br><sp=
an>     uint32_t iv;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   uint32_t (*hash_function)(const void *key, uint32_t iv);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uint64_t (*hash_function)(const=
 void *key, uint32_t iv);</span><br><span>     bool (*compare_function)(con=
st void *key1, const void *key2); /* return true if equal */</span><br><spa=
n>     struct hash_bucket *buckets;</span><br><span> };</span><br><span> </=
span><br><span> struct hash *hash_init(const uint32_t n_buckets, const uint=
32_t iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
          uint32_t (*hash_function)(const void *key, uint32_t iv),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                       uint6=
4_t (*hash_function)(const void *key, uint32_t iv),</span><br><span>       =
                 bool (*compare_function)(const void *key1, const void *key=
2));</span><br><span> </span><br><span> void hash_free(struct hash *hash);<=
/span><br><span>@@ -69,9 +69,9 @@</span><br><span> bool hash_add(struct has=
h *hash, const void *key, void *value, bool replace);</span><br><span> </sp=
an><br><span> struct hash_element *hash_lookup_fast(struct hash *hash, stru=
ct hash_bucket *bucket,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                      const void *key, uint32_t hv);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
              const void *key, uint64_t hv);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-bool hash_remove_fast(struct hash =
*hash, struct hash_bucket *bucket, const void *key, uint32_t hv);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bool hash_remove_fast(struct =
hash *hash, struct hash_bucket *bucket, const void *key, uint64_t hv);</spa=
n><br><span> </span><br><span> void hash_remove_by_value(struct hash *hash,=
 void *value);</span><br><span> </span><br><span>@@ -98,9 +98,9 @@</span><b=
r><span> </span><br><span> void hash_iterator_free(struct hash_iterator *hi=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-u=
int32_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t hash_func(cons=
t uint8_t *k, uint32_t length, uint32_t initval);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-static inline uint32_t</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static inline uint64_t</sp=
an><br><span> hash_value(const struct hash *hash, const void *key)</span><b=
r><span> {</span><br><span>     return (*hash-&gt;hash_function)(key, hash-=
&gt;iv);</span><br><span>@@ -119,7 +119,7 @@</span><br><span> }</span><br><=
span> </span><br><span> static inline struct hash_bucket *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-hash_bucket(struct hash *hash, uint32_=
t hv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_bucket(st=
ruct hash *hash, uint64_t hv)</span><br><span> {</span><br><span>     retur=
n &amp;hash-&gt;buckets[hv &amp; hash-&gt;mask];</span><br><span> }</span><=
br><span>@@ -129,7 +129,7 @@</span><br><span> {</span><br><span>     void *=
ret =3D NULL;</span><br><span>     struct hash_element *he;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    uint32_t hv =3D hash_value(hash, =
key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t h=
v =3D hash_value(hash, key);</span><br><span>     struct hash_bucket *bucke=
t =3D &amp;hash-&gt;buckets[hv &amp; hash-&gt;mask];</span><br><span> </spa=
n><br><span>     he =3D hash_lookup_fast(hash, bucket, key, hv);</span><br>=
<span>@@ -143,7 +143,7 @@</span><br><span> </span><br><span> /* NOTE: assum=
es that key is not a duplicate */</span><br><span> static inline void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_add_fast(struct hash *=
hash, struct hash_bucket *bucket, const void *key, uint32_t hv,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+hash_add_fast(struct hash *hash=
, struct hash_bucket *bucket, const void *key, uint64_t hv,</span><br><span=
>               void *value)</span><br><span> {</span><br><span>     struct=
 hash_element *he;</span><br><span>@@ -160,7 +160,7 @@</span><br><span> sta=
tic inline bool</span><br><span> hash_remove(struct hash *hash, const void =
*key)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    uint32_t hv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint64_t hv;</span><br><span>     struct hash_bucket *bucket;</span><br=
><span>     bool ret;</span><br><span> </span><br><span>diff --git a/src/op=
envpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br><span>index 6fa70a3=2E=
=2E78c689e 100644</span><br><span>--- a/src/openvpn/mroute=2Ec</span><br><s=
pan>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@ -354,7 +354,7 @@</span>=
<br><span>  * address type, number of bits in the network address,</span><b=
r><span>  * and the actual address=2E</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-uint32_t</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+uint64_t</span><br><span> mroute_addr_hash_functi=
on(const void *key, uint32_t iv)</span><br><span> {</span><br><span>     re=
turn hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),</span=
><br><span>diff --git a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh</sp=
an><br><span>index c8daa15=2E=2E2f5d019 100644</span><br><span>--- a/src/op=
envpn/mroute=2Eh</span><br><span>+++ b/src/openvpn/mroute=2Eh</span><br><sp=
an>@@ -144,7 +144,7 @@</span><br><span> </span><br><span> bool mroute_learn=
able_address(const struct mroute_addr *addr, struct gc_arena *gc);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint32_t mro=
ute_addr_hash_function(const void *key, uint32_t iv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+uint64_t mroute_addr_hash_function(const =
void *key, uint32_t iv);</span><br><span> </span><br><span> bool mroute_add=
r_compare_function(const void *key1, const void *key2);</span><br><span> </=
span><br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</sp=
an><br><span>index 7651b4d=2E=2Ef000283 100644</span><br><span>--- a/src/op=
envpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@=
@ -49,7 +49,7 @@</span><br><span>     {</span><br><span>         mi-&gt;rea=
l=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span>         struct hash_e=
lement *he;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        co=
nst uint32_t hv =3D hash_value(hash, &amp;mi-&gt;real);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const uint64_t hv =3D hash_valu=
e(hash, &amp;mi-&gt;real);</span><br><span>         struct hash_bucket *buc=
ket =3D hash_bucket(hash, hv);</span><br><span> </span><br><span>         m=
ulti_assign_peer_id(m, mi);</span><br><span>diff --git a/src/openvpn/mudp=
=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index f919b67=2E=2E9acf297 1006=
44</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/ope=
nvpn/mudp=2Ec</span><br><span>@@ -281,7 +281,7 @@</span><br><span>     if (=
mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edes=
t, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span>    =
 {</span><br><span>         struct hash_element *he;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const uint32_t hv =3D hash_value(ha=
sh, &amp;real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    const uint64_t hv =3D hash_value(hash, &amp;real);</span><br><span>    =
     struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span>=
         uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>=
         uint8_t op =3D ptr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><span>dif=
f --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>ind=
ex 8b36cf7=2E=2Ec4293a7 100644</span><br><span>--- a/src/openvpn/multi=2Ec<=
/span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -228,11 +228=
,11 @@</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static uint3=
2_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static uint64_t<=
/span><br><span> cid_hash_function(const void *key, uint32_t iv)</span><br>=
<span> {</span><br><span>     const unsigned long *k =3D (const unsigned lo=
ng *)key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (=
uint32_t)*k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn (uint64_t)*k;</span><br><span> }</span><br><span> </span><br><span> sta=
tic bool</span><br><span>@@ -246,19 +246,19 @@</span><br><span> #endif</spa=
n><br><span> </span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static uint32_t</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static uint64_t</span><br><span> /*</span><br=
><span>  * inotify watcher descriptors are used as hash value</span><br><sp=
an>  */</span><br><span> int_hash_function(const void *key, uint32_t iv)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn (uint32_t)(uintptr_t)key;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return (uintptr_t)key;</span><br><span> }</span><br><span> =
</span><br><span> static bool</span><br><span> int_compare_function(const v=
oid *key1, const void *key2)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return (unsigned long)key1 =3D=3D (unsigned l=
ong)key2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 (uintptr_t)key1 =3D=3D (uintptr_t)key2;</span><br><span> }</span><br><span=
> #endif</span><br><span> </span><br><span>@@ -1012,7 +1012,7 @@</span><br>=
<span>                  const unsigned int flags)</span><br><span> {</span>=
<br><span>     struct hash_element *he;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    const uint32_t hv =3D hash_value(m-&gt;vhash, addr);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t h=
v =3D hash_value(m-&gt;vhash, addr);</span><br><span>     struct hash_bucke=
t *bucket =3D hash_bucket(m-&gt;vhash, hv);</span><br><span>     struct mul=
ti_route *oldroute =3D NULL;</span><br><span>     struct multi_instance *ow=
ner =3D NULL;</span><br><span>@@ -3094,7 +3094,7 @@</span><br><span>       =
  goto done;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const uint32_t hv =3D hash_value(hash, =
&amp;real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t uint64_t hv =3D hash_value(hash, &amp;real);</span><br><span>     struct =
hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span> </span><br>=
<span>     /* make sure that we don&#39;t float to an address taken by anot=
her client */</span><br><span>@@ -4230,7 +4230,7 @@</span><br><span> multi_=
unlearn_addr(struct multi_context *m, struct multi_instance *mi, const stru=
ct mroute_addr *addr)</span><br><span> {</span><br><span>     struct hash_e=
lement *he;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
uint32_t hv =3D hash_value(m-&gt;vhash, addr);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(m-&gt;vhash=
, addr);</span><br><span>     struct hash_bucket *bucket =3D hash_bucket(m-=
&gt;vhash, hv);</span><br><span>     struct multi_route *r =3D NULL;</span>=
<br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=
=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index a9ae33f=
=2E=2Eccdfdee 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_mi=
sc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><=
br><span>@@ -124,7 +124,7 @@</span><br><span> };</span><br><span> </span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static uint3=
2_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static uint64_t<=
/span><br><span> word_hash_function(const void *key, uint32_t iv)</span><br=
><span> {</span><br><span>     const char *str =3D (const char *)key;</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1570?usp=3Demail">change 1570</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1570?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib8140107f98164d2a2e176=
8a6d8ac65016cd7f7c </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1570 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</b=
ody></html>
--b8fBZZ2i1ZI=--


--===============0208533532605615984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0208533532605615984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0208533532605615984==--

