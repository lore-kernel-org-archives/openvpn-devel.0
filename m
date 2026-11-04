Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3715606D814
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JCzCMPLr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mMkoo+LL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=huELYXpj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CNih3egG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=a3o446vMvKkqopRgds9gLwGKzNxu8vIf/16tEHciZ4A=; b=JCzCMPLrywa9tGK5iG7uLDoww/
	VB7MhMbgMLuEFt9nVVbZwCbDhvWAiss4VnOwfbClnxwNVQ9TGy4KEbi56erlQmCDv7GQNhIDXguzE
	rgSo1ifzwcgxMXjIou0dWlzXjVlE8KadXwZKhPeSovfN5CeRRrPV8G2ufAmJEkbd+o0Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOdqH-000000006eP-21dq;
	Wed, 04 Nov 2026 16:28:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOdqF-000000006eH-3RAi
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:28:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mJZkFqGUoQxflDk2l7frKgfOmrHoqT+BDLE2EGy4sWg=; b=mMkoo+LLGjFEfFbZ01Pxk/puKe
 UEs1JE+edW+khYp50KdSUZf52nri9NriQUOe7ZyxMyTBEroF0D6apA6rfF0Iy4815VwhdOnyUKRfY
 oecHHTvjpe9WtaGirUN4j6IPvEA0W2AcJ/xqCs8F6K6OmL8vhyDjKH2Z63QO7qvZvmGQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mJZkFqGUoQxflDk2l7frKgfOmrHoqT+BDLE2EGy4sWg=; b=huELYXpjWerjy19z/pNrfmlepP
 61wnCaZVeFx9XTdl+WBwJRO+IjEDSlzGgZJ405895njw8AEhEEYdL4U+J+pl9rkNOkPZAIOkHMpYc
 3/nTyBimmDGEDZO6hUd0D957RuImelPfQVJwDumdwamtylIvGRQ779Wly1WrkkF8TYKc=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOdqD-000000000a1-32Lo for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:28:03 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so8614395e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793809675; x=1794414475; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mJZkFqGUoQxflDk2l7frKgfOmrHoqT+BDLE2EGy4sWg=;
 b=CNih3egGNcch6twhYzQdusOnHWpeY2YcrAadGnWfWS4kXXLjnKaCF9fx1qODmITAS7
 jhCKPQ6xWUEBg1rI1qNgkjbiGHn85PfZnN743rTb/rhDHwj/fU0THkJPitycgK6fE23X
 CeN1dlNkAs2UEFG7+OtR7r//G22/ARlRi795lQ4u5oIBGn+l1dYo7yiLi2lP4BrFuemG
 Ic4zsOUJitBj2J8LY6XyX1T/by7QI9AvAMv1muwZZxQu4bRS8YoBRN3LkwHzxsTD4YiJ
 OPxrFe2NdC9WEK5eQyGK3f/1ZuyRaEIMzS9Akc+a3bjg28hv/EklV7hMeROo/EY/xY4R
 GOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793809675; x=1794414475;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mJZkFqGUoQxflDk2l7frKgfOmrHoqT+BDLE2EGy4sWg=;
 b=VMnrqgpvzzSo/0ey+bexNEWQ81+/CSxZxU6bU6Eqsc/wTrc4t0iEvXWBfJUfSN0Ons
 RQItUA0xjXnGNhKwnUF9pO/vZnxVE4onDL77SCIk3C3jIXrH43ihk4X0eMhEwYaRIHRc
 Yzp9M0hYwvE4tGVB6Bwp38Z0VWv7hF3S3Pa5YiLsBKT2XfqtWthIPeu/KeoKQCuAj6MX
 dSjGVmKicffrx6hFdBUPOPqtydAf2vx9LlAohSPyEdXOqGQ4j1QFe3s1VIu+8KpcGb/0
 EotjmfYm0ZaKJDVT3Sf5ecy7nklismChQrmp1mzkdKw/sOWSZFck06SN+YOdyZFoacoU
 bmGw==
X-Gm-Message-State: APuU4Z9YV4ymsxQOlbJ36RbyDj4FsKSLYzoTXewu9um2kO69Gn8OlDdx
 FcCIIjlpQo8vqDXqLgI9pBeBwM8z/st/veaN+KqrxAHi/TxV2cUH8GOE2hwezkkFJ4aYMTBBL/O
 I8f23mvPMMOFFZ+sb038pJiVWXCgjUalIKokj0aWiJyNln9FvBWSeI9/iuLHGdU8ynDJQ
