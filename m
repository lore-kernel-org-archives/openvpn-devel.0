Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BA9C624D3
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7dH0pYZU+3hzcTk1qXM/AOGJAyLtymkaEKsGL3H9C2w=; b=Ilkbi1UdDZYggr8JWw+JzvIlAA
	Z+It9YdIkmsU0D8D7btJHpOCCK+Gq/LQGfrVW7gxPmAwvL0If9XRned/s/QbArpzIxK7JfUHPJy8a
	ic4XxUil+JAUryvKFWgnji319UnkA3VpkfNMNoxlp+OGE1KCRRZHCrB1V69wWNiLPSeU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1jqR-0001pl-Ml;
	Wed, 02 Sep 2026 12:13:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1jqA-0001pW-Hd
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 12:13:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fQXNpl+z65+7sSy92Zs9cms4v9a3XKRD8E24DKM0/zw=; b=CeM4Aak/eqSNC/xhVZeWFpF7Bq
 zZNKdRMcmI5HZB2IEYJPs6wq/ua4WVlTogJ8HYnxew/YhhO5+czr/msnx/aQ7SZb4xTL2g4if+b9h
 Oy60sL446VzG8ki7FjLMyFBr27EViNO4ZwoZIR0ezjIZjj7zNmo502NvkHR8ujUXYOOA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fQXNpl+z65+7sSy92Zs9cms4v9a3XKRD8E24DKM0/zw=; b=R
 kW5Wp6U5gjG221/mW8zTmSlfJyaJ6yew2tDoMOQ/lOrMH/XgzTaK/18u5Gl+X5KXYbKnjlyMM9XJG
 vorye+XVPco4wNIq1wlxfPQ/2JswH+VBZ8ZRPEZEzR0T6gWT6QL3bxxCDyMQM6N65Q6KEXfO2bZN2
 bgjuK6eiI0hOcKFg=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1jq9-0003EO-MX for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 12:13:19 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49ccfae359fso6715005e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 05:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788351191; x=1788955991; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fQXNpl+z65+7sSy92Zs9cms4v9a3XKRD8E24DKM0/zw=;
 b=P3DUW/ewc/E3uyIwOcw6Ug9DhLCwAA+KmojWnvw+icAfuGt5dp55DgP1zTPak1Rm56
 vVQrUUFMFRCn9sDGmog2kZ0Q5AftArgwCQFPbS9wOAht689YJK5visTDBDgsP+B9UQaD
 SQ4PLrOUgTW+VSma6jMfapyAb/t8harxIMjdU1fXUWkXhiZGWo7/TNrfgeAEFCDlbIEN
 Ik4VkvpZKKcoAYswSAtL0s4f1hMBz6Mdxq8s/MqTVjQ3gkfhQHI55uxXgo369PAPaeyA
 1J58WP6FI+U+cED1ATlx5BZLe+8y8nkZlFYG1Eap4tDdPKOgcJBD0BZhEKY84/pFLYD2
 kENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788351191; x=1788955991;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fQXNpl+z65+7sSy92Zs9cms4v9a3XKRD8E24DKM0/zw=;
 b=GVV35srjMZjUHC6yqBO9HxaFgDntf0lcQHhL50tuEBmRzqe5G6d/Lc87x/GOvOeyNM
 HD95pFyngvAhd/qEng0lssaWFjMcZfr31ARGzZ48dYRu5E14BT55dmc1KMWPavBQ93Ga
 kn2Jp2qvxJQnq2oCA8J3jsrU5dX+grvLWZ6EJDtvKWOeesFOXMRdk10BV1BTmIopGGh6
 RlbP1fMmqODAHxc3PZ6LFKz9Ygim3jtGnzXICvppUG5jYwN/0GPKanp9xr0Kt3vNYDxS
 0jS+K2TNwPYNSwbbo/bQ2k2SY3WL0xO15e/gZUTwL0fTgWZClG+PDSfUO9EZkdrJ3bZV
 gHLg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqAmfOhFOVCQOLGHB4S8ZrJFIGeaWiQtkXYrqgEWSHPUGSE9jc8v6qiB0rTcX6dxCfWIv11pqsUnn4E+NS@lists.sourceforge.net
