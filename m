Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB768606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WL5r66Ne;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RuZHLTSW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PfHYHYO5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EBKPCLMD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Uyk4K8zn0+3KxWyI7hqhyDKPyt+IrzWq3b3iX6UaE10=; b=WL5r66NeulOrHm+U/nj1kekAdo
	Mozrg+8LJnX5IqU67xsNHJVvSeswuGjU1x8N4me9LF8YWaMsMSpZ1rdm4J1bfPNjIETB15anYGxoj
	kXgz6hFf2pQjDVbBYLnUSokg4aPImb4A2czJRkGz7jFEGlK7oA3OwshS9dNAW3gHuM18=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLNkL-000000002jN-0pIp;
	Mon, 26 Oct 2026 16:40:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLNkJ-000000002jE-0Nkm
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 16:40:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nl/rpDyCszCrPWL9eLZ7wTTiDSeJPOJWBNjb79pzQrA=; b=RuZHLTSWu/PVfQobM86NIDxgd4
 8vMeObSCR7XgTlyXrCuy0V7PQN9+0rMmNiLDb1CS6h5uxJ2+xBVUg8YxuLeKTyEzJiGxp0BUX+rXl
 0HgDby670+ItZC9tJ8UE9YLNvPX47hMSJIOmYXRdSM6E9h4jvig1567Wk6jGhtm7sB5I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nl/rpDyCszCrPWL9eLZ7wTTiDSeJPOJWBNjb79pzQrA=; b=PfHYHYO5HmivEyC5LuoP353d8S
 3SBte2U9LI4UkGInbLgAbgqp/howr3uvyNmlDDTEyjAgoAyYLPdYKhybci9jMRDn1ngKVIc0Y5YIC
 /PDzpFyA8aB/FmXYMsYvXtheFPpMAHx3zo9dCiSuT2GVWsi+NUMQ9/2RknGpP3/Msq3w=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLNkH-000000006x9-2gMK for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 16:40:27 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so2411373f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793032819; x=1793637619; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Nl/rpDyCszCrPWL9eLZ7wTTiDSeJPOJWBNjb79pzQrA=;
 b=EBKPCLMDLq3v4i2ARSfq44m2Rdns5FS7E/EffkSBaHLhQNfZ6bApbT/KBE4PRzJMof
 75MpUtZXAUCM2ytyWQARMqJtkeU0iIELleOBgFNig0GhFv3RhwGULVI/VqnjRvOB0e2U
 lLTemUe3eOFSrjATz8hMdEU7j59YxauOwNF1jluGFkaWVL69TEYr7nvDD/rSvmJ4kGk7
 hHNFwCVE9EVVJ+CKBKte8PHzRLyPSl7h3Tf8M112ZB600+wVgJpQTvUwLxwMpw0ArW+j
 e1Q3uDmzVsZat7Ba4eWeBq5QfI7syZlTLCmJr46Ajk6//23+kbpd7llmLSq4stjjQg8Z
 Yz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032819; x=1793637619;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nl/rpDyCszCrPWL9eLZ7wTTiDSeJPOJWBNjb79pzQrA=;
 b=Ia1l6F1cI0dY1y3AoJlFadiY+bbGWtdmvinUs98ab24W95GD7/Zp7dZg1Eqn8pocNL
 vBXTvjpJeB/txV5hZxU1ObK4NVedzqqDcIMDqvf8DNecu4kZZSgqIZ2HAL3yID+Bktsb
 QU7cwmiK/cTRH9qqOP7tudZC+DEY9BEqHJ/OxiSV0RTl52bJliMxTDLcmX+IlqiYYcfF
 R1WVeqsTo9TPg3+8pE+74BAs8KeAnLpcPxhHngLoPEelZFJ/Afc4HZKqrmKIQxPeCMHM
 WcL3H9VgmgHJF1eDYUeG0k7oaX7/1foC4d9uLClx22ulngRfMSY+voVBBXBOY8jGSJgW
 ksdA==
X-Gm-Message-State: AFq9FYIPi/rG2PnogbJH7CKQ1awEKj6xMo+i7uH6kxHvFzvC0hpdp+fS
 RvuHmGlehdMjJCGfyAOb3R34/PSkw1GEF06y/qau6PmysDS8vsJgZX2qPAMDtLRxVJVzOKcZl/T
 VSPD68+uM8ZA2B9k7uIv5NZM8j/0ajmXFzyYmEpw5MnVpYU0ezmHhDpXSJ0bo9tMWzEoBwvMAyW
 60p1k7cg==
X-Gm-Gg: AYBFou3O5kE2KM7u69HpBBkP35yQtq79jaZBIx3BGA2LJ10Yo9jMe5gRRxklPiwLSrK
 y29DceBLGy6csaP/omJp0q/E1S4tS7LaTQJLMf2nNZhlf5aP/5JXZCTd0fCfAEX2TtRQ8ij4Eze
 0PTNPNjH88FRboyXap7mzZWstT8M+9mmHWudwz1fziwPPfIsRAdn2aM3NXQKTmHiI7QhQr3bfwX
 N3oPjcGLmWHPtr32SgGw4Y28FtTZl4/Ur+Uqh5H6KcQ9ihtkLmQQhFH2fJnIphXnAmL1Qep3tSK
 VSaMmRN/Tg9yhar6kgZ/VIX2jJ+FKEO4+Lbk9NEdPZ4gJLugIeIVMcDe76DQ6NGvvufPWpCPJgA
 nIQ48HMZWC+tXXB4WDUxm5XV7DzqKgwiDQM/R9UDlBlDg9gQ5+yxz7zOuqXz3jnGr/omKGZ0LoV
 A04FCY2VGDFcXYuCDPa+v8WzTMMmVjoO4jyoxFCeWdYxdrg2QNzLqhundh9HpsY4SBOQsB7vqDU
 KJJxpZFR8McTZvzber0NmfHa9gbmHcftjYJlNrHoBxPDyYbZJ44dM6PILn32r9u+J3U3zCN3XBR
 SCrCjUMxdaEwy27V/SAo5b6gTN7R+IWSZTaEfUUJhf/Ka5pREhPhePonuiuPY0+AfZvuju5S3IJ
 32gsrt3NQcz7tGUa9gWP6+CESLeGZebsXscTbRSw7rrbWTgtoD4DbWeCHGm1hFv0=
