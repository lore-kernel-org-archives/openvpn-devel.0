Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31253C531D0
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7lZc7eWDzhranwaYD1r7q2Cs8f4srwiXXIUDKjCdd2E=; b=fDv1Z9OQZzWqUHPJ0nHIAWX+aM
	OtOCQG3NXh0sbsoovhIGXAUl8GkV6m691Lw8vULPhWnjHc0j6JouzWEsvVfkWZ7kbBFdDVzLINLpJ
	qKEQSM5h/xzXPgUVDTqs6vCdcq1CDZra8wahB2/8NZ+SHacUz8KS1h6US2Zy9OPRzF/Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmxov-0001JG-Iq;
	Thu, 23 Jul 2026 18:06:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmxot-0001Ix-5l
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 18:06:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=q3nXvjcck4WuZgxrRanpn+1UuZZ5gxJ+vGzyuZ0bNkA=; b=YSNvb6XwQZ47Hs+2jwuDeM9iIJ
 ajW6R+YS4NCjbe4J63FAHxl2OppGnBtE4uXlCZotgCQPwhlku6Qq7Ydq3mWrqPpoDOIcnUlMpfRFZ
 YHK9aqgnSDifY5qHf4I7RX7lBqwqFM1XjaaCj3bQLVqEuNaY+K/+9dkTd0FzCh3fw3Bw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=q3nXvjcck4WuZgxrRanpn+1UuZZ5gxJ+vGzyuZ0bNkA=; b=G
 si6C9I4oyOJ7E1BypTdt7sLNpVXqycTnLCxbzNPl3w0ICbso7dvQDTiQHSmT3dzBQJb7c5rVqizt2
 zB/m/AKwtNNwtetutydPjL1cwODALuvtwmD44J1ni2c60xQNWxiXUp8douiAr5iz0IzJ6yBWg0K6Q
 hbLWTt9SOeS3rBow=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmxog-0002YG-EX for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 18:06:41 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4955484387cso7612695e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784829991; x=1785434791; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q3nXvjcck4WuZgxrRanpn+1UuZZ5gxJ+vGzyuZ0bNkA=;
 b=PSsa6/WhT3kQUMiz4bJFBoYP1+nUvGeP6tKxo29pHASS09EPQK1uMGrCxG+SXhc0uJ
 LxeZYtyJVgrt1JziNdM2thsrcQdmchsmA8u4VRG5nFiiHHF458RTJaRspjLcSR6hY88w
 VA5lJXZwfE7krRUpS8p9j2vE+SzcHqCmnu0UNX9L3k75oXW2oGMzxlbvlrWNbNZSVJRE
 nEu8rWb0z5p86oRtSEQ+gTp3/SNBcJC2U7xDPFNJSdzumur8bls+lqkAda1szN40J1Ac
 twwTFVhMo3jgn8cgF+CIi3y4O0FaF+HzreLYHMM8u2JiWUYiPRnTEWJVDM8dBjRMiwQf
 +BGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784829991; x=1785434791;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=q3nXvjcck4WuZgxrRanpn+1UuZZ5gxJ+vGzyuZ0bNkA=;
 b=AZPx5Gzf2JxXtnlqptVzdFzVoEVAYHDbvyUlgrGsqHap6gOKKlQoVwVQ9A+40+LrWC
 qPwYeqQ2aPYN3R+vVTxOO6BLMkDBZ1Uz+oeqQR2krDEFEQGelsynnHvg2XKciSXkJCnZ
 B7TRbXYOiYIUVuj+5ONyzuWUgG6T4iWI11nv530IB0O5o7onDHJS+2szKDEw+5hYBq2u
 6LhIn4kG7/wpsyVZ0qRqSJbB3nRLPWgQUKReTLpuAoG8qw0LkzMlEqiUPu7h17KYF6mo
 CkjZlZulbKy0NKiPnLw5t8o+Nxw8HMG7Qc3xvEoqJ70DEzMvACyrK9RzRi9v5uffQCN/
 sXEg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rox1jH0zwfVF7alA1YH4jFarDFf3m5Z2Jyo+SHR7AOnphuMyv74UxoJv0fI2RJVMz4oGVL/aNYhXoxWUeua@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxkESLsQZdJaPWHhfzOPNEWJxwo+Sdtty4Ge0m3LWSxLnvhiyqZ
 SLM9E5c16YPylW9oVraoh1KsRtJgS1KJFgF5zICZnNK8FJyi3Gt5NWeOT1nGlCFCSDvhmIkNom0
 3p/ZA4yFCdP9UaWKRZFjLTV2ylXbzlOmFm4f6M+cS3uW64o+0uo/i3y6pl0zss4MfQerk
