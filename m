Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81C9CCA490
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 12:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F6KuBN9N5zVBBX9ZsqYohagPMXd6CSOqXu4iUO0Cu8s=; b=FhjcNdAmS8cV12AIbznCYZPTGd
	1xR4aMMNLvXrx65oNg/y6NNyYpWhZvXACdpF8l8KHo/Ari3RGnKlRJNfF491k48XMncgbTYUtjE08
	xSzqpnimj8nr5kqtoCJKnf2NTwea6VIuHi6YT2Fk7d/ObN6QgX9nqPOvl7kBMi0QsVTU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIPg8-0003Fh-Kn;
	Sun, 18 Oct 2026 12:07:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIPfv-0003EJ-0S
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 12:07:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iu6HJ5N5lRrVSw89o1GNOX5g0zVIka4/J8YKA69AA8o=; b=N9L75KUhBSOdIdC9wn4k68MU23
 vtnfTILiJK8+FI2UUmqWjzEQMFSRCYPG39JS0T+z+ms4BwnS9nohIeQW+kYNV5zNrJfZix3C3uVVT
 pXi+2M4PFWIT/tSURlCYxGtkwtag2ylMC7g3B+wIatK/MQOmAufytepGXo8r2Hmhme3w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iu6HJ5N5lRrVSw89o1GNOX5g0zVIka4/J8YKA69AA8o=; b=f
 5JtYd4HY5xsf1akpavgOYtCO7qEWSz+xFMbB1bpwqTHXCgh+wgk9CMXfq2SQNTFOaVEVbN3ShM9tA
 OuFc8ZQIdnCkCj1zuqRpXWg0xNrUCb2vawEmebMgVXxyFWTzHXsqW/agFbLHykiLTNdvrQaDJNkr0
 mmmYPk4uwzgA+GzQ=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIPfo-0005Jf-O1 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 12:07:34 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so669258f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 05:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792325246; x=1792930046; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iu6HJ5N5lRrVSw89o1GNOX5g0zVIka4/J8YKA69AA8o=;
 b=DoPM8e0fPMavm84PKDO8pNXAtf2P9O8uoVi0tzygZoDTpDbHnnqK1d/jZkes/89/Um
 AChHwDcuDaa7I7qr+252hj+GUeJxgeHdq7F9hc0Ja8pDQnJ9RVCmk8dGBe7GEUMhyEtk
 iglsSKMPaTLJVibzdOQU+2NvecIjgz1SUt2fD3GnML/WH29EA6ZomgRxSOeOkcac3m94
 k1GhoNjiRbm0mHDNa2BWmcFI/6hd8PxYKNlNrdmtBStPK8CsKdiNMHwrI7qk+YIuD30F
 0UtZCyr2zbyudN2AQHL9VSA8cZwjYBhC/SP6MmCU88Gay5+6zIjrDxdRaoumdTFb6A8Q
 1xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792325246; x=1792930046;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iu6HJ5N5lRrVSw89o1GNOX5g0zVIka4/J8YKA69AA8o=;
 b=JvfmKvEOPYwYYmS0E/fo7YDe5/lkwL8bNpuXw2qj2WrtMgUzzJpkENh9t+sEx4/fbz
 k0UVcMcEqFs+EGCzQ3hQcPDhH4fOa/aQN1jc5xhaoyiHTjYmld1lIUn+WguPMM0ixmn2
 teJ6A3xcwBTh5MSjm6m6w5bgp5AZBWEaogHenz7nk9QXOSb7fA2XxxA2PTJlp4h2BVNo
 UREc32A6kgEFsZo5t9U8GWzeNa8v7/BmELx+x8tTUg29zmbiq+FNrbgF9xorKPx4Ndle
 UKg80PcbyV0/rUGZAIWBMbduVJrtQsQnYZk0f+B1BQ4HjZoa8M0GdKJJmp+9p7dflhEa
 prCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx51zIx7KAYVNGsdyLnc8UPUrxfMu7nEcrmvf1HrkSuJEepAm/BDAIQvL+9vYV1oNsQB7xL4yHOmJs9UPbI@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJECmDaoxrWYL2rovelSQdaeihYCVn+GP4cdM1PiEaIWFa1jm+I
 ilCj+CGpPp/5t7b8DoDx5fzAcDakbMns3+nFSyyBGL2ZEqJQcTN7PU/CMPcKJzK7hNa0XXkcJq/
 MJVaEF5faidOJVwVRMiGKdCJKdVv7XedWQkmZyqAYwOVZDOFUjKrNE2Jxk5Fgcx1kRoHM
