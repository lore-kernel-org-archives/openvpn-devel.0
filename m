Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C65CCA490
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 11:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TnvgXNOheGKgenRv7OPAjnYDGtMqRb1qP04otdtxshY=; b=K+Hw2FQzNyWHFNsPKvLda2piPr
	VCGfyGiLV/H50MvRGd79Yktdg6dLAyHKBJqxtfm1KqK72SrrqjE+aXPyaWOtf5UI/WbMq9VyhLwtp
	13GDW5EpbuPXPIjHJNyAFd7blRQtlwRp6YfsC3liK6suGE07CLxsEfep9k71zxe55Z4I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIP85-0004ux-5X;
	Sun, 18 Oct 2026 11:32:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIP83-0004up-4Z
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 11:32:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vzDAIArfyLMvNTGZIJRfFN9T2tCi+gUuQSspqmRaIC8=; b=l++J9AYGBX39LHo5aMbtU6UY4z
 XCrdox7O3AUS/d5Rc6gmaGBF7Rp8dIEGcOGYIhj7xDKK7rPC0pg9goYCWQrns/jW3/sFq3A6JhJZw
 BJQ6GctMGygD488S4OTn8SChcIUdFJR0FbWsASwRCK167ieOTM4+KbzUzv2tyue2J3CQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vzDAIArfyLMvNTGZIJRfFN9T2tCi+gUuQSspqmRaIC8=; b=L
 wfmR70EnlIPpSBRuqfcOCPSuXP3y9Ro8A3mChDT7uZMAaxG75mW2zJxXzSSZTX/IEKjeAMgdihx3i
 l/I/tIydqTz+ZY43Sz2T0+zx1PxEXNegQ6SrZNb4cWJAGNmrlOo110pdAHC6VE156606nlNDOB/+C
 8kH5Mop7hB1Bm8Hg=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIP7x-0002mn-PG for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 11:32:39 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso574136f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792323147; x=1792927947; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vzDAIArfyLMvNTGZIJRfFN9T2tCi+gUuQSspqmRaIC8=;
 b=AINrrSbXvdm/FMoAdSW7/h+L0ioCRqzArikA/uFkxluPLclVkix0Z3lzlohNKZbfi6
 C7nx7mS4rF+lYTindNYjtXfakhSYLxJ4igh20eqCReu/Zl0lmNK8ZPdCsDZvZLE7O5fQ
 AtXT+7su5r87MryVFIPdU50w2b9xqLHuZexVN30uZYdXZsmx7xWvIHyATmmkopOy4iZb
 /Nii/O/YYQ+PfTQtVRaqaNLa2WfU20CC3DKrrLlLCqj7MB9uZu3peuuUEryum7uenDnF
 d6ZP0LZ52oXu+rKFxQkOw9o7B5x0yEnc5dajS/4dOz0AJN3KyrNGKmiXKGdwSCNxzmnf
 /OmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792323147; x=1792927947;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vzDAIArfyLMvNTGZIJRfFN9T2tCi+gUuQSspqmRaIC8=;
 b=oxQxJRpr/Fqf3CEMmkcyUTSayxYNxWWO/OIBgAza9iqUdVI9OqAq2Ecp/Jyq8KfzN0
 wEmGR6yIel9SxPdk16aq+TnfE2bq00jHEpmYEotjSpjLIBi6iWUwHOIuKBs/7dy+0Aqu
 20J+ltohnA32qnrQbYxgJSY6MT/VZXg9lfPdU9NTGEAg555Eo8ygd1ycXBfaoe4iSO8y
 Ch0dApSvqBP0ZyrgiP/GV1dLDMkD7GCdIBZTDUPbqKkjcWF+VZ2+32LthMpTMnP6GtDn
 Ql9KhVJgBKb7gBYDNyeVUSTF+OLUVj6khl2vr6o4GZyOARki6eHKCfEK0f2KbEruwsVc
 MCLg==
X-Gm-Message-State: AFq9FYI74Dy2pDs/sXtiwDj1F08GfCN/sW9ZlyTpxnSpCQN4pTnopar3
 kseabcbwIfZsOUP0yXAkwcAZVj2DW50+SU3qBc5cnvL9ux45RLmwtGPb9f1yI5v0EQ7XT/OuQnO
 /DBrhp60MKFTD2RI3pvYPKz6RaXqbazrXzqS1X964KeD+YOeAbfQ725dZo5caANFRD29h
X-Gm-Gg: AYBFou19D50ISTyil9MQ85lsJJAzkYIdQ6YyQymtIkdaBGIaQ9MXVjxflnBq3v5Y39C
 w9mvvCi5d2CkUdUs4aLFuFcA5JCP1RDy+ATfkpbWzGlRnzGhNITWXULdrH1P3sFVkyXW26W8KOM
 /rdzD6VtN0cRcJRxc0ag/O1idQujjeNUBXtAJ1P97WykW3IcZMRr3KKtPKJfs3rl6o0vt6z642c
 HJcMKTKEBKjshP9KPfkb2uPhdDt8cnQLV3ra5l1XmpKtjPrmNPWTC1Zynqh+bv5t1zeb71XiTx4
 8WVZi9yw1ehXLDsMNJhhkTmO/brq9riVnLZTx/+4Tq6s5DLWs7fMXnaACWXKQGrKsByyWzCoM+A
 jgb7ScJcyOs/yVFCh99yBg6pkrtQn7jbe3L3c1SDssBmK2wSegLjCYkZAvNMad6StCHCB+eZVIJ
 LjqKxTEe7JKXZ6h6y1Wyno/PmH+DOOJn2yBMbJt5vh4dqRip1fKJ1LnOEtb8VaWTFVo/N0hpZil
 uKYs4k4UoIfFcTVLltIAyBFppY/AS6IBioRipiTBk3h+vnh54s7NqpWVGQEOcOMAx84f/EEPp8j
 rElCzBh9mW3ipXBhI70qWUpnZO+3CktLzkitmNoEYEZPY9l7KbbXy73wFNsp
X-Received: by 2002:a05:6000:2005:b0:48e:d27:bef2 with SMTP id
 ffacd0b85a97d-48e0d27c26bmr6496284f8f.21.1792323146369; 
 Sun, 18 Oct 2026 04:32:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ec8dfsm17049533f8f.26.2026.10.18.04.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 04:32:25 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 11:32:19 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
X-Gerrit-Change-Number: 1786
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1786?usp=email>
X-Gerrit-Commit: 5255415de686e0056566ac9daf1b536d83ef9667
In-Reply-To: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
References: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk2NGUwODUwZDQ4NjQ3YTJjMGUzZDM4NWMyZjIwYTlmNDQ1OTMxNzI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cdc793d845b9824c422cc4134c73b42a83334ce6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIP7x-0002mn-PG
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign IPv6
 addresses from a tagged subnet-pool
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7513716951526175454=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7513716951526175454==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FolxjgOuzu8="; charset=UTF-8

--FolxjgOuzu8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1786?usp=3Demail

to look at the new patch set (#=
7)=2E


Change subject: multi: assign IPv6 addresses from a tagged subnet-p=
ool
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: =
assign IPv6 addresses from a tagged subnet-pool

Add the IPv6 counterpart o=
f --subnet-pool:

  subnet-pool-ipv6 <tag> <network>/<bits> [<gateway>]   (=
main config)

selected by the same per-client --subnet-pool-tag=2E A client=
's tag is
resolved against the IPv6 pool list too and, when it matches, an =
IPv6
address is handed out from the group's pool alongside any IPv4 one (a
=
single dual-stack ifconfig_pool per tag)=2E The pool gateway is pushed as
t=
he remote end of the client's ifconfig-ipv6, as the server's own
address is=
 off-link for it=2E A tag matching neither family is still
declined with AU=
TH_FAILED=2E

As for IPv4 the pools are checked when the config is loaded (=
network
between /64 and /124 without host bits, gateway a host address insi=
de
it, unique tags, no overlap with another pool or the --server-ipv6
netwo=
rk), created at startup with their gateway reserved, and routed
into the se=
rver's tun device=2E

Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
=
GitHub: closes openvpn/OpenVPN#987
Signed-off-by: Antonio Quartulli <antoni=
o@mandelbit=2Ecom>
---
M doc/man-sections/server-options=2Erst
M src/openvp=
n/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openv=
pn/options_util=2Ec
M src/openvpn/options_util=2Eh
M src/openvpn/pool=2Ec
M=
 src/openvpn/pool=2Eh
M tests/unit_tests/openvpn/test_subnet_pool=2Ec
9 fil=
es changed, 388 insertions(+), 29 deletions(-)


  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/86/1786/7

diff --git a/doc/man-se=
ctions/server-options=2Erst b/doc/man-sections/server-options=2Erst
index d=
868d09=2E=2Eb3e687f 100644
--- a/doc/man-sections/server-options=2Erst
+++ =
b/doc/man-sections/server-options=2Erst
@@ -359,11 +359,32 @@
   and FreeBS=
D the IPv4 route is installed on-link, without a gateway, so its
   ``route=
_gateway_{n}`` is not set for ``--route-up`` scripts=2E
 
