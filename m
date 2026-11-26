Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C70A606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eulfypum;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S1mlwpnT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TVkmbS2J;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LeLRaq5w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=2oaUx3LyjrR2srV+W0rv3b99Ornw1frZJaGZcoV+/nU=; b=eulfypumMTJm5cOpO8IJIZUWfk
	FzoM0/wZORK4jkPKD9rvDoGJk4Rom4H4zbUe9OhY5MatVPV3ySb3Fv7Vcrj6pcj1PjiJjsfBFst3Q
	WyHhDIY70nUlKEasSCJ3zALpo96TWacxCWMyXSH3ylTHbDjlGiayXykqg48XWCixJ57c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWTGX-00000000407-3VhI;
	Thu, 26 Nov 2026 06:47:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWTGV-000000003zx-3nGM
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 06:47:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OWb6/v78+GvKPwiDnuO8KCtP7LzCyYktZIsSSICBxXw=; b=S1mlwpnTeh+PQaLTdLJ4pSQMxr
 FN90CeESW52MI61CCzE5V5fVMNM4diULkooXGSQqoohbxnkKaKy4YAMmKGelinVyscDpWKTScOkEB
 o9U+P4qUsWkI2Bvd8lLxwpPJ5z+RgrFTNqxbx/XcD8SjkPzlGjZdlLFAFOJlGMrEdT7k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OWb6/v78+GvKPwiDnuO8KCtP7LzCyYktZIsSSICBxXw=; b=TVkmbS2JGcj1K0jHpAhsqX3Gm1
 qD8pKmA4Y43D/2NK+vdLE8n+bDv9EeAOjsEdkgSqcW+Qli3wiWWIhpzduf1qZdG3XF7MFZnsbXeS1
 wYAhs8+cakFt4Abivt8b/zJT7L8j6N0x8Az1SlrUY31Lu6ORQQq66etiPsVl3v9grlXU=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWTGS-000000003jV-11yX for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 06:47:31 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so66226345e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 22:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795675642; x=1796280442; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OWb6/v78+GvKPwiDnuO8KCtP7LzCyYktZIsSSICBxXw=;
 b=LeLRaq5wO2Ua03z+17S6XzVo5QTSr6Dq+lOXoAH4g/GLCadkO8YIbYVs87s9zma4dX
 LbI4g1EtXcNAFMkeNt0/NiJa98cal7BeGj8Pn5aRy1FGhLE1maTwtjQnmCUcYYaFUkx8
 5BKAgq8GBKjfWu7/NaSwk1ZX+5tBuj2A2n1dLyDgc3y9cHzEyyho4dKlmWdlx5zHKKIO
 jqMyrgcrI2sz/BJyl+Xe1SfewxJjlMG35Ai2XRjEkOEhNBqd0w7jJpG2014hGwvsQXvI
 94/RUTh0QvJR89CE6kP31a6orN1QkiftdayVYrk4E08CEdn1eo/TJj5peP22QXZBydk9
 EqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795675642; x=1796280442;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OWb6/v78+GvKPwiDnuO8KCtP7LzCyYktZIsSSICBxXw=;
 b=Hc6eOfbm7Di5JPRnae75LuXNLc941JSn3gkZ3icp+RwuH38Hsl7HWfnfhwIVIiEgMZ
 bjLXCwyZdhXqQns2hgA9TcWKXvfzApVRo9C4c7UwdqblpCF8AxLXzNRAkpNaV02itnuQ
 OgEvymD3GvS+q39oFfw7uiwGyKSnvQqHYUh6FNZ5woe/SaBHOdaIMPME3efbi1SY93mc
 0m12h81qCLDi0xmaVkBlkj8vel4QLLkhAfZciMSxTJjMFxMGInHPz/4pRHICMxaA0mXU
 j71cVMXnjoI5fOr5hZLeLFxpPZzEgU2gVwbCDVj7ePA9nTqVU5YjKhQOZ0olYb8IX8pr
 UZfw==
X-Gm-Message-State: APuU4Z/ctWu2RKuXT/LJazwO66bXxGlRbaE0FV6XB+sC3wo0pzNJ0kiY
 PpPqbJELxMFWKahaIrQjQ4H9TqzO3Pqli1Wu2TCObd8dVea4HUF+fZIt1hPHZ3jOqG52dXEYpeW
 k7VeM5PYNM50HE+KfoS45Li3bROPvwaSd6nibU+BpX0Ku99GY+e3JaJ5VLKB0GmMEyWD+eq7s+S
 komCIHfA==
