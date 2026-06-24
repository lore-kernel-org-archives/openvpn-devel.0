Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4372CDB481
	for <openvpn-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uNoRaosAjLQAG0CpfzK6WPI+S+sk/acbMiFrjQ22kyI=; b=gvcG8UZodJs1ENT9xIaL3FncTx
	G19xxJEK6CE7G4pkBuXMqS2uc1opfNKw5IexEVmWvyh5XErVR+jq+ZvD4gl59iHWjKVJf47/H7iXR
	TZicUdmVI8LFpTOtGYY4IIz46iDpcTqQ03Y6cch1buTQ4qKHkyJr+axy3poVA8zBIEBc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcMaO-0001mh-Dq;
	Wed, 24 Jun 2026 12:20:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wcMaN-0001mb-A4
 for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 12:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=k3XPjJHd5eD/D8aOsQFzCy1DWYUVDv273McHpkl4ptA=; b=Qpny4pDOjWBodkqaM2IB+zwuyv
 Vh4G3ioCRmFEyoIziG7JDL8cVWUMXXK2oXfEG/dKrYgvQ956FEfV0N3dTU83idGrtIJPd+aDXrgQs
 WUaibqF29SSlVKrOpDdhCOEFQ1ICNJL4AulExBoGETEMRw1JfQdlbzvwlriufYbTJOlI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k3XPjJHd5eD/D8aOsQFzCy1DWYUVDv273McHpkl4ptA=; b=V
 KPVOVOZgrT7A9UZMKfPOsuIuhUqhEGXtKRwj8ozaPNAidKp3TIfH8DIijYkht6WrGMnIVI5B3TJn+
 2ICFhfjfpYCLEtPdan6rUfVHBKAE7WMZsrvIP0wYRuXgcz2lNUZi3uKH/XmBMNA0AJ21Jusz/mREW
 Ox/Zz1jOeD5lvI00=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcMaH-0002OL-QY for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 12:20:04 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49258ac7294so6554855e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 24 Jun 2026 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782303596; x=1782908396; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k3XPjJHd5eD/D8aOsQFzCy1DWYUVDv273McHpkl4ptA=;
 b=eCp5cvCR8dIUiIkRBluSNWqXQjniXhEzAFc5dVoNy2DXo4veBTf7IwCFkb9UzMlwcE
 lPxARUPpO5TfGUhFWbOj/lbJgaLmKnbBgWG6rvLQDOYSDuTq9dl63DTd7LX/FHHj2IMp
 OmPlnwCwe2of0MOKqEJOLztB/0nCvS8OhogaUpEZ9sw9rtXHwFuOYnymSehGSzV9Ipj1
 FZFDNkZINpWkHDRwYnyPpGgUTPmRAbGjZu2MjH2UB8TXKvEnlPyJ/I9wkFsQJlw5CWVU
 9O6j1pB4cXjEdyzEG/nxAnhaMjk8rCMqzkW8O0dggAyaMM+Lp3bdrNaKRlI8HTA4rgnq
 bAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782303596; x=1782908396;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k3XPjJHd5eD/D8aOsQFzCy1DWYUVDv273McHpkl4ptA=;
 b=afTRBu8jrFIQE1lfs8KqwKXseKOslu0N5NsVR4p1EkuU2lx4+WHGEaYOgfs6HYxiix
 +pK4DqbfyKmYfK7/LzWewPKg7dxv+l8HeXZrTfo+PAJ+hcnsWmvSPIW3YqGf2E9BgcEz
 Ux/afItobL+B0ovIvF3no/mwz06a2gT1JWxUG4ECs2C/v4AwL65pkGj30P4Bg5vJO2a4
 kBOv8c4KTrza3Auq1yShzzcoGNRjyzq10JSBwrsKGSNhLmQuhZs7d57TXm7L4rCHya2y
 CkvkdISuhvVCuXr/kl2Xwgz/AK8kpGohyO4pE8SBCSENvA9PEzoaCUovlz1L18hkPjK1
 x78Q==
