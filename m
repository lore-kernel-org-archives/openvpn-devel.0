Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC33606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AtFxJxlp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eZ7ggPlk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Z3LL0F+F;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LfEMhTZv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IFN67r++IuaoxHsqEKSSpI7LvQARe2MqRp5iHJRlunU=; b=AtFxJxlpLsxBt7hkBZePWyrhJ6
	wcXbhftOkv5XSGaRbRnFIYzbj9YoYFiuE1jxbXLX2MEmiyOw5kcOmGl+PlmJJeDB3zIrC6i6AFDrx
	u4YyOF+BkAAePvfzsAYGZS4MV/LbkwMlB9+LzExqG+0xKyPyGELRLvXBwGj6pN3IT6Rs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWW5x-000000006UT-17Nw;
	Thu, 26 Nov 2026 09:48:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWW5v-000000006UM-17hg
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:48:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/IHPBik7v4OOjwSEFgh4IoJkvW6j7OX/KAkkbrgzRoI=; b=eZ7ggPlkuNcM6HuLfnNTEwvpyO
 jeHSg1PrWdMvp1vWvOnp3MUO7+BhEswiUheBNu2QMN/+JiNORZ3oQVUfRFdH1R9cecsVTbBmNwRnW
 nB7NbFF3fw/QszGaQg8lIv/hWZXDNlma4RIvtERUqIQWnHNmor29S4XMJGK/rPNZvjxE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/IHPBik7v4OOjwSEFgh4IoJkvW6j7OX/KAkkbrgzRoI=; b=Z3LL0F+FyUtapixmvEfoYv/ryc
 8ECBTutgcy1qZNPPXWxwTXR1dxnF25qr7BA7hRUTx/6Bl6airA2qkD5u/9G0so+KiPooCgggYhGFa
 LxX7LRx8Ay0z5cqMYVn9yFf0PIUCb5jk3fersmynjc4mNGvqbN7nxTGhE63FE2Y04CF8=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWW5t-000000002iN-0Xfl for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:48:47 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so54652555e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 01:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795686518; x=1796291318; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/IHPBik7v4OOjwSEFgh4IoJkvW6j7OX/KAkkbrgzRoI=;
 b=LfEMhTZviZAWIz6st9FTqCFte7EhMUoO7nqaK+I1vFSx8nlS3r2BIfYljjfebvuqkF
 FX3BoK4Z6pAz73txrQBMIjw6WNvWa907URb1vyzyISwj8XJ6Amayp/9pdCfvSodvGius
 jpl0R6WRCSh6yRWcz9z1gM4kQ1Rl3tAI32OSHZgLDywoaQKB42gwTNgRYtR1jgzVrf7q
 SQe3hVgAY/MEjAWknAIuIT0f61wEjZBbTHzcMys+iRwxoQfa6MUbYTIzmpyaZSfP/xcz
 uG+NmW+TBkebjxeMYCDZ3iq2vuk1d7x3puiiKI+otCyDZKMwhbp/fQcrZAClec9Rg5Op
 yyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795686518; x=1796291318;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/IHPBik7v4OOjwSEFgh4IoJkvW6j7OX/KAkkbrgzRoI=;
 b=R2TpLoyXCbWxoDEFO3s15pI8E+eACiRzLjwl6lB8MaOzSCXgE3D1Nb3ou08uKYW4AL
 rkZ6V+RlhtfhvYMHfHVoKVcGHZRJS4IYHNqk3SvlEBjO3sTx5JtuTSMGs6a5IucmYH1O
 o8VyKGzsH0mI/0kHv81260oukSz6M0r6z9LXgyjYADLj3Za5Tg0/4bxtSrnI60UKcBVM
 lv3PVG4DtNNAsc/T3B/aMzcrBpjn6vkCtNAyeA938G/1lU6bWqnoH6iVIJMAhz/HLHNk
 S2Id2+3GwXgSAdxwcDN8+ektM3zOkSYkv0ecNKnk8moa1DLrYaKV40Pl7GnvdVTkSlTr
 Chyw==
X-Forwarded-Encrypted: i=1;
 AL+hErGOaQ1TMRwSwhQbqpTlft6iS68hlBTunXppq3K/sjgQc9fiaE+UNbrz8H0+mbBepFdyAdd4qcMGk+1xb5hu@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8TUQUD93b0fNxAzxXrS3z9XyE+1wh7ue+mJ11qA2SxXqJKKzUc
 mKXJGYrF8Yku/MtMYam04SdqnMbTCZI1ZoXeZCDV9+gym5bQE9mlWlxkPGBVAqa1+9bcAQfpUAP
 HmjWL7IV4qzWI3JSWygZlUpPj1oUQDPK0+p7s6mNXVRLqtk8ZB6RLQJpqK6w9kNVuwFY+
