Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57148C5CFCF
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ahGor40GxCmvo70JLBXR5Af4lzvMEfkV0iRlwH1SAjQ=; b=Hibcw4ECKnVR410+8scaHQxvFe
	28fSBDozad0UnVbfzi3cjNQE3Y8EkJZttieJ6BdyKAhSCbwn5S8/5W23gYr1F2mC1rJjuBo/2QvOV
	LuY8qM8EpZbnTVXdD/9LBfezPKyQwtpDQEZKPciNZCYQ6qQyWKIEsSKTw8UExsxjls6M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuXRi-0006cl-8Q;
	Thu, 13 Aug 2026 15:34:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuXRR-0006c5-Qj
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 15:33:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8rAjX2EGPMw/InskBgR4f88qS3UmDdtQxpxAHOQkpEU=; b=Zo6HYJqkDZsOelafbV3MBR+b7P
 JeZsEZOOJeW0xskdSINemAv1hRYG6f1i6WlbQ2qrR2ZqyYvWbjf49qwSNKpPrcoyQwuDyiqBdDlK8
 Cs6w3npst3hXwu64Ty0S3NVCYQuNOmE+/7IgMi/dNqYk5+MgReEt7U2Gh6TQ5xc5zPWs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8rAjX2EGPMw/InskBgR4f88qS3UmDdtQxpxAHOQkpEU=; b=m
 5lBCFEsq3+G9JST+NytQ45UzfGsJU/Oqdld4zgpF7eNuCCGnfb/49s4ckcy/YckOMEXGqdBbELOT3
 EtWdfVYWXw4QaMAkFWetKu7L6PXdoPytY4g62JV8HUiN/UOZaks2Mi0/aqrqmNhc/rSeqezU0O055
 iWh6OVW2xd1XcvP8=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuXRP-0005Ev-SC for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 15:33:59 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4956242332dso468365e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 08:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786635230; x=1787240030; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8rAjX2EGPMw/InskBgR4f88qS3UmDdtQxpxAHOQkpEU=;
 b=Axan3rZYZifBCORmhmvYH7j+uTAzLc7A4tso3RgSaPJUo/xSPayAcBp3n86Z5hxfqC
 J7jAB7NreXx/TmN3foZkfTGYYxwyyJHu+I89eXDlmkKEDTJT/C9shjE8zm7XT/SLV47d
 95WAThub3GDVFNH5NmgX8eL9ZP684s0rL+W7onJ+XQHxAK2FH1tL0nS4TX5LDVxcHxDQ
 fM2kG+OocUk+XGxDxOTVUAMvFbOjdGHMZhcYTpCbpGLV2YuqtCyFTDkoss4cIzo0Nobh
 A0NxJ6X8vqyE0xV+nZdGTF6P3AiyrE0S6W42cgC9wG/4OKOh0fZ0jCd2ToZZt8LZFeD1
 5Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786635230; x=1787240030;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8rAjX2EGPMw/InskBgR4f88qS3UmDdtQxpxAHOQkpEU=;
 b=ZeBTPMdWihfjbfTk8wN6KcxQ6d1a9F6O4g3jhMwaOIfufgjwH9cwNfYds+27noRBmP
 zRtr6G95SJCzbZrIqwVcmjCvg8oKebZETQpx1DwwXJJbBmY+gUKoSZGIR20FDc0Z7Cqy
 mTWgUKscGJRzzzZndH1P2jds3pXqh0al861aPvMHL5eCOnh2RDNSvlzeJ7op8TT8kiEP
 hS59aYe1v5zlcPD9y3oNHOtT8oIFsKgv+ua/MwZ4PdlTGfgJfPvPcMoOrgF3aKB7oE/g
 SbHKndBb7a/MtkNPfXkBKbqGBBTGpTELU3ScFfcoqb30a8WaWhQyiuksGfZxiRp9tOKj
 nn6g==
X-Gm-Message-State: AOJu0YzBkADXAPU2N4CsCkrX1bF9OveMVNBCq0gs0Rwzq2Tp1zbpugyh
 pGvMYshYQWxmI6vviOoOEmDrjB6XFS3Mbz1Z7zALatODiHLgEjbWABw8xcCpXy4m6yOT4srPgUK
 4SkwOCJBjux7t65kkeJ+KHyqTKVzvVee2G1Kb06J9VrcdSqm/8RsTO4DpjGAXjlZMgAgiOtVNQc
 /ZDPD4Sg==
