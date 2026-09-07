Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0370FC79F99
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 17:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2kY7Uuzhy32JgqWSI1lv9ENQ3QPrn9X0E8MUSjQ7u88=; b=g0HOex8USEvTXkIHRviE7465S+
	s0L5n1UmT3u2b4211Mltos0ydbv8Ml+CY89pKtqXVPJFIR6uAi+NKSNZaALQBFjPMvICkkqCtXXxz
	VkrCCy2NV3rVPZDeJbs5NQ0YIl2k0emzSQCxbZWOUm2L2Pqg54EC3VocK+cNLN62Qmdc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3cqr-0001Ey-VB;
	Mon, 07 Sep 2026 17:09:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3cqq-0001Eq-9A
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 17:09:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EGSkY3htnFD88lAWOvy/rm1lOJ4Sz+e5Qic9KITXdLA=; b=T75Q0yWK5GIJjM7742HSyLjjBX
 GPs7sPCNvMNav9tMmAVKPHnRsKKbG+v32rVSX7VSeplEzFzuGBU+X8/8vpuzZZiB9zE6Sg0wEpw0i
 PHMSiJodNUBvE2x2GOTlUK5ORQ+ml+fo8rcao50IQ6gk1DO6OwHAaFfLZ5lCVtNgCdkI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EGSkY3htnFD88lAWOvy/rm1lOJ4Sz+e5Qic9KITXdLA=; b=a
 4gjP59qihM41Ja+hkMkzLj+G/OgjPIBz4abquIVhKBg5DTA9OUkZushbZtDW9LadtqH8oOMGX20AL
 a4Dm1c9SpPG9E/2T59q0tRprwgG2v5pHrp5s/rmJnAofRbVV8t5XoBtGJ/XXHK1TzxLLiqAS8fY5w
 ++JTl6vx/hECFFY0=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3cqq-0003BN-88 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 17:09:48 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so45055795e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788800979; x=1789405779; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EGSkY3htnFD88lAWOvy/rm1lOJ4Sz+e5Qic9KITXdLA=;
 b=UyIJLsnWydkxekdLCW1n4V7saFsuM/Pg0dcCCsW6CkaNovTduLy+zr5T5QEVVHgTSR
 RjpEzhm/XpYbN5hgJmoSQYA5FNx2aYa0oqGECjlzsE3KpGH3Kx1FyHj9H/BFW+uGvMSn
 oAD0wF4INhsWKC42QMmlcKbQORUkzG8+KPy3E8D6OiASoYF6C2MWPjiY1GrErtHRbEfC
 zzeank10vMvOiXWP75hLIAqy4hDGbTfljbb3tdDeUqTLiO3LpfbkjLsJcBvRRQedhjG9
 BUkJ5ed2SZaTmNhR3svDMuEJzQIjJRfelPXle+lmwiAn6TBrUVQsTdRwV2jzsu7rLZf0
 sofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800979; x=1789405779;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EGSkY3htnFD88lAWOvy/rm1lOJ4Sz+e5Qic9KITXdLA=;
 b=H8+IHYLHDRwifYG06xifHddqpB8WWAl8NFqAokaNQY5igBYIn3wQnu1cdvU1X35lN1
 ROBC2JxejxY1P79rwKmkaT7/rwnPThxDmQJZpUKq2Px3R7msGM3XUVKb0klVp3nRmkPp
 WW/B55oSwHJKGg9seQLuddjBaqrYWTCpX9bkK7jj8+dCnJn1hP51Ut7C+h7chGIwqbsl
 7qD784Lz3Ld4lFFMjqG8h0LcN24Q8YbPwJ08gQ9/xsZBGRUt7YfZbEo6rL1pn70gBOHA
 LBqep1sqqQp3w0Jwfvs56cewMZAPKM+h4k8U5fhBrvGY9a4ImQfiVmhM51nWmmbnDFVA
 skkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5KNl8NSerM/8nEL5UqCH8ZjYC9r07faS4xfLSb++xR7ZOjcpWhFPc6orI4KRRTmTdTBVCeaNrlQim5KJ1@lists.sourceforge.net
