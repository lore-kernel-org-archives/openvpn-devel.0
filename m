Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E5606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eYRRIEf4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ScOoXJtS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Yj6P0eFV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EQk+LrCM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=y568QtQvTirZszPqLZfAG5gZvbaZzCm3tuf5cr/4LYA=; b=eYRRIEf4wZ8OB+B3jQQSF1BreH
	Buh1JGHn+XJauJyLx+GhRD0AfqlxiY/koMsktWg+iGtav8tF1c1FSDVQfUH46JJ1XJaIbabZCcasE
	alKcwC2+avC7Dsiro0zDcudVM4AR9iVu6reJm+6HUTsuTH+0f5TUXt0SZ0K1bs0uBavE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU3E0-000000006Rt-08iT;
	Thu, 19 Nov 2026 14:34:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU3Di-000000006QK-30Kc
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 14:34:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0U4k6/VDMqJ16LTnyWJxVlaOjK/z0PDA1TGUo8XYFFQ=; b=ScOoXJtSUiURkqpqXGrLLNM8iH
 HSFwDRaXs6jZCMVMaYiHdp2xIryXUleV4dwFYor5wqn656+t5xtSGiAHWl+zD63Z5qGFf3hyTUheV
 33V/Nwb9DcxMoHicseAuw5SBJmGFKTiZouLLlhVsQblTyE51p4+AFfXByHYhcgJvaONE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0U4k6/VDMqJ16LTnyWJxVlaOjK/z0PDA1TGUo8XYFFQ=; b=Yj6P0eFVyYWpaKyKMy11MJZLXE
 LeiCxXmpFjUbMPVeyrzoLEuUWKJVe6IFM9ZTQpEkHeb+mzjLqha8t/i6I9PJ0ImK0t/fs72b6heWm
 kV3NByjxVedRZ9iWlGThB/i0WihZlTlMGwCFCUBd3AlqJSh77p3VvfePCEpNlXqkakZA=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU3DV-000000003As-36xc for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 14:34:27 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb6057b333so11429545e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 06:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795098859; x=1795703659; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0U4k6/VDMqJ16LTnyWJxVlaOjK/z0PDA1TGUo8XYFFQ=;
 b=EQk+LrCMp3HG8Ek+YCQZwYWTr5fRbV8UlR5EZBQEkq6VqOWut3tyEJESlQlYE6r9Wo
 wFPzSukK9ZAt2Ir2NKWdN7JiiAMxoTNORdmDun5W3scGJdn+LmW2gkFMlQIH1R65Lu+z
 wjNAjKHa6j+fhIB/JsK+DJM+0ooe1JMZ6joCLtqD3vXqjodJAhxyBWAF6iKQHM4WG5Ht
 vdOxeYkR/I4mVLmgwFZwayNraLcy9suwrRXUfY7lq9qDp5yoOGXmVeefiqVjC2INAoWT
 W3e5ahGuuGFkDFM2ND+cL/AblbhdI1kdrDeMke7R4UPJyw5c53syxIwMb8vZcHFXqu1C
 +AvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795098859; x=1795703659;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0U4k6/VDMqJ16LTnyWJxVlaOjK/z0PDA1TGUo8XYFFQ=;
 b=hHPOZyW/UjedpVrg1grywETeBGnh+TaxkQIXa6L5miS4Uck3KInzr6oeWzu4gdcIfM
 Q/PHYn9ZAhNMyN6igjxz5XBiCVh6VR2CYd2D5BChAK8BfMP5lWxgQSm5gM21bUW/r9GE
 SOizVznp8jHFt2+ckav9jezQAxMdM/Axyr6bKmXoazLJGENLoNZGFIUVZBp/uSge2fVu
 +RKOSVSFYHj+0VHyxTT7lAR1D5goriwJ4D22PSNEvwVZNw4vk8sX2CzsAkQxe1iU1pG6
 8bs3Lfg+VPJwzsYXnJ6BHp7JvJcNhVuCuVB0IWp+Eqwfj76W+vBoQXx6GvzJXi8NSjvE
 RTCw==
