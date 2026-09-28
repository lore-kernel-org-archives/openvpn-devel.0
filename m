Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B34C9833E
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 06:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UR1BvPO1FeYJtXqgqNwF1OryZA3mJGqWSafNz5RPI8I=; b=R2a1akaFtPKSW+NBy32/M6rXBB
	/FEhyIbzTTUbq4M0v+lVczyCVPJBOYDzvISSoCLAMig6Y6ByuOT3me4Pp0LjP+plme7K+AIyR+TR4
	sNKL0CAWLSkNa1KOcV32ow87vyAsdm41y6cLM7XFBny1r6LD8BKfEfwLIPf4N1cHXrIA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xB564-00024c-5o;
	Mon, 28 Sep 2026 06:44:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xB55w-00024S-M0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 06:44:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=p0qWfO44E7VPeEeY77DU996fk3K7GWvFNimCwdpraMM=; b=KFy/BVSdbOkC+5ZRu0v3HU4Zh4
 lgW1xgbcsKp6Mx48ZtqIV0338Tt5EELUGoji+LcZh+vyf7VxKkLDwPXlYFhzZ8XQR0osLP9s8mBZt
 +oZBnb6aVKek9sf5SBO1QRRt1sMv52gC2rVkk8mZ9oMI8Ij5j4LfmJVcHS38L2bPp37s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=p0qWfO44E7VPeEeY77DU996fk3K7GWvFNimCwdpraMM=; b=C
 rPc7DqIhgoh1edWnWM9sJ4WmViDiTDX5ESFeRULSAH508btqnKtZf+9YvHnmAHBbejqYbHhMWsPgb
 tYVU1qxNJXNc6HDBK92IdV4gCaH0K6X5uAmrloT73Oguc7Ovox0aYf0+A7Op8fYOOAzRf0zC37nF/
 UAe/78NAKwvPtTpA=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xB55u-0000rp-H7 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 06:44:13 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912df756so20764045e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 27 Sep 2026 23:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790577844; x=1791182644; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p0qWfO44E7VPeEeY77DU996fk3K7GWvFNimCwdpraMM=;
 b=DIx2cKwE9MswmKdPgln1bmMfzBDoMMvWDqQQ2ZTyqJzl1FqLAmDoj6hfXio59AQPYo
 Pj7plC0UipBMn8sX1MTYjgBVhWLGHVWBzUMMfpxe223cgY+vbjwj9bIJPE3arOXP++Di
 qIUk6kiB+eqFJUe/oCXdcSpADU8ywk3EFHg2eemtSDniu6DsVyK02kkysoM+Lq14RBIF
 PnY0fygE+zTgWuMyHChUG9r8sgnOJkSWR1Ru3yhku0e6i44kCgwh+Py1IpxblGIXwOjZ
 zFdNER7CRypZKZWFqG0xQPOms4YbCeblg3sBs9LqEHGAm98/uKeoH195zHkIIqTFTO3K
 PWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790577844; x=1791182644;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=p0qWfO44E7VPeEeY77DU996fk3K7GWvFNimCwdpraMM=;
 b=zB6qFuzwb8SSfZZcoTy5tSGMAtPsNUTc4J9BNROLfwrZIX3eeoN4AVGexzlplMYf9V
 BqoZh88oCRtZhaaW3Gz434DLXf8/li6bw7aHnV41PoHbMHgKGQS7pc9LRs5nxk0InxtK
 faCdX8TuNjFzZF5FAbToj5ojLoi28jU7x7vpCWJvg+TO9ZDxrTdkp1Hz4DCoU32kdjHn
 WaVeIMMSUO1Rta11JuYD2iczuOxtk/EjIfKEGcISoRRg0yOdjDNx5LM8M3QzPCOtzpYg
 dyRosvfBz7/50Y7+ZTnLqg2HVNs81bql+pWj5db7x3Ym+79RpHgAqvKiISjA3iF63Cgj
 Cpgg==
X-Gm-Message-State: AFuF++mkFrxdCWhM0Er1ck5db3JQMrPSDUbWf5QzQR6LZF2xKLiX717o
 SrgKikETB1GPEEVeS5r5QItPjB7uNgpXLW/Y+Fk+VadS0P9Kb5y9Uiyd/NqJAiJVsrlCKqralwp
 LMj8OVCu0Ty9XEMoQcPhDT0s/Jgq1Awk4imSpmX3SFJY3XPXoZcl2w8i0uz0Iwl/HHCeVwpcbp4
 VNIEq+Dg==
