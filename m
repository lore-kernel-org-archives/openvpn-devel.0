Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3D1CCA490
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 09:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ha8f9HZiakIWeTdcv1OwSLG+WkkQrpMVXOGwJ7nhbdQ=; b=JwM6WkX5a0XNH8C0DLaDH/WvpB
	2e+znELMCt0vZ7x5VKFutcbTDe8BXnj+40dpAavALT0OmsKbmKljO8KdjXTzCleV5gfqt1XUqnwWL
	h+s07rUacjNm6Q4wxRCVaeBY+k78JIxFyMQ/+Sh46Jpj0HyLW3l3QWeVduDXJBFXvIV8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xINZO-0002l4-61;
	Sun, 18 Oct 2026 09:52:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xINZN-0002ky-62
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 09:52:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NBzmD7poYgdbSVH9I1FhSTje3YLDQ4uiPccHOeLAxfA=; b=ZnoyFo1TvF1SyvtQW8Xdh26Wgb
 V3ptet2h5qGNK+yIgNF838vU5xpwr859wyODj8puDzLUrxNVqTh/guI9HuOpMJ2LVPNcSAEfsiIq9
 IILEwwRCY2UM4NKfVyd8Q6CzVkaRXJZoWWlA0+10OIsgq14v7HlJfqUQIrjOOmF9t4Es=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NBzmD7poYgdbSVH9I1FhSTje3YLDQ4uiPccHOeLAxfA=; b=J
 bi90L6vWSYPOJOYg4Cxx6DyRQH4KP4osydy6u2IM1/LdVJ5zbvz6IPdMTg82VjRnOAqgAdVeFqxJ5
 TQ07OyoaL/XF133f6879l2lJBbtCjwDz+dNjOg48oEnxdl+HJk7P3l7mYsm0QR6tl6YQSnUQxPLIf
 FeeO7nnKwW5yTeEw=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xINZL-0002lk-6F for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 09:52:45 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so656110f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 02:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792317157; x=1792921957; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NBzmD7poYgdbSVH9I1FhSTje3YLDQ4uiPccHOeLAxfA=;
 b=EcfOhjS2YcyVktyExi2pKFpobN+mkP13adZb3e7a0G006NC5OEpTHIcB+fmSilDQjs
 lC+Ij7+TeWj5VqUobsdwbD7A1wfqjaFz98ZgmZvkKklfqyqxmTWA/EDnezmD8XRVT+Qv
 KHH5bISFitWxIpPlerQkyxnFVrJO+YmXLIykJYMCjhyBzHn2a4yCqs7B0dvFij1VksOW
 z7s87pnidcl2zZslMrU5OcVRBG6vKNqss3vXZLB5IeQPtHnhHZsiQGdc//gMDRKFE4Ih
 yyLcI+xgEr/oIERU2P8qk6qujFPbgNgNRVCw53S/fYmFEsa7wTwL6m7OwSlxDBx4TtCE
 lTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792317157; x=1792921957;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NBzmD7poYgdbSVH9I1FhSTje3YLDQ4uiPccHOeLAxfA=;
 b=lCOZNAtocn3QWNQSBOCQrTReRWSy9roD7z8fi7Fcg62tH+2//xH8XFcu3F/p5z2+Ur
 ZnfYPZcJA2XM8sGAFKckXRX079A8+EkcLPcL1CmAXzhOuvxpJnaix9KdBwKZ9Q+oAD1M
 194/+1rwqYUokrOCu+/yL0jGNcqRbGpui7FvF5yY9fWo2oydly+Zhz7dUCZ4nZYo4isC
 RwBK2fkVuLS0adhGcr/X8Bf9X0/xK0KWMSTmWMsTl67IshUUSwY1lm7QOWdXADQQ6rTH
 4vfB+QqmLkK4T6aVNEZ+PNJ+4aVBKFCR9YF0Q9X4IH76QUghLcVvlOAVZ6+2mQ5KA5/H
 BhBg==
X-Gm-Message-State: AFq9FYKBgbxrIPrx8qpf6NW7l0AwsyDg+wJ+GpnZZHC4nuScNsCngjYV
 lkvqJ9whlmsOgrwpuNjUCCgYI80IKzM9glaYnzBJeFwUgTN2XlrjkvRE1BndVWW9Qa9lLuO5159
 wRI67zQ5EQ4XyjPbTy95pdtw2fQweM4crStH4eurt0iSew3Mmve+2Nj/RB7tabxRBr+zvaD6PNS
 azco5h5w==