X-Gm-Gg: AYBFou0DdOz3O+VyEsX8qxtJs3ONZaG9ktq2QJI6CBzV6rHTVGXF26GQtNTO8TBWgsh
 wlMmTIcVTmIHE2nPSlqQ90DOUMK902CskDGmSyE4H+p31/oNzp3uNmuPDrdSyEwBJ/iQ7d3Kwng
 luW8YVKwHRhuqTgCYdlAKPsKrOOhEFvs8LSYU0LZWHlAXYycP+qnQJGlbmvlbRwm+zRdWw0uG8D
 eZs+TrNIY8JDJU0j/Y9N6bHP3r3zrpXKHbSx7CmuGTRydKgmquiOkr9Erz3kq+MYKkfYu9aVzGO
 AN0Q0oEg3QewwSsmAmciL4Qs8kTs09vKUEPDNNSTVTa0iizy726WC22RxdU3icfWfcekyN4TMyK
 Bkcyd1lOPqFoo7UwsLok1jsE7bJ70h8OMVW/LTnHglNHxgczHftiSb+gcu3HwprUjfCI/KqNJOZ
 4gC9GvsH3E80InSWqlAUHJ945uMoEV+qnPanEqLHVp9e7I++4vUyShbUKA5PlTOqQwtHnU2AFtl
 oKBJIYUChYzesVj59Coox1vQNENXHlsP/WTGyD4U2IwSRHczWrpJTnEJxIrqsRo/krzfJsaIbL1
 E5vzyGA0mIVfweOsnwdhNwTdx6nH8uxN6KPwEj5g+PBuGuxNsejguBJ3CXYkMTieeZ9QWOVHhct
 j5wym60KlwNgarSakdpYD/K6c/AgURYxFBsQEURDVhTF/IowwVph8nq09bMA44sudNEnraIyH/a
 fFa0HNW5SXVjMM4w==
X-Received: by 2002:a05:600c:5d6:b0:49e:795e:ba89 with SMTP id
 5b1f17b1804b1-4aa8a0f4e16mr308015675e9.6.1793809674883; 
 Wed, 04 Nov 2026 08:27:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feea5d4e4sm4626764f8f.57.2026.11.04.08.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:27:54 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:27:50 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e
X-Gerrit-Change-Number: 2060
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2060?usp=email>
X-Gerrit-Commit: d05b45d95c175c9b892c157f6c4e3fa6283a7ba6
In-Reply-To: <gerrit.1793194671000.I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e@gerrit.openvpn.net>
References: <gerrit.1793194671000.I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkk3NWJhNzdmY2JiMTE3OTBjN2NjODZjYzQzNmZjNzVmZjk5YmQxYzllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7b5a2f88f89d7963d57966374f7abcae84623593-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOdqD-000000000a1-32Lo
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE:
 centralize virtual address changes in update_vaddr
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
Content-Type: multipart/mixed; boundary="===============6441849290084605371=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6441849290084605371==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZHfFFFQgwW4="; charset=UTF-8

--ZHfFFFQgwW4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a c=
hange=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?=
usp=3Demail

to look at the new patch set (#2)=2E

The following approvals =
got outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojocaru


Chan=
ge subject: PUSH_UPDATE: centralize virtual address changes in update_vaddr=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

PUSH_UPDAT=
E: centralize virtual address changes in update_vaddr

Use the current virt=
ual addresses as parser defaults so omitted options
remain unchanged and NU=
LL consistently means address removal=2E Move removal
into update_vaddr(), =
skip unchanged addresses, and set the new address before
learning its route=
=2E If learning either new address fails, restart the client
since the PUSH=
_UPDATE is already queued=2E Report the scheduled exit as a failed
update s=
o management does not count the client as successfully updated=2E

Change-I=
d: I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e
Signed-off-by: Marco Baffo <ma=
rco@mandelbit=2Ecom>
---
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M =
src/openvpn/push_util=2Ec
M tests/unit_tests/openvpn/mock_push_dependencies=
=2Ec
4 files changed, 111 insertions(+), 77 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/2060/2

diff --git a/=
src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index af8b1c7=2E=2E0027550 10=
0644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4477,7 +44=
77,7 @@
 }
 
 /* Function to unlearn previous ifconfig of a client in the s=
erver multi_context after a PUSH_UPDATE */
-void
+static void
 unlearn_ifco=