X-Gm-Gg: AYBFou04bIkq4XEcYYH6MbQXVAQBRIrYLQaakKJBzcB7H1h2I8Lz4QMcjVGLCU+4AjS
 ESu9PR9cshBcJWwbOxHyafBwHezBSRLFA+v73QSX8DlQ6w5FeplUtM/kGuGHV7stZm1YZ0CvQiT
 YiQ7iJkhILtp73riG+ZRlDNXvi7sbcWs3gIArp6lvakb5uA8mYUG7u97stgtqOMDZf8Ta+Wzvr6
 RcBd1nuOuiZX1iop3Aleb1ZPaZ7txIc7mwx7ILwyD0R1/2c7oQ9jpTDAd9OdO5xe5oBTQTnTa1g
 6mst8xivrbqDS3kbQWw4iXP0XHT2ZuYPPOaBjyBEfEXqrX+wMO61UlzQoL+P7nnp5W8MzQeP/nJ
 3cyWl3Ntqr2oJKfy+wAjNWupQfZdb0yngY7hFRapBShIdILsXUBv77FEjFmBUbpUO9/ZD4GJotE
 d9IRxKE2cQm0djLDcyHnYlz20FRH9HAq3gYJ2dyqvlcShyD9Hw9TdviBwQBgm/0sq/X1TWoTi60
 tX3ka3jwN9YxTBw8cup8HvbuAvTXFsPucLMTpI3lECSk00fl+N1GnMv8NFNNQm8EGS5uNHYbTeF
 L/VghXXV8AEt3iGnH5qWZyFbTIuSMdtjrMJmyXlvJaNRgR45Q9ugwJRaBreu
X-Received: by 2002:a05:600d:4445:10b0:4a0:37b:5c25 with SMTP id
 5b1f17b1804b1-4a0037b5ccbmr25309645e9.11.1790577843277; 
 Sun, 27 Sep 2026 23:44:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0016fd7b8sm129358795e9.2.2026.09.27.23.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 23:44:02 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 06:43:57 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690
X-Gerrit-Change-Number: 1947
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1947?usp=email>
X-Gerrit-Commit: 41618089630cefda590a5019ebe5597439128439
In-Reply-To: <gerrit.1790212215000.I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5ZTQ1YzBlZGJkMmNiMjM3ZjI3ZTM0OWYyZjlkN2Q5YjhkODI2NjkwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7f75cf8dc4e262420643af55a463e2c8197944f6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xB55u-0000rp-H7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route: implement
 net_gateway_ipv6 for --route-ipv6
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
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3766552956224041363=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3766552956224041363==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F4AQoSExz7M="; charset=UTF-8

--F4AQoSExz7M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1947?usp=3Demail