X-Gm-Gg: AZFdTZebZVN11iUqzW+HXNL8ad8ynrOXrxsoMHm1qXELwYVQsZRFvNGIuspkQv89llx
 8uSiPCHfrKvHOZW1YsAg/ML22134gBZyIRNsFju7vStfS0wQfRQVVimG8ZW2rjUX97D4toSZm3c
 FLNWBPoNk49j0XMwbZrvSH3fQpVLmAWEwZ2NnKjsHU1YLSVCOJBaJvqgVknNRAQMx3rfGWEm5pS
 JCSHr61A08iEOjyNe/d6NKYGPLVCbbf5Fw5PFSTZPSxPZSQcwpIK+s2P9OxohJZk7tX5UZt5av3
 TauPn7v8eSybCM8WqcbDORUqCjjBDJr4dWloxqnlNzO1RJyZ4WUHdltmZIqlFnotpi1IzrUYTKJ
 PQC8K+67cfc3g7Q60A0MPr7f1W0gHg/Qp4gvJ0XKtLuHrZ9IwnupSYahMai6DqaKlG7NO3WVMMD
 r+BIYymtSdxN+zVoKCoRqsUVP9NRYkrOPeA4PuYTJY0+gTAYCu6TUs6cO4iYkGDmhGHfb5LiHsV
 gU5PDHJ3LIdnLUG9sxephyqETK4rSZM7qqLkJP2YAgkgc6Hn6025HZu90wmJDDpBFwBikP+CmaT
 4RNRmp7auAhq7kSQrI8yWDSe5JquiMvXPxZH6O21i0+cYnFVZvRLbXZytjRPELuckAnA/YvixGR
 x9UriVn2kOzasGYK6MaUR5/0cw0BWpsisp9f6iJbi/kU92qRDtvhJ4/c1FoisSKu582UXzOHhJr
 /ES4h2nFosdBpjFFiqCj6sZ8FxTNaRRUTn8IDX
X-Received: by 2002:a05:600c:1549:b0:4bb:6f45:2a77 with SMTP id
 5b1f17b1804b1-4bb8880abf7mr392968445e9.11.1795686518196; 
 Thu, 26 Nov 2026 01:48:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90660cb4sm543965965e9.2.2026.11.26.01.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 01:48:37 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 09:48:37 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I189f3a311719b5c4476351702a44870d485d10d8
X-Gerrit-Change-Number: 2328
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2328?usp=email>
X-Gerrit-Commit: cd485998d2357c8ce48f7a2302f82176f336510e
In-Reply-To: <gerrit.1795442905000.I189f3a311719b5c4476351702a44870d485d10d8@gerrit.openvpn.net>
References: <gerrit.1795442905000.I189f3a311719b5c4476351702a44870d485d10d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQyOTA1MDAwLkkxODlmM2EzMTE3MTliNWM0NDc2MzUxNzAyYTQ0ODcwZDQ4NWQxMGQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3fb180d4b88db622455671711da8deaa8bdfe871-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWW5t-000000002iN-0Xfl
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4891225575512939100=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4891225575512939100==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gsLFoOrtD2A="; charset=UTF-8

--gsLFoOrtD2A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2328?usp=3Demail )

Change subject: comp: drop compression on s=
end leftovers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


comp: drop compression on send leftovers

