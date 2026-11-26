Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BEF606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F2aGWkim;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kel+3asX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Bynpz9vo;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BgIWuiZe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LncosIYtXvgxUbLNCLtxhJqSH0I1imnRis0Ir7MxIRk=; b=F2aGWkimSWPe2p+p88csaZ05NH
	Ia0iXuD26EmgJg40kSI4NM323tfhbAS0fKyJqIoln0sl1CFkOADFRzTKv1DlsFPzuMDI5+fb+rvN5
	yqSDzQ46axJLm7nlNjWTnWhUUCeGmDRMpT3ua7QHDQTB3exzORiTap+MgnFmNrxzJRKo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWW5x-000000000Q2-1tzN;
	Thu, 26 Nov 2026 09:48:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWW5v-000000000Po-3wYF
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:48:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cFohTIBjKl51UszBcetIW36geAXrGTiAx+q2Dcuu6VM=; b=kel+3asXkMvzO6BA4D4jlOAEr/
 ZjXr0VIjhu1n36pGR7DQdMQT4261ojdnI/LIixE/OHr5UqSMMhhilVy4GELK230myXVjBR7bjnjuA
 I90tDHNgjO6cqbnkGsDDCUsmLFVR5uZvGCb79GCC/dAqPlN2EhU1tOH7/TefQbTLgpAw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cFohTIBjKl51UszBcetIW36geAXrGTiAx+q2Dcuu6VM=; b=Bynpz9voNfUOeiwLKIuxTzSPoA
 z+uNNTqusFFFCT7g1pTwNQCdnvbHPXVzOqfjE4CZbB/U33wGDspSjVxkbqsUYh1xYFJVZMTj4zl0g
 7YT4gKkuP2zUCsSpFtekaj805hdBYTm5lWd9Pn8mHBBNhp9IrIb9goiEL+dmFlMkppGE=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWW5s-00000000681-1gG4 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:48:47 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so63533445e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 01:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795686518; x=1796291318; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cFohTIBjKl51UszBcetIW36geAXrGTiAx+q2Dcuu6VM=;
 b=BgIWuiZe0eLV4GXo9xaVYMOEXzidJlayjMZXOc20uwWxAfCTf7KXTq4qMoXaGyndlL
 mELBGv5ZcJRCStEsgGStq3K11rfe77aPFtfRrjiCRjaG1VD2QeSgmY0UsvWS2+qQ20fl
 enFbKuSLHgTtDd14l2m1iQhQkKuRVt9bG92Sn6GIicSYS/jOEfGjII3VZlOasbEQsHQT
 7+aaIVOdMZgYaSqLE7uTBLPOZc7mFzR0ttZHoa7+zL2Zk4GZFvxN68VDwJEVvTMp6XFU
 rTKdxiZDdVv9xB57+z+FJHrNV/EqUiwzcKJBdvZwaDLPb8e3mQYHQYYaKk3+Trj12TvD
 teIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795686518; x=1796291318;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cFohTIBjKl51UszBcetIW36geAXrGTiAx+q2Dcuu6VM=;
 b=DBI52C9bVZHTNKSAQnpazvhmuh16li8JnlEmnvxd7s9IJpYSlV1uKqwh+vNLKVpp7f
 6Hbn4prQ5WmY2t22ugyx25rLj/HyBnuKtVFJdvDeGE/1ov26zmjts1hB6QF0Snl6m4EO
 eHOVj2XuCiUVRyHxZT+HghQPQHR5SHcJP5jZFM/2kjZXZ3ha1aGVpkSW87XwSGm51kTJ
 eM8NNeBwHHuLU5bk0mMyf+q0O4k+/HywzVibbLKJLhlXukbFF22T7BgSJxYY06JAgYF1
 naqSOEyFqWQoiXl7CbBbnCp5kC8s60yaEPFm9/OtIHK1lpqhE6gGLr77XWZxrrw3gsGx
 dWyg==
X-Gm-Message-State: APuU4Z/Bu/KqE1baAioy+Fc+Oox4y9FKh0UPVd6ifq7MFwDqlIEdE5jo
 HL3khoC1WIfIMNV3N8wxOjeNLCtLDrwpss2VSa9YhXBC0sZsiAO0GXZHI4izszWV4FNQkg+BL39
 FkgllJt55ffW5bpc90Q1o3wPlmowtud4NX3ZHzkKRjmv93MHwuV4CBXzWfk/6xJoQiM0S
