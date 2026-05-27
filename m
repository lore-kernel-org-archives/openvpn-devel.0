Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3784CD5BD0
	for <openvpn-devel@archiver.kernel.org>; Wed, 27 May 2026 11:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=qpH44QS7myD8+RWbSGyWEZlQnHFoYkyP+oPa2d/Bmq0=; b=S3SHe9gtCrmq7v
	CbGkvNdb9Ap+0LG+cafsUwhrttfOMwW3fxy4E6vHydlc4YtlBxYElzvASDcHhhbdDs5COjH4wDCYo
	/hTZtmedFgkjh+0EBmMuVfkViQk2zCfOCQI6nWT74KHViZWqec3cdkgfcmicJEPONurKX4OF4icFc
	8wI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSCeP-0003hM-IJ;
	Wed, 27 May 2026 11:42:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wSCeN-0003gm-Mr
 for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 11:42:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iT6h2Mfv13zeDXAFBEB2ZIl1PlDuWFAK9zcHpIreqxc=; b=RwJFMGSUh4vY5xjyQUf/HQJK8Y
 9owMTHFM0aBZxQHYpOv8IlvsuFA39P+MfVl1e9DonfZOtEJDcTxLSJZMIQg1EDV98o5ayEViILJ6b
 j8gu2aPHLA5Vfc+cRZi1k7yQbJsp0xMo07+eg0YBfq4vBl/qCgXXgK47A6DaffrkP2MY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iT6h2Mfv13zeDXAFBEB2ZIl1PlDuWFAK9zcHpIreqxc=; b=J
 UMMcEcE84El/BZySyTGavZ5huGfPIlzT6snQDsqbBN1VvzpRWmuol9RUdyTrbUuJ3TjzuO3r/bEBP
 2JOkIGJDWR+Tfn+v+/RyGQLzEmlFGQvNTd48hcXuybL6fy8AOMGAO1yLA6NTxpoRwVv9QIXI/I/8h
 lflRSFrL6Mpb35hQ=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wSCe6-00056u-Je for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 11:42:01 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4903f7a90d1so46387005e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 27 May 2026 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779882112; x=1780486912; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iT6h2Mfv13zeDXAFBEB2ZIl1PlDuWFAK9zcHpIreqxc=;
 b=KzEk2I0Jdx5jcfVqd87Ua14GZvNfan4SAjm3LBMq1gExEAK9LVpR1pkcQcQo5zUuKH
 g+xddV/2WlUcMYn/VWUSnjbBw4pVr+0NbVeahyE2GMosZExeMS567RCmkwt7pFGMGepe
 LnQy7yv+DaDr5rX6vkqPMoBQv8sl69fR+ozJ63FmpI4tq9fkHypwthEv1UxPZM+ZqTMi
 0mmrgb2g/dDb07l62+tgGxFBnaTS15ZDhbeD0K6aH3Xp0HsNd51Di2TGH8QRVzCmXrWp
 2wlU7cgddK4sM8oZvfQkjGhUOKKtrTnWf/o/KzHmZEyuQljSybBsKZhEFS3KqCWZuVlO
 Pu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779882112; x=1780486912;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iT6h2Mfv13zeDXAFBEB2ZIl1PlDuWFAK9zcHpIreqxc=;
 b=jABpaik5bFG/0jpm9xN8ok4cq4fuVnJjj0f/scmBUBx90dTVFgi5NamA8y/V8UFlge
 wZ7qnEupPataZIN2I9mzFuO6mC1KmnJxrcrcw1cc9h0vX+c1FDSjx2MA0xH6mv9H0LQS
 DTP+rlvnoddkaEEll3ojRTnJjKOoLQClDgSOaqJZ6Q04qDMPUQFZq9w+2OKi9J7Oc8Oo
 dQlRi/Blcb+ZFtHKAIOeK0UtKiGkLI4zUt4PPU0dH6OJH1rA6HSbpb/PqwYME7TIjhZG
 yqzJwhdB7fRdymq5uxsw9HbgBsQmvx3GAqajsDwXA+MJXAtWn5hUcXEWPqqzE82uYOmy
 aq7Q==
