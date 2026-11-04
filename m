Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C34606A32D
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MPEe8M77;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g/eWrwEM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TbSKvQGF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hSQ2uI75
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VcGW5hUOKuFeFW7cZRD06vYbjcanCmCqmoIT8jBDWZY=; b=MPEe8M77pLL2zwlmqnSzEujOxn
	yZtgn2h2fmumNpQt8PwOXvnHtde7GiZ0MNMylPI7KYrLgIaQsqezwI11h9BcwKYvRuEAca97F+laT
	j3ubNazb8U7lqBpUWYQ2qg2CdzHKavynupCsZBo8mkQJBChPNieSUSF+6xBAG5EUxH9g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOa1L-000000005oq-0YUp;
	Wed, 04 Nov 2026 12:23:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOa1J-000000005ok-3Z4s
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:23:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hp0jurHiVDYy09TMnr74nXvOVjj/4WsTAGwKp/ru+sQ=; b=g/eWrwEMPPQVZRX0RROQKZG6qX
 UAjyGQK7q1tpZHnDS/87eUu5fhoOiI4kfCYZxXP4AjEAVBuAz0b6Ro8aG4M+yA7B0Eit5dkM3zRYN
 Z1hzG8Uv9hSVEPs2H135E/4AYUe4mVXbwjPh4gLLHHEALeHiKzdb74gvixxlzielR7mU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hp0jurHiVDYy09TMnr74nXvOVjj/4WsTAGwKp/ru+sQ=; b=TbSKvQGFd6kjSWKWej/J5z8inv
 GO5L4sIm7Pv8wLqqnLaNZnWWRxGtgXJJ3pOTKeu2Twf6SVclY20CNcmGTWNS9lL8cjcCVOh1l9VNo
 WCcBMb1BR37rAjUFYF5khx7UjNVf6TJYI5AHpEQsiSuQ/FNnti30z0h8Iz2+2FFXVO8E=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOa1I-000000008Ap-0V2G for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:23:13 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so612382f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793794985; x=1794399785; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hp0jurHiVDYy09TMnr74nXvOVjj/4WsTAGwKp/ru+sQ=;
 b=hSQ2uI75eLJCgJ9XR3ve8BV6zYdlR3/98deAhPkCpJrNaMQybJY2iRQJdrWWeclTot
 rtz7GvltVkp9dkOByYzkyk/B0qa48JTQK5WNZQhXZjMd+ybnHzEvxPe1U/StL/eKnLiN
 JZT/ii3Gy0oR85KUImcRWc/5nsK/yFKm8RgAohngE6Rwy0KogCYvQfUBku2gNY2c0OeP
 O5IRA3omuyxgMAAKSMeyOIQladF781ifowRkW6iibJJlBEmL4gl1GB5b4sTwo/Taf32z
 uDMuJ2e9XQ8UZWKgev8lZsMU+DE+imdPISq/vmVyotDFhdMzIpx1GFCNC5/TlD8uABsI
 9EZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793794985; x=1794399785;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Hp0jurHiVDYy09TMnr74nXvOVjj/4WsTAGwKp/ru+sQ=;
 b=s56Lua2B98SFxDmTQ/ZtPJs0OU4icDJtx29Jl0LKF8h28KA3rE5OFo5+XS+DR8siFk
 vkLM0k3ob/D4ZqfXDwAqGQxMv2UbulV5TdXhoJwunjY4n6wo+ft7ZUEE9dV7YUNGl0nK
 8lKUn6SbgUn/qU4M91usKH4/LOpquTwiK0Psygk23bZWkYU5+TFa+s1b9laM4rqwGh4q
 DtnxTO5n3wYuqloaWDxrveiHzvRjcVyNh4SSKyGmN+cla4UITqCC0n23Q9x4Ni5wMs/q
 /hfliEsecDg39yeNbi490eZW8bt7ROYzGQYZ6MoQkdlkp9WyRDs1Z5K3khUDpTI/ZB1T
 03zA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVbxpfgmf19ayb3FN0aptuusgqMmynhHlW0KKSSUbV7cw+OeSFlQHUPJEbX54JjPIaWvU+76JRDX8VS/xF@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+/LTuux4pT40ERDX8bPibW615+CesBwDt/h/vZMIKthdgcMtiA
 Uy4QePyPr4oRRZiq6tTARN3cUeuXnzAZ8UhQgyO5peL16UNHOIhITjKUCUgZSYvg8mlVGEWNPlU
 QJkcOD7N9FvlR9P8LUskzzEpYeA+rHj8Pi0z5HqZfbEjCZDAyhT0v54n8f31I3tPf0BMn
