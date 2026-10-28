Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CC606A31D
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Uq++/LSi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Qu2VbA7E;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Eggmty+a;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Rapjl92A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=5XMTeXK4odLzA+L40sVbrLDyswY3oeh3wZ60s8jFft4=; b=Uq++/LSijVk0hlMCtJ1HGN3PkE
	gtdFzQiM0eiRUPL4yfIFkArRIQSQVf6rSJtGgVIkSzKVtu2lUAGLyW+7I2vXcUZNvE6jZ48M0e8BJ
	rwyiuDW9dUBrxqZxGT4TBQWy5YSsKGVZeqg1PfRJ7z2Gx9Q8nfOD5+a1BS88ZqjOExTY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM3rl-000000004x1-09IU;
	Wed, 28 Oct 2026 13:38:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM3r3-000000004w5-2mH7
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 13:38:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OzrWd94MNGca8JjYANS/81cMMDyf91Xmz6bC19au9IY=; b=Qu2VbA7E1JQXWPQIaDsXpEFwrQ
 //jkd1pGOF3LJsvVWYuNh928gItecVPqZMH37kbubcaDAfB8VattQGD7Xb/L4OZ4t0gDoGs3WH/4i
 f9juqNcnyO982KFayX9TK0SuoBNhn2v/Nfdn5EouphTfKEI+tvCYu9mrOxgdTm7hi6e4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OzrWd94MNGca8JjYANS/81cMMDyf91Xmz6bC19au9IY=; b=Eggmty+aMwMgbI7nFX+zJfx/H1
 sU3KJdcHnt0peLDFpFqvR9Qganwclwsce5trnDSlyR6JzLGSqNwv7U01fXUSdcyb2POxPwU1l15do
 xNUOkBBoH32P/8pmA4v6Vif4NvLzBuZ9K+sfZjdIZ84fYw5RwuAwjnwFjb1iJJyGgYhY=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM3r0-00000000746-26FO for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 13:38:12 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so7264655e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 06:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793194684; x=1793799484; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OzrWd94MNGca8JjYANS/81cMMDyf91Xmz6bC19au9IY=;
 b=Rapjl92AIVWdCDG1qK6dlQ3dGblkFOiFod406cByC33qGmMnRItzbUOjp/7BItRuqP
 lR/0RYfXYLNKUjYgfMF+qrY9gW7MTq5mfZH84n4sfkisSBLGpMZ9QCDAUntNJb/crIhf
 LDpakZeJaC2u4dS930WOvg6jejlcZjT5NbqJXfKQ9P4h7SDRmH8DZfdVkpebmLFha1j3
 hrUZr+wgHdjyXedKFnobKO/5iY81IQRZKbw9/Q4kF80GkP4+IIYenlFMVygk2QqVAAoW
 66qETN6j4U60AtlF5Rz6SZy7SskzW+pYXAcDOuYWivdI5miqq4PMV5bE3IJi7zP+zHoa
 j3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793194684; x=1793799484;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OzrWd94MNGca8JjYANS/81cMMDyf91Xmz6bC19au9IY=;
 b=pQtZKM8xpuyKwj/P22Xrpx4wxlNUEieSveJKxwisefM8cjXDI7FmL70DO+/JENb75Y
 5XfEl4+Zb9S4bTC2qEAy44Sr9x1M0113fU78Gp041AjfVzW5V/FgBqvwzKO8aveWC3YZ
 nrY2F+fcLMclsyPWyC0W7B8Z5sTHtZyk9NEa+hrtxuzu9RrZcu71i8/pfBrRU8GMhqMd
 9HcUhRTF82nnTrh6MQKqatYCrnhyKcjeXMvbkj29I7zGGgGYhyd3NRHr7ADwq7Vl9jqx
 8ORJp/n05k7521mrL7FImBlv5ZTivecrSvxfbUc/q8mkywS8vLSJBKOF2dsxHBCXq9z7
 iqQA==
X-Gm-Message-State: AFq9FYJCNKob9zVg1liuZjrP2lltZdZbDj4oNTXgaB6HcHg8VeSOYQ+j
 eflV2mRLjQvWSDEuZ31+cAkuJaViBHfWbWtv3yopVzwR9j8tyvDJCRIg/lW8Bb3CsPfuBmHCfm3
 erBlVEDyuCDPcuOzbsMMB2STk4CU9JNdIhX/4yEVNAYmaKJfVNUxXTFcCRNENN5WAUw4WhRR34a
 THanjaqQ==
