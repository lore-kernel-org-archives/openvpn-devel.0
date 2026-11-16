Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480D9606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RwOxjCp/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jIjbCqVW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WMDcNxQe;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eNHMW4Lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WwTJ4JHkpKG9KlwRzsDi26Nv/ft65FtAYkexHWE02bA=; b=RwOxjCp/1np1Hk5IEft13n/Hoq
	XCq5NdjR2zj+W9URbcrAum2kkVxQ2jukIynm3k5w/nmlAXcUxOrRZcEbXnJRBUo8MyNwd2+pZ4uXj
	agLDUAu4w50WwCGlTHd1jI9csD2BYzAkTkTL1hw4Ku+Sy7ogp5JMaKaajW+yZy1oxaR8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSu5a-000000005sX-1QqQ;
	Mon, 16 Nov 2026 10:37:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSu5Y-000000005sR-4B6I
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:37:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+c4rI/P1UEe1zFupQGX6+O/f4ijH5qaCkIUT8Oif5zg=; b=jIjbCqVWdU6WHnF1fzAXk/KZcV
 SXYBJr5x7zlYTJjEN+zXKdFrGKUFpZoYdR603HQz8pIWUbkN5y4z8enzQzqfCWm3XFivc/9tG48Pr
 9xn2MyklmojEwla4/3l11t5ZVRCFRwqju8qUxus0kglKgoGcXBgefN8N06+abEz3CVfs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+c4rI/P1UEe1zFupQGX6+O/f4ijH5qaCkIUT8Oif5zg=; b=WMDcNxQewYvrerUQNpS/AnCpPA
 UaUHoCtd+n4oiu06G2x36nwUMEG4bmh+80KI0wMU9zfq3rnbHnjSeTDfoKFiBCbpg6POBBRcpAjCn
 n8wvnOoRc8FZF0CrYvGq4EO/nEwjTIkE8VvZvBJGFxcYC6dgfNDYNlVl3CSykHsoVibI=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSu5W-0000000018P-3TBU for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:37:28 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb6057b333so7339005e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 02:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794825440; x=1795430240; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+c4rI/P1UEe1zFupQGX6+O/f4ijH5qaCkIUT8Oif5zg=;
 b=eNHMW4LtEZUvapjMDrnpe7m1onv+qoCRE9lYwk8AFidG8JA5KcLzTVZo63ZBDfmN5p
 VvfuoiyYS9QiCoe59RA2nh/66KzEUxE/tZkFNhUGTCiY7Sor/3+8Cj365dcGrXXj0evs
 YdsF0wTjSkBVmRJOgr7XRDeGTesPxOCRXkQFR7x0wz6UEkZQSQ0FBBBzb0bkbXPoVWSs
 tN/pp4k3Qq7nUjup7iFOnhsn2VlO/7WtThelT2dhOrlRYa6ih0YeDv4tywhsPDM2/9PO
 XCv1oqUj0wYuDfR1qd8qY4DOt686SybUOOdTPROaHAxTMEryfUuokkr6Cp8kgvyDa8cI
 db9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794825440; x=1795430240;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+c4rI/P1UEe1zFupQGX6+O/f4ijH5qaCkIUT8Oif5zg=;
 b=Y1wW5jdYcO2ouGh95NBFrPpcAm0AAt7945ejz62ZcHxCER2v/Yzzm1VwL9yL5Pj+/W
 UsOweSNwCiMOMIXQyJN9eS9ch+zEd4b+SgsYClbfyMOm2efur8NvkcLb/J1MCEw4ZYHt
 IYtOcO84+KxEwimYNvAOEUtwqjmC/cNNL1w+bqVHuKCyfeFccOhC07rRvr7e/o7q6uAG
 V/VBYxoyVVckUaZQw1belZwH4YJf+tatgt5pnVhd7FWJNiNtTC5Dy5HGolk9zsSdGQXI
 o7s8br9yK/g3NFwSgNCAUHyEMlw/jPZgidlhzb08cf4XYNb07JGYLLa7WfXDQ4KiZlpR
 fuow==
X-Gm-Message-State: APuU4Z8rEMhQNfSoCvemX+e/mVjmrDK0vnjpILooYh5YGogocxtMUQd4
 pUKlrHoxD9bMF3yxek5y4NdSNa9l6060Um9QdKgD6FB8HkmbYqlYAuYgFSm6UlyC/SDyNJv/fhv
 X3JHtuUwECFulc8H8/m7oTUqzf29awYdR6WxZUq2OOUO9mBnB9feqOUc4Hg78UlXZsbn/+p6K5A
 A6E5tkeg==
