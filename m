Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25304C5AC7A
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PYX69WKjyC6qsgnrH8pnuAdK2FGivkzhlmueDn1R4xM=; b=fVr8nBDqwJrxX5Uu4h0conIqBA
	ZWTNvED8cots+NMNwTKpTYW1uYMF1dziLeLAUy5t6AdgPkR13n5hJNcBjDdh8RxgCg7HNW1XFCmIg
	GohNtHs4QU2sMiF4a/TDY+ONlkyMLJJ6awFePunhm+0JSDI0jXpwxPZrd+/x3vzkb/m4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsMkL-0003AW-GW;
	Fri, 07 Aug 2026 15:44:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsMkJ-0003AQ-RK
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:44:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=s6pOxvfItTBHOWnCF974rE7PV8Vjin5zNie1vt7v8KE=; b=T9inVYYnOcuT7tJDsOdDK7MOHu
 n+kzoZK6VsPOi+Zhuydid+qIJOomSpkLmTBcnF+1dN9mlJyJWlYh3vrUNZeKeozbRYhvomKc3EvWH
 /84hrbCvsSb/hdpz2wh20O3quyJ0JJA+vYpWcQJdl32lus/xPD3zUT/WF/cfFGM9/wmk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=s6pOxvfItTBHOWnCF974rE7PV8Vjin5zNie1vt7v8KE=; b=X
 Vxzy1ARc+Q4/bZouFW3V1Rsvn7Js4VuqSLfabB1fCyGNuOMyrq0afBg6xBzOVJ4RMlXEglRl2iQZV
 +b68DefEKAJWdLFxPUM0F5WdClwkR4UDnngQNIP0TxEwUk2CyHCumLz0EN8CdZ1WzvryXUjZu1UMB
 TeLOOg+oQ0ToDJzY=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsMkM-0004qO-Mw for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:44:32 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4807df69172so383518f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786117464; x=1786722264; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=s6pOxvfItTBHOWnCF974rE7PV8Vjin5zNie1vt7v8KE=;
 b=eOYOhUpR2JZdqJUViBHtcfSJoiqtLr9p29V8KOdkzxNLULYscJPzrWd/aKIAwfvBR+
 XVl79MvMSs3oVeoldEwwnSsTkDxCNow80a8jl6/8CE5Co+FlA9eHOgoYnxdg01MjCEiU
 S+bqIhQgAJIfn5q8WhT+dgB63AxYxGIZUlZ5zgfqi1aTzFaDb/Lshff72ZlrnVCCusMi
 mD08n2Q4N98xAonNqTMu/guXAThJdoiXMEdJWB+AJLLxKKps1O6W6c+8zAT6fXedMJ41
 BEzxqGj1VS5USHi1ntKLrD/JCP9L7n7TdtNXdze4274etUR1w8t+4gXE4kGttyO/YJ8h
 oMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786117464; x=1786722264;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=s6pOxvfItTBHOWnCF974rE7PV8Vjin5zNie1vt7v8KE=;
 b=qWtmwj/cWSXCzVjM6jf7civmSpCyfLEKj2Z40nNDtzLub4uAWy3WwjHgKtk7HHtUE4
 jDKxoHT26ydwZrU5JzgW1sl3T1ZfQjePaQamO+e+/SYwP30ibP11Ul5V7qqKN/bAZYg7
 K2AdTdMK+8fzWJ6XqxGCtLv4yR0ZFIjdt4lkn9akj1JpgLzi0up2r2bKL8LzofyCewbQ
 KIjQByHHI0YOZC9dvlZsjNLWy7MXSVSMk0H8pf3jv06cqE0qhPYwjxpDkkly1xLxbYsR
 IPlb3oH3JVo63sprkfv/9jUQlP2IKWvZZquZMAloq2ZA7uPuB1kIeMrvia8DgC3k8VFY
 ZfFQ==
X-Gm-Message-State: AOJu0YzR/D30bxYK1vvFljE/YSD1QcsppJyBOm0ovAfBvUiKrGr994Yn
 wHWQTujPgvhSllYhb/UbcKSnP2ptqan4hc+PfMxQ6FeXnP5C8lwI4z0hJoq5rTkouk+BFiOx9k2
 8a3QneC10qrofJW2uzufF9J1o6vb0u/1de1zQ9NGE4bhlv93oT8xnB5sJBWDS+3Xw8UBFRtk5Nh
 k+XwmZSg==
