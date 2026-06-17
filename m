Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1233CD98F2
	for <openvpn-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=MIc1lJaXFGOEXG4igoeqv5ECyZTfetLmp60mp1evrfo=; b=G8xMDynKmU7wtd
	PuRYV7cBZVS33fXTd65sywPZJfLIq/BU1CC4V+3lgGMz35lg0EblCjqk18cdp9kP05hdjwXx62X31
	HJpE+eNoYNk280ZtTpZltRx1bGGapMLxLcNRofjD9TxiHmKLB6I9B0uV5hXXPjZdyMqee7f7KYLgG
	va4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZtu3-00035y-Bv;
	Wed, 17 Jun 2026 17:18:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wZtu1-00035q-MS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 17:18:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6jSPbftHyaZIGugtCdWv8g47A+aiJPgc9iJjLLU/Spw=; b=bB6vWkmc7bxZBOFvYv69cd3Gd1
 WT8IOKkoFlOrrOa6Y/9SaTHQ2yr8NOKiW+Om7KKtu/1LCvGV3RLsUpaxvw68F741dmE2Fe3nufkC6
 Wh6AEmqq2yPY+US01m0vUeQl/E0mpP7Xr9wDIDzMORsKWVhC3bZy0+3FQC5Zf6qMukLA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6jSPbftHyaZIGugtCdWv8g47A+aiJPgc9iJjLLU/Spw=; b=j
 ziyYLIs9I1FLdIvrfOq9DT1EnYGtoDE5xwGE5vgXQK143W/o5XEqbzel06XdIhIdShyj4c6wzlvch
 9VLntTHi8r9XMJglKvY72nA0fR3q6lpsuaNP1xZ2N3go3UVikme9yTh3p0WQDDdVvE77yCgiWW/e7
 z9TKmT2OdkjqKuaU=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZttw-00020g-U7 for openvpn-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 17:18:11 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso33878f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2026 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781716683; x=1782321483; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6jSPbftHyaZIGugtCdWv8g47A+aiJPgc9iJjLLU/Spw=;
 b=HUD+2AatYm/qsPd9RBh5fON4rYMSEfQDGS1VfPBdC4uotcmML9Qm4v4BJSLhmNGJAW
 Plc2XBky7aoKvtlYMYzqzsFK5U8U0Bi79GlYoPzAsDyMBNkT3WPxTFTjI7AXhNVtr9KE
 U9F4YalriXESr7G3kY1fxwOB2cSVUo14yDgq7WI8DaWpD6mBcaaNNFIoKCkk6PstIhof
 3Y/4cNDLNNgFPl6T63nLptAzbnvQine9K7yabBemQolkLhKWHa4P6Gu/NF2702DJC/vv
 fqwibQd2vs+rHTUUSrSYpPMW7pmLckM4Mf5q9ZjzaQxWN5/Kq6+g9eHmKEp32mTeaCgP
 Pxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781716683; x=1782321483;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6jSPbftHyaZIGugtCdWv8g47A+aiJPgc9iJjLLU/Spw=;
 b=RJnbNWRHKGKkEqSQP4Y9E3HbFkW+dkoyZlswgEp5BDQIgyIN+Gjiq7df1w2DEicH/w
 X8D2ygsN4V7cps7bxYzFE7zWl0lGq3c34gAG0R1lYsGiUfq3uW3blJ2joStlrfIIZb5q
 36vBBSQC672R1YDxNT/o6BdO8xOpegYXMhGcRJGqdl+xyXB6GHHtQPJdiJxk2iAe31eZ
 tfu7jEAqGBzcFzX4LqmaT2tWb+XqfuRQGeSuXwCSfDedQunI0rACeKIP793rb/2hTH0B
 HYsGTX8Y/N1PgOYeiVG0EOf2PTcRtJKolaRTXLjXyRCUa9hmQ83HvTIihNbLBa4Os32s
 Fz/A==
X-Gm-Message-State: AOJu0YwkDNo0gzpg6CFg1c9UEZzqi/eIBjCcUizVcmv/MjXgm4d3WsV7
 w3mtwLEr5TTtgzfmYCuwb5pMpbw6NpURbzIzPnO9zD7xjqYsx2X4QNre09zl+JVUf5GKiSLq4up
 hfkxwti6yfsUhKA6SdfUfLB3Pjjt2phK3woD899xsAW3D+V4wTfrhSxHEJzcwy2fzLkCP
X-Gm-Gg: AfdE7ck74GfCxqXZlrB0xuV6ER4Igoh2+mdOGder4LinyRf0QUNToHsuZWE/RMmJ12t
 +KWi2WM8sqK6JLOydWbBDBaWNlAKOMIo8nqo47uVyG1+ice4MZ/WvCbb8ASQEpjE5L5Xa9GBoqx
 j67zifh+aSoanD0CRfc8O8qxT6+xZ9W67Wc4E9pTinBn+wMgnvfDY0dAJYw5QfYW8OmS5/HWwl1
 QxstiKKkVuQQ3+OEZi0HlE8q/hmQEMYiA5wFeP9rHwOUMDN7FkcOmtNDucN82ldxbeIX3JL381A
 93QDIAg4Hg6SXumjF5wAiqC8T26xZ3/PeOSb8mk9ZvRCIzGwpfAvLrk5/wufLm7WYCrCnQF/38L
 +y1vmf/+t+5rsjgdW/ZORt8Ayfwjmf3fzYRbTGeQGMTJ8jdXONyAPJkalBu5iGkDFZpbu6FDdY3
 g6urr6A1sMW1qMgdQX2azCStNeuUdStYeV88y+ow0aizLiKUqr8ZoVc7Cz3h3UaU6Q/BHjPH5Ja
 ZdTlogbH3LzHzOQSvdlqi/djDlQZefBo3oWeixKMrI/X8YTVSGQkaVQ7cVkwYr7ERABePbRXYT9
 PgA=
