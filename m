Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9432CC982FF
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=8jX9+GIjN/zOxee9Pvk1oIhdpQRPJk/smm3k6hD04Qg=; b=TEK0Kj5tjfPOkM
	Vjrj4teCFKdZ9nYR6hHAiapBgfUbkYEiOMSuv9AXTkgFlLt0xN5PPqKzgmzFjR1bxiAOqiDuNETXX
	ACOrPcgLqAWY8iZcqXFqXyESMyA6yjPfrI5jRnR5cLbdSwO5HbaEfxmeIiYdeBaoeqi6M5hx38jOo
	Sqw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8zYI-00062M-7X;
	Tue, 22 Sep 2026 12:24:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8zYG-00062C-8n
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:24:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qONrOhpNhIZ/3rtlqMuvGDLj3X3vPm3Ow3It7W/TZqY=; b=LgJTgq1IuioFacWtVKTOWJ0dIh
 ++WOxkPQiiRWyHGnQ8Ga9OOWFgeOS8RlCxY9w4mN60ujrpDz8noODn5ogKQRJqmoWP7nblm1kl9cc
 nmg6gf2vjTc/j4blYQR3wMLyRd1vO25JagpgX3Z5xRcbowRz6vrXYssFYgsMtSXN1MXY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qONrOhpNhIZ/3rtlqMuvGDLj3X3vPm3Ow3It7W/TZqY=; b=I
 BpzWZC6y8pnOnQec99eUUMItoWT4YoRnhvmQESBneFyt+KBvFHBX9AsI3uwEr5Vfp6ulYHq+/GSft
 QtFh0Dhesjx7pildINhjLRXYaXQYQeNDW4Kozt68+pju6q+WReIUxFA6GU2ywdOtszbnmIDCHnZjF
 tyClgyWfEkUjLrzM=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8zYC-0002zz-6l for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:24:45 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so29034875e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790079878; x=1790684678; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qONrOhpNhIZ/3rtlqMuvGDLj3X3vPm3Ow3It7W/TZqY=;
 b=USEEjLGhs9mJk4Tp0psa/Ir0vE7vADLdI0gSkjxwLYvvDj2s/kPjYRX1HAJsEdtA8h
 tMT0eXLkn9hcc1LDSGIPDTGrl7WaepRt7mL+SNXZDPEogysQMwfiA7yNTG2cX8QgV92X
 kPFQ7m83aSok7WW8uh3jKWnoyzrAUkuBvSMJDEeUncxnaPix4y8s7cJJfAgGMh+lq0Qc
 pHTOZpfDq5orzHDhLvud7gHGpAUoeH0qPUwXk+GDeDYG+P7qf23jMY70PQe9YuRZv4TB
 YBFYx9P67537/ZIWfhppzB/lGxoalImXNg+7Lrd9if4MoDbgeoQzM26cjQ30wvKbaKef
 eI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790079878; x=1790684678;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qONrOhpNhIZ/3rtlqMuvGDLj3X3vPm3Ow3It7W/TZqY=;
 b=FsLVQ425SBvzaay7AzEufEZAEXK1xFKzxVcxTD/Kv+OVNJDxSnxu/rT0TOUEl6yhou
 R6+AwpKp16wM5co4RXaKz4onuFRHsrIl9vzCuTuiIj5798rb5B9YIyQpCG9x2MwT4t4o
 e6Aox+7+/MvRv2siA6bvJoIQvZpnX+8DB8wnpWBOy4K9Y5dgzPg/qnNSaYUqpXW06Yj6
 FBMayaQjHiEgBZUosSKAYD/n7pSur6mT+j+S8v72lWeGi/XRiUkvFNZ3InWVuMAdRKPV
 mTxM1p98skSDPVLzJLpRmHOheJJr5iVAQMEgpx+XwLw7AUqBbHrxsSAbzxig84FsRFfH
 7aCQ==
X-Gm-Message-State: AFuF++lO4AzKYpMJlilz1RwXBSmrXXkPHOpp+wYSG83VsX+WCqX5yYaC
 PHBaTJsXR+NqiBHi7MH0YzHjapkyo6TznbSab1eNTlH08gHT/ad5okHiFMozjBoUWwsdVmGkgUX
 63pjwyjoqzfaEwBEoCq03xP15CevJj24tAowr/EJjUw5GHrs7d+Cw9Y7RAa7tqsT/nwXVuldgcl
 EwHpTUew==
