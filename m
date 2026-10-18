Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A60CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iSZHtLGxz3hgsJePrv3bls+8ARL2xrO6d10ZzKVVwro=; b=c/D1u1BAk/7tz8D9oIr69zad+8
	lE/XdD5CXMiLQb+2CP6U0oFJhdlOEsJFbv3YBRRWGY/ckCQdKDd0ppN7kVAehEFOrzwfOPrAxnL1f
	A76vFT1T1emJziLN93C5FKnaZ0fq7P0jcfdErLU+eIAvFGF+5mYCUI21UeO2O7SXgOtc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIRmb-00023y-0f;
	Sun, 18 Oct 2026 14:22:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIRmN-00023e-61
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:22:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4PADfbHkH3DM/fwJGRTyblC8Hlx4HD1eUcqjAzNJDkI=; b=HK+nhZPrLl3SqTIJ5YC8iHwNn0
 kxXrvmkhuq9JXXlAP/Yr1h0CtIuelHVDU2rMBI5ptB9pnbsT40RLxcDzx6azeHTHrR5K41KP/aU+2
 g8EbCz2EYtUdLZgejRLIri/3ZLLJvF9vIgISHF8w78dMRTo9Z/yyzq61wp6tLz3OkdZQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4PADfbHkH3DM/fwJGRTyblC8Hlx4HD1eUcqjAzNJDkI=; b=E
 FAjc/RRSyRv895K/w0LH+wQrd7Udj4ItunWNcB3Nh/5vk7xJuR2uUOfw4KpkjD6c2lGrKhAa2AjRH
 nDQ8wSsSD56K/ha/P9MMu1QacQRT5yr3axnnqpOy2jtMNvleubhO2KtTfzspkLeGB1VXYv4WibJp2
 eFfyPYUwXPO8uIiw=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIRmB-00089X-EY for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:22:18 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso11402955e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792333329; x=1792938129; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4PADfbHkH3DM/fwJGRTyblC8Hlx4HD1eUcqjAzNJDkI=;
 b=Zacl0QBLZor9xsLFWefXc0NwWCXkbIhewoxtcAVBRge3k30lHwkXgakX7AoWXw9eXk
 x5yq72BgXyur9iAgaEi5c2KymptjX/ShAWp/dxOvrfo1DSKs9en9t4LklTM8MxH2bPhP
 Sch37+C8b+C6EVwsH+5njky8oTY/aKbtFPku/llL7uLsDKP9L/Q42Op2sOl7lQiYk0fz
 0gST/+eYEFZbXRRZ6+SQnmcXjcS9ZSIY1lm2yRl+QvRTmCY3UIv9/zyJgcpXetBKa46d
 RnpDEuKGp1cZDR0ONQadXkBzKlACYkhKrPE6HnsaYGPxO5f7tgHgGOIrVR1TSLohnt0K
 zGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792333329; x=1792938129;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4PADfbHkH3DM/fwJGRTyblC8Hlx4HD1eUcqjAzNJDkI=;
 b=A7Wdj9l4Ob21ouoGJM/Ia02ARcu5aOWWdobCxkCohuUzYiRb/+LZEc5dwkV1kcL/uZ
 XkTc126eIGQ1dNLs8AZZBq2R+D1XEIOqeaHU5ep/QH3l4DzjCxX7uc0kZWRXuIzK544o
 eGRhosNwHLz9U2ri7f4OOLbm+nSaORM+hqURi/e2SAOVPuv5J5TwPF27NJzgb2pkAW5n
 EpJrq9tMLFAtk1ADQLkN8Mci6j2EXQRoj7kNFw4ywxR4LkHkekdcIiEYW5AWdPh7P4wP
 vHbBFzrzwAiwUtkT2HctqU4Gkf9hoL744B5xg3SYYPHwc/pyo+O5GOBC4gzeg6/K7WLb
 39kg==
X-Gm-Message-State: AFq9FYIngk0OdyU5qetAaRCTIvRSSLpK4cSWCznrtRRLHDLD6Rt6gUp/
 Hb58VFb0wPpgBBojygrFBQ8GIbPdQcX37R+GAOdA122LWGAh77VU/zsUfbsZegf82vdKCvUwZYG
 OGe9F8mhY4V9S2SN310VPZXVzefSuAmoTdrMdK5oxHtDJT2umYMFZSSxy0kIzXjDSxihrO+cIOF
 tgwv1uXw==
X-Gm-Gg: AYBFou3WovX2FGEcvcUCIIsaq/IIFoAfevpUaIgMQlob9tXDcnynEHbfUyDNezRLM2u
 c6/FkNhKKjD71W1L50057EMsaLVZaNisZ1olwY5urKV3JXK2NKfGuT3pCwS0ocJfqL25yXFwg95
 TRWuDQoiSdDN8GHnsvHyN/nQza0TOSrUt2BDVysW7JXCTaAOibFQPQaX3+JgMOhDk2BGzeBgKoq
 nY4M4cEWLPsvQfIyfHmuPvO5gr7k4WkHRhj9zVeG7a3g5n3FokoL46OzLdJKLBNKfHkNbFzjH+s
 9F6OpgYaVPMSLFBx7W68yzFK+QgMgBT4dsJpOfGD9383CqJ6mdDCkcclH1bstc8ARQP901Hoqra
 iEUMftcwMW4K4K7av66N+15tIEeyuqVCtFAXayl8aTX1PvIRIclkrFpw8UfzbK8JIvn+CglQbzp
 t3U6idO1pm7avuZjg97Hp8Z16LYkkdbep3g+NTOx5A7w8L9shVDs9dUvvI0x09A80mY5kVy8OAB
 iJIBl02gtaYfB2gtzBkAmBLv+5TzojzOnFINFaK4PiSNa+/KAggZeQJygJYZJ+GRK0m4lrCNv53
 CzCV3fOMiXJuJ11nOPHVnVhUqP0FlB9vweoRJa2m/MnEpV9V7kwX9zEjQgCv
X-Received: by 2002:a05:600c:638f:b0:4a1:e672:5721 with SMTP id
 5b1f17b1804b1-4a1e67257demr14734245e9.13.1792333328595; 
 Sun, 18 Oct 2026 07:22:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd50d080sm17361577f8f.53.2026.10.18.07.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 07:22:08 -0700 (PDT)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 14:22:03 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I0f7237720b0892f5ba0caf60f941f9cc2241cdb6
