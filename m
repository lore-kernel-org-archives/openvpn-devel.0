Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A85C9832A
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=62yfgpSmd4BfneZUIVcVrfaaWDo+rAFcTgQWvu7wfuU=; b=aPSEbagqojuN6v
	Gf85kPSpAeRo12ufM2qsRErb5jYBmJTF0N8huhXJ5FUJNyrVDA6QOJaQ8/DOO+pbRcXpKVTlZws3Z
	7THRWI2XyDTXj6yGfVxnWe8oRzOwEznumo2Yu9fzpD9OYM9SO11NCXQhp5OuR8ijhesj35hjoBiul
	r/4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBZuD-0000Px-Q7;
	Tue, 29 Sep 2026 15:38:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBZuC-0000Pr-Vn
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 15:38:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EM2oVgRcCvj0hGUl64tHggQtDFWNCKYCJXQPuj/rYD8=; b=IGpWVtmr9y3g/DSlRO8eEcXOLF
 c+ZIlYODxL3Zpgr0ulJyojdHASlIqKGZ4GbCaQHEQJge8CKYXyVePRx591ZE4l5YYLcB5PpIklp/H
 iz9GkS+IsNY2F+ZXX/G9BS/Dks2aP/9vS6xGu9ac5+s7nTpUrxk4e5qKGjpOiLSzlb+8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EM2oVgRcCvj0hGUl64tHggQtDFWNCKYCJXQPuj/rYD8=; b=C
 jKpbWwfyayonHfAUGm0Iw5M9puizWWTWeH9h9XAXyQe4q8jF3JSsZiuL9hQLvGk1NFeQ/5X01wvXQ
 TpecvAq4fWZ8VcVusOnb8OWUI01WHMcj52REIHoIOt5M3eblbSK1LSjRtM4MgZ+e0ZmWAOtwSDJeH
 nOZGsglLx7hzqcgo=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBZuA-0004G8-SL for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 15:38:09 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so32590585e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790696280; x=1791301080; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EM2oVgRcCvj0hGUl64tHggQtDFWNCKYCJXQPuj/rYD8=;
 b=ML1jTQmg5g3cJ/sXqonkLQDRZd/AhvL9dtxByo2har4Kc4U2hNaXqsQJOTrTZyCoeg
 6qHRYa0ROOL7/CY2D/Dl7tGvwrAfTqsX19XcRi7Yo5ZGb6EyuAczFFwIEViiLmNqGOOw
 iTV/i9Mqr0VlKWvufEwXnCjfCykVwAgoMqcICaAXeUn+hVRp3/m1hhG2yepHpcIxEMTP
 ECGZpC4CyhsGaZ0CWQ71ra3kW9o8FffqyEmILPOoQT7F3lvI/9j2T315qPotM4khT7LU
 /mbmokhT/0nSDC3aXecValRcfuTBM7sl8HfQK4FEUFpYmqV9KMMx8namzTRhkk8YyHg0
 S4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790696280; x=1791301080;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EM2oVgRcCvj0hGUl64tHggQtDFWNCKYCJXQPuj/rYD8=;
 b=uGJcQfrc1TKFE/Pab0OPPRenpdDgRqtowhe3RfMhbPQDPStdPjKW2f3bejlZT94js9
 SGKdgoDmQo7XExjH4Pu5ny9RR2QPPLhZpPWErRzN50H0dssBCQIIVFZ1ldLCa7hOz8sL
 yJKdfDL1qF4JNKcqfA3+h2iXpZ72XcMkExjjxhts2vpCKpOMJiqrFe5U4DUpvumdRfT0
 O0q1tRh9lVYD+qlSSAn5DHixg6l0FreWvcHJmZnPLLSmxJ6N4/QO0YntF1yaLujuDF6g
 KFux6c4HashGGxsUtrvTrgRa2Qv+gPRdfti7dRVSX3PrMkPpJF1gHrI2n5/BN6P+eB6T
 OCiA==
X-Gm-Message-State: AFuF++ls4BrCtArQ1IwiU157CsMs01+XOPlEfaaBuhxp18mNTYuxSYoU
 V+5RiOWO9UHxh5C0N9MA1m2dO+1MkOy6TGeCgyILPSK3EDztezl1egw8EgPOKJGy060eNlnouhl
 vH0T3duQ5NqfV58wLF4FV+g9Jlzl/awP6kwTl+NNOMWz3A31uInB/D5AYj+DU+fesQIfH8WExOr
 Q/qV30ew==
X-Gm-Gg: AYBFou2lkRVOmKZRVfzmNzOIRGXnVZ3YthsbUUu+SuA88JzCG9adSLdKTWt1kRxlOGx
 eql4WRuECUgKSh6v86xoo3dTr+uEjFr7HmJv7ygwqNscdp8C+fXga57qs/V/4UUeB9XVN7i7+4L
 dAO0jj344dwOske0llB3LHkDukBQMwo7p1EfWCGbOGCEHY/QzBS64dyAcAyxzd9279nKvL1Pi2Z
 WuiufPvxhhPggtewGAAAXpEBfEn7FyTwW/LGT6ClFstyVh8RhVFkjle2+KYNz3bA/28GWdl+iok
 4UnnoND3tX33hyCAyqRsjPXT03iKYa7UfOVS6VnpoLOsRwnegB4Q6FL3TWfErRSkZ3uSr6MTzWD
 GK0FM3/gXNxN55IUuAwyuDp6jgYuUBjJPGmkCUO9B7IR9CDKUYmVhhLetO3hREVIbHM7uTEV8xA
 HRckPxhRLLAi9OJTzZgzwq8Dn4FQMnwk8kr9k2ZYuqHeyaJEE3WwOigu/lyMujDi3swF379Uiy3
 Cm/BjP4kH/WHp4RK6E6cW1IozEGJ/SCZza1b+Y3s6yTtx/cMMPna8ZOIPvmGXneZzYCKpsJ4bR7
 489tHy4NEe5/3yECRPkyphAEhpu71gDm7TcmC6SLAgBH+al5xr5cdSMNv6gI
