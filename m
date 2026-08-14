Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B703BC5CFCF
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GJN+kB0cABQvwdUpye2PhLb675/ZikOhKut7gLjkePM=; b=feMyzoSpJAyow3YXJLPJYBPQr6
	s9i57nfFge/b7lBinGA4crM+ANPTCwNSrkmcNx3SOJLH+///W1ZFx/ksdr9vMxbFhOd7wtCwXoc3v
	z02/viYLxwFRvNhRuALNAvQpuXFNWMIQVdHLeBKKGl5xyJulfBN+cwOp/G9d3dNLVOdY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wumNd-0004hI-CS;
	Fri, 14 Aug 2026 07:31:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wumNc-0004h7-OJ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:31:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cSQ+4orIU2V4PtrKLMvJz7MZtdFPbvTOzCaoIOzSCH8=; b=a3eTeiCNJd+53CLFiWQFStpt6u
 gQCtfkY/NpR4q52TUZJNwm1v6tdt3cKlMllm9Ma7eDVO/4E4AN3apOEOCElYaWF/S02wcCdkqOvjM
 7hQyJaB/CucMArglhCgnGOMFT8GuImvoWM5EaebXsHpActhY25QxBTFt8FbNrqeLIGZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cSQ+4orIU2V4PtrKLMvJz7MZtdFPbvTOzCaoIOzSCH8=; b=j
 X2cN81I36sNEbGaaqFkvvJ9HPXEJEuAmPVetPaNYVovlRFGzsHxnECpPcChib/X8YCmxvyYsC+3cV
 WlJsbl9cLYRIemNiN5wFH/telbApmOthgRo1+072rcca5t/dgoT+bBXJwlNH8ToZSo61WZKfJa2Pa
 kEaWT2MnPC8bLJAQ=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wumNZ-0001Kr-PB for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:31:05 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso11979305e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786692655; x=1787297455; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cSQ+4orIU2V4PtrKLMvJz7MZtdFPbvTOzCaoIOzSCH8=;
 b=SpAdfFm2R0b62Gs5g8cCJl5neKcbQGfZWn8uEm3b5RMO+JVgdCy4mNGs7nKjrtisEi
 h7eTvmjrlwKCbvmXy7DhTKrIT1nqJ+zjk5AkXPemCLYK4KBDBdypq893HoAyaHT50lDW
 DvsiZJkWKIqms4uExh5nhqI4sRTsDsLUrhQ+hgZmUpVD3lD9uNU5qeAdwYG4Qr27Hplo
 iGGBxTQ06OiEPJiZXJNZxI+hmw0jkYhb4xrgVjkuIJ5RTD735pxMlBC4mBB9KtUmxbiV
 BdHKAZF6iaApXNP/umQpkVEfsi/p6EL+4X+z26ig49DB4vYCgsQpJInJ2HNrlQkOs+m1
 VrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786692655; x=1787297455;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cSQ+4orIU2V4PtrKLMvJz7MZtdFPbvTOzCaoIOzSCH8=;
 b=ewta+hujDhugIiEpJsTl2CaNx7YuV+rJjMp7ZeD0cmkmufI7nw6m5JtvMmydQdwFeH
 HQEVuBzDE1v2E7G6c6GAvwLBfygqrr51mYUkrOavs+O5tqnMRD8A1G5jcK0+xjuJFifz
 Jv/EsMHk6EL1oWRzKpqaWkBan3ZMu73FqSscmxdHNSBeBRgJ7/vDuoy8Fg9v8Qx63BgW
 0vAb93SCbY58Cmwzocdmhu+bsv30SCVckOmqL4iGUp9fNAP9FSG/8giBR+UIpxLZ++5D
 srxiCr1oBD8lOMWIA6nAxKDYRy+DOQxckajbEw0Fil5oRnslzCsqP5b3lTdeAZTrsGTu
 qKcQ==
X-Gm-Message-State: AOJu0YxZ0v3t50pUYlnBAY2KHHJCNmuUyPS01Sjzl9WTgZFwGkDIvhL1
 JKhEd/493d8f0/S0kxxsSpCOJNAsxUQNqnYYAJiUV7gXwD0lX4TEUjmyvQpp0E2DOqyUwd/nD6C
 38P7mlSAUMyqU7tYvd5cKOLhfyyte7kzYoS8HBc1Wa/sOlulYlvi8uPnElhtxBPDTT+dC
X-Gm-Gg: AR+sD13sIGGPxNDYoatood7osABmmjwBlZBsh0xWb7KLzq/8zUl2j+wI+19q62BI4IK
 W0DqH8/DOyZjv8qj6FyB2NVP099EoGz83dga1xL5307oBDMDb4QTtlLspPCJXw8vwkZZr/UKZCI
 VQDd9hIKnnUzBjZSmSbw3YF0TS8YFwkRpc5eWZAR7RnHLG+tdwu4Hw/6v1/9tb25G7D2cf8Wjwz
 99pm8RMPqKnYJ7JpL1f8FTugCYWyuIJ4d32hkYYK0BZJvH+qyc3biun9lSgZrVAwG6awIL2NJ7d
 6ZuVtA09w6xylMFy+W5/O5MR6/F0jRuRQFgoqs3YiSLuAUWE8QjnP7y1zaVhhjAQanU+WShx3U/
 78U4dA5hdb5juCPcB+0FBZBIQVK9l3BOKpwppR+fXk+tqDy2xXAD0cYUQSi2Qfek/s4JzLEZk00
 cSS68YGXeEYpij2D/I/1wtFOTrQasW9WIm6C6f+LKtZuui+8ES61VMNp5d7jH9w2KAz0G9IJ6hJ
 tBdZkAeMSWd6zadXzmWXe34eXQQzYPaoX9LtM1rNDd91kz/zaKobs6r6nkf5zEUl98EiuMCJGUp
 VdLihVCMYCmqhp+VgbkpR862+RrAXXunY3qLNn5uK7DppX/rlNalyba70SDIjQ==
