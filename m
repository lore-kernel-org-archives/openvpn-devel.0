Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96DFC4453A
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 20:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jv2swM8VJGErZQJpE94UKKhMmd2AwPEBk3v1eB1rJmI=; b=abLba+3v/1jxVSF3ssl4PRsV1z
	uZn1IdiaX4TX3C0lssZxFAFQbHkq6QC6l+2e1vIQ1k531UMr4bVdt5NymlUA8Tw8lVD6oUeA5oT6S
	+gb81dVeFbLPNRhsR//0Tb/nI0lJXu0uIyZ2U1glsra6K33F9wDcXbKAVBzh4g0utMm4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmdsR-0004Lj-Kn;
	Wed, 22 Jul 2026 20:49:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmdsP-0004Lb-S4
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 20:49:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=u0XBlWU66z7w3wrbUGAY2qft4rAV3OVNNiYqf1DCY9M=; b=JsCGxfYo2vuXSFePLiFQyJtCgI
 yaQ4Up7bbATjM61YReryoXV8K/Nc1TN9G38klCz4Pk4aDw3gLtvXEJX8ih/9UckjVKhsgOOgKpBfy
 oxqT2h5PQHxXDku2Z9wbo0Dehz4aFbAfmsmahbaaYf6jIxEt3YfyyRWmpRWfmi6GjLEo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=u0XBlWU66z7w3wrbUGAY2qft4rAV3OVNNiYqf1DCY9M=; b=d
 4yjbo8u/C2Fl2DbqkaCMvC/M1A5wNQLDS9jqRqgXctV+GDhTuVpErh0UivL6sl/CVeMehmlZfzMbN
 0EP3mGSYnsslecsfXmY+ifgdv6cRL1FPB48K7Xd7G+VZMTBmiCLGRwEm4iTFJV5Qy+JGT+vqKMIje
 mePu+9YbtVsiGHtg=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmdsP-0006Hj-42 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 20:49:14 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954d383e64so32790495e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784753346; x=1785358146; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u0XBlWU66z7w3wrbUGAY2qft4rAV3OVNNiYqf1DCY9M=;
 b=IasNX72GXIx4WUyUZ+QFCVvrefrvngLQ2c03IlQ8USm7rmD3fDBDCEXKf3h39/gSeG
 CnJeh6FEsSKqSeDnfTNpImgGdjyHw5KvWJPNrO6LXFzkFL/mWloCgMwA4esMa7IKPS2C
 1NUvS/PQuo/XVXB+gewXG6NatsBW3KHRSS5qYlYPmnDO8YpUbWvbByCb1Nf7PX/6BM2q
 3xdnFRxJbo8hBoc6PkmdNkdE8bC5VtZUXIAitNgIK9KdGlmkm0IX4IhQWfrBMa15cly/
 1a/yZIpH6Lrf2miskEzV4gzfc7MbJmd1ziL2udzgLLPfq5n7e4Z50DNCLxxQHJtz43UB
 6H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784753346; x=1785358146;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=u0XBlWU66z7w3wrbUGAY2qft4rAV3OVNNiYqf1DCY9M=;
 b=lHyrQfYxY/i0OTEvP0mp9QhxhrCTbEC/2sxg8UG+0NRrlm6Rms45JvPrccQszsPZ64
 30nI5qTstjM02TOAZckPVcus0UIRdVDlsYMoLgJAfRCLn3ahEqtuZ/kdBR592L4e50+E
 8Yg5iqruRcpdw9eT8ALhaW4Aqeo5NZg+Y1Q90KGtgYpPJts+V/48ivLE8HE/2mOjIe91
 X7WsiC8TeMQSY8HYc60An+Bv68RAASTAjTuM3irnuHz/uS8WhkvHXLjQfxbbjgd/DU0b
 rhZe9cT4kMxBEakn6/uET9WFBNGT+lAWBIrdP/D1sGYd/af67DYkUG5M+GV0CxlygghA
 K3Ig==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQw8yU8p2KG9+GdStAtSm9LZp0qPw/HbN79EuI47GCRQ/zqoe64eeVCSm9ID3iCdXyLzO+EXZM6JCJCeiA@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxB6yuTnhwis4uOyNfl9GyJfCP9VcGdEXCDLCny/BEwEOQ/l56p
 ZQhJr1upMEbvha6IVc6irtxNWFdvayHjtFd1tKo4NE7SxS9I3k11zBq9+rDz57OlQ24q8jpFQ9C
 uCjHZ3TFzo2/apDBS9R6kPUJQB1MhGCBAGzvsJCeKNC5ruI2LZpkCeRtgn5/5TXELd1wm
X-Gm-Gg: AR+sD10G74Wh2yjRvwFrIyTFKd/VO/deOUbTbOcMY3Jkf5ip6Wtt4CWPquTSzkd4C8t
 5mfm6tWWFGIBPnzkHZ7sdOTPuChyx9dNHjGTzl9SS5nxfzEx/okTo76w5OAluLrgyT/4Xx0uWBn
 JMF7tHPxlKUTGbbGsXIJS+Al1Y3QBZDH0HyRrcwOK81dSDskoyp8Z8rDEKnNT8oG7peJc34fiTj
 4RiXqGf8PuzGRycznoCqU7meKzx67bpfNNX0zgTXe0PNLhFuDdFb6XfvlJOGKsufePNlB2xDjna
 w0RxKb0MS0UhDvuioDiudcYb3rC2sa+LPy6p31MhJ8aKsyKhL9hKykEvYM3c93XIIhwUGbL+mqk
 tv+20Zm4T3uDmXZexW8PNX8wh2UNzQ9RVm9RGCJ7yN84dhT1V2CMB3aO5OIMlVAR44Y9iu5I5G8
 bKkvNwHtnLBu5xqXWzfljl+6PHYwJPlgPscibOxtNgETBNtfpUMgoeex/Xg4a2Mk84ZkT7fsDuh
 yJcpfiUaS/bd2e8x8VeP2u9uwG+7XIj5uWGpeKP36P4W/5LrfSD0YJECqmbJ9sc81af/iID4lsQ
 ZIc=
