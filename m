Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7634CC531CC
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 17:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+CkCJkGw/e7lxogPg3cDakDM/fttrJnh8TVogXWQhEI=; b=VpAjojmxcGJXvz6rlo5CAF5qa8
	nRUKWm9XHjmYa6xd7TQ3+zpn8JtsMEqe8GR82ftB/F/oNfSGFHHw17rSrVHvdK92Xa8RsSerGBPG6
	fEWK3Fr4NhrLFq3CMoZ7/jXkp8Vl9nBanxwdRV+CArQij/mBFFS05wF6zPUJKMPMizXw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmxdr-00057S-4a;
	Thu, 23 Jul 2026 17:55:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmxdp-000571-OM
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 17:55:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rMkdFPagVFjHw92o0JGW4ft6HNqWasNmH4K75mmRGKE=; b=K6NhkvQmBW9X+1BKg+6pgyasSe
 JJOW0Gd8kGlkZK4Hnk9U62FwWjk3xRRjlN9s4ncv/YUBkOdyW9T8S6+lOLh7zNcnKTulWpu+1kuV9
 BK+2eQtyujSncwIxVpycCnJiW09ojRJme7mChWn01Bg602kZu7+0OKNFXWQudjFCpb8A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rMkdFPagVFjHw92o0JGW4ft6HNqWasNmH4K75mmRGKE=; b=A
 8kO2UrKg4w0LltVQXNtShiNt8F7sB50oOw9NBHUkqN7Krh8EOp7f7s8qi2iWCbEixsLpaxiyOWSN/
 TSkc0FDqHDNYL87Vhwla0K4/poj041P/CsIGV3mpVJs2+OwHSx/QivdRINjD7WLq9Sxp5pnZRgZtz
 PT5iD8XjrVWH8omI=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmxdO-00067o-VD for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 17:55:04 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so7311675e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784829296; x=1785434096; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rMkdFPagVFjHw92o0JGW4ft6HNqWasNmH4K75mmRGKE=;
 b=DBMk7wpGtGmU3A5SPP1glzorTCeUsfRiHTsn4tFbyrijEL1eFQWR032t+6Qb2HA2gY
 HXDtMWlSjt4b+VDWZ/NWyThcpLODPUFxeLDdsKW6cjtIRjyDA0TpqtIlvT557Ww2x/1D
 SWCMVq7syWr0aiVy9wCJ4mSNhMptbgc9nSGmbTqu1/QkJ0EX2pP6ZPi0bFNNbZRNGCNo
 Znq+ZtTxYTJ2R+ljlZKh6HYEnW7svHkmIf1kzLBdBkNMBYcjNaFIQcjVItLCbAbyd6Pk
 ZmG1TTLNkm3jeZPysR1oJNVOpk7L0gamHDr1VffFR4St0/q6lPX7KtPof/znXrvPYoaj
 KhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784829296; x=1785434096;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rMkdFPagVFjHw92o0JGW4ft6HNqWasNmH4K75mmRGKE=;
 b=FiNHyf6hvcnUtbEwplSgNOlj5T83xrN6daATBnNZF14kQ4dEm+ljxyjDRMjLyjArYV
 W+405/vxg5eeeD0HlvikZiLrVrE/RH4iMD97poKRYOZuS33PdPwSbFGublogZjNN8MjR
 JeWnR3vkhsNrs5L3Rsp5IUs1z3KnAv+DUkHb+gpw8sJyXs9mhUIZEm7fFzgxSaZwERNG
 Qsmczb8rzAnrQ5ZibLIRwu1qYwLteZLU3iAlmQ7Pq4feO759zWv9hSAahLvro6lSbEdt
 ha0y8tjHSzEZn/6csCbtx4BmWlbNyoaXt5Uvx1Cq/z7i1UHUw+q7cw10JQrD4RykSc13
 UOIw==
