Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BE9CD8CB9
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xNF3SLsUV9UofCIBb1ArpMk8h1QyPqG59EGOnLgRqMw=; b=jZBdpIRgEDMuvGdCSifeDK7i0V
	cPAxrjCamS3ASzN9kVKtzguYPNP+UKJ0Q2n+i2kzI8EttLf6EgvRednDNV/8F0wPmCzIvOboGuLJM
	4XjyPUxQ/TY2r0oM36OH7epugy/HMeAXqBVIAzS5gvgXavfpvn4Yvlkgls79NLNbwGLs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWyT5-0005xs-7d;
	Tue, 09 Jun 2026 15:34:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWyT3-0005xm-8O
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:34:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kJEgYYrEALuGwclOUzN574YCon6qTn1IglUTOzkET1c=; b=RmdpXvEDqmF9TV353xnnV9KSUO
 QMAZWxoH3ivcT1GRu+8BWbMYiL4ejlzW8LbYHC+GYekh0bSemYd/qCBeT7dFuWCLjRvcbGwXOIE13
 TSjVPj8zjTYb+CWJYfVlMBOZAJrIkkPoBbbXHl8zIG9xbzOONomlHK4rYtZtE7BV7hTg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kJEgYYrEALuGwclOUzN574YCon6qTn1IglUTOzkET1c=; b=b
 L4wasL3Qu60tWrnZgIeklIrk72pBEzyKnGYujZpOCEhyXy37nIesRk23y7N1P5DRBc3bMXYFWbYF4
 OBk+rl1mWtVYgjucOONkTjBpzf8qLdDw2JbZeUC5s6l7SeT6Nx/i4r4OqrFxMBuiULUGeuFML+aRt
 UdIwBXt1VeXGVIPI=;
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWyT2-0005iM-KA for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:34:17 +0000
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-68b90fc6a1dso777444a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781019250; x=1781624050; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kJEgYYrEALuGwclOUzN574YCon6qTn1IglUTOzkET1c=;
 b=d1PnEETYgCBtGmJ5Nr+xRxbXlmXyQVEv1n51wOP5KsPnZB+aWCWAa3Unwhd2dCJeot
 e1DHD4LNGFHgMO0rWVPBLUuoY/ks7uOxy/2tNN3lsIRj3fRhF4PFHsxoE6iP+i8szhcZ
 uq1RjKrG6HGxuScPvjFXLuUgayUNTartXvlJb/fz85KsgmJZ9GK8q0M4nyoKgPj4a6Vx
 kzF89P5GBWpeG1Q4DWWoDt7ky+r9zMffbVLg0GW2YfjMV8oLkMZ1MjlrK1Usjdbd0JQg
 bBy5Vdvt+vXmHmfYaSCwQNOYzHgsJrtipfj+foxSGBB+q05xcBdHztLiXoXbU4mieH26
 85UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781019250; x=1781624050;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kJEgYYrEALuGwclOUzN574YCon6qTn1IglUTOzkET1c=;
 b=HD7Tavv88SloaNg5z/XXCINkpqtmq3CHu6U4lx+O5JK2nrESzCnMzVXEeM1vLUs99w
 sxqeYgF9a5bY9aHJbQSfigg9+D60R6arB1iq2EnrOFOxZ/9yJ4oPtZ2i+ubrcJmv27cT
 9z9SN3fUy2FESasCohMVpVIuHMTEFnC2OZFp0082J+yZeWU2Cq5+QjL5mL22UyyxhVc9
 do+ShT9/FBWfi38QXX6jkHts2x5x6oHGq5aBwvDzQCIHix7pBMKuH5g6+X86YvzK3aI2
 io/k27FJ1WD4IFNeQEAL3lJzl+rY9JIyo5+SJYnThjkmyCbybV28xh+6NGOKn4zf0vCJ
 xJ9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zsks/roWnh2OhbL517E39Lh4u1YrHkYQNI78VcwTtE5tRU8bJWvAZ0jmx6Bo9aBT7YoOT5sEViK9e7nvk@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxauohgO4ipHQeWamAInUi53eVPRmGk6UZqvulpf2QQ44VjTUYS
 RFEJG6A+Miv8oZeLUVI9r00k4ns1EZXwcw26YV+vaU0ZdvjRL03q0G+Ws20MrrAVoqGOSRBAEPS
 XXs9KkwtmriG0ekfizKVYJuhSW6Qv4WR12EeS9d+mEpfFEBVXg2CswF00bGUPL6s2btH112xVWU
 xochKcLw==
