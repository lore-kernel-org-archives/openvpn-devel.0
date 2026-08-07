Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B783C5AC7A
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QCmnT2nWCAjjzp88iXzdf+KVHzKvI7Sgzdx4pJVbWo8=; b=PFzOJ4uOf7FPdvItLk1g2Wgbsc
	1vucadAR3RFypUveXizb0G3uHbdju643WiWOENtsW2Pwxuy4GlS8JC0zxGMs436KgoDqHUhbLorf+
	CQNHc0x1HJoHlxDArM2W02miVnwixh5zIc5H9fHYiXkgY14jcGptQqPIS59x5Y+YO5WM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsIvS-0007iY-HY;
	Fri, 07 Aug 2026 11:39:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsIvQ-0007iR-S2
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 11:39:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3tuZ5jKswb/XHg1XYpAgQyUHNc4z5Yup3Wbn0RYeM3o=; b=BXSUSl+1K3EeJdhqDaw7Fcsr1B
 +HUEcdG/Pz8mILc/jaFgfxsUsfq3/lHLD3CoH8z7xX4NestdTnwsvPNYJKPzaMDlJNMKyf2SMBEGq
 WedkHSj8bY3D4P6FdTr+Vfpe7ewXFFgKPRYGIxAfLzy11f/ZUl0tMuXcmtwz78XUEYe8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3tuZ5jKswb/XHg1XYpAgQyUHNc4z5Yup3Wbn0RYeM3o=; b=d
 bzzq8ZGMdW2tBQJmCwO5UpBcona9XufJ4OzuO4tKPKdxZC+SK7PtzOTib06ZTfj6RDIPmeIfoBo0e
 mIXCfPTiqzGdHkDt6DPPkQbm7Hq4TzbxbPAOikjw0yZsdz8cnMAOobyxnE0hVwTpcJCkjO4G6wxAk
 Hcy5mf4I32gNSj9w=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsIvP-0002JT-Eb for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 11:39:44 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso23034975e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786102777; x=1786707577; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3tuZ5jKswb/XHg1XYpAgQyUHNc4z5Yup3Wbn0RYeM3o=;
 b=UcUvepZaJgk5ZVArh0id6ZuQJvme2r+BAmolxfZcRUKKQPDvPK2Y87aoka5Q/fRgXQ
 wiOV7CYaaLS+tVjRjEDLGjGtuhNrYEqGIzTtlR3FUKmq2fc6+HMckxXnGK2TfLxnM6ig
 /rS70NOYKZYQkMZfJ/ZPFloJ58w+P5SzjGMbmLNSY/nmkByDaWA4tN11781PNdR12ofg
 W584coSarsLuw4yU/AWetLbPpTzkh6lKPaErGEzCyoK5T/weRYUJacIxzHfxz9iYL1JN
 w0il/fT3wUKl0FcPsspomfzKQuAkx3NQtNFQN5epf7atUwsiwkPGouhW55bKO2mEJnA5
 ZQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786102777; x=1786707577;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3tuZ5jKswb/XHg1XYpAgQyUHNc4z5Yup3Wbn0RYeM3o=;
 b=MwJU9BRgRkNlWMbxz0EKWvXo1AM7lz2ANqphPBTVcFwd8BlGqkq+i5gMfFgM9N32DR
 lCsPzBuN3hV1uSAxPtMMuGrMSkHOswOHZtVAvaBTAQtlGh6/mMzo3gGr6Y4+ljIQhhWr
 EaIBFznvhCfs8BkieG1MII/smsSfZL9nNAWw4nVtG3xVw2AzS3e05WgaqPjbezB2ysSq
 4mhWBB40MlaOf+6rHRBT95uhOiae7iSuHcYqhLg/MBqWgMZshEdQLk5XrMsPcqCrCpTm
 ugZqlfaRnXo3YXQSxS/ni2Yv8RYu235ekCITmdc88B0ABPUXJfx0alic4GYxAEDJNw+2
 zu9Q==
X-Gm-Message-State: AOJu0Ywx18gGUNo2MmfYVLDO1QKwpGivOqaquD4+9/MPjIrIIfsbGOzA
 jGnVpXwAA0u6C0KktNswxB692rL/8T0UtEwcCZf/2d5auLVYFdknMf9MBHwwYNkHM3h7gQidxef
 Zt7fqkZzAgYjHonmDVMj+M6orYBuJ2UUQQQXLWWMsoERHplv/Kz1DKDGI4tQoJ5fq9dLNVVHanW
 u8gwxvRQ==