X-Gm-Message-State: AOJu0YxD0JQbNLD3Jwnxa9F6pTt00TPxtzHcvM0Xe6/TnPfG0EtCxoKl
 RnvghrCEEBQ107UTo1KDEh1IeQaM5fz/TPPqbcGJPWfoZfnNihiaXgblTKuZ8VOAOsbWnESTrWQ
 ovuszI0/Gzo/VENIftm97bRN63wGGZnFK6Jo/I8qrh97MpWf5yj4huayUarX3vhy0pcEz
X-Gm-Gg: AfdE7cnEMKX82yGVqzwCH1kfMtCQv7KlMOWC2ki2odMJZCp/4cYpySF9plkFnRycZv+
 mhr1qK6OO6kLnamocFF6h85LPBENAmwn4moitAQoKaE78n9QrE5cl2Wzddd3NFbx4Wsra+ag8yM
 KfrGCbydFvugAOWvLUO0s0Uz5ZjdKpmzPP2B3Y00n03XNwCtUkPEAWtBtNKA9whEk5swjX/9PlI
 1P+0vLOthnw8myDMYdhTV1F938d0edKuN0qz860FRD3fODcLY8mNGn5wZvqyGOd+LwOW4qMGeWc
 cBanPPdPZGRJgwHBRPwu1R8lAzYSiLQfi37Z6XGUWAUYXViTl4icd0ZE+n5S8mY2lzHygyLx8H6
 tx2EpWUGe8HjEqcgR9Te1yKCn8pU1rM2SN4q+M03OzUydhuaYyFGTsJCrcQujXFVv2DYVVpiwFd
 hxkA4Mhr4mRYCcjhk4R5ws6dSBXVejdAE3nudW96EkVkvL/aDHoIvk/Kta3R7eCPWNzcKNw5aUA
 BWxJ+mio/vQBPfubI466iQ4Ht6Z+Uz1rL/w8cGb6/Yj9/iJt//grwK2PmxxYvtu8J12RbNfThnV
 ais=
X-Received: by 2002:a05:600c:a010:b0:490:e974:e006 with SMTP id
 5b1f17b1804b1-49260878d9amr40320805e9.29.1782303594460; 
 Wed, 24 Jun 2026 05:19:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249238bfbsm391488935e9.5.2026.06.24.05.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:19:53 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 24 Jun 2026 12:19:52 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 6157655f2875cb95875b2fc9181c2c596c9e1780
X-Gerrit-Comment-Date: Wed, 24 Jun 2026 12:19:52 +0000
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <73b93d032be7d68cfabb9e51cf4ec78920f835a9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wcMaH-0002OL-QY
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Replace custom
 hash_func with siphash
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1493246846386596559=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1493246846386596559==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nOLN1uXtqy4="; charset=UTF-8

--nOLN1uXtqy4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1573?usp=3Demail )

Change subject: Replace custom hash_func with=
 siphash
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 5: Code-Review-1

(1 comment)

File src/openvpn/siphash=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573/comment/dadb6552_2657a7a7?usp=3Dem=
ail :
PS5, Line 46:     if (siphash_cryptolib_available(ctx) && false)
Debu=
gging leftover?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1573?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I80=
7f398903ac2047530800c29949793c6f4f0ec9
Gerrit-Change-Number: 1573
Gerrit-Pa=
tchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 24 Jun 2026 12:19:52 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: Yes

--nOLN1uXtqy4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 5:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/siphash=2Ec:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/157=
3/comment/dadb6552_2657a7a7?usp=3Demail">Patch Set #5, Line 46:</a> <code s=
tyle=3D"font-family:monospace,monospace">    if (siphash_cryptolib_availabl=
e(ctx) &amp;&amp; false)</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Debugging leftover?</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1573?usp=3Demail">change 1573</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1573?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: commen=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1573 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerri=
t-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Wed, 24 Jun 2026 12:19:52 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--nOLN1uXtqy4=--


--===============1493246846386596559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1493246846386596559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1493246846386596559==--

