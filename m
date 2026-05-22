Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194BBCD5BB1
	for <openvpn-devel@archiver.kernel.org>; Fri, 22 May 2026 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tds0NJDGHOmmTcETYPcWjVN8GsqbfVR6tgohUUuhxcw=; b=PQZ+Z5quoILh/HQ6SQIR2fW8R4
	E5xyPHhKGu1Wqe+7R2XTydCZ9OeGCvrUaQ45Saz3brPML8kPj3rrX4OaTRTT6D96uRE11Oke7t0ze
	w68qrRj5hbCv5MCLcsm3L4OFq7jU6CrWouGAxxdVOIwv+WFm8sX8g9hbXwLvYeNoag/Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wQPmx-0000QM-2j;
	Fri, 22 May 2026 13:19:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wQPmv-0000QG-Pi
 for openvpn-devel@lists.sourceforge.net;
 Fri, 22 May 2026 13:19:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+5zanSVY9bEeBTeFvh54saAnKc4TKplaPV4fSwEWvZM=; b=Bzz7CPXuUaThjqTubmf2D71kDY
 WqX4NUFpOs+ggvrMtoCmtzYW34NwDhOMtUgNuuMP4pSKZOqH5IK85Fp/MHV/ZCjVtGCTg3VmOvz/j
 W3K+cocBHD/yxOuS3fd8T2YfJCoy00ssWe5774fvPEmmAyNouyupFdP7424680MEk6aA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+5zanSVY9bEeBTeFvh54saAnKc4TKplaPV4fSwEWvZM=; b=g
 9LHfZhYq6tDbhkq+bFMHRcyivsbMc5NLB7b4yedVILAo4eG9+4rfhfm1QO81jibYD3IkMTXKPhs20
 CLcdtcBCuXER/M12MsIzZfn4fepoAvTqZBtZoI5z5G1vhtD3WMtBHhgNru1vMSwecrFVyB3248wUj
 pC/OdedBQfU+dksg=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wQPmr-00071P-4J for openvpn-devel@lists.sourceforge.net;
 Fri, 22 May 2026 13:19:41 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so11650925e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 22 May 2026 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779455971; x=1780060771; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+5zanSVY9bEeBTeFvh54saAnKc4TKplaPV4fSwEWvZM=;
 b=JCAJ7RVdfZx1Xm0Gk5Jp85c08/absc0zKpWFUUAKW53hur1i737cbriOmrhB3UglLJ
 9/yaZyDxrPKcc/NP25v1SKDm8LAFh72nIzG/gfGzep5WC9inFuMhTRo7m8UfM96BnRcb
 BXX0xFVe+kixFiZgyb5qFs0DAq+t65LghhxfGu5CrGz4cQ4cx+jd3V1vAdMTDtBeP2/b
 e5hvluwkWV7mlghzG1VstRFHq3porOCr2NVteDynn5LaCgqPQ6z+BIMNIMSgbek7E/QE
 Vc3sutcD/7bq3Iij1KgosiJ4xdkf3Etds0OfbNXNh4cK40MIN3Icpr3wGKZ1ovd+cql5
 Z02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779455971; x=1780060771;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+5zanSVY9bEeBTeFvh54saAnKc4TKplaPV4fSwEWvZM=;
 b=i65nyzDuxdoP6xf+G6zz2aGx4rOilN1PfPphXVMsdW6000E8pM3q04oJStYU7XS9Bb
 rNsmP/xUv0Z7qNalcsJDsdSbNwAkjgREf1t//naicJgjNjyMwxuw248ogQIfBQ+oO4qJ
 rI+ktTo1/kpk7EsV5LqBo40RzzpacxPh9MatL7RDQuNgUUducjxQuWxX7hQQoFJ0KQcZ
 KnxssNSaz7TQKHGLOoD1Cyc+vOfhkjrn1wmEHGI9GxozIK3cFVXfQcFExmoprifptdck
 XtcFth9cPlYFk97//kD44cx8NMixfkvOGvHmBU2tQQX989BDvERnOLU7lo4rVc6+Kt9S
 UBtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jsWIVt04S0WVQCIC0KUvnQhf2o9+w3npCSCOHcbo+btUuEZexaewXQH/69/ZjQ44FOzx91JyHObiPLGfE@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw2Lv8U8xR14HpU/GaZwlp1J+r3gHbDOZ5sLqyF/N8LIya8l7zL
 CuwBNGyqoupc3nF0Xkmfdb0SWeboDvjZZngkab2I4C7/ffeDFW3cuMHQUQPrNF4YzOfxDyjwJe8
 6omekeqICLBAVWEKtxSan17MJizUwO6VJpKvefkwL6ZHue42ijDI8brh2SwOHqjh8281RQQN48g
 ntdZAOjA==