X-Gm-Message-State: AOJu0Yw+54RiTY3tqnffL9toHpjMYcZlZpl59syZUAeIeO8gCmD7zdEE
 wp5SSGXBYkL/YYsH4DeqPaB/nK8xfu6QGy3Gi7WPlXsnXlRIqEx0H8Owq2EwN5f8IsGvPHZph/1
 qS9k+EBLs2yOKRsWDUlBuQlBysEb4RLltNOwnyPFW4aQuGZ6j15Sp3ppWeytd0TSazfai
X-Gm-Gg: AR+sD11Z7gm2Q9qLBUUz9GEsB4EL8VNDF1Nyx2MDVDRJv8gOohGEjTdvXsrDZXuKBI/
 KRIjzVGLeVPzTUtswCiuEAcVKmxCmMt6ROQLx1C6cjCGZPhgpJwdzlBRjFIG1qi3DmSd1zqsE3U
 m063NLIJwowKZ/M9SY1weIXKQkx+caNJfADyEbHlr42nOIgTIFm80dRvd8oMSg1gkvuis9h2BGL
 RdVv7xXav+LdvlyYISHSCIY5dSPkO6l9mtjtvfokobXFGonMGaRSurp0+twIECIKYsonkjplm16
 f89t+gCFtTIcTSZAPxmH7GU1Y34c3P021wnxh5P7kQBVCar038SiCN2hSX30rXUcBAuIFC57J5l
 jnt2oWQ7HDoQmo0dd39ZkSXUf9hdoKjvp2vSMNNBLECGth+zR1m2BQ/mDJe+j45pCm3bXmGc3zi
 5X5EA2Ef9VwQyom7IFw76L1eEFNrJ9McI3AntnsDeqzGu2Vn3B/09uoTpCxvjMOLJXdqBIyYgD4
 /LBpl9T3nvnnlxBncr4fW4+UUDxpRg9iRWCRKkP76zORzVWuYjUPdlxtMbbd1QTbJeF
X-Received: by 2002:a05:600c:4652:b0:495:4056:9473 with SMTP id
 5b1f17b1804b1-49573d08826mr28154435e9.28.1784829296023; 
 Thu, 23 Jul 2026 10:54:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957afac187sm8634375e9.11.2026.07.23.10.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:54:55 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 17:54:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
X-Gerrit-Change-Number: 1797
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1797?usp=email>
X-Gerrit-Commit: da4ecf990b55d6c19cdc3e01c19b989de26fc88e
In-Reply-To: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
References: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTg2MDY2MDAwLkk0MzRhNTM3M2Y3N2IwZjc1NzBhNmEyYWFmZTBlYWY5NzBlMmVhYmU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7762d723536066d839f599c348129fc7f2315443-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmxdO-00067o-VD
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Enable TCP_NODELAY
 by default and push it to clients
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2230232907757730198=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2230232907757730198==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+WCpcYFVdpo="; charset=UTF-8

--+WCpcYFVdpo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+1 by cron=
2, Code-Review+2 by plaisthos


Change subject: Enable TCP_NODELAY by defau=
lt and push it to clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Enable TCP_NODELAY by default and push it to clients

TCP_NOD=
ELAY had to be requested explicitly via
--tcp-nodelay or "socket-flags TCP_=
NODELAY"=2E Enable
it unconditionally on every TCP socket instead
(dco-win =
is skipped as it manages its own socket)=2E
The socket_set_flags() and
link=
_socket_update_flags() plumbing that only ever
applied it is dropped; the S=
F_TCP_NODELAY sockflag
and "socket-flags TCP_NODELAY" become no-ops, the
la=
tter kept for backwards compatibility=2E

--tcp-nodelay no longer touches t=
he local socket
but, in --mode server, still pushes "socket-flags
TCP_NODEL=
AY" to clients, for the benefit of clients
older than 2=2E7=2E6 that do not=
 enable it by default=2E
On a client the option is deprecated and inert=2E =
It
can be dropped once such clients are gone=2E

Change-Id: I434a5373f77b0f=
7570a6a2aafe0eaf970e2eabe7
Signed-off-by: Antonio Quartulli <antonio@mandel=
bit=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797
Message-Id: <20260721124452=
=2E27832-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg37726=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M doc/man-sections/link-options=2Erst=

