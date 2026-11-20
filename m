Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4B606A325
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QZf664bF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UdB2o6wu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YBLFGDWL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=f7xFSZyM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=3TL9lv2HhpuAH0lB1e6Tj9mV/Fb5u8htn80F28cWZ1I=; b=QZf664bFZkOeWy+kJKxVIuo9V1
	7lFHaQbiLUlN9LVwc6PZhgx7ZVomlALEhkYy0hTSyEo6LpdE7Y6wR+rGQR66TEDuE3GMnvtKRSpas
	gl8htoLXVzEQfzvHisxcieTMsfBA+o9V5k2WF6f9wQ1sIP/C4AWGUU1M7Qgpj2jjdu8U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUM4L-000000001KY-2Eep;
	Fri, 20 Nov 2026 10:42:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUM49-000000001KE-1PgP
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:42:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L43uwVAUEEl0w1FWfXxuNqn/b38HMzeEOjUJaBq51tw=; b=UdB2o6wuuOoYczM5xHtzovCK+h
 Owo5RnW/2/oagoJbucfKeQ4Ax+VgkWTbSZ5aahdQ2v+mV0EStI3AvWp2dcHunIg6hXO1sGdJ4MaSy
 3daE7ik2h/FVMbG8FT19oaLGRXaU3/AawSHc9Gon8FazBqRpikieL3JjrMO6hXKF3Mgw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L43uwVAUEEl0w1FWfXxuNqn/b38HMzeEOjUJaBq51tw=; b=YBLFGDWLwlsIrJHnOS+hF7FRcS
 CQElax4zP52AegqvUk6sbY0VUdTS1FnywfRmyvRUFaMk5STpdFPIx6tFscBojTUUjVORlQ8ceL/8k
 x0ovIpfNwUDIWETVfP1F6mvAU2n3LrYLqE7P2Ay6LBYqUmioDVDUqUMZAyIeywgP3clM=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUM46-0000000043S-3zDH for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:42:01 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so411197f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 02:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795171312; x=1795776112; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L43uwVAUEEl0w1FWfXxuNqn/b38HMzeEOjUJaBq51tw=;
 b=f7xFSZyMXh2Q7n3ZRpqbWBC6VAoH7MOohFqKF31m3mYnkD35h6CjjgpP37XNPhdWuV
 UbkrwK45L8Vnv5p0z2YfUx4OIk0yMtq1v6zIaFzgyl3VBSJrOE7yDtQTb1l+BdIZSDSF
 +XXDiHLzg7KMa0dbWNizVTsM4dQ7IGA3nJVthAY7zJQerhCaodbWBVJe5SpQTg0CQj2d
 2BU0LDN91IxwC3jJhI2EPRnh/i/Y36zQllKOsPjY76Ffv+SpgFjke5tM37st0CcUpVep
 xEOB7esxBRyNZe9n5Z70GSyHuq6SM69LXJiy02HC1zVNgCZRZ6nSuFuG7v89w9peSTX1
 eHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171312; x=1795776112;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L43uwVAUEEl0w1FWfXxuNqn/b38HMzeEOjUJaBq51tw=;
 b=nCZjbAfj+wqyIjk89yHuUK7bMzmpOVluCHrKfIT8jaB8W2JAQ0HisoZDPeMoFLztCD
 hFk3wuMMvKTqW1+pw+6VAFRbEg2Z+pYytpX1Zup9KAP0rXnMOe782Of+C71BbYuuTXAo
 /u7UtnY8JPq1+yA1353gJ8lISs1+5gGv9LapdSa7cd4hTP40tXeE5E+JxVmLaXRJwCuN
 PAqUOld0Ux9gzBSTltFZ/iBa35MyoPN3o/gs6NXRJXmRIRIYoFo9G7pgFOAaVa3+4lG7
 4fjV24iU82dJgsYkOg3XvjYpVTIx/cIagJMBiuoM3THwda32dLW165YwuYl8NxuW2ee4
 UHhw==
X-Gm-Message-State: APuU4Z+fYFCaD4RFY9UrGq4JZVvaWCOLlKxXOtTqxMaVbmYrrNq4xjVp
 pdrKB9SJWmH4cvKud9/1TF9sqBuTayPGlOiWUQLQj+/xCAHLJcsjhaKYC94QYjGO42I9oFzW6KU
 1lLjHHt57q8WTgFqg9XmoQzOZVqBHzijdmEH2bCmgW+yzvn9WubbNabrIWcka1a5ZsJ1SWEK/eB
 NPB320PA==