X-Gm-Gg: AYBFou2Yd5SJTrBfRjOx8jh+W0duW+wGODIXKEa8NEk60AQLmVYUCIcrtAO4vYq8Ua9
 i+Tp2qb54yarZw0Rlj3MNuUpfDPKL4h+otLRx87F56D1jYkRK2512mdV1o0rgA0wsxsnc4adFJd
 olYUQqwg66H5NJAcW6yAIObLmhcHD4JiRydfD3uH3AGF9JxgQYeVe4qMZ/92e/E7HXK9jNAzGLa
 eFj44n62nKIWUeh3XJQ6Kco0H6YkZGXy29oD/FN/exCOD/A8RAQromHOdi2S1SuIQZgH732aGES
 KbIL7xGT2mTWNqfA6FASQ+w/+qH6FNPz0rvXzEWKlS2FjXYnfDBYtJwC3WcgW41B5V6203kvlRw
 vunSCv3hiCD0PpjzrjpPAAoEMvzf5ZRQnWUF8vOo58+bFrQ48ieXAjglNEA0reX7YAXm1biIBQu
 vcYYUyB36brHStrpCR8LAtVIuzE8MUqeNLjdIdewNI5X2NxdNi4lXBqiRcRLZTbpuWkdlGpcTnW
 O6tyV7H92xupBgBT1Fv78LoMNqvA58FwWwyOpSPoGjakBSYYNH45tyk/z6qUBF39YjC5BLH9PHt
 Q1q3PGNW8o2SRXo0lhA1UolW8LydUyO9b0wcgunx0+AurE4LmSAwdS+0NHYn
X-Received: by 2002:a05:6000:1887:b0:488:8437:b8b7 with SMTP id
 ffacd0b85a97d-48e07978bfcmr10241588f8f.7.1792325246133; 
 Sun, 18 Oct 2026 05:07:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4f8bb6sm17542694f8f.34.2026.10.18.05.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 05:07:25 -0700 (PDT)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 12:07:24 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
X-Gerrit-Change-Number: 2010
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2010?usp=email>
X-Gerrit-Commit: b2d31a2fa8b5ae6544ba75ab3a7c8111c51c3390
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 12:07:24 +0000
In-Reply-To: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
References: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjc0MDI5MDAwLkljMzYxMjNjNWE0YTJiMjI5NWZmZGY0NzE3NGUyYWNlYjlkMTdkNjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a3ad3ce34f1705082eeb83d9376704c6c7b6e9c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIPfo-0005Jf-O1
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: gen-sample-keys.sh:
 use a random serial
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
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5342354768651254606=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5342354768651254606==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Dx1jgOnJjnI="; charset=UTF-8

--Dx1jgOnJjnI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Steffan Karger has posted comments on this change by Steffan Karger=2E ( =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail )

Change subje=
ct: gen-sample-keys=2Esh: use a random serial
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

P=
S1: 
> The script no longer works with LibreSSL (I had 3=2E7=2E3 installed =
FWIW)=2E
I don't think we need to support LibreSSL for generating the sampl=
e certs=2E We regenerate them every now and then, and can do that just fine=
 using OpenSSL=2E

That said, do you have the error message? It might be a =
quick fix=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2010?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: c=
omment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic36=
123c5a4a2b2295ffdf47174e2aceb9d17d668
Gerrit-Change-Number: 2010
Gerrit-Pat=
chSet: 1
Gerrit-Owner: Steffan Karger <steffan@karger=2Eme>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Comment-Date: Sun, 18 Oct 2026 12:07:24 +0000
Gerrit-HasComments: Yes
Ge=
rrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>

--Dx1jgOnJjnI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Steffan=
 Karger has posted comments on this change by Steffan Karger=2E</p><p><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail">View Cha=
nge</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2010?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
The script no longer works with LibreSSL (I had 3=2E7=2E3 installed FWIW)=
=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">I don&#39;t think we need to support LibreSSL for gene=
rating the sample certs=2E We regenerate them every now and then, and can d=
o that just fine using OpenSSL=2E</p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">That said, do you have the error mess=
age? It might be a quick fix=2E</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail">chang=
e 2010</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2010 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Steffan Ka=
rger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Com=
ment-Date: Sun, 18 Oct 2026 12:07:24 +0000 </div>
<div style=3D"display:non=
e"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--Dx1jgOnJjnI=--


--===============5342354768651254606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5342354768651254606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5342354768651254606==--

