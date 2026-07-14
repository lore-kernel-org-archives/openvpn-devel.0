Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D1BC43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v27/2GYROTVem8EzaGRb4jNzgSyb3z9QDCT/Xe5w22k=; b=Y7UCswIgdSdJ1feFBIWOtGnU3y
	NmUGdgkn8QVv4ImXVldhyj2TamVD77Aliq59nT9TQ/IxKpPGJx2MvufcGlmOkM6PXjIQIiQhqwS8Y
	8jdDGZpBXTys5ia7TutIWQt4WqAxKzjfqK0W0kK7gF8Qu/ectPtMNyCkXMmLey7/zvHY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjau5-0002Wu-Bi;
	Tue, 14 Jul 2026 11:02:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjau4-0002Wh-8n
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 11:02:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pwxZuzzPXu6MdJaSW9t/e4o+pQzBa9KJiOwvDQ79kfA=; b=WUHxSJY8vg3E0Ta0NXr9CghwGZ
 dQKCjomJRRM+cJiZqzVwm7jwKfcfk/6BWjg+6qWUoG6seJduZ1EQXborPt7EzS/CCHwE0Eh5CtpE3
 6fBIXHhY5P9i/KRkyu0hkUI34V9sgDFv5dKn9OqV1or/2uqIT+7qkfj+7ZU/IrD7run0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pwxZuzzPXu6MdJaSW9t/e4o+pQzBa9KJiOwvDQ79kfA=; b=J
 qgxprQPQ7FIMC8VIEx8GJQDk89JD6SESglqjaBdQZmxlXu3DllQkIuvMYIY8W0qMY1Sp1iWbO/lyQ
 rmX6AyK9liFZosJYxZ6UyVkprM3iZOK8+qH+hAPh+QMYA3r3iMktXt3hHPRxR2cVsb2jZvm+lpmSN
 eA94kBMmah/tfhXY=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjau4-0002BR-FX for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 11:02:20 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493c7902f47so37465085e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784026929; x=1784631729; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pwxZuzzPXu6MdJaSW9t/e4o+pQzBa9KJiOwvDQ79kfA=;
 b=QcY6tYzgaByYYdx+raw7laxt7DgpFCIyK7G1uSXswfnYwQ/EkW7WurW+/dEYcMiseM
 VU9f6wL26UYTIV7MwPYQwhPloJaNDEmzzam/3ph4SNI6Ew4Csg/ca2x58aniSx4C0Xac
 89IAhuqSXgwwa+yWYl1b6P6AI5mTpKsVvpJlh2cCTQbugdRxwbR0h+VX7RcNfIcvokCm
 bJiU/imRYzWwlGoInbDe9AanyLzYhxYHZFJwuAHCUN2ZOhdQ5/ZS7XWNEqmMblX/Z49C
 /PVB1UrvRG5aWZkv6vm9CHCcUg4LcVIrgX/loiulVp5J9UnKYh/fl7ibwYWUpR6mV4eW
 8Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784026929; x=1784631729;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pwxZuzzPXu6MdJaSW9t/e4o+pQzBa9KJiOwvDQ79kfA=;
 b=CBtgOSWHKU4WSJ4xTZm0adWa39RFaa/znAYovVpJzx2w5R3a//8Js3BI736vbFJ3DO
 lBI5glvcyCnXHf3AXwU7PyUbljVAwKAi/RXLNXPKGz1u7gEUN4TBFOc1/f7djRY8Z5BW
 mv9HS9rVg6rq6PPh1QLwedf+JdnImGzPUtOirYo5pyn6hQx5Ykp4ITOmV6YBZ6UGPsWL
 HKXUEGYHRTvpuU+NXbllzCeLzIBM6rB5PQXRbp/Sb3nuRjRnxkR4vdTO2J3Xt5kFevZS
 tZrcAfZ0gT2DvVsB7vqPZfVjt5AHZTOqbZOgRIsbRQSxmqlcC6SbMvar6ZNvlWV8zEoK
 MUlg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAn4VGqn2vP6KkPZqKAWOI05La007NvxS96F0WtPKIdfWPr6bqf+GpLWyo9K5SVq5yLok+abLtP/J2GEgB@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwIqvfSmiDPKRreHjM9iRBEZensn81k40Q2fHC42WuqzfAp0xCD
 vl7OSatEUerZY4ryizKnuyyq/lUGeEJ1Fr3lLisa3YvCvhBCycGS+VkGfLHwaINniIr8VHN3ahH
 3aq3Mf7BCLGnu7HuNzcg3k0V7olSujeng9/tXouOaVdh4pFw2MDvwRm+fVAQpjfpqD8PP2Qi3gA
 kGQ674tA==
