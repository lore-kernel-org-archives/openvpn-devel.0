Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C94ACD4F26
	for <openvpn-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CswGuhreFWqraqVLriPYUx+kajZXnRJesBEXh0ELph0=; b=BjQKLGojNxMS0HVNlyXCLUZfFY
	qScjl2uwbl7qO+tvHBJvs1Ckqrn7N6d5AM3bwHTv+F7+51WyoWkNIkAiSAa352JS8cGEN271ujh1b
	kSCj925Y78MVwGMLECw1ZypCJXRFxDS9/JZSwJB59u5o3gS8ViOb4ub7krdEMkIU9tJ0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbxG7-0002zH-UC;
	Tue, 23 Jun 2026 09:17:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbxG6-0002zA-Qc
 for openvpn-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 09:17:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fQwok52Qiufb6Ive4xeaBiIOt9ZKd03iWL6toRDBsCM=; b=DFHBuUAnxT4a50WkxdPB1d1Oyx
 5oRfojW+YaiSAhPwBnenEiRBntmtKX8V6Hm7DjFltk+LB8AALqWCYDQrhocElPYeqTR5sbgIcUmEk
 BXzri6oOOn3nzyveBTss8pUykJiwnhDGdSDJg6oiz2uxtZe6ENGle9cdF5OTD4Q/Ohew=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fQwok52Qiufb6Ive4xeaBiIOt9ZKd03iWL6toRDBsCM=; b=h
 N7bpws7vT2sIqes9au7UaQgu3irNrgLu3JvsaANJ9OIvqTvGhg3RL/p1okBQlbYMmEiUrM8OwsH+G
 /3coq4deqm1Rn0ca7iaY7Q0VFh8yjegg/+8nTq/yhFK/Mhh85F2H2PhD4kDqM9nNp/gsqa0Iatx09
 4XSyB3jBWDNFh4WE=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbxG2-0008UG-0V for openvpn-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 09:17:28 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4629051c946so540448f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 23 Jun 2026 02:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782206235; x=1782811035; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fQwok52Qiufb6Ive4xeaBiIOt9ZKd03iWL6toRDBsCM=;
 b=EC9r3Onn8UsdfNFMcIK6Y7EFapeh2jC/yifGaKx+/5w1BhRuEw+bFKpCLx09KQ/MJJ
 v/KHXuNzKIuLPT01IKU6EcJW1XIyAA5A2VSaYHX44Mz0FCmbg1zr1RRWYnP5SesS58HA
 y6E8y3G/aPu3w9KicOPc68HTZ04dfsICxHO7U3Y3yvF8x/Q1zUxh+VLVNymEUBkqJvrL
 hHyE2ef8CkcY5RoACRILHgg9T6V6KA9X44DHbrp5ufSUG5xqgLd2xpY5iT8g9aAXP7g8
 P+2nJb4tk8rWhvARYhq1fGDJlfoXKvvTykQ2/LZulLr3Jdgxy7yTo5DVp+3c2yYb5/yh
 G/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782206235; x=1782811035;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fQwok52Qiufb6Ive4xeaBiIOt9ZKd03iWL6toRDBsCM=;
 b=XuwnwMaKvlDkbDC4pjTwhahJe5P4Ovu5Q5wfj88e8bhr9JPNWO2xOh3HOykkp9MW6F
 npNANRLuoofE7z8jsaAd72C3I1s7XHDfqTzIxFA0UgR60i3yVcoQPm8DiNvhIeU6Q6AG
 tynKU5q1EUWXPwlWJhWN88jbVJ0F2bdIfbcS6knRfSSPTrFj4PM24nW7K3CNmljb3Yvb
 9YCuG9GEe1jAoE46YV9AubNk15PtYxn7KbcbKuZ0jp4bnljJIRqNfHa22aMDUUndzOwY
 aUCYKB1s+5AHLwkufmAtyHBV5wlu8krxZCrmiLOcGYKvZcG5CEAK1CXnUziW159pOgPP
 cMbQ==
