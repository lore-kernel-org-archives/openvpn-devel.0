Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551D6C982C1
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SaZkqlTrbLm4jq2WD00xkcZEOguIIcXwB2NW8WWV5RU=; b=FDMnXF/ZE8oi/RLchjn++tyQSO
	E88//vroTsn5XLy+Tn4QsmBYqJuugQUgwAjVv9s5kc0K+LkF4Rr570Eh6MY1a5x7WJ1xEJl5EmfCH
	Gv0un/p7i+LRrOCzI7K1j00LZIz8ig8c/BmHX/sVr/Csc1tDvVFj6pyhiJPhjQOGnS8k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6yuH-00045l-Ef;
	Wed, 16 Sep 2026 23:19:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6yuG-00045f-Hc
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 23:19:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=7fVcXHfF86KjP6kdkSSaRmAUe9jjnKo9xko5JHDHhs4=; b=Fzi02DuW9GxEmrAPxq/RmXCD44
 HMFAvt4DwvN1LZjSkJeObNf5RVimZ8Bx8WyYAyFkrUcvhWU7548GiMEoZ9C5Q2XniinEqdKLz2WCT
 e2/pv+giEOZy3zqHV3R7uxrbF97zLvfoKbbf2IQCHa/8bFj5c04d9sqGbXt0ZkbdOB9M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7fVcXHfF86KjP6kdkSSaRmAUe9jjnKo9xko5JHDHhs4=; b=h
 R/4Ayh4KbCpm+0r/OqpJgWAlruIA1sQaMSar3UvYZW20N3M6WDHQ6e/Wd6BD42sf6GVEi+tR7UkqI
 RazC/ZEIL0iqc8n3DAdLM4HrV832QyDi7fEEouxMXKNh6CmkUAh90YBhTNuy3/v4gzvn4er4LD3xg
 HH8nuuIeTUwjdfoA=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6yuF-0003U5-4H for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 23:19:12 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso3155845e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789600744; x=1790205544; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7fVcXHfF86KjP6kdkSSaRmAUe9jjnKo9xko5JHDHhs4=;
 b=cKGV4jxE8rHEwe9zTTpulwuO1j+qY7fxnGY4m1XxZsgzo03cgD1g59QeZMEYxLqaYj
 wib2XOR6t//x5UwkjvZ2uWSre9X0L66YUaY/YwyY5YzUDFvGEQB9KAzHaSYvcQnTcyiH
 rM0FAcU6asD0ez/4HlD7wdobQuU7nIR9WTdfLYzJRJodk1UOCjQvWeWxStkCK3y41O2F
 0SiPJ6akupUrfwGQegwgSpOfvgANSCUxwCbjSXws9LKXVz9gzJDPXN59Nqy3xkgwA4ZR
 xhdvvezqL4YgOtekyWr5UQcIWzuxqd1cU8XMCymJons/CYFHOxOBWVYwjdtBOKNE4l5I
 njPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789600744; x=1790205544;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7fVcXHfF86KjP6kdkSSaRmAUe9jjnKo9xko5JHDHhs4=;
 b=inbpAtMuVs0D+7Qn6JMtXhdgqU0Pc4cC+wPdMiUtbDBbdIr8sG0TDC72crMP0u7uFA
 JGmWjwFgH1NNqJ7UbLUUot9DOwt/yEEk50BQ4QlvpaE2Nb3y4nQyVTKP2KmnzTVM8e0B
 MbXxa5hFuYKSc90L9ldOs4kFoI7DX/kolps4DWr8/qD+jYUQFonkQJ5lya4pTBt3EhBR
 OJtHUYyo3SdcxKn4ikvg1BM4XrWZV0ksHPWlQquQLVfi0MOlk1jzhjB5TGKM9MIlwFG9
 3X6plk7+qPqxLvU3Vy94iG/4AnRl49KM55tAhO+EFxaHPLct3H+pKtaEZfYNSeYRYzGc
 Jf9A==
X-Forwarded-Encrypted: i=1;
 AKwUvByrF4swP2iYjWCFI3+Xzsk7YvoGGv1cbuKFDNNFCBPw/Amp3DNbW1RKIIIZGOyJp6vt0ki4kDLegdsxG4qL@lists.sourceforge.net
X-Gm-Message-State: AFuF++kCIZgZs2/+dkUHs426qHXyGEbYa6TLd9in7BBeeG+k+ERJh+ww
 XQ1jdKP7Gk3LXLJzUHdF9JJU/gfN/d8iJDEktpI55KIYwKVjkgd1qO8so/XRm1Y5vLQ98lZA+SC
 JkClgu1iLnMPHV+jTIdDLt9tqg+cU+tOPcEoLqs90lBHQ1dsCHeYLlp5lP91NNKUyymgPqWoLtS
 tEQAiJOQ==
