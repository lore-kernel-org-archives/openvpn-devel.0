Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA9606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aflP1Rrm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RbmPy4+K;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O8hp2bKN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aoDf12+j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Gp1DdQ8hXR1S7GkDWnBJ8L7/XGqRkkC9WCKBjFb/nRs=; b=aflP1Rrm2+IDwSXwplkTKuH4Kf
	VjNzpe/W6VMuAgnHeTvzOlBVEdWzOv+rseE7nvINF5iwBs7Vzx1nTnhAsvF/4rNLWNqOoj8iAqUqz
	bUNA000qvZbEUsPFF1U5dvh1ioUXcFFzPOHGv4pmaKrSeF5EOy02Ua9JsYA/a3WumP4Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPFg9-000000001lX-3bdR;
	Fri, 06 Nov 2026 08:52:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPFg7-000000001lP-3IFF
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 08:52:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RmYmO1vBek+6dLvD4J47mZAEBsA+QbxaBpQt23Ttgug=; b=RbmPy4+KoR9IzD8LShgZv5kQVp
 7iK3WOlx7yOiz6r2zB10pg982Dv8ghO2RS4GompzTIak1F4QhkNP4tzNyCsmsYu8y7f1ceSvzZ6gK
 +VeWVDCDvWfN4uYTRdWL6UtVoBia6ofNPDYxtMMv0lmWRSjcKp64R/key9ZXXdQMMFOw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RmYmO1vBek+6dLvD4J47mZAEBsA+QbxaBpQt23Ttgug=; b=O8hp2bKNfubmjGO/QWejazRyRY
 3FEWq84QR0OnHgY3v+RixPllfngFVPhiaiZQlV+sJ0fuMYzv1fTWqFsrd6uN7KatSPrFTXz3ackUm
 fyZpRQcyMWZYGjgfZGI6hsLOoyYrg7zrXvjPeCjey8wPK9yqqDjgVIBpMyZUDmuFMHmg=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPFg4-000000006kl-1s1h for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 08:52:07 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so2286295e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 00:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793955118; x=1794559918; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RmYmO1vBek+6dLvD4J47mZAEBsA+QbxaBpQt23Ttgug=;
 b=aoDf12+jpZszWbRh1vhM8INlEgcr3Y3hG6FUpICpdMyz8d0sk75Squu6LZIRN8osom
 2O1DRRi8TGVRz9doAkzeA6BRiMlt/ejPhOPV2VtXJFcRuKuN8k0RSd3/r86fZAkeav1m
 0/F6MFn7fgRyfkA3mrV6+7KKKMPiBQGBpB28/GTCfkv0N06TuKDmAc+fcQeXmrwSTf+T
 E4ANPiLvijo0+UyTvjprT7wlCTjlaXW4wiz/4eq2PSZGq/04Oz0FVzhGWkjmA/N7eeTU
 BLs+zCy31zMTK3NuJlMGzjnE7Y/Bk31+rHDtlQaHOPSzRpoKicsKKCiVR7a4eynf+xGY
 Mj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793955118; x=1794559918;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RmYmO1vBek+6dLvD4J47mZAEBsA+QbxaBpQt23Ttgug=;
 b=LiC7pd8BeDUs4P/96osQoRXDTZauJTAT8mAdJLTFrddfdTVpDNLg8hZkKE+NOcvJ2X
 1n3/wdi+ydQIfsSPGhhLjpgI/xLLFOcVLBZ548r1TDl66tEB8AaB+qPGNnbc+b2dKjF2
 zqPFCmts8+G8/bjvIt66xWFoL0UZ43bc2ijRm5EUNWne9hNBcYaLPzhW1Q1KAQTg2/Jy
 4Rfm7pnriOMpzV35VppjRnRS0MEhR3tpmE4iZmXlD5XtTeT6lKFE/JnKAPtAhttC1e1m
 yscxEwTk4QnYQ+0tSwcsHYoUlhU/FNWXD7yrE+Uc0v5zuc4V6gjW3bEh9WzNiKKsrfO5
 Iatg==
X-Gm-Message-State: APuU4Z9ZfGyOSxOJuOl+fwTdaMXbJIJx9IkvGRd8tyu1jLEX2lxxi/mo
 Uq7ohRKjckYz7PqCVr1pfj8efl9nDfgVOoU9V5ZBpTG657j/MevlySt0VovlDt+bi/vvzWP6Qb4
 OulvRyz+DSVwRDLkdbXiaGQpkeSACcQ1uPAbosRwl5S4xfHcWgNUGVcP1lIb9+qYaO514JV0Xgr
 bwVOu87w==
