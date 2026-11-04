Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA77606D812
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AR7Hndqr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KPKt7DAZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SZKpy07b;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LnaRjj+v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ubp3CusLEksWvn4Ekw2Q+mMVnmXZ5+F9dUtzSIjdi4g=; b=AR7Hndqryl8OrHAL9+/qTwWI2h
	todHI+B3TVl+sppbsvTUFnd4Y88rOkODvx26FxfVAuFPawk1VlWcCjHxy2mhkktlxPr9qlWU8xS9E
	Hy/tE3uZZ7sAfx0hyM3xGjGH7oSJqzwRaKtda28EOx5QWXXO0E4t61/WXRXjN0hcdY8g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOdqN-000000002Ld-2BHR;
	Wed, 04 Nov 2026 16:28:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOdqJ-000000002L1-1ip8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:28:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QTYBvsvLhVSxj0uNwgeTGy1V/RtZv7PKiTNEDbXmdZo=; b=KPKt7DAZvcaaYMRCKWvSmL9Hl6
 7pKsr24gcM3qE+NPCE1niZF/yoqrcuhai+CB1UlscSffW7M93aXbQLeA57wExNGoIhXGgB5/Bcqst
 w/iE14/M68dAU+ltmHwGnGUO4PKhfTRF2xSNlvOFIafxAyf8cyen70LXSQqIAxwa8sJY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QTYBvsvLhVSxj0uNwgeTGy1V/RtZv7PKiTNEDbXmdZo=; b=SZKpy07bE37xGreozdnAfLGMTJ
 zJaBguweextxE7Ea1n7HXDxgBwIVjxFoVAFcKYBHFz1K/yx5isJnASy4Et461Go/vrLlkykTamOJV
 /pSsPMo5Ju15kIWB1SMpn/0txzWRhveg+QMRo6GRPys8zjQEGEJ/TuIDX1VjUQWbpRyw=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOdqH-000000006Nn-3FCC for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:28:07 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so10002695e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793809679; x=1794414479; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QTYBvsvLhVSxj0uNwgeTGy1V/RtZv7PKiTNEDbXmdZo=;
 b=LnaRjj+vJZ1lrRz2EkGO6Hta7DAxbEMxckNtE9JlFdNTcOi3aacC2NV1i4+PCZzS34
 KL5HOqC/BgdX24+L5i+3GDtvwTWeCmlrRxsIZ9i6Ot8I0SeIAH+DGCzS/IF3FMg2rKQC
 FC3fXGX4Lgg3HWdQDJQKC5QAptJFaNl/FB365BPDuI8NOhHVArJAqp/ZQXCiVPlHqd/c
 oyrewpO3Lm9TnqDwdgt2qmaHd1qIUyVPhvAmdQVWX6tCL3sMY+qnkxNRYZm2AqUXDEQw
 M6ZWfgpSP+qPurVasjrev2xhJeMxh7IozXzTsqhgxKFjIdkFfX5KRT7m4PZPGj+vb6Fp
 6mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793809679; x=1794414479;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QTYBvsvLhVSxj0uNwgeTGy1V/RtZv7PKiTNEDbXmdZo=;
 b=vJxhW0T4hDosbZL6yzh7Bae7Jc37pEYfoTYtRvOFhNErox1xnnYHGbQgpSMpBzajPC
 aXh0Dz8KQVxARqZSaxT3to1Vqbxh+IMSVk6Z4FA9JkbcA0WRts7hLJjkBFLDkUa8OQDp
 /gzIidddVP0aU2Lh6ThR9fMAC2KRuYQAFRvdUCs/Masvenc3+nMg0EqcccUOrpySQfxg
 3ohU+MEbNWMcI+OfoJ72nZ/0iCzxy5U7QrjDjRgBUbrPtlTMEoV4WYR1z54etGKCoZ11
 Z3iCR8+0flxk88t9bPDJgfMupBUf2dzEHYV5/CaLMj/F6Snx4nwFl9MDHHsDPTuIKnDF
 ZMzA==
