Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A022C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=amY0SH36sZzZeoPZrrNp0iEt/O8wbLSHcqvBM4TshQo=; b=Vtim/6ZpXRYHtb0wSmQjzo5Xwh
	q2bfYJTrvpDHMMksN5y58YhLjlcxrBNlUdnlxvIdVcojPMTNTOuyl1emKh/vJtxSC3LOqjrao/3rH
	PWRDSMdmrbKiWcAseymCa2k7IwEzC4kvaaqtOuFecFPlrvt+r1XEm03slMApVTkLsXT0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjIQ9-00059D-6t;
	Mon, 13 Jul 2026 15:18:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjIQ6-00058v-UL
 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 15:18:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dyUi5ILtg6jLtkIHqJpCoDF8tV6GX+2BRWFmzRPAZoA=; b=P6Vxzizj2sCbJpWApFInBPoKyP
 3+mqoOZDwxPPDfWEjkJ8RlURCin5YSj64mM3ZwXYBD+MPiLwHY6Go83TRW59ott1PRBvc5MZJEPkd
 pQJamCDSTjuYHoxgTZDRo6vK0Ci6XamnDvK0sG/BbIicPb+Rs+I6tKIBONfzMAwnuLhQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dyUi5ILtg6jLtkIHqJpCoDF8tV6GX+2BRWFmzRPAZoA=; b=j
 /tS8tvXayPVC/CW/lHbyB6KWNCpzBI5claX+y7vrT0YDyjgLsfOqGFvYNmIi8iefk5i8+vPin0lNh
 /60EsvUOtcUs7Ims7W98XcxMnjU35mYBITyOQcPx3G3c2aTjJobmTkbEeWIQQnKhxYiM71P3vV7tt
 ohuDc12LhbZbXojE=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjIQ7-0002Ri-2J for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 15:18:11 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so3002883f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 13 Jul 2026 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783955879; x=1784560679; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dyUi5ILtg6jLtkIHqJpCoDF8tV6GX+2BRWFmzRPAZoA=;
 b=XxZURAE5quisaijvsc6OWPhK+mLgokz353g3oGuU/M0QO4wz+shpZiImklUvKU7xSP
 iA7jIUI91KHrXyiS14fnOZ1YBQxiAZ4NSozxKI8bTuZczHqURAMTHXHIgYy2+Q4FU68i
 q9qh/yUBbSdi2UidoNJYXPkAVQ3+PNwslPo6CbFiEzQ4ajh70KzMRA7U8Y+kzJ5X1zKY
 GMa1ZWPMrqUDjC8XICD+CuXApKPs8/kNKdMzsLW97EFLuaiXewzxsRTI8iL7vbvFVh0r
 +VZvCNp6ZtH4LHO2ZB67UGQTpqt2lAlFAmZOj551znDPg9bvu1zQQX/ZqHwZqSPmiGXY
 02BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783955879; x=1784560679;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dyUi5ILtg6jLtkIHqJpCoDF8tV6GX+2BRWFmzRPAZoA=;
 b=rSv/XcmtepTsx0xwM8nzYhV9j2iNmigVmSk1QWstDPZu6mA2DdshvEcIC2W/Bwgtv8
 roqaPGDjn2fjQt0jMGXcFsWnx7ozXLboFzvYVkwX+3249fSPO0lXCiGoqd3kP9dgxa84
 PBQIrX6pPN0679tuKhYkstJoLM/spxSdqrT8ZOK9OB98TD5LS3rm5Z41nzpARq8tGU2/
 v95BqYN83pQ+qc+ZhvFuoBCyUcgsacNUQYCJWUqkqvx2/00mktaCveXLG9LbPubux1sn
 sqmNFRoRz6RmKU7iSVntYlPF+qrOPstIt3M/7jiW3np5AUhM2K2n1N+v5eogfvQu/sv0
 o6Sg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKXpo6Q2Q5+9sPjlrYCIbY1qmvlhPqUDuZOKKtXJQGYHrkWhoWAuuTTZF1QG/zZGggqshkb/D0E4NNT5H6@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx3p05nB2vS4eOcNNuvMnRD9FfGgDWvfE+WHvzvIphuq3XFpt76
 RK+cJHc4Gd03LjO5/Paok+PyPdcIux5US0irxEo4gW20mYRPO9RjPle+Dzj1qj5ZBFr9YQLqecN
 f3/27pt8nyUVLL8+Q3csB1gedAfxBUTpyyKOOxCa2SHD1MynGOvecbYsZB/VyEWGYSQP7