X-Gm-Gg: AYBFou0vRcRUddYNgY5bR6gd0Bly6ivzdnXADlr8x4IaFs6qx/TuSJsT272hY4bdZBY
 XlXgjJU1U8ElswFCpTKjyzrcWzDs6F+Rsr7VfmpT+4JYPAiOjsnvlbVLvnIPoXhhZHAyFzcgL4U
 n/4fY6ZMIX7DihAYOMqytR/ut5o3ytQxwzBtNZ+GsQGIUNhtz0C8SoogFjYxX0lQgM6R3G2J6lI
 ncDyZvfnbDDH/SrkltQ1HxPt3wVOCK+mlGx/ra3wRvcQF+3FgB0RMNHBDfuBz6blSAA6OQF1aTZ
 /wqeXS0Hi7hcVzbDbXEzJ2g75b7QrBV1TTHSY9OiwxcCpm4ORzClHEj4NuAEEwwI1b9bfO/iawY
 Pq3V1Lp+WSi583Dr0Md2iEP2+n5tnrkazuthIaUvMA89L7s5rjyp8aJgzEIitaeKLf5FLVGBZA4
 SvKiWyi0uQWkDJDYwyMzNnJlcq8+H1YALhR+9eNNTndvef7XLYLtd0aZAUOGSvTf/Hj/u+mWQaD
 U1PrgjWwh1F06bYXBJ+I1sduC4AKPc8YtnkzcuRzayKy65oUY/mii6akUXCwvBSTfzf9Y3yJeBz
 dhzhwVAmzhItmc+X9ruOoKgdqz+aAW3wY+yTUY4AHsN+gFHa6/zxYg3QnlT0HYxBuz5I4OsBeDF
 hA85nGJNVSQd5mE+GtrCUgIEHx6F9oRI/L5txUzAFnATSYvWVp7O2fgbpYqcl6AmT57Dj741Fgj
 Nl6nMNiRFnZmH9yIE=
X-Received: by 2002:a05:600c:1d1a:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-4a966c41d56mr53142055e9.19.1793194683079; 
 Wed, 28 Oct 2026 06:38:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a978d57c36sm45779975e9.11.2026.10.28.06.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:38:02 -0700 (PDT)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 13:38:02 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I24589d5158f67febd3c25af029944d3f1da32763
X-Gerrit-Change-Number: 2063
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2063?usp=email>
X-Gerrit-Commit: 213806ce47126f4e8aed2137ed11cfabdf7f49de
References: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkkyNDU4OWQ1MTU4ZjY3ZmViZDNjMjVhZjAyOTk0NGQzZjFkYTMyNzYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <899c9a6c9898934948accf907383121de1d3c258-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM3r0-00000000746-26FO
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
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8239598798274446731=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8239598798274446731==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/CKwlQ1NIRQ="; charset=UTF-8

--/CKwlQ1NIRQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2063?usp=3Demail

to review the following change=2E
=


Change subject: PUSH_UPDATE: enable Linux DCO address and iroute updates
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

PUSH_UPDATE: =
enable Linux DCO address and iroute updates

Remove affected DCO routes bef=
ore changing virtual addresses, synchronize
the changed families with the L=
inux DCO peer, and reinstall only iroutes
still owned by this client=2E Pre=
serve the userspace iroutes=2E
Restart the client if updating the DCO peer =
fails, allowing the existing
scheduled-exit check to report the push as fai=
led=2E Skip clients already
scheduled to exit=2E

Change-Id: I24589d5158f67=
febd3c25af029944d3f1da32763
Signed-off-by: Marco Baffo <marco@mandelbit=2Ec=
om>
---
M src/openvpn/multi=2Ec
M src/openvpn/push_util=2Ec
2 files changed=
, 86 insertions(+), 3 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/63/2063/1

diff --git a/src/openvpn/multi=2Ec=
 b/src/openvpn/multi=2Ec
index edeef96=2E=2E093b98a 100644
--- a/src/openvp=
n/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4436,6 +4436,7 @@
 static void