X-Gm-Message-State: AOJu0YyhcRug0yRxywYiF6Fep6z+bPD9y5g2egEZjf6kCLh9DsPbhqKM
 w0+QMNuXjY9KXXrVMdqdjO2hvY9E4SZD6vYLvlul4foQzsGTKp1T/DBW9+PtfCPwo2qljzcCwv5
 /YLTBH1PiBVTcbHM4p4GQlxHz1pIwDDi9RnASsEsH6xNexuBJg+yKicRUfhOyz3THQktACuU3rv
 rkALzGMw==
X-Gm-Gg: Acq92OEAFjRsg6bWF4o1Lwt1gt1uHoaLzra4z3HA2s6/c3J/xHVuWa5EJjHInAUqONj
 ir0pY2vSFKPR6i8FCgaUmGy2DHAK158gP0S6eXLNRKGKGJB6j5Q1MNhHKO/uXqvzP0W3I7hSjp1
 saf/6Z3M6BWBCuh2yJHYBb2kbpcHRQLfvjK6Md6zy8Jgnv/mc9xSe/T/SxCMgoATvmL2qcsfx1/
 N/kfI8Xo14XHDN9rqlfRvVY2aWoaeiuNN7KT1r3BPraSX7rEvSLQdajWtQIp7zwtzUV8JnYLIMp
 ez5HmhtJZbCrKyoMkRWFRgtrPWw7B5mfZLEBZyKkDx+lWZ8P8b1+uZ57kYMqmzxH+59V0Ydvpc/
 agfkrmCqFSezcUAq7ggC4USQxqyi6ZU1O200xY7ouLfVPcdChafuCL3SxaOJN2TE2PU4e++uqQ8
 VADLtE/IoL6WdxwM1xZfXNZggdlfRSaXaK/IuBlwPkNwlb6M4A/mawr4IJLvqznTslij8puQBwk
 anK6HMBtM2Srx5J4ny4JrVIImTrUxvCuA9/c/dA6RQXazBySjRTAgEaWVN9GwGFgSDEC9jzUNRt
 YaLLntO3iZzS515RGubFeHtkL2l7Nev31cw=
X-Received: by 2002:a05:600c:1f87:b0:48a:8905:a500 with SMTP id
 5b1f17b1804b1-490424ad9abmr365781035e9.12.1779882112227; 
 Wed, 27 May 2026 04:41:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490809ea514sm20617985e9.9.2026.05.27.04.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 04:41:51 -0700 (PDT)
From: "stipa (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 27 May 2026 11:41:51 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I21d782780b7f89b3061dd97500589a24415afc23
X-Gerrit-Change-Number: 1704
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1704?usp=email>
X-Gerrit-Commit: cfb380539f4084fd65cb54b175cd5258e67cfb0f
References: <gerrit.1779882108000.I21d782780b7f89b3061dd97500589a24415afc23@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5ODgyMTA4MDAwLkkyMWQ3ODI3ODBiN2Y4OWIzMDYxZGQ5NzUwMDU4OWEyNDQxNWFmYzIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e7a134024417dc05a99a57121b6b211180978866-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wSCe6-00056u-Je
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route: Don't delete
 pre-existing host route to VPN server on disconnect
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
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4310718806744885861=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4310718806744885861==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4oBhB13KTKA="; charset=UTF-8

--4oBhB13KTKA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1704?usp=3Demail

to review the following change=2E


Chang=
e subject: route: Don't delete pre-existing host route to VPN server on dis=
connect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

rout=
e: Don't delete pre-existing host route to VPN server on disconnect

When a=
 host route to the VPN server already exists at connect time
(e=2Eg=2E a ma=
nually configured static route), add_route3() returns true
for both "succes=
sfully added" and "already exists" but discards the
per-route RT_ADDED bit,=
 since it operates on a local struct route_ipv4=2E
The caller in redirect_d=
efault_route_to_vpn() then sets RL_DID_LOCAL
unconditionally, and on discon=
nect undo_redirect_default_route_to_vpn()
asks del_route3() to delete it --=
 which forces RT_ADDED on a fresh struct,
bypassing delete_route()'s protec=
tive guard=2E The result: the pre-existing
route gets removed=2E

Change ad=
d_route3() to return RTA_SUCCESS / RTA_EEXIST / RTA_ERROR by
inspecting the=
 local struct's RT_ADDED bit after add_route()=2E Only set
