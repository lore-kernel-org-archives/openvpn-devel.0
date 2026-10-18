Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4182CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6UtIaSGX6fIKCp7X/c7sYgaq7U7N6UALM39JqioCexw=; b=jABvbs52zcx9/MbVFyZEleqDvd
	5d9qQ5VU+6k6rLyzhP8md4BVehLcFANRGqnC7O6G/8v8V9TB4rmQpR6QlbJJhRkFQGax6++5asKO+
	zfBLyZ68Ehhro3KQyPcZJwjTHTaxcUkm7GKHVUX36vmaBssHwSYT5leMqO5ClCHLFy0Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIQbC-00081c-UR;
	Sun, 18 Oct 2026 13:06:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIQbA-00080d-AK
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:06:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=haqEZ35thxKIWplQuRnw8VwVABArqSjdZG8gPRxVT9Q=; b=i3x0plx3Y+IUebr2doP/33VSLF
 KMOor+g4bszfmjVA2WfZgIoKQsOn3wTlj1y142PtkRxTXAZBwrzuBoletUV8xOegTDOHErDMcyAIT
 wxrpBSRF2RBCWTpwbPIOyFYMnxPJrI390k/BUzqjAcEQsTjzMPgfzCxAxp7nO+6Uj4T4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=haqEZ35thxKIWplQuRnw8VwVABArqSjdZG8gPRxVT9Q=; b=g
 BvyTwaMIIIj2zFVOsCFCV50wh4wlfcySMa1r9M2sJQuotUWGC0pruatD+GubcNxkAlKILfadPtWkX
 0C6xEPW8ZA7fZQSeUbSYTfOFTxdusrjGOQBj0YyoZ1oN+X/HKZHBDVK8Yg4uT2O8H5+sYQpYX2eMG
 RDjmYfzliDMBu318=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIQb0-0004cN-4Q for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:06:39 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso857162f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792328791; x=1792933591; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=haqEZ35thxKIWplQuRnw8VwVABArqSjdZG8gPRxVT9Q=;
 b=RXlxtqz88uZkX+37aV/FqbmFMDFOSYifBk3tQWBiexTye1Fcto0WwEoMW1XOQ/nTbl
 3hCo7jnW3MTuOzHGFYKjn4hrYuPpDXt5FAg2ocnyxzEeABDyVrgN1DKsiFPiSPp7ZgnB
 sFtq65BhrTcBgZhtIGDoJlP1nJmhLxXwowIjV0Xzqtc2BiZQPQnsLupXI/ZeGIS1VBaK
 IgWcup2mN7AHZ/o6RAxcQ6j7g1ZrWhNaY/lMMjRK0WVTk8UvZs/hsliPThClWU1AYohv
 +zKEzJQSwXYMl+DKJa3CTom/qNH9uj6BdGGKevqFZox4ECkWAYsPq/ykMYTJZo8MwRDG
 rp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792328791; x=1792933591;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=haqEZ35thxKIWplQuRnw8VwVABArqSjdZG8gPRxVT9Q=;
 b=a9shySLiev9kmVh/IVqy1n5FDU/3VcWi7KzAS0g916vN9erYxvlCQfrm4L6UmuqlJN
 lIXrmKmUxSbcKaMDwgbHnMQrrlN96leZJoLJYZjPwcd9iPGWqdc8FP9rkIrQ6bmf9wUK
 gTggrstZSdtHlVGezAytzdsyjXo/pR8A1TYp91b29wxMJrTH32b4ZRfWWJy+arwZLv1V
 JVW2ceHgNiEHkAdZU/9sYlFpv2wCBHBWkS67J73bxxH9MbW/CYmNb/KauhIwKAzAF4Jy
 LqaEYiBmwdoKM8jt70FQjeCUN2DPHQ/4xJP4WBtAoOCnX/8tE4e/Ko8WGHuVZa38niv6
 f+xw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8oTSQqnVrOo8aC/VtmXy5PzvArpepsEtR+MRoyxe3zLhX16sN6m2jBdVglf1OSgukFdYJMfNOdzgJKDsK@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLqnIrH8ZVaiHjsO8Kkmxk+dIgLHk+DgOAOuISGYE1sstsucnjd
 cYDqEhKRBjMM82scUhzA59UgJBj2r8BK374pLvWjH/9t2htXLvV19ZTaBuBmbrtq1/Q8UIjpL9R
 GYPrRFRR16oQBCsHIvTlokCK1a1RcIxsLaPBZe341GvcHrBgC8clz5DOwqzxpk2NU9H61
