Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2DD606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SaJ0jPO3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DoStUYRX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XEVUC6+Q;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EL6ECXwM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0m/2Cjeny8gRfHTLs5Wj1xBZmu1uW6Rs+XcbEMC9Ous=; b=SaJ0jPO3eJHFR8xlQ6UEgHQUa4
	gDBsAsJmJ8WMIJegSfvolrfrfc64FPTTvE9cFUfra0vKUcjVg53QXuzqH3ESyT/9vfeAjkfLk9bE2
	YSl7g/lTl5ek/VRLc5UkT4M85I1XYQdyAF1mcdDS1QzPkMbOkxJVXdE9GRNihOQ48mxM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT0gO-000000000tO-3AU1;
	Mon, 16 Nov 2026 17:39:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT0gJ-000000000t0-2XEc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:39:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gC1D9fPlMTS1ecDcazSSUhVHszv30Fac/vA/2D5W9YY=; b=DoStUYRX87yY8bf12WHPcSpTRS
 B51I6hQw9d8LgmfoPKBwNx8PuO8+1BWsvFC6X6NHw21lM/oxtt5i/W7uKKcCeVUlLfPcVNEBfsjib
 7qIRbsKYdhOR52EMEt3+umdKfm4tW96AkKfLpoZAO3BxNnEfdlrEyO2lknvz5fJUsdP4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gC1D9fPlMTS1ecDcazSSUhVHszv30Fac/vA/2D5W9YY=; b=XEVUC6+QVbPUO/vWYr9e4d7xGi
 gcSam5G1Q00hca3MV8fVXD/eA8PoDks1dxFTgWzRDuVs6uujMXLjJT4WOReUHyv16zI2vDcKIrYV6
 fjg+PdPqXkv7YjLUClijwZ9dbuUL4bTP6FRlWAYyJrAYHMv+t62HNGSoKM17hez0yTCk=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT0fx-0000000056n-389M for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:39:31 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso23583075e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 09:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794850763; x=1795455563; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gC1D9fPlMTS1ecDcazSSUhVHszv30Fac/vA/2D5W9YY=;
 b=EL6ECXwM+PkH8AuU9MJ5Tp1rNtI81omViSf7pFehoLICg5YBpPCvbsQlNS29Y0cGF7
 X0D9Zov3U6ZyO+7cYwY16Zy8XzhrRj7tRX6GYdgCJ1OFmA2q8EWeicatrjpl8duoh5pD
 HYela/TByqKzeJRDZvsItsJaaSiWvFQi5Bhg/4JaQcoSRKVG0mCH0DUUKBKagj5tEQ+B
 FvHK51MaE8sWUKZJvqYPvQjFKzDUeJqtCj4axoy2EHkxQ9kMzxEbDKOs6dDDy/MVPVMl
 HiJThn6IVR4OGtR8LSYeEb8o0F5z8Rpvy9EbeMC0kBKu81hjzddoIoaRIC+plltj6s9j
 OOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794850763; x=1795455563;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gC1D9fPlMTS1ecDcazSSUhVHszv30Fac/vA/2D5W9YY=;
 b=hmYWJT0lI9bLky86hx1T99sTMaI11TVbCDtyL+dVGUUo70dJnttbOg7JWSBQizMzH9
 WRnF8opWRbLij4AH7ClBTgyqc1xmFP4zcBXSOZAWtPI1UDjUmb6YsTb3oWwzyoSbpL3T
 U8i5YW7q/jlfXVAKEJfBolORlBzJ41JLQxu4mt84yWp9DlXDzjS+0aNlqCnr3Bj9U1uV
 btOXrJ4Y4rd9nd4elLth+e8q7crAN7UNuYqM+CkKfjEVFfsNf0JcNevQUL4gBv6bCloM
 qfrMT7bwZGyVfXpWurFhfJnHEE47iwzCGeaMHdw0GnIahltPWk7sWzW2nVohvUleyHYr
 pezw==
X-Forwarded-Encrypted: i=1;
 AL+hErHdTUCDqikCknvS+S94Fz8ZLYlBI6gwRkXY6m2qZHM5yRGeRr1L41PflPpyqhOeAnfAI8HgJmd2xdYIX+qS@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+nbolRF09k2Ccdj0WLiLkoq2u9Z9IWlDv+tyPOl9CjSn0Zzm1s
 Wob4VPyY5E4vj5giWq9o7oPi3Zh9AKgYZBw+xTrM+QV+wM+Q8eFhC2CORD66fzk9NuiQb4UQnEG
 EswQhq5299K2ByZGmETnMs45BfIIkd0nYaNCbx7T3FTl+zmt0jTWtBWPHMzoLxtAS9LVM
