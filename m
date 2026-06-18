Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4661ECD98F2
	for <openvpn-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WbgN2/q56SOkjcshL4zDYaGJAhbh+6/z/YgppgLij8E=; b=DJlXmxxCEbOz+Tm/5vHpeVt+U6
	NnX6G0p3jqG/2j8QR6qSu4bif+e6v+vYSCIjAX1dDGKQRMBlzqD85pDNKPPp4M3RM0Br2yjPnVFlz
	bw6XAF48hOuaIGQZxMi4hXSliqIkTsIde/lFausoIINP3F2FW6YbKy4l88GeIeNQnkEs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wa8Ug-0007ID-2f;
	Thu, 18 Jun 2026 08:53:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wa8Ue-0007Hu-BD
 for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 08:53:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=apsuAxOHDMR53/yR/8I4DvkpWDZK4Kl1TfIe5mZ67hk=; b=dppFyCvtsLQBrhjdB4XLfhbjKj
 nwS+khc6ljGw91D6G7iFGWpCdQJgnkkFMBbVludQpco3b4/VPSVs1uxCKG6q0e3CbDPIooEJMyhsU
 pxx2VjD32Hl3ojQiqJJy2nSbioNSWKDDzP9DHpmviyipyLm4xT3evCogIAJW2GV9r6Os=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=apsuAxOHDMR53/yR/8I4DvkpWDZK4Kl1TfIe5mZ67hk=; b=V
 MDnMW3dTYavOxo2Tf3KrQzgEhu2nVUaJZbPmz7oZJE+fEP6x5L3CyH+0ingarQeih/xo5zwBxExha
 P7FZfqUzVwVBWZhFNAUYp1Q5L5mrUMBu0vFlC9r+yc0oMYssZ47ww3ioMH/fgoksc3cljap7KUHYF
 nCGKM/lOiHl8W8I8=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wa8Ud-0007Ij-6d for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 08:53:01 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4629051c946so504873f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 18 Jun 2026 01:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781772768; x=1782377568; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=apsuAxOHDMR53/yR/8I4DvkpWDZK4Kl1TfIe5mZ67hk=;
 b=Dzf3X80EfL0VRTUW0VPIO9HHQlFLSZpID8Y/7rGmJf7QtTqsvej8aqSZmLIOt57O5/
 +AOmTIXciVh5QCXnMxBQiIYEbTcBj++SGg0DGipNUO1CUdXTXSTTLknyIdXFSWiz2eif
 Dc+nByTcIcKQtU5jfa9QVGai2XN7y3+p4+YhNVBqp/aym6hZoLnfXA8ddQjJYtTM4swD
 qcIZ1MDlmrelE6tyL6tCpVf5CcK2ZyAPTRFuXQJLORxZCjKPZI5vETvYym4Uwg4FHg9A
 X8oiqgNelQXCxH+3plqWkjOS92gE8VvJVdOcoPkwc/IScdAB+KTCHCEh75ob48r1hEct
 Nvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781772768; x=1782377568;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=apsuAxOHDMR53/yR/8I4DvkpWDZK4Kl1TfIe5mZ67hk=;
 b=S5LA88Gd9lKn3iEH9ViCN26dV9RryFwM9a033zANTJOP5rXlYSteyk94iIfgRQsaWS
 zRC9wrhO6DVbysKjpbuy2CJPXS1OM6gJ1LhkbaXZRTkNCiAx277l4QLeKfJGwSXkeBM5
 WCdB4UTK5VHp5bq3FN41QmfKEvDdRvcqTVQ9opcYk64Gg698c2DHfrYRmvbrEK/6tznR
 GVPwQ+L4idqElKrW/f9wLehxEQxE8cAQ63ExC/KZPrIbHlwFZivfsWyrhF7fLUZb8G38
 GNA/9ZfK32Acyp5NPTNGAperhj+FUeaRf4xqwnjbWNuvARK/OoqR33sBsjlrd5bXvCyB
 Zj6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VK0Y8+vA2ddrrUf4BuegXKCRucLm+RdEUNrEQtu5QLZwjKPOfgtnfW8n7qWW26afpQmXhCQT30dbHGCqf@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx+5xtYqQ5PBlntUdId2Hn0+mSzs6f8J7sPi/kOM2v7N5hwe6Iv
 edo3f4mZBjarrDo9WxyD0W7wHe98WaZFo8XjrnDr+gXbUeFJ69F7Rx+nPdcfL7YfoxNIkrb1Com
 eIVsv60Zr+a5ZmSm2tx3D8C/GTXf4VnffVOxqk8i1XctZ2Lbd0OtPSWBLSxUyad/6qNEc
