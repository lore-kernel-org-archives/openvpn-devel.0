Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AE9606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l7uAIFMP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z5EsaKVN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=m+1q0G9s;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JLTaGiw5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=ZXhwNmgxGaqgh64Fyb+3d54pY2odOZ3v1SBF01bIZZs=; b=l7uAIFMP7mXO/+pEe9ihD++Zvo
	0YQ1Hhxogwvr+Cso80EYSuCu4ASVKR1SFXmtwwGGKWXRk261Q4BD6sv7KYj4NsJoLGAHKubI/ghtD
	CkXfo0SmKpNxJCSmkD7o1PkhgvBnBUGZusNprR9StbogpcKSw97SwCRH2U1fIc+iBenw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVUil-000000004Ey-3aoV;
	Mon, 23 Nov 2026 14:08:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVUik-000000004Es-0Dnw
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:08:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UKxcdNxpJ6qfvJ6mYXd2TQFMTw36M2GmAGF2UBQQIfY=; b=Z5EsaKVNZGDlzMjBb79hHyOwiU
 Qmi8ygCSui9ErFGB485111KOPOCFPkCaV1bRrBkSR2o+nhYGTtJR3nHgVh1XrzWPVTP5DGS4aaGvt
 z3g1YH5wKnQ8mYsf0i96LQDY5d+pgSQqw3C/+C55Kg5RaKIMGtugKq0T9rk7Qg/GriZw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UKxcdNxpJ6qfvJ6mYXd2TQFMTw36M2GmAGF2UBQQIfY=; b=m+1q0G9sfgm/zU7NPpOgPDj1JX
 0S5OpNdJAuKgfkham382zUQ+9kQfdTgiqbcp0UO+XWct1zAyWkCqJdz1fLe6CL1zqrqRpCo3J3M5j
 MRpwll4ToML2iDMQNgJKGSrB0P7jREIxilYFuvckxz3KUIcrzLlXSKpKbqXdyfOm77iw=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVUih-000000003s3-0Sif for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:08:37 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso26147235e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 06:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795442908; x=1796047708; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UKxcdNxpJ6qfvJ6mYXd2TQFMTw36M2GmAGF2UBQQIfY=;
 b=JLTaGiw5lVdaXutsQXDe70Plenlfx3SLupfEiiK5HKuYea6xvY3btvx5lIei4z5yPV
 33OKKoqPRuduClCJsxB0Fnv+/bNT9LfyH37AMXzDekKR2CEegeUeei4RCC7PjcFm2pn7
 kxUS5Kq3FvQbN/C1wLR5GywOuQiIOgzF+3AetLtpsdghY3boNMirumJLUBRwDrYvqKAW
 60w2Dh7zu21v5buLWtXrtYcgkXzbDzzwoSRDRID99O8IVBRa9rlOsVi84OxzxBC2mVM8
 ghqH1PR0ZonNYs9O3gSvAl4yVkPd0AngeAddohd7eTPhIO8f6r3aRewDikc0qdRfjWNm
 F0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795442908; x=1796047708;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UKxcdNxpJ6qfvJ6mYXd2TQFMTw36M2GmAGF2UBQQIfY=;
 b=FPqtD0VcqgbKFrd1HDyVeVfwq5HCl/C8gBMbkxsqLbrhfRK/AoMIiDa0wVBg3hTwVj
 v3NWEfHOLSmuq97JffomD1emazChdyfYJOnM0BsB7VFHFwgu6El7R+cUDZnyRr5O9CGU
 F2AikiqKzcd/p7rAKmlCdPuDNZ2coR6ot4bHQnNK3HD1tTDfF+YZK27CEapqJJG3Kvgc
 CDwQnh34upuP56t4wCG8zha/MjvsrqsDrAoTW1MptISid71zaIVqonDZx8oNwiVPLgwa
 EbxU/Z5hpqTt+eQO5roSt4pmOUAGY5I0L70H7UW1NZ1kFMqYrySpiPCGIZFRN1+OI1n6
 vQ/w==
X-Gm-Message-State: APuU4Z+L5KkdqcyFQuE/pGCkcB70im7jjyBu83vgVgGh/cAIplLdVNXV
 0ou4Q1GChlFbf4aMBq4o4fwMB3qSAsIQvLVAHp4bAwN2cFIF8QHHywh154eom7wFzFIczp4TDMg
 QoTiC36kX0Lq0+dmf0biyV6xG0BtbgUXTY/aEnYJLRKZnyLflRtMExqhIigD+OeaIzXm6nCCGO5
 9VyV7ehg==
