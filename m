Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEFF606C557
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=V6Pu1vmh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UTovh9HR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G7f8bpmp;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=InQjv82B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6m41XlaLDWBhI3tN4f6Cfutyq03ofsBK272GXxG1vYg=; b=V6Pu1vmhbrY8oBoNzLPgNJcqMB
	mgA0vDGZ01iimJYP8DIVwG+ajinPEZiq1hVffzARCQyPX8vYDxmrpjCrLHVwEIu8LZyL/R/s5l3Kr
	2xE1a2pmrdfIOLi/LEf35wWXsmjJ/dePvQ20hdv+z1R0Ll6/lafWem4ZIbE6rwbslf+8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNtI0-000000008An-2sFr;
	Mon, 02 Nov 2026 14:45:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNtHz-000000008Ah-2zOF
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:45:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kh2PPJjrwc1oS26j5bqzk4yd06B7+ONXjTlzbZgHlrQ=; b=UTovh9HRbNCuNCh5a8bpHPgycl
 bk/YMj0ox/oguh2RIp+E5XI4zIK3xBO1lNewEwr4JyK6/VdTJoy8zNRf+QabnCf68HjAjp6qtLoAD
 TXVAq2mGI5aAf3bBlMSmt4jcZpTbBfcH+3/0BctzCQbUaI4dTleUlxf+f0t5ILJg+Zw4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kh2PPJjrwc1oS26j5bqzk4yd06B7+ONXjTlzbZgHlrQ=; b=G7f8bpmpc5FVXK1WzPG41Rp38N
 5dXsdzNEyd6gNv1EY30sGa8vNFfBTV5PY49p9t4UvIcUoPq307FJya8QRqwiF8TeQ2vLcwBfpLAG2
 y8nBlLIjc073LbtpBMnibwkjThPbPaqAiNjV7CUpk92aWDhDrYRZnLAOnCwNg5UWn2ak=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNtHv-000000002CG-2iCk for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:45:35 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so23695095e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 06:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793630725; x=1794235525; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Kh2PPJjrwc1oS26j5bqzk4yd06B7+ONXjTlzbZgHlrQ=;
 b=InQjv82BlrIq01BDVVs4Gi5+opekzHS4e3OTDfuDV3zBQy+HNXMOX4Dgv3BQhbz8AC
 E7AYiVyckjrspPkh7Pq7Dr3hFiVnsgrutYZp6nFeUXu001WF8X1P9rGrkz3cgJauDE41
 SEOUHuwR2jKiPzUcOYo/zy6DLBGgANhJuDpfJYiqUbSuJFeglnPqOgp73i3YMNYKLbQ4
 JlQ2KBW60qKhdJM0pY5uV3QVS7GfxCYf4wDp4p7sUfI2esbfFy/9Ure/lTcXcbG2QaZh
 5tX/Iaoj4Ndf5Usf7VgXUsRQp3hZGmwdDr2lSZ3xEFkUEPuvoer/6WeuBmk45bGFC57B
 vBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630725; x=1794235525;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Kh2PPJjrwc1oS26j5bqzk4yd06B7+ONXjTlzbZgHlrQ=;
 b=VT6zz938EwV844L/ry0+EAd1r/qv/UlCLzikVHSKM7ifYUzoERIRFRYol72H3iH1Hg
 NCAlG/GH97xuDONkVQ0YvYRVx09MGURK76BflpMFT258Myole3XFlmgUVXqLaT1dKR0p
 4oVyAAUD85MAagS021XvvwSEhxSiArx/WE01mrDU3edmWeWAGXfXh0+hHQgqyMpVlxk4
 3+huzvpnMZHvZXuFK/aZTpi1LnwAABldNc2kZMVE6DG05Ms9pbkSNxS+mA4L8Qli3eQj
 AjyGkMIJoyv9QGPrn9QqaQy14uY9Zid4oj9+ncWwfdAHfLqY5nzVM+8GVO1cdnSMtEXb
 o9ug==
X-Gm-Message-State: AFq9FYIy1ImM9elWNgBGbXgRA/Hf3BzNEaktthGEqOgB69Mwnblfx0o0
 shUjxiWvDfeSpIHp7HnHCGRf0BMksSTD9JWDcu25ZILbOJKdnB8dyqWn03viWp5uqSjbAjCmI3g
 eBWG9BxeyQubugyFEcx7nBOECqCdslTDcPxrDBFZkxNY6J/Xn5clR1A+6PXjRpDPgemnb
