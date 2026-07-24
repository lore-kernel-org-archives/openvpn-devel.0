Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A062C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 05:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6J//GGDYWzgh9mPsLVpD27DZ2xQF79qZRtu7Zt6Q+s0=; b=A4tKUbB48+24NRImR5krXaV7uB
	kd5DDieBp6dC2r7UVCl8G0HMfrSRcmapzXafV/YwomTLOiLAnY8kegqJR/eldPHQ1HWxFOdEVcyfX
	4OcrAGnkoAqAd1cTXPER8VD/t/0283mVEhrUnQlfrFP68P9/fM6KS8r2ug6fQ6BJB+lI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wn8sl-0005S3-Hj;
	Fri, 24 Jul 2026 05:55:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wn8sk-0005Rv-00
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 05:55:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3ZZmOfDTL1fGlk1r2Fr21fYHQsyD+0OXUlJBThBKIn4=; b=dY8YLUZuKwGDUVkMYXEX0kt0bW
 CuiZBnYevQF/m9EBNHgejSmvfaVoiftUZHxNjM3H/SEq4ZImqeBS5NFyx8S0WHoUrBALw4H5VYBI4
 8TH+2RrWpgxxuU/CDjGMKpw4ie7bs8x5ytmb8WRLvTUgnL996wnLTbwFHTqFCtyjPyFw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3ZZmOfDTL1fGlk1r2Fr21fYHQsyD+0OXUlJBThBKIn4=; b=OigNfz00WFfMUfRPJa0CHSunHb
 Jk8s682zYCfwHk4SFIfXcQOkbjzK+t+wHVw7wtzAc9q1jgSVeQ6fVADGtwDYX7GD6zhNy5mwmmKWg
 fMN3Dhbsj0A/jCujI0Grfer74TCy/RnILgSozjlqxKh9iBEb5f16rAluubVIFMoPEwNg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wn8sm-0002c5-O2 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 05:55:38 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66O5tUFM001401
 for <openvpn-devel@lists.sourceforge.net>; Fri, 24 Jul 2026 07:55:30 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66O5tUBG001395
 for openvpn-devel@lists.sourceforge.net; Fri, 24 Jul 2026 07:55:30 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 24 Jul 2026 07:55:23 +0200
Message-ID: <20260724055529.1376-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1771284291000.I0ca7b5b7ec1a01acaad222c99db137c94c88555a@gerrit.openvpn.net>
References: <gerrit.1771284291000.I0ca7b5b7ec1a01acaad222c99db137c94c88555a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wn8sm-0002c5-O2
Subject: [Openvpn-devel] [PATCH v3] options: make `tun` the default for
 `--dev`
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Antonio Quartulli <antonio@mandelbit.com>

With this change, OpenVPN can be launched without specifying
any --dev option and it will start a `tun` (L3) tunnel with the
interface named `tunX`.
As before, this behaviour can be changed using --dev or --dev-type.

Existing configs won't see any behavioural change as they all
had to contain at least one --dev directive.

Change-Id: I0ca7b5b7ec1a01acaad222c99db137c94c88555a
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1537
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1537
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/doc/man-sections/examples.rst b/doc/man-sections/examples.rst
index 80ef2df..416e576 100644
--- a/doc/man-sections/examples.rst
+++ b/doc/man-sections/examples.rst
@@ -63,6 +63,10 @@
 Example 1: A simple tunnel without security (not recommended)
 -------------------------------------------------------------
 
+Since :code:`tun` is the default device type, ``--dev`` is optional; when it
+is omitted OpenVPN creates a dynamically-named ``tunX`` device. The examples
+below still name the device (``--dev tun1``) explicitly for clarity.
+
 On bob::
 
    openvpn --remote alice.example.com --dev tun1 \
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 33ebedb..960c6ad 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -50,6 +50,10 @@
   :code:`null` or an arbitrary name string (:code:`X` can be omitted for
   a dynamic device.)
 
+  If neither ``--dev`` nor ``--dev-type`` is specified, OpenVPN defaults to
+  :code:`tun`, i.e. it creates a dynamically-named :code:`tunX` device and
+  runs a layer-3 tunnel.
+
   See examples section below for an example on setting up a TUN device.
 
   You must use either tun devices on both ends of the connection or tap
diff --git a/sample/sample-config-files/client.conf b/sample/sample-config-files/client.conf
index 53b8027..1806b24 100644
--- a/sample/sample-config-files/client.conf
+++ b/sample/sample-config-files/client.conf
@@ -20,6 +20,8 @@
 # On most systems, the VPN will not function
 # unless you partially or fully disable
 # the firewall for the TUN/TAP interface.
+# "tun" is the default device type, so the
+# "dev tun" line below is optional.
 ;dev tap
 dev tun
 
diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-files/server.conf
index 8943c34..924fb96 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -49,6 +49,8 @@
 # On most systems, the VPN will not function
 # unless you partially or fully disable/open
 # the firewall for the TUN/TAP interface.
+# "tun" is the default device type, so the
+# "dev tun" line below is optional.
 ;dev tap
 dev tun
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 87218d4..d4cc158 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -189,7 +189,8 @@
     " or --socks-proxy"
     " is used).\n"
     "--nobind        : Do not bind to local address and port.\n"
-    "--dev tunX|tapX : tun/tap device (X can be omitted for dynamic device.\n"
+    "--dev tunX|tapX : tun/tap device (X can be omitted for dynamic device).\n"
+    "                  Defaults to \"tun\" if neither --dev nor --dev-type is given.\n"
     "--dev-type dt   : Which device type are we using? (dt = tun or tap) Use\n"
     "                  this option only if the tun/tap device used with --dev\n"
     "                  does not begin with \"tun\" or \"tap\".\n"
@@ -801,6 +802,7 @@
     gc_init(&o->dns_options.gc);
 
     o->mode = MODE_POINT_TO_POINT;
+    o->dev = "tun";
     o->topology = TOP_UNDEF;
     o->ce.proto = PROTO_UDP;
     o->ce.af = AF_UNSPEC;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
