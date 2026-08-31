Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269C2C624D1
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=aCPEhg9Bjffs5MbUXAD32ISyMDrkXYFqb8I+LMXF9YY=; b=TedqxsEr5qL6xr
	2fhgRkGUK8BDjCIAH3Ytohf6bY/NDDsnQH9xkVsRzCjWNOxaiIsdy9+jazIJ3pjonZ7oMwXdSsqY2
	ZBADkaVPtK4LsUVLfZFqCaZ+YCdAcbBTo6d/rhmi4Ir+tEF8eMFnLF46mY/4Utf5rLCMZLuQmmYJo
	dkg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x14Tf-0006VN-Jc;
	Mon, 31 Aug 2026 16:03:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x14Te-0006VG-6M
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 16:03:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iN2VWfFmi1CwRFaSz8dcOups4gcihhyZDbwhj7YIg0U=; b=AkSI8GjB1A3StVSikzmbhTK8zc
 tgTGEXWq1silPDSXKSu/g6lotihhjfTk9ZgmjnhllZHyslcvXyHOJcUZ3ciLOmWvVYgn9ivN7DvF9
 wPQAAd0HUenRYjzm8O45nmb3aHbD+5mDdY7MABulQazdOdNlTSwFN60RkfA3Fn8TmT6Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iN2VWfFmi1CwRFaSz8dcOups4gcihhyZDbwhj7YIg0U=; b=T
 m+e0pbEis8M1ybPnDuAWtxVrHvAe4hifc+eqLxO0Rw5YPYpyqbt/bI9UwM4qzYKJPFCobYJW5e8+E
 uyY4zCEpUq7SEXESbS7GU5nkbWyO7sc8GHZWZ6z++5d8zP2N20wXT+nzBtcuLdJ4KhGEtKF9JUAWD
 wQQquEX69Qnq9tsM=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x14Td-0008D8-FZ for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 16:03:18 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-484415c8cb1so112418f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788192191; x=1788796991; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iN2VWfFmi1CwRFaSz8dcOups4gcihhyZDbwhj7YIg0U=;
 b=JwV8tiwhSelAqOc9S+wlSicz64SnoNgNw9sSKqIkJ/KMGqblc+eB7h4R0oYNM4HwRq
 usN7yKJeR6+07Mo04HVhf+VN4x5Yf0odfMcJJHDSG75MKlaRmY3npX0SygQtbKAQBfqa
 YcPindcvQokpYKqY6EUTCsx9r/NVqh2Ylxmx6FUzdl0ShH4KzSwA6OBd+XX4d3w7yHuK
 Gea8J+wuHXDAt30bJf8rN9wpCM/JmRX7SkyQcl/Jza/tlXmtuc2LSIuneaTNc+LTyg7I
 HdlPEDfQT9dPxQEyWsizo9+giXW/42/No0RUlMSxcs0eOWDuPRAkRaw/2TjhifX7pf79
 qzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192191; x=1788796991;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iN2VWfFmi1CwRFaSz8dcOups4gcihhyZDbwhj7YIg0U=;
 b=FyOs6yOzyFtCc+7K5HSZFSeG4oZ8OhYpDBsmFJMZDyUwd8fuqwtoQPzE3HieQ0RN3D
 aronq92H3+s3xeb4qNSNbMD2jTIPUDJxDkvyuFKdtx3sXt1N0njqu9CRX2vSTdp5H7T6
 FYUAqAFG5LrZf4jvpmypQfH85aZxttvjquuyFa/bVx44YawJ2KksbQGHydPO84CLje9+
 clyeiA1KPqBQc0FWU8OTwClVq2Z+kgR4AwFw475P6cqA5HgzeZyrWhn+AVpewScKzrJJ
 zxnk51rb/VWmTUjeVxaCCBv6q3EGLCvjXCu+sbNh+GOOoHoOI6pOMk0z3tb5fR5NYVuB
 5Y/w==
X-Gm-Message-State: AFuF++lUmR3e5LYT0VW4B7gMujjXeYct9+zKwyjoO/2vE8SsM9CeOuQk
 l2lLk/8/SyIEbbZKiEhaw8M80pheE+lZhNz5pQF5UywpXhQEz8rCVEMGWi5HPO2/rdorcIlZ3e6
 rIOprfwo8OnovF/S3o2p3D7alJsMKOw8pM+Cd/D3lANl6UlISmfF8aTnXDmeAE0wOaoQbZtmkp3
 V2Z14Zig==
X-Gm-Gg: AYBFou3UVHciW4gJ4HN8QfYOhUHCA3NmRuLhOKxLRoRmt3wW+EdWg1kFk3amE9QX0oJ
 vTIQ5AaiRgU1+pXZ2eLcAC5Uiamc+zM9hZjFVPgy82gOINlmDZXokSurDKZrSn2tngW+N3sryhd
 5pJwr9PfyHJvJ15Ci0kQAzYZ+BBsQWv+ZwXcUkJiHu9wZnTz3k5Xh1Sq8YiWIO9NFpOtpwQfMKF
 5R+/ybY3eLhHs5yKUGA1n14QIBWFF5UzqXM1kV952dcZUGf0OCQLOOVKcY4LFyO0xoXPmVoBsDh
 9VJ+HSMN6aMqI/KUzL4znLDbyGtp7ZVWMwnBYHEGTDjDAfWSvhRUdE4VSrQRctaCUhoo3iKmVIY
 /z3bTVVJWRjUISWo3e77j2gSMdBGZQMz6yKXNIPHpdXCWRkSvpWI9JDT67M+8gHVHn0jx+vf/KK
 rpr2OO9XHVroq/oI/7E6GaT4YwtnWU2DR5bChzWZfhWGGN734zemIBoxzWfK+eYU18qXQ05E9FV
 nQU321YJv5itISfraoU0NgRnpadd+CWyEd4dkwOgOpyGFYdfGFAdahtEcvd7F4WqCEk+oOos8GJ
 ZMz3IpNFFms9kV6q/IJeruq9pUuilbyFluPX8UnnPIxfChhD1bI=
