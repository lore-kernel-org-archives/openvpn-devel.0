Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C4606A331
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ISQh/1/C;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mqyKomN9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dy+3QKkv;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NXkU0XM2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mQq0aWUCOzALNKf5nJ1vwtsWI6rREIO7BJryKxHzb88=; b=ISQh/1/COt43zBfmgsJ1DwOhpU
	duOwD6+8NV4mXrvmtLO4I2yVrFCXDCE12MmexoprlsqOyDEATbaYby2LYMJGxs4V/7HqI91XVy/8w
	uhElNBsiBP2UhjdEJYub12dHMo3njgjvjOeLvGUL5IkVpDTSbIqK+ImrYn58kg/SCU7w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTKms-000000006Qh-3MEh;
	Tue, 17 Nov 2026 15:07:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTKms-000000006QX-0V7Z
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 15:07:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hGTPYzmm8DWYy02PMBMjJSSDUKeO+kwVxxcPOxUWS6g=; b=mqyKomN9Gsb0DPuu+jJomE9H/l
 +VNhFXXWaqep4d+zl/MUd5qYgRvdVT9FvazE+MOo2y8ei/ooVxAD9v7WAvHo5scCSSRPpDlyYoZ1l
 ErId9IEkLiOJRe07hPZa8jCE6oKRCVsx8Spp7jD7sVKSzDHl5Wf8ES/+ieUqv7wpnLg4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hGTPYzmm8DWYy02PMBMjJSSDUKeO+kwVxxcPOxUWS6g=; b=dy+3QKkvQieQZYtl4UdbxfnEzS
 0tCM0INcwnaUd07GslnhJDDAdppkSvRsdwYlBE4bpz+vfdPZ26LuE7ObpQE0IOEAlDSU5/Q01Teew
 5bJqWw8YErNa2HTML+rK5/xYl25Yt2k+X8BlCqoBkUlaE2VhtB+TXdi6wnlQfcf/Z7lA=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTKmq-000000000yL-1uz2 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 15:07:58 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so24416055e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 07:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794928070; x=1795532870; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hGTPYzmm8DWYy02PMBMjJSSDUKeO+kwVxxcPOxUWS6g=;
 b=NXkU0XM2iYClnzNj3O6yyleFq8N89RJD078s81nEooBIVFiUZFwMv8z4i5EvZl9sAu
 OBTOnZ8iOtPTD2fwjY7KiYJCSN7GKpLdpofsIrfeGi+IqKMZYErB80vKO2UO+eRHcfo6
 d73mFgcto0duYaGen4Olyzi1M49QL3SCTDUNygoOzRu7wnCCoTAuCZY5zSv434lheZG2
 vrbPVWwmt4ypGvn+Aygu0RqFrZ5d445w3x9G56KLfYyLluxuPMmt3CA12n/IRLQR9Il6
 EGzgenPBK8Kfh7PEwttzZX6WXXZfOqpjghg0sFrhZbGG+qcqKsQb64Vu7dNUtIG1mxGB
 EYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928070; x=1795532870;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hGTPYzmm8DWYy02PMBMjJSSDUKeO+kwVxxcPOxUWS6g=;
 b=dTY5EfeYlQPCaUMnKjcWgOywIL7UsMRH0RlZVQnQQXoRVuXBchgCJhkOAT/tXaVj/x
 TpbPlaqzHqG6FJjvm+rCPh2re6EPRqg1JtpFNfbEfI5PfyOPSKJh8G3HvPjQKlhW8SY6
 cyVwAkbzA2qXjVOBP2qc4PBxehhpf52wHyOLRQh7+RfgYyhUYBAbIg3bFMjpfljOkANW
 yqMC/asGwORnU1BEbBzuVGS5UlCCIhVCB3XCPvcLmNZg3TMJjcxcuXfwsSdfrFkCzZBG
 c8vqXp6g39nVAAPkd1fVglMIAdIOy4y5u7GQXP8wDmGTW3NUcpB+LGC3dbxwR9h9SgRC
 kekQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFWeRAV8yQBlYQc7hIxPrl/cENNwKhapVx/pXrRB2XRB7ngu0rZelt8uKBbQ1ILQdyAQ4m86gFH0X0WmmJE@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9sdLafatWiuflQJj/Pt7QyUxUG+doMx/IDkWwPQfLKtavhhciH
 A3gfza/O7xTdBIYGYQZPT4fKABIKPVQO5UEIJ8wTJMptYScjs+Y4P1xoAiG1vlxBTK7oriMX4HE
 XIJ3Eqsd8nw+MVGujDA8MOQe85XcLcTS/iCXzpS6pvC+knjesUU3TBslXesetx3IUDoei