X-Gm-Gg: AYBFou1MycjfGbJs+vW/7D3gaQ9LX9XxVCl8LF/IBe5mu8256A9UoPBAtBcUP7zFrFR
 vVlmvlEh2TKmXxXeFttXKb1HaEk2TfANUl4y+5nC+cnnzE/CrHVOslckS+xeXU5aGp4k05ozLEk
 D320NUUTaa1q/PIfKN859b0JgfY8YFBG1f35zQw15QooVb/oiUfKSuqTx7CKuEfg4Ipz7h5a2Gl
 NL3jT6vZT66TkgRDzqptxVc+kX9210g6nWLwu1OFxm2HjMna6+ucLiWQFSx+RKdhp6NYxr56n9j
 n7BgT92CsF63fx0dMLd/DzeVZS5iIwGn1/oR0+9z8NLUaWWOiHGTjl7Yr/9cFTTuq5RA1yikbNP
 dgd+3lH6ZwFlrbfFUVfLKnRg5FrbqhAcodbX7R772LanEhVVee6wX+NKPTlIiH+SFctkHoEVix+
 0szKFssLP/OcIQEiq2nNi4Il67zt5R5FA0AZohtl+ShFNWFWnLfo8ncoMMNCZtPas1PcQFud0qe
 ZlMc9MM8hGNLq4019YBq+kLSBcqRSocSywmJ/wCawYO/tPkpTEQ/SkAdTqoRl9HE222W3V/TZ66
 03g4iC7iG3wzb+jJBygVa5AuVs2pEQcSLaxNDwAj9J5VVzOkwafYLAL+nOvOdRUcGLDeLCJjNLc
 NTPWXHEzWbu8NV1Peyh9aR3TS4ApUtkyV0/ZEyIay8DDYlfRyElgmLhzs+Q8JzC/FI7v9nXRiWX
 k8IEhAMNlwOmc+JvUojXAQq7p2MPuNLo3hcZFl
X-Received: by 2002:a05:600c:3b1a:b0:4a7:8fe8:130c with SMTP id
 5b1f17b1804b1-4bb8881d4damr55136045e9.28.1795171311844; 
 Fri, 20 Nov 2026 02:41:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3882sm4759233f8f.49.2026.11.20.02.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:41:51 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 10:41:50 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I81fffc46c574cda873eba8864444e5c9972549f5
X-Gerrit-Change-Number: 2225
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2225?usp=email>
X-Gerrit-Commit: 41308f927631657574711a7c1e2f5cabd12f3a04
References: <gerrit.1795171307000.I81fffc46c574cda873eba8864444e5c9972549f5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTcxMzA3MDAwLkk4MWZmZmM0NmM1NzRjZGE4NzNlYmE4ODY0NDQ0ZTVjOTk3MjU0OWY1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <76ea2ae1225ee32d314ce3227639a62c42bf2db5-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUM46-0000000043S-3zDH
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add --mptcp option
 for Multipath TCP transport on Linux
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
Content-Type: multipart/mixed; boundary="===============2952750108810730488=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2952750108810730488==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vl0QiONRuZI="; charset=UTF-8

--Vl0QiONRuZI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2225?usp=3Demail

to review the following change=2E
=


Change subject: Add --mptcp option for Multipath TCP transport on Linux
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add --mptcp o=
ption for Multipath TCP transport on Linux

With --mptcp, the TCP transport=
 socket is created as Multipath TCP
(IPPROTO_MPTCP), falling back to plain =
TCP if the kernel lacks MPTCP
support=2E The flag lives in sockflags and on=
ly the TCP path honors it,
so in a multisocket setup only the TCP --local e=
ntries become MPTCP=2E
The SOCKS control connection and the management inte=
rface stay plain
TCP=2E IPPROTO_MPTCP is defined when the libc headers lack=
 it
(glibc < 2=2E32)=2E

MPTCP rejects IP(V6)_MTU_DISCOVER and IP(V6)_RECVE=
RR with EOPNOTSUPP,
so that error is ignored on MPTCP sockets: a connection=
 that fell back
to plain TCP during the handshake still gets these options,=
 and
--mtu-disc has no effect on a real MPTCP connection=2E

The kernel ovp=
n module cannot attach to an MPTCP socket, so --mptcp
disables data channel=
 offload when a TCP transport is used=2E

Change-Id: I81fffc46c574cda873eba=
8864444e5c9972549f5
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbi=
t=2Ecom>
---
M doc/man-sections/link-options=2Erst
M src/openvpn/dco=2Ec
M =
src/openvpn/manage=2Ec
M src/openvpn/mtu=2Ec
M src/openvpn/options=2Ec
M sr=
c/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M src/openvpn/socket_util=2Eh=

M src/openvpn/syshead=2Eh
9 files changed, 107 insertions(+), 16 deletions=
(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/2=
5/2225/1

diff --git a/doc/man-sections/link-options=2Erst b/doc/man-sectio=
ns/link-options=2Erst
index bbdcf7f=2E=2Effc8fdd 100644
--- a/doc/man-secti=
ons/link-options=2Erst
+++ b/doc/man-sections/link-options=2Erst
@@ -146,6 =
+146,21 @@
   (:code:`p2p`)=2E OpenVPN 2=2E0 introduces a new mode (:code:`=
server`) which
   implements a multi-client server capability=2E
 
+--mptcp=

+  Create the TCP transport sockets as Multipath TCP (MPTCP) sockets=2E UD=
P
+  sockets are not affected, so in a multisocket setup only the TCP
+  ``=
--local`` entries use MPTCP=2E An MPTCP listening socket still accepts
+  p=
lain TCP clients=2E
+
+  Additional subflows require MPTCP endpoints to be =
configured in the
+  kernel (``ip mptcp endpoint``); without them the conne=
ction uses a
+  single subflow=2E
+
+  This option is only supported on Lin=
ux=2E If an MPTCP socket cannot be
+  created, OpenVPN logs a warning and f=
alls back to plain TCP=2E ``--mptcp``
+  disables data channel offload, and=
 ``--mtu-disc`` has no effect on MPTCP
+  connections=2E
+
 --mssfix args
 =

   Valid syntax:
diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
in=
dex 236be93=2E=2Ed5e89a7 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn=
/dco=2Ec
@@ -255,8 +255,26 @@
 }
 
 static bool
