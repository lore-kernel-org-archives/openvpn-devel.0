Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0EDC9830D
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gRygRF8jsL9YKwIqa1J7T/AGb6llSdLFfrJvB/StBjQ=; b=VMLWJFx7lmu6DwfKUhH4ci1b1j
	gbh0YMvzWsM5ZBt3OACt2gI8i2vx38/GRBr3ivwLfxrNyyf7WfbHQjmSEwgfa8kOLPBUIIe+DYXKK
	jo+uaurNUWM+K/6E5Xm7ey+z5mf/VPNtBk/zi2Fom8GXFv0nDVzO+HjfMtjpFzBvA8Gs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA5lL-0007R6-L4;
	Fri, 25 Sep 2026 13:14:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA5lK-0007Qy-VG
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 13:14:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=R5GLhB0sPOiQi8ra1QapqJwPMTL+2pQcqwOawc3Ur74=; b=FxxXjk7b0QuOrWZ07u2XWkcUzS
 JRzEDP3kw/xxcv6rwNvV6qPvCyKJPKyjyUeZw08x5KVgQctOe1HZqxgr6agLJWi+KztLjIIG/cpwQ
 E/r16sbWy5Ekj36PARHwUWbUA3kFJsNqb51qlnxwLlhWe6PbEV1xgix5W2yh5YHVKAWw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=R5GLhB0sPOiQi8ra1QapqJwPMTL+2pQcqwOawc3Ur74=; b=h
 chPcP1l0o1nvmArERjruUqej1ORJ3WQ6Rc4EtIo5RXf/Gx0+hPC8RjfH3k2Kii+ciLosu8IZj4KW4
 CFXiJOB7gV9UjNIYQZMLdb19JmNYYG4OJaY1ncFSDF81d4FAX/jRurZbVJo1APWOjg2j0JV117M0z
 bZUqLk5jwwMfApHI=;
Received: from mail-wr2-f41.google.com ([74.125.225.105])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA5lK-00061F-BQ for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 13:14:51 +0000
Received: by mail-wr2-f41.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so510903f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790342084; x=1790946884; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=R5GLhB0sPOiQi8ra1QapqJwPMTL+2pQcqwOawc3Ur74=;
 b=HPFTNzQVUAZ0UInDrOAri+q/FZR8tuwz6gntKZLQEMCOqhTb+X5rwLU0+gKZwZfqso
 JtwE6WEC+YnEl7JgFz4wHWxGfazgejoU6CH4WG/X+C2rqdh5utM8i7ZFVlHObx3JYn+u
 VzFn57NPLFWs4pdjC0F824QSXNQ6fjI2fxHxB8hwjDaJQ8Wr5OaWdD0kTMq7Gl0biLRI
 J9BD1in9x98PKn8a2g7+lXkLcpEH8L7eoc30/ArCBDKaNBl5zyBdl/hgWsUI2Qrc36pQ
 CLowpBKaLL/pIccsPh9jhT2qptS5Xwd8YOTd4VVaB4yoV5ZkR/0PR+vc7D2rld3NoZ01
 UIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790342084; x=1790946884;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R5GLhB0sPOiQi8ra1QapqJwPMTL+2pQcqwOawc3Ur74=;
 b=QH4GMWz5qMIMdwnTNP4kUacfHqVTjMYSw1T5HdP0RoI2OiT9lsVlI1gSMbn1Bwq1ms
 UXVZmOgLjBa8g+M5cvCYbqUs+/gE+4zyzt4YVbvO77a6ar97m5JmerSQkAbc+U4SMuNV
 E+s8lHXRXN3PJ6V/VxYNGlnifO7OYlDjMtsZTtWjX0MsAg6Fz3XHuFpH2cZ4hM7tnVky
 TUDwEr/4s+nevHWp+wwkdyUjBgrp2/IAxnqDlLC+xaP3sj3+0qc8tmcLoEwSufY1jqnm
 uhXx2Svtij/wleR+ikCgoLLbPqGld7cpvygwANekRuKzSIliOn16YeT3T0k+5RuzDV35
 C09A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwP+gwSN3iL57PVTQzZzh42RBIVSSlWSlmbK4Ihffy9IyAwN1a+iQwFnDOIBzGiauP6W7Fk8VTR/Ok+eVVQ@lists.sourceforge.net
