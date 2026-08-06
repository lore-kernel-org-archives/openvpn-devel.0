Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70824C55ABF
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zzcKdzJH3NtnBBlvkSvYdOCepkjBUaJ5kGu7931wopo=; b=IsL7ERN71DWqHDFfQVxCd1Z1NE
	zUTIYqxtwpI5MxUzh/x9IgcGULNnxi+XixQ53jlw+u/sZTXeW4yuc1RRF13yYZEVqnP1srURL6ZDl
	uQmHUqZh+ZJ5Si2Qs/yAempUQeoVQHRKG6yVzVjh1210QUE5ENGfv4dt02pZpydScjmU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrw25-0003PK-MX;
	Thu, 06 Aug 2026 11:13:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrw24-0003PE-RS
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:13:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YRkXNS+TcG1SsPHNqVhBZARurEaUfilL8tn4oyiVMiI=; b=XA1ajF7k7fvJGxLBeuAqEwtMLz
 2bPAtRMa4AtXV/zTmNlcmMbcwlAHIUcnOKOMpVvchwJGJokhiZN0cAESJWd/dUGKPNUKkQceZ2ki9
 ZsYaASUVrNBCDYN+sL3OvghM8o01Rk2lKMVFdjkko19gEMZVRUt41KTKAKH1xT+/a5v8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YRkXNS+TcG1SsPHNqVhBZARurEaUfilL8tn4oyiVMiI=; b=F
 xql/V1v9JlR+4Q9lv/tM3NmhMnOzd9g3SiIOsq7JmNdr9db4KqInK+kaM91ZShowDxASSl/kkKJxX
 qKosRRVRA2zPrSviz95M3s22RVwkmPP+Y6bvnSdLVxysfLonj9AeRRl8PMOtjMedK6MR9eJsffQBu
 MaYVccd7f/d4dtdM=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrw23-0005dV-0N for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:13:04 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47fdd674e17so1297001f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 04:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786014776; x=1786619576; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YRkXNS+TcG1SsPHNqVhBZARurEaUfilL8tn4oyiVMiI=;
 b=MXTGTeznZlwUw8xgs5lRY9F93dpRnSRJ2DgXe+33lNvRw8IV/xCLDS8g2dzFujRVvV
 SLvSLtahRKdx9o6v+YAxb9KyW3mmfrvS0OOJJEJzhuBC37cLQV7UaxRwqBx6wszqn3Se
 Z5m/zzr3uO3cLXhLnfVM/mUUEhUPB9uBoASManuQHhGismIyaVjH6Hd7SCqp0Mw2+CsU
 pOFl1Hwfglm8tTCjbRZ4TQ1mLMgXZrsASqgOlCmC559pyw4ylX7GA6Uo6ij9b8atsaX7
 W6K2bLJw1YgBhMrXwSMdatUtvyGjz1OGOT9V7LKM7ZzDgUCmDq3gPjFzcod4MiUoP/AI
 VLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786014776; x=1786619576;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YRkXNS+TcG1SsPHNqVhBZARurEaUfilL8tn4oyiVMiI=;
 b=DUA6TiDn0djezZp8ZMNz5OFTeQwP5SM5s61HOiwMshjNqWrt1cLmVnB6uY/ejwYP1J
 rkvhUmROa9ngZ/XnnH/q7pHwzJeC6K5+2h+1ojTPdVTH9g8MlsQaQl9uAbe/nbJNmfat
 n2hY/1hE3i7BjqfpSSE74ROZXF6OYPpRU+C/LE5lBHp0lq/cdEboValmvi0ImXFmJBpo
 pMf34cu1VT1t3Srmtrj6FsHIZ/a9DFptcLMzdR4tp66/sQIfYhwsCNuczWsAo4Gwc4za
 HHsaWnZwANWErvV6ftrM7cKGWfgir63eCGfFQBO9yN+i5sLjvVTyL/fGpDVck7pfAec6
 9Enw==
