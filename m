Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F5DC9830D
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 11:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DjK5fThX1wNfynYldi8j20oNG0w/Jqhc+6NciooD9pM=; b=d3JqQTnEsUe4As+85p0JDyqOmS
	m/aeIq9rLOCU8eJ2fBFAnxkS7+4zwx22nwKoH1Uu6IKyfU2aY3BkhApY72xvo/4LOKTd6fnT51nFG
	/6BlaH9SrLJRkZYLpCv6S98lRED2cJfRJRvEU70Hf+TI2AcaUcR5sOOZpkWA0rpT1I7s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA4PV-0004I3-H2;
	Fri, 25 Sep 2026 11:48:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA4PT-0004Hw-LO
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:48:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OBc629Iq3jc2KGzRuibVbB6+7xpOKD93mdRNbemA//g=; b=g31K0e8q+vLvDJ2VxPRC+FSX4C
 pwwSaJlUjjKHxBJ4vnz4Fw2hFvS0dp6ZdQgxBoXUTo4Q1MSa5dcDEKqIA0Y55ASLWTUfzrV3/pixT
 soV0NvIYvDhuKh6segvgW4xdZ7iNqk5Of1YfrYx0M20nBbuwbO13GBXZHe/bxAZjfbWY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OBc629Iq3jc2KGzRuibVbB6+7xpOKD93mdRNbemA//g=; b=Y
 dAh7iQ8fxHBAWIYelxj8BYnkb0ozXFgNDhK8Hmzq8M/6pLuLawoSYjSxtlMsX/HWukIFaYMaXxXfh
 K6Ss4CoiNYPpEIvBEuC8kicmmbJtYjntXbQAsQ3TRwqKWFFInP+HUF6psdSrujtUV7h7Mq+mKBMcs
 YY+zu66VwX95GsEQ=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA4PR-0005kS-RQ for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:48:11 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so4918555e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 04:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790336883; x=1790941683; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OBc629Iq3jc2KGzRuibVbB6+7xpOKD93mdRNbemA//g=;
 b=STLXfQD5rqDn9CRo8tAhfURcpNvkNgsvItLj0TMGHhejzupGxMoDydnb/iCoz3fHrz
 W1dx1ezNFmiXWraR19We5OFsjkAGBau2W8r8HDWNAy4q53Z128TaAjjdxIuhhMO/HURx
 7OqEAlu8AEqPoNq/Q+I2EPL5sYl01PvvBCBWh2LEimFeizQmgj1LcSsF8aOujiP3I2Ov
 +ioE1+UfdyaegqHdGQdj6+tYCIIUyDJ0J0mShXS29853VJEjXeK1JiL7D5sS2bQMP5tf
 XR2b2TcShaW/WEfLT4hMYit+S32mChSLSHjXZS3A/C+bDDS/QiO+EAVL0GttSHdVzEzD
 LvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790336883; x=1790941683;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OBc629Iq3jc2KGzRuibVbB6+7xpOKD93mdRNbemA//g=;
 b=yD/RPpDbIMyvAFSzB31L8VnoJyDO5M7zZTWxNpux7YrlqK/QOVT+/ZTiWLpxTN9hJx
 BmdwuWGOYXWWH1zxauc+qUE0Zq8Q5z/Jb2jU3jA+pjqiAR/ClDXTQo05UWjyA0kldq7R
 RFOY8NGuXMDNBa8WnA740dgZ4q2X7grShyckTIYGGwk5rYYh/yVdDGEutYMAL1n8DCNF
 XWnwgLMmM6xcsak8tJc/m6FglB9CibwaLKlFEoHiy9aaFlHTsRl4U054eh41SWbwQ1Hy
 8I+2BKAgVFxqgTOeP2lbvYJlLL83DO8aPL3lnCcrfChUvO/FTSyAkj2tb2Df+6YT+51e
 pvOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBykPpt0JzQgDqABfalpqYnpYNf2O9C1KwHKArWqmKudDR/+v5r8aU1dynKRV+PNGmhU+8IdTwjyGpSVqlVy@lists.sourceforge.net
