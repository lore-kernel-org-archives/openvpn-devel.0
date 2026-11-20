Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0260A2634
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=X2az1r6v;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=anqgrFvN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e/0f1EXz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MuS8JICX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tDWV1HUgdkSiCr8OuxfRNraiEk/KoHPOrt9GiB5uOuI=; b=X2az1r6vf0Bfj/kJtgzfbSBKyh
	GCV/E50nqLBYW5fok/FrDAq5XKNSEIgnmpUilDfn7rmLI2efIKodkL+A2R28L+cRlEV1jhJq4dhC0
	tX6lnTqH5WfBBteNBe33Y6AH80a7F7Hi+QVt/jwiyOmljljSKRdRA3uzT9uinhCEfe7Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUMFl-000000001hO-44jV;
	Fri, 20 Nov 2026 10:54:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUMFk-000000001h5-0pBP
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:54:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ABgDhh/GjSRMKh7QvsZzEAq6/8jTmhNsFdbfFLVuB78=; b=anqgrFvN9Mcb6g9SUeDLWOe5FP
 JvUZM3e5Jh/XYGdl/iEJxf8HeaAbRCXY5yj+6NMfzq7e6uNlAePvhsaHIYFfH5PUr3n0+jirxtXz8
 kVu4swWNyXXqVcrkrj4+RnqXqlgT3DNtQ6kAr06ZZNfF6NwsOKUdfjkph5L8u2istXw4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ABgDhh/GjSRMKh7QvsZzEAq6/8jTmhNsFdbfFLVuB78=; b=e/0f1EXzRYRZLWTmn8KsTP1nxu
 zCAwMJcKxpqDjuMJ9coBySLwDOh8O+zXqNOTiglNZ0577FLY+1Q/jd7X0DTHm4LDG1J6DZfdlY7jz
 fPtVRq7IQDxhES+6hEEf5TBJV45/inhABcLZpLMEX1QM5mNC/zEuZlf+Jk9ETJHrsulk=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUMFi-000000005ho-3Buj for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:54:00 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4a7b8abe209so510196f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 02:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795172032; x=1795776832; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ABgDhh/GjSRMKh7QvsZzEAq6/8jTmhNsFdbfFLVuB78=;
 b=MuS8JICX4qOCOPq/F3rUHdJqoZ5tGmmf5JZUSPW7vHv4qYmeOLDPQs0+J5mGtbwIcK
 qTd6PCVAv85LECr1eNyDCe/GYKlVJ0+Nwdd2FJhWTxElh9kwfUXzVXNk79V5VMxVUAHa
 /Exy2hrpHdLUyvNVl39P98UOqAIvSzPThYl75dybxXTxxLO6I2BSgAhYNC+Uu3URVt2r
 sVISN548k1xqGT6a5U+PACwoNRjmQ7fGDrDUKSOLzfbgvSBvrC84L7uN9W1JCshJ9PGC
 CDH9gCdqls8gVm5dp8HNbHt30wB5mQ8gJH12sMpRyVDXcB6JGt5iTs/hhm3i6jcrBXD8
 Qvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795172032; x=1795776832;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ABgDhh/GjSRMKh7QvsZzEAq6/8jTmhNsFdbfFLVuB78=;
 b=Y3uJEZTZzUv1Xvf0PZMdXlXe1VK8PvEuxb3Feg9D2gJDm94Mr/aWamMRraxHkeEbNf
 /33oulShs1DQTLO20FLkMZTInXUIN0O4+Sbvgw85jWw/TNQnGdMx6jV6AA/0kOpjXtWI
 pVtI0BV0wKO/Ycc/Qsw3W71BIBtGXQfIRCefAF0nOrJKuPbzfwsXeRUXbvB1xqxn95Ml
 4C26UyqfYYwlhtoFYJH8SiSKSy3XccIjJqDliDxTxxoWnG69XpY1e94tW38kGK+tqwqi
 4qIL6Q1VRUH1rc+89PuY4cZICnT1rltcGPmc13NazIPtnrnWBSEPcrLCQp3xftUaQNEQ
 HYuw==