nfig(struct multi_context *m, struct multi_instance *mi)
 {
     in_addr_t =
old_addr =3D 0;
@@ -4489,7 +4489,7 @@
 }
 
 /* Function to unlearn previous=
 ifconfig-ipv6 of a client in the server multi_context after a PUSH_UPDATE =
*/
-void
+static void
 unlearn_ifconfig_ipv6(struct multi_context *m, struc=
t multi_instance *mi)
 {
     struct in6_addr old_addr6;
@@ -4502,59 +4502,=
102 @@
 }
 
 /**
- * Update the vhash with new IP/IPv6 addresses in the mul=
ti_context when a
- * push-update message containing ifconfig/ifconfig-ipv6=
 options is sent
- * from the server=2E
+ * Update the vhash when a push-up=
date message containing
+ * ifconfig/ifconfig-ipv6 options is sent from the=
 server=2E
  *
  * @param m         The multi_context
  * @param mi        =
The multi_instance of the client we are updating
- * @param new_ip    The n=
ew IPv4 address or NULL if no change
- * @param new_ipv6  The new IPv6 addr=
ess or NULL if no change
+ * @param new_ip    The new IPv4 address, NULL to=
 remove, current address to keep
+ * @param new_ipv6  The new IPv6 address,=
 NULL to remove, current address to keep
+ * @return          false if the =
update failed, true otherwise=2E On failure the
+ *                  client=
 is restarted
  */
-void
-update_vhash(struct multi_context *m, struct mult=
i_instance *mi, const char *new_ip, const char *new_ipv6)
+bool
+update_vad=
dr(struct multi_context *m, struct multi_instance *mi, const char *new_ip, =
const char *new_ipv6)
 {
+    /* -ifconfig */
+    if (!new_ip && mi->conte=
xt=2Ec2=2Epush_ifconfig_defined)
+    {
+        unlearn_ifconfig(m, mi);
+=
    }
+    /* -ifconfig-ipv6 */
+    if (!new_ipv6 && mi->context=2Ec2=2Epu=
sh_ifconfig_ipv6_defined)
+    {
+        unlearn_ifconfig_ipv6(m, mi);
+  =
  }
+
     if (new_ip)
     {
-        /* Remove old IP */
-        if (mi-=
>context=2Ec2=2Epush_ifconfig_defined)
-        {
-            unlearn_ifco=
nfig(m, mi);
-        }
-
-        /* Add new IP */
         struct in_addr=
 new_addr;
-        CLEAR(new_addr);
         if (inet_pton(AF_INET, new_ip=
, &new_addr) =3D=3D 1
-            && multi_learn_in_addr_t(m, mi, ntohl(ne=
w_addr=2Es_addr), -1, true))
+            && (!mi->context=2Ec2=2Epush_ifco=
nfig_defined
+                || ntohl(new_addr=2Es_addr) !=3D mi->context=
=2Ec2=2Epush_ifconfig_local))
         {
+            /* Remove old IP */
+=
            if (mi->context=2Ec2=2Epush_ifconfig_defined)
+            {
+ =
               unlearn_ifconfig(m, mi);
+            }
+
+            /* DC=
O needs the new address while installing its on-link route=2E */
          =
   mi->context=2Ec2=2Epush_ifconfig_defined =3D true;
             mi->cont=
ext=2Ec2=2Epush_ifconfig_local =3D ntohl(new_addr=2Es_addr);
-            /=
* set our client's VPN endpoint for status reporting purposes */
-         =
   mi->reporting_addr =3D mi->context=2Ec2=2Epush_ifconfig_local;
+        =
    if (multi_learn_in_addr_t(m, mi, mi->context=2Ec2=2Epush_ifconfig_local=
, -1, true) =3D=3D mi)
+            {
+                /* set our client's =
VPN endpoint for status reporting purposes */
+                mi->reportin=
g_addr =3D mi->context=2Ec2=2Epush_ifconfig_local;
+            }
+        =
    else
+            {
+                mi->context=2Ec2=2Epush_ifconfig_d=
efined =3D false;
+                mi->context=2Ec2=2Epush_ifconfig_local =
=3D 0;
+
+                msg(M_WARN, "MULTI: failed to learn PUSH_UPDATE I=
Pv4 address %s, restarting client",
+                    new_ip);
+        =
        /* PUSH_UPDATE is already queued, so reconnect to restore consisten=
t state=2E */
+                send_restart(&mi->context, NULL);
+         =
       multi_schedule_context_wakeup(m, mi);
+                return false;=

+            }
         }
     }
 
     if (new_ipv6)
     {
-        /* R=
emove old IPv6 */
-        if (mi->context=2Ec2=2Epush_ifconfig_ipv6_define=
d)
-        {
-            unlearn_ifconfig_ipv6(m, mi);
-        }
-
-    =
    /* Add new IPv6 */
         struct in6_addr new_addr6;
-        CLEAR(n=
ew_addr6);
         if (inet_pton(AF_INET6, new_ipv6, &new_addr6) =3D=3D 1
=
-            && multi_learn_in6_addr(m, mi, new_addr6, -1, true))
+        =
    && (!mi->context=2Ec2=2Epush_ifconfig_ipv6_defined
+                || =
memcmp(&new_addr6, &mi->context=2Ec2=2Epush_ifconfig_ipv6_local, sizeof(new=
_addr6))))
         {
+            /* Remove old IPv6 */
+            if (m=
i->context=2Ec2=2Epush_ifconfig_ipv6_defined)
+            {
+             =
   unlearn_ifconfig_ipv6(m, mi);
+            }
+
+            /* DCO needs=
 the new address while installing its on-link route=2E */
             mi->=
context=2Ec2=2Epush_ifconfig_ipv6_defined =3D true;
             mi->contex=
t=2Ec2=2Epush_ifconfig_ipv6_local =3D new_addr6;
-            /* set our cl=
ient's VPN endpoint for status reporting purposes */
-            mi->repor=
ting_addr_ipv6 =3D mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
+          =
  if (multi_learn_in6_addr(m, mi, new_addr6, -1, true) =3D=3D mi)
+        =
    {
+                /* set our client's VPN endpoint for status reportin=
g purposes */
+                mi->reporting_addr_ipv6 =3D mi->context=2Ec2=
=2Epush_ifconfig_ipv6_local;
+            }
+            else
+            =
{
+                mi->context=2Ec2=2Epush_ifconfig_ipv6_defined =3D false;=

+                CLEAR(mi->context=2Ec2=2Epush_ifconfig_ipv6_local);
+
+  =
              msg(M_WARN, "MULTI: failed to learn PUSH_UPDATE IPv6 address =
%s, restarting client",
+                    new_ipv6);
+                /*=
 PUSH_UPDATE is already queued, so reconnect to restore consistent state=2E=
 */
+                send_restart(&mi->context, NULL);
+                mul=
ti_schedule_context_wakeup(m, mi);
+                return false;
+        =
    }
         }
     }
