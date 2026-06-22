Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510FFCDB471
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HXLUr8Ll1+VAe1dnA0SmvAYF7uGrBuSYYsCAti28+WM=; b=E+2brIIZ5mBbjAvuL6e0VleAwR
	7qIuiZ+Gu9k8pJ6jhMrrQWFBtaqOLLOaG94PbNLCqfHW4i70YHDjknx+/o1NoM14yZIQsYmwAjg7n
	/6vhy4igi5/WO7FsTvIrt5NSsUhCxABjx6bOkbKVos/sWZxVyfy3wi3yvbbjUeY31xD8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgca-0001WY-JN;
	Mon, 22 Jun 2026 15:31:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgcY-0001WR-NQ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:31:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gbGB3TcGU6bpJO7f00YGC/vX9xhPDzPwci7y7R+C/bM=; b=csCcdI7+G1M5SQ32qIBnTM6MVn
 rEVJpr2+TCC6+/Q3RN54JIp7YLsaOHLnfhZ2SPMWQiW3a+jmgB19hLupA2I0QK/mFyBDP34qmy7Lb
 2dSXLIFXZ73tGO99x75QGCAPqrjgcmYPhf42YT3A2Xgf7KseahfIVhO7rciB2MXNNv+s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gbGB3TcGU6bpJO7f00YGC/vX9xhPDzPwci7y7R+C/bM=; b=O
 ccUQuQhGGBZIPHcvBug7SJKgQxm6ISRP/C3LQeONSQkY0i2fUxQrXvs645BMIdQgI0z8SiM3UPoPd
 yST3e/xOERCtJ1TgrVO8A/4D3hEYO8xAu24a1yMqlG4AMjXB/WIGFR8XK+U2hhK1kqxPpBv+HtLdP
 /B2+QFAio3OgMY54=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgcT-0007nW-TT for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:31:32 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-462cdb88d01so1743f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782142279; x=1782747079; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gbGB3TcGU6bpJO7f00YGC/vX9xhPDzPwci7y7R+C/bM=;
 b=TjgBeO/WHrkVTvTpw1YER1K79Iu6MgDuaWW5FzAcPqFfcblSsGBpe7/xaBkItIZWZT
 FL9dChpTlwmAX0lYtRF55ITjR0IuC8Mx/OZ/TU5etG/lYY5e0SwSLFI0Nfx/mdeFQJ4U
 4pCS5465JbFy0Gue+Qa79Fekp5f1JoycxdXjpHCLYyXW+TF6gh1aw5mgeFe0r22ZdCxR
 UrgtcW2m2ZRS3+wRqrNQRaRIKydaUwoAnhz3Hbj77O86gkDRnsk/zy8gJ1QvRXI50qJl
 XzEyaP8IGKg23HIrCgnGYsQYMlFpDhFR7Nm1G7Zd7thjHFqhLYc15ISDwNgsdcMac2JC
 3khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142279; x=1782747079;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gbGB3TcGU6bpJO7f00YGC/vX9xhPDzPwci7y7R+C/bM=;
 b=P8egOnD1O2KuyXC+cYXkj8ENj+OdJPtZ9KGpLf3ekNUgDOZZkNAP72HPfA+XDYYqut
 5bdKUMYTFK3D94vjxzW9S2pTkCHqlRw3JQfbVTDEK32gUmAJkkmGuJRSsTKMQfGLFJsD
 Q889K32w9PDC2Udivev6rE5oYtqfTiisQ0zTPS2yAe5QfyuYXVdmuz8YAZ/amS03JJN+
 72xvL7enqLbzZNQ8Ow5utARlj3NYdc46MyAIa0QSPt1RmN0P1Zge2jv5034d7UIpDdp7
 8HtgHTbsVWKH7bo4dxrzGuWLiLppldKlG6O7U9uJJS8FhKnSLH0oe+rC0VhuS9N85HV/
 EoUA==
