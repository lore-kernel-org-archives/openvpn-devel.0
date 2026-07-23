Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A6BC531D0
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 18:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=91IenL2OuxXGlKZA0+4SiZfTdHKv+VKrFes7nzde9Tk=; b=dVWr6D+Ei92A4eK4qxLpJ89v2X
	RecRyLax50YYwZWTMMkEUyFpgamhRzt+7VVgsNwrF4ycZM4bEgznp6vxfReLXZCpCIOOp6sJ0gsfU
	XReGfMJ21VAF/mddCE2/gF7tMmYvh/mhiqqjmRYbEGExi8ztxe5FdYWRbitQMwYNVOZQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmxoy-0005Lr-70;
	Thu, 23 Jul 2026 18:07:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmxos-0005LQ-Ex
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 18:06:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LuAlzEmAshjgO+TRw9LGSDpq+iyRgJfPWE3nWjGcxmU=; b=TmFe/HOaLc/u5bV2E8usvC0f6r
 +ipIP4FNcBPI13VT1OfvMLugzyL+LtB9HyM8mvjwbiTIpXOd02qCt+vCXogTi3hOTg6bAvmTfkA1k
 VTcE+xjp+lRZN884hkKywmGCuFbm2V45CLHK8CcNQWIk1ZusvEmkfgcK9jtt6ppAjBSI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LuAlzEmAshjgO+TRw9LGSDpq+iyRgJfPWE3nWjGcxmU=; b=m
 6HZG60owK39HKlPMkSmd7DfYMhYgbxnHJ0jf10c8egOola9lZLE0Hq0FPrzW6MzUjRwFAbaedks+P
 v/+WAkON9gV3ZvNz18re9h78uYpWrfgF0Rp7FGIH19LZ6AA3GErFwMlWY39UqYP59hifjj9wBz5Dd
 xfCzx01UC/zeb7Uw=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmxoe-0002YE-OS for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 18:06:40 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so886563f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 11:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784829991; x=1785434791; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LuAlzEmAshjgO+TRw9LGSDpq+iyRgJfPWE3nWjGcxmU=;
 b=NARPpj3zwL37+vA7cLqozgt/uPCitRGoiPooy0qmbPrFcd/GEK1cwsl/xT5Onn/Zu+
 k1ZfrGi66nGUm0uHzNrlXauTlpliCBI3VcJtAzfYkRbrCyrOZnoQ0D737JbkDDy0EApv
 cPpJZwOUM5g/+VIJp56eOJ+SCLYJenEEM/SXSCv+uMbLGopp5Xup2ToE4BX1ir4VNb+G
 5g0JjyeLQHg2oWJORwy3mpQSupKuhjxYwRhlzUG0G6BbMs4C87p38b+Ya38tlBDBwrPI
 4QvXQwrrzvgLBVNRk/pZkErt+k9xQTV8Zsuob4LvXAil6ZclLN132yP+/omLpH2MYBSh
 1CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784829991; x=1785434791;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LuAlzEmAshjgO+TRw9LGSDpq+iyRgJfPWE3nWjGcxmU=;
 b=K3ZN5+7RwR8HmpRYaQG7w2t7/yCKPoUEZWwyhd7y0Zb2jTFo7SrBVluEj49aTm0p6x
 qMiNRSzDo/sUnBN3whnLaNcFNNR/V4ylqR8I84eZ2MrIMcAblPQ0geYrOiPFg8ZALVem
 S457xn7X667fHM2IPRQ95Cn6P60GceM8MM79bQifVu+VNecJEArDZHaNDGZ3a0RdOzP8
 E7o/MoN4dBlEg+65ZnU6pFEfG6xTPhvw8p7fdMYa8mn1wjDxrosk8GAc7zG0b3hgC7Vs
 EN1eAYBt0M9cTCoKSzC/I4tovmDMd5zCKYHUkC2Dc5C8GGExW8Mh+d86C1QNV7pDzp76
 zOrw==
X-Gm-Message-State: AOJu0Ywk0mkTRH8iUsGMqR+rh3MYOjJmCVn7K57T2JlUZwNrE5n0xv2w
 NfgKn0DdmFqzSlSdjoPmxlvsEwtXBF0TL4BpJpc1rhSooE+GByrjb78D7oD6eGjBHTKjqDD1hks
 PThULcYVR6MKFVtmaZRViyTCIeKNVfd7+YoqeWcbegXO4yajHscYQrQDR7ZWAXRj7j0qP
