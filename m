Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512D7CD98F2
	for <openvpn-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ftScHlvmP1y47UzyzMtOYCCoUHVGTMDc/1AFheCnX1s=; b=mrEZ1zMBSiVSVvvuhwhAv4Tmjg
	N5+0V3n/TBngeak3hZox0i+q0kLS/sX2/swOpnXpWfWRK9gLhlO02TbfuQXxQhLPAHbuZ0Y3ju/WV
	XX7N+U2Vs3TZ9WvyIUldRM74fjh6eMWWQhi5NWDaCk9h63WIaSVjxRZcSDtlqXmVAvLo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1waBkX-0002di-9m;
	Thu, 18 Jun 2026 12:21:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1waBkQ-0002dZ-Db
 for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 12:21:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=K6TrpV5nSVyiPQDcxgBsktkiVogAUVleNcEgS9gs5/I=; b=eZPMxp+OsJ/RYqMED/0rPHtJ7C
 UMUt5OIOfaJxYKyVw5f7qiD8RTrVr1PKa7p26GwTLCUg7TqqrZ0bD0OxYBQ0HtryOJ5pO2R2BsrFz
 xSH5ozua1zGyzTCIVFlnsiKDZphkyqg1w2bEpt+o07jfD7ho+BAvcT5FacpmOF0uuw4Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=K6TrpV5nSVyiPQDcxgBsktkiVogAUVleNcEgS9gs5/I=; b=G
 D4jLMQ0s+lihD4ABWrDAvKUbULiDBJGb5xxeE6RGvPA3fvWt2fVRmkx5EadRSAhToHGG+gefXZUHV
 C57etsG8NTUZZLcCqo92aw9iA1eNhmslj43M4aFMUT2BPQsRHpBN3hMCb0UBGuAx5DodBb/VHUjoA
 bhsffjN2wl9VSc5s=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1waBkK-0006F4-F1 for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 12:21:27 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so676897f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 18 Jun 2026 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781785273; x=1782390073; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K6TrpV5nSVyiPQDcxgBsktkiVogAUVleNcEgS9gs5/I=;
 b=gqkDR7w7cnLF0D7KYHTBBY/HaW51Cq7oxRxVATgA1EzS0/V+DvgqW/G8YOzujmhoKx
 P3skf032PXBrKDgexf+iNiBbZptx01Gi7YMMBivRFNvpb6jPUemYxhIqlKbuUNnAMAsd
 TS8eorEI9sSZ/mXWbNlC5JTXciYJwNGy4b+Oi51aMIXwP9vk8TQJQ5Cm0T7S9Sl+W2Vm
 LpJQEn0cV9mUNDoRDmw9iLRXr7SbeIpy64NzKhagWyXI/4hTovufeT2kVqsTaQ2dlr7z
 xD04KPk8JPtc3bpPPP+lG5wzHCVozf/2BphHie01WDQ1NuSUpcsK+CBgqmoGdTSjW/En
 g+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785273; x=1782390073;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K6TrpV5nSVyiPQDcxgBsktkiVogAUVleNcEgS9gs5/I=;
 b=lJh7+V5o3YWB6e+AQU0xBsaD32EILgb56PHdRsKuGUw1hBju9xd3vqzNrRTy1P7Iv4
 se48M6QpDGGcWEO/Gl3PbC77+dgJH/Jkl1Ah6vCaCfUE5clVDYgJw7DcIm8+yknt7l+M
 9RN1dQkKecDbu7mM2gE+YaOxlxvLfmLM3A66SnUqPu3gezSe276ta3B5uLSLx31xoRpe
 9pYdfVQe5/CHJ7H7PeQjVZklZKdkNVHyZ/y/AaioZMc8LBRR3fA86c1V+DrMrZLXh8Gl
 FyeaQtVt6iSfOJ1U+MzJHYMcJbjS3jIXW9gRhDrSsAbbs+KGmIXxsgPLtPjhdr2mf7qk
 BcBQ==
X-Gm-Message-State: AOJu0Yz7MIC9zhM90cyL8dJcLFWdgLFdMHoQ1rTfbNMUAEb93sIN1rl7
 VGqi8zITDqHLLOx43CARcwV4U9ZjeJSZFahF7fPmUmgbJtUJx7gCT9uQBlu5+92a4rpxfwnwmNS
 YcUnC4np7zBDabdDhu9/7rmwBetnEubGLC/JnVRHQKuy+dfWR96sLovpJTFRmUDvn1ZX8uDIev0
 0d9pBNAQ==
