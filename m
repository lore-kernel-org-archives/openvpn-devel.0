Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C18C43458
	for <openvpn-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Up38ie1r9+e6+vSltS80y4OSbP5w6fj4VMxtomksFlY=; b=QaR7+yQqNIZGajwtr7NxANY3Cs
	UUO03HtOfNAExvRwgFtWLL5RGkJ+zyySVYLqGyrfAJMwdD4FTvP+2WgX5GfWgzH0Hfd52mDjf1noH
	PW4V6hv/uW0ww1DMJKLbVr6X/e+PdR7168wyEv53Elrae4oZ5I4winFI/YZyG8kqr0Zs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfcSQ-0007ra-Jt;
	Fri, 03 Jul 2026 11:53:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wfcSQ-0007rS-13
 for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 11:53:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1gbb1q0TEFsSmMZx/Qr/AlGOrklRCzwd61dfo7LJgm8=; b=PJHvvLybQ6Kd3Nkq6T0ZmYQuRu
 S7t9cOn9zzeC3tl3sW+Zf9fu+YCUpHCudO0zqkigbZK6ceSEA4Mk+xyYmmljyjW7C6ZEKhLasDJwf
 9Y9Rdlj/Wf7cCymhFowNccMMTL70GSrE9XFLXoQnvTYhRUFv+78sSTY0eGt9bBuHTWX8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1gbb1q0TEFsSmMZx/Qr/AlGOrklRCzwd61dfo7LJgm8=; b=N
 BJQPquTfG5BIKX5tbcnw4OJwTKHeg0TDpwfeLh2Sy1uc2m8ceWqzM/ABh2lwhmzulyHP5pKnfCiUV
 fIxxhLo2WOlmnIBWLqIqnxkNnbhNUB8fTussG3XcClLujeW1AYVCHoXpEtzY45OOAig05/nlhzEmv
 O4iNRbx3U/G16khw=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wfcSN-0005vn-Dp for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 11:53:21 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-474e7ba9fd6so272614f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 03 Jul 2026 04:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783079588; x=1783684388; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1gbb1q0TEFsSmMZx/Qr/AlGOrklRCzwd61dfo7LJgm8=;
 b=ETNDHaYQktjwWOwgKN+xY8pY+R/bER/mwn3lzmrkjwLUQiLzge/tjz68VfXbia7LGL
 1gqo1ABT5lXQTWYJTNyGx1bDHLJwotB2GhSepfBq/XDFuixxx43nw2OU/6Q1LCq/7RGl
 CVUy22n6dTZzT6EFnChPPmPOLaxnYdhY5K7A9LwbGoa0ID9yc1cUxLbpBICq1IJW3OSv
 9F97LLmJGh0C8mwYD1aJC4iQ+uFv78uspPFuRj9+SF7QPVSrKqJx3N8iYmkIYXGDjV/f
 dZMkxRs+b6jM5JNX1nmw+WlJdAbAdrOklyOPoD708ilNBl/wB3BiAe87d9dazNcoaCYU
 RVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783079588; x=1783684388;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1gbb1q0TEFsSmMZx/Qr/AlGOrklRCzwd61dfo7LJgm8=;
 b=BwoDeA0ciV/6QhyvS+DquIzivw5/9b+bG82Is4aY8tPJSbJPKsNnV16kpBY2AMLtH2
 hK2S4CzPmsMwaVHJR1ZcbrJqyKKhWJnlsiTKLmzLhTccrJwoEuENwHrZ9QdENx89rBwR
 TOT6DR/fm63qwbOiLPXxeJqP5CofC86DZyX12z4ajxQ7WKZab9DZaoytR0/cJ73RmwfB
 IFXuwzVu+/ILchtdQ2aQ7FpLdCcbe2cO8lMGU3nVN+WQXnAvbGw5S4JAollgG5PJuNW5
 VTzCCtWMDlqtxBbF0vC4ClP8YTNcskas6XROsu3OQBHfv2t91SQNyEaSTwFM1lLAyIN5
 uENA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfpIJkuatoyiBbqwuKgkOUCtqHSsL+tBT5Y4pPvNeSUa3x0Z0sE6m5+t4tZmN1L7JaKzdZIqsdIRBDV2lD@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwUebDAcY9H06Hw5RxIep4RpCKAFvh9MdYNJ8rb741V3cvXCgRQ
 4Xk0pHk34cBGepFL2Hc1cR+rwHzMnf7GElXot9I1Ou1QdDjctjcPO6ZSj8Uu5i756R/FWA7G9Ch
 J85FBR96JhSLprkY5VNTl6w+f3hb3v9wIURQ0RFKBX6jyEhMsF4dhzRJ0UUyRcyIQfo5e
