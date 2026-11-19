Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A75606A32F
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KUWz5P4+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Iz4ZBfpt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RRpTZ9zz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=M85QSQTP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cNR5HsgmkMs66RyQS3gYz97M9NdEx2LTdUkkp5X+yjI=; b=KUWz5P4+f1b29TUpzfg5CM/Jkd
	ClcSNd84626HbpWYoTMp88S7yXjqcm4LxEjNq2heS1hlMC3X7E2RK5TQuTEsDESSNKlkz4DA0U1/H
	DOHoT0m+2hwQxZfcgHhuChR5LQfIEyjBc2BREtkVJFc+cnVX5QeOUsC2lU0zd+q2Ewds=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTws7-000000008NG-0ofw;
	Thu, 19 Nov 2026 07:47:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTws6-000000008NA-1YcS
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 07:47:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ToSqgV4vzNoLl0J764Pmoiqa33RcwgudopQTpgARByU=; b=Iz4ZBfpt7zaxM6k3HA5LwIimi/
 n/a5rRcr372CMX+/fzMBraF+P38qxKH6PnLdi2gA4S1VZWOkBfCpaGYfTK4U6u2AWJEJSL/cvDzZY
 yZqMb2v2NuQdRw7WSVGgeRJX3a/lSaCiK+0N+/brZ9vBbmbeP26D2R7K32jc115CD8iI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ToSqgV4vzNoLl0J764Pmoiqa33RcwgudopQTpgARByU=; b=RRpTZ9zzbEk3n8gOUsLpJXi/xg
 n16bIXBO6BXhWeckomUX7nR8RSSQBdXEhLKNtk1yOvtUSDfnU3rkjPimKtOlubeRsQDJBfYQ3VM9b
 QScIDkCrr8MODwcWRD3CJf2siB+Zp8sNnYfUBz80xnqDTkwf9god1ycLDRIdf0ltCzr0=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTws4-000000006UY-3LDe for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 07:47:54 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4a358881793so954503f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 23:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795074466; x=1795679266; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ToSqgV4vzNoLl0J764Pmoiqa33RcwgudopQTpgARByU=;
 b=M85QSQTPmiX3Z3x2trSKsHiIi7P7w+SZtT5Syt2CJRpQTJ/QTkEXSM+d3kY5pehn5D
 xaaE9AO7YN0gcyBlSpUuV6mNEUHh+HyjptOO9Aj7JcJGKLW7uvgKjxZA/4iGcyRB3dtr
 bGHVm60CQ/7kehSmQaKvixLAu6EfrfJlMSvabGmGlQ9buWqa9t7PS3s6OCtbmfgQvu/y
 r3lZIL0pzOs2e4d0fQM5e6NXzMTTiESxLpWhLVWAVlVmeQ96bZZxkDm9n62y49IlUsON
 mYE3GiRTLI6Jie+pZhImd1CvONR+Hlnn4zdydtr1Pt5EPtB4RBOCg2Bp5TVru0UTHwiY
 5MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795074466; x=1795679266;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ToSqgV4vzNoLl0J764Pmoiqa33RcwgudopQTpgARByU=;
 b=hHlzb0827MaRqrzT14EHoetoSC+L8OsWeo9OKXYQoruazoas1RdLnPcTi1qraiPS31
 7dflu+xnJU3+ihRpmrYNcR/pcsNABtZWfc1X0xK+Hwvp2BkM7UJ5UrqRRxRvZBuOOQfH
 uL6X2q64v8Vz3ekPyp+jazUVP9WK2i+nznacwgHBc/O0P3i3KR154BDl3ZX6IRYzLoj4
 pAGUP50HNHJAYrYb4v9b6TUCPa/6YfDReJHUSuvZcwE8cQi07PUTurPSG2h5ETbhOkYp
 BquIJTn7HhrEL+Z7iq0vTFyslp75Yz3aTNMMrAjRzyMRF0TV6lhKxZVukG2P+6mSiZqY
 OPCQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF93QXJGu6MZmRW26e2vD9hqvaPH+/d8uO5ct4JB8I1DL8ag9rgC0GozLdLmcl3xK6Y2pZhGmikfxxbKMYi@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+8auEKsbD2YcmGUGi5vthzVv9202CcGro8ha36uz86DfuYEMvf
 LpWrRc6xPoqJhQxCnXt0iGCNWzJKa4IPlbqqBiMeHZ3tNVqHAW24D+AQjn6z6ObtXpWeePksv6L
 UIM4n7m6mt3pKeTOX7/sqbUO2fULLy9njny34WJJUJGbjX0UkTn/7bs9Emkx2gzjOyljm
