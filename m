Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6417606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ORxV9wyj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iUSIiUf+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kupMPXGf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=D62JHjhm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=SpSAAyIWD1/RFTayMG1ACgZ/Gho+IjbMmTVvrhMW4xw=; b=ORxV9wyj6de9GvonoXzMd1M0FD
	fQesK5CHPcOy84txSirllGMATswntuQ84UzZxbAyJ/Rz3m4aUCNVN0qcLsHYUqrIjWfkgqC/LR2nQ
	panO0zedYeuGULV9kttGX1VZTN77ZhhIuz8nj2PTvtaR7fKYCU4EyBT8xaCGdtZ/UKd8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTwyI-000000005Gc-06uE;
	Thu, 19 Nov 2026 07:54:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTwy4-000000005GK-2D1U
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 07:54:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pm09lPUolasLVKXm9p/G0pCeGFRFPVQhBAepxxQJkLs=; b=iUSIiUf+3suR4Aexumq/E+Tn1K
 zu8AzcIi8tcm+bn9itBhuueH3xAjSAP0es6yRJdOmhqBVnd9VuVe9AmqpDwtUoWMRFoVHiamkI3mb
 w68zU0ZEuiVzUUWROlsUoSoo1iOk/JAztQIoevq/g2Myeg2mw0kZ1CVs1l3ziYjQymH8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pm09lPUolasLVKXm9p/G0pCeGFRFPVQhBAepxxQJkLs=; b=kupMPXGfruNYO2GtieA5QIhfU5
 l1rHHlWOr3N3+J9kKq7R6XyGitZ77xWPK6p9ZvjRs/I8MAF70qndUOtEidfshfSjztnDlHf87DGwB
 /rp3+unkL5ubBLRvM/Z05K8YsxpK+Gyp0SdI6nSTSmrzkk83uKQU5wUctjJjPOeWj6Pc=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTwy3-000000005hf-195a for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 07:54:04 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so1250676f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 23:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795074837; x=1795679637; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pm09lPUolasLVKXm9p/G0pCeGFRFPVQhBAepxxQJkLs=;
 b=D62JHjhmAThi03/+3M7ZJGsEzY0KNADEeWYqAz3Odr7B66uz2ZDRwcIQImnQIstccM
 Q8IQ3VmM9a3SCkqGmWn6suvUSK98t7Mq2wWRkiB3UYVxgEXtZ1CZ4lQZp3N9WFr0gWV1
 OstkBpWeiYPKr3a/jZ0mwSyTECQ64NKMKSoRsWXBLrQO+2hePRrDUxD2W9b/KntS/agg
 bz1rSy0COIo04k3/d5b2sJJDmvXIGAwR1nkSFByvrxaspS1MS+XqmxwcZT4OOzkKAC3g
 K6qDaG4WjXT+xcFhX3HuzFnVV0OUdhbZNjJQArK3HrPUXEFOLHU3GGYugXZIuH31sRPq
 aEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795074837; x=1795679637;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pm09lPUolasLVKXm9p/G0pCeGFRFPVQhBAepxxQJkLs=;
 b=BEtECbKw7EM7Wr+B+60m7XTaDct5FmfE1mZvLq4aUL4nOVxHpGQpD9ydhAZbUguZ7U
 1VlJczMd8b8cMFpLRw7BPgnQfGPtUXpU4205abAwjDB971op26ZHi61oDnwDit7MzDuD
 +yS0aS+Jgs3bsnaU6A/BnrFXxp81XppqxdPZhH6OzxwE/S9MkoLen54RZlcgn5OCtrjq
 N0yQQIQTpVb9L7N0wE7tTzhSKXL/VKfubA6VH6+3F4TGagjYV4NAy+i/NWtsxjJsHA8d
 QPetwiDAZv6tBJTvm6sQPAGk8yR/wUM+krPpuYmnJ9MJ+JXQbjPMFQlXd5eKPRBgK+A/
 ZJrg==
