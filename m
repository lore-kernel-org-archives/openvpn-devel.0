Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C41CC79F9F
	for <openvpn-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R2onMKnhnDZOtTy+8NB59DbnMaO06toWK5G/G1GlwFU=; b=eyz2iSvBYmExmgGn/95I3cmeeV
	F/C5+kqQ0wSZec9qNfDii0jL4ekseSBS3GnvtBIJJIa1VbNac3VC1uOk10xpF7jhxzss94Ft9DmBS
	AvbOm9x1nA77bHYmA1OYWe9OV8XZvgYOQbsZNq9oQGuuq748BNgcWk0DlPR0vo+1nD3Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4aZy-0001qt-7Q;
	Thu, 10 Sep 2026 08:56:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4aZx-0001qg-8T
 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 08:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZNQ/+VkStPF7n3WirwswTqU3D6b5wyzepL4HKKxifYk=; b=m7sETn55W3z0XV46EAvprarNik
 Vsrm7OGBdjcQ9IhYGLQ3Ul1BrLWJAW22kS3xA0aDy/JVd++qtEZiFjHbLR3py3dXjpY4e3mwDQrnf
 XpIeVbhWWiO99wsEbSXbC18jJQ+ysSD82uwxfnB5VC1E1kWotFYl4h5iNTCd65YJIW68=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZNQ/+VkStPF7n3WirwswTqU3D6b5wyzepL4HKKxifYk=; b=O
 s+ytk+HBulowDOvteRVmNCGxhdpOFc/P3CMPELk4yCaBFdlDY/anDKf2WsZfZbsqvhPq6FUF783D/
 jLgtTXwm518a0G79igWNmaypmjwocYcnQKsBZOJSgYyHNVy7Vdi+sDyInGLsxjxAvj0CMjr1i1hOW
 JpXJGU/uBk30E7E4=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4aZw-0002Fn-Rp for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 08:56:21 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd38e0f79so10915485e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 01:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789030574; x=1789635374; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZNQ/+VkStPF7n3WirwswTqU3D6b5wyzepL4HKKxifYk=;
 b=F/q5fnA4uRPbkMPA7YdqR0JsMlQX58doc14mHpJctHHr4UXXpDJkoSxxTgOBq1mGYT
 +mq0S0o0AKdtniQNyMiRYc/JFqAns/lXi56jJNDdfeIYcoFU3wGeEEy4Q/uEk//IhjNN
 9neeGCzJHSXxqDlD5Pf+C26SSebPVU6zl/ndGi9tyRDGPBJH7r8KsChi6traRmXhHvi9
 IuGRZh7TCZiuC7CxC9YOq7aRsoIpQpeU3H/PG361O+A3zNwso2Dw7pMxyEGsPmMqG910
 +ttDtgBy80EfTRYINqnq3TXolNel43NWvhG4OMJ69jGekmaR68Xqlesg7JDX4Lz+0ygr
 14xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789030574; x=1789635374;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZNQ/+VkStPF7n3WirwswTqU3D6b5wyzepL4HKKxifYk=;
 b=ZeL9WuRyZ1xz7IQ1rbE+pEU+aJwBGPmbVxWn6BnDKre5Pk1plcQaeFbIkg2A0siXXb
 MXSvarHf61+/CrRqqKYJ1gx3pYz6nv5d0KWW+iF+SE96BJvpXqR9iCClYg5BlrL/sk4V
 rXZA3Bh1gL1L2cIWSB4t2wB/vAUwHsE7NZjzEm4PmiUXyHalT2yVNE5VN+FcJC8jegbH
 bQzbtUGdKdnYNjUbuMv6pJx+MiMzE7iOMTfRFKpcMJ1VlO4NU+vUsJUf4beGFg3aXlLh
 dUDCVS/0rtJNwOrua+IpEkTQZG/GNkM7w2Tde+O05mVxteBjEKKDYVUwKK3h5TFLDLbF
 NNfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzf0rvNmk2nDUjtk8+X9SsrnkwbKMxb8K/Z/CkvYWtnqUZ2lAAWjWZOJUWFX4LSAWqL0ie3Gv1jV1v+jZZd@lists.sourceforge.net
