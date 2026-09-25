Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1B6C98318
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wVHIA6OvPKtqXTab4eW+3nLFlMLMXcivCOewA+W8rc4=; b=VPxq90z6LhbLueHAVlCswMD5n5
	HyJuYRsyi4pUv7TtP3nThtkVZIYdXN8f2KW4MzLcfSwmaljeTWaYoERqHb/2CeZU49vCAlZXzGXJg
	6LxKftNXh6C6gC8T++2bHlu2m8L4xuPg7drY3xj/t6jWP15aOGsK2AWbhorT1Pqk2bEk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9vrV-0002Lm-0r;
	Fri, 25 Sep 2026 02:40:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9vrT-0002Lg-Vy
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 02:40:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wApn6n96jH4WeQL12ntnO5PZ9FWMpaFHZqgQKiZ8xpg=; b=YrokvNqrkHFv7RhrossSilkF5Z
 uxx6IRnxejB0v1TcIGwMU7WxxeWih42c+Ct1EWwmHxbWMzPYsS0oVSlnFqJ1+bkCKxDyDhlRR06sj
 mT3RCbi7sqWyG1hL+jVVSdWdkyS6WqoQLH1ieWfx97g16JgSAFpk4IMh1Kuhdxftir9A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wApn6n96jH4WeQL12ntnO5PZ9FWMpaFHZqgQKiZ8xpg=; b=T
 y3ghUuAMPhvgUxsOHObil104y0BXbSbAhI4H43GLJaGshZijCct60GfT1NLi692Qe/3sOgBEpXivZ
 fK9LIuytKXK91NOKF21fX4D0Mek6Xo3U4NZts4oZIr7K4FTmUV+kzs4Qu8Ri7D1GZWNVAz5MSqdgC
 /cZq9f6vOjyKZrt4=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9vrS-0001k4-FU for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 02:40:32 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so2400045e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 19:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790304024; x=1790908824; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wApn6n96jH4WeQL12ntnO5PZ9FWMpaFHZqgQKiZ8xpg=;
 b=FhKRBGv3pOGwm65iTmdo8KAH0hNZ6yBIBq8AKnH4i9LuLjdRlSUmeZuUFMcO//l1hI
 vSMbZcMhIUcrMd+j/lYkAp0oFTV2QzcPWJ9zdiMByd0IDXuAtk8HRXTUQ9vojqc3y4W8
 iWM9APSr7al5PRxieE8OPmMKOQR1/8icEa0zUfLGKFXXZT1h9nR4QU+fLofuvBn8WVms
 YH01L7jd5j1vDWPYXfxv7aBQ4m1/3buvKBht7YV5iksptzFZFHFvO7AvpFCO1luSJrN1
 S4+S+YdwFWAOvuOrClMab9F6NotXvKmtZ/Ik7zUvr8HskuHqM4Lpt4StMu5W2GinJ5Xa
 9d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790304024; x=1790908824;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wApn6n96jH4WeQL12ntnO5PZ9FWMpaFHZqgQKiZ8xpg=;
 b=kUUsHv9tBPDUJyZD5ufKCfpHUxUkpClZeaEA5yOVpzLmoQigjK8XZWeIdmZkuDho1k
 qtkqGCQ+927+O4q+lj/7R0d62YbBuTf6wUo1fLNQMhOjpk922VpIO2zNSLfzBz19LrKk
 esaTMBR8zuItVojeuIJ15yYQzjBWJvOVSdhqfw6iydwazYYyLgIOMIiR+l/OHsTUhSGY
 X/kn5xQu0pyBhAGKsB/unD9XfDst4wb7+QkW/nIOTAl7vo/DZUQWLheXjToYlN/UaW4f
 1AnHhvXRsvEKNCJnk7ukw4FVB6FVIUfbad9eo+8BbcmepA3p0M7q/HisFGUsKEDxaz0d
 Wssw==
X-Gm-Message-State: AFuF++me6vPrRIGIAmsC69nq19YAqNPLhbGJq8XanXbZe7XVYsHN+7ZR
 UOICzxD14Mdu2k51MNxOfXR4VkTFHriZZqKXXSEaoCaNOnDdeAIAbWuuT0H2LLziAo/YQhYtFAs
 4nEv0trd8Oka81Ox53AWiSPNVnwP0UDfh0lV7Z2PdZr2fiqEtq9+8e3GNITLzQB6fVsfusJ3onr
 ZJBnNltA==