X-Gm-Gg: AYBFou2xAuyrxCfeHslSgrPG5u5oG1RHHPGG6rF9fR94KLcBLkFPrYfTtMJ/2Gcaw30
 aVBsXiLe7cl4nJGmr+OklmjtFpj2AdVWuDy0ktnlMVPCZ4eZWZu9SNKj0iZy0ks1Yt+8R5IN+QG
 HX+xrvgTfpSxK5Z0z1PFfRgNi9kbNmPI40epSd/bD6TB/8JNsK+7u3nGQ98ok1lnqYVtqpDbyBl
 Pt7LJ/M2T2bFlAWFR7/yvPuwQ81P+Y03CJ2EdXhlTnH3wmPtlLP/LPrODf2kuIZsfqkDMG5Pa8c
 GxgiimEaass9kjgfqYGxsHK0jv1IxuwKK5iw9D4Y/+SbJ1p5SeMygTW43L3m3462z0lGlp6wC7Y
 +td+BfH9MYfG1Jh/Vscev4ZJg5q8fN7GP26P5Ok/V3jiGu1WZq+Kwb3qsv5h/9Lh7uph+bfyxU+
 eGe+/+sQytjddtuyVAXASgcN+UcQsFH1CyWMZAyccK29i3gGIa9ocX88KM9upk8IoQ9h4yK7MJB
 cM6tayNcA0qjzB7kyB9FYKrWRuVTzstthhxKtWlBcigstk6vcVH1hzgEW7QVHNuUMDbGneyJ+KX
 Zf6R6bD9JupV8MbXzfdDXUxxEeZfi8zUrjIPt4RKepsEvxMDDrGmDY+/QnYM8A3tH5q4aXeXngJ
 4ovffLhMqKqrFSpxntamz0ze/Hi7BOt8IIZaunfXMVpDCQtr0Lt8bKgLT1fodzYWGOLkXvxWJvv
 loXlgy01To/CnaLA==
X-Received: by 2002:a05:600c:83c7:b0:4a2:fd2:985d with SMTP id
 5b1f17b1804b1-4b6dddee194mr21749825e9.12.1793955117479; 
 Fri, 06 Nov 2026 00:51:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e58fcb8sm118884555e9.1.2026.11.06.00.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 00:51:56 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 08:51:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7c9e123a458b9d3757e9de93f401e4e421741675
X-Gerrit-Change-Number: 2143
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2143?usp=email>
X-Gerrit-Commit: 6579489bd3a3b39f9e153ac50c9d01887c9811a1
References: <gerrit.1793955112000.I7c9e123a458b9d3757e9de93f401e4e421741675@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTU1MTEyMDAwLkk3YzllMTIzYTQ1OGI5ZDM3NTdlOWRlOTNmNDAxZTRlNDIxNzQxNjc1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1fcf2c4f0ca5fd798fcc2b4c298a322a538e9d25-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPFg4-000000006kl-1s1h
Subject: [Openvpn-devel] [M] Change in openvpn[master]: comp: share the stub
 compress methods with LZO and LZ4
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1401072102400705958=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1401072102400705958==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="boTiptC2iCQ="; charset=UTF-8

--boTiptC2iCQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2143?usp=3Demail

to review the following change=2E
=


Change subject: comp: share the stub compress methods with LZO and LZ4
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

comp: share t=
he stub compress methods with LZO and LZ4