X-Gm-Gg: AR+sD10e7ZZxGqt6D+KeRv1DODTBdbcHfdj1+LZwkHisxp0R6GIvApoG4RgXTmg3v+9
 QVJupbon2wlHswI8uciFgk3Cg9HQFOO5l8d2UXoodpkMOH9mL0MOHcvGwlUD3c08wBEeKvkQPH9
 BxormsOiSyF7RRZImY9d/ZA1/YjTjA1+zvYPn9EtCII6arpARuMHllkQjSXyAZuc0a57jOR1K27
 2P3oXYSgyaBNmXX79JwArashdFKPCtncwfsBQ1xpFBihiuggTLfi1c6WVJMzWIlBjQtv39ZZAKd
 KCDBXbO9jODr4q7spfs5g7sxj+ptBXIdQ57UVKDrRuFkSGwUo0qYm4BK3yLsnQQ2d6i9OgqyCx1
 9CPa1fTJaeaKmEqA1kDeqRWTxbkFYE5tX8hcNvbiJw/9aFeoPj47Mw7tFBVWgu6ymZWsn3q54lG
 W77T5b1Tzkkm4HClMy5hTr45QsCE9jXOAGNnNJPZt0Ldk3Sdtz8pPWiCXcw5IrKaJw6C4ES8eW/
 7BK7mRGoIkgqRJP6fchkpopS/wE5u6z4Jy9MLbFMJScSzyVmNHedgjrTSMQnjZmZnHA
X-Received: by 2002:a05:6000:25c2:b0:47f:93a1:116a with SMTP id
 ffacd0b85a97d-47f93a1159bmr2673369f8f.17.1784829990447; 
 Thu, 23 Jul 2026 11:06:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531afsm16944647f8f.24.2026.07.23.11.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 11:06:30 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 18:06:28 +0000
To: mrbff <marco@mandelbit.com>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1
X-Gerrit-Change-Number: 1798
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1798?usp=email>
X-Gerrit-Commit: d9e9ec2d289e9a3c44144d4972ffe8e1fbe55978
In-Reply-To: <gerrit.1784699722000.Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1@gerrit.openvpn.net>
References: <gerrit.1784699722000.Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0Njk5NzIyMDAwLkliMThlMWVkMDg1MWJjMGZlNmQ4NDQ4ZTYwMWQxMWQ2YWJhYTcxMGMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a132ae922fcd0a0e22b71dce9417cd78450d0697-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmxoe-0002YE-OS
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1359935444652985632=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1359935444652985632==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u2i0lnRbJnQ="; charset=UTF-8

--u2i0lnRbJnQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 mrbff=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1798?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by flic=
htenheld


Change subject: options: limit ping and keepalive values to one =
day
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options=
: limit ping and keepalive values to one day

A correct configuration shoul=
d not require such large ping intervals or
timeouts, and an upper limit of =
one day is already generous=2E

Limit --ping, --ping-exit, --ping-restart a=
nd --keepalive values to
86400 seconds=2E Since --keepalive doubles the tim=
eout in server mode,
limit its timeout argument to 43200 seconds there=2E

=
Related: https://lore=2Ekernel=2Eorg/all/20260722044756=2E872870-1-marco@ma=
ndelbit=2Ecom/

Change-Id: Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1
Signed=
-off-by: Marco Baffo <marco@mandelbit=2Ecom>
Acked-by: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1798
Message-Id: <20260722205210=2E8060-1-gert@greenie=2Emuc=2Ede>
URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg37792=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =
doc/man-sections/link-options=2Erst
M src/openvpn/helper=2Ec
M src/openvpn/=
options=2Ec
M src/openvpn/options=2Eh
4 files changed, 27 insertions(+), 6 =
deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/98/1798/2

diff --git a/doc/man-sections/link-options=2Erst b/doc/ma=
n-sections/link-options=2Erst
index 7c61b67=2E=2E735ee51 100644
--- a/doc/m=
an-sections/link-options=2Erst
+++ b/doc/man-sections/link-options=2Erst
@@=
 -74,7 +74,9 @@
      keepalive interval timeout
 
   Send ping once every =