X-Gm-Gg: AYBFou0+cx8KUrRSfPmbDFOM0leMcOnPoIO9kHRhZLnfp4YfdiYoUCkiZwdbDNLrSLn
 tT/3UrHndQUSKlOUKZfoinwnh0G2knQhOKVGxhP4+z+nNBbKC0SoCOTH3mdsXDCgq/d5flvdVWB
 uvjwQg6AafiRbGFqvkzIyeZBt1z9FBBSH+Yu15ygIfIG0nhnM6+MvdK+mHFTINwqtJuz21XGe/X
 wvi/6N4gIH1uxM0vv9mXbdFjVBOyNimawIPsIbKfreaIeVjky9Fj9O2uALe4O7udi8+XF/YL0S9
 kPGEVm2IDdiNgXA/f6HH/r9rIDx+5ae/TBSEj56Ts2YL6LPBv0zppsIGxTvy5Gp+KpfaTmyX4/t
 W45+tBLzRLjgp4QXw5k5dBdlmW0vDvI1YhpR3asDmwkzVyoWAxfxG2IH7yIBBqmYNUhRJUmuUrz
 pDdPWBtWw14+IMZoaLg/2yGJTxA90O+WAIWB25oYut+iwCQoiyuMQ2/nJNMFry8BjqXTjSmpmML
 57t8eWpQIVMdv6QVb6W0sQr87TFxOf4DZEBpCcK9B02PF+fjYqkDaxcxKSWRQXaPw0G7GgZy2Wt
 x3phySK0Pl0AiMUQMhVmEbd3PvqKnQTqGVQPWro28gEXprIO8mF5WfXrJka3yxvMJkPt2ZwuoGD
 dCjvk5mpfwDNuSXw2po/vXyasG+CYA8oZr1DHrFi4xBS+YcXUNGhQvOEq/JE6LNKorW3p1ofhOT
 pZ3VV9rmQrofEwilU=
X-Received: by 2002:a05:600c:c16d:b0:4ba:495c:2f5d with SMTP id
 5b1f17b1804b1-4bb55a3e3f0mr202441105e9.9.1794825439852; 
 Mon, 16 Nov 2026 02:37:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae5299sm296588265e9.11.2026.11.16.02.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:37:19 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 10:37:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7c9e123a458b9d3757e9de93f401e4e421741675
X-Gerrit-Change-Number: 2143
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2143?usp=email>
X-Gerrit-Commit: 45bb87ff21bbf6320ef25fbe398d62c30385dd7b
In-Reply-To: <gerrit.1793955112000.I7c9e123a458b9d3757e9de93f401e4e421741675@gerrit.openvpn.net>
References: <gerrit.1793955112000.I7c9e123a458b9d3757e9de93f401e4e421741675@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTU1MTEyMDAwLkk3YzllMTIzYTQ1OGI5ZDM3NTdlOWRlOTNmNDAxZTRlNDIxNzQxNjc1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4bab1b00c6143e46a8c9e6f7cc2e07f6e8a38518-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSu5W-0000000018P-3TBU
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8047152989938169573=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8047152989938169573==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pgg18m8sVO8="; charset=UTF-8

--pgg18m8sVO8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, Frank Lichtenheld, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2143?usp=3Demail