+    return true;
 }
 
 bool
diff --git a/src/openv=
pn/multi=2Eh b/src/openvpn/multi=2Eh
index 3d2e932=2E=2Ef5a1a6f 100644
--- =
a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -661,9 +661,7 @@
 lo=
okup_by_cid(struct multi_context *m, const unsigned long cid);
 #endif
 
-v=
oid
-update_vhash(struct multi_context *m, struct multi_instance *mi, const=
 char *new_ip, const char *new_ipv6);
-void unlearn_ifconfig(struct multi_c=
ontext *m, struct multi_instance *mi);
-void unlearn_ifconfig_ipv6(struct m=
ulti_context *m, struct multi_instance *mi);
+bool
+update_vaddr(struct mul=
ti_context *m, struct multi_instance *mi, const char *new_ip, const char *n=
ew_ipv6);
 
 #endif /* MULTI_H */
diff --git a/src/openvpn/push_util=2Ec b/=
src/openvpn/push_util=2Ec
index 34cb26c=2E=2Ecd940fb 100644
--- a/src/openv=
pn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -149,14 +149,35 @@
    =
 struct options o;
     CLEAR(o);
 
-    /* Set canary values to detect ifc=
onfig options in push-update messages=2E
-     * These placeholder strings =
will be overwritten to NULL by the option
-     * parser if -ifconfig or -i=
fconfig-ipv6 options are present in the
-     * push-update=2E
+    /* Set =
canary values to detect -ifconfig and -ifconfig-ipv6 options in
+     * pus=
h-update messages=2E These placeholder strings will be overwritten
+     * =
to NULL by the option parser if -ifconfig or -ifconfig-ipv6 options
+     *=
 are present in the push-update, to the new value if present, or
+     * th=
ey will remain equal to the current values otherwise=2E
+     * If the curr=
ent values are not defined they will remain NULL=2E
      */