RL_DID_LOCAL on =
RTA_SUCCESS so a pre-existing route survives disconnect=2E
Apply the same f=
ix to the DHCP/DNS bypass routes via a new
route_bypass=2Ebypass_added bitm=
ask so each entry is only deleted on undo
if we added it=2E

GitHub: #970

=
Change-Id: I21d782780b7f89b3061dd97500589a24415afc23
Signed-off-by: Lev Sti=
pakov <lev@openvpn=2Enet>
---
M src/openvpn/route=2Ec
M src/openvpn/route=
=2Eh
2 files changed, 39 insertions(+), 17 deletions(-)



  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/04/1704/1

diff --git a/=
src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 81ce867=2E=2E06e63e1 10=
0644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -882,7 +882=
,10 @@
     return ret;
 }
 
-static bool
+/* Returns RTA_SUCCESS, RTA_EEXI=
ST or RTA_ERROR=2E RTA_EEXIST means the
+ * route was already present in th=
e system and was not added by us; the
+ * caller must not delete it on undo=
=2E */
+static int
 add_route3(in_addr_t network, in_addr_t netmask, in_add=
r_t gateway, const struct tuntap *tt,
            unsigned int flags, const=
 struct route_gateway_info *rgi, const struct env_set *es,
            open=
vpn_net_ctx_t *ctx)
@@ -893,7 +896,11 @@
     r=2Enetwork =3D network;
    =
 r=2Enetmask =3D netmask;
     r=2Egateway =3D gateway;
-    return add_rou=
te(&r, tt, flags, rgi, es, ctx);
+    if (!add_route(&r, tt, flags, rgi, es=
, ctx))
+    {
+        return RTA_ERROR;
+    }
+    return (r=2Eflags & R=
T_ADDED) ? RTA_SUCCESS : RTA_EEXIST;
 }
 
 static void
@@ -915,14 +922,19 @=
@
                   unsigned int flags, const struct route_gateway_info *r=
gi,
                   const struct env_set *es, openvpn_net_ctx_t *ctx)
 {=

-    int ret =3D true;
+    bool ret =3D true;
+    rb->bypass_added =3D 0=
;
     for (int i =3D 0; i < rb->n_bypass; ++i)
     {
         if (rb->byp=
ass[i])
         {
-            ret =3D add_route3(rb->bypass[i], IPV4_NETM=
ASK_HOST, gateway, tt, flags | ROUTE_REF_GW,
-                             =
rgi, es, ctx)
-                  && ret;
+            int status =3D add_ro=
ute3(rb->bypass[i], IPV4_NETMASK_HOST, gateway, tt,
+                      =
              flags | ROUTE_REF_GW, rgi, es, ctx);
+            if (status =
=3D=3D RTA_SUCCESS)
+            {
+                rb->bypass_added |=3D (=
1u << i);
+            }
+            ret =3D (status !=3D RTA_ERROR) && re=
t;
         }
     }
     return ret;
@@ -933,15 +945,15 @@
               =
    unsigned int flags, const struct route_gateway_info *rgi,
             =
      const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
-    int i;
-   =
 for (i =3D 0; i < rb->n_bypass; ++i)
+    for (int i =3D 0; i < rb->n_bypa=
ss; ++i)
     {
-        if (rb->bypass[i])
+        if (rb->bypass[i] && (=
rb->bypass_added & (1u << i)))
         {
             del_route3(rb->bypas=
s[i], IPV4_NETMASK_HOST, gateway, tt, flags | ROUTE_REF_GW, rgi, es,
      =
                  ctx);
         }
     }
+    rb->bypass_added =3D 0;
 }
 =

 static bool
