Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1D7CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eERl776VCiB8Quj85GKJ8RILqHIlrcnSRXTtCFmdrJA=; b=Xn6Gs4WrO6HCQdEkzwZ++mSimi
	+xlSCLcJS8xeUpVj7ziK9rMc5jnayzUo6uXVMtlsQZdYeImnXR8agkAGQtnp/CZD/N9kKADBpUHUw
	Va//23vK3tajQMf3kOXQXol7uAOMXUWdgiRtRXyDoUgYC19FLDbnj+I7agwmTI2VKrso=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIT14-0003y4-3R;
	Sun, 18 Oct 2026 15:41:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIT13-0003xy-2w
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:41:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lE/1xBzc2SCB+qd+k2pf+vmYUutd6RSFzrKSO8i9XTk=; b=jyYNtYz9TZCmO9GUSRcm6kHIPj
 68O8m+ZgZulMypCUc6Y7hLuBbt6hBpQ5Blk4PVswbtPGZ7QVGzrWzF0yw1E10sXZuvZj2G1psuZSM
 7DWs1hIXdOIqDeG38YBK+XegCWoOdUk48siNPUZC4VuMZHedZI1y7x3MwSLEC1ilW/A8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lE/1xBzc2SCB+qd+k2pf+vmYUutd6RSFzrKSO8i9XTk=; b=L
 rIITHWujwGT690x79WSQgnXLvGkEcaNRGb+fd3UuVhz77d138FUcQ9fdYSM8H1+edrqr3yeQSYEtf
 UDs2g5sY/9q4B2F4ZL8n2auzmqFFn4afPX4qeVGoIfp33hcRtZ2kzaZfBa/dgdf3JSgPal2QSkJSU
 F5/o0vMKQ5gwiDf0=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIT13-0001hD-6J for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:41:41 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so1093947f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792338095; x=1792942895; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lE/1xBzc2SCB+qd+k2pf+vmYUutd6RSFzrKSO8i9XTk=;
 b=W54F67u8kwH2reMhoZDOHYnPtglz576w4qU7PX1fRDOJqxoyR/FPVfbqrbIni9a8tp
 1a3+bCtmwlEJgsg7wC05T0bPhRX12REgL9akBZ1iXvys+iCC9KZR6CswCJJwCPXKVKff
 vyOwODezIZ5HohX6lav8Lz06TnXkQKMxY7JiuWt8Nc9lkDyGyeMr2mECiGUhgVAyR5WI
 FPaHuSCSzMuC8+I8PnoAerch+M57GIU4YnGLtAwaW6AGPNFI9ybVV76xJmipdeL54K9N
 UCP+1PcVWKJIbYU3BYGeRbKGIZuxi+MnUZKJONKUtzGBCoy9oXWXPbJvhdq8dH1J3vaj
 Y9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792338095; x=1792942895;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lE/1xBzc2SCB+qd+k2pf+vmYUutd6RSFzrKSO8i9XTk=;
 b=ZHWZkJ5fNuPUnhUkXfLNAsriF5OrMVUVPg2Esnym/ogO1r5oSvTpTtZ95kFQaGwmBn
 d+ctq1l7nYZSME5OB298WHGkiMKo2bcS21o4hEx+Mpq806Lnv45w2kTfxDE2yTGlSOKn
 eI0ZocwBY5Tp2hZt4RZ1r4X8c9X6h3cNbDHOqW5VPA7De7mwkkDBECsvHSQ5/vVDGblM
 RfdZmxLm2xt+n65NoI02cGrPuo3Kw7Qn12UWwF7uLZowzg7bmfZRk1Tspz3bW74jCvs0
 z40Xmm+mUGw31gk0X+MeXxOIoWKYPyfaPFgHk4k9mGsLB7vImVCuYQBSovs79zqIDZqf
 2efg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZs8T0tqucSRE6r8vfbZKlvTbCNQfOs0XI4RxJA1X6dtmcF7LuuyUB1Dr/ia6j41ItKB5xMTl5uDIALSeo@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK2FU3aOHisdqwgfDfQqr6HjQk0stYRVAFTueNs8w0+HBP/FiXB
 PyUD6npH4qZH4augX41sKJszCYvQbobWnsMSV2Rxy7rmxTyYGrv0910Ihzu2c6+AqwWcwtEFYTe
 7V+rIXueVYDIVnylBXZ2oOAUU1egLgli4v9jtdLOx4Hx+gGTk1mhfl0trSmjyN9GNtqS4CKy77C
 vBlqGGGg==