X-Gm-Gg: AZFdTZfDNyOe2HdcSf9fIZefovo21Z9x/5eRMr1Qz08OJVoxhMd0FbdFMtdJB1pFCM/
 P741u25AFLfiOI37tH4hw0Nme/9h3kYQDP60OK+mSom3Ge/V+h37lFmTCCxRl3GJRIUpySo9llP
 rXh5wNlbjKhtw823Gu9o9diahihui2o3QlGqrkp9/wtamzsC7Ft+X60ZfjT68Wh01po/OSqmd1h
 HyCQgepHr/ditLdw+9elnuxV2BLlK9Az21SHw1gH2FIlWQudWBrnKvuPu0wjtv8NPgPr/Wy05Mm
 sltyFoSe7oIPW9R+996OlMisIClzUhdiIm9Amml7OX+2GlgnBe7t1sfnl4mKbFjejSV3R3aLMv8
 hx+YLu3CRQHjcZMcSHPUbEkTSx7lz9jvXxCpznfvf0DJeVzs3hM1c8P3Sbz64S462PkBWDyj+GA
 i2n2Ea2xJlllmoGo2QfjtkihV16qd3o8s+EMHbNJ/AmiL04V3ZBxd/AxuKlgvlu5bOWcOk9tfQF
 nSVbvtaSBZjgOkHxh0R6nv9X9F6VO1y+meNzNkqqqv4tHgMuf3U+fcqywBASqZaYC4BVQ+16MxO
 xLgYoR13XFm5Wh8iBipKB4pxrAvbC/igGNvyvsHhhtc/6EkrlM8yQCQxq+/d73CPEoUlpAZUHLX
 446LESLqdb4eqkm7CtS+Q2tyERq4UKn8e+MtYtVEEbExCkoToWECljaheCXkMnzB56mhmBhpTri
 APvqiadYvLAteeLgI=
X-Received: by 2002:adf:e014:0:10b0:492:20e0:f200 with SMTP id
 ffacd0b85a97d-4a63ae56927mr7659836f8f.14.1795074466030; 
 Wed, 18 Nov 2026 23:47:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c411sm9400569f8f.16.2026.11.18.23.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 23:47:45 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 07:47:44 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7e70d73f494382e99933d48eef67ecb50a52ee1e
X-Gerrit-Change-Number: 2221
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2221?usp=email>
X-Gerrit-Commit: 6ddfa021563ca174a2968557119e8fc4bb4894e6
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 07:47:44 +0000
In-Reply-To: <gerrit.1795074255000.I7e70d73f494382e99933d48eef67ecb50a52ee1e@gerrit.openvpn.net>
References: <gerrit.1795074255000.I7e70d73f494382e99933d48eef67ecb50a52ee1e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDc0MjU1MDAwLkk3ZTcwZDczZjQ5NDM4MmU5OTkzM2Q0OGVlZjY3ZWNiNTBhNTJlZTFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <41ec587150328aeec4cb2ccb003c6e2c70e21de8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTws4-000000006UY-3LDe
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove
 .svncommitters
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0445086631657855741=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0445086631657855741==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Som+zE7Cy8k="; charset=UTF-8

--Som+zE7Cy8k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2221?usp=3Demail )

Change=
 subject: Remove =2Esvncommitters
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2221?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I7e70d73f494382e99933d48eef67ecb50a52ee1e
=
Gerrit-Change-Number: 2221
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 19 Nov 2026 07=
:47:44 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--Som+zE7Cy8k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2221?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2221?usp=
=3Demail">change 2221</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2221?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I7e70d73f494382e99933d48eef67ecb50a52ee1e </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2221 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Thu, 19 Nov 2026 07:47:44 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Som+zE7Cy8k=--


--===============0445086631657855741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0445086631657855741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0445086631657855741==--

