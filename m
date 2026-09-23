Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142E3C9830B
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w1gRaZ6HHXN2Izl6iU4DweBc7+z65KBoNX5S1AMwxTQ=; b=gw9qQa65C4+8RBZc+idUCatFYN
	5x1eBxBNKNCaX59efTNxnftB84tIfQu3d4UiI+jrdaLZ5H5YggIt3a2AvbFN062/0MndgoSQErll8
	lbtcLFKceSyBYRYd3iVS3CSbhHPdFGH+hpiDG/4JvJ5VfsJlVjErujlkHwEZl3NRmM1U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9MfJ-000247-Lf;
	Wed, 23 Sep 2026 13:05:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9MfE-00023c-4K
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:05:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=W/xLtvwfDhcUxDJ6RInaGtkkbPV79J+592M0FlhitdE=; b=gI8UkUp25pIsook98mzonUD84i
 qCGfk6g1QTEjQfQmp4z8D+ChFLNu7G/Qj6rUFdWdlhEjxdf4vxRJPn5bR3uPS5FsIFDwxbohRe3hw
 WX4eSgjxTetUhb96HPQNYrDZKGZ/HWavo4WU0WLAa69bpXooUCd7hBScwgq/u2Z/Pqd0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=W/xLtvwfDhcUxDJ6RInaGtkkbPV79J+592M0FlhitdE=; b=E
 /9c2mXF2Aejh69hTq+GAgZ/cEmUy+PDpiCeSgVZsuK2yV6lRTCrgmNt9kVSuiLwpOu4mWNirmg6Un
 1TJnSiaDQHj75XK0Xf9lWtodFEAahDT74QfHmFgXG0t8YcxCLqekkhmpTx5AZM1dw5UbE+TmoEjpJ
 kjzwBBX76udqyQNo=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9Mej-00009u-2v for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:05:05 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so5319655e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790168694; x=1790773494; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W/xLtvwfDhcUxDJ6RInaGtkkbPV79J+592M0FlhitdE=;
 b=Ytne9lCMd/+8DeH9zoBgbPnR96xOsWBz3B3y9JT3Fn+glTF6xvmNJx54BtVd4cN1NN
 IxV4zD7HmZjP9jrQD/ZxsvXimFko4i/MkZO217/TqB2B2I9xf+RTc7v4b4gU5a6iFPJK
 Q7LMChXNvPiAqPtJKxcpMQhtNOol0c78sUkd043JoZ6cAbOFtzHwYBIk4+VWRss0F37g
 hbzi5f4ezPLxnUjzj/qATZ6bvnyglB9mNbfjd/hrHKATx1cx7h5praa40o4A2ULpwxzf
 nYSM94FfWd1K1rSz8oDEJS8PvtzmqrK2bjK62J2RkobZkZ/VG9gozN5/4huAczLlKUv7
 bOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790168694; x=1790773494;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W/xLtvwfDhcUxDJ6RInaGtkkbPV79J+592M0FlhitdE=;
 b=v/G25P1WjKUg5bVePaHbDfVcU+NxsweKYnMFIzgJqb7ZJOrIXyCqjrof8spKLK9Ry1
 hPviNMxzmS3vU4xVkWvXLUI/PWR+AALfndafVBoX8+/AMH7gYABRWOtrSPgUxJdCAB05
 F71xvwIdqZCn9YqOKt/nLGXbKyAF0tCDgfDjOo8GWOAU1c43Gh1M02DuJ4YAMUL7mkd9
 rm0vnVcLvPUNBWuGZrfBvKHQD4+BH5BBB6Z0q7GHXQwrKNSEN2CfVOO0XBCWppb/9RPL
 oWAGcRpC+vJd6AnoHtYTGHENwWJgcWDFBwDWje3doXc3tOXseGoLAqoatw5MXC7Lj/di
 JM4g==
X-Forwarded-Encrypted: i=1;
 AKwUvByoUkZTzEBasnHP1wNtl6GT8aec85puLVB8bdSi0ODWGSNkC8R/gG5CnIdsu+PqUqNtt3GDHfJdtZg2X7nW@lists.sourceforge.net
X-Gm-Message-State: AFuF++muotioUnKUWFaGsldkiTqEDgfrNyc7YpFFzaReuP6G5nYL5wmM
 QpQNzZUaOj6pgIvUsA3uCfnTpvMos4OWJWO3XPcNysL/tFM8OWuXm2zKP0+FPyLQqOqBkIxYRWq
 zqecpHK2WVCmvYCY1rgC69bAfVg+0MNvqLM3dad4hVvYDiPXR16UrPqMu/EQXdnWuc0+mX5o4SC
 nzMvK6yA==
