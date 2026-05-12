Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3B9CD4F24
	for <openvpn-devel@archiver.kernel.org>; Tue, 12 May 2026 15:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cCssqnOlj7EfMb6Y7h2Jv5GwJV5yV1y60Etr3QtluRs=; b=eWlotFL5LJ3mIVV8v4I+X5viRH
	DzCDZQUY6j5oqb9oVC3QZxB1+pkM2Tr1nBzPTlKWqCUk7dn5PAco4gpkjt2yA5u/lxNsFlnUL0E0V
	W7tyO9Ce34YSqCC1EIH8o23SJJwJPJAY+m0WxEigWtL6vY5qZe2qpuq/A0VDLLaFi1OM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wMow3-0007rf-IW;
	Tue, 12 May 2026 15:22:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wMow2-0007rX-E8
 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 15:22:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oU4wHs91pN9SCy54wdhG6SkYdd7536yroMVr1FXaU9U=; b=nFlZT9yPbq1UgetAd2DouQbywb
 t/dT0m5kbG/SQOvqGp/W/b5tWUrEUGVqtaBn1T4kjPqrwSi82GzepenEuMS8ZJvV6u4d2S6kXujli
 4m00PNt9g7J8+f4ikSY+fxXbJHQ57XrM4Df54+bunpF2d3ZkeGOTl018RvSMc0TaVq74=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oU4wHs91pN9SCy54wdhG6SkYdd7536yroMVr1FXaU9U=; b=M
 fWN/+JGeseZAe36wBATuZoXNU0A+cCvrZzPZz7Y4Z+ngF14oWj6UlvArkueEmRn20GqPJtLe2aMyL
 zij7icrIU11Fpx3cUU/C44Jfr+6ofPdb6N/KzJXYnVHkdQtk0UvG0L5hgphIh2TXTtlHh8nrccLkf
 2o8rPSiWhVpaqLx0=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wMovy-0001ON-2e for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 15:22:15 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso40295805e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 12 May 2026 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778599319; x=1779204119; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oU4wHs91pN9SCy54wdhG6SkYdd7536yroMVr1FXaU9U=;
 b=CzenO/HeoaQbnL7Ih7Tgr+Xwp7uEUaPHgPxLy3cDb/WSUHALIDaloZSlPzHXzGQGC2
 RmIxh4n7YiS9xdq4Ts06mNX4p/Hz9f+P2Q0mcA/nejn/VtreB55zSdEmCOwZdnSdq9s4
 +WVVMV7GcCqYneGeeubl9Q5fk+4O6JzSlcwOeAkJAmUG40GFR9iHqIYAGiclld5dwMbc
 uuRhda6lMtiiMFT546PTcjkHVpc0CwXq91PFoHOup/YYNYMhcOYvSZmPXhFd4ncO6bhp
 7hg3Z5AqmuagGyfl0XpuGTL329F2Y5y/mye1HH13tvXiiI+T0vm6FMPN8Yp2iK1PGWnN
 yOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778599319; x=1779204119;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oU4wHs91pN9SCy54wdhG6SkYdd7536yroMVr1FXaU9U=;
 b=QmdQLMG6SubhFr8ZpiKrQ6YvfCdHRvVihq5uFbdBCi3wJ1Cm3F5LO+Mi1mmpaQiGdU
 kNxOG9ZFDEVL/njDfipatZxQru/iHiVGbv6VJC00RySGWCKVQD0Th3oVzSlk0sKVlGZ9
 bIZ//89rf93oTGWK9xGtukGGaltKwjRUku66w/sdfT1Y0gJsBSumgwtamXJsCUwS+5/m
 TZJP8iCnSH8+4kp2HDJZAMAWidU27D/kIbZyo67lwuZaBRiEK8JZlL9q50zS8Q4hFcJ7
 TvFF2sANwcmn4Q+nPw3HkULNl1MmgQu0NBciAcaB1Zpt6J9TMHsaaN6bxLgBiYWgllAa
 FiiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ95OvDuctlsGYeSxIyLtvK+Ijd34Pq2GIUJmsMOQERrojt2L4T2tY8TsV8OluOqpV4y56upBQ4UI06ahg+z@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy5TWTv8ATIr89/jtbfHFuGGGW0nOcD6caCCIXm+GMkxs4lUZ5d
 TlNcgEp6B7mflYizBa4noYW6cXJLpgju7siB4VC7KFHmdq3nDNZmHMqGJ1/qF3Sw0yhKwvTqaE+
 asMsDogUYmPHUORLEsxgTO9/iu4NqZxfwFIENYSBAAaDwstkGHIDnueCfORR7uDz3zMtQ