X-Received: by 2002:a05:600c:630d:b0:495:4749:16a7 with SMTP id
 5b1f17b1804b1-49573cd03bdmr2411475e9.14.1784753346508; 
 Wed, 22 Jul 2026 13:49:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a63fb10sm97161085e9.13.2026.07.22.13.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 13:49:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 20:49:05 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
X-Gerrit-Change-Number: 1799
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1799?usp=email>
X-Gerrit-Commit: 4b80a129999aceaeb429ebd703f618a51775d955
In-Reply-To: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
References: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzE4NDQ0MDAwLkkwZjU2Y2E2OWVmYWUwY2EzNzZlYjllYWUwNjRhODkzYzg3NjgxODhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dbb121a95814b83335930c7faf16e2a87ca83758-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmdsP-0006Hj-42
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove --providers
 from --help output for Mbed TLS
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3843837318705825659=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3843837318705825659==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SP+Mh8oVl/I="; charset=UTF-8

--SP+Mh8oVl/I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1799?usp=3Demail )

Change subject: Remove --providers from --help outp=
ut for Mbed TLS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Remove --providers from --help output for Mbed TLS

This option is Ope=
nSSL-only=2E When used with Mbed TLS, it prints warnings
and does not do an=
ything=2E With this change, the option is still parsed,
to ensure compatibl=
ity of configurations, but it is removed from the
--help text=2E

Change-Id=
: I0f56ca69efae0ca376eb9eae064a893c8768188e
Signed-off-by: Max Fillinger <m=
aximilian=2Efillinger@sentyron=2Ecom>
Acked-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799
Me=
ssage-Id: <20260722163800=2E2474-1-gert@greenie=2Emuc=2Ede>
URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37781=2Eh=
tml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn=
/options=2Ec
1 file changed, 2 insertions(+), 0 deletions(-)




diff --git=
 a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 87218d4=2E=2E242=
4431 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ =
-606,7 +606,9 @@
     "                : Use --show-tls to see a list of su=
pported TLS ciphers (suites)=2E\n"
     "--tls-cert-profile p : Set the all=
owed certificate crypto algorithm profile\n"
     "                  (defau=
lt=3Dlegacy)=2E\n"
+#ifndef ENABLE_CRYPTO_MBEDTLS
     "--providers l   : A=
 list l of OpenSSL providers to load=2E\n"
+#endif
     "--tls-timeout n : =
Packet retransmit timeout on TLS control channel\n"
     "                 =
 if no ACK from remote within n seconds (default=3D%d)=2E\n"
     "--reneg-=
bytes n : Renegotiate data chan=2E key after n bytes sent and recvd=2E\n"

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f56ca69efae0ca376eb9e=
ae064a893c8768188e
Gerrit-Change-Number: 1799
Gerrit-PatchSet: 3
Gerrit-Own=
er: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2Em=
uc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--SP+Mh8oVl/I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1799?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Remove --providers from --help output for =
Mbed TLS<br><br>This option is OpenSSL-only=2E When used with Mbed TLS, it =
prints warnings<br>and does not do anything=2E With this change, the option=
 is still parsed,<br>to ensure compatiblity of configurations, but it is re=
moved from the<br>--help text=2E<br><br>Change-Id: I0f56ca69efae0ca376eb9ea=
e064a893c8768188e<br>Signed-off-by: Max Fillinger &lt;maximilian=2Efillinge=
r@sentyron=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&=
gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799<br>Messa=
ge-Id: &lt;20260722163800=2E2474-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg377=
81=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>---<br>M src/openvpn/options=2Ec<br>1 file changed, 2 insertions(+), 0 del=
etions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src/openv=
pn/options=2Ec</span><br><span>index 87218d4=2E=2E2424431 100644</span><br>=
<span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/optio=
ns=2Ec</span><br><span>@@ -606,7 +606,9 @@</span><br><span>     &quot;     =
           : Use --show-tls to see a list of supported TLS ciphers (suites)=
=2E\n&quot;</span><br><span>     &quot;--tls-cert-profile p : Set the allow=
ed certificate crypto algorithm profile\n&quot;</span><br><span>     &quot;=
                  (default=3Dlegacy)=2E\n&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span> =
    &quot;--providers l   : A list l of OpenSSL providers to load=2E\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span>     &quot;--tls-timeout n : Packet retransmit timeout on TLS control =
channel\n&quot;</span><br><span>     &quot;                  if no ACK from=
 remote within n seconds (default=3D%d)=2E\n&quot;</span><br><span>     &qu=
ot;--reneg-bytes n : Renegotiate data chan=2E key after n bytes sent and re=
cvd=2E\n&quot;</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail">change 1799=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f56c=
a69efae0ca376eb9eae064a893c8768188e </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1799 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fill=
inger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 =
&lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--SP+Mh8oVl/I=--


--===============3843837318705825659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3843837318705825659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3843837318705825659==--

