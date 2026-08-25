Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DED6C61DB9
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EbTiisBI8fGai+fk8coDggZZcxQVXW6UCch0ZKjsJmM=; b=bfkgeEmfNfJHPPUQQHhANY40vF
	KumQJNJouHySg/jglp+MwyMWT0Kcb1pcgHEbNG3BjYdgXCjLwW1boJRMcQMJWcjYWYDf+0wqBKFTO
	TcV5PRTN9R/C2UWFtOZ/n80cGW2nCcckfjGRZ3LS8oWktxY1gJs9Ke+67ItH2L7JzWqY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wytP3-00024d-3L;
	Tue, 25 Aug 2026 15:49:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wytP1-00024X-Qe
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:49:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UtVVgoIjKgUJjf7cfv0FGU4qpQ/rbcmy7YUhsM2i4QU=; b=h8su3MSQVc0Y+KXZJBVQC7j8l+
 rFOMr9sY6qfh4gcT8mbw7bpiuP1RtYI9V3YVIJZ2v2Tb4qlCQxxkMmLefoJlgOIWeFKCZTcbKYXE8
 9+dG4QRNBgCGtM13MCHst5OA1H3mrsUHGYFhsR4rmiIt95M84N7r8p/wIeF6anSZvQYM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UtVVgoIjKgUJjf7cfv0FGU4qpQ/rbcmy7YUhsM2i4QU=; b=D
 bPI+6raw62wfJDORzLaxH/LfCHLtRF7S9sCqwfO6NHWfSli8xu01WAD+mb4vkexE6rnb0mowkPvs8
 2ViAdcemV/HycwxdTGraGus4Svo8B62JNfYwckbIQuqv0EksNEYSEdkYurekaP+GIWEDUMEagAObo
 g3yD176RvaXD7VdU=;
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wytOx-0001Lm-Mo for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:49:29 +0000
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6a15d54ac95so8685563a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787672961; x=1788277761; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UtVVgoIjKgUJjf7cfv0FGU4qpQ/rbcmy7YUhsM2i4QU=;
 b=bQJoUrlnQhzkHPVHZmPiamD99oB1KbP5O3Mf8f3/33jV/HjHzSBmeEMfYM0VClp+4P
 9L2fX5YXYHnESH7Rx9Y0Mo6YojZT5qo0XcW5u1hTiLwNbJkVKYHfqJ//32uk8cX9OPkS
 F8NMTqyk/PlO7wg4LevBcPTUGSx3gH+9nx56HWftT9bZHV6WJe07lOetovpxP8CJu8Vq
 NiHzdvWI+n34r4DLRqradQkZ0OKNXgLVOS4ymvHZ7LrUXFVCIqvU8z7l346tu3cAnZEL
 4pBVqElMJW4l4RnN5w0JIge5LhWw4srr8mSSaBNxLG4lzIyvb510WktwVSl16BtQC5rm
 SMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787672961; x=1788277761;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UtVVgoIjKgUJjf7cfv0FGU4qpQ/rbcmy7YUhsM2i4QU=;
 b=rILFQ/r/qkJB3tqVutdaYcCZPc9+fgySp/PdqUaV4pA+JxSXtE/9DYVQEujezs7tSB
 A1hIt7+jLBSOZCHrsD04Sc8K/zSD10WNYnDPsmYr7gwk/H1QVI+CjFXbDWpnW4lkRKol
 +vHQSs46O4C+FNMxFyEbOhytYMW5CYKDGOKGEkNPdfznW7Dn1ZHevOC6UesDdFbjCLSP
 s7wH48cjwpUpAmiWS3b4ZhU5lFtnFC4x1Im07XzwQe+iwT+OC5kEOu5YsfMAsDKiDwa7
 vxZL4AVqJlsWNQmJX4y5DVs59UTTPuaawYfRjdNWTVj2XCAcrl+r/fyb96B0bQWSYqdT
 iLjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6KElD+bBEEX/oCTlIdXNqWLYtT17xkK4lsTSpI0NLgCL5ZxhfE6XOcJgmVZmYHLn0vmkHXgYv57PmXNyr@lists.sourceforge.net
