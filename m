Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D1EC982DE
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PCSxjWTrpg4vCHJLHntCweCYg2xdoxUuKAY9l9EKnVE=; b=GM8EV7XEZxnGuxGmELntKQDg6p
	NZUuXxVBNdJ4Y59FE67LAOa7VSFzV9VONTspBOYzF/gZRY9dtoxlrd5+oApUcyRZb4icDBQarCjyW
	1cjDlzPgpOkmes7juVG1Q3dYj/RelB2Lfem7IU95tyeDJREJ/MrDUmoX6ngsdANJlZiw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8bCz-0000ta-Tb;
	Mon, 21 Sep 2026 10:25:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8bCy-0000tO-JZ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 10:25:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=7RALROtI8jXXLgvs4R9J1IMdwg9QaDrq9pa6/MRRA6w=; b=UxrkzNzlxbEDKI8X3v2UeqYlHW
 WWrKZBLi0B3L0239R8wXDANhsjsRvFldUoHVW3TsXe2M9akkm6gjlnWLkM+8v8DwESjAEGmxK3is/
 hnxeCdWkwszXNySTeyTjB1/cIIHSF2Kl9oxma85W0a6yyt9CxBWbn+AIohaMb4nFx8/M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7RALROtI8jXXLgvs4R9J1IMdwg9QaDrq9pa6/MRRA6w=; b=n
 C5CYUH/Bc9vL5Kow05pgQUB1ekSFbVA85e9HvrH3ktpFQPxrMb3qeVYzEDGc1f3hu7PD7dVcY58oJ
 dTxorPWUmNtzud/PdCpfvKvp/DiPpEhhK/fMmI1Gwb73sFeHAhhF32uPpAesERNTA0XdC7qng6SL0
 WzKUHsHrw4LPNNdY=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8bCy-0007Sc-L3 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 10:25:13 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-482f635552aso2306292f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 03:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789986306; x=1790591106; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7RALROtI8jXXLgvs4R9J1IMdwg9QaDrq9pa6/MRRA6w=;
 b=AzuriJqixeV9Px838CKhhbyFYaMjCO63JSVgkruG2PZWxK9tFHz+4HUKKMKECkDVqb
 Vem5fDma+MFV+yPo+ZwvquWPvKJcHi75Hvhi6LBAtznbPuM44csTisJtYFYYqH19OGf9
 JKxAv9FGWSRV7gcgZZKI+QCp4Z1Yl6VPkSUTRqsQGguEFHF5B1IczKKvxWirTKhGqx9y
 LGAVjRGffy/ig77zT7dD47BjWRNprgpG0iZoTUhaAOp7A6U5+UhgGero2okPv020C1KW
 XSoYWWFKkKg6ecxcrHO8rNF9Qq7ybLSv7jr7irbthoIsMd5fb2Xy95XO7GcM63QuLQ61
 MEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986306; x=1790591106;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7RALROtI8jXXLgvs4R9J1IMdwg9QaDrq9pa6/MRRA6w=;
 b=QJ6RScDuk0sRqDSFgOUZmxdOOFfwEvRmf97pc9KHWFNWjhmVslleQ6eSzUTtIsYwAS
 hzTmuOlE2UOHHSIezob8KIwy4nJLG3NSKz3wA9hi3UOE+kVNkIGpH9J4oOXzTf9/mNoY
 w+bmlIiL9zeX8Vm+aCkwCbXWyXCWOB1HtoHYTZjGES7vlcbS7pDnKF6iJT05q6zcKqmj
 FWgvgv/+sWtLzlrlkZ8y7d5suc77q2V7XZ1Vg6qGMcjH3UdnZyJd6Xu0djxduNNpqVXA
 WfH5Hw2/XClvIAR7gwyLago/6/kRx1Mzd7ztGXNAsz10kGLSn+xppcB5UmwXiKSKJSLQ
 VUng==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYsbUNbujEIOKkqVYX5QmkFg7UIdH/sdNzn9K8r/YYVInTs/r1ab76RfDu9dNS2okr7z3ou+ve4KU+JYeK@lists.sourceforge.net
X-Gm-Message-State: AFuF++neI39wEDqKfF9qMTPYpzy98Y1cqMJBUSmYFd0TDi0wIjarI8ii
 zjD6FGjJaS7SWkpQWUivuVQ26sAZuXL6mqiF+GECL8P2oxROIm7uYL82l4cSmePI2RAxynGxR6U
 v1XRXf+iDmqq7Aqt6DPTf+BCmAbaR4U36sChackMTf/DAMOQb/NHUtW3RaXwj+28lDBsi