X-Gm-Gg: AZFdTZdiHKFZ9qN8vC41eha7uMVWzxJg1Hl29NgV32p7rIpkOTdTu5olopZnXreoEYY
 rDFynuw0L0FZUtHzRKTUqwckArHNZeZeypqTTlJbdTyL/EA3Ujfry/XiX3kJN+BalrVk33mEOc7
 6/JwfS2S10teWSyDwfYFcQtCGMegI1abTEBo599JFtKIODA1QapE49TMkx4rXDJaEPDu5pVCc4C
 uMHyaw2jALW4/BHNNyIvN4Pj8xC4jRDJMC7Qn71pOrkkL98oK0s+uMgu9N9/2qPFMR4IXsgo8jU
 v/Ity9Mm7uujKU+eewEqn7ENxUR5coldcm01SpDmdjgAnrDWb+TkAaCqZX6FUFcAHFrSk7RAk8i
 H2e4Jt/08gnNuuF6WepieeICxsG1KLS576nTYVA2iubWZLjT2xjtapWwhhQ8FQMVmKOklKuGHV7
 eU1nklz62DJMzSMcaoRQyAI6B7Tj1uISRhdBEb1Uawq5qUS1agOSDrTXjDWP9a06AI2HyXeU3RE
 hwKsMr1P/eCSiypzmM3hG7YzGA7oUFJe3/Nq2/UqmoBujDST2xTInPuSOiaX3nOGJ6GPNusUX3+
 vpST1WoYjF6ezVZ+1sJxfGu3HqeALkFjLRGl1BZK+eXnKOro137deP74akqY4pae6RJhJPGZxWs
 DslQHYCC4A6vDLWnrM72mLf+I+YJDQ85CyY3a1Nb2R8AvNlpCRet/Tlouk/Q+2W1oZyCGc31Ran
 39PNb9YilitXdAWvE=
X-Received: by 2002:a05:600c:c168:b0:4bb:81b2:c801 with SMTP id
 5b1f17b1804b1-4bb889238f1mr402970065e9.20.1795686517404; 
 Thu, 26 Nov 2026 01:48:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm582435295e9.1.2026.11.26.01.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 01:48:37 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 09:48:36 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I189f3a311719b5c4476351702a44870d485d10d8
X-Gerrit-Change-Number: 2328
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2328?usp=email>
X-Gerrit-Commit: cd485998d2357c8ce48f7a2302f82176f336510e
In-Reply-To: <gerrit.1795442905000.I189f3a311719b5c4476351702a44870d485d10d8@gerrit.openvpn.net>
References: <gerrit.1795442905000.I189f3a311719b5c4476351702a44870d485d10d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQyOTA1MDAwLkkxODlmM2EzMTE3MTliNWM0NDc2MzUxNzAyYTQ0ODcwZDQ4NWQxMGQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3fb180d4b88db622455671711da8deaa8bdfe871-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWW5s-00000000681-1gG4
Subject: [Openvpn-devel] [M] Change in openvpn[master]: comp: drop
 compression on send leftovers
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
Content-Type: multipart/mixed; boundary="===============4788710221817829668=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4788710221817829668==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yTNh9FuvScc="; charset=UTF-8

--yTNh9FuvScc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2328?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: comp: drop compressi=
on on send leftovers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

comp: drop compression on send leftovers

