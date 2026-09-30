Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44523CA5FBA
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2odAxoLbiWkWJKugWZsYK5D8TWsd6Gi1CQrD2M1VPQ8=; b=C5zcjXu/OAUKq52a7jiogp3VA1
	u8vOO7z5KBsT57kcnA2BwrE0PD7rbihlRkVSK5MjKptk+X1d+v62ksnyfQSNxIAZ+4VMtc67T46cR
	MeBPre5n66s+/P4kRbFGgQc2vz1KkCOkkBu9lc2x9y9X0oN1y4obD8w7V41UV7ePRaUg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBrdL-0006tK-9L;
	Wed, 30 Sep 2026 10:33:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBrdJ-0006tB-Ik
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 10:33:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=m7D5PgZQu7GU3qnvGwGLmGpJEDxjpJ2SdHy9MOjAqto=; b=S30cgTbPulq6ilE8zHJFVJlm21
 yYSOeXxQB6CRUczA9m0Whrnspy1BX2I/rNi2gpFXMOvjvQVKCYjwweFTBdXdCP5zcoVWr3jfq+kWH
 Wh4yiRX6BCM7vL5M6oxGzq4hMU8c7C+V6TCu1P/W/+c3iRAhHhOwRvdHKgRDWECMhE1o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=m7D5PgZQu7GU3qnvGwGLmGpJEDxjpJ2SdHy9MOjAqto=; b=T
 +xEauQ3sbQtEQNmHhi/5SnJIgLwMDUgM9W+/8RSwhvN94u4C3YRgaP45PVqcLoFExXwVp2Ix016IT
 vW/YZFJTYs+bwhIqYFGOtEJGstXLahGLn9JhH32RDh4Ontq9T03aoxpOKuctMtp7sX5SGwNDXavW0
 +kUxEsA6TNeq3u9M=;
Received: from mail-wr2-f33.google.com ([74.125.225.97])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBrdI-0002Px-US for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 10:33:54 +0000
Received: by mail-wr2-f33.google.com with SMTP id
 ffacd0b85a97d-48b024549a2so323739f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 03:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790764426; x=1791369226; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m7D5PgZQu7GU3qnvGwGLmGpJEDxjpJ2SdHy9MOjAqto=;
 b=Ij/K6I4EbYa5DV4eNtITRpOHOx+/8ZoOA5UrgYQTu+yQ/uSw48nxQmr9FKI+lW11Rs
 Il+15GJOuDKLm6ZJeOoLxL/nuwaGBbAbi68KQ1c7ams3ZBO1WPLoSVuMy6Wtrq6CggPP
 PGQ4eSIicQm35xmBlyag9u/pUYlsvkezqOph6B++Pw49mJp7TbD0CDwe+Th3wFgNrlNX
 GF1zCfql/wVds7UjZ9MGi8XrQyen+0yHiTZuaO6fB2Joi2Ko10RBXXu55ifxTGxlhro1
 6AEB5qkaaLfu8O9edlYWGqQfBer6F8cBucc7mwnEnY1KpTEU1za40ustQVBy9xuXRhwb
 UMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790764426; x=1791369226;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m7D5PgZQu7GU3qnvGwGLmGpJEDxjpJ2SdHy9MOjAqto=;
 b=WcpvwKXZt9fkhVBccLF4yMpqO0VZxIBW2953asMed2Vj5hhTyCshEGXzRNHjOuJiqP
 VO0VkFCceIGmGJ6JeVJ5KK8lej/tTpgEyV2mVuedSc5U+iOFAm/IU0KRegE0ugFh1FEe
 oTEJDwKeELgYC9oZSvw1pv0CpYBAfcHbWhIEiYKyErY6vT/9QjCBzeDehoCzi/Wgw/Z0
 nzzUYyIiSzcw0xZdnwokW833Lty6XWqE3pVu2MQoEpq9IcEQoEGvm4klgrZYkE2DzH6A
 b3V8aVl0P+FmZelE/GjcB5JsRnd/C4eV8tJwPdvdB06eeXp/jk4ZQWLl+dgqvsds8ggi
 Oj2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwunKFNk3Upt4G9U5St0gRqpKHbwqv2yCpJbji++MrqxjVHTmxCse9/KQB5R/2ONnNNQkvvLkfLmQrgBeIG@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKRI9dRcx/owkXG/QaFkBkT/H9cxhouoE2ETUV7iGzb40dFihQa
 nghGwSD3Mz3CcY2MVcXSFHA0ckbdnbFwfMMzFQ0y/GwS2lTWJuMbzWCtYlSYHC/IGmZxmMdal3u
 R6zglmwol6HxRQsC+gp80s+fAgxf6FXFwTkBrQDBaYx46Yj+N0+cfO6GNr+o2HgD0q9OD