X-Gm-Message-State: AFuF++kJcSNvPVD/CO1LRsudyb/fSBzgsP1W5wcbHbv9MsFPZvNehjBm
 mhZLUavbdTuM8NAvy0QFGph3HbbEhD1FJxn7QG9Se7fMqH6XNcKL41qgfjhBT4XHkFSuiYAvLUr
 BOsNqCUBwTiRjii+SEHZ4CQmSC7jAUicO3dvPpO6mmJy58SQe+/FUudI9hHdJIq+fWVC/nMugM/
 JQFoPucg==
X-Gm-Gg: AYBFou0zGJHx7sT+ChsnkPxRNYfjxCl3aeAnXwyEg4gy89xrFxxi4vgTxcTyrqs/LB3
 bF7XNbfkwG9TgRXdNWKtW87z69lX0sBu6mMvN2CaYsKfPR+aWPWXR7/kqaEf67iExG1/xX12ckX
 W5XpC1PxSK0+E2xZbWpCVxOPGF6R9RumsfKuZd4K4EfMSNBj+/g2S6rH2PVE3OUfhM/gCC+fIsr
 ETT1uhlSuw2o5l8mYp2H/zPHZlFtwcEiK2kMYggfR5VJI/HCasvsAX8s32b+DQdNSWcqjey7QkR
 zXDF/2k8eb1of046T65S5SvP+DQohe6cd2TTs3vAQ+uquCdid6+m2844rxLmjXwFrDq/Oeej4aP
 jFJaM5+eWoBaG3YsBG0WNAqkzCM3GmrRoY5z6S6eXbRb00rjviM3N0LtvxSlOlamNyaHAuAPs8H
 Mb7ngCJO56N3FW00MbHTA1AvVFPjzAlsZcYGnX03gPxUHPa5YtLITyDCkJpGxB/QkyjF/aC40jX
 EGIHpptwFCauvOpzul20cKylFvZjpNPqvoY2GOTxKtNxqeJlmSjaFtdRJB1dg8U9Zl29hfhoXA0
 +j7VLHmAJ80SHsxMpwbfH5eCPBwYI+Ws/9pA9j53HlLZ+mEQxpLI6GzsEY8+uQ==
X-Received: by 2002:a05:600c:3146:b0:49b:9105:cdaf with SMTP id
 5b1f17b1804b1-49d1f32335amr188618515e9.8.1789030573979; 
 Thu, 10 Sep 2026 01:56:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c494basm52974935e9.12.2026.09.10.01.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 01:56:13 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 10 Sep 2026 08:56:11 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
X-Gerrit-Change-Number: 1682
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1682?usp=email>
X-Gerrit-Commit: 8559184d4d69311300b093095358ddbf4346b90a
X-Gerrit-Comment-Date: Thu, 10 Sep 2026 08:56:11 +0000
In-Reply-To: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
References: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkliNTgzMmRjNTZlYWVjYTFiMTcwMTYzOTY3NjliODRiZGYyYzE1MTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b1d2774253b04355db8fe2a3ae664fb79db0aa51-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4aZw-0002Fn-Rp
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi/dco: simplify
 dco_delete_iroutes call chain
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4875257218005135445=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4875257218005135445==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pmxEOphb1Vo="; charset=UTF-8

--pmxEOphb1Vo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos=2E

ra=
zvanc has posted comments on this change by ordex=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1682?usp=3Demail )

Change subject: multi/dco: simpli=
fy dco_delete_iroutes call chain
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review+2


-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
Gerri=
t-Change-Number: 1682
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <antonio@mande=
lbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-At=
tention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ordex <an=
tonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Thu, 10 Sep 2026 08:56:11 +0000=

Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--pmxEOphb1Vo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, plaisthos=2E </p>
<p>Patch set 4=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">View Change=
</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">chan=
ge 1682</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1682 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;=
antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ord=
ex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Thu, 10 Sep 2026 08:56:11 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit=
-Has-Labels: Yes </div>

</body></html>
--pmxEOphb1Vo=--


--===============4875257218005135445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4875257218005135445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4875257218005135445==--

