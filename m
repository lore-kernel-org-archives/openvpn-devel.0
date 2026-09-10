Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2BDC79FBB
	for <openvpn-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=on9N/Y00YVCtIRz/ZN8orGoPNdfJr7gAobv9teq0WCM=; b=iAAx3Ng6yoRLa4WYeCGnvrbK2Z
	jE06nZLHAIRW0ixaA/BJLekRUGEhFDMa68cAR0mzONhNc71TBaLghaywsP7NJJZzxpdU8jqhTbkuS
	NcjULEbpRw70WCZgPbuX9UZ6heC07G0LzUhlFXJrZnAXctE7C651NmABa/3kfW6Sk1BE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4nrd-0003dq-Kn;
	Thu, 10 Sep 2026 23:07:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4nrE-0003dK-68
 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 23:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hQJwZawkw4NOSC1aro/vvLN5vfUf8KZBYfIJgULM6co=; b=HYvxmQJ7hjWlokj4WUQSu9D3ay
 fIMUXW0N4G+5icEmNpC1beLDXUw3t30J1Gv5Jehmidjs0JVzgroQQYt32HbqFIKPmr6fSKX8ff89t
 tlIVWfBMPB33th5E27JLSXcggQFZN/hfitjOla0RUH8YXTMVAO7OQNh2deLxvHQbMzlY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hQJwZawkw4NOSC1aro/vvLN5vfUf8KZBYfIJgULM6co=; b=C
 GwUhiB+mPCOq0Erv8ZSSImeWbWXU944oPVNjonsXXWNancigBwYFzrQDWo2a/X0VXQ/Rt2sNZMBKx
 2iu9oCByvLyOzn3sW7mFuy0XtIfUVL2aNpLrW0TjTD7Hjd4XXG/Jnup/sfhAzP9amYOHHhJgp1pjV
 xv/aYcO7XdWPTIgM=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4nr4-0008S3-C3 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 23:06:57 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c2790ccso150128f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789081608; x=1789686408; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hQJwZawkw4NOSC1aro/vvLN5vfUf8KZBYfIJgULM6co=;
 b=ad6N9EGcMbbUAIFJC6qyjA/paJSspjsp/puyFl0nCg6i09jBOH6zF0ceNnAlVA/bPc
 nvkd8sMSg7RC/XHz6ONK1JaVWjp+tKI7jjbi/0t8C+hFqyGVyo7zxtAnM21Npp73sq8M
 smi2jksOGR5EdPuUdCBL5PY64OsyBsoJ+ZYBCZwjLAynYrSwLYp5D6/f6du7bp9t5Bq2
 +yh1czWQnF+BNe4bNQkVKFOuvMw84GTzAvFwDp692K5tOQp6dB6m+77xxJW04fbVLXZW
 R3+bUGHfwhOGPRbqKmFZ1li+KfKk5Lz6xlbGHTaJfXF4dRFpoR/Q1iCLFS/saq5TuRLB
 xY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789081608; x=1789686408;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hQJwZawkw4NOSC1aro/vvLN5vfUf8KZBYfIJgULM6co=;
 b=QTfROG4ux7g9dSOmR39P0L1C0n3pNMA+a9OxxELBPHN1liFhE3dqD3X6FH4Y48mwrl
 jCg6K8QfSwyRqawu0NoYF0U/A7abw00E4ORY3YcodW43hTmm6NxQLbzMXPcmoGxnTfSq
 uMf7UO2bY9ita+la+mKjltx3BM6LWHclCGQyslY+DSiZsvjXxiy4fzourM2BgGpHNccJ
 b8DbcikgIxON8v/ctZbIicy8Xv9NYWJf4Y7xVBSkLxbD8c4lvO4EtFlGmdo/ER5KBk74
 QzkJwN24XEzDlmsY7b8eq1uGc7JZugYIZnj6ggUQiRbBvTXGjTOTcjafrzm/c/VUjrwe
 +Jsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrAZtZ2BDmqI48vsc9RyudrFFKbGcwhsA/W+9HHc2V3flArJPg/3Rk2qdv3Z0knoYjhw8riAHPBTsk9LUp@lists.sourceforge.net
X-Gm-Message-State: AFuF++nU7Ka646DdKOvUEJXrG73KR7n0j/aNAcR+L7LG4LxTtoUn/1eL
 JoAF1Yk+pUJCEZ8rLJXwZVhQlHphAyOfvVjZJf592FIDG7V6YDCA+w7sFz8igcxc5CUnc8U9ch1
 irSeuzco33Nug37j2ElIXwOYH4ajDTr7qup1OwK22zLuxs1DXma/ia4ufVsqEQngpqDOy