-    const cha=
r *canary =3D "canary";
-    o=2Eifconfig_local =3D canary;
-    o=2Eifconf=
ig_ipv6_local =3D canary;
+
+    char ifconfig_local[INET_ADDRSTRLEN];
+   =
 if (mi->context=2Ec2=2Epush_ifconfig_defined)
+    {
+        struct in_ad=
dr addr4 =3D { =2Es_addr =3D htonl(mi->context=2Ec2=2Epush_ifconfig_local) =
};
+        if (!inet_ntop(AF_INET, &addr4, ifconfig_local, sizeof(ifconfig=
_local)))
+        {
+            return false;
+        }
+        o=2Eifc=
onfig_local =3D ifconfig_local;
+    }
+
+    char ifconfig_ipv6_local[INET=
6_ADDRSTRLEN];
+    if (mi->context=2Ec2=2Epush_ifconfig_ipv6_defined)
+   =
 {
+        if (!inet_ntop(AF_INET6, &mi->context=2Ec2=2Epush_ifconfig_ipv6=
_local,
+                       ifconfig_ipv6_local, sizeof(ifconfig_ipv6_l=
ocal)))
+        {
+            return false;
+        }
+        o=2Eifcon=
fig_ipv6_local =3D ifconfig_ipv6_local;
+    }
 
     struct buffer_entry *=
e =3D msgs->head;
     while (e)
@@ -192,34 +213,15 @@
         e =3D e->ne=
xt;
     }
 
+    bool success =3D true;
     if (option_types_found & OPT_=
P_UP)
     {
-        /* -ifconfig */
-        if (!o=2Eifconfig_local && m=
i->context=2Ec2=2Epush_ifconfig_defined)
-        {
-            unlearn_if=
config(m, mi);
-        }
-        /* -ifconfig-ipv6 */
-        if (!o=2Ei=
fconfig_ipv6_local && mi->context=2Ec2=2Epush_ifconfig_ipv6_defined)
-     =
   {
-            unlearn_ifconfig_ipv6(m, mi);
-        }
-
-        if (o=
=2Eifconfig_local && !strcmp(o=2Eifconfig_local, canary))
-        {
-     =
       o=2Eifconfig_local =3D NULL;
-        }
-        if (o=2Eifconfig_ip=
v6_local && !strcmp(o=2Eifconfig_ipv6_local, canary))
-        {
-         =
   o=2Eifconfig_ipv6_local =3D NULL;
-        }
-
-        /* new ifconfig =
or new ifconfig-ipv6 */
-        update_vhash(m, mi, o=2Eifconfig_local, o=
=2Eifconfig_ipv6_local);
+        /* ifconfig or ifconfig-ipv6 */
+        =
success =3D update_vaddr(m, mi, o=2Eifconfig_local, o=2Eifconfig_ipv6_local=
);
     }
 
     uninit_options(&o);
-    return true;
+    return success;=

 }
 
 /* Return true if the client supports push-update */
diff --git a/te=
sts/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvp=
n/mock_push_dependencies=2Ec
index f083f89=2E=2E041a5e6 100644
--- a/tests/=
unit_tests/openvpn/mock_push_dependencies=2Ec
+++ b/tests/unit_tests/openvp=
n/mock_push_dependencies=2Ec
@@ -48,19 +48,10 @@
     return flags;
 }
 
-v=
oid
-unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi)
+=
bool
+update_vaddr(struct multi_context *m, struct multi_instance *mi, cons=
t char *new_ip, const char *new_ipv6)
 {
-}
-
-void
-unlearn_ifconfig_ipv6(=
struct multi_context *m, struct multi_instance *mi)
-{
-}
-
-void
-update_v=
hash(struct multi_context *m, struct multi_instance *mi, const char *new_ip=
, const char *new_ipv6)
-{
+    return true;
 }
 
 void

-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I75ba77fcbb11790c7cc86cc436fc75ff9=
9bd1c9e
Gerrit-Change-Number: 2060
Gerrit-PatchSet: 2
Gerrit-Owner: Marco B=
affo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>

