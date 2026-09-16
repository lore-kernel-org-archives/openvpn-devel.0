Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EE1C982C9
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cXO+Jovn0GVjoh/mH+NTDng/c2ehu6D6XnmvLNieUxA=; b=LRCmWiCuN7gz9q6J5L1PJvLzvd
	YH/0fh6ChlaiekeRRO04iRbaGh0FQR0lj5g9LzSw+qjhNU1UhIHJqo4JyuC1bJWpcZ4ts8WsyF8e8
	P7M5EQfPCOYfFuoRVGr0dbhYx6PTP53KXNDCc3palS4E7QCRs8LOjJ1rdl4NJCyQib/k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6ri0-0002wH-Kx;
	Wed, 16 Sep 2026 15:38:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6ri0-0002wB-70
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:38:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2VnMjqMjslMRu36CUkkq1v1y91CxdxZXdUBHI4NJCdE=; b=cUWcoZeb672a3VQqQdpX6KbVzZ
 xhQ4PB0gt2R2gxl3uDKSEsQ9rxdpu+m0EavMM8+6drEFIV/lLH2DpSmeGq6XDcsCzNob6fwvxg3NU
 Qgii/RREsL84z8APKHk7o5n/iH+42PtrGleiMvE1Ax0ip/TQ52JnqEQcsYVQqjhxQPgU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2VnMjqMjslMRu36CUkkq1v1y91CxdxZXdUBHI4NJCdE=; b=Q
 lqUYP3yA6eg87SN0NT6JMEcA6p17EXstthlKAZQHuZxHgOsZRCqvQJSA2ZvfKewsgNp45JZHl/Nby
 bDs23x1cgMCHniuBBKBvdG7olR46DLz812AyTpN8//GQ4N2GVTv5MqIHXzEEplV3q3vJxsWXZJL5x
 dcIhaVuB0aHByIBY=;