X-Gm-Gg: AYBFou0NKnz6k9ny+/bBbQ1XoKse5xhClyZ52WtG6vBfHjUl/ug/nHcQGMIJuBVDqth
 z2Qh8PasaBcv2QDVLC1VsnUt3Eq853l621miiAZU3BLWi8a8TRwhzcpQ7rMnkps6f6V42EgSiRz
 08QSq88Kb6W/mBzH9skRCJo4sOvmmHdmu8McgZkgE1T47fx+7KjYDMDwp4Ebz9oJUs5yGN3RjhL
 oNrzP+3V90qrveM9MjUswQe6oeVeZxcqoKtJs4FnCx2xmdxyLsHv1pTWp7I1Ld7sEsCqQqUursU
 +VkvRbksTVeskmwx0AxC/RqAkV9AEbFkmaNDoqRVXalBl/hoQjb3YftmH23OgXdzesLaT1i14/w
 fOH+loqJ3uYMinOZ2nKX9FSxmaPS4AO+4Eiy5uJUrr4temtR3fAmdesNDBdgUsEkV770P80I/bh
 KBk3vIQ6BFJ+FVqnslX+uTppV7eCl1d6xPe1NA3OL1HfY4WieNnSKOnGx6zBhZfOxrj7QVvmXii
 0dpPbSMXskmEKGS5YHy+iJMIETsIu55MVSKRrVPmwcjK0kj19HRkzTlVYm4KYCo4R8LDQzDQYn7
 aPE6aZUATpi09Lp7N9w3rCDCcAHtfic/Mu0T2TrRg8Dse/3k09ZEGHQFAxCASlo=
X-Received: by 2002:a05:600c:848e:b0:49f:bd3c:bc22 with SMTP id
 5b1f17b1804b1-49fbd3cbd1dmr11342045e9.29.1789600744062; 
 Wed, 16 Sep 2026 16:19:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbda7c461sm7050125e9.4.2026.09.16.16.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 16:19:03 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 23:19:01 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 3f8217314124701400cb9ce525071943a373e780
X-Gerrit-Comment-Date: Wed, 16 Sep 2026 23:19:01 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4a7a0d954c49eb1b90d7cf9dc9ce5ae7ae46c696-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6yuF-0003U5-4H
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
 ralf@mandelbit.com, frank@lichtenheld.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1222300305342748487=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1222300305342748487==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OJVjYdicjKQ="; charset=UTF-8

--OJVjYdicjKQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ralf_lici, stipa=2E

pl=
aisthos has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add contro=
l message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 15: Code-Review-2

(1 comment)

Fil=
e src/openvpn/ssl_pkt=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/=
comment/4a12bf6c_a19a4737?usp=3Demail :
PS8, Line 70: #define P_CONTROL_OOB=
_V1 12
> The root cause is that P_LAST_OPCODE has 2 different meanings: [=
=E2=80=A6]
You did not really address the comment=2E The code still has P_L=
AST_OPCODE as one define that is still 12=2E If anything the comments and t=
he change made it even more confusing now=2E

Somehow now an OOB opcode is =
not valid inside a session but a CLIENT_RESET_V2 opcode is valid inside a s=
ession but both have similar treatment in the reset of the code=2E Also you=
 introduce the concept of "inside a session" without properly explaining wh=
at a session in this context actually is=2E



-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit=
-Change-Number: 1741
Gerrit-PatchSet: 15
Gerrit-Owner: stipa <lstipakov@gma=
il=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <=
ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lst=
ipakov@gmail=2Ecom>
Gerrit-Comment-Date: Wed, 16 Sep 2026 23:19:01 +0000
Ge=
rrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: stipa <lstipakov@gmail=
=2Ecom>

--OJVjYdicjKQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ralf_lici, stipa=2E </p>
<p>Patch set 1=
5:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #ffd4d4;">Code-Review -2</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_pkt=2Eh:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741/comment/4a12bf6c_a19a4737?usp=3Demail">Patch Set #8=
, Line 70:</a> <code style=3D"font-family:monospace,monospace">#define P_CO=
NTROL_OOB_V1 12</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">The root cause is that P_LAST_OPCODE =
has 2 different meanings: [=E2=80=A6]</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">You did not really a=
ddress the comment=2E The code still has P_LAST_OPCODE as one define that i=
s still 12=2E If anything the comments and the change made it even more con=
fusing now=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Somehow now an OOB opcode is not valid inside a session b=
ut a CLIENT_RESET_V2 opcode is valid inside a session but both have similar=
 treatment in the reset of the code=2E Also you introduce the concept of &q=
uot;inside a session&quot; without properly explaining what a session in th=
is context actually is=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8d=
302ac57c5603d622a7be14be369437388268 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1741 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Wed, 16 Sep 2026 23:19:01 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-=
In-Reply-To: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--OJVjYdicjKQ=--


--===============1222300305342748487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1222300305342748487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1222300305342748487==--