--ZHfFFFQgwW4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Marco B=
affo <strong>uploaded patch set #2</strong> to this change=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Rev=
iew-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">PUSH_UPDATE: centralize virt=
ual address changes in update_vaddr<br><br>Use the current virtual addresse=
s as parser defaults so omitted options<br>remain unchanged and NULL consis=
tently means address removal=2E Move removal<br>into update_vaddr(), skip u=
nchanged addresses, and set the new address before<br>learning its route=2E=
 If learning either new address fails, restart the client<br>since the PUSH=
_UPDATE is already queued=2E Report the scheduled exit as a failed<br>updat=
e so management does not count the client as successfully updated=2E<br><br=
>Change-Id: I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e<br>Signed-off-by: Mar=
co Baffo &lt;marco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/multi=2Ec<br=
>M src/openvpn/multi=2Eh<br>M src/openvpn/push_util=2Ec<br>M tests/unit_tes=
ts/openvpn/mock_push_dependencies=2Ec<br>4 files changed, 111 insertions(+)=
, 77 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/60/2060/2</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index af8b1c7=2E=2E002=
7550 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++=
 b/src/openvpn/multi=2Ec</span><br><span>@@ -4477,7 +4477,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> /* Function to unlearn previous i=
fconfig of a client in the server multi_context after a PUSH_UPDATE */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> unlearn_ifco=
nfig(struct multi_context *m, struct multi_instance *mi)</span><br><span> {=
</span><br><span>     in_addr_t old_addr =3D 0;</span><br><span>@@ -4489,7 =
+4489,7 @@</span><br><span> }</span><br><span> </span><br><span> /* Functio=
n to unlearn previous ifconfig-ipv6 of a client in the server multi_context=
 after a PUSH_UPDATE */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span> unlearn_ifconfig_ipv6(struct multi_context *m, struct multi=
_instance *mi)</span><br><span> {</span><br><span>     struct in6_addr old_=
addr6;</span><br><span>@@ -4502,59 +4502,102 @@</span><br><span> }</span><b=
r><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Update the vhash with new IP/IPv6 addresses in the multi_contex=
t when a</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * push-updat=
e message containing ifconfig/ifconfig-ipv6 options is sent</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * from the server=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Update the vhash when a push-upd=
ate message containing</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * ifconfig/ifconfig-ipv6 options is sent from the server=2E</span><br><=
span>  *</span><br><span>  * @param m         The multi_context</span><br><=
span>  * @param mi        The multi_instance of the client we are updating<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param new_ip    Th=
e new IPv4 address or NULL if no change</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * @param new_ipv6  The new IPv6 address or NULL if no ch=
ange</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param new_i=
p    The new IPv4 address, NULL to remove, current address to keep</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param new_ipv6  The new =
IPv6 address, NULL to remove, current address to keep</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return          false if the update f=
ailed, true otherwise=2E On failure the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *                  client is restarted</span><br><span=
>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-update_vhash(struct multi_context=
 *m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+update_vaddr(struct multi_context *m=
, struct multi_instance *mi, const char *new_ip, const char *new_ipv6)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* -ifconfig */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!new_ip &amp;&amp; mi-&gt;context=2Ec2=2Epush_ifconfig_defined)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        unlearn_ifconfig(m, mi);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* -ifconfig-ipv6 */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!new_ipv6 &amp;&amp; mi-&gt;=
context=2Ec2=2Epush_ifconfig_ipv6_defined)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        unlearn_ifconfig_ipv6(m, mi);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     if (new_ip)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Remove old IP */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;co=
ntext=2Ec2=2Epush_ifconfig_defined)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            unlearn_ifconfig(m, mi);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Add n=
ew IP */</span><br><span>         struct in_addr new_addr;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(new_addr);</span><br><sp=
an>         if (inet_pton(AF_INET, new_ip, &amp;new_addr) =3D=3D 1</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; multi_l=
earn_in_addr_t(m, mi, ntohl(new_addr=2Es_addr), -1, true))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (!mi-&gt;cont=
ext=2Ec2=2Epush_ifconfig_defined</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                || ntohl(new_addr=2Es_addr) !=3D mi-&gt;contex=
t=2Ec2=2Epush_ifconfig_local))</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* Remove old IP */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (mi-&gt;co=
ntext=2Ec2=2Epush_ifconfig_defined)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                unlearn_ifconfig(m, mi);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            /* DCO needs the new address while installing its on-link=
 route=2E */</span><br><span>             mi-&gt;context=2Ec2=2Epush_ifconf=
