Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3538460A2635
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IT4ddvz9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g1bMGGVY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hhQAlE9M;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ai/do0/N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ohUhOiKBLbxSuizV9PEiptLRSzZv+Mb45EFdym2bh1w=; b=IT4ddvz9+A35TOvWDN/t+HoQdt
	+elsY1V/7r2cxQCx2qDQuWsmxid8aRGiGPA9ilW73QQ/Cf9vezxNkrOmxgDf4hrqBjRLCqCEbqUUq
	O8sfwArXya0lWE/yakgE4ojDRIXjO/+jhrS9U+UcYjZqYqkt4czYF84vx02JJPEl40rE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUMFn-000000000VA-3hKs;
	Fri, 20 Nov 2026 10:54:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUMFm-000000000Uw-1Le6
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:54:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=62yyofEFXZU5gH1ebWZ04B3CYjQ4VsahHoRqu6TLK6k=; b=g1bMGGVYOwgw8k/RSZEQkL6KU6
 56s85koa9dOlWqlcnjBUtTcibDjEMHEfKzT8XsogDTjPxtn9MOytVgVn9TfvDiMv/klDEhi0cS4GL
 pRF4a5UZBeKL6A25uZvKFQ3vhhYYI0qrszt0CMYlxcW7eqKCLhxgZ3J88qqIzVbsEQyE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=62yyofEFXZU5gH1ebWZ04B3CYjQ4VsahHoRqu6TLK6k=; b=hhQAlE9MAl7A6QuDY/LWCVZ485
 P3rgdEjN5PtnkzR2CnynwGKai2c6LPhKdH/jjcrwp+y0Pwn6LzjnWwr7lYi4ipeX8rUxjwwg8Uk/C
 XJgir4NcRYmJ55J+BYXAKCgjCYrS47pF1xbW9qbMLw0gG0kRQpywx5UHMaeYe+mHQBaA=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUMFj-000000005hp-29BF for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:54:02 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so5607105e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 02:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795172033; x=1795776833; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=62yyofEFXZU5gH1ebWZ04B3CYjQ4VsahHoRqu6TLK6k=;
 b=Ai/do0/NJEGBiqwcZCmPF+dZLveDR5XF4dMlMGYgUsD76JIgpmYOTIH2rX24Cp8iGY
 9FUZlO09PkbZS9M91WUYyazNOUEf01/IBD1MpS6uLGPuy/GOB3Yr6JbZgc2geMHiBMzX
 NTBo2+MFiyJfdgYvXqL97D+BIoaHgGwYChQCbiRR73+v5fjONnEFjhlhwY4K50j1n5SU
 SeW9zXiqzFKudCBg+bMj4ci+1gEVKRlwZdOWDp8MA1wXszxrJj6rzgyfcILP4V4dcrAu
 W2GXuUDz3reAbBm00tBgRZ73JdhfC0pnlCSabMqIevgHRFq+xDlJ8FJZuKDx/rqKsJAg
 UN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795172033; x=1795776833;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=62yyofEFXZU5gH1ebWZ04B3CYjQ4VsahHoRqu6TLK6k=;
 b=nTndLXtkVLhGtbuq0NRcM74aPgpRR5SZgetEjELddNec5aupoGoq9Y92uuOxErW2ZC
 Qp5B7mcxZkMgLUNmdGwgNDbmi2OdXGHS7UZSOPP3PYX97JSJyBUtr9yBP3O20jqE1cBp
 yic0WaoyCrd8wBa3klW1mASLthoEOU4EZr+e+yEypLFpMAVq+2g23YQkP4NyebeuWtZi
 Nw7Ph6OpAdEqjZsHASDIaGYVCuE/OQ3FmmlWXjIQcZt88MB/65cbZb5MGlkxjmgDxGrS
 pF3ElnKe0tEkU2Hi9cTVMHvTEJVAqvMAGmjdXfiydyy5vG/RmnqJXzn8CvcPpb1J9aZP
 78/w==