X-Received: by 2002:a05:6000:27c6:b0:484:3310:710b with SMTP id
 ffacd0b85a97d-48441025c15mr2699999f8f.23.1788192190721; 
 Mon, 31 Aug 2026 09:03:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f22sm24405524f8f.2.2026.08.31.09.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:03:10 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 16:03:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1a181d65ad0d5e3765f57373a6ee223ede909dea
X-Gerrit-Change-Number: 1888
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1888?usp=email>
X-Gerrit-Commit: 5b7cefa7007c689c2c84ba9b89847e144443b500
References: <gerrit.1788192180000.I1a181d65ad0d5e3765f57373a6ee223ede909dea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkkxYTE4MWQ2NWFkMGQ1ZTM3NjVmNTczNzNhNmVlMjIzZWRlOTA5ZGVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <538d76d95fc7955da85073adb094e0d05c047111-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x14Td-0008D8-FZ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: fix
 off-by-one input validation
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1052176394834620716=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1052176394834620716==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g4AWFLgT8f0="; charset=UTF-8

--g4AWFLgT8f0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos=2E

Hello plaisthos,=


I'd like you to do a code review=2E
Please visit

    http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1888?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: fix off-by-one input validation
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: fix off-by-o=
ne input validation

Code checked for a hypothetical third trailing NUL cha=
racter,
instead of the second=2E Could read one extra octet beyond the buff=
er if
it is used up by the data completely=2E

Discovered and reported by B=
reachX Zero Day Labs, using Typhon AI Mil v2=2E
Contributing Researcher: Vi=
vek Parikh=2E

Reported-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
CVE:=
 2026-78221
Change-Id: I1a181d65ad0d5e3765f57373a6ee223ede909dea
Signed-off=
-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
---
M src/openvpnserv/intera=
ctive=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/88/1888/1

diff --git a/=
src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 0c6=
e23f=2E=2Ed2288b9 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/op=
envpnserv/interactive=2Ec
@@ -2959,7 +2959,7 @@
         const char *rdom =
=3D msg->resolve_domains;
         size_t rdom_size =3D sizeof(msg->resolve=
_domains);
         size_t rdom_len =3D strlen(rdom);
-        if (rdom_len=
 && (rdom_len + 1 >=3D rdom_size || rdom[rdom_len + 2] !=3D 0))
+        if=
 (rdom_len && (rdom_len + 1 >=3D rdom_size || rdom[rdom_len + 1] !=3D 0))
 =
        {
             return ERROR_MESSAGE_DATA;
         }

-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1888?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I1a181d65ad0d5e3765f57373a6ee223e=
de909dea
Gerrit-Change-Number: 1888
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 =
<gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: d12fk <heiko@openvpn=2Enet>

--g4AWFLgT8f0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos=2E </p>
<p>cron2 would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1888?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">openvpnserv: fix off-by-one input validation<br><br>Code checked for a=
 hypothetical third trailing NUL character,<br>instead of the second=2E Cou=
ld read one extra octet beyond the buffer if<br>it is used up by the data c=
ompletely=2E<br><br>Discovered and reported by BreachX Zero Day Labs, using=
 Typhon AI Mil v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>Rep=
orted-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>CVE: 2026-782=
21<br>Change-Id: I1a181d65ad0d5e3765f57373a6ee223ede909dea<br>Signed-off-by=
: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M src/openvpnse=
rv/interactive=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/88/1888/1</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/=
src/openvpnserv/interactive=2Ec</span><br><span>index 0c6e23f=2E=2Ed2288b9 =
100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><spa=
n>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -2959,7 +2959,7 =
@@</span><br><span>         const char *rdom =3D msg-&gt;resolve_domains;</=
span><br><span>         size_t rdom_size =3D sizeof(msg-&gt;resolve_domains=
);</span><br><span>         size_t rdom_len =3D strlen(rdom);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (rdom_len &amp;&amp; (rd=
om_len + 1 &gt;=3D rdom_size || rdom[rdom_len + 2] !=3D 0))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (rdom_len &amp;&amp; (rd=
om_len + 1 &gt;=3D rdom_size || rdom[rdom_len + 1] !=3D 0))</span><br><span=
>         {</span><br><span>             return ERROR_MESSAGE_DATA;</span><=
br><span>         }</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1888?usp=3Demail">change 1=
888</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1888?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"=
display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> =
Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id:=
 I1a181d65ad0d5e3765f57373a6ee223ede909dea </div>
<div style=3D"display:non=
e"> Gerrit-Change-Number: 1888 </div>
<div style=3D"display:none"> Gerrit-P=
atchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: d12fk &lt;heiko@openvpn=2Enet&gt; </div>

</body></htm=
l>
--g4AWFLgT8f0=--


--===============1052176394834620716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1052176394834620716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1052176394834620716==--