X-Gm-Gg: AYBFou2cEd9jdktio22K8lt3xw8afKc1ATlG1hylQS0elx4QSj4uGrT6R81wCgJEGUg
 MvD1dYIWODPE6mqI9rhnbEl7O7boP2e1/ASulTFtMLXhWBJmACVu/3vWlZeUbvOyO5OgN7iQvMw
 U5j5AyJEFDKTWznVNqgkGDx70xRV441UqXDnTki53DExNebbSfDe2dTmjBxX7CqNq3v+SZSZR2t
 kXStshL5ETIlHlkN9c7xhKKrTwJaB6TymMuePmgmjTw/KDd3wzL1axBybnDbDLAmAevwb2lR42L
 wyghd/v6o8qdYAcjfYLquMM6mqMOO35tJP3xnnWtOSXEWpK7tS3YY3fNWeDvqVexo+S7viYETss
 c5d9vwAInypwQSVwK7dvRNDdO2YV4Uy7Kxfo470mIqj74EpokpVXG+xTvXB3YQEPGf3H46FtQ20
 e7ASLBGpCw/X1MBMgo4AYT3Z3+uXd2vk2Y0X5YlW2iZo5ZyHnByNBW4+JI7ODyqZJcpoWcqzrR5
 cKlxYIWscl7QanapeZVpFLinf5RD3HVatXwY7l8E1kRUfHZDdjH7SIhYt1eONfuwUPWRKUdbTUu
 3WKnjhbii3lxXvPFaRcRaHCBL4q52ucL092//ouLDJ8r3wuWjdVSyutBGoNfzscOxjJPlYyxHHq
 RnukLhNihUGqa3PCwf069tFlxNE1s3odzas0fK+pgtri3Ty2tXCkRgydVb47kC65wGAShWv5OLq
 6nUdTxGSUL+fhpDg==
X-Received: by 2002:a05:6000:4919:b0:48e:7b12:aca5 with SMTP id
 ffacd0b85a97d-48e7b21f3c1mr25789162f8f.46.1793794985408; 
 Wed, 04 Nov 2026 04:23:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec8d8648sm3769205f8f.9.2026.11.04.04.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:23:04 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:23:03 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ieee93e625bd25f1f674ce1c3b6475fd73770c73f
X-Gerrit-Change-Number: 2119
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2119?usp=email>
X-Gerrit-Commit: 27d14fb203bb18c597ad988d7e1abdb68d9e7fa7
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 12:23:03 +0000
In-Reply-To: <gerrit.1793776745000.Ieee93e625bd25f1f674ce1c3b6475fd73770c73f@gerrit.openvpn.net>
References: <gerrit.1793776745000.Ieee93e625bd25f1f674ce1c3b6475fd73770c73f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NzQ1MDAwLkllZWU5M2U2MjViZDI1ZjFmNjc0Y2UxYzNiNjQ3NWZkNzM3NzBjNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3806b9fe44a4a7f66f77ee292cf85f6c8985b5e8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOa1I-000000008Ap-0V2G
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: lladdr: pass S_*
 flags, not M_WARN, to openvpn_execve_check()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1208239905223699645=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1208239905223699645==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2N+vRC93tcw="; charset=UTF-8

--2N+vRC93tcw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2119?usp=3Demail )

Cha=
nge subject: lladdr: pass S_* flags, not M_WARN, to openvpn_execve_check()
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:=
 Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2119?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iee=
e93e625bd25f1f674ce1c3b6475fd73770c73f
Gerrit-Change-Number: 2119
Gerrit-Pa=
tchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 12:23:03 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--2N+vRC93tcw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2119?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2119?=
usp=3Demail">change 2119</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2119?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ieee93e625bd25f1f674ce1c3b6475fd73770c73f </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2119 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 12:23:03 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--2N+vRC93tcw=--


--===============1208239905223699645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1208239905223699645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1208239905223699645==--

