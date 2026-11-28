Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC51606A31F
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fO9BEyBu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=U5qGEB+b;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UGsmo0Ub;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=L51SsVz0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Oqegj0fixd8a6tIhD3/PPg0OZwnGNFoDboAD4s2XTNo=; b=fO9BEyBuacUnlNcSZZWpJYw0i7
	+su4vLAlrAjOuqHwIkXbX025wpkkdqUchIuLVig8qg7TdZWFI9hOzDUfBcQBMCwVVh8UdgEc+vry3
	l3d1TYiQCa66XLUUB0dVYB3FVhQ11GTMuvDMSV5bMfEO7Sx64nUvNkdYyNKoVcBaw24c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX6ZL-00000000707-10Z0;
	Sat, 28 Nov 2026 00:45:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX6ZK-00000000700-0uh6
 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 00:45:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bcjeMnlwA2eZIFWSsEnDjULWRDomPOqHP1RNtLqZZOg=; b=U5qGEB+bx9HEkrA7PWAckqB5uE
 2fxvFu8/B1nkTUpMDxNZ8JCceg3u11sic5F9Lt9mzhxamSp5PUnU0YBx02vbX43suMCmu8/BN+v1b
 G2LrkxgcxDHIp7ArrAm0hzz9LVHcOU5XjLKDaKIL/jzNqcgM/1YscceVsYHFIoE7ETh4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bcjeMnlwA2eZIFWSsEnDjULWRDomPOqHP1RNtLqZZOg=; b=UGsmo0UbpuidGocLRuJwiVmIo8
 FVmxhltm23mWHIyQBqpD/sYGdJbOLKgex/KkczStLhNylD602oHS+30FtpaS2UVp4aJWewwXVxrgB
 gXBIpXZx1P1+3AQtxFZwo/ubVppcpm3AVsriuXK3vSvlykIdehw7TB5jeDE0/9tRPPIM=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX6ZF-000000000o9-3GXS for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 00:45:34 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso62028865e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 16:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795826723; x=1796431523; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bcjeMnlwA2eZIFWSsEnDjULWRDomPOqHP1RNtLqZZOg=;
 b=L51SsVz0YOzKeRFAnpAhJKX0ZueNxCnNxo1+VGMvKxmY7QvmpB+CfNj5ek1/quUeKl
 Bag0hDA8bXp1xTz0FgWc7SN4IpEBn/bSLKlXgIWpPml3KMVx0x5Ky3Afa8qA3MLsNXTY
 cfqjggVB6hC1BdA8mjuWoCtDuRJDesXo/FByt8uXVF4GzFBf09apD9TO1GldLxY1AROl
 Jac3xEALYCyNwcRKm5a1W6cUEzQSVb/Gw9TYqTz9QJoCC8TIQaYo++fk/GjDSKxIMT5T
 KYqfhzmFi3kMuL6rJ+RxThgB9iZrPcZ/RHAxq6zEBJdRJCran6n7IOhnjHtGvBVSifew
 oUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795826723; x=1796431523;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bcjeMnlwA2eZIFWSsEnDjULWRDomPOqHP1RNtLqZZOg=;
 b=hBR+eiaj9hrMQ1YyBZaYORPInsb6gYB571ZGKx7sN3xYvKNM5pip62ja3MAln+jjyQ
 XamKHQap8DPVVdeS14aQkNk9C1jcGgiQl7wNyPgaycra0T3UkW13mMI0Z38HFb70gPgJ
 GxDUOR+IIPxRcbrTFOyT6HQYdzpZr/hNfwtILd/EdifeUwd2W9/5K2kxbVRIw+n1hljE
 mV9a460dHsZ8sPRRqhbxhVEPcc8lAT4ogPFucsJvD5E/ejRNlltdWJFkDMxsxvSxmo9U
 2e+8DPA1odrfPEvhZ2mCF2H8W2tKvrqFMmH34HmpxNqDwrbkZzlbPNadeSQeEMSVfcq7
 FWBw==
X-Gm-Message-State: APuU4Z9y+1t8efwMJlDHS0O1LgJik27N2FlpIw/X/GSZw/gW/PHovhPu
 ajZiqt3GhylCh+wumsvM53xseNYJlOAkR609nbtZy7vL0y2ESL6WQf5KVzGySqAHvr141QLBgRJ
 gXnDTvliAz1+Um9QVuNt99tRVZmKOU9ifDUJOInTE5+Pbgt2a6q+CF8N+5mQlqarfboTjreLPwI
 OEtf/umw==
X-Gm-Gg: AZFdTZdG6K/hQaOogMUdxk90cuAe8upMPrBlysZ4GztAt0Ueq8QwZP/UCsJDFe/CEJJ
 UR49DQdeHTa2u5T8UwnyoekA3Ik0iAlTXX+8QMqHeZCrV6iySed79QBC7CbnPY9GOJQD58iGB0u
 yMH0x4PAEWKUsFd4OesEXH50SHmOGCdeXhspaoDTZNNs/LxWwfVJxtGkIrn40RHZKqoojAqDezO
 gjxCmSZVry8s+jNLfF6q/vxgIMcI/rQO44EKsZLVep/N5GjRzq0uodCktL9j+XGrz2EyMkiJYMR
 it2GjWsuK2mwZWILpjNH/fWJbgxfw86WPXU0geNmpeyrgBHSpoBckJ2A2Nj8AfjymgWYyiRSBcb
 JDf6EboyIT6/Sj1bNZ3QtcvqEwATCUwVfKEUaprSxA18Oh6vi+TYundohChWUCKC99pE4m2ol7m
 xPO4/F9MxVDrbzNfLFG64GITNPRW2PtpZH2A85ToY6vMb/8t5jNN558vOXnZvziCe0DWCrT6yPD
 0S94Ohz+tAFCBf20Je0eVXhM4JrXusZL5ZkMtIFeDqm4XRQqBKNgrO9v5hxHHtfOK1E3NLmOqv+
 yyyYkkFkUTYqkpPDJOVmxqurOIpWaStjNeVIIOUIUxULOB2uieQVTMMDacKTIzOIabyAeM2fufQ
 qKO8QszbpuFpZrIwP8REkAO8KeQ3Ap5jAgTCdA2yXx3aG7JCNUU8f5HNYwoCxafFf/68gWsJnkE
 7ANVftPDsfMvbC/3A=