X-Gerrit-Change-Number: 1541
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1541?usp=email>
X-Gerrit-Commit: b7ac8c301e00af2026455149ca68403f411c48ea
In-Reply-To: <gerrit.1771373435000.I0f7237720b0892f5ba0caf60f941f9cc2241cdb6@gerrit.openvpn.net>
References: <gerrit.1771373435000.I0f7237720b0892f5ba0caf60f941f9cc2241cdb6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcxMzczNDM1MDAwLkkwZjcyMzc3MjBiMDg5MmY1YmEwY2FmNjBmOTQxZjljYzIyNDFjZGI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <27300d7f12e1665f6e65a46d956181f2a88c5cee-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIRmB-00089X-EY
Subject: [Openvpn-devel] [M] Change in openvpn[master]: wfp: add flag to
 allow DNS traffic to loopback
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
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8328334964345977315=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8328334964345977315==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DZgFdo2TYVU="; charset=UTF-8

--DZgFdo2TYVU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, Frank Lichtenheld, 

I'd like you to reexamine a change=
=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1541?usp=
=3Demail

to look at the new patch set (#6)=2E


Change subject: wfp: add f=
lag to allow DNS traffic to loopback
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

wfp: add flag to allow DNS traffic to loopback

A=
dd a flag 'allow-loopback' to the --block-outside-dns options=2E When it
is=
 set DNS traffic to loopback (localhost) will not be blocked=2E This
flag w=
ill also allow DNS to localhost when all local traffic is to be
blocked via=
 '--redirect-gateway block-local'=2E

Fixes #703

Change-Id: I0f7237720b089=
2f5ba0caf60f941f9cc2241cdb6
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentli=
ch=2Enet>
---
M doc/man-sections/windows-options=2Erst
M include/openvpn-ms=
g=2Eh
M src/openvpn/init=2Ec
M src/openvpn/options=2Ec
M src/openvpn/option=
s=2Eh
M src/openvpn/wfp_block=2Ec
M src/openvpn/wfp_block=2Eh
M src/openvpn=
/win32=2Ec
M src/openvpn/win32=2Eh
M src/openvpnserv/interactive=2Ec
10 fil=
es changed, 121 insertions(+), 59 deletions(-)


  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/41/1541/6

diff --git a/doc/man-se=
ctions/windows-options=2Erst b/doc/man-sections/windows-options=2Erst
index=
 8d7dcbb=2E=2Eff2e9d7 100644
--- a/doc/man-sections/windows-options=2Erst
+=
++ b/doc/man-sections/windows-options=2Erst
@@ -16,11 +16,12 @@
   after a =
reboot, or if the driver is unloaded and reloaded=2E This
   directive can =
only be used by an administrator=2E
 
---block-outside-dns
+--block-outside=
-dns [allow-loopback]
   Block DNS servers on other network adapters to pre=
vent DNS leaks=2E This
   option prevents any application from accessing TC=
P or UDP port 53 except
   one inside the tunnel=2E It uses Windows Filteri=
ng Platform (WFP) and
-  works on Windows Vista or later=2E
+  works on Win=
dows Vista or later=2E If ``allow-loopback`` is set, traffic to
+  localhos=
t port 53 is still allowed=2E
 
 --cryptoapicert select-string
   *(Windows=
/OpenSSL Only)* Load the certificate and private key from the
diff --git a/=
include/openvpn-msg=2Eh b/include/openvpn-msg=2Eh
index ca3267e8=2E=2E118d3=
dd 100644
--- a/include/openvpn-msg=2Eh
+++ b/include/openvpn-msg=2Eh
@@ -7=
3,9 +73,13 @@
 
 typedef enum
 {
-    wfp_block_local =3D 1 << 0,
-    wfp_=
block_dns =3D 1 << 1
-} wfp_block_flags_t;
+    wfp_block_all,
+    wfp_blo=
ck_all_except_local_dns,
+    wfp_block_dns,
+    wfp_block_dns_except_loca=
l,
+    wfp_block_type_count,
+    wfp_block_none =3D -1
+} wfp_block_t;
 
