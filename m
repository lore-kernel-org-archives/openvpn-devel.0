Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735C8CA5FA5
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zkOoUJEycaa6ZQ7InX9rIolq6/6U58oQp2K3PYPW8T0=; b=eKiqs/hUSyVwUHgUaItQHynYSZ
	7bX1wKbltCLXwfh/7gRj+1DaQzr6X1xBdguQ0iK4TC9KO9IgV6pWEvum6HqF+k6MbAo9zDGY0qFr4
	J9k2F2fDznKnEC1IM+CzohAQiP2jVFouJR5APiRpkek1DZuZdBk+4QCML47j7ZGWOTFg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBCjR-0004EL-UH;
	Mon, 28 Sep 2026 14:53:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBCjQ-0004EE-Rg
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:53:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tA8sCYRZ7ZMbw5sfQ1DyKHmDvC6WJlQcuecpZdddOCE=; b=dgwemqga4VeQW5ozPSTSpi4pdj
 2wK5KzjaH/5n+hZZ8XRsnl6sn+48/IuBHtkrcK67Yj7OjRNaEUSALNq7eFOWZ5qnORxfinxKuoG2D
 ErnSaW3M6TRbmZynybc75a09PPsWnaqN5Vpx3QYVH+ILENaLqCDUe9ZwMkZII2huhlbk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tA8sCYRZ7ZMbw5sfQ1DyKHmDvC6WJlQcuecpZdddOCE=; b=f
 ouHaX8I6Vp3Xt5eHD5Takm3cd8DKgT9dom7MlP5f456CBz0TMw8pslpVQdeMKNqOW8Inbadv53GRH
 3ZAXPLsfg7Yr9mz7zK/OJILjSzqwBs5vTYeFPRgub8clCjCwJgxvzl3TDGY9E0BEURwgRq0uteb8z
 Zp/iTA8u/7u3Lz/4=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBCjQ-0004iZ-56 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:53:29 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c3ea1f6so1715381f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790607201; x=1791212001; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tA8sCYRZ7ZMbw5sfQ1DyKHmDvC6WJlQcuecpZdddOCE=;
 b=Mu7mG520v/j+PhJnaa3Mr/opyXb7tCx2ypcMRoONJi0vLuIxFuXWfbNmEKYdGaqSUy
 u+Ju+PL2nmlNzlpm82SFKw4/qSzaNLoxjXt3gK7UhQTG2h9GtKmkXkxNMw6/WTLroeu3
 qd8dy62dIo7jwUjbRfTEPkrau25+phUxHXAwo+46KyuzYPFI1lMHKp7RKrI6coirhfZR
 xvzYfR8RVL1IuqW8C4rW7NoTaVqx83jxOoFZ0YaMXB7jXNwuEL/5NtvsE2pOD1bjOECy
 tPba9bAR5veInEqNCYD5dA0f6BudzA04M+EyJeNffjAm4pbEWQzGWXQ5ol42IBanrt8R
 Ag4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790607201; x=1791212001;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tA8sCYRZ7ZMbw5sfQ1DyKHmDvC6WJlQcuecpZdddOCE=;
 b=EUFnoqIAgN/nXntH3dd+e7JMBrAZw8WTOzgriV2Fxn6vT5190sGTuabXYCSzdZ7ojE
 nBWpUzfZcayiwj40iOZDLwsgamQULUcWpgeDTjeSp26q5k8OM15XDs1icTOqBUXknzFG
 2Ooz1/z75xRJtek5bha+3xQyD13YgFV+IaX8F6rCUAVd1iDjTzK53aj3seXpFI6qz9Cd
 q1DW2gOCPz5wnFyai2SrKbxKktxL5PbGWbrK5L5LScUhj061b2jh5DIQ18ktou3dSt73
 yAWK6pG6OthX3Wv0giY7LiTNQn7c+viQJGOfdd8rVa8QG99KxaBHu8qdToRxKebRZeky
 tIMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByiepqgH16BKhvrsATN1YKoOkFKAq64/Q9IMgeKOoaDvABUJowcu9apWV1tRYluTmQnawnU3kbZIaBFU9QT@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIt6hLSxzaQo/GnU81Dc5GP+o7ueHI3Jrg+CrLisX2eu85AvPFX
 M8/JAVfIZF35HQB4UHZCN0EaF6O0ahEDXfv8vz2xaZn7NhQFSHFXvRUMrr6567/nwa0lb5oiEs2
 3MSTpay/zWu+KYQdLiD8NJFkC1fFkTLRzHwiGfdQuRdhUATwbiFLaRVX+EzBQDbPbAwVy
