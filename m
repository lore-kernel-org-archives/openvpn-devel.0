Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7B0C531D0
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 01:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IipcX4w5fbpKvU2VsZ7R2HzRVOuBEwIbrcKC6710nWw=; b=LC/rEgWBaybAUqVTdoHzpOmrss
	sQrxBL7dhke4Vdk7nX+jFs2Dt4Ya5T0wq78UILfqR10syCkIfBIO0TdSwxOT7BXRobVUCVEFNk+jd
	XvCJ233jnQ4N4/YOudZDuZs/piZfmD9I6sTjEkv6P0n9yPI3vc17n4ILPPMlPldY7yWE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnnL1-0000fn-2B;
	Sun, 26 Jul 2026 01:07:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnnL0-0000fW-2v
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 01:07:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yA5BIsRl+C6yF6uxSuQ2povAfGswAIxPuOm4+GmNTB4=; b=li/X97DMzn5Clyiw/YaRsI6rIV
 0MYrfBhSLX+CBClucFTNEn9OMHGanzLgUHwG/EPetgVcAieg++OxtUkocboS/4n1YRh7EetWx0AP2
 KotwQoSHB6K/qEItgc+t5IqAAwKoTrI+YC+/+re5arQyOcgztDThavlz4b75FL8TdQDA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yA5BIsRl+C6yF6uxSuQ2povAfGswAIxPuOm4+GmNTB4=; b=W
 NTiam2j4vh/I1oAQ3ZqGApLUVQA+twrEy5r4mlAoyGzaOS45q9xo0WAalp0TfW01b6a3hfcb44lvx
 yiFdlUr3/WSymyT2KynpldiaDRSw6ihLrk7/38JUM1F5ZcK0V1hi7/1x2MLOKMLptIyy0hGukV1u1
 XmR/XYcDc3uTlXEE=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnnKy-0001QL-9T for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 01:07:28 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso15170455e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 18:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785028042; x=1785632842; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yA5BIsRl+C6yF6uxSuQ2povAfGswAIxPuOm4+GmNTB4=;
 b=GnfBdi6glEkMBn4bpZxGdsD5KJUVDIslzvNUxotviA7WMgCUIDY2ah3vKWbNJj82Z0
 JErjlXBTOnwPGW2rk60J/o0qxGY9ZV9obeDV28wKwVx3+SMgfu/UZS1Z0peGZc33cp5j
 60T8dYcfNz6XjFeTlV1nnKElafzZC11QcjA/IjyTvCLwnyBUL1BsKbhd3qRe0vrMOKjF
 CjPChk5UjvDS4XZruMZntx9nsSAc/jNlAaplqza+eJdZqDmfeg3nd1IbjD4w8Yf+eioj
 0ZOZeK6iazu0pV/khDm1+I8symeBfm8YRICsbIkk2dVogmLKufboO3gyIm8FTeimyX0r
 39VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785028042; x=1785632842;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yA5BIsRl+C6yF6uxSuQ2povAfGswAIxPuOm4+GmNTB4=;
 b=bxfVOcLe+lqDRJt/5W7tStJ8r2WZMW8FW4GWxNN2dUfhcWEPc+MHYRGWzgl4E3VPoV
 8mYshPHDVA3GtOjvLEWYgy8G3soe5X/cjHo1BsG6vtlW6uJWLtGJCrDcZRmvny4cD9pn
 JSoJzm/tnNSdsU8maxYZMUKMOFLQlwkkmEgBtP8KUelO69RA1g+CvdkwMBKIC/+DZh/G
 iJitRc7h7RYhHiq4KxITHiNE5exYod1lQ+3pimKWHLCXyrA/aiN4Q87VW2cAgejsFaaB
 uDGni2H+fH9t4cvcy/VsDIxR6d0cLY+1UxssrGMNfMT/89tg9HT6aIfaazm5t1UXA556
 w+rg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8OdRKG6uR3/rBH8WMOZHIltlGwdF3PPgssJxn87+HqR3S+c23RYqfv0hUcX6L5lLaNOaaNRaXP93vGoIl@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxX1tpFCibDZUb791FCipuaRg45sASZhmWmOokniagTas6DQFie
 xEJ1AlCW/57pBliRpkdEyCX5TPIoQ34BHArKtC3FkbBJSg2pJ8ePysELoDrwbyRPBAJZth7rITw
 UcHn1yVVjlGizLn8TCmef+6x1YpfZLnr6M8odM0PPEVOslE8OWyfFyakNwPW0xRRyBMz37PEw3/
 OKM1oYiA==
