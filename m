Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8056FC5DF6A
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kc0SkWWgvKC7KL0P9kSWPAnE97slxpVp7eo4yu0w88M=; b=cpYLDTUz3psTfFwaUq+NEU/GPy
	hij5NKWDqhsJtVXQ7bH2EeE4Seg+IyOHj4FltjA7Bs3cQypbxLQ2FkhL8dMDsPU5UjQZKojuGz6tx
	/ej8rTc/wekr0n/N/EVXkk1J85ykeZuOq7RMU2HcToW4V7bxuHGQeEXEpl8+d8QUlKPE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuqXF-0001iy-2w;
	Fri, 14 Aug 2026 11:57:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuqWt-0001iK-1M
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:56:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AvbPVTJtpFSkFZKWTxxTabGxZcyle1pJxx5ktnk//kY=; b=l0c30pstUDwsGLNXywx5IIK7+L
 Xe6pK1pVABWhk80t7T8Xk566ynEVzXHPGz1928AW3WRZ10pfH7n6RIXto1AX7h2MxOHTf43slhDau
 LheHQXW35kRnGn6HqHgxQE5mZ2zHKUY5I7IPQ7rM9XpSsPxwlIbkOE897VGHboaQRkck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AvbPVTJtpFSkFZKWTxxTabGxZcyle1pJxx5ktnk//kY=; b=D
 mJAlT1T+PIqV4NwUibodfAJeI/5kEzzgMpDbpdWSZUZ/YYDG0L349ue4qm8yy3sQu9qtQEPNUEFxT
 P3chskjrdvD0nrJOdfj3CMEh2dkGxVwPqU4Bq2lGkMvyZYg7XdotrfOPo0VA94tzYEG6uccc/JcAU
 y6wcbkaAjK8J90rc=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuqWh-0004b2-Ba for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:56:46 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-499840a2575so7160525e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786708597; x=1787313397; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AvbPVTJtpFSkFZKWTxxTabGxZcyle1pJxx5ktnk//kY=;
 b=cIwowBPBPtpYjFSGMs9laY41/oWYogcaiN0COdN+JQAFv1Ve85f+5DMgS9tSHztoeB
 0svmMrzsN4B/YDcuEXAOwI1qdn2jiJaqse/AINVzcpXn/S0SfJ7WUCVPUTx46iopyJlg
 URp8BBYy4bNTYUBqO34t+FIBDz06SsdhpjYSsp2GlApg09wdYD3n5sL0WEmuCT38Yart
 vkoOVDj4TTAAHq1uY5+E/agwhA4Hhsdti2DFDyuLtT+wDLfqfYFg7I/zwjgIC9cXz7/v
 Ax9g2WizvOLuNUiQjsK6mhLrDcJST24Lo74Lc2MP7jEb+EsyoWkOYyLZplrazjMy5Y9z
 haUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786708597; x=1787313397;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AvbPVTJtpFSkFZKWTxxTabGxZcyle1pJxx5ktnk//kY=;
 b=XBm9TfvyKngRJJ9Oxp6XDvgEBp82whI2+lRhI1t/Hxu3lxQQCY9HGneuV4WteLpESy
 JlS/HYNPzjcwa4YdAJiryzuPVvC4WMNDoz08A0m/Cn9QyorjJIPyyUscKMRf2a0bzWSz
 pit/mEJhT+F4YUNwJtuz1jBS8ltL4ydSbglmgLMJT1i4KfOkdks05ih4Yh1ui9OpkJD6
 DLXO0EdIe3mabXq1tUqrf35WSaq1xdgTT+wVHNnGK5Kbg84joVdUE1fvM6sFrYlGlJxe
 JO84wyzChO8LssEQrLA3tPQ4P8NrVzHxYWl7n8eTo46bhTOf5hNAHhJ+KzfXjDxRGr48
 jHyg==
X-Gm-Message-State: AOJu0YxO2wLs+e1Hypcg+XdXNPlUO4/F+QIOhBV6LLEeKIrn+ifnFvmV
 diLbnRnTkVTNRkfXV0ZxVjLmTL13NVGhzDPhqJ2+lQ5qrxLn4dYO0IR8IQ+NYbCnlHs2bb0fCn0
 53qUl7CvNVxbmFvWWR0jstDadrMsKhFecHzcLTAZrQPJQ/K2+dgOC5DR7/mX8QG8OFOEpKB4NKd
 i1i6CbXQ==
X-Gm-Gg: AR+sD10kaHLPv8tQlLNnc8RmV9lDVdlyG+TuP0jR08e8ttdkFM7hWrUGs5MHAuiJhhx
 z8MGQ0bacVdw/QkBHP1x/AP++XQjcKV+zTJi6gcJgFyvCoXiGjC5advy0DtLETIH6Jrk8jvFmyF
 ByutuM0ontCkoeT95oLuoSxlqQnc3nr2NM7930hK3TuObzNzFMYqWSqRhOYWx0EgEfARdW0Co6e
 DrFtTRY2iC59lFfQle4S72u0x/MrM5wQK8PwrZfR0pPZyB4s6BJ7oqH5m9BkWWvqzwS6qdgntQy
 D6PyjxXTtbE90eIEF4Xq1QU8fclcsFKdMBWQhpzrZFMpKshORNlr1mczN4KV0zw6q+xiaVeo88y
 6I8uFAa94cn+pAkH/8dTfn0WlSQBC7+EWY3z2T91YSZj5N4EFW0HPZRO52GtFO8Tq7+wQoTfkbX
 0H69XCaQTmU61lv3ZpZC2Jcjh+i8e6yvkyHHSdITESOX984S+YiatEavcnh/d5ZJdxLq0uTVdHQ
 Qwp8WhC+3+xwOGmnnWWZWlO8bMY/xrqX6VeH3YzyMyLQT1E+z/UXrVpHs/oyanjyS76tNQxam8Z
 MSkFecBW22Y8U4Vtllhd3TwcGqphldksY3mitDr/cldxrAMIxcHB5AE6Bd7hfw==
X-Received: by 2002:a05:600c:828c:b0:495:3da3:beb with SMTP id
 5b1f17b1804b1-49989345963mr48586845e9.10.1786708596261; 
 Fri, 14 Aug 2026 04:56:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1a91sm7212039f8f.21.2026.08.14.04.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:56:35 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 11:56:29 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 7fb4963f5775ec258af08dbaeea4ce03e454ede2
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <96cbc601220159979984832f5fe60de041c1d2f4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuqWh-0004b2-Ba
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7122334822543866250=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7122334822543866250==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jpN8uSaCDNw="; charset=UTF-8

--jpN8uSaCDNw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1727?usp=3Demail