X-Gm-Gg: AfdE7clYuCETQZuCITfnnMWATYuemrWTqf+yDiwbFje1rjrlo4+YqawX9QJ7n2duGIk
 n8XKRLbtUAHSZzKpyENy5nGa57SMZ8lRPu1k3IWC8g1e98lCw/WDHEBa+JFW+cH0Y2C/hc++wWS
 ICGRudRp9Qj3EGPdpxbUYa7+TAU6SNfO8nfCn0cs5MYFyAwbCHY0OV8QsV6bTm+Rw2FZnKqRXSI
 7Ycv6BNTgTHvlhKI5x0TxkdwklDAjp70Bks4kk75Hvvgx0YJfu08yVER0DcS2ylgIFfNwATlyqT
 W5jo3E6s0WqiWR4REH/ainFeGpgxdj7rduIWsQEThZ/cq41DTcOw38YkebgkKw/wXtFUzFx0PtA
 NwylSvYRQdwdaM73Vf/n5X6rtyHLUMhq3KPdATsUNyVLQu9yfCzQB6AAnquyOqiOInW4DSojoZQ
 NiBbwOPmc1/c6eU6YbQIynb1QBtjisOQ+PF5xZC55Pt9Kfn3E4qRpguYBrRuOusGJww07z0pS4g
 AqAavN/dy0ltp0z93dd6GUoFeYzxu9zkfcuCwps3s/mVbgzbBnZHNXCeAWRqZya0F5hyk+F1x0h
 vR+7G/RUnEQJOQ==
X-Received: by 2002:a5d:684f:0:b0:460:5960:b16f with SMTP id
 ffacd0b85a97d-46396f127c3mr3452319f8f.9.1781772767045; 
 Thu, 18 Jun 2026 01:52:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619b9b7750sm33326947f8f.6.2026.06.18.01.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 01:52:46 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 18 Jun 2026 08:52:46 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ic9ac18f730e6035126ccf1cf19799548e5fd9316
X-Gerrit-Change-Number: 1155
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1155?usp=email>
X-Gerrit-Commit: 4e4236ded8ce8e7e191a5091d55c286c0071f341
In-Reply-To: <gerrit.1755879913000.Ic9ac18f730e6035126ccf1cf19799548e5fd9316@gerrit.openvpn.net>
References: <gerrit.1755879913000.Ic9ac18f730e6035126ccf1cf19799548e5fd9316@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU1ODc5OTEzMDAwLkljOWFjMThmNzMwZTYwMzUxMjZjY2YxY2YxOTc5OTU0OGU1ZmQ5MzE2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f0b19f2db280659c4c312d6751112b743311ce1f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wa8Ud-0007Ij-6d
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: Move <= 0
 check for keepalive settings earlier
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
Content-Type: multipart/mixed; boundary="===============8537615616312159157=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8537615616312159157==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZSysOTFPf5E="; charset=UTF-8

--ZSysOTFPf5E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1155?usp=3Demail )

Change subject: options: Move <=3D 0 check for keep=
alive settings earlier
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

options: Move <=3D 0 check for keepalive settings earlier

Use t=
he atoi_constrained function=2E

Change-Id: Ic9ac18f730e6035126ccf1cf197995=
48e5fd9316
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked=
-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1155
Message-Id: <20260514192727=2E31903-1-gert@gre=
enie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg36939=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/helper=2Ec
M src/openvpn/options=2Ec
2 fi=
les changed, 3 insertions(+), 7 deletions(-)




diff --git a/src/openvpn/h=
elper=2Ec b/src/openvpn/helper=2Ec
index 9e7ad93=2E=2E4c540a6 100644
--- a/=
src/openvpn/helper=2Ec
+++ b/src/openvpn/helper=2Ec
@@ -552,14 +552,10 @@
 =
        /*
          * Sanity checks=2E
          */
-        if (o->keepal=
ive_ping <=3D 0 || o->keepalive_timeout <=3D 0)
-        {
-            msg=
(M_USAGE, "--keepalive parameters must be > 0");
-        }
         if (o-=
>keepalive_ping * 2 > o->keepalive_timeout)
         {
             msg(M_U=
SAGE,
-                "the second parameter to --keepalive (restart timeou=
t=3D%d) must be at least twice the value of the first parameter (ping inter=
val=3D%d)=2E  A ratio of 1:5 or 1:6 would be even better=2E  Recommended se=
tting is --keepalive 10 60=2E",
+                "The second parameter to -=
-keepalive (restart timeout=3D%d) must be at least twice the value of the f=
irst parameter (ping interval=3D%d)=2E  A ratio of 1:5 or 1:6 would be even=
 better=2E  Recommended setting is --keepalive 10 60=2E",
                 =
o->keepalive_timeout, o->keepalive_ping);
         }
         if (o->ping_s=
end_timeout || o->ping_rec_timeout)
diff --git a/src/openvpn/options=2Ec b/=
src/openvpn/options=2Ec
index 62c0bbb=2E=2E8012192 100644
--- a/src/openvpn=
/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -6777,8 +6777,8 @@
     else =
