Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C04C982FA
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NxLpypI5lCG2cOO3dmG91DJsRjjwkOim0oK4A1m8hyQ=; b=awADR4lcLmOhrRarMTOPEa+0Oj
	7SGMYLNd2dTofjkUJg0suEKJPZ5wZQm9KYZyDWdqlcCTI55BFy5uzlE7JbTpjh4DGGsUfDourdb11
	YsLvKzpD+pc1ChiId755BcfpwGXyh76qVACuEM9Iq2cn14o8I03bngJR6mqrQMTx52XQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x96wH-0005d3-4t;
	Tue, 22 Sep 2026 20:18:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x96wG-0005cs-L2
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 20:18:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=M39l6pyim2usUr6ekQVnEPV83LDtxhdV4Q0FlcqXVYM=; b=WKE/eY0hl5+URr9ZRpB7gX0VwS
 d+7msg7cvmpcYZHiN3TiYg2uJNmgPfQT0kTp7zOwHJQldr9b2OB7Uae7ZFZ8yFp3gFeAKZ8XOu3U4
 0tTbDw0I49/gnPZmpUdHD37WeQSr3Y58Uf4xNNJNZ65NwvgDe5gDoqPNWV7ggxxajJIY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M39l6pyim2usUr6ekQVnEPV83LDtxhdV4Q0FlcqXVYM=; b=Q
 ll79ERmlGoLIjRFqCmquTTOFg7bU7wbteXJ8rdP/8MELv+AzfEDhX4uVvobsNJ4GYuY3vkk0LgN1I
 x0frOvnkIa+eGf4C6ICRD4O97/LUFoZfBFiM1m4oVBkBPf1QbydlTqQeFUSCx2jbzDT76LUMF2ZsI
 uz6OkwHs7uIW20Zc=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x96wC-0005Ej-9E for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 20:18:02 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e620fa473so1176945e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 13:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790108274; x=1790713074; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M39l6pyim2usUr6ekQVnEPV83LDtxhdV4Q0FlcqXVYM=;
 b=hM4gKUA0bhKHRa2BTKpFndNhIxgGqTKmAVwEhBW1PXPSL5Fhksc5dK0mA6HdjeN2ex
 4PnWe1z+gykCjNVhcmlfMXokg2EtQmamdcxuVhonNzs9Q1vEW4Nwly+Z62PBBHAxKHaV
 rhnPDV2OavbTJTXCiip246MDgUHSUBanzXYGD1G3HKaNSowvyiHQX1IbUITRalQbZ7Do
 gR3kxkl0qdh0br1Ny7OszjIPV5W0AtGa5jdHEfVSWHYLQg8GezhioEU7ddipGOM8j39l
 YNMIaNEfzk0VyZVei3Y5GjmqKhV7r8/YnF/Jk7EyZSXdcKgHkY+bT7x8NZromNqL2I1z
 KW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790108274; x=1790713074;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M39l6pyim2usUr6ekQVnEPV83LDtxhdV4Q0FlcqXVYM=;
 b=f7BOGbSSNc2bf6RK+qp4ZTfDthML6dLCAUPqlA0+eA/UY5NZ0ajggVcNJ9+OnQfG13
 WsHIf08jSOK+aX+tLOvGRmxg7aH7q1RBgmiFfYe2AAX/5zkKA1r+dC5KhvRrhrZARnDC
 Qa/TkZ8URl54t09V6cE3gc9G84fE6qgMLCGTDK2e6KIVT4Ke/l+0Z2AlIr4tq3C1WRXl
 gSS2+vx3OgSk9yw7o5c/LIB/KW/bzIzP/fFjQTuSw4LorCvrNfqvg8Ghiyzew0H3EDJT
 aoWIicbyDKvnvLy8iPsBhVqznIMjhJfEJLceiRtWyodPnYGnf27qb7NKzuD362NxJj0l
 5vWg==
X-Forwarded-Encrypted: i=1;
 AKwUvByAjTWe9Bw+cFix0llx2Yz9p0ehKT3RcswicNi/7ypCbOvmFNzZF1iQ/vrfFhRQpwPqlSuYZ1eMlGj8rlnA@lists.sourceforge.net