X-Forwarded-Encrypted: i=1;
 AL+hErGUa0zV/KDQnBeJ1yv5tGoGdheJqMFsqPz8PoCxPyKzSyoi8Ga1iffZwHPVXIiNQYjnUbGph0/HJ1WhL5+l@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8hwmj6RzR4NFeqxYj/oDwo5ecdQ8uB9CI3fXCZXsx3xhY4lKof
 NAYUPaOUn6/OozwH6c9ttQXn/WrGXS5n7S6Ce0u3hLoAK3sa27L6PTKNUmsPxMjtPou4NT5kMqh
 bH5Ko0Gfj6NxPQXR3uLOoi+mF1g+Ne1Rbxx1pnAjEEqjkTRaZ2lrK34xDQlV2OFVy3QOlv6ZbNp
 CU9iZA5A==
X-Gm-Gg: AYBFou0dRWam/LlAqmY0DYpKEtGxdKjsgSJFqpnTcumRGB8q8giaf7+vQt+de+GlLZP
 dPtw8rIn2G4nqSiaX7rQVyD/rV/ZdV3uKfQUKz/tkEHZpuImNkh6xgWhrgwt1dB4+OzxY9ErZr3
 LRHQ3t9lwr4mu9yNVbiz6slmLv2qIly5DmEZe6WZ81zAmpZSOVLr02KIp+pEs3eN3q95GHQGJPV
 UCjquidVP4G66aFizdPresFF+LSoymcWaMksoioKfdzfoEAv8BpxfOCcuIxRqk/fMbO+eTgTFbG
 /m40TWCg87/PYeQ7Xnf67OhTNYrcz+8OJ01x7fADdhzdhczp4Zl7wZX3Fq4QkFaVu3qa3GitJI2
 kIaBJFgpDD5vBxK8B8AMZPV23tionbNgNMTVU4btEeOtL0g3tLzOFToN3YhD+F3BGbXjcIq0ITz
 erlRWotlt9CqoyiUS/yfFJZv4QeQkjMob+CLH94XgYAqnXKXIt5XNibqhffwOLVQVuXqNsH+cpm
 BrQATe7XjBTENZK+2LRhZNxqHKzLCt/lKRIyFeJRB4A20vqGCg6piUcvdDA+eT36WnjWvPnIZHQ
 XzTHf6r9fvmdhD2AnSRCRlgrLks63ZuL0PjoIqPp14bC72cgaa5XZUyj2qiME1id87j5liFIrWm
 5kwR0VbWiEdhIcQlM63fEOEI9YUmL3zhKaWvs1yS3966ynODFSGAZvR10BwjC6p5F1gr2v+XOwH
 n5Ln/FIyf28i13Z3Wz
X-Received: by 2002:a05:600c:a088:b0:4bb:6473:cde9 with SMTP id
 5b1f17b1804b1-4bb8880f2d8mr50124725e9.6.1795172032716; 
 Fri, 20 Nov 2026 02:53:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442693sm68897725e9.1.2026.11.20.02.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:53:52 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 10:53:52 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: If803050d06e59ec067ef5bd8bb32787ec2b7cfdf
X-Gerrit-Change-Number: 2222
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2222?usp=email>
X-Gerrit-Commit: 90a0ce2a742167f759f5b339c3c69ea9980b4c9c
In-Reply-To: <gerrit.1795074834000.If803050d06e59ec067ef5bd8bb32787ec2b7cfdf@gerrit.openvpn.net>
References: <gerrit.1795074834000.If803050d06e59ec067ef5bd8bb32787ec2b7cfdf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDc0ODM0MDAwLklmODAzMDUwZDA2ZTU5ZWMwNjdlZjViZDhiYjMyNzg3ZWMyYjdjZmRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d83393acf789af4053650fc30e715b9778cb369-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUMFj-000000005hp-29BF
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4195678569306843450=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4195678569306843450==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YUOW2TzDRmw="; charset=UTF-8

--YUOW2TzDRmw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2222?usp=3Demail )

Change subject: contrib: drop fwmarkroute s=
cripts
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




diff --git a/contrib/openvpn-fwmarkroute-1=2E00/README b/contrib/o=
penvpn-fwmarkroute-1=2E00/README
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: If803050d06e59ec067ef5bd8bb32787ec2b7cfdf
Ge=
rrit-Change-Number: 2222
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--YUOW2TzDRmw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2222?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">contrib: drop fwmarkroute scripts<=
br><br>The scripts read $remote and $remote_port, which OpenVPN has only<br=
>exported with an index suffix (remote_1, =2E=2E=2E) since at least 2=2E0,<=
br>and $proto, which became proto_1 in 2=2E1=2E The down script also<br>doe=
sn&#39;t undo the up script: its iptables -D rules have their -d<br>targets=
 swapped and the SNAT rule is never removed=2E<br><br>--mark with an &quot;=
