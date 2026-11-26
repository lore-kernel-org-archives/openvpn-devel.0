Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57843606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hPLgvUeC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fhOnTkuA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jW4CXhog;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PKATC9ci
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=hhjw84q0sY5ooO0q3hgAr0BXZXonBdSN4nim5ECuS0M=; b=hPLgvUeC9DySTrhgdfG/wdyugk
	LGpesv7gFGwbuk8LRHWvgn0cULH7eC7pfoj0ZnLI8wZZ6abZrr8HCihyCKNDtgjWML3jcfXEV9lJ5
	J6SBhl+/KtooxDyT4KAi/27MpmAR0h/s9JgqUsjY2gvM53+hi5nfj1RVNY32JCOxeziw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWTGV-000000001Vx-2d4Y;
	Thu, 26 Nov 2026 06:47:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWTGU-000000001Vq-2WiP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 06:47:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+3qGqlsGBMw+mmu2Q9cJL2TKyTO+na/EkLlFklqDHic=; b=fhOnTkuAS5pF9q2jVY7nsyMNv2
 k5o547rYZSJmWL/9BeHu8dScYHAqyU+BF6+1o4c7AD8UqSQgDbbXqD+rad12tSrhiAaHdgnzDsN86
 RlD5J6uxFYNRUF7jPbrNpY0mZam//38W9l44mRzpCob+eYmGxkof9qivJDZQIihxr0sY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+3qGqlsGBMw+mmu2Q9cJL2TKyTO+na/EkLlFklqDHic=; b=jW4CXhogkXBN22WNAu9R9y9d7n
 D/jFGdCA2/J5PvxvxL/Jh4J+Mia6ywW/Z7awfae8mQPb10VwgodSit+xt+p0b+r/H/5fT//eEzSZF
 ytXrG6VtJ0k+h07ZVfPkWb7NvqoEn83/KXMS3rONXDN0QQwogypmFCExCe1jxWoSNZgw=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWTGR-000000003jU-2gqE for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 06:47:30 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4b52fcb410dso2274579f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 22:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795675641; x=1796280441; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+3qGqlsGBMw+mmu2Q9cJL2TKyTO+na/EkLlFklqDHic=;
 b=PKATC9ci5cXQs9tVdqMtU3NcnztC4zRA0liVuPAYKq/VFuyXbt2+yY79O2noSMOPIZ
 3y+24NjmVcWWZ4+1t3pFqVbDLb2XJKX1wFvKBkDiE2uHYPqCx/xSzLaFb6L2pw8GvlRO
 N38PcEOZxX+KsY4AnwSHe5LgAmvzTgWVhp23ygTZ4Xh8DV6q/bmJdaqc3qg2uwMihluq
 /YCWpGA/KBUoy6lOguul9fdgjQUTYAvPu7WwYLcMYztMWvsqttRIWpKSi74rHabovO9r
 C2Dif2X1AHhAEp2Wbm4k6SZtaEOalG8qd2rHrAFg+fpcJ3Zgf8fV1Bbun9xI5j2gUXDx
 fDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795675641; x=1796280441;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+3qGqlsGBMw+mmu2Q9cJL2TKyTO+na/EkLlFklqDHic=;
 b=GCjJeGzsOolLr80/3zJ0IqrzJmfuvJNQa14W/N3l7CG2qIykmDl2M0pxfC53HGegPG
 +SFZP4gEgDDPeUrt9nYrAng6bBD4VSPSAcNy8m0GSaRuKGwxwzrt/J2nmKI8m7ze5mX3
 gpBJf5HQSv1knHzmxo9T+nXBgH6GTcy/UOySW/+MQSx7+8q4bWH93ss5jiudtFzpvkrK
 30P25OPLT6YCOHPZ1am34wBZZDJKaUns4JgQLEgyID2TxBpGrBswDddyt9llGhYznV+S
 cPgbmA14YUM97IVG/hVGzK5Btmr9mGzDP4fNb1gxDsYGUknCEYYN5ioQYJzButjMMKSs
 FQGg==
X-Gm-Message-State: APuU4Z9tRAsqfue1Crne5EYRNF9957/xTl9JJ/cxbTVwF/WMJop/ohMx
 De6LZTyCYyAx/BxXSmIX/XxiP3ymB3OovLFPhucIbbkaSSvjzBT88011Kfe27ZLSmEyVbmqpfVw
 RZQCuT2cKZvh/5rlA0reqGE/cbdpwS4PkitjQJcS871AhzWIopk9QKLUbA8McWVs+nKFb9dTTC1
 aHgJIFKg==
X-Gm-Gg: AZFdTZdYbo7D7WLhWQn1+b6ZLdObS9VFS1gt6uvnI2qZO510lBipEEGntqmwnL0fWkn
 PR1qYgQyZ0XyJec3vgTOJ5FSLcKZCZ6xx8mLo6Zx/hYuUtMY1xletnUpo2sD6ui8vUl9KSZg6aB
 zg3T+CrkQlCbk1HdzFfMRq/g+JCpmu2UsMVy8PmFc6Eh/krJIQqDUN84cw1MpZWy14zp0qqkQwQ
 pBSFGi/yPX1xev2yUxOxQel7CTZgOLE2fVc7rU4A5EQsUs+wuocWGV7muscs/SO0qY2YTgrxMzq
 9mcXOSH2BeflbSS2e0xDgac6yRbrWQCPzVyZQGoYoOYc1lAVtFuew2BkgAHLPtsTVIvJd2Yilu1
 sU0k0psdd5sf2msDNGURP9e9UfsDJFPX7d18cWizRMxyc+Xc88C/APgc/SJDEJlUsGOWNRfdRkq
 kH7M4UaTTlZv4w/rjX49pMe77+QYIJwVKyNq8y+6wxwurgO6T0Ol1pK0zBwb7TVQOYgkTlDBXG9
 H+PGWhNEWG4SsHm3hZ7Y2KYfyeGbh3wVLTPAm0wlGsaPZMpRyurkK4PVTCqusb4Fdm9peWILYTa
 v76OCRXLB5fkBgBaWDFwEpuy5m6/CWOA90Zz1qI2pKNzpFdEr7OpoJb6lty3LrPUE6kj5k8DXAx
 /4kKvwGdogN/JysowPxFbkGBGG+lf+NabIi7GlOzoVaGs8Y341E+BPsGczWPDEsvDQP1B8glDl+
 68Qg8Y8FAa8MW7SVABw91hCnc22nbkVGUab/GA