X-Gm-Gg: Acq92OFrqQRnYTBYurutsqI+eQ2lcfSKDCgV+aRYlC38XrENBU1tHb4d7lLG2eQcUki
 4sSW/j3V34UA/BYREJWmCbbiSccTBg4QksNyBoTGtMaJ60t4WYBk8zpnP+q1fjAKtISbA24Iu4p
 cSQ/RZLkS0H5gxRWo2OhuCPD4STJDnkcBuiMdRPitby6M6znrtzLnhKLtFrIx5MmZD9sqI8trQ3
 2XPDxLWKK0XYTeJQ9DH4qX8b8gMXbxHbCGIgr0WMWMXKqt9dAuVOnP9TmKu0m9fMXFJwV8fAe5f
 RxuaQHPWD7AAJOytRo1/Pr1fxmYg3gPf1SN0tg7546aP8bru3z68X5rqxpp1o1mj2PU7NE+HmxD
 TNtOD8603eidkBaz+U5nL1+QsTDCswOLiUsSUNNi05OYscMYsPtUrdGIJ7+ihnR46ePa4fCU4A4
 C6cr/g7M3NiNMuK5S5O9GI1P4MWYMLiZTR5QgrnNttom4cQ2sG4yTbmUBAVK93rSTWkUX+vAcx2
 OdaF+MLI9/uWM1NP8NMBXbeLs5QltsEOptGoM2ChACDFDrGRixazAcNKA/lXm6CtVkZ2+shqq6B
 n2LTw2tMeCeJMg==
X-Received: by 2002:a05:600c:3e0c:b0:489:fec9:a17e with SMTP id
 5b1f17b1804b1-48e6768514dmr324389925e9.12.1778599318874; 
 Tue, 12 May 2026 08:21:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8e566bc8sm34281915e9.0.2026.05.12.08.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 08:21:57 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 12 May 2026 15:21:54 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
X-Gerrit-Change-Number: 1675
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1675?usp=email>
X-Gerrit-Commit: 940954440470a6439e9fdad2c08a7dea68510111
X-Gerrit-Comment-Date: Tue, 12 May 2026 15:21:54 +0000
In-Reply-To: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkliZTdiM2MxNzE3NmM5N2ExY2JiNGQ5Y2M4NzczNWIwNWU2MmM0ZjQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1097522f101e432bcd6cf2f5172d881b90de6b8c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wMovy-0001ON-2e
Subject: [Openvpn-devel] [M] Change in openvpn[master]: lladdr: Clean up code
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4437499394762143472=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4437499394762143472==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lPVF2VTm/n0="; charset=UTF-8

--lPVF2VTm/n0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1675?usp=3Demail )

Change subject: lladdr: Clean up co=
de
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 3: Code-Review-2

(1 comment)

Patchset:

PS3: 
OpenBSD does not agree wit=
h the resulting #defines=2E=2E=2E  with the patch, I see

```
2026-05-12 16=
:59:43 tun/tap device [tap0] opened
2026-05-12 16:59:43 
ifconfig: ether: b=
ad value
2026-05-12 16:59:43 ERROR: Unable to set link layer address=2E: ex=
ternal program exited with error status: 1
```

in my logs=2E=2E=2E the old=
 code does

```
2026-05-12 17:00:54 TUN/TAP device /dev/tap0 opened
2026-05=
-12 17:00:54 /sbin/ifconfig tap0 lladdr fe:e1:ba:dd:5d:2e
2026-05-12 17:00:=
54 TUN/TAP link layer address set to fe:e1:ba:dd:5d:2e
```



-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e6=
2c4f43
Gerrit-Change-Number: 1675
Gerrit-PatchSet: 3
Gerrit-Owner: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 12 May 2026 15:21:54 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: Yes

--lPVF2VTm/n0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 3:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">OpenBSD does not agree =
with the resulting #defines=2E=2E=2E  with the patch, I see</p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>2026=
-05-12 16:59:43 tun/tap device [tap0] opened<br>2026-05-12 16:59:43 <br>ifc=
onfig: ether: bad value<br>2026-05-12 16:59:43 ERROR: Unable to set link la=
yer address=2E: external program exited with error status: 1<br>```</p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">in =
my logs=2E=2E=2E the old code does</p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">```<br>2026-05-12 17:00:54 TUN/TAP d=
evice /dev/tap0 opened<br>2026-05-12 17:00:54 /sbin/ifconfig tap0 lladdr fe=
:e1:ba:dd:5d:2e<br>2026-05-12 17:00:54 TUN/TAP link layer address set to fe=
:e1:ba:dd:5d:2e<br>```</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail">change 1675</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibe7b3c17=
176c97a1cbb4d9cc87735b05e62c4f43 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1675 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: c=
ron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Tue, 12 May 2026 15:21:54 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<d=
iv style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--lPVF2VTm/n0=--


--===============4437499394762143472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4437499394762143472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4437499394762143472==--

