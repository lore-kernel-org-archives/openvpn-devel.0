Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E71C44529
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pYnYoQG2wWDp5ZgfaxVI7oaaBxHF7ynzajLEu+35kSo=; b=Novbg1/lX/WBtlSqJezW0Rql4I
	eJbP+yjYpB7HC05WO6MCt17m6Gynx5Ed5jlZ3Q/He4EhK9XL6gg6DLwUsDDmAsXfYyxKpdTPyRI6q
	axcIIBSw3Mw7+vfwh3ig46y5nq0cj3sjMOhOYa2n0ZGxMCXbplYYRnt5hHX6fDExL0Oo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wm8em-00057D-40;
	Tue, 21 Jul 2026 11:29:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wm8ek-000575-5c
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 11:29:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+xNw2FgFrJZtfU0/Jv+N6sxeUR8a8wlrAYBAHQKRJRg=; b=k0DEkeUQ7E0X3ZDw8oEsIsNuUW
 9XSYfZIB+iB9X+PK70PnD60SSZ9yDyeVYqU9BzfeJKHOH2/P/mRdVK9r763ul4mZhGtJocVmmtLck
 irExn41LGewgN8omU7tb20BRKApSu68OjMrsQb31DDLqUR8PVXHHABv578ko7b3fATvk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+xNw2FgFrJZtfU0/Jv+N6sxeUR8a8wlrAYBAHQKRJRg=; b=b
 n1d+1KSg/U+s7/tjmqQJdsV2Vj0Yy/XQGCdCOtHEyENhvP+mdJVuOiZ1SkhHZgY+5BaQ9FIDVduel
 q727lpZeNEFx6SaDCo+PfuQ1euut+2aOC3LZoyJH3pIUkTj1dYrfH95u4PNhRS3PxlDoz35zDSOJa
 Z9keqBrAb04eyyPE=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wm8ei-0007Ck-GY for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 11:29:02 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso32717915e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784633329; x=1785238129; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+xNw2FgFrJZtfU0/Jv+N6sxeUR8a8wlrAYBAHQKRJRg=;
 b=N4gTE+GebUY9d+AkwLaTk5n/caF6sjKGYaSqTldVoEP5brqSRZrDgfZlCnyruJjNpc
 nJ483lq//OkeRD2jzx0YlfP/zkPyw+64LOii1rXrTbBcLOnIJy9qA97ikFoMrX5j4vSo
 jCoFZaj+DBeI3aAMHI8B+d9fzocvebPBl5BwhIndoRgcFImmwV4G7dhjAcX+9iDhsfom
 94elzulzBwNqpZ7vZ4dfoPP9+megx+kG5OHYaIHeMrFgXox/GcN+l9G/6BhVLRCTdRU2
 gUDJWLRdO5neq49nMgqvOXkNNysWDEVq07e+pcLUB13jBHpGzNc9KXahYF4c8zoTBX+f
 R/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784633329; x=1785238129;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+xNw2FgFrJZtfU0/Jv+N6sxeUR8a8wlrAYBAHQKRJRg=;
 b=VTqeBzWaerbxgzGYNKEaDci2QD0UH3DCX1Adr1aI18t1w2k/Hh2NE1lefJIQxDBeKw
 rHfpS04weX9sjh6+k9wGv7YnKZgFAjjKpp9n6EOzich0nIzanvvCXEPMAAzmTy52bP85
 r7NqYYr/SRzdTXn/yxbDN8xFVITRCYZdZBPF1NUphT2a4k43HfGbK8Z2Z1iF7c7Cn4tv
 Iu+jlR677BT7C+F21qF3gy5pYC0xJHkqSvf8rStbQJpFJARSIHPcQlxePtlF9qdRDVIW
 Er4JrqvnOX6l2I2vZPMcRKXM+jXZCr7sELgvIDGRv1ZSrUH/VNaqsulNBfB3SYeDpbxb
 ULJQ==