X-Gm-Gg: AYBFou2AuirJxKxu/ZWvs7zT8rlnEDLsN6uGSDqdkSWLZwk7R2MBdXZ83c227Br44iW
 q35wOqj/5XV0CN+XiOY3Xotu6HHAbRqj0ZfP5f1GqSXkalNMl4Ce7Yg2HrufOugZZ/5cXeB85e3
 edIEUbTuz3SsKTtUbvYbIV+kZLTzd0VyVGAA5JQjiywzJaXANiejCq9zxxGUbPX1YRU0YHCxned
 Zg+GO4G0/cpv8dbUpRkQ5LGADMlQgZu5mJJBt5VjEH9YScUZOQqtNRBS/oBMuurOoeh7l05ACQn
 Pd6Uysra45Q4FTQT1xKpc5qlUiPn0osHU4Znj7QyDLmKhHZAWNHlubH4TZTvA7UuE3YIPWavxaY
 qLOMe/UqP8tCXSWDNf6/q85XAcDZLV3oH5VofPqCKfHtOBugZgBcwP6Af8a9bzZX4eMuPWDrYhB
 fg1Fxd9J0acBvUkFvB98q50iS3dliz7HKfPYxzhZybRVN82otGtHm2oYg1BJmArsBKwiomBhg0V
 pwosg5hZZHsyj1glAckLWk4L0Ix0kKuftd/zal+TeaoUUe+BSOO76ccgc9EEej36zXAFCK48x8V
 TenIX4gvguQxQnn3kZS7hQlFhzWQL1RUytC0ZPJsMXHRlrMO2PBnHPX2vumONSjn9n7BioSP4+t
 M+S5cZ85/x/9O3C1QCbkNwmZbgKogetkSDloqUxpkkctM/z1npHq9KRjEx1l0blryGvvFxP6K6n
 61VshXCztI/YiOMm0=
X-Received: by 2002:a05:600c:890d:b0:4bb:5c97:f4b1 with SMTP id
 5b1f17b1804b1-4bb5c97f545mr206925575e9.24.1794928068342; 
 Tue, 17 Nov 2026 07:07:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78420edasm108538825e9.9.2026.11.17.07.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 07:07:47 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 15:07:47 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
X-Gerrit-Change-Number: 2170
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2170?usp=email>
X-Gerrit-Commit: 727e2463939d5b4118b2b19f4445493597484718
In-Reply-To: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
References: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzQwMzgwMDAwLkk1YWI5NTllNzEwMWNmODAxYWM5M2U1MTg1ODU1ZTc1ZGIwZmI2MjI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bcc2627508854cc1a4e873f3fd63a2874a8534a9-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xTKmq-000000000yL-1uz2
Subject: [Openvpn-devel] [M] Change in openvpn[master]: DragonFly: bring
 things back into a working state
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
Content-Type: multipart/mixed; boundary="===============0452911622882777911=="
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0452911622882777911==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UG1d1fD1Ja4="; charset=UTF-8

--UG1d1fD1Ja4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2170?usp=3Demail )

Change subject: DragonFly: bring things bac=
k into a working state
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

DragonFly: bring things back into a working state

- t_client=2E=
sh(=2Ein): add "DragonFly" to the OS versions "like FreeBSD"

- tun=2Ec ope=
n_tun()
   - add DragonFly specific handling of dynamic tun/tap devices
   =
  (open /dev/{tun,tap}, assigns first-free node, fdevname(fd) returns
     =
 true device name)
     --dev tunN (and tapN) works "the old way", by openi=
