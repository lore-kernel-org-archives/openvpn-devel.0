Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A16760A2639
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SsH3ryk6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FqB7BIMR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iLZ7lU+L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=s6s9t5trTdvTT6G9ISI7vhpxzLHPUnvCcnkOunGwBZA=; b=SsH3ryk6q08AA+
	gxQn1h3zpl+FFPY9an4ZSImHnVSOB3y16zrpOuE6z4h89ejTzD67OWA+8hpIuepMFeAsQayAQQ+Pw
	wLYKbdAxJnCt5mPuD7AzCCFRxmUYC7Lj2ovcoTK2k8NukngjpAbSJv0iw/op2Mp3B1Qyh72PLFbiX
	uBU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTzTi-000000008Mj-16tP;
	Thu, 19 Nov 2026 10:34:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTzTg-000000008Md-2J2Q for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:34:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7qyD7LnZ3q7oaBaWXE8/otPnQEZKfMMaXDnkV4GEZWc=; b=FqB7BIMRQF+aHorfge1u7AZP3z
 E6C1gYt1HGlzqrvAgBkSoIU7nJARKuitSG+I5u9NX1C9ysaDRMJX0E50E132J4oJQksGn9dV91OpH
 ft+619rQmTbS34OF4/1aXwKt+68cTlGybSzzIHNnejR7pu42K8Upql8PVnBt6SGopqM4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7qyD7LnZ3q7oaBaWXE8/otPnQEZKfMMaXDnkV4GEZWc=; b=iLZ7lU+LBKUfR7NMN1+HnKxGMD
 i+3T9EKHZaUB4EwLAHlW+3gKzqHwiFm3kQwf99xt/vaNNKqZE3wrfNUEAqUMfumClhLUqDLH3PHI9
 p9Zc9D5RjNH3gZjspzFmapF+ZpipPq3IvGjYcELkgWw9QBrFV4zC9DmFm8PTxm30mCuE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTzTe-000000005aM-3VgW for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:34:52 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AJAYimg005367
 for <openvpn-devel@lists.sourceforge.net>; Thu, 19 Nov 2026 11:34:44 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AJAYh1b005366
 for openvpn-devel@lists.sourceforge.net; Thu, 19 Nov 2026 11:34:43 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 19 Nov 2026 11:34:37 +0100
Message-ID: <20261119103443.5348-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795074834000.If803050d06e59ec067ef5bd8bb32787ec2b7cfdf@gerrit.openvpn.net>
References: <gerrit.1795074834000.If803050d06e59ec067ef5bd8bb32787ec2b7cfdf@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTzTe-000000005aM-3VgW
Subject: [Openvpn-devel] [PATCH v1] contrib: drop fwmarkroute scripts
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

The scripts read $remote and $remote_port, which OpenVPN has only
exported with an index suffix (remote_1, ...) since at least 2.0,
and $proto, which became proto_1 in 2.1. The down script also
doesn't undo the up script: its iptables -D rules have their -d
targets swapped and the SNAT rule is never removed.

--mark with an "ip rule fwmark" does the same job natively.

