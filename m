Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4924DCA5FF0
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e0uRtPRRaLkC7BU2uTlSOg1K+yq29gpQd9kcOoiaX80=; b=Pn/Y9SSbB0JkOMP2MmDkClRqQ2
	ddsfErGLEgKYonSeiFiUXgcCBXA6Ja8ovMWuM3oQbyEau61DfqA2yFtoVCczTvGHwYK/8xcTs/T/S
	hCHZblugWqJ8UgjR2c64ovAU1orCq1lylnj0CGI8alE362o12KX/PPx4uLaO0R9Xb7u0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDl8h-0005GQ-6C;
	Mon, 05 Oct 2026 16:02:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDl8f-0005GH-GB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 16:02:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=IUI6D0hQPR97k5fQ4Kv3tJ3e2g/7Ylbzoz30NiFpXCc=; b=BP7250DkXDTFzN7dJNgS6WbA20
 KjYvi4U8cLThnXms3Br5oqXnihWA0cmMKgrAwexsYTeOnPSLHhgAKO2G04uxpY4NlNYIRon9C7mXR
 OrUvkk44at8mpGdDON+u366gSImYDOnPixWbBKdp3QuolVQzzRvmAKrXWIKF2+xXWS4U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IUI6D0hQPR97k5fQ4Kv3tJ3e2g/7Ylbzoz30NiFpXCc=; b=G
 Jo0np90wH2y+TWO/GoZqeCxOUFsQEa6p3tsq2CgqanYqOZEcBAisFqlbVy9uhfpKwjP/ZQkFtpkBN
 aRTJmeqQuwjdDCA6Lu3NYBkBegl4aUjgr9M8PBl9C5cTbhL5OJnJ1P3hticLp9OVRsKwTGM+eMiU/
 8fux8aPJlzvG7NLQ=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDl8Y-0003PV-Jw for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 16:02:02 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48b01c4f4daso1572048f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 09:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791216112; x=1791820912; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IUI6D0hQPR97k5fQ4Kv3tJ3e2g/7Ylbzoz30NiFpXCc=;
 b=clnZYDbJ4BKuQpmej6eBmFuVJUt6Nt65HgbmZ2pvECZ3AhL6eGZN99krv4yLCKeuh2
 L3TVtNLcIQkYgrtC0m9VClN5++2BYcMUdqrE8DxCa1cDkQ0q9WJVXrWg2XqFatL8/eKI
 frCBdDS1By3P11bQaew4/LwpmqBqME13SsDfOABEkILmucg+Y6fSKGQRFhoxvlJYaaEq
 HFt/G8VH7L22BMxlJx+Z3Gs/XGkRP1MVX6LVvlJYkLDsetPaxFyG5scJocDLDVQPe1vz
 iKkjD5vF4EVvsRHUbAIYidkR4GkBPFHXikC8xzrV6ngXYVbHPpWFCd2DDFR7GiqTuAAu
 +erA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791216112; x=1791820912;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IUI6D0hQPR97k5fQ4Kv3tJ3e2g/7Ylbzoz30NiFpXCc=;
 b=2W5/nYlNMIZXWGKZskrWJvr2L0UqNBFYccbngMJ8nilihi6vZQaEAXZzoNxYdO8o06
 T9J2KyrJs+nYVhxtKwemXp1K03qGXWSv7rz2ygDLO2IxlOMWColbUxaiDliDuY16q/UZ
 bv68EbG8mpBLg0siBVxhZQL711dfsbMIkW3ln9RkMtcsSuK71B2WH9THuQF18kiF0Djv
 MASyXQOoQMEkI7WWGePJcgerUvr2J9EKGkag4FrZHsmSt1knh6ez1ZjLtugi5CBmEDmK
 E9v2KqzoROYZWmjZRKUorJ4n8AwQkOPEqv60xMVSzf/CbVqudOM/u/s/U8Yrm/y0vfZk
 gCqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByju1T9cffvcdoitIPi6MVkzrR92NomlrY2jOQyqC8qrxYBfG7Bd5YwPgB/A5BIhZmVA08VSl93SNtpT5C+@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIEKyB/7WsjfcsT1IQvL50Bx0M7SObqeU4PQVB6f9vQixXqjsI9
 zqVv2dy91QcB3XTOpYIMu98eSBMnF0fVVdrVJ84+GokP6d+gvkf8G1UQLpZhAc0620HoEfnjDWj
 fE73ICHekb4AGH4sENdVAmhQ0w225X1sX46mMdCtr1GtPOO5p1SbQUPbJf2AgeRS66Ve5