ng /dev/tunN - but
     only for devices pre-created with "ifconfig tun3 cr=
eate"
   - set ioctl(TUNSIFMODE, IFF_BROADCAST=3D1) for "topology subnet" t=
un ifs
     -> this is sufficient to make FreeBSD "ifconfig ipv4" code work=

     (DragonFly was broken by FreeBSD commit 94db3261659)

- tun=2Ec do_if=
config_ipv4()
   - use TARGET_FREEBSD code path for DragonFly too, just ame=
nd the
     error message ("FreeBSD/DragonFly ifconfig failed")

- tun=2Ec =
do_ifconfig_ipv6()
   - needs "add_route_connected_v6_net()" for tun and ta=
p(!) devices,
     otherwise the on-link /64 is not routed to the tun devic=
e

- tun=2Ec undo_ifconfig_ipv4(), undo_ifconfig_ipv6()
   - share FreeBSD =
code to undo IPv4/IPv6 ifconfig on precreated interfaces
   - add delete_ro=
ute_connected_v6_net() call for DragonFly only
     (this is not removing f=
e80:: addresses from the tun if, which upsets
      t_client test, but for =
normal usage is considered "reasonably fine")

- lladdr=2Ec: add TARGET_DRA=
GONFLY to TARGET_FREEBSD format

v1 -> v2:
 - fix clang-format issues
 - in=
troduce TUNSIFMODE setting
 - revert do_ifconfig_ipv4 change from v1 (use F=
REEBSD code path)
 - use M_ERR instead of M_FATAL
 - gate --dev tun/tap che=
ck on --dev-node being unset

v2 -> v3:
 - clang-format in lladdr=2Ec and t=
_client=2Esh=2Ein

Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
Git=
hub: see also DragonFlyBSD/DPorts#266
Signed-off-by: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170
Message-Id: <2026111516=
4331=2E8511-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg41373=2Ehtml
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/lladdr=2Ec
M src/ope=
nvpn/tun=2Ec
M tests/t_client=2Esh=2Ein
3 files changed, 75 insertions(+), =
17 deletions(-)




diff --git a/src/openvpn/lladdr=2Ec b/src/openvpn/lladd=
r=2Ec
index 8bd572a=2E=2E43480f1 100644
--- a/src/openvpn/lladdr=2Ec
+++ b/=
src/openvpn/lladdr=2Ec
@@ -24,7 +24,7 @@
 }
 #else /* TARGET_LINUX */
 
-#i=
f defined(TARGET_OPENBSD) || defined(TARGET_FREEBSD) || defined(TARGET_DARW=
IN)
+#if defined(TARGET_OPENBSD) || defined(TARGET_FREEBSD) || defined(TARG=
ET_DARWIN) || defined(TARGET_DRAGONFLY)
 #define IFCONFIG_LLADDR_FMT "%s %s=
 lladdr %s"
 #elif defined(TARGET_NETBSD)
 #define IFCONFIG_LLADDR_FMT "%s =
%s link %s active"
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
i=
ndex c56ace3=2E=2Efe1af45 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvp=
n/tun=2Ec
@@ -979,7 +979,7 @@
 #endif /* ifdef _WIN32 */
 }
 
-#if defined(=
_WIN32)
+#if defined(_WIN32) || defined(TARGET_DRAGONFLY)
 
 /* some of the=
 platforms will auto-add a "network route" pointing
  * to the interface on=
 "ifconfig tunX 2001:db8::1/64", others need
@@ -1014,8 +1014,7 @@
     rou=
te_ipv6_clear_host_bits(&r6);
     delete_route_ipv6(&r6, tt, NULL, NULL);
=
 }
-#endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGE=
T_NETBSD) || \
-          defined(TARGET_OPENBSD) */
+#endif /* if defined(=
_WIN32) || defined(TARGET_DRAGONFLY) */
 
 #if defined(TARGET_NETBSD) || de=