X-Gm-Gg: AYBFou2yp5gpXGnVDJNvYVUaHB2V4EqGKblBWTO1Vmd1Xu7A8OgpVeoge5xieqWcCC1
 vmEvAE3kVJXnC4tpHZjVfzOraKg6mu9W8LA0MD2+1UcKIV6QOQwBYS3khtuOci4o/3tkDzBy0qp
 JLTVf5PnhDZpn7buOsJzqcguS6HGZ9QNG14nJpANiWENa2lQy88XfhFFqJm56Tg0oys4IuVP9Pp
 byffbXDOvNWM0l2LmlvWc9W8GQYlu7Oe1pdK02fl2uXjql7YCzb4dCZM8afQpKA4xMjoKq/cvON
 ECP8Rog7G8qHyIN9Kh/tiJdEmKYv3QvPTunc1TGWd6ADpwMOEccveskbgZvmajXjHqsGy1IvFIv
 Kxh+irODdW6Gkm1Wa/kdj+C1JRMtF+KOn5goGZfYlDe3rnJCSpyJReLMyQBosyYlOAv8nnzoxz7
 fCVlQzuOmGdYNTDhGLuKP5TlVSda8/Rh5lF+Ey720vD6LwA/U7YeEFRLtmFEiJmvWnL0GEIvc17
 c3A7XNy7UlL+rVWyMgKTRuOB7+KbLbhPw8BVbkAQBJvb8DR0OQYozll/tTFHUj7INH4pW41pp4k
 8FbqUorgez5JDDTa4vIOmlic5VF0U507wj9N9JjEg45fRlO/JbuTwjZBekt3
X-Received: by 2002:a05:6000:26cb:b0:487:88b:55d8 with SMTP id
 ffacd0b85a97d-48b024284bamr2421742f8f.1.1790764426191; 
 Wed, 30 Sep 2026 03:33:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029ff46bsm2544533f8f.29.2026.09.30.03.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 03:33:45 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 10:33:43 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 0160c1f0066118d78f9fcc46420134293de271b1
X-Gerrit-Comment-Date: Wed, 30 Sep 2026 10:33:43 +0000
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <29c4536ad37e0077a22075e61a5fbe8e1615b876-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBrdI-0002Px-US
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Answer probe
 requests on the server (P_CONTROL_OOB_V1)
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0039671571233276537=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0039671571233276537==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BvUxLzzoA38="; charset=UTF-8

--BvUxLzzoA38=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

razvanc has posted comments on this change by stipa=2E ( http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail )

Change subject: oob: A=
nswer probe requests on the server (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 20:

(1 comment)

File =
src/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744/comme=
nt/87c486d8_64fb5311?usp=3Demail :
PS20, Line 235:     else if (verdict =3D=
=3D VERDICT_VALID_OOB_V1)
Do we want to also gate the following logic on so=
me option being enabled? This looks like any valid `P_CONTROL_OOB_V1` will =
trigger a server response, which is basically an unauthenticated reply path=
=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I930d3789e0313a=
a0c3bc51ee5fd1d108343d59f0
Gerrit-Change-Number: 1744
Gerrit-PatchSet: 20
G=
errit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
G=
errit-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbo=
x=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attentio=
n: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Comment-Date: Wed, 30 Sep 2026 10:33:43 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: No

--BvUxLzzoA38=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
razvanc has posted comments on this change by stipa=2E</p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1744/comment/87c486d8_64fb5311?usp=3Demail">Patch Set #20, Line 235=
:</a> <code style=3D"font-family:monospace,monospace">    else if (verdict =
=3D=3D VERDICT_VALID_OOB_V1)</code></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Do we want to also gate the followi=
ng logic on some option being enabled? This looks like any valid `P_CONTROL=
_OOB_V1` will trigger a server response, which is basically an unauthentica=
ted reply path=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">change 1744</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I930d3789e0313=
aa0c3bc51ee5fd1d108343d59f0 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1744 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: raz=
vanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Wed, 30 Sep 2026 10:33:43 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>

</body></html>
--BvUxLzzoA38=--


--===============0039671571233276537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0039671571233276537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0039671571233276537==--

