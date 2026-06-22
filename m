Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876B6CDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rFcuTEGcKt9SRjuHDAKnHeOVhZDPHNfzNP2H/rjH2oo=; b=lJwCLju/Xgw7hZqvFP+jh9MlwM
	8D4N5481X46+FThe0bxGTDVlEgvCjdVr5oFTkrhy72NFpCmSyCTqrjA/T8NdPu1ocJ2LF6CpIV2SE
	Xu0/f0D59M6cfz4pVFKYSw+lapsDSTrBUbTHg6v02inmxvN2PyUVwthw5yyvzTG6AflM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgqX-0006U2-7k;
	Mon, 22 Jun 2026 15:46:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgqW-0006Tu-3d
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:46:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wgFN61oRv3Bi8Etg9HCm7P12V3f1lEqOLHNqnRdwqPI=; b=QsKzjuLIHz7jdw75qrCFkHtooa
 jXaKOGG5EKIFPt7Un0qjDM7IflQ9vKqpqi70FXXbxXDG7g7jikg/HnhQWyCPOkZ1ZudF63ErNtDOE
 p/NdsfOFnQOnE/bOJuDrGJ6S6NrIxYO1dDl0cyq6nRx9cH9/GEAdzhE7wMQf6pTPkXUw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wgFN61oRv3Bi8Etg9HCm7P12V3f1lEqOLHNqnRdwqPI=; b=l
 KrVLK/Eriw0MmPO94GqKUqXYNRjWgCSdrwLdEj/geB4hotILFKj/2eV1KCxKoGv1PJecRj8ZwIfQq
 6GFL4x1psR5w9io0/vtovgLljwNOu2356eyRCzAzjiNzhZ3yLwoB2udE7eHLUKBWk/+fqRITqcxDh
 ON2wPZ9knZHYjo5Y=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgqR-0008Rw-Qb for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:45:59 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4923139e940so26727885e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782143150; x=1782747950; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wgFN61oRv3Bi8Etg9HCm7P12V3f1lEqOLHNqnRdwqPI=;
 b=AaF+wyD2yH267zRIbUgfgUT2vYspquIVoBO/pnyjE3547xUUx+ltLZq9pSmc/QcGvX
 yFNVTdXu1gl6aOseqAvFxNN3tYxTxLb0DFVjycWhvksR0UQw/VS8zu23oTyt/RpjN38K
 7VXEndN9kD+oJXXI4UZQvqyKKhF4UWuEIZXIAzP0T3hGBJU1FfWx13Jkj+lW9NYqUFY5
 LCi/R24tCGh8100w934CqVuyYSNH4Hl4ajBfW2So3c4TfV5Y/TFPebKXxNjrqEUNI88p
 nfBoVKzVabPWpYTGEgFcnwhwPT2HdizzeDNYTiCUr29vuyVhHol2c0jXvgJj8z4lVC+Y
 u0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782143150; x=1782747950;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wgFN61oRv3Bi8Etg9HCm7P12V3f1lEqOLHNqnRdwqPI=;
 b=Ce63t+A2fKAbI5PrpI/J5OObEB+8z/z9hIFkaLWDt/tD/pvnzvocblbWGPemzsgo6V
 mEZPIB4mZc1Vqw8lYB0HAgKuSp3MlTewqYosXSeg1eNsb5ss/nfrnT1SSYp08Hud6QO6
 Y4fwNju37NLC2nled05wVbzhOc/1ipnAb2gBMZ37dg+v4wM/xxq52aHaMfAFbaUinxup
 0LTIf60k+5qq6euB9M98jSlJfQPVeqw8sLKXC1kI1PWWfo2sP9RYaNZI/PrOBUC35YsQ
 oIVHgleV0KSMkNqn3nnSCvtbYpGphO1Uzxvvf8J3tyqN4uGlIorQ+FQ3cYEUL+GVy9et
 zF5Q==
X-Gm-Message-State: AOJu0YwAU/IOMrhlZtsdAxvwoBBD7hWpwCrEDSzQN2LixFhUffKJjayS
 dfNMyQCvZ82Ss2AqEf5P+Nfnm5f1S31xzyFaeY0CcM4yDNQNuvGbn19WSH8tz9m7IgmtZDhlmJT
 +D3rTyeEEU1/+shGeGqtGYelp7qS0bKPNm/KP3qoE/Fgzj7ZfvJI2NRFFZjSILtcLgxkqi9CSyr
 k7bV4+Qw==