X-Gm-Gg: AR+sD13lXr06Bq/NEGw4sOVeASHDRkV4OT3bVVMR0rlBY582p1y7d58RFs5eDA4v6DQ
 nwl3Sp1qb8FQjraBjTzSZM87Xhm8EBEpR8YCTRMxAucrCabuloS0POJLOYrsXGZJVIPYknfLZAe
 cwAAygxbogWPQMULkzC54uJn5zTjSwDRkcCxcdtFr3sSwL/Dgc4ozGRUuCvlGFF9TY6HPcoK68e
 iBvsuZAlM8B0Qb6/eeudhzJ+qQwQUXNcPGFYO8s4HYXEyVo0psFiePrkN7KGDcNKFnWlhkYMQ3g
 P6qL0Vdt7vS7Oigcs8Wu6l8oQ6tNXKUYM9KzfyV6rCCB9m/sz5ootKMAn0yCmzotD8d6VrYQvBo
 1glgo0rGNDAGm6K/o667zPmNEjJXWEk/869qT+UDs6nC/ADzTSydxCF2MYYr6/ZVQEF5bT9IYwx
 MaBPPST7A4nuWPP5GPKYq6C0KYwIaTgX/tXG+puLmRxJoyj34koljnt6wbmNM5a2g/SaFIDn2v3
 zruN5HLnefzOPRX1mj9wMfLla54lebi5le/1qg57Iy+n2XIjIPHi3AEQPbbDnxI93Uk
X-Received: by 2002:a05:600c:4f44:b0:493:bd2a:93bb with SMTP id
 5b1f17b1804b1-49573c8d564mr47245275e9.3.1784829991345; 
 Thu, 23 Jul 2026 11:06:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b5f2918sm6841565e9.2.2026.07.23.11.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 11:06:31 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 18:06:30 +0000
To: mrbff <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1
X-Gerrit-Change-Number: 1798
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1798?usp=email>
X-Gerrit-Commit: d9e9ec2d289e9a3c44144d4972ffe8e1fbe55978
In-Reply-To: <gerrit.1784699722000.Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1@gerrit.openvpn.net>
References: <gerrit.1784699722000.Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0Njk5NzIyMDAwLkliMThlMWVkMDg1MWJjMGZlNmQ4NDQ4ZTYwMWQxMWQ2YWJhYTcxMGMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a132ae922fcd0a0e22b71dce9417cd78450d0697-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmxog-0002YG-EX
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: limit ping
 and keepalive values to one day
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4904406111551109187=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4904406111551109187==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GvEDVfEmk8A="; charset=UTF-8

--GvEDVfEmk8A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1798?usp=3Demail )

Change subject: options: limit ping and keepalive v=
alues to one day
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

options: limit ping and keepalive values to one day

A correct configu=
ration should not require such large ping intervals or
timeouts, and an upp=
er limit of one day is already generous=2E

Limit --ping, --ping-exit, --pi=
ng-restart and --keepalive values to
86400 seconds=2E Since --keepalive dou=
bles the timeout in server mode,
limit its timeout argument to 43200 second=
s there=2E

Related: https://lore=2Ekernel=2Eorg/all/20260722044756=2E87287=
0-1-marco@mandelbit=2Ecom/

Change-Id: Ib18e1ed0851bc0fe6d8448e601d11d6abaa=
710c1
Signed-off-by: Marco Baffo <marco@mandelbit=2Ecom>
Acked-by: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1798
Message-Id: <20260722205210=2E8060-1-gert@greenie=2Emu=
c=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg37792=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M doc/man-sections/link-options=2Erst
M src/openvpn/helper=2Ec
M=
 src/openvpn/options=2Ec
M src/openvpn/options=2Eh
4 files changed, 27 inse=
rtions(+), 6 deletions(-)




diff --git a/doc/man-sections/link-options=2E=
rst b/doc/man-sections/link-options=2Erst
index 7c61b67=2E=2E735ee51 100644=

