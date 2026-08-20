Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602D9C5DF81
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RbfZq30h+oREqLZaUREMcyJNeimYjw286S2ZsgtVBI4=; b=Z0ouxg6TVW6MiDan5omOFSm4an
	XzItZyayAJ52WS66bPmgncgYrGdrlHENPTEXHSPZD87ZuUYyjd5bY8skDH+mLZ2OrI1Au+KXv4Q2X
	bhoUthPwSZoQSL7sX+xbWkrsV2FKuMtcH5Cs4d3ZbsqrTuIVw1zqHHrwBcavMeXxLxjw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwzXZ-0005IB-0L;
	Thu, 20 Aug 2026 09:58:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwzXC-0005Hi-4Z
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 09:58:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xx5D05og4Ict8KIVbjjcl6+NT4QvgsBm8Ok+8XjblFg=; b=DyKhAYsE/tRu7LCDW7F4kGDsH4
 L2VgpGSuzYS4X5ZIho2u7MxlfQjs0mgiNK7zyNPLutmrDH/5eZtCKm4NoelWqrB3Sqr6AFVOwhphn
 dtW1xnmkHB8rSRg1aC0Gl+gDvFA26ddKnDQqZP4VR0TYX4GjvKwMOgkcqolnPvuDNldU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xx5D05og4Ict8KIVbjjcl6+NT4QvgsBm8Ok+8XjblFg=; b=m
 Xux1jn/DiKU9TrCs/79b7Ib4HKPLcqwHeb5KJhHu1RMrdxfPMWKo4Z0ApVypc8c1aE7svVP1nhp5+
 G7xMOcFGPfu97EPDCICIZgeV+ohdluLTgKfopRl2XgMOTFEJvzqVLzI0kxfSbKBaIiqgKw5Dqdwav
 XvAm8gsuciycLG2c=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwzX1-0004Df-UN for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 09:57:57 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso21198095e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 02:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787219869; x=1787824669; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xx5D05og4Ict8KIVbjjcl6+NT4QvgsBm8Ok+8XjblFg=;
 b=ZdwxvSN8TTy7ujV1YDmFcyZRIJ0UV3kfESkJjQnTsBIEkFwuKfL6E0m1kVF3ZvtnuU
 iptYI/cwPkzLQfBfH7p2jNQ/KhOu54RwMJ2kFskwUpFY8AHVbK3suMmm74x0to2nfqj7
 gTCFzMMa4ZiGDewX9dBWzcdApnf7kf5qFjetB6AdJo0uNvPd4mbsNyi6Lx7YHjLSFEs7
 +6pKHbro775zG2T3UWGvdyC8hkG0XHDpsQdI0Sh4iDi1WQdfVf9ZHimMc7FG/mJu8XyA
 scAqBjYWQpysEYuPhLvJT8LZx4bBjFARuLyEedHXG53Di7f7EWAZ4WdxLRR7ByKbVDo7
 yXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787219869; x=1787824669;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xx5D05og4Ict8KIVbjjcl6+NT4QvgsBm8Ok+8XjblFg=;
 b=kTYRpiq5JrO/ynRD7nEcO4e2rDjxGDrD4rqeyjW9PQUPCKTcGxrMEw4UKwftPgkNQv
 RBS6pYPpNNFc8tH8kpMI+HvsP8+PSq65crspFPi9d72XtUXYbRbDz0bZoY9lMDyxlbsk
 VWNj1HgeVRP6JHbnUfeu85+K6qR0YU4mybK+Gu6RkphVQ1c1LZuTAwmadEfewHS6HJ9J
 eggXT7Sntitd0tXZJiWcXG9v6YukBGKUOfRoJQ0z0Sjabx0Ks67eZgVuOVEE5GhOIcjH
 E/sgUM7rzh3iXezjIIuptHJ9RsMxqq/VV3JEnafAVDON4QQw6Wapt5KzOXuBegGPpIvV
 J+5A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rody3lBpfwt2/KJmjVtt5tnqre7KSoQHJ9sc7zunfTeDlzciypk8XkXS99wUQZXPse9mWiFisD9Q+fgo4UW@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywn5TbzIgHCcX6bzyN6BVelX0tfA9DVycE66xlMQzEHLshBve0l
 lPgSlVPJPMzgQLDEZMabBnDcBSTWLk3NklhdhR9J/9azJ0gfp2N5TpWjwYTJJKfV6JJg2Ph1+Dv
 crBzBtHJkcY8LHVY+HrIRk62jsuSj8S8OEgv7EH9dIcEsfLXMU9hX2UeNIQgG+owu8OZe