X-Gm-Gg: AYBFou0OI5libaKGxWCmLGuPLedXHQ/ezAE/H6+c0HWz7ipd4k/7jmG05g4tT8xB65x
 jW0ft6ZlAKn6pfJNwkhv/oQt4HvtuFYoNZTyWaxDkku4qY9fTZ82zyYn9X4BYzxvva1krZZgkYh
 mh71cJ3Cm0z9GxA1Mqjtkurttrc+b8EcKZDz75m21Uwk6kXw3lF2rfQgOOurHStKOlzJZRLsKd4
 PTJ6kCkK3zn9sQB3PF3ku7h08+p0EmHsQLTKlAO420qG+jZYp9znMZ0iBppdJUGxvRbKOPpzwV3
 sUv++SgNp9vV93Uk2QECxVSANKc48jwvImFm5DvujrMB732LNA9OSq62DThV6tEPhwORHrkzHqF
 JIuZ4JozqtFBzHJ78zvvXOFul/Q5QTjnlokHFNhJHXMSsXQx5VGsorY2Z6TMcKccW6CKE/ofO5J
 BYDeC/bY7WKWpopxremylM3LF1cJTbSWWtM90uedFfPeIkERvpY7Z7ZRlxS8cpuZ7H38Tfy/i+3
 74/dgi6CBEeRrwNM8fzPAxeFSg3TGEUAZMZ4ICuJCn8oDI5oLknm4VAIGDt+n3ucXg3oTLC4xhU
 /rYU5eHy83x2V4X1Mhzudxk6pPh8ugk1Mc1oCYhjGX/jFSKYiI+O4lPhOe64IxbSVeK0h36i6LP
 BSJLv7bWoExDeMeNNRyCY82zW1Ym/HkfVa+PreNUfXjUIpyK0XggaIHNL/SPZ7oVuvtEGMcdvsJ
 /e7yvA4/I3WaC7vQ==
X-Received: by 2002:a05:600c:b8a:b0:4ab:c447:49df with SMTP id
 5b1f17b1804b1-4ac182dca8emr228616225e9.23.1793630723785; 
 Mon, 02 Nov 2026 06:45:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe77053fesm127071595e9.0.2026.11.02.06.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:45:23 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 14:45:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
X-Gerrit-Change-Number: 2085
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2085?usp=email>
X-Gerrit-Commit: 259326663c8fff86a5680687883f5577ee396aed
In-Reply-To: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
References: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MDcwMDAwLkliOTE2NGUxYzhmNWUwMmEyMjUzYmJiM2IyMzYzYTRmOWYzMWM4YmRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0c12eff1df689f1e7f59e694172bb5cde1de2024-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNtHv-000000002CG-2iCk
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: check
 parameters for NULL before strlen() in send_cc_message
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2060379307143552110=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2060379307143552110==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GvIhkmEPsAU="; charset=UTF-8

--GvIhkmEPsAU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, Frank Lichtenheld, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2085?usp=3Demail

to look at the new patch set (#3)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review+2 by Frank Licht=
enheld


Change subject: init: check parameters for NULL before strlen() in=
 send_cc_message
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

init: check parameters for NULL before strlen() in send_cc_message

ma=
nagement_callback_send_cc_message() called strlen(parameters) before
its ow=
n NULL check=2E Only count parameters and the separator when set=2E

Change=
-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
Signed-off-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
---
M src/openvpn/init=2Ec
1 file changed, 5 ins=
ertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/85/2085/3

diff --git a/src/openvpn/init=2Ec b/src/open=
vpn/init=2Ec
index 24cf532=2E=2E6c87865 100644
--- a/src/openvpn/init=2Ec
+=
++ b/src/openvpn/init=2Ec
@@ -299,7 +299,11 @@
 management_callback_send_cc=
_message(void *arg, const char *command, const char *parameters)
 {
     st=
ruct context *c =3D (struct context *)arg;
-    size_t len =3D strlen(comma=
nd) + 1 + strlen(parameters) + 1;
+    size_t len =3D strlen(command) + 1;
=
+    if (parameters)
+    {
+        len +=3D 1 + strlen(parameters);
+    =
}
     if (len > PUSH_BUNDLE_SIZE)
     {
         return false;

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b=
2363a4f9f31c8bdb
Gerrit-Change-Number: 2085
Gerrit-PatchSet: 3
Gerrit-Owner=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>

--GvIhkmEPsAU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #3</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2085?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ini=
t: check parameters for NULL before strlen() in send_cc_message<br><br>mana=
gement_callback_send_cc_message() called strlen(parameters) before<br>its o=
wn NULL check=2E Only count parameters and the separator when set=2E<br><br=
>Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb<br>Signed-off-by: Raz=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/init=2Ec=
<br>1 file changed, 5 insertions(+), 1 deletion(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/85/208=
5/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span>=
<br><span>index 24cf532=2E=2E6c87865 100644</span><br><span>--- a/src/openv=
pn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -=
299,7 +299,11 @@</span><br><span> management_callback_send_cc_message(void =
*arg, const char *command, const char *parameters)</span><br><span> {</span=
><br><span>     struct context *c =3D (struct context *)arg;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    size_t len =3D strlen(command) +=
 1 + strlen(parameters) + 1;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    size_t len =3D strlen(command) + 1;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (parameters)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        len +=3D 1 + strlen(parameters);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     if (len &gt;=
 PUSH_BUNDLE_SIZE)</span><br><span>     {</span><br><span>         return f=
alse;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2085?usp=3Demail">change 2085</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b=
2363a4f9f31c8bdb </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2085 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--GvIhkmEPsAU=--


--===============2060379307143552110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2060379307143552110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2060379307143552110==--

