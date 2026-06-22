Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D83CD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CBanSJ0LiaBGQpn5HLWWbUSpG8XmP39t+tIbJJ71RBo=; b=E8S34kSCgWZjBms3YzP9uLT+lG
	NqflXuhA0PGlEsFG4tzB39PBjuMFnJphYLDkq8JGk6ZToQbzgXo/HOLrKOLzqyS6q8Sgcx3zDAoSx
	LALSvJvtA7ZCtscBHB/2p6Kcs+3TjyJfAR/HPxJLjacfGa/GAtXBjj6bS1cBEj8ceEj4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgfq-0003Cn-KX;
	Mon, 22 Jun 2026 15:34:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgfZ-0003BO-2l
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:34:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2sZ3RTnO4dRXYaeVnkfETUpaUar+9EHTto00kUWtZTo=; b=DQvK1xgcJmtcspPlTR33IAmxnI
 jP9/g5pEB2JsAPR+sJraVMQNZSP8ld8FWtk3CdBc9emUOW0MoTjBNOUrWWtJCq5Xqdl8GGFg3gR7Z
 7druVCDG853yZYvRrpPEQVCrW+6c9oLCR3BBhNYGAdLUCTKzUHrjrub2o0JwCpdyaduc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2sZ3RTnO4dRXYaeVnkfETUpaUar+9EHTto00kUWtZTo=; b=L
 wjFntiZ49ea27zCIVef7oKiT2SYJkHcQGe/tszD8jXDrcR6zo3hcTwpmaHH2NGLLD/sQ6ya1qnJ3B
 9Qi8f5AK7de490W3Om1cSHMycvpsj/i+kHnx92y2z7Sk6mMD9aCc47gCP2S2CFbU9JmBnZCjh7zKF
 rqhqY4HcvBlD8NJs=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgfW-0007yc-Oe for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:34:41 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490b3637b90so35423985e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782142468; x=1782747268; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2sZ3RTnO4dRXYaeVnkfETUpaUar+9EHTto00kUWtZTo=;
 b=cefNB9HhQROvF4OFJeaVJ2xZVKvZXBPnQ3+TjDE+uHQSG5irHvQ3bkyw0nUqZet19a
 UY6O4uzBPRW1DTli6viRpdl5XsDGqCaclGXOwnTL8Q+ygbAL6WRlxKvKnMM0ytOG+etT
 /qSX+eLP2vPKf/c9fViJUbuWlQuoFCzccygI6X4RZ86f5/ka9/6ac68656+WJJBdz5I9
 qFlfzUE64eIrjbgvBhX8k9Fjb2f/GpjtehTlZSI72AtzQBnvBUHG4m7QR1dKtj0MVQKi
 U28NFC0uNUHLj1F86J3VQZRWymdHgXDPa0WGTGtgo5MNrZsUFnkGp10RkZecCdXUNLYW
 2nCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142468; x=1782747268;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2sZ3RTnO4dRXYaeVnkfETUpaUar+9EHTto00kUWtZTo=;
 b=HKshWOaUZYoeGy78nnBVSUZG9rgs3azGrPDiK1aF9C4GmDtMHy00EgEbuLJevUjfux
 Dg+tOAzARjSOmzEs5zvDG1gNE9npSfrxztRjWdTuXOKcBrcniIrff9SqFkj1Zf/1Ex/b
 WpSWIa1DTqnltjig4nk1TKFjzbGFM/xlnmU/Jp/O8hRiD9jJ+Rj3DgCNS/pLdnbvrItL
 842OS6V1sqB5c39uq1RqZqOOj3roobMc31Qr6n0bOpHtqyjgcL2dmqC3fH0Zr1o7/jM0
 Gc1dkG+6XqRrWr6AWsGh6y5/drWReGSlrBHlWjDXzedDndCf5nonpwWtd94LRpRd8gLW
 y8SQ==
X-Gm-Message-State: AOJu0YyACPWCRZy4VNlkI8sHM6P80h/jlBA/FgbvrN7bP6i17lR2iBNl
 llwMofGEk/suTUr6lUYaBWlJGDmJmcrfNewaiblGul9TCOnIOd8EqaMUcMbUCn2BA8Yd1tEiuLR
 QKVYhk1z+5A7cERgK66J1aq2XiMUsVBaJAadb3nubDw3nChNJr4CKP59Rcvtve545JMoo
