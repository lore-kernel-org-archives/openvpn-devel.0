Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7CFC4451C
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 05:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=t4jnCcBN2osxvYJ4If/3U67YXW50GbKPkAFURRvPjsQ=; b=Ueyd8ahUpt0B6w
	QERPAUa72ClKIg3lVdPEs0bPCiqtfjIIy4NT8DxPSGswhTPYJ0G1xqYOmLOa6x9fqqra7dR+j2Xu2
	fyr/ZLYnHdgMeTo+Xl9Cs20/TxRpv12aJ6iNONp3EPzO2peedN6mG7JaYb0dbBUYcFo4s63zZVo8D
	yA4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmPvj-0005GN-NU;
	Wed, 22 Jul 2026 05:55:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmPve-0005GE-Gs
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 05:55:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z0sX4Ml+p62lsqzHgds2VP+9MBvwWIeqlgM9B5Y+xTw=; b=L7fig771Ka7vf5oeJ+GtaiTRqJ
 kdbiibqJ++GNDHomBAYKrM/SwkzqMDYsoSghesEr/z6cRbteqKOqq2/H7sb0hOrVnAsCSrAsDzGZ3
 nOWUfXGfxtmsbkiE9dDXRu8Q4yI4sRTHv2UvWKtj7+8vRgK6pikvqJ291bQ+/lkYaNTU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=z0sX4Ml+p62lsqzHgds2VP+9MBvwWIeqlgM9B5Y+xTw=; b=A
 UCmQNs5/pMf0j/b9ug+dV6BS6SKcs+t78sYC7GNpQsc54QT1G2wyO1t3DFKzoZc4m/EL8q+/my9wd
 y/YL9Ny1tmNRcuB48JHcn+OquRfDC/V7NO33iBxIMi/TJNebK0eVtD64u4U2EHx35gXYU1NKsIQpP
 KsFa6Ks1b97DBEIo=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmPvZ-00010S-WD for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 05:55:35 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so31498775e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 22:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784699727; x=1785304527; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z0sX4Ml+p62lsqzHgds2VP+9MBvwWIeqlgM9B5Y+xTw=;
 b=U+Z0K+7Pty72Gl4gh0P1mZv9//OuBsZNclKD7gvSqBatt3LGqCR2lmx4BbXWmUgP9B
 JFaJNcTofQ6hslGTwjXBy1on73fbObb7V9Gw9+7LwUnY8RmODmy0Tqak5nagnQQopud5
 6/9alvTVJuX36FHnuBJ4Z3o/NTyqpxzjOvqxPVWJP/pLwFVLfjQuy2gmstRj1+YvaqGS
 QjXCBRrIDlseB0GYGJbrSRVDpNCwJ2MVvkbf7wJr4FlaPAAEV5cPD1ZcFsQuQOtAqeFz
 qMD/Fh9xi1nzLLfxNPbg/fnx3CJHYz314ImCVUgR4gaTE2lSYxYC09Q4O7QSZl0+Ycqv
 6pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784699727; x=1785304527;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z0sX4Ml+p62lsqzHgds2VP+9MBvwWIeqlgM9B5Y+xTw=;
 b=mD5euXiU68jyZmtXihy1ydYGiaMUI62B6A8OLzKLgakbJkC6PKfRTT1L2McggzUwag
 weKJb6yOm7MZBzAV6R7EZcPxSO+1tv/Phfz/YkJAx0wr8s/fopomjhOHdYVuJikZWosW
 +8tmL9JSIe6Huq6TxTZzV56mlPmCss5d75K27gm+Ij6Fvd1NZzKe2Fh5OKukLOlhhN0E
 H7LjLcc1fxiXUyvwgHfSazB/qCdGeNzBeK69qFN4nOFuTPKPDZ9Zq0phwxtuKwn1Bigi
 Vs190ccIEiiT6Pe6++r4TnTY8pCLhd7WsP6q5G2LUNrD+Z2emXduk/A2+yWLPEbK+aYh
 xCNQ==