fined(TARGET_OPENBSD)
 /* we can't use true subnet mode on tun on all platf=
orms, as that
@@ -1160,6 +1159,10 @@
     openvpn_execve_check(&argv, es, S=
_FATAL, "FreeBSD BSD 'ifconfig inet6 -ifdisabled' failed");
 #endif
 
+#ifd=
ef TARGET_DRAGONFLY
+    add_route_connected_v6_net(tt, es);
+#endif
+
 #el=
if defined(TARGET_AIX)
     argv_printf(&argv, "%s %s inet6 %s/%d mtu %d up=
", IFCONFIG_PATH, ifname, ifconfig_ipv6_local,
                 tt->netbits=
_ipv6, tun_mtu);
@@ -1490,7 +1493,7 @@
     }
 
     argv_msg(M_INFO, &argv=
);
-    openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD ifconfig failed")=
;
+    openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD/DragonFly ifconfig=
 failed");
 
 #elif defined(TARGET_AIX)
     {
@@ -1623,14 +1626,14 @@
    =
         msg(M_WARN, "Linux can't del IP from iface %s", tt->actual_name);
=
         }
     }
-#elif defined(TARGET_FREEBSD)
+#elif defined(TARGET_FREE=
BSD) || defined(TARGET_DRAGONFLY)
     struct gc_arena gc =3D gc_new();
   =
  const char *ifconfig_local =3D print_in_addr_t(tt->local, 0, &gc);
     s=
truct argv argv =3D argv_new();
 
     argv_printf(&argv, "%s %s %s -alias"=
, IFCONFIG_PATH, tt->actual_name, ifconfig_local);
     argv_msg(M_INFO, &a=
rgv);
-    openvpn_execve_check(&argv, NULL, 0, "FreeBSD ip addr del failed=
");
+    openvpn_execve_check(&argv, NULL, 0, "FreeBSD/DragonFly ip addr de=
l failed");
 
     argv_free(&argv);
     gc_free(&gc);
@@ -1646,7 +1649,12=
 @@
     {
         msg(M_WARN, "Linux can't del IPv6 from iface %s", tt->a=
ctual_name);
     }
-#elif defined(TARGET_FREEBSD)
+#elif defined(TARGET_FR=
EEBSD) || defined(TARGET_DRAGONFLY)
+
+#ifdef TARGET_DRAGONFLY
+    delete_=
route_connected_v6_net(tt);
+#endif
+
     struct gc_arena gc =3D gc_new();=

     const char *ifconfig_ipv6_local =3D print_in6_addr(tt->local_ipv6, 0,=
 &gc);
     struct argv argv =3D argv_new();
@@ -1655,7 +1663,7 @@
        =
         ifconfig_ipv6_local, tt->netbits_ipv6);
 
     argv_msg(M_INFO, &a=
rgv);
-    openvpn_execve_check(&argv, NULL, 0, "FreeBSD ip -6 addr del fai=
led");
+    openvpn_execve_check(&argv, NULL, 0, "FreeBSD/DragonFly ip -6 a=
ddr del failed");
 
     argv_free(&argv);
     gc_free(&gc);
@@ -2888,20 +=
2896,70 @@
 
 #elif defined(TARGET_DRAGONFLY)
 
+/* DragonFly tun/tap devic=
es are similar to NetBSD
+ *  - for a dynamic tun/tap, open /dev/tun or /de=
v/tap, get assigned
+ *    the first free device, ask with (f)devname(3) wh=
at you got, and
+ *    the interface will auto-destruct on close
+ *  - for=
 a pre-created tun/tap, open "/dev/tun3"
+ *  - using "--dev tun3" and have=
 it dynamically created needs a call
+ *    to "ifconfig tun3 create" which=
 we don't currently do
+ */
+
 void
 open_tun(const char *dev, const char *=
dev_type, const char *dev_node, struct tuntap *tt,
          openvpn_net_ct=
x_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, tt);
-
-    if =
(tt->fd >=3D 0)
+    if (!dev_node && (strcmp(dev, "tap") =3D=3D 0 || strcm=
p(dev, "tun") =3D=3D 0))
     {
-        int i =3D 0;
+        char tunname=
[256];
+        snprintf(tunname, sizeof(tunname), "/dev/%s", dev);
 
-    =
    /* Disable extended modes */
+        if ((tt->fd =3D open(tunname, O_R=
DWR)) < 0)
+        {
+            msg(M_ERR, "Cannot allocate DragonFly TU=
N/TAP %s dynamically", tunname);
+        }
+
+        char *devname =3D fd=
evname(tt->fd);
+        if (devname =3D=3D NULL)
+        {
+            m=
sg(M_ERR, "Cannot query DragonFly TUN/TAP device name");
+        }
+      =
  set_nonblock(tt->fd);
+        set_cloexec(tt->fd); /* don't pass fd to s=
cripts */
+        msg(M_INFO, "TUN/TAP device %s opened", devname);
+
+   =
     tt->actual_name =3D string_alloc(devname, NULL);
+    }
+    else
+   =
 {
+        open_tun_generic(dev, dev_type, dev_node, tt);
+    }
+
+    if=
 (tt->fd >=3D 0 && tt->type =3D=3D DEV_TYPE_TUN)
+    {
+        /* see "In=
terface Flags" in ifnet(9) */
+        int i =3D IFF_POINTOPOINT | IFF_MULT=
ICAST;
+        if (tt->topology =3D=3D TOP_SUBNET)
+        {
+           =
 i =3D IFF_BROADCAST | IFF_MULTICAST;
+        }
+
+        if (ioctl(tt->f=
d, TUNSIFMODE, &i) < 0)
+        {
+            msg(M_WARN | M_ERRNO, "ioct=
l(TUNSIFMODE)");
+        }
+
+        /* Disable "link layer" mode (would =
prepend route-nexthop address
+         * on read, but is incompatible with=
 TUNSIFHEAD multi-af mode) */
+        i =3D 0;
         ioctl(tt->fd, TUNS=
LMODE, &i);
+
+        /* multi_af mode for v4+v6, see "tun(4)" */
        =
 i =3D 1;
-        ioctl(tt->fd, TUNSIFHEAD, &i);
+        if (ioctl(tt->fd=
, TUNSIFHEAD, &i) < 0)
+        {
+            msg(M_WARN | M_ERRNO, "ioctl=
(TUNSIFHEAD)");
+        }
     }
 }
 
diff --git a/tests/t_client=2Esh=2Ei=
n b/tests/t_client=2Esh=2Ein
index 5e924bb=2E=2Ed81cef0 100755
--- a/tests/=
t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -212,8 +212,8 @@
     =
            LANG=3DC @NETSTAT@ -rn -4 -6
             fi
             ;;
- =
       FreeBSD | NetBSD | Darwin)
-            echo "-- FreeBSD/NetBSD/Darw=
in [MacOS X] --"
+        FreeBSD | DragonFly | NetBSD | Darwin)
+         =
   echo "-- FreeBSD/DragonFly/NetBSD/Darwin [MacOS X] --"
             @IFC=
