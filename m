Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B4BC88E72
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T3P0Mzy6i1hEv4hG5h2S9EKzRxMUmHL91mhi3VFFHxA=; b=OOq53ENqRCFwm3Jgg57YRdocB0
	ymdiL6O0ehuz5Yh20WeuN1346DPzZRWF/guqjSntvVgK63z1qpX2CRPMLP/j1Vt5MhpTsoPwnjHCT
	cdxOxIQ2m+3p3hVC9m9VUSS1Pq06MR0QSIUZYu/FYXNmVM6d1Vkb0qANRTkD15tOUSbc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x770b-0007sH-VO;
	Thu, 17 Sep 2026 07:58:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x770a-0007s4-Lh
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:58:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OVY3IzR75exom5EUuoE1OdM5f5Mrv6YjPqOcIj9SG1Q=; b=gI5aInewzNVH620oB6eRI7jLNc
 PqLBSGOqKdU4Vxrq7n8A0wyFDbdaGOeMqwXUkGIivDEdFcx+wT/8jhAjvVG7QXE1Aa/NQ9EAzOOc8
 iQPTV/NKoizgEddAZonNKDU1UrgHA4Ftv5q74J1Qxtx3vz6vQwzYe0sHDq95NbC9niYo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OVY3IzR75exom5EUuoE1OdM5f5Mrv6YjPqOcIj9SG1Q=; b=D
 cRsiZiizzsjwr8CsXc6o8zbTIFIOEzpsZHBqXCUoK/mYXsBgeGnLtvduTNKHbSrVKq1hV0MyVSxbC
 OZTID18w5CrzANq8GaYzw3rwGU6vYT47i3izSYKhX/FvgN+FOt/GUjpoRCf6kGaidr2tnV8FsDJ/V
 teF/7MbUHeS6Sa7Q=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x770Z-0007zs-Qg for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:58:17 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so3713235e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789631889; x=1790236689; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OVY3IzR75exom5EUuoE1OdM5f5Mrv6YjPqOcIj9SG1Q=;
 b=J8axTKE+KeCtVnW819FiYVkdqOku6ydsSGyAayblNh2YEolu64YFACmxe2fnEmifSN
 vevrEasIAd/BGQYYJGQT1dfgKQaFoswY6KGmfXzjpOEyYLA5Jfzmk4n0Tb3/C8ux/jhW
 gJyGh8gUkGyTXw25+857RBlaksT9dLR4Qk046uqFprnTFgxzcRJncjJ5nHp+7uGRz3v0
 dgjKkagXMA7BhI5SrWYyWyx9Xh28Dq5yRJxKf4nEOFXmCk+3e/78sD/Hwlc+//qvdGeZ
 dnEwDN8TdM77/KkQtmCMX4yb8zJNJFqbu4lTQO5xKGaqD/3GOajA5JNNpvXOrIq0JlKs
 /z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631889; x=1790236689;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OVY3IzR75exom5EUuoE1OdM5f5Mrv6YjPqOcIj9SG1Q=;
 b=ldpKcxlghF2ZoAV3mpncuAjHsLcvDI9X3Ha4SIQ+az22z9oBnrlRzgNFqPjPuLHdbD
 pbxUqmuRd79PDPvNXGRL/xLb6Sg9Gq/s1NSHYXBk5dvX3Gb2Qk2FCSjFjPNz32Ib7gft
 2d9T3moxC9owPU14Qgqe8O13k6eWLG3OqrgivHkkJO+w/T8lLeGOhBzZ9KpmRH11FYZb
 RTlxA3Pj819PoOOqRqvoW57T+/vLx3f+vcDVSE1F5vaYg5fXXCrkI/mpDoztpoQRhoLp
 xj+3T1nzrmAxdlsC/H+Rn9q0WOfRHpyn0PQpARJ1iMUlbWd7zKtgNG40DP2p8LfOeRk9
 8yxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByXcaJcP3J76vELA2LShZgVxInbmlxzxE7W6cVhxOCFVEvjZ6iGoWVIVskQQ/Qh1bq0nhLw7+aHfVSvi7lk@lists.sourceforge.net
X-Gm-Message-State: AFuF++l4K8symwxhhWEgGtmvhsljiQpviqEbmrl4TSnB1CLiV9GI6OkB
 TI42tyZIxvcLIZrP+RFmF8/7K1zpbjx+7tspVZeLLfE4sp0Fdu9wRsRTN4kzBvD4Eq2O5A3tnbZ
 IHNSxPJERpCJkUX2c17+dHU3ZkfYDD8YqlRh7GeiwA2aiQO5iGyeXqoel0mZLgfHzqS7E
