Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9CBCD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQ6PaBuNrQdbg/4HLx5Z14ElD/IWVYl0QFDbG+6cPsg=; b=UpoF6i24bA9qYfvhFjDar1ay9+
	CLehsg28HB6hwgH3/efNllvcm1bh9+fR8EZrUwnkxncDwu4KooAyJfbX96J2BD4mdzsb1qe6UI/f1
	bjnKfv25o/XDMherImXfw8DI24k0gxP0WdtJOWjeplOpyiL4GrWyrsXfRiiaqeTKU5GQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgWr-00061k-KH;
	Mon, 22 Jun 2026 15:25:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgWX-00061S-TF
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:25:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hW5GNFklWZ+jZePt+mbVmvsV1nsSbG5ktlBl1LBkR2s=; b=CyxeOob+fRMWeqJnbjK1Qgcsye
 LUJX0VZ5ByIieQfI5EgVMmhDlXyColVgwLr0KY+HUNdUKQBC/bHJ64FWlWUstw5JijzraJW39kXV5
 TkPSsCN3Ge1A//QzK4lHhakUJbcE1cIYKiBJDlQlhI5rNaVr+9ijlBAYEFdXwIAfYmFQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hW5GNFklWZ+jZePt+mbVmvsV1nsSbG5ktlBl1LBkR2s=; b=N
 d/WrBRF4zJMN7hC4krFejsZfk4MM6twpPqqqa/u31RFKpCTzX4kbBuay2pdQL9CfoFEtSk0b6fJ92
 Tb4V/J+VERqa/9tRjFOT8ibECx3SizqNFJ0aDvINuzrUTgHvpGRV/FrLape02a9niNLIS4oADbdk7
 c7cCV9DsMK/0yUP0=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgWV-0007Wm-3E for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:25:21 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4923fb1f095so33522085e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782141908; x=1782746708; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hW5GNFklWZ+jZePt+mbVmvsV1nsSbG5ktlBl1LBkR2s=;
 b=RZlKQyAJuZlME/3lwi57htcUjhIQKqDvlGekmtO0HLY6tqiy1aJpiUMTFIgToD7GIL
 CHEgoeTEaRblOyuI4FuiVqj5kWTk5gVIif2Ao/QxwBH20VxiYWCsRn6rQZ8kHivBcL6F
 ecs1X1CTK9RANIM3EEywC8lvNwazBJpyusZm0TV94+En4Y51elv97zL8vtjRonGMpca0
 lNZAWjz2GB+wH+ZGvLWZF+FZYXfEWFz62GXpOH4jrAO+wM32uwfQ7tfUMw1PVeUzusMj
 dsMy4GxILJjfvOF64SkAk7wz0DTWpzH3Vsz7hIw3HwB69nnKRxxxWS0uxuDarDvfntXH
 4yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782141908; x=1782746708;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hW5GNFklWZ+jZePt+mbVmvsV1nsSbG5ktlBl1LBkR2s=;
 b=PT8D3Sr1qCnstdCwCbB7XSN4CfRUHlXkoqeM2vzjm0CnAPBQ4ahiilA663Q7/kW+dt
 twjQj4kqEKViweWb51UaQb/WIgA5LOBMLxVey/fduzV3JzXN0YDB5SpkD3NgaKe+HpUp
 2KPCLYG7fNCzxpULDrvLrsUFe1AmC66n5cz1+ctfpUwWgtqLKkWdCEg6LuXdL7BmYG5L
 AtlF/2GeewPG+Hzqwy8DsyjJjDybKAxMNMZQxpZC7OicITyRnVvM5kxzSpJzwh6mazic
 s6OqdMFov/ef6k6M54l1xt1wAeSuiS/pI9Vf5SobkkXUl4K+h2lrmHPurzBrXEHhE/1c
 A7kA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8K556SJ77VPf3iAim1t+4WMIa14aJ8t8ilWKzbGlnFTmVYeWNL1/GkJASoA6VlxCGIA1YuVfRDi6LLkGy8@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy3DbNE6xDdPM+8vUnbydVdCIdlqK9VbCS2xzu5q6SYSwildr7+
 0lZSOPJLKcpvYnMTSu9VqCxBxiOuP6R90NcognTUiF5sgnu1/5MDj0gZD8ivYf8JiqyHaWuE8yk
 ZKTKVAeS8B4o1swAlTdCMC3IAH0Vt2hpk46dRIXegHoBpXfE/k9/R2Clv9zezbHqnE8E1QeVKnS
 RtfKwmrw==