Since 7f0214c9 ("Remove support =
for compression on send") the LZO and
LZ4 compress methods only add the stu=
b framing, duplicating
stub_compress() and stubv2_compress()=2E Export thos=
e as
comp_stub_compress() and compv2_stub_compress() and use them for all
m=
ethods=2E Also allocate the context only once in comp_init()=2E

This also =
fixes LZO sending dropped packets=2E encrypt_sign() drops
packets by settin=
g buf=2Elen to 0 (e=2Eg=2E before client-connect has
completed) and still c=
alls the compress method=2E lzo_compress()
prepended NO_COMPRESS_BYTE regar=
dless, turning the dropped packet into
a one byte packet that was sent=2E T=
he stub methods return early on
empty buffers=2E

Change-Id: I7c9e123a458b9=
d3757e9de93f401e4e421741675
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
---
M doc/doxygen/doc_compression=2Eh
M src/openvpn/comp-lz4=2Ec
M =
src/openvpn/comp=2Ec
M src/openvpn/comp=2Eh
M src/openvpn/compstub=2Ec
M sr=
c/openvpn/forward=2Eh
M src/openvpn/lzo=2Ec
7 files changed, 41 insertions(=
+), 81 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/43/2143/1

diff --git a/doc/doxygen/doc_compression=2Eh b/do=
c/doxygen/doc_compression=2Eh
index 1f2e93bd1=2E=2Eefd18bf 100644
--- a/doc=
/doxygen/doc_compression=2Eh
+++ b/doc/doxygen/doc_compression=2Eh
@@ -60,1=
0 +60,10 @@
  * Data Channel Control module\endlink and processes them acco=
rding to the
  * settings of the packet's VPN tunnel=2E  The \link data_con=
trol Data
  * Channel Control module\endlink uses the following interface f=
unctions:
- * - For packets which will be sent to a remote OpenVPN peer: \c=

- *   lzo_compress()
- * - For packets which have been received from a rem=
ote OpenVPN peer: \c
- *   lzo_decompress()
+ * - For packets which will be=
 sent to a remote OpenVPN peer: the \c
+ *   compress method of \c compress=
_alg
+ * - For packets which have been received from a remote OpenVPN peer:=
 the
+ *   \c decompress method of \c compress_alg
  *
  * @par Settings th=
at control this module's activity
  * Whether or not the Data Channel Compr=
ession module is active depends on
diff --git a/src/openvpn/comp-lz4=2Ec b/=
src/openvpn/comp-lz4=2Ec
index 57c6bb3=2E=2E192d1bd 100644
--- a/src/openvp=
n/comp-lz4=2Ec
+++ b/src/openvpn/comp-lz4=2Ec
@@ -55,40 +55,6 @@
 {
 }
 
-/=
* Doesn't do any actual compression anymore */
-static void
-lz4_compress(s=
truct buffer *buf, struct buffer work, struct compress_context *compctx,
- =
            const struct frame *frame)
-{
-    if (buf->len <=3D 0)
-    {
=
-        return;
-    }
-
-    uint8_t comp_head_byte =3D NO_COMPRESS_BYTE_=
SWAP;
-    uint8_t *head =3D BPTR(buf);
-    uint8_t *tail =3D BEND(buf);
-=
    ASSERT(buf_safe(buf, 1));
-    ++buf->len;
-
-    /* move head byte of =
payload to tail */
-    *tail =3D *head;
-    *head =3D comp_head_byte;
-}
=
-
-/* Doesn't do any actual compression anymore */
-static void
-lz4v2_comp=
ress(struct buffer *buf, struct buffer work, struct compress_context *compc=
tx,
-               const struct frame *frame)
-{
-    if (buf->len <=3D 0)=

-    {
-        return;
-    }
-
-    compv2_escape_data_ifneeded(buf);
-}=

-
 static void
 do_lz4_decompress(int zlen_max, struct buffer *work, struc=
t buffer *buf,
                   struct compress_context *compctx)
@@ -198=
,9 +164,9 @@
     }
 }
 
-const struct compress_alg lz4_alg =3D { "lz4", lz=
4_compress_init, lz4_compress_uninit, lz4_compress,
-                      =
                lz4_decompress };
+const struct compress_alg lz4_alg =3D { =
"lz4", lz4_compress_init, lz4_compress_uninit,
+                           =
           comp_stub_compress, lz4_decompress };
 
 const struct compress_a=
lg lz4v2_alg =3D { "lz4v2", lz4v2_compress_init, lz4_compress_uninit,
-    =
                                    lz4v2_compress, lz4v2_decompress };
+  =
                                      compv2_stub_compress, lz4v2_decompres=
s };
 #endif /* ENABLE_LZ4 */
diff --git a/src/openvpn/comp=2Ec b/src/openv=
pn/comp=2Ec
index 387a7c4=2E=2E357eabc 100644
--- a/src/openvpn/comp=2Ec
++=
+ b/src/openvpn/comp=2Ec
@@ -38,47 +38,41 @@
 struct compress_context *
 co=