ip rule fwmark&quot; does the same job natively=2E<br><br>Change-Id: If8030=
50d06e59ec067ef5bd8bb32787ec2b7cfdf<br>Signed-off-by: Razvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2222<br=
>Message-Id: &lt;20261119103443=2E5348-1-gert@greenie=2Emuc=2Ede&gt;<br>URL=
: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/=
msg41665=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&=
gt;<br>---<br>D contrib/openvpn-fwmarkroute-1=2E00/README<br>D contrib/open=
vpn-fwmarkroute-1=2E00/fwmarkroute=2Edown<br>D contrib/openvpn-fwmarkroute-=
1=2E00/fwmarkroute=2Eup<br>3 files changed, 0 insertions(+), 115 deletions(=
-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/contrib/openvpn-fwmarkroute-1=2E00/README =
b/contrib/openvpn-fwmarkroute-1=2E00/README</span><br><span>deleted file mo=
de 100644</span><br><span>index 66fe61a=2E=2E0000000</span><br><span>--- a/=
contrib/openvpn-fwmarkroute-1=2E00/README</span><br><span>+++ /dev/null</sp=
an><br><span>@@ -1,44 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-OpenVPN fwmark Routing</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-Sean Reifschneider, &lt;jafo@tummy=2Ecom&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-Thursday November 27, 2003</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
These scripts can be used with OpenVPN up and down scripts to set up</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-routing on a Linux system su=
ch that the VPN traffic is sent via normal</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-network connectivity, but other traffic to that networ=
k runs over the VPN=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-The idea is to allow encryption of data to the network the remote host is<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-on, without interferin=
g with the VPN traffic=2E  You can&#39;t simply add a route</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-to the remote network, becaues that w=
ill cause the VPN traffic to also try</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-to run over the VPN, and breaks the VPN=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-These scripts use the Linux &quot;fwmark&quot; iptables rul=
es to specify routing</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
based not only on IP address, but also by port and protocol=2E  This allows=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-you to effectively sa=
y &quot;if the packet is to this IP address on this port</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-using this protocol, then use the normal=
 default gateway, otherwise use the</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-VPN gateway=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-This is set up=
 on the client VPN system, not the VPN server=2E  These scripts</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-also set up all ICMP echo-respons=
es to run across the VPN=2E  You can</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-comment the lines in the scripts to disable this, but I find=
 this useful</span><br><span style=3D"color: hsl(0, 100%, 40%);">-at coffee=
 shops which have networks that block ICMP=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-To configure this, you need to set up these scripts as your up and down<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-scripts in the config =
file=2E  You will need to set these values in the</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-config file:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 up /etc/openvpn/fwmarkroute=2Eup</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   down /etc/openvpn/fwmarkroute=2Edown</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   up-restart</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   up-delay</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   sete=
nv remote_netmask_bits 24</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Note: For this to=
 work, you can&#39;t set the &quot;user&quot; or &quot;group&quot; config o=
ptions,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-because then t=
he scripts will not run as root=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-The last=
 setting allows you to control the size of the network the remote</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-system is on=2E  The remote end=
 has to be set up to route, probably with</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-masquerading or NAT=2E  The network this netmask relate=
s to is calculated</span><br><span style=3D"color: hsl(0, 100%, 40%);">-usi=
ng the value of &quot;remote&quot; in the conf file=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-Sean</span><br><span>diff --git a/contrib/openvpn-fwmarkroute-1=
=2E00/fwmarkroute=2Edown b/contrib/openvpn-fwmarkroute-1=2E00/fwmarkroute=
=2Edown</span><br><span>deleted file mode 100755</span><br><span>index 87d6=
7d4=2E=2E0000000</span><br><span>--- a/contrib/openvpn-fwmarkroute-1=2E00/f=
wmarkroute=2Edown</span><br><span>+++ /dev/null</span><br><span>@@ -1,22 +0=
,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#!/bin/sh</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#  Bring down vpn routing=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#  calculate the network address</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-remote_network=3D`ipcalc -n &quot;$remote&quot;/&qu=
ot;$remote_netmask_bits&quot;`</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-remote_network=3D&quot;${remote_network#*=3D}&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#  clear routing via VPN</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-ip route del &quot;$remote_network&quot;/&quot;$remote=
_netmask_bits&quot; via &quot;$5&quot; table vpn=2Eout</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-ip route del table vpnonly=2Eout via &quot=
;$5&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-iptables -D =
OUTPUT -t mangle -p &quot;$proto&quot; \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-		-d &quot;$remote_network&quot;/&quot;$remote_netmask_b=
its&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		--dport =
&quot;$remote_port&quot; -j ACCEPT</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-iptables -D OUTPUT -t mangle -d &quot;$remote&quot; -j MARK --=
set-mark 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#  undo the ICMP ping tunneling<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-iptables -D OUTPUT -t =
mangle --protocol icmp --icmp-type echo-request \</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-		-j MARK --set-mark 3</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#  flush route cache</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-ip route flush cache</span><br><span>diff --git a/contrib/openvpn-fw=
markroute-1=2E00/fwmarkroute=2Eup b/contrib/openvpn-fwmarkroute-1=2E00/fwma=
rkroute=2Eup</span><br><span>deleted file mode 100755</span><br><span>index=
 661ec31=2E=2E0000000</span><br><span>--- a/contrib/openvpn-fwmarkroute-1=
=2E00/fwmarkroute=2Eup</span><br><span>+++ /dev/null</span><br><span>@@ -1,=
49 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#!/bin/sh</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#  Bring up vpn routing=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#  calculate the network address</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-remote_network=3D`ipcalc -n &quot;$remote&quot;/=
&quot;$remote_netmask_bits&quot;`</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-remote_network=3D&quot;${remote_network#*=3D}&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#  add the stuff that doesn&#39;t change if it&#39;s n=
ot already there</span><br><span style=3D"color: hsl(0, 100%, 40%);">-grep =
-q &#39;^202 &#39; /etc/iproute2/rt_tables </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-if [ &quot;$?&quot; -ne 0 ]</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-then</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	echo 202 vpn=2Eout &gt;&gt; /etc/iproute2/rt_tables</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-grep -q &#39;^203 &#39; /etc/iproute2/rt_tables </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ &quot;$?&quot; -ne 0=
 ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-then</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	echo 203 vpnonly=2Eout &gt;&gt; /et=
c/iproute2/rt_tables</span><br><span style=3D"color: hsl(0, 100%, 40%);">-f=
i</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ip rule ls | grep -q=
 &#39;lookup vpn=2Eout *$&#39;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-if [ &quot;$?&quot; -ne 0 ]</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	i=
p rule add fwmark 2 table vpn=2Eout</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ip ru=
le ls | grep -q &#39;lookup vpnonly=2Eout *$&#39;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-if [ &quot;$?&quot; -ne 0 ]</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-then</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	ip rule add fwmark 3 table vpnonly=2Eout</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  =
route VPN traffic using the normal table</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-iptables -A OUTPUT -t mangle -p &quot;$proto&quot; -d &q=
uot;$remote&quot; --dport &quot;$remote_port&quot; \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-		-j ACCEPT</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#  route all other traffic to that host via VPN</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-iptables -A OUTPUT -t mangle -d &quot;$remote_ne=
twork&quot;/&quot;$remote_netmask_bits&quot; \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-		-j MARK --set-mark 2</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#  route all ICMP pings over the VPN</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-iptables -A OUTPUT -t mangle --protocol icmp --icmp-typ=
e echo-request \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		-j =
MARK --set-mark 3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#  NAT traffic going over=
 the VPN, so it doesn&#39;t have an unknown address</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-iptables -t nat -A POSTROUTING -o &quot;$1&=
quot; -j SNAT --to-source &quot;$4&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
 add routing commands</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
ip route add &quot;$remote_network&quot;/&quot;$remote_netmask_bits&quot; v=
ia &quot;$5&quot; table vpn=2Eout</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-ip route add table vpnonly=2Eout via &quot;$5&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-ip route flush cache</span><br></=
pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2222?usp=3Demail">change 2222</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2222?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: If803050d06e59ec067ef5bd8bb32787ec2b7cfdf </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 2222 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert D=
oering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--YUOW2TzDRmw=--


--===============4195678569306843450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4195678569306843450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4195678569306843450==--