X-Received: by 2002:a05:6000:4022:b0:460:138d:c9b3 with SMTP id
 ffacd0b85a97d-463ab043b86mr182559f8f.2.1781716682570; 
 Wed, 17 Jun 2026 10:18:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e592csm58483943f8f.36.2026.06.17.10.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 10:18:02 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 17 Jun 2026 17:18:01 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6
X-Gerrit-Change-Number: 1713
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1713?usp=email>
X-Gerrit-Commit: 5582fc46e59592828105d11ac11e1ba1a3bfba14
References: <gerrit.1781716678000.Iac54e6772b2c26a09227fd638d24d6e2aa35cec6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxNzE2Njc4MDAwLklhYzU0ZTY3NzJiMmMyNmEwOTIyN2ZkNjM4ZDI0ZDZlMmFhMzVjZWM2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <db566a6c17f2708a12371d7353ea564a4f803a3a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wZttw-00020g-U7
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: Fix 1-byte
 buffer overrun on NTLMv2 proxy responses.
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
Content-Type: multipart/mixed; boundary="===============5488969844489085084=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5488969844489085084==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fFWtW15M6q0="; charset=UTF-8

--fFWtW15M6q0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1713?usp=3Demail

to review the following change=2E


Chang=
e subject: Fix 1-byte buffer overrun on NTLMv2 proxy responses=2E
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix 1-byte buffer over=
run on NTLMv2 proxy responses=2E

An attacker controlling an HTTP proxy (or=
 performing MITM on the
plaintext pre-TLS proxy connection) can trigger a s=
ingle 0-byte
overrun to a buffer on the stack by sending a crafted NTLM Typ=
e
2 challenge response=2E

The effects of this depend on memory layout, but=
 could possibly lead
to a crashing OpenVPN client=2E

Reported-by: Tristan =
Madani (@TristanInSec)
CVE: 2026-11771

Change-Id: Iac54e6772b2c26a09227fd6=
38d24d6e2aa35cec6
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---=

M src/openvpn/ntlm=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)



  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/13/1713/1
=

diff --git a/src/openvpn/ntlm=2Ec b/src/openvpn/ntlm=2Ec
index 244ee94=2E=
=2E9c4edf9 100644
--- a/src/openvpn/ntlm=2Ec
+++ b/src/openvpn/ntlm=2Ec
@@ =
-317,7 +317,7 @@
     if ((flags & 0x00800000) =3D=3D 0x00800000)
     {
  =
       tib_len =3D buf2[0x28]; /* Get Target Information block size */
-   =
     if (tib_len + 0x1c + 16 > sizeof(ntlmv2_response))
+        if (tib_le=
n + 0x1c + 16 >=3D sizeof(ntlmv2_response))
         {
             msg(M_W=
ARN, "NTLM: target information buffer too long for response (len=3D%d)", ti=
b_len);
             return NULL;

-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1713?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2=
=2E7
Gerrit-Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6
Gerrit-Cha=
nge-Number: 1713
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>

--fFWtW15M6q0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1713?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Fi=
x 1-byte buffer overrun on NTLMv2 proxy responses=2E<br><br>An attacker con=
trolling an HTTP proxy (or performing MITM on the<br>plaintext pre-TLS prox=
y connection) can trigger a single 0-byte<br>overrun to a buffer on the sta=
ck by sending a crafted NTLM Type<br>2 challenge response=2E<br><br>The eff=
ects of this depend on memory layout, but could possibly lead<br>to a crash=
ing OpenVPN client=2E<br><br>Reported-by: Tristan Madani (@TristanInSec)<br=
>CVE: 2026-11771<br><br>Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec=
6<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>=
M src/openvpn/ntlm=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/13/1713/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ntlm=2Ec b/src/ope=
nvpn/ntlm=2Ec</span><br><span>index 244ee94=2E=2E9c4edf9 100644</span><br><=
span>--- a/src/openvpn/ntlm=2Ec</span><br><span>+++ b/src/openvpn/ntlm=2Ec<=
/span><br><span>@@ -317,7 +317,7 @@</span><br><span>     if ((flags &amp; 0=
x00800000) =3D=3D 0x00800000)</span><br><span>     {</span><br><span>      =
   tib_len =3D buf2[0x28]; /* Get Target Information block size */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (tib_len + 0x1c + 1=
6 &gt; sizeof(ntlmv2_response))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (tib_len + 0x1c + 16 &gt;=3D sizeof(ntlmv2_response)=
)</span><br><span>         {</span><br><span>             msg(M_WARN, &quot=
;NTLM: target information buffer too long for response (len=3D%d)&quot;, ti=
b_len);</span><br><span>             return NULL;</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1713?usp=3Demail">change 1713</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1713?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E7 </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa3=
5cec6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1713 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--fFWtW15M6q0=--


--===============5488969844489085084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5488969844489085084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5488969844489085084==--

