Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7AEC88E75
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0OoA9lM8MAkyyKrCLQbamFquyX7OrG/adLbpnPBy8yU=; b=aPSEMkXGfFIWSQYjYKquFyVabj
	9N2AeiGn45kHczOF76MVEVEsc+16LKfpoH4tgrp58G6CuO0isJwroDprExI9di0rHjL5v50K+wFhI
	oPxNvGX3Zx0SdYmMxZsrnkcBpKPXBLIXWaqPvw8AxqrfCzmqu12H3Yh1bTCbTgXiQDu0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6W8R-0007Xa-A0;
	Tue, 15 Sep 2026 16:35:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6W8P-0007XU-EQ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 16:35:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9l4FAiKx58jZgzhuOUhhi/Mi9mOBLMbhD3JjtRx0A4Y=; b=Gr6q9fziUEn9LCMSJ17++h/onr
 N98GQHyEkAIu07s+55gCS4cnE5HwoxGOFCxoDCnSbmld7BDRiqZFT0IzMnbb1mk10Sfbkwmy4ckT5
 nrq+6by6a05Upw8MJI3OJ9/hqPXqjIgLvBoPm/+E6BtlttL2s1pCCD+9A8va2hw36060=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9l4FAiKx58jZgzhuOUhhi/Mi9mOBLMbhD3JjtRx0A4Y=; b=T
 93DG+5g5cKeNcpOmetmuTRGwPRqsSOD/ia9eBEUP45mO0yH0gorzwH/zpqO4TiwhA4rfbKc0xaVCi
 QHLFLqRJQ33SSF/FrrjnAmmaPF234QRQViJWWmzCciJWrKqnCtsmcWRtawBsjJiK9P/N/mmg8rdLA
 4/3P8rdCx9rp00C8=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6W8O-000109-EO for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 16:35:53 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48449f62b93so1135570f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789490146; x=1790094946; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9l4FAiKx58jZgzhuOUhhi/Mi9mOBLMbhD3JjtRx0A4Y=;
 b=CWD7bYnr/7+Bhc17dR42aobdK76t4i6FNzbIsOvdmn5UKTePIH8Wbhc7DN6t2+h5dd
 cfI0noAa0Bv7A9xCTqfBejk6bD5FvGGltbn7WesOpu29uZ3U6xrtmI0Ktm9lQYtKdzrL
 8VTGRYYIzkJZyS4ytTstDDV1i2tsPfDjQKoEfdQkqu4asox67+oYEar6KMYausmy7lkP
 JgLMWltGH8RI66Eh1eVG/SBABp/5DbZxp3TQcjYVlJs3nZJCXiJ3KLZTQB0F9Drxt4eb
 XRaWTs9979zGjNzaKgszzK9BgWMOF5QF8TEwxS1uwAPsu+JhQY1y/h8RTPetIA5O/h/z
 JQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789490146; x=1790094946;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9l4FAiKx58jZgzhuOUhhi/Mi9mOBLMbhD3JjtRx0A4Y=;
 b=YyDSwemeVSYP2+vqFOtIA0+po11TgHPZpO2pvX0QX15K4zPmta1vmDy+2PSkHbaR5D
 GlvN8VDbxpVTtNwyWtOHJeQ0550+A7edKd+CycprVTdbzpFvoKq3pB5bGtidMJ6u3j4v
 sM8dN92hppT+msVzwvlE2cc99rPbXYNPas7BQvUcyPMkc/axneJADEl0kIx8A8y+BM3k
 VgR+WEvGAIDDF95DAVFj9LRIj/Tf24ixC6b552J8Hj3nE6gh0KQpCjgsIwjy4ypcbKJb
 zJImnDhUMjgvVCl7aKh1IJP758gV8qqF2or4YVIiwr9E5/q7KxJkTMUyJCsLsYfdJ9fk
 0e7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzl+3dKUgd16/ZU1vitXq2uECE0Tfs9IMCyyGYYuZgCqWm/2fiJnLdRleir98zMGCdMIFiz4TsCltmLEq3g@lists.sourceforge.net
X-Gm-Message-State: AFuF++mixAhl0xN5dPq30tY5tepx5+SBvhhVigQCgIK+UFqIQ/IWGF0N
 74yd/OIN2cxtj5xdH/ACT6LvlAieMZWkpC9AQaNoswQ93Y4645aIfoV+qVwA6a+JSdG0j6jei5P
 aAJliG8LKeOLZqA7358XNK4EzS2tuIYCEQ5i7ELdcmO/cYhinTOckxwIZUBWRJuagiN9Q
X-Gm-Gg: AYBFou2x6/tHuEkixteIfSBjlL990TMwAWnTHIb7TmkHZrqe6ivy+YYg6I+7geviIee
 xf+Yph1ger0cUqBPcNHgT1GKyTtfvHsw96lHeHqh+tuYWa9yYKfFrjpsqNv6x2gb1wxMpo3Qhmc
 8Qey7VBME0pE+qDZ4970Rlxmbke3DTzgdoCYIh3XxmIXcopNeQB2nzSqUa+pa9uUFXuX8/ToleM
 5mzoFPHGiBBVm/3mmeVHrd1GEf+mQJcETrXl321RzjLJmAtGjxvxpgW8H6AKLv+SBampi9CWSIG
 rmrLDm7vBDV0UIWaWLUut8qqn+bzMPF1472+u/JL2YeYHQX1P7pJierX6c7QcDVl4bS2kYCCQdg
 A6Of1H+4QLhHOKww0SOIaqmp+l3ZEv7XHmsstrfgdsFy0CnlEiuiIeRdLqL/L9Bnb5nRMrt6Nfl
 WzR4ea/K9aEGNIBNEDT5u6VQJeM3bODnBBVKtv75Gi5+ufn80EPkokE952p9dCVcdwpooWrFY1w
 2qdL7+rKB4zfCLpXY2gkWX1b9ezk68XOO/+BN4yswTouuLGAePsjMb3mmrQzdd9W+3Avrjlb0cC
 hS045Ys5ZqooRySFNGAXdnL+aVwX5f2HiS6RoQ9eOQQ8TieC097Zz1esODNgog==
X-Received: by 2002:a05:6000:2487:b0:484:3147:49c9 with SMTP id
 ffacd0b85a97d-48705a39740mr7150841f8f.2.1789490145766; 
 Tue, 15 Sep 2026 09:35:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27a36sm220424f8f.17.2026.09.15.09.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:35:45 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 16:35:43 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: 0999fc1bb083c87bb4acd3e3011d11ad1e55e426
X-Gerrit-Comment-Date: Tue, 15 Sep 2026 16:35:43 +0000
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <61d77efa38589154330286922c84fbf2b1466d83-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6W8O-000109-EO
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make required action
 returned from pre_decrypt_verdict more explicit
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5108229562277040320=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5108229562277040320==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s6V/EmM6lnc="; charset=UTF-8

--s6V/EmM6lnc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
zvanc has posted comments on this change by plaisthos=2E ( http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1826?usp=3Demail )

Change subject: Make required=
 action returned from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 10: Code-Review+2


=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iccdd4cfad090c565aac27=
e16cdaa9871106c2f89
Gerrit-Change-Number: 1826
Gerrit-PatchSet: 10
Gerrit-O=
wner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Tue=
, 15 Sep 2026 16:35:43 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--s6V/EmM6lnc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
0:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">cha=
nge 1826</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1826 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gm=
ail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Tue, 15 Sep 2026 16:35:43 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--s6V/EmM6lnc=--


--===============5108229562277040320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5108229562277040320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5108229562277040320==--

