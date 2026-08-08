Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6064C55174
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 12:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eNrGIkudy//+hnVUXrVglz/b7zKTotqv8xK+VN65dhE=; b=OldDP5MymuD1ixiS1u4EHm6te/
	kTkrH9B4NFGs1Q7QDHlyv5n787Cnxj7cU8T7X14Zpb/WBsorOenDkPOhnsDZN2kxKKy49aekA9n4L
	IMeZV2HHbBPredZ0o/O/wU81H/eaoTwXGQQAfz4hXwIBiezTJLcnwdG2JE+HE9hO2EN4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsgbZ-0003RQ-Vb;
	Sat, 08 Aug 2026 12:56:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsgbY-0003RJ-IM
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 12:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EdwNnwVn0l5AbWF07Xa5ylU15tViqj9ff/56kxOsbMM=; b=IhFMz88uazYFLMpMKphS/DX2XM
 FaCBR2gvXxdfKKiixGhkMF8gjrvHmrAfOq0sOgs5dZHywI1Q/LYOnzoG6NfugpH31SPTbQXyGDynn
 iu+g00zWgvbNpNV7ccLlJDK5su5v8JrK3ePlHcyqhB36NqNv4GvBsZ2CHVHwScU7p5Oc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EdwNnwVn0l5AbWF07Xa5ylU15tViqj9ff/56kxOsbMM=; b=E
 1OcsQ4bkQv9YC3q13HBpSYzLe4QG4PL/rLYIzlOdrChiUxh8+gsrlVfEDuCnW8fNZ04xG3BZYcoKt
 s6oaiEdzaMdgaXc8GedzyIOfZEH4GJmdipahr/OvmgGl1YBnBaCWYPUlToLA74zMijq4geHQVUi9k
 hR4YlBhvzNDJBYgk=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsgbb-00017o-Qq for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 12:56:49 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so4035315e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 08 Aug 2026 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786193802; x=1786798602; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EdwNnwVn0l5AbWF07Xa5ylU15tViqj9ff/56kxOsbMM=;
 b=YSMnHhejXQpSj//BxzXiVH4ZOgyhFjeH0sO8c6LHGi9qQBB+fW9VNxF3Nb2+A1fCiz
 NmrkCSBTprXjY76FiHrP9jhgEHdlBCrctZqZ5BXeSf4dIkD0fma5zWmMReJ0dP1r9MN0
 jtN1VfM1VX1HtckQ+RdzSuuccFpj4reNsHFDr9v8V5AKF7T+IOX94mZlrmWoMp658dus
 e13OQzVI61E0rPMd+EmcUHdOHd5wfpvmgOgeciB9GHzQCBrh9VD+tWiYoaQhPBfU55x7
 3PtvKUJepKNmvPhEvxq007zdBgoDRk1oW8rvyuOQ55AVh9soq+c3QsuezhH271gFPpXb
 tqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786193802; x=1786798602;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EdwNnwVn0l5AbWF07Xa5ylU15tViqj9ff/56kxOsbMM=;
 b=En1Iu4AgvAx4deiEHsHLL2/7DfztjLlW55WPMQygeUGpk6sCKZAkIN2jTH0ECgKAp7
 D2kcbDQBvayf3fZBbHv1E0vZJNqfW7sPaEbzLLDbhrX60up8XSE0cGlAoskKyCiSJATs
 Gw+J0zlqQFDG2vEJkjioAAaJvnQMWimgX0/E0icAaRkzJqirCupJZ1zPA6LAKKbG8hIr
 pWickksuJjrm68tc7nE0xKdMqnCw4BYioDNGImAxsWIQJNVJuvUAMhTBQPXkcblAjOEt
 Q/swtwm1BcOzHX1xqQ2SOD8Dzo1mHi99hBwY1wwZg6BuOkzXYULGxQ3R51lAhAHZlSO8
 h5/A==
