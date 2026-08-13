Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9BFC5CFCF
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N2DTyn3ZU6WAS8UYREnmV+pNmZ6DDbHVmYLKpXGovn8=; b=mT9/U2pk0eqCzvneSpF0Kq+Uaq
	cwDKvrNcKOJ79lF8INy4VuEyicmiNZ7yZftGGApEJ2DPLv5zz7lHShawZz2I86udRwMLKNQcVF33u
	KQodRf5aqOW7uMmhjzjB8h3SBuSBnxdf2HCJhcD4ooJ9W/TsKPs66K96szFgATNcF3Vg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYJ9-0006zx-M5;
	Thu, 13 Aug 2026 16:29:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuYJ3-0006z1-HR
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:29:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=06U1KzNLzW/XtSXYm9KvDluzNh2i3Xe8rj2IeEMsRQo=; b=gAxwjqFQYMKiaACHcYlP9Rurcw
 ays3JfIvTYYcfbtsghxvi28osbyY3EgjTK/phLc7nKEha580MuqStS7YOVbOGJUUuZ5kZ9I925Vrw
 h88Osm/tT7ZWmFHNdaAodpSuRnczQIAwbaC5ubzF5pEVHqGmDFZk3bteGNoeCq4mQTJg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=06U1KzNLzW/XtSXYm9KvDluzNh2i3Xe8rj2IeEMsRQo=; b=L
 c9/jiV8vrQZRTLoNn5JqXhckrwT+IMDea81K/TB/BnZ9M0SH642V+gsdt0wjeue24WdAYSS5V2qfS
 22Mqhk3VAk4QYy5DXkXbhzqpLfZIUedfZ+KAd0AZycaJHxyaElqB/UZ4Zj1uzAnTLOCpCy3k3exY3
 MQuZ+4h3L2Kqaa90=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuYIW-00045h-TU for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:28:55 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-480001972b8so2119f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786638526; x=1787243326; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=06U1KzNLzW/XtSXYm9KvDluzNh2i3Xe8rj2IeEMsRQo=;
 b=c1VHzqxaROJHgFyNRg10zyToW1UR5m6uRldLS63LqMBYAhbY7ZKDFlZG//uYjk8u3n
 v6miujBIIqMxjz9uV3pcavlwkwsDyQsxhaTyYr799cDuOHbrco6w6QcjYQmdc3oCnyxo
 0XmsC4iYW+WS0qm+RVXgOqm5rg3vb2kbONuM3wgXlJjmi4zSSoLbJ6dGmOPwIn8aCwIu
 6DW1pq78/1BUEVaRmyhx+M70kblD/Id7st0AkhaqgmeHVFVnluDfmg1WdqPzPwYgBGIu
 N8BbULHnP3O7INhyyBFE8NYNv+S8ajm+7vB4GL+YO3PrtM/PyFJrxE1lfU5vtritRDIh
 W00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786638526; x=1787243326;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=06U1KzNLzW/XtSXYm9KvDluzNh2i3Xe8rj2IeEMsRQo=;
 b=mEljsbF5fhODz7eQwdDIWqhWsiMxm+lmGSC9BDWjyIj2fRI8ygZHvRBOrOeL8Xxt04
 6YJOiuLLtW8no4gchTIVuARgfD/rgwh8sTeAUGu9IYxK9ZVqI3I3JpSbvFheybZsH4Xp
 42Ja3BEkKPIxVABsi/iHv05xD3fju+foZaAV3CBNSlXbY6bTRWWiRg3ovh6f8ZnH4ur+
 RtMjPaBxGpaLF2T3GfLC4uIC2tJFlXBHIYNY62Oo1Iv7ta33oXABaCEiCOLM+enG9lOz
 EC2FZyM05mhOGPlNORyQCEEdn6cKcHWdG2TqGFDxZCVtDUYChPL+Z2qkP5ZuabzGSi04
 IGaw==
X-Gm-Message-State: AOJu0YwGzMhN6nbavJWs5qw29tI6UJpfwSKvtzQrikFqUbIqfrYQHHzH
 3wjIuRpYQtfRyKc+4guxRXUvK4wiD4/5OtcQbQGtLmIQkx/DOsS4uh6v6GNnzSu7x8xqi+RkLSX
 wb9vn+/O5FrugaYhnaPNsttRqEZcXFlma9RXID158zoPLcJcY/1ZP/zd7O1d1V4auVyWv
X-Gm-Gg: AR+sD13ib1VGPpx9L9ecw+UpMJokt/Z3oOEv4eu7EE61dBBlUvsXhGbPBPalKa3Vy8q
 7ba9B1SJE0JOwdtfpeJy6IDbN3KQ59iwLtbtlv/8UTuBxp9+14ReRKQ84UrqXxemCVPNfds9iGr
 uWIhZjzfND1nj/Ft/tvpE0vgc2ZB13lTO7zMCefF1gX2qX5X+EgzwiegOWNuFa6ulMi5ZtymR3X
 zKPQLGISKwEbX6hCjxQMxhXKdlv+q7sPHu5TjzoQmhOq/shUGxL5e2qjdB869f9GztwgnWWCa72
 F7c7UjKjdL8voHA9lg6UmNRSMTjzVYUl4CXrmKirJWe4AH/zchr7XlEqhxKkck3vJUg1ZrtyK8g
 4OiWYzNhXDZhBMrnYupMQGLNqj6cpbh9JL5fanak1VbtCfNxihYI57+YB2xCCFAIqbT82PSYRQG
 KnfsPkBsURJyil43wr2Ak07SK+SJzHz9jQhru1OeYWClogWobT/G1d4qKBfr1EP0zchZ4zpdW9e
 zaED81k2OPGou+Sai6VbaOboxiIszblGBVE6Fp22OaZR3R/4Sqf2g0Cw0y520wI5DS/Kr/5KkVz
 CKl/5Z2k9N7RMJ7q6RUpbm9tSyVidCSKvjzNHnLx/Lp+WWJDXw7YE4rFG8k9Ww==
