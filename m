Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F3FCC6B24
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kl1EX/6Ap22+IPD1uj0GCOyYT8qro5og87oy5YVnsMY=; b=SYRrWXw2qgnHZ8zxky7/3zcLJI
	QY4cFcpVf7lonGw4kviJNheMEAbgYjrZ26ZYs2h6olPlLEqHUqElEW1Fj1tqsa35m/FLMpk4A5SIs
	Y49CbJAO9Ja4XFWxMKbDyhrPKg5cdwlAjTgIP0vzvNHmYBDUF3RyzfzwSGjvAJnVhGxU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGtBT-0005gH-VJ;
	Wed, 14 Oct 2026 07:13:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGtBS-0005g9-Nt
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 07:13:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=j3WJEETKqCpwWMBuA3XJQGgV4PuF+4ZY6qXPnrMVT9U=; b=iuMtQ++y0FtpRU99omqnm+jbwZ
 o5S1UV2Hj0cLCE42XXd1mNY5LLAczrmako9qP9Tg6MN9UdX3mQy4dTDUXQw++i7TgJa1xKjzJO5MF
 9M8u8AQ6w4LmsVYGzk4kTvcR/ZQN/MxUdNch/XQAU5R3KGOWCbk13nBwZ0ACZwd97N7M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=j3WJEETKqCpwWMBuA3XJQGgV4PuF+4ZY6qXPnrMVT9U=; b=X
 yGJVrlkxLP+M2eETYZlTZQ/i81ayB/HNJ1TovE442wWStUFvRk71X5JfxC6U71yFvyNFCOmSl153y
 N98s0FJh8xfi0XDfGaCu9AhrI0mSDkeDg34LBbEyZNWgd8RGKyvpeUa4x6bYBvTf3hEUJ0G/5mnL7
 k6Bus8I6ju5355Ko=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGtBN-0002iR-8U for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 07:13:52 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so29688065e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 00:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791962023; x=1792566823; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j3WJEETKqCpwWMBuA3XJQGgV4PuF+4ZY6qXPnrMVT9U=;
 b=QNdyiMuu8z99KlAJgTZDRmmwVITSiglRPKFWAo72XWdl4eYb9k0N+WuqawOS3WfstQ
 CKR+f9UAFuuqIsFTK8H/moJ3P6E0Zp3zZzqKjpqV5hPQqRVP1xdqgpMGnkFHEGMqp8b5
 38CLHJs8IRY6gu2qV47dnteBGEoVy06p+L4pXkcpCenhNPdZ2XAD207ySU26GdDAoAuI
 +YTGWy5wcEIGHF+JpvYx/Pquax2Axygeyy8jzlFnZbOK6pafZn3noArdrHJq8WpckL30
 culeEg5CEsTCG049mUeyzkWjCNCpJG1NfcKhbsOLya6sobT8Fqlbq9vT1kiCq0Z0usgw
 5Hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791962023; x=1792566823;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=j3WJEETKqCpwWMBuA3XJQGgV4PuF+4ZY6qXPnrMVT9U=;
 b=nAqFgUQ9Yvg1Cmfr2VDNbhj3Yre2R/wfndTIGKTaVjC1TBxmdeblFR1CJsfrmiFELm
 aKgW/VopLtNx+I8L89LI60utH63ULObw6LP+xr1PWvkK+4V6nP/gFHGY+bd0aFnMBPif
 FXJrzgskef0dDuNRNlKhJtp6ktWs5jgCkre9Tl8BXTar7LIL0mCfuFrGAzor1jHNB/iJ
 OPpNqfYNaZFcTaMvVcrxmuWyzewPuIvtj9fUzAkQ1X8UBELUVg7BUImeWOvjkX0BKaWm
 Udn448J887UO5uN/DRRBsQZwGTBGhLUvxXjMs0nYHr+g6czInd85jbXR809e+8bpe3UP
 nyVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxU2t78tsmyzXRNn3QjAPpXyN5jVTPHcJ5NxpEh79FtNS52aZDmJ6d8kLoFyDiGALmKph+gYAtlWo6QFB8P@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIb6+dqjzHcCj7XtI34Fw9OUEAgQCSn3lS+9D5or21YcMmMC1U2
 yMAYlIsH6sOc+yjZlTbf0a989zCZVbnLo7Y5Cv3v9NE8skbiXgpJ5zsWI5s3eWdetKX1AiR1qC0
 H51vz++0J4X7pSgdVX8EPlQ/mIzJbvftxLVlH+DgRarrVPi3f1g1yhkJ96ipAOdxit3i6