X-Gm-Gg: AYBFou1/yLEB7uOhMbGDH0JrSsrVOG3xFySYCgWGGICjtmtBAZFFGwG4x5S0S8Cxd7f
 OS4BIN/Belr2MGCvzRmp39/JobY8lB7glZssnZLzw3eA7nas8x7kvX+fFsMU97+geUuPebeDUsO
 YoMLj2PDPPoVitHGuCiSdpq8VK8OLsqVXLAsAwFwCogiu2w2M0bxbBxpTejtOQ5wcmmtiofShiI
 WaIPLDttxilS7papQwMsfSblTTuNfIdlD8OGFjwXICtnd7ATCrla3SRXpi/amnSb8uYE5+d8Uis
 FLw0dOZZb7lx9i7002vHSCS0MB8KGdav7tjqKBq7wvTCeobY0Qc/f4YisO35ZR/jz1rulcEfubo
 lfIWPwiw70vZEWiHFWTgHOIBaGuDTWxoVosGnpkp3EDoz9FTNndX9gbij7ZZ4OeoNOB9wJU1dRz
 Jlx5OOgZz3KDiBNY8d1bjEpOwknzVRnA/pS+adhs4cI86pMFW4wUJNMF4AlQ4mNwn84FIzgwIca
 v5f5uZuf984MNa51Ac0hhCeRCDBGvaTKJWlzR0Ap72fdIME4xxBGCSdX+Iwc+Ue0Ckmpn3vbHpi
 GLTOYzaBmjOP8OpcfXh+nCdNISpSaQhd6MOYTBt1pZxMybQJN+pNaHXUwOPbbL8eARnODFTT
X-Received: by 2002:a05:600c:83c8:b0:49c:ff3c:973f with SMTP id
 5b1f17b1804b1-49fc573f531mr188455315e9.24.1790079877509; 
 Tue, 22 Sep 2026 05:24:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaf8a0bsm36123595e9.3.2026.09.22.05.24.36
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:24:36 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 12:24:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib31928529d10c7722e1f08e9ca7ff596bdebe840
X-Gerrit-Change-Number: 1943
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1943?usp=email>
X-Gerrit-Commit: 734ac19b1953b4b09993bbd72e7271245e8dd613
References: <gerrit.1790079868000.Ib31928529d10c7722e1f08e9ca7ff596bdebe840@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkliMzE5Mjg1MjlkMTBjNzcyMmUxZjA4ZTljYTdmZjU5NmJkZWJlODQwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <92d9f0776fdceec0767961747e920f88d36efb4e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x8zYC-0002zz-6l
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Rename
 --enable-debug to --enable-developer-debug and turn it off
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4343688815782360289=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4343688815782360289==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jnd1WzKc2E8="; charset=UTF-8

--Jnd1WzKc2E8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1943?usp=3Demail )


Change subject: Rename --enable-deb=
ug to --enable-developer-debug and turn it off
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Rename --enable-debug to --enable-develo=
per-debug and turn it off

Since the verbose logging is now always enabled
=
(apart from --enable-small), --enable-debug now only covers true
debug opti=
ons like gremlin=2E

Also rename the option to --enable-developer-debug to =
ensure
existing build script/maintainer do not enable this option
by defaul=
t=2E

Change-Id: Ib31928529d10c7722e1f08e9ca7ff596bdebe840
---
M CMakeLists=
=2Etxt
M Changes=2Emd
M config=2Eh=2Ecmake=2Ein
M configure=2Eac
4 files ch=
anged, 10 insertions(+), 4 deletions(-)



  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/43/1943/1

diff --git a/CMakeLists=2Etxt=
 b/CMakeLists=2Etxt
