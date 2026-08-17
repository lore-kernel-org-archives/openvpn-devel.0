Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DEAC5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yvEmM+6nGQ9w20bP36S+RC2XEENGNU3JlQ6T1ugA85Q=; b=A0/hQF2HAIVrRR1WCuHEuVikUM
	yYV122MjKZ0gn1YKAdNLIZBSGtdDtYVq0mXCMLDZE+NIqipyCHCtlPNvxFVoJDnrAeDmZhJ7YLlMD
	0Pp0hHK+bHnXo4O0PjbNHvGFgSOHDbRj5TajVNtpTEM8FQY/TzZB+dO6c8a8CbXTwfqQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ww27K-00013n-53;
	Mon, 17 Aug 2026 18:31:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1ww27I-00013h-UI
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 18:31:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3qL8EHp4GlhnGYPb3VJUDL/7+p97nuJ6VckDJq4IMIc=; b=M+/17Mr76o5Mwwh9LdpjflFdNq
 pPZb3RwuePTIj/l5e/GX1aj7K2cpXPTWx9fbDAkZ2u1I4+S64sagHBK3tdOnGvabmc0xKr31JBOie
 52pSK4FR1yHT1Fdis+MdpGZfE3LPBXwdMtkyPtmRwx9ZwEqExmV/p0pdfT3XYLQcE4Zc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3qL8EHp4GlhnGYPb3VJUDL/7+p97nuJ6VckDJq4IMIc=; b=L
 4LY5eSTU5yhUm5ytt5dS0cU/VZlEB6CIowDXfeQc0rhRZiMItsXPo2laVXosBE1CuhrehckktO/4X
 o+itp6974e45n6PH6FGRXMjEv0JEGpfcIegpozzRs8HHOr2niVijVoWWprz1b10B1jyZ5PtXyiYgP
 dIpLZyQLPfr2Fv18=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ww27I-0004lk-Jd for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 18:31:22 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so41309735e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786991474; x=1787596274; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3qL8EHp4GlhnGYPb3VJUDL/7+p97nuJ6VckDJq4IMIc=;
 b=JTtAUkwuJI57VkvUf8SPT6MMCQs3KT4nxTnONqcOypDALlFffjKaufnR8nGFvNvnGE
 2v3pqqZNwDvke80+fIY1/0ck+GEa57vL2paelZKYfGJhalGf9bEeE/U3L0mVkB5O6kP/
 gmf4S99WEMddC072OzpZKVFAe6ZkO6ab+2Z6FMK4fdkUjS9FZVZj0UjwB2xsxuyjCbYI
 76+8PJiKDa7Wa1f919wASoUdqWkAguwhgSHqNLaIfVWdyOmNHjHNbaugNB7pakm6pKq3
 4lq1JHmfz0gqveTk3p3Teq6WiWbMgB2RLwGuTJRG0XqU6rrHy7kRXxxptNzWho3eAAA8
 7ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786991474; x=1787596274;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3qL8EHp4GlhnGYPb3VJUDL/7+p97nuJ6VckDJq4IMIc=;
 b=JpbJT5A/MyhsoAmsBMYTb2LoKw8b7786wmDk5N5BPtZ883R77/t1cNIP8WsQtESX/W
 tjIpO4XHYza0bisNH2Woh3qRpteuyWadk4u+/oyEeW525PFVDp7q6w4kTX9cmt1Zn2Zp
 eU95o8PY/sr2UB+soDT76hW2GLDUyFJw/bgM8U0ou3FgQETDZcpKG27yanSAloh0zWHF
 01x7bXpOAqFL+ubiC8V3YncrQBlqMJbv/B7nshQ4rPbRYyaZMDaMO6CscOs55K2f2oGj
 nyBadM/H0tRcA2uohTKrq/clDOYGFyyKesYayyojtHXgmjCf0pj3JxHwEZWAbqcPrR0d
 ydgg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rop8752E3XsxD2p2E8R+GAJ80dkzm2v+pt9Na6JUd/leTnNReM/9P46ZUTxaENg+8jcpo9RczEHr4EGYmtp@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzjdu6RHcynj0Ud/DCf+VH+CdwuXP3h0+4NDmhAOX7DG4zk/K9R
 8jlJfLPORnQIasXZiJorLs4F2aoV9F6CR32+pXiY6nhxqMYAu8TYeSCktAQ4IPr0WmT0xtXe5c9
 Xvi2Z3EL9Nz4WP9yPpzL28t5kYFPoFBFq3Uq97cIFgsd/9c+Zf7zQ0G69dwLmqg98bWzV