X-Gm-Message-State: AFuF++mqqE9uVOU0t9GY5mDvXqaEHcBxrU66Uz2uwi7M0YLLGbIsCS4S
 FUXVBBjlPbErOcx3gFf0LgVOizorX9KSngYTf6zZ1uO8gtCHa3Y89lsjs3AlMRGnhmm8HCJWy0V
 0NvFBvnLyyLfrmtnakZvE7NC4fKaWU6r5pUxNu1S2NrmKqzi9Yt+ATY3uToLZsRkTHxvY6e5jV5
 h6Alg4/w==
X-Gm-Gg: AYBFou320tRMq3zWCKXGOCISJySKhhZoQe3ZyYFwW7Y5d19Ij3p0cPG+09WLiqk2/6n
 qkwGE7YHeO24adDc8MXJJ5HRn5SgtEhBSCLNLGjAEHEhg3MUhu1Oh7R1l8jBbYBB+p5J0S2WGn6
 c4a0DsZx8p4OKuXvaBU+20NYJJIEchXM/538PWTkKDRvHhf+pjhLR4OJRgA/36+1WCDQUjrDGsn
 dQawkgf+wJIMsQuboEC2Sc3cRBBbZHOBLaO66OBjm7wLx0zFNRsK/WO2oQ/KrqxAYL2LzcXb2o2
 HdyvrwCmRfweCxst3z4sUwWAYqOE6eX7EFvN5ejlabQqHMI6DsfFb5r4dU0F+dJxH84zAnZdOES
 kvMUvqqyzPuEidA5poY75RrhBF8OMp1C1YnfnF85oRyUP97qUW/Dn7/+ij+zKjFXutlyDWEqRY9
 FTzPKuIxOMa/nCOHCmtJEbrj/4iplcyfo1CBUDCR24H1kRDcouRW7/WAOTVe2GkugXdBeMVh1Ri
 JtFz2ypJC++cO4gOW1xPOr1g0fkLmFpVBg58W7+jfC1rmMzwenYdBvldPWmzaQ3bzUBmAKrPTZ0
 8OasNHo49YPy5BKzXGV6R1cOwEwRBjNknTJ1OzhwWSbq4qKdiGUJ0gWoiW2A
X-Received: by 2002:a05:6000:2083:b0:487:27f6:a4e4 with SMTP id
 ffacd0b85a97d-488716bc8c3mr9116852f8f.52.1790342083613; 
 Fri, 25 Sep 2026 06:14:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ed6esm7826917f8f.29.2026.09.25.06.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:14:43 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 13:14:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a
X-Gerrit-Change-Number: 1738
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1738?usp=email>
X-Gerrit-Commit: 235e8730afd06d8b6cd75d8422c2e64089d5ffbe
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 13:14:42 +0000
In-Reply-To: <gerrit.1782693360000.I46a9ef71359f42395d69cf899c948014fb72f65a@gerrit.openvpn.net>
References: <gerrit.1782693360000.I46a9ef71359f42395d69cf899c948014fb72f65a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNjkzMzYwMDAwLkk0NmE5ZWY3MTM1OWY0MjM5NWQ2OWNmODk5Yzk0ODAxNGZiNzJmNjVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2b67a4ad38207a7abc5fabd314fd4cf76de34e4d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA5lK-00061F-BQ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: drop the
 now-redundant __is_locked re-entrancy guard
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6415203541353320154=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6415203541353320154==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o/rPqomfiho="; charset=UTF-8

--o/rPqomfiho=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

razvanc has post=
ed comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1738?usp=3Demail )

Change subject: dco_linux: drop the now-redunda=
nt __is_locked re-entrancy guard
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1738?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a
Gerri=
t-Change-Number: 1738
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@mande=
lbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ordex <antonio@mandelbi=
t=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Co=
mment-Date: Fri, 25 Sep 2026 13:14:42 +0000
Gerrit-HasComments: No
Gerrit-H=
as-Labels: Yes

--o/rPqomfiho=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>razvanc has posted commen=
ts on this change by ordex=2E</p><p>Patch set 3:<span style=3D"border-radiu=
s: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-color=
: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1738?usp=3Demail">View Change</a></p><ul style=3D"list-s=
tyle: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1738?usp=3Demail">change 1738</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1738?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I46a9ef71359f42395d69c=
f899c948014fb72f65a </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1738 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div =
style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Fri, 25 Sep 2026 13:14:42 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> G=
errit-Has-Labels: Yes </div>

</body></html>
--o/rPqomfiho=--


--===============6415203541353320154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6415203541353320154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6415203541353320154==--

