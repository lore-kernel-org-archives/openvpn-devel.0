Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A34C531D0
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 01:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j7LWdhNBEUNKzkWHS+lXtx45qO+T/6VzL8HxPU1KWPE=; b=N9lCOpp2dJ4aeksgK4SVXFx3tF
	39FM6kH70rdvOaQvoUihmzVFWxkG5yv67mLGWUrPtQupl+lDMIYuBrq1VKvKWhvqHsDE7MsbQ0P0W
	Dain+euLPmd+Ve97y7B8VRgx5Y2B0KU7o5+IaJPMcbJ4E7Mr9kr+vuH7YHQMktNIn4aI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnnck-0000kr-KK;
	Sun, 26 Jul 2026 01:25:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnncj-0000kk-La
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 01:25:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9vyp95mw4kCOP7T2z94hxxPvUbBEvwZxP8e0kUTqg7k=; b=VMjGPF4AZuTCtzVN2/6bWRmi5M
 phptDJHzOdNUrOIhhMdkSh65Q05eA5VW5XK78SCpVjlc52O3jwqrnYPWuHgDU9VWTia+3JSid5uIt
 L1JyFCpVzgsLvg6yWTMT+YSHy0pRiAPAJNZKfE/FlHXH/VUijS1mdqHv5MTPfK8WFRYY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9vyp95mw4kCOP7T2z94hxxPvUbBEvwZxP8e0kUTqg7k=; b=O
 YHWI7DAAH5S0WQmUXerfknKLzX7WfWxZZoK4x2fSe/8ze/8xBjxSxXifjdIXfcsBnNrEWSLIdVQBS
 jZ08r2bkavdC15QULYN9SOWaFuo/FnmhVk94jRu/iKef7RBwdyej/y7Jc4VeA9oU/4pXut4WVJxw6
 KSO9rsSr+f6TF9fE=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnncm-0007f0-Kt for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 01:25:49 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4954c0833b4so12090725e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 18:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785029142; x=1785633942; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9vyp95mw4kCOP7T2z94hxxPvUbBEvwZxP8e0kUTqg7k=;
 b=LzoN/1nOwUciDz/Qwy2hyF6AEOAA2mW1ui0A5jj/jhbjKUTPvG8L/sDtRyx5JlFieW
 KRbv/zUwHKTFKT6gSTpjxDvQQqrARFICnbdqOvpjEdDXUxfXvz3B6XfYEnpID3LHt4T+
 rYz4dER23jzXk2MZKG4iteZ/6x367FAfubyrRLYkFyJTbWx/nuyAyDNvqM/RW2GrR2QX
 VCUh94egsm7T4z75QHZ1qSmT5V+DEGfxw3I6Tn8Fcdp8wOjmlAEn08GMcy4/11jMcAYE
 m7anqxks8fMpT64O5zP1nwGzXUG7lej5L1AX5Kqd3WobNO4oyt0vGbK0VX/AA18ygQQr
 iraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785029142; x=1785633942;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9vyp95mw4kCOP7T2z94hxxPvUbBEvwZxP8e0kUTqg7k=;
 b=aOnnWYAO0H9LbxdMGNEMEZYqxfPnq05nq1qgGEi0WmyZzKhDSRQZrAsfM7paR5Q/wC
 JsKrS8h5aIEs95EekCC9lEBAIRH6kqEbr0uDjq2WBOBYCDoqKURRhd9Q1UluXlHzIE3h
 6hq0uslsPeqRZoav+4AL3jQnPk5VpHDJhg8/U2kGK6xrvYw52jioq3XEDyV54FXtu3o5
 +k2KSSC8TsKvvDoA5ENM+fORi6/mUViAscM1N38b2mCCpTN6YhJieFpzzNYXDKzMd01g
 YpwQtr4IS5Oos8MIMHzuIFrhAz7MleSPMuVMEI/v3qpAG1sIR6Gyonekts20Uur81YwG
 cmsg==
