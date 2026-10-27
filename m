Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB18606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gqbHWHgn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=h/e6Jfgg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZyDnrep0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JoQZr/Vc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=yRzhNWowj4pCUdraPDeoq6RmQF7ml3XLWtwzaJEox4w=; b=gqbHWHgnbIVoafRbcABhmKgIqy
	t28FPWVmqVKksMRLOECgj780fHciA601DDm85jy6X8iml/bCnrtjUPb5hzdpbgxojHZioYutM94NX
	DNMx71eMtuyRrUVDptDySoSuBOwl3UwbWcGqCy3cN/mQ4Asa8uejJIybqaBDlr3oGlGY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLeD7-000000007EF-0qMs;
	Tue, 27 Oct 2026 10:15:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLeD4-000000007Ct-2Saz
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:15:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=529jRAIkRmKaCule+jJjGuz8Krab/CaUdGzcPwX2cww=; b=h/e6JfgggEaejfDB0+tolHJnL2
 qZib6votlPnOcxqHx0jjvArBW4xg+aFn1I8IdMNLFUM/ox/XHrMNrosMrnW7q+QjALJNlpWRzd+SF
 Kb/M/rPEOcxUCtu9CzFN7ezeAxIU74MAdyc5FLFcN6JWq3X/x1/0E9ESLml60Mi1KXkI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=529jRAIkRmKaCule+jJjGuz8Krab/CaUdGzcPwX2cww=; b=ZyDnrep0lQVSyuJohbCFMwuzmU
 mM1CPxmYKXJT9XAfTHvBz1Kpfjh6rEoaRguODPG35lZrqiIL9hQoHwZUg+qoUONzswpXK9fQnuiYo
 gy0e/c/KAqJxHW6WPHkziUmjpZD7WVn0tZF4UbR3nWKBOftCyZpLEek05nI2rhfQ8UHU=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLeCY-000000002id-0EFi for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:14:46 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a2d6cf958bso15626565e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793096075; x=1793700875; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=529jRAIkRmKaCule+jJjGuz8Krab/CaUdGzcPwX2cww=;
 b=JoQZr/Vcjf8lknY3A14efpUA7TGSsXTkNwoHCk2z4y8/wQTGRWAf+Ssmmy5Ap4PDQg
 SrwPcnE8O5uRyiNUSsdwdzpDNJt6NxWP9Ou7JMoXRrPf5gjDQcTf3b7hLrUXf8q2WGeu
 Lki32aV1AL14R8t5m67BsD8YoAhKMqPvJKxtwDGSXE+Er8FgB2AyESYdqZM5W5vEeKp+
 tOSr4ZllIhqvdf4MHaoSnGHQOAUa0tYlMeUZQpJfl9C/8IhhqnSt23WbBC5CyKjAAGAx
 cxU37zDd+ehpkpapc+NOuOH6MsAUwtfd3HXCeInzfmGSraTFjySz+VqYxuF3xSSwxlNB
 wYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793096075; x=1793700875;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=529jRAIkRmKaCule+jJjGuz8Krab/CaUdGzcPwX2cww=;
 b=zZID2kNxPUA1vf7Ndf8puYa0SDTf4RHVPeZS0EdT8P8kA2YX4LKWs6efgrXcsKXuZ6
 jc2XeNHIT5ui2LJCiRjxcNcJ7GohFMvofL6AMMDCu+0krq6A20/zL8JDcRJO7tYLqf6n
 8bKBRH0Bj9V9yTgLYsD6Clu/wZvnM8pwi0yG51DKc9lgIhAxqhtICrzXn0BoJPT7rsUH
 WVEOopbGgNy6rlvt6qT+Vl7yjaBcQqfqzmtBk6YCp6ibh4pJDWujqCtIHaQZgspz3aJX
 4A8ATi665zMPLhAhEK+/IommFem30EoLEh6F7atqtrn+55KnNqL3Lpvi10m+P9I5f+Gh
 q/HA==
X-Gm-Message-State: AFq9FYL/Hl1A+efFV+OhQoqBf0hQoqTVYdh/dyC79vTyw8ro5Z8yA7y3
 GkvCr+5Q8W8tEiHKx8K41IcTsTl3/tdFqWfqsEUwxVmJqmSAhuLLO8qI8Jfva7ZeIrON78lnGpw
 fdqHmWwnOHAUfvK+vPgTHV8cKtW91IFGTEsAf2kskmt7h3SAxgNAEh4Bd3hmU4niczlda
X-Gm-Gg: AYBFou0NTY4m7mzzPzp+aYuC9fyPxbs5Q8h4JSvQJ8zJ1kTCZ5UZ9RvUHauylXkVgTg
 d0xqVvRK97p5Co1glwEjtZQen6EGjHSxcg+PA4wmCcW9dNn8tkcEIhxvWuIjlCo+ukTLjDVbcgW
 7lULQRe8nOk61bl8V/eb9XNRX/7uYou1bM5DjNVwOhomZrRt781VjFNbHKr48YC1IZdiFh0wEf1
 LPeH7e7rAxtrsOc+hwg3668dZ7cqlp0nsZk7NU4UMD/AghYLekuuyGlkk5dyVEaSJbwGJrX8BSU
 mYrkBzMzv5hAzf+8AlixAfOb0N8oZn9AX60UsLZSX7OM6wBekO12XIzJD79JHzDTH9U3tF/QEc4
 lU/7C1FgUTBzST9SWmZui0AkmsVqIHWljZhtns/X/njKVk7xTUzFMz8EL3UXcHOwVJqP4ONg6ZX
 uM+svup1pJTR1xRuKoN4pcHZZa0UrjR7a8vZiw2QQBhAGWuz123merOaId+CPmgxBD9vyB3lhrq
 aS3HjkvjPfGQwd4bA1+ycUr6PrunZEUuRS2LsZGTXCjGz9cX+eB/tSzlZY+AP9YTLEMiPnotUG1
 iPl4EGyKd1rhaG3mVBQlWmMnaCmc0FYEOMVgdu8U0n+win+m0lMlhc07ieRffI5DxBWaWOC+6d8
 0sT5s8jMzDYeKgKdHd2J3xOYfqwWPKQfDHjfZ8XwIIyT5PkAO/Ya9S75+eLO0M80=
X-Received: by 2002:a05:600c:5397:b0:4a2:a9:ed56 with SMTP id
 5b1f17b1804b1-4a35ac99b8fmr178194425e9.8.1793096074146; 
 Tue, 27 Oct 2026 03:14:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a59d238sm244512385e9.14.2026.10.27.03.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 03:14:33 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 10:14:33 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2fd7d973be9a1eb90ea201b2278be73e6ee6f27d
X-Gerrit-Change-Number: 2052
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2052?usp=email>
X-Gerrit-Commit: 7c3b3c27e2814443ff37e0e87102a0f148ec71ee
References: <gerrit.1793096063000.I2fd7d973be9a1eb90ea201b2278be73e6ee6f27d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk2MDYzMDAwLkkyZmQ3ZDk3M2JlOWExZWI5MGVhMjAxYjIyNzhiZTczZTZlZTZmMjdkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d0a922c514bcfa32cabb5eab2ef3d808efdda3c8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLeCY-000000002id-0EFi
Subject: [Openvpn-devel] [L] Change in openvpn[master]: transport: introduce
 transport API plugin codebase
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
Content-Type: multipart/mixed; boundary="===============5960649844809547741=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5960649844809547741==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oQXhEGZeAlU="; charset=UTF-8

--oQXhEGZeAlU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2052?usp=3Demail

to review the following change=2E
=


Change subject: transport: introduce transport API plugin codebase
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

transport: introduc=
e transport API plugin codebase

This API will allow plugins to provide vir=
tual socket implementations
with their own table of functions for operation=
s on these sockets,
with limited but functional integration with the main O=
penVPN event
loop=2E

This new mechanism can be used to implement alternati=
ve transport
protocols via external plugins, without interfering with the O=
penVPN
core codebase=2E

A sample user of this API might be an obsufcation =
schema which
manipulates the traffic before sending/receiving it=2E

Change=
-Id: I2fd7d973be9a1eb90ea201b2278be73e6ee6f27d
Signed-off-by: Robin Tarsige=
r <rtt@dasyatidae=2Ecom>
[antonio@openvpn=2Enet: refactored commits, restyl=
ed code]
[gianmarco@mandelbit=2Ecom: rebased, adapted to multisocket]
---
M=
 CMakeLists=2Etxt
M include/Makefile=2Eam
M include/openvpn-plugin=2Eh=2Ein=

A include/openvpn-transport=2Eh
M src/openvpn/Makefile=2Eam
M src/openvpn/=
plugin=2Ec
M src/openvpn/plugin=2Eh
M src/openvpn/socket_util=2Eh
A src/ope=
nvpn/transport=2Ec
A src/openvpn/transport=2Eh
10 files changed, 709 insert=
ions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/52/2052/1

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Et=
xt
index 184a95a=2E=2E417d9a1 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeList=
s=2Etxt
@@ -620,6 +620,8 @@
     src/openvpn/status=2Eh
     src/openvpn/sy=
shead=2Eh
     src/openvpn/tls_crypt=2Ec
+    src/openvpn/transport=2Ec
+  =
  src/openvpn/transport=2Eh
     src/openvpn/tun=2Ec
     src/openvpn/tun=
=2Eh
     src/openvpn/tun_afunix=2Ec
