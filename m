Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EABBCCA490
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 12:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MMYze2Or+RaZ/crfCZ6Z2XmaNordSaR1OPKJwfefB5w=; b=XhJKfobGe6FZq5qLdmK96kOICN
	zHI7tBC2doeFa098XcQyxZOa65FY1+bsbABemqSZodvT3cZHAHJXPVP4iJEAsbj3NUCdbexUD59b/
	e71LlIRa4TvPQDtKTkZAXzA3ATemI4F3EmP6a8l5OZRrki3F+MQjM3sb/yHQRUQB46WI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIQGF-0008Lf-CC;
	Sun, 18 Oct 2026 12:45:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIQGE-0008LY-15
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 12:45:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=grSpWrWywNdvCW2aRRSEW7x58r+XNMcSVC2wGBVSvkQ=; b=YvwEiIxZe1DxkKGrzNzasIcPDL
 pRbgz3ImiulhECQpFnYT58PlEWs6PhTlBvoumoah1toJ2SC6BpRYKstYO5k4TLm36x9k1cQMdo+6h
 nqrX4zb40nNK9RUZhPAuk8QlvRg1Z9+2bRW57fd1BdbABmECk1/FJO0OB3Re0jeVVVNg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=grSpWrWywNdvCW2aRRSEW7x58r+XNMcSVC2wGBVSvkQ=; b=G
 5dMmCsF9eXrIpT3NO0azo1+aqJaCvSM0YVtVjlVSP0siZFeqha2yT8cuVJtqK6+73FJimuhx5/tXn
 uRmax51MqpBkGV733WP8+q04S4Jn92kNlZCUpYin/yyDzLwSOaQAlFTSXucdcTxtErjjo1fIi+Qr6
 qktnqOi23HQGw5U8=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIQGD-00066L-DJ for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 12:45:10 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48de72fc832so927280f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792327503; x=1792932303; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=grSpWrWywNdvCW2aRRSEW7x58r+XNMcSVC2wGBVSvkQ=;
 b=GrSFIJXPGNh2AbIeJFnkxlZaj3/XdV1AN6maireQD0nXz7fyF04Vtp3HHrpRbwHLp+
 /KNllnImGFhXkhNmaCgeZTL15lP8t9GBl7NLkYYlIqa1/iGmMTQtEJ6T1EnHPsOa558G
 yOjyIzge2hDsFD/cbh7Hjzz9EBreHjhB50FWBW+SKExW+J22bKL4NXS25Dhx0PX9D4WI
 7hh3N+hXyP7E6NVwQ8F3h3ZsRM1OM7PRzA7wMGedP9K4Ur/bapnvDaS+ab7Mw45m/0Bv
 9GTouW2/PYlJI0VJP+2UGrqggqFcRvOBZUTuA3/3tamFx9NYa/jIeblLOvyPFaHisOzB
 d6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792327503; x=1792932303;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=grSpWrWywNdvCW2aRRSEW7x58r+XNMcSVC2wGBVSvkQ=;
 b=BO1EkXL2Vb/AErmNZgp6xgfwSwePeZ0B1LA7t2JyDy1sHoMOcPpvtukhF7nD0avkGr
 /359NPAZcNByS33/QRiSazx6i5Y2/z9QmBC/POa/amuIpM90PoB5dM44lWbWtIKwYF1Z
 bDlGc01d7jKftgLu+f3/PHOuJd/pFGO6uyE5aK2HIHhbgEFrrwTAKb9YwKBqETZ/Bwzb
 VZlr9wRSd5q7xlOGeUCnLDSqzBT8xbQFRDHIXNAPUlruZgU8+a98tuTgKRh2b9ITm3mv
 l98kUQUJopHMnQbiNRwNX8uirkk0762zQHXW/y2CIMe88jW7h8PUcxmG5odj6SiKkcd7
 tV4A==
X-Gm-Message-State: AFq9FYIdehIUn4fjwmOGLZFrlKuzTwl6uPoLwNcSlbk5SZfKG/UourA9
 yTSCSffFvcCbthiv4cdgzBC17ucTak3d8HR5k8TouD8zfeJb5MuL/AmIa9P4aq2XN4WcPoMqFGR
 XtAtjphgzjeJpXOSFL9HYH43mfQHJ8BSztCXx2E3Y4hT7sDVvXDA4xdm9+84AWe0ua5jt