X-Gm-Message-State: APuU4Z++wKZHUqpzTSoN4OV2+ObBc+bvgSQVYulYY0dqqgDawCUj2c5P
 9Gcj3tDT+io4GD0N+P89BR/Y6dg2M1yJEE/61GFlLbitbPVDvUOLRe1qzKuM+nvFH3QHLWFt5qT
 XiL+wGuDuDAyFeHBlBF4SGmEtMapuozxwmm6Oc9gth6hgPEddtsezsTAzqZZUwr0EYdwn0L8HN7
 pyVIJpCA==
X-Gm-Gg: AYBFou0mW+rz/qzX3vhQgyOTghnmhWzX1iPd2M0UVAQVw6xOGOjSoU6rBHMh+X8I6+Z
 tMafkLVpiMq4ddJncrX1Fbk07BkKVCvnse0M6R/QT1CnEZRjGHa1NlJZA1dCfnuLUpSBisHkwsE
 inUDzMYWScBlOZ/iuJXxP+d70wRNMjbMKGGhRBOcVVGBE5a7AWWU2UL0LS3IT4GbWfk1T/P9s7Z
 eyvxztwYmln/QRuV6+5wEjkUrBsbK83IiX1Dc1hcJDUR3M0drDW/ARGleHeV2ZSBq441CKkazK0
 NIu/VDP+5MXqBppUrUNXHEl0335gf0L/Bxn0JsCaQew1ZZU8j66A6xDx26LdmtlYVMD1tbGGSjA
 1B4ujeB+sg3XD73m5M8FbSPSej3CdBPzeqeuD6EMLZ459MtkvHCt4A5p1NMK80hg60Kcdeyb3Dc
 56HuyaYvA+/rGuy1T4rd+VLJMO3IViuGC2LnolTRU7uDg88rcrmfLKQz/9baUCp4gCLuekyv5Kj
 h6vyW014zvaedZuev2L2itLvUI0+U5AwPGP+w+OdS0SEVJcxk/vMHzFpbGNfKtYHGvz73aPhdF1
 BZRI/yNNmmv5nTUZ6xbEM3s1+qGNWdTof2eWVZvLhBxCiNPwEslT7pbCsR/GiCFVXZw6kuhCAHB
 KuS9mYeFwohTEPpUPtfWHuW9vicgrvvLlpRHINfQXwVcgjLNEGSz1dmxHJtwZQVDdLhN5EGmhgG
 m42tIMPHKeNl3tXtg=
X-Received: by 2002:a05:600c:4583:b0:4a7:9025:5c3b with SMTP id
 5b1f17b1804b1-4bb7da2633emr108360805e9.19.1795074836441; 
 Wed, 18 Nov 2026 23:53:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e5656asm16359015e9.3.2026.11.18.23.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 23:53:56 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 07:53:55 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If803050d06e59ec067ef5bd8bb32787ec2b7cfdf
X-Gerrit-Change-Number: 2222
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2222?usp=email>
X-Gerrit-Commit: 7f5ea0ff8000103d044c1a4f174dc84ef34a60e6
References: <gerrit.1795074834000.If803050d06e59ec067ef5bd8bb32787ec2b7cfdf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDc0ODM0MDAwLklmODAzMDUwZDA2ZTU5ZWMwNjdlZjViZDhiYjMyNzg3ZWMyYjdjZmRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f232d714d37afa9df2f501614bb169f06cebcd6c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTwy3-000000005hf-195a
Subject: [Openvpn-devel] [M] Change in openvpn[master]: contrib: drop
 fwmarkroute scripts
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4083360614610502723=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4083360614610502723==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8lmu9B5g9vA="; charset=UTF-8

--8lmu9B5g9vA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2222?usp=3Demail

to review the following change=2E
=


Change subject: contrib: drop fwmarkroute scripts
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

contrib: drop fwmarkroute scripts
=