X-Received: by 2002:a05:6000:455c:b0:4b2:1d92:211b with SMTP id
 ffacd0b85a97d-4b21d922811mr15112309f8f.17.1795675640753; 
 Wed, 25 Nov 2026 22:47:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6ae2dd55sm37289382f8f.30.2026.11.25.22.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:47:20 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 06:47:20 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c438441
X-Gerrit-Change-Number: 2348
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2348?usp=email>
X-Gerrit-Commit: b9a836f1f376939833e93dc2f1d5e9f93138885b
References: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkllMGQ3NzJhZjM4YjY2Nzk5NDk5YjFiNTcyOTkxNWVkNzdjNDM4NDQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <690af6e70cd5c7496710e86affa7e118aa3af1c4-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWTGR-000000003jU-2gqE
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: pass dns vars
 to the updown runner via pipe
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
Content-Type: multipart/mixed; boundary="===============0006147029033803959=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0006147029033803959==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jbEJZqMoXqg="; charset=UTF-8

--jbEJZqMoXqg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2348?usp=3Demail

to review the following change=2E
=


Change subject: dns: pass dns vars to the updown runner via pipe
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dns: pass dns vars =
to the updown runner via pipe

The privileged runner had the script source =
a temp file written by
the unprivileged process and unlinked its path unche=
cked, so another
process running as the --user could run code as root=2E

S=
end the vars over the pipe instead=2E The dns scripts no longer source
a va=
rs file=2E

Reported-by: Paul Jenkins <Paul@northit=2Eco=2Euk>
Reported-by:=
 Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
Reported-by: Bhabani Sank=
ar Das <007bsd@proton=2Eme>
Change-Id: Ie0d772af38b66799499b1b5729915ed77c4=
38441
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
---
M distro=
/dns-scripts/haikuos_file-dns-updown=2Esh
M distro/dns-scripts/macos-dns-up=
down=2Esh
M distro/dns-scripts/openresolv-dns-updown=2Esh
M distro/dns-scri=
pts/resolvconf_file-dns-updown=2Esh
M distro/dns-scripts/systemd-dns-updown=
=2Esh
M src/openvpn/dns=2Ec
M src/openvpn/env_set=2Ec
M src/openvpn/env_set=
=2Eh
8 files changed, 179 insertions(+), 148 deletions(-)



  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/2348/1

diff --git =
a/distro/dns-scripts/haikuos_file-dns-updown=2Esh b/distro/dns-scripts/haik=
uos_file-dns-updown=2Esh
index 04e9e26=2E=2Ed8bf577 100644
--- a/distro/dns=
-scripts/haikuos_file-dns-updown=2Esh
+++ b/distro/dns-scripts/haikuos_file=
-dns-updown=2Esh
@@ -7,10 +7,6 @@
 #
 # Example env from openvpn (most are =
not applied):
 #
-#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d7=
45f986c53c=2Etmp
-#
-#      or
-#
 #   dev tun0
 #   script_type dns-up
 # =
  dns_search_domain_1 mycorp=2Ein
@@ -43,7 +39,6 @@
 
 conf=3D/boot/system/=
settings/network/resolv=2Econf
 test -e "$conf" || exit 1
-test -z "${dns_v=
ars_file}" || =2E "${dns_vars_file}"
 case "${script_type}" in
 dns-up)
   =
  n=3D1
diff --git a/distro/dns-scripts/macos-dns-updown=2Esh b/distro/dns-=
scripts/macos-dns-updown=2Esh
index fccc6b5=2E=2Eb6b93f8 100644
--- a/distr=
o/dns-scripts/macos-dns-updown=2Esh
+++ b/distro/dns-scripts/macos-dns-updo=
wn=2Esh
@@ -8,10 +8,6 @@
 #
 # Example env from openvpn (most are not appli=
ed):
 #
-#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53=
c=2Etmp
-#
-#      or
-#
 #   dev utun0
 #   script_type dns-up
 #   dns_se=
arch_domain_1 mycorp=2Ein
@@ -43,8 +39,6 @@
 done
 trap "/bin/rm -f ${lockf=
ile}" EXIT
 
-[ -z "${dns_vars_file}" ] || =2E "${dns_vars_file}"
-
 itf_dn=
s_key=3D"State:/Network/Service/openvpn-${dev}/DNS"
 
 function primary_dns=
_key {
diff --git a/distro/dns-scripts/openresolv-dns-updown=2Esh b/distro/=
dns-scripts/openresolv-dns-updown=2Esh
index 4aca99f=2E=2E4865031 100644
--=
- a/distro/dns-scripts/openresolv-dns-updown=2Esh
+++ b/distro/dns-scripts/=
openresolv-dns-updown=2Esh
@@ -8,10 +8,6 @@
 #
 # Example env from openvpn =
(most are not applied):
 #
-#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2=
db43afb5d745f986c53c=2Etmp
-#
-#      or
-#
 #   dev tun0
 #   script_type =
dns-up
 #   dns_search_domain_1 mycorp=2Ein
@@ -42,7 +38,6 @@
     done
 }
=
 
-[ -z "${dns_vars_file}" ] || =2E "${dns_vars_file}"
 : ${script_type:=3D=
dns-down}
 case "${script_type}" in
 dns-up)
diff --git a/distro/dns-script=
s/resolvconf_file-dns-updown=2Esh b/distro/dns-scripts/resolvconf_file-dns-=
updown=2Esh
index 78bf9d3=2E=2Ed68c00d 100644
--- a/distro/dns-scripts/reso=
lvconf_file-dns-updown=2Esh
+++ b/distro/dns-scripts/resolvconf_file-dns-up=
down=2Esh
@@ -7,10 +7,6 @@
 #
 # Example env from openvpn (most are not app=