=
 typedef struct
 {
@@ -163,7 +167,7 @@
 typedef struct
 {
     message_head=
er_t header;
-    wfp_block_flags_t flags;
+    wfp_block_t block_type;
   =
  interface_t iface;
 } wfp_block_message_t;
 
diff --git a/src/openvpn/ini=
t=2Ec b/src/openvpn/init=2Ec
index 3c2ebf9=2E=2Ea04ab2a 100644
--- a/src/op=
envpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -1757,12 +1757,14 @@
 {
 #if d=
efined(_WIN32)
     /* Fortify 'redirect-gateway block-local' with firewall=
 rules? */
-    bool block_local =3D block_local_needed(c->c1=2Eroute_list)=
;
+    const bool block_local =3D block_local_needed(c->c1=2Eroute_list);
+=
    const bool block_outside_dns =3D c->options=2Eblock_outside_dns;
+    c=
onst bool allow_loopback_dns =3D c->options=2Eallow_loopback_dns;
+    cons=
t wfp_block_t block_type =3D get_wfp_block_type(block_local, block_outside_=
dns, allow_loopback_dns);
 
-    if (c->options=2Eblock_outside_dns || bloc=
k_local)
+    if (block_type !=3D wfp_block_none)
     {
-        BOOL dns_=
only =3D !block_local;
-        if (!win_wfp_block(c->c1=2Etuntap->adapter_=
index, c->options=2Emsg_channel, dns_only))
+        if (!win_wfp_block(c->=
c1=2Etuntap->adapter_index, c->options=2Emsg_channel, block_type))
        =
 {
             msg(M_FATAL, "WFP: initialization failed");
         }
@@ -=
1782,7 +1784,11 @@
 del_wfp_block(const struct context *c, unsigned long ad=
apter_index)
 {
 #if defined(_WIN32)
-    if (c->options=2Eblock_outside_dn=
s || block_local_needed(c->c1=2Eroute_list))
+    const bool block_local =
=3D block_local_needed(c->c1=2Eroute_list);
+    const bool block_outside_d=
ns =3D c->options=2Eblock_outside_dns;
+    const wfp_block_t block_type =
=3D get_wfp_block_type(block_local, block_outside_dns, false);
+
+    if (b=
lock_type !=3D wfp_block_none)
     {
         if (!win_wfp_uninit(adapter_=
index, c->options=2Emsg_channel))
         {
diff --git a/src/openvpn/optio=
ns=2Ec b/src/openvpn/options=2Ec
index e7585ad=2E=2E743d917 100644
--- a/sr=
c/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -859,6 +859,7 @@
   =
  o->tuntap_options=2Edhcp_masq_offset =3D 0;
     o->route_method =3D ROUT=
E_METHOD_ADAPTIVE;
     o->block_outside_dns =3D false;
+    o->allow_loopb=
ack_dns =3D false;
     o->windows_driver =3D WINDOWS_DRIVER_UNSPECIFIED;
 =
#endif
     o->vlan_accept =3D VLAN_ALL;
@@ -3808,6 +3809,7 @@
     {
     =
    VERIFY_PERMISSION(OPT_P_DHCPDNS);
         options->block_outside_dns =
=3D false;
+        options->allow_loopback_dns =3D false;
     }
 #else /*=
 ifdef _WIN32 */
     else if (streq(p[0], "dhcp-option") && !p[1])
@@ -673=
9,10 +6741,14 @@
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
         option=
s->tuntap_options=2Eregister_dns =3D true;
     }
-    else if (streq(p[0],=
 "block-outside-dns") && !p[1])
+    else if (streq(p[0], "block-outside-dn=
s") && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
         op=
tions->block_outside_dns =3D true;
+        if (p[1] && streq(p[1], "allow-=
loopback"))
+        {
+            options->allow_loopback_dns =3D true;
+=
        }
     }
     else if (streq(p[0], "rdns-internal") && !p[1])
     =
/* standalone method for internal use
diff --git a/src/openvpn/options=2Eh =
b/src/openvpn/options=2Eh
index d347830=2E=2E06237ef 100644
--- a/src/openv=
pn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -695,6 +695,7 @@
     bool =
show_net_up;
     int route_method;
     bool block_outside_dns;
+    bool =
allow_loopback_dns;
     enum tun_driver_type windows_driver;
 #endif
 
dif=
f --git a/src/openvpn/wfp_block=2Ec b/src/openvpn/wfp_block=2Ec
index 4d38f=
db=2E=2E99802f2 100644
--- a/src/openvpn/wfp_block=2Ec
+++ b/src/openvpn/wf=
p_block=2Ec
@@ -131,27 +131,14 @@
     return err;
 }
 
-/*
- * Block outgo=
ing local traffic, possibly DNS only, except for
- * (i) adapter with the s=
pecified index (and loopback, if all is blocked)
- * OR
- * (ii) processes =
with the specified executable path
- * The firewall filters added here are =
automatically removed when the process exits or
- * on calling delete_wfp_b=
lock_filters()=2E
- * Arguments:
- *   engine_handle : On successful return=
 contains the handle for a newly opened fwp session
- *                   i=
n which the filters are added=2E
- *                   May be closed by pas=
sing to delete_wfp_block_filters to remove the filters=2E
- *   index      =
   : The index of adapter for which traffic is permitted=2E
- *   exe_path =
     : Path of executable for which traffic is permitted=2E
- *   msg_handl=
er   : An optional callback function for error reporting=2E
- *   dns_only =
     : Whether the blocking filters should apply for DNS only=2E
- * Return=
s 0 on success, a non-zero status code of the last failed action on failure=
=2E
- */
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnost=
ic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
 
 DWORD
 =
add_wfp_block_filters(HANDLE *engine_handle, int index, const WCHAR *exe_pa=
th,
-                      wfp_block_msg_handler_t msg_handler, BOOL dns_on=
ly)
+                      wfp_block_msg_handler_t msg_handler, const wfp_b=
lock_t block_type)
 {
     FWPM_SESSION0 session =3D { 0 };
     FWPM_SUBLA=
YER0 *sublayer_ptr =3D NULL;
@@ -247,7 +234,7 @@
     Filter=2ElayerKey =3D=
 FWPM_LAYER_ALE_AUTH_CONNECT_V4;
     Filter=2Eaction=2Etype =3D FWP_ACTION=
_PERMIT;
     Condition[0] =3D match_openvpn;
-    if (dns_only)
+    if (b=
lock_type =3D=3D wfp_block_dns || block_type =3D=3D wfp_block_dns_except_lo=
cal)
     {
         Filter=2EnumFilterConditions =3D 2;
         Condition=
[1] =3D match_port_53;
@@ -268,7 +255,7 @@
     Filter=2Eweight=2Etype =3D =
FWP_EMPTY;
     Filter=2EnumFilterConditions =3D 1;
     Condition[0] =3D m=
atch_not_loopback;
-    if (dns_only)
+    if (block_type =3D=3D wfp_block_=
dns || block_type =3D=3D wfp_block_dns_except_local)
     {
         Filter=
=2EnumFilterConditions =3D 2;
         Condition[1] =3D match_port_53;
@@ -=
292,7 +279,7 @@
     Filter=2Eaction=2Etype =3D FWP_ACTION_PERMIT;
     Fil=
ter=2EnumFilterConditions =3D 1;
     Condition[0] =3D match_interface;
-  =
  if (dns_only)
+    if (block_type =3D=3D wfp_block_dns || block_type =3D=
=3D wfp_block_dns_except_local)
     {
         Filter=2EnumFilterCondition=
s =3D 2;
         Condition[1] =3D match_port_53;
@@ -308,20 +295,23 @@
 
 =
    msg_handler(0, "WFP Block: Added permit filters for VPN interface");
 
=
-    /* Seventh Filter=2E Block IPv4 DNS requests to loopback from other ap=
ps */
-    Filter=2ElayerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;
-    Filte=
r=2Eaction=2Etype =3D FWP_ACTION_BLOCK;
-    Filter=2Eweight=2Etype =3D FWP=
_EMPTY;
-    Filter=2EnumFilterConditions =3D 2;
-    Condition[0] =3D matc=
h_loopback;
-    Condition[1] =3D match_port_53;
-    err =3D FwpmFilterAdd=
0(*engine_handle, &Filter, NULL, &filterid);
-    OUT_ON_ERROR(err, "Add fi=
lter to block IPv4 DNS traffic to loopback failed");
+    if (block_type !=
=3D wfp_block_all_except_local_dns && block_type !=3D wfp_block_dns_except_=
local)
+    {
+        /* Seventh Filter=2E Block IPv4 DNS requests to loop=
back from other apps */
+        Filter=2ElayerKey =3D FWPM_LAYER_ALE_AUTH_=
CONNECT_V4;
+        Filter=2Eaction=2Etype =3D FWP_ACTION_BLOCK;
+        =
Filter=2Eweight=2Etype =3D FWP_EMPTY;
+        Filter=2EnumFilterConditions=
 =3D 2;
+        Condition[0] =3D match_loopback;
+        Condition[1] =3D=
 match_port_53;
+        err =3D FwpmFilterAdd0(*engine_handle, &Filter, NU=
LL, &filterid);
+        OUT_ON_ERROR(err, "Add filter to block IPv4 DNS tr=
affic to loopback failed");
 
-    /* Eighth Filter=2E Block IPv6 DNS reque=
sts to loopback from other apps */
-    Filter=2ElayerKey =3D FWPM_LAYER_AL=
E_AUTH_CONNECT_V6;
-    err =3D FwpmFilterAdd0(*engine_handle, &Filter, NUL=
L, &filterid);
-    OUT_ON_ERROR(err, "Add filter to block IPv6 DNS traffic=
 to loopback failed");
+        /* Eighth Filter=2E Block IPv6 DNS requests=
 to loopback from other apps */
+        Filter=2ElayerKey =3D FWPM_LAYER_A=
LE_AUTH_CONNECT_V6;
+        err =3D FwpmFilterAdd0(*engine_handle, &Filter=
, NULL, &filterid);
+        OUT_ON_ERROR(err, "Add filter to block IPv6 DN=
S traffic to loopback failed");
+    }
 
     msg_handler(0, "WFP Block: Ad=
ded block filters for DNS traffic to loopback");
 
diff --git a/src/openvpn=
/wfp_block=2Eh b/src/openvpn/wfp_block=2Eh
index 8bc093a=2E=2E8cb5fa5 10064=
4
--- a/src/openvpn/wfp_block=2Eh
+++ b/src/openvpn/wfp_block=2Eh
@@ -28,19=
 +28,47 @@
 #include <windef=2Eh>
 #include <iphlpapi=2Eh>
 #include <ws2tc=
pip=2Eh>
+#include <stdbool=2Eh>
+
+#include "openvpn-msg=2Eh"
 
 /* Any va=
lue less than 5 should work fine=2E 3 is chosen without any real reason=2E =
*/
 #define WFP_BLOCK_IFACE_METRIC 3
 
 typedef void (*wfp_block_msg_handle=
r_t)(DWORD err, const char *msg);
 
+/**
+ * Block outgoing local traffic, =
possibly DNS only, except for
+ * (i) adapter with the specified index (and=
 loopback, if all is blocked)
+ * OR
+ * (ii) processes with the specified =
executable path
+ * The firewall filters added here are automatically remov=
ed when the process exits or
+ * on calling \ref delete_wfp_block_filters()=
=2E
+ *
+ * @param engine_handle On successful return contains the handle f=
or a newly opened fwp
+ *                      session in which the filters=
 are added=2E May be closed by passing
+ *                      to \ref del=
ete_wfp_block_filters() to remove the filters=2E
+ * @param index         T=
he index of adapter for which traffic is permitted=2E
+ * @param exe_path  =
    Path of executable for which traffic is permitted=2E
+ * @param msg_han=
dler   An optional callback function for error reporting=2E
+ * @param bloc=
k_type    Whether the blocking filters should apply for DNS only=2E
+ *
+ *=
 @return ERROR_SUCCESS, or a non-zero status code of the last failed action=
 on failure=2E
+ */
+DWORD
+add_wfp_block_filters(HANDLE *engine_handle, in=
t index, const WCHAR *exe_path,
+                      wfp_block_msg_handle=
r_t msg_handler, const wfp_block_t block_type);
+
+/**
+ * Remove the firew=
all filter rules set with \ref add_wfp_block_filters()
+ *
+ * @param engin=
e        The WFP session handle in which the firewall rules were added=2E
+=
 *
+ * @return ERROR_SUCCESS, or a non-zero status code of the last failed =
action on failure=2E
+ */
 DWORD
 delete_wfp_block_filters(HANDLE engine);
=
 
-DWORD
-add_wfp_block_filters(HANDLE *engine, int iface_index, const WCHA=
R *exe_path,
-                      wfp_block_msg_handler_t msg_handler_cal=
lback, BOOL dns_only);
-
 /**
  * Return interface metric value for the spe=
cified interface index=2E
  *
diff --git a/src/openvpn/win32=2Ec b/src/open=
vpn/win32=2Ec
index fde6412=2E=2Ecd73855 100644
--- a/src/openvpn/win32=2Ec=

+++ b/src/openvpn/win32=2Ec
@@ -1215,7 +1215,7 @@
 }
 
 static bool
-win_w=
fp_block_service(bool add, bool dns_only, int index, const HANDLE pipe)
+wi=
n_wfp_block_service(bool add, const wfp_block_t block_type, int index, cons=
t HANDLE pipe)
 {
     bool ret =3D false;
     ack_message_t ack;
@@ -1223=
,7 +1223,7 @@
 
     wfp_block_message_t data =3D { =2Eheader =3D { (add ? =
msg_add_wfp_block : msg_del_wfp_block),
                                   =
           sizeof(wfp_block_message_t), 0 },
-                             =
    =2Eflags =3D dns_only ? wfp_block_dns : wfp_block_local,
+             =
                    =2Eblock_type =3D block_type,
                         =
         =2Eiface =3D { =2Eindex =3D index, =2Ename =3D "" } };
 
     if (=
!send_msg_iservice(pipe, &data, sizeof(data), &ack, "WFP block"))
@@ -1248,=
7 +1248,7 @@
 }
 
 bool
-win_wfp_block(const NET_IFINDEX index, const HANDL=
E msg_channel, BOOL dns_only)
+win_wfp_block(const NET_IFINDEX index, const=
 HANDLE msg_channel, const wfp_block_t block_type)
 {
     WCHAR openvpnpat=
h[MAX_PATH];
     bool ret =3D false;
@@ -1257,7 +1257,7 @@
     if (msg_ch=
annel)
     {
         dmsg(D_LOW, "Using service to add WFP block filters"=
);
-        ret =3D win_wfp_block_service(true, dns_only, index, msg_channe=
l);
+        ret =3D win_wfp_block_service(true, block_type, index, msg_cha=
nnel);
         goto out;
     }
 
@@ -1268,7 +1268,7 @@
     }
 
     stat=
us =3D
-        add_wfp_block_filters(&m_hEngineHandle, index, openvpnpath,=
 win_wfp_msg_handler, dns_only);
+        add_wfp_block_filters(&m_hEngineH=
andle, index, openvpnpath, win_wfp_msg_handler, block_type);
     if (statu=
s =3D=3D 0)
     {
         int is_auto =3D 0;
diff --git a/src/openvpn/win=
32=2Eh b/src/openvpn/win32=2Eh
index 39ff7d8=2E=2Ee1f4373 100644
--- a/src/=
openvpn/win32=2Eh
+++ b/src/openvpn/win32=2Eh
@@ -295,7 +295,31 @@
 /* call=
 self in a subprocess */
 void fork_to_self(const char *cmdline);
 
-bool w=
in_wfp_block(const NET_IFINDEX index, const HANDLE msg_channel, BOOL dns_on=
ly);
+/**
+ * Get the wfp block type value according to the parameters pass=
ed=2E
+ * Block types are defined in the \ref wfp_block_t enum=2E
+ *
+ * @=
param block_local           Do we need to block traffic to local adapters
+=
 * @param block_outside_dns     Do we need to block DNS to local adapters
+=
 * @param allow_loopback_dns    Do we need to make an exception for DNS to =
loopback
+ *
+ * @return wfp_block_none if no blocking is needed, or the bl=
ock type to use
+ */
+static inline wfp_block_t
+get_wfp_block_type(const b=
ool block_local, const bool block_outside_dns, const bool allow_loopback_dn=
s)
+{
+    if (block_local)
+    {
+        return allow_loopback_dns ? wfp=
_block_all_except_local_dns : wfp_block_all;
+    }
+    else if (block_out=
side_dns)
+    {
+        return allow_loopback_dns ? wfp_block_dns_except_=
local : wfp_block_dns;
+    }
+    return wfp_block_none;
+}
+
+bool win_wf=
p_block(const NET_IFINDEX index, const HANDLE msg_channel, const wfp_block_=
t block_type);
 
 bool win_wfp_uninit(const NET_IFINDEX index, const HANDLE=
 msg_channel);
 
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpn=
serv/interactive=2Ec
index d8cf6e1=2E=2E1f7aadf 100644
--- a/src/openvpnser=
v/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -792,12 +792,10 =
@@
     wfp_block_data_t *block_data =3D NULL;
     HANDLE engine =3D NULL;=

     LPCWSTR exe_path;
-    BOOL dns_only;
 
     exe_path =3D settings=2E=
exe_path;
-    dns_only =3D (msg->flags =3D=3D wfp_block_dns);
 
-    err =
=3D add_wfp_block_filters(&engine, msg->iface=2Eindex, exe_path, BlockDNSEr=
rHandler, dns_only);
+    err =3D add_wfp_block_filters(&engine, msg->iface=
=2Eindex, exe_path, BlockDNSErrHandler, msg->block_type);
     if (!err)
  =
   {
         block_data =3D malloc(sizeof(wfp_block_data_t));
@@ -855,6 +8=
53,10 @@
 static DWORD
 HandleWfpBlockMessage(const wfp_block_message_t *ms=
g, undo_lists_t *lists)
 {
+    if (msg->block_type < 0 || msg->block_type =
>=3D wfp_block_type_count)
+    {
+        return ERROR_MESSAGE_DATA;
+    =
}
     if (msg->header=2Etype =3D=3D msg_add_wfp_block)
     {
         ret=
urn AddWfpBlock(msg, lists);

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1541?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I0f7237720b0892f5ba0caf60f941f9cc2241cdb6
Gerrit-Change-Num=
ber: 1541
Gerrit-PatchSet: 6
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>

--DZgFdo2TYVU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Heiko Hund=
 <strong>uploaded patch set #6</strong> to this change=2E</p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1541?usp=3Demail">View Change</a=
></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">wfp: add flag to allow DNS traffic to loopback<br><br>Ad=
d a flag &#39;allow-loopback&#39; to the --block-outside-dns options=2E Whe=
n it<br>is set DNS traffic to loopback (localhost) will not be blocked=2E T=
his<br>flag will also allow DNS to localhost when all local traffic is to b=
e<br>blocked via &#39;--redirect-gateway block-local&#39;=2E<br><br>Fixes #=
703<br><br>Change-Id: I0f7237720b0892f5ba0caf60f941f9cc2241cdb6<br>Signed-o=
ff-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M doc/man-=
sections/windows-options=2Erst<br>M include/openvpn-msg=2Eh<br>M src/openvp=
n/init=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M s=
rc/openvpn/wfp_block=2Ec<br>M src/openvpn/wfp_block=2Eh<br>M src/openvpn/wi=
n32=2Ec<br>M src/openvpn/win32=2Eh<br>M src/openvpnserv/interactive=2Ec<br>=
10 files changed, 121 insertions(+), 59 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/15=
41/6</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/doc/man-sections/windows-options=2Erst b/doc/man-=
sections/windows-options=2Erst</span><br><span>index 8d7dcbb=2E=2Eff2e9d7 1=
00644</span><br><span>--- a/doc/man-sections/windows-options=2Erst</span><b=
r><span>+++ b/doc/man-sections/windows-options=2Erst</span><br><span>@@ -16=
,11 +16,12 @@</span><br><span>   after a reboot, or if the driver is unload=
ed and reloaded=2E This</span><br><span>   directive can only be used by an=
 administrator=2E</span><br><span> </span><br><span>---block-outside-dns</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+--block-outside-dns [a=
llow-loopback]</span><br><span>   Block DNS servers on other network adapte=
rs to prevent DNS leaks=2E This</span><br><span>   option prevents any appl=
ication from accessing TCP or UDP port 53 except</span><br><span>   one ins=
ide the tunnel=2E It uses Windows Filtering Platform (WFP) and</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  works on Windows Vista or later=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  works on Windo=
ws Vista or later=2E If ``allow-loopback`` is set, traffic to</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  localhost port 53 is still allo=
wed=2E</span><br><span> </span><br><span> --cryptoapicert select-string</sp=
an><br><span>   *(Windows/OpenSSL Only)* Load the certificate and private k=
ey from the</span><br><span>diff --git a/include/openvpn-msg=2Eh b/include/=
openvpn-msg=2Eh</span><br><span>index ca3267e8=2E=2E118d3dd 100644</span><b=
r><span>--- a/include/openvpn-msg=2Eh</span><br><span>+++ b/include/openvpn=
-msg=2Eh</span><br><span>@@ -73,9 +73,13 @@</span><br><span> </span><br><sp=
an> typedef enum</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    wfp_block_local =3D 1 &lt;&lt; 0,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    wfp_block_dns =3D 1 &lt;&lt; 1</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-} wfp_block_flags_t;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    wfp_block_all,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    wfp_block_all_except_local=
_dns,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wfp_block_=
dns,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wfp_block_d=
ns_except_local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 wfp_block_type_count,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    wfp_block_none =3D -1</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+} wfp_block_t;</span><br><span> </span><br><span> typedef struct</=
span><br><span> {</span><br><span>@@ -163,7 +167,7 @@</span><br><span> type=
def struct</span><br><span> {</span><br><span>     message_header_t header;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wfp_block_flags_t=
 flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wfp_bloc=
k_t block_type;</span><br><span>     interface_t iface;</span><br><span> } =
wfp_block_message_t;</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 3c2ebf9=2E=2Ea04=
ab2a 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ =
b/src/openvpn/init=2Ec</span><br><span>@@ -1757,12 +1757,14 @@</span><br><s=
pan> {</span><br><span> #if defined(_WIN32)</span><br><span>     /* Fortify=
 &#39;redirect-gateway block-local&#39; with firewall rules? */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    bool block_local =3D block_lo=
cal_needed(c-&gt;c1=2Eroute_list);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const bool block_local =3D block_local_needed(c-&gt;c1=
=2Eroute_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const bool block_outside_dns =3D c-&gt;options=2Eblock_outside_dns;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const bool allow_loopba=
ck_dns =3D c-&gt;options=2Eallow_loopback_dns;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const wfp_block_t block_type =3D get_wfp_blo=
ck_type(block_local, block_outside_dns, allow_loopback_dns);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;opti=
ons=2Eblock_outside_dns || block_local)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (block_type !=3D wfp_block_none)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        BOOL d=
ns_only =3D !block_local;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (!win_wfp_block(c-&gt;c1=2Etuntap-&gt;adapter_index, c-&gt;o=
ptions=2Emsg_channel, dns_only))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (!win_wfp_block(c-&gt;c1=2Etuntap-&gt;adapter_index=
, c-&gt;options=2Emsg_channel, block_type))</span><br><span>         {</spa=
n><br><span>             msg(M_FATAL, &quot;WFP: initialization failed&quot=
;);</span><br><span>         }</span><br><span>@@ -1782,7 +1784,11 @@</span=
><br><span> del_wfp_block(const struct context *c, unsigned long adapter_in=
dex)</span><br><span> {</span><br><span> #if defined(_WIN32)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;options=2Eblock_outsid=
e_dns || block_local_needed(c-&gt;c1=2Eroute_list))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const bool block_local =3D block_loca=
l_needed(c-&gt;c1=2Eroute_list);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const bool block_outside_dns =3D c-&gt;options=2Eblock_out=
side_dns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
wfp_block_t block_type =3D get_wfp_block_type(block_local, block_outside_dn=
s, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (block_type !=3D wfp_=
block_none)</span><br><span>     {</span><br><span>         if (!win_wfp_un=
init(adapter_index, c-&gt;options=2Emsg_channel))</span><br><span>         =
{</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/option=
s=2Ec</span><br><span>index e7585ad=2E=2E743d917 100644</span><br><span>---=
 a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</s=
pan><br><span>@@ -859,6 +859,7 @@</span><br><span>     o-&gt;tuntap_options=
=2Edhcp_masq_offset =3D 0;</span><br><span>     o-&gt;route_method =3D ROUT=
E_METHOD_ADAPTIVE;</span><br><span>     o-&gt;block_outside_dns =3D false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;allow_loop=
back_dns =3D false;</span><br><span>     o-&gt;windows_driver =3D WINDOWS_D=
RIVER_UNSPECIFIED;</span><br><span> #endif</span><br><span>     o-&gt;vlan_=
accept =3D VLAN_ALL;</span><br><span>@@ -3808,6 +3809,7 @@</span><br><span>=
     {</span><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br=
><span>         options-&gt;block_outside_dns =3D false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        options-&gt;allow_loopback_dns=
 =3D false;</span><br><span>     }</span><br><span> #else /* ifdef _WIN32 *=
/</span><br><span>     else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&=
amp; !p[1])</span><br><span>@@ -6739,10 +6741,14 @@</span><br><span>       =
  VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span>         options-&gt;tu=
ntap_options=2Eregister_dns =3D true;</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;block=
-outside-dns&quot;) &amp;&amp; !p[1])</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    else if (streq(p[0], &quot;block-outside-dns&quot;) &=
amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PER=
MISSION(OPT_P_DHCPDNS);</span><br><span>         options-&gt;block_outside_=
dns =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (p[1] &amp;&amp; streq(p[1], &quot;allow-loopback&quot;))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            options-&gt;allow_loopback_dn=
s =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;rd=
ns-internal&quot;) &amp;&amp; !p[1])</span><br><span>     /* standalone met=
hod for internal use</span><br><span>diff --git a/src/openvpn/options=2Eh b=
/src/openvpn/options=2Eh</span><br><span>index d347830=2E=2E06237ef 100644<=
/span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/ope=
nvpn/options=2Eh</span><br><span>@@ -695,6 +695,7 @@</span><br><span>     b=
ool show_net_up;</span><br><span>     int route_method;</span><br><span>   =
  bool block_outside_dns;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    bool allow_loopback_dns;</span><br><span>     enum tun_driver_typ=
e windows_driver;</span><br><span> #endif</span><br><span> </span><br><span=
>diff --git a/src/openvpn/wfp_block=2Ec b/src/openvpn/wfp_block=2Ec</span><=
br><span>index 4d38fdb=2E=2E99802f2 100644</span><br><span>--- a/src/openvp=
n/wfp_block=2Ec</span><br><span>+++ b/src/openvpn/wfp_block=2Ec</span><br><=
span>@@ -131,27 +131,14 @@</span><br><span>     return err;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Block outgoing l=
ocal traffic, possibly DNS only, except for</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * (i) adapter with the specified index (and loopback=
, if all is blocked)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* OR</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * (ii) processes=
 with the specified executable path</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * The firewall filters added here are automatically removed =
when the process exits or</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * on calling delete_wfp_block_filters()=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * Arguments:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *   engine_handle : On successful return contains the ha=
ndle for a newly opened fwp session</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *                   in which the filters are added=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *                   May be =
closed by passing to delete_wfp_block_filters to remove the filters=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *   index         : The i=
ndex of adapter for which traffic is permitted=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *   exe_path      : Path of executable for whi=
ch traffic is permitted=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *   msg_handler   : An optional callback function for error reporting=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   dns_only     =
 : Whether the blocking filters should apply for DNS only=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * Returns 0 on success, a non-zero =
status code of the last failed action on failure=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic igno=
red &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span> </span><br><span> DWORD</span><br><span>=
 add_wfp_block_filters(HANDLE *engine_handle, int index, const WCHAR *exe_p=
ath,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
     wfp_block_msg_handler_t msg_handler, BOOL dns_only)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                      wfp_block_msg_ha=
ndler_t msg_handler, const wfp_block_t block_type)</span><br><span> {</span=
><br><span>     FWPM_SESSION0 session =3D { 0 };</span><br><span>     FWPM_=
SUBLAYER0 *sublayer_ptr =3D NULL;</span><br><span>@@ -247,7 +234,7 @@</span=
><br><span>     Filter=2ElayerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;</span=
><br><span>     Filter=2Eaction=2Etype =3D FWP_ACTION_PERMIT;</span><br><sp=
an>     Condition[0] =3D match_openvpn;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (dns_only)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (block_type =3D=3D wfp_block_dns || block_type =3D=
=3D wfp_block_dns_except_local)</span><br><span>     {</span><br><span>    =
     Filter=2EnumFilterConditions =3D 2;</span><br><span>         Condition=
[1] =3D match_port_53;</span><br><span>@@ -268,7 +255,7 @@</span><br><span>=
     Filter=2Eweight=2Etype =3D FWP_EMPTY;</span><br><span>     Filter=2Enu=
mFilterConditions =3D 1;</span><br><span>     Condition[0] =3D match_not_lo=
opback;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dns_on=
ly)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (block_ty=
pe =3D=3D wfp_block_dns || block_type =3D=3D wfp_block_dns_except_local)</s=
pan><br><span>     {</span><br><span>         Filter=2EnumFilterConditions =
=3D 2;</span><br><span>         Condition[1] =3D match_port_53;</span><br><=
span>@@ -292,7 +279,7 @@</span><br><span>     Filter=2Eaction=2Etype =3D FW=
P_ACTION_PERMIT;</span><br><span>     Filter=2EnumFilterConditions =3D 1;</=
span><br><span>     Condition[0] =3D match_interface;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (dns_only)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (block_type =3D=3D wfp_block_dns || bl=
ock_type =3D=3D wfp_block_dns_except_local)</span><br><span>     {</span><b=
r><span>         Filter=2EnumFilterConditions =3D 2;</span><br><span>      =
   Condition[1] =3D match_port_53;</span><br><span>@@ -308,20 +295,23 @@</s=
pan><br><span> </span><br><span>     msg_handler(0, &quot;WFP Block: Added =
permit filters for VPN interface&quot;);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* Seventh Filter=2E Block IPv4 DN=
S requests to loopback from other apps */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    Filter=2ElayerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V=
4;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Filter=2Eaction=
=2Etype =3D FWP_ACTION_BLOCK;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    Filter=2Eweight=2Etype =3D FWP_EMPTY;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    Filter=2EnumFilterConditions =3D 2;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    Condition[0] =3D match_lo=
opback;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Condition[=
1] =3D match_port_53;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    err =3D FwpmFilterAdd0(*engine_handle, &amp;Filter, NULL, &amp;filterid=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OUT_ON_ERROR(er=
r, &quot;Add filter to block IPv4 DNS traffic to loopback failed&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (block_type !=
=3D wfp_block_all_except_local_dns &amp;&amp; block_type !=3D wfp_block_dns=
_except_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Seventh =
Filter=2E Block IPv4 DNS requests to loopback from other apps */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        Filter=2ElayerKey =3D =
FWPM_LAYER_ALE_AUTH_CONNECT_V4;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        Filter=2Eaction=2Etype =3D FWP_ACTION_BLOCK;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        Filter=2Eweight=2Etype=
 =3D FWP_EMPTY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    Filter=2EnumFilterConditions =3D 2;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        Condition[0] =3D match_loopback;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        Condition[1] =3D match_por=
t_53;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =
=3D FwpmFilterAdd0(*engine_handle, &amp;Filter, NULL, &amp;filterid);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        OUT_ON_ERROR(err,=
 &quot;Add filter to block IPv4 DNS traffic to loopback failed&quot;);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* E=
ighth Filter=2E Block IPv6 DNS requests to loopback from other apps */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    Filter=2ElayerKey =3D =
FWPM_LAYER_ALE_AUTH_CONNECT_V6;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    err =3D FwpmFilterAdd0(*engine_handle, &amp;Filter, NULL, &am=
p;filterid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OUT_O=
N_ERROR(err, &quot;Add filter to block IPv6 DNS traffic to loopback failed&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* E=
ighth Filter=2E Block IPv6 DNS requests to loopback from other apps */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        Filter=2ElayerKe=
y =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        err =3D FwpmFilterAdd0(*engine_handle, &amp;Filte=
r, NULL, &amp;filterid);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        OUT_ON_ERROR(err, &quot;Add filter to block IPv6 DNS traffic t=
o loopback failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span> </span><br><span>     msg_handler(0, &quot;WFP=
 Block: Added block filters for DNS traffic to loopback&quot;);</span><br><=
span> </span><br><span>diff --git a/src/openvpn/wfp_block=2Eh b/src/openvpn=
/wfp_block=2Eh</span><br><span>index 8bc093a=2E=2E8cb5fa5 100644</span><br>=
<span>--- a/src/openvpn/wfp_block=2Eh</span><br><span>+++ b/src/openvpn/wfp=
_block=2Eh</span><br><span>@@ -28,19 +28,47 @@</span><br><span> #include &l=
t;windef=2Eh&gt;</span><br><span> #include &lt;iphlpapi=2Eh&gt;</span><br><=
span> #include &lt;ws2tcpip=2Eh&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &lt;stdbool=2Eh&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;openvpn-msg=2Eh&quot;</span><br><span> </span><br><spa=
n> /* Any value less than 5 should work fine=2E 3 is chosen without any rea=
l reason=2E */</span><br><span> #define WFP_BLOCK_IFACE_METRIC 3</span><br>=
<span> </span><br><span> typedef void (*wfp_block_msg_handler_t)(DWORD err,=
 const char *msg);</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Block outgoing local traffic, possibly DNS only, except for</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * (i) adapter with the specifi=
ed index (and loopback, if all is blocked)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * OR</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * (ii) processes with the specified executable path</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * The firewall filters added her=
e are automatically removed when the process exits or</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * on calling \ref delete_wfp_block_filte=
rs()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param engine_handle On su=
ccessful return contains the handle for a newly opened fwp</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *                      session in w=
hich the filters are added=2E May be closed by passing</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *                      to \ref delete_w=
fp_block_filters() to remove the filters=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param index         The index of adapter for wh=
ich traffic is permitted=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param exe_path      Path of executable for which traffic is per=
mitted=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
msg_handler   An optional callback function for error reporting=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param block_type    Whet=
her the blocking filters should apply for DNS only=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return ERROR_SUCCESS, or a non-zero status code of the=
 last failed action on failure=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+DW=
ORD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_wfp_block_fi=
lters(HANDLE *engine_handle, int index, const WCHAR *exe_path,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                      wfp_block_=
msg_handler_t msg_handler, const wfp_block_t block_type);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Remove the firewall filter rules set with \ref add_wfp_block_filters(=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param engine        The WFP ses=
sion handle in which the firewall rules were added=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return ERROR_SUCCESS, or a non-zero status code of the=
 last failed action on failure=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span> DWORD</span><br><span> delete_wfp_block_=
filters(HANDLE engine);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-add_wfp_block_filters(HANDLE *engine, int iface_index, const WCHAR *exe=
_path,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
       wfp_block_msg_handler_t msg_handler_callback, BOOL dns_only);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span>=
<br><span>  * Return interface metric value for the specified interface ind=
ex=2E</span><br><span>  *</span><br><span>diff --git a/src/openvpn/win32=2E=
c b/src/openvpn/win32=2Ec</span><br><span>index fde6412=2E=2Ecd73855 100644=
</span><br><span>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/open=
vpn/win32=2Ec</span><br><span>@@ -1215,7 +1215,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> static bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-win_wfp_block_service(bool add, bool dns_only, int ind=
ex, const HANDLE pipe)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+win_wfp_block_service(bool add, const wfp_block_t block_type, int index,=
 const HANDLE pipe)</span><br><span> {</span><br><span>     bool ret =3D fa=
lse;</span><br><span>     ack_message_t ack;</span><br><span>@@ -1223,7 +12=
23,7 @@</span><br><span> </span><br><span>     wfp_block_message_t data =3D=
 { =2Eheader =3D { (add ? msg_add_wfp_block : msg_del_wfp_block),</span><br=
><span>                                              sizeof(wfp_block_messa=
ge_t), 0 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                       =2Eflags =3D dns_only ? wfp_block_dns : wfp_block_lo=
cal,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                  =2Eblock_type =3D block_type,</span><br><span>           =
                       =2Eiface =3D { =2Eindex =3D index, =2Ename =3D &quot=
;&quot; } };</span><br><span> </span><br><span>     if (!send_msg_iservice(=
pipe, &amp;data, sizeof(data), &amp;ack, &quot;WFP block&quot;))</span><br>=
<span>@@ -1248,7 +1248,7 @@</span><br><span> }</span><br><span> </span><br>=
<span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-win_wfp_bl=
ock(const NET_IFINDEX index, const HANDLE msg_channel, BOOL dns_only)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+win_wfp_block(const NET_I=
FINDEX index, const HANDLE msg_channel, const wfp_block_t block_type)</span=
><br><span> {</span><br><span>     WCHAR openvpnpath[MAX_PATH];</span><br><=
span>     bool ret =3D false;</span><br><span>@@ -1257,7 +1257,7 @@</span><=
br><span>     if (msg_channel)</span><br><span>     {</span><br><span>     =
    dmsg(D_LOW, &quot;Using service to add WFP block filters&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =3D win_wfp_bloc=
k_service(true, dns_only, index, msg_channel);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        ret =3D win_wfp_block_service(true, bloc=
k_type, index, msg_channel);</span><br><span>         goto out;</span><br><=
span>     }</span><br><span> </span><br><span>@@ -1268,7 +1268,7 @@</span><=
br><span>     }</span><br><span> </span><br><span>     status =3D</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        add_wfp_block_filters(&=
amp;m_hEngineHandle, index, openvpnpath, win_wfp_msg_handler, dns_only);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_wfp_block_=
filters(&amp;m_hEngineHandle, index, openvpnpath, win_wfp_msg_handler, bloc=
k_type);</span><br><span>     if (status =3D=3D 0)</span><br><span>     {</=
span><br><span>         int is_auto =3D 0;</span><br><span>diff --git a/src=
/openvpn/win32=2Eh b/src/openvpn/win32=2Eh</span><br><span>index 39ff7d8=2E=
=2Ee1f4373 100644</span><br><span>--- a/src/openvpn/win32=2Eh</span><br><sp=
an>+++ b/src/openvpn/win32=2Eh</span><br><span>@@ -295,7 +295,31 @@</span><=
br><span> /* call self in a subprocess */</span><br><span> void fork_to_sel=
f(const char *cmdline);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-bool win_wfp_block(const NET_IFINDEX index, const HANDL=
E msg_channel, BOOL dns_only);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Ge=
t the wfp block type value according to the parameters passed=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Block types are defined in =
the \ref wfp_block_t enum=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m block_local           Do we need to block traffic to local adapters</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param block_outside_d=
ns     Do we need to block DNS to local adapters</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param allow_loopback_dns    Do we need to =
make an exception for DNS to loopback</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @return wfp_block_none if no blocking is needed, or the block type to u=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static inline wfp_block_t</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+get_wfp_block_type(const bo=
ol block_local, const bool block_outside_dns, const bool allow_loopback_dns=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (block_local)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return allow_loopback_dns ? wfp_block_all=
_except_local_dns : wfp_block_all;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    else if (block_outside_dns)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return allow_loopback_dns ? wfp_block_dns_except_local : wfp_block_d=
ns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return wfp_block_none;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool win_wfp_block(const NET_IFINDEX index, const HANDLE msg=
_channel, const wfp_block_t block_type);</span><br><span> </span><br><span>=
 bool win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel);</s=
pan><br><span> </span><br><span>diff --git a/src/openvpnserv/interactive=2E=
c b/src/openvpnserv/interactive=2Ec</span><br><span>index d8cf6e1=2E=2E1f7a=
adf 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br>=
<span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -792,12 +792=
,10 @@</span><br><span>     wfp_block_data_t *block_data =3D NULL;</span><b=
r><span>     HANDLE engine =3D NULL;</span><br><span>     LPCWSTR exe_path;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    BOOL dns_only;</s=
pan><br><span> </span><br><span>     exe_path =3D settings=2Eexe_path;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    dns_only =3D (msg-&gt;=
flags =3D=3D wfp_block_dns);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    err =3D add_wfp_block_filters(&amp;engine, msg=
-&gt;iface=2Eindex, exe_path, BlockDNSErrHandler, dns_only);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    err =3D add_wfp_block_filters(=
&amp;engine, msg-&gt;iface=2Eindex, exe_path, BlockDNSErrHandler, msg-&gt;b=
lock_type);</span><br><span>     if (!err)</span><br><span>     {</span><br=
><span>         block_data =3D malloc(sizeof(wfp_block_data_t));</span><br>=
<span>@@ -855,6 +853,10 @@</span><br><span> static DWORD</span><br><span> H=
andleWfpBlockMessage(const wfp_block_message_t *msg, undo_lists_t *lists)</=
span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (msg-&gt;block_type &lt; 0 || msg-&gt;block_type &gt;=3D wfp_block_typ=
e_count)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return ERROR_MESS=
AGE_DATA;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span>     if (msg-&gt;header=2Etype =3D=3D msg_add_wfp_block)</span>=
<br><span>     {</span><br><span>         return AddWfpBlock(msg, lists);</=
span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1541?usp=3Demail">change 1541</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1541?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I0f7237720b0892f5ba0caf60f941f9=
cc2241cdb6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1541 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"=
display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Fra=
nk Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</bod=
y></html>
--DZgFdo2TYVU=--


--===============8328334964345977315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8328334964345977315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8328334964345977315==--