X-Gm-Gg: Acq92OEdSHBCKcawLDRetesBwA/GkALZ0gDU6UbwQ4wXHQSzzc+Zf9u+gHJTd80xE3X
 v0huyvg26ko5nhaOGsemW8AnZ2AmwrQrie8QYxKRtQotg+dzYXuT7tZXN2n4Yc1pK+ym5dqSrZ1
 Ija1LBnybGBaAq64Qu82UfIhzPGVnbVTEpklygQQTv2LzgnDaAEgN6zqRg4vWf8sTMIyHv8wugJ
 azjJlgbDbjBhWXtuAxTOcIdX5F5zuN24L3jxhXi4cZSn2kprk3SR8InoXT7APcOIRpcxLEyxnO+
 dGRkUfUZ6dyiHKdpyrkczfXq8KDA5a02wpafznIbJ1651vs2OLcV3MAllbrUSTdzpAKxH+2QrU5
 4sbjkMTB/yUvBMkvgs1RsyY57qFha20N9btmDZovF39ebdCwWQxFw83TJsZFvVlzv9+7N4khDiF
 vq+UMgXxu7kpHX7Hv9beY4dwiIYbFCgG/O1FQCpxihHmJP++1rQXjpjA0F4wT5ZkrrGNNhxCMb+
 ShkWPnHKQ4V6pmTcAjCVkgWZBXSVysKUxa/KbL+E0j1ICECCWCYCmJFqpsX+r5hj8SPrdVNWLFA
 LPBlM+eYy2NR3w==
X-Received: by 2002:a05:600c:46c6:b0:490:46df:a87a with SMTP id
 5b1f17b1804b1-49046dfa9c1mr35873095e9.1.1779455971019; 
 Fri, 22 May 2026 06:19:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm69969055e9.7.2026.05.22.06.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 06:19:30 -0700 (PDT)
From: "its_Giaan (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 22 May 2026 13:19:28 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
X-Gerrit-Change-Number: 1635
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1635?usp=email>
X-Gerrit-Commit: ba94f49bf8492ba5a9b6a8442181f233d5917d25
X-Gerrit-Comment-Date: Fri, 22 May 2026 13:19:28 +0000
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzgzMTAwMDAwLkk2YjMwMzgwNWEzNjg4YjZmNjM2MzE0MGM3Njg1M2E1OGJhZGVjZDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <409348dc8a1b89abebd34834def2eed6fec234dc-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wQPmr-00071P-4J
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
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com,
 gert@greenie.muc.de
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0098389588817258356=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0098389588817258356==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vOZKFAgtOV8="; charset=UTF-8

--vOZKFAgtOV8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos=2E

its_Giaan=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1635?usp=3Demail )

Change subject: Multisocket: use e=
vent engine rwflags for UDP I/O
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Set Ready For Review


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
Gerrit-Chan=
ge-Number: 1635
Gerrit-PatchSet: 4
Gerrit-Owner: its_Giaan <gianmarco@mande=
lbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewe=
r: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: ordex <antonio@ma=
ndelbit=2Ecom>
Gerrit-Comment-Date: Fri, 22 May 2026 13:19:28 +0000
Gerrit-=
HasComments: No
Gerrit-Has-Labels: No

--vOZKFAgtOV8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, ordex, plaisthos=2E </p>
<p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Set Ready For Review=
</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demai=
l">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=
=3Demail">change 1635</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1635?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1635 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;ger=
t@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Fri, 22 May 2026 13:19:28 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none=
"> Gerrit-Has-Labels: No </div>

</body></html>
--vOZKFAgtOV8=--


--===============0098389588817258356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0098389588817258356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0098389588817258356==--

