Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E157C79FB9
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n6U34fC/8HAKK+Jiv58vUZAxUGdMl8wv1poE+zi9wf4=; b=ItC4j3WhcB7NUXTkAzK0rsdi81
	NgNfWx0o4Mt1ym2zKjyWvfBglOPUg2uUqkZ++54KkmxEouPUThSdPRp9IgvJ8AAcr1epfgt9ftjgI
	28pjdlqC6RLo9AoxmFgyUq5okkowVZpas5639YCbLlDZKxeSkomX90pHgXW2UWy6+r6c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4GjB-0002Ix-At;
	Wed, 09 Sep 2026 11:44:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4Gj9-0002Ht-Cj
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:44:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CVUTqAd1/9wAn48XPcGk80YLxe3vuExEqv0xnngBGmc=; b=Y/sXcHPcGSv/h/RnRCS8WbkFe1
 eRt9xczbKFkTuSavWTNFpLBQAIjZNNU4p22bnTioFAkFK9P4CCwxtWSZhXZdErcXnhp/YmBkR93Ds
 pXBYz8xRj5dDZ+Mi9XhF02SaXydGsSfIx3LzyA7qEoCnxuodfkdXuUvfnViAhIHuuZzM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CVUTqAd1/9wAn48XPcGk80YLxe3vuExEqv0xnngBGmc=; b=i
 UkFk2+aPyVChRCK+6LT+PW/0K25Otm3PpIATRRXA649ti5ZT9JfT+MOiMLRPeZbkZL5Mx/KCt4Ua7
 dCJa7VXv15iMr4IYi9xOUa/CsS1LKb/TA0L0E5x9bGIH0hfbj6V0AqKVLtbQwTcRr+n7lYRp9YTj1
 Bd0oXt3i3IfNwkEQ=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4Gil-0000nN-D6 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:44:08 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b91369ef6so841425e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788954241; x=1789559041; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CVUTqAd1/9wAn48XPcGk80YLxe3vuExEqv0xnngBGmc=;
 b=a1VLRkP5PlRyHKoIWNzIQwKAvyU9QJRJUiGLfOa1EumlicFOr3L9YxP4ScTU0P/cuN
 LWO1UMGHpprFw3QWY0SaB2tQSuf74qm32g1/BtIdZe+U+9R59hfGeGRUQ/It7wYIUWr0
 rakTwO4rxa8ATVF3eDj4F7EuQ0YsJw7SQxHk9fDRE/+y6y56mt3XIG+mSG8ycu22AfYJ
 KoTXKr216ayKJkSeHHOA4GJjPslGE7kN3YJ1uWCZWDfY2yY/rN7zUrz9efX2PrRs6d5L
 Def0+X6ycnPP8koG1+ytNrsvV9Yo37LkjKd+oJIQOIXKk2uaFPBZVxJOO87qIrAc7dIB
 6r5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788954241; x=1789559041;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CVUTqAd1/9wAn48XPcGk80YLxe3vuExEqv0xnngBGmc=;
 b=tA3Nicf5zlUxhx+5NreuDtFH9ureo1ycbJ8G/XJyWhV4wYRHFnd69wCKjbM90GHm4v
 szbGFINQyKcgtBL9ikBe94ICOOeAOTHwLsiA3/sU3tBAs166PRUMYzjjQQ42DLao0ewe
 IcFiqJVdZaeKmzQlv8C+155GLaoCryyHowYy8EKdmolDH1xYKkx0MlvgPEC+e62+/cus
 PgNGqV+EWI6YRdQcgEBXyxkTDTe2+EXR80PxHu3eo4gKlDy1Tv3ZPUxW69MOOy5PUXO7
 0qlMoA696/IgFh9min70L4w9WKH6dT3UlJ9pQT9O5/wVqnkKH0XysuLlFl72HHiglAN6
 W2AQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwX5x2F1YHb+DEosYnnGaa2f9L2p74aIIC6PlxYmPz8Ip0xqn3FrkyRvBK+NsY8K44H6UxsvnFUnc8G6imB@lists.sourceforge.net
