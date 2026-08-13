Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EC5C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nqrIZdbaa9X+wNj0iZMOi8DA7qiH679/6pfGG0D62z4=; b=d36+oX8quTVw7LMR+L0cQIF52P
	cyJBimRNOADChHT0HuhiX0sOIPZ0naOWCtAHXvZNzGWRzCJn171L1uGvh0PB9uvBIaHUAkhHt9xVU
	0pffCRz5WovsOvauDBtGlMrBXN87ph8q4mbLXLHoDqTI/f2XKq7OttVmLqyt+fEutEvQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wua9w-00019R-0N;
	Thu, 13 Aug 2026 18:28:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wua9u-00019K-0s
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WfyrboK3tkzyKiDGpTMpoCSlhCWaF/wqTS2K+uPASIM=; b=NoJemAGg2M+8uXJIiYH9uAaWXq
 19RdS2KSac7OJ1cyuSjONdFacegf1NxJJE/ApIePEeM7RTgx/KCkUCc4+h7MvAUMVUxgsbDD5LaxY
 HjV5tR3HxegHKQzGgLPg0eJsdxwURXsL68F30PXPFLpxjQzczdkgmgtJzXFNOisNcjAs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WfyrboK3tkzyKiDGpTMpoCSlhCWaF/wqTS2K+uPASIM=; b=e
 4X1VUTsmSmpnLTO1v/GYOfyzc0wMG50Cxqh4Jg6uUYRkI03TvZ3yRJpxuKyghz6zMtapK5eZod/K0
 FMPkRGIPuqrj2d/D8yrPuuALK17n6x0QKJgQS4AwYZDS1aCuvE6uGy1Bg792zl/Eyt6I6n0Pl7yxF
 ZKZbIGPKroXlW8tE=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wua9v-0002JF-7S for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:28:06 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4994c49f588so961615e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786645677; x=1787250477; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WfyrboK3tkzyKiDGpTMpoCSlhCWaF/wqTS2K+uPASIM=;
 b=P08O25AFclyelMdqyyEt0zMCXDxSgWUWurw5PipjY6dRjnkER2PSWwW+g9ZQ+HLUvj
 uzhCqR1M72AkmXOuReqVLmlb/8P8M3FoYe2wqwjJmtbTjJ1KU9MbB4BSHq6+vhd07nPB
 KsS719P+W6IMxhF+zRkhFiXmZfiyQbKMWq0Ei1SsYduWiPHB376DBsEeXKKTlgdhlth0
 m/h4PgBFMJmMg6Q4BT0KaopKbKjmhLyW/l4VYEctZxhxtfU/CalGDQOROo0h1oAqnadY
 t+w1MkcyG5rAFvobbhlGKbCYCmD8eioKLiQhydQsr/IcZuba2a6kLrhVNKpRh29/d6Pd
 3VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645677; x=1787250477;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WfyrboK3tkzyKiDGpTMpoCSlhCWaF/wqTS2K+uPASIM=;
 b=r5Z//SxpWkJZeX2JW80+LJiXSkej/nrrNQ5GBxBJkwa8vs8Io99KuiAkAErU8h+Hfu
 fW6OVCGsYE+Y5xkBVlWxBszldLeuseOFTkHeMVomOszQnWw9ur9KmbQNHgqeAaPT/vY4
 UPwtXCaX0+xUdE2QLWHJyDxNkwx0F81gkzVyb74mCO2ByOkRC3nFdyusHx4CjH+Eo59J
 uSVGRHzf/8CUWXW5uIjDu+Yl8Cln3p4+dq9063tzg7RyWipvnshhKX1bq8p0wFyV8loj
 iMqZLHpsyX3niuz6zOEd3ehPQgF5Rz5FmgWlEXzyk+p+14ogKTfXxoVCsAO9Gb2WP8OZ
 lF4A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcA4cn+uD6DTvQqOetrPfkA6vY1E+l1w5ouepAx6lLh5If1xU1PTXtrK+CvDxa9EuRYQJ61+wn+xkGKHMm@lists.sourceforge.net
X-Gm-Message-State: AOJu0YywRKSYRCkQzQ7LQwCa3KI0aqZDsNG6xCj90gxseOh2MIgFVYn/
 qVXDSJ8mpGz1zX1/jDPM3qKAImc0kEmy23i1I9DvY/o1r7PReGbdCFlmMRjafJTMSz47e+Pg28I
 xUJndhk3OlFD5P/gEYufvMg8JfX1BVZhEUo7Br//mf2VWkSg4BSQHnRqOLlfcK4L14Y/P
