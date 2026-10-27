Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9A606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KLasT90J;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JK9SjRhr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dLN2jqG6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=c0ZOpp54
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=af8Psv6RachdupNETlZPrv58e16QvTYym3Q7WLQXMDc=; b=KLasT90J7DRBPTsDKcDJLheOb0
	sAd8HjHNXIoMOuGTts11mnz+07QQ/QJOq9R8UA80ESobJsu6SuQ6UJI5MkSDxkJy8jCqH+FwImHqF
	rEqqiBZG+K832vV3Zoku5bsGIpehQxip+R8Ah+sQ9jECK4zFPXmGqQG5/Iky7ZlwU2OQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLeD5-000000003qn-3qn9;
	Tue, 27 Oct 2026 10:15:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLeCZ-000000003ja-05mX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:14:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sWOtnjeICmZrZEr6FGpUMGpIWj/0/oASIoBC6R+lJBI=; b=JK9SjRhrQeaqQhnUTk62Zg9+ih
 Prn7HKnk8b3aG7eJXvQS+2lnTl4aVLMEBA/8OqPzpdYFaMXlMqmaeflTYcdwHRgZWKtYe+6GHEKGj
 /5NIKfNSF71pxRQf/c0VYvFUtqYZWCuCMTGwx1iFKVnJZMOGYdbp9umVIxANnLUj9m08=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sWOtnjeICmZrZEr6FGpUMGpIWj/0/oASIoBC6R+lJBI=; b=dLN2jqG6mUtWjbp/35jj8SDiJv
 4Wn4pasSPdllggiO8oTyqZyTDxhRe2s2kP5qx0ZHGVgN6L1G6UGn74VwZUqZCYTO0Yt+a0H8t7xr0
 lAm/agE2S1cXMbXlsFnk+HEoS/oUzQCfxMhwzDp8Zi9uUPZUwM3HILDdez571eT9k/XM=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLeCX-000000001zo-3nI3 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:14:42 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso2359114f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793096075; x=1793700875; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sWOtnjeICmZrZEr6FGpUMGpIWj/0/oASIoBC6R+lJBI=;
 b=c0ZOpp54AEgcWZ7XC+TskUmZDcOYU8AHmMgUljxfaQWiaTpjquJKC/Z3lmFu4fguEz
 KMOhpho/YiAsOUJD0vjIEQsq2MIR/FRZLoACLTPktPVv3XOJT9o2q3bHg0kx9f/WDTcm
 WljiXPbXEuP9sJbFKERZnFAPfyGUBqQh692bIOEJC9Brfj/qyKYM/purfpdPnTuwwV2M
 ck+KQ2220Ux9X5jETTKoWgsaB9I+RSRJpHmKERCcM2zhOMyH2qICpN69ZkTCk5GLG3du
 ejor52AaQaCPO3QFbue6tdwMySv+2XA3owwecOEV/YiKHgQb7rtibYceWr3Jko6NLimI
 VBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793096075; x=1793700875;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sWOtnjeICmZrZEr6FGpUMGpIWj/0/oASIoBC6R+lJBI=;
 b=Mc+wxibZ03gV6+WIYTLQ/WFOvE1o2/3iLrIx74hWR6btPkOHU0oGvIUOv7oGBtnXZi
 x70FIO1tc+v3BfWxsALrCJWuQpRHG9UH0T5pVmZnrDUvuxrbyZyz1zabM0RmyGXEgkT4
 uUMX/A38cWsaRawr8ONTTEA5WRormX2gCAorhUI40JyFcJNZvuCV114Moe01YCO3R5Tm
 xi6mmlg7PO9+xX18LXT48V5rUvQD7Q7DnTyyys7OvMD02pSSFhRy2YA+RB42dVhnmQGR
 RMXXIKzGAER/cCzY/Ih1mzaaadtYLGshj/HrLBPVlCp4qzIU+bKs5gsLWaefbJql/uvk
 9JUw==
X-Gm-Message-State: AFq9FYIzzHkHIbZeaYo7wYW/CpGmBnsMmEGmq2ctj4GWEbznGpcY712o
 Kbj+8rEcswtsQR+Yu7lXA0MI2wWxAJKd/PJkKQuYcE5k5o0Kiu9n/fa8qeOYnOY98hJzDZUYRFs
 TrJopTvIhLE2YTcOFMOL3Gm+lxCfqMZuZpi+oJvG5hQwtKPAxHK4yxGlg29TUN5/fuStMOV/aNB
 JacDZemQ==