X-Received: by 2002:a05:600c:530e:b0:4ba:eb:eb9b with SMTP id
 5b1f17b1804b1-4bb8880aba2mr517304845e9.8.1795826722886; 
 Fri, 27 Nov 2026 16:45:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b8429sm1143620555e9.14.2026.11.27.16.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 16:45:22 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 28 Nov 2026 00:45:20 +0000
To: Deri Haerudi <abcderyscreenprinting@gmail.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c438441
X-Gerrit-Change-Number: 2348
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2348?usp=email>
X-Gerrit-Commit: 8b8786bbf9cdcb7d8330cf1d4cfc1c627c736d46
In-Reply-To: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
References: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkllMGQ3NzJhZjM4YjY2Nzk5NDk5YjFiNTcyOTkxNWVkNzdjNDM4NDQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fa70615088ac855f0a5bba1bccedcfb861f6fc48-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX6ZF-000000000o9-3GXS
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
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 abcderyscreenprinting@gmail.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8110281902066683683=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8110281902066683683==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XzkWthWwPus="; charset=UTF-8

--XzkWthWwPus=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Deri Haerudi, Heiko Hun=
d, R=C4=83zvan Cojocaru=2E

Hello Arne Schwabe, Deri Haerudi, R=C4=83zvan C=
ojocaru, 

I'd like you to reexamine a change=2E Please visit

    https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail

to look at the new pat=
ch set (#3)=2E

The following approvals got outdated and were removed:
Code=
-Review+1 by Deri Haerudi, Code-Review+2 by R=C4=83zvan Cojocaru

The chang=
e is no longer submittable: Code-Review and checks~ChecksSubmitRule are uns=
atisfied now=2E


Change subject: dns: pass dns vars to the updown runner v=
ia pipe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dns:=
 pass dns vars to the updown runner via pipe

The privileged runner had the=
 script source a temp file written by
the unprivileged process and unlinked=
 its path unchecked, so another
process running as the --user could run cod=
e as root=2E

Send the vars over the pipe instead=2E The dns scripts no lon=
ger source
a vars file=2E

Reported-by: Paul Jenkins <Paul@northit=2Eco=2Eu=
k>
Reported-by: Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
Reported-b=
y: Bhabani Sankar Das <007bsd@proton=2Eme>
Change-Id: Ie0d772af38b66799499b=
1b5729915ed77c438441
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Ene=
t>
---
M Changes=2Emd
M distro/dns-scripts/haikuos_file-dns-updown=2Esh
M d=
istro/dns-scripts/macos-dns-updown=2Esh
M distro/dns-scripts/openresolv-dns=
-updown=2Esh
M distro/dns-scripts/resolvconf_file-dns-updown=2Esh
M distro/=
dns-scripts/systemd-dns-updown=2Esh
M src/openvpn/dns=2Ec
M src/openvpn/env=
_set=2Ec
M src/openvpn/env_set=2Eh
9 files changed, 188 insertions(+), 148 =
deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/48/2348/3

diff --git a/Changes=2Emd b/Changes=2Emd
index 5d5697f0=
=2E=2E8d10d1e 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -48,6 +48,15 =
@@
   `--pkcs11-providers provider=2Edll`, need to be given with their full=
 path,
   unless they are located in one of the directories listed above=2E=

 
+* **`--dns-updown` commands no longer get a `dns_vars_file`**
+
+  When=
 running with `--user`, OpenVPN used to pass the DNS settings to the
+  `--=
dns-updown` command in a temporary file named in the `dns_vars_file`
+  env=
ironment variable=2E The settings are now always passed as environment
+  v=
ariables, the same way as without `--user`=2E If your own `--dns-updown`
+ =
 command sources `dns_vars_file`, you can remove that, the variable is no
+=
  longer set=2E
+
 ## Maintainer-visible changes
 
 - The configure-time op=
tion `--enable-debug` is no longer  available
diff --git a/distro/dns-scrip=
ts/haikuos_file-dns-updown=2Esh b/distro/dns-scripts/haikuos_file-dns-updow=
n=2Esh
index 04e9e26=2E=2Ed8bf577 100644
--- a/distro/dns-scripts/haikuos_f=
ile-dns-updown=2Esh
+++ b/distro/dns-scripts/haikuos_file-dns-updown=2Esh
@=
@ -7,10 +7,6 @@
 #
 # Example env from openvpn (most are not applied):
 #
-=
#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c=2Etmp
-=
#
-#      or
-#
 #   dev tun0
 #   script_type dns-up
 #   dns_search_domai=
n_1 mycorp=2Ein
@@ -43,7 +39,6 @@
 
 conf=3D/boot/system/settings/network/r=
esolv=2Econf
 test -e "$conf" || exit 1
-test -z "${dns_vars_file}" || =2E =
"${dns_vars_file}"
 case "${script_type}" in
 dns-up)
     n=3D1
diff --git=
 a/distro/dns-scripts/macos-dns-updown=2Esh b/distro/dns-scripts/macos-dns-=
updown=2Esh
index fccc6b5=2E=2Eb6b93f8 100644
--- a/distro/dns-scripts/maco=
s-dns-updown=2Esh
+++ b/distro/dns-scripts/macos-dns-updown=2Esh
@@ -8,10 +=
8,6 @@
 #
 # Example env from openvpn (most are not applied):
 #
-#   dns_v=
ars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c=2Etmp
-#
-#     =
 or