X-Gm-Message-State: AOJu0Yz9b2SfruBX/N8tmYrW838fXCstQlDmcZZ7tIggMNS0FyYVTY19
 UFMk4t7LkLHdnF62u6wLo6XegzOrvpa7PzE4/tK+jrpR/loW9UE6hLcW1yuka6XKArQe+l+1Qms
 EOCJPx12dqQ7CvqtyHwmG6/flVnSkWhTXeMUYIBXOVM7o+EHOJ1cLjKicTUvm3bFFYkao
X-Gm-Gg: AR+sD12lcCqYZAcsQbq9FjGDNliTSzCgbskENnqzqv4n4qJDkFCQKeRT0oQh0nfO3zZ
 Upabbaud2wiRvIuFuPMQzUL9twq1OUCbfNW+ErCKNyxDvxjjLsa+T5vr6VEoBzB5oZYxL/goxn+
 DWxCGS+XNXRWyCvHxrf9kfwQ//6z6zZvjbXE3kqwv+A52FkyZEf6vkv8PlA5q8EPQezODQZ/Vsm
 AB0Ob5x48I3na2bJ65V3ebpOVpUc6NZ1PJwzOygYpMt9wFT9EM5R6eHEU6vljU7U82X9aalJs5Z
 XH/KGtF6aAj0u1hZJ3Gx4oRA6iVjUrZ4r0oDXqPulkOug/U04+STqGYq0V12Lrq08ZDL0eWTGgW
 3c5fye3505Kg6EKRVBVzIipQv7kR2PfFiVH9f20EkZs2ZUhgG5p78WMucaDL5P4yvI0urCGTMb7
 vOXrI0AsiJAilVBtg+VZC7La34/zJ91woLvsPw6hp/7OdNFiR06xFVSCIgGNodPph4RmD1ePxHO
 Mwmz0TWQbLxJINtmwEYKVuJ1fRnMRa84rqZkbe8OFPeD0Z5XNOaV98va0Jl6+PFiezd6n4CZY0Z
 /xRRkCvfEqSeGh54/353Vn1itdFP1pce8J6UywHgT6beidaxv44=
X-Received: by 2002:a05:600c:8116:b0:495:3da3:beb with SMTP id
 5b1f17b1804b1-4994e7b74a2mr208480315e9.10.1786014776133; 
 Thu, 06 Aug 2026 04:12:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542858b2sm61883915e9.14.2026.08.06.04.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 04:12:55 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 11:12:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: d1106970f76e955b0a5fa19b566e97bba98d4c9b
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b6d052a113e4819574930c9161e601a7a1534c92-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrw23-0005dV-0N
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8780199609510284295=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8780199609510284295==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Aui9i52ECtQ="; charset=UTF-8

--Aui9i52ECtQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#22) to the change originally created b=
y plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail=
 )

The following approvals got outdated and were removed:
Code-Review+2 by=
 flichtenheld


Change subject: Change hash iv to a be a fixed sized array
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Change hash i=
v to a be a fixed sized array

While for our own hash function, always usin=
g an uint32_t works well, it does
not work very well if we move to another =
hash function like siphash that
requires a larger key=2E

To avoid allocati=
ng a specific context, change the API to be a fixed size
array of size 4=2E=
 This define allows use to easily change it to a larger
value if we use has=
h functions that require larger keys=2E

Change-Id: If47c7d920b2fa4047b7db0=
3fcde821899839324d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-b=
y: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1571
Message-Id: <20260806102926=2E28206-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg38162=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
M src=
/openvpn/mroute=2Ec
M src/openvpn/mroute=2Eh
M src/openvpn/multi=2Ec
M test=
s/unit_tests/openvpn/test_misc=2Ec
6 files changed, 32 insertions(+), 23 de=
letions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/71/1571/22

diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
i=
ndex c07e764=2E=2Ee52c778 100644
--- a/src/openvpn/list=2Ec
+++ b/src/openv=
pn/list=2Ec
@@ -29,13 +29,15 @@
 
 #include "integer=2Eh"
 #include "list=
