Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7305EC88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0qKgFw7DVc+cZa0l6bDbn0rwipG4iElOYLN1VZRcHTc=; b=Abhq+lHkAe7P4zA5kyjf8wT9dq
	SHqAZmdyFRhlIFd3UKVzQgTssPBAo981ZjVGprOz6KEqvZ/2e+10G39MgJHwHSPLK+NTC57e/rGEG
	jH+dSlZs0zvx9J9qGfgAu4qX/WG2G6ySWGgUwHROY4Z9+GpYR4dkeeMWSf6m+qyn9PkI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4zvQ-0003kX-47;
	Fri, 11 Sep 2026 12:00:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4zvP-0003kQ-Dr
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 12:00:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oyTwTXoPpkaLQjM0DGtLfxRyTswOZmpIIu8x9op1LVs=; b=DID8/FeIv4iDSfFutN5gfArRFm
 aTnp0PUV7KfkXnUm/BqQETyoZaYRSmviIzX7zTbbdy8EczwNSjI3KyWVLVSTBsz9gdaj+X5B7OSzz
 hPuaogfdrj9SevLylqeSPCPJVDeWswb/QXS+I/Hk5XiWAxJE8Ep8K0pEDKrmy2sMl32Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oyTwTXoPpkaLQjM0DGtLfxRyTswOZmpIIu8x9op1LVs=; b=C
 es91YGp8aeAjr0oXD+7b5rxUwqoCVtoH6U7ZqtmOv/5ADl2z/l1PqKdq3ZXHbsZKmWLLCGrnyPKuH
 9UM6O9VzWIXHkNQBHXOJCSLytPjHECSWUlQm89cMqfPZ8AQM5fiV0M0VVuLo5cd1KIgc8NNccHtwO
 YHQ0pcEsVYNfyhBE=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4zvK-0001dI-BY for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 12:00:11 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48589798dbbso767630f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 05:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789128000; x=1789732800; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oyTwTXoPpkaLQjM0DGtLfxRyTswOZmpIIu8x9op1LVs=;
 b=Iy7s2gLkEbEyjzCrx2mFfDkgJTSGyqD78ze7QoVYpNPXEApsCA3fVaQd0gZGHjZkWn
 MmYag4hnxgUsOcu4fHKnNTQvPE60HLVtJFebpF8JPNRlFEaUFbSIjer1nPo81RWI/VcV
 FCjxt1XZV0cGMqO6QUIPmMD/joMBAnq0ppzgLcNiUz/yZc1nQa3lVVuVMHvsTIjHK5sY
 VSJfXr7h+Jm3YUMq4sX9gmnApsZAxZDplD+GCBvmUAQEgFVC21Q8+J39KZ/zL8FN1Tgh
 2Qw3+KYgCrwk18jBH8RauPK0WU95GUwstCT0wcUFViq0t7IHvhpSpWdS5AhkuvaJCbi2
 rBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789128000; x=1789732800;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oyTwTXoPpkaLQjM0DGtLfxRyTswOZmpIIu8x9op1LVs=;
 b=IKQ31aQuLHQ41VKhgw+dPTPC56NgObUmecHS97Ob5tGp1GtoudM+tHM7bFvnpFWKEw
 uJ6R3qZXIF0FGREtMkHzi7nkZis/3m5eVgmrl1YFKKKeHT2HUq/+4K52Cem52FoGaOs/
 o0G1CCvVZZA9fKSv/7rvk+qbC5++7vEdN5at26tt4zPFsrQPngpLNQbGi3oPXVdGENil
 t6Vgb+wkF+vDVtZjWBtSL7gfW27gKwg0OOxBaD24FneU4Cs6du+jWdVRBDGNV/flFjud
 Vzu9dEUHI1pWuCJxgZjHxn8YqaSyri1jz7KhFf2HcoclTsvX7gg2kJ0lRsoP1lSZi9w3
 X/vQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwS7UUeKwUF+JoGHY9rUSiTvc2p1Vc4TBuKU7XHnQA10JyFdo5LpC0BCh8lmkXK7baVEgKvwX8PkGRh5xKP@lists.sourceforge.net
X-Gm-Message-State: AFuF++lVGiwRRf4BPUo7GYZ2+liGz992/Eig+BcOmcTx7VP3Bjlu4SC3
 QiDTtLwzAwYYJiLiaACOtZZZjSSs0aQKLjGG593QATVu8uOBKnXziePd6w4uZyZbkvLOlSWrFaW
 W5L6f7xPDI/ayoU+QaqJHalJ2vTRSRcK/TxDK0LIBPcYgnWIASNk6iBnKuW4vDJn54GUx