-dco_check_option_ce(const =
struct connection_entry *ce, msglvl_t msglevel, int mode)
+dco_check_option=
_ce(const struct connection_entry *ce, msglvl_t msglevel, int mode,
+      =
              unsigned int sockflags)
 {
+#if defined(TARGET_LINUX)
+    /*=
 the kernel ovpn module cannot attach to an MPTCP socket */
+    if (sockfl=
ags & SF_MPTCP)
+    {
+        bool tcp =3D !proto_is_dgram(ce->proto);
+ =
       for (int i =3D 0; ce->local_list && i < ce->local_list->len; i++)
+ =
       {
+            tcp =3D tcp || !proto_is_dgram(ce->local_list->array[=
i]->proto);
+        }
+        if (tcp)
+        {
+            msg(msglev=
el, "Note: --mptcp disables data channel offload=2E");
+            return =
false;
+        }
+    }
+#endif
+
     if (ce->fragment)
     {
         m=
sg(msglevel, "Note: --fragment disables data channel offload=2E");
@@ -356,=
7 +374,7 @@
         const struct connection_list *l =3D o->connection_list=
;
         for (int i =3D 0; i < l->len; ++i)
         {
-            if (!=
dco_check_option_ce(l->array[i], msglevel, o->mode))
+            if (!dco_=
check_option_ce(l->array[i], msglevel, o->mode, o->sockflags))
            =
 {
                 return false;
             }
@@ -364,7 +382,7 @@
     }=

     else
     {
-        if (!dco_check_option_ce(&o->ce, msglevel, o->mo=
de))
+        if (!dco_check_option_ce(&o->ce, msglevel, o->mode, o->sockfl=
ags))
         {
             return false;
         }
diff --git a/src/ope=
nvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 86c498e=2E=2E4984c4a 100644
=
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2103,7 +2103,=
7 @@
         else
 #endif
         {
-            man->connection=2Esd_top=
 =3D create_socket_tcp(man->settings=2Elocal);
+            man->connection=
=2Esd_top =3D create_socket_tcp(man->settings=2Elocal, 0);
             soc=
ket_bind(man->connection=2Esd_top, man->settings=2Elocal, man->settings=2El=
ocal->ai_family,
                         "MANAGEMENT", false);
         }
=
@@ -2184,7 +2184,7 @@
     else
 #endif
     {
-        man->connection=2Es=
d_cli =3D create_socket_tcp(man->settings=2Elocal);
+        man->connectio=
n=2Esd_cli =3D create_socket_tcp(man->settings=2Elocal, 0);
         status=
 =3D openvpn_connect(man->connection=2Esd_cli, man->settings=2Elocal->ai_ad=
dr, 5,
                                  &signal_received);
     }
diff --g=
it a/src/openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec
index 7892935=2E=2E6f4dc08 1=
00644
--- a/src/openvpn/mtu=2Ec
+++ b/src/openvpn/mtu=2Ec
@@ -31,6 +31,7 @@=

 #include "error=2Eh"
 #include "integer=2Eh"
 #include "mtu=2Eh"
+#includ=
e "socket_util=2Eh"
 #include "options=2Eh"
 #include "crypto=2Eh"
 
@@ -22=
2,7 +223,8 @@
 #if defined(IP_MTU_DISCOVER)
             case AF_INET:
    =
             if (setsockopt(sd, IPPROTO_IP, IP_MTU_DISCOVER, (void *)&mtu_t=
ype,
-                               sizeof(mtu_type)))
+                  =
             sizeof(mtu_type))
+                    && !(openvpn_errno() =
=3D=3D EOPNOTSUPP && socket_is_mptcp(sd)))
                 {
             =
        msg(M_ERR, "Error setting IP_MTU_DISCOVER type=3D%d on TCP/UDP sock=
et", mtu_type);
                 }
@@ -232,7 +234,8 @@
 #if defined(IPV6_MT=
U_DISCOVER)
             case AF_INET6:
                 if (setsockopt(sd,=
 IPPROTO_IPV6, IPV6_MTU_DISCOVER, (void *)&mtu_type,
-                     =
          sizeof(mtu_type)))
+                               sizeof(mtu_typ=
e))
+                    && !(openvpn_errno() =3D=3D EOPNOTSUPP && socket_i=
s_mptcp(sd)))
                 {
                     msg(M_ERR, "Error set=
ting IPV6_MTU_DISCOVER type=3D%d on TCP6/UDP6 socket",
                    =
     mtu_type);
@@ -399,7 +402,8 @@
     /* see "man 7 ip" (on Linux)
     =
 * this works on IPv4 and IPv6(-dual-stack) sockets (v4-mapped)
      */
- =
   if (setsockopt(sd, SOL_IP, IP_RECVERR, (void *)&on, sizeof(on)) !=3D 0)
=
+    if (setsockopt(sd, SOL_IP, IP_RECVERR, (void *)&on, sizeof(on)) !=3D 0=

+        && !(openvpn_errno() =3D=3D EOPNOTSUPP && socket_is_mptcp(sd)))
 =
    {
         msg(M_WARN | M_ERRNO,
             "Note: enable extended er=
ror passing on TCP/UDP socket failed (IP_RECVERR)");
@@ -408,7 +412,8 @@
  =
    * this only works on IPv6 sockets
      */
     if (proto_af =3D=3D AF_=
INET6
-        && setsockopt(sd, IPPROTO_IPV6, IPV6_RECVERR, (void *)&on, s=
izeof(on)) !=3D 0)
+        && setsockopt(sd, IPPROTO_IPV6, IPV6_RECVERR, (=
void *)&on, sizeof(on)) !=3D 0
+        && !(openvpn_errno() =3D=3D EOPNOTS=
UPP && socket_is_mptcp(sd)))
     {
         msg(M_WARN | M_ERRNO,
        =
     "Note: enable extended error passing on TCP/UDP socket failed (IPV6_RE=
CVERR)");
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
in=
dex 947439d=2E=2E0bbfa03 100644
--- a/src/openvpn/options=2Ec
+++ b/src/ope=
nvpn/options=2Ec
@@ -332,6 +332,7 @@
     "--bind-dev dev  : Bind to the gi=
ven device when making connection to a peer or\n"
     "                  l=
istening for connections=2E This allows sending encrypted packets\n"
     "=
                  via a VRF present on the system=2E\n"
+    "--mptcp      =
   : Create the TCP transport sockets as Multipath TCP sockets=2E\n"
 #endi=
f
     "--txqueuelen n  : Set the tun/tap TX queue length to n (Linux only)=
=2E\n"
     "--mlock         : Disable Paging -- ensures key material and t=
unnel\n"
@@ -5530,6 +5531,15 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
=
         options->sockflags |=3D SF_HOST_RANDOMIZE;
     }
+    else if (st=
req(p[0], "mptcp") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERA=
L);
+#if defined(TARGET_LINUX)
+        options->sockflags |=3D SF_MPTCP;
+=
#else
+        msg(M_WARN, "Note: --mptcp is not supported by this build, i=
gnoring");
+#endif
+    }
     else if (streq(p[0], "setenv") && p[1] && !p=
[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/ope=
nvpn/socket=2Ec b/src/openvpn/socket=2Ec
index c07ef60=2E=2E142a85b 100644
=
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -174,15 +174,3=
6 @@
  */
 
 socket_descriptor_t
-create_socket_tcp(struct addrinfo *addrin=
fo)
+create_socket_tcp(struct addrinfo *addrinfo, unsigned int flags)
 {
  =
   socket_descriptor_t sd;
 
     ASSERT(addrinfo);
     ASSERT(addrinfo->a=
i_socktype =3D=3D SOCK_STREAM);
 
-    if ((sd =3D socket(addrinfo->ai_fami=
ly, addrinfo->ai_socktype, addrinfo->ai_protocol))
-        =3D=3D SOCKET_U=
NDEFINED)
+    int protocol =3D addrinfo->ai_protocol;
+
+#if defined(TARGE=
T_LINUX)
+    if (flags & SF_MPTCP)
+    {
+        protocol =3D IPPROTO_MP=
TCP;
+    }
+#endif
+
+    sd =3D socket(addrinfo->ai_family, addrinfo->ai_=
socktype, protocol);
+
+#if defined(TARGET_LINUX)
+    if (sd =3D=3D SOCKET=
_UNDEFINED && protocol =3D=3D IPPROTO_MPTCP
+        && (errno =3D=3D EINVA=
L || errno =3D=3D EPROTONOSUPPORT || errno =3D=3D ENOPROTOOPT))
+    {
+   =
     msg(M_WARN | M_ERRNO,
+            "MPTCP: cannot create MPTCP socket,=
 falling back to plain TCP "
+            "(check kernel support and net=2E=
mptcp=2Eenabled)");
+        sd =3D socket(addrinfo->ai_family, addrinfo->a=
i_socktype, addrinfo->ai_protocol);
+    }
+#endif
+
+    if (sd =3D=3D SOC=
KET_UNDEFINED)
     {
         msg(M_ERR, "Cannot create TCP socket");
    =
 }
@@ -354,13 +375,13 @@
             struct addrinfo addrinfo_tmp =3D *add=
r;
             addrinfo_tmp=2Eai_socktype =3D SOCK_STREAM;
             ad=
drinfo_tmp=2Eai_protocol =3D IPPROTO_TCP;
-            sock->ctrl_sd =3D cr=
eate_socket_tcp(&addrinfo_tmp);
+            sock->ctrl_sd =3D create_socke=
t_tcp(&addrinfo_tmp, 0);
             bind_local(sock);
         }
     }
 =
    else if (addr->ai_protocol =3D=3D IPPROTO_TCP || addr->ai_socktype =3D=
=3D SOCK_STREAM)
     {
-        sock->sd =3D create_socket_tcp(addr);
+   =
     sock->sd =3D create_socket_tcp(addr, sock->sockflags);
         socket=
_apply_options(sock->sd, &sock->socket_buffer_sizes, sock->mark, sock->bind=
_dev);
         bind_local(sock);
     }
@@ -1240,7 +1261,7 @@
         if =
(proxy_retry)
         {
             openvpn_close_socket(sock->sd);
-    =
        sock->sd =3D create_socket_tcp(sock->info=2Elsa->current_remote);
+=
            sock->sd =3D create_socket_tcp(sock->info=2Elsa->current_remote=
, sock->sockflags);
         }
 
     } while (proxy_retry);
diff --git a/s=
rc/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index 2210bfe=2E=2E48de3e0 1=
00644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -204,6 +=
204,7 @@
 #define SF_DCO_WIN           (1 << 5)
 #define SF_PREPEND_SA     =
   (1 << 6)
 #define SF_PKTINFO_COPY_IIF  (1 << 7)
+#define SF_MPTCP       =
      (1 << 8)
     unsigned int sockflags;
     int mark;
     const char =
*bind_dev;
@@ -395,7 +396,7 @@
  * Low-level functions
  */
 
-socket_descr=
iptor_t create_socket_tcp(struct addrinfo *);
+socket_descriptor_t create_s=
ocket_tcp(struct addrinfo *, unsigned int flags);
 
 /**
  * Create a UDP s=
ocket for @p af set up the way a link socket is: --sndbuf/--rcvbuf,
diff --=
git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh
index a1a61=
af=2E=2E7575cf8 100644
--- a/src/openvpn/socket_util=2Eh
+++ b/src/openvpn/=
socket_util=2Eh
@@ -180,6 +180,23 @@
     return proto =3D=3D PROTO_TCP_CLI=
ENT || proto =3D=3D PROTO_TCP_SERVER;
 }
 
+/**
+ * @brief Returns true if =
the socket is an MPTCP socket
+ */
+static inline bool
+socket_is_mptcp(soc=
ket_descriptor_t sd)
+{
+#if defined(TARGET_LINUX)
+    int protocol =3D 0;=

+    socklen_t len =3D sizeof(protocol);
+
+    return getsockopt(sd, SOL_=
SOCKET, SO_PROTOCOL, &protocol, &len) =3D=3D 0
+           && protocol =3D=
=3D IPPROTO_MPTCP;
+#else
+    return false;
+#endif
+}
+
 int ascii2proto(=
const char *proto_name);
 
 sa_family_t ascii2af(const char *proto_name);
d=
iff --git a/src/openvpn/syshead=2Eh b/src/openvpn/syshead=2Eh
index 8f27436=
=2E=2E12741f1 100644
--- a/src/openvpn/syshead=2Eh
+++ b/src/openvpn/syshea=
d=2Eh
@@ -398,6 +398,10 @@
 #define SOL_IP IPPROTO_IP
 #endif
 
+#if define=
d(TARGET_LINUX) && !defined(IPPROTO_MPTCP)
+#define IPPROTO_MPTCP 262
+#end=
if
+
 /*
  * Define type sa_family_t if it isn't defined in the socket head=
ers
  */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/222=
5?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchan=
ge
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I81fffc4=
6c574cda873eba8864444e5c9972549f5
Gerrit-Change-Number: 2225
Gerrit-PatchSe=
t: 1
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>

--Vl0QiONRuZI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2225?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">Add --mptcp option for Multipath TCP transport on Linux=
<br><br>With --mptcp, the TCP transport socket is created as Multipath TCP<=
br>(IPPROTO_MPTCP), falling back to plain TCP if the kernel lacks MPTCP<br>=
support=2E The flag lives in sockflags and only the TCP path honors it,<br>=
so in a multisocket setup only the TCP --local entries become MPTCP=2E<br>T=
he SOCKS control connection and the management interface stay plain<br>TCP=
=2E IPPROTO_MPTCP is defined when the libc headers lack it<br>(glibc &lt; 2=
=2E32)=2E<br><br>MPTCP rejects IP(V6)_MTU_DISCOVER and IP(V6)_RECVERR with =
EOPNOTSUPP,<br>so that error is ignored on MPTCP sockets: a connection that=
 fell back<br>to plain TCP during the handshake still gets these options, a=
nd<br>--mtu-disc has no effect on a real MPTCP connection=2E<br><br>The ker=
nel ovpn module cannot attach to an MPTCP socket, so --mptcp<br>disables da=
ta channel offload when a TCP transport is used=2E<br><br>Change-Id: I81fff=
c46c574cda873eba8864444e5c9972549f5<br>Signed-off-by: Gianmarco De Gregori =
&lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M doc/man-sections/link-options=
=2Erst<br>M src/openvpn/dco=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvp=
n/mtu=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/socket=2Ec<br>M src=
/openvpn/socket=2Eh<br>M src/openvpn/socket_util=2Eh<br>M src/openvpn/syshe=
ad=2Eh<br>9 files changed, 107 insertions(+), 16 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/25/2225/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/doc/man-sections/link-options=2Erst b/do=
c/man-sections/link-options=2Erst</span><br><span>index bbdcf7f=2E=2Effc8fd=
d 100644</span><br><span>--- a/doc/man-sections/link-options=2Erst</span><b=
r><span>+++ b/doc/man-sections/link-options=2Erst</span><br><span>@@ -146,6=
 +146,21 @@</span><br><span>   (:code:`p2p`)=2E OpenVPN 2=2E0 introduces a =
new mode (:code:`server`) which</span><br><span>   implements a multi-clien=
t server capability=2E</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+--mptcp</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  Create the TCP transport sockets as Multipath TCP (MPTCP) socket=
s=2E UDP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  sockets a=
re not affected, so in a multisocket setup only the TCP</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  ``--local`` entries use MPTCP=2E An M=
PTCP listening socket still accepts</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  plain TCP clients=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  Additional subflows require MPTCP endpoints to be configured in the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  kernel (``ip mptcp endp=
oint``); without them the connection uses a</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  single subflow=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  This option is only supported on Linux=2E If an MPTCP socket cannot =
be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  created, OpenVP=
N logs a warning and falls back to plain TCP=2E ``--mptcp``</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  disables data channel offload, an=
d ``--mtu-disc`` has no effect on MPTCP</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  connections=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> --mssfix args</span><br><span> </span><b=
r><span>   Valid syntax:</span><br><span>diff --git a/src/openvpn/dco=2Ec b=
/src/openvpn/dco=2Ec</span><br><span>index 236be93=2E=2Ed5e89a7 100644</spa=
n><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=
=2Ec</span><br><span>@@ -255,8 +255,26 @@</span><br><span> }</span><br><spa=
n> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-dco_check_option_ce(const struct connection_entry *ce, msglvl_t =
msglevel, int mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
dco_check_option_ce(const struct connection_entry *ce, msglvl_t msglevel, i=
nt mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         unsigned int sockflags)</span><br><span> {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* the kernel ovpn module canno=
t attach to an MPTCP socket */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (sockflags &amp; SF_MPTCP)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        bool tcp =3D !proto_is_dgram(ce-&gt;proto);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; ce-&gt=
;local_list &amp;&amp; i &lt; ce-&gt;local_list-&gt;len; i++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            tcp =3D tcp || !proto_is_dgra=
m(ce-&gt;local_list-&gt;array[i]-&gt;proto);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (tcp)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(msglevel, &quot;Note: --mptcp disables data channel offlo=
ad=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (ce-&gt;frag=
ment)</span><br><span>     {</span><br><span>         msg(msglevel, &quot;N=
ote: --fragment disables data channel offload=2E&quot;);</span><br><span>@@=
 -356,7 +374,7 @@</span><br><span>         const struct connection_list *l =
=3D o-&gt;connection_list;</span><br><span>         for (int i =3D 0; i &lt=
; l-&gt;len; ++i)</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            if (!dco_check_option_ce(l-&gt;array[i],=
 msglevel, o-&gt;mode))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (!dco_check_option_ce(l-&gt;array[i], msglevel, o-&gt;mo=
de, o-&gt;sockflags))</span><br><span>             {</span><br><span>      =
           return false;</span><br><span>             }</span><br><span>@@ =
-364,7 +382,7 @@</span><br><span>     }</span><br><span>     else</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (!dco_check_option_ce(&amp;o-&gt;ce, msglevel, o-&gt;mode))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (!dco_check_option_ce=
(&amp;o-&gt;ce, msglevel, o-&gt;mode, o-&gt;sockflags))</span><br><span>   =
      {</span><br><span>             return false;</span><br><span>        =
 }</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=
=2Ec</span><br><span>index 86c498e=2E=2E4984c4a 100644</span><br><span>--- =
a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span=
><br><span>@@ -2103,7 +2103,7 @@</span><br><span>         else</span><br><s=
pan> #endif</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            man-&gt;connection=2Esd_top =3D create_socket_=
tcp(man-&gt;settings=2Elocal);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            man-&gt;connection=2Esd_top =3D create_socket_tcp(ma=
n-&gt;settings=2Elocal, 0);</span><br><span>             socket_bind(man-&g=
t;connection=2Esd_top, man-&gt;settings=2Elocal, man-&gt;settings=2Elocal-&=
gt;ai_family,</span><br><span>                         &quot;MANAGEMENT&quo=
t;, false);</span><br><span>         }</span><br><span>@@ -2184,7 +2184,7 @=
@</span><br><span>     else</span><br><span> #endif</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        man-&gt;connec=
tion=2Esd_cli =3D create_socket_tcp(man-&gt;settings=2Elocal);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        man-&gt;connection=2Esd_=
cli =3D create_socket_tcp(man-&gt;settings=2Elocal, 0);</span><br><span>   =
      status =3D openvpn_connect(man-&gt;connection=2Esd_cli, man-&gt;setti=
ngs=2Elocal-&gt;ai_addr, 5,</span><br><span>                               =
   &amp;signal_received);</span><br><span>     }</span><br><span>diff --git=
 a/src/openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec</span><br><span>index 7892935=
=2E=2E6f4dc08 100644</span><br><span>--- a/src/openvpn/mtu=2Ec</span><br><s=
pan>+++ b/src/openvpn/mtu=2Ec</span><br><span>@@ -31,6 +31,7 @@</span><br><=
span> #include &quot;error=2Eh&quot;</span><br><span> #include &quot;intege=
r=2Eh&quot;</span><br><span> #include &quot;mtu=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket_util=2Eh&quot;<=
/span><br><span> #include &quot;options=2Eh&quot;</span><br><span> #include=
 &quot;crypto=2Eh&quot;</span><br><span> </span><br><span>@@ -222,7 +223,8 =
@@</span><br><span> #if defined(IP_MTU_DISCOVER)</span><br><span>          =
   case AF_INET:</span><br><span>                 if (setsockopt(sd, IPPROT=
O_IP, IP_MTU_DISCOVER, (void *)&amp;mtu_type,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                               sizeof(mtu_type)))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
          sizeof(mtu_type))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    &amp;&amp; !(openvpn_errno() =3D=3D EOPNOTSUPP =
&amp;&amp; socket_is_mptcp(sd)))</span><br><span>                 {</span><=
br><span>                     msg(M_ERR, &quot;Error setting IP_MTU_DISCOVE=
R type=3D%d on TCP/UDP socket&quot;, mtu_type);</span><br><span>           =
      }</span><br><span>@@ -232,7 +234,8 @@</span><br><span> #if defined(IP=