X-Gm-Gg: AYBFou3XaAjET2+/YDm/SpZzzsmjs4vraTS+ccArD1pvNHTjiwhRIpgIwQtzdzkep5l
 ZMvHSJTeiFYAnmpd492w+ybUPVOPz1OExY0mugYP9hy8C9FOVMwoeXX8KMx0V/hjtsXpFv6HHEX
 w58Y0NheMuMfA3ywM3URBb1QAYYwubniIIiRJSQpf9O53GGFQQnekxQ8vnE5eq1qC7iU81z/YnU
 W6YP0DlSx2we+mlel7eR1z9rFkeQt+6s5E95mLYOKNMLiQ6mhux67uwNohU1F74ryj3yTqa01xa
 /iC+uQx/QkjokqrRWC/71eSVA4bfnEruBkNn4SodMoUM8wuE2drmp61PVTOmHH+9lQwSbIiM3qu
 pIkOkxuDFPfkYEPzjibkJbwn6lzt8zlWbjSpFjqfQm/Rwp7f3WpEXLC3DYlcXWbxUR7zK4dMdy2
 Ht0rsYcc8DQ6632u89sdvDu/B38TfEqW1gWo7MR2fOyk5azgGaOa+jxTy4Kp62rubAo+7u0S5at
 upNP8/WAMnUEvRwicYMeG0TqZokcQucqGjQUuNQTj7Y4I4709BF01VaG5g/iS2eVdjlJDhGptT1
 XYLVAk305Mq4Z5SXe43WR0j+0EKpXETjH+DwGUxdc6tRe+fGMWU6Yu3mRQ7k
X-Received: by 2002:a05:6000:470f:b0:48d:ff0b:9b52 with SMTP id
 ffacd0b85a97d-48e07fb2ab5mr7379471f8f.19.1792317156355; 
 Sun, 18 Oct 2026 02:52:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd50d080sm16203847f8f.53.2026.10.18.02.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 02:52:35 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 09:52:34 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 2b8e1791c89fe2b5ea9f63b1fdb874771db2a4b3
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <35c6db4aebbfcd87d3695ee62d747252daf3bb10-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xINZL-0002lk-6F
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8960908525024847148=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8960908525024847148==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eog7lOYs3k0="; charset=UTF-8

--eog7lOYs3k0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd l=
ike you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1852?usp=3Demail

to look at the new patch set (#13)=2E
=

The following approvals got outdated and were removed:
Code-Review-1 by Fr=
ank Lichtenheld


Change subject: Add unix-script functionality to the --ma=
nagement feature
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Add unix-script functionality to the --management feature

This allows=
 a script that handles management input/output to
be started alongside Open=
VPN simpler in small deployments=2E

Change-Id: I307e64079f436aa782f7e24bff=
f665a545ad2fa0
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M doc/m=
an-sections/management-options=2Erst
M doc/management-notes=2Etxt
M src/ope=
nvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openv=
pn/options=2Ec
M src/openvpn/options=2Eh
7 files changed, 128 insertions(+)=
, 11 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/52/1852/13

diff --git a/doc/man-sections/management-options=2E=
rst b/doc/man-sections/management-options=2Erst
index 8dad52b=2E=2Ee2e0773 =
100644
--- a/doc/man-sections/management-options=2Erst
+++ b/doc/man-sectio=
ns/management-options=2Erst
@@ -14,6 +14,7 @@
     management socket-name u=
nix pw-file  # (recommended)
     management IP port                   # (I=
NSECURE)
     management IP port pw-file           #
+    management script=
 unix-script
 
   ``pw-file``, if specified, is a password file where the p=
assword must
   be on first line=2E Instead of a filename it can use the ke=
yword stdin
@@ -25,6 +26,14 @@
   ``--management-client-user`` and ``--mana=
gement-client-group``
   directives to restrict access=2E
 
+  When the var=
iant :code:`unix-script` is used, OpenVPN will start the
+  specified scrip=
t on startup and enable ``--management-hold``=2E
+  OpenVPN will generate a=
 random path for the unix socket
+  and management password=2E These are pa=
ssed as environment
+  variables :code:`MANAGEMENT_SOCKET`, :code:`MANAGEME=
NT_PASSWORD`
+  to the script when being started=2E When OpenVPN terminates=
 it sends
