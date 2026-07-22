Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6FFC4453A
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 20:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AaiKi9jBxmB/VX1kLGrTpQbe6obNkW/WRelOYf/2Dj0=; b=PNUvzIe72ic4eszAmcZP7vT4Lr
	3PR9A7GBx/axcDgwTr2u3GEV2ghledGMnAqrCo2BaDrDuJUzh0UZcCtqFXsQuXPkVsKaPkNDY6nBq
	skuInMq3m/EqOTINOELVOLjGIoLrTMveYs6Llppznz1uRbhdjxtM8zoeoNLNnThgRbXo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmdsV-0000YZ-US;
	Wed, 22 Jul 2026 20:49:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmdsU-0000YT-7J
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 20:49:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UbwYI7OWr2bBRuVcGFA+R8Mft+UMjSoV6QWkGVow+Pc=; b=E/LScAfSVWS0XqJiGOnsghztgp
 zpv+TeJjDLmp8nqx3eeFHPRSf3vRVv/8PzRatRjiBC7zm43gJWmJwwtLiEOSKF63RvuNKaU7JTeLD
 EaFBVkuSpTenXrvq/zfRd+xwDczAVarV57lmMSU/f/IhBKs9SvO7WiHKYzoQexzWpaWM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UbwYI7OWr2bBRuVcGFA+R8Mft+UMjSoV6QWkGVow+Pc=; b=e
 ypl5VQs9JiF4WoQzzX5o22Ph19z/LP2RFu/YOoRfuAl1lUU6Vfkw9eBy54II3k+RRkg+yXiEihkRR
 iPjVUTU9VBtkXcfxps7kALRIyWJdFU39F1yQjMrJsUB13sG1TlJvkOYAfy91/Hx+OX3asLIxco8kJ
 RC9L7wuSlRIW4f+Y=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmdsT-0006Ht-G4 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 20:49:18 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so8992206f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784753346; x=1785358146; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UbwYI7OWr2bBRuVcGFA+R8Mft+UMjSoV6QWkGVow+Pc=;
 b=dlRHyrkRqxP/JFCCOSBNeR7VzYMFm+rRWyuHzFTClT0f4JchP+OaqIgsUoK1sD/HJS
 C17ndfB6ff+knmBcKeRrkJwW3nUNZFyiA8iUV/JdBWMQBM6RQEWFJ1/j9lAF9z1sbi/s
 58kFCSyA0gSBG2R4phGTj+Hvl0qHpX2cCU3yne2Yj2fB7vtgPIzfpRmD3wb/QvS0plHy
 N5e3I3Sts9/48Ui3meZ56hCRvEBwGhKw8+9vbisQiDKYn45O0hzqTEz4P6Q31mH0CifA
 by0PHPlgovqG3dNiGoGkXgE8n8dwXVZHkzg25ULFbNkfqlCiadHStiITJum1+Z4ohobM
 94bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784753346; x=1785358146;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UbwYI7OWr2bBRuVcGFA+R8Mft+UMjSoV6QWkGVow+Pc=;
 b=C2yg9SCvn7bEqdJVg9MzGO5iWxY5ryTLtqwPuLedCjxF3tkGzhxJWiIxPjsuHRaSmJ
 Fm9VHc8WtyuWX9/8wE6TemyWDpTg0HcBRxd7lmDLBo3vCzeCfc8UKzR0bN8OYMjO9Lwi
 NjIoWhioSWRFB4nX/hxtSdm9RHECfnvh2uAga76LoqHDyqdQtKU1tPqc+TV0Ki+F/Zwe
 YceruKqeDOvK8zbIqvWI54UKB8ecDXjJuLEw/XY0mwwcz6SnzGF5BAL1iY/C878aT32N
 AlzIclmFyaMq1SxNAkoKvPGFBmAtLYgHr3zJ9GbDiUusBiP/2214NLKH/SsBQlk1Mwgh
 c0ig==
X-Gm-Message-State: AOJu0YwEVowilyViCsfKr3Glb7BTA4M/W/9J7bvPYdpMWQCZYfcgXg2N
 9w20y+XUNti3E0yvU4B9GFUTpXtod2jWclAkPIwAPfxKxakTcHgC/hlKYbxmjKLGuLJUblr/tSr
 GUqBW0rrRvyidaPcMQDeaPNTrNSvIO4F7BdFyLwSOIY+SCpz6yNcg6N62NYl2URjuTk49
X-Gm-Gg: AR+sD10/1hp2A7IdTvhYIZz8dKmnghygizqaM0/2QLhO4+atNMlBUFgtrZb0k8Ihx88
 ZHLQ4/b4/tMadtLOEFpLxN8D4TFbAtD13upr4KRzzhpQ5XJXnObDLmw22ZiApsCN8phpY764zff
 jtXBrM638pTa61LmR3p7HfY0o03WaiRS7lSfCVyKCdbcr3VGuwIVehmaEAuEjWijEAb1dufsHt3
 h0TDgu104JIOUwMkUVubHjp1FZw2KcRKPczlu4Jauk5QSLsX8QvqcFzXu5JyExXhPmzPPSRYKYZ
 qeGfqdULcmNM+JqxlccXpY/zQijGzAP+aDotKFCbxpQiBwknUxZRhivIIGKQbCZR+Ejhtvd8kbB
 rkCw9MOAZYfSIPJJuvLFGxpLJvEyE/ag4UJYH7yn9weLdf9vkEmcTHnFxCOgWdEkqBiecHck20V
 GLrPkSlYeWS4GQuj2b4TUvDBY10a6cTuUi69SWG1m6a2u4BRWLT+PQOChLIcV3EfdTR7X0AZ33T
 Wt0O6Um+q3EWvLZUUwIedSwbwJNKbe6GYCksjmlKtrR01IWsGhGIcnMxOJdu0zS175W