X-Gm-Gg: AZFdTZfRL84NFeQSSjlhNte0ixIQ2AD02pJ2WAtKeanbHwgE0pLGXVSRHMECEJ4Ny90
 EjBV5COahlrhh9K9qxG8ra4OjmxTuLd0yW31L2j74g2EypNNVXD7ESgthWBTaeWCC3o+L9vjJUG
 ZOf4UOKN/EGuxnGDncZpHaFbYk0mFBB76Wu8rktL632L11hDgVuOanRpAZx47HSJqC6muRgXc+8
 niWwMH3SYDyE8eA2/Xw4xeM7M6JW785rGkty32c6roYIlBdCc3gjdBVR7WdA8x4pwe8TzFDgyTL
 BsFclcZNTOq2jX5KYUkFNNAZnGRbmfdWBSWQY7YoeyWTvpuAGgjmzI+70j2yTT5+iKXuktfdg6k
 5cYyiGjh5IN5taHuombM0IgQ+sF0qI29hWc3nRJ3bmDC80Lw7sO3ceD92sMkemAsyTbSNVkYcA1
 8HYRsp+aujQxHGM9SGqC0uFpqnpZIQN71ktukjXluldRRM8lMLBqLpMi7fV4mWhfpZWot6sVwHk
 rCthD+4UmhIUvONsVuDg1WqW4ebHcJzepqrUJ2NFGJ2mVo8nri01uGLK97x8BOjzvmGIQqdMzv+
 hdYyaq2t8lfQvnnhBCf7BnegF/e+82CBUf5rMhhT5y+7nhei05OHX0m+IkgWg83SqjJQFS52inG
 CPjRjNKcNJ1vfhefNIvUbGZja/S0SrIx6tKPkelQYslLn1LYhTBHaRpwrfk7mUuXuIrjSNPrFAk
 XjkFBIwwHEoVYrDqU=
X-Received: by 2002:a05:600c:4e0d:b0:4bb:69b2:d3b3 with SMTP id
 5b1f17b1804b1-4bb8881eea5mr247904885e9.27.1795442908107; 
 Mon, 23 Nov 2026 06:08:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm315927285e9.12.2026.11.23.06.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 06:08:27 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 14:08:27 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I189f3a311719b5c4476351702a44870d485d10d8
X-Gerrit-Change-Number: 2328
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2328?usp=email>
X-Gerrit-Commit: 1d2b577cca721d4e3ef5d17bc56f51f7935d73f2
References: <gerrit.1795442905000.I189f3a311719b5c4476351702a44870d485d10d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQyOTA1MDAwLkkxODlmM2EzMTE3MTliNWM0NDc2MzUxNzAyYTQ0ODcwZDQ4NWQxMGQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <40f8dd2d6a49de630ef086d463b8d8b777d322d8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVUih-000000003s3-0Sif
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1784946376156183576=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1784946376156183576==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NptgXeSWcbY="; charset=UTF-8

--NptgXeSWcbY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2328?usp=3Demail

to review the following change=2E
=


Change subject: comp: drop compression on send leftovers
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

comp: drop compression on se=
nd leftovers

7f0214c9 ("Remove support for compression on send") left the =
LZO
compression workspace, adaptive compression state and related defines
b=
ehind=2E lzo1x_decompress_safe() ignores its work memory argument, so
stop =
allocating LZO1X_1_15_MEM_COMPRESS bytes (256 KiB on 64-bit) per
LZO compre=
ssion context and pass NULL instead=2E

Remove the now empty compress_works=
pace_union, COMPRESS_THRESHOLD and
D_COMP_LOW, probe for lzo1x_decompress_s=
afe() instead of the unused
compressor in configure, and update the compres=
sion module docs=2E

Change-Id: I189f3a311719b5c4476351702a44870d485d10d8
S=
igned-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M configure=2Eac
=
M doc/doxygen/doc_compression=2Eh
M src/openvpn/comp-lz4=2Eh
M src/openvpn/=
comp=2Eh
M src/openvpn/errlevel=2Eh
M src/openvpn/lzo=2Ec
M src/openvpn/lzo=
=2Eh
7 files changed, 29 insertions(+), 127 deletions(-)



  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/2328/1

diff --git a=
/configure=2Eac b/configure=2Eac
index 585c3bd=2E=2E05fa964 100644
--- a/co=
nfigure=2Eac
+++ b/configure=2Eac
@@ -1001,11 +1001,11 @@
 	have_lzo=3D"yes=
