Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E885C55182
	for <openvpn-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NmeFJ2j6EZmAcpPme8eWjEKlWBUIkz5Vp0c9aWY0jsQ=; b=EAG7AXGkNwqr/dwc9wlUccopeW
	uoGTEQUgmz8y/KA9gNyRKwQMSH9KVkh9GKsFsP5ke9F/sL2+1Eh7BXqyaWLNY+dRhBJqYuzjkB3Sy
	Nu6vbNaZHj5R1jpAn34B4pOwcmHzKtcJHTEg3pGvdot5VmsQTcpFXkchTp9VAbj7Nrf0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wquJ7-0003CJ-UT;
	Mon, 03 Aug 2026 15:10:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wquJ6-0003C2-2X
 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 15:10:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=RmMLTiBEYuze0WGjqWymbO/WvMth3kPuU/W7B99dGCE=; b=QhbJHLjxrJW1OjkZK1wKuYqcDR
 RqDumFA1EhPG5GnU1RoUZIiCejQkQMDB9cnySD0xCiy0UeEoHoanuQKFivxlw15Me4TiWSvt24GZT
 3VsJSNpUkiBX/zP7MlmGZDh6IgOY40bd2+vMCwB4QgCPBLEbwdxGyEQ46fIaynI4HuE4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RmMLTiBEYuze0WGjqWymbO/WvMth3kPuU/W7B99dGCE=; b=M
 8dQWhAxexHbktm+ZvPR4f3TAX7PkrF9CuDs1TSYASRtKh6Ish7fDYFW2AM32a2IXYFBZ2GmjeBDyJ
 xj1tXONvnZnpL6xMSd5fSfRt/dajw08QLbudoJ/+f4G9hTb8xf60KDwg/doGFXHdAulDNDHRPvquK
 X+0bf/Vfd7eoTIEE=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wquJ3-000708-1O for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 15:10:23 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47fde295992so1118207f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 08:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785769814; x=1786374614; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RmMLTiBEYuze0WGjqWymbO/WvMth3kPuU/W7B99dGCE=;
 b=L0zNcloNapd22zxmM+yvgVNaLs5AbquzkkQfGOgxoGWQ/d8qTuCROu5D2cv4kX4z4H
 kISHVnd9yCTv74ZfmkzN1tF3I221HqMJVGgbVLXLaPKBD7Spew2W5mu2U6x5CdrL6O9t
 3SWyrSypaQxDH821waQR2yEWpUATMRywo0uetzyCVPHV61OSpiticlElpnIhPiMFXdie
 8h3mCI6usXi0uFz9rr+KuOlPaS0aANmwvB1qPYNn010rx6ZiwqfRc/3EVwDqbpwRr9ts
 YblHnnMZz/vckM+rQcydea836wGHp3gM89v7MnAaOOLetlNQNCKXM5hUt1NnADqt4rIF
 Ti5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785769814; x=1786374614;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RmMLTiBEYuze0WGjqWymbO/WvMth3kPuU/W7B99dGCE=;
 b=qjja4HmsMbhmMVPkTT27wmIe+f0RK8OeXZNCDiBDsRujmcu29XhbWdbv2elMk8RNqd
 BzQ6MrqL2hFNPAQokeE/wXsASr5+pZw4wAlxAoMwfvcFste3wKVvjeMJfZ2iOiCMALFp
 PQdl8akbsN+m7EwkmsLpxx/CfINZR784CPWNdE5XG/jHBrvZxzt2Gy8dHmgmLPvX+5fJ
 JEHqglmfHKgUQTmSSYc1nqpTOa7BGCURPVaIBT2qYlSSbxDrX1f1jldsfY0Ue71BILqc
 sR3K0MXdq8CwgeuLo+sOMG7F2rD+jv899yZPh9adOIyY2tyOJsKWW/MGorUTDDdkDyLl
 45EQ==
X-Gm-Message-State: AOJu0Yz1tJjdGMgS6ByZJxdLJq2paXFomuQk7uo41/tRhSlEUNtiieLQ
 hRxBqDvWJKtdd5yLNExwyFGsC++ZTHXJpoqtqGVd6GeS7hHQ9MeOMp5uI37h/3vvtMxkk7esMnp
 Y51JVoaIRap+wkV0FgO0MQ17dsFTN4C9fSDPUdZB/nHTNrYuNEhliLKUSo37YAp/+3ciXeaDk4c
 FMGCc7EA==