X-Gm-Gg: AZFdTZduaAgcqMrWd3hmr9dohdsBWG9uwYa4ZWWRSwM8tl+3E/UcCHKdSnraZcGpoMz
 G9O2ZLw7xbiwHNLdvHHJUOw8y1Wop7AKE+ngOyVTmcB53+doJlRUUlGaiccOaTPCWudkJPJU9H2
 ZrgxvGPOlSaMqy+Xhj3zmgbEfPQ3W9tJ4+fZloDMHu6HxfTULLlZwJv/xWMlyOt8Cd2d0l19Ehc
 YL46uB+ZmL5eqyv2AQYuE5bS3mqEnQdviwQaU3G/O0IfSHe4lSSGetE8uiftJ7ravL4zB4H/fAI
 r9vZz2Am0+wWXXJ9a/hEQg3rTWbtM+MftH7i2J0BGW06yWtfI9aQuChe+SpancRcObkyTzy/94F
 zsrR2GR+EXHTmoReVgb2jNyiZxE6CLPs+P+A591mOtIPJ4u1/SpDvruoR8lUO42hHdG7rQHuki9
 ICngL/TtmVgEa2jDIr6e3nXFYZenGkBrKKg2VHXuYu8o+7av/pAWDvAs/VNMVkkkjoxwL7rO8YN
 UfWGnyo7HWuNUNCW/+62YGaV1IzhG3rEkmtGF+zF1a0NP9F3a+ITjdT7cLfPcdcjlbgoDmLdbjV
 wwDgE9NyJkGkU8NAYBgovOOsldebXHggA/mjya3DiVzOoTAn46p3J7TLUrVSHn2tNWZXMA6NX6B
 br1BeaGtmgEr+GEtF2S23tkE0fynrLxdKyH7xxaTS+VHwwVZSrO77loxCW2aUZTLG/+bvqcLAd9
 t08uccb6gyPCYv6F4=
X-Received: by 2002:a05:600c:6749:b0:4bb:8508:7fb3 with SMTP id
 5b1f17b1804b1-4bb8881c3b3mr373631195e9.11.1795675641517; 
 Wed, 25 Nov 2026 22:47:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399d52sm559507835e9.6.2026.11.25.22.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:47:21 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 06:47:20 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I247474b43ac7a22d16a150a856ae5643657eacdb
X-Gerrit-Change-Number: 2347
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2347?usp=email>
X-Gerrit-Commit: d89d39e832638762b1fa50a2017ee699258f058f
References: <gerrit.1795675637000.I247474b43ac7a22d16a150a856ae5643657eacdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkkyNDc0NzRiNDNhYzdhMjJkMTZhMTUwYTg1NmFlNTY0MzY1N2VhY2RiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <715a99d500ab74b0302d87b5751b86905e505ec3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWTGS-000000003jV-11yX
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns-scripts: don't
 re-evaluate collected search domains
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6642318379771818751=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6642318379771818751==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3pAy6L+aS8k="; charset=UTF-8

--3pAy6L+aS8k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2347?usp=3Demail

to review the following change=2E
=


Change subject: dns-scripts: don't re-evaluate collected search domains
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dns-scripts: =
don't re-evaluate collected search domains

$domains was expanded before ev=
al, so the domains collected so far
were parsed as shell code again=2E Esca=
pe it like the indexed variable=2E

Change-Id: I247474b43ac7a22d16a150a856a=
e5643657eacdb
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
---
=
M distro/dns-scripts/haikuos_file-dns-updown=2Esh
M distro/dns-scripts/reso=
lvconf_file-dns-updown=2Esh
M distro/dns-scripts/systemd-dns-updown=2Esh
3 =
files changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/2347/1

diff --git a/distro/=
dns-scripts/haikuos_file-dns-updown=2Esh b/distro/dns-scripts/haikuos_file-=
dns-updown=2Esh
index e19b2b7=2E=2E04e9e26 100644
--- a/distro/dns-scripts/=
haikuos_file-dns-updown=2Esh
+++ b/distro/dns-scripts/haikuos_file-dns-updo=
wn=2Esh
@@ -75,7 +75,7 @@
 
     test -z "$dns_search_domain_1" || {
      =
   for i in $(seq 1 6); do
-            eval domains=3D\"$domains\$dns_sear=
ch_domain_${i} \" || break
+            eval domains=3D\"\$domains\$dns_sea=
rch_domain_${i} \" || break
         done
         text=3D"${text}search $d=
omains\n"
     }
diff --git a/distro/dns-scripts/resolvconf_file-dns-updown=
=2Esh b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh
index 8d23ed6=2E=
=2E78bf9d3 100644
--- a/distro/dns-scripts/resolvconf_file-dns-updown=2Esh
=
+++ b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh
@@ -75,7 +75,7 @@
=
 
     test -z "$dns_search_domain_1" || {
         for i in $(seq 1 6); do=

-            eval domains=3D\"$domains\$dns_search_domain_${i} \" || break=

+            eval domains=3D\"\$domains\$dns_search_domain_${i} \" || brea=
k
         done
         text=3D"${text}search $domains\n"
     }
