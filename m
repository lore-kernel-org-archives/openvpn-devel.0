Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD162606A32C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Q/wb052h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ax2ruKzE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kkv5u4ov;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SH5xAc3f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yeWEbnZQ1xlWhnrG6IjKW+QQHHyzRugsGixJyQ1JE38=; b=Q/wb052hulwaCdBz5rLW86LHzF
	eYtApkRMnTPAEn6bTEC3Ql95+r645g1EFvGUQRWKZ0jJYslHBHyMB4lrZbOIgjmd1121nKkYKS5PX
	MshtJPhrzZ0wrg/64LeZWQ2ONDM3IUx7K8UFSB5shO5oAgsY7HTgGG2hU2h3ZL5sAbto=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTNHi-000000006dN-2F1u;
	Tue, 17 Nov 2026 17:47:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTNHh-000000006dF-3le7
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:47:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B/yIqUCexJYYFKMTnfeeWcmqUV4ABq6CdigKx4GveQg=; b=Ax2ruKzENFpsbw/hNhG4vXbg+9
 kB3OXqaDYtJdGnM0SuHfoZ7Ex29Q9sfCrjD/8aY9ytEBfToyqY8Oy9bb8I159mdrVulR7b+l7pYj9
 PbL0r285hLcqFNcnv0bShRnha76X48WGUrR7BYN33c8ftBGWbl7+UPml3oDJ63eFIS4I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B/yIqUCexJYYFKMTnfeeWcmqUV4ABq6CdigKx4GveQg=; b=kkv5u4ovfB9rHeo0qWNCbIMYIt
 RkZPKmJelp+0n29v98KH66EHcMZEGSc+wdYf+JIr1IEn0kK9CkhZh1UP804opasXcwXxl+F5pKqiM
 rZqji5oo1nl7Xa3hrCRinXISSLLZ+n+jKlpA0REL82iltiA1pz3MII9NOjmn1tBMlvo0=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTNHg-00000000571-08mh for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:47:57 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so9137115e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794937669; x=1795542469; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B/yIqUCexJYYFKMTnfeeWcmqUV4ABq6CdigKx4GveQg=;
 b=SH5xAc3fdv+se/MMw7yf/j3aA1r3zGPyubw1jnkY/7rv3oqgEcwtwjREbsoDpXsftH
 WjPTH3beSKBWr2f/Ocr/hXKemo58ZECi2h6QiY/UkJMWUUXMbfeeeHtctobrBEu/4vSr
 SAGcItt/fIk0PE/3wC7tg92N6qmLq9X2cSBJU0m4YCSVSonjhFIcWP+ptmrkCcNgUNvb
 llnexwBpGsblOezNmw8E8tnGS3hbDb+NHB2cLm3xtFGFc5A3WDP/57tX7oQwRvSk+jD0
 94ScShyjG0k/P2sp2+egX7HGYLmxir/EwiAHTOnEkqH9GOsezZR2jjmaQQNrayys8C0C
 OMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794937669; x=1795542469;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=B/yIqUCexJYYFKMTnfeeWcmqUV4ABq6CdigKx4GveQg=;
 b=2DoKmLV4W12R3Uj4TckQB56dxmlW3ElYE0Icqc82ZQONJTAnoI63q4SmH+pS3nzze0
 Gq22W2FSQ3PkTKk9nsStTXNtnEsc9ZgI2J3V98/35J55RwtcmwZQmb8bqVmRU8pitILl
 rAvZscoO1eg0ducB8J0UFbfzY+gqAk+4kgHwfDj0lkkaN0u+b7pm38012XB+k8C5HyCJ
 UUnF6a0KJazckwLVCQxHw5SZITKjZkH4vmCiekCAi3LXHnu8llw7lWu9cZI35CWnXtEN
 ibAPEpjRsOJPGuOFVL0eO2YLChPpUpbjPxLe+M99gF8sZ2ua/QB/T8Qc8Oiizg1AUS0q
 PTBQ==
X-Gm-Message-State: APuU4Z+G1O6D39Dar64xIFjq1jEH2170nrLyZEw47mojux+EyGwsFqK4
 zOGo9Hl03lWXPsJ7mw0aTuoBwa6qtjVKfNr4egTqI3Dp9QC5xmTga+FJEVdweNJ8dE9kuQJQJbR
 KThd4f5qAMzypl8zLgoTmUJ4HZ6NM2rjEG1IcDqAWb3I4rz5RIsL13xNXrjvACQom6Ccp