X-Gm-Gg: AYBFou3TXbJbFt8bfWmLeW67RFODzXWcQhLfv0ve96pAm6Ec8aYtV06OI2i2Lh9nsID
 sfUjJh/QD/Peo/NYnFlwlXL9haagfStV0kDTHCkhNJfzCjdWKILr2SMPvHWuTPqd3fbq3BcplQq
 e9M8ERbEaMkHbzxi8cavAkMmpvTffVU5Ii12BU+u8McUKmiKjQjqAR1DZynDOKchEDkEdM/wboa
 /Y3oQUd0jg2Zs7IjB2S9SXAirA7pMXvItilGnp46d440VQGZUvZ5fJQHoKbaBuwBy3RUTi7MLHU
 ryNjRD5/vnyskhGYOtMndpQIHulXhI4jCWzAfCo1J4OGoDxNX+/0ggRqnn8GJGmHC0Df37TPwbe
 Qpt0XDnWnMMzdk9b6XsTWsbwISRwpqtFimSvtg64ifENQzrd1Amejx4WzuPbvzPF5QEp5cFCbHb
 5tUlcSn74zFADOnGYe+3nswZ8Aofwc9W+/f6XlmkaBAh+TlovAMO0ghIzSCxz5mxxMf9XH4/Qqf
 d3gQxFc4MfPAShg0O+URefS02+1ibnsDpnklDaqS6cD7Hws84I12Se+/UErpHAVNV+PNF9CW1wV
 Q37wBe/jGihpit9BNgasSZ6rjsoi0kpnsP5lnKJgz1tVCQQaksD6UM3NWkPIvWdbLsDvlX4=
X-Received: by 2002:a05:6000:490e:b0:488:6561:b324 with SMTP id
 ffacd0b85a97d-48e07baf65dmr9774791f8f.9.1792328791405; 
 Sun, 18 Oct 2026 06:06:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfdc4eecasm16461778f8f.13.2026.10.18.06.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:06:31 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 13:06:30 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
X-Gerrit-Change-Number: 2010
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2010?usp=email>
X-Gerrit-Commit: b2d31a2fa8b5ae6544ba75ab3a7c8111c51c3390
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 13:06:30 +0000
In-Reply-To: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
References: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjc0MDI5MDAwLkljMzYxMjNjNWE0YTJiMjI5NWZmZGY0NzE3NGUyYWNlYjlkMTdkNjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d86f8d104ec24d4d3037a086a9873f0838d77dce-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIQb0-0004cN-4Q
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: gen-sample-keys.sh:
 use a random serial
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7700339666392939665=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7700339666392939665==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BLvToAj+tGE="; charset=UTF-8

--BLvToAj+tGE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Steffan Karger=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Steffan Karger=2E ( =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail )

Change subje=
ct: gen-sample-keys=2Esh: use a random serial
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 comment)=


Patchset:

PS1: 
> Oh, sorry, missed your comments because the gerrit UI =
didn't refresh (or I didn't)=2E [=E2=80=A6]
Fair enough, if LibreSSL doesn'=
t matter here I'll just +2 this and we'll move on=2E =F0=9F=98=80



-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf4717=
4e2aceb9d17d668
Gerrit-Change-Number: 2010
Gerrit-PatchSet: 1
Gerrit-Owner:=
 Steffan Karger <steffan@karger=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Steffan Karger <steffan@karger=2Eme>
Gerrit-Attention: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 18 Oct 2=
026 13:06:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-I=
n-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Comment-In-Reply-T=
o: Steffan Karger <steffan@karger=2Eme>

--BLvToAj+tGE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Steffan Karger=2E </p>
<p>R=C4=83zvan C=
ojocaru has posted comments on this change by Steffan Karger=2E</p><p>Patch=
 set 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 =
2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail">View=
 Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2010?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">Oh, sorry, missed your comments because the gerrit UI didn&#39;t refresh =
(or I didn&#39;t)=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Fair enough, if LibreSSL=
 doesn&#39;t matter here I&#39;ll just +2 this and we&#39;ll move on=2E =F0=
=9F=98=80</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail">change 2010</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic36123c5a4a2b229=
5ffdf47174e2aceb9d17d668 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2010 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;steffan@karge=
r=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 18 Oct 2026 13=
:06:30 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: St=
effan Karger &lt;steffan@karger=2Eme&gt; </div>

</body></html>
--BLvToAj+tGE=--


--===============7700339666392939665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7700339666392939665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7700339666392939665==--

