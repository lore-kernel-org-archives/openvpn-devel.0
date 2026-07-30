Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931BAC55162
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ATEX5dPjzcLc+BMpYywbeGPu0uzy6Ai1DPDFcJlCy40=; b=YWzYQET8bRTA5v2VwjuYwHS7xn
	fa67U72lgh6qgiGGGlobOEHZpdguS3p8hvfxqzzPM0rQ1yy9P2YXEC1ChEV7DjfU6k8uaJpb+9xLM
	LLy7ukPTIk9TtS4btTqYYkUrbbYclfclQ7M1Y2YNc2Vz6boassL+ap4v0F3qbrYmS4S0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpTCf-0006XO-CZ;
	Thu, 30 Jul 2026 16:01:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpTCN-0006X2-7X
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 16:01:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=PYMgX04joGzsQGQm8O/x0CugU6ygGoO1z6PaL5e/E1g=; b=gBc6ym2r5ngwJk0frEsOyw/r0i
 WgogQ1xEmBaLZqRruYoErHbjB3ZL+8HIwRh/hBzSNxaL3zQcTY5GL2A4dC3SR0cZilEH8UwIFxVEC
 T8Fx/QSGSOWhCIuSAgHFB4w5SnYcOQVkwMsOEww5y79acO9fYO8pZmzUGrHGxs6Nt28E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PYMgX04joGzsQGQm8O/x0CugU6ygGoO1z6PaL5e/E1g=; b=c
 PusBl66uevYZ88ow7akAiJrA1UcjsMNRW5Jp9y1ZW52uYdmqnBUXTV9S958x1du8B0ltcf8xdtcZa
 qZq+NLjMZv+zUxd/4+y0pAF5IvUw7nRI3NeK46O1yGW3/2k9glvdnfV1rMZjUva4iBHHPJSP5n9H4
 RCXWYAGX1vuoDTGM=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpTC8-0004sC-TX for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 16:01:17 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso25822755e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 09:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785427267; x=1786032067; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PYMgX04joGzsQGQm8O/x0CugU6ygGoO1z6PaL5e/E1g=;
 b=XiTzlkdIEbxFxK4U0B1avQV0nNeVWdQTbZsjTzDgbBujgXLTPSnFYsu6+V0tTzgG4P
 +bV6UsCk6W+8nODRq/hV5jrANiM5rucfMpHyrR3IR7+szs9vacWt1XQfHoNSCQRYPcHv
 dw02Z0jpSOxeyUJaF1LqBgVGxG76bJgPzEieIUvJ7WG4FcIp5RtkAyagWx5lla8L2fOC
 Bigela0JM0Tw6ips2hOvI1arbqDQVMfuOFyHUyjsbEHDF1UeNG04i7kyE88QBewt2nok
 YsLUF2Foe6MAgFnaoO5ovPSHDksN1BIfATn3QkgwM5aChXhGdwkdkf2WIY2PPL2PIXgC
 ZDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785427267; x=1786032067;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PYMgX04joGzsQGQm8O/x0CugU6ygGoO1z6PaL5e/E1g=;
 b=qEEHcMo8OM89a6UMB0xXY43arJSCwF66Y5IXLGlwEXh3l4j/1k93R2eDMnlpikzPpm
 zJ2F/IfJWjOH1O0E9HTdi6rQ76QTozD43oH/ZUyEGrCkrmQYprIBIKLJwkozf21eYR/s
 TmpT7vIkQ6gc0Uboox+QZWrMYgGnbhAD3/OF4ARtPV2eVG7oR5Nv3frOjDp4vZcST9LT
 UR51cumfzNxzMs0bCyPYVxfiLvJ677TaRlagwF1xUKamkDLjj7ZpI0s0TP5eUnSpqhxt
 17H+06AD12PQJJ6kMUcN9XTWArZoGdGQP6uZS7LBzZ4hp5YPOcDL7/1uy9zlXip+eBus
 MTVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXfE+tkeWfFAInEv8/RntQHhHxtn+Y9SxtOIgBJFNdyjslBPsoe1yV20WiZq2ZKDB/mzGuomkgcmaiGyA2@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzbsV8M+xXO1rcUORD3oBgIoVjJV8iD5C0gFS/ZhumvwGxzE22h
 f36T1P2QPDU+6zCyJv/9mD2j4EWFudfWLfcTI8DDIG09D1qcCoPoUKUi3jj8s6NF6cXR2L1/XLm
 GhoV0Xfdj1e8BcRxNBO+Q+7Oy/YOsBMHa+aQS+10R7l6MDkuDGd6hgK2BAu0amURieUIqrCm/kO
 +RdlSbcw==