X-Gm-Message-State: APuU4Z/BTYz0/YP+/GZwyRKeiV4aX0sI/+/hFh/mOZfAjriK5dddJWSA
 M/CDRRG7GIDeAWaz2txuQxex2aVdVFlsA7ig4G06UX0MaXyFAaUlqPVu4uQhTQBHRYG8E7Asl7+
 O9KUPure7y+rKq00OoCwLrQipndQ1O2xtK3nwSKa0tr4aRA5L4ZwBFBqWorwmFsytzVSlVFE6EL
 VcUpFG7g==
X-Gm-Gg: AZFdTZfPfcthv0R9uVWapl93MhSpBlYZ15djX6IXsOGJ/H5bIdZhZcOvXUD8+n5dREA
 05GE5znvcAYgsRmeIZWGxfwh+QV/dMDn2SRL75y9rTKtIEboAf6z5Phzc0c3Va+5s7+Dd/puHyT
 JsNewuvJCAmEW65LgZ3dWpTzmt1YioPDcpb6mm1rqZw6aK5c2s4CpOuGG3qJyLX1tQ56g/V4Jni
 SvlQyb9G9FambQXBPaHNoayXAK5EuY3m+nlfuxgPjWvZwKffuHOz10YfQpt8jdHfJzt/ZfovoB2
 Mqyhi8T4sDxiDpoy2adaXw9eeNAIjhWDex/i7Ck7EWZQpeWTBxHvSnlRimtsDLu/09xNIze7GzC
 pw1ay/x3xONrL87cT/zF/uKDq/GbCTFOzivt7xdYNO8X/A2vX4i1Rw6sxTHgB2o4YXkBGJA4yPl
 6KA8NrvjMmR46quVysPPoy8WJMh8Zz0LSk9eLNu9hSr5nyVoemN/K81dCMhLlSvP31KU5GtQTST
 2xG87w53LAQupChwmziB5YkQfx/DiMpYIWMyqntIRSY43B95r2BY8xxy5Cd0pVHcWe4bzPXMCP3
 lpN4bvRBPzn7DCCnot5w9SYfo0TBPfxbZIR8vMrHT0L6rS0gmhkW5XO+Uto3u/PhJQOZs01AIQ7
 lSAkcMrtLKnQDuu7T87t9Ap1o030XNvl13X5qmbFmhf28rxZnQFIMYPDTbz5D3AqdlfGUJfxI+t
 oaf9QmIZ45Tfag3vOU
X-Received: by 2002:a05:6000:111:b0:490:71a7:6f51 with SMTP id
 ffacd0b85a97d-4abb4c7aab0mr3896109f8f.45.1795172031973; 
 Fri, 20 Nov 2026 02:53:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2e6dsm5012599f8f.6.2026.11.20.02.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:53:51 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 10:53:49 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: If803050d06e59ec067ef5bd8bb32787ec2b7cfdf
X-Gerrit-Change-Number: 2222
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2222?usp=email>
X-Gerrit-Commit: 90a0ce2a742167f759f5b339c3c69ea9980b4c9c
In-Reply-To: <gerrit.1795074834000.If803050d06e59ec067ef5bd8bb32787ec2b7cfdf@gerrit.openvpn.net>
References: <gerrit.1795074834000.If803050d06e59ec067ef5bd8bb32787ec2b7cfdf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDc0ODM0MDAwLklmODAzMDUwZDA2ZTU5ZWMwNjdlZjViZDhiYjMyNzg3ZWMyYjdjZmRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d83393acf789af4053650fc30e715b9778cb369-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUMFi-000000005ho-3Buj
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6747178278520485122=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6747178278520485122==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="N+Ake4IN3ys="; charset=UTF-8

--N+Ake4IN3ys=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2222?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: contrib: drop fwmarkroute=
 scripts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

cont=
rib: drop fwmarkroute scripts

