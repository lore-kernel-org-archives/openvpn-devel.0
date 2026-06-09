Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E7ECD8CB9
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=oGTpqfdJfv9bdHKW/9C/Ug4waRZiKjv8eAllOMk8W5I=; b=hAZGnIQ/8KE9Vy
	nYFH0q+NUL4yQB0BSt10OTwVMNLym0aV0OYtjzlEoWFW8/HWaDBXlww13cj7417NTLEu9QY135W/H
	mu3xQGtgiscD6J07L/7wmbgLrvVvWFArSmvJlUSQ1tUjdQnnrDQtAAerwv10xOtKMHp1MEeE8r4dq
	9Is=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxv2-0006Fb-5p;
	Tue, 09 Jun 2026 14:59:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxv0-0006FL-Ai
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:59:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U/W/UkVwoE4a7tGEJLcOWivAAv7xvzq2POLwWBiugWQ=; b=Of4RvbrMAz7IyaGdsO5aNAmJm+
 svocTZLstE4tUQQG+S5gOq32uZ4GlMNab8Y8uIgqabHEtRNZ0/a7ztAciCaT0zXpq683eJI1m7rji
 6pbhQirLZM2sraHYTGfRDh9FXrbIHywbHWrxQkyJBJsOfgtcwhufGmqcBKICoUgVs2Bc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U/W/UkVwoE4a7tGEJLcOWivAAv7xvzq2POLwWBiugWQ=; b=V
 A27gF3c5UyrBC4Ruj+kUn7OkD1RSZInhksrcGI7P4cd4Y3RKADc9vfTF2mIvbBgsadh2iOGudo9bw
 vyLrsfbhDJBpEMYHAuk9pI96JSfdshI/BUeDz5zRzBf0TljWks3N7elH/LcyCEg+JPytkzBOwa9eT
 HgHm+jSYMLNgW2aw=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxuv-00006u-P7 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:59:03 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso64122865e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781017131; x=1781621931; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/W/UkVwoE4a7tGEJLcOWivAAv7xvzq2POLwWBiugWQ=;
 b=ZRTE6T3iMzVHMdYj1yHMsx57xhPvHyNAWDuT0/j54DgOPo42wx1GB9kPbSoRUQcOKZ
 8ZxDobazVcWY74KJ0XTabTCZmDwfT71OsFtsjlEkt8UWzz3N4JsdQr1/ei1PPyxLJj6O
 cpzB+6P9dmfMHvzfKqNyqJYX9UnuuiwEXHNrEutB1WBUiD9xGy8LnBTCf5ewKHEV9xEC
 k+thlne6+Aim1Yx9BpgD2CNJhjr0JxegkUOUlbr3VgEXF/vsGO8YgbstxJltxFL+2uuY
 U1pdWEdkksco39V+DP1/VuEs3NxSDJCouD7ffdg2etm8dRKYIfTzr40W0cDlAUA5eBfQ
 Nr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017131; x=1781621931;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U/W/UkVwoE4a7tGEJLcOWivAAv7xvzq2POLwWBiugWQ=;
 b=pe6q/4hLPlVGshiv1QC34vOihcnYQY/fH8Ml7Eg7fUiD5JATKlbzjPL6JPEHntoNdb
 DcVpWWrynuziuSzUn2MgVy3mLKtI1wxEDp0TZoPY8jpQtfXd5Sse2jbkcNts2T72YWIX
 K/T48NJtyIcQEpOR+HkbJBMc9aZCFFYMKblzcwAkXgQ1UmLSLk/TJ4ws53JEXYRskdiu
 XEwKI6paji75HOUOQpEC7IrI7Uzx4TP7gLcGiwqFnK2pa8Xa67kuEQrR9L1Y0xAoU28R
 /Ce/tkqQIGTBi2za/5JxD0ruiMCy/O9BNgEF2aDwR8JyN38fGBi+0dAxq6iPhI6MWaVF
 8wOQ==
X-Gm-Message-State: AOJu0YwaohYas+YcRvbk9Np2B4GlqU0ilDUIY2N0NprtRiXlaEBuohCv
 ud2y+ESSb/OVMLBd5FzMlz4Wu9fYJiRL4zQ4jfhB/3x94oAeVA3BSu7trwlsLlkJGGKggcEpRZa
 by9FgGfqhWAtXEgVh5w5UKYy4Ugvx+u5wVvxxGYYV2qQDEoBLqqVxXLLTcSlE3xeg8LklVnNhyh
 HtH9RLrQ==
