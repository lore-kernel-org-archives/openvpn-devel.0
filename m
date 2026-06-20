Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C548ECD4F26
	for <openvpn-devel@archiver.kernel.org>; Sat, 20 Jun 2026 10:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RxLXo5DcwauoWHzmV2cZ8v5tPZDVy8m7Q2aQ38qQdbg=; b=InUCjCRbm6XKTDkWhzXCPexVzJ
	WUIXLfLf30ZUxhZX5l9jQwCcpBAeV8Du+C7J9kljYERjhLQPuMZgJh7qkUk+H/UXsCFnPiqvqtZjE
	mCS+A/jogwKr01YgxoKTD4Tqt7EcItUdOpvhn6xgiolDUPhgfczz6aJl1xzIoFZbHEaU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1waswl-0006nB-Ku;
	Sat, 20 Jun 2026 10:29:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1waswk-0006n3-Ga
 for openvpn-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 10:29:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sJ2qlKQcOOmtxCMmT2yJXUt7i1zs14Uo0HkT3hwj/5Q=; b=X5MR/GjC/6HKXiaoT0wK8tlWQa
 WbthsiB+0HYYGCYhb0iQ13EkwQSUltJBG5tp3PszflRax1GMBsbzjkwiKsztTKMpuL54oV9GRRF+C
 GoMnSbZiw8haOchXUvzZ7wlOVjZxUWE8ai06zQwYLuKrLYAk+6pyec7cGw0cg4A552SI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sJ2qlKQcOOmtxCMmT2yJXUt7i1zs14Uo0HkT3hwj/5Q=; b=U
 KMbwik/tgWzNuJYJ9KBRbLGVYFm2xI3VlFguEPIBA6XcfgGKtwS5qLB3QpegjBsD2wN1qPEVCeJ2s
 lJK54Twt22brgynSuiJF8XQY7yVfeK1OgJNOf/uQkeSTE6kaD6mcEjum9c5wwajZ6BRRbkvDd9iiz
 YLksKYh5bfbq02yg=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1waswk-0001In-1A for openvpn-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 10:29:07 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-45eeea039ebso1617071f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 20 Jun 2026 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781951340; x=1782556140; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sJ2qlKQcOOmtxCMmT2yJXUt7i1zs14Uo0HkT3hwj/5Q=;
 b=N0i8H8+Zi23xT3DSSeXYQH0qSvo8Mlak5F5huFB4elkiEh5ZwtYbQn4Xs8cvDzgKis
 P5Df+yO3RYjOQz5tMj6Gx+ACBpG5Cd1rs5ITSgSuf6dNi9H6uTeUD2cT+2VLly2Sp9g7
 Te/qhAeoI67Y+bqN/6FExAXLzN+tTKbr7WbBV5WieMqfrUQj0ZLXJHFFCM+HJp7fio8b
 8+venRTQ+/hCugDXufzSwlVA53uzapJ2puO4ZH5iPNQ7kGlo1Sh7hU27AZqPFm458RSb
 vd2aydb0FaaHQWACDnNdM1YJ8HxHcWW8slUGRFGYE+Z18AVmx/RCWfuxdASPfpKnS9sP
 0kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781951340; x=1782556140;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sJ2qlKQcOOmtxCMmT2yJXUt7i1zs14Uo0HkT3hwj/5Q=;
 b=bRujXbQlGph8BMxufBWqrFzDo5qBLH+cSJNZEOPm336Kwi9RCw4XFRaEBDPnlHboJ2
 Ui9V8TGM6ZPa+nbS58bsFJ/gkatL3Mot9UrBTpWcPYK4/Iwj4tWiaXGDeNcufX9PWpfz
 uz8POdbcE7/h7VmKDmRCsZPCBBNnjG6h7dca0Zs7IAEBrRtyTuU54GhKe+sgSCaSsrcu
 kdRczzRp0fN7YT2qyHhkuNPp2HJ10hqtRBw7sRRHCkmC3IQkrEwlA1WT1Bwm/f+fSQIN
 L2JKPGGhUu4Rn9gMyYCNSTtCLY5LNeUtkf3040/HiKa8+tb6Jvz4qjzgfyroT2PYzQKx
 ULNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gwIJOufd0HAjrNoKT5hLsuYhKv4HLm8kD3ETo+ha37BwiNSh41YC1R+K/+PQyp2jLNPGGIWgek9Tz9Riw@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwQGQGMZV83q0fVVQs+gskN2S4/b6tamruHwyxmrqKEdAJBxwOF
 tvDgoOwTQrBN2PUhe0TaDlVB+X00E342wXPHss0+DamMaCtrSSGucuGUpx22lI1lfGsIHDHDBY3
 qWhOto244ZmdU4jsevgVwLjBMHKxWYMPp3oOQqMHznBjKeUxVHvqbcFyDBvcTvJAZYGWb
