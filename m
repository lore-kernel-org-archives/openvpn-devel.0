Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1109E606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ETHtF7Wl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ANkCI0IJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EvRzhjVk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YyPWN37k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=M51yur3VWj9m+ELXdbEwqxP9a92rTcFgV0qlrefKJSE=; b=ETHtF7WlQW9cw9mTLUqAD4m64w
	+erPLQZ/LZ0qLAU2lLY7ipV6acyrt9IVI2Ws7Jqg8RG9OeHBtFba6M6RlW/YFrNiuo+8azNnWZZkn
	KQ7mEKsgVMWoVHLgTRFTiD5MMiJD8cDPkfcQIFdmVxjB+sCJyibFITtEhlQJ9yUnNMZg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM3r3-000000006dG-38l7;
	Wed, 28 Oct 2026 13:38:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM3r1-000000006d7-0CeW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 13:38:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sB7Quk+3MVu7FSF2Xq7XdXNA6/aT8vN/Rs3UvMP7w3A=; b=ANkCI0IJ0YxRUBmyTEfNXlTpAw
 y+difR2nUZQ3chIcxq2avQ2OqKA3t8DAkT6KkOMYnjQj/hazbAuc5jQoLLnd8VY23MIUcqG2elw88
 m9RydEaYcD5kj9m15EW8i7y2IqbYjRSVLfPNxRxWIuAk1zGQKRx1GOn3ymrwJ4ypovSA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sB7Quk+3MVu7FSF2Xq7XdXNA6/aT8vN/Rs3UvMP7w3A=; b=EvRzhjVkf4vDHulVQy3TqAZvbP
 +/Fp/xr4LMNxwwG6cJN5/Npwp7MdFb8gZ3GrgTmaWE/ujLi1tvTTY1skcbIUDupwrbgbJpfUpXRWa
 CsUMobBusxQHKoIYitUB7YCrhbiJHRp4V367D/zJb5q0KVhi2cOLKzTzbSRT38xqIn0s=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM3qx-0000000089q-01nJ for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 13:38:08 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso10157675e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 06:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793194680; x=1793799480; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sB7Quk+3MVu7FSF2Xq7XdXNA6/aT8vN/Rs3UvMP7w3A=;
 b=YyPWN37kyhOChbSXkBR4zKHfOSzBe1+YFEhh+RhvIFRZyIzcLLlYZ181RBBoIuL8Ru
 4SasCg6F48NHl/Yt+8hFOQWkBbquESeqlvbE4DmJjC3EBufK2da7WGv9bm+K+hdWRS8G
 KZNkOytntVB/uJ2wLpR88gbgh3H4JJUfjizrZnqQZ/B0bOLtsJ9vfQedfS7cOT/E5BYr
 RdW8v0f6TVhNbgZUBUrpW2xg+uoUrpWdmvvvnPGRSABI53qT3SvXqTwOfoTc/DtyE41l
 vr76Z4bOFVxWxDlOdWgwhU49+hyWXhFA38TPyacJpGa1M0UcT04eLTfUZbDmrIALgDP3
 0Olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793194680; x=1793799480;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sB7Quk+3MVu7FSF2Xq7XdXNA6/aT8vN/Rs3UvMP7w3A=;
 b=sn2dS+1FVUTOBUN1CV2/WmOynaFO8291wsPiXtk/ZkbJo6fyaBBYo7h6ayeMKPnj4t
 /bIYcsbDchWwcbzhadewRxx3U0vAHRY4WZGENlPhx4nno7YJYbSVV2Erq+eB23wmZxut
 BWvuBq/g2zqB5+xRZuIYxL9fNDBFucZjIGui/I2J2sY8inXfdjHgxtb7Fk2oIaKrTADq
 YF6bGAofIkr56YB4Qr3b557QnAaaVSqAlwAImEVXk2aqe1B6csmtMfRymrMR2ls0uUbK
 /hcf5VqPmR5BmJOq7XWGO/dQDeIuMoTQODp0Nw5FRCNTjBjnsWCsLpnvKPYMYVfk+yGZ
 HUeA==
