Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C21C43458
	for <openvpn-devel@archiver.kernel.org>; Sat, 27 Jun 2026 07:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=e3aO4JFeMH8fxt9YOUMS3bptt6+x4wGJvq1cCTSRY08=; b=O+S9mnsh9rjLdA
	vBiUnSOSQERoKalFYhwGjBbYwXqRTqTx1NESqi9MzxXLcfCyQHRz1hDhhSvmZZiAqyVZwqOuGPKg6
	wpZb9o7ZWnVMZy4pGZlMg0KE4bOdhcP196oBiwaoa3CCh4ytfEKfJy2STM8XT0/72FQnmdHzdnDsb
	AtI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdNTB-0002aD-U5;
	Sat, 27 Jun 2026 07:28:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdNTA-0002Zw-GU
 for openvpn-devel@lists.sourceforge.net;
 Sat, 27 Jun 2026 07:28:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kJzeHLqqFHKVsyM4tau9SvhOF+1mAO46kYNjjNEk/3A=; b=WZC5D0PgZa8UpxiMyH0MzjFIjn
 yFZhkmUlwOfgQCen48JXGJkYOVvVNUWhSZQ0tAoeuME+rAQ/kpVjWxasVykJAVzMmzQHwtWTPCi7M
 KfeTLnNBAzJNKyuCTRaI2QFIW4Ri5WdLl8pQge7smgF5zDm2PGumF3vmAsXBFn/IQdcY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kJzeHLqqFHKVsyM4tau9SvhOF+1mAO46kYNjjNEk/3A=; b=L
 EsfAVjOjcO8fH3YWwWPqIcMcAkFtFeAi7Y+Oz8KnfZxY0Nm6jlVr7XRPZYiwihjtTbQQuCMwbyXVU
 rHzd8t1jKxgN589SqfWf1D98KWRrnDH8MqJPTV9v8Lqn3L/8ZRs9n0657Y2eqLpRAO6tCHnAy9Tmw
 9WQkp+1z9/1rUPEE=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdNT9-000557-9W for openvpn-devel@lists.sourceforge.net;
 Sat, 27 Jun 2026 07:28:53 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-46f34d8f888so1379148f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 27 Jun 2026 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782545320; x=1783150120; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJzeHLqqFHKVsyM4tau9SvhOF+1mAO46kYNjjNEk/3A=;
 b=UyTkOIH+Squgzok5WsGbXqzg2ioPEXvDawRzwt6kwPaJ1e1KvvUcSJEuHEdlniGfO5
 U2uHk16u/gsky72xyEOwOaVdrVeCO9uyTEfnNBjy9FQcKmJfZqDhe/TcA/sHAAHvWh4H
 2lhd2FtuorP7I8eHFigzFbPdbaUMZwHhKKpMyR7jjUZIPVXFgaZg0+oA57Sc4fnpgj2e
 X6kB3ytNvc66qLMaksXu0LiEjx6foMR4kXBJCbjjNknfdHCV03y58Q3W4uNGSJSWiBRd
 vpFXC+8LA+7KMhPtvfdDo/eLjZ/+tnSciXwqTuCYFZszXZUHZaU0jD3FXnUW17iN609Z
 K5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782545320; x=1783150120;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kJzeHLqqFHKVsyM4tau9SvhOF+1mAO46kYNjjNEk/3A=;
 b=BfmsQbu80njitW2g7NgbA+1r348XOSVueWQ26sryjKf7vPyQeLzVRh/68SbGdJExB2
 gmLrXb+8ev5QjFFO74nLGzlylR3sFLzTPVG/AbteV2jk7kjQ/iGQFd0hROfMtPNFrSqf
 yBD3VBEKHTEWf1IXPJwDX3wv+qQPSKa1ke115txL8GBHEyfntT/j2x1DVEm6AlhHUHHO
 3oihUWJT0pxh61HOinDCHHy0JEnvol5Gq/S0HgH91l0fqQBCCaL7EEWDKcSmY0QgcDEX
 OXfprzh0ezyF8obplLLSn/0grGLEBDVvzXh+neg0UIsGSjgxtXJx0yyrdRiXtH4KZY2q
 Dn4Q==
X-Gm-Message-State: AOJu0YwzJZLxwHOj6/c1EPrKjjxL1VhbNRKzr7xHvDQm9qEj9U/Pbmc4
 XNAh9g6nd+8YxLQ+DZF59xdRXZvi4m+xvRka8VNdkZGV3lPbUzcn1wOqIouoav6k5qtwvjSB0PE
 iav5A+2U/ZSknvDGv65VT/8n0Zn8yPPXyT4wAvrb7qUoS8UkS6uoQJQlAff+as8nfNdXbpvOFLk
 HnFZbXKA==