The scripts read $remote and $remote_port, w=
hich OpenVPN has only
exported with an index suffix (remote_1, =2E=2E=2E) s=
ince at least 2=2E0,
and $proto, which became proto_1 in 2=2E1=2E The down =
script also
doesn't undo the up script: its iptables -D rules have their -d=

targets swapped and the SNAT rule is never removed=2E

--mark with an "ip =
rule fwmark" does the same job natively=2E

Change-Id: If803050d06e59ec067e=
f5bd8bb32787ec2b7cfdf
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg=
>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2222
Message-Id: <20261119103443=2E5348-1-ge=
rt@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@=
lists=2Esourceforge=2Enet/msg41665=2Ehtml
Signed-off-by: Gert Doering <gert=
@greenie=2Emuc=2Ede>
---
D contrib/openvpn-fwmarkroute-1=2E00/README
D cont=
rib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Edown
D contrib/openvpn-fwmarkr=
oute-1=2E00/fwmarkroute=2Eup
3 files changed, 0 insertions(+), 115 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/2=
2/2222/2

diff --git a/contrib/openvpn-fwmarkroute-1=2E00/README b/contrib/=
openvpn-fwmarkroute-1=2E00/README
deleted file mode 100644
index 66fe61a=2E=
=2E0000000
--- a/contrib/openvpn-fwmarkroute-1=2E00/README
+++ /dev/null
@@=
 -1,44 +0,0 @@
-OpenVPN fwmark Routing
-Sean Reifschneider, <jafo@tummy=2Ec=
om>
-Thursday November 27, 2003
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-These scripts can be used with Open=
VPN up and down scripts to set up
-routing on a Linux system such that the =
VPN traffic is sent via normal
-network connectivity, but other traffic to =
that network runs over the VPN=2E
-The idea is to allow encryption of data =
to the network the remote host is
-on, without interfering with the VPN tra=
ffic=2E  You can't simply add a route
-to the remote network, becaues that =
will cause the VPN traffic to also try
-to run over the VPN, and breaks the=
 VPN=2E
-
-These scripts use the Linux "fwmark" iptables rules to specify r=
outing
-based not only on IP address, but also by port and protocol=2E  Thi=
s allows
-you to effectively say "if the packet is to this IP address on th=
is port
-using this protocol, then use the normal default gateway, otherwis=
e use the
-VPN gateway=2E
-
-This is set up on the client VPN system, not t=
he VPN server=2E  These scripts
-also set up all ICMP echo-responses to run=
 across the VPN=2E  You can
-comment the lines in the scripts to disable th=
is, but I find this useful
-at coffee shops which have networks that block =
ICMP=2E
-
-To configure this, you need to set up these scripts as your up a=
nd down
-scripts in the config file=2E  You will need to set these values i=
n the
-config file:
-
-   up /etc/openvpn/fwmarkroute=2Eup
-   down /etc/op=
envpn/fwmarkroute=2Edown
-   up-restart
-   up-delay
-
-   setenv remote_ne=
tmask_bits 24
-
-Note: For this to work, you can't set the "user" or "group=
" config options,
-because then the scripts will not run as root=2E
-
-The =
last setting allows you to control the size of the network the remote
-syst=
em is on=2E  The remote end has to be set up to route, probably with
-masqu=
erading or NAT=2E  The network this netmask relates to is calculated
-using=
 the value of "remote" in the conf file=2E
-
-Sean
diff --git a/contrib/ope=
nvpn-fwmarkroute-1=2E00/fwmarkroute=2Edown b/contrib/openvpn-fwmarkroute-1=
=2E00/fwmarkroute=2Edown
deleted file mode 100755
index 87d67d4=2E=2E000000=
0
--- a/contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Edown
+++ /dev/null=

