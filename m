Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13A1C5B572
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CLdXDZDFGj8kewzLQWe6nLyWMVNoegmW1xn4ypGzY8k=; b=AaBsAWnaIYnm4bSJ5l9huogDiR
	y8B7TDtL8TLzmIkfs/gMM1T6bqtZ+CIYKRgfkC4VvVbjVVIjQbmhVk7qfRQNB/7eTcyDwgOFpc6GE
	wAJteKu8vzM/y4d4ZTNfk6p7nw6UE+01czUfy+fBIMaUHMoQi+kdsrSnwu+WvcpMsq3Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wupLZ-0008OB-NN;
	Fri, 14 Aug 2026 10:41:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wupLY-0008O4-6J
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:41:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yR8tcGJ9se6kgFm7f0HFZNqVnHGGhBeuf6YNuYsLMwM=; b=GeosMYq+rkyRNwwYTw7VkY9Peq
 qk94SKzDFT/+b9X4SzKTxZPgiuAfOzRuG4JgIsr0hwMGB4X53bHrI5QPbFVCSBV5xuOTtYSlspvTY
 I+bXfEmm1Ymoj52gAFcZlA8eOZ32wJgvf3yOXZLtZ3kBRiXE3S+/jMFPi04llCsiPINY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yR8tcGJ9se6kgFm7f0HFZNqVnHGGhBeuf6YNuYsLMwM=; b=J
 lnY2uKXYuMtVJ/puBQn0QaE/406OCHEeZ/mqaGHdPrKbEz6Ug3u6FRXCHyuBOBu4syVylK/q+N8xF
 bklwuAyb3q6Lvl8XO5hTqJWQm4HbqUp38xslKnC/X3t13vZWNfWwYVJOE4796aSM93PQe+7ZphbPs
 lkx2lFOdi7TdBwNc=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wupLa-0003Dn-6e for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:41:07 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so597295f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786704060; x=1787308860; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yR8tcGJ9se6kgFm7f0HFZNqVnHGGhBeuf6YNuYsLMwM=;
 b=RCYFFeMPub1wZXb5FFVxIw0U/lMcbL8tkLXBMy1T6LTwkOcbo2fnnb3BwxxPT8PB/O
 GRzP5AqtdYzbFv1baSd8tHWaOIDzNkbGHn/bFsBL4oqaJ2IiL00pxWNLYXpbeRyUB2Np
 chrgsHJ9L/IdDXI+pGzRhHeCeeMuO8iHGgnivfxu9UeglS2mi2fS/DnRT0RI7Xss62e6
 4FGFPus6vHF2harbzVNL8cS7Wl+q6fWSl242/EA7OLCGmeHgbNsWaD+U/dVqwd+7RtWX
 A57FV/pXcnhvCoAMgqrvXwB+z+NccVv2B/1p20t5CgQshjfD6DBtcV6b1mTE3PCk2nHi
 wmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786704060; x=1787308860;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yR8tcGJ9se6kgFm7f0HFZNqVnHGGhBeuf6YNuYsLMwM=;
 b=FueUbu7XLas0xBE6YXMpHGwv8QpwRqVJK3c/vMZxHWBbOgz24BVGSwR4Ej00HkBx0g
 5frCye7Hh+wBIEv/yEmVm11dV2IuLrynrGDLGeTWTDPFG/aMyJdFuxhRCaTYiggJZ3A1
 G1KmqEQvpRHxPxuBPnDwjBVi1z8sVlawemEEeM/KEfFSYkmc5DDbyv1vec+tgJFgL68C
 CZXT99nhlZ+Q0WAMGAcbGq2QAOEB7pZ0aSRneJsTKO8vFRFk30iRt9Cy+CuuO0RFDtmM
 jW7XAnHwSrbuWudCSQIJi9jAPmJuv5o4+q+D48RqVeGK/K8QwXMNB05X3uBr3NGHGR77
 WFIg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rox26HWYsDMa9wjINnp9rzuVOClYHlYC1347yiqjf0c3RWeQkg/+uosnbRmUvIaMHynGRHIjKE1Dky3kYCn@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxxt66l/Z+VwqY7lEPA1ePgEXl0kOKI/ivoVhwi6l3I4fbA6kit
 OozuyJ2K7EGHXlP01XgmDQdvphhURes7+Dp1BRfRv9N90wF/vWooi23ZIhsJ3CUKZMK4lXPhy+c
 XKDIp1G9inlejLDeH0bKrhyWsmNQfU6WED9TLBwnamEBrTodv6o6LZwGtQSrgKOO6ZLCj
