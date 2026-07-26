Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C523C531D0
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 02:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V75lnp9QkQpLvOP48G0zEZuDzPMAwjJdpgoGXOmrwPs=; b=Ph73LAWKJp9XhUoh+eL8R58djx
	oUlhxXVC4Y9rEk0n865JRfrpuFUSWJpFNqNGsIgdEFMiqQYyRo41B/4P3R7bbs33ASdyKyDLdIs5q
	FAAyIybwzNO7vvsRkGrDVrKZFQB8NhqJoOwWOa20KL5ypkvpK9Go2oUg59L8iz6MWA00=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnoJ1-00086U-DX;
	Sun, 26 Jul 2026 02:09:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnoIj-00086G-Iu
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 02:09:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=98WxQL5sSkaiHRaVAwRWGHhANEqMaqqyimYZSCXqPDI=; b=mKxuTv9uq7bg9VYvFdXCKQo/x4
 rVlKM04/ce/b/aQZJNc42+TYBNDM0u7N0t+s2fZPpsOQjvnBEUw2yrAhn6GQVv9Z07Rha8OJwCeJC
 SNbRoFyXfJsXaCxKUpJlI1iU/KvN/7pBVE+NtOdEoU4gvCx0ltnP7OCnUB8Kn5B/tRWo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=98WxQL5sSkaiHRaVAwRWGHhANEqMaqqyimYZSCXqPDI=; b=P
 YbdzHRJEcI9VtnztPPnVp8V89XXYpBrwl/p0BZwkquYA72FtZrro9lq5ORMvsIKq51vLpWEWX+PQO
 N8iF7GezmDXdAHNuZxaSWG/AbS/W7WIv5W0qR2xs8v5Dfl1TEYhHVRQ7TRG9qhyyR9qzmRzzfAJZy
 RCfiFrYn3GQm4YKQ=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnoIk-0000Eu-1L for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 02:09:11 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4956242332dso14291495e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 19:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785031744; x=1785636544; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=98WxQL5sSkaiHRaVAwRWGHhANEqMaqqyimYZSCXqPDI=;
 b=b8N6qw+Ym6YkhCYFbEXkVll0vlQ1BXWr6NLT2Tk25fzY4Tah1GvRq3KhGwdjPu6RdA
 VopVpcZoRxJV9/aIJs9vABRjO/Uut5/8+cmPcyG4KBWSCAURHam2i8sGCb8o27UIA0pS
 BXL3IZ9hJWvMnWTvw0E4JAJjponcWYY7+DGFgdZIxJJkqKHEVPhyYaHT1fLy7b5otn7k
 +JJUR3uRvZ7lYSpvPcgX7NS0e70Pe7Y1NUahdetca9IHMz2HfJ4mnvfirzoNyrIVqg/h
 NTyQYHTVYuQBTpLOcXM3bGbIwe9UO+nYLjWoupPlpMrPpKf2YPpiCSNzhvmuDjBCBriP
 sLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785031744; x=1785636544;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=98WxQL5sSkaiHRaVAwRWGHhANEqMaqqyimYZSCXqPDI=;
 b=V2BQMwMxZ9ulHpvT/PjPnNP16xAKblwpIUioJSamDcKNpkZ/iL62QLQL0zpbN5Hvgb
 GYIX2wvTAxzXYSn9cHTFYic0xoy9yeTGPNJVQz/r40dfEQT1VAPx1F6OT0BytPBNWFxS
 r2lC6KZrMBvs+y5e7dgn0HURMQAEDf3iZBJp9BkEkYK0nWcOmuxTja3SmTq0jrG5loIj
 q3L0QDtvWzGID1TPZ3s9u7DVu29kM+fOsTcuIKbaayywm/uVCTIE+k5vf9bksZ+kGR2T
 AXv6EooVIoyubqje4xzCc9yj3PwX4DIIrxs2Y3o7qMSJlGSQq5lZzXvWDiwzJeXrXRcH
 H6UA==