+  a :code:`SIGINT` signal to the running script=2E
+
   The mana=
gement interface provides a special mode where the TCP
   management link c=
an operate over the tunnel itself=2E To enable this mode,
   set IP to ``tu=
nnel``=2E Tunnel mode will cause the management interface to
@@ -127,10 +13=
6,11 @@
   (client-only)=2E
 
 --management-signal
-  Send SIGUSR1 signal t=
o OpenVPN if management session disconnects=2E This
-  is useful when you w=
ish to disconnect an OpenVPN session on user logoff=2E
-  For ``--managemen=
t-client`` this option is not needed since a disconnect
-  will always gene=
rate a :code:`SIGTERM`=2E
+  Send :code:`SIGUSR1` signal to OpenVPN if mana=
gement session disconnects=2E
+  This is useful when you wish to disconnect=
 an OpenVPN session on user
+  logoff=2E For ``--management-client`` or ``-=
-management`` with
+  :code:`unixscript` this option has no effect since a =
disconnect will
+  always trigger sending a :code:`SIGTERM`=2E
 
 --managem=
ent-up-down
   Report tunnel up/down events to management interface=2E
diff=
 --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt
index 412b=
79b=2E=2E325f8bd 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/manageme=
nt-notes=2Etxt
@@ -35,6 +35,10 @@
 you can telnet to the management port (m=
ake sure to use
 a telnet client which understands "raw" mode)=2E
 
+When p=
assword authentication is enabled, the management interface
+will require s=
ending the password on its own line after establishing
+the connection=2E
+=

 Once connected to the management port, you can use
 the "help" command to=
 list all commands=2E
 
diff --git a/src/openvpn/init=2Ec b/src/openvpn/ini=
t=2Ec
index 3c2ebf9=2E=2E8014a02 100644
--- a/src/openvpn/init=2Ec
+++ b/sr=
c/openvpn/init=2Ec
@@ -4341,19 +4341,62 @@
     }
 }
 