=2Eh"
+
+#include "crypto=2Eh"
 #include "misc=2Eh"
 
 #include "memdbg=2Eh=
"
 
 struct hash *
-hash_init(const uint32_t n_buckets, const uint32_t iv,
=
-          uint64_t (*hash_function)(const void *key, uint32_t iv),
+hash_i=
nit(const uint32_t n_buckets,
+          uint64_t (*hash_function)(const vo=
id *key, const uint8_t hash_key[HASH_KEY_LEN]),
           bool (*compare_f=
unction)(const void *key1, const void *key2))
 {
     struct hash *h;
@@ -4=
6,7 +48,10 @@
     h->mask =3D h->n_buckets - 1;
     h->hash_function =3D =
hash_function;
     h->compare_function =3D compare_function;
-    h->iv =
=3D iv;
+
+    /* create random hash key */
+    prng_bytes(h->hash_key, si=
zeof(h->hash_key));
+
     ALLOC_ARRAY(h->buckets, struct hash_bucket, h->n=
_buckets);
     for (uint32_t i =3D 0; i < h->n_buckets; ++i)
     {
diff -=
-git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh
index 06377c6=2E=2Ecbf1a=
bf 100644
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -49,19 +=
49,24 @@
     struct hash_element *list;
 };
 
+
+#define HASH_KEY_LEN 4
+
=
 struct hash
 {
     uint32_t n_buckets;
     uint32_t n_elements;
     uin=
t32_t mask;
-    uint32_t iv;
-    uint64_t (*hash_function)(const void *ke=
y, uint32_t iv);
+    /** key/iv used for the hash function=2E No to be con=
fused with the (key, value)
+     * keys for the actual hash map entries */=

+    uint8_t hash_key[HASH_KEY_LEN];
+    uint64_t (*hash_function)(const =
void *key, const uint8_t hash_key[HASH_KEY_LEN]);
     bool (*compare_funct=
ion)(const void *key1, const void *key2); /* return true if equal */
     s=
truct hash_bucket *buckets;
 };
 
-struct hash *hash_init(const uint32_t n_=
buckets, const uint32_t iv,
-                       uint64_t (*hash_functio=
n)(const void *key, uint32_t iv),
+struct hash *hash_init(const uint32_t n_=
buckets,
+                       uint64_t (*hash_function)(const void *key,=
 const uint8_t hash_key[HASH_KEY_LEN]),
                        bool (*comp=
are_function)(const void *key1, const void *key2));
 
 void hash_free(struc=
t hash *hash);
@@ -103,7 +108,7 @@
 static inline uint64_t
 hash_value(cons=
t struct hash *hash, const void *key)
 {
-    return (*hash->hash_function)=
(key, hash->iv);
+    return (*hash->hash_function)(key, hash->hash_key);
 =
}
 
 static inline uint32_t
diff --git a/src/openvpn/mroute=2Ec b/src/openv=
pn/mroute=2Ec
index 78c689e=2E=2Ea5179d0 100644
--- a/src/openvpn/mroute=2E=
c
+++ b/src/openvpn/mroute=2Ec
@@ -355,10 +355,10 @@
  * and the actual add=
ress=2E
  */
 uint64_t
-mroute_addr_hash_function(const void *key, uint32_t=
 iv)
+mroute_addr_hash_function(const void *key, const uint8_t hash_key[HAS=
H_KEY_LEN])
 {
     return hash_func(mroute_addr_hash_ptr((const struct mro=
ute_addr *)key),
-                     mroute_addr_hash_len((const struct m=
route_addr *)key), iv);
+                     mroute_addr_hash_len((const s=
truct mroute_addr *)key), *(uint32_t *)hash_key);
 }
 
 bool
diff --git a/s=
rc/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh
index 2f5d019=2E=2E639281b 1=
00644
--- a/src/openvpn/mroute=2Eh
+++ b/src/openvpn/mroute=2Eh
@@ -144,7 +=
144,7 @@
 
 bool mroute_learnable_address(const struct mroute_addr *addr, s=
truct gc_arena *gc);
 
-uint64_t mroute_addr_hash_function(const void *key,=
 uint32_t iv);
+uint64_t mroute_addr_hash_function(const void *key, const u=
int8_t hash_key[HASH_KEY_LEN]);
 
 bool mroute_addr_compare_function(const =
void *key1, const void *key2);
 
diff --git a/src/openvpn/multi=2Ec b/src/o=
penvpn/multi=2Ec
index fe2badb=2E=2Ea4e9c1c 100644
--- a/src/openvpn/multi=
=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -229,7 +229,7 @@
 #ifdef ENABLE_MANAGEM=
ENT
 
 static uint64_t
-cid_hash_function(const void *key, uint32_t iv)
+ci=
d_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
 =
    const unsigned long *k =3D (const unsigned long *)key;
     return (uin=
t64_t)*k;
@@ -250,7 +250,7 @@
 /*
  * inotify watcher descriptors are used =
as hash value
  */
-int_hash_function(const void *key, uint32_t iv)
+int_ha=
sh_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
     =
return (uintptr_t)key;
 }
@@ -290,18 +290,18 @@
      * to determine which =
client sent an incoming packet
      * which is seen on the TCP/UDP socket=
=2E
      */
-    m->hash =3D hash_init(t->options=2Ereal_hash_size, (uint3=
2_t)get_random(),
+    m->hash =3D hash_init(t->options=2Ereal_hash_size,
 =
                        mroute_addr_hash_function, mroute_addr_compare_func=
tion);
 
     /*
      * Virtual address hash table=2E  Used to determine
 =
     * which client to route a packet to=2E
      */
-    m->vhash =3D hash=
_init(t->options=2Evirtual_hash_size, (uint32_t)get_random(),
+    m->vhash=
 =3D hash_init(t->options=2Evirtual_hash_size,
                          mr=
oute_addr_hash_function, mroute_addr_compare_function);
 
 #ifdef ENABLE_MA=
NAGEMENT
-    m->cid_hash =3D hash_init(t->options=2Ereal_hash_size, 0, cid=
_hash_function, cid_compare_function);
+    m->cid_hash =3D hash_init(t->op=
tions=2Ereal_hash_size, cid_hash_function, cid_compare_function);
 #endif
 =

 #ifdef ENABLE_ASYNC_PUSH
@@ -309,8 +309,8 @@
      * Mapping between inot=
ify watch descriptors and
      * multi_instances=2E
      */
-    m->inoti=
fy_watchers =3D hash_init(t->options=2Ereal_hash_size, (uint32_t)get_random=
(),
-                                    int_hash_function, int_compare_fun=
ction);
+    m->inotify_watchers =3D
+        hash_init(t->options=2Ereal_h=
ash_size, int_hash_function, int_compare_function);
 #endif
 
     /*
diff =
--git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/t=
est_misc=2Ec
index 4d046ce=2E=2E3ebbfc1 100644
--- a/tests/unit_tests/openv=
pn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -131,11 +1=
31,11 @@
 
 
 static uint64_t
-word_hash_function(const void *key, uint32_t=
 iv)
+word_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_L=
EN])
 {
     const char *str =3D (const char *)key;
     const uint32_t len=
 =3D (uint32_t)strlen(str);
-    return hash_func((const uint8_t *)str, len=
, iv);
+    return hash_func((const uint8_t *)str, len, *(uint32_t *)(hash_=
key));
 }
 
 static bool
@@ -170,10 +170,9 @@
      * Test the hash code by=
 implementing a simple
      * word frequency algorithm=2E
      */
-
     =
struct gc_arena gc =3D gc_new();
-    struct hash *hash =3D hash_init(10000=
, get_random(), word_hash_function, word_compare_function);
-    struct has=
h *nhash =3D hash_init(256, get_random(), word_hash_function, word_compare_=
function);
+    struct hash *hash =3D hash_init(10000, word_hash_function, =
word_compare_function);
+    struct hash *nhash =3D hash_init(256, word_has=
h_function, word_compare_function);
 
     printf("hash_init n_buckets=3D%u=
 mask=3D0x%08x\n", hash->n_buckets, hash->mask);
 

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d=

Gerrit-Change-Number: 1571
Gerrit-PatchSet: 22
Gerrit-Owner: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Aui9i52ECtQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #22</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Change hash iv to a =
be a fixed sized array<br><br>While for our own hash function, always using=
 an uint32_t works well, it does<br>not work very well if we move to anothe=
r hash function like siphash that<br>requires a larger key=2E<br><br>To avo=
id allocating a specific context, change the API to be a fixed size<br>arra=
y of size 4=2E This define allows use to easily change it to a larger<br>va=
lue if we use hash functions that require larger keys=2E<br><br>Change-Id: =
If47c7d920b2fa4047b7db03fcde821899839324d<br>Signed-off-by: Arne Schwabe &l=
t;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571=
<br>Message-Id: &lt;20260806102926=2E28206-1-gert@greenie=2Emuc=2Ede&gt;<br=
>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg38162=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M s=
rc/openvpn/mroute=2Ec<br>M src/openvpn/mroute=2Eh<br>M src/openvpn/multi=2E=
c<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>6 files changed, 32 insert=
ions(+), 23 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1571/22</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/list=2Ec b/src/openvpn/list=2Ec</span><br><span>index c07e764=
=2E=2Ee52c778 100644</span><br><span>--- a/src/openvpn/list=2Ec</span><br><=
span>+++ b/src/openvpn/list=2Ec</span><br><span>@@ -29,13 +29,15 @@</span><=
br><span> </span><br><span> #include &quot;integer=2Eh&quot;</span><br><spa=
n> #include &quot;list=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;crypto=2Eh&quot;</span><br><span> #include &quot;misc=2Eh&quot;</s=
pan><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br>=
<span> </span><br><span> struct hash *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-hash_init(const uint32_t n_buckets, const uint32_t iv,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-          uint64_t (*hash=
_function)(const void *key, uint32_t iv),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+hash_init(const uint32_t n_buckets,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+          uint64_t (*hash_function)(c=
onst void *key, const uint8_t hash_key[HASH_KEY_LEN]),</span><br><span>    =
       bool (*compare_function)(const void *key1, const void *key2))</span>=
<br><span> {</span><br><span>     struct hash *h;</span><br><span>@@ -46,7 =
+48,10 @@</span><br><span>     h-&gt;mask =3D h-&gt;n_buckets - 1;</span><b=
r><span>     h-&gt;hash_function =3D hash_function;</span><br><span>     h-=
&gt;compare_function =3D compare_function;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    h-&gt;iv =3D iv;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* create random hash key */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    prng_bytes(h-&gt;hash_key, sizeof(h-&gt;hash_key));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     A=
LLOC_ARRAY(h-&gt;buckets, struct hash_bucket, h-&gt;n_buckets);</span><br><=
span>     for (uint32_t i =3D 0; i &lt; h-&gt;n_buckets; ++i)</span><br><sp=
an>     {</span><br><span>diff --git a/src/openvpn/list=2Eh b/src/openvpn/l=
ist=2Eh</span><br><span>index 06377c6=2E=2Ecbf1abf 100644</span><br><span>-=
-- a/src/openvpn/list=2Eh</span><br><span>+++ b/src/openvpn/list=2Eh</span>=
<br><span>@@ -49,19 +49,24 @@</span><br><span>     struct hash_element *lis=
t;</span><br><span> };</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define HASH_KEY_LEN 4</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> struct hash</span><br><span> {</span><br><span>     =
uint32_t n_buckets;</span><br><span>     uint32_t n_elements;</span><br><sp=
an>     uint32_t mask;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    uint32_t iv;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
uint64_t (*hash_function)(const void *key, uint32_t iv);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /** key/iv used for the hash funct=
ion=2E No to be confused with the (key, value)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * keys for the actual hash map entries */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t hash_key[=
HASH_KEY_LEN];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int64_t (*hash_function)(const void *key, const uint8_t hash_key[HASH_KEY_L=
EN]);</span><br><span>     bool (*compare_function)(const void *key1, const=
 void *key2); /* return true if equal */</span><br><span>     struct hash_b=
ucket *buckets;</span><br><span> };</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-struct hash *hash_init(const uint32_t n_buc=
kets, const uint32_t iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                       uint64_t (*hash_function)(const void *key, uint32=
_t iv),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct hash =
*hash_init(const uint32_t n_buckets,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                       uint64_t (*hash_function)(const voi=
d *key, const uint8_t hash_key[HASH_KEY_LEN]),</span><br><span>            =
            bool (*compare_function)(const void *key1, const void *key2));<=
/span><br><span> </span><br><span> void hash_free(struct hash *hash);</span=
><br><span>@@ -103,7 +108,7 @@</span><br><span> static inline uint64_t</spa=
n><br><span> hash_value(const struct hash *hash, const void *key)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (=
*hash-&gt;hash_function)(key, hash-&gt;iv);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return (*hash-&gt;hash_function)(key, hash-&gt;=
hash_key);</span><br><span> }</span><br><span> </span><br><span> static inl=
ine uint32_t</span><br><span>diff --git a/src/openvpn/mroute=2Ec b/src/open=
vpn/mroute=2Ec</span><br><span>index 78c689e=2E=2Ea5179d0 100644</span><br>=
<span>--- a/src/openvpn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mroute=
=2Ec</span><br><span>@@ -355,10 +355,10 @@</span><br><span>  * and the actu=
al address=2E</span><br><span>  */</span><br><span> uint64_t</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-mroute_addr_hash_function(const void=
 *key, uint32_t iv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
mroute_addr_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_=
LEN])</span><br><span> {</span><br><span>     return hash_func(mroute_addr_=
hash_ptr((const struct mroute_addr *)key),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                     mroute_addr_hash_len((const struc=
t mroute_addr *)key), iv);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                     mroute_addr_hash_len((const struct mroute_addr =
*)key), *(uint32_t *)hash_key);</span><br><span> }</span><br><span> </span>=
<br><span> bool</span><br><span>diff --git a/src/openvpn/mroute=2Eh b/src/o=
penvpn/mroute=2Eh</span><br><span>index 2f5d019=2E=2E639281b 100644</span><=
br><span>--- a/src/openvpn/mroute=2Eh</span><br><span>+++ b/src/openvpn/mro=
ute=2Eh</span><br><span>@@ -144,7 +144,7 @@</span><br><span> </span><br><sp=
an> bool mroute_learnable_address(const struct mroute_addr *addr, struct gc=
_arena *gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-uint64_t mroute_addr_hash_function(const void *key, uint32_t iv);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t mroute_addr=
_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN]);</spa=
n><br><span> </span><br><span> bool mroute_addr_compare_function(const void=
 *key1, const void *key2);</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index fe2badb=
=2E=2Ea4e9c1c 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br>=
<span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -229,7 +229,7 @@</span=
><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> </span><br><span> sta=
tic uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cid_hash_=
function(const void *key, uint32_t iv)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+cid_hash_function(const void *key, const uint8_t hash_ke=
y[HASH_KEY_LEN])</span><br><span> {</span><br><span>     const unsigned lon=
g *k =3D (const unsigned long *)key;</span><br><span>     return (uint64_t)=
*k;</span><br><span>@@ -250,7 +250,7 @@</span><br><span> /*</span><br><span=
>  * inotify watcher descriptors are used as hash value</span><br><span>  *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int_hash_function(co=
nst void *key, uint32_t iv)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+int_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_=
LEN])</span><br><span> {</span><br><span>     return (uintptr_t)key;</span>=
<br><span> }</span><br><span>@@ -290,18 +290,18 @@</span><br><span>      * =
to determine which client sent an incoming packet</span><br><span>      * w=
hich is seen on the TCP/UDP socket=2E</span><br><span>      */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;hash =3D hash_init(t-&gt=
;options=2Ereal_hash_size, (uint32_t)get_random(),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    m-&gt;hash =3D hash_init(t-&gt;options=
=2Ereal_hash_size,</span><br><span>                         mroute_addr_has=
h_function, mroute_addr_compare_function);</span><br><span> </span><br><spa=
n>     /*</span><br><span>      * Virtual address hash table=2E  Used to de=
termine</span><br><span>      * which client to route a packet to=2E</span>=
<br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 m-&gt;vhash =3D hash_init(t-&gt;options=2Evirtual_hash_size, (uint32_t)get=
_random(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt=
;vhash =3D hash_init(t-&gt;options=2Evirtual_hash_size,</span><br><span>   =
                       mroute_addr_hash_function, mroute_addr_compare_funct=
ion);</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;cid_hash =3D hash_ini=
t(t-&gt;options=2Ereal_hash_size, 0, cid_hash_function, cid_compare_functio=
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;cid_ha=
sh =3D hash_init(t-&gt;options=2Ereal_hash_size, cid_hash_function, cid_com=
pare_function);</span><br><span> #endif</span><br><span> </span><br><span> =
#ifdef ENABLE_ASYNC_PUSH</span><br><span>@@ -309,8 +309,8 @@</span><br><spa=
n>      * Mapping between inotify watch descriptors and</span><br><span>   =
   * multi_instances=2E</span><br><span>      */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    m-&gt;inotify_watchers =3D hash_init(t-&gt;o=
ptions=2Ereal_hash_size, (uint32_t)get_random(),</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                    int_hash_fun=
ction, int_compare_function);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    m-&gt;inotify_watchers =3D</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        hash_init(t-&gt;options=2Ereal_hash_size, int_=
hash_function, int_compare_function);</span><br><span> #endif</span><br><sp=
an> </span><br><span>     /*</span><br><span>diff --git a/tests/unit_tests/=
openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><s=
pan>index 4d046ce=2E=2E3ebbfc1 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test=
_misc=2Ec</span><br><span>@@ -131,11 +131,11 @@</span><br><span> </span><br=
><span> </span><br><span> static uint64_t</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-word_hash_function(const void *key, uint32_t iv)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+word_hash_function(const v=
oid *key, const uint8_t hash_key[HASH_KEY_LEN])</span><br><span> {</span><b=
r><span>     const char *str =3D (const char *)key;</span><br><span>     co=
nst uint32_t len =3D (uint32_t)strlen(str);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return hash_func((const uint8_t *)str, len, iv);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return hash_func=
((const uint8_t *)str, len, *(uint32_t *)(hash_key));</span><br><span> }</s=
pan><br><span> </span><br><span> static bool</span><br><span>@@ -170,10 +17=
0,9 @@</span><br><span>      * Test the hash code by implementing a simple<=
/span><br><span>      * word frequency algorithm=2E</span><br><span>      *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>   =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct hash *hash =3D hash_init(10000, get_random(), word_=
hash_function, word_compare_function);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct hash *nhash =3D hash_init(256, get_random(), wo=
rd_hash_function, word_compare_function);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct hash *hash =3D hash_init(10000, word_hash_=
function, word_compare_function);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct hash *nhash =3D hash_init(256, word_hash_function,=
 word_compare_function);</span><br><span> </span><br><span>     printf(&quo=
t;hash_init n_buckets=3D%u mask=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-=
&gt;mask);</span><br><span> </span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail"=
>change 1571</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1571 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 22 </div>
<div style=3D"display:none"> Gerrit-Owner: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--Aui9i52ECtQ=--


--===============8780199609510284295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8780199609510284295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8780199609510284295==--