--- a/doc/man-sections/link-options=2Erst
+++ b/doc/man-sections/link-opti=
ons=2Erst
@@ -74,7 +74,9 @@
      keepalive interval timeout
 
   Send ping=
 once every ``interval`` seconds, restart if ping is not received
-  for ``=
timeout`` seconds=2E
+  for ``timeout`` seconds=2E Both values are limited =
to 86400 seconds=2E Since the
+  server-side timeout is doubled, ``timeout`=
` is limited to 43200 seconds in
+  server mode=2E
 
   This option can be =
used on both client and server side, but it is enough
   to add this on the=
 server side as it will push appropriate ``--ping``
@@ -247,6 +249,8 @@
   =
cause ping packets to be sent in both directions since OpenVPN ping
   pack=
ets are not echoed like IP ping packets)=2E
 
+  The maximum value for ``n`=
` is 86400 seconds=2E
+
   This option has two intended uses:
 
   (1)  Com=
patibility with stateful firewalls=2E The periodic ping will ensure
@@ -264=
,6 +268,8 @@
   ``--inactive``, ``--ping`` and ``--ping-exit`` to create a =
two-tiered
   inactivity disconnect=2E
 
+  The maximum value for ``n`` is =
86400 seconds=2E
+
   For example,
   ::
 
@@ -278,6 +284,8 @@
   ``n`` sec=
onds pass without reception of a ping or other packet from
   remote=2E
 
+=
  The maximum value for ``n`` is 86400 seconds=2E
+
   This option is usefu=
l in cases where the remote peer has a dynamic IP
   address and a low-TTL =
DNS name is used to track the IP address using a
   service such as https:/=
/www=2Ensupdate=2Einfo/ + a dynamic DNS client such as
diff --git a/src/ope=
nvpn/helper=2Ec b/src/openvpn/helper=2Ec
index 7c186c5=2E=2Ed29895b 100644
=
--- a/src/openvpn/helper=2Ec
+++ b/src/openvpn/helper=2Ec
@@ -555,6 +555,12=
 @@
             msg(M_USAGE,
                 "--keepalive conflicts with =
--ping, --ping-exit, or --ping-restart=2E  If you use --keepalive, you don'=
t need any of the other --ping directives=2E");
         }
+        if (o->=
mode =3D=3D MODE_SERVER && o->keepalive_timeout > PING_TIMEOUT_MAX / 2)
+  =
      {
+            msg(M_USAGE,
+                "The second parameter to=
 --keepalive must not exceed %d in server mode=2E",
+                PING_T=
IMEOUT_MAX / 2);
+        }
 
         /*
          * Expand=2E
diff --git =
a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 7460a83=2E=2Ed467=
5ca 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -=
6794,24 +6794,29 @@
     else if (streq(p[0], "keepalive") && p[1] && p[2] =
&& !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        atoi_c=
onstrained(p[1], &options->keepalive_ping, "keepalive ping", 1, INT_MAX, ms=
glevel);
-        atoi_constrained(p[2], &options->keepalive_timeout, "keep=
alive timeout", 1, INT_MAX, msglevel);
+        atoi_constrained(p[1], &opt=
ions->keepalive_ping, "keepalive ping",
+                         1, PING_T=
IMEOUT_MAX, msglevel);
+        atoi_constrained(p[2], &options->keepalive_=
timeout, "keepalive timeout",
+                         1, PING_TIMEOUT_MAX=
, msglevel);
     }
     else if (streq(p[0], "ping") && p[1] && !p[2])
   =
  {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping_send_ti=
meout =3D positive_atoi(p[1], msglevel);
+        atoi_constrained(p[1], &o=
ptions->ping_send_timeout, p[0],
+                         0, PING_TIMEOUT_=
MAX, msglevel);
     }
     else if (streq(p[0], "ping-exit") && p[1] && !p=
[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping=
_rec_timeout =3D positive_atoi(p[1], msglevel);
+        atoi_constrained(p=
[1], &options->ping_rec_timeout, p[0],
+                         0, PING_TI=
MEOUT_MAX, msglevel);
         options->ping_rec_timeout_action =3D PING_EX=
IT;
     }
     else if (streq(p[0], "ping-restart") && p[1] && !p[2])
    =
 {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping_rec_time=
out =3D positive_atoi(p[1], msglevel);
+        atoi_constrained(p[1], &opt=
ions->ping_rec_timeout, p[0],
+                         0, PING_TIMEOUT_MAX=
, msglevel);
         options->ping_rec_timeout_action =3D PING_RESTART;
  =
   }
     else if (streq(p[0], "ping-timer-rem") && !p[1])
diff --git a/src=
/openvpn/options=2Eh b/src/openvpn/options=2Eh
index a111cf8=2E=2E2f7fe30 1=
00644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -56,6 =
+56,8 @@
 #define OPTION_PARM_SIZE 256
 #define OPTION_LINE_SIZE 256
 
+#de=
fine PING_TIMEOUT_MAX 86400 /* one day (in seconds) */
+
 extern const char=
 title_string[];
 
 /* certain options are saved before --pull modification=
s are applied */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1798?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: m=
erged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib18e=
1ed0851bc0fe6d8448e601d11d6abaa710c1
Gerrit-Change-Number: 1798
Gerrit-Patc=
hSet: 2
Gerrit-Owner: mrbff <marco@mandelbit=2Ecom>
Gerrit-Reviewer: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--GvEDVfEmk8A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1798?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">options: limit ping and keepalive values t=
o one day<br><br>A correct configuration should not require such large ping=
 intervals or<br>timeouts, and an upper limit of one day is already generou=
