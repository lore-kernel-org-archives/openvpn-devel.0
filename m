Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC41606A336
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=L3NRumtJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TlTi5Gxf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=M3SpsUst;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PAO6aBk4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hk46i2NodeDQEQumG9+UlNj63+HByedq+a1PG/W3q3o=; b=L3NRumtJwZo41QrA+94dLfGsad
	OfiRzQ0YNDxNCcoMgsqMibqrLbKrBLmHKLnXqFhsXAPmovu3POq2c/IZOnwK/XfL94i3hf7vPVvZW
	O45fnUMDLPh4gsVGCJoB0nWl2gwto1FzmkKep8eqpqBn8hOuDGClH+lKhjhKHFur2qqQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVteR-000000007Vw-2lss;
	Tue, 24 Nov 2026 16:45:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVteQ-000000007Vp-1UvO
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:45:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J7GinNLba2kWZuYp5NKvUg/6kdum2s0lQJxLX2vqh8A=; b=TlTi5Gxfhu/F2XgBkPi+YR6lDm
 vahbnOp6EIViWlCiJiieVbk/NZkNTWNjl85WOBFMWbdK8TsbX1y1cLO5XajR66HfSG88Hz6Fv8ziH
 ef7sxino+2vDVtQ9bPKTIUe2QQBBblLxi4wYg9LSj0MMgEf79NsAxg5wn3FwlXEUL62k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J7GinNLba2kWZuYp5NKvUg/6kdum2s0lQJxLX2vqh8A=; b=M3SpsUstROPbtt3D/S8jE+/DkA
 KI6oUpOUsIiBCXmb/m2Dtj6g0uirTxsoSf+H7s7QsMGbkv/ZZdemGOOyeRVTMc896b3FjOYTHF9Wt
 WuUcUvu96NCY7dewZonsj0Myhde7hIR87zML44zOKLV7cqFh8XQodmGgPH6AEs4gzp2A=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVteN-000000008Vj-33bE for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:45:50 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso3469161f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795538741; x=1796143541; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J7GinNLba2kWZuYp5NKvUg/6kdum2s0lQJxLX2vqh8A=;
 b=PAO6aBk4BeoQxnA1kRIGz3ITTcGWg8lcbugo0A05fEiOOGEdgR4qMNUq7tLzW7AeR+
 Idv0AfmxAJd77Ukak6H1M9hJxBGloF9C9vSLsXcnNlomkFcXxpBuGWOO5qKbQqmtrXVi
 t+CZV2wADQ5E8Dp8eldC9U1cJbuRD6/j61mi7UM9F7z5MuKEPJ7S905BgVa9/jqiH6d7
 dB1mxs3hA1ew/tpZjuxEuZmjIvn1jSQ+Vwy+ocYzeGT6WqOAV/4XUvq5HVPO3QMSQNPg
 GtaA3Jbn41k7+4T6AIKNlF3A6MGCDGZk3M24uYRlXfw+2Bn7qeSbub/jJh5WSf4qI41V
 bEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795538741; x=1796143541;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=J7GinNLba2kWZuYp5NKvUg/6kdum2s0lQJxLX2vqh8A=;
 b=BMHteXkSsN9jxB7tUi6rxsd7HUgK8SHZYRZwgyTcdVb1REbTcM/7HS9APV0PrzeR9I
 AXMWiBN4m/3XEVoOeOKSiQXdiFjQp+simCp5nc1R0VSrftfo84YsIWGHhjugbExGnueI
 X4NgheW4Gx1e0+H4rrxdF2nc0QY8E+fW+NYwvM1RaW8y8ylqgZRu8+k8aqHu6poFoS8f
 b/Xy3k8Hwpk/ciERrQk2R0VKQB13QkVZ57GototzH39wZLqUYOL3Z2abiTT1ComYL8jD
 Z8Pihal4z66OLCf6/JuoZgzWTSamWdCajVLE3eo779o+wdlevZ6bQYYndqjYKdSYS8Iw
 LC/w==
X-Forwarded-Encrypted: i=1;
 AL+hErFwhtwXCtjYViiZtjgp8PeBIWGQFQA/noF9G65fTjAMZuhZeKcUN4DnLDw/Pyg871rqos4GH28BUYlO/aQg@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/BcqtZ52pj26cX1Q6x241FuRkocbLZGzKwj3F2g5u5JVERUbzZ
 cOqNnn2cCABndmkZDwWrko6H6fksOlaq4Ot66fxEuGrCnN2h0lHIniew9z/XpRxIfMm18AfoM2t
 Pc+Op0EDLpa7Oys7DJ+y7AeePszKct1JK1/b8Ccl0oS9WRRrwDkRNbHIK4GEsXDb054rdILQXrj
 5pJwuinQ==