X-Gm-Message-State: APuU4Z8MDA03y9IJEvOShCoDX7X7xFAj/oMT6UxpMGz60ahuJMrI0fsZ
 cfl/fyGOldKayDmVEgLlWWupgf8c/A2vv1wFmocIxy0YhBbNazGwMs3HiZCzhchkqvgf728jOdP
 LEN5/hrt3TFjtaJbPX9eJfBWc/wA+4f8WdqHh/N/IBsmXJnj6PcLYMr/iiJxVq2V2tldI1FVwLw
 xXvmUOiA==
X-Gm-Gg: AYBFou3GY+/D78mgY9OgyHZUI2Xgmol5afz/CX3fAsc9CZ85Z5rxGiaTsQr4CvHgJUR
 FEAvflEQg0urxHR83SRH1CbvTg+o3LN83PDbZB8gZ8bI4aMmpH2RP+nxbLonyJRNNNtCb8fBvGz
 UWIR0W4deUsFFkPVbgRirasE6kTk49Wuv4VO1tPv0FRM0iu7xhb0OfD8GiUi6ROYEXZI+ZnKopl
 VgwteNoOdXxN18dvTqp8KlAvcZYPdRfCIoEnY9VVZqJjb4CqToobIZEN01GluGTXa5bT+P71OsZ
 uePHdCHZIt4ynYvOaOMRSYRhaodhsx3mrTa4yRwBJ9Yn657BICgKaK+DyovuSkT/H+ZqT7FCPzD
 PY9ZrmCGiY19/irAtnwfT4jHiwD0gj3f5+SJMYoWQqTgSn/04hxqLBlhuSaM2qGWch55lkHeUqp
 QLsm10sUKBiHpYYU3NbgjVSRmDTtco2r38h89NN1aa9IS0HnYeNWrCKsDlsNQAaMJr38aG4MlaA
 SNCjGObUHM37PhVJ+v79sVO2zkN6vEl/JeOju7rzLEAWBY45301teVnYU3tD16XQPu8zGPtpqPk
 Qaiolx2X7GHTBQnbDI6PBnaS6OxQoO2lv7aEREUlml4N7owD/csrl/GDfUchGDXm2tDTVaPU4++
 UHfSLBbFnpyzQimv0l0GF2kSmP/YxYZaHGiyMT8Qyy4UlV6AoQWkYyBuc3mtey70hK3GNUkYj2q
 LYlMyMZR1ysBbOUA==
X-Received: by 2002:a05:600c:5397:b0:4a4:4d57:8462 with SMTP id
 5b1f17b1804b1-4ac18b7e65bmr369745495e9.24.1793809678935; 
 Wed, 04 Nov 2026 08:27:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2afee292bsm163895875e9.4.2026.11.04.08.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:27:57 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:27:50 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I24589d5158f67febd3c25af029944d3f1da32763
X-Gerrit-Change-Number: 2063
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2063?usp=email>
X-Gerrit-Commit: 81c4dde479fa60d5fec0736c65406622e3327206
In-Reply-To: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
References: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkkyNDU4OWQ1MTU4ZjY3ZmViZDNjMjVhZjAyOTk0NGQzZjFkYTMyNzYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <54b8de01b3a5b8c8ac410c734a452458dcd95910-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOdqH-000000006Nn-3FCC
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE: enable
 Linux DCO address and iroute updates
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0063234489354603886=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0063234489354603886==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XowYeXSrAxI="; charset=UTF-8

--XowYeXSrAxI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a c=
hange=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?=
usp=3Demail