X-Received: by 2002:a05:600c:1d1a:b0:495:779a:ed33 with SMTP id
 5b1f17b1804b1-49987937fa8mr46286525e9.7.1786692655069; 
 Fri, 14 Aug 2026 00:30:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988af1068sm31502725e9.8.2026.08.14.00.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 00:30:54 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 07:30:52 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iac4af315c6d7798f09a27383fc0a755a874b9881
X-Gerrit-Change-Number: 1480
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1480?usp=email>
X-Gerrit-Commit: 96dc5b7d2416e588ef9599d46b91a29fb1e0791b
In-Reply-To: <gerrit.1768911587000.Iac4af315c6d7798f09a27383fc0a755a874b9881@gerrit.openvpn.net>
References: <gerrit.1768911587000.Iac4af315c6d7798f09a27383fc0a755a874b9881@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4OTExNTg3MDAwLklhYzRhZjMxNWM2ZDc3OThmMDlhMjczODNmYzBhNzU1YTg3NGI5ODgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <baa5e210b15f3e8d0f0d58544746a021f7bc88d1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wumNZ-0001Kr-PB
Subject: [Openvpn-devel] [S] Change in openvpn[master]: reliable: Avoid
 conversion warning in reliable_send_timeout
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3043290588902901384=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3043290588902901384==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CRWs9xEeSrw="; charset=UTF-8

--CRWs9xEeSrw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1480?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: reliable: Avoid conversion warning in reliable=
_send_timeout
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


reliable: Avoid conversion warning in reliable_send_timeout

It is not re=
alistic that this produced big values
and we already discard negative value=
s=2E So just use
whatever we get=2E

Change-Id: Iac4af315c6d7798f09a27383fc=
0a755a874b9881
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
A=
cked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1480
Message-Id: <20260813180856=2E3208-1-gert=
@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg38329=2Ehtml
Signed-off-by: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
---
M src/openvpn/reliable=2Ec
1 file changed, 1 inserti=
on(+), 10 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/80/1480/4

diff --git a/src/openvpn/reliable=2Ec b/src/ope=
nvpn/reliable=2Ec
index 52adacf=2E=2E690e50d6 100644
--- a/src/openvpn/reli=
able=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -687,11 +687,6 @@
     }
 }
 
-#=
if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#p=
ragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /* in how many secon=
ds should we wake up to check for timeout */
 /* if we return BIG_TIMEOUT, =
nothing to wait for */
 interval_t
@@ -713,7 +708,7 @@
             }
     =
        else
             {
-                ret =3D min_int(ret, e->next_t=
ry - local_now);
+                ret =3D min_int(ret, (int)(e->next_try - =
local_now));
             }
         }
     }
@@ -724,10 +719,6 @@
     ret=
urn ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC dia=
gnostic pop
-#endif
-
 /*
  * Enable an incoming buffer previously returned=
 by a get function as active=2E
  */

-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1480?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: Iac4af315c6d7798f09a27383fc0a755a874b9881
Gerrit-Change=
-Number: 1480
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>

--CRWs9xEeSrw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1480?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">reliable: Avoid conversi=
on warning in reliable_send_timeout<br><br>It is not realistic that this pr=
oduced big values<br>and we already discard negative values=2E So just use<=
br>whatever we get=2E<br><br>Change-Id: Iac4af315c6d7798f09a27383fc0a755a87=
4b9881<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<=
br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1480<br>Message-Id: &lt;202608131=
80856=2E3208-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38329=2Ehtml<br>Signed-=
off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvp=
n/reliable=2Ec<br>1 file changed, 1 insertion(+), 10 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/80/1480/4</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/reliable=2Ec b/src/openv=
pn/reliable=2Ec</span><br><span>index 52adacf=2E=2E690e50d6 100644</span><b=
r><span>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/re=
liable=2Ec</span><br><span>@@ -687,11 +687,6 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot=
;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 /* in how many seconds should we wake up to check for timeout */</span><br=
><span> /* if we return BIG_TIMEOUT, nothing to wait for */</span><br><span=
> interval_t</span><br><span>@@ -713,7 +708,7 @@</span><br><span>          =
   }</span><br><span>             else</span><br><span>             {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                ret =3D min=
_int(ret, e-&gt;next_try - local_now);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                ret =3D min_int(ret, (int)(e-&gt;next_tr=
y - local_now));</span><br><span>             }</span><br><span>         }<=
/span><br><span>     }</span><br><span>@@ -724,10 +719,6 @@</span><br><span=
>     return ret;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br=
><span>  * Enable an incoming buffer previously returned by a get function =
as active=2E</span><br><span>  */</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1480?usp=3De=
mail">change 1480</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1480?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: Iac4af315c6d7798f09a27383fc0a755a874b9881 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1480 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--CRWs9xEeSrw=--


--===============3043290588902901384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3043290588902901384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3043290588902901384==--