X-Gm-Message-State: AFq9FYIUoEiYgWnGcuXBo7mGpogpHySnaads4FAPBiwO2oBoL31bek8B
 q92nTr+/0cuSijgyXLazEGQJ1//KH4Az8TYeC2oD3EBsq2jWEuqMH1LmPfyahnGb+yorjeJG+VS
 DkPC7WJUbi80wUP8bPu2l93lkehz6vUE9Hk+LLLT6xJNa7Z3MM9wI6yYANq3gA4owfuuYyeyP9W
 lzWrGHxw==
X-Gm-Gg: AYBFou2GpUFP4ULg+ZJPPKqWJINfdXOsjRo4fQbCK4Ukf2TH3Dx0f2BfIN1CVms7ojE
 LArAswuFeHNml5PgtOQEXz22bwjMXM9mYFScWaXzd+ANDK7DfCEhJ3njoOjWbdDlN+By7rsGV3p
 /A90abWlYcSH9ltNnezyB0YHW9JpnAPExvySbeeToyQv19M0Qhxa1o9BWMTY7UlWs6YNQZ15k/M
 cf9k4wu1sakuvh/zi1/VKQHuCAjawBcwZ84zf4/4Ns/KHw01jhtT7Hmt38PTG7GyuZTIXZBq2Wu
 uFcrBzn4+u9ahXJvCmiCBLTsTmyj+vMkmNu+4WESGwEB7XPbSKO64kuretiK7QzRZP5QYBZrD/1
 hQ8gnyZ4dytv9sOl8flTjYP4XebfyaX7tbvU8boYCVM7+RxFBiomvmX1IQsVImaoNMI5Zghr5v5
 dNJUiJ77zcMPVqnS6eDjzZK/FvV74gg2ExLcu+S3MxB3U3XIzBHKWQ350NlmHDFoLuMnLrJ7D/y
 a6hp6Ho5b4IlRBbc8GyTxHJowQQAnU4Rv8sfOKtw9vXtvqK3Z/hIRKkx5Q+0xEkckM4tF4W7oeg
 HO7BGJ3f+CRP1MSwBzyTlnoy1iJkxrYChHIvlpBGdxSe6IgsInHPfyDMw7tp/545Db09GGMr5j9
 ynYtD59B6QJ39Ngo2Aqmq5pGmqB5czKr3UAJ+tP9OP6Gr49gyFuWGGCri1FBh8dTIe+U/54a77I
 ubpUj6ds/YdlUQqc8=
X-Received: by 2002:a05:600c:8b28:b0:4a5:75d2:c104 with SMTP id
 5b1f17b1804b1-4a96720304cmr51706765e9.22.1793194680081; 
 Wed, 28 Oct 2026 06:38:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97cebfa16sm69526635e9.13.2026.10.28.06.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:37:59 -0700 (PDT)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 13:37:59 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e
X-Gerrit-Change-Number: 2060
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2060?usp=email>
X-Gerrit-Commit: ed4acc88e80d08696902ef2b387f2f44497b1fb7
References: <gerrit.1793194671000.I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkk3NWJhNzdmY2JiMTE3OTBjN2NjODZjYzQzNmZjNzVmZjk5YmQxYzllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d381a36d8ffcc4f9880228719904c785a6e77da0-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM3qx-0000000089q-01nJ
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
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7565000673464885621=="
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7565000673464885621==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ykEp1jbA/EY="; charset=UTF-8

--ykEp1jbA/EY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2060?usp=3Demail

to review the following change=2E
=


Change subject: PUSH_UPDATE: centralize virtual address changes in update=
_vaddr
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

PUSH=
_UPDATE: centralize virtual address changes in update_vaddr

Use the curren=
t virtual addresses as parser defaults so omitted options
remain unchanged =
and NULL consistently means address removal=2E Move removal
into update_vad=
dr(), skip unchanged addresses, and set the new address before
learning its=
 route=2E If learning either new address fails, restart the client
since th=
e PUSH_UPDATE is already queued=2E Report the scheduled exit as a failed
up=
date so management does not count the client as successfully updated=2E

Ch=
ange-Id: I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e
Signed-off-by: Marco Baf=
fo <marco@mandelbit=2Ecom>
---
M src/openvpn/multi=2Ec
M src/openvpn/multi=
=2Eh
M src/openvpn/push_util=2Ec
M tests/unit_tests/openvpn/mock_push_depen=
dencies=2Ec
4 files changed, 104 insertions(+), 73 deletions(-)



  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/2060/1

