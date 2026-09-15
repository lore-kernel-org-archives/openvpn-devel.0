Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014C7C88E75
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yDwk2PE4HoZ+hemz6AuEimA6C+HzJjgKdxJJAoohXx8=; b=edqKmAKXhGIXKrStrbDfI+ohmg
	lzlnWysrLCy/6pSVMiHUkV+p9Rz2IZgxelS0qQkQsvpTrkadHgWu71usTF+spzAGK+DW52ywbp/qQ
	qPV1G0Qn7tYq0AA+I86FoEP7+MY+jiETRezc8QSTY7qt6pVGDoyVWoPpOUcvTxrr2ucc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6SXf-0004UX-Dx;
	Tue, 15 Sep 2026 12:45:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6SXe-0004UP-6K
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:45:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=87BsM02IbE/4RIfYv5mMUHscHeOkuR589XmOuNCgHSA=; b=Mpa9Vvfwr3W5v2oLC80e8j5OK1
 PIoss0HtoFDhVb6ob08w/af9HEaSn2xX2bGcZWWqkdILsCTV543kgfFPrm4HYs6SnlEhIz4oq9GW1
 i19CaBwbd8kb1yKm8hXvEpGwlnkQ8yDmO3rCQAiLA8GldOfxdSvRk6SHzmyxqiHLcW0w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=87BsM02IbE/4RIfYv5mMUHscHeOkuR589XmOuNCgHSA=; b=e
 TISnYLyjpc8WNT+tCHLgEXAiwyyAgYr+5lLeD0AhP/Huno8FdxL8WeAH198Fgk2cvhG62E2GkK0Oe
 IU9QqbzMSauZ2apkJHcwOWBXiWN6Qcxln4N+wo2829K8tZ6Z4fr24F1h8rygxaxcEMez0y7/0bdpN
 cIfq6aW0WRfFavbY=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6SXc-0002G3-MV for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:45:42 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6351832so1796863f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789476334; x=1790081134; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=87BsM02IbE/4RIfYv5mMUHscHeOkuR589XmOuNCgHSA=;
 b=Zo2ScaAAY9enakUpfVUnt4RdIw/ILVJzYfB7cX5eJaDJE1If53TukxCgr68hyk/F7S
 J8Wg4GQvau+0QTc1FN00NIIsGWS4P8k0ae4ZG2PLozrXbC2Pg80KCDgSEgyKiZ5HTFDs
 Elg5sUjlOIkDYBG1Ti7vHnLLiJgNDsohJIGYohujVhtzxEAoWDoFdCSPnk4RzBQvw4Vl
 QGKggCvquaPajOHhmnWzUBxYd999CSRLAnnZAXeL5kkc2FKS+WesdpizQNoFlRRkMg5b
 qf2qs2nabxoipRM7SWej4HI3JfC+vBuLeFWL/jR0PNN/RjSKsAN+Uiw7xCXgAuKcNkVz
 05Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789476334; x=1790081134;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=87BsM02IbE/4RIfYv5mMUHscHeOkuR589XmOuNCgHSA=;
 b=yc2XPRpeLXO0Vup12E03DPuKRz4nQw5/xGkSFqiTuzfnMA1/KVEU7GhNmmWk9XxqXn
 I5EwR5xB+kebX4k6G5mrxlZt6Ptdk1gTSkIHj5AXkcccm3mnd1enMfkK+TlaUaIvrN9s
 WGLX/hLy2nWz0EHx8VDTFOi4dagOxgWWJFhFiTngj2OqjWjcnZnIjQvKLqrIAHFRoLAt
 2TkWncPDdJgE5hPovpYAaAYlCnV9atWqRVjiyELlg8hmH7wfhRBWj1PCjVOrQUMt2GR2
 HgMGZ7FkY59m0uMmUcvVuAdFMQd3ugm3p1w/d7n1+ZL8qkGbNquDhvHYPAJmXq2tT8ql
 wTLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+ZxS4xNETpa0P3p1yVEZdEoG01awzzI+LVqPg3ax0b/jKhvUaXzsW4QnwLBFzh8n957D0OQ8oPKdlW9//@lists.sourceforge.net
X-Gm-Message-State: AFuF++mJx2pIzF+iKJG/IV26bPKORf4rF5QHZoH+/Zxt/YizupFJZT9x
 gZW9ms4yYIkYHTtxdFnbFqekQlPS57qnjzatrfaKfV3xJdEDJJ8spYwI6wdMR6r4Q0YlBFh31rO
 YM+c56JiFchneATL6UUJSPeiBimYEMdpJev7C218Cuf5u5qGyLjBF1gmnkUKxEE6ZGbTP