X-Gm-Message-State: AOJu0YwruTjKx/hev+u9PRRZs9LGwTJCpI15+9szcD45wd2oxXQMkeaH
 I9i80DSOLSa41qXj2ebkeRHqeV21tMYTjKTO/NJUyQBy5TJFYA2Al2yAth/AG/IsjD6gDc/lrrU
 CI1JUJ8yGQCa8iJU/jVjPk8/vEVQgB0JcznWDwPtJaKw5pfsT8XQydRxPhsRB2llJi8q01fhee3
 YuM3TWTA==
X-Gm-Gg: AfdE7cm+seCATjuR41hG7zHkQyJHY1pkhiWRtmuuge+L8oGF3r8ILOqRtitw9vD4u5o
 uQKMSfv0yn9ta+dkOBvqQiNlhkFMwa2ovDvYgoEGDXkJIKO6ime53GmB3WWWESUZ5Tx3EQcas56
 DN7CO4bMOfsvQSlBUurHOI2qyb0O254P3C9wAorJ9UM2+/ME0qgRz2WBE2kIE1cNaZLPZU7WEF4
 xOxCvSxPKNBstfn6IDxD7yDg1UYNeJb8upAVkRYrd3gC+37rPUWyluZIxBGSGYSSGqx5ykdMLpc
 VqhWMJFQyPQ9wxrcTW3Dj/F6Z3DlVttWSIZrHMgZnKI7OjSpab0g0obfD1E1+CHU1QNLG1kI5au
 DO8NHOTyd+wIS17N4zraz7AvvOuGuou46E3KRxAHSgG3EkAvfIHfW2RTuDP2NbUFfvDphezhWZM
 0TrZCvgKkwR4gS4fjG6pf1BIRZxnCwZHiKOlI5iXNONhkYj8uqFhjyEPHiSmdCPJmoe376hCq4K
 LtrAjylC8ZihY6ap+b7lepG1H1fMHPuPBh/NmjJX3FIgPLKXxtUbmiz3kAC04qLoYqTp0YrbzbD
 UTIn+NpoiaEbrA==
X-Received: by 2002:a05:6000:4205:b0:463:b7f2:cc7a with SMTP id
 ffacd0b85a97d-4651dffe79fmr21811022f8f.17.1782142277557; 
 Mon, 22 Jun 2026 08:31:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666788226sm27097986f8f.23.2026.06.22.08.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:31:17 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:31:08 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
X-Gerrit-Change-Number: 1570
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1570?usp=email>
X-Gerrit-Commit: 4c79552ee28832b73b22bd58c2985a23abeb2a02
In-Reply-To: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@gerrit.openvpn.net>
References: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkliODE0MDEwN2Y5ODE2NGQyYTJlMTc2OGE2ZDhhYzY1MDE2Y2Q3ZjdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a13f71254a95947633e30edb41ce97a74ed57a21-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgcT-0007nW-TT
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6970199283023841406=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6970199283023841406==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MCSxGmv3n6c="; charset=UTF-8

--MCSxGmv3n6c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1570?usp=3Demail

to look at the new patch set (#6=
)=2E

The following approvals got outdated and were removed:
Code-Review+2 =
by flichtenheld


Change subject: Change hash values in our hash map from u=
int32_t to uint64_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Change hash values in our hash map from uint32_t to uint64_t

32 bi=
t architectures are playing a very small role today, so the difference
betw=
een 64 bit and 32 bit hash values is not expected to be large anymore=2E

T=
his is also in preparation to replace our hash function with a more modern
=
replacement=2E

Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
Signed=
-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/list=2Ec
M src=
/openvpn/list=2Eh
M src/openvpn/mroute=2Ec
M src/openvpn/mroute=2Eh
M src/o=
penvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M tests/unit=
_tests/openvpn/test_misc=2Ec
8 files changed, 29 insertions(+), 29 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/7=
0/1570/6

diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index f0=
e9908=2E=2Ec07e764 100644
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=
=2Ec
@@ -35,7 +35,7 @@
 
 struct hash *
 hash_init(const uint32_t n_buckets=
, const uint32_t iv,
-          uint32_t (*hash_function)(const void *key, =
uint32_t iv),
+          uint64_t (*hash_function)(const void *key, uint32_=
t iv),
           bool (*compare_function)(const void *key1, const void *ke=
y2))
 {
     struct hash *h;
@@ -76,7 +76,7 @@
 }
 
 struct hash_element *