-#
 #   dev utun0
 #   script_type dns-up
 #   dns_search_domain_1 myco=
rp=2Ein
@@ -43,8 +39,6 @@
 done
 trap "/bin/rm -f ${lockfile}" EXIT
 
-[ -z=
 "${dns_vars_file}" ] || =2E "${dns_vars_file}"
-
 itf_dns_key=3D"State:/Ne=
twork/Service/openvpn-${dev}/DNS"
 
 function primary_dns_key {
diff --git =
a/distro/dns-scripts/openresolv-dns-updown=2Esh b/distro/dns-scripts/openre=
solv-dns-updown=2Esh
index 4aca99f=2E=2E4865031 100644
--- a/distro/dns-scr=
ipts/openresolv-dns-updown=2Esh
+++ b/distro/dns-scripts/openresolv-dns-upd=
own=2Esh
@@ -8,10 +8,6 @@
 #
 # Example env from openvpn (most are not appl=
ied):
 #
-#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c5=
3c=2Etmp
-#
-#      or
-#
 #   dev tun0
 #   script_type dns-up
 #   dns_se=
arch_domain_1 mycorp=2Ein
@@ -42,7 +38,6 @@
     done
 }
 
-[ -z "${dns_var=
s_file}" ] || =2E "${dns_vars_file}"
 : ${script_type:=3Ddns-down}
 case "$=
{script_type}" in
 dns-up)
diff --git a/distro/dns-scripts/resolvconf_file-=
dns-updown=2Esh b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh
index =
78bf9d3=2E=2Ed68c00d 100644
--- a/distro/dns-scripts/resolvconf_file-dns-up=
down=2Esh
+++ b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh
@@ -7,10=
 +7,6 @@
 #
 # Example env from openvpn (most are not applied):
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
@@ -43,7 +39,6 @@
 
 conf=3D/etc/resolv=2Econf
 test -e "$conf" ||=
 exit 1
-test -z "${dns_vars_file}" || =2E "${dns_vars_file}"
 case "${scri=
pt_type}" in
 dns-up)
     n=3D1
diff --git a/distro/dns-scripts/systemd-dn=
s-updown=2Esh b/distro/dns-scripts/systemd-dns-updown=2Esh
index 3bdaa4b=2E=
=2Eff6f982 100644
--- a/distro/dns-scripts/systemd-dns-updown=2Esh
+++ b/di=
stro/dns-scripts/systemd-dns-updown=2Esh
@@ -15,10 +15,6 @@
 #
 # Example e=
nv from openvpn (not all are always applied):
 #
-#   dns_vars_file /tmp/op=
envpn_dvf_58b95c0c97b2db43afb5d745f986c53c=2Etmp
-#
-#      or
-#
 #   dev =
tun0
 #   script_type dns-up
 #   dns_search_domain_1 mycorp=2Ein
@@ -34,8 =
+30,6 @@
 #   dns_server_1_sni dns=2Emycorp=2Ein
 #
 
-[ -z "${dns_vars_fil=
e}" ] || =2E "${dns_vars_file}"
-
 function do_resolved_servers {
     loca=
l sni=3D""
     local transport_var=3Ddns_server_${n}_transport
diff --git =
a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index e2cb981=2E=2E1bd6c85 1006=
44
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -587,23 +587,113 =
@@
     setenv_dns_options(o, es);
 }
 
-static int
-do_run_up_down_command=
(bool up, const char *vars_file, const struct dns_options *o,
-            =
           const struct tuntap *tt)
+/** Maximum size in bytes of the dns v=
ars sent to the updown runner */
+#define DNS_VARS_MAX_SIZE (64 * 1024)
+
+=
/**
+ * Add dns vars received by the updown runner to an env set
+ *
+ * Ev=
ery var must be a name=3Dvalue pair=2E If anything is invalid, the vars
+ *=
 are rejected as a whole=2E
+ *
+ * @param  vars     NUL terminated name=3D=
value strings, modified in place
+ * @param  size     size of @p vars in by=
tes
+ * @param  es       env set to add the vars to
+ *
+ * @return bool to=
 indicate success or failure
+ */
+static bool
+dns_vars_setenv(char *vars,=
 size_t size, struct env_set *es)
 {
-    struct gc_arena gc =3D gc_new();
=
+    if (size > 0 && vars[size - 1] !=3D '\0')
+    {
+        return false=
;
+    }
+
+    const char *const end =3D vars + size;
+    char *var =3D v=
ars;
+    while (var < end)
+    {
+        const size_t var_size =3D strle=
n(var);
+        char *next =3D var + var_size + 1;
+        char *eq =3D m=
emchr(var, '=3D', var_size);
+        if (!eq)
+        {
+            retu=
rn false;
+        }
+
+        *eq =3D '\0';
+        setenv_str(es, var, =
eq + 1);
+        var =3D next;
+    }
+
+    return true;
+}
+
+/**
+ * Re=
ad from a pipe until the requested amount of data has arrived
+ *
+ * @para=
m  fd       file descriptor to read from
+ * @param  data     buffer to rea=
d into
+ * @param  size     number of bytes to read
+ *
+ * @return bool to=
 indicate success or failure
+ */
+static bool
+read_pipe(int fd, void *dat=
a, size_t size)
+{
+    uint8_t *p =3D data;
+    while (size > 0)
+    {
+=
        const ssize_t len =3D read(fd, p, size);
+        if (len =3D=3D -1=
 && errno =3D=3D EINTR)
+        {
+            continue;
+        }
+     =
   if (len < 1)
+        {
+            return false;
+        }
+        p=
 +=3D len;
+        size -=3D (size_t)len;
+    }
+    return true;
+}
+
+/=
**
+ * Write to a pipe until all data has been written
+ *
+ * @param  fd  =
     file descriptor to write to