lied):
 #
-#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c=
53c=2Etmp
-#
-#      or
-#
 #   dev tun0
 #   script_type dns-up
 #   dns_s=
earch_domain_1 mycorp=2Ein
@@ -43,7 +39,6 @@
 
 conf=3D/etc/resolv=2Econf
 =
test -e "$conf" || exit 1
-test -z "${dns_vars_file}" || =2E "${dns_vars_fi=
le}"
 case "${script_type}" in
 dns-up)
     n=3D1
diff --git a/distro/dns-=
scripts/systemd-dns-updown=2Esh b/distro/dns-scripts/systemd-dns-updown=2Es=
h
index 3bdaa4b=2E=2Eff6f982 100644
--- a/distro/dns-scripts/systemd-dns-up=
down=2Esh
+++ b/distro/dns-scripts/systemd-dns-updown=2Esh
@@ -15,10 +15,6 =
@@
 #
 # Example env from openvpn (not all are always applied):
 #
-#   dns=
_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c=2Etmp
-#
-#   =
   or
-#
 #   dev tun0
 #   script_type dns-up
 #   dns_search_domain_1 myc=
orp=2Ein
@@ -34,8 +30,6 @@
 #   dns_server_1_sni dns=2Emycorp=2Ein
 #
 
-[ =
-z "${dns_vars_file}" ] || =2E "${dns_vars_file}"
-
 function do_resolved_s=
ervers {
     local sni=3D""
     local transport_var=3Ddns_server_${n}_tra=
nsport
diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index e2cb981=
=2E=2E1bd6c85 100644
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@=
 -587,23 +587,113 @@
     setenv_dns_options(o, es);
 }
 
-static int
-do_r=
un_up_down_command(bool up, const char *vars_file, const struct dns_options=
 *o,
-                       const struct tuntap *tt)
+/** Maximum size in =
bytes of the dns vars sent to the updown runner */
+#define DNS_VARS_MAX_SI=
ZE (64 * 1024)
+
+/**
+ * Add dns vars received by the updown runner to an =
env set
+ *
+ * Every var must be a name=3Dvalue pair=2E If anything is inv=
alid, the vars
+ * are rejected as a whole=2E
+ *
+ * @param  vars     NUL =
terminated name=3Dvalue strings, modified in place
+ * @param  size     siz=
e of @p vars in bytes
+ * @param  es       env set to add the vars to
+ *
+=
 * @return bool to indicate success or failure
+ */
+static bool
+dns_vars_=
setenv(char *vars, size_t size, struct env_set *es)
 {
-    struct gc_arena=
 gc =3D gc_new();
+    if (size > 0 && vars[size - 1] !=3D '\0')
+    {
+  =
      return false;
+    }
+
+    const char *const end =3D vars + size;
+ =
   char *var =3D vars;
+    while (var < end)
+    {
+        const size_t =
var_size =3D strlen(var);
+        char *next =3D var + var_size + 1;
+    =
    char *eq =3D memchr(var, '=3D', var_size);
+        if (!eq)
+        {=

+            return false;
+        }
+
+        *eq =3D '\0';
+        se=
tenv_str(es, var, eq + 1);
+        var =3D next;
+    }
+
+    return true=
;
+}
+
+/**
+ * Read from a pipe until the requested amount of data has arr=
ived
+ *
+ * @param  fd       file descriptor to read from
+ * @param  data=
     buffer to read into
+ * @param  size     number of bytes to read
+ *
+=
 * @return bool to indicate success or failure
+ */
+static bool
+read_pipe=
(int fd, void *data, size_t size)
+{
+    uint8_t *p =3D data;
+    while (=
size > 0)
+    {
+        const ssize_t len =3D read(fd, p, size);
+       =
 if (len =3D=3D -1 && errno =3D=3D EINTR)
+        {
+            continue;=

+        }
+        if (len < 1)
+        {
+            return false;
+  =
      }
+        p +=3D len;
+        size -=3D (size_t)len;
+    }
+    re=
turn true;
+}
+
+/**
+ * Write to a pipe until all data has been written
+ =
*
+ * @param  fd       file descriptor to write to
+ * @param  data     dat=
a to write
+ * @param  size     number of bytes to write
+ *
+ * @return bo=
ol to indicate success or failure
+ */
+static bool
+write_pipe(int fd, con=
st void *data, size_t size)
+{
+    const uint8_t *p =3D data;
+    while (=
size > 0)
+    {
+        const ssize_t len =3D write(fd, p, size);
+      =
  if (len =3D=3D -1 && errno =3D=3D EINTR)
+        {
+            continue=
;
+        }
+        if (len < 1)
+        {
+            return false;
+ =
       }
+        p +=3D len;
+        size -=3D (size_t)len;
+    }
+    r=
eturn true;
+}
+
+static int
+do_run_up_down_command(const struct dns_optio=
ns *o, const struct env_set *es)
+{
     struct argv argv =3D argv_new();
-=
    struct env_set *es =3D env_set_create(&gc);
-
-    if (vars_file)
-    =
{
-        setenv_str(es, "dns_vars_file", vars_file);
-    }
-    else
-  =
  {
-        updown_env_set(up, o, tt, es);
-    }
-
     argv_printf(&argv=
, "%s", o->updown);
     argv_msg(M_INFO, &argv);
     int res;
@@ -616,13 =
+706,11 @@
         res =3D openvpn_execve_check(&argv, es, S_EXITCODE, "WA=
RNING: Failed running dns updown");
     }
     argv_free(&argv);
-    gc_f=
ree(&gc);
     return res;
 }
 
 static bool
