Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075E0C44515
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 23:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x6pTA+jubZesN8/hWYRqRkhTkm4TV4jTLuK4WM0dW84=; b=DiHzD6Hp6DcqoZgu/HqoYyyrom
	hidVtVfPjsfXQ/H6TAghR2vdWTOVV2i217hGIgq+GcK8mqzaS9jRmmiELEsaOge4fHVpBkCcDqo0/
	3Gzum0Wn+GIOvJ7+cyP/viME9FzfYvyEU24ZZ99kBDQpaSEanoEK8RDisjrpfyZiLPu8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wlxGA-000835-9M;
	Mon, 20 Jul 2026 23:18:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wlxG9-00082y-39
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 23:18:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=RD2oa60wgqsU7UrZnmP2ekE1/0bczxT7S5u0V19DM+M=; b=ee1OoCwevpi9KMywfLlPK2dFwV
 tykp3/uRe4GP4dxMO58M2htP4OGbALsPWvPyZ5epg/QZxZrmNC8/xwi9UKp3X6rGov/n+S7yM7pn3
 iR9oVpR0TvPIRwZ3Gt+V/ytbQKkDzw8NlLzWET+EPRX9TQKct+CXpn0IvBMrE42UyXlI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RD2oa60wgqsU7UrZnmP2ekE1/0bczxT7S5u0V19DM+M=; b=A
 dxB5FWJMsc+8W/8EOumC7nJ6Gee962EQsrOHTvK325+6XRo7vQYzolGh4ZC4FMoKQY1Wh2DLEGrJ+
 0XRjbr8rdK2lu5OeTBzYiwCV86teq/JM0NFy1Df/8e+8lxllirC/bTSKpmuyeb/ORgEC/0J6vcVvM
 m84AEgvcgl0lX+LA=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wlxG5-0007NG-J9 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 23:18:50 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so81029325e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 16:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784589523; x=1785194323; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RD2oa60wgqsU7UrZnmP2ekE1/0bczxT7S5u0V19DM+M=;
 b=KzdsiP3SbfVeusCwuACuVJM+qWGSmQGKFzeKp0VJ28rjl0chLt93b3KWJvsqdtzi2v
 PmYTGkSRIeteZj6KNBGmSQ/iGCC++zSSaMugOW9ISnSGiNXjC2khWHkFBq0M49H0IiWh
 MZqazOtE5IrRATwUd0pTzDp2BHCSTsHEs2dtyFkVFHIosxaFO8GS4pNPma64cD0HmtiB
 vwI/UbgVYAqM7rxYkTJLiGJcax/qIzN0/fX/EKSkOn4fWSb6brjNHWAV6heGUl+nG+YS
 AZE7/pCSJlf3rUruYm6HCpMgBwvz3zdXdGRqG/htAVxMjlpZOPZjWDzT6wXSUBF903d0
 QOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784589523; x=1785194323;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RD2oa60wgqsU7UrZnmP2ekE1/0bczxT7S5u0V19DM+M=;
 b=ejvDm00iX8Xc8deosuLuEUvsPUb351L6Z1z3YrqB1HK5zNjqjgz6oz056urnEiy+45
 iw1uZdroQ2nLkPHZBVriz7Y/0g/BQ3wcZJhMS5nzwexnSUBSRvBdcmL4hCu5N1MRBYlJ
 VPh89kAv25Zgelr68czPrSHXabeR0+itg5aHXmV1uRHtq9Beom81GXJhOu/766kK8JBa
 VRZzjWSKcmTIHHTR9mE4y9sLKxSxHXNsqDhvKE3rD+Izlio66UOHCEyd6PrEwp8PdorK
 RaKBjqrAXRT/KSGoDcX1Nu3dNk03SZQd44QugXtRKba/WkTIBBHNNS8jbaMDT5OWfLBL
 BykQ==
X-Gm-Message-State: AOJu0Yz2q9SQ5iMIQByBrwPeEcukeGGb/Eo619uS9uoOfSs+JfmqrZtu
 E3y231Tk4XjqYt1OijP4HheFfkFaqs1uDnjfv5F/VDPDfE6uJqoEJ3/HXFht8uTpZPNudD4WnJ8
 urqKH60aT88fWu0ZHYu3Ayh3kATXA+1IWu8ZWyihCdLvVsCfT0zKTkfSlFa+sRwJfdys9CzcfBQ
 YUDAo8Ag==
