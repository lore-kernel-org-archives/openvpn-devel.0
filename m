Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7377C98321
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 11:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bwHlMrV4a9YI9tnqTc1DDAOyxHwOrIx4ljGtxGnKw2c=; b=iEB0xDKQhj1tuZHLkGGTCW1Sqr
	e45pcCEzwxkD0ZeJfFGSgvnA7goJkpJOzb/GtXnlZR7IYSakM1p01jQH8d1f8d8J9Lq7UGuuem2IB
	w2r4J2mEsQITjIXEBBaTf12N4zuuGlW3eor1gMh2CPZUmJ+IH0lVlM7FocpqEWpHtneI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA4Ua-0004RM-Gv;
	Fri, 25 Sep 2026 11:53:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA4UZ-0004RG-Vh
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:53:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2GDzrfebuAa9A87dWwrL85XIw3EEX3Jt/DQf59y7bIQ=; b=PNcRQDh01mxs+4PigKsCZHAunp
 iTTLQ/s4k3ve14C2E4/nsNrZP0gLZIC17TfluxyAUhNwYEtj5pbg3XPaivfmtWHEOp16cduuwU9M0
 EHsB2jNeA11g6vbsF+Tm4KOEphtPfsYls03DLwnO4aBzg8qcg8Mtbr1IZPhLWFIwldLc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2GDzrfebuAa9A87dWwrL85XIw3EEX3Jt/DQf59y7bIQ=; b=G
 ao+nsmchPYjE+mn8C8GjjU1xGNW7BZxq9IbMBfvR7Q7MV3G/oiYkDmR+B1NSQ0b6j7odRbTtTu4KK
 euYmR7jrswBif/sYEjBh7fQpB6lYkbqomswR6jRPrDIx7pL41ImHTB7uuc4Eotx577YunGsLbCoB7
 IPk03uMfzWMiR7sM=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA4UZ-0004cE-Cu for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:53:27 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e620fa473so5018865e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790337201; x=1790942001; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2GDzrfebuAa9A87dWwrL85XIw3EEX3Jt/DQf59y7bIQ=;
 b=Yib1KnWSL7QHyijC/FloV316QCDbZ6wN1UH/uY9dj3E2Fwc7A8KOsfHcUHyPS7A1N8
 d9Z/Rmgp93g6QOdJ7ejJ73shYxcYhSP8tN9L+5Z6jP/qEK24xDJRvynSL0pFFKcKNyTO
 ws4JeW0SItU8EuG1SiBo0BMNARPODBI6L+yYw7lMK8UMQNh4aO37/OpoQ7eNPsBVZVjk
 lY3YqcgzvZBP6KqfezFkJMj0/kCjcFqBtOF5q2d67cGcgN4KnLwgHjzYy2Iqr8McM69f
 JivGHbFmasL9qA/7/luViy4ykal4lis42a/YvSPMjs16sef0OWjat/RVbMj/RVCzt+73
 3K6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790337201; x=1790942001;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2GDzrfebuAa9A87dWwrL85XIw3EEX3Jt/DQf59y7bIQ=;
 b=AXSfBDPDtNWc3/UkiSD3JCKF7x6wCBQe0EtfGqcXT9zGz82neVRzMLbHPjWujO8vG1
 Dvu5smwp2o0qUSf5Ud5JeBJwjdwDBcn16ffAtWayRyllNUrBRXmtCXTu2AVsjJqGVAxU
 X8ApkdwZUW8Q62kG3wqoPQgeT9oJ00c0iSoxXvy8JGmd7XY8Lpny4B9taCbYe46DxZ4T
 tP+GSZSM/Mm6J7TXI7y5k7XKG+JYx88cyY+j1QeP37U77AT9khBYQVo4zlPUHGmUVdPP
 mXL2wdwExwskDRiHOzmnJ8KCPEibqSKGvvm4fpBEIAYN0eQMp4TPRsw1oPxE+rY6zGsD
 OUuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqnaqTqolvZBsssNC6Dn4lqPH46JJP1Re0i8rqoU1G4rd/EbkYr/lDxkLn4WuOupRZLTxsv8fJVGUp6LX0@lists.sourceforge.net
