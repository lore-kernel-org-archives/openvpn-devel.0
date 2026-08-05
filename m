Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0CFC55ABA
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4X33Kp5OfwFAMdb2MzfbaXPz20EZsrCr3zS0P76El+Y=; b=DGnUK4X0cwMH1Wzs1TkVLrEA65
	2X7SSe91sp2L5i6MhxK87BTG0uT1ZZhsVxYd7xQcmI76Joz0NP9iBh9JvN+LolwhsAlRBvFk/qul/
	0JDEC+k68S+surpuJowxZcEKA5huQ85bCgWqLu3/q+T9K6uFH4Ky5CPRQXjnC/WJqc4I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrbkk-0000RA-8I;
	Wed, 05 Aug 2026 13:33:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrbkX-0000Qy-Q8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 13:33:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EbK4kZtg+tSsCk8TN8P1Of1ZhZ+aFvAQ0R/ckpdeF/8=; b=Utip7LFGqqvyo82MxS4FlPiIQr
 KfLInOwdeV+M8viZa4Y1IQiT81czK8GziOYTJVwSBdl3a/c/pnjvEgAy8l4dzi0IuGRueIH40nFrO
 3IHGjeV+tu0qjIX/swJl0BdKtxmMJc8TStzysk1wmYYgZ1ipNKcKsPOViuuAGqPYaQUY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EbK4kZtg+tSsCk8TN8P1Of1ZhZ+aFvAQ0R/ckpdeF/8=; b=D
 kH5LT4L0RJwZRH0kytOjZ7ozHJETyVUxQB7VbmAJKNaBPsqYFALx8J91EmgKTX5gItm9hU7WrcILP
 gN++X50Qm90/Z3K5GoL+sH2kWT9o4i3MuMTifHiBPPUbbWjeBh1Gz1p81ztziPYPQ/EOsGT3x04HH
 fzZRwX3gBBZkA/0Y=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrbkX-00028g-O6 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 13:33:38 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso685663f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785936811; x=1786541611; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EbK4kZtg+tSsCk8TN8P1Of1ZhZ+aFvAQ0R/ckpdeF/8=;
 b=WXUCMLHJhsK0Kqs18YpKfYPQb6dy+UM7TBQ5Y4hmqayPkAxPr3KLa2VMrJ9yD7kA1u
 jQPSYfng/SfZg2+sy1ENIfzUlbm7J3b27ENf5HJx7N8ETjfHrg1sEUPFXPCxj9t4s8KN
 LRRfYmZWZe5vTbttHezUEdECTTXjrB7mdSY1rTpqsVAgJEy216bSMWHNHDMiVcVyrhNj
 uJceeuZMXU9hiYoPvf6U+xN9k+gFwtP46t4NqiWxvgpYq35xF8IULiuSllfVN5XQSTlD
 VhnNzHrAb3ucFc1VIg6V8HulnO5w2wQZ360euyPhRW65K6yT89JnDqvpaEfw3J4Cl11Z
 E98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785936811; x=1786541611;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EbK4kZtg+tSsCk8TN8P1Of1ZhZ+aFvAQ0R/ckpdeF/8=;
 b=MmSsSs5INjN1yPnagh6CZPU03SxuBLmJBpHTT+VCms3qP7FIEbRgA4ZcVaQo36dYa8
 dqGJBSFy1wgZ9AZZwpR5d+ftoE9y0Xi2aSCp/ncijfFqFK+qJ7B4yN+XI+96L22wfo9n
 wK6JTXEWVGiB3qmByNt2bd1c1jGOhVnejLI6Lhx3lWdyaIKVy8MGRuBaIabBYwDrtqMv
 lqDpTu7AvV5Zoegj8u49kUVDeOJgPzymkmCU7yRnDe90C2IsTTWuBBICkHHkx7Nj3GwH
 ysbanSwsCi3x+KJv3I2nfrEsWe/HbQnH6w3eqDg6VyezXk/ucesp+0Y/ysf1UPA90MwR
 G3WQ==
X-Gm-Message-State: AOJu0Yx+zqPMZ8HLqfkTGo2sta4xW0BGr3dUFXRaGqgLaoiXVCg1n1ed
 qEotvsr5fa3fB03Ck26usz12bZ5VUuQi2D3og50IaXHjT+kFulMzmCxb54ng/dTLC+P0RW8kNVG
 gNpeHhUfXAyjJAibpD8DhvgMbVFgJnfvIWdtbPJDUFzmgJi0RnOevkBKW6rNhlCw1FXTYWMKCty
 6Wsqz+wQ==
X-Gm-Gg: AR+sD13SxWXw8sfDlUsPWR8MxL5c+YumYdsFbg9MsUmi4Ic5N8zbl5hO9nM09glz83l
 8Q6y6csWQHAJ1cUn7NcIJHfKA1Fn50zba6WBO4J33NuadtPUBa3J/Tr1M0DQ4O2hLHkx2zwZqpg
 rCos2tkMPvt6p+JIkvF22VJCtDa/aZFk49vRLTnbrXv566IQ7GzsuLIxJ4ZuAgb9Y09IBmQQghF
 v2sErVd+gAyIQ9WVrXGvnI97sXeWa8ur+QKAKeg+sy0thDfGw12UkIaV5ctlCeWazQBqTW2DAVu
 uT2cl0DYeeJvgTWAHmDj2YZYZSsFcOk7Xr5Os5O2j2F7cvv6I5igO4ycrmt2gpQ7XY15lklq5YE
 uxalYhqj8UA5rbhAjpQ1a1raLqzceNRBrHlrPrHHS+TETthSQn1C9MZ1qINcddsXABiBBndXlIL
 T1yjzuLkCtbuYQlrflZAFI6R87e4AsMTi7FxLibwsVkqEEVca79NuYmgeuMqwqhifOsgBeUDNUP
 BhszM4mXgBot7w6uqFbdvvwxRSV3QwaaNkeVtnuTHfPpx207NtyuWDlNOhFCP642eOJg2IyGYXf
 R/AEQ9mMDhiUff9dSf0uD1f0lCCkah23+QXg8stmaeoPABW1J24=
