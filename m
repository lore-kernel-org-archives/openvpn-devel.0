Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A11CD4F3C
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 10:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kjXM+yHY7jU8jPvuYGLoU6E8sF82bBu8flkybvDJ3gs=; b=Mn9lbuEtf5F0EP19DNARootNnh
	9t2f7WPRLPP0VraA5kyucMTSRpxOKBXod1UtQOaGPCYywiFvcq+1KT2AtuuBue9H6eWJ3ql3a3wbf
	DeTnXHowWZzAHfR+s6XcpBWqF2HUa6psvgowAu8SYgurQwQCMkkpUg8ckZ/xirwNTlo8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPdrA-0006ix-UB;
	Wed, 20 May 2026 10:08:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPdr8-0006ip-Tm
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 10:08:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=37gqpCyYBfCD2gkwT0QPR1/95Ym3UCVJ3A2xxcVIXdY=; b=VoLBuMVlUsbK6hYnBUJfPoE4Yq
 s2dmrbgoLnZIKUy1JltRaNIdAUfqILb1Vn8faEBtEFUyUumGOxR3ibn3+gQpL2BGZ7bFGNX+/zsAQ
 lRKjc+2FNQgK9eSGTX3zK5/aEr6nRaZ+sEbyWnFZsoiOqLHnn4NwsmURLGI9xGtjyCTY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=37gqpCyYBfCD2gkwT0QPR1/95Ym3UCVJ3A2xxcVIXdY=; b=R
 6boZErSvNASDjWfIakpXCuWGon7pB1MAVU4AQv255jiZqlgj+Wag2kxbuZPNchIMCEgMsZqUOwXtT
 ERb9CL1HkN38vkkyCPrK7rxOz3jMWpcST9g3s4W2Q2qlrJPd9Hebrhw8Bi6DCTNtQFVeGyFbTtLW7
 eRG4nhphainjONC0=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPdr6-0006ZX-Or for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 10:08:50 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so3003150f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 03:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779271718; x=1779876518; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=37gqpCyYBfCD2gkwT0QPR1/95Ym3UCVJ3A2xxcVIXdY=;
 b=c3Pk9d7EmiJOxImvOBLR6bPRujo4RRBJAvOtIw5FqxqAUf81QOrgo5ezrVpMFJIx9i
 k7Cb4tshembbX1w4bbalUxa1JM/qsGVacOjWMoH7KZlAEWfEZJOkPloCt08dbkD+ITZB
 /ZoERGL78k831GLIdhNABWp1jRLpaTnteqW2LqNqTfIzdLnLgkeWpOMPLIKrFDW64+lx
 Nfo/jLaEzOc29s7j2CDk0bzzZRGwt1oLP1eGZkrVKRb0/zyQU/lm4DX9j96gpaHpcs16
 /F9PP2ctz10G/fFLOmgWTIw0WYoxB0izA470m9lbVGh1IUzF/drAF+AxyDFNOUk0ntux
 nuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779271718; x=1779876518;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=37gqpCyYBfCD2gkwT0QPR1/95Ym3UCVJ3A2xxcVIXdY=;
 b=E74OGXQMHmghTx63j54ldMfdoQSzh4SnQRXs77cp/h3VXoGB28PxyupgtPZN+yEN9w
 aqfkuFr5+PS22PVEInLfKIZ7HRJQFA+jWMAPVRwR9+/OBtRGVLRMxlI6kOoZeUF4xwIg
 9QwYyTfqoBfQd38DFu/xcneMrQGHJYqRiB8kNGW4Kj7uw+ZZa/Opzj3Iw+Y7OwL8lMGU
 0L6FmClyR3o4DTqluKWzb+yb2yDVFMlicv4qeb3NF4Z7llwihfLBG6nOt6liUDGYlwLx
 5cUWXbsX2Je9/HLGZtgo4NyOoRntDP8PgJCwi77C9MbUUfAwAW4GUBjVOP6a+HNRUjg2
 lzxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ED/k9hZUvKDEb6a1lnlWRkPSiEyG02EHVabQRArQTxTkv5y+MFbRUxZTL6oow6x5ijQOLerbYG41ifm0M@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yws95kwcsFWQDsDamFt7/vbt1Sjo26M9Pj38defQ9NnIgRVVZze
 gb+RD20QUx5XsN//SnRAyxh71Q7RfJ7sr+pPjIpedFuxcVkKwoZXlS54Pk6KP/B1eY/Jmcj5Uro
 SfC7leAVBECn11sJjriOkih0YG3KdgqMX1Q9C3NVTGSHCsphrJ6jggySGShKG2vt0eh3C