X-Gm-Gg: AYBFou0/CfjYAQvRQ/t/DAU1SQ/K608m+eohe1e3eTGXLMUG/JSxoPXDeCTamUfRAAR
 8rTSULGpQ3UtPyhWzHg6Al+DpGP8YOGBS88bV8y/GCHmmYVfEileD/ijMNYHPSf/RJZ2QK0a77p
 LTlnqlWQ/9e+r9y+3JzSZdQ4qxIwydjlTAJWwyns3KENT4Tx7mfMlAS+tvo7DPNhQV/yqx16pJK
 F+KllcORU/CYtSkRvVHw1NXfFzYKEgK6XfhpnbBObUMS0UCr/S/xHA4/TQXv4aXI+xwUFuL2k00
 Ly40UO/LOGF08S9ZSSiuurPvXhnAq5gY8Rovaruh3uLfetfm9hbK2kRwyp518SYcqaCFRONCFax
 c5hiA9a/y5DdnIHzuVNNZOG3Peg5QBEBl4pysdYiJ1JkzRMI09kPWLx0rcgjLe37bsGEGXw8o/Q
 +YNt/NdY8t0jSJl435CodD7MVzgAKGai0kdSwQOV98+jBoqslbAKhmzp0rOFsZD2KY8tVm+q+Pe
 YkmZ5Kdz+Wk6T+6omiOL9hiyTRcWmlPYCAcBteK2lsp7pPvfPehof+etOyrdjL31bErfnhtyV10
 0xZ6IyjDQJAVDz0rMp1RyhlQ5FpONa4My4Ig45Ku4v5m1SkAY2bVw7DX3jlab2vq8IHMdwCNQnQ
 8Kvk3DjJrjYST+TIfUyLOQp+u8B+CUN39MrwGd3fc5PiR5pW5lyEY9BFzIDFeJhiHeNJknhEHoj
 Fnh4Af4ziYBd5DxJd/7K5FY2OlavYtlJiQZC9F
X-Received: by 2002:a05:600c:b99:b0:4bb:5d38:259f with SMTP id
 5b1f17b1804b1-4bb7838bdaamr73949155e9.12.1794937669327; 
 Tue, 17 Nov 2026 09:47:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7843bd79sm80249775e9.14.2026.11.17.09.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:47:48 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 17:47:48 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c
X-Gerrit-Change-Number: 2214
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2214?usp=email>
X-Gerrit-Commit: c19bdda311b56048c2de66d827c09eb3a255019e
In-Reply-To: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
References: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTM0OTkyMDAwLkkzMzEyM2ZlNjIxNTEyMzc2NDEwNzY1MDMxZmM5YWU2OGNkZDkxYTZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <63d80479d4baf96d7196f54edaf626399c372f80-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTNHg-00000000571-08mh
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_openssl: fix
 -Wsign-conversion in tls_ctx_set_tls_groups()
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
Content-Type: multipart/mixed; boundary="===============1022915572427042384=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1022915572427042384==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gEKIIDfOjbQ="; charset=UTF-8

--gEKIIDfOjbQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2214?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: ssl_openssl: fix -Ws=
ign-conversion in tls_ctx_set_tls_groups()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_openssl: fix -Wsign-conversion in tls_c=
tx_set_tls_groups()

Since 7d46ff17 dropped the -Wsign-conversion pragma, L=
ibreSSL and
AWS-LC CI builds fail: their SSL_CTX_set1_groups() takes a size=
_t
length, but glistlen is an int=2E

The buildbot LibreSSL builds pass bec=
ause the headers also define
SSL_CTX_set1_groups as a macro, and clang supp=
resses warnings in
expansions of system header macros=2E CI includes the li=
braries with
plain -I, so their headers aren't system headers and the warni=
ng fires=2E

OpenSSL 1=2E1=2E1's macro passes the length to SSL_CTX_ctrl() =
as a long,
so add openssl_groups_len_t to pick the type per library=2E

