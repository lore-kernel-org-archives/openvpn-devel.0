Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A423C53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 18:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j6VskfN4BRHGdXYcd+BIW01ger+aL7y9llT0nYEgweA=; b=X8WoDDIa2CE0YeuHwz0/MggWdu
	PT60KoOFQmePY0ecjVmqQ1VUEvapq0rmFLWCf/DufJJY4XpRZfA1Td+pdWp2S2AMtPArXz/AV7alT
	zGQ5WusRPw/CqitFQgopMP3Zk3n85ySZEjmJm2nKyLNx2+5qJT2X0kmE3rV2ZU4zTiVs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp9R9-0002KI-1h;
	Wed, 29 Jul 2026 18:55:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp9R7-0002KB-Rb
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 18:55:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WIJnhze0wxHqwcbN6Dab9Fk24G6IoJPXgWi7of1Mc5Q=; b=VVP6DMiuk6W5o+69cSkRp6h3Iw
 KZc92ckIYz6sEicino9aOuYlVFk1vUt/8Fc/THacRTduTtCxW/+CFgrCTDtFAUAYazGOfjfJpyKRA
 bfdKVPV8PL5/17PNaAF5XHFqQOZVCBP++r+GhoUZ4Mw7F5Zch01j/1zTeCMgcF3QmdUw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WIJnhze0wxHqwcbN6Dab9Fk24G6IoJPXgWi7of1Mc5Q=; b=P
 k/v0MB0AD8uW9+qwp7DuOaiqElvcfwIzzg4GYIyrZJ7MUNACmBqbmz4qJKdsjoxlGArcEqcD+eguF
 BVLNzvb+wGrl7t9hS9rurHh4RIy9ZelLby3E0A4Un8CrO+TNdLYGhq9YFYlPZPpHFtEfG9EaE4ILD
 LwfFTr0JePIc3m34=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp9RA-0006yD-AF for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 18:55:26 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso6827985e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 11:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785351318; x=1785956118; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WIJnhze0wxHqwcbN6Dab9Fk24G6IoJPXgWi7of1Mc5Q=;
 b=MXughiPsfYzI9/P9H6L4TgQ+/KYHrybv+en1qf9K4OCZIm4yXFVF6nmV9S6inrwktC
 EF1fCjoh3yWBT5pnB7lKaRtDD9OwchwqSVx8Mbrv/EkyVa07seyU/W0if56EI4uvCkvU
 B2tpYyqp5d6mJXUqqJ0eaNXMseJ4BwSBMFZ6T/SIpFDR3wzKmZ9547BJ55kIrfcwMQ+i
 JxSSknXrJ2kOc3Q/3v4dH3dOW8PBKCNraX0K5ZwCnAzAxMpO0SPAWwvFvcVPbvUOpaeU
 hZZmEIVhaHim4T/hn5GcbThrVPT1AikKmPsMnsXhwt/2uE4SWa++FD5N8a8rbsC9Gsc7
 wqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785351318; x=1785956118;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WIJnhze0wxHqwcbN6Dab9Fk24G6IoJPXgWi7of1Mc5Q=;
 b=sjwO+dtFj/tyJunjiR5ozUS5PUapMNY8aE9zPdmETcGMEaimsRIqxB51+WAcZ++3IZ
 bA/V4KxJqs7Ro4exTx7Jy+XKirY8LHp8EqCdjsriBnWrEZpUcaUw06dpWkchugy0wKC4
 VA7g2e4k3EzgwLKUsuxh1II3OjCYDvr9ek9Hgzjg4A9vRaOD9h/Z9i9mi5rjlvvZXk/m
 15lOINqn4AJhF4/ic/cq5yreDZC4//lBi+AkTFQKqaswdXfNqVw51OCBis0VI3Wbw3W6
 LOLTE9aafsF7FPRcT+idx+19dy03a0D75jWMCO5nMTxY/PtjxCfJp9vvq8HRFm2wlMsY
 LAig==