X-Gm-Message-State: AFuF++m37OhYjBIRwJ2NM+SeCW/n5o4SXs89lOev9qIUE4vxDisVG5Fl
 1cdDc0q0hBxv2HyCNZyJ+rzqJsbn4fsCJg5JSrl1cJe7W+8TnikWnbtlE3izOskWQrRx6D+aYL2
 5mpVdouXIAy2B6NLs2FF2NAJjA+MGSu7XZsQ+kR8EYSlp2kPqLVhiZwA67WiugksePmpJ
X-Gm-Gg: AR+sD10BOK89i4/17/dfrelaoqwiuaJ9TuC/L/21JFZIaq0Z30JKVuGq9W1m36XDT7Y
 pYA7CgLtnpRqw2TWQ5Q7KoVDr6g+YVgiCWm3qMETiUfBwEBL4qyHrQJRCBSocqT7D6p+B6TxzUd
 RWTLDauplz45//8Pqgx3Zz7YfuG50mmzPqOVjGpPwhLgmCewduJxU8FzVk2pGnKXmM715T48yiF
 55epls6Ud7mndFF9EhlenA1XlURQTFZXrcgYV7F7W6foC/9zPZWd1nlBLZi29wTy350muNe6VQP
 WiaP0xwq9efq2LZorBv4gXtyZ9EpnU1t7CilKwSg39kdPa+Qspp8aKlZ9lzBjOhUInGIBoUO+u6
 um6wAemq4jQ5RGtRuRworYeVibxzkCBG+dba+k1MYInpDPkE/ACUgSjKtg5yV6QyPzgDohKkXVr
 64HgNL4vXFvC/vMZ49477EFl/MnI4m1hkvYkSCUEcUUX4b+zNKT45rfr1kVuuh6ZIiYiFpWoYS6
 9y1dKaiW/61H3/rMrB6++I/5qkR+smyrpvtQ5bDM2aq7HXkKrZUlIeWLE04bx+nMCiRPwGoW/tP
 ReHDbIjD4vmffiUtwiVXXg59mXNCzADTzCdmNEMuFoh6W2nKPh0=
X-Received: by 2002:a05:6402:434a:b0:6a3:691a:9d82 with SMTP id
 4fb4d7f45d1cf-6a582af951cmr33390121a12.3.1787672960902; 
 Tue, 25 Aug 2026 08:49:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8b625bsm351942a12.6.2026.08.25.08.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 08:49:20 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 15:49:16 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id56fbfa4767346995eaa05ac95c7a20fbba99b2d
X-Gerrit-Change-Number: 1869
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1869?usp=email>
X-Gerrit-Commit: 0f575c5ac88f329fd34904f141c52401cdbfa62e
X-Gerrit-Comment-Date: Tue, 25 Aug 2026 15:49:16 +0000
In-Reply-To: <gerrit.1787672720000.Id56fbfa4767346995eaa05ac95c7a20fbba99b2d@gerrit.openvpn.net>
References: <gerrit.1787672720000.Id56fbfa4767346995eaa05ac95c7a20fbba99b2d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLklkNTZmYmZhNDc2NzM0Njk5NWVhYTA1YWM5NWM3YTIwZmJiYTk5YjJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f4aeec07502deb75fdf552fc6151f2502124e335-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wytOx-0001Lm-Mo
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make cppcheck run
 pass on top of current master
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6107423396010930432=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6107423396010930432==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BEULqGb2n/0="; charset=UTF-8

--BEULqGb2n/0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1869?usp=3Demail )

Change subject: Make cppcheck run p=
ass on top of current master
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1869?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Id56fbfa4767346995eaa05ac95c7a20fbba99b2d
Gerrit=
-Change-Number: 1869
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Tue, 25 Aug 2026 15:49:16 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--BEULqGb2n/0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1869?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1869?usp=3Demail">change 1869=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1869?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id56f=
bfa4767346995eaa05ac95c7a20fbba99b2d </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1869 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 25 Aug 2026 15:=
49:16 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--BEULqGb2n/0=--


--===============6107423396010930432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6107423396010930432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6107423396010930432==--

