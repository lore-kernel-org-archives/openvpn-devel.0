Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26476C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dXHuA6shuKOTczmEXtppdyrP17KdIC62x+OpEupAu4Q=; b=B1o14UHxA0kmbqGOW1CTF0I+qu
	37Moi/FfP6KjgcbU5srS3khNaVXRJ6oqTVpamJRi6qrFDm3VP+p0OB/41w3l5mVZAVb+AxnWokhWL
	u3LKyeIgGe1DVk4qWLUXcvsAEojY5f4vgaw2nsoWztfKoWw4PGcZw3RgUg44foBdlsOk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnIxv-0006rv-7m;
	Fri, 24 Jul 2026 16:41:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnIxt-0006rf-MQ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:41:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MfbSOAxE95TN9mGHgcHTXy3CDU1neSMYuwDwpZvGzMk=; b=frcSeF4Hax9BIyYE3Hre8W9SzH
 ZRsvtIm8JA9dFm9tGU0bqBGsNvW43s99r31L1FSV0upeAFu5tCfvCzV4Rj6RLUxHTQggyBDVgfjhV
 NRXS/jIUCUiX7tAS8OXvUX05GgpqhYCfX0u9IFx1ym0ZomMBwd+Bbi8NN1t3YJy+yhvM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MfbSOAxE95TN9mGHgcHTXy3CDU1neSMYuwDwpZvGzMk=; b=Q
 YXVtDNDzREa+9BsncKx8rw72MNG5RGwJ1XX1buRDdhEJ/B04/xsCzi/VdoyunsauODSZ5+q5f2V9u
 aAmhSMnbqFU5mNpMslrI4xsOOcNzlhIK1bUmHYsv9rXa60LBkPbaeV3rTXXKDBi5i2JTaSDOKD+Ao
 fzqNTiIO5minWF58=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIxt-0002UT-3t for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:41:38 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so7190445e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 09:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784911290; x=1785516090; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MfbSOAxE95TN9mGHgcHTXy3CDU1neSMYuwDwpZvGzMk=;
 b=TyqXHZm/czKdx00fkgWHDiqdj7K1semTIHH7skmpYFkYvndi7oeICBng6TLwkSlEfI
 k3nvgyNQ8nXaUwNSY/PrcHBYydTljjGsuXOG4QUSD5UmFKOx84a6LxRkpx7WKkP/fNpG
 TecdsDADrRyGXMQy8GobauCVXqx/gprU/uypscImr8/3pjV21Ovi3gcnjJHp3s0VP0zZ
 cIUrC+xQkD7c9iI6itP94FW9y7so2qqpoSuvGIdv6G72L00MY2Au5tpT6wbW5LbJ8VFH
 Wuj2jefL+ZveSPrxZju+DatYC1jaAofhcX/ZDUi6eYrDu6pa8CCUh9/9vVG9IKPzVu+0
 FKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784911290; x=1785516090;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MfbSOAxE95TN9mGHgcHTXy3CDU1neSMYuwDwpZvGzMk=;
 b=R8QNK5Xx8ybIaMsIRGxDPgiIh+UIbfCiY3sSkjhn4dzjK/p6tajqZzSZXxnVWlKQq7
 5vRGwMyS6zrO4QgnGnPemh8FWGa4/VBSc5hTPw46N1+yu5IKvfvCUMwxv2xuXbITADdw
 iDROeYC4cEOEjNrgrp/T1wrqzvqpyTjVdNGj1L9wkq5hnL+yRPpsMBW/Y1TzT2it56xd
 avDyQ9iEJlwWgvc8RpCULgb5PlRs8ZoQQPr2jo/81VWUoQ5zofOdv2/mheaxQH+Og8kG
 vPCceVv+NTy+Hr91uuk+q4/BoG8uHLpHRwpq7bnWElt/61QDsAsQLkzCgenGrQC6ArzC
 DIMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvMkctZoJNeUA+ntPm4J0Rx8VgqOd0tqzacxG/xP9LpRA1UK3zObILEGstz2sF/dMO+GgaAoASEt0tN1Du@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxoocA4fKEv15fApk6XAkezHsxx4D4R3+WP7C6x3n0mIRPzRj74
 WtCBFaFnwxjte3FpnMryTylO8ZqwNJKvUFoKYKzDkacWMISMIYTbi4tSgq6eKbDLef4lK+ant6f
 bxMjDtTR49oU/u8hvvE0b50Cwj9uC6Zh/3q2Un/+Cp3E10lhS9Z1SBoR+TMmhKMGHEu2H9lay0v
 AqEU3Rpw==