to look at the new patch set (#3)=2E

=

Change subject: route: implement net_gateway_ipv6 for --route-ipv6
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: implement ne=
t_gateway_ipv6 for --route-ipv6

--route has been able to name the system d=
efault gateway symbolically for
a long time: get_special_addr() resolves ne=
t_gateway, vpn_gateway and
remote_host=2E  --route-ipv6 never gained the eq=
uivalent, so the usual IPv4
idiom for keeping specific traffic off the tunn=
el has no IPv6 counterpart=2E

The failure is silent and points the wrong w=
ay=2E  init_route_ipv6() hands
the gateway parameter straight to inet_pton(=
), which rejects
"net_gateway_ipv6" with a warning and leaves the gateway u=
nset=2E
add_route_ipv6() then falls back to device =3D tt->actual_name, so =
a route
meant to bypass the tunnel is installed through it instead -- the e=
xact
opposite of what was asked for=2E

Resolve the name from rl6->ngi6, wh=
ich init_route_ipv6_list() already
fills with the system default gateway an=
d exports to scripts under this
very name, and pin the route to that gatewa=
y's interface so it leaves the
host the same way the corresponding IPv4 rou=
te does=2E  Note this is ngi6
and not rgi6: the latter is the route towards=
 the VPN server, which only
coincides with the default gateway on a singly-=
homed host=2E  An on-link
gateway is not a next hop, so only the interface =
is set in that case=2E

Cover the three outcomes in route_testdriver: a res=
olved gateway, one
the system could not supply, and an on-link gateway wher=
e only the
interface is wanted=2E

Document the keyword under --route-ipv6=
=2E While there, note that the
gateway parameter also accepts "default", wh=
ich means the same as
leaving it out=2E

This revives the patch originally =
submitted in 2021 for Trac #1161=2E

Github: OpenVPN/openvpn#1015
Change-Id=
: I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690
Signed-off-by: Fran=C3=A7ois Ko=
oman <fkooman@tuxed=2Enet>
Signed-off-by: Charlie Vigue <charlie=2Evigue@op=
envpn=2Ecom>
---
M doc/man-sections/vpn-network-options=2Erst
M src/openvpn=
/options=2Ec
M src/openvpn/route=2Ec
M src/openvpn/route=2Eh
M tests/unit_t=
ests/openvpn/test_route=2Ec
5 files changed, 193 insertions(+), 4 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/47=
/1947/3

diff --git a/doc/man-sections/vpn-network-options=2Erst b/doc/man-=
sections/vpn-network-options=2Erst
index 960c6ad=2E=2E8dd1b31 100644
--- a/=
doc/man-sections/vpn-network-options=2Erst
+++ b/doc/man-sections/vpn-netwo=
rk-options=2Erst
@@ -485,7 +485,16 @@
   ``gateway``
         Only used for=
 IPv6 routes across *tap* devices,
         and if missing, the ``ipv6remot=
e`` field from ``--ifconfig-ipv6`` or
-        ``--route-ipv6-gateway`` is =
used=2E
+        ``--route-ipv6-gateway`` is used=2E Setting it to :code:`d=
efault` has
+        the same effect as leaving it out=2E
+
+        It may=
 also be given as the special keyword
+        :code:`net_gateway_ipv6`, th=
e IPv6 counterpart of
+        :code:`net_gateway` described under ``--rout=
e``: the pre-existing
+        IPv6 default gateway, read from the routing =
table (not supported on
+        all OSes)=2E The route is then installed o=
n the interface that
+        gateway is reachable through, which is how tr=
affic is kept out of
+        the tunnel=2E
 
   ``metric``
         defaul=
t taken from ``--route-metric`` if set, otherwise :code:`0`=2E
diff --git a=
/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index e3cd527=2E=2E7eab7=
79 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3=
865,7 +3865,7 @@
             msg(msglevel, "route-ipv6 parameter network/I=
P '%s' must be a valid address", p[1]);
             return false;
        =
 }
-        if (p[2] && !ipv6_addr_safe(p[2]))
+        if (p[2] && !ipv6_a=
ddr_safe(p[2]) && !ipv6_get_special_addr(NULL, p[2], NULL, NULL))
         =
{
             msg(msglevel, "route-ipv6 parameter gateway '%s' must be a v=
alid address", p[2]);
             return false;
diff --git a/src/openvpn/r=
oute=2Ec b/src/openvpn/route=2Ec
index 03a2526=2E=2E837f9ee 100644
--- a/sr=
c/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -284,6 +284,65 @@
     r=
eturn false;
 }
 
+/**
+ * Resolve the special IPv6 gateway name "net_gatew=
ay_ipv6"=2E
+ *
+ * The IPv6 counterpart of get_special_addr(), which handl=
es the IPv4 names=2E
+ * There is currently only one special IPv6 name=2E
+=
 *
+ * @param rl        route list carrying the system default gateway in n=
gi6
+ *                  (not rgi6, which is the route towards the VPN serv=
er), or
+ *                  NULL to merely test whether @p string names a =
special
+ *                  address (used when validating options, where n=
o route
+ *                  list exists yet)
+ * @param string    the --ro=
ute-ipv6 gateway parameter to examine
+ * @param out       receives the res=
olved gateway; only written when @p rl is
+ *                  given and th=
e system gateway is known
+ * @param status    set to false if @p string na=
mes a special address that
+ *                  could not be resolved, so t=
he caller can reject the route;
+ *                  set to true otherwise=
=2E May be NULL=2E
+ *
+ * @return true if @p string is a special address n=
ame, in which case the
+ *         caller must not parse it as a literal ad=
dress; false otherwise=2E
+ */
+bool
+ipv6_get_special_addr(const struct ro=
ute_ipv6_list *rl, const char *string, struct in6_addr *out,
+             =
         bool *status)
+{
+    if (status)
+    {
+        *status =3D true=
;
+    }
+
+    if (strcmp(string, "net_gateway_ipv6") !=3D 0)
+    {
+    =
    return false;
+    }
+
+    if (rl)
+    {
+        if (rl->ngi6=2Eflag=
s & RGI_ADDR_DEFINED)
+        {
+            /* an on-link gateway is not =
a next hop, the interface is
+             * enough -- leave *out unspecifi=
ed in that case */
+            if (!(rl->ngi6=2Eflags & RGI_ON_LINK))
+   =
         {
+                *out =3D rl->ngi6=2Egateway=2Eaddr_ipv6;
+     =
       }
+        }
+        else
+        {
+            msg(M_INFO, PACKA=
GE_NAME " ROUTE: net_gateway_ipv6 undefined -- unable to get default "
+   =
                                  "gateway from system");
+            if (=
status)
+            {
+                *status =3D false;
+            }
+=
        }
+    }
+    return true;
+}
+
 bool
 is_special_addr(const char *=
addr_str)
 {
@@ -422,7 +481,7 @@
 
 static bool
 init_route_ipv6(struct rou=
te_ipv6 *r6, const struct route_ipv6_option *r6o,
-                const st=
ruct route_ipv6_list *rl6)
+                struct route_ipv6_list *rl6)
 {=

     CLEAR(*r6);
 
@@ -434,7 +493,26 @@
     /* gateway */
     if (is_rou=
te_parm_defined(r6o->gateway))
     {
-        if (inet_pton(AF_INET6, r6o-=
>gateway, &r6->gateway) !=3D 1)
+        bool status =3D true;
+
+        i=
f (ipv6_get_special_addr(rl6, r6o->gateway, &r6->gateway, &status))
+      =
  {
+            if (!status)
+            {
+                goto fail;
+ =
           }
+            /* the route has to leave via the interface the s=
ystem gateway
+             * is on, otherwise it would be sent down the tu=
nnel */
+            if (rl6->ngi6=2Eflags & RGI_IFACE_DEFINED)
+          =
  {
+#ifdef _WIN32
+                r6->adapter_index =3D rl6->ngi6=2Eadapt=
er_index;
+#else
+                r6->iface =3D rl6->ngi6=2Eiface;
+#endif
=
+            }
+        }
+        else if (inet_pton(AF_INET6, r6o->gatewa=
y, &r6->gateway) !=3D 1)
         {
             msg(M_WARN, PACKAGE_NAME "=
ROUTE6: cannot parse gateway spec '%s'", r6o->gateway);
         }
diff --g=
it a/src/openvpn/route=2Eh b/src/openvpn/route=2Eh
index 0d33d36=2E=2E41ae0=
dc 100644
--- a/src/openvpn/route=2Eh
+++ b/src/openvpn/route=2Eh
@@ -345,6=
 +345,8 @@
 void setenv_routes_ipv6(struct env_set *es, const struct route_=
ipv6_list *rl6);
 
 bool is_special_addr(const char *addr_str);
+bool ipv6_=
get_special_addr(const struct route_ipv6_list *rl, const char *string,
+   =
                        struct in6_addr *out, bool *status);
 
 /**
  * @br=
ief Retrieves the best gateway for a given destination based on the routing=
 table=2E
diff --git a/tests/unit_tests/openvpn/test_route=2Ec b/tests/unit=
_tests/openvpn/test_route=2Ec
index 476cfa9=2E=2E7b25aa5 100644
--- a/tests=
/unit_tests/openvpn/test_route=2Ec
+++ b/tests/unit_tests/openvpn/test_rout=
e=2Ec
@@ -33,6 +33,10 @@
 
 #include "test_route=2Eh"
 
+/* the system defa=
ult IPv6 gateway, and the route towards the peer */
+#define NET_GATEWAY6  =
"2001:db8:1::1"
+#define PEER_GATEWAY6 "2001:db8:2::1"
+
 /* Stubs for func=
tions route=2Ec references but that no test here reaches=2E
  * They assert=
 rather than return quietly, so a test straying onto one
  * fails loudly i=
nstead of silently doing nothing=2E
@@ -159,11 +163,107 @@
     assert_clea=
r_host_bits("2001:db8::1", 0, "::");
 }
 
+/* Set up a route list where the=
 system default gateway (ngi6) and the
+ * route towards the peer (rgi6) ar=
e different, so a test can tell which
+ * one an answer came from=2E
+ */
+=
static void
+init_test_route_ipv6_list(struct route_ipv6_list *rl6, unsigne=
d int ngi6_flags)
+{
+    CLEAR(*rl6);
+
+    assert_int_equal(inet_pton(AF=
_INET6, NET_GATEWAY6, &rl6->ngi6=2Egateway=2Eaddr_ipv6), 1);
+    rl6->ngi6=
=2Eflags =3D ngi6_flags;
+
+    assert_int_equal(inet_pton(AF_INET6, PEER_G=
ATEWAY6, &rl6->rgi6=2Egateway=2Eaddr_ipv6), 1);
+    rl6->rgi6=2Eflags =3D =
RGI_ADDR_DEFINED;
+}
+
+static void
+test_ipv6_get_special_addr_resolves(vo=
id **state)
+{
+    struct route_ipv6_list rl6;
+    struct in6_addr out, e=
xpect;
+    bool status =3D false;
+
+    init_test_route_ipv6_list(&rl6, R=
GI_ADDR_DEFINED);
+    CLEAR(out);
+
+    assert_true(ipv6_get_special_addr=
(&rl6, "net_gateway_ipv6", &out, &status));
+    assert_true(status);
+
+  =
  /* the system default gateway, not the route towards the peer */
+    ass=
ert_int_equal(inet_pton(AF_INET6, NET_GATEWAY6, &expect), 1);
+    assert_m=
emory_equal(&out, &expect, sizeof(out));
+}
+
+static void
+test_ipv6_get_s=
pecial_addr_not_special(void **state)
+{
+    struct route_ipv6_list rl6;
+=
    struct in6_addr out;
+    bool status =3D false;
+
+    init_test_route=
_ipv6_list(&rl6, RGI_ADDR_DEFINED);
+    CLEAR(out);
+
+    assert_false(ip=
v6_get_special_addr(&rl6, "2001:db8::1", &out, &status));
+    assert_true(=
IN6_IS_ADDR_UNSPECIFIED(&out));
+
+    /* the IPv4 names are not IPv6 names=
 */
+    assert_false(ipv6_get_special_addr(&rl6, "net_gateway", &out, &sta=
tus));
+
+    /* a caller with no route list only learns whether the name i=
s special */
+    assert_true(ipv6_get_special_addr(NULL, "net_gateway_ipv6=
", NULL, NULL));
+    assert_false(ipv6_get_special_addr(NULL, "2001:db8::1=
", NULL, NULL));
+}
+
+static void
+test_ipv6_get_special_addr_undefined(vo=
id **state)
+{
+    struct route_ipv6_list rl6;
+    struct in6_addr out;
+=
    bool status =3D true;
+
+    /* no IPv6 default gateway on this system =
*/
+    init_test_route_ipv6_list(&rl6, 0);
+    CLEAR(out);
+
+    /* stil=
l a special name, but one that could not be resolved, so the
+     * caller=
 must reject the route rather than install it via the tunnel
+     */
+    =
assert_true(ipv6_get_special_addr(&rl6, "net_gateway_ipv6", &out, &status))=
;
+    assert_false(status);
+    assert_true(IN6_IS_ADDR_UNSPECIFIED(&out)=
);
+}
+
+static void
+test_ipv6_get_special_addr_on_link(void **state)
+{
+=
    struct route_ipv6_list rl6;
+    struct in6_addr out;
+    bool status =
=3D false;
+
+    init_test_route_ipv6_list(&rl6, RGI_ADDR_DEFINED | RGI_ON=
_LINK);
+    CLEAR(out);
+
+    /* an on-link gateway is not a next hop: th=
e name resolves, but no
+     * gateway address is handed back
+     */
+  =
  assert_true(ipv6_get_special_addr(&rl6, "net_gateway_ipv6", &out, &status=
));
+    assert_true(status);
+    assert_true(IN6_IS_ADDR_UNSPECIFIED(&out=
));
+}
+
 static const struct CMUnitTest route_test_list[] =3D {
     cmock=
a_unit_test(test_is_special_addr),
     cmocka_unit_test(test_netmask_to_ne=
tbits),
     cmocka_unit_test(test_netmask_to_netbits2),
     cmocka_unit_t=
est(test_route_ipv6_clear_host_bits),
+    cmocka_unit_test(test_ipv6_get_s=
pecial_addr_resolves),
+    cmocka_unit_test(test_ipv6_get_special_addr_not=
_special),
+    cmocka_unit_test(test_ipv6_get_special_addr_undefined),
+  =
  cmocka_unit_test(test_ipv6_get_special_addr_on_link),
 };
 
 int

-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1947?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9e45c0edbd2cb237f27e349f=
2f9d7d9b8d826690
Gerrit-Change-Number: 1947
Gerrit-PatchSet: 3
Gerrit-Owner=
: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--F4AQoSExz7M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>chugly <strong>uploaded patch se=
t #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1947?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">route: i=
mplement net_gateway_ipv6 for --route-ipv6<br><br>--route has been able to =
name the system default gateway symbolically for<br>a long time: get_specia=
l_addr() resolves net_gateway, vpn_gateway and<br>remote_host=2E  --route-i=
pv6 never gained the equivalent, so the usual IPv4<br>idiom for keeping spe=
cific traffic off the tunnel has no IPv6 counterpart=2E<br><br>The failure =
is silent and points the wrong way=2E  init_route_ipv6() hands<br>the gatew=
ay parameter straight to inet_pton(), which rejects<br>&quot;net_gateway_ip=
v6&quot; with a warning and leaves the gateway unset=2E<br>add_route_ipv6()=
 then falls back to device =3D tt-&gt;actual_name, so a route<br>meant to b=
ypass the tunnel is installed through it instead -- the exact<br>opposite o=
f what was asked for=2E<br><br>Resolve the name from rl6-&gt;ngi6, which in=
it_route_ipv6_list() already<br>fills with the system default gateway and e=
xports to scripts under this<br>very name, and pin the route to that gatewa=
y&#39;s interface so it leaves the<br>host the same way the corresponding I=
Pv4 route does=2E  Note this is ngi6<br>and not rgi6: the latter is the rou=
te towards the VPN server, which only<br>coincides with the default gateway=
 on a singly-homed host=2E  An on-link<br>gateway is not a next hop, so onl=
y the interface is set in that case=2E<br><br>Cover the three outcomes in r=
oute_testdriver: a resolved gateway, one<br>the system could not supply, an=
d an on-link gateway where only the<br>interface is wanted=2E<br><br>Docume=
nt the keyword under --route-ipv6=2E While there, note that the<br>gateway =
parameter also accepts &quot;default&quot;, which means the same as<br>leav=
ing it out=2E<br><br>This revives the patch originally submitted in 2021 fo=
r Trac #1161=2E<br><br>Github: OpenVPN/openvpn#1015<br>Change-Id: I9e45c0ed=
bd2cb237f27e349f2f9d7d9b8d826690<br>Signed-off-by: Fran=C3=A7ois Kooman &lt=
;fkooman@tuxed=2Enet&gt;<br>Signed-off-by: Charlie Vigue &lt;charlie=2Evigu=
e@openvpn=2Ecom&gt;<br>---<br>M doc/man-sections/vpn-network-options=2Erst<=
br>M src/openvpn/options=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvpn/ro=
ute=2Eh<br>M tests/unit_tests/openvpn/test_route=2Ec<br>5 files changed, 19=
3 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/1947/3</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/doc/man-sections/vpn-network-options=2Erst b/doc/man-sections/vpn-net=
work-options=2Erst</span><br><span>index 960c6ad=2E=2E8dd1b31 100644</span>=
<br><span>--- a/doc/man-sections/vpn-network-options=2Erst</span><br><span>=
+++ b/doc/man-sections/vpn-network-options=2Erst</span><br><span>@@ -485,7 =
+485,16 @@</span><br><span>   ``gateway``</span><br><span>         Only use=
d for IPv6 routes across *tap* devices,</span><br><span>         and if mis=
sing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` or</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        ``--route-ipv6-gateway`` is us=
ed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ``--ro=
ute-ipv6-gateway`` is used=2E Setting it to :code:`default` has</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        the same effect as leav=
ing it out=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        It may also be gi=
ven as the special keyword</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        :code:`net_gateway_ipv6`, the IPv6 counterpart of</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        :code:`net_gateway` de=
scribed under ``--route``: the pre-existing</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        IPv6 default gateway, read from the routing=
 table (not supported on</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        all OSes)=2E The route is then installed on the interface that=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gateway is =
reachable through, which is how traffic is kept out of</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        the tunnel=2E</span><br><span> <=
/span><br><span>   ``metric``</span><br><span>         default taken from `=
`--route-metric`` if set, otherwise :code:`0`=2E</span><br><span>diff --git=
 a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index =
e3cd527=2E=2E7eab779 100644</span><br><span>--- a/src/openvpn/options=2Ec</=
span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -3865,7 +38=
65,7 @@</span><br><span>             msg(msglevel, &quot;route-ipv6 paramet=
er network/IP &#39;%s&#39; must be a valid address&quot;, p[1]);</span><br>=
<span>             return false;</span><br><span>         }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (p[2] &amp;&amp; !ipv6_add=
r_safe(p[2]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (p[2] &amp;&amp; !ipv6_addr_safe(p[2]) &amp;&amp; !ipv6_get_special_ad=
dr(NULL, p[2], NULL, NULL))</span><br><span>         {</span><br><span>    =
         msg(msglevel, &quot;route-ipv6 parameter gateway &#39;%s&#39; must=
 be a valid address&quot;, p[2]);</span><br><span>             return false=
;</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2E=
c</span><br><span>index 03a2526=2E=2E837f9ee 100644</span><br><span>--- a/s=
rc/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br>=
<span>@@ -284,6 +284,65 @@</span><br><span>     return false;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Resolve t=
he special IPv6 gateway name &quot;net_gateway_ipv6&quot;=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * The IPv6 counterpart of get_special_addr(), whic=
h handles the IPv4 names=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * There is currently only one special IPv6 name=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param rl        route list carrying the system d=
efault gateway in ngi6</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *                  (not rgi6, which is the route towards the VPN server=
), or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
      NULL to merely test whether @p string names a special</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *                  address (used w=
hen validating options, where no route</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *                  list exists yet)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param string    the --route-ipv6 ga=
teway parameter to examine</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param out       receives the resolved gateway; only written when=
 @p rl is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
          given and the system gateway is known</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param status    set to false if @p string n=
ames a special address that</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *                  could not be resolved, so the caller can reject=
 the route;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
            set to true otherwise=2E May be NULL=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return true if @p string is a special address name, in=
 which case the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
       caller must not parse it as a literal address; false otherwise=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ipv6_get_special_addr(const struct route_ipv6_list *r=
l, const char *string, struct in6_addr *out,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                      bool *status)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (status)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        *status =3D true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strcmp(string,=
 &quot;net_gateway_ipv6&quot;) !=3D 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rl)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (rl-&gt;ngi6=2Eflags &amp; RGI_ADDR_D=
EFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* an on-l=
ink gateway is not a next hop, the interface is</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+             * enough -- leave *out unspecified=
 in that case */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (!(rl-&gt;ngi6=2Eflags &amp; RGI_ON_LINK))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                *out =3D rl-&gt;ngi6=2Egateway=
=2Eaddr_ipv6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(M_INFO, PACKAGE_NAME &q=
uot; ROUTE: net_gateway_ipv6 undefined -- unable to get default &quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
             &quot;gateway from system&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (status)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                *status =3D false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> bool</span><br><span> is_special_addr(const char *addr_str)</span><b=
r><span> {</span><br><span>@@ -422,7 +481,7 @@</span><br><span> </span><br>=
<span> static bool</span><br><span> init_route_ipv6(struct route_ipv6 *r6, =
const struct route_ipv6_option *r6o,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                const struct route_ipv6_list *rl6)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                struct route_=
ipv6_list *rl6)</span><br><span> {</span><br><span>     CLEAR(*r6);</span><=
br><span> </span><br><span>@@ -434,7 +493,26 @@</span><br><span>     /* gat=
eway */</span><br><span>     if (is_route_parm_defined(r6o-&gt;gateway))</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (inet_pton(AF_INET6, r6o-&gt;gateway, &amp;r6-&gt;gateway) !=3D 1=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bool statu=
s =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ipv6_get_specia=
l_addr(rl6, r6o-&gt;gateway, &amp;r6-&gt;gateway, &amp;status))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!status)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                goto fail;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            /* the route has to leave vi=
a the interface the system gateway</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+             * is on, otherwise it would be sent down the tu=
nnel */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (rl6-&gt;ngi6=2Eflags &amp; RGI_IFACE_DEFINED)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                r6-&gt;adapter_index =3D rl6-&gt;ngi6=2Ea=
dapter_index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                r6-&=
gt;iface =3D rl6-&gt;ngi6=2Eiface;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else i=
f (inet_pton(AF_INET6, r6o-&gt;gateway, &amp;r6-&gt;gateway) !=3D 1)</span>=
<br><span>         {</span><br><span>             msg(M_WARN, PACKAGE_NAME =
&quot;ROUTE6: cannot parse gateway spec &#39;%s&#39;&quot;, r6o-&gt;gateway=
);</span><br><span>         }</span><br><span>diff --git a/src/openvpn/rout=
e=2Eh b/src/openvpn/route=2Eh</span><br><span>index 0d33d36=2E=2E41ae0dc 10=
0644</span><br><span>--- a/src/openvpn/route=2Eh</span><br><span>+++ b/src/=
openvpn/route=2Eh</span><br><span>@@ -345,6 +345,8 @@</span><br><span> void=
 setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *rl6);=
</span><br><span> </span><br><span> bool is_special_addr(const char *addr_s=
tr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ipv6_get_s=
pecial_addr(const struct route_ipv6_list *rl, const char *string,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                           st=
ruct in6_addr *out, bool *status);</span><br><span> </span><br><span> /**</=
span><br><span>  * @brief Retrieves the best gateway for a given destinatio=
n based on the routing table=2E</span><br><span>diff --git a/tests/unit_tes=
ts/openvpn/test_route=2Ec b/tests/unit_tests/openvpn/test_route=2Ec</span><=
br><span>index 476cfa9=2E=2E7b25aa5 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/test_route=2Ec</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_route=2Ec</span><br><span>@@ -33,6 +33,10 @@</span><br><span> </span=
><br><span> #include &quot;test_route=2Eh&quot;</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* the system default IPv6 ga=
teway, and the route towards the peer */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define NET_GATEWAY6  &quot;2001:db8:1::1&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define PEER_GATEWAY6 &quo=
t;2001:db8:2::1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> /* Stubs for functions route=2Ec references but that no=
 test here reaches=2E</span><br><span>  * They assert rather than return qu=
ietly, so a test straying onto one</span><br><span>  * fails loudly instead=
 of silently doing nothing=2E</span><br><span>@@ -159,11 +163,107 @@</span>=
<br><span>     assert_clear_host_bits(&quot;2001:db8::1&quot;, 0, &quot;::&=
quot;);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Set up a route list where the system default ga=
teway (ngi6) and the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * route towards the peer (rgi6) are different, so a test can tell which</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * one an answer came=
 from=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+init_test_route_ipv6_list(struct ro=
ute_ipv6_list *rl6, unsigned int ngi6_flags)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    CLEAR(*rl6);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(inet_pton(AF_INET6, NET_GATEWAY6, &amp;rl6-&gt;ngi6=2Egateway=2Eaddr_=
ipv6), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rl6-&=
gt;ngi6=2Eflags =3D ngi6_flags;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(inet_pton(AF_INET6, PEER_GATEWAY6, &amp;rl6-&gt;rgi6=2Egatewa=
y=2Eaddr_ipv6), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    rl6-&gt;rgi6=2Eflags =3D RGI_ADDR_DEFINED;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ipv6_get_spec=
ial_addr_resolves(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct route_ipv6_list rl6;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct in6_addr out, expect;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    bool status =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    init_test_route_ipv6_list(&amp;rl6, RGI_ADDR_DEFINED);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(out);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(ipv6_get_special_addr(&amp;rl6, &quo=
t;net_gateway_ipv6&quot;, &amp;out, &amp;status));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(status);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* the system default gateway, not the route towards t=
he peer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(inet_pton(AF_INET6, NET_GATEWAY6, &amp;expect), 1);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(&amp;ou=
t, &amp;expect, sizeof(out));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_ipv6_get_special_addr_not_spec=
ial(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct route_ipv=
6_list rl6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct in6_addr out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 bool status =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_test_r=
oute_ipv6_list(&amp;rl6, RGI_ADDR_DEFINED);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    CLEAR(out);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_false(ipv6_get_special_addr(&amp;rl6, &quot;2001:db8::1&quot;, =
&amp;out, &amp;status));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(IN6_IS_ADDR_UNSPECIFIED(&amp;out));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* the IPv4 names are not IPv6 names */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ipv6_get_special=
_addr(&amp;rl6, &quot;net_gateway&quot;, &amp;out, &amp;status));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* a caller with no route list only learns w=
hether the name is special */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(ipv6_get_special_addr(NULL, &quot;net_gateway_ipv=
6&quot;, NULL, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_false(ipv6_get_special_addr(NULL, &quot;2001:db8::1&quot;, NU=
LL, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_ipv6_get_special_addr_undefined(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct route_ipv6_list rl6;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr out;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool status =3D tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* no IPv6 default gateway on th=
is system */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ini=
t_test_route_ipv6_list(&amp;rl6, 0);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    CLEAR(out);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 still a special name, but one that could not be resolved, so the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * caller must reject the=
 route rather than install it via the tunnel</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(ipv6_get_special_addr(&amp;rl6, &quot;net_gate=
way_ipv6&quot;, &amp;out, &amp;status));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_false(status);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(IN6_IS_ADDR_UNSPECIFIED(&amp;out=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_ipv6_get_special_addr_on_link(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct route_ipv6_list rl6;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr out;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    bool status =3D false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    init_test_route_ipv6_list(&amp;rl6, RGI_A=
DDR_DEFINED | RGI_ON_LINK);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    CLEAR(out);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* an on-li=
nk gateway is not a next hop: the name resolves, but no</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * gateway address is handed back</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ipv6_get_special_=
addr(&amp;rl6, &quot;net_gateway_ipv6&quot;, &amp;out, &amp;status));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(status);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(IN6_=
IS_ADDR_UNSPECIFIED(&amp;out));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> static const struct CMUnitTest route_test_list[] =3D {</span><b=
r><span>     cmocka_unit_test(test_is_special_addr),</span><br><span>     c=
mocka_unit_test(test_netmask_to_netbits),</span><br><span>     cmocka_unit_=
test(test_netmask_to_netbits2),</span><br><span>     cmocka_unit_test(test_=
route_ipv6_clear_host_bits),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    cmocka_unit_test(test_ipv6_get_special_addr_resolves),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_i=
pv6_get_special_addr_not_special),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    cmocka_unit_test(test_ipv6_get_special_addr_undefined),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test=
(test_ipv6_get_special_addr_on_link),</span><br><span> };</span><br><span> =
</span><br><span> int</span><br></pre><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1947?usp=3Demail">change 1947</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1947?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9e45c0edbd2c=
b237f27e349f2f9d7d9b8d826690 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1947 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: chugly &lt;charlie=2Evigue@o=
penvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--F4AQoSExz7M=--


--===============3766552956224041363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3766552956224041363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3766552956224041363==--