s=2E<br><br>Limit --ping, --ping-exit, --ping-restart and --keepalive value=
s to<br>86400 seconds=2E Since --keepalive doubles the timeout in server mo=
de,<br>limit its timeout argument to 43200 seconds there=2E<br><br>Related:=
 https://lore=2Ekernel=2Eorg/all/20260722044756=2E872870-1-marco@mandelbit=
=2Ecom/<br><br>Change-Id: Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1<br>Sign=
ed-off-by: Marco Baffo &lt;marco@mandelbit=2Ecom&gt;<br>Acked-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1798<br>Message-Id: &lt;20260722205210=2E8060-1-ger=
t@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg37792=2Ehtml<br>Signed-off-by: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M doc/man-sections/link-option=
s=2Erst<br>M src/openvpn/helper=2Ec<br>M src/openvpn/options=2Ec<br>M src/o=
penvpn/options=2Eh<br>4 files changed, 27 insertions(+), 6 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/doc/man-sections/link-options=2Erst b/doc/man-se=
ctions/link-options=2Erst</span><br><span>index 7c61b67=2E=2E735ee51 100644=
</span><br><span>--- a/doc/man-sections/link-options=2Erst</span><br><span>=
+++ b/doc/man-sections/link-options=2Erst</span><br><span>@@ -74,7 +74,9 @@=
</span><br><span>      keepalive interval timeout</span><br><span> </span><=
br><span>   Send ping once every ``interval`` seconds, restart if ping is n=
ot received</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  for ``ti=
meout`` seconds=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 for ``timeout`` seconds=2E Both values are limited to 86400 seconds=2E Sin=
ce the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  server-side=
 timeout is doubled, ``timeout`` is limited to 43200 seconds in</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  server mode=2E</span><br><spa=
n> </span><br><span>   This option can be used on both client and server si=
de, but it is enough</span><br><span>   to add this on the server side as i=
t will push appropriate ``--ping``</span><br><span>@@ -247,6 +249,8 @@</spa=
n><br><span>   cause ping packets to be sent in both directions since OpenV=
PN ping</span><br><span>   packets are not echoed like IP ping packets)=2E<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
The maximum value for ``n`` is 86400 seconds=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>   This option has two intende=
d uses:</span><br><span> </span><br><span>   (1)  Compatibility with statef=
ul firewalls=2E The periodic ping will ensure</span><br><span>@@ -264,6 +26=
8,8 @@</span><br><span>   ``--inactive``, ``--ping`` and ``--ping-exit`` to=
 create a two-tiered</span><br><span>   inactivity disconnect=2E</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The maximu=
