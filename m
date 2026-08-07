Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00F7C5AC9F
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8SowPmp2XVYYQxPR/B8xw8S9Xb7rnb6op94voutUyHs=; b=IvsL/14T9T9Kh6Tw0j+ELVo3Ct
	/PYlwsdW3jXCrq06zbZc1RXl51KW4joHnILXE5EVgR3X6+FZ6z3lu9n5fcbuvKFkoKgflE1O2EeXO
	EsUx3qexH2Ab6KQRFJKA1lpa+0FrXwfMxXhiGlq8mOAX1TiAfquJJEHTN4xyaKQweIbg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsItY-0007cp-7G;
	Fri, 07 Aug 2026 11:37:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsItW-0007cj-Ly
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 11:37:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Aufond3DKXkHDiPhK9xGaJlabNTf3MwaOaLA/VNK5X0=; b=B9Haemkay01one+BIrOzCoQNql
 CLuV58EEzOYl/aEcXMbF2LtRoAqn6kf9AVdj3gl/rbDJQpSZ1vXksgzSIn1bvEJgJRXaLoIr+hzmo
 f7Vvm6/eFtM/KGZu8cgnXmPylITThTT1CbQ1rYCu3ZOo7obAHzDpvj+OmWS2itZPhZrA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Aufond3DKXkHDiPhK9xGaJlabNTf3MwaOaLA/VNK5X0=; b=j
 /lzB2xelReIGP8r08a+RX2dWTQZf+kP+tuYF21nfDCslogwdFEJifnf/rQzEKp5S7j+dt9bK24uov
 xlfIQd6TlJ2uKGq/tb++m0V7laG+vo0MxJZtCiJ5wz1MIPIWSY0GT0DmNJVpuvMMWgRx8cJuolMkt
 YknYV7nnCUBUeZ2Q=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsItY-00055O-RI for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 11:37:46 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso48828695e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786102659; x=1786707459; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Aufond3DKXkHDiPhK9xGaJlabNTf3MwaOaLA/VNK5X0=;
 b=OerP7RVlUATufMwZvKujD3hSDd0NptGtrxuJXnI1PFrhvXfN9OVXJ72rlvuiIgNbfs
 wzVPjV8CX/SJaFG3pHsutZ63aQz1LvEdKam8IBNWcu5hCIt0bVdQBm0WkMuWMyUTDXWp
 fmDFbs/53jSBHtPbqeoKUGwPXl0Adb2RZ2d+jt7it845tPmaB3T+6JA6LWbWYS48PUms
 y8bRX/GecE5fNoq7TIBCwRsRZy5moL6q3wqvS+aJyI2/ScCRr2yeHWmytW9HB+DePn+3
 +8ZvXE8nf5zFXKOQCltH1whMi7c+hamy7NwNbuWxA8z896a+ckSqtjnsg6xitSG6J6R0
 IYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786102659; x=1786707459;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Aufond3DKXkHDiPhK9xGaJlabNTf3MwaOaLA/VNK5X0=;
 b=j7u8p7HslG4LNRCKHIRRccR5GUyqDJ7mWZo6ORSkU8Ic46RMeN+uo7f3PhuXjLluEZ
 eafoCFND7IRoMVtyVxZxaGbqevnB1EN+VaiAzHPt+d6y6Tgvr0Civt6Eda7esIPKxDi1
 qJWtcD4u7thYwtLLow1gRNd/euW8k3YCg3EKPLUp/qPCzPg8TTqnmIfgTL7evd1Xv3FA
 YE+AP6INUCGlCEhD0xqUHUJ4LzpCo4GwMp+lGH2/m54oXwNU89dtga7LXkpYnjBRgPMT
 BJCIIuflCTweOrBlAx2illVB1doIpfC2rjHTrnPIbHTDVX72iukuWYsPJi94asg/FCgl
 TySw==
