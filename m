Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32BEC5B572
	for <openvpn-devel@archiver.kernel.org>; Sat, 22 Aug 2026 16:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zHAk1Z7hixCDdV7RPL8Nz57rhAY6BBZGTCGCuct/RYA=; b=d+l9a9i3bK7Y5u1yKiaQJ2SZ/G
	iEnqAjUWGss09jPcUzc3PCahRnWVB9+cFUASXP6jyeJrruX0kPEF9X7TJI1miIklrJteV6jmV9Hxu
	eQgjVzuC3LDJP63MVaQHC9clKNHFFBDbVEiuaTj7UjLoqazQSONG4YTlAtBeJQMwifRE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxoFY-0002fm-M7;
	Sat, 22 Aug 2026 16:07:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxoFW-0002fg-8q
 for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 16:07:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fkRJ+giaMdiWRCZUbopdcKV4mIvebFALJET+pYuP9RQ=; b=b0AXnVaPQDz6KjLUVo62Mt8qu5
 2POcd9tEOHJz6bBOaa7oTZO6ynMNNVB1ZiZqVAU7DpiRiOFqJmYkcXFZ3h+i1bhrlOZlMQeHQZp3a
 g1iFzRT7LFRXNJNMTtryHkJ37yHJ2wTvsMUFLkylwuuYjCZfUP6oVU7WeHkekFJnzE8o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fkRJ+giaMdiWRCZUbopdcKV4mIvebFALJET+pYuP9RQ=; b=Z
 KK72F03Es7htqUM1Bj83X6qXMFxp6qPWlW7sV+wKqqXith2VCZgWAg9i3M3qBquTCvA6PbQmgZ2H+
 7Xs/feFLlZ/xotkiS7VURjBu32qvKgYkY/7v0hAQtKzbjFqgUSZCqaF9HKSgwUG0ZmNsH/mfWxAJ8
 vKeTapwCx1H9siho=;
