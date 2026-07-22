Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E53C44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=90ZC1wiPa4IvwPMLX9K8nuMNpxqtea+9Q23lEASdMCQ=; b=YgwL2s5ezODrzFYA8Evv4OvX9H
	T526l3t1o0SkoOKk0S+v5d7cFfYfQqDTzrCgjkY2NWTuesROQ0M+pLf11lOcgR/3bw+nIJA7sYtjK
	L09krFFHJmZgD2pwuec2WEIyqkjWZrwVvqHYiZLtANdNF7r1Df5snrVpc7OIJ37mIu8c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmVwG-0006U1-5a;
	Wed, 22 Jul 2026 12:20:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmVwF-0006Tu-6W
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 12:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8gcPeMYiqm+//8Ield8Ym8ZtNH3+kJL4Mgp8Z1ExWY8=; b=KUAfC4WmFuKV//FUlOQxxGS8Ml
 26whA9S9NsHmQLDhN0dK1i8XrOByou+S54hcMM4WSTrRsP797pjEpGdd+7F8nzNT3MXQxQlH8br/o
 vwGi9PmSupDI8a4x1fptGzvvuk6ak3Rb6YPkyC4mmyGooavUCAPwzInBIoEnqQE5hkaU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8gcPeMYiqm+//8Ield8Ym8ZtNH3+kJL4Mgp8Z1ExWY8=; b=d
 zEPY9h59pkKFlEnBzacHyQs89kEMG8t0cq5V4tuSWLVowv2fJEe3P2NhfPpBQs9YHB0TQHenZs9C9
 Hc/xJ6LtyJYM0EOXucfTMlNE7eAyHW/vmX56oHNbz30WCkSabqZrrfgNzfXQjqkjI1JNXmhqP/JAm
 J6nz/erVTv8Ep448=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmVwA-00049e-OO for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 12:20:36 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47f7854678bso1041781f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 05:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784722823; x=1785327623; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8gcPeMYiqm+//8Ield8Ym8ZtNH3+kJL4Mgp8Z1ExWY8=;
 b=G+z8dUeaFNAlp02mpUmuYWQKz3ErK79hIS7m2fYWMl1HK5tXCnVMT/j2lHy4hc/pnr
 NgWPvrqEJYGCYB9N8Io2ZH+cM73dd/WblPXMjjU4uVJ5J5giPTOnNqmV+/Q1aEXYfp7W
 /StxMBR5TQDDlVMCYCJ5+hAvfCfheuzfbXjMUduPugZYYC2o8nT5yvoqguzM65SaxGvb
 Vz2jfhzoHK8TyyX+4vJX3Per94zhQX2Pr12wd3UJSQucOu0hX5oyT5vs+ms8iZlU9t0p
 vM0nkey54wmyUa+1je37r/YZQtGYw3UXQNeGQUKFBY3MwhI+6gATVKMmVbKZjzaUGNYE
 5lSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784722823; x=1785327623;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8gcPeMYiqm+//8Ield8Ym8ZtNH3+kJL4Mgp8Z1ExWY8=;
 b=CdhjpDAUo3FzNoB4AmL9uEHc4E4PH6X+MPI910QsFWuDtMFaeisjyA2KVohEZHIh+J
 Q7msnvawGXoeUJkZ64STYBnIK5BMSQ7MSGKkW3GBFv0qR7tMFKvpqIBotrzr7CukJqP0
 IBbsd18eAzGu4x2q2mq7Fx67IVemyG3PwzrQX10G0YFr+pE7PuZxnk2gAmSy+gXIS9Sw
 sOCYsLo1Xu9KcoslgU2VT7gZE8egoYHw87E3roprQzZGXSjCsxSnu+r0NpRD7kMFBhoH
 gngQJrpbfmlmNJ+qW4OL17Tbn4NcxkNSIx0DFcBXyVjcoB9/UFMPtWzX0ZLI1gMfA+K0
 EmWg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNJ4LJc4HLYgHTHyLxBuXlbwh3378nXRtSF/sf3lhd9OECkiqDOERInYvGLhF+6zhzK6hEzznMOojvuZeg@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxqiEHEpNjlTVNQWXfElyb/wUqolVS5bOwhQRjE2WQKLwlI/KWm
 CJSXFH0aFJ2jdMLrbILM0mRgY+MjgKJC7obJ2i7j9skgjJCpc0buQO4dJoIDwqq0ZBhNs3HwRoS
 2gKZXltHK6CG0GJMDsVcbSZeEniFaGaOalnBw6E9D0PLxxzcSr/Cb6gjcY1tB9yz0ab7/
