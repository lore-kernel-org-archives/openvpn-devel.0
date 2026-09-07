Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFE0C79FAA
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=trMyXBBphvItw+gYgJfcx2y/r5JhlCv0rXeE7iTLtO8=; b=PUg3UTDRgSzB+km6/AHfa0VSlb
	MvQRKPGxdyNSQoWsUUGUNlRplvntFsMVIrzuNGbuV0w7W6rNNx7D9DkVTSqiTUwRcMbNUPhS3N6Wz
	vLYqyAd5JwK4hTjggAw/+O+j4b5mCGY4xDLH+dDV8kNIDwvLiYElRsoCW+b4ekf2CeVo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3drF-00068E-Vg;
	Mon, 07 Sep 2026 18:14:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3drD-000687-Vg
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 18:14:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wTJjSQfuRvknmc+HUkFUk4HSm8EhQ5cdUFJMAxBjHMI=; b=EbW36yMBbHnQyD/tbOj/fQx7rw
 IZ4mGbmQbiuEapdPGyOcJyFno6oXwu6OjliXSiP9r3J5XQQteiFzCGp21D85+zmT85JGOEG6SixJp
 W9NQqCD+Ug4VP+1f3aZPyxMRuiAEUAhhDrPzYej4ue/NBSnR/EjsFg3pn5F+/fKhjb+s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wTJjSQfuRvknmc+HUkFUk4HSm8EhQ5cdUFJMAxBjHMI=; b=D
 t0xnEvzZWxU1zW2cZ4dOvLNz7jACIgvQTjowN1R98CNflu2rcrHAPCcISw9X3aBQVcEHot0jTDeBR
 PfWVrpdwfZ6axXXE75TKERUzK+JR1PILaAbNQYPnelDyuOjdD6/HMzwsokRGiVT8K7UICxuKW4hcH
 K6ntGS9V5pPR6nSw=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3dr2-00017Y-Tt for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 18:14:13 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-482e257a23aso2703963f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 11:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788804838; x=1789409638; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wTJjSQfuRvknmc+HUkFUk4HSm8EhQ5cdUFJMAxBjHMI=;
 b=Wy0iije9/pQriPRz64ARaLGbLrz6BnytCT9qr/Hcpo+2smS16meIb0Sk6IqURo7BDf
 Az6wlMJvsSTbFtbMaaIzwdXcCzmyUANcYVUyLvZGkw6eEx5MgtZQu/jGD03yfN7ZFuYO
 sC4o1/IN+ozzpGXUYhjUiOwfk1C6BDWii8ymWgT7igcZrjemwvIXBoudcQ1qq/1eOaiE
 5hk4iIbJAqR5ANODlHd3hN5LxooCSLd+I2sWnSvJ0IrUlKshFRnZ5vUlntz6kWH4F73/
 OAZY+WSCeTPnO53ZDW6VNpyBOe/Z/Mb+AA8LBJ0IkuArbPWyQ9Qyc/nDfzys4v51nbQn
 APXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788804838; x=1789409638;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wTJjSQfuRvknmc+HUkFUk4HSm8EhQ5cdUFJMAxBjHMI=;
 b=UghB+8DXkjwCDnXvNhtgzsoEmDUEVwRewM9dsCwde+aM6TnvPGzra8YGC59Ejz8HhV
 +Jops12sAovCB+a1YKLkp/Lr9VRRI0ynxjoPabb/m3ZJZbamOHaaxPRt+0naH99dpXDH
 7w7IsXyLco422P/AkHKPiL65CamygpFT+PmNuQSBTddALB+JZAtMkcTdmkwxsq3RFs2+
 d4MqELJDVogE7M1t5YF8IqdGbXRIB7W8oU9H8IkwLu3kx0t8TAgFCZCE+KmgMOfXCXQO
 XfzzJm59VWk+wJ3fpgj5tuKJKls1SUlCdwu6Cz3LZPNysp673LGpJsid1KMUsltSY+CJ
 23sg==
X-Forwarded-Encrypted: i=1;
 AKwUvByA5P2zyMbV30lj+oZhuW0VezBilcexBV6czP5SR+MoClSl7UpyH7BSYhdSX2QGaB61Q1NmJdQCIc5Es4SJ@lists.sourceforge.net
X-Gm-Message-State: AFuF++k28ki99uaC6LwViTtOs/8qAjEu4B8QB03VhGPxyR2tqC6DL9Qx
 7o47OldNIhFDwdPBfBkSd5sO6shKyuLF3+thfS0K065spnQW/Of+APt5mei8Lul/s1rvJFJiqtW
 Cl9jS9xawmIrjTGZRQmVz2867+Dm33ZDAVKl5e12VeAMRKoTVJMRU5D9GRh7ZeW1G2sBG
X-Gm-Gg: AYBFou2979rvXr2DbPkmSHp9YN/GNF9UtbBJbPQsNvMLSZZwxzBq50iLkvctlKVof6b
 QB9opNxDq9fJanAuCU+Vn0F8bVr/0DJeTNBupxCFo++Q74U4UkxlmXhUeqZ2yY+BmDo5JQ3qj0s
 SczT9alihct6eldLjeePEW9qsyZcjCRwZzxYlLLwem9w+dsMwLPJvXpp2iWuRIuwzJ35FOrNiTx
 Ep8RR7b3SbioQ4XkgPH5rR2ORADezt+dqQZ22fbABpfr2MYvsPRKorpktB8nB9j9q7rRHEjtPCb
 2MwlKdkPVQbaORAmK3Cq5X3U/1j95FoAbbn8dhlz5WLnqrdCeT6mvOcL52o9glXQrOY/2AuUNgK
 x5vXjoN11Lvh7ez4cPpgoTcRFt8iUPvN7TOnyN8dWyN6CKNmtnwA8FJQ1uFYUJEJp14Vy6GKzth
 w+lXis3JMfOLw+DnynIjhjvgqgDGU7+XNsFjMiXoe9/2tGC4ZOR3DMeUGDkSxyudr3vT5FcJTk5
 U4PLgJNPPMXeQN2q4xnZOveaYJq7RfQjZ2Qm0/NmkWkggvVpFALG6LerakTYKcx/jkaE2TXB3sc
 Hathq8QLyjBW/Wnp4Hs+CaHMRWBSL+OrHKWfEJKXg7mHh+OcLus=
X-Received: by 2002:a5d:584f:0:b0:485:9309:6f07 with SMTP id
 ffacd0b85a97d-4859309765fmr17364465f8f.26.1788804836698; 
 Mon, 07 Sep 2026 11:13:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4859162f354sm22625509f8f.20.2026.09.07.11.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:13:55 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 18:13:55 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I8887fa7ccf407d727c2b59397000149e45487e13
X-Gerrit-Change-Number: 1767
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1767?usp=email>
X-Gerrit-Commit: 57b1f870a76dbe94dbf8dc6a4d22d1a225a42578
In-Reply-To: <gerrit.1782994293000.I8887fa7ccf407d727c2b59397000149e45487e13@gerrit.openvpn.net>
References: <gerrit.1782994293000.I8887fa7ccf407d727c2b59397000149e45487e13@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTk0MjkzMDAwLkk4ODg3ZmE3Y2NmNDA3ZDcyN2MyYjU5Mzk3MDAwMTQ5ZTQ1NDg3ZTEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c22a4531b742288d86c2c48cc356a7ffee017305-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3dr2-00017Y-Tt
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4272062365968240308=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4272062365968240308==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x4c+AxinNkw="; charset=UTF-8

--x4c+AxinNkw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1767?usp=3Demail )

Change subject: Convert Changes=2Erst to Markdown
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Convert Chang=
es=2Erst to Markdown

Since all of our release publishing infrastructure no=
w uses
Markdown (Wiki, Forums, Github), preparing this documentation
in rst=
 just creates more work for the people creating the
release (so often me ;)=
)=2E

This conversion to Markdown tries to also fix several instances
of we=
ird formatting=2E But I tried to limit myself to not go
too much in the dir=
ection of actually "improving" the text=2E

The biggest changes come due to=
 the missing support for
<dl> style lists in MarkDown=2E We work around thi=
s by
converting to a <ul> and manually adding a bold paragraph
with the "ti=
tle"=2E

v2:
- reformat feature lists as ul

Change-Id: I8887fa7ccf407d727c=
2b59397000149e45487e13
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1767
Message-Id: <20260907154412=2E29=
523-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg38990=2Ehtml
Signed-off-by: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
---
A Changes=2Emd
D Changes=2Erst
M Makefile=
=2Eam
3 files changed, 1,458 insertions(+), 1,481 deletions(-)




diff --g=
it a/Changes=2Emd b/Changes=2Emd
new file mode 100644
index 0000000=2E=2E26=
84251
--- /dev/null
+++ b/Changes=2Emd
@@ -0,0 +1,1457 @@
+# Overview of ch=
anges in 2=2E8
+
+## User-visible Changes
+
+* **Parsing Distinguished Name=
s in certificates**
+
+  (OpenSSL backend:) OpenVPN now rejects certificate=
s that have a null-byte
+  inside any of the field values of their subject=
=2E To avoid ambiguity in the
+  parsed subject, OpenVPN escapes the follow=
ing characters by prefixing them with
+  a backslash:
+
+  * " " (space) at=
 the start or end of a field,
+  * "#" at the start of a field,
+  * ",", "=
+", """, "\", "<", ">" and ";" anywhere=2E
+
+  As a result, if you use the=
 option `--verify-x509-name <expected subject>`,
+  you need to prefix thes=
e characters with a backslash in your configuration=2E
+  The subject passe=
d to a `--tls-verify` script is escaped in the same way and
+  you may need=
 to adjust your script=2E
+
+  (Mbed TLS backend:) The behavior has not cha=
nged=2E Subjects with null-bytes were
+  already rejected (assuming OpenVPN=
 was built with Mbed TLS 3=2E5 or later) and
+  the characters mentioned ab=
ove were already escaped=2E However, the behavior of
+  Mbed TLS is slightl=
y different from OpenSSL in that it also escapes "=3D"=2E
+
+# Overview of =
changes in 2=2E7
+
+## New features
+
+* **Multi-socket support for servers=
**
+
+  OpenVPN servers now can listen on multiple sockets at the same time=
=2E Multiple
+  `--local` statements in the configuration can be used to co=
nfigure this=2E This
+  way the same server can e=2Eg=2E listen for UDP and=
 TCP connections at the same
+  time, or listen on multiple addresses and/o=
r ports=2E
+
+* **Client implementations for DNS options sent by server for=
 Linux/BSD/macOS**
+
+  Linux, BSD and macOS versions of OpenVPN now ship w=
ith a per-platform default
+  `--dns-updown` script that implements proper =
handling of DNS configuration sent
+  by the server=2E The scripts should w=
ork on systems that use `systemd` or
+  `resolveconf` to manage the DNS set=
up, as well as raw `/etc/resolv=2Econf` files=2E
+  However, the exact feat=
ures supported will depend on the configuration method=2E
+  On Linux and M=
acOS this should usually make split-DNS configurations supported
+  out-of-=
the-box now=2E
+
+  Note that this new script will not be used by default i=
f a `--up` script is
+  already in use to reduce problems with backwards co=
mpatibility=2E
+
+  See documentation for `--dns-updown` and `--dns` for mo=
re details=2E
+
+* **New client implementation for DNS options sent by serv=
er for Windows**
+
+  The Windows client now uses NRPT (Name Resolution Pol=
icy Table) to handle DNS
+  configurations=2E This adds support for split-D=
NS and DNSSEC and improves the
+  compatbility with local DNS resolvers=2E =
Requires the interactive service=2E
+
+* **On Windows the `block-local` fla=
g is now enforced with WFP filters=2E**
+
+  The `block-local` flag to `--r=
edirect-gateway` and `--redirect-private` is now
+  also enforced via the W=
indows Firewall, making sure packets can't be sent to the
+  local network=
=2E This provides stronger protection against TunnelCrack-style
+  attacks=
=2E
+
+* **Windows network adapters are now generated on demand**
+
+  This=
 means that on systems that run multiple OpenVPN connections at the same
+ =
 time the users don't need to manually create enough network adapters anymo=
re (in
+  addition to the ones created by the installer)=2E
+
+* **Windows =
automatic service now runs as an unpriviledged user**
+
+  All tasks that n=
eed privileges are now delegated to the interactive service=2E
+  **NOTE** =
this has the risk of breaking existing setups if the Windows
+  certificate=
 store is used (cryptoapi), and the certificates are not readable for
+  `N=
T SERVICE\OpenVPNService`=2E
+
+* **Support for new version of Linux DCO mo=
dule**
+
+  The OpenVPN DCO module has been merged into the Linux kernel as=
 of 6=2E16=2E This
+  required some API changes and OpenVPN 2=2E7 only supp=
orts the new API=2E The new
+  module is called `ovpn`=2E Out-of-tree build=
s for older kernels are available from
+  <https://github=2Ecom/OpenVPN/ovp=
n-backports>=2E Please see the release
+  announcements for further informa=
tion=2E
+
+* **Support for server mode in win-dco driver**
+
+  On Windows =
the win-dco driver can now be used in server setups=2E
+
+* **Support for T=
LS client floating in DCO implementations**
+
+  The kernel modules will de=
tect clients floating to a new IP address and notify
+  userland so both da=
ta packets (kernel) and TLS packets (sent by userland) can
+  reach the new=
 client IP=2E (Actual support depends on recent-enough kernel
+  implementa=
tion)
+
+* **Enforcement of AES-GCM usage limit**
+
+  OpenVPN will now enf=
orce the usage limits on AES-GCM with the same
+  confidentiality margin as=
 TLS 1=2E3 does=2E This mean that renegotiation will be
+  triggered after =
roughly 2^28 to 2^31 packets depending of the packet size=2E More
+  detail=
s about usage limit of AES-GCM can be found here:
+
+  <https://datatracker=
=2Eietf=2Eorg/doc/draft-irtf-cfrg-aead-limits/>
+
+* **Epoch data keys and =
packet format**
+
+  This introduces the epoch data format for AEAD data ch=
annel ciphers in TLS mode
+  ciphers=2E This new data format has a number o=
f improvements over the standard
+  "DATA_V2" format=2E
+
+  - AEAD tag at =
the end of packet which is more hardware implementation friendly
+  - Autom=
atic key switchover when cipher usage limits are hit, similar to the
+    e=
poch data keys in (D)TLS 1=2E3
+  - 64 bit instead of 32 bit packet ids to =
allow the data channel to be ready for
+    10 GBit/s without having freque=
nt renegotiation
+  - IV constructed with XOR instead of concatenation to n=
ot have (parts) of the
+    real IV on the wire
+
+* **Support for Epoch da=
ta channel on Windows, using the win-dco driver (2=2E8=2E0+)**
+
+* **Defau=
lt ciphers in `--data-ciphers`**
+
+  Ciphers in `--data-ciphers` can conta=
in the string DEFAULT that is replaced by
+  the default ciphers used by Op=
enVPN, making it easier to add an allowed cipher
+  without having to spell=
 out the default ciphers=2E
+
+* **TLS alerts**
+
+  OpenVPN 2=2E7 will sen=
d out TLS alerts to peers informing them if the TLS session
+  shuts down o=
r when the TLS implementation informs the peer about an error in the
+  TLS=
 session (e=2Eg=2E mismatching TLS versions)=2E This improves the user expe=
rience
+  as the client shows an error instead of running into a timeout wh=
en the server
+  just stops responding completely=2E
+
+* **Support for tun=
/tap via unix domain socket and lwipovpn support**
+
+  To allow better tes=
ting and emulating a full client with a full network stack
+  OpenVPN now a=
llows a program executed to provide a tun/tap device instead of
+  opening =
a device=2E
+
+  The co-developed lwipovpn program based on lwIP stack allo=
ws to simulate full IP
+  stack=2E An OpenVPN client using `--dev-node unix=
:/path/to/lwipovpn` can emulate a
+  full client that can be pinged, can se=
rve a website and more without requiring
+  any elevated permission=2E This=
 can make testing OpenVPN much easier=2E