+--subnet-pool-ip=
v6 args
+  The IPv6 counterpart of ``--subnet-pool``=2E Repeatable main-con=
fig directive=2E
+
+  Valid syntax:
+  ::
+
+     subnet-pool-ipv6 tag netw=
ork/bits [gateway]
+
+  ``bits`` must be between 64 and 124; ``gateway`` de=
faults to the first
+  address of the network, is never assigned to a clien=
t, and is pushed to the
+  pool's clients as the remote end of their ``ifco=
nfig-ipv6``=2E A tag may name
+  an IPv4 pool, an IPv6 pool, or both; a cli=
ent referencing it with
+  ``--subnet-pool-tag`` is then assigned an addres=
s from each family the tag
+  defines=2E
+
+  Requires ``--server-ipv6`` wi=
th ``--dev tun``=2E ``network`` must have no host
+  bits set, ``gateway`` =
must be a host address inside it, each ``tag`` may be
+  defined only once =
and no pool may overlap another one or the
+  ``--server-ipv6`` network=2E =
As for ``--subnet-pool``, the server routes each
+  pool's network into the=
 tun device=2E
+
 --subnet-pool-tag tag
-  Assign this client to the ``--su=
bnet-pool`` named ``tag``=2E Must be
-  associated with a specific client i=
nstance via ``--client-config-dir`` or
-  ``--client-connect``=2E Several c=
lients may reference the same tag and are
-  then served from the same shar=
ed pool=2E
+  Assign this client to the ``--subnet-pool`` / ``--subnet-pool=
-ipv6`` named
+  ``tag``=2E Must be associated with a specific client insta=
nce via
+  ``--client-config-dir`` or ``--client-connect``=2E Several clien=
ts may
+  reference the same tag and are then served from the same shared p=
ool(s)=2E
 
 --ifconfig-ipv6-push args
   for ``--client-config-dir`` per-c=
lient static IPv6 interface
diff --git a/src/openvpn/multi=2Ec b/src/openvp=
n/multi=2Ec
index 12b7442=2E=2Ee3e48f5 100644
--- a/src/openvpn/multi=2Ec
+=
++ b/src/openvpn/multi=2Ec
@@ -392,6 +392,10 @@
     {
         multi_get_g=
roup_pool(m, &t->options, d->tag);
     }
+    for (const struct subnet_poo=
l6_def *d =3D t->options=2Esubnet_pools_ipv6; d; d =3D d->next)
+    {
+   =
     multi_get_group_pool(m, &t->options, d->tag);
+    }
 
     /*
      *=
 Help us keep track of routing table=2E
@@ -1469,14 +1473,25 @@
     }
 
  =
   const struct subnet_pool_def *d4 =3D subnet_pool_by_tag(o->subnet_pools,=
 tag);
-    ASSERT(d4);
+    const struct subnet_pool6_def *d6 =3D subnet_p=
ool6_by_tag(o->subnet_pools_ipv6, tag);
+    const char *pool_tag =3D d4 ? =
d4->tag : (d6 ? d6->tag : NULL);
+    ASSERT(pool_tag);
     ALLOC_OBJ_CLEA=
R(sp, struct subnet_pool);
-    sp->tag =3D d4->tag;
-    /* every host add=
ress of the subnet, minus the gateway reserved below */
-    sp->pool =3D i=
fconfig_pool_init(true, IFCONFIG_POOL_INDIV, d4->network + 1,
-            =
                      (d4->network | ~d4->netmask) - 1, o->duplicate_cn, fa=
lse,
-                                  in6addr_any, 0);
-    ifconfig_pool=
_reserve_ip(sp->pool, d4->gateway);
+    sp->tag =3D pool_tag;
+    /* ever=
y host address of each subnet, minus the gateways reserved below
+     * (t=
he IPv4 and the IPv6 address of a client share one pool handle) */
+    sp-=
>pool =3D ifconfig_pool_init(d4 !=3D NULL, IFCONFIG_POOL_INDIV, d4 ? d4->ne=
twork + 1 : 0,
+                                  d4 ? (d4->network | ~d4->=
netmask) - 1 : 0, o->duplicate_cn,
+                                  d6 !=
=3D NULL, d6 ? add_in6_addr(d6->network, 1) : in6addr_any,
+               =
                   d6 ? (int)d6->netbits : 0);
+    if (d4)
+    {
+       =
 ifconfig_pool_reserve_ip(sp->pool, d4->gateway);
+    }
+    if (d6)
+    =
{
+        ifconfig_pool_reserve_ipv6(sp->pool, &d6->gateway);
+    }
     =
sp->next =3D m->subnet_pools;
     m->subnet_pools =3D sp;
     return sp->=
pool;
@@ -1510,6 +1525,19 @@
             mi->context=2Eoptions=2Esubnet_po=
ol_gateway =3D d->gateway;
         }
     }
+    if (mi->context=2Eoptions=
=2Esubnet_pool_tag)
+    {
+        const struct subnet_pool6_def *d =3D su=
bnet_pool6_by_tag(
+            m->top=2Eoptions=2Esubnet_pools_ipv6, mi->c=
ontext=2Eoptions=2Esubnet_pool_tag);
+
+        mi->context=2Eoptions=2Esub=
net_pool_ipv6_defined =3D d !=3D NULL;
+        if (d)
+        {
+        =
    mi->context=2Eoptions=2Esubnet_pool_ipv6_network =3D d->network;
+     =
       mi->context=2Eoptions=2Esubnet_pool_ipv6_netbits =3D d->netbits;
+  =
          mi->context=2Eoptions=2Esubnet_pool_ipv6_gateway =3D d->gateway;
=
+        }
+    }
 
     /*
      * If ifconfig addresses were set by dynam=
ic config file,
@@ -1544,15 +1572,16 @@
                 "MULTI_sva: WARNIN=
G: if --ifconfig-push is used for IPv4, automatic IPv6 assignment from --if=
config-ipv6-pool does not work=2E  Use --ifconfig-ipv6-push for IPv6 then=
=2E");
         }
     }
-    else if (mi->context=2Eoptions=2Esubnet_pool_=
defined)
+    else if (mi->context=2Eoptions=2Esubnet_pool_defined
+       =
      || mi->context=2Eoptions=2Esubnet_pool_ipv6_defined)
     {
-        =
/* dynamic address from this client's --subnet-pool group */
+        /* dy=
namic address(es) from this client's --subnet-pool group */
         struct=
 ifconfig_pool *group =3D
             multi_get_group_pool(m, &m->top=2Eop=
tions, mi->context=2Eoptions=2Esubnet_pool_tag);
 
         /* the address =
may have been acquired before the tag was known (from
          * the globa=
l pool) or for a tag that a later handler overrode: drop
-         * it so =
we serve this client from its current group */
+         * it so we serve t=
his client from its current group only */
         if (mi->vaddr_handle >=
=3D 0 && mi->vaddr_pool !=3D group)
         {
             ifconfig_pool_r=
elease(mi->vaddr_pool ? mi->vaddr_pool : m->ifconfig_pool,
@@ -1567,27 +159=
6,44 @@
         if (mi->vaddr_handle < 0)
         {
             in_addr_=
t local =3D 0, remote =3D 0;
+            struct in6_addr remote_ipv6;
    =
         const char *cn =3D NULL;
 
+            CLEAR(remote_ipv6);
      =
       if (!mi->context=2Eoptions=2Eduplicate_cn)
             {
          =
       cn =3D tls_common_name(mi->context=2Ec2=2Etls_multi, true);
        =
     }
 
             mi->vaddr_pool =3D group;
-            mi->vaddr_hand=
le =3D ifconfig_pool_acquire(mi->vaddr_pool, &local, &remote, NULL, cn);
- =
           if (mi->vaddr_handle >=3D 0)
-            {
-                mi-=
>context=2Ec2=2Epush_ifconfig_local =3D remote;
-                mi->contex=
t=2Ec2=2Epush_ifconfig_remote_netmask =3D
-                    mi->context=
=2Eoptions=2Esubnet_pool_netmask;
-                mi->context=2Ec2=2Epush_=
ifconfig_defined =3D true;
-            }
-            else
+            mi=
->vaddr_handle =3D
+                ifconfig_pool_acquire(mi->vaddr_pool, &=
local, &remote, &remote_ipv6, cn);
+            if (mi->vaddr_handle < 0)
 =
            {
                 msg(D_MULTI_ERRORS, "MULTI: no free --subnet=
-pool addresses are available for %s",
                     multi_instance_=
string(mi, false, &gc));
             }
+            else
+            {
+ =
               if (mi->context=2Eoptions=2Esubnet_pool_defined)
+          =
      {
+                    mi->context=2Ec2=2Epush_ifconfig_local =3D rem=
ote;
+                    mi->context=2Ec2=2Epush_ifconfig_remote_netmask =
=3D
+                        mi->context=2Eoptions=2Esubnet_pool_netmask;
+=
                    mi->context=2Ec2=2Epush_ifconfig_defined =3D true;
+   =
             }
+                if (mi->context=2Eoptions=2Esubnet_pool_ipv=
6_defined)
+                {
+                    /* the server's own addr=
ess is off-link for this client:
+                     * hand out the pool =
gateway as the remote end instead */
+                    mi->context=2Ec2=
=2Epush_ifconfig_ipv6_local =3D remote_ipv6;
+                    mi->conte=
xt=2Ec2=2Epush_ifconfig_ipv6_remote =3D
+                        mi->contex=
t=2Eoptions=2Esubnet_pool_ipv6_gateway;
+                    mi->context=2E=
c2=2Epush_ifconfig_ipv6_netbits =3D
+                        mi->context=2E=
options=2Esubnet_pool_ipv6_netbits;
+                    mi->context=2Ec2=
=2Epush_ifconfig_ipv6_defined =3D true;
+                }
+            }
 =
        }
     }
     else if (m->ifconfig_pool && mi->vaddr_handle < 0) /*=
 otherwise, choose a pool address */
@@ -2928,7 +2974,9 @@
     }
 
     if=
 (mi->context=2Eoptions=2Esubnet_pool_tag
-        && !subnet_pool_by_tag(m=
->top=2Eoptions=2Esubnet_pools, mi->context=2Eoptions=2Esubnet_pool_tag))
+=
        && !subnet_pool_by_tag(m->top=2Eoptions=2Esubnet_pools, mi->context=
=2Eoptions=2Esubnet_pool_tag)
+        && !subnet_pool6_by_tag(m->top=2Eopt=
ions=2Esubnet_pools_ipv6,
+                                mi->context=2Eop=
tions=2Esubnet_pool_tag))
     {
         msg(D_MULTI_ERRORS, "MULTI: clien=
t has been rejected due to unknown --subnet-pool-tag '%s'",
             mi=
->context=2Eoptions=2Esubnet_pool_tag);
diff --git a/src/openvpn/options=2E=
c b/src/openvpn/options=2Ec
index d5666b8=2E=2E61b52f2 100644
--- a/src/ope=
nvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -455,6 +455,8 @@
     "--=
subnet-pool tag network netmask [gateway] : Define a named pool of\n"
     =
"                  addresses outside the --server network, selected per\n"
=
     "                  client with --subnet-pool-tag=2E\n"
+    "--subnet-=
pool-ipv6 tag network/bits [gateway] : IPv6 counterpart of\n"
+    "       =
           --subnet-pool=2E\n"
     "--subnet-pool-tag tag : Assign this cl=
ient to the --subnet-pool named tag=2E\n"
     "                  Only vali=
d in a client-specific config file=2E\n"
     "--ifconfig-push local remote=
-netmask : Push an ifconfig option to remote,\n"
@@ -1944,6 +1946,20 @@
   =
          subnet_pools_check(options->subnet_pools, options->server_network=
,
                                options->server_netmask, M_USAGE);
      =
   }
