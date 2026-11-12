Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D23606A32E
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BxBVAyu3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CD8ALIDW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VQ+P87Ua;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cEzEvKpP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JNcQRGOS+QRc9360XtNMmTo8j5F/xiJEB9QGBkEPPLw=; b=BxBVAyu3Ts9BVc8xTc/DVQ6wVM
	zrBiS9ECbrDU+hcJm9g/mO0wsYwyebjwutgaQmOLsyuVgQuWCiF4vMK8uuEDvXJqCQpyLKiy4ZnQg
	CVZ/QOJd4zsGZ1Y5/MCJ7Nuguie2MMYGD7n34jI2xYZ58Z1lIT6Z4x3NWzehTEJZWG1A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRZ0F-000000006A7-21VZ;
	Thu, 12 Nov 2026 17:54:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRZ07-0000000069v-0c9W
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:54:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wcBcPODsuqjV/IuZT1ZuCcV6R/GOmmn8KsirTdAQl1U=; b=CD8ALIDWubyT/65xkIX/9MtvG5
 EX16zDxcqwDFBKOaPNuSJzwEqZjz8MQHzvR55BZoppYsKeeAKA5I7JTE66jgUV9piF7BbuQIa7k8p
 Koj96a2i2DWy2Lp4LoZWo8+mEIACTIpv06lOWHmeoOs3W/bPvpSjRC6AOpeKZEMK5/nY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wcBcPODsuqjV/IuZT1ZuCcV6R/GOmmn8KsirTdAQl1U=; b=VQ+P87UaWueTmSak0CQl9KrfwI
 U/jg2RLz3Hz8AjG5mtKHiSpkjOE5ozi+m1XJJ0zvain0JsrOGt2bv1x2Fwzz77/h5LhcgBO/oHD2I
 HEzsO04QQOAQcIT1ts4HzfpaQbKIEG8nzbcRGLV7SdIsroU9RzHYPZGfAOvLh4X3oXhI=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRZ06-000000008Lp-28xA for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:54:19 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso26223f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794506052; x=1795110852; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wcBcPODsuqjV/IuZT1ZuCcV6R/GOmmn8KsirTdAQl1U=;
 b=cEzEvKpPJhLxbEAUSnWoppIgxuhoMEM1huYzbZm6/7xAA79LByzzfgltaQvTKKZSPY
 idndiYRkrU4yoP7tiuU0XYMCY+Qs89gFv46wt/CrqVo8DPYJGZ5B4ba52ra7+bMQmFjB
 QaxOCQVpEZdRl1hZ817LkatZy27R2WVdPFq2KIwfZSMB8j7ZLSVRI3Lc/RgcB1NwjnSu
 pdhTZYuqRzRZr8GHCsIhA3OJDHubEmOihWD8CwLzofjhNBo+c0qPAaqrmEtmBGyx+HS5
 8t/XLui8kYiYZj8cNb95FP9n+G8KNdH+jcocxtCh7Ap/vO2Ul1wBAUWhSd8JUb8Qd87a
 9pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506052; x=1795110852;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wcBcPODsuqjV/IuZT1ZuCcV6R/GOmmn8KsirTdAQl1U=;
 b=s87YKir9Z/4UIkTbQtSzWm9owJJJtVFsum+AXXdNGFLKpI4uP39865NLvgIk6zvd3Q
 cRnn+H1Rx7DJawMSog2WoGbZvwaR+EmXFhDTTIKYVhL2vGJl1vMUHFRUbU8q/O4xaQrh
 lJ25CADTS+6h/KCl1x+YmMeWf4DoDTZ0XF5q7zlKHN6rsYEG1rovr7d7aDE5unEzrErb
 bswvQ3OyLeKQVv4oz/AZ5CGamAr9bznZFUV8ulUVEWbRknJ7T5kXQnPRo9K7lOSp8OJo
 1sgr1abfZITAXxNYpmc3lZ+epPfqTVtJ52uUP76jbR5FRrhJOK6TGKX2dYcApsbKyEYA
 W6ug==
X-Forwarded-Encrypted: i=1;
 AL+hErERWD3ozUErw/WOmjfXUI7yvZ4mDf9XKmqiR/jv63lfCzXDAtq7Bo9UxheAuUm9ZBDN9u2KPCiqPsaWAoAi@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+KYjXCPxvTqZMGD7+x5jnG4U4bAZfCz/Qvfr0A/UOvj4DkwHxR
 Xa2Dz1QbotZUMuLPKVRhNBzdQtlzS4YtN1AsVlD5ocSmY9hNlJNF+fHfEz3WHGLfMtrRdWUGdU4
 1kiTZfzQR5Az7XVUYLsdjrWuPG1a4uYiAg+yExsSiHJCMrlgoe5vPyGtxGO8bdB9j5WViwsO/04
 4ZKlSIYw==