7f0214c9 ("Remove support for c=
ompression on send") left the LZO
compression workspace, adaptive compressi=
on state and related defines
behind=2E lzo1x_decompress_safe() ignores its =
work memory argument, so
stop allocating LZO1X_1_15_MEM_COMPRESS bytes (256=
 KiB on 64-bit) per
LZO compression context and pass NULL instead=2E

Remov=
e the now empty compress_workspace_union, COMPRESS_THRESHOLD and
D_COMP_LOW=
, probe for lzo1x_decompress_safe() instead of the unused
compressor in con=
figure, and update the compression module docs=2E

Change-Id: I189f3a311719=
b5c4476351702a44870d485d10d8
Signed-off-by: Razvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2328
Message-Id: <20261123143201=
=2E4058-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg41831=2Ehtml
Signed-off-by: Gert D=
oering <gert@greenie=2Emuc=2Ede>
---
M configure=2Eac
M doc/doxygen/doc_com=
pression=2Eh
M src/openvpn/comp-lz4=2Eh
M src/openvpn/comp=2Eh
M src/openvp=
n/errlevel=2Eh
M src/openvpn/lzo=2Ec
M src/openvpn/lzo=2Eh
7 files changed,=
 29 insertions(+), 127 deletions(-)




diff --git a/configure=2Eac b/confi=
gure=2Eac
index 585c3bd=2E=2E05fa964 100644
--- a/configure=2Eac
+++ b/conf=
igure=2Eac
@@ -1001,11 +1001,11 @@
 	have_lzo=3D"yes"
 	AC_CHECK_LIB(
 		[l=
zo2],
-		[lzo1x_1_15_compress],
+		[lzo1x_decompress_safe],
 		[LZO_LIBS=3D=
"-llzo2"],
 		[AC_CHECK_LIB(
 			[lzo],
-			[lzo1x_1_15_compress],
+			[lzo=
1x_decompress_safe],
 			[LZO_LIBS=3D"-llzo"],
 			[have_lzo=3D"no"]
 		)]
=
diff --git a/doc/doxygen/doc_compression=2Eh b/doc/doxygen/doc_compression=
=2Eh
index efd18bf=2E=2E4c60e74 100644
--- a/doc/doxygen/doc_compression=2E=
h
+++ b/doc/doxygen/doc_compression=2Eh
@@ -29,31 +29,21 @@
 /**
  * @defgr=
oup compression Data Channel Compression module
  *
- * This module offers =
compression of data channel packets=2E
+ * This module decompresses incomin=
g data channel packets and adds
+ * compression framing to outgoing ones=2E=

  *
  * @par State structures
  * The Data Channel Compression module stor=
es its internal state in a \c
- * lzo_compress_workspace structure=2E  This=
 state includes flags which
- * control the module's behavior and prealloca=
ted working memory=2E  One
- * such structure is present for each VPN tunne=
l, and is stored in the \c
- * context=2Ec2=2Elzo_compwork of the \c contex=
t associated with that VPN
- * tunnel=2E
+ * compress_context structure=2E =
 One such structure is present for each VPN
+ * tunnel, and is stored in th=
e \c context=2Ec2=2Ecomp_context of the \c
+ * context associated with that=
 VPN tunnel=2E
  *
  * @par Initialization and cleanup
- * Every time a new=
 \c lzo_compress_workspace is needed, it must be
- * initialized using the =
\c lzo_compress_init() function=2E  Similarly,
- * every time a \c lzo_comp=
ress_workspace is no longer needed, it must be
- * cleaned up using the \c =
lzo_compress_uninit() function=2E  These
- * functions take care of the all=
ocation and freeing of internal working
- * memory, but not of the \c lzo_c=
ompress_workspace structures themselves=2E
- *
- * @par
- * Because of the =
one-to-one relationship between \c
- * lzo_compress_workspace structures an=
d VPN tunnels, the above-mentioned
- * initialization and cleanup functions=
 are called directly from the \c
- * init_instance() and \c close_instance(=
) functions, which control the
- * initialization and cleanup of VPN tunnel=
 instances and their associated
- * \c context structures=2E
+ * \c comp_in=
it() allocates a \c compress_context and calls the \c
+ * compress_init met=
hod of its \c compress_alg; \c comp_uninit() calls
+ * the \c compress_unin=
it method and frees the structure=2E  Both are called
+ * from \c init_inst=
ance() and \c close_instance(), and when pushed
+ * options change=2E
  *
 =
 * @par Packet processing functions
  * This module receives data channel p=
ackets from the \link data_control
@@ -67,25 +57,25 @@
  *
  * @par Setting=
s that control this module's activity
  * Whether or not the Data Channel C=
ompression module is active depends on
- * the compile-time \c ENABLE_LZO p=
reprocessor macro and the runtime flags
- * stored in \c lzo_compress_works=
pace=2Eflags of the associated VPN tunnel=2E
- * The latter are initialized=
 from \c options=2Elzo, which gets its value
- * from the process's configu=
ration sources, such as its configuration
- * file or command line %options=
=2E
+ * the compile-time \c USE_COMP preprocessor macro and on \c
+ * optio=
ns=2Ecomp=2Ealg, which gets its value from the process's configuration
+ * =
sources, such as its configuration file or command line %options=2E
+ * \c =
comp_init() creates no \c compress_context if no algorithm is set=2E
+ * Th=
e flags in \c compress_context=2Eflags, copied from \c
+ * options=2Ecomp=
=2Eflags, only adjust framing, option checks and which
+ * algorithms are a=
dvertised to the peer=2E
  *
- * @par Adaptive compression
- * The compress=
ion module supports adaptive compression=2E  If this feature
- * is enabled=
, the compression routines monitor their own performance and
- * turn compr=
ession on or off depending on whether it is leading to
- * significantly re=
duced payload size=2E
+ * @par Outgoing packets
+ * Outgoing packets are ne=
ver compressed, only framed so that the peer
+ * can parse them=2E
  *
  * =
@par Compression algorithms
- * This module uses the Lempel-Ziv-Oberhumer (=
LZO) compression algorithms=2E
- * These offer lossless compression and are=
 designed for high-performance
- * decompression=2E  This module uses the e=
xternal \c lzo library's
- * implementation of the algorithms=2E
+ * This m=
odule supports the Lempel-Ziv-Oberhumer (LZO) and LZ4
+ * algorithms, as im=
plemented by the external \c lzo and \c lz4
+ * libraries=2E
  *
  * @par
-=
 * For more information on the LZO library, see:\n
- * https://www=2Eoberhu=
mer=2Ecom/opensource/lzo/
+ * For more information on these libraries, see:=
\n
+ * https://www=2Eoberhumer=2Ecom/opensource/lzo/ \n
+ * https://lz4=2Eo=
rg/
  */
diff --git a/src/openvpn/comp-lz4=2Eh b/src/openvpn/comp-lz4=2Eh
i=
ndex 3d04771=2E=2E10dbe59 100644
--- a/src/openvpn/comp-lz4=2Eh
+++ b/src/o=
penvpn/comp-lz4=2Eh
@@ -31,10 +31,5 @@
 extern const struct compress_alg lz=
4_alg;
 extern const struct compress_alg lz4v2_alg;
 
-struct lz4_workspace=

-{
-    int dummy;
-};
-
 #endif /* ENABLE_LZ4 */
 #endif
diff --git a/src=
/openvpn/comp=2Eh b/src/openvpn/comp=2Eh
index 3f6411b=2E=2E4abf870 100644
=
--- a/src/openvpn/comp=2Eh
+++ b/src/openvpn/comp=2Eh
@@ -132,11 +132,6 @@
=
  */
 #define COMP_EXTRA_BUFFER(len) ((len) / 6 + 128 + 3 + COMP_PREFIX_LEN=
)
 
-/*
- * Don't try to compress any packet smaller than this=2E
- */
-#de=
fine COMPRESS_THRESHOLD 100
-
 /* Forward declaration of compression contex=
t */
 struct compress_context;
 
@@ -167,26 +162,12 @@
 #endif
 
 /*
- * Wo=
rkspace union of all supported compression algorithms
- */
-union compress_=
workspace_union
-{
-#ifdef ENABLE_LZO
-    struct lzo_compress_workspace lz=
o;
-#endif
-#ifdef ENABLE_LZ4
-    struct lz4_workspace lz4;
-#endif
-};
-
=
-/*
  * Context for active compression session
  */
 struct compress_contex=
t
 {
     unsigned int flags;
     struct compress_alg alg;
-    union comp=
ress_workspace_union wu;
 
     /* statistics */
     counter_type pre_deco=
mpress;
diff --git a/src/openvpn/errlevel=2Eh b/src/openvpn/errlevel=2Eh
in=
dex 5cea0ad=2E=2E62ec731 100644
--- a/src/openvpn/errlevel=2Eh
+++ b/src/op=
envpn/errlevel=2Eh
@@ -123,7 +123,6 @@
 #define D_MTU_DEBUG        LOGLEV(7=
, 70, M_DEBUG)  /* show MTU debugging info */
 #define D_MULTI_DEBUG      L=
OGLEV(7, 70, M_DEBUG)  /* show medium-freq multi debugging info */
 #define=
 D_MSS              LOGLEV(7, 70, M_DEBUG)  /* show MSS adjustments */
-#de=
fine D_COMP_LOW         LOGLEV(7, 70, M_DEBUG)  /* show adaptive compressio=
n state changes */
 #define D_CONNECTION_LIST  LOGLEV(7, 70, M_DEBUG)  /* s=
how <connection> list info */
 #define D_SCRIPT           LOGLEV(7, 70, M_D=
EBUG)  /* show parms & env vars passed to scripts */
 #define D_SHOW_NET   =
      LOGLEV(7, 70, M_DEBUG)  /* show routing table and adapter list */