+ * @param  data     data to write
+ * @pa=
ram  size     number of bytes to write
+ *
+ * @return bool to indicate suc=
cess or failure
+ */
+static bool
+write_pipe(int fd, const void *data, siz=
e_t size)
+{
+    const uint8_t *p =3D data;
+    while (size > 0)
+    {
+=
        const ssize_t len =3D write(fd, p, size);
+        if (len =3D=3D -=
1 && errno =3D=3D EINTR)
+        {
+            continue;
+        }
+    =
    if (len < 1)
+        {
+            return false;
+        }
+        =
p +=3D len;
+        size -=3D (size_t)len;
+    }
+    return true;
+}
+
+=
static int
+do_run_up_down_command(const struct dns_options *o, const struc=
t env_set *es)
+{
     struct argv argv =3D argv_new();
-    struct env_set=
 *es =3D env_set_create(&gc);
-
-    if (vars_file)
-    {
-        setenv_=
str(es, "dns_vars_file", vars_file);
-    }
-    else
-    {
-        updow=
n_env_set(up, o, tt, es);
-    }
-
     argv_printf(&argv, "%s", o->updown)=
;
     argv_msg(M_INFO, &argv);
     int res;
@@ -616,13 +706,11 @@
       =
  res =3D openvpn_execve_check(&argv, es, S_EXITCODE, "WARNING: Failed runn=
ing dns updown");
     }
     argv_free(&argv);
-    gc_free(&gc);
     ret=
urn res;
 }
 
 static bool
-run_updown_runner(bool up, struct options *o, c=
onst struct tuntap *tt,
-                  struct dns_updown_runner_info *u=
pdown_runner)
+run_updown_runner(struct options *o, struct dns_updown_runne=
r_info *updown_runner)
 {
     int dns_pipe_fd[2];
     int ack_pipe_fd[2];=

@@ -675,56 +763,58 @@
         signal(SIGUSR2, SIG_IGN);
         signal(S=
IGPIPE, SIG_IGN);
 
+        char *vars =3D malloc(DNS_VARS_MAX_SIZE);
+   =
     check_malloc_return(vars);
+
         while (1)
         {
-          =
  char path[PATH_MAX];
+            uint32_t vars_size;
 
-            /* B=
lock here until parent sends a path */
-            ssize_t rlen =3D read(d=
ns_pipe_fd[0], &path, sizeof(path));
-            if (rlen < 1)
+          =
  /* Block here until parent sends the dns vars */
+            if (!read_p=
ipe(dns_pipe_fd[0], &vars_size, sizeof(vars_size)))
             {
-       =
         if (rlen =3D=3D -1 && errno =3D=3D EINTR)
-                {
-    =
                continue;
-                }
-                close(dns_pip=
e_fd[0]);
-                close(ack_pipe_fd[1]);
-                exit(0);=

+                break;
+            }
+            if (vars_size > DNS_VA=
RS_MAX_SIZE)
+            {
+                msg(M_WARN, "dns updown: recei=
ved dns vars are too large");
+                break;
+            }
+     =
       if (!read_pipe(dns_pipe_fd[0], vars, vars_size))
+            {
+   =
             break;
             }
 
-            path[sizeof(path) - 1] =
=3D '\0';
-            int res =3D do_run_up_down_command(up, path, &o->dns=
_options, tt);
-            platform_unlink(path);
+            int res =3D=
 -1;
+            struct gc_arena gc =3D gc_new();
+            struct env_=
set *es =3D env_set_create(&gc);
+            if (dns_vars_setenv(vars, var=
s_size, es))
+            {
+                res =3D do_run_up_down_command=
(&o->dns_options, es);
+            }
+            else
+            {
+   =
             msg(M_WARN, "dns updown: received invalid dns vars");
+       =
     }
+            gc_free(&gc);
 
             /* Unblock parent process =
*/
-            while (1)
+            if (!write_pipe(ack_pipe_fd[1], &res=
, sizeof(res)))
             {
-                ssize_t wlen =3D write(ack_=
pipe_fd[1], &res, sizeof(res));
-                if ((wlen =3D=3D -1 && err=
no !=3D EINTR) || wlen < (ssize_t)sizeof(res))
-                {
-        =
            /* Not much we can do about errors but exit */
-               =
     close(dns_pipe_fd[0]);
-                    close(ack_pipe_fd[1]);
-  =
                  exit(0);
-                }
-                else if (wle=
n =3D=3D sizeof(res))
-                {
-                    break;
-     =
           }
+                break;
             }
-
-            up =3D !=
up; /* do the opposite next time */
         }
+
+        /* Not much we ca=
n do about errors but exit */
+        free(vars);
+        close(dns_pipe_=
fd[0]);
+        close(ack_pipe_fd[1]);
+        exit(0);
     }
 
     ret=
urn true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC di=
agnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-=

 static void
 run_up_down_command(bool up, struct options *o, const struct=
 tuntap *tt,
                     struct dns_updown_runner_info *updown_run=
ner)
@@ -736,77 +826,46 @@
     }
 
     int status =3D -1;