to look at the new patch set (#2)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review+2 by Frank Licht=
enheld

The change is no longer submittable: Code-Review and checks~ChecksS=
ubmitRule are unsatisfied now=2E


Change subject: comp: share the stub com=
press methods with LZO and LZ4
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

comp: share the stub compress methods with LZO and LZ4
=

Since 7f0214c9 ("Remove support for compression on send") the LZO and
LZ4 =
compress methods only add the stub framing, duplicating
stub_compress() and=
 stubv2_compress()=2E Export those as
comp_stub_compress() and compv2_stub_=
compress() and use them for all
methods=2E Also allocate the context only o=
nce in comp_init()=2E

This also fixes LZO sending dropped packets=2E encry=
pt_sign() drops
packets by setting buf=2Elen to 0 (e=2Eg=2E before client-c=
onnect has
completed) and still calls the compress method=2E lzo_compress()=

prepended NO_COMPRESS_BYTE regardless, turning the dropped packet into
a o=
ne byte packet that was sent=2E The stub methods return early on
empty buff=
ers=2E

Change-Id: I7c9e123a458b9d3757e9de93f401e4e421741675
Signed-off-by:=
 Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M doc/doxygen/doc_compression=
=2Eh
M src/openvpn/comp-lz4=2Ec
M src/openvpn/comp=2Ec
M src/openvpn/comp=
=2Eh
M src/openvpn/compstub=2Ec
M src/openvpn/forward=2Eh
M src/openvpn/lzo=
=2Ec
7 files changed, 41 insertions(+), 81 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/2143/2

diff --git a/d=
oc/doxygen/doc_compression=2Eh b/doc/doxygen/doc_compression=2Eh
index 1f2e=
93bd1=2E=2Eefd18bf 100644
--- a/doc/doxygen/doc_compression=2Eh
+++ b/doc/d=
oxygen/doc_compression=2Eh
@@ -60,10 +60,10 @@
  * Data Channel Control mod=
ule\endlink and processes them according to the
  * settings of the packet'=
s VPN tunnel=2E  The \link data_control Data
  * Channel Control module\end=
link uses the following interface functions:
- * - For packets which will b=
e sent to a remote OpenVPN peer: \c
- *   lzo_compress()
- * - For packets =
which have been received from a remote OpenVPN peer: \c
- *   lzo_decompres=
s()
+ * - For packets which will be sent to a remote OpenVPN peer: the \c
+=
 *   compress method of \c compress_alg
+ * - For packets which have been r=
eceived from a remote OpenVPN peer: the
+ *   \c decompress method of \c co=
mpress_alg
  *
  * @par Settings that control this module's activity
  * Wh=
ether or not the Data Channel Compression module is active depends on
diff =
--git a/src/openvpn/comp-lz4=2Ec b/src/openvpn/comp-lz4=2Ec
index 0c5f22f=
=2E=2E736601a 100644
--- a/src/openvpn/comp-lz4=2Ec
+++ b/src/openvpn/comp-=
lz4=2Ec
@@ -55,40 +55,6 @@
 {
 }
 
-/* Doesn't do any actual compression an=
ymore */
-static void
-lz4_compress(struct buffer *buf, struct buffer work,=
 struct compress_context *compctx,
-             const struct frame *frame)=

-{
-    if (buf->len <=3D 0)
-    {
-        return;
-    }
-
-    uint8_t=
 comp_head_byte =3D NO_COMPRESS_BYTE_SWAP;
-    uint8_t *head =3D BPTR(buf)=
;
-    uint8_t *tail =3D BEND(buf);
-    ASSERT(buf_safe(buf, 1));
-    ++b=
uf->len;
-
-    /* move head byte of payload to tail */
-    *tail =3D *hea=
d;
-    *head =3D comp_head_byte;
-}
-
-/* Doesn't do any actual compressio=
n anymore */
-static void
-lz4v2_compress(struct buffer *buf, struct buffer=
 work, struct compress_context *compctx,
-               const struct frame=
 *frame)
-{
-    if (buf->len <=3D 0)
-    {
-        return;
-    }
-
-   =
 compv2_escape_data_ifneeded(buf);
-}
-
 #if defined(__GNUC__) || defined(_=
_clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Ws=
ign-conversion"
@@ -207,9 +173,9 @@
 #pragma GCC diagnostic pop
 #endif
 
-=
const struct compress_alg lz4_alg =3D { "lz4", lz4_compress_init, lz4_compr=
ess_uninit, lz4_compress,
-                                      lz4_decomp=
ress };
+const struct compress_alg lz4_alg =3D { "lz4", lz4_compress_init, =
lz4_compress_uninit,
+                                      comp_stub_compr=
ess, lz4_decompress };
 
 const struct compress_alg lz4v2_alg =3D { "lz4v2"=
, lz4v2_compress_init, lz4_compress_uninit,
-                              =
          lz4v2_compress, lz4v2_decompress };
+                            =
            compv2_stub_compress, lz4v2_decompress };
 #endif /* ENABLE_LZ4=
 */
