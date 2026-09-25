Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDB2C98321
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 14:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G2ZM4dJmThbwnbY0lPmivkDV4yNtUhdsxwQxKHXvmSo=; b=m5V74j1SnwS3YYNCWXqv98J9ez
	p9o/GhWTyVsqh3/RuJrIiVv8RtTPoO5WMM7ZTUEtcG/aOAXE+QvVBCICO2xoMeF2/UK+TZapgxqD4
	XwXFUI8qLRtPKnXIUil500ucVfqLWL+vJR85hxMFhm9KV8dkl0JmjxAxTOkYBcSe4wLo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA6kv-0007oJ-98;
	Fri, 25 Sep 2026 14:18:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA6kr-0007o7-2s
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:18:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vlBf3JJb6htc3cBvm+md32HCepp9uSh0KgamKUzdAoU=; b=VMClXVXGUkPYDdnlaNBd/UiM7R
 RU2OJOxoXv5IEZHMzX6dOZmRtsIfrkLxsKw7SUfiaZm7vheow3W0l/78q5lHHyUCsIWpa21P8jM0N
 1WFTxxuAkcxY6euS8yd2s3QplQp6Sp/0BneGEG7uSgAl+iBPmcxFKRMMGwnPEdbtrIuY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vlBf3JJb6htc3cBvm+md32HCepp9uSh0KgamKUzdAoU=; b=U
 rt9EZuOiKThh3XdZ6ZHaYmP4KBSST8GY0Qe3QnQkxpfeiICaB2lwmvgeHzhgcIufAt8ZA2DEdeRcF
 lWvPesBADiUwdgOd1nk6AXYMvBzrqnXVoA5xQ4+pVWZSfSzbFIzrc1QSFqSpPeTxkggRNEf1nMCP2
 ZVJMQqVw2d2tZEt0=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA6ko-00076y-0F for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:18:22 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso2907775e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 07:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790345895; x=1790950695; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vlBf3JJb6htc3cBvm+md32HCepp9uSh0KgamKUzdAoU=;
 b=ViYIIUg667H+dDh2qBQHT84s54YUDxdBNMUWkJ/OzNgMjVKC7iDerMzd4wTrqZBLk7
 CuPC50edQDDqv2UuhrxZ6K5bO8QyMwfuK+3qNyfDhQI5NFHGB3ei/d5ky7ArSwZ8AhOs
 ZK1ycffIdZ9DzfJ454oDchqz+LTXcO1cnpimXfLlFRXXEtb0lgy1GMrx3Z+nA3DAarIH
 BcJTCoQlsoxKAWQbooQf9UG/M8A6sDZuy/f5Lk/NHuE9TpDnvE1ILajaoTgxs5bN+uau
 PvWd+CtkSrmttYjTBxUhIhckCF2dzsY/kymED6hb2fSdzwyV549AIxWRIixaNxQibudG
 jLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790345895; x=1790950695;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vlBf3JJb6htc3cBvm+md32HCepp9uSh0KgamKUzdAoU=;
 b=JJnIminaI8XN77VYlFYdIXeR8GclpZwn4BI3E6zlWx9NJmSy91DI4v7TM5jWlD+ZF3
 GRPZflVB3gMmbPzHSPJhqgzYJIhu184r3/W0rbg2QyPggPaP5q7iLn/wRCnOUGpYSybQ
 07kJeWGClh2CyRcRY6aGk/5MAqzrvswFb26vKu4SuxotKaX/fThabIjkNIhx2D3Da0+W
 fcd3+ZqUNAtdO26bnX7tyD7iKvtNdNA5b+OjoxDzPnFBtWjkxPcau5QDXsWsmUBOQaTt
 ajHjrLO3/nxTzuwUdsunXyQyIWwKXceA66J+F/LTZFYsEBrW9f23wDsGNMfkGOxeAAcg
 zJ6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByGGfcYqE15gKjF28wODvvyPXYQqKo/0ZkcmQZBM63UPIwcjloExIbOrCLMpmLVStMkFLzP8T/baqY/RUyT@lists.sourceforge.net