to look at the new patch set (#28)=
=2E


Change subject: Add lookup of multi session by session id
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add lookup of multi se=
ssion by session id

This refactors the way that we lookup control channel =
packets for UDP
packets from other peers=2E Instead of looking them up by t=
heir source
IP address, we lookup the session ids instead=2E

It also has t=
he consequence that we can have multiple ongoing
sessions from the same sou=
rce IP address and the new session will
go through all the connect steps li=
ke an initial session=2E

The check if the new session can take over the ol=
d session's IP
is now also the same as for floating=2E

This eliminates a w=
hole class of bugs that we currently have that
break connection if the reco=
nnecting client has different
capabilities as the setup and negotiation is =
inherited from the
previous client currently=2E Currently there is at least=
 one bug
regarding the dynamic tls-crypt in this situation=2E

This also ch=
anges the user visible behaviour for clients
reconnecting from the same IP =
and port=2E They are now almost
behaving like clients that reconnect from a=
 different IP
address=2E These now do the whole renegotiation and run
conne=
ct scripts/plugins and all the things are normally
skipped when reconnectin=
g from the same IP and port=2E

The only difference is that duplicate-cn do=
es not
allow both connection=2E

This will also eventually allow us to get =
rid of TM_INITIAL
slot as we now do no longer need to keep an ongoing and a=

new session anymore=2E Currently the p2p mode still needs
the extra sessio=
n slot for the new session so we cannot
remove it just yet=2E

This now all=
ows a multiple pending session from the
same source IP and port=2E Previous=
ly a client would need
to use a different ports to create multiple pending
=
session=2E This change does not make it really easier to
exhaust all pendin=
g session than before=2E

Change-Id: Idb59ecd119331b198792ad1379bec86002116=
51b
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt=

M doc/man-sections/advanced-options=2Erst
M src/openvpn/Makefile=2Eam
M sr=
c/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/ope=
nvpn/multi=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
A src/op=
envpn/sid_hash=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_te=
sts/openvpn/test_misc=2Ec
12 files changed, 269 insertions(+), 52 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27=
/1727/28

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 789c0d4=2E=
=2E3eb0062 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -842,6 +=
842,7 @@
         src/openvpn/siphash=2Eh
         src/openvpn/siphash=2Ec
=
         src/openvpn/siphash_reference=2Ec
+        src/openvpn/session_id=
=2Ec
     )
 
     target_sources(test_ncp PRIVATE
diff --git a/doc/man-sec=
tions/advanced-options=2Erst b/doc/man-sections/advanced-options=2Erst
inde=
x 3eff3085=2E=2Eb20c3f7 100644
--- a/doc/man-sections/advanced-options=2Ers=
t
+++ b/doc/man-sections/advanced-options=2Erst
@@ -29,16 +29,18 @@
 
 --ha=
sh-size args
   Set the size of the real address hash table to ``r`` and th=
e virtual
-  address table to ``v``=2E
+  address table to ``v``=2E If spec=
ified set the size of session id hash table
+  to ``s``=2E Otherwise ``s`` =
will be set to the same value as ``r``=2E
 
   Valid syntax:
   ::
 
-     =
hash-size r v
+     hash-size r v [s]
 
-  By default, both tables are size=
d at 4 times ``--max-clients`` buckets=2E
+  By default, all three tables a=
re sized at 4 times ``--max-clients`` buckets=2E
   With the default of 102=
4 of ``--max-clients`` this gives 4096 buckets=2E
 
+
 --bcast-buffers n
  =
 Allocate ``n`` buffers for broadcast datagrams (default :code:`256`)=2E
 
=
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index f5=
a7621=2E=2Eeb3533c 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn=
/Makefile=2Eam
@@ -127,6 +127,7 @@
 	schedule=2Ec schedule=2Eh \
 	session_=
id=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
+	sid_hash=2Eh \
 	sig=2E=
c sig=2Eh \
 	siphash_reference=2Ec \
 	siphash=2Ec siphash=2Eh \
diff --gi=
t a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index f000283=2E=2Eeb4e944 =
100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -42,36 +42,=
12 @@
 {
     struct gc_arena gc =3D gc_new();
     struct multi_instance *=
mi =3D NULL;
-    struct hash *hash =3D m->hash;
 
     mi =3D multi_create=
_instance(m, NULL, sock);
     if (mi)
     {
         mi->real=2Eproto =3D=
 sock->info=2Eproto;
-        struct hash_element *he;
-        const uint6=
4_t hv =3D hash_value(hash, &mi->real);
-        struct hash_bucket *bucket=
 =3D hash_bucket(hash, hv);
-
         multi_assign_peer_id(m, mi);
-
-    =
    he =3D hash_lookup_fast(hash, bucket, &mi->real, hv);
-
-        if (he=
)
-        {
-            struct multi_instance *oldmi =3D (struct multi_in=
stance *)he->value;
-            msg(D_MULTI_LOW,
-                "MULTI T=
CP: new incoming client address matches existing client address -- new clie=
nt takes precedence");
-            oldmi->did_real_hash =3D false;
-      =
      multi_close_instance(m, oldmi, false);
-            he->key =3D &mi->=
real;
-            he->value =3D mi;
-        }
-        else
-        {
- =
           hash_add_fast(hash, bucket, &mi->real, hv, mi);
-        }
-
-  =
      mi->did_real_hash =3D true;
     }
 
 #ifdef ENABLE_DEBUG
diff --git =
a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index f588515=2E=2E3d20b05 10=
0644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -32,6 +32,7 @=
@
 
 #include "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
+#include "sid_hash=2Eh"=

 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>
@@ -210,7 +211,7 =
@@
         }
         else
         {
-            msg(D_MULTI_DEBUG,
+   =
         msg(D_MULTI_MEDIUM,
                 "Valid packet (%s) with HMAC =
challenge from peer (%s), "
                 "accepting new connection=2E",=

                 packet_opcode_name(op), peer);
@@ -250,7 +251,6 @@
      =
   return NULL;
     }
 
-    struct hash *hash =3D m->hash;
     struct tl=
s_pre_decrypt_state state =3D { 0 };
     struct multi_instance *mi =3D NUL=
L;
 
@@ -272,11 +272,6 @@
             mi =3D multi_create_instance(m, real=
, sock);
             if (mi)
             {
-                const uint64_=
t hv =3D hash_value(hash, real);
-                struct hash_bucket *bucke=
t =3D hash_bucket(hash, hv);
-                hash_add_fast(hash, bucket, &=
mi->real, hv, mi);
-
-                mi->did_real_hash =3D true;
         =
        multi_assign_peer_id(m, mi);
 
                 /* If we have a ses=
sion id already, ensure that the
@@ -291,6 +286,7 @@
                      =
   mi->context=2Ec2=2Etls_multi->n_sessions++;
                         ses=
sion_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
             =
        }
+                    multi_hash_sid_add(m, &state=2Epeer_session_=
id, mi);
                 }
             }
         }
@@ -327,15 +323,26 @@=

     return NULL;
 }
 
-struct multi_instance *
-multi_get_instance_udp_co=
ntrol(struct multi_context *m, struct link_socket *sock)
-{
-    struct mro=
ute_addr real =3D { 0 };
-    real=2Eproto =3D sock->info=2Eproto;
 
-    i=
f (mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true)=
 && m->top=2Ec2=2Ebuf=2Elen > 0)
+static struct multi_instance *
+multi_get=
_instance_udp_control(struct multi_context *m)
+{
+    /* Copy buffer, to a=
 tmp buffer, so that reading the sesison does not
+     * modify the intern=
al pointers */
+    struct buffer tmp =3D m->top=2Ec2=2Ebuf;
+
+    /* op c=
ode */
+    uint8_t op =3D (uint8_t)buf_read_u8(&tmp) >> P_OPCODE_SHIFT;
+ =
   (void)op;
+
+    struct session_id sid =3D { 0 };
+    session_id_read(&=
sid, &tmp);
+
+    struct hash_element *he_sid =3D multi_hash_sid_lookup(m,=
 &sid);
+
+    if (he_sid)
     {
-        return multi_get_instance_udp_re=
al(m, &real);
+        return he_sid->value;
     }
 
     return NULL;
@@ =
-421,7 +428,14 @@
     }
     else
     {
-        mi =3D multi_get_instanc=
e_udp_control(m, sock);
+        if (m->top=2Ec2=2Ebuf=2Elen < (int)SID_SIZ=
E + 1)
+        {
+            /* control packets must be at least the opco=
de byte + session id
+             * (8 byte) long, otherwise they are not =
valid packets */
+            return NULL;
+        }
+
+        mi =3D mul=
ti_get_instance_udp_control(m);
 
         /* we have no existing multi ins=
tance for this connection, control
          * packets can create a session=
=2E Data packets cannot */
diff --git a/src/openvpn/multi=2Ec b/src/openvpn=
/multi=2Ec
index 20b4f14=2E=2E60e89fb 100644
--- a/src/openvpn/multi=2Ec
++=
+ b/src/openvpn/multi=2Ec
@@ -42,6 +42,7 @@
 #include "vlan=2Eh"
 #include =
"auth_token=2Eh"
 #include "route=2Eh"
+#include "sid_hash=2Eh"
 #include <=
inttypes=2Eh>
 #include <string=2Eh>
 
@@ -271,8 +272,8 @@
     struct mult=
i_context *m =3D t->multi;
     int dev =3D DEV_TYPE_UNDEF;
 
-    msg(D_MU=
LTI_LOW, "MULTI: multi_init called, r=3D%d v=3D%d", t->options=2Ereal_hash_=
size,
-        t->options=2Evirtual_hash_size);
+    msg(D_MULTI_LOW, "MULT=
I: multi_init called, r=3D%d v=3D%d s=3D%d", t->options=2Ereal_hash_size,
+=
        t->options=2Evirtual_hash_size, t->options=2Esid_hash_size);
 
    =
 /*
      * Get tun/tap/null device type
@@ -300,6 +301,12 @@
     m->vhash=
 =3D hash_init(t->options=2Evirtual_hash_size,
                          mr=
oute_addr_hash_function, mroute_addr_compare_function);
 
+    /*
+     * P=
eer session id hash table=2E Used to lookup a session by the session
+     =
* id of one of its active sessions */
+    m->sid_hash =3D hash_init(t->opt=
ions=2Esid_hash_size,
+                            session_id_hash_function=
, session_id_hash_equal);
+
 #ifdef ENABLE_MANAGEMENT
     m->cid_hash =3D =
hash_init(t->options=2Ereal_hash_size, cid_hash_function, cid_compare_funct=
ion);
 #endif
@@ -427,8 +434,7 @@
             buf_printf(&out, "%s/", cn);=

         }
         buf_printf(&out, "%s", mroute_addr_print(&mi->real, gc=
));
-        if (mi->context=2Ec2=2Etls_multi && check_debug_level(D_DCO_DE=
BUG)
-            && dco_enabled(&mi->context=2Eoptions))
+        if (mi->=
context=2Ec2=2Etls_multi)
         {
             buf_printf(&out, " rx-pee=
r-id=3D%d", mi->context=2Ec2=2Etls_multi->rx_peer_id);
         }
@@ -598,6=
 +604,12 @@
         }
 #endif
 
+
+        if (session_id_defined(&mi->sid=
_hashed_value))
+        {
+            multi_hash_sid_remove(m, &mi->sid_h=
ashed_value);
+        }
+
         if (mi->context=2Ec2=2Etls_multi->rx_pe=
er_id !=3D MAX_PEER_ID)
         {
             m->instances[mi->context=2E=
c2=2Etls_multi->rx_peer_id] =3D NULL;
@@ -672,6 +684,7 @@
 
         hash_f=
ree(m->hash);
         hash_free(m->vhash);
+        hash_free(m->sid_hash)=
;
 #ifdef ENABLE_MANAGEMENT
         hash_free(m->cid_hash);
 #endif
@@ -24=
56,6 +2469,34 @@
     multi_client_connect_setenv(mi);
 }
 
+static bool
+m=
ulti_check_dest_addr_allowed(struct multi_context *m, struct multi_instance=
 *mi, struct mroute_addr *real);
+
+/**
+ * This sets up the client real ad=
dress (outer tunnel addr) in the
+ * hash map for data channel packet=2E If=
 the address is already taken
+ * this steps fails
+ */
+static enum client=
_connect_return
+multi_client_connect_real_addr(struct multi_context *m, st=
ruct multi_instance *mi,
+                               bool deferred, uin=
t64_t *option_types_found)
+{
+    /* If the address is already taken up by=
 another client we fail the new
+     * connection */
+    if (!multi_check=
_dest_addr_allowed(m, mi, &mi->real))
+    {
+        msg(D_MULTI_ERRORS,
+=
            "MULTI: client IP address and port already assigned to another =
"
+            "client, terminating connection");
+        return CC_RET_FA=
ILED;
+    }
+
+    ASSERT(!mi->did_real_hash);
+    ASSERT(hash_add(m->has=
h, &mi->real, mi, false));
+    mi->did_real_hash =3D true;
+    return CC_=
RET_SUCCEEDED;
+}
+
 /**
  *  Do the necessary modification for doing the c=
ompress migrate=2E This is
  *  implemented as a connect handler as it fits=
 the modify config for a client
@@ -2550,6 +2591,7 @@
     uint64_t *option=
_types_found);
 
 static const multi_client_connect_handler client_connect_=
handlers[] =3D {
+    multi_client_connect_real_addr,
     multi_client_con=
nect_compress_migrate,
     multi_client_connect_source_ccd,
     multi_cli=
ent_connect_call_plugin_v1,
@@ -2618,6 +2660,7 @@
     }
     return true;
=
 }
+
 /*
  * Called as soon as the SSL/TLS connection is authenticated=2E
 =
 *
@@ -3104,7 +3147,7 @@
     /* do not allow if target address is taken by=
 client with another cert */
     if (!cert_hash_compare(m1->locked_cert_ha=
sh_set, m2->locked_cert_hash_set))
     {
-        msg(D_MULTI_LOW, "Disall=
ow float to an address taken by another client %s",
+        msg(D_MULTI_LO=
W, "Disallow float/connect to an address taken by another client %s",
     =
        multi_instance_string(ex_mi, false, &gc));
 
         mi->context=
=2Ec2=2Ebuf=2Elen =3D 0;
@@ -3117,7 +3160,7 @@
         if (!m1->locked_use=
rname || !m2->locked_username
             || strcmp(m1->locked_username, m=
2->locked_username) !=3D 0)
         {
-            msg(D_MULTI_LOW, "Disal=
low float to an address taken by another client %s",
+            msg(D_MUL=
TI_LOW, "Disallow float/connect to an address taken by another client %s",
=
                 multi_instance_string(ex_mi, false, &gc));
             go=
to done;
         }
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=
=2Eh
index 8b837fa=2E=2E98547b0 100644
--- a/src/openvpn/multi=2Eh
+++ b/sr=
c/openvpn/multi=2Eh
@@ -131,7 +131,15 @@
     in_addr_t reporting_addr;    =
        /* IP address shown in status listing */
     struct in6_addr repor=
ting_addr_ipv6; /* IPv6 address in status listing */
 
+    /** Indicates t=
hat the real address/port of the client is hashed in
+     * the multi_cont=
ext m->hash table=2E */
     bool did_real_hash;
+
+    /** If this is mult=
i_instance is hashed in the sid lookup table the session
+     * id here is=
 a non-null session id and the hash map's key pointer points
+     * to thi=
s field (the value pointer points to the whole struct) */
+    struct sessi=
on_id sid_hashed_value;
+
 #ifdef ENABLE_MANAGEMENT
     bool did_cid_hash;=

     struct buffer_list *cc_config;
@@ -170,6 +178,12 @@
                 =
                        *   address of the remote peer=2E */
     struct ha=
sh *vhash;                /**< VPN tunnel instances indexed by
            =
                             *   virtual address of remote hosts=2E */
+   =
 struct hash *sid_hash;             /**< TLS sessions indexed by the peer's=

+                                            session id=2E We do not care =
about
+                                            collisions here as clien=
ts should
+                                            have unique ids and =
supporting
+                                            clients with identi=
cal SIDs
+                                            is not needed */
    =
 struct schedule *schedule;
     struct mbuf_set *mbuf;             /**< Se=
t of buffers for passing data
                                         *   =
channel packets between VPN tunnel
diff --git a/src/openvpn/options=2Ec b/s=
rc/openvpn/options=2Ec
index d0f447c=2E=2E629652e 100644
--- a/src/openvpn/=
options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3764,6 +3764,10 @@
     {
   =
      o->virtual_hash_size =3D 4 * o->max_clients;
     }
+    if (!o->sid_=
hash_size)
+    {
+        o->sid_hash_size =3D o->real_hash_size;
+    }
 =
}
 
 static void
@@ -7367,7 +7371,7 @@
         options->ifconfig_ipv6_pool=
_base =3D network;
         options->ifconfig_ipv6_pool_netbits =3D netbits=
;
     }
-    else if (streq(p[0], "hash-size") && p[1] && p[2] && !p[3])
+=
    else if (streq(p[0], "hash-size") && p[1] && p[2] && !p[4])
     {
    =
     int real, virtual;
 
@@ -7379,6 +7383,16 @@
         }
         option=
s->real_hash_size =3D (uint32_t)real;
         options->virtual_hash_size =
=3D (uint32_t)virtual;
+
+        if (p[3])
+        {
+            int sid=
;
+            if (!atoi_constrained(p[3], &sid, "hash-size sid", 1, INT_MA=
X, msglevel))
+            {
+                goto err;
+            }
+   =
         options->sid_hash_size =3D (uint32_t)sid;
+        }
     }
     e=
lse if (streq(p[0], "connect-freq") && p[1] && p[2] && !p[3])
     {
diff -=
-git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 30a146f=2E=
=2Ec7825c7 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=
=2Eh
@@ -498,6 +498,7 @@
 
     uint32_t real_hash_size;
     uint32_t virt=
ual_hash_size;
+    uint32_t sid_hash_size;
     const char *client_connect=
_script;
     const char *client_disconnect_script;
     const char *learn_=
address_script;
diff --git a/src/openvpn/sid_hash=2Eh b/src/openvpn/sid_has=
h=2Eh
new file mode 100644
index 0000000=2E=2E4667fb1
--- /dev/null
+++ b/s=
rc/openvpn/sid_hash=2Eh
@@ -0,0 +1,90 @@
+/*
+ *  OpenVPN -- An application=
 to securely tunnel IP networks
+ *             over a single TCP/UDP port,=
 with support for SSL/TLS-based
+ *             session authentication and =
key exchange,
+ *             packet encryption, packet authentication, and=

+ *             packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN =
Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2026 Arne Schwabe <arne@rfc254=
9=2Eorg>
+ *
+ *
+ *  This program is free software; you can redistribute i=
t and/or modify
+ *  it under the terms of the GNU General Public License v=
ersion 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This=
 program is distributed in the hope that it will be useful,
+ *  but WITHOU=
T ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Lice=
nse for more details=2E
+ *
+ *  You should have received a copy of the GNU=
 General Public License along
+ *  with this program; if not, write to the =
Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Bos=
ton, MA 02110-1301 USA=2E
+ */
+
+#include "session_id=2Eh"
+#include "mult=
i=2Eh"
+#include "list=2Eh"
+#include "siphash=2Eh"
+
+inline static void
+=
multi_hash_sid_add(struct multi_context *m, struct session_id *sid,
+      =
             struct multi_instance *mi)
+{
+    /* This must only be called=
 if the multi instance is not already present
+     * in the hash table */
=
+    ASSERT(!session_id_defined(&mi->sid_hashed_value));
+
+    mi->sid_has=
hed_value =3D *sid;
+
+    const uint64_t hv =3D hash_value(m->sid_hash, &m=
i->sid_hashed_value);
+    struct hash_bucket *bucket =3D hash_bucket(m->si=
d_hash, hv);
+    hash_add_fast(m->sid_hash, bucket, &mi->sid_hashed_value,=
 hv, mi);
+    multi_instance_inc_refcount(mi);
+}
+
+static inline struct =
hash_element *
+multi_hash_sid_lookup(struct multi_context *m, const struct=
 session_id *sid)
+{
+    const uint64_t sid_hv =3D hash_value(m->sid_hash,=
 sid);
+    struct hash_bucket *sid_bucket =3D hash_bucket(m->sid_hash, sid=
_hv);
+    struct hash_element *he_sid =3D hash_lookup_fast(m->sid_hash, si=
d_bucket, sid, sid_hv);
+    return he_sid;
+}
+
+inline static bool
+multi=
_hash_sid_remove(struct multi_context *m, const struct session_id *sid)
+{
=
+    const uint64_t sid_hv =3D hash_value(m->sid_hash, sid);
+    struct ha=
sh_bucket *sid_bucket =3D hash_bucket(m->sid_hash, sid_hv);
+    struct has=
h_element *he_sid =3D hash_lookup_fast(m->sid_hash, sid_bucket, sid, sid_hv=
);
+    if (he_sid)
+    {
+        struct multi_instance *mi =3D he_sid->v=
alue;
+        ASSERT(hash_remove_fast(m->sid_hash, sid_bucket, sid, sid_hv=
));
+        CLEAR(mi->sid_hashed_value);
+        multi_instance_dec_refco=
unt(mi);
+        return true;
+    }
+    else
+    {
+        return fals=
e;
+    }
+}
+
+/* hashing the session=2E As the struct is just an 8 byte a=
rray
+ * hashing is straight forward */
+static inline uint64_t
+session_id=
_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
+{
+ =
   return siphash_hash_func(key, sizeof(struct session_id), hash_key);
+}
+=

+/* wrapper for session_id_equal to have the void* arguments that the
+ * =
hash map requires */
+static inline bool
+session_id_hash_equal(const void =
*sid1, const void *sid2)
+{
+    return session_id_equal((struct session_id=
 *)sid1, (struct session_id *)sid2);
+}
diff --git a/tests/unit_tests/openv=
pn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 6db611e=2E=
=2E7a8915b 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/=
unit_tests/openvpn/Makefile=2Eam
@@ -386,7 +386,8 @@
 	$(top_srcdir)/src/op=
envpn/otime=2Ec \
 	$(top_srcdir)/src/openvpn/schedule=2Ec \
 	$(top_srcdir=
)/src/openvpn/siphash=2Ec \
-	$(top_srcdir)/src/openvpn/siphash_reference=
=2Ec
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \
+	$(top_srcdir)/sr=
c/openvpn/session_id=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D -I$(top_s=
rcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tests/unit=
_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index=
 5f03860=2E=2E8b85b51 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+=
++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -40,12 +40,12 @@
 #include "=
list=2Eh"
 #include "mock_msg=2Eh"
 #include "crypto=2Eh"
+#include "sid_ha=
sh=2Eh"
 #ifdef _WIN32
 #include "win32-util=2Eh"
 #endif
 #include "test_s=
chedule=2Eh"
 
-
 static void
 test_compat_lzo_string(void **state)
 {
@@ -=
475,6 +475,65 @@
 }
 #endif /* _WIN32 */
 
+
+static void
+test_sid_hash_li=
st(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /* very simp=
le tests to ensure the basic hash functions work */
+
+    struct multi_con=
text m =3D { 0 };
+    m=2Esid_hash =3D hash_init(2048, session_id_hash_fun=
ction, session_id_hash_equal);
+
+    struct session_id sid1;
+    struct s=
ession_id sid2;
+    struct session_id sid3;
+
+    struct multi_instance *=
m1, *m3;
+
+    /* multi_hash_sid_remove will call gc_free on the gc of a m=
i and
+     * free on the mi itself */
+    ALLOC_OBJ_CLEAR(m1, struct mult=
i_instance);
+    ALLOC_OBJ_CLEAR(m3, struct multi_instance);
+
+    m1->gc=
 =3D gc_new();
+    m3->gc =3D gc_new();
+
+    session_id_random(&sid1);
+=
    session_id_random(&sid2);
+    session_id_random(&sid3);
+
+    multi_h=
ash_sid_add(&m, &sid1, m1);
+    multi_hash_sid_add(&m, &sid3, m3);
+
+
+  =
  /* sid2 is not added and should not be returned */
+    struct hash_eleme=
nt *he_sid =3D multi_hash_sid_lookup(&m, &sid2);
+    assert_null(he_sid);
=
+
+    he_sid =3D multi_hash_sid_lookup(&m, &sid1);
+    assert_non_null(he=
_sid);
+    assert_ptr_equal(he_sid->value, m1);
+
+    /* Try removing ele=
ments, only that are in the map should return true */
+    assert_true(mult=
i_hash_sid_remove(&m, &sid1));
+    assert_false(multi_hash_sid_remove(&m, =
&sid2));
+    assert_false(multi_hash_sid_remove(&m, &sid1));
+
+    /* sho=
uld no longer find the element */
+    he_sid =3D multi_hash_sid_lookup(&m,=
 &sid1);
+    assert_null(he_sid);
+
+    /* this element should still be i=
n the hash table */
+    he_sid =3D multi_hash_sid_lookup(&m, &sid3);
+    =
assert_ptr_equal(he_sid->value, m3);
+
+    assert_true(multi_hash_sid_remo=
ve(&m, &sid3));
+
+    hash_free(m=2Esid_hash);
+    gc_free(&gc);
+}
+
 co=
nst struct CMUnitTest misc_tests[] =3D {
 #ifdef _WIN32
     cmocka_unit_te=
st(test_win_path_in_dir),
@@ -485,7 +544,8 @@
     cmocka_unit_test(test_au=
th_fail_temp_flags_msg),
     cmocka_unit_test(test_list),
     cmocka_unit=
_test(test_atoi_variants),
-    cmocka_unit_test(schedule_test)
+    cmocka=
_unit_test(schedule_test),
+    cmocka_unit_test(test_sid_hash_list)
 };
 
=
 int

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb59ecd1193=
31b198792ad1379bec8600211651b
Gerrit-Change-Number: 1727
Gerrit-PatchSet: 2=
8
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>

--jpN8uSaCDNw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #28</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Add =
lookup of multi session by session id<br><br>This refactors the way that we=
 lookup control channel packets for UDP<br>packets from other peers=2E Inst=
ead of looking them up by their source<br>IP address, we lookup the session=
 ids instead=2E<br><br>It also has the consequence that we can have multipl=
e ongoing<br>sessions from the same source IP address and the new session w=
ill<br>go through all the connect steps like an initial session=2E<br><br>T=
he check if the new session can take over the old session&#39;s IP<br>is no=
w also the same as for floating=2E<br><br>This eliminates a whole class of =
bugs that we currently have that<br>break connection if the reconnecting cl=
ient has different<br>capabilities as the setup and negotiation is inherite=
d from the<br>previous client currently=2E Currently there is at least one =
bug<br>regarding the dynamic tls-crypt in this situation=2E<br><br>This als=
o changes the user visible behaviour for clients<br>reconnecting from the s=
ame IP and port=2E They are now almost<br>behaving like clients that reconn=
ect from a different IP<br>address=2E These now do the whole renegotiation =
and run<br>connect scripts/plugins and all the things are normally<br>skipp=
ed when reconnecting from the same IP and port=2E<br><br>The only differenc=
e is that duplicate-cn does not<br>allow both connection=2E<br><br>This wil=
l also eventually allow us to get rid of TM_INITIAL<br>slot as we now do no=
 longer need to keep an ongoing and a<br>new session anymore=2E Currently t=
he p2p mode still needs<br>the extra session slot for the new session so we=
 cannot<br>remove it just yet=2E<br><br>This now allows a multiple pending =
session from the<br>same source IP and port=2E Previously a client would ne=
ed<br>to use a different ports to create multiple pending<br>session=2E Thi=
s change does not make it really easier to<br>exhaust all pending session t=
han before=2E<br><br>Change-Id: Idb59ecd119331b198792ad1379bec8600211651b<b=
r>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeL=
ists=2Etxt<br>M doc/man-sections/advanced-options=2Erst<br>M src/openvpn/Ma=
kefile=2Eam<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/op=
envpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/options=2Ec<br>=
M src/openvpn/options=2Eh<br>A src/openvpn/sid_hash=2Eh<br>M tests/unit_tes=
ts/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>12 =
files changed, 269 insertions(+), 52 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/172=
7/28</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><sp=
an>index 789c0d4=2E=2E3eb0062 100644</span><br><span>--- a/CMakeLists=2Etxt=
</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -842,6 +842,7 @@=
</span><br><span>         src/openvpn/siphash=2Eh</span><br><span>         =
src/openvpn/siphash=2Ec</span><br><span>         src/openvpn/siphash_refere=
nce=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/=
openvpn/session_id=2Ec</span><br><span>     )</span><br><span> </span><br><=
span>     target_sources(test_ncp PRIVATE</span><br><span>diff --git a/doc/=
man-sections/advanced-options=2Erst b/doc/man-sections/advanced-options=2Er=
st</span><br><span>index 3eff3085=2E=2Eb20c3f7 100644</span><br><span>--- a=
/doc/man-sections/advanced-options=2Erst</span><br><span>+++ b/doc/man-sect=
ions/advanced-options=2Erst</span><br><span>@@ -29,16 +29,18 @@</span><br><=
span> </span><br><span> --hash-size args</span><br><span>   Set the size of=
 the real address hash table to ``r`` and the virtual</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  address table to ``v``=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  address table to ``v``=2E If spec=
ified set the size of session id hash table</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  to ``s``=2E Otherwise ``s`` will be set to the sa=
me value as ``r``=2E</span><br><span> </span><br><span>   Valid syntax:</sp=
an><br><span>   ::</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     hash-size r v</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     hash-size r v [s]</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  By default, both tables are sized at 4 t=
imes ``--max-clients`` buckets=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  By default, all three tables are sized at 4 times ``--max-c=
lients`` buckets=2E</span><br><span>   With the default of 1024 of ``--max-=
clients`` this gives 4096 buckets=2E</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --bcast-buffers n</spa=
n><br><span>   Allocate ``n`` buffers for broadcast datagrams (default :cod=
e:`256`)=2E</span><br><span> </span><br><span>diff --git a/src/openvpn/Make=
file=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index f5a7621=2E=2Eeb=
3533c 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><spa=
n>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -127,6 +127,7 @@</span=
><br><span> 	schedule=2Ec schedule=2Eh \</span><br><span> 	session_id=2Ec s=
ession_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	sid_hash=2Eh \</span><br><span> 	sig=
=2Ec sig=2Eh \</span><br><span> 	siphash_reference=2Ec \</span><br><span> 	=
siphash=2Ec siphash=2Eh \</span><br><span>diff --git a/src/openvpn/mtcp=2Ec=
 b/src/openvpn/mtcp=2Ec</span><br><span>index f000283=2E=2Eeb4e944 100644</=
span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn=
/mtcp=2Ec</span><br><span>@@ -42,36 +42,12 @@</span><br><span> {</span><br>=
<span>     struct gc_arena gc =3D gc_new();</span><br><span>     struct mul=
ti_instance *mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct hash *hash =3D m-&gt;hash;</span><br><span> </span><br><span=
>     mi =3D multi_create_instance(m, NULL, sock);</span><br><span>     if =
(mi)</span><br><span>     {</span><br><span>         mi-&gt;real=2Eproto =
=3D sock-&gt;info=2Eproto;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        struct hash_element *he;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        const uint64_t hv =3D hash_value(hash, &amp;mi-&gt;=
real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct =
hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span>         multi_assign_peer_id(m, =
mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        he =3D hash_lookup_fast(hash, =
bucket, &amp;mi-&gt;real, hv);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
he)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            struct multi_insta=
nce *oldmi =3D (struct multi_instance *)he-&gt;value;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                &quot;MULTI TCP: new=
 incoming client address matches existing client address -- new client take=
s precedence&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           oldmi-&gt;did_real_hash =3D false;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            multi_close_instance(m, oldmi, false);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            he-&gt;key=
 =3D &amp;mi-&gt;real;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            he-&gt;value =3D mi;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            hash_add_=
fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
i-&gt;did_real_hash =3D true;</span><br><span>     }</span><br><span> </spa=
n><br><span> #ifdef ENABLE_DEBUG</span><br><span>diff --git a/src/openvpn/m=
udp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index f588515=2E=2E3d20b05 1=
00644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/=
openvpn/mudp=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> </span>=
<br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;=
ssl_pkt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;sid_hash=2Eh&quot;</span><br><span> </span><br><span> #ifdef H=
AVE_SYS_INOTIFY_H</span><br><span> #include &lt;sys/inotify=2Eh&gt;</span><=
br><span>@@ -210,7 +211,7 @@</span><br><span>         }</span><br><span>   =
      else</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            msg(D_MULTI_DEBUG,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            msg(D_MULTI_MEDIUM,</span><br><span>=
                 &quot;Valid packet (%s) with HMAC challenge from peer (%s)=
, &quot;</span><br><span>                 &quot;accepting new connection=2E=
&quot;,</span><br><span>                 packet_opcode_name(op), peer);</sp=
an><br><span>@@ -250,7 +251,6 @@</span><br><span>         return NULL;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span><br><span>     s=
truct tls_pre_decrypt_state state =3D { 0 };</span><br><span>     struct mu=
lti_instance *mi =3D NULL;</span><br><span> </span><br><span>@@ -272,11 +27=
2,6 @@</span><br><span>             mi =3D multi_create_instance(m, real, s=
ock);</span><br><span>             if (mi)</span><br><span>             {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                const u=
int64_t hv =3D hash_value(hash, real);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                struct hash_bucket *bucket =3D hash_bucket=
(hash, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                mi-&gt;did_real_hash =3D true;</span><br>=
<span>                 multi_assign_peer_id(m, mi);</span><br><span> </span=
><br><span>                 /* If we have a session id already, ensure that=
 the</span><br><span>@@ -291,6 +286,7 @@</span><br><span>                  =
       mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions++;</span><br><span>  =
                       session_skip_to_pre_start(session, &amp;state, &amp;=
m-&gt;top=2Ec2=2Efrom);</span><br><span>                     }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    multi_hash_s=
id_add(m, &amp;state=2Epeer_session_id, mi);</span><br><span>              =
   }</span><br><span>             }</span><br><span>         }</span><br><s=
pan>@@ -327,15 +323,26 @@</span><br><span>     return NULL;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-multi_get_instance_udp_control(struct multi_context *m, struct link_socke=
t *sock)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct mroute_addr real =3D {=
 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    real=2Eproto=
 =3D sock-&gt;info=2Eproto;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (mroute_extract_openvpn_sockaddr(&amp;real, =
&amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2E=
len &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static s=
truct multi_instance *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+multi_get_instance_udp_control(struct multi_context *m)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Copy buffer, to a tmp buffer, so that reading t=
he sesison does not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * modify the internal pointers */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer tmp =3D m-&gt;top=2Ec2=2Ebuf;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* op code */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint8_t op =3D (uint8_t)buf_read_u8(&amp;tmp)=
 &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    (void)op;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_=
id sid =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  session_id_read(&amp;sid, &amp;tmp);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct hash_element *he_sid =3D multi_hash_sid_lookup(m, &amp;sid);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (he_sid)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return multi_get=
_instance_udp_real(m, &amp;real);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return he_sid-&gt;value;</span><br><span>     }</span=
><br><span> </span><br><span>     return NULL;</span><br><span>@@ -421,7 +4=
28,14 @@</span><br><span>     }</span><br><span>     else</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi =3D m=
ulti_get_instance_udp_control(m, sock);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (m-&gt;top=2Ec2=2Ebuf=2Elen &lt; (int)SID_SI=
ZE + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* control=
 packets must be at least the opcode byte + session id</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+             * (8 byte) long, otherwise =
they are not valid packets */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            return NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi =3D=
 multi_get_instance_udp_control(m);</span><br><span> </span><br><span>     =
    /* we have no existing multi instance for this connection, control</spa=
n><br><span>          * packets can create a session=2E Data packets cannot=
 */</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index 20b4f14=2E=2E60e89fb 100644</span><br><span>--- =
a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><=
br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;vlan=2Eh&quot;</=
span><br><span> #include &quot;auth_token=2Eh&quot;</span><br><span> #inclu=
de &quot;route=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;sid_hash=2Eh&quot;</span><br><span> #include &lt;inttyp=
es=2Eh&gt;</span><br><span> #include &lt;string=2Eh&gt;</span><br><span> </=
span><br><span>@@ -271,8 +272,8 @@</span><br><span>     struct multi_contex=
t *m =3D t-&gt;multi;</span><br><span>     int dev =3D DEV_TYPE_UNDEF;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(=
D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%d v=3D%d&quot;, t-&gt;opt=
ions=2Ereal_hash_size,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        t-&gt;options=2Evirtual_hash_size);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    msg(D_MULTI_LOW, &quot;MULTI: multi_init calle=
d, r=3D%d v=3D%d s=3D%d&quot;, t-&gt;options=2Ereal_hash_size,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;options=2Evirtual_=
hash_size, t-&gt;options=2Esid_hash_size);</span><br><span> </span><br><spa=
n>     /*</span><br><span>      * Get tun/tap/null device type</span><br><s=
pan>@@ -300,6 +301,12 @@</span><br><span>     m-&gt;vhash =3D hash_init(t-&=
gt;options=2Evirtual_hash_size,</span><br><span>                          m=
route_addr_hash_function, mroute_addr_compare_function);</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * Peer session id hash table=
=2E Used to lookup a session by the session</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * id of one of its active sessions */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;sid_hash =3D hash_=
init(t-&gt;options=2Esid_hash_size,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                            session_id_hash_function, sessi=
on_id_hash_equal);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     m-&gt;cid_ha=
sh =3D hash_init(t-&gt;options=2Ereal_hash_size, cid_hash_function, cid_com=
pare_function);</span><br><span> #endif</span><br><span>@@ -427,8 +434,7 @@=
</span><br><span>             buf_printf(&amp;out, &quot;%s/&quot;, cn);</s=
pan><br><span>         }</span><br><span>         buf_printf(&amp;out, &quo=
t;%s&quot;, mroute_addr_print(&amp;mi-&gt;real, gc));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;context=2Ec2=2Etls_multi=
 &amp;&amp; check_debug_level(D_DCO_DEBUG)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            &amp;&amp; dco_enabled(&amp;mi-&gt;context=
=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (mi-&gt;context=2Ec2=2Etls_multi)</span><br><span>         {</span><br>=
<span>             buf_printf(&amp;out, &quot; rx-peer-id=3D%d&quot;, mi-&g=
t;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span>         }</spa=
n><br><span>@@ -598,6 +604,12 @@</span><br><span>         }</span><br><span=
> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
session_id_defined(&amp;mi-&gt;sid_hashed_value))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            multi_hash_sid_remove(m, &amp;mi-&gt;sid_ha=
shed_value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
         if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_I=
D)</span><br><span>         {</span><br><span>             m-&gt;instances[=
mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NULL;</span><br><span>@=
@ -672,6 +684,7 @@</span><br><span> </span><br><span>         hash_free(m-&=
gt;hash);</span><br><span>         hash_free(m-&gt;vhash);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        hash_free(m-&gt;sid_hash);</=
span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>         hash_free=
(m-&gt;cid_hash);</span><br><span> #endif</span><br><span>@@ -2456,6 +2469,=
34 @@</span><br><span>     multi_client_connect_setenv(mi);</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_=
check_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi,=
 struct mroute_addr *real);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * This sets up the client =
real address (outer tunnel addr) in the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * hash map for data channel packet=2E If the address i=
s already taken</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * t=
his steps fails</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static enum client_c=
onnect_return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_=
client_connect_real_addr(struct multi_context *m, struct multi_instance *mi=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
             bool deferred, uint64_t *option_types_found)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* If the address is already taken up by another cl=
ient we fail the new</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * connection */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!multi_check_dest_addr_allowed(m, mi, &amp;mi-&gt;real))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_ERRORS,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            &quot;MULTI: client I=
P address and port already assigned to another &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;client, terminating con=
nection&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return CC_RET_FAILED;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!mi-&gt;did_real=
_hash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(h=
ash_add(m-&gt;hash, &amp;mi-&gt;real, mi, false));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    mi-&gt;did_real_hash =3D true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return CC_RET_SUCCEEDED;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>=
  *  Do the necessary modification for doing the compress migrate=2E This i=
s</span><br><span>  *  implemented as a connect handler as it fits the modi=
fy config for a client</span><br><span>@@ -2550,6 +2591,7 @@</span><br><spa=
n>     uint64_t *option_types_found);</span><br><span> </span><br><span> st=
atic const multi_client_connect_handler client_connect_handlers[] =3D {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_client_connec=
t_real_addr,</span><br><span>     multi_client_connect_compress_migrate,</s=
pan><br><span>     multi_client_connect_source_ccd,</span><br><span>     mu=
lti_client_connect_call_plugin_v1,</span><br><span>@@ -2618,6 +2660,7 @@</s=
pan><br><span>     }</span><br><span>     return true;</span><br><span> }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*<=
/span><br><span>  * Called as soon as the SSL/TLS connection is authenticat=
ed=2E</span><br><span>  *</span><br><span>@@ -3104,7 +3147,7 @@</span><br><=
span>     /* do not allow if target address is taken by client with another=
 cert */</span><br><span>     if (!cert_hash_compare(m1-&gt;locked_cert_has=
h_set, m2-&gt;locked_cert_hash_set))</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_LOW, &quot;Disall=
ow float to an address taken by another client %s&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;Disallo=
w float/connect to an address taken by another client %s&quot;,</span><br><=
span>             multi_instance_string(ex_mi, false, &amp;gc));</span><br>=
<span> </span><br><span>         mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</sp=
an><br><span>@@ -3117,7 +3160,7 @@</span><br><span>         if (!m1-&gt;loc=
ked_username || !m2-&gt;locked_username</span><br><span>             || str=
cmp(m1-&gt;locked_username, m2-&gt;locked_username) !=3D 0)</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(D_MULTI_LOW, &quot;Disallow float to an address taken by another clie=
nt %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(D_MULTI_LOW, &quot;Disallow float/connect to an address taken by a=
nother client %s&quot;,</span><br><span>                 multi_instance_str=
ing(ex_mi, false, &amp;gc));</span><br><span>             goto done;</span>=
<br><span>         }</span><br><span>diff --git a/src/openvpn/multi=2Eh b/s=
rc/openvpn/multi=2Eh</span><br><span>index 8b837fa=2E=2E98547b0 100644</spa=
n><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/m=
ulti=2Eh</span><br><span>@@ -131,7 +131,15 @@</span><br><span>     in_addr_=
t reporting_addr;            /* IP address shown in status listing */</span=
><br><span>     struct in6_addr reporting_addr_ipv6; /* IPv6 address in sta=
tus listing */</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /** Indicates that the real address/port of the client is =
hashed in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the=
 multi_context m-&gt;hash table=2E */</span><br><span>     bool did_real_ha=
sh;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /** If this is multi_instance i=
s hashed in the sid lookup table the session</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * id here is a non-null session id and the ha=
sh map&#39;s key pointer points</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * to this field (the value pointer points to the whole str=
uct) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct s=
ession_id sid_hashed_value;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     boo=
l did_cid_hash;</span><br><span>     struct buffer_list *cc_config;</span><=
br><span>@@ -170,6 +178,12 @@</span><br><span>                             =
            *   address of the remote peer=2E */</span><br><span>     struc=
t hash *vhash;                /**&lt; VPN tunnel instances indexed by</span=
><br><span>                                         *   virtual address of =
remote hosts=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct hash *sid_hash;             /**&lt; TLS sessions indexed by the p=
eer&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                  session id=2E We do not care about</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
                  collisions here as clients should</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
   have unique ids and supporting</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                            clients with iden=
tical SIDs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                   is not needed */</span><br><span>     st=
ruct schedule *schedule;</span><br><span>     struct mbuf_set *mbuf;       =
      /**&lt; Set of buffers for passing data</span><br><span>             =
                            *   channel packets between VPN tunnel</span><b=
r><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</spa=
n><br><span>index d0f447c=2E=2E629652e 100644</span><br><span>--- a/src/ope=
nvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><s=
pan>@@ -3764,6 +3764,10 @@</span><br><span>     {</span><br><span>         =
o-&gt;virtual_hash_size =3D 4 * o-&gt;max_clients;</span><br><span>     }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;sid_ha=
sh_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;sid_hash_si=
ze =3D o-&gt;real_hash_size;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span> }</span><br><span> </span><br><span> static=
 void</span><br><span>@@ -7367,7 +7371,7 @@</span><br><span>         option=
s-&gt;ifconfig_ipv6_pool_base =3D network;</span><br><span>         options=
-&gt;ifconfig_ipv6_pool_netbits =3D netbits;</span><br><span>     }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quo=
t;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &=
quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</sp=
an><br><span>     {</span><br><span>         int real, virtual;</span><br><=
span> </span><br><span>@@ -7379,6 +7383,16 @@</span><br><span>         }</s=
pan><br><span>         options-&gt;real_hash_size =3D (uint32_t)real;</span=
><br><span>         options-&gt;virtual_hash_size =3D (uint32_t)virtual;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (p[3])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            int sid;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (!atoi_constrained(p[3], &amp;sid, =
&quot;hash-size sid&quot;, 1, INT_MAX, msglevel))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                goto err;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            options-&gt;sid_hash_size =3D (uint32_t=
)sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span>     }</span><br><span>     else if (streq(p[0], &quot;connect-=
freq&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><sp=
an>     {</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvp=
n/options=2Eh</span><br><span>index 30a146f=2E=2Ec7825c7 100644</span><br><=
span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/option=
s=2Eh</span><br><span>@@ -498,6 +498,7 @@</span><br><span> </span><br><span=
>     uint32_t real_hash_size;</span><br><span>     uint32_t virtual_hash_s=
ize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t si=
d_hash_size;</span><br><span>     const char *client_connect_script;</span>=
<br><span>     const char *client_disconnect_script;</span><br><span>     c=
onst char *learn_address_script;</span><br><span>diff --git a/src/openvpn/s=
id_hash=2Eh b/src/openvpn/sid_hash=2Eh</span><br><span>new file mode 100644=
</span><br><span>index 0000000=2E=2E4667fb1</span><br><span>--- /dev/null</=
span><br><span>+++ b/src/openvpn/sid_hash=2Eh</span><br><span>@@ -0,0 +1,90=
 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to =
securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             over a single TCP/UDP port, with support for SSL/TLS=
-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  session authentication and key exchange,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             packet encryption, packet authenticat=
ion, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrig=
ht (C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;a=
rne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softwar=
e; you can redistribute it and/or modify</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licen=
se version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as =
published by the Free Software Foundation=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is distributed in the hope that it will be useful,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, write to the Free Software Foundation, Inc=2E,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;session_id=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;list=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+inline static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+multi_hash_sid_add(struct multi_context *m, struct se=
ssion_id *sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
              struct multi_instance *mi)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* This must only be called if the multi instance is not already pre=
sent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * in the h=
ash table */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASS=
ERT(!session_id_defined(&amp;mi-&gt;sid_hashed_value));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    mi-&gt;sid_hashed_value =3D *sid;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const uint64_t hv =3D hash_value(m-&gt;sid_hash, &amp;m=
i-&gt;sid_hashed_value);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct hash_bucket *bucket =3D hash_bucket(m-&gt;sid_hash, hv);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    hash_add_fast(m-&g=
t;sid_hash, bucket, &amp;mi-&gt;sid_hashed_value, hv, mi);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    multi_instance_inc_refcount(mi);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static inline struct hash_element *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_lookup(struct multi_conte=
xt *m, const struct session_id *sid)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const uint64_t sid_hv =3D hash_value(m-&gt;sid_hash, sid);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket *sid_bucke=
t =3D hash_bucket(m-&gt;sid_hash, sid_hv);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct hash_element *he_sid =3D hash_lookup_fast=
(m-&gt;sid_hash, sid_bucket, sid, sid_hv);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return he_sid;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+inline static b=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_r=
emove(struct multi_context *m, const struct session_id *sid)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const uint64_t sid_hv =3D hash_value(m-&gt;sid_h=
ash, sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t hash_bucket *sid_bucket =3D hash_bucket(m-&gt;sid_hash, sid_hv);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *he_=
sid =3D hash_lookup_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (he_sid)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        struct multi_instance *mi =3D he_sid-&=
gt;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        AS=
SERT(hash_remove_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(mi-&gt;sid_hashe=
d_value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mu=
lti_instance_dec_refcount(mi);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* hashing the session=2E As the struct is just an 8 byte array</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * hashing is straight forward *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline uint=
64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+session_id_hash=
_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return siphash_hash_func(key, sizeof(struct =
session_id), hash_key);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* wrapper for session_id_equal t=
o have the void* arguments that the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * hash map requires */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+session_id_hash_equal(const void *sid1, const void *sid2=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return session_id_equal((struct =
session_id *)sid1, (struct session_id *)sid2);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/=
openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><s=
pan>index 6db611e=2E=2E7a8915b 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Make=
file=2Eam</span><br><span>@@ -386,7 +386,8 @@</span><br><span> 	$(top_srcdi=
r)/src/openvpn/otime=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/sche=
dule=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/siphash=2Ec \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/s=
iphash_reference=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/session_id=2Ec=
</span><br><span> </span><br><span> push_update_msg_testdriver_CFLAGS =3D -=
I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/test=
s/unit_tests/openvpn/test_misc=2Ec</span><br><span>index 5f03860=2E=2E8b85b=
51 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@=
 -40,12 +40,12 @@</span><br><span> #include &quot;list=2Eh&quot;</span><br>=
<span> #include &quot;mock_msg=2Eh&quot;</span><br><span> #include &quot;cr=
ypto=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;sid_hash=2Eh&quot;</span><br><span> #ifdef _WIN32</span><br><span=
> #include &quot;win32-util=2Eh&quot;</span><br><span> #endif</span><br><sp=
an> #include &quot;test_schedule=2Eh&quot;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span>=
<br><span> test_compat_lzo_string(void **state)</span><br><span> {</span><b=
r><span>@@ -475,6 +475,65 @@</span><br><span> }</span><br><span> #endif /* =
_WIN32 */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_sid_hash_list(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 very simple tests to ensure the basic hash functions work */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct multi_context m =3D { 0 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    m=2Esid_hash =3D hash_init(204=
8, session_id_hash_function, session_id_hash_equal);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct session_id sid1;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct session_id sid2;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct session_id sid3;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct multi_instance *m1, *m3;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* multi_hash_sid_remove will call gc_free on the gc o=
f a mi and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * fr=
ee on the mi itself */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ALLOC_OBJ_CLEAR(m1, struct multi_instance);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(m3, struct multi_instanc=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    m1-&gt;gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    m3-&gt;gc =3D gc_new();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&amp;sid1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&a=
mp;sid2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sessio=
n_id_random(&amp;sid3);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_hash_=
sid_add(&amp;m, &amp;sid1, m1);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    multi_hash_sid_add(&amp;m, &amp;sid3, m3);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* sid2 is not added and should not be returned */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *he_sid =3D mul=
ti_hash_sid_lookup(&amp;m, &amp;sid2);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_null(he_sid);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid1);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(he_sid);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(he_=
sid-&gt;value, m1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Try removing=
 elements, only that are in the map should return true */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(multi_hash_sid_remove=
(&amp;m, &amp;sid1));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(multi_hash_sid_remove(&amp;m, &amp;sid2));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(multi_hash_sid_r=
emove(&amp;m, &amp;sid1));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* shoul=
d no longer find the element */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid1);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(he_sid);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* this element should still be in t=
he hash table */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid3);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(he_sid-&gt;value, m3=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(multi_hash_sid_remov=
e(&amp;m, &amp;sid3));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hash_free(m=
=2Esid_hash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> cons=
t struct CMUnitTest misc_tests[] =3D {</span><br><span> #ifdef _WIN32</span=
><br><span>     cmocka_unit_test(test_win_path_in_dir),</span><br><span>@@ =
-485,7 +544,8 @@</span><br><span>     cmocka_unit_test(test_auth_fail_temp_=
flags_msg),</span><br><span>     cmocka_unit_test(test_list),</span><br><sp=
an>     cmocka_unit_test(test_atoi_variants),</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    cmocka_unit_test(schedule_test)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(schedule_test)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_te=
st(test_sid_hash_list)</span><br><span> };</span><br><span> </span><br><spa=
n> int</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59ecd119=
331b198792ad1379bec8600211651b </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 28 =
</div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--jpN8uSaCDNw=--


--===============7122334822543866250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7122334822543866250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7122334822543866250==--