X-Gm-Gg: AYBFou010qpxJZVo82sD8k+5RdDmZvozqURwg8id1Im6RNTTxNZ0wg3LH6mOi1o9FXB
 zBBpa+WGkZ3fi6T4MoD/VbT+OJdolgKkb3u4myvWfcJrub4FaJBk0kKvnt26NljcTejZD/1JxhZ
 PuNNXNUtgkc4ZI8TwueUeF1Oo8VJOVWr44rCQM5UMPJ+evY8XFL3NaQs/tGh0N3ZFXdy3xrtN1Q
 QHWuKpjo2xvkWWXED/ozv5/3WVq71jhM5+/XM9ixvLFK/ycl03KYPfPfox6K1UHspEC5COxeLr5
 DdtoRtD5ZG4HtHdksKsglXzyqs6F+TrcyrdxLC0Y3a5mJMVuv55yM6X7pfzdNoVr+odUx1HCwOJ
 pTAl1s/wfuZ6YtXypFh3499E6iwDmEijghn5Phv3Jj4zSpszEt1PyjICUC7R+d6lxzIJbASE961
 aYKEuv1cqoT6DT4K+wjm1hBMGQ/KZYSTGbacqf+i9wT8ByMcUSvDFwy+LUHU9FIr9hUAisGltK2
 Hng1d8i9AWGUd8dcZNKB9UkJFEyuQHr99oDPnaJ4eC+bY9zFH/eIHP++dJioYjoLZxAMUkOg5+F
 /NNOvY78iSbTXqwLxhHgSQNBlZLa6WDiVcc+MYGZ7cd8ESh7HTqh7whvu+dQ
X-Received: by 2002:a05:600c:4e4d:b0:49f:ce78:3561 with SMTP id
 5b1f17b1804b1-49fdee0a1c9mr36228725e9.18.1790168693588; 
 Wed, 23 Sep 2026 06:04:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1aca52sm77060725e9.14.2026.09.23.06.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:04:52 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 13:04:51 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
X-Gerrit-Change-Number: 1919
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1919?usp=email>
X-Gerrit-Commit: 12c2603caaec7f4b6d7f4aca60c1177714d2b300
X-Gerrit-Comment-Date: Wed, 23 Sep 2026 13:04:51 +0000
In-Reply-To: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
References: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTkwNDAwMDAwLkk2MjE3YzA1NDFiZmY4MWVlZmE2M2E5ODdkYjg5MDRiMmZlZGEyNTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <362cbaf7d828d4eaf7469018fe0836555f489c87-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9Mej-00009u-2v
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Document notify as
 auth pending method
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6571659284259078311=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6571659284259078311==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QOhCRK9yEgY="; charset=UTF-8

--QOhCRK9yEgY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has posted comments on this change by plaisthos=2E ( http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail )

Change subject: Document =
notify as auth pending method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 3:

(2 comments)

File doc/management-notes=2Et=
xt:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/dd10e647_cbbfa7=
5a?usp=3Demail :
PS1, Line 814: An example message for a message for a serv=
er that does some checks against
> Yeah that is not a good text, reworded=
=2E
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/b79601c0_=
e9b7e35a?usp=3Demail :
PS1, Line 822: this message is not negotiated but ca=
n just be sent as a gratuitous message=2E
> I tried to clarify=2E
Done



-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6217c0541bff81eefa63a9=
87db8904b2feda2546
Gerrit-Change-Number: 1919
Gerrit-PatchSet: 3
Gerrit-Own=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvan=
c@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Comment-Date: Wed, 23 Sep 2026 13:04:51 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mail=
box=2Eorg>
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>

--QOhCRK9yEgY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has pos=
ted comments on this change by plaisthos=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail">View Change</a></p><p>2 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File doc/management-notes=2Etxt:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1919/comment/dd10e647_cbbfa75a?usp=3Demail">Patch Set #1, Line 814:</a=
> <code style=3D"font-family:monospace,monospace">An example message for a =
message for a server that does some checks against</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Ye=
ah that is not a good text, reworded=2E</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/b79601c0_e=
9b7e35a?usp=3Demail">Patch Set #1, Line 822:</a> <code style=3D"font-family=
:monospace,monospace">this message is not negotiated but can just be sent a=
s a gratuitous message=2E</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">I tried to clarify=2E</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail">change 1919</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6217c0541bff81=
eefa63a987db8904b2feda2546 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1919 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div=
>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Wed, 23 Sep 2026 13:04:51 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display=
:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>

</body></html>
--QOhCRK9yEgY=--


--===============6571659284259078311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6571659284259078311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6571659284259078311==--