X-Gm-Gg: AYBFou2tBWRtpG57j0f+gnw8XMyid1/iqOutpletU2eL1720z5FRTptRgm4rxLRbnoE
 8HxZgYlL820e7jr7fLafsLv2rfdbMy526iiCImvje2cZ58PezeOxX/dQ6WFBMoCgP4qNiLoQ2Wo
 Vwv3AKGrJE8P4bY5S1wYlAgSHkhFFQj04P0t5cCWZJeDhGjPGLduj23d3A01paGs9LyVhdrYlYm
 rRB6l2YVNzBvSFyex3fAqWKHq65iMCoIA+quvYk1d00UzdpGGivf7vVuK39FE38mOSmfnyodx51
 BuMcQf/H+FUnYKwGsXZI5gUGwQMdmnJ240xZNUI2+bAiQHp+ilZ6kybWqd3tjUN9grNAOr7PREA
 8qIeuyciDJbVO4eYtu4LHYxjUvknxppdSQhpVrDVo2njfuIzuTFtUAyUsg4l+PpeWHbHhxMZKli
 GjNEdxAwxZDABT+41cn5p+FVcYAPTkojWrSFl28FtPTV8QDXNuB3INkdxhxrvO/48q6If8nVKbb
 ugR4rCW/ABhPa6kEwmzGncO0q80i072dA1Lc9f3rN5vK3U2Jx1vFJj5pzpU9y0FSNGwBM5DFR6j
 e3f0rJfIndoGRUwiyvAL00oe03qxgWXPsWLxf52paes873ZtoDgVObW9bZTS3w==
X-Received: by 2002:a5d:6dce:0:b0:48b:9ed:b81f with SMTP id
 ffacd0b85a97d-48e07bbe767mr6112998f8f.10.1792327502700; 
 Sun, 18 Oct 2026 05:45:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471b06sm18716007f8f.5.2026.10.18.05.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 05:45:02 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 12:45:01 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
X-Gerrit-Change-Number: 2014
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2014?usp=email>
X-Gerrit-Commit: 019f91d238c8bbf67bb6eeb8b795300b072bdcec
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 12:45:01 +0000
In-Reply-To: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
References: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzI1NzcwMDAwLkkxMGViYjU4MjE4MjliZjczOGU1OGZlYzIzZjlmOWRkNjVkNDYyNmQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <050d7208b6c3d3f3c68cb9c0696abb6cb1625e2d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIQGD-00066L-DJ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix cppcheck
 warnings on macOS
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7450792165762893685=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7450792165762893685==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="m9siW+zprIs="; charset=UTF-8

--m9siW+zprIs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Gert Doering has pos=
ted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2014?usp=3Demail )

Change subject: Fix cppcheck warning=
s on macOS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review-1

(1 comment)

File src/openvpn/route=2Ec:

https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014/comment/d4623b1b_318ef550?usp=3D=
email :
PS1, Line 3354:     bzero(&rtm, sizeof(struct rt_msghdr));
If we go=
 there, I would recommend going for `CLEAR(m_rtmsg)` etc=2E - which wraps m=
emset()



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
14?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I10ebb582=
1829bf738e58fec23f9f9dd65d4626d3
Gerrit-Change-Number: 2014
Gerrit-PatchSet=
: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 18 Oct 2026 12:45:01 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: Yes

--m9siW+zprIs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gert Doering has posted comme=
nts on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/route=2Ec:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2014/comment/d4623b1b_318ef550?usp=3Demail">Patch Set #1, Line 3354:</a> <c=
ode style=3D"font-family:monospace,monospace">    bzero(&amp;rtm, sizeof(st=
ruct rt_msghdr));</code></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">If we go there, I would recommend going for `C=
LEAR(m_rtmsg)` etc=2E - which wraps memset()</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=
=3Demail">change 2014</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2014?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2014 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Sun, 18 Oct 2026 12:45:01 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--m9siW+zprIs=--


--===============7450792165762893685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7450792165762893685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7450792165762893685==--