Received: from mail-ed2-f35.google.com ([74.125.228.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6rhw-00006w-9O for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:38:04 +0000
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6a60591ae54so1916610a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789573073; x=1790177873; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2VnMjqMjslMRu36CUkkq1v1y91CxdxZXdUBHI4NJCdE=;
 b=eTLB5NvIN0ottSbQc2B1O2tn8Tdk91ldPOoryY1qmJYDOQgJIrjLxKlWrtWx2bM0nm
 S3ke8bB9wrgboHiVGRt+z66jaIszz7dsB2hz6S0xU9L7D7IEbc4Oa95JIbuSy5z/wrF3
 yaNkfE2Ge58M054yyq5wp0vLfYXXy7VgmrP5qtwEQghTngP3SBNtrnqjhhnXpOH8OClu
 b0Guu3DCqkko8zXzbgDfuXPr3xVUFkmPLK9p0RStdz+lcV2v/SyGkCE883T+j+DU4Ii8
 9Y7BmlENCCRAcGPiYIq5mREVx4sFz3x7oqWe+gWazpTvJaBY3K0KVqo/UyMbrDB13Fc6
 LJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789573073; x=1790177873;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2VnMjqMjslMRu36CUkkq1v1y91CxdxZXdUBHI4NJCdE=;
 b=aLlmngR67QZuPPPn+U98A7osaiENrFargk+5fYKqNWXki2RWw17MIL1pt6uWJ52U2V
 UA6NgQaefu5IMmA7tpsa518Ioq2i8TPyRLbXYoFWWTx2zus202rX49qNYcVTY4XogE8N
 2b5QQMmcgrb/q7TvsEp900l0y/YB0LpVmQAxLvSlG20vZo+ufU51oTGJNN5hHiNH38eI
 a2JRfenGDe4KUz/OI7qWqqedA1Kwqq84sqWb7/8iMyy2x80DP0vMRryNlsQAQEYQ0EPm
 VTOdJItLhVQTySfwFwJNYHrMg0aWm61fgGzd2yKbhWWF5h1HhgWD5PL/QOhHgvq15Oqt
 +dIA==
X-Gm-Message-State: AFuF++kHorbXOcVcRiqDdNHVYEPyXx4Ihvs3Dlc7McoetHAJ8sF3KMha
 O5KfPtaJAxjh/pJfTukPbxNE/eknQ/YxU+icLB+h/AriAMpM+yBFxj9KyTrRTopkBG8141s0ft9
 7YD+LRIzqaJktvntv9Mmxqw/YB+F4s3pfJExXHz8T6ZT0Vrin+m2UXmcQCzyvDWiUdLEkvQGkN5
 jnvUgsTw==
X-Gm-Gg: AYBFou1l0D1dUs5ohe/m5zl8uwnXWiiNV7bCzdKaa0oLUuUXzzSIe/Sa15NJGJjp+qn
 Cw3jVYDv8OVRG8lgaq1sp4ZQPwReYrtnzLK5wmavOQzDZLCuXydB60px1x+uqoXD5YfeoU7JnJ+
 HO9OH0+8O2iXIAjqckHV2wvYAucESU4iPC1u7yCmkf8AFZraoZTLSQe7/zAU4xIGKzbBRTQNFsS
 jT/Tgx2a4ASRbrIuY7GagK6vOT92zM++b/P1Px317st+1bg2n7RVKP+yrUgWdiz1tIujJH6+Sdi
 XCuPx4xKv2kmjqpoAvIxJjnZO2IH0SFThAprDZFTq5gioyppRH5VNu/dJDQLGOEuM8/Vh3eoEKf
 1CoC6HyNk8k/Yf5ytX0/Srp0eQVG+AcyNDbjvLau3KHM3KNTtWjga7BzCa1NyLzs8lvX4ZuSk3g
 BNj2A8YJmv2RgQRNiyJq9hDRj6qTmL8Kjk8pZxLxeXaJDzXOzDQzEBGp0aZ3WnwT5/mm//LdzaI
 L9wyW4sVv+Cr5sFikI2Gj4CbKY2knoo2D93Wn9Si/vECKFdNd+fyKuoUvlztZg8hxTDe9g7imml
 ido0E4mUVvQ1JJzFvS7agYHMIvyqbyOj6G55RjMHD1scjdsl5jrY5wGlyIxV0w==
X-Received: by 2002:a05:6000:4301:b0:487:1266:628c with SMTP id
 ffacd0b85a97d-487126662c1mr337520f8f.2.1789567986537; 
 Wed, 16 Sep 2026 07:13:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bef7642sm7015164f8f.5.2026.09.16.07.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 07:13:06 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 14:13:04 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0
X-Gerrit-Change-Number: 1918
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1918?usp=email>
X-Gerrit-Commit: 6e48e34d118139a04976cd29a1e1400a2d58d06e
X-Gerrit-Comment-Date: Wed, 16 Sep 2026 14:13:04 +0000
In-Reply-To: <gerrit.1789560307000.Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0@gerrit.openvpn.net>
References: <gerrit.1789560307000.Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTYwMzA3MDAwLkliZjcyMzhiYWRlMmFlZDgxYWM3ZmU0ZmRhMmFmNThlMDkxZGM4Y2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <10a8dbbb3fa12d4988140e6d0c7d8358a9e4e82f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6rhw-00006w-9O
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Improve auth token
 related comments
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7619807530967318824=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7619807530967318824==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uqf1t4HIWAY="; charset=UTF-8

--uqf1t4HIWAY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1918?usp=3Demail )

Change subject: Improve auth token related comment=
s
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1918?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib=
f7238bade2aed81ac7fe4fda2af58e091dc8cd0
Gerrit-Change-Number: 1918
Gerrit-P=
atchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Comment-Date: Wed, 16 Sep 2026 14:13:04 +0000
Gerrit-Has=
Comments: No
Gerrit-Has-Labels: Yes

--uqf1t4HIWAY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1918?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1918?usp=3Demail">change 1918</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1918?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibf7238bade2aed81a=
c7fe4fda2af58e091dc8cd0 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1918 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 16=
 Sep 2026 14:13:04 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
=

</body></html>
--uqf1t4HIWAY=--


--===============7619807530967318824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7619807530967318824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7619807530967318824==--