X-Gm-Gg: AR+sD116la5ylDuBtXSTUw1h2sSxUyckqKsLIrMBPa/dZgt3nV4h00ZAprjPGNxLLlx
 hmNCx7kjd6yZ5VfIKTUmmOugq98t2QWjcO6cBvtst+LAD7+/LZYWs6XXaiA27+HD9rZMdk9/28/
 WSclzqodMkdx6/4NMQJZTpY/Ryi9MX1YNeuky00d/sx4VmdIgxMaoG4tdb4SEFetBEY7qWJMeVv
 Ecz4wxBkMGNBFJimmqn+cxzz27n/WxoIWVRCNHKIEEXnWKdb5myMoNGWNJzaYf/4j0d9cQMdMf0
 0IXMJ82fG5e88ymT5H+q9wsPjrbGp10le8o3D9NoAa0azuccijF4iZVu1xR2Wm9qhaP0SKb0ZCu
 Y3BB6nvES3Te6K60TiKXocQfuw0xsAzoJ8VG+alMbwuGIgoJWz3UyOzZJfl/c3duhblD1cJvrjh
 /A9En5aBflOAl+N8DXYM0AGYaVO9YzfUokmPmkI8dyh5yOUCvRxURyAtcC+gu8grFvEeyIJJn1k
 9gh8u2dNdnTKvSY42rT1u5oZMmAeAhbOQfSyQxlwwoXS//b5E/UdfEGQMr+a5WG3A7aKIOSwbGJ
 /shXVepibEu2rAR+cmnTs6AbR3o/iaMjqsS1P3FvgCHq/NB8CLw=
X-Received: by 2002:a05:600c:3b90:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-49987a4f131mr3133525e9.1.1786645676951; 
 Thu, 13 Aug 2026 11:27:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b1063esm95488535e9.6.2026.08.13.11.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:27:56 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 18:27:54 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8887fa7ccf407d727c2b59397000149e45487e13
X-Gerrit-Change-Number: 1767
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1767?usp=email>
X-Gerrit-Commit: ad864a699245649191d347c152193c8e7f59d8b8
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 18:27:54 +0000
In-Reply-To: <gerrit.1782994293000.I8887fa7ccf407d727c2b59397000149e45487e13@gerrit.openvpn.net>
References: <gerrit.1782994293000.I8887fa7ccf407d727c2b59397000149e45487e13@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTk0MjkzMDAwLkk4ODg3ZmE3Y2NmNDA3ZDcyN2MyYjU5Mzk3MDAwMTQ5ZTQ1NDg3ZTEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <80f6c43c1bf719283d7f1a13619dd07e82977246-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wua9v-0002JF-7S
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Convert Changes.rst
 to Markdown
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7141713661575207579=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7141713661575207579==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9Hp5VsrG1Rg="; charset=UTF-8

--9Hp5VsrG1Rg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1767?usp=3Demail )

Change subject: Convert Changes=
=2Erst to Markdown
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
I suggest the followin=
g further edits to the =2Emd file:


```diff
diff --git a/Changes=2Emd b/Ch=
anges=2Emd
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -165,6 +165,8 @@

 **PQ=
E support for WolfSSL**

+**New environment variables for gateway redirecti=
on**
+
 Two new environment variables have been introduced to communicate d=
esired
 default gateway redirection to plugins like Network Manager,
 `rout=
e_redirect_gateway_ipv4` and `route_redirect_gateway_ipv6`=2E See the
@@ -2=
56,13 +258,19 @@
 this feature=2E This feature provided very limited statis=
tics (number of users,
 link bytes read/written) and we do not except any u=
sage because of this=2E

+**Warning when using `--push` without `--mode ser=
ver`**
+
 Using `--push` in a mode that is not `--mode server` will now pri=
nt a
 clear warning that this is an unsupported operation and might cause n=
egotiation
 failures=2E

+**Warning for `--reneg-bytes` and `--reneg-packet=
s` in DCO mode**
+
 `--reneg-bytes` and `--reneg-packets` do not work in DC=
O mode, and will
 now print an appropriate warning=2E

+**On-connect resolv=
ing of `--remote` in `--tcp-server` mode removed**
+
 On-connect resolving =
of `--remote` addresses in `--tcp-server` mode
 was not working since 2=2E4=
, so the code was completely removed=2E

@@ -380,6 +388,8 @@
 just allows O=
penVPN to be run on a system that be configured OpenSSL in FIPS
 mode=2E

+=
**`mlock` now checks available memlock-able memory**
+
 `mlock` will now ch=
eck if enough memlock-able memory has been reserved,
 and if less than 100M=
B RAM are available, use setrlimit() to upgrade the limit=2E
 See Trac #139=
0=2E Not available on OpenSolaris=2E
@@ -872,6 +882,8 @@
 to avoid client c=
onnections to IPv6-enabled servers leaking "around" the
 IPv4-only VPN=2E

=
+**`--ifconfig-ipv6` and `--ifconfig-ipv6-push` accept hostnames**
+
 `--if=
