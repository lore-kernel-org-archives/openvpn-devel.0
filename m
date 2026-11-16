Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9C606A32A
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=it27fJF5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=H/AFkm9C;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=m+0G3gDz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VNLFgnrp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LLjwGlX3Q+euiRHA/wfYriZk2iNPAFb8nLr1ZP14b9Y=; b=it27fJF5boHSqOR2Jcb+KqKBo3
	E6LGhiUrfPAf+pWeCKj0M5eRTEDPSiIkvQjdu72fWiqEQxMvXPuKhloPVclZ8dk7bv2jPEQijz1CM
	YCnPcBtKJfnORn94rQXo0l92uh1EeWrOvrNfWZMyGOPhqwT5R9R1SnLxOiAO2+LJMyFs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT0gL-000000000rU-1m20;
	Mon, 16 Nov 2026 17:39:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT0gJ-000000000pU-2Wdj
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:39:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Aq3DT6NyjM/Sd1zS8X6q7XKBpRC2c+VfGlhRrmSWjlQ=; b=H/AFkm9Co5C4Qio2aUSRs1YdS5
 oosF44tS/K/T1hITxbKZaFIzqL6voGR4RFbxvIt3rFQcvwGz3UGgxWE3ca+KZn38PTuBIrgIEqhAJ
 j1XubFuXDTlDIIe9F7SpTeyCkrcNp7giCeMzh9Jauh9y6sEC/ZKF1RN4Zuf3GNcDGSZ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Aq3DT6NyjM/Sd1zS8X6q7XKBpRC2c+VfGlhRrmSWjlQ=; b=m+0G3gDzxc91FwinH8//ClBg46
 wk8jhNIHwsYs8OLg9uxebFY+f3jlgC830fH4PHQH+XE3/Yo3/TPNkTYYZ8gG9+Y6fJaYwgDaxDfiJ
 6MFoGlpmGqejQfADlclpGPF6b7a2K1dJhciIhSWAIzBgDjG0KhabKWtEb1twSeJmBWaM=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT0fx-000000002GE-2fH5 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:39:31 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4a357b1c649so85182f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 09:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794850763; x=1795455563; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Aq3DT6NyjM/Sd1zS8X6q7XKBpRC2c+VfGlhRrmSWjlQ=;
 b=VNLFgnrpEK2Onu9LdDuYfwrgEnIWwxrat2WkhivMtENgT552kdkOcSjz+HVzuiF+f5
 pgw00EIWWD++oZnfOBf1rpwldRXga2rZRAF1D50WdvYvljECG0gCa0vGnaGli6ZPHkZp
 EV8FRM9DqSRoQkNHivesuIbvCEWxk5LowRMqZ9PmNLfCTodg4pzi13B/xVaOBnvPa51d
 mndGdDZVOeL3IbkmxoMfMgaAiFVnNpxRyHV5a1ZBui82G6Q3fcqeYuFl8qjKA3Q3j7CF
 G3m9hIIeN2Nef1h401RrH6OAsB4axoQeeD1oe0vZvL7SWFcAuhfqNZ5w5UaoT3WJLH0E
 0pNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794850763; x=1795455563;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Aq3DT6NyjM/Sd1zS8X6q7XKBpRC2c+VfGlhRrmSWjlQ=;
 b=txa1K7kPc8Ye4qUVIYK7i31lzDzH2pZ0H7bPROPNbKCvCZ2d0OljeSzl8qCLjfpv8I
 Hh/TfQtOIqnjk8XbzxjLb6vnCdfpcL2974cEDXpxgZCi3g8KWNMYQWfZl7XSobAq8umY
 tlMWnV/X3XvgJY/R5zAV7vWO4QyCkkraJQcDirGMiLfPCQ1g1fqiXgvQsv8IPfrP+zOp
 bv/aofp4LQ3ixJrYLFOFEtTlGowD/X8VJHrUrbNY0vgsZQYt+FtR9GEi6MT/FLSuZNET
 0Nll7UfREP3V/BeOm6Z88HVP4+FEBk80HnhPhED69GdCFSaGfelB5wfDcOvCuoXWnr7L
 y9OA==
X-Gm-Message-State: APuU4Z/SZmm7wN6LWfoUCk+7yYwGfwoy+m4Zg+jPGttktscUb69N4pDQ
 XyNe5zNpIJB4YJhPZlnhowJ/cKChN9ykon7Z0XLqOLN53A/ZRo7hX9gnaBlH6ZGgHIa9m35/zyS
 OXxeouv9L9bfUqR6XIMhbkXmIrB1VkP2rqpu9lcGXdp2mw/eD2+sKiIWIBnwuBYLHKZV4MKcJz3
 GoSV9llw==