X-Gm-Gg: AYBFou0iJ8Zlo41QxahMScJAiHXP3g0Z9bjYqywzfotiFN+iA9VpDHiRoYS5fVGXg71
 HCqieCFvlhgpC0oYhmfvNaMtdcbSniuwp2mGhqfyv9bb9MRJ9ANg14yo+42Uuow6rD74P2sR5uk
 pPrLnE//CC8bOORJ8Iya387eNXAjNDUpc1Vt0sG/h9P0kgxPzBP2xVD4gSnjM+8qxj1kgGcSkGM
 +qYMy9+WgiYydIh8axF8LoVoZm7/iwFyXmNjUQsdICesK3MjpvmtN7NNXmVd4tvJqOon11XST/S
 Zs4k0E0bxSDXhoolBtkFJTrv9iPXhho3XGG+Yt/9ChxMdETDWbKM4BpGVGWJKmztWkV59Tgeuhl
 ujATyKENDwgAnWcGkw5uJJCf6c+gKHLpOc7j1f4seecxikQIGFMSMZ7KlzcTfY6Z7/E9xT7/Xpf
 GBr6r1LlweKz87CHWSf1yikNhQGB4+cmkjbi688F96uX+t/SPwjh3mu8J2fG5hGbmmY17do+gt+
 3p/ld/wn+XJ1BJXgBjeR2LZDNkmfYzqbNcN/aMR/SBwejUXL69VnqVKArKvWAUywlC04ailRi2d
 WCx4V6SX/4zpbCPEey30J12+vAGrPQ7mSsRgn+f2JN/vrbc36Fmb1ZptvlIdzQ==
X-Received: by 2002:a05:600c:3b87:b0:49e:6c9b:4e94 with SMTP id
 5b1f17b1804b1-49eb73308bemr83159745e9.28.1789631889114; 
 Thu, 17 Sep 2026 00:58:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd247809sm93370995e9.11.2026.09.17.00.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:58:08 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:58:06 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: 16e2b183c7a230baef16215f37843c2e4cc37788
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 07:58:06 +0000
In-Reply-To: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9d47be9cba987528a5d69f4a6d1cf86cc9614b29-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x770Z-0007zs-Qg
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 probe-result ranking for server selection
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8375936046613831668=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8375936046613831668==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NjWEi82lvH0="; charset=UTF-8

--NjWEi82lvH0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

stipa has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1746?usp=3Demail )

Change subject: oob: Add probe-result ranking=
 for server selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 18:

(1 comment)

File src/openvpn/oob=2Ec:

http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1746/comment/40eab88f_95490599?usp=3Demai=
l :
PS14, Line 253: announcing 0 asks not to be
              :          * =
compared on weight
> Is this true tho? A fastest server advertising zero re=
mains a candidate, and a slower server can joi [=E2=80=A6]
You are right=2E=
 Advertising 0 only means "I am a candidate only if I am the fastest"=2E It=
 does not exempt that server from the weight draw: a slower server that get=
s in through its own margin is weighed against it=2E Comment fixed; the two=
 zero-margin tests already check exactly this=2E



-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
Ger=
rit-Change-Number: 1746
Gerrit-PatchSet: 18
Gerrit-Owner: stipa <lstipakov@=
gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit=
-Comment-Date: Thu, 17 Sep 2026 07:58:06 +0000
Gerrit-HasComments: Yes
Gerr=
it-Has-Labels: No
Comment-In-Reply-To: ralf_lici <ralf@mandelbit=2Ecom>

--NjWEi82lvH0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/oob=2Ec:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1746/comment/40eab88f_95490599?usp=3Demail">Patch Set #14, Line 253:</a> </=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;"><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">announcing 0 asks not to be<br>         * compa=
red on weight<br></pre></blockquote></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Is this true tho? A fas=
test server advertising zero remains a candidate, and a slower server can j=
oi [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">You are right=2E Advertising 0 only means &=
quot;I am a candidate only if I am the fastest&quot;=2E It does not exempt =
that server from the weight draw: a slower server that gets in through its =
own margin is weighed against it=2E Comment fixed; the two zero-margin test=
s already check exactly this=2E</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">change=
 1746</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I55da68cc341bcfc707fd34ca2f84ff9b6a55501f </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1746 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 18 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Sep 2026 07:58:06 +000=
0 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div s=
tyle=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:n=
one"> Comment-In-Reply-To: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

<=
/body></html>
--NjWEi82lvH0=--


--===============8375936046613831668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8375936046613831668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8375936046613831668==--