diff --git a/src/openvpn/comp=2Ec b/src/openvpn/comp=2Ec
index 513a766=
=2E=2E6ce9152 100644
--- a/src/openvpn/comp=2Ec
+++ b/src/openvpn/comp=2Ec
=
@@ -38,47 +38,41 @@
 struct compress_context *
 comp_init(const struct comp=
ress_options *opt)
 {
-    struct compress_context *compctx =3D NULL;
+    =
const struct compress_alg *alg;
     switch (opt->alg)
     {
         case=
 COMP_ALG_STUB:
-            ALLOC_OBJ_CLEAR(compctx, struct compress_conte=
xt);
-            compctx->flags =3D opt->flags;
-            compctx->alg =
=3D comp_stub_alg;
+            alg =3D &comp_stub_alg;
             break;=

 
         case COMP_ALGV2_UNCOMPRESSED:
-            ALLOC_OBJ_CLEAR(comp=
ctx, struct compress_context);
-            compctx->flags =3D opt->flags;
=
-            compctx->alg =3D compv2_stub_alg;
+            alg =3D &compv2=
_stub_alg;
             break;
 
 #ifdef ENABLE_LZO
         case COMP_ALG_=
LZO:
-            ALLOC_OBJ_CLEAR(compctx, struct compress_context);
-     =
       compctx->flags =3D opt->flags;
-            compctx->alg =3D lzo_alg=
;
+            alg =3D &lzo_alg;
             break;
 
 #endif
 #ifdef ENAB=
LE_LZ4
         case COMP_ALG_LZ4:
-            ALLOC_OBJ_CLEAR(compctx, st=
ruct compress_context);
-            compctx->flags =3D opt->flags;
-      =
      compctx->alg =3D lz4_alg;
+            alg =3D &lz4_alg;
            =
 break;
 
         case COMP_ALGV2_LZ4:
-            ALLOC_OBJ_CLEAR(compct=
x, struct compress_context);
-            compctx->flags =3D opt->flags;
- =
           compctx->alg =3D lz4v2_alg;
+            alg =3D &lz4v2_alg;
   =
          break;
 #endif
+        default:
+            return NULL;
     }=

-    if (compctx)
-    {
-        (*compctx->alg=2Ecompress_init)(compctx)=
;
-    }
+
+    struct compress_context *compctx;
+    ALLOC_OBJ_CLEAR(comp=
ctx, struct compress_context);
+    compctx->flags =3D opt->flags;
+    com=
pctx->alg =3D *alg;
+    (*compctx->alg=2Ecompress_init)(compctx);
 
     r=
eturn compctx;
 }
diff --git a/src/openvpn/comp=2Eh b/src/openvpn/comp=2Eh
=
index ad80243=2E=2E3f6411b 100644
--- a/src/openvpn/comp=2Eh
+++ b/src/open=
vpn/comp=2Eh
@@ -208,6 +208,14 @@
 
 void compv2_escape_data_ifneeded(struc=
t buffer *buf);
 
+/* Compress methods of the stub algorithms, also used by=
 LZO and LZ4, which
+ * no longer compress on send */
+void comp_stub_compr=
ess(struct buffer *buf, struct buffer work, struct compress_context *compct=
x,
+                        const struct frame *frame);
+
+void compv2_stub=
_compress(struct buffer *buf, struct buffer work, struct compress_context *=
compctx,
+                          const struct frame *frame);
+
 static i=
