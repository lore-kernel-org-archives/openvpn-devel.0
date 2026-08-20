Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B7AC5DF81
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hxFpjPY8oR+5xzqdehooWFTJTYlzSzVzx3cV9fL4u9M=; b=Afsb9ghbKF5Jl9ZCFxmah0KrmC
	MHom+FRIrM4L3+JuZJZUpyjHABbmlJVqnU5+J1H4uKANHWXdu/OCtr4EdSDoeieNW3fJA1O1gWlZa
	yXwWQKcTpaayap8jc8Kmg6hG7lBceTmij9FAfyX0UWR874hm4A9EUBSWRCdrI7/FFyTI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx0kK-0003r8-EH;
	Thu, 20 Aug 2026 11:15:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wx0kJ-0003qz-8Y
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 11:15:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SzZYJccTL4ZOywlOpFj0p+H6aeHx3cSdpQ6nCVvv6BA=; b=ZfaP6aHfe/vKo5EKUPKuYijmKY
 AT1cVloCGxLmfwK29kDVXfei5zUo3n/6ZI+Dybv4Y7gUD8aP9ItaTEvszMVHh4AMkP8xIInCbMBD1
 1ggkXbDYh7AvZWzKd0KMWqQ6QNMkiIa2x3ky5Cy+tmre5+3hyR/tG23CXD7oNj+53ckY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SzZYJccTL4ZOywlOpFj0p+H6aeHx3cSdpQ6nCVvv6BA=; b=A
 W6JH+5bGEiP3mhHOGD4FoH1CikEpqL+p4HUzOA35PRsJ6ylK09WLT/1Qn21kbw5U6KjRhrpKF4NZz
 ZZSO5N+7Nxp1FgwEMEfvo2sN7PYCrGaADZZcIOU/3/5OsMGpKJuVbsyRH0UicXwgXm+WA3WWiK4KT
 D64AOIl0zEB3RvUQ=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx0kI-00072P-HN for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 11:15:43 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47f7872abb6so1033101f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 04:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787224536; x=1787829336; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SzZYJccTL4ZOywlOpFj0p+H6aeHx3cSdpQ6nCVvv6BA=;
 b=HM5IIoOaoHBU/mgvZfN+chgr5f1ptmZC708ml55ivylGKXqFoAid6qq1UY90cxwcwT
 CK/jT3/b5+Oacc+d36hmHMvKRJrJCC0isBKiBkz5lt49QpocRSLPwwKl7VRdUlyxAIn3
 dqe+U6FvZBs7g116qsHUtBtXwSCmjMRWAs+oTTT+weyfesdv2eoJTdLCTybJl+2TF219
 KaPWB5lrPqNuFkRkZM6dOeKKOFBWdz6VFKTQwXDqRKJA9NvrdSA7qVrNqgYVVVLT5ZvS
 NOQHiTTW6qWrR3r6FFTbxEZhZmECjtsqZE4XenxQXqyU3LK2Oo2YRshPxM5Lqjsq7SQK
 vrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787224536; x=1787829336;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SzZYJccTL4ZOywlOpFj0p+H6aeHx3cSdpQ6nCVvv6BA=;
 b=dCs02iYPfNmMFHnKOxImALjj17I9p84Iof8s4RSjrC5csGQEppoL/Yjdmyd1jhzcGr
 +/MUW/HTJaQthLwdN5InzjKxf+otli5PydRcIObBRE/dyOxNwknGhaqvsXs6pvXEBIDM
 OTe8fvlw24AxYEu2yj++/SB2qJJQn3RzjdSlk6iUx9wPWtJz+qTJm48fndY/nZ+Vx0uU
 Z/S8Lqi0/80mK2tFtUkYWnag60CrsZWqBh4cxTV9rtq2WtxPXRrmyWuzEzz6d9PfnXsd
 cIWuXZOX3DdbQ7oQEWtQN1Bymo6QrHE1dgLQKkOf55F3jMeJd1hbNnc/iNnyHCVqI+hl
 5GbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZDSRYunP7+rEvhZxgdnICcCGsoQoe4gPt2Z/N0NPw+AymvL8kx4G3gfgBdlrEJUNfSLaq/xaSsdOGYmy5@lists.sourceforge.net
