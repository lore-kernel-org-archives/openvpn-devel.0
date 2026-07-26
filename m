Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBB8C531D0
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 01:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p7VtmwlbM2up4+nS+YGcgqft6PsZatTriR06ZWmR+Jw=; b=BYl4BiaWnCy0vvYRznges75ubk
	8Ce/fEJRozRKMJVUQSk+JCWpIKw+dHw0NEPm9molZ/g/Rf8hXJtQbzS2ywuTSsAJuOszM+CRfmJzN
	ESAWEISXltLLzqx1QGR8TxGIdAvoj/5cS1pQs2D/rZQuuALpQgtITwyP1YnneuUKRMlc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wno5v-0007ky-EO;
	Sun, 26 Jul 2026 01:55:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wno5u-0007kr-C1
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 01:55:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EeFjpQoEo1hKzRdY0QGaBm4aVwS3BoTLfzMW5Ocdg+4=; b=U7AKcxqNfRhHro7tryepgRcL8O
 i5RPNOoiPngkRjHxsBdcWAK0Z/HYxaujga0UQ3karerZNjWoDgbbqzWwpsLAyyTZRerwY2exjYaB9
 xmLIr4KNqqmpeGqjc2rGS76xJbEgOOeMwcIuj3El/RmSIlUo4yo8OYNUw0rqiFen/VNM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EeFjpQoEo1hKzRdY0QGaBm4aVwS3BoTLfzMW5Ocdg+4=; b=e
 i+BdFU1hspYewCR4n6PMYOBl21dPz4ScRezLgPwPOi6HtxZ4DLGHAXWssQwkf1/G1Co5u8OZnjWsT
 IanZHuNYx99N3LB5jxmNZXHxMPsSwPbmvpLyMfYy+SZg8SHzTXUSwEcIBCaKsPpTI10h1YIS47WMN
 VcVYnmd3WyPapNCQ=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wno5u-0008Mz-IZ for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 01:55:55 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so13247005e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 18:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785030948; x=1785635748; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EeFjpQoEo1hKzRdY0QGaBm4aVwS3BoTLfzMW5Ocdg+4=;
 b=C25XjZk5m/tnDXdd0YqPhgsaLb+Dtt9V3ZU/rf0T9fyNv/tYaul6IdjKhvsXQ69OQl
 HipmTDV7/Bgrae/Bx4+2wm1qj0/9FcOjRuVE3eSf2sOgsEIjYJtvIhGY7+BQLPc0ZQYS
 /nn7sTEcvYnMDL37/BH6+1En+g7zcvZE8e4eiSA9NLpnU2c+K2MclQydGQoG5JiHQKq1
 6ihHbuEb0UiKtHFvOXmH3nRqpxnyUvW5htLNGHDc8vNhmt6G08NzQhvn4OUz0CscI2y+
 ZHlebDsP6FEMSlJeKyntUaRPKdFhGNrchjEb/gy6aN16TYMYwO8t1H16nAZr7GL0RpNE
 Va+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785030948; x=1785635748;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EeFjpQoEo1hKzRdY0QGaBm4aVwS3BoTLfzMW5Ocdg+4=;
 b=Og7EDgmDwzWE7BmFQp3MO0r3o9crG6j2NDqrxQjiSYgR0MUXqjWma/ko2j+Gk22wvk
 wzFtC6EKVgV0/s2sgNkNGTkH5uLfWUO80zD4fEJtUSuHgepxMp4PC6JDK1N4xs2lLlq5
 a9AfXRAryDt+z4CRqTbhn6EpNvSVIuEARYSfLoRj7CUW40UzfMc2Ujj7glRuTWMS54bn
 kxr72m206colXzUp0Y3mWfZyjJy+vdC3x8/6Au8ySRG58h4ZgAxNenDhNwP+QyRks90z
 b+2InrR2zk9MN1JaVoXiOjBkkGHZ5h2sdngiOMssuVs+ALQd7fYjEBwANfAHxNJsLcSQ
 gAzw==
X-Gm-Message-State: AOJu0YxiP3Tu7EDxsuxJejgvQPTl/8JmtBpt6ulMvz87j2TcFo+MjsVB
 pr1lnYdSp+kiAc9IRhKDtptjo0Tob6ilmlNevwFjjNxaNEEAuTwUNaetNZR0j7OhfScQX8CU5WG
 F0UAeXXkwlRXivfKE3g6/gmZ8B6qbMA20jtnN+vPxy0316djM8I9eIQzwk9OkBbMLklnyUOjruz
 2V5Z3o/Q==
