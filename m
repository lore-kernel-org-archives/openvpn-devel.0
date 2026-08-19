Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6F2C5DF81
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EED68tav/GexEwM8R9x1rh5xjEMv9yn5TZpoxQ9Z0I0=; b=FEskOUsKk8klRxYrC4ZT/dBXGU
	zzJmWpzp+ccRu9gRgYlD3fDhiMRdpw5H2IXyjh4e3LXZHF/nJ4rN23DKGLMWOejkqxqnlraYfZcen
	/oFAWiS6nbZnm+uY+YVZAFuaPOCbHeILrk8w3hRFUEotVTJiS2/2EYFCWIjC3MTmpizk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwiQj-0000uh-PQ;
	Wed, 19 Aug 2026 15:42:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwiQi-0000ua-AM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:42:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SRTE6xe+2Cr6RWj/NU2G+aDcbtaf0FOVPtcJ3YQrqHw=; b=JgPFPBS8TBVH9bOjFszOsgqwy3
 1EnuWW6XKx6iQdMskKtUn6cdRdUKN1IXJZXnExwgBHf8vEt+waNziGXR4ozfa8w1fP1jERT0Jo9uP
 WoHYfWqjY9sAFkRi3qLSc3XlyrX3cdssMbuEF7/KQlKCyGbr8hM+Hx57Vxomn+m4YtbI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SRTE6xe+2Cr6RWj/NU2G+aDcbtaf0FOVPtcJ3YQrqHw=; b=e
 izXR+agPMMUKDm7qNygfiuofJVk46dDr5av1m2T647DE+4lWoP73q6oSC9YQdE62NoH1nbXSBzPXU
 7D5I2bkmXFxmn6vwr13k/5Jp34St+9MJbrU4iO8Y8AwQBjCxtzbiQ648trUHz/EQu6eGG42HnGuyn
 xOIpxpwRvHcPjXWM=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwiQf-0007ui-64 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:42:13 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4815b8781c7so576390f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787154127; x=1787758927; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SRTE6xe+2Cr6RWj/NU2G+aDcbtaf0FOVPtcJ3YQrqHw=;
 b=YskwdL7uf0vqXxJ6FFk3mYmJy8vk1DKC3pwKNkzJ3x/PQ7V8UpNbX5eOuJuSR5hK9l
 bLeKnWz/02KqLAk1BZle+ENRAoDVa+Kuoj4KPrFyT5hLrWkjC9I1gOlLIdFglM+8XXR0
 FoNYUoc6CWF7O/hGnCfTJQIA60Z/I64T6YuF1jJXKmdt4z3WoNemh1nMk89cnGvt8GNO
 89wH16MqgpLmtYBWFERD9TRcSsgogmBVHHF4j9sg9Gy4INYqpggmziqIwC9gPB8fHVtd
 5rRl+Z18s5uGlTUmW93FNiRXswdR7Jvo6O3dclGyeI41Y14CFrcsLfCwnp+YkITpc7hX
 JU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787154127; x=1787758927;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SRTE6xe+2Cr6RWj/NU2G+aDcbtaf0FOVPtcJ3YQrqHw=;
 b=fng39Lk06nfp/3hzI5EWuf6PrIeff2YOdKbX1plR2aOGPqigKuJDzpolm9rFxaJI7T
 ZmhkXorf1KMSGhKBlqQp5NZ2DOzrPKEPOuRCfcC/lEhZxNAPWVu5Vz2o0uQ2iZA0F9LI
 AqPxfU6UxZTvz5SqDo5CHFPA/g6VmIdOoVciI/uuv4NlHR3fKwoAIfLtdlwLnkCOZLkX
 LiSUfg2L0SJGq1BOgNAIbnnnvtRxKbZxZ1WSaG9TIok5UL2vwwAaG+tcFZWM5UzIN+v2
 12rcDJ305Eo+0nDoxhNqXWZP4yE3pCn6zBj4v/CmBZ9S40zVx++D2erAYxD7fkBiCBsz
 I7sQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpY8thHqLYbFP558A+UyTLLsk1fhQ7vxZoLiq8yK5/q83oW2oGRQgqhiqvPitwOHh2Cf8ts9oNeQ2vdjCm9@lists.sourceforge.net
