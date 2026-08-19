Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78051C5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iDDb2MhLtRKS99aC61W7/z6ozvQ1pHH3MHUMvgPE1lE=; b=Y2wieW5cXohC1Y5dDn89LdB6VX
	mKf7n4GWuLSG3NUgxikTpMN7lW+VpFwmVPnoU2mwQv0+aR74gN1ZH2t7teIvVqAlrSIMS3SmTx17J
	MpIg6C0IzrNxe16eOhRwDg0heAPXPDzsBdi/IK5WWx/dkpKrlW0FhpPIr/rBgwhwa8cM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwiP0-0000hQ-Ca;
	Wed, 19 Aug 2026 15:40:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwiOw-0000gz-RM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:40:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZRDKnifn179yiCWrU0IDdx3tPLEQaLezFyYzE3W+0Z8=; b=S6pj6JD0TV6zZ48VZxm7qFzxSW
 j5Opj2/5kADmotjwN4HyZl0ORmGoTrynR10X+fs2IlMHodBJAvx8sAT8+U166KoHxaKtmvpWLWNrc
 jlbxVC6LzaqKFOlD5N3gugOZdH8mjAwgmIxt7RVFpkieHeBTwqGHTDJvBE4UBgNgV0NM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZRDKnifn179yiCWrU0IDdx3tPLEQaLezFyYzE3W+0Z8=; b=U
 Y/C398qkKnm1/5NzRuLXDSsWhRAgs7U/CqnxBNlW3u+q/GwYWDFBIBXRvN03QAy4vi6BX6ngPoWno
 FTewXvvz/i1x8AgggYOWgcwJI9Gm1Qh/UqtYlHrzwi8ISo2vAkK4GxoP31TT50X8aANF5xDQWsLak
 A2Kxo2BlM5K//5i0=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwiOW-0007me-Kf for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:40:03 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so700545f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787153994; x=1787758794; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZRDKnifn179yiCWrU0IDdx3tPLEQaLezFyYzE3W+0Z8=;
 b=K64/nEvXjBSm/EYlo3X8+kYNQwQE9ehJPN2vWexeNJt4Ov7QdS23wRG+Dw0Sq1WASr
 3tlnRd7fYWS1tpaSZTnhtaADxumvk2OxLcGKNuKZAlaHOlSQw6dOgg5H+KM/O3DrtkCB
 0mWs+Fb1f9j6c0xhITjJN/yyzKssadNmUkJVUwP2RjOujt8XhsMVrAqMU6cK9WF4NHUH
 Q1wE+D1jxoRcYUjyV2Zt7jsX621gtoqmCLFHkkkChBk1gU/bwJQKvucNF8YpDg1LF6Mx
 mQ3XRCMeb4jkupmsKfRevb+9XqMXQv1c/1cAN23c1MhmFgEurLYR0wRvq5hostc5jV+A
 iVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787153994; x=1787758794;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZRDKnifn179yiCWrU0IDdx3tPLEQaLezFyYzE3W+0Z8=;
 b=r7gmtxYafcE+x6/yEgEPbjjNNKEl6uaW2LxSjML4Ln298hUl+60TGpf4LO+hmNf5yl
 bQw+jTOgnZ0TnpepH77UgXvRmb3Q2+r6rQoHuzbjSSrmBzkWwAgWR0soncKp+IdFHQWq
 UQjLTrJLuNcgKRZdcRaK/WR6dSxutRHhF8qzZpqa6eK4tHee5IgYd1O8qXxSIKiEmrVE
 P7Fk1pq87+yvQ658mPTQ60UrwTZBiXrpvbxs9EkGkI2TbaKqplE8Q4XKMNAwx/cRPinZ
 b6GKUToFrX7B+IXpsk/YUNDrDlSTYxk4mJqwFlhAursyQT1iIu/79B3mEcGSAgv7kwPv
 mhLg==
X-Forwarded-Encrypted: i=1;
 AHgh+RojAEeDZSM5fXOoYYpddXj6izYloPjRhN4KxdSBlQZ+c8CMW1+xStSK4kBNanKLj4qvBdUY03kV/5GDD7wQ@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy4W+j/3G9Ci9s1zDSObrij2CtpjWv1LFuj/Bm0/qWUeP7SjbSj
 /Iy6JcDhGvS3pN6tNOvITlp3RnUV2YuxbvyYnjTSUM+I7Z4HKygyq+qD1Vq3aynYs+B58Q+MdR8
 MF+CfEwafTejJCAy4Xd6C/flnsQjTOEmC3ICFOrSXC0Pi+O5yTY2IfpjrD8uwgqc99bo8