X-Gm-Gg: AYBFou1duz6LxvValBywd6jRE3zZ0FDKQ7ASBTgyGCLDZUcQAvpP325jkAoMmzsRSnq
 R4ibsac4sfC3XYsmxF9+ISGI4MseozWvkw5UjX2QpYYxyG1Fq/pkJIBNGyXXkYzX6JY1Jin+Unc
 jHJibpTmy+TQEovrPP6JU/UhFwL3wU7zPFmmbxwnj2E8lMSljVY5vjRTtmlSXiWVGqQ9FgWgBVM
 nSXBlGjmG3bnoVOFNqCgGHyybAMoU5SLmYxRap47G3/804LJTrxZ6nRH0FBMGE9JtrXjehrgAE2
 q2FPAL+CDPOL0EGv5t2Iq1U7k/hcwUfN6mZvOxKCoQ3jRPJ0q8qXK3ECJjpJyTDvf0Bm6zR2YAE
 3zlFb3Y9dSpuWC2DpHanhTpZr1FE/bjee7rPsTpxFpK31ZIjcIq5HvjbF0zJkn/fawZiMB3tJQP
 HxyCMZL3N3C1n/o8r/fzRI7+LwQOG5pwNlMSq9lLjJ/gSaLojosn43xXtUxiPbLBmwJlcMXp1ly
 4VaiUTv9PZZW+S3ranI1Prgvq1ESF4gSzttpmHcQZlhx7cii2AOz2bU5UM2hR8WKHfmc2ZTpgnt
 N2pvCSnsqLxXIxDTg+bUmuvw4LYytiUghtNioO7blawi2fMUlBRnJYqyTzhk7i3HK7262ZzM55/
 ABfUce1PxHSTKOSnh+F8z3OJEr+vvnU/Mxvm+F7M9lHhHkLOw7d030r51OAOl70Pbtmd92QpYUe
 /R/GTbGL89fzJw5H0=
X-Received: by 2002:a05:600c:a45:b0:4ac:86c9:b09c with SMTP id
 5b1f17b1804b1-4bb55a69123mr237366175e9.13.1794850762972; 
 Mon, 16 Nov 2026 09:39:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c1797sm26147037f8f.11.2026.11.16.09.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:39:22 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 17:39:22 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I7c9e123a458b9d3757e9de93f401e4e421741675
X-Gerrit-Change-Number: 2143
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2143?usp=email>
X-Gerrit-Commit: f4773397871ee461aee541104a3e430294633753
In-Reply-To: <gerrit.1793955112000.I7c9e123a458b9d3757e9de93f401e4e421741675@gerrit.openvpn.net>
References: <gerrit.1793955112000.I7c9e123a458b9d3757e9de93f401e4e421741675@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTU1MTEyMDAwLkk3YzllMTIzYTQ1OGI5ZDM3NTdlOWRlOTNmNDAxZTRlNDIxNzQxNjc1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7d7e6f3092ddb11935f5adb08ae9c9f9c5d8565c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT0fx-0000000056n-389M
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2354075508415117493=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2354075508415117493==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ODQTv3CHHBE="; charset=UTF-8

--ODQTv3CHHBE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2143?usp=3Demail )

Change subject: comp: share the stub compre=
ss methods with LZO and LZ4
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

comp: share the stub compress methods with LZO and LZ4

Si=
nce 7f0214c9 ("Remove support for compression on send") the LZO and
LZ4 com=
press methods only add the stub framing, duplicating
stub_compress() and st=
ubv2_compress()=2E Export those as
comp_stub_compress() and compv2_stub_com=
press() and use them for all
methods=2E Also allocate the context only once=
 in comp_init()=2E

This also fixes LZO sending dropped packets=2E encrypt_=
sign() drops
packets by setting buf=2Elen to 0 (e=2Eg=2E before client-conn=
ect has
completed) and still calls the compress method=2E lzo_compress()
pr=
epended NO_COMPRESS_BYTE regardless, turning the dropped packet into
a one =
byte packet that was sent=2E The stub methods return early on
empty buffers=
=2E

