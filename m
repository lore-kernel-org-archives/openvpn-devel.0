Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00348606A338
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JQExs4ms;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=azgLJUpW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jQAjzlB0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Dvojn/IJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Z/0XJ/dPasFcg9HYNNJalvUilmrC0Mu9U5Csm8SXTVw=; b=JQExs4msfxiIPBipjv+KOns2YH
	9eK5GxQvYrZs3O4KaToRay0ZVHVSupxT9TxijSOcFT+1dnA/KDxtDOk4XN0ljpTTJMfgjromGa/lF
	t/K4iH0gyUN/ueExHsFh0Rg+RbXN0LfUsAokCKNaU3YxdORBf5w3XppHnU7BNbr/LPVc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSxqI-000000004Xs-2vtx;
	Mon, 16 Nov 2026 14:37:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSxqH-000000004Xk-0CDL
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:37:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=psnepiCqwhu1Ldf8X4AcQ6Nnhx2CMjmTobATUyvhwWU=; b=azgLJUpWh8hAB1/1SAErDTw2ym
 hvOGouXTvsE4pTBsawSzWFhOzAwYrzJAF/gYu+UbmJCG7bS7GvxRVMIIriek9JpBGtzWWbsnNg7Jm
 L8XUj+pVDEh8R/8675iLstYvD012FVEH0VIWEHJInfrOQz7xz4p1Oa5HBtAU11w2lvYY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=psnepiCqwhu1Ldf8X4AcQ6Nnhx2CMjmTobATUyvhwWU=; b=jQAjzlB0YpAci+08ZrV+D7Dc8O
 YwBLLLqSZcVocw5oYUily4fCawvAeugOnx65slcR0EHW/4fSoUq3Q435OtUkdSsAEp13exWgKnMUX
 Yt6zkCnrPAZs50T9ZynhxsF6FCvz/pCdxY4+vd1BRdy8yeRJKr6w8V6mmilCGaBrnwuk=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSxqF-000000000SS-0QmB for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:37:56 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4a32576da88so27158f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794839868; x=1795444668; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=psnepiCqwhu1Ldf8X4AcQ6Nnhx2CMjmTobATUyvhwWU=;
 b=Dvojn/IJLNXiI0AdiQnwLtuwp0DdouCH20gvWrYCZ64/5AXTwvK3F8Ipyw4h1Mc8RC
 Uu45foKDYiCO931q6G9ttoEY3MgJaRGzNkzJhwGiGmI1A21b/HM0j0MPq4s4B1Jy4r5P
 +9BeXiD9IHcekC7WMyRaie4z5bFOwcz6Rx0Hg2XvOU7IcpJ09k2wlPru5UiAYIAuPRKx
 ZLel5KmBV18g4qbrwvD7ABvSHSPkquSF1jgGhPqBkkaXIa8xZdps8pwKOpBU5U7jsGH8
 3nkyXRn3YpVRinQl2PX8aNoQ4aXx5i2jDsfLOPKV5fobEIWq71GPg/ST9dfvRfXlrEQM
 xotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794839868; x=1795444668;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=psnepiCqwhu1Ldf8X4AcQ6Nnhx2CMjmTobATUyvhwWU=;
 b=KJ5wFeF74ne5BUeyYxgw8xvXZhpp/gjf5r+PGKy3ZyJONJ2Sv9U1/ZChaL6iuV0yd1
 MX6ppSHoJQWYDUq+4QzNee5QnZceUST3WX+y49viBSiTeEKxPP+LiF4y9y1rET7idP92
 B6HpUZVmp/Tuq0avxWomhRWs20gpzBJqbupuutH3avj20X/wjJi9bAJcd47asUoNiNfc
 U/AV8MvWUhMsUodGeDlVMOyVF9EHOzl+bOMVSW2CFl8QObDg8x4PfvXVmwGzSRfpw62O
 sCsrj/ulnzjImGq7eHQ2ixuibDbDQOnBBlJf0kV2ZM8oIgVHzxU31VqgMWz6PMTr0Rda
 /oiw==
X-Gm-Message-State: APuU4Z8zQ+O4GY9NI2XeWTxmYzUXdEQ6U7XUGaFUCWAZ2p2r30GSWHmO
 YOCc6auFf4OQO4L0VCibURS1/yLk/oI4/79LHGCiEVrJ7re2GQaGGzmKuBhL553SeQr91K2+crj
 0lJITi7PP9CI2NopCshWnp9b8wmDiFzB+V2oGkPyDZYtFjhf20qrxnX+m9KtEMOxz0IMtyCxWgk
 zwPbmUUA==