+    struct gc_=
arena gc =3D gc_new();
+    struct env_set *es =3D env_set_create(&gc);
+  =
  updown_env_set(up, dns, tt, es);
 
     if (!updown_runner->required)
   =
  {
         /* Run dns updown directly */
-        status =3D do_run_up_do=
wn_command(up, NULL, dns, tt);
+        status =3D do_run_up_down_command(d=
ns, es);
     }
     else
     {
-        if (updown_runner->pid < 1)
+    =
    /* Need to set up privilege preserving child first */
+        if (updo=
wn_runner->pid < 1 && !run_updown_runner(o, updown_runner))
         {
-   =
         /* Need to set up privilege preserving child first */
-           =
 if (!run_updown_runner(up, o, tt, updown_runner))
-            {
-        =
        return;
-            }
+            gc_free(&gc);
+            retu=
rn;
         }
 
-        struct gc_arena gc =3D gc_new();
-        const c=
har *dvf =3D platform_create_temp_file(o->tmp_dir, "dvf", &gc);
-        if=
 (!dvf)
+        struct buffer vars =3D env_set_write_buffer(es, &gc);
+   =
     const uint32_t vars_size =3D (uint32_t)BLEN(&vars);
+        if (BLEN(=
&vars) > DNS_VARS_MAX_SIZE)
         {
-            msg(M_ERR, "could not c=
reate dns vars file");
-            goto out_free;
+            msg(M_WARN,=
 "dns vars exceed the maximum size");
         }
-
-        struct env_set =
*es =3D env_set_create(&gc);
-        updown_env_set(up, &o->dns_options, t=
t, es);
-        env_set_write_file(dvf, es);
-
-        int wfd =3D updown=
_runner->fds[1];
-        ssize_t dvf_size =3D strlen(dvf) + 1;
-        wh=
ile (1)
+        else if (!write_pipe(updown_runner->fds[1], &vars_size, si=
zeof(vars_size))
+                 || !write_pipe(updown_runner->fds[1], BP=
TR(&vars), vars_size))
         {
-            ssize_t len =3D write(wfd, d=
vf, dvf_size);
-            if (len < dvf_size)
-            {
-           =
     if (len =3D=3D -1 && errno =3D=3D EINTR)
-                {
-         =
           continue;
-                }
-                msg(M_WARN | M_ERR=
NO, "could not send dns vars filename");
-            }
-            break;=

+            msg(M_WARN | M_ERRNO, "could not send dns vars");
         }
=
-
-        int rfd =3D updown_runner->fds[0];
-        while (1)
+        e=
lse if (!read_pipe(updown_runner->fds[0], &status, sizeof(status)))
       =
  {
-            ssize_t len =3D read(rfd, &status, sizeof(status));
-     =
       if (len < (ssize_t)sizeof(status))
-            {
-                i=
f (len =3D=3D -1 && errno =3D=3D EINTR)
-                {
-               =
     continue;
-                }
-                msg(M_WARN | M_ERRNO, "c=
ould not receive dns updown status");
-            }
-            break;
+ =
           msg(M_WARN | M_ERRNO, "could not receive dns updown status");
+ =
           status =3D -1;
         }
-
-out_free:
-        gc_free(&gc);
  =
   }
 
+    gc_free(&gc);
     msg(M_INFO, "dns %s command exited with stat=
us %d", up ? "up" : "down", status);
 }
 
-#if defined(__GNUC__) || defined=
(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* _WIN32 */
 
 v=
oid
diff --git a/src/openvpn/env_set=2Ec b/src/openvpn/env_set=2Ec
index 55=
190b8=2E=2E9494851 100644
--- a/src/openvpn/env_set=2Ec
+++ b/src/openvpn/e=
nv_set=2Ec
@@ -232,28 +232,22 @@
     }
 }
 
-void
-env_set_write_file(cons=
t char *path, const struct env_set *es)
+struct buffer
+env_set_write_buffe=
r(const struct env_set *es, struct gc_arena *gc)
 {
-    FILE *fp =3D platf=
orm_fopen(path, "w");
-    if (!fp)
+    size_t size =3D 0;
+    for (const=
 struct env_item *e =3D es ? es->list : NULL; e; e =3D e->next)
     {
-   =
     msg(M_ERR, "could not write env set to '%s'", path);
-        return;
=
+        size +=3D strlen(e->string) + 1;
     }
 
-    if (es)
+    struct=
 buffer buf =3D alloc_buf_gc(size, gc);
+    for (const struct env_item *e =
=3D es ? es->list : NULL; e; e =3D e->next)
     {
-        const struct en=
v_item *item =3D es->list;
-        while (item)
-        {
-            fp=
uts(item->string, fp);
-            fputc('\n', fp);
-            item =3D =
item->next;
-        }
+        ASSERT(buf_write(&buf, e->string, strlen(e-=
>string) + 1));
     }
 
-    fclose(fp);
+    return buf;
 }
 
 void
diff =
--git a/src/openvpn/env_set=2Eh b/src/openvpn/env_set=2Eh
index fcfc3ca=2E=
=2E24d3bde 100644
--- a/src/openvpn/env_set=2Eh
+++ b/src/openvpn/env_set=
=2Eh
@@ -88,12 +88,17 @@
 void env_set_print(msglvl_t msglevel, const struc=
t env_set *es);
 
 /**
- * Write a struct env_set to a file=2E Each item on=
 one line=2E
+ * Write the items of an env set into a buffer
  *
- * @param=
 path  The filepath to write to=2E
- * @param es    Pointer to the env_set =
to write=2E
+ * The items are written as NUL terminated name=3Dvalue string=
s, one after
+ * the other=2E
+ *
+ * @param  es       env set to write
+ *=
 @param  gc       gc arena to allocate the buffer from
+ *
+ * @return stru=
ct buffer containing the items
  */
-void env_set_write_file(const char *pa=
th, const struct env_set *es);
+struct buffer env_set_write_buffer(const st=
ruct env_set *es, struct gc_arena *gc);
 
 void env_set_inherit(struct env_=
set *es, const struct env_set *src);
 

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c438441
Gerrit-=
Change-Number: 2348
Gerrit-PatchSet: 3
Gerrit-Owner: Heiko Hund <heiko@ist=
=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
Gerr=
it-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Deri Ha=
erudi <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Attention: Heiko Hund <hei=
ko@ist=2Eeigentlich=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--XzkWthWwPus=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Deri Haerudi, Heiko Hund, R=C4=83zvan C=
ojocaru=2E </p>
<p>Heiko Hund <strong>uploaded patch set #3</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/234=
8?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+1 by Deri Haerudi, Code-Review+2 by R=C4=83zva=
n Cojocaru</p><p>The change is no longer submittable: Code-Review and check=
s~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">dns: pass dns va=
rs to the updown runner via pipe<br><br>The privileged runner had the scrip=
t source a temp file written by<br>the unprivileged process and unlinked it=
s path unchecked, so another<br>process running as the --user could run cod=
e as root=2E<br><br>Send the vars over the pipe instead=2E The dns scripts =
no longer source<br>a vars file=2E<br><br>Reported-by: Paul Jenkins &lt;Pau=
l@northit=2Eco=2Euk&gt;<br>Reported-by: Deri Haerudi &lt;abcderyscreenprint=
ing@gmail=2Ecom&gt;<br>Reported-by: Bhabani Sankar Das &lt;007bsd@proton=2E=
me&gt;<br>Change-Id: Ie0d772af38b66799499b1b5729915ed77c438441<br>Signed-of=
f-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M Changes=
=2Emd<br>M distro/dns-scripts/haikuos_file-dns-updown=2Esh<br>M distro/dns-=
scripts/macos-dns-updown=2Esh<br>M distro/dns-scripts/openresolv-dns-updown=
=2Esh<br>M distro/dns-scripts/resolvconf_file-dns-updown=2Esh<br>M distro/d=
ns-scripts/systemd-dns-updown=2Esh<br>M src/openvpn/dns=2Ec<br>M src/openvp=
n/env_set=2Ec<br>M src/openvpn/env_set=2Eh<br>9 files changed, 188 insertio=
ns(+), 148 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/48/2348/3</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/Cha=
nges=2Emd b/Changes=2Emd</span><br><span>index 5d5697f0=2E=2E8d10d1e 100644=
</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=2Emd</spa=
n><br><span>@@ -48,6 +48,15 @@</span><br><span>   `--pkcs11-providers provi=
der=2Edll`, need to be given with their full path,</span><br><span>   unles=
s they are located in one of the directories listed above=2E</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **`--dns-updow=
n` commands no longer get a `dns_vars_file`**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  When running with `--user`, OpenVPN used to pass the DNS settings =
to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `--dns-updo=
wn` command in a temporary file named in the `dns_vars_file`</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  environment variable=2E The sett=
ings are now always passed as environment</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  variables, the same way as without `--user`=2E If y=
our own `--dns-updown`</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  command sources `dns_vars_file`, you can remove that, the variable is =
no</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  longer set=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ## =
Maintainer-visible changes</span><br><span> </span><br><span> - The configu=
re-time option `--enable-debug` is no longer  available</span><br><span>dif=
f --git a/distro/dns-scripts/haikuos_file-dns-updown=2Esh b/distro/dns-scri=
pts/haikuos_file-dns-updown=2Esh</span><br><span>index 04e9e26=2E=2Ed8bf577=
 100644</span><br><span>--- a/distro/dns-scripts/haikuos_file-dns-updown=2E=
sh</span><br><span>+++ b/distro/dns-scripts/haikuos_file-dns-updown=2Esh</s=
pan><br><span>@@ -7,10 +7,6 @@</span><br><span> #</span><br><span> # Exampl=
e env from openvpn (most are not applied):</span><br><span> #</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#   dns_vars_file /tmp/openvpn_dvf_=
58b95c0c97b2db43afb5d745f986c53c=2Etmp</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  =
    or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><sp=
an> #   dev tun0</span><br><span> #   script_type dns-up</span><br><span> #=
   dns_search_domain_1 mycorp=2Ein</span><br><span>@@ -43,7 +39,6 @@</span>=
<br><span> </span><br><span> conf=3D/boot/system/settings/network/resolv=2E=
conf</span><br><span> test -e &quot;$conf&quot; || exit 1</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-test -z &quot;${dns_vars_file}&quot; ||=
 =2E &quot;${dns_vars_file}&quot;</span><br><span> case &quot;${script_type=
}&quot; in</span><br><span> dns-up)</span><br><span>     n=3D1</span><br><s=
pan>diff --git a/distro/dns-scripts/macos-dns-updown=2Esh b/distro/dns-scri=
pts/macos-dns-updown=2Esh</span><br><span>index fccc6b5=2E=2Eb6b93f8 100644=
</span><br><span>--- a/distro/dns-scripts/macos-dns-updown=2Esh</span><br><=
span>+++ b/distro/dns-scripts/macos-dns-updown=2Esh</span><br><span>@@ -8,1=
0 +8,6 @@</span><br><span> #</span><br><span> # Example env from openvpn (m=
ost are not applied):</span><br><span> #</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d=
745f986c53c=2Etmp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#      or</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span> #   dev utun0</sp=
an><br><span> #   script_type dns-up</span><br><span> #   dns_search_domain=
_1 mycorp=2Ein</span><br><span>@@ -43,8 +39,6 @@</span><br><span> done</spa=
n><br><span> trap &quot;/bin/rm -f ${lockfile}&quot; EXIT</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-[ -z &quot;${dns_vars=
_file}&quot; ] || =2E &quot;${dns_vars_file}&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> itf_dns_key=3D&quot;State:/N=
etwork/Service/openvpn-${dev}/DNS&quot;</span><br><span> </span><br><span> =
function primary_dns_key {</span><br><span>diff --git a/distro/dns-scripts/=
openresolv-dns-updown=2Esh b/distro/dns-scripts/openresolv-dns-updown=2Esh<=
/span><br><span>index 4aca99f=2E=2E4865031 100644</span><br><span>--- a/dis=
tro/dns-scripts/openresolv-dns-updown=2Esh</span><br><span>+++ b/distro/dns=
-scripts/openresolv-dns-updown=2Esh</span><br><span>@@ -8,10 +8,6 @@</span>=
<br><span> #</span><br><span> # Example env from openvpn (most are not appl=
ied):</span><br><span> #</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c=2Etm=
p</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#      or</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#</span><br><span> #   dev tun0</span><br><span> #  =
 script_type dns-up</span><br><span> #   dns_search_domain_1 mycorp=2Ein</s=