X-Gm-Gg: AfdE7cmjJWXBeRnkrdDd0jKRD+o9AHWkF9f8+vUnWeY0TKdlf0/5jf/SlYNSP21+W5X
 qWjVNOGXNNxT69WCfry98GJac6QMFUxk+92A+rgRBQOPoT4Z8/By6qb3+us/LRkhkXEL6FD6DzW
 SDyrY1KpK6Y4n36CvyNDLu/0AdV/aOEf4B0H8DD9gW0gc6IQsLF9yY5RCWtw57W6XLSSrLD54Tp
 jR8lvRM2wqa+ynhbmlEjUNLb/FNjd0NY96Deg6pnyn6eeaEXj+UPBU6+kQ+nBpJ8gWDWhhqnb2o
 r9LGGy4AgYmoUNuxnDIK6pLViyY7iS9jSCB93ITt/DW78bAeP1M+R27uM8/G2u/QD/5H0WEJUki
 1iLxuQbgcEdhPr0xjhPCJJVka8FUmwQInLNMcMaoF8lemySVTqur4kR7/dzEoCmvE2Mm2muyTXQ
 EfVLU7A6casmP5fkwU6PaFsGKf0HIJuQcje73ZKnwg9HHLyYiNwwlbx9z8NjCscGyyxsIhfBkOu
 q1GO2kZ8fugpB8KoC7aNm0dzlNiQs6etfAayxCnFrq9VFT9bZmfPt7uFA/LP7+irbSN4I7Pq3Rm
 q24=
X-Received: by 2002:a05:600c:c167:b0:492:2f2e:e7e7 with SMTP id
 5b1f17b1804b1-4924256fdf8mr217792385e9.17.1782143148738; 
 Mon, 22 Jun 2026 08:45:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4666712cceesm26472146f8f.35.2026.06.22.08.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:45:48 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:45:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de
X-Gerrit-Change-Number: 1720
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1720?usp=email>
X-Gerrit-Commit: b6d62f43e76d30a195744dd5a129389b3c23327f
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 15:45:47 +0000
In-Reply-To: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
References: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk2YTAzMjQ2NWU2NmI0OWFiMGNlOGIxYTg0ZWFkOGQ5YWNlZjkxOGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f9584084e4d06c12c1549e338f3f2076031cc005-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgqR-0008Rw-Qb
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 handle_connection_attempt from multi_get_create_instance_udp
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
Content-Type: multipart/mixed; boundary="===============1185417334000196054=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1185417334000196054==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/vMqu+ggyqo="; charset=UTF-8

--/vMqu+ggyqo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1720?usp=3Demail )

Change subject: Extract handle_connection_att=
empt from multi_get_create_instance_udp
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(2 comments)

Fil=
e src/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720/com=
ment/f0f33608_0184e108?usp=3Demail :
PS2, Line 197: struct multi_instance *=

should be static


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720/comment/=
fb1756d4_a03663f9?usp=3Demail :
PS2, Line 198: handle_connection_attempt(st=
ruct multi_context *m,
should have documentation



-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de
Ger=
rit-Change-Number: 1720
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon=
, 22 Jun 2026 15:45:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes=


--/vMqu+ggyqo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1720?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720/=
comment/f0f33608_0184e108?usp=3Demail">Patch Set #2, Line 197:</a> <code st=
yle=3D"font-family:monospace,monospace">struct multi_instance *</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
should be static</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1720/comment/fb1756d4_a03663f9?usp=3Demail">Patch Set #2, Line 198:<=
/a> <code style=3D"font-family:monospace,monospace">handle_connection_attem=
pt(struct multi_context *m,</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">should have documentation</p></li></=
ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1720?usp=3Demail">change 1720</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1720?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef91=
8de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1720 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 22 Jun 2026 15:=
45:47 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></ht=
ml>
--/vMqu+ggyqo=--


--===============1185417334000196054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1185417334000196054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1185417334000196054==--

