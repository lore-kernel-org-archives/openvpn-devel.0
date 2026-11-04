Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E4F606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W2BWZuwn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=blAjLASz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gzGISr+T;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cBF8zYQ2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=E8lQWpcoxJKp/uWcJVlXeACvfr+Vyku7sO4d4LvT7HQ=; b=W2BWZuwnOgh1M/NjKzzPso3rXO
	FDjGqnQyYj9LHp8A8UzSF4oZuu86Lblbubj7ezmNmVszq+mcva74GPwb0hqPfSWd/r3c81kBL6W6c
	EyFVom9QN0POAHVwV20ZzBPa3l5TlytyhP+gUSVxteMvyD6HM4k4QqELZhhnuNZzQogo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOV9K-000000000iz-23Rd;
	Wed, 04 Nov 2026 07:11:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOV9J-000000000is-1loz
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:11:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FqejOSRD/cllYmKU4zL5x3wKu8L8rvhNCw1yhE0BFuo=; b=blAjLASzvEr8mn3kjEnI0Dy/V4
 JxXWrf0Pcu/okX/pskdCLP/x2q0t817tassNV0fDvD+ePfcluSmOg4HPyGoN4iufXiiFq38Pbl5cH
 ZmA44GrAOmF6W7EL3RH+JtS9t5YfPjXWCxYyIf/jFKBBcBSxAKkHcGtZD5hYenKI8aiU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FqejOSRD/cllYmKU4zL5x3wKu8L8rvhNCw1yhE0BFuo=; b=gzGISr+TfvkdKKKZS/Muo7ZgNg
 zZ27ldzf//k4LEqzCEmidVFb0Zyp8B/blGoIXeruOwX5idiFxraBRGuNLUUheLSjFHj5c8/wl2Jro
 vVmktyULvEKUGsS2AYoyj+bzkAjyuQd76zftLdnXuXq+5EEV81TNMTQTF3ck9/9y8F3I=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOV9G-000000007xx-1npi for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:11:09 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso1651445e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 23:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793776260; x=1794381060; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FqejOSRD/cllYmKU4zL5x3wKu8L8rvhNCw1yhE0BFuo=;
 b=cBF8zYQ2daOmyF2wA/KyDwHHJ2itBEjUrRCoCLWUirw1Fn3REZYl2T6AaXDDgQCXFC
 O2rrG/6ZE9+hf19adHZZ04UUYFF7V/crL3cBRC8e54qAvTD6e0ymgtodS0qHtCoCYotX
 4h5b2lNsxKtT3+uRX2slUM8CaTPA2gXc7F//f3mriqW1q+IP7+FuI9Wjx9JfMo9oNtbG
 RSIht51XwLrzf4JlqO44XS69z5OhDUfjDBpJEm3FdXD9HHsGJTqgcbKR2PAClSUUimOQ
 ywbscgvbEW5IndVGQ9xToakBfLI3RJVnWPerZmnIUaYfFRJwscmk8mW+jNFfHLAncjX7
 r6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793776260; x=1794381060;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FqejOSRD/cllYmKU4zL5x3wKu8L8rvhNCw1yhE0BFuo=;
 b=SUSBgxF5HM/9+J8XWPtcSAETplYBwbKJF8HpWRMnTRuROBCOqdiCC4U0ifarjPMyN4
 qucPrL0P5jeG0J4IyueszrDMGIF0VENn6BjQxu7nwRy1ll9wleKAPs9JMsm8/AL3CUoa
 yqyRt+R4SWK3c1yk7WhT1/kRNLhAoH4MlQgY7vIHIFPML30fh81iZZgjnhxUXLAnw1R/
 Hu/ah3AyqAqVVcMcLbyFjYrvQekc3DoUQ7O8XUY0qjRfNyJJtlt7Dkyja3csfopJMuqZ
 iMTeMS0ZXPBMqienjbkHRgJ7QehPtqITobo7tfTIThmmlaWBUZBZ91AcV5Cq5SXQ5dKb
 Eldg==
X-Gm-Message-State: APuU4Z+Z+MfYO8+FCnNWJUNOGoq/+fo3yi1uUIRANfJEgxDOM9WSsV9v
 d4hAU9j4gSh4c/4+J0SDYkLIs3MelqTdm8VyWy7G8HCR3CUaN88IjRe4vXyOanF+xgcOueWgtAn
 1Z9JeTAlBV4cO2v3+tbtLPcEbyyeV5EEhExoEdl3oZQDiIR+GAkNW2ljosV7khitWNBnhzrAyc/
 iFqMDClQ==