X-Gm-Message-State: AOJu0YxU5aqW5NX7Iq9XqSxMcl1ONuYyy/53cQlaU03Z6WBKJfuIzVbH
 5EI6Vc+TS2HzW5px+kKdFKvlfXzh9++Iuv8HfZWIkxla9MMmD2DX3k/iYxWLn28eOtjoAMX5DIX
 /dPdbo+PMJAS6YTnZtZYt/p7vyfkjUD2nyMxoTAjUZb6M9RkzawhDseil23Iq9y/7PPq1yfZaWx
 +MnzXW8A==
X-Gm-Gg: AR+sD10i3j95zmmbQPLde77I6vQjy1SL9/wwxRPVSMOPT8bJFOIQ/fF+Ds+hV8bdGCR
 J89Hk4es68/2TXWsdVBqnY1RuKvtr7qEFc+O2RXtxpbfX6a91vY8YFt+jZ3f6ul63BYAyKlYC5L
 hEMUO4jXS5bsKjRJ0A4kxpJJ6ba7KzSFtzf0r1kEyXyQXbM4gID2Rst1jxVse89Ugm6NnISWWGF
 g/odfdBWEvE4E9z4reZc4zwKWjYcAZVYAUhDMMCMpHUVLg8HZUPu77W6W6BW1d5yoGL/zKSDAaB
 fJKHOCdRNjAlz3KYn9Y6zlgzpkMB9dDfMAFeYvklCeG79WaclbCt2hlagLGsU3tCth7f5DVJAAx
 jUIm4PKTkyFHKvjE2T9E4uAo9oI2c3cN7EWtfE7efcB99RT+X9kR+VcYYNuSTmywmmvkVfRTtgh
 /PvFhyXO6Y4fwesxaBwxSq4DimjjXjdKdzTohPuyROw8HJ22KP++gM8aS9IxgV/LZCq716o3/yQ
 HenA+/t7Yhxr3WnDJ0GRXEBZVmsc/lX8DbgR4FTYvKDafzrSfx1bVF1Pykw0iVV22ej
X-Received: by 2002:a05:600c:3551:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-496b56bf01emr46869725e9.10.1785031743905; 
 Sat, 25 Jul 2026 19:09:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b499cc49sm120967005e9.9.2026.07.25.19.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 19:09:03 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 02:09:02 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
X-Gerrit-Change-Number: 1771
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1771?usp=email>
X-Gerrit-Commit: 060ee6a4015f002fe2c9e7029a22834c596bd667
X-Gerrit-Comment-Date: Sun, 26 Jul 2026 02:09:02 +0000
In-Reply-To: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
References: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkljZWM0Njk2ZmYyNjNhYjM5ZWJhYjA2ZThkNDc4Mzk1YTVkZGZhYWI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fc7803cbbdb1c7f375fdc6b3971dd5a438f70da4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnoIk-0000Eu-1L
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: fall back
 quickly when a handshake shortcut is ignored
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
 lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8711381603330575874=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8711381603330575874==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S8U9HRZZJkA="; charset=UTF-8

--S8U9HRZZJkA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
771?usp=3Demail )

Change subject: oob: fall back quickly when a handshake =
shortcut is ignored
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 8: Code-Review-2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1771?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
Gerrit-Change-Num=
ber: 1771
Gerrit-PatchSet: 8
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: stipa <lsti=
pakov@gmail=2Ecom>
Gerrit-Comment-Date: Sun, 26 Jul 2026 02:09:02 +0000
Ger=
rit-HasComments: No
Gerrit-Has-Labels: Yes

--S8U9HRZZJkA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>Patch set 8:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1771?usp=3Demail">View Change</a></p><ul style=3D"list=
-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail">change 1771</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Icec4696ff263ab39ebab0=
6e8d478395a5ddfaab9 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1771 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div =
style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 26 Jul 2026 02:=
09:02 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--S8U9HRZZJkA=--


--===============8711381603330575874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8711381603330575874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8711381603330575874==--

