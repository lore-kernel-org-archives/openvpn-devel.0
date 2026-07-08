Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F24C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eO2mJc1FK9d8slpURTCQybI4yRhiQtzhZR9Jg5yN0vc=; b=Hs0X4Nj4EXF89RyZOtAjuNzHdj
	yvJ/ENC/P6QuQAP4nVQVA2EnUaHMcvjKgjw2HlMyaKQc0TZQ8hzIEwPhcYwP6bOjAW+7GuszCSTZU
	gV4JxfwewJicKf8CAHOgvwliVXFdj749qYbOnJuArqCsUH0J8dffDxL9gM9LGP2iyvco=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whYSh-0008Mg-G4;
	Wed, 08 Jul 2026 20:01:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whYSf-0008Ma-T8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 20:01:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AFlf0pQxFoT8EJuJuuUEqNv3QpfhfZJvVnkLGBAW24E=; b=hAWY43ll7yn62OhF+Z3QEHkbXj
 M5WwaeIfrXRKeTtsXiiHNWqLIA1hZ6vTclhgU+F7vScToJITY7tKyduKS8BLJ+h68ibF1fibUZbuY
 vIGJrYcb/F9t/jAtWtCoS2eCVeXkws1raSlMdQ+TVZcnrDEnI7aNdHbPFOXTkbAo4wPM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AFlf0pQxFoT8EJuJuuUEqNv3QpfhfZJvVnkLGBAW24E=; b=f
 zYHHyB+kj4bXXUyyituASfro+TBzoTEbyMyAHWQon34/p8TF0cMW9u4raJN366z59WmrbK21GuBkM
 HmlSWVEMhLyYT75tzlqjfeDIbg2ehJyHPmNtj3QJRmY33AmbnLglAzPUpmoA4GrE0nIaU7YnM90sq
 uyRC6q+9jqXxWlh8=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whYSd-0000fD-SC for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 20:01:37 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so1701575e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 08 Jul 2026 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783540884; x=1784145684; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AFlf0pQxFoT8EJuJuuUEqNv3QpfhfZJvVnkLGBAW24E=;
 b=E+D88Ja5XytB9Bzl4EH6v4sTByJo5eMlCQ0T1pEEZDPOaY9Zmqt0TrdohJgK3GfMLB
 KqIulXsp/TsD3xd6r6gHJ0zbjlNWHOtslEVvskc2lCW/P+JgPvXgb3HfZ507Fncw0tGM
 ohL3HsKX5BoBICPLzDq2b2oKZZe8sdeoOtS3i018uDEPD5fvsuaK3LgX+ACH4LEmV5J6
 zsC4mA73d14C00bxd2NIOcKiig9xHjFNXhD5rjqEQFuP0i5e93ksiaY4tzihT7Z/UBHA
 2iPTpVzboYE886gnOV7/LEY0BqpFi+OdvsfqSWHdiJObS4dQksxP4U7YN23LVZCmcZC7
 lRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783540884; x=1784145684;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AFlf0pQxFoT8EJuJuuUEqNv3QpfhfZJvVnkLGBAW24E=;
 b=M6IxWiMCvhLDAwTPm4XewigA1VHMEi4LPfo+s1ILy01R/JJ332lq99iG0EadUSvzuK
 RjENl64MkhsrlU3QowlktVMy6pm16SxAWVQUze1qon1j9BN4UiWyezrYZYiewNzSxqet
 ZY5XdHXYCKCoGriUUtk+zpdyNLwha7eupPhF1yzxG0HFpngZ/3vHQqNB+wejqSQPaXkq
 HgrZYapoEZAjqCrnoHYp//rcNNEtcpHiq+aYImHfsZRn/MQvDowc5enQ53ipdeLwLAD+
 FjKKAjCij0Ms87gwyGR3z9j6FzzOTLosYoroz0qL0SDeavTmHX8z2oVBuM6n8BrOMvyT
 li2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbXvOxVIjZQMRORs9Sd+ZwoeT1jpMAj3HBu8clAEV0Uxx9q2g6Y3voudsehYIfjSabdgPq4TKydzn82cNo@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxFwepXnj/Ocnt2wLEmmiZAm++4+gkeabkSS2pPjMQzAg7SoOmP
 lplSYDbmOSv/qGyl4Fae39265WbQF2MesHX6aowphWEzaDsdSLWT89WC8A/aAnI+r/0apB9oiIR
 U3/jJ0PZLLH6CSH2iSSWEngzi/VaO/HXYJ+Ha0F97WuXILVkblx1Av23dlsTtLJQj0qo0