X-Gm-Gg: AYBFou1huBT+VM5Jqy1FbevhVS/M5+PqwmQ6pb2pgMypFdfZkEg0r1BFn8phY2eHdaV
 JBWZCGffnRX904lcOvH1O4Bs+YxUEX+ZYRAN3j4FkY/rwC/98yHayVnrfWsKArMMF5s4/lQm23T
 3qdf4pLEQWfhfP07Kq2FpwZZVn0EF2VW2BtPQaMEFApkFeKLcoTM0d1T0Gn4RK8vutDK3clQrk/
 1sIVrilGnx5Ro3n3eONrzryYw4wLttNWWIVQPgu4qijjWuxhHxHZdjtEnyU1p7gngC3Un0f1hs8
 ieyLRZXVEB+9J4q868dPNBJ1NclAVNJRw3pkgzqZOylp0ooQ4YxoAapQtPaDiBE2jyStY4tUPnA
 AlDjYXEJALiralEUlD9pdKCHrgCaXEYXCaDPEuOuy2YFfr8gAM22kQpXkh6ZF7DQzcLiVfBP9G1
 L8YCjS9bLpcnXgEvL8/04pVL4FJQAD+7/IkvOwywixMdHo+wHtqxhOZTThyzF9TzvRAW+hE316v
 qBfhk0n6Uyu2W/vksTTp4tvn/qiCovkHl4QQMO5jq/7FJ4+hzVDcIEjgM+m1Rk1Ie74Xaz3Hj2W
 AYLJubQjZYv7wqUCJqfiWQMxnpv1og4QqBdciXXacddLjC3T8nllMbngVmwVMANplDlCBjgdC99
 GV+Cxzj2eeLGgCvAR+RQpfIiKCCyGReCQ8+CerMF14tcevFLB1FZva3ndC1iNOFfwzMGjPmsvJx
 JRfXRU9V4fH/2qizQ=
X-Received: by 2002:a05:6000:2007:b0:492:a2cc:f2f4 with SMTP id
 ffacd0b85a97d-49c72c9be17mr215494f8f.53.1794506051838; 
 Thu, 12 Nov 2026 09:54:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60da0a03sm375771f8f.53.2026.11.12.09.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:54:11 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:54:09 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: 840b0bd7cbeb34ecb479f1d12302b8c037337bb0
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 17:54:09 +0000
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <30d90d02fc66993f9498f04c818dc97b40a73ac4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRZ06-000000008Lp-28xA
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: reject
 a config file passed without --config
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2572443313591208825=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2572443313591208825==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7wX2R5wDlBw="; charset=UTF-8

--7wX2R5wDlBw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Heiko Hund has posted comments on this change by R=C4=
=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=
=3Demail )

Change subject: openvpnserv: reject a config file passed withou=
t --config
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 5:

(1 comment)

File src/openvpnserv/interactive=2Ec:

https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2159/comment/095c33f8_d42f398c?usp=3Demai=
l :
PS5, Line 358:  * openvpn=2Eexe takes a lone argument as the config fil=
e only when there are
Can you make this doxygen, please



-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf=
9cfcf
Gerrit-Change-Number: 2159
Gerrit-PatchSet: 5
Gerrit-Owner: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <ant=
onio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Anto=
nio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Comment-Date: Thu, 12 Nov 2026 17:54:09 +0000
Gerrit-Ha=
sComments: Yes
Gerrit-Has-Labels: No

--7wX2R5wDlBw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>Heiko Hund has posted comments on this change by R=C4=83zvan Co=
jocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?=
usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpns=
erv/interactive=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159/comment/095c33f8_d4=
2f398c?usp=3Demail">Patch Set #5, Line 358:</a> <code style=3D"font-family:=
monospace,monospace"> * openvpn=2Eexe takes a lone argument as the config f=
ile only when there are</code></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Can you make this doxygen, please</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2159?usp=3Demail">change 2159</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7c=
f9cfcf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2159 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt=
;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Thu, 12 Nov 2026 17:54:09 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: No </div>

</body></html>
--7wX2R5wDlBw=--


--===============2572443313591208825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2572443313591208825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2572443313591208825==--