X-Gm-Message-State: AOJu0YywlT0mIaAMpVWuUGA3/9vpr0cAUXdXA8XJ+Nq5RwM9oI6vR+Cx
 U2CMnHjNXwLAQ8afCCWIXwHu4HsZQWl/v8V+GwzFpAnWq7+PwRFW0kUXq5IptbcXhUnm319/Mq0
 6BXd26bEthdNzUfSfGdKv+odZIXlnVhvERqjP0iVsvFKm1Ef9TBcOdpljMD4IxHBnbUWg8Fcxsn
 VVTs/IVg==
X-Gm-Gg: AR+sD11uGme+z0qhwzYkspPsMbSCd3DicdZhbmMbaLOcKH7ThSIXVyp+KSQM1wsFhoX
 oItWpmq10X/2/adPFoV2NFpJ+Fbcohvv7LoeuB8/C53UXaCQad2LwBCWyY4jkqp9tLXXseXyx4y
 npHG2wAlqZZPAHWRshB60E3W9aqJRyB2JOLhnAaGxkK0CQ/oC2PGzN4hZekWyTAv3+xA77X5ueH
 zD1WPjCzPjwHw3kM69nVhuu1X/gfo8MsRXZxRwi9B9FBDLQPlnXF7so7JWG6nEIwVjai9Nt3jte
 0ynisnDoeiK+xJtnIToN1v9VLn9aKLxK5sMQz/IXGkjXQLGpNbkvKaOvRV1q3bL7M2D4gkvLAMy
 oTmCCq8anZh3VT30Ubh98DfLzWGNyrrD6N2w+QxyJNNpZLnhxSccm2F9peyE83/+d4RZCpBD/s6
 g7GSugn5oVDA+gazJqYM0RFkMDrak2f6rCx7gqRTTZ5kevzNfj+pjBPJ6z24lvgte7JHos+T3cL
 MUawTU2Blxk9iaG0/jgsp1hmFV73+aR78l9IKdsdg/9BW8zGrO48HIjAfYpdtCisNqCZDQ4ecJ6
 p0s=
X-Received: by 2002:a05:600c:1911:b0:495:4fd4:619b with SMTP id
 5b1f17b1804b1-4954fd46219mr210307075e9.1.1784699727211; 
 Tue, 21 Jul 2026 22:55:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c8760sm109509245e9.14.2026.07.21.22.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 22:55:26 -0700 (PDT)
X-Google-Original-From: "mrbff (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 05:55:26 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1
X-Gerrit-Change-Number: 1798
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1798?usp=email>
X-Gerrit-Commit: 392af324b9480eda6ea96cc2e1f4838d17bdccff
References: <gerrit.1784699722000.Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0Njk5NzIyMDAwLkliMThlMWVkMDg1MWJjMGZlNmQ4NDQ4ZTYwMWQxMWQ2YWJhYTcxMGMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7ab1158dd1f936e6e8c5a66a33f18215cd8a1ca4-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmPvZ-00010S-WD
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
From: "mrbff \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "mrbff \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9209340695548633407=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9209340695548633407==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cMWVfbBYwBw="; charset=UTF-8

--cMWVfbBYwBw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1798?usp=3Demail

to review the following change=2E


Chang=
e subject: options: limit ping and keepalive values to one day
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: limit ping and k=
eepalive values to one day

A correct configuration should not require such=
 large ping intervals or
timeouts, and an upper limit of one day is already=
 generous=2E

Limit --ping, --ping-exit, --ping-restart and --keepalive val=
ues to
86400 seconds=2E Since --keepalive doubles the timeout in server mod=
e,
limit its timeout argument to 43200 seconds there=2E

Related: https://l=
ore=2Ekernel=2Eorg/all/20260722044756=2E872870-1-marco@mandelbit=2Ecom/