@@ -1,22 +0,0 @@
-#!/bin/sh
-#
-#  Bring down vpn routing=2E
-
-#  calcula=
te the network address
-remote_network=3D`ipcalc -n "$remote"/"$remote_netm=
ask_bits"`
-remote_network=3D"${remote_network#*=3D}"
-
-#  clear routing v=
ia VPN
-ip route del "$remote_network"/"$remote_netmask_bits" via "$5" tabl=
e vpn=2Eout
-ip route del table vpnonly=2Eout via "$5"
-iptables -D OUTPUT =
-t mangle -p "$proto" \
-		-d "$remote_network"/"$remote_netmask_bits" \
-	=
	--dport "$remote_port" -j ACCEPT
-iptables -D OUTPUT -t mangle -d "$remote=
" -j MARK --set-mark 2
-
-#  undo the ICMP ping tunneling
-iptables -D OUTP=
UT -t mangle --protocol icmp --icmp-type echo-request \
-		-j MARK --set-ma=
rk 3
-
-#  flush route cache
-ip route flush cache
diff --git a/contrib/ope=
nvpn-fwmarkroute-1=2E00/fwmarkroute=2Eup b/contrib/openvpn-fwmarkroute-1=2E=
00/fwmarkroute=2Eup
deleted file mode 100755
index 661ec31=2E=2E0000000
---=
 a/contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Eup
+++ /dev/null
@@ -1,=
49 +0,0 @@
-#!/bin/sh
-#
-#  Bring up vpn routing=2E
-
-#  calculate the ne=
twork address
-remote_network=3D`ipcalc -n "$remote"/"$remote_netmask_bits"=
`
-remote_network=3D"${remote_network#*=3D}"
-
-#  add the stuff that doesn=
't change if it's not already there
-grep -q '^202 ' /etc/iproute2/rt_table=
s 
-if [ "$?" -ne 0 ]
-then
-	echo 202 vpn=2Eout >> /etc/iproute2/rt_tables=

-fi
-grep -q '^203 ' /etc/iproute2/rt_tables 
-if [ "$?" -ne 0 ]
-then
-	e=
cho 203 vpnonly=2Eout >> /etc/iproute2/rt_tables
-fi
-ip rule ls | grep -q =
'lookup vpn=2Eout *$'
-if [ "$?" -ne 0 ]
-then
-	ip rule add fwmark 2 table=
 vpn=2Eout
-fi
-ip rule ls | grep -q 'lookup vpnonly=2Eout *$'
-if [ "$?" -=
ne 0 ]
-then
-	ip rule add fwmark 3 table vpnonly=2Eout
-fi
-
-#  route VPN=
 traffic using the normal table
-iptables -A OUTPUT -t mangle -p "$proto" -=
d "$remote" --dport "$remote_port" \
-		-j ACCEPT
-
-#  route all other tra=
ffic to that host via VPN
-iptables -A OUTPUT -t mangle -d "$remote_network=
"/"$remote_netmask_bits" \
-		-j MARK --set-mark 2
-
-#  route all ICMP pin=
gs over the VPN
-iptables -A OUTPUT -t mangle --protocol icmp --icmp-type e=
cho-request \
-		-j MARK --set-mark 3
-
-#  NAT traffic going over the VPN,=
 so it doesn't have an unknown address
-iptables -t nat -A POSTROUTING -o "=
$1" -j SNAT --to-source "$4"
-
-#  add routing commands
-ip route add "$rem=
ote_network"/"$remote_netmask_bits" via "$5" table vpn=2Eout
-ip route add =
table vpnonly=2Eout via "$5"
-ip route flush cache

