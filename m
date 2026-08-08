Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11F7C5AC67
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Evc0mTUo0FXpGa/mBCwJslX7sls0vKMPxyqdaA9DpU=; b=Zae06sFYVA1onDBnTA7dMOY0wO
	GQ80F5HBWPzXWw4I/mPLD/tLIje3krZ+s7rC2bUSMphqDFzJtnn5vssIeOxAwQrmzEA+FaOotHy/4
	g9oLTDI764Hw+OEzibNymkur/RfgBNg6hE8cYBp5C28RkKSX7Ru2U7gVX05//FUBNoTU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsgrt-0003pT-CB;
	Sat, 08 Aug 2026 13:13:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsgrs-0003pL-2M
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 13:13:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=l0Z54aGiGu8EGUXCpSZcDZc/1mZf5lYwEMSB1iNKwGg=; b=aZ24igg3+i7xaPkPYqnYhAtilk
 TRQ3jv8jjKdVk7k4N6gAH9UB05O0C6+biB4C4S6yro6lNSBe+tU0U0XmMuThYwDOf6vgXWRCmLs/Q
 diIu63Jfs8p3a0BmwGI9shw+JgAX7Em0ljnyC49xrExp+5cJ1TiCBPMHaYC88o7ixPWU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l0Z54aGiGu8EGUXCpSZcDZc/1mZf5lYwEMSB1iNKwGg=; b=H
 j94OhoPz9gcZbP8kNtSl9AzRzCOOVd9j1E81/cd96DnqlW+WKKRPC3MTq9bsjqOQMJ1Yb641FsH0A
 SGqDzZ+i3uL/03/f/v2cDAU0EmWemuEmsFoJVcPC11BtUf6v2FVNE7iw1HHe5ae2kYv/mLskqY+vO
 xs83pw5mk0Sup8tQ=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsgrv-00029T-MU for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 13:13:40 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so2568935e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 08 Aug 2026 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786194813; x=1786799613; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l0Z54aGiGu8EGUXCpSZcDZc/1mZf5lYwEMSB1iNKwGg=;
 b=DW/l2ONnCYGWjo39Mbi+pSfWXFMB1c5VHFZMjgZ1UnBwrFG2HofZXfHR7E+gpT6L4D
 AvVygA/NGfE27hrYCvr86alI+/awGbjcX1i/93cQvZ9JN7K4xaPrGjnGCLOhUtPnS5jb
 QbUlbpV3whuzyc3pZ6gxXU7oxO081gYWgbAooBBH3NpHKwnPIfbMjUJzP36l9DyHlilu
 g/5OA5OGHR4jFw3jM8Mp9jPLET3AXU1IQDH5HXXAQfS/eLDAjN7chZcSKwTCx1ETPsKd
 sDuLMc9/EwW498Drg04iQ6LsJGLGlAmUjTaGXsAnta9Uz3NOpVI/xT6MWHK/SoPtmM8U
 sKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786194813; x=1786799613;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=l0Z54aGiGu8EGUXCpSZcDZc/1mZf5lYwEMSB1iNKwGg=;
 b=B1E36al3iT2nYolW9urVCazejjUUISZHIAkLYbh7XQMsBqZoo/leQdi4xB2hriF9Nb
 al57OVw9x73qbcIvo2WkGtmznwZRFv+3DzBrKLzf6R0P+/KXjMyeWSgFrkRfFxyLCpgC
 rPFDBFExjf1rMG7RbDtDj36eJLInZsB3Pjgd6RXNsBIuQv/e8eQMRzWRehNuc8byBCY2
 ogXltHE+TKIlcQ/uWUJ94+4VE/lWLYS9meDGxAMgzv5JwycK0nPVmoltjFhrFGycOufU
 R1bQRJlmbe8iaKKr232+3CudEg+VknmHNLPPktcLccOPdsaxWuVKi8S+HCQ0/52Mjgaq
 9gzQ==