7f0214c9 ("Remove support=
 for compression on send") left the LZO
compression workspace, adaptive com=
pression state and related defines
behind=2E lzo1x_decompress_safe() ignore=
s its work memory argument, so
stop allocating LZO1X_1_15_MEM_COMPRESS byte=
s (256 KiB on 64-bit) per
LZO compression context and pass NULL instead=2E
=

Remove the now empty compress_workspace_union, COMPRESS_THRESHOLD and
D_CO=
MP_LOW, probe for lzo1x_decompress_safe() instead of the unused
compressor =
in configure, and update the compression module docs=2E

Change-Id: I189f3a=
311719b5c4476351702a44870d485d10d8
Signed-off-by: Razvan Cojocaru <razvanc@=
mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2328
Message-Id: <20261123=
143201=2E4058-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg41831=2Ehtml
Signed-off-by: =
Gert Doering <gert@greenie=2Emuc=2Ede>
---
M configure=2Eac
M doc/doxygen/d=
oc_compression=2Eh
M src/openvpn/comp-lz4=2Eh
M src/openvpn/comp=2Eh
M src/=
openvpn/errlevel=2Eh
M src/openvpn/lzo=2Ec
M src/openvpn/lzo=2Eh
7 files ch=
anged, 29 insertions(+), 127 deletions(-)


  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/28/2328/2

diff --git a/configure=2Eac =
b/configure=2Eac
index 585c3bd=2E=2E05fa964 100644
--- a/configure=2Eac
+++=
 b/configure=2Eac
@@ -1001,11 +1001,11 @@
 	have_lzo=3D"yes"
 	AC_CHECK_LIB=
(
 		[lzo2],
-		[lzo1x_1_15_compress],
+		[lzo1x_decompress_safe],
 		[LZO_=
LIBS=3D"-llzo2"],
 		[AC_CHECK_LIB(
 			[lzo],
-			[lzo1x_1_15_compress],
+=
			[lzo1x_decompress_safe],
 			[LZO_LIBS=3D"-llzo"],
 			[have_lzo=3D"no"]=

 		)]
diff --git a/doc/doxygen/doc_compression=2Eh b/doc/doxygen/doc_compr=
ession=2Eh
index efd18bf=2E=2E4c60e74 100644
--- a/doc/doxygen/doc_compress=
ion=2Eh
+++ b/doc/doxygen/doc_compression=2Eh
@@ -29,31 +29,21 @@
 /**
  * =
@defgroup compression Data Channel Compression module
  *
- * This module o=
ffers compression of data channel packets=2E
+ * This module decompresses i=
ncoming data channel packets and adds
+ * compression framing to outgoing o=
nes=2E
  *
  * @par State structures
  * The Data Channel Compression modul=
e stores its internal state in a \c
- * lzo_compress_workspace structure=2E=
  This state includes flags which
- * control the module's behavior and pre=
allocated working memory=2E  One
- * such structure is present for each VPN=
 tunnel, and is stored in the \c
- * context=2Ec2=2Elzo_compwork of the \c =
context associated with that VPN
- * tunnel=2E
+ * compress_context structu=
re=2E  One such structure is present for each VPN
+ * tunnel, and is stored=
 in the \c context=2Ec2=2Ecomp_context of the \c
+ * context associated wit=
h that VPN tunnel=2E
  *
  * @par Initialization and cleanup
- * Every time=
 a new \c lzo_compress_workspace is needed, it must be
- * initialized usin=
g the \c lzo_compress_init() function=2E  Similarly,
- * every time a \c lz=
o_compress_workspace is no longer needed, it must be
- * cleaned up using t=
he \c lzo_compress_uninit() function=2E  These
- * functions take care of t=
he allocation and freeing of internal working
- * memory, but not of the \c=
 lzo_compress_workspace structures themselves=2E
- *
- * @par
- * Because o=
f the one-to-one relationship between \c
- * lzo_compress_workspace structu=
res and VPN tunnels, the above-mentioned
- * initialization and cleanup fun=
ctions are called directly from the \c
- * init_instance() and \c close_ins=
tance() functions, which control the
- * initialization and cleanup of VPN =
tunnel instances and their associated
- * \c context structures=2E
+ * \c c=
omp_init() allocates a \c compress_context and calls the \c
+ * compress_in=
it method of its \c compress_alg; \c comp_uninit() calls
+ * the \c compres=
s_uninit method and frees the structure=2E  Both are called
+ * from \c ini=
t_instance() and \c close_instance(), and when pushed
+ * options change=2E=

  *
  * @par Packet processing functions
  * This module receives data cha=
nnel packets from the \link data_control
@@ -67,25 +57,25 @@
  *
  * @par S=
ettings that control this module's activity
  * Whether or not the Data Cha=
nnel Compression module is active depends on
- * the compile-time \c ENABLE=
_LZO preprocessor macro and the runtime flags
- * stored in \c lzo_compress=
_workspace=2Eflags of the associated VPN tunnel=2E
- * The latter are initi=
alized from \c options=2Elzo, which gets its value
- * from the process's c=
onfiguration sources, such as its configuration
- * file or command line %o=
ptions=2E
+ * the compile-time \c USE_COMP preprocessor macro and on \c
+ *=
 options=2Ecomp=2Ealg, which gets its value from the process's configuratio=
n
+ * sources, such as its configuration file or command line %options=2E
+=
 * \c comp_init() creates no \c compress_context if no algorithm is set=2E
=
+ * The flags in \c compress_context=2Eflags, copied from \c
+ * options=2E=
comp=2Eflags, only adjust framing, option checks and which
+ * algorithms a=
re advertised to the peer=2E
  *
- * @par Adaptive compression
- * The comp=
ression module supports adaptive compression=2E  If this feature
- * is ena=
bled, the compression routines monitor their own performance and
- * turn c=
ompression on or off depending on whether it is leading to
- * significantl=
y reduced payload size=2E
+ * @par Outgoing packets
+ * Outgoing packets ar=
e never compressed, only framed so that the peer
+ * can parse them=2E
  *
=
  * @par Compression algorithms
- * This module uses the Lempel-Ziv-Oberhum=
er (LZO) compression algorithms=2E
- * These offer lossless compression and=
 are designed for high-performance
- * decompression=2E  This module uses t=
he external \c lzo library's
- * implementation of the algorithms=2E
+ * Th=
is module supports the Lempel-Ziv-Oberhumer (LZO) and LZ4
+ * algorithms, a=
s implemented by the external \c lzo and \c lz4
+ * libraries=2E
  *
  * @p=
ar
- * For more information on the LZO library, see:\n
- * https://www=2Eob=
erhumer=2Ecom/opensource/lzo/
+ * For more information on these libraries, =
see:\n
+ * https://www=2Eoberhumer=2Ecom/opensource/lzo/ \n
+ * https://lz4=
=2Eorg/
  */
diff --git a/src/openvpn/comp-lz4=2Eh b/src/openvpn/comp-lz4=
=2Eh
index 3d04771=2E=2E10dbe59 100644
--- a/src/openvpn/comp-lz4=2Eh
+++ b=
/src/openvpn/comp-lz4=2Eh
@@ -31,10 +31,5 @@
 extern const struct compress_=
alg lz4_alg;
 extern const struct compress_alg lz4v2_alg;
 
-struct lz4_wor=
kspace
-{
-    int dummy;
-};
-
 #endif /* ENABLE_LZ4 */
 #endif
diff --git=
 a/src/openvpn/comp=2Eh b/src/openvpn/comp=2Eh
index 3f6411b=2E=2E4abf870 1=
00644
--- a/src/openvpn/comp=2Eh
+++ b/src/openvpn/comp=2Eh
@@ -132,11 +132=
,6 @@
  */
 #define COMP_EXTRA_BUFFER(len) ((len) / 6 + 128 + 3 + COMP_PREF=
IX_LEN)
 
-/*
- * Don't try to compress any packet smaller than this=2E
- *=
/
-#define COMPRESS_THRESHOLD 100
-
 /* Forward declaration of compression =
context */
 struct compress_context;
 
@@ -167,26 +162,12 @@
 #endif
 
 /*
=
- * Workspace union of all supported compression algorithms
- */
-union com=
press_workspace_union
-{
-#ifdef ENABLE_LZO
-    struct lzo_compress_worksp=
ace lzo;
-#endif
-#ifdef ENABLE_LZ4
-    struct lz4_workspace lz4;
-#endif
=
-};
-
-/*
  * Context for active compression session
  */
 struct compress_=
context
 {
     unsigned int flags;
     struct compress_alg alg;
-    unio=
n compress_workspace_union wu;
 
     /* statistics */
     counter_type pr=
e_decompress;
diff --git a/src/openvpn/errlevel=2Eh b/src/openvpn/errlevel=
=2Eh
index 5cea0ad=2E=2E62ec731 100644
--- a/src/openvpn/errlevel=2Eh
+++ b=
/src/openvpn/errlevel=2Eh
@@ -123,7 +123,6 @@
 #define D_MTU_DEBUG        L=
OGLEV(7, 70, M_DEBUG)  /* show MTU debugging info */
 #define D_MULTI_DEBUG=
      LOGLEV(7, 70, M_DEBUG)  /* show medium-freq multi debugging info */
 =
#define D_MSS              LOGLEV(7, 70, M_DEBUG)  /* show MSS adjustments =
*/
-#define D_COMP_LOW         LOGLEV(7, 70, M_DEBUG)  /* show adaptive com=
pression state changes */
 #define D_CONNECTION_LIST  LOGLEV(7, 70, M_DEBUG=
)  /* show <connection> list info */
 #define D_SCRIPT           LOGLEV(7, =
70, M_DEBUG)  /* show parms & env vars passed to scripts */
 #define D_SHOW=
