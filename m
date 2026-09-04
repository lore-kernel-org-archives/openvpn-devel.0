Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B777C624DE
	for <openvpn-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2AWas0LM4RVeO7Xs/ujAA5HLbacvt1VZPfZ7Ohvas40=; b=Z9wzVG/hwyo0taSYZEVXyVkxrl
	VIVkw9lsuaaol6EJ9NMhIT1aZvmGRr9Anfs9alC2I8K6RN4WhrNem5o2V6VSmRLQxfve3pvKmAUBd
	7zEE8rLPoi9xbBtL9Xhbp5PRsQ3DVreErdHuGQ9OTb5Xh7f5RCy1ZQVgJrOLL4wPHFmE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2QMe-0000ah-T7;
	Fri, 04 Sep 2026 09:37:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2QMd-0000ab-Tu
 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 09:37:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6UH14Yg8AjT6Bn0pY5lfenOB3BjnAJ1cXldcOXSJjCg=; b=Hu0aoijFpVpoJlSwucDACmrDDy
 i9Q2QhLQsz+P3GybxhlAz/gdQLcp/RoD7z1xaMbV4etO2y/0N5P9613BkC9s0lh3cxqBNbmrS/DYd
 DMpi8xGACGib4Seey5TXG9GBGuD2s/x09AbcRAr0E/q9PI+QjYCNiNkHUqwf2H3qAkRI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6UH14Yg8AjT6Bn0pY5lfenOB3BjnAJ1cXldcOXSJjCg=; b=G
 +kMYV4EG9S18sgFClwHuVMkabs7IOaemcxnOZHTm0Jk+VSsDWrcft7gijk41oEwXHeRsTN/g3l6eP
 VtpRJBFKjvt7d5F0OthnBBhIccLd/dXboY006c2MXA5ZedKEZT+uIQJRypxziegONh2+fOpekED2+
 8Xgienc0oAEnGYy4=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2QMa-0001OG-BW for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 09:37:37 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so8439205e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 04 Sep 2026 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788514650; x=1789119450; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6UH14Yg8AjT6Bn0pY5lfenOB3BjnAJ1cXldcOXSJjCg=;
 b=E3gAKJeyJnhEi0rib2rdfXQo6viSHO5lQstwRCO9MyJ31A7DBv5XHtQxQCdc4wary2
 wWoWbdG72BX2re1D9lc2eLkQixQj4/6dHZ7nuMcTgxiiU6GMUIEo5816pVRcCJYbUj9x
 yaCmkZFsjQbxrtDYlGU5H5XP2OBTYq3Bk1nXgPMesRDnCa+KHymzc+xyhsPnhBNHajxi
 cjjaB+QO0rNZPpR3/sYrNEGXWNjGoMA3rMIhidNyc7/pWAmyDd9XM/eYm2+Zlwv4eguJ
 BCQQTHKzi1ov4zT1ZaAqDtqFOkl6aydi16TsSnywxf7cKT/3InUKQEhgr83gVcqbx+5R
 1RWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788514650; x=1789119450;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6UH14Yg8AjT6Bn0pY5lfenOB3BjnAJ1cXldcOXSJjCg=;
 b=lEEFN32xTl2IIHCUbxxK+cOwxKi4bVd9kbRiSXw8yEEzW/XslWik4yBLRDGRxNQmCs
 JuC9KkVfj10mzq8iLvxINNb2X9gsN4Xq/owve2maa+RDnW3z5imMqDsHj/LYzh6WhDc1
 7Qfewd1s9rqy5EjGcUwe/a36qP5mQcp3WANY63n7lXs6G7z50agH70hqCDrqFqWXqmc0
 7kb2FWJhH7HPqIEeuEj07xFPr43w2hBaXMvyWcE7nBo7sos/ESbftiqW7+9Fhhwu2PLZ
 dslghgeARHn4OnJdFW96U14S6iEV5dTkMii0waXVzNd5zTXQkgfS9IfeK9LRwSEtq8K1
 QrWw==