diff --gi=
t a/distro/dns-scripts/systemd-dns-updown=2Esh b/distro/dns-scripts/systemd=
-dns-updown=2Esh
index 553056b=2E=2E3bdaa4b 100644
--- a/distro/dns-scripts=
/systemd-dns-updown=2Esh
+++ b/distro/dns-scripts/systemd-dns-updown=2Esh
@=
@ -227,7 +227,7 @@
 
         test -z "$dns_search_domain_1" || {
         =
    for i in $(seq 1 6); do
-                eval domains=3D\"$domains\$dns=
_search_domain_${i} \" || break
+                eval domains=3D\"\$domains=
\$dns_search_domain_${i} \" || break
             done
             text=3D=
"${text}search $domains\n"
         }

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2347?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I247474b43ac7a22d16a150a856ae5643657eacdb
Gerrit-Chang=
e-Number: 2347
Gerrit-PatchSet: 1
Gerrit-Owner: Heiko Hund <heiko@ist=2Eeig=
entlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--3pAy6L+aS8k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">dns-scripts: don&#39;t re-evaluate collected search domains<br><b=
r>$domains was expanded before eval, so the domains collected so far<br>wer=
e parsed as shell code again=2E Escape it like the indexed variable=2E<br><=
br>Change-Id: I247474b43ac7a22d16a150a856ae5643657eacdb<br>Signed-off-by: H=
eiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M distro/dns-scrip=
ts/haikuos_file-dns-updown=2Esh<br>M distro/dns-scripts/resolvconf_file-dns=
-updown=2Esh<br>M distro/dns-scripts/systemd-dns-updown=2Esh<br>3 files cha=
nged, 3 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/2347/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/distro/dns-scripts/haikuos_file-dns-updown=2Esh b/distro/dns-scr=
ipts/haikuos_file-dns-updown=2Esh</span><br><span>index e19b2b7=2E=2E04e9e2=
6 100644</span><br><span>--- a/distro/dns-scripts/haikuos_file-dns-updown=
=2Esh</span><br><span>+++ b/distro/dns-scripts/haikuos_file-dns-updown=2Esh=
</span><br><span>@@ -75,7 +75,7 @@</span><br><span> </span><br><span>     t=
est -z &quot;$dns_search_domain_1&quot; || {</span><br><span>         for i=
 in $(seq 1 6); do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         eval domains=3D\&quot;$domains\$dns_search_domain_${i} \&quot; || =
break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ev=
al domains=3D\&quot;\$domains\$dns_search_domain_${i} \&quot; || break</spa=
n><br><span>         done</span><br><span>         text=3D&quot;${text}sear=
ch $domains\n&quot;</span><br><span>     }</span><br><span>diff --git a/dis=
tro/dns-scripts/resolvconf_file-dns-updown=2Esh b/distro/dns-scripts/resolv=
conf_file-dns-updown=2Esh</span><br><span>index 8d23ed6=2E=2E78bf9d3 100644=
</span><br><span>--- a/distro/dns-scripts/resolvconf_file-dns-updown=2Esh</=
span><br><span>+++ b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh</sp=
an><br><span>@@ -75,7 +75,7 @@</span><br><span> </span><br><span>     test =
-z &quot;$dns_search_domain_1&quot; || {</span><br><span>         for i in =
$(seq 1 6); do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     eval domains=3D\&quot;$domains\$dns_search_domain_${i} \&quot; || brea=
k</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            eval d=
omains=3D\&quot;\$domains\$dns_search_domain_${i} \&quot; || break</span><b=
r><span>         done</span><br><span>         text=3D&quot;${text}search $=
domains\n&quot;</span><br><span>     }</span><br><span>diff --git a/distro/=
dns-scripts/systemd-dns-updown=2Esh b/distro/dns-scripts/systemd-dns-updown=
=2Esh</span><br><span>index 553056b=2E=2E3bdaa4b 100644</span><br><span>---=
 a/distro/dns-scripts/systemd-dns-updown=2Esh</span><br><span>+++ b/distro/=
dns-scripts/systemd-dns-updown=2Esh</span><br><span>@@ -227,7 +227,7 @@</sp=
an><br><span> </span><br><span>         test -z &quot;$dns_search_domain_1&=
quot; || {</span><br><span>             for i in $(seq 1 6); do</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                eval domains=3D\&=
quot;$domains\$dns_search_domain_${i} \&quot; || break</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                eval domains=3D\&quot;\$=
domains\$dns_search_domain_${i} \&quot; || break</span><br><span>          =
   done</span><br><span>             text=3D&quot;${text}search $domains\n&=
quot;</span><br><span>         }</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demail">change 234=
7</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I247474b43ac7a22d16a150a856ae5643657eacdb </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2347 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;=
heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--3pAy6L+aS8k=--


--===============6642318379771818751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6642318379771818751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6642318379771818751==--