Cha=
nge-Id: I33123fe621512376410765031fc9ae68cdd91a6c
Signed-off-by: Razvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214
Messag=
e-Id: <20261117172524=2E11381-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41565=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
openssl_compat=2Eh
M src/openvpn/ssl_openssl=2Ec
2 files changed, 9 inserti=
ons(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/14/2214/3

diff --git a/src/openvpn/openssl_compat=2Eh b/sr=
c/openvpn/openssl_compat=2Eh
index 8309cee=2E=2Eae182d2 100644
--- a/src/op=
envpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -61,6 +61,=
14 @@
 typedef uint64_t openssl_opt_t;
 #endif
 
+/* SSL_CTX_set1_groups() =
length: size_t in LibreSSL and AWS-LC, passed to
+ * SSL_CTX_ctrl() as long=
 by OpenSSL 1=2E1=2E1's macro */
+#if defined(LIBRESSL_VERSION_NUMBER) || d=
efined(OPENSSL_IS_AWSLC)
+typedef size_t openssl_groups_len_t;
+#else
+type=
def long openssl_groups_len_t;
+#endif
+
 
 /* Functionality missing in Lib=
reSSL before 3=2E5 */
 #if defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VER=
SION_NUMBER < 0x3050000fL
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/op=
envpn/ssl_openssl=2Ec
index 30ef383=2E=2Eb95de8e 100644
--- a/src/openvpn/s=
sl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -535,7 +535,7 @@
     A=
LLOC_ARRAY_CLEAR_GC(glist, int, groups_count, &gc);
 
     /* Parse allowed=
 ciphers, getting IDs */
-    int glistlen =3D 0;
+    openssl_groups_len_t=
 glistlen =3D 0;
     char *tmp_groups =3D string_alloc(groups, &gc);
 
   =
  const char *token;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2214?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I33123fe621512376410765031fc9ae68cdd91a6c
Gerrit-Change-Number: 2214
=
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>

--gEKIIDfOjbQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2214?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">ssl_openssl: fix -Wsign-conversion in tls_ctx_set_tls_groups()<br><br>S=
ince 7d46ff17 dropped the -Wsign-conversion pragma, LibreSSL and<br>AWS-LC =
CI builds fail: their SSL_CTX_set1_groups() takes a size_t<br>length, but g=
listlen is an int=2E<br><br>The buildbot LibreSSL builds pass because the h=
eaders also define<br>SSL_CTX_set1_groups as a macro, and clang suppresses =
warnings in<br>expansions of system header macros=2E CI includes the librar=
ies with<br>plain -I, so their headers aren&#39;t system headers and the wa=
rning fires=2E<br><br>OpenSSL 1=2E1=2E1&#39;s macro passes the length to SS=
L_CTX_ctrl() as a long,<br>so add openssl_groups_len_t to pick the type per=
 library=2E<br><br>Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c<br>=
Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2214<br>Message-Id: &lt;20261117172524=2E11=
381-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg41565=2Ehtml<br>Signed-off-by: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/openssl=
_compat=2Eh<br>M src/openvpn/ssl_openssl=2Ec<br>2 files changed, 9 insertio=
ns(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/14/2214/3</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh</span><br><span>i=
ndex 8309cee=2E=2Eae182d2 100644</span><br><span>--- a/src/openvpn/openssl_=
compat=2Eh</span><br><span>+++ b/src/openvpn/openssl_compat=2Eh</span><br><=
span>@@ -61,6 +61,14 @@</span><br><span> typedef uint64_t openssl_opt_t;</s=
pan><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* SSL_CTX_set1_groups() length: size_t in LibreSSL and=
 AWS-LC, passed to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* SSL_CTX_ctrl() as long by OpenSSL 1=2E1=2E1&#39;s macro */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(LIBRESSL_VERSION_NUMBE=
R) || defined(OPENSSL_IS_AWSLC)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+typedef size_t openssl_groups_len_t;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+typedef long openssl_groups_len_t;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> </span><br><span> /* Functionality missi=
ng in LibreSSL before 3=2E5 */</span><br><span> #if defined(LIBRESSL_VERSIO=
N_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &lt; 0x3050000fL</span><br><sp=
an>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</=
span><br><span>index 30ef383=2E=2Eb95de8e 100644</span><br><span>--- a/src/=
openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</=
span><br><span>@@ -535,7 +535,7 @@</span><br><span>     ALLOC_ARRAY_CLEAR_G=
C(glist, int, groups_count, &amp;gc);</span><br><span> </span><br><span>   =
  /* Parse allowed ciphers, getting IDs */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int glistlen =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    openssl_groups_len_t glistlen =3D 0;</span><br=
><span>     char *tmp_groups =3D string_alloc(groups, &amp;gc);</span><br><=
span> </span><br><span>     const char *token;</span><br></pre><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214?usp=3Demai=
l">change 2214</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2214?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2214 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
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
--gEKIIDfOjbQ=--


--===============1022915572427042384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1022915572427042384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1022915572427042384==--