``interval`` seconds, restart if ping is not received
-  for ``timeout`` se=
conds=2E
+  for ``timeout`` seconds=2E Both values are limited to 86400 sec=
onds=2E Since the
+  server-side timeout is doubled, ``timeout`` is limited=
 to 43200 seconds in
+  server mode=2E
 
   This option can be used on both=
 client and server side, but it is enough
   to add this on the server side=
 as it will push appropriate ``--ping``
@@ -247,6 +249,8 @@
   cause ping p=
ackets to be sent in both directions since OpenVPN ping
   packets are not =
echoed like IP ping packets)=2E
 
+  The maximum value for ``n`` is 86400 s=
econds=2E
+
   This option has two intended uses:
 
   (1)  Compatibility w=
ith stateful firewalls=2E The periodic ping will ensure
@@ -264,6 +268,8 @@=

   ``--inactive``, ``--ping`` and ``--ping-exit`` to create a two-tiered
 =
  inactivity disconnect=2E
 
+  The maximum value for ``n`` is 86400 second=
s=2E
+
   For example,
   ::
 
@@ -278,6 +284,8 @@
   ``n`` seconds pass wi=
thout reception of a ping or other packet from
   remote=2E
 
+  The maximu=
m value for ``n`` is 86400 seconds=2E
+
   This option is useful in cases w=
here the remote peer has a dynamic IP
   address and a low-TTL DNS name is =
used to track the IP address using a
   service such as https://www=2Ensupd=
ate=2Einfo/ + a dynamic DNS client such as
diff --git a/src/openvpn/helper=
=2Ec b/src/openvpn/helper=2Ec
index 7c186c5=2E=2Ed29895b 100644
--- a/src/o=
penvpn/helper=2Ec
+++ b/src/openvpn/helper=2Ec
@@ -555,6 +555,12 @@
       =
      msg(M_USAGE,
                 "--keepalive conflicts with --ping, --p=
ing-exit, or --ping-restart=2E  If you use --keepalive, you don't need any =
of the other --ping directives=2E");
         }
+        if (o->mode =3D=3D=
 MODE_SERVER && o->keepalive_timeout > PING_TIMEOUT_MAX / 2)
+        {
+  =
          msg(M_USAGE,
+                "The second parameter to --keepaliv=
e must not exceed %d in server mode=2E",
+                PING_TIMEOUT_MAX =
/ 2);
+        }
 
         /*
          * Expand=2E
diff --git a/src/openv=
pn/options=2Ec b/src/openvpn/options=2Ec
index 7460a83=2E=2Ed4675ca 100644
=
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -6794,24 +67=
94,29 @@
     else if (streq(p[0], "keepalive") && p[1] && p[2] && !p[3])
 =
    {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        atoi_constrained(=
p[1], &options->keepalive_ping, "keepalive ping", 1, INT_MAX, msglevel);
- =
       atoi_constrained(p[2], &options->keepalive_timeout, "keepalive timeo=
ut", 1, INT_MAX, msglevel);
+        atoi_constrained(p[1], &options->keepa=
live_ping, "keepalive ping",
+                         1, PING_TIMEOUT_MAX,=
 msglevel);
+        atoi_constrained(p[2], &options->keepalive_timeout, "k=
eepalive timeout",
+                         1, PING_TIMEOUT_MAX, msglevel)=
;
     }
     else if (streq(p[0], "ping") && p[1] && !p[2])
     {
       =
  VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping_send_timeout =3D p=
ositive_atoi(p[1], msglevel);
+        atoi_constrained(p[1], &options->pin=
g_send_timeout, p[0],
+                         0, PING_TIMEOUT_MAX, msglev=
el);
     }
     else if (streq(p[0], "ping-exit") && p[1] && !p[2])
     {=

         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping_rec_timeou=
t =3D positive_atoi(p[1], msglevel);
+        atoi_constrained(p[1], &optio=
ns->ping_rec_timeout, p[0],
+                         0, PING_TIMEOUT_MAX, =
msglevel);
         options->ping_rec_timeout_action =3D PING_EXIT;
     }
=
     else if (streq(p[0], "ping-restart") && p[1] && !p[2])
     {
        =
 VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping_rec_timeout =3D pos=
itive_atoi(p[1], msglevel);
+        atoi_constrained(p[1], &options->ping_=
rec_timeout, p[0],
+                         0, PING_TIMEOUT_MAX, msglevel)=
;
         options->ping_rec_timeout_action =3D PING_RESTART;
     }
     e=
lse if (streq(p[0], "ping-timer-rem") && !p[1])
diff --git a/src/openvpn/op=
tions=2Eh b/src/openvpn/options=2Eh
index a111cf8=2E=2E2f7fe30 100644
--- a=
/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -56,6 +56,8 @@
 #=
define OPTION_PARM_SIZE 256
 #define OPTION_LINE_SIZE 256
 
+#define PING_T=
IMEOUT_MAX 86400 /* one day (in seconds) */
+
 extern const char title_stri=
