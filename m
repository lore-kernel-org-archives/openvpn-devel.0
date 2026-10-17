Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04B2CCF2C1
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 16:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=3f5X15QzSAHKapcFoUvEHSmWLdUepYRt3rVLC2GYHi4=; b=SDyQ0AD4sMd9rd
	IeaKR6kxw3e1WpXNHz0Ly+4/kiAsJ8fOcEW2afKVov4HGDgTIZRwuXtjiUR+7pOzdRYonNAdbbD1Y
	PSv1QCBbmO6NgCSVpUFjk/V2Wp8EkPs1S6Ng71Y1d2wVzY7XD54hDtTB+nc9CQ/tQjk6RPr9mqEnI
	9c4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI7Z8-000816-4G;
	Sat, 17 Oct 2026 16:47:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI7Z3-00080r-Jc
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:47:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JTdbeK8qb9hIkAdL+axPxryPRDcLDXiicZi4Hovqg7I=; b=QL7ymlLSkSNMn2bwBVVVCGyjNb
 AQVlzetKKMog2gSmna1boD5td98OITas9PgiSVDJBuqAYC6qaNOIbe52+yyyrYCP2CMkwPgyR1vTg
 rafAPf5jiMoODrWv5O1GHZj3OoVticPU/j8lBuIEHr1YfVF2yuuVdDRW/7LL0O4rHiKo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JTdbeK8qb9hIkAdL+axPxryPRDcLDXiicZi4Hovqg7I=; b=B
 ngNSpgirxj/B4rc0ybJKE1yw8Vc6TJt0Wjp3YfKndaf8WCBL4kc8vOMgzPUo36QEih0dGlqNuS1Dp
 VC3LBr58CJHb0y9zqgkhXoeRo6v+KPno6HJ56lYPzpcPGpPM9kqUOy8SBD98wN1QWS9T775jbwDNu
 wHr6833wkjrIl5y0=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI7Z2-00068q-HD for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:47:21 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso457307f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792255634; x=1792860434; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JTdbeK8qb9hIkAdL+axPxryPRDcLDXiicZi4Hovqg7I=;
 b=fd6hWjY939rGfuscs8sbQRp/Bq0yP1yc8KpC2tLjlb5Stp7q0xGrdh6xrKvvJ5g539
 Ye1ba4de2ryZ6kggzyrPDTBC7IqlPnwA17UzTftokpMRZCOXRJJzg9CcTIqqiT+rAMod
 86M8GDibDcJM8F6/UazCbvutiv9GzPKbD1lDHNja23LqPqggSJ7SZp41kC8nB4G/m9ya
 kN2kaeY1WSxTke+yEh4ryyI00uCW3ouBVD0uxX+52UYAmQz8cRLFBuSb4as+HtFnFzIW
 bB89ky0zd2gpZwuopajadGIFJ1ezH2U1K9o7U8Fhp/TBbBcz4sVl0YNDNDj1piWD54B5
 IZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792255634; x=1792860434;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JTdbeK8qb9hIkAdL+axPxryPRDcLDXiicZi4Hovqg7I=;
 b=dYbXVa0eAHeVEhUzH1rwI0GPLQPoFF8Z9mlHrJY1ktj7fSglhl+v6l1Mj8W6ZQ1qwr
 kew0oStAWY+LqmGV5dlqooRw6pIy4JIIT2V49SSTpBa8jfAcuXp7D4+ZSRU6oBoFfnWt
 hgIXK29zmecn4p6BX/yEbxZcque8D3/pYdx939sZERFsZl0AxVY1YiT/MUWN1BLxf6Ja
 P6zfgZbu4LfTTTQCpB0TwJUHlGS9U+VzylMSgE6aAmD24v+cxMYtmgiqTbEJR6OC/o9P
 WT9/8Qgg/gw1kcOagJ2GPxUoWrljpoSostCDi9ynT8l9T+DJCukOAO4yUaQBkkHTq1Gs
 Oxrw==
X-Gm-Message-State: AFq9FYKV0LsMrwrX4uvxJMS1Vfb1RhNr3llzbYf6/5eOZ6dduG6sEFH4
 NYXxmfJUXBovIHlzUY+07/6yZbtQL77dNsLXMMvdM2lz/gHpRwJm7Zdj0o+L2OcI+Gq5dtbt7+1
 yoCkiIuqkmFWO+JR29HdtTYslt2fM+jYKCeL4jx6B1THr0o39XyQZuitaozgndnhrc2V9kygWWm
 4YMMl5pQ==
