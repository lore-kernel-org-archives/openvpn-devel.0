Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915E1C43602
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xSl4jrbL0r7NefkrZyXNm3qFF/iKzifL8nwq00XkGaA=; b=DmbvnopIfPdIiRB43KFxZI8hut
	88nlbj4wVn6V7MnpkcI2r7LwfS1LSxl18K9rN9gVCYfqFAnC7WZ5ESL3Zxg2ZmbI5MZy23sSFZoTZ
	5R8ldezEHYcHhU+pgWjmrfz4ZKiIBbeAKFYzcL5m0t/53xjXjtjCGivgIX8ZZMYlyi08=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfEmK-0008Ga-FR;
	Thu, 02 Jul 2026 10:36:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wfEmJ-0008GO-9K
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 10:36:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bSeCiq1o9UYnTfoH+HexBvfTzKf9ejqdcJDv2awq7U8=; b=VAY4oR8muil0O43XlwwuD0I+Od
 rebNKwqRAoG08j+/59cYCqrAlzA241OgG34PsngSelwqenBVFCn7u2e5b2ujmtSa8c7TD+EqelLWv
 CH75yELQDZSvHmObr7XD6uXzvBiHM01G7O9roUqs8yjauNoLTX/9/EiK+gIHr2gCHd6Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bSeCiq1o9UYnTfoH+HexBvfTzKf9ejqdcJDv2awq7U8=; b=Q
 B5qtyJqHkHXrcZOUy0tmL6RO1VRVHxeQKKNmN+B+cwfjE9KtvVK08Kp9u5ZL15UKCV22TBfgQxmnF
 o8lET1butX4zEsVyXfoyx6h+hv9FLkwK966zZbjzXlmh9WfS5xe69dyIjsyLrVl4zdq/ewDXMnx6T
 eQTYUd6U5K1JIwOs=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wfEmG-0000UO-Tl for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 10:36:19 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so14536695e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 02 Jul 2026 03:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782988571; x=1783593371; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bSeCiq1o9UYnTfoH+HexBvfTzKf9ejqdcJDv2awq7U8=;
 b=ZnF3ZMNGdA+aIziRuc/Bk0XYtiSBrcmLjs22QW1Jo7L7eO4Qeg5RvnnnmnGM8KGMSW
 97vWryBa9j+1arrx+I5ALjIFiLzvjgwmBkJQt8E8nbKOZbVHfSoRvy0zb3yUuLCAM9vd
 9l95Sy3xytwDoK1ifvjmYyDucsCOB+s+hZjw3Mrio+k92J/eS5VbBBe5/il5vJD6YOgo
 bIvH5n1Qm/Y0lSMpKz0uLCLv4gNhoIBZTZhoSzxEW/ADKc89ln8e907JCldHeOUAMIe1
 EpNYZdPTIKjKmXn9TzOy62faxo3CKrZxpoa+gGZMTMbCWzmcP4RkahnUluz/vJg/CnPa
 PTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782988571; x=1783593371;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bSeCiq1o9UYnTfoH+HexBvfTzKf9ejqdcJDv2awq7U8=;
 b=ZRQYSEpVLP5JwzkvANDOhEVUmDQkdz2MZhTj94eIpHYtoZtpnmJ3QsppC1nefTphdI
 7iM13H0JV1kau4MCdAOL9Z7b9ouZIZLvmqWaOU5WY+uk1j20H3zpkGKCbKp1jmxuLSkQ
 99S0Ug88huL5DJPjYbfKVWi2nlqRnsbtRV3qBt2X9riP3TUMSe/It4eh29vu/1d2Lb4V
 NAUCeOdAMJHYeYBxpSBimlqFUZPXLH8ydozztfXZrG4mUzytxV3/nhGTlYscu7ntk4k6
 doM2UkzXbNm0gzxjsvuKZBcW0r0xyNZsvHAq78lEuvQsj211H6c3h1xEhoQOZCdNZuc+
 SfPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nFgz4JuBw/ncvmBHpuKGIIkjWUh1u3bTgbKawxcHdCYf7hQqnEw+OJlygNQ6+ajCuKcrNtW2WMtexuS11@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyCP1YrihXhIVb54XwbUGdZlHq2rl9BXGBrCRQbRmck+Z3EHgp4
 YZrT2bY9gU8WKGpHbvtpP0+iLx6QDgOB6Ro1zut7zZZCJ0WHXbQPPOG4QGi0mrDzc8cDvJdXRmn
 fm7w9/r+IGZhKG8IHNNXmHWdbx/mGM8q+u1vZRg09VkyhD1q6fm5IoVlv1/Ish9RWb6Gr