mp_init(const struct compress_options *opt)
 {
-    struct compress_context=
 *compctx =3D NULL;
+    const struct compress_alg *alg;
     switch (opt->=
alg)
     {
         case COMP_ALG_STUB:
-            ALLOC_OBJ_CLEAR(compc=
tx, struct compress_context);
-            compctx->flags =3D opt->flags;
-=
            compctx->alg =3D comp_stub_alg;
+            alg =3D &comp_stub=
_alg;
             break;
 
         case COMP_ALGV2_UNCOMPRESSED:
-       =
     ALLOC_OBJ_CLEAR(compctx, struct compress_context);
-            compct=
x->flags =3D opt->flags;
-            compctx->alg =3D compv2_stub_alg;
+  =
          alg =3D &compv2_stub_alg;
             break;
 
 #ifdef ENABLE_LZ=
O
         case COMP_ALG_LZO:
-            ALLOC_OBJ_CLEAR(compctx, struct =
compress_context);
-            compctx->flags =3D opt->flags;
-           =
 compctx->alg =3D lzo_alg;
+            alg =3D &lzo_alg;
             brea=
k;
 
 #endif
 #ifdef ENABLE_LZ4
         case COMP_ALG_LZ4:
-            AL=
LOC_OBJ_CLEAR(compctx, struct compress_context);
-            compctx->flag=
s =3D opt->flags;
-            compctx->alg =3D lz4_alg;
+            alg =
=3D &lz4_alg;
             break;
 
         case COMP_ALGV2_LZ4:
-        =
    ALLOC_OBJ_CLEAR(compctx, struct compress_context);
-            compctx=
->flags =3D opt->flags;
-            compctx->alg =3D lz4v2_alg;
+         =
   alg =3D &lz4v2_alg;
             break;
 #endif
+        default:
+     =
       return NULL;
     }
-    if (compctx)
-    {
-        (*compctx->alg=
=2Ecompress_init)(compctx);
-    }
+
+    struct compress_context *compctx;=

+    ALLOC_OBJ_CLEAR(compctx, struct compress_context);
+    compctx->flag=
s =3D opt->flags;
+    compctx->alg =3D *alg;
+    (*compctx->alg=2Ecompres=
s_init)(compctx);
 
     return compctx;
 }
diff --git a/src/openvpn/comp=
=2Eh b/src/openvpn/comp=2Eh
index ad80243=2E=2E3f6411b 100644
--- a/src/ope=
nvpn/comp=2Eh
+++ b/src/openvpn/comp=2Eh
@@ -208,6 +208,14 @@
 
 void compv=
2_escape_data_ifneeded(struct buffer *buf);
 