ONFIG@ -a | egrep "(flags=3D|inet)"
             @NETSTAT@ -rn | awk '$3 !~=
 /^UHL/ { print $1,$2,$3,$NF }'
             ;;

-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
Gerri=
t-Change-Number: 2170
Gerrit-PatchSet: 4
Gerrit-Owner: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--UG1d1fD1Ja4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2170?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">DragonFly: bring things back into =
a working state<br><br>- t_client=2Esh(=2Ein): add &quot;DragonFly&quot; to=
 the OS versions &quot;like FreeBSD&quot;<br><br>- tun=2Ec open_tun()<br>  =
 - add DragonFly specific handling of dynamic tun/tap devices<br>     (open=
 /dev/{tun,tap}, assigns first-free node, fdevname(fd) returns<br>      tru=
e device name)<br>     --dev tunN (and tapN) works &quot;the old way&quot;,=
 by opening /dev/tunN - but<br>     only for devices pre-created with &quot=
;ifconfig tun3 create&quot;<br>   - set ioctl(TUNSIFMODE, IFF_BROADCAST=3D1=
) for &quot;topology subnet&quot; tun ifs<br>     -&gt; this is sufficient =
to make FreeBSD &quot;ifconfig ipv4&quot; code work<br>     (DragonFly was =
broken by FreeBSD commit 94db3261659)<br><br>- tun=2Ec do_ifconfig_ipv4()<b=
r>   - use TARGET_FREEBSD code path for DragonFly too, just amend the<br>  =
   error message (&quot;FreeBSD/DragonFly ifconfig failed&quot;)<br><br>- t=