X-Gm-Gg: AR+sD10WPRJZArVr1hXT4hzWp3vJ0qwnhmpcfjFsrQbFONP3qdeXEfivGyE++PrGOhm
 uRohHFdyQe6xVaC403EY77yBURII+I0MpR47/V06kxwPFV5uR5w2SfXdoNp1pSN/y+O/LsfukJk
 T/68iMzCIUHZwHM0btLxjnMjf7gXhK5S3vxESh9qRyc329nT5MH1GBShqgr8XUbB+um5Lxjaowy
 Izm1eKyLyUKZBVbOgm95P/JOU+tVrfN9PmQ5REgBr1iplh8gmJQOHYUvY30271jwoSdiSda1y0s
 pObBnud7Pa7SzIGMsaXE28g5COV/FAxeSiGYFibGE+3caW/H0LayyP+9SsinEcTPVDoaKFZ/8YO
 NWHw60kKKfw31wySYHAbZftpGgB2ZXhYAt5i0z9dQ5LBAXSYnPSXrRQPrkR6o0Ozzl4j61U0pCi
 DNKanw7RyR3gfJfa0beAWPp5cvXnRYo6+cpj4Xk/kL/DdpfRfkJ8Xiye89uWThdkFHzod01SIFR
 aLI92hicWtziDw5JPEGFokQuglfsUpupPkbMBsKJgUBVpT90/m3blSf91Jo5z75hKmndSK4WNQu
 VBIWidwtWPp3HRdYqTVS+vlyssUSfMQSwGxcYgkBNjT2ZyRtGgw=
X-Received: by 2002:a05:600c:4003:b0:495:3de8:33a6 with SMTP id
 5b1f17b1804b1-4998798db40mr54212565e9.16.1786704059987; 
 Fri, 14 Aug 2026 03:40:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988ae8af3sm36097545e9.4.2026.08.14.03.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:40:59 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 10:40:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: 45219183dd0984613b8c46bb05bd0bdfc8b218d2
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 10:40:57 +0000
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <22bb1ce17b51b4c7aae05aea37284926abd26166-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wupLa-0003Dn-6e
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 useless assignments
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7416785715526939668=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7416785715526939668==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8SFY/0qar+4="; charset=UTF-8

--8SFY/0qar+4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1617?usp=3Demail )

Change subject: Remove various usel=
ess assignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 12:

(1 comment)

File src/openvpn/console_builtin=2Ec:

ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617/comment/a42ad3c9_4f641da3?usp=
=3Demail :
PS11, Line 203:     msg(M_FATAL, "Sorry, but I can't get console=
 input on this OS (%s)", prompt);
> this loses return=2E [=E2=80=A6]
In gen=
eral we added EXIT_FATAL macro to msg() exactly so that tools would not com=
plain=2E We do not usually add return statements after M_FATAL=2E But of co=
urse in most functions there is some return still afterwards=2E

Not sure h=
ow we would test this specific instance=2E I don't know if we even have a p=
latform where this code branch is used=2E=2E=2E



-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
Gerr=
it-Change-Number: 1617
Gerrit-PatchSet: 12
Gerrit-Owner: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-CC: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Com=
ment-Date: Fri, 14 Aug 2026 10:40:57 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: No
Comment-In-Reply-To: stipa <lstipakov@gmail=2Ecom>

--8SFY/0qar+4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/console_builtin=2Ec:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1617/comment/a42ad3c9_4f641da3?usp=3Demail">Patch Set #11, Line 20=
3:</a> <code style=3D"font-family:monospace,monospace">    msg(M_FATAL, &qu=
ot;Sorry, but I can&#39;t get console input on this OS (%s)&quot;, prompt);=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">this loses return=2E [=E2=80=A6]</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">In=
 general we added EXIT_FATAL macro to msg() exactly so that tools would not=
 complain=2E We do not usually add return statements after M_FATAL=2E But o=
f course in most functions there is some return still afterwards=2E</p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Not=
 sure how we would test this specific instance=2E I don&#39;t know if we ev=
en have a platform where this code branch is used=2E=2E=2E</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1617?usp=3Demail">change 1617</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1617?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1617 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"=
> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: F=
ri, 14 Aug 2026 10:40:57 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No <=
/div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov=
@gmail=2Ecom&gt; </div>

</body></html>
--8SFY/0qar+4=--


--===============7416785715526939668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7416785715526939668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7416785715526939668==--