=
-hash_lookup_fast(struct hash *hash, struct hash_bucket *bucket, const void=
 *key, uint32_t hv)
+hash_lookup_fast(struct hash *hash, struct hash_bucket=
 *bucket, const void *key, uint64_t hv)
 {
     struct hash_element *he;
  =
   struct hash_element *prev =3D NULL;
@@ -104,7 +104,7 @@
 }
 
 bool
-hash=
_remove_fast(struct hash *hash, struct hash_bucket *bucket, const void *key=
, uint32_t hv)
+hash_remove_fast(struct hash *hash, struct hash_bucket *buc=
ket, const void *key, uint64_t hv)
 {
     struct hash_element *he;
     st=
ruct hash_element *prev =3D NULL;
@@ -136,7 +136,7 @@
 bool
 hash_add(struc=
t hash *hash, const void *key, void *value, bool replace)
 {
-    uint32_t =
hv;
+    uint64_t hv;
     struct hash_bucket *bucket;
     struct hash_ele=
ment *he;
     bool ret =3D false;
@@ -412,7 +412,7 @@
         c ^=3D (b >=
> 15); \
     }
 
-uint32_t
+uint64_t
 hash_func(const uint8_t *k, uint32_t=
 length, uint32_t initval)
 {
     uint32_t a, b, c, len;
diff --git a/src/=
openvpn/list=2Eh b/src/openvpn/list=2Eh
index 04cc3ab=2E=2E06377c6 100644
-=
-- a/src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -40,7 +40,7 @@
 {
 =
    void *value;
     const void *key;
-    uint32_t hash_value;
+    uint6=
4_t hash_value;
     struct hash_element *next;
 };
 
@@ -55,13 +55,13 @@
 =
    uint32_t n_elements;
     uint32_t mask;
     uint32_t iv;
-    uint32_=
t (*hash_function)(const void *key, uint32_t iv);
+    uint64_t (*hash_func=
tion)(const void *key, uint32_t iv);
     bool (*compare_function)(const vo=
id *key1, const void *key2); /* return true if equal */
     struct hash_bu=
cket *buckets;
 };
 
 struct hash *hash_init(const uint32_t n_buckets, cons=
t uint32_t iv,
-                       uint32_t (*hash_function)(const void=
 *key, uint32_t iv),
+                       uint64_t (*hash_function)(cons=
t void *key, uint32_t iv),
                        bool (*compare_function)=
(const void *key1, const void *key2));
 
 void hash_free(struct hash *hash)=
;
@@ -69,9 +69,9 @@
 bool hash_add(struct hash *hash, const void *key, void=
 *value, bool replace);
 
 struct hash_element *hash_lookup_fast(struct has=
h *hash, struct hash_bucket *bucket,
-                                     =
 const void *key, uint32_t hv);
+                                      cons=
t void *key, uint64_t hv);
 
-bool hash_remove_fast(struct hash *hash, stru=
ct hash_bucket *bucket, const void *key, uint32_t hv);
+bool hash_remove_fa=
st(struct hash *hash, struct hash_bucket *bucket, const void *key, uint64_t=
 hv);
 
 void hash_remove_by_value(struct hash *hash, void *value);
 
@@ -9=
8,9 +98,9 @@
 
 void hash_iterator_free(struct hash_iterator *hi);
 
-uint3=
2_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);
+uint64=
_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);
 
-stati=
c inline uint32_t
+static inline uint64_t
 hash_value(const struct hash *ha=
sh, const void *key)
 {
     return (*hash->hash_function)(key, hash->iv);
=
@@ -119,7 +119,7 @@
 }
 
 static inline struct hash_bucket *
-hash_bucket(s=
truct hash *hash, uint32_t hv)
+hash_bucket(struct hash *hash, uint64_t hv)=

 {
     return &hash->buckets[hv & hash->mask];
 }