X-Gm-Gg: AR+sD12hqMsPl6kBn4EUFttLEXZ8Dc47l1OYRA2U7SckgQYEt43DPbzGlcoqXWDEkk8
 ihL7j4VgwUi4Cu2UR6YUvwgc1nRgIdsUYZ5XCeVEBsgvpVQrn3/VQZ66n4YbpOUEtqCWm01mWJu
 chmpwxqiuCK56Hn90+ppr1qZecwpzXxes5K9l99u3c32KKrYBdVX02BE2KttxvYtyNQ0MNn3uK8
 O38uRymOpRX1PJbizVIwTypNjqVs4kovA7yOU0J4sK6Mu27OtrkI5mACyxubcruTgbsNXmHwjOq
 w/MbL5OCH+3I6S3IF8cF+7UyH+3wya23LIKgTVxriPjirzPfMgJ5rrcx0ibNQvOKIoB9UeWpPAK
 +rTKdJa9TOgvAvaAHkTuiSdDMwqu2qWRRX1t4aEkHZekFNq7/LrNHOtGIYFsfxssFLfulEXOTIf
 kTpIgB1q14Vyy0RCX6ATp+D0DlqpPJbLqYfl0+h4lPtu/V2k1AVdWEOYOypOJrG/4c/EFJev+/C
 GtdAy7t76jw1GJifXedwujUh6TEl1zBI8zwcrGPPkuosqpgz0SdisueygsNwoLnYo+i
X-Received: by 2002:a05:600c:1553:b0:492:6f6f:fa42 with SMTP id
 5b1f17b1804b1-496b5711f19mr45976485e9.37.1785028041641; 
 Sat, 25 Jul 2026 18:07:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b49b2ffdsm101543285e9.15.2026.07.25.18.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 18:07:21 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 01:07:19 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 2e79a47e4bad09cf3952c4df0be13742908f2437
X-Gerrit-Comment-Date: Sun, 26 Jul 2026 01:07:19 +0000
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6e8c4e1838349fb788d907545584fc8b8bde2453-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnnKy-0001QL-9T
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 SERVER_PROBE parsing and the probe-reply decision
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
 frank@lichtenheld.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4849463267443881687=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4849463267443881687==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ktEZuwTSEZM="; charset=UTF-8

--ktEZuwTSEZM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
742?usp=3Demail )

The change is no longer submittable: Code-Review is unsa=
tisfied now=2E

Change subject: oob: Add SERVER_PROBE parsing and the probe=
-reply decision
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 8: Code-Review-2

(2 comments)

File src/openvpn/oob=2Eh:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/901d01eb_60ff6821?us=
p=3Demail :
PS8, Line 161:  * skipped, so the scan tolerates additional/fut=
ure TLVs=2E @p payload is consumed
the scan?


File src/openvpn/oob=2Ec:

h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/c2c75c09_6a659319?usp=
=3Demail :
PS8, Line 226:     }
I think this is harmful if we drop them unc=
ondionally=2E We should probably still accept them but maybe at a much lowe=
r rate than ones with correct time=2E

Otherwise the goal to eventually be =
able to replace the reset packet with these new packets will never work=2E
=



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iafa9efc1c156974ad9=
f5752e9de810a8c2f68c30
Gerrit-Change-Number: 1742
Gerrit-PatchSet: 8
Gerrit=
-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Sun, 26 Jul 20=
26 01:07:19 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--ktEZuwTSEZM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>Patch set 8:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #ffd4d4;">Code-Review -2</span></p><p>The change is no longer submitta=
ble: Code-Review is unsatisfied now=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change</a></p><p>2 comments:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/oob=2Eh:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/com=
ment/901d01eb_60ff6821?usp=3Demail">Patch Set #8, Line 161:</a> <code style=
=3D"font-family:monospace,monospace"> * skipped, so the scan tolerates addi=
tional/future TLVs=2E @p payload is consumed</code></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">the scan?</p></li><=
/ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob=2Ec:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/c2c75c09_6a659319?usp=3Demail">Pa=
tch Set #8, Line 226:</a> <code style=3D"font-family:monospace,monospace"> =
   }</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">I think this is harmful if we drop them uncondionally=2E We=
 should probably still accept them but maybe at a much lower rate than ones=
 with correct time=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Otherwise the goal to eventually be able to repla=
ce the reset packet with these new packets will never work=2E</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1742?usp=3Demail">change 1742</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1742?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1742 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none">=
 Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 26 Jul 2026 01:=
07:19 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></ht=
ml>
--ktEZuwTSEZM=--


--===============4849463267443881687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4849463267443881687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4849463267443881687==--

