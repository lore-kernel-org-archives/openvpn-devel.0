Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7688C43327
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T/Xu/pnpbJhG2ftbMDni3hWLc2kIRxK5xV+KxZGWM+Q=; b=jjg9x8VbFfqZoVcXWjQXAwGMDz
	VuCDdVSEk6kSyekLXpCc3DJ8myNk96sE/mnSAWecrHUnyWRiqNxdS2AF4Jj3oi2BAH3dlXrZ68ArL
	lUuaZLK2AUSZty3OrMZ4dOisZkoRzaySaLtaD2QFIeMh7T/mkkMQBBej9nYIf8G7Osso=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wepZa-00027n-U4;
	Wed, 01 Jul 2026 07:41:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wepZY-00027g-Bb
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 07:41:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AkeFIVAGayb5L0haGcKA2gW/d+HrQ3l6VM8N+DeXHzU=; b=ms0YmuMF1f155+9y6+Io4mc78I
 +DJX6+e6BSRc4dYiVpap2rLaKfNczEtQ9QP3W9mPqPDJFS7UYRPFcp/Ikg+nULMaMKRP16Op60cZB
 Tbn93t1DqGBnKrJb9JkasQhHVHLPXUjFlmtPRl4iRSLUsLpjnU9ZJNm2yMpn7aNE6Jgo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AkeFIVAGayb5L0haGcKA2gW/d+HrQ3l6VM8N+DeXHzU=; b=V
 JJddioJdmFyThWSVdpYGQYvgNToIgWF1Dm4UHqlpzwMELbySYyG4JQVYF9opWgH9mUoXVOczehCm6
 uE1yNo12FGeOT+hnf6VOMnU6h6bv3DgLRPJiw63gOkaqgpZOJ+cGQ4WyB98EY0W16YcjpLdsD692C
 wL3fmxtWCSVkMiUA=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wepZO-0003tE-BX for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 07:41:25 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493b7612475so2221275e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 00:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782891667; x=1783496467; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AkeFIVAGayb5L0haGcKA2gW/d+HrQ3l6VM8N+DeXHzU=;
 b=fauy12Xf6Jna41gDL110IDOxtDa5FbER1WCJqdFpcVWRcBiEAWzCgtwym0bqaGnCuj
 vuvTn6dawEnxTUxuhNXf2rAuNNUPX1ce4ENduW+qAW0I0lmv1n6ZDMs4wgO3/7aDMdDP
 RoUjq8IgfZpGHW2IlF/mhQzIg9kH6QzGTEsgHUre82hL9tjm9NsIIuq1kj4WSkoqF1Z+
 JbR8y7OAzoDu51R1q1xsMpeMQHF86eYNipUPb09uJt9iJ7HNXVHheMOkBMljK3bVM0xE
 v1aMevb7mEtVnWiLULds1MGZ1BRq8jtKwBYbn+Jq5vZTXbgyVBM1GFA+8F7z5v/0/sQP
 4WZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782891667; x=1783496467;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AkeFIVAGayb5L0haGcKA2gW/d+HrQ3l6VM8N+DeXHzU=;
 b=jRYVyt9h0+HXpzsVMy19uMOP1jalxob9XH+ECr4P0n9JRR7zBWkkln4jaU5SnWqTIO
 +go1g0iFkmDlrz3Ez6ld9oBgJR3PdPYVhvKnt9smr9Psgb9eystvdUOH72+gSOUWwPD+
 H5dSnJmUG8p3xLyoOtci+Q9xjf8kH0g3zN9K0vE4UAle+FSwt/CU8tN8bYhz4uLyWTdB
 oBhC9iisvPCBSrusncx/KIcs29zQQDb/XuCqomw0xrjHpLZqXJbLCfuLg+bJue6sPQQG
 OxRqZxKwTKHXX5hD5qlLeJ/2EB1/HYbshutIrxBRzcdrBUtVZgfYhqfVZnpallPlWmnL
 ZxYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OdKm+LPWI9ToiMr4PRxk9Lp1qb2g3vJ0bE3tlVQbkOxINaEwZF6/wm90GsEfyCnDz3ckCJbTpKEn4u2sN@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx6XxEasAa7l8XOSLN1lz52Rz9i6cEQttJE/HjZNX1svBtoiXIc
 5Le+TOaOzZIfqZnqwrlvcFai4aDwIThxGy8Dy7YRqf4G4DoSvgaY5l19zBeqjTLU+RlIeHqmriF
 hmU/jBHcf2PrnE1b+8z5fiUI/h8fRo64+aGVQ4JRm5jr4qZiDtznd3NAhjAZ+hhOQwoRymx7lK5
 2JCLh9kw==