X-Gm-Gg: AR+sD12SbEVgcWQbfOx5nISER5AJseHHdniPqPDL3uYiz7IwBTGIgS9CCVNbXSKVPM+
 xQL5Syye1LYLAM/KKSxIwbUyD+bk4u0tZsJ6Jam8gF1LyVwCsCVXI6l4kARDiUJ5ikB6QlKZ+TE
 4N88ZxNIWanjVrv3lmLTMyECEpqpMYDODHRQ/pY2WEBevBwr09nzFD8TpjvXqMa1JKHsiEpfhzz
 vEhl4Lr4+BMD0X3eEVtpN9TyNHeM0L+aYQWyKxE0CLQaMMzAqoCppj36vweD4kDJJ1tlg/wYFpH
 bt4wrcTV7ZeEvQHsYKoU2shvv60+Akn6TMhVCCq7a8FB8E0U5Z6y0Rf1bm3ciCJ29+lo2704nCF
 qPx1xgjBQ1j7L931pcdYeHeZLnpBXpe2NcfRbU74yHTqsVE1jAu76nS5iQDYy7FRDkRUuZr2RLH
 FNfvIBYGMpGbUr69j+aTLh1DecbTLGdRaNdjtNhBYJBGQ1nTyJSLiKltHI9zJCln7vXt6dY4P1r
 KNfF5pntxdrpvMeFD3fnnPbbtBWCklrHFnIdEXY25jfAgWI5DRJcdfvue6FfEb4wHo+SZUTrrRR
 DU1YxhZaxtv01RSr873pY9NzbxE9SV229hqqcQJbGIhwsmf4faQ=
X-Received: by 2002:a05:600c:19c8:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-499821ca34amr75406415e9.10.1786635229369; 
 Thu, 13 Aug 2026 08:33:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f20058fsm200628f8f.4.2026.08.13.08.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:33:48 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 15:33:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f
X-Gerrit-Change-Number: 1840
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1840?usp=email>
X-Gerrit-Commit: f893e6e68b48f09a37edb9ffe0c89c519051017e
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 15:33:47 +0000
In-Reply-To: <gerrit.1786440840000.I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f@gerrit.openvpn.net>
References: <gerrit.1786440840000.I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NDQwODQwMDAwLkkxOTEzYTZlNjRiN2NlMjJiNjZkMjAzNGRmMmEyZmFjMzNmNjBlYTlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <68b331e3aa0ad6bcfd944cb04400a3588d3e30f6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuXRP-0005Ev-SC
Subject: [Openvpn-devel] [S] Change in openvpn[master]: OpenSSL: avoid
 resetting the HMAC key on every packet
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
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4215383863694107790=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4215383863694107790==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Kt5zy4TV1/I="; charset=UTF-8

--Kt5zy4TV1/I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1840?usp=3Demail )

Change subject: OpenSSL: avoid resetting the HMAC =
key on every packet
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1:

(2 comments)

Patchset:

PS1: 
There seems to be a s=
mall typo in this patch that accidentally introduces an additional line to =
review=2E


File src/openvpn/crypto_openssl=2Ec:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1840/comment/68a03825_62ae9d45?usp=3Demail :
PS1, Line 1=
212: #else /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
This looks like an=
 accidental change, only introducing a new space character=2E



-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I1913a6e64b7ce22b66d2034df2a2fac=
33f60ea9f
Gerrit-Change-Number: 1840
Gerrit-PatchSet: 1
Gerrit-Owner: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 13 Aug 2026 15:3=
3:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--Kt5zy4TV1/I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1840?usp=3Demail">View Change</a></p><p>2 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840?tab=3Dcomments&amp;us=
p=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">There seems to be a small typo in this pa=
tch that accidentally introduces an additional line to review=2E</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_ope=
nssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840/comment/68a03825_62ae9d45?usp=
=3Demail">Patch Set #1, Line 1212:</a> <code style=3D"font-family:monospace=
,monospace">#else /* if OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</code></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">This looks like an accidental change, only introducing a new space chara=
cter=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1840?usp=3Demail">change 1840</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I1913a6e64b7ce22b66d20=
34df2a2fac33f60ea9f </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1840 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Thu, 13 Aug 2026 15:33:47 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: No </div>

</body></html>
--Kt5zy4TV1/I=--


--===============4215383863694107790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4215383863694107790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4215383863694107790==--

