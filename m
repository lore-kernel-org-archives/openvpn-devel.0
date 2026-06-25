Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5C9CDB479
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4JAT1yV7wOZb0oLRbAntEPbh1i41JWX5/7Xl6Fx/bsI=; b=Gxo+Ejlrn4rFLBefz0/o9r9FTo
	/r7/P8Wk6HFQHlomEvv4+nS0sfRjyzIOvPsf7gn5YiL1FSqhDzb13wlBFMRR+6kVEGp90Ppu52xXl
	WqG+LIcsNLi3QMOUq8kImMZvbtLHItfRPqv95Xgi8YAzPYBSKy2js4yf+dKkMV2snZDg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wckzz-00058Y-Ak;
	Thu, 25 Jun 2026 14:24:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wckzx-00058S-OX
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 14:24:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=68sQbH0OLwSsAp7kV1MXqwGTcQbOePCIrzq5SKJZ/Sc=; b=LSNX6JEs2p/YQR9YBpiBp2J2wQ
 hlzgP/jj/soH/GW144kEl2CQ168GOV292bMZHzWtVgXrqHLRN4OG7TSyCgyAFG0YmPO235muWIL+G
 LogTmdcUNTTkrd+up+ZEAWQHEaVpc9QHnOTcdhhAjMbxwoY7bXvOQHa1nRnJp7dV/BAs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=68sQbH0OLwSsAp7kV1MXqwGTcQbOePCIrzq5SKJZ/Sc=; b=b
 CzPeRUHJdogmIYazpNseeCW/YWjncXtxjWN7rSxnIo5pOE6/hMPv9QPRGY/M9pifUptAIewCF4yDK
 PlggF8BbsOf/fZy9amMLEnD6fq7WGne6Cr33lh1Rjg1qYXWUEqWV9rB9oeCDaqqfRuwlaQ8TKdIKG
 Db5nLnvSoVOaDF5Y=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wckzv-0003mC-ST for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 14:24:10 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-460166910e6so1490274f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782397437; x=1783002237; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=68sQbH0OLwSsAp7kV1MXqwGTcQbOePCIrzq5SKJZ/Sc=;
 b=Z9uG+oLeo1SjQws48R/A/z0DnwevKHQcIVKSXKAiLNftWaOlIPJcT+4rcO8mGPSUUC
 qIZj0nUR6n9KRFGGNxVl3DefoyAR9xaswSk5auo0V0iP6CLUg0vMX81dRuY4wRovBhxE
 6/mtloGS5h9ok3wXjKJNmgj+V9OzjndtRjpnhrSx7uirNpQrvtD/7ddPWlCB3hy9KKGY
 QHOH91JjTceTrtxE4mhBaeP5zG6c3FVHjG0JXmgKRc1qrYhRbizy9D+NQCQHZoTdGggy
 ECYhHxvUzYt6N1aEnSC5bb4LA1DuuRgjsa8tFLIi4gSjaRNyMVcrKuvxrdt5VFfbrwH2
 TpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397437; x=1783002237;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=68sQbH0OLwSsAp7kV1MXqwGTcQbOePCIrzq5SKJZ/Sc=;
 b=BwoOXrgSMSoR3If3/gSyOb+RWCoVHlAMsM5ldWYCs8deBT5PmG8TzGEEni+IUd4scO
 q6wCy8Ba8PT3IJn8v1mf2F+z7NODnbHhHmXDLyC32euexKjGFlXZcvk2u8V3ZFj5EUnk
 +BqHYfYjYKMVzbWm5SfzBizB6z9u3yQS5QlcKYouHJwcm3Oz6tcLQqvOeMIrGjMmXm5X
 Z290CJgauu7yaNqCQK/hQIJdaBTOvjKR1X6YX/e3cXHLy0rQZdesa8hFXt6RqOXVoCMz
 crxGB8YrvkKjEmXm33JWJ9mHfvcJwVc+RAMZO72qJeJzQ8nmQWt1Sy83XfOAVjiKfWJ5
 Bcag==
