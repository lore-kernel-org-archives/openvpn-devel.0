Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA51606C908
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=A1VqNi4g;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mBftBL9h;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=euSTBJht;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QtiaLv2T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LnXD5pfjJpJ47oXkQ85Nup2p+axZByU0vATqxFEpDtI=; b=A1VqNi4gNzyXH6BN/u9JVvU97Q
	LGfugj7DCJxRyFvXJjtarQM8chK4uCcvN/l9wSb3wam+V2Nwy63SATT4iAEp+Ciq2cqo1CwAmppbk
	MSAdKoHmjYcPZCDM1C7b6zAI+qMAxpc31QiuVdO22Yjyw6OuUdzBruJBiEq5YBizDM8c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOiax-000000001oF-2Ib0;
	Wed, 04 Nov 2026 21:32:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOiaT-000000001mQ-05Bj
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 21:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7xd384JaQESXyxfIJuQj9bXKJTc8J56B67BFi/VFBEQ=; b=mBftBL9hJEdTReo7rElpfBOIzn
 Ki6qQb5ubLXdKh3RaryPQ64KXOzwDlCr4JlVE+0kx8vL6sn5ZFIG3JmDSBdiVCReT3oZw0sd0rgXH
 2hPwiFK777lELZrhqrUKF7w+B7Flov6XVeyegqn6/vkMTsfF+tvSuVd0cxYNzZGOXui4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7xd384JaQESXyxfIJuQj9bXKJTc8J56B67BFi/VFBEQ=; b=euSTBJhtqXopwvzyGyKKwOXuBg
 dPCYn3Le3t/FRthBHT9VARSMdQnXnuk/H5Mr5jqkLD3l//9brcg4oFjcyTDFwg3fnlzeu3pby3ydI
 j5RLLEI8GMVeAN5da6FqOv3IS6syMPpZdsFSw6DKek07qTV4JQb7hSbGQ0ISe8XIDVTM=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOiaP-000000001Lk-2ogA for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 21:32:04 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso12485835e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 13:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793827915; x=1794432715; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7xd384JaQESXyxfIJuQj9bXKJTc8J56B67BFi/VFBEQ=;
 b=QtiaLv2TjuCJv/RRP/q8j1NxlkMXBWkWYweRCo+S2lnXxzXkxBfdrIM4j5XU6/oRod
 2RFbc0HjP9YmAVd3Zv3KSb3RBN2GnzUqWWLCVLXURjjRgOp3pYbVcyG0+hEc0Fppa5qQ
 MEQT7bKLzRLYBrFjuGsmGuLu3id8z5yleHmVKQpkjmqFycUAKp8oitJZP1o0mSmVWNvD
 xdPf5H3IgWeSRQkSIa8aB3DpADBQHPSNbGrMXCQdx1HkEn7G04PM5BtQEnrVs3z8JBjK
 A4PiOZVVLAhdtJ7e83sjlgwpeQHBdxDp19zeq2gVBEbyvD0qD5wjRxmAXu0DG/kZtBZO
 KHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793827915; x=1794432715;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7xd384JaQESXyxfIJuQj9bXKJTc8J56B67BFi/VFBEQ=;
 b=DAXt0cBqJT1lSZulTiBW2JH/Zl8G29GMLmrUS/NEs9ZJvdFQyHYNi0SpSi6buqMwuA
 LzODN+ANFiKIHGDOKnhfuaUczEOkjbVEjJa7gv63DH1lhB8Ci8CxxpJ23IOsMRd9t2NQ
 bE4sPHE3IcrmEjy842iwbkC9Wx30ARivCSfMpWLSo1gbxgpq1hKGe7oVfGd8qQoADBlT
 9Lw0cVZwtgze1/2BD8PyKTu9A4V/9j9ZawnnzG9+c7DbWDin+J8/xDnH6NLmhfsIEGJ+
 TgC0Q+0lN9xTspreDz+vqUp8LT3/1Y7STxNmoMQ/ri9da1IC3KOQ+qACzpnXuBQB1W+k
 O2Gw==