X-Gm-Gg: AR+sD11WxJLJXOkMH1UBqwmPeIgPPVp7KyP1IswsOcb2LfJ/fRS22EYk9rt6Kovs5Hn
 e0C7gGrFdeh13SoPLiBJQDricJHnJu2Ud+5AUAEb611WU5gEg/TlDMISSmXYVKaIfl6oEgy5AC2
 ZwENTUi9LvfSMKwPJGdZ/n6E8oEO0+CRU/PtjchlSEvpQ+UXalhsAbPNqnzKPkoHlxQgeR/VUv+
 Klos8sDCOr8R82INw0tdjqd43m8XHxSWETW7T2ykb3OXPrnrvP4GD17O2N8KJnOITxOnp2Qpigw
 tRQJP2I5KolVtIfm84ROnrHVKGLtSTfCvp+irWQCiJb6j9GdFnxp7kSowz+fMss1rdu22XjQwyO
 nExq23EDH0btgLvkzuMRnho73digcBZRK19fDHirkV5dO2YlCBCNGlWmaeJHze0P0tZR/yHmUnv
 HIGCImGNiRZkhVc5aDLjmyOpF2u0+8DFm7qCXInUffvpaUDVYA6HhPr9VWCQ35eJpqOo/PZxeIC
 lopYS5GoUz37f8zRZh1g8bMaNQQDGAJ80fYITVxCvksQNs0PwX0FTt78Wk2VvRcWrsMtTNCFEN7
 2sgUvmQ9GQEHRqCFuwWb6odvyzv+Ig9lH+wFvV9Og4NmhM3HqZZfPCFU+ycF13L5UUjOuJKrRA=
 =
X-Received: by 2002:a05:6000:4905:b0:47f:70f2:ccf6 with SMTP id
 ffacd0b85a97d-47fd725b349mr28754502f8f.6.1785769814286; 
 Mon, 03 Aug 2026 08:10:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1a58sm33679753f8f.7.2026.08.03.08.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:10:13 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 3 Aug 2026 15:10:11 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3
X-Gerrit-Change-Number: 1831
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1831?usp=email>
X-Gerrit-Commit: 1e8bc06b45f792230e2bea4643053a50fade344c
X-Gerrit-Comment-Date: Mon, 3 Aug 2026 15:10:11 +0000
In-Reply-To: <gerrit.1785402220000.Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3@gerrit.openvpn.net>
References: <gerrit.1785402220000.Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NDAyMjIwMDAwLkliMGU3YzlkM2EyZjRlNmI4YzFkNWE5ZjdlM2IyYzRkNmE4ZjFlNWIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e3943de44d3235645887709c7e062d9dae9ef195-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wquJ3-000708-1O
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Do not queue
 control ciphertext while a packet is still queued
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4533394293161071937=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4533394293161071937==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YQzLE+vad0U="; charset=UTF-8

--YQzLE+vad0U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1831?usp=3Demail )

Change subject: ssl: Do not queue control =
ciphertext while a packet is still queued
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 comment)

Patc=
hset:

PS1: 
I don't particulary like this change but it is more that the g=
eneral to_link handling needs to be fixed rather than the fault of this com=
mit=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1831=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib0e7c9d3a2f=
4e6b8c1d5a9f7e3b2c4d6a8f1e5b3
Gerrit-Change-Number: 1831
Gerrit-PatchSet: 1=

Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Comment-Date: Mon, 03 Aug 2026 15:10:11 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: Yes

--YQzLE+vad0U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 1:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1831?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1831?tab=3Dcomments=
&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">I don&#39;t particulary like this =
change but it is more that the general to_link handling needs to be fixed r=
ather than the fault of this commit=2E</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1831?usp=3Demail"=
>change 1831</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1831=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1831 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Mon, 03 Aug 2026 15:10:11 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--YQzLE+vad0U=--


--===============4533394293161071937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4533394293161071937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4533394293161071937==--