X-Gm-Gg: AfdE7cn6pyVsihOZusGYpmJjuuxqyQas5WwxOZ5jtf5WRo4UUQlXhqIqMGThoKKV1sP
 eBHhdeIpvyPkRZFguIv7NVRygOvzgXjvV/CJTo9mdN3qiSFbX7adiA/azkGl914R5MmEHSJHvwh
 OZAUF70w0Fd2xV77xoHWTVSmd4PtH9R8Pe0ftySRTEWw9w1b7aKG0tzoGcLi4yFCEdUy7KkaDLD
 O9Tm06GYNxSq/EvveH8g+9ZMD0KRLP9MpdtNbn4jfV4a7ixK90xUBSuJZ4CsdKiZVGGF/nNeaDs
 j8QR6sTeQ2dc6L7jDn2utxtkR28j/57yPigV6ezJe/PBkorkWmPpT+kE2a6Wn2jYY4gmqMjf1Dq
 qaGWPVbEcZyOSIBtRRxh2MDONcaLNeLvH7Jl7U7lC8z3GJ/vTF2zDCFA9WrBR40X1dkheg/OTo6
 jIDwgq/rVdr5b02Qn9DDSThSlpKhH9douonPEpSDJbHS2myUh5nDjU6W+K/LYOBCaUfYduD7KsX
 ldAMfjXapkDhBHnu3gSpYi+6rCH4udlbqDK02Gb8esFvLo19UShN5dz9yYr3GENfSdovRrzWiEn
 Qp4=
X-Received: by 2002:a7b:cc98:0:b0:490:9d1b:f086 with SMTP id
 5b1f17b1804b1-4923f33c6d2mr151367785e9.14.1782142466467; 
 Mon, 22 Jun 2026 08:34:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240eef2basm324195065e9.2.2026.06.22.08.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:34:26 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:34:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 2d8cf123844fdee5854b3d0fe82abd0747dc3662
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 15:34:24 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <25dea37f7818ae010e71e15b0d0d05a69ed2a956-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgfW-0007yc-Oe
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3069985013247289074=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3069985013247289074==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OTbg7CMG9VE="; charset=UTF-8

--OTbg7CMG9VE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1571?usp=3Demail )

Change subject: Change hash iv to a dynamical=
ly allocated ctx
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 6: Code-Review-1

(2 comments)

File src/openvpn/list=2Eh:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/93d3f73b_2fadf384?u=
sp=3Demail :
PS5, Line 106: void *hash_func_new_ctx(void);
please provide d=
ocumentation for new functions


File src/openvpn/multi=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/9a502f44_82e37234?usp=3Demail :
P=
S5, Line 313:         hash_init(t->options=2Ereal_hash_size, NULL, free, in=
t_hash_function, int_compare_function);
why NULL here and not hash_func_new=
_ctx ?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If47c7d920b2=
fa4047b7db03fcde821899839324d
Gerrit-Change-Number: 1571
Gerrit-PatchSet: 6=

Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Comment-Date: Mon, 22 Jun 2026 15:34:24 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: Yes

--OTbg7CMG9VE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 6:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/list=2Eh:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/=
comment/93d3f73b_2fadf384?usp=3Demail">Patch Set #5, Line 106:</a> <code st=
yle=3D"font-family:monospace,monospace">void *hash_func_new_ctx(void);</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">please provide documentation for new functions</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1571/comment/9a502f44_82e37234?usp=3Demail">Patch Set #5=
, Line 313:</a> <code style=3D"font-family:monospace,monospace">        has=
h_init(t-&gt;options=2Ereal_hash_size, NULL, free, int_hash_function, int_c=
ompare_function);</code></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">why NULL here and not hash_func_new_ctx ?</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1571?usp=3Demail">change 1571</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde8218998=
39324d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1571 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 22 Jun 2026 =
15:34:24 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body><=
/html>
--OTbg7CMG9VE=--


--===============3069985013247289074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3069985013247289074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3069985013247289074==--