X-Gm-Message-State: APuU4Z8298oASIKjX0WtV5YroNo3fTbUT5Ng4FQUUmXHuriFUvX94+t3
 wi0krfn75p0h8o0BWhJx562lLAtPO4EXfWc5NJCoQZeNseDF1RJo31xqNny+DuiWou2gt7nsD38
 WQeu8n18sBl5TM6paAvF3pcABpqbfJWHIEEh8UD7SfWpgw3UULri55VnzGacOGy5UtDrYLhn2QU
 pv+KIm1w==
X-Gm-Gg: AYBFou3dR1ooIEqsR9E67GXqo+hHe47kcUanHD6ARrqNTgTs3zZQGotbz7NAfEZ72fQ
 1kZflQH30oYfh/tLKgKs2od6cJaZEx8cTrLjPS0SQWUA+/46aoErsbobGrfTD0Ug8ErLp75mkpp
 L3qM87WAIeHa+yNmpucJdlkx6xrWS1nMQAorgf5lnKILj71AcII38y+KgjDY97rcKAsd9G81BIw
 TWRRQ4xmAqnuiFPA/rftpjOlvJsPaZY3uwpWgwrjecGUS+1UT6m3V7LzstoZ0kTFTeiMMERNCfF
 zE4KF87aTZ/31BgectkMaxxVw/BIogkUcRN/RuHUVEv7fZ7AEKxDlw9c81QYEv6WQAT1d0Ku+Jn
 SWk4znL8xT3xUjh2ey/HfdXcC0FDJpvGbt3EfpSGhlPJwImH8z/xMorhUCo5WUNIKEbZKj6utgv
 SojJOskfFXOQpxUCpacciuQ8uBWCw9aQtlVPqOFWhNIV1SMPFaH4d3Je9quYN+yzNR18Jm+iUnz
 MfcGIxhXTmX+EXFmn6pjIZubYDNoLixHNK8J+j4g1z/kqv+raL+MrTRRx4SKFpZs/eNrbRblOf1
 3L57W6I2UXf5yan8x/AhH+1Tyx5knPK+BdWhz7N5ckuA8Ay5q/LFjm7LgTGtVcWfal8uoPIwK1K
 rIChy/NkAs1LXzD3dOT3XavLenFoOBwmRRbBWBX7+5ORch/HDkjvk9yQc3JXZsoCJcOZG85HgVR
 NP2NhAZlQI3wJG85VtHAcchNHy6fna+FZatJ0=
X-Received: by 2002:a05:600c:6208:b0:4a2:397:73fd with SMTP id
 5b1f17b1804b1-4ac182dc32cmr387700455e9.12.1793827914910; 
 Wed, 04 Nov 2026 13:31:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b57317cae5sm18676045e9.12.2026.11.04.13.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:31:54 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 21:31:50 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I24589d5158f67febd3c25af029944d3f1da32763
X-Gerrit-Change-Number: 2063
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2063?usp=email>
X-Gerrit-Commit: 3b2ce51dcb04b48f6d9e43af9318d73ed1cd7c09
In-Reply-To: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
References: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkkyNDU4OWQ1MTU4ZjY3ZmViZDNjMjVhZjAyOTk0NGQzZjFkYTMyNzYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a02c056d3c692df026dde96fbfa0271a3e4c1ad7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOiaP-000000001Lk-2ogA
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
Content-Type: multipart/mixed; boundary="===============5791145710140517876=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5791145710140517876==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VxlJvFDU0t8="; charset=UTF-8

--VxlJvFDU0t8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo, R=C4=83zva=
n Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to =
reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2063?usp=3Demail