X-Gm-Gg: AfdE7clYfXDNNz8aw7jyrcIXr6kzoVjeZg3+lLFKVTjGoV4kDglizdCiPzDi7N7du6J
 iHRceIPEoGJ2pb1IkZt9Oc2m265BZytmw12wQVJlfdsabE974zjB+oo2VhiMahOqhcmkrbQRqjv
 b+hvZiMKLQip4riCDQ+lu4jxuuOOzOAvaishRR2G37/H44vikv5sbtBpMhhozh4BIPvzcIxk2qE
 sjLoglpI9So3CoAOoJn6XukqP1cqcVZ5rgyPjCqFUR3GxRA7mr7a50wCgmur6EJTYPyXGK0H2JO
 LSDzb1pM0j8m7Acxe4B5StDACJQ2cg7vLipvs0GbjXqzSMHxxtut567QMJDkCKOb58IwINok9Sr
 wrJG8n3J1K7QBbK8TYBV62ZoQ0Fw8HdTw2qx175Vc2dxxb0F2z6+MDB5dzStFhDUE3VQfU/weVe
 uXZEXCJICafTlt5IM0+QohU5hVfW7elREIEn67rr9mVqOhn50AWXGcyfTxb2okT7RIqRGerG4Lv
 YmXxsgnk67Atrv7mIllRPTEI1MVST36+rqdLB2/FMwnhcpz4I8+cvZ1tuX0u/2L3GEGPse/sc0G
 7ln4T1siek/83w==
X-Received: by 2002:a05:6000:26ca:b0:47d:f54d:399d with SMTP id
 ffacd0b85a97d-47f2dcb5084mr11364465f8f.19.1783955879391; 
 Mon, 13 Jul 2026 08:17:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635a940sm86355f8f.12.2026.07.13.08.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:17:58 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 13 Jul 2026 15:17:56 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I677d3206c24aad997889ed76fb8eca2e6f4b1259
X-Gerrit-Change-Number: 1778
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1778?usp=email>
X-Gerrit-Commit: b20071030db5041bb3ae2e8f0f7a9c96b18ee946
X-Gerrit-Comment-Date: Mon, 13 Jul 2026 15:17:56 +0000
In-Reply-To: <gerrit.1783945377000.I677d3206c24aad997889ed76fb8eca2e6f4b1259@gerrit.openvpn.net>
References: <gerrit.1783945377000.I677d3206c24aad997889ed76fb8eca2e6f4b1259@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTQ1Mzc3MDAwLkk2NzdkMzIwNmMyNGFhZDk5Nzg4OWVkNzZmYjhlY2EyZTZmNGIxMjU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1d3cce296cc2fffb6db191a13f8b24fa7c1fff1b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjIQ7-0002Ri-2J
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_client.sh.in: Do
 not run resolvectl if systemd is not running
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3118205526506111562=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3118205526506111562==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hgjQ4tFne1o="; charset=UTF-8

--hgjQ4tFne1o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1778?usp=3Demail )

Change subject: t_client=2Esh=2Ein:=
 Do not run resolvectl if systemd is not running
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1778?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I677d3206c24aad997889ed76fb8e=
ca2e6f4b1259
Gerrit-Change-Number: 1778
Gerrit-PatchSet: 1
Gerrit-Owner: fl=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=
=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 13 Jul 2026 15:17:56 +00=
00
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--hgjQ4tFne1o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1778?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1778?usp=3Demail">change 1778=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1778?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I677d=
3206c24aad997889ed76fb8eca2e6f4b1259 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1778 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 13 Jul 2026 15:=
17:56 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--hgjQ4tFne1o=--


--===============3118205526506111562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3118205526506111562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3118205526506111562==--