Change-Id: I7c9e123a458b9d3757e9de93f401e4e421741675
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2143
Me=
ssage-Id: <20261116105141=2E17064-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41415=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M doc/doxyge=
n/doc_compression=2Eh
M src/openvpn/comp-lz4=2Ec
M src/openvpn/comp=2Ec
M s=
rc/openvpn/comp=2Eh
M src/openvpn/compstub=2Ec
M src/openvpn/forward=2Eh
M =
src/openvpn/lzo=2Ec
7 files changed, 41 insertions(+), 81 deletions(-)




=
diff --git a/doc/doxygen/doc_compression=2Eh b/doc/doxygen/doc_compression=
=2Eh
index 1f2e93bd1=2E=2Eefd18bf 100644
--- a/doc/doxygen/doc_compression=
=2Eh
+++ b/doc/doxygen/doc_compression=2Eh
@@ -60,10 +60,10 @@
  * Data Cha=
nnel Control module\endlink and processes them according to the
  * setting=
s of the packet's VPN tunnel=2E  The \link data_control Data
  * Channel Co=
ntrol module\endlink uses the following interface functions:
- * - For pack=
ets which will be sent to a remote OpenVPN peer: \c
- *   lzo_compress()
- =
* - For packets which have been received from a remote OpenVPN peer: \c
- *=
   lzo_decompress()
+ * - For packets which will be sent to a remote OpenVP=
N peer: the \c
+ *   compress method of \c compress_alg
+ * - For packets w=
hich have been received from a remote OpenVPN peer: the
+ *   \c decompress=
 method of \c compress_alg
  *
  * @par Settings that control this module's=
 activity
  * Whether or not the Data Channel Compression module is active =
depends on
diff --git a/src/openvpn/comp-lz4=2Ec b/src/openvpn/comp-lz4=2Ec=

index 0c5f22f=2E=2E736601a 100644
--- a/src/openvpn/comp-lz4=2Ec
+++ b/src=
/openvpn/comp-lz4=2Ec
@@ -55,40 +55,6 @@
 {
 }
 
-/* Doesn't do any actual =
compression anymore */
-static void
-lz4_compress(struct buffer *buf, struc=
t buffer work, struct compress_context *compctx,
-             const struct=
 frame *frame)
-{
-    if (buf->len <=3D 0)
-    {
-        return;
-    }
=
-
-    uint8_t comp_head_byte =3D NO_COMPRESS_BYTE_SWAP;
-    uint8_t *head=
 =3D BPTR(buf);
-    uint8_t *tail =3D BEND(buf);
-    ASSERT(buf_safe(buf,=
 1));
-    ++buf->len;
-
-    /* move head byte of payload to tail */
-    =
*tail =3D *head;
-    *head =3D comp_head_byte;
-}
-
-/* Doesn't do any act=
ual compression anymore */
-static void
-lz4v2_compress(struct buffer *buf,=
 struct buffer work, struct compress_context *compctx,
-               cons=
t struct frame *frame)
-{
-    if (buf->len <=3D 0)
-    {
-        return;=

-    }
-
-    compv2_escape_data_ifneeded(buf);
-}
-
 #if defined(__GNUC__=
) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnosti=
c ignored "-Wsign-conversion"
@@ -207,9 +173,9 @@
 #pragma GCC diagnostic p=
op
 #endif
 
-const struct compress_alg lz4_alg =3D { "lz4", lz4_compress_i=
nit, lz4_compress_uninit, lz4_compress,
-                                  =
    lz4_decompress };
+const struct compress_alg lz4_alg =3D { "lz4", lz4_c=
ompress_init, lz4_compress_uninit,
+                                      c=
omp_stub_compress, lz4_decompress };
 
 const struct compress_alg lz4v2_alg=
 =3D { "lz4v2", lz4v2_compress_init, lz4_compress_uninit,
-                =
                        lz4v2_compress, lz4v2_decompress };
+              =
                          compv2_stub_compress, lz4v2_decompress };
 #endif=
 /* ENABLE_LZ4 */