un=2Ec do_ifconfig_ipv6()<br>   - needs &quot;add_route_connected_v6_net()&=
quot; for tun and tap(!) devices,<br>     otherwise the on-link /64 is not =
routed to the tun device<br><br>- tun=2Ec undo_ifconfig_ipv4(), undo_ifconf=
ig_ipv6()<br>   - share FreeBSD code to undo IPv4/IPv6 ifconfig on precreat=
ed interfaces<br>   - add delete_route_connected_v6_net() call for DragonFl=
y only<br>     (this is not removing fe80:: addresses from the tun if, whic=
h upsets<br>      t_client test, but for normal usage is considered &quot;r=
easonably fine&quot;)<br><br>- lladdr=2Ec: add TARGET_DRAGONFLY to TARGET_F=
REEBSD format<br><br>v1 -&gt; v2:<br> - fix clang-format issues<br> - intro=
duce TUNSIFMODE setting<br> - revert do_ifconfig_ipv4 change from v1 (use F=
REEBSD code path)<br> - use M_ERR instead of M_FATAL<br> - gate --dev tun/t=
ap check on --dev-node being unset<br><br>v2 -&gt; v3:<br> - clang-format i=
n lladdr=2Ec and t_client=2Esh=2Ein<br><br>Change-Id: I5ab959e7101cf801ac93=
e5185855e75db0fb6225<br>Github: see also DragonFlyBSD/DPorts#266<br>Signed-=
off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Razvan Co=
jocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2170<br>Message-Id: &lt;20261115164331=2E8511-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg41373=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/lladdr=2Ec<br>M src/=
openvpn/tun=2Ec<br>M tests/t_client=2Esh=2Ein<br>3 files changed, 75 insert=
ions(+), 17 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/lladdr=
=2Ec b/src/openvpn/lladdr=2Ec</span><br><span>index 8bd572a=2E=2E43480f1 10=
0644</span><br><span>--- a/src/openvpn/lladdr=2Ec</span><br><span>+++ b/src=
/openvpn/lladdr=2Ec</span><br><span>@@ -24,7 +24,7 @@</span><br><span> }</s=
pan><br><span> #else /* TARGET_LINUX */</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_OPENBSD) || defined(=
TARGET_FREEBSD) || defined(TARGET_DARWIN)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(TARGET_OPENBSD) || defined(TARGET_FREEBSD=
) || defined(TARGET_DARWIN) || defined(TARGET_DRAGONFLY)</span><br><span> #=
define IFCONFIG_LLADDR_FMT &quot;%s %s lladdr %s&quot;</span><br><span> #el=
if defined(TARGET_NETBSD)</span><br><span> #define IFCONFIG_LLADDR_FMT &quo=
t;%s %s link %s active&quot;</span><br><span>diff --git a/src/openvpn/tun=
=2Ec b/src/openvpn/tun=2Ec</span><br><span>index c56ace3=2E=2Efe1af45 10064=
4</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openv=
pn/tun=2Ec</span><br><span>@@ -979,7 +979,7 @@</span><br><span> #endif /* i=
fdef _WIN32 */</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) || defined(TARGET_DRA=
GONFLY)</span><br><span> </span><br><span> /* some of the platforms will au=
to-add a &quot;network route&quot; pointing</span><br><span>  * to the inte=
rface on &quot;ifconfig tunX 2001:db8::1/64&quot;, others need</span><br><s=
pan>@@ -1014,8 +1014,7 @@</span><br><span>     route_ipv6_clear_host_bits(&=
amp;r6);</span><br><span>     delete_route_ipv6(&amp;r6, tt, NULL, NULL);</=
span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_NETBSD=
) || \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          defin=
ed(TARGET_OPENBSD) */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif /* if defined(_WIN32) || defined(TARGET_DRAGONFLY) */</span><br><s=
pan> </span><br><span> #if defined(TARGET_NETBSD) || defined(TARGET_OPENBSD=
)</span><br><span> /* we can&#39;t use true subnet mode on tun on all platf=
orms, as that</span><br><span>@@ -1160,6 +1159,10 @@</span><br><span>     o=
penvpn_execve_check(&amp;argv, es, S_FATAL, &quot;FreeBSD BSD &#39;ifconfig=
 inet6 -ifdisabled&#39; failed&quot;);</span><br><span> #endif</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_=
DRAGONFLY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_ro=
ute_connected_v6_net(tt, es);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> #elif defined(TARGET_AIX)</span><br><span>     argv_printf(&=
amp;argv, &quot;%s %s inet6 %s/%d mtu %d up&quot;, IFCONFIG_PATH, ifname, i=
fconfig_ipv6_local,</span><br><span>                 tt-&gt;netbits_ipv6, t=
un_mtu);</span><br><span>@@ -1490,7 +1493,7 @@</span><br><span>     }</span=
><br><span> </span><br><span>     argv_msg(M_INFO, &amp;argv);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv=
, es, S_FATAL, &quot;FreeBSD ifconfig failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    openvpn_execve_check(&amp;argv, es, S=
_FATAL, &quot;FreeBSD/DragonFly ifconfig failed&quot;);</span><br><span> </=
span><br><span> #elif defined(TARGET_AIX)</span><br><span>     {</span><br>=
<span>@@ -1623,14 +1626,14 @@</span><br><span>             msg(M_WARN, &quo=
t;Linux can&#39;t del IP from iface %s&quot;, tt-&gt;actual_name);</span><b=
r><span>         }</span><br><span>     }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#elif defined(TARGET_FREEBSD) || defined(TARG=
ET_DRAGONFLY)</span><br><span>     struct gc_arena gc =3D gc_new();</span><=
br><span>     const char *ifconfig_local =3D print_in_addr_t(tt-&gt;local, =
0, &amp;gc);</span><br><span>     struct argv argv =3D argv_new();</span><b=
r><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s %s %s -alias=
&quot;, IFCONFIG_PATH, tt-&gt;actual_name, ifconfig_local);</span><br><span=
>     argv_msg(M_INFO, &amp;argv);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    openvpn_execve_check(&amp;argv, NULL, 0, &quot;FreeBSD ip =
addr del failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    openvpn_execve_check(&amp;argv, NULL, 0, &quot;FreeBSD/DragonFly ip=
 addr del failed&quot;);</span><br><span> </span><br><span>     argv_free(&=
amp;argv);</span><br><span>     gc_free(&amp;gc);</span><br><span>@@ -1646,=
7 +1649,12 @@</span><br><span>     {</span><br><span>         msg(M_WARN, &=
quot;Linux can&#39;t del IPv6 from iface %s&quot;, tt-&gt;actual_name);</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
lif defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifdef TARGET_DRAGONFLY</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    delete_route_connected_v6_net(tt);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct gc_are=
na gc =3D gc_new();</span><br><span>     const char *ifconfig_ipv6_local =
=3D print_in6_addr(tt-&gt;local_ipv6, 0, &amp;gc);</span><br><span>     str=
uct argv argv =3D argv_new();</span><br><span>@@ -1655,7 +1663,7 @@</span><=
br><span>                 ifconfig_ipv6_local, tt-&gt;netbits_ipv6);</span>=
<br><span> </span><br><span>     argv_msg(M_INFO, &amp;argv);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv,=
 NULL, 0, &quot;FreeBSD ip -6 addr del failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    openvpn_execve_check(&amp;argv, NULL,=
 0, &quot;FreeBSD/DragonFly ip -6 addr del failed&quot;);</span><br><span> =
</span><br><span>     argv_free(&amp;argv);</span><br><span>     gc_free(&a=
mp;gc);</span><br><span>@@ -2888,20 +2896,70 @@</span><br><span> </span><br=
><span> #elif defined(TARGET_DRAGONFLY)</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* DragonFly tun/tap devices are simi=
lar to NetBSD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - =
for a dynamic tun/tap, open /dev/tun or /dev/tap, get assigned</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *    the first free device, ask=
 with (f)devname(3) what you got, and</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *    the interface will auto-destruct on close</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  - for a pre-created tun/t=
ap, open &quot;/dev/tun3&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  - using &quot;--dev tun3&quot; and have it dynamically creat=
ed needs a call</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
  to &quot;ifconfig tun3 create&quot; which we don&#39;t currently do</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> o=
pen_tun(const char *dev, const char *dev_type, const char *dev_node, struct=
 tuntap *tt,</span><br><span>          openvpn_net_ctx_t *ctx)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    open_tun_ge=
neric(dev, dev_type, dev_node, tt);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(tt-&gt;fd &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!dev_node &amp;&amp; (strcmp(dev, &quot;tap&quot;) =3D=3D 0 || st=
rcmp(dev, &quot;tun&quot;) =3D=3D 0))</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        int i =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        char tunname[256];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tunname, si=
zeof(tunname), &quot;/dev/%s&quot;, dev);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /* Disable extended modes */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((tt-&gt;=
fd =3D open(tunname, O_RDWR)) &lt; 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(M_ERR, &quot;Cannot allocate DragonFly TUN/TAP %s d=
ynamically&quot;, tunname);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *devname=
 =3D fdevname(tt-&gt;fd);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (devname =3D=3D NULL)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msg(M_ERR, &quot;Cannot query DragonFly TUN/TAP device=
 name&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        set_nonb=
lock(tt-&gt;fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     set_cloexec(tt-&gt;fd); /* don&#39;t pass fd to scripts */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;TUN/T=
AP device %s opened&quot;, devname);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      tt-&gt;actual_name =3D string_alloc(devname, NULL);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       open_tun_generic(dev, dev_type, dev_node, tt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (tt-&gt;fd &gt;=3D 0 &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* see &quot;Interface Flags=
&quot; in ifnet(9) */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        int i =3D IFF_POINTOPOINT | IFF_MULTICAST;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (tt-&gt;topology =3D=3D TOP_SU=
BNET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            i =3D IFF_BR=
OADCAST | IFF_MULTICAST;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ioctl(tt-&gt=
;fd, TUNSIFMODE, &amp;i) &lt; 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(M_WARN | M_ERRNO, &quot;ioctl(TUNSIFMODE)&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* Disable &quot;link layer&quot; mode (would p=
repend route-nexthop address</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * on read, but is incompatible with TUNSIFHEAD multi-af m=
ode) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i =
=3D 0;</span><br><span>         ioctl(tt-&gt;fd, TUNSLMODE, &amp;i);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* multi_af mode for v4+v6, see &quot=
;tun(4)&quot; */</span><br><span>         i =3D 1;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        ioctl(tt-&gt;fd, TUNSIFHEAD, &amp;i);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ioctl(tt=
-&gt;fd, TUNSIFHEAD, &amp;i) &lt; 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(M_WARN | M_ERRNO, &quot;ioctl(TUNSIFHEAD)&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan>     }</span><br><span> }</span><br><span> </span><br><span>diff --git =
a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><span>index=
 5e924bb=2E=2Ed81cef0 100755</span><br><span>--- a/tests/t_client=2Esh=2Ein=
</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -212,8 +=
212,8 @@</span><br><span>                 LANG=3DC @NETSTAT@ -rn -4 -6</spa=
n><br><span>             fi</span><br><span>             ;;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        FreeBSD | NetBSD | Darwin)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            echo &quot;-=
- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        FreeBSD | DragonFly | NetBSD | Darwin)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;--=
 FreeBSD/DragonFly/NetBSD/Darwin [MacOS X] --&quot;</span><br><span>       =
      @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span>   =
          @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#39;=
</span><br><span>             ;;</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail">change 217=
0</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5a=
b959e7101cf801ac93e5185855e75db0fb6225 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 2170 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--UG1d1fD1Ja4=--


--===============0452911622882777911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0452911622882777911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0452911622882777911==--