M src/openvpn/helper=2Ec
M src/openvpn/init=2Ec
M src/openvpn/options=2Ec
=
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
6 files changed, 29 inser=
tions(+), 81 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/97/1797/4

diff --git a/doc/man-sections/link-options=
=2Erst b/doc/man-sections/link-options=2Erst
index df8c917=2E=2E7c61b67 100=
644
--- a/doc/man-sections/link-options=2Erst
+++ b/doc/man-sections/link-o=
ptions=2Erst
@@ -465,23 +465,20 @@
   trying to group several smaller packe=
ts into a larger packet=2E  This can
   result in a considerably improvemen=
t in latency=2E
 
-  This option is pushable from server to client, and sho=
uld be used on
-  both client and server for maximum effect=2E
+  Since Ope=
nVPN 2=2E7=2E6 :code:`TCP_NODELAY` is enabled by default on every TCP
+  so=
cket, so specifying it here is no longer necessary=2E
 
 --tcp-nodelay
-  T=
his macro sets the :code:`TCP_NODELAY` socket flag on the server as well
- =
 as pushes it to connecting clients=2E The :code:`TCP_NODELAY` flag disable=
s
-  the Nagle algorithm on TCP sockets causing packets to be transmitted
-=
  immediately with low latency, rather than waiting a short period of time
=
-  in order to aggregate several packets into a larger containing packet=2E=

-  In VPN applications over TCP, :code:`TCP_NODELAY` is generally a good
-=
  latency optimization=2E
+  :code:`TCP_NODELAY` is enabled by default on e=
very TCP socket=2E In
+  ``--mode server`` this option additionally pushes
=
+  ``socket-flags TCP_NODELAY`` to connecting clients, so that clients olde=
r
+  than 2=2E7=2E6 get it too=2E The option can be removed once such clien=
ts are no
+  longer in use=2E
 
   The macro expands as follows:
   ::
 
  =
    if mode server:
-         socket-flags TCP_NODELAY
          push "sock=
et-flags TCP_NODELAY"
 
 --max-packet-size size
diff --git a/src/openvpn/he=
lper=2Ec b/src/openvpn/helper=2Ec
index 4c540a6=2E=2E7c186c5 100644
--- a/s=
rc/openvpn/helper=2Ec
+++ b/src/openvpn/helper=2Ec
@@ -99,14 +99,6 @@
     =
return BSTR(&out);
 }
 
-static const char *
-print_str(const char *str, st=
ruct gc_arena *gc)
-{
-    struct buffer out =3D alloc_buf_gc(128, gc);
-  =
  buf_printf(&out, "%s", str);
-    return BSTR(&out);
-}
-
 static void
 h=
elper_add_route(const in_addr_t network, const in_addr_t netmask, struct op=
tions *o)
 {
@@ -597,22 +589,13 @@
  * EXPANDS TO:
  *
  * if mode server:
=
- *   socket-flags TCP_NODELAY
  *   push "socket-flags TCP_NODELAY"
  */
 =
void
 helper_tcp_nodelay(struct options *o)
 {
-    if (o->server_flags & S=
F_TCP_NODELAY_HELPER)
+    if ((o->server_flags & SF_TCP_NODELAY_HELPER) &&=
 o->mode =3D=3D MODE_SERVER)
     {
-        if (o->mode =3D=3D MODE_SERVER=
)
-        {
-            o->sockflags |=3D SF_TCP_NODELAY;
-            pu=
sh_option(o, print_str("socket-flags TCP_NODELAY", &o->gc), M_USAGE);
-    =
    }
-        else
-        {
-            o->sockflags |=3D SF_TCP_NODELA=
Y;
-        }
+        push_option(o, "socket-flags TCP_NODELAY", M_USAGE);=

     }
 }
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index c=
aaa769=2E=2E914d191 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/ini=
t=2Ec
@@ -2650,15 +2650,6 @@
         }
     }
 