X-Received: by 2002:a05:600c:638f:b0:49e:799a:8951 with SMTP id
 5b1f17b1804b1-49fe66d1674mr281886145e9.11.1790696280077; 
 Tue, 29 Sep 2026 08:38:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013d3f823sm9297245e9.4.2026.09.29.08.37.59
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:37:59 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 15:37:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I924a531c69921cebf563e7ecfd8177764ecc38cb
X-Gerrit-Change-Number: 1964
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1964?usp=email>
X-Gerrit-Commit: a27a40fcd6a533d3c09e84f18350687841aaa995
References: <gerrit.1790696277000.I924a531c69921cebf563e7ecfd8177764ecc38cb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjk2Mjc3MDAwLkk5MjRhNTMxYzY5OTIxY2ViZjU2M2U3ZWNmZDgxNzc3NjRlY2MzOGNiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9e0908ee4eb61b174751ea19e18a9199edae3957-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBZuA-0004G8-SL
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Add check for
 termios.h to Cmake
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4832180945447247093=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4832180945447247093==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AkyMN76JVZ4="; charset=UTF-8

--AkyMN76JVZ4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1964?usp=3Demail )


Change subject: Add check for termi=
os=2Eh to Cmake
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Add check for termios=2Eh to Cmake

Without this the client will not a=
ble to query username/password from the
console n Unix platforms=2E

Change=
-Id: I924a531c69921cebf563e7ecfd8177764ecc38cb
Signed-off-by: Arne Schwabe =
<arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M config=2Eh=2Ecmake=2Ein
2 fil=
es changed, 4 insertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/64/1964/1

diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt
index d553697=2E=2E21528d5 100644
--- a/CMakeList=
s=2Etxt
+++ b/CMakeLists=2Etxt
@@ -274,6 +274,7 @@
 check_include_files("${=
NETEXTRA};sys/uio=2Eh" HAVE_SYS_UIO_H)
 check_include_files(sys/un=2Eh HAVE=
_SYS_UN_H)
 check_include_files(sys/wait=2Eh HAVE_SYS_WAIT_H)
+check_includ=
e_files(termios=2Eh HAVE_TERMIOS_H)
 
 check_include_files("${NETEXTRA};net=
inet/ip=2Eh" HAVE_NETINET_IP_H)
 if (HAVE_NETINET_IP_H)
diff --git a/config=
=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index c6c0a96=2E=2E1414297 1006=
44
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -324,6 +3=
24,9 @@
 /* Define to 1 if you have the <uapi=2Eh> header file=2E */
 #unde=
f HAVE_UAPI_H
 
+/* Define to 1 if you have the <termios=2Eh> header file=
=2E */
+#cmakedefine HAVE_TERMIOS_H
+
 /* Define to 1 if you have the <unis=
td=2Eh> header file=2E */
 #cmakedefine HAVE_UNISTD_H
 

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1964?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I924a531c69921cebf563e7ecfd8177764ecc3=
8cb
Gerrit-Change-Number: 1964
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--AkyMN76JVZ4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1964?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Add check for termios=2Eh to Cmake<br><br>Without this the client =
will not able to query username/password from the<br>console n Unix platfor=
ms=2E<br><br>Change-Id: I924a531c69921cebf563e7ecfd8177764ecc38cb<br>Signed=
-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Et=
xt<br>M config=2Eh=2Ecmake=2Ein<br>2 files changed, 4 insertions(+), 0 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/64/1964/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b=
/CMakeLists=2Etxt</span><br><span>index d553697=2E=2E21528d5 100644</span><=
br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</spa=
n><br><span>@@ -274,6 +274,7 @@</span><br><span> check_include_files(&quot;=
${NETEXTRA};sys/uio=2Eh&quot; HAVE_SYS_UIO_H)</span><br><span> check_includ=
e_files(sys/un=2Eh HAVE_SYS_UN_H)</span><br><span> check_include_files(sys/=
wait=2Eh HAVE_SYS_WAIT_H)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+check_include_files(termios=2Eh HAVE_TERMIOS_H)</span><br><span> </sp=
an><br><span> check_include_files(&quot;${NETEXTRA};netinet/ip=2Eh&quot; HA=
VE_NETINET_IP_H)</span><br><span> if (HAVE_NETINET_IP_H)</span><br><span>di=
ff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><spa=
n>index c6c0a96=2E=2E1414297 100644</span><br><span>--- a/config=2Eh=2Ecmak=
e=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -32=
4,6 +324,9 @@</span><br><span> /* Define to 1 if you have the &lt;uapi=2Eh&=
gt; header file=2E */</span><br><span> #undef HAVE_UAPI_H</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if y=
ou have the &lt;termios=2Eh&gt; header file=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_TERMIOS_H</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Define to 1 if y=
ou have the &lt;unistd=2Eh&gt; header file=2E */</span><br><span> #cmakedef=
ine HAVE_UNISTD_H</span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1964?usp=3Demail">change 1964</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1964?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerri=
t-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: maste=
r </div>
<div style=3D"display:none"> Gerrit-Change-Id: I924a531c69921cebf5=
63e7ecfd8177764ecc38cb </div>
<div style=3D"display:none"> Gerrit-Change-Nu=
mber: 1964 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<d=
iv style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--AkyMN76JVZ4=--


--===============4832180945447247093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4832180945447247093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4832180945447247093==--