X-Gm-Gg: AR+sD12YZxBvI/8m6Ec85pepfRPWI3O6qxA23UDKIBHT1OEh3T09rWUur5MspJr2bkB
 bbFT/Ck8QJ+Yee7jS7WWgblrBwg05nYL6HTbwVSoT6OyLw55i0G6W1NZm9zmnVgELDBVQY9OSVi
 HgpF5iKoDPJ9qjqfX63lfoCBdF/29VOVZM4CJadVJsTVPCWvC+fmxbiTA3I9GPdaWIwEdlUQ/fK
 ZoGGedp4PurYWNEfY1WQuAH9rczmqLauqev17Za1zK/fa0byufodMYcDVthXrLc+lGc6Uk7B6GC
 OsHrMnBCTAmkA0zBgP+2wYl94tqwso79KhQvM+WuScL4UTylpRkgG3v2lJFt/dxmq1IY5Nke9AU
 T7sLfg/qf9cB8rWtghq3J/tec4TC12LbkI0lMTCJWEVpQfrVdkjJXz+6MPF6au22hoD1bqAStoq
 w9EwuMRDBosSK0JusRklNc+Mt+jhEJfVNOcxGVxIddxdbms3AunnzBUBddT7W90nldvXoGluKCX
 m20BjE8DLYkJmBHZBFg216ZSPyjy8wGobsZXTOPZ/I7MQDUCSqOughma/NFjByKQyu7
X-Received: by 2002:a05:600c:e548:20b0:495:7538:d4ea with SMTP id
 5b1f17b1804b1-4957538d5f9mr58241325e9.0.1784911289852; 
 Fri, 24 Jul 2026 09:41:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b487c8e3sm4504635e9.15.2026.07.24.09.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:41:29 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 16:41:28 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7e5ac9b4a8594251c3b5c4655f9d74b021950098
X-Gerrit-Change-Number: 777
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/777?usp=email>
X-Gerrit-Commit: 6c4f0e656c38b3dd0d3d21b9884254a2a8894953
X-Gerrit-Comment-Date: Fri, 24 Jul 2026 16:41:28 +0000
In-Reply-To: <gerrit.1728025749000.I7e5ac9b4a8594251c3b5c4655f9d74b021950098@gerrit.openvpn.net>
References: <gerrit.1728025749000.I7e5ac9b4a8594251c3b5c4655f9d74b021950098@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzI4MDI1NzQ5MDAwLkk3ZTVhYzliNGE4NTk0MjUxYzNiNWM0NjU1ZjlkNzRiMDIxOTUwMDk4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b4a4d796019ae1a002a91abded87bd71117755f4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnIxt-0002UT-3t
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_server_null: run
 server processes with 'ulimit -t 300'
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
 frank@lichtenheld.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8160887651915173286=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8160887651915173286==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8cML3H+T4X0="; charset=UTF-8

--8cML3H+T4X0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld=2E

plaisthos has=
 posted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/777?usp=3Demail )

Change subject: t_server_null: run server p=
rocesses with 'ulimit -t 300'
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/777?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I7e5ac9b4a8594251c3b5c4655f9d74b021950098
Gerrit-Ch=
ange-Number: 777
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: cron2 <gert@greenie=
=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Fri, 24 Jul 2026 16:41:28 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--8cML3H+T4X0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld=2E </p>
<p>Patch set 2:<span styl=
e=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px=
;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/777?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/777?usp=3Demail">change 777</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/777?usp=3Demail"/><me=
ta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"d=
isplay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7e5ac9b4a8=
594251c3b5c4655f9d74b021950098 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 777 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </=
div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron=
2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Fri, 24 Jul 2026 16:41:28 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--8cML3H+T4X0=--


--===============8160887651915173286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8160887651915173286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8160887651915173286==--