X-Gm-Gg: AR+sD118DGLGO/Wa9mjlJwCGhifQOu2NSBKU80wCJluBe7duvHAMmy6mnA1ZbLD3hNq
 ip0b9StQl92puO3hXfMy+wfxfd4aQj4w8vXjRuFuZD9Ng14Jz+oo0fZUvnmKDPTJBJUSOFXkl6K
 Lscq4p9pL8yrMxzhGCCxogSGqzKLllMLDRnn2tcMFka3votu0v0n4fGbf39ef27+EWfRDslIqQL
 q6s4k/Ou7Z/0ZFWIlNSZlZKXscLU1Z0XUMeH/IusHUhnqkFQdmbAgGwXSKtojCuejLTw8Fo2KmL
 Pjeevc0Ef0vqODmGxt6pHa8nlxRdp9knH1Tr82Hjs96IJgRH4oCvXUZ8fk4Z+6FTcH57cFV5IkO
 8UCHDBW2NIRHn01GTrvA8YlwOaEvu58MbDnByitx00Zm4zMYxKphmGhBSVaz4NgfmXXn1cNZN7n
 i4EJWcnBBNd8XJRnILmK4QcfNp3SYOfBMOpfIEUPoQkKOLtSTLzhu1U26y1fqzlQV+NepZAziGl
 RRepRPWvHyaMctu6qxdLJBwe8bmRCEo8VBYMnu83w9I+4NkIAhUk9/Da+17O84jezlZ/bFGRApI
 dGhBqR0iLbPEUSUY0aNobjRyR6YQNoX2ivVik5fUXfntPfBCQqI=
X-Received: by 2002:a05:600c:3b23:b0:499:8ae1:b900 with SMTP id
 5b1f17b1804b1-4998ae1bb69mr336835795e9.12.1786991474442; 
 Mon, 17 Aug 2026 11:31:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d06167csm63427595e9.3.2026.08.17.11.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:31:14 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 18:31:12 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I450568c0307a6372506d115cb389d172472140d4
X-Gerrit-Change-Number: 1845
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1845?usp=email>
X-Gerrit-Commit: 67d8b92b41b94b3e838a692e67a6139416e9952c
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 18:31:12 +0000
In-Reply-To: <gerrit.1786968495000.I450568c0307a6372506d115cb389d172472140d4@gerrit.openvpn.net>
References: <gerrit.1786968495000.I450568c0307a6372506d115cb389d172472140d4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTY4NDk1MDAwLkk0NTA1NjhjMDMwN2E2MzcyNTA2ZDExNWNiMzg5ZDE3MjQ3MjE0MGQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a3af67b86c72116d09ceb20b4f2532661eddf18b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1ww27I-0004lk-Jd
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: buffer: Remove some
 useless casts on BLAST returns
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3416645040193846607=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3416645040193846607==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fzsQ47jLl8E="; charset=UTF-8

--fzsQ47jLl8E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1845?usp=3Demail )

Change subject: buffer: Remove so=
me useless casts on BLAST returns
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1845?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I450568c0307a6372506d115cb389d172472140d4
Ge=
rrit-Change-Number: 1845
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Mon, 17 Aug 2026 18:31:12 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--fzsQ47jLl8E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1845?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1845?usp=3Demail">change 1845=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1845?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4505=
68c0307a6372506d115cb389d172472140d4 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1845 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 18:=
31:12 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--fzsQ47jLl8E=--


--===============3416645040193846607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3416645040193846607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3416645040193846607==--

