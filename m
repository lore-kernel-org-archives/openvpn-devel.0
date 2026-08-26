Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075CDC5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VlLzae8E6hq4iecL311AI/awAj2TgYZW6of/G3AJQFk=; b=iqC719lDYhDshvOX6fMuZL+owg
	qtVRAcJ11i4zJF2XWrzU4pefAECuehtkhTwzFRMhrt5sfKgcgltUe7IffqHB6ZGM6Mb3xxRCjhf7+
	vieUSN0Hi5HuyOhBumXNzVHg8LtYfSWP2xdC0XQdZmyVMPf0W69qS8Q+ta3TPE07hNBg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzFYr-00027o-Cn;
	Wed, 26 Aug 2026 15:29:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzFYq-00027i-16
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:29:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dHYg2L0PdbSj9ZyX4ANxZozn4GWXZOBWrQsxEHapg4M=; b=f9WKEQauUaPcPebb3qfhT6V6ge
 rukMraQeZj7HxnQ+immmEzn3sYepyjvhUaGvQ+S1ZfvnxCIa2J9CPFR4g/rGlRy9i9luIBz9eL260
 5gzWac5GpdXs4YpopL4oewWZ1haA9b6M739Jrxu3NN7L1484gZftw2Q7E6Ql44uyFIqk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dHYg2L0PdbSj9ZyX4ANxZozn4GWXZOBWrQsxEHapg4M=; b=l
 EKItJm+ax1Bg/gr2adnt9vefwJFH86NJidNJGMZ7EFB3HViPVfZ/cm9eWcjZvdFwazP+rV6Edg7sx
 XV+vwHuzFWM7ni0PGwQv506gctZkJrauvkEIHftSAXJvXd6BsGf85UkFYVWgdCB7a/vEeCV6HfzUd
 Q4Od+2JypezMaL9w=;
