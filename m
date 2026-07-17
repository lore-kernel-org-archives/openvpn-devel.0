Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992B7C44520
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3jKDFG+PuSAsDGAsxhYJsWiMtz/l8Wvg6hNcvJ9QqWA=; b=B1cer4f5TiBA0OKFQdrd7CDqK1
	IvnM4PoPGcJPZh8dTOEVzIP8dGxrQQtMoLGAwFw46PNEDmKHkHH425HA6YZ1P3z7jxITHvtbMgLLt
	ciekNVUrgO42sfiy4LWIpbgFGRomjBtTPNWOBSD1zxMJ5Y87vrNVtCBRixfT9N40i7dM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkjpg-00020Y-2y;
	Fri, 17 Jul 2026 14:46:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkjpf-00020R-4F
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:46:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=08ZBCJS405WG1KCU01eG02f/rpP6Q4IMEXm+HV9RY6Y=; b=HH7jQU4L8svuz2QiUooNN6xhQj
 EqW1aYIgxIX1G9MgGPwXv7odl+lI5DBR9qwdge8f+P87LzHTUurBUUrCRzlFb9S9L7ryKHnP/7/7B
 mIFd9iD8XrP584GPvlMyuVpAIhfNry3tq3gBEqNs3yTL0Xvef+CswqwPC+DU/013BTXU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=08ZBCJS405WG1KCU01eG02f/rpP6Q4IMEXm+HV9RY6Y=; b=i
 0whuW3btXAowzRd/KU2DnBDg7juMIjNkreTtzsXYrcCnMx8/cr/gzHzAMUUdLtfMZb0aLveCxXZga
 6lKb+cU5zKN/JlhOgNUhDINdUxv5JBQOoAw8dhNG1QEDUfRnwyYnyoJsrLTdUMNIJ76LWD2GS0B9H
 JbOegt+jGmcIp5LI=;
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkjpb-0005rM-1L for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:46:28 +0000
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so492323066b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784299575; x=1784904375; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=08ZBCJS405WG1KCU01eG02f/rpP6Q4IMEXm+HV9RY6Y=;
 b=MFEX9V1OcLVgwevNwdYbtF41zG7RPTfX6JbM+WGNYdlTWRAPPK0jUh2IlSDWgm32xo
 cbsN4Ig8/8z8AFx2J+XB12tejsO3TxvqwWgHrFQ0Q7Vx013Ut7W1XLNm/qqCP7eyAyPC
 IPm0QRLzbUNvSRPomGovVz0DgC9UtqjsqxzhQiCf+P7x3SwdqG+VZrwV5hgbA58BK0rk
 xyaXctJN3+pxDfzJNKZicoPNOBnLea+51SFJahA3NttmFiZPavaIEua7+jbJb1Wb3ddj
 8gSl8CeJQUrMyCilxJ8SEXkWZtVL1iqFfAefN+yqr2tSbLHcxF5nbwfCZVaC7Q0MgVkC
 niLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784299575; x=1784904375;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=08ZBCJS405WG1KCU01eG02f/rpP6Q4IMEXm+HV9RY6Y=;
 b=G2YWN8Bzhk25zn7e2TQRVfGRS5L9O5hey3xMgUuRiX/vBEcUNPfRcYEfKZnacaLRPk
 pnFLA4WAQY9isYjCvNcJXOkovw99JDauYsWI92B35CIzmck5loukNa3JBH9KItUL3dWq
 DdOz54oX02hp/8echsN9txmAkYERZ0QmLJuZpFv6kFhCxySUJorsslbMWjHtEB1Pj3FO
 lJHjNT3L3CffZWK0EG17CVB1aRDu2mjMR+OrhRLUqaIo5iYZkWylvE7ExLoHj+4MT474
 cs8LwYy9RUaEFEaW8jUD+B6zPVdTMpKMVSI7BjO5lUaYwhDr1PKn2G+D+14uBHKKPtdr
 aPBA==
X-Gm-Message-State: AOJu0YzXYxIR6iLKwYj8eW4P500unz+pDOW/R8I0phaSgBx5+d42cFUO
 JY9MF7aVBerUfeI0I0EEyU+uiY8pS6n1pZHJW2HvFsYeaEDcBXgDf+41J+f0BmaPyWIsjeZqh6J
 iE3xbG/1WVmOnoG3ZRb+aSWq1k3JA56jXet1FecPaPZ1i32YzLCDMNsedR/TD+ZzBhCLF
X-Gm-Gg: AfdE7cmqH31+oTGfV1ab/b7UK40ivjpsbjzIiCYymNSjtya6aqdYKJxXlKRVgcQLzNo
 tJSqfzL4FVrpZ2xSgT9M0HFnTLw9+jrbfBDlx1WepcbhzS2IWeHFGFR/c9g+zLYWT2FrIDroufm
 ws+o9ALSE1ks6dyeadmFkfMGz5CbojclcQuTFzOHJf1Y46MGDO2mXButC333kbD1VxcvymQZ60Y
 m8Apwt4ItY9+xpYeixFlf48045V6xvuyV09hkdGKoOVjPHlqOXJapuF3GGLKWHiAyDwG37kJsXc
 duEA8DUrcZ6FYlVNMNHO9E/XtVtyaQeoxbDuZU881EgJQAw26vw4o9dqt7NrpA3wylfI5lNL6lZ
 YzCRAPtGVFDlzJKBKlO6s6DvCoeXL1Rgxr3OotU7D5p1RJjHaGOusumRDElVGmcfWx9CKDN0YXG
 9QQl7qbORmdtIyYJniB5mWuS2TyuVgd7gHThUR8lGohurFWA8lsSt7+6Yf1vorbijQyTj71xDil
 foDudPQbkstsF88I88hKKFjMZlet1mQi3vy3DJJMuZWcY/XlACN5MWmMwyWc0SGfjJ8WS5AtQWZ
 tP4=
X-Received: by 2002:a17:907:9809:b0:c16:2750:fc43 with SMTP id
 a640c23a62f3a-c16b47fe55cmr135009166b.49.1784299575151; 
 Fri, 17 Jul 2026 07:46:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69e70013a00sm838444a12.31.2026.07.17.07.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 07:46:14 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 14:46:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 6e4746b5ad1e73d7bf95b650d780b7a07e7a7506
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 14:46:13 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c2b98ebb842474411740532c7d06eceaa70eef13-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkjpb-0005rM-1L
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
Content-Type: multipart/mixed; boundary="===============0620755711065658105=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0620755711065658105==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xg6aS8iu6PI="; charset=UTF-8

--Xg6aS8iu6PI=
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


Patch Set 10: Code-Review-1

(1 comment)

File src/openvpn/list=2Eh:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/af26d1b9_c3019f4c?u=
sp=3Demail :
PS10, Line 61:     void *free_ctx_arg;
This seems to be unused=
?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If47c7d920b2fa40=
47b7db03fcde821899839324d
Gerrit-Change-Number: 1571
Gerrit-PatchSet: 10
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Fri, 17 Jul 2026 14:46:13 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--Xg6aS8iu6PI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 10:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>1 comment=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/list=2Eh:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/=
comment/af26d1b9_c3019f4c?usp=3Demail">Patch Set #10, Line 61:</a> <code st=
yle=3D"font-family:monospace,monospace">    void *free_ctx_arg;</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
This seems to be unused?</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">change 1571=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If47c=
7d920b2fa4047b7db03fcde821899839324d </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1571 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Fri, 17 Jul 2026 14:46:13 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--Xg6aS8iu6PI=--


--===============0620755711065658105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0620755711065658105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0620755711065658105==--