"
 	AC_CHECK_LIB(
 		[lzo2],
-		[lzo1x_1_15_compress],
+		[lzo1x_decompress=
_safe],
 		[LZO_LIBS=3D"-llzo2"],
 		[AC_CHECK_LIB(
 			[lzo],
-			[lzo1x_1=
_15_compress],
+			[lzo1x_decompress_safe],
 			[LZO_LIBS=3D"-llzo"],
 			[=
have_lzo=3D"no"]
 		)]
diff --git a/doc/doxygen/doc_compression=2Eh b/doc/d=
oxygen/doc_compression=2Eh
index efd18bf=2E=2E4c60e74 100644
--- a/doc/doxy=
gen/doc_compression=2Eh
+++ b/doc/doxygen/doc_compression=2Eh
@@ -29,31 +29=
,21 @@
 /**
  * @defgroup compression Data Channel Compression module
  *
-=
 * This module offers compression of data channel packets=2E
+ * This modul=
e decompresses incoming data channel packets and adds
+ * compression frami=
ng to outgoing ones=2E
  *
  * @par State structures
  * The Data Channel C=
ompression module stores its internal state in a \c
- * lzo_compress_worksp=
ace structure=2E  This state includes flags which
- * control the module's =
behavior and preallocated working memory=2E  One
- * such structure is pres=
ent for each VPN tunnel, and is stored in the \c
- * context=2Ec2=2Elzo_com=
pwork of the \c context associated with that VPN
- * tunnel=2E
+ * compress=
_context structure=2E  One such structure is present for each VPN
+ * tunne=
l, and is stored in the \c context=2Ec2=2Ecomp_context of the \c
+ * contex=
t associated with that VPN tunnel=2E
  *
  * @par Initialization and cleanu=
p
- * Every time a new \c lzo_compress_workspace is needed, it must be
- * =
initialized using the \c lzo_compress_init() function=2E  Similarly,
- * ev=
ery time a \c lzo_compress_workspace is no longer needed, it must be
- * cl=
eaned up using the \c lzo_compress_uninit() function=2E  These
- * function=
s take care of the allocation and freeing of internal working
- * memory, b=
ut not of the \c lzo_compress_workspace structures themselves=2E
- *
- * @p=
ar
- * Because of the one-to-one relationship between \c
- * lzo_compress_w=
orkspace structures and VPN tunnels, the above-mentioned
- * initialization=
 and cleanup functions are called directly from the \c
- * init_instance() =
and \c close_instance() functions, which control the
- * initialization and=
 cleanup of VPN tunnel instances and their associated
- * \c context struct=
ures=2E
+ * \c comp_init() allocates a \c compress_context and calls the \c=

+ * compress_init method of its \c compress_alg; \c comp_uninit() calls
+ =
* the \c compress_uninit method and frees the structure=2E  Both are called=

+ * from \c init_instance() and \c close_instance(), and when pushed
+ * o=
ptions change=2E
  *
  * @par Packet processing functions
  * This module r=
eceives data channel packets from the \link data_control
@@ -67,25 +57,25 @=
@
  *
  * @par Settings that control this module's activity
  * Whether or =
not the Data Channel Compression module is active depends on
- * the compil=
e-time \c ENABLE_LZO preprocessor macro and the runtime flags
- * stored in=
 \c lzo_compress_workspace=2Eflags of the associated VPN tunnel=2E
- * The =
latter are initialized from \c options=2Elzo, which gets its value
- * from=
 the process's configuration sources, such as its configuration
- * file or=
 command line %options=2E
+ * the compile-time \c USE_COMP preprocessor mac=
ro and on \c
+ * options=2Ecomp=2Ealg, which gets its value from the proces=
s's configuration
+ * sources, such as its configuration file or command li=
ne %options=2E
+ * \c comp_init() creates no \c compress_context if no algo=
rithm is set=2E
+ * The flags in \c compress_context=2Eflags, copied from \=
c
+ * options=2Ecomp=2Eflags, only adjust framing, option checks and which
=
+ * algorithms are advertised to the peer=2E
  *
- * @par Adaptive compress=
ion
- * The compression module supports adaptive compression=2E  If this fe=
ature
- * is enabled, the compression routines monitor their own performanc=
e and
- * turn compression on or off depending on whether it is leading to
=
- * significantly reduced payload size=2E
+ * @par Outgoing packets
+ * Out=
going packets are never compressed, only framed so that the peer
+ * can pa=
rse them=2E
  *
  * @par Compression algorithms
- * This module uses the Le=
mpel-Ziv-Oberhumer (LZO) compression algorithms=2E
- * These offer lossless=
 compression and are designed for high-performance
- * decompression=2E  Th=
is module uses the external \c lzo library's
- * implementation of the algo=
rithms=2E
+ * This module supports the Lempel-Ziv-Oberhumer (LZO) and LZ4
+=
 * algorithms, as implemented by the external \c lzo and \c lz4
+ * librari=
es=2E
  *
  * @par
- * For more information on the LZO library, see:\n
- * =
https://www=2Eoberhumer=2Ecom/opensource/lzo/
+ * For more information on t=
hese libraries, see:\n
+ * https://www=2Eoberhumer=2Ecom/opensource/lzo/ \n=

+ * https://lz4=2Eorg/
  */
diff --git a/src/openvpn/comp-lz4=2Eh b/src/op=
envpn/comp-lz4=2Eh
index 3d04771=2E=2E10dbe59 100644
--- a/src/openvpn/comp=
-lz4=2Eh
+++ b/src/openvpn/comp-lz4=2Eh
@@ -31,10 +31,5 @@
 extern const st=
ruct compress_alg lz4_alg;
 extern const struct compress_alg lz4v2_alg;
 
-=
struct lz4_workspace
-{
-    int dummy;
-};
-
 #endif /* ENABLE_LZ4 */
 #en=
dif
diff --git a/src/openvpn/comp=2Eh b/src/openvpn/comp=2Eh
index 3f6411b=
=2E=2E4abf870 100644
--- a/src/openvpn/comp=2Eh
+++ b/src/openvpn/comp=2Eh
=
@@ -132,11 +132,6 @@
  */
 #define COMP_EXTRA_BUFFER(len) ((len) / 6 + 128 =
+ 3 + COMP_PREFIX_LEN)
 
