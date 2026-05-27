Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B08CD4F54
	for <openvpn-devel@archiver.kernel.org>; Wed, 27 May 2026 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=aS0pkYuJFXV91Q1f98BspLHIjDwnDj3ZAjT2JfCoaLM=; b=GRH4/VEQOZHuKS
	BFhUfSkImJxSqL8/wDRAC2nKYDfVHH1mT/f1tohvy4MJwAYxXjvAkF5mjsr3qyQEoa6QJYzpZg/p7
	lowSbNW8Vb++UCjqQNxFlAio5RxoXaHSBm5bUV0+c8/f1GGWCZuzP/StYwY68gs3n/f3ijfYxrEr7
	l+E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSGQe-0001Pr-AI;
	Wed, 27 May 2026 15:44:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wSGQM-0001PU-NX
 for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 15:44:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nZKecH/ZiOHuhMEG+4cQKVMNqQCVL9ociXPBhaGMOlc=; b=f2KbJN2xRgPug0y4IeT8mk7ojG
 P6ETdjUvasfHxbGfsji7c4/Llpl2GpV/CYZa+x6cKjrESa5o+8p8auGlad+hdIcMExaFNjq8cuFCP
 wqzf3S3CgiylK33ddfOWBwJQCJ7UB9jwh8wedWdLBfasV9cl1Ne13kOEh65qMro2llAs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nZKecH/ZiOHuhMEG+4cQKVMNqQCVL9ociXPBhaGMOlc=; b=U
 p8DT3wVcnBcHFBgBP1aCNYwuD5XzEe8w6KcxbJF8nokjaUuCisxnzVRRInY3cIuMt0TawTB6OQpnx
 nC0CF51su814UD7KJb0yl64Fer5fDPnRhv+XYvE6+gIEMTXqTWC8WOv84ZDBfDgUNiW772QxHRABS
 5k92Ai5GnnJXu9Zg=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wSGQJ-0000Xa-9j for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 15:44:03 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so70530415e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 27 May 2026 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779896628; x=1780501428; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZKecH/ZiOHuhMEG+4cQKVMNqQCVL9ociXPBhaGMOlc=;
 b=BtdyfswUV1BtpkeBvlXOtKFYFzanqn4HcucVEpVGBRBiZ6bATMCUUoQV+DvWlSg5a6
 MQNvR5wvrpRjRqhkn1MbRHV4nPv87rMoyBYBN2sS14kw03qrOkzuV1I5edJ/vRr/Ug3q
 u+mVBUgRBFvTdaYvtxKNF8KaEDHr2c6YGUP0fGUDteguYLOROqbYUYsoWSvVKx7kMX3s
 pKOCOI+AsqlUuQPw9EhGMT4JC1OZIvqspLmT+cReYd2e+xXnJ6ZEbP9chE1VsTGjdtdB
 7HnGrLHraVXES4V8MAfP7oB+Mm2WvYyahkl99FLc4a7GLUTNekox10/GVhf7Z1jTTPDF
 L7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779896628; x=1780501428;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nZKecH/ZiOHuhMEG+4cQKVMNqQCVL9ociXPBhaGMOlc=;
 b=POFIqSwqzRTjG0ozJB++/4cLvxp9p5Gq9diZGmKSB7sGJT4B0lwwlDnQrwW8bx/VRL
 SuCLViNTd1rychNAFk7DZFT+z5ICwzgXrGAWfrg/ec5qKyOMl9o30RAMtJSx93F6btQF
 UwJGaPvaCA2FsS5CCq169N5oXQHgQErlOVqvKzLaaK6Rxb/A2jlJmvichjoZO7CpJNeA
 jL5Vd4p5pdQXUTA3JyBNFEFbeOTUBDNd21Q3GuVt/9qcig+m1CZdx24UfWBxRYUEEu92
 E19mCIqMEyOv9zyUizmLOHTZ5hJZcANomZNBy4iNa73mtD5e9BfyLyhP98vF5bCJmx7p
 JDQQ==
X-Gm-Message-State: AOJu0YyKItipSm+RaBv/c+aXuAAywhQOHICcYsRd3TV8UfHciheUsu2V
 FA389xUg8NgdV0zjUgbI6J7GXpl0yGeS2tnAiyexrhTS5fEbns5NdOggv2LwAgZDLks5XnbivoE
 HyMefVL2u5XunjKijdcDIm3GowJoTebNSCKNToUgemWl+bavVCk3pllMebmxCE/JlQhr4icy55o
 jcP4Kfww==
X-Gm-Gg: Acq92OGYunDqctxWkxG4bMd4aeC0Nf0jeOa0QO+mK6nb02PXryzBdeZ2d1uXIosv4or
 BE2nwBC8qpzV8ni5eZLu6HKyIZ4nmDO4mkThQvOxwyPTFnM4Wo/fhLb7FhofhpX7pllELLCp6+M
 srkFPbU8JTpeq5dquAOCyE9CUkzB7lLxjNKhLJ0bmWClFQEHcq/4f048fUMAdiM3/A7H43a2SL3
 wZYBjc3YD3HTGs/S2ekdYbiek1MuoUoHtYy9x2BQTvvElhntfGtsZqQDXv1V/kATkYWUN6CAc0I
 DKNUzmY59T3xUSeixhVwmsqaOCs+hM7KOwfmfAM6RLxe+2AxxQpvAlWjQ+UUB2Q/iTcwQ8Uw+nW
 +zw8x2pPQy2Fj+z/iufIjRwcJXt+V07bhdNlKP/F6EcG2e1kO/PAAl/d6ZTOv0HTVF+fbDV6kdZ
 MMLZNn5M36RwRX/r9upwwe0IuCqaD7O+tBxAhy/EyA9e4QI2kyU/IkuzhR1NTnJUryFoabJovQs
 y5pbCkb7Xjk15z45U4GglQpNKEbfbC5yOmG5GqeQlAe25nLq28Idz++kecGlFMwgLvvrHAhANqC
 RFTOh0Z9u2lScnMYXLNpH178