X-Gm-Gg: AZFdTZdMkQwMJPqahrUaSPmmAQoq4jrmrDPWf/YPMvZuOW/J3dfu0tGTi7Eg8OWHr1f
 rkjsguKH5kz2LXTe8n6W9zfuuVXIcTlJ3UnVHxswTkuJ0HMPnHPreF2Frl85UH2aW9WE2DPT3C9
 K2ghkySrjxEiU+41rVW7Mo758N2mOS7O8htBJF9huZu+h1TjCAR6satYFkwSXWIZVcA6DOc22kj
 PDH4i/4uW8di1ryo+aOceMbP8O4Gv5xogOl1mnYGoK45BUN9uW2G7ZslPjUHW+HX4PFi0d7bAcp
 4Id9Cqxc1Xo53sdnUSP8vLiYIvcGjFsMVPzFeOwLJ+DcT53Cw+eEoHWdEN2whSA878laLLigdFy
 PheOeKh4knq/PoqDPsjc0jRl7UGBBVnx2GH5xChnW/tdP9wuDRoYSVwMdMP/cR7YoEm7X9wqqZ2
 Ss5bP1k64E5OfMVp7p9l5aAeSlAJr4wOqhMl7oOVN+zdw2sbitV7DZPPY9VqRgHJJVG2QIDiuG1
 k4mdqFB9ac45Zfz16ZtwEhgW4KT14tDIGute7OQXNRuWXGQDi+DV04MUtB5xO4Xsmm9uNyw6T53
 aZa/586jo6NYxcMaGrgydzTn5KMF3LdUqzj9duvS6QFlfbKJotMhmylKoqBOQjog+z8GAiuYMnS
 T46UST+SkH2VDScj5XzmdbCUS1otFQ4BHJVWTbL//l9u0fLJKIZqA4hs76c5SUaDQynh2wMedGs
 54pDi5nEcFg0iLts/R8WMBWDRQwhL4rcgSXm+K
X-Received: by 2002:adf:e011:0:10b0:492:5ef7:5d98 with SMTP id
 ffacd0b85a97d-49c726da84fmr15544661f8f.38.1794839868123; 
 Mon, 16 Nov 2026 06:37:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49dc430fa15sm16357693f8f.13.2026.11.16.06.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:37:47 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:37:47 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
X-Gerrit-Change-Number: 2198
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2198?usp=email>
X-Gerrit-Commit: f876009b2802561292d654c16f7fffa1616bbd1d
References: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLkk5YzI0MDNjMjFlZjhmMjFhMGZiZDk5ODM0NmM4YWQ3MTliNGI5OTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8135f8e882608e0e399cea9db5691607b8b7920f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSxqF-000000000SS-0QmB
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Switch
 buf_forward_capacity and buf_write_set to size_t
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
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
Content-Type: multipart/mixed; boundary="===============6384188311634230947=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6384188311634230947==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gF+fJpRkG94="; charset=UTF-8

--gF+fJpRkG94=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2198?usp=3Demail

to review the following change=2E
=


Change subject: buffer: Switch buf_forward_capacity and buf_write_set to =
size_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buff=
er: Switch buf_forward_capacity and buf_write_set to size_t

To make them c=
onsistent with buf_forward_capacity_total
and buf_read_set that were alread=
y switched=2E

Review call sites=2E

Change-Id: I9c2403c21ef8f21a0fbd998346=
c8ad719b4b9972
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
-=
--
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/crypto=
=2Ec
M src/openvpn/crypto_openssl=2Ec
M src/openvpn/push=2Ec
M src/openvpn/=
ssl_mbedtls=2Ec
M src/openvpn/ssl_ncp=2Ec
M src/openvpn/ssl_openssl=2Ec
M s=
rc/openvpn/status=2Ec
M src/openvpn/tls_crypt=2Ec
M src/openvpn/tun=2Ec
11 =
files changed, 39 insertions(+), 46 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/98/2198/1