X-Gm-Gg: AYBFou16D5mhdNKOig3cvHT9vZOQRvz8yW+JS1+ffdAoU7sB/p1Jj/afJVtPF15yXTk
 Sw5L1DxY2uIJM4PQCQ04dY18kqx0ZM3UW1pdFxAtz4jdorXMzxPlofyrW8nQVpWE66P82ktKrb3
 hAKYViiAF3ramuva/TDGpXp2F9H4NHbOWOaEQQ4WjWxoOdYloa+dHD9/wd/KomxcV4nChHFLpF7
 3AfawuEcT6g6YHkUn0LeXsnskP4TBo9ahYhMkhooi34AkgdnsBwoB8gK0bj/VG0i9xPDkzTnnO+
 qEY71vzS1XIr28tv8jqZJfEWldoJKoaTbDGc7gZrZneh/+KIKubQdQYYzc5EYKIrLuyy6EkWugO
 k6wMfvIr67hAHbf2uW/EPvf8N11jI6KGtAgvW2AGFnMEsdeEsDTD9mRkd3g0ps+9dvMG7OHVr06
 lI4Zaje782dq5qwZ7cD1ne3yKeJbX6ybDknO2xyIhPGueelFqHJdqZBQZW4kIAd1yCWcJOroqNT
 NcT/0q2v583pSMeCbYeWJwPyl/h6iCHJUD7OEB4w/eALD9umY1kGnSAEPlO43tGhr2w7bZlRPSg
 ZGbTlqAdX+xJMA/gfkOGcXaqcU1u4LBc4018iD172Qk963WxId1AqeX+vNl0
X-Received: by 2002:adf:e187:0:b0:48d:ef7d:4b4c with SMTP id
 ffacd0b85a97d-48e07fa8491mr5681033f8f.44.1792255633605; 
 Sat, 17 Oct 2026 09:47:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd5128f1sm12341233f8f.59.2026.10.17.09.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 09:47:13 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 16:47:12 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia57c539ede73ca4d0fe08b7b03f8bf8652b89ca4
X-Gerrit-Change-Number: 2003
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2003?usp=email>
X-Gerrit-Commit: 38bdb3b3a99bb3a0322a7812c9422543a4200759
References: <gerrit.1792255622000.Ia57c539ede73ca4d0fe08b7b03f8bf8652b89ca4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLklhNTdjNTM5ZWRlNzNjYTRkMGZlMDhiN2IwM2Y4YmY4NjUyYjg5Y2E0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <211c5e0973b032aeb1cc1dee8c651c29154cf6f6-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI7Z2-00068q-HD
Subject: [Openvpn-devel] [M] Change in openvpn[master]:
 crypto_mbedtls_legacy: Sync code with crypto_mbedtls to remove warnings
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3940279158655232684=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3940279158655232684==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G0KyRUWstfE="; charset=UTF-8

--G0KyRUWstfE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2003?usp=3Demail

to review the following change=2E
=


Change subject: crypto_mbedtls_legacy: Sync code with crypto_mbedtls to r=
emove warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


crypto_mbedtls_legacy: Sync code with crypto_mbedtls to remove warnings

=
Generally take the solutions we chose in crypto_mbedtls=2Ec
to avoid conver=
sion warnings and apply them to
crypto_mbedtls_legacy=2Ec=2E

Change-Id: Ia=
57c539ede73ca4d0fe08b7b03f8bf8652b89ca4
Signed-off-by: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
---
M src/openvpn/crypto_mbedtls=2Ec
M src/openvpn/=
crypto_mbedtls_legacy=2Ec
2 files changed, 25 insertions(+), 30 deletions(-=
)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/03/=
2003/1

diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mb=
edtls=2Ec
index 05bb60d=2E=2E81f1a37 100644
--- a/src/openvpn/crypto_mbedtl=
s=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -872,7 +872,7 @@
         hma=
c_ctx_reset(ctx_tmp);
         hmac_ctx_update(ctx, A1, A1_len);
         h=
mac_ctx_update(ctx_tmp, A1, A1_len);
-        hmac_ctx_update(ctx, seed, (i=
nt)seed_len);
+        hmac_ctx_update(ctx, seed, seed_len);
 
         if =
