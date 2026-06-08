Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6452CD8C9D
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S2ZvwNUt6pXDANTJljdvEou4txnDmkwO6M7Uo7D7Hww=; b=IQAX2bYGZZv2ZU4LGBIXMqoeIf
	croEApL5M3LWFCHZX5ShNZiFQwknb16noS9PPl7Rs6SQjeWeP58sUnmZ/vApa/KMFnphJORaPUVXe
	tl2Qi3NCIoyCXMOlbpVRKVFl4tjICt2U08Qoyj4DexRGR3Cy4qeDEFPPdOXzl9xyF2iY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWZRW-0000NH-Pp;
	Mon, 08 Jun 2026 12:51:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWZRV-0000N8-NX
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 12:51:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=a3o8Gj8zOTXZsBvxICDBG0xjykq5OlOnxBpsy5oTZnE=; b=Vm1jjiNq45ZJ8BaNK8g5eMpUIr
 v/ahMX79xdzwfxlL+O+lqaYIn/UGBVA55c9Eu2pziOcILhEecN2F+6lEY17qhMj8s17xec4ugONjt
 H0wN/8DQ8WMtcy+T3HF5CRZd+IrFx7ABtSitRuRHF+Y0Xyn6EzIFxo4lIVxq4W5Vosxg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=a3o8Gj8zOTXZsBvxICDBG0xjykq5OlOnxBpsy5oTZnE=; b=Q
 cJ83a1LDIG28exLMRPtmo6XwhZvcyLGwl/5YIwiGf5Hy21JmzEksgjNFRZHqyje5DJUrm28vhWSXx
 CFom+gZJwLoO7kXd/zYpGF38ByNANGkpIiVUDoaidWyxchTvyjzJVDiLkfDaa9Zesl/AmvrThyUMp
 qdVt+BowsRbjbii8=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWZRU-0000MC-HM for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 12:51:02 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso49720845e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 08 Jun 2026 05:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780923053; x=1781527853; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a3o8Gj8zOTXZsBvxICDBG0xjykq5OlOnxBpsy5oTZnE=;
 b=WzSyClUf42dRRTdK/VanTibNR1BZ6K4snQj2ifUr6+uwvqDbSUUiJDB+m8Mp/XFZi5
 EAJJBQ8gS0FoNkVulJp85V7lYlHuw0aPkRj3rehmKHQFiokXmpQJDXc+y/Mp8lmsZCxK
 GuGxKsNZ+p1Sd40tKvctxRF9GZJ60BSQff7vsepX8ikJNFnTbAWEU2cuyLJBouQKEk76
 JYk0Ff+P8cRCw2aQorI+yAE7TTcd3fDlxa4gG++xUgJzDwnPE+KVPduWyRp1co2qCQIA
 v9xfUOErNZLRa2LV1RF4s8yHHg18BynUr/iWnABHM/Qyk2QNvOaZHMDyN/G9OdAkT3T7
 3Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780923053; x=1781527853;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a3o8Gj8zOTXZsBvxICDBG0xjykq5OlOnxBpsy5oTZnE=;
 b=Ztfd/OPEVEmbVtjzB8+ALctGrvwiHvms0bgg4KnTDlkGO+YnyHiTZeMfzdm/rRck6t
 Xb5f1Qt0zpRUvwhpljfWWxq+jimdGVGUc5AI7v4BmV9bGZTyrWQOFr1Ntu5Mjl+AYMMs
 0wPiit6ASKC1VUiEtLB6gNaBEm/ajKO5PtPqa5nOyM6chNzx0BRH4QjqZigPL+GkDeYK
 nFkv9sCuInNh2uDwuWwHJ3Zs3dhstRgp7wCeIe0mtm1ICTDPVUsMsLHgCOJSSMOV/qRJ
 dUPtIzJ2s+I+SedmdFT3Rrcm/cTShCNpKP5zbPQuqgXfmrzfwW++O44oTF4GtnS1uivi
 I6Lg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8iqYnhrRYCMY0m7koxdbPXdpW28n39nNYkXQASKe0rlA9CVh5d48rxEQc9G50bpC0heSCixJ3F8HPwaSoi@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxNx0KEWmqMAPraQusGpQta7ji18my/J9u14lY0CUgjuwmZISdM
 DzKlBdAUbKIWvz01XI43CCjUS9PWIKYKXN1DJVC+ajD4co1MElij+MuXP1fO9lG8dpTnmyIhxrb
 CGBHy2e3eLGWqw0ppQfu9PYa7AgeTvb+0f4xqorS9EooKtQPpM8+kNCDg5cAv846gBBlG