to look at the new patch set (#2)=2E

The following approvals =
got outdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru

The c=
hange is no longer submittable: Code-Review and checks~ChecksSubmitRule are=
 unsatisfied now=2E


Change subject: PUSH_UPDATE: enable Linux DCO address=
 and iroute updates
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

PUSH_UPDATE: enable Linux DCO address and iroute updates

Remove af=
fected DCO routes before changing virtual addresses, synchronize
the change=
d families with the Linux DCO peer, and reinstall only iroutes
still owned =
by this client=2E Preserve the userspace iroutes=2E
Restart the client if u=
pdating the DCO peer fails, allowing the existing
scheduled-exit check to r=
eport the push as failed=2E Skip clients already
scheduled to exit=2E

Chan=
ge-Id: I24589d5158f67febd3c25af029944d3f1da32763
Signed-off-by: Marco Baffo=
 <marco@mandelbit=2Ecom>
---
M src/openvpn/multi=2Ec
M src/openvpn/push_uti=
l=2Ec
2 files changed, 82 insertions(+), 3 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/2063/2

diff --git a/s=
rc/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index a850e72=2E=2E8a4b2e1 100=
644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4496,6 +449=
6,7 @@
 static void
 unlearn_ifconfig(struct multi_context *m, struct multi=
_instance *mi)
 {
+    multi_del_dco_iroutes_v4(m, mi);
     in_addr_t old_=
addr =3D 0;
     old_addr =3D htonl(mi->context=2Ec2=2Epush_ifconfig_local)=
;
     multi_unlearn_in_addr_t(m, mi, old_addr);
@@ -4508,6 +4509,7 @@
 sta=
tic void
 unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_insta=
nce *mi)
 {
+    multi_del_dco_iroutes_v6(m, mi);
     struct in6_addr old_=
addr6;
     CLEAR(old_addr6);
     old_addr6 =3D mi->context=2Ec2=2Epush_if=
config_ipv6_local;
@@ -4517,9 +4519,54 @@
     CLEAR(mi->reporting_addr_ipv=
6);
 }
 
+/* Reinstall only routes that are still owned by this client=2E *=
/
+static void
+multi_reinstall_owned_dco_iroute(struct multi_context *m, s=
truct multi_instance *mi,
+                                 const struct mr=
oute_addr *addr)
+{
+    const struct multi_route *route =3D hash_lookup(m-=
>vhash, addr);
+    if (route && route->instance =3D=3D mi && multi_route_d=
efined(m, route))
+    {
+        dco_install_iroute(m, mi, addr);
+    }
+=
}
+
+/* Userspace iroutes do not depend on the client's VPN address=2E Only=
 their
+ * DCO routes need to be reinstalled when the gateway changes=2E */=

+static void
+multi_reinstall_dco_iroutes(struct multi_context *m, struct =
multi_instance *mi, int flags)
+{
+    if ((flags & (1 << AF_INET)) && mi->=
context=2Ec2=2Epush_ifconfig_defined)
+    {
+        for (const struct iro=
ute *ir =3D mi->context=2Eoptions=2Eiroutes; ir; ir =3D ir->next)
+        =
{
+            struct mroute_addr addr =3D { 0 };
+            mroute_extra=
ct_in_addr_t(&addr, ir->network);
+            addr=2Etype |=3D MR_WITH_NET=
BITS;
+            addr=2Enetbits =3D (uint8_t)ir->netbits;
+            mu=
lti_reinstall_owned_dco_iroute(m, mi, &addr);
+        }
+    }
+
+    if (=
(flags & (1 << AF_INET6)) && mi->context=2Ec2=2Epush_ifconfig_ipv6_defined)=

+    {
+        for (const struct iroute_ipv6 *ir6 =3D mi->context=2Eoptio=
ns=2Eiroutes_ipv6; ir6; ir6 =3D ir6->next)
+        {
+            struct m=
route_addr addr =3D { 0 };
+            addr=2Etype =3D MR_ADDR_IPV6 | MR_W=
ITH_NETBITS;
+            addr=2Elen =3D 16;
+            addr=2Enetbits =
=3D (uint8_t)ir6->netbits;
+            addr=2Ev6=2Eaddr =3D ir6->network;
=
+            mroute_addr_mask_host_bits(&addr);
+            multi_reinstal=
l_owned_dco_iroute(m, mi, &addr);
+        }
+    }
+}
+
 /**
- * Update th=
e vhash when a push-update message containing
- * ifconfig/ifconfig-ipv6 op=
tions is sent from the server=2E
+ * Update the vhash and DCO peer addresse=
s when a push-update message containing
+ * ifconfig/ifconfig-ipv6 options =
is sent from the server=2E Preserve userspace
+ * iroutes and reinstall the=
ir DCO routes with the new IP if needed=2E
  *
  * @param m         The mul=
ti_context
  * @param mi        The multi_instance of the client we are upd=
ating
@@ -4531,15 +4578,20 @@
 bool
 update_vaddr(struct multi_context *m, =
struct multi_instance *mi, const char *new_ip, const char *new_ipv6)
 {
+  =
  /* Track changed address families to avoid resetting unchanged DCO addres=
ses=2E */
+    int update_flags =3D 0;
+
     /* -ifconfig */
     if (!new=
_ip && mi->context=2Ec2=2Epush_ifconfig_defined)
     {
         unlearn_if=
config(m, mi);
+        update_flags |=3D (1 << AF_INET);
     }
     /* -i=
fconfig-ipv6 */
     if (!new_ipv6 && mi->context=2Ec2=2Epush_ifconfig_ipv6=
_defined)
     {
         unlearn_ifconfig_ipv6(m, mi);
+        update_fla=
gs |=3D (1 << AF_INET6);
     }
 
     if (new_ip)
@@ -4553,6 +4605,7 @@
  =
           if (mi->context=2Ec2=2Epush_ifconfig_defined)
             {
   =
              unlearn_ifconfig(m, mi);
+                update_flags |=3D (=
1 << AF_INET);
             }
 
             /* DCO needs the new address w=
hile installing its on-link route=2E */
@@ -4562,6 +4615,7 @@
             =
{
                 /* set our client's VPN endpoint for status reporting pu=
rposes */
                 mi->reporting_addr =3D mi->context=2Ec2=2Epush_i=
fconfig_local;
+                update_flags |=3D (1 << AF_INET);
         =
    }
             else
             {
@@ -4589,6 +4643,7 @@
             i=
f (mi->context=2Ec2=2Epush_ifconfig_ipv6_defined)
             {
          =
       unlearn_ifconfig_ipv6(m, mi);
+                update_flags |=3D (1 =
<< AF_INET6);
             }
 
             /* DCO needs the new address wh=
ile installing its on-link route=2E */
@@ -4598,6 +4653,7 @@
             {=

                 /* set our client's VPN endpoint for status reporting pur=
poses */
                 mi->reporting_addr_ipv6 =3D mi->context=2Ec2=2Epu=
sh_ifconfig_ipv6_local;
+                update_flags |=3D (1 << AF_INET6);=

             }
             else
             {
@@ -4613,6 +4669,24 @@
   =
          }
         }
     }