X-Gm-Gg: AYBFou3/IBgJf0MVhhB/jfS8hhIndQb5qM2B78rirGl9Me0O7JrI5qM6WJBBsb+Hvcx
 PynOsr1zLx3xzZrTUwuRq+nWiGzfA8ASQ1re69IHC7beKpD9cc7hdJUwdajRTY+lWWSr1jmnuC0
 CnaxpXqFMOS3Ky11X4OKRkDPwv477rZsu0tL3a1PWsdFd16onp1hyicCVfKi4ER+/nV1a9X4vnv
 64lO0EavHPljo4YbzE8xah9S2aywns48oVV/w8SbgK6u99n32Hoic1KIL3CQzxmZ0IrcvZXvBpP
 cjyZ+z/9/FoGNt7i9F7wNOVXeCrEzUDWzL0x2zaMvsrew3HwsaCQpvazgonV5W/Dc3Qr7zrPfoR
 mmRdKkpKIowVTNLujcHlFp8lho5Wcbe62H36LXpI8ffrRNY12/WRy7fU3zyt7iChbq22IekCvDT
 xMa/Yrjk5lLJo5w60OeVlbRbcC/LHyM/dVijqjkRlAfCaxM9Nx5WNioE1ln1zpuoTvGubccrAKV
 ZfvpDMmicTiZ+GBkgC3GfreNTBtv0JhTAGDAjXiDxnC6rjMNX5PoTr4HZtLP5qIrOo0KssfHzC1
 ryEQ7JDs9ZZ7Etdp73ghtOBjhiT4hyihkQhNIS8XY1Izx0MNZa6Z+U30SW+V5Q==
X-Received: by 2002:a05:6000:2482:b0:488:7ec1:a6c6 with SMTP id
 ffacd0b85a97d-4887ec1a942mr19710136f8f.4.1790607201461; 
 Mon, 28 Sep 2026 07:53:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35607bsm25812241f8f.16.2026.09.28.07.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:53:19 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 14:53:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
X-Gerrit-Change-Number: 1955
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1955?usp=email>
X-Gerrit-Commit: 7f48516ea1d96c7a8545cbdb1292def401ac411e
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 14:53:17 +0000
In-Reply-To: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
References: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNTk5NjY4MDAwLkk0NGQ3MTcxYzdlNGY4NDk3YmY4YjkwMjM4MGRmOTJhNThiZjhhNzlhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7791ed932815172134b90f7eca10d271342eba6c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBCjQ-0004iZ-56
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Build against
 Windows 10 API and remove some backwards compatility code
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1153337087448005856=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1153337087448005856==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VvacIOQ1EBM="; charset=UTF-8

--VvacIOQ1EBM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1955?usp=3Demail )

Change subject: Build against Windows 10 A=
PI and remove some backwards compatility code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Commit Messa=
ge:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955/comment/9ec55521_a40656=
70?usp=3Demail :
PS2, Line 13: versions anymore, so let's also remove that=
=2E
> And I forgot to include the link=2E=2E=2E [=E2=80=A6]
Agreed that thi=
s is not relevant as long as we do make the change 2=2E8-only=2E



-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df=
92a58bf8a79a
Gerrit-Change-Number: 1955
Gerrit-PatchSet: 2
Gerrit-Owner: fl=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 28 Sep 2=
026 14:53:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In=
-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--VvacIOQ1EBM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld has posted comments=
 on this change by flichtenheld=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1955?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955/comment/9ec55521_a=
4065670?usp=3Demail">Patch Set #2, Line 13:</a> <code style=3D"font-family:=
monospace,monospace">versions anymore, so let&#39;s also remove that=2E</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">And I forgot to include the link=2E=2E=2E [=E2=80=A6]</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Agreed that this is not relevant as long as we do make the c=
hange 2=2E8-only=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">change 1955</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I44d7171c7=
e4f8497bf8b902380df92a58bf8a79a </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1955 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 =
</div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Mon, 28 Sep 2026 14:53:17 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--VvacIOQ1EBM=--


--===============1153337087448005856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1153337087448005856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1153337087448005856==--