diff --git a/include/Makefile=2Eam b/i=
nclude/Makefile=2Eam
index af02d88=2E=2Ece367a5 100644
--- a/include/Makefi=
le=2Eam
+++ b/include/Makefile=2Eam
@@ -15,4 +15,5 @@
 
 include_HEADERS =
=3D \
 	openvpn-plugin=2Eh \
+	openvpn-transport=2Eh \
 	openvpn-msg=2Eh
di=
ff --git a/include/openvpn-plugin=2Eh=2Ein b/include/openvpn-plugin=2Eh=2Ei=
n
index dde5dea=2E=2E436662e 100644
--- a/include/openvpn-plugin=2Eh=2Ein
+=
++ b/include/openvpn-plugin=2Eh=2Ein
@@ -132,7 +132,8 @@
 #define OPENVPN_P=
LUGIN_CLIENT_CONNECT_DEFER     13
 #define OPENVPN_PLUGIN_CLIENT_CONNECT_DE=
FER_V2  14
 #define OPENVPN_PLUGIN_CLIENT_CRRESPONSE        15
-#define OPE=
NVPN_PLUGIN_N                        16
+#define OPENVPN_PLUGIN_TRANSPORT  =
              16
+#define OPENVPN_PLUGIN_N                        17
 
 /*
=
  * Build a mask out of a set of plug-in types=2E
@@ -791,6 +792,34 @@
    =
 (void);
 
 /*
+ * FUNCTION: openvpn_plugin_get_vtab_v1
+ *
+ * This is onl=
y used for TRANSPORT plugins presently=2E  It is called to
+ * retrieve a v=
table structure to be used for binding virtual sockets
+ * which use the tr=
ansport provided by the plugin=2E The selector is an
+ * OPENVPN_VTAB const=
ant=2E *size_out must be set to the size of the
+ * structure returned=2E
+=
 *
+ * REQUIRED: only for TRANSPORT plugins
+ *
+ * RETURN VALUE
+ *
+ * A =
pointer to a vtable of the requested type, or NULL if no
+ * such vtable is=
 provided by this plugin=2E
+ */
+
+enum {
+    /* Return type: struct open=
vpn_transport_bind_vtab1 *
+     * Plugin should provide OPENVPN_PLUGIN_TRA=
NSPORT at open time=2E
+     */
+    OPENVPN_VTAB_TRANSPORT_BIND_V1 =3D 0x5=
4726e31 /* 'Trn1' */
+};
+
+
+OPENVPN_PLUGIN_DEF void *OPENVPN_PLUGIN_FUNC(=
openvpn_plugin_get_vtab_v1)
+    (int selector, size_t *size_out);
+
+/*
  =
* Deprecated functions which are still supported for backward compatibility=
=2E
  */
 
diff --git a/include/openvpn-transport=2Eh b/include/openvpn-tra=
nsport=2Eh
new file mode 100644
index 0000000=2E=2E7f29696
--- /dev/null
++=
+ b/include/openvpn-transport=2Eh
@@ -0,0 +1,258 @@
+/*
+ *  Transport API =
handling code
+ *
+ *  Copyright (C) 2018 Robin Tarsiger <rtt@dasyatidae=2E=
com>
+ *
+ *  This program is free software; you can redistribute it and/or=
 modify
+ *  it under the terms of the GNU General Public License version 2=

+ *  as published by the Free Software Foundation=2E
+ *
+ *  This program=
 is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WA=
RRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNES=
S FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for =
more details=2E
+ *
+ *  You should have received a copy of the GNU General=
 Public License
+ *  along with this program (see the file COPYING included=
 with this
+ *  distribution); if not, write to the Free Software Foundatio=
n, Inc=2E,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *=
/
+
+
+#ifndef OPENVPN_TRANSPORT_H_
+#define OPENVPN_TRANSPORT_H_
+
+/* PLA=
TFORM: only POSIX-y platforms or Win32 here */
+
+#ifdef _WIN32
+
+/* Win32=
 */
+#define OPENVPN_TRANSPORT_PLATFORM_WIN32
+#include <stdbool=2Eh>
+#inc=
lude <winsock2=2Eh>
+#include <windows=2Eh>
+
+/* On Windows, platform-nati=
ve events to wait on are provided to OpenVPN core as
+ * pairs of system ev=
ents, normally corresponding to one potentially queued I/O
+ * operation in=
 each direction=2E The read event is waited on if read events are
+ * reque=
sted, and the write event is waited on if write events are
+ * requested=2E=
 Events need not be distinct, but usually will be=2E Two event
+ * handles =
must always be provided; neither is permitted to be NULL=2E */
+typedef con=
st struct openvpn_transport_win32_event_pair
+{
+    HANDLE read;
+    HAND=
LE write;
+} *openvpn_transport_native_event_t;
+
+/* Windows doesn't have =
socklen_t; it uses int=2E */
+typedef int openvpn_transport_socklen_t;
+
+#=
ifdef _MSC_VER
+#include <basetsd=2Eh>
+typedef SSIZE_T openvpn_transport_s=
size_t;
+#else
+typedef ssize_t openvpn_transport_ssize_t;
+#endif
+
+#else=
 /* ifdef _WIN32 */
+
+/* POSIX-y */
+#define OPENVPN_TRANSPORT_PLATFORM_PO=
SIX
+#include <stdbool=2Eh>
+#include <unistd=2Eh>
+#include <stdlib=2Eh>
+=
#include <sys/socket=2Eh>
+
+/* On POSIX-y platforms, platform-native event=
s to wait on are provided to
+ * OpenVPN core as file descriptors=2E  Readi=
ness for read and write are defined
+ * the same way as in poll, epoll, and=
 similar system APIs=2E The file descriptor
+ * may be of any type which ca=
n be waited on=2E */
+typedef int openvpn_transport_native_event_t;
+
+/* A=
lias natural socklen_t definition=2E */
+typedef socklen_t openvpn_transpor=
t_socklen_t;
+
+typedef ssize_t openvpn_transport_ssize_t;
+
+#endif /* ifd=
ef _WIN32 */
+
+/* rwflags values are a bitwise OR of zero or more of these=
 values, indicating
+ * what types of events are being requested or returne=
d for a given object=2E */
+#define OPENVPN_TRANSPORT_EVENT_READ  (1 << 0)
=
+#define OPENVPN_TRANSPORT_EVENT_WRITE (1 << 1)
+
+/* Handle to an object t=
hat can accumulate requests to wait on platform-native
+ * event sources=2E=
 Use the functions in the vtable to operate on it=2E */
+typedef struct ope=
nvpn_transport_event_set_handle *openvpn_transport_event_set_handle_t;
+
+s=
truct openvpn_transport_event_set_vtab
+{
+    /* Request to be notified wh=
en ev becomes ready in any of the ways specified
+     * by the bitmask rwf=
lags=2E Incoming notifications will have arg passed
+     * through as-is=
=2E See above for the definition of native events on different
+     * plat=
forms=2E
+     *
+     * Note that arg must be a distinct, owned pointer an=
d not NULL; see
+     * update_event below=2E */
+    void (*set_event)(ope=
nvpn_transport_event_set_handle_t handle,
+                      openvpn_tr=
ansport_native_event_t ev, unsigned rwflags,
+                      void *a=
rg);
+};
+
+/* Implementation extends this structure with state=2E Implemen=
tation is normally
+ * provided by OpenVPN core; see request_event in struc=
t
+ * openvpn_transport_vtab=2E */
+struct openvpn_transport_event_set_hand=
le
+{
+    const struct openvpn_transport_event_set_vtab *vtab;
+};
+
+/* H=
andle to a virtual datagram socket, non-connection-oriented=2E */
+typedef =
struct openvpn_transport_socket *openvpn_transport_socket_t;
+
+/* Implemen=
tation extends this structure with state=2E Implementation is normally
+ * =
provided by a plugin providing an indirect socket mechanism=2E */
+struct o=
penvpn_transport_socket
+{
+    const struct openvpn_transport_socket_vtab1=
 *vtab;
+};
+
+/* Handle to opaque per-connection parameters=2E */
+typedef=
 void *openvpn_transport_args_t;