X-Gm-Gg: AYBFou3RXgr9A17T+OyLZQahAuzHY4Uh579hEuskeY8jbUK33Afreu3gC8wqPE4QWbx
 BgDQx+6n7gF1bcKEQtz8wwaKn8+RmuCt8W7P2y0uS86EFqIzjd0Hdi0p90I/sxUGyUiYl/kY07I
 1QjQyBhDSvw704gEsrNa+Tn/IgYO8hdkXERclmpW1B2dgd5k+HF3SnrLeTGF+NZE28WjF0TbJUQ
 4oyFZUbyBt5S1iZTXcVslS58RVLVE1wkdB2KqS9OU4itAntv+e7VejgJ4X5AgDS9K4O9niR3KY7
 5i7M/RFBssvx3uqcbOiW+btlm9kzSmxVYkitqG3pZv9C9ggQmb3QFrAJeenUNU40lORHTjkgPmI
 0IgchT1WR7ES4m6G+P14llqfkRthHGrV+eQHNPXE0A4lehy7nr0fHfvluZOZTzYirlSKWcHHqji
 0LuNqXDPXt3COWZkfzZNKas/iPZmIWxBt8emfyy49w2u6KJx+Vhyv02MA0VJshesmacnupv+qFZ
 5hX08/Rq4VgAMkajSlPY5f8tYXQzg9OGEhVviRCzpEdu3rCo1mj6yyDg5S9mIDUUjl1IB+FnqRW
 008gLD9WhcNauNYNfPWLqKEse5mT2q32M/MzHh9OFd98xeczlztdXqiDlD705iaIvZ+JHJoLDUy
 J3r/sBYNJ88fRMpCrKCAqF7v5pe3yBlxrmYj+QPdvu86hC9a++pPud8bcipEmVzHAWThXStYW7m
 xAxLJqHuWGGRfawA==
X-Received: by 2002:a05:600c:870f:b0:4a2:1196:db0e with SMTP id
 5b1f17b1804b1-4ac1899348bmr322660495e9.30.1793776259529; 
 Tue, 03 Nov 2026 23:10:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43cff3fcdsm30676375e9.11.2026.11.03.23.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:10:59 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 07:10:58 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8
X-Gerrit-Change-Number: 2116
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2116?usp=email>
X-Gerrit-Commit: ddeed4be229157bdf2cecf378281259794228a17
References: <gerrit.1793776256000.I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2MjU2MDAwLkk0MjdiZDllZjhiNDkwM2NiYzEzODZkM2RjZWYxYjY4YTQ2MGI0NGM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d65730996cca21c59d0b24276478c2885275bce2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOV9G-000000007xx-1npi
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: fix
 "cr-response" typo in unsupported command error
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5556112392556979659=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5556112392556979659==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qDis+dP9zDs="; charset=UTF-8

--qDis+dP9zDs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2116?usp=3Demail

to review the following change=2E
=


Change subject: manage: fix "cr-response" typo in unsupported command err=
or
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: fi=
x "cr-response" typo in unsupported command error

Broken since caf1b903 ("=
Use a template for 'unsupported management
commands' error")=2E

Change-Id:=
 I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8
Signed-off-by: Razvan Cojocaru <=
razvanc@mailbox=2Eorg>
---
M src/openvpn/manage=2Ec
1 file changed, 1 inser=
tion(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/16/2116/1

diff --git a/src/openvpn/manage=2Ec b/src/open=
vpn/manage=2Ec
index 58f63e6=2E=2Ec1e89e9 100644
--- a/src/openvpn/manage=
=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -886,7 +886,7 @@
     }
     else
    =
 {
-        man_command_unsupported("cr-repsonse");
+        man_command_un=
supported("cr-response");
     }
 }
 #ifdef ENABLE_PKCS11

-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2116?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I427bd9ef8b4903cbc1386d3dcef1b68a4=
60b44c8
Gerrit-Change-Number: 2116
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--qDis+dP9zDs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2116?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">manage: fix &quot;cr-response&quot; typo in unsupported=
 command error<br><br>Broken since caf1b903 (&quot;Use a template for &#39;=
unsupported management<br>commands&#39; error&quot;)=2E<br><br>Change-Id: I=
427bd9ef8b4903cbc1386d3dcef1b68a460b44c8<br>Signed-off-by: Razvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1 file =
changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/16/2116/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span=
>index 58f63e6=2E=2Ec1e89e9 100644</span><br><span>--- a/src/openvpn/manage=
=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -886,7=
 +886,7 @@</span><br><span>     }</span><br><span>     else</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        man_co=
mmand_unsupported(&quot;cr-repsonse&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        man_command_unsupported(&quot;cr-response&q=
uot;);</span><br><span>     }</span><br><span> }</span><br><span> #ifdef EN=
ABLE_PKCS11</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2116?usp=3Demail">change 2116</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2116?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I427bd9ef8b4903cbc13=
86d3dcef1b68a460b44c8 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2116 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--qDis+dP9zDs=--


--===============5556112392556979659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5556112392556979659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5556112392556979659==--