X-Gm-Gg: Acq92OF0dMZgG7U5k/LAnC1x0MpM7r+fNE1vOO5YeicSShgkGepql+R7VatoDsRSD0r
 u/hyUaWaHxyblquTYXaI3TgPqene/iBP1WVTA4yFVUN4DmSdXaVPJf4ws2fme1fc2eZyOFW+jYe
 WIna1sK/qfdeakQ8/vj+Kl9xkedEBb5R4+/kHf5Ub/y19Nt6mJLIFYKaNMwp4C3OqHWi/M10R63
 16grSlscHVE6xApj1AbrNttAgWlDYZd7SnyrajzmbUhqf6Uwj2Oni9Jwa9VHjDrtxYMQTvuVuGK
 O5B/D3KRS0/zqzYE7ejYYbrpHHTTfwPWZewv9SIzLwf7dwUgurl1N37lqSeJopEQ50f1y6bIIz3
 jHSXH3GLZx4H/GaTBB5x2TAP1966ouqQVA/1RBbmhHrrPpO6SpXQWYN5uR4UrTdXTG9XjCziYz7
 6X/Ht/2K/B9sb5eoHTEmZqglToUJkvEQUpcmI61kS4YkLdrZ1E2GU/RjgfmgmTVE+494eywfaKT
 VlF04r82k/F689YBdMj+NuYVosXOc4N5GU1MYMEvQxS2hsiNDfG+ZqfW8LZpgsD2bFXNjAopX+J
 6gRlXUGZqvypKeGGxz1Taf9c
X-Received: by 2002:a05:600c:3ba4:b0:490:bad9:de43 with SMTP id
 5b1f17b1804b1-490c2525dacmr370941085e9.0.1781017130469; 
 Tue, 09 Jun 2026 07:58:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351d69sm112862201f8f.29.2026.06.09.07.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:58:50 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 14:58:49 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8a17d452e9e5690a5507d17129286142df6c88f1
X-Gerrit-Change-Number: 1711
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1711?usp=email>
X-Gerrit-Commit: de327d6ba42e622c7e7721f0e1491a9b5700031e
References: <gerrit.1781017122000.I8a17d452e9e5690a5507d17129286142df6c88f1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxMDE3MTIyMDAwLkk4YTE3ZDQ1MmU5ZTU2OTBhNTUwN2QxNzEyOTI4NjE0MmRmNmM4OGYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4ce01c38b16217ca973f0fa81a3937273cf59b35-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxuv-00006u-P7
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Switch to
 using VS 2026
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2332732513701403852=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2332732513701403852==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8gzZB1CSvqY="; charset=UTF-8

--8gzZB1CSvqY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1711?usp=3Demail

to review the following change=2E


Chang=
e subject: GHA: Switch to using VS 2026
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Switch to using VS 2026

Since Github wil=
l switch to windows-2025 image to use
VS 2026 at some point in the near fut=
ure (according to
https://github=2Eblog/changelog/2026-02-05-github-actions=
-early-february-2026-updates/#windows-server-2025-with-visual-studio-2026-i=
mage-now-available-for-github-hosted-runners)
enforce that switch to avoid =
any build failures=2E Since
we hardcode the VS version in CMakePresets=2Ejs=
on (and I
do not see an easy way to avoid this with CMake), we
need to over=
ride the generator value=2E We can switch the
default once our release infr=
astructure has been switched
to VS 2026=2E

Change-Id: I8a17d452e9e5690a550=
7d17129286142df6c88f1
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
---
M =2Egithub/workflows/build=2Eyaml
1 file changed, 4 insertions=
(+), 2 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/11/1711/1

diff --git a/=2Egithub/workflows/build=2Eyaml b/=
=2Egithub/workflows/build=2Eyaml
index 323645a=2E=2E4cab0ac 100644
--- a/=
=2Egithub/workflows/build=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ =
-138,7 +138,7 @@
         test: [argv, auth_token, buffer, cryptoapi, crypt=
o, misc, options_parse, ncp, openvpnserv, packet_id, pkt, provider, ssl, tl=
s_crypt, user_pass]
         build: [Release, Debug]
 
-    runs-on: window=
s-2025
+    runs-on: windows-2025-vs2026
     name: "mingw unittest ${{ mat=
rix=2Etest }} - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL"
     s=
teps:
       - name: Checkout OpenVPN
@@ -285,7 +285,7 @@
         VCPKG_BI=
NARY_SOURCES: clear;default,readwrite
         VCPKG_GIT_COMMIT_ID: 75672db=
6bd812b060482b0f00b5a16b18a0c0f07
 
-      runs-on: windows-2025
+      run=
s-on: windows-2025-vs2026
       steps:
       - uses: actions/checkout@df4=
cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
       - uses: lukka/get=
-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3
@@ -315,6 +315=
,7 @@
         with:
           configurePreset: win-${{ matrix=2Earch }}-r=
elease
           buildPreset: win-${{ matrix=2Earch }}-release