The scripts read $remote and $remote_port, which OpenVPN has only
exported=
 with an index suffix (remote_1, =2E=2E=2E) since at least 2=2E0,
and $prot=
o, which became proto_1 in 2=2E1=2E The down script also
doesn't undo the u=
p script: its iptables -D rules have their -d
targets swapped and the SNAT =
rule is never removed=2E

--mark with an "ip rule fwmark" does the same job=
 natively=2E

Change-Id: If803050d06e59ec067ef5bd8bb32787ec2b7cfdf
Signed-o=
ff-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
D contrib/openvpn-fwmark=
route-1=2E00/README
D contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Edown=

D contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Eup
3 files changed, 0 i=
nsertions(+), 115 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/22/2222/1

diff --git a/contrib/openvpn-fwmarkrou=
te-1=2E00/README b/contrib/openvpn-fwmarkroute-1=2E00/README
deleted file m=
ode 100644
index 66fe61a=2E=2E0000000
--- a/contrib/openvpn-fwmarkroute-1=
=2E00/README
+++ /dev/null
@@ -1,44 +0,0 @@
-OpenVPN fwmark Routing
-Sean R=
eifschneider, <jafo@tummy=2Ecom>
-Thursday November 27, 2003
-=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-These=
 scripts can be used with OpenVPN up and down scripts to set up
-routing on=
 a Linux system such that the VPN traffic is sent via normal
-network conne=
ctivity, but other traffic to that network runs over the VPN=2E
-The idea i=
s to allow encryption of data to the network the remote host is
-on, withou=
t interfering with the VPN traffic=2E  You can't simply add a route
-to the=
 remote network, becaues that will cause the VPN traffic to also try
-to ru=
n over the VPN, and breaks the VPN=2E
-
-These scripts use the Linux "fwmar=
k" iptables rules to specify routing
-based not only on IP address, but als=
o by port and protocol=2E  This allows
-you to effectively say "if the pack=
et is to this IP address on this port
-using this protocol, then use the no=
rmal default gateway, otherwise use the
-VPN gateway=2E
-
-This is set up o=
n the client VPN system, not the VPN server=2E  These scripts
-also set up =
all ICMP echo-responses to run across the VPN=2E  You can
-comment the line=
s in the scripts to disable this, but I find this useful
-at coffee shops w=
hich have networks that block ICMP=2E
-
-To configure this, you need to set=
 up these scripts as your up and down
-scripts in the config file=2E  You w=
ill need to set these values in the
-config file:
-
-   up /etc/openvpn/fwm=
arkroute=2Eup
-   down /etc/openvpn/fwmarkroute=2Edown
-   up-restart
-   u=
p-delay
-
-   setenv remote_netmask_bits 24
-
-Note: For this to work, you =
can't set the "user" or "group" config options,
-because then the scripts w=
ill not run as root=2E
-
-The last setting allows you to control the size o=
f the network the remote
-system is on=2E  The remote end has to be set up =
to route, probably with
-masquerading or NAT=2E  The network this netmask r=
elates to is calculated
-using the value of "remote" in the conf file=2E
-
=
-Sean
diff --git a/contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Edown b/=
contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Edown
deleted file mode 100=
755
index 87d67d4=2E=2E0000000
--- a/contrib/openvpn-fwmarkroute-1=2E00/fwm=
arkroute=2Edown
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/sh
-#
-#  Bring down=
 vpn routing=2E
-
-#  calculate the network address
-remote_network=3D`ipca=
lc -n "$remote"/"$remote_netmask_bits"`
-remote_network=3D"${remote_network=
#*=3D}"
-
-#  clear routing via VPN
-ip route del "$remote_network"/"$remot=
e_netmask_bits" via "$5" table vpn=2Eout
-ip route del table vpnonly=2Eout =
via "$5"
-iptables -D OUTPUT -t mangle -p "$proto" \
-		-d "$remote_network=
"/"$remote_netmask_bits" \
-		--dport "$remote_port" -j ACCEPT
-iptables -D=
 OUTPUT -t mangle -d "$remote" -j MARK --set-mark 2