X-Gm-Gg: AZFdTZee/QQkgewMKzFLRJtljdJzJJgSOmY1bM036op6bPbuEd0aEQbJmwmNB0Nm2gK
 NiAzeSvx1tP5LJ1CyguVZ10i7VGws/RsZQz/Hra6nT+NA/e6JZj3I4VN3NLa31xej3W1nAeAlSu
 9QeQufvo5KwEL/+1d+iRRBtETiG/3v6pvBj7iALN3rbsjvJe9dGy0KtWGkne4PGt9lpKhZkpE8e
 zuhxr0/XQgoBgu0w1CzfyouxDvqiaTr/fGIR+hDsNccBn4QA7XW10aR6s9S50PyTKmnDDQBb2Ym
 4rSe3jBZnddTdIT6WuV9mLCesjzaBNczhT4wZUTBgbHXuxGOInL1NiCdEF4KVR1uTMgCKGJo3Uh
 XgTd1jDHFW3dE6munK98ArHQ9hv+t/EmPWvTPfiCZflQimstFm74ZXh91RkHCd49pFT09O/6bmG
 bnwrmZ9CQvMEGQQoDuyXawyGSgvePFoHef4npcG6IS0r2yfyyOXEm3ToMy5DoQyaoKIZRnZjnIN
 rVVbLLVGeNm5PLoCE7oMEHRjgq9mECHpjCtdFIVQNd7kwAOna67Rgr2522ZE9lYjXMh/Ss9nb1w
 tqmBu6kmBjn6hVKXBSx9koLUHpx52WKvw4SryO5nqBRyYQakELFudZYsrEEMeesKgWKBLQ8MNbe
 as+MrHEyp0lfRpaKd25KNBxCcny4qjt75JeRuW/JSXaZ0q6zepFnlE7oMamHwy/vTWaIneAhBcN
 AJJn19imJ9SxbmWmI=
X-Received: by 2002:a05:6000:4819:b0:48f:bba5:732e with SMTP id
 ffacd0b85a97d-49c748646e4mr23234175f8f.57.1794850762180; 
 Mon, 16 Nov 2026 09:39:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c603f4d29sm22994687f8f.35.2026.11.16.09.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:39:21 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 17:39:20 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I7c9e123a458b9d3757e9de93f401e4e421741675
X-Gerrit-Change-Number: 2143
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2143?usp=email>
X-Gerrit-Commit: f4773397871ee461aee541104a3e430294633753
In-Reply-To: <gerrit.1793955112000.I7c9e123a458b9d3757e9de93f401e4e421741675@gerrit.openvpn.net>
References: <gerrit.1793955112000.I7c9e123a458b9d3757e9de93f401e4e421741675@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTU1MTEyMDAwLkk3YzllMTIzYTQ1OGI5ZDM3NTdlOWRlOTNmNDAxZTRlNDIxNzQxNjc1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7d7e6f3092ddb11935f5adb08ae9c9f9c5d8565c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT0fx-000000002GE-2fH5
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0510664277249556487=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0510664277249556487==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OhXjL1uMDoY="; charset=UTF-8

--OhXjL1uMDoY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2143?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: comp: share the stub comp=
ress methods with LZO and LZ4
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
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/2143/3
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

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7c9e123a45=
8b9d3757e9de93f401e4e421741675
Gerrit-Change-Number: 2143
Gerrit-PatchSet: =
3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>