config-ipv6` and `--ifconfig-ipv6-push` will now accept hostnames and do
 a=
 DNS lookup to get the IPv6 address to use=2E

@@ -1117,7 +1129,7 @@

 **ke=
ying-material-exporter**

-Keying Material Exporter \[RFC-5705\] allow addi=
tional keying material to be
+Keying Material Exporter [RFC-5705] allow add=
itional keying material to be
 derived from existing TLS channel=2E

 **And=
roid platform support**
```



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1767?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I8887fa7ccf407d727c2b59397000149e45487e13
Gerrit-Change-Number: =
1767
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razva=
nc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Thu, 13 Aug 2026 18:27:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Label=
s: No

--9Hp5VsrG1Rg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1767?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1767?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">I suggest the following furt=
her edits to the =2Emd file:</p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;"><br>```diff<br>diff --git a/Changes=2Emd b=
/Changes=2Emd<br>--- a/Changes=2Emd<br>+++ b/Changes=2Emd<br>@@ -165,6 +165=
,8 @@</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"> **PQE support for WolfSSL**</pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">+**N=
ew environment variables for gateway redirection**<br>+<br> Two new environ=
ment variables have been introduced to communicate desired<br> default gate=
way redirection to plugins like Network Manager,<br> `route_redirect_gatewa=
y_ipv4` and `route_redirect_gateway_ipv6`=2E See the<br>@@ -256,13 +258,19 =
@@<br> this feature=2E This feature provided very limited statistics (numbe=
r of users,<br> link bytes read/written) and we do not except any usage bec=
ause of this=2E</pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">+**Warning when using `--push` without `=
--mode server`**<br>+<br> Using `--push` in a mode that is not `--mode serv=
er` will now print a<br> clear warning that this is an unsupported operatio=
n and might cause negotiation<br> failures=2E</pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">+**Warning=
 for `--reneg-bytes` and `--reneg-packets` in DCO mode**<br>+<br> `--reneg-=
bytes` and `--reneg-packets` do not work in DCO mode, and will<br> now prin=
t an appropriate warning=2E</pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">+**On-connect resolving of `=
--remote` in `--tcp-server` mode removed**<br>+<br> On-connect resolving of=
 `--remote` addresses in `--tcp-server` mode<br> was not working since 2=2E=
4, so the code was completely removed=2E</pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">@@ -380,6 +38=
8,8 @@<br> just allows OpenVPN to be run on a system that be configured Ope=
nSSL in FIPS<br> mode=2E</pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">+**`mlock` now checks available=
 memlock-able memory**<br>+<br> `mlock` will now check if enough memlock-ab=
le memory has been reserved,<br> and if less than 100MB RAM are available, =
use setrlimit() to upgrade the limit=2E<br> See Trac #1390=2E Not available=
 on OpenSolaris=2E<br>@@ -872,6 +882,8 @@<br> to avoid client connections t=
o IPv6-enabled servers leaking &quot;around&quot; the<br> IPv4-only VPN=2E<=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">+**`--ifconfig-ipv6` and `--ifconfig-ipv6-push` accept h=
ostnames**<br>+<br> `--ifconfig-ipv6` and `--ifconfig-ipv6-push` will now a=
ccept hostnames and do<br> a DNS lookup to get the IPv6 address to use=2E</=
pre><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">@@ -1117,7 +1129,7 @@</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"> **keying-material-exporter**</=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">-Keying Material Exporter \[RFC-5705\] allow additional k=
eying material to be<br>+Keying Material Exporter [RFC-5705] allow addition=
al keying material to be<br> derived from existing TLS channel=2E</pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"> **Android platform support**<br>```</pre></li></ul></li></ul><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1767?us=
p=3Demail">change 1767</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1767?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: I8887fa7ccf407d727c2b59397000149e45487e13 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1767 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner=
: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 1=
3 Aug 2026 18:27:54 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=


</body></html>
--9Hp5VsrG1Rg=--


--===============7141713661575207579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7141713661575207579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7141713661575207579==--