X-Gm-Gg: Acq92OHqmo54gxU1o03u1AatJiFbowBHczW7zh0NyTLEP+djQvziiMla0RSIa+egGUt
 8zzLA97K9ofGdrF3eGCVjupTYmotvccEn8FMFUKQAhwhmJNj5tLzmkS5jbBvF1uT5L/HooiNefw
 uYpT8Zdt3INriXhamXWdoYqWASF8yYxAzsqhrCNNn02CUGIKLI6r3sBXuJA/5LQ+MUHts2BbN7/
 4OPsDzOihDdUIZYfYddPs02GpK3IttmLxFy87AVdNKalnlNDVFeNs1/INwCoo/jnB/Fk8o1eHeU
 /hQOoF9HY+isX7jM/2QZ6HuDnQtTFPUJamGNyaFuFKKEHEdhNzfm34WR4UqT6TLagWZk9ZXEE4S
 0KUvMFHbzOlIqFP2jchC5ZCYaiT3Ntq2LAbWNYuTZc6gY/CU4X9p1Fc7xcQ8yanJenjjwF7G+m/
 IlRlzCmj17eVSLugvtThGZUda5/dCCGh02hnMvch+4UEn1kfT1U5DVOlDu2dS3PEkpbAbYc1imL
 Jslj3TtkCzAVbBuLK+6heflWyfjenOHp3vijcUXIjENewHJu3SsE0FFm3CTsL6UubZMB7bAPN6h
 D6c+LKAiOQTSag==
X-Received: by 2002:a5d:64c6:0:b0:446:708e:1e8d with SMTP id
 ffacd0b85a97d-45d955021f5mr43207770f8f.30.1779271717256; 
 Wed, 20 May 2026 03:08:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0f72sm56252908f8f.25.2026.05.20.03.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 03:08:36 -0700 (PDT)
From: "flichtenheld (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 10:08:35 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a37
X-Gerrit-Change-Number: 1680
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1680?usp=email>
X-Gerrit-Commit: 1ae98cae9b29e614b124c23055d24cb0271a1b36
X-Gerrit-Comment-Date: Wed, 20 May 2026 10:08:35 +0000
In-Reply-To: <gerrit.1779183573000.Id4e21efebbe64b963cf7847ad77bc41339af7a37@gerrit.openvpn.net>
References: <gerrit.1779183573000.Id4e21efebbe64b963cf7847ad77bc41339af7a37@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MTgzNTczMDAwLklkNGUyMWVmZWJiZTY0Yjk2M2NmNzg0N2FkNzdiYzQxMzM5YWY3YTM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4f71b88f06e85aa2a9dc58ad162a4b403711d897-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPdr6-0006ZX-Or
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix: port-share and
 multi-socket interaction
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4091403887189663686=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4091403887189663686==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2gNAOcEWAJs="; charset=UTF-8

--2gNAOcEWAJs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos=2E

flichtenheld=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1680?usp=3Demail )

Change subject: Fix: port-share an=
d multi-socket interaction
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Commit Message:

http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1680/comment/5cf7d4b5_9b051648?usp=3Demail :
PS1,=
 Line 11: entries insted of rely on the global
"relying"



-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af=
7a37
Gerrit-Change-Number: 1680
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan =
<gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: its_Giaan <gianmar=
co@mandelbit=2Ecom>
Gerrit-Comment-Date: Wed, 20 May 2026 10:08:35 +0000
Ge=
rrit-HasComments: Yes
Gerrit-Has-Labels: No

--2gNAOcEWAJs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680/comme=
nt/5cf7d4b5_9b051648?usp=3Demail">Patch Set #1, Line 11:</a> <code style=3D=
"font-family:monospace,monospace">entries insted of rely on the global</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">&quot;relying&quot;</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3Demail">change 1680=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id4e2=
1efebbe64b963cf7847ad77bc41339af7a37 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1680 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianma=
rco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 20 May 2026 =
10:08:35 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></=
html>
--2gNAOcEWAJs=--


--===============4091403887189663686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4091403887189663686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4091403887189663686==--

