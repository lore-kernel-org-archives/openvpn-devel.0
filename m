Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE66CC61DFD
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zFl2q45qBVFauap77Xr6/nbaBY8BUXM75s52U+zLihI=; b=gOwD/ZTQkahuk0EIXiYYpd0Ybd
	0ocEZNPv8vT2RVXPzdqxRUbzcSSQOfDX+vG7w+rDys5vZw94LHrwc057guWES/nT3aAhzdpRLmnZ0
	aXixiswLV1jUjXYkzzQ2rEID0+OXdQAyzsxHRPGXGCGWSNwcQnhd+IOxT94qNQxJW8Mo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1gNg-0005UO-Lo;
	Wed, 02 Sep 2026 08:31:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1gNe-0005Tr-Fs
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 08:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=f30CKHyhBq1lrGbvFMZ8SzfTpM4HipQdBtDyR02TVtg=; b=HIK/OiEAxZjHdcXm1Wn24SAEV9
 JE1Xz2x9ZCYIwlEd2v72Ax9rTv8CkQenVFzg30rHG3N6qZMRv5VlQPEvvOuV5rDXYQlZ8n9fW8Btu
 rZfHQUeZVq45oelASNTuWeOAQBEKrooDZT0l/VSdggSmcsyDyG03nCAvGOklll4kAnBk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=f30CKHyhBq1lrGbvFMZ8SzfTpM4HipQdBtDyR02TVtg=; b=D
 UFJ63DPdUMwTEpBEZ+lltmYxnzIWnM/pLnxhtyZf6rKCSAMQ4fDl6xEfI6nSyl5WGSSxtbUrvC7Qf
 m0pUsTXnGsVnq06bomdqjkOrAupuOu7B8Z4jTfQ4krF4eOValBcp/TsA+RiyFcYwppsPgsfYPxw7H
 QBWD63pQd3NLRt4Y=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1gNd-0004qU-79 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 08:31:38 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48444ec4fe2so391970f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 01:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788337890; x=1788942690; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f30CKHyhBq1lrGbvFMZ8SzfTpM4HipQdBtDyR02TVtg=;
 b=goYMn2PUYA34N5pMO1HprG+QG2r/PaJuw9CfO9rsd5MSHl1UKZQBGoB761HyX4FBMd
 2X2Rg0LKzHS3thw0hWZeqIX+e1YcdPQc+plLpu399yM0pD3Ael1/NQGRUwssAZB3YmGA
 Jvsh+bdDbFVmxgrFIb+nYlHEnRlVKiyIBhLE9vPvKffhJ/txqVnf1lfN0d0I6u/JsZDZ
 GdMfkYLJ6wazfpAn/iPFQljQS1JTITiS7rXouh1uB7lgkZTjNrD5qtcgh19YYPv5fv8m
 0bUKa8smXlPBN1sTr0a4FG+xbvR/MTc+13QCUv73eXhGcKWKCKajH4z/QJJ2C3lLS39C
 ZwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788337890; x=1788942690;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f30CKHyhBq1lrGbvFMZ8SzfTpM4HipQdBtDyR02TVtg=;
 b=BvOhSeWw9cibd2pWYv2TtSPpiMXEDs2ydPbP/3z/bMfUbeCuiqpjYva+DfXSkcRyoP
 JgYFARPgkosYVtNWMTDcgoftCj7Mcd1hYULNI5DzvRyNnLho4YoSPFV/qa52iplJpG4V
 HqnZFwLygfYbRUuXdy8+FP4kHF4psQ4Wdb7GrwupFvxhLQBveXNgKoOifOuihhAMbpPk
 RvoQa07ve7JuvMDbaF+tnx/EWi0QK7HkPDMhWIUxTKT9/ng+pSxK+NmW7nyQxwBP2mUY
 sSarmP67CYwvz8tKtPcnHzWB2AJdJ54s/1fArzoab2ffyNIN5ubpAERBl4gw/FhyWhny
 XW3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvG0mGQEBlxfRcvP4RFrnw8f7QsEuO9Xas4EIY0p3+zCESzaOQedAbAV9yj48elKI6uiZ/jyD9PqzS7hFu@lists.sourceforge.net
X-Gm-Message-State: AFuF++l6SrnmCa/egk7NlkNi1yt2c2o1Qkmr5J5kT+ROcUEVrag/wFKp
 zlZ3FGKg9AsOudrUvWBLhaiPcZ0shbe3iElEg7goo6jNe5hTaTi06cv/m2a/ymKilWParwKSSRK
 djZ30+9uZX5NFhjqi3yeL5/naFICZHdyPSfXRBjuC3w/I8rNqs29Dy9yTUd0uq+HELmzl