X-Gm-Gg: AR+sD12SzLnFloT2KCPj3+tf85wE3/bo53nGJ/cKt07Fi+CVrjAdt4dXtUvwphR+O8y
 cJ/PjUU95IGWayVr4F9jgNx32PBdDkPtY2kIyo6p/G8Pe7BYz2Qm6mW3PAw7gAbPpoqooG27UNp
 KsIWhE9QgtuvQu5+WFaULE0JUUhsH3p6nFogPik1j5Dn2QtOIOKkzW8bWNXEiZvvZnMr+c/Uoww
 cr4rK0fFKNWz0aabVLocHt3C/FtNrXzVu3UGP4gpNb5MY9Dwn5yRcR8nsr6qJxOak+fOiURLxba
 xnnQkTixigExkMI418uBZS3kwBzCxPsBNbEmTLXQ1Sw9rq1pWV5HQWDOfXH0ea4Gi3cftJXC8Bj
 Bye/WFr4S+wPCSAIMUOiYZAUAzWLjT7UGEqjVLgjTwmNFrb9iPZbxP8bByCUjl8y/5DBro2oxBn
 TZtNTLgcEWRHvykYe6WOO5NJdFTmCiXHJE8ANxfqoldMJ8AcSi9OtkbI7P/fiZqC2UXf/DOewcU
 h0LdOWuxvYy6aYY5Y10jQGXzq4Fc4BARka0ZTzAjhIbX96gz6Ma357j4Ya6BtZ+kiXwkL+YnAsM
 /26eLpX2STynDcg8L0it3B2Lhr7Jr1VSN+yFmHoVfLxVhDWkinnhBnA/0+5PD34=
X-Received: by 2002:a05:600c:1d8c:b0:495:4487:61af with SMTP id
 5b1f17b1804b1-49800ece1e1mr42963595e9.36.1785427266562; 
 Thu, 30 Jul 2026 09:01:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49800f0ecd4sm66529905e9.1.2026.07.30.09.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 09:01:02 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 16:01:00 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 124613f88855cf4b97c403de5d5ca145d5cd44f5
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 16:01:00 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fe0a49367c15718c6edf2b4c49fc4243f21c5afa-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpTC8-0004sC-TX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 be a fixed sized array
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6547362402584586119=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6547362402584586119==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+CVwSRqHk6I="; charset=UTF-8

--+CVwSRqHk6I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1571?usp=3Demail )

Change subject: Change hash iv to a be a fixe=
d sized array
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 20:

(4 comments)

File src/openvpn/list=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/df7e5f88_b8113cd6?usp=3Demail :
P=
S19, Line 425: hash_func_new_ctx(void)
> forgot to remove?
yes=2E Removed

=

File src/openvpn/mroute=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/15=
71/comment/c129ac68_53fe4557?usp=3Demail :
PS20, Line 361:                 =
     mroute_addr_hash_len((const struct mroute_addr *)key), *(int32_t *)has=
h_key);
> Should be `uint32_t*`
Done


File src/openvpn/multi=2Ec:

http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/f195ffaa_13f23ddc?usp=3Dema=
il :
PS19, Line 313:      * value and function for the context parameters=
=2E
> comment is obsolete
Done


File tests/unit_tests/openvpn/test_misc=2E=
c:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/37bb3b03_050c364=
d?usp=3Demail :
PS20, Line 135:     return hash_func((const uint8_t *)str, =
len, *(int32_t *)(hash_key));
> Should be `uint32_t*`
Done



-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde8218998=
39324d
Gerrit-Change-Number: 1571
Gerrit-PatchSet: 20
Gerrit-Owner: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Commen=
t-Date: Thu, 30 Jul 2026 16:01:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--+CVwSRqHk6I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>4 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/list=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/c=
omment/df7e5f88_b8113cd6?usp=3Demail">Patch Set #19, Line 425:</a> <code st=
yle=3D"font-family:monospace,monospace">hash_func_new_ctx(void)</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">forgot to remove?</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">yes=2E Removed</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mroute=2Ec:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/c129ac68_53fe4557?usp=3Demail">Pa=
tch Set #20, Line 361:</a> <code style=3D"font-family:monospace,monospace">=
                     mroute_addr_hash_len((const struct mroute_addr *)key),=
 *(int32_t *)hash_key);</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">Should be `uint32_t*`</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/f195ffa=
a_13f23ddc?usp=3Demail">Patch Set #19, Line 313:</a> <code style=3D"font-fa=
mily:monospace,monospace">     * value and function for the context paramet=
ers=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">comment is obsolete</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tes=
ts/openvpn/test_misc=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/37bb3b0=
3_050c364d?usp=3Demail">Patch Set #20, Line 135:</a> <code style=3D"font-fa=
mily:monospace,monospace">    return hash_func((const uint8_t *)str, len, *=
(int32_t *)(hash_key));</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">Should be `uint32_t*`</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">change 1571</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa404=
7b7db03fcde821899839324d </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1571 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>=

<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Thu, 30 Jul 2026 16:01:00 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: N=
o </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--+CVwSRqHk6I=--


--===============6547362402584586119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6547362402584586119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6547362402584586119==--