X-Gm-Message-State: AOJu0YxMJPVtGZ1YiNdPul0gtuh+8N+yGyveQ4Cx6mL23dSX3H6C1mt0
 9lGg8Lmlqb8JFXbBrdkYboD/iSdpZVL0wp/bw4TQbdlGxaxR0Aqs3csqIcA2MItq1aoh/zsluJ4
 i/bHAo4KY0MvLjHRXnqGdaQVgGN6zvfNMLAlR2s76UbUKQq+CbJSlQPUnMKmyq9c3Bss2SYi1Qi
 CF+Azb+w==
X-Gm-Gg: AfdE7cltlH6MS7D4dGUmt8NuBMmv8V0ixx+GTVuLJGgCG6U36VFieVtdaruzRN0iwKN
 s9KLdHM67p2wuXGqlNayZOau8CBqRF7afmieJP7p4axTtQvcNGAqepp0APOhYkMGv+PeNWz3xGc
 XKNG4KAkm1m/iYFbCaKzCTYK7JHMJBDw+7A9kPPALf41GGXHMmrL859gImUlihcq9Zns7B9qSrY
 zfjV1eHu7xj6C7DOhJhbjayNMXOBMbNXzHIefyIsQm31jf3pR1fslcYiHh08HSqtVfyKwbvO5fK
 NMdWp6GLYlxeHzbCVXZyhbG450UI3DyXq2E0lYP5uQwZ+G/1NextriEuNhH8/U1AP3NwtzKVfGw
 4WcwT3F+8nHSyAVHaArClRTsBJM1kNKJGrcVDXzOQeWAml1uymuEbll1WAX6lnM1Y1b4u5nw2oW
 Xqei/NL/Q7tLXFgGW/v4mKJBWjFxO6MXTxYJq55QWWXCeCHRvqYwXIMg0QUqKiAsSjBRGqnDNU2
 kA0GrqZXX4u0y0ewJP5fIkhvS5Z0xQBU5ICMeEtyanWEldL1EiQkRG//WTK9puqyqFG
X-Received: by 2002:a05:600c:1548:b0:493:c062:a533 with SMTP id
 5b1f17b1804b1-4954a3e8fe1mr206982895e9.17.1784633328691; 
 Tue, 21 Jul 2026 04:28:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49acesm36810743f8f.6.2026.07.21.04.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:28:48 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 11:28:45 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
X-Gerrit-Change-Number: 1797
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1797?usp=email>
X-Gerrit-Commit: ee7b3d5be874f61f2863b7a8698f82e4ca3bab25
In-Reply-To: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
References: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTg2MDY2MDAwLkk0MzRhNTM3M2Y3N2IwZjc1NzBhNmEyYWFmZTBlYWY5NzBlMmVhYmU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e0b11d88806cb56e75fab22c9cb7e0f76191f25e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wm8ei-0007Ck-GY
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3515117299311307040=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3515117299311307040==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qKapAvX7O+4="; charset=UTF-8

--qKapAvX7O+4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

Hello cron2, pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail

