Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C549C54F4C
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xsm5OESCWKndCb48a9q3VTjwYbCY5mWF7OkT4W4nx2I=; b=CqAEmS8OAWFe5xFZQ13PZQ6HNj
	Y19KWWdhYrpM4DGdDxOqUjPBtQn5Y4itWRHhCS2TWwNthP6z+vM8YOsHCc/kcqf1t7eNqMc6EtayX
	tUJkn45e5pOmq3vZCrvdHUx4c15K2l7VRDX2DeiHKwlKzDiEALREe/XQJYEdbzFmZxMU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojNv-0002I9-Nh;
	Tue, 28 Jul 2026 15:06:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojNt-0002Hr-Bw
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VG9D6egQfYsGctcUyGGgdfqV00jYyzWlQS1z8VKyzFg=; b=UGhfFFGGd0UluL6ynG/9z3JOAk
 H/Oe1qdnrkWIrtIRVmDNvCa5M2+UQd8YcicLLgaOv/m4N/7jrZdtGSRGhGg8mWZa35gQKyIowVrxM
 D05HdW/+0xPr9wy4MU8632t+nCUQf5UXNV5Wr7MsLRT9T1mIZmiGwIe4To9FQVmgLU80=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VG9D6egQfYsGctcUyGGgdfqV00jYyzWlQS1z8VKyzFg=; b=e
 jBctQrDrF4BDdUUVbY3wTc0jXYyIS1qAO2PbjZKWjE+TXSH0sQfmZif6IpF6zNrW0EO3Toa6hX6RY
 fmQ7ct83ifyepjzxrIweWiospBp0lO7AT4ssZRPZKEtMMCLxvS8ESdPq84n9WOzfJYUKKSEeon9yo
 LcKv2FgUid91KU8o=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojNv-0000ZQ-W3 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:06:21 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47f97d310caso2865423f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251174; x=1785855974; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VG9D6egQfYsGctcUyGGgdfqV00jYyzWlQS1z8VKyzFg=;
 b=UV4jXhD2WNSVnjPdSPbLE5Ev9xi77djVcG02NJUQZ2fC3cl0sFg6cR1aZUIa3Li4X6
 dcAfFvo1L1/7J56cqHTPtnfgLOwB1l2oAScwJtNlxL4Pac1r2Ybx2HDifq2Gmxeyfi9X
 SMa43BMg3JytAFEAmfk+CJGcWLzte9l+CVtxLGkoLSPtGnEckWHK7FeOIuImO0p3JlTn
 0evR/lNw4ktQzaDIEAFjrwxEnmU8bZc8E1yl8jYFaBb307W5BguaR1eZIgdpp2+YNoRN
 BWUnbeF2/VZF+CRYpnRxXjqYB8PXbgcOH5/SHe4Mm5Bgdv5yrSw5TMaTR+O76zzkPEMW
 SJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251174; x=1785855974;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VG9D6egQfYsGctcUyGGgdfqV00jYyzWlQS1z8VKyzFg=;
 b=kjnA65DvXc29Na/OFyOWOsYtNHzS08ccepfpJv4DQX8eyilrOvGcRaWJKgqPkuYopb
 FCl8bD+7Y/nHXzilCMxSJlR9ENioyQRW1vnUXkLY3gPBpZAdXEtFjbZEdxrA/qdd/t8P
 YJ0SWsLqSLEsK9d2FmV/6QvBMyscMt99/FocefFooAj20q+wnzCDlnT3sNuDyrVuLqgH
 GUI+Aa/8mq/xNoNGqg9E7FaWK60H6L9HThTnHenKerh65ZjNrxjjj26G4wn5j1IHulqK
 Xv/VzheEG7y1Wc1b89Qv7LK7JT/BECX+Js+mEl7hcn0l6t3VvP4EDKX6duhnzFrhUY8b
 CsoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0f1Hh0Fw1yqOiA1fd920l1GO5bsTyZbPCxX6PZBaFOUf+Sg5dOBr5E1j7q355zYU9sVvBZZc5OAQij7u1@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw2oQ35JZkT3WYCLFZtT9EL6xPr8BLqHGbggD+vcCM2agKoaqs2
 wKq2/15gNI2vJ+3KffdqfDTsLg2Ppcd4MFD2Edw2MyraPf3cq0Ui3RdNhE7a+Nh5dzOqkvJCVPH
 BIL7raZHg4qlm2opBwYNsuYZ0OIwAj4Tr6Bhe6xemtLg5WLZ3bgQyw9/odijoG/JORxTuCSS7Ob
 Z85j7LzQ==