X-Gm-Gg: AfdE7cke2t/J07h8SNp92mB78qTsPPBqT+BjUPXwMHd58XqwNaVJwXWyBmZWAAg+cIh
 s+NVtWc8nTLqSC9FJPEH9RlaE9rUyklNRTpslJ/As/Wo0dquVX30pLP4/3ypw9s8rlF9Nn5yOZX
 lsvz47+SkPoplbXBqxRb9yE3W2Ulnnp2uVUT+hTXc3jmfse+vAetT+G8vu88VO4Uto9rbpH9qgJ
 ST1rIp5ewf4T7i7/bTzeNOvLzaIJ7ukRz82sI9vG1SIhSHnZRq1DYjxhYGW9yowhX12VMf21vgi
 mgbR6smD6nx/mYVk56i8K2YMElejnqruzl8Y0KOjCWbCdAkKa54avzYGEgYSUYhsOKrzbF4oC4Q
 YH0aFiPa2kIge1/vEshqV1yrnMuZ8WEK7lsCmV6J4x6PAPJgeUjsX2/omKvLdMcMwU6QWbluyGf
 RU1tNIPWNIyoeE5SoOiU0MPKiIzBZNcUMvC1R/DiyRLjD5h97BxIcP0PaB2ol5u37Yihax+9bzt
 B09cqLA7fJ3pZAH5bHVBI2xgZdjnjZPUa6XzUlS/l64M8tBsXemKgSXvkbyIexfXtc/diI3HyHS
 XhQ=
X-Received: by 2002:a05:6000:26cc:b0:460:1a52:8a13 with SMTP id
 ffacd0b85a97d-4623362de03mr15051829f8f.0.1781785272138; 
 Thu, 18 Jun 2026 05:21:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e592csm65750142f8f.36.2026.06.18.05.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 05:21:10 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 18 Jun 2026 12:21:08 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6
X-Gerrit-Change-Number: 1713
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1713?usp=email>
X-Gerrit-Commit: 57bce06563118f9853c6002ae87653f3ec125f15
X-Gerrit-Comment-Date: Thu, 18 Jun 2026 12:21:08 +0000
In-Reply-To: <gerrit.1781716678000.Iac54e6772b2c26a09227fd638d24d6e2aa35cec6@gerrit.openvpn.net>
References: <gerrit.1781716678000.Iac54e6772b2c26a09227fd638d24d6e2aa35cec6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxNzE2Njc4MDAwLklhYzU0ZTY3NzJiMmMyNmEwOTIyN2ZkNjM4ZDI0ZDZlMmFhMzVjZWM2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ed6c4c9485e4b190675c74b1d59ecfe1ed75c10-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1waBkK-0006F4-F1
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: Fix 1-byte
 buffer overrun on NTLMv2 proxy responses.
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
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3301048220444074512=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3301048220444074512==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o3bUi7nsJV0="; charset=UTF-8

--o3bUi7nsJV0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2=2E

plaisthos has posted commen=
ts on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
713?usp=3Demail )

Change subject: Fix 1-byte buffer overrun on NTLMv2 prox=
y responses=2E
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 2: Code-Review+2

(3 comments)

Commit Message:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1713/comment/a1104ba8_b5c0316f?usp=3Demail :
P=
S2, Line 10: plaintext pre-TLS proxy connection) can trigger a single 0-byt=
e
A 0 byte overrun sounds like not an overrun at all=2E The subject also sa=
ys 1 byte=2E


File src/openvpn/ntlm=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1713/comment/9eaf74ec_648ccee9?usp=3Demail :
PS2, Line 214:     u=
int8_t *ntlmv2_blob =3D ntlmv2_response + 16; /* inside ntlmv2_response, le=
ngth: 128 */
So this pointer aliases ntlmv2_response=2E The length: 128 is =
weird and probably incorrect or meant as some maximum that normally occurs?=
 I don't know=2E Since we already removed this in master, I think we can ig=
nore it=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713/comment/775331c=
c_3f049b8e?usp=3Demail :
PS2, Line 348:     ntlmv2_blob[0x1c + tib_len] =3D=
 0;
Here we then have the off by one=2E



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1713?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: rele=
ase/2=2E7
Gerrit-Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6
Gerri=
t-Change-Number: 1713
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=
=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Thu, 18 Jun 2026 1=
2:21:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--o3bUi7nsJV0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2=2E </p>
<p>Patch set 2:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1713?usp=3Demail">View Change</a></p><p>3 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713/comment/a1104ba=
8_b5c0316f?usp=3Demail">Patch Set #2, Line 10:</a> <code style=3D"font-fami=
ly:monospace,monospace">plaintext pre-TLS proxy connection) can trigger a s=
ingle 0-byte</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">A 0 byte overrun sounds like not an overrun at all=
=2E The subject also says 1 byte=2E</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/ntlm=2Ec:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1713/comment/9eaf74ec_648ccee9?usp=3Demail">Patch Set #2, Line 214:</a> <co=
de style=3D"font-family:monospace,monospace">    uint8_t *ntlmv2_blob =3D n=
tlmv2_response + 16; /* inside ntlmv2_response, length: 128 */</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">S=
o this pointer aliases ntlmv2_response=2E The length: 128 is weird and prob=
ably incorrect or meant as some maximum that normally occurs? I don&#39;t k=
now=2E Since we already removed this in master, I think we can ignore it=2E=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713/comm=
ent/775331cc_3f049b8e?usp=3Demail">Patch Set #2, Line 348:</a> <code style=
=3D"font-family:monospace,monospace">    ntlmv2_blob[0x1c + tib_len] =3D 0;=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Here we then have the off by one=2E</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713?usp=
=3Demail">change 1713</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1713?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1713 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit=
-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Thu, 18 Jun 2026 12:21:08 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: Yes </div>

</body></html>
--o3bUi7nsJV0=--


--===============3301048220444074512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3301048220444074512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3301048220444074512==--