X-Gm-Gg: AYBFou2sXoOkrWvSkVDCZYN9ikW4LjTI1qhlDuHtLFMF27BizPnN2eM25QhFWD8LXDN
 1Lb0uab4Qrr7FVfgNRcShqcrpywapQXoUZUbNzmhNqbA1DU92KRo0tdXQRWYDCpluEKZNQUhOQ1
 UKoRPbrnIraCCocEcmGWaDLll2mz7uxmt51Sog0B9SffxjxX5CrVd7R73WvfoQgxwO8lppB2HJ2
 q7rl8XHV01CxRdKPljZI8Rk4R/RZavEFNTLqNLN+CqrNLL53QfsH9klSB86HuweCEfbF2+knr+R
 2/dIr4vaetXSzTFN+hy2YokbuFGGVMaOJwhZ5vSKnSOoL9zOPpDIZjWjQV+oF631k4rL1YmTHV6
 rD1xDLK4QY65Nzs6VVWdcKLBVF4pj+OltHQsjb4kBseBonOnWxoX2jiKa/wLzb4yzIQuzIy0jNC
 72fuPBYEojzfcc8gKZZNS+m4l7i5V2rC4KYLHLDtpGq04gTbxS4mCQvN//Zo5HZSUapK1eIGPSM
 wzomhYJF7G9lkt+6T9y8p+/2T4EY1Ue7CTZ8vwd0JZS/Y5/tGDtdUtrWwfnBrawGSBuaJhDRrGA
 SxI/72dmQjvanz9Ys+gvT3FHCk5nCn+uFyjvbVbXwbgKVp0LAxpV7Cyp9TuRt6CI6DLHkdu7
X-Received: by 2002:a05:600c:8b61:b0:49e:69ff:c6b1 with SMTP id
 5b1f17b1804b1-49fc5749edemr158847395e9.31.1789986305936; 
 Mon, 21 Sep 2026 03:25:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd1149e0sm214219265e9.13.2026.09.21.03.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:25:05 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 10:25:03 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: e341e3134d523bec7b04ac998cad8c2a9b284616
X-Gerrit-Comment-Date: Mon, 21 Sep 2026 10:25:03 +0000
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a9f7fc50bdd4a144aca5e94675c8999e53648b75-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8bCy-0007Sc-L3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Measure probe
 RTT for candidate-band selection
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
Content-Type: multipart/mixed; boundary="===============1570432435071334384=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1570432435071334384==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0QgbmpLKC5w="; charset=UTF-8

--0QgbmpLKC5w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

stipa has posted=
 comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1748?usp=3Demail )

Change subject: oob: Measure probe RTT for candid=
ate-band selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 27:

(1 comment)

File src/openvpn/oob_client=2Ec:

http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748/comment/a129460b_0a8ce632?usp=3D=
email :
PS19, Line 274:         results[i]=2Ertt_ms =3D (ms > 0) ? (unsigne=
d int)ms : 0;
> Agreed=2E [=E2=80=A6]
RFC update: https://github=2Ecom/Open=
VPN/openvpn-rfc/pull/39/changes



-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1748?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
Gerrit-Change-Number=
: 1748
Gerrit-PatchSet: 27
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_l=
ici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Mon, =
21 Sep 2026 10:25:03 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Co=
mment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-=
To: ralf_lici <ralf@mandelbit=2Ecom>
Comment-In-Reply-To: stipa <lstipakov@=
gmail=2Ecom>

--0QgbmpLKC5w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/oob_client=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1748/comment/a129460b_0a8ce632?usp=3Demail">Patch Set #19, Line 274:</a=
> <code style=3D"font-family:monospace,monospace">        results[i]=2Ertt_=
ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Agreed=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">RFC update: https://github=2Ecom/OpenVPN/o=
penvpn-rfc/pull/39/changes</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">change 1748=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I375a=
41749060b7d006647bc27002c55436c8a8bb </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1748 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 27 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Mon, 21 Sep 2026 10:25:03 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: stip=
a &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--0QgbmpLKC5w=--


--===============1570432435071334384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1570432435071334384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1570432435071334384==--