to look at the new patch=
 set (#3)=2E

The following approvals got outdated and were removed:
Code-R=
eview+2 by plaisthos


Change subject: Enable TCP_NODELAY by default and pu=
sh it to clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Enable TCP_NODELAY by default and push it to clients

TCP_NODELAY had =
to be requested explicitly via
--tcp-nodelay or "socket-flags TCP_NODELAY"=
=2E Enable
it unconditionally on every TCP socket instead
(dco-win is skipp=
ed as it manages its own socket)=2E
The socket_set_flags() and
link_socket_=
update_flags() plumbing that only ever
applied it is dropped; the SF_TCP_NO=
DELAY sockflag
and "socket-flags TCP_NODELAY" become no-ops, the
latter kep=
t for backwards compatibility=2E

--tcp-nodelay no longer touches the local=
 socket
but, in --mode server, still pushes "socket-flags
TCP_NODELAY" to c=
lients, for the benefit of clients
older than 2=2E7=2E6 that do not enable =
it by default=2E
On a client the option is deprecated and inert=2E It
can b=
e dropped once such clients are gone=2E

Change-Id: I434a5373f77b0f7570a6a2=
aafe0eaf970e2eabe7
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Eco=
m>
---
M doc/man-sections/link-options=2Erst
M src/openvpn/helper=2Ec
M src=
/openvpn/init=2Ec
M src/openvpn/options=2Ec
M src/openvpn/socket=2Ec
M src/=
openvpn/socket=2Eh
6 files changed, 29 insertions(+), 81 deletions(-)


  g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/1797/3

=
diff --git a/doc/man-sections/link-options=2Erst b/doc/man-sections/link-op=
tions=2Erst
index df8c917=2E=2E7c61b67 100644
--- a/doc/man-sections/link-o=
ptions=2Erst
+++ b/doc/man-sections/link-options=2Erst
@@ -465,23 +465,20 @=
@
   trying to group several smaller packets into a larger packet=2E  This =
can
   result in a considerably improvement in latency=2E
 
-  This option =
is pushable from server to client, and should be used on
-  both client and=
 server for maximum effect=2E
+  Since OpenVPN 2=2E7=2E6 :code:`TCP_NODELAY=
` is enabled by default on every TCP
+  socket, so specifying it here is no=
 longer necessary=2E
 
 --tcp-nodelay
-  This macro sets the :code:`TCP_NOD=
ELAY` socket flag on the server as well
-  as pushes it to connecting clien=
ts=2E The :code:`TCP_NODELAY` flag disables
-  the Nagle algorithm on TCP s=
ockets causing packets to be transmitted
-  immediately with low latency, r=
ather than waiting a short period of time
-  in order to aggregate several =
packets into a larger containing packet=2E
-  In VPN applications over TCP,=
 :code:`TCP_NODELAY` is generally a good
-  latency optimization=2E
+  :cod=
e:`TCP_NODELAY` is enabled by default on every TCP socket=2E In
+  ``--mode=
 server`` this option additionally pushes
+  ``socket-flags TCP_NODELAY`` t=
o connecting clients, so that clients older
+  than 2=2E7=2E6 get it too=2E=
 The option can be removed once such clients are no
+  longer in use=2E
 
 =
  The macro expands as follows:
   ::
 
      if mode server:
-         soc=
ket-flags TCP_NODELAY
          push "socket-flags TCP_NODELAY"
 
 --max-pa=
cket-size size
diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec=

index 4c540a6=2E=2E7c186c5 100644
--- a/src/openvpn/helper=2Ec
+++ b/src/o=
penvpn/helper=2Ec
@@ -99,14 +99,6 @@
     return BSTR(&out);
 }
 
