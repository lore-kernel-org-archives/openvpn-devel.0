Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739B9CD8CA4
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TxYDfI2OUowDVQyGA3ZKZVBFBE32NCPbEUl4mXQ0PAo=; b=XLnmPPxc5uIZB0ZVrC13C8lSv1
	Og1vCVrlSTUiLOmMxZ8gznz+zLiWBJKUuR71DEWQ+Ya7taWyDmaV3oGyLgtGDoDlE06zf1XEOct13
	Uw/fLda33p+BhgcL56LKOTaBZFoHmwn/Qn0KAopyHrLkumEFKrkpm8fB8CM/E+M0mIP0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxHn-0004xx-43;
	Tue, 09 Jun 2026 14:18:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxHl-0004xr-ED
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:18:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6WA2UkcsoQIkXs9zQeZVuyP2J5oBlRQJpStissNDs8g=; b=GyVjX5MJN1/xdLzJ/0KI1J4q7j
 U4QL8G5pYPE00aG7/t3SQdKMZZLJ5cDAb3w9SloT8Gd6zdmrsp0BzUOkWv2WVLt1SPJYzlsKMgWXk
 Uv2j9JZK1J5SjHdAQu+wNVkV3tMgvuPy+a+MmMTqN98atC+gsxZ1p/VVJP0VVbDQcLKU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6WA2UkcsoQIkXs9zQeZVuyP2J5oBlRQJpStissNDs8g=; b=e
 9ytlUxemiyEMJ7xsRjb5dYI8SuJJn2PM36XnaER1IjHEJvueFmvZcDX9RYjnY3IkFVogexunTeFy1
 eTNHZkpbqPF9oCFN3FxhGgTDGArvRR0zytgB2PVKZx7hDCzKDLm6ujF1hvHEBlTWEiuFJ4IzmefzZ
 kZ28yGjWuNsMRwpw=;
Received: from mail-lj1-f171.google.com ([209.85.208.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxHf-0000pu-Ur for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:18:32 +0000
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-3967724bed1so60353741fa.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781014697; x=1781619497; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6WA2UkcsoQIkXs9zQeZVuyP2J5oBlRQJpStissNDs8g=;
 b=FtrxIVadZ0B1HSaMjwKaxWGammivYJgB+/YXHrgGYGpgv02me0AFlNrYWWOhpjoapR
 E0z7DbQ4p6QXVIW5L+FHvyEQoq6h5RYU/k5K5L5CnTVWT5O32HolovFGmhQQJcaFO+nl
 uDf5y366YKpyQdGe+BQy4dESYAItYFD2iCug9BRKbqnvaH1pWSQcJ3q7BgZYmT4WvETi
 DnLAenSRhb/LSm4idWeSBOBQuDdVLbHwK3gvTDHHILkbSTby3YdLx7gJng+WzIIASLn5
 csM89fOHWmbxUducHi0kGRj+91OrOeIERMbweryTa0lnN4gyFSuFY+6fr18FoNP71SEm
 yW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781014697; x=1781619497;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6WA2UkcsoQIkXs9zQeZVuyP2J5oBlRQJpStissNDs8g=;
 b=RGjBqnqYUGbm7CQpjZf9LjyG114UXu6l39HvfleLtlna+VUGgJv1jSTR2p+a6npOwl
 5jsknKNiKPyZdUZ4X6gEL10+l2PJV7s/SiaRnvXI7Ds3hWxD0TkRnttu3yM8zYoCzdol
 5ZEs8Ppa+fkoyF7YX2sqfCxkFZ9/3vST6mAHTz/4zXlmUT2ZLKWYP9CGO8HKerRnkpRG
 zY5Me+c6XWY9k7H++/5qbohugOQfM+MYHxqm3BS5divxfXd9WkOasG97udWtoGJjWG+G
 QB1FP7vjZH4mIhV/rI81PqcQiBibQqP/X1X8tiaWHgagaXnB+QBFUQy5z28WiONvzvmH
 063g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OyDVD0uC78vwXJ4hReCl+rxikwfc5egLj6IyitvXxYWQhAhz/zJpsG62JyV2askEukynHDMDXJ/fcTXao@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxL/XIBCC7vXK3EMvh4kPT/9eq8X5ccoET+AxcQ8/Tnry7RTwZ/
 89Oo/FnJ4pHOelWem3QM6kYgVA7JT9Kg/RiL2eQBo6QM9TOchlfiQCA7Rs/aKrzzKdMQ+Zg5GZ4
 sOs4a4CSETnrjyPQ2nFtScn4YJ1/PilBcSIx4kO4Aw/HeayoOuavwQ+K6Bc1jSZzxM8k2HGmrQ9
 2q5VfxVQ==
X-Gm-Gg: Acq92OGpW7Db2k+myqAhz9URS1tpPfZmsAl0SNqNegNynMwODFLgIq39fL9T5HMIwLS
 z5zsE+LMUYi41aQ8Qm+0AO6wH/xILq2PWZpsbfPuDo5U4TxtqVhf0PJWjVvwL4vwBv9m/MkV55J
 8b1bgIMvo7w5q44cMRqPj0xYSgXvhkwqDZMYv6lt6ROzajE6w3AvDZlDmVe3SwFN2b9zL3E9hOz
 EsmvpSp68dscBIzLFo0TpPvIkJ8JVnBHeWjR30rRIPA6qZ/VC/4TBt2w7r0wehpP5uVJK8Cn9C1
 N52MhGih0Bwhm5XRSvjlSiqY07+5u+95liDVxUY87GtV1g4oYqZcGSClq9S0Cqgn0j/mFHXcHrD
 DxZPMhic0jQE2LF/LHSpfXAyEeQYCUheo2XXRsC4pRTlgQWj7KnkRp+DgqE8E83wcmMAWbHoOLk
 d+s9VLq4Ambfs4Hej/TiRwW5mCusO1bjEjET1XCA39J4uL7360E/nwLCf2EAWfvE5uYjLdbB9uQ
 DgEdpJKln1B5Q/T4NkF5k8+Bw8afAL+wbr1929FDHSntLhdxTj3FbKNookP+fAteq3STsI1L3Ip
 pvw5x6IH4JXRRG2ViTGSMWlg
X-Received: by 2002:a05:600c:83c6:b0:490:6e12:542d with SMTP id
 5b1f17b1804b1-490c25fc0e1mr345348495e9.19.1781007628433; 
 Tue, 09 Jun 2026 05:20:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bda4fd52sm465895365e9.0.2026.06.09.05.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:20:27 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 12:20:26 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 945fac1b51d7eba143abca65da6f8ccacd12c3be
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 12:20:26 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1599483cd4271539b85d08341fba05477c9035bb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxHf-0000pu-Ur
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
Reply-To: arne-openvpn@rfc2549.org, gianmarco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8432358295568824810=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8432358295568824810==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tOM78tBiXaY="; charset=UTF-8

--tOM78tBiXaY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan=2E

plaisthos=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introdu=
ce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 12: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Chang=
e-Number: 1089
Gerrit-PatchSet: 12
Gerrit-Owner: its_Giaan <gianmarco@mande=
lbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewe=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerr=
it-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: T=
ue, 09 Jun 2026 12:20:26 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Ye=
s

--tOM78tBiXaY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan=2E </p>
<p>Patch set 12:<span=
 style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding=
: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change</a></=
p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">change 108=
9</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a1=
3ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gian=
marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Tue, 09 Jun 2026 12:20:26 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--tOM78tBiXaY=--


--===============8432358295568824810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8432358295568824810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8432358295568824810==--

