Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B16606A31C
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ADWK4lEd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dkyHMxBS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WovvqQV9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=F1Lfz1Oq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DQgVrrxzhmpFFhbkSmBq2kJPDEIfGlJMhbWSnDHVkgM=; b=ADWK4lEdNRPZH9BXmxPIk3ACaE
	GP+yA74a2y7usMz/TOgqyp7clFRdEjDnxiwYKuSq6pf83C5ttiBmf9OTXZs+FP4BpjQfvHDRbnWkX
	1omcJk3tw7HZS0aAmF6h8ww4Gvd5X8z9yUxBayrJvILSQRt4y1cb+FhZBXqG8WK/DRJI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xXFfY-000000007OM-2Xxd;
	Sat, 28 Nov 2026 10:28:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xXFfI-000000007O7-1d39
 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 10:28:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s+BW0vMk1WiGLToDMfStURDFd5akO0SEBSxd0ctQHeQ=; b=dkyHMxBSC8ywIWNE+YDI2DQCVa
 PsHsqQih1gKXRzrR3kLArje9NgkorOjyA6ViL2rK10zTz/2cQQSfqFpOVCNLa6WeinSjyHr0FRnSR
 XNBcOLmmMIHxcamoQcDn8tC6zWRaWrpwFit6GcRYWxa3VMbZDDJEnClReNjXUW9PzH0M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s+BW0vMk1WiGLToDMfStURDFd5akO0SEBSxd0ctQHeQ=; b=WovvqQV9adlhfQxu949tN/ZB/M
 aYjUKcuvhRwXp/troLJIbNwNyUSeL2wFf0An1hE0PjepTsFEWiGVzR5/xqr0kO3ff84G490Tj1H8O
 o5AE5JKEe5lzUbVm0jQ65VnvB+K15GrZ5S6+w44O1lnWxKcr3UfmIjrk6QsER8ys7gsc=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xXFfG-000000002P7-3CM2 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 10:28:20 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so6367714f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 28 Nov 2026 02:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795861692; x=1796466492; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=s+BW0vMk1WiGLToDMfStURDFd5akO0SEBSxd0ctQHeQ=;
 b=F1Lfz1OqLkN4X4zwjMSKF3Sc7bUK3X2GsBfLifd3LQE9fCLYTVXWX6ffIzLA5m6GTW
 wBIf5CQ8fNds2g4R2sw6KLRhe39Pk2iRhosTTo6ZVM0NJwDpxdx4AxPPTeNF7tq1NnFv
 mq5jvoxMa+cX81sLH6wKLUieTP8YOEGUL+bBJiejSIwCN/GhyGInKWDefhBkTBLkBcuL
 AWYKdIgHO+QXL1JmLVIEWiJ9WUhyM+BRcCWHF6Y9E3Zqf+Dli5AoSTcFbboZ/d5tXYCt
 nTuwXvaDBVS6qlyIJdsMZ9z1RKLL3RUe7lBC0Ca/ZIL/If+o6mqZJQM20dAioBTtK+tE
 yn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795861692; x=1796466492;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s+BW0vMk1WiGLToDMfStURDFd5akO0SEBSxd0ctQHeQ=;
 b=0xNTjzIBA+d+0EzN3ZfdSypYUKaavLSFV2yxfCOyeUZJOyTT3P/GD/6ZCS/GxPrDRZ
 nl5EJD+hgSRDOOZ3IgGrd1LvTZ33/POsU9sNSVDw+lqktSpMNcuYXAXOQuQCAr7FVmTG
 CCh7lr3t1S3GntpuC434r3jZzYoQBPAQVmzyRMyyu3sy5GPgnLyK2mlfkY75HfZJf0tU
 Z9BMGIEyHcG2GtG0LKRF176325IwCsNxvE3id9f6tgtRTaWIhVIqceBR1SvjEiZawZmd
 fxwjEcl+2BltghIfQLOh1ISuNCWpAPIL9dAqydg2nI6lFNvKtiwk8m6D+2c4ZLBZiLZd
 IPnA==
X-Forwarded-Encrypted: i=1;
 AL+hErHJv654ng+vyS4lIJLAUpqJGkLkqryadvhsT5Jk17+0MF0QACU0UJV7YWfY+XQtTbc8+oTiFuUQdkznNRDu@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/buYiiDVeELxKB+bWc+HI4a5AqQ+fizswj1A/B3DIHzBc4Htj7
 4vA2tTuycBqvjb9h2uQ0flzsiKKOMt4D+wdirlV/hDndWKD3JMlaj6vewYaGJs1d6JRtkXxwFUy
 B4T8YiCfX3lBH8ZR0baQEkpBfiV0NokKkiA5b/5xbZRW4KAP2tK9wUmQMbnKgL/R8y1NO