-static c=
onst char *
-print_str(const char *str, struct gc_arena *gc)
-{
-    struct=
 buffer out =3D alloc_buf_gc(128, gc);
-    buf_printf(&out, "%s", str);
- =
   return BSTR(&out);
-}
-
 static void
 helper_add_route(const in_addr_t n=
etwork, const in_addr_t netmask, struct options *o)
 {
@@ -597,22 +589,13 @=
@
  * EXPANDS TO:
  *
  * if mode server:
- *   socket-flags TCP_NODELAY
  =
*   push "socket-flags TCP_NODELAY"
  */
 void
 helper_tcp_nodelay(struct o=
ptions *o)
 {
-    if (o->server_flags & SF_TCP_NODELAY_HELPER)
+    if ((o=
->server_flags & SF_TCP_NODELAY_HELPER) && o->mode =3D=3D MODE_SERVER)
    =
 {
-        if (o->mode =3D=3D MODE_SERVER)
-        {
-            o->sock=
flags |=3D SF_TCP_NODELAY;
-            push_option(o, print_str("socket-fl=
ags TCP_NODELAY", &o->gc), M_USAGE);
-        }
-        else
-        {
- =
           o->sockflags |=3D SF_TCP_NODELAY;
-        }
+        push_optio=
n(o, "socket-flags TCP_NODELAY", M_USAGE);
     }
 }
diff --git a/src/openv=
pn/init=2Ec b/src/openvpn/init=2Ec
index caaa769=2E=2E914d191 100644
--- a/=
src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2650,15 +2650,6 @@
    =
     }
     }
 
-    if (found & OPT_P_SOCKFLAGS)
-    {
-        msg(D_PUS=
H, "OPTIONS IMPORT: --socket-flags option modified");
-        for (int i =
=3D 0; i < c->c1=2Elink_sockets_num; i++)
-        {
-            link_sock=
et_update_flags(c->c2=2Elink_sockets[i], c->options=2Esockflags);
-        =
}
-    }
-
     if (found & OPT_P_PERSIST)
     {
         msg(D_PUSH, "OPT=
IONS IMPORT: --persist options modified");
diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec
index 87218d4=2E=2E49b604b 100644
--- a/src/=
openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -486,8 +486,8 @@
     =
"                  virtual address table to v=2E\n"
     "--bcast-buffers n=
 : Allocate n broadcast buffers=2E\n"
     "--tcp-queue-limit n : Maximum n=
umber of queued TCP output packets=2E\n"
-    "--tcp-nodelay   : Macro that=
 sets TCP_NODELAY socket flag on the server\n"
-    "                  as w=
ell as pushes it to connecting clients=2E\n"
+    "--tcp-nodelay   : In ser=
ver mode, push TCP_NODELAY to clients (it is\n"
+    "                  ena=
bled by default on the local socket)=2E\n"
     "--learn-address cmd : Run =
command cmd to validate client virtual addresses=2E\n"
     "--connect-freq=
 n s : Allow a maximum of n new connections per s seconds=2E\n"
     "--con=
nect-freq-initial n s : Allow a maximum of n replies for initial connection=
s attempts per s seconds=2E\n"
@@ -2616,6 +2616,13 @@
             MUST_BE_=
UNDEF(vlan_accept, "vlan-accept");
             MUST_BE_UNDEF(vlan_pvid, "v=
lan-pvid");
         }
+
+        if (options->server_flags & SF_TCP_NODELA=
Y_HELPER)
+        {
+            msg(M_INFO, "NOTE: TCP_NODELAY is always =
enabled locally; "
+                        "--tcp-nodelay is now only usef=
ul to push the flag to "
+                        "clients older than 2=2E7=
=2E6=2E");
+        }
     }
     else
     {
@@ -2646,9 +2653,7 @@
       =
  MUST_BE_FALSE(options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL, "auth-us=
er-pass-optional");
         if (options->server_flags & SF_TCP_NODELAY_HEL=
PER)
         {
-            msg(M_WARN, "WARNING: setting tcp-nodelay on t=
he client side will not "
-                        "affect the server=2E To=
 have TCP_NODELAY in both direction use "
-                        "tcp-nod=
elay in the server configuration instead=2E");
+            msg(M_WARN, "DE=
PRECATED OPTION: --tcp-nodelay is always enabled on clients");
         }
 =
        MUST_BE_UNDEF(auth_user_pass_verify_script, "auth-user-pass-verify"=
);
         MUST_BE_UNDEF(auth_token_generate, "auth-gen-token");
@@ -6535,=
11 +6540,9 @@
         VERIFY_PERMISSION(OPT_P_SOCKFLAGS);
         for (j =
=3D 1; j < MAX_PARMS && p[j]; ++j)
         {
-            if (streq(p[j], =
"TCP_NODELAY"))
-            {
-                options->sockflags |=3D SF_=
TCP_NODELAY;
-            }
-            else
+            /* TCP_NODELAY i=
s enabled by default; the flag is still accepted
+             * for backwa=
rds compatibility but no longer has any effect */
+            if (!streq(p=
[j], "TCP_NODELAY"))
             {
                 msg(msglevel, "unknown=
 socket flag: %s", p[j]);
             }
diff --git a/src/openvpn/socket=2E=
c b/src/openvpn/socket=2Ec
index df2cc9e=2E=2Eb73a5df 100644
--- a/src/open=
vpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -516,34 +516,6 @@
 #endif
 }=

 
-static bool
-socket_set_flags(socket_descriptor_t sd, unsigned int sock=
flags)
-{
-    /* SF_TCP_NODELAY doesn't make sense for dco-win */
-    if =
((sockflags & SF_TCP_NODELAY) && (!(sockflags & SF_DCO_WIN)))
-    {
-     =
   return socket_set_tcp_nodelay(sd, 1);
-    }
-    else
-    {
-        r=
eturn true;
-    }
-}
-
-bool
-link_socket_update_flags(struct link_socket =
*sock, unsigned int sockflags)
-{
-    if (sock && socket_defined(sock->sd)=
)
-    {
-        sock->sockflags |=3D sockflags;
-        return socket_se=
t_flags(sock->sd, sock->sockflags);
-    }
-    else
-    {
-        return=
 false;
-    }
-}
-
 void
 link_socket_update_buffer_sizes(struct link_sock=
et *sock, int rcvbuf, int sndbuf)
 {
@@ -1485,8 +1457,12 @@
 static void
 p=
hase2_set_socket_flags(struct link_socket *sock)
 {
-    /* set misc socket=
 parameters */
-    socket_set_flags(sock->sd, sock->sockflags);
+    /* TC=
P_NODELAY is enabled by default on every TCP socket; dco-win is
+     * ski=
pped as it manages its own socket */
+    if (proto_is_tcp(sock->info=2Epro=
to) && !(sock->sockflags & SF_DCO_WIN))
+    {
+        socket_set_tcp_node=
lay(sock->sd, 1);
+    }
 
     /* set socket to non-blocking mode */
     =
set_nonblock(sock->sd);
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/s=
ocket=2Eh
index cd4e8ed=2E=2E5883592 100644
--- a/src/openvpn/socket=2Eh
++=
+ b/src/openvpn/socket=2Eh
@@ -207,7 +207,7 @@
     int mtu; /* OS discover=
ed MTU, or 0 if unknown */
 
 #define SF_USE_IP_PKTINFO    (1 << 0)
-#defin=
e SF_TCP_NODELAY       (1 << 1)
+#define SF_TCP_NODELAY       (1 << 1) /* u=
nused: flag always enabled */
 #define SF_PORT_SHARE        (1 << 2)
 #defi=
ne SF_HOST_RANDOMIZE    (1 << 3)
 #define SF_GETADDRINFO_DGRAM (1 << 4)
@@ =
-390,8 +390,6 @@
 
 void setenv_trusted(struct env_set *es, const struct li=
nk_socket_info *info);
 
-bool link_socket_update_flags(struct link_socket =
*sock, unsigned int sockflags);
-
 void link_socket_update_buffer_sizes(str=
uct link_socket *sock, int rcvbuf, int sndbuf);
 
 /*

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2ea=
be7
Gerrit-Change-Number: 1797
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <anto=
nio@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>

--qKapAvX7O+4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>ordex <strong>uploaded pa=
tch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1797?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">Enable TCP_NODELAY by default and push it to clients<br><br>TCP_=
NODELAY had to be requested explicitly via<br>--tcp-nodelay or &quot;socket=
-flags TCP_NODELAY&quot;=2E Enable<br>it unconditionally on every TCP socke=
t instead<br>(dco-win is skipped as it manages its own socket)=2E<br>The so=
cket_set_flags() and<br>link_socket_update_flags() plumbing that only ever<=
br>applied it is dropped; the SF_TCP_NODELAY sockflag<br>and &quot;socket-f=
lags TCP_NODELAY&quot; become no-ops, the<br>latter kept for backwards comp=
atibility=2E<br><br>--tcp-nodelay no longer touches the local socket<br>but=
, in --mode server, still pushes &quot;socket-flags<br>TCP_NODELAY&quot; to=
 clients, for the benefit of clients<br>older than 2=2E7=2E6 that do not en=
able it by default=2E<br>On a client the option is deprecated and inert=2E =
It<br>can be dropped once such clients are gone=2E<br><br>Change-Id: I434a5=
373f77b0f7570a6a2aafe0eaf970e2eabe7<br>Signed-off-by: Antonio Quartulli &lt=
;antonio@mandelbit=2Ecom&gt;<br>---<br>M doc/man-sections/link-options=2Ers=
t<br>M src/openvpn/helper=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/op=
tions=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>6 file=
s changed, 29 insertions(+), 81 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/1797/3</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/doc/man-sections/link-options=2Erst b/doc/man-sections/li=
nk-options=2Erst</span><br><span>index df8c917=2E=2E7c61b67 100644</span><b=
r><span>--- a/doc/man-sections/link-options=2Erst</span><br><span>+++ b/doc=
/man-sections/link-options=2Erst</span><br><span>@@ -465,23 +465,20 @@</spa=
n><br><span>   trying to group several smaller packets into a larger packet=
=2E  This can</span><br><span>   result in a considerably improvement in la=
tency=2E</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  This option is pushable from server to client, and should be used on=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  both client and ser=
ver for maximum effect=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  Since OpenVPN 2=2E7=2E6 :code:`TCP_NODELAY` is enabled by default o=
n every TCP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  socket=
, so specifying it here is no longer necessary=2E</span><br><span> </span><=
br><span> --tcp-nodelay</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  This macro sets the :code:`TCP_NODELAY` socket flag on the server as we=
ll</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  as pushes it to c=
onnecting clients=2E The :code:`TCP_NODELAY` flag disables</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  the Nagle algorithm on TCP sockets c=
ausing packets to be transmitted</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  immediately with low latency, rather than waiting a short peri=
od of time</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  in order =
to aggregate several packets into a larger containing packet=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  In VPN applications over TCP, :=
code:`TCP_NODELAY` is generally a good</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  latency optimization=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  :code:`TCP_NODELAY` is enabled by default on every=
 TCP socket=2E In</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
``--mode server`` this option additionally pushes</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  ``socket-flags TCP_NODELAY`` to connecting =
clients, so that clients older</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  than 2=2E7=2E6 get it too=2E The option can be removed once su=
ch clients are no</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
longer in use=2E</span><br><span> </span><br><span>   The macro expands as =
follows:</span><br><span>   ::</span><br><span> </span><br><span>      if m=
ode server:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         s=
ocket-flags TCP_NODELAY</span><br><span>          push &quot;socket-flags T=
CP_NODELAY&quot;</span><br><span> </span><br><span> --max-packet-size size<=
/span><br><span>diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2E=
c</span><br><span>index 4c540a6=2E=2E7c186c5 100644</span><br><span>--- a/s=
rc/openvpn/helper=2Ec</span><br><span>+++ b/src/openvpn/helper=2Ec</span><b=
r><span>@@ -99,14 +99,6 @@</span><br><span>     return BSTR(&amp;out);</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static const char *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-print_str(const char *str, struct gc_arena *gc)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct buffer out =3D alloc_buf_gc(128, gc);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;%s=
&quot;, str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn BSTR(&amp;out);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> stati=
c void</span><br><span> helper_add_route(const in_addr_t network, const in_=
addr_t netmask, struct options *o)</span><br><span> {</span><br><span>@@ -5=
97,22 +589,13 @@</span><br><span>  * EXPANDS TO:</span><br><span>  *</span>=
<br><span>  * if mode server:</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *   socket-flags TCP_NODELAY</span><br><span>  *   push &quot;sock=
et-flags TCP_NODELAY&quot;</span><br><span>  */</span><br><span> void</span=
><br><span> helper_tcp_nodelay(struct options *o)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;server_flags &=
amp; SF_TCP_NODELAY_HELPER)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if ((o-&gt;server_flags &amp; SF_TCP_NODELAY_HELPER) &amp;&amp;=
 o-&gt;mode =3D=3D MODE_SERVER)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (o-&gt;mode =3D=3D MODE_SERVER)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;sockflags |=3D =
SF_TCP_NODELAY;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      push_option(o, print_str(&quot;socket-flags TCP_NODELAY&quot;, &amp;o=
-&gt;gc), M_USAGE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;sockflags |=3D SF=
_TCP_NODELAY;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        push_optio=
n(o, &quot;socket-flags TCP_NODELAY&quot;, M_USAGE);</span><br><span>     }=
</span><br><span> }</span><br><span>diff --git a/src/openvpn/init=2Ec b/src=
/openvpn/init=2Ec</span><br><span>index caaa769=2E=2E914d191 100644</span><=
br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=
=2Ec</span><br><span>@@ -2650,15 +2650,6 @@</span><br><span>         }</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (found &amp; OPT_P_SOCKFLAGS)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(D_PUSH, &quot;OPTIONS IMPORT: --socket-flags op=
tion modified&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        for (int i =3D 0; i &lt; c-&gt;c1=2Elink_sockets_num; i++)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            link_socket_update_flags(c-&gt=
;c2=2Elink_sockets[i], c-&gt;options=2Esockflags);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span>     if (found &amp; OPT_P_PERSIST)</span><br><span>     =
{</span><br><span>         msg(D_PUSH, &quot;OPTIONS IMPORT: --persist opti=
ons modified&quot;);</span><br><span>diff --git a/src/openvpn/options=2Ec b=
/src/openvpn/options=2Ec</span><br><span>index 87218d4=2E=2E49b604b 100644<=
/span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/ope=
nvpn/options=2Ec</span><br><span>@@ -486,8 +486,8 @@</span><br><span>     &=
quot;                  virtual address table to v=2E\n&quot;</span><br><spa=
n>     &quot;--bcast-buffers n : Allocate n broadcast buffers=2E\n&quot;</s=
pan><br><span>     &quot;--tcp-queue-limit n : Maximum number of queued TCP=
 output packets=2E\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &quot;--tcp-nodelay   : Macro that sets TCP_NODELAY socket flag on=
 the server\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  &quot;                  as well as pushes it to connecting clients=2E\n&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--tcp=
-nodelay   : In server mode, push TCP_NODELAY to clients (it is\n&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;             =
     enabled by default on the local socket)=2E\n&quot;</span><br><span>   =
  &quot;--learn-address cmd : Run command cmd to validate client virtual ad=
dresses=2E\n&quot;</span><br><span>     &quot;--connect-freq n s : Allow a =
maximum of n new connections per s seconds=2E\n&quot;</span><br><span>     =
&quot;--connect-freq-initial n s : Allow a maximum of n replies for initial=
 connections attempts per s seconds=2E\n&quot;</span><br><span>@@ -2616,6 +=
2616,13 @@</span><br><span>             MUST_BE_UNDEF(vlan_accept, &quot;vl=
an-accept&quot;);</span><br><span>             MUST_BE_UNDEF(vlan_pvid, &qu=
ot;vlan-pvid&quot;);</span><br><span>         }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (options-&gt;server_flags &amp; SF_TCP_NODELAY_HELPER)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INFO, &quot;=
NOTE: TCP_NODELAY is always enabled locally; &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        &quot;--tcp-nodel=
ay is now only useful to push the flag to &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        &quot;clients older th=
an 2=2E7=2E6=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span>     }</span><br><span>     else</span><br><s=
pan>     {</span><br><span>@@ -2646,9 +2653,7 @@</span><br><span>         M=
UST_BE_FALSE(options-&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL, &quo=
t;auth-user-pass-optional&quot;);</span><br><span>         if (options-&gt;=
server_flags &amp; SF_TCP_NODELAY_HELPER)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quo=
t;WARNING: setting tcp-nodelay on the client side will not &quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        &quot;a=
ffect the server=2E To have TCP_NODELAY in both direction use &quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        &quo=
t;tcp-nodelay in the server configuration instead=2E&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;DEPR=
ECATED OPTION: --tcp-nodelay is always enabled on clients&quot;);</span><br=
><span>         }</span><br><span>         MUST_BE_UNDEF(auth_user_pass_ver=
ify_script, &quot;auth-user-pass-verify&quot;);</span><br><span>         MU=
ST_BE_UNDEF(auth_token_generate, &quot;auth-gen-token&quot;);</span><br><sp=
an>@@ -6535,11 +6540,9 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_=
SOCKFLAGS);</span><br><span>         for (j =3D 1; j &lt; MAX_PARMS &amp;&a=
mp; p[j]; ++j)</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (streq(p[j], &quot;TCP_NODELAY&quot;))</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                options-&gt;soc=
kflags |=3D SF_TCP_NODELAY;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* TCP_NODELAY is enabled by default; the flag is still accepted</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+             * for back=
wards compatibility but no longer has any effect */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!streq(p[j], &quot;TCP_NO=
DELAY&quot;))</span><br><span>             {</span><br><span>              =
   msg(msglevel, &quot;unknown socket flag: %s&quot;, p[j]);</span><br><spa=
n>             }</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/=
openvpn/socket=2Ec</span><br><span>index df2cc9e=2E=2Eb73a5df 100644</span>=
<br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/so=
cket=2Ec</span><br><span>@@ -516,34 +516,6 @@</span><br><span> #endif</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
socket_set_flags(socket_descriptor_t sd, unsigned int sockflags)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* SF_TCP_NODELAY doesn&#39;t make sense for dco=
-win */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((sockf=
lags &amp; SF_TCP_NODELAY) &amp;&amp; (!(sockflags &amp; SF_DCO_WIN)))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        return socket_set_tcp_nodelay(sd, =
1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        return true;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-link_socket_update_flags(struct link_socket *sock, unsigned int=
 sockflags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (sock &amp;&amp; socket=
_defined(sock-&gt;sd))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sock-&g=
t;sockflags |=3D sockflags;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        return socket_set_flags(sock-&gt;sd, sock-&gt;sockflags);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return false;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><b=
r><span> link_socket_update_buffer_sizes(struct link_socket *sock, int rcvb=
uf, int sndbuf)</span><br><span> {</span><br><span>@@ -1485,8 +1457,12 @@</=
span><br><span> static void</span><br><span> phase2_set_socket_flags(struct=
 link_socket *sock)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /* set misc socket parameters */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    socket_set_flags(sock-&gt;sd, sock-&gt;=
sockflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* T=
CP_NODELAY is enabled by default on every TCP socket; dco-win is</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * skipped as it manages i=
ts own socket */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (proto_is_tcp(sock-&gt;info=2Eproto) &amp;&amp; !(sock-&gt;sockflags &a=
mp; SF_DCO_WIN))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_se=
t_tcp_nodelay(sock-&gt;sd, 1);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span> </span><br><span>     /* set socket to no=
n-blocking mode */</span><br><span>     set_nonblock(sock-&gt;sd);</span><b=
r><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span>=
<br><span>index cd4e8ed=2E=2E5883592 100644</span><br><span>--- a/src/openv=
pn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>=
@@ -207,7 +207,7 @@</span><br><span>     int mtu; /* OS discovered MTU, or =
0 if unknown */</span><br><span> </span><br><span> #define SF_USE_IP_PKTINF=
O    (1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine SF_TCP_NODELAY       (1 &lt;&lt; 1)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define SF_TCP_NODELAY       (1 &lt;&lt; 1) /* unused=
: flag always enabled */</span><br><span> #define SF_PORT_SHARE        (1 &=
lt;&lt; 2)</span><br><span> #define SF_HOST_RANDOMIZE    (1 &lt;&lt; 3)</sp=
an><br><span> #define SF_GETADDRINFO_DGRAM (1 &lt;&lt; 4)</span><br><span>@=
@ -390,8 +390,6 @@</span><br><span> </span><br><span> void setenv_trusted(s=
truct env_set *es, const struct link_socket_info *info);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool link_socket_updat=
e_flags(struct link_socket *sock, unsigned int sockflags);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void link_socket_upd=
ate_buffer_sizes(struct link_socket *sock, int rcvbuf, int sndbuf);</span><=
br><span> </span><br><span> /*</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demai=
l">change 1797</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
97?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1797 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: or=
dex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; =
</div>

</body></html>
--qKapAvX7O+4=--


--===============3515117299311307040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3515117299311307040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3515117299311307040==--