X-Gm-Gg: AfdE7cnV4El1PyAvGZ+ZjoZWEtvXL8z3rLc3RlNqyUvWZKwa331mhHnbU8Ir6Auhzbe
 SoisPcftN7V3R4GN3LkhRW3MTT7ivms3aINbj88X2CMX/D+g2ymAmmuEtNXKzvVQzHTsPKMesOF
 /BiuZQIY2AOBDGU9nF6uASO4BaH1cX4RQgFA7zrvtaGdbRgGlV6GzqbR5JKBV+Rt2TtAbsYOuJR
 e4Y8FRILH6QTJbTCY8jSXeyJ6S+7jsltUFAjvJ9UZWUJw1Tk/2bD3SMTYySFGcEloyvHPZAO8II
 BlDepgvBUQWRHrWeIL+AI8DrwQIhKzQfbHAbHvsglP9ax+yfZFfxnYj3hu4orbYt4GAiycHvmeR
 Cu2CvV4XQ4oKNe91YCn3/xdhVvM/pXPNTGXhJhHrK1glK+LH6gEPHnCfHypv8JGgTtY5QPO1fI2
 clhRmMVFudKXBLLS9a3yyKQKK/T+OmN/A+1qQOc7APpTxaW4bSV8SwAzluwsR8UL0LxnrbD7fH0
 7UeECg4iPx1odlErHayAd/lFF4DsDSsHmuIp7dt1Zy+Ly4N6W8QfiPcBq/cWTCXB07v10W0kyW/
 bpE=
X-Received: by 2002:a05:6000:2486:b0:45e:f188:393d with SMTP id
 ffacd0b85a97d-46503175f8dmr12173255f8f.29.1781951338401; 
 Sat, 20 Jun 2026 03:28:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466667881b4sm6404571f8f.24.2026.06.20.03.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 03:28:58 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 20 Jun 2026 10:28:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6
X-Gerrit-Change-Number: 1713
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1713?usp=email>
X-Gerrit-Commit: 04309bfe0313c09edd02c29945893b9d7e2ca920
In-Reply-To: <gerrit.1781716678000.Iac54e6772b2c26a09227fd638d24d6e2aa35cec6@gerrit.openvpn.net>
References: <gerrit.1781716678000.Iac54e6772b2c26a09227fd638d24d6e2aa35cec6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxNzE2Njc4MDAwLklhYzU0ZTY3NzJiMmMyNmEwOTIyN2ZkNjM4ZDI0ZDZlMmFhMzVjZWM2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <98ca706f7c18cd7e02ed78525b3a4467e419af86-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1waswk-0001In-1A
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8373878549422434453=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8373878549422434453==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G7gt+OxNBQA="; charset=UTF-8

--G7gt+OxNBQA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1713?usp=3Demail )

Change subject: Fix 1-byte buffer overrun on NTLMv2=
 proxy responses=2E
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Fix 1-byte buffer overrun on NTLMv2 proxy responses=2E

