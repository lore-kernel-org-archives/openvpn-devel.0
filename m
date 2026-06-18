Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78101CD98ED
	for <openvpn-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9X9RxaSHxJaQtc747WdIB4t7l4ZA5i3ZGwCLRzCVf7c=; b=aVeXEXKnaAtboBt4DR6UTbzFpZ
	W4qetcN9S3vqwo1qQvcSX9yAMqipvrZoE2flO0waSx40vN0zPCAUL817kDD4wAK6y4qJhPKKXP38m
	DRjjZZic1t51kRtvx0Ic1EIdXb0G/ykt4aLF3QHOCDA9w5qTI/Xk2n/XhCJ4wyAoEkTg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wa8Fg-0007iK-4o;
	Thu, 18 Jun 2026 08:37:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wa8Fe-0007iD-FG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 08:37:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2TSc8C5NKoIiR98aX18bYM8KH1xiSR1y7j8bXKAIHEY=; b=MMmWYLC04HD/LlS/xMxDLliRkU
 WRRxFt5Nm9xHvBPp7R7T+KXCQ1wIq3tpjR+3e70Ek8e4FpmhEJWO2jm6b7n1cto8uYQ33HtI5Ocu7
 Qm/5UXH88vjjNG4Wf/7JLDcYl89Tu0uGSFAkjtrdU6UhSXoLXWgOJnp7SXr++kgPlFC4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2TSc8C5NKoIiR98aX18bYM8KH1xiSR1y7j8bXKAIHEY=; b=P
 X9WEqmE4ZrCXQ4Xb33gmeix1+wOBJB0x1J3i3RA+zVgVYBsGvj/2aGVdQBZuReyVuL9F57H78yRqo
 il8Y31XgpLQRM4yX0+53feuun1dJc2hFfBvdL2U4NFyiuN83tADrmh6+LxAwmP22KLbsctHqzPNxK
 SPjWumz3iWM6JeKM=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wa8Fd-0005Ne-9T for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 08:37:30 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490b4a8e28bso3916655e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 18 Jun 2026 01:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781771838; x=1782376638; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2TSc8C5NKoIiR98aX18bYM8KH1xiSR1y7j8bXKAIHEY=;
 b=PzEQ31bgnC+nCgpCKLfQP7wg9hGJ/dzG1lKiQoOxvF7Bti9p/KFPwIt9gWuQf7XBJJ
 gRpCtnfP7tBjMUIwOObLVlhlzZADJ9vR1OTDGdBnWC9OjXBb464LSjPzx5WoE7h0EX6a
 yJsdcPv0pZNc/fZv5k2KPcot02Zki8OLzM2gfN8pKWzUX6awE9w5OePfY/L4fmdjekAO
 uNC6GyJrYkP267VaVRfi0Hw/Olu789BEwWJpIMBd8iI+HyPsdV/CuMsaLbnAqgtHp6a8
 VZCLdCNnYLGcDM4rccmsgXbggR3fXFPmZcLrRvM9iHf2PXbWE2igDHK0TEE16RQxxbJq
 ZaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781771838; x=1782376638;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2TSc8C5NKoIiR98aX18bYM8KH1xiSR1y7j8bXKAIHEY=;
 b=qqk9tNPaQLuWfZEKsiLX7ZeHcR7TYLvxIxvM9N9m1VINvVtdYQ2e8uvwdpXcvr/nGm
 2mou1Ex+ANGI2Jo88VP9gQT4g8vFVFqveCRwVQ4qKjaW1eImk+lJLhVAaVegUfBCjy/W
 aZ/SEaPLLh5LU+0Yte0U12l+qE3JaPvvG78/r5pNbplnAIVA5fo7N3UUGqtA1lsL1bPt
 +SlGbRTXReIajMVhcGlviVZPa1wFPa0M2a9sVBCLb6kGBkULHTg4MWYnSMp9+1r7egc7
 u9YR+EQKlClhF4xWfKas+tsMR+dsp/tZw60NCwbKw6AjVNh/jJCFL8VyOr4I43qYVUs6
 qM8Q==
X-Gm-Message-State: AOJu0Ywtf/EakvM2jkNNJkE6p66hxCrnSZnET3oEHIpmkQmTSRsOIX0r
 RaoNFhKDEoYF7JnfTZ1kVDnzAC0nd5ULLRkDHw2o43irkcEhyfM1x9iw/XFs1xP6NJBmBh2wfoO
 eL1CWUXD5t2nuyLsq43xk3nwLLQnMmsoWKdb11Rpxo77E8wwCJ4ShgqsGSyTWNikgqVmU
X-Gm-Gg: Acq92OHNw6nK8lihCS+eIXLx8fIl05YhF8HQE1bm4Y4ZDpRcqhOc2Bha2T9sKWScZ2B
 VPhG1snrNRUInB6rQRnYhPJQDIka9ZWfS5MfgL5PuGE1wLLi0DVgdtyELisUmuNTy1LHL06V/IG
 AWQ8MkomREDpbYdQUmDErZDYKG7QDuJjX6LoxQ18RjiMjumjDT9mRNkcD4JJcHGC20GFz0UU7OY
 1y9KytgRFnQXIG64NECd1VD7xCOr4ibVScSIRCLmc1pSDrAPk0yImLRhwMo8XU6FS1Mfv5powdO
 DeFBoPzqJvkqFoPbDH/vXq5JhlF/r4dMETRJ1sF5JgqW5dlyCBCV8QEtD/A+N6YX2yC7hfpu0He
 J/vcodVpCXQJ1z/g7x9t+dxeHUNxkAikm4rYz/yPbaECPGw7irS9I7sczxSWbYWr/+llD9fxDp9
 kBwPpq7a7NQirmQEraATLisNn45B9dWepjTHGWft8T5m75ArP6LZMaVvRj3gPKauxdALB0YfISg
 osusS1Hm6QDR/LcBF47Oa6+WxbiwCZ34YBoIiCbgnbmk6qpogoMfLRtiIZtWoYRv8fwozIYA7Qb
 6jA=