-run_updown_runner(bool up, st=
ruct options *o, const struct tuntap *tt,
-                  struct dns_upd=
own_runner_info *updown_runner)
+run_updown_runner(struct options *o, struc=
t dns_updown_runner_info *updown_runner)
 {
     int dns_pipe_fd[2];
     i=
nt ack_pipe_fd[2];
@@ -675,56 +763,58 @@
         signal(SIGUSR2, SIG_IGN);=

         signal(SIGPIPE, SIG_IGN);
 
+        char *vars =3D malloc(DNS_VA=
RS_MAX_SIZE);
+        check_malloc_return(vars);
+
         while (1)
    =
     {
-            char path[PATH_MAX];
+            uint32_t vars_size;
 =

-            /* Block here until parent sends a path */
-            ssize=
_t rlen =3D read(dns_pipe_fd[0], &path, sizeof(path));
-            if (rle=
n < 1)
+            /* Block here until parent sends the dns vars */
+     =
       if (!read_pipe(dns_pipe_fd[0], &vars_size, sizeof(vars_size)))
     =
        {
-                if (rlen =3D=3D -1 && errno =3D=3D EINTR)
-     =
           {
-                    continue;
-                }
-           =
     close(dns_pipe_fd[0]);
-                close(ack_pipe_fd[1]);
-      =
          exit(0);
+                break;
+            }
+            if (=
vars_size > DNS_VARS_MAX_SIZE)
+            {
+                msg(M_WARN, =
"dns updown: received dns vars are too large");
+                break;
+  =
          }
+            if (!read_pipe(dns_pipe_fd[0], vars, vars_size))
+=
            {
+                break;
             }
 
-            path[si=
zeof(path) - 1] =3D '\0';
-            int res =3D do_run_up_down_command(u=
p, path, &o->dns_options, tt);
-            platform_unlink(path);
+       =
     int res =3D -1;
+            struct gc_arena gc =3D gc_new();
+       =
     struct env_set *es =3D env_set_create(&gc);
+            if (dns_vars_=
setenv(vars, vars_size, es))
+            {
+                res =3D do_run=
_up_down_command(&o->dns_options, es);
+            }
+            else
+  =
          {
+                msg(M_WARN, "dns updown: received invalid dns =
vars");
+            }
+            gc_free(&gc);
 
             /* Unblock=
 parent process */
-            while (1)
+            if (!write_pipe(ack_=
pipe_fd[1], &res, sizeof(res)))
             {
-                ssize_t wle=
n =3D write(ack_pipe_fd[1], &res, sizeof(res));
-                if ((wlen =
=3D=3D -1 && errno !=3D EINTR) || wlen < (ssize_t)sizeof(res))
-           =
     {
-                    /* Not much we can do about errors but exit */
=
-                    close(dns_pipe_fd[0]);
-                    close(ack_=
pipe_fd[1]);
-                    exit(0);
-                }
-            =
    else if (wlen =3D=3D sizeof(res))
-                {
-                 =
   break;
-                }
+                break;
             }
-
-    =
        up =3D !up; /* do the opposite next time */
         }
+
+        /=
* Not much we can do about errors but exit */
+        free(vars);
+       =
 close(dns_pipe_fd[0]);
+        close(ack_pipe_fd[1]);
+        exit(0);
 =
    }
 
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)=

-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conve=
rsion"
-#endif
-
 static void
 run_up_down_command(bool up, struct options =
*o, const struct tuntap *tt,
                     struct dns_updown_runner_=
info *updown_runner)
@@ -736,77 +826,46 @@
     }
 
     int status =3D -1;=

+    struct gc_arena gc =3D gc_new();
+    struct env_set *es =3D env_set_=
create(&gc);
+    updown_env_set(up, dns, tt, es);
 
     if (!updown_runne=
r->required)
     {
         /* Run dns updown directly */
-        status =
=3D do_run_up_down_command(up, NULL, dns, tt);
+        status =3D do_run_u=
p_down_command(dns, es);
     }
     else
     {
-        if (updown_runner=
->pid < 1)
+        /* Need to set up privilege preserving child first */
+=
        if (updown_runner->pid < 1 && !run_updown_runner(o, updown_runner))=

         {
-            /* Need to set up privilege preserving child first=
 */
-            if (!run_updown_runner(up, o, tt, updown_runner))
-       =
     {
-                return;
-            }
+            gc_free(&gc);
+=
            return;
         }
 
-        struct gc_arena gc =3D gc_new();
=
-        const char *dvf =3D platform_create_temp_file(o->tmp_dir, "dvf", &=
gc);
-        if (!dvf)
+        struct buffer vars =3D env_set_write_buffe=
r(es, &gc);
+        const uint32_t vars_size =3D (uint32_t)BLEN(&vars);
+ =
       if (BLEN(&vars) > DNS_VARS_MAX_SIZE)
         {
-            msg(M_E=
RR, "could not create dns vars file");
-            goto out_free;
+       =
     msg(M_WARN, "dns vars exceed the maximum size");
         }
-
-       =
 struct env_set *es =3D env_set_create(&gc);
-        updown_env_set(up, &o=
->dns_options, tt, es);
-        env_set_write_file(dvf, es);
-
-        in=
t wfd =3D updown_runner->fds[1];
-        ssize_t dvf_size =3D strlen(dvf) =
+ 1;
-        while (1)
+        else if (!write_pipe(updown_runner->fds[1]=
, &vars_size, sizeof(vars_size))
+                 || !write_pipe(updown_ru=
nner->fds[1], BPTR(&vars), vars_size))
         {
-            ssize_t len =
=3D write(wfd, dvf, dvf_size);
-            if (len < dvf_size)
-          =
  {
-                if (len =3D=3D -1 && errno =3D=3D EINTR)
-            =
    {
-                    continue;
-                }
-                ms=
g(M_WARN | M_ERRNO, "could not send dns vars filename");
-            }
-  =
          break;
+            msg(M_WARN | M_ERRNO, "could not send dns var=
s");
         }
-
-        int rfd =3D updown_runner->fds[0];
-        whil=
e (1)
+        else if (!read_pipe(updown_runner->fds[0], &status, sizeof(s=
tatus)))
         {
-            ssize_t len =3D read(rfd, &status, sizeof(=
status));
-            if (len < (ssize_t)sizeof(status))
-            {
- =
               if (len =3D=3D -1 && errno =3D=3D EINTR)
-                {
=
-                    continue;
-                }
-                msg(M_WA=
RN | M_ERRNO, "could not receive dns updown status");
-            }
-     =
       break;
+            msg(M_WARN | M_ERRNO, "could not receive dns upd=
own status");
+            status =3D -1;
         }
-
-out_free:
-        =
gc_free(&gc);
     }
 
+    gc_free(&gc);
     msg(M_INFO, "dns %s command =
exited with status %d", up ? "up" : "down", status);
 }
 
-#if defined(__GN=
UC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /=
* _WIN32 */
 
 void
diff --git a/src/openvpn/env_set=2Ec b/src/openvpn/env_=
set=2Ec
index 55190b8=2E=2E9494851 100644
--- a/src/openvpn/env_set=2Ec
+++=
 b/src/openvpn/env_set=2Ec
@@ -232,28 +232,22 @@
     }
 }
 