pan><br><span>@@ -42,7 +38,6 @@</span><br><span>     done</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-[ =
-z &quot;${dns_vars_file}&quot; ] || =2E &quot;${dns_vars_file}&quot;</span=
><br><span> : ${script_type:=3Ddns-down}</span><br><span> case &quot;${scri=
pt_type}&quot; in</span><br><span> dns-up)</span><br><span>diff --git a/dis=
tro/dns-scripts/resolvconf_file-dns-updown=2Esh b/distro/dns-scripts/resolv=
conf_file-dns-updown=2Esh</span><br><span>index 78bf9d3=2E=2Ed68c00d 100644=
</span><br><span>--- a/distro/dns-scripts/resolvconf_file-dns-updown=2Esh</=
span><br><span>+++ b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh</sp=
an><br><span>@@ -7,10 +7,6 @@</span><br><span> #</span><br><span> # Example=
 env from openvpn (most are not applied):</span><br><span> #</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#   dns_vars_file /tmp/openvpn_dvf_5=
8b95c0c97b2db43afb5d745f986c53c=2Etmp</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#   =
   or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><spa=
n> #   dev tun0</span><br><span> #   script_type dns-up</span><br><span> # =
  dns_search_domain_1 mycorp=2Ein</span><br><span>@@ -43,7 +39,6 @@</span><=