X-Gm-Gg: AYBFou05WJB82/4Wqpps3h/eYK7FNJz+rCvmJjLKx+jkFZGDnZjOjlUlgBmcu0VsxSu
 49eYKHdbN1TS3iqOvAR9W72oCGlAoclxlmmOQQILurcn6OK4tKCG2OotKxWeBT1Ownq+jTxFk1r
 iLAg3B1X6PpFiwMzgrwvWLKRZdcfTM7CKQluCamSYb8gYbzDhOL4W67QVz7wMD81Ag0E/2piaoi
 TUeOQ1xDPlvt8CIxBbrtCrYZjxr59t1VS6ugFnIRWWQOLduorsJ2/xKo/oknfh9w0tBudSx1ELC
 jWFpLXE5Na8AcEfm1/1ey0f8M6fO4+Jbcr9Km9UhLskkjfDIkaJMBtZDdIhhiRLn034YFBTXqAz
 VTEzxnPtFqVy/0jaPjn/O0PR7LJp8+kzI2HhsawF7eKaV9VvFUO+eSJOMGnozW6FsAOKHfEbYd1
 cv3lbawi2luf8hgJ50mXqLCBqfr1lXyUdNeysbjBCMUvaU0ZpbeJQ/hKgFdCvkNSNcFlPa389YN
 H6KaIyrgQ1ubYakhuSjSs4NEfouQhJa7FIDwgIOFQX1BVZFZUminzPlb+Esyn/gQOo4QbslGdP4
 C8kyqChn/JAsz9AEtSmVCiyGdLPyeUXdbLl3takcDiscDW6NNsE=
X-Received: by 2002:a5d:5f47:0:b0:484:47a4:ae60 with SMTP id
 ffacd0b85a97d-48488e0386cmr4737143f8f.3.1788337890281; 
 Wed, 02 Sep 2026 01:31:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed2e9fsm4895010f8f.20.2026.09.02.01.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 01:31:29 -0700 (PDT)
X-Google-Original-From: "srkyn (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 08:31:28 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: db8854f550226474ea84c377fdbc5024620f05e4
X-Gerrit-Comment-Date: Wed, 2 Sep 2026 08:31:28 +0000
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <72fa39f6f7a95093801391dfe1e7fdae7fe70f7c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1gNd-0004qU-79
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
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
From: "srkyn \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: david@srkyn.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "srkyn \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3851444155155830291=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3851444155155830291==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a94ZySna84s="; charset=UTF-8

--a94ZySna84s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

srkyn has posted comments on this change by srkyn=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1881?usp=3Demail )

Change subject: compat: close all=
 unrelated fds in forked helpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 3:

Patch set 3 addresses the review comment=
s: it folds the descriptor checks into test_misc, adds CMake close_range de=
tection, and simplifies the native and fallback paths=2E I reran the CMake =
main and test_misc targets, the forced-fallback test_misc case, and the Aut=
otools suite=2E All 17 OpenVPN unit tests and both runnable system tests pa=
ss; three environment-dependent system tests skip=2E Please take another lo=
ok when convenient=2E


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1881?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
Gerrit-Change-Number: 1881
Gerr=
it-PatchSet: 3
Gerrit-Owner: srkyn <david@srkyn=2Ecom>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailb=
ox=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Comment-Date: Wed, 02 S=
ep 2026 08:31:28 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: No

--a94ZySna84s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Patch set 3 address=
es the review comments: it folds the descriptor checks into test_misc, adds=
 CMake close_range detection, and simplifies the native and fallback paths=
=2E I reran the CMake main and test_misc targets, the forced-fallback test_=
misc case, and the Autotools suite=2E All 17 OpenVPN unit tests and both ru=
nnable system tests pass; three environment-dependent system tests skip=2E =
Please take another look when convenient=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">change 1881</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iacd56d245e9ab3=
0cfb25b2b364ca661fa289dc55 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1881 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div=
>
<div style=3D"display:none"> Gerrit-Owner: srkyn &lt;david@srkyn=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 02=
 Sep 2026 08:31:28 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

=
</body></html>
--a94ZySna84s=--


--===============3851444155155830291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3851444155155830291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3851444155155830291==--