_NET         LOGLEV(7, 70, M_DEBUG)  /* show routing table and adapter list=
 */
diff --git a/src/openvpn/lzo=2Ec b/src/openvpn/lzo=2Ec
index 207cea6=2E=
=2Ef5ae776 100644
--- a/src/openvpn/lzo=2Ec
+++ b/src/openvpn/lzo=2Ec
@@ -3=
5,7 +35,6 @@
 
 #include "comp=2Eh"
 #include "error=2Eh"
-#include "otime=
=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -50,7 +49,6 @@
 {
     msg(D_INIT_MEDIU=
M, "LZO compression initializing");
     ASSERT(!(compctx->flags & COMP_F_S=
WAP));
-    compctx->wu=2Elzo=2Ewmem_size =3D LZO_WORKSPACE;
 
     int lzo=
_status =3D lzo_init();
     if (lzo_status !=3D LZO_E_OK)
@@ -58,15 +56,11=
 @@
         msg(M_FATAL, "Cannot initialize LZO compression library (lzo_i=
nit() returns %d)",
             lzo_status);
     }
-    compctx->wu=2Elzo=
=2Ewmem =3D (lzo_voidp)malloc(compctx->wu=2Elzo=2Ewmem_size);
-    check_ma=
lloc_return(compctx->wu=2Elzo=2Ewmem);
 }
 
 static void
 lzo_compress_unin=
it(struct compress_context *compctx)
 {
-    free(compctx->wu=2Elzo=2Ewmem)=
;
-    compctx->wu=2Elzo=2Ewmem =3D NULL;
 }
 
 static void
@@ -89,7 +83,7 =
@@
     if (c =3D=3D LZO_COMPRESS_BYTE) /* packet was compressed */
     {
=
         ASSERT(buf_safe(&work, zlen));
-        int err =3D LZO_DECOMPRESS=
(BPTR(buf), BLENZ(buf), BPTR(&work), &zlen, compctx->wu=2Elzo=2Ewmem);
+   =
     int err =3D LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), BPTR(&work), &zlen, =
