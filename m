Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98FBCD8C9D
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uwS4Ic7DRAylODCYcAzsq/e61pn/UoYFzUvlLdR2/FY=; b=J5kyctSwVvqvH3j/SMBIjzelsR
	y52QpsuOomDhZX+nEppXAtu0kxlBe31r7GwOM+oBeoDn2aa1zVli0VFwnO/pMoPqGjyfNXIMgh1VN
	lTSCuQ6QRcGItVfrTyXpFcnGxUWlDkGU+iikqo2gAj4LnXEsS7uWgazyLMXQGl8aGKXA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWZCa-0002CZ-Ok;
	Mon, 08 Jun 2026 12:35:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWZCY-0002CR-HT
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 12:35:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pH+ueVXpBi1hOe2SJw3C4Amfs63LFrcqnFn4JCTD3vE=; b=en4RnrGvcpvXUlaZ2oqBavjiy2
 N68rt7W/6u6YUfX3+mM72MRmOKfyjL/83K+fsS/pZgXrtbvXgXvghkq26AvyOb1doKH/4/oSzzVd7
 P+6IJRzgoWZTNYW0c2rKyKZIdfFSGSVvXTaphixwXUIihCtbar6bxrJCkCQgd2vpBlbE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pH+ueVXpBi1hOe2SJw3C4Amfs63LFrcqnFn4JCTD3vE=; b=k
 Ou9GCXJYQs5uf7jyMlXcfjutU566VdHXxlqsxRTgVHIL4Sq/JRcCW0UhLfe66yx4uwp1/Fub+lXrm
 LLENUX18lMFOuI6r1bTNlNR22/JUEKeT+dp6IoZo1SjzurInR2NFdYk2LzrCrGULvGzrHJLsKqOW0
 WEpf03d2kBAEmtQ4=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWZCW-0007A0-3n for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 12:35:33 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490b12270b3so25465905e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 08 Jun 2026 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780922121; x=1781526921; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pH+ueVXpBi1hOe2SJw3C4Amfs63LFrcqnFn4JCTD3vE=;
 b=Ja6bewI3GEfJhy7pSSJ4GwGaOHOqNNIrHeZNleipHDOWCTPwoeUTJXo+VeRvVgqhjA
 znsqnynLILRUyvVs055Ru31nDg7hrhsIJAj5srkFGrw7Lmmcima7C+zKA7+OCuKJlCZF
 wanFvCD9J6nDlSu8O8YzdzPiggsxqPKo3Rosf0DbdmhVdDmCBEfZF0i7t8BUhLrnEkFc
 Vw0N2knd+M9YboqiAhFAQw6DQYRYrxSoRbAJR2VfiqZYh4Gl8L+Feh4Tt5WfCjuHUAHa
 UcfeTgQye/7RY2Nq5yaw0RinuT5hR2gRK2CSe0Xyl2eVV+grlG1rKON73i0QgAnsrGpS
 sHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780922121; x=1781526921;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pH+ueVXpBi1hOe2SJw3C4Amfs63LFrcqnFn4JCTD3vE=;
 b=HMRZRq+OSp7O4g9Evfqn+capzG9JA9WkFDRTpy/wWtIxWlJNZJF17aZgumOP6QWnt6
 Z9VLBpnGerzjvnv/0PMgPkKhS1vHiL/L4T64UwAywi0kGB+Hc/XMygmYK0D8Ecg5Udtv
 3Nb3AT55dP49TPGSJ/doukW9spl0wrD9tsxLTkJCL1aSW5w8Rrp+xXHjjbK2je4BP3Pa
 +dv9fXejKreO6vlo6ZHNQYmAY3WOAdzZEp/8LW8VJiQQQAzz4NomKX09kRGwR2aAyJO1
 0S17sE1L+mJneePpvb5dmwUIRQgzjPAagoejmm1d4s4TUnbAa9rZwyf2ukVyK4cmt5QR
 3Kew==
X-Forwarded-Encrypted: i=1;
 AFNElJ9eCjN1ktewUTC5bM9Nt2/+CcO6tWqJ9ARVANT184X6bl3YIHD/sVsKopwAee3pYqs4/uXO1WQYaPsxf4o6@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyq2IRuS+tzn5ExydcMpDOee3ZT5CHXx/h4Fe1Ni3saGs+1UDaF
 /KlN/9A8CQ+bQFfsLlPm8P39gsjZv8hIVXdWbYaFEuDgUea120EFOJr1EysTI6LfaNmeiJsXQL7
 DW9ph+1UKKbpnbenMSLRafalzQZ7Hmno05pt1Ew51mvi3W2+gBRGrwF+NnWgFmL6Rxx4F/kxxNn
 ILM/ps3w==