X-Received: by 2002:a05:600d:6450:10b0:48a:7a10:4f17 with SMTP id
 5b1f17b1804b1-4904249d125mr282179755e9.6.1779896628122; 
 Wed, 27 May 2026 08:43:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454ac676sm438822845e9.13.2026.05.27.08.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 08:43:47 -0700 (PDT)
From: "mrbff (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "mrbff (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 27 May 2026 15:43:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5
X-Gerrit-Change-Number: 1705
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1705?usp=email>
X-Gerrit-Commit: 62a69f3f1b48950d3ae9c825946cb448c4206908
References: <gerrit.1779896625000.Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5ODk2NjI1MDAwLkliNTZmYjUzZWMxYzBjMzBjOWFlY2JkMGNhNDQwZGUyYWZmYWQwNGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1df2c459320bc660999e4f2e0a00a34e33123ac9-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wSGQJ-0000Xa-9j
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: allow
 passing KEEPALIVE_TIMEOUT without KEEPALIVE_INTERVAL
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
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1773531910224572690=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1773531910224572690==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l2t8n2RHvBs="; charset=UTF-8

--l2t8n2RHvBs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1705?usp=3Demail

to review the following change=2E


Chang=
e subject: dco_linux: allow passing KEEPALIVE_TIMEOUT without KEEPALIVE_INT=
ERVAL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_lin=
ux: allow passing KEEPALIVE_TIMEOUT without KEEPALIVE_INTERVAL

Depends on:=
 https://github=2Ecom/OpenVPN/ovpn-net-next/commit/67f453e3146a646ef5f811e5=
a85c610537d80521

Closes: https://github=2Ecom/OpenVPN/openvpn/issues/911

=
Change-Id: Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5
Signed-off-by: Marco B=
affo <marco@mandelbit=2Ecom>
---
M src/openvpn/ssl=2Ec
1 file changed, 3 in=
sertions(+), 3 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/05/1705/1

diff --git a/src/openvpn/ssl=2Ec b/src/op=
envpn/ssl=2Ec
index d332359c=2E=2E0998bd6 100644
--- a/src/openvpn/ssl=2Ec
=
+++ b/src/openvpn/ssl=2Ec
@@ -1623,9 +1623,9 @@
 
     if (dco_enabled(opti=
ons))
     {
-        /* dco_set_peer() must be called if either keepalive =
or
-         * mssfix are set to update in-kernel config */
-        if (op=
tions->ping_send_timeout || frame->mss_fix)
+        /* dco_set_peer() must=
 be called if either keepalive, ping, ping-restart,
+         * ping-exit o=
r mssfix are set to update in-kernel config */
+        if (options->ping_s=
end_timeout || options->ping_rec_timeout || frame->mss_fix)
         {
    =
         int ret =3D dco_set_peer(dco, multi->dco_peer_id, options->ping_se=
nd_timeout,
                                    options->ping_rec_timeout, =
frame->mss_fix);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1705?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib=
56fb53ec1c0c30c9aecbd0ca440de2affad04b5
Gerrit-Change-Number: 1705
Gerrit-P=
atchSet: 1
Gerrit-Owner: mrbff <marco@mandelbit=2Ecom>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>

--l2t8n2RHvBs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>mrbff would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1705?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">dc=
o_linux: allow passing KEEPALIVE_TIMEOUT without KEEPALIVE_INTERVAL<br><br>=
Depends on: https://github=2Ecom/OpenVPN/ovpn-net-next/commit/67f453e3146a6=
46ef5f811e5a85c610537d80521<br><br>Closes: https://github=2Ecom/OpenVPN/ope=
nvpn/issues/911<br><br>Change-Id: Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5=
<br>Signed-off-by: Marco Baffo &lt;marco@mandelbit=2Ecom&gt;<br>---<br>M sr=
c/openvpn/ssl=2Ec<br>1 file changed, 3 insertions(+), 3 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/05/1705/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn=
/ssl=2Ec</span><br><span>index d332359c=2E=2E0998bd6 100644</span><br><span=
>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span>=
<br><span>@@ -1623,9 +1623,9 @@</span><br><span> </span><br><span>     if (=
dco_enabled(options))</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        /* dco_set_peer() must be called if either k=
eepalive or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         *=
 mssfix are set to update in-kernel config */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (options-&gt;ping_send_timeout || frame-=
&gt;mss_fix)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* dco_set_peer() must be called if either keepalive, ping, ping-restart,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * ping-exit=
 or mssfix are set to update in-kernel config */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (options-&gt;ping_send_timeout || o=
ptions-&gt;ping_rec_timeout || frame-&gt;mss_fix)</span><br><span>         =
{</span><br><span>             int ret =3D dco_set_peer(dco, multi-&gt;dco_=
peer_id, options-&gt;ping_send_timeout,</span><br><span>                   =
                 options-&gt;ping_rec_timeout, frame-&gt;mss_fix);</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1705?usp=3Demail">change 1705</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1705?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Ib56fb53ec1c0c30c9aecbd0ca=
440de2affad04b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
705 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>

</body></html>
--l2t8n2RHvBs=--


--===============1773531910224572690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1773531910224572690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1773531910224572690==--