(olen > chunk)
         {
diff --git a/src/openvpn/crypto_mbedtls_legacy=2E=
c b/src/openvpn/crypto_mbedtls_legacy=2Ec
index f46d8bf=2E=2Eed18d30 100644=

--- a/src/openvpn/crypto_mbedtls_legacy=2Ec
+++ b/src/openvpn/crypto_mbedt=
ls_legacy=2Ec
@@ -225,11 +225,6 @@
            "available\n");
 }
 
-#if de=
fined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma=
 GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 crypto_pem_encode(c=
onst char *name, struct buffer *dst, const struct buffer *src,
            =
       struct gc_arena *gc)
@@ -259,7 +254,7 @@
     *dst =3D alloc_buf_gc(=
out_len, gc);
     if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, CB=
PTR(src), BLEN(src), BPTR(dst),
                                           =
BCAP(dst), &out_len))
-        || !buf_inc_len(dst, out_len - 1))
+        =
|| !buf_inc_len(dst, (int)out_len - 1))
     {
         CLEAR(*dst);
      =
   return false;
@@ -365,7 +360,7 @@
 
     while (len > 0)
     {
-       =
 const size_t blen =3D min_int(len, MBEDTLS_CTR_DRBG_MAX_REQUEST);
+       =
 const int blen =3D min_int(len, MBEDTLS_CTR_DRBG_MAX_REQUEST);
         if=
 (0 !=3D mbedtls_ctr_drbg_random(rng_ctx, output, blen))
         {
       =
      return 0;
@@ -447,7 +442,7 @@
         return 0;
     }
 
-    return=
 mbedtls_cipher_info_get_key_bitlen(cipher_kt) / 8;
+    return (unsigned i=
nt)mbedtls_cipher_info_get_key_bitlen(cipher_kt) / 8;
 }
 
 unsigned int
@@=
 -459,7 +454,7 @@
     {
         return 0;
     }
-    return mbedtls_ciph=
er_info_get_iv_size(cipher_kt);
+    return (unsigned int)mbedtls_cipher_in=
fo_get_iv_size(cipher_kt);
 }
 
 unsigned int
@@ -470,7 +465,7 @@
     {
  =
       return 0;
     }
-    return mbedtls_cipher_info_get_block_size(ciph=
er_kt);
+    return (unsigned int)mbedtls_cipher_info_get_block_size(cipher=
_kt);
 }
 
 unsigned int
@@ -694,7 +689,11 @@
         return 0;
     }
 
-=
    *dst_len =3D s_dst_len;
+    if (s_dst_len > INT_MAX)
+    {
+        r=
eturn 0;
+    }
+    *dst_len =3D (int)s_dst_len;
 
     return 1;
 }
@@ -7=
09,7 +708,11 @@
         return 0;
     }
 
-    *dst_len =3D s_dst_len;
+ =
   if (s_dst_len > INT_MAX)
+    {
+        return 0;
+    }
+    *dst_len =
=3D (int)s_dst_len;
 
     return 1;
 }
@@ -740,7 +743,7 @@
     {
        =
 return 0;
     }
-    *dst_len =3D olen;
+    *dst_len =3D (int)olen;
 
  =
   if (!mbed_ok(mbedtls_cipher_check_tag(ctx, (const unsigned char *)tag, t=
ag_len)))
     {
@@ -750,10 +753,6 @@
     return 1;
 }
 
-#if defined(__GN=
UC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  *
 =
 * Generic message digest information functions
@@ -966,11 +965,6 @@
     r=
eturn diff;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC =
diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /=
*
  * Generate the hash required by for the \c tls1_PRF function=2E
  *