+        if (options->subnet_pools_ipv6)
+        {
+            if (!=
options->server_ipv6_defined)
+            {
+                msg(M_USAGE, =
"--subnet-pool-ipv6 requires --server-ipv6");
+            }
+            i=
f (dev_type_enum(options->dev, options->dev_type) !=3D DEV_TYPE_TUN
+      =
          || options->topology !=3D TOP_SUBNET)
+            {
+           =
     msg(M_USAGE, "--subnet-pool-ipv6 requires --dev tun and --topology sub=
net");
+            }
+            subnet_pools6_check(options->subnet_pool=
s_ipv6, &options->server_network_ipv6,
+                                opt=
ions->server_netbits_ipv6, M_USAGE);
+        }
         MUST_BE_UNDEF(allo=
w_recursive_routing, "allow-recursive-routing");
         if (options->auth=
_user_pass_file)
         {
@@ -2011,6 +2027,7 @@
         MUST_BE_UNDEF(if=
config_pool_persist_filename, "ifconfig-pool-persist");
         MUST_BE_UN=
DEF(ifconfig_ipv6_pool_defined, "ifconfig-ipv6-pool");
         MUST_BE_UND=
EF(subnet_pools, "subnet-pool");
+        MUST_BE_UNDEF(subnet_pools_ipv6, =
"subnet-pool-ipv6");
         MUST_BE_UNDEF(real_hash_size, "hash-size");
 =
        MUST_BE_UNDEF(virtual_hash_size, "hash-size");
         MUST_BE_UND=
EF(learn_address_script, "learn-address");
@@ -3144,8 +3161,9 @@
 }
 
 /*
-=
 * The server's tun device is only configured with the --server network, so=

- * route each --subnet-pool network into it as well: without this the ser=
ver
+ * The server's tun device is only configured with the --server and
+ =
* --server-ipv6 networks, so route each --subnet-pool and --subnet-pool-ipv=
6
+ * network into it as well: without this the server
  * could not reach =
its subnet-pool clients when the data channel runs in
  * userspace=2E  Und=
er DCO on Linux and FreeBSD the routes are installed on-link,
  * see subne=
t_pool_routes_onlink()=2E
@@ -3163,6 +3181,16 @@
                          =
             o->route_default_table_id);
         ro->on_link =3D subnet_po=
ol_routes_onlink(o);
     }
+
+    for (const struct subnet_pool6_def *d =
=3D o->subnet_pools_ipv6; d; d =3D d->next)
+    {
+        struct buffer p=
refix =3D alloc_buf_gc(64, &o->gc);
+
+        buf_printf(&prefix, "%s/%u",=
 print_in6_addr(d->network, 0, &o->gc), d->netbits);
+        rol6_check_al=
loc(o);
+        add_route_ipv6_to_option_list(o->routes_ipv6, BSTR(&prefix=
), NULL, NULL,
+                                      o->route_default_tabl=
e_id);
+    }
 }
 
 static void
@@ -6325,6 +6353,37 @@
         sp->next =
=3D options->subnet_pools;
         options->subnet_pools =3D sp;
     }
+ =
   else if (streq(p[0], "subnet-pool-ipv6") && p[1] && p[2] && !p[4])
+    =
{
+        struct subnet_pool6_def *sp;
+        struct in6_addr network, g=
ateway;
+        unsigned int netbits =3D 0;
+
+        VERIFY_PERMISSION(O=
PT_P_GENERAL);
+        if (!get_ipv6_addr(p[2], &network, &netbits, msglev=
el))
+        {
+            msg(msglevel, "cannot parse --subnet-pool-ipv6=
 network");
+            goto err;
+        }
+        if (netbits < 64 || =
netbits > 124)
+        {
+            msg(msglevel, "--subnet-pool-ipv6 ne=
twork must be between /64 and /124 (not /%u)",
+                netbits);
+=
            goto err;
+        }
+        if (p[3] && !get_ipv6_addr(p[3], =
&gateway, NULL, msglevel))
+        {
+            msg(msglevel, "cannot pa=
rse --subnet-pool-ipv6 gateway");
+            goto err;
+        }
+      =
  ALLOC_OBJ_GC(sp, struct subnet_pool6_def, &options->gc);
+        sp->tag=
 =3D p[1];
+        sp->network =3D network;
+        sp->netbits =3D netbi=
ts;
+        sp->gateway =3D p[3] ? gateway : add_in6_addr(network, 1);
+  =
      sp->next =3D options->subnet_pools_ipv6;
+        options->subnet_poo=
ls_ipv6 =3D sp;
+    }
     else if (streq(p[0], "subnet-pool-tag") && p[1]=
 && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_INSTANCE);
diff --git a/=
src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index ff26066=2E=2Ec75894=
3 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -26=
3,6 +263,16 @@
     in_addr_t gateway;
 };
 
+/* The IPv6 counterpart of st=
ruct subnet_pool_def (--subnet-pool-ipv6)=2E */
+struct subnet_pool6_def
+{=

+    struct subnet_pool6_def *next;
+    const char *tag;
+    struct in6_=
addr network;
+    unsigned int netbits;
+    struct in6_addr gateway;
+};
=
+
 /* Command line options */
 struct options
 {
@@ -529,12 +539,17 @@
    =
 bool push_ifconfig_constraint_defined;
     in_addr_t push_ifconfig_constr=
aint_network;
     in_addr_t push_ifconfig_constraint_netmask;
-    struct =
subnet_pool_def *subnet_pools; /* named pools (server config) */
-    const=
 char *subnet_pool_tag;          /* which pool this client uses (CCD) */
- =
   bool subnet_pool_defined;             /* resolved from the tag at connec=
t */
+    struct subnet_pool_def *subnet_pools;       /* named IPv4 pools (=
server config) */
+    struct subnet_pool6_def *subnet_pools_ipv6; /* named=
 IPv6 pools (server config) */
+    const char *subnet_pool_tag;           =
     /* which pool this client uses (CCD) */
+    bool subnet_pool_defined;=
                   /* resolved from the tag at connect */
     in_addr_t su=
bnet_pool_network;
     in_addr_t subnet_pool_netmask;
     in_addr_t subne=
t_pool_gateway;
+    bool subnet_pool_ipv6_defined; /* resolved from the ta=
g at connect */
+    struct in6_addr subnet_pool_ipv6_network;
+    unsigne=
d int subnet_pool_ipv6_netbits;
+    struct in6_addr subnet_pool_ipv6_gatew=
ay;
     bool push_ifconfig_ipv4_blocked;           /* IPv4 */
     bool pu=
sh_ifconfig_ipv6_defined;           /* IPv6 */
     struct in6_addr push_if=
config_ipv6_local;  /* IPv6 */
diff --git a/src/openvpn/options_util=2Ec b/=
src/openvpn/options_util=2Ec
index 744ad4c=2E=2Efb38cfa 100644
--- a/src/op=
envpn/options_util=2Ec
+++ b/src/openvpn/options_util=2Ec
@@ -116,6 +116,10=
8 @@
     return true;
 }
 
+/* value of bit <i> (0 =3D most significant) o=
f an IPv6 address */
+static bool
+in6_bit(const struct in6_addr *a, unsign=
ed int i)
+{
+    return a->s6_addr[i / 8] & (0x80 >> (i % 8));
+}
+
+/* tr=
ue if the first <bits> bits of the two addresses are equal */
+static bool
=
+in6_prefix_equal(const struct in6_addr *a, const struct in6_addr *b, unsig=
ned int bits)
+{
+    for (unsigned int i =3D 0; i < bits; ++i)
+    {
+   =
     if (in6_bit(a, i) !=3D in6_bit(b, i))
+        {
+            return f=
alse;
+        }
+    }
+    return true;
+}
+
+/* true if every bit of <a>=
 from bit <from> on is zero */
+static bool
+in6_suffix_zero(const struct i=
n6_addr *a, unsigned int from)
+{
+    for (unsigned int i =3D from; i < 12=
8; ++i)
+    {
+        if (in6_bit(a, i))
+        {
+            return f=
alse;
+        }
+    }
+    return true;
+}
+
+bool
+subnet_pools6_check(c=
onst struct subnet_pool6_def *pools, const struct in6_addr *server_network,=

+                    unsigned int server_netbits, msglvl_t msglevel)
+{
+ =
   for (const struct subnet_pool6_def *d =3D pools; d; d =3D d->next)
+    =
{
+        if (d->netbits < 64 || d->netbits > 124)
+        {
+           =
 msg(msglevel, "--subnet-pool-ipv6 %s: network must be between /64 and /124=
 (not /%u)",
+                d->tag, d->netbits);
+            return fals=
e;
+        }
+
+        if (!in6_suffix_zero(&d->network, d->netbits))
+  =
      {
+            msg(msglevel, "--subnet-pool-ipv6 %s: network has host=
 bits set", d->tag);
+            return false;
+        }
+
+        if (!=
in6_prefix_equal(&d->gateway, &d->network, d->netbits)
+            || in6_=
suffix_zero(&d->gateway, d->netbits))
+        {
+            msg(msglevel,=

+                "--subnet-pool-ipv6 %s: gateway must be a host address in=
side the network",
+                d->tag);
+            return false;
+  =
      }
+
+        if (server_netbits
+            && in6_prefix_equal(&d->=
network, server_network, min_uint(d->netbits, server_netbits)))
+        {
=
+            msg(msglevel, "--subnet-pool-ipv6 %s: network overlaps the --s=
erver-ipv6 network",
+                d->tag);
+            return false;
+=
        }
+
+        for (const struct subnet_pool6_def *e =3D d->next; e; =
e =3D e->next)
+        {
+            if (!strcmp(d->tag, e->tag))
+      =
      {
+                msg(msglevel, "--subnet-pool-ipv6 %s: tag defined =
more than once", d->tag);
+                return false;
+            }
+  =
          if (in6_prefix_equal(&d->network, &e->network, min_uint(d->netbit=
s, e->netbits)))
+            {
+                msg(msglevel, "--subnet-po=
ol-ipv6 %s and %s: networks overlap", d->tag, e->tag);
+                ret=
urn false;
+            }
+        }
+    }
+
+    return true;
+}
+
+const=
 struct subnet_pool6_def *
+subnet_pool6_by_tag(const struct subnet_pool6_d=
ef *pools, const char *tag)
+{
+    for (const struct subnet_pool6_def *d =
=3D pools; d; d =3D d->next)
+    {
+        if (!strcmp(d->tag, tag))
+   =
     {
+            return d;
+        }
+    }
+    return NULL;
+}
+
 con=
st char *
 parse_auth_failed_temp(struct options *o, const char *reason)
 {=

diff --git a/src/openvpn/options_util=2Eh b/src/openvpn/options_util=2Eh
i=
ndex d60759a=2E=2Ebffcddb 100644
--- a/src/openvpn/options_util=2Eh
+++ b/s=
rc/openvpn/options_util=2Eh
@@ -53,6 +53,25 @@
 bool subnet_pools_check(con=
st struct subnet_pool_def *pools, in_addr_t server_network,
               =
          in_addr_t server_netmask, msglvl_t msglevel);
 
+/**
+ * IPv6 cou=
nterpart of subnet_pools_check(): network between /64 and /124
+ * without =
host bits, gateway a host address inside it, unique tags, and no
+ * networ=
k overlapping another pool or the --server-ipv6 network=2E
+ *
+ * @param p=
ools           head of the --subnet-pool-ipv6 list (may be NULL)
+ * @param=
 server_network  the --server-ipv6 network
+ * @param server_netbits  the -=
-server-ipv6 prefix length, or 0 if there is none
+ * @param msglevel      =
  level of the message logged on the first error
+ * @return               =
 true if every definition is valid
+ */
+bool subnet_pools6_check(const str=
uct subnet_pool6_def *pools,
+                         const struct in6_add=
r *server_network, unsigned int server_netbits,
+                         m=
sglvl_t msglevel);
+
+/** IPv6 counterpart of subnet_pool_by_tag()=2E */
+c=
onst struct subnet_pool6_def *subnet_pool6_by_tag(const struct subnet_pool6=
_def *pools,
+                                                   const char=
 *tag);
+
 
 /** Checks if the string is a valid integer by checking if it =
can be
  *  converted to an integer */
diff --git a/src/openvpn/pool=2Ec b/=
src/openvpn/pool=2Ec
index fa04d9c=2E=2E8f899d3 100644
--- a/src/openvpn/po=
ol=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -445,6 +445,22 @@
     return true;
 }=

 
+bool
+ifconfig_pool_reserve_ipv6(struct ifconfig_pool *pool, const stru=
ct in6_addr *addr)
+{
+    const ifconfig_pool_handle h =3D ifconfig_pool_i=
pv6_base_to_handle(pool, addr);
+
+    if (h < 0)
+    {
+        return fa=
lse;
+    }
+
+    ifconfig_pool_entry_free(&pool->list[h], true);
+    poo=
l->list[h]=2Ein_use =3D true;
+    pool->list[h]=2Ereserved =3D true;
+    =
return true;
+}
+
 static in_addr_t
 ifconfig_pool_handle_to_ip_base(const =
struct ifconfig_pool *pool, ifconfig_pool_handle hand)
 {
diff --git a/src/=
openvpn/pool=2Eh b/src/openvpn/pool=2Eh
index 497dcda=2E=2Efda87ed 100644
-=
-- a/src/openvpn/pool=2Eh
+++ b/src/openvpn/pool=2Eh
@@ -98,6 +98,9 @@
  */=

 bool ifconfig_pool_reserve_ip(struct ifconfig_pool *pool, in_addr_t addr)=
;
 
+/** IPv6 counterpart of ifconfig_pool_reserve_ip()=2E */
+bool ifconfi=
g_pool_reserve_ipv6(struct ifconfig_pool *pool, const struct in6_addr *addr=
);
+
 struct ifconfig_pool_persist *ifconfig_pool_persist_init(const char *=
filename, int refresh_freq);
 
 void ifconfig_pool_persist_close(struct ifc=
onfig_pool_persist *persist);
diff --git a/tests/unit_tests/openvpn/test_su=
bnet_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec
index 5ce4c76=
=2E=2Efbb8da9 100644
--- a/tests/unit_tests/openvpn/test_subnet_pool=2Ec
++=
+ b/tests/unit_tests/openvpn/test_subnet_pool=2Ec
@@ -128,11 +128,87 @@
   =
  assert_false(subnet_pools_check(&adup, 0, 0, M_WARN));
 }
 
+/* the IPv6 =
counterpart resolves independently: a tag may name a v4 pool, a
+ * v6 pool=
, or both=2E */
+static void
+test_subnet_pool6_by_tag(void **state)
+{
+  =
  struct subnet_pool6_def c =3D { =2Enext =3D NULL, =2Etag =3D "grpC", =2En=
etbits =3D 64 };
+    struct subnet_pool6_def b =3D { =2Enext =3D &c, =2Eta=
g =3D "grpB", =2Enetbits =3D 96 };
+    struct subnet_pool6_def a =3D { =2E=
next =3D &b, =2Etag =3D "grpA", =2Enetbits =3D 64 };
+
+    assert_ptr_equa=
l(subnet_pool6_by_tag(&a, "grpA"), &a);
+    assert_ptr_equal(subnet_pool6_=
by_tag(&a, "grpB"), &b);
+    assert_ptr_equal(subnet_pool6_by_tag(&a, "grp=
C"), &c);
+    assert_int_equal(subnet_pool6_by_tag(&a, "grpB")->netbits, 9=
6);
+    assert_null(subnet_pool6_by_tag(&a, "nope"));
+    assert_null(sub=
net_pool6_by_tag(NULL, "grpA"));
+}
+
+/* <prefix>::<host> as an in6_addr *=
/
+static struct in6_addr
+in6(const char *addr)
+{
+    struct in6_addr a;=

+
+    assert_int_equal(inet_pton(AF_INET6, addr, &a), 1);
+    return a;
=
+}
+
+/* a single IPv6 pool, checked against the fd00:8::/64 --server-ipv6 =
network */
+static bool
+check6_one(const char *net, unsigned int bits, con=
st char *gw)
+{
+    const struct in6_addr server =3D in6("fd00:8::");
+   =
 struct subnet_pool6_def d =3D { =2Enext =3D NULL, =2Etag =3D "grp", =2Enet=
work =3D in6(net), =2Enetbits =3D bits, =2Egateway =3D in6(gw) };
+
+    re=
turn subnet_pools6_check(&d, &server, 64, M_WARN);
+}
+
+static void
+test_=
subnet_pools6_check(void **state)
+{
+    /* /64 =2E=2E /124, any host addr=
ess of the network as gateway */
+    assert_true(check6_one("fd00:9::", 64=
, "fd00:9::1"));
+    assert_true(check6_one("fd00:9::", 124, "fd00:9::1"))=
;
+    assert_true(check6_one("fd00:9::", 112, "fd00:9::ffff"));
+    asser=
t_false(check6_one("fd00:9::", 63, "fd00:9::1"));
+    assert_false(check6_=
one("fd00:9::", 125, "fd00:9::1"));
+
+    /* host bits in the network, gat=
eway =3D network or outside it */
+    assert_false(check6_one("fd00:9::5",=
 64, "fd00:9::1"));
+    assert_false(check6_one("fd00:9::", 64, "fd00:9::"=
));
+    assert_false(check6_one("fd00:9::", 64, "fd00:a::1"));
+
+    /* o=
verlapping the --server-ipv6 network, inside or covering it */
+    assert_=
false(check6_one("fd00:8::", 96, "fd00:8::1"));
+
+    /* two pools: disjoi=
nt, overlapping, same tag */
+    const struct in6_addr server =3D in6("fd0=
0:8::");
+    struct subnet_pool6_def b =3D { =2Enext =3D NULL, =2Etag =3D =
"grpB", =2Enetwork =3D in6("fd00:a::"), =2Enetbits =3D 64, =2Egateway =3D i=
n6("fd00:a::1") };
+    struct subnet_pool6_def a =3D { =2Enext =3D &b, =2E=
tag =3D "grpA", =2Enetwork =3D in6("fd00:9::"), =2Enetbits =3D 64, =2Egatew=
ay =3D in6("fd00:9::1") };
+
+    assert_true(subnet_pools6_check(&a, &serv=
er, 64, M_WARN));
+    assert_true(subnet_pools6_check(&a, &server, 0, M_WA=
RN));
+
+    /* a /120 grpB inside grpA */
+    struct subnet_pool6_def bin=
 =3D { =2Enext =3D NULL, =2Etag =3D "grpB", =2Enetwork =3D in6("fd00:9::100=
"), =2Enetbits =3D 120, =2Egateway =3D in6("fd00:9::101") };
+    struct su=
bnet_pool6_def ain =3D { =2Enext =3D &bin, =2Etag =3D "grpA", =2Enetwork =
=3D in6("fd00:9::"), =2Enetbits =3D 64, =2Egateway =3D in6("fd00:9::1") };
=
+    assert_false(subnet_pools6_check(&ain, &server, 64, M_WARN));
+
+    /=
* the same tag defined twice */
+    struct subnet_pool6_def bdup =3D { =2E=
next =3D NULL, =2Etag =3D "grpA", =2Enetwork =3D in6("fd00:a::"), =2Enetbit=
s =3D 64, =2Egateway =3D in6("fd00:a::1") };
+    struct subnet_pool6_def a=
dup =3D { =2Enext =3D &bdup, =2Etag =3D "grpA", =2Enetwork =3D in6("fd00:9:=
:"), =2Enetbits =3D 64, =2Egateway =3D in6("fd00:9::1") };
+    assert_fals=
e(subnet_pools6_check(&adup, &server, 64, M_WARN));
+}
+
 const struct CMUn=
itTest subnet_pool_tests[] =3D {
     cmocka_unit_test(test_subnet_pool_by_=
tag),
     cmocka_unit_test(test_subnet_pools_check_netmask),
     cmocka_u=
nit_test(test_subnet_pools_check_gateway),
     cmocka_unit_test(test_subne=
t_pools_check_overlap),
+    cmocka_unit_test(test_subnet_pool6_by_tag),
+ =
   cmocka_unit_test(test_subnet_pools6_check),
 };
 
 int

-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f=
445931727
Gerrit-Change-Number: 1786
Gerrit-PatchSet: 7
Gerrit-Owner: Anton=
io Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--FolxjgOuzu8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli <strong>upl=
oaded patch set #7</strong> to this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">multi: assign IPv6 addresses from a tagged subnet-pool<br><br>Add th=
e IPv6 counterpart of --subnet-pool:<br><br>  subnet-pool-ipv6 &lt;tag&gt; =
&lt;network&gt;/&lt;bits&gt; [&lt;gateway&gt;]   (main config)<br><br>selec=
ted by the same per-client --subnet-pool-tag=2E A client&#39;s tag is<br>re=
solved against the IPv6 pool list too and, when it matches, an IPv6<br>addr=
ess is handed out from the group&#39;s pool alongside any IPv4 one (a<br>si=
ngle dual-stack ifconfig_pool per tag)=2E The pool gateway is pushed as<br>=
the remote end of the client&#39;s ifconfig-ipv6, as the server&#39;s own<b=
r>address is off-link for it=2E A tag matching neither family is still<br>d=
eclined with AUTH_FAILED=2E<br><br>As for IPv4 the pools are checked when t=
he config is loaded (network<br>between /64 and /124 without host bits, gat=
eway a host address inside<br>it, unique tags, no overlap with another pool=
 or the --server-ipv6<br>network), created at startup with their gateway re=
served, and routed<br>into the server&#39;s tun device=2E<br><br>Change-Id:=
 I64e0850d48647a2c0e3d385c2f20a9f445931727<br>GitHub: closes openvpn/OpenVP=
N#987<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<b=
r>---<br>M doc/man-sections/server-options=2Erst<br>M src/openvpn/multi=2Ec=
<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn=
/options_util=2Ec<br>M src/openvpn/options_util=2Eh<br>M src/openvpn/pool=
=2Ec<br>M src/openvpn/pool=2Eh<br>M tests/unit_tests/openvpn/test_subnet_po=
ol=2Ec<br>9 files changed, 388 insertions(+), 29 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/86/1786/7</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/doc/man-sections/server-options=2Erst b/=
doc/man-sections/server-options=2Erst</span><br><span>index d868d09=2E=2Eb3=
e687f 100644</span><br><span>--- a/doc/man-sections/server-options=2Erst</s=
pan><br><span>+++ b/doc/man-sections/server-options=2Erst</span><br><span>@=
@ -359,11 +359,32 @@</span><br><span>   and FreeBSD the IPv4 route is insta=
lled on-link, without a gateway, so its</span><br><span>   ``route_gateway_=
{n}`` is not set for ``--route-up`` scripts=2E</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+--subnet-pool-ipv6 args</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  The IPv6 counterpart of =
``--subnet-pool``=2E Repeatable main-config directive=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  Valid syntax:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  ::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     subnet-pool-ipv=
6 tag network/bits [gateway]</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``bits``=
 must be between 64 and 124; ``gateway`` defaults to the first</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  address of the network, is nev=
er assigned to a client, and is pushed to the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  pool&#39;s clients as the remote end of their `=
`ifconfig-ipv6``=2E A tag may name</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  an IPv4 pool, an IPv6 pool, or both; a client referencing =
it with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--subnet=
-pool-tag`` is then assigned an address from each family the tag</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  defines=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  Requires ``--server-ipv6`` with ``--dev tun``=2E ``net=
work`` must have no host</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  bits set, ``gateway`` must be a host address inside it, each ``tag``=
 may be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  defined on=
ly once and no pool may overlap another one or the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  ``--server-ipv6`` network=2E As for ``--su=
bnet-pool``, the server routes each</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  pool&#39;s network into the tun device=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --subnet-pool-tag=
 tag</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Assign this cli=
ent to the ``--subnet-pool`` named ``tag``=2E Must be</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  associated with a specific client instanc=
e via ``--client-config-dir`` or</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  ``--client-connect``=2E Several clients may reference the same=
 tag and are</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  then se=
rved from the same shared pool=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  Assign this client to the ``--subnet-pool`` / ``--subnet-po=
ol-ipv6`` named</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``=
tag``=2E Must be associated with a specific client instance via</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  ``--client-config-dir`` or ``=
--client-connect``=2E Several clients may</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  reference the same tag and are then served from the=
 same shared pool(s)=2E</span><br><span> </span><br><span> --ifconfig-ipv6-=
push args</span><br><span>   for ``--client-config-dir`` per-client static =
IPv6 interface</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/ope=
nvpn/multi=2Ec</span><br><span>index 12b7442=2E=2Ee3e48f5 100644</span><br>=
<span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=
=2Ec</span><br><span>@@ -392,6 +392,10 @@</span><br><span>     {</span><br>=
<span>         multi_get_group_pool(m, &amp;t-&gt;options, d-&gt;tag);</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   for (const struct subnet_pool6_def *d =3D t-&gt;options=2Esubnet_pools_i=
pv6; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
multi_get_group_pool(m, &amp;t-&gt;options, d-&gt;tag);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span=
>     /*</span><br><span>      * Help us keep track of routing table=2E</sp=
an><br><span>@@ -1469,14 +1473,25 @@</span><br><span>     }</span><br><span=
> </span><br><span>     const struct subnet_pool_def *d4 =3D subnet_pool_by=
_tag(o-&gt;subnet_pools, tag);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    ASSERT(d4);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const struct subnet_pool6_def *d6 =3D subnet_pool6_by_tag(o-&gt;su=
bnet_pools_ipv6, tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *pool_tag =3D d4 ? d4-&gt;tag : (d6 ? d6-&gt;tag : NULL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(pool_tag=
);</span><br><span>     ALLOC_OBJ_CLEAR(sp, struct subnet_pool);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    sp-&gt;tag =3D d4-&gt;tag;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* every host addre=
ss of the subnet, minus the gateway reserved below */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    sp-&gt;pool =3D ifconfig_pool_init(true=
, IFCONFIG_POOL_INDIV, d4-&gt;network + 1,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                  (d4-&gt;network | ~d=
4-&gt;netmask) - 1, o-&gt;duplicate_cn, false,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                  in6addr_any, 0);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifconfig_pool_res=
erve_ip(sp-&gt;pool, d4-&gt;gateway);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    sp-&gt;tag =3D pool_tag;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* every host address of each subnet, minus =
the gateways reserved below</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * (the IPv4 and the IPv6 address of a client share one pool ha=
ndle) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;=
pool =3D ifconfig_pool_init(d4 !=3D NULL, IFCONFIG_POOL_INDIV, d4 ? d4-&gt;=
network + 1 : 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                               d4 ? (d4-&gt;network | ~d4-&gt;netmask) - 1 =
: 0, o-&gt;duplicate_cn,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                  d6 !=3D NULL, d6 ? add_in6_addr(d6-&=
gt;network, 1) : in6addr_any,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                  d6 ? (int)d6-&gt;netbits : 0);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (d4)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ifconfig_pool_reserve_ip(sp-&gt;p=
ool, d4-&gt;gateway);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (d6)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        ifconfig_pool_reserve_ipv6=
(sp-&gt;pool, &amp;d6-&gt;gateway);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span>     sp-&gt;next =3D m-&gt;subnet_poo=
ls;</span><br><span>     m-&gt;subnet_pools =3D sp;</span><br><span>     re=
turn sp-&gt;pool;</span><br><span>@@ -1510,6 +1525,19 @@</span><br><span>  =
           mi-&gt;context=2Eoptions=2Esubnet_pool_gateway =3D d-&gt;gateway=
;</span><br><span>         }</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Eoptions=2Esubnet=
_pool_tag)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct su=
bnet_pool6_def *d =3D subnet_pool6_by_tag(</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            m-&gt;top=2Eoptions=2Esubnet_pools_ipv6,=
 mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_defined =3D d !=
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;contex=
t=2Eoptions=2Esubnet_pool_ipv6_network =3D d-&gt;network;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=
=2Esubnet_pool_ipv6_netbits =3D d-&gt;netbits;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_po=
ol_ipv6_gateway =3D d-&gt;gateway;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span> </span><br><span>     /*</span><br><span>      =
* If ifconfig addresses were set by dynamic config file,</span><br><span>@@=
 -1544,15 +1572,16 @@</span><br><span>                 &quot;MULTI_sva: WAR=
NING: if --ifconfig-push is used for IPv4, automatic IPv6 assignment from -=
-ifconfig-ipv6-pool does not work=2E  Use --ifconfig-ipv6-push for IPv6 the=
n=2E&quot;);</span><br><span>         }</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else if (mi-&gt;context=2Eopti=
ons=2Esubnet_pool_defined)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else if (mi-&gt;context=2Eoptions=2Esubnet_pool_defined</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+             || mi-&gt;conte=
xt=2Eoptions=2Esubnet_pool_ipv6_defined)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /* dynamic address from t=
his client&#39;s --subnet-pool group */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* dynamic address(es) from this client&#39;s -=
-subnet-pool group */</span><br><span>         struct ifconfig_pool *group =
=3D</span><br><span>             multi_get_group_pool(m, &amp;m-&gt;top=2Eo=
ptions, mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span> </spa=
n><br><span>         /* the address may have been acquired before the tag w=
as known (from</span><br><span>          * the global pool) or for a tag th=
at a later handler overrode: drop</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-         * it so we serve this client from its current group */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * it so we=
 serve this client from its current group only */</span><br><span>         =
if (mi-&gt;vaddr_handle &gt;=3D 0 &amp;&amp; mi-&gt;vaddr_pool !=3D group)<=
/span><br><span>         {</span><br><span>             ifconfig_pool_relea=
se(mi-&gt;vaddr_pool ? mi-&gt;vaddr_pool : m-&gt;ifconfig_pool,</span><br><=
span>@@ -1567,27 +1596,44 @@</span><br><span>         if (mi-&gt;vaddr_hand=
le &lt; 0)</span><br><span>         {</span><br><span>             in_addr_=
t local =3D 0, remote =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            struct in6_addr remote_ipv6;</span><br><span>         =
    const char *cn =3D NULL;</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            CLEAR(remote_ipv6);</span><br><span>=
             if (!mi-&gt;context=2Eoptions=2Eduplicate_cn)</span><br><span>=
             {</span><br><span>                 cn =3D tls_common_name(mi-&=
gt;context=2Ec2=2Etls_multi, true);</span><br><span>             }</span><b=
r><span> </span><br><span>             mi-&gt;vaddr_pool =3D group;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;vaddr_hand=
le =3D ifconfig_pool_acquire(mi-&gt;vaddr_pool, &amp;local, &amp;remote, NU=
LL, cn);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i=
f (mi-&gt;vaddr_handle &gt;=3D 0)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                mi-&gt;context=2Ec2=2Epush_ifconfig_local =3D remote;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mi-&gt;=
context=2Ec2=2Epush_ifconfig_remote_netmask =3D</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    mi-&gt;context=2Eoptions=2Esu=
bnet_pool_netmask;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D true;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_handle =3D</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                ifconfig_=
pool_acquire(mi-&gt;vaddr_pool, &amp;local, &amp;remote, &amp;remote_ipv6, =
cn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if =
(mi-&gt;vaddr_handle &lt; 0)</span><br><span>             {</span><br><span=
>                 msg(D_MULTI_ERRORS, &quot;MULTI: no free --subnet-pool ad=
dresses are available for %s&quot;,</span><br><span>                     mu=
lti_instance_string(mi, false, &amp;gc));</span><br><span>             }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                if (mi-&gt;cont=
ext=2Eoptions=2Esubnet_pool_defined)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    mi-&gt;context=2Ec2=2Epush_ifconfig_loca=
l =3D remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              mi-&gt;context=2Ec2=2Epush_ifconfig_remote_netmask =3D</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        mi=
-&gt;context=2Eoptions=2Esubnet_pool_netmask;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    mi-&gt;context=2Ec2=2Epush_if=
config_defined =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                if (mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_defined)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    /=
* the server&#39;s own address is off-link for this client:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     * hand out the=
 pool gateway as the remote end instead */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    mi-&gt;context=2Ec2=2Epush_ifcon=
fig_ipv6_local =3D remote_ipv6;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_re=
mote =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_gateway;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;co=
ntext=2Ec2=2Epush_ifconfig_ipv6_netbits =3D</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        mi-&gt;context=2Eoptions=2E=
subnet_pool_ipv6_netbits;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span>         }</span><br><span>     }</span><br><span>     el=
se if (m-&gt;ifconfig_pool &amp;&amp; mi-&gt;vaddr_handle &lt; 0) /* otherw=
ise, choose a pool address */</span><br><span>@@ -2928,7 +2974,9 @@</span><=
br><span>     }</span><br><span> </span><br><span>     if (mi-&gt;context=
=2Eoptions=2Esubnet_pool_tag</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        &amp;&amp; !subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_=
pools, mi-&gt;context=2Eoptions=2Esubnet_pool_tag))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !subnet_pool_by_tag(m-=
&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=2Eoptions=2Esubnet_pool_ta=
g)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp=
; !subnet_pool6_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools_ipv6,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
 mi-&gt;context=2Eoptions=2Esubnet_pool_tag))</span><br><span>     {</span>=
<br><span>         msg(D_MULTI_ERRORS, &quot;MULTI: client has been rejecte=
d due to unknown --subnet-pool-tag &#39;%s&#39;&quot;,</span><br><span>    =
         mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span>diff =
--git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>i=
ndex d5666b8=2E=2E61b52f2 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -455,=
6 +455,8 @@</span><br><span>     &quot;--subnet-pool tag network netmask [g=
ateway] : Define a named pool of\n&quot;</span><br><span>     &quot;       =
           addresses outside the --server network, selected per\n&quot;</sp=
an><br><span>     &quot;                  client with --subnet-pool-tag=2E\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--=
subnet-pool-ipv6 tag network/bits [gateway] : IPv6 counterpart of\n&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;           =
       --subnet-pool=2E\n&quot;</span><br><span>     &quot;--subnet-pool-ta=
g tag : Assign this client to the --subnet-pool named tag=2E\n&quot;</span>=
<br><span>     &quot;                  Only valid in a client-specific conf=
ig file=2E\n&quot;</span><br><span>     &quot;--ifconfig-push local remote-=
netmask : Push an ifconfig option to remote,\n&quot;</span><br><span>@@ -19=
44,6 +1946,20 @@</span><br><span>             subnet_pools_check(options-&g=
t;subnet_pools, options-&gt;server_network,</span><br><span>               =
                 options-&gt;server_netmask, M_USAGE);</span><br><span>    =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (o=
ptions-&gt;subnet_pools_ipv6)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if (!options-&gt;server_ipv6_defined)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                msg(M_USAGE, &quot;--subnet-pool-ip=
v6 requires --server-ipv6&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (dev_type_enum(options-&gt;dev, options-&gt;dev_type=
) !=3D DEV_TYPE_TUN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                || options-&gt;topology !=3D TOP_SUBNET)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                msg(M_USAGE, &quot;--subnet-=
pool-ipv6 requires --dev tun and --topology subnet&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            subnet_pools6_check(options-&=
gt;subnet_pools_ipv6, &amp;options-&gt;server_network_ipv6,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                opt=
ions-&gt;server_netbits_ipv6, M_USAGE);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span>         MUST_BE_UNDEF(allow_=
recursive_routing, &quot;allow-recursive-routing&quot;);</span><br><span>  =
       if (options-&gt;auth_user_pass_file)</span><br><span>         {</spa=
n><br><span>@@ -2011,6 +2027,7 @@</span><br><span>         MUST_BE_UNDEF(if=
config_pool_persist_filename, &quot;ifconfig-pool-persist&quot;);</span><br=
><span>         MUST_BE_UNDEF(ifconfig_ipv6_pool_defined, &quot;ifconfig-ip=
v6-pool&quot;);</span><br><span>         MUST_BE_UNDEF(subnet_pools, &quot;=
subnet-pool&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        MUST_BE_UNDEF(subnet_pools_ipv6, &quot;subnet-pool-ipv6&quot;);</sp=
an><br><span>         MUST_BE_UNDEF(real_hash_size, &quot;hash-size&quot;);=
</span><br><span>         MUST_BE_UNDEF(virtual_hash_size, &quot;hash-size&=
quot;);</span><br><span>         MUST_BE_UNDEF(learn_address_script, &quot;=
learn-address&quot;);</span><br><span>@@ -3144,8 +3161,9 @@</span><br><span=
> }</span><br><span> </span><br><span> /*</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * The server&#39;s tun device is only configured with =
the --server network, so</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * route each --subnet-pool network into it as well: without this the se=
rver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The server&#=
39;s tun device is only configured with the --server and</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * --server-ipv6 networks, so route ea=
ch --subnet-pool and --subnet-pool-ipv6</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * network into it as well: without this the server</sp=
an><br><span>  * could not reach its subnet-pool clients when the data chan=
nel runs in</span><br><span>  * userspace=2E  Under DCO on Linux and FreeBS=
D the routes are installed on-link,</span><br><span>  * see subnet_pool_rou=
tes_onlink()=2E</span><br><span>@@ -3163,6 +3181,16 @@</span><br><span>    =
                                   o-&gt;route_default_table_id);</span><br=
><span>         ro-&gt;on_link =3D subnet_pool_routes_onlink(o);</span><br>=
<span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const struct subn=
et_pool6_def *d =3D o-&gt;subnet_pools_ipv6; d; d =3D d-&gt;next)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct buffer prefix =3D alloc_bu=
f_gc(64, &amp;o-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_pr=
intf(&amp;prefix, &quot;%s/%u&quot;, print_in6_addr(d-&gt;network, 0, &amp;=
o-&gt;gc), d-&gt;netbits);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        rol6_check_alloc(o);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        add_route_ipv6_to_option_list(o-&gt;routes_ipv6, BS=
TR(&amp;prefix), NULL, NULL,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                      o-&gt;route_default_table_id=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span> }</span><br><span> </span><br><span> static void</span><br><span>@@ -=
6325,6 +6353,37 @@</span><br><span>         sp-&gt;next =3D options-&gt;sub=
net_pools;</span><br><span>         options-&gt;subnet_pools =3D sp;</span>=
<br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else if (streq(p[0], &quot;subnet-pool-ipv6&quot;) &amp;&amp; p[1] &amp;&a=
mp; p[2] &amp;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 struct subnet_pool6_def *sp;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct in6_addr network, gateway;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        unsigned int netbits =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!get_ipv6_=
addr(p[2], &amp;network, &amp;netbits, msglevel))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(msglevel, &quot;cannot parse --subnet-p=
ool-ipv6 network&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            goto err;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (netbits &lt; 64 || netbits &gt; 124)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(msglevel, &quot;--subnet-pool-ipv6 network =
must be between /64 and /124 (not /%u)&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                netbits);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (p[3] &amp;&amp; !get_ipv6_addr(p[3], =
&amp;gateway, NULL, msglevel))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(msglevel, &quot;cannot parse --subnet-pool-ipv6 gateway&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            go=
to err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_GC(s=
p, struct subnet_pool6_def, &amp;options-&gt;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        sp-&gt;tag =3D p[1];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;network =3D network;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;netbi=
ts =3D netbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    sp-&gt;gateway =3D p[3] ? gateway : add_in6_addr(network, 1);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;next =3D optio=
ns-&gt;subnet_pools_ipv6;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        options-&gt;subnet_pools_ipv6 =3D sp;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq=
(p[0], &quot;subnet-pool-tag&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span=
><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_INSTANCE=
);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/optio=
ns=2Eh</span><br><span>index ff26066=2E=2Ec758943 100644</span><br><span>--=
- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</=
span><br><span>@@ -263,6 +263,16 @@</span><br><span>     in_addr_t gateway;=
</span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* The IPv6 counterpart of struct subnet_pool_def (--sub=
net-pool-ipv6)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct subnet_pool6_def</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct su=
bnet_pool6_def *next;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *tag;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct in6_addr network;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    unsigned int netbits;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct in6_addr gateway;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> /* Command line options */</span><br><span> str=
uct options</span><br><span> {</span><br><span>@@ -529,12 +539,17 @@</span>=
<br><span>     bool push_ifconfig_constraint_defined;</span><br><span>     =
in_addr_t push_ifconfig_constraint_network;</span><br><span>     in_addr_t =
push_ifconfig_constraint_netmask;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct subnet_pool_def *subnet_pools; /* named pools (serve=
r config) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 char *subnet_pool_tag;          /* which pool this client uses (CCD) */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool subnet_pool_def=
ined;             /* resolved from the tag at connect */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def *subnet_poo=
ls;       /* named IPv4 pools (server config) */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct subnet_pool6_def *subnet_pools_ipv6=
; /* named IPv6 pools (server config) */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *subnet_pool_tag;                /* whi=
ch pool this client uses (CCD) */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    bool subnet_pool_defined;                   /* resolved f=
rom the tag at connect */</span><br><span>     in_addr_t subnet_pool_networ=
k;</span><br><span>     in_addr_t subnet_pool_netmask;</span><br><span>    =
 in_addr_t subnet_pool_gateway;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    bool subnet_pool_ipv6_defined; /* resolved from the tag at =
connect */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t in6_addr subnet_pool_ipv6_network;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    unsigned int subnet_pool_ipv6_netbits;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr subnet_pool_ipv=
6_gateway;</span><br><span>     bool push_ifconfig_ipv4_blocked;           =
/* IPv4 */</span><br><span>     bool push_ifconfig_ipv6_defined;           =
/* IPv6 */</span><br><span>     struct in6_addr push_ifconfig_ipv6_local;  =
/* IPv6 */</span><br><span>diff --git a/src/openvpn/options_util=2Ec b/src/=
openvpn/options_util=2Ec</span><br><span>index 744ad4c=2E=2Efb38cfa 100644<=
/span><br><span>--- a/src/openvpn/options_util=2Ec</span><br><span>+++ b/sr=
c/openvpn/options_util=2Ec</span><br><span>@@ -116,6 +116,108 @@</span><br>=
<span>     return true;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* value of bit &lt;i&gt; (0 =3D m=
ost significant) of an IPv6 address */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+in6_bit(const struct in6_addr *a, unsigned int i)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return a-&gt;s6_addr[i / 8] &amp; (0x80 &gt;&gt;=
 (i % 8));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* true if the first &lt;bits&gt; bits of the =
two addresses are equal */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
n6_prefix_equal(const struct in6_addr *a, const struct in6_addr *b, unsigne=
d int bits)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (unsigned int i =
=3D 0; i &lt; bits; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (in6_bit(a, i) !=3D in6_bit(b, i))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* true if every bit of &lt;a&gt; from bit &lt;from=
&gt; on is zero */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in6_suffi=
x_zero(const struct in6_addr *a, unsigned int from)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (unsigned int i =3D from; i &lt; 128; ++i)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (in6_bit(a, i))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+subnet_pools6_check(const struct subnet_p=
ool6_def *pools, const struct in6_addr *server_network,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    unsigned int server=
_netbits, msglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (=
const struct subnet_pool6_def *d =3D pools; d; d =3D d-&gt;next)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (d-&gt;netbits &lt; 64 || d-&gt;n=
etbits &gt; 124)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(msglevel, &quot;--subnet-pool-ipv6 %s: network must be between /64 and /=
124 (not /%u)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                d-&gt;tag, d-&gt;netbits);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!in6_suffix_zero(&amp;d-&gt;network, d-&gt;netbits))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--subne=
t-pool-ipv6 %s: network has host bits set&quot;, d-&gt;tag);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!in6_prefix_equal(&amp;d-&gt;gateway, &amp;d-=
&gt;network, d-&gt;netbits)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            || in6_suffix_zero(&amp;d-&gt;gateway, d-&gt;netbits))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;--=
subnet-pool-ipv6 %s: gateway must be a host address inside the network&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                d=
-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (server_netbits</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; in=
6_prefix_equal(&amp;d-&gt;network, server_network, min_uint(d-&gt;netbits, =
server_netbits)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(msglevel, &quot;--subnet-pool-ipv6 %s: network overlaps the --server-ip=
v6 network&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              d-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (cons=
t struct subnet_pool6_def *e =3D d-&gt;next; e; e =3D e-&gt;next)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (!strcmp(d-&gt;tag, e-&g=
t;tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ms=
g(msglevel, &quot;--subnet-pool-ipv6 %s: tag defined more than once&quot;, =
d-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (in6_prefix_equal(&amp;d-&gt;network, &amp;e-&gt;network, min_ui=
nt(d-&gt;netbits, e-&gt;netbits)))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                msg(msglevel, &quot;--subnet-pool-ipv6 %s and %s: =
networks overlap&quot;, d-&gt;tag, e-&gt;tag);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+const struct subnet_pool6_def *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+subnet_pool6_by_tag(const struct subnet_=
pool6_def *pools, const char *tag)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (const struct subnet_pool6_def *d =3D pools; d; d =3D d-&gt;next)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(d-&gt;tag, tag))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return d;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> const char *</span><br><span> parse_auth_failed_temp(str=
uct options *o, const char *reason)</span><br><span> {</span><br><span>diff=
 --git a/src/openvpn/options_util=2Eh b/src/openvpn/options_util=2Eh</span>=
<br><span>index d60759a=2E=2Ebffcddb 100644</span><br><span>--- a/src/openv=
pn/options_util=2Eh</span><br><span>+++ b/src/openvpn/options_util=2Eh</spa=
n><br><span>@@ -53,6 +53,25 @@</span><br><span> bool subnet_pools_check(con=
st struct subnet_pool_def *pools, in_addr_t server_network,</span><br><span=
>                         in_addr_t server_netmask, msglvl_t msglevel);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * IPv6 counterpart o=
f subnet_pools_check(): network between /64 and /124</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * without host bits, gateway a host addr=
ess inside it, unique tags, and no</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * network overlapping another pool or the --server-ipv6 net=
work=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pools           hea=
d of the --subnet-pool-ipv6 list (may be NULL)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param server_network  the --server-ipv6 netw=
ork</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param server=
_netbits  the --server-ipv6 prefix length, or 0 if there is none</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param msglevel        leve=
l of the message logged on the first error</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @return                true if every definition i=
s valid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool subnet_pools6_check(con=
st struct subnet_pool6_def *pools,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                         const struct in6_addr *server_netwo=
rk, unsigned int server_netbits,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                         msglvl_t msglevel);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/** IPv6 counterpart of subnet_pool_by_tag()=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct subnet_pool6=
_def *subnet_pool6_by_tag(const struct subnet_pool6_def *pools,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
                    const char *tag);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> </span><br><span> /** Checks if the str=
ing is a valid integer by checking if it can be</span><br><span>  *  conver=
ted to an integer */</span><br><span>diff --git a/src/openvpn/pool=2Ec b/sr=
c/openvpn/pool=2Ec</span><br><span>index fa04d9c=2E=2E8f899d3 100644</span>=
<br><span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b/src/openvpn/pool=
=2Ec</span><br><span>@@ -445,6 +445,22 @@</span><br><span>     return true;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ifconfig_pool_reserve_ipv6(struct ifconfig_pool *pool, const struct in6_=
addr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const ifconfig_pool_ha=
ndle h =3D ifconfig_pool_ipv6_base_to_handle(pool, addr);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (h &lt; 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_entry_free=
(&amp;pool-&gt;list[h], true);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    pool-&gt;list[h]=2Ein_use =3D true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    pool-&gt;list[h]=2Ereserved =3D true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static in_addr_t</span>=
<br><span> ifconfig_pool_handle_to_ip_base(const struct ifconfig_pool *pool=
, ifconfig_pool_handle hand)</span><br><span> {</span><br><span>diff --git =
a/src/openvpn/pool=2Eh b/src/openvpn/pool=2Eh</span><br><span>index 497dcda=
=2E=2Efda87ed 100644</span><br><span>--- a/src/openvpn/pool=2Eh</span><br><=
span>+++ b/src/openvpn/pool=2Eh</span><br><span>@@ -98,6 +98,9 @@</span><br=
><span>  */</span><br><span> bool ifconfig_pool_reserve_ip(struct ifconfig_=
pool *pool, in_addr_t addr);</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/** IPv6 counterpart of ifconfig_pool_reserve_ip=
()=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ifconf=
ig_pool_reserve_ipv6(struct ifconfig_pool *pool, const struct in6_addr *add=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> struct ifconfig_pool_persist *ifconfig_pool_persist_init(const char *file=
name, int refresh_freq);</span><br><span> </span><br><span> void ifconfig_p=
ool_persist_close(struct ifconfig_pool_persist *persist);</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/test_subnet_pool=2Ec b/tests/unit_test=
s/openvpn/test_subnet_pool=2Ec</span><br><span>index 5ce4c76=2E=2Efbb8da9 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_subnet_pool=2Ec</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_subnet_pool=2Ec</span><b=
r><span>@@ -128,11 +128,87 @@</span><br><span>     assert_false(subnet_pool=
s_check(&amp;adup, 0, 0, M_WARN));</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* the IPv6 counterpart=
 resolves independently: a tag may name a v4 pool, a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * v6 pool, or both=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_subnet_pool6_by_tag(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def c =3D { =2En=
ext =3D NULL, =2Etag =3D &quot;grpC&quot;, =2Enetbits =3D 64 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def b =
=3D { =2Enext =3D &amp;c, =2Etag =3D &quot;grpB&quot;, =2Enetbits =3D 96 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_p=
ool6_def a =3D { =2Enext =3D &amp;b, =2Etag =3D &quot;grpA&quot;, =2Enetbit=
s =3D 64 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet=
_pool6_by_tag(&amp;a, &quot;grpA&quot;), &amp;a);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet_pool6_by_tag(&amp=
;a, &quot;grpB&quot;), &amp;b);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_ptr_equal(subnet_pool6_by_tag(&amp;a, &quot;grpC&quo=
t;), &amp;c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(subnet_pool6_by_tag(&amp;a, &quot;grpB&quot;)-&gt;netbits, 9=
6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(=
subnet_pool6_by_tag(&amp;a, &quot;nope&quot;));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_null(subnet_pool6_by_tag(NULL, &quot=
;grpA&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* &lt;prefix&gt;::&lt;host&gt; as an in6=
_addr */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static stru=
ct in6_addr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in6(cons=
t char *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr a;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6,=
 addr, &amp;a), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* a single IPv6 pool, checked against th=
e fd00:8::/64 --server-ipv6 network */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+check6_one(const char *net, unsigned int bits, const char *gw)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct in6_addr server =3D in=
6(&quot;fd00:8::&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct subnet_pool6_def d =3D { =2Enext =3D NULL, =2Etag =3D &quot=
;grp&quot;, =2Enetwork =3D in6(net), =2Enetbits =3D bits, =2Egateway =3D in=
6(gw) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return subnet_pools6_check=
(&amp;d, &amp;server, 64, M_WARN);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_subnet_pools6_check(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* /64 =2E=2E /124, any h=
ost address of the network as gateway */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(check6_one(&quot;fd00:9::&quot;, 64, &=
quot;fd00:9::1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(check6_one(&quot;fd00:9::&quot;, 124, &quot;fd00:9::1&q=
uot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(check6_one(&quot;fd00:9::&quot;, 112, &quot;fd00:9::ffff&quot;));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check6_o=
ne(&quot;fd00:9::&quot;, 63, &quot;fd00:9::1&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(check6_one(&quot;fd00:9:=
:&quot;, 125, &quot;fd00:9::1&quot;));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* host bits in the network, gateway =3D network or outside it */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check6_o=
ne(&quot;fd00:9::5&quot;, 64, &quot;fd00:9::1&quot;));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_false(check6_one(&quot;fd00:9=
::&quot;, 64, &quot;fd00:9::&quot;));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_false(check6_one(&quot;fd00:9::&quot;, 64, &qu=
ot;fd00:a::1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* overlappin=
g the --server-ipv6 network, inside or covering it */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(check6_one(&quot;fd00:8:=
:&quot;, 96, &quot;fd00:8::1&quot;));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* two pools: disjoint, overlapping, same tag */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct in6_addr server =3D in6(=
&quot;fd00:8::&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct subnet_pool6_def b =3D { =2Enext =3D NULL, =2Etag =3D &quot;g=
rpB&quot;, =2Enetwork =3D in6(&quot;fd00:a::&quot;), =2Enetbits =3D 64, =2E=
gateway =3D in6(&quot;fd00:a::1&quot;) };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct subnet_pool6_def a =3D { =2Enext =3D &amp;=
b, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D in6(&quot;fd00:9::&quot;), =
=2Enetbits =3D 64, =2Egateway =3D in6(&quot;fd00:9::1&quot;) };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(subnet_pools6_check(&amp;a, &amp;s=
erver, 64, M_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(subnet_pools6_check(&amp;a, &amp;server, 0, M_WARN));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* a /120 grpB inside grpA */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def=
 bin =3D { =2Enext =3D NULL, =2Etag =3D &quot;grpB&quot;, =2Enetwork =3D in=
6(&quot;fd00:9::100&quot;), =2Enetbits =3D 120, =2Egateway =3D in6(&quot;fd=
00:9::101&quot;) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct subnet_pool6_def ain =3D { =2Enext =3D &amp;bin, =2Etag =3D &quo=
t;grpA&quot;, =2Enetwork =3D in6(&quot;fd00:9::&quot;), =2Enetbits =3D 64, =
=2Egateway =3D in6(&quot;fd00:9::1&quot;) };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_false(subnet_pools6_check(&amp;ain, &am=
p;server, 64, M_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the same=
 tag defined twice */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct subnet_pool6_def bdup =3D { =2Enext =3D NULL, =2Etag =3D &quot=
;grpA&quot;, =2Enetwork =3D in6(&quot;fd00:a::&quot;), =2Enetbits =3D 64, =
=2Egateway =3D in6(&quot;fd00:a::1&quot;) };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct subnet_pool6_def adup =3D { =2Enext =3D=
 &amp;bdup, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D in6(&quot;fd00:9::&=
quot;), =2Enetbits =3D 64, =2Egateway =3D in6(&quot;fd00:9::1&quot;) };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(subnet=
_pools6_check(&amp;adup, &amp;server, 64, M_WARN));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> const struct CMUnitTest subnet_pool_tests=
[] =3D {</span><br><span>     cmocka_unit_test(test_subnet_pool_by_tag),</s=
pan><br><span>     cmocka_unit_test(test_subnet_pools_check_netmask),</span=
><br><span>     cmocka_unit_test(test_subnet_pools_check_gateway),</span><b=
r><span>     cmocka_unit_test(test_subnet_pools_check_overlap),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_subne=
t_pool6_by_tag),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 cmocka_unit_test(test_subnet_pools6_check),</span><br><span> };</span><br>=
<span> </span><br><span> int</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail">change 1786</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6=
4e0850d48647a2c0e3d385c2f20a9f445931727 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1786 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: Antonio Quartulli=
 &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--FolxjgOuzu8=--


--===============7513716951526175454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7513716951526175454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7513716951526175454==--