+
+/* Virtual socket implementations shoul=
d expect (and consumers must
+ * provide) vtable calls in the following ord=
er:
+ *
+ *   - bind must occur first, to create the virtual socket=2E
+ * =
  - request_event is followed by zero or more update_event calls, and then =
a
+ *     pump call, before any further request_event calls occur=2E
+ *   =
- recvfrom/sendto may occur at any time between bind and close, including
+=
 *     interleaved with the event request cycle above=2E
+ *   - close must=
 occur last=2E
+ *
+ * Error reporting is platform-native: errno on POSIX-y=
 systems, or
+ * Winsock errors on Windows systems=2E
+ */
+
+struct openvp=
n_transport_bind_vtab1
+{
+    /* Producer should set to 0, consumer should=
 ignore=2E May indicate
+     * extended functions in the future=2E */
+   =
 unsigned features;
+
+    /* Parse connection-specific arguments as provid=
ed by a
+     * "transport-plugin" configuration line=2E argv[0] is normall=
y the
+     * plugin shared object pathname=2E argc is the total number of
=
+     * valid strings in argv; argv[argc] is also NULL=2E plugin_handle
+  =
   * is an openvpn_plugin_handle_t=2E  Memory for argv and its strings
+   =
  * is borrowed and may not be retained by the plugin=2E Any syntax
+     *=
 checking of text arguments should be done in this function=2E
+     *
+   =
  * The value returned points to either opaque, valid parameters,
+     * o=
r an error value=2E The distinction between the two is defined
+     * by t=
he plugin, and can only be evaluated via the argerror
+     * function belo=
w=2E
+     *
+     * This function pointer is allowed to be NULL=2E In this=
 case,
+     * argerror and freeargs must also be NULL, a nonempty
+     * =
connection-specific argument list will be rejected with an
+     * error, a=
nd the value of args in the subsequent bind call will
+     * always be NUL=
L=2E
+     */
+    openvpn_transport_args_t (*parseargs)(void *plugin_handl=
e,
+                                          const char *const *argv,
+   =
                                       int argc);
+
+    /* If args is an e=
rror value, as defined by this plugin, then
+     * return a string describ=
ing the error=2E The string must remain
+     * valid until the next call t=
o argerror or freeargs on the same
+     * value of args=2E If args is not =
an error value, return NULL=2E
+     * This function pointer must be NULL i=
f and only if parseargs is
+     * NULL=2E */
+    const char *(*argerror)(=
openvpn_transport_args_t args);
+
+    /* Destroy any resources associated =
with args, which may be any
+     * return value of parseargs: either parse=
d parameters or an error
+     * value=2E This function pointer must be NUL=
L if and only if
+     * parseargs is NULL=2E */
+    void (*freeargs)(open=
vpn_transport_args_t args);
+
+    /* Bind a new virtual socket to addr/len=
, given a plugin handle
+     * and any connection-specific parameters=2E a=
ddr must not be NULL=2E
+     * plugin_handle is actually of type openvpn_p=
lugin_handle_t=2E
+     * args is any value returned by parseargs for which=
 argerror
+     * would return NULL; however, it is still borrowed, and the=

+     * caller may call freeargs after bind while the socket is still
+   =
  * in use=2E */
+    openvpn_transport_socket_t (*bind)(void *plugin_handl=
e,
+                                       openvpn_transport_args_t args,
+=
                                       const struct sockaddr *addr,
+      =
                                 openvpn_transport_socklen_t len);
+};
+
+s=
truct openvpn_transport_socket_vtab1
+{
+    /* Producer should set to 0, c=
onsumer should ignore=2E May indicate
+     * extended functions in the fut=
ure=2E */
+    unsigned features;
+
+    /* Given a virtual indirect socket=
 returns the descriptor associated */
+    int (*get_sd)(openvpn_transport_=
socket_t handle);
+
+    /* Given the bitmask rwflags, request that event_s=
et be provided with all
+     * native events that should be waited on such=
 that whenever this virtual
+     * socket may become ready in a way specif=
ied by rwflags, one of the
+     * native events will become ready=2E This =
function should call
+     *
+     *   event_set->vtab->set_event(event_set=
, =2E=2E=2E)
+     *
+     * zero or more times for this purpose=2E
+     *=

+     * The state of event_set should be assumed not to persist between ca=
lls to
+     * request_event; every native event must be provided every tim=
e=2E Currently,
+     * only one native event may be supplied (i=2Ee=2E, on=
e call above)=2E */
+    void (*request_event)(openvpn_transport_socket_t h=
andle,
+                          openvpn_transport_event_set_handle_t even=
t_set,
+                          unsigned rwflags);
+
+    /* Indicate to =
the virtual socket that a native event for which arg was
+     * provided t=
o a set_event call above became ready in a manner indicated by
+     * the =
bitmask rwflags=2E  This function _must_ test for whether arg
+     * corre=
sponds to an actual requested event from this virtual socket=2E
+     *
+  =
   * If arg corresponds to a requested event, update_event does any necessa=
ry
+     * internal state updates and _returns true_ to consume the event=
=2E
+     *
+     * If arg does not correspond to a requested event, update=
_event
+     * does nothing and _returns false_=2E */
+    bool (*update_ev=
ent)(openvpn_transport_socket_t handle, void *arg,
+                       =
  unsigned rwflags);
+
+    /* Perform any pending processing that can be p=
erformed
+     * immediately, and return a bitmask of rwflags indicating wh=
ether
+     * this virtual socket is ready to receive/send more packets=2E =
*/
+    unsigned (*pump)(openvpn_transport_socket_t handle);
+
+    /* Rece=
ive a packet into buf/len, storing the address into addr/(*addrlen)
+     *=
 and updating *addrlen to match=2E Returns -1 on error, or the number of
+ =
    * bytes received=2E Must not block; signals an error if there is nothin=
g to
+     * receive=2E */
+    openvpn_transport_ssize_t (*recvfrom)(openv=
pn_transport_socket_t handle,
+                                          vo=
id *buf, size_t len,
+                                          struct sock=
addr *addr,
+                                          openvpn_transport_so=
cklen_t *addrlen);
+
+    /* Send a packet from buf/len to the address addr=
/addrlen=2E Returns -1 on
+     * error, or the number of bytes sent=2E Mus=
t not block; signals an error if
+     * there is no room to send=2E */
+  =
  openvpn_transport_ssize_t (*sendto)(openvpn_transport_socket_t handle,
+ =
                                       const void *buf, size_t len,
+      =
                                  const struct sockaddr *addr,
+           =
                             openvpn_transport_socklen_t addrlen);
+
+    /=
* Destroy this virtual socket and free all resources allocated for it=2E Th=
e
+     * virtual socket must not be used afterward=2E */
+    void (*close=
)(openvpn_transport_socket_t handle);
+};
+
+#endif /* ifndef OPENVPN_TRANS=
PORT_H_ */
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2E=
am
index 8a60a94=2E=2Ea6e9ca0 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/=
src/openvpn/Makefile=2Eam
@@ -154,6 +154,7 @@
 	status=2Ec status=2Eh \
 	s=
yshead=2Eh \
 	tls_crypt=2Ec tls_crypt=2Eh \
+	transport=2Ec transport=2Eh =
\
 	tun=2Ec tun=2Eh \
 	tun_afunix=2Ec tun_afunix=2Eh \
 	vlan=2Ec vlan=2Eh=
 \
diff --git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec
index a94f0=
7b=2E=2E4ebbebb 100644
--- a/src/openvpn/plugin=2Ec
+++ b/src/openvpn/plugi=
n=2Ec
@@ -122,6 +122,9 @@
         case OPENVPN_PLUGIN_CLIENT_CRRESPONSE:
 =
            return "PLUGIN_CRRESPONSE";
 
+        case OPENVPN_PLUGIN_TRAN=
SPORT:
+            return "PLUGIN_TRANSPORT";
+
         default:
        =
     return "PLUGIN_???";
     }
@@ -320,6 +323,7 @@
     PLUGIN_SYM(client=
_destructor, "openvpn_plugin_client_destructor_v1", 0);
     PLUGIN_SYM(min=
_version_required, "openvpn_plugin_min_version_required_v1", 0);
     PLUGI=
N_SYM(initialization_point, "openvpn_plugin_select_initialization_point_v1"=
, 0);
+    PLUGIN_SYM(get_vtab, "openvpn_plugin_get_vtab_v1", 0);
 
     if=
 (!p->open1 && !p->open2 && !p->open3)
     {
diff --git a/src/openvpn/plug=
in=2Eh b/src/openvpn/plugin=2Eh
index 684632c=2E=2E6776434 100644
--- a/src=
/openvpn/plugin=2Eh
+++ b/src/openvpn/plugin=2Eh
@@ -78,6 +78,7 @@
     ope=
nvpn_plugin_client_destructor_v1 client_destructor;
     openvpn_plugin_min=
_version_required_v1 min_version_required;
     openvpn_plugin_select_initi=
alization_point_v1 initialization_point;
+    openvpn_plugin_get_vtab_v1 ge=
t_vtab;
 
     openvpn_plugin_handle_t plugin_handle;
 };
diff --git a/src/=
openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh
index a1a61af=2E=2E40=
f9334 100644
--- a/src/openvpn/socket_util=2Eh
+++ b/src/openvpn/socket_uti=
l=2Eh
@@ -140,6 +140,9 @@
     PROTO_TCP,
     PROTO_TCP_SERVER,
     PROTO=
_TCP_CLIENT,
+#ifdef ENABLE_PLUGIN
+    PROTO_INDIRECT,
+#endif
     PROTO_=
N
 };
 