--OhXjL1uMDoY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2143?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">com=
p: share the stub compress methods with LZO and LZ4<br><br>Since 7f0214c9 (=
&quot;Remove support for compression on send&quot;) the LZO and<br>LZ4 comp=
ress methods only add the stub framing, duplicating<br>stub_compress() and =
stubv2_compress()=2E Export those as<br>comp_stub_compress() and compv2_stu=
b_compress() and use them for all<br>methods=2E Also allocate the context o=
nly once in comp_init()=2E<br><br>This also fixes LZO sending dropped packe=
ts=2E encrypt_sign() drops<br>packets by setting buf=2Elen to 0 (e=2Eg=2E b=
efore client-connect has<br>completed) and still calls the compress method=
=2E lzo_compress()<br>prepended NO_COMPRESS_BYTE regardless, turning the dr=
opped packet into<br>a one byte packet that was sent=2E The stub methods re=
turn early on<br>empty buffers=2E<br><br>Change-Id: I7c9e123a458b9d3757e9de=
93f401e4e421741675<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2143<br>Message-Id: &lt;20=
261116105141=2E17064-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Ema=
il-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41415=2Ehtml<br=
>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M do=
c/doxygen/doc_compression=2Eh<br>M src/openvpn/comp-lz4=2Ec<br>M src/openvp=
n/comp=2Ec<br>M src/openvpn/comp=2Eh<br>M src/openvpn/compstub=2Ec<br>M src=
/openvpn/forward=2Eh<br>M src/openvpn/lzo=2Ec<br>7 files changed, 41 insert=
ions(+), 81 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/2143/3</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
doc/doxygen/doc_compression=2Eh b/doc/doxygen/doc_compression=2Eh</span><br=
><span>index 1f2e93bd1=2E=2Eefd18bf 100644</span><br><span>--- a/doc/doxyge=
n/doc_compression=2Eh</span><br><span>+++ b/doc/doxygen/doc_compression=2Eh=
</span><br><span>@@ -60,10 +60,10 @@</span><br><span>  * Data Channel Contr=
ol module\endlink and processes them according to the</span><br><span>  * s=
ettings of the packet&#39;s VPN tunnel=2E  The \link data_control Data</spa=
n><br><span>  * Channel Control module\endlink uses the following interface=
 functions:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * - For p=
ackets which will be sent to a remote OpenVPN peer: \c</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *   lzo_compress()</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * - For packets which have been received f=
rom a remote OpenVPN peer: \c</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *   lzo_decompress()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * - For packets which will be sent to a remote OpenVPN peer: the=
 \c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   compress me=