X-Gm-Gg: AYBFou3l3Yw+Fg19tG/aGqFRyhUjtlvdWejxsPiA6JspIiZMUKGruwne3G1us2PtlDm
 NwP0Y/L4z2fkdKKJIjHg6aXyYznusKiPeO1YXzry/nxN7yqmiMaxJongM9bhTNP+/5jSXzd7eTR
 IfoLihESWSBHEPSZGUJtukc8X3D4fXQFpZKrYthC5MN52s+rwbNe27DPi711Jd1DsFewqwpRc3u
 OE8aEIBfz4QGIXQeIQxQO/QlmCCjlG3apRe/Bu8TwQrTMQGK5vHVcJGKCJxRdX4oBF3rW9hdY6A
 xoJ8MTOxQS8LOcBaom4G9uUxTMdV4see7hw9lpjmr3T2KCEiz8Nyi2bT3awZ+Os850WcvPbmWNK
 +qykz0RkzZfGE6ryOrbis3frBbeHMW1zZUX3h/jxvxEk6Q0FAEonli8QucwbKl9Z+n7CPpowiXM
 7sjafGR5K++e2tFp+u+ynNhZPbkKtSB0YCosEkOi0sI9Fw57ohj/RbBqW/DXTVnOse31eO9BRhU
 T33M+R97hAR6xJcbs4U7PIdjB8XrB6sM0U8Czsua6gA9UDno8jd4gHD6rVV2RV76AfhzNQH6zR8
 vJw2QtkHqcBOgmuchMUQjodDPVr5PFDfAi1aRKM3N8coBFQZA1p68sj5ar+a
X-Received: by 2002:a05:6000:40c8:b0:48c:5785:9b77 with SMTP id
 ffacd0b85a97d-48c5785a1e1mr8188741f8f.27.1791216111833; 
 Mon, 05 Oct 2026 09:01:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6229291fsm4697606f8f.27.2026.10.05.09.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 09:01:51 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 16:01:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 178afa9fc7b5a7b499297aa6361beb423d4e845b
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 16:01:49 +0000
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <031a8956a0803f5caf96433458f950b467f2a225-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDl8Y-0003PV-Jw
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0431136215153092712=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0431136215153092712==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="W0duSFGJtN8="; charset=UTF-8

--W0duSFGJtN8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Arne Schwabe ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1852?usp=3Demail )

Change subject: Add unix-script f=
unctionality to the --management feature
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 10:

(2 comments)

File doc/man-sec=
tions/management-options=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1852/comment/54f4e871_c0a990a9?usp=3Demail :
PS8, Line 142:   this option =
is not needed since a disconnect  will always generate a
> Additional space=
 after "disconnect"
Done


File src/openvpn/manage=2Ec:

https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1852/comment/4e9d3bac_c9a37a67?usp=3Demail :
PS8, =
Line 2662:             snprintf(ms->up=2Epassword, sizeof(ms->up=2Epassword=
),
> Don't we also need to generate an username?
There is no username in th=
e management authentication=2E The commit also updates management-notes=2Et=
xt to properly document this=2E



-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1852?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
Gerrit-Change-Numb=
er: 1852
Gerrit-PatchSet: 10
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 05 Oct 2026 =
16:01:49 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Rep=
ly-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--W0duSFGJtN8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Change</a></p><p>2 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File doc/man-sections/management-options=2Erst:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1852/comment/54f4e871_c0a990a9?usp=3Demail">Patch Set =
#8, Line 142:</a> <code style=3D"font-family:monospace,monospace">  this op=
tion is not needed since a disconnect  will always generate a</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">Additional space after &quot;disconnect&quot;</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvp=
n/manage=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/4e9d3bac_c9a37a67?=
usp=3Demail">Patch Set #8, Line 2662:</a> <code style=3D"font-family:monosp=
ace,monospace">            snprintf(ms-&gt;up=2Epassword, sizeof(ms-&gt;up=
=2Epassword),</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">Don&#39;t we also need to generate an u=
sername?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">There is no username in the management authentica=
tion=2E The commit also updates management-notes=2Etxt to properly document=
 this=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">change 1852</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I307e64079f436aa782f=
7e24bfff665a545ad2fa0 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1852 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<d=
iv style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Mon, 05 Oct 2026 16:01:49 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>

</body></html>
--W0duSFGJtN8=--


--===============0431136215153092712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0431136215153092712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0431136215153092712==--