+/* Compress methods of the s=
tub algorithms, also used by LZO and LZ4, which
+ * no longer compress on s=
end */
+void comp_stub_compress(struct buffer *buf, struct buffer work, str=
uct compress_context *compctx,
+                        const struct frame =
*frame);
+
+void compv2_stub_compress(struct buffer *buf, struct buffer wor=
k, struct compress_context *compctx,
+                          const struc=
t frame *frame);
+
 static inline bool
 comp_enabled(const struct compress_=
options *info)
 {
diff --git a/src/openvpn/compstub=2Ec b/src/openvpn/comps=
tub=2Ec
index 2eef587=2E=2Eb1115c9 100644
--- a/src/openvpn/compstub=2Ec
++=
+ b/src/openvpn/compstub=2Ec
@@ -44,9 +44,9 @@
 {
 }
 
-static void
-stub_c=
ompress(struct buffer *buf, struct buffer work, struct compress_context *co=
mpctx,
-              const struct frame *frame)
+void
+comp_stub_compress(=
struct buffer *buf, struct buffer work, struct compress_context *compctx,
+=
                   const struct frame *frame)
 {
     if (buf->len <=3D 0)
=
     {
@@ -104,9 +104,9 @@
 }
 
 
-static void
-stubv2_compress(struct buff=
er *buf, struct buffer work, struct compress_context *compctx,
-           =
     const struct frame *frame)
+void
+compv2_stub_compress(struct buffer *=
buf, struct buffer work, struct compress_context *compctx,
+               =
      const struct frame *frame)
 {
     if (buf->len <=3D 0)
     {
@@ -15=
4,8 +154,8 @@
 }
 
 const struct compress_alg compv2_stub_alg =3D { "stubv2=
", stub_compress_init, stub_compress_uninit,
-                             =
                 stubv2_compress, stubv2_decompress };
+                   =
                           compv2_stub_compress, stubv2_decompress };
 
 co=
nst struct compress_alg comp_stub_alg =3D { "stub", stub_compress_init, stu=
b_compress_uninit,
-                                            stub_compre=
ss, stub_decompress };
+                                            comp_st=
ub_compress, stub_decompress };
 #endif /* USE_STUB */
diff --git a/src/ope=
nvpn/forward=2Eh b/src/openvpn/forward=2Eh
index 375635b=2E=2E1a67319 10064=
4
--- a/src/openvpn/forward=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -102,7 +10=
2,7 @@
  * - Check that the client authentication has succeeded; if not, dr=
op the
  *   packet=2E
  * - If the \a comp_frag argument is true:
- *   - =
Call \c lzo_compress() of the \link compression Data Channel Compression
+ =
*   - Call the \c compress method of the \link compression Data Channel Com=
pression
  *     module\endlink to (possibly) compress the packet=2E
  *   =
- Call \c fragment_outgoing() of the \link fragmentation Data Channel Fragm=
entation
  *     module\endlink to (possibly) fragment the packet=2E
@@ -19=
1,7 +191,7 @@
  * - Call \c fragment_incoming() of the \link fragmentation =
Data Channel
  *   Fragmentation module\endlink to reassemble the packet if=
 it's
  *   fragmented=2E
- * - Call \c lzo_decompress() of the \link compr=
ession Data Channel
+ * - Call the \c decompress method of the \link compre=
ssion Data Channel
  *   Compression module\endlink to decompress the packe=
t if it's
  *   compressed=2E
  * - Place the resulting packet in \c c->c2=
=2Eto_tun so that it can be sent
diff --git a/src/openvpn/lzo=2Ec b/src/ope=
nvpn/lzo=2Ec
index 51cf5e8=2E=2E3cf0d79 100644
--- a/src/openvpn/lzo=2Ec
++=
+ b/src/openvpn/lzo=2Ec
@@ -65,14 +65,6 @@
 }
 
 static void
-lzo_compress(=
struct buffer *buf, struct buffer work, struct compress_context *compctx,
-=
             const struct frame *frame)
-{
-    uint8_t *header =3D buf_pre=
pend(buf, 1);
-    *header =3D NO_COMPRESS_BYTE;
-}
-
-static void
 lzo_dec=
ompress(struct buffer *buf, struct buffer work, struct compress_context *co=
mpctx,
                const struct frame *frame)
 {
@@ -120,6 +112,6 @@
  =
   }
 }
 
-const struct compress_alg lzo_alg =3D { "lzo", lzo_compress_init=
, lzo_compress_uninit, lzo_compress,
-                                     =
 lzo_decompress };
+const struct compress_alg lzo_alg =3D { "lzo", lzo_comp=
ress_init, lzo_compress_uninit,
+                                      comp=
_stub_compress, lzo_decompress };
 #endif /* ENABLE_LZO */

-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2143?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I7c9e123a458b9d3757e9de93f401e4e4=
21741675
Gerrit-Change-Number: 2143
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>

--boTiptC2iCQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2143?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">comp: share the stub compress methods with LZO and LZ4<=
br><br>Since 7f0214c9 (&quot;Remove support for compression on send&quot;) =
the LZO and<br>LZ4 compress methods only add the stub framing, duplicating<=
br>stub_compress() and stubv2_compress()=2E Export those as<br>comp_stub_co=
mpress() and compv2_stub_compress() and use them for all<br>methods=2E Also=
 allocate the context only once in comp_init()=2E<br><br>This also fixes LZ=
