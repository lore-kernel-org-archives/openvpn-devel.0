Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CDAC5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zdZgucLIvx44RIOCMK+bRdpP+NrYb/f4D5ymQqQJsgE=; b=d/98bNEwf24CErLnqtatXHGPWs
	4+04DQ9HFBhP6IfnNRIAc/FCjnYmUWRdEN5NvbgrBtgw4Qmt2BxAbJUE+ahFJg6wIr2Kjka84vvzH
	dfdrlqOojH4byneAxbjjfLrzw3qitwMPi4FUrKwT0TaAW//uSoN0j9fPigR4ir47/PE0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvwv5-0005oR-6k;
	Mon, 17 Aug 2026 12:58:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvwun-0005oC-VI
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:58:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=IepaIFpqkhzWY1lUoMZsuq4ct699fPLphcgVQ5cmL0w=; b=bwBq95mcnGd7lK7DMkp/y77y60
 OjmYPK+Uh+4kQOMUqU6KqBTmwYDydX3AvWKV3LR/MKNqgEsaloMnH4vcprl4vIOgWhc8OkUzFWzpE
 LWllzJeT9bwbVz9hqn1uDtH+HjmJFAXP+Dur0oA+pzCKzntoQHv3RyJC1qt3kMN6dhJI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IepaIFpqkhzWY1lUoMZsuq4ct699fPLphcgVQ5cmL0w=; b=H
 3jWS+ZD34KQAbC2UdIVzBROR9tZIg/VmtzoMViKO1v6z6jLuso1Xd16Aeo4eSdqMf1xzP4GhDVRqp
 N07oOrHxzwSXcKQ0wNPthAI+CAp5a+G1+L+7MhD5iBGlXviGJDJ03XelJrxKpRUgSL1x0ysRhczXp
 ZsE1aUyRXGRXne6E=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvwun-0007b7-23 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:58:10 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso23080535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786971482; x=1787576282; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IepaIFpqkhzWY1lUoMZsuq4ct699fPLphcgVQ5cmL0w=;
 b=HbJQO3k/wjLttfoWyDVwmTnLuej9eB9K1Os766AyY7NZayh0Ery6tq5zDUQ8sLMjAd
 X6WnOIdBO9hnvWeSR60w84rHAWxSxJIxHlpFqnXwuRx5ORCFKBifQvEbmY7AKvGxnY3t
 cLB257Hr9tB7p7LVC2XsrMZqWdfD2230yAHxfjOikznPpENYXRLRWEoVaBiMqJN+T0QA
 PdE9CIxnu9x8y0YOQo5jYrj53m8+80QwY7rqmbZlZvpuGjTWBqo4KnCb8QU+Zme8vXjp
 jL5r4511lA/RSWLui3A2e6PpT2DLPlWCVxSkYvrLVIN8DwU61CDDZXrI5FB+DHvXEslc
 oLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786971482; x=1787576282;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IepaIFpqkhzWY1lUoMZsuq4ct699fPLphcgVQ5cmL0w=;
 b=hGeN2Z4kk2xZ85JwL7Gf3t/zGPXpMtQgSZYOsTAL7KtXsC0cIHWQFmgGpcoXQu/EEi
 W0Sss/zyMbmJz/RwH1LrwVi2PLzcx6B0aJZfUNNBJbO4qvF8Z2EV0JSp3iJaEb2pQDdx
 4rCXPw6P4mIIp/R/k4pA5dzf/tbPBNnRfh1m0FVlMxEJTV59K51RVZEPic9z0uMNp/rW
 nXJMQDMeL2SLgpUk4z30lugv7WpgrrNOfocdVGDVtxh4zRP7DoraAhF/3nRKX2QamSmV
 0m4sdCcUoqBTKBmV6vVhmBtIXS/vCZa7S4VHXiJlRpZlnkTtoWJ2dSVVmivgP6nKdpQo
 pE8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrihq8PW+h6GHsY/hOX8ksA4XFFel674Hnub2QzXqDX/yhQXVYPDJgPcgyV9gdO5o3XZNCxWtR+WqRRcxMf@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxJ90l1V0/SOqg29HoGn+lblBK92vpdZzPRsgH7tr7FPqzK4asI
 rM4lpo5aKTs0lqlcxwVkrNr+cWFNibvECzKG06/2baOBd13FalEostR2TcaAD+P0ZFn5C9IW29W
 XCkCjEzcpNXdjxZQN7DqO/rRuNgQIbqI3rfIOUNFq07HgMTXXjgr8kut39FL2WnQtYTnvtRwmNQ
 vQcdmI+Q==