dif=
f --git a/src/openvpn/lzo=2Ec b/src/openvpn/lzo=2Ec
index 207cea6=2E=2Ef5ae=
776 100644
--- a/src/openvpn/lzo=2Ec
+++ b/src/openvpn/lzo=2Ec
@@ -35,7 +35=
,6 @@
 
 #include "comp=2Eh"
 #include "error=2Eh"
-#include "otime=2Eh"
 
=
 #include "memdbg=2Eh"
 
@@ -50,7 +49,6 @@
 {
     msg(D_INIT_MEDIUM, "LZO =
compression initializing");
     ASSERT(!(compctx->flags & COMP_F_SWAP));
-=
    compctx->wu=2Elzo=2Ewmem_size =3D LZO_WORKSPACE;
 
     int lzo_status =
=3D lzo_init();
     if (lzo_status !=3D LZO_E_OK)
@@ -58,15 +56,11 @@
    =
     msg(M_FATAL, "Cannot initialize LZO compression library (lzo_init() re=
turns %d)",
             lzo_status);
     }
-    compctx->wu=2Elzo=2Ewmem =
=3D (lzo_voidp)malloc(compctx->wu=2Elzo=2Ewmem_size);
-    check_malloc_ret=
urn(compctx->wu=2Elzo=2Ewmem);
 }
 
 static void
 lzo_compress_uninit(struc=
t compress_context *compctx)
 {
-    free(compctx->wu=2Elzo=2Ewmem);
-    c=
ompctx->wu=2Elzo=2Ewmem =3D NULL;
 }
 
 static void
@@ -89,7 +83,7 @@
     =