to look at the new patch set (#3)=2E

The followi=
ng approvals got outdated and were removed:
Code-Review-1 by R=C4=83zvan Co=
jocaru


Change subject: PUSH_UPDATE: enable Linux DCO address and iroute u=
pdates
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

PUSH=
_UPDATE: enable Linux DCO address and iroute updates

Remove affected DCO r=
outes before changing virtual addresses, synchronize
the changed families w=
ith the Linux DCO peer, and reinstall only iroutes
still owned by this clie=
nt=2E Preserve the userspace iroutes=2E
Restart the client if updating the =
DCO peer fails=2E

Change-Id: I24589d5158f67febd3c25af029944d3f1da32763
Sig=
ned-off-by: Marco Baffo <marco@mandelbit=2Ecom>
---
M src/openvpn/multi=2Ec=

M src/openvpn/push_util=2Ec
2 files changed, 82 insertions(+), 3 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63=
/2063/3

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index a=
850e72=2E=2E8a4b2e1 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/mu=
lti=2Ec
@@ -4496,6 +4496,7 @@
 static void
 unlearn_ifconfig(struct multi_c=
ontext *m, struct multi_instance *mi)
 {
+    multi_del_dco_iroutes_v4(m, m=
i);
     in_addr_t old_addr =3D 0;
     old_addr =3D htonl(mi->context=2Ec2=
=2Epush_ifconfig_local);
     multi_unlearn_in_addr_t(m, mi, old_addr);
@@ =
-4508,6 +4509,7 @@
 static void
 unlearn_ifconfig_ipv6(struct multi_context=
 *m, struct multi_instance *mi)
 {
+    multi_del_dco_iroutes_v6(m, mi);
  =
   struct in6_addr old_addr6;
     CLEAR(old_addr6);
     old_addr6 =3D mi-=
>context=2Ec2=2Epush_ifconfig_ipv6_local;
@@ -4517,9 +4519,54 @@
     CLEAR=
(mi->reporting_addr_ipv6);
 }
 
+/* Reinstall only routes that are still ow=
ned by this client=2E */
+static void
+multi_reinstall_owned_dco_iroute(str=
uct multi_context *m, struct multi_instance *mi,
+                         =
        const struct mroute_addr *addr)
+{
+    const struct multi_route *r=
oute =3D hash_lookup(m->vhash, addr);
+    if (route && route->instance =3D=
=3D mi && multi_route_defined(m, route))
+    {
+        dco_install_iroute=
(m, mi, addr);
+    }
+}
+
+/* Userspace iroutes do not depend on the clien=
t's VPN address=2E Only their
+ * DCO routes need to be reinstalled when th=
e gateway changes=2E */
+static void
+multi_reinstall_dco_iroutes(struct mu=
lti_context *m, struct multi_instance *mi, int flags)
+{
+    if ((flags & =
(1 << AF_INET)) && mi->context=2Ec2=2Epush_ifconfig_defined)
+    {
+      =
  for (const struct iroute *ir =3D mi->context=2Eoptions=2Eiroutes; ir; ir =
=3D ir->next)
+        {
+            struct mroute_addr addr =3D { 0 };
+ =
           mroute_extract_in_addr_t(&addr, ir->network);
+            addr=
=2Etype |=3D MR_WITH_NETBITS;
+            addr=2Enetbits =3D (uint8_t)ir->=
netbits;
+            multi_reinstall_owned_dco_iroute(m, mi, &addr);
+    =
    }
+    }
+
+    if ((flags & (1 << AF_INET6)) && mi->context=2Ec2=2Epus=
h_ifconfig_ipv6_defined)
+    {
+        for (const struct iroute_ipv6 *ir6=
 =3D mi->context=2Eoptions=2Eiroutes_ipv6; ir6; ir6 =3D ir6->next)
+       =
 {
+            struct mroute_addr addr =3D { 0 };
+            addr=2Etype=
 =3D MR_ADDR_IPV6 | MR_WITH_NETBITS;
+            addr=2Elen =3D 16;
+     =
       addr=2Enetbits =3D (uint8_t)ir6->netbits;
+            addr=2Ev6=2Ea=
ddr =3D ir6->network;
+            mroute_addr_mask_host_bits(&addr);
+    =
        multi_reinstall_owned_dco_iroute(m, mi, &addr);
+        }
+    }
+=
}
+
 /**
- * Update the vhash when a push-update message containing
- * ifc=
onfig/ifconfig-ipv6 options is sent from the server=2E
+ * Update the vhash=
 and DCO peer addresses when a push-update message containing
+ * ifconfig/=
ifconfig-ipv6 options is sent from the server=2E Preserve userspace
+ * iro=
utes and reinstall their DCO routes with the new IP if needed=2E
  *
  * @p=
aram m         The multi_context
  * @param mi        The multi_instance of=
 the client we are updating
@@ -4531,15 +4578,20 @@
 bool
 update_vaddr(str=
uct multi_context *m, struct multi_instance *mi, const char *new_ip, const =
char *new_ipv6)
 {
+    /* Track changed address families to avoid resettin=
g unchanged DCO addresses=2E */
+    int update_flags =3D 0;
+
     /* -ifc=
onfig */
     if (!new_ip && mi->context=2Ec2=2Epush_ifconfig_defined)
    =
 {
         unlearn_ifconfig(m, mi);
+        update_flags |=3D (1 << AF_IN=
ET);
     }
     /* -ifconfig-ipv6 */
     if (!new_ipv6 && mi->context=2Ec=
2=2Epush_ifconfig_ipv6_defined)
     {
         unlearn_ifconfig_ipv6(m, mi=
);
+        update_flags |=3D (1 << AF_INET6);
     }
 
     if (new_ip)
@@=
 -4553,6 +4605,7 @@
             if (mi->context=2Ec2=2Epush_ifconfig_defin=
ed)
             {
                 unlearn_ifconfig(m, mi);
+             =
   update_flags |=3D (1 << AF_INET);
             }
 
             /* DCO n=
eeds the new address while installing its on-link route=2E */
@@ -4562,6 +4=
615,7 @@
             {
                 /* set our client's VPN endpoint f=
or status reporting purposes */
                 mi->reporting_addr =3D mi-=
>context=2Ec2=2Epush_ifconfig_local;
+                update_flags |=3D (1 =
<< AF_INET);
             }
             else
             {
@@ -4589,6 +46=
43,7 @@
             if (mi->context=2Ec2=2Epush_ifconfig_ipv6_defined)
   =
          {
                 unlearn_ifconfig_ipv6(m, mi);
+               =
 update_flags |=3D (1 << AF_INET6);
             }
 
             /* DCO ne=
eds the new address while installing its on-link route=2E */
@@ -4598,6 +46=
53,7 @@
             {
                 /* set our client's VPN endpoint fo=
r status reporting purposes */
                 mi->reporting_addr_ipv6 =3D=
 mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
+                update_flags=
 |=3D (1 << AF_INET6);
             }
             else
             {
@@ -=
4613,6 +4669,24 @@
             }
         }
     }
+
+    if (!update_flag=
s || !dco_enabled(&m->top=2Eoptions))
+    {
+        return true;
+    }
+=

+    int ret =3D dco_multi_update_peer_addr(&mi->context, update_flags);
+=
    if (ret < 0)
+    {
+        msg(M_WARN, "MULTI: failed to update DCO p=
eer addresses (error %d)", ret);
+        /* PUSH_UPDATE is already queued,=
 so reconnect to restore consistent state=2E */
+        send_restart(&mi->=
context, NULL);
+        multi_schedule_context_wakeup(m, mi);
+        ret=
urn false;
+    }
+
+    multi_reinstall_dco_iroutes(m, mi, update_flags);
=
+
     return true;
 }
 
diff --git a/src/openvpn/push_util=2Ec b/src/openv=
pn/push_util=2Ec
index cd940fb=2E=2Eaa77583 100644
--- a/src/openvpn/push_u=
til=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -255,12 +255,14 @@
 static int
 =
send_push_update(struct multi_context *m, const void *target, const char *m=
sg, const push_update_type type, const size_t push_bundle_size)
 {
+#if !de=
fined(TARGET_LINUX)
     if (dco_enabled(&m->top=2Eoptions))
     {
       =
  msg(M_WARN, "WARN: PUSH_UPDATE messages cannot currently be sent while DC=
O is enabled=2E"
                     " To send a PUSH_UPDATE message, be s=
ure to use the --disable-dco option=2E");
         return 0;
     }
+#endif=

 
     if (!msg || !*msg || !m || (!target && type !=3D UPT_BROADCAST))
  =
   {
@@ -303,6 +305,7 @@
         }
 
         if (!mi->halt
+            &=
& !event_timeout_defined(&mi->context=2Ec2=2Escheduled_exit)
             &=
& send_single_push_update(m, mi, msgs))
         {
             buffer_list=
_free(msgs);
@@ -323,7 +326,9 @@
     {
         struct multi_instance *cur=
r_mi =3D m->instances[i];
 
-        if (!curr_mi || curr_mi->halt || !supp=
ort_push_update(curr_mi))
+        if (!curr_mi || curr_mi->halt
+         =
   || event_timeout_defined(&curr_mi->context=2Ec2=2Escheduled_exit)
+     =
       || !support_push_update(curr_mi))
         {
             continue;
=
         }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
063?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I245=
89d5158f67febd3c25af029944d3f1da32763
Gerrit-Change-Number: 2063
Gerrit-Pat=
chSet: 3
Gerrit-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Marco Baffo <marco@mandelbit=2Ecom>=

Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atte=
ntion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--VxlJvFDU0t8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo, R=C4=83zvan Cojocaru=2E </=
p>
<p>Marco Baffo <strong>uploaded patch set #3</strong> to this change=2E<=
/p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demai=
l">View Change</a></p><p>The following approvals got outdated and were remo=
ved:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">PUSH_UPDATE: =
enable Linux DCO address and iroute updates<br><br>Remove affected DCO rout=
es before changing virtual addresses, synchronize<br>the changed families w=
ith the Linux DCO peer, and reinstall only iroutes<br>still owned by this c=
lient=2E Preserve the userspace iroutes=2E<br>Restart the client if updatin=
g the DCO peer fails=2E<br><br>Change-Id: I24589d5158f67febd3c25af029944d3f=
1da32763<br>Signed-off-by: Marco Baffo &lt;marco@mandelbit=2Ecom&gt;<br>---=
<br>M src/openvpn/multi=2Ec<br>M src/openvpn/push_util=2Ec<br>2 files chang=
ed, 82 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/2063/3</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>ind=
ex a850e72=2E=2E8a4b2e1 100644</span><br><span>--- a/src/openvpn/multi=2Ec<=
/span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -4496,6 +449=
6,7 @@</span><br><span> static void</span><br><span> unlearn_ifconfig(struc=
t multi_context *m, struct multi_instance *mi)</span><br><span> {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    multi_del_dco_iroutes_v4(=
m, mi);</span><br><span>     in_addr_t old_addr =3D 0;</span><br><span>    =
 old_addr =3D htonl(mi-&gt;context=2Ec2=2Epush_ifconfig_local);</span><br><=
span>     multi_unlearn_in_addr_t(m, mi, old_addr);</span><br><span>@@ -450=
8,6 +4509,7 @@</span><br><span> static void</span><br><span> unlearn_ifconf=
ig_ipv6(struct multi_context *m, struct multi_instance *mi)</span><br><span=
> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_del_dc=
o_iroutes_v6(m, mi);</span><br><span>     struct in6_addr old_addr6;</span>=
<br><span>     CLEAR(old_addr6);</span><br><span>     old_addr6 =3D mi-&gt;=
context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span>@@ -4517,9 +4519,5=
4 @@</span><br><span>     CLEAR(mi-&gt;reporting_addr_ipv6);</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Reinstall only routes that are still owned by this client=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+multi_reinstall_owned_dco_iroute(=
struct multi_context *m, struct multi_instance *mi,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                 const st=
ruct mroute_addr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const stru=
ct multi_route *route =3D hash_lookup(m-&gt;vhash, addr);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (route &amp;&amp; route-&gt;in=
stance =3D=3D mi &amp;&amp; multi_route_defined(m, route))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        dco_install_iroute(m, mi, addr);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Userspace iroutes do not depend on the client&#39;s VPN address=2E Only the=
ir</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * DCO routes nee=
d to be reinstalled when the gateway changes=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+multi_reinstall_dco_iroutes(struct multi_context *m,=
 struct multi_instance *mi, int flags)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if ((flags &amp; (1 &lt;&lt; AF_INET)) &amp;&amp; mi-&gt;context=2Ec2=
=2Epush_ifconfig_defined)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
for (const struct iroute *ir =3D mi-&gt;context=2Eoptions=2Eiroutes; ir; ir=
 =3D ir-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
struct mroute_addr addr =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            mroute_extract_in_addr_t(&amp;addr, ir-&gt;netwo=
rk);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            add=
r=2Etype |=3D MR_WITH_NETBITS;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            addr=2Enetbits =3D (uint8_t)ir-&gt;netbits;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            multi_reinstall_=
owned_dco_iroute(m, mi, &amp;addr);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((flags &amp; (1 &lt=
;&lt; AF_INET6)) &amp;&amp; mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_define=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        for (const struct irout=
e_ipv6 *ir6 =3D mi-&gt;context=2Eoptions=2Eiroutes_ipv6; ir6; ir6 =3D ir6-&=
gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct mr=
oute_addr addr =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            addr=2Etype =3D MR_ADDR_IPV6 | MR_WITH_NETBITS;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            addr=2Elen =3D 16=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            addr=
=2Enetbits =3D (uint8_t)ir6-&gt;netbits;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            addr=2Ev6=2Eaddr =3D ir6-&gt;network;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            mroute_addr_=
mask_host_bits(&amp;addr);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            multi_reinstall_owned_dco_iroute(m, mi, &amp;addr);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Update the vhash when a push-update message containing</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * ifconfig/ifconfig-ipv6 opti=
ons is sent from the server=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Update the vhash and DCO peer addresses when a push-update me=
ssage containing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
ifconfig/ifconfig-ipv6 options is sent from the server=2E Preserve userspac=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * iroutes and rei=
nstall their DCO routes with the new IP if needed=2E</span><br><span>  *</s=
pan><br><span>  * @param m         The multi_context</span><br><span>  * @p=
aram mi        The multi_instance of the client we are updating</span><br><=
span>@@ -4531,15 +4578,20 @@</span><br><span> bool</span><br><span> update_=
vaddr(struct multi_context *m, struct multi_instance *mi, const char *new_i=
p, const char *new_ipv6)</span><br><span> {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* Track changed address families to avoid rese=
tting unchanged DCO addresses=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int update_flags =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>     /* -ifconfig */</span><br><sp=
an>     if (!new_ip &amp;&amp; mi-&gt;context=2Ec2=2Epush_ifconfig_defined)=
</span><br><span>     {</span><br><span>         unlearn_ifconfig(m, mi);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        update_flags =
|=3D (1 &lt;&lt; AF_INET);</span><br><span>     }</span><br><span>     /* -=
ifconfig-ipv6 */</span><br><span>     if (!new_ipv6 &amp;&amp; mi-&gt;conte=
xt=2Ec2=2Epush_ifconfig_ipv6_defined)</span><br><span>     {</span><br><spa=
n>         unlearn_ifconfig_ipv6(m, mi);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        update_flags |=3D (1 &lt;&lt; AF_INET6);</span=
><br><span>     }</span><br><span> </span><br><span>     if (new_ip)</span>=
<br><span>@@ -4553,6 +4605,7 @@</span><br><span>             if (mi-&gt;con=
text=2Ec2=2Epush_ifconfig_defined)</span><br><span>             {</span><br=
><span>                 unlearn_ifconfig(m, mi);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                update_flags |=3D (1 &lt;&lt; =
AF_INET);</span><br><span>             }</span><br><span> </span><br><span>=
             /* DCO needs the new address while installing its on-link rout=
e=2E */</span><br><span>@@ -4562,6 +4615,7 @@</span><br><span>             =
{</span><br><span>                 /* set our client&#39;s VPN endpoint for=
 status reporting purposes */</span><br><span>                 mi-&gt;repor=
ting_addr =3D mi-&gt;context=2Ec2=2Epush_ifconfig_local;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                update_flags |=3D (1 &=
lt;&lt; AF_INET);</span><br><span>             }</span><br><span>          =
   else</span><br><span>             {</span><br><span>@@ -4589,6 +4643,7 @=
@</span><br><span>             if (mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6=
_defined)</span><br><span>             {</span><br><span>                 u=
nlearn_ifconfig_ipv6(m, mi);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                update_flags |=3D (1 &lt;&lt; AF_INET6);</span><br=
><span>             }</span><br><span> </span><br><span>             /* DCO=
 needs the new address while installing its on-link route=2E */</span><br><=
span>@@ -4598,6 +4653,7 @@</span><br><span>             {</span><br><span> =
                /* set our client&#39;s VPN endpoint for status reporting p=
urposes */</span><br><span>                 mi-&gt;reporting_addr_ipv6 =3D =
mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                update_flags |=3D (1 &lt;&lt; A=
F_INET6);</span><br><span>             }</span><br><span>             else<=
/span><br><span>             {</span><br><span>@@ -4613,6 +4669,24 @@</span=
><br><span>             }</span><br><span>         }</span><br><span>     }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!update_flags || !dco_enabled(=
&amp;m-&gt;top=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco_multi_update_peer_a=
ddr(&amp;mi-&gt;context, update_flags);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_WARN, &quot;MULTI: failed to update DCO peer addresses =
(error %d)&quot;, ret);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* PUSH_UPDATE is already queued, so reconnect to restore consi=
stent state=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      send_restart(&amp;mi-&gt;context, NULL);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        multi_schedule_context_wakeup(m, mi);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    multi_reinstall_dco_iroutes(m, mi, update_flags);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   return true;</span><br><span> }</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span><br><spa=
n>index cd940fb=2E=2Eaa77583 100644</span><br><span>--- a/src/openvpn/push_=
util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span><br><span>@@=
 -255,12 +255,14 @@</span><br><span> static int</span><br><span> send_push_=
update(struct multi_context *m, const void *target, const char *msg, const =
push_update_type type, const size_t push_bundle_size)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_LI=
NUX)</span><br><span>     if (dco_enabled(&amp;m-&gt;top=2Eoptions))</span>=
<br><span>     {</span><br><span>         msg(M_WARN, &quot;WARN: PUSH_UPDA=
TE messages cannot currently be sent while DCO is enabled=2E&quot;</span><b=
r><span>                     &quot; To send a PUSH_UPDATE message, be sure =
to use the --disable-dco option=2E&quot;);</span><br><span>         return =
0;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span> </span><br><span>     if (!msg || !*msg || !m=
 || (!target &amp;&amp; type !=3D UPT_BROADCAST))</span><br><span>     {</s=
pan><br><span>@@ -303,6 +305,7 @@</span><br><span>         }</span><br><spa=
n> </span><br><span>         if (!mi-&gt;halt</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            &amp;&amp; !event_timeout_defined(&am=
p;mi-&gt;context=2Ec2=2Escheduled_exit)</span><br><span>             &amp;&=
amp; send_single_push_update(m, mi, msgs))</span><br><span>         {</span=
><br><span>             buffer_list_free(msgs);</span><br><span>@@ -323,7 +=
326,9 @@</span><br><span>     {</span><br><span>         struct multi_insta=
nce *curr_mi =3D m-&gt;instances[i];</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (!curr_mi || curr_mi-&gt;halt |=
| !support_push_update(curr_mi))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (!curr_mi || curr_mi-&gt;halt</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            || event_timeout_defined(&amp=
;curr_mi-&gt;context=2Ec2=2Escheduled_exit)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            || !support_push_update(curr_mi))</span=
><br><span>         {</span><br><span>             continue;</span><br><spa=
n>         }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2063?usp=3Demail">change 2063</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I24589d5158f67febd=
3c25af029944d3f1da32763 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2063 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Marco Baffo &lt;marco@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--VxlJvFDU0t8=--


--===============5791145710140517876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5791145710140517876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5791145710140517876==--