X-Gm-Gg: AR+sD12uu/hIBIgrVncPiZK35/lZSOjiHubQQBn/bEXnVqZhzkYqlJvRtF3v0HbZzj1
 rF/ralckkHl07qgq9YnDqUaTCo8HBMotdfQ7dHbDfOAEHUdaDfeNHX7yWShUPyNk1J5Puoz+ml0
 dQ5UbWOQfBPSQtcE//g8kHadyDVgG61r5OS6CprMOiwJuhh6uHAftYhZaIYfJB7qzcX4+XupksS
 E5lYMRM3ivadrTS3vrakMvMrUNRiz4oLW2VuG339LbH0oQrafHX/Iei+HO8MCqJQhpCPrHoDswp
 j1F+Hd1lNIAqdGSyuSOz4EVLvgjJxOXO1iBRhmp0rtwj2VZsCLG1qRv6xwUyOIkfFGqjx3NkvAT
 J+GtlC4ZnGifxQcyBfseBhpuUFfcD7DVCtMpvDp6gba1qKHU6zehLkeQpzJ3Jtu9w6srxGbliK4
 pa1bDla4gpgaL7+fnxx1FxLQyVd/pWE8QZFrvAqw26Ps3jVbwTQ3tdZ7wYfwS6RN9vkdsC0XEYn
 ts3ktsqUdQN/Dg7dFO5v5pH2wL1+LR/9ZQRko9F2whCMvMqh5hFGJbmbr2E3gw3OWiBK00h2XWq
 OuROeY4JUN+HVztKr0ecjjHLwkFlM2+Oa3ju6++oVmFesu6wH+s=
X-Received: by 2002:a05:6000:460c:b0:481:2fff:2a09 with SMTP id
 ffacd0b85a97d-4812fff2bb9mr2964339f8f.14.1786117464376; 
 Fri, 07 Aug 2026 08:44:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800220a6d9sm7351790f8f.34.2026.08.07.08.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:44:23 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 15:44:22 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
X-Gerrit-Change-Number: 1763
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1763?usp=email>
X-Gerrit-Commit: de4a268fe490245fce4a6443a886bd6aea8ee893
X-Gerrit-Comment-Date: Fri, 7 Aug 2026 15:44:22 +0000
In-Reply-To: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
References: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMzODUyMDAwLkkxOTA1ZDk0OTQzMzZkYTRlOTFmMTk0NmQyZmZkODc1NzIwNjA1YjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c101f46f7dc2ebf5cf0dc4fb3068ed99ca27bd2e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsMkM-0004qO-Mw
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in: Add
 utility function needs_openvpn()
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
Content-Type: multipart/mixed; boundary="===============2831287753123786324=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2831287753123786324==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hWy2GjoYicU="; charset=UTF-8

--hWy2GjoYicU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1763?usp=3Demail )

Change subject: t_client=2Esh=2Ein: Add ut=
ility function needs_openvpn()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(1 comment)

File tests/t_=
client=2Esh=2Ein:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763/comment/0=
8cec795_6020fd06?usp=3Demail :
PS2, Line 79: =2E "${t_client_rc}"
> `source=
` is a bashism=2E
Acknowledged



-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1763?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
Gerrit-Change-Number:=
 1763
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 07 Aug 2026 15:4=
4:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-=
To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: flichtenhel=
d <frank@lichtenheld=2Ecom>

--hWy2GjoYicU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 2:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File tests/t_client=2Esh=2Ein:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1763/comment/08cec795_6020fd06?usp=3Demail">Patch Set #2, Line 79:</a> <=
code style=3D"font-family:monospace,monospace">=2E &quot;${t_client_rc}&quo=
t;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">`source` is a bashism=2E</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowl=
edged</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1763?usp=3Demail">change 1763</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I1905d9494336da4e91f19=
46d2ffd875720605b41 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1763 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri,=
 07 Aug 2026 15:44:22 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </d=
iv>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-Repl=
y-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--hWy2GjoYicU=--


--===============2831287753123786324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2831287753123786324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2831287753123786324==--

