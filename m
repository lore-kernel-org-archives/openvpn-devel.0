Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13C2C982FA
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TlXDhUrwpYo/zGExXZa4ZL3O31XP5BprieOvU7jFRhA=; b=m0M3DGn3tjNvDUjZ8GrqmFJ1PQ
	fCtcfWy+qcjxCe4gipdrn8wupV/IXsPKyp6XgqoY8tQe06L+9+mXtJbpcJR0B6nwfkJ1bl6cXY5gC
	qkPS0bO3DbEYPKRs1kKtPwgNhiwrVlMZDvfPPmAE2Ge4uO8HIFI16YItL14s5U8AtJBM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8zlx-0007gv-Pw;
	Tue, 22 Sep 2026 12:38:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8zlo-0007LX-7P
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:38:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=D21pnG+I1EHdOmwZYWiPrcMYGDJ6ihQJE7Sc/nB5J8Q=; b=E+Jq+t8mEJqHafEttFkxb47p3I
 xI1ZF2x7Sy9i60QbbEYi4NSutvm5lCTqdoIOgE92Box8QaTEQ9zOh3B+n6tVRlTCIPUyF98sPL9cq
 MJP1hy9c+yT6fOKRJqWVzrgAuBFOp2TVGjme/O8q6YHKIHTAYFqtXsAuUafqlxWARAUY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=D21pnG+I1EHdOmwZYWiPrcMYGDJ6ihQJE7Sc/nB5J8Q=; b=g
 GwtOzAzxU2WZH0xknK+qMpaocf5e8QuODRcE/dffOD/SMdpDfMW1H/VsDOawAniFh1sBz/hO596Go
 728nG7x1MLMD2noYq1lt5A/CWYkg6+79My1nwB3PvMdQEuoop406ZGzaINfgllcQTBl+CyEtsCHdg
 8wVD06/l5YngOx4M=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8zlk-0008HT-BF for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:38:45 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48439feca17so3174107f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790080718; x=1790685518; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=D21pnG+I1EHdOmwZYWiPrcMYGDJ6ihQJE7Sc/nB5J8Q=;
 b=ALlUhZtdvVMomDlBeMLM0sdw/dEDZU8F8KixZH7pMRDu6hXs1tz95rs+OuGVZtSJLU
 DcWh+oEkjyDYT8M/pmJLrdkLiUi1i29i1Pc+V4MGMzWY1PbklZii2nkxsEg8xm2ADZV5
 ZMec9OXO7lVl67dygWdgHLC/pygLrjv+m+QQCyuPEDFUSDslDaAAmeQRBHq8ly+zjcpq
 cYp7sclQtMXNbStE+FzkCh9qVDKfmFgzjd9ortQzwvFStIxDzGSxlH4bCFpabbDyY5m3
 w4JJ6GwIDf0XsuykU3wGcllgfKUXE3u3bCtun6ud9MzzdgoGVOdQCo50ZjnP42C0nYox
 0ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790080718; x=1790685518;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D21pnG+I1EHdOmwZYWiPrcMYGDJ6ihQJE7Sc/nB5J8Q=;
 b=pDAx7mG8QMA737v7K1pbIzIKmuDCsBhxdYxcLAfUjVgjdKrFy5Jk2t6/gDc9cu5bQo
 nwP7R186s4qWDZ4Zfr26Rn7qObHA6hTgUcrosF7jki8tlwllvSSSsI+CspoAjz+X4fu2
 JhW4imViPgMnk+DO+scJCzgZuBMmoXKnSH5pVl4USsrHYakFdnrMKeAz0AG/fMSAUm5T
 9n2/GzZqdQOOJT+6TNQO8uC1DUUZhYvB0008ZwFjWDPrDtjiLPdeeywVj81qB8kuSxmZ
 TKJuixctIn55ivIuKpEb1GFnF+Hv23ovwF8XetlTwUg7Hm0KPgINrzXWO0nNd74RJfRu
 FQHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1ekYxc8A7wzXV2dNsTjsrEnUn+hWZ95UzqQ6i0zuxC0Rxv6SuX6EJWhoDdE/mWXKGpPXFydl1PM15ecgp@lists.sourceforge.net
X-Gm-Message-State: AFuF++lHlJiEo6PktnN0eAy77L+xZJSyaAPVQcacYo1tRP4XzHZb+rUg
 IWdD0smp8V2TUB1TF3IfRI7xYETXxOK6LlX4HhSXCFR7uxX0WZkl44aVlBIPwhZgCXNxR2y5Nt2
 srZ6XU/NqoIOO6MrloyqOdNVVtpeRsH7Xe9XIJQctOLEqSXtnLLCwtC4UmpP0KmyrVGNq