X-Gm-Message-State: APuU4Z8x+YI7xbG5oBv0cZYH3tLatNi98XlV1mVHbmkqH6gEmEDNuE9v
 D1pW6JcVXDeKdCtyJtUoXvH8MqLi5/22q5gUrGwu17IJmRfPA542VSGepN1TE/7iFTRknVRu9iE
 rBRb5cTMI3vQErDZNGNDIGkBrUZdZ8nu4OR7pF0v6FloljJLL4eEBanEv06oouARXWUJG
X-Gm-Gg: AYBFou0felR6VTFtHd17MOi265nq+/XnCsQQRS0BPPYVEqplIfoyxmE3BdwJUe5q8IS
 zalRzM3icTIPg93acqxOqiCyzQPCM+nGDPey3B9ButpuZ8bzMQyW4lm7r8ZQF15E4Rw0Ubap7sg
 jcVW/0w+FaJ1A6JuGalOs5BNzGjEuRGYlwFvJJta91k5nlf7ktr8Spa1PMo5CbZc1/Od0IHZcl3
 73aTa6Syvt/7ZTAyhqDe0GW8ekWDFXKBFgb04dLpAJzqSjwqcXt1PP0/ZB3lFG/HpW7e2zU4LHx
 2VlKoxZ5hQSJOmZB3haQXeqripqC+ejWbyk8TaUnHbpL6CTJo+o8v7EiF0LozMHS+K+hqKmD28V
 zqonXo8hvLFX15YQqQF4WEmX1C6PC/JS2WPDTWt7ViBnwckB3hc1+q21rs1dmVx9P7K8jmSmzBZ
 SId2gv0QiLMEHMEzrLKh5R/vUcEFy+iwdd/Lp9JxBAFMf5Lfn8mb4XIsRzf1D4gow70XuvXDGkF
 hp9oOb8p1e3ojVokUEmsogyssT3Rl9LvYiUkjPmqtZLI18CRY402zZrX91fvZOh2DlfmqGHKf9w
 laeFdLN52RjK6v45TG1XzN3G+ui4E6+sYLEyxlJAxS+yazPgWoKDoStKT8vzRLP9svZ2R45u7ec
 vd7L7qCAlpCR0yLf/MDsZ+x/9gPAd+re+/iN6cS6dAj8E1Rka9OpuG8nk7YO6uY5APBMNCIJk3f
 aTVHBB9ejK+j44Foo=
X-Received: by 2002:a05:600c:474c:b0:4bb:6a2d:b426 with SMTP id
 5b1f17b1804b1-4bb7d5d40fdmr117019665e9.1.1795098858873; 
 Thu, 19 Nov 2026 06:34:18 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab5490e40esm137893f8f.27.2026.11.19.06.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 06:34:18 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 14:34:17 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ifbd6badab31a48653fa0bca7f086db058f83f891
X-Gerrit-Change-Number: 2191
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2191?usp=email>
X-Gerrit-Commit: 90464f81459cfb25262b733effa6908dc2484de7
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 14:34:17 +0000
In-Reply-To: <gerrit.1794830847000.Ifbd6badab31a48653fa0bca7f086db058f83f891@gerrit.openvpn.net>
References: <gerrit.1794830847000.Ifbd6badab31a48653fa0bca7f086db058f83f891@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMwODQ3MDAwLklmYmQ2YmFkYWIzMWE0ODY1M2ZhMGJjYTdmMDg2ZGIwNThmODNmODkxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <88da0b4992cd81f283521c8977a920527d93b36e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xU3DV-000000003As-36xc
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_verify: remove
 script temp files on all exit paths
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4413891483462102425=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4413891483462102425==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E/ndbQMLLpo="; charset=UTF-8

--E/ndbQMLLpo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Arne Schwabe=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=3Demail )

Change subject: ssl_ve=
rify: remove script temp files on all exit paths
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifbd6badab31a48653fa0bca7f0=
86db058f83f891
Gerrit-Change-Number: 2191
Gerrit-PatchSet: 3
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Comment-Date: Thu, 19 Nov 2026 14:34:17 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--E/ndbQMLLpo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set 3:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=3Demail">View Change</a=
></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=3Demail">change=
 2191</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ifbd6badab31a48653fa0bca7f086db058f83f891 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2191 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Thu, 19 Nov 2026 14:34:17 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--E/ndbQMLLpo=--


--===============4413891483462102425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4413891483462102425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4413891483462102425==--

