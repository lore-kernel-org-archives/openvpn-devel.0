Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6572FC4451C
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8TUGu/nPqTMOZWwZJOwY+pQlsWt3ed7HardeyB8Zo7I=; b=f0IqD7e7ndyyEO8mCcHBKSql7S
	7ISnrp3xi57T7CkfGKgQYylHUisVzc2XJ4ylZ0vCmDHPKpvPZQ0sT6B4mNtRebOH6QiH+Zpoqe5Qq
	Z/cxJoVWRXl/XhlRf1r/fNvt1vFrEGxKIAH7FbXP9bYIrkiIzeh3RtmKowGOER5ZTllE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmROW-0002FK-E8;
	Wed, 22 Jul 2026 07:29:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmROV-0002FD-96
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 07:29:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rMS/AGExDC1Grs4lYDYvtltOAVlEaQWVC69x9JU2+lo=; b=nKdd4ybiuhxjQxrAYaLxAXa2TB
 IO7pBWYARqMPwsJqex5hg4m8rYOmX/algkmGE6RJF2fxZCKOS2cf/GM1S0vqlwZ7kf71Y/139l3jK
 VQ2Fk9cpxRIvbA1urIGAAz+UJJKSPG7Gvpyp/sl780ADtzSwoY0GPfH3+AegH3934ptA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rMS/AGExDC1Grs4lYDYvtltOAVlEaQWVC69x9JU2+lo=; b=W
 aej2+R/48er5q3HTPA3ifOiQJ3QZ8fDAKy3OiSkpwqzDwAKSYG9+vu5jsb1Jc/U3UG3vxc319WXcF
 RkY0yhOYq8LolXv7pk4TgnG+JGsmqanMvocuOap8LNtI7OwV0pYkdfmYy3Tq3oUDtzKxKguBpXBix
 /KefGeBar8COgArU=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmROT-000493-Px for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 07:29:32 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so53513275e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 00:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784705363; x=1785310163; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rMS/AGExDC1Grs4lYDYvtltOAVlEaQWVC69x9JU2+lo=;
 b=Z9DnbtO5h5F5gUJ/H1B/Q7UfKlmgtd4itnYGgdAOYF4gZ/LcyZ0nGo2nBA72SOQBEP
 /qLAkr8qq0brF71FZO8X2916luaygLcPtmesXZtS8Zy5kcqdXDJpw9zyV+MFUjNQvhKu
 hynyVKU57YiSOaGjjIGVyCyGWdrKvU2C4eGFcRET/V9+0JVS5s7mDCmwXHXiDtiOqxNj
 fjCbvXsJhNKF8ComznhxruAGfxgWYKCBOPRNEhGxzLdbZbwOtwqxrLp4MoIjjW9lqADZ
 O1CNU4tW34sgWpSX+tBGQMUSgCb7N6cOcxknVYvnIu20Hrx3k5lxdot0O3pvRhuCIwER
 jCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784705363; x=1785310163;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rMS/AGExDC1Grs4lYDYvtltOAVlEaQWVC69x9JU2+lo=;
 b=TM05Hd7rH97aDfOl7XWYtaDeKudvEr295ekyOX9fBWcghQeKnSbLk25maTpABD2BHv
 TOge5SxcBEsYpu5Lxz/bs4Twh4Bnu+VDewYJUpx1IXaRkkW9GQj+sxvdfUAu4txv7/Cy
 iXWa+cHqB3fqgLmHriSwSWnFA9cKJ84JqAdJa/r/Nf8Y/S2eIwYRCKlsY9mPdKmNu6yv
 bSegGTfpaX4HWpdWf8OgxwC2j8gP0d0blKXdCO1ifPXMwBQ9wOtah1LHSjJsBbp9FCvI
 v0TrdHbEZwM4FTMbxY5GE1cNdgRvU1LC5Vwd2M9VPblKCX76pH8sjjcJ8OHs6fSkEUFr
 kyRQ==
X-Gm-Message-State: AOJu0YzvHamZeTZt8qMWPpi6aGkrVKjx5TvTQtFsL+mxx9B2DCUvvYSx
 JFgzwIegQ4Bs08fOdcbxWSoEfFXkgixwB5stZDfYbWw92jT3uvKGeDo2PvYnOxx2lR69XoBZrV9
 3liFITGpqgoekW5Np3T5fy+cI9IB0CJPOmMxzHi4jhwNxnOTO/3p7CoWvUut8RuQDm3vb99EuR6
 1T1Aencw==
X-Gm-Gg: AR+sD13sfqt0T+jAUC2Aw8C6mhEt71BRLFy0DuYfa58KpsK/6TIhi/jVTY7OG7coMoz
 ZSAGUUMCR+f3wwbrHKo0vjUeETHCte6wf0nhYME0DEv/p8kFZiXhvMkF9f/J1JKn2GjG8EeVQpZ
 lztYT/l0PIG5gF9bP56WLcRYvYSfCXNRAkJNuwvxhIZKkaCiaIbyZKki+ChllhCwF1OJuytpskI
 3mf36tnKLv4i1Akn4F65H8t+KOxWU4UMSySLWEbALKC6Vo2Qbvnyn6iJgP+saP+8R9y8EdgK2kB
 QSZqbd2gHMgasQ6ZO2CQyUIGgxQEHdlkXzrX03oEJCnQO4mbBOnzju9EUABSB07NhB4dQEA+a2+
 EFn2x388i08MVf+JF1OLPyDk0WUiXhnH+ZE7GGf3C+KJ2gf2ArAvbWfJSIUTZFWk4+/jznHG96S
 rKXmcnEOoPZ1ZgC+eF8XfGmQePHgdkaCHIyahwLxnW5JFsqEDI3x3okgkq12CzdT/gXjGuicanT
 zihj3M4a4QILOWSfIVS952bYu7TeEusBKBWS9+vWpJlAODoJj0QNXzm7vif+C9XZFlW
X-Received: by 2002:a05:600c:1989:b0:495:699:84ca with SMTP id
 5b1f17b1804b1-4954a798f17mr229614465e9.28.1784705363130; 
 Wed, 22 Jul 2026 00:29:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4aae16sm48575655e9.0.2026.07.22.00.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:29:22 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 07:29:20 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
X-Gerrit-Change-Number: 1793
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1793?usp=email>
X-Gerrit-Commit: d0cd33880c2af6a8573bee59a325bf8b084440be
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 07:29:20 +0000
In-Reply-To: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
References: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk3NmNkMzhmYzRmNDNjMmI3NWVkNGNhNmI5YTVjOWZmZGJmMzMyYTBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3a420d655543482efc5191c524f68a0844809cbe-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmROT-000493-Px
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Reformat all
 shell-scripts with shfmt
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
Content-Type: multipart/mixed; boundary="===============7886061980497769051=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7886061980497769051==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bf5ZsdzXMKY="; charset=UTF-8

--Bf5ZsdzXMKY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1793?usp=3Demail )

Change subject: Reformat all shell-scripts=
 with shfmt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review+1

(1 comment)

Patchset:

PS1: 
Looks all good to=
 me=2E I don't have a strong feeling about formatting=2E



-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf33=
2a0f
Gerrit-Change-Number: 1793
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-D=
ate: Wed, 22 Jul 2026 07:29:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Lab=
els: Yes

--Bf5ZsdzXMKY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 1:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?tab=3Dcomments=
&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Looks all good to me=2E I don&#39;=
t have a strong feeling about formatting=2E</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3De=
mail">change 1793</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1793?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1793 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 07:29:20 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Bf5ZsdzXMKY=--


--===============7886061980497769051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7886061980497769051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7886061980497769051==--