-void
-env_set=
_write_file(const char *path, const struct env_set *es)
+struct buffer
+env=
_set_write_buffer(const struct env_set *es, struct gc_arena *gc)
 {
-    FI=
LE *fp =3D platform_fopen(path, "w");
-    if (!fp)
+    size_t size =3D 0;=

+    for (const struct env_item *e =3D es ? es->list : NULL; e; e =3D e->n=
ext)
     {
-        msg(M_ERR, "could not write env set to '%s'", path);
-=
        return;
+        size +=3D strlen(e->string) + 1;
     }
 
-    if =
(es)
+    struct buffer buf =3D alloc_buf_gc(size, gc);
+    for (const str=
uct env_item *e =3D es ? es->list : NULL; e; e =3D e->next)
     {
-       =
 const struct env_item *item =3D es->list;
-        while (item)
-        {=

-            fputs(item->string, fp);
-            fputc('\n', fp);
-     =
       item =3D item->next;
-        }
+        ASSERT(buf_write(&buf, e->s=
tring, strlen(e->string) + 1));
     }
 
-    fclose(fp);
+    return buf;
=
 }
 
 void
diff --git a/src/openvpn/env_set=2Eh b/src/openvpn/env_set=2Eh
i=
ndex fcfc3ca=2E=2E24d3bde 100644
--- a/src/openvpn/env_set=2Eh
+++ b/src/op=
envpn/env_set=2Eh
@@ -88,12 +88,17 @@
 void env_set_print(msglvl_t msglevel=
, const struct env_set *es);
 
 /**
- * Write a struct env_set to a file=2E=
 Each item on one line=2E
+ * Write the items of an env set into a buffer
 =
 *
- * @param path  The filepath to write to=2E
- * @param es    Pointer to=
 the env_set to write=2E
+ * The items are written as NUL terminated name=
=3Dvalue strings, one after
+ * the other=2E
+ *
+ * @param  es       env s=
et to write
+ * @param  gc       gc arena to allocate the buffer from
+ *
+=
 * @return struct buffer containing the items
  */
-void env_set_write_file=
(const char *path, const struct env_set *es);
+struct buffer env_set_write_=
buffer(const struct env_set *es, struct gc_arena *gc);
 
 void env_set_inhe=
rit(struct env_set *es, const struct env_set *src);
 

-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c438=
441
Gerrit-Change-Number: 2348
Gerrit-PatchSet: 1
Gerrit-Owner: Heiko Hund =
<heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--jbEJZqMoXqg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">dns: pass dns vars to the updown runner via pipe<br><br>The privi=
leged runner had the script source a temp file written by<br>the unprivileg=
ed process and unlinked its path unchecked, so another<br>process running a=
s the --user could run code as root=2E<br><br>Send the vars over the pipe i=
nstead=2E The dns scripts no longer source<br>a vars file=2E<br><br>Reporte=
d-by: Paul Jenkins &lt;Paul@northit=2Eco=2Euk&gt;<br>Reported-by: Deri Haer=
udi &lt;abcderyscreenprinting@gmail=2Ecom&gt;<br>Reported-by: Bhabani Sanka=
r Das &lt;007bsd@proton=2Eme&gt;<br>Change-Id: Ie0d772af38b66799499b1b57299=
15ed77c438441<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet=
&gt;<br>---<br>M distro/dns-scripts/haikuos_file-dns-updown=2Esh<br>M distr=
o/dns-scripts/macos-dns-updown=2Esh<br>M distro/dns-scripts/openresolv-dns-=
updown=2Esh<br>M distro/dns-scripts/resolvconf_file-dns-updown=2Esh<br>M di=
stro/dns-scripts/systemd-dns-updown=2Esh<br>M src/openvpn/dns=2Ec<br>M src/=
openvpn/env_set=2Ec<br>M src/openvpn/env_set=2Eh<br>8 files changed, 179 in=
sertions(+), 148 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/2348/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/distro/dns-scripts/haikuos_file-dns-updown=2Esh b/distro/dns-scripts/hai=
kuos_file-dns-updown=2Esh</span><br><span>index 04e9e26=2E=2Ed8bf577 100644=
</span><br><span>--- a/distro/dns-scripts/haikuos_file-dns-updown=2Esh</spa=
n><br><span>+++ b/distro/dns-scripts/haikuos_file-dns-updown=2Esh</span><br=
><span>@@ -7,10 +7,6 @@</span><br><span> #</span><br><span> # Example env f=
rom openvpn (most are not applied):</span><br><span> #</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#   dns_vars_file /tmp/openvpn_dvf_58b95c0=
c97b2db43afb5d745f986c53c=2Etmp</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#      or<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span> #  =
 dev tun0</span><br><span> #   script_type dns-up</span><br><span> #   dns_=
search_domain_1 mycorp=2Ein</span><br><span>@@ -43,7 +39,6 @@</span><br><sp=
an> </span><br><span> conf=3D/boot/system/settings/network/resolv=2Econf</s=
pan><br><span> test -e &quot;$conf&quot; || exit 1</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-test -z &quot;${dns_vars_file}&quot; || =2E &q=
uot;${dns_vars_file}&quot;</span><br><span> case &quot;${script_type}&quot;=
 in</span><br><span> dns-up)</span><br><span>     n=3D1</span><br><span>dif=