X-Gm-Message-State: AFuF++k//MgX0MUPa1cD8fbUs3O+M2lbBEXOwXz80b5HVDG24HBuN0CW
 annWGn94zlSPudv4gauE11m+HyIn15CJfYK1ULoLX0Li9TRkTtzI9+Frqkyz5SXIjY7hnClWgDa
 sAFE3ejO+2NRAf+RmLkrb9ppb8R5QjftkBVcS9s1Wctxs4nB3hhSXLkCVwTLW8oYIegfR
X-Gm-Gg: AYBFou3lQKJrljX0jFLJS06nbmPsdvqSIHB5fPnLCbOkSgNHsaBcJKnylslatKU7AD1
 1b6OXRfpMj4lK1lw/lwoZXG8r8fTHwmnMTlkXRHdOWLWcIYjDWeaE7jIe+Zyz4AtkbzmQB4v7xz
 9mqXnUpwgu7k3oWArO5yY0edzl95IyzPIWfSJkf/H1OKwDDwZcIskXIHWfBiu0zbOD45KwE8S57
 hk7JjrD6eEGaYvq70MloTg2wQtGd8Fd1lYJaLAGkepRv0/HOVk856lCmj4CM2hpLVE1khoT2MSl
 9238PHdS57iW9J9Tao06GT4odzfzf8xUuJ9zSKQyccIVxg0zQ3eeixUTygRTYi9SWUauGkg9q5b
 bWsCwLShd7jr44thYcRmC9ysB8k3BRUIR0KlS/eXgwrG0TS2zOQE1FQ0SpypRueGz7+3QsTRFXi
 hb+8eDJnO4Zk5Ioq3uTdeQq46gviky/DwdTutxE99g92vF/BA/7Mgb6ti4FhHyzG2sOFUV2Kg9u
 dnqFzZqGxRiO9TxVC5s1wAzIOCbKmAVwp+PXrI0f8p9Q+bGvScAh+nnZIM8I1jkoBfM2PS0eRkd
 qDzeTPtdRRj2p8eBWFFHEQ5UZbU1vEE9s3PbEknyOIdsBTb7EaC0Z1IdjD2m
X-Received: by 2002:a05:600c:154c:b0:49c:fa21:e746 with SMTP id
 5b1f17b1804b1-49fe6701f37mr96448735e9.28.1790336883131; 
 Fri, 25 Sep 2026 04:48:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff43ad975sm44969575e9.13.2026.09.25.04.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 04:48:02 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 11:48:01 +0000
To: chugly <charlie.vigue@openvpn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
X-Gerrit-Change-Number: 1949
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1949?usp=email>
X-Gerrit-Commit: 57e9b919136ba4e1dac9ff6ca0de201f644c057b
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 11:48:01 +0000
In-Reply-To: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
References: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzA2NzE5MDAwLkkyZThmMTQ0OWZlNTRlN2Y2MjhlMmJkYjA0MmVlMmE1NjdmMjVlMDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8936254b5cb272200db00d929a5aa6761194b33b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA4PR-0005kS-RQ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add an
 end-to-end test for --route gateway keywords
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
 openvpn-devel@lists.sourceforge.net, charlie.vigue@openvpn.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0971990524947979326=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0971990524947979326==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5nEGEiZSw40="; charset=UTF-8

--5nEGEiZSw40=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: chugly, plaisthos=2E

flichtenheld ha=
s posted comments on this change by chugly=2E ( http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1949?usp=3Demail )

Change subject: tests: add an end-to-end=
 test for --route gateway keywords
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(6 comments)

Patchset:=


PS1: 
Generally speaking the netns-based test has advantages in terms of =
isolation, but a test that is usable on *BSD would also be good=2E I wonder=
 whether it would be possible to re-use some of the test code or whether on=
e would need to create a completely separate script for that=2E


File test=
s/t_route=2Esh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949/comment/778=
09d49_afd6d430?usp=3Demail :
PS1, Line 1: #!/usr/bin/env bash
This fails on=
 the BSD runners=2E Maybe we can just port it to POSIX? I don't see anythin=
g that particularly needs bash?

t_net=2Esh seems to get away with it by ma=
king the decision in Makefile=2E But I would say the skip at runtime is pre=
ferable=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949/comment/77b70e6=
6_b16b7565?usp=3Demail :
PS1, Line 29: TARGET=3D"10=2E71=2E250=2E1"       #=
 what we ask to be routed via net_gateway