X-Gm-Message-State: AFuF++kMmzDMC+CVN5qy8uwNFBxQ98Tnc5stTGim9jiMZ5ErUsYik9cU
 sPfpaMp9Qgq9+PslQYDhqbmTRHYWs059BY3fUeeRHSKMGRVRigOymBUnRrUJyeF5hLSS8IT7JcA
 wGI4Jp/wHvTrvFzJeBWFod5gaMSHYiCx5H+eK2uH6hWzTSk+MMCxJE4MxmxvklP4h7lX6
X-Gm-Gg: AR+sD12z7epkhK6Xw1p27rFZxPpv1aQ64laSXc3WXz7MWISm4diq2Z39IP5GCE/r2FF
 23waJb4jEAmJKXIBcPCn2/km2Bdmzd3PHwqr8sk4tJqx6lhoBxNU2uO3XO7I72Dwrnmc1YF5wAo
 jdwJiYY37Qmzer5RHaFBUc/uI6A5XuDJhQZ+zu121bzaPcFLkFIv3IxWd5MBxx4r510bnfZvU/j
 AwCpR7hLSF0mpCwbmrYJMB+MDZcw2cYuK9AkApWQUM9b9NevaIwIcVf+y74QdPs1IRFtCh42U4j
 QnYK5YVeSIfPEEnI1fx4loRpC21VBmLKv8Idxv9vP53dif6vRIodIFCwOirgbboVUj8evx3aT2B
 DLHHvQi4GIZovoXFoCYricI2tDKyaQaKAl3zjUxGAtQzxo1CtPZAgJLSL9yitsojPLFH+8vbiZp
 C8onDjkzY1zDv/aKtnKfqPd38zHFM7Q+2CXrgxi5Eft/17nQJzofDOAlAqp+r40ybzVpLz0FVHU
 +/+Z8wWP6Slg5Qsb3gzYB7sMP7FnIwh9wOLOoptXaOsMipJjFDP4p0hg0MxuNfykH0ScxAjyNYM
 wgWqebuItgc4WzK5caORLpMKdOD4NONFJOctAY8+SJyTp4KUp6g=
X-Received: by 2002:a05:6000:4310:b0:482:a9d7:7ced with SMTP id
 ffacd0b85a97d-482b1fd9655mr9284882f8f.14.1787154126526; 
 Wed, 19 Aug 2026 08:42:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14d05a6sm7128907f8f.35.2026.08.19.08.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:42:06 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:42:03 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
X-Gerrit-Change-Number: 1773
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1773?usp=email>
X-Gerrit-Commit: 76db269d466ea06988a46af08705dbbf7f7f3d4b
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 15:42:03 +0000
In-Reply-To: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ODI0MDU4ZmM5YzRlZmQ0OGNlZWIzMmQ0MTY0Zjk3YjJhMjQzZDg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c04d5428cc4471d5347773a7661b50964f348690-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwiQf-0007ui-64
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Factor out
 options_string code from options.c
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7652957959682548509=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7652957959682548509==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SXhGjEnc4Cc="; charset=UTF-8

--SXhGjEnc4Cc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1773?usp=3Demail )

Change subject: options: Factor o=
ut options_string code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2


-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243=
d85
Gerrit-Change-Number: 1773
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Comment-Date: Wed, 19 Aug 2026 15:42:03 +0000
Gerrit-H=
asComments: No
Gerrit-Has-Labels: Yes

--SXhGjEnc4Cc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 5:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">change 1773=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6824=
058fc9c4efd48ceeb32d4164f97b2a243d85 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1773 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Aug 2026 15:=
42:03 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--SXhGjEnc4Cc=--


--===============7652957959682548509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7652957959682548509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7652957959682548509==--