X-Gm-Gg: Acq92OHaj0dvsSDI6HAwQjNQI3xlEy1LKhQA+CFfIje4kzV6swbQ8LZY6A4EhjgCYww
 Ay/tUB0yIh6a4dKaFv3cgy7cCRhnH+c4XuH/fNrnvMhbYWC6jiNmzXML6GLdVoTWVzxyZ947oN/
 PGFEuOzBe+6Yt7EgDro7ivibsioB7pVZBrMxttEn9rR4BPheEV9/uP3W/+jFSCN/cRfOs/WrRt+
 uyEh6ix3JEJAlpBdJjm9RL1QIks1XLQAq15i8PEAEOsPu0ZPhliUWSJWlUfk5BrtC8NXIZ8ds2+
 /TDbx3I4ocyPzo/qaPyHcPCVOCQ64N3sLrXO0xUQUhy6CoHo2333p4U1Gce2atEHRnSsuFw80iz
 JrKg2+VFCUwI5j0ZTLAJNX4c5M5LhWfihVP67ja4ldMSugEY375GmBjZhSaKdMhy4pRKu3bq4Jo
 ewX+Fq0/i1qfo+7g2rgeC5loQmh/ouJawzifBXAR2dZtXqlBy7ZPg2jeuKnqSuGp/8FA0ZtuOnv
 nRcLfWToT52RqlnCiPGOwZyOk986Q4m11VfXDqeREtATz9XlB7bT9EZLzWV4RRVYmNJrUrxQhF7
 VdLv5RYFeKlytG1hqYGgUMRF
X-Received: by 2002:a05:600c:8b67:b0:490:d354:bcef with SMTP id
 5b1f17b1804b1-490d354be2emr10739015e9.33.1780923053189; 
 Mon, 08 Jun 2026 05:50:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918fcsm447463035e9.3.2026.06.08.05.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 05:50:52 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 8 Jun 2026 12:50:51 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
X-Gerrit-Change-Number: 1635
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1635?usp=email>
X-Gerrit-Commit: 6e690c619252e5d88271ace9b302f8abd626c965
X-Gerrit-Comment-Date: Mon, 8 Jun 2026 12:50:51 +0000
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzgzMTAwMDAwLkk2YjMwMzgwNWEzNjg4YjZmNjM2MzE0MGM3Njg1M2E1OGJhZGVjZDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fc8e37bbfe7f4699e9be7ebd2d05e7ad52dfa95d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWZRU-0000MC-HM
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Multisocket: use
 event engine rwflags for UDP I/O
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6743353461939872516=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6743353461939872516==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y3TA8rbpQv4="; charset=UTF-8

--y3TA8rbpQv4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos=2E

ordex has=
 posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1635?usp=3Demail )

Change subject: Multisocket: use eve=
nt engine rwflags for UDP I/O
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
Gerrit=
-Change-Number: 1635
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@=
mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Re=
viewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: ordex <anton=
io@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 08 Jun 2026 12:50:51 +0000
Ge=
rrit-HasComments: No
Gerrit-Has-Labels: Yes

--y3TA8rbpQv4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, ordex, plaisthos=2E </p>
<p>Patch set 5:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">change 1635=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b30=
3805a3688b6f6363140c76853a58badecd8f </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1635 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianma=
rco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ed=
e&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;anton=
io@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-D=
ate: Mon, 08 Jun 2026 12:50:51 +0000 </div>
<div style=3D"display:none"> Ge=
rrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels:=
 Yes </div>

</body></html>
--y3TA8rbpQv4=--


--===============6743353461939872516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6743353461939872516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6743353461939872516==--