nline bool
 comp_enabled(const struct compress_options *info)
 {
diff --git=
 a/src/openvpn/compstub=2Ec b/src/openvpn/compstub=2Ec
index 2eef587=2E=2Eb=
1115c9 100644
--- a/src/openvpn/compstub=2Ec
+++ b/src/openvpn/compstub=2Ec=

@@ -44,9 +44,9 @@
 {
 }
 
-static void
-stub_compress(struct buffer *buf, =
struct buffer work, struct compress_context *compctx,
-              const =
struct frame *frame)
+void
+comp_stub_compress(struct buffer *buf, struct b=
uffer work, struct compress_context *compctx,
+                   const str=
uct frame *frame)
 {
     if (buf->len <=3D 0)
     {
@@ -104,9 +104,9 @@
 =
}
 
 
-static void
-stubv2_compress(struct buffer *buf, struct buffer work,=
 struct compress_context *compctx,
-                const struct frame *fra=
me)
+void
+compv2_stub_compress(struct buffer *buf, struct buffer work, str=
uct compress_context *compctx,
+                     const struct frame *fr=
ame)
 {
     if (buf->len <=3D 0)
     {
@@ -154,8 +154,8 @@
 }
 
 const st=
ruct compress_alg compv2_stub_alg =3D { "stubv2", stub_compress_init, stub_=
compress_uninit,
-                                              stubv2_comp=
ress, stubv2_decompress };
+                                              c=
ompv2_stub_compress, stubv2_decompress };
 
 const struct compress_alg comp=
_stub_alg =3D { "stub", stub_compress_init, stub_compress_uninit,
-        =
                                    stub_compress, stub_decompress };
+    =
                                        comp_stub_compress, stub_decompress=
 };
 #endif /* USE_STUB */
diff --git a/src/openvpn/forward=2Eh b/src/openv=
pn/forward=2Eh
index 375635b=2E=2E1a67319 100644
--- a/src/openvpn/forward=
=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -102,7 +102,7 @@
  * - Check that the=
 client authentication has succeeded; if not, drop the
  *   packet=2E
  * =
- If the \a comp_frag argument is true:
- *   - Call \c lzo_compress() of t=
he \link compression Data Channel Compression
+ *   - Call the \c compress =
method of the \link compression Data Channel Compression
  *     module\end=
link to (possibly) compress the packet=2E
  *   - Call \c fragment_outgoing=
() of the \link fragmentation Data Channel Fragmentation
  *     module\end=
link to (possibly) fragment the packet=2E
@@ -191,7 +191,7 @@
  * - Call \c=
 fragment_incoming() of the \link fragmentation Data Channel
  *   Fragment=
ation module\endlink to reassemble the packet if it's
  *   fragmented=2E
-=
 * - Call \c lzo_decompress() of the \link compression Data Channel
+ * - C=
all the \c decompress method of the \link compression Data Channel
  *   Co=
mpression module\endlink to decompress the packet if it's
  *   compressed=
=2E
  * - Place the resulting packet in \c c->c2=2Eto_tun so that it can be=
 sent
diff --git a/src/openvpn/lzo=2Ec b/src/openvpn/lzo=2Ec
index 2b0691b=
=2E=2E207cea6 100644
--- a/src/openvpn/lzo=2Ec
+++ b/src/openvpn/lzo=2Ec
@@=
 -70,14 +70,6 @@
 }
 
 static void