@@ -129,7 +129,7 @@
 {
=
     void *ret =3D NULL;
     struct hash_element *he;
-    uint32_t hv =3D=
 hash_value(hash, key);
+    uint64_t hv =3D hash_value(hash, key);
     st=
ruct hash_bucket *bucket =3D &hash->buckets[hv & hash->mask];
 
     he =3D=
 hash_lookup_fast(hash, bucket, key, hv);
@@ -143,7 +143,7 @@
 
 /* NOTE: a=
ssumes that key is not a duplicate */
 static inline void
-hash_add_fast(st=
ruct hash *hash, struct hash_bucket *bucket, const void *key, uint32_t hv,
=
+hash_add_fast(struct hash *hash, struct hash_bucket *bucket, const void *k=
ey, uint64_t hv,
               void *value)
 {
     struct hash_element *h=
e;
@@ -160,7 +160,7 @@
 static inline bool
 hash_remove(struct hash *hash, =
const void *key)
 {
-    uint32_t hv;
+    uint64_t hv;
     struct hash_bu=
cket *bucket;
     bool ret;
 
diff --git a/src/openvpn/mroute=2Ec b/src/op=
envpn/mroute=2Ec
index 6fa70a3=2E=2E78c689e 100644
--- a/src/openvpn/mroute=
=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -354,7 +354,7 @@
  * address type, num=
ber of bits in the network address,
  * and the actual address=2E
  */
-uin=
t32_t
+uint64_t
 mroute_addr_hash_function(const void *key, uint32_t iv)
 {=

     return hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key=
),
diff --git a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh
index c8daa=
15=2E=2E2f5d019 100644
--- a/src/openvpn/mroute=2Eh
+++ b/src/openvpn/mrout=
e=2Eh
@@ -144,7 +144,7 @@
 
 bool mroute_learnable_address(const struct mro=
ute_addr *addr, struct gc_arena *gc);
 
-uint32_t mroute_addr_hash_function=
(const void *key, uint32_t iv);
+uint64_t mroute_addr_hash_function(const v=
oid *key, uint32_t iv);
 
 bool mroute_addr_compare_function(const void *ke=
y1, const void *key2);
 
diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mt=
cp=2Ec
index 7651b4d=2E=2Ef000283 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/s=
rc/openvpn/mtcp=2Ec
@@ -49,7 +49,7 @@
     {
         mi->real=2Eproto =3D =
sock->info=2Eproto;
         struct hash_element *he;
-        const uint32=
_t hv =3D hash_value(hash, &mi->real);
+        const uint64_t hv =3D hash_=
value(hash, &mi->real);
         struct hash_bucket *bucket =3D hash_bucket=
(hash, hv);
 
         multi_assign_peer_id(m, mi);
diff --git a/src/openvp=
n/mudp=2Ec b/src/openvpn/mudp=2Ec
index 143a330=2E=2Eb1de446 100644
--- a/s=
rc/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -212,7 +212,7 @@
     if =
(mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) &=
& m->top=2Ec2=2Ebuf=2Elen > 0)
     {
         struct hash_element *he;
-  =
      const uint32_t hv =3D hash_value(hash, &real);
+        const uint64_=
t hv =3D hash_value(hash, &real);
         struct hash_bucket *bucket =3D h=
ash_bucket(hash, hv);
         uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
 =
        uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec
index e96d43c=2E=2Ee1c9c80 100644
--- a/sr=
c/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -228,11 +228,11 @@
 
 #i=
fdef ENABLE_MANAGEMENT
 
-static uint32_t
+static uint64_t
 cid_hash_functi=
on(const void *key, uint32_t iv)
 {
     const unsigned long *k =3D (const =
unsigned long *)key;
-    return (uint32_t)*k;
+    return (uint64_t)*k;
 }=

 
 static bool
@@ -246,19 +246,19 @@
 #endif
 
 #ifdef ENABLE_ASYNC_PUSH
-=
static uint32_t
+static uint64_t
 /*
  * inotify watcher descriptors are us=
ed as hash value
  */
 int_hash_function(const void *key, uint32_t iv)
 {
-=
    return (uint32_t)(uintptr_t)key;
+    return (uintptr_t)key;
 }
 
 stat=
ic bool
 int_compare_function(const void *key1, const void *key2)
 {
-    r=
eturn (unsigned long)key1 =3D=3D (unsigned long)key2;
+    return (uintptr_=
t)key1 =3D=3D (uintptr_t)key2;
 }
 #endif
 
@@ -1011,7 +1011,7 @@
         =
         const unsigned int flags)
 {
     struct hash_element *he;
-    co=
nst uint32_t hv =3D hash_value(m->vhash, addr);
+    const uint64_t hv =3D =
hash_value(m->vhash, addr);
     struct hash_bucket *bucket =3D hash_bucket=
(m->vhash, hv);
     struct multi_route *oldroute =3D NULL;
     struct mul=
ti_instance *owner =3D NULL;
@@ -3094,7 +3094,7 @@
         goto done;
    =
 }
 
-    const uint32_t hv =3D hash_value(hash, &real);
+    const uint64_=
t hv =3D hash_value(hash, &real);
     struct hash_bucket *bucket =3D hash_=
bucket(hash, hv);
 
     /* make sure that we don't float to an address tak=
en by another client */
@@ -4230,7 +4230,7 @@
 multi_unlearn_addr(struct mu=
lti_context *m, struct multi_instance *mi, const struct mroute_addr *addr)
=
 {
     struct hash_element *he;
-    const uint32_t hv =3D hash_value(m->v=
hash, addr);
+    const uint64_t hv =3D hash_value(m->vhash, addr);
     st=
ruct hash_bucket *bucket =3D hash_bucket(m->vhash, hv);
     struct multi_r=
oute *r =3D NULL;
 
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/t=
ests/unit_tests/openvpn/test_misc=2Ec
index a9ae33f=2E=2Eccdfdee 100644
---=
 a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/te=
st_misc=2Ec
@@ -124,7 +124,7 @@
 };
 
 
-static uint32_t
+static uint64_t
 =
word_hash_function(const void *key, uint32_t iv)
 {
     const char *str =
=3D (const char *)key;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1570?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
Gerrit-Change-Number: 1570
=
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld=
 <frank@lichtenheld=2Ecom>

--MCSxGmv3n6c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #6</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1570?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Change hash values in our hash map from uint32_t to uint64_t<=
br><br>32 bit architectures are playing a very small role today, so the dif=
ference<br>between 64 bit and 32 bit hash values is not expected to be larg=
e anymore=2E<br><br>This is also in preparation to replace our hash functio=
n with a more modern<br>replacement=2E<br><br>Change-Id: Ib8140107f98164d2a=
2e1768a6d8ac65016cd7f7c<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eo=
rg&gt;<br>---<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/=
openvpn/mroute=2Ec<br>M src/openvpn/mroute=2Eh<br>M src/openvpn/mtcp=2Ec<br=
>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M tests/unit_tests/op=
envpn/test_misc=2Ec<br>8 files changed, 29 insertions(+), 29 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/70/1570/6</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/list=2Ec b/src/o=
penvpn/list=2Ec</span><br><span>index f0e9908=2E=2Ec07e764 100644</span><br=
><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2E=
c</span><br><span>@@ -35,7 +35,7 @@</span><br><span> </span><br><span> stru=
ct hash *</span><br><span> hash_init(const uint32_t n_buckets, const uint32=
_t iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          uint3=
2_t (*hash_function)(const void *key, uint32_t iv),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          uint64_t (*hash_function)(const=
 void *key, uint32_t iv),</span><br><span>           bool (*compare_functio=
n)(const void *key1, const void *key2))</span><br><span> {</span><br><span>=
     struct hash *h;</span><br><span>@@ -76,7 +76,7 @@</span><br><span> }</=
span><br><span> </span><br><span> struct hash_element *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-hash_lookup_fast(struct hash *hash, struc=
t hash_bucket *bucket, const void *key, uint32_t hv)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+hash_lookup_fast(struct hash *hash, struc=
t hash_bucket *bucket, const void *key, uint64_t hv)</span><br><span> {</sp=
an><br><span>     struct hash_element *he;</span><br><span>     struct hash=
_element *prev =3D NULL;</span><br><span>@@ -104,7 +104,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-hash_remove_fast(struct hash *hash, struct hash_buck=
et *bucket, const void *key, uint32_t hv)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+hash_remove_fast(struct hash *hash, struct hash_bucke=
t *bucket, const void *key, uint64_t hv)</span><br><span> {</span><br><span=
>     struct hash_element *he;</span><br><span>     struct hash_element *pr=
ev =3D NULL;</span><br><span>@@ -136,7 +136,7 @@</span><br><span> bool</spa=
n><br><span> hash_add(struct hash *hash, const void *key, void *value, bool=
 replace)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    uint32_t hv;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    uint64_t hv;</span><br><span>     struct hash_bucket *bucket;</span=
><br><span>     struct hash_element *he;</span><br><span>     bool ret =3D =
false;</span><br><span>@@ -412,7 +412,7 @@</span><br><span>         c ^=3D =
(b &gt;&gt; 15); \</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-uint32_t</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+uint64_t</span><br><span> hash_func(const uint8_=
t *k, uint32_t length, uint32_t initval)</span><br><span> {</span><br><span=
>     uint32_t a, b, c, len;</span><br><span>diff --git a/src/openvpn/list=
=2Eh b/src/openvpn/list=2Eh</span><br><span>index 04cc3ab=2E=2E06377c6 1006=
44</span><br><span>--- a/src/openvpn/list=2Eh</span><br><span>+++ b/src/ope=
nvpn/list=2Eh</span><br><span>@@ -40,7 +40,7 @@</span><br><span> {</span><b=
r><span>     void *value;</span><br><span>     const void *key;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t hash_value;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t hash_value;</sp=
an><br><span>     struct hash_element *next;</span><br><span> };</span><br>=
<span> </span><br><span>@@ -55,13 +55,13 @@</span><br><span>     uint32_t n=
_elements;</span><br><span>     uint32_t mask;</span><br><span>     uint32_=
t iv;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t (*h=
ash_function)(const void *key, uint32_t iv);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    uint64_t (*hash_function)(const void *key, uin=
t32_t iv);</span><br><span>     bool (*compare_function)(const void *key1, =
const void *key2); /* return true if equal */</span><br><span>     struct h=
ash_bucket *buckets;</span><br><span> };</span><br><span> </span><br><span>=
 struct hash *hash_init(const uint32_t n_buckets, const uint32_t iv,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                       uint3=
2_t (*hash_function)(const void *key, uint32_t iv),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                       uint64_t (*hash_fu=
nction)(const void *key, uint32_t iv),</span><br><span>                    =
    bool (*compare_function)(const void *key1, const void *key2));</span><b=
r><span> </span><br><span> void hash_free(struct hash *hash);</span><br><sp=
an>@@ -69,9 +69,9 @@</span><br><span> bool hash_add(struct hash *hash, cons=
t void *key, void *value, bool replace);</span><br><span> </span><br><span>=
 struct hash_element *hash_lookup_fast(struct hash *hash, struct hash_bucke=
t *bucket,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                           const void *key, uint32_t hv);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
 const void *key, uint64_t hv);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-bool hash_remove_fast(struct hash *hash, struct=
 hash_bucket *bucket, const void *key, uint32_t hv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool hash_remove_fast(struct hash *hash, =
struct hash_bucket *bucket, const void *key, uint64_t hv);</span><br><span>=
 </span><br><span> void hash_remove_by_value(struct hash *hash, void *value=
);</span><br><span> </span><br><span>@@ -98,9 +98,9 @@</span><br><span> </s=
pan><br><span> void hash_iterator_free(struct hash_iterator *hi);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint32_t hash=
_func(const uint8_t *k, uint32_t length, uint32_t initval);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+uint64_t hash_func(const uint8_t *k=
, uint32_t length, uint32_t initval);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static inline uint32_t</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static inline uint64_t</span><br><span=
> hash_value(const struct hash *hash, const void *key)</span><br><span> {</=
span><br><span>     return (*hash-&gt;hash_function)(key, hash-&gt;iv);</sp=
an><br><span>@@ -119,7 +119,7 @@</span><br><span> }</span><br><span> </span=
><br><span> static inline struct hash_bucket *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-hash_bucket(struct hash *hash, uint32_t hv)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+hash_bucket(struct hash *h=
ash, uint64_t hv)</span><br><span> {</span><br><span>     return &amp;hash-=
&gt;buckets[hv &amp; hash-&gt;mask];</span><br><span> }</span><br><span>@@ =
-129,7 +129,7 @@</span><br><span> {</span><br><span>     void *ret =3D NULL=
;</span><br><span>     struct hash_element *he;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    uint32_t hv =3D hash_value(hash, key);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t hv =3D hash_v=
alue(hash, key);</span><br><span>     struct hash_bucket *bucket =3D &amp;h=
ash-&gt;buckets[hv &amp; hash-&gt;mask];</span><br><span> </span><br><span>=
     he =3D hash_lookup_fast(hash, bucket, key, hv);</span><br><span>@@ -14=
3,7 +143,7 @@</span><br><span> </span><br><span> /* NOTE: assumes that key =
is not a duplicate */</span><br><span> static inline void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-hash_add_fast(struct hash *hash, struct=
 hash_bucket *bucket, const void *key, uint32_t hv,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+hash_add_fast(struct hash *hash, struct h=
ash_bucket *bucket, const void *key, uint64_t hv,</span><br><span>         =
      void *value)</span><br><span> {</span><br><span>     struct hash_elem=
ent *he;</span><br><span>@@ -160,7 +160,7 @@</span><br><span> static inline=
 bool</span><br><span> hash_remove(struct hash *hash, const void *key)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uin=
t32_t hv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64=
_t hv;</span><br><span>     struct hash_bucket *bucket;</span><br><span>   =
  bool ret;</span><br><span> </span><br><span>diff --git a/src/openvpn/mrou=
te=2Ec b/src/openvpn/mroute=2Ec</span><br><span>index 6fa70a3=2E=2E78c689e =
100644</span><br><span>--- a/src/openvpn/mroute=2Ec</span><br><span>+++ b/s=
rc/openvpn/mroute=2Ec</span><br><span>@@ -354,7 +354,7 @@</span><br><span> =
 * address type, number of bits in the network address,</span><br><span>  *=
 and the actual address=2E</span><br><span>  */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-uint32_t</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+uint64_t</span><br><span> mroute_addr_hash_function(const vo=
id *key, uint32_t iv)</span><br><span> {</span><br><span>     return hash_f=
unc(mroute_addr_hash_ptr((const struct mroute_addr *)key),</span><br><span>=
diff --git a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh</span><br><spa=
n>index c8daa15=2E=2E2f5d019 100644</span><br><span>--- a/src/openvpn/mrout=
e=2Eh</span><br><span>+++ b/src/openvpn/mroute=2Eh</span><br><span>@@ -144,=
7 +144,7 @@</span><br><span> </span><br><span> bool mroute_learnable_addres=
s(const struct mroute_addr *addr, struct gc_arena *gc);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint32_t mroute_addr_ha=
sh_function(const void *key, uint32_t iv);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+uint64_t mroute_addr_hash_function(const void *key, =
uint32_t iv);</span><br><span> </span><br><span> bool mroute_addr_compare_f=
unction(const void *key1, const void *key2);</span><br><span> </span><br><s=
pan>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><spa=
n>index 7651b4d=2E=2Ef000283 100644</span><br><span>--- a/src/openvpn/mtcp=
=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -49,7 +4=
9,7 @@</span><br><span>     {</span><br><span>         mi-&gt;real=2Eproto =
=3D sock-&gt;info=2Eproto;</span><br><span>         struct hash_element *he=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const uint32=
_t hv =3D hash_value(hash, &amp;mi-&gt;real);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        const uint64_t hv =3D hash_value(hash, &a=
mp;mi-&gt;real);</span><br><span>         struct hash_bucket *bucket =3D ha=
sh_bucket(hash, hv);</span><br><span> </span><br><span>         multi_assig=
n_peer_id(m, mi);</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/o=
penvpn/mudp=2Ec</span><br><span>index 143a330=2E=2Eb1de446 100644</span><br=
><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2E=
c</span><br><span>@@ -212,7 +212,7 @@</span><br><span>     if (mroute_extra=
ct_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &am=
p;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span>     {</span><br=
><span>         struct hash_element *he;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        const uint32_t hv =3D hash_value(hash, &amp;real=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const uin=
t64_t hv =3D hash_value(hash, &amp;real);</span><br><span>         struct h=
ash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span>         uint=
8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>         uint=
8_t op =3D ptr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><span>diff --git a/src=
/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e96d43c=2E=
=2Ee1c9c80 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><sp=
an>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -228,11 +228,11 @@</span>=
<br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static uint32_t</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static uint64_t</span><br><sp=
an> cid_hash_function(const void *key, uint32_t iv)</span><br><span> {</spa=
n><br><span>     const unsigned long *k =3D (const unsigned long *)key;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (uint32_t)*k;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (uint64_t=
)*k;</span><br><span> }</span><br><span> </span><br><span> static bool</spa=
n><br><span>@@ -246,19 +246,19 @@</span><br><span> #endif</span><br><span> =
</span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static uint32_t</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static uint64_t</span><br><span> /*</span><br><span>  * in=
otify watcher descriptors are used as hash value</span><br><span>  */</span=
><br><span> int_hash_function(const void *key, uint32_t iv)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (uint32=
_t)(uintptr_t)key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return (uintptr_t)key;</span><br><span> }</span><br><span> </span><br><s=
pan> static bool</span><br><span> int_compare_function(const void *key1, co=
nst void *key2)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return (unsigned long)key1 =3D=3D (unsigned long)key2;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (uintptr_t)k=
ey1 =3D=3D (uintptr_t)key2;</span><br><span> }</span><br><span> #endif</spa=
n><br><span> </span><br><span>@@ -1011,7 +1011,7 @@</span><br><span>       =
           const unsigned int flags)</span><br><span> {</span><br><span>   =
  struct hash_element *he;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    const uint32_t hv =3D hash_value(m-&gt;vhash, addr);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_va=
lue(m-&gt;vhash, addr);</span><br><span>     struct hash_bucket *bucket =3D=
 hash_bucket(m-&gt;vhash, hv);</span><br><span>     struct multi_route *old=
route =3D NULL;</span><br><span>     struct multi_instance *owner =3D NULL;=
</span><br><span>@@ -3094,7 +3094,7 @@</span><br><span>         goto done;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const uint32_t hv =3D hash_value(hash, &amp;real);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv=
 =3D hash_value(hash, &amp;real);</span><br><span>     struct hash_bucket *=
bucket =3D hash_bucket(hash, hv);</span><br><span> </span><br><span>     /*=
 make sure that we don&#39;t float to an address taken by another client */=
</span><br><span>@@ -4230,7 +4230,7 @@</span><br><span> multi_unlearn_addr(=
struct multi_context *m, struct multi_instance *mi, const struct mroute_add=
r *addr)</span><br><span> {</span><br><span>     struct hash_element *he;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const uint32_t hv =
=3D hash_value(m-&gt;vhash, addr);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const uint64_t hv =3D hash_value(m-&gt;vhash, addr);</sp=
an><br><span>     struct hash_bucket *bucket =3D hash_bucket(m-&gt;vhash, h=
v);</span><br><span>     struct multi_route *r =3D NULL;</span><br><span> <=
/span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests=
/unit_tests/openvpn/test_misc=2Ec</span><br><span>index a9ae33f=2E=2Eccdfde=
e 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ =
-124,7 +124,7 @@</span><br><span> };</span><br><span> </span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static uint32_t</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static uint64_t</span><br><s=
pan> word_hash_function(const void *key, uint32_t iv)</span><br><span> {</s=
pan><br><span>     const char *str =3D (const char *)key;</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1570?usp=3Demail">change 1570</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1570?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016=
cd7f7c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1570 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>

</body></html>
--MCSxGmv3n6c=--


--===============6970199283023841406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6970199283023841406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6970199283023841406==--