O sending dropped packets=2E encrypt_sign() drops<br>packets by setting buf=
=2Elen to 0 (e=2Eg=2E before client-connect has<br>completed) and still cal=
ls the compress method=2E lzo_compress()<br>prepended NO_COMPRESS_BYTE rega=
rdless, turning the dropped packet into<br>a one byte packet that was sent=
=2E The stub methods return early on<br>empty buffers=2E<br><br>Change-Id: =
I7c9e123a458b9d3757e9de93f401e4e421741675<br>Signed-off-by: Razvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M doc/doxygen/doc_compression=2Eh<=
br>M src/openvpn/comp-lz4=2Ec<br>M src/openvpn/comp=2Ec<br>M src/openvpn/co=
mp=2Eh<br>M src/openvpn/compstub=2Ec<br>M src/openvpn/forward=2Eh<br>M src/=
openvpn/lzo=2Ec<br>7 files changed, 41 insertions(+), 81 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/43/2143/1</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/doc/doxygen/doc_compression=2Eh =
b/doc/doxygen/doc_compression=2Eh</span><br><span>index 1f2e93bd1=2E=2Eefd1=
8bf 100644</span><br><span>--- a/doc/doxygen/doc_compression=2Eh</span><br>=
<span>+++ b/doc/doxygen/doc_compression=2Eh</span><br><span>@@ -60,10 +60,1=
0 @@</span><br><span>  * Data Channel Control module\endlink and processes =
them according to the</span><br><span>  * settings of the packet&#39;s VPN =
tunnel=2E  The \link data_control Data</span><br><span>  * Channel Control =
module\endlink uses the following interface functions:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * - For packets which will be sent to a r=
emote OpenVPN peer: \c</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *   lzo_compress()</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* - For packets which have been received from a remote OpenVPN peer: \c</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *   lzo_decompress()</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - For packets which =
will be sent to a remote OpenVPN peer: the \c</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *   compress method of \c compress_alg</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * - For packets which have b=
een received from a remote OpenVPN peer: the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *   \c decompress method of \c compress_alg</span=
><br><span>  *</span><br><span>  * @par Settings that control this module&#=
39;s activity</span><br><span>  * Whether or not the Data Channel Compressi=
on module is active depends on</span><br><span>diff --git a/src/openvpn/com=
p-lz4=2Ec b/src/openvpn/comp-lz4=2Ec</span><br><span>index 57c6bb3=2E=2E192=
d1bd 100644</span><br><span>--- a/src/openvpn/comp-lz4=2Ec</span><br><span>=
+++ b/src/openvpn/comp-lz4=2Ec</span><br><span>@@ -55,40 +55,6 @@</span><br=
><span> {</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/* Doesn&#39;t do any actual compression anymore *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-lz4_compress(struct buffer *bu=
f, struct buffer work, struct compress_context *compctx,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-             const struct frame *frame)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt;=3D 0)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t comp_=
head_byte =3D NO_COMPRESS_BYTE_SWAP;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    uint8_t *head =3D BPTR(buf);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    uint8_t *tail =3D BEND(buf);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_safe(buf, 1));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ++buf-&gt;len;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* move head byte of payload to tail */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    *tail =3D *head;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    *head =3D comp_head_byte;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/* Doesn&#39;t do any actual compression anymore */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-lz4v2_compress(struct buffer *buf, struct b=
uffer work, struct compress_context *compctx,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-               const struct frame *frame)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt;=3D 0)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    compv2_escape_data_ifn=
eeded(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void<=
/span><br><span> do_lz4_decompress(int zlen_max, struct buffer *work, struc=
t buffer *buf,</span><br><span>                   struct compress_context *=
compctx)</span><br><span>@@ -198,9 +164,9 @@</span><br><span>     }</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-const struct compress_alg lz4_alg =3D { &quot;lz4&quot;, lz4_compre=
ss_init, lz4_compress_uninit, lz4_compress,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                      lz4_decompress =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct comp=
ress_alg lz4_alg =3D { &quot;lz4&quot;, lz4_compress_init, lz4_compress_uni=
nit,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                       comp_stub_compress, lz4_decompress };</span><br><spa=
n> </span><br><span> const struct compress_alg lz4v2_alg =3D { &quot;lz4v2&=
quot;, lz4v2_compress_init, lz4_compress_uninit,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                        lz4v2_co=
mpress, lz4v2_decompress };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                        compv2_stub_compress, lz4v2=
_decompress };</span><br><span> #endif /* ENABLE_LZ4 */</span><br><span>dif=
f --git a/src/openvpn/comp=2Ec b/src/openvpn/comp=2Ec</span><br><span>index=
 387a7c4=2E=2E357eabc 100644</span><br><span>--- a/src/openvpn/comp=2Ec</sp=