X-Gm-Gg: AfdE7cnc2Og2TfGJgpQsN+UQP42fFYVCf8+KxT5A6s6bc0JWIy23KqVbNTOPFTC+Ppt
 myCt/hBQyWyfVfbzb1n35gReTOVjZMNZy4g85EGBHvBaUVzebOlETzoVRH24qp+CPXE+0IPwE1O
 cFJzeWHL/8/s8LeSKVOxmWDpBINwuU0N/IJWBh5G8+fF3jDmr6YLS5ybOMZ8PiItmHT4VpIIdv7
 198bLF6U5XFtujOg9P1siy7qF36vsbP5E0JNnpMmqBCkL6+b1XwjPJIWUBjUbhdCtO99ZY0CWqe
 4vsM59bfniVz1X1vWe7yLkmoSnmH8x1ehCdL30y5wUGTnmFNr/yekdb+nM8ogNtyp3QLjE88ti+
 SyHMU9cTYNrrDWFAy1/dT85I1VKbGUnuKnaHF2kI6v1VouGVpW+UED0M9rBw8xjI6FL/n+h7yqd
 cd8jKZSZ8P+3jH2f1eP7MCd28i5P3tgW3oU3W225OYlepvwdLLyo1guTFEE4GhmBpS5/bG//Cgr
 0znZiPN+T/aUAttWIsBC2v0wPcXkJL5rwcQNTqTU/YhXVov1rqBBI58jF0TyAAJtcwjiVzHLsTM
 5DE=
X-Received: by 2002:a5d:5f53:0:b0:465:d0f9:95e3 with SMTP id
 ffacd0b85a97d-46dbfca2d6fmr15926927f8f.19.1782545320121; 
 Sat, 27 Jun 2026 00:28:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46ebf4e1b95sm14089723f8f.1.2026.06.27.00.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 00:28:39 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 27 Jun 2026 07:28:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic8c83132a4de64f27e6453ddb90ebcf137500db2
X-Gerrit-Change-Number: 1735
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1735?usp=email>
X-Gerrit-Commit: f0a65c3eb248ff25a418ac3403cd603bd5364782
References: <gerrit.1782545314000.Ic8c83132a4de64f27e6453ddb90ebcf137500db2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkljOGM4MzEzMmE0ZGU2NGYyN2U2NDUzZGRiOTBlYmNmMTM3NTAwZGIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f84a476f94a019492034ebc706e3912a3080f284-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdNT9-000557-9W
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: create and
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
Content-Type: multipart/mixed; boundary="===============3101048290784149330=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3101048290784149330==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="z7//ZvV+dV0="; charset=UTF-8

--z7//ZvV+dV0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1735?usp=3Demail

to review the following change=2E


Chang=
e subject: init: create and destroy Linux DCO devices with --mktun/--rmtun
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: create =
and destroy Linux DCO devices with --mktun/--rmtun

When DCO is enabled on =
Linux, make --mktun create an ovpn interface
instead of falling back to a T=
UN device=2E Set the ovpn interface mode
from --mode, using MP for server m=
ode and P2P otherwise=2E Handle --rmtun
in the same branch by deleting the =
ovpn interface through the networking
backend=2E

Users can still request t=
he old userspace TUN behavior with
--disable-dco=2E

Change-Id: Ic8c83132a4=
de64f27e6453ddb90ebcf137500db2
Signed-off-by: Ralf Lici <ralf@mandelbit=2Ec=
om>
---
M src/openvpn/init=2Ec
1 file changed, 32 insertions(+), 8 deletion=
s(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
35/1735/1

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index c=
aaa769=2E=2Ec71081f 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/ini=
t=2Ec
@@ -1109,19 +1109,43 @@
     }
 
 #if defined(ENABLE_DCO)