X-Received: by 2002:a05:6000:4802:b0:47f:fb57:8c7f with SMTP id
 ffacd0b85a97d-4815a008815mr11048266f8f.29.1786638526251; 
 Thu, 13 Aug 2026 09:28:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f219d3dsm567661f8f.14.2026.08.13.09.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:28:45 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 16:28:43 +0000
To: MaxF <max@max-fillinger.net>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id8524d9c36ea913d557d3f43f1f62acc4186b4eb
X-Gerrit-Change-Number: 1843
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1843?usp=email>
X-Gerrit-Commit: 7d44bf3d965a50387675a82ba31148fbde6fc8ac
In-Reply-To: <gerrit.1786632384000.Id8524d9c36ea913d557d3f43f1f62acc4186b4eb@gerrit.openvpn.net>
References: <gerrit.1786632384000.Id8524d9c36ea913d557d3f43f1f62acc4186b4eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NjMyMzg0MDAwLklkODUyNGQ5YzM2ZWE5MTNkNTU3ZDNmNDNmMWY2MmFjYzQxODZiNGViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4628da9b22a8ce720f70ec3457e42fda578b96cc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuYIW-00045h-TU
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix format string
 specifier for size_t
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
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1430313826392681609=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1430313826392681609==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Zdu0huD8hxI="; charset=UTF-8

--Zdu0huD8hxI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1843?usp=3Demail )

Th=
e following approvals got outdated and were removed:
Code-Review+2 by cron2=
, Code-Review+2 by razvanc


Change subject: Fix format string specifier fo=
r size_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix =
format string specifier for size_t

size_t being the same as unsigned long =
is true on Linux, but this
produces a warning when cross-compiling for Wind=
ows=2E Replace %lu with
the correct format specifier %zu=2E

Change-Id: Id8=
524d9c36ea913d557d3f43f1f62acc4186b4eb
Signed-off-by: Max Fillinger <maximi=
lian=2Efillinger@sentyron=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1843
Message-Id: <20260813145122=2E146=
06-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg38303=2Ehtml
Signed-off-by: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/pkcs11_mbedtls=2Ec
1 file cha=
nged, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/43/1843/2

diff --git a/src/openvpn/pkcs11_mb=
edtls=2Ec b/src/openvpn/pkcs11_mbedtls=2Ec
index bf9d953=2E=2E2183217 10064=
4
--- a/src/openvpn/pkcs11_mbedtls=2Ec
+++ b/src/openvpn/pkcs11_mbedtls=2Ec=

@@ -64,7 +64,7 @@
 
     if (cert_blob_size > max_cert_size)
     {
-     =
   msg(M_WARN, "PKCS#11: Certificate too large: %lu bytes, maximum is %lu",=
 cert_blob_size, max_cert_size);
+        msg(M_WARN, "PKCS#11: Certificate=
 too large: %zu bytes, maximum is %zu", cert_blob_size, max_cert_size);
   =
      goto cleanup;
     }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1843?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: Id8524d9c36ea913d557d3f43f1f62acc4186b4eb
Gerrit-Change-Number:=
 1843
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerri=
t-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Zdu0huD8hxI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by MaxF=2E</p>=
<p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1843?usp=3Demail">V=
iew Change</a></p><p>The following approvals got outdated and were removed:=

Code-Review+2 by cron2, Code-Review+2 by razvanc</p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Fix form=
at string specifier for size_t<br><br>size_t being the same as unsigned lon=
g is true on Linux, but this<br>produces a warning when cross-compiling for=
 Windows=2E Replace %lu with<br>the correct format specifier %zu=2E<br><br>=
Change-Id: Id8524d9c36ea913d557d3f43f1f62acc4186b4eb<br>Signed-off-by: Max =
Fillinger &lt;maximilian=2Efillinger@sentyron=2Ecom&gt;<br>Acked-by: Gert D=
oering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Razvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1843<br>Message-Id: &lt;20260813145122=2E14606-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38303=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/pkcs11_mbedtls=2Ec<br>1 file ch=
anged, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/1843/2</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/pkcs11_mbedtls=2Ec b/src/openvpn/pkcs11_mbedtls=2Ec</=
span><br><span>index bf9d953=2E=2E2183217 100644</span><br><span>--- a/src/=
openvpn/pkcs11_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/pkcs11_mbedtls=
=2Ec</span><br><span>@@ -64,7 +64,7 @@</span><br><span> </span><br><span>  =
   if (cert_blob_size &gt; max_cert_size)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;PKCS#1=
1: Certificate too large: %lu bytes, maximum is %lu&quot;, cert_blob_size, =
max_cert_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_WARN, &quot;PKCS#11: Certificate too large: %zu bytes, maximum is=
 %zu&quot;, cert_blob_size, max_cert_size);</span><br><span>         goto c=
leanup;</span><br><span>     }</span><br><span> </span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1843?usp=3Demail">change 1843</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1843?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Id8524d9c36ea913d557d3f43f1f62acc4186b4eb=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1843 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--Zdu0huD8hxI=--


--===============1430313826392681609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1430313826392681609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1430313826392681609==--