X-Gm-Gg: AR+sD11jDHe5+Ol2Bu4shuFgp4HiDUUgi00lNrsniGZgdRkn8dNTPlPnX2G9N1DrxhI
 T2z7Wdv2KWmtML5gbCagylDodR+Q/Gi5kgmmBsCTL3wRQTF+nhBy0GHA76+WZhf3Sbl3nBprj94
 ry8DTuhYhMSHWyQcN9/9Np4aUlUuSRmpB6fWEwSasHCwz5NPieO2lgkRDZuYNLh0hTbDZbD9nN3
 pftayChb9j02nsIrNPaFsBzjMbxG73dY4dPnynbeeMgCiRSOwaf/teDJdkTefHpBcAhRV0v3ytk
 zx7/l2N3TiYQi1o4VMC1stVNRQAfxRTBkhA8Iz2395hT3p3A9jQJ+P12vLdvpvITatk2W5yV4x1
 Bwob1Cwrk/oFH9xsOcH5TB9ReR3NBsEuHpJkhJdFb90mne9YbHUr2+xQnnpPY22XJRJk5ybPEuy
 N1Wz/ohimztmc+i6Seot9lFmd4PkwdnmU7GG+11hiof+SuRWJXMip8vY6yuLiiHUNj9UPjK9t95
 rdgj5kkqBE8ooIHyIT4fqJtQ31+AlEcVSGoljQJXaNu+EnV9jSuoAYfpNXpThW/fQgdhYFqwB29
 vns=
X-Received: by 2002:a05:6000:2306:b0:47f:778a:6587 with SMTP id
 ffacd0b85a97d-47fb1edbcc8mr3517393f8f.40.1785251173625; 
 Tue, 28 Jul 2026 08:06:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f96b9abc0sm38322318f8f.32.2026.07.28.08.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:06:12 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:06:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
X-Gerrit-Change-Number: 1770
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1770?usp=email>
X-Gerrit-Commit: 417762280a87265ae3e372375d8587e3d3d4e45f
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 15:06:10 +0000
In-Reply-To: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
References: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkk0NTRkNTA0MGNiYWQ0ZDM3M2VlNGY5MGI4ZDY4MzIwMGQyYTRjMGU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <52f0114478facb9251c5191447d99e7a802e5d04-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojNv-0000ZQ-W3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: start the
 client handshake from the server probe
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6193224672422836210=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6193224672422836210==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+OxmSsklA38="; charset=UTF-8

--+OxmSsklA38=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

stipa has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
770?usp=3Demail )

Change subject: oob: start the client handshake from the=
 server probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 9:

(3 comments)

Commit Message:

http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1770/comment/0c3a5f84_07b90a1a?usp=3Demail :
PS8, Line 7: oo=
b: client handshake shortcut via a server probe
> I don't think handshake s=
hortcut is a good name here=2E Because that is not what this is really this=
=2E [=E2=80=A6]
agreed=2E Renamed, it is now "probe-started handshake"=2E T=
he message says that the handshake is not shortened - the probe and reply t=
ake place of the reset packets, not remove them=2E The saving is one RTT vs=
 probing and then connecting=2E


File Changes=2Erst:

http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1770/comment/938eb310_891c59a4?usp=3Demail :
PS8, Lin=
e 15:     for it=2E This needs no extra configuration=2E
> there is no skip=
ping of a round of three-way handshake=2E [=E2=80=A6]
Reworded=2E


File sr=
c/openvpn/oob_client=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770/c=
omment/5ad93dd1_365c9d1e?usp=3Demail :
PS8, Line 657:      * immediately be=
fore connecting (~0 s gap), so that check is a no-op today;
> You can probe=
 two server and then both reply and then the you don't connect to both of t=
hem instantl [=E2=80=A6]
Right, the gap is not 0s for a later remote=2E The=
 comment is confusing, let me make it shorter and clearer=2E



-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200=
d2a4c0e4
Gerrit-Change-Number: 1770
Gerrit-PatchSet: 9
Gerrit-Owner: stipa =
<lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: =
Tue, 28 Jul 2026 15:06:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>

--+OxmSsklA38=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1770?usp=3Demail">View Change</a></p><p>3 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770/comment/0c3a5f8=
4_07b90a1a?usp=3Demail">Patch Set #8, Line 7:</a> <code style=3D"font-famil=
y:monospace,monospace">oob: client handshake shortcut via a server probe</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">I don&#39;t think handshake shortcut is a good name her=
e=2E Because that is not what this is really this=2E [=E2=80=A6]</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">agreed=2E Renamed, it is now &quot;probe-started handshake&quot;=2E =
The message says that the handshake is not shortened - the probe and reply =
take place of the reset packets, not remove them=2E The saving is one RTT v=
s probing and then connecting=2E</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File Changes=2Erst:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770/comme=
nt/938eb310_891c59a4?usp=3Demail">Patch Set #8, Line 15:</a> <code style=3D=
"font-family:monospace,monospace">    for it=2E This needs no extra configu=
ration=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">there is no skipping of a round of three-wa=
y handshake=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Reworded=2E</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob_client=2Ec:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1770/comment/5ad93dd1_365c9d1e?usp=3Demail">Patch=
 Set #8, Line 657:</a> <code style=3D"font-family:monospace,monospace">    =
 * immediately before connecting (~0 s gap), so that check is a no-op today=
;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">You can probe two server and then both reply and th=
en the you don&#39;t connect to both of them instantl [=E2=80=A6]</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Right, the gap is not 0s for a later remote=2E The comment is confu=
sing, let me make it shorter and clearer=2E</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3De=
mail">change 1770</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1770?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1770 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: sti=
pa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Tue, 28 Jul 2026 15:06:10 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--+OxmSsklA38=--


--===============6193224672422836210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6193224672422836210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6193224672422836210==--