-lzo_compress(struct buffer *buf, struct=
 buffer work, struct compress_context *compctx,
-             const struct =
frame *frame)
-{
-    uint8_t *header =3D buf_prepend(buf, 1);
-    *header=
 =3D NO_COMPRESS_BYTE;
-}
-
-static void
 lzo_decompress(struct buffer *buf=
, struct buffer work, struct compress_context *compctx,
                con=
st struct frame *frame)
 {
@@ -129,6 +121,6 @@
 #pragma GCC diagnostic pop
=
 #endif
 
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

Gerrit-MessageType: newpatchset
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: I7c9e123a458b9d3757e9de93f401e4=
e421741675
Gerrit-Change-Number: 2143
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>

--pgg18m8sVO8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #2</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2143?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by Frank Lichtenheld</p><p>The change is =
no longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisf=
ied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">comp: share the stub compress methods with LZO =
and LZ4<br><br>Since 7f0214c9 (&quot;Remove support for compression on send=
&quot;) the LZO and<br>LZ4 compress methods only add the stub framing, dupl=
icating<br>stub_compress() and stubv2_compress()=2E Export those as<br>comp=
_stub_compress() and compv2_stub_compress() and use them for all<br>methods=
=2E Also allocate the context only once in comp_init()=2E<br><br>This also =
fixes LZO sending dropped packets=2E encrypt_sign() drops<br>packets by set=
ting buf=2Elen to 0 (e=2Eg=2E before client-connect has<br>completed) and s=
till calls the compress method=2E lzo_compress()<br>prepended NO_COMPRESS_B=
YTE regardless, turning the dropped packet into<br>a one byte packet that w=
as sent=2E The stub methods return early on<br>empty buffers=2E<br><br>Chan=
ge-Id: I7c9e123a458b9d3757e9de93f401e4e421741675<br>Signed-off-by: Razvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M doc/doxygen/doc_compressi=
on=2Eh<br>M src/openvpn/comp-lz4=2Ec<br>M src/openvpn/comp=2Ec<br>M src/ope=
nvpn/comp=2Eh<br>M src/openvpn/compstub=2Ec<br>M src/openvpn/forward=2Eh<br=
>M src/openvpn/lzo=2Ec<br>7 files changed, 41 insertions(+), 81 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/43/2143/2</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/doc/doxygen/doc_compressi=
on=2Eh b/doc/doxygen/doc_compression=2Eh</span><br><span>index 1f2e93bd1=2E=
=2Eefd18bf 100644</span><br><span>--- a/doc/doxygen/doc_compression=2Eh</sp=
an><br><span>+++ b/doc/doxygen/doc_compression=2Eh</span><br><span>@@ -60,1=
0 +60,10 @@</span><br><span>  * Data Channel Control module\endlink and pro=
cesses them according to the</span><br><span>  * settings of the packet&#39=
;s VPN tunnel=2E  The \link data_control Data</span><br><span>  * Channel C=
ontrol module\endlink uses the following interface functions:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * - For packets which will be sent=
 to a remote OpenVPN peer: \c</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *   lzo_compress()</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * - For packets which have been received from a remote OpenVPN peer:=
 \c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   lzo_decompres=
s()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - For packets=
 which will be sent to a remote OpenVPN peer: the \c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *   compress method of \c compress_alg</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - For packets whic=
h have been received from a remote OpenVPN peer: the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *   \c decompress method of \c compress_=
alg</span><br><span>  *</span><br><span>  * @par Settings that control this=
 module&#39;s activity</span><br><span>  * Whether or not the Data Channel =
Compression module is active depends on</span><br><span>diff --git a/src/op=
envpn/comp-lz4=2Ec b/src/openvpn/comp-lz4=2Ec</span><br><span>index 0c5f22f=
=2E=2E736601a 100644</span><br><span>--- a/src/openvpn/comp-lz4=2Ec</span><=
br><span>+++ b/src/openvpn/comp-lz4=2Ec</span><br><span>@@ -55,40 +55,6 @@<=
/span><br><span> {</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/* Doesn&#39;t do any actual compression =
anymore */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-lz4_compress(struct b=
uffer *buf, struct buffer work, struct compress_context *compctx,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-             const struct frame=
 *frame)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt;=3D 0)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint=
8_t comp_head_byte =3D NO_COMPRESS_BYTE_SWAP;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    uint8_t *head =3D BPTR(buf);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    uint8_t *tail =3D BEND(buf);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_safe(buf, 1));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ++buf-&gt;len;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* move head byte of payload to tail */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *tail =3D *head;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *head =3D comp_hea=
d_byte;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/* Doesn&#39;t do any actual compression anymore */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-lz4v2_compress(struct buffer *buf, =
struct buffer work, struct compress_context *compctx,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-               const struct frame *frame)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt;=3D 0)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    compv2_escape_=
data_ifneeded(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #if =
defined(__GNUC__) || defined(__clang__)</span><br><span> #pragma GCC diagno=
stic push</span><br><span> #pragma GCC diagnostic ignored &quot;-Wsign-conv=
ersion&quot;</span><br><span>@@ -207,9 +173,9 @@</span><br><span> #pragma G=
CC diagnostic pop</span><br><span> #endif</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-const struct compress_alg lz4_alg =3D=
 { &quot;lz4&quot;, lz4_compress_init, lz4_compress_uninit, lz4_compress,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
               lz4_decompress };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+const struct compress_alg lz4_alg =3D { &quot;lz4&quot;, lz4_c=
ompress_init, lz4_compress_uninit,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                      comp_stub_compress, lz=
4_decompress };</span><br><span> </span><br><span> const struct compress_al=
g lz4v2_alg =3D { &quot;lz4v2&quot;, lz4v2_compress_init, lz4_compress_unin=
it,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
                      lz4v2_compress, lz4v2_decompress };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
   compv2_stub_compress, lz4v2_decompress };</span><br><span> #endif /* ENA=
