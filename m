Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0537C5DF94
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oDGoXnDCpO/IABhox6krPwaCDx9FvYCsNpl8n1iJblA=; b=JsP44HHwvTxoCDR4Vc76bAjhZ3
	aALwKw6uuRwIHqJ1roIMl5nv2CL+gTNRVb4ec4wyaXyVxxj6Gy3tRjYALjm3uvpnu5SBdwES2ihDp
	HG1txn7tTS5yZlwzqbWSGs7e6PvqJckmlD9+lng4mJbwTdT06JGXI5uo4gte2rY9r13s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyQNr-0007Y9-C2;
	Mon, 24 Aug 2026 08:50:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyQNq-0007Xw-2W
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 08:50:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UbzpZQbpyuPy4ve+0VqUZsGAak8YSoQNd549xMSNyX8=; b=TPEkI51DeKt4pmMQPcyb0NcAiu
 6gRkJbqR8IEfsafy/oGCVJcpmZiKhVOvBIYL0sJf0+zKBSOxcXoxHoWMDva73vWNHMA/0N+bYX4t7
 s78vMo1p3zgT8qNqgpEIw2DVIXcnee0dqEvK2X/SUT/9aAnOJxRdXdaSj/87v/+LXEG8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UbzpZQbpyuPy4ve+0VqUZsGAak8YSoQNd549xMSNyX8=; b=i
 ySLjaDm9zNwFm2YWNetJJGlm8+XdhnorqK2m9QVDHuLzYfNE+P852nyjyyfwxYs9aHWJrqNtK9J4p
 BlZ6AdpDsD9ySXG2Xl234PoCc1x3+RvN67rohWv6PZAPq8S0zciBs4OF7/UY8nZj82VbB2bkAbSwU
 zzgCAmHGjcJR6swc=;
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyQNp-0006AW-DP for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 08:50:22 +0000
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6a3fda88184so4926671a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 01:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787561415; x=1788166215; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UbzpZQbpyuPy4ve+0VqUZsGAak8YSoQNd549xMSNyX8=;
 b=eaU4MyT2OqGG8c52n3KJmCS5YQ50vu6VdIMSIocqTuzRg23kLLYJO+fKxrtVPcTxmc
 ejKTBDRNV4AWNDk2E29AgH8YKzJKWJpwcOakqugNqmuaYc7bT1+z1T+c/7Knq2nN3rAL
 /k14oA7QE/1YqTpr6Or/DSC13rT1UBjh7eZoNe3GUucteBo8Z0zzQTp21bqB3bmHEjQ0
 vjXKud1gBuofiBcvNrca56otfDgqxbOvksbQZLI43iaXT0VJeb8aSuVfW/hsRwtwOZeK
 ZvitQ3D/yXC5AmmxXRct+UrI4cGiIdA4mY/ZzH6AEjDd7ARDmWw128h1gKMJiQIlxBQb
 baCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561415; x=1788166215;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UbzpZQbpyuPy4ve+0VqUZsGAak8YSoQNd549xMSNyX8=;
 b=fCvga+W9PdqXAHEaydfn8tAYA9jikYmLHpttKyOFtPCCm5TIqXaicIsETl3VjXvxUU
 WF0HtOa4eg5ZTu76fmVAC5vutl6KmCJHH6ikjHvbt6ZtFSuUTRdn2evhxVHWQYnrhWfq
 U1EX1PeVyBly7cpetGaXQRR2mk0+lst/Us+FiNM9iSeQWzeeuzIRWeGqez32cYlRUhwo
 p1zI24++3Cwgh+1CqaY+uPz4mS2MdQiobSLtapgT6A9pkgthyZx3f+TxmAGxxhzxl8fD
 7HVeAiKd0M0ZuUvCIRQM+SX9ER3E3K14hJWNvQ8KI1g8iDgBkO6FeG0/kJIPEDypAJpO
 s2ow==
X-Forwarded-Encrypted: i=1;
 AHgh+Rou4vQkmOk1rzz1p0EQk1SqL1HU6qbsP2hMFz6sj9XhTk46OC5n7c8ZBMJqoEIuupG/1fUT/za11X+Vj2MK@lists.sourceforge.net
X-Gm-Message-State: AFuF++nsCz3hUtGml1SlbVIbV+FqAyvTbb7RYVUekYoh2EmAXmKR2C/+
 CDCEOb1Jaesf3MWSQa95P3diqHm8q05nl/k7CpHt4n/w7qyGXVOTrDrOGtSYlsL8Gc63IxrX6RA
 PGeFDNZ4ZObAWkqBlgfB76VkQnQd3mc20ops8yyqp0TKJOux9jCopZo/zWxRXZoXOfEZGUB1hso
 WApC2o+A==
