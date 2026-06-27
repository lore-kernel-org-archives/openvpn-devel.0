Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67AFC43458
	for <openvpn-devel@archiver.kernel.org>; Sat, 27 Jun 2026 10:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Pd8L55I8lxYpwLCnzKkP97uB7Ur56wwzzEQCi3X4XU=; b=XysSIYeP168BTKUsm9Eu+XjhpF
	MI7d7ywJ5Bv30Ofr1DUOCWqqiJjOYj1OS2QpvFkFiZhifsOXrRneFpWKdIiOFGDFqDfG81hq9cAhd
	SfuTdnY4vIr4LsAOo8Ah4RWfIfV4gljP6OqUPXfQZ4plfYV+Nhi/RrfAOjxsswmWVOqQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdQPS-0001pY-7o;
	Sat, 27 Jun 2026 10:37:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdQPF-0001pC-D4
 for openvpn-devel@lists.sourceforge.net;
 Sat, 27 Jun 2026 10:37:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fJFZQSIvAut1SeIj8QkPgm7gCsf70xzBvtftmg1uRh4=; b=AOs7tZ5XK/kzV8FaOnrnkMWfHv
 sJNuRD0QN9itYWs771BtDd6e8jdDOs9DqmHb2z3htZ90SvlBPHodT2YCJxUyX40hHWpLkhT38gehg
 MqP53GGKC5/3k2BhDDfKudyT/TGTAWEeb4uRpPy93mdDNgBjVINu3OuBEEcjsdzRysiA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fJFZQSIvAut1SeIj8QkPgm7gCsf70xzBvtftmg1uRh4=; b=F
 JKjUA3fRcWkGruu3RgfdD/E6yHvTRrpgwmFnifftXgWlNvV7LG+daaKljII6lCLPA2Q4sjMIQVYhQ
 wWb0mV0Y8B8ixZOcn/+aLwCm0UXlsjlKp6wBKN56B5uFqPrq3JyjGbmvCP4lxaP1zQC+6KjBOk4qG
 6KpYcOQ8/roIkY/A=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdQPE-0006IW-7M for openvpn-devel@lists.sourceforge.net;
 Sat, 27 Jun 2026 10:37:01 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4938d60c035so2070615e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 27 Jun 2026 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782556609; x=1783161409; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fJFZQSIvAut1SeIj8QkPgm7gCsf70xzBvtftmg1uRh4=;
 b=TIrCBq7eZLdqvuvV6oUlxmrSgzYsyN+PJrnXz636MVSDD6lSMIwcXL4wuNh/wRFCNx
 j/pa20aECT7BGZ8lDfRYnEDLRiG29Rv5jhVJR5Y+58VZySHuPGWD9Ay5hP25mMh2x5VU
 LE4sp4t22pUHwjhyQigUGeLhtRbeBmWPeohI4XA0xsaC8Nqfxf4pD+RRxz8oif0AZ/TB
 +MhbEwMzoY4y3E2svOjT2c2MkH05ZYM7VaomSRJgtcN8Yaeg1hPt0spNqbyhwoFDZSHr
 kuRqStK+/1NYp9FihF/QaxmmzCgSIYAuY5NtWVhNve5YpmEeAID7WdJrTdln0L+t51qo
 FZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782556609; x=1783161409;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fJFZQSIvAut1SeIj8QkPgm7gCsf70xzBvtftmg1uRh4=;
 b=Rm96IL/A7KD6Qn+MCnsqVbfcUjA+bmeDYC0jbaQrSNeY9FZQfjQfVNlFUvTYJNkdpF
 Nj05e4Hx3EK8Bc1C7xbVXUyAhxUKy0guIJGuZTPkE9AeQIGFUekxGWqy9dxaWOjFS0OM
 ulx1Opppxe1EoKu0hjjcazvkvgWmhDyXRYZH3RoQTEDjE+eaTeTcJXf7pKIUXtITOPjo
 G8qj1S5Yt+hCcK8JxWNDZD4u0jTYg1dNpRj0+AN0TAcBCIjAEefTX4FB8UwLiZjzCOA3
 BRFhoW4zRidzPvKMMH/b+q8o09T5ANzImJ4YMiZJsXX+IfQdflYu2i9AnIbgJ5puUI7m
 PCcg==
