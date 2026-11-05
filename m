Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AAE606A31B
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 05:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kYeEZOQi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ese+Q7or;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NDxi29z/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=E3DTYKkl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vKM075U1hsG73KkIipQlU1hPk5jjk47WVaSQTET5n8c=; b=kYeEZOQiFx1unvDNULu/R2kO7j
	lUa3Qic+iWElJLaZMvaQzg3MszM9Gg3xJcRU/GRXcdq/HEx6z9710D3BuH7EPO6UETVoVl3j2mTF+
	K+ohC6sqrPU1x5eIaIGBA+n/hKvXSmhyTsS4Ant0u2xmpP6ol1dJIUe6M42fuF3lM2oE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOqFC-0000000012Z-04aw;
	Thu, 05 Nov 2026 05:42:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOqFB-0000000012T-0vfV
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 05:42:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8/MawGmNSd0XB7ISwXkxO5YXpMZLXpRo+YG10Ah2vz8=; b=Ese+Q7orTWWp8HsB3oR0s/P3dn
 P2F61UKk+mb4hYtMbAUBFnO+tz8pINTooRa/X9KRpHTQUvNmmQCMhKOJPmGAfOT/+Mafz8kAn+yCY
 VHQy3WrsFSrzAiWEKhdQf2uHTzjgeZIlEiooPK12R0CEAhTNmfPM65Cd9RsZGN3+O3O4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8/MawGmNSd0XB7ISwXkxO5YXpMZLXpRo+YG10Ah2vz8=; b=NDxi29z/hNCouiGpDXkcLP+kGR
 atBe2bWU56uq0SOaT3oFrC6zVniUacFdLYwseAfBbIIUAlpZR0kb1kYvn9WSzL7eIx6jut0feHUOb
 NS+u46K5oQNsmnnjFlHmF1raY7YXBmO8k9nyktXluZBsjtcuvKiQh/X4AXJBPvU24hh8=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOqF9-000000002rW-0HF7 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 05:42:37 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-490d59c3f0aso308260f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 21:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793857348; x=1794462148; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8/MawGmNSd0XB7ISwXkxO5YXpMZLXpRo+YG10Ah2vz8=;
 b=E3DTYKkljjZf5T8lwYXFpWLYsQgLSmsMJp+vZtye8VxMymBFijKzbziioc2Va3gRpC
 goBrmcHOukEhehwp5T+LYnoSQLf2sF04B1WsnF3vbNg/aiE3y5PWVdch4R+ATwPDxMYm
 VX3lBSMHPJoQvRTIYe77X/Zqw8j6gdf/NijAMqSnzpoYLRkZ+8EHy7qVXqemyBVOCaZw
 /e1q5WPXIu8hzlkTwWUZQhe9chm8nr/DUjF2NcJIHabzUct4Gu7R2Sh1oG1FY9EFUf5g
 ontVZkkduthquYgXrzKWXSe2cOgj8j6tGO21Oj2lGQEmyDoyKqsUFtnV0sto3J1IAZY4
 tLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793857348; x=1794462148;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8/MawGmNSd0XB7ISwXkxO5YXpMZLXpRo+YG10Ah2vz8=;
 b=bKiTbHGLSgoZJh75tdWdzhdG249Cm0W4p+2cVQEigRF/KZd9ejIPEs+14wt3Y7mS1Z
 /okPB2hEOS+PwD22D4WbKNReB1XMCS3Dr0+Is1hhfYQtmqCpRkqFn6CrZioiBRzG7frb
 9Zc/xfIwV0j5yp7/FuGsUSJp0DlBZZzX081hfly2kOoy6498PqEItptABZGaAmG3kyWT
 BDU7idPKGMnI32RXIg5Znm5AJPNYo5zdRralCwg/wOphOP2LX53PyH+Vg2pxmRZsItJj
 bO92cvD51tcurvBjNtAZSBDshV4tc9BNJ8QqflJX3A3B6442BbxGguBl7K+b8l+r3adC
 b66A==