-
-#  undo the ICMP pin=
g tunneling
-iptables -D OUTPUT -t mangle --protocol icmp --icmp-type echo-=
request \
-		-j MARK --set-mark 3
-
-#  flush route cache
-ip route flush c=
ache
diff --git a/contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Eup b/con=
trib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Eup
deleted file mode 100755
i=
ndex 661ec31=2E=2E0000000
--- a/contrib/openvpn-fwmarkroute-1=2E00/fwmarkro=
ute=2Eup
+++ /dev/null
@@ -1,49 +0,0 @@
-#!/bin/sh
-#
-#  Bring up vpn rout=
ing=2E
-
-#  calculate the network address
-remote_network=3D`ipcalc -n "$r=
emote"/"$remote_netmask_bits"`
-remote_network=3D"${remote_network#*=3D}"
-=

-#  add the stuff that doesn't change if it's not already there
-grep -q '=
^202 ' /etc/iproute2/rt_tables 
-if [ "$?" -ne 0 ]
-then
-	echo 202 vpn=2Eo=
ut >> /etc/iproute2/rt_tables
-fi
-grep -q '^203 ' /etc/iproute2/rt_tables =

-if [ "$?" -ne 0 ]
-then
-	echo 203 vpnonly=2Eout >> /etc/iproute2/rt_tabl=
es
-fi
-ip rule ls | grep -q 'lookup vpn=2Eout *$'
-if [ "$?" -ne 0 ]
-then=

-	ip rule add fwmark 2 table vpn=2Eout
-fi
-ip rule ls | grep -q 'lookup v=
pnonly=2Eout *$'
-if [ "$?" -ne 0 ]
-then
-	ip rule add fwmark 3 table vpno=
nly=2Eout
-fi
-
-#  route VPN traffic using the normal table
-iptables -A O=
UTPUT -t mangle -p "$proto" -d "$remote" --dport "$remote_port" \
-		-j ACC=
EPT
-
-#  route all other traffic to that host via VPN
-iptables -A OUTPUT =
-t mangle -d "$remote_network"/"$remote_netmask_bits" \
-		-j MARK --set-ma=
rk 2
-
-#  route all ICMP pings over the VPN
-iptables -A OUTPUT -t mangle =
--protocol icmp --icmp-type echo-request \
-		-j MARK --set-mark 3
-
-#  NA=
T traffic going over the VPN, so it doesn't have an unknown address
-iptabl=
es -t nat -A POSTROUTING -o "$1" -j SNAT --to-source "$4"
-
-#  add routing=
 commands
-ip route add "$remote_network"/"$remote_netmask_bits" via "$5" t=
able vpn=2Eout
-ip route add table vpnonly=2Eout via "$5"
-ip route flush c=
ache

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2222?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If803050d06e=
59ec067ef5bd8bb32787ec2b7cfdf
Gerrit-Change-Number: 2222
Gerrit-PatchSet: 1=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>

--8lmu9B5g9vA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2222?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">contrib: drop fwmarkroute scripts<br><br>The scripts re=
ad $remote and $remote_port, which OpenVPN has only<br>exported with an ind=
ex suffix (remote_1, =2E=2E=2E) since at least 2=2E0,<br>and $proto, which =
became proto_1 in 2=2E1=2E The down script also<br>doesn&#39;t undo the up =
script: its iptables -D rules have their -d<br>targets swapped and the SNAT=
 rule is never removed=2E<br><br>--mark with an &quot;ip rule fwmark&quot; =