X-Received: by 2002:a5d:44cc:0:b0:48e:23e1:35ec with SMTP id
 ffacd0b85a97d-48e3eb9c203mr9798988f8f.47.1793032818698; 
 Mon, 26 Oct 2026 09:40:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd39a9sm17695441f8f.46.2026.10.26.09.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 09:40:18 -0700 (PDT)
X-Google-Original-From: "Laptops (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 16:40:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib8f602f1fa27140e4938fea273b58de5fdfbbebf
X-Gerrit-Change-Number: 2036
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2036?usp=email>
X-Gerrit-Commit: 33a6b60d5c41af61e39f6fbad4d0a95db278f76c
References: <gerrit.1793032811000.Ib8f602f1fa27140e4938fea273b58de5fdfbbebf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDMyODExMDAwLkliOGY2MDJmMWZhMjcxNDBlNDkzOGZlYTI3M2I1OGRlNWZkZmJiZWJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <41c7747539f85bdb1ac8257096d1045c3d49533e-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLNkH-000000006x9-2gMK
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: build buffer.c
 with -fbounds-safety on macOS
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Laptops \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: jeff@incrediblybased.co, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Laptops \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1663187559667217929=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1663187559667217929==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A8wNyjtgm5U="; charset=UTF-8

--A8wNyjtgm5U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2036?usp=3Demail

to review the following change=2E
=


Change subject: GHA: build buffer=2Ec with -fbounds-safety on macOS
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: build buffe=
r=2Ec with -fbounds-safety on macOS

Pass --enable-fbounds-safety to config=
ure in the macOS jobs, so that
the -fbounds-safety annotations in buffer=2E=
c and buffer=2Eh are compiled
and checked by Apple clang in CI=2E

Change-I=
d: Ib8f602f1fa27140e4938fea273b58de5fdfbbebf
Signed-off-by: Jeff Bindel <je=
ff@incrediblybased=2Eco>
---
M =2Egithub/workflows/build=2Eyaml
1 file chan=
ged, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/36/2036/1

diff --git a/=2Egithub/workflows/b=
uild=2Eyaml b/=2Egithub/workflows/build=2Eyaml
index 27f08df=2E=2Ee32be71 1=
00644
--- a/=2Egithub/workflows/build=2Eyaml
+++ b/=2Egithub/workflows/buil=
d=2Eyaml
@@ -267,7 +267,7 @@
       - name: autoconf
         run: autoreco=
nf -fvi
       - name: configure
-        run: =2E/configure --enable-werro=
r ${{matrix=2Econfigureflags}}
+        run: =2E/configure --enable-werror =
--enable-fbounds-safety ${{matrix=2Econfigureflags}}
       - name: make al=
l
         run: make -j4
       - name: configure checks

-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2036?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: Ib8f602f1fa27140e4938fea273b58de5fd=
fbbebf
Gerrit-Change-Number: 2036
Gerrit-PatchSet: 1
Gerrit-Owner: Laptops =
<jeff@incrediblybased=2Eco>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--A8wNyjtgm5U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Laptops would like Arne Schwa=
be to <strong>review</strong> this change=2E
</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2036?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">GHA: build buffer=2Ec with -fbounds-safety on macOS<br><br>Pass --en=
able-fbounds-safety to configure in the macOS jobs, so that<br>the -fbounds=
-safety annotations in buffer=2Ec and buffer=2Eh are compiled<br>and checke=
d by Apple clang in CI=2E<br><br>Change-Id: Ib8f602f1fa27140e4938fea273b58d=
e5fdfbbebf<br>Signed-off-by: Jeff Bindel &lt;jeff@incrediblybased=2Eco&gt;<=
br>---<br>M =2Egithub/workflows/build=2Eyaml<br>1 file changed, 1 insertion=
(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/36/2036/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=2Egithu=
b/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml</span><br><span=
>index 27f08df=2E=2Ee32be71 100644</span><br><span>--- a/=2Egithub/workflow=
s/build=2Eyaml</span><br><span>+++ b/=2Egithub/workflows/build=2Eyaml</span=
><br><span>@@ -267,7 +267,7 @@</span><br><span>       - name: autoconf</spa=
n><br><span>         run: autoreconf -fvi</span><br><span>       - name: co=
nfigure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: =
=2E/configure --enable-werror ${{matrix=2Econfigureflags}}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        run: =2E/configure --enable-=
werror --enable-fbounds-safety ${{matrix=2Econfigureflags}}</span><br><span=
>       - name: make all</span><br><span>         run: make -j4</span><br><=
span>       - name: configure checks</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2036?usp=3Demail">change =
2036</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2036?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ib8f602f1fa27140e4938fea273b58de5fdfbbebf </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2036 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Laptops &l=
t;jeff@incrediblybased=2Eco&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--A8wNyjtgm5U=--


--===============1663187559667217929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1663187559667217929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1663187559667217929==--