Received: from mail-ed1-f49.google.com ([209.85.208.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxoFT-0003me-5V for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 16:07:11 +0000
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6a156627e22so5738934a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 22 Aug 2026 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787414825; x=1788019625; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fkRJ+giaMdiWRCZUbopdcKV4mIvebFALJET+pYuP9RQ=;
 b=UM2tmHGmcuWO2eEEP4LQDvFvooVWs/YA8Ue2Lb7Boeg9otqyR5UzfdoFoZlsGuvCEX
 Tttb/N79mGniwM+6ieSvGmjwKdFdkXnhYn2BEtMSpJJ8DtdJX4lEb90spiUOTAg6Z578
 T2EJFPHVmY6hAoRDZqmkGn/K1z8QQcq1LFN4mqqVMjJ9UT/xCnhSX7IPp2Az8l9F2+RH
 JYdgMRJS6t8f13Qy0z2e1nPuCAcuD8kmUFrog1TQNaHFiP6Khu7aL0KcF8w2E+XwoEnN
 lV7hWSK8bMPrl3KSfnWbucklNGDKrida4SqVecSHnp8BlhUoS7iIhgynwAF+67hiG2Qz
 b+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787414825; x=1788019625;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fkRJ+giaMdiWRCZUbopdcKV4mIvebFALJET+pYuP9RQ=;
 b=Nh+v0s1FgKmacOS+Cf+tdlUzoGDCOXS25Nn7NV0ttFgYiFqoLhgYp+4EKIAS/McSPl
 sG7bXgrKPyV76JZYHJESP5Besc1KRCBg80ZhHLEhDZAs3n2C38BHSjSXNYc6+swIZdLW
 sRDPMhnaVElXvE3l1rVqrhhhaVv7seRO/0H0Pm0v4weVxFSruNGVHR2FAMEXIan0Dor6
 my9oXNYgOW8/lmKkaM0E9MmDmH1J19bHgzvNLHTzkVdH6eD3Y9ZxpQ8tmUdBS71MXNTD
 g7wi3mL5AfveypLFynBehJYD2LsqDV1i7xVN66vqQOSDLPfQKOLnVAKoEPwhh/Ccl7ra
 DrWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrI/j1+R9IoBl0Yvi5TYGleJQthEb8yGYGtc3wQIEiAAtRNK/I2fTOGfGuGoyEEc/Zeta++Zg92iPY8TYaR@lists.sourceforge.net
X-Gm-Message-State: AFuF++k8G2wS9gScJFOkGmItbMDmpNUAP4BooDAETX/bC15WCTyvbcnb
 JjwI4HmvhOn5+BjFN69PlIDkADFpsQ4ycJXt9D6tRV1LMzaPeUsJgCvRtLRps4FVvP2VmeinAg7
 8fduXw2fwe2ren/ZOZ5apxq1AieRBOgpRMHgiHPGCWmtDQ42QuewmnKvikOvshODa0qFq
X-Gm-Gg: AR+sD106W7lAfQsCKtEvsBqS/sssEwsCAYjvy9LxbAZz820Oek2HZ2/JYMRb+t5vijR
 ydQbQOrR9kO+Q4+DVz6dLP3dg7QMnYg9qhz/D37dpmP55ngmDya95oGdLBH6q/aukqUFLiHxcik
 7v79idfq91C3pEz9GGf0N6vbn7Id5Y0JVCGjbKz79WLKe7uYYaqva2RjnADefo5zQnXWb4FdCaB
 64prop8JpAi3KCGeo8EdvUPGEhi/UGg/9y2zxLUIkrdZGsjpIAaQGQyEWZtqXezVnHISN4g5QMe
 /fbcWXXdyE+deIy4RCjy+lP8A6ayn9RI3PIJCnYaJN/pXKIf819wILtgnYWJztm8m8OKpVbcTs4
 xpv+5+Ap8kJ1N1MhYrqGU1O0dDuliMqGjn5cnotE5GScoMOJt7t1l59opJSQ+A5JzKXFtTlSCgb
 B4WXMGEN8JPMmFXtFtuDldCIpeOBaa53+utVVMjUJvL/P98kkXcbbw3tlcFJbgVczSsPeVzEW5D
 4sWuSL9Rkxw/+nQGHLQ2Ewx5cmuZVSGP50bJeOKRWM9Y4JFsPYtpnqnotnCKSyvaIf2/m1rzSfD
 1lIUkKMCcS6Sfi21O0Zz+Hghm/vBdvPl+MDgLJTwtbIiHMEMAkFerHPHzOyjjzE=
X-Received: by 2002:a17:907:c408:b0:c20:a243:9a52 with SMTP id
 a640c23a62f3a-c246d3bc308mr1386213166b.0.1787414824495; 
 Sat, 22 Aug 2026 09:07:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm365635866b.38.2026.08.22.09.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 09:07:03 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 22 Aug 2026 16:07:01 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ibaf84cba0124320f7c49e28d1b3364dac9e8b6d9
X-Gerrit-Change-Number: 1586
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1586?usp=email>
X-Gerrit-Commit: 103f2bd05530c0ed4e3670018c3dbe4a6dc02d59
X-Gerrit-Comment-Date: Sat, 22 Aug 2026 16:07:01 +0000
In-Reply-To: <gerrit.1774440822000.Ibaf84cba0124320f7c49e28d1b3364dac9e8b6d9@gerrit.openvpn.net>
References: <gerrit.1774440822000.Ibaf84cba0124320f7c49e28d1b3364dac9e8b6d9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0NDQwODIyMDAwLkliYWY4NGNiYTAxMjQzMjBmN2M0OWUyOGQxYjMzNjRkYWM5ZThiNmQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0143552fe7f795f33762418a80dc98b8bf484b4e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxoFT-0003me-5V
Subject: [Openvpn-devel] [M] Change in openvpn[master]: test_networking:
 Allow to test --netns
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1271398644207960787=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1271398644207960787==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IuPgbaLjP1c="; charset=UTF-8

--IuPgbaLjP1c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos=2E=


cron2 has posted comments on this change by flichtenheld=2E ( http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1586?usp=3Demail )

Change subject: test_net=
working: Allow to test --netns
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review-1

(1 comment)

Patchset:

PS=
3: 
Razvan's finding need to be addressed



-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1586?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: Ibaf84cba0124320f7c49e28d1b3364dac9e8b6d9
Gerrit-Cha=
nge-Number: 1586
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Revie=
wer: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: its_Giaan <gianm=
arco@mandelbit=2Ecom>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Sat, 22 Aug 2026 16:07:01 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: Yes

--IuPgbaLjP1c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos=2E </p>
<p>Patch s=
et 3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2p=
x; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1586?usp=3Demail">View Ch=
ange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1586?tab=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Razvan&#39;s=
 finding need to be addressed</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1586?usp=3Demail">change 1=
586</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1586?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
baf84cba0124320f7c49e28d1b3364dac9e8b6d9 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1586 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt=
;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Sat, 22 Aug 2026 16:07:01 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--IuPgbaLjP1c=--


--===============1271398644207960787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1271398644207960787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1271398644207960787==--