Ch=
ange-Id: Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1
Signed-off-by: Marco Baf=
fo <marco@mandelbit=2Ecom>
---
M doc/man-sections/link-options=2Erst
M src/=
openvpn/helper=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
4 fi=
les changed, 27 insertions(+), 6 deletions(-)



  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/98/1798/1

diff --git a/doc/man-se=
ctions/link-options=2Erst b/doc/man-sections/link-options=2Erst
index df8c9=
17=2E=2E77c3c41 100644
--- a/doc/man-sections/link-options=2Erst
+++ b/doc/=
man-sections/link-options=2Erst
@@ -74,7 +74,9 @@
      keepalive interval =
timeout
 
   Send ping once every ``interval`` seconds, restart if ping is =
not received
-  for ``timeout`` seconds=2E
+  for ``timeout`` seconds=2E Bo=
th values are limited to 86400 seconds=2E Since the
+  server-side timeout =
is doubled, ``timeout`` is limited to 43200 seconds in
+  server mode=2E
 
=
   This option can be used on both client and server side, but it is enough=

   to add this on the server side as it will push appropriate ``--ping``
@=
@ -247,6 +249,8 @@
   cause ping packets to be sent in both directions sinc=
e OpenVPN ping
   packets are not echoed like IP ping packets)=2E
 
+  The =
maximum value for ``n`` is 86400 seconds=2E
+
   This option has two intend=
ed uses:
 
   (1)  Compatibility with stateful firewalls=2E The periodic pi=
ng will ensure
@@ -264,6 +268,8 @@
   ``--inactive``, ``--ping`` and ``--pi=
ng-exit`` to create a two-tiered
   inactivity disconnect=2E
 
+  The maxim=
um value for ``n`` is 86400 seconds=2E
+
   For example,
   ::
 
@@ -278,6 =
+284,8 @@
   ``n`` seconds pass without reception of a ping or other packet=
 from
   remote=2E
 
+  The maximum value for ``n`` is 86400 seconds=2E
+
 =
  This option is useful in cases where the remote peer has a dynamic IP
   =
address and a low-TTL DNS name is used to track the IP address using a
   s=
ervice such as https://www=2Ensupdate=2Einfo/ + a dynamic DNS client such a=
s
diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec
index 4c540a=
6=2E=2E6fd2689 100644
--- a/src/openvpn/helper=2Ec
+++ b/src/openvpn/helper=
=2Ec
@@ -563,6 +563,12 @@
             msg(M_USAGE,
                 "--kee=
palive conflicts with --ping, --ping-exit, or --ping-restart=2E  If you use=
 --keepalive, you don't need any of the other --ping directives=2E");
     =
    }