-/*
- * Don't try to compress any packet smaller t=
han this=2E
- */
-#define COMPRESS_THRESHOLD 100
-
 /* Forward declaration =
of compression context */
 struct compress_context;
 
@@ -167,26 +162,12 @@=

 #endif
 
 /*
- * Workspace union of all supported compression algorithms
=
- */
-union compress_workspace_union
-{
-#ifdef ENABLE_LZO
-    struct lzo_=
compress_workspace lzo;
-#endif
-#ifdef ENABLE_LZ4
-    struct lz4_workspac=
e lz4;
-#endif
-};
-
-/*
  * Context for active compression session
  */
 s=
truct compress_context
 {
     unsigned int flags;
     struct compress_alg=
 alg;
-    union compress_workspace_union wu;
 
     /* statistics */
     =
counter_type pre_decompress;
diff --git a/src/openvpn/errlevel=2Eh b/src/op=
envpn/errlevel=2Eh
index 5cea0ad=2E=2E62ec731 100644
--- a/src/openvpn/errl=
evel=2Eh
+++ b/src/openvpn/errlevel=2Eh
@@ -123,7 +123,6 @@
 #define D_MTU_=
DEBUG        LOGLEV(7, 70, M_DEBUG)  /* show MTU debugging info */
 #define=
 D_MULTI_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show medium-freq multi debug=
ging info */
 #define D_MSS              LOGLEV(7, 70, M_DEBUG)  /* show MS=
S adjustments */
-#define D_COMP_LOW         LOGLEV(7, 70, M_DEBUG)  /* sho=
w adaptive compression state changes */
 #define D_CONNECTION_LIST  LOGLEV(=
7, 70, M_DEBUG)  /* show <connection> list info */
 #define D_SCRIPT       =
    LOGLEV(7, 70, M_DEBUG)  /* show parms & env vars passed to scripts */
 =
#define D_SHOW_NET         LOGLEV(7, 70, M_DEBUG)  /* show routing table an=
d adapter list */
diff --git a/src/openvpn/lzo=2Ec b/src/openvpn/lzo=2Ec
in=
dex 207cea6=2E=2Ef5ae776 100644
--- a/src/openvpn/lzo=2Ec
+++ b/src/openvpn=
/lzo=2Ec
@@ -35,7 +35,6 @@
 
 #include "comp=2Eh"
 #include "error=2Eh"
-#i=
nclude "otime=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -50,7 +49,6 @@
 {
     msg=
(D_INIT_MEDIUM, "LZO compression initializing");
     ASSERT(!(compctx->fla=
gs & COMP_F_SWAP));
-    compctx->wu=2Elzo=2Ewmem_size =3D LZO_WORKSPACE;
 =

     int lzo_status =3D lzo_init();
     if (lzo_status !=3D LZO_E_OK)
@@ =
-58,15 +56,11 @@
         msg(M_FATAL, "Cannot initialize LZO compression l=
ibrary (lzo_init() returns %d)",
             lzo_status);
     }
-    comp=
ctx->wu=2Elzo=2Ewmem =3D (lzo_voidp)malloc(compctx->wu=2Elzo=2Ewmem_size);
=
-    check_malloc_return(compctx->wu=2Elzo=2Ewmem);
 }
 
 static void
 lzo_=
compress_uninit(struct compress_context *compctx)
 {
-    free(compctx->wu=
=2Elzo=2Ewmem);
-    compctx->wu=2Elzo=2Ewmem =3D NULL;
 }
 
 static void