X-Received: by 2002:a05:600c:3b04:b0:495:5e86:4e11 with SMTP id
 5b1f17b1804b1-4994e7baa85mr78623175e9.12.1785936810997; 
 Wed, 05 Aug 2026 06:33:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e99c035sm45688865e9.4.2026.08.05.06.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 06:33:30 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 13:33:29 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
X-Gerrit-Change-Number: 1837
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1837?usp=email>
X-Gerrit-Commit: b55b3d3d525662ec8f138a9ca86592c3ba58c33b
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 13:33:29 +0000
In-Reply-To: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
References: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1OTMxNzkzMDAwLkk3MjgwNjdlZjA4NDgxYzg3YzdiNjkxOGM4OGViY2FlZWVjNDY2NTM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1720e47200b15b25b2cf6dffe30226e22e78dc49-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrbkX-00028g-O6
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Reenable xmit_hold
 when using p2p tcp-server and tls-server
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
Content-Type: multipart/mixed; boundary="===============6808863939671668535=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6808863939671668535==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="I9vlDwvW3mM="; charset=UTF-8

--I9vlDwvW3mM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1837?usp=3Demail )

Change subject: Reenable xmit_hold when using=
  p2p tcp-server and tls-server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(8 comments)

Patchset:

P=
S1: 
commit message needs some work


Commit Message:

http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1837/comment/65e0750c_ba449b7d?usp=3Demail :
PS1, Lin=
e 7: Reenable xmit_hold when using  p2p tcp-server and tls-server
spurious =
whitespace


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/b3c294d=
c_83cac3b1?usp=3Demail :
PS1, Line 9: Commit 619c3e9 changed the logic to o=
nly enable xmit_hold only
doubled "only"


http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1837/comment/6bcaee95_047866ff?usp=3Demail :
PS1, Line 10: when c=
->mode is CM_CHILD_TOP=2E This works for the --mode server
Remove "the"


h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/2ccd8a54_df0b8463?usp=
=3Demail :
PS1, Line 11: was probably done to allow this to properly work w=
hen the server
"and was" ?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837=
/comment/e3fdbf8d_5bee3754?usp=3Demail :
PS1, Line 12: is listening on mult=
iple sockets and options->ce=2Eproto cannot be
missing word after "be"=2E "=
used"?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/52ba6361_4a=
e9b15d?usp=3Demail :
PS1, Line 15: Restore the logic for p2p logic to avoid=
 both sides starting sending
doubled "logic"


http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1837/comment/89cc92bb_6bfd6e27?usp=3Demail :
PS1, Line 16: re=
set at the same time=2E
"resets"



-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1837?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
Gerrit-Change-Numbe=
r: 1837
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 05 Aug 2026 13=
:33:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--I9vlDwvW3mM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1837?usp=3Demail">View Change</a></p><p>8 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?tab=3Dcomments&am=
p;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">commit message needs some work</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1837/comment/65e0750c_ba449b7d?usp=3Demail">Patch Set=
 #1, Line 7:</a> <code style=3D"font-family:monospace,monospace">Reenable x=
mit_hold when using  p2p tcp-server and tls-server</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">spurious whit=
espace</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/183=
7/comment/b3c294dc_83cac3b1?usp=3Demail">Patch Set #1, Line 9:</a> <code st=
yle=3D"font-family:monospace,monospace">Commit 619c3e9 changed the logic to=
 only enable xmit_hold only</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">doubled &quot;only&quot;</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/6bcaee95=
_047866ff?usp=3Demail">Patch Set #1, Line 10:</a> <code style=3D"font-famil=
y:monospace,monospace">when c-&gt;mode is CM_CHILD_TOP=2E This works for th=
e --mode server</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Remove &quot;the&quot;</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/2ccd8a54_df0b8463?usp=
=3Demail">Patch Set #1, Line 11:</a> <code style=3D"font-family:monospace,m=
onospace">was probably done to allow this to properly work when the server<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">&quot;and was&quot; ?</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1837/comment/e3fdbf8d_5bee3754?usp=3Demail">Patch Se=
t #1, Line 12:</a> <code style=3D"font-family:monospace,monospace">is liste=
ning on multiple sockets and options-&gt;ce=2Eproto cannot be</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">mi=
ssing word after &quot;be&quot;=2E &quot;used&quot;?</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/52ba6361_4ae9b15d?u=
sp=3Demail">Patch Set #1, Line 15:</a> <code style=3D"font-family:monospace=
,monospace">Restore the logic for p2p logic to avoid both sides starting se=
nding</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">doubled &quot;logic&quot;</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/89cc92bb_6bfd6e27?usp=3Demail=
">Patch Set #1, Line 16:</a> <code style=3D"font-family:monospace,monospace=
">reset at the same time=2E</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">&quot;resets&quot;</p></li></ul></li=
></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1837?usp=3Demail">change 1837</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1837?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1837 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Wed, 05 Aug 2026 13:33:29 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--I9vlDwvW3mM=--


--===============6808863939671668535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6808863939671668535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6808863939671668535==--