X-Gm-Gg: AR+sD131QXCcgaQgfdOzen8hFlJx1lVfBPJ9C7EHxpvki/qfRNEDWflUw27Xp/khsOL
 sUXeVyOqE370e9kPb5r7houlPXiA/adFMgsI3XzRwFcQSVhfu9aqTGEcbHvu+UvDu3/u8cfA6hh
 y6ApEjou8/DhDJ9mw4Eg+itEbOe4gY56kDQZfeMnmDLAjgd4BdddSFC4OOxV+N5edWZ7hYhr9/z
 bjzsTxH6+NJKD4GghtJk5tkP7FH4vEIGUabiVFZk1AUdAiEVQJ6DpG+ZQgEPAZyFeKrDi08kFtE
 aiz3744hgpFcehuDXV2jUrdNf8ryc5Bt18ferwx+5udUzSv1hM+0OXgcGVsjRYn+bKMRpCbbD9A
 Lag9p806NjrZcCsnPytbN4ucbjvNQbUMc2Pp3VS/q1yH02Rb+CXejfpPk84AXJGMV12Rw8F5Yrh
 RZtRkyjg9oPPQsclcgn/2n4BCumozWM/60vgHeL0SiU1XK+k2EvEcjIEefZMm8CNmL0gOB2qvr1
 qSPk2ihkFMaGHm+okY1Ii4O0tVWnW2H9iR+SR1hbNyDvM6qadXY2qX+FT1Sec7VwIoXax0ZP105
 FTKSZ/nVtolKrqqa+2KfM6N7n1bGxehQPA12s/a+yme81OPRdFA=
X-Received: by 2002:a05:600c:8b8a:b0:499:8777:ccba with SMTP id
 5b1f17b1804b1-499aa1e9fc2mr118906845e9.12.1787153994069; 
 Wed, 19 Aug 2026 08:39:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e09905sm84336035e9.4.2026.08.19.08.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:39:53 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:39:52 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
X-Gerrit-Change-Number: 1773
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1773?usp=email>
X-Gerrit-Commit: 76db269d466ea06988a46af08705dbbf7f7f3d4b
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 15:39:52 +0000
In-Reply-To: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ODI0MDU4ZmM5YzRlZmQ0OGNlZWIzMmQ0MTY0Zjk3YjJhMjQzZDg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <85b9fe2fcd71a0f3df7d175438d25b266cddf8a4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwiOW-0007me-Kf
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Factor out
 options_string code from options.c
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
Content-Type: multipart/mixed; boundary="===============8679626082343962215=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8679626082343962215==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ukkfHhWqwhA="; charset=UTF-8

--ukkfHhWqwhA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1773?usp=3Demail )

Change subject: options: Factor o=
ut options_string code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(2 comments)

File src/openvpn/=
options=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773/comment/e13eca=
d9_b30ebd18?usp=3Demail :
PS4, Line 3739:  */
> Should such Doxygen go to t=
he header instead?
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773/co=
mment/f7b1d321_92aceeed?usp=3Demail :
PS4, Line 3932:  */
> I _think_ the n=
ewline between this and the function below orphans the comment=2E
Done



-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6824058fc9c4efd48ceeb3=
2d4164f97b2a243d85
Gerrit-Change-Number: 1773
Gerrit-PatchSet: 5
Gerrit-Own=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc=
@mailbox=2Eorg>
Gerrit-Comment-Date: Wed, 19 Aug 2026 15:39:52 +0000
Gerrit=
-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razva=
nc@mailbox=2Eorg>

--ukkfHhWqwhA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">View Change</a></p><p>2 com=
ments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1773/comment/e13ecad9_b30ebd18?usp=3Demail">Patch Set #4, Line 3739:</a>=
 <code style=3D"font-family:monospace,monospace"> */</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Should such Doxygen go to the header instead?</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773/comment/f7b1=
d321_92aceeed?usp=3Demail">Patch Set #4, Line 3932:</a> <code style=3D"font=
-family:monospace,monospace"> */</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I _think_ the newlin=
e between this and the function below orphans the comment=2E</blockquote></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">change 1773</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I6824058fc9c4efd48ceeb=
32d4164f97b2a243d85 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1773 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div =
style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Wed, 19 Aug 2026 15:39:52 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--ukkfHhWqwhA=--


--===============8679626082343962215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8679626082343962215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8679626082343962215==--