an><br><span>+++ b/src/openvpn/comp=2Ec</span><br><span>@@ -38,47 +38,41 @@=
</span><br><span> struct compress_context *</span><br><span> comp_init(cons=
t struct compress_options *opt)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct compress_context *compctx =3D NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct co=
mpress_alg *alg;</span><br><span>     switch (opt-&gt;alg)</span><br><span>=
     {</span><br><span>         case COMP_ALG_STUB:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            ALLOC_OBJ_CLEAR(compctx, struct=
 compress_context);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          compctx-&gt;flags =3D opt-&gt;flags;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            compctx-&gt;alg =3D comp_stub_alg;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            alg =3D &am=
p;comp_stub_alg;</span><br><span>             break;</span><br><span> </spa=
n><br><span>         case COMP_ALGV2_UNCOMPRESSED:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            ALLOC_OBJ_CLEAR(compctx, struct co=
mpress_context);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       compctx-&gt;flags =3D opt-&gt;flags;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            compctx-&gt;alg =3D compv2_stub_alg;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            alg =3D &amp=
;compv2_stub_alg;</span><br><span>             break;</span><br><span> </sp=
an><br><span> #ifdef ENABLE_LZO</span><br><span>         case COMP_ALG_LZO:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ALLOC_OBJ=
_CLEAR(compctx, struct compress_context);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            compctx-&gt;flags =3D opt-&gt;flags;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            compctx-&gt;alg =
=3D lzo_alg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     alg =3D &amp;lzo_alg;</span><br><span>             break;</span><br><s=
pan> </span><br><span> #endif</span><br><span> #ifdef ENABLE_LZ4</span><br>=
<span>         case COMP_ALG_LZ4:</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            ALLOC_OBJ_CLEAR(compctx, struct compress_context);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            compctx-&g=
t;flags =3D opt-&gt;flags;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            compctx-&gt;alg =3D lz4_alg;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            alg =3D &amp;lz4_alg;</span><br><span=
>             break;</span><br><span> </span><br><span>         case COMP_A=
LGV2_LZ4:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
ALLOC_OBJ_CLEAR(compctx, struct compress_context);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            compctx-&gt;flags =3D opt-&gt;flag=
s;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            compctx=
-&gt;alg =3D lz4v2_alg;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            alg =3D &amp;lz4v2_alg;</span><br><span>             break;=
</span><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        default:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return NULL;</span><br><span>     }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (compctx)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        (*compctx-&gt;alg=2Ecompress_init)(compctx);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct compress_context *compctx;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(compctx, struct compress_context=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    compctx-&gt;f=
lags =3D opt-&gt;flags;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    compctx-&gt;alg =3D *alg;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    (*compctx-&gt;alg=2Ecompress_init)(compctx);</span><br><s=
pan> </span><br><span>     return compctx;</span><br><span> }</span><br><sp=
an>diff --git a/src/openvpn/comp=2Eh b/src/openvpn/comp=2Eh</span><br><span=
>index ad80243=2E=2E3f6411b 100644</span><br><span>--- a/src/openvpn/comp=
=2Eh</span><br><span>+++ b/src/openvpn/comp=2Eh</span><br><span>@@ -208,6 +=
208,14 @@</span><br><span> </span><br><span> void compv2_escape_data_ifneed=
ed(struct buffer *buf);</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Compress methods of the stub algorithms, also used=
 by LZO and LZ4, which</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * no longer compress on send */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void comp_stub_compress(struct buffer *buf, struct buffer w=
ork, struct compress_context *compctx,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        const struct frame *frame);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void compv2_stub_compress(struct buffer *=
buf, struct buffer work, struct compress_context *compctx,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                          const stru=
ct frame *frame);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> static inline bool</span><br><span> comp_enabled(const stru=
ct compress_options *info)</span><br><span> {</span><br><span>diff --git a/=
src/openvpn/compstub=2Ec b/src/openvpn/compstub=2Ec</span><br><span>index 2=
eef587=2E=2Eb1115c9 100644</span><br><span>--- a/src/openvpn/compstub=2Ec</=
span><br><span>+++ b/src/openvpn/compstub=2Ec</span><br><span>@@ -44,9 +44,=
9 @@</span><br><span> {</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-stub_compress(struct buffer *buf, struct buffe=
r work, struct compress_context *compctx,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-              const struct frame *frame)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+comp_stub_compress(struct buffer *buf, struct buf=
fer work, struct compress_context *compctx,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                   const struct frame *frame)</span=
><br><span> {</span><br><span>     if (buf-&gt;len &lt;=3D 0)</span><br><sp=
an>     {</span><br><span>@@ -104,9 +104,9 @@</span><br><span> }</span><br>=
<span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stubv2=
_compress(struct buffer *buf, struct buffer work, struct compress_context *=
compctx,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   const struct frame *frame)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+compv=
2_stub_compress(struct buffer *buf, struct buffer work, struct compress_con=
text *compctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                const struct frame *frame)</span><br><span> {</span><br><sp=
an>     if (buf-&gt;len &lt;=3D 0)</span><br><span>     {</span><br><span>@=
@ -154,8 +154,8 @@</span><br><span> }</span><br><span> </span><br><span> co=
nst struct compress_alg compv2_stub_alg =3D { &quot;stubv2&quot;, stub_comp=
ress_init, stub_compress_uninit,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                              stubv2_compress, s=
tubv2_decompress };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                              compv2_stub_compress, stubv2_=
decompress };</span><br><span> </span><br><span> const struct compress_alg =
comp_stub_alg =3D { &quot;stub&quot;, stub_compress_init, stub_compress_uni=
nit,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
                           stub_compress, stub_decompress };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
          comp_stub_compress, stub_decompress };</span><br><span> #endif /*=
 USE_STUB */</span><br><span>diff --git a/src/openvpn/forward=2Eh b/src/ope=
nvpn/forward=2Eh</span><br><span>index 375635b=2E=2E1a67319 100644</span><b=
r><span>--- a/src/openvpn/forward=2Eh</span><br><span>+++ b/src/openvpn/for=
ward=2Eh</span><br><span>@@ -102,7 +102,7 @@</span><br><span>  * - Check th=
at the client authentication has succeeded; if not, drop the</span><br><spa=
n>  *   packet=2E</span><br><span>  * - If the \a comp_frag argument is tru=
e:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   - Call \c lzo_=
compress() of the \link compression Data Channel Compression</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *   - Call the \c compress method=
 of the \link compression Data Channel Compression</span><br><span>  *     =
module\endlink to (possibly) compress the packet=2E</span><br><span>  *   -=
 Call \c fragment_outgoing() of the \link fragmentation Data Channel Fragme=
ntation</span><br><span>  *     module\endlink to (possibly) fragment the p=
acket=2E</span><br><span>@@ -191,7 +191,7 @@</span><br><span>  * - Call \c =
fragment_incoming() of the \link fragmentation Data Channel</span><br><span=
>  *   Fragmentation module\endlink to reassemble the packet if it&#39;s</s=
pan><br><span>  *   fragmented=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * - Call \c lzo_decompress() of the \link compression Data Cha=
nnel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - Call the \=
c decompress method of the \link compression Data Channel</span><br><span> =
 *   Compression module\endlink to decompress the packet if it&#39;s</span>=
<br><span>  *   compressed=2E</span><br><span>  * - Place the resulting pac=
ket in \c c-&gt;c2=2Eto_tun so that it can be sent</span><br><span>diff --g=
it a/src/openvpn/lzo=2Ec b/src/openvpn/lzo=2Ec</span><br><span>index 51cf5e=
8=2E=2E3cf0d79 100644</span><br><span>--- a/src/openvpn/lzo=2Ec</span><br><=
span>+++ b/src/openvpn/lzo=2Ec</span><br><span>@@ -65,14 +65,6 @@</span><br=
><span> }</span><br><span> </span><br><span> static void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-lzo_compress(struct buffer *buf, struct =
buffer work, struct compress_context *compctx,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-             const struct frame *frame)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    uint8_t *header =3D buf_prepend(buf, 1);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    *header =3D NO_COMPRESS_B=
YTE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static void</span><br><span> lzo_decompress(struct buffer =
*buf, struct buffer work, struct compress_context *compctx,</span><br><span=
>                const struct frame *frame)</span><br><span> {</span><br><s=
pan>@@ -120,6 +112,6 @@</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-const struct =
compress_alg lzo_alg =3D { &quot;lzo&quot;, lzo_compress_init, lzo_compress=
_uninit, lzo_compress,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                      lzo_decompress };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+const struct compress_alg lzo_alg =3D =
{ &quot;lzo&quot;, lzo_compress_init, lzo_compress_uninit,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
  comp_stub_compress, lzo_decompress };</span><br><span> #endif /* ENABLE_L=
ZO */</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2143?usp=3Demail">change 2143</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2143?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I7c9e123a458b9d3757e9de93f4=
01e4e421741675 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 21=
43 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--boTiptC2iCQ=--


--===============1401072102400705958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1401072102400705958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1401072102400705958==--

