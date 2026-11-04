Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB40606A328
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bFiZt+PB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Jo8Fwdy8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W9egqbmZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Bxs0JJKc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7etE++IAJLt9hwbF1M/JT75D2GkYdFm8KHlcKT/ajjA=; b=bFiZt+PBCnif6y9F4CnFGcWfKh
	NZpGsPhsyuELhtVq22VSN604nodWSYQwUDk7UFUN58hMuDCsjK6blSDK1DZFdgHA8fP8am7NDTCvA
	ZRf7+rGr5du+u19EcTVUKNYtJjnxXSGVxJix7vMTMbS39DcpcXjSEML0zTy8D8SPosWI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOaAY-000000008LD-3cYR;
	Wed, 04 Nov 2026 12:32:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOaAX-000000008L6-0nWy
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:32:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tQF3CW/P90HkPceoGRMfuG2GSWzn5RL6JbXV3etjc4M=; b=Jo8Fwdy8/xNWtqrLEZVM7QZwcz
 poZ9nfLMdoxWVbpbI+aDTiHvED3gfElY0ZgGNvmgel8HKL/GWiY1O3ksJohwmJ63s2KZWdI/aOZtK
 C54OyhuNdQOXUx8Zt8OXOABDtaiZQOS5hewcMQHnYtfZ6wTk85yP7h3CqEQLaADp9DMw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tQF3CW/P90HkPceoGRMfuG2GSWzn5RL6JbXV3etjc4M=; b=W9egqbmZ+L0IE1ZPrzJuXK9L4x
 G3mip1TRQYWVQKeFm27fCKFRy9RJqK9IeZ0s44VzBLC/IIr2sS3JbzAVyyMI+Rx+q6wuEjK7owI5A
 gTNtMeYTFUVTIDXiw+ILkjqGbXOKgPRXOBslzO5IBMW+ern5QPpz1UTo9hPQY2ENO3JI=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOaAV-000000008Vh-38EE for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:32:45 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48e47347279so380907f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793795557; x=1794400357; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tQF3CW/P90HkPceoGRMfuG2GSWzn5RL6JbXV3etjc4M=;
 b=Bxs0JJKc5D+bQr7lrzDjjTwMdhiTO+w4RzMaMPeDardm+CyUmwFBlwsBAyXhHAKiYs
 h4HPbLY+TJQfm/ulj5b/FF5DYuCPCMcl+zfELzAsjBGmeacYmvZ5MXCR7GhhfvlS5J79
 speVYJDVVdVx00HhDKCPeIKtsfouUXoEmdKSz+P45Ze1k6rBZeIR2n8prfA+YNICL/gb
 TFJX/pBmEnRgcQEJ8HkbnKelTuqDo+tCzEDR4mxrZnyM32nH6GZQEXLo/ByBzad1ot4S
 CSKOKUyy/AK502GOas9VYjD558m6iE+qYni04CLq3TnuTvSLLwq8HgJxOiCRFkLcyz/q
 ff6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793795557; x=1794400357;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tQF3CW/P90HkPceoGRMfuG2GSWzn5RL6JbXV3etjc4M=;
 b=RugUsI/GLmwZelYkzCUDwPaVEzrTBaLfl7tlY4jZyheJpn69BbhGaxvVP3PovHIvxd
 Zy1bwnuFW0By0WbXOA8avYidz9r99VR4GhYKpyXHLGLpTOtnDYvnqb0dk2lu79IjOUK3
 3dClPOanGA7Ls0W2Q54ToPbQ69QtPhA/fHMdfeFiaGGF4mvYUVmZoK3scsP/oddIMyfP
 T+uV0Spe2MzO/mGP4WcEA4Y252IiwKfhp+Ptq2ILfm7Pf0WRdIP2SaUoTxSQiMXDXFs5
 raw/PHhy8KrV5EEQ4mxv7hsU6NtyEIpZaTkwaGHVIxR3Ec9wwjssX8b4HGp0H9atxnok
 gW7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfJpSJyBLdTQwUS+55x27jN0QaqH1EavoGPalHO2rwkPGafrJXK2fFjGGlZGYInlHM7wNjEPE+pnGIWCn6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z90Lgg0Xh+1FkBxAp1B9zuTtg0qXcVBIzmbS0mHKUpb96Pk7BY4
 ywA4aXxrdHkvTOtp0XM6T3nBDkHnUswSxqDVxCTXs5/tc6JFfJLWjIxxp68cwIRCgYodmsjEkeo
 JZmoHbcL2jEii++Q2LMAqrJNeQkCh7xHSFa9Xmcnm82qXiTAFfgARU3aZ/p61EwWlOB4e