+        if (o->mode =3D=3D MODE_SERVER && o->keepalive_timeout > PIN=
G_TIMEOUT_MAX / 2)
+        {
+            msg(M_USAGE,
+                "T=
he second parameter to --keepalive must not exceed %d in server mode=2E",
+=
                PING_TIMEOUT_MAX / 2);
+        }
 
         /*
          *=
 Expand=2E
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
i=
ndex 87218d4=2E=2E003b460 100644
--- a/src/openvpn/options=2Ec
+++ b/src/op=
envpn/options=2Ec
@@ -6789,24 +6789,29 @@
     else if (streq(p[0], "keepal=
ive") && p[1] && p[2] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GEN=
ERAL);
-        atoi_constrained(p[1], &options->keepalive_ping, "keepalive=
 ping", 1, INT_MAX, msglevel);
-        atoi_constrained(p[2], &options->ke=
epalive_timeout, "keepalive timeout", 1, INT_MAX, msglevel);
+        atoi_=
constrained(p[1], &options->keepalive_ping, "keepalive ping",
+            =
             1, PING_TIMEOUT_MAX, msglevel);
+        atoi_constrained(p[2]=
, &options->keepalive_timeout, "keepalive timeout",
+                      =
   1, PING_TIMEOUT_MAX, msglevel);
     }
     else if (streq(p[0], "ping")=
 && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-       =
 options->ping_send_timeout =3D positive_atoi(p[1], msglevel);
+        ato=
i_constrained(p[1], &options->ping_send_timeout, p[0],
+                   =
      0, PING_TIMEOUT_MAX, msglevel);
     }
     else if (streq(p[0], "pin=
g-exit") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
=
-        options->ping_rec_timeout =3D positive_atoi(p[1], msglevel);
+    =
    atoi_constrained(p[1], &options->ping_rec_timeout, p[0],
+             =
            0, PING_TIMEOUT_MAX, msglevel);
         options->ping_rec_time=
out_action =3D PING_EXIT;
     }
     else if (streq(p[0], "ping-restart") =
&& p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        =
options->ping_rec_timeout =3D positive_atoi(p[1], msglevel);
+        atoi_=
constrained(p[1], &options->ping_rec_timeout, p[0],
+                      =
   0, PING_TIMEOUT_MAX, msglevel);
         options->ping_rec_timeout_actio=
n =3D PING_RESTART;
     }
     else if (streq(p[0], "ping-timer-rem") && !=
p[1])
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index =
a111cf8=2E=2E2f7fe30 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn=
/options=2Eh
@@ -56,6 +56,8 @@
 #define OPTION_PARM_SIZE 256
 #define OPTIO=
N_LINE_SIZE 256
 
+#define PING_TIMEOUT_MAX 86400 /* one day (in seconds) *=
/
+
 extern const char title_string[];
 
 /* certain options are saved befo=
re --pull modifications are applied */

-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1798?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1
Gerrit-Change=
-Number: 1798
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@mandelbit=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>

--cMWVfbBYwBw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>mrbff would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1798?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">op=
tions: limit ping and keepalive values to one day<br><br>A correct configur=
ation should not require such large ping intervals or<br>timeouts, and an u=
pper limit of one day is already generous=2E<br><br>Limit --ping, --ping-ex=
it, --ping-restart and --keepalive values to<br>86400 seconds=2E Since --ke=
epalive doubles the timeout in server mode,<br>limit its timeout argument t=
o 43200 seconds there=2E<br><br>Related: https://lore=2Ekernel=2Eorg/all/20=
260722044756=2E872870-1-marco@mandelbit=2Ecom/<br><br>Change-Id: Ib18e1ed08=
51bc0fe6d8448e601d11d6abaa710c1<br>Signed-off-by: Marco Baffo &lt;marco@man=
delbit=2Ecom&gt;<br>---<br>M doc/man-sections/link-options=2Erst<br>M src/o=
penvpn/helper=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh=
<br>4 files changed, 27 insertions(+), 6 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/98/1=
798/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/doc/man-sections/link-options=2Erst b/doc/man-se=
ctions/link-options=2Erst</span><br><span>index df8c917=2E=2E77c3c41 100644=
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
b/src/openvpn/helper=2Ec</span><br><span>index 4c540a6=2E=2E6fd2689 100644<=
/span><br><span>--- a/src/openvpn/helper=2Ec</span><br><span>+++ b/src/open=
vpn/helper=2Ec</span><br><span>@@ -563,6 +563,12 @@</span><br><span>       =
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
a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 8=
7218d4=2E=2E003b460 100644</span><br><span>--- a/src/openvpn/options=2Ec</s=
pan><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -6789,24 +67=
89,29 @@</span><br><span>     else if (streq(p[0], &quot;keepalive&quot;) &=
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
 newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </di=
v>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"=
display:none"> Gerrit-Change-Id: Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1 =
</div>
<div style=3D"display:none"> Gerrit-Change-Number: 1798 </div>
<div =
style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:non=
e"> Gerrit-Owner: mrbff &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body>=
</html>
--cMWVfbBYwBw=--


--===============9209340695548633407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9209340695548633407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9209340695548633407==--