X-Gm-Message-State: AFuF++lLtWvkwQaU36PpBHvhObQ/RAnE3Nl/WQOT863K/lUwQWN9HAL5
 TBHTSfaYK+TaAGJUoQDmoGBSPmfGU7smqlz5143sNt3gWQTYdNNZ2cC8jjnkCUnQvkj93mZI01Z
 7dDDvHR/qQGllAjr7UH5exiUd7FN3rPjwO9hBvANNnLlPIAfGsgGUq3JHV3NxFzuR0XUu
X-Gm-Gg: AYBFou398Rtx9k09qO+z4BaFkLxPB2FVXMZJH4/Or9p6qh5S09tMmHcgGBZjAH3ZxFU
 jAZHHG2Q2IAsZo8V6SlbS9RyjyAELkBUfDynPvYSrJ26l0aaerkFcP0N/c9K7NbjZK8mdQVLUS5
 iOmNDPVQS60DZcm3k/Ep/V5ibNAvwQYRm+lSv4dzEhBgtFguqdME2u9V7Uw1Rwmsv6uEh7rvUOK
 w1xWOxqW+7QCWWhOCc8P6iGzCxYPZ8sHZERv/v1YeZrQ+qnaZDwbvkkkARCvZOwTQ1W/80Yd+tk
 PmfFNdr6BEdwaefZmz4lnHNA54MmgSv+oKJi4nlS6+Ybx4XGssMZ1kl0wF3+/yP6L86Q5dpB+Fw
 WUT2DoNdLq5ienuUX/5AOop06W+/erNKGUxZhEMOA0eRbxZBMfaAY/xZSHxjpansYAiY5oDiBEP
 RaTOJqGko52hS0X11LOlilpFMfJl2+g0tpNW1ejdFgI63TztcLaequ58KwpuusMWVOLe2/V8X81
 4pvVCqc/csQBaQahn08onoR1EQBNfFDGpZ2ROCG/c52dUgsGYvKBl8jNFsFOVYJ7tGs0YXZSRaa
 TyAf7ncMDLBNn6I1MaC9TlHw3R2D47Lop1cr0fCzxtVuryQYIY8=
X-Received: by 2002:a05:600c:4585:b0:49c:fc6c:be16 with SMTP id
 5b1f17b1804b1-49cfea09f08mr5457135e9.28.1788514649551; 
 Fri, 04 Sep 2026 02:37:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce551bf7asm122422895e9.2.2026.09.04.02.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 02:37:29 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 4 Sep 2026 09:37:25 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic8c83132a4de64f27e6453ddb90ebcf137500db2
X-Gerrit-Change-Number: 1735
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1735?usp=email>
X-Gerrit-Commit: 5a088f96ab0d3b10e6d8c4f1bd3910a049909f1c
In-Reply-To: <gerrit.1782545314000.Ic8c83132a4de64f27e6453ddb90ebcf137500db2@gerrit.openvpn.net>
References: <gerrit.1782545314000.Ic8c83132a4de64f27e6453ddb90ebcf137500db2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkljOGM4MzEzMmE0ZGU2NGYyN2U2NDUzZGRiOTBlYmNmMTM3NTAwZGIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6f20a2c281617a6ca8ecb2fcccf8ceec765b5ee4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2QMa-0001OG-BW
Subject: [Openvpn-devel] [M] Change in openvpn[master]: init: create and
 destroy Linux DCO devices with --mktun/--rmtun
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9184235344653123565=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9184235344653123565==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ag3J0+y4Rt8="; charset=UTF-8

--Ag3J0+y4Rt8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1735?usp=3Demail

to look at the new patch set (#2)=2E

=
The following approvals got outdated and were removed:
Code-Review-1 by pla=
isthos


Change subject: init: create and destroy Linux DCO devices with --=
mktun/--rmtun
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


init: create and destroy Linux DCO devices with --mktun/--rmtun

When DCO=
 is enabled on Linux, make --mktun create an ovpn interface
instead of fall=
ing back to a TUN device=2E Set the ovpn interface mode
from --mode, using =
MP for server mode and P2P otherwise=2E Handle --rmtun
in the same branch b=
y deleting the ovpn interface through the networking
backend=2E

Users can =
still request the old userspace TUN behavior with
--disable-dco=2E

Change-=
Id: Ic8c83132a4de64f27e6453ddb90ebcf137500db2
Signed-off-by: Ralf Lici <ral=
f@mandelbit=2Ecom>
---
M src/openvpn/init=2Ec
1 file changed, 46 insertions=
(+), 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/35/1735/2

diff --git a/src/openvpn/init=2Ec b/src/openvpn/in=
it=2Ec
index 1109a13=2E=2Eea1802d 100644
--- a/src/openvpn/init=2Ec
+++ b/s=
rc/openvpn/init=2Ec
@@ -1085,21 +1085,59 @@
     }
 
 #if defined(ENABLE_DC=
