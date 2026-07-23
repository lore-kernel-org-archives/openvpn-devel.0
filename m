Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0246FC531D0
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 17:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1pwggKHRPXl3tEmN2nucZGxSasiy9y0cIZJwWyhvM9Q=; b=daQdhA1ZlU+jtk6bCDm8LxCNkU
	9kl+b0BlF4hmSqjlk3S5GO4S2gmtPF0rzrQyG1N9gwFhXh64o6ojwW3oIqCh9VWC7JQrPdJ/80bAu
	xw4gDsuuvyrq7Mu2K1uCTtlhHqWz8i0V94m2ZhiJgPiTe5kelkQr3dMHhmqhVHHVApSA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmxds-00012T-Ux;
	Thu, 23 Jul 2026 17:55:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmxdq-000128-FB
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 17:55:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=RHoXVuidBEiMdoYnkcMd7QeOJkAPcGw5UIsk5hALf3A=; b=K9O4zqC1NiFYVWCSdOSqkPLSe8
 HSC2r9ka84py8Ab6WA/vB0gzI66vIVb+zN7y5URI9tSgjcnqiHkyNCagpdESfCFzYOePpCHbwYOkC
 u260d5EaX7bKDhwdrRIAoWxQYnVEV93gRfIMkE7LdITNCyuHlV3ROBE3b3FsYlVFwi+Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RHoXVuidBEiMdoYnkcMd7QeOJkAPcGw5UIsk5hALf3A=; b=U
 Qm4e6pYjuiyRkhEj7sWUp4PVw2fa/U3Yg9aFqUe9/1zJPg9QM71hU2zGyVisUn9MpeL9vO8zQC+/C
 jCS0QJmNz3sjLdYD2mquTyplQu2F+b1B8Es473tfaGI/546PSW4dwo8ZzJGZmpY1pOyjXWZKD14BU
 XS7w/CJ2CTQR6k0U=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmxdU-0002Bx-0y for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 17:55:06 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso6899375e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784829298; x=1785434098; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RHoXVuidBEiMdoYnkcMd7QeOJkAPcGw5UIsk5hALf3A=;
 b=S4aqCmCZX1Eb9Hb2Hd/KFzUtFvC3yT0JSZ3OESpjoigJvMebNhQl1rqymW1Qi1RamN
 hDVgXwibRSW3QYVH24NYqGgfbW2gkmB6C2MEkjsQwjCAPo8i5cJ6NiIVoriVf9Tzu1ea
 7Fs7sOO3HXdA3VOWuEuV/oQWfZV85DdnVRserxxrhtlHUCY+K4ODc02k0Yugc0iO7GxG
 F1GkIaxMIzNMJOkkgwXjlFE0aau9EkF07T6nB+2NNlmUXbRUxhf3okAKTEIQtlPbI+YG
 aaNG26EyLJIa1/uR9gY+kVj9XlL/G/rJTle8v6uI+UV8kmhwekRE2G4bsRFp+GdKdqJk
 cYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784829298; x=1785434098;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RHoXVuidBEiMdoYnkcMd7QeOJkAPcGw5UIsk5hALf3A=;
 b=c0HDizv8mQV7EVuF6bT9EGipIQip2bEcH2DRaj5KD0wZcIXq6EFS68h59KNZq0pvoW
 LoIJJMbNUTCav4/0wkMDTlIxn/R9cLcqmMfB9pXMkdcNpTNkNMZG58uyRuODJoyj1fTL
 GVSeaSo93XHHzSdBNemtge98EugYADxUI+dgDCs7RmG2QNGNnFP0t4ZD3mDYI/ETATWY
 PvsFz9PMy1bS1qYsC37xvFf/DQJlNEE8D8OYY4Zpz9bM8RCVpW79DQr1p+c+xDgGH2lX
 NDsLYNtNcgbJyLaKxjh4ea9Fzswe3Ffch/9OIuVxRjmMvXQNW7pmhYdFQse1q1ayItAm
 bZuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwDzG7muMPT3nphLT8oFVyd2bho9jAJ7bds2vgc2iIs7GAnG6Vr0GjX1cgfdSCVEdDVyofoCgirhNdrNQ5@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwnDXnq0oH+hNzs8r0klVEJV2DWDDiqOclcvgAXI2bLePU5zE8r
 8Q3Ap1WO4jJGIGGkJyd3MsQ6zGC8LoahrEo50aPOprzPCESppSVNQi4ENbK7HJb+7pdlJW+Z2Fq
 shchqtPXeHIqfVVeXUrkt85awbscNsY+Xg+4j/W/LHrS9HL5sGKxvQ/6d9cPc+dEjQzRlbV0rKu
 yV/e0eDw==
