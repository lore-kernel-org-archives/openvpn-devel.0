Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D9FCDE000
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/55pDW75QDZQBTvlew2BLjbDJhkyJyOgUgetldDzzzU=; b=lDoUPVL9iVnAge1Pxd3mYCeEiw
	hf42hKnEt7tnYkoewSnVy+AzA+qvvZM3UNH6UQQHLXWFQFGCFKzl203gwsf0NAgYXwXiSGIKoPz4C
	5wslyuTo0bNlzsYqSxNaf6WZcCoDCBRCYjnzhTifdbyc+Sswy09EIpExiSz9Kf3oxS5k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wckDs-0006W1-CK;
	Thu, 25 Jun 2026 13:34:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wckDq-0006Vu-Um
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:34:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dMis4kIWF8uhD94ob0WwnAi23fiMaEyhSp3AERIAeZo=; b=lXQ+MXE16Vdl7d8ISTTFlBPuNG
 mgibRlA1aOnDl/1uQijEmTjnmLgZhnkncUUMZ2doJvWilkKOB1P0rlUQixvyogVbA/K+THDf4LeeX
 hlbF5npZmvBBanE4KbsPAXVtAnEGZ/M5Gmrl/NC4f3djKmexx8WqOd+1NBx55ZpBME4k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dMis4kIWF8uhD94ob0WwnAi23fiMaEyhSp3AERIAeZo=; b=K
 qjYQZknnhkim1qjYCZmIfUk0RyORg1XGoo7WJo7b+7uz33BPnozHtah0RMuCJtzYNydWTfq7z+zlQ
 qcM/lFumPvrrwI7mqUU5EHni6Hzh9zEf+ol3pau8VWGL/0cVMz1PlEzDmJObbYf6cpgqztlmY/UOV
 D8dRb4U0Nd7yl+bQ=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wckDp-00018d-IU for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:34:27 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-46caaa805b2so1163896f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782394454; x=1782999254; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dMis4kIWF8uhD94ob0WwnAi23fiMaEyhSp3AERIAeZo=;
 b=O2wydf3OGJSXC1MFr4clzVOWmafbPYzXCs2lHhuwtrL7mJlIoItIREWCEctf+B+3ZA
 3IijP5Fu3HBFB/Q6EwezASx8HTWPvFz892KB4fzrgkKEHAF/orM93glwP+4BVsosAlEm
 gKENF/X3QxvGr32DxjXDu1iQT9AfVviDqSuOVWJR1JHEHIYO4AuKGLUV+KWP7FYfQ6p9
 Do5nfYQbRQuohEuTMZ7oNFlK8hoUroGMNIiNVMKjKgCttpfZpMEJ3Z7suUVQlf5RQZNT
 gdH4et+6OnjP15Kf7svpoidZw+lCUDtwPmRCZnK9LKzg2D3uVwhB/367VzrjZca7MUm5
 UXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394454; x=1782999254;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dMis4kIWF8uhD94ob0WwnAi23fiMaEyhSp3AERIAeZo=;
 b=B8VQJXgf0velTqFaFhek5v+TXVO7yiltl4Y3or6i/mqvgB42sIYHa2ODY7DRZYmN2s
 8QVxMQ/k2olCUeRA26Dw0YqMPlyop+CfedGCTUbiSouyA1r3d1dTLtbGwZsRoxiUwgQV
 LnLRFa5R4RqDMd0Gl/g0DeJydn9N88vUF7BesAWbF+VY/cYKBMivBEPUjUGWbTL+5xFR
 FjKsXrPMFG9Ca468m3T3JV7yvYp3JoEVQLWyGgagjHFSn/fCkRSFfVmnAKkyF8a7cON9
 1GSXzGtFz1epxyiVSTf7Ob8vo6tAVQrXT6qMcHcT7h2VIbi79WSYbVBCf8V9kjmt9OSO
 YdUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0zgnJBfvQ4tpxtdMHCvwwnXgIOZkL/HeVfj6WArglnfoio2tqIY2XVOC32v+wqBid5ozZVtv3utUhDwz5@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyw4gy44XtQKmvXWgUyCwlVIgLBh9AC1V9DV8l5FO2Kw8IaB8NB
 8p3RuM0Kj1/fsBD65wcKoeWyFyTK52SfuU62Cf+SwIyuZyvVoxGUOPBtnTOBld0d7RFzaQJQUv4
 3iLGYC2WyCSM/ipepLkH58Y+vUrCArQ8MT4j4RZJKtpZlYs3b5OVAIzdH91P2Zh2n5nrhrSVpx7
 oDXr+9+w==