ig_defined =3D true;</span><br><span>             mi-&gt;context=2Ec2=2Epus=
h_ifconfig_local =3D ntohl(new_addr=2Es_addr);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            /* set our client&#39;s VPN endpoint f=
or status reporting purposes */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            mi-&gt;reporting_addr =3D mi-&gt;context=2Ec2=2Epush_=
ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (multi_learn_in_addr_t(m, mi, mi-&gt;context=2Ec2=2Epush_ifconfi=
g_local, -1, true) =3D=3D mi)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                /* set our client&#39;s VPN endpoint for status reporti=
ng purposes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           mi-&gt;reporting_addr =3D mi-&gt;context=2Ec2=2Epush_ifconfig_lo=
cal;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                mi-&gt;context=
=2Ec2=2Epush_ifconfig_defined =3D false;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                mi-&gt;context=2Ec2=2Epush_ifconfig_lo=
cal =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_WARN, =
&quot;MULTI: failed to learn PUSH_UPDATE IPv4 address %s, restarting client=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        new_ip);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             /* PUSH_UPDATE is already queued, so reconnect to restore cons=
istent state=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               send_restart(&amp;mi-&gt;context, NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                multi_schedule_context_=
wakeup(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span>         }</span><br><span>     }</span>=
<br><span> </span><br><span>     if (new_ipv6)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Remove old IPv6 =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;=
context=2Ec2=2Epush_ifconfig_ipv6_defined)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            unlearn_ifconfig_ipv6(m, mi);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /* Add new IPv6 */</span><br><span>         struct in6_addr new_addr6;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(new_addr=
6);</span><br><span>         if (inet_pton(AF_INET6, new_ipv6, &amp;new_add=
r6) =3D=3D 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   &amp;&amp; multi_learn_in6_addr(m, mi, new_addr6, -1, true))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (!mi-&gt=
;context=2Ec2=2Epush_ifconfig_ipv6_defined</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                || memcmp(&amp;new_addr6, &amp;mi-&g=
t;context=2Ec2=2Epush_ifconfig_ipv6_local, sizeof(new_addr6))))</span><br><=
span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        /* Remove old IPv6 */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                unlearn_i=
fconfig_ipv6(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* DCO needs=
 the new address while installing its on-link route=2E */</span><br><span> =
            mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined =3D true;</spa=
n><br><span>             mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local =3D=
 new_addr6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  /* set our client&#39;s VPN endpoint for status reporting purposes */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;report=
ing_addr_ipv6 =3D mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (multi_learn_i=
n6_addr(m, mi, new_addr6, -1, true) =3D=3D mi)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                /* set our client&#39;s VPN endpoint f=
or status reporting purposes */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                mi-&gt;reporting_addr_ipv6 =3D mi-&gt;context=
=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined =3D false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                CLEA=
R(mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                msg(M_WARN, &quot;MULTI: failed to learn PUSH_U=
PDATE IPv6 address %s, restarting client&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    new_ipv6);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                /* PUSH_UPDATE is al=
ready queued, so reconnect to restore consistent state=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                send_restart(&amp;=
mi-&gt;context, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                multi_schedule_context_wakeup(m, mi);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n>         }</span><br><span>     }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return true;</span><br><span> }</span><br><span> </span=
><br><span> bool</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/o=
penvpn/multi=2Eh</span><br><span>index 3d2e932=2E=2Ef5a1a6f 100644</span><b=
r><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=
=2Eh</span><br><span>@@ -661,9 +661,7 @@</span><br><span> lookup_by_cid(str=
uct multi_context *m, const unsigned long cid);</span><br><span> #endif</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-update_vhash(struct mult=
i_context *m, struct multi_instance *mi, const char *new_ip, const char *ne=
w_ipv6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void unlearn_=
ifconfig(struct multi_context *m, struct multi_instance *mi);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void unlearn_ifconfig_ipv6(struct m=
ulti_context *m, struct multi_instance *mi);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+update_vaddr(struct multi_context *m, struct multi_instance *mi, =
const char *new_ip, const char *new_ipv6);</span><br><span> </span><br><spa=
n> #endif /* MULTI_H */</span><br><span>diff --git a/src/openvpn/push_util=
=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index 34cb26c=2E=2Ecd940fb=
 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</span><br><span>+++=
 b/src/openvpn/push_util=2Ec</span><br><span>@@ -149,14 +149,35 @@</span><b=
r><span>     struct options o;</span><br><span>     CLEAR(o);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Set canary=
 values to detect ifconfig options in push-update messages=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-     * These placeholder strings wi=
ll be overwritten to NULL by the option</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     * parser if -ifconfig or -ifconfig-ipv6 options are =
present in the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * =
push-update=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Set canary values to detect -ifconfig and -ifconfig-ipv6 options in</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * push-update messag=
es=2E These placeholder strings will be overwritten</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * to NULL by the option parser if -i=
fconfig or -ifconfig-ipv6 options</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * are present in the push-update, to the new value if pr=
esent, or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the=
y will remain equal to the current values otherwise=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * If the current values are not def=
ined they will remain NULL=2E</span><br><span>      */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    const char *canary =3D &quot;canary&qu=
ot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eifconfig_=
local =3D canary;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
o=2Eifconfig_ipv6_local =3D canary;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 char ifconfig_local[INET_ADDRSTRLEN];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (mi-&gt;context=2Ec2=2Epush_ifconfig_defined)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct in_addr addr4 =3D { =
=2Es_addr =3D htonl(mi-&gt;context=2Ec2=2Epush_ifconfig_local) };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (!inet_ntop(AF_INE=
T, &amp;addr4, ifconfig_local, sizeof(ifconfig_local)))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        o=2Eifconfig_local =3D ifconfig_local;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    char ifconfig_ipv6_local[INET6_ADDRSTRLEN];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Ec2=
=2Epush_ifconfig_ipv6_defined)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (!inet_ntop(AF_INET6, &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6=
_local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
           ifconfig_ipv6_local, sizeof(ifconfig_ipv6_local)))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        o=2Eifconfig_ipv6_local =3D ifconfig_=
ipv6_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span> </span><br><span>     struct buffer_entry *e =3D msgs-&gt;he=
ad;</span><br><span>     while (e)</span><br><span>@@ -192,34 +213,15 @@</s=
pan><br><span>         e =3D e-&gt;next;</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool succ=
ess =3D true;</span><br><span>     if (option_types_found &amp; OPT_P_UP)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        /* -ifconfig */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (!o=2Eifconfig_local &amp;&amp; mi-&gt;context=2Ec2=2Epush_ifc=
onfig_defined)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            unlearn=
_ifconfig(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* -ifco=
nfig-ipv6 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (!o=2Eifconfig_ipv6_local &amp;&amp; mi-&gt;context=2Ec2=2Epush_ifconfig_=
ipv6_defined)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            unlearn_=
ifconfig_ipv6(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (o=2Eifconfig_local &a=
mp;&amp; !strcmp(o=2Eifconfig_local, canary))</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            o=2Eifconfig_local =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (o=2Eifconfig_ipv6_local &amp;&amp; !strcmp(=
o=2Eifconfig_ipv6_local, canary))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            o=2Eifconfig_ipv6_local =3D NULL;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* new ifconfig or new ifconfig-ipv6 */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        update_vhash(m, mi, o=2Eifconfig_local, o=2Eifconf=
ig_ipv6_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* ifconfig or ifconfig-ipv6 */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        success =3D update_vaddr(m, mi, o=2Eifconfig_local,=
 o=2Eifconfig_ipv6_local);</span><br><span>     }</span><br><span> </span><=
br><span>     uninit_options(&amp;o);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return success;</span><br><span> }</span><br><span> </span=
><br><span> /* Return true if the client supports push-update */</span><br>=
<span>diff --git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/te=
sts/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>index f08=
3f89=2E=2E041a5e6 100644</span><br><span>--- a/tests/unit_tests/openvpn/moc=
k_push_dependencies=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock=
_push_dependencies=2Ec</span><br><span>@@ -48,19 +48,10 @@</span><br><span>=
     return flags;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-unlearn_ifconfig(struct multi_context *m, struct multi_ins=
tance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+update_vaddr(struct mult=
i_context *m, struct multi_instance *mi, const char *new_ip, const char *ne=
w_ipv6)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-unlearn_ifconfig_ipv6(struct multi_context *m, struct=
 multi_instance *mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-upda=
te_vhash(struct multi_context *m, struct multi_instance *mi, const char *ne=
w_ip, const char *new_ipv6)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return t=
rue;</span><br><span> }</span><br><span> </span><br><span> void</span><br><=
/pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2060?usp=3Demail">change 2060</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2060?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2060 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></h=
tml>
--ZHfFFFQgwW4=--


--===============6441849290084605371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6441849290084605371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6441849290084605371==--