X-Gm-Message-State: AFuF++msLVjJQf0HRadZKrNsNLIuZFLZ/5jOBzyZ9D5s0ccRpDTyCpBj
 AkdTrakt0rU6BbdL7hj+bgFuvVDZZXp+v1ZwGF7sDDocdrH14wB6C2Dnw3pMubrURWfG8/vFUcf
 B+BnqO1TdaVtDNAuD/vXTLl0XAXLQq0B/J2x+d3LhFWc4umdJF4JbS2B8TQPqQyC60XMK
X-Gm-Gg: AYBFou1VPrres+tnK3Tx2x62NUvG0uO95PMR3/olPa6HEAjI3A4MZ86jKuy6IKPY4+M
 jaXT4170OFOF9Z5Y0azfFiOWAmNzLkvSrBYW8dHgoWpbt2bwv2U2ORMs1nly5cxOWmXKyiwvMTZ
 DImlYgO5oWNL8WHb4wBP1H/m0tD7yscbOUrV/sR2qyGhq47gsGc4d5+CPcPoIsW58LOnu1HeaCi
 hQ5EpH5kPGXAyifjT2NIKRLUlmTHhb+2V1m0aJ53te6/82QpLnVeW2/3yqRWLv5B6sd3Rmi7Yay
 RlDZdS3jTDNj900F246AAi9z3cHmhDWTXZAvMAwkQW7SMcY7k/tS0Epz71UuhLLTjxZGtEhvxLz
 ioT/ZQwYivfFETm0ww5Mbz3V+ZCVd81SJg6oTgc9Nn4K7bDtslkItS8laEwm9tGrPNXzc6xPa87
 UIErNXftWKZ54P4bd3xH//CiSDOw+0p0Dedufra7Y+9T1Tj0s1c9+fzPmHuOfzAmdybKWc8o3jT
 I8yKXL9iNvz1O3l2UtHb3wLAbbsD7llShVKD/EJ/AzxoSqgbF5RGx/aaJ7nYlHyqpxsTeoFqaR8
 bwTpvtPlfqRK0DWWcEEPxuk9ENB/vUe2vU9z6DUPQS5GQNhOND7L/roM/APK6A==
X-Received: by 2002:a05:600c:1d04:b0:49e:63cc:6324 with SMTP id
 5b1f17b1804b1-49fe66d0606mr102503405e9.6.1790345895095; 
 Fri, 25 Sep 2026 07:18:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff27eabc1sm65409675e9.15.2026.09.25.07.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 07:18:14 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 14:18:13 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
X-Gerrit-Change-Number: 1952
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1952?usp=email>
X-Gerrit-Commit: 5655c770a96630ceb381007087759de61afc87ae
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 14:18:13 +0000
In-Reply-To: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
References: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzQ0MzM2MDAwLkljNTM1YmIxZjBkYTE3MzlmODdlOWQ2YmVmNmZkMTA2MTI0N2IwNWRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <994a5f391c51ec85e668d141a698fe28ed52d39e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA6ko-00076y-0F
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: stop fetching
 peer stats during client disconnect
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, antonio@mandelbit.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1897167828876846321=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1897167828876846321==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SJe8Rha9mE8="; charset=UTF-8

--SJe8Rha9mE8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

razvanc has =
posted comments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1952?usp=3Demail )

Change subject: dco: stop fetching peer=
 stats during client disconnect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/multi=2Ec:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952/comment/83aaef13_b354ec76?=
usp=3Demail :
PS1, Line 507:     }
Could removing this here end up with sta=
le stats in some corner case? Would it be useful to still call this, but so=
mewhere else (some "global" uninit function)?



-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
Gerrit=
-Change-Number: 1952
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@mande=
lbit=2Ecom>
Gerrit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg=
>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 25 Sep 2026 14=
:18:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--SJe8Rha9mE8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>razvanc has posted co=
mments on this change by ralf_lici=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1952?usp=3Demail">View Change</a></p><p>1 comment:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952/com=
ment/83aaef13_b354ec76?usp=3Demail">Patch Set #1, Line 507:</a> <code style=
=3D"font-family:monospace,monospace">    }</code></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Could removing this h=
ere end up with stale stats in some corner case? Would it be useful to stil=
l call this, but somewhere else (some &quot;global&quot; uninit function)?<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1952?usp=3Demail">change 1952</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1=
061247b05de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1952 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D=
"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Fri, 25 Sep 2026 14:18:13 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: No </div>

</body></html>
--SJe8Rha9mE8=--


--===============1897167828876846321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1897167828876846321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1897167828876846321==--