X-Forwarded-Encrypted: i=1;
 AKwUvByPAjOfxCGI7NddJKmRVJHdiWpvEKJ3jOEhoIVVlwFt8SntpsoMjT1A9OHocK1+UI9wHk9sC3cKb/4R2S/Z@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+rI7oiii9E9qJiaEZhkwZpT7PnAJ5bQpcM7CwRmGD55WHZmjnp
 cR9MUBp7lMdDW8CUk9Rfmx0MPC9TwTrMCl1RmLu0y8gH1rVdmZ80TDPgk82SvXRXCMjdrSuY+bh
 ylDzpGhHiAGEb8vOdwgir3GVphscKOX4hi6FbCDT+Dm+oEXKPHO/yTfb5hoDWMc1T+iTDf92qCD
 wjzQX3+Q==
X-Gm-Gg: AYBFou1j44CNjXbArPpj+KozNO8O9j9GzmgKtv4isKAnABzRhaPy0WpRya2wKJHPREo
 hY3GbINt2MtY5Dnj3eXH+8EzG8OmYCky1VQVc1CBFZ+qdNuXXxHBqG7AbZzVLKVdFAtHaJXZpmD
 Q3D36xaTaiNRioquB2MM7vQ7jfgOOUhTsGfNF0VMR6aosOKgSn/DNGsWomMEO9/kvYglEfRSiVF
 2FiR6a343S+A4eAc/1RkKAlndzQg4+I7G9VNiEzBMSzGCpGd7IvRd+jBt1VD2AwzOwPCThsmhLr
 36a5pAyFnYqFZz6CTzTCuE4zxH+brwunKchF9q49NJKmb9KArcMBI3BHOqG6waW9tcr5OFS/2m4
 JRFEmkNs3VSdGbYC5pHDPGikIw9rKDyVqA4UMHpCq/7cINawC5L2DCDicffGPhWxx1qxOzYnskn
 pkpnfLC7Lv1u0kvtjk7GK6txeUvy1q93n4I2btbIPagFU3kngkUYAzHbEplaSNe/q8B2095LCMA
 as+MDtQmdUbA+jTbx3MQyKPsPpVGpJ8jRi+qZEYY5J/rB4D1xfYVwmzZ92jNBie8Bq7uK1kR/bj
 4/2yzNgzw8wT1KoQsTytXaF8HB05UFT4Xh4usY8Xem64WpDiKTmoTUqh3GHotn4gmyxFr4Ql3+G
 ADN5ZT7lqk8D+yCazIDBP2cZOM0f8E1bVjUrKSTaBRZiWTSivF99cdAkYWmcvCNvIwqM9SB6CT9
 S2Ko9b6/NcAJ+kwQ==
X-Received: by 2002:a05:6000:3109:b0:48f:bcbf:26fc with SMTP id
 ffacd0b85a97d-48fbcbf2c1cmr12221116f8f.53.1793857348205; 
 Wed, 04 Nov 2026 21:42:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed0844c8sm8246844f8f.26.2026.11.04.21.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 21:42:27 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 05:42:23 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270
X-Gerrit-Change-Number: 2061
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2061?usp=email>
X-Gerrit-Commit: 08f4044a258ce40d8373160c19d5042e86583b6b
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 05:42:23 +0000
In-Reply-To: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
References: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkljMGI4YjBhMzI0OWViNDFlMWRlMTBmMzgxOTMyYzExNjFjZDc1MjcwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c33ef1b4673d1ed1e3d92d3a979ce1be4eb018d6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOqF9-000000002rW-0HF7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: track installed
 iroutes separately for IPv4 and IPv6
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1019852415890957895=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1019852415890957895==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WjtX5+HWcT8="; charset=UTF-8

--WjtX5+HWcT8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

R=C4=83=
zvan Cojocaru has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail )

Change subject: dc=
o: track installed iroutes separately for IPv4 and IPv6
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic0b8b0a3249eb41e1d=
e10f381932c1161cd75270
Gerrit-Change-Number: 2061
Gerrit-PatchSet: 3
Gerrit=
-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 05=
 Nov 2026 05:42:23 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--WjtX5+HWcT8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>R=C4=83zvan Cojo=
caru has posted comments on this change by Marco Baffo=2E</p><p>Patch set 3=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail">ch=
ange 2061</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2061 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Marco Ba=
ffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Thu, 05 Nov 2026 05:42:23 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--WjtX5+HWcT8=--


--===============1019852415890957895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1019852415890957895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1019852415890957895==--