if (c =3D=3D LZO_COMPRESS_BYTE) /* packet was compressed */
     {
        =
 ASSERT(buf_safe(&work, zlen));
-        int err =3D LZO_DECOMPRESS(BPTR(bu=
f), BLENZ(buf), BPTR(&work), &zlen, compctx->wu=2Elzo=2Ewmem);
+        int=
 err =3D LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), BPTR(&work), &zlen, NULL);
 =
        if (err !=3D LZO_E_OK)
         {
             dmsg(D_COMP_ERRORS, =
"LZO decompression error: %d", err);
diff --git a/src/openvpn/lzo=2Eh b/src=
/openvpn/lzo=2Eh
index bb9cc81=2E=2E3a8586c 100644
--- a/src/openvpn/lzo=2E=
h
+++ b/src/openvpn/lzo=2Eh
@@ -57,17 +57,6 @@
 
 /************************=
**************************************************/
 /** @name LZO library =
interface defines */ /** @{ */ /***********************/
-#define LZO_COMPR=
ESS   lzo1x_1_15_compress
-/**< LZO library compression function=2E
- *
- *=
   Use \c lzo1x_1_15_compress because it
- *   is described as faster than =
the
- *   standard routine, although it does
- *   need a bit more memory=
=2E */
-#define LZO_WORKSPACE  LZO1X_1_15_MEM_COMPRESS
-/**< The size in by=
tes of the memory
- *   %buffer required by the LZO library
- *   compressi=
on algorithm=2E */
 #define LZO_DECOMPRESS lzo1x_decompress_safe
 /**< LZO =
library decompression function=2E
  *
@@ -80,52 +69,6 @@
  *   using the no=
n-safe version=2E */
 /** @} name LZO library interface */ /***************=
***********************/
 
-
-/********************************************=
******************************/
-/** @name Adaptive compression defines */ =
/** @{ */ /************************/
-#define AC_SAMP_SEC 2                =
               /**< Number of seconds in a sample period=2E */
-#define AC_=
MIN_BYTES                                                                  =
    \
-    1000                                            /**< Minimum num=
ber of bytes a sample \
-                                                  =
   *   period must contain for it to be \
-                                =
                     *   evaluated=2E */
-#define AC_SAVE_PCT              =
                                                          \
-    5         =
                                      /**< Minimum size reduction percentag=
e \
-                                                     *   below which c=
ompression will be   \
-                                                   =
  *   turned off=2E */
-#define AC_OFF_SEC                                 =
                                            \
-    60                      =
                        /**< Seconds to wait after compression has \
-     =
                                                *   been turned off before =
retesting=2E */
-/** @} name Adaptive compression defines */         /*****=
**************************/
-
-/**
- * Adaptive compression state=2E
- */
-=
struct lzo_adaptive_compress
-{
-    bool compress_state;
-    time_t next;=

-    int n_total;
-    int n_comp;
-};
-
-
-/**
- * State for the compress=
ion and decompression routines=2E
- *
- * This structure contains compressi=
on module state, such as whether
- * compression is enabled and the status =
of the adaptive compression
- * routines=2E  It also contains an allocated =
working buffer=2E
- *
- * One of these compression workspace structures is =
maintained for each
- * VPN tunnel=2E
- */
-struct lzo_compress_workspace
-=
{
-    lzo_voidp wmem;
-    int wmem_size;
-    struct lzo_adaptive_compres=
s ac;
-};
-
 /** @} addtogroup compression */
 
 

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2328?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I189f3a311719b5c4476351702a44870d485d10d8
Ger=
rit-Change-Number: 2328
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--gsLFoOrtD2A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2328?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">comp: drop compression on send lef=
tovers<br><br>7f0214c9 (&quot;Remove support for compression on send&quot;)=
 left the LZO<br>compression workspace, adaptive compression state and rela=
ted defines<br>behind=2E lzo1x_decompress_safe() ignores its work memory ar=
gument, so<br>stop allocating LZO1X_1_15_MEM_COMPRESS bytes (256 KiB on 64-=
bit) per<br>LZO compression context and pass NULL instead=2E<br><br>Remove =
the now empty compress_workspace_union, COMPRESS_THRESHOLD and<br>D_COMP_LO=
W, probe for lzo1x_decompress_safe() instead of the unused<br>compressor in=
 configure, and update the compression module docs=2E<br><br>Change-Id: I18=
9f3a311719b5c4476351702a44870d485d10d8<br>Signed-off-by: Razvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
328<br>Message-Id: &lt;20261123143201=2E4058-1-gert@greenie=2Emuc=2Ede&gt;<=
br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg41831=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M configure=2Eac<br>M doc/doxygen/doc_compression=2Eh<=
br>M src/openvpn/comp-lz4=2Eh<br>M src/openvpn/comp=2Eh<br>M src/openvpn/er=
rlevel=2Eh<br>M src/openvpn/lzo=2Ec<br>M src/openvpn/lzo=2Eh<br>7 files cha=
nged, 29 insertions(+), 127 deletions(-)<br><br></pre>
<pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/conf=
igure=2Eac b/configure=2Eac</span><br><span>index 585c3bd=2E=2E05fa964 1006=
44</span><br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Ea=
c</span><br><span>@@ -1001,11 +1001,11 @@</span><br><span> 	have_lzo=3D&quo=
t;yes&quot;</span><br><span> 	AC_CHECK_LIB(</span><br><span> 		[lzo2],</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-		[lzo1x_1_15_compress],</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[lzo1x_decompress_s=
afe],</span><br><span> 		[LZO_LIBS=3D&quot;-llzo2&quot;],</span><br><span> =
		[AC_CHECK_LIB(</span><br><span> 			[lzo],</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-			[lzo1x_1_15_compress],</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+			[lzo1x_decompress_safe],</span><br><span> 		=
	[LZO_LIBS=3D&quot;-llzo&quot;],</span><br><span> 			[have_lzo=3D&quot;no&q=
uot;]</span><br><span> 		)]</span><br><span>diff --git a/doc/doxygen/doc_co=
mpression=2Eh b/doc/doxygen/doc_compression=2Eh</span><br><span>index efd18=
bf=2E=2E4c60e74 100644</span><br><span>--- a/doc/doxygen/doc_compression=2E=
h</span><br><span>+++ b/doc/doxygen/doc_compression=2Eh</span><br><span>@@ =
-29,31 +29,21 @@</span><br><span> /**</span><br><span>  * @defgroup compres=
sion Data Channel Compression module</span><br><span>  *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * This module offers compression of dat=
a channel packets=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * This module decompresses incoming data channel packets and adds</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * compression framing to o=
utgoing ones=2E</span><br><span>  *</span><br><span>  * @par State structur=
es</span><br><span>  * The Data Channel Compression module stores its inter=
nal state in a \c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * l=
zo_compress_workspace structure=2E  This state includes flags which</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * control the module&#39;s b=
ehavior and preallocated working memory=2E  One</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * such structure is present for each VPN tunnel,=
 and is stored in the \c</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * context=2Ec2=2Elzo_compwork of the \c context associated with that VP=
N</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * tunnel=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * compress_context structu=
re=2E  One such structure is present for each VPN</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * tunnel, and is stored in the \c context=2E=
c2=2Ecomp_context of the \c</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * context associated with that VPN tunnel=2E</span><br><span>  *</=
span><br><span>  * @par Initialization and cleanup</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * Every time a new \c lzo_compress_workspace =
is needed, it must be</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * initialized using the \c lzo_compress_init() function=2E  Similarly,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * every time a \c lzo_co=
mpress_workspace is no longer needed, it must be</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * cleaned up using the \c lzo_compress_uninit()=
 function=2E  These</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 functions take care of the allocation and freeing of internal working</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * memory, but not of the =
\c lzo_compress_workspace structures themselves=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @par</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * B=
ecause of the one-to-one relationship between \c</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * lzo_compress_workspace structures and VPN tun=
nels, the above-mentioned</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * initialization and cleanup functions are called directly from the \c=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * init_instance() an=
d \c close_instance() functions, which control the</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * initialization and cleanup of VPN tunnel in=
stances and their associated</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * \c context structures=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * \c comp_init() allocates a \c compress_context and calls =
the \c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * compress_i=
nit method of its \c compress_alg; \c comp_uninit() calls</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * the \c compress_uninit method and =
frees the structure=2E  Both are called</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * from \c init_instance() and \c close_instance(), and=
 when pushed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * opti=
ons change=2E</span><br><span>  *</span><br><span>  * @par Packet processin=
g functions</span><br><span>  * This module receives data channel packets f=
rom the \link data_control</span><br><span>@@ -67,25 +57,25 @@</span><br><s=
pan>  *</span><br><span>  * @par Settings that control this module&#39;s ac=
tivity</span><br><span>  * Whether or not the Data Channel Compression modu=
le is active depends on</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * the compile-time \c ENABLE_LZO preprocessor macro and the runtime flag=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * stored in \c lzo_=
compress_workspace=2Eflags of the associated VPN tunnel=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * The latter are initialized from \c =
options=2Elzo, which gets its value</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * from the process&#39;s configuration sources, such as its =
configuration</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * file =
or command line %options=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * the compile-time \c USE_COMP preprocessor macro and on \c</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * options=2Ecomp=2Ealg, w=
hich gets its value from the process&#39;s configuration</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * sources, such as its configuration =
file or command line %options=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * \c comp_init() creates no \c compress_context if no algorit=
hm is set=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The =
flags in \c compress_context=2Eflags, copied from \c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * options=2Ecomp=2Eflags, only adjust fr=
aming, option checks and which</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * algorithms are advertised to the peer=2E</span><br><span>  *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @par Adaptive compr=
ession</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The compress=
ion module supports adaptive compression=2E  If this feature</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * is enabled, the compression routi=
nes monitor their own performance and</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * turn compression on or off depending on whether it is le=
ading to</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * significan=
tly reduced payload size=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @par Outgoing packets</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Outgoing packets are never compressed, only framed so that =
the peer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * can pars=
e them=2E</span><br><span>  *</span><br><span>  * @par Compression algorith=
ms</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This module uses=
 the Lempel-Ziv-Oberhumer (LZO) compression algorithms=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * These offer lossless compression and=
 are designed for high-performance</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * decompression=2E  This module uses the external \c lzo libr=
ary&#39;s</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * implement=
ation of the algorithms=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * This module supports the Lempel-Ziv-Oberhumer (LZO) and LZ4</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * algorithms, as impleme=
nted by the external \c lzo and \c lz4</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * libraries=2E</span><br><span>  *</span><br><span>  * =
@par</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * For more infor=
mation on the LZO library, see:\n</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * https://www=2Eoberhumer=2Ecom/opensource/lzo/</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * For more information on these l=
ibraries, see:\n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
https://www=2Eoberhumer=2Ecom/opensource/lzo/ \n</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * https://lz4=2Eorg/</span><br><span>  */</sp=
an><br><span>diff --git a/src/openvpn/comp-lz4=2Eh b/src/openvpn/comp-lz4=
=2Eh</span><br><span>index 3d04771=2E=2E10dbe59 100644</span><br><span>--- =
a/src/openvpn/comp-lz4=2Eh</span><br><span>+++ b/src/openvpn/comp-lz4=2Eh</=
span><br><span>@@ -31,10 +31,5 @@</span><br><span> extern const struct comp=
ress_alg lz4_alg;</span><br><span> extern const struct compress_alg lz4v2_a=
lg;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
struct lz4_workspace</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int dummy;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* ENABLE_LZ4 */</span=
><br><span> #endif</span><br><span>diff --git a/src/openvpn/comp=2Eh b/src/=
openvpn/comp=2Eh</span><br><span>index 3f6411b=2E=2E4abf870 100644</span><b=
r><span>--- a/src/openvpn/comp=2Eh</span><br><span>+++ b/src/openvpn/comp=
=2Eh</span><br><span>@@ -132,11 +132,6 @@</span><br><span>  */</span><br><s=
pan> #define COMP_EXTRA_BUFFER(len) ((len) / 6 + 128 + 3 + COMP_PREFIX_LEN)=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Don&#39;t try to co=
mpress any packet smaller than this=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define COMPRESS_THRESHOLD 100</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span> /* Forward declaration of compression context */<=
/span><br><span> struct compress_context;</span><br><span> </span><br><span=
>@@ -167,26 +162,12 @@</span><br><span> #endif</span><br><span> </span><br>=
<span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Workspace=
 union of all supported compression algorithms</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-union compress_workspace_union</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_LZO</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct lzo_compress_workspace lzo;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 ENABLE_LZ4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 lz4_workspace lz4;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/*</span><br><span>  * Context for active compression ses=
sion</span><br><span>  */</span><br><span> struct compress_context</span><b=
r><span> {</span><br><span>     unsigned int flags;</span><br><span>     st=
ruct compress_alg alg;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    union compress_workspace_union wu;</span><br><span> </span><br><span> =
    /* statistics */</span><br><span>     counter_type pre_decompress;</spa=
n><br><span>diff --git a/src/openvpn/errlevel=2Eh b/src/openvpn/errlevel=2E=
h</span><br><span>index 5cea0ad=2E=2E62ec731 100644</span><br><span>--- a/s=
rc/openvpn/errlevel=2Eh</span><br><span>+++ b/src/openvpn/errlevel=2Eh</spa=
n><br><span>@@ -123,7 +123,6 @@</span><br><span> #define D_MTU_DEBUG       =
 LOGLEV(7, 70, M_DEBUG)  /* show MTU debugging info */</span><br><span> #de=
fine D_MULTI_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show medium-freq multi d=
ebugging info */</span><br><span> #define D_MSS              LOGLEV(7, 70, =
M_DEBUG)  /* show MSS adjustments */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define D_COMP_LOW         LOGLEV(7, 70, M_DEBUG)  /* show a=
daptive compression state changes */</span><br><span> #define D_CONNECTION_=
LIST  LOGLEV(7, 70, M_DEBUG)  /* show &lt;connection&gt; list info */</span=
><br><span> #define D_SCRIPT           LOGLEV(7, 70, M_DEBUG)  /* show parm=
s &amp; env vars passed to scripts */</span><br><span> #define D_SHOW_NET  =
       LOGLEV(7, 70, M_DEBUG)  /* show routing table and adapter list */</s=
pan><br><span>diff --git a/src/openvpn/lzo=2Ec b/src/openvpn/lzo=2Ec</span>=
<br><span>index 207cea6=2E=2Ef5ae776 100644</span><br><span>--- a/src/openv=
pn/lzo=2Ec</span><br><span>+++ b/src/openvpn/lzo=2Ec</span><br><span>@@ -35=
,7 +35,6 @@</span><br><span> </span><br><span> #include &quot;comp=2Eh&quot=
;</span><br><span> #include &quot;error=2Eh&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#include &quot;otime=2Eh&quot;</span><br><span>=
 </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span>=
<br><span>@@ -50,7 +49,6 @@</span><br><span> {</span><br><span>     msg(D_I=
NIT_MEDIUM, &quot;LZO compression initializing&quot;);</span><br><span>    =
 ASSERT(!(compctx-&gt;flags &amp; COMP_F_SWAP));</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    compctx-&gt;wu=2Elzo=2Ewmem_size =3D LZO_WOR=
KSPACE;</span><br><span> </span><br><span>     int lzo_status =3D lzo_init(=
);</span><br><span>     if (lzo_status !=3D LZO_E_OK)</span><br><span>@@ -5=
8,15 +56,11 @@</span><br><span>         msg(M_FATAL, &quot;Cannot initializ=
e LZO compression library (lzo_init() returns %d)&quot;,</span><br><span>  =
           lzo_status);</span><br><span>     }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    compctx-&gt;wu=2Elzo=2Ewmem =3D (lzo_voidp)mal=
loc(compctx-&gt;wu=2Elzo=2Ewmem_size);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    check_malloc_return(compctx-&gt;wu=2Elzo=2Ewmem);</spa=
n><br><span> }</span><br><span> </span><br><span> static void</span><br><sp=
an> lzo_compress_uninit(struct compress_context *compctx)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(compctx-&gt=
;wu=2Elzo=2Ewmem);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 compctx-&gt;wu=2Elzo=2Ewmem =3D NULL;</span><br><span> }</span><br><span> =
</span><br><span> static void</span><br><span>@@ -89,7 +83,7 @@</span><br><=
span>     if (c =3D=3D LZO_COMPRESS_BYTE) /* packet was compressed */</span=
><br><span>     {</span><br><span>         ASSERT(buf_safe(&amp;work, zlen)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int err =3D=
 LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), BPTR(&amp;work), &amp;zlen, compctx-=
&gt;wu=2Elzo=2Ewmem);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        int err =3D LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), BPTR(&amp;work)=
, &amp;zlen, NULL);</span><br><span>         if (err !=3D LZO_E_OK)</span><=
br><span>         {</span><br><span>             dmsg(D_COMP_ERRORS, &quot;=
LZO decompression error: %d&quot;, err);</span><br><span>diff --git a/src/o=
penvpn/lzo=2Eh b/src/openvpn/lzo=2Eh</span><br><span>index bb9cc81=2E=2E3a8=
586c 100644</span><br><span>--- a/src/openvpn/lzo=2Eh</span><br><span>+++ b=
/src/openvpn/lzo=2Eh</span><br><span>@@ -57,17 +57,6 @@</span><br><span> </=
span><br><span> /**********************************************************=
****************/</span><br><span> /** @name LZO library interface defines =
*/ /** @{ */ /***********************/</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define LZO_COMPRESS   lzo1x_1_15_compress</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/**&lt; LZO library compression funct=
ion=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *   Use \c lzo1x_1_15_compress be=
cause it</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   is descr=
ibed as faster than the</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *   standard routine, although it does</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *   need a bit more memory=2E */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define LZO_WORKSPACE  LZO1X_1_15_MEM_COMPR=
ESS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**&lt; The size i=
n bytes of the memory</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *   %buffer required by the LZO library</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *   compression algorithm=2E */</span><br><span> #defin=
e LZO_DECOMPRESS lzo1x_decompress_safe</span><br><span> /**&lt; LZO library=
 decompression function=2E</span><br><span>  *</span><br><span>@@ -80,52 +6=
9,6 @@</span><br><span>  *   using the non-safe version=2E */</span><br><sp=
an> /** @} name LZO library interface */ /*********************************=
*****/</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*****************=
*********************************************************/</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-/** @name Adaptive compression defines=
 */ /** @{ */ /************************/</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define AC_SAMP_SEC 2                               /**&=
lt; Number of seconds in a sample period=2E */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define AC_MIN_BYTES                              =
                                        \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    1000                                            /**=
&lt; Minimum number of bytes a sample \</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                                     *   =
period must contain for it to be \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                                     *   evalu=
ated=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define AC_=
SAVE_PCT                                                                   =
     \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    5          =
                                     /**&lt; Minimum size reduction percent=
age \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                                     *   below which compression will be   =
\</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
                                 *   turned off=2E */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define AC_OFF_SEC                         =
                                                    \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    60                                     =
         /**&lt; Seconds to wait after compression has \</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                        =
             *   been turned off before retesting=2E */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/** @} name Adaptive compression defines =
*/         /*******************************/</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Adaptive comp=
ression state=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct lzo_adaptive_com=
press</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    bool compress_state;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    time_t next;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int n_total;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int n_comp;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * State for the compression and decompression routin=
es=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * This structure contains compress=
ion module state, such as whether</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * compression is enabled and the status of the adaptive compre=
ssion</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * routines=2E  =
It also contains an allocated working buffer=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * One of these compression workspace structures is maintained for e=
ach</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * VPN tunnel=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-struct lzo_compress_workspace</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    lzo_voidp wmem;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int wmem_size;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct lzo_adaptive_compress ac;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> /** @} addtogroup compression */</span><br><=
/pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2328?usp=3Demail">change 2328</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2328?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I189f3a311719b5c4476351702a44870d485d10d8 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 2328 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--gsLFoOrtD2A=--


--===============4891225575512939100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4891225575512939100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4891225575512939100==--