Received: from mail-lf1-f51.google.com ([209.85.167.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzFYo-00088R-DF for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:29:07 +0000
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5b28c91fba5so944e87.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787758140; x=1788362940; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dHYg2L0PdbSj9ZyX4ANxZozn4GWXZOBWrQsxEHapg4M=;
 b=C+Eu0YDDt1nPAJTLfh8Zn7x9pCXeLy5Mwg4GeEOIewMwHQyYVBWHEWOG+gSsU8uxx/
 CTQN2vB2XH6B5mOkQe5nolwb/tCtH43v0Z2J+b3XQEDnjE06fgzwgu8FePR3WYxznmtQ
 354pSmpRtWdyIqmfRNbV3QM43IkXOHTabzCabaExsW9Hd6Sqn4X20putw7E7OmEgn2gv
 gnk1MW7iUnsgal6x7p200IhdPfbmhUzNJFCMuR5yYc+hJhg81xcUGG179VA7lDSzRk95
 o0X66/dGRJw+XXzqRkFsi0KHdvZr8wE96Q6YB+J9x5SZ/P1XqiLBhUohao1hL5D7vYW1
 IffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787758140; x=1788362940;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dHYg2L0PdbSj9ZyX4ANxZozn4GWXZOBWrQsxEHapg4M=;
 b=hRr2F3uucuwsuveK4FjhwqoHir/BVgotwOiwKuGnPk0J4wxgLoe6nS5ST+S1V/0xqb
 +u6N9LlrEO5hGIrNDAN6VPPLeXJwmxHzbpUjr3TJFtyst4hEAGYuQLtUjxU/G86TmV5K
 2kfyotgYXpTMNWhiVPKnFScEqdkHtC78M1gm3kx41X4MmR463h9KjH52vqo/HanoKp7C
 Zch0sotR8ndzHMY4laC6KRDNw59/Q/xqEyADeykWpMQFTBHIqsq/74/FRMsunXeij0Kq
 e6IfCwAlxBXzKqzGW1cSyjEcSNEz9VwrTRRlo6S6LUTKT6AP9hfxYeH0xd/K73xmF24c
 w/ow==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPWaLFQVqVjpxxqRtmiULEqdd5U834Df1PfbdcrdZQ+GyLhLAIwkf+X33L6cT/RAn7UD4tVgE+cYZgFcFE@lists.sourceforge.net
X-Gm-Message-State: AFuF++kB1te4p1TyI4VmRosvYiAYxIIJnJFY1EAkOKEFdH7FX+i3MSV+
 j1KnKwqil33sxaAIsRCTZAYRd29x4WxlXsYfkYxhGguzjcSq7JCXppwyWL/FNP5OZASm2aCgjvI
 Q3o5sJDZ70317Mws6jE2UZuxuJjm9px8aidCZIlmqXPauzYqJGQAU/osz8Lk21kubqsTgaa3ErW
 MalEdeXA==
X-Gm-Gg: AR+sD11OrMuXfa5313A4BtsbWlfAcYGLQHlzJ60T4HdpPXeLukjAJAEjwN5SpDELB1B
 RIlrferhOm5G1mY+xw4DFHd0nLK0zh5eSLPQwNn+nRUrJqPpXY5fF5c6VMoVRXQRrMNtnAvQBp4
 9UTIgnH7XUqy4oFn3KWWY/fshIyum3zYbZfkusVe5DDmv9Z9pCOH6S+hQn8EXBaB94rFdAEqPLJ
 +QAMXf15r8OFOJ1QPgj5SHQ8eFZ44aokKBg3ILbJCei1XH7JbOjANcLXdq/VJOJhtaYAYB7ssFj
 nn0t6xHBV19lrz7KD2Ou7zz4hgyL+sEbisusZwXJzRuHZKEQypkzb3z7LULkYdTqxyKpjbkuJV/
 7mUjobuIgc8xZf/Fnsl2K8D51mpHnf0HpxhayB3YougdpHJ+L/NEiRUcboFj2hSf5b/rN3Gewh1
 L/dGNoORzqFOW7nTXXqbuft6P9WKqoM1lHRu7mptih4f9yvdqSVtDagNuEuQLiYBSWSXbyWQvfq
 MBSDd/Qbim14iX1WMqfHccjgHKiym8rbzdlbObK6mIh1i8iww3UGRdA9qsPIEwz0NyYLJSDrYzi
 hcEATiANJ1DIYKek++JKXuG3JcL5cVNPhaM0ONk2eyFkLqOvoAap
X-Received: by 2002:a05:6402:304b:b0:69f:c929:b88 with SMTP id
 4fb4d7f45d1cf-6a5df3014b7mr6283195a12.5.1787746014034; 
 Wed, 26 Aug 2026 05:06:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8b6412sm3857454a12.2.2026.08.26.05.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 05:06:53 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 12:06:50 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I41b9f7686180f2549bd4984cbbf66059f0ba2b15
X-Gerrit-Change-Number: 1259
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1259?usp=email>
X-Gerrit-Commit: 4ccfed975151a7bb0601eefcdac5e847c514cf24
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 12:06:50 +0000
In-Reply-To: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@gerrit.openvpn.net>
References: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU5OTM5OTE3MDAwLkk0MWI5Zjc2ODYxODBmMjU0OWJkNDk4NGNiYmY2NjA1OWYwYmEyYjE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dd31612160946cac9e30189c1dcca57a685d6fb2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzFYo-00088R-DF
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: Fix conversion
 warnings
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1036547182340082810=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1036547182340082810==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t7jkcELkZEk="; charset=UTF-8

--t7jkcELkZEk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, razvanc=2E

plai=
sthos has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail )

Change subject: init: Fix =
conversion warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 20: Code-Review+2


-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1259?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I41b9f7686180f2549bd4984cbbf66059f0ba2b15
Gerrit-Change-Nu=
mber: 1259
Gerrit-PatchSet: 20
Gerrit-Owner: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
G=
errit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Attention: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Comment-Date: Wed, 26 Aug 2026 12:06:50 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--t7jkcELkZEk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, razvanc=2E </p>
<p>Patch set 20:=
<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pa=
dding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail">View Change=
</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail">chan=
ge 1259</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I41b9f7686180f2549bd4984cbbf66059f0ba2b15 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1259 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Wed, 26 Aug 2026 12:06:50 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--t7jkcELkZEk=--


--===============1036547182340082810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1036547182340082810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1036547182340082810==--