X-Gm-Gg: AYBFou3hqVMvnpGMpRAp0qhFaPkSZLd+s41GZwz87kGSiiTz4gtBx8rmCB1vKBi78qi
 MfnzEHeGQ/KV1H30yHovAvJj22DDnFrhhxIsfyzwvZoHV01crZt9xLiGyNQHuCTBOfzywEarfXM
 J6T2IkxuKmcnEETzgK6LP+aD10LK8otq9pcGh3Bf0u2b7qGTt1P8eHqTErRAJTcnamAGcuNryp1
 1HNFJiKG3l+LVDEusiMYmO1dnA/lv9a5PbuznyciKKWu/5xvwG8Sk1N0KyYK1m6wN6KPzABo4hY
 fb1w/tJbMM28v2ByQc6yRe2Vt69j9tinqpqFiEvJpzH0oPDLfmYY2f0vqc+C/UMSaQEE3xIoJtc
 SmAPYS3oP4THJ7+/LOuES6AaAPPIWADA7QX3TpeaQ2MOCo/D0a0NyIsCqrV6nbG0Xm9Tq6DHDik
 +oHBeEOC7tzJCq+SWF/gDpDpcUv4D/3bloHt1QgYmq41WZus8i46FpfWXLV77NxX52Pmc7NSMLq
 oMc29/FkZtiFcT/J5C3ei2/NUmySuCIqB7o760s4OQJDd7lfF/8/foNfD/qeNAtmQMA6PtIeKxv
 uRv3dYIdogSKEFwGZOnJYYSBuWGVyFApmJLEb4gN2uZa74x7UCCjaLSWT9p/
X-Received: by 2002:a05:600c:1d0b:b0:4a0:13ea:2ec3 with SMTP id
 5b1f17b1804b1-4a18e4ddca6mr295982995e9.35.1791962022509; 
 Wed, 14 Oct 2026 00:13:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be97d1esm663625165e9.8.2026.10.14.00.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 00:13:41 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 07:13:39 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
X-Gerrit-Change-Number: 1997
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1997?usp=email>
X-Gerrit-Commit: a05840749fae02ea496242e2624097ed6817b9b2
X-Gerrit-Comment-Date: Wed, 14 Oct 2026 07:13:39 +0000
In-Reply-To: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
References: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkkxZDZlZDVkNDA5MTAzNTliNjViOWY1YzVkOGY1NmFkM2QzYmM4MjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cd1639c6357c22a7aeba4d20a1b767c84607e5ed-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGtBN-0002iR-8U
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Fix small
 issues buf_printf and buf_puts
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6485188654309131091=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6485188654309131091==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AerUGLaYI/Y="; charset=UTF-8

--AerUGLaYI/Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail )

Change=
 subject: buffer: Fix small issues buf_printf and buf_puts
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1
=

(3 comments)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1997/comment/bf44caf2_47911318?usp=3Demail :
PS1, Line 7: buffer: Fix small=
 issues buf_printf and buf_puts
Is this missing an "in"?


File src/openvpn=
/buffer=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997/comment/3d7b7=
dff_7cce7db7?usp=3Demail :
PS1, Line 795:  * @return true if the buffer was=
 changed, i=2Ee=2E at least one character was appended=2E
`buf_puts(buf, ""=
)` returns `true` whenever `cap > 1` so that's not technically true=2E

May=
be say "false if there was no room to append anything"?


File tests/unit_t=
ests/openvpn/test_buffer=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
997/comment/af54758a_5f5c3f0d?usp=3Demail :
PS1, Line 68:     assert_buf_eq=
uals_str(&buf, "123some text, t");
This passes with the old code as well=2E=
 Intended?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1997?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d6ed=
5d40910359b65b9f5c5d8f56ad3d3bc827a
Gerrit-Change-Number: 1997
Gerrit-Patch=
Set: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Comment-Date: Wed, 14 Oct 2026 07:13:39 +0000
Gerrit-HasComments: Ye=
s
Gerrit-Has-Labels: Yes

--AerUGLaYI/Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail=
">View Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1997/comment/bf44caf2_47911318?usp=3Demail">Patch Set #1=
, Line 7:</a> <code style=3D"font-family:monospace,monospace">buffer: Fix s=
mall issues buf_printf and buf_puts</code></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Is this missing an &quot;in&=
quot;?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/o=
penvpn/buffer=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997/comment/3d7b7dff_7cce=
7db7?usp=3Demail">Patch Set #1, Line 795:</a> <code style=3D"font-family:mo=
nospace,monospace"> * @return true if the buffer was changed, i=2Ee=2E at l=
east one character was appended=2E</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">`buf_puts(buf, &quot;&quot;)`=
 returns `true` whenever `cap &gt; 1` so that&#39;s not technically true=2E=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Maybe say &quot;false if there was no room to append anything&quot;?</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_te=
sts/openvpn/test_buffer=2Ec:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997/comment/af5=
4758a_5f5c3f0d?usp=3Demail">Patch Set #1, Line 68:</a> <code style=3D"font-=
family:monospace,monospace">    assert_buf_equals_str(&amp;buf, &quot;123so=
me text, t&quot;);</code></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">This passes with the old code as well=2E Inte=
nded?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1997?usp=3Demail">change 1997</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d6ed5d40910359b65b9f=
5c5d8f56ad3d3bc827a </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1997 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 14 Oc=
t 2026 07:13:39 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComment=
s: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

<=
/body></html>
--AerUGLaYI/Y=--


--===============6485188654309131091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6485188654309131091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6485188654309131091==--