@=
@ -89,7 +83,7 @@
     if (c =3D=3D LZO_COMPRESS_BYTE) /* packet was compres=
sed */
     {
         ASSERT(buf_safe(&work, zlen));
-        int err =3D =
LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), BPTR(&work), &zlen, compctx->wu=2Elzo=
=2Ewmem);
+        int err =3D LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), BPTR(&=
work), &zlen, NULL);
         if (err !=3D LZO_E_OK)
         {
           =
  dmsg(D_COMP_ERRORS, "LZO decompression error: %d", err);
diff --git a/src=
/openvpn/lzo=2Eh b/src/openvpn/lzo=2Eh
index bb9cc81=2E=2E3a8586c 100644
--=
- a/src/openvpn/lzo=2Eh
+++ b/src/openvpn/lzo=2Eh
@@ -57,17 +57,6 @@
 
 /**=
************************************************************************/
 =
/** @name LZO library interface defines */ /** @{ */ /*********************=
**/
-#define LZO_COMPRESS   lzo1x_1_15_compress
-/**< LZO library compressi=
on function=2E
- *
- *   Use \c lzo1x_1_15_compress because it
- *   is des=
cribed as faster than the
- *   standard routine, although it does
- *   ne=
ed a bit more memory=2E */
-#define LZO_WORKSPACE  LZO1X_1_15_MEM_COMPRESS
=
-/**< The size in bytes of the memory
- *   %buffer required by the LZO lib=
rary
- *   compression algorithm=2E */
 #define LZO_DECOMPRESS lzo1x_decomp=
ress_safe
 /**< LZO library decompression function=2E
  *
@@ -80,52 +69,6 @=
@
  *   using the non-safe version=2E */
 /** @} name LZO library interface=
 */ /**************************************/
 
-
-/************************=
**************************************************/
-/** @name Adaptive com=
pression defines */ /** @{ */ /************************/
-#define AC_SAMP_S=
EC 2                               /**< Number of seconds in a sample perio=
d=2E */
-#define AC_MIN_BYTES                                              =
                        \
-    1000                                        =
    /**< Minimum number of bytes a sample \
-                              =
                       *   period must contain for it to be \
-            =
                                         *   evaluated=2E */
-#define AC_SA=
VE_PCT                                                                     =
   \
-    5                                               /**< Minimum size=
 reduction percentage \
-                                                  =
   *   below which compression will be   \
-                               =
                      *   turned off=2E */
-#define AC_OFF_SEC             =
                                                                \
-    60  =
                                            /**< Seconds to wait after comp=
ression has \
-                                                     *   bee=
n turned off before retesting=2E */
-/** @} name Adaptive compression defin=
es */         /*******************************/
-
-/**
- * Adaptive compres=
sion state=2E
- */
-struct lzo_adaptive_compress
-{
-    bool compress_stat=
e;
-    time_t next;
-    int n_total;
-    int n_comp;
-};
-
-
-/**
- * St=
ate for the compression and decompression routines=2E
- *
- * This structur=
e contains compression module state, such as whether
- * compression is ena=
bled and the status of the adaptive compression
- * routines=2E  It also co=
ntains an allocated working buffer=2E
- *
- * One of these compression work=
space structures is maintained for each
- * VPN tunnel=2E
- */
-struct lzo_=
compress_workspace
-{
-    lzo_voidp wmem;
-    int wmem_size;
-    struct =
lzo_adaptive_compress ac;
-};
-
 /** @} addtogroup compression */
 
 

-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2328?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I189f3a311719b5c447635=
1702a44870d485d10d8
Gerrit-Change-Number: 2328
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>

--NptgXeSWcbY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2328?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">comp: drop compression on send leftovers<br><br>7f0214c=
9 (&quot;Remove support for compression on send&quot;) left the LZO<br>comp=
ression workspace, adaptive compression state and related defines<br>behind=
=2E lzo1x_decompress_safe() ignores its work memory argument, so<br>stop al=
locating LZO1X_1_15_MEM_COMPRESS bytes (256 KiB on 64-bit) per<br>LZO compr=
ession context and pass NULL instead=2E<br><br>Remove the now empty compres=
s_workspace_union, COMPRESS_THRESHOLD and<br>D_COMP_LOW, probe for lzo1x_de=
compress_safe() instead of the unused<br>compressor in configure, and updat=
e the compression module docs=2E<br><br>Change-Id: I189f3a311719b5c44763517=
02a44870d485d10d8<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt;<br>---<br>M configure=2Eac<br>M doc/doxygen/doc_compression=2Eh<br>M=
 src/openvpn/comp-lz4=2Eh<br>M src/openvpn/comp=2Eh<br>M src/openvpn/errlev=
el=2Eh<br>M src/openvpn/lzo=2Ec<br>M src/openvpn/lzo=2Eh<br>7 files changed=
, 29 insertions(+), 127 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/2328/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/configure=2Eac b/configure=2Eac</span><br><span>index 585c3bd=2E=
=2E05fa964 100644</span><br><span>--- a/configure=2Eac</span><br><span>+++ =
b/configure=2Eac</span><br><span>@@ -1001,11 +1001,11 @@</span><br><span> 	=
have_lzo=3D&quot;yes&quot;</span><br><span> 	AC_CHECK_LIB(</span><br><span>=
 		[lzo2],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[lzo1x_1_=
15_compress],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[lzo=
1x_decompress_safe],</span><br><span> 		[LZO_LIBS=3D&quot;-llzo2&quot;],</s=
pan><br><span> 		[AC_CHECK_LIB(</span><br><span> 			[lzo],</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-			[lzo1x_1_15_compress],</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+			[lzo1x_decompress_safe],</spa=
n><br><span> 			[LZO_LIBS=3D&quot;-llzo&quot;],</span><br><span> 			[have_l=
zo=3D&quot;no&quot;]</span><br><span> 		)]</span><br><span>diff --git a/doc=
/doxygen/doc_compression=2Eh b/doc/doxygen/doc_compression=2Eh</span><br><s=
pan>index efd18bf=2E=2E4c60e74 100644</span><br><span>--- a/doc/doxygen/doc=
_compression=2Eh</span><br><span>+++ b/doc/doxygen/doc_compression=2Eh</spa=
n><br><span>@@ -29,31 +29,21 @@</span><br><span> /**</span><br><span>  * @d=
efgroup compression Data Channel Compression module</span><br><span>  *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * This module offers com=
pression of data channel packets=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * This module decompresses incoming data channel packets a=
nd adds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * compressi=
on framing to outgoing ones=2E</span><br><span>  *</span><br><span>  * @par=
 State structures</span><br><span>  * The Data Channel Compression module s=
tores its internal state in a \c</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * lzo_compress_workspace structure=2E  This state includes flag=
s which</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * control the=
 module&#39;s behavior and preallocated working memory=2E  One</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * such structure is present for e=
ach VPN tunnel, and is stored in the \c</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * context=2Ec2=2Elzo_compwork of the \c context associat=
ed with that VPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * tu=
nnel=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * compress_=
context structure=2E  One such structure is present for each VPN</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * tunnel, and is stored in th=
e \c context=2Ec2=2Ecomp_context of the \c</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * context associated with that VPN tunnel=2E</span>=
<br><span>  *</span><br><span>  * @par Initialization and cleanup</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * Every time a new \c lzo_comp=
ress_workspace is needed, it must be</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * initialized using the \c lzo_compress_init() function=2E =
 Similarly,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * every t=
ime a \c lzo_compress_workspace is no longer needed, it must be</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * cleaned up using the \c lzo_co=
mpress_uninit() function=2E  These</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * functions take care of the allocation and freeing of intern=
al working</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * memory, =
but not of the \c lzo_compress_workspace structures themselves=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * @par</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * Because of the one-to-one relationship between \c</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * lzo_compress_workspace structu=
res and VPN tunnels, the above-mentioned</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * initialization and cleanup functions are called direc=
tly from the \c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * ini=
t_instance() and \c close_instance() functions, which control the</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * initialization and cleanup o=
f VPN tunnel instances and their associated</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * \c context structures=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * \c comp_init() allocates a \c compress_con=
text and calls the \c</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * compress_init method of its \c compress_alg; \c comp_uninit() calls</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the \c compress_uni=
nit method and frees the structure=2E  Both are called</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * from \c init_instance() and \c close_=
instance(), and when pushed</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * options change=2E</span><br><span>  *</span><br><span>  * @par P=
acket processing functions</span><br><span>  * This module receives data ch=
annel packets from the \link data_control</span><br><span>@@ -67,25 +57,25 =
@@</span><br><span>  *</span><br><span>  * @par Settings that control this =
module&#39;s activity</span><br><span>  * Whether or not the Data Channel C=
ompression module is active depends on</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * the compile-time \c ENABLE_LZO preprocessor macro and t=
he runtime flags</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * st=
ored in \c lzo_compress_workspace=2Eflags of the associated VPN tunnel=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The latter are initi=
alized from \c options=2Elzo, which gets its value</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * from the process&#39;s configuration source=
s, such as its configuration</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * file or command line %options=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * the compile-time \c USE_COMP preprocessor macro a=
nd on \c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * options=
=2Ecomp=2Ealg, which gets its value from the process&#39;s configuration</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sources, such as it=
s configuration file or command line %options=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * \c comp_init() creates no \c compress_conte=
xt if no algorithm is set=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * The flags in \c compress_context=2Eflags, copied from \c</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * options=2Ecomp=2Eflags,=
 only adjust framing, option checks and which</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * algorithms are advertised to the peer=2E</span=
><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @par=
 Adaptive compression</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * The compression module supports adaptive compression=2E  If this feature=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * is enabled, the co=
mpression routines monitor their own performance and</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * turn compression on or off depending on =
whether it is leading to</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * significantly reduced payload size=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @par Outgoing packets</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Outgoing packets are never compressed, only=
 framed so that the peer</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * can parse them=2E</span><br><span>  *</span><br><span>  * @par Comp=
ression algorithms</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
This module uses the Lempel-Ziv-Oberhumer (LZO) compression algorithms=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * These offer lossless=
 compression and are designed for high-performance</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * decompression=2E  This module uses the exte=
rnal \c lzo library&#39;s</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * implementation of the algorithms=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * This module supports the Lempel-Ziv-Oberhumer (LZ=
O) and LZ4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * algori=
thms, as implemented by the external \c lzo and \c lz4</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * libraries=2E</span><br><span>  *</spa=
n><br><span>  * @par</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* For more information on the LZO library, see:\n</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * https://www=2Eoberhumer=2Ecom/opensource/lzo=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * For more inform=
ation on these libraries, see:\n</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * https://www=2Eoberhumer=2Ecom/opensource/lzo/ \n</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * https://lz4=2Eorg/</span><b=
r><span>  */</span><br><span>diff --git a/src/openvpn/comp-lz4=2Eh b/src/op=
envpn/comp-lz4=2Eh</span><br><span>index 3d04771=2E=2E10dbe59 100644</span>=
<br><span>--- a/src/openvpn/comp-lz4=2Eh</span><br><span>+++ b/src/openvpn/=
comp-lz4=2Eh</span><br><span>@@ -31,10 +31,5 @@</span><br><span> extern con=
st struct compress_alg lz4_alg;</span><br><span> extern const struct compre=
ss_alg lz4v2_alg;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-struct lz4_workspace</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int=
 dummy;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* ENABL=
E_LZ4 */</span><br><span> #endif</span><br><span>diff --git a/src/openvpn/c=
omp=2Eh b/src/openvpn/comp=2Eh</span><br><span>index 3f6411b=2E=2E4abf870 1=
00644</span><br><span>--- a/src/openvpn/comp=2Eh</span><br><span>+++ b/src/=
openvpn/comp=2Eh</span><br><span>@@ -132,11 +132,6 @@</span><br><span>  */<=
/span><br><span> #define COMP_EXTRA_BUFFER(len) ((len) / 6 + 128 + 3 + COMP=
_PREFIX_LEN)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Don&#39=
;t try to compress any packet smaller than this=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define COMPRESS_THRESHOLD 100</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> /* Forward declaration of compression=
 context */</span><br><span> struct compress_context;</span><br><span> </sp=
an><br><span>@@ -167,26 +162,12 @@</span><br><span> #endif</span><br><span>=
 </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * Workspace union of all supported compression algorithms</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-union compress_workspace_union</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#ifdef ENABLE_LZO</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct lzo_compress_workspace lzo;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef ENABLE_LZ4</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct lz4_workspace lz4;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Context for active c=
ompression session</span><br><span>  */</span><br><span> struct compress_co=
ntext</span><br><span> {</span><br><span>     unsigned int flags;</span><br=
><span>     struct compress_alg alg;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    union compress_workspace_union wu;</span><br><span> </sp=
an><br><span>     /* statistics */</span><br><span>     counter_type pre_de=
compress;</span><br><span>diff --git a/src/openvpn/errlevel=2Eh b/src/openv=
pn/errlevel=2Eh</span><br><span>index 5cea0ad=2E=2E62ec731 100644</span><br=
><span>--- a/src/openvpn/errlevel=2Eh</span><br><span>+++ b/src/openvpn/err=
level=2Eh</span><br><span>@@ -123,7 +123,6 @@</span><br><span> #define D_MT=
U_DEBUG        LOGLEV(7, 70, M_DEBUG)  /* show MTU debugging info */</span>=
<br><span> #define D_MULTI_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show mediu=
m-freq multi debugging info */</span><br><span> #define D_MSS              =
LOGLEV(7, 70, M_DEBUG)  /* show MSS adjustments */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define D_COMP_LOW         LOGLEV(7, 70, M_DEB=
UG)  /* show adaptive compression state changes */</span><br><span> #define=
 D_CONNECTION_LIST  LOGLEV(7, 70, M_DEBUG)  /* show &lt;connection&gt; list=
 info */</span><br><span> #define D_SCRIPT           LOGLEV(7, 70, M_DEBUG)=
  /* show parms &amp; env vars passed to scripts */</span><br><span> #defin=
e D_SHOW_NET         LOGLEV(7, 70, M_DEBUG)  /* show routing table and adap=
ter list */</span><br><span>diff --git a/src/openvpn/lzo=2Ec b/src/openvpn/=
lzo=2Ec</span><br><span>index 207cea6=2E=2Ef5ae776 100644</span><br><span>-=
-- a/src/openvpn/lzo=2Ec</span><br><span>+++ b/src/openvpn/lzo=2Ec</span><b=
r><span>@@ -35,7 +35,6 @@</span><br><span> </span><br><span> #include &quot=
;comp=2Eh&quot;</span><br><span> #include &quot;error=2Eh&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;otime=2Eh&quot;</s=
pan><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br>=
<span> </span><br><span>@@ -50,7 +49,6 @@</span><br><span> {</span><br><spa=
n>     msg(D_INIT_MEDIUM, &quot;LZO compression initializing&quot;);</span>=
<br><span>     ASSERT(!(compctx-&gt;flags &amp; COMP_F_SWAP));</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    compctx-&gt;wu=2Elzo=2Ewmem_si=
ze =3D LZO_WORKSPACE;</span><br><span> </span><br><span>     int lzo_status=
 =3D lzo_init();</span><br><span>     if (lzo_status !=3D LZO_E_OK)</span><=
br><span>@@ -58,15 +56,11 @@</span><br><span>         msg(M_FATAL, &quot;Ca=
nnot initialize LZO compression library (lzo_init() returns %d)&quot;,</spa=
n><br><span>             lzo_status);</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    compctx-&gt;wu=2Elzo=2Ewmem =3D =
(lzo_voidp)malloc(compctx-&gt;wu=2Elzo=2Ewmem_size);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    check_malloc_return(compctx-&gt;wu=2Elz=
o=2Ewmem);</span><br><span> }</span><br><span> </span><br><span> static voi=
d</span><br><span> lzo_compress_uninit(struct compress_context *compctx)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    f=
ree(compctx-&gt;wu=2Elzo=2Ewmem);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    compctx-&gt;wu=2Elzo=2Ewmem =3D NULL;</span><br><span> }</s=
pan><br><span> </span><br><span> static void</span><br><span>@@ -89,7 +83,7=
 @@</span><br><span>     if (c =3D=3D LZO_COMPRESS_BYTE) /* packet was comp=
ressed */</span><br><span>     {</span><br><span>         ASSERT(buf_safe(&=
amp;work, zlen));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    int err =3D LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), BPTR(&amp;work), &amp=
;zlen, compctx-&gt;wu=2Elzo=2Ewmem);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        int err =3D LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), =
BPTR(&amp;work), &amp;zlen, NULL);</span><br><span>         if (err !=3D LZ=
O_E_OK)</span><br><span>         {</span><br><span>             dmsg(D_COMP=
_ERRORS, &quot;LZO decompression error: %d&quot;, err);</span><br><span>dif=
f --git a/src/openvpn/lzo=2Eh b/src/openvpn/lzo=2Eh</span><br><span>index b=
b9cc81=2E=2E3a8586c 100644</span><br><span>--- a/src/openvpn/lzo=2Eh</span>=
<br><span>+++ b/src/openvpn/lzo=2Eh</span><br><span>@@ -57,17 +57,6 @@</spa=
n><br><span> </span><br><span> /*******************************************=
*******************************/</span><br><span> /** @name LZO library int=
erface defines */ /** @{ */ /***********************/</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define LZO_COMPRESS   lzo1x_1_15_compress<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**&lt; LZO library co=
mpression function=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   Use \c lzo1x_1=
_15_compress because it</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *   is described as faster than the</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *   standard routine, although it does</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *   need a bit more memory=2E */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define LZO_WORKSPACE  LZO1X=
_1_15_MEM_COMPRESS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**=
&lt; The size in bytes of the memory</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *   %buffer required by the LZO library</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *   compression algorithm=2E */</span><b=
r><span> #define LZO_DECOMPRESS lzo1x_decompress_safe</span><br><span> /**&=
lt; LZO library decompression function=2E</span><br><span>  *</span><br><sp=
an>@@ -80,52 +69,6 @@</span><br><span>  *   using the non-safe version=2E *=
/</span><br><span> /** @} name LZO library interface */ /******************=
********************/</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**=
************************************************************************/</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** @name Adaptive comp=
ression defines */ /** @{ */ /************************/</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define AC_SAMP_SEC 2                    =
           /**&lt; Number of seconds in a sample period=2E */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define AC_MIN_BYTES               =
                                                       \</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    1000                                =
            /**&lt; Minimum number of bytes a sample \</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                          =
           *   period must contain for it to be \</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                               =
      *   evaluated=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define AC_SAVE_PCT                                                    =
                    \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    5                                               /**&lt; Minimum size re=
duction percentage \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                                    *   below which compres=
sion will be   \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                                                *   turned off=2E */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define AC_OFF_SEC          =
                                                                   \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    60                      =
                        /**&lt; Seconds to wait after compression has \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
                            *   been turned off before retesting=2E */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-/** @} name Adaptive compr=
ession defines */         /*******************************/</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* Adaptive compression state=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct l=
zo_adaptive_compress</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool compress_sta=
te;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    time_t next;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int n_total;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int n_comp;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * State for the compression and decom=
pression routines=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This structure co=
ntains compression module state, such as whether</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * compression is enabled and the status of the =
adaptive compression</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* routines=2E  It also contains an allocated working buffer=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * One of these compression workspace structures is m=
aintained for each</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
VPN tunnel=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-struct lzo_compress_worksp=
ace</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    lzo_voidp wmem;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int wmem_size;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct lzo_adaptive_compress ac;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> /** @} addtogroup compression=
 */</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2328?usp=3Demail">change 2328</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2328?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I189f3a311719b5c4476351702a=
44870d485d10d8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 23=
28 </div>
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
--NptgXeSWcbY=--


--===============1784946376156183576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1784946376156183576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1784946376156183576==--