X-Gm-Message-State: AFuF++nFD0kyiCJ6bc+mq+YaZ6BcAXUyrfaRTpOLGCA1LGELodyR559Y
 VV/QFspp6bIARMblRzVuxsf92pwOyLCzHBw1vpJIDcGAHGxIdVVINnKNz6OlVeQBnkFQVDfCAZg
 y1xqnVV7Re66AaIr0anJZIFt5/UdqZKFM+xgNGC08q1DFGiq/2V006gwkfioDKkC3I60hnerZaV
 m2kA8/+Q==
X-Gm-Gg: AR+sD10agoiq6N719HfAIBZHGpN70INPyHBKdqvQWz4bsRYTmdEG67AHcU68lEwHW06
 KbMoYXLyo2RRDidlvqt+ODdFndo7Ds42mT1UYhWcrKm4hp30MvZMt03sg+f9vnBm1pNJXfaALYT
 N9M7O9PEn8dMyCCViBKtNBIYW3GQw40dZOR9PeDk4hJVll4YrixHc4jOfKUEOQFQhvClA1D1wO2
 1X2r/Fo84IWW/ZobbQIvrWMTpJ4WqUVPJk+j1PdBVhvSXVNQnmntRhqXXnDxfBJEhH0Q02W98My
 Av44Ab31HJKZuJQ2Kyep/Fof81/OyFWeFcnk9IH/zaPkZE9OxTNy8gIDQ1BQWPMebl7fdYW+zmK
 feQ4pv28ldD1bvHDiBRMT4Xc+qJmd13MbA4G6RNr/MucwEdty01sqW/m74QlEidDsu2SmedJ5LT
 E7AMolkp4aXvc6Nx1a1iJQagUnCf1+NThA8pB6okfTi3+97K0Wc4uN65m+niLNNipauh7s40l8Z
 BA+pSrxcr3L7W4o0ESp4RBG0aV6UmC7hrcOzw1Fui2uWufnGdQTo7NTl+c6+/6dLs8wEqPj4nL3
 bjSAEXamR5zfEebAZyrwswm12QEpZds7dk8Ar5e9avMGYFGM/Xk=
X-Received: by 2002:a05:600c:c490:b0:499:60bf:c6f7 with SMTP id
 5b1f17b1804b1-49ce581f1ccmr63898075e9.13.1788351191015; 
 Wed, 02 Sep 2026 05:13:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5936a5esm22242105e9.3.2026.09.02.05.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 05:13:10 -0700 (PDT)
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 12:13:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iba66235cbad52692da542abd47e9f51810b0ed66
X-Gerrit-Change-Number: 1892
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1892?usp=email>
X-Gerrit-Commit: 0bdd7a5cc6fc5939af8f269f424538aa3692c45f
X-Gerrit-Comment-Date: Wed, 2 Sep 2026 12:13:09 +0000
In-Reply-To: <gerrit.1788295708000.Iba66235cbad52692da542abd47e9f51810b0ed66@gerrit.openvpn.net>
References: <gerrit.1788295708000.Iba66235cbad52692da542abd47e9f51810b0ed66@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4Mjk1NzA4MDAwLkliYTY2MjM1Y2JhZDUyNjkyZGE1NDJhYmQ0N2U5ZjUxODEwYjBlZDY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e36374a4963e82bdb82f600f4327d944414f2cab-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1jq9-0003EO-MX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win32: unit-test the
 CreateProcess() command line quoting
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
From: "d12fk \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "d12fk \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7628765781251924882=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7628765781251924882==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UuQ19hpKr/A="; charset=UTF-8

--UuQ19hpKr/A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

d12fk has posted=
 comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1892?usp=3Demail )

Change subject: win32: unit-test the CreateProces=
s() command line quoting
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1892?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Iba66235cbad52692da542abd47e9f51810b0ed66
Gerrit-Chan=
ge-Number: 1892
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Da=
te: Wed, 02 Sep 2026 12:13:09 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--UuQ19hpKr/A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1892?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1892?usp=3Demail">change 1892</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1892?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iba66235c=
bad52692da542abd47e9f51810b0ed66 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1892 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk =
&lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Wed, 02 Sep 2026 12:13:09 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--UuQ19hpKr/A=--


--===============7628765781251924882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7628765781251924882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7628765781251924882==--