X-Gm-Gg: AR+sD139CT8H2a5yOzlMVbG1Yy4tjQcckTzGi5eABrWzdJ72G2vdgVoKilnpmoj5nIb
 1gqHR/RpN+uCrDrOPsUXwC4IUfSPrslao6YjUj7dIgk+QUpmR5848YTxlISvF4mkBBEIpOYoT1A
 egVit3lHvdPYJ79pb+vDygV3YR1BbRZOonQrCkm8C4WwPSfSfDOlEuz+L2+TkHrcA8KZ6DZqbwl
 xkVqwQwREZHCkdaoGBbWxeyeVP3w9J8Qt103kgwdGF7C7T7jmQZ+BchumG2If5QHPKUDHw/xHKc
 d5TB8SSxY8w/3fOUaXKOYs/7MvvknCqArYdWvRkWgSeCiSpEhJfX0ZoE1ht/EsbDm4/5cOr1Co7
 CDWZWeOQ8XDpGIaODrKH7e1wER5NdxT7Xi5HpJhYW4s4m6QNhXpT3qqDJAVqJqvGTaxLyNmdq/m
 07Bf4D64egj7bIMjWWFZosOQrE7L8jXeANV2Jf8y7tZm5+RXUSzOYBuXp3dKi32rEpnYbY+C9R7
 urn7DZRYjJ3D1g3mP8Zb5HfiWSRqLfHx82W82QO0KWbeiGoyaEvXTp/be86Cz5WzDPA
X-Received: by 2002:a7b:cb83:0:b0:495:6b55:f938 with SMTP id
 5b1f17b1804b1-49573cc6d02mr32234775e9.10.1784829297616; 
 Thu, 23 Jul 2026 10:54:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5c4sm16667705f8f.8.2026.07.23.10.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:54:57 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 17:54:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
X-Gerrit-Change-Number: 1797
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1797?usp=email>
X-Gerrit-Commit: da4ecf990b55d6c19cdc3e01c19b989de26fc88e
In-Reply-To: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
References: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTg2MDY2MDAwLkk0MzRhNTM3M2Y3N2IwZjc1NzBhNmEyYWFmZTBlYWY5NzBlMmVhYmU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7762d723536066d839f599c348129fc7f2315443-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmxdU-0002Bx-0y
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3534928644337671314=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3534928644337671314==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E4zMDhMrrcI="; charset=UTF-8

--E4zMDhMrrcI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1797?usp=3Demail )

Change subject: Enable TCP_NODELAY by default and p=
ush it to clients
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
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797
Message-Id: <20260721124452=2E27832=
-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg37726=2Ehtml
Signed-off-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
---
M doc/man-sections/link-options=2Erst
M src/o=
penvpn/helper=2Ec
M src/openvpn/init=2Ec
M src/openvpn/options=2Ec
M src/op=
envpn/socket=2Ec
M src/openvpn/socket=2Eh
6 files changed, 29 insertions(+)=
, 81 deletions(-)




diff --git a/doc/man-sections/link-options=2Erst b/do=
c/man-sections/link-options=2Erst
index df8c917=2E=2E7c61b67 100644
--- a/d=
oc/man-sections/link-options=2Erst
+++ b/doc/man-sections/link-options=2Ers=
t
@@ -465,23 +465,20 @@
   trying to group several smaller packets into a l=