diff =
--git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index abc26b9=2E=2Eb8=
a829c 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -44=
17,7 +4417,7 @@
 }
 
 /* Function to unlearn previous ifconfig of a client =
in the server multi_context after a PUSH_UPDATE */
-void
+static void
 unle=
arn_ifconfig(struct multi_context *m, struct multi_instance *mi)
 {
     in=
_addr_t old_addr =3D 0;
@@ -4429,7 +4429,7 @@
 }
 
 /* Function to unlearn =
previous ifconfig-ipv6 of a client in the server multi_context after a PUSH=
_UPDATE */
-void
+static void
 unlearn_ifconfig_ipv6(struct multi_context *=
m, struct multi_instance *mi)
 {
     struct in6_addr old_addr6;
@@ -4442,5=
7 +4442,97 @@
 }
 
 /**
- * Update the vhash with new IP/IPv6 addresses in =
the multi_context when a
- * push-update message containing ifconfig/ifconf=
ig-ipv6 options is sent
- * from the server=2E
+ * Update the vhash when a =
push-update message containing
+ * ifconfig/ifconfig-ipv6 options is sent f=
rom the server=2E
  *
  * @param m         The multi_context
  * @param mi =
       The multi_instance of the client we are updating
- * @param new_ip  =
  The new IPv4 address or NULL if no change
- * @param new_ipv6  The new IP=
v6 address or NULL if no change
+ * @param new_ip    The new IPv4 address, =
NULL for -ifconfig or the current IPv4 if no change
+ * @param new_ipv6  Th=
e new IPv6 address, NULL for -ifconfig-ipv6 or the current IPv6 if no chang=
e
  */
 void