@@ -996,12 +1008,16 @@
                 if ((rl->spec=2Eflags=
 & RTSA_REMOTE_HOST)
                     && rl->spec=2Eremote_host !=3D IP=
V4_INVALID_ADDR)
                 {
-                    ret =3D add_route3=
(rl->spec=2Eremote_host, IPV4_NETMASK_HOST, rl->rgi=2Egateway=2Eaddr,
-    =
                                 tt, flags | ROUTE_REF_GW, &rl->rgi, es, ct=
x);
-                    if (ret)
+                    int status =3D add_r=
oute3(rl->spec=2Eremote_host, IPV4_NETMASK_HOST,
+                         =
                   rl->rgi=2Egateway=2Eaddr, tt, flags | ROUTE_REF_GW,
+   =
                                         &rl->rgi, es, ctx);
+             =
       /* only flag as ours-to-undo when we actually added it;
+           =
          * a pre-existing route (RTA_EEXIST) must survive disconnect */
+ =
                   if (status =3D=3D RTA_SUCCESS)
                     {
  =
                       rl->iflags |=3D RL_DID_LOCAL;
                     }=

+                    ret =3D (status !=3D RTA_ERROR);
                 }
 =
                else
                 {
@@ -1020,13 +1036,15 @@
           =
      if (rl->flags & RG_DEF1)
                 {
                     /* a=
dd new default route (1st component) */
-                    ret =3D add_ro=
ute3(0x00000000, 0x80000000, rl->spec=2Eremote_endpoint, tt, flags,
-      =
                               &rl->rgi, es, ctx)
+                    ret =
=3D (add_route3(0x00000000, 0x80000000, rl->spec=2Eremote_endpoint, tt, fla=
gs,
+                                      &rl->rgi, es, ctx)
+            =
               !=3D RTA_ERROR)
                           && ret;
 
       =
              /* add new default route (2nd component) */
-                =
    ret =3D add_route3(0x80000000, 0x80000000, rl->spec=2Eremote_endpoint, =
tt, flags,
-                                     &rl->rgi, es, ctx)
+      =
              ret =3D (add_route3(0x80000000, 0x80000000, rl->spec=2Eremote=
_endpoint, tt, flags,
+                                      &rl->rgi, es, =
ctx)
+                           !=3D RTA_ERROR)
                          =
 && ret;
                 }
                 else
@@ -1040,7 +1058,8 @@
   =
                  }
 
                     /* add new default route */
-   =
                 ret =3D add_route3(0, 0, rl->spec=2Eremote_endpoint, tt, f=
lags, &rl->rgi, es, ctx)
+                    ret =3D (add_route3(0, 0, rl-=
>spec=2Eremote_endpoint, tt, flags, &rl->rgi, es, ctx)
+                   =
        !=3D RTA_ERROR)
                           && ret;
                =
 }
             }
diff --git a/src/openvpn/route=2Eh b/src/openvpn/route=2E=
h
index 88107e9=2E=2E23d2eed 100644
--- a/src/openvpn/route=2Eh
+++ b/src/o=
penvpn/route=2Eh
@@ -54,6 +54,9 @@
 #define N_ROUTE_BYPASS 8
     int n_byp=
ass;
     in_addr_t bypass[N_ROUTE_BYPASS];
+    /* bit i set when bypass[i=
] was actually added by us (so we may delete
+     * it on undo); cleared w=
hen the route already existed in the system=2E */
+    unsigned int bypass_=
added;
 };
 
 struct route_special_addr

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1704?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I21d782780b7f89b3061dd97500589a24415afc23
Gerrit-Cha=
nge-Number: 1704
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gmail=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plai=
sthos <arne-openvpn@rfc2549=2Eorg>

--4oBhB13KTKA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1704?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ro=
ute: Don&#39;t delete pre-existing host route to VPN server on disconnect<b=
r><br>When a host route to the VPN server already exists at connect time<br=
>(e=2Eg=2E a manually configured static route), add_route3() returns true<b=
r>for both &quot;successfully added&quot; and &quot;already exists&quot; bu=
t discards the<br>per-route RT_ADDED bit, since it operates on a local stru=
ct route_ipv4=2E<br>The caller in redirect_default_route_to_vpn() then sets=
 RL_DID_LOCAL<br>unconditionally, and on disconnect undo_redirect_default_r=
oute_to_vpn()<br>asks del_route3() to delete it -- which forces RT_ADDED on=
 a fresh struct,<br>bypassing delete_route()&#39;s protective guard=2E The =
result: the pre-existing<br>route gets removed=2E<br><br>Change add_route3(=
) to return RTA_SUCCESS / RTA_EEXIST / RTA_ERROR by<br>inspecting the local=
 struct&#39;s RT_ADDED bit after add_route()=2E Only set<br>RL_DID_LOCAL on=
 RTA_SUCCESS so a pre-existing route survives disconnect=2E<br>Apply the sa=