X-Gm-Message-State: AOJu0YxVJbmqg1GPDvFSab45NcQ6ra/GzoBsRgjO33NbrFhV6mn1jRUl
 A97mdzYQQ1yU7RJbcsOuXYGWrKlK+GE+RSr+KQHAZDdE/kGniKiM/cgQAh8P9NwLyXqzMFyyEXa
 EvramUGhSJPYby2OFhbQbzvB1pAhXkMaxSmtdLFIc5ZTtSA3eeoIa2EFjnuzWD4NDqBHraTOEgz
 XA8Z0u5g==
X-Gm-Gg: AR+sD11PTKkUD+IxL78FyVzLfxjxZ+I/OS/+Kq+Tu+hKGwA0EW6Px7YGNUB1+t5ELkj
 cr6ZaH1gkHwtShSTzEJrUYUdthnVp45iFmMzbXRhuDEwtobWLVbwHz4b/NBqk7nuP5YU+waR5HC
 O4IMbqSbayaWtctk0mMBpOSJlljD1jOhLi2DkYVsTvR4c3HHGNHzNsvF6AR75eicBnuPNRjoieh
 Ep1Y+U+4dsq/O/mCAiKO/c3I6dGNnxfOMi2kBMBDVh9h4VZv23df8prh+zgM1xnYipQuUxiUdHD
 xMISysGwxiI3rhFZC6H31VutqW65Hjs7XtIb4fn6qEuKzDFodfK/A+bb49jcfDQK8++X5jttdIF
 O4j9NSlxSMbRDENihqgng2z5NftT9MS48WEWWgvycARjzvvoyBlCBNLvBglAPbt9uDcgv6tMaCx
 DUzAdSApyDeUiJJTFzpl3qdb82VkQaST6cBv4E4vnfaExeoh1OjUja+Dsuu86fS+rfP/T6j7PQF
 LhNLPWHOKh8GP7ErhcdQ6jZtrgSGmvGqkrISSOKqY2NUE51pJ+Ty0zUw0E3OvEfIEDr
X-Received: by 2002:a05:6000:200f:b0:47f:9201:6409 with SMTP id
 ffacd0b85a97d-47f9febc866mr4173841f8f.40.1785029142468; 
 Sat, 25 Jul 2026 18:25:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c52fc0sm36170330f8f.23.2026.07.25.18.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 18:25:42 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 01:25:40 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: 02d01e3b98567bfaf5e65af63da53c7b8fb77c97
X-Gerrit-Comment-Date: Sun, 26 Jul 2026 01:25:40 +0000
In-Reply-To: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <44793df272620f403e82a25d76d331b63066e55e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnncm-0007f0-Kt
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 probe-result ranking for server selection
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0412527433010837557=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0412527433010837557==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r/+MrRzN9Nw="; charset=UTF-8

--r/+MrRzN9Nw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
746?usp=3Demail )

Change subject: oob: Add probe-result ranking for server=
 selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 9:

(1 comment)

File src/openvpn/oob=2Ec:

http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1746/comment/9ed728f8_d40ffac7?usp=3Demail :
PS9, Line=
 268:     if (ra->responded)
I think if you started with 

if (ra->response=
d && rb->responded)

and make the logic and intent of the sorting would be =
more clear instead of this double negative logic here the function would be=
 much easier to read and understand=2E



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
Gerrit-Chang=
e-Number: 1746
Gerrit-PatchSet: 9
Gerrit-Owner: stipa <lstipakov@gmail=2Eco=
m>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: stipa =
<lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Sun, 26 Jul 2026 01:25:40 +000=
0
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--r/+MrRzN9Nw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1746?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/oob=2Ec:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746/comment/=
9ed728f8_d40ffac7?usp=3Demail">Patch Set #9, Line 268:</a> <code style=3D"f=
ont-family:monospace,monospace">    if (ra-&gt;responded)</code></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I thin=
k if you started with </p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">if (ra-&gt;responsed &amp;&amp; rb-&gt;responded=
)</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">and make the logic and intent of the sorting would be more clear inst=
ead of this double negative logic here the function would be much easier to=
 read and understand=2E</p></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">change 1746</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I55da6=
8cc341bcfc707fd34ca2f84ff9b6a55501f </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1746 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@g=
mail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 2=
6 Jul 2026 01:25:40 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=


</body></html>
--r/+MrRzN9Nw=--


--===============0412527433010837557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0412527433010837557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0412527433010837557==--