X-Gm-Message-State: AFuF++lESprmFPQ90DjDjzoEJEKedS6YahM8cM5sNfGEiU3SVqcvOUCy
 eiqPjawkpOdtYoQNmhyTwlHDDwgb9/p2pttN+c/YjmA6jS/bJwZs9sd3l+GpGEm6Vtxud3lQh9F
 Q2bPmS3BsIKuIhKTpLAM2JkFl0t8N23Q8ShYg0oFWYfHHVZDtgVjLv698YZG9au5q0yfU
X-Gm-Gg: AYBFou2+/lsnChXky5en6P28iLz+EqnQs+QlJk6pUPK9XDPFlrnU5HnlLzzBRl6Oqpe
 bZQlhxLq8Pv4CzNJxuYVouRpzfbyMk0PLJ1C26RtrCpCzdfC2BLAxSmMKAimy6QIL58Ji6KQTJh
 NqL93NtaLy8cwFpBIdJvNaoMtEDFUrqQHTciyvsohALT6b7EkDV1mS4LB7DbUAG6OLP2lVGMf23
 2i3SzTpXu1Pub5vi6Di8qTZASOJmhCb/Okft555weJkP/IzoYXRCWwQOvK46goXGrrui2d3xI8A
 O929C0v5XhDE9TjMPnCSrlTVMY2h9GpDNkYiEOclTCEq/xcEY8tYaC6/8eipcZJU/38OTgdO9Ho
 +1JCdkCqJ//ZPv/U2av5p9lCI+nXUolpOo7WWHuVhvurvOJIhYAwTdifd8AHDMuOFsUTSMr4uQu
 I4VKgR+E9+RYYku2m1Ct64Ap0TI0GcPaq9/rdpX7rD2tjnu8jKR+5sU3p8SlNXr7ykprEFGWS7a
 BlsO6dnAM366zG6jlj7LBUWsX0eKo87lgjrXQ/uBhCoAA1AHimx/7s+7ob5q+gga+x5d3as/TFK
 snZvqf2mpniU9tniSVE0pVHtLE54t06o68Y4hBppBE5tWTJBUzM=
X-Received: by 2002:a05:600c:35c3:b0:49c:fc6c:be10 with SMTP id
 5b1f17b1804b1-49cfc6cc055mr208232105e9.22.1788800979468; 
 Mon, 07 Sep 2026 10:09:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce554d52esm291961485e9.3.2026.09.07.10.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:09:39 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 17:09:38 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90
X-Gerrit-Change-Number: 1868
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1868?usp=email>
X-Gerrit-Commit: 6c839553075328e0103ee33d0fb6c26f1e50a2e2
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 17:09:38 +0000
In-Reply-To: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
References: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLkk2NWJlYjM3YTJkODIyMzMzYWE4ODhkZTFiYWYxMWRmY2I4NDkwZTkwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <94904c6188cd481cd41faedb27ed28220a2aedf3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3cqq-0003BN-88
Subject: [Openvpn-devel] [S] Change in openvpn[master]: run-cppcheck.sh:
 Make it more configurable
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0723575142189964795=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0723575142189964795==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+t88NnVO86Q="; charset=UTF-8

--+t88NnVO86Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1868?usp=3Demail )

Change subject: run-cppcheck=2Esh=
: Make it more configurable
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90
Gerrit=
-Change-Number: 1868
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Mon, 07 Sep 2026 17:09:38 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--+t88NnVO86Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 3:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail">change 1868=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I65be=
b37a2d822333aa888de1baf11dfcb8490e90 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1868 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 07 Sep 2026 17:=
09:38 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--+t88NnVO86Q=--


--===============0723575142189964795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0723575142189964795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0723575142189964795==--

