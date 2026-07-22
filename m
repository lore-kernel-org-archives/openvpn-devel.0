Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46191C4453C
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PWgNG1NpMZ3OIrVzc/RZ9xj2+/4Wtw5du+myBunQOi0=; b=QzKm2SC1LOBTEyvh7a+XJFNfHR
	s84qPHRnec1G7oBXn60Sw6eu7wzfiIU1VluHtRQ30VLaZKUqpIwwj+1f7EaTrOdFOT5iCBhvKfNcH
	eCc/v86XgN02CqS1JvD+PMK9Qg3nBP4dBDdaLQPw5R3UyN1/Rz/RHSa1J0YVn7lLPZn0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmZWB-0005dz-Ru;
	Wed, 22 Jul 2026 16:09:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmZWA-0005ds-OV
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 16:09:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VyxCGJ6OZkipqHEotk8VxiwiHSuEvTlTK6BDDG6/0qw=; b=HfKAZhyNAlHKF4tXIkRmycziS2
 7xluoY31Z915SJn+iWhiPiHBNiR/CJw8BzDJXHZwLLyVpH4gM2cYevtNvYqvM/RXK7iwqvsruw1hN
 /A5CRuo9grZYkQRaI01DK69LdidnOtc27lKW8/sJZLoiMehtmTkL2sC8ooxEgo+M/wPA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VyxCGJ6OZkipqHEotk8VxiwiHSuEvTlTK6BDDG6/0qw=; b=U
 AxlIGa9Ctkd7KN/3FwoWfQZvu9e7IrAVftnMrvvZZpFe7RYwfHfGnnsv1D6vdqiQL73AfXG1VVSQz
 T49FWA6R8nqcUptNgCZlNFpmW2G2Xua2dPil9VjdC119sYP+V4E17eUUKeTxWrRtEcycs8QEYaeBu
 JIEMMAr28VixVMlY=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmZW6-00084Q-Od for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 16:09:56 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so56877065e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784736583; x=1785341383; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VyxCGJ6OZkipqHEotk8VxiwiHSuEvTlTK6BDDG6/0qw=;
 b=UgVHLmdKGdtEn1hWkWRZVyzZX1fL/te3hfTW55loaJc7FTH3zo+C+IY7UFKzdhJV+t
 6lFKe+VFUjADYR56+BhiDUkc+A8At9tvc2uW4FxIOAyTg2H1kC7MvOzoYU1k5tX9fH54
 /N0IAwD8JklLN6/X7N7bmgZUYZrztWp3PWQIhd2vrm228HRaK5+rf543Qbj71a4iQi/L
 7hKON+r26AnKvXUQ2LH5nVsWzeRYLbRNZZbCr9e2307i+vP65a7riYRRxSXSsGvUTJcF
 4GAqJldwmDBwLlZcpZmmtObM5Vm9dbCNukwRrWyjc57dmlnRWyrbKJdyH5Ul2gH+LVF2
 7wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784736583; x=1785341383;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VyxCGJ6OZkipqHEotk8VxiwiHSuEvTlTK6BDDG6/0qw=;
 b=cTu648d+ojB3GaiAqodvyNWesQ/ykSaWG3CwXIjXgifEwwyMAnQK47tz8C2lB17jak
 t4t4WnCZvaKNakaGGtTn41m+TY+XJvB5pb5r4Nll5YmNjLF0+g+dJKx+Dy4bEctzoOy7
 1LYM1a8mjFFl5neBSlaI/tkzaT76wwbsRvisv4uHsNC15I4d0InUXzYVyNJwmbcDI6xK
 7oxxAMl1KtdptNtbqaBTH3zld3jq83kvEPYZ2ft9iQjjOmwaPJZO2sAwY0Xr4WsWh5vN
 g/7E364UMNlH0ERtSnne/uqiW5x0IqNiBUpSYICHp2bsShx92csy0mxzoLW3NLbQn34p
 nLrw==
X-Gm-Message-State: AOJu0YyG/HgOO34/nqxMypIzlbCon4FurW0Y8Wj645ZdD5C4Tx/vetyU
 POslYnhdZ9kPKiC477wrI6kCAysJrYVWyyWZ8MYcOFq9x45SKhmQRUaMmtc1dmSGZdyxnHkkg9B
 1DTKiXHjLE3pzeGyU9I6gnSseTe34JfCTBK7UrO+D9uQfoev8BwtCCTWbb5tto8R2SZ7wOhjhwc
 AADAGTSg==
X-Gm-Gg: AR+sD11aD9X98UBpvuFTK6K1c5W3s7QRESaj5MKNR7qKpXXhI3EtGYRFeaJ0qzgVHxh
 OL4RYnF866pIHkigFboIlIvVkjkVE+XEGJ7cba8Mko8PVYmSBKJz7dAXKPUCmCih+NRXUlHovmg
 w3bM9VfctldxmD0CP9b96HY22u7r+Uoge1WOnw1z2OMFvLplUYj3EYhmWkhK4s+kVdmSKtpC81E
 skU+Dicai2jfJ32YP/WOU0saBGgpgzhOZCfz2rMgsn9iidWvlHlFFjNv2lAX6xMLTLo5zrjgr99
 Lp3gIEiMkmvxVBztGxrkH3qYQoP4JlbOCDt+qT+uBJz1ij+fAhbtK4G7lx2tIhLDBA+nuaqcpYH
 /IuZPZsidjfwp+m8p7gNkK9WsXJoYcYdpLqtPcZjXrsnaYqcKZ57cpTNhqbTDCrUmKfKTTd8T8l
 CaQPvKXWfWHAxqFzaeyaQ6+lMOUqFOVTaBQ2lDr9PV72TQZU46oBalaiCKBdoPj4RosbCExPdyx
 /zbXt/gPzDsNZoaF3CTHor1Wxmal/oFtQFlxLq3IO4PX/5agWQyC6jqAriqq3QX+RwD