X-Gm-Gg: AR+sD118M7gPcYlvUZotOMZsMrGtFD+uSKPlRa4ZR79mac4aHImbVFbBmSC+72kKmWA
 n+VA76rteffp7pReHzCaTL1EgR9FNF14g3/rorOqscxtA47r7hjPKiBDhAnqbFugWfmGSR6SdeG
 Uq9aHkDH+52heRd83SDmOBtppZowC22GPBKbGa4MMv7/01jbaNsgf3mUEG7s7mGQGJrq9cZArrY
 s6+LcT1MbuLAIWcFFDEPJ/Prh9Ktf0CvpFicPcZrkcTpMN2HFXA835CJSmTSG1n274Y2cGuYtYu
 hT+1WNBVN+IbuttEbxotwX5b8pmMOkyXhWFk1Wp3XBAQMl0EA1P7zgCq0RPvJjcau4PUIkcDCC3
 yRox8myFdlfuHYxi9fhBx5j1m8C2WQ2Mxiw98KypTWzfNRRWu/kuPBYceGE94ESqejXx9XMldIO
 9q29TRfV+/aYMQpYpPlojXg7qBqlEYu/elkxmy3zc5l0uzrHFHC2wL9C6fug4jYfveUnqtwhD/I
 yCmFtFkCOfHAAcsjn9T9FAVqoAT/bWrdTg5A3QwTBkOHBGqXA6awjJlIRdEDFDpf1iwmXOqaT8e
 +L4=
X-Received: by 2002:a05:600c:1c05:b0:495:607e:5ed6 with SMTP id
 5b1f17b1804b1-496b6a31f1dmr39826925e9.31.1785030948295; 
 Sat, 25 Jul 2026 18:55:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a60asm37899474f8f.3.2026.07.25.18.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 18:55:48 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 01:55:46 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
X-Gerrit-Change-Number: 1770
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1770?usp=email>
X-Gerrit-Commit: ad957fa52d9cd851d8e9f52beb2171a656c43db0
X-Gerrit-Comment-Date: Sun, 26 Jul 2026 01:55:46 +0000
In-Reply-To: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
References: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkk0NTRkNTA0MGNiYWQ0ZDM3M2VlNGY5MGI4ZDY4MzIwMGQyYTRjMGU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <df55b457a6d551acc9223301c60c861f314fbf79-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wno5u-0008Mz-IZ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: client
 handshake shortcut via a server probe
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
Content-Type: multipart/mixed; boundary="===============0717062913165546259=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0717062913165546259==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HJyWm8eTDaY="; charset=UTF-8

--HJyWm8eTDaY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
770?usp=3Demail )

Change subject: oob: client handshake shortcut via a ser=
ver probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 8: Code-Review-1

(3 comments)

Commit Message:

http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1770/comment/8e001067_ef9168f5?usp=3Demail :
PS8,=
 Line 7: oob: client handshake shortcut via a server probe
I don't think ha=
ndshake shortcut is a good name here=2E Because that is not what this is re=
ally this=2E 

We are not short cutting anything here=2E We are doing a nor=
mal server connection with a slightly different packets at the start=2E


F=
ile Changes=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770/comment/=
7acec7dc_b19b4484?usp=3Demail :
PS8, Line 15:     for it=2E This needs no e=
xtra configuration=2E
there is no skipping of a round of three-way handshak=
e=2E The probe packet is just a replacement for the RESET_V3/RESET_V2 packe=
t=2E

This change entry is misleading=2E


File src/openvpn/oob_client=2Ec:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770/comment/a8368f3e_fcf6298a?=
usp=3Demail :
PS8, Line 657:      * immediately before connecting (~0 s gap=
), so that check is a no-op today;
You can probe two server and then both r=
eply and then the you don't connect to both of them instantly=2E And when y=
ou reach the second server there is more than a 0s gap=2E



-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a=
4c0e4
Gerrit-Change-Number: 1770
Gerrit-PatchSet: 8
Gerrit-Owner: stipa <ls=
tipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Sun, 26 Jul =
2026 01:55:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--HJyWm8eTDaY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>Patch set 8:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1770?usp=3Demail">View Change</a></p><p>3 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770/comment/8e00106=
7_ef9168f5?usp=3Demail">Patch Set #8, Line 7:</a> <code style=3D"font-famil=
y:monospace,monospace">oob: client handshake shortcut via a server probe</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">I don&#39;t think handshake shortcut is a good name here=2E Becaus=
e that is not what this is really this=2E </p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">We are not short cutting any=
thing here=2E We are doing a normal server connection with a slightly diffe=
rent packets at the start=2E</p></li></ul></li><li style=3D"margin: 0; padd=
ing: 0;"><p>File Changes=2Erst:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770/comment/7=
acec7dc_b19b4484?usp=3Demail">Patch Set #8, Line 15:</a> <code style=3D"fon=
t-family:monospace,monospace">    for it=2E This needs no extra configurati=
on=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">there is no skipping of a round of three-way handshake=2E =
The probe packet is just a replacement for the RESET_V3/RESET_V2 packet=2E<=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">This change entry is misleading=2E</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/oob_client=2Ec:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1770/comment/a8368f3e_fcf6298a?usp=3Demail">Patch Set #8, Line 657=
:</a> <code style=3D"font-family:monospace,monospace">     * immediately be=
fore connecting (~0 s gap), so that check is a no-op today;</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">You =
can probe two server and then both reply and then the you don&#39;t connect=
 to both of them instantly=2E And when you reach the second server there is=
 more than a 0s gap=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail">change 1770</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I454d5040=
cbad4d373ee4f90b8d683200d2a4c0e4 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1770 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 26=
 Jul 2026 01:55:46 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--HJyWm8eTDaY=--


--===============0717062913165546259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0717062913165546259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0717062913165546259==--

