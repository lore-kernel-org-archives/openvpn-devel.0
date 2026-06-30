Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28142C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yLkKDdFFSk3htzsSF1HswRp6LxnlWA8y0NaQ1dYRUNk=; b=O7Y61VDC15eYdIBoq6EGD6shUe
	kstkc4c+BQwC4plOs8tI7y1rVYTHnikNQUVIQ+jERz7bvFcpgOi6EM3lKbzRzifx9kWWZt+lsF1uU
	3GJRtZn5GLPa/LS+wfKq+9MWJmyxzEwgoq8UhBuW+pKTzCibR6Xn5CkVUrwX8lBVT1Ec=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weXBg-0005Pf-VN;
	Tue, 30 Jun 2026 12:03:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weXBd-0005PX-IE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 12:03:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=spO8Hva5eDa0HfjgiR6Wli5M6WCH6bOYEoiW46v3iDU=; b=ejqiNpmtDocmLgVGkHFrR/wMZc
 e9W1yaJ8E6IczDpLbxUqR66aGvEoLz6Jg/yBsyAxiSqqHxL117X9A316maF/h9k0K9v/ARnRhaJC3
 w3aFaSagbZ/s49rEVRhdJjiNIEmMRhUNzk+BqfOgv9DZqnUN/EyMTs5wVpMQueWO7F60=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=spO8Hva5eDa0HfjgiR6Wli5M6WCH6bOYEoiW46v3iDU=; b=j
 Ir3dayCQRR0/+eNMJSogO1TbdTwv+ewmtRFCt8RFqaO4eN9Y/OluFBRJIwm7GVWX/NkwrYm7wbZDN
 1/kCwFLVyPzC8vbX6r8N1JWjoQiU/gJgj/DJWoVrpRg4nO++Wb4GnYUkuIgtI3lrbf2qoxxpj5y2W
 EUevz/GXO7/xVQD0=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weXBE-0004Qn-Qw for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 12:03:32 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4924593f45dso56588785e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 30 Jun 2026 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782820934; x=1783425734; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=spO8Hva5eDa0HfjgiR6Wli5M6WCH6bOYEoiW46v3iDU=;
 b=b22hLOD9xBSEkP3/nUFGNGPzWwUWxm63Q3EDaFMUX5Y5rTyyFS+uO1PEEyO7nZimcU
 TmvXkBLVK/UcT9NCzJyPAzii4U38e22yOIDxIf70L6R/sSO51nIEZBdT+3/x1F0C1Qz9
 VTJZ7mhZrdDhpAFWITOTwhGSpCRYDbrhD/w3oi9B3QazOzt/bYVc0Qob7HUwROAkYETv
 lN9wGZWrpsVQNhNQrD1RSnS81IHUD1uRvx+vfkUt75UK2D2aXb9GKxlUg9NmLFEf8PCh
 FSkhQSUoQz2eABAf113I2Ffbb0Yhu4NOY/eBCN5hYX0FziZVIqQxHPdacBXQDQRJN/58
 qmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782820934; x=1783425734;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=spO8Hva5eDa0HfjgiR6Wli5M6WCH6bOYEoiW46v3iDU=;
 b=GMK7bN/2PAw1HON+vWrNZfYesZhzILI0s9utkAm8j6fZzwWCh+ZBmKqx4/whA8PKbU
 ppdLjEuW6SMpoZNgpALneJOhE8QgSRj2TZ5CFoFDl/449E0+caKDsHCZh9mBHd6ClTj9
 SEu+kA8/iDEAns+Os9gI+/2OJC/Y7WQNvAhdiLhDw11EuH0fNmnwcJxCzTbBwdRLZzXg
 +lCll639fORbiQ6au8LKtX6rH2lV/yvy6NR74zsn0PZx2AZ7Dm2Bf+FGDwGLMgRd5caF
 UkaK/R3ZbyJtEuNm51njR6KrcethsuYu5hNOPMOvWc+97lIfFG4F7YAFMmuyXVNho6Ho
 T7VA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9k16TPJ0FaikGDu3s5vdzUT7Ugs0EAEXHqpuDAy4sbKA/qDUKOL6JReXIBmR1rUc7SlzaNhEdJbGJzinbQ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwAY0uaZThh/BZRFj9V+3K9bHjZaWJnqoPoKQ3bawsQWZY1qh59
 rxlYI+3AWpvoEzj+/AvNeKHAoUelSX43nWim/3xYODN6f5nUwFiNtey7MTRUs3+wS7ysCSovxNQ
 d6JvOz7O09UZUmJ4I2Hvatg30Q5lrDhC3+uOcVjoV6fe14I9MuvuzgUx6yIEsTcUTKzV9