-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2222?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: If803050d06e59ec067ef5bd8bb32787ec2b7cf=
df
Gerrit-Change-Number: 2222
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--N+Ake4IN3ys=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2222?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">con=
trib: drop fwmarkroute scripts<br><br>The scripts read $remote and $remote_=
port, which OpenVPN has only<br>exported with an index suffix (remote_1, =
=2E=2E=2E) since at least 2=2E0,<br>and $proto, which became proto_1 in 2=
=2E1=2E The down script also<br>doesn&#39;t undo the up script: its iptable=
s -D rules have their -d<br>targets swapped and the SNAT rule is never remo=
ved=2E<br><br>--mark with an &quot;ip rule fwmark&quot; does the same job n=
atively=2E<br><br>Change-Id: If803050d06e59ec067ef5bd8bb32787ec2b7cfdf<br>S=
igned-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2222<br>Message-Id: &lt;20261119103443=2E5348-1-g=
ert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg41665=2Ehtml<br>Signed-off-by: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>D contrib/openvpn-fwmarkrout=
e-1=2E00/README<br>D contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Edown<=
br>D contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Eup<br>3 files changed=
, 0 insertions(+), 115 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/22/2222/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/contrib/openvpn-fwmarkroute-1=2E00/README b/contrib/openvpn-fwmark=
route-1=2E00/README</span><br><span>deleted file mode 100644</span><br><spa=
n>index 66fe61a=2E=2E0000000</span><br><span>--- a/contrib/openvpn-fwmarkro=
ute-1=2E00/README</span><br><span>+++ /dev/null</span><br><span>@@ -1,44 +0=
,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-OpenVPN fwmark R=
outing</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Sean Reifschnei=
der, &lt;jafo@tummy=2Ecom&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-Thursday November 27, 2003</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-These scripts can be use=
d with OpenVPN up and down scripts to set up</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-routing on a Linux system such that the VPN traffic =
is sent via normal</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net=
work connectivity, but other traffic to that network runs over the VPN=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-The idea is to allow en=
cryption of data to the network the remote host is</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-on, without interfering with the VPN traffic=
=2E  You can&#39;t simply add a route</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-to the remote network, becaues that will cause the VPN traf=
fic to also try</span><br><span style=3D"color: hsl(0, 100%, 40%);">-to run=
 over the VPN, and breaks the VPN=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-These =
scripts use the Linux &quot;fwmark&quot; iptables rules to specify routing<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-based not only on IP a=
ddress, but also by port and protocol=2E  This allows</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-you to effectively say &quot;if the packet =
is to this IP address on this port</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-using this protocol, then use the normal default gateway, othe=
rwise use the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-VPN gate=
way=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-This is set up on the client VPN sys=
tem, not the VPN server=2E  These scripts</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-also set up all ICMP echo-responses to run across the V=
PN=2E  You can</span><br><span style=3D"color: hsl(0, 100%, 40%);">-comment=
 the lines in the scripts to disable this, but I find this useful</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-at coffee shops which have netw=
orks that block ICMP=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-To configure this, =
you need to set up these scripts as your up and down</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-scripts in the config file=2E  You will nee=
d to set these values in the</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-config file:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   up /etc/openvpn/fwma=
rkroute=2Eup</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   down /=
etc/openvpn/fwmarkroute=2Edown</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-   up-restart</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   up-delay</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   setenv remote_netmask_bits =
24</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-Note: For this to work, you can&#39;t se=
t the &quot;user&quot; or &quot;group&quot; config options,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-because then the scripts will not run=
 as root=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-The last setting allows you to =
control the size of the network the remote</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-system is on=2E  The remote end has to be set up to ro=
ute, probably with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mas=
querading or NAT=2E  The network this netmask relates to is calculated</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-using the value of &quot;r=
emote&quot; in the conf file=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Sean</span>=
<br><span>diff --git a/contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Edow=
n b/contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Edown</span><br><span>d=
eleted file mode 100755</span><br><span>index 87d67d4=2E=2E0000000</span><b=
r><span>--- a/contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Edown</span><=
br><span>+++ /dev/null</span><br><span>@@ -1,22 +0,0 @@</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#!/bin/sh</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#  Bring down vpn routing=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  calculate=
 the network address</span><br><span style=3D"color: hsl(0, 100%, 40%);">-r=