X-Gm-Gg: AYBFou0WoX6UVe8n3QafZpMw7qhUV7GD1LfJt6VDXLMGHCrBmH5ntCXOrDdc3C2942t
 E1D2Bkl8JUoWwu5QtjBx20X3FIEUvwsL1D2CcyBItFFpnnJAtttE0anFz3ClXBmQf+vzB5lwKgh
 ksw4GYSEyaH1pRC4jF7AvXwFXSfaFTy98/JNBIzgcl/Fs3gNdhctx9lwAcCyKRwW8yhHoHz6okF
 NweAkBYE+a0RTA+cOSqPxpQBGdGlYBQQ9hVeYuN+Xe6DZyWJVF3tZihc3QSn7WrioZv51TtuRUq
 YfOPVQdupZREhmemPc0Gu66to4Ae4hdsdDhW2OGi3fhLneSPuxF5LkVkfLt9AWkb8anpt2yID6i
 aU+af0tRU9275D3q2wca6bZXGDTLV5uDNboU2+xPL/bvXN1LdGY0Bng96HzIgkQcp2I14qtDIQw
 21Y2B+26hwZXsuNl4L1SDUogQEdoHoNxaiHQNTO91jNsKW2RQON+2z5VntfK1got6zuBPFR03c6
 37mK0CGA7dPYTxYFKIhahSQ+g9JjAg8Rr6fsDXoDFN05+F6nt9KirB5dBWWB8HvwtwT7b49eHjl
 X9uMO7iHdJ65YC+bDqS1fUzO4aBn0EvqTQ6rPOX1e5V/W5iupNleIUOzOxHN
X-Received: by 2002:a05:600c:800d:b0:4a1:e6b8:67f8 with SMTP id
 5b1f17b1804b1-4a1e6b869e9mr16768285e9.9.1792338094510; 
 Sun, 18 Oct 2026 08:41:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d3e2e602sm209281825e9.5.2026.10.18.08.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 08:41:33 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 15:41:32 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c
X-Gerrit-Change-Number: 2005
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2005?usp=email>
X-Gerrit-Commit: 95741acc59940c22f4234fbd677945bb9b5e8d7c
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 15:41:32 +0000
In-Reply-To: <gerrit.1792255622000.I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c@gerrit.openvpn.net>
References: <gerrit.1792255622000.I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLkk2YjAzYmE5MzkzODdjMmE4NzMxMDVmNmI2Y2Q1ZjE4ZWZiZjRkZDRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9b0bc6a3d9d28362f256eab6e774d2fc1387fe24-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIT13-0001hD-6J
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: Avoid
 conversion warnings in send_push_options
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2282158660292844212=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2282158660292844212==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="npLXQpjl90k="; charset=UTF-8

--npLXQpjl90k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

G=
ert Doering has posted comments on this change by Frank Lichtenheld=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=3Demail )

Change subject=
: push: Avoid conversion warnings in send_push_options
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b03ba939387c2a873=
105f6b6cd5f18efbf4dd4c
Gerrit-Change-Number: 2005
Gerrit-PatchSet: 1
Gerrit=
-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sun, 18 Oct=
 2026 15:41:32 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--npLXQpjl90k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Gert Doeri=
ng has posted comments on this change by Frank Lichtenheld=2E</p><p>Patch s=
et 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2p=
x; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=3Demail">View C=
hange</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=3Demail=
">change 2005</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
005?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 2005 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Sun, 18 Oct 2026 15:41:32 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--npLXQpjl90k=--


--===============2282158660292844212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2282158660292844212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2282158660292844212==--