X-Received: by 2002:a05:600c:5351:b0:493:c8a6:b517 with SMTP id
 5b1f17b1804b1-4954a51bb65mr193072035e9.38.1784736583047; 
 Wed, 22 Jul 2026 09:09:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b03a93csm55887455e9.4.2026.07.22.09.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:09:42 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 16:09:41 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
X-Gerrit-Change-Number: 1799
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1799?usp=email>
X-Gerrit-Commit: 28c867778a91a651e3eed9974a09922536b958d1
In-Reply-To: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
References: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzE4NDQ0MDAwLkkwZjU2Y2E2OWVmYWUwY2EzNzZlYjllYWUwNjRhODkzYzg3NjgxODhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c6bea9a23dcda7cb631113810b3607af5664b0fc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmZW6-00084Q-Od
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3721584467309394003=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3721584467309394003==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8UjqOqBFDCA="; charset=UTF-8

--8UjqOqBFDCA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2=2E

Hello cron2, plaistho=
s, 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail

to look at the new patch set=
 (#2)=2E

The following approvals got outdated and were removed:
Code-Revie=
w-1 by cron2


Change subject: Remove --providers from --help output for Mb=
ed TLS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remo=
ve --providers from --help output for Mbed TLS

This option is OpenSSL-only=
=2E When used with Mbed TLS, it prints warnings
and does not do anything=2E=
 With this change, the option is still parsed,
to ensure compatiblity of co=
nfigurations, but it is removed from the
--help text=2E

Change-Id: I0f56ca=
69efae0ca376eb9eae064a893c8768188e
Signed-off-by: Max Fillinger <maximilian=
=2Efillinger@sentyron=2Ecom>
---
M src/openvpn/options=2Ec
1 file changed, =
2 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/99/1799/2

diff --git a/src/openvpn/options=2Ec b=
/src/openvpn/options=2Ec
index 87218d4=2E=2E2424431 100644
--- a/src/openvp=
n/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -606,7 +606,9 @@
     "     =
           : Use --show-tls to see a list of supported TLS ciphers (suites)=
=2E\n"
     "--tls-cert-profile p : Set the allowed certificate crypto algo=
rithm profile\n"
     "                  (default=3Dlegacy)=2E\n"
+#ifndef =
ENABLE_CRYPTO_MBEDTLS
     "--providers l   : A list l of OpenSSL providers=
 to load=2E\n"
+#endif
     "--tls-timeout n : Packet retransmit timeout on=
 TLS control channel\n"
     "                  if no ACK from remote withi=
n n seconds (default=3D%d)=2E\n"
     "--reneg-bytes n : Renegotiate data c=
han=2E key after n bytes sent and recvd=2E\n"

-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
Ge=
rrit-Change-Number: 1799
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@max-fil=
linger=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: cron2 <gert@greenie=
=2Emuc=2Ede>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>

--8UjqOqBFDCA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, cron2=2E </p>
<p>MaxF <strong>uploaded patch se=
t #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1799?usp=3Demail">View Change</a></p><p>The following appro=
vals got outdated and were removed:
Code-Review-1 by cron2</p><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>Remove --providers from --help output for Mbed TLS<br><br>This option is O=
penSSL-only=2E When used with Mbed TLS, it prints warnings<br>and does not =
do anything=2E With this change, the option is still parsed,<br>to ensure c=
ompatiblity of configurations, but it is removed from the<br>--help text=2E=
<br><br>Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e<br>Signed-off-=
by: Max Fillinger &lt;maximilian=2Efillinger@sentyron=2Ecom&gt;<br>---<br>M=
 src/openvpn/options=2Ec<br>1 file changed, 2 insertions(+), 0 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/99/1799/2</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/=
src/openvpn/options=2Ec</span><br><span>index 87218d4=2E=2E2424431 100644</=
span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/open=
vpn/options=2Ec</span><br><span>@@ -606,7 +606,9 @@</span><br><span>     &q=
uot;                : Use --show-tls to see a list of supported TLS ciphers=
 (suites)=2E\n&quot;</span><br><span>     &quot;--tls-cert-profile p : Set =
the allowed certificate crypto algorithm profile\n&quot;</span><br><span>  =
   &quot;                  (default=3Dlegacy)=2E\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_CRYPTO_MBEDTLS</span><b=
r><span>     &quot;--providers l   : A list l of OpenSSL providers to load=
=2E\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span>     &quot;--tls-timeout n : Packet retransmit timeout on TL=
S control channel\n&quot;</span><br><span>     &quot;                  if n=
o ACK from remote within n seconds (default=3D%d)=2E\n&quot;</span><br><spa=
n>     &quot;--reneg-bytes n : Renegotiate data chan=2E key after n bytes s=
ent and recvd=2E\n&quot;</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail">cha=
nge 1799</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1799 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt=
;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>

</body>=
</html>
--8UjqOqBFDCA=--


--===============3721584467309394003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3721584467309394003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3721584467309394003==--