+
+    if (!update_flags || !dco_enabled(&m->=
top=2Eoptions))
+    {
+        return true;
+    }
+
+    int ret =3D dco_=
multi_update_peer_addr(&mi->context, update_flags);
+    if (ret < 0)
+    =
{
+        msg(M_WARN, "MULTI: failed to update DCO peer addresses (error %=
d)", ret);
+        /* PUSH_UPDATE is already queued, so reconnect to resto=
re consistent state=2E */
+        send_restart(&mi->context, NULL);
+     =
   multi_schedule_context_wakeup(m, mi);
+        return false;
+    }
+
+ =
   multi_reinstall_dco_iroutes(m, mi, update_flags);
+
     return true;
 }=

 
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index=
 cd940fb=2E=2Eaa77583 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/open=
vpn/push_util=2Ec
@@ -255,12 +255,14 @@
 static int
 send_push_update(struc=
t multi_context *m, const void *target, const char *msg, const push_update_=
type type, const size_t push_bundle_size)
 {
+#if !defined(TARGET_LINUX)
  =
   if (dco_enabled(&m->top=2Eoptions))
     {
         msg(M_WARN, "WARN: P=
USH_UPDATE messages cannot currently be sent while DCO is enabled=2E"
     =
                " To send a PUSH_UPDATE message, be sure to use the --disab=
le-dco option=2E");
         return 0;
     }
+#endif
 
     if (!msg || !*=
msg || !m || (!target && type !=3D UPT_BROADCAST))
     {
@@ -303,6 +305,7 =
@@
         }
 
         if (!mi->halt
+            && !event_timeout_defin=
ed(&mi->context=2Ec2=2Escheduled_exit)
             && send_single_push_upd=
ate(m, mi, msgs))
         {
             buffer_list_free(msgs);
@@ -323,7=
 +326,9 @@
     {
         struct multi_instance *curr_mi =3D m->instances[=
i];
 
-        if (!curr_mi || curr_mi->halt || !support_push_update(curr_m=
i))
+        if (!curr_mi || curr_mi->halt
+            || event_timeout_de=
fined(&curr_mi->context=2Ec2=2Escheduled_exit)
+            || !support_pus=
h_update(curr_mi))
         {
             continue;
         }

-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I24589d5158f67febd3c25af0=
29944d3f1da32763
Gerrit-Change-Number: 2063
Gerrit-PatchSet: 2
Gerrit-Owner=
: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atte=
ntion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--XowYeXSrAxI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Marco B=
affo <strong>uploaded patch set #2</strong> to this change=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Rev=
iew+2 by R=C4=83zvan Cojocaru</p><p>The change is no longer submittable: Co=
de-Review and checks~ChecksSubmitRule are unsatisfied now=2E</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">PUSH_UPDATE: enable Linux DCO address and iroute updates<br><br>Remove =
affected DCO routes before changing virtual addresses, synchronize<br>the c=
hanged families with the Linux DCO peer, and reinstall only iroutes<br>stil=
l owned by this client=2E Preserve the userspace iroutes=2E<br>Restart the =
client if updating the DCO peer fails, allowing the existing<br>scheduled-e=
xit check to report the push as failed=2E Skip clients already<br>scheduled=
 to exit=2E<br><br>Change-Id: I24589d5158f67febd3c25af029944d3f1da32763<br>=
Signed-off-by: Marco Baffo &lt;marco@mandelbit=2Ecom&gt;<br>---<br>M src/op=
envpn/multi=2Ec<br>M src/openvpn/push_util=2Ec<br>2 files changed, 82 inser=
tions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/2063/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index a850e72=
=2E=2E8a4b2e1 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br>=
<span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -4496,6 +4496,7 @@</sp=
an><br><span> static void</span><br><span> unlearn_ifconfig(struct multi_co=
ntext *m, struct multi_instance *mi)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    multi_del_dco_iroutes_v4(m, mi);</s=
pan><br><span>     in_addr_t old_addr =3D 0;</span><br><span>     old_addr =
=3D htonl(mi-&gt;context=2Ec2=2Epush_ifconfig_local);</span><br><span>     =
multi_unlearn_in_addr_t(m, mi, old_addr);</span><br><span>@@ -4508,6 +4509,=
7 @@</span><br><span> static void</span><br><span> unlearn_ifconfig_ipv6(st=
ruct multi_context *m, struct multi_instance *mi)</span><br><span> {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_del_dco_iroutes_=
v6(m, mi);</span><br><span>     struct in6_addr old_addr6;</span><br><span>=
     CLEAR(old_addr6);</span><br><span>     old_addr6 =3D mi-&gt;context=2E=
c2=2Epush_ifconfig_ipv6_local;</span><br><span>@@ -4517,9 +4519,54 @@</span=
><br><span>     CLEAR(mi-&gt;reporting_addr_ipv6);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Rein=
stall only routes that are still owned by this client=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_reinstall_owned_dco_iroute(struct m=
ulti_context *m, struct multi_instance *mi,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                 const struct mrout=
e_addr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct multi_r=
oute *route =3D hash_lookup(m-&gt;vhash, addr);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (route &amp;&amp; route-&gt;instance =3D=
=3D mi &amp;&amp; multi_route_defined(m, route))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        dco_install_iroute(m, mi, addr);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Userspace ir=
outes do not depend on the client&#39;s VPN address=2E Only their</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * DCO routes need to be rein=
stalled when the gateway changes=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+multi_reinstall_dco_iroutes(struct multi_context *m, struct mult=
i_instance *mi, int flags)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((fl=
ags &amp; (1 &lt;&lt; AF_INET)) &amp;&amp; mi-&gt;context=2Ec2=2Epush_ifcon=
fig_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (const st=
ruct iroute *ir =3D mi-&gt;context=2Eoptions=2Eiroutes; ir; ir =3D ir-&gt;n=
ext)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct mroute=
_addr addr =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            mroute_extract_in_addr_t(&amp;addr, ir-&gt;network);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            addr=2Etype |=3D=
 MR_WITH_NETBITS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          addr=2Enetbits =3D (uint8_t)ir-&gt;netbits;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            multi_reinstall_owned_dco_iro=
ute(m, mi, &amp;addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if ((flags &amp; (1 &lt;&lt; AF_INET=
6)) &amp;&amp; mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        for (const struct iroute_ipv6 *ir6 =
=3D mi-&gt;context=2Eoptions=2Eiroutes_ipv6; ir6; ir6 =3D ir6-&gt;next)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            struct mroute_addr ad=
dr =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      addr=2Etype =3D MR_ADDR_IPV6 | MR_WITH_NETBITS;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            addr=2Elen =3D 16;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            addr=2Enetbits =3D=
 (uint8_t)ir6-&gt;netbits;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            addr=2Ev6=2Eaddr =3D ir6-&gt;network;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            mroute_addr_mask_host_bits=
(&amp;addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     multi_reinstall_owned_dco_iroute(m, mi, &amp;addr);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Up=
date the vhash when a push-update message containing</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * ifconfig/ifconfig-ipv6 options is sent f=
rom the server=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Update the vhash and DCO peer addresses when a push-update message contain=
ing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ifconfig/ifco=
nfig-ipv6 options is sent from the server=2E Preserve userspace</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * iroutes and reinstall their =
DCO routes with the new IP if needed=2E</span><br><span>  *</span><br><span=
>  * @param m         The multi_context</span><br><span>  * @param mi      =
  The multi_instance of the client we are updating</span><br><span>@@ -4531=
,15 +4578,20 @@</span><br><span> bool</span><br><span> update_vaddr(struct =
multi_context *m, struct multi_instance *mi, const char *new_ip, const char=
 *new_ipv6)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* Track changed address families to avoid resetting unchang=
ed DCO addresses=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int update_flags =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     /* -ifconfig */</span><br><span>     if (!=
new_ip &amp;&amp; mi-&gt;context=2Ec2=2Epush_ifconfig_defined)</span><br><s=
pan>     {</span><br><span>         unlearn_ifconfig(m, mi);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        update_flags |=3D (1 &lt;&=
lt; AF_INET);</span><br><span>     }</span><br><span>     /* -ifconfig-ipv6=
 */</span><br><span>     if (!new_ipv6 &amp;&amp; mi-&gt;context=2Ec2=2Epus=
h_ifconfig_ipv6_defined)</span><br><span>     {</span><br><span>         un=
learn_ifconfig_ipv6(m, mi);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        update_flags |=3D (1 &lt;&lt; AF_INET6);</span><br><span>  =
   }</span><br><span> </span><br><span>     if (new_ip)</span><br><span>@@ =
-4553,6 +4605,7 @@</span><br><span>             if (mi-&gt;context=2Ec2=2Ep=
ush_ifconfig_defined)</span><br><span>             {</span><br><span>      =
           unlearn_ifconfig(m, mi);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                update_flags |=3D (1 &lt;&lt; AF_INET);</sp=
an><br><span>             }</span><br><span> </span><br><span>             =
/* DCO needs the new address while installing its on-link route=2E */</span=
><br><span>@@ -4562,6 +4615,7 @@</span><br><span>             {</span><br><=
span>                 /* set our client&#39;s VPN endpoint for status repor=
ting purposes */</span><br><span>                 mi-&gt;reporting_addr =3D=
 mi-&gt;context=2Ec2=2Epush_ifconfig_local;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                update_flags |=3D (1 &lt;&lt; AF_IN=
ET);</span><br><span>             }</span><br><span>             else</span=
><br><span>             {</span><br><span>@@ -4589,6 +4643,7 @@</span><br><=
span>             if (mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined)</sp=
an><br><span>             {</span><br><span>                 unlearn_ifconf=
ig_ipv6(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            update_flags |=3D (1 &lt;&lt; AF_INET6);</span><br><span>      =
       }</span><br><span> </span><br><span>             /* DCO needs the ne=
w address while installing its on-link route=2E */</span><br><span>@@ -4598=
,6 +4653,7 @@</span><br><span>             {</span><br><span>              =
   /* set our client&#39;s VPN endpoint for status reporting purposes */</s=
pan><br><span>                 mi-&gt;reporting_addr_ipv6 =3D mi-&gt;contex=
t=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                update_flags |=3D (1 &lt;&lt; AF_INET6);</sp=
an><br><span>             }</span><br><span>             else</span><br><sp=
an>             {</span><br><span>@@ -4613,6 +4669,24 @@</span><br><span>  =
           }</span><br><span>         }</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!update_flags || !dco_enabled(&amp;m-&gt;to=
p=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int ret =3D dco_multi_update_peer_addr(&amp;mi-&=
gt;context, update_flags);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(M_WARN, &quot;MULTI: failed to update DCO peer addresses (error %d)&qu=
ot;, ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* PUSH_UPDATE is already queued, so reconnect to restore consistent state=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        send_=
restart(&amp;mi-&gt;context, NULL);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        multi_schedule_context_wakeup(m, mi);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    multi_reinstall_dco_iroutes(m, mi, update_flags);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return t=
rue;</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/=
openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index cd9=
40fb=2E=2Eaa77583 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</s=
pan><br><span>+++ b/src/openvpn/push_util=2Ec</span><br><span>@@ -255,12 +2=
55,14 @@</span><br><span> static int</span><br><span> send_push_update(stru=
ct multi_context *m, const void *target, const char *msg, const push_update=
_type type, const size_t push_bundle_size)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_LINUX)</span>=
<br><span>     if (dco_enabled(&amp;m-&gt;top=2Eoptions))</span><br><span> =
    {</span><br><span>         msg(M_WARN, &quot;WARN: PUSH_UPDATE messages=
 cannot currently be sent while DCO is enabled=2E&quot;</span><br><span>   =
                  &quot; To send a PUSH_UPDATE message, be sure to use the =
--disable-dco option=2E&quot;);</span><br><span>         return 0;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span> </span><br><span>     if (!msg || !*msg || !m || (!targe=
t &amp;&amp; type !=3D UPT_BROADCAST))</span><br><span>     {</span><br><sp=
an>@@ -303,6 +305,7 @@</span><br><span>         }</span><br><span> </span><=
br><span>         if (!mi-&gt;halt</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &amp;&amp; !event_timeout_defined(&amp;mi-&gt;co=
ntext=2Ec2=2Escheduled_exit)</span><br><span>             &amp;&amp; send_s=
ingle_push_update(m, mi, msgs))</span><br><span>         {</span><br><span>=
             buffer_list_free(msgs);</span><br><span>@@ -323,7 +326,9 @@</s=
pan><br><span>     {</span><br><span>         struct multi_instance *curr_m=
i =3D m-&gt;instances[i];</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (!curr_mi || curr_mi-&gt;halt || !support_=
push_update(curr_mi))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (!curr_mi || curr_mi-&gt;halt</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            || event_timeout_defined(&amp;curr_mi-&g=
t;context=2Ec2=2Escheduled_exit)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            || !support_push_update(curr_mi))</span><br><span>=
         {</span><br><span>             continue;</span><br><span>         =
}</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2063?usp=3Demail">change 2063</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I24589d5158f67febd3c25af029944=
d3f1da32763 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2063 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D=
"display:none"> Gerrit-Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=

</body></html>
--XowYeXSrAxI=--


--===============0063234489354603886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0063234489354603886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0063234489354603886==--