X-Gm-Gg: AfdE7clW9KRK56+iBOO3/TDjaWC+7mFrhiXeBBzW6l5bQQ1qiK3iuqeXay5jlQwtdar
 hVfcEsmfpmqmBBucQLXPglK3n6V3hPIqCLEfl/Fc6Kyx6pZxkk2oJGux7uKoZSCs10ZMIfv/G2k
 +sFXjfo6kT3Xn2AdWum6jkPXGAq98/+inLAE+/2h0Xlh2HgYyIG+dRc8UcpwSklGFwEVcJKez55
 24Y8GQ0YqOZep83hUcadblrHkzAUn12WFT6vbAFCk7MXwUZ/H/Vz/yBF8ddnHTkwEEc4HN+qEyk
 xtnooMTFNPVsBYvnkHYtC1aeP2lVVEZBw3ohmIplelMJcfZoIUyWgKwBNzBXxCPlnELzpZzOV6c
 ZgqPFUkjOF++EWvYENm9xtY1b2CylvVRsOP2yHLJ8dHKKHF7HMcT7SrThYZtbfzhedCZWcl6V5e
 UoOhNJn7+mcgibDKDegteve7rHJ2u1Qk1c07sl+NwAwFp+Gkh+9a0mccikI8nE1wF8tkaz2tvhJ
 vVHOK2n3gWfzl/K33Gwd0bvjN48caT8dqFhpUIWy5Jvv/HJatLDm1RnlI/greypw+p3+nRolsYZ
 hMCtMhJCYSNdhQ==
X-Received: by 2002:a05:6000:29d7:b0:476:5c84:e830 with SMTP id
 ffacd0b85a97d-47757e57f36mr10936974f8f.9.1783079588210; 
 Fri, 03 Jul 2026 04:53:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dde1a4fdsm18616686f8f.26.2026.07.03.04.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 04:53:07 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 3 Jul 2026 11:53:04 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6595695ab6401047d498d530f8739686880bea3a
X-Gerrit-Change-Number: 1733
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1733?usp=email>
X-Gerrit-Commit: 522eaaef80c1394de08ecf773b6595d0b17a84b3
X-Gerrit-Comment-Date: Fri, 3 Jul 2026 11:53:04 +0000
In-Reply-To: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
References: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTAwNDExMDAwLkk2NTk1Njk1YWI2NDAxMDQ3ZDQ5OGQ1MzBmODczOTY4Njg4MGJlYTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ea99ce7faad4d6654d370f1d0e53b219ec175ba3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wfcSN-0005vn-Dp
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mingw: avoid C99
 "hh" scanf length modifier
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8467746664848263184=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8467746664848263184==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C+LU1ysFKgQ="; charset=UTF-8

--C+LU1ysFKgQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos=2E

flichtenheld has=
 posted comments on this change by d12fk=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1733?usp=3Demail )

Change subject: mingw: avoid C99 "hh" scan=
f length modifier
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2: Code-Review+2

(1 comment)

File src/openvpn/crypto=2Ec:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1733/comment/7e2808a9_614d1954?=
usp=3Demail :
PS2, Line 1477:                         ASSERT(sscanf((const =
char *)hex_byte, "%" SCNx8, &u) =3D=3D 1);
> Certainly true for MinGW on 26=
=2E04=2E There is a uLibc, that supports %hhx=2E [=E2=80=A6]
After research=
ing this myself a bit I agree with both the sentiment that this is a mess a=
nd with Heiko's assessment that a work-around is currently the easiest solu=
tion=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/173=
3?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6595695ab6=
401047d498d530f8739686880bea3a
Gerrit-Change-Number: 1733
Gerrit-PatchSet: =
2
Gerrit-Owner: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
d12fk <heiko@openvpn=2Enet>
Gerrit-Comment-Date: Fri, 03 Jul 2026 11:53:04 =
+0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: d12fk <heiko@ope=
nvpn=2Enet>

--C+LU1ysFKgQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos=2E </p>
<p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1733?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/crypto=2Ec:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1733/comment/7e2808a9_614d1954?usp=3Demail">Patch Set #2, Line 1477:</=
a> <code style=3D"font-family:monospace,monospace">                        =
ASSERT(sscanf((const char *)hex_byte, &quot;%&quot; SCNx8, &amp;u) =3D=3D 1=
);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">Certainly true for MinGW on 26=2E04=2E There is a =
uLibc, that supports %hhx=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">After researching=
 this myself a bit I agree with both the sentiment that this is a mess and =
with Heiko&#39;s assessment that a work-around is currently the easiest sol=
ution=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1733?usp=3Demail">change 1733</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1733?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I6595695ab6401047d498d=
530f8739686880bea3a </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1733 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@openvpn=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Comment-Date: Fri, 03 Jul 2026 11:53:04 +0000 </div>
<div style=3D"d=
isplay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> G=
errit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-=
To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Comment-In-Reply-To: d12fk &lt;heiko@openvpn=2Enet&gt; </div>

</=
body></html>
--C+LU1ysFKgQ=--


--===============8467746664848263184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8467746664848263184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8467746664848263184==--