if (streq(p[0], "keepalive") && p[1] && p[2] && !p[3])
     {
         VERI=
FY_PERMISSION(OPT_P_GENERAL);
-        options->keepalive_ping =3D atoi_war=
n(p[1], msglevel);
-        options->keepalive_timeout =3D atoi_warn(p[2], =
msglevel);
+        atoi_constrained(p[1], &options->keepalive_ping, "keepa=
live ping", 1, INT_MAX, msglevel);
+        atoi_constrained(p[2], &options=
->keepalive_timeout, "keepalive timeout", 1, INT_MAX, msglevel);
     }
   =
  else if (streq(p[0], "ping") && p[1] && !p[2])
     {

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1155?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Ic9ac18f730e6035126ccf1cf19799548e5fd9316=

Gerrit-Change-Number: 1155
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--ZSysOTFPf5E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1155?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">options: Move &lt;=3D 0 check for keepaliv=
e settings earlier<br><br>Use the atoi_constrained function=2E<br><br>Chang=
e-Id: Ic9ac18f730e6035126ccf1cf19799548e5fd9316<br>Signed-off-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert=
@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1155<br>Message-Id: &lt;20260514192727=2E31903-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg36939=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/helper=2Ec<br>M src/openvpn/opt=
ions=2Ec<br>2 files changed, 3 insertions(+), 7 deletions(-)<br><br></pre>
=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec</span><br><=
span>index 9e7ad93=2E=2E4c540a6 100644</span><br><span>--- a/src/openvpn/he=
lper=2Ec</span><br><span>+++ b/src/openvpn/helper=2Ec</span><br><span>@@ -5=
52,14 +552,10 @@</span><br><span>         /*</span><br><span>          * Sa=
nity checks=2E</span><br><span>          */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (o-&gt;keepalive_ping &lt;=3D 0 || o-&gt;k=
eepalive_timeout &lt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      msg(M_USAGE, &quot;--keepalive parameters must be &gt; 0&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>=
         if (o-&gt;keepalive_ping * 2 &gt; o-&gt;keepalive_timeout)</span><=
br><span>         {</span><br><span>             msg(M_USAGE,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                &quot;the second pa=
rameter to --keepalive (restart timeout=3D%d) must be at least twice the va=
lue of the first parameter (ping interval=3D%d)=2E  A ratio of 1:5 or 1:6 w=
ould be even better=2E  Recommended setting is --keepalive 10 60=2E&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quo=
t;The second parameter to --keepalive (restart timeout=3D%d) must be at lea=
st twice the value of the first parameter (ping interval=3D%d)=2E  A ratio =
of 1:5 or 1:6 would be even better=2E  Recommended setting is --keepalive 1=
0 60=2E&quot;,</span><br><span>                 o-&gt;keepalive_timeout, o-=
&gt;keepalive_ping);</span><br><span>         }</span><br><span>         if=
 (o-&gt;ping_send_timeout || o-&gt;ping_rec_timeout)</span><br><span>diff -=
-git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>in=
dex 62c0bbb=2E=2E8012192 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -6777=
,8 +6777,8 @@</span><br><span>     else if (streq(p[0], &quot;keepalive&quo=
t;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>     =
{</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;keepalive_ping =
=3D atoi_warn(p[1], msglevel);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        options-&gt;keepalive_timeout =3D atoi_warn(p[2], msglevel=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        atoi_cons=
trained(p[1], &amp;options-&gt;keepalive_ping, &quot;keepalive ping&quot;, =
1, INT_MAX, msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        atoi_constrained(p[2], &amp;options-&gt;keepalive_timeout, &quot=
;keepalive timeout&quot;, 1, INT_MAX, msglevel);</span><br><span>     }</sp=
an><br><span>     else if (streq(p[0], &quot;ping&quot;) &amp;&amp; p[1] &a=
mp;&amp; !p[2])</span><br><span>     {</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1155?us=
p=3Demail">change 1155</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1155?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: Ic9ac18f730e6035126ccf1cf19799548e5fd9316 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1155 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 9 </div>
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
--ZSysOTFPf5E=--


--===============8537615616312159157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8537615616312159157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8537615616312159157==--