-update_vhash(struct multi_context *m, struct multi_instance *=
mi, const char *new_ip, const char *new_ipv6)
+update_vaddr(struct multi_co=
ntext *m, struct multi_instance *mi, const char *new_ip, const char *new_ip=
v6)
 {
+    /* -ifconfig */
+    if (!new_ip && mi->context=2Ec2=2Epush_ifc=
onfig_defined)
+    {
+        unlearn_ifconfig(m, mi);
+    }
+    /* -ifc=
onfig-ipv6 */
+    if (!new_ipv6 && mi->context=2Ec2=2Epush_ifconfig_ipv6_d=
efined)
+    {
+        unlearn_ifconfig_ipv6(m, mi);
+    }
+
     if (new=
_ip)
     {
-        /* Remove old IP */
-        if (mi->context=2Ec2=2Epu=
sh_ifconfig_defined)
-        {
-            unlearn_ifconfig(m, mi);
-    =
    }
-
-        /* Add new IP */
         struct in_addr new_addr;
-      =
  CLEAR(new_addr);
         if (inet_pton(AF_INET, new_ip, &new_addr) =3D=
=3D 1
-            && multi_learn_in_addr_t(m, mi, ntohl(new_addr=2Es_addr)=
, -1, true))
+            && (!mi->context=2Ec2=2Epush_ifconfig_defined
+  =
              || ntohl(new_addr=2Es_addr) !=3D mi->context=2Ec2=2Epush_ifco=
nfig_local))
         {
+            /* Remove old IP */
+            if (m=
i->context=2Ec2=2Epush_ifconfig_defined)
+            {
+                un=
learn_ifconfig(m, mi);
+            }
+
+            /* DCO needs the new a=
ddress while installing its on-link route=2E */
             mi->context=2E=
c2=2Epush_ifconfig_defined =3D true;
             mi->context=2Ec2=2Epush_i=
fconfig_local =3D ntohl(new_addr=2Es_addr);
-            /* set our client'=
s VPN endpoint for status reporting purposes */
-            mi->reporting_=
addr =3D mi->context=2Ec2=2Epush_ifconfig_local;
+            if (multi_lea=
rn_in_addr_t(m, mi, mi->context=2Ec2=2Epush_ifconfig_local, -1, true) =3D=
=3D mi)
+            {
+                /* set our client's VPN endpoint fo=
r status reporting purposes */
+                mi->reporting_addr =3D mi->=
context=2Ec2=2Epush_ifconfig_local;
+            }
+            else
+     =
       {
+                mi->context=2Ec2=2Epush_ifconfig_defined =3D fals=
e;
+                mi->context=2Ec2=2Epush_ifconfig_local =3D 0;
+
+      =
          msg(M_WARN, "MULTI: failed to learn PUSH_UPDATE IPv4 address %s, =
restarting client",
+                    new_ip);
+                /* PUSH_=
UPDATE is already queued, so reconnect to restore consistent state=2E */
+ =
               send_restart(&mi->context, NULL);
+                multi_sch=
edule_context_wakeup(m, mi);
+                return;
+            }
      =
   }
     }
 
     if (new_ipv6)
     {
-        /* Remove old IPv6 */
-   =
     if (mi->context=2Ec2=2Epush_ifconfig_ipv6_defined)
-        {
-       =
     unlearn_ifconfig_ipv6(m, mi);
-        }
-
-        /* Add new IPv6 */=

         struct in6_addr new_addr6;
-        CLEAR(new_addr6);
         if=
 (inet_pton(AF_INET6, new_ipv6, &new_addr6) =3D=3D 1
-            && multi_=
learn_in6_addr(m, mi, new_addr6, -1, true))
+            && (!mi->context=
=2Ec2=2Epush_ifconfig_ipv6_defined
+                || memcmp(&new_addr6, &=
mi->context=2Ec2=2Epush_ifconfig_ipv6_local, sizeof(new_addr6))))
         =
{
+            /* Remove old IPv6 */
+            if (mi->context=2Ec2=2Epu=
sh_ifconfig_ipv6_defined)
+            {
+                unlearn_ifconfig_=
ipv6(m, mi);
+            }
+
+            /* DCO needs the new address whi=
le installing its on-link route=2E */
             mi->context=2Ec2=2Epush_=
ifconfig_ipv6_defined =3D true;
             mi->context=2Ec2=2Epush_ifconf=
ig_ipv6_local =3D new_addr6;
-            /* set our client's VPN endpoint =
for status reporting purposes */
-            mi->reporting_addr_ipv6 =3D m=
i->context=2Ec2=2Epush_ifconfig_ipv6_local;
+            if (multi_learn_in=
6_addr(m, mi, new_addr6, -1, true) =3D=3D mi)
+            {
+             =
   /* set our client's VPN endpoint for status reporting purposes */
+     =
           mi->reporting_addr_ipv6 =3D mi->context=2Ec2=2Epush_ifconfig_ipv=
6_local;
+            }
+            else
+            {
+                m=
i->context=2Ec2=2Epush_ifconfig_ipv6_defined =3D false;
+                CL=
EAR(mi->context=2Ec2=2Epush_ifconfig_ipv6_local);
+
+                msg(M_=
WARN, "MULTI: failed to learn PUSH_UPDATE IPv6 address %s, restarting clien=
t",
+                    new_ipv6);
+                /* PUSH_UPDATE is alre=
ady queued, so reconnect to restore consistent state=2E */
+               =
 send_restart(&mi->context, NULL);
+                multi_schedule_context_=
wakeup(m, mi);
+                return;
+            }
         }
     }
 }=

diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 5db7147=
=2E=2E010fb9b 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2E=
h
@@ -730,8 +730,6 @@
 #endif
 
 void
-update_vhash(struct multi_context *m=
, struct multi_instance *mi, const char *new_ip, const char *new_ipv6);
-vo=
id unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi);
-v=
oid unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *m=
i);
+update_vaddr(struct multi_context *m, struct multi_instance *mi, const=
 char *new_ip, const char *new_ipv6);
 
 #endif /* MULTI_H */
diff --git a/=
src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index 34cb26c=2E=2Ec0=
ecd1b 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2E=
c
@@ -149,14 +149,35 @@
     struct options o;
     CLEAR(o);
 
-    /* Set=
 canary values to detect ifconfig options in push-update messages=2E
-     =
* These placeholder strings will be overwritten to NULL by the option
-    =
 * parser if -ifconfig or -ifconfig-ipv6 options are present in the
-     *=
 push-update=2E
+    /* Set canary values to detect -ifconfig and -ifconfig=
-ipv6 options in
+     * push-update messages=2E These placeholder strings =
will be overwritten
+     * to NULL by the option parser if -ifconfig or -i=
fconfig-ipv6 options
+     * are present in the push-update, to the new val=
ue if present, or
+     * they will remain equal to the current values othe=
rwise=2E
+     * If the current values are not defined they will remain NUL=
L=2E
      */