emote_network=3D`ipcalc -n &quot;$remote&quot;/&quot;$remote_netmask_bits&q=
uot;`</span><br><span style=3D"color: hsl(0, 100%, 40%);">-remote_network=
=3D&quot;${remote_network#*=3D}&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  cl=
ear routing via VPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ip=
 route del &quot;$remote_network&quot;/&quot;$remote_netmask_bits&quot; via=
 &quot;$5&quot; table vpn=2Eout</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-ip route del table vpnonly=2Eout via &quot;$5&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-iptables -D OUTPUT -t mangle -p &qu=
ot;$proto&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		-d=
 &quot;$remote_network&quot;/&quot;$remote_netmask_bits&quot; \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-		--dport &quot;$remote_port&quot=
; -j ACCEPT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-iptables -=
D OUTPUT -t mangle -d &quot;$remote&quot; -j MARK --set-mark 2</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#  undo the ICMP ping tunneling</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-iptables -D OUTPUT -t mangle --protocol icm=
p --icmp-type echo-request \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-		-j MARK --set-mark 3</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  flush rout=
e cache</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ip route flush=
 cache</span><br><span>diff --git a/contrib/openvpn-fwmarkroute-1=2E00/fwma=
rkroute=2Eup b/contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Eup</span><b=
r><span>deleted file mode 100755</span><br><span>index 661ec31=2E=2E0000000=
</span><br><span>--- a/contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=2Eup<=
/span><br><span>+++ /dev/null</span><br><span>@@ -1,49 +0,0 @@</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#!/bin/sh</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#  Bring up vpn routing=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  calc=
ulate the network address</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-remote_network=3D`ipcalc -n &quot;$remote&quot;/&quot;$remote_netmask_b=
its&quot;`</span><br><span style=3D"color: hsl(0, 100%, 40%);">-remote_netw=
ork=3D&quot;${remote_network#*=3D}&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
 add the stuff that doesn&#39;t change if it&#39;s not already there</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-grep -q &#39;^202 &#39; /etc=
/iproute2/rt_tables </span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
f [ &quot;$?&quot; -ne 0 ]</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	echo 202 vp=
n=2Eout &gt;&gt; /etc/iproute2/rt_tables</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
grep -q &#39;^203 &#39; /etc/iproute2/rt_tables </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-if [ &quot;$?&quot; -ne 0 ]</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-then</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	echo 203 vpnonly=2Eout &gt;&gt; /etc/iproute2/rt_tables</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-ip rule ls | grep -q &#39;lookup vpn=2Eout =
*$&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ &quot;$?&=
quot; -ne 0 ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-then</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	ip rule add fwmark 2 tab=
le vpn=2Eout</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-ip rule ls | grep -q &#39;lo=
okup vpnonly=2Eout *$&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-if [ &quot;$?&quot; -ne 0 ]</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	ip ru=
le add fwmark 3 table vpnonly=2Eout</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#  route VPN traffic using=
 the normal table</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ipta=
bles -A OUTPUT -t mangle -p &quot;$proto&quot; -d &quot;$remote&quot; --dpo=
rt &quot;$remote_port&quot; \</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-		-j ACCEPT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  route all other traf=
fic to that host via VPN</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-iptables -A OUTPUT -t mangle -d &quot;$remote_network&quot;/&quot;$remot=
e_netmask_bits&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-		-j MARK --set-mark 2</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  route all ICMP p=
ings over the VPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ipta=
bles -A OUTPUT -t mangle --protocol icmp --icmp-type echo-request \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-		-j MARK --set-mark 3</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#  NAT traffic going over the VPN, so it doesn&#3=
9;t have an unknown address</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-iptables -t nat -A POSTROUTING -o &quot;$1&quot; -j SNAT --to-source =
&quot;$4&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#  add routing commands</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-ip route add &quot;$remote=
_network&quot;/&quot;$remote_netmask_bits&quot; via &quot;$5&quot; table vp=
n=2Eout</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ip route add t=
able vpnonly=2Eout via &quot;$5&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-ip route flush cache</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2222?usp=3Demail">change =
2222</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2222?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: If803050d06e59ec067ef5bd8bb32787ec2b7cfdf </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2222 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--N+Ake4IN3ys=--


--===============6747178278520485122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6747178278520485122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6747178278520485122==--