diff --git a/src/openvpn/comp=2Ec b/src/openvpn/comp=2Ec
=
index 513a766=2E=2E6ce9152 100644
--- a/src/openvpn/comp=2Ec
+++ b/src/open=
vpn/comp=2Ec
@@ -38,47 +38,41 @@
 struct compress_context *
 comp_init(cons=
t struct compress_options *opt)
 {
-    struct compress_context *compctx =
=3D NULL;
+    const struct compress_alg *alg;
     switch (opt->alg)
     =
{
         case COMP_ALG_STUB:
-            ALLOC_OBJ_CLEAR(compctx, struct=
 compress_context);
-            compctx->flags =3D opt->flags;
-          =
  compctx->alg =3D comp_stub_alg;
+            alg =3D &comp_stub_alg;
    =
         break;
 
         case COMP_ALGV2_UNCOMPRESSED:
-            ALLOC=
_OBJ_CLEAR(compctx, struct compress_context);
-            compctx->flags =
=3D opt->flags;
-            compctx->alg =3D compv2_stub_alg;
+           =
 alg =3D &compv2_stub_alg;
             break;
 
 #ifdef ENABLE_LZO
       =
  case COMP_ALG_LZO:
-            ALLOC_OBJ_CLEAR(compctx, struct compress_=
context);
-            compctx->flags =3D opt->flags;
-            compctx-=
>alg =3D lzo_alg;
+            alg =3D &lzo_alg;
             break;
 
 #en=
dif
 #ifdef ENABLE_LZ4
         case COMP_ALG_LZ4:
-            ALLOC_OBJ_C=
LEAR(compctx, struct compress_context);
-            compctx->flags =3D opt=
->flags;
-            compctx->alg =3D lz4_alg;
+            alg =3D &lz4_a=
lg;
             break;
 
         case COMP_ALGV2_LZ4:
-            ALLOC_=
OBJ_CLEAR(compctx, struct compress_context);
-            compctx->flags =
=3D opt->flags;
-            compctx->alg =3D lz4v2_alg;
+            alg =
=3D &lz4v2_alg;
             break;
 #endif
+        default:
+            =
return NULL;
     }
-    if (compctx)
-    {
-        (*compctx->alg=2Ecomp=
ress_init)(compctx);
-    }
+
+    struct compress_context *compctx;
+    A=
LLOC_OBJ_CLEAR(compctx, struct compress_context);
+    compctx->flags =3D o=
pt->flags;
+    compctx->alg =3D *alg;
+    (*compctx->alg=2Ecompress_init)=
(compctx);
 
     return compctx;
 }
diff --git a/src/openvpn/comp=2Eh b/sr=
c/openvpn/comp=2Eh
index ad80243=2E=2E3f6411b 100644
--- a/src/openvpn/comp=
=2Eh
+++ b/src/openvpn/comp=2Eh
@@ -208,6 +208,14 @@
 
 void compv2_escape_=
data_ifneeded(struct buffer *buf);
 
+/* Compress methods of the stub algor=
ithms, also used by LZO and LZ4, which
+ * no longer compress on send */
+v=
oid comp_stub_compress(struct buffer *buf, struct buffer work, struct compr=
ess_context *compctx,
+                        const struct frame *frame);
=
+
+void compv2_stub_compress(struct buffer *buf, struct buffer work, struct=
 compress_context *compctx,
+                          const struct frame *=
frame);
+
 static inline bool
 comp_enabled(const struct compress_options *=
info)
 {
diff --git a/src/openvpn/compstub=2Ec b/src/openvpn/compstub=2Ec
i=
ndex 2eef587=2E=2Eb1115c9 100644
--- a/src/openvpn/compstub=2Ec
+++ b/src/o=
penvpn/compstub=2Ec
@@ -44,9 +44,9 @@
 {
 }
 
-static void
-stub_compress(s=
truct buffer *buf, struct buffer work, struct compress_context *compctx,
- =
             const struct frame *frame)
+void
+comp_stub_compress(struct bu=
ffer *buf, struct buffer work, struct compress_context *compctx,
+         =
          const struct frame *frame)
 {
     if (buf->len <=3D 0)
     {
@@=
 -104,9 +104,9 @@
 }
 
 
-static void
-stubv2_compress(struct buffer *buf, =
struct buffer work, struct compress_context *compctx,
-                cons=
t struct frame *frame)
+void
+compv2_stub_compress(struct buffer *buf, stru=
ct buffer work, struct compress_context *compctx,
+                     con=
st struct frame *frame)
 {
     if (buf->len <=3D 0)
     {
@@ -154,8 +154,=
8 @@
 }
 
 const struct compress_alg compv2_stub_alg =3D { "stubv2", stub_c=
ompress_init, stub_compress_uninit,
-                                      =
        stubv2_compress, stubv2_decompress };
+                            =
                  compv2_stub_compress, stubv2_decompress };
 
 const struc=
t compress_alg comp_stub_alg =3D { "stub", stub_compress_init, stub_compres=
s_uninit,
-                                            stub_compress, stub_=
decompress };
+                                            comp_stub_compre=
ss, stub_decompress };
 #endif /* USE_STUB */
diff --git a/src/openvpn/forw=
ard=2Eh b/src/openvpn/forward=2Eh
index 375635b=2E=2E1a67319 100644
--- a/s=
rc/openvpn/forward=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -102,7 +102,7 @@
  =
* - Check that the client authentication has succeeded; if not, drop the
  =
*   packet=2E
  * - If the \a comp_frag argument is true:
- *   - Call \c l=
zo_compress() of the \link compression Data Channel Compression
+ *   - Cal=
l the \c compress method of the \link compression Data Channel Compression
=
  *     module\endlink to (possibly) compress the packet=2E
  *   - Call \c=
 fragment_outgoing() of the \link fragmentation Data Channel Fragmentation
=
  *     module\endlink to (possibly) fragment the packet=2E
@@ -191,7 +191,=
7 @@
  * - Call \c fragment_incoming() of the \link fragmentation Data Chan=
nel
  *   Fragmentation module\endlink to reassemble the packet if it's
  *=
   fragmented=2E
- * - Call \c lzo_decompress() of the \link compression Da=
ta Channel
+ * - Call the \c decompress method of the \link compression Dat=
a Channel
  *   Compression module\endlink to decompress the packet if it's=

  *   compressed=2E
  * - Place the resulting packet in \c c->c2=2Eto_tun =
so that it can be sent
diff --git a/src/openvpn/lzo=2Ec b/src/openvpn/lzo=
=2Ec
index 2b0691b=2E=2E207cea6 100644
--- a/src/openvpn/lzo=2Ec
+++ b/src/=
openvpn/lzo=2Ec
@@ -70,14 +70,6 @@
 }
 
 static void