X-Gm-Gg: AYBFou18h3IGmaEtIug6lyBosaYGHBxKAjgeGXOXN//na5Pvz17spOE5zxxVSee5v1L
 XaTeDVVXvElsDI9Q7Ni1z1kdFEVT7T+RVkL3/E5d1VTiWGEEScQA5Yg91uvWnOnovxs8TRm4ZNJ
 jWDdGBn9ZB8R5Svm1C29XwpUvUgL4N7UAWqg5JYOB40hrQwGlhrhISCW1ik7j8Xuzo8CZVxS1P0
 VQqRFqL8QJxRrTWZQe1h3+cnhXV1LohaaQUkPaM12hBnZpW6BWAAk/9CxNL0mdaMK2MUUyZltsd
 at33sV7ImF24l4fUoP2CT6U7+OTwQq4OTn9TFG5q7M2zW9XIcB9BCklT4KbzY/Vp7KqggpMoWfp
 1oam7Qi0tXrng9nnkmdva6QDGn7khx/q4+gkh6uHdb1kSPSelV8ZK7dD6bzT5hTO9VmNMrvt1yO
 6rKOPUZbIJfwnF+KMirCi5wx0HE0RlEGLuEu8jh9JAi7vEoUxdldoGR8n1u2uir3ULTKFpAZbCz
 Yvup716GMWqCvUS9bH+gxd6XuZ1lLnxlsSoqcgIXYUI0HvqR2E/Y0QuBJioOMft+mHNkE12GZLR
 qXwZFMIe9tEy5et0rrngyGdMc7D/OZT6JjGorOibuqxjgmesI9FCArTa/u/cb4qLvyH2E0550ut
 qQe6CLqPBGTbkmRKMxwPFqxdrFZ6FbDoKbi6keR2bkA==
X-Received: by 2002:a05:6000:1a8a:b0:485:8c17:9764 with SMTP id
 ffacd0b85a97d-48e3eb94b77mr18598871f8f.38.1793096075182; 
 Tue, 27 Oct 2026 03:14:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece14a1sm22538396f8f.57.2026.10.27.03.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 03:14:34 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 10:14:34 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If09735841cd90aa4b07e85448ccf3b2f5944528e
X-Gerrit-Change-Number: 2054
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2054?usp=email>
X-Gerrit-Commit: 99c1de64602c12a01e50fac2a373692a941c0d95
References: <gerrit.1793096063000.If09735841cd90aa4b07e85448ccf3b2f5944528e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk2MDYzMDAwLklmMDk3MzU4NDFjZDkwYWE0YjA3ZTg1NDQ4Y2NmM2IyZjU5NDQ1MjhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <622da2ec4a633b417bdc584a65678f282fb4b94c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLeCX-000000001zo-3nI3
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: add support
 for --transport-plugin
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2516209856224368198=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2516209856224368198==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G5Lmo8/Feyo="; charset=UTF-8

--G5Lmo8/Feyo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2054?usp=3Demail

to review the following change=2E
=


Change subject: options: add support for --transport-plugin
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: add support for =
--transport-plugin

Add a new config option to allow the user to specify a =
transport plugin
implementing the new API=2E This plugin can be used to man=
ipulate traffic
in any way, as designed by the plugin developer=2E

The fon=
damental advantage of this plugin is that the core codebase does
not need t=
o know anything about its implementation, as soon as it
implements the tran=
sport API properly=2E

A plugin specified with --transport-plugin must be a=
lready loaded via
--plugin=2E --transport-plugin is a per-connection-block =
option and
specifies which plugin to use for this particular connection=2E
=
It can take additional arguments, if required by the specific plugin=2E

Th=
e manpage has been extended accordingly=2E

Change-Id: If09735841cd90aa4b07=
e85448ccf3b2f5944528e
Signed-off-by: Robin Tarsiger <rtt@dasyatidae=2Ecom>
=
[antonio@openvpn=2Enet: refactored commits, restyled code]
[gianmarco@mande=
lbit=2Ecom: rebased, adapted to multisocket]
---
M src/openvpn/dco=2Ec
M sr=
c/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/socket=2Ec
4 =
files changed, 38 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/54/2054/1

diff --git a/src/ope=
nvpn/dco=2Ec b/src/openvpn/dco=2Ec
index f3b5d44=2E=2Ed9e4729 100644
--- a/=
src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -270,6 +270,12 @@
        =
 return false;
     }
 