X-Gm-Gg: AfdE7cmjI909iTbxtTSrIPY+3/PPhAz+NXtOeR/qRvmL/RAkx/s3932U4tUHRYqO57n
 PdXrmk+zJ8Zf7wpUUOnhd7OJKYFELvuz6mOjsJB+d0lfKd37ivrPvqQU8sBxuMf56WgdiUWFndV
 nMevI4gYip2ufwIJ9fsms8Q1HT2jxQlVE1WrtRNaQyLghgIUz2eyueJhYYtz8ECigpN0B6d3pwg
 ktiQMv2d357lUa7jmVn3G5Khvix7iHTl0Kbjq6jTUVvUIfJIoXs7PwYjS+09dPiPJIm8u0JCxho
 a/jQHp2+HIlIGWxsjfluK86+ANgqmUskEnVLeL741cU6sFGZy5rVpOn9G8cx3IAdY/t2YP0+O7+
 FMjXN/id/4qE6xv1yaukXEjG4o2KsC4e6GMrZ2/vGdWrsGSbA0WGG/mAeIl9PkGJ2VURuwMXDG7
 7alUfDUvWBeMKLUo0yaUv4PCQgw1C9Tr+gbvTu021j78FWv6cIw8F23lFdmRme/JZeQWbm7JY1i
 A8x/86hDs2Fu6feRaKOue10y0/rhnlXtpa39wSmc4blZ/M+olsUh30PlkHBJtqworPg0D++GluU
 w99nw6ocsspiWA==
X-Received: by 2002:a05:600c:a07:b0:492:3da4:81ef with SMTP id
 5b1f17b1804b1-493bda6fdaamr4227245e9.18.1782820933490; 
 Tue, 30 Jun 2026 05:02:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bb4f174esm28185115e9.2.2026.06.30.05.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 05:02:12 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 30 Jun 2026 12:02:11 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: e268a6167a01da9be34af5193ec5ba8a5c093e82
X-Gerrit-Comment-Date: Tue, 30 Jun 2026 12:02:11 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8428b0ec3dc10add58fffb0f8eefe302f738a5b9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weXBE-0004Qn-Qw
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4012212290922593283=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4012212290922593283==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="okFNhDXRzPo="; charset=UTF-8

--okFNhDXRzPo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add control message T=
LV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

File src/openvpn/oob=2Eh:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/d13a7f25_6ad9b312?us=
p=3Demail :
PS2, Line 95:  * @param expected_msg_type  the message type the=
 payload must carry
If you document one parameter you need to document all =
of them=2E See the doxygen buildbot failure for details=2E



-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437=
388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <l=
stipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Comment-Date: Tue, 30 Jun 2026 12:02:11 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No

--okFNhDXRzPo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/oob=2Eh:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/174=
1/comment/d13a7f25_6ad9b312?usp=3Demail">Patch Set #2, Line 95:</a> <code s=
tyle=3D"font-family:monospace,monospace"> * @param expected_msg_type  the m=
essage type the payload must carry</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">If you document one parameter=
 you need to document all of them=2E See the doxygen buildbot failure for d=
etails=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603d622a=
7be14be369437388268 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1741 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Tue, 30 Jun 2026 12:02:11 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>

</body></html>
--okFNhDXRzPo=--


--===============4012212290922593283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4012212290922593283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4012212290922593283==--