X-Gm-Message-State: AOJu0YyQ2WE/XnYDMsmqWSqHFfiY7vjWLARbze2xEO6BZKrK30+1VdLc
 yIqaY779AEdtMnBH1XaZSXaqMFbrKZPMa68qBiBjuC2cpHCb+Y0YYfIuSqkcpkNGoyQout+LPAF
 2IJCTCewG/n8ylTh5xCygcNLCzzHXEbZtyL8ngMUW9qBTmFXpJ2/cCBmoZd20NRnAGzRLwNIS2v
 edz2j+uQ==
X-Gm-Gg: AR+sD1169+UwSzVUKOg79BvS/LdzG5gPIODP5o6CEbMyB+/hy4NQTkTOnCV57uY+YQ7
 wX+2Hevir1LPqe7tEP6y4gPBuBoYa1Drf9MBP2x+OruKzCrjRe9OMqj/12LU8YEGqSJ+LbI5GMZ
 5oqx2ATLmadbIfSyXmdfN8PPDCJ2eZldBb9xvus39Z3HZgjJOTbTdmSElrnyimXfZ7Fal5Fxdof
 9EjO2gOriEPX+xGa9HTNMD53Z+bjKcflgQRephR55cnVJ2PZvAoFHrBxaF8Db6/1lqf21mokxRV
 2h5rcxmEvaqEw5c85om+/2Yej6Rvt7zvhkY/O6AHzhC6nNKyXUiJZON2QfxRENgl/CBxoOgLU8x
 9plik5vEWxUFHBFaK06j/7DUWRehooRaMx9q3GrBKoHsr1vlW6uIt37pBtLjoqfQSPEjsKc01us
 jCuO2dkd8R+GtcjYUmh1qGISp2zTdcoihqg1VONQb+YAs2TNoDbCcsZ08tFrzgtsidI4kL6Woe6
 MkL6Y4pzkLqYIP4rSu3yEqHeyhXkaB9WAkX/HWk9sMyBBsRQxaOUrknsJH0b1f63KA3OmWd7TFn
 VUktjQNBQY4hZbpLhvuUgsSpBt6a1lPpSdL5u54UPWSmtOMU2eg=
X-Received: by 2002:a05:6000:401e:b0:47f:91eb:342 with SMTP id
 ffacd0b85a97d-47ffd231cf2mr13305594f8f.13.1786102658509; 
 Fri, 07 Aug 2026 04:37:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f9182sm5052637f8f.28.2026.08.07.04.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 04:37:38 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 11:37:36 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
X-Gerrit-Change-Number: 1777
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1777?usp=email>
X-Gerrit-Commit: d6e876f91d5e85158a4e08b6018283753cf20f12
X-Gerrit-Comment-Date: Fri, 7 Aug 2026 11:37:36 +0000
In-Reply-To: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
References: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTQ1Mzc3MDAwLkk0ZWJlYjhjMWYwZjk0MmRhOWIyZTI1ZjE4Zjg4NTY2ZjgzNzJmYWJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <80e8f2121c6858311f461c429d071f0a584156aa-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsItY-00055O-RI
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in: Add
 ability to filter by test group
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
Content-Type: multipart/mixed; boundary="===============3888572614068024381=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3888572614068024381==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FV+3a23lQ0c="; charset=UTF-8

--FV+3a23lQ0c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld=2E

plaisthos has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1777?usp=3Demail )

Change subject: t_client=2Esh=2Ein:=
 Add ability to filter by test group
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf=

Gerrit-Change-Number: 1777
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: cron2 <ger=
t@greenie=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Fri, 07 Aug 2026 11:37:36 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--FV+3a23lQ0c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld=2E </p>
<p>Patch set 3:<span styl=
e=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px=
;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail">change 1777</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4ebeb8c1=
f0f942da9b2e25f18f88566f8372fabf </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1777 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: c=
ron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cr=
on2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Fri, 07 Aug 2026 11:37:36 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--FV+3a23lQ0c=--


--===============3888572614068024381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3888572614068024381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3888572614068024381==--