X-Gm-Gg: AYBFou2eo+iAvU1F69pFVk8fgmaXUVscIdJbAydDZ6kiaFbODUiHjc1j/R+qPm8Y4az
 T+eAZYH0+OMfnDGAD27n7pToI9N7hBufLh4bLykUwTr6tz3lqSAdq6hgfRrYUEDTJxhZ2/TLQG/
 Hdkp4NZcoozmDULpTRhY4jOm9MzpI3LjxKm2NNGMiFae6DWi01tjLdwoXcTsAlx3/bO1g686ggQ
 1BYVigKGxPxBUH5MJ70btMMwU763IOgNSUlh+ofjGffPlfrTB+Q958mRzpU80fBhk3FqIaZvIwy
 IoJH/8YyWuX+VKTxSSmQSM0fVV5OLf8/3MyuEJyQv73CPIcY6+BKjk+OLMMtxZW980AJNYh7Ar6
 hUw1EYzLYoQJuITcztpm4my8UhvRTm5Utlp92Ga8JSEIXJfLLItZxksc7zMDnUEfydYm5anOlzu
 /FIzRYDPeejsT5A6LsdDUqL6BDpLmXzLUydhgG2Dn+2CDzhgReca0/KYBDThqdTaG0Oo2hZFPom
 LdY6T8VNQug3m+6W3oBtQ+Ua96d2UHUv3Y2W8R1s7FQlTKmADie4kqdAYH9dsZ3KHIh3Aod52Un
 N6pnplEbZgJPqeGCe1oGgolTJy871/F0ORmn5t3Q2ZypBqr6hTFaK8FKV1Lw
X-Received: by 2002:a05:600d:8498:20b0:49f:eb08:2989 with SMTP id
 5b1f17b1804b1-49feb08298fmr39064555e9.35.1790304023804; 
 Thu, 24 Sep 2026 19:40:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fedec53c4sm42479725e9.4.2026.09.24.19.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 19:40:23 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 02:40:20 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690
X-Gerrit-Change-Number: 1947
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1947?usp=email>
X-Gerrit-Commit: e2f21c35ece9c04cec0d9a6651696768eb0616db
In-Reply-To: <gerrit.1790212215000.I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5ZTQ1YzBlZGJkMmNiMjM3ZjI3ZTM0OWYyZjlkN2Q5YjhkODI2NjkwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <428865f5fd376ac7ca91ff4bfb62b6987c7ef71c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9vrS-0001k4-FU
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
Content-Type: multipart/mixed; boundary="===============7974229668530109984=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7974229668530109984==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ItTf453jZQo="; charset=UTF-8

--ItTf453jZQo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1947?usp=3Demail