X-Gm-Gg: AR+sD13mtcCRZhspcoNIoWlLv6sFaJbDy+Z1ugN8YmbWpo1zDdEAPXGmFyM+INrPgip
 pq2MAWHySRJFvHYdRglycg/x4ZeuQKN0tHeaVFhp8Hz/Ftx+CPtwtW4ajYCxiun8zksXBk3yx3q
 de5q3d5LkP4/0jSIU37Tx1MNQ3kNJ38UOJx0g/xvK53KQuTKIjnT7bMjxSLqoOf7BOuGMPj+7WC
 3jHYXwtsHXVlCuAWDsMv+CPiJepuT6n0vBM0R+YCzQHQp7i4F30z9q7J8+qJ8znc3An2wpHBoq4
 oTjXaOV7NxWt5h5RmTidCgIKwrtvIjNFqoCDaOsoETf9hRHvrTm9aX70YR3wxWmU9+7veNxNR2L
 ptrANr8KmgbXjCOOT4svq9szGv10Z2feIGQXiJihjicYRTDUqLGSNR1RDZ+XrMdi8wpkSkS0mJo
 ewqqFK/e6KiV/ogEzX+8Kte0xnrdrwoobkqOmnctcnXvfhoGb0VgCBnotgUhoHvlk/quLpAbBzv
 3/PsSp6h8Ckz1xg0qKweHKuaHuPR9UpfMsiU9zmyi29aDFG8rZ0VjQCheVABHJhq2tg0AG3T7mz
 nB71j3HSjWA5cfG0wTbPKOzm0jBPcNq2hhJ3IWmmMvXyd03r+54=
X-Received: by 2002:a05:600c:4e04:b0:499:8ed2:8234 with SMTP id
 5b1f17b1804b1-499aa0e221fmr248470795e9.0.1787219869319; 
 Thu, 20 Aug 2026 02:57:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa175d0fsm134854435e9.9.2026.08.20.02.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 02:57:48 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 09:57:45 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ibb80db0547dcc0935964c9bd40222c27aac80439
X-Gerrit-Change-Number: 1848
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1848?usp=email>
X-Gerrit-Commit: 676c9da30502b1e593d554b54f17dea41f0a5508
X-Gerrit-Comment-Date: Thu, 20 Aug 2026 09:57:45 +0000
In-Reply-To: <gerrit.1787144531000.Ibb80db0547dcc0935964c9bd40222c27aac80439@gerrit.openvpn.net>
References: <gerrit.1787144531000.Ibb80db0547dcc0935964c9bd40222c27aac80439@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTQ0NTMxMDAwLkliYjgwZGIwNTQ3ZGNjMDkzNTk2NGM5YmQ0MDIyMmMyN2FhYzgwNDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <de4626969da1f27d1789a6e7b746d17a8aaad205-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwzX1-0004Df-UN
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: .clang-format:
 Convert deprecated setting KeepEmptyLinesAtTheStartOfB...
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
Content-Type: multipart/mixed; boundary="===============2520920009902518354=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2520920009902518354==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="02XLqlRJHvM="; charset=UTF-8

--02XLqlRJHvM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1848?usp=3Demail )

Change subject: =2Eclang-format: =
Convert deprecated setting KeepEmptyLinesAtTheStartOfBlocks
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2
=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1848?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibb80db0547dcc09359=
64c9bd40222c27aac80439
Gerrit-Change-Number: 1848
Gerrit-PatchSet: 2
Gerrit=
-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 20 Aug 2026 09:5=
7:45 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--02XLqlRJHvM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1848?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1848?usp=3Demail">change 1848=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1848?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibb80=
db0547dcc0935964c9bd40222c27aac80439 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1848 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 20 Aug 2026 09:=
57:45 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--02XLqlRJHvM=--


--===============2520920009902518354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2520920009902518354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2520920009902518354==--