X-Gm-Gg: AfdE7cltkqalLfcoMRC0vZx6CAo3hdO2J6KCRylTT88RiSB1+xhS9/ok6M60G1oDddb
 MjxBIrMn+x9BZaa4hGFYZBt/Rh8LsaJVLBBfLHbsAY02nXPzmA+GjG8ISr96C/O8Vx0aLovSxb/
 nfhuQ5T2EDjLKaxCQOTPVBQ/W+8MWQNUQVLmpodHmebpiBtGUqdGDFdbj87dg0JzxCWBJifQvKL
 X5vOPw4hUM7FSE1DNJ3pDOtOgp6jSg3ELGQDCM0A/K4rAEpIDI4RjmuLXrPCl6NFzIQXCr+Qh6h
 zOuVYQ+3XTOjuucgDgUEpbloiN8vK/5Ss1dci9z/NIWJuUUP5q9+cEKVnR/4Pw3OC+6onbIMlaH
 VXQfq5MbWMKWaCtRTVihuZYThAyz5+bsbWl07Bde+xpGKj3xQsygJGYG+NuLyUjYnfYHvY76y6S
 u4hjkZXoQRwpbsbx6xc3qvYjux2z1zrgM1ISLNy/hymb5hH+a41GvkKXpy8jhctH2BPjZ8uLQsP
 xkoN0tG5Q6hKidYNjgHpRDg1RUt/5XUa9a70x1xnTeyFtBKevw2zC7Kz8GDYHtpvKpIK2ZrwLc9
 mY1IMS7JY+ksQQ==
X-Received: by 2002:a05:600c:4708:b0:492:3754:15f2 with SMTP id
 5b1f17b1804b1-492668858f2mr36110615e9.32.1782394454250; 
 Thu, 25 Jun 2026 06:34:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49264082417sm79532305e9.11.2026.06.25.06.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:34:13 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:34:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: c257cc89966792bed1d61c4c2c098d8ac8e09afe
X-Gerrit-Comment-Date: Thu, 25 Jun 2026 13:34:12 +0000
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <be9588d8dd847fce85bfa2fe3c4ca059f6040c15-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wckDp-00018d-IU
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 multi_get_instance_real_udp_real method
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4317631258861223829=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4317631258861223829==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="llA5YCL0bOg="; charset=UTF-8

--llA5YCL0bOg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1725?usp=3Demail )

Change subject: Extract multi_get_instance_re=
al_udp_real method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 2:

(3 comments)

File src/openvpn/mudp=2Ec:

http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1725/comment/0e567d40_4c1bbe48?usp=3Demail =
:
PS2, Line 264:  * @return      instance matching the NULL otherwise
> mis=
sing word after "the"
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725=
/comment/45ff1856_7d259630?usp=3Demail :
PS2, Line 267: multi_get_instance_=
real_udp_real(struct multi_context *m, struct mroute_addr *real)
> why the =
doubled "real" in the name?
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1725/comment/a9233f3f_40660c5e?usp=3Demail :
PS2, Line 298:         const=
 uint64_t hv =3D hash_value(hash, &real);
> why is it better to call this u=
p to three times instead of once?
do you mean calculation of hash_value?


=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I37ade55d7674c68dd9=
8cf4dfde35c4ad42e20d39
Gerrit-Change-Number: 1725
Gerrit-PatchSet: 2
Gerrit=
-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Thu, 25 Jun 2026 13:34:12 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichte=
nheld=2Ecom>

--llA5YCL0bOg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1725?usp=3Demail">View Change</a></p><p>3 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725/c=
omment/0e567d40_4c1bbe48?usp=3Demail">Patch Set #2, Line 264:</a> <code sty=
le=3D"font-family:monospace,monospace"> * @return      instance matching th=
e NULL otherwise</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">missing word after &quot;the&quot;</=
blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1725/comment/45ff1856_7d259630?usp=3Demail">Patch Set #2, Line 2=
67:</a> <code style=3D"font-family:monospace,monospace">multi_get_instance_=
real_udp_real(struct multi_context *m, struct mroute_addr *real)</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">why the doubled &quot;real&quot; in the name?</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725/=
comment/a9233f3f_40660c5e?usp=3Demail">Patch Set #2, Line 298:</a> <code st=
yle=3D"font-family:monospace,monospace">        const uint64_t hv =3D hash_=
value(hash, &amp;real);</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">why is it better to call this=
 up to three times instead of once?</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">do you mean calculatio=
n of hash_value?</p></li></ul></li></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail">change 1725</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I37ade55d7674c6=
8dd98cf4dfde35c4ad42e20d39 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1725 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div=
>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Thu, 25 Jun 2026 13:34:12 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--llA5YCL0bOg=--


--===============4317631258861223829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4317631258861223829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4317631258861223829==--