NULL);
         if (err !=3D LZO_E_OK)
         {
             dmsg(D_COMP_=
ERRORS, "LZO decompression error: %d", err);
diff --git a/src/openvpn/lzo=
=2Eh b/src/openvpn/lzo=2Eh
index bb9cc81=2E=2E3a8586c 100644
--- a/src/open=
vpn/lzo=2Eh
+++ b/src/openvpn/lzo=2Eh
@@ -57,17 +57,6 @@
 
 /**************=
************************************************************/
 /** @name LZ=
O library interface defines */ /** @{ */ /***********************/
-#define=
 LZO_COMPRESS   lzo1x_1_15_compress
-/**< LZO library compression function=
=2E
- *
- *   Use \c lzo1x_1_15_compress because it
- *   is described as f=
aster than the
- *   standard routine, although it does
- *   need a bit mo=
re memory=2E */
-#define LZO_WORKSPACE  LZO1X_1_15_MEM_COMPRESS
-/**< The s=
ize in bytes of the memory
- *   %buffer required by the LZO library
- *   =
compression algorithm=2E */
 #define LZO_DECOMPRESS lzo1x_decompress_safe
 =
/**< LZO library decompression function=2E
  *
@@ -80,52 +69,6 @@
  *   usi=
ng the non-safe version=2E */
 /** @} name LZO library interface */ /******=
********************************/
 
-
-/***********************************=
***************************************/
-/** @name Adaptive compression de=
fines */ /** @{ */ /************************/
-#define AC_SAMP_SEC 2       =
                        /**< Number of seconds in a sample period=2E */
-#d=
efine AC_MIN_BYTES                                                         =
             \
-    1000                                            /**< Mi=
nimum number of bytes a sample \
-                                         =
            *   period must contain for it to be \
-                       =
                              *   evaluated=2E */
-#define AC_SAVE_PCT     =
                                                                   \
-    5=
                                               /**< Minimum size reduction =
percentage \
-                                                     *   belo=
w which compression will be   \
-                                          =
           *   turned off=2E */
-#define AC_OFF_SEC                        =
                                                     \
-    60             =
                                 /**< Seconds to wait after compression has=
 \
-                                                     *   been turned of=
f before retesting=2E */
-/** @} name Adaptive compression defines */      =
   /*******************************/
-
-/**
- * Adaptive compression state=
=2E
- */
-struct lzo_adaptive_compress
-{
-    bool compress_state;
-    ti=
me_t next;
-    int n_total;
-    int n_comp;
-};
-
-
-/**
- * State for th=
e compression and decompression routines=2E
- *
- * This structure contains=
 compression module state, such as whether
- * compression is enabled and t=
he status of the adaptive compression
- * routines=2E  It also contains an =
allocated working buffer=2E
- *
- * One of these compression workspace stru=
ctures is maintained for each
- * VPN tunnel=2E
- */
-struct lzo_compress_w=
orkspace
-{
-    lzo_voidp wmem;
-    int wmem_size;
-    struct lzo_adapti=
ve_compress ac;
-};
-
 /** @} addtogroup compression */
 
 

-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2328?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I189f3a311719b5c4476351702a448=
70d485d10d8
Gerrit-Change-Number: 2328
Gerrit-PatchSet: 2
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--yTNh9FuvScc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2328?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">comp: drop compression on send leftovers<br><br>7f0214c9 (&quot;Remove =
support for compression on send&quot;) left the LZO<br>compression workspac=
e, adaptive compression state and related defines<br>behind=2E lzo1x_decomp=
ress_safe() ignores its work memory argument, so<br>stop allocating LZO1X_1=
_15_MEM_COMPRESS bytes (256 KiB on 64-bit) per<br>LZO compression context a=
nd pass NULL instead=2E<br><br>Remove the now empty compress_workspace_unio=
n, COMPRESS_THRESHOLD and<br>D_COMP_LOW, probe for lzo1x_decompress_safe() =
instead of the unused<br>compressor in configure, and update the compressio=
n module docs=2E<br><br>Change-Id: I189f3a311719b5c4476351702a44870d485d10d=
8<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-=
by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2328<br>Message-Id: &lt;20261123143201=
=2E4058-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg41831=2Ehtml<br>Signed-off-b=
y: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M configure=2Eac<=
br>M doc/doxygen/doc_compression=2Eh<br>M src/openvpn/comp-lz4=2Eh<br>M src=
/openvpn/comp=2Eh<br>M src/openvpn/errlevel=2Eh<br>M src/openvpn/lzo=2Ec<br=
>M src/openvpn/lzo=2Eh<br>7 files changed, 29 insertions(+), 127 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/28/2328/2</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/configure=2Eac b/configu=
re=2Eac</span><br><span>index 585c3bd=2E=2E05fa964 100644</span><br><span>-=
-- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@=
 -1001,11 +1001,11 @@</span><br><span> 	have_lzo=3D&quot;yes&quot;</span><b=