+
+  For more details see [lwipovp=
n on Github](https://github=2Ecom/OpenVPN/lwipovpn)=2E
+
+* **Allow overrid=
ing username with `--override-username`**
+
+  This is intended to allow us=
ing `--auth-gen-token` in scenarios where the
+  clients use certificates a=
nd multi-factor authentication=2E This will also
+  generate a `push "auth-=
token-user newusername"` directive in push replies=2E
+
+* **`--port-share`=
 now properly supports IPv6**
+
+  Issues with logging of IPv6 addresses we=
re fixed=2E The feature now allows IPv6
+  connections towards the proxy re=
ceiver=2E
+
+* **Support for Haiku OS**
+
+* **TLS1=2E3 support with mbedTL=
S (requires mbedTLS >=3D 3=2E6=2E4)**
+
+* **PUSH_UPDATE client support**
+=

+  It is now possible to update parts of the client-side configuration (IP=
 address,
+  routes, MTU, DNS) by sending a new server-to-client control me=
ssage,
+  `PUSH_UPDATE,<options>`=2E See also:
+  <https://openvpn=2Egithub=
=2Eio/openvpn-rfc/openvpn-wire-protocol=2Ehtml>
+
+  NOTE: PUSH_UPDATE clie=
nt support is currently disabled if DCO is active (on all
+  platforms)=2E
=
+
+* **PUSH_UPDATE server support (minimal)**
+
+  New management interface=
 commands `push-update-broad` and `push-update-cid` to
+  send PUSH_UPDATE =
option updates to all clients ("there is a new DNS server") or
+  only a sp=
ecific client ID ("privileges have changed, here's a new IP address")=2E
+
=
+  See doc/management-notes=2Etxt
+
+  NOTE: PUSH_UPDATE server support is =
currently disabled if DCO is active
+  (on all platforms)=2E
+
+* **Support=
 for user-defined routing tables on Linux**
+
+  See the `--route-table` op=
tion in the manpage
+
+* **PQE support for WolfSSL**
+
+* **New environment=
 variables for gateway redirection**
+
+  Two new environment variables hav=
e been introduced to communicate desired
+  default gateway redirection to =
plugins like Network Manager,
+  `route_redirect_gateway_ipv4` and `route_r=
edirect_gateway_ipv6`=2E See the
+  "Environmental Variables" section in th=
e man page
+
+* **Improved logging of service events/errors to event log on=
 Windows=2E**
+
+* **Improved "Recursive Routing" check**
+
+  The check is=
 now more granular, and will only drop
+  packets-in-tunnel if destination =
IP, protocol and port matches with those needed
+  to reach the VPN server=
=2E With that change, you can now use policies that direct
+  "everything t=
hat is not OpenVPN" into the tunnel, and have IP packets to the VPN
+  serv=
er address arrive as expected (no such policies are currently installed by
=
+  OpenVPN) (GH: OpenVPN/openvpn#669)=2E
+
+* **COPYING: license details on=
ly relevant to our Windows installers have
+been updated and moved to the o=
penvpn-build repo**
+
+* **Improved BYTECOUNT support**
+
+  More strictly =
adhere to timing interval requested, correctly support client and
+  server=
 counters with Linux and Windows DCO offloading=2E
+
+* **Improve compatibi=
lity with OpenSSL 3=2E6=2E0 (do not fail t_lpback selftest)**
+
+* **New op=
tion `--tls-crypt-v2-max-age n` to check tls-crypt-v2 timestamps**
+
+  Whe=
n a client is older than n days or has no timestamp, the server will reject=

+  it=2E
+
+* **mbedTLS 4 support has been added=2E**
+
+  Note that with =
mbedTLS 4 algorithms need to be translated to mbedTLS 4 internal
+  IDs by =
OpenVPN, and some names might be missing=2E
+
+## Deprecated features
+
+* =
**`secret` support has been removed (by default)=2E**
+
+  static key mode =
(non-TLS) is no longer considered "good and secure enough" for
+  today's r=
equirements=2E Use TLS mode instead=2E If deploying a PKI CA is considered
=
+  "too complicated", using `--peer-fingerprint` makes TLS mode about as ea=
sy as
+  using `--secret`=2E
+
+  This mode can still be enabled by using
+=
  `--allow-deprecated-insecure-static-crypto` but will be removed in OpenVP=
N 2=2E8=2E
+
+* **Support for wintun Windows driver has been removed=2E**
+=

+  OpenVPN 2=2E6 added support for the new dco-win driver, so it supported=
 three
+  different device drivers: dco-win, wintun, and tap-windows6=2E Op=
enVPN 2=2E7 now
+  drops the support for wintun driver=2E By default all mo=
dern configs should be
+  supported by dco-win driver=2E In all other cases=
 OpenVPN will fall back
+  automatically to tap-windows6 driver=2E
+
+* **N=
TLMv1 authentication support for HTTP proxies has been removed=2E**
+
+  Th=
is is considered an insecure method of authentication that uses obsolete
+ =
 crypto algorithms=2E NTLMv2 support is still available, but will be remove=
d in a
+  future release=2E When configured to authenticate with NTLMv1 (`n=
tlm` keyword in
+  `--http-proxy`) OpenVPN will try NTLMv2 instead=2E
+
+* =
**`persist-key` option has been enabled by default=2E**
+
+  All the keys w=
ill be kept in memory across restart=2E
+
+* **OpenSSL 1=2E0=2E2 support ha=
s been removed=2E**
+
+  Support for building with OpenSSL 1=2E0=2E2 has be=
en removed=2E The minimum supported
+  OpenSSL version is now 1=2E1=2E0=2E
=
+
+* **mbedTLS 2=2Ex support has been removed**
+
+  Support for building w=
ith mbedTLS 2=2Ex has been removed (it is out of support
+  since March 202=
5, and the necessary compatibility code is making maintenance and
+  suppor=
t for mbedTLS 4=2Ex hard)=2E The minimum supported mbedTLS version is now
+=
  3=2E2=2E1=2E
+
+* **Compression on send has been removed=2E**
+
+  OpenVP=
N 2=2E7 will never compress data before sending=2E Decompression of receive=
d
+  data is still supported=2E `--allow-compression yes` is now an alias f=
or
+  `--allow-compression asym`=2E
+
+* **`--memstats` feature removed**
+=

+  The `--memstats` option was largely undocumented and there is no known =
user of
+  this feature=2E This feature provided very limited statistics (n=
umber of users,
+  link bytes read/written) and we do not except any usage =
because of this=2E
+
+* **Warning when using `--push` without `--mode serve=
r`**
+
+  Using `--push` in a mode that is not `--mode server` will now pri=
nt a
+  clear warning that this is an unsupported operation and might cause=
 negotiation
+  failures=2E
+
+* **Warning for `--reneg-bytes` and `--reneg=
-packets` in DCO mode**
+
+  `--reneg-bytes` and `--reneg-packets` do not w=
ork in DCO mode, and will
+  now print an appropriate warning=2E
+
+* **On-=
connect resolving of `--remote` in `--tcp-server` mode removed**
+
+  On-co=
nnect resolving of `--remote` addresses in `--tcp-server` mode
+  was not w=
orking since 2=2E4, so the code was completely removed=2E
+
+## User-visibl=
e Changes
+
+- Default for `--topology` changed to `subnet` for `--mode ser=
ver`=2E Previous
+  releases always used `net30` as default=2E This only af=
fects configs with
+  `--mode server` or `--server` (the latter implies the=
 former), and
+  `--dev tun`, and only if IPv4 is enabled=2E Note that this=
 changes the semantics
+  of `--ifconfig`, so if you have manual settings f=
or that in your config but
+  not set `--topology` your config might fail t=
o parse with the new version=2E
+  Just adding `--topology net30` to the co=
nfig should fix the problem=2E By
+  default `--topology` is pushed from se=
rver to client=2E
+- `--x509-username-field` will no longer automatically c=
onvert fieldnames to
+  uppercase=2E This was deprecated since OpenVPN 2=2E=
4, and has now been removed=2E
+- `--dh none` is now the default if `--dh` =
is not specified=2E Modern TLS
+  implementations will prefer ECDH and othe=
r more modern algorithms anyway=2E And
+  finite field Diffie Hellman is in=
 the proces of being deprecated (see
+  draft-ietf-tls-deprecate-obsolete-k=
ex)
+- `--lport 0` does not imply `--bind` anymore=2E
+- `--redirect-gatewa=
y` now works correctly if the VPN remote is not reachable by
+  the default=
 gateway=2E
+- `--show-gateway` now supports querying the gateway for IPv4 =
addresses=2E
+- `--static-challenge` option now has a third parameter `form=
at` that can change
+  how password and challenge response should be combin=
ed=2E
+- `--key` and `--cert` now accept URIs implemented in OpenSSL 3 as w=
ell as
+  optional OpenSSL 3 providers loaded using `--providers` option=2E=

+- `--cryptoapicert` now supports issuer name as well as Windows CA templa=
te name
+  or OID as selector string=2E
+- TLS handshake debugging informat=
ion contains much more details now when using
+  recent versions of OpenSSL=
=2E
+- The `IV_PLAT_VER` variable sent by Windows clients now contains the =
full
+  Windows build version to make it possible to determine the Windows =
10 or
+  Windows 11 version used=2E
+- The `--windows-driver` option to sel=
ect between various windows drivers will
+  no longer do anything - it's ke=
pt so existing configs will not become invalid,
+  but it is ignored with a=
 warning=2E The default is now `ovpn-dco` if all options
+  used are compat=
ible with DCO, with a fallback to `tap-windows6`=2E To force TAP
+  (for ex=
ample because a server pushes DCO incompatible options), use the
+  `--disa=
ble-dco` option=2E
+- Apply more checks to incoming TLS handshake packets b=
efore creating new
+  state - namely, verify message ID / acked ID for "val=
id range for an initial
+  packet"=2E This fixes a problem with clients tha=
t float very early but send
+  control channel packet from the pre-float IP=
 (Github: OpenVPN/openvpn#704)=2E
+- Use of `--dh dh2048=2Epem` in all samp=
le configs has been replaced with
+  `--dh none`=2E The `dh2048=2Epem` file=
 has been removed=2E
+- The startup delay in `t_client=2Esh` has been reduc=
ed from 3s to 1s, making a
+  noticeable difference for setups with many te=
sts=2E
+- Changed from using `uncrustify` for code formatting and pre-commi=
t checks to
+  `clang-format`=2E This reformatted quite a bit of code, and =
requires that
+  regular committers change their pre-commit checks accordin=
gly=2E
+- On Linux, on interfaces where applicable, OpenVPN explicitly conf=
igures the
+  broadcast address again=2E This was dropped for 2=2E6=2E0 "be=
cause computers are
+  smart and can do it themselves", but the kernel netl=
ink interface isn't, and
+  will install "0=2E0=2E0=2E0"=2E This does not n=
ormally matter, but for broadcast-based
+  applications that get the addres=
s to use from "ifconfig", this change repairs
+  functionality (this has be=
en backported to 2=2E6=2E15, but is not in earlier 2=2E6
+  versions)=2E
+-=
 `max-routes-per-client 0` used to be silently upgraded to `1`=2E This now
=
+  produces an error=2E
+- `ifconfig` and `ifconfig-ipv6` values are now st=
ored in pre-connect options
+  cache, and will be restored to pre-connect v=
alues on reconnects if the server
+  stops pushing the respective option=2E=

+- `tapctl=2Eexe` helper binary on Windows has been reworked to improve he=
lp texts
+  (making clear that it can not only do TAP-Adapters but Win-DCO =
as well), add
+  printing of the hwid to all adapter outputs, and change th=
e default adapter
+  type created to `ovpn-dco`=2E
+- The default for `mult=
ihome` egress interface handling has changed=2E 2=2E7=2E0 will
+  default t=
o ipi_ifindex=3D0, that is, leave the decision to the routing/policy
+  set=
up of the operating system=2E The pre-2=2E7 behaviour (force egress =3D ing=
ress
+  interface) can be achieved with the new `--multihome same-interface=
`
+  sub-option=2E
+- Windows `openvpn=2Eexe` binary manifest now sets code=
 page UTF8 - which has no
+  direct effect on OpenVPN itself, but this repa=
irs OpenSSL file loading for
+  key/cert files with non-ASCII characters in=
 their file names (GH:
+  OpenVPN/openvpn#920)=2E
+- The `test-crypto` opti=
on no longer requires a `--secret` argument and will
+  automatically gener=
ate a random key=2E
+- The configure-time option `--enable-x509-alt-usernam=
e` is no longer
+  conditional, and always-on (GH: OpenVPN/openvpn#917)=2E
=
+
+## Deprecated features
+
+* **`--opt-verify` feature removed**
+
+  This=
 option was already deprecated and it is now being converted to a no-op=2E
=
+  Using this option will only print a warning=2E
+
+# Overview of changes =
in 2=2E6
+
+## Project changes
+
+We want to deprecate our old Trac bug tra=
cking system=2E Please report any issues
+with this release in GitHub inste=
ad: <https://github=2Ecom/OpenVPN/openvpn/issues>
+
+## New features
+
+* *=
*Support unlimited number of connection entries and remote entries**
+
+* *=
*New management commands to enumerate and list remote entries**
+
+  Use `r=
emote-entry-count` and `remote-entry-get` commands from the management
+  i=
nterface to get the number of remote entries and the entries themselves=2E
=
+
+* **Keying Material Exporters (RFC 5705) based key generation**
+
+  As =
part of the cipher negotiation OpenVPN will automatically prefer the RFC570=
5
+  based key material generation to the current custom OpenVPN PRF=2E Thi=
s feature
+  requires OpenSSL or mbed TLS 2=2E18+=2E
+
+* **Compatibility w=
ith OpenSSL in FIPS mode**
+
+  OpenVPN will now work with OpenSSL in FIPS =
mode=2E Note, no effort has been made
+  to check or implement all the requ=
irements/recommendation of FIPS 140-2=2E This
+  just allows OpenVPN to be =
run on a system that be configured OpenSSL in FIPS
+  mode=2E
+
+* **`mlock=
` now checks available memlock-able memory**
+
+  `mlock` will now check if=
 enough memlock-able memory has been reserved,
+  and if less than 100MB RA=
M are available, use setrlimit() to upgrade the limit=2E
+  See Trac #1390=
=2E Not available on OpenSolaris=2E
+
+* **Certificate pinning/verify peer =
fingerprint**
+
+  The `--peer-fingerprint` option has been introduced to g=
ive users an easy to use
+  alternative to the `tls-verify` for matching th=
e fingerprint of the peer=2E The
+  option takes use a number of allowed SH=
A256 certificate fingerprints=2E
+
+  See the man page section "Small OpenV=
PN setup with peer-fingerprint" for a
+  tutorial on how to use this featur=
e=2E This is also available online under
+  <https://github=2Ecom/openvpn/o=
penvpn/blob/master/doc/man-sections/example-fingerprint=2Erst>
+
+* **TLS m=
ode with self-signed certificates**
+
+  When `--peer-fingerprint` is used,=
 the `--ca` and `--capath` option become
+  optional=2E This allows for sma=
ll OpenVPN setups without setting up a PKI with
+  Easy-RSA or similar soft=
ware=2E
+
+* **Deferred auth support for scripts**
+
+  The `--auth-user-pa=
ss-verify` script supports now deferred authentication=2E
+
+* **Pending au=
th support for plugins and scripts**
+
+  Both auth plugin and script can n=
ow signal pending authentication to the client
+  when using deferred authe=
ntication=2E The new `client-crresponse` script option
+  and `OPENVPN_PLUG=
IN_CLIENT_CRRESPONSE` plugin function can be used to parse a
+  client resp=
onse to a `CR_TEXT` two factor challenge=2E
+
+  See `sample/sample-scripts=
/totpauth=2Epy` for an example=2E
+
+* **Compatibility mode (`--compat-mode=
`)**
+
+  The modernisation of defaults can impact the compatibility of Ope=
nVPN 2=2E6=2E0 with
+  older peers=2E The options `--compat-mode` allows UI=
s to provide users with an
+  easy way to still connect to older servers=2E=

+
+* **OpenSSL 3=2E0 support**
+
+  OpenSSL 3=2E0 has been added=2E Most o=
f OpenSSL 3=2E0 changes are not user visible but
+  improve general compati=
bility with OpenSSL 3=2E0=2E `--tls-cert-profile insecure`
+  has been adde=
d to allow selecting the lowest OpenSSL security level (not
+  recommended,=
 use only if you must)=2E OpenSSL 3=2E0 no longer supports the Blowfish
+  =
(and other deprecated) algorithm by default and the new option `--providers=
`
+  allows loading the legacy provider to renable these algorithms=2E
+
+*=
 **Optional ciphers in `--data-ciphers`**
+
+  Ciphers in `--data-ciphers` =
can now be prefixed with a `?` to mark those as
+  optional and only use th=
em if the SSL library supports them=2E
+
+* **Improved `--mssfix` and `--fr=
agment` calculation**
+
+  The `--mssfix` and `--fragment` options now allo=
w an optional `mtu` parameter to
+  specify that different overhead for IPv=
4/IPv6 should taken into account and the
+  resulting size is specified as =
the total size of the VPN packets including IP
+  and UDP headers=2E
+
+* *=
*Cookie based handshake for UDP server**
+
+  Instead of allocating a conne=
ction for each client on the initial packet OpenVPN
+  server will now use =
an HMAC based cookie as its session id=2E This way the server
+  can verify=
 it on completing the handshake without keeping state=2E This eliminates
+ =
 the amplification and resource exhaustion attacks=2E For tls-crypt-v2 clie=
nts,
+  this requires OpenVPN 2=2E6 clients or later because the client nee=
ds to resend
+  its client key on completing the hand shake=2E The tls-cryp=
t-v2 option allows
+  controlling if older clients are accepted=2E
+
+  By =
default the rate of initial packet responses is limited to 100 per 10s
+  i=
nterval to avoid OpenVPN servers being abused in reflection attacks (see
+ =
 `--connect-freq-initial`)=2E
+
+* **Data channel offloading with ovpn-dco*=
*
+
+  2=2E6=2E0+ implements support for data-channel offloading where the =
data packets are
+  directly processed and forwarded in kernel space thanks=
 to the ovpn-dco kernel
+  module=2E The userspace openvpn program acts pur=
ely as a control plane
+  application=2E Note that DCO will use DATA\_V2 pa=
ckets in P2P mode, therefore, this
+  implies that peers must be running 2=
=2E6=2E0+ in order to have P2P-NCP which brings
+  DATA\_V2 packet support=
=2E
+
+* **Session timeout**
+
+  It is now possible to terminate a session=
 (or all) after a specified amount of
+  seconds has passed session commenc=
ement=2E This behaviour can be configured using
+  `--session-timeout`=2E T=
his option can be configured on the server, on the client
+  or can also be=
 pushed=2E
+
+* **Inline auth username and password**
+
+  Username and pas=
sword can now be specified inline in the configuration file
+  within the `=
<auth-user-pass></auth-user-pass>` tags=2E If the password is
+  missing Op=
enVPN will prompt for input via stdin=2E This applies to inline'd
+  http-p=
roxy-user-pass too=2E
+
+* **Tun MTU can be pushed**
+
+  The client can no=
w also dynamically configure its MTU and the server will try to
+  push the=
 client MTU when the client supports it=2E The directive `--tun-mtu-max`
+ =
 has been introduced to increase the maximum pushable MTU size (defaults to=

+  1600)=2E
+
+* **Dynamic TLS Crypt**
+
+  When both peers are OpenVPN 2=
=2E6=2E1+, OpenVPN will dynamically create a tls-crypt
+  key that is used =
for renegotiation=2E This ensure that only the previously
+  authenticated =
peer can do trigger renegotiation and complete renegotiations=2E
+
+* **Imp=
roved control channel packet size control (`max-packet-size`)**
+
+  The si=
ze of control channel is no longer tied to `--link-mtu`/`--tun-mtu` and
+  =
can be set using `--max-packet-size`=2E Sending large control channel frame=
s is
+  also optimised by allowing 6 outstanding packets instead of just 4=
=2E
+  `max-packet-size` will also set `mssfix` to try to limit data-channe=
l packets as
+  well=2E
+
+## Deprecated features
+
+* **`inetd` has been r=
emoved**
+
+  This was a very limited and not-well-tested way to run OpenVP=
N, on TCP and TAP
+  mode only=2E
+
+* **`verify-hash` has been deprecated*=
*
+
+  This option has very limited usefulness and should be replaced by ei=
ther a
+  better `--ca` configuration or with a `--tls-verify` script=2E
+
=
+* **`secret` has been deprecated**
+
+  Static key mode (non-TLS) is no lo=
nger considered "good and secure enough" for
+  today's requirements=2E Use=
 TLS mode instead=2E If deploying a PKI CA is considered
+  "too complicate=
d", using `--peer-fingerprint` makes TLS mode about as easy as
+  using `--=
secret`=2E
+
+* **`ncp-disable` has been removed**
+
+  This option mainly =
served a role as debug option when NCP was first introduced=2E
+  It should=
 now no longer be necessary=2E
+
+* **TLS 1=2E0 and 1=2E1 are deprecated**
=
+
+  `tls-version-min` is set to 1=2E2 by default=2E OpenVPN 2=2E6=2E0 defa=
ults to a minimum
+  TLS version of 1=2E2 as TLS 1=2E0 and 1=2E1 should be =
generally avoided=2E Note that
+  OpenVPN versions older than 2=2E3=2E7 use=
 TLS 1=2E0 only=2E
+
+* **`--cipher` argument is no longer appended to `--d=
ata-ciphers` by default**
+
+  Data cipher negotiation has been introduced =
in 2=2E4=2E0 and been
+  significantly improved in 2=2E5=2E0=2E The implici=
t fallback to the cipher specified
+  in `--cipher` has been removed=2E Eff=
ectively, `--cipher` is a no-op in TLS mode
+  now, and will only have an e=
ffect in pre-shared-key mode (`--secret`)=2E From now
+  on `--cipher` shou=
ld not be used in new configurations for TLS mode=2E Should
+  backwards co=
mpatibility with older OpenVPN peers be required, please see the
+  `--comp=
at-mode` instead=2E
+
+* **`--prng` has beeen removed**
+
+  OpenVPN used t=
o implement its own PRNG based on a hash=2E However implementing a
+  PRNG =
is better left to a crypto library=2E So we use the PRNG mbed TLS or OpenSS=
L
+  now=2E
+
+* **`--keysize` has been removed**
+
+  The `--keysize` opti=
on was only useful to change the key length when using the
+  BF, CAST6 or =
RC2 ciphers=2E For all other ciphers the key size is fixed with the
+  chos=
en cipher=2E As OpenVPN v2=2E6 no longer supports any of these variable len=
gth
+  ciphers, this option was removed as well to avoid confusion=2E
+
+* =
**Compression no longer enabled by default**
+
+  Unless an explicit compre=
ssion option is specified in the configuration,
+  `--allow-compression` de=
faults to `no` in OpeNVPN 2=2E6=2E0=2E By default, OpenVPN 2=2E5
+  still a=
llowed a server to enable compression by pushing compression related
+  opt=
ions=2E
+
+* **PF (Packet Filtering) support has been removed**
+
+  The bu=
ilt-in PF functionality has been removed from the code base=2E This feature=

+  wasn't really easy to use and was long unmaintained=2E This implies tha=
t also
+  `--management-client-pf` and any other compile time or run time r=
elated option
+  do not exist any longer=2E
+
+* **Option conflict checking=
 is being deprecated and phased out**
+
+  The static option checking (OCC)=
 is no longer useful in typical setups that
+  negotiate most connection pa=
rameters=2E The `--opt-verify` and `--occ-disable`
+  options are deprecate=
d, and the configure option `--enable-strict-options` has
+  been removed=
=2E Logging of mismatched options has been moved to debug logging
+  (verb =
7)=2E
+
+## User-visible Changes
+
+- CHACHA20-POLY1305 is included in the =
default of `--data-ciphers` when
+  available=2E
+- Option `--prng` is igno=
red as we rely on the SSL library random number
+  generator=2E
+- Option `=
--nobind` is default when `--client` or `--pull` is used in the
+  configur=
ation
+- `link_mtu` parameter is removed from environment or replaced with =
0 when
+  scripts are called with parameters=2E This parameter is unreliabl=
e and no longer
+  internally calculated=2E
+- control channel packet maxim=
um size is no longer influenced by
+  `--link-mtu`/`--tun-mtu` and must be =
set by `--max-packet-size` now=2E The
+  default is 1250 for the control ch=
annel size=2E
+- In point-to-point OpenVPN setups (no `--server`), using `-=
-explict-exit-notiy`
+  on one end would terminate the other side at sessio=
n end=2E This is considered a
+  no longer useful default and has been chan=
ged to "restart on reception of
+  explicit-exit-notify message"=2E If the =
old behaviour is still desired,
+  `--remap-usr1 SIGTERM` can be used=2E
+-=
 FreeBSD tun interfaces with `--topology subnet` are now put into real subn=
et
+  mode (IFF_BROADCAST instead of IFF_POINTOPOINT) - this might upset so=
ftware
+  that enumerates interfaces, looking for "broadcast capable?" and =
expecting
+  certain results=2E Normal uses should not see any difference=
=2E
+- The default configurations will no longer allow connections to OpenV=
PN 2=2E3=2Ex
+  peer or earlier, use the new `--compat-mode` option if you =
need compatibility
+  with older versions=2E See the manual page on the `--=
compat-mode` for details=2E
+- The `client-pending-auth` management command=
 now requires also the key id=2E The
+  management version has been changed=
 to 5 to indicate this change=2E
+- (OpenVPN 2=2E6=2E2) A client will now r=
efuse a connection if pushed compression
+  settings will contradict the se=
tting of allow-compression as this almost
+  always results in a non-workin=
g connection=2E
+- The "kill" by addr management command now requires also =
the protocol as string
+  e=2Eg=2E "udp", "tcp"=2E
+
+## Common errors with=
 OpenSSL 3=2E0 and OpenVPN 2=2E6
+
+Both OpenVPN 2=2E6 and OpenSSL 3=2E0 ti=
ghten the security considerable, so some
+configuration will no longer work=
=2E This section will cover the most common
+causes and error message we ha=
ve seen and explain their reason and temporary
+workarounds=2E You should f=
ix the underlying problems as soon as possible since
+these workaround are =
not secure and will eventually stop working in a future
+update=2E
+
+- wea=
k SHA1 or MD5 signature on certificates
+
+  This will happen on either loa=
ding of certificates or on connection to a
+  server:
+
+      OpenSSL: err=
or:0A00018E:SSL routines::ca md too weak
+      Cannot load certificate fil=
e cert=2Ecrt
+      Exiting due to fatal error
+
+  OpenSSL 3=2E0 no longer=
 allows weak signatures on certificates=2E You can
+  downgrade your securi=
ty to allow them by using `--tls-cert-profile insecure`
+  but should repla=
ce/regenerate these certificates as soon as possible=2E
+
+- 1024 bit RSA c=
ertificates, 1024 bit DH parameters, other weak keys
+
+  This happens if y=
ou use private keys or other cryptographic material that does
+  not meet t=
oday's cryptographic standards anymore=2E Messages are similar to:
+
+     =
 OpenSSL: error:0A00018F:SSL routines::ee key too small
+      OpenSSL: err=
or:1408518A:SSL routines:ssl3_ctx_ctrl:dh key too small
+
+  DH parameters =
(`--dh`) can be regenerated with `openssl dhparam 2048`=2E For
+  other cry=
ptographic keys, these keys and certificates need to be regenerated=2E
+  T=
LS Security level can be temporarily lowered with `--tls-cert-profile legac=
y`
+  or even `--tls-cert-profile insecure`=2E
+
+- Connecting to a OpenVPN=
 2=2E3=2Ex server or allowing OpenVPN 2=2E3=2Ex or earlier
+  clients
+
+  =
This will normally result in messages like:
+
+      OPTIONS ERROR: failed =
to negotiate cipher with server=2E Add the server's cipher ('AES-128-CBC') =
to --data-ciphers (currently 'AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305') i=
f you want to connect to this server=2E
+
+  or
+
+      client/127=2E0=2E0=
=2E1:49954 SENT CONTROL [client]: 'AUTH_FAILED,Data channel cipher negotiat=
ion failed (no shared cipher)' (status=3D1)
+
+  You can manually add the m=
issing cipher to the `--data-ciphers`=2E The standard
+  ciphers should be =
included as well, e=2Eg=2E
+  `--data-ciphers AES-256-GCM:AES-128-GCM:?Chac=
ha20-Poly1305:?AES-128-CBC`=2E You
+  can also use the `--compat-mode` opti=
on=2E Note that these message may also
+  indicate other cipher configurati=
on problems=2E See the data channel cipher
+  negotiation manual section fo=
r more details=2E (Available online under
+  <https://github=2Ecom/OpenVPN/=
openvpn/blob/master/doc/man-sections/cipher-negotiation=2Erst>)
+
+- Use of=
 a legacy or deprecated cipher (e=2Eg=2E 64bit block ciphers)
+
+  OpenSSL =
3=2E0 no longer supports a number of insecure and outdated ciphers in
+  it=
s default configuration=2E Some of these ciphers are known to be vulnerable=

+  (SWEET32 attack)=2E
+
+  This will typically manifest itself in message=
s like:
+
+      OpenSSL: error:0308010C:digital envelope routines::unsuppo=
rted
+      Cipher algorithm 'BF-CBC' not found
+      Unsupported cipher i=
n --data-ciphers: BF-CBC
+
+  If your OpenSSL distribution comes with the l=
egacy provider (see also
+  `man OSSL_PROVIDER-legacy`), you can load it wi=
th
+  `--providers legacy default`=2E This will re-enable the old algorithm=
s=2E
+
+- OpenVPN version not supporting TLS 1=2E2 or later
+
+  The defaul=
t in OpenVPN 2=2E6 and also in many distributions is now TLS 1=2E2 or
+  la=
ter=2E Connecting to a peer that does not support this will results in
+  m=
essages like:
+
+      TLS error: Unsupported protocol=2E
+
+  This typical=
ly indicates that client and server have no common TLS version
+  enabled=
=2E This can be caused by mismatched tls-version-min and tls-version-max
+ =
 options on client and server=2E If your OpenVPN client is between v2=2E3=
=2E6 and
+  v2=2E3=2E2 try adding `tls-version-min 1=2E0` to the client con=
figuration to use
+  TLS 1=2E0+ instead of TLS 1=2E0 only=2E
+
+      OpenS=
SL: error:0A000102:SSL routines::unsupported protocol
+
+  This can be an O=
penVPN 2=2E3=2E6 or earlier version=2E `compat-version 2=2E3=2E0` will
+  e=
nable TLS 1=2E0 support if supported by the OpenSSL distribution=2E Note th=
at on
+  some Linux distributions enabling TLS 1=2E1 or 1=2E0 is not possib=
le=2E
+
+# Overview of changes in 2=2E5
+
+## New features
+
+* **Client-sp=
ecific tls-crypt keys (`--tls-crypt-v2`)**
+
+  `tls-crypt-v2` adds the abi=
lity to supply each client with a unique tls-crypt
+  key=2E This allows la=
rge organisations and VPN providers to profit from the same
+  DoS and TLS =
stack protection that small deployments can already achieve using
+  `tls-a=
uth` or `tls-crypt`=2E
+
+* **ChaCha20-Poly1305 cipher support**
+
+  Added=
 support for using the ChaCha20-Poly1305 cipher in the OpenVPN data
+  chan=
nel=2E
+
+* **Improved Data channel cipher negotiation**
+
+  The option `n=
cp-ciphers` has been renamed to `data-ciphers`=2E The old name is
+  still =
accepted=2E The change in name signals that `data-ciphers` is the preferred=

+  way to configure data channel ciphers and the data prefix is chosen to =
avoid the
+  ambiguity that exists with `--cipher` for the data cipher and =
`tls-cipher` for
+  the TLS ciphers=2E
+
+  OpenVPN clients will now signal=
 all supported ciphers from the `data-ciphers`
+  option to the server via =
`IV_CIPHERS`=2E OpenVPN servers will select the first
+  common cipher from=
 the `data-ciphers` list instead of blindly pushing the first
+  cipher of =
the list=2E This allows to use a configuration like
+  `data-ciphers ChaCha=
20-Poly1305:AES-256-GCM` on the server that prefers
+  ChaCha20-Poly1305 bu=
t uses it only if the client supports it=2E
+
+  See the data channel negot=
iation section in the manual for more details=2E
+
+* **Removal of BF-CBC s=
upport in default configuration:**
+
+  By default OpenVPN 2=2E5 will only =
accept AES-256-GCM and AES-128-GCM as data
+  ciphers=2E OpenVPN 2=2E4 allo=
ws AES-256-GCM,AES-128-GCM and BF-CBC when no --cipher
+  and --ncp-ciphers=
 options are present=2E Accepting BF-CBC can be enabled by adding
+
+  > da=
ta-ciphers AES-256-GCM:AES-128-GCM:BF-CBC
+
+  and when you need to support=
 very old peers also
+
+  > data-ciphers-fallback BF-CBC
+
+  To offer back=
wards compatibility with older configs an *explicit*
+
+  > cipher BF-CBC
+=

+  in the configuration will be automatically translated into adding BF-CB=
C to the
+  data-ciphers option and setting data-ciphers-fallback to BF-CBC=
 (as in the
+  example commands above)=2E We strongly recommend to switchin=
g away from BF-CBC to
+  a more secure cipher=2E
+
+* **Asynchronous (defer=
red) authentication support for auth-pam plugin=2E**
+
+  See src/plugins/a=
uth-pam/README=2Eauth-pam for details=2E
+
+* **Deferred client-connect**
+=

+  The `--client-connect` option and the connect plugin API allow
+  async=
hronous/deferred return of the configuration file in the same way as the
+ =
 auth-plugin=2E
+
+* **Faster connection setup**
+
+  A client will signal =
in the `IV_PROTO` variable that it is in pull mode=2E This
+  allows the se=
rver to push the configuration options to the client without
+  waiting for=
 a `PULL_REQUEST` message=2E The feature is automatically enabled if
+  bot=
h client and server support it and significantly reduces the connection set=
up
+  time by avoiding one extra packet round-trip and 1s of internal event=
 delays=2E
+
+* **Netlink support**
+
+  On Linux, if configured without `-=
-enable-iproute2`, configuring IP addresses
+  and adding/removing routes i=
s now done via the netlink(3) kernel interface=2E This
+  is much faster th=
an calling `ifconfig` or `route` and also enables OpenVPN to
+  run with le=
ss privileges=2E
+
+  If configured with --enable-iproute2, the `ip` comman=
d is used (as in 2=2E4)=2E
+  Support for `ifconfig` and `route` is gone=2E=

+
+* **Wintun support**
+
+  On Windows, OpenVPN can now use `wintun` devi=
ces=2E They are faster than the
+  traditional `tap9` tun/tap devices, but =
do not provide `--dev tap` mode - so the
+  official installers contain bot=
h=2E To use a wintun device, add
+  `--windows-driver wintun` to your confi=
g (and use of the interactive service is
+  required as wintun needs SYSTEM=
 privileges to enable access)=2E
+
+* **IPv6-only operation**
+
+  It is no=
w possible to have only IPv6 addresses inside the VPN tunnel, and
+  IPv6-o=
nly address pools (2=2E4 always required IPv4 config/pools and IPv6 was the=

+  "optional extra")=2E
+
+* **Improved Windows 10 detection**
+
+  Correc=
tly log OS on Windows 10 now=2E
+
+* **Linux VRF support**
+
+  Using the n=
ew `--bind-dev` option, the OpenVPN outside socket can now be put
+  into a=
 Linux VRF=2E See the "Virtual Routing and Forwarding" documentation in the=

+  man page=2E
+
+* **TLS 1=2E3 support**
+
+  TLS 1=2E3 support has been =
added to OpenVPN=2E Currently, this requires OpenSSL
+  1=2E1=2E1+=2E The o=
ptions `--tls-ciphersuites` and `--tls-groups` have been added to
+  fine t=
une TLS protocol options=2E Most of the improvements were also backported t=
o
+  OpenVPN 2=2E4 as part of the maintainance releases=2E
+
+* **Support s=
etting DHCP search domain**
+
+  A new option `--dhcp-option DOMAIN-SEARCH =
my=2Eexample=2Ecom` has been defined, and
+  Windows support for it is impl=
emented (tun/tap only, no wintun support yet)=2E
+  Other platforms need to=
 support this via `--up` script (Linux) or GUI
+  (OSX/Tunnelblick)=2E
+
+*=
 **per-client changing of `--data-ciphers` or `data-ciphers-fallback`**
+
+=
  Via client-connect script/dir (NOTE: this only changes preference of ciph=
ers
+  for NCP, but can not override what the client announces as "willing =
to accept")=2E
+
+* **Handle setting of tun/tap interface MTU on Windows**
=
+
+  If IPv6 is in use, MTU must be >=3D 1280 (Windows enforces IETF requir=
ements)
+
+* **Add support for OpenSSL engines to access private key materi=
al (like TPM)=2E**
+
+* **HMAC based auth-token support**
+
+  The `--auth-=
gen-token` support has been improved and now generates HMAC based
+  user t=
oken=2E If the optional `--auth-gen-token-secret` option is used clients
+ =
 will be able to seamlessly reconnect to a different server using the same =
secret
+  file or to the same server after a server restart=2E
+
+* **Impro=
ved support for pending authentication**
+
+  The protocol has been enhance=
d to be able to signal that the authentication
+  should use a secondary au=
thentication via web (like SAML) or a two factor
+  authentication without =
disconnecting the OpenVPN session with AUTH_FAILED=2E The
+  session will i=
nstead be stay in a authenticated state and wait for the second
+  factor a=
uthentication to complete=2E
+
+  This feature currently requires usage of =
the managent interface on both client
+  and server side=2E See the `manage=
ment-notes=2Etxt` `client-pending-auth` and
+  `cr-response` commands for m=
ore details=2E
+
+* **VLAN support**
+
+  OpenVPN servers in TAP mode can n=
ow use 802=2E1q tagged VLANs on the TAP interface
+  to separate clients in=
to different groups that can then be handled differently
+  (different subn=
ets / DHCP, firewall zones, =2E=2E=2E) further down the network=2E See
+  t=
he new options `--vlan-tagging`, `--vlan-accept`, `--vlan-pvid`=2E
+
+  802=
=2E1q tagging on the client side TAP interface is not handled today (=3D ta=
gs are
+  just forwarded transparently to the server)=2E
+
+* **Support bui=
lding of =2Emsi installers for Windows**
+
+* **Allow unicode search string=
 in `--cryptoapicert` option (Windows)**
+
+* **Support IPv4 configs with /=
31 netmasks now**
+
+  (By no longer trying to configure `broadcast x=2Ex=
=2Ex=2Ex` in ifconfig calls, /31
+  support "just works")
+
+* **New option=
 `--block-ipv6` to reject all IPv6 packets (ICMPv6)**
+
+  This is useful i=
f the VPN service has no IPv6, but the clients might have (LAN),
+  to avoi=
d client connections to IPv6-enabled servers leaking "around" the
+  IPv4-o=
nly VPN=2E
+
+* **`--ifconfig-ipv6` and `--ifconfig-ipv6-push` accept hostn=
ames**
+
+  `--ifconfig-ipv6` and `--ifconfig-ipv6-push` will now accept ho=
stnames and do
+  a DNS lookup to get the IPv6 address to use=2E
+
+## Depr=
ecated features
+
+For an up-to-date list of all deprecated options, see th=
is wiki page:
+<https://community=2Eopenvpn=2Enet/openvpn/wiki/DeprecatedOp=
tions>
+
+- `ncp-disable` has been deprecated=2E
+
+  With the improved and=
 matured data channel cipher negotiation, the use of
+  `ncp-disable` shoul=
d not be necessary anymore=2E
+
+- `inetd` has been deprecated=2E
+
+  This=
 is a very limited and not-well-tested way to
+  run OpenVPN, on TCP and TA=
P mode only, which complicates the code quite a bit
+  for little gain=2E T=
o be removed in OpenVPN 2=2E6 (unless users protest)=2E
+
+- `no-iv` has be=
en removed=2E
+
+  This option was made into a NOOP option with OpenVPN
+  =
2=2E4=2E This has now been completely removed=2E
+
+- `--client-cert-not-re=
quired` has been removed
+
+  This option will now cause server configurati=
ons to not start=2E
+  Use `--verify-client-cert none` instead=2E
+
+- `--i=
fconfig-pool-linear` has been removed=2E
+
+  This option is removed=2E Use=
 `--topology p2p` or `--topology subnet` instead=2E
+
+- `--compress xxx` i=
s considered risky and is warned against, see below=2E
+
+- `--key-method 1=
` has been removed
+
+## User-visible Changes
+
+- If multiple connect hand=
lers are used (client-connect, ccd, connect plugin)
+  and one of the handl=
er succeeds but a subsequent fails, the
+  client-disconnect-script is now =
called immediately=2E Previously it was called,
+  when the VPN session was=
 terminated=2E
+- Support for building with OpenSSL 1=2E0=2E1 has been remo=
ved=2E The minimum
+  supported OpenSSL version is now 1=2E0=2E2=2E
+- The =
GET_CONFIG management state is omitted if the server pushes the client
+  c=
onfiguration almost immediately as result of the faster connection setup
+ =
 feature=2E
+- `--compress` is nowadays considered risky, because attacks e=
xist leveraging
+  compression-inside-crypto to reveal plaintext (VORACLE)=
=2E So by default,
+  `--compress xxx` will now accept incoming compressed =
packets (for
+  compatibility with peers that have not been upgraded yet), =
but will not use
+  compression outgoing packets=2E This can be controlled =
with the new option
+  `--allow-compression yes|no|asym`=2E
+- Stop changin=
g `--txlen` aways from OS defaults unless explicitly specified in
+  config=
 file=2E OS defaults nowadays are actually larger then what we used to
+  c=
onfigure, so our defaults sometimes caused packet drops =3D bad performance=
=2E
+- remove `--writepid` pid file on exit now
+- plugin-auth-pam now logs=
 via OpenVPN logging method, no longer to stderr (this
+  means you'll have=
 log messages in syslog or openvpn log file now)
+- use ISO 8601 time forma=
t for file based logging now (YYYY-MM-DD hh:mm:dd)
+  (syslog is not affect=
ed, nor is `--machine-readable-output`)
+- `--clr-verify` now loads all CRL=
s if more than one CRL is in the same file
+  (OpenSSL backend only, mbedTL=
S always did that)
+- when `--auth-user-pass file` has no password, and the=
 management interface is
+  active, query management interface (instead of =
trying console query, which
+  does not work on windows)
+- skip expired ce=
rtificates in Windows certificate store (`--cryptoapicert`)
+- `--socks-pro=
xy` + `--proto udp*` will now allways use IPv4, even if IPv6 is
+  requeste=
d and available=2E Our SOCKS code does not handle IPv6+UDP, and before
+  t=
hat change it would just fail in non-obvious ways=2E
+- TCP listen() backlo=
g queue is now set to 32 - this helps TCP servers that
+  receive lots of "=
invalid" connects by TCP port scanners
+- do no longer print OCC warnings (=
"option mismatch") about `key-method`,
+  `keydir`, `tls-auth` and `cipher`=
 - these are either gone now, or negotiated,
+  and the warnings do not ser=
ve a useful purpose=2E
+- `dhcp-option DNS` and `dhcp-option DNS6` are now =
treated identically (=3D both
+  accept an IPv4 or IPv6 address for the nam=
eserver)
+
+## Maintainer-visible changes
+
+- the man page is now in maint=
ained in =2Erst format, so building the openvpn=2E8
+  manpage from a git c=
heckout now requires python-docutils (if this is missing,
+  the manpage wi=
ll not be built - which is not considered an error generally,
+  but for pa=
ckage builders or `make distcheck` it is)=2E Release tarballs contain
+  th=
e openvpn=2E8 file, so unless some =2Erst is changed, doc-utils are not nee=
ded
+  for building=2E
+- OCC support can no longer be disabled
+- AEAD sup=
port is now required in the crypto library
+- `--disable-server` has been r=
emoved from configure (so it is no longer
+  possible to build a client-/p2=
p-only OpenVPN binary) - the saving in code size
+  no longer outweighs the=
 extra maintenance effort=2E
+- `--enable-iproute2` will disable netlink(3)=
 support, so maybe remove that from
+  package building configs (see above)=

+- support building with MSVC 2019
+- cmocka based unit tests are now only=
 run if cmocka is installed externally
+  (2=2E4 used to ship a local git s=
ubmodule which was painful to maintain)
+- `--disable-crypto` configure opt=
ion has been removed=2E OpenVPN is now always
+  built with crypto support,=
 which makes the code much easier to maintain=2E This
+  does not affect `-=
-cipher none` to do a tunnel without encryption=2E
+- `--disable-multi` con=
figure option has been removed
+
+# Overview of changes in 2=2E4
+
+## New =
features
+
+* **Seamless client IP/port floating**
+
+  Added new packet fo=
rmat P_DATA_V2, which includes peer-id=2E If both the server
+  and client =
support it, the client sends all data packets in the new format=2E When
+  =
a data packet arrives, the server identifies peer by peer-id=2E If peer's i=
p/port
+  has changed, server assumes that client has floated, verifies HMA=
C and updates
+  ip/port in internal structs=2E This allows the connection =
to be immediately
+  restored, instead of requiring a TLS handshake before =
the server accepts packets
+  from the new client ip/port=2E
+
+* **Data ch=
annel cipher negotiation**
+
+  Data channel ciphers (`--cipher`) are now b=
y default negotiated=2E If a client
+  advertises support for Negotiable Cr=
ypto Parameters (NCP), the server will
+  choose a cipher (by default AES-2=
56-GCM) for the data channel, and tell the
+  client to use that cipher=2E =
Data channel cipher negotiation can be controlled
+  using `--ncp-ciphers` =
and `--ncp-disable`=2E
+
+  A more limited version also works in client-to-=
server and server-to-client
+  scenarios where one of the end points uses a=
 v2=2E4 client or server and the other
+  side uses an older version=2E In =
such scenarios the v2=2E4 side will change to the
+  `--cipher` set by the =
remote side, if permitted by by `--ncp-ciphers`=2E For
+  example, a v2=2E4=
 client with `--cipher BF-CBC` and
+  `ncp-ciphers AES-256-GCM:AES-256-CBC`=
 can connect to both a v2=2E3 server with
+  `cipher BF-CBC` as well as a s=
erver with `cipher AES-256-CBC` in its config=2E The
+  other way around, a=
 v2=2E3 client with either `cipher BF-CBC` or
+  `cipher AES-256-CBC` can c=
onnect to a v2=2E4 server with e=2Eg=2E `cipher BF-CBC` and
+  `ncp-ciphers=
 AES-256-GCM:AES-256-CBC` in its config=2E For this to work it
+  requires =
that OpenVPN was built without disabling OCC support=2E
+
+* **AEAD (GCM) d=
ata channel cipher support**
+
+  The data channel now supports AEAD cipher=
s (currently only GCM)=2E The AEAD packet
+  format has a smaller crypto ov=
erhead than the CBC packet format, (e=2Eg=2E 20 bytes
+  per packet for AES=
-128-GCM instead of 36 bytes per packet for AES-128-CBC +
+  HMAC-SHA1)=2E
=
+
+* **ECDH key exchange**
+
+  The TLS control channel now supports for el=
liptic curve diffie-hellmann key
+  exchange (ECDH)=2E
+
+* **Improved Cert=
ificate Revocation List (CRL) processing**
+
+  CRLs are now handled by the=
 crypto library (OpenSSL or mbed TLS), instead of
+  inside OpenVPN itself=
=2E The crypto library implementations are more strict than
+  the OpenVPN =
implementation was=2E This might reject peer certificates that would
+  pre=
viously be accepted=2E If this occurs, OpenVPN will log the crypto library'=
s
+  error description=2E
+
+* **Dualstack round-robin DNS client connect**=

+
+  Instead of only using the first address of each `--remote` OpenVPN wi=
ll now try
+  all addresses (IPv6 and IPv4) of a `--remote` entry=2E
+
+* *=
*Support for providing IPv6 DNS servers**
+
+  A new DHCP sub-option `DNS6`=
 is added alongside with the already existing `DNS`
+  sub-option=2E This i=
s used to provide DNS resolvers available over IPv6=2E This may
+  be pushe=
d to clients where `--up` scripts and `--plugin` can act upon it through
+ =
 the `foreign_option_<n>` environment variables=2E
+
+  Support for the Win=
dows client picking up this new sub-option is added, however
+  IPv6 DNS re=
solvers need to be configured via `netsh` which requires
+  administrator p=
rivileges unless the new interactive services on Windows is being
+  used=
=2E If the interactive service is used, this service will execute `netsh` i=
n
+  the background with the proper privileges=2E
+
+* **New improved Windo=
ws Background service**
+
+  The new OpenVPNService is based on openvpnserv=
2, a complete rewrite of the
+  OpenVPN service wrapper=2E It is intended f=
or launching OpenVPN instances that
+  should be up at all times, instead o=
f being manually launched by a user=2E
+  OpenVPNService is able to restart=
 individual OpenVPN processes if they crash,
+  and it also works properly =
on recent Windows versions=2E OpenVPNServiceLegacy
+  tends to work poorly,=
 if at all, on newer Windows versions (8+) and its use is
+  not recommende=
d=2E
+
+* **New interactive Windows service**
+
+  The installer starts Ope=
nVPNServiceInteractive automatically and configures it
+  to start at syste=
m startup=2E
+
+  The interactive Windows service allows unprivileged users=
 to start OpenVPN
+  connections in the global config directory (usually C:=
\Program
+  Files\OpenVPN\config) using OpenVPN GUI without any extra confi=
guration=2E
+
+  Users who belong to the built-in Administrator group or to=
 the local "OpenVPN
+  Administrator" group can also store configuration fi=
les under
+  %USERPROFILE%\OpenVPN\config for use with the interactive serv=
ice=2E
+
+* **redirect-gateway ipv6**
+
+  OpenVPN has now feature parity b=
etween IPv4 and IPv6 for redirect gateway
+  including the handling of over=
lapping IPv6 routes with IPv6 remote VPN server
+  address=2E
+
+* **LZ4 Co=
mpression and pushable compression**
+
+  Additionally to LZO compression O=
penVPN now also supports LZ4 compression=2E
+  Compression options are now =
pushable from the server=2E
+
+* **Filter pulled options client-side: pull-=
filter**
+
+  New option to explicitly allow or reject options pushed by th=
e server=2E May be
+  used multiple times and is applied in the order speci=
fied=2E
+
+* **Per-client remove push options: push-remove**
+
+  New optio=
n to remove options on a per-client basis from the "push" list (more
+  fin=
e-grained than `--push-reset`)=2E
+
+* **Http proxy password inside config =
file**
+
+  Http proxy passwords can be specified with the inline file opti=
on
+  `<http-proxy-user-pass>` =2E=2E `</http-proxy-user-pass>`
+
+* **Wind=
ows version detection**
+
+  Windows version is detected, logged and possib=
ly signalled to server
+  (`IV_PLAT_VER=3D<nn>` if `--push-peer-info` is se=
t on client)=2E
+
+* **Authentication tokens**
+
+  In situations where it =
is not suitable to save user passwords on the client,
+  OpenVPN has suppor=
t for pushing a --auth-token since v2=2E3=2E This option is pushed
+  from =
the server to the client with a token value to be used instead of the users=

+  password=2E For this to work, the authentication plug-in would need to =
implement
+  this support as well=2E In OpenVPN 2=2E4 --auth-gen-token is i=
ntroduced, which will
+  allow the OpenVPN server to generate a random toke=
n and push it to the client
+  without any changes to the authentication mo=
dules=2E When the clients need to
+  re-authenticate the OpenVPN server wil=
l do the authentication internally,
+  instead of sending the re-authentica=
tion request to the authentication module =2E
+  This feature is especially=
 useful in configurations which use One Time Password
+  (OTP) authenticati=
on schemes, as this allows the tunnel keys to be renegotiated
+  regularly =
without any need to supply new OTP codes=2E
+
+* **keying-material-exporter=
**
+
+  Keying Material Exporter [RFC-5705] allow additional keying materia=
l to be
+  derived from existing TLS channel=2E
+
+* **Android platform sup=
port**
+
+  Support for running on Android using Android's VPNService API h=
as been added=2E
+  See doc/android=2Etxt for more details=2E This support =
is primarily used in the
+  OpenVPN for Android app (<https://github=2Ecom/=
schwabe/ics-openvpn>)
+
+* **AIX platform support**
+
+  AIX platform suppo=
rt has been added=2E The support only includes tap devices since
+  AIX doe=
s not provide tun interface=2E
+
+* **Control channel encryption (`--tls-cr=
ypt`)**
+
+  Use a pre-shared static key (like the `--tls-auth` key) to enc=
rypt control
+  channel packets=2E Provides more privacy, some obfuscation =
and poor-man's
+  post-quantum security=2E
+
+* **Asynchronous push reply**=

+
+  Plug-ins providing support for deferred authentication can benefit fr=
om a more
+  responsive authentication where the server sends PUSH\_REPLY i=
mmediately once the
+  authentication result is ready, instead of waiting f=
or the client to to send
+  PUSH\_REQUEST once more=2E This requires OpenVP=
N to be built with
+  `=2E/configure --enable-async-push`=2E This is a comp=
ile-time only switch=2E
+
+## Deprecated features
+
+For an up-to-date list=
 of all deprecated options, see this wiki page:
+<https://community=2Eopenv=
pn=2Enet/openvpn/wiki/DeprecatedOptions>
+
+- `--key-method 1` is deprecate=
d in OpenVPN 2=2E4 and will be removed in v2=2E5=2E
+  Migrate away from `-=
-key-method 1` as soon as possible=2E The recommended
+  approach is to rem=
ove the `--key-method` option from the configuration files,
+  OpenVPN will=
 then use `--key-method 2` by default=2E Note that this requires
+  changin=
g the option in both the client and server side configs=2E
+- `--tls-remote=
` is removed in OpenVPN 2=2E4, as indicated in the v2=2E3 man-pages=2E
+  S=
imilar functionality is provided via `--verify-x509-name`, which does the
+=
  same job in a better way=2E
+- `--compat-names` and `--no-name-remapping`=
 were deprecated in OpenVPN 2=2E3 and
+  will be removed in v2=2E5=2E All s=
cripts and plug-ins depending on the old
+  non-standard X=2E509 subject fo=
rmatting must be updated to the standardized
+  formatting=2E See the man p=
age for more information=2E
+- `--no-iv` is deprecated in OpenVPN 2=2E4 and=
 will be removed in v2=2E5=2E
+- `--keysize` is deprecated in OpenVPN 2=2E4=
 and will be removed in v2=2E6 together
+  with the support of ciphers with=
 cipher block size less than 128-bits=2E
+- `--comp-lzo` is deprecated in O=
penVPN 2=2E4=2E Use `--compress` instead=2E
+- `--ifconfig-pool-linear` has=
 been deprecated since OpenVPN 2=2E1 and will be
+  removed in v2=2E5=2E Us=
e `--topology p2p` instead=2E
+- `--client-cert-not-required` is deprecated=
 in OpenVPN 2=2E4 and will be removed
+  in v2=2E5=2E Use `--verify-client-=
cert none` for a functional equivalent=2E
+- `--ns-cert-type` is deprecated=
 in OpenVPN 2=2E3=2E18 and v2=2E4=2E It will be removed
+  in v2=2E5=2E Use=
 the far better `--remote-cert-tls` option which replaces this
+  feature=
=2E
+
+## User-visible Changes
+
+- When using ciphers with cipher blocks l=
ess than 128-bits, OpenVPN will
+  complain loudly if the configuration use=
s ciphers considered weak, such as the
+  SWEET32 attack vector=2E In such =
scenarios, OpenVPN will by default renegotiate
+  for each 64MB of transpor=
ted data (`--reneg-bytes`)=2E This renegotiation can be
+  disabled, but is=
 HIGHLY DISCOURAGED=2E
+
+- For certificate DNs with duplicate fields, e=2E=
g=2E "OU=3Done,OU=3Dtwo", both fields
+  are now exported to the environmen=
t, where each second and later occurrence of
+  a field get `_$N` appended =
to it's field name, starting at N=3D1=2E For the
+  example above, that wou=
ld result in e=2Eg=2E `X509_0_OU=3Done`, `X509_0_OU_1=3Dtwo`=2E Note
+  tha=
t this breaks setups that rely on the fact that OpenVPN would previously
+ =
 (incorrectly) only export the last occurrence of a field=2E
+
+- `proto ud=
p` and `proto tcp` now use both IPv4 and IPv6=2E The new options
+  `proto =
udp4` and `proto tcp4` use IPv4 only=2E
+
+- `--sndbuf` and `--recvbuf` def=
ault now to OS defaults instead of 64k
+
+- OpenVPN exits with an error if =
an option has extra parameters; previously they
+  were silently ignored
+
=
+- `--tls-auth` always requires OpenVPN static key files and will no longer=
 work
+  with free form files
+
+- `--proto udp6/tcp6` in server mode will =
now try to always listen to both IPv4
+  and IPv6 on platforms that allow i=
t=2E Use `--bind ipv6only` to explicitly
+  listen only on IPv6=2E
+
+- Rem=
oved `--enable-password-save` from configure=2E This option is now always
+=
  enabled=2E
+
+- Stricter default TLS cipher list (override with `--tls-ci=
pher`), that now also
+  disables:
+
+  - Non-ephemeral key exchange using =
static (EC)DH keys
+  - DSS private keys
+
+- mbed TLS builds: changed the =
`tls_digest_N` values exported to the script
+  environment to be equal to =
the ones exported by OpenSSL builds, namely the
+  certificate fingerprint =
(was the hash of the 'to be signed' data)=2E
+
+- mbed TLS builds: minimum =
RSA key size is now 2048 bits=2E Shorter keys will not
+  be accepted, both=
 local and from the peer=2E
+
+- `--connect-timeout` now specifies the time=
out until the first TLS packet is
+  received (identical to `--server-poll-=
timeout`) and this timeout now includes
+  the removed socks proxy timeout =
and http proxy timeout=2E
+
+  In `--static` mode `connect-timeout` specifi=
es the timeout for TCP and proxy
+  connection establishment
+
+- `--connec=
t-retry-max` now specifies the maximum number of unsuccessful
+  attempts o=
f each remote/connection entry before exiting=2E
+
+- `--http-proxy-timeout=
` and the static non-changeable socks timeout (5s) have
+  been folded into=
 a "unified" `--connect-timeout` which covers all steps needed
+  to connec=
t to the server, up to the start of the TLS exchange=2E The default
+  valu=
e has been raised to 120s, to handle slow http/socks proxies graciously=2E
=
+  The old "fail TCP fast" behaviour can be achieved by adding
+  "`--conne=
ct-timeout 10`" to the client config=2E
+
+- `--http-proxy-retry` and `--so=
ck-proxy-retry` have been removed=2E Proxy
+  connections will now behave l=
ike regular connection entries and generate a
+  USR1 on failure=2E
+
+- `-=
-connect-retry` gets an optional second argument that specifies the maximum=

+  time in seconds to wait between reconnection attempts when an exponenti=
al
+  backoff is triggered due to repeated retries=2E Default =3D 300 secon=
ds=2E
+
+- Data channel cipher negotiation (see New features section) can o=
verride
+  ciphers configured in the config file=2E Use `--ncp-disable` if =
you do not want
+  this behavior=2E
+
+- All tun devices on all platforms a=
re always considered to be IPv6 capable=2E The
+  `--tun-ipv6` option is ig=
nored (behaves like it is always on)=2E
+
+- On the client side recursively=
 routed packets, which have the same destination
+  as the VPN server, are =
dropped=2E This can be disabled with
+  --allow-recursive-routing option=2E=

+
+- On Windows, when the `--register-dns` option is set, OpenVPN no longe=
r
+  restarts the `dnscache` service - this had unwanted side effects, and =
seems to
+  be no longer necessary with currently supported Windows version=
s=2E
+
+- If no flags are given, and the interactive Windows service is use=
d, "def1" is
+  implicitly set (because "delete and later reinstall the exi=
sting default
+  route" does not work well here)=2E If not using the servic=
e, the old behaviour
+  is kept=2E
+
+- OpenVPN now reloads a CRL only if t=
he modication time or file size has
+  changed, instead of for each new con=
nection=2E This reduces the connection setup
+  time, in particular when us=
ing large CRLs=2E
+
+- OpenVPN now ships with more up-to-date systemd unit =
files which take advantage
+  of the improved service management as well as=
 some hardening steps=2E The
+  configuration files are picked up from the =
/etc/openvpn/server/ and
+  /etc/openvpn/client/ directories (depending on =
unit file)=2E This also avoids
+  these new unit files and how they work to=
 collide with older pre-existing unit
+  files=2E
+
+- Using `--no-iv` (whi=
ch is generally not a recommended setup) will require
+  explicitly disabli=
ng NCP with `--disable-ncp`=2E This is intentional because NCP
+  will by d=
efault use AES-GCM, which requires an IV - so we want users of that
+  opti=
on to consciously reconsider=2E
+
+## Maintainer-visible changes
+
+- OpenV=
PN no longer supports building with crypto support, but without TLS
+  supp=
ort=2E As a consequence, `OPENSSL_CRYPTO_{CFLAGS,LIBS}` and
+  `OPENSSL_SSL=
_{CFLAGS,LIBS}` have been merged into `OPENSSL_{CFLAGS,LIBS}`=2E
+  This is=
 particularly relevant for maintainers who build their own OpenSSL
+  libra=
ry, e=2Eg=2E when cross-compiling=2E
+- Linux distributions using systemd i=
s highly encouraged to ship these new unit
+  files instead of older ones, =
to provide a unified behaviour across systemd
+  based Linux distributions=
=2E
+- With OpenVPN 2=2E4, the project has moved over to depend on and acti=
vely use the
+  official C99 standard (-std=3Dc99)=2E This may fail on some=
 older compiler/libc
+  header combinations=2E In most of these situations =
it is recommended to use
+  -std=3Dgnu99 in CFLAGS=2E This is known to be n=
eeded when doing i386/i686 builds
+  on RHEL5=2E
+
+# Version 2=2E4=2E5
+
+=
## New features
+
+- The new option `--tls-cert-profile` can be used to res=
trict the set of allowed
+  crypto algorithms in TLS certificates in mbed T=
LS builds=2E The default profile
+  is 'legacy' for now, which allows SHA1+=
, RSA-1024+ and any elliptic curve
+  certificates=2E The default will be c=
hanged to the 'preferred' profile in the
+  future, which requires SHA2+, R=
SA-2048+ and any curve=2E
+
+# Version 2=2E4=2E3
+
+## New features
+
+- Su=
pport building with OpenSSL 1=2E1 now (in addition to older versions)
+- On=
 Win10, set low interface metric for TAP adapter when block-outside-dns is
=
+  in use, to make Windows prefer the TAP adapter for DNS queries (avoiding=
 large
+  delays)
+
+## Security
+
+- CVE-2017-7522: Fix `--x509-track` pos=
t-authentication remote DoS A client
+  could crash a v2=2E4+ mbedtls serve=
r, if that server uses the `--x509-track`
+  option and the client has a co=
rrect, signed and unrevoked certificate that
+  contains an embedded NUL in=
 the certificate subject=2E Discovered and reported
+  to the OpenVPN secur=
ity team by Guido Vranken=2E
+- CVE-2017-7521: Fix post-authentication remo=
te-triggerable memory leaks A
+  client could cause a server to leak a few =
bytes each time it connects to the
+  server=2E That can eventually cause t=
he server to run out of memory, and thereby
+  causing the server process t=
o terminate=2E Discovered and reported to the
+  OpenVPN security team by G=
uido Vranken=2E (OpenSSL builds only=2E)
+- CVE-2017-7521: Fix a potential =
post-authentication remote code execution
+  attack on servers that use the=
 `--x509-username-field` option with an X=2E509
+  extension field (option =
argument prefixed with `ext:`)=2E A client that can
+  cause a server to ru=
n out-of-memory (see above) might be able to cause the
+  server to double =
free, which in turn might lead to remote code execution=2E
+  Discovered an=
d reported to the OpenVPN security team by Guido Vranken=2E
+  (OpenSSL bui=
lds only=2E)
+- CVE-2017-7520: Pre-authentication remote crash/information =
disclosure for
+  clients=2E If clients use a HTTP proxy with NTLM authenti=
cation (i=2Ee=2E
+  `--http-proxy <server> <port> [<authfile>|'auto'|'auto-=
nct'] ntlm2`), a
+  man-in-the-middle attacker between the client and the p=
roxy can cause the
+  client to crash or disclose at most 96 bytes of stack=
 memory=2E The disclosed
+  stack memory is likely to contain the proxy pas=
sword=2E If the proxy password is
+  not reused, this is unlikely to compro=
mise the security of the OpenVPN tunnel
+  itself=2E Clients who do not use=
 the `--http-proxy` option with ntlm2
+  authentication are not affected=2E=

+- CVE-2017-7508: Fix remotely-triggerable ASSERT() on malformed IPv6 pack=
et=2E
+  This can be used to remotely shutdown an openvpn server or client,=
 if IPv6 and
+  `--mssfix` are enabled and the IPv6 networks used inside th=
e VPN are known=2E
+- Fix null-pointer dereference when talking to a malici=
ous http proxy that
+  returns a malformed `Proxy-Authenticate:` headers fo=
r digest auth=2E
+- Fix overflow check for long `--tls-cipher` option
+- Wi=
ndows: Pass correct buffer size to `GetModuleFileNameW()` (OSTIF/Quarkslabs=

+  audit, finding 5=2E6)
+
+## User-visible Changes
+
+- `--verify-hash` c=
an now take an optional flag which changes the hashing
+  algorithm=2E It c=
an be either SHA1 or SHA256=2E The default if not provided is
+  SHA1 to pr=
eserve backwards compatibility with existing configurations=2E
+- Restrict =
the supported `--x509-username-field` extension fields to
+  subjectAltName=
 and issuerAltName=2E Other extensions probably didn't work
+  anyway, and =
would cause OpenVPN to crash when a client connects=2E
+
+## Bugfixes
+
+- =
Fix fingerprint calculation in mbed TLS builds=2E This means that mbed TLS =
users
+  of OpenVPN 2=2E4=2E0, v2=2E4=2E1 and v2=2E4=2E2 that rely on the v=
alues of the
+  `tls_digest_*` env vars, or that use `--verify-hash` will h=
ave to change the
+  fingerprint values they check against=2E The security =
impact of the incorrect
+  calculation is very minimal; the last few bytes =
(max 4, typically 4) are not
+  verified by the fingerprint=2E We expect no=
 real-world impact,
+  because users that used this feature before will not=
ice that it has suddenly
+  stopped working, and users that didn't will not=
ice that connection setup fails
+  if they specify correct fingerprints=2E
=
+
+- Fix edge case with NCP when the server sends an empty PUSH_REPLY messa=
ge back,
+  and the client would not initialize it's data channel crypto la=
yer properly
+  (trac #903)
+
+- Fix SIGSEGV on unaligned buffer access on =
OpenBSD/Sparc64
+
+- Fix TCP_NODELAY on OpenBSD
+
+- Remove erroneous limit=
ation on max number of args for `--plugin`
+
+- Fix NCP behaviour on TLS re=
connect (Server would not send a proper "cipher
+  =2E=2E=2E" message back =
to the client, leading to client and server using different
+  ciphers) (tr=
ac #887)
+
+# Version 2=2E4=2E2
+
+## Bugfixes
+
+- Fix memory leak introdu=
ced in OpenVPN 2=2E4=2E1: if `--remote-cert-tls` is used,
+  we leaked some=
 memory on each TLS (re)negotiation=2E
+
+## Security
+
+- Fix a pre-authen=
tication denial-of-service attack on both clients and servers=2E
+  By send=
ing a too-large control packet, OpenVPN 2=2E4=2E0 or v2=2E4=2E1 can be forc=
ed
+  to hit an ASSERT() and stop the process=2E If `--tls-auth` or `--tls-=
crypt` is
+  used, only attackers that have the `--tls-auth` or `--tls-cryp=
t` key can mount
+  an attack=2E (OSTIF/Quarkslab audit finding 5=2E1, CVE-=
2017-7478)
+- Fix an authenticated remote DoS vulnerability that could be t=
riggered by
+  causing a packet id roll over=2E An attack is rather ineffic=
ient; a peer would
+  need to get us to send at least about 196 GB of data=
=2E (OSTIF/Quarkslab audit
+  finding 5=2E2, CVE-2017-7479)
+
+# Version 2=
=2E4=2E1
+
+- `--remote-cert-ku` now only requires the certificate to have =
at least the bits
+  set of one of the values in the supplied list, instead=
 of requiring an exact
+  match to one of the values in the list=2E
+- `--r=
emote-cert-tls` now only requires that a keyUsage is present in the
+  cert=
ificate, and leaves the verification of the value up to the crypto
+  libra=
ry, which has more information (i=2Ee=2E the key exchange method in use) to=

+  verify that the keyUsage is correct=2E
+- `--ns-cert-type` is deprecate=
d=2E Use `--remote-cert-tls` instead=2E The
+  nsCertType x509 extension is=
 very old, and barely used=2E `--remote-cert-tls`
+  uses the far more comm=
on keyUsage and extendedKeyUsage extension instead=2E Make
+  sure your cer=
tificates carry these to be able to use `--remote-cert-tls`=2E
diff --git a=
/Changes=2Erst b/Changes=2Erst
deleted file mode 100644
index fe81909=2E=2E=
0000000
--- a/Changes=2Erst
+++ /dev/null
@@ -1,1480 +0,0 @@
-Overview of c=
hanges in 2=2E8
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
-User-visible Changes
---------------------
-Parsing =
Distinguished Names in certificates
-    (OpenSSL backend:) OpenVPN now rej=
ects certificates that have a null-byte
-    inside any of the field values=
 of their subject=2E To avoid ambiguity in the
-    parsed subject, OpenVPN=
 escapes the following characters by prefixing them with
-    a backslash:
=
-     * " " (space) at the start or end of a field,
-     * "#" at the star=
t of a field,
-     * ",", "+", """, "\", "<", ">" and ";" anywhere=2E
-
- =
   As a result, if you use the option ``--verify-x509-name <expected subjec=
t>``,
-    you need to prefix these characters with a backslash in your con=
figuration=2E
-    The subject passed to a ``--tls-verify`` script is escap=
ed in the same way and
-    you may need to adjust your script=2E
-
-    (M=
bed TLS backend:) The behavior has not changed=2E Subjects with null-bytes =
were
-    already rejected (assuming OpenVPN was built with Mbed TLS 3=2E5 =
or later) and
-    the characters mentioned above were already escaped=2E H=
owever, the behavior of
-    Mbed TLS is slightly different from OpenSSL in=
 that it also escapes "=3D"=2E
-
-
-Overview of changes in 2=2E7
-=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-New =
features
-------------
-Multi-socket support for servers
-    OpenVPN serve=
rs now can listen on multiple sockets at the same time=2E
-    Multiple ``-=
-local`` statements in the configuration can be used to
-    configure this=
=2E This way the same server can e=2Eg=2E listen for UDP
-    and TCP conne=
ctions at the same time, or listen on multiple addresses
-    and/or ports=
=2E
-
-Client implementations for DNS options sent by server for Linux/BSD/=
macOS
-    Linux, BSD and macOS versions of OpenVPN now ship with a per-pla=
tform
-    default ``--dns-updown`` script that implements proper handling =
of
-    DNS configuration sent by the server=2E  The scripts should work on=

-    systems that use ``systemd`` or ``resolveconf`` to manage the DNS
-  =
  setup, as well as raw ``/etc/resolv=2Econf`` files=2E However, the exact
=
-    features supported will depend on the configuration method=2E
-    On =
Linux and MacOS this should usually make split-DNS configurations
-    supp=
orted out-of-the-box now=2E
-
-    Note that this new script will not be us=
ed by default if a ``--up``
-    script is already in use to reduce problem=
s with
-    backwards compatibility=2E
-
-    See documentation for ``--dns=
-updown`` and ``--dns`` for more details=2E
-
-New client implementation fo=
r DNS options sent by server for Windows
-    The Windows client now uses N=
RPT (Name Resolution Policy Table) to
-    handle DNS configurations=2E Thi=
s adds support for split-DNS and DNSSEC
-    and improves the compatbility =
with local DNS resolvers=2E Requires the
-    interactive service=2E
-
-On =
Windows the ``block-local`` flag is now enforced with WFP filters=2E
-    T=
he ``block-local`` flag to ``--redirect-gateway`` and
-    ``--redirect-pri=
vate`` is now also enforced via the Windows Firewall,
-    making sure pack=
ets can't be sent to the local network=2E
-    This provides stronger prote=
ction against TunnelCrack-style attacks=2E
-
-Windows network adapters are =
now generated on demand
-    This means that on systems that run multiple O=
penVPN connections at
-    the same time the users don't need to manually c=
reate enough network
-    adapters anymore (in addition to the ones created=
 by the installer)=2E
-
-Windows automatic service now runs as an unprivile=
dged user
-    All tasks that need privileges are now delegated to the inte=
ractive
-    service=2E
-    **NOTE** this has the risk of breaking existin=
g setups if the
-    Windows certificate store is used (cryptoapi), and the=
 certificates
-    are not readable for ``NT SERVICE\OpenVPNService``=2E
-
=
-Support for new version of Linux DCO module
-    The OpenVPN DCO module ha=
s been merged into the Linux kernel as of
-    6=2E16=2E  This required som=
e API changes and OpenVPN 2=2E7 only supports
-    the new API=2E The new m=
odule is called ``ovpn``=2E Out-of-tree builds
-    for older kernels are a=
vailable from
-    https://github=2Ecom/OpenVPN/ovpn-backports=2E Please
- =
   see the release announcements for further information=2E
-
-Support for =
server mode in win-dco driver
-    On Windows the win-dco driver can now be=
 used in server setups=2E
-
-Support for TLS client floating in DCO impleme=
ntations
-    The kernel modules will detect clients floating to a new IP a=
ddress
-    and notify userland so both data packets (kernel) and TLS packe=
ts
-    (sent by userland) can reach the new client IP=2E
-    (Actual supp=
ort depends on recent-enough kernel implementation)
-
-Enforcement of AES-G=
CM usage limit
-    OpenVPN will now enforce the usage limits on AES-GCM wi=
th the same
-    confidentiality margin as TLS 1=2E3 does=2E This mean that=
 renegotiation will
-    be triggered after roughly 2^28 to 2^31 packets de=
pending of the packet
-    size=2E More details about usage limit of AES-GC=
M can be found here:
-
-    https://datatracker=2Eietf=2Eorg/doc/draft-irtf=
-cfrg-aead-limits/
-
-Epoch data keys and packet format
-    This introduce=
s the epoch data format for AEAD data channel
-    ciphers in TLS mode ciph=
ers=2E This new data format has a number of
-    improvements over the stan=
dard "DATA_V2" format=2E
-
-    - AEAD tag at the end of packet which is mo=
re hardware implementation
-      friendly
-    - Automatic key switchover =
when cipher usage limits are hit, similar to
-      the epoch data keys in =
(D)TLS 1=2E3
-    - 64 bit instead of 32 bit packet ids to allow the data c=
hannel to be
-      ready for 10 GBit/s without having frequent renegotiati=
on
-    - IV constructed with XOR instead of concatenation to not have (par=
ts) of
-      the real IV on the wire
-
-Support for Epoch data channel on =
Windows, using the win-dco driver (2=2E8=2E0+)
-
-Default ciphers in ``--da=
ta-ciphers``
-    Ciphers in ``--data-ciphers`` can contain the string DEFA=
ULT that is
-    replaced by the default ciphers used by OpenVPN, making it=
 easier to
-    add an allowed cipher without having to spell out the defau=
lt ciphers=2E
-
-TLS alerts
-    OpenVPN 2=2E7 will send out TLS alerts to =
peers informing them if the TLS
-    session shuts down or when the TLS imp=
lementation informs the peer about
-    an error in the TLS session (e=2Eg=
=2E mismatching TLS versions)=2E This improves
-    the user experience as =
the client shows an error instead of running into
-    a timeout when the s=
erver just stops responding completely=2E
-
-Support for tun/tap via unix d=
omain socket and lwipovpn support
-    To allow better testing and emulatin=
g a full client with a full
-    network stack OpenVPN now allows a program=
 executed to provide
-    a tun/tap device instead of opening a device=2E
-=

-    The co-developed lwipovpn program based on lwIP stack allows to
-    =
simulate full IP stack=2E An OpenVPN client using
-    ``--dev-node unix:/p=
ath/to/lwipovpn`` can emulate a full client that
-    can be pinged, can se=
rve a website and more without requiring any
-    elevated permission=2E Th=
is can make testing OpenVPN much easier=2E
-
-    For more details see
-   =
 `lwipovpn on Github <https://github=2Ecom/OpenVPN/lwipovpn>`_=2E
-
-Allow =
overriding username with ``--override-username``
-    This is intended to a=
llow using ``--auth-gen-token`` in scenarios where the
-    clients use cer=
tificates and multi-factor authentication=2E  This will
-    also generate =
a ``push "auth-token-user newusername"`` directive in
-    push replies=2E
=
-
-``--port-share`` now properly supports IPv6
-    Issues with logging of =
IPv6 addresses were fixed=2E The feature now allows
-    IPv6 connections t=
owards the proxy receiver=2E
-
-Support for Haiku OS
-
-TLS1=2E3 support wi=
th mbedTLS (requires mbedTLS >=3D 3=2E6=2E4)
-
-PUSH_UPDATE client support
=
-    It is now possible to update parts of the client-side configuration
- =
   (IP address, routes, MTU, DNS) by sending a new server-to-client
-    co=
ntrol message, ``PUSH_UPDATE,<options>``=2E
-    See also: https://openvpn=
=2Egithub=2Eio/openvpn-rfc/openvpn-wire-protocol=2Ehtml
-    NOTE: PUSH_UPD=
ATE client support is currently disabled if DCO
-    is active (on all plat=
forms)=2E
-
-PUSH_UPDATE server support (minimal)
-    New management inter=
face commands ``push-update-broad`` and
-    ``push-update-cid`` to send PU=
SH_UPDATE option updates to all
-    clients ("there is a new DNS server") =
or only a specific client ID
-    ("privileges have changed, here's a new I=
P address")=2E  See
-    doc/management-notes=2Etxt
-    NOTE: PUSH_UPDATE =
server support is currently disabled if DCO
-    is active (on all platform=
s)=2E
-
-Support for user-defined routing tables on Linux
-    See the ``--=
route-table`` option in the manpage
-
-PQE support for WolfSSL
-
-Two new e=
nvironment variables have been introduced to communicate desired
-    defau=
lt gateway redirection to plugins like Network Manager,
-    ``route_redire=
ct_gateway_ipv4`` and ``route_redirect_gateway_ipv6``=2E
-    See the "Envi=
ronmental Variables" section in the man page
-
-Improved logging of service=
 events/errors to event log on Windows=2E
-
-"Recursive Routing" check is n=
ow more granular, and will only drop
-   packets-in-tunnel if destination I=
P, protocol and port matches with
-   those needed to reach the VPN server=
=2E  With that change, you can now
-   use policies that direct "everything=
 that is not OpenVPN" into the
-   tunnel, and have IP packets to the VPN s=
erver address arrive as
-   expected (no such policies are currently instal=
led by OpenVPN)
-   (GH: OpenVPN/openvpn#669)=2E
-
-COPYING: license detail=
s only relevant to our Windows installers have
-   been updated and moved t=
o the openvpn-build repo
-
-Improved BYTECOUNT support - more strictly adhe=
re to timing interval
-   requested, correctly support client and server co=
unters with Linux and
-   Windows DCO offloading=2E
-
-Improve compatibilit=
y with OpenSSL 3=2E6=2E0 (do not fail t_lpback selftest)
-
-New option ``--=
tls-crypt-v2-max-age n`` to check tls-crypt-v2 timestamps
-   (When a clien=
t is older than n days or has no timestamp, the server
-    will reject it)=

-
-mbedTLS 4 support has been added=2E
-   Note that with mbedTLS 4 algori=
thms need to be translated to
-   mbedTLS 4 internal IDs by OpenVPN, and so=
me names might be
-   missing=2E
-
-
-Deprecated features
-----------------=
---
-``secret`` support has been removed (by default)=2E
-    static key mo=
de (non-TLS) is no longer considered "good and secure enough"
-    for toda=
y's requirements=2E  Use TLS mode instead=2E  If deploying a PKI CA
-    is=
 considered "too complicated", using ``--peer-fingerprint`` makes
-    TLS =
mode about as easy as using ``--secret``=2E
-
-    This mode can still be e=
nabled by using
-    ``--allow-deprecated-insecure-static-crypto`` but will=
 be removed in
-    OpenVPN 2=2E8=2E
-
-Support for wintun Windows driver h=
as been removed=2E
-    OpenVPN 2=2E6 added support for the new dco-win dri=
ver, so it supported
-    three different device drivers: dco-win, wintun, =
and tap-windows6=2E
-    OpenVPN 2=2E7 now drops the support for wintun dri=
ver=2E By default
-    all modern configs should be supported by dco-win dr=
iver=2E In all
-    other cases OpenVPN will fall back automatically to tap=
-windows6
-    driver=2E
-
-NTLMv1 authentication support for HTTP proxies =
has been removed=2E
-    This is considered an insecure method of authentic=
ation that uses
-    obsolete crypto algorithms=2E
-    NTLMv2 support is s=
till available, but will be removed in a future
-    release=2E
-    When c=
onfigured to authenticate with NTLMv1 (``ntlm`` keyword in
-    ``--http-pr=
oxy``) OpenVPN will try NTLMv2 instead=2E
-
-``persist-key`` option has bee=
n enabled by default=2E
-    All the keys will be kept in memory across res=
tart=2E
-
-OpenSSL 1=2E0=2E2 support has been removed=2E
-    Support for b=
uilding with OpenSSL 1=2E0=2E2 has been removed=2E The minimum
-    support=
ed OpenSSL version is now 1=2E1=2E0=2E
-
-mbedTLS 2=2Ex support has been re=
moved
-    Support for building with mbedTLS 2=2Ex has been removed (it is =
out
-    of support since March 2025, and the necessary compatibility code
=
-    is making maintenance and support for mbedTLS 4=2Ex hard)=2E
-    The =
minimum supported mbedTLS version is now 3=2E2=2E1=2E
-
-Compression on sen=
d has been removed=2E
-    OpenVPN 2=2E7 will never compress data before se=
nding=2E Decompression of
-    received data is still supported=2E
-    ``-=
-allow-compression yes`` is now an alias for
-    ``--allow-compression asy=
m``=2E
-
-``--memstats`` feature removed
-    The ``--memstats`` option was=
 largely undocumented and there is no known
-    user of this feature=2E  T=
his feature provided very limited statistics
-    (number of users, link by=
tes read/written) and we do not except any
-    usage because of this=2E
-
=
-Using ``--push`` in a mode that is not ``--mode server`` will now print a
=
-    clear warning that this is an unsupported operation and might cause
- =
   negotiation failures=2E
-
-``--reneg-bytes`` and ``--reneg-packets`` do =
not work in DCO mode, and will
-    now print an appropriate warning=2E
-
-=
On-connect resolving of ``--remote`` addresses in ``--tcp-server`` mode
-  =
  was not working since 2=2E4, so the code was completely removed=2E
-
-
-U=
ser-visible Changes
---------------------
-- Default for ``--topology`` cha=
nged to ``subnet`` for ``--mode server``=2E
-  Previous releases always use=
d ``net30`` as default=2E This only affects
-  configs with ``--mode server=
`` or ``--server`` (the latter implies the
-  former), and ``--dev tun``, a=
nd only if IPv4 is enabled=2E
-  Note that this changes the semantics of ``=
--ifconfig``, so if you have
-  manual settings for that in your config but=
 not set ``--topology``
-  your config might fail to parse with the new ver=
sion=2E Just adding
-  ``--topology net30`` to the config should fix the pr=
oblem=2E
-  By default ``--topology`` is pushed from server to client=2E
-
=
-- ``--x509-username-field`` will no longer automatically convert fieldname=
s to
-  uppercase=2E This was deprecated since OpenVPN 2=2E4, and has now b=
een removed=2E
-
-- ``--dh none`` is now the default if ``--dh`` is not spe=
cified=2E Modern TLS
-  implementations will prefer ECDH and other more mod=
ern algorithms anyway=2E
-  And finite field Diffie Hellman is in the proce=
s of being deprecated
-  (see draft-ietf-tls-deprecate-obsolete-kex)
-
-- `=
`--lport 0`` does not imply ``--bind`` anymore=2E
-
-- ``--redirect-gateway=
`` now works correctly if the VPN remote is not
-  reachable by the default=
 gateway=2E
-
-- ``--show-gateway`` now supports querying the gateway for I=
Pv4 addresses=2E
-
-- ``--static-challenge`` option now has a third paramet=
er ``format`` that
-  can change how password and challenge response should=
 be combined=2E
-
-- ``--key`` and ``--cert`` now accept URIs implemented i=
n OpenSSL 3 as well as
-  optional OpenSSL 3 providers loaded using ``--pro=
viders`` option=2E
-
-- ``--cryptoapicert`` now supports issuer name as wel=
l as Windows CA template
-  name or OID as selector string=2E
-
-- TLS hand=
shake debugging information contains much more details now when
-  using re=
cent versions of OpenSSL=2E
-
-- The ``IV_PLAT_VER`` variable sent by Windo=
ws clients now contains the
-  full Windows build version to make it possib=
le to determine the
-  Windows 10 or Windows 11 version used=2E
-
-- The ``=
--windows-driver`` option to select between various windows
-  drivers will=
 no longer do anything - it's kept so existing configs
-  will not become i=
nvalid, but it is ignored with a warning=2E  The default
-  is now ``ovpn-d=
co`` if all options used are compatible with DCO, with
-  a fallback to ``t=
ap-windows6``=2E  To force TAP (for example because a
-  server pushes DCO =
incompatible options), use the ``--disable-dco``
-  option=2E
-
-- Apply mo=
re checks to incoming TLS handshake packets before creating
-  new state - =
namely, verify message ID / acked ID for "valid range for
-  an initial pac=
ket"=2E  This fixes a problem with clients that float
-  very early but sen=
d control channel packet from the pre-float IP
-  (Github: OpenVPN/openvpn#=
704)=2E
-
-- Use of ``--dh dh2048=2Epem`` in all sample configs has been re=
placed
-  with ``--dh none``=2E  The ``dh2048=2Epem`` file has been removed=
=2E
-
-- The startup delay in ``t_client=2Esh`` has been reduced from 3s to=
 1s,
-  making a noticeable difference for setups with many tests=2E
-
-- C=
hanged from using ``uncrustify`` for code formatting and pre-commit checks
=
-  to ``clang-format``=2E  This reformatted quite a bit of code, and requir=
es
-  that regular committers change their pre-commit checks accordingly=2E=

-
-- On Linux, on interfaces where applicable, OpenVPN explicitly configur=
es
-  the broadcast address again=2E  This was dropped for 2=2E6=2E0 "becau=
se
-  computers are smart and can do it themselves", but the kernel netlink=

-  interface isn't, and will install "0=2E0=2E0=2E0"=2E  This does not nor=
mally
-  matter, but for broadcast-based applications that get the address =
to
-  use from "ifconfig", this change repairs functionality (this has
-  b=
een backported to 2=2E6=2E15, but is not in earlier 2=2E6 versions)=2E
-
--=
 ``max-routes-per-client 0`` used to be silently upgraded to ``1``=2E  This=

-  now produces an error=2E
-
-- ``ifconfig`` and ``ifconfig-ipv6`` values=
 are now stored in pre-connect
-  options cache, and will be restored to pr=
e-connect values on reconnects
-  if the server stops pushing the respectiv=
e option=2E
-
-- ``tapctl=2Eexe`` helper binary on Windows has been reworke=
d to improve
-  help texts (making clear that it can not only do TAP-Adapte=
rs but
-  Win-DCO as well), add printing of the hwid to all adapter outputs=
, and
-  change the default adapter type created to ``ovpn-dco``=2E
-
-- Th=
e default for ``multihome`` egress interface handling has changed=2E
-  2=
=2E7=2E0 will default to ipi_ifindex=3D0, that is, leave the decision to th=
e
-  routing/policy setup of the operating system=2E  The pre-2=2E7 behavio=
ur
-  (force egress =3D ingress interface) can be achieved with the new
-  =
``--multihome same-interface`` sub-option=2E
-
-- Windows ``openvpn=2Eexe``=
 binary manifest now sets code page UTF8 - which
-  has no direct effect on=
 OpenVPN itself, but this repairs OpenSSL file
-  loading for key/cert file=
s with non-ASCII characters in their file names
-  (GH: OpenVPN/openvpn#920=
)=2E
-
-- The ``test-crypto`` option no longer requires a ``--secret`` argu=
ment and
-  will automatically generate a random key=2E
-
-- The configure-=
time option ``--enable-x509-alt-username`` is no longer
-  conditional, and=
 always-on (GH: OpenVPN/openvpn#917)=2E
-
-
-Deprecated features
----------=
----------
-``--opt-verify`` feature removed
-    This option was already d=
eprecated and it is now being converted to a
-    no-op=2E Using this optio=
n will only print a warning=2E
-
-
-Overview of changes in 2=2E6
-=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Pr=
oject changes
----------------
-
-We want to deprecate our old Trac bug tra=
cking system=2E
-Please report any issues with this release in GitHub
-inst=
ead: https://github=2Ecom/OpenVPN/openvpn/issues
-
-New features
----------=
---
-Support unlimited number of connection entries and remote entries
-
-N=
ew management commands to enumerate and list remote entries
-    Use ``remo=
te-entry-count`` and ``remote-entry-get``
-    commands from the management=
 interface to get the number of
-    remote entries and the entries themsel=
ves=2E
-
-Keying Material Exporters (RFC 5705) based key generation
-    As=
 part of the cipher negotiation OpenVPN will automatically prefer
-    the =
RFC5705 based key material generation to the current custom
-    OpenVPN PR=
F=2E This feature requires OpenSSL or mbed TLS 2=2E18+=2E
-
-Compatibility =
with OpenSSL in FIPS mode
-    OpenVPN will now work with OpenSSL in FIPS m=
ode=2E Note, no effort
-    has been made to check or implement all the
-  =
  requirements/recommendation of FIPS 140-2=2E This just allows OpenVPN
-  =
  to be run on a system that be configured OpenSSL in FIPS mode=2E
-
-``mlo=
ck`` will now check if enough memlock-able memory has been reserved,
-    a=
nd if less than 100MB RAM are available, use setrlimit() to upgrade
-    th=
e limit=2E  See Trac #1390=2E  Not available on OpenSolaris=2E
-
-Certifica=
te pinning/verify peer fingerprint
-    The ``--peer-fingerprint`` option h=
as been introduced to give users an
-    easy to use alternative to the ``t=
ls-verify`` for matching the
-    fingerprint of the peer=2E The option tak=
es use a number of allowed
-    SHA256 certificate fingerprints=2E
-
-    S=
ee the man page section "Small OpenVPN setup with peer-fingerprint"
-    fo=
r a tutorial on how to use this feature=2E This is also available online
- =
   under https://github=2Ecom/openvpn/openvpn/blob/master/doc/man-sections/=
example-fingerprint=2Erst
-
-TLS mode with self-signed certificates
-    Wh=
en ``--peer-fingerprint`` is used, the ``--ca`` and ``--capath`` option
-  =
  become optional=2E This allows for small OpenVPN setups without setting u=
p
-    a PKI with Easy-RSA or similar software=2E
-
-Deferred auth support =
for scripts
-    The ``--auth-user-pass-verify`` script supports now deferr=
ed authentication=2E
-
-Pending auth support for plugins and scripts
-    B=
oth auth plugin and script can now signal pending authentication to
-    th=
e client when using deferred authentication=2E The new ``client-crresponse`=
`
-    script option and ``OPENVPN_PLUGIN_CLIENT_CRRESPONSE`` plugin functi=
on can
-    be used to parse a client response to a ``CR_TEXT`` two factor =
challenge=2E
-
-    See ``sample/sample-scripts/totpauth=2Epy`` for an exam=
ple=2E
-
-Compatibility mode (``--compat-mode``)
-    The modernisation of =
defaults can impact the compatibility of OpenVPN 2=2E6=2E0
-    with older =
peers=2E The options ``--compat-mode`` allows UIs to provide users
-    wit=
h an easy way to still connect to older servers=2E
-
-OpenSSL 3=2E0 support=

-    OpenSSL 3=2E0 has been added=2E Most of OpenSSL 3=2E0 changes are not=
 user visible but
-    improve general compatibility with OpenSSL 3=2E0=2E =
``--tls-cert-profile insecure``
-    has been added to allow selecting the =
lowest OpenSSL security level (not
-    recommended, use only if you must)=
=2E OpenSSL 3=2E0 no longer supports the Blowfish
-    (and other deprecate=
d) algorithm by default and the new option ``--providers``
-    allows load=
ing the legacy provider to renable these algorithms=2E
-
-Optional ciphers =
in ``--data-ciphers``
-    Ciphers in ``--data-ciphers`` can now be prefixe=
d with a ``?`` to mark
-    those as optional and only use them if the SSL =
library supports them=2E
-
-
-Improved ``--mssfix`` and ``--fragment`` calc=
ulation
-    The ``--mssfix`` and ``--fragment`` options now allow an optio=
nal :code:`mtu`
-    parameter to specify that different overhead for IPv4/=
IPv6 should taken into
-    account and the resulting size is specified as =
the total size of the VPN packets
-    including IP and UDP headers=2E
-
-C=
ookie based handshake for UDP server
-    Instead of allocating a connectio=
n for each client on the initial packet
-    OpenVPN server will now use an=
 HMAC based cookie as its session id=2E This
-    way the server can verify=
 it on completing the handshake without keeping
-    state=2E This eliminat=
es the amplification and resource exhaustion attacks=2E
-    For tls-crypt-=
v2 clients, this requires OpenVPN 2=2E6 clients or later
-    because the c=
lient needs to resend its client key on completing the hand
-    shake=2E T=
he tls-crypt-v2 option allows controlling if older clients are
-    accepte=
d=2E
-
-    By default the rate of initial packet responses is limited to 1=
00 per 10s
-    interval to avoid OpenVPN servers being abused in reflectio=
n attacks
-    (see ``--connect-freq-initial``)=2E
-
-Data channel offloadi=
ng with ovpn-dco
-    2=2E6=2E0+ implements support for data-channel offloa=
ding where the data packets
-    are directly processed and forwarded in ke=
rnel space thanks to the ovpn-dco
-    kernel module=2E The userspace openv=
pn program acts purely as a control plane
-    application=2E Note that DCO=
 will use DATA_V2 packets in P2P mode, therefore,
-    this implies that pe=
ers must be running 2=2E6=2E0+ in order to have P2P-NCP
-    which brings D=
ATA_V2 packet support=2E
-
-Session timeout
-    It is now possible to term=
inate a session (or all) after a specified amount
-    of seconds has passe=
d session commencement=2E This behaviour can be configured
-    using ``--s=
ession-timeout``=2E This option can be configured on the server, on
-    th=
e client or can also be pushed=2E
-
-Inline auth username and password
-   =
 Username and password can now be specified inline in the configuration fil=
e
-    within the <auth-user-pass></auth-user-pass> tags=2E If the password=
 is
-    missing OpenVPN will prompt for input via stdin=2E This applies to=
 inline'd
-    http-proxy-user-pass too=2E
-
-Tun MTU can be pushed
-    Th=
e  client can now also dynamically configure its MTU and the server
-    wi=
ll try to push the client MTU when the client supports it=2E The
-    direc=
tive ``--tun-mtu-max`` has been introduced to increase the maximum
-    pus=
hable MTU size (defaults to 1600)=2E
-
-Dynamic TLS Crypt
-    When both pe=
ers are OpenVPN 2=2E6=2E1+, OpenVPN will dynamically create
-    a tls-cryp=
t key that is used for renegotiation=2E This ensure that only the
-    prev=
iously authenticated peer can do trigger renegotiation and complete
-    re=
negotiations=2E
-
-Improved control channel packet size control (``max-pack=
et-size``)
-    The size of control channel is no longer tied to
-    ``--l=
ink-mtu``/``--tun-mtu`` and can be set using ``--max-packet-size``=2E
-    =
Sending large control channel frames is also optimised by allowing 6
-    o=
utstanding packets instead of just 4=2E ``max-packet-size`` will also set
-=
    ``mssfix`` to try to limit data-channel packets as well=2E
-
-Deprecate=
d features
--------------------
-``inetd`` has been removed
-    This was a=
 very limited and not-well-tested way to run OpenVPN, on TCP
-    and TAP m=
ode only=2E
-
-``verify-hash`` has been deprecated
-    This option has ver=
y limited usefulness and should be replaced by either
-    a better ``--ca`=
` configuration or with a ``--tls-verify`` script=2E
-
-``secret`` has been=
 deprecated
-    static key mode (non-TLS) is no longer considered "good an=
d secure enough"
-    for today's requirements=2E  Use TLS mode instead=2E =
 If deploying a PKI CA
-    is considered "too complicated", using ``--peer=
-fingerprint`` makes
-    TLS mode about as easy as using ``--secret``=2E
-=

-``ncp-disable`` has been removed
-    This option mainly served a role as=
 debug option when NCP was first
-    introduced=2E It should now no longer=
 be necessary=2E
-
-TLS 1=2E0 and 1=2E1 are deprecated
-    ``tls-version-m=
in`` is set to 1=2E2 by default=2E  OpenVPN 2=2E6=2E0 defaults
-    to a mi=
nimum TLS version of 1=2E2 as TLS 1=2E0 and 1=2E1 should be generally
-    =
avoided=2E Note that OpenVPN versions older than 2=2E3=2E7 use TLS 1=2E0 on=
ly=2E
-
-``--cipher`` argument is no longer appended to ``--data-ciphers``
=
-    by default=2E Data cipher negotiation has been introduced in 2=2E4=2E0=

-    and been significantly improved in 2=2E5=2E0=2E The implicit fallback=

-    to the cipher specified in ``--cipher`` has been removed=2E
-    Effe=
ctively, ``--cipher`` is a no-op in TLS mode now, and will
-    only have a=
n effect in pre-shared-key mode (``--secret``)=2E
-    From now on ``--ciph=
er`` should not be used in new configurations
-    for TLS mode=2E
-    Sho=
uld backwards compatibility with older OpenVPN peers be
-    required, plea=
se see the ``--compat-mode`` instead=2E
-
-``--prng`` has beeen removed
-  =
  OpenVPN used to implement its own PRNG based on a hash=2E However impleme=
nting
-    a PRNG is better left to a crypto library=2E So we use the PRNG
=
-    mbed TLS or OpenSSL now=2E
-
-``--keysize`` has been removed
-    The =
``--keysize`` option was only useful to change the key length when using th=
e
-    BF, CAST6 or RC2 ciphers=2E For all other ciphers the key size is fi=
xed with the
-    chosen cipher=2E As OpenVPN v2=2E6 no longer supports any=
 of these variable length
-    ciphers, this option was removed as well to =
avoid confusion=2E
-
-Compression no longer enabled by default
-    Unless =
an explicit compression option is specified in the configuration,
-    ``--=
allow-compression`` defaults to ``no`` in OpeNVPN 2=2E6=2E0=2E
-    By defa=
ult, OpenVPN 2=2E5 still allowed a server to enable compression by
-    pus=
hing compression related options=2E
-
-PF (Packet Filtering) support has be=
en removed
-   The built-in PF functionality has been removed from the code=
 base=2E This
-   feature wasn't really easy to use and was long unmaintain=
ed=2E
-   This implies that also ``--management-client-pf`` and any other c=
ompile
-   time or run time related option do not exist any longer=2E
-
-Op=
tion conflict checking is being deprecated and phased out
-    The static o=
ption checking (OCC) is no longer useful in typical setups
-    that negoti=
ate most connection parameters=2E The ``--opt-verify`` and
-    ``--occ-dis=
able`` options are deprecated, and the configure option
-    ``--enable-str=
ict-options`` has been removed=2E Logging of mismatched
-    options has be=
en moved to debug logging (verb 7)=2E
-
-User-visible Changes
-------------=
--------
-- CHACHA20-POLY1305 is included in the default of ``--data-cipher=
s`` when available=2E
-- Option ``--prng`` is ignored as we rely on the SSL=
 library random number generator=2E
-- Option ``--nobind`` is default when =
``--client`` or ``--pull`` is used in the configuration
-- :code:`link_mtu`=
 parameter is removed from environment or replaced with 0 when scripts are
=
-  called with parameters=2E This parameter is unreliable and no longer int=
ernally calculated=2E
-
-- control channel packet maximum size is no longer=
 influenced by
-  ``--link-mtu``/``--tun-mtu`` and must be set by ``--max-p=
acket-size`` now=2E
-  The default is 1250 for the control channel size=2E
=
-
-- In point-to-point OpenVPN setups (no ``--server``), using
-  ``--expli=
ct-exit-notiy`` on one end would terminate the other side at
-  session end=
=2E  This is considered a no longer useful default and has
-  been changed =
to "restart on reception of explicit-exit-notify message"=2E
-  If the old =
behaviour is still desired, ``--remap-usr1 SIGTERM`` can be used=2E
-
-- Fr=
eeBSD tun interfaces with ``--topology subnet`` are now put into real
-  su=
bnet mode (IFF_BROADCAST instead of IFF_POINTOPOINT) - this might upset
-  =
software that enumerates interfaces, looking for "broadcast capable?" and
-=
  expecting certain results=2E  Normal uses should not see any difference=
=2E
-
-- The default configurations will no longer allow connections to Ope=
nVPN 2=2E3=2Ex
-  peer or earlier, use the new ``--compat-mode`` option if =
you need
-  compatibility with older versions=2E See the manual page on the=

-  ``--compat-mode`` for details=2E
-
-- The ``client-pending-auth`` manag=
ement command now requires also the
-  key id=2E The management version has=
 been changed to 5 to indicate this change=2E
-
-- (OpenVPN 2=2E6=2E2) A cl=
ient will now refuse a connection if pushed compression
-  settings will co=
ntradict the setting of allow-compression as this almost
-  always results =
in a non-working connection=2E
-
-- The "kill" by addr management command n=
ow requires also the protocol
-  as string e=2Eg=2E "udp", "tcp"=2E
-
-Comm=
on errors with OpenSSL 3=2E0 and OpenVPN 2=2E6
----------------------------=
-------------------
-Both OpenVPN 2=2E6 and OpenSSL 3=2E0 tighten the secur=
ity considerable, so some
-configuration will no longer work=2E This sectio=
n will cover the most common
-causes and error message we have seen and exp=
lain their reason and temporary
-workarounds=2E You should fix the underlyi=
ng problems as soon as possible since
-these workaround are not secure and =
will eventually stop working in a future
-update=2E
-
-- weak SHA1 or MD5 s=
ignature on certificates
-
-  This will happen on either loading of certifi=
cates or on connection
-  to a server::
-
-      OpenSSL: error:0A00018E:SS=
L routines::ca md too weak
-      Cannot load certificate file cert=2Ecrt
-=
      Exiting due to fatal error
-
-  OpenSSL 3=2E0 no longer allows weak s=
ignatures on certificates=2E You can
-  downgrade your security to allow th=
em by using ``--tls-cert-profile insecure``
-  but should replace/regenerat=
e these certificates as soon as possible=2E
-
-
-- 1024 bit RSA certificate=
s, 1024 bit DH parameters, other weak keys
-
-  This happens if you use pri=
vate keys or other cryptographic material that
-  does not meet today's cry=
ptographic standards anymore=2E Messages are similar
-  to::
-
-      OpenS=
SL: error:0A00018F:SSL routines::ee key too small
-      OpenSSL: error:140=
8518A:SSL routines:ssl3_ctx_ctrl:dh key too small
-
-  DH parameters (``--d=
h``) can be regenerated with ``openssl dhparam 2048``=2E
-  For other crypt=
ographic keys, these keys and certificates need to be
-  regenerated=2E TLS=
 Security level can be temporarily lowered with
-  ``--tls-cert-profile leg=
acy`` or even ``--tls-cert-profile insecure``=2E
-
-- Connecting to a OpenV=
PN 2=2E3=2Ex server or allowing OpenVPN 2=2E3=2Ex or earlier
-  clients
-
-=
  This will normally result in messages like::
-
-     OPTIONS ERROR: faile=
d to negotiate cipher with server=2E  Add the server's cipher ('AES-128-CBC=
') to --data-ciphers (currently 'AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305'=
) if you want to connect to this server=2E
-
-     or
-
-     client/127=2E=
0=2E0=2E1:49954 SENT CONTROL [client]: 'AUTH_FAILED,Data channel cipher neg=
otiation failed (no shared cipher)' (status=3D1)
-
-  You can manually add =
the missing cipher to the ``--data-ciphers``=2E The
-  standard ciphers sho=
uld be included as well, e=2Eg=2E
-  ``--data-ciphers AES-256-GCM:AES-128-G=
CM:?Chacha20-Poly1305:?AES-128-CBC``=2E
-  You can also use the ``--compat-=
mode`` option=2E Note that these message may
-  also indicate other cipher =
configuration problems=2E See the data channel
-  cipher negotiation manual=
 section for more details=2E (Available online under
-  https://github=2Eco=
m/OpenVPN/openvpn/blob/master/doc/man-sections/cipher-negotiation=2Erst)
-
=
-- Use of a legacy or deprecated cipher (e=2Eg=2E 64bit block ciphers)
-
- =
 OpenSSL 3=2E0 no longer supports a number of insecure and outdated ciphers=
 in
-  its default configuration=2E Some of these ciphers are known to be v=
ulnerable (SWEET32 attack)=2E
-
-  This will typically manifest itself in m=
essages like::
-
-      OpenSSL: error:0308010C:digital envelope routines::=
unsupported
-      Cipher algorithm 'BF-CBC' not found
-      Unsupported c=
ipher in --data-ciphers: BF-CBC
-
-  If your OpenSSL distribution comes wit=
h the legacy provider (see
-  also ``man OSSL_PROVIDER-legacy``), you can l=
oad it with
-  ``--providers legacy default``=2E  This will re-enable the o=
ld algorithms=2E
-
-- OpenVPN version not supporting TLS 1=2E2 or later
-
-=
  The default in OpenVPN 2=2E6 and also in many distributions is now TLS 1=
=2E2 or
-  later=2E Connecting to a peer that does not support this will re=
sults in
-  messages like::
-
-    TLS error: Unsupported protocol=2E This =
typically indicates that client and
-    server have no common TLS version =
enabled=2E This can be caused by mismatched
-    tls-version-min and tls-ve=
rsion-max options on client and server=2E If your
-    OpenVPN client is be=
tween v2=2E3=2E6 and v2=2E3=2E2 try adding tls-version-min 1=2E0
-    to th=
e client configuration to use TLS 1=2E0+ instead of TLS 1=2E0 only
-    Ope=
nSSL: error:0A000102:SSL routines::unsupported protocol
-
-  This can be an=
 OpenVPN 2=2E3=2E6 or earlier version=2E ``compat-version 2=2E3=2E0`` will
=
-  enable TLS 1=2E0 support if supported by the OpenSSL distribution=2E Not=
e that
-  on some Linux distributions enabling TLS 1=2E1 or 1=2E0 is not po=
ssible=2E
-
-
-
-Overview of changes in 2=2E5
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-New features
-------=
------
-Client-specific tls-crypt keys (``--tls-crypt-v2``)
-    ``tls-cryp=
t-v2`` adds the ability to supply each client with a unique
-    tls-crypt =
key=2E  This allows large organisations and VPN providers to profit
-    fr=
om the same DoS and TLS stack protection that small deployments can
-    al=
ready achieve using ``tls-auth`` or ``tls-crypt``=2E
-
-ChaCha20-Poly1305 c=
ipher support
-    Added support for using the ChaCha20-Poly1305 cipher in =
the OpenVPN data
-    channel=2E
-
-Improved Data channel cipher negotiatio=
n
-    The option ``ncp-ciphers`` has been renamed to ``data-ciphers``=2E
-=
    The old name is still accepted=2E The change in name signals that
-    =
``data-ciphers`` is the preferred way to configure data channel
-    cipher=
s and the data prefix is chosen to avoid the ambiguity that
-    exists wit=
h ``--cipher`` for the data cipher and ``tls-cipher``
-    for the TLS ciph=
ers=2E
-
-    OpenVPN clients will now signal all supported ciphers from th=
e
-    ``data-ciphers`` option to the server via ``IV_CIPHERS``=2E OpenVPN
=
-    servers will select the first common cipher from the ``data-ciphers``
=
-    list instead of blindly pushing the first cipher of the list=2E This
-=
    allows to use a configuration like
-    ``data-ciphers ChaCha20-Poly130=
5:AES-256-GCM`` on the server that
-    prefers ChaCha20-Poly1305 but uses =
it only if the client supports it=2E
-
-    See the data channel negotiatio=
n section in the manual for more details=2E
-
-Removal of BF-CBC support in=
 default configuration:
-    By default OpenVPN 2=2E5 will only accept AES-=
256-GCM and AES-128-GCM as
-    data ciphers=2E OpenVPN 2=2E4 allows AES-25=
6-GCM,AES-128-GCM and BF-CBC when
-    no --cipher and --ncp-ciphers option=
s are present=2E Accepting BF-CBC can be
-    enabled by adding
-
-        =
data-ciphers AES-256-GCM:AES-128-GCM:BF-CBC
-
-    and when you need to sup=
port very old peers also
-
-        data-ciphers-fallback BF-CBC
-
-    To =
offer backwards compatibility with older configs an *explicit*
-
-        c=
ipher BF-CBC
-
-    in the configuration will be automatically translated i=
nto adding BF-CBC
-    to the data-ciphers option and setting data-ciphers-=
fallback to BF-CBC
-    (as in the example commands above)=2E We strongly r=
ecommend to switching
-    away from BF-CBC to a more secure cipher=2E
-
-A=
synchronous (deferred) authentication support for auth-pam plugin=2E
-    S=
ee src/plugins/auth-pam/README=2Eauth-pam for details=2E
-
-Deferred client=
-connect
-    The ``--client-connect`` option and the connect plugin API al=
low
-    asynchronous/deferred return of the configuration file in the same=
 way
-    as the auth-plugin=2E
-
-Faster connection setup
-    A client wi=
ll signal in the ``IV_PROTO`` variable that it is in pull
-    mode=2E This=
 allows the server to push the configuration options to
-    the client wit=
hout waiting for a ``PULL_REQUEST`` message=2E The feature
-    is automati=
cally enabled if both client and server support it and
-    significantly r=
educes the connection setup time by avoiding one
-    extra packet round-tr=
ip and 1s of internal event delays=2E
-
-Netlink support
-    On Linux, if =
configured without ``--enable-iproute2``, configuring IP
-    addresses and=
 adding/removing routes is now done via the netlink(3)
-    kernel interfac=
e=2E  This is much faster than calling ``ifconfig`` or
-    ``route`` and a=
lso enables OpenVPN to run with less privileges=2E
-
-    If configured wit=
h --enable-iproute2, the ``ip`` command is used
-    (as in 2=2E4)=2E  Supp=
ort for ``ifconfig`` and ``route`` is gone=2E
-
-Wintun support
-    On Win=
dows, OpenVPN can now use ``wintun`` devices=2E  They are faster
-    than =
the traditional ``tap9`` tun/tap devices, but do not provide
-    ``--dev t=
ap`` mode - so the official installers contain both=2E  To use
-    a wintu=
n device, add ``--windows-driver wintun`` to your config
-    (and use of t=
he interactive service is required as wintun needs
-    SYSTEM privileges t=
o enable access)=2E
-
-IPv6-only operation
-    It is now possible to have =
only IPv6 addresses inside the VPN tunnel,
-    and IPv6-only address pools=
 (2=2E4 always required IPv4 config/pools
-    and IPv6 was the "optional e=
xtra")=2E
-
-Improved Windows 10 detection
-    Correctly log OS on Windows=
 10 now=2E
-
-Linux VRF support
-    Using the new ``--bind-dev`` option, t=
he OpenVPN outside socket can
-    now be put into a Linux VRF=2E  See the =
"Virtual Routing and Forwarding"
-    documentation in the man page=2E
-
-T=
LS 1=2E3 support
-    TLS 1=2E3 support has been added to OpenVPN=2E  Curre=
ntly, this requires
-    OpenSSL 1=2E1=2E1+=2E
-    The options ``--tls-cip=
hersuites`` and ``--tls-groups`` have been
-    added to fine tune TLS prot=
ocol options=2E  Most of the improvements
-    were also backported to Open=
VPN 2=2E4 as part of the maintainance
-    releases=2E
-
-Support setting D=
HCP search domain
-    A new option ``--dhcp-option DOMAIN-SEARCH my=2Eexam=
ple=2Ecom`` has been
-    defined, and Windows support for it is implemente=
d (tun/tap only, no
-    wintun support yet)=2E  Other platforms need to su=
pport this via ``--up``
-    script (Linux) or GUI (OSX/Tunnelblick)=2E
-
-=
per-client changing of ``--data-ciphers`` or ``data-ciphers-fallback``
-   =
 from client-connect script/dir (NOTE: this only changes preference of
-   =
 ciphers for NCP, but can not override what the client announces as
-    "w=
illing to accept")
-
-Handle setting of tun/tap interface MTU on Windows
- =
   If IPv6 is in use, MTU must be >=3D 1280 (Windows enforces IETF requirem=
ents)
-
-Add support for OpenSSL engines to access private key material (li=
ke TPM)=2E
-
-HMAC based auth-token support
-    The ``--auth-gen-token`` s=
upport has been improved and now generates HMAC
-    based user token=2E If=
 the optional ``--auth-gen-token-secret`` option is
-    used clients will =
be able to seamlessly reconnect to a different server
-    using the same s=
ecret file or to the same server after a server restart=2E
-
-Improved supp=
ort for pending authentication
-    The protocol has been enhanced to be ab=
le to signal that
-    the authentication should use a secondary authentica=
tion
-    via web (like SAML) or a two factor authentication without
-    d=
isconnecting the OpenVPN session with AUTH_FAILED=2E The
-    session will =
instead be stay in a authenticated state and
-    wait for the second facto=
r authentication to complete=2E
-
-    This feature currently requires usag=
e of the managent interface
-    on both client and server side=2E See the =
``management-notes=2Etxt``
-    ``client-pending-auth`` and ``cr-response``=
 commands for more
-    details=2E
-
-VLAN support
-    OpenVPN servers in =
TAP mode can now use 802=2E1q tagged VLANs
-    on the TAP interface to sep=
arate clients into different groups
-    that can then be handled different=
ly (different subnets / DHCP,
-    firewall zones, =2E=2E=2E) further down =
the network=2E  See the new
-    options ``--vlan-tagging``, ``--vlan-accep=
t``, ``--vlan-pvid``=2E
-
-    802=2E1q tagging on the client side TAP inte=
rface is not handled
-    today (=3D tags are just forwarded transparently =
to the server)=2E
-
-Support building of =2Emsi installers for Windows
-
-A=
llow unicode search string in ``--cryptoapicert`` option (Windows)
-
-Suppo=
rt IPv4 configs with /31 netmasks now
-    (By no longer trying to configur=
e ``broadcast x=2Ex=2Ex=2Ex`` in
-    ifconfig calls, /31 support "just wor=
ks")
-
-New option ``--block-ipv6`` to reject all IPv6 packets (ICMPv6)
-  =
  this is useful if the VPN service has no IPv6, but the clients
-    might=
 have (LAN), to avoid client connections to IPv6-enabled
-    servers leaki=
ng "around" the IPv4-only VPN=2E
-
-``--ifconfig-ipv6`` and ``--ifconfig-ip=
v6-push`` will now accept
-    hostnames and do a DNS lookup to get the IPv=
6 address to use
-
-
-Deprecated features
--------------------
-For an up-t=
o-date list of all deprecated options, see this wiki page:
-https://communi=
ty=2Eopenvpn=2Enet/openvpn/wiki/DeprecatedOptions
-
-- ``ncp-disable`` has =
been deprecated
-    With the improved and matured data channel cipher nego=
tiation, the use
-    of ``ncp-disable`` should not be necessary anymore=2E=

-
-- ``inetd`` has been deprecated
-  This is a very limited and not-well-=
tested way to run OpenVPN, on TCP
-  and TAP mode only, which complicates t=
he code quite a bit for little gain=2E
-  To be removed in OpenVPN 2=2E6 (u=
nless users protest)=2E
-
-- ``no-iv`` has been removed
-  This option was =
made into a NOOP option with OpenVPN 2=2E4=2E  This has now
-  been complet=
ely removed=2E
-
-- ``--client-cert-not-required`` has been removed
-  This=
 option will now cause server configurations to not start=2E  Use
-  ``--ve=
rify-client-cert none`` instead=2E
-
-- ``--ifconfig-pool-linear`` has been=
 removed
-  This option is removed=2E  Use ``--topology p2p`` or ``--topolo=
gy subnet``
-  instead=2E
-
-- ``--compress xxx`` is considered risky and i=
s warned against, see below=2E
-
-- ``--key-method 1`` has been removed
-
-=

-User-visible Changes
---------------------
-- If multiple connect handler=
s are used (client-connect, ccd, connect
-  plugin) and one of the handler =
succeeds but a subsequent fails, the
-  client-disconnect-script is now cal=
led immediately=2E Previously it
-  was called, when the VPN session was te=
rminated=2E
-
-- Support for building with OpenSSL 1=2E0=2E1 has been remov=
ed=2E The minimum
-  supported OpenSSL version is now 1=2E0=2E2=2E
-
-- The=
 GET_CONFIG management state is omitted if the server pushes
-  the client =
configuration almost immediately as result of the
-  faster connection setu=
p feature=2E
-
-- ``--compress`` is nowadays considered risky, because atta=
cks exist
-  leveraging compression-inside-crypto to reveal plaintext (VORA=
CLE)=2E  So
-  by default, ``--compress xxx`` will now accept incoming comp=
ressed
-  packets (for compatibility with peers that have not been upgraded=
 yet),
-  but will not use compression outgoing packets=2E  This can be con=
trolled with
-  the new option ``--allow-compression yes|no|asym``=2E
-
-- =
Stop changing ``--txlen`` aways from OS defaults unless explicitly specifie=
d
-  in config file=2E  OS defaults nowadays are actually larger then what =
we used
-  to configure, so our defaults sometimes caused packet drops =3D =
bad performance=2E
-
-- remove ``--writepid`` pid file on exit now
-
-- plu=
gin-auth-pam now logs via OpenVPN logging method, no longer to stderr
-  (t=
his means you'll have log messages in syslog or openvpn log file now)
-
-- =
use ISO 8601 time format for file based logging now (YYYY-MM-DD hh:mm:dd)
-=
  (syslog is not affected, nor is ``--machine-readable-output``)
-
-- ``--c=
lr-verify`` now loads all CRLs if more than one CRL is in the same
-  file =
(OpenSSL backend only, mbedTLS always did that)
-
-- when ``--auth-user-pas=
s file`` has no password, and the management interface
-  is active, query =
management interface (instead of trying console query,
-  which does not wo=
rk on windows)
-
-- skip expired certificates in Windows certificate store =
(``--cryptoapicert``)
-
-- ``--socks-proxy`` + ``--proto udp*`` will now al=
lways use IPv4, even if
-  IPv6 is requested and available=2E  Our SOCKS co=
de does not handle IPv6+UDP,
-  and before that change it would just fail i=
n non-obvious ways=2E
-
-- TCP listen() backlog queue is now set to 32 - th=
is helps TCP servers that
-  receive lots of "invalid" connects by TCP port=
 scanners
-
-- do no longer print OCC warnings ("option mismatch") about ``=
key-method``,
-  ``keydir``, ``tls-auth`` and ``cipher`` - these are either=
 gone now, or
-  negotiated, and the warnings do not serve a useful purpose=
=2E
-
-- ``dhcp-option DNS`` and ``dhcp-option DNS6`` are now treated ident=
ically
-  (=3D both accept an IPv4 or IPv6 address for the nameserver)
-
-
=
-Maintainer-visible changes
---------------------------
-- the man page is =
now in maintained in =2Erst format, so building the openvpn=2E8
-  manpage =
from a git checkout now requires python-docutils (if this is missing,
-  th=
e manpage will not be built - which is not considered an error generally,
-=
  but for package builders or ``make distcheck`` it is)=2E  Release tarball=
s
-  contain the openvpn=2E8 file, so unless some =2Erst is changed, doc-ut=
ils are
-  not needed for building=2E
-
-- OCC support can no longer be dis=
abled
-
-- AEAD support is now required in the crypto library
-
-- ``--disa=
ble-server`` has been removed from configure (so it is no longer
-  possibl=
e to build a client-/p2p-only OpenVPN binary) - the saving in code
-  size =
no longer outweighs the extra maintenance effort=2E
-
-- ``--enable-iproute=
2`` will disable netlink(3) support, so maybe remove
-  that from package b=
uilding configs (see above)
-
-- support building with MSVC 2019
-
-- cmock=
a based unit tests are now only run if cmocka is installed externally
-  (2=
=2E4 used to ship a local git submodule which was painful to maintain)
-
--=
 ``--disable-crypto`` configure option has been removed=2E  OpenVPN is now =
always
-  built with crypto support, which makes the code much easier to ma=
intain=2E
-  This does not affect ``--cipher none`` to do a tunnel without =
encryption=2E
-
-- ``--disable-multi`` configure option has been removed
-
=
-
-
-Overview of changes in 2=2E4
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-
-New features
-------------
-Se=
amless client IP/port floating
-    Added new packet format P_DATA_V2, whic=
h includes peer-id=2E If both the
-    server and client support it, the cl=
ient sends all data packets in
-    the new format=2E When a data packet ar=
rives, the server identifies peer
-    by peer-id=2E If peer's ip/port has =
changed, server assumes that
-    client has floated, verifies HMAC and upd=
ates ip/port in internal structs=2E
-    This allows the connection to be i=
mmediately restored, instead of requiring
-    a TLS handshake before the s=
erver accepts packets from the new client
-    ip/port=2E
-
-Data channel c=
ipher negotiation
-    Data channel ciphers (``--cipher``) are now by defau=
lt negotiated=2E  If a
-    client advertises support for Negotiable Crypto=
 Parameters (NCP), the
-    server will choose a cipher (by default AES-256=
-GCM) for the data channel,
-    and tell the client to use that cipher=2E =
 Data channel cipher negotiation
-    can be controlled using ``--ncp-ciphe=
rs`` and ``--ncp-disable``=2E
-
-    A more limited version also works in c=
lient-to-server and server-to-client
-    scenarios where one of the end po=
ints uses a v2=2E4 client or server and the
-    other side uses an older v=
ersion=2E  In such scenarios the v2=2E4 side will
-    change to the ``--ci=
pher`` set by the remote side, if permitted by by
-    ``--ncp-ciphers``=2E=
  For example, a v2=2E4 client with ``--cipher BF-CBC``
-    and ``ncp-ciph=
ers AES-256-GCM:AES-256-CBC`` can connect to both a v2=2E3
-    server with=
 ``cipher BF-CBC`` as well as a server with
-    ``cipher AES-256-CBC`` in =
its config=2E  The other way around, a v2=2E3 client
-    with either ``cip=
her BF-CBC`` or ``cipher AES-256-CBC`` can connect to a
-    v2=2E4 server =
with e=2Eg=2E ``cipher BF-CBC`` and
-    ``ncp-ciphers AES-256-GCM:AES-256-=
CBC`` in its config=2E  For this to work
-    it requires that OpenVPN was =
built without disabling OCC support=2E
-
-AEAD (GCM) data channel cipher su=
pport
-    The data channel now supports AEAD ciphers (currently only GCM)=
=2E  The AEAD
-    packet format has a smaller crypto overhead than the CBC=
 packet format,
-    (e=2Eg=2E 20 bytes per packet for AES-128-GCM instead =
of 36 bytes per packet
-    for AES-128-CBC + HMAC-SHA1)=2E
-
-ECDH key exc=
hange
-    The TLS control channel now supports for elliptic curve diffie-h=
ellmann
-    key exchange (ECDH)=2E
-
-Improved Certificate Revocation List=
 (CRL) processing
-    CRLs are now handled by the crypto library (OpenSSL =
or mbed TLS), instead
-    of inside OpenVPN itself=2E  The crypto library =
implementations are more
-    strict than the OpenVPN implementation was=2E=
  This might reject peer
-    certificates that would previously be accepte=
d=2E  If this occurs, OpenVPN
-    will log the crypto library's error desc=
ription=2E
-
-Dualstack round-robin DNS client connect
-    Instead of only=
 using the first address of each ``--remote`` OpenVPN
-    will now try all=
 addresses (IPv6 and IPv4) of a ``--remote`` entry=2E
-
-Support for provid=
ing IPv6 DNS servers
-    A new DHCP sub-option ``DNS6`` is added alongside=
 with the already existing
-    ``DNS`` sub-option=2E  This is used to prov=
ide DNS resolvers available over
-    IPv6=2E  This may be pushed to client=
s where `` --up`` scripts and ``--plugin``
-    can act upon it through the=
 ``foreign_option_<n>`` environment variables=2E
-
-    Support for the Win=
dows client picking up this new sub-option is added,
-    however IPv6 DNS =
resolvers need to be configured via ``netsh`` which requires
-    administr=
ator privileges unless the new interactive services on Windows is
-    bein=
g used=2E  If the interactive service is used, this service will execute
- =
   ``netsh`` in the background with the proper privileges=2E
-
-New improve=
d Windows Background service
-    The new OpenVPNService is based on openvp=
nserv2, a complete rewrite of the OpenVPN
-    service wrapper=2E It is int=
ended for launching OpenVPN instances that should be
-    up at all times, =
instead of being manually launched by a user=2E OpenVPNService is
-    able=
 to restart individual OpenVPN processes if they crash, and it also works
-=
    properly on recent Windows versions=2E OpenVPNServiceLegacy tends to wo=
rk poorly,
-    if at all, on newer Windows versions (8+) and its use is no=
t recommended=2E
-
-New interactive Windows service
-    The installer star=
ts OpenVPNServiceInteractive automatically and configures
-    it to start	=
at system startup=2E
-
-    The interactive Windows service allows unprivil=
eged users to start
-    OpenVPN connections in the global config directory=
 (usually
-    C:\\Program Files\\OpenVPN\\config) using OpenVPN GUI withou=
t any
-    extra configuration=2E
-
-    Users who belong to the built-in A=
dministrator group or to the
-    local "OpenVPN Administrator" group can a=
lso store configuration
-    files under %USERPROFILE%\\OpenVPN\\config for=
 use with the
-    interactive service=2E
-
-redirect-gateway ipv6
-    Ope=
nVPN has now feature parity between IPv4 and IPv6 for redirect
-    gateway=
 including the handling of overlapping IPv6 routes with
-    IPv6 remote VP=
N server address=2E
-
-LZ4 Compression and pushable compression
-    Additi=
onally to LZO compression OpenVPN now also supports LZ4 compression=2E
-   =
 Compression options are now pushable from the server=2E
-
-Filter pulled o=
ptions client-side: pull-filter
-    New option to explicitly allow or reje=
ct options pushed by the server=2E
-    May be used multiple times and is a=
pplied in the order specified=2E
-
-Per-client remove push options: push-re=
move
-    New option to remove options on a per-client basis from the "push=
" list
-    (more fine-grained than ``--push-reset``)=2E
-
-Http proxy pass=
word inside config file
-    Http proxy passwords can be specified with the=
 inline file option
-    ``<http-proxy-user-pass>`` =2E=2E ``</http-proxy-u=
ser-pass>``
-
-Windows version detection
-    Windows version is detected, =
logged and possibly signalled to server
-    (IV_PLAT_VER=3D<nn> if ``--pus=
h-peer-info`` is set on client)=2E
-
-Authentication tokens
-    In situati=
ons where it is not suitable to save user passwords on the client,
-    Ope=
nVPN has support for pushing a --auth-token since v2=2E3=2E  This option is=

-    pushed from the server to the client with a token value to be used in=
stead
-    of the users password=2E  For this to work, the authentication p=
lug-in would
-    need to implement this support as well=2E  In OpenVPN 2=
=2E4 --auth-gen-token
-    is introduced, which will allow the OpenVPN serv=
er to generate a random
-    token and push it to the client without any ch=
anges to the authentication
-    modules=2E  When the clients need to re-au=
thenticate the OpenVPN server will
-    do the authentication internally, i=
nstead of sending the re-authentication
-    request to the authentication =
module =2E  This feature is especially
-    useful in configurations which =
use One Time Password (OTP) authentication
-    schemes, as this allows the=
 tunnel keys to be renegotiated regularly without
-    any need to supply n=
ew OTP codes=2E
-
-keying-material-exporter
-    Keying Material Exporter [=
RFC-5705] allow additional keying material to be
-    derived from existing=
 TLS channel=2E
-
-Android platform support
-    Support for running on And=
roid using Android's VPNService API has been added=2E
-    See doc/android=
=2Etxt for more details=2E This support is primarily used in
-    the OpenV=
PN for Android app (https://github=2Ecom/schwabe/ics-openvpn)
-
-AIX platfo=
rm support
-    AIX platform support has been added=2E The support only inc=
ludes tap
-    devices since AIX does not provide tun interface=2E
-
-Contr=
ol channel encryption (``--tls-crypt``)
-    Use a pre-shared static key (l=
ike the ``--tls-auth`` key) to encrypt control
-    channel packets=2E  Pro=
vides more privacy, some obfuscation and poor-man's
-    post-quantum secur=
ity=2E
-
-Asynchronous push reply
-    Plug-ins providing support for defer=
red authentication can benefit from a more
-    responsive authentication w=
here the server sends PUSH_REPLY immediately once
-    the authentication r=
esult is ready, instead of waiting for the client to
-    to send PUSH_REQU=
EST once more=2E  This requires OpenVPN to be built with
-    ``=2E/configu=
re --enable-async-push``=2E  This is a compile-time only switch=2E
-
-
-Dep=
recated features
--------------------
-For an up-to-date list of all deprec=
ated options, see this wiki page:
-https://community=2Eopenvpn=2Enet/openvp=
n/wiki/DeprecatedOptions
-
-- ``--key-method 1`` is deprecated in OpenVPN 2=
=2E4 and will be removed in v2=2E5=2E
-  Migrate away from ``--key-method 1=
`` as soon as possible=2E  The recommended
-  approach is to remove the ``-=
-key-method`` option from the configuration
-  files, OpenVPN will then use=
 ``--key-method 2`` by default=2E  Note that this
-  requires changing the =
option in both the client and server side configs=2E
-
-- ``--tls-remote`` =
is removed in OpenVPN 2=2E4, as indicated in the v2=2E3
-  man-pages=2E  Si=
milar functionality is provided via ``--verify-x509-name``,
-  which does t=
he same job in a better way=2E
-
-- ``--compat-names`` and ``--no-name-rema=
pping`` were deprecated in OpenVPN 2=2E3
-  and will be removed in v2=2E5=
=2E  All scripts and plug-ins depending on the old
-  non-standard X=2E509 =
subject formatting must be updated to the standardized
-  formatting=2E  Se=
e the man page for more information=2E
-
-- ``--no-iv`` is deprecated in Op=
enVPN 2=2E4 and will be removed in v2=2E5=2E
-
-- ``--keysize`` is deprecat=
ed in OpenVPN 2=2E4 and will be removed in v2=2E6
-  together with the supp=
ort of ciphers with cipher block size less than
-  128-bits=2E
-
-- ``--com=
p-lzo`` is deprecated in OpenVPN 2=2E4=2E  Use ``--compress`` instead=2E
-
=
-- ``--ifconfig-pool-linear`` has been deprecated since OpenVPN 2=2E1 and w=
ill be
-  removed in v2=2E5=2E  Use ``--topology p2p`` instead=2E
-
-- ``--=
client-cert-not-required`` is deprecated in OpenVPN 2=2E4 and will be remov=
ed
-  in v2=2E5=2E  Use ``--verify-client-cert none`` for a functional equi=
valent=2E
-
-- ``--ns-cert-type`` is deprecated in OpenVPN 2=2E3=2E18 and v=
2=2E4=2E  It will be removed
-  in v2=2E5=2E  Use the far better ``--remote=
-cert-tls`` option which replaces this
-  feature=2E
-
-
-User-visible Chan=
ges
---------------------
-- When using ciphers with cipher blocks less tha=
n 128-bits,
-  OpenVPN will complain loudly if the configuration uses ciphe=
rs considered
-  weak, such as the SWEET32 attack vector=2E  In such scenar=
ios, OpenVPN will by
-  default renegotiate for each 64MB of transported da=
ta (``--reneg-bytes``)=2E
-  This renegotiation can be disabled, but is HIG=
HLY DISCOURAGED=2E
-
-- For certificate DNs with duplicate fields, e=2Eg=2E=
 "OU=3Done,OU=3Dtwo", both fields
-  are now exported to the environment, w=
here each second and later occurrence
-  of a field get _$N appended to it'=
s field name, starting at N=3D1=2E  For the
-  example above, that would re=
sult in e=2Eg=2E X509_0_OU=3Done, X509_0_OU_1=3Dtwo=2E
-  Note that this br=
eaks setups that rely on the fact that OpenVPN would
-  previously (incorre=
ctly) only export the last occurrence of a field=2E
-
-- ``proto udp`` and =
``proto tcp`` now use both IPv4 and IPv6=2E The new
-  options ``proto udp4=
`` and ``proto tcp4`` use IPv4 only=2E
-
-- ``--sndbuf`` and ``--recvbuf`` =
default now to OS defaults instead of 64k
-
-- OpenVPN exits with an error =
if an option has extra parameters;
-  previously they were silently ignored=

-
-- ``--tls-auth`` always requires OpenVPN static key files and will no
-=
  longer work with free form files
-
-- ``--proto udp6/tcp6`` in server mod=
e will now try to always listen to
-  both IPv4 and IPv6 on platforms that =
allow it=2E Use ``--bind ipv6only``
-  to explicitly listen only on IPv6=2E=

-
-- Removed ``--enable-password-save`` from configure=2E This option is n=
ow
-  always enabled=2E
-
-- Stricter default TLS cipher list (override wit=
h ``--tls-cipher``), that now
-  also disables:
-
-  * Non-ephemeral key ex=
change using static (EC)DH keys
-  * DSS private keys
-
-- mbed TLS builds:=
 changed the tls_digest_N values exported to the script
-  environment to b=
e equal to the ones exported by OpenSSL builds, namely
-  the certificate f=
ingerprint (was the hash of the 'to be signed' data)=2E
-
-- mbed TLS build=
s: minimum RSA key size is now 2048 bits=2E  Shorter keys will
-  not be ac=
cepted, both local and from the peer=2E
-
-- ``--connect-timeout`` now spec=
ifies the timeout until the first TLS packet
-  is received (identical to `=
`--server-poll-timeout``) and this timeout now
-  includes the removed sock=
s proxy timeout and http proxy timeout=2E
-
-  In ``--static`` mode ``conne=
ct-timeout`` specifies the timeout for TCP and
-  proxy connection establis=
hment
-
-- ``--connect-retry-max`` now specifies the maximum number of unsu=
ccessful
-  attempts of each remote/connection entry before exiting=2E
-
--=
 ``--http-proxy-timeout`` and the static non-changeable socks timeout (5s)
=
-  have been folded into a "unified" ``--connect-timeout`` which covers all=

-  steps needed to connect to the server, up to the start of the TLS excha=
nge=2E
-  The default value has been raised to 120s, to handle slow http/so=
cks
-  proxies graciously=2E  The old "fail TCP fast" behaviour can be achi=
eved by
-  adding "``--connect-timeout 10``" to the client config=2E
-
-- `=
`--http-proxy-retry`` and ``--sock-proxy-retry`` have been removed=2E Proxy=
 connections
-  will now behave like regular connection entries and generat=
e a USR1 on failure=2E
-
-- ``--connect-retry`` gets an optional second arg=
ument that specifies the maximum
-  time in seconds to wait between reconne=
ction attempts when an exponential
-  backoff is triggered due to repeated =
retries=2E Default =3D 300 seconds=2E
-
-- Data channel cipher negotiation =
(see New features section) can override
-  ciphers configured in the config=
 file=2E  Use ``--ncp-disable`` if you do not want
-  this behavior=2E
-
--=
 All tun devices on all platforms are always considered to be IPv6
-  capab=
le=2E The ``--tun-ipv6`` option is ignored (behaves like it is always
-  on=
)=2E
-
-- On the client side recursively routed packets, which have the sam=
e destination
-  as the VPN server, are dropped=2E This can be disabled wit=
h
-  --allow-recursive-routing option=2E
-
-- On Windows, when the ``--regi=
ster-dns`` option is set, OpenVPN no longer
-  restarts the ``dnscache`` se=
rvice - this had unwanted side effects, and
-  seems to be no longer necess=
ary with currently supported Windows versions=2E
-
-- If no flags are given=
, and the interactive Windows service is used, "def1"
-  is implicitly set =
(because "delete and later reinstall the existing
-  default route" does no=
t work well here)=2E  If not using the service,
-  the old behaviour is kep=
t=2E
-
-- OpenVPN now reloads a CRL only if the modication time or file siz=
e has
-  changed, instead of for each new connection=2E  This reduces the c=
onnection
-  setup time, in particular when using large CRLs=2E
-
-- OpenVP=
N now ships with more up-to-date systemd unit files which take advantage
- =
 of the improved service management as well as some hardening steps=2E  The=

-  configuration files are picked up from the /etc/openvpn/server/ and
-  =
/etc/openvpn/client/ directories (depending on unit file)=2E  This also avo=
ids
-  these new unit files and how they work to collide with older pre-exi=
sting
-  unit files=2E
-
-- Using ``--no-iv`` (which is generally not a rec=
ommended setup) will
-  require explicitly disabling NCP with ``--disable-n=
cp``=2E  This is
-  intentional because NCP will by default use AES-GCM, wh=
ich requires
-  an IV - so we want users of that option to consciously reco=
nsider=2E
-
-
-Maintainer-visible changes
---------------------------
-- Op=
enVPN no longer supports building with crypto support, but without TLS
-  s=
upport=2E  As a consequence, OPENSSL_CRYPTO_{CFLAGS,LIBS} and
-  OPENSSL_SS=
L_{CFLAGS,LIBS} have been merged into OPENSSL_{CFLAGS,LIBS}=2E  This
-  is =
particularly relevant for maintainers who build their own OpenSSL library,
=
-  e=2Eg=2E when cross-compiling=2E
-
-- Linux distributions using systemd =
is highly encouraged to ship these new unit
-  files instead of older ones,=
 to provide a unified behaviour across systemd
-  based Linux distributions=
=2E
-
-- With OpenVPN 2=2E4, the project has moved over to depend on and ac=
tively use
-  the official C99 standard (-std=3Dc99)=2E  This may fail on s=
ome older compiler/libc
-  header combinations=2E  In most of these situati=
ons it is recommended to
-  use -std=3Dgnu99 in CFLAGS=2E  This is known to=
 be needed when doing
-  i386/i686 builds on RHEL5=2E
-
-
-Version 2=2E4=2E=
5
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-New features
-------------
--=
 The new option ``--tls-cert-profile`` can be used to restrict the set of
-=
  allowed crypto algorithms in TLS certificates in mbed TLS builds=2E  The
=
-  default profile is 'legacy' for now, which allows SHA1+, RSA-1024+ and a=
ny
-  elliptic curve certificates=2E  The default will be changed to the 'p=
referred'
-  profile in the future, which requires SHA2+, RSA-2048+ and any=
 curve=2E
-
-
-Version 2=2E4=2E3
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=

-New features
-------------
-- Support building with OpenSSL 1=2E1 now (in=
 addition to older versions)
-
-- On Win10, set low interface metric for TA=
P adapter when block-outside-dns
-  is in use, to make Windows prefer the T=
AP adapter for DNS queries
-  (avoiding large delays)
-
-
-Security
-------=
--
-- CVE-2017-7522: Fix ``--x509-track`` post-authentication remote DoS
- =
 A client could crash a v2=2E4+ mbedtls server, if that server uses the
-  =
``--x509-track`` option and the client has a correct, signed and unrevoked
=
-  certificate that contains an embedded NUL in the certificate subject=2E
=
-  Discovered and reported to the OpenVPN security team by Guido Vranken=2E=

-
-- CVE-2017-7521: Fix post-authentication remote-triggerable memory leak=
s
-  A client could cause a server to leak a few bytes each time it connect=
s to the
-  server=2E  That can eventually cause the server to run out of m=
emory, and thereby
-  causing the server process to terminate=2E Discovered=
 and reported to the
-  OpenVPN security team by Guido Vranken=2E  (OpenSSL=
 builds only=2E)
-
-- CVE-2017-7521: Fix a potential post-authentication re=
mote code execution
-  attack on servers that use the ``--x509-username-fie=
ld`` option with an X=2E509
-  extension field (option argument prefixed wi=
th ``ext:``)=2E  A client that can
-  cause a server to run out-of-memory (=
see above) might be able to cause the
-  server to double free, which in tu=
rn might lead to remote code execution=2E
-  Discovered and reported to the=
 OpenVPN security team by Guido Vranken=2E
-  (OpenSSL builds only=2E)
-
--=
 CVE-2017-7520: Pre-authentication remote crash/information disclosure for
=
-  clients=2E If clients use a HTTP proxy with NTLM authentication (i=2Ee=
=2E
-  ``--http-proxy <server> <port> [<authfile>|'auto'|'auto-nct'] ntlm2`=
`),
-  a man-in-the-middle attacker between the client and the proxy can ca=
use
-  the client to crash or disclose at most 96 bytes of stack memory=2E =
The
-  disclosed stack memory is likely to contain the proxy password=2E If=
 the
-  proxy password is not reused, this is unlikely to compromise the se=
curity
-  of the OpenVPN tunnel itself=2E  Clients who do not use the ``--h=
ttp-proxy``
-  option with ntlm2 authentication are not affected=2E
-
-- CV=
E-2017-7508: Fix remotely-triggerable ASSERT() on malformed IPv6 packet=2E
=
-  This can be used to remotely shutdown an openvpn server or client, if
- =
 IPv6 and ``--mssfix`` are enabled and the IPv6 networks used inside the VP=
N
-  are known=2E
-
-- Fix null-pointer dereference when talking to a malic=
ious http proxy
-  that returns a malformed ``Proxy-Authenticate:`` headers=
 for digest auth=2E
-
-- Fix overflow check for long ``--tls-cipher`` optio=
n
-
-- Windows: Pass correct buffer size to ``GetModuleFileNameW()``
-  (OS=
TIF/Quarkslabs audit, finding 5=2E6)
-
-
-User-visible Changes
------------=
---------
-- ``--verify-hash`` can now take an optional flag which changes =
the hashing
-  algorithm=2E It can be either SHA1 or SHA256=2E  The default=
 if not provided is
-  SHA1 to preserve backwards compatibility with existi=
ng configurations=2E
-
-- Restrict the supported ``--x509-username-field`` =
extension fields to subjectAltName
-  and issuerAltName=2E  Other extension=
s probably didn't work anyway, and would
-  cause OpenVPN to crash when a c=
lient connects=2E
-
-
-Bugfixes
---------
-- Fix fingerprint calculation in=
 mbed TLS builds=2E  This means that mbed TLS users
-  of OpenVPN 2=2E4=2E0=
, v2=2E4=2E1 and v2=2E4=2E2 that rely on the values of the
-  ``tls_digest_=
*`` env vars, or that use ``--verify-hash`` will have to change
-  the fing=
erprint values they check against=2E  The security impact of the
-  incorre=
ct calculation is very minimal; the last few bytes (max 4, typically
-  4) =
are not verified by the fingerprint=2E  We expect no real-world impact,
-  =
because users that used this feature before will notice that it has suddenl=
y
-  stopped working, and users that didn't will notice that connection set=
up
-  fails if they specify correct fingerprints=2E
-
-- Fix edge case with=
 NCP when the server sends an empty PUSH_REPLY message
-  back, and the cli=
ent would not initialize it's data channel crypto layer
-  properly (trac #=
903)
-
-- Fix SIGSEGV on unaligned buffer access on OpenBSD/Sparc64
-
-- Fi=
x TCP_NODELAY on OpenBSD
-
-- Remove erroneous limitation on max number of =
args for ``--plugin``
-
-- Fix NCP behaviour on TLS reconnect (Server would=
 not send a proper
-  "cipher =2E=2E=2E" message back to the client, leadin=
g to client and server
-  using different ciphers) (trac #887)
-
-
-Version=
 2=2E4=2E2
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Bugfixes
---------
-=
- Fix memory leak introduced in OpenVPN 2=2E4=2E1: if ``--remote-cert-tls``=
 is
-  used, we leaked some memory on each TLS (re)negotiation=2E
-
-
-Secu=
rity
---------
-- Fix a pre-authentication denial-of-service attack on both=
 clients and
-  servers=2E  By sending a too-large control packet, OpenVPN =
2=2E4=2E0 or v2=2E4=2E1 can
-  be forced to hit an ASSERT() and stop the pr=
ocess=2E  If ``--tls-auth`` or
-  ``--tls-crypt`` is used, only attackers t=
hat have the ``--tls-auth`` or
-  ``--tls-crypt`` key can mount an attack=
=2E
-  (OSTIF/Quarkslab audit finding 5=2E1, CVE-2017-7478)
-
-- Fix an aut=
henticated remote DoS vulnerability that could be triggered by
-  causing a=
 packet id roll over=2E  An attack is rather inefficient; a peer
-  would n=
eed to get us to send at least about 196 GB of data=2E
-  (OSTIF/Quarkslab =
audit finding 5=2E2, CVE-2017-7479)
-
-
-Version 2=2E4=2E1
-=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
-- ``--remote-cert-ku`` now only requires the cert=
ificate to have at least the
-  bits set of one of the values in the suppli=
ed list, instead of requiring an
-  exact match to one of the values in the=
 list=2E
-- ``--remote-cert-tls`` now only requires that a keyUsage is pres=
ent in the
-  certificate, and leaves the verification of the value up to t=
he crypto
-  library, which has more information (i=2Ee=2E the key exchange=
 method in use)
-  to verify that the keyUsage is correct=2E
-- ``--ns-cert=
-type`` is deprecated=2E  Use ``--remote-cert-tls`` instead=2E
-  The nsCer=
tType x509 extension is very old, and barely used=2E
-  ``--remote-cert-tls=
`` uses the far more common keyUsage and extendedKeyUsage
-  extension inst=
ead=2E  Make sure your certificates carry these to be able to
-  use ``--re=
mote-cert-tls``=2E
-
diff --git a/Makefile=2Eam b/Makefile=2Eam
index feeaa=
bb=2E=2E66252e6 100644
--- a/Makefile=2Eam
+++ b/Makefile=2Eam
@@ -59,7 +59=
,7 @@
 dist_doc_DATA =3D \
 	README \
 	README=2Embedtls \
-	Changes=2Erst =
\
+	Changes=2Emd \
 	COPYRIGHT=2EGPL \
 	COPYING
 

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1767?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I8887fa7ccf407d727c2b59397000149e45487e13
Gerr=
it-Change-Number: 1767
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--x4c+AxinNkw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1767?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Convert Changes=2Erst to Markdown<br><br>S=
ince all of our release publishing infrastructure now uses<br>Markdown (Wik=
i, Forums, Github), preparing this documentation<br>in rst just creates mor=
e work for the people creating the<br>release (so often me ;))=2E<br><br>Th=
is conversion to Markdown tries to also fix several instances<br>of weird f=
ormatting=2E But I tried to limit myself to not go<br>too much in the direc=
tion of actually &quot;improving&quot; the text=2E<br><br>The biggest chang=
es come due to the missing support for<br>&lt;dl&gt; style lists in MarkDow=
n=2E We work around this by<br>converting to a &lt;ul&gt; and manually addi=
ng a bold paragraph<br>with the &quot;title&quot;=2E<br><br>v2:<br>- reform=
at feature lists as ul<br><br>Change-Id: I8887fa7ccf407d727c2b59397000149e4=
5487e13<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1767<br>Message-Id: &lt;20260907=
154412=2E29523-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38990=2Ehtml<br>Signe=
d-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>A Changes=
=2Emd<br>D Changes=2Erst<br>M Makefile=2Eam<br>3 files changed, 1,458 inser=
tions(+), 1,481 deletions(-)<br><br></pre>
<pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/Changes=2Emd b/C=
hanges=2Emd</span><br><span>new file mode 100644</span><br><span>index 0000=
000=2E=2E2684251</span><br><span>--- /dev/null</span><br><span>+++ b/Change=
s=2Emd</span><br><span>@@ -0,0 +1,1457 @@</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# Overview of changes in 2=2E8</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+## User-visible Changes</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
* **Parsing Distinguished Names in certificates**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  (OpenSSL backend:) OpenVPN now rejects certificates that have =
a null-byte</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  inside=
 any of the field values of their subject=2E To avoid ambiguity in the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  parsed subject, OpenVP=
N escapes the following characters by prefixing them with</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  a backslash:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  * &quot; &quot; (space) at the start or end of a field,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  * &quot;#&quot; at t=
he start of a field,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  * &quot;,&quot;, &quot;+&quot;, &quot;&quot;&quot;, &quot;\&quot;, &quot=
;&lt;&quot;, &quot;&gt;&quot; and &quot;;&quot; anywhere=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  As a result, if you use the option `--verify-x509-na=
me &lt;expected subject&gt;`,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  you need to prefix these characters with a backslash in your co=
nfiguration=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The=
 subject passed to a `--tls-verify` script is escaped in the same way and</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  you may need to adj=
ust your script=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (Mbed TLS backend:=
) The behavior has not changed=2E Subjects with null-bytes were</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  already rejected (assuming Op=
enVPN was built with Mbed TLS 3=2E5 or later) and</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  the characters mentioned above were already=
 escaped=2E However, the behavior of</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  Mbed TLS is slightly different from OpenSSL in that it a=
lso escapes &quot;=3D&quot;=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Overvi=
ew of changes in 2=2E7</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+## New features<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+* **Multi-socket support for servers**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  OpenVPN servers now can listen on mul=
tiple sockets at the same time=2E Multiple</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  `--local` statements in the configuration can be u=
sed to configure this=2E This</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  way the same server can e=2Eg=2E listen for UDP and TCP connect=
ions at the same</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  t=
ime, or listen on multiple addresses and/or ports=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+* **Client implementations for DNS options sent by server fo=
r Linux/BSD/macOS**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Linux, BSD and ma=
cOS versions of OpenVPN now ship with a per-platform default</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  `--dns-updown` script that imple=
ments proper handling of DNS configuration sent</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  by the server=2E The scripts should work on s=
ystems that use `systemd` or</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  `resolveconf` to manage the DNS setup, as well as raw `/etc/reso=
lv=2Econf` files=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  However, the exact features supported will depend on the configuration me=
thod=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  On Linux a=
nd MacOS this should usually make split-DNS configurations supported</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  out-of-the-box now=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Note that this new script will not be u=
sed by default if a `--up` script is</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  already in use to reduce problems with backwards compati=
bility=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  See documentation for `--dn=
s-updown` and `--dns` for more details=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+* **New client implementation for DNS options sent by server for Windows=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  The Windows client now uses NRPT (=
Name Resolution Policy Table) to handle DNS</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  configurations=2E This adds support for split-DNS=
 and DNSSEC and improves the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  compatbility with local DNS resolvers=2E Requires the interactiv=
e service=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+* **On Windows the `block-=
local` flag is now enforced with WFP filters=2E**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  The `block-local` flag to `--redirect-gateway` and `--redirect=
-private` is now</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  a=
lso enforced via the Windows Firewall, making sure packets can&#39;t be sen=
t to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  local net=
work=2E This provides stronger protection against TunnelCrack-style</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  attacks=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+* **Windows network adapters are now generated on dem=
and**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  This means that on systems that=
 run multiple OpenVPN connections at the same</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  time the users don&#39;t need to manually creat=
e enough network adapters anymore (in</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  addition to the ones created by the installer)=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+* **Windows automatic service now runs as an=
 unpriviledged user**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  All tasks that =
need privileges are now delegated to the interactive service=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  **NOTE** this has the risk of=
 breaking existing setups if the Windows</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  certificate store is used (cryptoapi), and the certi=
ficates are not readable for</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  `NT SERVICE\OpenVPNService`=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+* **Support for new version of Linux DCO module**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  The OpenVPN DCO module has been merged into the Linux kern=
el as of 6=2E16=2E This</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  required some API changes and OpenVPN 2=2E7 only supports the new API=
=2E The new</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  module=
 is called `ovpn`=2E Out-of-tree builds for older kernels are available fro=
m</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;https://gith=
ub=2Ecom/OpenVPN/ovpn-backports&gt;=2E Please see the release</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  announcements for further infor=
mation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+* **Support for server mode i=
n win-dco driver**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  On Windows the win=
-dco driver can now be used in server setups=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+* **Support for TLS client floating in DCO implementations**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  The kernel modules will detect clients flo=
ating to a new IP address and notify</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  userland so both data packets (kernel) and TLS packets (=
sent by userland) can</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  reach the new client IP=2E (Actual support depends on recent-enough ker=
nel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  implementation=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+* **Enforcement of AES-GCM usage limi=
t**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN will now enforce the usag=
e limits on AES-GCM with the same</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  confidentiality margin as TLS 1=2E3 does=2E This mean that =
renegotiation will be</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  triggered after roughly 2^28 to 2^31 packets depending of the packet si=
ze=2E More</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  details=
 about usage limit of AES-GCM can be found here:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  &lt;https://datatracker=2Eietf=2Eorg/doc/draft-irtf-cfrg-aead-l=
imits/&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+* **Epoch data keys and pack=
et format**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  This introduces the epoch=
 data format for AEAD data channel ciphers in TLS mode</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  ciphers=2E This new data format has a =
number of improvements over the standard</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &quot;DATA_V2&quot; format=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  - AEAD tag at the end of packet which is more hardware imp=
lementation friendly</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  - Automatic key switchover when cipher usage limits are hit, similar to =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch data k=
eys in (D)TLS 1=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  - 64 bit instead of 32 bit packet ids to allow the data channel to be rea=
dy for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    10 GBit/s=
 without having frequent renegotiation</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  - IV constructed with XOR instead of concatenation to =
not have (parts) of the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    real IV on the wire</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Support=
 for Epoch data channel on Windows, using the win-dco driver (2=2E8=2E0+)**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+* **Default ciphers in `--data-ciphers=
`**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Ciphers in `--data-ciphers` can c=
ontain the string DEFAULT that is replaced by</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  the default ciphers used by OpenVPN, making it =
easier to add an allowed cipher</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  without having to spell out the default ciphers=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+* **TLS alerts**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  OpenVPN 2=2E7 will send out TLS alerts to peers informing them if the=
 TLS session</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  shuts=
 down or when the TLS implementation informs the peer about an error in the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  TLS session (e=2E=
g=2E mismatching TLS versions)=2E This improves the user experience</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  as the client shows an er=
ror instead of running into a timeout when the server</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  just stops responding completely=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+* **Support for tun/tap via unix domain s=
ocket and lwipovpn support**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  To allow=
 better testing and emulating a full client with a full network stack</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN now allows a pr=
ogram executed to provide a tun/tap device instead of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  opening a device=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  The co-developed lwipovpn program based on lwIP stack al=
lows to simulate full IP</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  stack=2E An OpenVPN client using `--dev-node unix:/path/to/lwipovpn`=
 can emulate a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ful=
l client that can be pinged, can serve a website and more without requiring=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  any elevated perm=
ission=2E This can make testing OpenVPN much easier=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  For more details see [lwipovpn on Github](https://github=
=2Ecom/OpenVPN/lwipovpn)=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Allow o=
verriding username with `--override-username`**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  This is intended to allow using `--auth-gen-token` in scenarios =
where the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  clients =
use certificates and multi-factor authentication=2E This will also</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  generate a `push &quot;aut=
h-token-user newusername&quot;` directive in push replies=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+* **`--port-share` now properly supports IPv6**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  Issues with logging of IPv6 addresses were=
 fixed=2E The feature now allows IPv6</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  connections towards the proxy receiver=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+* **Support for Haiku OS**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+* **TLS1=2E3 support with mbedTLS (requires mbedTLS &gt;=3D 3=2E=
6=2E4)**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+* **PUSH_UPDATE client support=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  It is now possible to update parts=
 of the client-side configuration (IP address,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  routes, MTU, DNS) by sending a new server-to-c=
lient control message,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  `PUSH_UPDATE,&lt;options&gt;`=2E See also:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  &lt;https://openvpn=2Egithub=2Eio/openvpn-rfc=
/openvpn-wire-protocol=2Ehtml&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  NOT=
E: PUSH_UPDATE client support is currently disabled if DCO is active (on al=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  platforms)=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+* **PUSH_UPDATE server support (minimal)*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  New management interface commands `=
push-update-broad` and `push-update-cid` to</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  send PUSH_UPDATE option updates to all clients (&=
quot;there is a new DNS server&quot;) or</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  only a specific client ID (&quot;privileges have cha=
nged, here&#39;s a new IP address&quot;)=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  See doc/management-notes=2Etxt</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 NOTE: PUSH_UPDATE server support is currently disabled if DCO is active</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  (on all platforms)=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+* **Support for user-defined routin=
g tables on Linux**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  See the `--route-=
table` option in the manpage</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **PQE su=
pport for WolfSSL**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **New environment=
 variables for gateway redirection**</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
Two new environment variables have been introduced to communicate desired</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  default gateway red=
irection to plugins like Network Manager,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  `route_redirect_gateway_ipv4` and `route_redirect_g=
ateway_ipv6`=2E See the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  &quot;Environmental Variables&quot; section in the man page</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+* **Improved logging of service events/errors to=
 event log on Windows=2E**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Improved=
 &quot;Recursive Routing&quot; check**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  The check is now more granular, and will only drop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  packets-in-tunnel if destination IP, pr=
otocol and port matches with those needed</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  to reach the VPN server=2E With that change, you ca=
n now use policies that direct</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  &quot;everything that is not OpenVPN&quot; into the tunnel, an=
d have IP packets to the VPN</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  server address arrive as expected (no such policies are currentl=
y installed by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Ope=
nVPN) (GH: OpenVPN/openvpn#669)=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **=
COPYING: license details only relevant to our Windows installers have</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+been updated and moved to=
 the openvpn-build repo**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Improved =
BYTECOUNT support**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  More strictly adh=
ere to timing interval requested, correctly support client and</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  server counters with Linux and=
 Windows DCO offloading=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Improve =
compatibility with OpenSSL 3=2E6=2E0 (do not fail t_lpback selftest)**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+* **New option `--tls-crypt-v2-max-age n`=
 to check tls-crypt-v2 timestamps**</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  W=
hen a client is older than n days or has no timestamp, the server will reje=
ct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  it=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+* **mbedTLS 4 support has been added=2E**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  Note that with mbedTLS 4 algorithms need to=
 be translated to mbedTLS 4 internal</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  IDs by OpenVPN, and some names might be missing=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+## Deprecated features</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+* **`secret` support has been removed (by default)=2E**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  static key mode (non-TLS) is no longer =
considered &quot;good and secure enough&quot; for</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  today&#39;s requirements=2E Use TLS mode in=
stead=2E If deploying a PKI CA is considered</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  &quot;too complicated&quot;, using `--peer-finge=
rprint` makes TLS mode about as easy as</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  using `--secret`=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  This mode can still be enabled by using</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  `--allow-deprecated-insecure-static-crypto` but =
will be removed in OpenVPN 2=2E8=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* *=
*Support for wintun Windows driver has been removed=2E**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  OpenVPN 2=2E6 added support for the new dco-win driver,=
 so it supported three</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  different device drivers: dco-win, wintun, and tap-windows6=2E OpenVPN=
 2=2E7 now</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  drops t=
he support for wintun driver=2E By default all modern configs should be</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  supported by dco-win =
driver=2E In all other cases OpenVPN will fall back</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  automatically to tap-windows6 driver=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+* **NTLMv1 authentication support for =
HTTP proxies has been removed=2E**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Th=
is is considered an insecure method of authentication that uses obsolete</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  crypto algorithms=2E=
 NTLMv2 support is still available, but will be removed in a</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  future release=2E When configure=
d to authenticate with NTLMv1 (`ntlm` keyword in</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  `--http-proxy`) OpenVPN will try NTLMv2 inst=
ead=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+* **`persist-key` option has bee=
n enabled by default=2E**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  All the key=
s will be kept in memory across restart=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+* **OpenSSL 1=2E0=2E2 support has been removed=2E**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  Support for building with OpenSSL 1=2E0=2E2 has been rem=
oved=2E The minimum supported</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  OpenSSL version is now 1=2E1=2E0=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+* **mbedTLS 2=2Ex support has been removed**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  Support for building with mbedTLS 2=2Ex has been removed (=
it is out of support</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  since March 2025, and the necessary compatibility code is making mainten=
ance and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  support f=
or mbedTLS 4=2Ex hard)=2E The minimum supported mbedTLS version is now</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  3=2E2=2E1=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+* **Compression on send has been removed=2E**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  OpenVPN 2=2E7 will never compress data =
before sending=2E Decompression of received</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  data is still supported=2E `--allow-compression y=
es` is now an alias for</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  `--allow-compression asym`=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* *=
*`--memstats` feature removed**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The `=
--memstats` option was largely undocumented and there is no known user of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  this feature=2E Thi=
s feature provided very limited statistics (number of users,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  link bytes read/written) and we =
do not except any usage because of this=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+* **Warning when using `--push` without `--mode server`**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  Using `--push` in a mode that is not `--mode serve=
r` will now print a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  clear warning that this is an unsupported operation and might cause negot=
iation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  failures=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+* **Warning for `--reneg-bytes` and `-=
-reneg-packets` in DCO mode**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `--rene=
g-bytes` and `--reneg-packets` do not work in DCO mode, and will</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  now print an appropriate war=
ning=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+* **On-connect resolving of `--=
remote` in `--tcp-server` mode removed**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  On-connect resolving of `--remote` addresses in `--tcp-server` mode</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  was not working since=
 2=2E4, so the code was completely removed=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+## User-visible Changes</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Defaul=
t for `--topology` changed to `subnet` for `--mode server`=2E Previous</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  releases always used `=
net30` as default=2E This only affects configs with</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  `--mode server` or `--server` (the latt=
er implies the former), and</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  `--dev tun`, and only if IPv4 is enabled=2E Note that this change=
s the semantics</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  of=
 `--ifconfig`, so if you have manual settings for that in your config but</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  not set `--topology=
` your config might fail to parse with the new version=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  Just adding `--topology net30` to t=
he config should fix the problem=2E By</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  default `--topology` is pushed from server to client=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--x509-userna=
me-field` will no longer automatically convert fieldnames to</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  uppercase=2E This was deprecated=
 since OpenVPN 2=2E4, and has now been removed=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+- `--dh none` is now the default if `--dh` is=
 not specified=2E Modern TLS</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  implementations will prefer ECDH and other more modern algorithm=
s anyway=2E And</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  fi=
nite field Diffie Hellman is in the proces of being deprecated (see</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  draft-ietf-tls-deprecate-=
obsolete-kex)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--l=
port 0` does not imply `--bind` anymore=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+- `--redirect-gateway` now works correctly if the VP=
N remote is not reachable by</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  the default gateway=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+- `--show-gateway` now supports querying the gateway for IPv4=
 addresses=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--s=
tatic-challenge` option now has a third parameter `format` that can change<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  how password and c=
hallenge response should be combined=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+- `--key` and `--cert` now accept URIs implemented in O=
penSSL 3 as well as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  optional OpenSSL 3 providers loaded using `--providers` option=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+- `--cryptoapicert` now sup=
ports issuer name as well as Windows CA template name</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  or OID as selector string=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+- TLS handshake debugging info=
rmation contains much more details now when using</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  recent versions of OpenSSL=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+- The `IV_PLAT_VER` variable sent=
 by Windows clients now contains the full</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  Windows build version to make it possible to determ=
ine the Windows 10 or</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  Windows 11 version used=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+- The `--windows-driver` option to select between various window=
s drivers will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  no =
longer do anything - it&#39;s kept so existing configs will not become inva=
lid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  but it is ign=
ored with a warning=2E The default is now `ovpn-dco` if all options</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  used are compatible with =
DCO, with a fallback to `tap-windows6`=2E To force TAP</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  (for example because a server pushes D=
CO incompatible options), use the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  `--disable-dco` option=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+- Apply more checks to incoming TLS handshake packets=
 before creating new</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  state - namely, verify message ID / acked ID for &quot;valid range for a=
n initial</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  packet&q=
uot;=2E This fixes a problem with clients that float very early but send</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  control channel pack=
et from the pre-float IP (Github: OpenVPN/openvpn#704)=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+- Use of `--dh dh2048=2Epem` in all s=
ample configs has been replaced with</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  `--dh none`=2E The `dh2048=2Epem` file has been removed=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- The startup de=
lay in `t_client=2Esh` has been reduced from 3s to 1s, making a</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  noticeable difference for set=
ups with many tests=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+- Changed from using `uncrustify` for code formatting and pre-commit che=
cks to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `clang-form=
at`=2E This reformatted quite a bit of code, and requires that</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  regular committers change thei=
r pre-commit checks accordingly=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+- On Linux, on interfaces where applicable, OpenVPN explicit=
ly configures the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
broadcast address again=2E This was dropped for 2=2E6=2E0 &quot;because com=
puters are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  smart a=
nd can do it themselves&quot;, but the kernel netlink interface isn&#39;t, =
and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  will install &=
quot;0=2E0=2E0=2E0&quot;=2E This does not normally matter, but for broadcas=
t-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  applicatio=
ns that get the address to use from &quot;ifconfig&quot;, this change repai=
rs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  functionality (=
this has been backported to 2=2E6=2E15, but is not in earlier 2=2E6</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  versions)=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+- `max-routes-per-client 0` used=
 to be silently upgraded to `1`=2E This now</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  produces an error=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+- `ifconfig` and `ifconfig-ipv6` values are now =
stored in pre-connect options</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  cache, and will be restored to pre-connect values on reconnects=
 if the server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  sto=
ps pushing the respective option=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+- `tapctl=2Eexe` helper binary on Windows has been reworked=
 to improve help texts</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  (making clear that it can not only do TAP-Adapters but Win-DCO as well=
), add</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  printing of=
 the hwid to all adapter outputs, and change the default adapter</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  type created to `ovpn-dco`=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- The default fo=
r `multihome` egress interface handling has changed=2E 2=2E7=2E0 will</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  default to ipi_ifindex=
=3D0, that is, leave the decision to the routing/policy</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  setup of the operating system=2E The =
pre-2=2E7 behaviour (force egress =3D ingress</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  interface) can be achieved with the new `--mult=
ihome same-interface`</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  sub-option=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- =
Windows `openvpn=2Eexe` binary manifest now sets code page UTF8 - which has=
 no</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  direct effect =
on OpenVPN itself, but this repairs OpenSSL file loading for</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  key/cert files with non-ASCII ch=
aracters in their file names (GH:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  OpenVPN/openvpn#920)=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+- The `test-crypto` option no longer requires a `--secr=
et` argument and will</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  automatically generate a random key=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+- The configure-time option `--enable-x509-alt-usern=
ame` is no longer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
conditional, and always-on (GH: OpenVPN/openvpn#917)=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+## Deprecated features</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+* **`--opt-verify` feature removed**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 This option was already deprecated and it is now being converted to a no-o=
p=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Using this op=
tion will only print a warning=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Ove=
rview of changes in 2=2E6</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+## Project ch=
anges</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+We want to deprecate our old Trac=
 bug tracking system=2E Please report any issues</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+with this release in GitHub instead: &lt;https=
://github=2Ecom/OpenVPN/openvpn/issues&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+## New features</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Support unlimit=
ed number of connection entries and remote entries**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+* **New management commands to enumerate and list remote ent=
ries**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  Use `remote-entry-count` and `=
remote-entry-get` commands from the management</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  interface to get the number of remote entries =
and the entries themselves=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Keyin=
g Material Exporters (RFC 5705) based key generation**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  As part of the cipher negotiation OpenVPN will automatica=
lly prefer the RFC5705</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  based key material generation to the current custom OpenVPN PRF=2E Thi=
s feature</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  requires=
 OpenSSL or mbed TLS 2=2E18+=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Com=
patibility with OpenSSL in FIPS mode**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  OpenVPN will now work with OpenSSL in FIPS mode=2E Note, no effort has be=
en made</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  to check o=
r implement all the requirements/recommendation of FIPS 140-2=2E This</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  just allows OpenVPN to =
be run on a system that be configured OpenSSL in FIPS</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  mode=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+* **`mlock` now checks available memlock-able memory**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  `mlock` will now check if enough memlock-able memory=
 has been reserved,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  and if less than 100MB RAM are available, use setrlimit() to upgrade the =
limit=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  See Trac =
#1390=2E Not available on OpenSolaris=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+* **Certificate pinning/verify peer fingerprint**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  The `--peer-fingerprint` option has been introduced to giv=
e users an easy to use</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  alternative to the `tls-verify` for matching the fingerprint of the pe=
er=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  option t=
akes use a number of allowed SHA256 certificate fingerprints=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  See the man page section &quot;Small OpenVPN set=
up with peer-fingerprint&quot; for a</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  tutorial on how to use this feature=2E This is also avai=
lable online under</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;https://github=2Ecom/openvpn/openvpn/blob/master/doc/man-sections/exam=
ple-fingerprint=2Erst&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **TLS mode =
with self-signed certificates**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  When =
`--peer-fingerprint` is used, the `--ca` and `--capath` option become</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  optional=2E This allows=
 for small OpenVPN setups without setting up a PKI with</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  Easy-RSA or similar software=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+* **Deferred auth support for scripts**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  The `--auth-user-pass-verify` script su=
pports now deferred authentication=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+*=
 **Pending auth support for plugins and scripts**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  Both auth plugin and script can now signal pending authenticat=
ion to the client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
when using deferred authentication=2E The new `client-crresponse` script op=
tion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and `OPENVPN_=
PLUGIN_CLIENT_CRRESPONSE` plugin function can be used to parse a</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  client response to a `CR_TEX=
T` two factor challenge=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  See `sampl=
e/sample-scripts/totpauth=2Epy` for an example=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+* **Compatibility mode (`--compat-mode`)**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  The modernisation of defaults can impact the compatibility=
 of OpenVPN 2=2E6=2E0 with</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  older peers=2E The options `--compat-mode` allows UIs to provide u=
sers with an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  easy =
way to still connect to older servers=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+* **OpenSSL 3=2E0 support**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenSSL=
 3=2E0 has been added=2E Most of OpenSSL 3=2E0 changes are not user visible=
 but</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  improve gener=
al compatibility with OpenSSL 3=2E0=2E `--tls-cert-profile insecure`</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  has been added to allow =
selecting the lowest OpenSSL security level (not</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  recommended, use only if you must)=2E OpenSS=
L 3=2E0 no longer supports the Blowfish</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  (and other deprecated) algorithm by default and the n=
ew option `--providers`</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  allows loading the legacy provider to renable these algorithms=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+* **Optional ciphers in `--data-ciphers`*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  Ciphers in `--data-ciphers` can now=
 be prefixed with a `?` to mark those as</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  optional and only use them if the SSL library suppor=
ts them=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+* **Improved `--mssfix` and =
`--fragment` calculation**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The `--mss=
fix` and `--fragment` options now allow an optional `mtu` parameter to</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  specify that different=
 overhead for IPv4/IPv6 should taken into account and the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  resulting size is specified as the =
total size of the VPN packets including IP</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  and UDP headers=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+* **Cookie based handshake for UDP server**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  Instead of allocating a connection for each client on the initi=
al packet OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
server will now use an HMAC based cookie as its session id=2E This way the =
server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  can verify =
it on completing the handshake without keeping state=2E This eliminates</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  the amplification and=
 resource exhaustion attacks=2E For tls-crypt-v2 clients,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  this requires OpenVPN 2=2E6 clients=
 or later because the client needs to resend</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  its client key on completing the hand shake=2E T=
he tls-crypt-v2 option allows</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  controlling if older clients are accepted=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  By default the rate of initial packet responses is limi=
ted to 100 per 10s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 interval to avoid OpenVPN servers being abused in reflection attacks (see<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `--connect-freq-in=
itial`)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+* **Data channel offloading =
with ovpn-dco**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  2=2E6=2E0+ implements=
 support for data-channel offloading where the data packets are</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  directly processed and forwar=
ded in kernel space thanks to the ovpn-dco kernel</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  module=2E The userspace openvpn program act=
s purely as a control plane</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  application=2E Note that DCO will use DATA\_V2 packets in P2P mod=
e, therefore, this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 implies that peers must be running 2=2E6=2E0+ in order to have P2P-NCP whi=
ch brings</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  DATA\_V2=
 packet support=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Session timeout*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  It is now possible to terminate a s=
ession (or all) after a specified amount of</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  seconds has passed session commencement=2E This b=
ehaviour can be configured using</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  `--session-timeout`=2E This option can be configured on the =
server, on the client</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  or can also be pushed=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Inline=
 auth username and password**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Usernam=
e and password can now be specified inline in the configuration file</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  within the `&lt;auth-use=
r-pass&gt;&lt;/auth-user-pass&gt;` tags=2E If the password is</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  missing OpenVPN will prompt for=
 input via stdin=2E This applies to inline&#39;d</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  http-proxy-user-pass too=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+* **Tun MTU can be pushed**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  The client can now also dynamically configure its MTU and the se=
rver will try to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  p=
ush the client MTU when the client supports it=2E The directive `--tun-mtu-=
max`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  has been intr=
oduced to increase the maximum pushable MTU size (defaults to</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  1600)=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+* **Dynamic TLS Crypt**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  When both peers are OpenVPN 2=2E6=2E1+, OpenVPN will dynamically create a=
 tls-crypt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  key tha=
t is used for renegotiation=2E This ensure that only the previously</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  authenticated peer can do=
 trigger renegotiation and complete renegotiations=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+* **Improved control channel packet size control (`max-packe=
t-size`)**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  The size of control channe=
l is no longer tied to `--link-mtu`/`--tun-mtu` and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  can be set using `--max-packet-size`=2E=
 Sending large control channel frames is</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  also optimised by allowing 6 outstanding packets ins=
tead of just 4=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
`max-packet-size` will also set `mssfix` to try to limit data-channel packe=
ts as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  well=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+## Deprecated features</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+* **`inetd` has been removed**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  This was a very limited and not-well-tested way to run OpenVPN,=
 on TCP and TAP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  mo=
de only=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+* **`verify-hash` has been d=
eprecated**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  This option has very limi=
ted usefulness and should be replaced by either a</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  better `--ca` configuration or with a `--tl=
s-verify` script=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **`secret` has be=
en deprecated**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  Static key mode (non-=
TLS) is no longer considered &quot;good and secure enough&quot; for</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  today&#39;s requirements=
=2E Use TLS mode instead=2E If deploying a PKI CA is considered</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &quot;too complicated&quot;, =
using `--peer-fingerprint` makes TLS mode about as easy as</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  using `--secret`=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+* **`ncp-disable` has been removed**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  This option mainly served a role as debug option when=
 NCP was first introduced=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  It should now no longer be necessary=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+* **TLS 1=2E0 and 1=2E1 are deprecated**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  `tls-version-min` is set to 1=2E2 by default=2E OpenVPN 2=
=2E6=2E0 defaults to a minimum</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  TLS version of 1=2E2 as TLS 1=2E0 and 1=2E1 should be generall=
y avoided=2E Note that</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  OpenVPN versions older than 2=2E3=2E7 use TLS 1=2E0 only=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+* **`--cipher` argument is no longer appended to =
`--data-ciphers` by default**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Data ci=
pher negotiation has been introduced in 2=2E4=2E0 and been</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  significantly improved in 2=2E5=2E=
0=2E The implicit fallback to the cipher specified</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  in `--cipher` has been removed=2E Effectiv=
ely, `--cipher` is a no-op in TLS mode</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  now, and will only have an effect in pre-shared-key mo=
de (`--secret`)=2E From now</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  on `--cipher` should not be used in new configurations for TLS mo=
de=2E Should</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  backw=
ards compatibility with older OpenVPN peers be required, please see the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  `--compat-mode` inste=
ad=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+* **`--prng` has beeen removed**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  OpenVPN used to implement its own PRN=
G based on a hash=2E However implementing a</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  PRNG is better left to a crypto library=2E So we =
use the PRNG mbed TLS or OpenSSL</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  now=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **`--keysize` h=
as been removed**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The `--keysize` opt=
ion was only useful to change the key length when using the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  BF, CAST6 or RC2 ciphers=2E For a=
ll other ciphers the key size is fixed with the</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  chosen cipher=2E As OpenVPN v2=2E6 no longer =
supports any of these variable length</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  ciphers, this option was removed as well to avoid confu=
sion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+* **Compression no longer enabl=
ed by default**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  Unless an explicit co=
mpression option is specified in the configuration,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  `--allow-compression` defaults to `no` =
in OpeNVPN 2=2E6=2E0=2E By default, OpenVPN 2=2E5</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  still allowed a server to enable compressio=
n by pushing compression related</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  options=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **PF (Packe=
t Filtering) support has been removed**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  The built-in PF functionality has been removed from the code base=2E Thi=
s feature</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  wasn&#39=
;t really easy to use and was long unmaintained=2E This implies that also</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `--management-clien=
t-pf` and any other compile time or run time related option</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  do not exist any longer=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+* **Option conflict checking is being depreca=
ted and phased out**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The static optio=
n checking (OCC) is no longer useful in typical setups that</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  negotiate most connection paramet=
ers=2E The `--opt-verify` and `--occ-disable`</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  options are deprecated, and the configure optio=
n `--enable-strict-options` has</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  been removed=2E Logging of mismatched options has been moved =
to debug logging</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (=
verb 7)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+## User-visible Changes</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+- CHACHA20-POLY1305 is included in the de=
fault of `--data-ciphers` when</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  available=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+- Option `--prng` is ignored as we rely on the SSL library random num=
ber</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  generator=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Option `--nobind` i=
s default when `--client` or `--pull` is used in the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  configuration</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+- `link_mtu` parameter is removed from enviro=
nment or replaced with 0 when</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  scripts are called with parameters=2E This parameter is unrelia=
ble and no longer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
internally calculated=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+- control channel packet maximum size is no longer influenced by</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  `--link-mtu`/`--tun-mtu=
` and must be set by `--max-packet-size` now=2E The</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  default is 1250 for the control channel=
 size=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- In point-=
to-point OpenVPN setups (no `--server`), using `--explict-exit-notiy`</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  on one end would termin=
ate the other side at session end=2E This is considered a</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  no longer useful default and has be=
en changed to &quot;restart on reception of</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  explicit-exit-notify message&quot;=2E If the old =
behaviour is still desired,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  `--remap-usr1 SIGTERM` can be used=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+- FreeBSD tun interfaces with `--topology subne=
t` are now put into real subnet</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  mode (IFF_BROADCAST instead of IFF_POINTOPOINT) - this might =
upset software</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  tha=
t enumerates interfaces, looking for &quot;broadcast capable?&quot; and exp=
ecting</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  certain res=
ults=2E Normal uses should not see any difference=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+- The default configurations will no long=
er allow connections to OpenVPN 2=2E3=2Ex</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  peer or earlier, use the new `--compat-mode` option=
 if you need compatibility</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  with older versions=2E See the manual page on the `--compat-mode` =
for details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- The=
 `client-pending-auth` management command now requires also the key id=2E T=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  management vers=
ion has been changed to 5 to indicate this change=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+- (OpenVPN 2=2E6=2E2) A client will now r=
efuse a connection if pushed compression</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  settings will contradict the setting of allow-compre=
ssion as this almost</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  always results in a non-working connection=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+- The &quot;kill&quot; by addr management comm=
and now requires also the protocol as string</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  e=2Eg=2E &quot;udp&quot;, &quot;tcp&quot;=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+## Common errors with OpenSSL 3=2E0 and O=
penVPN 2=2E6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+Both OpenVPN 2=2E6 and Ope=
nSSL 3=2E0 tighten the security considerable, so some</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+configuration will no longer work=2E This=
 section will cover the most common</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+causes and error message we have seen and explain their rea=
son and temporary</span><br><span style=3D"color: hsl(120, 100%, 40%);">+wo=
rkarounds=2E You should fix the underlying problems as soon as possible sin=
ce</span><br><span style=3D"color: hsl(120, 100%, 40%);">+these workaround =
are not secure and will eventually stop working in a future</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+update=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+- weak SHA1 or MD5 signature on certificates</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  This will happen on either loading of certificates or on=
 connection to a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  s=
erver:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      OpenSSL: error:0A00018E:SS=
L routines::ca md too weak</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      Cannot load certificate file cert=2Ecrt</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      Exiting due to fatal error</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  OpenSSL 3=2E0 no longer allows weak signature=
s on certificates=2E You can</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  downgrade your security to allow them by using `--tls-cert-profi=
le insecure`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  but s=
hould replace/regenerate these certificates as soon as possible=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+- 1024 bit RSA certificates, 1024 bit DH parame=
ters, other weak keys</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This happens if=
 you use private keys or other cryptographic material that does</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  not meet today&#39;s cryptogr=
aphic standards anymore=2E Messages are similar to:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      OpenSSL: error:0A00018F:SSL routines::ee key too small=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      OpenSSL: erro=
r:1408518A:SSL routines:ssl3_ctx_ctrl:dh key too small</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  DH parameters (`--dh`) can be regenerated with `openssl d=
hparam 2048`=2E For</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  other cryptographic keys, these keys and certificates need to be regenera=
ted=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  TLS Securit=
y level can be temporarily lowered with `--tls-cert-profile legacy`</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  or even `--tls-cert-profi=
le insecure`=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+- Connecting to a OpenV=
PN 2=2E3=2Ex server or allowing OpenVPN 2=2E3=2Ex or earlier</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  clients</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  This will normally result in messages like:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      OPTIONS ERROR: failed to negotiate cipher with ser=
ver=2E Add the server&#39;s cipher (&#39;AES-128-CBC&#39;) to --data-cipher=
s (currently &#39;AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&#39;) if you wa=
nt to connect to this server=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  or</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      client/127=2E0=2E0=2E1:49954 SENT C=
ONTROL [client]: &#39;AUTH_FAILED,Data channel cipher negotiation failed (n=
o shared cipher)&#39; (status=3D1)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Yo=
u can manually add the missing cipher to the `--data-ciphers`=2E The standa=
rd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ciphers should =
be included as well, e=2Eg=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  `--data-ciphers AES-256-GCM:AES-128-GCM:?Chacha20-Poly1305:?AES=
-128-CBC`=2E You</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  c=
an also use the `--compat-mode` option=2E Note that these message may also<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  indicate other cip=
her configuration problems=2E See the data channel cipher</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  negotiation manual section for more=
 details=2E (Available online under</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  &lt;https://github=2Ecom/OpenVPN/openvpn/blob/master/doc/=
man-sections/cipher-negotiation=2Erst&gt;)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+- Use of a legacy or deprecated cipher (e=2Eg=2E 64bit block ciphers)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  OpenSSL 3=2E0 no longer supports a num=
ber of insecure and outdated ciphers in</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  its default configuration=2E Some of these ciphers ar=
e known to be vulnerable</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  (SWEET32 attack)=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This will =
typically manifest itself in messages like:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      OpenSSL: error:0308010C:digital envelope routines::unsupported</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Cipher algorith=
m &#39;BF-CBC&#39; not found</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      Unsupported cipher in --data-ciphers: BF-CBC</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  If your OpenSSL distribution comes with the legacy p=
rovider (see also</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
`man OSSL_PROVIDER-legacy`), you can load it with</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  `--providers legacy default`=2E This will r=
e-enable the old algorithms=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- OpenVP=
N version not supporting TLS 1=2E2 or later</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  The default in OpenVPN 2=2E6 and also in many distributions is now T=
LS 1=2E2 or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  later=
=2E Connecting to a peer that does not support this will results in</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  messages like:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      TLS error: Unsupported protocol=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  This typically indicates that client and serv=
er have no common TLS version</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  enabled=2E This can be caused by mismatched tls-version-min and=
 tls-version-max</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  o=
ptions on client and server=2E If your OpenVPN client is between v2=2E3=2E6=
 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  v2=2E3=2E2 tr=
y adding `tls-version-min 1=2E0` to the client configuration to use</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  TLS 1=2E0+ instead of TLS=
 1=2E0 only=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      OpenSSL: error:0A0=
00102:SSL routines::unsupported protocol</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  This can be an OpenVPN 2=2E3=2E6 or earlier version=2E `compat-version =
2=2E3=2E0` will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  en=
able TLS 1=2E0 support if supported by the OpenSSL distribution=2E Note tha=
t on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  some Linux di=
stributions enabling TLS 1=2E1 or 1=2E0 is not possible=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# Overview of changes in 2=2E5</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+## New features</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Client-=
specific tls-crypt keys (`--tls-crypt-v2`)**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  `tls-crypt-v2` adds the ability to supply each client with a unique=
 tls-crypt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  key=2E =
This allows large organisations and VPN providers to profit from the same</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  DoS and TLS stack p=
rotection that small deployments can already achieve using</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  `tls-auth` or `tls-crypt`=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+* **ChaCha20-Poly1305 cipher support**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  Added support for using the ChaCha20-Poly1=
305 cipher in the OpenVPN data</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  channel=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Improved Da=
ta channel cipher negotiation**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The o=
ption `ncp-ciphers` has been renamed to `data-ciphers`=2E The old name is</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  still accepted=2E T=
he change in name signals that `data-ciphers` is the preferred</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  way to configure data channel =
ciphers and the data prefix is chosen to avoid the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  ambiguity that exists with `--cipher` for =
the data cipher and `tls-cipher` for</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  the TLS ciphers=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 OpenVPN clients will now signal all supported ciphers from the `data-ciphe=
rs`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  option to the =
server via `IV_CIPHERS`=2E OpenVPN servers will select the first</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  common cipher from the `data=
-ciphers` list instead of blindly pushing the first</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  cipher of the list=2E This allows to us=
e a configuration like</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  `data-ciphers ChaCha20-Poly1305:AES-256-GCM` on the server that prefer=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ChaCha20-Poly130=
5 but uses it only if the client supports it=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  See the data channel negotiation section in the manual for more =
details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+* **Removal of BF-CBC suppor=
t in default configuration:**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  By defa=
ult OpenVPN 2=2E5 will only accept AES-256-GCM and AES-128-GCM as data</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  ciphers=2E OpenVPN 2=
=2E4 allows AES-256-GCM,AES-128-GCM and BF-CBC when no --cipher</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  and --ncp-ciphers options are=
 present=2E Accepting BF-CBC can be enabled by adding</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  &gt; data-ciphers AES-256-GCM:AES-128-GCM:BF-CBC</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  and when you need to support very old peers al=
so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &gt; data-ciphers-fallback BF-CBC<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  To offer backwards compatibility with=
 older configs an *explicit*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &gt; cip=
her BF-CBC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  in the configuration will =
be automatically translated into adding BF-CBC to the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  data-ciphers option and setting data-ci=
phers-fallback to BF-CBC (as in the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  example commands above)=2E We strongly recommend to switc=
hing away from BF-CBC to</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  a more secure cipher=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Asyn=
chronous (deferred) authentication support for auth-pam plugin=2E**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  See src/plugins/auth-pam/README=2Eauth-pam f=
or details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Deferred client-conne=
ct**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  The `--client-connect` option an=
d the connect plugin API allow</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  asynchronous/deferred return of the configuration file in the =
same way as the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  au=
th-plugin=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+* **Faster connection setu=
p**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  A client will signal in the `IV_P=
ROTO` variable that it is in pull mode=2E This</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  allows the server to push the configuration op=
tions to the client without</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  waiting for a `PULL_REQUEST` message=2E The feature is automatica=
lly enabled if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  bot=
h client and server support it and significantly reduces the connection set=
up</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  time by avoidin=
g one extra packet round-trip and 1s of internal event delays=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+* **Netlink support**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  On Linux, if configured without `--enable-iproute2`, configuring=
 IP addresses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and =
adding/removing routes is now done via the netlink(3) kernel interface=2E T=
his</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  is much faster=
 than calling `ifconfig` or `route` and also enables OpenVPN to</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  run with less privileges=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  If configured with --enable-iproute2, =
the `ip` command is used (as in 2=2E4)=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  Support for `ifconfig` and `route` is gone=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+* **Wintun support**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  On Windows, OpenVPN can now use `wintun` devices=2E They a=
re faster than the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 traditional `tap9` tun/tap devices, but do not provide `--dev tap` mode - =
so the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  official in=
stallers contain both=2E To use a wintun device, add</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  `--windows-driver wintun` to your confi=
g (and use of the interactive service is</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  required as wintun needs SYSTEM privileges to enable=
 access)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+* **IPv6-only operation**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  It is now possible to have only IPv6 a=
ddresses inside the VPN tunnel, and</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  IPv6-only address pools (2=2E4 always required IPv4 confi=
g/pools and IPv6 was the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  &quot;optional extra&quot;)=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+*=
 **Improved Windows 10 detection**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Co=
rrectly log OS on Windows 10 now=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* *=
*Linux VRF support**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Using the new `-=
-bind-dev` option, the OpenVPN outside socket can now be put</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  into a Linux VRF=2E See the &quo=
t;Virtual Routing and Forwarding&quot; documentation in the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  man page=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+* **TLS 1=2E3 support**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  TLS 1=2E3 support has been added to OpenVPN=2E Currently, this requires O=
penSSL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  1=2E1=2E1+=
=2E The options `--tls-ciphersuites` and `--tls-groups` have been added to<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  fine tune TLS prot=
ocol options=2E Most of the improvements were also backported to</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN 2=2E4 as part of the=
 maintainance releases=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Support s=
etting DHCP search domain**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  A new opt=
ion `--dhcp-option DOMAIN-SEARCH my=2Eexample=2Ecom` has been defined, and<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Windows support fo=
r it is implemented (tun/tap only, no wintun support yet)=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  Other platforms need to support =
this via `--up` script (Linux) or GUI</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  (OSX/Tunnelblick)=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+* **per-client changing of `--data-ciphers` or `data-ciphers-fallback`**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  Via client-connect script/dir (NOTE: =
this only changes preference of ciphers</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  for NCP, but can not override what the client announc=
es as &quot;willing to accept&quot;)=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+* **Handle setting of tun/tap interface MTU on Windows**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  If IPv6 is in use, MTU must be &gt;=3D 1280 (Windows e=
nforces IETF requirements)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Add supp=
ort for OpenSSL engines to access private key material (like TPM)=2E**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+* **HMAC based auth-token support**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  The `--auth-gen-token` support has been im=
proved and now generates HMAC based</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  user token=2E If the optional `--auth-gen-token-secret` o=
ption is used clients</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  will be able to seamlessly reconnect to a different server using the sa=
me secret</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  file or =
to the same server after a server restart=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+* **Improved support for pending authentication**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  The protocol has been enhanced to be able to signal that=
 the authentication</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  should use a secondary authentication via web (like SAML) or a two factor=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  authentication wi=
thout disconnecting the OpenVPN session with AUTH_FAILED=2E The</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  session will instead be stay =
in a authenticated state and wait for the second</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  factor authentication to complete=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  This feature currently requires usage of the=
 managent interface on both client</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  and server side=2E See the `management-notes=2Etxt` `clien=
t-pending-auth` and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  `cr-response` commands for more details=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+* **VLAN support**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN serv=
ers in TAP mode can now use 802=2E1q tagged VLANs on the TAP interface</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  to separate clients in=
to different groups that can then be handled differently</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  (different subnets / DHCP, firewall =
zones, =2E=2E=2E) further down the network=2E See</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  the new options `--vlan-tagging`, `--vlan-a=
ccept`, `--vlan-pvid`=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  802=2E1q tag=
ging on the client side TAP interface is not handled today (=3D tags are</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  just forwarded trans=
parently to the server)=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Support =
building of =2Emsi installers for Windows**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+* **Allow unicode search string in `--cryptoapicert` option (Windows)*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+* **Support IPv4 configs with /31 net=
masks now**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  (By no longer trying to c=
onfigure `broadcast x=2Ex=2Ex=2Ex` in ifconfig calls, /31</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  support &quot;just works&quot;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+* **New option `--block-ipv6` to reject a=
ll IPv6 packets (ICMPv6)**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This is us=
eful if the VPN service has no IPv6, but the clients might have (LAN),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  to avoid client connec=
tions to IPv6-enabled servers leaking &quot;around&quot; the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  IPv4-only VPN=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+* **`--ifconfig-ipv6` and `--ifconfig-ipv6-push` accep=
t hostnames**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  `--ifconfig-ipv6` and `=
--ifconfig-ipv6-push` will now accept hostnames and do</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  a DNS lookup to get the IPv6 address t=
o use=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+## Deprecated features</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+For an up-to-date list of all deprecated optio=
ns, see this wiki page:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+&lt;https://community=2Eopenvpn=2Enet/openvpn/wiki/DeprecatedOptions&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+- `ncp-disable` has been deprecated=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  With the improved and matured dat=
a channel cipher negotiation, the use of</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  `ncp-disable` should not be necessary anymore=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+- `inetd` has been deprecated=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  This is a very limited and not-well-tested wa=
y to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  run OpenVPN, =
on TCP and TAP mode only, which complicates the code quite a bit</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  for little gain=2E To be rem=
oved in OpenVPN 2=2E6 (unless users protest)=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+- `no-iv` has been removed=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  This option was made into a NOOP option with OpenVPN</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  2=2E4=2E This has now been completely =
removed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+- `--client-cert-not-require=
d` has been removed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This option will =
now cause server configurations to not start=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  Use `--verify-client-cert none` instead=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+- `--ifconfig-pool-linear` has been remov=
ed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  This option is removed=2E Use `=
--topology p2p` or `--topology subnet` instead=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+- `--compress xxx` is considered risky and is warned against, se=
e below=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+- `--key-method 1` has been =
removed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+## User-visible Changes</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+- If multiple connect handlers are used (clien=
t-connect, ccd, connect plugin)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  and one of the handler succeeds but a subsequent fails, the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  client-disconnect-s=
cript is now called immediately=2E Previously it was called,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  when the VPN session was termina=
ted=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Support for=
 building with OpenSSL 1=2E0=2E1 has been removed=2E The minimum</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  supported OpenSSL version is=
 now 1=2E0=2E2=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- =
The GET_CONFIG management state is omitted if the server pushes the client<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  configuration almo=
st immediately as result of the faster connection setup</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  feature=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+- `--compress` is nowadays considered risky, b=
ecause attacks exist leveraging</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  compression-inside-crypto to reveal plaintext (VORACLE)=2E So=
 by default,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `--co=
mpress xxx` will now accept incoming compressed packets (for</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  compatibility with peers that ha=
ve not been upgraded yet), but will not use</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  compression outgoing packets=2E This can be contr=
olled with the new option</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  `--allow-compression yes|no|asym`=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+- Stop changing `--txlen` aways from OS defaults u=
nless explicitly specified in</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  config file=2E OS defaults nowadays are actually larger then wh=
at we used to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  conf=
igure, so our defaults sometimes caused packet drops =3D bad performance=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- remove `--writepi=
d` pid file on exit now</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+- plugin-auth-pam now logs via OpenVPN logging method, no longer to std=
err (this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  means yo=
u&#39;ll have log messages in syslog or openvpn log file now)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+- use ISO 8601 time format for fi=
le based logging now (YYYY-MM-DD hh:mm:dd)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  (syslog is not affected, nor is `--machine-readabl=
e-output`)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--clr-=
verify` now loads all CRLs if more than one CRL is in the same file</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  (OpenSSL backend only, mb=
edTLS always did that)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+- when `--auth-user-pass file` has no password, and the management inter=
face is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  active, qu=
ery management interface (instead of trying console query, which</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  does not work on windows)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+- skip expired certifi=
cates in Windows certificate store (`--cryptoapicert`)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+- `--socks-proxy` + `--proto udp*` will =
now allways use IPv4, even if IPv6 is</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  requested and available=2E Our SOCKS code does not hand=
le IPv6+UDP, and before</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  that change it would just fail in non-obvious ways=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+- TCP listen() backlog queue is now=
 set to 32 - this helps TCP servers that</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  receive lots of &quot;invalid&quot; connects by TCP =
port scanners</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- do n=
o longer print OCC warnings (&quot;option mismatch&quot;) about `key-method=
`,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `keydir`, `tls-=
auth` and `cipher` - these are either gone now, or negotiated,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  and the warnings do not serve =
a useful purpose=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
- `dhcp-option DNS` and `dhcp-option DNS6` are now treated identically (=3D=
 both</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  accept an IP=
v4 or IPv6 address for the nameserver)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
## Maintainer-visible changes</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- the man=
 page is now in maintained in =2Erst format, so building the openvpn=2E8</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  manpage from a git c=
heckout now requires python-docutils (if this is missing,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  the manpage will not be built - whi=
ch is not considered an error generally,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  but for package builders or `make distcheck` it is)=
=2E Release tarballs contain</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  the openvpn=2E8 file, so unless some =2Erst is changed, doc-util=
s are not needed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  f=
or building=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- OCC=
 support can no longer be disabled</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+- AEAD support is now required in the crypto library</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+- `--disable-server` has be=
en removed from configure (so it is no longer</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  possible to build a client-/p2p-only OpenVPN bi=
nary) - the saving in code size</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  no longer outweighs the extra maintenance effort=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+- `--enable-iproute2` will di=
sable netlink(3) support, so maybe remove that from</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  package building configs (see above)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+- support building wit=
h MSVC 2019</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- cmocka=
 based unit tests are now only run if cmocka is installed externally</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  (2=2E4 used to ship a lo=
cal git submodule which was painful to maintain)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+- `--disable-crypto` configure option has been=
 removed=2E OpenVPN is now always</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  built with crypto support, which makes the code much easier=
 to maintain=2E This</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  does not affect `--cipher none` to do a tunnel without encryption=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--disable-multi` con=
figure option has been removed</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Overvi=
ew of changes in 2=2E4</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+## New features<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+* **Seamless client IP/port floating**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  Added new packet format P_DATA_V2, wh=
ich includes peer-id=2E If both the server</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  and client support it, the client sends all data p=
ackets in the new format=2E When</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  a data packet arrives, the server identifies peer by peer-id=
=2E If peer&#39;s ip/port</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  has changed, server assumes that client has floated, verifies HMAC =
and updates</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ip/por=
t in internal structs=2E This allows the connection to be immediately</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  restored, instead of re=
quiring a TLS handshake before the server accepts packets</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  from the new client ip/port=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+* **Data channel cipher negotiation**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Data channel ciphers (`--cipher`) are n=
ow by default negotiated=2E If a client</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  advertises support for Negotiable Crypto Parameters (=
NCP), the server will</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  choose a cipher (by default AES-256-GCM) for the data channel, and tell=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  client to use=
 that cipher=2E Data channel cipher negotiation can be controlled</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  using `--ncp-ciphers` and `=
--ncp-disable`=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  A more limited vers=
ion also works in client-to-server and server-to-client</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  scenarios where one of the end points=
 uses a v2=2E4 client or server and the other</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  side uses an older version=2E In such scenarios=
 the v2=2E4 side will change to the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  `--cipher` set by the remote side, if permitted by by `--=
ncp-ciphers`=2E For</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  example, a v2=2E4 client with `--cipher BF-CBC` and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  `ncp-ciphers AES-256-GCM:AES-256-CBC` c=
an connect to both a v2=2E3 server with</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  `cipher BF-CBC` as well as a server with `cipher AES-=
256-CBC` in its config=2E The</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  other way around, a v2=2E3 client with either `cipher BF-CBC` o=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `cipher AES-256-=
CBC` can connect to a v2=2E4 server with e=2Eg=2E `cipher BF-CBC` and</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  `ncp-ciphers AES-256-GC=
M:AES-256-CBC` in its config=2E For this to work it</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  requires that OpenVPN was built without=
 disabling OCC support=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **AEAD (GCM=
) data channel cipher support**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The d=
ata channel now supports AEAD ciphers (currently only GCM)=2E The AEAD pack=
et</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  format has a sm=
aller crypto overhead than the CBC packet format, (e=2Eg=2E 20 bytes</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  per packet for AES-128-G=
CM instead of 36 bytes per packet for AES-128-CBC +</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  HMAC-SHA1)=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+* **ECDH key exchange**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Th=
e TLS control channel now supports for elliptic curve diffie-hellmann key</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  exchange (ECDH)=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+* **Improved Certificate Revocation Lis=
t (CRL) processing**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  CRLs are now han=
dled by the crypto library (OpenSSL or mbed TLS), instead of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  inside OpenVPN itself=2E The cry=
pto library implementations are more strict than</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  the OpenVPN implementation was=2E This might=
 reject peer certificates that would</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  previously be accepted=2E If this occurs, OpenVPN will l=
og the crypto library&#39;s</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  error description=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Dual=
stack round-robin DNS client connect**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  Instead of only using the first address of each `--remote` OpenVPN will n=
ow try</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  all address=
es (IPv6 and IPv4) of a `--remote` entry=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+* **Support for providing IPv6 DNS servers**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  A new DHCP sub-option `DNS6` is added alongside with the alrea=
dy existing `DNS`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
sub-option=2E This is used to provide DNS resolvers available over IPv6=2E =
This may</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  be pushed=
 to clients where `--up` scripts and `--plugin` can act upon it through</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  the `foreign_option_&=
lt;n&gt;` environment variables=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Su=
pport for the Windows client picking up this new sub-option is added, howev=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  IPv6 DNS resolv=
ers need to be configured via `netsh` which requires</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  administrator privileges unless the new=
 interactive services on Windows is being</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  used=2E If the interactive service is used, this se=
rvice will execute `netsh` in</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  the background with the proper privileges=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+* **New improved Windows Background service**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  The new OpenVPNService is based on openvpnserv2,=
 a complete rewrite of the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  OpenVPN service wrapper=2E It is intended for launching OpenVPN in=
stances that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  shoul=
d be up at all times, instead of being manually launched by a user=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPNService is able =
to restart individual OpenVPN processes if they crash,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  and it also works properly on recent W=
indows versions=2E OpenVPNServiceLegacy</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  tends to work poorly, if at all, on newer Windows ver=
sions (8+) and its use is</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  not recommended=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **New inte=
ractive Windows service**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The install=
er starts OpenVPNServiceInteractive automatically and configures it</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  to start at system startu=
p=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  The interactive Windows service =
allows unprivileged users to start OpenVPN</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  connections in the global config directory (usuall=
y C:\Program</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Files=
\OpenVPN\config) using OpenVPN GUI without any extra configuration=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  Users who belong to the built-in Administr=
ator group or to the local &quot;OpenVPN</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  Administrator&quot; group can also store configurati=
on files under</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  %US=
ERPROFILE%\OpenVPN\config for use with the interactive service=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+* **redirect-gateway ipv6**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  OpenVPN has now feature parity between IPv4 and IPv6 for =
redirect gateway</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  i=
ncluding the handling of overlapping IPv6 routes with IPv6 remote VPN serve=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  address=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+* **LZ4 Compression and pushable compression=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  Additionally to LZO compression Op=
enVPN now also supports LZ4 compression=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  Compression options are now pushable from the serv=
er=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+* **Filter pulled options client-=
side: pull-filter**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  New option to exp=
licitly allow or reject options pushed by the server=2E May be</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  used multiple times and is app=
lied in the order specified=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Per-=
client remove push options: push-remove**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  New option to remove options on a per-client basis from the &quot;push=
&quot; list (more</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
fine-grained than `--push-reset`)=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* =
**Http proxy password inside config file**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  Http proxy passwords can be specified with the inline file option</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  `&lt;http-proxy-user-=
pass&gt;` =2E=2E `&lt;/http-proxy-user-pass&gt;`</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+* **Windows version detection**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  Windows version is detected, logged and possibly signalled to server</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (`IV_PLAT_VER=3D&lt=
;nn&gt;` if `--push-peer-info` is set on client)=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+* **Authentication tokens**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  In situations where it is not suitable to save user passwords on the =
client,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN ha=
s support for pushing a --auth-token since v2=2E3=2E This option is pushed<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  from the server to=
 the client with a token value to be used instead of the users</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  password=2E For this to work, =
the authentication plug-in would need to implement</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  this support as well=2E In OpenVPN 2=2E4 -=
-auth-gen-token is introduced, which will</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  allow the OpenVPN server to generate a random token=
 and push it to the client</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  without any changes to the authentication modules=2E When the clie=
nts need to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  re-aut=
henticate the OpenVPN server will do the authentication internally,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  instead of sending the re=
-authentication request to the authentication module =2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  This feature is especially useful in=
 configurations which use One Time Password</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  (OTP) authentication schemes, as this allows the =
tunnel keys to be renegotiated</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  regularly without any need to supply new OTP codes=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+* **keying-material-exporter**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  Keying Material Exporter [RFC-5705] allow additional =
keying material to be</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  derived from existing TLS channel=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+* **Android platform support**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Supp=
ort for running on Android using Android&#39;s VPNService API has been adde=
d=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  See doc/andro=
id=2Etxt for more details=2E This support is primarily used in the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN for Android app (&=
lt;https://github=2Ecom/schwabe/ics-openvpn&gt;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+* **AIX platform support**</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
AIX platform support has been added=2E The support only includes tap device=
s since</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  AIX does n=
ot provide tun interface=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Control=
 channel encryption (`--tls-crypt`)**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 Use a pre-shared static key (like the `--tls-auth` key) to encrypt control=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  channel packets=
=2E Provides more privacy, some obfuscation and poor-man&#39;s</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  post-quantum security=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+* **Asynchronous push reply**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  Plug-ins providing support for deferred authenticat=
ion can benefit from a more</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  responsive authentication where the server sends PUSH\_REPLY imme=
diately once the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  a=
uthentication result is ready, instead of waiting for the client to to send=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  PUSH\_REQUEST onc=
e more=2E This requires OpenVPN to be built with</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  `=2E/configure --enable-async-push`=2E This =
is a compile-time only switch=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+## Dep=
recated features</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+For an up-to-date list=
 of all deprecated options, see this wiki page:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+&lt;https://community=2Eopenvpn=2Enet/openvpn/w=
iki/DeprecatedOptions&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--key-meth=
od 1` is deprecated in OpenVPN 2=2E4 and will be removed in v2=2E5=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  Migrate away from `--ke=
y-method 1` as soon as possible=2E The recommended</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  approach is to remove the `--key-method` o=
ption from the configuration files,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  OpenVPN will then use `--key-method 2` by default=2E Note=
 that this requires</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  changing the option in both the client and server side configs=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+- `--tls-remote` is removed=
 in OpenVPN 2=2E4, as indicated in the v2=2E3 man-pages=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  Similar functionality is provided =
via `--verify-x509-name`, which does the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  same job in a better way=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+- `--compat-names` and `--no-name-remapping`=
 were deprecated in OpenVPN 2=2E3 and</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  will be removed in v2=2E5=2E All scripts and plug-ins d=
epending on the old</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  non-standard X=2E509 subject formatting must be updated to the standardiz=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  formatting=2E S=
ee the man page for more information=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+- `--no-iv` is deprecated in OpenVPN 2=2E4 and will be =
removed in v2=2E5=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+- `--keysize` is deprecated in OpenVPN 2=2E4 and will be removed in v2=2E6=
 together</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  with the=
 support of ciphers with cipher block size less than 128-bits=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+- `--comp-lzo` is deprecated i=
n OpenVPN 2=2E4=2E Use `--compress` instead=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+- `--ifconfig-pool-linear` has been deprecated s=
ince OpenVPN 2=2E1 and will be</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  removed in v2=2E5=2E Use `--topology p2p` instead=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+- `--client-cert-not-required=
` is deprecated in OpenVPN 2=2E4 and will be removed</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  in v2=2E5=2E Use `--verify-client-cert =
none` for a functional equivalent=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+- `--ns-cert-type` is deprecated in OpenVPN 2=2E3=2E18 and=
 v2=2E4=2E It will be removed</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  in v2=2E5=2E Use the far better `--remote-cert-tls` option whic=
h replaces this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  fe=
ature=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+## User-visible Changes</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+- When using ciphers with cipher blocks less =
than 128-bits, OpenVPN will</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  complain loudly if the configuration uses ciphers considered weak=
, such as the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  SWEE=
T32 attack vector=2E In such scenarios, OpenVPN will by default renegotiate=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  for each 64MB of =
transported data (`--reneg-bytes`)=2E This renegotiation can be</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  disabled, but is HIGHLY DISCO=
URAGED=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+- For certificate DNs with du=
plicate fields, e=2Eg=2E &quot;OU=3Done,OU=3Dtwo&quot;, both fields</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  are now exported to the e=
nvironment, where each second and later occurrence of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  a field get `_$N` appended to it&#39;s =
field name, starting at N=3D1=2E For the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  example above, that would result in e=2Eg=2E `X509_0=
_OU=3Done`, `X509_0_OU_1=3Dtwo`=2E Note</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  that this breaks setups that rely on the fact that Op=
enVPN would previously</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  (incorrectly) only export the last occurrence of a field=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+- `proto udp` and `proto tcp` now use both IPv4 a=
nd IPv6=2E The new options</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  `proto udp4` and `proto tcp4` use IPv4 only=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+- `--sndbuf` and `--recvbuf` default now to OS defaults in=
stead of 64k</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+- OpenVPN exits with an er=
ror if an option has extra parameters; previously they</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  were silently ignored</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+- `--tls-auth` always requires OpenVPN static key files=
 and will no longer work</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  with free form files</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--proto =
udp6/tcp6` in server mode will now try to always listen to both IPv4</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  and IPv6 on platforms th=
at allow it=2E Use `--bind ipv6only` to explicitly</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  listen only on IPv6=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+- Removed `--enable-password-save` from configure=2E This =
option is now always</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  enabled=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+- Stricter default TLS ci=
pher list (override with `--tls-cipher`), that now also</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  disables:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  - Non-ephemeral key exchange using static (EC)DH keys</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  - DSS private keys</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+- mbed TLS builds: changed the `tls_digest_N` va=
lues exported to the script</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  environment to be equal to the ones exported by OpenSSL builds, n=
amely the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  certific=
ate fingerprint (was the hash of the &#39;to be signed&#39; data)=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+- mbed TLS builds: minimum RSA key size is no=
w 2048 bits=2E Shorter keys will not</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  be accepted, both local and from the peer=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+- `--connect-timeout` now specifies the timeout un=
til the first TLS packet is</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  received (identical to `--server-poll-timeout`) and this timeout =
now includes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the r=
emoved socks proxy timeout and http proxy timeout=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  In `--static` mode `connect-timeout` specifies the timeout=
 for TCP and proxy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 connection establishment</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--connect-=
retry-max` now specifies the maximum number of unsuccessful</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  attempts of each remote/connectio=
n entry before exiting=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--http-pro=
xy-timeout` and the static non-changeable socks timeout (5s) have</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  been folded into a &quot;un=
ified&quot; `--connect-timeout` which covers all steps needed</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  to connect to the server, up to=
 the start of the TLS exchange=2E The default</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  value has been raised to 120s, to handle slow h=
ttp/socks proxies graciously=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  The old &quot;fail TCP fast&quot; behaviour can be achieved b=
y adding</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &quot;`--=
connect-timeout 10`&quot; to the client config=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+- `--http-proxy-retry` and `--sock-proxy-retry` have been remove=
d=2E Proxy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  connect=
ions will now behave like regular connection entries and generate a</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  USR1 on failure=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+- `--connect-retry` gets an optional second a=
rgument that specifies the maximum</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  time in seconds to wait between reconnection attempts when=
 an exponential</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ba=
ckoff is triggered due to repeated retries=2E Default =3D 300 seconds=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+- Data channel cipher negotiation (see Ne=
w features section) can override</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  ciphers configured in the config file=2E Use `--ncp-disable`=
 if you do not want</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  this behavior=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+- All tun devices on=
 all platforms are always considered to be IPv6 capable=2E The</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  `--tun-ipv6` option is ignored=
 (behaves like it is always on)=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- On=
 the client side recursively routed packets, which have the same destinatio=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  as the VPN serve=
r, are dropped=2E This can be disabled with</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  --allow-recursive-routing option=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+- On Windows, when the `--register-dns` option is se=
t, OpenVPN no longer</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  restarts the `dnscache` service - this had unwanted side effects, and se=
ems to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  be no longe=
r necessary with currently supported Windows versions=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+- If no flags are given, and the interactive Windows serv=
ice is used, &quot;def1&quot; is</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  implicitly set (because &quot;delete and later reinstall the=
 existing default</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
route&quot; does not work well here)=2E If not using the service, the old b=
ehaviour</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  is kept=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+- OpenVPN now reloads a CRL only if=
 the modication time or file size has</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  changed, instead of for each new connection=2E This red=
uces the connection setup</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  time, in particular when using large CRLs=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+- OpenVPN now ships with more up-to-date systemd unit files =
which take advantage</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  of the improved service management as well as some hardening steps=2E Th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  configuration fi=
les are picked up from the /etc/openvpn/server/ and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  /etc/openvpn/client/ directories (depen=
ding on unit file)=2E This also avoids</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  these new unit files and how they work to collide with=
 older pre-existing unit</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  files=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+- Using `--no-iv` (whic=
h is generally not a recommended setup) will require</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  explicitly disabling NCP with `--disabl=
e-ncp`=2E This is intentional because NCP</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  will by default use AES-GCM, which requires an IV -=
 so we want users of that</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  option to consciously reconsider=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+## Maintainer-visible changes</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Op=
enVPN no longer supports building with crypto support, but without TLS</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  support=2E As a conseq=
uence, `OPENSSL_CRYPTO_{CFLAGS,LIBS}` and</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  `OPENSSL_SSL_{CFLAGS,LIBS}` have been merged into `=
OPENSSL_{CFLAGS,LIBS}`=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  This is particularly relevant for maintainers who build their own O=
penSSL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  library, e=
=2Eg=2E when cross-compiling=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+- Linux distributions using systemd is highly encouraged to shi=
p these new unit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  f=
iles instead of older ones, to provide a unified behaviour across systemd</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  based Linux distrib=
utions=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- With Ope=
nVPN 2=2E4, the project has moved over to depend on and actively use the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  official C99 standar=
d (-std=3Dc99)=2E This may fail on some older compiler/libc</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  header combinations=2E In most of=
 these situations it is recommended to use</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  -std=3Dgnu99 in CFLAGS=2E This is known to be need=
ed when doing i386/i686 builds</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  on RHEL5=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Version 2=2E=
4=2E5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+## New features</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+- The new option `--tls-cert-profile` can be used to res=
trict the set of allowed</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  crypto algorithms in TLS certificates in mbed TLS builds=2E The defa=
ult profile</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  is &#3=
9;legacy&#39; for now, which allows SHA1+, RSA-1024+ and any elliptic curve=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  certificates=2E T=
he default will be changed to the &#39;preferred&#39; profile in the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  future, which requires S=
HA2+, RSA-2048+ and any curve=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Vers=
ion 2=2E4=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+## New features</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+- Support building with OpenSSL 1=2E1 now (in ad=
dition to older versions)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+- On Win10, set low interface metric for TAP adapter when block-outsi=
de-dns is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  in use, =
to make Windows prefer the TAP adapter for DNS queries (avoiding large</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  delays)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+## Security</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- CVE=
-2017-7522: Fix `--x509-track` post-authentication remote DoS A client</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  could crash a v2=2E4+ =
mbedtls server, if that server uses the `--x509-track`</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  option and the client has a correct, s=
igned and unrevoked certificate that</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  contains an embedded NUL in the certificate subject=2E D=
iscovered and reported</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  to the OpenVPN security team by Guido Vranken=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+- CVE-2017-7521: Fix post-authentication =
remote-triggerable memory leaks A</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  client could cause a server to leak a few bytes each time i=
t connects to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
server=2E That can eventually cause the server to run out of memory, and th=
ereby</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  causing the =
server process to terminate=2E Discovered and reported to the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN security team by Guido =
Vranken=2E (OpenSSL builds only=2E)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+- CVE-2017-7521: Fix a potential post-authentication remote=
 code execution</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  at=
tack on servers that use the `--x509-username-field` option with an X=2E509=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  extension field (=
option argument prefixed with `ext:`)=2E A client that can</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  cause a server to run out-of-memor=
y (see above) might be able to cause the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  server to double free, which in turn might lead to r=
emote code execution=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  Discovered and reported to the OpenVPN security team by Guido Vranken=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (OpenSSL build=
s only=2E)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- CVE-201=
7-7520: Pre-authentication remote crash/information disclosure for</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  clients=2E If clients use =
a HTTP proxy with NTLM authentication (i=2Ee=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  `--http-proxy &lt;server&gt; &lt;port&gt; [&l=
t;authfile&gt;|&#39;auto&#39;|&#39;auto-nct&#39;] ntlm2`), a</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  man-in-the-middle attacker betwe=
en the client and the proxy can cause the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  client to crash or disclose at most 96 bytes of sta=
ck memory=2E The disclosed</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  stack memory is likely to contain the proxy password=2E If the pro=
xy password is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  not=
 reused, this is unlikely to compromise the security of the OpenVPN tunnel<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  itself=2E Clients =
who do not use the `--http-proxy` option with ntlm2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  authentication are not affected=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+- CVE-2017-7508: Fix rem=
otely-triggerable ASSERT() on malformed IPv6 packet=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  This can be used to remotely shutdown =
an openvpn server or client, if IPv6 and</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  `--mssfix` are enabled and the IPv6 networks used in=
side the VPN are known=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+- Fix null-pointer dereference when talking to a malicious http proxy=
 that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  returns a ma=
lformed `Proxy-Authenticate:` headers for digest auth=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+- Fix overflow check for long `--tls-c=
ipher` option</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Wind=
ows: Pass correct buffer size to `GetModuleFileNameW()` (OSTIF/Quarkslabs</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  audit, finding 5=2E=
6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+## User-visible Changes</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+- `--verify-hash` can now take an optional flag whi=
ch changes the hashing</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  algorithm=2E It can be either SHA1 or SHA256=2E The default if not pro=
vided is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  SHA1 to p=
reserve backwards compatibility with existing configurations=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+- Restrict the supported `--x50=
9-username-field` extension fields to</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  subjectAltName and issuerAltName=2E Other extensions pr=
obably didn&#39;t work</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  anyway, and would cause OpenVPN to crash when a client connects=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+## Bugfixes</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+- Fix fingerprint calculation in mbed TLS builds=2E This means that =
mbed TLS users</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  of =
OpenVPN 2=2E4=2E0, v2=2E4=2E1 and v2=2E4=2E2 that rely on the values of the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `tls_digest_*` en=
v vars, or that use `--verify-hash` will have to change the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  fingerprint values they check aga=
inst=2E The security impact of the incorrect</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  calculation is very minimal; the last few bytes =
(max 4, typically 4) are not</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  verified by the fingerprint=2E We expect no real-world impact,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  because users that =
used this feature before will notice that it has suddenly</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  stopped working, and users that did=
n&#39;t will notice that connection setup fails</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  if they specify correct fingerprints=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+- Fix edge case with NCP when the server sen=
ds an empty PUSH_REPLY message back,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  and the client would not initialize it&#39;s data channe=
l crypto layer properly</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  (trac #903)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Fix SIGSEGV on unal=
igned buffer access on OpenBSD/Sparc64</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
- Fix TCP_NODELAY on OpenBSD</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Remove e=
rroneous limitation on max number of args for `--plugin`</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+- Fix NCP behaviour on TLS reconnect (Server would not se=
nd a proper &quot;cipher</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  =2E=2E=2E&quot; message back to the client, leading to client and se=
rver using different</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  ciphers) (trac #887)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Version 2=2E4=
=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+## Bugfixes</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+- Fix memory leak introduced in OpenVPN 2=2E4=2E1: if `--rem=
ote-cert-tls` is used,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  we leaked some memory on each TLS (re)negotiation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+## Security</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Fix a =
pre-authentication denial-of-service attack on both clients and servers=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  By sending a too-l=
arge control packet, OpenVPN 2=2E4=2E0 or v2=2E4=2E1 can be forced</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  to hit an ASSERT() and sto=
p the process=2E If `--tls-auth` or `--tls-crypt` is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  used, only attackers that have the `--t=
ls-auth` or `--tls-crypt` key can mount</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  an attack=2E (OSTIF/Quarkslab audit finding 5=2E1, CV=
E-2017-7478)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Fix a=
n authenticated remote DoS vulnerability that could be triggered by</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  causing a packet id roll =
over=2E An attack is rather inefficient; a peer would</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  need to get us to send at least about 1=
96 GB of data=2E (OSTIF/Quarkslab audit</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  finding 5=2E2, CVE-2017-7479)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# Version 2=2E4=2E1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `-=
-remote-cert-ku` now only requires the certificate to have at least the bit=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  set of one of th=
e values in the supplied list, instead of requiring an exact</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  match to one of the values in th=
e list=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--remot=
e-cert-tls` now only requires that a keyUsage is present in the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  certificate, and leaves the v=
erification of the value up to the crypto</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  library, which has more information (i=2Ee=2E the k=
ey exchange method in use) to</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  verify that the keyUsage is correct=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+- `--ns-cert-type` is deprecated=2E Use `--r=
emote-cert-tls` instead=2E The</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  nsCertType x509 extension is very old, and barely used=2E `--r=
emote-cert-tls`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  us=
es the far more common keyUsage and extendedKeyUsage extension instead=2E M=
ake</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  sure your cert=
ificates carry these to be able to use `--remote-cert-tls`=2E</span><br><sp=
an>diff --git a/Changes=2Erst b/Changes=2Erst</span><br><span>deleted file =
mode 100644</span><br><span>index fe81909=2E=2E0000000</span><br><span>--- =
a/Changes=2Erst</span><br><span>+++ /dev/null</span><br><span>@@ -1,1480 +0=
,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Overview of chan=
ges in 2=2E8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-User-visible Changes</span>=
<br><span>---------------------</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-Parsing Distinguished Names in certificates</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    (OpenSSL backend:) OpenVPN now rejects =
certificates that have a null-byte</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    inside any of the field values of their subject=2E To avoi=
d ambiguity in the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 parsed subject, OpenVPN escapes the following characters by prefixing them=
 with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a backslash:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * &quot; &quot; =
(space) at the start or end of a field,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     * &quot;#&quot; at the start of a field,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-     * &quot;,&quot;, &quot;+&quo=
t;, &quot;&quot;&quot;, &quot;\&quot;, &quot;&lt;&quot;, &quot;&gt;&quot; a=
nd &quot;;&quot; anywhere=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    As a resul=
t, if you use the option ``--verify-x509-name &lt;expected subject&gt;``,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    you need to prefix =
these characters with a backslash in your configuration=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    The subject passed to a ``--tls-ve=
rify`` script is escaped in the same way and</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    you may need to adjust your script=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    (Mbed TLS backend:) The behavior has not changed=
=2E Subjects with null-bytes were</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    already rejected (assuming OpenVPN was built with Mbed TLS =
3=2E5 or later) and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  the characters mentioned above were already escaped=2E However, the behav=
ior of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Mbed TLS is=
 slightly different from OpenSSL in that it also escapes &quot;=3D&quot;=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-Overview of changes in 2=2E7</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-New features</span><br><span>-------------</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-Multi-socket support for servers</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    OpenVPN servers now can listen on mu=
ltiple sockets at the same time=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    Multiple ``--local`` statements in the configuration can b=
e used to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    configur=
e this=2E This way the same server can e=2Eg=2E listen for UDP</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    and TCP connections at the sam=
e time, or listen on multiple addresses</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    and/or ports=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Clien=
t implementations for DNS options sent by server for Linux/BSD/macOS</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    Linux, BSD and macOS ver=
sions of OpenVPN now ship with a per-platform</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    default ``--dns-updown`` script that implements=
 proper handling of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  DNS configuration sent by the server=2E  The scripts should work on</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    systems that use ``syst=
emd`` or ``resolveconf`` to manage the DNS</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    setup, as well as raw ``/etc/resolv=2Econf`` files=
=2E However, the exact</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    features supported will depend on the configuration method=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    On Linux and MacOS this sh=
ould usually make split-DNS configurations</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    supported out-of-the-box now=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    Note that this new script will not be used by default if =
a ``--up``</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    script =
is already in use to reduce problems with</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    backwards compatibility=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    See documentation for ``--dns-updown`` and ``--dns`` for more d=
etails=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-New client implementation for DNS=
 options sent by server for Windows</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    The Windows client now uses NRPT (Name Resolution Policy =
Table) to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    handle D=
NS configurations=2E This adds support for split-DNS and DNSSEC</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    and improves the compatbility=
 with local DNS resolvers=2E Requires the</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    interactive service=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-On Windows the ``block-local`` flag is now enforced with WFP filters=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The ``block-local=
`` flag to ``--redirect-gateway`` and</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    ``--redirect-private`` is now also enforced via the Win=
dows Firewall,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mak=
ing sure packets can&#39;t be sent to the local network=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    This provides stronger protection =
against TunnelCrack-style attacks=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Window=
s network adapters are now generated on demand</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    This means that on systems that run multiple O=
penVPN connections at</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    the same time the users don&#39;t need to manually create enough networ=
k</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    adapters anymore=
 (in addition to the ones created by the installer)=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-Windows automatic service now runs as an unpriviledged user</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    All tasks that need p=
rivileges are now delegated to the interactive</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    service=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    **NOTE** this has the risk of breaking existing setup=
s if the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Windows c=
ertificate store is used (cryptoapi), and the certificates</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    are not readable for ``NT SERVICE\=
OpenVPNService``=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-Support for new version=
 of Linux DCO module</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   The OpenVPN DCO module has been merged into the Linux kernel as of</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    6=2E16=2E  This require=
d some API changes and OpenVPN 2=2E7 only supports</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    the new API=2E The new module is called ``=
ovpn``=2E Out-of-tree builds</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    for older kernels are available from</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    https://github=2Ecom/OpenVPN/ovpn-backports=
=2E Please</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    see the=
 release announcements for further information=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-Support for server mode in win-dco driver</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    On Windows the win-dco driver can now be use=
d in server setups=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Support for TLS clien=
t floating in DCO implementations</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    The kernel modules will detect clients floating to a new IP=
 address</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    and notif=
y userland so both data packets (kernel) and TLS packets</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    (sent by userland) can reach the new=
 client IP=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    (Act=
ual support depends on recent-enough kernel implementation)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-Enforcement of AES-GCM usage limit</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    OpenVPN will now enforce the usage limi=
ts on AES-GCM with the same</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    confidentiality margin as TLS 1=2E3 does=2E This mean that renego=
tiation will</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    be tr=
iggered after roughly 2^28 to 2^31 packets depending of the packet</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    size=2E More details about=
 usage limit of AES-GCM can be found here:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    https://datatracker=2Eietf=2Eorg/doc/draft-irtf-cfrg-aead-limits/</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-Epoch data keys and packet format</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    This introduces the epoch data f=
ormat for AEAD data channel</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ciphers in TLS mode ciphers=2E This new data format has a number =
of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    improvements ov=
er the standard &quot;DATA_V2&quot; format=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    - AEAD tag at the end of packet which is more hardware implementatio=
n</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      friendly</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    - Automatic key switcho=
ver when cipher usage limits are hit, similar to</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-      the epoch data keys in (D)TLS 1=2E3</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    - 64 bit instead of 32 b=
it packet ids to allow the data channel to be</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-      ready for 10 GBit/s without having frequent r=
enegotiation</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    - IV =
constructed with XOR instead of concatenation to not have (parts) of</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-      the real IV on the wir=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-Support for Epoch data channel on Windows=
, using the win-dco driver (2=2E8=2E0+)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Def=
ault ciphers in ``--data-ciphers``</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    Ciphers in ``--data-ciphers`` can contain the string DEFAU=
LT that is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    replace=
d by the default ciphers used by OpenVPN, making it easier to</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    add an allowed cipher without h=
aving to spell out the default ciphers=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-T=
LS alerts</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenVPN =
2=2E7 will send out TLS alerts to peers informing them if the TLS</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    session shuts down or when =
the TLS implementation informs the peer about</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    an error in the TLS session (e=2Eg=2E mismatchi=
ng TLS versions)=2E This improves</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    the user experience as the client shows an error instead of=
 running into</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a ti=
meout when the server just stops responding completely=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-Support for tun/tap via unix domain socket and lwipovpn supp=
ort</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    To allow bette=
r testing and emulating a full client with a full</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    network stack OpenVPN now allows a program =
executed to provide</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  a tun/tap device instead of opening a device=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    The co-developed lwipovpn program based on lwIP stack allows to<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    simulate full IP s=
tack=2E An OpenVPN client using</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    ``--dev-node unix:/path/to/lwipovpn`` can emulate a full clie=
nt that</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    can be pin=
ged, can serve a website and more without requiring any</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    elevated permission=2E This can make =
testing OpenVPN much easier=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    For more=
 details see</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    `lwip=
ovpn on Github &lt;https://github=2Ecom/OpenVPN/lwipovpn&gt;`_=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-Allow overriding username with ``--override-username=
``</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    This is intende=
d to allow using ``--auth-gen-token`` in scenarios where the</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    clients use certificates and mul=
ti-factor authentication=2E  This will</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    also generate a ``push &quot;auth-token-user newuserna=
me&quot;`` directive in</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    push replies=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-``--port-share`` now =
properly supports IPv6</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    Issues with logging of IPv6 addresses were fixed=2E The feature now al=
lows</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    IPv6 connecti=
ons towards the proxy receiver=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Support f=
or Haiku OS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-TLS1=2E3 support with mbedTLS (=
requires mbedTLS &gt;=3D 3=2E6=2E4)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-PUSH_UP=
DATE client support</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  It is now possible to update parts of the client-side configuration</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    (IP address, routes, MT=
U, DNS) by sending a new server-to-client</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    control message, ``PUSH_UPDATE,&lt;options&gt;``=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    See also: https:/=
/openvpn=2Egithub=2Eio/openvpn-rfc/openvpn-wire-protocol=2Ehtml</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    NOTE: PUSH_UPDATE client supp=
ort is currently disabled if DCO</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    is active (on all platforms)=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-PUSH_UPDATE server support (minimal)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    New management interface commands ``push-update-broa=
d`` and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``push-upd=
ate-cid`` to send PUSH_UPDATE option updates to all</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    clients (&quot;there is a new DNS serve=
r&quot;) or only a specific client ID</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    (&quot;privileges have changed, here&#39;s a new IP add=
ress&quot;)=2E  See</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  doc/management-notes=2Etxt</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    NOTE: PUSH_UPDATE server support is currently disabled if DCO</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    is active (on all pl=
atforms)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-Support for user-defined routin=
g tables on Linux</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
See the ``--route-table`` option in the manpage</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-PQE support for WolfSSL</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Two new enviro=
nment variables have been introduced to communicate desired</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    default gateway redirection to pl=
ugins like Network Manager,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ``route_redirect_gateway_ipv4`` and ``route_redirect_gateway_ipv6=
``=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    See the &quo=
t;Environmental Variables&quot; section in the man page</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-Improved logging of service events/errors to event log on Wind=
ows=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-&quot;Recursive Routing&quot; check =
is now more granular, and will only drop</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-   packets-in-tunnel if destination IP, protocol and por=
t matches with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   thos=
e needed to reach the VPN server=2E  With that change, you can now</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   use policies that direct &q=
uot;everything that is not OpenVPN&quot; into the</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   tunnel, and have IP packets to the VPN serve=
r address arrive as</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 expected (no such policies are currently installed by OpenVPN)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-   (GH: OpenVPN/openvpn#669)=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-COPYING: license details only relevant to o=
ur Windows installers have</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-   been updated and moved to the openvpn-build repo</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-Improved BYTECOUNT support - more strictly adhere to timing i=
nterval</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   requested, =
correctly support client and server counters with Linux and</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   Windows DCO offloading=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-Improve compatibility with OpenSSL 3=2E6=2E0 (do no=
t fail t_lpback selftest)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-New option ``--tl=
s-crypt-v2-max-age n`` to check tls-crypt-v2 timestamps</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   (When a client is older than n days or=
 has no timestamp, the server</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    will reject it)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedTLS 4 suppo=
rt has been added=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
  Note that with mbedTLS 4 algorithms need to be translated to</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   mbedTLS 4 internal IDs by OpenV=
PN, and some names might be</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   missing=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-Deprecated features</span><br><span>-------=
-------------</span><br><span style=3D"color: hsl(0, 100%, 40%);">-``secret=
`` support has been removed (by default)=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    static key mode (non-TLS) is no longer considered=
 &quot;good and secure enough&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    for today&#39;s requirements=2E  Use TLS mode instead=2E =
 If deploying a PKI CA</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    is considered &quot;too complicated&quot;, using ``--peer-fingerprint`=
` makes</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    TLS mode a=
bout as easy as using ``--secret``=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    T=
his mode can still be enabled by using</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ``--allow-deprecated-insecure-static-crypto`` but will=
 be removed in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Ope=
nVPN 2=2E8=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-Support for wintun Windows dr=
iver has been removed=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    OpenVPN 2=2E6 added support for the new dco-win driver, so it suppor=
ted</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    three differen=
t device drivers: dco-win, wintun, and tap-windows6=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    OpenVPN 2=2E7 now drops the support fo=
r wintun driver=2E By default</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    all modern configs should be supported by dco-win driver=2E In =
all</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    other cases Op=
enVPN will fall back automatically to tap-windows6</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    driver=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
NTLMv1 authentication support for HTTP proxies has been removed=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    This is considered an inse=
cure method of authentication that uses</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    obsolete crypto algorithms=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    NTLMv2 support is still available, but =
will be removed in a future</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    release=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   When configured to authenticate with NTLMv1 (``ntlm`` keyword in</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    ``--http-proxy``) OpenVPN=
 will try NTLMv2 instead=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-``persist-key``=
 option has been enabled by default=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    All the keys will be kept in memory across restart=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-OpenSSL 1=2E0=2E2 support has been removed=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Support for bu=
ilding with OpenSSL 1=2E0=2E2 has been removed=2E The minimum</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    supported OpenSSL version is no=
w 1=2E1=2E0=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-mbedTLS 2=2Ex support has be=
en removed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Support=
 for building with mbedTLS 2=2Ex has been removed (it is out</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    of support since March 2025, and=
 the necessary compatibility code</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    is making maintenance and support for mbedTLS 4=2Ex hard)=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The minimum su=
pported mbedTLS version is now 3=2E2=2E1=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-Compression on send has been removed=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    OpenVPN 2=2E7 will never compress data before sendin=
g=2E Decompression of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    received data is still supported=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    ``--allow-compression yes`` is now an alias for</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``--allow-compression a=
sym``=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-``--memstats`` feature removed</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    The ``--memstats`` op=
tion was largely undocumented and there is no known</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    user of this feature=2E  This feature p=
rovided very limited statistics</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    (number of users, link bytes read/written) and we do not exce=
pt any</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    usage becau=
se of this=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-Using ``--push`` in a mode th=
at is not ``--mode server`` will now print a</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    clear warning that this is an unsupported operat=
ion and might cause</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  negotiation failures=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-``--reneg-bytes``=
 and ``--reneg-packets`` do not work in DCO mode, and will</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    now print an appropriate warning=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-On-connect resolving of ``--remote`` ad=
dresses in ``--tcp-server`` mode</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    was not working since 2=2E4, so the code was completely remo=
ved=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-User-visible Changes</span><br><span>--------------------=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Default for ``--to=
pology`` changed to ``subnet`` for ``--mode server``=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  Previous releases always used ``net30``=
 as default=2E This only affects</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  configs with ``--mode server`` or ``--server`` (the latter imp=
lies the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  former), an=
d ``--dev tun``, and only if IPv4 is enabled=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  Note that this changes the semantics of ``--ifc=
onfig``, so if you have</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  manual settings for that in your config but not set ``--topology``</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  your config might fail t=
o parse with the new version=2E Just adding</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  ``--topology net30`` to the config should fix the p=
roblem=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  By default=
 ``--topology`` is pushed from server to client=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-- ``--x509-username-field`` will no longer automatically convert fi=
eldnames to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  uppercas=
e=2E This was deprecated since OpenVPN 2=2E4, and has now been removed=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-- ``--dh none`` is now the default if ``--d=
h`` is not specified=2E Modern TLS</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  implementations will prefer ECDH and other more modern algor=
ithms anyway=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  And =
finite field Diffie Hellman is in the proces of being deprecated</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  (see draft-ietf-tls-deprecate-=
obsolete-kex)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--lport 0`` does not impl=
y ``--bind`` anymore=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--redirect-gate=
way`` now works correctly if the VPN remote is not</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  reachable by the default gateway=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-- ``--show-gateway`` now supports querying the gate=
way for IPv4 addresses=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--static-chal=
lenge`` option now has a third parameter ``format`` that</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  can change how password and challenge =
response should be combined=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--key`` =
and ``--cert`` now accept URIs implemented in OpenSSL 3 as well as</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  optional OpenSSL 3 providers=
 loaded using ``--providers`` option=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- `=
`--cryptoapicert`` now supports issuer name as well as Windows CA template<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  name or OID as selec=
tor string=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-- TLS handshake debugging inf=
ormation contains much more details now when</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  using recent versions of OpenSSL=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-- The ``IV_PLAT_VER`` variable sent by Windows clients no=
w contains the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  full =
Windows build version to make it possible to determine the</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  Windows 10 or Windows 11 version use=
d=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-- The ``--windows-driver`` option to s=
elect between various windows</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  drivers will no longer do anything - it&#39;s kept so existing co=
nfigs</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  will not becom=
e invalid, but it is ignored with a warning=2E  The default</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  is now ``ovpn-dco`` if all options =
used are compatible with DCO, with</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  a fallback to ``tap-windows6``=2E  To force TAP (for example=
 because a</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  server pu=
shes DCO incompatible options), use the ``--disable-dco``</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  option=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-- Apply more checks to incoming TLS handshake packets before creating<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  new state - namely, =
verify message ID / acked ID for &quot;valid range for</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  an initial packet&quot;=2E  This fixes a=
 problem with clients that float</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  very early but send control channel packet from the pre-float =
IP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (Github: OpenVPN/=
openvpn#704)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-- Use of ``--dh dh2048=2Epe=
m`` in all sample configs has been replaced</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  with ``--dh none``=2E  The ``dh2048=2Epem`` file ha=
s been removed=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-- The startup delay in ``=
t_client=2Esh`` has been reduced from 3s to 1s,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  making a noticeable difference for setups with =
many tests=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-- Changed from using ``uncrus=
tify`` for code formatting and pre-commit checks</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  to ``clang-format``=2E  This reformatted quite=
 a bit of code, and requires</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  that regular committers change their pre-commit checks accordingly=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-- On Linux, on interfaces where applica=
ble, OpenVPN explicitly configures</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  the broadcast address again=2E  This was dropped for 2=2E6=
=2E0 &quot;because</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  c=
omputers are smart and can do it themselves&quot;, but the kernel netlink</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  interface isn&#39;t, =
and will install &quot;0=2E0=2E0=2E0&quot;=2E  This does not normally</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  matter, but for broadcast=
-based applications that get the address to</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  use from &quot;ifconfig&quot;, this change repairs =
functionality (this has</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  been backported to 2=2E6=2E15, but is not in earlier 2=2E6 versions)=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-- ``max-routes-per-client 0`` used to be s=
ilently upgraded to ``1``=2E  This</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  now produces an error=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- `=
`ifconfig`` and ``ifconfig-ipv6`` values are now stored in pre-connect</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  options cache, and will =
be restored to pre-connect values on reconnects</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  if the server stops pushing the respective opti=
on=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-- ``tapctl=2Eexe`` helper binary on W=
indows has been reworked to improve</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  help texts (making clear that it can not only do TAP-Adapte=
rs but</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Win-DCO as we=
ll), add printing of the hwid to all adapter outputs, and</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  change the default adapter type creat=
ed to ``ovpn-dco``=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- The default for ``m=
ultihome`` egress interface handling has changed=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  2=2E7=2E0 will default to ipi_ifindex=3D0=
, that is, leave the decision to the</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  routing/policy setup of the operating system=2E  The pre-2=
=2E7 behaviour</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (forc=
e egress =3D ingress interface) can be achieved with the new</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  ``--multihome same-interface`` sub=
-option=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-- Windows ``openvpn=2Eexe`` bina=
ry manifest now sets code page UTF8 - which</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  has no direct effect on OpenVPN itself, but this re=
pairs OpenSSL file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  l=
oading for key/cert files with non-ASCII characters in their file names</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  (GH: OpenVPN/openvpn#92=
0)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-- The ``test-crypto`` option no longe=
r requires a ``--secret`` argument and</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  will automatically generate a random key=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-- The configure-time option ``--enable-x509-alt-usernam=
e`` is no longer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  con=
ditional, and always-on (GH: OpenVPN/openvpn#917)=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Deprecated=
 features</span><br><span>--------------------</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-``--opt-verify`` feature removed</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    This option was already deprecated =
and it is now being converted to a</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    no-op=2E Using this option will only print a warning=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-Overview of changes in 2=2E6</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Project changes</span=
><br><span>----------------</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-We want to depr=
ecate our old Trac bug tracking system=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-Please report any issues with this release in GitHub</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-instead: https://github=
=2Ecom/OpenVPN/openvpn/issues</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-New features<=
/span><br><span>-------------</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-Support unlimited number of connection entries and remote entries</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-New management commands to enumerate and li=
st remote entries</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
Use ``remote-entry-count`` and ``remote-entry-get``</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    commands from the management interface =
to get the number of</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   remote entries and the entries themselves=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-Keying Material Exporters (RFC 5705) based key generation</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    As part of the cipher negotiat=
ion OpenVPN will automatically prefer</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    the RFC5705 based key material generation to the curren=
t custom</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenVPN P=
RF=2E This feature requires OpenSSL or mbed TLS 2=2E18+=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-Compatibility with OpenSSL in FIPS mode</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    OpenVPN will now work with OpenSSL in=
 FIPS mode=2E Note, no effort</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    has been made to check or implement all the</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    requirements/recommendation of FIPS 1=
40-2=2E This just allows OpenVPN</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    to be run on a system that be configured OpenSSL in FIPS mod=
e=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-``mlock`` will now check if enough mem=
lock-able memory has been reserved,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    and if less than 100MB RAM are available, use setrlimit()=
 to upgrade</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    the li=
mit=2E  See Trac #1390=2E  Not available on OpenSolaris=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-Certificate pinning/verify peer fingerprint</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    The ``--peer-fingerprint`` option=
 has been introduced to give users an</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    easy to use alternative to the ``tls-verify`` for match=
ing the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fingerprin=
t of the peer=2E The option takes use a number of allowed</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SHA256 certificate fingerprints=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    See the man page section &quot;Small Op=
enVPN setup with peer-fingerprint&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    for a tutorial on how to use this feature=2E This is =
also available online</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    under https://github=2Ecom/openvpn/openvpn/blob/master/doc/man-sections=
/example-fingerprint=2Erst</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-TLS mode with se=
lf-signed certificates</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    When ``--peer-fingerprint`` is used, the ``--ca`` and ``--capath`` opt=
ion</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    become optiona=
l=2E This allows for small OpenVPN setups without setting up</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    a PKI with Easy-RSA or similar s=
oftware=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-Deferred auth support for script=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The ``--auth-use=
r-pass-verify`` script supports now deferred authentication=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-Pending auth support for plugins and scripts</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    Both auth plugin and script =
can now signal pending authentication to</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    the client when using deferred authentication=2E The=
 new ``client-crresponse``</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    script option and ``OPENVPN_PLUGIN_CLIENT_CRRESPONSE`` plugin func=
tion can</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    be used t=
o parse a client response to a ``CR_TEXT`` two factor challenge=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    See ``sample/sample-scripts/totpauth=2Epy`` for=
 an example=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-Compatibility mode (``--comp=
at-mode``)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The mod=
ernisation of defaults can impact the compatibility of OpenVPN 2=2E6=2E0</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    with older peers=2E =
The options ``--compat-mode`` allows UIs to provide users</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    with an easy way to still connect t=
o older servers=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-OpenSSL 3=2E0 support</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenSSL 3=2E0 has be=
en added=2E Most of OpenSSL 3=2E0 changes are not user visible but</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    improve general compatibil=
ity with OpenSSL 3=2E0=2E ``--tls-cert-profile insecure``</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    has been added to allow selecting t=
he lowest OpenSSL security level (not</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    recommended, use only if you must)=2E OpenSSL 3=2E0 no =
longer supports the Blowfish</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    (and other deprecated) algorithm by default and the new option `=
`--providers``</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    all=
ows loading the legacy provider to renable these algorithms=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-Optional ciphers in ``--data-ciphers``</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    Ciphers in ``--data-ciphers`` can =
now be prefixed with a ``?`` to mark</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    those as optional and only use them if the SSL library s=
upports them=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-Improved ``--mssfix`` and ``--fragment`` calcula=
tion</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The ``--mssfi=
x`` and ``--fragment`` options now allow an optional :code:`mtu`</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    parameter to specify that di=
fferent overhead for IPv4/IPv6 should taken into</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    account and the resulting size is specified =
as the total size of the VPN packets</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    including IP and UDP headers=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-Cookie based handshake for UDP server</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    Instead of allocating a connection for each cli=
ent on the initial packet</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    OpenVPN server will now use an HMAC based cookie as its session id=
=2E This</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    way the s=
erver can verify it on completing the handshake without keeping</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    state=2E This eliminates the =
amplification and resource exhaustion attacks=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    For tls-crypt-v2 clients, this requires Open=
VPN 2=2E6 clients or later</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    because the client needs to resend its client key on completing th=
e hand</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    shake=2E Th=
e tls-crypt-v2 option allows controlling if older clients are</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    accepted=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    By default the rate of initial packet responses is limited=
 to 100 per 10s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
terval to avoid OpenVPN servers being abused in reflection attacks</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    (see ``--connect-freq-init=
ial``)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-Data channel offloading with ovpn=
-dco</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    2=2E6=2E0+ im=
plements support for data-channel offloading where the data packets</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    are directly processed an=
d forwarded in kernel space thanks to the ovpn-dco</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    kernel module=2E The userspace openvpn pro=
gram acts purely as a control plane</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    application=2E Note that DCO will use DATA_V2 packets in =
P2P mode, therefore,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   this implies that peers must be running 2=2E6=2E0+ in order to have P2P-=
NCP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    which brings D=
ATA_V2 packet support=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Session timeout</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    It is now possible t=
o terminate a session (or all) after a specified amount</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    of seconds has passed session commenc=
ement=2E This behaviour can be configured</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    using ``--session-timeout``=2E This option can be c=
onfigured on the server, on</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    the client or can also be pushed=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-Inline auth username and password</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    Username and password can now be specified inline in the=
 configuration file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  within the &lt;auth-user-pass&gt;&lt;/auth-user-pass&gt; tags=2E If the p=
assword is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    missing=
 OpenVPN will prompt for input via stdin=2E This applies to inline&#39;d</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    http-proxy-user-pass=
 too=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-Tun MTU can be pushed</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    The  client can now also dynami=
cally configure its MTU and the server</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    will try to push the client MTU when the client suppor=
ts it=2E The</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    direc=
tive ``--tun-mtu-max`` has been introduced to increase the maximum</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    pushable MTU size (default=
s to 1600)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-Dynamic TLS Crypt</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    When both peers are OpenVPN 2=
=2E6=2E1+, OpenVPN will dynamically create</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    a tls-crypt key that is used for renegotiation=2E =
This ensure that only the</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    previously authenticated peer can do trigger renegotiation and comp=
lete</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    renegotiation=
s=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-Improved control channel packet size c=
ontrol (``max-packet-size``)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    The size of control channel is no longer tied to</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    ``--link-mtu``/``--tun-mtu`` and =
can be set using ``--max-packet-size``=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    Sending large control channel frames is also optimi=
sed by allowing 6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
outstanding packets instead of just 4=2E ``max-packet-size`` will also set<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``mssfix`` to try =
to limit data-channel packets as well=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-De=
precated features</span><br><span>--------------------</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-``inetd`` has been removed</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    This was a very limited and not-w=
ell-tested way to run OpenVPN, on TCP</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    and TAP mode only=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-``=
verify-hash`` has been deprecated</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    This option has very limited usefulness and should be repla=
ced by either</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a be=
tter ``--ca`` configuration or with a ``--tls-verify`` script=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-``secret`` has been deprecated</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    static key mode (non-TLS) is no longer =
considered &quot;good and secure enough&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    for today&#39;s requirements=2E  Use TLS mode i=
nstead=2E  If deploying a PKI CA</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    is considered &quot;too complicated&quot;, using ``--peer-fi=
ngerprint`` makes</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
TLS mode about as easy as using ``--secret``=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-``ncp-disable`` has been removed</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    This option mainly served a role as debug option when N=
CP was first</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    intro=
duced=2E It should now no longer be necessary=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-TLS 1=2E0 and 1=2E1 are deprecated</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    ``tls-version-min`` is set to 1=2E2 by default=2E  O=
penVPN 2=2E6=2E0 defaults</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    to a minimum TLS version of 1=2E2 as TLS 1=2E0 and 1=2E1 should be =
generally</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    avoided=
=2E Note that OpenVPN versions older than 2=2E3=2E7 use TLS 1=2E0 only=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-``--cipher`` argument is no longer appended=
 to ``--data-ciphers``</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    by default=2E Data cipher negotiation has been introduced in 2=2E4=2E0=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    and been signific=
antly improved in 2=2E5=2E0=2E The implicit fallback</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    to the cipher specified in ``--cipher``=
 has been removed=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   Effectively, ``--cipher`` is a no-op in TLS mode now, and will</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    only have an effect in pre-=
shared-key mode (``--secret``)=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    From now on ``--cipher`` should not be used in new configur=
ations</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for TLS mod=
e=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Should backwa=
rds compatibility with older OpenVPN peers be</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    required, please see the ``--compat-mode`` inst=
ead=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-``--prng`` has beeen removed</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenVPN used to implement=
 its own PRNG based on a hash=2E However implementing</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    a PRNG is better left to a crypto libra=
ry=2E So we use the PRNG</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    mbed TLS or OpenSSL now=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-``--keysi=
ze`` has been removed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    The ``--keysize`` option was only useful to change the key length when =
using the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    BF, CAST=
6 or RC2 ciphers=2E For all other ciphers the key size is fixed with the</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    chosen cipher=2E As =
OpenVPN v2=2E6 no longer supports any of these variable length</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ciphers, this option was remov=
ed as well to avoid confusion=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Compressio=
n no longer enabled by default</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    Unless an explicit compression option is specified in the conf=
iguration,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``--all=
ow-compression`` defaults to ``no`` in OpeNVPN 2=2E6=2E0=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    By default, OpenVPN 2=2E5 still a=
llowed a server to enable compression by</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    pushing compression related options=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-PF (Packet Filtering) support has been removed</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-   The built-in PF functionalit=
y has been removed from the code base=2E This</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   feature wasn&#39;t really easy to use and was lo=
ng unmaintained=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
This implies that also ``--management-client-pf`` and any other compile</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   time or run time relat=
ed option do not exist any longer=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Option=
 conflict checking is being deprecated and phased out</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    The static option checking (OCC) is no =
longer useful in typical setups</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    that negotiate most connection parameters=2E The ``--opt-veri=
fy`` and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``--occ-d=
isable`` options are deprecated, and the configure option</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ``--enable-strict-options`` has bee=
n removed=2E Logging of mismatched</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    options has been moved to debug logging (verb 7)=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-User-visible Changes</span><br><span>------------=
---------</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- CHACHA20-P=
OLY1305 is included in the default of ``--data-ciphers`` when available=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Option ``--prng`` is=
 ignored as we rely on the SSL library random number generator=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-- Option ``--nobind`` is defaul=
t when ``--client`` or ``--pull`` is used in the configuration</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-- :code:`link_mtu` parameter is re=
moved from environment or replaced with 0 when scripts are</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  called with parameters=2E This param=
eter is unreliable and no longer internally calculated=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-- control channel packet maximum size is no longer influence=
d by</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--link-mtu``/=
``--tun-mtu`` and must be set by ``--max-packet-size`` now=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  The default is 1250 for the contr=
ol channel size=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-- In point-to-point Open=
VPN setups (no ``--server``), using</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  ``--explict-exit-notiy`` on one end would terminate the oth=
er side at</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  session e=
nd=2E  This is considered a no longer useful default and has</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  been changed to &quot;restart on r=
eception of explicit-exit-notify message&quot;=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  If the old behaviour is still desired, ``--re=
map-usr1 SIGTERM`` can be used=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- FreeBSD=
 tun interfaces with ``--topology subnet`` are now put into real</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  subnet mode (IFF_BROADCAST ins=
tead of IFF_POINTOPOINT) - this might upset</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  software that enumerates interfaces, looking for &q=
uot;broadcast capable?&quot; and</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  expecting certain results=2E  Normal uses should not see any d=
ifference=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-- The default configurations w=
ill no longer allow connections to OpenVPN 2=2E3=2Ex</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  peer or earlier, use the new ``--compat-m=
ode`` option if you need</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  compatibility with older versions=2E See the manual page on the</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--compat-mode`` for deta=
ils=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-- The ``client-pending-auth`` manage=
ment command now requires also the</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  key id=2E The management version has been changed to 5 to in=
dicate this change=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- (OpenVPN 2=2E6=2E2)=
 A client will now refuse a connection if pushed compression</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  settings will contradict the setti=
ng of allow-compression as this almost</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  always results in a non-working connection=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-- The &quot;kill&quot; by addr management command now=
 requires also the protocol</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  as string e=2Eg=2E &quot;udp&quot;, &quot;tcp&quot;=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-Common errors with OpenSSL 3=2E0 and OpenVPN 2=2E6</spa=
n><br><span>-----------------------------------------------</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-Both OpenVPN 2=2E6 and OpenSSL 3=2E0 =
tighten the security considerable, so some</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-configuration will no longer work=2E This section will=
 cover the most common</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-causes and error message we have seen and explain their reason and tempora=
ry</span><br><span style=3D"color: hsl(0, 100%, 40%);">-workarounds=2E You =
should fix the underlying problems as soon as possible since</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-these workaround are not secure and =
will eventually stop working in a future</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-update=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- weak SHA1 or=
 MD5 signature on certificates</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This will =
happen on either loading of certificates or on connection</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  to a server::</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      OpenSSL: error:0A00018E:SSL routines::ca md too weak</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      Cannot load certifica=
te file cert=2Ecrt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
   Exiting due to fatal error</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  OpenSSL 3=
=2E0 no longer allows weak signatures on certificates=2E You can</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  downgrade your security to all=
ow them by using ``--tls-cert-profile insecure``</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  but should replace/regenerate these certificat=
es as soon as possible=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-- 1024 bit RSA certificates, 1024 bit =
DH parameters, other weak keys</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This happe=
ns if you use private keys or other cryptographic material that</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  does not meet today&#39;s crypt=
ographic standards anymore=2E Messages are similar</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  to::</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      O=
penSSL: error:0A00018F:SSL routines::ee key too small</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      OpenSSL: error:1408518A:SSL routines:=
ssl3_ctx_ctrl:dh key too small</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  DH paramet=
ers (``--dh``) can be regenerated with ``openssl dhparam 2048``=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  For other cryptographic keys=
, these keys and certificates need to be</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  regenerated=2E TLS Security level can be temporarily l=
owered with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--tls-=
cert-profile legacy`` or even ``--tls-cert-profile insecure``=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-- Connecting to a OpenVPN 2=2E3=2Ex server or allowin=
g OpenVPN 2=2E3=2Ex or earlier</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  clients</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  This will normally res=
ult in messages like::</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     OPTIONS ERROR: =
failed to negotiate cipher with server=2E  Add the server&#39;s cipher (&#3=
9;AES-128-CBC&#39;) to --data-ciphers (currently &#39;AES-256-GCM:AES-128-G=
CM:CHACHA20-POLY1305&#39;) if you want to connect to this server=2E</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-     or</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     clien=
t/127=2E0=2E0=2E1:49954 SENT CONTROL [client]: &#39;AUTH_FAILED,Data channe=
l cipher negotiation failed (no shared cipher)&#39; (status=3D1)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  You can manually add the missing cipher to the ``--=
data-ciphers``=2E The</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  standard ciphers should be included as well, e=2Eg=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  ``--data-ciphers AES-256-GCM:AES-128-GC=
M:?Chacha20-Poly1305:?AES-128-CBC``=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  You can also use the ``--compat-mode`` option=2E Note th=
at these message may</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 also indicate other cipher configuration problems=2E See the data channel<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  cipher negotiation m=
anual section for more details=2E (Available online under</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  https://github=2Ecom/OpenVPN/openvpn/=
blob/master/doc/man-sections/cipher-negotiation=2Erst)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-- Use of a legacy or deprecated cipher (e=2Eg=2E 64bit block ci=
phers)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  OpenSSL 3=2E0 no longer supports a=
 number of insecure and outdated ciphers in</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  its default configuration=2E Some of these ciphers =
are known to be vulnerable (SWEET32 attack)=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  This will typically manifest itself in messages like::</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      OpenSSL: error:0308010C:digital envelope routines::=
unsupported</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      Ciph=
er algorithm &#39;BF-CBC&#39; not found</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      Unsupported cipher in --data-ciphers: BF-CBC</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  If your OpenSSL distribution comes with the leg=
acy provider (see</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  al=
so ``man OSSL_PROVIDER-legacy``), you can load it with</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  ``--providers legacy default``=2E  This =
will re-enable the old algorithms=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Open=
VPN version not supporting TLS 1=2E2 or later</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  The default in OpenVPN 2=2E6 and also in many distributions is now TLS=
 1=2E2 or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  later=2E C=
onnecting to a peer that does not support this will results in</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  messages like::</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    TLS error: Unsupported protocol=2E This typically indic=
ates that client and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   server have no common TLS version enabled=2E This can be caused by misma=
tched</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls-version-=
min and tls-version-max options on client and server=2E If your</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    OpenVPN client is between v2=
=2E3=2E6 and v2=2E3=2E2 try adding tls-version-min 1=2E0</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    to the client configuration to use T=
LS 1=2E0+ instead of TLS 1=2E0 only</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    OpenSSL: error:0A000102:SSL routines::unsupported protoco=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  This can be an OpenVPN 2=2E3=2E6 or ear=
lier version=2E ``compat-version 2=2E3=2E0`` will</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  enable TLS 1=2E0 support if supported by the =
OpenSSL distribution=2E Note that</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  on some Linux distributions enabling TLS 1=2E1 or 1=2E0 is no=
t possible=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-Overview of changes in 2=2E5</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-New features</span><br><spa=
n>-------------</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Client=
-specific tls-crypt keys (``--tls-crypt-v2``)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    ``tls-crypt-v2`` adds the ability to supply eac=
h client with a unique</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    tls-crypt key=2E  This allows large organisations and VPN providers to=
 profit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    from the s=
ame DoS and TLS stack protection that small deployments can</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    already achieve using ``tls-auth`=
` or ``tls-crypt``=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ChaCha20-Poly1305 cip=
her support</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Added =
support for using the ChaCha20-Poly1305 cipher in the OpenVPN data</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    channel=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-Improved Data channel cipher negotiation</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    The option ``ncp-ciphers`` has been=
 renamed to ``data-ciphers``=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    The old name is still accepted=2E The change in name signals =
that</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``data-cipher=
s`` is the preferred way to configure data channel</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ciphers and the data prefix is chosen to a=
void the ambiguity that</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    exists with ``--cipher`` for the data cipher and ``tls-cipher``</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    for the TLS ciphers=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    OpenVPN clients will now signal all sup=
ported ciphers from the</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ``data-ciphers`` option to the server via ``IV_CIPHERS``=2E OpenVPN</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    servers will select=
 the first common cipher from the ``data-ciphers``</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    list instead of blindly pushing the first =
cipher of the list=2E This</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    allows to use a configuration like</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    ``data-ciphers ChaCha20-Poly1305:AES-256-GCM`` on=
 the server that</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p=
refers ChaCha20-Poly1305 but uses it only if the client supports it=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    See the data channel negotiation section in=
 the manual for more details=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Removal of =
BF-CBC support in default configuration:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    By default OpenVPN 2=2E5 will only accept AES-256-GC=
M and AES-128-GCM as</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   data ciphers=2E OpenVPN 2=2E4 allows AES-256-GCM,AES-128-GCM and BF-CBC =
when</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    no --cipher a=
nd --ncp-ciphers options are present=2E Accepting BF-CBC can be</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    enabled by adding</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        data-ciphers AES-256-GCM:AES-128-GCM:BF-CBC</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    and when you need to support very old p=
eers also</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        data-ciphers-fallback BF-=
CBC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    To offer backwards compatibility wi=
th older configs an *explicit*</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ciph=
er BF-CBC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    in the configuration will be =
automatically translated into adding BF-CBC</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    to the data-ciphers option and setting data-ciphe=
rs-fallback to BF-CBC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    (as in the example commands above)=2E We strongly recommend to switchin=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    away from BF-CBC=
 to a more secure cipher=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Asynchronous (d=
eferred) authentication support for auth-pam plugin=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    See src/plugins/auth-pam/README=2Eauth=
-pam for details=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-Deferred client-connect=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The ``--client-co=
nnect`` option and the connect plugin API allow</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    asynchronous/deferred return of the configura=
tion file in the same way</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    as the auth-plugin=2E</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Faster connec=
tion setup</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    A clien=
t will signal in the ``IV_PROTO`` variable that it is in pull</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    mode=2E This allows the server =
to push the configuration options to</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    the client without waiting for a ``PULL_REQUEST`` messag=
e=2E The feature</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
s automatically enabled if both client and server support it and</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    significantly reduces the co=
nnection setup time by avoiding one</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    extra packet round-trip and 1s of internal event delays=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-Netlink support</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    On Linux, if configured without ``--ena=
ble-iproute2``, configuring IP</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    addresses and adding/removing routes is now done via the netli=
nk(3)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    kernel inter=
face=2E  This is much faster than calling ``ifconfig`` or</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ``route`` and also enables OpenVPN =
to run with less privileges=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    If confi=
gured with --enable-iproute2, the ``ip`` command is used</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    (as in 2=2E4)=2E  Support for ``ifco=
nfig`` and ``route`` is gone=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Wintun supp=
ort</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    On Windows, Op=
enVPN can now use ``wintun`` devices=2E  They are faster</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    than the traditional ``tap9`` tun/ta=
p devices, but do not provide</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ``--dev tap`` mode - so the official installers contain both=2E=
  To use</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a wintun =
device, add ``--windows-driver wintun`` to your config</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    (and use of the interactive service is=
 required as wintun needs</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    SYSTEM privileges to enable access)=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-IPv6-only operation</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    It is now possible to have only IPv6 addresses inside the VPN tunnel,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    and IPv6-only add=
ress pools (2=2E4 always required IPv4 config/pools</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    and IPv6 was the &quot;optional extra&q=
uot;)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-Improved Windows 10 detection</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    Correctly log OS on Wi=
ndows 10 now=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-Linux VRF support</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    Using the new ``--bind-dev`=
` option, the OpenVPN outside socket can</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    now be put into a Linux VRF=2E  See the &quot;Virtua=
l Routing and Forwarding&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    documentation in the man page=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-TLS 1=2E3 support</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   TLS 1=2E3 support has been added to OpenVPN=2E  Currently, this requires=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenSSL 1=2E1=2E1=
+=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The options `=
`--tls-ciphersuites`` and ``--tls-groups`` have been</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    added to fine tune TLS protocol options=
=2E  Most of the improvements</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    were also backported to OpenVPN 2=2E4 as part of the maintainan=
ce</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    releases=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-Support setting DHCP search domain</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    A new option ``--dhcp-option =
DOMAIN-SEARCH my=2Eexample=2Ecom`` has been</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    defined, and Windows support for it is implemente=
d (tun/tap only, no</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  wintun support yet)=2E  Other platforms need to support this via ``--up``=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    script (Linux) or=
 GUI (OSX/Tunnelblick)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-per-client changi=
ng of ``--data-ciphers`` or ``data-ciphers-fallback``</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    from client-connect script/dir (NOTE: t=
his only changes preference of</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    ciphers for NCP, but can not override what the client announce=
s as</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;willing=
 to accept&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-Handle setting of tun/tap=
 interface MTU on Windows</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    If IPv6 is in use, MTU must be &gt;=3D 1280 (Windows enforces IETF =
requirements)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-Add support for OpenSSL engin=
es to access private key material (like TPM)=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-HMAC based auth-token support</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    The ``--auth-gen-token`` support has been improved and now=
 generates HMAC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ba=
sed user token=2E If the optional ``--auth-gen-token-secret`` option is</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    used clients will be =
able to seamlessly reconnect to a different server</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    using the same secret file or to the same =
server after a server restart=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Improved s=
upport for pending authentication</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    The protocol has been enhanced to be able to signal that</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    the authentication s=
hould use a secondary authentication</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    via web (like SAML) or a two factor authentication witho=
ut</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    disconnecting t=
he OpenVPN session with AUTH_FAILED=2E The</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    session will instead be stay in a authenticated st=
ate and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wait for t=
he second factor authentication to complete=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    This feature currently requires usage of the managent interface</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    on both client and se=
rver side=2E See the ``management-notes=2Etxt``</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ``client-pending-auth`` and ``cr-response`` c=
ommands for more</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    d=
etails=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-VLAN support</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    OpenVPN servers in TAP mode can now us=
e 802=2E1q tagged VLANs</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    on the TAP interface to separate clients into different groups</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    that can then be handled=
 differently (different subnets / DHCP,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    firewall zones, =2E=2E=2E) further down the network=
=2E  See the new</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=
ptions ``--vlan-tagging``, ``--vlan-accept``, ``--vlan-pvid``=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    802=2E1q tagging on the client side TAP interface=
 is not handled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    to=
day (=3D tags are just forwarded transparently to the server)=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-Support building of =2Emsi installers for Windows</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-Allow unicode search string in ``--cryptoapice=
rt`` option (Windows)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Support IPv4 configs =
with /31 netmasks now</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    (By no longer trying to configure ``broadcast x=2Ex=2Ex=2Ex`` in</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ifconfig calls, /31 supp=
ort &quot;just works&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-New option ``--=
block-ipv6`` to reject all IPv6 packets (ICMPv6)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    this is useful if the VPN service has no IPv=
6, but the clients</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 might have (LAN), to avoid client connections to IPv6-enabled</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    servers leaking &quot;around&q=
uot; the IPv4-only VPN=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-``--ifconfig-ipv6=
`` and ``--ifconfig-ipv6-push`` will now accept</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    hostnames and do a DNS lookup to get the IPv6=
 address to use</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-Deprecated features</span><br><span>------------=
--------</span><br><span style=3D"color: hsl(0, 100%, 40%);">-For an up-to-=
date list of all deprecated options, see this wiki page:</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-https://community=2Eopenvpn=2Enet/openvp=
n/wiki/DeprecatedOptions</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``ncp-disable`` =
has been deprecated</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  With the improved and matured data channel cipher negotiation, the use</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    of ``ncp-disable`` s=
hould not be necessary anymore=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``inetd=
`` has been deprecated</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  This is a very limited and not-well-tested way to run OpenVPN, on TCP</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  and TAP mode only, whi=
ch complicates the code quite a bit for little gain=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  To be removed in OpenVPN 2=2E6 (unless u=
sers protest)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``no-iv`` has been remov=
ed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This option was m=
ade into a NOOP option with OpenVPN 2=2E4=2E  This has now</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  been completely removed=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-- ``--client-cert-not-required`` has been removed</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  This option will now c=
ause server configurations to not start=2E  Use</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  ``--verify-client-cert none`` instead=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-- ``--ifconfig-pool-linear`` has been removed</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  This option is removed=
=2E  Use ``--topology p2p`` or ``--topology subnet``</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  instead=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-- ``--compress xxx`` is considered risky and is warned against, see below=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-- ``--key-method 1`` has been removed</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-User-visible Changes</span><br><span>---------------------</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-- If multiple connect handl=
ers are used (client-connect, ccd, connect</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  plugin) and one of the handler succeeds but a subseq=
uent fails, the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  clie=
nt-disconnect-script is now called immediately=2E Previously it</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  was called, when the VPN sessio=
n was terminated=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Support for building =
with OpenSSL 1=2E0=2E1 has been removed=2E The minimum</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  supported OpenSSL version is now 1=2E0=
=2E2=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-- The GET_CONFIG management state i=
s omitted if the server pushes</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  the client configuration almost immediately as result of the</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  faster connection setup=
 feature=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-- ``--compress`` is nowadays co=
nsidered risky, because attacks exist</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  leveraging compression-inside-crypto to reveal plaintext =
(VORACLE)=2E  So</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  by =
default, ``--compress xxx`` will now accept incoming compressed</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  packets (for compatibility with=
 peers that have not been upgraded yet),</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  but will not use compression outgoing packets=2E  This=
 can be controlled with</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  the new option ``--allow-compression yes|no|asym``=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-- Stop changing ``--txlen`` aways from OS defaults unless ex=
plicitly specified</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  i=
n config file=2E  OS defaults nowadays are actually larger then what we use=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  to configure, so o=
ur defaults sometimes caused packet drops =3D bad performance=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-- remove ``--writepid`` pid file on exit now</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-- plugin-auth-pam now logs via OpenVPN logging meth=
od, no longer to stderr</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  (this means you&#39;ll have log messages in syslog or openvpn log file =
now)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-- use ISO 8601 time format for file ba=
sed logging now (YYYY-MM-DD hh:mm:dd)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  (syslog is not affected, nor is ``--machine-readable-outp=
ut``)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-- ``--clr-verify`` now loads all CRLs=
 if more than one CRL is in the same</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  file (OpenSSL backend only, mbedTLS always did that)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-- when ``--auth-user-pass file`` has no password=
, and the management interface</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  is active, query management interface (instead of trying console=
 query,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  which does n=
ot work on windows)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-- skip expired certific=
ates in Windows certificate store (``--cryptoapicert``)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-- ``--socks-proxy`` + ``--proto udp*`` will now allways use IP=
v4, even if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  IPv6 is =
requested and available=2E  Our SOCKS code does not handle IPv6+UDP,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  and before that change it =
would just fail in non-obvious ways=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- TC=
P listen() backlog queue is now set to 32 - this helps TCP servers that</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  receive lots of &quot;i=
nvalid&quot; connects by TCP port scanners</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
- do no longer print OCC warnings (&quot;option mismatch&quot;) about ``key=
-method``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``keydir`=
`, ``tls-auth`` and ``cipher`` - these are either gone now, or</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  negotiated, and the warnings do =
not serve a useful purpose=2E</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``dhcp-opti=
on DNS`` and ``dhcp-option DNS6`` are now treated identically</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  (=3D both accept an IPv4 or IPv6 =
address for the nameserver)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-Maintainer-visible changes</span><br=
><span>---------------------------</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-- the man page is now in maintained in =2Erst format, so build=
ing the openvpn=2E8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
manpage from a git checkout now requires python-docutils (if this is missin=
g,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the manpage will =
not be built - which is not considered an error generally,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  but for package builders or ``make d=
istcheck`` it is)=2E  Release tarballs</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  contain the openvpn=2E8 file, so unless some =2Erst is c=
hanged, doc-utils are</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  not needed for building=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- OCC support =
can no longer be disabled</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- AEAD support is=
 now required in the crypto library</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--d=
isable-server`` has been removed from configure (so it is no longer</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  possible to build a client-=
/p2p-only OpenVPN binary) - the saving in code</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  size no longer outweighs the extra maintenance e=
ffort=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-- ``--enable-iproute2`` will disab=
le netlink(3) support, so maybe remove</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  that from package building configs (see above)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-- support building with MSVC 2019</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-- cmocka based unit tests are now only run if cmocka is insta=
lled externally</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (2=
=2E4 used to ship a local git submodule which was painful to maintain)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-- ``--disable-crypto`` configure option has bee=
n removed=2E  OpenVPN is now always</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  built with crypto support, which makes the code much easier=
 to maintain=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This=
 does not affect ``--cipher none`` to do a tunnel without encryption=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-- ``--disable-multi`` configure option has bee=
n removed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
Overview of changes in 2=2E4</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-New features</span><br><span>-------------</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-Seamless client IP/port floati=
ng</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Added new packe=
t format P_DATA_V2, which includes peer-id=2E If both the</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    server and client support it, the c=
lient sends all data packets in</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    the new format=2E When a data packet arrives, the server iden=
tifies peer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    by pee=
r-id=2E If peer&#39;s ip/port has changed, server assumes that</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    client has floated, verifies H=
MAC and updates ip/port in internal structs=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    This allows the connection to be immediately r=
estored, instead of requiring</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    a TLS handshake before the server accepts packets from the new =
client</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ip/port=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-Data channel cipher negotiation</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    Data channel ciphers (``--cip=
her``) are now by default negotiated=2E  If a</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    client advertises support for Negotiable Crypto=
 Parameters (NCP), the</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    server will choose a cipher (by default AES-256-GCM) for the data chan=
nel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    and tell the =
client to use that cipher=2E  Data channel cipher negotiation</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    can be controlled using ``--ncp=
-ciphers`` and ``--ncp-disable``=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    A m=
ore limited version also works in client-to-server and server-to-client</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    scenarios where one o=
f the end points uses a v2=2E4 client or server and the</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    other side uses an older version=2E  =
In such scenarios the v2=2E4 side will</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    change to the ``--cipher`` set by the remote side, if =
permitted by by</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``=
--ncp-ciphers``=2E  For example, a v2=2E4 client with ``--cipher BF-CBC``</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    and ``ncp-ciphers A=
ES-256-GCM:AES-256-CBC`` can connect to both a v2=2E3</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    server with ``cipher BF-CBC`` as well a=
s a server with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``=
cipher AES-256-CBC`` in its config=2E  The other way around, a v2=2E3 clien=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    with either ``ci=
pher BF-CBC`` or ``cipher AES-256-CBC`` can connect to a</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    v2=2E4 server with e=2Eg=2E ``cipher=
 BF-CBC`` and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``nc=
p-ciphers AES-256-GCM:AES-256-CBC`` in its config=2E  For this to work</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    it requires that OpenV=
PN was built without disabling OCC support=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-AEAD (GCM) data channel cipher support</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    The data channel now supports AEAD ciphers (current=
ly only GCM)=2E  The AEAD</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    packet format has a smaller crypto overhead than the CBC packet for=
mat,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    (e=2Eg=2E 20 =
bytes per packet for AES-128-GCM instead of 36 bytes per packet</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    for AES-128-CBC + HMAC-SHA1)=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-ECDH key exchange</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    The TLS control channel now supports fo=
r elliptic curve diffie-hellmann</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    key exchange (ECDH)=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Impro=
ved Certificate Revocation List (CRL) processing</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    CRLs are now handled by the crypto library (=
OpenSSL or mbed TLS), instead</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    of inside OpenVPN itself=2E  The crypto library implementations=
 are more</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strict t=
han the OpenVPN implementation was=2E  This might reject peer</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    certificates that would previou=
sly be accepted=2E  If this occurs, OpenVPN</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    will log the crypto library&#39;s error descripti=
on=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-Dualstack round-robin DNS client conn=
ect</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Instead of onl=
y using the first address of each ``--remote`` OpenVPN</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    will now try all addresses (IPv6 and I=
Pv4) of a ``--remote`` entry=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Support for=
 providing IPv6 DNS servers</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    A new DHCP sub-option ``DNS6`` is added alongside with the alread=
y existing</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``DNS``=
 sub-option=2E  This is used to provide DNS resolvers available over</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    IPv6=2E  This may be pus=
hed to clients where `` --up`` scripts and ``--plugin``</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    can act upon it through the ``foreign=
_option_&lt;n&gt;`` environment variables=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    Support for the Windows client picking up this new sub-option is adde=
d,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    however IPv6 DN=
S resolvers need to be configured via ``netsh`` which requires</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    administrator privileges unles=
s the new interactive services on Windows is</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    being used=2E  If the interactive service is use=
d, this service will execute</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    ``netsh`` in the background with the proper privileges=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-New improved Windows Background service</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    The new OpenVPNService is b=
ased on openvpnserv2, a complete rewrite of the OpenVPN</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    service wrapper=2E It is intended for=
 launching OpenVPN instances that should be</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    up at all times, instead of being manually launch=
ed by a user=2E OpenVPNService is</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    able to restart individual OpenVPN processes if they crash,=
 and it also works</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 properly on recent Windows versions=2E OpenVPNServiceLegacy tends to work =
poorly,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if at all,=
 on newer Windows versions (8+) and its use is not recommended=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-New interactive Windows service</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    The installer starts OpenVPNServiceInt=
eractive automatically and configures</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    it to start	at system startup=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    The interactive Windows service allows unprivileged users to=
 start</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenVPN con=
nections in the global config directory (usually</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    C:\\Program Files\\OpenVPN\\config) using Op=
enVPN GUI without any</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    extra configuration=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Users who be=
long to the built-in Administrator group or to the</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    local &quot;OpenVPN Administrator&quot; gr=
oup can also store configuration</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    files under %USERPROFILE%\\OpenVPN\\config for use with the<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    interactive servic=
e=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-redirect-gateway ipv6</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    OpenVPN has now feature parity bet=
ween IPv4 and IPv6 for redirect</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    gateway including the handling of overlapping IPv6 routes wit=
h</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    IPv6 remote VPN =
server address=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-LZ4 Compression and pusha=
ble compression</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Ad=
ditionally to LZO compression OpenVPN now also supports LZ4 compression=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Compression option=
s are now pushable from the server=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Filte=
r pulled options client-side: pull-filter</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    New option to explicitly allow or reject options pu=
shed by the server=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    May be used multiple times and is applied in the order specified=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-Per-client remove push options: push-remove</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    New option to remove=
 options on a per-client basis from the &quot;push&quot; list</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    (more fine-grained than ``--pus=
h-reset``)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-Http proxy password inside co=
nfig file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Http pro=
xy passwords can be specified with the inline file option</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ``&lt;http-proxy-user-pass&gt;`` =
=2E=2E ``&lt;/http-proxy-user-pass&gt;``</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Wi=
ndows version detection</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    Windows version is detected, logged and possibly signalled to server<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    (IV_PLAT_VER=3D&lt=
;nn&gt; if ``--push-peer-info`` is set on client)=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-Authentication tokens</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    In situations where it is not suitable to save user password=
s on the client,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    O=
penVPN has support for pushing a --auth-token since v2=2E3=2E  This option =
is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pushed from the=
 server to the client with a token value to be used instead</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    of the users password=2E  For thi=
s to work, the authentication plug-in would</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    need to implement this support as well=2E  In Ope=
nVPN 2=2E4 --auth-gen-token</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    is introduced, which will allow the OpenVPN server to generate a =
random</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    token and p=
ush it to the client without any changes to the authentication</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    modules=2E  When the clients n=
eed to re-authenticate the OpenVPN server will</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    do the authentication internally, instead of s=
ending the re-authentication</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    request to the authentication module =2E  This feature is especi=
ally</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    useful in con=
figurations which use One Time Password (OTP) authentication</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    schemes, as this allows the tunn=
el keys to be renegotiated regularly without</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    any need to supply new OTP codes=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-keying-material-exporter</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    Keying Material Exporter [RFC-5705] allow additi=
onal keying material to be</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    derived from existing TLS channel=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-Android platform support</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    Support for running on Android using Android&#39;s VPNService API=
 has been added=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 See doc/android=2Etxt for more details=2E This support is primarily used i=
n</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    the OpenVPN for =
Android app (https://github=2Ecom/schwabe/ics-openvpn)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-AIX platform support</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    AIX platform support has been added=2E The support only incl=
udes tap</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    devices s=
ince AIX does not provide tun interface=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
Control channel encryption (``--tls-crypt``)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    Use a pre-shared static key (like the ``--tls-au=
th`` key) to encrypt control</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    channel packets=2E  Provides more privacy, some obfuscation and =
poor-man&#39;s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pos=
t-quantum security=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Asynchronous push rep=
ly</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Plug-ins provid=
ing support for deferred authentication can benefit from a more</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    responsive authentication whe=
re the server sends PUSH_REPLY immediately once</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    the authentication result is ready, instead o=
f waiting for the client to</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    to send PUSH_REQUEST once more=2E  This requires OpenVPN to be bu=
ilt with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``=2E/con=
figure --enable-async-push``=2E  This is a compile-time only switch=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-Deprecated features</span><br><span>--------------------</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-For an up-to-date list of all dep=
recated options, see this wiki page:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-https://community=2Eopenvpn=2Enet/openvpn/wiki/DeprecatedOpt=
ions</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-- ``--key-method 1`` is deprecated in =
OpenVPN 2=2E4 and will be removed in v2=2E5=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  Migrate away from ``--key-method 1`` as soon as =
possible=2E  The recommended</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  approach is to remove the ``--key-method`` option from the configu=
ration</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  files, OpenVP=
N will then use ``--key-method 2`` by default=2E  Note that this</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  requires changing the option i=
n both the client and server side configs=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-- ``--tls-remote`` is removed in OpenVPN 2=2E4, as indicated in the v2=2E=
3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  man-pages=2E  Simi=
lar functionality is provided via ``--verify-x509-name``,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  which does the same job in a better w=
ay=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-- ``--compat-names`` and ``--no-name-=
remapping`` were deprecated in OpenVPN 2=2E3</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  and will be removed in v2=2E5=2E  All scripts and =
plug-ins depending on the old</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  non-standard X=2E509 subject formatting must be updated to the st=
andardized</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  formattin=
g=2E  See the man page for more information=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-- ``--no-iv`` is deprecated in OpenVPN 2=2E4 and will be removed in v2=
=2E5=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-- ``--keysize`` is deprecated in Op=
enVPN 2=2E4 and will be removed in v2=2E6</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  together with the support of ciphers with cipher bloc=
k size less than</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  128=
-bits=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-- ``--comp-lzo`` is deprecated in =
OpenVPN 2=2E4=2E  Use ``--compress`` instead=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-- ``--ifconfig-pool-linear`` has been deprecated since OpenVPN 2=2E1 a=
nd will be</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  removed i=
n v2=2E5=2E  Use ``--topology p2p`` instead=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-- ``--client-cert-not-required`` is deprecated in OpenVPN 2=2E4 and wil=
l be removed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  in v2=
=2E5=2E  Use ``--verify-client-cert none`` for a functional equivalent=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-- ``--ns-cert-type`` is deprecated in OpenV=
PN 2=2E3=2E18 and v2=2E4=2E  It will be removed</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  in v2=2E5=2E  Use the far better ``--remote-cer=
t-tls`` option which replaces this</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  feature=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-User-visible Changes</span><br><span>-=
--------------------</span><br><span style=3D"color: hsl(0, 100%, 40%);">--=
 When using ciphers with cipher blocks less than 128-bits,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  OpenVPN will complain loudly if the =
configuration uses ciphers considered</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  weak, such as the SWEET32 attack vector=2E  In such scena=
rios, OpenVPN will by</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  default renegotiate for each 64MB of transported data (``--reneg-bytes``)=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This renegotiati=
on can be disabled, but is HIGHLY DISCOURAGED=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-- For certificate DNs with duplicate fields, e=2Eg=2E &quot;OU=3Done,=
OU=3Dtwo&quot;, both fields</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  are now exported to the environment, where each second and later oc=
currence</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  of a field =
get _$N appended to it&#39;s field name, starting at N=3D1=2E  For the</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  example above, that woul=
d result in e=2Eg=2E X509_0_OU=3Done, X509_0_OU_1=3Dtwo=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  Note that this breaks setups that re=
ly on the fact that OpenVPN would</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  previously (incorrectly) only export the last occurrence of a=
 field=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-- ``proto udp`` and ``proto tcp``=
 now use both IPv4 and IPv6=2E The new</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  options ``proto udp4`` and ``proto tcp4`` use IPv4 only=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-- ``--sndbuf`` and ``--recvbuf`` defaul=
t now to OS defaults instead of 64k</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- OpenV=
PN exits with an error if an option has extra parameters;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  previously they were silently ignored=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-- ``--tls-auth`` always requires OpenVPN s=
tatic key files and will no</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  longer work with free form files</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- =
``--proto udp6/tcp6`` in server mode will now try to always listen to</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  both IPv4 and IPv6 on pla=
tforms that allow it=2E Use ``--bind ipv6only``</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  to explicitly listen only on IPv6=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-- Removed ``--enable-password-save`` from configure=
=2E This option is now</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  always enabled=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Stricter default TLS=
 cipher list (override with ``--tls-cipher``), that now</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  also disables:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  * Non-ephemeral key exchange using static (EC)DH keys</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  * DSS private keys</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-- mbed TLS builds: changed the tls_digest_N values expo=
rted to the script</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  e=
nvironment to be equal to the ones exported by OpenSSL builds, namely</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  the certificate fingerpri=
nt (was the hash of the &#39;to be signed&#39; data)=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-- mbed TLS builds: minimum RSA key size is now 2048 bits=2E  S=
horter keys will</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  not=
 be accepted, both local and from the peer=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-- ``--connect-timeout`` now specifies the timeout until the first TLS pa=
cket</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  is received (id=
entical to ``--server-poll-timeout``) and this timeout now</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  includes the removed socks proxy tim=
eout and http proxy timeout=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  In ``--sta=
tic`` mode ``connect-timeout`` specifies the timeout for TCP and</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  proxy connection establishment=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-- ``--connect-retry-max`` now specifies th=
e maximum number of unsuccessful</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  attempts of each remote/connection entry before exiting=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-- ``--http-proxy-timeout`` and the static non-=
changeable socks timeout (5s)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  have been folded into a &quot;unified&quot; ``--connect-timeout``=
 which covers all</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  st=
eps needed to connect to the server, up to the start of the TLS exchange=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The default value h=
as been raised to 120s, to handle slow http/socks</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  proxies graciously=2E  The old &quot;fail TCP=
 fast&quot; behaviour can be achieved by</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  adding &quot;``--connect-timeout 10``&quot; to the cli=
ent config=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--http-proxy-retry`` and =
``--sock-proxy-retry`` have been removed=2E Proxy connections</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  will now behave like regular conn=
ection entries and generate a USR1 on failure=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-- ``--connect-retry`` gets an optional second argument that specifies=
 the maximum</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  time in=
 seconds to wait between reconnection attempts when an exponential</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  backoff is triggered due to =
repeated retries=2E Default =3D 300 seconds=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-- Data channel cipher negotiation (see New features section) can overri=
de</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ciphers configure=
d in the config file=2E  Use ``--ncp-disable`` if you do not want</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  this behavior=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-- All tun devices on all platforms are always considere=
d to be IPv6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  capable=
=2E The ``--tun-ipv6`` option is ignored (behaves like it is always</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  on)=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-- On the client side recursively routed packets, which have the=
 same destination</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  as=
 the VPN server, are dropped=2E This can be disabled with</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  --allow-recursive-routing option=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-- On Windows, when the ``--register-dns`` o=
ption is set, OpenVPN no longer</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  restarts the ``dnscache`` service - this had unwanted side effe=
cts, and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  seems to be=
 no longer necessary with currently supported Windows versions=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-- If no flags are given, and the interactive Windows=
 service is used, &quot;def1&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  is implicitly set (because &quot;delete and later reinstall =
the existing</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  default=
 route&quot; does not work well here)=2E  If not using the service,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  the old behaviour is kept=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-- OpenVPN now reloads a CRL only if the=
 modication time or file size has</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  changed, instead of for each new connection=2E  This reduces =
the connection</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  setup=
 time, in particular when using large CRLs=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-- OpenVPN now ships with more up-to-date systemd unit files which take a=
dvantage</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  of the impr=
oved service management as well as some hardening steps=2E  The</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  configuration files are picked =
up from the /etc/openvpn/server/ and</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  /etc/openvpn/client/ directories (depending on unit file)=
=2E  This also avoids</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  these new unit files and how they work to collide with older pre-existing=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  unit files=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-- Using ``--no-iv`` (which is generally not a re=
commended setup) will</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  require explicitly disabling NCP with ``--disable-ncp``=2E  This is</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  intentional because NCP w=
ill by default use AES-GCM, which requires</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  an IV - so we want users of that option to conscious=
ly reconsider=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-Maintainer-visible changes</span><br><span>----=
-----------------------</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-- OpenVPN no longer supports building with crypto support, but without TL=
S</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  support=2E  As a c=
onsequence, OPENSSL_CRYPTO_{CFLAGS,LIBS} and</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  OPENSSL_SSL_{CFLAGS,LIBS} have been merged into OP=
ENSSL_{CFLAGS,LIBS}=2E  This</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  is particularly relevant for maintainers who build their own OpenS=
SL library,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  e=2Eg=2E=
 when cross-compiling=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Linux distributi=
ons using systemd is highly encouraged to ship these new unit</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  files instead of older ones, to p=
rovide a unified behaviour across systemd</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  based Linux distributions=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-- With OpenVPN 2=2E4, the project has moved over to depend on and a=
ctively use</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the offi=
cial C99 standard (-std=3Dc99)=2E  This may fail on some older compiler/lib=
c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  header combination=
s=2E  In most of these situations it is recommended to</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  use -std=3Dgnu99 in CFLAGS=2E  This is k=
nown to be needed when doing</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  i386/i686 builds on RHEL5=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-Version 2=2E4=2E5</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-New features</span><br><span>----=
---------</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- The new op=
tion ``--tls-cert-profile`` can be used to restrict the set of</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  allowed crypto algorithms in TLS=
 certificates in mbed TLS builds=2E  The</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  default profile is &#39;legacy&#39; for now, which all=
ows SHA1+, RSA-1024+ and any</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  elliptic curve certificates=2E  The default will be changed to the=
 &#39;preferred&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 profile in the future, which requires SHA2+, RSA-2048+ and any curve=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-Version 2=2E4=2E3</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-New features</span><br><span>-------------</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-- Support building with OpenSSL 1=2E1 now (in addi=
tion to older versions)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- On Win10, set low=
 interface metric for TAP adapter when block-outside-dns</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  is in use, to make Windows prefer the =
TAP adapter for DNS queries</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  (avoiding large delays)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-Security</span><br><span>-------=
--</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- CVE-2017-7522: Fi=
x ``--x509-track`` post-authentication remote DoS</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  A client could crash a v2=2E4+ mbedtls server=
, if that server uses the</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  ``--x509-track`` option and the client has a correct, signed and unre=
voked</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  certificate th=
at contains an embedded NUL in the certificate subject=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  Discovered and reported to the OpenVP=
N security team by Guido Vranken=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- CVE-2=
017-7521: Fix post-authentication remote-triggerable memory leaks</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  A client could cause a server=
 to leak a few bytes each time it connects to the</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  server=2E  That can eventually cause the serv=
er to run out of memory, and thereby</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  causing the server process to terminate=2E Discovered and =
reported to the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Open=
VPN security team by Guido Vranken=2E  (OpenSSL builds only=2E)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-- CVE-2017-7521: Fix a potential post-authentication r=
emote code execution</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 attack on servers that use the ``--x509-username-field`` option with an X=
=2E509</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  extension fie=
ld (option argument prefixed with ``ext:``)=2E  A client that can</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  cause a server to run out-of-=
memory (see above) might be able to cause the</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  server to double free, which in turn might lead t=
o remote code execution=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  Discovered and reported to the OpenVPN security team by Guido Vranke=
n=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (OpenSSL builds=
 only=2E)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-- CVE-2017-7520: Pre-authenticati=
on remote crash/information disclosure for</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  clients=2E If clients use a HTTP proxy with NTLM aut=
hentication (i=2Ee=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  ``--http-proxy &lt;server&gt; &lt;port&gt; [&lt;authfile&gt;|&#39;auto&#3=
9;|&#39;auto-nct&#39;] ntlm2``),</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  a man-in-the-middle attacker between the client and the proxy =
can cause</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the client=
 to crash or disclose at most 96 bytes of stack memory=2E The</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  disclosed stack memory is likely =
to contain the proxy password=2E If the</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  proxy password is not reused, this is unlikely to compr=
omise the security</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  o=
f the OpenVPN tunnel itself=2E  Clients who do not use the ``--http-proxy``=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  option with ntlm2 a=
uthentication are not affected=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- CVE-201=
7-7508: Fix remotely-triggerable ASSERT() on malformed IPv6 packet=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  This can be used to remot=
ely shutdown an openvpn server or client, if</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  IPv6 and ``--mssfix`` are enabled and the IPv6 net=
works used inside the VPN</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  are known=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-- Fix null-pointer deref=
erence when talking to a malicious http proxy</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  that returns a malformed ``Proxy-Authenticate:`` =
headers for digest auth=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Fix overflow c=
heck for long ``--tls-cipher`` option</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Win=
dows: Pass correct buffer size to ``GetModuleFileNameW()``</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  (OSTIF/Quarkslabs audit, finding 5=
=2E6)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-User-visible Changes</span><br><span>---------------------=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--verify-hash`` c=
an now take an optional flag which changes the hashing</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  algorithm=2E It can be either SHA1 or SH=
A256=2E  The default if not provided is</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  SHA1 to preserve backwards compatibility with existing =
configurations=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-- Restrict the supported =
``--x509-username-field`` extension fields to subjectAltName</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  and issuerAltName=2E  Other extens=
ions probably didn&#39;t work anyway, and would</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  cause OpenVPN to crash when a client connects=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-Bugfixes</span><br><span>---------</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-- Fix fingerprint calculation in mbed TLS build=
s=2E  This means that mbed TLS users</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  of OpenVPN 2=2E4=2E0, v2=2E4=2E1 and v2=2E4=2E2 that rely =
on the values of the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 ``tls_digest_*`` env vars, or that use ``--verify-hash`` will have to chan=
ge</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the fingerprint v=
alues they check against=2E  The security impact of the</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  incorrect calculation is very minimal; =
the last few bytes (max 4, typically</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  4) are not verified by the fingerprint=2E  We expect no re=
al-world impact,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  bec=
ause users that used this feature before will notice that it has suddenly</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  stopped working, and =
users that didn&#39;t will notice that connection setup</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  fails if they specify correct fingerpri=
nts=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-- Fix edge case with NCP when the se=
rver sends an empty PUSH_REPLY message</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  back, and the client would not initialize it&#39;s data =
channel crypto layer</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 properly (trac #903)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Fix SIGSEGV on unal=
igned buffer access on OpenBSD/Sparc64</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Fi=
x TCP_NODELAY on OpenBSD</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Remove erroneous=
 limitation on max number of args for ``--plugin``</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-- Fix NCP behaviour on TLS reconnect (Server would not send a prope=
r</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &quot;cipher =2E=
=2E=2E&quot; message back to the client, leading to client and server</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  using different ciphers) =
(trac #887)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-Version 2=2E4=2E2</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-Bugfixes</span><br><span>---------</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-- Fix memory leak introduced in OpenVPN 2=2E4=
=2E1: if ``--remote-cert-tls`` is</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  used, we leaked some memory on each TLS (re)negotiation=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-Security</span><br><span>---------</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-- Fix a pre-authentication denial-of-service attack=
 on both clients and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 servers=2E  By sending a too-large control packet, OpenVPN 2=2E4=2E0 or v2=
=2E4=2E1 can</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  be forc=
ed to hit an ASSERT() and stop the process=2E  If ``--tls-auth`` or</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--tls-crypt`` is used, on=
ly attackers that have the ``--tls-auth`` or</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  ``--tls-crypt`` key can mount an attack=2E</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  (OSTIF/Quarkslab audit find=
ing 5=2E1, CVE-2017-7478)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Fix an authenti=
cated remote DoS vulnerability that could be triggered by</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  causing a packet id roll over=2E  An =
attack is rather inefficient; a peer</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  would need to get us to send at least about 196 GB of data=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (OSTIF/Quarkslab=
 audit finding 5=2E2, CVE-2017-7479)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-Version 2=2E4=2E1</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--remote=
-cert-ku`` now only requires the certificate to have at least the</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  bits set of one of the values=
 in the supplied list, instead of requiring an</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  exact match to one of the values in the list=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--remote-cert-tls`=
` now only requires that a keyUsage is present in the</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  certificate, and leaves the verification =
of the value up to the crypto</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  library, which has more information (i=2Ee=2E the key exchange me=
thod in use)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  to veri=
fy that the keyUsage is correct=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-- ``--ns-cert-type`` is deprecated=2E  Use ``--remote-cert-tls=
`` instead=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The ns=
CertType x509 extension is very old, and barely used=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  ``--remote-cert-tls`` uses the far more=
 common keyUsage and extendedKeyUsage</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  extension instead=2E  Make sure your certificates carry t=
hese to be able to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  u=
se ``--remote-cert-tls``=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span>diff --git a/Makefile=2Eam b/Makefile=2Eam</span><br=
><span>index feeaabb=2E=2E66252e6 100644</span><br><span>--- a/Makefile=2Ea=
m</span><br><span>+++ b/Makefile=2Eam</span><br><span>@@ -59,7 +59,7 @@</sp=
an><br><span> dist_doc_DATA =3D \</span><br><span> 	README \</span><br><spa=
n> 	README=2Embedtls \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	Changes=2Erst \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	C=
hanges=2Emd \</span><br><span> 	COPYRIGHT=2EGPL \</span><br><span> 	COPYING=
</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1767?usp=3Demail">change 17=
67</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1767?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8=
887fa7ccf407d727c2b59397000149e45487e13 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1767 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--x4c+AxinNkw=--


--===============4272062365968240308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4272062365968240308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4272062365968240308==--