br><span> </span><br><span> conf=3D/etc/resolv=2Econf</span><br><span> test=
 -e &quot;$conf&quot; || exit 1</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-test -z &quot;${dns_vars_file}&quot; || =2E &quot;${dns_vars_file=
}&quot;</span><br><span> case &quot;${script_type}&quot; in</span><br><span=
> dns-up)</span><br><span>     n=3D1</span><br><span>diff --git a/distro/dn=
s-scripts/systemd-dns-updown=2Esh b/distro/dns-scripts/systemd-dns-updown=
=2Esh</span><br><span>index 3bdaa4b=2E=2Eff6f982 100644</span><br><span>---=
 a/distro/dns-scripts/systemd-dns-updown=2Esh</span><br><span>+++ b/distro/=
dns-scripts/systemd-dns-updown=2Esh</span><br><span>@@ -15,10 +15,6 @@</spa=
n><br><span> #</span><br><span> # Example env from openvpn (not all are alw=
ays applied):</span><br><span> #</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c=
53c=2Etmp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#      or</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#</span><br><span> #   dev tun0</span><br><=
span> #   script_type dns-up</span><br><span> #   dns_search_domain_1 mycor=
p=2Ein</span><br><span>@@ -34,8 +30,6 @@</span><br><span> #   dns_server_1_=
sni dns=2Emycorp=2Ein</span><br><span> #</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-[ -z &quot;${dns_vars_file}&quot; ] ||=
 =2E &quot;${dns_vars_file}&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> function do_resolved_servers {</span><br><spa=
n>     local sni=3D&quot;&quot;</span><br><span>     local transport_var=3D=
dns_server_${n}_transport</span><br><span>diff --git a/src/openvpn/dns=2Ec =
b/src/openvpn/dns=2Ec</span><br><span>index e2cb981=2E=2E1bd6c85 100644</sp=
an><br><span>--- a/src/openvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dn=
s=2Ec</span><br><span>@@ -587,23 +587,113 @@</span><br><span>     setenv_dn=
s_options(o, es);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-do_run_up_down_command(bool up, const char *vars_file=
, const struct dns_options *o,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                       const struct tuntap *tt)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/** Maximum size in bytes of the dns v=
ars sent to the updown runner */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define DNS_VARS_MAX_SIZE (64 * 1024)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A=
dd dns vars received by the updown runner to an env set</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Every var must be a name=3Dvalue pair=2E If anything =
is invalid, the vars</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * are rejected as a whole=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram  vars     NUL terminated name=3Dvalue strings, modified in place</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  size     size o=
f @p vars in bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param  es       env set to add the vars to</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @return bool to indicate success or failure</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+dns_vars_setenv(char *vars, size_t size, struct env_set *es)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (size &gt; 0 &amp;&amp; vars[size - 1] !=3D &#39;\0&#39;=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const char *const end =3D vars + size;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    char *var =3D vars;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    while (var &lt; end)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        const size_t var_size =3D strlen(var)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *next=
 =3D var + var_size + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        char *eq =3D memchr(var, &#39;=3D&#39;, var_size);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!eq)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        *eq =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        setenv_str(es, var, eq + 1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        var =3D next;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Read from a pipe until the requested amount of da=
ta has arrived</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  fd       fi=
le descriptor to read from</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param  data     buffer to read into</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param  size     number of bytes to read</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return bool to indicate success or fa=
ilure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+read_pipe(int fd, void *data, size_t s=
ize)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *p =3D data;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    while (size &gt; 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        const ssize_t len =3D read(fd,=
 p, size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (len =3D=3D -1 &amp;&amp; errno =3D=3D EINTR)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            continue;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (len &lt; 1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        p +=3D len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        size -=3D (size_t)len;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Write to a pipe until all data has been written</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param  fd       file descriptor to wr=
ite to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  da=
ta     data to write</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param  size     number of bytes to write</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @return bool to indicate success or failure</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+write_pipe(int fd, const void *data, size_t size)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const uint8_t *p =3D data;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    while (size &gt; 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const ssize_t len =3D write(fd, p, size);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (len =3D=
=3D -1 &amp;&amp; errno =3D=3D EINTR)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            continue;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (len &lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p =
+=3D len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        si=
ze -=3D (size_t)len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+do_run_up_down_command(const struct dns_options *o, const stru=
ct env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span>     struct argv argv =3D argv_new();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct env_set *es =3D env_set_create(&=
amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (vars_file)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        setenv_str(es, &quot;dns_vars_file&quot;, var=
s_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        updown_env_set(up, o, tt, es);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span>     argv_printf(&amp;argv, &quot;%s&quo=
t;, o-&gt;updown);</span><br><span>     argv_msg(M_INFO, &amp;argv);</span>=
<br><span>     int res;</span><br><span>@@ -616,13 +706,11 @@</span><br><sp=
an>         res =3D openvpn_execve_check(&amp;argv, es, S_EXITCODE, &quot;W=
ARNING: Failed running dns updown&quot;);</span><br><span>     }</span><br>=
<span>     argv_free(&amp;argv);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    gc_free(&amp;gc);</span><br><span>     return res;</span><br=
><span> }</span><br><span> </span><br><span> static bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-run_updown_runner(bool up, struct option=
s *o, const struct tuntap *tt,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                  struct dns_updown_runner_info *updown_runner)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+run_updown_runner(stru=
ct options *o, struct dns_updown_runner_info *updown_runner)</span><br><spa=
n> {</span><br><span>     int dns_pipe_fd[2];</span><br><span>     int ack_=
pipe_fd[2];</span><br><span>@@ -675,56 +763,58 @@</span><br><span>         =
signal(SIGUSR2, SIG_IGN);</span><br><span>         signal(SIGPIPE, SIG_IGN)=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        char *vars =3D malloc(DNS_VARS_MAX_SIZE);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        check_malloc_return(vars);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         whil=
e (1)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            char path[PATH_MAX];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            uint32_t vars_size;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Block he=
re until parent sends a path */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            ssize_t rlen =3D read(dns_pipe_fd[0], &amp;path, size=
of(path));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (rlen &lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          /* Block here until parent sends the dns vars */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (!read_pipe(dns_pipe_=
fd[0], &amp;vars_size, sizeof(vars_size)))</span><br><span>             {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (rle=
n =3D=3D -1 &amp;&amp; errno =3D=3D EINTR)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    continue;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                close(dns_pipe_fd[0]);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                close(ack_pipe_fd[1])=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                exit=
(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (va=
rs_size &gt; DNS_VARS_MAX_SIZE)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                msg(M_WARN, &quot;dns updown: received dns vars are t=
oo large&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (!read_pipe(dns_pipe_fd[0], vars, vars_size))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                break;</span><br><span>       =
      }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            path[sizeof(path) - 1] =3D &#39;\0&#39;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            int res =3D do_run_up_down_c=
ommand(up, path, &amp;o-&gt;dns_options, tt);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            platform_unlink(path);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            int res =3D -1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         struct env_set *es =3D env_set_create(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (dns_vars_setenv(vars, =
vars_size, es))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      res =3D do_run_up_down_command(&amp;o-&gt;dns_options, es);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                msg(M_WARN, &quot;dns updown=
: received invalid dns vars&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            gc_free(&amp;gc);</span><br><span> </span><br><span> =
            /* Unblock parent process */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            while (1)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (!write_pipe(ack_pipe_fd[1], &amp;res, =
sizeof(res)))</span><br><span>             {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                ssize_t wlen =3D write(ack_pipe_fd[1=
], &amp;res, sizeof(res));</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                if ((wlen =3D=3D -1 &amp;&amp; errno !=3D EINTR) || wl=
en &lt; (ssize_t)sizeof(res))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    /* Not much we can do about errors but exit */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    close(=
dns_pipe_fd[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               close(ack_pipe_fd[1]);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    exit(0);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                else if (wlen =3D=3D sizeof(res))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    break;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                break;</span>=
<br><span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            up =3D=
 !up; /* do the opposite next time */</span><br><span>         }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* Not much we can do about errors but ex=
it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(v=
ars);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(=
dns_pipe_fd[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     close(ack_pipe_fd[1]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        exit(0);</span><br><span>     }</span><br><span> </span><br=
><span>     return true;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma=
 GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> static void</span><br><span> run_up_down=
_command(bool up, struct options *o, const struct tuntap *tt,</span><br><sp=
an>                     struct dns_updown_runner_info *updown_runner)</span=
><br><span>@@ -736,77 +826,46 @@</span><br><span>     }</span><br><span> </=
span><br><span>     int status =3D -1;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct env_set *es =3D env_set_crea=
te(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    upd=
own_env_set(up, dns, tt, es);</span><br><span> </span><br><span>     if (!u=
pdown_runner-&gt;required)</span><br><span>     {</span><br><span>         =
/* Run dns updown directly */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        status =3D do_run_up_down_command(up, NULL, dns, tt);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        status =3D do_run=
_up_down_command(dns, es);</span><br><span>     }</span><br><span>     else=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (updown_runner-&gt;pid &lt; 1)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* Need to set up privilege preserving chil=
d first */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (updown_runner-&gt;pid &lt; 1 &amp;&amp; !run_updown_runner(o, updown_run=
ner))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            /* Need to set up privilege preserving child first *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!run=
_updown_runner(up, o, tt, updown_runner))</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                return;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return;</span><br><span>         }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct=
 gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        const char *dvf =3D platform_create_temp_file(o-&gt;tmp_dir, &=
quot;dvf&quot;, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (!dvf)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        struct buffer vars =3D env_set_write_buffer(es, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const uint32_t vars=
_size =3D (uint32_t)BLEN(&amp;vars);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (BLEN(&amp;vars) &gt; DNS_VARS_MAX_SIZE)</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           msg(M_ERR, &quot;could not create dns vars file&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            goto out_free;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN,=
 &quot;dns vars exceed the maximum size&quot;);</span><br><span>         }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
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
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0d772af38b667994=
99b1b5729915ed77c438441 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2348 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigent=
lich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Deri Haerudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Deri Haerudi &lt;abcderyscreenprin=
ting@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--XzkWthWwPus=--


--===============8110281902066683683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8110281902066683683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8110281902066683683==--