r><span> 	AC_CHECK_LIB(</span><br><span> 		[lzo2],</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-		[lzo1x_1_15_compress],</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+		[lzo1x_decompress_safe],</span><br><spa=
n> 		[LZO_LIBS=3D&quot;-llzo2&quot;],</span><br><span> 		[AC_CHECK_LIB(</sp=
an><br><span> 			[lzo],</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-			[lzo1x_1_15_compress],</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+			[lzo1x_decompress_safe],</span><br><span> 			[LZO_LIBS=3D&quot;-=
llzo&quot;],</span><br><span> 			[have_lzo=3D&quot;no&quot;]</span><br><spa=
n> 		)]</span><br><span>diff --git a/doc/doxygen/doc_compression=2Eh b/doc/=
doxygen/doc_compression=2Eh</span><br><span>index efd18bf=2E=2E4c60e74 1006=
44</span><br><span>--- a/doc/doxygen/doc_compression=2Eh</span><br><span>++=
+ b/doc/doxygen/doc_compression=2Eh</span><br><span>@@ -29,31 +29,21 @@</sp=
an><br><span> /**</span><br><span>  * @defgroup compression Data Channel Co=
mpression module</span><br><span>  *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * This module offers compression of data channel packets=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This module deco=
mpresses incoming data channel packets and adds</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * compression framing to outgoing ones=2E</spa=
n><br><span>  *</span><br><span>  * @par State structures</span><br><span> =
 * The Data Channel Compression module stores its internal state in a \c</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * lzo_compress_workspac=
e structure=2E  This state includes flags which</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * control the module&#39;s behavior and prealloc=
ated working memory=2E  One</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * such structure is present for each VPN tunnel, and is stored in th=
e \c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * context=2Ec2=
=2Elzo_compwork of the \c context associated with that VPN</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * tunnel=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * compress_context structure=2E  One such st=
ructure is present for each VPN</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * tunnel, and is stored in the \c context=2Ec2=2Ecomp_context =
of the \c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * context=
 associated with that VPN tunnel=2E</span><br><span>  *</span><br><span>  *=
 @par Initialization and cleanup</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * Every time a new \c lzo_compress_workspace is needed, it must=
 be</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * initialized usi=
ng the \c lzo_compress_init() function=2E  Similarly,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * every time a \c lzo_compress_workspace i=
s no longer needed, it must be</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * cleaned up using the \c lzo_compress_uninit() function=2E  Thes=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * functions take ca=
re of the allocation and freeing of internal working</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * memory, but not of the \c lzo_compress_w=
orkspace structures themselves=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @par=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Because of the one=
-to-one relationship between \c</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * lzo_compress_workspace structures and VPN tunnels, the above-m=
entioned</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * initializa=
tion and cleanup functions are called directly from the \c</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * init_instance() and \c close_instan=
ce() functions, which control the</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * initialization and cleanup of VPN tunnel instances and their=
 associated</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * \c cont=
ext structures=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 \c comp_init() allocates a \c compress_context and calls the \c</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * compress_init method of its=
 \c compress_alg; \c comp_uninit() calls</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * the \c compress_uninit method and frees the structu=
re=2E  Both are called</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * from \c init_instance() and \c close_instance(), and when pushed</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * options change=2E</sp=
an><br><span>  *</span><br><span>  * @par Packet processing functions</span=
><br><span>  * This module receives data channel packets from the \link dat=
a_control</span><br><span>@@ -67,25 +57,25 @@</span><br><span>  *</span><br=
><span>  * @par Settings that control this module&#39;s activity</span><br>=
<span>  * Whether or not the Data Channel Compression module is active depe=
nds on</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the compile-=
time \c ENABLE_LZO preprocessor macro and the runtime flags</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * stored in \c lzo_compress_workspac=
e=2Eflags of the associated VPN tunnel=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * The latter are initialized from \c options=2Elzo, wh=
ich gets its value</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
from the process&#39;s configuration sources, such as its configuration</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * file or command line %=
options=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the co=
mpile-time \c USE_COMP preprocessor macro and on \c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * options=2Ecomp=2Ealg, which gets its v=
alue from the process&#39;s configuration</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * sources, such as its configuration file or command=
 line %options=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 \c comp_init() creates no \c compress_context if no algorithm is set=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The flags in \c com=
press_context=2Eflags, copied from \c</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * options=2Ecomp=2Eflags, only adjust framing, option ch=
ecks and which</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * al=
gorithms are advertised to the peer=2E</span><br><span>  *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * @par Adaptive compression</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * The compression module suppo=
rts adaptive compression=2E  If this feature</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * is enabled, the compression routines monitor thei=
r own performance and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * turn compression on or off depending on whether it is leading to</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * significantly reduced payl=
oad size=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par =
Outgoing packets</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Outgoing packets are never compressed, only framed so that the peer</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * can parse them=2E</span>=
<br><span>  *</span><br><span>  * @par Compression algorithms</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * This module uses the Lempel-Ziv-=
Oberhumer (LZO) compression algorithms=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * These offer lossless compression and are designed fo=
r high-performance</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
decompression=2E  This module uses the external \c lzo library&#39;s</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * implementation of the alg=
orithms=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This m=
odule supports the Lempel-Ziv-Oberhumer (LZO) and LZ4</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * algorithms, as implemented by the exte=
rnal \c lzo and \c lz4</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * libraries=2E</span><br><span>  *</span><br><span>  * @par</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * For more information on the LZ=
O library, see:\n</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * h=
ttps://www=2Eoberhumer=2Ecom/opensource/lzo/</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * For more information on these libraries, see:\n=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * https://www=2Eob=
erhumer=2Ecom/opensource/lzo/ \n</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * https://lz4=2Eorg/</span><br><span>  */</span><br><span>dif=
f --git a/src/openvpn/comp-lz4=2Eh b/src/openvpn/comp-lz4=2Eh</span><br><sp=
an>index 3d04771=2E=2E10dbe59 100644</span><br><span>--- a/src/openvpn/comp=
-lz4=2Eh</span><br><span>+++ b/src/openvpn/comp-lz4=2Eh</span><br><span>@@ =
-31,10 +31,5 @@</span><br><span> extern const struct compress_alg lz4_alg;<=
/span><br><span> extern const struct compress_alg lz4v2_alg;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct lz4_workspa=
ce</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int dummy;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> #endif /* ENABLE_LZ4 */</span><br><span> #endif=
</span><br><span>diff --git a/src/openvpn/comp=2Eh b/src/openvpn/comp=2Eh</=
span><br><span>index 3f6411b=2E=2E4abf870 100644</span><br><span>--- a/src/=
openvpn/comp=2Eh</span><br><span>+++ b/src/openvpn/comp=2Eh</span><br><span=
>@@ -132,11 +132,6 @@</span><br><span>  */</span><br><span> #define COMP_EX=
TRA_BUFFER(len) ((len) / 6 + 128 + 3 + COMP_PREFIX_LEN)</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * Don&#39;t try to compress any packet sm=
aller than this=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define COMPRESS_THRE=
SHOLD 100</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> /* Forward declaration of compression context */</span><br><span> str=
uct compress_context;</span><br><span> </span><br><span>@@ -167,26 +162,12 =
@@</span><br><span> #endif</span><br><span> </span><br><span> /*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * Workspace union of all suppor=
ted compression algorithms</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-union compres=
s_workspace_union</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_LZO</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct lzo_compress_work=
space lzo;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_LZ4</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct lz4_workspace lz4;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*=
</span><br><span>  * Context for active compression session</span><br><span=
>  */</span><br><span> struct compress_context</span><br><span> {</span><br=
><span>     unsigned int flags;</span><br><span>     struct compress_alg al=
g;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    union compress_=
workspace_union wu;</span><br><span> </span><br><span>     /* statistics */=
</span><br><span>     counter_type pre_decompress;</span><br><span>diff --g=
it a/src/openvpn/errlevel=2Eh b/src/openvpn/errlevel=2Eh</span><br><span>in=
dex 5cea0ad=2E=2E62ec731 100644</span><br><span>--- a/src/openvpn/errlevel=
=2Eh</span><br><span>+++ b/src/openvpn/errlevel=2Eh</span><br><span>@@ -123=
,7 +123,6 @@</span><br><span> #define D_MTU_DEBUG        LOGLEV(7, 70, M_DE=
BUG)  /* show MTU debugging info */</span><br><span> #define D_MULTI_DEBUG =
     LOGLEV(7, 70, M_DEBUG)  /* show medium-freq multi debugging info */</s=
pan><br><span> #define D_MSS              LOGLEV(7, 70, M_DEBUG)  /* show M=
SS adjustments */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine D_COMP_LOW         LOGLEV(7, 70, M_DEBUG)  /* show adaptive compression=
 state changes */</span><br><span> #define D_CONNECTION_LIST  LOGLEV(7, 70,=
 M_DEBUG)  /* show &lt;connection&gt; list info */</span><br><span> #define=
 D_SCRIPT           LOGLEV(7, 70, M_DEBUG)  /* show parms &amp; env vars pa=
ssed to scripts */</span><br><span> #define D_SHOW_NET         LOGLEV(7, 70=
, M_DEBUG)  /* show routing table and adapter list */</span><br><span>diff =
--git a/src/openvpn/lzo=2Ec b/src/openvpn/lzo=2Ec</span><br><span>index 207=
cea6=2E=2Ef5ae776 100644</span><br><span>--- a/src/openvpn/lzo=2Ec</span><b=
r><span>+++ b/src/openvpn/lzo=2Ec</span><br><span>@@ -35,7 +35,6 @@</span><=
br><span> </span><br><span> #include &quot;comp=2Eh&quot;</span><br><span> =
#include &quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#include &quot;otime=2Eh&quot;</span><br><span> </span><br><span> =
#include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>@@ -50,7 =
+49,6 @@</span><br><span> {</span><br><span>     msg(D_INIT_MEDIUM, &quot;L=
ZO compression initializing&quot;);</span><br><span>     ASSERT(!(compctx-&=
gt;flags &amp; COMP_F_SWAP));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    compctx-&gt;wu=2Elzo=2Ewmem_size =3D LZO_WORKSPACE;</span><br><=
span> </span><br><span>     int lzo_status =3D lzo_init();</span><br><span>=
     if (lzo_status !=3D LZO_E_OK)</span><br><span>@@ -58,15 +56,11 @@</spa=
n><br><span>         msg(M_FATAL, &quot;Cannot initialize LZO compression l=
ibrary (lzo_init() returns %d)&quot;,</span><br><span>             lzo_stat=
us);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    compctx-&gt;wu=2Elzo=2Ewmem =3D (lzo_voidp)malloc(compctx-&gt;wu=
=2Elzo=2Ewmem_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   check_malloc_return(compctx-&gt;wu=2Elzo=2Ewmem);</span><br><span> }</sp=
an><br><span> </span><br><span> static void</span><br><span> lzo_compress_u=
ninit(struct compress_context *compctx)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    free(compctx-&gt;wu=2Elzo=2Ewmem);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    compctx-&gt;wu=2E=
lzo=2Ewmem =3D NULL;</span><br><span> }</span><br><span> </span><br><span> =
static void</span><br><span>@@ -89,7 +83,7 @@</span><br><span>     if (c =
=3D=3D LZO_COMPRESS_BYTE) /* packet was compressed */</span><br><span>     =
{</span><br><span>         ASSERT(buf_safe(&amp;work, zlen));</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        int err =3D LZO_DECOMPRESS(=
BPTR(buf), BLENZ(buf), BPTR(&amp;work), &amp;zlen, compctx-&gt;wu=2Elzo=2Ew=
mem);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int er=
r =3D LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), BPTR(&amp;work), &amp;zlen, NUL=
L);</span><br><span>         if (err !=3D LZO_E_OK)</span><br><span>       =
  {</span><br><span>             dmsg(D_COMP_ERRORS, &quot;LZO decompressio=
n error: %d&quot;, err);</span><br><span>diff --git a/src/openvpn/lzo=2Eh b=
/src/openvpn/lzo=2Eh</span><br><span>index bb9cc81=2E=2E3a8586c 100644</spa=
n><br><span>--- a/src/openvpn/lzo=2Eh</span><br><span>+++ b/src/openvpn/lzo=
=2Eh</span><br><span>@@ -57,17 +57,6 @@</span><br><span> </span><br><span> =
/**************************************************************************=
/</span><br><span> /** @name LZO library interface defines */ /** @{ */ /**=
*********************/</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define LZO_COMPRESS   lzo1x_1_15_compress</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/**&lt; LZO library compression function=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *   Use \c lzo1x_1_15_compress because it</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *   is described as faster t=
han the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   standard =
routine, although it does</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *   need a bit more memory=2E */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define LZO_WORKSPACE  LZO1X_1_15_MEM_COMPRESS</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-/**&lt; The size in bytes of the m=
emory</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   %buffer req=
uired by the LZO library</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *   compression algorithm=2E */</span><br><span> #define LZO_DECOMPRESS=
 lzo1x_decompress_safe</span><br><span> /**&lt; LZO library decompression f=
unction=2E</span><br><span>  *</span><br><span>@@ -80,52 +69,6 @@</span><br=
><span>  *   using the non-safe version=2E */</span><br><span> /** @} name =
LZO library interface */ /**************************************/</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-/*********************************=
*****************************************/</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-/** @name Adaptive compression defines */ /** @{ */ /*=
***********************/</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define AC_SAMP_SEC 2                               /**&lt; Number of se=
conds in a sample period=2E */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define AC_MIN_BYTES                                              =
                        \</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    1000                                            /**&lt; Minimum num=
ber of bytes a sample \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                                     *   period must cont=
ain for it to be \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                                                  *   evaluated=2E */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define AC_SAVE_PCT        =
                                                                \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    5                          =
                     /**&lt; Minimum size reduction percentage \</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
                     *   below which compression will be   \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                    =
                 *   turned off=2E */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define AC_OFF_SEC                                         =
                                    \</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    60                                              /**&lt;=
 Seconds to wait after compression has \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                                     *  =
 been turned off before retesting=2E */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/** @} name Adaptive compression defines */         /****=
***************************/</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * Adaptive compression state=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-struct lzo_adaptive_compress</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    bool compress_state;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    time_t next;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int n_total;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    int n_comp;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * State for the compression and decompression routines=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * This structure contains compression module state=
, such as whether</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * c=
ompression is enabled and the status of the adaptive compression</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * routines=2E  It also contains=
 an allocated working buffer=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * One of=
 these compression workspace structures is maintained for each</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * VPN tunnel=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-struct lzo_compress_workspace</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    lzo_voidp wmem;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int wmem_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct lzo_adaptive_compress ac;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> /** @} addtogroup compression */</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2328?usp=3Dema=
il">change 2328</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2328?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I189f3a311719b5c4476351702a44870d485d10d8 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2328 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--yTNh9FuvScc=--


--===============4788710221817829668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4788710221817829668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4788710221817829668==--