X-Gm-Gg: AZFdTZenbNQHKVJaGm2lBQkxEd+pAsD/ixtq+SLTVkV892GINDQ4KZpUYGUG1uFH5/M
 tj/qNQFS8/yb/qcn84/hvIEtmyeRqKMYRDY0AjxwXhlr7axAzY/8KDoyKS6QRKiW25K34/QIc5W
 ogaIve3SVbCaPqN3XX8eTzfB+17wmNCnOZIqTZ4kL5D+8PJkCWySluPPqZejhK39kKYcwD771va
 RUHeHXsJr9YwrTYDeSoZh7knOBPuwJimJ1NQ5WCfjGS6hu0X0noVM1R+wkoXw28ZHvAoj4ywmwq
 tAkx/Pu67xlhBjKvg0/naK44hfuZLsS21icqaCf7vcr2qNGjdmbm7w+Gry4aqLCeF08gIcWf+HM
 bSTy2/BRE4T/JCAKdjFyAc4tF4q/pNw33BH6PsWTAYcXYit+K8rG4HpliQRscdndNyd+YGLIgTE
 +sAP6glEVx7IpSvfnye6IDSaP7RHEYYGjxWGFphlMZE7VaZ+Hv9xA34fZEP3brChcXdIU+K/jDY
 56KdYIb5dwWJENBJIDsvoy8iCDCSLiwuHjiRZx08ZW1VNiICErsO1xsFCqLdsQsmsyIZqxbyQfm
 gi3unuAt0LtArmzRMcrzyIBl76TU64uAa4ItDqc2baoZufsL18TG9h6XLmsi0yBH3cb8L3wesy8
 MA36NnwxSFBkM7xZVqHAWXQOF7h7iJPsRiCJnagmQoIAATLHb1FG7LxCACArPM6SP2M30bwOfFJ
 j30J98sSM41BCjJGE=
X-Received: by 2002:a5d:5f86:0:b0:4a5:ba8b:e00e with SMTP id
 ffacd0b85a97d-4abb4f5a324mr29162329f8f.45.1795538740950; 
 Tue, 24 Nov 2026 08:45:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf685asm28729826f8f.20.2026.11.24.08.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:45:40 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 16:45:39 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5
X-Gerrit-Change-Number: 2339
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2339?usp=email>
X-Gerrit-Commit: 3fe138dac3f51b7e1527a67ab703287beed0f2ac
X-Gerrit-Comment-Date: Tue, 24 Nov 2026 16:45:39 +0000
In-Reply-To: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
References: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTM4MzExMDAwLkk4N2RkNDFiNjZmN2Q3N2NhYjdhYWY4MGZhOWQ5MDk1ZTQ2YzAzM2Q1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ef1c8ee4dc8607b60ab6d2a807ef94fddb0287a4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVteN-000000008Vj-33bE
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: Fix
 conversion warnings in man_read
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3348008741536388168=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3348008741536388168==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DPixW374xgk="; charset=UTF-8

--DPixW374xgk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail )

Change=
 subject: manage: Fix conversion warnings in man_read
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 co=
mment)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339/co=
mment/26f7af55_daa48a43?usp=3Demail :
PS1, Line 7: manage: Fix conversion w=
arnings in man_read
Doesn't this change modify code in `man_write()` (not `=
man_read()`)?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2339?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87=
dd41b66f7d77cab7aaf80fa9d9095e46c033d5
Gerrit-Change-Number: 2339
Gerrit-Pa=
tchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Tue, 24 Nov 2026 16:45:39 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: Yes

--DPixW374xgk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail=
">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2339/comment/26f7af55_daa48a43?usp=3Demail">Patch Set #1=
, Line 7:</a> <code style=3D"font-family:monospace,monospace">manage: Fix c=
onversion warnings in man_read</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Doesn&#39;t this change modify co=
de in `man_write()` (not `man_read()`)?</p></li></ul></li></ul><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demai=
l">change 2339</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2339?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2339 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Tue, 24 Nov 2026 16:45:39 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: Yes </div>

</body></html>
--DPixW374xgk=--


--===============3348008741536388168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3348008741536388168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3348008741536388168==--