BLE_LZ4 */</span><br><span>diff --git a/src/openvpn/comp=2Ec b/src/openvpn/=
comp=2Ec</span><br><span>index 513a766=2E=2E6ce9152 100644</span><br><span>=
--- a/src/openvpn/comp=2Ec</span><br><span>+++ b/src/openvpn/comp=2Ec</span=
><br><span>@@ -38,47 +38,41 @@</span><br><span> struct compress_context *</=
span><br><span> comp_init(const struct compress_options *opt)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct compr=
ess_context *compctx =3D NULL;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const struct compress_alg *alg;</span><br><span>     switch =
(opt-&gt;alg)</span><br><span>     {</span><br><span>         case COMP_ALG=
_STUB:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ALL=
OC_OBJ_CLEAR(compctx, struct compress_context);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            compctx-&gt;flags =3D opt-&gt;flags;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            compctx-&g=
t;alg =3D comp_stub_alg;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            alg =3D &amp;comp_stub_alg;</span><br><span>             b=
reak;</span><br><span> </span><br><span>         case COMP_ALGV2_UNCOMPRESS=
ED:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ALLOC_=
OBJ_CLEAR(compctx, struct compress_context);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            compctx-&gt;flags =3D opt-&gt;flags;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            compctx-&gt;a=
lg =3D compv2_stub_alg;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            alg =3D &amp;compv2_stub_alg;</span><br><span>             =
break;</span><br><span> </span><br><span> #ifdef ENABLE_LZO</span><br><span=
>         case COMP_ALG_LZO:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            ALLOC_OBJ_CLEAR(compctx, struct compress_context);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            compctx-&gt;fla=
gs =3D opt-&gt;flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            compctx-&gt;alg =3D lzo_alg;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            alg =3D &amp;lzo_alg;</span><br><span>    =
         break;</span><br><span> </span><br><span> #endif</span><br><span> =
#ifdef ENABLE_LZ4</span><br><span>         case COMP_ALG_LZ4:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            ALLOC_OBJ_CLEAR(compctx=
, struct compress_context);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            compctx-&gt;flags =3D opt-&gt;flags;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            compctx-&gt;alg =3D lz4_alg;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            alg =3D &=
amp;lz4_alg;</span><br><span>             break;</span><br><span> </span><b=
r><span>         case COMP_ALGV2_LZ4:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            ALLOC_OBJ_CLEAR(compctx, struct compress_contex=
t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            compct=
x-&gt;flags =3D opt-&gt;flags;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            compctx-&gt;alg =3D lz4v2_alg;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            alg =3D &amp;lz4v2_alg;</span=
><br><span>             break;</span><br><span> #endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return NULL;</span><br><span>=
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (compctx=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        (*compctx-&gt;alg=2Ecompress=
_init)(compctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct compress_context *compctx;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(=
compctx, struct compress_context);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    compctx-&gt;flags =3D opt-&gt;flags;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    compctx-&gt;alg =3D *alg;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    (*compctx-&gt;alg=2Ecompr=
ess_init)(compctx);</span><br><span> </span><br><span>     return compctx;<=
/span><br><span> }</span><br><span>diff --git a/src/openvpn/comp=2Eh b/src/=
openvpn/comp=2Eh</span><br><span>index ad80243=2E=2E3f6411b 100644</span><b=
r><span>--- a/src/openvpn/comp=2Eh</span><br><span>+++ b/src/openvpn/comp=
=2Eh</span><br><span>@@ -208,6 +208,14 @@</span><br><span> </span><br><span=
> void compv2_escape_data_ifneeded(struct buffer *buf);</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Compress methods o=
f the stub algorithms, also used by LZO and LZ4, which</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * no longer compress on send */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void comp_stub_compress(str=
uct buffer *buf, struct buffer work, struct compress_context *compctx,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
const struct frame *frame);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void compv2=
_stub_compress(struct buffer *buf, struct buffer work, struct compress_cont=
ext *compctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                    const struct frame *frame);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static inline bool</span><br>=
<span> comp_enabled(const struct compress_options *info)</span><br><span> {=
</span><br><span>diff --git a/src/openvpn/compstub=2Ec b/src/openvpn/compst=
ub=2Ec</span><br><span>index 2eef587=2E=2Eb1115c9 100644</span><br><span>--=
- a/src/openvpn/compstub=2Ec</span><br><span>+++ b/src/openvpn/compstub=2Ec=
</span><br><span>@@ -44,9 +44,9 @@</span><br><span> {</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stub_compress(st=
ruct buffer *buf, struct buffer work, struct compress_context *compctx,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-              const struc=
t frame *frame)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+comp_stub_compress(=
struct buffer *buf, struct buffer work, struct compress_context *compctx,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   co=
nst struct frame *frame)</span><br><span> {</span><br><span>     if (buf-&g=
t;len &lt;=3D 0)</span><br><span>     {</span><br><span>@@ -104,9 +104,9 @@=
</span><br><span> }</span><br><span> </span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-stubv2_compress(struct buffer *buf, struct buffer w=
ork, struct compress_context *compctx,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                const struct frame *frame)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+compv2_stub_compress(struct buffer *buf, struct bu=
ffer work, struct compress_context *compctx,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                     const struct frame *frame)</s=
pan><br><span> {</span><br><span>     if (buf-&gt;len &lt;=3D 0)</span><br>=
<span>     {</span><br><span>@@ -154,8 +154,8 @@</span><br><span> }</span><=
br><span> </span><br><span> const struct compress_alg compv2_stub_alg =3D {=
 &quot;stubv2&quot;, stub_compress_init, stub_compress_uninit,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
            stubv2_compress, stubv2_decompress };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                             =
 compv2_stub_compress, stubv2_decompress };</span><br><span> </span><br><sp=
an> const struct compress_alg comp_stub_alg =3D { &quot;stub&quot;, stub_co=
mpress_init, stub_compress_uninit,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                            stub_compress, stu=
b_decompress };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                                        comp_stub_compress, stub_decompress=
 };</span><br><span> #endif /* USE_STUB */</span><br><span>diff --git a/src=
/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</span><br><span>index 375635=
b=2E=2E1a67319 100644</span><br><span>--- a/src/openvpn/forward=2Eh</span><=
br><span>+++ b/src/openvpn/forward=2Eh</span><br><span>@@ -102,7 +102,7 @@<=
/span><br><span>  * - Check that the client authentication has succeeded; i=
f not, drop the</span><br><span>  *   packet=2E</span><br><span>  * - If th=
e \a comp_frag argument is true:</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *   - Call \c lzo_compress() of the \link compression Data Chan=
nel Compression</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
 - Call the \c compress method of the \link compression Data Channel Compre=
ssion</span><br><span>  *     module\endlink to (possibly) compress the pac=
ket=2E</span><br><span>  *   - Call \c fragment_outgoing() of the \link fra=
gmentation Data Channel Fragmentation</span><br><span>  *     module\endlin=
k to (possibly) fragment the packet=2E</span><br><span>@@ -191,7 +191,7 @@<=
/span><br><span>  * - Call \c fragment_incoming() of the \link fragmentatio=
n Data Channel</span><br><span>  *   Fragmentation module\endlink to reasse=
mble the packet if it&#39;s</span><br><span>  *   fragmented=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * - Call \c lzo_decompress() of =
the \link compression Data Channel</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * - Call the \c decompress method of the \link compression =
Data Channel</span><br><span>  *   Compression module\endlink to decompress=
 the packet if it&#39;s</span><br><span>  *   compressed=2E</span><br><span=
>  * - Place the resulting packet in \c c-&gt;c2=2Eto_tun so that it can be=
 sent</span><br><span>diff --git a/src/openvpn/lzo=2Ec b/src/openvpn/lzo=2E=
c</span><br><span>index 2b0691b=2E=2E207cea6 100644</span><br><span>--- a/s=
rc/openvpn/lzo=2Ec</span><br><span>+++ b/src/openvpn/lzo=2Ec</span><br><spa=
n>@@ -70,14 +70,6 @@</span><br><span> }</span><br><span> </span><br><span> =
static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-lzo_compre=
ss(struct buffer *buf, struct buffer work, struct compress_context *compctx=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             const s=
truct frame *frame)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *header =
=3D buf_prepend(buf, 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    *header =3D NO_COMPRESS_BYTE;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><spa=
n> lzo_decompress(struct buffer *buf, struct buffer work, struct compress_c=
ontext *compctx,</span><br><span>                const struct frame *frame)=
</span><br><span> {</span><br><span>@@ -129,6 +121,6 @@</span><br><span> #p=
ragma GCC diagnostic pop</span><br><span> #endif</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-const struct compress_alg lzo_=
alg =3D { &quot;lzo&quot;, lzo_compress_init, lzo_compress_uninit, lzo_comp=
ress,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                      lzo_decompress };</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+const struct compress_alg lzo_alg =3D { &quot;lzo&quot;=
, lzo_compress_init, lzo_compress_uninit,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                      comp_stub_compr=
ess, lzo_decompress };</span><br><span> #endif /* ENABLE_LZO */</span><br><=
/pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2143?usp=3Demail">change 2143</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2143?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I7c9e123a458b9d3757e9de93f401e4e421741675=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2143 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>

</body></html>
--pgg18m8sVO8=--


--===============8047152989938169573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8047152989938169573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8047152989938169573==--