ng[];
 
 /* certain options are saved before --pull modifications are appli=
ed */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1798?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib18e1ed085=
1bc0fe6d8448e601d11d6abaa710c1
Gerrit-Change-Number: 1798
Gerrit-PatchSet: =
2
Gerrit-Owner: mrbff <marco@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--u2i0lnRbJnQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by mrbff=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1798?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">options: limit ping and ke=
epalive values to one day<br><br>A correct configuration should not require=
 such large ping intervals or<br>timeouts, and an upper limit of one day is=
 already generous=2E<br><br>Limit --ping, --ping-exit, --ping-restart and -=
-keepalive values to<br>86400 seconds=2E Since --keepalive doubles the time=
out in server mode,<br>limit its timeout argument to 43200 seconds there=2E=
<br><br>Related: https://lore=2Ekernel=2Eorg/all/20260722044756=2E872870-1-=
marco@mandelbit=2Ecom/<br><br>Change-Id: Ib18e1ed0851bc0fe6d8448e601d11d6ab=
aa710c1<br>Signed-off-by: Marco Baffo &lt;marco@mandelbit=2Ecom&gt;<br>Acke=
d-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1798<br>Message-Id: &lt;202607222052=
10=2E8060-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37792=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M doc/man-sect=
ions/link-options=2Erst<br>M src/openvpn/helper=2Ec<br>M src/openvpn/option=
s=2Ec<br>M src/openvpn/options=2Eh<br>4 files changed, 27 insertions(+), 6 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/98/1798/2</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sectio=
ns/link-options=2Erst b/doc/man-sections/link-options=2Erst</span><br><span=
>index 7c61b67=2E=2E735ee51 100644</span><br><span>--- a/doc/man-sections/l=
ink-options=2Erst</span><br><span>+++ b/doc/man-sections/link-options=2Erst=
</span><br><span>@@ -74,7 +74,9 @@</span><br><span>      keepalive interval=
 timeout</span><br><span> </span><br><span>   Send ping once every ``interv=
al`` seconds, restart if ping is not received</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  for ``timeout`` seconds=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  for ``timeout`` seconds=2E Both values =
are limited to 86400 seconds=2E Since the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  server-side timeout is doubled, ``timeout`` is limi=
ted to 43200 seconds in</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  server mode=2E</span><br><span> </span><br><span>   This option can b=
e used on both client and server side, but it is enough</span><br><span>   =
to add this on the server side as it will push appropriate ``--ping``</span=
><br><span>@@ -247,6 +249,8 @@</span><br><span>   cause ping packets to be =
sent in both directions since OpenVPN ping</span><br><span>   packets are n=
ot echoed like IP ping packets)=2E</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  The maximum value for ``n`` is 86400 se=
conds=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>   This option has two intended uses:</span><br><span> </span><br><sp=
an>   (1)  Compatibility with stateful firewalls=2E The periodic ping will =
ensure</span><br><span>@@ -264,6 +268,8 @@</span><br><span>   ``--inactive`=
`, ``--ping`` and ``--ping-exit`` to create a two-tiered</span><br><span>  =
 inactivity disconnect=2E</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  The maximum value for ``n`` is 86400 seconds=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   F=
or example,</span><br><span>   ::</span><br><span> </span><br><span>@@ -278=
,6 +284,8 @@</span><br><span>   ``n`` seconds pass without reception of a p=
ing or other packet from</span><br><span>   remote=2E</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  The maximum value for=
 ``n`` is 86400 seconds=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>   This option is useful in cases where the remote =