X-Gm-Gg: AfdE7cmRm+b2/m9pPw47wahacjhm6w4aaC+ljLYedZ1xoQfbjEUor3cf2e6vRsWLB3P
 5zXEvRv6xKKWFL7PwY1xBN1R1gEQEzG+AfhyLxrB/l6XY1K6AyovLDcNQFVqXrkdsfhEZ2zh50f
 hhMgDIhlnk8VtumaLWWtkCTSplgMplG/E0CPqNmFUPGup+IBmetk557WVVHS1f9TRrh7zRK9EyC
 4mBRyDUARCxGd5QHzJQpyqd1yFaeZz1HtTl0n6lMLX1hZmULKaNMN55YvRXS0BXyyziekmMtO7m
 Zdt1k8YZqRZvgNukOv4UnASI0MQT9Q1x44iwQkGbWTu7zOWyr3476wci+dw13125w8aoAjksHI0
 VN221KtIWN9VoMg0ojXuRsf7Ssu9YO2HfwLaZEr3kNYgNimXgm5UHl6+4Cknk+LDwdfHlVE9eTG
 NoibT+hVKMgYxtxCSy2oI498DTbf46c+YCACUI6ihlqx8nAm77JBlE+7mBdazJ5nT3ewdhmQHG6
 +WJ0T4/S4ebGDlxr1dngZsphux4yPp0UEQC9pIUOfREjm2i/t92ZS0sEu8ZOUQS2m2W3U155rq8
 BUE=
X-Received: by 2002:a05:600c:19c7:b0:493:b750:bd20 with SMTP id
 5b1f17b1804b1-493c3cdd21emr61041625e9.15.1782988570767; 
 Thu, 02 Jul 2026 03:36:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c635c365sm35569215e9.4.2026.07.02.03.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 03:36:10 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 2 Jul 2026 10:36:10 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I20cc89a546b69aceadcd1630828de407d530d7c7
X-Gerrit-Change-Number: 1765
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1765?usp=email>
X-Gerrit-Commit: d41472de0144f3c483a8397dea3bb55f00dc57e4
In-Reply-To: <gerrit.1782986182000.I20cc89a546b69aceadcd1630828de407d530d7c7@gerrit.openvpn.net>
References: <gerrit.1782986182000.I20cc89a546b69aceadcd1630828de407d530d7c7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTg2MTgyMDAwLkkyMGNjODlhNTQ2YjY5YWNlYWRjZDE2MzA4MjhkZTQwN2Q1MzBkN2M3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f9062f8c184b407daeb33ed4e087048a00aa4fc6-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wfEmG-0000UO-Tl
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_pkt: Fix
 doxygen warning about read_control_auth
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6769838463541022928=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6769838463541022928==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rkpDomRwImw="; charset=UTF-8

--rkpDomRwImw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1765?usp=3Demail )

Change subject: ssl_pkt: Fix doxygen warning about =
read_control_auth
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

ssl_pkt: Fix doxygen warning about read_control_auth

Commit 01ee1693f=
960a696a613e7b83f9960002264a379
("Ensure tls-crypt keys are not setup twice=
") removed
the argument but did not delete it from the doxygen
documentatio=
n, leading to warnings=2E

Change-Id: I20cc89a546b69aceadcd1630828de407d530=
d7c7
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: G=
ert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1765
Message-Id: <20260702100704=2E24692-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg37459=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/ssl_pkt=2Eh
1 file changed, 0 insertions(+),=
 1 deletion(-)




diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_p=
kt=2Eh
index 640885e=2E=2E82cb5b1 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ =
b/src/openvpn/ssl_pkt=2Eh
@@ -207,7 +207,6 @@
  * @param ctx               =
control channel security context
  * @param from              incoming link=
 socket address
  * @param opt               tls options struct for the ses=
sion
- * @param initial_packet    whether this is the initial packet for th=
e connection
  * @return                  if the packet was successfully pr=
ocessed
  */
 bool read_control_auth(struct buffer *buf, struct tls_wrap_ct=
x *ctx,

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1765?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I20cc89a546b69=
aceadcd1630828de407d530d7c7
Gerrit-Change-Number: 1765
Gerrit-PatchSet: 2
G=
errit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 =
<gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--rkpDomRwImw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1765?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">ssl_pkt: Fix doxygen warning about read_co=
ntrol_auth<br><br>Commit 01ee1693f960a696a613e7b83f9960002264a379<br>(&quot=
;Ensure tls-crypt keys are not setup twice&quot;) removed<br>the argument b=
ut did not delete it from the doxygen<br>documentation, leading to warnings=
=2E<br><br>Change-Id: I20cc89a546b69aceadcd1630828de407d530d7c7<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1765<br>Message-Id: &lt;20260702100704=2E24692-1-ger=
t@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg37459=2Ehtml<br>Signed-off-by: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_pkt=2Eh<br>1=
 file changed, 0 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 64=
0885e=2E=2E82cb5b1 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</sp=
an><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -207,7 +207,6=
 @@</span><br><span>  * @param ctx               control channel security c=
ontext</span><br><span>  * @param from              incoming link socket ad=
dress</span><br><span>  * @param opt               tls options struct for t=
he session</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param i=
nitial_packet    whether this is the initial packet for the connection</spa=
n><br><span>  * @return                  if the packet was successfully pro=
cessed</span><br><span>  */</span><br><span> bool read_control_auth(struct =
buffer *buf, struct tls_wrap_ctx *ctx,</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1765?us=
p=3Demail">change 1765</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1765?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I20cc89a546b69aceadcd1630828de407d530d7c7 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1765 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--rkpDomRwImw=--


--===============6769838463541022928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6769838463541022928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6769838463541022928==--