V6_MTU_DISCOVER)</span><br><span>             case AF_INET6:</span><br><spa=
n>                 if (setsockopt(sd, IPPROTO_IPV6, IPV6_MTU_DISCOVER, (voi=
d *)&amp;mtu_type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                            sizeof(mtu_type)))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                               sizeof(mtu_type))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 &amp;&amp; !(openvpn_errno() =3D=3D EOPNOTSUPP &amp;&amp; socket_is_mptcp(=
sd)))</span><br><span>                 {</span><br><span>                  =
   msg(M_ERR, &quot;Error setting IPV6_MTU_DISCOVER type=3D%d on TCP6/UDP6 =
socket&quot;,</span><br><span>                         mtu_type);</span><br=
><span>@@ -399,7 +402,8 @@</span><br><span>     /* see &quot;man 7 ip&quot;=
 (on Linux)</span><br><span>      * this works on IPv4 and IPv6(-dual-stack=
) sockets (v4-mapped)</span><br><span>      */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (setsockopt(sd, SOL_IP, IP_RECVERR, (void *=
)&amp;on, sizeof(on)) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (setsockopt(sd, SOL_IP, IP_RECVERR, (void *)&amp;on, sizeo=
f(on)) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  &amp;&amp; !(openvpn_errno() =3D=3D EOPNOTSUPP &amp;&amp; socket_is_mptcp=
(sd)))</span><br><span>     {</span><br><span>         msg(M_WARN | M_ERRNO=
,</span><br><span>             &quot;Note: enable extended error passing on=
 TCP/UDP socket failed (IP_RECVERR)&quot;);</span><br><span>@@ -408,7 +412,=
8 @@</span><br><span>      * this only works on IPv6 sockets</span><br><spa=
n>      */</span><br><span>     if (proto_af =3D=3D AF_INET6</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; setsockopt(sd, IP=
PROTO_IPV6, IPV6_RECVERR, (void *)&amp;on, sizeof(on)) !=3D 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; setsockopt(sd=
, IPPROTO_IPV6, IPV6_RECVERR, (void *)&amp;on, sizeof(on)) !=3D 0</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !(openvpn_=
errno() =3D=3D EOPNOTSUPP &amp;&amp; socket_is_mptcp(sd)))</span><br><span>=
     {</span><br><span>         msg(M_WARN | M_ERRNO,</span><br><span>     =
        &quot;Note: enable extended error passing on TCP/UDP socket failed =
(IPV6_RECVERR)&quot;);</span><br><span>diff --git a/src/openvpn/options=2Ec=
 b/src/openvpn/options=2Ec</span><br><span>index 947439d=2E=2E0bbfa03 10064=
4</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/o=
penvpn/options=2Ec</span><br><span>@@ -332,6 +332,7 @@</span><br><span>    =
 &quot;--bind-dev dev  : Bind to the given device when making connection to=
 a peer or\n&quot;</span><br><span>     &quot;                  listening f=
or connections=2E This allows sending encrypted packets\n&quot;</span><br><=
span>     &quot;                  via a VRF present on the system=2E\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--mptcp =
        : Create the TCP transport sockets as Multipath TCP sockets=2E\n&qu=
ot;</span><br><span> #endif</span><br><span>     &quot;--txqueuelen n  : Se=
t the tun/tap TX queue length to n (Linux only)=2E\n&quot;</span><br><span>=
     &quot;--mlock         : Disable Paging -- ensures key material and tun=
nel\n&quot;</span><br><span>@@ -5530,6 +5531,15 @@</span><br><span>        =
 VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         options-&gt;soc=
kflags |=3D SF_HOST_RANDOMIZE;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;mptcp&quot=
;) &amp;&amp; !p[1])</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIF=
Y_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        options-&gt;sockflags |=3D SF_MPTCP;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Note: --mptcp is not su=
pported by this build, ignoring&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span>     else if (streq(p[0], &quot;setenv&quot;) =
&amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>  =
       VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>diff --git a/src/o=
penvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index c07ef60=2E=
=2E142a85b 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><s=
pan>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -174,15 +174,36 @@</spa=
n><br><span>  */</span><br><span> </span><br><span> socket_descriptor_t</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-create_socket_tcp(struct =
addrinfo *addrinfo)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
create_socket_tcp(struct addrinfo *addrinfo, unsigned int flags)</span><br>=
<span> {</span><br><span>     socket_descriptor_t sd;</span><br><span> </sp=
an><br><span>     ASSERT(addrinfo);</span><br><span>     ASSERT(addrinfo-&g=
t;ai_socktype =3D=3D SOCK_STREAM);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if ((sd =3D socket(addrinfo-&gt;ai_fami=
ly, addrinfo-&gt;ai_socktype, addrinfo-&gt;ai_protocol))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        =3D=3D SOCKET_UNDEFINED)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int protocol =3D addrin=
fo-&gt;ai_protocol;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_=
LINUX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags=
 &amp; SF_MPTCP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        protocol =
=3D IPPROTO_MPTCP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    sd =3D socket(addrinfo-&gt;ai_family, addri=
nfo-&gt;ai_socktype, protocol);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (sd =3D=3D SOCKET_UNDEFINED &amp;&amp; protocol =3D=3D IPPROTO_MPTCP<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; (=
errno =3D=3D EINVAL || errno =3D=3D EPROTONOSUPPORT || errno =3D=3D ENOPROT=
OOPT))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRN=
O,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot=
;MPTCP: cannot create MPTCP socket, falling back to plain TCP &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;(check k=
ernel support and net=2Emptcp=2Eenabled)&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        sd =3D socket(addrinfo-&gt;ai_family, =
addrinfo-&gt;ai_socktype, addrinfo-&gt;ai_protocol);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sd =
=3D=3D SOCKET_UNDEFINED)</span><br><span>     {</span><br><span>         ms=
g(M_ERR, &quot;Cannot create TCP socket&quot;);</span><br><span>     }</spa=
n><br><span>@@ -354,13 +375,13 @@</span><br><span>             struct addri=
nfo addrinfo_tmp =3D *addr;</span><br><span>             addrinfo_tmp=2Eai_=
socktype =3D SOCK_STREAM;</span><br><span>             addrinfo_tmp=2Eai_pr=
otocol =3D IPPROTO_TCP;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            sock-&gt;ctrl_sd =3D create_socket_tcp(&amp;addrinfo_tmp);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            sock-&gt;c=
trl_sd =3D create_socket_tcp(&amp;addrinfo_tmp, 0);</span><br><span>       =
      bind_local(sock);</span><br><span>         }</span><br><span>     }</=
span><br><span>     else if (addr-&gt;ai_protocol =3D=3D IPPROTO_TCP || add=
r-&gt;ai_socktype =3D=3D SOCK_STREAM)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;sd =3D create_socke=
t_tcp(addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 sock-&gt;sd =3D create_socket_tcp(addr, sock-&gt;sockflags);</span><br><sp=
an>         socket_apply_options(sock-&gt;sd, &amp;sock-&gt;socket_buffer_s=
izes, sock-&gt;mark, sock-&gt;bind_dev);</span><br><span>         bind_loca=
l(sock);</span><br><span>     }</span><br><span>@@ -1240,7 +1261,7 @@</span=
><br><span>         if (proxy_retry)</span><br><span>         {</span><br><=
span>             openvpn_close_socket(sock-&gt;sd);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            sock-&gt;sd =3D create_socket_t=
cp(sock-&gt;info=2Elsa-&gt;current_remote);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            sock-&gt;sd =3D create_socket_tcp(sock-=
&gt;info=2Elsa-&gt;current_remote, sock-&gt;sockflags);</span><br><span>   =
      }</span><br><span> </span><br><span>     } while (proxy_retry);</span=