X-Gm-Gg: AR+sD11+a3AQlXiilWYj3FWVseUoPQQ1FDlQoaq9tXfzE875hiJMANXiUAZtrL0koTL
 MxCV73o/Mn5+6J4cSn455dZGHn7IzptugR2/WSEPXOSSj2iZ+jMqODw9LVafoVfUE3W4Tc0Gih/
 LzeU/GWyPlYMNrmnRGSajGhRLz1TyL86IgG9itfNbhAWS5f2k+rZnwEx+BE9qawnEw+4zbIpiJR
 1vNJqEbBcI7J0YOf5BNkEZUMuqlJ6zN3hx8r/6MeQhTXvnJeY2b31tK6Nqx1tFWTv9kjTPyGLFj
 GVCKxDQFQ4F6tKReX7CcfEi5PkTi+jyMiSQOopXulLw0H7Jl0zPC705iS3Bx9L4b96O8ENEoH34
 qjWWRH/qJCEyySLr+20Z0XsGkM90A+pHyUJbbT9PDkVOZg/8OHkPUV0aQOLeUZSLNRbCuv9kmvr
 BTmA44SjM2dguFaQyo4lKgPvkGkfSixkqSD3/P1CSVxAdmabktK7/ziWn+qaXhLMbcqd9dQ7FMV
 qBLojZsmhlyA1UkB2L+zQu+4dz8coFyyKxk0ZI9h9okhOn3cfWcfx8xdpYwCAJ31KcV
X-Received: by 2002:a05:6000:2011:b0:47f:763e:e03a with SMTP id
 ffacd0b85a97d-47f763ee07cmr17001559f8f.34.1784722823002; 
 Wed, 22 Jul 2026 05:20:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6d277sm5911239f8f.32.2026.07.22.05.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 05:20:22 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 12:20:20 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 54a201ed40362a8b76d2b2c5f323057b556c9080
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 12:20:20 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5bfb5e10b37bd13a979f9502b2eb13f23947ad72-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmVwA-00049e-OO
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
Reply-To: arne-openvpn@rfc2549.org, gianmarco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2656700486216001068=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2656700486216001068==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="h6atIMwsTlQ="; charset=UTF-8

--h6atIMwsTlQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan, ordex=
=2E

plaisthos has posted comments on this change by its_Giaan=2E ( http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: mult=
ipeer: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 20:

(1 comment)

File src/openvpn/ssl_ut=
il=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/6b579e61_ac=
56b5e3?usp=3Demail :
PS19, Line 78:     const char *optstr =3D peer_info ? =
strstr(peer_info, "ID=3D") : NULL;
> It can, yes=2E peer_info also carries =
the client's UV_* vars, so something like UV_ID=3D=2E=2E=2E (or GUID=3D=2E=
=2E=2E [=E2=80=A6]
I noticed this issue and already prepared a patch for th=
at=2E That also fixes that for all the other peer info extraction: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Chang=
e-Number: 1089
Gerrit-PatchSet: 20
Gerrit-Owner: its_Giaan <gianmarco@mande=
lbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewe=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention:=
 its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: cron2 <gert@greeni=
e=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Wed, 22 =
Jul 2026 12:20:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comme=
nt-In-Reply-To: its_Giaan <gianmarco@mandelbit=2Ecom>
Comment-In-Reply-To: =
ordex <antonio@mandelbit=2Ecom>

--h6atIMwsTlQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, its_Giaan, ordex=2E </p>
<p><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Cha=
nge</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_util=2Ec:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1089/comment/6b579e61_ac56b5e3?usp=3Demail">Patch Set=
 #19, Line 78:</a> <code style=3D"font-family:monospace,monospace">    cons=
t char *optstr =3D peer_info ? strstr(peer_info, &quot;ID=3D&quot;) : NULL;=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">It can, yes=2E peer_info also carries the client&#39=
;s UV_* vars, so something like UV_ID=3D=2E=2E=2E (or GUID=3D=2E=2E=2E [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">I noticed this issue and already prepared a patch =
for that=2E That also fixes that for all the other peer info extraction: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=
=3Demail">change 1089</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1089?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner=
: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gian=
marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 22=
 Jul 2026 12:20:20 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: its_Giaan &lt;gianmarco@m=
andelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To:=
 ordex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--h6atIMwsTlQ=--


--===============2656700486216001068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2656700486216001068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2656700486216001068==--