X-Gm-Gg: AfdE7cmf+09f2WHSvOSnsve6LHb3syIvsV7otV65DWyZ4d7E+x22tQLmgqjD3fLy2P0
 xqUW64zDEHRJDB/fkS8I3uzBFtfYuIuCweMMbUfDeyNt11q1XywCdREsveNNYAwAz+k/2HEsEhL
 AnaJwa5TDahoDSSBCqK6Toc6KyvGk8rIhyg9pPtwNYuozt7ZdKdIvZuTstZcpTGDBtg5HzlQ+qv
 0rM4H/9EtozIh3OcyD1eE5SsUs6sHVcjzhBEf2jPZTtztkUJRIPezP5asyZw7gz2pWoxVgJEzOu
 2g5XLjH7G2Ie1RxGuu5tceP3RP2evwKCZs5cEdhJe4/hYviC9V9wyyz7ywM08KKBimKEqtJY298
 e2rP/iEar4bj2ojkJLtCVyVX5N8sCel/4OoeSmWm9DrccY0TrP8/j1wcPqD9a1eDY/4W0hkA53l
 w+gqHhH5adw+6+Rxg1POeWt/r1zBd8TFqWOFLNd5Ss361NCeJCJIW3b8kbLS5AK0Q39hPv4sE17
 sfpqinyfRIyz6SGK+fck2DCIRkYrKwk5+0HZhOBNZuGebqrxSs4xZ/SfPbt43G8polP40rzGDUA
 TGU=
X-Received: by 2002:a05:600c:8117:b0:490:688b:f9f8 with SMTP id
 5b1f17b1804b1-493c2b99aafmr6177265e9.27.1782891667164; 
 Wed, 01 Jul 2026 00:41:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475643cd85dsm14014232f8f.15.2026.07.01.00.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 00:41:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 07:41:04 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id8945dce437da11e6fecae9550c3be52e393d4cf
X-Gerrit-Change-Number: 1760
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1760?usp=email>
X-Gerrit-Commit: 14c1af739c6041b7e516c1aee425610d4969cc11
X-Gerrit-Comment-Date: Wed, 1 Jul 2026 07:41:04 +0000
In-Reply-To: <gerrit.1782883869000.Id8945dce437da11e6fecae9550c3be52e393d4cf@gerrit.openvpn.net>
References: <gerrit.1782883869000.Id8945dce437da11e6fecae9550c3be52e393d4cf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODgzODY5MDAwLklkODk0NWRjZTQzN2RhMTFlNmZlY2FlOTU1MGMzYmU1MmUzOTNkNGNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <39a1cbf9f9d60084a68e960b944c5b07026d1d28-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wepZO-0003tE-BX
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco.c: fix argument
 order in dco_install_key() log string
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2467883376590835760=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2467883376590835760==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ci4LoFO27kc="; charset=UTF-8

--ci4LoFO27kc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

cron2 has po=
sted comments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1760?usp=3Demail )

Change subject: dco=2Ec: fix argument ord=
er in dco_install_key() log string
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1760?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Id8945dce437da11e6fecae9550c3be52e393d4cf
Ge=
rrit-Change-Number: 1760
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@m=
andelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerr=
it-Comment-Date: Wed, 01 Jul 2026 07:41:04 +0000
Gerrit-HasComments: No
Ger=
rit-Has-Labels: Yes

--ci4LoFO27kc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>Patch set 1:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1760?usp=3Demail">View Change</a></p><u=
l style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1760?usp=3Demail">change 1760</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1760?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id8945=
dce437da11e6fecae9550c3be52e393d4cf </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1760 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron=
2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Wed, 01 Jul 2026 07:41:04 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ci4LoFO27kc=--


--===============2467883376590835760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2467883376590835760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2467883376590835760==--

