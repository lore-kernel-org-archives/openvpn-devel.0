Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8343AC88E40
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xK6jqnWPiIPtysCsw+lVicr1r1noRvNA2ZRe4rLkTuU=; b=fZqv5KZF1ZKbw0CYA73WxUizA+
	PsCaEHPun2yhyIBH2tM+T4KxExVkGN0zHoPWrSmCvKbzJn5TCX9lqSruxGaLT0CwtAMmCWCI8UkpU
	+fNECSs2+m5qrnIglbpR3UPA4CSs40/craNJ2GBFr+MQmIJm6U7v9LBkd3kQ7eUWm7pk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5h36-0002x8-2s;
	Sun, 13 Sep 2026 10:03:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5h34-0002wu-Km
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 10:02:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=aMSvoLYSEH1Q2pJ+SSKY4v96de98jSvjHMFdzh0PWpk=; b=MiOOyAj5wZWbLRb8Z5EkyDeIES
 0BdXjb0Bk3klYrcWHjPOfQJqY7LAeNnjSRWrMR48Qcj3MMMhHIzGbrrWNK3XXprrVzAB2mxqKktvB
 auXrZASc6F+w5zgndRMcOr3Lr7CaulPMIt1Q5BLjtaNquJyzD5Vt5TGOkt/3Fo13l2s0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aMSvoLYSEH1Q2pJ+SSKY4v96de98jSvjHMFdzh0PWpk=; b=b
 /rNoEoQ/51iUAGDSmrszClfAjwNLHgttdO5EmTKNc8Mgz8NlqbC+67DOC3+OeddsvUi+gy48J7Rf1
 +E+6HIATsJuVKub3EOgSGnsUM6WSfuOCq9j4J1GR/e5cu+dWkBO0BZOif8nUkl9fm/YcE9RfiOqKa
 t1935ErDDvcmOQwM=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5h33-0005Fx-3a for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 10:02:59 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d822dso7465345e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789293770; x=1789898570; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aMSvoLYSEH1Q2pJ+SSKY4v96de98jSvjHMFdzh0PWpk=;
 b=Zvo2u7iYl7xcGKDunOBUx05xQ5VFIbpm0sCeLQHGjev4Tk7nGsSo0LP9NisL0Z9utB
 iNJbY9PJ+7LOYhI0GCg3QYikNBoTtNsXC6i/cX5e+R0ukblT1qvp4dllh9za3zyghgj7
 c8SUUycmbxMGZjaP80NDgm0Ve4L2rUQOs0gDVvvqmE7SBhGwOty+1Cxg5NeqCv4rVOqJ
 sYjfg2x1zK4eH9F5HYnSjL1i4kpp7wSqq+It+JVdyEVSpSGB+vFZEe4lL0SSBZ548z12
 1qYOMXktw1iTECRBY+Yp9pNgkw8LNff8c4TWGHFsBBtd4LCeC+TgZ04FQawT7PYR/plc
 2xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789293770; x=1789898570;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aMSvoLYSEH1Q2pJ+SSKY4v96de98jSvjHMFdzh0PWpk=;
 b=o8GJM7J5s3dLFyXQ7v8/vI+DMYcZjqyujyMk5dWjBHm8I9OEF8uxE+9K/HdGrQw90G
 7GrZXaRePK+usXIG/Ny1zTmVxDo+5XfqMwkix8rAnIZeM8oO+5MwC6MXncsP8c1ziAg2
 WMKUVEx0HycZUSJGD2Z0iZNcCxjHFvuNAkPwZ4+pqMeypM5v8R6tmpGjtGNKznQqTZOr
 teQyeAF72FAxlPlTp5lhp7hcCk3POwIUoHnVTftV65mGPvszVwW52tdBFfu1GtgI/uZl
 RKQehTgyrC2L3BEeoFWfBaJxh3s+9uWolXpxnDX4TEQ72R1W4WbcP5eqjGbxhGjSkJiU
 qluA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxY1EDDxaBHlNlIQwDroG6yUOwy0Gq54jBFGI+nAL4w2dbHgl16pQHOLPFuTKnHFYDhqq6PXFpU6b2o3bkc@lists.sourceforge.net
X-Gm-Message-State: AFuF++mKY2THuJea6iu8QKLIk0deIzqASGchLfrB5bJ116jTGqUxsa3U
 IcRfms9fDcN1+YcnuKDSwmhHZOM+Ao9C5oMF6dD9bXk9OENM/jVcT/xEapMrrDUwdM6EFmuGIYJ
 /dExLj+SHJq9SKd6EqU0p+D4LzGo9uCyOtGjEj1BSSdWrL2pI2LvB2oqsSaZfROzpj+TL