X-Gm-Message-State: AFuF++m7geKEh4I7g5VZRiLrGel6v35drAcZZo8NxdTCpSf1FH7+LxrE
 SfrjfNPgAuiOUmWtalT4dsZN3t2a577jBCAMs0V0XsHPfBtAhKjYwORH0y3X+bhRHR8fVkugccX
 G/yMsbVT0X7fdwzhxB/xZtCP+xBoa3Y5hhFZSazsZ+4taA6ecAafmQeaxGgEBwOJ4GrYBjn5e/1
 OP15+O2w==
X-Gm-Gg: AYBFou3F2uRuJdsu0Wwjq7WKf72Cd/zuRWvwKFLXVzxTGQGavReIJBpj78UellDUyuH
 btfUFIlkMF/cwebeXcOnNmx39ibrM6A6uwICNp0OXAXyVLUJIeUJOMaIu0ie2ynNy/HoWOAFRwR
 Ln+nlc0mFPaDjiZ1gInKzPydtuTJc1wgUmMgUIr5g+3pYmrtsJGwX47QrXk1nnkuR0/sNMwI/Sq
 WD5UbdbUTNbTJwftNLMpwpAz7G0c23ImvcY5MdqixcXcpjw7PzKLw4OL3HYVMvjLBJXdx3uG0D6
 UN8C2fUJr9Fn35YvugjkTw9vecZQEsZNz7C0Q0I776BjoewcTx26ZC2CD8yb0NIOiXjQdXCkzLZ
 KJzcnCOQQo7c46J2kxCxAFRm/J4nycWQSS2LKqsipWJe5NqakhQxa9SSmwmcbP9TOX/FLZKniYv
 wWC35jjszm1vTzg/2CA4EXSYHrd0hr1BPfqbJnoGAfne3YskSLHv+8WVNq3WYkHk/7nnwDjbo35
 FaHCImf2ZXlKtxngBzLKywLmK/CcesGQuebQMiFFJ7vGccbOx8WQYvzHJCSOGjlGNgAP/YBjA0e
 in+ZJAynEOv7a+DNrHDbs7e1uC2ZD+JY1kLNG16IxjEepMxel5nIeuPC1Ae/
X-Received: by 2002:a05:600c:3586:b0:49e:7c7e:274c with SMTP id
 5b1f17b1804b1-49fdf0fcbb2mr5436655e9.14.1790108273656; 
 Tue, 22 Sep 2026 13:17:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde17dab9sm20458875e9.2.2026.09.22.13.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 13:17:53 -0700 (PDT)
X-Google-Original-From: "srkyn (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 20:17:51 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: 67bc78c7f97e197fe98ce901e36edb13709376c2
X-Gerrit-Comment-Date: Tue, 22 Sep 2026 20:17:51 +0000
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3837bc6fdd41f886d48cfdafd348bb51f429e45d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x96wC-0005Ej-9E
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
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
From: "srkyn \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: david@srkyn.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "srkyn \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6029558791286793871=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6029558791286793871==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w/G01DmcAdk="; charset=UTF-8

--w/G01DmcAdk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2=2E

srkyn has posted comments o=
n this change by srkyn=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?=
usp=3Demail )

Change subject: compat: close all unrelated fds in forked he=
lpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 5:

(1 comment)

Patchset:

PS5: 
Thanks for the +2=2E Patch set 5 stil=
l shows checks~ChecksSubmitRule as unsatisfied, with no check results=2E Is=
 there a job I should run, or is this handled by maintainers?



-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661=
fa289dc55
Gerrit-Change-Number: 1881
Gerrit-PatchSet: 5
Gerrit-Owner: srkyn=
 <david@srkyn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: cron2 <gert@g=
reenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment=
-Date: Tue, 22 Sep 2026 20:17:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: No

--w/G01DmcAdk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2=2E </p>
<p>srkyn has posted comments on this ch=
ange by srkyn=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1881?usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1881?tab=3Dcomments&amp;usp=3Demail">Patch Set=
 #5:</a> </p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Thanks for the +2=2E Patch set 5 still shows checks~ChecksSub=
mitRule as unsatisfied, with no check results=2E Is there a job I should ru=
n, or is this handled by maintainers?</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">=
change 1881</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1881 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: srkyn &lt=
;david@srkyn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Tue, 22 Sep 2026 20:17:51 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display=
:none"> Gerrit-Has-Labels: No </div>

</body></html>
--w/G01DmcAdk=--


--===============6029558791286793871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6029558791286793871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6029558791286793871==--