X-Gm-Message-State: AOJu0Yz+EfklysqqH68KLrVdQh3TXtt3zeurB6k3VJ5YEXtf92xFf6PR
 TKbZepCt99LXLlLPArIM5op43MM8/li+kIGmZhWkF25D+avhpj4AlhlPJi3JXkL8s9eFw+ZQWV1
 FMIe7j8+q0ghdrDvgXd53bmZSSitU3TONN2HPMSJM7XAsYqafl/pAvQD+BmbEd9yjshL0pO/Vwi
 LIpGoUvw==
X-Gm-Gg: AR+sD10JRAM2THTxg6cdLkzluGQebLhEfj1GLoNRnmbNe7xwt0vMAgr9lFr0gd/62oL
 IBgsUaHBGoJV6hUNlOw0SwpO0J8oXoHTZhOOBLqFhD2hMOJDlbvVhO5inTflSZZea8tLgE78mVh
 lP0hGnc5CYgsn9aFRVX/9fjVCcaoV+HKU2Jb7TMcGT9m0u4HtcKRSRudr9sBTxHADfVUdzDYjBP
 bskp7zmYwLjesrmql7np+T1tep47zZkAHOcgRG7+ifAZnbVHETqcxx05Uy8hRXuwd5XEVS5YD8G
 SXZpK2nm7fGqX4tEMO5anxp7Jr7iBXnXaOY1mx5QFzxZMMaJTXg6ZEAFRFIaMsXHPXL48USXrJQ
 sJalK5jVxYdKLuE2fjttQi4PGZTnYJFONb/4YOhu8wfAayWWtXvqC055kjDjSZPdp6iacdfI9Uc
 JzvXYP3aNwK/3teVq2bLWuZOm1CsIn3YGw54ShYV8ZFIWEUsS3e7uyn3LTto7mRBsil55B5oDZi
 cEmf6kPm9UuJzQuqMZXqkSY7jirRZFka7MqL5VvMsKpY0iGc97YYBm0HeLS+qRPXBOrmGnjcJw4
 pB9vPw7XDIRVUhHjSG71RTiGR7cldfFm2KKbx50WpHhRYzim/tA=
X-Received: by 2002:a05:600c:3b0a:b0:493:c47f:3c55 with SMTP id
 5b1f17b1804b1-4994e71d7b0mr370252925e9.5.1786193801595; 
 Sat, 08 Aug 2026 05:56:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e902dsm15277777f8f.21.2026.08.08.05.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 05:56:41 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 12:56:38 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I81b7168b64c438f759eace1e8f2735891c797bb9
X-Gerrit-Change-Number: 1611
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1611?usp=email>
X-Gerrit-Commit: c18e74d52fd88489806f86a43712b78b56d9b231
X-Gerrit-Comment-Date: Sat, 8 Aug 2026 12:56:38 +0000
In-Reply-To: <gerrit.1775343746000.I81b7168b64c438f759eace1e8f2735891c797bb9@gerrit.openvpn.net>
References: <gerrit.1775343746000.I81b7168b64c438f759eace1e8f2735891c797bb9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MWI3MTY4YjY0YzQzOGY3NTllYWNlMWU4ZjI3MzU4OTFjNzk3YmI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d588e842ee5597e760dbc6d7c3c531fe1b4b9530-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsgbb-00017o-Qq
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Hide various
 functions when unused
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
Content-Type: multipart/mixed; boundary="===============3597642934220206532=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3597642934220206532==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yg0XXBYeSTE="; charset=UTF-8

--yg0XXBYeSTE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1611?usp=3Demail )

Change subject: Hide various functions whe=
n unused
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 12: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1611?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I81b7168b64c438f759eace1e8f2735891c797bb9
Gerrit-Change-Number: 1611
G=
errit-PatchSet: 12
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sat, 08 Aug 2026 12:56:38 +=
0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--yg0XXBYeSTE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 12:<span style=3D"b=
order-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backg=
round-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1611?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1611?usp=3Demail">change 1611</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1611?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I81b7168b64c438=
f759eace1e8f2735891c797bb9 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1611 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Da=
te: Sat, 08 Aug 2026 12:56:38 +0000 </div>
<div style=3D"display:none"> Ger=
rit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
Yes </div>

</body></html>
--yg0XXBYeSTE=--


--===============3597642934220206532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3597642934220206532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3597642934220206532==--