diff --git a/src/openvpn/transport=2Ec b/src/openvpn/transport=2Ec
=
new file mode 100644
index 0000000=2E=2E8467916
--- /dev/null
+++ b/src/ope=
nvpn/transport=2Ec
@@ -0,0 +1,309 @@
+/*
+ *  Transport API handling code
+=
 *
+ *  Copyright (C) 2018 Robin Tarsiger <rtt@dasyatidae=2Ecom>
+ *
+ *  T=
his program is free software; you can redistribute it and/or modify
+ *  it=
 under the terms of the GNU General Public License version 2
+ *  as publis=
hed by the Free Software Foundation=2E
+ *
+ *  This program is distributed=
 in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without=
 even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICU=
LAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E=

+ *
+ *  You should have received a copy of the GNU General Public License=

+ *  along with this program (see the file COPYING included with this
+ * =
 distribution); if not, write to the Free Software Foundation, Inc=2E,
+ * =
 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+#ifdef H=
AVE_CONFIG_H
+#include "config=2Eh"
+#elif defined(_MSC_VER)
+#include "con=
fig-msvc=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#ifdef ENABLE_PLUGIN
+
+=
#include "error=2Eh"
+#include "event=2Eh"
+#include "plugin=2Eh"
+#include=
 "socket=2Eh"
+#include "transport=2Eh"
+#include "openvpn-transport=2Eh"
+=

+bool
+transport_prepare(const struct plugin_list *plugins,
+             =
     const char **transport_plugin_argv,
+                  struct openvpn_=
transport_bind_vtab1 **vtabp,
+                  openvpn_plugin_handle_t *h=
andlep,
+                  openvpn_transport_args_t *argsp)
+{
+    const c=
har *expected_so_pathname =3D transport_plugin_argv[0];
+    int argc =3D 0=
;
+
+    while (transport_plugin_argv[argc])
+    {
+        argc++;
+    }=

+
+    for (int i =3D 0; i < plugins->common->n; i++)
+    {
+        stru=
ct plugin *p =3D &plugins->common->plugins[i];
+        if (p->so_pathname =
&& !strcmp(p->so_pathname, expected_so_pathname))
+        {
+            /=
* Pathname matches; this is the plugin requested=2E */
+            if (!(p=
->plugin_type_mask
+                  & OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_=
TRANSPORT)))
+            {
+                msg(M_FATAL,
+                =
    "INDIRECT: plugin %s does not indicate TRANSPORT functionality",
+     =
               p->so_pathname);
+            }
+
+            size_t size =
=3D 0;
+            struct openvpn_transport_bind_vtab1 *vtab =3D NULL;
+  =
          if (p->get_vtab)
+            {
+                vtab =3D p->get_=
vtab(OPENVPN_VTAB_TRANSPORT_BIND_V1, &size);
+            }
+
+            =
if (!vtab)
+            {
+                msg(M_FATAL,
+                  =
  "INDIRECT: plugin %s has no TRANSPORT_BIND_V1 table",
+                  =
  p->so_pathname);
+            }
+
+            /* Sanity checks on the vt=
able=2E */
+            if (!(size =3D=3D sizeof(*vtab) && vtab->bind
+    =
              && ((vtab->parseargs && vtab->argerror && vtab->freeargs)
+  =
                    || (!vtab->parseargs && !vtab->argerror
+              =
            && !vtab->freeargs))))
+            {
+                msg(M_FA=
TAL,
+                    "INDIRECT: plugin %s returned a faulty TRANSPORT_=
BIND_V1 table",
+                    p->so_pathname);
+            }
+
+   =
         openvpn_transport_args_t args =3D NULL;
+            if (vtab->par=
seargs)
+            {
+                args =3D vtab->parseargs(p->plugin_=
handle, transport_plugin_argv,
+                                       argc=
);
+
+                const char *argerror =3D vtab->argerror(args);
+     =
           if (argerror)
+                {
+                    msg(M_FATA=
L,
+                        "INDIRECT: invalid arguments to transport-plugi=
n %s: %s",
+                        p->so_pathname, argerror);
+           =
     }
+            }
+
+            *vtabp =3D vtab;
+            *handlep=
 =3D p->plugin_handle;