X-Gm-Gg: AfdE7clBhsO2gVl3zOLQPtx5EDk8qvWyEeG9x4YBCcnSlF8v1Ha7k6dvaF8XwoRnrph
 8sBy3FPynMMKaxGnVxsQe7hPu9TgKbTQFyB45Gzn+HkHaxIMqA7jF4PtF+E3U2yQQkpNh8rnNAD
 gkMzWdNFD9XK4PEM6NY3gHI81kpMO9BhspLGbD0VHoiOU+RLytSpE7OJzfakIHTEWD4EhxyBUdP
 tHcqEIVwaCRQF8xPjBDOkcxOWTyjF81JBEHmn7UvhuZRZdPFpKr5nPuw5VqMNSfrf4vq//OQrbq
 WpiAyT0yt2oIVS0JE4ooir1Crdcns2TUjyYtHTHsoGetRaXCFwEmaTCY2GMCJvmyaMonyjdlV84
 UpNg6HYIyN2XZHB/zsE1pqoRfnlZGgkxiXfmgIt4PY0BTVUm0EMwug/IlYw658y66ULwYN5+XAl
 ae8A/HPOLNkxeI2E+p03mvrEa49TiWOe44/HMC5Yu8rf8+IcO0nYbiCb0v115bjgsEqzHbVj4qd
 VbIK9tcvGsvhphS3YNc+q9XxFSXGvHMBkihllF3asp++QuMSyOOLtH4qx1cWxR/gxN2kLdrkkqB
 xcE=
X-Received: by 2002:a05:600c:4fd0:b0:492:4986:24e with SMTP id
 5b1f17b1804b1-4924986054bmr148845785e9.21.1782141906860; 
 Mon, 22 Jun 2026 08:25:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4e9esm25741234f8f.1.2026.06.22.08.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:25:06 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:25:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: 516b6556e193aeb3a43c85599605d77fb38e68bb
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 15:25:05 +0000
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <95972480b1c25f7fbfdf4cee01d25e6238633f09-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgWV-0007Wm-3E
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 multi_check_dest_addr_allowed from multi_process_float
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
Content-Type: multipart/mixed; boundary="===============6978534968219771941=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6978534968219771941==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rLZzuJgdSuo="; charset=UTF-8

--rLZzuJgdSuo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1723?usp=3Demail )

Change subject: Extract multi_check_dest_addr=
_allowed from multi_process_float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/multi=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723/comment/c5cce27c_3fca=
c0b4?usp=3Demail :
PS1, Line 3130:     struct gc_arena gc =3D gc_new();
> `=
`` [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1723?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
Gerrit-Change-Number: 1723
Gerri=
t-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 22 Jun 2026 15:25:05 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichten=
held <frank@lichtenheld=2Ecom>

--rLZzuJgdSuo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1723?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723/c=
omment/c5cce27c_3fcac0b4?usp=3Demail">Patch Set #1, Line 3130:</a> <code st=
yle=3D"font-family:monospace,monospace">    struct gc_arena gc =3D gc_new()=
;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">``` [=E2=80=A6]</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1723?usp=3Demail">change 1723</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1723?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1723 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Mon, 22 Jun 2026 15:25:05 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"displa=
y:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>

</body></html>
--rLZzuJgdSuo=--


--===============6978534968219771941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6978534968219771941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6978534968219771941==--