me fix to the DHCP/DNS bypass routes via a new<br>route_bypass=2Ebypass_add=
ed bitmask so each entry is only deleted on undo<br>if we added it=2E<br><b=
r>GitHub: #970<br><br>Change-Id: I21d782780b7f89b3061dd97500589a24415afc23<=
br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/op=
envpn/route=2Ec<br>M src/openvpn/route=2Eh<br>2 files changed, 39 insertion=
s(+), 17 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/04/1704/1</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 81ce867=2E=
=2E06e63e1 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><sp=
an>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -882,7 +882,10 @@</span><=
br><span>     return ret;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Returns RTA_SUCCESS, RTA_EEXIST or RTA=
_ERROR=2E RTA_EEXIST means the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * route was already present in the system and was not added by =
us; the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * caller mu=
st not delete it on undo=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static int</span><br><span> add_route3(in_addr_t network, in_add=
r_t netmask, in_addr_t gateway, const struct tuntap *tt,</span><br><span>  =
          unsigned int flags, const struct route_gateway_info *rgi, const s=
truct env_set *es,</span><br><span>            openvpn_net_ctx_t *ctx)</spa=
n><br><span>@@ -893,7 +896,11 @@</span><br><span>     r=2Enetwork =3D netwo=
rk;</span><br><span>     r=2Enetmask =3D netmask;</span><br><span>     r=2E=
gateway =3D gateway;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return add_route(&amp;r, tt, flags, rgi, es, ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!add_route(&amp;r, tt, flags, rgi=
, es, ctx))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return RTA_ERR=
OR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return (r=2Eflags &amp; RT=
_ADDED) ? RTA_SUCCESS : RTA_EEXIST;</span><br><span> }</span><br><span> </s=
pan><br><span> static void</span><br><span>@@ -915,14 +922,19 @@</span><br>=
<span>                   unsigned int flags, const struct route_gateway_inf=
o *rgi,</span><br><span>                   const struct env_set *es, openvp=
n_net_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int ret =3D true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    bool ret =3D true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    rb-&gt;bypass_added =3D 0;</span><br><span>     for=
 (int i =3D 0; i &lt; rb-&gt;n_bypass; ++i)</span><br><span>     {</span><b=
r><span>         if (rb-&gt;bypass[i])</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            ret =3D add_route3(=
rb-&gt;bypass[i], IPV4_NETMASK_HOST, gateway, tt, flags | ROUTE_REF_GW,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
    rgi, es, ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
              &amp;&amp; ret;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            int status =3D add_route3(rb-&gt;bypass[i], IPV4_NETM=
ASK_HOST, gateway, tt,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                    flags | ROUTE_REF_GW, rgi, es, ctx);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (sta=
tus =3D=3D RTA_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              rb-&gt;bypass_added |=3D (1u &lt;&lt; i);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            ret =3D (status !=3D RTA_ERROR) &=
amp;&amp; ret;</span><br><span>         }</span><br><span>     }</span><br>=
<span>     return ret;</span><br><span>@@ -933,15 +945,15 @@</span><br><spa=
n>                   unsigned int flags, const struct route_gateway_info *r=
gi,</span><br><span>                   const struct env_set *es, openvpn_ne=
t_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    for (i =3D 0; i &lt; rb-&gt;n_bypass; ++i)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; rb-&gt;n_bypass; ++=
i)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (rb-&gt;bypass[i])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (rb-&gt;bypass[i] &amp;&amp; (rb-&gt;bypass_added =
&amp; (1u &lt;&lt; i)))</span><br><span>         {</span><br><span>        =
     del_route3(rb-&gt;bypass[i], IPV4_NETMASK_HOST, gateway, tt, flags | R=
OUTE_REF_GW, rgi, es,</span><br><span>                        ctx);</span><=
br><span>         }</span><br><span>     }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    rb-&gt;bypass_added =3D 0;</span><br><span> }</s=
pan><br><span> </span><br><span> static bool</span><br><span>@@ -996,12 +10=
08,16 @@</span><br><span>                 if ((rl-&gt;spec=2Eflags &amp; RT=
SA_REMOTE_HOST)</span><br><span>                     &amp;&amp; rl-&gt;spec=
=2Eremote_host !=3D IPV4_INVALID_ADDR)</span><br><span>                 {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    ret=
 =3D add_route3(rl-&gt;spec=2Eremote_host, IPV4_NETMASK_HOST, rl-&gt;rgi=2E=
gateway=2Eaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                               tt, flags | ROUTE_REF_GW, &amp;rl-&gt;rgi, e=
s, ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       if (ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                int status =3D add_route3(rl-&gt;spec=2Eremote_host, IPV4_N=
ETMASK_HOST,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                                     rl-&gt;rgi=2Egateway=2Eaddr, tt, flags=
 | ROUTE_REF_GW,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                         &amp;rl-&gt;rgi, es, ctx);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    /* only=
 flag as ours-to-undo when we actually added it;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                     * a pre-existing route (R=
TA_EEXIST) must survive disconnect */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    if (status =3D=3D RTA_SUCCESS)</span>=
<br><span>                     {</span><br><span>                         r=
l-&gt;iflags |=3D RL_DID_LOCAL;</span><br><span>                     }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    ret =
=3D (status !=3D RTA_ERROR);</span><br><span>                 }</span><br><=
span>                 else</span><br><span>                 {</span><br><sp=
an>@@ -1020,13 +1036,15 @@</span><br><span>                 if (rl-&gt;flag=
s &amp; RG_DEF1)</span><br><span>                 {</span><br><span>       =
              /* add new default route (1st component) */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    ret =3D add_route3(=
0x00000000, 0x80000000, rl-&gt;spec=2Eremote_endpoint, tt, flags,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
      &amp;rl-&gt;rgi, es, ctx)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    ret =3D (add_route3(0x00000000, 0x80000000,=
 rl-&gt;spec=2Eremote_endpoint, tt, flags,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                      &amp;rl-&gt;rg=
i, es, ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                   !=3D RTA_ERROR)</span><br><span>                        =
   &amp;&amp; ret;</span><br><span> </span><br><span>                     /=
* add new default route (2nd component) */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    ret =3D add_route3(0x80000000, 0x8=
0000000, rl-&gt;spec=2Eremote_endpoint, tt, flags,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                     &amp;rl-&=
gt;rgi, es, ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 ret =3D (add_route3(0x80000000, 0x80000000, rl-&gt;spec=2E=
remote_endpoint, tt, flags,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                      &amp;rl-&gt;rgi, es, ctx)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
    !=3D RTA_ERROR)</span><br><span>                           &amp;&amp; r=
et;</span><br><span>                 }</span><br><span>                 els=
e</span><br><span>@@ -1040,7 +1058,8 @@</span><br><span>                   =
  }</span><br><span> </span><br><span>                     /* add new defau=
lt route */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          ret =3D add_route3(0, 0, rl-&gt;spec=2Eremote_endpoint, tt, flags=
, &amp;rl-&gt;rgi, es, ctx)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    ret =3D (add_route3(0, 0, rl-&gt;spec=2Eremote_=
endpoint, tt, flags, &amp;rl-&gt;rgi, es, ctx)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                           !=3D RTA_ERROR)</span=
><br><span>                           &amp;&amp; ret;</span><br><span>     =
            }</span><br><span>             }</span><br><span>diff --git a/s=
rc/openvpn/route=2Eh b/src/openvpn/route=2Eh</span><br><span>index 88107e9=
=2E=2E23d2eed 100644</span><br><span>--- a/src/openvpn/route=2Eh</span><br>=
<span>+++ b/src/openvpn/route=2Eh</span><br><span>@@ -54,6 +54,9 @@</span><=
br><span> #define N_ROUTE_BYPASS 8</span><br><span>     int n_bypass;</span=
><br><span>     in_addr_t bypass[N_ROUTE_BYPASS];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* bit i set when bypass[i] was actually =
added by us (so we may delete</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * it on undo); cleared when the route already existed in the=
 system=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    un=
signed int bypass_added;</span><br><span> };</span><br><span> </span><br><s=
pan> struct route_special_addr</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1704?usp=3Demai=
l">change 1704</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
04?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I21d782780b7f89b3061dd97500589a24415afc23 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1704 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stip=
a &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--4oBhB13KTKA=--


--===============4310718806744885861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4310718806744885861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4310718806744885861==--