m value for ``n`` is 86400 seconds=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>   For example,</span><br><span>   ::</s=
pan><br><span> </span><br><span>@@ -278,6 +284,8 @@</span><br><span>   ``n`=
` seconds pass without reception of a ping or other packet from</span><br><=
span>   remote=2E</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  The maximum value for ``n`` is 86400 seconds=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   This opti=
on is useful in cases where the remote peer has a dynamic IP</span><br><spa=
n>   address and a low-TTL DNS name is used to track the IP address using a=
</span><br><span>   service such as https://www=2Ensupdate=2Einfo/ + a dyna=
mic DNS client such as</span><br><span>diff --git a/src/openvpn/helper=2Ec =
b/src/openvpn/helper=2Ec</span><br><span>index 7c186c5=2E=2Ed29895b 100644<=
/span><br><span>--- a/src/openvpn/helper=2Ec</span><br><span>+++ b/src/open=
vpn/helper=2Ec</span><br><span>@@ -555,6 +555,12 @@</span><br><span>       =
      msg(M_USAGE,</span><br><span>                 &quot;--keepalive confl=
icts with --ping, --ping-exit, or --ping-restart=2E  If you use --keepalive=
, you don&#39;t need any of the other --ping directives=2E&quot;);</span><b=
r><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (o-&gt;mode =3D=3D MODE_SERVER &amp;&amp; o-&gt;keepalive_timeout=
 &gt; PING_TIMEOUT_MAX / 2)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          msg(M_USAGE,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                &quot;The second parameter to --keepalive must not excee=
d %d in server mode=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                PING_TIMEOUT_MAX / 2);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span> </span><br><span>  =
       /*</span><br><span>          * Expand=2E</span><br><span>diff --git =
a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 7=
460a83=2E=2Ed4675ca 100644</span><br><span>--- a/src/openvpn/options=2Ec</s=
pan><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -6794,24 +67=
94,29 @@</span><br><span>     else if (streq(p[0], &quot;keepalive&quot;) &=
amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>     {</sp=
an><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        atoi_constrained(p[1], &amp;optio=
ns-&gt;keepalive_ping, &quot;keepalive ping&quot;, 1, INT_MAX, msglevel);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        atoi_constraine=
d(p[2], &amp;options-&gt;keepalive_timeout, &quot;keepalive timeout&quot;, =
1, INT_MAX, msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        atoi_constrained(p[1], &amp;options-&gt;keepalive_ping, &quot;ke=
epalive ping&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                         1, PING_TIMEOUT_MAX, msglevel);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        atoi_constrained(p[2], &amp;op=
tions-&gt;keepalive_timeout, &quot;keepalive timeout&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                         1, PING_TI=
MEOUT_MAX, msglevel);</span><br><span>     }</span><br><span>     else if (=
streq(p[0], &quot;ping&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><=
span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_TIMER);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ping_sen=
d_timeout =3D positive_atoi(p[1], msglevel);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        atoi_constrained(p[1], &amp;options-&gt;pi=
ng_send_timeout, p[0],</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                         0, PING_TIMEOUT_MAX, msglevel);</span><br><span=
>     }</span><br><span>     else if (streq(p[0], &quot;ping-exit&quot;) &a=
mp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>    =
     VERIFY_PERMISSION(OPT_P_TIMER);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        options-&gt;ping_rec_timeout =3D positive_atoi(p[1],=
 msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
atoi_constrained(p[1], &amp;options-&gt;ping_rec_timeout, p[0],</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                         0, PIN=
G_TIMEOUT_MAX, msglevel);</span><br><span>         options-&gt;ping_rec_tim=
eout_action =3D PING_EXIT;</span><br><span>     }</span><br><span>     else=
 if (streq(p[0], &quot;ping-restart&quot;) &amp;&amp; p[1] &amp;&amp; !p[2]=
)</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_T=
IMER);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options=
-&gt;ping_rec_timeout =3D positive_atoi(p[1], msglevel);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        atoi_constrained(p[1], &amp;op=
tions-&gt;ping_rec_timeout, p[0],</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                         0, PING_TIMEOUT_MAX, msglevel);</spa=
n><br><span>         options-&gt;ping_rec_timeout_action =3D PING_RESTART;<=
/span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;ping=
-timer-rem&quot;) &amp;&amp; !p[1])</span><br><span>diff --git a/src/openvp=
n/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index a111cf8=2E=2E=
2f7fe30 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><spa=
n>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -56,6 +56,8 @@</span><br=
><span> #define OPTION_PARM_SIZE 256</span><br><span> #define OPTION_LINE_S=
IZE 256</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define PING_TIMEOUT_MAX 86400 /* one day (in seconds) */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> extern const =
char title_string[];</span><br><span> </span><br><span> /* certain options =
are saved before --pull modifications are applied */</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1798?usp=3Demail">change 1798</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1798?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1798 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: mrbff &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--GvEDVfEmk8A=--


--===============4904406111551109187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4904406111551109187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4904406111551109187==--