X-Received: by 2002:a05:600c:c114:b0:490:3f7a:108b with SMTP id
 5b1f17b1804b1-492333faba1mr96540825e9.16.1781771838111; 
 Thu, 18 Jun 2026 01:37:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a96b47sm194712055e9.13.2026.06.18.01.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 01:37:17 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 18 Jun 2026 08:37:14 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd
X-Gerrit-Change-Number: 1712
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1712?usp=email>
X-Gerrit-Commit: 154e8a520b3bd639fb137c1ba73ce8a80818d08d
In-Reply-To: <gerrit.1781714533000.I7ec318c86af994284d1c6272e3bbe2b1ede160fd@gerrit.openvpn.net>
References: <gerrit.1781714533000.I7ec318c86af994284d1c6272e3bbe2b1ede160fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxNzE0NTMzMDAwLkk3ZWMzMThjODZhZjk5NDI4NGQxYzYyNzJlM2JiZTJiMWVkZTE2MGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bb7fe0c5b1b344917d42863332c49b54d5641407-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wa8Fd-0005Ne-9T
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: Fix memory
 leak in dns_server_addr_parse
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3745987727718133999=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3745987727718133999==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XlWEyeEzXYU="; charset=UTF-8

--XlWEyeEzXYU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello d12fk, plaisthos, 

I'd like you to reexamine a change=2E Please visi=
t

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1712?usp=3Demail

to look =
at the new patch set (#3)=2E

The following approvals got outdated and were=
 removed:
Code-Review+2 by d12fk


Change subject: dns: Fix memory leak in =
dns_server_addr_parse
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

dns: Fix memory leak in dns_server_addr_parse

When the DNS serv=
er's address count is already full (exceeds the
limit of 8), the function r=
eturned early without freeing the
successfully resolved addrinfo struct=2E =
Fix this by checking the
limit before executing the DNS lookup=2E

Github: =
OpenVPN/openvpn#1055
Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd
S=
igned-off-by: saddamr3e <saddamr3e@gmail=2Ecom>
Acked-by: Heiko Hund <heiko=
@openvpn=2Enet>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1712=

Message-Id: <20260618061835=2E16448-1-gert@greenie=2Emuc=2Ede>
URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37209=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/ope=
nvpn/dns=2Ec
1 file changed, 3 insertions(+), 3 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/12/1712/3

diff --gi=
t a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index 954ed52=2E=2E1465cdf 10=
0644
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -114,13 +114,13=
 @@
         addr =3D addrcopy;
     }
 
-    struct addrinfo *ai =3D NULL;=

-    if (openvpn_getaddrinfo(0, addr, NULL, 0, NULL, af, &ai) !=3D 0)
+   =
 if (server->addr_count >=3D SIZE(server->addr))
     {
         return fal=
se;
     }
 
-    if (server->addr_count >=3D SIZE(server->addr))
+    stru=
ct addrinfo *ai =3D NULL;
+    if (openvpn_getaddrinfo(0, addr, NULL, 0, NU=
LL, af, &ai) !=3D 0)
     {
         return false;
     }

-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1712?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I7ec318c86af994284d1c6272e3bbe2b1e=
de160fd
Gerrit-Change-Number: 1712
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <=
gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: ordex <antonio@mandel=
bit=2Ecom>

--XlWEyeEzXYU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1712?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by d12fk</p=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dns: Fix memory leak in dns_server_addr_parse<br><br>When th=
e DNS server&#39;s address count is already full (exceeds the<br>limit of 8=
), the function returned early without freeing the<br>successfully resolved=
 addrinfo struct=2E Fix this by checking the<br>limit before executing the =
DNS lookup=2E<br><br>Github: OpenVPN/openvpn#1055<br>Change-Id: I7ec318c86a=
f994284d1c6272e3bbe2b1ede160fd<br>Signed-off-by: saddamr3e &lt;saddamr3e@gm=
ail=2Ecom&gt;<br>Acked-by: Heiko Hund &lt;heiko@openvpn=2Enet&gt;<br>Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1712<br>Message-Id: &lt;20=
260618061835=2E16448-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Ema=
il-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37209=2Ehtml<br=
>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M sr=
c/openvpn/dns=2Ec<br>1 file changed, 3 insertions(+), 3 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/12/1712/3</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/dns=2Ec b/src/openvpn=
/dns=2Ec</span><br><span>index 954ed52=2E=2E1465cdf 100644</span><br><span>=
--- a/src/openvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</span><=
br><span>@@ -114,13 +114,13 @@</span><br><span>         addr =3D addrcopy;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct addrinfo *ai =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (openvpn_getaddrinfo(0, addr, NULL, =
0, NULL, af, &amp;ai) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (server-&gt;addr_count &gt;=3D SIZE(server-&gt;addr))</spa=
n><br><span>     {</span><br><span>         return false;</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (server-&gt;addr_count &gt;=3D SIZE(server-&gt;addr))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *ai =3D NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (openvpn_ge=
taddrinfo(0, addr, NULL, 0, NULL, af, &amp;ai) !=3D 0)</span><br><span>    =
 {</span><br><span>         return false;</span><br><span>     }</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1712?usp=3Demail">change 1712</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1712?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I7ec318c86af994284d1c6272e=
3bbe2b1ede160fd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
712 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&g=
t; </div>

</body></html>
--XlWEyeEzXYU=--


--===============3745987727718133999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3745987727718133999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3745987727718133999==--