X-Gm-Gg: AYBFou1u3wYSMHFje7BMp1RIAFrY1mkdzLBez4jC/rIA4ICKYtRWixmGMCTiyGUxKQU
 5sejm0/Q1Hgurc1//l84y8uc1CQ9lJwOHPHy2bXp6hY6BxVOhxgKwvVzmMtvOfUJ775Wyly6F6F
 fL16uXCA0aVp6qiu3FClZenusFZqB4AiTBrVYY9iZsRGHXuCZkZBxb1i0zqOr4mVDyIKHH1tXnz
 W0AtZO6KGxaM2+kPs0fIZBAH5qcTCYq76NA6r2eRglJ9nAHPz9+ZQUcwX9hpYrZELUGaVpbVrTJ
 84pBp6I8VzyYO8iTbfB0RYj7THko6jhJEw2H7gQ39MlwxjumnwoUd0Ybo5+8FuslOoqqPJlOgKX
 bICIYz21d9o/0IGpeiItYIYMoImsIf5Hjc5cpa/DmChohrlJ5OMRzTSf2C/b+GUZQOFfOrWzPKi
 f1D9DysqCgyqdre4BoWJ05JIq91GjSGzDwWo3p21uG4cTENFdITKXWDIKNR7Il6rEeJGJBATsdX
 mwnUreo6Zsm5+nmlZ7TKC7nQ/XXVh3QKuMrlWz8OSR152R+PfwLxNtvrAPTL9plRYEFo4C/yN8T
 v0zqSoxhjK8869Q0QBnslHaRt5Z+JFSEAvfNLgafiOTJ+GDzLHESMXg5k3xFnw==
X-Received: by 2002:a5d:588b:0:b0:481:512b:f0e7 with SMTP id
 ffacd0b85a97d-486eb2f0bb9mr4662425f8f.17.1789127999047; 
 Fri, 11 Sep 2026 04:59:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35c071sm5705878f8f.33.2026.09.11.04.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 04:59:58 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 11:59:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
X-Gerrit-Change-Number: 1904
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1904?usp=email>
X-Gerrit-Commit: cd975aa044ffd02f2dd16b2f954081d9f0099f8a
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 11:59:56 +0000
In-Reply-To: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
References: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODE1MDM1MDAwLkliNGFmNzYzOWNkZWJlODFlYmEwNWFiMDRlZmU2ZTg1ZTYzZGUwZjllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0eb44e7bc48a38f37b9d26a0ec7ce43f22aceee2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4zvK-0001dI-BY
Subject: [Openvpn-devel] [L] Change in openvpn[master]: buffer: When
 extracting pointers from buffer, retain const
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3711518889681369103=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3711518889681369103==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Zjs30hXCX8M="; charset=UTF-8

--Zjs30hXCX8M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1904?usp=3Demail )

Change subject: buffer: When extr=
acting pointers from buffer, retain const
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(3 comments)

Commit Message:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/comment/c72b284e_2efe3978?us=
p=3Demail :
PS2, Line 9: Currently you can use BPTR and similar to implictl=
y remove
> Typo: "implicitly"=2E
Done


http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1904/comment/7811f908_40797ef6?usp=3Demail :
PS2, Line 14: pointer i=
f the buffer is not const=2E Change all call sites
> I will try to remove a=
 few levels of negation from the sentence ;)
Done


File src/openvpn/buffer=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/comment/0f68e3b9_1dc9=
94af?usp=3Demail :
PS2, Line 1138:         const uintptr_t u =3D (uintptr_t=
)BPTR(buf);
> Yeah, code that isn't every compiled, so the build will not f=
lag it=2E [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1904?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
Gerrit-Change-Number: 190=
4
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@=
mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Fri, 11=
 Sep 2026 11:59:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comm=
ent-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>
Comment-In-Reply-To=
: razvanc <razvanc@mailbox=2Eorg>

--Zjs30hXCX8M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail">View Change</a></p><p>3 com=
ments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/commen=
t/c72b284e_2efe3978?usp=3Demail">Patch Set #2, Line 9:</a> <code style=3D"f=
ont-family:monospace,monospace">Currently you can use BPTR and similar to i=
mplictly remove</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">Typo: &quot;implicitly&quot;=2E</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1904/comment/7811f908_40797ef6?usp=3Demail">Patch Set #2, Line 14:</=
a> <code style=3D"font-family:monospace,monospace">pointer if the buffer is=
 not const=2E Change all call sites</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I will try to rem=
ove a few levels of negation from the sentence ;)</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/bu=
ffer=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/comment/0f68e3b9_1dc994af?usp=
=3Demail">Patch Set #2, Line 1138:</a> <code style=3D"font-family:monospace=
,monospace">        const uintptr_t u =3D (uintptr_t)BPTR(buf);</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">Yeah, code that isn&#39;t every compiled, so the build will not =
flag it=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3D=
email">change 1904</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1904?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1904 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: raz=
vanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 11 Sep 2026 =
11:59:56 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--Zjs30hXCX8M=--


--===============3711518889681369103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3711518889681369103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3711518889681369103==--