Change-Id: If803050d06e59ec067ef5bd8bb32787ec2b7cfdf
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2222
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2222
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/contrib/openvpn-fwmarkroute-1.00/README b/contrib/openvpn-fwmarkroute-1.00/README
deleted file mode 100644
index 66fe61a..0000000
--- a/contrib/openvpn-fwmarkroute-1.00/README
+++ /dev/null
@@ -1,44 +0,0 @@
-OpenVPN fwmark Routing
-Sean Reifschneider, <jafo@tummy.com>
-Thursday November 27, 2003
-==========================
-
-These scripts can be used with OpenVPN up and down scripts to set up
-routing on a Linux system such that the VPN traffic is sent via normal
-network connectivity, but other traffic to that network runs over the VPN.
-The idea is to allow encryption of data to the network the remote host is
-on, without interfering with the VPN traffic.  You can't simply add a route
-to the remote network, becaues that will cause the VPN traffic to also try
-to run over the VPN, and breaks the VPN.
-
-These scripts use the Linux "fwmark" iptables rules to specify routing
-based not only on IP address, but also by port and protocol.  This allows
-you to effectively say "if the packet is to this IP address on this port
-using this protocol, then use the normal default gateway, otherwise use the
-VPN gateway.
-
-This is set up on the client VPN system, not the VPN server.  These scripts
-also set up all ICMP echo-responses to run across the VPN.  You can
-comment the lines in the scripts to disable this, but I find this useful
-at coffee shops which have networks that block ICMP.
-
-To configure this, you need to set up these scripts as your up and down
-scripts in the config file.  You will need to set these values in the
-config file:
-
-   up /etc/openvpn/fwmarkroute.up
-   down /etc/openvpn/fwmarkroute.down
-   up-restart
-   up-delay
-
-   setenv remote_netmask_bits 24
-
-Note: For this to work, you can't set the "user" or "group" config options,
-because then the scripts will not run as root.
-
-The last setting allows you to control the size of the network the remote
-system is on.  The remote end has to be set up to route, probably with
-masquerading or NAT.  The network this netmask relates to is calculated
-using the value of "remote" in the conf file.
-
-Sean
diff --git a/contrib/openvpn-fwmarkroute-1.00/fwmarkroute.down b/contrib/openvpn-fwmarkroute-1.00/fwmarkroute.down
deleted file mode 100755
index 87d67d4..0000000
--- a/contrib/openvpn-fwmarkroute-1.00/fwmarkroute.down
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/sh
-#
-#  Bring down vpn routing.
-
-#  calculate the network address
-remote_network=`ipcalc -n "$remote"/"$remote_netmask_bits"`
-remote_network="${remote_network#*=}"
-
-#  clear routing via VPN
-ip route del "$remote_network"/"$remote_netmask_bits" via "$5" table vpn.out
-ip route del table vpnonly.out via "$5"
-iptables -D OUTPUT -t mangle -p "$proto" \
-		-d "$remote_network"/"$remote_netmask_bits" \
-		--dport "$remote_port" -j ACCEPT
-iptables -D OUTPUT -t mangle -d "$remote" -j MARK --set-mark 2
-
-#  undo the ICMP ping tunneling
-iptables -D OUTPUT -t mangle --protocol icmp --icmp-type echo-request \
-		-j MARK --set-mark 3
-
-#  flush route cache
-ip route flush cache
diff --git a/contrib/openvpn-fwmarkroute-1.00/fwmarkroute.up b/contrib/openvpn-fwmarkroute-1.00/fwmarkroute.up
deleted file mode 100755
index 661ec31..0000000
--- a/contrib/openvpn-fwmarkroute-1.00/fwmarkroute.up
+++ /dev/null
@@ -1,49 +0,0 @@
-#!/bin/sh
-#
-#  Bring up vpn routing.
-
-#  calculate the network address
-remote_network=`ipcalc -n "$remote"/"$remote_netmask_bits"`
-remote_network="${remote_network#*=}"
-
-#  add the stuff that doesn't change if it's not already there
-grep -q '^202 ' /etc/iproute2/rt_tables 
-if [ "$?" -ne 0 ]
-then
-	echo 202 vpn.out >> /etc/iproute2/rt_tables
-fi
-grep -q '^203 ' /etc/iproute2/rt_tables 
-if [ "$?" -ne 0 ]
-then
-	echo 203 vpnonly.out >> /etc/iproute2/rt_tables
-fi
-ip rule ls | grep -q 'lookup vpn.out *$'
-if [ "$?" -ne 0 ]
-then
-	ip rule add fwmark 2 table vpn.out
-fi
-ip rule ls | grep -q 'lookup vpnonly.out *$'
-if [ "$?" -ne 0 ]
-then
-	ip rule add fwmark 3 table vpnonly.out
-fi
-
-#  route VPN traffic using the normal table
-iptables -A OUTPUT -t mangle -p "$proto" -d "$remote" --dport "$remote_port" \
-		-j ACCEPT
-
-#  route all other traffic to that host via VPN
-iptables -A OUTPUT -t mangle -d "$remote_network"/"$remote_netmask_bits" \
-		-j MARK --set-mark 2
-
-#  route all ICMP pings over the VPN
-iptables -A OUTPUT -t mangle --protocol icmp --icmp-type echo-request \
-		-j MARK --set-mark 3
-
-#  NAT traffic going over the VPN, so it doesn't have an unknown address
-iptables -t nat -A POSTROUTING -o "$1" -j SNAT --to-source "$4"
-
-#  add routing commands
-ip route add "$remote_network"/"$remote_netmask_bits" via "$5" table vpn.out
-ip route add table vpnonly.out via "$5"
-ip route flush cache


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