X-Gm-Message-State: AFuF++mWczRF7t9LkQE5dxb58eKTvmZo/5jACCoHDuxqxpI5dc5V+5tl
 IM787Qg7zNgDf/jnTOh1OHLo9g44qbYhW1E1RNfn2lezcx+4eX0QyuS0BSz6xeKLtVg/nNWRb4E
 G6ugOrgJwEl9M1eRE2qGkruAp+4dR8Gf0FOiYyr2UC1vRxo/0HJ2X9DxSPdNafcwONfHH
X-Gm-Gg: AYBFou33PUV1Ab10KbM62oFPrY1AKvVrJcwifAdjv4TCONOQT2ch0DLr6zZkAElTOi4
 tIlHXdhEZd5vMwai+PN880OhYjckSSkw+9THKaF6G0R7csylNcTOgn/VRtR76GIaz3Eog7RAlHj
 kGuvenf7bxvT2oFJ7Y9q/ZMQUccUzjsz7r3WgUk/Q4jlvf+TKY2Yl2aAgdBILRy21Gyci8hTSae
 CBxEeKqNMA/yX3LKp7SeApDirXhR4qn+VzMxm86N0ZUbum9XAsKmstfm4mEnGmtYvPdCf62b2t+
 gfqjyHkXu7CqSQUHrEenB8RWjGCZVXHcuQWXuxq9Fp8NuLmCahSMP57o0p6OP3zf5ev8wsA6IX4
 qO4FS2E/17XJ7/n9yTeY6Oh3JwoY0BUJ36+mgMr3itKMTX4RKK8/5iBdhpt2PtGga5UNjOt0r93
 2lt4WtUHXiYuZ1j3ZZkRGQA5F4XocmYatDa64DOrWl/Q4S0wfGyhli5HaB+Xd7rRCjX8A6qmKGg
 4Kyh/IML0JW/elW3NdEerqk96b3s3j+EcmRdnfpQZET/3hZw43YWTZ9j8Jr/arWQRy40966HDmY
 RDZjqn++u9IMirY7BFMe7nGpfagF988pseWWUPUpd9bvkGJZwk9yPfxcgVVrsg==
X-Received: by 2002:a05:6000:4819:b0:485:ac96:7272 with SMTP id
 ffacd0b85a97d-485c23e492dmr2112955f8f.19.1788954240758; 
 Wed, 09 Sep 2026 04:44:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c074asm42359170f8f.23.2026.09.09.04.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 04:44:00 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 11:43:59 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: 9fbd7ea4380f1158846bb9346d3b6d35712e7a8f
X-Gerrit-Comment-Date: Wed, 9 Sep 2026 11:43:59 +0000
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a5cd05c78873916b56e19691206f50b780e48801-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4Gil-0000nN-D6
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add client
 PROBE_REPLY parser
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8988004654817025911=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8988004654817025911==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vxVQuHXKDNA="; charset=UTF-8

--vxVQuHXKDNA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
lf_lici has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1745?usp=3Demail )

Change subject: oob: Add client=
 PROBE_REPLY parser
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 13: Code-Review+1


-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1745?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
Gerrit-Change-Nu=
mber: 1745
Gerrit-PatchSet: 13
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
=
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mande=
lbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipak=
ov@gmail=2Ecom>
Gerrit-Comment-Date: Wed, 09 Sep 2026 11:43:59 +0000
Gerrit=
-HasComments: No
Gerrit-Has-Labels: Yes

--vxVQuHXKDNA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +1</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">cha=
nge 1745</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1745 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Comment-Date: Wed, 09 Sep 2026 11:43:59 +0000 </div>
<div style=3D"dis=
play:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerr=
it-Has-Labels: Yes </div>

</body></html>
--vxVQuHXKDNA=--


--===============8988004654817025911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8988004654817025911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8988004654817025911==--