diff --git a/src/ope=
nvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index c60936a=2E=2Ec33a987 100644
=
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -234,17 +234,1=
6 @@
     if (buf_defined(buf))
     {
         char *ptr =3D (char *)BEND(=
buf);
-        int cap =3D buf_forward_capacity(buf);
+        size_t cap =
=3D buf_forward_capacity(buf);
 
         if (cap > 1) /* can write more th=
an \0 */
         {
-            int stat;
             va_list arglist;
  =
           va_start(arglist, format);
-            stat =3D vsnprintf(ptr, =
cap, format, arglist);
+            int stat =3D vsnprintf(ptr, cap, format=
, arglist);
             va_end(arglist);
             buf->len +=3D (int)s=
trnlen(ptr, cap);
-            if (stat >=3D 0 && stat < cap)
+            =
if (stat >=3D 0 && stat < (int)cap)
             {
                 ret =3D=
 true;
             }
@@ -257,11 +256,11 @@
 buf_puts(struct buffer *buf, c=
onst char *str)
 {
     char *ptr =3D (char *)BEND(buf);
-    int cap =3D b=
uf_forward_capacity(buf);
+    size_t cap =3D buf_forward_capacity(buf);
  =
   if (cap > 1) /* can write more than \0 */
     {
-        int str_len =
=3D (int)strlcpy(ptr, str, cap);
-        buf->len +=3D (str_len < cap) ? s=
tr_len : cap - 1;
+        size_t str_len =3D strlcpy(ptr, str, cap);
+    =
    buf->len +=3D (str_len < cap) ? (int)str_len : (int)cap - 1;
     }
 }
=
 
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 541f0b=
d=2E=2E32b49d3 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=
=2Eh
@@ -643,11 +643,6 @@
     return true;
 }
 
-#if defined(__GNUC__) || =
defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ign=
ored "-Wsign-conversion"
-#endif
-
 /**
  * Initialise a buffer with an ext=
ernally provided writable memory region=2E
  *
@@ -660,7 +655,7 @@
  * @par=
am size  Size of the memory region in bytes=2E
  */
 static inline void
-bu=
f_set_write(struct buffer *buf, uint8_t *data, int size)
+buf_set_write(str=
uct buffer *buf, uint8_t *data, size_t size)
 {
     if (!buf_size_valid(si=
ze))
     {
@@ -668,7 +663,7 @@
     }
     buf->len =3D 0;
     buf->offse=
t =3D 0;
-    buf->capacity =3D size;
+    buf->capacity =3D (int)size;
   =
  buf->data =3D data;
     if (size > 0 && data)
     {
@@ -1039,7 +1034,7 =
@@
  * @return Number of bytes available for appending, or 0 if \c buf is
 =
 *         invalid=2E
  */
-static inline int
+static inline size_t
 buf_fo=
rward_capacity(const struct buffer *buf)
 {
     if (buf_valid(buf))
@@ -10=
49,7 +1044,7 @@
         {
             ret =3D 0;
         }
-        retu=
rn ret;
+        return (size_t)ret;
     }
     else
     {
@@ -1252,6 +12=
47,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__=
)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conv=
ersion"
+#endif
+
 /**
  * Prepend data to a buffer=2E
  *
diff --git a/src=
/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index db1cb41=2E=2E8b4cc3b 100=
644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1825,7 +1=
825,7 @@
 bool
 generate_ephemeral_key(struct buffer *key, const char *key_=
name)
 {
-    const int len =3D BCAP(key);
+    const int len =3D (int)BCAP=
(key);
 
     msg(M_INFO, "Using random %s=2E", key_name);
 
diff --git a/s=
rc/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec
index 0a1d00=
c=2E=2E1246bc6 100644
--- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/openvp=
n/crypto_openssl=2Ec
@@ -523,7 +523,7 @@
     uint8_t *dst_data =3D buf_wri=
te_alloc(dst, data_read_len);
     if (!dst_data)
     {
-        dmsg(D_CR=
YPT_ERRORS, "%s: dst too small (%i, needs %li)", __func__, BCAP(dst),
+    =
    dmsg(D_CRYPT_ERRORS, "%s: dst too small (%zu, needs %li)", __func__, BC=
AP(dst),
              data_read_len);
         goto cleanup;
     }
diff -=
-git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 6f628b8=2E=2Eeb111=
07 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -805,7 +=
805,7 @@
 #endif
 
 static bool
-send_push_options(struct context *c, struc=
t buffer *buf, struct push_list *push_list, int safe_cap,
+send_push_option=
s(struct context *c, struct buffer *buf, struct push_list *push_list, size_=
t safe_cap,
                   bool *push_sent, bool *multi_push)
 {
     s=
truct push_entry *e =3D push_list->head;
@@ -820,7 +820,7 @@
              =
   msg(M_WARN, "--push option is too long");
                 return false;=

             }
-            if (BLEN(buf) + (int)l >=3D safe_cap)
+       =
     if (BLENZ(buf) + l >=3D safe_cap)
             {
                 buf_=
printf(buf, ",push-continuation 2");
                 {
@@ -835,7 +835,7 @@=

                     buf_printf(buf, "%s", push_reply_cmd);
              =
   }
             }
-            if (BLEN(buf) + (int)l >=3D safe_cap)
+   =
         if (BLENZ(buf) + l >=3D safe_cap)
             {
                 =
msg(M_WARN, "--push option is too long");
                 return false;
@@=
 -873,8 +873,8 @@
     struct gc_arena gc =3D gc_new();
     struct buffer =
buf =3D alloc_buf_gc(PUSH_BUNDLE_SIZE, &gc);
     bool multi_push =3D false=
;
-    const int extra =3D 84; /* extra space for possible trailing ifconfi=
g and push-continuation */
-    const int safe_cap =3D BCAP(&buf) - extra;
=
+    const size_t extra =3D 84; /* extra space for possible trailing ifconf=
ig and push-continuation */
+    const size_t safe_cap =3D BCAP(&buf) - ext=
ra;
     bool push_sent =3D false;
 
     buf_printf(&buf, "%s", push_reply=
_cmd);
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=
=2Ec
index aa843c1=2E=2E2d29e60 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
++=
+ b/src/openvpn/ssl_mbedtls=2Ec
@@ -1068,7 +1068,6 @@
 key_state_read_ciphe=
rtext(struct key_state_ssl *ks, struct buffer *buf)
 {
     int retval =3D =
0;
-    int len =3D 0;
 
     ASSERT(NULL !=3D ks);
     ASSERT(buf);
@@ -1=
079,9 +1078,7 @@
         return 0;
     }
 
-    len =3D buf_forward_capac=
ity(buf);
-
-    retval =3D endless_buf_read(&ks->bio_ctx->out, BPTR(buf), =
len);
+    retval =3D endless_buf_read(&ks->bio_ctx->out, BPTR(buf), BCAP(b=
uf));
 
     /* Error during read, check for retry error */
     if (retval=
 < 0)
@@ -1153,7 +1150,6 @@
 key_state_read_plaintext(struct key_state_ssl =
*ks, struct buffer *buf)
 {
     int retval =3D 0;
-    int len =3D 0;
 
  =
   ASSERT(NULL !=3D ks);
     ASSERT(buf);
@@ -1164,9 +1160,7 @@
         r=
eturn 0;
     }
 
-    len =3D buf_forward_capacity(buf);
-
-    retval =3D=
 mbedtls_ssl_read(ks->ctx, BPTR(buf), len);
+    retval =3D mbedtls_ssl_rea=
d(ks->ctx, BPTR(buf), BCAP(buf));
 
     /* Error during read, check for re=
try error */
     if (retval < 0)
diff --git a/src/openvpn/ssl_ncp=2Ec b/sr=
c/openvpn/ssl_ncp=2Ec
index df9e42c=2E=2E0f4c94c 100644
--- a/src/openvpn/s=
sl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -154,7 +154,7 @@
             }=

 
             /* Ensure buffer has capacity for cipher name + : + \0 */
-=
            if (buf_forward_capacity(&new_list) < (int)strlen(ovpn_cipher_n=
ame) + 2)
+            if (buf_forward_capacity(&new_list) < strlen(ovpn_ci=
pher_name) + 2)
             {
                 msg(M_WARN, "Length of --da=
ta-ciphers is over the "
                             "limit of 127 chars")=
;
@@ -564,7 +564,7 @@
 
     struct buffer ncp_ciphers_buf;
     ASSERT(ncp=
_ciphers_len <=3D INT_MAX);
-    buf_set_write(&ncp_ciphers_buf, ncp_cipher=
s, (int)ncp_ciphers_len);
+    buf_set_write(&ncp_ciphers_buf, ncp_ciphers,=
 ncp_ciphers_len);
 
     const char *def =3D strstr(o->ncp_ciphers, search=
);
 
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec=

index e190935=2E=2E7622d88 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/=
src/openvpn/ssl_openssl=2Ec
@@ -2163,13 +2163,12 @@
          * if the buff=
er is not empty */
         return 0;
     }
-    int len =3D buf_forward_c=
apacity(buf);
 
     /*
      * BIO_read brackets most of the serious RSA
 =
     * key negotiation number crunching=2E
      */
-    int i =3D BIO_read=
(bio, BPTR(buf), len);
+    int i =3D BIO_read(bio, BPTR(buf), (int)BCAP(bu=
f));
 
     VALGRIND_MAKE_READABLE((void *)&i, sizeof(i));
 
diff --git a/s=
rc/openvpn/status=2Ec b/src/openvpn/status=2Ec
index 533619f=2E=2E73cf28a 1=
00644
--- a/src/openvpn/status=2Ec
+++ b/src/openvpn/status=2Ec
@@ -281,7 +=
281,7 @@
             if (c =3D=3D -1)
             {
                 ASSE=
RT(buf_init(&so->read_buf, 0));
-                ssize_t len =3D read(so->f=
d, BPTR(&so->read_buf), BCAP(&so->read_buf));
+                ssize_t len =
=3D read(so->fd, BPTR(&so->read_buf), (unsigned int)BCAP(&so->read_buf));
 =
                if (len <=3D 0)
                 {
                     bre=
ak;
diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
inde=
x d7f69f7=2E=2E5617ad3 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/ope=
nvpn/tls_crypt=2Ec
@@ -380,8 +380,8 @@
         msg(M_WARN, "ERROR: could n=
ot write tag");
         return false;
     }
-    const int data_len =3D B=
LEN(src_metadata) + sizeof(src_key->keys) + sizeof(uint16_t);
-    const in=
t tagged_len =3D data_len + TLS_CRYPT_TAG_SIZE;
+    const size_t data_len =
=3D BLENZ(src_metadata) + sizeof(src_key->keys) + sizeof(uint16_t);
+    co=
nst size_t tagged_len =3D data_len + TLS_CRYPT_TAG_SIZE;
     const uint16_=
t net_len =3D htons((uint16_t)tagged_len);
     hmac_ctx_t *hmac_ctx =3D se=
rver_key->hmac;
     hmac_ctx_reset(hmac_ctx);
@@ -396,7 +396,7 @@
     ASS=
ERT(cipher_ctx_reset(cipher_ctx, tag));
 
     /* Overflow check (OpenSSL r=
equires an extra block in the dst buffer) */
-    const int padded_len =3D =
data_len + cipher_ctx_block_size(cipher_ctx);
+    const size_t padded_len =
=3D data_len + cipher_ctx_block_size(cipher_ctx);
     if (buf_forward_capa=
city(&work) < padded_len)
     {
         msg(M_WARN, "ERROR: could not cry=
pt: insufficient space in dst");
@@ -735,7 +735,7 @@
         size_t b64_le=
ngth =3D strlen(b64_metadata);
         metadata =3D alloc_buf_gc(OPENVPN_B=
ASE64_DECODED_LENGTH(b64_length) + 1, &gc);
         ASSERT(buf_write(&meta=
data, &TLS_CRYPT_METADATA_TYPE_USER, 1));
-        int decoded_len =3D open=
vpn_base64_decode(b64_metadata, BEND(&metadata), BCAP(&metadata));
+       =
 int decoded_len =3D openvpn_base64_decode(b64_metadata, BEND(&metadata), (=
int)BCAP(&metadata));
         if (decoded_len < 0)
         {
            =
 msg(M_FATAL, "ERROR: failed to base64 decode provided metadata");
diff --g=
it a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 0ba8a4a=2E=2Ec56ace3 1=
00644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -4008,7 +4008,=
7 @@
  * registry for the TAP device # =3D device_number=2E
  */
 static co=
nst char *
-get_unspecified_device_guid(const int device_number, uint8_t *a=
ctual_name, int actual_name_size,
+get_unspecified_device_guid(const int de=
vice_number, uint8_t *actual_name, size_t actual_name_size,
               =
              const struct tap_reg *tap_reg_src,
                          =
   const struct panel_reg *panel_reg_src,
                             enum=
 tun_driver_type *windows_driver, struct gc_arena *gc)
@@ -4071,7 +4071,7 @=
@
  * returning the GUID and optional actual_name and device type
  */
 sta=
tic const char *
-get_device_guid(const char *name, uint8_t *actual_name, i=
nt actual_name_size,
+get_device_guid(const char *name, uint8_t *actual_nam=
e, size_t actual_name_size,
                 enum tun_driver_type *windows_=
driver, const struct tap_reg *tap_reg,
                 const struct panel_=
reg *panel_reg, struct gc_arena *gc)
 {
@@ -6087,8 +6087,9 @@
     {
      =
   struct buffer out =3D alloc_buf_gc(256, gc);
         DWORD len;
-      =
  if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_INFO, BSTR(&out), BCAP(&o=
ut), BSTR(&out),
-                            BCAP(&out), &len, NULL))
+   =
     if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_INFO, BSTR(&out),
+   =
                         (DWORD)BCAP(&out), BSTR(&out),
+                  =
          (DWORD)BCAP(&out), &len, NULL))
         {
             return BS=
TR(&out);
         }
@@ -6103,8 +6104,8 @@
     {
         struct buffer ou=
t =3D alloc_buf(1024);
         DWORD len;
-        while (DeviceIoControl(=
tt->hand, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(&out), BCAP(&out),
-            =
                   BSTR(&out), BCAP(&out), &len, NULL))
+        while (Dev=
iceIoControl(tt->hand, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(&out), (DWORD)BCAP(=
&out),
+                               BSTR(&out), (DWORD)BCAP(&out), &len,=
 NULL))
         {
             msg(D_TAP_WIN_DEBUG, "TAP-Windows: %s", BST=
R(&out));
         }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2198?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
Gerrit-Change-Number: 2198
Ge=
rrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>

--gF+fJpRkG94=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">buffer: Switch buf_forward_capacity and buf_write_set to s=
ize_t<br><br>To make them consistent with buf_forward_capacity_total<br>and=
 buf_read_set that were already switched=2E<br><br>Review call sites=2E<br>=
<br>Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/b=
uffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/crypto=2Ec<br>M src/=
openvpn/crypto_openssl=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/ssl_m=
bedtls=2Ec<br>M src/openvpn/ssl_ncp=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br=
>M src/openvpn/status=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>M src/openvpn/t=
un=2Ec<br>11 files changed, 39 insertions(+), 46 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/98/2198/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buf=
fer=2Ec</span><br><span>index c60936a=2E=2Ec33a987 100644</span><br><span>-=
-- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</s=
pan><br><span>@@ -234,17 +234,16 @@</span><br><span>     if (buf_defined(bu=
f))</span><br><span>     {</span><br><span>         char *ptr =3D (char *)B=
END(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int =
cap =3D buf_forward_capacity(buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        size_t cap =3D buf_forward_capacity(buf);</span><br>=
<span> </span><br><span>         if (cap &gt; 1) /* can write more than \0 =
*/</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            int stat;</span><br><span>             va_list arglist;=
</span><br><span>             va_start(arglist, format);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            stat =3D vsnprintf(ptr, cap,=
 format, arglist);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           int stat =3D vsnprintf(ptr, cap, format, arglist);</span><br><sp=
an>             va_end(arglist);</span><br><span>             buf-&gt;len +=
=3D (int)strnlen(ptr, cap);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if (stat &gt;=3D 0 &amp;&amp; stat &lt; cap)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (stat &gt;=3D 0 &=
amp;&amp; stat &lt; (int)cap)</span><br><span>             {</span><br><spa=
n>                 ret =3D true;</span><br><span>             }</span><br><=
span>@@ -257,11 +256,11 @@</span><br><span> buf_puts(struct buffer *buf, co=
nst char *str)</span><br><span> {</span><br><span>     char *ptr =3D (char =
*)BEND(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int c=
ap =3D buf_forward_capacity(buf);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    size_t cap =3D buf_forward_capacity(buf);</span><br><span=
>     if (cap &gt; 1) /* can write more than \0 */</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int str_len =3D=
 (int)strlcpy(ptr, str, cap);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        buf-&gt;len +=3D (str_len &lt; cap) ? str_len : cap - 1;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t str_len=
 =3D strlcpy(ptr, str, cap);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        buf-&gt;len +=3D (str_len &lt; cap) ? (int)str_len : (int)=
cap - 1;</span><br><span>     }</span><br><span> }</span><br><span> </span>=
<br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</spa=
n><br><span>index 541f0bd=2E=2E32b49d3 100644</span><br><span>--- a/src/ope=
nvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><spa=
n>@@ -643,11 +643,6 @@</span><br><span>     return true;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conver=
sion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</spa=
n><br><span>  * Initialise a buffer with an externally provided writable me=
mory region=2E</span><br><span>  *</span><br><span>@@ -660,7 +655,7 @@</spa=
n><br><span>  * @param size  Size of the memory region in bytes=2E</span><b=
r><span>  */</span><br><span> static inline void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-buf_set_write(struct buffer *buf, uint8_t *data,=
 int size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_set_w=
rite(struct buffer *buf, uint8_t *data, size_t size)</span><br><span> {</sp=
an><br><span>     if (!buf_size_valid(size))</span><br><span>     {</span><=
br><span>@@ -668,7 +663,7 @@</span><br><span>     }</span><br><span>     bu=
f-&gt;len =3D 0;</span><br><span>     buf-&gt;offset =3D 0;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    buf-&gt;capacity =3D size;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    buf-&gt;capacity =3D (=
int)size;</span><br><span>     buf-&gt;data =3D data;</span><br><span>     =
if (size &gt; 0 &amp;&amp; data)</span><br><span>     {</span><br><span>@@ =
-1039,7 +1034,7 @@</span><br><span>  * @return Number of bytes available fo=
r appending, or 0 if \c buf is</span><br><span>  *         invalid=2E</span=
><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static i=
nline size_t</span><br><span> buf_forward_capacity(const struct buffer *buf=
)</span><br><span> {</span><br><span>     if (buf_valid(buf))</span><br><sp=
an>@@ -1049,7 +1044,7 @@</span><br><span>         {</span><br><span>       =
      ret =3D 0;</span><br><span>         }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return ret;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return (size_t)ret;</span><br><span>     }</s=
pan><br><span>     else</span><br><span>     {</span><br><span>@@ -1252,6 +=
1247,11 @@</span><br><span>     return true;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span>=
<br><span>  * Prepend data to a buffer=2E</span><br><span>  *</span><br><sp=
an>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><=
span>index db1cb41=2E=2E8b4cc3b 100644</span><br><span>--- a/src/openvpn/cr=
ypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1=
825,7 +1825,7 @@</span><br><span> bool</span><br><span> generate_ephemeral_=
key(struct buffer *key, const char *key_name)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const int len =3D BCAP(key);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int len =
=3D (int)BCAP(key);</span><br><span> </span><br><span>     msg(M_INFO, &quo=
t;Using random %s=2E&quot;, key_name);</span><br><span> </span><br><span>di=
ff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec<=
/span><br><span>index 0a1d00c=2E=2E1246bc6 100644</span><br><span>--- a/src=
/openvpn/crypto_openssl=2Ec</span><br><span>+++ b/src/openvpn/crypto_openss=
l=2Ec</span><br><span>@@ -523,7 +523,7 @@</span><br><span>     uint8_t *dst=
_data =3D buf_write_alloc(dst, data_read_len);</span><br><span>     if (!ds=
t_data)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        dmsg(D_CRYPT_ERRORS, &quot;%s: dst too small (%i, needs %l=
i)&quot;, __func__, BCAP(dst),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        dmsg(D_CRYPT_ERRORS, &quot;%s: dst too small (%zu, needs=
 %li)&quot;, __func__, BCAP(dst),</span><br><span>              data_read_l=
en);</span><br><span>         goto cleanup;</span><br><span>     }</span><b=
r><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br>=
<span>index 6f628b8=2E=2Eeb11107 100644</span><br><span>--- a/src/openvpn/p=
ush=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -805,=
7 +805,7 @@</span><br><span> #endif</span><br><span> </span><br><span> stat=
ic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-send_push_opti=
ons(struct context *c, struct buffer *buf, struct push_list *push_list, int=
 safe_cap,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_push=
_options(struct context *c, struct buffer *buf, struct push_list *push_list=
, size_t safe_cap,</span><br><span>                   bool *push_sent, bool=
 *multi_push)</span><br><span> {</span><br><span>     struct push_entry *e =
=3D push_list-&gt;head;</span><br><span>@@ -820,7 +820,7 @@</span><br><span=
>                 msg(M_WARN, &quot;--push option is too long&quot;);</span=
><br><span>                 return false;</span><br><span>             }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (BLEN(buf=
) + (int)l &gt;=3D safe_cap)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (BLENZ(buf) + l &gt;=3D safe_cap)</span><br><span> =
            {</span><br><span>                 buf_printf(buf, &quot;,push-=
continuation 2&quot;);</span><br><span>                 {</span><br><span>@=
@ -835,7 +835,7 @@</span><br><span>                     buf_printf(buf, &qu=
ot;%s&quot;, push_reply_cmd);</span><br><span>                 }</span><br>=
<span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           if (BLEN(buf) + (int)l &gt;=3D safe_cap)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (BLENZ(buf) + l &gt;=3D sa=
fe_cap)</span><br><span>             {</span><br><span>                 msg=
(M_WARN, &quot;--push option is too long&quot;);</span><br><span>          =
       return false;</span><br><span>@@ -873,8 +873,8 @@</span><br><span>  =
   struct gc_arena gc =3D gc_new();</span><br><span>     struct buffer buf =
=3D alloc_buf_gc(PUSH_BUNDLE_SIZE, &amp;gc);</span><br><span>     bool mult=
i_push =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
const int extra =3D 84; /* extra space for possible trailing ifconfig and p=
ush-continuation */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const int safe_cap =3D BCAP(&amp;buf) - extra;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const size_t extra =3D 84; /* extra space =
for possible trailing ifconfig and push-continuation */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const size_t safe_cap =3D BCAP(&amp=
;buf) - extra;</span><br><span>     bool push_sent =3D false;</span><br><sp=
an> </span><br><span>     buf_printf(&amp;buf, &quot;%s&quot;, push_reply_c=
md);</span><br><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn=
/ssl_mbedtls=2Ec</span><br><span>index aa843c1=2E=2E2d29e60 100644</span><b=
r><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn=
/ssl_mbedtls=2Ec</span><br><span>@@ -1068,7 +1068,6 @@</span><br><span> key=
_state_read_ciphertext(struct key_state_ssl *ks, struct buffer *buf)</span>=
<br><span> {</span><br><span>     int retval =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int len =3D 0;</span><br><span> </span>=
<br><span>     ASSERT(NULL !=3D ks);</span><br><span>     ASSERT(buf);</spa=
n><br><span>@@ -1079,9 +1078,7 @@</span><br><span>         return 0;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    len =3D buf_forward_capacity(buf);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    retval =3D endless_buf_read(&amp;ks-&gt;bio_ctx-&gt;out, BPT=
R(buf), len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
tval =3D endless_buf_read(&amp;ks-&gt;bio_ctx-&gt;out, BPTR(buf), BCAP(buf)=
);</span><br><span> </span><br><span>     /* Error during read, check for r=
etry error */</span><br><span>     if (retval &lt; 0)</span><br><span>@@ -1=
153,7 +1150,6 @@</span><br><span> key_state_read_plaintext(struct key_state=
_ssl *ks, struct buffer *buf)</span><br><span> {</span><br><span>     int r=
etval =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int l=
en =3D 0;</span><br><span> </span><br><span>     ASSERT(NULL !=3D ks);</spa=
n><br><span>     ASSERT(buf);</span><br><span>@@ -1164,9 +1160,7 @@</span><=
br><span>         return 0;</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    len =3D buf_forward_capa=
city(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    retval =3D mbedtls_ssl_read(=
ks-&gt;ctx, BPTR(buf), len);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    retval =3D mbedtls_ssl_read(ks-&gt;ctx, BPTR(buf), BCAP(buf));=
</span><br><span> </span><br><span>     /* Error during read, check for ret=
ry error */</span><br><span>     if (retval &lt; 0)</span><br><span>diff --=
git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>ind=
ex df9e42c=2E=2E0f4c94c 100644</span><br><span>--- a/src/openvpn/ssl_ncp=2E=
c</span><br><span>+++ b/src/openvpn/ssl_ncp=2Ec</span><br><span>@@ -154,7 +=
154,7 @@</span><br><span>             }</span><br><span> </span><br><span> =
            /* Ensure buffer has capacity for cipher name + : + \0 */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (buf_forward=
_capacity(&amp;new_list) &lt; (int)strlen(ovpn_cipher_name) + 2)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (buf_forward_ca=
pacity(&amp;new_list) &lt; strlen(ovpn_cipher_name) + 2)</span><br><span>  =
           {</span><br><span>                 msg(M_WARN, &quot;Length of -=
-data-ciphers is over the &quot;</span><br><span>                          =
   &quot;limit of 127 chars&quot;);</span><br><span>@@ -564,7 +564,7 @@</sp=
an><br><span> </span><br><span>     struct buffer ncp_ciphers_buf;</span><b=
r><span>     ASSERT(ncp_ciphers_len &lt;=3D INT_MAX);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    buf_set_write(&amp;ncp_ciphers_buf, ncp=
_ciphers, (int)ncp_ciphers_len);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    buf_set_write(&amp;ncp_ciphers_buf, ncp_ciphers, ncp_ciphe=
rs_len);</span><br><span> </span><br><span>     const char *def =3D strstr(=
o-&gt;ncp_ciphers, search);</span><br><span> </span><br><span>diff --git a/=
src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>i=
ndex e190935=2E=2E7622d88 100644</span><br><span>--- a/src/openvpn/ssl_open=
ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@=
@ -2163,13 +2163,12 @@</span><br><span>          * if the buffer is not emp=
ty */</span><br><span>         return 0;</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    int len =3D buf_forward_capac=
ity(buf);</span><br><span> </span><br><span>     /*</span><br><span>      *=
 BIO_read brackets most of the serious RSA</span><br><span>      * key nego=
tiation number crunching=2E</span><br><span>      */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i =3D BIO_read(bio, BPTR(buf), len)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i =3D BIO_=
read(bio, BPTR(buf), (int)BCAP(buf));</span><br><span> </span><br><span>   =
  VALGRIND_MAKE_READABLE((void *)&amp;i, sizeof(i));</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/status=2Ec b/src/openvpn/status=2Ec</s=
pan><br><span>index 533619f=2E=2E73cf28a 100644</span><br><span>--- a/src/o=
penvpn/status=2Ec</span><br><span>+++ b/src/openvpn/status=2Ec</span><br><s=
pan>@@ -281,7 +281,7 @@</span><br><span>             if (c =3D=3D -1)</span=
><br><span>             {</span><br><span>                 ASSERT(buf_init(=
&amp;so-&gt;read_buf, 0));</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                ssize_t len =3D read(so-&gt;fd, BPTR(&amp;so-&gt;read_=
buf), BCAP(&amp;so-&gt;read_buf));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                ssize_t len =3D read(so-&gt;fd, BPTR(&amp;so=
-&gt;read_buf), (unsigned int)BCAP(&amp;so-&gt;read_buf));</span><br><span>=
                 if (len &lt;=3D 0)</span><br><span>                 {</spa=
n><br><span>                     break;</span><br><span>diff --git a/src/op=
envpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index d7f69=
f7=2E=2E5617ad3 100644</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</spa=
n><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -380,8 +380,=
8 @@</span><br><span>         msg(M_WARN, &quot;ERROR: could not write tag&=
quot;);</span><br><span>         return false;</span><br><span>     }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int data_len =3D =
BLEN(src_metadata) + sizeof(src_key-&gt;keys) + sizeof(uint16_t);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    const int tagged_len =3D da=
ta_len + TLS_CRYPT_TAG_SIZE;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const size_t data_len =3D BLENZ(src_metadata) + sizeof(src_key=
-&gt;keys) + sizeof(uint16_t);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const size_t tagged_len =3D data_len + TLS_CRYPT_TAG_SIZE;</=
span><br><span>     const uint16_t net_len =3D htons((uint16_t)tagged_len);=
</span><br><span>     hmac_ctx_t *hmac_ctx =3D server_key-&gt;hmac;</span><=
br><span>     hmac_ctx_reset(hmac_ctx);</span><br><span>@@ -396,7 +396,7 @@=
</span><br><span>     ASSERT(cipher_ctx_reset(cipher_ctx, tag));</span><br>=
<span> </span><br><span>     /* Overflow check (OpenSSL requires an extra b=
lock in the dst buffer) */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    const int padded_len =3D data_len + cipher_ctx_block_size(cipher_c=
tx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_=
t padded_len =3D data_len + cipher_ctx_block_size(cipher_ctx);</span><br><s=
pan>     if (buf_forward_capacity(&amp;work) &lt; padded_len)</span><br><sp=
an>     {</span><br><span>         msg(M_WARN, &quot;ERROR: could not crypt=
: insufficient space in dst&quot;);</span><br><span>@@ -735,7 +735,7 @@</sp=
an><br><span>         size_t b64_length =3D strlen(b64_metadata);</span><br=
><span>         metadata =3D alloc_buf_gc(OPENVPN_BASE64_DECODED_LENGTH(b64=
_length) + 1, &amp;gc);</span><br><span>         ASSERT(buf_write(&amp;meta=
data, &amp;TLS_CRYPT_METADATA_TYPE_USER, 1));</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        int decoded_len =3D openvpn_base64_decode(b=
64_metadata, BEND(&amp;metadata), BCAP(&amp;metadata));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        int decoded_len =3D openvpn_bas=
e64_decode(b64_metadata, BEND(&amp;metadata), (int)BCAP(&amp;metadata));</s=
pan><br><span>         if (decoded_len &lt; 0)</span><br><span>         {</=
span><br><span>             msg(M_FATAL, &quot;ERROR: failed to base64 deco=
de provided metadata&quot;);</span><br><span>diff --git a/src/openvpn/tun=
=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 0ba8a4a=2E=2Ec56ace3 10064=
4</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openv=
pn/tun=2Ec</span><br><span>@@ -4008,7 +4008,7 @@</span><br><span>  * regist=
ry for the TAP device # =3D device_number=2E</span><br><span>  */</span><br=
><span> static const char *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-get_unspecified_device_guid(const int device_number, uint8_t *actual_=
name, int actual_name_size,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+get_unspecified_device_guid(const int device_number, uint8_t *actua=
l_name, size_t actual_name_size,</span><br><span>                          =
   const struct tap_reg *tap_reg_src,</span><br><span>                     =
        const struct panel_reg *panel_reg_src,</span><br><span>            =
                 enum tun_driver_type *windows_driver, struct gc_arena *gc)=
</span><br><span>@@ -4071,7 +4071,7 @@</span><br><span>  * returning the GU=
ID and optional actual_name and device type</span><br><span>  */</span><br>=
<span> static const char *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-get_device_guid(const char *name, uint8_t *actual_name, int actual_nam=
e_size,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_device_g=
uid(const char *name, uint8_t *actual_name, size_t actual_name_size,</span>=
<br><span>                 enum tun_driver_type *windows_driver, const stru=
ct tap_reg *tap_reg,</span><br><span>                 const struct panel_re=
g *panel_reg, struct gc_arena *gc)</span><br><span> {</span><br><span>@@ -6=
087,8 +6087,9 @@</span><br><span>     {</span><br><span>         struct buf=
fer out =3D alloc_buf_gc(256, gc);</span><br><span>         DWORD len;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (DeviceIoContro=
l(tt-&gt;hand, TAP_WIN_IOCTL_GET_INFO, BSTR(&amp;out), BCAP(&amp;out), BSTR=
(&amp;out),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                  BCAP(&amp;out), &amp;len, NULL))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (DeviceIoControl(tt-&gt;hand, TAP=
_WIN_IOCTL_GET_INFO, BSTR(&amp;out),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                            (DWORD)BCAP(&amp;out), BSTR(&a=
mp;out),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                 (DWORD)BCAP(&amp;out), &amp;len, NULL))</span><br><span>  =
       {</span><br><span>             return BSTR(&amp;out);</span><br><spa=
n>         }</span><br><span>@@ -6103,8 +6104,8 @@</span><br><span>     {</=
span><br><span>         struct buffer out =3D alloc_buf(1024);</span><br><s=
pan>         DWORD len;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        while (DeviceIoControl(tt-&gt;hand, TAP_WIN_IOCTL_GET_LOG_LINE, B=
STR(&amp;out), BCAP(&amp;out),</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                               BSTR(&amp;out), BCAP(&amp;out), &am=
p;len, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  while (DeviceIoControl(tt-&gt;hand, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(&amp=
;out), (DWORD)BCAP(&amp;out),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                               BSTR(&amp;out), (DWORD)BCAP(&amp;o=
ut), &amp;len, NULL))</span><br><span>         {</span><br><span>          =
   msg(D_TAP_WIN_DEBUG, &quot;TAP-Windows: %s&quot;, BSTR(&amp;out));</span=
><br><span>         }</span><br></pre><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail">change 2198</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9c2403c21ef=
8f21a0fbd998346c8ad719b4b9972 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2198 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--gF+fJpRkG94=--


--===============6384188311634230947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6384188311634230947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6384188311634230947==--