X-Gm-Message-State: AOJu0YxKFlMyjF14AwQu1hv0hj3vF/E1ehMQlAKe3LAigUZF33Na2kEM
 kGEPSwIHrrhuYD4+k8Rb7KC8KyKM43zWNW58bxdocNont8aWjeUd37x8/FI5iJKjiT/A0GqLcLo
 Yv0Bgx+jMKa9jWZLSEyUz6ClW8Z7gRL7XcH0ujCpVrG+IK8ZntxDFTvjxlomwzL0gkOAMuGCbZ1
 LiLLpmBg==
X-Gm-Gg: AR+sD13+MZI2Dpfll/29HUcGdTTLCQm1Rd+kyberKCcoENuhMFlrylQdtX8hcRImJ5e
 zxL4t4IySNiq0t22r6HIza9+3oJcqV4S/T+Qd7TWD6qbrqYJuMfPh1qvSpbAVD9L/e9XfmBgs2D
 B05XUJZshBffUz+af5OaPSv3M9DAmivWnZjIZSzJymyLiz1V81NB1EE32MLwdUl4wHQaQKM6P5C
 oZ7gLcWYN02ggH32//TKz2HyOJloekrTYXhxiECLqtHaiddpuXOE0HxwqInX4GDx1eHal65m7lt
 qiTgOlTl7Ub8D81iGmqW9D2bTJZ0b8YRP5QrOp5Z6+VLvLcdnrsnPoY/QC0sEY/tjl/C0fz1G62
 4emM0WMDAKCzNfcWJvE+hlwH4h5/6LXEydWmomUB0ztixEGgOwnEAZCIQZ2MfAFQIVmDHY0ASfL
 oOyh85YHtaQNtC8Eo/Dt/gzVFRwJksPezWeRyTCW0QEaUUIyCMgg2o2eQ060542moLqCoFGFByM
 BtQxoKq8mrHPlfmTkvdkpUwL827jRlzj3sFmmM/op67xcBWbNlpBhUuUm4alqtUTTpRGXlvTiMm
 98vE7Gg/OVmAkYppjBr/ahIbssoe9HyF9UaPJC2sag4PDxo0dvQ=
X-Received: by 2002:a05:600c:3547:b0:495:6b78:6f4 with SMTP id
 5b1f17b1804b1-496c6413230mr96448025e9.8.1785351318037; 
 Wed, 29 Jul 2026 11:55:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-497fecfccc7sm74761725e9.12.2026.07.29.11.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 11:55:17 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 18:55:15 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 124613f88855cf4b97c403de5d5ca145d5cd44f5
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e29d4f5660d2d2e9abf7ce965ec2a446c4b871fa-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp9RA-0006yD-AF
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
Content-Type: multipart/mixed; boundary="===============8692962275064750659=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8692962275064750659==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mOuVvG3Vvow="; charset=UTF-8

--mOuVvG3Vvow=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail

