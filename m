Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DB3CD8CA4
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 20:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SJTWz4Yes/SybCKTwp8oEEwCB+U8TJZx4sUtPyWg1U8=; b=Eur8BAP+L6Efu+s1KwVjPBqkZe
	2F6SJFXkcLDryASk6Uk1Txv58JCWw2Mze/3g5zJ1+1ZQBLy+yPGBPlGHUdVJ6rfU1mmM0nNYpm1jH
	KYNZoLsZj0pdcKD2Kdp72OuFSexz2ByhY+w5ZESMF28mGMRZMRmklF3zIESqP0TaO2t8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWgXq-0004HA-8N;
	Mon, 08 Jun 2026 20:25:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWgXp-0004H3-19
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 20:25:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gtT7fpkoc/rlxHIQyi2ub8L9nktsyTqJ5c1OewdlL44=; b=AAqA6BIFWPJ8mcAQpJeAo/O4Cz
 LEswOdBsX1VYzG8lftvqpwbQyNjKTiceLoVWVjkvi9hO07Geb3eUuntjQaYjwBCkB6O9qio0jhg3J
 vNb0onT3yGSSjQexkY9ltPPlRm/2EGxpazdSMmxTR1ab9oTvBmoyuabO58jz07KXi/cM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gtT7fpkoc/rlxHIQyi2ub8L9nktsyTqJ5c1OewdlL44=; b=S
 +ATwZQmLKxi29GTL6ySZ6bXtcsE6FY2jL7DbvtWxWeEGPXc4/lIQNPYWOikuTzVIDA6QkMN7ovjom
 3jbnPXy3KuaY0PlABB7AmE2eiP+QJvHFUcEiSaPzesMw57AKy110dkveunQb+mdx2CneMOO7Qz6jd
 v3KXrJ/37UDNcVXs=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWgXk-00063h-G9 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 20:25:58 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490cdae130cso9357945e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 08 Jun 2026 13:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780950345; x=1781555145; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gtT7fpkoc/rlxHIQyi2ub8L9nktsyTqJ5c1OewdlL44=;
 b=T3h/HWxQVR4lvHv7liz9tQ5H4q1IgEoYnzdN3IO/SgqRfgMxmrufauDKhgYxx6bI/i
 J/NgDxputnAs15MfcTYuSbcZsEsw/iiijITK8dJLtmoyyla91tPa3VzohBSIhNiEUNwN
 5eepvm0oO3mmipDCq4DZfjdT9qdX97zxZ4JcwS0Tn+5T7az+KkvAOXTy31pI6mYTolCP
 +vTMxW+O6ZzayKXsZpmFFwUakFhAGSItA1yFB0Tm1WhMKGI1M9ErluskdIQaW/GCI9pJ
 mW/C6dmcpxbbHbNwjqhgLoxV23cMCwvoC+4aHR5vJaGGxXAiJPUz/Vp6mNr8+Um/YwEp
 miQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780950345; x=1781555145;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gtT7fpkoc/rlxHIQyi2ub8L9nktsyTqJ5c1OewdlL44=;
 b=I5oWfPHmO75ehkeJYloLZ62p1H3B+O32AzPbKFnhA8ShprkCe/wl+sWDQfIXspjxI1
 OeEnznLQbGeCIkRA/fXfSNAttxMirpJSxKQZ1o+FezI8WCDIOg2pIAtJrFWwh0uY4EPs
 B4oc45VdL5ouG1vFj1WOPAK1tucbpDZSauCxaxNdpHrsMRlfVzw7wDDOYtUOwnIQ8C7s
 qj3ULH73HrR4Ns9EKa3qAkHx1PbhCZhBDkt+FrQL9tqR1NMaoazqgjdw6QdIVwk8iDKe
 Tq9FBbjHqnJtJmVDDhiHMoOBD6qZ3AtT33SuC1KInlDqQLLsdm+nCI9aOS3xNCMrZdQO
 D2fg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CG9YlgDqF8lszJBzewRU78ZdNQqtws2fvFFz7yiclAxhMcqWyto5LvcLM2mFqfRTIW6zqU9dqDVTxffZ7@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzk7rPsd0zyFf5N6iyhea+9OEyXxwW7fhLyp3SgZJU5sAIHlKJ4
 AOSTNinaa1EPjLlmvhfrPSzoEiulG05oDU8bV6jbhLadzBMRmXFrV7egsUsmPAiaZxVpq9wtBKO
 JCf2sEQUV5/5jIA0/oQJq85mV2eOUqU4FkW0sfEXrXxZ6SQ4SxId6PVoFdRxmU8F+O0yAGsXUmD
 +//Zjaqw==