+            *argsp =3D args;
+
+            return =
true;
+        }
+    }
+
+    return false;
+}
+
+openvpn_transport_socket=
_t
+transport_bind(const struct plugin_list *plugins,
+               const=
 char **transport_plugin_argv, sa_family_t ai_family,
+               struc=
t addrinfo *bind_addresses)
+{
+    openvpn_plugin_handle_t handle;
+    op=
envpn_transport_args_t args;
+    openvpn_transport_socket_t indirect;
+   =
 struct openvpn_transport_bind_vtab1 *vtab;
+    struct addrinfo *cur =3D N=
ULL;
+    struct openvpn_sockaddr zero;
+
+    if (!transport_prepare(plugi=
ns, transport_plugin_argv, &vtab, &handle,
+                           &arg=
s))
+    {
+        msg(M_FATAL, "INDIRECT: Socket bind failed: provider pl=
ugin not found");
+    }
+
+    /* Partially replicates the functionality o=
f socket_bind=2E No bind_ipv6_only
+     * or other such options, presently=
=2E
+     */
+    if (bind_addresses)
+    {
+        for (cur =3D bind_add=
resses; cur; cur =3D cur->ai_next)
+        {
+            if (cur->ai_fami=
ly =3D=3D ai_family)
+            {
+                break;
+            }
=
+        }
+
+        if (!cur)
+        {
+            msg(M_FATAL, "INDIR=
ECT: Socket bind failed: Addr to bind has no %s record",
+                a=
ddr_family_name(ai_family));
+        }
+    }
+
+    if (cur)
+    {
+    =
    indirect =3D vtab->bind(handle, args, cur->ai_addr, (openvpn_transport_=
socklen_t)cur->ai_addrlen);
+    }
+    else if (ai_family =3D=3D AF_UNSPEC=
)
+    {
+        msg(M_ERR, "INDIRECT: cannot bind with unspecified addres=
s family");
+    }
+    else
+    {
+        memset(&zero, 0, sizeof(zero))=
;
+        zero=2Eaddr=2Esa=2Esa_family =3D ai_family;
+        addr_zero_h=
ost(&zero);
+        indirect =3D vtab->bind(handle, args, &zero=2Eaddr=2Es=
a, (openvpn_transport_socklen_t)af_addr_size(ai_family));
+    }
+
+    if =
(!indirect)
+    {
+        msg(M_ERR, "INDIRECT: Socket bind failed");
+  =
  }
+
+    if (vtab->freeargs)
+    {
+        vtab->freeargs(args);
+    }=

+
+    return indirect;
+}
+
+struct encapsulated_event_set
+{
+    struct=
 openvpn_transport_event_set_handle handle;
+    struct event_set *real;
+}=
;
+
+#if EVENT_READ =3D=3D OPENVPN_TRANSPORT_EVENT_READ \
+    && EVENT_WRI=
TE =3D=3D OPENVPN_TRANSPORT_EVENT_WRITE
+#define TRANSPORT_EVENT_BITS_IDENT=
ICAL 1
+#else
+#define TRANSPORT_EVENT_BITS_IDENTICAL 0
+#endif
+
+static i=
nline unsigned
+translate_rwflags_in(unsigned vrwflags)
+{
+#if TRANSPORT_E=
VENT_BITS_IDENTICAL
+    return vrwflags;
+#else
+    unsigned rwflags =3D =
0;
+    if (vrwflags & OPENVPN_TRANSPORT_EVENT_READ)
+    {
+        rwflag=
s |=3D EVENT_READ;
+    }
+    if (vrwflags & OPENVPN_TRANSPORT_EVENT_WRITE=
)
+    {
+        rwflags |=3D EVENT_WRITE;
+    }
+    return rwflags;
+#e=
ndif
+}
+
+static inline unsigned
+translate_rwflags_out(unsigned rwflags)
=
+{
+#if TRANSPORT_EVENT_BITS_IDENTICAL
+    return rwflags;
+#else
+    uns=
igned vrwflags =3D 0;
+    if (rwflags & EVENT_READ)
+    {
+        vrwfla=
gs |=3D OPENVPN_TRANSPORT_EVENT_READ;
+    }
+    if (rwflags & EVENT_WRITE=
)
+    {
+        vrwflags |=3D OPENVPN_TRANSPORT_EVENT_WRITE;
+    }
+    =
return vrwflags;
+#endif
+}
+
+static void
+encapsulated_event_set_set_even=
t(openvpn_transport_event_set_handle_t handle,
+                           =
      openvpn_transport_native_event_t vev,
+                              =
   unsigned vrwflags, void *arg)
+{
+    unsigned rwflags =3D translate_rwf=
lags_in(vrwflags);
+    event_t ev;
+#ifdef _WIN32
+    struct rw_handle rw=
;
+    rw=2Eread =3D vev->read;
+    rw=2Ewrite =3D vev->write;
+    ev =3D=
 &rw;
+#else
+    ev =3D vev;
+#endif
+
+    struct event_set *es =3D ((str=
uct encapsulated_event_set *)handle)->real;
+    /* If rwflags =3D=3D 0, we=
 do nothing, because this is always one-shot mode=2E */
+    if (rwflags !=
=3D 0)
+    {
+        event_ctl(es, ev, rwflags, arg);
+    }
+}
+
+static=
 const struct openvpn_transport_event_set_vtab encapsulated_event_set_vtab =
=3D {
+    encapsulated_event_set_set_event
+};
+
+unsigned
+transport_upda=
te_event(openvpn_transport_socket_t indirect,
+                       struc=
t event_set_return *esr, int *esrlen)
+{
+    int i =3D 0;
+    while (i < =
*esrlen)
+    {
+        unsigned vrwflags =3D translate_rwflags_out(esr[i]=
=2Erwflags);
+        if (indirect->vtab->update_event(indirect, esr[i]=2Ea=
rg, vrwflags))
+        {
+            /* Consume the event; move the last =
one in place of it=2E */
+            if (i !=3D *esrlen - 1)
+            =
{
+                memcpy(&esr[i], &esr[*esrlen - 1], sizeof(*esr));
+     =
       }
+            (*esrlen)--;
+        }
+        else
+        {
+   =
         /* Don't consume the event; move to the next one=2E */
+          =
  i++;
+        }
+    }
+
+    return translate_rwflags_in(indirect->vtab-=
>pump(indirect));
+}
+
+int
+transport_get_sd(openvpn_transport_socket_t in=
direct)
+{
+    return indirect->vtab->get_sd(indirect);
+}
+
+void
+transp=
ort_request_events(openvpn_transport_socket_t indirect,
+                  =
       struct event_set *es, unsigned rwflags)
+{
+    unsigned vrwflags =
=3D translate_rwflags_out(rwflags);
+    struct encapsulated_event_set enca=
psulated_es;
+    encapsulated_es=2Ehandle=2Evtab =3D &encapsulated_event_s=
et_vtab;
+    encapsulated_es=2Ereal =3D es;
+    indirect->vtab->request_e=
vent(indirect, &encapsulated_es=2Ehandle, vrwflags);
+}
+
+#endif /* ENABLE=
_PLUGIN */
diff --git a/src/openvpn/transport=2Eh b/src/openvpn/transport=
=2Eh
new file mode 100644
index 0000000=2E=2E72778c5
--- /dev/null
+++ b/sr=
c/openvpn/transport=2Eh
@@ -0,0 +1,100 @@
+/*
+ *  Transport API handling c=
ode
+ *
+ *  Copyright (C) 2018 Robin Tarsiger <rtt@dasyatidae=2Ecom>
+ *
+=
 *  This program is free software; you can redistribute it and/or modify
+ =
*  it under the terms of the GNU General Public License version 2
+ *  as p=
ublished by the Free Software Foundation=2E
+ *
+ *  This program is distri=
buted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; wi=
thout even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PA=
RTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more detai=
ls=2E
+ *
+ *  You should have received a copy of the GNU General Public Li=
cense
+ *  along with this program (see the file COPYING included with this=

+ *  distribution); if not, write to the Free Software Foundation, Inc=2E,=

+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+#if=
ndef OPENVPN_TRANSPORT_H
+#define OPENVPN_TRANSPORT_H
+
+#ifdef ENABLE_PLUG=
IN
+
+#include "plugin=2Eh"
+#include "openvpn-transport=2Eh"
+
+/* Given a=
 list of plugins and an argument list for a desired
+ * transport plugin in=
stance, prepare to bind new link sockets using
+ * that transport plugin an=
d args=2E If all succeeds, return true, and:
+ *
+ *   *vtabp is set to the=
 vtable by which to bind new link sockets=2E
+ *   *handlep is set to the p=
lugin handle to use in bind calls=2E
+ *   *argsp is set to the args value =
to use in bind calls=2E It is
+ *     the caller's responsibility to call f=
reeargs on it later=2E
+ *
+ * Otherwise, return false, and the values of a=
ll of the above are
+ * undefined=2E None of the output pointers may be NUL=
L=2E
+ */
+bool transport_prepare(const struct plugin_list *plugins,
+     =
                  const char **transport_plugin_argv,
+                    =
   struct openvpn_transport_bind_vtab1 **vtabp,
+                       ope=
nvpn_plugin_handle_t *handlep,
+                       openvpn_transport_ar=
gs_t *argsp);
+
+/* Bind a virtual socket given an address family and list =
of potential
+ * bind addresses=2E bind_addresses may be NULL, in which cas=
e an
+ * unspecified address of the correct family is used=2E The virtual
+=
 * socket comes from a transport plugin in the list of plugins which
+ * ma=
tches transport_plugin_argv, which is used for any
+ * connection-specific =
parameters the plugin may require=2E
+ *
+ * Raises a fatal error if the so=
cket cannot be bound=2E
+ */
+openvpn_transport_socket_t
+transport_bind(co=
nst struct plugin_list *plugins,
+               const char **transport_plu=
gin_argv, sa_family_t ai_family,
+               struct addrinfo *bind_addr=
esses);
+
+struct event_set_return;
+struct event_set;
+
+/* Mutates esr/es=
rlen to consume events=2E */
+unsigned transport_update_event(openvpn_trans=
port_socket_t vsocket,
+                                struct event_set_re=
turn *esr, int *esrlen);
+
+void transport_request_events(openvpn_transport=
_socket_t indirect,
+                              struct event_set *es, un=
signed rwflags);
+
+
+int transport_get_sd(openvpn_transport_socket_t indir=
ect);
+
+/* NOTE: transport_write and transport_read implicitly downcast fr=
om a
+ * ssize_t to an int on return=2E Various link_socket_* functions
+ *=
 already do this, under the assumption that the return values will
+ * alwa=
ys fit in an int, because the requested lengths always fit in
+ * an int, o=
therwise the buffer structure would already be corrupted=2E
+ */
+
+static =
inline int
+transport_write(openvpn_transport_socket_t indirect,
+         =
       struct buffer *buf, struct sockaddr *addr, socklen_t addrlen)
+{
+  =
  return (int)indirect->vtab->sendto(indirect, BPTR(buf), BLEN(buf), addr,
=
+                                       addrlen);
+}
+
+static inline int
+=
transport_read(openvpn_transport_socket_t indirect,
+               struct =
buffer *buf, struct sockaddr *addr, socklen_t *addrlen)
+{
+    return (int=
)indirect->vtab->recvfrom(indirect, BPTR(buf),
+                           =
              buf_forward_capacity(buf), addr, addrlen);
+}
+
+#endif /* EN=
ABLE_PLUGIN */
+
+#endif /* !OPENVPN_TRANSPORT_H */

-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2052?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I2fd7d973be9a1eb90ea201b2278be73e6ee6f27=
d
Gerrit-Change-Number: 2052
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De =
Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--oQXhEGZeAlU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2052?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">transport: introduce transport API plugin codebase<br><=
br>This API will allow plugins to provide virtual socket implementations<br=
>with their own table of functions for operations on these sockets,<br>with=
 limited but functional integration with the main OpenVPN event<br>loop=2E<=
br><br>This new mechanism can be used to implement alternative transport<br=
>protocols via external plugins, without interfering with the OpenVPN<br>co=
re codebase=2E<br><br>A sample user of this API might be an obsufcation sch=
ema which<br>manipulates the traffic before sending/receiving it=2E<br><br>=
Change-Id: I2fd7d973be9a1eb90ea201b2278be73e6ee6f27d<br>Signed-off-by: Robi=
n Tarsiger &lt;rtt@dasyatidae=2Ecom&gt;<br>[antonio@openvpn=2Enet: refactor=
ed commits, restyled code]<br>[gianmarco@mandelbit=2Ecom: rebased, adapted =
to multisocket]<br>---<br>M CMakeLists=2Etxt<br>M include/Makefile=2Eam<br>=
M include/openvpn-plugin=2Eh=2Ein<br>A include/openvpn-transport=2Eh<br>M s=
rc/openvpn/Makefile=2Eam<br>M src/openvpn/plugin=2Ec<br>M src/openvpn/plugi=
n=2Eh<br>M src/openvpn/socket_util=2Eh<br>A src/openvpn/transport=2Ec<br>A =
src/openvpn/transport=2Eh<br>10 files changed, 709 insertions(+), 1 deletio=
n(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/52/2052/1</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMa=
keLists=2Etxt</span><br><span>index 184a95a=2E=2E417d9a1 100644</span><br><=
span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><b=
r><span>@@ -620,6 +620,8 @@</span><br><span>     src/openvpn/status=2Eh</sp=
an><br><span>     src/openvpn/syshead=2Eh</span><br><span>     src/openvpn/=
tls_crypt=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sr=
c/openvpn/transport=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    src/openvpn/transport=2Eh</span><br><span>     src/openvpn/tun=2Ec<=
/span><br><span>     src/openvpn/tun=2Eh</span><br><span>     src/openvpn/t=
un_afunix=2Ec</span><br><span>diff --git a/include/Makefile=2Eam b/include/=
Makefile=2Eam</span><br><span>index af02d88=2E=2Ece367a5 100644</span><br><=
span>--- a/include/Makefile=2Eam</span><br><span>+++ b/include/Makefile=2Ea=
m</span><br><span>@@ -15,4 +15,5 @@</span><br><span> </span><br><span> incl=
ude_HEADERS =3D \</span><br><span> 	openvpn-plugin=2Eh \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	openvpn-transport=2Eh \</span><br><sp=
an> 	openvpn-msg=2Eh</span><br><span>diff --git a/include/openvpn-plugin=2E=
h=2Ein b/include/openvpn-plugin=2Eh=2Ein</span><br><span>index dde5dea=2E=
=2E436662e 100644</span><br><span>--- a/include/openvpn-plugin=2Eh=2Ein</sp=
an><br><span>+++ b/include/openvpn-plugin=2Eh=2Ein</span><br><span>@@ -132,=
7 +132,8 @@</span><br><span> #define OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER   =
  13</span><br><span> #define OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2  14</s=
pan><br><span> #define OPENVPN_PLUGIN_CLIENT_CRRESPONSE        15</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_PLUGIN_N       =
                 16</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define OPENVPN_PLUGIN_TRANSPORT                16</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define OPENVPN_PLUGIN_N                    =
    17</span><br><span> </span><br><span> /*</span><br><span>  * Build a ma=
sk out of a set of plug-in types=2E</span><br><span>@@ -791,6 +792,34 @@</s=
pan><br><span>     (void);</span><br><span> </span><br><span> /*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * FUNCTION: openvpn_plugin_ge=
t_vtab_v1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * This is only used for TR=
ANSPORT plugins presently=2E  It is called to</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * retrieve a vtable structure to be used for bin=
ding virtual sockets</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * which use the transport provided by the plugin=2E The selector is an</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * OPENVPN_VTAB consta=
nt=2E *size_out must be set to the size of the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * structure returned=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * REQUIRED: only for TRANSPORT plugins</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * RETURN VALUE</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* A pointer to a vtable of the requested type, or NULL if no</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * such vtable is provided by this=
 plugin=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+enum {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Return type: struct openvpn_transport_bind_vtab1 *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Plugin shoul=
d provide OPENVPN_PLUGIN_TRANSPORT at open time=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    OPENVPN_VTAB_TRANSPORT_BIND_V1 =3D 0x54726e31 /* &#3=
9;Trn1&#39; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+OPENVPN_PLUGIN_DEF void *OPENVPN_PLUGIN_FUNC(openvpn_plugin_=
get_vtab_v1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (in=
t selector, size_t *size_out);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span=
><br><span>  * Deprecated functions which are still supported for backward =
compatibility=2E</span><br><span>  */</span><br><span> </span><br><span>dif=
f --git a/include/openvpn-transport=2Eh b/include/openvpn-transport=2Eh</sp=
an><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E7f2969=
6</span><br><span>--- /dev/null</span><br><span>+++ b/include/openvpn-trans=
port=2Eh</span><br><span>@@ -0,0 +1,258 @@</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  Transport API handling code</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  Copyright (C) 2018 Robin Tarsiger &lt;rtt@dasyatidae=2Ecom&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  This program is free software; you can r=
edistribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  it under the terms of the GNU General Public License version 2=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by=
 the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
This program is distributed in the hope that it will be useful,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; w=
ithout even the implied warranty of</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E =
 See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Gen=
eral Public License for more details=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  You should have received a copy of the GNU General Public License</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  along with this pr=
ogram (see the file COPYING included with this</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  distribution); if not, write to the Free Sof=
tware Foundation, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef =
OPENVPN_TRANSPORT_H_</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define OPENVPN_TRANSPORT_H_</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* PLATFO=
RM: only POSIX-y platforms or Win32 here */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Win32 */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_TRANSPORT_PL=
ATFORM_WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &lt;stdbool=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &lt;winsock2=2Eh&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &lt;windows=2Eh&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* On Windows, platform-native events to wait on are provided to OpenVPN =
core as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * pairs of =
system events, normally corresponding to one potentially queued I/O</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * operation in each direct=
ion=2E The read event is waited on if read events are</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * requested, and the write event is wait=
ed on if write events are</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * requested=2E Events need not be distinct, but usually will be=2E T=
wo event</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * handles =
must always be provided; neither is permitted to be NULL=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+typedef const struct openvpn_tra=
nsport_win32_event_pair</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE rea=
d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE write;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} *openvpn_transpor=
t_native_event_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Windows doesn&#39;=
t have socklen_t; it uses int=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+typedef int openvpn_transport_socklen_t;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifdef _MSC_VER</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &lt;basetsd=2Eh&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+typedef SSIZE_T openvpn_transport_ssize_t;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+typedef ssize_t openvpn_transport_ssize_t=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#else /* ifdef _WIN32 */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* POSIX-y */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define OPENVPN_TRANSPORT_PLATFORM_POSIX</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;stdbool=2Eh&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;unistd=2Eh&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;sys/socket=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* On POSIX-y platforms, platf=
orm-native events to wait on are provided to</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * OpenVPN core as file descriptors=2E  Readiness =
for read and write are defined</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * the same way as in poll, epoll, and similar system APIs=2E Th=
e file descriptor</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 may be of any type which can be waited on=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+typedef int openvpn_transport_native_event_t;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* Alias natural socklen_t definition=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef sockl=
en_t openvpn_transport_socklen_t;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typed=
ef ssize_t openvpn_transport_ssize_t;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* rwflags val=
ues are a bitwise OR of zero or more of these values, indicating</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * what types of events are be=
ing requested or returned for a given object=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define OPENVPN_TRANSPORT_EVENT_READ  (1 &lt=
;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPE=
NVPN_TRANSPORT_EVENT_WRITE (1 &lt;&lt; 1)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Handle to an object that can accumulate requests to wait on platform-=
native</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * event sour=
ces=2E Use the functions in the vtable to operate on it=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+typedef struct openvpn_transport_=
event_set_handle *openvpn_transport_event_set_handle_t;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+struct openvpn_transport_event_set_vtab</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* Request to be notified when ev becomes ready in a=
ny of the ways specified</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * by the bitmask rwflags=2E Incoming notifications will have arg =
passed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * throug=
h as-is=2E See above for the definition of native events on different</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * platforms=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * Note that arg must be a distinc=
t, owned pointer and not NULL; see</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * update_event below=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    void (*set_event)(openvpn_transport_event_se=
t_handle_t handle,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                     openvpn_transport_native_event_t ev, unsigned rwflags,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
   void *arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Implementation extends this structure =
with state=2E Implementation is normally</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * provided by OpenVPN core; see request_event in stru=
ct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * openvpn_transp=
ort_vtab=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struc=
t openvpn_transport_event_set_handle</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const struct openvpn_transport_event_set_vtab *vtab;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* Handle to a virtual datagram socket, non-connection-oriented=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct openvpn_tr=
ansport_socket *openvpn_transport_socket_t;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* Implementation extends this structure with state=2E Implementation =
is normally</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * provi=
ded by a plugin providing an indirect socket mechanism=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct openvpn_transport_socket</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const struct openvpn_transport_socke=
t_vtab1 *vtab;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Handle to opaque per-connection parame=
ters=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef v=
oid *openvpn_transport_args_t;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Virtu=
al socket implementations should expect (and consumers must</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * provide) vtable calls in the fol=
lowing order:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   - bind must occur =
first, to create the virtual socket=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *   - request_event is followed by zero or more update_=
event calls, and then a</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *     pump call, before any further request_event calls occur=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   - recvfrom/sendto ma=
y occur at any time between bind and close, including</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *     interleaved with the event request=
 cycle above=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
 - close must occur last=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Error =
reporting is platform-native: errno on POSIX-y systems, or</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Winsock errors on Windows systems=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+struct openvpn_transport_bind_vtab1</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Producer should set to 0, consumer should igno=
re=2E May indicate</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * extended functions in the future=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    unsigned features;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* Parse connection-specific arguments as provided by a</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * &quot;transport-plu=
gin&quot; configuration line=2E argv[0] is normally the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * plugin shared object pathname=2E=
 argc is the total number of</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * valid strings in argv; argv[argc] is also NULL=2E plugin_ha=
ndle</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * is an op=
envpn_plugin_handle_t=2E  Memory for argv and its strings</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * is borrowed and may not be ret=
ained by the plugin=2E Any syntax</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * checking of text arguments should be done in this func=
tion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * The value returned=
 points to either opaque, valid parameters,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * or an error value=2E The distinction between=
 the two is defined</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * by the plugin, and can only be evaluated via the argerror</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * function below=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * This function pointer is allowe=
d to be NULL=2E In this case,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * argerror and freeargs must also be NULL, a nonempty</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * connection-specific=
 argument list will be rejected with an</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * error, and the value of args in the subsequent b=
ind call will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 always be NULL=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_t=
ransport_args_t (*parseargs)(void *plugin_handle,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                          con=
st char *const *argv,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                          int argc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* If args is an error value, as defined by this plugin=
, then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * return=
 a string describing the error=2E The string must remain</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * valid until the next call to ar=
gerror or freeargs on the same</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * value of args=2E If args is not an error value, return NU=
LL=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * This fu=
nction pointer must be NULL if and only if parseargs is</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * NULL=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *(*argerror)(openvpn_trans=
port_args_t args);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Destroy any r=
esources associated with args, which may be any</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * return value of parseargs: either parsed=
 parameters or an error</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * value=2E This function pointer must be NULL if and only if</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * parseargs is NULL=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    void (*fr=
eeargs)(openvpn_transport_args_t args);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Bind a new virtual socket to addr/len, given a plugin handle</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * and any connection-=
specific parameters=2E addr must not be NULL=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * plugin_handle is actually of type openvp=
n_plugin_handle_t=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * args is any value returned by parseargs for which argerror</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * would return NULL; ho=
wever, it is still borrowed, and the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * caller may call freeargs after bind while the socke=
t is still</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * in=
 use=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openv=
pn_transport_socket_t (*bind)(void *plugin_handle,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                       openv=
pn_transport_args_t args,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                       const struct sockaddr *addr,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                  openvpn_transport_socklen_t len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
ruct openvpn_transport_socket_vtab1</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* Producer should set to 0, consumer should ignore=2E May indicate</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * extended functions=
 in the future=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    unsigned features;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Given a =
virtual indirect socket returns the descriptor associated */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int (*get_sd)(openvpn_transpor=
t_socket_t handle);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Given the bi=
tmask rwflags, request that event_set be provided with all</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * native events that should be =
waited on such that whenever this virtual</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * socket may become ready in a way specified by =
rwflags, one of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * native events will become ready=2E This function should call</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     *   event_set-&gt;vtab-&gt;set_even=
t(event_set, =2E=2E=2E)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ze=
ro or more times for this purpose=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * The state of event_set should be assumed not to persist between =
calls to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * requ=
est_event; every native event must be provided every time=2E Currently,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * only one native =
event may be supplied (i=2Ee=2E, one call above)=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    void (*request_event)(openvpn_transp=
ort_socket_t handle,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                          openvpn_transport_event_set_handle_t event_set,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
      unsigned rwflags);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Indicat=
e to the virtual socket that a native event for which arg was</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * provided to a set_event ca=
ll above became ready in a manner indicated by</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * the bitmask rwflags=2E  This function _mu=
st_ test for whether arg</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * corresponds to an actual requested event from this virtual sock=
et=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * If arg corresponds t=
o a requested event, update_event does any necessary</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * internal state updates and _return=
s true_ to consume the event=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * If arg does not correspond to a requested event, update_event</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * does nothing and _re=
turns false_=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool (*update_event)(openvpn_transport_socket_t handle, void *arg,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
unsigned rwflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Perform any p=
ending processing that can be performed</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * immediately, and return a bitmask of rwflags ind=
icating whether</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * this virtual socket is ready to receive/send more packets=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned (*pump)(openvpn=
_transport_socket_t handle);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Rec=
eive a packet into buf/len, storing the address into addr/(*addrlen)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * and updating *addrl=
en to match=2E Returns -1 on error, or the number of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * bytes received=2E Must not block; =
signals an error if there is nothing to</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * receive=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    openvpn_transport_ssize_t (*recvfrom)(openvpn_tran=
sport_socket_t handle,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                          void *buf, size_t len,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
               struct sockaddr *addr,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                          openvpn_transpo=
rt_socklen_t *addrlen);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Send a p=
acket from buf/len to the address addr/addrlen=2E Returns -1 on</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * error, or the number of =
bytes sent=2E Must not block; signals an error if</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * there is no room to send=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_transport_ssize=
_t (*sendto)(openvpn_transport_socket_t handle,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                        const v=
oid *buf, size_t len,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                        const struct sockaddr *addr,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                openvpn_transport_socklen_t addrlen);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Destroy this virtual socket and free all resources al=
located for it=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * virtual socket must not be used afterward=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    void (*close)(openvpn_transport_so=
cket_t handle);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef OPENVPN_TRANSPORT_H_ */=
</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makef=
ile=2Eam</span><br><span>index 8a60a94=2E=2Ea6e9ca0 100644</span><br><span>=
--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=
=2Eam</span><br><span>@@ -154,6 +154,7 @@</span><br><span> 	status=2Ec stat=
us=2Eh \</span><br><span> 	syshead=2Eh \</span><br><span> 	tls_crypt=2Ec tl=
s_crypt=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	trans=
port=2Ec transport=2Eh \</span><br><span> 	tun=2Ec tun=2Eh \</span><br><spa=
n> 	tun_afunix=2Ec tun_afunix=2Eh \</span><br><span> 	vlan=2Ec vlan=2Eh \</=
span><br><span>diff --git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec=
</span><br><span>index a94f07b=2E=2E4ebbebb 100644</span><br><span>--- a/sr=
c/openvpn/plugin=2Ec</span><br><span>+++ b/src/openvpn/plugin=2Ec</span><br=
><span>@@ -122,6 +122,9 @@</span><br><span>         case OPENVPN_PLUGIN_CLI=
ENT_CRRESPONSE:</span><br><span>             return &quot;PLUGIN_CRRESPONSE=
&quot;;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        case OPENVPN_PLUGIN_TRANSPORT:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            return &quot;PLUGIN_TRANSPORT&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
     default:</span><br><span>             return &quot;PLUGIN_???&quot;;</=
span><br><span>     }</span><br><span>@@ -320,6 +323,7 @@</span><br><span> =
    PLUGIN_SYM(client_destructor, &quot;openvpn_plugin_client_destructor_v1=
&quot;, 0);</span><br><span>     PLUGIN_SYM(min_version_required, &quot;ope=
nvpn_plugin_min_version_required_v1&quot;, 0);</span><br><span>     PLUGIN_=
SYM(initialization_point, &quot;openvpn_plugin_select_initialization_point_=
v1&quot;, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PL=
UGIN_SYM(get_vtab, &quot;openvpn_plugin_get_vtab_v1&quot;, 0);</span><br><s=
pan> </span><br><span>     if (!p-&gt;open1 &amp;&amp; !p-&gt;open2 &amp;&a=
mp; !p-&gt;open3)</span><br><span>     {</span><br><span>diff --git a/src/o=
penvpn/plugin=2Eh b/src/openvpn/plugin=2Eh</span><br><span>index 684632c=2E=
=2E6776434 100644</span><br><span>--- a/src/openvpn/plugin=2Eh</span><br><s=
pan>+++ b/src/openvpn/plugin=2Eh</span><br><span>@@ -78,6 +78,7 @@</span><b=
r><span>     openvpn_plugin_client_destructor_v1 client_destructor;</span><=
br><span>     openvpn_plugin_min_version_required_v1 min_version_required;<=
/span><br><span>     openvpn_plugin_select_initialization_point_v1 initiali=
zation_point;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    op=
envpn_plugin_get_vtab_v1 get_vtab;</span><br><span> </span><br><span>     o=
penvpn_plugin_handle_t plugin_handle;</span><br><span> };</span><br><span>d=
iff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh</span=
><br><span>index a1a61af=2E=2E40f9334 100644</span><br><span>--- a/src/open=
vpn/socket_util=2Eh</span><br><span>+++ b/src/openvpn/socket_util=2Eh</span=
><br><span>@@ -140,6 +140,9 @@</span><br><span>     PROTO_TCP,</span><br><s=
pan>     PROTO_TCP_SERVER,</span><br><span>     PROTO_TCP_CLIENT,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PLUGIN</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    PROTO_INDIRECT,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     =
PROTO_N</span><br><span> };</span><br><span> </span><br><span>diff --git a/=
src/openvpn/transport=2Ec b/src/openvpn/transport=2Ec</span><br><span>new f=
ile mode 100644</span><br><span>index 0000000=2E=2E8467916</span><br><span>=
--- /dev/null</span><br><span>+++ b/src/openvpn/transport=2Ec</span><br><sp=
an>@@ -0,0 +1,309 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Transport AP=
I handling code</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 201=
8 Robin Tarsiger &lt;rtt@dasyatidae=2Ecom&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  This program is free software; you can redistribute it and/or =
modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under =
the terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distri=
buted in the hope that it will be useful,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  ME=
RCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License fo=
r more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have=
 received a copy of the GNU General Public License</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  along with this program (see the file CO=
PYING included with this</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  distribution); if not, write to the Free Software Foundation, Inc=
=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  59 Temple P=
lace, Suite 330, Boston, MA  02111-1307  USA</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(_M=
SC_VER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;config-msvc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PLUGIN</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;event=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;plugin=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;so=
cket=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;transport=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;openvpn-transport=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
transport_prepare(const struct plugin_list *plugins,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  const char **transport_=
plugin_argv,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
           struct openvpn_transport_bind_vtab1 **vtabp,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                  openvpn_plugin_handle=
_t *handlep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
           openvpn_transport_args_t *argsp)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *expected_so_pathname =3D transport_plugin_argv[0];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int argc =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (transport_plugin_argv[argc])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        argc++;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (int i =3D 0; i &lt; plugins-&gt;common-&gt;n; i++)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        struct plugin *p =3D &amp;plugins-&gt;=
common-&gt;plugins[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (p-&gt;so_pathname &amp;&amp; !strcmp(p-&gt;so_pathname, expe=
cted_so_pathname))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 /* Pathname matches; this is the plugin requested=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (!(p-&gt;plugin_type_ma=
sk</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
 &amp; OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TRANSPORT)))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                msg(M_FATAL,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    &quot;INDIRECT: p=
lugin %s does not indicate TRANSPORT functionality&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    p-&gt;so_pathname=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            size_t size =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            struct openvpn_tra=
nsport_bind_vtab1 *vtab =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if (p-&gt;get_vtab)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                vtab =3D p-&gt;get_vtab(OPENVPN_VTAB_TR=
ANSPORT_BIND_V1, &amp;size);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (=
!vtab)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg=
(M_FATAL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          &quot;INDIRECT: plugin %s has no TRANSPORT_BIND_V1 table&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    p=
-&gt;so_pathname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Sanity chec=
ks on the vtable=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (!(size =3D=3D sizeof(*vtab) &amp;&amp; vtab-&gt;bind</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                  &amp;=
&amp; ((vtab-&gt;parseargs &amp;&amp; vtab-&gt;argerror &amp;&amp; vtab-&gt=
;freeargs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
             || (!vtab-&gt;parseargs &amp;&amp; !vtab-&gt;argerror</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                          &a=
mp;&amp; !vtab-&gt;freeargs))))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                msg(M_FATAL,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    &quot;INDIRECT: plugin %s returned a fau=
lty TRANSPORT_BIND_V1 table&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    p-&gt;so_pathname);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            openvpn_transport_args_t args =3D NULL;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (vtab-&gt;parsearg=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                args =
=3D vtab-&gt;parseargs(p-&gt;plugin_handle, transport_plugin_argv,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
           argc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                const=
 char *argerror =3D vtab-&gt;argerror(args);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                if (argerror)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    msg(M_FATAL,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        &quo=
t;INDIRECT: invalid arguments to transport-plugin %s: %s&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        p-&gt;s=
o_pathname, argerror);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            *vtabp =3D v=
tab;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *ha=
ndlep =3D p-&gt;plugin_handle;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            *argsp =3D args;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+o=
penvpn_transport_socket_t</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+transport_bind(const struct plugin_list *plugins,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+               const char **transport_p=
lugin_argv, sa_family_t ai_family,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+               struct addrinfo *bind_addresses)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    openvpn_plugin_handle_t handle;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    openvpn_transport_args_t args;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_transpo=
rt_socket_t indirect;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct openvpn_transport_bind_vtab1 *vtab;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct addrinfo *cur =3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr zer=
o;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!transport_prepare(plugins, =
transport_plugin_argv, &amp;vtab, &amp;handle,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                           &amp;args))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;INDIRECT: Sock=
et bind failed: provider plugin not found&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* Partially replicates the functionality of socket_bind=2E No bind_ipv6_o=
nly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * or other =
such options, presently=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (bind_addresses)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (cu=
r =3D bind_addresses; cur; cur =3D cur-&gt;ai_next)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (cur-&gt;ai_family =3D=3D ai_family)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                break;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!cur)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(M_FATAL, &quot;INDIRECT: Socket bind failed: Addr to =
bind has no %s record&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                addr_family_name(ai_family));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
cur)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        indirect =3D vtab-&gt=
;bind(handle, args, cur-&gt;ai_addr, (openvpn_transport_socklen_t)cur-&gt;a=
i_addrlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (ai_family=
 =3D=3D AF_UNSPEC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_E=
RR, &quot;INDIRECT: cannot bind with unspecified address family&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        memset(&amp;zero, 0, sizeof(zero));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        zero=2Eaddr=2Esa=2Esa_family =
=3D ai_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   addr_zero_host(&amp;zero);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        indirect =3D vtab-&gt;bind(handle, args, &amp;zero=2Eaddr=
=2Esa, (openvpn_transport_socklen_t)af_addr_size(ai_family));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!indirect)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(M_ERR, &quot;INDIRECT: Socket bind failed&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (vtab-&gt;freeargs)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    vtab-&gt;freeargs(args);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return indirect;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+struct encapsulated_event_set</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct openvpn_transport_event_set_handle handle;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct event_set *real;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if EVENT_READ =3D=3D OPENVPN_TRANSPORT_EVENT_READ \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &amp;&amp; EVENT_WRITE =
=3D=3D OPENVPN_TRANSPORT_EVENT_WRITE</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define TRANSPORT_EVENT_BITS_IDENTICAL 1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define TRANSPORT_EVENT_BITS_IDENTICAL 0</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static inline unsigned</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+translate_rwflags_in(unsigned vrwflags)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if TRANSPORT_EVENT_BITS_IDENTICAL</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return vrwflags;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    unsigned rwflags =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (vrwflags &amp; OPENVPN_TRANSPORT_EVEN=
T_READ)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        rwflags |=3D EVENT=
_READ;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (vrwflags &amp; OPEN=
VPN_TRANSPORT_EVENT_WRITE)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 rwflags |=3D EVENT_WRITE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn rwflags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline unsigned</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+translate_rwflags_out(unsigned rwflags)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if TRANSPORT_EVENT_BITS_IDENTICAL</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return rwflags;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    unsigned vrwflags =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (rwflags &amp; EVENT_READ)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        vrwflags |=3D OPENVPN_TRANSPORT_E=
VENT_READ;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rwflags &amp; E=
VENT_WRITE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        vrwflags |=3D =
OPENVPN_TRANSPORT_EVENT_WRITE;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return vrwflags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+encapsulated_event_set_set_event(openvpn_transport_event_set=
_handle_t handle,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                               openvpn_transport_native_event_t vev,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
       unsigned vrwflags, void *arg)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   unsigned rwflags =3D translate_rwflags_in(vrwflags);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    event_t ev;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct rw_handle rw;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    rw=2Eread =3D vev-&gt;read;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    rw=2Ewrite =3D vev-&gt;wr=
ite;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ev =3D &amp=
;rw;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ev =3D vev;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct event_set *es =3D ((struct encapsulated_event_set *)ha=
ndle)-&gt;real;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* If rwflags =3D=3D 0, we do nothing, because this is always one-shot mode=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rwfla=
gs !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        event_ctl(es, e=
v, rwflags, arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static const struct openvpn_transport_event_set_vtab =
encapsulated_event_set_vtab =3D {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    encapsulated_event_set_set_event</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsig=
ned</span><br><span style=3D"color: hsl(120, 100%, 40%);">+transport_update=
_event(openvpn_transport_socket_t indirect,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                       struct event_set_return *esr=
, int *esrlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    while (i &lt; *esrlen)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        unsigned vrwflags =3D tra=
nslate_rwflags_out(esr[i]=2Erwflags);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (indirect-&gt;vtab-&gt;update_event(indirect, =
esr[i]=2Earg, vrwflags))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* Consume the event; move the last one in place of it=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (i !=3D *esr=
len - 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
emcpy(&amp;esr[i], &amp;esr[*esrlen - 1], sizeof(*esr));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            (*esrlen)--;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            /* Don&#39;t consume the event; move to the next one=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return translate_rwflags_in(indirect-&gt;vtab-&gt;pump(=
indirect));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+transport_get_sd(openvpn_transport_socket_t indirect)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return indirect-&gt;vtab-&gt;get_sd(indir=
ect);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+transport_request_events(openvpn_transport_socket_t indirect,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
 struct event_set *es, unsigned rwflags)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    unsigned vrwflags =3D translate_rwflags_out(rwflags);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct encapsulated_event_set =
encapsulated_es;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 encapsulated_es=2Ehandle=2Evtab =3D &amp;encapsulated_event_set_vtab;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    encapsulated_es=2Ere=
al =3D es;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    indir=
ect-&gt;vtab-&gt;request_event(indirect, &amp;encapsulated_es=2Ehandle, vrw=
flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif /* ENABLE_PLUGIN */</span><br><span>diff -=
-git a/src/openvpn/transport=2Eh b/src/openvpn/transport=2Eh</span><br><spa=
n>new file mode 100644</span><br><span>index 0000000=2E=2E72778c5</span><br=
><span>--- /dev/null</span><br><span>+++ b/src/openvpn/transport=2Eh</span>=
<br><span>@@ -0,0 +1,100 @@</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Trans=
port API handling code</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright =
(C) 2018 Robin Tarsiger &lt;rtt@dasyatidae=2Ecom&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is free software; you can redistribute it=
 and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  i=
t under the terms of the GNU General Public License version 2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Soft=
ware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s distributed in the hope that it will be useful,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Li=
cense for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You sho=
uld have received a copy of the GNU General Public License</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  along with this program (see the=
 file COPYING included with this</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  distribution); if not, write to the Free Software Foundati=
on, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  59 T=
emple Place, Suite 330, Boston, MA  02111-1307  USA</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OPENVPN_TRAN=
SPORT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPEN=
VPN_TRANSPORT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PLUGIN</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;plugin=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn-transp=
ort=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Given a list of plugin=
s and an argument list for a desired</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * transport plugin instance, prepare to bind new link soc=
kets using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that t=
ransport plugin and args=2E If all succeeds, return true, and:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *   *vtabp is set to the vtable by which to bind=
 new link sockets=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *   *handlep is set to the plugin handle to use in bind calls=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *   *argsp is set to the ar=
gs value to use in bind calls=2E It is</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *     the caller&#39;s responsibility to call freeargs =
on it later=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Otherwise, return f=
alse, and the values of all of the above are</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * undefined=2E None of the output pointers may be=
 NULL=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool transport_prepare(cons=
t struct plugin_list *plugins,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                       const char **transport_plugin_argv,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                       st=
ruct openvpn_transport_bind_vtab1 **vtabp,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                       openvpn_plugin_handle_t *hand=
lep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
        openvpn_transport_args_t *argsp);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Bind a virtual socket given an address family and list of potential</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * bind addresses=2E =
bind_addresses may be NULL, in which case an</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * unspecified address of the correct family is us=
ed=2E The virtual</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 socket comes from a transport plugin in the list of plugins which</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * matches transport_plugin_=
argv, which is used for any</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * connection-specific parameters the plugin may require=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Raises a fatal error if the socket cannot=
 be bound=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_transport_socke=
t_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+transport_bind(c=
onst struct plugin_list *plugins,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+               const char **transport_plugin_argv, sa_family_=
t ai_family,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
        struct addrinfo *bind_addresses);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+struct event_set_return;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+struct event_set;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Mutates es=
r/esrlen to consume events=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+unsigned transport_update_event(openvpn_transport_socket_t vso=
cket,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                  struct event_set_return *esr, int *esrlen);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void transport_request_events(openvpn_transport_sock=
et_t indirect,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                         struct event_set *es, unsigned rwflags);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+int transport_get_sd(openvpn_transport_socket_t indirect);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* NOTE: transport_write and transport_read imp=
licitly downcast from a</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * ssize_t to an int on return=2E Various link_socket_* functions</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * already do this, under=
 the assumption that the return values will</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * always fit in an int, because the requested leng=
ths always fit in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 an int, otherwise the buffer structure would already be corrupted=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static inline int</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+transport_write(openvpn_transport_socket_t indirect,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                struct buffer=
 *buf, struct sockaddr *addr, socklen_t addrlen)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return (int)indirect-&gt;vtab-&gt;sendto(indirect, BPTR(buf)=
, BLEN(buf), addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                      addrlen);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static in=
line int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+transport_r=
ead(openvpn_transport_socket_t indirect,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+               struct buffer *buf, struct sockaddr *ad=
dr, socklen_t *addrlen)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (in=
t)indirect-&gt;vtab-&gt;recvfrom(indirect, BPTR(buf),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
buf_forward_capacity(buf), addr, addrlen);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ENAB=
LE_PLUGIN */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* !OPENVPN_TRANSPO=
RT_H */</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2052?usp=3Demail">change 2052</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2052?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I2fd7d973be9a1eb90ea201b2=
278be73e6ee6f27d </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2052 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--oQXhEGZeAlU=--


--===============5960649844809547741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5960649844809547741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5960649844809547741==--