X-Gm-Gg: AR+sD108Tzz5QMjR4wQtEiD7wMmvIQzCKFAizGhuhKUb/cB1a4bq45c82LND9vplfOQ
 8ouN0iVqFORiZRS6EvCnQwdli29BJYeimoeLKQJM7KGz83vaW5FWKmSeZ43YixvgVG+8SUCoPmR
 d01zOx5HVqRn9PYSv72nZzxvrvEct9q8OtimbwGVmkbfzbr+BcV+7GdJJc/ZOP5Cxi/cJBt7Ma8
 vbq/59M6fRgyh6wFUoqvvhLZJH54uZO5sNnHoMZPzYeyf2xZqihVYwJmTvAA3Fy8nq37ZrawS/D
 UaxCB8mMo2TXJfdlU5O0Ujf6eyrzLTEslm6iQ+3hVjsPvYLcQEivwSstc+V9f9rEK3h90MKa3OY
 szhL4GxY5eVgywtSTbtCcZXMvxsH3UWugesru6otIEeCTKVfNjX5p0sZRhoWpXkkpyBgMLOjM7u
 6KZdw/3rSzw3sHsupYyl/obBiWhwV+IuiHforPrIxKBD+kgspbQ4FvAgi+58ZfaZEMIv+8bTzxE
 ZJ/b37oopsfUHKp6YWT9KM5BbGQ3u3dQbLjyNYyu2aJWACQuNTnBZYyr46cXFrJDeiBSDy8A3w5
 6zsNBq3VPCmTE9wxPNYcJCA7x8gkvJ0+A7aKVjb7pTTQabsSj54=
X-Received: by 2002:a05:600c:190d:b0:499:5a5e:f2f3 with SMTP id
 5b1f17b1804b1-4995a5ef379mr90408265e9.5.1786102775638; 
 Fri, 07 Aug 2026 04:39:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542858b2sm158442605e9.14.2026.08.07.04.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 04:39:35 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 11:39:33 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
X-Gerrit-Change-Number: 1763
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1763?usp=email>
X-Gerrit-Commit: de4a268fe490245fce4a6443a886bd6aea8ee893
X-Gerrit-Comment-Date: Fri, 7 Aug 2026 11:39:33 +0000
In-Reply-To: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
References: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMzODUyMDAwLkkxOTA1ZDk0OTQzMzZkYTRlOTFmMTk0NmQyZmZkODc1NzIwNjA1YjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <01afc5c9db819b72846286aadc177908c8536282-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsIvP-0002JT-Eb
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in: Add
 utility function needs_openvpn()
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
Content-Type: multipart/mixed; boundary="===============7315352971035818505=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7315352971035818505==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y+8kfp14E6c="; charset=UTF-8

--y+8kfp14E6c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1763?usp=3Demail )

Change subject: t_client=2Esh=2Ein: Add ut=
ility function needs_openvpn()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

File tests/t_client=2Esh=2E=
in:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763/comment/a075fc7f_df41a0=
63?usp=3Demail :
PS2, Line 79: =2E "${t_client_rc}"
Is =2E still considered=
 what you should use instead of `source`? Or is that a /bin/sh compatbility=
 thing?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/176=
3?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1905d94943=
36da4e91f1946d2ffd875720605b41
Gerrit-Change-Number: 1763
Gerrit-PatchSet: =
2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Comment-Date: Fri, 07 Aug 2026 11:39:33 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No

--y+8kfp14E6c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1763?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File tests/t_client=2Esh=2Ein:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/176=
3/comment/a075fc7f_df41a063?usp=3Demail">Patch Set #2, Line 79:</a> <code s=
tyle=3D"font-family:monospace,monospace">=2E &quot;${t_client_rc}&quot;</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Is =2E still considered what you should use instead of `source`? Or=
 is that a /bin/sh compatbility thing?</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail"=
>change 1763</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I1905d9494336da4e91f1946d2ffd875720605b41 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1763 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Fri, 07 Aug 2026 11:39:33 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>

</body></html>
--y+8kfp14E6c=--


--===============7315352971035818505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7315352971035818505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7315352971035818505==--