=
 unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi)
 {
+ =
   multi_del_dco_iroutes_v4(m, mi);
     in_addr_t old_addr =3D 0;
     old=
_addr =3D htonl(mi->context=2Ec2=2Epush_ifconfig_local);
     multi_unlearn=
_in_addr_t(m, mi, old_addr);
@@ -4448,6 +4449,7 @@
 static void
 unlearn_if=
config_ipv6(struct multi_context *m, struct multi_instance *mi)
 {
+    mul=
ti_del_dco_iroutes_v6(m, mi);
     struct in6_addr old_addr6;
     CLEAR(ol=
d_addr6);
     old_addr6 =3D mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
@=
@ -4457,9 +4459,54 @@
     CLEAR(mi->reporting_addr_ipv6);
 }
 
+/* Reinsta=
ll only routes that are still owned by this client=2E */
+static void
+mult=
i_reinstall_owned_dco_iroute(struct multi_context *m, struct multi_instance=
 *mi,
+                                 const struct mroute_addr *addr)
+{
=
+    const struct multi_route *route =3D hash_lookup(m->vhash, addr);
+    =
if (route && route->instance =3D=3D mi && multi_route_defined(m, route))
+ =
   {
+        dco_install_iroute(m, mi, addr);
+    }
+}
+
+/* Userspace ir=
outes do not depend on the client's VPN address=2E Only their
+ * DCO route=
s need to be reinstalled when the gateway changes=2E */
+static void
+multi=
_reinstall_dco_iroutes(struct multi_context *m, struct multi_instance *mi, =
int flags)
+{
+    if ((flags & (1 << AF_INET)) && mi->context=2Ec2=2Epush_=
ifconfig_defined)
+    {
+        for (const struct iroute *ir =3D mi->cont=
ext=2Eoptions=2Eiroutes; ir; ir =3D ir->next)
+        {
+            struc=
t mroute_addr addr =3D { 0 };
+            mroute_extract_in_addr_t(&addr, =
ir->network);
+            addr=2Etype |=3D MR_WITH_NETBITS;
+            a=
ddr=2Enetbits =3D (uint8_t)ir->netbits;
+            multi_reinstall_owned_=
dco_iroute(m, mi, &addr);
+        }
+    }
+
+    if ((flags & (1 << AF_IN=
ET6)) && mi->context=2Ec2=2Epush_ifconfig_ipv6_defined)
+    {
+        for=
 (const struct iroute_ipv6 *ir6 =3D mi->context=2Eoptions=2Eiroutes_ipv6; i=
r6; ir6 =3D ir6->next)
+        {
+            struct mroute_addr addr =3D =
{ 0 };
+            addr=2Etype =3D MR_ADDR_IPV6 | MR_WITH_NETBITS;
+      =
      addr=2Elen =3D 16;
+            addr=2Enetbits =3D (uint8_t)ir6->netb=
its;
+            addr=2Ev6=2Eaddr =3D ir6->network;
+            mroute_ad=
dr_mask_host_bits(&addr);
+            multi_reinstall_owned_dco_iroute(m, =
mi, &addr);
+        }
+    }
+}
+
 /**
- * Update the vhash when a push-up=
date message containing
- * ifconfig/ifconfig-ipv6 options is sent from the=
 server=2E
+ * Update the vhash and DCO peer addresses when a push-update m=
essage containing
+ * ifconfig/ifconfig-ipv6 options is sent from the serve=
r=2E Preserve userspace
+ * iroutes and reinstall their DCO routes with the=
 new IP if needed=2E
  *
  * @param m         The multi_context
  * @param =
mi        The multi_instance of the client we are updating
@@ -4469,15 +451=
6,20 @@
 void
 update_vaddr(struct multi_context *m, struct multi_instance =
*mi, const char *new_ip, const char *new_ipv6)
 {
+    /* Track changed add=
ress families to avoid resetting unchanged DCO addresses=2E */
+    int upd=
ate_flags =3D 0;
+
     /* -ifconfig */
     if (!new_ip && mi->context=2Ec=
2=2Epush_ifconfig_defined)
     {
         unlearn_ifconfig(m, mi);
+      =
  update_flags |=3D (1 << AF_INET);
     }
     /* -ifconfig-ipv6 */
     i=
f (!new_ipv6 && mi->context=2Ec2=2Epush_ifconfig_ipv6_defined)
     {
     =
    unlearn_ifconfig_ipv6(m, mi);
+        update_flags |=3D (1 << AF_INET6=
);
     }
 
     if (new_ip)
@@ -4491,6 +4543,7 @@
             if (mi->con=
text=2Ec2=2Epush_ifconfig_defined)
             {
                 unlearn_=
ifconfig(m, mi);
+                update_flags |=3D (1 << AF_INET);
       =
      }
 
             /* DCO needs the new address while installing its on=
-link route=2E */
@@ -4500,6 +4553,7 @@
             {
                 /* =
set our client's VPN endpoint for status reporting purposes */
            =
     mi->reporting_addr =3D mi->context=2Ec2=2Epush_ifconfig_local;
+      =
          update_flags |=3D (1 << AF_INET);
             }
             els=
e
             {
@@ -4527,6 +4581,7 @@
             if (mi->context=2Ec2=2E=
push_ifconfig_ipv6_defined)
             {
                 unlearn_ifconfi=
g_ipv6(m, mi);
+                update_flags |=3D (1 << AF_INET6);
        =
     }
 
             /* DCO needs the new address while installing its on-=
link route=2E */
@@ -4536,6 +4591,7 @@
             {
                 /* s=
et our client's VPN endpoint for status reporting purposes */
             =
    mi->reporting_addr_ipv6 =3D mi->context=2Ec2=2Epush_ifconfig_ipv6_local=
;
+                update_flags |=3D (1 << AF_INET6);
             }
      =
       else
             {
@@ -4551,6 +4607,28 @@
             }
         }=

     }