X-Gm-Message-State: AOJu0YxCUZ6jgBKMVgrxQkraiTG2EPVeZMFz3aE3akOF3/cOfB5GWc8s
 pwckoTbhAx6Xo3jI9RyQX9VsT8szd5jvhOjEoXq5iVywRaFA9pjMhjERq7egmeJMZyWmp/N/OYV
 ZMDIfaR4R9ZJdKEdrtqTfhY7xN2LV+39S0xO707cchRnw42rF6UolJhMqmKGrpTbeg03K
X-Gm-Gg: AfdE7cnES8sKqYU+3IpKr7gbAVW9sOuh0nem3lbUeAq56QbKVU5PESH16PcD0B7RW60
 1HlkpDbz0p+eZuAMxwo6LsdSY5Qvv5HZkllpmEs9crpVEmT5tgi5fnAjkJ5+UQWA5JfvmS+gBBN
 /P4YLlVzvUy+MHLlH2cegwvgbFc7y4OPlfu7CZd6nM4XKC8P+A5+ENaJzNJVbuBegMtvlq2XrBT
 QTXvJWuEvqDdA1HLOSsGRPfPSGMYbI+N4UY39mdbcWGYFaZ0IVZNb4TOm54C9x4eD/h6USMopp+
 Y1W0BgfgBRvCPzg74uP8hd4Te4RV2BYd07RVssC0GVdgxbRzjY2QSz1bkRYxKB1DFRTOZi3C7o9
 A5ia08C0Nb17TKEWezkh3JB6+1ONcq2EMxaHX/67pe7uGGJ03RzWmYodxHMiO0fS/iSEN6dFBqS
 5n1kwU/pfsA0GB1eLbRCYnYCnoSCyq/V5zDAiwPw4UVkcxFVo5/BsIQ8DKqVn/snP3VNYMHSR7Z
 w1neN0ntMW1fom3MiTvcbRC2Q7qVijHAXFJcNDcEn/wjpQ5FcQpOK4WzyMwvfV6sfRAkcFIYTyZ
 YhI=
X-Received: by 2002:a05:6000:4718:b0:463:d9:5b35 with SMTP id
 ffacd0b85a97d-46dc04610c4mr4419302f8f.1.1782397436585; 
 Thu, 25 Jun 2026 07:23:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46d3ba68d8dsm10220914f8f.27.2026.06.25.07.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:23:56 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 14:23:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: f3cb575b1f97e1a49f67cf2d4249da9f723d910f
X-Gerrit-Comment-Date: Thu, 25 Jun 2026 14:23:54 +0000
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <76d50595f1c65853b7aa0843b6c4e557e4024863-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wckzv-0003mC-ST
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
Content-Type: multipart/mixed; boundary="===============5009857715053293495=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5009857715053293495==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FrIfAhP98ZI="; charset=UTF-8

--FrIfAhP98ZI=
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
ch Set 6: Code-Review-2

(1 comment)

File src/openvpn/siphash=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573/comment/00f9a1fd_e625b1ce?usp=3Dem=
ail :
PS5, Line 46:     if (siphash_cryptolib_available(ctx) && false)
> ye=
s
you fixed the occurence in siphash=2Eh, but not siphash=2Ec?



-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I807f398903ac2047530800c29949=
793c6f4f0ec9
Gerrit-Change-Number: 1573
Gerrit-PatchSet: 6
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
omment-Date: Thu, 25 Jun 2026 14:23:54 +0000
Gerrit-HasComments: Yes
Gerrit=
-Has-Labels: Yes
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--FrIfAhP98ZI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 6:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/siphash=2Ec:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/157=
3/comment/00f9a1fd_e625b1ce?usp=3Demail">Patch Set #5, Line 46:</a> <code s=
tyle=3D"font-family:monospace,monospace">    if (siphash_cryptolib_availabl=
e(ctx) &amp;&amp; false)</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">yes</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">you fix=
ed the occurence in siphash=2Eh, but not siphash=2Ec?</p></li></ul></li></u=
l><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/15=
73?usp=3Demail">change 1573</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1573?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1573 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-=
Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Thu, 25 Jun 2026 14:23:54 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none=
"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>

</body></html>
--FrIfAhP98ZI=--


--===============5009857715053293495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5009857715053293495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5009857715053293495==--