to look at the new patch set (#2)=2E

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
/1947/2

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
index db039c1=2E=2Ebfcccb8 100644
--- a/tests=
/unit_tests/openvpn/test_route=2Ec
+++ b/tests/unit_tests/openvpn/test_rout=
e=2Ec
@@ -31,6 +31,10 @@
 #include "route=2Eh"
 #include "networking=2Eh"
 =

+/* the system default IPv6 gateway, and the route towards the peer */
+#d=
efine NET_GATEWAY6  "2001:db8:1::1"
+#define PEER_GATEWAY6 "2001:db8:2::1"
=
+
 /* Stubs for functions route=2Ec references but that no test here reache=
s=2E
  * They assert rather than return quietly, so a test straying onto on=
e
  * fails loudly instead of silently doing nothing=2E
@@ -210,11 +214,107=
 @@
     assert_clear_host_bits("2001:db8::1", 0, "::");
 }
 
+/* Set up a =
route list where the system default gateway (ngi6) and the
+ * route toward=
s the peer (rgi6) are different, so a test can tell which
+ * one an answer=
 came from=2E
+ */
+static void
+init_test_route_ipv6_list(struct route_ipv=
6_list *rl6, unsigned int ngi6_flags)
+{
+    CLEAR(*rl6);
+
+    assert_in=
t_equal(inet_pton(AF_INET6, NET_GATEWAY6, &rl6->ngi6=2Egateway=2Eaddr_ipv6)=
, 1);
+    rl6->ngi6=2Eflags =3D ngi6_flags;
+
+    assert_int_equal(inet_p=
ton(AF_INET6, PEER_GATEWAY6, &rl6->rgi6=2Egateway=2Eaddr_ipv6), 1);
+    rl=
6->rgi6=2Eflags =3D RGI_ADDR_DEFINED;
+}
+
+static void
+test_ipv6_get_spec=
ial_addr_resolves(void **state)
+{
+    struct route_ipv6_list rl6;
+    st=
ruct in6_addr out, expect;
+    bool status =3D false;
+
+    init_test_rou=
te_ipv6_list(&rl6, RGI_ADDR_DEFINED);
+    CLEAR(out);
+
+    assert_true(i=
pv6_get_special_addr(&rl6, "net_gateway_ipv6", &out, &status));
+    assert=
_true(status);
+
+    /* the system default gateway, not the route towards =
the peer */
+    assert_int_equal(inet_pton(AF_INET6, NET_GATEWAY6, &expect=
), 1);
+    assert_memory_equal(&out, &expect, sizeof(out));
+}
+
+static v=
oid
+test_ipv6_get_special_addr_not_special(void **state)
+{
+    struct ro=
ute_ipv6_list rl6;
+    struct in6_addr out;
+    bool status =3D false;
+
=
+    init_test_route_ipv6_list(&rl6, RGI_ADDR_DEFINED);
+    CLEAR(out);
+
=
+    assert_false(ipv6_get_special_addr(&rl6, "2001:db8::1", &out, &status)=
);
+    assert_true(IN6_IS_ADDR_UNSPECIFIED(&out));
+
+    /* the IPv4 name=
s are not IPv6 names */
+    assert_false(ipv6_get_special_addr(&rl6, "net_=
gateway", &out, &status));
+
+    /* a caller with no route list only learn=
s whether the name is special */
+    assert_true(ipv6_get_special_addr(NUL=
L, "net_gateway_ipv6", NULL, NULL));
+    assert_false(ipv6_get_special_add=
r(NULL, "2001:db8::1", NULL, NULL));
+}
+
+static void
+test_ipv6_get_speci=
al_addr_undefined(void **state)
+{
+    struct route_ipv6_list rl6;
+    st=
ruct in6_addr out;
+    bool status =3D true;
+
+    /* no IPv6 default gat=
eway on this system */
+    init_test_route_ipv6_list(&rl6, 0);
+    CLEAR(=
out);
+
+    /* still a special name, but one that could not be resolved, s=
o the
+     * caller must reject the route rather than install it via the t=
unnel
+     */
+    assert_true(ipv6_get_special_addr(&rl6, "net_gateway_ip=
v6", &out, &status));
+    assert_false(status);
+    assert_true(IN6_IS_AD=
DR_UNSPECIFIED(&out));
+}
+
+static void
+test_ipv6_get_special_addr_on_lin=
k(void **state)
+{
+    struct route_ipv6_list rl6;
+    struct in6_addr ou=
t;
+    bool status =3D false;
+
+    init_test_route_ipv6_list(&rl6, RGI_A=
DDR_DEFINED | RGI_ON_LINK);
+    CLEAR(out);
+
+    /* an on-link gateway i=
s not a next hop: the name resolves, but no
+     * gateway address is hand=
ed back
+     */
+    assert_true(ipv6_get_special_addr(&rl6, "net_gateway_=
ipv6", &out, &status));
+    assert_true(status);
+    assert_true(IN6_IS_A=
DDR_UNSPECIFIED(&out));
+}
+
 const struct CMUnitTest route_tests[] =3D {
 =
    cmocka_unit_test(test_is_special_addr),
     cmocka_unit_test(test_netm=
ask_to_netbits),
     cmocka_unit_test(test_netmask_to_netbits2),
     cmoc=
ka_unit_test(test_route_ipv6_clear_host_bits),
+    cmocka_unit_test(test_i=
pv6_get_special_addr_resolves),
+    cmocka_unit_test(test_ipv6_get_special=
_addr_not_special),
+    cmocka_unit_test(test_ipv6_get_special_addr_undefi=
ned),
+    cmocka_unit_test(test_ipv6_get_special_addr_on_link),
 };
 
 int=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1947?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9e45c0edbd2cb2=
37f27e349f2f9d7d9b8d826690
Gerrit-Change-Number: 1947
Gerrit-PatchSet: 2
Ge=
rrit-Owner: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--ItTf453jZQo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>chugly <strong>uploaded patch se=
t #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/1947/2</pre><pre style=
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
br><span>index db039c1=2E=2Ebfcccb8 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/test_route=2Ec</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_route=2Ec</span><br><span>@@ -31,6 +31,10 @@</span><br><span> #inclu=
de &quot;route=2Eh&quot;</span><br><span> #include &quot;networking=2Eh&quo=
t;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* the system default IPv6 gateway, and the route towards the peer */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define NET_GATEWAY6  &q=
uot;2001:db8:1::1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define PEER_GATEWAY6 &quot;2001:db8:2::1&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Stubs for functions =
route=2Ec references but that no test here reaches=2E</span><br><span>  * T=
hey assert rather than return quietly, so a test straying onto one</span><b=
r><span>  * fails loudly instead of silently doing nothing=2E</span><br><sp=
an>@@ -210,11 +214,107 @@</span><br><span>     assert_clear_host_bits(&quot=
;2001:db8::1&quot;, 0, &quot;::&quot;);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Set up a route =
list where the system default gateway (ngi6) and the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * route towards the peer (rgi6) are diff=
erent, so a test can tell which</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * one an answer came from=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
it_test_route_ipv6_list(struct route_ipv6_list *rl6, unsigned int ngi6_flag=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*rl6);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, NET_GATEWAY6, &a=
mp;rl6-&gt;ngi6=2Egateway=2Eaddr_ipv6), 1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    rl6-&gt;ngi6=2Eflags =3D ngi6_flags;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, PEER_GAT=
EWAY6, &amp;rl6-&gt;rgi6=2Egateway=2Eaddr_ipv6), 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    rl6-&gt;rgi6=2Eflags =3D RGI_ADDR_DEF=
INED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_ipv6_get_special_addr_resolves(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct route_ipv6_list rl6;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr out, expect;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool status =3D fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    init_test_route_ipv6_list(&amp=
;rl6, RGI_ADDR_DEFINED);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    CLEAR(out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ip=
v6_get_special_addr(&amp;rl6, &quot;net_gateway_ipv6&quot;, &amp;out, &amp;=
status));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the system defaul=
t gateway, not the route towards the peer */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, NET_GATEW=
AY6, &amp;expect), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_memory_equal(&amp;out, &amp;expect, sizeof(out));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_ipv6_get_special_addr_not_special(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct route_ipv6_list rl6;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct in6_addr out;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool status =3D false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    init_test_route_ipv6_list(&amp;rl6, RGI_ADDR_DEFI=
NED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(out)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_false(ipv6_get_special_add=
r(&amp;rl6, &quot;2001:db8::1&quot;, &amp;out, &amp;status));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(IN6_IS_ADDR_UNSPE=
CIFIED(&amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the IPv4 name=
s are not IPv6 names */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_false(ipv6_get_special_addr(&amp;rl6, &quot;net_gateway&quot=
;, &amp;out, &amp;status));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a ca=
ller with no route list only learns whether the name is special */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ipv6_get_spe=
cial_addr(NULL, &quot;net_gateway_ipv6&quot;, NULL, NULL));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ipv6_get_special_a=
ddr(NULL, &quot;2001:db8::1&quot;, NULL, NULL));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ipv6_get_sp=
ecial_addr_undefined(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct route_ipv6_list rl6;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct in6_addr out;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    bool status =3D true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* no IPv6 default gateway on this system */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    init_test_route_ipv6_list(&amp;rl6, 0);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(out);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* still a special name, but one that co=
uld not be resolved, so the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * caller must reject the route rather than install it via the =
tunnel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ipv6_get_=
special_addr(&amp;rl6, &quot;net_gateway_ipv6&quot;, &amp;out, &amp;status)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(=
status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(IN6_IS_ADDR_UNSPECIFIED(&amp;out));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ipv6_get_special_ad=
dr_on_link(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ro=
ute_ipv6_list rl6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct in6_addr out;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool status =3D false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init=
_test_route_ipv6_list(&amp;rl6, RGI_ADDR_DEFINED | RGI_ON_LINK);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(out);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* an on-link gateway is not a next hop: the name=
 resolves, but no</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * gateway address is handed back</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(ipv6_get_special_addr(&amp;rl6, &quot;net_gateway_ipv6&=
quot;, &amp;out, &amp;status));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(status);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(IN6_IS_ADDR_UNSPECIFIED(&amp;out));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> const struct CMUnitTest ro=
ute_tests[] =3D {</span><br><span>     cmocka_unit_test(test_is_special_add=
r),</span><br><span>     cmocka_unit_test(test_netmask_to_netbits),</span><=
br><span>     cmocka_unit_test(test_netmask_to_netbits2),</span><br><span> =
    cmocka_unit_test(test_route_ipv6_clear_host_bits),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_ipv6_get_speci=
al_addr_resolves),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   cmocka_unit_test(test_ipv6_get_special_addr_not_special),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_ipv6_get=
_special_addr_undefined),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    cmocka_unit_test(test_ipv6_get_special_addr_on_link),</span><br><=
span> };</span><br><span> </span><br><span> int</span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1947?usp=3Demai=
l">change 1947</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
47?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1947 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ch=
ugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ItTf453jZQo=--


--===============7974229668530109984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7974229668530109984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7974229668530109984==--