><br><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</sp=
an><br><span>index 2210bfe=2E=2E48de3e0 100644</span><br><span>--- a/src/op=
envpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><sp=
an>@@ -204,6 +204,7 @@</span><br><span> #define SF_DCO_WIN           (1 &lt=
;&lt; 5)</span><br><span> #define SF_PREPEND_SA        (1 &lt;&lt; 6)</span=
><br><span> #define SF_PKTINFO_COPY_IIF  (1 &lt;&lt; 7)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define SF_MPTCP             (1 &lt;&lt=
; 8)</span><br><span>     unsigned int sockflags;</span><br><span>     int =
mark;</span><br><span>     const char *bind_dev;</span><br><span>@@ -395,7 =
+396,7 @@</span><br><span>  * Low-level functions</span><br><span>  */</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-socket_d=
escriptor_t create_socket_tcp(struct addrinfo *);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+socket_descriptor_t create_socket_tcp(struct =
addrinfo *, unsigned int flags);</span><br><span> </span><br><span> /**</sp=
an><br><span>  * Create a UDP socket for @p af set up the way a link socket=
 is: --sndbuf/--rcvbuf,</span><br><span>diff --git a/src/openvpn/socket_uti=
l=2Eh b/src/openvpn/socket_util=2Eh</span><br><span>index a1a61af=2E=2E7575=
cf8 100644</span><br><span>--- a/src/openvpn/socket_util=2Eh</span><br><spa=
n>+++ b/src/openvpn/socket_util=2Eh</span><br><span>@@ -180,6 +180,23 @@</s=
pan><br><span>     return proto =3D=3D PROTO_TCP_CLIENT || proto =3D=3D PRO=
TO_TCP_SERVER;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @brief Returns true if the socket is an MPTCP socket</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+socket_is_mptcp(socket_descriptor_t sd=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int protocol =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    socklen_t len =3D size=
of(protocol);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return getsockopt(sd,=
 SOL_SOCKET, SO_PROTOCOL, &amp;protocol, &amp;len) =3D=3D 0</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; protocol =3D=
=3D IPPROTO_MPTCP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> int ascii2proto(const char *pr=
oto_name);</span><br><span> </span><br><span> sa_family_t ascii2af(const ch=
ar *proto_name);</span><br><span>diff --git a/src/openvpn/syshead=2Eh b/src=
/openvpn/syshead=2Eh</span><br><span>index 8f27436=2E=2E12741f1 100644</spa=
n><br><span>--- a/src/openvpn/syshead=2Eh</span><br><span>+++ b/src/openvpn=
/syshead=2Eh</span><br><span>@@ -398,6 +398,10 @@</span><br><span> #define =
SOL_IP IPPROTO_IP</span><br><span> #endif</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) &amp;&amp=
; !defined(IPPROTO_MPTCP)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define IPPROTO_MPTCP 262</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> /*</span><br><span>  * Define type sa_family_t if it isn&#=
39;t defined in the socket headers</span><br><span>  */</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2225?u=
sp=3Demail">change 2225</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2225?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I81fffc46c574cda873eba8864444e5c9972549f5 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2225 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>

</body></html>
--Vl0QiONRuZI=--


--===============2952750108810730488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2952750108810730488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2952750108810730488==--