please apply the changes from shf=
mt in the failed format check=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1949/comment/223cedbc_75cb6e87?usp=3Demail :
PS1, Line 67: if ! $RUN_SUDO=
 ip netns add "$NS" >/dev/null 2>&1; then
I don't particularly like the pre=
emptive dumping to /dev/null=2E This command is silent unless it throws an =
error and then the error might be useful to differentiate between "can't cr=
eate any ns" and "can't create this ns because it exists" (unlikely as that=
 might be)=2E So I would remove this=2E


http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1949/comment/7b7a112b_5db8ae54?usp=3Demail :
PS1, Line 79:     [ -=
n "$clt_pid" ] && kill "$clt_pid" 2>/dev/null
Again, I don't think the redi=
rection to /dev/null is good here


http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1949/comment/ccc4f156_009c1cbc?usp=3Demail :
PS1, Line 83:     $RUN_SUDO=
 ip netns del "$NS" 2>/dev/null
Nor here



-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
Gerrit-Chan=
ge-Number: 1949
Gerrit-PatchSet: 1
Gerrit-Owner: chugly <charlie=2Evigue@op=
envpn=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: chugly <charlie=
=2Evigue@openvpn=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Fri, 25 Sep 2026 11:48:01 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--5nEGEiZSw40=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: chugly, plaisthos=2E </p>
<p>flichtenheld has posted =
comments on this change by chugly=2E</p><p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1949?usp=3Demail">View Change</a></p><p>6 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?tab=3Dcomments&am=
p;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Generally speaking the netns-based te=
st has advantages in terms of isolation, but a test that is usable on *BSD =
would also be good=2E I wonder whether it would be possible to re-use some =
of the test code or whether one would need to create a completely separate =
script for that=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File tests/t_route=2Esh:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949/comment/77809d=
49_afd6d430?usp=3Demail">Patch Set #1, Line 1:</a> <code style=3D"font-fami=
ly:monospace,monospace">#!/usr/bin/env bash</code></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">This fails on the BS=
D runners=2E Maybe we can just port it to POSIX? I don&#39;t see anything t=
hat particularly needs bash?</p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">t_net=2Esh seems to get away with it by ma=
king the decision in Makefile=2E But I would say the skip at runtime is pre=
ferable=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1949/comment/77b70e66_b16b7565?usp=3Demail">Patch Set #1, Line 29:</a> <=
code style=3D"font-family:monospace,monospace">TARGET=3D&quot;10=2E71=2E250=
=2E1&quot;       # what we ask to be routed via net_gateway</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">plea=
se apply the changes from shfmt in the failed format check=2E</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949/comment/223cedbc_7=
5cb6e87?usp=3Demail">Patch Set #1, Line 67:</a> <code style=3D"font-family:=
monospace,monospace">if ! $RUN_SUDO ip netns add &quot;$NS&quot; &gt;/dev/n=
ull 2&gt;&amp;1; then</code></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">I don&#39;t particularly like the preempti=
ve dumping to /dev/null=2E This command is silent unless it throws an error=
 and then the error might be useful to differentiate between &quot;can&#39;=
t create any ns&quot; and &quot;can&#39;t create this ns because it exists&=
quot; (unlikely as that might be)=2E So I would remove this=2E</p></li><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949/comment/7b7a112b_=
5db8ae54?usp=3Demail">Patch Set #1, Line 79:</a> <code style=3D"font-family=
:monospace,monospace">    [ -n &quot;$clt_pid&quot; ] &amp;&amp; kill &quot=
;$clt_pid&quot; 2&gt;/dev/null</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Again, I don&#39;t think the redi=
rection to /dev/null is good here</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1949/comment/ccc4f156_009c1cbc?usp=3Demail">Patch S=
et #1, Line 83:</a> <code style=3D"font-family:monospace,monospace">    $RU=
N_SUDO ip netns del &quot;$NS&quot; 2&gt;/dev/null</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Nor here</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1949?usp=3Demail">change 1949</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f=
25e02d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1949 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: chugly &lt;charlie=2E=
vigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Fri, 25 Sep 2026 11:48:01 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display=
:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--5nEGEiZSw40=--


--===============0971990524947979326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0971990524947979326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0971990524947979326==--