-    if (dc=
o_enabled(options))
+    if (dco_enabled(options) && dev_type_enum(options-=
>dev, options->dev_type) =3D=3D DEV_TYPE_TUN)
     {
-        /* creating a=
 DCO interface via --mktun is not supported as it does not
-         * make=
 much sense=2E Since DCO is enabled by default, people may run into
-      =
   * this without knowing, therefore this case should be properly handled=
=2E
+#if defined(TARGET_LINUX)
+        if (options->persist_mode)
+       =
 {
+            struct tuntap *tt;
+
+            ALLOC_OBJ_CLEAR(tt, struc=
t tuntap);
+            tt->type =3D DEV_TYPE_TUN;
+            tt->backend=
_driver =3D DRIVER_DCO;
+            tt->dco=2Eifmode =3D options->mode =3D=
=3D MODE_SERVER ? OVPN_MODE_MP : OVPN_MODE_P2P;
+
+            open_tun(opt=
ions->dev, options->dev_type, options->dev_node, tt, ctx);
+            fre=
e(tt->actual_name);
+            free(tt);
+            msg(M_INFO, "Create=
d DCO device %s in %s mode", options->dev, options->mode =3D=3D MODE_SERVER=
 ? "server" : "p2p");
+        }
+        else
+        {
+            int =
ret =3D net_iface_del(ctx, options->dev);
+            if (ret < 0)
+      =
      {
+                msg(M_FATAL, "Cannot remove DCO device %s: %s (%d)=
", options->dev, strerror(-ret), ret);
+            }
+            msg(M_IN=
FO, "Deleted DCO device %s", options->dev);
+        }
+        return true=
;
+#endif /* defined(TARGET_LINUX) */
+        /* creating a non-Linux DCO =
interface via --mktun is not supported as it
+         * does not make much=
 sense=2E Since DCO is enabled by default, people may
+         * run into =
this without knowing, therefore this case should be properly
+         * ha=
ndled=2E
          *
          * Disable DCO if --mktun was provided and pr=
int a message to let
          * user know=2E
          */
-        if (dev=
_type_enum(options->dev, options->dev_type) =3D=3D DEV_TYPE_TUN)
-        {=

-            msg(M_WARN, "Note: --mktun does not support DCO=2E Creating T=
UN interface=2E");
-        }
+        msg(M_WARN, "Note: --mktun does not =
support DCO=2E Creating TUN interface=2E");
 
         options->disable_dco=
 =3D true;
     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1735?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
c8c83132a4de64f27e6453ddb90ebcf137500db2
Gerrit-Change-Number: 1735
Gerrit-=
PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@r=
fc2549=2Eorg>

--z7//ZvV+dV0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ralf_lici would like plaisthos t=
o <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1735?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">init: create and destroy Linux DCO devices with --mktun/--rmtun<br><br>=
When DCO is enabled on Linux, make --mktun create an ovpn interface<br>inst=
ead of falling back to a TUN device=2E Set the ovpn interface mode<br>from =
--mode, using MP for server mode and P2P otherwise=2E Handle --rmtun<br>in =
the same branch by deleting the ovpn interface through the networking<br>ba=
ckend=2E<br><br>Users can still request the old userspace TUN behavior with=
<br>--disable-dco=2E<br><br>Change-Id: Ic8c83132a4de64f27e6453ddb90ebcf1375=
00db2<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;<br>---<br>M =
src/openvpn/init=2Ec<br>1 file changed, 32 insertions(+), 8 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/35/1735/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/op=
envpn/init=2Ec</span><br><span>index caaa769=2E=2Ec71081f 100644</span><br>=
<span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec=
</span><br><span>@@ -1109,19 +1109,43 @@</span><br><span>     }</span><br><=
span> </span><br><span> #if defined(ENABLE_DCO)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (dco_enabled(options))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(options) &amp;&amp;=
 dev_type_enum(options-&gt;dev, options-&gt;dev_type) =3D=3D DEV_TYPE_TUN)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        /* creating a DCO interface via --mktun is not supported as it doe=
s not</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * make =
much sense=2E Since DCO is enabled by default, people may run into</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-         * this without knowin=
g, therefore this case should be properly handled=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;persist_mod=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            struct tuntap *=
tt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            ALLOC_OBJ_CLEAR(tt, str=
uct tuntap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     tt-&gt;type =3D DEV_TYPE_TUN;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            tt-&gt;backend_driver =3D DRIVER_DCO;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            tt-&gt;dco=2Eifmod=
e =3D options-&gt;mode =3D=3D MODE_SERVER ? OVPN_MODE_MP : OVPN_MODE_P2P;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            open_tun(options-&gt;dev, op=
tions-&gt;dev_type, options-&gt;dev_node, tt, ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            free(tt-&gt;actual_name);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            free(tt);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INF=
O, &quot;Created DCO device %s in %s mode&quot;, options-&gt;dev, options-&=
gt;mode =3D=3D MODE_SERVER ? &quot;server&quot; : &quot;p2p&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            int ret =3D net_iface_del(ctx, options-&gt=
;dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     msg(M_FATAL, &quot;Cannot remove DCO device %s: %s (%d)&quot;, options=
-&gt;dev, strerror(-ret), ret);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(M_INFO, &quot;Deleted DCO device %s&quot;, options-&g=
t;dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* defined(TAR=
GET_LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* creating a non-Linux DCO interface via --mktun is not supported as it<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * does not =
make much sense=2E Since DCO is enabled by default, people may</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * run into this without=
 knowing, therefore this case should be properly</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         * handled=2E</span><br><span>        =
  *</span><br><span>          * Disable DCO if --mktun was provided and pri=
nt a message to let</span><br><span>          * user know=2E</span><br><spa=
n>          */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (dev_type_enum(options-&gt;dev, options-&gt;dev_type) =3D=3D DEV_TYPE_T=
UN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;=
Note: --mktun does not support DCO=2E Creating TUN interface=2E&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Note: --m=
ktun does not support DCO=2E Creating TUN interface=2E&quot;);</span><br><s=
pan> </span><br><span>         options-&gt;disable_dco =3D true;</span><br>=
<span>     }</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?usp=3Demail">change 1735</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic8c831=
32a4de64f27e6453ddb90ebcf137500db2 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1735 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--z7//ZvV+dV0=--


--===============3101048290784149330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3101048290784149330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3101048290784149330==--