arger packet=2E  This can
   result in a considerably improvement in latenc=
y=2E
 
-  This option is pushable from server to client, and should be used=
 on
-  both client and server for maximum effect=2E
+  Since OpenVPN 2=2E7=
=2E6 :code:`TCP_NODELAY` is enabled by default on every TCP
+  socket, so s=
pecifying it here is no longer necessary=2E
 
 --tcp-nodelay
-  This macro =
sets the :code:`TCP_NODELAY` socket flag on the server as well
-  as pushes=
 it to connecting clients=2E The :code:`TCP_NODELAY` flag disables
-  the N=
agle algorithm on TCP sockets causing packets to be transmitted
-  immediat=
ely with low latency, rather than waiting a short period of time
-  in orde=
r to aggregate several packets into a larger containing packet=2E
-  In VPN=
 applications over TCP, :code:`TCP_NODELAY` is generally a good
-  latency =
optimization=2E
+  :code:`TCP_NODELAY` is enabled by default on every TCP s=
ocket=2E In
+  ``--mode server`` this option additionally pushes
+  ``socke=
t-flags TCP_NODELAY`` to connecting clients, so that clients older
+  than =
2=2E7=2E6 get it too=2E The option can be removed once such clients are no
=
+  longer in use=2E
 
   The macro expands as follows:
   ::
 
      if mod=
e server:
-         socket-flags TCP_NODELAY
          push "socket-flags T=
CP_NODELAY"
 
 --max-packet-size size
diff --git a/src/openvpn/helper=2Ec b=
/src/openvpn/helper=2Ec
index 4c540a6=2E=2E7c186c5 100644
--- a/src/openvpn=
/helper=2Ec
+++ b/src/openvpn/helper=2Ec
@@ -99,14 +99,6 @@
     return BST=
R(&out);
 }
 
-static const char *
-print_str(const char *str, struct gc_ar=
ena *gc)
-{
-    struct buffer out =3D alloc_buf_gc(128, gc);
-    buf_prin=
tf(&out, "%s", str);
-    return BSTR(&out);
-}
-
 static void
 helper_add_=
route(const in_addr_t network, const in_addr_t netmask, struct options *o)
=
 {
@@ -597,22 +589,13 @@
  * EXPANDS TO:
  *
  * if mode server:
- *   sock=
et-flags TCP_NODELAY
  *   push "socket-flags TCP_NODELAY"
  */
 void
 help=
er_tcp_nodelay(struct options *o)
 {
-    if (o->server_flags & SF_TCP_NODE=
LAY_HELPER)
+    if ((o->server_flags & SF_TCP_NODELAY_HELPER) && o->mode =
=3D=3D MODE_SERVER)
     {
-        if (o->mode =3D=3D MODE_SERVER)
-      =
  {
-            o->sockflags |=3D SF_TCP_NODELAY;
-            push_option=
(o, print_str("socket-flags TCP_NODELAY", &o->gc), M_USAGE);
-        }
-  =
      else
-        {
-            o->sockflags |=3D SF_TCP_NODELAY;
-     =
   }
+        push_option(o, "socket-flags TCP_NODELAY", M_USAGE);
     }
 =
}
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index caaa769=2E=
=2E914d191 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ =
-2650,15 +2650,6 @@
         }
     }
 