-lzo_compress(struct b=
uffer *buf, struct buffer work, struct compress_context *compctx,
-        =
     const struct frame *frame)
-{
-    uint8_t *header =3D buf_prepend(buf=
, 1);
-    *header =3D NO_COMPRESS_BYTE;
-}
-
-static void
 lzo_decompress(=
struct buffer *buf, struct buffer work, struct compress_context *compctx,
 =
               const struct frame *frame)
 {
@@ -129,6 +121,6 @@
 #pragma G=
CC diagnostic pop
 #endif
 
-const struct compress_alg lzo_alg =3D { "lzo",=
 lzo_compress_init, lzo_compress_uninit, lzo_compress,
-                   =
                   lzo_decompress };
+const struct compress_alg lzo_alg =3D=
 { "lzo", lzo_compress_init, lzo_compress_uninit,
+                        =
              comp_stub_compress, lzo_decompress };
 #endif /* ENABLE_LZO *=
/

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2143?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7c9e123a458b9d3=
757e9de93f401e4e421741675
Gerrit-Change-Number: 2143
Gerrit-PatchSet: 3
Ger=
rit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ODQTv3CHHBE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2143?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">comp: share the stub compress meth=
ods with LZO and LZ4<br><br>Since 7f0214c9 (&quot;Remove support for compre=
ssion on send&quot;) the LZO and<br>LZ4 compress methods only add the stub =
framing, duplicating<br>stub_compress() and stubv2_compress()=2E Export tho=
se as<br>comp_stub_compress() and compv2_stub_compress() and use them for a=
ll<br>methods=2E Also allocate the context only once in comp_init()=2E<br><=
br>This also fixes LZO sending dropped packets=2E encrypt_sign() drops<br>p=
ackets by setting buf=2Elen to 0 (e=2Eg=2E before client-connect has<br>com=
pleted) and still calls the compress method=2E lzo_compress()<br>prepended =
NO_COMPRESS_BYTE regardless, turning the dropped packet into<br>a one byte =
packet that was sent=2E The stub methods return early on<br>empty buffers=
=2E<br><br>Change-Id: I7c9e123a458b9d3757e9de93f401e4e421741675<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2143<br>Message-Id: &lt;20261116105141=2E17064-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg41415=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M doc/doxygen/doc_compression=2Eh<=
br>M src/openvpn/comp-lz4=2Ec<br>M src/openvpn/comp=2Ec<br>M src/openvpn/co=
mp=2Eh<br>M src/openvpn/compstub=2Ec<br>M src/openvpn/forward=2Eh<br>M src/=
openvpn/lzo=2Ec<br>7 files changed, 41 insertions(+), 81 deletions(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/doc/doxygen/doc_compression=2Eh b/doc/doxygen/doc_=
compression=2Eh</span><br><span>index 1f2e93bd1=2E=2Eefd18bf 100644</span><=
br><span>--- a/doc/doxygen/doc_compression=2Eh</span><br><span>+++ b/doc/do=
xygen/doc_compression=2Eh</span><br><span>@@ -60,10 +60,10 @@</span><br><sp=
an>  * Data Channel Control module\endlink and processes them according to =
the</span><br><span>  * settings of the packet&#39;s VPN tunnel=2E  The \li=
nk data_control Data</span><br><span>  * Channel Control module\endlink use=
s the following interface functions:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * - For packets which will be sent to a remote OpenVPN peer=
: \c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   lzo_compress=
()</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * - For packets wh=
ich have been received from a remote OpenVPN peer: \c</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *   lzo_decompress()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * - For packets which will be sent to a =
remote OpenVPN peer: the \c</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *   compress method of \c compress_alg</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * - For packets which have been received from =
a remote OpenVPN peer: the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *   \c decompress method of \c compress_alg</span><br><span>  *</sp=
an><br><span>  * @par Settings that control this module&#39;s activity</spa=
n><br><span>  * Whether or not the Data Channel Compression module is activ=
e depends on</span><br><span>diff --git a/src/openvpn/comp-lz4=2Ec b/src/op=
envpn/comp-lz4=2Ec</span><br><span>index 0c5f22f=2E=2E736601a 100644</span>=
<br><span>--- a/src/openvpn/comp-lz4=2Ec</span><br><span>+++ b/src/openvpn/=
comp-lz4=2Ec</span><br><span>@@ -55,40 +55,6 @@</span><br><span> {</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-/* Doesn&#39;t do any actual compression anymore */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-lz4_compress(struct buffer *buf, struct buffer w=
ork, struct compress_context *compctx,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-             const struct frame *frame)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (buf-&gt;len &lt;=3D 0)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    uint8_t comp_head_byte =3D NO_C=
OMPRESS_BYTE_SWAP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 uint8_t *head =3D BPTR(buf);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    uint8_t *tail =3D BEND(buf);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    ASSERT(buf_safe(buf, 1));</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ++buf-&gt;len;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* move head byte of payload to tail */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    *tail =3D *head;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    *head =3D comp_head_byte;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Doesn&=
#39;t do any actual compression anymore */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-lz4v2_compress(struct buffer *buf, struct buffer work, struct co=
mpress_context *compctx,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-               const struct frame *frame)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (buf-&gt;len &lt;=3D 0)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    compv2_escape_data_ifneeded(buf);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> #if defined(__GNUC__) || defined(=
__clang__)</span><br><span> #pragma GCC diagnostic push</span><br><span> #p=
ragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span>=
@@ -207,9 +173,9 @@</span><br><span> #pragma GCC diagnostic pop</span><br><=
span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-const struct compress_alg lz4_alg =3D { &quot;lz4&quot;, lz4_compr=
ess_init, lz4_compress_uninit, lz4_compress,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                      lz4_decompress=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct com=
press_alg lz4_alg =3D { &quot;lz4&quot;, lz4_compress_init, lz4_compress_un=
init,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                        comp_stub_compress, lz4_decompress };</span><br><sp=
an> </span><br><span> const struct compress_alg lz4v2_alg =3D { &quot;lz4v2=
&quot;, lz4v2_compress_init, lz4_compress_uninit,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                        lz4v2_c=
ompress, lz4v2_decompress };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                        compv2_stub_compress, lz4v=
2_decompress };</span><br><span> #endif /* ENABLE_LZ4 */</span><br><span>di=
ff --git a/src/openvpn/comp=2Ec b/src/openvpn/comp=2Ec</span><br><span>inde=
x 513a766=2E=2E6ce9152 100644</span><br><span>--- a/src/openvpn/comp=2Ec</s=
pan><br><span>+++ b/src/openvpn/comp=2Ec</span><br><span>@@ -38,47 +38,41 @=
@</span><br><span> struct compress_context *</span><br><span> comp_init(con=
st struct compress_options *opt)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct compress_context *compctx =3D NU=
LL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct=
 compress_alg *alg;</span><br><span>     switch (opt-&gt;alg)</span><br><sp=
an>     {</span><br><span>         case COMP_ALG_STUB:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            ALLOC_OBJ_CLEAR(compctx, struc=
t compress_context);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           compctx-&gt;flags =3D opt-&gt;flags;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            compctx-&gt;alg =3D comp_stub_alg;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            alg =3D &a=
mp;comp_stub_alg;</span><br><span>             break;</span><br><span> </sp=
an><br><span>         case COMP_ALGV2_UNCOMPRESSED:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            ALLOC_OBJ_CLEAR(compctx, struct=
 compress_context);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          compctx-&gt;flags =3D opt-&gt;flags;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            compctx-&gt;alg =3D compv2_stub_alg;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            alg =3D &=
amp;compv2_stub_alg;</span><br><span>             break;</span><br><span> <=
/span><br><span> #ifdef ENABLE_LZO</span><br><span>         case COMP_ALG_L=
ZO:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ALLOC_=
OBJ_CLEAR(compctx, struct compress_context);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            compctx-&gt;flags =3D opt-&gt;flags;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            compctx-&gt;a=
lg =3D lzo_alg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        alg =3D &amp;lzo_alg;</span><br><span>             break;</span><br=
><span> </span><br><span> #endif</span><br><span> #ifdef ENABLE_LZ4</span><=
br><span>         case COMP_ALG_LZ4:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            ALLOC_OBJ_CLEAR(compctx, struct compress_context=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            compctx=
-&gt;flags =3D opt-&gt;flags;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            compctx-&gt;alg =3D lz4_alg;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            alg =3D &amp;lz4_alg;</span><br><s=
pan>             break;</span><br><span> </span><br><span>         case COM=
P_ALGV2_LZ4:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   ALLOC_OBJ_CLEAR(compctx, struct compress_context);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            compctx-&gt;flags =3D opt-&gt;f=
lags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            comp=
ctx-&gt;alg =3D lz4v2_alg;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            alg =3D &amp;lz4v2_alg;</span><br><span>             bre=
ak;</span><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        default:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return NULL;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (compctx)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        (*compctx-&gt;alg=2Ecompress_init)(compctx);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct compress_context *compctx;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(compctx, struct compress_con=
text);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    compctx-&=
gt;flags =3D opt-&gt;flags;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    compctx-&gt;alg =3D *alg;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    (*compctx-&gt;alg=2Ecompress_init)(compctx);</span><b=
r><span> </span><br><span>     return compctx;</span><br><span> }</span><br=
><span>diff --git a/src/openvpn/comp=2Eh b/src/openvpn/comp=2Eh</span><br><=
span>index ad80243=2E=2E3f6411b 100644</span><br><span>--- a/src/openvpn/co=
mp=2Eh</span><br><span>+++ b/src/openvpn/comp=2Eh</span><br><span>@@ -208,6=
 +208,14 @@</span><br><span> </span><br><span> void compv2_escape_data_ifne=
eded(struct buffer *buf);</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Compress methods of the stub algorithms, also us=
ed by LZO and LZ4, which</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * no longer compress on send */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void comp_stub_compress(struct buffer *buf, struct buffer=
 work, struct compress_context *compctx,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        const struct frame *frame);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
it a/src/openvpn/lzo=2Ec b/src/openvpn/lzo=2Ec</span><br><span>index 2b0691=
b=2E=2E207cea6 100644</span><br><span>--- a/src/openvpn/lzo=2Ec</span><br><=
span>+++ b/src/openvpn/lzo=2Ec</span><br><span>@@ -70,14 +70,6 @@</span><br=
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
pan>@@ -129,6 +121,6 @@</span><br><span> #pragma GCC diagnostic pop</span><=
br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-const struct compress_alg lzo_alg =3D { &quot;lzo&quot;, lzo_c=
ompress_init, lzo_compress_uninit, lzo_compress,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                      lzo_decomp=
ress };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct=
 compress_alg lzo_alg =3D { &quot;lzo&quot;, lzo_compress_init, lzo_compres=
s_uninit,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                            comp_stub_compress, lzo_decompress };</span><br=
><span> #endif /* ENABLE_LZO */</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2143?usp=3Demail">change 214=
3</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2143?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7c=
9e123a458b9d3757e9de93f401e4e421741675 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 2143 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--ODQTv3CHHBE=--


--===============2354075508415117493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2354075508415117493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2354075508415117493==--