+          =
configurePresetAdditionalArgs: "['-GVisual Studio 18 2026']"
 
       - nam=
e: Run CMake with vcpkg=2Ejson manifest
         uses: lukka/run-cmake@5d55=
ea7949e25f69f0ecb516d8d572297e03a956 # v10=2E9
@@ -323,6 +324,7 @@
        =
   configurePreset: win-${{ matrix=2Earch }}-release
           buildPreset=
: win-${{ matrix=2Earch }}-release
           testPreset: win-${{ matrix=2E=
arch }}-release
+          configurePresetAdditionalArgs: "['-GVisual Studi=
o 18 2026']"
           testPresetAdditionalArgs: "['--output-on-failure']"=

 
       - uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d=
1fc6a0a # v7=2E0=2E1

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1711?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I8a17d452e9e5690a5507d17129286142df6c88f1
Gerrit-Change-Number: 1711
Gerr=
it-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-=
openvpn@rfc2549=2Eorg>

--8gzZB1CSvqY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1711?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">GHA: Switch to using VS 2026<br><br>Since Github will switch to window=
s-2025 image to use<br>VS 2026 at some point in the near future (according =
to<br>https://github=2Eblog/changelog/2026-02-05-github-actions-early-febru=
ary-2026-updates/#windows-server-2025-with-visual-studio-2026-image-now-ava=
ilable-for-github-hosted-runners)<br>enforce that switch to avoid any build=
 failures=2E Since<br>we hardcode the VS version in CMakePresets=2Ejson (an=
d I<br>do not see an easy way to avoid this with CMake), we<br>need to over=
ride the generator value=2E We can switch the<br>default once our release i=
nfrastructure has been switched<br>to VS 2026=2E<br><br>Change-Id: I8a17d45=
2e9e5690a5507d17129286142df6c88f1<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt;<br>---<br>M =2Egithub/workflows/build=2Eyaml<br>=
1 file changed, 4 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/11/1711/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows=
/build=2Eyaml</span><br><span>index 323645a=2E=2E4cab0ac 100644</span><br><=
span>--- a/=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=2Egithub=
/workflows/build=2Eyaml</span><br><span>@@ -138,7 +138,7 @@</span><br><span=
>         test: [argv, auth_token, buffer, cryptoapi, crypto, misc, options=
_parse, ncp, openvpnserv, packet_id, pkt, provider, ssl, tls_crypt, user_pa=
ss]</span><br><span>         build: [Release, Debug]</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: windows-2025<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    runs-on: windows=
-2025-vs2026</span><br><span>     name: &quot;mingw unittest ${{ matrix=2Et=
est }} - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL&quot;</span><b=
r><span>     steps:</span><br><span>       - name: Checkout OpenVPN</span><=
br><span>@@ -285,7 +285,7 @@</span><br><span>         VCPKG_BINARY_SOURCES:=
 clear;default,readwrite</span><br><span>         VCPKG_GIT_COMMIT_ID: 7567=
2db6bd812b060482b0f00b5a16b18a0c0f07</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-      runs-on: windows-2025</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      runs-on: windows-2025-vs2026=
</span><br><span>       steps:</span><br><span>       - uses: actions/check=
out@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span> =
      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=
=2E3=2E3</span><br><span>@@ -315,6 +315,7 @@</span><br><span>         with:=
</span><br><span>           configurePreset: win-${{ matrix=2Earch }}-relea=
se</span><br><span>           buildPreset: win-${{ matrix=2Earch }}-release=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          configure=
PresetAdditionalArgs: &quot;[&#39;-GVisual Studio 18 2026&#39;]&quot;</span=
><br><span> </span><br><span>       - name: Run CMake with vcpkg=2Ejson man=
ifest</span><br><span>         uses: lukka/run-cmake@5d55ea7949e25f69f0ecb5=
16d8d572297e03a956 # v10=2E9</span><br><span>@@ -323,6 +324,7 @@</span><br>=
<span>           configurePreset: win-${{ matrix=2Earch }}-release</span><b=
r><span>           buildPreset: win-${{ matrix=2Earch }}-release</span><br>=
<span>           testPreset: win-${{ matrix=2Earch }}-release</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+          configurePresetAddition=
alArgs: &quot;[&#39;-GVisual Studio 18 2026&#39;]&quot;</span><br><span>   =
        testPresetAdditionalArgs: &quot;[&#39;--output-on-failure&#39;]&quo=
t;</span><br><span> </span><br><span>       - uses: actions/upload-artifact=
@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1711?usp=3Demail">change 1711</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1711?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I8a17d452e9e5690a5507d17129286142df6c=
88f1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1711 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>

</body></html>
--8gzZB1CSvqY=--


--===============2332732513701403852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2332732513701403852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2332732513701403852==--