-    if (found & OPT_P_SOCKFLAGS)
-=
    {
-        msg(D_PUSH, "OPTIONS IMPORT: --socket-flags option modified"=
);
-        for (int i =3D 0; i < c->c1=2Elink_sockets_num; i++)
-        {=

-            link_socket_update_flags(c->c2=2Elink_sockets[i], c->options=
=2Esockflags);
-        }
-    }
-
     if (found & OPT_P_PERSIST)
     {
 =
        msg(D_PUSH, "OPTIONS IMPORT: --persist options modified");
diff --g=
it a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 2424431=2E=2E7=
460a83 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@=
@ -486,8 +486,8 @@
     "                  virtual address table to v=2E\n"=

     "--bcast-buffers n : Allocate n broadcast buffers=2E\n"
     "--tcp-q=
ueue-limit n : Maximum number of queued TCP output packets=2E\n"
-    "--tc=
p-nodelay   : Macro that sets TCP_NODELAY socket flag on the server\n"
-   =
 "                  as well as pushes it to connecting clients=2E\n"
+    "=
--tcp-nodelay   : In server mode, push TCP_NODELAY to clients (it is\n"
+  =
  "                  enabled by default on the local socket)=2E\n"
     "--=
learn-address cmd : Run command cmd to validate client virtual addresses=2E=
\n"
     "--connect-freq n s : Allow a maximum of n new connections per s s=
econds=2E\n"
     "--connect-freq-initial n s : Allow a maximum of n replie=
s for initial connections attempts per s seconds=2E\n"
@@ -2618,6 +2618,13 =
@@
             MUST_BE_UNDEF(vlan_accept, "vlan-accept");
             MUS=
T_BE_UNDEF(vlan_pvid, "vlan-pvid");
         }
+
+        if (options->serv=
er_flags & SF_TCP_NODELAY_HELPER)
+        {
+            msg(M_INFO, "NOTE=
: TCP_NODELAY is always enabled locally; "
+                        "--tcp-=
nodelay is now only useful to push the flag to "
+                        "=
clients older than 2=2E7=2E6=2E");
+        }
     }
     else
     {
@@ -2=
648,9 +2655,7 @@
         MUST_BE_FALSE(options->ssl_flags & SSLF_AUTH_USER=
_PASS_OPTIONAL, "auth-user-pass-optional");
         if (options->server_fl=
ags & SF_TCP_NODELAY_HELPER)
         {
-            msg(M_WARN, "WARNING: =
setting tcp-nodelay on the client side will not "
-                        =
"affect the server=2E To have TCP_NODELAY in both direction use "
-        =
                "tcp-nodelay in the server configuration instead=2E");
+   =
         msg(M_WARN, "DEPRECATED OPTION: --tcp-nodelay is always enabled on=
 clients");
         }
         MUST_BE_UNDEF(auth_user_pass_verify_script,=
 "auth-user-pass-verify");
         MUST_BE_UNDEF(auth_token_generate, "aut=
h-gen-token");
@@ -6537,11 +6542,9 @@
         VERIFY_PERMISSION(OPT_P_SOCK=
FLAGS);
         for (j =3D 1; j < MAX_PARMS && p[j]; ++j)
         {
-    =
        if (streq(p[j], "TCP_NODELAY"))
-            {
-                opt=
ions->sockflags |=3D SF_TCP_NODELAY;
-            }
-            else
+    =
        /* TCP_NODELAY is enabled by default; the flag is still accepted
+ =
            * for backwards compatibility but no longer has any effect */
+=
            if (!streq(p[j], "TCP_NODELAY"))
             {
               =
  msg(msglevel, "unknown socket flag: %s", p[j]);
             }
diff --git=
 a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index df2cc9e=2E=2Eb73a5=
df 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -516=
,34 +516,6 @@
 #endif
 }
 
-static bool
-socket_set_flags(socket_descriptor=
_t sd, unsigned int sockflags)
-{
-    /* SF_TCP_NODELAY doesn't make sense=
 for dco-win */
-    if ((sockflags & SF_TCP_NODELAY) && (!(sockflags & SF_=
DCO_WIN)))
-    {
-        return socket_set_tcp_nodelay(sd, 1);
-    }
-  =
  else
-    {
-        return true;
-    }
-}
-
-bool
-link_socket_update_f=
lags(struct link_socket *sock, unsigned int sockflags)
-{
-    if (sock && =
socket_defined(sock->sd))
-    {
-        sock->sockflags |=3D sockflags;
-=
        return socket_set_flags(sock->sd, sock->sockflags);
-    }
-    els=
e
-    {
-        return false;
-    }
-}
-
 void
 link_socket_update_buffe=
r_sizes(struct link_socket *sock, int rcvbuf, int sndbuf)
 {
@@ -1485,8 +14=
57,12 @@
 static void
 phase2_set_socket_flags(struct link_socket *sock)
 {=

-    /* set misc socket parameters */
-    socket_set_flags(sock->sd, sock=
->sockflags);
+    /* TCP_NODELAY is enabled by default on every TCP socket=
; dco-win is
+     * skipped as it manages its own socket */
+    if (proto=
_is_tcp(sock->info=2Eproto) && !(sock->sockflags & SF_DCO_WIN))
+    {
+   =
     socket_set_tcp_nodelay(sock->sd, 1);
+    }
 
     /* set socket to no=
n-blocking mode */
     set_nonblock(sock->sd);
diff --git a/src/openvpn/so=
cket=2Eh b/src/openvpn/socket=2Eh
index cd4e8ed=2E=2E5883592 100644
--- a/s=
rc/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -207,7 +207,7 @@
    =
 int mtu; /* OS discovered MTU, or 0 if unknown */
 
 #define SF_USE_IP_PKT=
INFO    (1 << 0)
-#define SF_TCP_NODELAY       (1 << 1)
+#define SF_TCP_NOD=
ELAY       (1 << 1) /* unused: flag always enabled */
 #define SF_PORT_SHAR=
E        (1 << 2)
 #define SF_HOST_RANDOMIZE    (1 << 3)
 #define SF_GETADD=
RINFO_DGRAM (1 << 4)
@@ -390,8 +390,6 @@
 
 void setenv_trusted(struct env_=
set *es, const struct link_socket_info *info);
 
-bool link_socket_update_f=
lags(struct link_socket *sock, unsigned int sockflags);
-
 void link_socket=
_update_buffer_sizes(struct link_socket *sock, int rcvbuf, int sndbuf);
 
 =
/*

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I434a5373f77b0f75=
70a6a2aafe0eaf970e2eabe7
Gerrit-Change-Number: 1797
Gerrit-PatchSet: 4
Gerr=
it-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@gree=
nie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--E4zMDhMrrcI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1797?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Enable TCP_NODELAY by default and push it =
to clients<br><br>TCP_NODELAY had to be requested explicitly via<br>--tcp-n=
odelay or &quot;socket-flags TCP_NODELAY&quot;=2E Enable<br>it unconditiona=
lly on every TCP socket instead<br>(dco-win is skipped as it manages its ow=
n socket)=2E<br>The socket_set_flags() and<br>link_socket_update_flags() pl=
umbing that only ever<br>applied it is dropped; the SF_TCP_NODELAY sockflag=
<br>and &quot;socket-flags TCP_NODELAY&quot; become no-ops, the<br>latter k=
ept for backwards compatibility=2E<br><br>--tcp-nodelay no longer touches t=
he local socket<br>but, in --mode server, still pushes &quot;socket-flags<b=
r>TCP_NODELAY&quot; to clients, for the benefit of clients<br>older than 2=
=2E7=2E6 that do not enable it by default=2E<br>On a client the option is d=
eprecated and inert=2E It<br>can be dropped once such clients are gone=2E<b=
r><br>Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7<br>Signed-off-by=
: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1797<br>Message-Id: &lt;20260721124452=2E27832-1-gert@=
greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-dev=
el@lists=2Esourceforge=2Enet/msg37726=2Ehtml<br>Signed-off-by: Gert Doering=
 &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M doc/man-sections/link-options=
=2Erst<br>M src/openvpn/helper=2Ec<br>M src/openvpn/init=2Ec<br>M src/openv=
pn/options=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>6=
 files changed, 29 insertions(+), 81 deletions(-)<br><br></pre>
<pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/doc/man-sections/link-options=2Erst b/doc/man-sections/link-options=
=2Erst</span><br><span>index df8c917=2E=2E7c61b67 100644</span><br><span>--=
- a/doc/man-sections/link-options=2Erst</span><br><span>+++ b/doc/man-secti=
ons/link-options=2Erst</span><br><span>@@ -465,23 +465,20 @@</span><br><spa=
n>   trying to group several smaller packets into a larger packet=2E  This =
can</span><br><span>   result in a considerably improvement in latency=2E</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Thi=
s option is pushable from server to client, and should be used on</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  both client and server for ma=
ximum effect=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Si=
nce OpenVPN 2=2E7=2E6 :code:`TCP_NODELAY` is enabled by default on every TC=
P</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  socket, so speci=
fying it here is no longer necessary=2E</span><br><span> </span><br><span> =
--tcp-nodelay</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This m=
acro sets the :code:`TCP_NODELAY` socket flag on the server as well</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  as pushes it to connecting =
clients=2E The :code:`TCP_NODELAY` flag disables</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  the Nagle algorithm on TCP sockets causing pac=
kets to be transmitted</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  immediately with low latency, rather than waiting a short period of time=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  in order to aggrega=
te several packets into a larger containing packet=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  In VPN applications over TCP, :code:`TCP_=
NODELAY` is generally a good</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  latency optimization=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  :code:`TCP_NODELAY` is enabled by default on every TCP socke=
t=2E In</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--mode s=
erver`` this option additionally pushes</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  ``socket-flags TCP_NODELAY`` to connecting clients, s=
o that clients older</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  than 2=2E7=2E6 get it too=2E The option can be removed once such clients=
 are no</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  longer in =
use=2E</span><br><span> </span><br><span>   The macro expands as follows:</=
span><br><span>   ::</span><br><span> </span><br><span>      if mode server=
:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         socket-flag=
s TCP_NODELAY</span><br><span>          push &quot;socket-flags TCP_NODELAY=
&quot;</span><br><span> </span><br><span> --max-packet-size size</span><br>=
<span>diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec</span><b=
r><span>index 4c540a6=2E=2E7c186c5 100644</span><br><span>--- a/src/openvpn=
/helper=2Ec</span><br><span>+++ b/src/openvpn/helper=2Ec</span><br><span>@@=
 -99,14 +99,6 @@</span><br><span>     return BSTR(&amp;out);</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-p=
rint_str(const char *str, struct gc_arena *gc)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct buffer out =3D alloc_buf_gc(128, gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;%s&quot;, st=
r);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return BSTR(&a=
mp;out);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</sp=
an><br><span> helper_add_route(const in_addr_t network, const in_addr_t net=
mask, struct options *o)</span><br><span> {</span><br><span>@@ -597,22 +589=
,13 @@</span><br><span>  * EXPANDS TO:</span><br><span>  *</span><br><span>=
  * if mode server:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
   socket-flags TCP_NODELAY</span><br><span>  *   push &quot;socket-flags T=
CP_NODELAY&quot;</span><br><span>  */</span><br><span> void</span><br><span=
> helper_tcp_nodelay(struct options *o)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;server_flags &amp; SF_TC=
P_NODELAY_HELPER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if ((o-&gt;server_flags &amp; SF_TCP_NODELAY_HELPER) &amp;&amp; o-&gt;mod=
e =3D=3D MODE_SERVER)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (o-&gt;mode =3D=3D MODE_SERVER)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            o-&gt;sockflags |=3D SF_TCP_NOD=
ELAY;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            push=
_option(o, print_str(&quot;socket-flags TCP_NODELAY&quot;, &amp;o-&gt;gc), =
M_USAGE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            o-&gt;sockflags |=3D SF_TCP_NOD=
ELAY;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        push_option(o, &qu=
ot;socket-flags TCP_NODELAY&quot;, M_USAGE);</span><br><span>     }</span><=
br><span> }</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn=
/init=2Ec</span><br><span>index caaa769=2E=2E914d191 100644</span><br><span=
>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</spa=
n><br><span>@@ -2650,15 +2650,6 @@</span><br><span>         }</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (found &amp; OPT_P_SOCKFLAGS)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        msg(D_PUSH, &quot;OPTIONS IMPORT: --socket-flags option modifi=
ed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for=
 (int i =3D 0; i &lt; c-&gt;c1=2Elink_sockets_num; i++)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            link_socket_update_flags(c-&gt;c2=2Elink_=
sockets[i], c-&gt;options=2Esockflags);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span>     if (found &amp; OPT_P_PERSIST)</span><br><span>     {</span><br=
><span>         msg(D_PUSH, &quot;OPTIONS IMPORT: --persist options modifie=
d&quot;);</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvp=
n/options=2Ec</span><br><span>index 2424431=2E=2E7460a83 100644</span><br><=
span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/option=
s=2Ec</span><br><span>@@ -486,8 +486,8 @@</span><br><span>     &quot;      =
            virtual address table to v=2E\n&quot;</span><br><span>     &quo=
t;--bcast-buffers n : Allocate n broadcast buffers=2E\n&quot;</span><br><sp=
an>     &quot;--tcp-queue-limit n : Maximum number of queued TCP output pac=
kets=2E\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &q=
uot;--tcp-nodelay   : Macro that sets TCP_NODELAY socket flag on the server=
\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;   =
               as well as pushes it to connecting clients=2E\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--tcp-nodelay   =
: In server mode, push TCP_NODELAY to clients (it is\n&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &quot;                  enable=
d by default on the local socket)=2E\n&quot;</span><br><span>     &quot;--l=
earn-address cmd : Run command cmd to validate client virtual addresses=2E\=
n&quot;</span><br><span>     &quot;--connect-freq n s : Allow a maximum of =
n new connections per s seconds=2E\n&quot;</span><br><span>     &quot;--con=
nect-freq-initial n s : Allow a maximum of n replies for initial connection=
s attempts per s seconds=2E\n&quot;</span><br><span>@@ -2618,6 +2618,13 @@<=
/span><br><span>             MUST_BE_UNDEF(vlan_accept, &quot;vlan-accept&q=
uot;);</span><br><span>             MUST_BE_UNDEF(vlan_pvid, &quot;vlan-pvi=
d&quot;);</span><br><span>         }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (options-&gt;server_flags &amp; SF_TCP_NODELAY_HELPER)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_INFO, &quot;NOTE: TCP_N=
ODELAY is always enabled locally; &quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        &quot;--tcp-nodelay is now onl=
y useful to push the flag to &quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        &quot;clients older than 2=2E7=2E6=
=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span>     }</span><br><span>     else</span><br><span>     {</=
span><br><span>@@ -2648,9 +2655,7 @@</span><br><span>         MUST_BE_FALSE=
(options-&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL, &quot;auth-user-=
pass-optional&quot;);</span><br><span>         if (options-&gt;server_flags=
 &amp; SF_TCP_NODELAY_HELPER)</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WARNING: s=
etting tcp-nodelay on the client side will not &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        &quot;affect the se=
rver=2E To have TCP_NODELAY in both direction use &quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                        &quot;tcp-nodela=
y in the server configuration instead=2E&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;DEPRECATED OPTIO=
N: --tcp-nodelay is always enabled on clients&quot;);</span><br><span>     =
    }</span><br><span>         MUST_BE_UNDEF(auth_user_pass_verify_script, =
&quot;auth-user-pass-verify&quot;);</span><br><span>         MUST_BE_UNDEF(=
auth_token_generate, &quot;auth-gen-token&quot;);</span><br><span>@@ -6537,=
11 +6542,9 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_SOCKFLAGS);<=
/span><br><span>         for (j =3D 1; j &lt; MAX_PARMS &amp;&amp; p[j]; ++=
j)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            if (streq(p[j], &quot;TCP_NODELAY&quot;))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                options-&gt;sockflags |=3D =
SF_TCP_NODELAY;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* TC=
P_NODELAY is enabled by default; the flag is still accepted</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+             * for backwards compat=
ibility but no longer has any effect */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (!streq(p[j], &quot;TCP_NODELAY&quot;))<=
/span><br><span>             {</span><br><span>                 msg(msgleve=
l, &quot;unknown socket flag: %s&quot;, p[j]);</span><br><span>            =
 }</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=
=2Ec</span><br><span>index df2cc9e=2E=2Eb73a5df 100644</span><br><span>--- =
a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span=
><br><span>@@ -516,34 +516,6 @@</span><br><span> #endif</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socket_set_fla=
gs(socket_descriptor_t sd, unsigned int sockflags)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* SF_TCP_NODELAY doesn&#39;t make sense for dco-win */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((sockflags &amp; SF_=
TCP_NODELAY) &amp;&amp; (!(sockflags &amp; SF_DCO_WIN)))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        return socket_set_tcp_nodelay(sd, 1);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-li=
nk_socket_update_flags(struct link_socket *sock, unsigned int sockflags)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (sock &amp;&amp; socket_defined(sock=
-&gt;sd))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;sockflags |=
=3D sockflags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 return socket_set_flags(sock-&gt;sd, sock-&gt;sockflags);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> lin=
k_socket_update_buffer_sizes(struct link_socket *sock, int rcvbuf, int sndb=
uf)</span><br><span> {</span><br><span>@@ -1485,8 +1457,12 @@</span><br><sp=
an> static void</span><br><span> phase2_set_socket_flags(struct link_socket=
 *sock)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* set misc socket parameters */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    socket_set_flags(sock-&gt;sd, sock-&gt;sockflags);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TCP_NODELAY i=
s enabled by default on every TCP socket; dco-win is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * skipped as it manages its own sock=
et */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (proto_=
is_tcp(sock-&gt;info=2Eproto) &amp;&amp; !(sock-&gt;sockflags &amp; SF_DCO_=
WIN))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        socket_set_tcp_nodel=
ay(sock-&gt;sd, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span> </span><br><span>     /* set socket to non-blocking =
mode */</span><br><span>     set_nonblock(sock-&gt;sd);</span><br><span>dif=
f --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>i=
ndex cd4e8ed=2E=2E5883592 100644</span><br><span>--- a/src/openvpn/socket=
=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -207,7=
 +207,7 @@</span><br><span>     int mtu; /* OS discovered MTU, or 0 if unkn=
own */</span><br><span> </span><br><span> #define SF_USE_IP_PKTINFO    (1 &=
lt;&lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SF_=
TCP_NODELAY       (1 &lt;&lt; 1)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define SF_TCP_NODELAY       (1 &lt;&lt; 1) /* unused: flag al=
ways enabled */</span><br><span> #define SF_PORT_SHARE        (1 &lt;&lt; 2=
)</span><br><span> #define SF_HOST_RANDOMIZE    (1 &lt;&lt; 3)</span><br><s=
pan> #define SF_GETADDRINFO_DGRAM (1 &lt;&lt; 4)</span><br><span>@@ -390,8 =
+390,6 @@</span><br><span> </span><br><span> void setenv_trusted(struct env=
_set *es, const struct link_socket_info *info);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-bool link_socket_update_flags(s=
truct link_socket *sock, unsigned int sockflags);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> void link_socket_update_buffe=
r_sizes(struct link_socket *sock, int rcvbuf, int sndbuf);</span><br><span>=
 </span><br><span> /*</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail">change=
 1797</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
434a5373f77b0f7570a6a2aafe0eaf970e2eabe7 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1797 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>

</body></html>
--E4zMDhMrrcI=--


--===============3534928644337671314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3534928644337671314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3534928644337671314==--