X-Gm-Message-State: AFuF++n3fsWzo+2i29AyBzxGr6bQtIDDDi7dbVyoLmtup6BBEy+ux53I
 x/I+iwp5l3jKj++MiPta4mq1QIt8Cf8Vuh2T5SVFR5DU4tKgJSshJsbpiatgOzjROiNgjmJxEU2
 zGXoVYojum+AjCQtFQIX6x+rZt5GOUhFLZGy503kB5uV/st2GqZQ8YRgbB7qZstObw+9FPyM9rB
 xqX0urgg==
X-Gm-Gg: AYBFou0RQxcXPemNMfql1Ng+o8tp/50HJ4ZMDSSiHqrtpM5FkH4QEtvr+1LdY/i3WaA
 oNQ+/X/NtjhI8BUk4DVlbCpfYq21BKcQsl/OkIOn3RZ9KbdthUIh0aosfQ9xRTyN4p6G3MFnWQj
 acUh3SEYcUl/a6zKB9E9grG70qUneCjqo7c0CH1kUSJ7fEgRzIkg3V5YyE0Xr+HXeL9EeM5vS9u
 Q5FdCJbD5TY3830iK86ZVRiTS7MJIbnD4putYwFrhS0zKa/GXxdpb5/N48B2FnJ6b9+LiFjhSYB
 UfWTWF6R6j04ZbArYV+GJS6KCvdFGGmxEilYhow2r4JqPQgJpCdLYeLzHrZOrWC7KEquEbYpFDk
 XNbNTaLaT4tMaUEstgf//3vP5ElBTwluOzxBiOhwdCbQ0PORXfANb45nNnSoTXnAoCsWQJ0qq32
 BktEyGLp+3uhcwlPx826RcBa7bIAUVq0UgsNwaGa86YJtY3XOyfxm+0mRKv+0dWMJb73sNJRFq9
 KQdoREINsrtuBWIjTeaWmUEUO1ChKF9Re4Cx5Wt1TblHgwf7tqaZ0Qp1DjqL+JB1+yGW54iUW8n
 main/3aDDAZaAz3MdX4l5Ik+u3hlQL2yWH4SMmhNdjAsaVR6Hjf94rRx
X-Received: by 2002:a05:600c:638f:b0:49c:d26a:cf70 with SMTP id
 5b1f17b1804b1-49ff06c9a80mr34268555e9.15.1790337200746; 
 Fri, 25 Sep 2026 04:53:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ed6esm7257200f8f.29.2026.09.25.04.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 04:53:20 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 11:53:19 +0000
To: chugly <charlie.vigue@openvpn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
X-Gerrit-Change-Number: 1949
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1949?usp=email>
X-Gerrit-Commit: 57e9b919136ba4e1dac9ff6ca0de201f644c057b
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 11:53:19 +0000
In-Reply-To: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
References: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzA2NzE5MDAwLkkyZThmMTQ0OWZlNTRlN2Y2MjhlMmJkYjA0MmVlMmE1NjdmMjVlMDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cc75682e81813b1747e3fd75fc5e1cd9281db4f2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA4UZ-0004cE-Cu
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add an
 end-to-end test for --route gateway keywords
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
 openvpn-devel@lists.sourceforge.net, charlie.vigue@openvpn.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4842357798175534199=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4842357798175534199==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XYftLevd3s0="; charset=UTF-8

--XYftLevd3s0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: chugly, plaisthos=2E

flichtenheld ha=
s posted comments on this change by chugly=2E ( http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1949?usp=3Demail )

Change subject: tests: add an end-to-end=
 test for --route gateway keywords
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
As a si=
de note: There is a patch from me that adds netns support to t_net=2Esh: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1586



-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
Gerrit=
-Change-Number: 1949
Gerrit-PatchSet: 1
Gerrit-Owner: chugly <charlie=2Evig=
ue@openvpn=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: chugly <ch=
arlie=2Evigue@openvpn=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Comment-Date: Fri, 25 Sep 2026 11:53:19 +0000
Gerrit-HasC=
omments: Yes
Gerrit-Has-Labels: No

--XYftLevd3s0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: chugly, plaisthos=2E </p>
<p>flichtenheld has posted =
comments on this change by chugly=2E</p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1949?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">As a side note: There is a patch from me t=
hat adds netns support to t_net=2Esh: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1586</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail">change 1949</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: I2e8f1449fe54e7f628e2=
bdb042ee2a567f25e02d </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 1949 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: chugly &lt;charlie=2Evigue@openvpn=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: chug=
ly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Fri, 25 Sep 2026 11:53:19 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--XYftLevd3s0=--


--===============4842357798175534199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4842357798175534199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4842357798175534199==--