+
+    if (!update_flags || !dco_enabled(&m->top=2Eoptions))
+    {=

+        return;
+    }
+
+#if defined(TARGET_LINUX)
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
+        return;
+    }
+#endif
+
=
+    if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
+    {=

+        multi_reinstall_dco_iroutes(m, mi, update_flags);
+    }
 }
 
 bo=
ol
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index=
 c0ecd1b=2E=2E95f3a9c 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/open=
vpn/push_util=2Ec
@@ -256,12 +256,14 @@
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
@@ -304,6 +306,7 =
@@
         }
 
         if (!mi->halt
+            && !event_timeout_defin=
ed(&mi->context=2Ec2=2Escheduled_exit)
             && send_single_push_upd=
ate(m, mi, msgs))
         {
             buffer_list_free(msgs);
@@ -324,7=
 +327,9 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I24589d5158f67febd3c25af029=
944d3f1da32763
Gerrit-Change-Number: 2063
Gerrit-PatchSet: 1
Gerrit-Owner: =
Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--/CKwlQ1NIRQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Marco Baffo would like Arne S=
chwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail">View Change</a></p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">PUSH_UPDATE: enable Linux DCO address and iroute updates<br><br>=
Remove affected DCO routes before changing virtual addresses, synchronize<b=
r>the changed families with the Linux DCO peer, and reinstall only iroutes<=
br>still owned by this client=2E Preserve the userspace iroutes=2E<br>Resta=
rt the client if updating the DCO peer fails, allowing the existing<br>sche=
duled-exit check to report the push as failed=2E Skip clients already<br>sc=
heduled to exit=2E<br><br>Change-Id: I24589d5158f67febd3c25af029944d3f1da32=
763<br>Signed-off-by: Marco Baffo &lt;marco@mandelbit=2Ecom&gt;<br>---<br>M=
 src/openvpn/multi=2Ec<br>M src/openvpn/push_util=2Ec<br>2 files changed, 8=
6 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/2063/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e=
deef96=2E=2E093b98a 100644</span><br><span>--- a/src/openvpn/multi=2Ec</spa=
n><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -4436,6 +4436,7 =
@@</span><br><span> static void</span><br><span> unlearn_ifconfig(struct mu=
lti_context *m, struct multi_instance *mi)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    multi_del_dco_iroutes_v4(m, m=
i);</span><br><span>     in_addr_t old_addr =3D 0;</span><br><span>     old=
_addr =3D htonl(mi-&gt;context=2Ec2=2Epush_ifconfig_local);</span><br><span=
>     multi_unlearn_in_addr_t(m, mi, old_addr);</span><br><span>@@ -4448,6 =
+4449,7 @@</span><br><span> static void</span><br><span> unlearn_ifconfig_i=
pv6(struct multi_context *m, struct multi_instance *mi)</span><br><span> {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_del_dco_ir=
outes_v6(m, mi);</span><br><span>     struct in6_addr old_addr6;</span><br>=
<span>     CLEAR(old_addr6);</span><br><span>     old_addr6 =3D mi-&gt;cont=
ext=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span>@@ -4457,9 +4459,54 @@=
</span><br><span>     CLEAR(mi-&gt;reporting_addr_ipv6);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Reinstall only routes that are still owned by this client=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+multi_reinstall_owned_dco_iroute(stru=
ct multi_context *m, struct multi_instance *mi,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                 const struct m=
route_addr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct mul=
ti_route *route =3D hash_lookup(m-&gt;vhash, addr);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (route &amp;&amp; route-&gt;instan=
ce =3D=3D mi &amp;&amp; multi_route_defined(m, route))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        dco_install_iroute(m, mi, addr);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Usersp=
ace iroutes do not depend on the client&#39;s VPN address=2E Only their</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * DCO routes need to b=
e reinstalled when the gateway changes=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+multi_reinstall_dco_iroutes(struct multi_context *m, struc=
t multi_instance *mi, int flags)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f ((flags &amp; (1 &lt;&lt; AF_INET)) &amp;&amp; mi-&gt;context=2Ec2=2Epush=
_ifconfig_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (co=
nst struct iroute *ir =3D mi-&gt;context=2Eoptions=2Eiroutes; ir; ir =3D ir=
-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct =
mroute_addr addr =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            mroute_extract_in_addr_t(&amp;addr, ir-&gt;network);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            addr=2Etyp=
e |=3D MR_WITH_NETBITS;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            addr=2Enetbits =3D (uint8_t)ir-&gt;netbits;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            multi_reinstall_owned_d=
co_iroute(m, mi, &amp;addr);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if ((flags &amp; (1 &lt;&lt; A=
F_INET6)) &amp;&amp; mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        for (const struct iroute_ipv6 =
*ir6 =3D mi-&gt;context=2Eoptions=2Eiroutes_ipv6; ir6; ir6 =3D ir6-&gt;next=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            struct mroute_ad=
dr addr =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           addr=2Etype =3D MR_ADDR_IPV6 | MR_WITH_NETBITS;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            addr=2Elen =3D 16;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            addr=2Enetbit=
s =3D (uint8_t)ir6-&gt;netbits;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            addr=2Ev6=2Eaddr =3D ir6-&gt;network;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            mroute_addr_mask_host=
_bits(&amp;addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          multi_reinstall_owned_dco_iroute(m, mi, &amp;addr);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * Update the vhash when a push-update message containing</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * ifconfig/ifconfig-ipv6 options is =
sent from the server=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Update the vhash and DCO peer addresses when a push-update message c=
ontaining</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ifconfi=
g/ifconfig-ipv6 options is sent from the server=2E Preserve userspace</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * iroutes and reinstall =
their DCO routes with the new IP if needed=2E</span><br><span>  *</span><br=
><span>  * @param m         The multi_context</span><br><span>  * @param mi=
        The multi_instance of the client we are updating</span><br><span>@@=
 -4469,15 +4516,20 @@</span><br><span> void</span><br><span> update_vaddr(s=
truct multi_context *m, struct multi_instance *mi, const char *new_ip, cons=
t char *new_ipv6)</span><br><span> {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Track changed address families to avoid resetting u=
nchanged DCO addresses=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int update_flags =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span>     /* -ifconfig */</span><br><span>    =
 if (!new_ip &amp;&amp; mi-&gt;context=2Ec2=2Epush_ifconfig_defined)</span>=
<br><span>     {</span><br><span>         unlearn_ifconfig(m, mi);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        update_flags |=3D (1=
 &lt;&lt; AF_INET);</span><br><span>     }</span><br><span>     /* -ifconfi=
g-ipv6 */</span><br><span>     if (!new_ipv6 &amp;&amp; mi-&gt;context=2Ec2=
=2Epush_ifconfig_ipv6_defined)</span><br><span>     {</span><br><span>     =
    unlearn_ifconfig_ipv6(m, mi);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        update_flags |=3D (1 &lt;&lt; AF_INET6);</span><br><s=
pan>     }</span><br><span> </span><br><span>     if (new_ip)</span><br><sp=
an>@@ -4491,6 +4543,7 @@</span><br><span>             if (mi-&gt;context=2E=
c2=2Epush_ifconfig_defined)</span><br><span>             {</span><br><span>=
                 unlearn_ifconfig(m, mi);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                update_flags |=3D (1 &lt;&lt; AF_INET=
);</span><br><span>             }</span><br><span> </span><br><span>       =
      /* DCO needs the new address while installing its on-link route=2E */=
</span><br><span>@@ -4500,6 +4553,7 @@</span><br><span>             {</span=
><br><span>                 /* set our client&#39;s VPN endpoint for status=
 reporting purposes */</span><br><span>                 mi-&gt;reporting_ad=
dr =3D mi-&gt;context=2Ec2=2Epush_ifconfig_local;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                update_flags |=3D (1 &lt;&lt;=
 AF_INET);</span><br><span>             }</span><br><span>             else=
</span><br><span>             {</span><br><span>@@ -4527,6 +4581,7 @@</span=
><br><span>             if (mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_define=
d)</span><br><span>             {</span><br><span>                 unlearn_=
ifconfig_ipv6(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                update_flags |=3D (1 &lt;&lt; AF_INET6);</span><br><span>=
             }</span><br><span> </span><br><span>             /* DCO needs =
the new address while installing its on-link route=2E */</span><br><span>@@=
 -4536,6 +4591,7 @@</span><br><span>             {</span><br><span>        =
         /* set our client&#39;s VPN endpoint for status reporting purposes=
 */</span><br><span>                 mi-&gt;reporting_addr_ipv6 =3D mi-&gt;=
context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                update_flags |=3D (1 &lt;&lt; AF_INET6=
);</span><br><span>             }</span><br><span>             else</span><=
br><span>             {</span><br><span>@@ -4551,6 +4607,28 @@</span><br><s=
pan>             }</span><br><span>         }</span><br><span>     }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!update_flags || !dco_enabled(&amp;m-=
&gt;top=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int ret =3D dco_multi_update_peer_addr(&a=
mp;mi-&gt;context, update_flags);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(M_WARN, &quot;MULTI: failed to update DCO peer addresses (error=
 %d)&quot;, ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* PUSH_UPDATE is already queued, so reconnect to restore consistent =
state=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
send_restart(&amp;mi-&gt;context, NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        multi_schedule_context_wakeup(m, mi);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        multi_reinstall_dco_iroutes(m, mi=
, update_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span> }</span><br><span> </span><br><span> bool</span><br><sp=
an>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span=
><br><span>index c0ecd1b=2E=2E95f3a9c 100644</span><br><span>--- a/src/open=
vpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span><br=
><span>@@ -256,12 +256,14 @@</span><br><span> static int</span><br><span> s=
end_push_update(struct multi_context *m, const void *target, const char *ms=
g, const push_update_type type, const size_t push_bundle_size)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(=
TARGET_LINUX)</span><br><span>     if (dco_enabled(&amp;m-&gt;top=2Eoptions=
))</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;WARN: =
PUSH_UPDATE messages cannot currently be sent while DCO is enabled=2E&quot;=
</span><br><span>                     &quot; To send a PUSH_UPDATE message,=
 be sure to use the --disable-dco option=2E&quot;);</span><br><span>       =
  return 0;</span><br><span>     }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span> </span><br><span>     if (!msg || !*=
msg || !m || (!target &amp;&amp; type !=3D UPT_BROADCAST))</span><br><span>=
     {</span><br><span>@@ -304,6 +306,7 @@</span><br><span>         }</span=
><br><span> </span><br><span>         if (!mi-&gt;halt</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !event_timeout_de=
fined(&amp;mi-&gt;context=2Ec2=2Escheduled_exit)</span><br><span>          =
   &amp;&amp; send_single_push_update(m, mi, msgs))</span><br><span>       =
  {</span><br><span>             buffer_list_free(msgs);</span><br><span>@@=
 -324,7 +327,9 @@</span><br><span>     {</span><br><span>         struct mu=
lti_instance *curr_mi =3D m-&gt;instances[i];</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (!curr_mi || curr_mi-&=
gt;halt || !support_push_update(curr_mi))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (!curr_mi || curr_mi-&gt;halt</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            || event_timeout_def=
ined(&amp;curr_mi-&gt;context=2Ec2=2Escheduled_exit)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            || !support_push_update(curr_=
mi))</span><br><span>         {</span><br><span>             continue;</spa=
n><br><span>         }</span><br></pre><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail">change 2063</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I24589d5158=
f67febd3c25af029944d3f1da32763 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 2063 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: Marco Baffo &lt;marco@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--/CKwlQ1NIRQ=--


--===============8239598798274446731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8239598798274446731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8239598798274446731==--