X-Gm-Gg: Acq92OF6qflUDB5vKbSI821f+nrWZFxK/pafyFVkN/CHUhK3UtIOWAP0p4235ORaMbn
 L93a0xLSU/Y6d8nM3yd4tuDbcikb1nW3nFu0GJhKJISGc3yBflU98hd/s+CfkaNGHhFBErpjsVB
 WAYcZs+EhYVyw8G2le+kLBDjtOzMFnVpaD5JgBxd+MGHOcU11ROQ7XsYfFZ3SohWsfMl7UZGKNi
 uOb7GTbF/22hLP0+bANFk9DMDu1KJpyeSkBxNw2ZqrsmHaGSZ6zx+vR28fvQR5gWemPymfFMxsT
 FP6WSslmpPPQk2l67JDZgxtJZRa8HcT/C3naZIezTJ5X9v7nD7E0Q7Bpr+LxdsXvKRl7vs07Z34
 6RVP83Ft1GQJT+VTkcSCWtUx/qH6lXO9CdILrgXUmC2UBoRK/AEymT+qlyL74AjHmW7WywWO0Rj
 xizo2HZatwCRgjyCgOmb1lOHpFpSZ7cMN7qJZLT9BrYqN84r/9t8nLXXSKuCAlIlPSByBl2bTYv
 MVxV9IdBi0WJ0bBDIye2870UpBmFmQJJRlkr2vxJjlvybKACzANFb2YFhhd3UkCL3Nz54bD+Cl4
 iLRtQfKSMeV4NBSO1xMlm8FA
X-Received: by 2002:a05:600c:8519:b0:490:3cf0:8d81 with SMTP id
 5b1f17b1804b1-490c2d0e9a2mr247443745e9.13.1781006167935; 
 Tue, 09 Jun 2026 04:56:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3cbfe4sm487221815e9.7.2026.06.09.04.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 04:56:07 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 11:56:06 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 945fac1b51d7eba143abca65da6f8ccacd12c3be
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 11:56:06 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dd5ca163213054a2b315bec23a28399e2f3eb83b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWyT2-0005iM-KA
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7640701125875611350=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7640701125875611350==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fCXCEbBYTJ4="; charset=UTF-8

--fCXCEbBYTJ4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

its_Giaan=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introdu=
ce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 12:

(1 comment)

File src/openvpn/ssl=2Ec:

http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/cc54099c_5992e30e?usp=3Demai=
l :
PS11, Line 1194:             srand((unsigned)time(NULL));
> srand will =
be flagged by people for not being a secure random=2E Rather use rand_bytes=
 here=2E
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1089?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a13=
ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-Patc=
hSet: 12
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewe=
r: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 09 Jun 2026 11:56:06 =
+0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>

--fCXCEbBYTJ4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1089/comment/cc54099c_5992e30e?usp=3Demail">Patch Set #11, Line 1194:</a=
> <code style=3D"font-family:monospace,monospace">            srand((unsign=
ed)time(NULL));</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">srand will be flagged by people for n=
ot being a secure random=2E Rather use rand_bytes here=2E</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1089?usp=3Demail">change 1089</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3b=
ab3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 10=
89 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 09 Jun 2026 11:=
56:06 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D=
"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--fCXCEbBYTJ4=--


--===============7640701125875611350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7640701125875611350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7640701125875611350==--