An attacker=
 controlling an HTTP proxy (or performing MITM on the
plaintext pre-TLS pro=
xy connection) can trigger a single 0-byte
overrun to a buffer on the stack=
 by sending a crafted NTLM Type
2 challenge response=2E

The effects of thi=
s depend on memory layout, but could possibly lead
to a crashing OpenVPN cl=
ient=2E

Reported-by: Tristan Madani (@TristanInSec)
CVE: 2026-11771
Github=
: OpenVPN/openvpn-private-issues#116

Change-Id: Iac54e6772b2c26a09227fd638=
d24d6e2aa35cec6
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Acked=
-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1713
Message-Id: <20260618123729=2E18337-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg37218=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/ntlm=2Ec
1 file changed, 1 insertion(=
+), 1 deletion(-)




diff --git a/src/openvpn/ntlm=2Ec b/src/openvpn/ntlm=
=2Ec
index 244ee94=2E=2E9c4edf9 100644
--- a/src/openvpn/ntlm=2Ec
+++ b/src=
/openvpn/ntlm=2Ec
@@ -317,7 +317,7 @@
     if ((flags & 0x00800000) =3D=3D =
0x00800000)
     {
         tib_len =3D buf2[0x28]; /* Get Target Informati=
on block size */
-        if (tib_len + 0x1c + 16 > sizeof(ntlmv2_response)=
)
+        if (tib_len + 0x1c + 16 >=3D sizeof(ntlmv2_response))
         {=

             msg(M_WARN, "NTLM: target information buffer too long for res=
ponse (len=3D%d)", tib_len);
             return NULL;

-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-=
Branch: release/2=2E7
Gerrit-Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa=
35cec6
Gerrit-Change-Number: 1713
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <g=
ert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--G7gt+OxNBQA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1713?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Fix 1-byte buffer overrun on NTLMv2 proxy =
responses=2E<br><br>An attacker controlling an HTTP proxy (or performing MI=
TM on the<br>plaintext pre-TLS proxy connection) can trigger a single 0-byt=
e<br>overrun to a buffer on the stack by sending a crafted NTLM Type<br>2 c=
hallenge response=2E<br><br>The effects of this depend on memory layout, bu=
t could possibly lead<br>to a crashing OpenVPN client=2E<br><br>Reported-by=
: Tristan Madani (@TristanInSec)<br>CVE: 2026-11771<br>Github: OpenVPN/open=
vpn-private-issues#116<br><br>Change-Id: Iac54e6772b2c26a09227fd638d24d6e2a=
a35cec6<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>A=
cked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713<br>Message-Id: &lt;20260618123=
729=2E18337-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37218=2Ehtml<br>Signed-o=
ff-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn=
/ntlm=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/ntlm=2Ec b/src/openvpn/ntlm=2Ec</span><br><span>i=
ndex 244ee94=2E=2E9c4edf9 100644</span><br><span>--- a/src/openvpn/ntlm=2Ec=
</span><br><span>+++ b/src/openvpn/ntlm=2Ec</span><br><span>@@ -317,7 +317,=
7 @@</span><br><span>     if ((flags &amp; 0x00800000) =3D=3D 0x00800000)</=
span><br><span>     {</span><br><span>         tib_len =3D buf2[0x28]; /* G=
et Target Information block size */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (tib_len + 0x1c + 16 &gt; sizeof(ntlmv2_response))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tib_len=
 + 0x1c + 16 &gt;=3D sizeof(ntlmv2_response))</span><br><span>         {</s=
pan><br><span>             msg(M_WARN, &quot;NTLM: target information buffe=
r too long for response (len=3D%d)&quot;, tib_len);</span><br><span>       =
      return NULL;</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713?usp=3Demail">change 17=
13</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: release/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1713 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--G7gt+OxNBQA=--


--===============8373878549422434453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8373878549422434453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8373878549422434453==--