does the same job natively=2E<br><br>Change-Id: If803050d06e59ec067ef5bd8bb=
32787ec2b7cfdf<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt;<br>---<br>D contrib/openvpn-fwmarkroute-1=2E00/README<br>D contrib/open=
vpn-fwmarkroute-1=2E00/fwmarkroute=2Edown<br>D contrib/openvpn-fwmarkroute-=
1=2E00/fwmarkroute=2Eup<br>3 files changed, 0 insertions(+), 115 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/22/2222/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/contrib/openvpn-fwmarkro=
ute-1=2E00/README b/contrib/openvpn-fwmarkroute-1=2E00/README</span><br><sp=
an>deleted file mode 100644</span><br><span>index 66fe61a=2E=2E0000000</spa=
n><br><span>--- a/contrib/openvpn-fwmarkroute-1=2E00/README</span><br><span=
>+++ /dev/null</span><br><span>@@ -1,44 +0,0 @@</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-OpenVPN fwmark Routing</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-Sean Reifschneider, &lt;jafo@tummy=2Ecom&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-Thursday November 27, 200=
3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-These scripts can be used with OpenVPN up and down script=
s to set up</span><br><span style=3D"color: hsl(0, 100%, 40%);">-routing on=
 a Linux system such that the VPN traffic is sent via normal</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-network connectivity, but other traf=
fic to that network runs over the VPN=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-The idea is to allow encryption of data to the network t=
he remote host is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-on, =
without interfering with the VPN traffic=2E  You can&#39;t simply add a rou=
te</span><br><span style=3D"color: hsl(0, 100%, 40%);">-to the remote netwo=
rk, becaues that will cause the VPN traffic to also try</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-to run over the VPN, and breaks the VPN=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-These scripts use the Linux &quot;fwmar=
k&quot; iptables rules to specify routing</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-based not only on IP address, but also by port and prot=
ocol=2E  This allows</span><br><span style=3D"color: hsl(0, 100%, 40%);">-y=
ou to effectively say &quot;if the packet is to this IP address on this por=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-using this protocol,=
 then use the normal default gateway, otherwise use the</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-VPN gateway=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-This is set up on the client VPN system, not the VPN server=2E  These=
 scripts</span><br><span style=3D"color: hsl(0, 100%, 40%);">-also set up a=