X-Gm-Gg: AYBFou2h6KJMNP/kXurRgoePb8EmpFSci8G1L+IeIUWqOzCsZ091PbuNguAErVfyiFB
 OHAS66LnKsYeZg0JlQZEDWlzBb7NJZd2dSgx5KtngNDVEjVRBnBXk6cmLNeM2hN1w0w7VVu/7mP
 m9aQiypJPz7l8qEyjQu2weshSTFcYREUjVqYt5G0qjI9LG095c0zcJHs9LksbDEiDDzHKxCkIT/
 goCOgrOYL/wUqpC/H2fNXO4XwjTcTr3d7bxpVjIHGNdSBeufnrEXoRZXluaXTpB56s0xOnTizFp
 iXSAA9LKPXRgbsF8ip5FsblB7qpEK8sQI7I1Eg9PNhxHoThoKX1sFvsdjbDHQV8eYTPm8i5IXxn
 cJQvH+y2jKJF6oBuZZH1JkwV4MyBOTiTr+9702cl4L+eJgZRlKxiHjQ6T1yEbv4hjVY59bsyzbb
 KjF3B1qLT5BAKFv0mGoO0qLGGZnZhdqoyVdp/EgWuUZOHb4zT7LwXeslWLMOdbwEjhr4yBAvRgr
 /jcNsFQnOFKkn3EljNL0tB3IoGbICT4KUG500x+kKQy8zK/cVq8k/PM9Wq0fx7unuRFDB60+nR6
 SEiD1xiJCM5zTZstFQxGzWzXOzXgVjJx/wH9W5/cxJol1Y1+O5/ejLDy6p5E/A==
X-Received: by 2002:a05:600c:8b45:b0:49e:6c27:d093 with SMTP id
 5b1f17b1804b1-49e6cadab01mr59365995e9.15.1789293770515; 
 Sun, 13 Sep 2026 03:02:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6576122bsm283936615e9.2.2026.09.13.03.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 03:02:49 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 13 Sep 2026 10:02:48 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: 35aca022b11f9efa8a8f0f3eef5c632a9c52102b
X-Gerrit-Comment-Date: Sun, 13 Sep 2026 10:02:48 +0000
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <747eff2cf15d2de10370156ef14fda0ca0bd028d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5h33-0005Fx-3a
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1836948215980335352=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1836948215980335352==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NnGKgrWu/6M="; charset=UTF-8

--NnGKgrWu/6M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

cr=
on2 has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail )

Change subject: Remove var=
ious useless assignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 21: -Code-Review

(1 comment)

File src/openvpn/pu=
sh_util=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617/comment/1e30ed=
79_80442e61?usp=3Demail :
PS21, Line 134:     }
> It is not changing behavi=
or=2E The `else` branch did this: [=E2=80=A6]
Thanks=2E  I only saw the "`s=
tr` is not advanced here, so this is different" part, but missed the "the l=
oop will implicitly be broken in the `else {}` case" bit=2E

So yes, this m=
akes sense=2E  Will progress=2E



-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1617?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
Gerrit-Change-Number=
: 1617
Gerrit-PatchSet: 21
Gerrit-Owner: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbo=
x=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-CC: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date=
: Sun, 13 Sep 2026 10:02:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: Yes
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>
Comment-In-Reply=
-To: razvanc <razvanc@mailbox=2Eorg>

--NnGKgrWu/6M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 2=
1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #ddd;">-Code-Review</span></p><p><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">View Change</a>=
</p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/push_util=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1617/comment/1e30ed79_80442e61?usp=3Demail">Patch Set #2=
1, Line 134:</a> <code style=3D"font-family:monospace,monospace">    }</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">It is not changing behavior=2E The `else` branch did this=
: [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Thanks=2E  I only saw the &quot;`str` is not=
 advanced here, so this is different&quot; part, but missed the &quot;the l=
oop will implicitly be broken in the `else {}` case&quot; bit=2E</p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">So yes=
, this makes sense=2E  Will progress=2E</p></li></ul></li></ul><p>To view, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail=
">change 1617</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/161=
7?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1617 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Sun, 13 Sep 2026 10:02:48 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Commen=
t-In-Reply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"d=
isplay:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </=
div>

</body></html>
--NnGKgrWu/6M=--


--===============1836948215980335352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1836948215980335352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1836948215980335352==--