+void
+run_managemen=
t_script(struct context *c)
+{
+#if UNIX_SOCK_SUPPORT
+    struct gc_arena =
gc =3D gc_new();
+    struct argv argv =3D argv_new();
+    struct env_set =
*env =3D env_set_create(&gc);
+
+    setenv_str(env, "MANAGEMENT_USER", man=
agement->settings=2Eup=2Eusername);
+    setenv_str(env, "MANAGEMENT_PASSWO=
RD", management->settings=2Eup=2Epassword);
+    setenv_str(env, "MANAGEMEN=
T_SOCKET", c->options=2Emanagement_addr);
+
+    argv_printf(&argv, "%s", c=
->options=2Emanagement_script);
+
+    int flags =3D S_NOWAITPID | S_SCRIPT=
 | S_FATAL;
+    int *pid =3D &management->connection=2Eunix_script_pid;
+ =
   const char *msg_prefix =3D "WARNING: Failed running management unix-scri=
pt";
+    *pid =3D openvpn_execve_check(&argv, env, flags, msg_prefix);
+
+=
    if (!openvpn_waitpid_check(*pid, msg_prefix, M_FATAL))
+    {
+        =
*pid =3D 0;
+    }
+
+    argv_free(&argv);
+    gc_free(&gc);
+#else
+    =
msg(M_FATAL, "ERROR: Management unix-socket support is not available on thi=
s platform");
+#endif
+}
+
 bool
 open_management(struct context *c)
 {
   =
  /* initialize management layer */
     if (management)
     {
+        un=
signed int flags =3D c->options=2Emanagement_flags;
+        if (flags & MF=
_UNIX_SOCK_SCRIPT)
+        {
+            /* This creates a filename that =
should be unguessable */
+            char sockname[64] =3D { 0 };
+       =
     snprintf(sockname, sizeof(sockname),
+                     PACKAGE_NAM=
E "_omi_%08" PRIx64 "%08" PRIx64 "=2Esock",
+                     get_rando=
m(), get_random());
+
+            c->options=2Emanagement_addr =3D platfor=
m_gen_path(platform_get_tmp_dir(), sockname, &c->gc);
+        }
+
        =
 if (c->options=2Emanagement_addr)
         {
-            unsigned int fla=
gs =3D c->options=2Emanagement_flags;
             if (c->options=2Emode =
=3D=3D MODE_SERVER)
             {
                 flags |=3D MF_SERVER;
 =
            }
+
             if (management_open(
                     mana=
gement, c->options=2Emanagement_addr, c->options=2Emanagement_port,
       =
              c->options=2Emanagement_user_pass, c->options=2Emanagement_cl=
ient_user,
@@ -4365,6 +4408,11 @@
                                      NUL=
L);
             }
 
+            if (flags & MF_UNIX_SOCK_SCRIPT)
+       =
     {
+                run_management_script(c);
+            }
+
        =
     /* initial management hold, called early, before first context initial=
ization */
             do_hold(0);
             if (IS_SIG(c))
diff --git =
a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index e15d7bd=2E=2Eaf3bfd=
3 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -46,6=
 +46,7 @@
 #include "multi=2Eh"
 
 #include "memdbg=2Eh"
+#include "run_com=
mand=2Eh"
 
 #ifdef ENABLE_PKCS11
 #include "pkcs11=2Eh"
@@ -333,10 +334,12=
 @@
 man_delete_unix_socket(const struct management *man)
 {
 #if UNIX_SOCK=
_SUPPORT
-    if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CL=
IENT)) =3D=3D MF_UNIX_SOCK)
+    if ((man->settings=2Eflags & (MF_UNIX_SOCK=
 | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK
+        || man->settings=2Ef=
lags & MF_UNIX_SOCK_SCRIPT)
     {
         socket_delete_unix(&man->settin=
gs=2Elocal_unix);
     }
+
 #endif
 }
 
@@ -2195,10 +2198,18 @@
           =
  }
         }
 
+        if (man->settings=2Eflags & MF_UNIX_SOCK_SCRIPT &=
& !man_password_needed(man))
+        {
+            msg(D_MANAGEMENT, "MAN=
AGEMENT: Triggering exit on unix-script disconnect");
+            throw_si=
gnal_soft(SIGTERM, "management-exit");
+        }
+
         if (man->setti=
ngs=2Eflags & MF_CONNECT_AS_CLIENT)
         {
-            msg(D_MANAGEMEN=
T, "MANAGEMENT: Triggering management exit");
-            throw_signal_sof=
t(SIGTERM, "management-exit");
+            {
+                msg(D_MANAGE=
MENT, "MANAGEMENT: Triggering management exit");
+                throw_sig=
nal_soft(SIGTERM, "management-exit");
+            }
         }
         el=
se
         {
@@ -2643,6 +2654,15 @@
         {
             get_user_pass(=
&ms->up, pass_file, "Management", GET_USER_PASS_PASSWORD_ONLY);
         }
=
+        else if (ms->flags & MF_UNIX_SOCK_SCRIPT)
+        {
+            =
/* Set random password=2E The password is only
+             * alphanumeric=
al [0-9a-f] but still has 128 bit of randomness,
+             * which is m=
ore than enough */
+            snprintf(ms->up=2Epassword, sizeof(ms->up=
=2Epassword),
+                     "%" PRIx64 "%" PRIx64, get_random(), ge=
t_random());
+            ms->up=2Edefined =3D true;
+        }
 
 #if UNIX=
_SOCK_SUPPORT
         /*
@@ -2788,6 +2808,13 @@
         man_close_socket(=
man, mc->sd_cli);
     }
 
+#if UNIX_SOCK_SUPPORT
+    if (mc->unix_script_=
pid)
+    {
+        kill(mc->unix_script_pid, SIGINT);
+    }
+#endif
+
  =
   command_line_free(mc->in);
     buffer_list_free(mc->out);
 
@@ -3447,6 =
+3474,19 @@
                 break;
             }
 
+#if UNIX_SOCK_SUPPORT=

+            /* if unix-script is in use, the script might have exited
+  =
           * while we are waiting for it to connect */
+            const c=
har *msg_prefix =3D "WARNING: Failed running management unix-script";
+
+  =
          if (man->connection=2Eunix_script_pid
+                && !openvp=
n_waitpid_check(man->connection=2Eunix_script_pid, msg_prefix, M_FATAL))
+ =
           {
+                status =3D -1;
+                break;
+     =
       }
+#endif
+
             if (status > 0)
             {
            =
     break;
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
in=
dex f2c6916=2E=2E157039d 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/open=
vpn/manage=2Eh
@@ -42,6 +42,7 @@
 #define MF_EXTERNAL_CERT          (1u << =
15)
 #define MF_EXTERNAL_KEY_PSSPAD    (1u << 16)
 #define MF_EXTERNAL_KEY_=
DIGEST    (1u << 17)
+#define MF_UNIX_SOCK_SCRIPT       (1u << 18)
 
 #ifde=
f ENABLE_MANAGEMENT
 
@@ -327,6 +328,9 @@
     int fdtosend;
     int lastf=
dreceived;
 #endif
+#if UNIX_SOCK_SUPPORT
+    pid_t unix_script_pid;
+#end=
if
     int client_version;
 };
 
diff --git a/src/openvpn/options=2Ec b/sr=
c/openvpn/options=2Ec
index 7fc8614=2E=2E3bdfc45 100644
--- a/src/openvpn/o=
ptions=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1726,7 +1726,7 @@
      * Chec=
k for consistency of management options
      */
 #ifdef ENABLE_MANAGEMENT
=
-    if (!options->management_addr
+    if (!options->management_addr && !(=
options->management_flags & MF_UNIX_SOCK_SCRIPT)
         && (options->mana=
gement_flags
             || options->management_log_history_cache !=3D def=
aults=2Emanagement_log_history_cache))
     {
@@ -4311,7 +4311,7 @@
     el=
se if (streq(p[0], "management") && p[1] && p[2] && !p[4])
     {
         =
VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (streq(p[2], "unix"))
+      =
  if (streq(p[2], "unix") || streq(p[2], "unix-script"))
         {
 #if UN=
IX_SOCK_SUPPORT
             options->management_flags |=3D MF_UNIX_SOCK;
@=
@ -4321,7 +4321,16 @@
 #endif
         }
 
-        options->management_add=
r =3D p[1];
+        if (streq(p[2], "unix-script"))
+        {
+          =
  options->management_flags |=3D MF_UNIX_SOCK_SCRIPT | MF_HOLD;
+          =
  set_user_script(options, &options->management_script, p[1],
+            =
                "management unix-script", false);
+        }
+        else
=
+        {
+            options->management_addr =3D p[1];
+        }
     =
    options->management_port =3D p[2];
         if (p[3])
         {
diff -=
-git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index d347830=2E=
=2E4cd9ef5 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=
=2Eh
@@ -446,6 +446,8 @@
     const char *management_addr;
     const char =
*management_port;
     const char *management_user_pass;
+    /** Script ex=
ecuted to talk to the management interface */
+    const char *management_s=
cript;
     int management_log_history_cache;
     int management_echo_buff=
er_size;
     int management_state_buffer_size;

-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
=
Gerrit-Change-Number: 1852
Gerrit-PatchSet: 13
Gerrit-Owner: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>

--eog7lOYs3k0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #13</strong> to this ch=
ange=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?us=
p=3Demail">View Change</a></p><p>The following approvals got outdated and w=
ere removed:
Code-Review-1 by Frank Lichtenheld</p><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">Add unix-s=
cript functionality to the --management feature<br><br>This allows a script=
 that handles management input/output to<br>be started alongside OpenVPN si=
mpler in small deployments=2E<br><br>Change-Id: I307e64079f436aa782f7e24bff=
f665a545ad2fa0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br=
>---<br>M doc/man-sections/management-options=2Erst<br>M doc/management-not=
es=2Etxt<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/ope=
nvpn/manage=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<b=
r>7 files changed, 128 insertions(+), 11 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1=
852/13</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/doc/man-sections/management-options=2Erst b/doc=
/man-sections/management-options=2Erst</span><br><span>index 8dad52b=2E=2Ee=
2e0773 100644</span><br><span>--- a/doc/man-sections/management-options=2Er=
st</span><br><span>+++ b/doc/man-sections/management-options=2Erst</span><b=
r><span>@@ -14,6 +14,7 @@</span><br><span>     management socket-name unix =
pw-file  # (recommended)</span><br><span>     management IP port           =
        # (INSECURE)</span><br><span>     management IP port pw-file       =
    #</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    management=
 script unix-script</span><br><span> </span><br><span>   ``pw-file``, if sp=
ecified, is a password file where the password must</span><br><span>   be o=
n first line=2E Instead of a filename it can use the keyword stdin</span><b=
r><span>@@ -25,6 +26,14 @@</span><br><span>   ``--management-client-user`` =
and ``--management-client-group``</span><br><span>   directives to restrict=
 access=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  When the variant :code:`unix-script` is used, OpenVPN will start=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  specified scr=
ipt on startup and enable ``--management-hold``=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  OpenVPN will generate a random path for th=
e unix socket</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and =
management password=2E These are passed as environment</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  variables :code:`MANAGEMENT_SOCKET`, :=
code:`MANAGEMENT_PASSWORD`</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  to the script when being started=2E When OpenVPN terminates it sen=
ds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  a :code:`SIGINT=
` signal to the running script=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>   The management interface provides a speci=
al mode where the TCP</span><br><span>   management link can operate over t=
he tunnel itself=2E To enable this mode,</span><br><span>   set IP to ``tun=
nel``=2E Tunnel mode will cause the management interface to</span><br><span=
>@@ -127,10 +136,11 @@</span><br><span>   (client-only)=2E</span><br><span>=
 </span><br><span> --management-signal</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  Send SIGUSR1 signal to OpenVPN if management session dis=
connects=2E This</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  is =
useful when you wish to disconnect an OpenVPN session on user logoff=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  For ``--management-clie=
nt`` this option is not needed since a disconnect</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  will always generate a :code:`SIGTERM`=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  Send :code:`SIGUSR1` =
signal to OpenVPN if management session disconnects=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  This is useful when you wish to discon=
nect an OpenVPN session on user</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  logoff=2E For ``--management-client`` or ``--management`` wit=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`unixscrip=
t` this option has no effect since a disconnect will</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  always trigger sending a :code:`SIGTERM=
`=2E</span><br><span> </span><br><span> --management-up-down</span><br><spa=
n>   Report tunnel up/down events to management interface=2E</span><br><spa=
n>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</spa=
n><br><span>index 412b79b=2E=2E325f8bd 100644</span><br><span>--- a/doc/man=
agement-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</span>=
<br><span>@@ -35,6 +35,10 @@</span><br><span> you can telnet to the managem=
ent port (make sure to use</span><br><span> a telnet client which understan=
ds &quot;raw&quot; mode)=2E</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+When password authentication is enabled, the mana=
gement interface</span><br><span style=3D"color: hsl(120, 100%, 40%);">+wil=
l require sending the password on its own line after establishing</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+the connection=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Once connecte=
d to the management port, you can use</span><br><span> the &quot;help&quot;=
 command to list all commands=2E</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 3c2e=
bf9=2E=2E8014a02 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><b=
r><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -4341,19 +4341,62 @@<=
/span><br><span>     }</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+run_management_script(struct context *c)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct argv argv =3D arg=
v_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
env_set *env =3D env_set_create(&amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    setenv_str(env, &quot;MANAGEMENT_USER&quot;, management-&gt;settings=
=2Eup=2Eusername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   setenv_str(env, &quot;MANAGEMENT_PASSWORD&quot;, management-&gt;settings=
=2Eup=2Epassword);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   setenv_str(env, &quot;MANAGEMENT_SOCKET&quot;, c-&gt;options=2Emanagemen=
t_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &qu=
ot;%s&quot;, c-&gt;options=2Emanagement_script);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int flags =3D S_NOWAITPID | S_SCRIPT | S_FATAL;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int *pid =3D &amp;management-=
&gt;connection=2Eunix_script_pid;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char *msg_prefix =3D &quot;WARNING: Failed running =
management unix-script&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    *pid =3D openvpn_execve_check(&amp;argv, env, flags, msg_pref=
ix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!openvpn_waitpid_check(*pi=
d, msg_prefix, M_FATAL))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *=
pid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    argv_free(&amp;argv);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    msg(M_FATAL, &quot;ERROR: Management unix-s=
ocket support is not available on this platform&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> bool</span><br><span> open_management(struct context=
 *c)</span><br><span> {</span><br><span>     /* initialize management layer=
 */</span><br><span>     if (management)</span><br><span>     {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int flags =3D =
c-&gt;options=2Emanagement_flags;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            /* This creates a filename that sh=
ould be unguessable */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            char sockname[64] =3D { 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            snprintf(sockname, sizeof(sockname),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                     P=
ACKAGE_NAME &quot;_omi_%08&quot; PRIx64 &quot;%08&quot; PRIx64 &quot;=2Esoc=
k&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
          get_random(), get_random());</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            c-&gt;options=2Emanagement_addr =3D platform_gen_path(platform_=
get_tmp_dir(), sockname, &amp;c-&gt;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>         if (c-&gt;options=2Emanagement_addr)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            unsigned int flags =3D c-&gt;options=2Emanagement_flags;</s=
pan><br><span>             if (c-&gt;options=2Emode =3D=3D MODE_SERVER)</sp=
an><br><span>             {</span><br><span>                 flags |=3D MF_=
SERVER;</span><br><span>             }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>             if (management_open(</span=
><br><span>                     management, c-&gt;options=2Emanagement_addr=
, c-&gt;options=2Emanagement_port,</span><br><span>                     c-&=
gt;options=2Emanagement_user_pass, c-&gt;options=2Emanagement_client_user,<=
/span><br><span>@@ -4365,6 +4408,11 @@</span><br><span>                    =
                  NULL);</span><br><span>             }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (flags=
 &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                run_management_script(c);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>             /* initial management hold,=
 called early, before first context initialization */</span><br><span>     =
        do_hold(0);</span><br><span>             if (IS_SIG(c))</span><br><=
span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br=
><span>index e15d7bd=2E=2Eaf3bfd3 100644</span><br><span>--- a/src/openvpn/=
manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ =
-46,6 +46,7 @@</span><br><span> #include &quot;multi=2Eh&quot;</span><br><s=
pan> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;run_command=2Eh&quot;</sp=
an><br><span> </span><br><span> #ifdef ENABLE_PKCS11</span><br><span> #incl=
ude &quot;pkcs11=2Eh&quot;</span><br><span>@@ -333,10 +334,12 @@</span><br>=
<span> man_delete_unix_socket(const struct management *man)</span><br><span=
> {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK =
| MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_=
SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        || man-&gt;settings=2Eflags &amp; MF_=
UNIX_SOCK_SCRIPT)</span><br><span>     {</span><br><span>         socket_de=
lete_unix(&amp;man-&gt;settings=2Elocal_unix);</span><br><span>     }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif<=
/span><br><span> }</span><br><span> </span><br><span>@@ -2195,10 +2198,18 @=
@</span><br><span>             }</span><br><span>         }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man-&=
gt;settings=2Eflags &amp; MF_UNIX_SOCK_SCRIPT &amp;&amp; !man_password_need=
ed(man))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MAN=
AGEMENT, &quot;MANAGEMENT: Triggering exit on unix-script disconnect&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            throw_=
signal_soft(SIGTERM, &quot;management-exit&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>         if (man-&gt;settings=2Eflags=
 &amp; MF_CONNECT_AS_CLIENT)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            msg(D_MANAGEMENT, &quot;MANAG=
EMENT: Triggering management exit&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            throw_signal_soft(SIGTERM, &quot;management=
-exit&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    msg(D_MANAGEMENT, &quot;MANAGEMENT: Triggering management exit&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                thro=
w_signal_soft(SIGTERM, &quot;management-exit&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>         }<=
/span><br><span>         else</span><br><span>         {</span><br><span>@@=
 -2643,6 +2654,15 @@</span><br><span>         {</span><br><span>           =
  get_user_pass(&amp;ms-&gt;up, pass_file, &quot;Management&quot;, GET_USER=
_PASS_PASSWORD_ONLY);</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        else if (ms-&gt;flags &amp; MF_UNIX_SO=
CK_SCRIPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Set =
random password=2E The password is only</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+             * alphanumerical [0-9a-f] but still has 12=
8 bit of randomness,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+             * which is more than enough */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            snprintf(ms-&gt;up=2Epassword, sizeof(=
ms-&gt;up=2Epassword),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                     &quot;%&quot; PRIx64 &quot;%&quot; PRIx64, get_rand=
om(), get_random());</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            ms-&gt;up=2Edefined =3D true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span> </span><br><span> #if UNI=
X_SOCK_SUPPORT</span><br><span>         /*</span><br><span>@@ -2788,6 +2808=
,13 @@</span><br><span>         man_close_socket(man, mc-&gt;sd_cli);</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (mc-&gt;unix_script_pid)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        kill(mc-&gt;unix_script_pid, SIGINT);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     command_line_free(mc-&gt;in);</span><b=
r><span>     buffer_list_free(mc-&gt;out);</span><br><span> </span><br><spa=
n>@@ -3447,6 +3474,19 @@</span><br><span>                 break;</span><br>=
<span>             }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            /* if unix-script is in use, the script mi=
ght have exited</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
         * while we are waiting for it to connect */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            const char *msg_prefix =3D &q=
uot;WARNING: Failed running management unix-script&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (man-&gt;connection=2Eunix_script_pid</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                &amp;&a=
mp; !openvpn_waitpid_check(man-&gt;connection=2Eunix_script_pid, msg_prefix=
, M_FATAL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  status =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
           if (status &gt; 0)</span><br><span>             {</span><br><spa=
n>                 break;</span><br><span>diff --git a/src/openvpn/manage=
=2Eh b/src/openvpn/manage=2Eh</span><br><span>index f2c6916=2E=2E157039d 10=
0644</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src=
/openvpn/manage=2Eh</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #def=
ine MF_EXTERNAL_CERT          (1u &lt;&lt; 15)</span><br><span> #define MF_=
EXTERNAL_KEY_PSSPAD    (1u &lt;&lt; 16)</span><br><span> #define MF_EXTERNA=
L_KEY_DIGEST    (1u &lt;&lt; 17)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define MF_UNIX_SOCK_SCRIPT       (1u &lt;&lt; 18)</span><br><=
span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> </span><b=
r><span>@@ -327,6 +328,9 @@</span><br><span>     int fdtosend;</span><br><s=
pan>     int lastfdreceived;</span><br><span> #endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    pid_t unix_script_pid;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     int =
client_version;</span><br><span> };</span><br><span> </span><br><span>diff =
--git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>i=
ndex 7fc8614=2E=2E3bdfc45 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -1726=
,7 +1726,7 @@</span><br><span>      * Check for consistency of management o=
ptions</span><br><span>      */</span><br><span> #ifdef ENABLE_MANAGEMENT</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!options-&gt;ma=
nagement_addr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!options-&gt;management_addr &amp;&amp; !(options-&gt;management_flags &a=
mp; MF_UNIX_SOCK_SCRIPT)</span><br><span>         &amp;&amp; (options-&gt;m=
anagement_flags</span><br><span>             || options-&gt;management_log_=
history_cache !=3D defaults=2Emanagement_log_history_cache))</span><br><spa=
n>     {</span><br><span>@@ -4311,7 +4311,7 @@</span><br><span>     else if=
 (streq(p[0], &quot;management&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;=
&amp; !p[4])</span><br><span>     {</span><br><span>         VERIFY_PERMISS=
ION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (streq(p[2], &quot;unix&quot;))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (streq(p[2], &quot;unix&quot;) || streq(p[2=
], &quot;unix-script&quot;))</span><br><span>         {</span><br><span> #i=
f UNIX_SOCK_SUPPORT</span><br><span>             options-&gt;management_fla=
gs |=3D MF_UNIX_SOCK;</span><br><span>@@ -4321,7 +4321,16 @@</span><br><spa=
n> #endif</span><br><span>         }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        options-&gt;management_addr =3D p[=
1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (stre=
q(p[2], &quot;unix-script&quot;))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            options-&gt;management_flags |=3D MF_UNIX_SOCK_SCRIPT | MF_=
HOLD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            se=
t_user_script(options, &amp;options-&gt;management_script, p[1],</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                            &q=
uot;management unix-script&quot;, false);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       options-&gt;management_addr =3D p[1];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span>         options-&gt;man=
agement_port =3D p[2];</span><br><span>         if (p[3])</span><br><span> =
        {</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvp=
n/options=2Eh</span><br><span>index d347830=2E=2E4cd9ef5 100644</span><br><=
span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/option=
s=2Eh</span><br><span>@@ -446,6 +446,8 @@</span><br><span>     const char *=
management_addr;</span><br><span>     const char *management_port;</span><b=
r><span>     const char *management_user_pass;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /** Script executed to talk to the managemen=
t interface */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *management_script;</span><br><span>     int management_log_histo=
ry_cache;</span><br><span>     int management_echo_buffer_size;</span><br><=
span>     int management_state_buffer_size;</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">=
change 1852</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
2?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1852 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>

</body></html>
--eog7lOYs3k0=--


--===============8960908525024847148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8960908525024847148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8960908525024847148==--