peer has a dynamic IP</span><br><span>   address and a low-TTL DNS name is =
used to track the IP address using a</span><br><span>   service such as htt=
ps://www=2Ensupdate=2Einfo/ + a dynamic DNS client such as</span><br><span>=
diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec</span><br><spa=
n>index 7c186c5=2E=2Ed29895b 100644</span><br><span>--- a/src/openvpn/helpe=
r=2Ec</span><br><span>+++ b/src/openvpn/helper=2Ec</span><br><span>@@ -555,=
6 +555,12 @@</span><br><span>             msg(M_USAGE,</span><br><span>    =
             &quot;--keepalive conflicts with --ping, --ping-exit, or --pin=
g-restart=2E  If you use --keepalive, you don&#39;t need any of the other -=
-ping directives=2E&quot;);</span><br><span>         }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;mode =3D=3D MODE_SERVE=
R &amp;&amp; o-&gt;keepalive_timeout &gt; PING_TIMEOUT_MAX / 2)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_USAGE,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                &quot;The second par=
ameter to --keepalive must not exceed %d in server mode=2E&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                PING_TIMEOUT_=
MAX / 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span> </span><br><span>         /*</span><br><span>          * E=
xpand=2E</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn=
/options=2Ec</span><br><span>index 7460a83=2E=2Ed4675ca 100644</span><br><s=
pan>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=
=2Ec</span><br><span>@@ -6794,24 +6794,29 @@</span><br><span>     else if (=
streq(p[0], &quot;keepalive&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&am=
p; !p[3])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION=
(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   atoi_constrained(p[1], &amp;options-&gt;keepalive_ping, &quot;keepalive =
ping&quot;, 1, INT_MAX, msglevel);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        atoi_constrained(p[2], &amp;options-&gt;keepalive_time=
out, &quot;keepalive timeout&quot;, 1, INT_MAX, msglevel);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        atoi_constrained(p[1], &amp;=
options-&gt;keepalive_ping, &quot;keepalive ping&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                         1, PING_TIMEOU=
T_MAX, msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      atoi_constrained(p[2], &amp;options-&gt;keepalive_timeout, &quot;keep=
alive timeout&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                         1, PING_TIMEOUT_MAX, msglevel);</span><br><span> =
    }</span><br><span>     else if (streq(p[0], &quot;ping&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VE=
RIFY_PERMISSION(OPT_P_TIMER);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        options-&gt;ping_send_timeout =3D positive_atoi(p[1], msgle=
vel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        atoi_c=
onstrained(p[1], &amp;options-&gt;ping_send_timeout, p[0],</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                         0, PING_TIM=
EOUT_MAX, msglevel);</span><br><span>     }</span><br><span>     else if (s=
treq(p[0], &quot;ping-exit&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><=
br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_TIMER);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ping=
_rec_timeout =3D positive_atoi(p[1], msglevel);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        atoi_constrained(p[1], &amp;options-&gt=
;ping_rec_timeout, p[0],</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                         0, PING_TIMEOUT_MAX, msglevel);</span><br><sp=
an>         options-&gt;ping_rec_timeout_action =3D PING_EXIT;</span><br><s=
pan>     }</span><br><span>     else if (streq(p[0], &quot;ping-restart&quo=
t;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><spa=
n>         VERIFY_PERMISSION(OPT_P_TIMER);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        options-&gt;ping_rec_timeout =3D positive_atoi=
(p[1], msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      atoi_constrained(p[1], &amp;options-&gt;ping_rec_timeout, p[0],</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
0, PING_TIMEOUT_MAX, msglevel);</span><br><span>         options-&gt;ping_r=
ec_timeout_action =3D PING_RESTART;</span><br><span>     }</span><br><span>=
     else if (streq(p[0], &quot;ping-timer-rem&quot;) &amp;&amp; !p[1])</sp=
an><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh=
</span><br><span>index a111cf8=2E=2E2f7fe30 100644</span><br><span>--- a/sr=
c/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><=
br><span>@@ -56,6 +56,8 @@</span><br><span> #define OPTION_PARM_SIZE 256</s=
pan><br><span> #define OPTION_LINE_SIZE 256</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define PING_TIMEOUT_MAX 86400 /*=
 one day (in seconds) */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> extern const char title_string[];</span><br><span> <=
/span><br><span> /* certain options are saved before --pull modifications a=
re applied */</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1798?usp=3Demail">change 1798</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1798?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib=
18e1ed0851bc0fe6d8448e601d11d6abaa710c1 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1798 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@m=
andelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--u2i0lnRbJnQ=--


--===============1359935444652985632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1359935444652985632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1359935444652985632==--