X-Gm-Gg: AYBFou1Sir1uiP9KjLqbSPjg90OmFm1iWGzKg5YOKGaWTjv/6PewnXON/+sZcVRMfHc
 q6jQhDIElh610dsCMERwVAUefzE/L+dsJMW1G4yRtFCiULdqts9/u5NsggJ5PhOw78HMD2LSQSV
 sEvr/XCQIUkX7l1+aXaSigAMtv0SYPOBR4z8ui8r9mlhRgmgMM1LWW5t9rpyQ930QujX235wt8u
 09//EYHMfhKJ0HGf1B5dBr/MIpk1yHHqRW3B4AWJ/gxn3bwF3awHWIPxejfeLxbxsaGMpu0O9fq
 eMdZyw80sx2l0YWSjrk1YXUiwN7KeXf3AT/oKuQiL5Wh+7rEicMG9LqybiH0GX9XvwrFG/QuGip
 wZHLPmFukZTPJrEHoordAqGAEJ4g+bYaBBZ/dauiqD8aV5x+NMTGXwpSGKC9gBe9w5H9SojcVbB
 /t+3bh9vk1BAZRAC0IDyEAJMbpVfxUhmFqPG5N1/qh6LW7PbDhM9x7/i7V32LNTtnC9RgjDRd1E
 ToVKnw0/gG0+Pf50F3QzSGQ3Cn1y3cxjKcIyUUbvfFSN98Rvy0zsGhe8FSkNi6M1rpRYseya8bj
 u3yh5oeqMP1vDp35ez026o/+jqIUTJL2cs/mkWTYi2FwoePr/RAwr4pcPDFtUQ==
X-Received: by 2002:a05:6000:2005:b0:486:e41c:101b with SMTP id
 ffacd0b85a97d-486eb1d35bfmr2372291f8f.6.1789081607766; 
 Thu, 10 Sep 2026 16:06:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fd3bsm1628532f8f.19.2026.09.10.16.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:06:47 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 10 Sep 2026 23:06:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
X-Gerrit-Change-Number: 1902
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1902?usp=email>
X-Gerrit-Commit: efb1f77d28be164260bf4235949ee81f9aff5124
X-Gerrit-Comment-Date: Thu, 10 Sep 2026 23:06:45 +0000
In-Reply-To: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
References: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzgxMzUwMDAwLkllYTE0ODFlOTRiYTFhYmUxOGMzOWQ4MWNkNzk3MTg3Yzg4NDI3NTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d8d585486911b1768bc9804b83cb61a72ff97938-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4nr4-0008S3-C3
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.7]: Check for
 null-bytes in certificate subjects
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3820379614057915559=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3820379614057915559==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ImfgQuAR8j8="; charset=UTF-8

--ImfgQuAR8j8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, syzzer=2E

MaxF has posted=
 comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1902?usp=3Demail )

Change subject: Check for null-bytes in certificat=
e subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1:

(1 comment)

File src/openvpn/ssl_verify_openssl=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902/comment/3fffd9fc_ccfa4019?usp=3Dem=
ail :
PS1, Line 389:                            | ASN1_STRFLGS_ESC_CTRL);
>=
 (Where that last remark about using RFC2253 is about master, not release/2=
=2E [=E2=80=A6]
Alternatively, we could check for "\\0" substrings=2E Seems=
 cleaner to me than parsing the subject twice=2E

Since you misunderstood t=
he change in master, would you like me to make the same change there?



--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: Iea1481e94ba1abe1=
8c39d81cd797187c88427571
Gerrit-Change-Number: 1902
Gerrit-PatchSet: 1
Gerr=
it-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: syzzer <steffan@karger=2Eme>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attentio=
n: syzzer <steffan@karger=2Eme>
Gerrit-Attention: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Comment-Date: Thu, 10 Sep 2026 23:06:45 +0000
Gerrit-H=
asComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: syzzer <steffan@=
karger=2Eme>
Comment-In-Reply-To: MaxF <max@max-fillinger=2Enet>

--ImfgQuAR8j8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, syzzer=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/ssl_verify_openssl=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1902/comment/3fffd9fc_ccfa4019?usp=3Demail">Patch Set #1, Line =
389:</a> <code style=3D"font-family:monospace,monospace">                  =
         | ASN1_STRFLGS_ESC_CTRL);</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">(Where that last r=
emark about using RFC2253 is about master, not release/2=2E [=E2=80=A6]</bl=
ockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Alternatively, we could check for &quot;\\0&quot; substrings=
=2E Seems cleaner to me than parsing the subject twice=2E</p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Since you mis=
understood the change in master, would you like me to make the same change =
there?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1902?usp=3Demail">change 1902</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/=
2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iea1481e94ba1ab=
e18c39d81cd797187c88427571 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1902 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@=
karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Thu, 10 Sep 2026 23:06:45 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-=
To: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> =
Comment-In-Reply-To: MaxF &lt;max@max-fillinger=2Enet&gt; </div>

</body></=
html>
--ImfgQuAR8j8=--


--===============3820379614057915559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3820379614057915559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3820379614057915559==--