+    if (ce->transport_plugin_argv)
+    {
+       =
 msg(msglevel, "Note: --transport-plugin disables data channel offload=2E")=
;
+        return false;
+    }
+
 #if defined(TARGET_FREEBSD)
     if (ce-=
>local_list)
     {
diff --git a/src/openvpn/options=2Ec b/src/openvpn/opti=
ons=2Ec
index 912d8e0=2E=2E1720fc3 100644
--- a/src/openvpn/options=2Ec
+++=
 b/src/openvpn/options=2Ec
@@ -430,6 +430,9 @@
 #ifdef ENABLE_PLUGIN
     "=
--plugin m [str]: Load plug-in module m passing str as an argument\n"
     =
"                  to its initialization function=2E\n"
+    "--transport-p=
lugin m [args]: Use plug-in module m to provide the transport\n"
+    "    =
                         layer, with optional per-connection args=2E The\n"=

+    "                             module must already be loaded with --pl=
ugin=2E\n"
 #endif
     "--vlan-tagging  : Enable 802=2E1Q-based VLAN taggi=
ng=2E\n"
     "--vlan-accept tagged|untagged|all : Set VLAN tagging mode=2E=
 Default is 'all'=2E\n"
@@ -1622,6 +1625,22 @@
         msg(M_USAGE, "multi=
ple --local statements only allowed in --server mode");
     }
 
+#ifdef EN=
ABLE_PLUGIN
+    /*
+     * "proto indirect" may not be specified directly =
without a
+     * transport-plugin, and vice versa=2E
+     */
+    if (ce-=
>proto =3D=3D PROTO_INDIRECT && !ce->transport_plugin_argv)
+    {
+       =
 msg(M_USAGE, "--proto indirect may not be used without a transport-plugin =
line");
+    }
+
+    if (ce->transport_plugin_argv && ce->proto !=3D PROTO=
_INDIRECT)
+    {
+        msg(M_USAGE, "--transport-plugin must be used wi=
th --proto indirect");
+    }
+#endif
+
     if (options->lladdr && dev !=
=3D DEV_TYPE_TAP)
     {
         msg(M_USAGE, "--lladdr can only be used i=
n --dev tap mode");
@@ -4424,7 +4443,17 @@
             goto err;
         =
}
     }
-#endif
+    else if (streq(p[0], "transport-plugin") && p[1])
+  =
  {
+        VERIFY_PERMISSION(OPT_P_PLUGIN | OPT_P_CONNECTION);
+
+       =
 /* p[1] is the shared object name, which becomes
+         * argv[0]=2E p[=
2=2E=2E] are connection-specific transport
+         * parameters, which be=
come argv[1=2E=2E]=2E
+         */
+        options->ce=2Etransport_plugin_=
argv =3D make_extended_arg_array(&p[1], false, &options->gc);
+    }
+#endi=
f /* ifdef ENABLE_PLUGIN */
     else if (streq(p[0], "mode") && p[1] && !p=
[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/ope=
nvpn/options=2Eh b/src/openvpn/options=2Eh
index c58530a=2E=2Eb117fa4 10064=
4
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -112,6 +11=
2,7 @@
     sa_family_t af;
     const char *local_port;
     bool local_po=
rt_defined;
+    const char **transport_plugin_argv;
     const char *remot=
e_port;
     const char *remote;
     bool remote_float;
diff --git a/src/o=
penvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 9629cb3=2E=2E07090f6 10064=
4
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -1105,6 +110=
5,7 @@
     sock->info=2Ebind_ipv6_only =3D o->ce=2Ebind_ipv6_only;
     so=
ck->info=2Eipchange_command =3D o->ipchange;
     sock->info=2Eplugins =3D =
c->plugins;
+    sock->info=2Etransport_plugin_argv =3D o->ce=2Etransport_p=
lugin_argv;
     sock->server_poll_timeout =3D &c->c2=2Eserver_poll_interva=
l;
 
     sock->mode =3D mode;

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2054?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: If09735841cd90aa4b07e85448ccf3b2f5944528e
Gerrit-Change-Numbe=
r: 2054
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gregori <gianmarco@ma=
ndelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--G5Lmo8/Feyo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2054?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">options: add support for --transport-plugin<br><br>Add =
a new config option to allow the user to specify a transport plugin<br>impl=
ementing the new API=2E This plugin can be used to manipulate traffic<br>in=
 any way, as designed by the plugin developer=2E<br><br>The fondamental adv=
antage of this plugin is that the core codebase does<br>not need to know an=
ything about its implementation, as soon as it<br>implements the transport =
API properly=2E<br><br>A plugin specified with --transport-plugin must be a=
lready loaded via<br>--plugin=2E --transport-plugin is a per-connection-blo=
ck option and<br>specifies which plugin to use for this particular connecti=
on=2E<br>It can take additional arguments, if required by the specific plug=
in=2E<br><br>The manpage has been extended accordingly=2E<br><br>Change-Id:=
 If09735841cd90aa4b07e85448ccf3b2f5944528e<br>Signed-off-by: Robin Tarsiger=
 &lt;rtt@dasyatidae=2Ecom&gt;<br>[antonio@openvpn=2Enet: refactored commits=
, restyled code]<br>[gianmarco@mandelbit=2Ecom: rebased, adapted to multiso=
cket]<br>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/options=2Ec<br>M src=
/openvpn/options=2Eh<br>M src/openvpn/socket=2Ec<br>4 files changed, 38 ins=
ertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/54/2054/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index f3b5d44=2E=
=2Ed9e4729 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span=
>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -270,6 +270,12 @@</span><br><=
span>         return false;</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;transport_p=
lugin_argv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, =
&quot;Note: --transport-plugin disables data channel offload=2E&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(TARGE=
T_FREEBSD)</span><br><span>     if (ce-&gt;local_list)</span><br><span>    =
 {</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/optio=
ns=2Ec</span><br><span>index 912d8e0=2E=2E1720fc3 100644</span><br><span>--=
- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</=
span><br><span>@@ -430,6 +430,9 @@</span><br><span> #ifdef ENABLE_PLUGIN</s=
pan><br><span>     &quot;--plugin m [str]: Load plug-in module m passing st=
r as an argument\n&quot;</span><br><span>     &quot;                  to it=
s initialization function=2E\n&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &quot;--transport-plugin m [args]: Use plug-in module =
m to provide the transport\n&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;                             layer, with optional =
per-connection args=2E The\n&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;                             module must already b=
e loaded with --plugin=2E\n&quot;</span><br><span> #endif</span><br><span> =
    &quot;--vlan-tagging  : Enable 802=2E1Q-based VLAN tagging=2E\n&quot;</=
span><br><span>     &quot;--vlan-accept tagged|untagged|all : Set VLAN tagg=
ing mode=2E Default is &#39;all&#39;=2E\n&quot;</span><br><span>@@ -1622,6 =
+1625,22 @@</span><br><span>         msg(M_USAGE, &quot;multiple --local st=
atements only allowed in --server mode&quot;);</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef =
ENABLE_PLUGIN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * &quot;proto =
indirect&quot; may not be specified directly without a</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * transport-plugin, and vice versa=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;proto =3D=3D =
PROTO_INDIRECT &amp;&amp; !ce-&gt;transport_plugin_argv)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;--proto indirect may not =
be used without a transport-plugin line&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (ce-&gt;transport_plugin_argv &amp;&amp; ce-&gt;proto !=3D PROTO_INDIRECT=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;--tra=
nsport-plugin must be used with --proto indirect&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     if (options-&gt;lladdr &amp;&amp; dev !=3D =
DEV_TYPE_TAP)</span><br><span>     {</span><br><span>         msg(M_USAGE, =
&quot;--lladdr can only be used in --dev tap mode&quot;);</span><br><span>@=
@ -4424,7 +4443,17 @@</span><br><span>             goto err;</span><br><spa=
n>         }</span><br><span>     }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    else if (streq(p[0], &quot;transport-plugin&quot;) &amp;&amp; p[1])</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_PLUG=
IN | OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* p[1]=
 is the shared object name, which becomes</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         * argv[0]=2E p[2=2E=2E] are connection-speci=
fic transport</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * parameters, which become argv[1=2E=2E]=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        options-&gt;ce=2Etransport_plugin_argv =3D make_=
extended_arg_array(&amp;p[1], false, &amp;options-&gt;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_PLUGIN */</span><br><span> =
    else if (streq(p[0], &quot;mode&quot;) &amp;&amp; p[1] &amp;&amp; !p[2]=
)</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_G=
ENERAL);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn=
/options=2Eh</span><br><span>index c58530a=2E=2Eb117fa4 100644</span><br><s=
pan>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=
=2Eh</span><br><span>@@ -112,6 +112,7 @@</span><br><span>     sa_family_t a=
f;</span><br><span>     const char *local_port;</span><br><span>     bool l=
ocal_port_defined;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const char **transport_plugin_argv;</span><br><span>     const char *rem=
ote_port;</span><br><span>     const char *remote;</span><br><span>     boo=
l remote_float;</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/o=
penvpn/socket=2Ec</span><br><span>index 9629cb3=2E=2E07090f6 100644</span><=
br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/soc=
ket=2Ec</span><br><span>@@ -1105,6 +1105,7 @@</span><br><span>     sock-&gt=
;info=2Ebind_ipv6_only =3D o-&gt;ce=2Ebind_ipv6_only;</span><br><span>     =
sock-&gt;info=2Eipchange_command =3D o-&gt;ipchange;</span><br><span>     s=
ock-&gt;info=2Eplugins =3D c-&gt;plugins;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    sock-&gt;info=2Etransport_plugin_argv =3D o-&gt;c=
e=2Etransport_plugin_argv;</span><br><span>     sock-&gt;server_poll_timeou=
t =3D &amp;c-&gt;c2=2Eserver_poll_interval;</span><br><span> </span><br><sp=
an>     sock-&gt;mode =3D mode;</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2054?usp=3Demail">change 205=
4</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2054?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
If09735841cd90aa4b07e85448ccf3b2f5944528e </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2054 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gr=
egori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--G5Lmo8/Feyo=--


--===============2516209856224368198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2516209856224368198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2516209856224368198==--