index 6eb5954=2E=2Ed553697 100644
--- a/CMakeLists=2Etx=
t
+++ b/CMakeLists=2Etxt
@@ -40,6 +40,7 @@
 option(ENABLE_PKCS11 "BUILD wit=
h pkcs11-helper" ON)
 option(USE_WERROR "Treat compiler warnings as errors =
(-Werror)" ON)
 option(FAKE_ANDROID "Target Android but do not use actual c=
ross compile/Android cmake to build for simple compile checks on Linux")
+o=
ption(ENABLE_DEBUG "Enable building with debug" OFF)
 
 option(ENABLE_DNS_U=
PDOWN_BY_DEFAULT "Run --dns-updown hook by default" ON)
 set(DNS_UPDOWN_PAT=
H "${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown" CACHE STRING "Defaul=
t location for the DNS up/down script")
diff --git a/Changes=2Emd b/Changes=
=2Emd
index 2684251=2E=2E7763d59 100644
--- a/Changes=2Emd
+++ b/Changes=2E=
md
@@ -23,6 +23,11 @@
   the characters mentioned above were already escape=
d=2E However, the behavior of
   Mbed TLS is slightly different from OpenSS=
L in that it also escapes "=3D"=2E
 
+## Maintainer-visible changes
+
+- Th=
e configure-time option `--enable-debug` is no longer
+  available and the =
verbose logging is now always included=2E
+
 # Overview of changes in 2=2E7=

 
 ## New features
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecma=
ke=2Ein
index c3bb5a5=2E=2Ec6c0a96 100644
--- a/config=2Eh=2Ecmake=2Ein
+++=
 b/config=2Eh=2Ecmake=2Ein
@@ -18,8 +18,8 @@
 /* Enable shared data channel=
 offload */
 #cmakedefine ENABLE_DCO
 
-/* Enable debugging support (needed=
 for verb>=3D4) */
-#define ENABLE_DEBUG 1
+/* Enable debugging support */
=
+#cmakedefine ENABLE_DEBUG
 
 /* Enable internal fragmentation support */
 =
#define ENABLE_FRAGMENT 1
diff --git a/configure=2Eac b/configure=2Eac
inde=
x 469a475=2E=2E47e4759 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ =
-131,9 +131,9 @@
 
 AC_ARG_ENABLE(
 	[debug],
-	[AS_HELP_STRING([--disable-=
debug], [disable debugging support (disable gremlin and verb 7+ messages) @=
<:@default=3Dyes@:>@])],
+	[AS_HELP_STRING([--enable-developer-debug], [ena=
ble developer debugging support (enable gremlin) @<:@default=3Dyes@:>@])],
=
 	,
-	[enable_debug=3D"yes"]
+	[enable_debug=3D"no"]
 )
 
 AC_ARG_ENABLE(

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1943?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib31928529d10c7722e1=
f08e9ca7ff596bdebe840
Gerrit-Change-Number: 1943
Gerrit-PatchSet: 1
Gerrit-=
Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--Jnd1WzKc2E8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1943?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Rename --enable-debug to --enable-developer-debug and turn it off<=
br><br>Since the verbose logging is now always enabled<br>(apart from --ena=
ble-small), --enable-debug now only covers true<br>debug options like greml=
in=2E<br><br>Also rename the option to --enable-developer-debug to ensure<b=
r>existing build script/maintainer do not enable this option<br>by default=
=2E<br><br>Change-Id: Ib31928529d10c7722e1f08e9ca7ff596bdebe840<br>---<br>M=
 CMakeLists=2Etxt<br>M Changes=2Emd<br>M config=2Eh=2Ecmake=2Ein<br>M confi=
gure=2Eac<br>4 files changed, 10 insertions(+), 4 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/43/1943/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</sp=
an><br><span>index 6eb5954=2E=2Ed553697 100644</span><br><span>--- a/CMakeL=
ists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -40,6 =
+40,7 @@</span><br><span> option(ENABLE_PKCS11 &quot;BUILD with pkcs11-help=
er&quot; ON)</span><br><span> option(USE_WERROR &quot;Treat compiler warnin=
gs as errors (-Werror)&quot; ON)</span><br><span> option(FAKE_ANDROID &quot=
;Target Android but do not use actual cross compile/Android cmake to build =
for simple compile checks on Linux&quot;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+option(ENABLE_DEBUG &quot;Enable building with debug&=
quot; OFF)</span><br><span> </span><br><span> option(ENABLE_DNS_UPDOWN_BY_D=
EFAULT &quot;Run --dns-updown hook by default&quot; ON)</span><br><span> se=
t(DNS_UPDOWN_PATH &quot;${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown&=
quot; CACHE STRING &quot;Default location for the DNS up/down script&quot;)=
</span><br><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>i=
ndex 2684251=2E=2E7763d59 100644</span><br><span>--- a/Changes=2Emd</span><=
br><span>+++ b/Changes=2Emd</span><br><span>@@ -23,6 +23,11 @@</span><br><s=
pan>   the characters mentioned above were already escaped=2E However, the =
behavior of</span><br><span>   Mbed TLS is slightly different from OpenSSL =
in that it also escapes &quot;=3D&quot;=2E</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+## Maintainer-visible changes</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+- The configure-time option `--enable-deb=
ug` is no longer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  a=
vailable and the verbose logging is now always included=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Overview of chan=
ges in 2=2E7</span><br><span> </span><br><span> ## New features</span><br><=
span>diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><=
br><span>index c3bb5a5=2E=2Ec6c0a96 100644</span><br><span>--- a/config=2Eh=
=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span=
>@@ -18,8 +18,8 @@</span><br><span> /* Enable shared data channel offload *=
/</span><br><span> #cmakedefine ENABLE_DCO</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/* Enable debugging support (needed =
for verb&gt;=3D4) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define ENABLE_DEBUG 1</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Enable debugging support */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#cmakedefine ENABLE_DEBUG</span><br><span> </span><br><span> /=
* Enable internal fragmentation support */</span><br><span> #define ENABLE_=
FRAGMENT 1</span><br><span>diff --git a/configure=2Eac b/configure=2Eac</sp=
an><br><span>index 469a475=2E=2E47e4759 100644</span><br><span>--- a/config=
ure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -131,9 +13=
1,9 @@</span><br><span> </span><br><span> AC_ARG_ENABLE(</span><br><span> 	=
[debug],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AS_HELP_STR=
ING([--disable-debug], [disable debugging support (disable gremlin and verb=
 7+ messages) @&lt;:@default=3Dyes@:&gt;@])],</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	[AS_HELP_STRING([--enable-developer-debug], [ena=
ble developer debugging support (enable gremlin) @&lt;:@default=3Dyes@:&gt;=
@])],</span><br><span> 	,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	[enable_debug=3D&quot;yes&quot;]</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	[enable_debug=3D&quot;no&quot;]</span><br><span> )</span=
><br><span> </span><br><span> AC_ARG_ENABLE(</span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1943?usp=3Demail">=
change 1943</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1943?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: Ib31928529d10c7722e1f08e9ca7ff596bdebe840 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1943 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--Jnd1WzKc2E8=--


--===============4343688815782360289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4343688815782360289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4343688815782360289==--