X-Gm-Message-State: AOJu0YzEwV2Scw1S8hQqxPwjHozeOtjV8cufJM49iAUgHFQC/2Ec6m1d
 ZgZrcCDHfS+d7VCvB60NCT79iCXwmOv5loEsdZLoxxv+OrFqYvahU+ULJNXyruVseduwf31RzCj
 SjttS4rYM0vb5NtvpyBAfwe47Lcm/a/ymkzNwo26oTRfCg1Ljx69rOaok9SEWhtazJqjdY9R3SF
 OSJ3iSsA==
X-Gm-Gg: AR+sD10fF9t7uJ5q8HgOd1ecfsXmptUXGlFueR+gWGuHpppbGhpv9Qo9gFgKrDB6sKH
 M/MaIeJ2XNWm9UUMuPqeaJhQ+VFqH7XjK4SK7PJYcjXzyJsPbhXQLu46CoD5F/vX+LKudGy4CQ6
 apR/jyS4Wi08UoKoWZ7kyYN/EeKMIfl9zQLm8VM83ggKpn9enfXEKQHMTOSXQ3DXHBlWeJihF9K
 eMLynoqsfjT1rt615Rdw8vUxrXLgFTe5JLpGprPSl9Fj/T+YxUS78srLOrJsjGL8LzOjx73A36G
 uCIEAYMwSx9kTFXohvyOrs14bxn1IziJYJGDGDSWNrWYq5m0gVJKnPW+1/1w0D3moQEGp7dc/d5
 ETC58Sz6yn7gO1MCROsSnUvOOVnX5lak0SKJFePf7hmAsC1esJNwNTsEh37sQy5MxSlcSp+NAwt
 SerWEvhJJVNIkG6tx4foHrzPPiejp5ZIIbK7GCz6z07+retKnjEL5hVz7c1cqP7baFIqUA7eDT4
 kSMl3B/5pjotjovAehTZkwKLYQc10m5q5dL/RH7iQ52UwDXOoiy4sKlZcTgQpfywhWPV9IGLZen
 jB7pG8mhBlKg8ZI2ulQc5ympojcHoCvrQkjx/8/MwUX37bgDarM=
X-Received: by 2002:a05:600c:6b4e:b0:496:bbcb:b0bb with SMTP id
 5b1f17b1804b1-4994e7e863amr312920745e9.18.1786194813477; 
 Sat, 08 Aug 2026 06:13:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9f0230sm120616985e9.6.2026.08.08.06.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:13:32 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 13:13:30 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: 5f440cfa6725af843e25a622588fc010486667a4
X-Gerrit-Comment-Date: Sat, 8 Aug 2026 13:13:30 +0000
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dc7b0b0f68fa2da9c67d6e03af335685d5b490b0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsgrv-00029T-MU
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 useless assignments
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1602137368195118985=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1602137368195118985==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CYX1GBbKCk4="; charset=UTF-8

--CYX1GBbKCk4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1617?usp=3Demail )

Change subject: Remove various useless ass=
ignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 11:

(1 comment)

Patchset:

PS11: 
This commit also removes the ini=
talisation of the buffer by =3D clear_buf(); While that might do something=
=2E I think that change should be explained in the commit message or the in=
itisation should be kept or replace by a simple =3D { 0 }; since that is wh=
at clear_buf does anyway=2E



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1617?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
Gerrit-Change-Number: =
1617
Gerrit-PatchSet: 11
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sat, 08 Aug 2026 13:1=
3:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--CYX1GBbKCk4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1617?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?tab=3Dcomments&amp;=
usp=3Demail">Patch Set #11:</a> </p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">This commit also removes the initalisa=
tion of the buffer by =3D clear_buf(); While that might do something=2E I t=
hink that change should be explained in the commit message or the initisati=
on should be kept or replace by a simple =3D { 0 }; since that is what clea=
r_buf does anyway=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">change 1617</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id0caa497=
c4ff1ad8743cb23f332f003b2d3393ed </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1617 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Sat, 08 Aug 2026 13:13:30 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: No </div>

</body></html>
--CYX1GBbKCk4=--


--===============1602137368195118985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1602137368195118985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1602137368195118985==--