X-Gm-Gg: AfdE7ck8z5E3m5EquPGv35m3epIzA2Kn0crKn/HIERH3Yyb8TGXoPEswrG5pTFzl5Ip
 h9ytRTRTVClEzgwkZxGSgY0nUwJqAwMZXKAbSQoNRaMJ0oGI2DlZupvyV2PimsUDSDc2GtAoKdw
 HTFmepCDsjWOcP3CQc1r09iEkAFPh7dgEYaDP+lZr7/f0oUhHY9mSAC3yxkoTqx8EoBXrc5N58T
 EEJpjr9IQBLK4x9Vr6e6qJa2XBaqKsQdANmpiXxsilEsp71eFNgwblOZp+TqKhE8o1OpsGY24ty
 4OdP9Kzjg9GWiwQcGLHmKpxtXfWFaX6xyJA8FiOJmRBZs+fGMrzb2O7nElDCWGnNzliChqFL2j9
 mhC1TcmkaBwD3M8Dm4hCwXXVErYVFBBrFBjzDFBfhEonOQsckKkSHKcFUpxKHeEY6KP5b2dmpAv
 sPDMykRoU9pSGlN/I69m8At5v1b7oNl5zJgE7dlhd3MFplmxnRlt5sd1IwZ50YjXHWBaoufz0S7
 XvaWzA2EBux7mW7mScWeCShVBMlc1EBeRSErne2JHiqCV4yrV5dLFpVf68iLZ8cw+ybYqWYm8Ys
 XdCwhUpcq+plfQ==
X-Received: by 2002:a05:600d:6405:10b0:493:e963:e671 with SMTP id
 5b1f17b1804b1-493e963e68bmr10213745e9.3.1783540884087; 
 Wed, 08 Jul 2026 13:01:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a58853sm65398045e9.1.2026.07.08.13.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 13:01:23 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 8 Jul 2026 20:01:20 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
X-Gerrit-Change-Number: 1740
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1740?usp=email>
X-Gerrit-Commit: 837260c57e6dee5b2eb106534d12f05f3e7dbbc0
X-Gerrit-Comment-Date: Wed, 8 Jul 2026 20:01:20 +0000
In-Reply-To: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNjc3ZjQzZmMzZWIwMDUyZjhlODBkOWE3ZjA5OGQzNGFkMDNkZmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <222042702723762bc4a4bd7b5b8b66580388f541-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whYSd-0000fD-SC
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Add
 buf_read_u64() and buf_write_u64()
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9154408045633914757=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9154408045633914757==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="540x4e/fvu8="; charset=UTF-8

--540x4e/fvu8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

cron2 has posted=
 comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1740?usp=3Demail )

Change subject: buffer: Add buf_read_u64() and bu=
f_write_u64()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 2: Code-Review-1

(1 comment)

Patchset:

PS2: 
The code is pr=
obably good, but the commit message does not make sense - it talks about "n=
o portable 64 bit byte-order primitive" and then the code just uses `htonll=
()`=2E  No what? ;-)



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1740?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
Gerrit-Change-Number: 1740
Gerr=
it-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer:=
 cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipa=
kov@gmail=2Ecom>
Gerrit-Comment-Date: Wed, 08 Jul 2026 20:01:20 +0000
Gerri=
t-HasComments: Yes
Gerrit-Has-Labels: Yes

--540x4e/fvu8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">The code is probably good, bu=
t the commit message does not make sense - it talks about &quot;no portable=
 64 bit byte-order primitive&quot; and then the code just uses `htonll()`=
=2E  No what? ;-)</p></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail">change 1740</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic677f43fc3eb0=
052f8e80d9a7f098d34ad03dfe1 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1740 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@=
greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Wed, 08 Jul 2026 20:01:20 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<d=
iv style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--540x4e/fvu8=--


--===============9154408045633914757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9154408045633914757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9154408045633914757==--