to look at the new pa=
tch set (#20)=2E

The following approvals got outdated and were removed:
Co=
de-Review-1 by flichtenheld


Change subject: Change hash iv to a be a fixe=
d sized array
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Change hash iv to a be a fixed sized array

While for our own hash functi=
on, always using an uint32_t works well, it does
not work very well if we m=
ove to another hash function like siphash that
requires a larger key=2E

To=
 avoid allocating a specific context, change the API to be a fixed size
arr=
ay of size 4=2E This define allows use to easily change it to a larger
valu=
e if we use hash functions that require larger keys=2E

Change-Id: If47c7d9=
20b2fa4047b7db03fcde821899839324d
Signed-off-by: Arne Schwabe <arne@rfc2549=
=2Eorg>
---
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
M src/openvpn/mro=
ute=2Ec
M src/openvpn/mroute=2Eh
M src/openvpn/multi=2Ec
M tests/unit_tests=
/openvpn/test_misc=2Ec
6 files changed, 32 insertions(+), 23 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1571=
/20

diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index c07e764=
=2E=2Ee52c778 100644
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
=
@@ -29,13 +29,15 @@
 
 #include "integer=2Eh"
 #include "list=2Eh"
+
+#incl=
ude "crypto=2Eh"
 #include "misc=2Eh"
 
 #include "memdbg=2Eh"
 
 struct ha=
sh *
-hash_init(const uint32_t n_buckets, const uint32_t iv,
-          uin=
t64_t (*hash_function)(const void *key, uint32_t iv),
+hash_init(const uint=
32_t n_buckets,
+          uint64_t (*hash_function)(const void *key, const=
 uint8_t hash_key[HASH_KEY_LEN]),
           bool (*compare_function)(const=
 void *key1, const void *key2))
 {
     struct hash *h;
@@ -46,7 +48,10 @@
=
     h->mask =3D h->n_buckets - 1;
     h->hash_function =3D hash_function;=

     h->compare_function =3D compare_function;
-    h->iv =3D iv;
+
+    /=
* create random hash key */
+    prng_bytes(h->hash_key, sizeof(h->hash_key=
));
+
     ALLOC_ARRAY(h->buckets, struct hash_bucket, h->n_buckets);
     =
for (uint32_t i =3D 0; i < h->n_buckets; ++i)
     {
diff --git a/src/openv=
pn/list=2Eh b/src/openvpn/list=2Eh
index 06377c6=2E=2Ecbf1abf 100644
--- a/=
src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -49,19 +49,24 @@
     st=
ruct hash_element *list;
 };
 
+
+#define HASH_KEY_LEN 4
+
 struct hash
 {
=
     uint32_t n_buckets;
     uint32_t n_elements;
     uint32_t mask;
-   =
 uint32_t iv;
-    uint64_t (*hash_function)(const void *key, uint32_t iv);=

+    /** key/iv used for the hash function=2E No to be confused with the (=
key, value)
+     * keys for the actual hash map entries */
+    uint8_t ha=
sh_key[HASH_KEY_LEN];
+    uint64_t (*hash_function)(const void *key, const=
 uint8_t hash_key[HASH_KEY_LEN]);
     bool (*compare_function)(const void =
*key1, const void *key2); /* return true if equal */
     struct hash_bucke=
t *buckets;
 };
 
-struct hash *hash_init(const uint32_t n_buckets, const u=
int32_t iv,
-                       uint64_t (*hash_function)(const void *k=
ey, uint32_t iv),
+struct hash *hash_init(const uint32_t n_buckets,
+      =
                 uint64_t (*hash_function)(const void *key, const uint8_t h=
ash_key[HASH_KEY_LEN]),
                        bool (*compare_function)(co=
nst void *key1, const void *key2));
 
 void hash_free(struct hash *hash);
@=
@ -103,7 +108,7 @@
 static inline uint64_t
 hash_value(const struct hash *h=
ash, const void *key)
 {
-    return (*hash->hash_function)(key, hash->iv);=

+    return (*hash->hash_function)(key, hash->hash_key);
 }
 
 static inli=
ne uint32_t
diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
in=
dex 78c689e=2E=2E62f655f 100644
--- a/src/openvpn/mroute=2Ec
+++ b/src/open=
vpn/mroute=2Ec
@@ -355,10 +355,10 @@
  * and the actual address=2E
  */
 ui=
nt64_t
-mroute_addr_hash_function(const void *key, uint32_t iv)
+mroute_add=
r_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
 =
    return hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),=

-                     mroute_addr_hash_len((const struct mroute_addr *)key=
), iv);
+                     mroute_addr_hash_len((const struct mroute_add=
r *)key), *(int32_t *)hash_key);
 }
 
 bool
diff --git a/src/openvpn/mroute=
=2Eh b/src/openvpn/mroute=2Eh
index 2f5d019=2E=2E639281b 100644
--- a/src/o=
penvpn/mroute=2Eh
+++ b/src/openvpn/mroute=2Eh
@@ -144,7 +144,7 @@
 
 bool =
mroute_learnable_address(const struct mroute_addr *addr, struct gc_arena *g=
c);
 
-uint64_t mroute_addr_hash_function(const void *key, uint32_t iv);
+u=
int64_t mroute_addr_hash_function(const void *key, const uint8_t hash_key[H=
ASH_KEY_LEN]);
 
 bool mroute_addr_compare_function(const void *key1, const=
 void *key2);
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
=
index f823f5b=2E=2Ecfa2ad8 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/ope=
nvpn/multi=2Ec
@@ -229,7 +229,7 @@
 #ifdef ENABLE_MANAGEMENT
 
 static uint=