X-Gm-Gg: AYBFou3f0yTzs/Xg7emv5cmZwLFtPRC2qm4QdxRO2jCNl+37haLCu3IlDy0FCyeZyNp
 XPtjBzyLk8a5GZVRZWuxUTVdaMPeCivw1Pt4igw4YQlXZ5pj8P2xK7BMa8/oh29wFMwl4Zqgv7E
 RfZyhD79OxY9diHx/esPOJulIG4nSp9RiPo5xFmofn9e7rZwI3BNPDgMZTTJXm97shKarbVgKhx
 /sDKYHbVVYezlDaz196tCVs3uG7oBPzoAu3F57g5Y6lYCuWxflzkoISdY6uBf7iqYc2IGvv+MKI
 wOcjB0EFNlXynXrk/g97VjWRxg0wTayFyoHIuzJwQ4g60N6uWEVGlUpCATJIN3DHIBEgmhCoHmG
 OYgZShEk3Lvf/CZiK/jJCOGm0aUIENGZcN1OZLlwloo0QclhwRQ7VEdXY4ccvGrb0iAoyi+3YQC
 VT2n7mtcf48zRgEEU75fiapCGSABx+ZK1XRGqZCKehHtXmlSQninEe9lwxhZtQ676sIfXpe+VNJ
 UsTuxj9o/0wrTBmrSfh4zPJWHOF+yzRioWJkhtmE2Rqh+giRFsOylWJe+hXtX6igTxuSmG2htPQ
 iP7+Durh0IYnvXgjwg51wyjliT/z73r9CD9CcpmPYcdaQTSCJ8ouWJcGgwSFtQ==
X-Received: by 2002:a5d:5f03:0:b0:487:9a9:6d24 with SMTP id
 ffacd0b85a97d-48709a96d43mr1934340f8f.19.1789476333888; 
 Tue, 15 Sep 2026 05:45:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb3602eesm32769801f8f.34.2026.09.15.05.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 05:45:33 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 12:45:31 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: 793301a47dcc96dfdd667c31e923d1c416f069e0
X-Gerrit-Comment-Date: Tue, 15 Sep 2026 12:45:31 +0000
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0eb0a1ca338d398dd1650d7e2f0895d3b23fdb80-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6SXc-0002G3-MV
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make required action
 returned from pre_decrypt_verdict more explicit
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9117761702688577580=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9117761702688577580==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uMc36I5l9tk="; charset=UTF-8

--uMc36I5l9tk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, stipa=2E

plaisthos has=
 posted comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1826?usp=3Demail )

Change subject: Make required action=
 returned from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 9:

(2 comments)

File src=
/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/=
6f84dd44_50266c07?usp=3Demail :
PS9, Line 99:     /** This packet creates a=
 new session normally */
> "normally" is not very useful here I think=2E [=
=E2=80=A6]
I reworded this and explcitly mentioned that this is for legacy =
tls-crypt-v2 clients=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/co=
mment/ef2d16e0_8af59dcb?usp=3Demail :
PS9, Line 102:      * the three way h=
andshake */
> "This packet creates a new session=2E The challenge has alrea=
dy been completed=2E [=E2=80=A6]
Thanks reworded this as well=2E



-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa=
9871106c2f89
Gerrit-Change-Number: 1826
Gerrit-PatchSet: 9
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-R=
eviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment=
-Date: Tue, 15 Sep 2026 12:45:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--uMc36I5l9tk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, stipa=2E </p>
<p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a></p><p>2 co=
mments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1826/comment/6f84dd44_50266c07?usp=3Demail">Patch Set #9, Line 99:</a> <=
code style=3D"font-family:monospace,monospace">    /** This packet creates =
a new session normally */</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;normally&quot; is not=
 very useful here I think=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">I reworded this a=
nd explcitly mentioned that this is for legacy tls-crypt-v2 clients=2E</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/e=
f2d16e0_8af59dcb?usp=3Demail">Patch Set #9, Line 102:</a> <code style=3D"fo=
nt-family:monospace,monospace">     * the three way handshake */</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">&quot;This packet creates a new session=2E The challenge has al=
ready been completed=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Thanks reworded this a=
s well=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">change 1826</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Iccdd4cfad090c565aac27=
e16cdaa9871106c2f89 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1826 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Tue, 15 Sep 2026 12:45:31 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=

</body></html>
--uMc36I5l9tk=--


--===============9117761702688577580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9117761702688577580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9117761702688577580==--