thod of \c compress_alg</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * - For packets which have been received from a remote OpenVPN peer: t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   \c decompres=
s method of \c compress_alg</span><br><span>  *</span><br><span>  * @par Se=
ttings that control this module&#39;s activity</span><br><span>  * Whether =
or not the Data Channel Compression module is active depends on</span><br><=
span>diff --git a/src/openvpn/comp-lz4=2Ec b/src/openvpn/comp-lz4=2Ec</span=
><br><span>index 0c5f22f=2E=2E736601a 100644</span><br><span>--- a/src/open=
vpn/comp-lz4=2Ec</span><br><span>+++ b/src/openvpn/comp-lz4=2Ec</span><br><=
span>@@ -55,40 +55,6 @@</span><br><span> {</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Doesn&#39;t do=
 any actual compression anymore */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-lz4_compress(struct buffer *buf, struct buffer work, struct compress_con=
text *compctx,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
      const struct frame *frame)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (b=
uf-&gt;len &lt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    uint8_t comp_head_byte =3D NO_COMPRESS_BYTE_SWAP;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *head =3D BPTR(=
buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *tai=
l =3D BEND(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    A=
SSERT(buf_safe(buf, 1));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    ++buf-&gt;len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* move head byte=
 of payload to tail */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    *tail =3D *head;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    *head =3D comp_head_byte;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/* Doesn&#39;t do any actual comp=
ression anymore */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-lz4v2_compres=
s(struct buffer *buf, struct buffer work, struct compress_context *compctx,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               const =
struct frame *frame)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &=
lt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    compv2_escape_data_ifneeded(buf);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> #if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an> #pragma GCC diagnostic push</span><br><span> #pragma GCC diagnostic ign=
ored &quot;-Wsign-conversion&quot;</span><br><span>@@ -207,9 +173,9 @@</spa=
n><br><span> #pragma GCC diagnostic pop</span><br><span> #endif</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-const struct co=
mpress_alg lz4_alg =3D { &quot;lz4&quot;, lz4_compress_init, lz4_compress_u=
ninit, lz4_compress,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                     lz4_decompress };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+const struct compress_alg lz4_alg =3D { =
&quot;lz4&quot;, lz4_compress_init, lz4_compress_uninit,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
comp_stub_compress, lz4_decompress };</span><br><span> </span><br><span> co=
nst struct compress_alg lz4v2_alg =3D { &quot;lz4v2&quot;, lz4v2_compress_i=
nit, lz4_compress_uninit,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                        lz4v2_compress, lz4v2_decompres=
s };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                         compv2_stub_compress, lz4v2_decompress };</span><b=
r><span> #endif /* ENABLE_LZ4 */</span><br><span>diff --git a/src/openvpn/c=
omp=2Ec b/src/openvpn/comp=2Ec</span><br><span>index 513a766=2E=2E6ce9152 1=
00644</span><br><span>--- a/src/openvpn/comp=2Ec</span><br><span>+++ b/src/=
openvpn/comp=2Ec</span><br><span>@@ -38,47 +38,41 @@</span><br><span> struc=
t compress_context *</span><br><span> comp_init(const struct compress_optio=
ns *opt)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct compress_context *compctx =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct compress_alg *alg;</span=
><br><span>     switch (opt-&gt;alg)</span><br><span>     {</span><br><span=
>         case COMP_ALG_STUB:</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            ALLOC_OBJ_CLEAR(compctx, struct compress_context);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            compctx-&gt;fl=
ags =3D opt-&gt;flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            compctx-&gt;alg =3D comp_stub_alg;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            alg =3D &amp;comp_stub_alg;</span><=
br><span>             break;</span><br><span> </span><br><span>         cas=
e COMP_ALGV2_UNCOMPRESSED:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            ALLOC_OBJ_CLEAR(compctx, struct compress_context);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            compctx-&gt;flags=
 =3D opt-&gt;flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          compctx-&gt;alg =3D compv2_stub_alg;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            alg =3D &amp;compv2_stub_alg;</span>=
<br><span>             break;</span><br><span> </span><br><span> #ifdef ENA=
BLE_LZO</span><br><span>         case COMP_ALG_LZO:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            ALLOC_OBJ_CLEAR(compctx, struct=
 compress_context);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          compctx-&gt;flags =3D opt-&gt;flags;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            compctx-&gt;alg =3D lzo_alg;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            alg =3D &amp;lzo_=
alg;</span><br><span>             break;</span><br><span> </span><br><span>=
 #endif</span><br><span> #ifdef ENABLE_LZ4</span><br><span>         case CO=
MP_ALG_LZ4:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  ALLOC_OBJ_CLEAR(compctx, struct compress_context);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            compctx-&gt;flags =3D opt-&gt;f=
lags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            comp=
ctx-&gt;alg =3D lz4_alg;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            alg =3D &amp;lz4_alg;</span><br><span>             break;<=
/span><br><span> </span><br><span>         case COMP_ALGV2_LZ4:</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            ALLOC_OBJ_CLEAR(compc=
tx, struct compress_context);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            compctx-&gt;flags =3D opt-&gt;flags;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            compctx-&gt;alg =3D lz4v2_al=
g;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            alg =
=3D &amp;lz4v2_alg;</span><br><span>             break;</span><br><span> #e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        default=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 NULL;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (compctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (*com=
pctx-&gt;alg=2Ecompress_init)(compctx);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct comp=
ress_context *compctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ALLOC_OBJ_CLEAR(compctx, struct compress_context);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    compctx-&gt;flags =3D opt-&gt;fla=
gs;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    compctx-&gt;=
alg =3D *alg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (*=
compctx-&gt;alg=2Ecompress_init)(compctx);</span><br><span> </span><br><spa=
n>     return compctx;</span><br><span> }</span><br><span>diff --git a/src/=
openvpn/comp=2Eh b/src/openvpn/comp=2Eh</span><br><span>index ad80243=2E=2E=
3f6411b 100644</span><br><span>--- a/src/openvpn/comp=2Eh</span><br><span>+=
++ b/src/openvpn/comp=2Eh</span><br><span>@@ -208,6 +208,14 @@</span><br><s=
pan> </span><br><span> void compv2_escape_data_ifneeded(struct buffer *buf)=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* Compress methods of the stub algorithms, also used by LZO and LZ4, which=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * no longer compre=
ss on send */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void c=
omp_stub_compress(struct buffer *buf, struct buffer work, struct compress_c=
ontext *compctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     const struct frame *frame);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void compv2_stub_compress(struct buffer *buf, struct buffer work,=
 struct compress_context *compctx,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                          const struct frame *frame);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static i=
nline bool</span><br><span> comp_enabled(const struct compress_options *inf=
o)</span><br><span> {</span><br><span>diff --git a/src/openvpn/compstub=2Ec=
 b/src/openvpn/compstub=2Ec</span><br><span>index 2eef587=2E=2Eb1115c9 1006=
44</span><br><span>--- a/src/openvpn/compstub=2Ec</span><br><span>+++ b/src=
/openvpn/compstub=2Ec</span><br><span>@@ -44,9 +44,9 @@</span><br><span> {<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-stub_compress(struct buffer *buf, struct buffer work, struct compress_=
context *compctx,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
          const struct frame *frame)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+comp_stub_compress(struct buffer *buf, struct buffer work, struct compres=
s_context *compctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                   const struct frame *frame)</span><br><span> {</span><br>=
<span>     if (buf-&gt;len &lt;=3D 0)</span><br><span>     {</span><br><spa=
n>@@ -104,9 +104,9 @@</span><br><span> }</span><br><span> </span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-stubv2_compress(struct buffer =
*buf, struct buffer work, struct compress_context *compctx,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                const struct frame *f=
rame)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+compv2_stub_compress(struct b=
uffer *buf, struct buffer work, struct compress_context *compctx,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                     const st=
ruct frame *frame)</span><br><span> {</span><br><span>     if (buf-&gt;len =
&lt;=3D 0)</span><br><span>     {</span><br><span>@@ -154,8 +154,8 @@</span=
><br><span> }</span><br><span> </span><br><span> const struct compress_alg =
compv2_stub_alg =3D { &quot;stubv2&quot;, stub_compress_init, stub_compress=
_uninit,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                                 stubv2_compress, stubv2_decompress };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                      compv2_stub_compress, stubv2_decompress };</span><br>=
<span> </span><br><span> const struct compress_alg comp_stub_alg =3D { &quo=
t;stub&quot;, stub_compress_init, stub_compress_uninit,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                                         =
   stub_compress, stub_decompress };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                            comp_stub_comp=
ress, stub_decompress };</span><br><span> #endif /* USE_STUB */</span><br><=
span>diff --git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</span><=
br><span>index 375635b=2E=2E1a67319 100644</span><br><span>--- a/src/openvp=
n/forward=2Eh</span><br><span>+++ b/src/openvpn/forward=2Eh</span><br><span=
>@@ -102,7 +102,7 @@</span><br><span>  * - Check that the client authentica=
tion has succeeded; if not, drop the</span><br><span>  *   packet=2E</span>=
<br><span>  * - If the \a comp_frag argument is true:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *   - Call \c lzo_compress() of the \link =
compression Data Channel Compression</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *   - Call the \c compress method of the \link compressio=
n Data Channel Compression</span><br><span>  *     module\endlink to (possi=
bly) compress the packet=2E</span><br><span>  *   - Call \c fragment_outgoi=
ng() of the \link fragmentation Data Channel Fragmentation</span><br><span>=
  *     module\endlink to (possibly) fragment the packet=2E</span><br><span=
>@@ -191,7 +191,7 @@</span><br><span>  * - Call \c fragment_incoming() of t=
he \link fragmentation Data Channel</span><br><span>  *   Fragmentation mod=
ule\endlink to reassemble the packet if it&#39;s</span><br><span>  *   frag=
mented=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * - Call \c=
 lzo_decompress() of the \link compression Data Channel</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * - Call the \c decompress method of t=
he \link compression Data Channel</span><br><span>  *   Compression module\=
endlink to decompress the packet if it&#39;s</span><br><span>  *   compress=
ed=2E</span><br><span>  * - Place the resulting packet in \c c-&gt;c2=2Eto_=
tun so that it can be sent</span><br><span>diff --git a/src/openvpn/lzo=2Ec=
 b/src/openvpn/lzo=2Ec</span><br><span>index 2b0691b=2E=2E207cea6 100644</s=
pan><br><span>--- a/src/openvpn/lzo=2Ec</span><br><span>+++ b/src/openvpn/l=
zo=2Ec</span><br><span>@@ -70,14 +70,6 @@</span><br><span> }</span><br><spa=
n> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-lzo_compress(struct buffer *buf, struct buffer work, struct comp=
ress_context *compctx,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-             const struct frame *frame)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   uint8_t *header =3D buf_prepend(buf, 1);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    *header =3D NO_COMPRESS_BYTE;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
void</span><br><span> lzo_decompress(struct buffer *buf, struct buffer work=
, struct compress_context *compctx,</span><br><span>                const s=
truct frame *frame)</span><br><span> {</span><br><span>@@ -129,6 +121,6 @@<=
/span><br><span> #pragma GCC diagnostic pop</span><br><span> #endif</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-const struc=
t compress_alg lzo_alg =3D { &quot;lzo&quot;, lzo_compress_init, lzo_compre=
ss_uninit, lzo_compress,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                      lzo_decompress };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+const struct compress_alg lzo_alg =
=3D { &quot;lzo&quot;, lzo_compress_init, lzo_compress_uninit,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
      comp_stub_compress, lzo_decompress };</span><br><span> #endif /* ENAB=
LE_LZO */</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2143?usp=3Demail">change 2143</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2143?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I7c9e123a458b9d3757e9d=
e93f401e4e421741675 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2143 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div =
style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--OhXjL1uMDoY=--


--===============0510664277249556487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0510664277249556487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0510664277249556487==--

