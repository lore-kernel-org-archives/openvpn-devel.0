Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C0CC5B56A
	for <openvpn-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DD218GgvvuR/FonvcXtOVomWF+4v4AZENqBNacDZR+Y=; b=I1zHZiVchWRg+9rah696RJPfGB
	n1FBP58ioVsCMrrt7V3Q6u5Sgml6+keFUP/Oyy8ZkmVbRCDa5yXZc+ZHX63u2K1zlt415iYeq2J7p
	IzYOVNDmelEV/LDoiLie0xkIlEP2bMUG4o9gqC1tW5AI9YIA4VtG5yWHFhCt79DXO2pA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtqyB-0002vO-UY;
	Tue, 11 Aug 2026 18:13:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtqxx-0002v6-O6
 for openvpn-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 18:12:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dRV66Ilssgf6Tjf3Pa+gnld31BMhXPDRTxxeMKA7g1M=; b=WemD+1UDmfg/6YAEoSGG2flvmC
 xbos8EXhp9ykVTyGF/CmiHUys6CVll3bimxSB+6ulvt9zh3dOXGy9I9JxBS+d1+x4DdrobHsRXgAg
 CYdj4X2DBGmLwQvmMKsSeY9yJBPOLXIGoL2Lf8y9g/6rP2ncll0lN20YOdp6UP4Vj2hM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dRV66Ilssgf6Tjf3Pa+gnld31BMhXPDRTxxeMKA7g1M=; b=X
 8JMwirbnRPr6sK9gqMR4go1c7g3PdXY/C8FlpLwadr6AC/zFPRKxaeE0y8QpXMJiJvsmm2U+hejtm
 +rcW7n6nKXirLocs7nkBzwp5eWTZVXIVsaLCn7Lebe860hVOPk21Ci4ySnELJvnSjfZhwzIDkN/dt
 6/aLBNZM2qy72tmo=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtqy0-000129-8V for openvpn-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 18:12:46 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-472326ca506so39297f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786471958; x=1787076758; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dRV66Ilssgf6Tjf3Pa+gnld31BMhXPDRTxxeMKA7g1M=;
 b=Bpz1bj1WaCDmgxClecnD/eMqU4g6KWdwTOeJ+22Z+w3do9Xzob8cjEa8T7HIHUEAwo
 GbBaERqau43EyABiMYIYsZhFDHVq06/HM+BMR6jz4J/6MxnCZ6GlLYlHRjlePHaXvCuH
 1OS8CLtTm0KKC7Uuj09MJ6KPIloF37bUpojqN7CbuYcy8Svb/7BxXXxGU28x10C0mzcJ
 XBdhHftVziM88DsFcIlqNu/xDHEypSUZr3auIhiQmYbAtJ3fEMxpp7yBml1iWmyXRLjO
 llGnEzw28e3nI4cEl5xzLpjlQD0GMcb7jLXqTcV9vn21VGUdZUv7VhpJemQ5fW9Tfkv7
 xZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786471958; x=1787076758;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dRV66Ilssgf6Tjf3Pa+gnld31BMhXPDRTxxeMKA7g1M=;
 b=QJZawQLgu72vlW/rBvh1LqwDAJwO1BkJ2myANemx5IksCeY/eH9NRsvGucSVsrmXwW
 VpXdntCNJGDlpU0LfnsazF90keP3GoKQKgXY5ZRSvBYz/KjydNup03jj+hX9AVc4eAwh
 1B15Xs3Oqphex6Lj54hZcWjkt1KeS4516FCvtxzIQVt8YLqrnbwFAaERerGG6Z5xbeb3
 fxifP8JZSfgBg858zEoWLpkcbyBpJ7eDLVWRuQN2a/OGa4u0x0aVPZB7IZZNWcCuauyO
 xUYzCnBHu+5s9BSrI/gyjijwsOgLFvwuhHMkzYMMDeVexbGf73UHpDVUad85gP3t8yyc
 41Pg==