64_t
-cid_hash_function(const void *key, uint32_t iv)
+cid_hash_function(co=
nst void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
     const unsigned=
 long *k =3D (const unsigned long *)key;
     return (uint64_t)*k;
@@ -250,=
7 +250,7 @@
 /*
  * inotify watcher descriptors are used as hash value
  */=

-int_hash_function(const void *key, uint32_t iv)
+int_hash_function(const =
void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
     return (uintptr_t)=
key;
 }
@@ -290,18 +290,18 @@
      * to determine which client sent an inc=
oming packet
      * which is seen on the TCP/UDP socket=2E
      */
-    m=
->hash =3D hash_init(t->options=2Ereal_hash_size, (uint32_t)get_random(),
+=
    m->hash =3D hash_init(t->options=2Ereal_hash_size,
                    =
     mroute_addr_hash_function, mroute_addr_compare_function);
 
     /*
  =
    * Virtual address hash table=2E  Used to determine
      * which client=
 to route a packet to=2E
      */
-    m->vhash =3D hash_init(t->options=2E=
virtual_hash_size, (uint32_t)get_random(),
+    m->vhash =3D hash_init(t->o=
ptions=2Evirtual_hash_size,
                          mroute_addr_hash_func=
tion, mroute_addr_compare_function);
 
 #ifdef ENABLE_MANAGEMENT
-    m->ci=
d_hash =3D hash_init(t->options=2Ereal_hash_size, 0, cid_hash_function, cid=
_compare_function);
+    m->cid_hash =3D hash_init(t->options=2Ereal_hash_s=
ize, cid_hash_function, cid_compare_function);
 #endif
 
 #ifdef ENABLE_ASY=
NC_PUSH
@@ -309,8 +309,8 @@
      * Mapping between inotify watch descripto=
rs and
      * multi_instances=2E
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
Gerrit-PatchSet: 20
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank=
@lichtenheld=2Ecom>

--mOuVvG3Vvow=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #20</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review-1 by flic=
htenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">Change hash iv to a be a fixed sized array<br><br=
>While for our own hash function, always using an uint32_t works well, it d=
oes<br>not work very well if we move to another hash function like siphash =
that<br>requires a larger key=2E<br><br>To avoid allocating a specific cont=
ext, change the API to be a fixed size<br>array of size 4=2E This define al=
lows use to easily change it to a larger<br>value if we use hash functions =
that require larger keys=2E<br><br>Change-Id: If47c7d920b2fa4047b7db03fcde8=
21899839324d<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>-=
--<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/mro=
ute=2Ec<br>M src/openvpn/mroute=2Eh<br>M src/openvpn/multi=2Ec<br>M tests/u=
nit_tests/openvpn/test_misc=2Ec<br>6 files changed, 32 insertions(+), 23 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/71/1571/20</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/lis=
t=2Ec b/src/openvpn/list=2Ec</span><br><span>index c07e764=2E=2Ee52c778 100=
644</span><br><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/op=
envpn/list=2Ec</span><br><span>@@ -29,13 +29,15 @@</span><br><span> </span>=
<br><span> #include &quot;integer=2Eh&quot;</span><br><span> #include &quot=
;list=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=
=2Eh&quot;</span><br><span> #include &quot;misc=2Eh&quot;</span><br><span> =
</span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><=
br><span> struct hash *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-hash_init(const uint32_t n_buckets, const uint32_t iv,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-          uint64_t (*hash_function)(cons=
t void *key, uint32_t iv),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+hash_init(const uint32_t n_buckets,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+          uint64_t (*hash_function)(const void *key,=
 const uint8_t hash_key[HASH_KEY_LEN]),</span><br><span>           bool (*c=
ompare_function)(const void *key1, const void *key2))</span><br><span> {</s=
pan><br><span>     struct hash *h;</span><br><span>@@ -46,7 +48,10 @@</span=
><br><span>     h-&gt;mask =3D h-&gt;n_buckets - 1;</span><br><span>     h-=
&gt;hash_function =3D hash_function;</span><br><span>     h-&gt;compare_fun=
ction =3D compare_function;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    h-&gt;iv =3D iv;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* creat=
e random hash key */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    prng_bytes(h-&gt;hash_key, sizeof(h-&gt;hash_key));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ALLOC_ARRAY(h-&g=
t;buckets, struct hash_bucket, h-&gt;n_buckets);</span><br><span>     for (=
uint32_t i =3D 0; i &lt; h-&gt;n_buckets; ++i)</span><br><span>     {</span=
><br><span>diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh</span><=
br><span>index 06377c6=2E=2Ecbf1abf 100644</span><br><span>--- a/src/openvp=
n/list=2Eh</span><br><span>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -4=
9,19 +49,24 @@</span><br><span>     struct hash_element *list;</span><br><s=
pan> };</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HASH_=
KEY_LEN 4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> struct hash</span><br><span> {</span><br><span>     uint32_t n_buck=
ets;</span><br><span>     uint32_t n_elements;</span><br><span>     uint32_=
t mask;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t i=
v;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint64_t (*hash=
_function)(const void *key, uint32_t iv);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /** key/iv used for the hash function=2E No to be=
 confused with the (key, value)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * keys for the actual hash map entries */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    uint8_t hash_key[HASH_KEY_LEN];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t (*hash_=
function)(const void *key, const uint8_t hash_key[HASH_KEY_LEN]);</span><br=
><span>     bool (*compare_function)(const void *key1, const void *key2); /=
* return true if equal */</span><br><span>     struct hash_bucket *buckets;=
</span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-struct hash *hash_init(const uint32_t n_buckets, const uin=
t32_t iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
           uint64_t (*hash_function)(const void *key, uint32_t iv),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+struct hash *hash_init(cons=
t uint32_t n_buckets,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                       uint64_t (*hash_function)(const void *key, const u=
int8_t hash_key[HASH_KEY_LEN]),</span><br><span>                        boo=
l (*compare_function)(const void *key1, const void *key2));</span><br><span=
> </span><br><span> void hash_free(struct hash *hash);</span><br><span>@@ -=
103,7 +108,7 @@</span><br><span> static inline uint64_t</span><br><span> ha=
sh_value(const struct hash *hash, const void *key)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (*hash-&gt;hash_=
function)(key, hash-&gt;iv);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return (*hash-&gt;hash_function)(key, hash-&gt;hash_key);</spa=
n><br><span> }</span><br><span> </span><br><span> static inline uint32_t</s=
pan><br><span>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec<=
/span><br><span>index 78c689e=2E=2E62f655f 100644</span><br><span>--- a/src=
/openvpn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</span><br>=
<span>@@ -355,10 +355,10 @@</span><br><span>  * and the actual address=2E</=
span><br><span>  */</span><br><span> uint64_t</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-mroute_addr_hash_function(const void *key, uint32_t=
 iv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mroute_addr_has=
h_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])</span><br=
><span> {</span><br><span>     return hash_func(mroute_addr_hash_ptr((const=
 struct mroute_addr *)key),</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                     mroute_addr_hash_len((const struct mroute_addr *=
)key), iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
             mroute_addr_hash_len((const struct mroute_addr *)key), *(int32=
_t *)hash_key);</span><br><span> }</span><br><span> </span><br><span> bool<=
/span><br><span>diff --git a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2E=
h</span><br><span>index 2f5d019=2E=2E639281b 100644</span><br><span>--- a/s=
rc/openvpn/mroute=2Eh</span><br><span>+++ b/src/openvpn/mroute=2Eh</span><b=
r><span>@@ -144,7 +144,7 @@</span><br><span> </span><br><span> bool mroute_=
learnable_address(const struct mroute_addr *addr, struct gc_arena *gc);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint64_=
t mroute_addr_hash_function(const void *key, uint32_t iv);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+uint64_t mroute_addr_hash_function(c=
onst void *key, const uint8_t hash_key[HASH_KEY_LEN]);</span><br><span> </s=
pan><br><span> bool mroute_addr_compare_function(const void *key1, const vo=
id *key2);</span><br><span> </span><br><span>diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec</span><br><span>index f823f5b=2E=2Ecfa2ad8 100=
644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/o=
penvpn/multi=2Ec</span><br><span>@@ -229,7 +229,7 @@</span><br><span> #ifde=
f ENABLE_MANAGEMENT</span><br><span> </span><br><span> static uint64_t</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-cid_hash_function(const vo=
id *key, uint32_t iv)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+cid_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])<=
/span><br><span> {</span><br><span>     const unsigned long *k =3D (const u=
nsigned long *)key;</span><br><span>     return (uint64_t)*k;</span><br><sp=
an>@@ -250,7 +250,7 @@</span><br><span> /*</span><br><span>  * inotify watc=
her descriptors are used as hash value</span><br><span>  */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-int_hash_function(const void *key, ui=
nt32_t iv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int_hash_=
function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])</span><br><=
span> {</span><br><span>     return (uintptr_t)key;</span><br><span> }</spa=
n><br><span>@@ -290,18 +290,18 @@</span><br><span>      * to determine whic=
h client sent an incoming packet</span><br><span>      * which is seen on t=
he TCP/UDP socket=2E</span><br><span>      */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    m-&gt;hash =3D hash_init(t-&gt;options=2Ereal_h=
ash_size, (uint32_t)get_random(),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    m-&gt;hash =3D hash_init(t-&gt;options=2Ereal_hash_size,<=
/span><br><span>                         mroute_addr_hash_function, mroute_=
addr_compare_function);</span><br><span> </span><br><span>     /*</span><br=
><span>      * Virtual address hash table=2E  Used to determine</span><br><=
span>      * which client to route a packet to=2E</span><br><span>      */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;vhash =3D ha=
sh_init(t-&gt;options=2Evirtual_hash_size, (uint32_t)get_random(),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;vhash =3D hash_ini=
t(t-&gt;options=2Evirtual_hash_size,</span><br><span>                      =
    mroute_addr_hash_function, mroute_addr_compare_function);</span><br><sp=
an> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    m-&gt;cid_hash =3D hash_init(t-&gt;options=2Er=
eal_hash_size, 0, cid_hash_function, cid_compare_function);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;cid_hash =3D hash_init(t-=
&gt;options=2Ereal_hash_size, cid_hash_function, cid_compare_function);</sp=
an><br><span> #endif</span><br><span> </span><br><span> #ifdef ENABLE_ASYNC=
_PUSH</span><br><span>@@ -309,8 +309,8 @@</span><br><span>      * Mapping b=
etween inotify watch descriptors and</span><br><span>      * multi_instance=
s=2E</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    m-&gt;inotify_watchers =3D hash_init(t-&gt;options=2Ereal_hash_=
size, (uint32_t)get_random(),</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                    int_hash_function, int_compare_=
function);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt=
;inotify_watchers =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        hash_init(t-&gt;options=2Ereal_hash_size, int_hash_function, int_=
compare_function);</span><br><span> #endif</span><br><span> </span><br><spa=
n>     /*</span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=
=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index fc9840a=
=2E=2Ec0a49ab 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_mi=
sc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><=
br><span>@@ -128,11 +128,11 @@</span><br><span> </span><br><span> </span><b=
r><span> static uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-word_hash_function(const void *key, uint32_t iv)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+word_hash_function(const void *key, const=
 uint8_t hash_key[HASH_KEY_LEN])</span><br><span> {</span><br><span>     co=
nst char *str =3D (const char *)key;</span><br><span>     const uint32_t le=
n =3D (uint32_t)strlen(str);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    return hash_func((const uint8_t *)str, len, iv);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return hash_func((const uint8_t=
 *)str, len, *(int32_t *)(hash_key));</span><br><span> }</span><br><span> <=
/span><br><span> static bool</span><br><span>@@ -174,10 +174,9 @@</span><br=
><span>      * Test the hash code by implementing a simple</span><br><span>=
      * word frequency algorithm=2E</span><br><span>      */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     struct gc_aren=
a gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 struct hash *hash =3D hash_init(10000, get_random(), word_hash_function, w=
ord_compare_function);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct hash *nhash =3D hash_init(256, get_random(), word_hash_function=
, word_compare_function);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct hash *hash =3D hash_init(10000, word_hash_function, word_c=
ompare_function);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct hash *nhash =3D hash_init(256, word_hash_function, word_compare_fu=
nction);</span><br><span> </span><br><span>     printf(&quot;hash_init n_bu=
ckets=3D%u mask=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</span=
><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">change 1571</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If47c=
7d920b2fa4047b7db03fcde821899839324d </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1571 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></ht=
ml>
--mOuVvG3Vvow=--


--===============8692962275064750659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8692962275064750659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8692962275064750659==--