O)
-    if (dco_enabled(options))
+    if (dco_enabled(options) && dev_type=
_enum(options->dev, options->dev_type) =3D=3D DEV_TYPE_TUN)
     {
-       =
 /* creating a DCO interface via --mktun is not supported as it does not
- =
        * make much sense=2E Since DCO is enabled by default, people may ru=
n into
-         * this without knowing, therefore this case should be prop=
erly handled=2E
+#if defined(TARGET_LINUX)
+        if (options->persist_mo=
de)
+        {
+            /* dco_available autoloads the kernel module=2E=
 Use D_DCO_DEBUG
+             * because it could print "disabling data cha=
nnel offload" which is
+             * misleading if you immediately fatal=
=2E
+             */
+            if (!dco_available(D_DCO_DEBUG))
+       =
     {
+                msg(M_FATAL, "Cannot create DCO device: ovpn kernel=
 support unavailable=2E "
+                             "Install ovpn or us=
e --disable-dco to create a TUN device=2E");
+            }
+
+            =
struct tuntap *tt;
+
+            ALLOC_OBJ_CLEAR(tt, struct tuntap);
+    =
        tt->type =3D DEV_TYPE_TUN;
+            tt->backend_driver =3D DRIV=
ER_DCO;
+            tt->dco=2Eifmode =3D options->mode =3D=3D MODE_SERVER =
? OVPN_MODE_MP : OVPN_MODE_P2P;
+
+            open_tun(options->dev, optio=
ns->dev_type, options->dev_node, tt, ctx);
+            msg(M_INFO, "Create=
d DCO device %s in %s mode", tt->actual_name,
+                options->mod=
e =3D=3D MODE_SERVER ? "server" : "p2p");
+            free(tt->actual_name=
);
+            free(tt);
+            return true;
+        }
+        els=
e
+        {
+            int ret =3D net_iface_del(ctx, options->dev);
+  =
          if (ret < 0)
+            {
+                msg(M_FATAL, "Cannot=
 remove DCO device %s: %s (%d)", options->dev,
+                    strerro=
r(-ret), ret);
+            }
+            msg(M_INFO, "Deleted DCO device =
%s", options->dev);
+            return true;
+        }
+#else  /* if defi=
ned(TARGET_LINUX) */
+        /* creating a non-Linux DCO interface via --m=
ktun is not supported as it
+         * does not make much sense=2E Since D=
CO is enabled by default, people may
+         * run into this without know=
ing, therefore this case should be properly
+         * handled=2E
        =
  *
          * Disable DCO if --mktun was provided and print a message to =
let
          * user know=2E
          */
-        if (dev_type_enum(option=
s->dev, options->dev_type) =3D=3D DEV_TYPE_TUN)
-        {
-            msg=
(M_WARN, "Note: --mktun does not support DCO=2E Creating TUN interface=2E")=
;
-        }
+        msg(M_WARN, "Note: --mktun does not support DCO=2E Cr=
eating TUN interface=2E");
 
         options->disable_dco =3D true;
+#endi=
f /* defined(TARGET_LINUX) */
     }
 #endif
 

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1735?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ic8c83132a4de64f27e6453ddb90ebcf137500db2
Ge=
rrit-Change-Number: 1735
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@m=
andelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--Ag3J0+y4Rt8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ralf_lici <strong>uploaded patch=
 set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1735?usp=3Demail">View Change</a></p><p>The following ap=
provals got outdated and were removed:
Code-Review-1 by plaisthos</p><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">init: create and destroy Linux DCO devices with --mktun/--rmtun<br>=
<br>When DCO is enabled on Linux, make --mktun create an ovpn interface<br>=
instead of falling back to a TUN device=2E Set the ovpn interface mode<br>f=
rom --mode, using MP for server mode and P2P otherwise=2E Handle --rmtun<br=
>in the same branch by deleting the ovpn interface through the networking<b=
r>backend=2E<br><br>Users can still request the old userspace TUN behavior =
with<br>--disable-dco=2E<br><br>Change-Id: Ic8c83132a4de64f27e6453ddb90ebcf=
137500db2<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;<br>---<b=
r>M src/openvpn/init=2Ec<br>1 file changed, 46 insertions(+), 8 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/35/1735/2</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/sr=
c/openvpn/init=2Ec</span><br><span>index 1109a13=2E=2Eea1802d 100644</span>=
<br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=
=2Ec</span><br><span>@@ -1085,21 +1085,59 @@</span><br><span>     }</span><=
br><span> </span><br><span> #if defined(ENABLE_DCO)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (dco_enabled(options))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(options) &amp=
;&amp; dev_type_enum(options-&gt;dev, options-&gt;dev_type) =3D=3D DEV_TYPE=
_TUN)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* creating a DCO interface via --mktun is not supported as =
it does not</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         *=
 make much sense=2E Since DCO is enabled by default, people may run into</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-         * this without =