@@ =
-984,7 +978,7 @@
  */
 static void
 tls1_P_hash(const mbedtls_md_info_t *md=
_kt, const uint8_t *sec, size_t sec_len, const uint8_t *seed,
-            =
size_t seed_len, uint8_t *out, size_t olen)
+            int seed_len, uint=
8_t *out, size_t olen)
 {
     struct gc_arena gc =3D gc_new();
     uint8_=
t A1[MAX_HMAC_KEY_LENGTH];
@@ -1077,6 +1071,11 @@
     const md_kt_t *md5 =
=3D md_get("MD5");
     const md_kt_t *sha1 =3D md_get("SHA1");
 
+    if (=
label_len > (size_t)INT_MAX)
+    {
+        return false;
+    }
+
     ui=
nt8_t *out2 =3D (uint8_t *)gc_malloc(olen, false, &gc);
 
     size_t len =
=3D slen / 2;
@@ -1084,8 +1083,8 @@
     const uint8_t *S2 =3D &(sec[len]);=

     len +=3D (slen & 1); /* add for odd, make longer */
 
-    tls1_P_has=
h(md5, S1, len, label, label_len, out1, olen);
-    tls1_P_hash(sha1, S2, l=
en, label, label_len, out2, olen);
+    tls1_P_hash(md5, S1, len, label, (i=
nt)label_len, out1, olen);
+    tls1_P_hash(sha1, S2, len, label, (int)labe=
l_len, out2, olen);
 
     for (size_t i =3D 0; i < olen; i++)
     {
@@ -1=
100,9 +1099,5 @@
     return true;
 }
 
-#if defined(__GNUC__) || defined(_=
_clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* MBEDTLS_VERSION_=
NUMBER < 0x040000 */
 #endif /* ENABLE_CRYPTO_MBEDTLS */

-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2003?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: Ia57c539ede73ca4d0fe08b7b03f8bf8652=
b89ca4
Gerrit-Change-Number: 2003
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--G0KyRUWstfE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2003?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">crypto_mbedtls_legacy: Sync code with crypto_mbedtls to re=
move warnings<br><br>Generally take the solutions we chose in crypto_mbedtl=
s=2Ec<br>to avoid conversion warnings and apply them to<br>crypto_mbedtls_l=
egacy=2Ec=2E<br><br>Change-Id: Ia57c539ede73ca4d0fe08b7b03f8bf8652b89ca4<br=
>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br=
>M src/openvpn/crypto_mbedtls=2Ec<br>M src/openvpn/crypto_mbedtls_legacy=2E=
c<br>2 files changed, 25 insertions(+), 30 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/03=
/2003/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/c=
rypto_mbedtls=2Ec</span><br><span>index 05bb60d=2E=2E81f1a37 100644</span><=
br><span>--- a/src/openvpn/crypto_mbedtls=2Ec</span><br><span>+++ b/src/ope=
nvpn/crypto_mbedtls=2Ec</span><br><span>@@ -872,7 +872,7 @@</span><br><span=
>         hmac_ctx_reset(ctx_tmp);</span><br><span>         hmac_ctx_update=
(ctx, A1, A1_len);</span><br><span>         hmac_ctx_update(ctx_tmp, A1, A1=
_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        hmac_ct=
x_update(ctx, seed, (int)seed_len);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        hmac_ctx_update(ctx, seed, seed_len);</span><br><sp=
an> </span><br><span>         if (olen &gt; chunk)</span><br><span>        =
 {</span><br><span>diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src=
/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>index f46d8bf=2E=2Eed18d=
30 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls_legacy=2Ec</span=
><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>@@ -=
225,11 +225,6 @@</span><br><span>            &quot;available\n&quot;);</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot=
;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 bool</span><br><span> crypto_pem_encode(const char *name, struct buffer *d=
st, const struct buffer *src,</span><br><span>                   struct gc_=
arena *gc)</span><br><span>@@ -259,7 +254,7 @@</span><br><span>     *dst =
=3D alloc_buf_gc(out_len, gc);</span><br><span>     if (!mbed_ok(mbedtls_pe=
m_write_buffer(header, footer, CBPTR(src), BLEN(src), BPTR(dst),</span><br>=
<span>                                           BCAP(dst), &amp;out_len))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        || !buf_inc_le=
n(dst, out_len - 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        || !buf_inc_len(dst, (int)out_len - 1))</span><br><span>     {</sp=
an><br><span>         CLEAR(*dst);</span><br><span>         return false;</=
span><br><span>@@ -365,7 +360,7 @@</span><br><span> </span><br><span>     w=
hile (len &gt; 0)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        const size_t blen =3D min_int(len, MBEDTLS_CTR_D=
RBG_MAX_REQUEST);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      const int blen =3D min_int(len, MBEDTLS_CTR_DRBG_MAX_REQUEST);</span>=
<br><span>         if (0 !=3D mbedtls_ctr_drbg_random(rng_ctx, output, blen=
))</span><br><span>         {</span><br><span>             return 0;</span>=
<br><span>@@ -447,7 +442,7 @@</span><br><span>         return 0;</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    return mbedtls_cipher_info_get_key_bitlen(cipher_kt) / 8;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (unsigned int=
)mbedtls_cipher_info_get_key_bitlen(cipher_kt) / 8;</span><br><span> }</spa=
n><br><span> </span><br><span> unsigned int</span><br><span>@@ -459,7 +454,=
7 @@</span><br><span>     {</span><br><span>         return 0;</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
mbedtls_cipher_info_get_iv_size(cipher_kt);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return (unsigned int)mbedtls_cipher_info_get_iv=
_size(cipher_kt);</span><br><span> }</span><br><span> </span><br><span> uns=
igned int</span><br><span>@@ -470,7 +465,7 @@</span><br><span>     {</span>=
<br><span>         return 0;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_cipher_info_get_block_si=
ze(cipher_kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn (unsigned int)mbedtls_cipher_info_get_block_size(cipher_kt);</span><b=
r><span> }</span><br><span> </span><br><span> unsigned int</span><br><span>=
@@ -694,7 +689,11 @@</span><br><span>         return 0;</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    *dst_len =3D s_dst_len;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (s_dst_len &gt; INT_MAX)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *dst_l=
en =3D (int)s_dst_len;</span><br><span> </span><br><span>     return 1;</sp=
an><br><span> }</span><br><span>@@ -709,7 +708,11 @@</span><br><span>      =
   return 0;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    *dst_len =3D s_dst_len;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (s_dst_len &gt; INT_MAX)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    *dst_len =3D (int)s_dst_len;</span><br><span> </s=
pan><br><span>     return 1;</span><br><span> }</span><br><span>@@ -740,7 +=
743,7 @@</span><br><span>     {</span><br><span>         return 0;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *ds=
t_len =3D olen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
*dst_len =3D (int)olen;</span><br><span> </span><br><span>     if (!mbed_ok=
(mbedtls_cipher_check_tag(ctx, (const unsigned char *)tag, tag_len)))</span=
><br><span>     {</span><br><span>@@ -750,10 +753,6 @@</span><br><span>    =
 return 1;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>=
  *</span><br><span>  * Generic message digest information functions</span>=
<br><span>@@ -966,11 +965,6 @@</span><br><span>     return diff;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wcon=
version&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</s=
pan><br><span>  * Generate the hash required by for the \c tls1_PRF functio=
n=2E</span><br><span>  *</span><br><span>@@ -984,7 +978,7 @@</span><br><spa=
n>  */</span><br><span> static void</span><br><span> tls1_P_hash(const mbed=
tls_md_info_t *md_kt, const uint8_t *sec, size_t sec_len, const uint8_t *se=
ed,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            size_t=
 seed_len, uint8_t *out, size_t olen)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            int seed_len, uint8_t *out, size_t olen)</spa=
n><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span>=
<br><span>     uint8_t A1[MAX_HMAC_KEY_LENGTH];</span><br><span>@@ -1077,6 =
+1071,11 @@</span><br><span>     const md_kt_t *md5 =3D md_get(&quot;MD5&qu=
ot;);</span><br><span>     const md_kt_t *sha1 =3D md_get(&quot;SHA1&quot;)=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (label_len &gt; (size_t)INT_MAX)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     uint8_t *out2 =3D (uint8_t *)gc_malloc(olen, false, &amp;gc=
);</span><br><span> </span><br><span>     size_t len =3D slen / 2;</span><b=
r><span>@@ -1084,8 +1083,8 @@</span><br><span>     const uint8_t *S2 =3D &a=
mp;(sec[len]);</span><br><span>     len +=3D (slen &amp; 1); /* add for odd=
, make longer */</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    tls1_P_hash(md5, S1, len, label, label_len, out1, olen);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls1_P_hash(sha1, S=
2, len, label, label_len, out2, olen);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    tls1_P_hash(md5, S1, len, label, (int)label_len, out=
1, olen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls1_P=
_hash(sha1, S2, len, label, (int)label_len, out2, olen);</span><br><span> <=
/span><br><span>     for (size_t i =3D 0; i &lt; olen; i++)</span><br><span=
>     {</span><br><span>@@ -1100,9 +1099,5 @@</span><br><span>     return t=
rue;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* MBEDTLS_VERSION=
_NUMBER &lt; 0x040000 */</span><br><span> #endif /* ENABLE_CRYPTO_MBEDTLS *=
/</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2003?usp=3Demail">change 2003</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2003?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: op=
envpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div=
 style=3D"display:none"> Gerrit-Change-Id: Ia57c539ede73ca4d0fe08b7b03f8bf8=
652b89ca4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2003 </=
div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"d=
isplay:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>

</body></html>
--G0KyRUWstfE=--


--===============3940279158655232684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3940279158655232684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3940279158655232684==--