X-Gm-Gg: AfdE7ckBC2ZYRkHul/g3S+jhKKu2BCtHmrzx7QnPv/FEMG4QeLNFiocbJaIXtpFkgWR
 nKWm7mC1DDrQFrNAA2rivyzgf0/YkKZ7nu6+Br4a+BS/ycvehEvj6A5e0+hhIzPFOtq9gZH5HBq
 juT9bIyXDEN4NDfzXxmj+ltnTZVrzH84D1/Wg6cBZfSRBIjcYiuyC1jUqtp05uN6O++r5b6WdG7
 SN5x3fakpafav7hRmea2ZDGx+iwczI2U4JluzTpQfn1CBOVSUEX2m+gmQeV+AqQUyqEYOW5qGkj
 eeE/i+1syi6eKX3bbAexsmyoXcelWLAIWmMjkV/s7UFY5k+8RrNcsbRX3T9Xv0qboOlRlkreWJS
 o3UKTzZR+vAVexeCE3cn0YLsRHPu1dZW8E/MDgf9WbH2PPMtUd/g5BAqrI2rH6+rzlqpXlbS6pm
 lDQ6frkUWDSjKSzhNBoGK8CclGN1zDohZJXZ92Ym4bXT+Zt5MC4dBPhlo3Ayqc4kdDBuswhlmqQ
 IrxIofk+DfP0aBx0/UDX2LE/I/QoJ+S345uLsRAWphxA8MbcfsS9euewStE75BrTGwFlwkMnJnR
 irY=
X-Received: by 2002:a05:600c:8b88:b0:494:e456:4596 with SMTP id
 5b1f17b1804b1-494e45645ccmr43281895e9.21.1784026928572; 
 Tue, 14 Jul 2026 04:02:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464b7f09sm7155497f8f.26.2026.07.14.04.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 04:02:07 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 11:02:06 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 3d5e28f0683c691004b7b18966fc4a8caf35d50b
X-Gerrit-Comment-Date: Tue, 14 Jul 2026 11:02:06 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f49bce0d089ae54162317260096175fa81253fee-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjau4-0002BR-FX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 dynamically allocated ctx
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
Content-Type: multipart/mixed; boundary="===============2035843043536042143=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2035843043536042143==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oyPhjbEqi/Y="; charset=UTF-8

--oyPhjbEqi/Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1571?usp=3Demail )

Change subject: Change hash iv to a dynamical=
ly allocated ctx
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 9:

(1 comment)

File src/openvpn/multi=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/3f2398b2_dda35ea1?usp=3Demail :
P=
S5, Line 313:         hash_init(t->options=2Ereal_hash_size, NULL, free, in=
t_hash_function, int_compare_function);
> Since this is not using the norma=
l hash function=2E I added a comment to explain that=2E
Done



-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde82189=
9839324d
Gerrit-Change-Number: 1571
Gerrit-PatchSet: 9
Gerrit-Owner: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Com=
ment-Date: Tue, 14 Jul 2026 11:02:06 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
C=
omment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--oyPhjbEqi/Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/c=
omment/3f2398b2_dda35ea1?usp=3Demail">Patch Set #5, Line 313:</a> <code sty=
le=3D"font-family:monospace,monospace">        hash_init(t-&gt;options=2Ere=
al_hash_size, NULL, free, int_hash_function, int_compare_function);</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">Since this is not using the normal hash function=2E I added =
a comment to explain that=2E</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?=
usp=3Demail">change 1571</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1571?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1571 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Tue, 14 Jul 2026 11:02:06 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>

</body></html>
--oyPhjbEqi/Y=--


--===============2035843043536042143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2035843043536042143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2035843043536042143==--