-    if (found & OPT_P_SOC=
KFLAGS)
-    {
-        msg(D_PUSH, "OPTIONS IMPORT: --socket-flags option =
modified");
-        for (int i =3D 0; i < c->c1=2Elink_sockets_num; i++)
-=
        {
-            link_socket_update_flags(c->c2=2Elink_sockets[i], c-=
>options=2Esockflags);
-        }
-    }
-
     if (found & OPT_P_PERSIST)
=
     {
         msg(D_PUSH, "OPTIONS IMPORT: --persist options modified");
=
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 242443=
1=2E=2E7460a83 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/optio=
ns=2Ec
@@ -486,8 +486,8 @@
     "                  virtual address table to=
 v=2E\n"
     "--bcast-buffers n : Allocate n broadcast buffers=2E\n"
     =
"--tcp-queue-limit n : Maximum number of queued TCP output packets=2E\n"
- =
   "--tcp-nodelay   : Macro that sets TCP_NODELAY socket flag on the server=
\n"
-    "                  as well as pushes it to connecting clients=2E\n=
"
+    "--tcp-nodelay   : In server mode, push TCP_NODELAY to clients (it i=
s\n"
+    "                  enabled by default on the local socket)=2E\n"
=
     "--learn-address cmd : Run command cmd to validate client virtual addr=
esses=2E\n"
     "--connect-freq n s : Allow a maximum of n new connections=
 per s seconds=2E\n"
     "--connect-freq-initial n s : Allow a maximum of =
n replies for initial connections attempts per s seconds=2E\n"
@@ -2618,6 +=
2618,13 @@
             MUST_BE_UNDEF(vlan_accept, "vlan-accept");
        =
     MUST_BE_UNDEF(vlan_pvid, "vlan-pvid");
         }
+
+        if (optio=
ns->server_flags & SF_TCP_NODELAY_HELPER)
+        {
+            msg(M_INF=
O, "NOTE: TCP_NODELAY is always enabled locally; "
+                       =
 "--tcp-nodelay is now only useful to push the flag to "
+                 =
       "clients older than 2=2E7=2E6=2E");
+        }
     }
     else
    =
 {
@@ -2648,9 +2655,7 @@
         MUST_BE_FALSE(options->ssl_flags & SSLF_A=
UTH_USER_PASS_OPTIONAL, "auth-user-pass-optional");
         if (options->s=
erver_flags & SF_TCP_NODELAY_HELPER)
         {
-            msg(M_WARN, "W=
ARNING: setting tcp-nodelay on the client side will not "
-                =
        "affect the server=2E To have TCP_NODELAY in both direction use "
-=
                        "tcp-nodelay in the server configuration instead=2E=
");
+            msg(M_WARN, "DEPRECATED OPTION: --tcp-nodelay is always en=
abled on clients");
         }
         MUST_BE_UNDEF(auth_user_pass_verify=
_script, "auth-user-pass-verify");
         MUST_BE_UNDEF(auth_token_genera=
te, "auth-gen-token");
@@ -6537,11 +6542,9 @@
         VERIFY_PERMISSION(OP=
T_P_SOCKFLAGS);
         for (j =3D 1; j < MAX_PARMS && p[j]; ++j)
        =
 {
-            if (streq(p[j], "TCP_NODELAY"))
-            {
-           =
     options->sockflags |=3D SF_TCP_NODELAY;
-            }
-            el=
se
+            /* TCP_NODELAY is enabled by default; the flag is still acc=
epted
+             * for backwards compatibility but no longer has any eff=
ect */
+            if (!streq(p[j], "TCP_NODELAY"))
             {
       =
          msg(msglevel, "unknown socket flag: %s", p[j]);
             }
di=
ff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index df2cc9e=2E=
=2Eb73a5df 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec=

@@ -516,34 +516,6 @@
 #endif
 }
 
-static bool
-socket_set_flags(socket_de=
scriptor_t sd, unsigned int sockflags)
-{
-    /* SF_TCP_NODELAY doesn't ma=
ke sense for dco-win */
-    if ((sockflags & SF_TCP_NODELAY) && (!(sockfla=
gs & SF_DCO_WIN)))
-    {
-        return socket_set_tcp_nodelay(sd, 1);
- =
   }
-    else
-    {
-        return true;
-    }
-}
-
-bool
-link_socket_=
update_flags(struct link_socket *sock, unsigned int sockflags)
-{
-    if (=
sock && socket_defined(sock->sd))
-    {
-        sock->sockflags |=3D sock=
flags;
-        return socket_set_flags(sock->sd, sock->sockflags);
-    }
=
-    else
-    {
-        return false;
-    }
-}
-
 void
 link_socket_upda=
te_buffer_sizes(struct link_socket *sock, int rcvbuf, int sndbuf)
 {
@@ -14=
85,8 +1457,12 @@
 static void
 phase2_set_socket_flags(struct link_socket *=
sock)
 {
-    /* set misc socket parameters */
-    socket_set_flags(sock->=
sd, sock->sockflags);
+    /* TCP_NODELAY is enabled by default on every TC=
P socket; dco-win is
+     * skipped as it manages its own socket */
+    i=
f (proto_is_tcp(sock->info=2Eproto) && !(sock->sockflags & SF_DCO_WIN))
+  =
  {
+        socket_set_tcp_nodelay(sock->sd, 1);
+    }
 
     /* set sock=
et to non-blocking mode */
     set_nonblock(sock->sd);
diff --git a/src/op=
envpn/socket=2Eh b/src/openvpn/socket=2Eh
index cd4e8ed=2E=2E5883592 100644=

--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -207,7 +207,7=
 @@
     int mtu; /* OS discovered MTU, or 0 if unknown */
 
 #define SF_US=
E_IP_PKTINFO    (1 << 0)
-#define SF_TCP_NODELAY       (1 << 1)
+#define SF=
_TCP_NODELAY       (1 << 1) /* unused: flag always enabled */
 #define SF_P=
ORT_SHARE        (1 << 2)
 #define SF_HOST_RANDOMIZE    (1 << 3)
 #define S=
F_GETADDRINFO_DGRAM (1 << 4)
@@ -390,8 +390,6 @@
 
 void setenv_trusted(str=
uct env_set *es, const struct link_socket_info *info);
 
-bool link_socket_=
update_flags(struct link_socket *sock, unsigned int sockflags);
-
 void lin=
k_socket_update_buffer_sizes(struct link_socket *sock, int rcvbuf, int sndb=
uf);
 
 /*

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
97?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I434a5=
373f77b0f7570a6a2aafe0eaf970e2eabe7
Gerrit-Change-Number: 1797
Gerrit-Patch=
Set: 4
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: cron2=
 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--+WCpcYFVdpo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by ordex=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+1 by cron2, Code-Review+2 by plaisthos</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Enabl=
e TCP_NODELAY by default and push it to clients<br><br>TCP_NODELAY had to b=
e requested explicitly via<br>--tcp-nodelay or &quot;socket-flags TCP_NODEL=
AY&quot;=2E Enable<br>it unconditionally on every TCP socket instead<br>(dc=
o-win is skipped as it manages its own socket)=2E<br>The socket_set_flags()=
 and<br>link_socket_update_flags() plumbing that only ever<br>applied it is=
 dropped; the SF_TCP_NODELAY sockflag<br>and &quot;socket-flags TCP_NODELAY=
&quot; become no-ops, the<br>latter kept for backwards compatibility=2E<br>=
<br>--tcp-nodelay no longer touches the local socket<br>but, in --mode serv=
er, still pushes &quot;socket-flags<br>TCP_NODELAY&quot; to clients, for th=
e benefit of clients<br>older than 2=2E7=2E6 that do not enable it by defau=
lt=2E<br>On a client the option is deprecated and inert=2E It<br>can be dro=
pped once such clients are gone=2E<br><br>Change-Id: I434a5373f77b0f7570a6a=
2aafe0eaf970e2eabe7<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelb=
it=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<b=
r>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797<br>Message-Id=
: &lt;20260721124452=2E27832-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37726=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M doc/man-sections/link-options=2Erst<br>M src/openvpn/helper=2Ec<br>=
M src/openvpn/init=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/socket=
=2Ec<br>M src/openvpn/socket=2Eh<br>6 files changed, 29 insertions(+), 81 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/97/1797/4</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-section=
s/link-options=2Erst b/doc/man-sections/link-options=2Erst</span><br><span>=
index df8c917=2E=2E7c61b67 100644</span><br><span>--- a/doc/man-sections/li=
nk-options=2Erst</span><br><span>+++ b/doc/man-sections/link-options=2Erst<=
/span><br><span>@@ -465,23 +465,20 @@</span><br><span>   trying to group se=
veral smaller packets into a larger packet=2E  This can</span><br><span>   =
result in a considerably improvement in latency=2E</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  This option is pushable fr=
om server to client, and should be used on</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  both client and server for maximum effect=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  Since OpenVPN 2=2E7=2E6 :=
code:`TCP_NODELAY` is enabled by default on every TCP</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  socket, so specifying it here is no lon=
ger necessary=2E</span><br><span> </span><br><span> --tcp-nodelay</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  This macro sets the :code:`TC=
P_NODELAY` socket flag on the server as well</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  as pushes it to connecting clients=2E The :code:`T=
CP_NODELAY` flag disables</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  the Nagle algorithm on TCP sockets causing packets to be transmitted<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  immediately with low=
 latency, rather than waiting a short period of time</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  in order to aggregate several packets int=
o a larger containing packet=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  In VPN applications over TCP, :code:`TCP_NODELAY` is generally =
a good</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  latency optim=
ization=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`=
TCP_NODELAY` is enabled by default on every TCP socket=2E In</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  ``--mode server`` this option ad=
ditionally pushes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
``socket-flags TCP_NODELAY`` to connecting clients, so that clients older</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  than 2=2E7=2E6 get =
it too=2E The option can be removed once such clients are no</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  longer in use=2E</span><br><span=
> </span><br><span>   The macro expands as follows:</span><br><span>   ::</=
span><br><span> </span><br><span>      if mode server:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-         socket-flags TCP_NODELAY</span><b=
r><span>          push &quot;socket-flags TCP_NODELAY&quot;</span><br><span=
> </span><br><span> --max-packet-size size</span><br><span>diff --git a/src=
/openvpn/helper=2Ec b/src/openvpn/helper=2Ec</span><br><span>index 4c540a6=
=2E=2E7c186c5 100644</span><br><span>--- a/src/openvpn/helper=2Ec</span><br=
><span>+++ b/src/openvpn/helper=2Ec</span><br><span>@@ -99,14 +99,6 @@</spa=
n><br><span>     return BSTR(&amp;out);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const char *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-print_str(const char *=
str, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffe=
r out =3D alloc_buf_gc(128, gc);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    buf_printf(&amp;out, &quot;%s&quot;, str);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return BSTR(&amp;out);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> helper_=
add_route(const in_addr_t network, const in_addr_t netmask, struct options =
*o)</span><br><span> {</span><br><span>@@ -597,22 +589,13 @@</span><br><spa=
n>  * EXPANDS TO:</span><br><span>  *</span><br><span>  * if mode server:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   socket-flags TCP_N=
ODELAY</span><br><span>  *   push &quot;socket-flags TCP_NODELAY&quot;</spa=
n><br><span>  */</span><br><span> void</span><br><span> helper_tcp_nodelay(=
struct options *o)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (o-&gt;server_flags &amp; SF_TCP_NODELAY_HELPER)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((o-&gt;server_f=
lags &amp; SF_TCP_NODELAY_HELPER) &amp;&amp; o-&gt;mode =3D=3D MODE_SERVER)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (o-&gt;mode =3D=3D MODE_SERVER)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            o-&gt;sockflags |=3D SF_TCP_NODELAY;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            push_option(o, print_str(=
&quot;socket-flags TCP_NODELAY&quot;, &amp;o-&gt;gc), M_USAGE);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            o-&gt;sockflags |=3D SF_TCP_NODELAY;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        push_option(o, &quot;socket-flags TCP_N=
ODELAY&quot;, M_USAGE);</span><br><span>     }</span><br><span> }</span><br=
><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><=
span>index caaa769=2E=2E914d191 100644</span><br><span>--- a/src/openvpn/in=
it=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2650,=
15 +2650,6 @@</span><br><span>         }</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (found &=
amp; OPT_P_SOCKFLAGS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_PU=
SH, &quot;OPTIONS IMPORT: --socket-flags option modified&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        for (int i =3D 0; i &lt;=
 c-&gt;c1=2Elink_sockets_num; i++)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            link_socket_update_flags(c-&gt;c2=2Elink_sockets[i], c-&gt;opt=
ions=2Esockflags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (found=
 &amp; OPT_P_PERSIST)</span><br><span>     {</span><br><span>         msg(D=
_PUSH, &quot;OPTIONS IMPORT: --persist options modified&quot;);</span><br><=
span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><=
br><span>index 2424431=2E=2E7460a83 100644</span><br><span>--- a/src/openvp=
n/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span=
>@@ -486,8 +486,8 @@</span><br><span>     &quot;                  virtual a=
ddress table to v=2E\n&quot;</span><br><span>     &quot;--bcast-buffers n :=
 Allocate n broadcast buffers=2E\n&quot;</span><br><span>     &quot;--tcp-q=
ueue-limit n : Maximum number of queued TCP output packets=2E\n&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--tcp-nodelay   :=
 Macro that sets TCP_NODELAY socket flag on the server\n&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &quot;                  as wel=
l as pushes it to connecting clients=2E\n&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &quot;--tcp-nodelay   : In server mode, pus=
h TCP_NODELAY to clients (it is\n&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &quot;                  enabled by default on the l=
ocal socket)=2E\n&quot;</span><br><span>     &quot;--learn-address cmd : Ru=
n command cmd to validate client virtual addresses=2E\n&quot;</span><br><sp=
an>     &quot;--connect-freq n s : Allow a maximum of n new connections per=
 s seconds=2E\n&quot;</span><br><span>     &quot;--connect-freq-initial n s=
 : Allow a maximum of n replies for initial connections attempts per s seco=
nds=2E\n&quot;</span><br><span>@@ -2618,6 +2618,13 @@</span><br><span>     =
        MUST_BE_UNDEF(vlan_accept, &quot;vlan-accept&quot;);</span><br><spa=
n>             MUST_BE_UNDEF(vlan_pvid, &quot;vlan-pvid&quot;);</span><br><=
span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt=
;server_flags &amp; SF_TCP_NODELAY_HELPER)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(M_INFO, &quot;NOTE: TCP_NODELAY is always enab=
led locally; &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        &quot;--tcp-nodelay is now only useful to push the =
flag to &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   &quot;clients older than 2=2E7=2E6=2E&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>    =
 }</span><br><span>     else</span><br><span>     {</span><br><span>@@ -264=
8,9 +2655,7 @@</span><br><span>         MUST_BE_FALSE(options-&gt;ssl_flags=
 &amp; SSLF_AUTH_USER_PASS_OPTIONAL, &quot;auth-user-pass-optional&quot;);<=
/span><br><span>         if (options-&gt;server_flags &amp; SF_TCP_NODELAY_=
HELPER)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            msg(M_WARN, &quot;WARNING: setting tcp-nodelay on =
the client side will not &quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                        &quot;affect the server=2E To have TCP_NO=
DELAY in both direction use &quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        &quot;tcp-nodelay in the server config=
uration instead=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(M_WARN, &quot;DEPRECATED OPTION: --tcp-nodelay is al=
ways enabled on clients&quot;);</span><br><span>         }</span><br><span>=
         MUST_BE_UNDEF(auth_user_pass_verify_script, &quot;auth-user-pass-v=
erify&quot;);</span><br><span>         MUST_BE_UNDEF(auth_token_generate, &=
quot;auth-gen-token&quot;);</span><br><span>@@ -6537,11 +6542,9 @@</span><b=
r><span>         VERIFY_PERMISSION(OPT_P_SOCKFLAGS);</span><br><span>      =
   for (j =3D 1; j &lt; MAX_PARMS &amp;&amp; p[j]; ++j)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if=
 (streq(p[j], &quot;TCP_NODELAY&quot;))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                options-&gt;sockflags |=3D SF_TCP_NODELAY;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            /* TCP_NODELAY is enabled b=
y default; the flag is still accepted</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+             * for backwards compatibility but no longer =
has any effect */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (!streq(p[j], &quot;TCP_NODELAY&quot;))</span><br><span>      =
       {</span><br><span>                 msg(msglevel, &quot;unknown socke=
t flag: %s&quot;, p[j]);</span><br><span>             }</span><br><span>dif=
f --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>i=
ndex df2cc9e=2E=2Eb73a5df 100644</span><br><span>--- a/src/openvpn/socket=
=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -516,3=
4 +516,6 @@</span><br><span> #endif</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-socket_set_flags(socket_descriptor=
_t sd, unsigned int sockflags)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* SF_T=
CP_NODELAY doesn&#39;t make sense for dco-win */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if ((sockflags &amp; SF_TCP_NODELAY) &amp;&a=
mp; (!(sockflags &amp; SF_DCO_WIN)))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return socket_set_tcp_nodelay(sd, 1);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return true;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_update_fla=
gs(struct link_socket *sock, unsigned int sockflags)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (sock &amp;&amp; socket_defined(sock-&gt;sd))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        sock-&gt;sockflags |=3D sockflags;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        return socket_set_f=
lags(sock-&gt;sd, sock-&gt;sockflags);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> void</span><br><span> link_socket_update_buff=
er_sizes(struct link_socket *sock, int rcvbuf, int sndbuf)</span><br><span>=
 {</span><br><span>@@ -1485,8 +1457,12 @@</span><br><span> static void</spa=
n><br><span> phase2_set_socket_flags(struct link_socket *sock)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* set misc=
 socket parameters */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    socket_set_flags(sock-&gt;sd, sock-&gt;sockflags);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* TCP_NODELAY is enabled by default=
 on every TCP socket; dco-win is</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * skipped as it manages its own socket */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (proto_is_tcp(sock-&gt;info=
=2Eproto) &amp;&amp; !(sock-&gt;sockflags &amp; SF_DCO_WIN))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        socket_set_tcp_nodelay(sock-&gt;sd, 1);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n> </span><br><span>     /* set socket to non-blocking mode */</span><br><s=
pan>     set_nonblock(sock-&gt;sd);</span><br><span>diff --git a/src/openvp=
n/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index cd4e8ed=2E=2E58=
83592 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+=
++ b/src/openvpn/socket=2Eh</span><br><span>@@ -207,7 +207,7 @@</span><br><=
span>     int mtu; /* OS discovered MTU, or 0 if unknown */</span><br><span=
> </span><br><span> #define SF_USE_IP_PKTINFO    (1 &lt;&lt; 0)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define SF_TCP_NODELAY       (1 &=
lt;&lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define S=
F_TCP_NODELAY       (1 &lt;&lt; 1) /* unused: flag always enabled */</span>=
<br><span> #define SF_PORT_SHARE        (1 &lt;&lt; 2)</span><br><span> #de=
fine SF_HOST_RANDOMIZE    (1 &lt;&lt; 3)</span><br><span> #define SF_GETADD=
RINFO_DGRAM (1 &lt;&lt; 4)</span><br><span>@@ -390,8 +390,6 @@</span><br><s=
pan> </span><br><span> void setenv_trusted(struct env_set *es, const struct=
 link_socket_info *info);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-bool link_socket_update_flags(struct link_socket *soc=
k, unsigned int sockflags);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> void link_socket_update_buffer_sizes(struct link_so=
cket *sock, int rcvbuf, int sndbuf);</span><br><span> </span><br><span> /*<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail">change 1797</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I434a5373f77b0f757=
0a6a2aafe0eaf970e2eabe7 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1797 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<=
div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@gr=
eenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--+WCpcYFVdpo=--


--===============2230232907757730198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2230232907757730198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2230232907757730198==--