knowing, therefore this case should be properly handled=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;persis=
t_mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* dco_ava=
ilable autoloads the kernel module=2E Use D_DCO_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             * because it could print &qu=
ot;disabling data channel offload&quot; which is</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             * misleading if you immediately f=
atal=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (=
!dco_available(D_DCO_DEBUG))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                msg(M_FATAL, &quot;Cannot create DCO device: ovpn kernel=
 support unavailable=2E &quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                             &quot;Install ovpn or use --disable=
-dco to create a TUN device=2E&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      struct tuntap *tt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            AL=
LOC_OBJ_CLEAR(tt, struct tuntap);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            tt-&gt;type =3D DEV_TYPE_TUN;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            tt-&gt;backend_driver =3D D=
RIVER_DCO;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   tt-&gt;dco=2Eifmode =3D options-&gt;mode =3D=3D MODE_SERVER ? OVPN_MODE_=
MP : OVPN_MODE_P2P;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            open_tu=
n(options-&gt;dev, options-&gt;dev_type, options-&gt;dev_node, tt, ctx);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INFO=
, &quot;Created DCO device %s in %s mode&quot;, tt-&gt;actual_name,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                options-&gt=
;mode =3D=3D MODE_SERVER ? &quot;server&quot; : &quot;p2p&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            free(tt-&gt;actua=
l_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 free(tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            int ret =3D net_ifa=
ce_del(ctx, options-&gt;dev);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (ret &lt; 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                msg(M_FATAL, &quot;Cannot remove DCO device %s:=
 %s (%d)&quot;, options-&gt;dev,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    strerror(-ret), ret);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            msg(M_INFO, &quot;Deleted DCO devi=
ce %s&quot;, options-&gt;dev);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#else  /* if defined(TARGET_LINUX) */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* creating a non-Linux DCO interface via -=
-mktun is not supported as it</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+         * does not make much sense=2E Since DCO is enabled by de=
fault, people may</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * run into this without knowing, therefore this case should be prope=
rly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * handl=
ed=2E</span><br><span>          *</span><br><span>          * Disable DCO i=
f --mktun was provided and print a message to let</span><br><span>         =
 * user know=2E</span><br><span>          */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (dev_type_enum(options-&gt;dev, options-&=
gt;dev_type) =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            msg(M_WARN, &quot;Note: --mktun does not support DCO=2E Creatin=
g TUN interface=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(M_WARN, &quot;Note: --mktun does not support DCO=2E Creating TUN int=
erface=2E&quot;);</span><br><span> </span><br><span>         options-&gt;di=
sable_dco =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif /* defined(TARGET_LINUX) */</span><br><span>     }</span><br><span> =
#endif</span><br><span> </span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?usp=3Demail">cha=
nge 1735</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ic8c83132a4de64f27e6453ddb90ebcf137500db2 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1735 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lic=
i &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Ag3J0+y4Rt8=--


--===============9184235344653123565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9184235344653123565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9184235344653123565==--