ll ICMP echo-responses to run across the VPN=2E  You can</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-comment the lines in the scripts to disa=
ble this, but I find this useful</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-at coffee shops which have networks that block ICMP=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-To configure this, you need to set up these scripts =
as your up and down</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sc=
ripts in the config file=2E  You will need to set these values in the</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-config file:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   up /etc/openvpn/fwmarkroute=2Eup</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   down /etc/openvpn/fwmarkroute=2Edown</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   up-restart</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-   up-delay</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   setenv remote_netmask_bits 24</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-Note: For this to work, you can&#39;t set the &quot;user&quot; or &quot;gr=
oup&quot; config options,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-because then the scripts will not run as root=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-The last setting allows you to control the size of the network t=
he remote</span><br><span style=3D"color: hsl(0, 100%, 40%);">-system is on=
=2E  The remote end has to be set up to route, probably with</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-masquerading or NAT=2E  The network =
this netmask relates to is calculated</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-using the value of &quot;remote&quot; in the conf file=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-Sean</span><br><span>diff --git a/contrib/o=
penvpn-fwmarkroute-1=2E00/fwmarkroute=2Edown b/contrib/openvpn-fwmarkroute-=
1=2E00/fwmarkroute=2Edown</span><br><span>deleted file mode 100755</span><b=
r><span>index 87d67d4=2E=2E0000000</span><br><span>--- a/contrib/openvpn-fw=
markroute-1=2E00/fwmarkroute=2Edown</span><br><span>+++ /dev/null</span><br=
><span>@@ -1,22 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#!/bin/sh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#  Bring down vpn routing=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#  calculate the network address</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-remote_network=3D`ipcalc -n &quo=
t;$remote&quot;/&quot;$remote_netmask_bits&quot;`</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-remote_network=3D&quot;${remote_network#*=3D}&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#  clear routing via VPN</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-ip route del &quot;$remote_network&=
quot;/&quot;$remote_netmask_bits&quot; via &quot;$5&quot; table vpn=2Eout</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-ip route del table vpno=
nly=2Eout via &quot;$5&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-iptables -D OUTPUT -t mangle -p &quot;$proto&quot; \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-		-d &quot;$remote_network&quot;/&quo=
t;$remote_netmask_bits&quot; \</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-		--dport &quot;$remote_port&quot; -j ACCEPT</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-iptables -D OUTPUT -t mangle -d &quot;$remo=
te&quot; -j MARK --set-mark 2</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  undo the I=
CMP ping tunneling</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ipt=
ables -D OUTPUT -t mangle --protocol icmp --icmp-type echo-request \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-		-j MARK --set-mark 3</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#  flush route cache</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-ip route flush cache</span><br><span>diff --git a=
/contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Eup b/contrib/openvpn-fwma=
rkroute-1=2E00/fwmarkroute=2Eup</span><br><span>deleted file mode 100755</s=
pan><br><span>index 661ec31=2E=2E0000000</span><br><span>--- a/contrib/open=
vpn-fwmarkroute-1=2E00/fwmarkroute=2Eup</span><br><span>+++ /dev/null</span=
><br><span>@@ -1,49 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#!/bin/sh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#  Bring up vpn routing=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#  calculate the network address</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-remote_network=3D`ipcalc -n &qu=
ot;$remote&quot;/&quot;$remote_netmask_bits&quot;`</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-remote_network=3D&quot;${remote_network#*=3D}&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#  add the stuff that doesn&#39;t cha=
nge if it&#39;s not already there</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-grep -q &#39;^202 &#39; /etc/iproute2/rt_tables </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-if [ &quot;$?&quot; -ne 0 ]</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-then</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	echo 202 vpn=2Eout &gt;&gt; /etc/iproute2/rt_t=
ables</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-grep -q &#39;^203 &#39; /etc/iprout=
e2/rt_tables </span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ &qu=
ot;$?&quot; -ne 0 ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-th=
en</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	echo 203 vpnonly=
=2Eout &gt;&gt; /etc/iproute2/rt_tables</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
p rule ls | grep -q &#39;lookup vpn=2Eout *$&#39;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-if [ &quot;$?&quot; -ne 0 ]</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-then</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	ip rule add fwmark 2 table vpn=2Eout</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-ip rule ls | grep -q &#39;lookup vpnonly=2Eout *$&#39;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-if [ &quot;$?&quot; -ne 0 ]<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-then</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	ip rule add fwmark 3 table vpnonly=2Eo=
ut</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#  route VPN traffic using the normal table</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-iptables -A OUTPUT -t mangle -p &quot=
;$proto&quot; -d &quot;$remote&quot; --dport &quot;$remote_port&quot; \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-		-j ACCEPT</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#  route all other traffic to that host via VPN</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-iptables -A OUTPUT -t mangle -=
d &quot;$remote_network&quot;/&quot;$remote_netmask_bits&quot; \</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-		-j MARK --set-mark 2</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#  route all ICMP pings over the VPN</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-iptables -A OUTPUT -t mangle --protoc=
ol icmp --icmp-type echo-request \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-		-j MARK --set-mark 3</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  NAT =
traffic going over the VPN, so it doesn&#39;t have an unknown address</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-iptables -t nat -A POSTROUT=
ING -o &quot;$1&quot; -j SNAT --to-source &quot;$4&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#  add routing commands</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-ip route add &quot;$remote_network&quot;/&quot;$remote_netm=
ask_bits&quot; via &quot;$5&quot; table vpn=2Eout</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-ip route add table vpnonly=2Eout via &quot;$5&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ip route flush ca=
che</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2222?usp=3Demail">change 2222</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2222?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: If803050d06e59ec067ef5bd8bb=
32787ec2b7cfdf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 22=
22 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--8lmu9B5g9vA=--


--===============4083360614610502723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4083360614610502723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4083360614610502723==--