X-Received: by 2002:a05:6000:3105:b0:47f:853d:4768 with SMTP id
 ffacd0b85a97d-47f8da6b82emr437662f8f.20.1784753345692; 
 Wed, 22 Jul 2026 13:49:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5d9sm8552254f8f.5.2026.07.22.13.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 13:49:05 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 20:49:03 +0000
To: MaxF <max@max-fillinger.net>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
X-Gerrit-Change-Number: 1799
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1799?usp=email>
X-Gerrit-Commit: 4b80a129999aceaeb429ebd703f618a51775d955
In-Reply-To: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
References: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzE4NDQ0MDAwLkkwZjU2Y2E2OWVmYWUwY2EzNzZlYjllYWUwNjRhODkzYzg3NjgxODhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dbb121a95814b83335930c7faf16e2a87ca83758-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmdsT-0006Ht-G4
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2487671871696567863=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2487671871696567863==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+0xOSLeyyV8="; charset=UTF-8

--+0xOSLeyyV8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail )

Th=
e following approvals got outdated and were removed:
Code-Review+2 by cron2=
, Code-Review+2 by plaisthos


Change subject: Remove --providers from --he=
lp output for Mbed TLS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Remove --providers from --help output for Mbed TLS

This option =
is OpenSSL-only=2E When used with Mbed TLS, it prints warnings
and does not=
 do anything=2E With this change, the option is still parsed,
to ensure com=
patiblity of configurations, but it is removed from the
--help text=2E

Cha=
nge-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
Signed-off-by: Max Fillin=
ger <maximilian=2Efillinger@sentyron=2Ecom>
Acked-by: Gert Doering <gert@gr=
eenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
99
Message-Id: <20260722163800=2E2474-1-gert@greenie=2Emuc=2Ede>
URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3778=
1=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/op=
envpn/options=2Ec
1 file changed, 2 insertions(+), 0 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/99/1799/3

diff=
 --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 87218d4=2E=
=2E2424431 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -606,7 +606,9 @@
     "                : Use --show-tls to see a li=
st of supported TLS ciphers (suites)=2E\n"
     "--tls-cert-profile p : Set=
 the allowed certificate crypto algorithm profile\n"
     "                =
  (default=3Dlegacy)=2E\n"
+#ifndef ENABLE_CRYPTO_MBEDTLS
     "--providers=
 l   : A list l of OpenSSL providers to load=2E\n"
+#endif
     "--tls-time=
out n : Packet retransmit timeout on TLS control channel\n"
     "         =
         if no ACK from remote within n seconds (default=3D%d)=2E\n"
     "=
--reneg-bytes n : Renegotiate data chan=2E key after n bytes sent and recvd=
=2E\n"

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f56ca69e=
fae0ca376eb9eae064a893c8768188e
Gerrit-Change-Number: 1799
Gerrit-PatchSet:=
 3
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: cron2 <ger=
t@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--+0xOSLeyyV8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by MaxF=2E</p>=
<p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail">V=
iew Change</a></p><p>The following approvals got outdated and were removed:=

Code-Review+2 by cron2, Code-Review+2 by plaisthos</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Remove=
 --providers from --help output for Mbed TLS<br><br>This option is OpenSSL-=
only=2E When used with Mbed TLS, it prints warnings<br>and does not do anyt=
hing=2E With this change, the option is still parsed,<br>to ensure compatib=
lity of configurations, but it is removed from the<br>--help text=2E<br><br=
>Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e<br>Signed-off-by: Max=
 Fillinger &lt;maximilian=2Efillinger@sentyron=2Ecom&gt;<br>Acked-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1799<br>Message-Id: &lt;20260722163800=2E2474-1-gert=
@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg37781=2Ehtml<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/options=2Ec<br>1 =
file changed, 2 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/99/1799/3</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span>=
<br><span>index 87218d4=2E=2E2424431 100644</span><br><span>--- a/src/openv=
pn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><spa=
n>@@ -606,7 +606,9 @@</span><br><span>     &quot;                : Use --sh=
ow-tls to see a list of supported TLS ciphers (suites)=2E\n&quot;</span><br=
><span>     &quot;--tls-cert-profile p : Set the allowed certificate crypto=
 algorithm profile\n&quot;</span><br><span>     &quot;                  (de=
fault=3Dlegacy)=2E\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span>     &quot;--providers=
 l   : A list l of OpenSSL providers to load=2E\n&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     &quot;--tls=
-timeout n : Packet retransmit timeout on TLS control channel\n&quot;</span=
><br><span>     &quot;                  if no ACK from remote within n seco=
nds (default=3D%d)=2E\n&quot;</span><br><span>     &quot;--reneg-bytes n : =
Renegotiate data chan=2E key after n bytes sent and recvd=2E\n&quot;</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1799?usp=3Demail">change 1799</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I0f56ca69efae0ca376eb9ea=
e064a893c8768188e </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1799 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--+0xOSLeyyV8=--


--===============2487671871696567863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2487671871696567863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2487671871696567863==--