X-Gm-Gg: AYBFou24rsm1AxYbdxFKgqt4ck7+pfgvdb2qljX6WvSq9WZngqzzrqhEUj+xaXvs0rv
 lvWObs3T9DxcUPU9YKBljSrTycHlkAmXdxp/bEiY2Z2MFr3l5A6WIQOddLxGZdkQmYXZGKftwt6
 GOoRuARvfiXHvoDpsMIP2Qzw79oS0hqDhtV6BG78IGv/bdcLqajWQmMzjAPdC5YGj4kww0ppIxd
 O07C1dysE1SYwNOPpaOARTz8/eTLnhVH1LIcoHLYdvsDBUYBxZKcJkHzhW0aynCSDhY355fl/W1
 SEwBSamk49+ipP73SwoPwjB1dHu3SUEGvJWU0jk8Wo/IncagBNziX5Ku0hiaA8ja0TlQ3q/Jl13
 u+w9lbZSDoIEptc2mep4oBVtlwlgUz4yY/M7V3BU5b5RlfWA9E7SnZeDR4fDkofZ/NEx1cJuh/O
 X5ImFW0kVJnwM0rYDU/OQ7c6dRCHCb5+7TJ7FyYjjTgDKr1crM3QDovETTpga4MtlrRt3imf9dK
 GHUpyzcdkVmT8b7jF0KXmPUr1wNHW4Px3F0eFxlqqANFoMunU9tkrs67Um/1RiwWHz2/dQTV/Pt
 AQdYu+c+jiNLLyn17qrWVvdGr7ad3daar7Q3ghfX6OcAdeHqoqicLWu+xB/ZB4w=
X-Received: by 2002:a05:6000:144c:b0:488:63f2:8766 with SMTP id
 ffacd0b85a97d-48863f28a80mr2107012f8f.21.1790080717509; 
 Tue, 22 Sep 2026 05:38:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862788f61sm4930127f8f.26.2026.09.22.05.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:38:37 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 12:38:34 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
X-Gerrit-Change-Number: 890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/890?usp=email>
X-Gerrit-Commit: e064870a823d64266e703fb724cb088f366f593f
X-Gerrit-Comment-Date: Tue, 22 Sep 2026 12:38:34 +0000
In-Reply-To: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
References: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzM5MzYxMjA0MDAwLkkyMmU0YjczZTc0NGM3NjVhNDNiZGIyOWY2ZTE4ODEzZDEwM2VhNzU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0a1c535e92372d0427eda6bc732b0753900a486f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x8zlk-0008HT-BF
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Always use a
 0.0.0.0/0 default on Android instead of def1
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0123658617254942403=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0123658617254942403==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ntzXRE+kFes="; charset=UTF-8

--ntzXRE+kFes=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, razvanc=2E

plai=
sthos has posted comments on this change by plaisthos=2E ( http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/890?usp=3Demail )

Change subject: Always use a 0=
=2E0=2E0=2E0/0 default on Android instead of def1
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(3 comments)

Commit M=
essage:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890/comment/4b648b11_3a5=
52b9c?usp=3Demail :
PS2, Line 9: Certain handset manufactures (like Samsung=
 iirc)  are handling
> Typo: "manufacturers"=2E
Done


File src/openvpn/opt=
ions=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890/comment/2f7981b4_b=
03abb67?usp=3Demail :
PS2, Line 7324:                 /* Android always use=
s 0=2E0=2E0=2E0/0, so silently ignore the flag */
> Do we want to ignore it=
 silently, since this is a behavior change?
I expanded the comment to say w=
hy we are doing that=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890/com=
ment/bb440912_483ac534?usp=3Demail :
PS2, Line 7325:                 option=
s->routes->flags |=3D RG_DEF1;
> I hope I've followed the core correctly, b=
ut `do_init_route_ipv6_list()` still seems to unconditiona [=E2=80=A6]
I ha=
ven't noticed the bad behaviour in IPv6 so far=2E



-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
Ger=
rit-Change-Number: 890
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: razvanc =
<razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-At=
tention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 22 Sep 2026 12:38:34 +0000=

Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc=
 <razvanc@mailbox=2Eorg>

--ntzXRE+kFes=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, razvanc=2E </p>
<p>plaisthos has=
 posted comments on this change by plaisthos=2E</p><p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail">View Change</a></p><p>3 co=
mments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890/commen=
t/4b648b11_3a552b9c?usp=3Demail">Patch Set #2, Line 9:</a> <code style=3D"f=
ont-family:monospace,monospace">Certain handset manufactures (like Samsung =
iirc)  are handling</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">Typo: &quot;manufacturers&quot;=
=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890/com=
ment/2f7981b4_b03abb67?usp=3Demail">Patch Set #2, Line 7324:</a> <code styl=
e=3D"font-family:monospace,monospace">                /* Android always use=
s 0=2E0=2E0=2E0/0, so silently ignore the flag */</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Do =
we want to ignore it silently, since this is a behavior change?</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">I expanded the comment to say why we are doing that=2E</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890/comment/bb440912_483=
ac534?usp=3Demail">Patch Set #2, Line 7325:</a> <code style=3D"font-family:=
monospace,monospace">                options-&gt;routes-&gt;flags |=3D RG_D=
EF1;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">I hope I&#39;ve followed the core correctly, but=
 `do_init_route_ipv6_list()` still seems to unconditiona [=E2=80=A6]</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">I haven&#39;t noticed the bad behaviour in IPv6 so far=2E</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/890?usp=3Demail">change 890</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/890?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea=
757 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 890 </div>
<d=
iv style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:=
none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2E=
de&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Comment-Date: Tue, 22 Sep 2026 12:38:34 +000=
0 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div s=
tyle=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:n=
one"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</=
body></html>
--ntzXRE+kFes=--


--===============0123658617254942403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0123658617254942403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0123658617254942403==--