X-Gm-Gg: Acq92OF7lI5raJpoPe7G2Cfp5qSA8Jy0/GotzhKqteLBk+BQRc8h0AtnJJoip0CrGKy
 DDrA2qkTccBYdWZIlBLxpehbFHCwsAhuqf3nFshIK1sYCG3UUgZSu4lAA6dYEuWtWg/cpue5hS4
 3ULKzOXXOzjDoEPsD9ysYlm8ZJj7uTerbg5xgKz5oiDlcO4dZ4zExfi5ssSMWnqNLuHpf0caIUH
 hQJyjpUQ9y75xSvZs9Lfquu7qbJ6eCMTJ4qsShCV3eE2TefVBsGjzTjmOQVni57uA3Pf8feuVp2
 PaMFtl/ZXtS+RB2R25bOXlyWZ8YONecHJMwLxCPpqqbGil1aHajC8AU23xg3jgiGB52KcNDVP5M
 aH7Sh+6IDIiaZwhEgjta13dl9ChXFJc4J87r5rExm0PtS1E3AKUduOT+n9R/mcWC2AuI5REXleE
 SmE+S02h2q8iqWeLXBadfFgnA/WuwNk+YOo9rN78eQ3QaMiMqOS4NDPBdEaFDTR7lB8Wpggqdcn
 HPx2UOYwm7oKA/QfWSBm5JXdG6lwATXSOoIWxfkjP4her6HLDe1F04ZCnHOiVCzrqYEnc1Kg/rt
 yM3EBcEhLUBbykBj7bKaZbcZ
X-Received: by 2002:a05:600c:34c5:b0:490:be9e:fd07 with SMTP id
 5b1f17b1804b1-490c25ae3e8mr283134095e9.10.1780950345346; 
 Mon, 08 Jun 2026 13:25:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2c9ebeesm251077045e9.0.2026.06.08.13.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 13:25:44 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 8 Jun 2026 20:25:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
X-Gerrit-Change-Number: 1683
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1683?usp=email>
X-Gerrit-Commit: a6f3f92a7bd0ef1c026f5ebe7684f9494cf2deb1
X-Gerrit-Comment-Date: Mon, 8 Jun 2026 20:25:42 +0000
In-Reply-To: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
References: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkkwYmE3MjNkMTJkNDMzZTZlMDIwNTg4YjdiMGMzYmExMGJjZjhjNDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e5101505b0198c5a70cc00c5021d4439d8833820-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWgXk-00063h-G9
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: remove iroute
 at client exit time instead of delayed exit
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
 frank@lichtenheld.com, antonio@mandelbit.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1264568457798636266=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1264568457798636266==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dlRwxR9D6Mk="; charset=UTF-8

--dlRwxR9D6Mk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex=2E

plaisthos has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1683?usp=3Demail )

Change subject: dco: remove iroute at clie=
nt exit time instead of delayed exit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f=

Gerrit-Change-Number: 1683
Gerrit-PatchSet: 5
Gerrit-Owner: ordex <antonio=
@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Ec=
om>
Gerrit-Comment-Date: Mon, 08 Jun 2026 20:25:42 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--dlRwxR9D6Mk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex=2E </p>
<p>Patch set 5:<span styl=
e=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px=
;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">change 1683</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0ba723d1=
2d433e6e020588b7b0c3ba10bcf8c44f </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1683 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5=
 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Mon, 08 Jun 2026 20:25:42 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--dlRwxR9D6Mk=--


--===============1264568457798636266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1264568457798636266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1264568457798636266==--