X-Gm-Gg: Acq92OFqa9zviQR5oTfAeLWMzKuhgGJm+VNAeijZrcSf6VqQ5WlcytaMb0lK7fXPsJN
 D2NmTIlUPgGQLXHHy+C4EzZMWj4JXIaL+Be3mWua1ciq77AqgnoKp2P0mpj0/QN955MDOQJZ14f
 QYPMwVFRdjcYUdyWHOOBEaoxaiZDIwjtG/8n4u+YZxoXK4vI7XMTfoJELQ0zUkL0kVsbYiwiFlq
 EKPKpyXhEb7vWfZR2pFaO0m9iYtqSYzgEVQ0l8IdsptI4UgtRGBpuO7U1PGJy/jZAfD/vAz/oLd
 ZsHFUF1ymdDLGQeKwrsXIckIsgIv6X4E0e5aJsqrYBRnXj9DtGfiKJHnC5Df6JLKPITElM2Esc+
 XbKmay4B/TwIL8rh1h0/byK9brMnDu9xoP/BE7bWwYP+iDTBDgF9Yu4/pzG9qU7WJd4qkbNT4g0
 La3AftLnb8/otD1q+eTQBdOqzt225vraSXsWS/K+w/APX2I9A1iu+fcMaJ3eBB6NhR2ORnfHen+
 /esczHjtazOl6BZJm30IL6lJtmOYMzM6981N8Jth3kXEv/eW4Cys07t8mxx6Aayqhac4/3YXNIQ
 3Z07GBypex86OzSNwWUEfNHcWBK26P280uQ=
X-Received: by 2002:a05:600c:3553:b0:490:601f:d776 with SMTP id
 5b1f17b1804b1-490c25afademr239206765e9.3.1780922120936; 
 Mon, 08 Jun 2026 05:35:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3fd663sm450261785e9.10.2026.06.08.05.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 05:35:20 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 8 Jun 2026 12:35:18 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
X-Gerrit-Change-Number: 1635
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1635?usp=email>
X-Gerrit-Commit: ba94f49bf8492ba5a9b6a8442181f233d5917d25
X-Gerrit-Comment-Date: Mon, 8 Jun 2026 12:35:18 +0000
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzgzMTAwMDAwLkk2YjMwMzgwNWEzNjg4YjZmNjM2MzE0MGM3Njg1M2E1OGJhZGVjZDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <76de2f1f2c338d332f04e2b2932127fa58922df2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWZCW-0007A0-3n
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Multisocket: use
 event engine rwflags for UDP I/O
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0514917491574722335=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0514917491574722335==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Es6ONKdHrvk="; charset=UTF-8

--Es6ONKdHrvk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, its_Giaan, plaisthos=2E

ordex=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1635?usp=3Demail )

Change subject: Multisocket: use e=
vent engine rwflags for UDP I/O
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

File src/openvpn/multi_io=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635/comment/309711da_b4aa=
2afc?usp=3Demail :
PS4, Line 180:                 unsigned int flags =3D
no=
t sure why we need to go to a new line here=2E



-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
Gerri=
t-Change-Number: 1635
Gerrit-PatchSet: 4
Gerrit-Owner: its_Giaan <gianmarco=
@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: cron2=
 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Mon, 08 Jun 2026 12:35:18 +=
0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--Es6ONKdHrvk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, its_Giaan, plaisthos=2E </p>
<p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/multi_io=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1635/comment/309711da_b4aa2afc?usp=3Demail">Patch Set #4, Line =
180:</a> <code style=3D"font-family:monospace,monospace">                un=
signed int flags =3D</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">not sure why we need to go to a new line he=
re=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1635?usp=3Demail">change 1635</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b303805a3688b6f63631=
40c76853a58badecd8f </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1635 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div =
style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@=
greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 08 =
Jun 2026 12:35:18 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComme=
nts: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

=
</body></html>
--Es6ONKdHrvk=--


--===============0514917491574722335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0514917491574722335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0514917491574722335==--