X-Gm-Gg: AR+sD11iBzfWzJhTLuaGFZWPe6+VYX0ArxfQW9ibaecODRTnZR0fwO6vpkMqjJ0n1Lb
 Q0PUf/SwbmOvj+TEC18d/mdyusjGreUT40bEsi3K2OCOwKAZdw/c6x+ApIq0ll04wp7GO7H2Nwv
 w4cOUREUd/O6yGKjnBv+14cutDQV+4/l1kyXoQZ209blrgU6g5H8WReAkYr33aDMmJUJWlls2qZ
 FY1T7PiQ+4ZZgOKJUzemhDcUaz23ebckT6S7smG0FvQk1wvsde/R3xYve4TzMWdxyQbB4q8x502
 SSiFL/YZxiTkscxmGFyGTLbOv6APnSq8H0qjux4JGiTd34XJpSLmeYvxN2AH64i1Wysy2JQVpmb
 j24ogWu1hkqqY/G1+UY228DIibIjtcVWjUIcb0HbW+E1EPZ7t0wD2mozSb26L280dC1C31fr+gt
 CpvdofQTMpx4Ti1Z+oyHcvpJ9Y7dJp27XIGxUW1FCdvYoTVli+THPEjzT5XelUv7tKm00dlGDi3
 FzZOoKaOfDIQ4M6tsCT6fZCOP2E/2tdCmW5md3zx2Oi/HA/eYRWZlVCrdhrJSdI1S8z5Fvn1I0z
 s7e6+euqe0eX4fqgzN7TiBanPvyVee1PnNNwNcHMn0MC29lnfOM=
X-Received: by 2002:a05:600c:a087:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-49992409ab3mr269850925e9.15.1786971482390; 
 Mon, 17 Aug 2026 05:58:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996176b8asm122397075e9.11.2026.08.17.05.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:58:02 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:58:00 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
X-Gerrit-Change-Number: 1844
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1844?usp=email>
X-Gerrit-Commit: 79f87e8fa83b20485262f5a50497d621febc5e40
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 12:58:00 +0000
In-Reply-To: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
References: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTU5NzcxMDAwLklkM2M2NjgxYjI5MDI2YzI5MjBhNjJhMGVhNTcwZmQwOTg2NDllMTk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0b59bead892ca1b8ca3ef987000bf0542417c6e4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvwun-0007b7-23
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Reduce number of
 future epoch keys from 16 to 4
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1574832740387007529=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1574832740387007529==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OjGEO9xDnsA="; charset=UTF-8

--OjGEO9xDnsA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: razvanc=2E

plaisthos has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1844?usp=3Demail )

Change subject: Reduce number of future epoch keys=
 from 16 to 4
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 2:

(2 comments)

Patchset:

PS1: 
> Is this a squash gone wro=
ng? The patch does a lot more than the stated commit message, and the part =
 [=E2=80=A6]
Yeah, something really gone wrong here=2E I will redo the patc=
h=2E,


File src/openvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1844/comment/39eef646_1c164414?usp=3Demail :
PS1, Line 2000:             =
    buf_printf(&out, "P=3D%d\n", session->opt->ping_rec_timeout);
> This ac=
tually does not build: [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
Gerrit-Chang=
e-Number: 1844
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: razvanc <r=
azvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Mon, 17 Aug 2026 12:58:00 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc =
<razvanc@mailbox=2Eorg>

--OjGEO9xDnsA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: razvanc=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1844?usp=3Demail">View Change</a></p><p>2 comments:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">Is this a squash gone wrong? Th=
e patch does a lot more than the stated commit message, and the part  [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Yeah, something really gone wrong here=2E I will r=
edo the patch=2E,</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p=
>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844/comment/39eef6=
46_1c164414?usp=3Demail">Patch Set #1, Line 2000:</a> <code style=3D"font-f=
amily:monospace,monospace">                buf_printf(&amp;out, &quot;P=3D%=
d\n&quot;, session-&gt;opt-&gt;ping_rec_timeout);</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Thi=
s actually does not build: [=E2=80=A6]</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1844?usp=3Demail">change 1844</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1844?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1844 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 12:58:00 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-=
Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--OjGEO9xDnsA=--


--===============1574832740387007529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1574832740387007529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1574832740387007529==--