X-Gm-Gg: AYBFou0kK8etgFl/gF9X7MqiqXyAK6Nn7Wt3X54eWfz3GIHVPgy/SRhocHEOLs3EJ1O
 e1uk7T/vDpXKO0s2Qx95WjzWWSRI5umx8TYSyMTOhUoksEQpzKmNibum4Q812Y2qI/r0523iB8Z
 QKnmCNuLhrehx7z15L+1+kDWx6bDpa6w4dqMhDVhvZihNTiLEiuDp80DFa014c3JLU7KlIEf3ZO
 F2IupvDLE0XWQ179FcxZ1q4IwIVEgL9AUv87TelDF/PIlBTYEBTGFbj++4fV13f3KpZVycwJhdj
 zKQi4GX0f225YJ1zjbHU3v04ZejuqMq8UMfJTN/T6FCYGISMeguTlshLZvIvtA/M1kiNfFX0Q5c
 yZF4ylZ5DZ7rMru5N4oHs1iC6OpDY1DZlRou/01dODuPysRztUxv5UlGZe2AcbeQvRlKpnZiy44
 RgIdsdsfNV33AQSbXWbYXOLpygxLY3O5yinC46FIjKFRSLLM+gGkDr5sQsnAMmdcRfg/hmGX1KI
 w9dspAFiZOHpNZ+Uyll4uOffKF/Cdw2UWlzdCbokpv5qR8xV2qMDbvPnnpTTGWb3wa61OD7gos5
 QiIJud+uxDYa+fG4iXChI6vX0Az8jTfjLYjUh+tCEPpbm8m8kzFpd9yZplSl+Ntp9MJFANlBJqe
 92/szcSlgsa0RPO5iAlIXCTPFEYGSayVfgE6pBYfCSsdARGsGdzFKtS7u96KRGsipBurumPDdaC
 dWlJIvYDhMRl41Fw==
X-Received: by 2002:a05:6000:29cf:b0:48d:cda6:4dd7 with SMTP id
 ffacd0b85a97d-48e6e4ffa15mr25130791f8f.44.1793795556967; 
 Wed, 04 Nov 2026 04:32:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea181079sm3981805f8f.8.2026.11.04.04.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:32:36 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:32:35 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd
X-Gerrit-Change-Number: 2127
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2127?usp=email>
X-Gerrit-Commit: c713ad00acf2c3fa70dc51c9281ba60ea9d3fc6c
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 12:32:35 +0000
In-Reply-To: <gerrit.1793781422000.I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd@gerrit.openvpn.net>
References: <gerrit.1793781422000.I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzgxNDIyMDAwLkkyZDY3N2VlYjZhZTkxODZlZGUyYWViM2MyZTBjMTJkMjVjOTM1ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <399694b4ed6ab4d6d7a0ebab447cec084e7d2fba-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOaAV-000000008Vh-38EE
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: return NULL
 when the second adapter info query fails
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
Content-Type: multipart/mixed; boundary="===============1394756461576380588=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1394756461576380588==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BQSgf/B6GQQ="; charset=UTF-8

--BQSgf/B6GQQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2127?usp=3Demail )

Cha=
nge subject: tun: return NULL when the second adapter info query fails
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2127?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2d677=
eeb6ae9186ede2aeb3c2e0c12d25c935fcd
Gerrit-Change-Number: 2127
Gerrit-Patch=
Set: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Comment-Date: Wed, 04 Nov 2026 12:32:35 +0000
Gerrit-HasComments: N=
o
Gerrit-Has-Labels: Yes

--BQSgf/B6GQQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2127?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2127?=
usp=3Demail">change 2127</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2127?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2127 </div>
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
"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 12:32:35 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--BQSgf/B6GQQ=--


--===============1394756461576380588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1394756461576380588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1394756461576380588==--