-    const char *canary =3D "canary";
-    o=2Eifconfig_local=
 =3D canary;
-    o=2Eifconfig_ipv6_local =3D canary;
+
+    char ifconfig_=
local[INET_ADDRSTRLEN];
+    struct in_addr addr4 =3D { =2Es_addr =3D htonl=
(mi->context=2Ec2=2Epush_ifconfig_local) };
+    if (mi->context=2Ec2=2Epus=
h_ifconfig_defined)
+    {
+        if (!inet_ntop(AF_INET, &addr4, ifconfi=
g_local, sizeof(ifconfig_local)))
+        {
+            return false;
+  =
      }
+        o=2Eifconfig_local =3D ifconfig_local;
+    }
+
+    char =
ifconfig_ipv6_local[INET6_ADDRSTRLEN];
+    if (mi->context=2Ec2=2Epush_ifc=
onfig_ipv6_defined)
+    {
+        if (!inet_ntop(AF_INET6, &mi->context=
=2Ec2=2Epush_ifconfig_ipv6_local,
+                       ifconfig_ipv6_loc=
al, sizeof(ifconfig_ipv6_local)))
+        {
+            return false;
+  =
      }
+        o=2Eifconfig_ipv6_local =3D ifconfig_ipv6_local;
+    }
 
=
     struct buffer_entry *e =3D msgs->head;
     while (e)
@@ -194,28 +215,=
10 @@
 
     if (option_types_found & OPT_P_UP)
     {
-        /* -ifconfi=
g */
-        if (!o=2Eifconfig_local && mi->context=2Ec2=2Epush_ifconfig_d=
efined)
-        {
-            unlearn_ifconfig(m, mi);
-        }
-      =
  /* -ifconfig-ipv6 */
-        if (!o=2Eifconfig_ipv6_local && mi->context=
=2Ec2=2Epush_ifconfig_ipv6_defined)
-        {
-            unlearn_ifconfi=
g_ipv6(m, mi);
-        }
-
-        if (o=2Eifconfig_local && !strcmp(o=2E=
ifconfig_local, canary))
-        {
-            o=2Eifconfig_local =3D NUL=
L;
-        }
-        if (o=2Eifconfig_ipv6_local && !strcmp(o=2Eifconfig_=
ipv6_local, canary))
-        {
-            o=2Eifconfig_ipv6_local =3D NU=
LL;
-        }
-
-        /* new ifconfig or new ifconfig-ipv6 */
-        =
update_vhash(m, mi, o=2Eifconfig_local, o=2Eifconfig_ipv6_local);
+        =
/* ifconfig or ifconfig-ipv6 */
+        update_vaddr(m, mi, o=2Eifconfig_l=
ocal, o=2Eifconfig_ipv6_local);
+        uninit_options(&o);
+        retur=
n !event_timeout_defined(&c->c2=2Escheduled_exit);
     }
 
     uninit_opt=
ions(&o);
diff --git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec =
b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
index bf2ccf3=2E=2Ec9=
51a8f 100644
--- a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
+++ =
b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
@@ -48,17 +48,7 @@
 }=

 
 void
-unlearn_ifconfig(struct multi_context *m, struct multi_instance *=
mi)
-{
-}
-
-void
-unlearn_ifconfig_ipv6(struct multi_context *m, struct mu=
lti_instance *mi)
-{
-}
-
-void
-update_vhash(struct multi_context *m, stru=
ct multi_instance *mi, const char *new_ip, const char *new_ipv6)
+update_va=
ddr(struct multi_context *m, struct multi_instance *mi, const char *new_ip,=
 const char *new_ipv6)
 {
 }
 

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2060?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e
Gerrit-Change-Numbe=
r: 2060
Gerrit-PatchSet: 1
Gerrit-Owner: Marco Baffo <marco@mandelbit=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>

--ykEp1jbA/EY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Marco Baffo would like Arne S=
chwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?usp=3Demail">View Change</a></p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">PUSH_UPDATE: centralize virtual address changes in update_vaddr<=
br><br>Use the current virtual addresses as parser defaults so omitted opti=
ons<br>remain unchanged and NULL consistently means address removal=2E Move=
 removal<br>into update_vaddr(), skip unchanged addresses, and set the new =