f --git a/distro/dns-scripts/macos-dns-updown=2Esh b/distro/dns-scripts/mac=
os-dns-updown=2Esh</span><br><span>index fccc6b5=2E=2Eb6b93f8 100644</span>=
<br><span>--- a/distro/dns-scripts/macos-dns-updown=2Esh</span><br><span>++=
+ b/distro/dns-scripts/macos-dns-updown=2Esh</span><br><span>@@ -8,10 +8,6 =
@@</span><br><span> #</span><br><span> # Example env from openvpn (most are=
 not applied):</span><br><span> #</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986=
c53c=2Etmp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#      or</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#</span><br><span> #   dev utun0</span><br>=
<span> #   script_type dns-up</span><br><span> #   dns_search_domain_1 myco=
rp=2Ein</span><br><span>@@ -43,8 +39,6 @@</span><br><span> done</span><br><=
span> trap &quot;/bin/rm -f ${lockfile}&quot; EXIT</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-[ -z &quot;${dns_vars_file}&=
quot; ] || =2E &quot;${dns_vars_file}&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> itf_dns_key=3D&quot;State:/Network/=
Service/openvpn-${dev}/DNS&quot;</span><br><span> </span><br><span> functio=
n primary_dns_key {</span><br><span>diff --git a/distro/dns-scripts/openres=
olv-dns-updown=2Esh b/distro/dns-scripts/openresolv-dns-updown=2Esh</span><=
br><span>index 4aca99f=2E=2E4865031 100644</span><br><span>--- a/distro/dns=
-scripts/openresolv-dns-updown=2Esh</span><br><span>+++ b/distro/dns-script=
s/openresolv-dns-updown=2Esh</span><br><span>@@ -8,10 +8,6 @@</span><br><sp=
an> #</span><br><span> # Example env from openvpn (most are not applied):</=
span><br><span> #</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#   =
dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c=2Etmp</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#      or</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#</span><br><span> #   dev tun0</span><br><span> #   script=
_type dns-up</span><br><span> #   dns_search_domain_1 mycorp=2Ein</span><br=
><span>@@ -42,7 +38,6 @@</span><br><span>     done</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-[ -z &quo=
t;${dns_vars_file}&quot; ] || =2E &quot;${dns_vars_file}&quot;</span><br><s=
pan> : ${script_type:=3Ddns-down}</span><br><span> case &quot;${script_type=
}&quot; in</span><br><span> dns-up)</span><br><span>diff --git a/distro/dns=
-scripts/resolvconf_file-dns-updown=2Esh b/distro/dns-scripts/resolvconf_fi=
le-dns-updown=2Esh</span><br><span>index 78bf9d3=2E=2Ed68c00d 100644</span>=
<br><span>--- a/distro/dns-scripts/resolvconf_file-dns-updown=2Esh</span><b=
r><span>+++ b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh</span><br>=
<span>@@ -7,10 +7,6 @@</span><br><span> #</span><br><span> # Example env fr=
om openvpn (most are not applied):</span><br><span> #</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#   dns_vars_file /tmp/openvpn_dvf_58b95c0c=
97b2db43afb5d745f986c53c=2Etmp</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#      or</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span> #   =
dev tun0</span><br><span> #   script_type dns-up</span><br><span> #   dns_s=
earch_domain_1 mycorp=2Ein</span><br><span>@@ -43,7 +39,6 @@</span><br><spa=
n> </span><br><span> conf=3D/etc/resolv=2Econf</span><br><span> test -e &qu=
ot;$conf&quot; || exit 1</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-test -z &quot;${dns_vars_file}&quot; || =2E &quot;${dns_vars_file}&quot;=
</span><br><span> case &quot;${script_type}&quot; in</span><br><span> dns-u=
p)</span><br><span>     n=3D1</span><br><span>diff --git a/distro/dns-scrip=
ts/systemd-dns-updown=2Esh b/distro/dns-scripts/systemd-dns-updown=2Esh</sp=
an><br><span>index 3bdaa4b=2E=2Eff6f982 100644</span><br><span>--- a/distro=
/dns-scripts/systemd-dns-updown=2Esh</span><br><span>+++ b/distro/dns-scrip=
ts/systemd-dns-updown=2Esh</span><br><span>@@ -15,10 +15,6 @@</span><br><sp=
an> #</span><br><span> # Example env from openvpn (not all are always appli=
ed):</span><br><span> #</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c=2Etmp=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#      or</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#</span><br><span> #   dev tun0</span><br><span> #   =
script_type dns-up</span><br><span> #   dns_search_domain_1 mycorp=2Ein</sp=
an><br><span>@@ -34,8 +30,6 @@</span><br><span> #   dns_server_1_sni dns=2E=
mycorp=2Ein</span><br><span> #</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-[ -z &quot;${dns_vars_file}&quot; ] || =2E &quot=
;${dns_vars_file}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> function do_resolved_servers {</span><br><span>     loc=
al sni=3D&quot;&quot;</span><br><span>     local transport_var=3Ddns_server=
_${n}_transport</span><br><span>diff --git a/src/openvpn/dns=2Ec b/src/open=
vpn/dns=2Ec</span><br><span>index e2cb981=2E=2E1bd6c85 100644</span><br><sp=
an>--- a/src/openvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</spa=
n><br><span>@@ -587,23 +587,113 @@</span><br><span>     setenv_dns_options(=
o, es);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-do_run_up_down_command(bool up, const char *vars_file, const st=
ruct dns_options *o,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                      const struct tuntap *tt)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/** Maximum size in bytes of the dns vars sent t=
o the updown runner */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define DNS_VARS_MAX_SIZE (64 * 1024)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Add dns var=
s received by the updown runner to an env set</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Every var must be a name=3Dvalue pair=2E If anything is invalid=
, the vars</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * are re=
jected as a whole=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  vars =
    NUL terminated name=3Dvalue strings, modified in place</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param  size     size of @p vars =
in bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  =
es       env set to add the vars to</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return bool to indicate success or failure</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+dns_vars_setenv(char *vars, size_t size, struct env_set *es)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (size &gt; 0 &amp;&amp; vars[size - 1] !=3D &#39;\0&#39;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *const end =3D vars + size;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    char *var =3D vars;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    while (var &lt; end)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        const size_t var_size =3D strlen(var);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        char *next =3D var =
+ var_size + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    char *eq =3D memchr(var, &#39;=3D&#39;, var_size);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (!eq)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        *eq =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        setenv_str(es, var, eq + 1);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        var =3D next;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Read from a pipe until the requested amount of data ha=
s arrived</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  fd       file de=
scriptor to read from</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param  data     buffer to read into</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param  size     number of bytes to read</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @return bool to indicate success or failure=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+read_pipe(int fd, void *data, size_t size=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *p =3D data;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    while (size &gt; 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const ssize_t len =3D read(fd, p,=
 size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
len =3D=3D -1 &amp;&amp; errno =3D=3D EINTR)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            continue;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (len &lt; 1)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     p +=3D len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     size -=3D (size_t)len;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Write to a pipe until all data has been written</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param  fd       file descriptor to write to<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  data     =
data to write</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram  size     number of bytes to write</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @return bool to indicate success or failure</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+write_pipe(int fd, const void *data, size_t size)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const uint8_t *p =3D data;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    while (size &gt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        const ssize_t len =3D write(fd, p, size);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (len =3D=3D -1=
 &amp;&amp; errno =3D=3D EINTR)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            continue;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (len &lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p +=3D l=
en;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size -=
=3D (size_t)len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+do_run_up_down_command(const struct dns_options *o, const struct e=
nv_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span>     struct argv argv =3D argv_new();</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct env_set *es =3D env_set_create(&amp;gc=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (vars_file)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        setenv_str(es, &quot;dns_vars_file&quot;, vars_file=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        updown_env_set(up, o, tt, es);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>     argv_printf(&amp;argv, &quot;%s&quot;, o-=
&gt;updown);</span><br><span>     argv_msg(M_INFO, &amp;argv);</span><br><s=
pan>     int res;</span><br><span>@@ -616,13 +706,11 @@</span><br><span>   =
      res =3D openvpn_execve_check(&amp;argv, es, S_EXITCODE, &quot;WARNING=
: Failed running dns updown&quot;);</span><br><span>     }</span><br><span>=
     argv_free(&amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    gc_free(&amp;gc);</span><br><span>     return res;</span><br><span=
> }</span><br><span> </span><br><span> static bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-run_updown_runner(bool up, struct options *o, =
const struct tuntap *tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                  struct dns_updown_runner_info *updown_runner)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+run_updown_runner(struct opt=
ions *o, struct dns_updown_runner_info *updown_runner)</span><br><span> {</=
span><br><span>     int dns_pipe_fd[2];</span><br><span>     int ack_pipe_f=
d[2];</span><br><span>@@ -675,56 +763,58 @@</span><br><span>         signal=
(SIGUSR2, SIG_IGN);</span><br><span>         signal(SIGPIPE, SIG_IGN);</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  char *vars =3D malloc(DNS_VARS_MAX_SIZE);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        check_malloc_return(vars);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         while (1)<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            char path[PATH_MAX];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            uint32_t vars_size;</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Block here unt=
il parent sends a path */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            ssize_t rlen =3D read(dns_pipe_fd[0], &amp;path, sizeof(pat=
h));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (r=
len &lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    /* Block here until parent sends the dns vars */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!read_pipe(dns_pipe_fd[0]=
, &amp;vars_size, sizeof(vars_size)))</span><br><span>             {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                if (rlen =3D=
=3D -1 &amp;&amp; errno =3D=3D EINTR)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    continue;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                close(dns_pipe_fd[0]);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                close(ack_pipe_fd[1]);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                exit(0);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                brea=
k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (vars_si=
ze &gt; DNS_VARS_MAX_SIZE)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                msg(M_WARN, &quot;dns updown: received dns vars are too la=
rge&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (!read_pipe(dns_pipe_fd[0], vars, vars_size))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                break;</span><br><span>            =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           path[sizeof(path) - 1] =3D &#39;\0&#39;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            int res =3D do_run_up_down_comm=
and(up, path, &amp;o-&gt;dns_options, tt);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            platform_unlink(path);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            int res =3D -1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      struct env_set *es =3D env_set_create(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (dns_vars_setenv(vars, var=
s_size, es))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   res =3D do_run_up_down_command(&amp;o-&gt;dns_options, es);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                msg(M_WARN, &quot;dns updown: r=
eceived invalid dns vars&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            gc_free(&amp;gc);</span><br><span> </span><br><span>    =
         /* Unblock parent process */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            while (1)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (!write_pipe(ack_pipe_fd[1], &amp;res, siz=
eof(res)))</span><br><span>             {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                ssize_t wlen =3D write(ack_pipe_fd[1], =
&amp;res, sizeof(res));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                if ((wlen =3D=3D -1 &amp;&amp; errno !=3D EINTR) || wlen =
&lt; (ssize_t)sizeof(res))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    /* Not much we can do about errors but exit */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    close(dns=
_pipe_fd[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            close(ack_pipe_fd[1]);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    exit(0);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                else if (wlen =3D=3D sizeof(res))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    break;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                break;</span><br=
><span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            up =3D !u=
p; /* do the opposite next time */</span><br><span>         }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* Not much we can do about errors but exit =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(vars=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(dns=
_pipe_fd[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  close(ack_pipe_fd[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        exit(0);</span><br><span>     }</span><br><span> </span><br><s=
pan>     return true;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GC=
C diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> static void</span><br><span> run_up_down_co=
mmand(bool up, struct options *o, const struct tuntap *tt,</span><br><span>=
                     struct dns_updown_runner_info *updown_runner)</span><b=
r><span>@@ -736,77 +826,46 @@</span><br><span>     }</span><br><span> </spa=
n><br><span>     int status =3D -1;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct env_set *es =3D env_set_create=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    updow=
n_env_set(up, dns, tt, es);</span><br><span> </span><br><span>     if (!upd=
own_runner-&gt;required)</span><br><span>     {</span><br><span>         /*=
 Run dns updown directly */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        status =3D do_run_up_down_command(up, NULL, dns, tt);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        status =3D do_run_u=
p_down_command(dns, es);</span><br><span>     }</span><br><span>     else</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (updown_runner-&gt;pid &lt; 1)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        /* Need to set up privilege preserving child =
first */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(updown_runner-&gt;pid &lt; 1 &amp;&amp; !run_updown_runner(o, updown_runne=
r))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            /* Need to set up privilege preserving child first */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!run_u=
pdown_runner(up, o, tt, updown_runner))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                return;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return;</span><br><span>         }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        const char *dvf =3D platform_create_temp_file(o-&gt;tmp_dir, &qu=
ot;dvf&quot;, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (!dvf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        struct buffer vars =3D env_set_write_buffer(es, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        const uint32_t vars_s=
ize =3D (uint32_t)BLEN(&amp;vars);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (BLEN(&amp;vars) &gt; DNS_VARS_MAX_SIZE)</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         msg(M_ERR, &quot;could not create dns vars file&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            goto out_free;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &=
quot;dns vars exceed the maximum size&quot;);</span><br><span>         }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        struct env_set *es =3D env_set_crea=
te(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u=
pdown_env_set(up, &amp;o-&gt;dns_options, tt, es);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        env_set_write_file(dvf, es);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        int wfd =3D updown_runner-&gt;fds[1];</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        ssize_t dvf_size =3D=
 strlen(dvf) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    while (1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  else if (!write_pipe(updown_runner-&gt;fds[1], &amp;vars_size, sizeof(var=
s_size))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
      || !write_pipe(updown_runner-&gt;fds[1], BPTR(&amp;vars), vars_size))=
</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            ssize_t len =3D write(wfd, dvf, dvf_size);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (len &lt; dvf_size)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                if (len =3D=3D =
-1 &amp;&amp; errno =3D=3D EINTR)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    continue;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                msg(M_WARN | M_ERRNO, &quot;could not send dns =
vars filename&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_WARN | M_ERRNO, &quot;could not send dns vars&quot;);</span><br><s=
pan>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        int rfd =3D updown_r=
unner-&gt;fds[0];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    while (1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  else if (!read_pipe(updown_runner-&gt;fds[0], &amp;status, sizeof(status)=
))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            ssize_t len =3D read(rfd, &amp;status, sizeof(status));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (len &=
lt; (ssize_t)sizeof(status))</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               if (len =3D=3D -1 &amp;&amp; errno =3D=3D EINTR)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    continue;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_WARN | M_ER=
RNO, &quot;could not receive dns updown status&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(M_WARN | M_ERRNO, &quot;could not r=
eceive dns updown status&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            status =3D -1;</span><br><span>         }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-out_free:</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        gc_free(&amp;gc);</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp=
;gc);</span><br><span>     msg(M_INFO, &quot;dns %s command exited with sta=
tus %d&quot;, up ? &quot;up&quot; : &quot;down&quot;, status);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> #endif /* _WIN32 */</span><br><span> </s=
pan><br><span> void</span><br><span>diff --git a/src/openvpn/env_set=2Ec b/=
src/openvpn/env_set=2Ec</span><br><span>index 55190b8=2E=2E9494851 100644</=
span><br><span>--- a/src/openvpn/env_set=2Ec</span><br><span>+++ b/src/open=
vpn/env_set=2Ec</span><br><span>@@ -232,28 +232,22 @@</span><br><span>     =
}</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
env_set_write_file(const char *path, const struct env_set *es)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+struct buffer</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+env_set_write_buffer(const struct env_=
set *es, struct gc_arena *gc)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    FILE *fp =3D platform_fopen(path, &quot;w&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!fp)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t size =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const struc=
t env_item *e =3D es ? es-&gt;list : NULL; e; e =3D e-&gt;next)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ms=
g(M_ERR, &quot;could not write env set to &#39;%s&#39;&quot;, path);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        size +=3D strlen(e-&gt;s=
tring) + 1;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (es)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(size, gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const struct=
 env_item *e =3D es ? es-&gt;list : NULL; e; e =3D e-&gt;next)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        con=
st struct env_item *item =3D es-&gt;list;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        while (item)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            fputs(item-&gt;string, fp);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            fputc(&#39;\n&#39;, fp);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            item =3D item-&gt;next;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(buf_write(&amp;b=
uf, e-&gt;string, strlen(e-&gt;string) + 1));</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fclose=
(fp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf=
;</span><br><span> }</span><br><span> </span><br><span> void</span><br><spa=
n>diff --git a/src/openvpn/env_set=2Eh b/src/openvpn/env_set=2Eh</span><br>=
<span>index fcfc3ca=2E=2E24d3bde 100644</span><br><span>--- a/src/openvpn/e=
nv_set=2Eh</span><br><span>+++ b/src/openvpn/env_set=2Eh</span><br><span>@@=
 -88,12 +88,17 @@</span><br><span> void env_set_print(msglvl_t msglevel, co=
nst struct env_set *es);</span><br><span> </span><br><span> /**</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * Write a struct env_set to a fi=
le=2E Each item on one line=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Write the items of an env set into a buffer</span><br><span> =
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param path  The=
 filepath to write to=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @param es    Pointer to the env_set to write=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * The items are written as NUL terminate=
d name=3Dvalue strings, one after</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * the other=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am  es       env set to write</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param  gc       gc arena to allocate the buffer from</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return struct buffer containing the items=
</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
void env_set_write_file(const char *path, const struct env_set *es);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer env_set_writ=
e_buffer(const struct env_set *es, struct gc_arena *gc);</span><br><span> <=
/span><br><span> void env_set_inherit(struct env_set *es, const struct env_=
set *src);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2348?usp=3Demail">change 2348</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0d772af38b66799499=
b1b5729915ed77c438441 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2348 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigentli=
ch=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--jbEJZqMoXqg=--


--===============0006147029033803959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0006147029033803959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0006147029033803959==--