X-Gm-Message-State: AOJu0YxuhsH8oARfDt4J/qEN2a8ftDS4eS0VC8PZKqSY+5BvL5aNAo1K
 t2qxSwx1Lh7UmVUQ+9JVFNlyLxUCGXudFRYo9uVC46gRAd/V1MbSAsjs5QyHnWW4uvIhSZV7KqI
 GiyhBnJvSig3dBrLwFaljLXOWVwUoweIkcOW+aRlRJflF7LHgieyKkeeBZrOfx7xhi75KqWpsY1
 wpXgEcLA==
X-Gm-Gg: AfdE7ckSwaSaCYaywKJdsOL2b1EHi2BkrpTmWNpIXgebmPErAWkD9PhLvje++akOXOH
 S3X2zd2rJAPpqQyyTbFBrTjVZVh9HIL4mP8JvkD+cvPRK5nQezQAT7xOaXKf0b+OMS4XFDbauPg
 9FZHFcdmfDVX0ad+R+0sxQj65y7M7f+sQQ0FeSKk+yhTXnbw/vd7fzKG0ZnYXc9hfeYBKAaGwHa
 vKWedmr5XlAO531CCVWMhEi+8C7o5TNhPaa7KbpeOIWeR80y1eSBHXswprvZy9EjPEjWtg7SiBU
 zWH26Olz3hALy4OlhXmHa+Tffx7dpAIhDlRqUoV18eLPnxM7aWA8LsZIhRP5qES04Dzz5UqQPS+
 T2GpIV7P7Y0EKblwQkLYASM83t6G3J6FnpQ0jXAz6OdVP0rg6+kWWq6IxYTW7ZVI0y0E6GQlteq
 ueV40EoVnn7YeTsDK85PzN2hOCduhjBjJa58M926EFAb7mq3/zk+7yS604nNwOVptfRoFIIOP8K
 1wmNUKbvajA9trjEUV7lLRPnGLg6T7uRNgUq6Kwd4X5gb0hYKjq/E5dzRPe05OY2tv2ACOAk5tm
 6Sc=
X-Received: by 2002:a05:600c:6215:b0:490:e180:2ed with SMTP id
 5b1f17b1804b1-4926683879fmr126348255e9.4.1782556609050; 
 Sat, 27 Jun 2026 03:36:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926c2954efsm87812415e9.2.2026.06.27.03.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 03:36:48 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 27 Jun 2026 10:36:45 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc
X-Gerrit-Change-Number: 1736
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1736?usp=email>
X-Gerrit-Commit: e0ba79507431a8c970b721cd1413d32c64c15415
X-Gerrit-Comment-Date: Sat, 27 Jun 2026 10:36:45 +0000
In-Reply-To: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
References: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTU2MDk5MDAwLkliN2Y5YzljZTVlZDc3ODE5MDQ0NWNjNGNmYWE4ZjNjZDVkMTExMGJjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a88c4e9a129634a83368d0b0323483eb2c4925b3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdQPE-0006IW-7M
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win32: fix plugin
 trusted-dir check prefix bypass
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
 lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6477382934197613586=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6477382934197613586==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d7B1B8ZEPaM="; charset=UTF-8

--d7B1B8ZEPaM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
736?usp=3Demail )

Change subject: win32: fix plugin trusted-dir check pref=
ix bypass
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review-1

(1 comment)

File src/openvpn/win32-util=2Ec:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736/comment/d02afeba_81f8d36e?us=
p=3Demail :
PS1, Line 182:     if (dir_len =3D=3D 0 || wcsnicmp(dir, path, =
dir_len) !=3D 0)
I think since you are doing dir_len -1 below you should ma=
ybe change the dir_len check to be <=3D 1



-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc
Gerrit-Cha=
nge-Number: 1736
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gmail=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: stip=
a <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Sat, 27 Jun 2026 10:36:45 +0=
000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--d7B1B8ZEPaM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>Patch set 1:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1736?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/win32-util=2Ec:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736=
/comment/d02afeba_81f8d36e?usp=3Demail">Patch Set #1, Line 182:</a> <code s=
tyle=3D"font-family:monospace,monospace">    if (dir_len =3D=3D 0 || wcsnic=
mp(dir, path, dir_len) !=3D 0)</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">I think since you are doing dir_l=
en -1 below you should maybe change the dir_len check to be &lt;=3D 1</p></=
li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1736?usp=3Demail">change 1736</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d=
1110bc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1736 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Sat, 27 Jun 2026 10:36:45 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--d7B1B8ZEPaM=--


--===============6477382934197613586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6477382934197613586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6477382934197613586==--