X-Gm-Gg: AR+sD10f8W64ZUfqPgLr6x3MkUw95dggs9VGug755V7jM8QtMOIufRFrlQEqjhO+1Cx
 SYBEz34RfScB8rDibMZ6CzniOxCaiV15cx55zJjrgUz1ZZDPL7xvcOrXCtUyBYdSBQa8UmY47Oh
 xIyIBJkNCIWNRKFsi6GqBJKRa9iCO9xMDSVmlV0D3r9eebcGi3jAyA++LJzJC3SMcUImi8aqWcZ
 Ldx6z1XDW5zg/qTl7JTbFlIBVq9JmANx6kZdr6J/59ksD8PBuFeLdn/xCk7cEqHSgQOnP8rlvrb
 FZ7tWVEeEbtfZtRURrabAXQCHrgCr00+ItZK9ckdi35a7WDhTgG0QHvNov2h0Yfvm4j2qrKZWcV
 9j+gI9HK22DJ3Pz/FN8+GuLvsfbB+zU05MMWAblvSyzP1bqfkrhUr+oEGkEhKOhUArlrR0kkFju
 fIoFA6NQPkJgjfxzvOkLLV9TmfI678+5Kz8DZmKRiDWzcL/U8h+zurXmKfDPuM2tsagM4jhQj9F
 uYPINUM6H+ot/X4RLX2WC25wST2RdAsIkHyYtBgn9X7Icn4krv2bei+LIwaR36lhOGExRlVUOPk
 7tn15TM8Z2kWi/dSSVGMdLLMY3TKC7Jjn5Q3AvHZeZDOWJ1VzWg=
X-Received: by 2002:a05:6402:2186:b0:6a1:2400:baea with SMTP id
 4fb4d7f45d1cf-6a42f18a70cmr24030421a12.10.1787561414715; 
 Mon, 24 Aug 2026 01:50:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e00108asm11186230a12.2.2026.08.24.01.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:50:14 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 08:50:10 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d880
X-Gerrit-Change-Number: 1861
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1861?usp=email>
X-Gerrit-Commit: 4cccdf6e27b97d01e33a9b95ddc6ea1f1252dc24
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 08:50:10 +0000
In-Reply-To: <gerrit.1787438913000.Iec392a47123d618c0dbc3a5241c39da4ac83d880@gerrit.openvpn.net>
References: <gerrit.1787438913000.Iec392a47123d618c0dbc3a5241c39da4ac83d880@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NDM4OTEzMDAwLkllYzM5MmE0NzEyM2Q2MThjMGRiYzNhNTI0MWMzOWRhNGFjODNkODgwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a241b7ae70bf85aeec5c3516b1ccdc61c34ee19a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyQNp-0006AW-DP
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: fix log
 lines format string
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7036316262740292868=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7036316262740292868==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fNa7QW1zofk="; charset=UTF-8

--fNa7QW1zofk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos=2E

razvanc has post=
ed comments on this change by d12fk=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1861?usp=3Demail )

Change subject: openvpnserv: fix log lines form=
at string
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1:

(1 comment)

File src/openvpnserv/interactive=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1861/comment/8c4d92b3_b1aef36b?usp=3Demail=
 :
PS1, Line 1228:         MsgToEventLog(M_ERR, L"%S: failed to convert itf=
 alias '%s'", __func__, wide_name);
This is probably correct and Windows ca=
n deal with it, but `wide_name` _can_ be `NULL` here (especially in allocat=
or failure situations - `ERROR_OUTOFMEMORY`)=2E

So whether this patch is c=
orrect or not depends on how safe it is to pass `NULL` into `%s` here=2E


=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1861?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iec392a47123d618c0d=
bc3a5241c39da4ac83d880
Gerrit-Change-Number: 1861
Gerrit-PatchSet: 1
Gerrit=
-Owner: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: d12fk <heiko@openvpn=2E=
net>
Gerrit-Comment-Date: Mon, 24 Aug 2026 08:50:10 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: No

--fNa7QW1zofk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1861?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpnserv/interactive=2Ec:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1861/comment/8c4d92b3_b1aef36b?usp=3Demail">Patch Set #1, Line 122=
8:</a> <code style=3D"font-family:monospace,monospace">        MsgToEventLo=
g(M_ERR, L&quot;%S: failed to convert itf alias &#39;%s&#39;&quot;, __func_=
_, wide_name);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">This is probably correct and Windows can deal wit=
h it, but `wide_name` _can_ be `NULL` here (especially in allocator failure=
 situations - `ERROR_OUTOFMEMORY`)=2E</p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">So whether this patch is correct =
or not depends on how safe it is to pass `NULL` into `%s` here=2E</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1861?usp=3Demail">change 1861</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1861?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d=
880 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1861 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@openvp=
n=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 2=
4 Aug 2026 08:50:10 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=


</body></html>
--fNa7QW1zofk=--


--===============7036316262740292868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7036316262740292868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7036316262740292868==--