X-Gm-Message-State: AOJu0YxSplAwumNY9PJs7JNVLoWMu4Ep53FP9GuPJw5D1TWBCuL4DAbo
 zAZ6+ijFma45HYToBAtlEBodCBR6DgAHncmRHHp70hoMntOxa1G6I7UJD8C3oG4EVzQButVhyGd
 I//y0iRYRdKojWHOhC77CFaWuP2mnHKIEiMBwEgvFwJHusoHvYOrOmJ6vf5+w27dwOklBbah2u1
 OIqiTzrA==
X-Gm-Gg: AR+sD12JI3xCQdUIJgEWJP5itK0O6u/BEVgOX7zaImas5gA5AxTakV6HFNUy0Cu3w9N
 LR0unxkMihYuLr9EC8tXwYQC7oaEeYTnds7XNkhkCywXwddlEvHbxH/cHqaMc+0v6CZcpLfmsCU
 wl8T3Ngh8c3AC4TlBEV31eH4XeWAMTydHyixnQ/o8Y3LHmEdlzRVjcPCA9Ybbh0Ocg7j2kY+99a
 yi6yP/Gz05xPIYWMvCFPQin9ooy3XW4aTD8cCAzXfPyV7q2J+ua2n0kd3y2CyUCXrwmK9oMXvxM
 54YNKeg7vhY3fBDeLuPqK1dz3l3JhPQxYyn3ry9DD/kHT4UM0C56apdh8n/0e9xi5AHnVTWI3vB
 fC1zmj3ahU/LOTFDp2Ig669u0MyJzkF0PIchbdIjU+aOcROTFNcFZpm1sVwdA+3gFZpx3MjCLaB
 dFFT66fh7QzXXqvodcq/6q0psJjcvrVK1ZOBNooHVSMpa6GSkAFj9hLX+Pd4XeHjPQGSxOLejTF
 nxtJYzIAIHZ/Rl6tyKDO0w64d63Fxa8bcGqbSmNNPzTpvsZxLNYjgx0sZ1OYhr6i9+LMYtM0KO9
 Q+Zts7K0F7djBWMOqnXraFEL9J+zT4DTb21Iuo50SBLsNGtZQ8mVv196Xmhzl84=
X-Received: by 2002:a05:6000:29c9:b0:481:4fa4:f9e5 with SMTP id
 ffacd0b85a97d-4814fd76a99mr2683444f8f.14.1786471958029; 
 Tue, 11 Aug 2026 11:12:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5dfadsm190856f8f.29.2026.08.11.11.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 11:12:37 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 11 Aug 2026 18:12:35 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7
X-Gerrit-Change-Number: 1841
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1841?usp=email>
X-Gerrit-Commit: a7bb5c3aaef57413d7ae219097a91730a1e462bb
X-Gerrit-Comment-Date: Tue, 11 Aug 2026 18:12:35 +0000
In-Reply-To: <gerrit.1786465628000.I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7@gerrit.openvpn.net>
References: <gerrit.1786465628000.I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NDY1NjI4MDAwLkkyYmQ1MjU5ZGU3MDJmY2U1ZDRlZjY5MjZjMWRlZTdjNmU2ZTU5N2Q3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0f7b49a35ecb946783e02969a637afdee0c4a967-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtqy0-000129-8V
Subject: [Openvpn-devel] [S] Change in openvpn[master]: otime: Remove
 openvpn_time()
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
Content-Type: multipart/mixed; boundary="===============0075032319021369572=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0075032319021369572==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5SGw5+lLmig="; charset=UTF-8

--5SGw5+lLmig=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1841?usp=3Demail )

Change subject: otime: Remove openvpn_time=
()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1841?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2=
bd5259de702fce5d4ef6926c1dee7c6e6e597d7
Gerrit-Change-Number: 1841
Gerrit-P=
atchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 11 Aug 2026 18:12:35 +0000
Ger=
rit-HasComments: No
Gerrit-Has-Labels: Yes

--5SGw5+lLmig=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 1:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1841?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1841?usp=3Demail">change 1841</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1841?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2bd5259de702fc=
e5d4ef6926c1dee7c6e6e597d7 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1841 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Tue, 11 Aug 2026 18:12:35 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--5SGw5+lLmig=--


--===============0075032319021369572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0075032319021369572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0075032319021369572==--