address before<br>learning its route=2E If learning either new address fail=
s, restart the client<br>since the PUSH_UPDATE is already queued=2E Report =
the scheduled exit as a failed<br>update so management does not count the c=
lient as successfully updated=2E<br><br>Change-Id: I75ba77fcbb11790c7cc86cc=
436fc75ff99bd1c9e<br>Signed-off-by: Marco Baffo &lt;marco@mandelbit=2Ecom&g=
t;<br>---<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/op=
envpn/push_util=2Ec<br>M tests/unit_tests/openvpn/mock_push_dependencies=2E=
c<br>4 files changed, 104 insertions(+), 73 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/6=
0/2060/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec=
</span><br><span>index abc26b9=2E=2Eb8a829c 100644</span><br><span>--- a/sr=
c/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><=
span>@@ -4417,7 +4417,7 @@</span><br><span> }</span><br><span> </span><br><=
span> /* Function to unlearn previous ifconfig of a client in the server mu=
lti_context after a PUSH_UPDATE */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span> unlearn_ifconfig(struct multi_context *m, struct=
 multi_instance *mi)</span><br><span> {</span><br><span>     in_addr_t old_=
addr =3D 0;</span><br><span>@@ -4429,7 +4429,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> /* Function to unlearn previous ifconfig-ipv6 =
of a client in the server multi_context after a PUSH_UPDATE */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span> unlearn_ifconfig_ipv=
6(struct multi_context *m, struct multi_instance *mi)</span><br><span> {</s=
pan><br><span>     struct in6_addr old_addr6;</span><br><span>@@ -4442,57 +=
4442,97 @@</span><br><span> }</span><br><span> </span><br><span> /**</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * Update the vhash with new=
 IP/IPv6 addresses in the multi_context when a</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * push-update message containing ifconfig/ifconfi=
g-ipv6 options is sent</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * from the server=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Update the vhash when a push-update message containing</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * ifconfig/ifconfig-ipv6 options =
is sent from the server=2E</span><br><span>  *</span><br><span>  * @param m=
         The multi_context</span><br><span>  * @param mi        The multi_i=
nstance of the client we are updating</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @param new_ip    The new IPv4 address or NULL if no chan=
ge</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param new_ipv6 =
 The new IPv6 address or NULL if no change</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param new_ip    The new IPv4 address, NULL for -=
ifconfig or the current IPv4 if no change</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param new_ipv6  The new IPv6 address, NULL for -i=
fconfig-ipv6 or the current IPv6 if no change</span><br><span>  */</span><b=
r><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-update_v=
hash(struct multi_context *m, struct multi_instance *mi, const char *new_ip=
, const char *new_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+update_vaddr(struct multi_context *m, struct multi_instance *mi, const =
char *new_ip, const char *new_ipv6)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* -ifconfig */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!new_ip &amp;&amp; mi-&gt;contex=
t=2Ec2=2Epush_ifconfig_defined)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      unlearn_ifconfig(m, mi);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* -ifconfig-ipv6 */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!new_ipv6 &amp;&amp; mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_def=
ined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        unlearn_ifconfig_ipv=
6(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if=
 (new_ip)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* Remove old IP */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (mi-&gt;context=2Ec2=2Epush_ifconfig_defined)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            unlearn_ifconfig(m, mi)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        /* Add new IP */</span><br><span>         str=
uct in_addr new_addr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        CLEAR(new_addr);</span><br><span>         if (inet_pton(AF_INET, ne=
w_ip, &amp;new_addr) =3D=3D 1</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            &amp;&amp; multi_learn_in_addr_t(m, mi, ntohl(new_addr=
=2Es_addr), -1, true))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &amp;&amp; (!mi-&gt;context=2Ec2=2Epush_ifconfig_defined</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                || ntoh=
l(new_addr=2Es_addr) !=3D mi-&gt;context=2Ec2=2Epush_ifconfig_local))</span=
><br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            /* Remove old IP */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if (mi-&gt;context=2Ec2=2Epush_ifconfig_defined)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                unlearn_if=
config(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            /* DCO needs the n=
ew address while installing its on-link route=2E */</span><br><span>       =
      mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D true;</span><br><span=
>             mi-&gt;context=2Ec2=2Epush_ifconfig_local =3D ntohl(new_addr=
=2Es_addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  /* set our client&#39;s VPN endpoint for status reporting purposes */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;report=
ing_addr =3D mi-&gt;context=2Ec2=2Epush_ifconfig_local;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (multi_learn_in_addr_t(m=
, mi, mi-&gt;context=2Ec2=2Epush_ifconfig_local, -1, true) =3D=3D mi)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                /* set our clie=
nt&#39;s VPN endpoint for status reporting purposes */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                mi-&gt;reporting_addr =
=3D mi-&gt;context=2Ec2=2Epush_ifconfig_local;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    mi-&gt;context=2Ec2=2Epush_ifconfig_local =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                msg(M_WARN, &quot;MULTI: failed to learn PUS=
H_UPDATE IPv4 address %s, restarting client&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    new_ip);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                /* PUSH_UPDATE is a=
lready queued, so reconnect to restore consistent state=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                send_restart(&amp=
;mi-&gt;context, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                multi_schedule_context_wakeup(m, mi);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                return;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>   =
      }</span><br><span>     }</span><br><span> </span><br><span>     if (n=
ew_ipv6)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        /* Remove old IPv6 */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defi=
ned)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            unlearn_ifconfig_=
ipv6(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        /* Add new IPv6 */</span><br><span=
>         struct in6_addr new_addr6;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        CLEAR(new_addr6);</span><br><span>         if (inet_=
pton(AF_INET6, new_ipv6, &amp;new_addr6) =3D=3D 1</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            &amp;&amp; multi_learn_in6_addr(m, =
mi, new_addr6, -1, true))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            &amp;&amp; (!mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_def=
ined</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 || memcmp(&amp;new_addr6, &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_lo=
cal, sizeof(new_addr6))))</span><br><span>         {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* Remove old IPv6 */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (mi-&gt;cont=
ext=2Ec2=2Epush_ifconfig_ipv6_defined)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                unlearn_ifconfig_ipv6(m, mi);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            /* DCO needs the new address while installing it=
s on-link route=2E */</span><br><span>             mi-&gt;context=2Ec2=2Epu=
sh_ifconfig_ipv6_defined =3D true;</span><br><span>             mi-&gt;cont=
ext=2Ec2=2Epush_ifconfig_ipv6_local =3D new_addr6;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            /* set our client&#39;s VPN endpoi=
nt for status reporting purposes */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            mi-&gt;reporting_addr_ipv6 =3D mi-&gt;context=2Ec=
2=2Epush_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (multi_learn_in6_addr(m, mi, new_addr6, -1, true) =
=3D=3D mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 /* set our client&#39;s VPN endpoint for status reporting purposes */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                mi-&gt;r=
eporting_addr_ipv6 =3D mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                mi-&gt;context=2Ec2=2Ep=
ush_ifconfig_ipv6_defined =3D false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                CLEAR(mi-&gt;context=2Ec2=2Epush_ifconfig_=
ipv6_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_WARN=
, &quot;MULTI: failed to learn PUSH_UPDATE IPv6 address %s, restarting clie=
nt&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          new_ipv6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                /* PUSH_UPDATE is already queued, so reconnect to restore =
consistent state=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                send_restart(&amp;mi-&gt;context, NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                multi_schedule_cont=
ext_wakeup(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               return;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span>         }</span><br><span>     }</span><b=
r><span> }</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn=
/multi=2Eh</span><br><span>index 5db7147=2E=2E010fb9b 100644</span><br><spa=
n>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</=
span><br><span>@@ -730,8 +730,6 @@</span><br><span> #endif</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-update_vhash(struct multi_context *m, struct multi_instance *mi, const ch=
ar *new_ip, const char *new_ipv6);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void unlearn_ifconfig(struct multi_context *m, struct multi_in=
stance *mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void unle=
arn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+update_vaddr(struct mult=
i_context *m, struct multi_instance *mi, const char *new_ip, const char *ne=
w_ipv6);</span><br><span> </span><br><span> #endif /* MULTI_H */</span><br>=
<span>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</s=
pan><br><span>index 34cb26c=2E=2Ec0ecd1b 100644</span><br><span>--- a/src/o=
penvpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span>=
<br><span>@@ -149,14 +149,35 @@</span><br><span>     struct options o;</spa=
n><br><span>     CLEAR(o);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* Set canary values to detect ifconfig options =
in push-update messages=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-     * These placeholder strings will be overwritten to NULL by the op=
tion</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * parser if =
-ifconfig or -ifconfig-ipv6 options are present in the</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-     * push-update=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Set canary values to detect -ifco=
nfig and -ifconfig-ipv6 options in</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * push-update messages=2E These placeholder strings wil=
l be overwritten</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * to NULL by the option parser if -ifconfig or -ifconfig-ipv6 options</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * are present in t=
he push-update, to the new value if present, or</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * they will remain equal to the current va=
lues otherwise=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * If the current values are not defined they will remain NULL=2E</span><=
br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
const char *canary =3D &quot;canary&quot;;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    o=2Eifconfig_local =3D canary;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    o=2Eifconfig_ipv6_local =3D canary;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    char ifconfig_local[INET_ADDRSTRLEN]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in_addr=
 addr4 =3D { =2Es_addr =3D htonl(mi-&gt;context=2Ec2=2Epush_ifconfig_local)=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;c=
ontext=2Ec2=2Epush_ifconfig_defined)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (!inet_ntop(AF_INET, &amp;addr4, ifconfig_local, sizeof(ifcon=
fig_local)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=2Eifconfig_=
local =3D ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    char ifconfig_ipv6_loca=
l[INET6_ADDRSTRLEN];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (!inet_ntop(AF_INET6, &amp;mi-&gt;conte=
xt=2Ec2=2Epush_ifconfig_ipv6_local,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                       ifconfig_ipv6_local, sizeof(ifconfig=
_ipv6_local)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret=
urn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=2Eifconfi=
g_ipv6_local =3D ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span> </span><br><span>     struct buffe=
r_entry *e =3D msgs-&gt;head;</span><br><span>     while (e)</span><br><spa=
n>@@ -194,28 +215,10 @@</span><br><span> </span><br><span>     if (option_t=
ypes_found &amp; OPT_P_UP)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        /* -ifconfig */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!o=2Eifconfig_local &amp;&amp; =
mi-&gt;context=2Ec2=2Epush_ifconfig_defined)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            unlearn_ifconfig(m, mi);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        /* -ifconfig-ipv6 */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (!o=2Eifconfig_ipv6_local &amp;&amp; mi-&gt=
;context=2Ec2=2Epush_ifconfig_ipv6_defined)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            unlearn_ifconfig_ipv6(m, mi);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (o=2Eifconfig_local &amp;&amp; !strcmp(o=2Eifconfig_local, canary=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            o=2Eifconfig_local =
=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (o=2Eifconfig=
_ipv6_local &amp;&amp; !strcmp(o=2Eifconfig_ipv6_local, canary))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            o=2Eifconfig_ipv6_local =3D NUL=
L;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        /* new ifconfig or new ifconfig-ipv6 */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        update_vhash(m, mi=
, o=2Eifconfig_local, o=2Eifconfig_ipv6_local);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* ifconfig or ifconfig-ipv6 */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        update_vaddr(m, mi,=
 o=2Eifconfig_local, o=2Eifconfig_ipv6_local);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        uninit_options(&amp;o);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return !event_timeout_define=
d(&amp;c-&gt;c2=2Escheduled_exit);</span><br><span>     }</span><br><span> =
</span><br><span>     uninit_options(&amp;o);</span><br><span>diff --git a/=
tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/open=
vpn/mock_push_dependencies=2Ec</span><br><span>index bf2ccf3=2E=2Ec951a8f 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/mock_push_dependencies=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_push_dependencies=
=2Ec</span><br><span>@@ -48,17 +48,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-unlearn_ifconfig_ipv6(struct =
multi_context *m, struct multi_instance *mi)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-update_vhash(struct multi_context *m, struct multi_inst=
ance *mi, const char *new_ip, const char *new_ipv6)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+update_vaddr(struct multi_context *m, str=
uct multi_instance *mi, const char *new_ip, const char *new_ipv6)</span><br=
><span> {</span><br><span> }</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?usp=3Demail">change 2060</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I75b=
a77fcbb11790c7cc86cc436fc75ff99bd1c9e </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2060 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Marco Baffo &lt;mar=
co@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ykEp1jbA/EY=--


--===============7565000673464885621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7565000673464885621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7565000673464885621==--