X-Gm-Message-State: AOJu0YwEr6IdpHNcyjACmHHvI5zIgwU9xZ+TRranZEFvCeqLtKMNWIBk
 vj3vHXmgcSGCf8IqicKlauL1v9BW378r9W+lfySxFhBV9mESN+dGwF2GACtLyjxy2mX3PPY9a/g
 x38zmwR5X8Uc8U0qhw0TSNgfsnd1njkE9Nk3KEXooZmuhb3Uv0B+vlSpnTaJQU8s70GcRNcPTwp
 KnY5cVZQ==
X-Gm-Gg: AfdE7cl+yVNVvBD9SzdfcYAx0ErXecSIp97EGNJePa87tzwd9QHvWsaWxMz9Gn5F0OL
 1HLv5b5Fy66QofgDT+2or0mKq6oWpYeOBAb1m+QvgQvtOp8hsjRLycTxGyZH5oNJi19RhCVsI5C
 Dmep4hw7rj7IsU422n1/mnVZM/YOE5AWlwNXu012ZROQ49zoLlIj6xVFhuZcmDZDYbRKUzqmKB+
 n60TlYB+QuhT3gVLPDGlOQPl2KUKQJp0TjfvBuRsTSx36wjcRr8nFaCbE22YdunFuRafcdGGItY
 6Vz4jqGHwUmLyvAUoS2Sc0FwP2JkKuDi13TlcCjnKlHNKCxQwqDu/RKS/n0ctUb0aYCDeK/Z6Eu
 As7yP9TTMXcA9mozexsUAYbowhLuWfA4nRmVMxZ3PLM/aAiJNqC5t62gayNToRQctnDTUTJWv0o
 JAlsR48FH2Ujb4LWLJMFIp+vytPnJmLtlBICVzVMqI7yrZYC1cBropUfWNdybFcxJbcHjsaG4rp
 2dSTEvuEml0Ln53aujZxIkk81+XAk8p4aOkimAmMlI7+qRO2y8OpxosEGUNp03++C8IL/A60LBT
 GSg=
X-Received: by 2002:a05:6000:1888:b0:460:21e7:330e with SMTP id
 ffacd0b85a97d-46a7efb72e0mr4730735f8f.10.1782206233667; 
 Tue, 23 Jun 2026 02:17:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c57b95sm30813249f8f.30.2026.06.23.02.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 02:17:13 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 23 Jun 2026 09:17:12 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iabe1992b2608661b862a81363574e957d18395f0
X-Gerrit-Change-Number: 1554
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1554?usp=email>
X-Gerrit-Commit: 3353dd9c5cc152588111892a1b878e96b5d51fca
X-Gerrit-Comment-Date: Tue, 23 Jun 2026 09:17:12 +0000
In-Reply-To: <gerrit.1772554170000.Iabe1992b2608661b862a81363574e957d18395f0@gerrit.openvpn.net>
References: <gerrit.1772554170000.Iabe1992b2608661b862a81363574e957d18395f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcyNTU0MTcwMDAwLklhYmUxOTkyYjI2MDg2NjFiODYyYTgxMzYzNTc0ZTk1N2QxODM5NWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c865048340f0d82f81cf86a16330a688eb88203-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbxG2-0008UG-0V
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: Never use
 negative buf->len in link_socket_read*
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
Content-Type: multipart/mixed; boundary="===============2196339630520693313=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2196339630520693313==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jpRN21RJNVc="; charset=UTF-8

--jpRN21RJNVc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1554?usp=3Demail )

Change subject: socket: Never use negative=
 buf->len in link_socket_read*
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review+2


-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1554?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: Iabe1992b2608661b862a81363574e957d18395f0
Gerri=
t-Change-Number: 1554
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, =
23 Jun 2026 09:17:12 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--jpRN21RJNVc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 4:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1554?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1554?usp=3Demail">change 1554</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1554?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iabe1992b260866=
1b862a81363574e957d18395f0 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1554 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Tue, 23 Jun 2026 09:17:12 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--jpRN21RJNVc=--


--===============2196339630520693313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2196339630520693313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2196339630520693313==--