X-Gm-Gg: AZFdTZfBTrXMrGTbfJeBx60J4I37GGkV41tn+0KCmuSfREtl0DRZKYXJ3ikq1aLtWjV
 d9wFXE+vsEBlM/h+hfO3/sNrV/+IN4aPXOzmSpT6oXmxo2odOmn4mx3zeAWT8RhndXa6dgOLU6X
 i2XTBTXMQuG7sVFLtijUhUp/x0vhUYsw90Zk+YkIWcqYOZsvdgGi9I97MeXU147iDqVIMgnPHy8
 IxS+E4QNrgLCn9uNO6SQeq7ziqxYf5FmQG7k6vYY17E3NUbCSlczr1GPJSzNII6If7Z1EiI036/
 lNTvI/u6H87awEKOw18uDn2nivViHoHdf6Cdoo/qcnuuTn/UpCN3eXQTQk+0EX1/naOn+QxDSfu
 Vy6r4aI7FqyoP5We21JeNZYDfmaeUooSgAWnH32WW4sc0F0/5yX7TE1972OR4ktmE1lPQykZ88K
 LRcHQaOJOLtHvRqVBN8EJgZhjficVAoZ36WkIVwa1LMhjVbu3Q8MN8pb0cCyqzgH2rxYBudMh16
 nWqici1KzfsFdxwzG4p+tE2LNlClsL/gyS//3JV/bQ1jvFPvDUI2Rrf3x0IwcqL6IatkfvzaaOQ
 celLFov6xvRgFpdvYfinsP8FamPxIAWlPLYP7I1bfmahn0BLgmYRQgxujrPRCw49plZ26TbiBHL
 R08SnYzfR4OJaUrF4paXdz+0q2IfXrbqlW63KY20hPZVcfwvcApYDy4KZn08s1DkaqwvJBO1EBF
 jEr92YjigjviIOzRs=
X-Received: by 2002:a05:6000:2b85:b0:498:be72:6371 with SMTP id
 ffacd0b85a97d-4abb27268f2mr34614492f8f.21.1795861691938; 
 Sat, 28 Nov 2026 02:28:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c61e53asm57144292f8f.59.2026.11.28.02.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 02:28:11 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 28 Nov 2026 10:28:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968
X-Gerrit-Change-Number: 2349
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2349?usp=email>
X-Gerrit-Commit: b6bc63f13a9294dfbd40fef75b558999a7627a44
X-Gerrit-Comment-Date: Sat, 28 Nov 2026 10:28:10 +0000
In-Reply-To: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
References: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkk1ODQ3ZDYwMmEwMjQwNDRkOTEwOWY1MjFkZTc4ODVkNTVkMjhhOTY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <36d7db406225017dab0db2a2ae47a7f35b8b7476-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xXFfG-000000002P7-3CM2
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns: restrict dns
 var names and values in the updown runner
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, abcderyscreenprinting@gmail.com,
 heiko@ist.eigentlich.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Deri Haerudi <abcderyscreenprinting@gmail.com>
Content-Type: multipart/mixed; boundary="===============5318558647484374833=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5318558647484374833==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2Boy8QUqEqQ="; charset=UTF-8

--2Boy8QUqEqQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail )

Change subject: dns:=
 restrict dns var names and values in the updown runner
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review-1

(2=
 comments)

File src/openvpn/dns=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2349/comment/2da61be0_a78dabea?usp=3Demail :
PS4, Line 697: dns_var_=
dev_valid(const char *value, size_t size)
`open_tun_generic()` builds the d=
evice name with `sep =3D "/"` on Haiku, and `/` is not an allowed character=
=2E So `dev=3Dtun/0` now gets rejected=2E

Maybe the regression is acceptab=
le, in which case we should probably say so in the commit message? If not, =
we should probably allow `/` only under `TARGET_HAIKU`=2E


https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2349/comment/58a36930_be0c45ab?usp=3Demail :
P=
S4, Line 697: dns_var_dev_valid(const char *value, size_t size)
Should we a=
lso reject a leading `=2E` (which would cover `"=2E=2E"` as well)?



-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5847d602a024044d9109f521=
de7885d55d28a968
Gerrit-Change-Number: 2349
Gerrit-PatchSet: 4
Gerrit-Owner=
: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Deri Haerudi <abcderyscreenpri=
nting@gmail=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attentio=
n: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, 28 N=
ov 2026 10:28:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--2Boy8QUqEqQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p>Patch set 4:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail">View Chang=
e</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dns=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2349/comment/2da61be0_a78dabea?usp=3Demail">Patch Set #4=
, Line 697:</a> <code style=3D"font-family:monospace,monospace">dns_var_dev=
_valid(const char *value, size_t size)</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">`open_tun_generic()` bui=
lds the device name with `sep =3D &quot;/&quot;` on Haiku, and `/` is not a=
n allowed character=2E So `dev=3Dtun/0` now gets rejected=2E</p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe the =
regression is acceptable, in which case we should probably say so in the co=
mmit message? If not, we should probably allow `/` only under `TARGET_HAIKU=
`=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349=
/comment/58a36930_be0c45ab?usp=3Demail">Patch Set #4, Line 697:</a> <code s=
tyle=3D"font-family:monospace,monospace">dns_var_dev_valid(const char *valu=
e, size_t size)</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Should we also reject a leading `=2E` (which wou=
ld cover `&quot;=2E=2E&quot;` as well)?</p></li></ul></li></ul><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demai=
l">change 2349</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2349?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I5847d602a024044d9109f521de7885d55d28a968 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2349 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Heik=
o Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Deri Haerudi &lt;abcderyscr=
eenprinting@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Heik=
o Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 28 Nov 2026 10:28=
:10 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--2Boy8QUqEqQ=--


--===============5318558647484374833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5318558647484374833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5318558647484374833==--