X-Gm-Gg: AfdE7cksRR91urTlN2t4ueuNvXWhs9hlv0EuTLqlRj9yxBu8uTIZ45MAT517PYgr2Jr
 /XXHYXrfsrxccdKdTPnUlcZ9rPqEVCJTO6y/9XS3FpkLHI5d5+iAYZTWFH4igMQo+3RHtAz10Lj
 H4+7Px85rDnGuabt05FXsgACdwdv67zAfKHwwRTnbnQGYQie5gE+H8uBopZHd5MEN4EJjdbgcaC
 UNetmo6nicgtg6FejwY62eqGtaN027uSAwETOugEncigQB0ci0AXTX84NjFFNsPyJ2z38zSbCRX
 a0PE91Qo87SXd252GwECuNccAjDPfJyw3BcWjhz3CH+KKaelhdhJQhszuWfWyF8DE2grei9piRe
 fvf7wETKyafONU+JU0IQDivVfzOMjjaPjvdQHPFqa29DEgXq2hgHUEAOAL6UX0kapC5DKCj8/5P
 sdNByz5mgz18DIJXe3Zc8xay2ha6ftuj+s+rOEfpNnivm3Jpp4cQ7ERjK1vv4qSpGd8viVdasQh
 yQubWC2khv7Vr4qKt53hp6Rr8S993bdoU7Zoo/5ej7AwmizARzEDIAri8jMSJ13G2sDTRsIhZ7H
 eeA=
X-Received: by 2002:a05:600c:3b10:b0:495:4aff:5fce with SMTP id
 5b1f17b1804b1-4954aff609amr175790325e9.32.1784589522902; 
 Mon, 20 Jul 2026 16:18:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954aa1a231sm190289915e9.1.2026.07.20.16.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 16:18:42 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 20 Jul 2026 23:18:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
X-Gerrit-Change-Number: 1797
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1797?usp=email>
X-Gerrit-Commit: 0ce327878bdd991c5a45c1b08ed1bb593d477975
X-Gerrit-Comment-Date: Mon, 20 Jul 2026 23:18:40 +0000
In-Reply-To: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
References: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTg2MDY2MDAwLkk0MzRhNTM3M2Y3N2IwZjc1NzBhNmEyYWFmZTBlYWY5NzBlMmVhYmU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f7f3319039a009694730eb1e009471276b59d826-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wlxG5-0007NG-J9
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Enable TCP_NODELAY
 by default and deprecate --tcp-nodelay
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
 antonio@mandelbit.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4167693196981393855=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4167693196981393855==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YjnVSiPK04I="; charset=UTF-8

--YjnVSiPK04I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex=2E

plaisthos has posted commen=
ts on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
797?usp=3Demail )

Change subject: Enable TCP_NODELAY by default and deprec=
ate --tcp-nodelay
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 1: Code-Review-1

(3 comments)

Patchset:

PS1: 
I think it=
 is a good idea but I think we can clean up a bit more=2E


File src/openvp=
n/options=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797/comment/089b=
99ab_9a547c6b?usp=3Demail :
PS1, Line 7710:         msg(M_WARN, "DEPRECATED=
 OPTION: --tcp-nodelay is now the default and "
is enabled by default=2E


=
File src/openvpn/socket=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/179=
7/comment/f74cde81_10fbe178?usp=3Demail :
PS1, Line 1492:         sock->soc=
kflags |=3D SF_TCP_NODELAY;
Let's get rid of SF_TCP_NODELAY=2E And maybe th=
e whole socket_set_flags wrapper and just do:

if (proto_is_tcp(sock->info=
=2Eproto) && !sock->sockflags & SF_DCO_WIN)
   socket_set_tcp_nodelay(sd, 1=
)
   
to clean up the code=2E



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1797?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
Gerrit-Change-Number: =
1797
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ordex <antonio=
@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 20 Jul 2026 23:18:40 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: Yes

--YjnVSiPK04I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex=2E </p>
<p>Patch set 1:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1797?usp=3Demail">View Change</a></p><p>3 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?tab=3Dcomments&amp;us=
p=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">I think it is a good idea but I think we =
can clean up a bit more=2E</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797/c=
omment/089b99ab_9a547c6b?usp=3Demail">Patch Set #1, Line 7710:</a> <code st=
yle=3D"font-family:monospace,monospace">        msg(M_WARN, &quot;DEPRECATE=
D OPTION: --tcp-nodelay is now the default and &quot;</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">is enabled=
 by default=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/socket=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797/comment/f74cde=
81_10fbe178?usp=3Demail">Patch Set #1, Line 1492:</a> <code style=3D"font-f=
amily:monospace,monospace">        sock-&gt;sockflags |=3D SF_TCP_NODELAY;<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Let&#39;s get rid of SF_TCP_NODELAY=2E And maybe the whole socke=
t_set_flags wrapper and just do:</p><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">if (proto_is_tcp(sock-&gt=
;info=2Eproto) &amp;&amp; !sock-&gt;sockflags &amp; SF_DCO_WIN)<br>   socke=
t_set_tcp_nodelay(sd, 1)<br>   <br>to clean up the code=2E</pre></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1797?usp=3Demail">change 1797</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1797?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1797 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Mon, 20 Jul 2026 23:18:40 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--YjnVSiPK04I=--


--===============4167693196981393855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4167693196981393855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4167693196981393855==--