X-Gm-Message-State: AFuF++kChqe2kvTw+ymvasX+OBhcGL8+JsAtHiZUFj/iPjGddwtuwlFr
 LsxTTuNOceFkfvxpmeC9dKc8Z7tY4i5d5zBJu6olHlHhhTYGJYJdKNZc9FRGfcTr8yvf7HKAQpP
 6vkAsdw05LmvDSQHZRV0VCsyS/bOWXETqlc27hj6LDUwJjIViBALFfhgqe3KaJbB39l0F
X-Gm-Gg: AR+sD12jzf035RkISS/ojHFjwiuR3DvkpO1+j5HNJYLEOMI5/gvlCCtUTBsNah9opDE
 wsF5D23dRUwLqpeHd5dQi8A+XqUevQfcIJ0cSEOEBqwZP0kToiNq+Xw3DFrMHvw5ARYighG4dOr
 wdCd9800Rrdgty22HIbWKJb5fkfe82XyaXYbLo23U4byQXTUmjPTQ1+3v8k33lhURMaw7hH64DT
 q3lrrqxit2RK4xGkPCStZ9DIn+B+1hP5VlkbBQRj39HagWVj7la8qwdUXn3AA9G0Fz9hzHdRyXM
 jXQqhRkY3oPXBYulVe8HLUvLwH8ak+KhJ9NyyE1yqBSIPyR1xwaUIq/60iuR8N2Ggdyih2k2I2L
 Fh95AP8WNiNHzzGdWimKBom798lFcMMyxDxnrghb/Nj6X5wnj4Y43Jnj3QJ8d81Y18rhE/tT/6t
 B8qFglsI7wT4YatVXKK8HKAyNJhLdalh6AJG8zaZofkLL5aRu/OHbxGpLWtx7seICCwI/4LeiXY
 b5YrugIOBrkZg+vf4irXJ87BlatczRAklfR7A9mWZxsAzPVclH/qnbablBVxXqA8KNBPKfvF07S
 hDG/P7YydHhrllCC8v56iMwNeQ2aZNERcn2yDe+nJj7kqEmE+eE=
X-Received: by 2002:a05:6000:60c:b0:47f:71a6:970e with SMTP id
 ffacd0b85a97d-482b1e84686mr22689822f8f.2.1787224535775; 
 Thu, 20 Aug 2026 04:15:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b144173csm12243663f8f.6.2026.08.20.04.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 04:15:34 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 11:15:31 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: 871b80b3d7079145d0bb580e6601b4e6791ac753
X-Gerrit-Comment-Date: Thu, 20 Aug 2026 11:15:31 +0000
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <85871fe371ee934a80ca48721833214d92aadca9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wx0kI-00072P-HN
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove various
 unused functions
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3626075955974656767=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3626075955974656767==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P/vgr5q7Af0="; charset=UTF-8

--P/vgr5q7Af0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
zvanc has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail )

Change subject: Remove var=
ious unused functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 14:

(2 comments)

Patchset:

PS14: 
LGTM=2E But befo=
re I +2, are we sure that

1=2E We won't want to use some of these in the f=
uture and have to dig them back up (or re-write them), since many of them l=
ook like small helpers?

2=2E There are no external users we may care about=
?


File src/openvpn/plugin=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1610/comment/d8e529bf_070501d1?usp=3Demail :
PS14, Line 138: 
This change =
now leaves two blank lines=2E



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1610?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
Gerrit-Change-Number: =
1610
Gerrit-PatchSet: 14
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Eco=
m>
Gerrit-Comment-Date: Thu, 20 Aug 2026 11:15:31 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: No

--P/vgr5q7Af0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">View Change</a>=
</p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?=
tab=3Dcomments&amp;usp=3Demail">Patch Set #14:</a> </p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">LGTM=2E But before =
I +2, are we sure that</p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">1=2E We won&#39;t want to use some of these in t=
he future and have to dig them back up (or re-write them), since many of th=
em look like small helpers?</p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">2=2E There are no external users we may car=
e about?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src=
/openvpn/plugin=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610/comment/d8e529bf_070=
501d1?usp=3Demail">Patch Set #14, Line 138:</a> <code style=3D"font-family:=
monospace,monospace"></code></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">This change now leaves two blank lines=2E<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1610?usp=3Demail">change 1610</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c=
65b835360b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1610 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 20 Aug 2026 11=
:15:31 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></ht=
ml>
--P/vgr5q7Af0=--


--===============3626075955974656767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3626075955974656767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3626075955974656767==--

