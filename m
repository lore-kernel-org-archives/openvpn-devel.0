Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1B1CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Re6Mf2N4yRFdQD6iRg2LmejXB9xpEYUIszwD4nIuQrU=; b=hgPRrEZ/DfeiNl
	CSooMLM8UDwuoFIBWL2d0nbd0eQPI2TWZv5we68qOSTphZg2SEfe6Ug+UMMf6/2X9vBzjOfyZWlLb
	8+lIV2FsquJLVp04TxIQpDK+25CkXuhKrY90dp0DUCcicEdVU/LgKqqiOSAwexUw9VKPb/0ZPfihr
	mjQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIQew-0006r4-OL;
	Sun, 18 Oct 2026 13:10:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIQeg-0006qn-Ni
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:10:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WSM3ouFGU4U6lKaZjijh1mUBlg2Ocfg1KShAx7EEpJ4=; b=klyCLjd3Vc3QkhqjvwH3/dbaah
 5IkLht2dhkQnlakm3gILtfX6PSRSWbpdob5/UFR/fs4ZKy5o/qZF7F8VdzTtozY4YPcg5PVnP6QOE
 Q0+8QP8K2Cixl4nF1KbtE073yiJPNis1RSQWf9PE+0GgVeCKUgd1niHRGd0U3zg8hWiI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WSM3ouFGU4U6lKaZjijh1mUBlg2Ocfg1KShAx7EEpJ4=; b=M
 51gzGnuJxo1PajcLHRsYjMTOkFESGYCy2ROnvfdUNixqWusDKlTYXWwEOS6hYoeShoLYEQiI3V8nP
 NfzBqWqdEYwdGpRiAKkBuMDNWWlCxVufi3mPkdntzEaFO8yLyI/pgjUPs/SURswSKaWmc8ZxiVEPr
 aJIZYnSieSJWBBbM=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIQeY-0006fk-U5 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:10:21 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so196309f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792329012; x=1792933812; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WSM3ouFGU4U6lKaZjijh1mUBlg2Ocfg1KShAx7EEpJ4=;
 b=OZr49PNms0eAT7fbuaFIU0G3poaT6tK6YMrcJT13c7vEmhhpfmQTQVq2bIh7SnFS9X
 LUg8ZQNcxVRhZgswWPFiokNQF1zsAFzDc4qAtLFzVt7rB56s+cNETPynw92hoLYze4E1
 di3vKOqfR8zat+turxvWyGHwMTU8SnkCvvn1oKmCEHlcb9Ru6WrbQ3w96Fq6UpqGfj4Y
 msX+HOWSJwmbWTg3Bk/RDkAWM+j/3GfUYbpuL74beOvlCvj7Qr3K5JV7KPL2sqj8MWPR
 ChGWq924xpdzQTsTwyaGojifWJ10M5TaY6/ieCgc9r8D/9usaNY6FWrvqC6Dl2+wkIpJ
 KRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792329012; x=1792933812;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WSM3ouFGU4U6lKaZjijh1mUBlg2Ocfg1KShAx7EEpJ4=;
 b=R6Ak1gTgzJ3+X4ko24ivgS9Xw5lk5VOKDg01M1qH5mhfgP+S+kM3YxYtU6eIOaXxIx
 cejjO0JUM+jTnh9xEPl6E6RrnBrhZ8QTjIm8GQ8ui7jo7ILmefas5Se4sDWAVKhQJRu6
 GBgQGwb/GW05waZJ+ruW4tzijcEVMW3Ge60tnOrVbyYSJjrfbP4YJ9i3zBABwQN+Z2o8
 6CwRBHaEw61reaa7NaIK4IrXTd26UpVcjmkbNJe3s6fAS8caTTOjwhzpIHXb2vpTi75S
 +lPy105/MGgEg0CeZUd6tMBVbdcRikCAyw26LMAdQmB9L8dtNdtpiJgqm3BjgLT1QRDO
 2wRA==
X-Gm-Message-State: AFq9FYI1mnbRlM8UUS+3CuPTZO76mhAxDw53kFnC1Be3xIt7Jg+6v93B
 oG5yAuFZVQpWrEoq2aj+wgCjy1VuHDOpOQ0frIkY60bHDy4EX3DMh7zmLT+xWW4sUnI7YaNm2sg
 DA901TdzIfbdYxEftayb9OtGpxN+V0LbXzUWf/tikPdKmvMrDHi0zklSSMgqoJ3Xzy5yja7DTLL
 aNqc/ecg==
X-Gm-Gg: AYBFou2vqeLhOklXFA8JlCvQTTG3qeYzRHMkYy4letaoy/1yU06tqkDCSgvxOZsufWC
 Q39pUX3iKsCGek4WXDG+3507Gg3l9DjmH0AJkZrYo5tTlc06d7aku6PpmF6hPPOVflohU+DmjuO
 V9hfkzErt+3eWXavfC/Fiw+yu4lgaGStnIKeNFYgjgjv8ZGw/T2xyzn/eeuIrSPjlopdqWnu5vJ
 xNN+zA9yS3w0MV11gaTsj62p/pDIqWgyGNWbdUR2L39CDPG0vWdyrzy08ZpKmoQrJC3aBf4BN+J
 BWdGf6ZlFePcDX3qrLW4AhrNRoj0orjv+8tsOXD+2XcAOYTgXyGg7qjN4FP783DuoOpHQCWMSWV
 uOrb/88vT9fBzTYKjoNaNq6oOG1HhlsKxYM2H/4BKtTJqD8Zl16wRjIN+KN8Mh7NKI8Q7alYang
 192oKE+CaaeIzAtCxd+WRlNgjownaE9TtJi005INSvdkGazjqZAk2qUzLhMAw/SM4QsCnpbPnJ0
 BoH333p5TsqSU709wLkqPlcKzwXw0YQFCWQq6nTFCY+JQDL8yIbhDjV1aPjAuw6q6tEiRt1IJuE
 Xaf05/fPpCwsReKmwxRSVIk8/rMJUy/vlXpkNXNPxX4B1ozESEU6nGVg7uKW
X-Received: by 2002:a05:6000:420f:b0:48d:f7af:be35 with SMTP id
 ffacd0b85a97d-48e07f9c33amr10994861f8f.29.1792329012012; 
 Sun, 18 Oct 2026 06:10:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfe4d2321sm19723562f8f.19.2026.10.18.06.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:10:11 -0700 (PDT)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 13:10:11 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I27dce67069704b445dd1e59794f435edffb5eb56
X-Gerrit-Change-Number: 2015
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2015?usp=email>
X-Gerrit-Commit: 096cba6380113368a1c7bf73464d54289c311fd1
References: <gerrit.1792329007000.I27dce67069704b445dd1e59794f435edffb5eb56@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzI5MDA3MDAwLkkyN2RjZTY3MDY5NzA0YjQ0NWRkMWU1OTc5NGY0MzVlZGZmYjVlYjU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f66b3b992ae85b9c12e0b67e68a9f88d5810eb70-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIQeY-0006fk-U5
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win: remove
 --register-dns
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
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5778720716111273663=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5778720716111273663==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HadGp+WkPns="; charset=UTF-8

--HadGp+WkPns=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2015?usp=3Demail

to review the following change=2E
=


Change subject: win: remove --register-dns
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

win: remove --register-dns

The option ran =
"ipconfig /flushdns" and "ipconfig /registerdns" on
connection initiation t=
o make Windows pick up pushed DNS servers=2E This
is no longer needed, sinc=
e the interactive service configures DNS
directly and takes care of everyth=
ing that is required and the code
to deal with DNS will be removed from ope=
nvpn=2Eexe=2E

Remove the implementation in openvpn and the interactive ser=
vice,
including msg_register_dns=2E The option is still accepted, but
ignor=
ed with a warning, like it is done for others already=2E

Change-Id: I27dce=
67069704b445dd1e59794f435edffb5eb56
Signed-off-by: Heiko Hund <heiko@ist=2E=
eigentlich=2Enet>
---
M Changes=2Emd
M doc/man-sections/unsupported-options=
=2Erst
M doc/man-sections/windows-options=2Erst
M include/openvpn-msg=2Eh
M=
 src/openvpn/init=2Ec
M src/openvpn/options=2Ec
M src/openvpn/tun=2Ec
M src=
/openvpn/tun=2Eh
M src/openvpn/win32=2Eh
M src/openvpnserv/interactive=2Ec
=
10 files changed, 16 insertions(+), 199 deletions(-)



  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/2015/1

diff --git a/Cha=
nges=2Emd b/Changes=2Emd
index 5c3270b=2E=2Eba4491c 100644
--- a/Changes=2E=
md
+++ b/Changes=2Emd
@@ -23,6 +23,12 @@
   the characters mentioned above =
were already escaped=2E However, the behavior of
   Mbed TLS is slightly di=
fferent from OpenSSL in that it also escapes "=3D"=2E
 
+* **Removed `--reg=
ister-dns`**
+
+  The Windows-only option `--register-dns` is now ignored w=
ith a warning=2E
+  Running `ipconfig /flushdns` and `ipconfig /registerdns=
` on connection
+  initiation is no longer needed for Windows to pick up pu=
shed DNS servers=2E
+
 ## Maintainer-visible changes
 
 - The configure-tim=
e option `--enable-debug` is no longer  available
diff --git a/doc/man-sect=
ions/unsupported-options=2Erst b/doc/man-sections/unsupported-options=2Erst=

index c273905=2E=2E00dc7dd 100644
--- a/doc/man-sections/unsupported-optio=
ns=2Erst
+++ b/doc/man-sections/unsupported-options=2Erst
@@ -58,6 +58,11 @=
@
   Removed in OpenVPN 2=2E7=2E  This option does not make sense anymore a=
s option
   strings may not match due to the introduction of parameters neg=
otiation=2E
 
+--register-dns
+  Ignored since OpenVPN 2=2E8=2E  Running ``=
ipconfig /flushdns`` and
+  ``ipconfig /registerdns`` is no longer needed f=
or Windows to pick up
+  pushed DNS servers=2E
+
 --socks-proxy-retry
   Re=
moved in OpenVPN 2=2E4=2E  All retries are controlled by ``--max-connect-re=
try``=2E
 
diff --git a/doc/man-sections/windows-options=2Erst b/doc/man-se=
ctions/windows-options=2Erst
index 8d7dcbb=2E=2E04610c7 100644
--- a/doc/ma=
n-sections/windows-options=2Erst
+++ b/doc/man-sections/windows-options=2Er=
st
@@ -161,11 +161,6 @@
   explorer when OpenVPN is run on a configuration =
file using the
   right-click explorer menu=2E
 
---register-dns
-  Run :co=
de:`ipconfig /flushdns` and :code:`ipconfig /registerdns` on
-  connection =
initiation=2E This is known to kick Windows into recognizing
-  pushed DNS =
servers=2E
-
 --route-method m
   Which method ``m`` to use for adding rout=
es on Windows?
 
diff --git a/include/openvpn-msg=2Eh b/include/openvpn-msg=
=2Eh
index ca3267e8=2E=2Ebc3f534a 100644
--- a/include/openvpn-msg=2Eh
+++ =
b/include/openvpn-msg=2Eh
@@ -42,7 +42,6 @@
     msg_flush_neighbors,
     =
msg_add_wfp_block,
     msg_del_wfp_block,
-    msg_register_dns,
     msg_=
enable_dhcp,
     deprecated_msg_register_ring_buffers,
     msg_set_mtu,
d=
iff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 3c2ebf9=2E=2E=
1cf8dd4 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -15=
49,10 +1549,6 @@
         c->options=2Eno_advance =3D true;
     }
 
-#ifde=
f _WIN32
-    fork_register_dns_action(c->c1=2Etuntap);
-#endif
-
 #ifdef E=
NABLE_MANAGEMENT
     /* Tell management interface that we initialized */
 =
    if (management)
diff --git a/src/openvpn/options=2Ec b/src/openvpn/opti=
ons=2Ec
index 7fc8614=2E=2E3f92f6e 100644
--- a/src/openvpn/options=2Ec
+++=
 b/src/openvpn/options=2Ec
@@ -745,8 +745,6 @@
     "--dhcp-renew       : A=
sk Windows to renew the TAP adapter lease on startup=2E\n"
     "--dhcp-pre=
-release : Ask Windows to release the previous TAP adapter lease on\n"
    =
 "                       startup=2E\n"
-    "--register-dns  : Run ipconfig=
 /flushdns and ipconfig /registerdns\n"
-    "                  on connecti=
on initiation=2E\n"
     "--tap-sleep n   : Sleep for n seconds after TAP a=
dapter open before\n"
     "                  attempting to set adapter pro=
perties=2E\n"
     "--pause-exit         : When run from a console window, =
pause before exiting=2E\n"
@@ -6736,30 +6734,13 @@
     }
     else if (str=
eq(p[0], "register-dns") && !p[1])
     {
-        VERIFY_PERMISSION(OPT_P_=
DHCPDNS);
-        options->tuntap_options=2Eregister_dns =3D true;
+      =
  msg(M_WARN, "DEPRECATED OPTION: --register-dns option ignored=2E");
     =
}
     else if (streq(p[0], "block-outside-dns") && !p[1])
     {
         =
VERIFY_PERMISSION(OPT_P_DHCPDNS);
         options->block_outside_dns =3D t=
rue;
     }
-    else if (streq(p[0], "rdns-internal") && !p[1])
-    /* st=
andalone method for internal use
-     *
-     * (if --register-dns is set,=
 openvpn needs to call itself in a
-     *  sub-process to execute the requ=
ired functions in a non-blocking
-     *  way, and uses --rdns-internal to =
signal that to itself)
-     */
-    {
-        VERIFY_PERMISSION(OPT_P_GEN=
ERAL);
-        set_debug_level(options->verbosity, SDL_CONSTRAIN);
-      =
  if (options->tuntap_options=2Eregister_dns)
-        {
-            ipcon=
fig_register_dns(NULL);
-        }
-        openvpn_exit(OPENVPN_EXIT_STATU=
S_GOOD); /* exit point */
-    }
     else if (streq(p[0], "show-valid-subn=
ets") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --gi=
t a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 2c2766f=2E=2Ee8527f2 10=
0644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -4871,28 +4871,=
6 @@
     exec_command("NETSH", a, n, msglevel);
 }
 
-void
-ipconfig_regis=
ter_dns(const struct env_set *es)
-{
-    struct argv argv =3D argv_new();
=
-    const char err[] =3D "ERROR: Windows ipconfig command failed";
-
-    =
msg(D_TUNTAP_INFO, "Start ipconfig commands for register-dns=2E=2E=2E");
- =
   netcmd_semaphore_lock();
-
-    argv_printf(&argv, "%s%s /flushdns", get=
_win_sys_path(), WIN_IPCONFIG_PATH_SUFFIX);
-    argv_msg(D_TUNTAP_INFO, &a=
rgv);
-    openvpn_execve_check(&argv, es, 0, err);
-
-    argv_printf(&arg=
v, "%s%s /registerdns", get_win_sys_path(), WIN_IPCONFIG_PATH_SUFFIX);
-   =
 argv_msg(D_TUNTAP_INFO, &argv);
-    openvpn_execve_check(&argv, es, 0, er=
r);
-    argv_free(&argv);
-
-    netcmd_semaphore_release();
-    msg(D_TU=
NTAP_INFO, "End ipconfig commands for register-dns=2E=2E=2E");
-}
-
 static=
 void
 ip_addr_string_to_array(in_addr_t *dest, unsigned int *dest_len, con=
st IP_ADDR_STRING *src)
 {
@@ -5339,54 +5317,6 @@
     }
 }
 
-static void
=
-register_dns_service(const struct tuntap *tt)
-{
-    HANDLE msg_channel =
=3D tt->options=2Emsg_channel;
-    ack_message_t ack;
-    struct gc_arena=
 gc =3D gc_new();
-
-    message_header_t rdns =3D { msg_register_dns, size=
of(message_header_t), 0 };
-
-    if (!send_msg_iservice(msg_channel, &rdns=
, sizeof(rdns), &ack, "Register_dns"))
-    {
-        gc_free(&gc);
-     =
   return;
-    }
-
-    else if (ack=2Eerror_number !=3D NO_ERROR)
-    {
=
-        msg(M_WARN, "Register_dns failed using service: %s [status=3D0x%x]=
",
-            strerror_win32(ack=2Eerror_number, &gc), ack=2Eerror_number=
);
-    }
-
-    else
-    {
-        msg(M_INFO, "Register_dns request sen=
t to the service");
-    }
-
-    gc_free(&gc);
-}
-
-void
-fork_register_d=
ns_action(const struct tuntap *tt)
-{
-    if (tt && tt->options=2Eregister=
_dns && tt->options=2Emsg_channel)
-    {
-        register_dns_service(tt)=
;
-    }
-    else if (tt && tt->options=2Eregister_dns)
-    {
-        st=
ruct gc_arena gc =3D gc_new();
-        struct buffer cmd =3D alloc_buf_gc(=
256, &gc);
-        const int verb =3D 3;
-
-        buf_printf(&cmd, "open=
vpn --verb %d --register-dns --rdns-internal", verb);
-        fork_to_self=
(BSTR(&cmd));
-        gc_free(&gc);
-    }
-}
-
 static uint32_t
 dhcp_mas=
q_addr(const in_addr_t local, const in_addr_t netmask, const int offset)
 {=

diff --git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh
index 61fe943=2E=2E=
b658db2 100644
--- a/src/openvpn/tun=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -135,=
8 +135,6 @@
     bool dhcp_renew;
     bool dhcp_pre_release;
 
-    bool r=
egister_dns;
-
     struct in6_addr dns6[N_DHCP_ADDR];
     unsigned int dn=
s6_len;
 #if defined(TARGET_ANDROID)
@@ -460,10 +458,6 @@
 
 bool dhcp_rene=
w_by_adapter_index(const DWORD adapter_index);
 
-void fork_register_dns_ac=
tion(const struct tuntap *tt);
-
-void ipconfig_register_dns(const struct e=
nv_set *es);
-
 void tun_standby_init(struct tuntap *tt);
 
 bool tun_stand=
by(struct tuntap *tt);
diff --git a/src/openvpn/win32=2Eh b/src/openvpn/win=
32=2Eh
index 39ff7d8=2E=2E5f29ea7 100644
--- a/src/openvpn/win32=2Eh
+++ b/=
src/openvpn/win32=2Eh
@@ -36,11 +36,10 @@
 /* location of executables */
 #=
define SYS_PATH_ENV_VAR_NAME \
     "SystemRoot" /* environmental variable =
name that normally contains the system path */
-#define NETSH_PATH_SUFFIX  =
      "\\system32\\netsh=2Eexe"
-#define WIN_ROUTE_PATH_SUFFIX    "\\system=
32\\route=2Eexe"
-#define WIN_IPCONFIG_PATH_SUFFIX "\\system32\\ipconfig=2E=
exe"
-#define WIN_NET_PATH_SUFFIX      "\\system32\\net=2Eexe"
-#define POW=
ERSHELL_PATH_SUFFIX   "\\system32\\WindowsPowerShell\\v1=2E0\\powershell=2E=
exe"
+#define NETSH_PATH_SUFFIX      "\\system32\\netsh=2Eexe"
+#define WIN=
_ROUTE_PATH_SUFFIX  "\\system32\\route=2Eexe"
+#define WIN_NET_PATH_SUFFIX =
   "\\system32\\net=2Eexe"
+#define POWERSHELL_PATH_SUFFIX "\\system32\\Win=
dowsPowerShell\\v1=2E0\\powershell=2Eexe"
 
 /*
  * Win32-specific OpenVPN =
code, targeted at the mingw
diff --git a/src/openvpnserv/interactive=2Ec b/=
src/openvpnserv/interactive=2Ec
index ed163a4=2E=2Ef4b2d39 100644
--- a/src=
/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -52,8=
 +52,6 @@
 static SERVICE_STATUS status =3D { =2EdwServiceType =3D SERVICE_=
WIN32_SHARE_PROCESS };
 static HANDLE exit_event =3D NULL;
 static settings=
_t settings;
-static HANDLE rdns_semaphore =3D NULL;
-#define RDNS_TIMEOUT =
600 /* seconds to wait for the semaphore */
 
 #define TUN_IOCTL_REGISTER_R=
INGS \
     CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE=
_WRITE_DATA)
@@ -926,80 +924,6 @@
     return exit_code;
 }
 
-/*
- * Entry=
 point for register-dns thread=2E
- */
-static DWORD WINAPI
-RegisterDNS(LP=
VOID unused)
-{
-    DWORD err;
-    DWORD timeout =3D RDNS_TIMEOUT * 1000;=
 /* in milliseconds */
-
-    /* path of ipconfig command */
-    WCHAR ipc=
fg[MAX_PATH];
-
-    struct
-    {
-        WCHAR *argv0;
-        WCHAR *c=
mdline;
-        DWORD timeout;
-    } cmds[] =3D {
-        { ipcfg, L"ipc=
onfig /flushdns", timeout },
-        { ipcfg, L"ipconfig /registerdns", ti=
meout },
-    };
-
-    HANDLE wait_handles[2] =3D { rdns_semaphore, exit_e=
vent };
-
-    swprintf(ipcfg, MAX_PATH, L"%ls\\%ls", get_win_sys_path(), L=
"ipconfig=2Eexe");
-
-    if (WaitForMultipleObjects(2, wait_handles, FALSE=
, timeout) =3D=3D WAIT_OBJECT_0)
-    {
-        /* Semaphore locked */
-  =
      for (size_t i =3D 0; i < _countof(cmds); ++i)
-        {
-           =
 ExecCommand(cmds[i]=2Eargv0, cmds[i]=2Ecmdline, cmds[i]=2Etimeout);
-     =
   }
-        err =3D 0;
-        if (!ReleaseSemaphore(rdns_semaphore, 1, =
NULL))
-        {
-            err =3D
-                MsgToEventLog(M_SYS=
ERR, L"RegisterDNS: Failed to release regsiter-dns semaphore:");
-        }=

-    }
-    else
-    {
-        MsgToEventLog(M_ERR, L"RegisterDNS: Faile=
d to lock register-dns semaphore");
-        err =3D ERROR_SEM_TIMEOUT; /* =
Windows error code 0x79 */
-    }
-    return err;
-}
-
-static DWORD
-Hand=
leRegisterDNSMessage(void)
-{
-    DWORD err;
-    HANDLE thread =3D NULL;
=
-
-    /* Delegate this job to a sub-thread */
-    thread =3D CreateThread=
(NULL, 0, RegisterDNS, NULL, 0, NULL);
-
-    /*
-     * We don't add these=
 thread handles to the undo list -- the thread and
-     * processes it spa=
wns are all supposed to terminate or timeout by themselves=2E
-     */
-   =
 if (thread)
-    {
-        err =3D 0;
-        CloseHandle(thread);
-    =
}
-    else
-    {
-        err =3D GetLastError();
-    }
-
-    return er=
r;
-}
-
 /**
  * Run the command: netsh interface ip $action wins $if_index=
 [static] $addr
  * @param  action      "delete", "add" or "set"
@@ -3280,1=
0 +3204,6 @@
             }
             break;
 
-        case msg_registe=
r_dns:
-            ack=2Eerror_number =3D HandleRegisterDNSMessage();
-   =
         break;
-
         case msg_add_dns_cfg:
         case msg_del_dns_=
cfg:
             ack=2Eerror_number =3D HandleDNSConfigMessage(&msg=2Edns,=
 lists);
@@ -3991,13 +3911,6 @@
         goto out;
     }
 
-    rdns_semap=
hore =3D CreateSemaphoreW(NULL, 1, 1, NULL);
-    if (!rdns_semaphore)
-   =
 {
-        error =3D MsgToEventLog(M_SYSERR, L"Could not create semaphore =
for register-dns");
-        goto out;
-    }
-
     error =3D UpdateWaitHa=
ndles(&handles, &handle_count, io_event, threads);
     if (error !=3D NO_E=
RROR)
     {
@@ -4122,7 +4035,6 @@
     FreeWaitHandles(handles);
     Clos=
eHandleEx(&io_event);
     CloseHandleEx(&exit_event);
-    CloseHandleEx(&=
rdns_semaphore);
 
     status=2EdwCurrentState =3D SERVICE_STOPPED;
     s=
tatus=2EdwWin32ExitCode =3D error;

-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2015?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I27dce67069704b445dd1e59794f435edffb5eb56
Gerrit-Change-N=
umber: 2015
Gerrit-PatchSet: 1
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Ene=
t>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>

--HadGp+WkPns=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2015?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">win: remove --register-dns<br><br>The option ran &quot;ipconfig /=
flushdns&quot; and &quot;ipconfig /registerdns&quot; on<br>connection initi=
ation to make Windows pick up pushed DNS servers=2E This<br>is no longer ne=
eded, since the interactive service configures DNS<br>directly and takes ca=
re of everything that is required and the code<br>to deal with DNS will be =
removed from openvpn=2Eexe=2E<br><br>Remove the implementation in openvpn a=
nd the interactive service,<br>including msg_register_dns=2E The option is =
still accepted, but<br>ignored with a warning, like it is done for others a=
lready=2E<br><br>Change-Id: I27dce67069704b445dd1e59794f435edffb5eb56<br>Si=
gned-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M Ch=
anges=2Emd<br>M doc/man-sections/unsupported-options=2Erst<br>M doc/man-sec=
tions/windows-options=2Erst<br>M include/openvpn-msg=2Eh<br>M src/openvpn/i=
nit=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/tun=2Ec<br>M src/open=
vpn/tun=2Eh<br>M src/openvpn/win32=2Eh<br>M src/openvpnserv/interactive=2Ec=
<br>10 files changed, 16 insertions(+), 199 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/1=
5/2015/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>i=
ndex 5c3270b=2E=2Eba4491c 100644</span><br><span>--- a/Changes=2Emd</span><=
br><span>+++ b/Changes=2Emd</span><br><span>@@ -23,6 +23,12 @@</span><br><s=
pan>   the characters mentioned above were already escaped=2E However, the =
behavior of</span><br><span>   Mbed TLS is slightly different from OpenSSL =
in that it also escapes &quot;=3D&quot;=2E</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+* **Removed `--register-dns`**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  The Windows-only option `--register-dns=
` is now ignored with a warning=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  Running `ipconfig /flushdns` and `ipconfig /registerdns` o=
n connection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  initi=
ation is no longer needed for Windows to pick up pushed DNS servers=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ## Mai=
ntainer-visible changes</span><br><span> </span><br><span> - The configure-=
time option `--enable-debug` is no longer  available</span><br><span>diff -=
-git a/doc/man-sections/unsupported-options=2Erst b/doc/man-sections/unsupp=
orted-options=2Erst</span><br><span>index c273905=2E=2E00dc7dd 100644</span=
><br><span>--- a/doc/man-sections/unsupported-options=2Erst</span><br><span=
>+++ b/doc/man-sections/unsupported-options=2Erst</span><br><span>@@ -58,6 =
+58,11 @@</span><br><span>   Removed in OpenVPN 2=2E7=2E  This option does =
not make sense anymore as option</span><br><span>   strings may not match d=
ue to the introduction of parameters negotiation=2E</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+--register-dns</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  Ignored since OpenVPN 2=2E8=
=2E  Running ``ipconfig /flushdns`` and</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  ``ipconfig /registerdns`` is no longer needed for Win=
dows to pick up</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  pu=
shed DNS servers=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> --socks-proxy-retry</span><br><span>   Removed in OpenVPN=
 2=2E4=2E  All retries are controlled by ``--max-connect-retry``=2E</span><=
br><span> </span><br><span>diff --git a/doc/man-sections/windows-options=2E=
rst b/doc/man-sections/windows-options=2Erst</span><br><span>index 8d7dcbb=
=2E=2E04610c7 100644</span><br><span>--- a/doc/man-sections/windows-options=
=2Erst</span><br><span>+++ b/doc/man-sections/windows-options=2Erst</span><=
br><span>@@ -161,11 +161,6 @@</span><br><span>   explorer when OpenVPN is r=
un on a configuration file using the</span><br><span>   right-click explore=
r menu=2E</span><br><span> </span><br><span>---register-dns</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  Run :code:`ipconfig /flushdns` and =
:code:`ipconfig /registerdns` on</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  connection initiation=2E This is known to kick Windows into re=
cognizing</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  pushed DNS=
 servers=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> --route-method m</span><br><span>   Which method ``m`` to use for a=
dding routes on Windows?</span><br><span> </span><br><span>diff --git a/inc=
lude/openvpn-msg=2Eh b/include/openvpn-msg=2Eh</span><br><span>index ca3267=
e8=2E=2Ebc3f534a 100644</span><br><span>--- a/include/openvpn-msg=2Eh</span=
><br><span>+++ b/include/openvpn-msg=2Eh</span><br><span>@@ -42,7 +42,6 @@<=
/span><br><span>     msg_flush_neighbors,</span><br><span>     msg_add_wfp_=
block,</span><br><span>     msg_del_wfp_block,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg_register_dns,</span><br><span>     msg_ena=
ble_dhcp,</span><br><span>     deprecated_msg_register_ring_buffers,</span>=
<br><span>     msg_set_mtu,</span><br><span>diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec</span><br><span>index 3c2ebf9=2E=2E1cf8dd4 1006=
44</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/ope=
nvpn/init=2Ec</span><br><span>@@ -1549,10 +1549,6 @@</span><br><span>      =
   c-&gt;options=2Eno_advance =3D true;</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    fork_register_dns_ac=
tion(c-&gt;c1=2Etuntap);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> #ifdef ENABLE_MANAGEMENT</span><br><span>     /* Tell management inte=
rface that we initialized */</span><br><span>     if (management)</span><br=
><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span=
><br><span>index 7fc8614=2E=2E3f92f6e 100644</span><br><span>--- a/src/open=
vpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><sp=
an>@@ -745,8 +745,6 @@</span><br><span>     &quot;--dhcp-renew       : Ask =
Windows to renew the TAP adapter lease on startup=2E\n&quot;</span><br><spa=
n>     &quot;--dhcp-pre-release : Ask Windows to release the previous TAP a=
dapter lease on\n&quot;</span><br><span>     &quot;                       s=
tartup=2E\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&quot;--register-dns  : Run ipconfig /flushdns and ipconfig /registerdns\n&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;      =
            on connection initiation=2E\n&quot;</span><br><span>     &quot;=
--tap-sleep n   : Sleep for n seconds after TAP adapter open before\n&quot;=
</span><br><span>     &quot;                  attempting to set adapter pro=
perties=2E\n&quot;</span><br><span>     &quot;--pause-exit         : When r=
un from a console window, pause before exiting=2E\n&quot;</span><br><span>@=
@ -6736,30 +6734,13 @@</span><br><span>     }</span><br><span>     else if =
(streq(p[0], &quot;register-dns&quot;) &amp;&amp; !p[1])</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        VERIFY_PE=
RMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        options-&gt;tuntap_options=2Eregister_dns =3D true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DEPREC=
ATED OPTION: --register-dns option ignored=2E&quot;);</span><br><span>     =
}</span><br><span>     else if (streq(p[0], &quot;block-outside-dns&quot;) =
&amp;&amp; !p[1])</span><br><span>     {</span><br><span>         VERIFY_PE=
RMISSION(OPT_P_DHCPDNS);</span><br><span>         options-&gt;block_outside=
_dns =3D true;</span><br><span>     }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else if (streq(p[0], &quot;rdns-internal&quot;) &amp;&a=
mp; !p[1])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* stan=
dalone method for internal use</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-     *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
 (if --register-dns is set, openvpn needs to call itself in a</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-     *  sub-process to execute the =
required functions in a non-blocking</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     *  way, and uses --rdns-internal to signal that to itse=
lf)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        VERIFY_PERMISSION(OPT_P_GENERAL);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        set_debug_level(opti=
ons-&gt;verbosity, SDL_CONSTRAIN);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (options-&gt;tuntap_options=2Eregister_dns)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            ipconfig_register_dns(NULL);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        openvpn_exit(OPENVPN_EXIT_=
STATUS_GOOD); /* exit point */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span>     else if (streq(p[0], &quot;show-valid-s=
ubnets&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>    =
     VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>diff --git a/src/ope=
nvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 2c2766f=2E=2Ee8527=
f2 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/s=
rc/openvpn/tun=2Ec</span><br><span>@@ -4871,28 +4871,6 @@</span><br><span> =
    exec_command(&quot;NETSH&quot;, a, n, msglevel);</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-ipconfig_register_dns(co=
nst struct env_set *es)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct argv ar=
gv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 const char err[] =3D &quot;ERROR: Windows ipconfig command failed&quot;;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_TUNTAP_INFO, &quot;Start ipconfig=
 commands for register-dns=2E=2E=2E&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    netcmd_semaphore_lock();</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    argv_printf(&amp;argv, &quot;%s%s /flushdns&quot;, get_win_sys_=
path(), WIN_IPCONFIG_PATH_SUFFIX);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    argv_msg(D_TUNTAP_INFO, &amp;argv);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv, es, 0, =
err);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s%s=
 /registerdns&quot;, get_win_sys_path(), WIN_IPCONFIG_PATH_SUFFIX);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_TUNTAP_INFO, &=
amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn=
_execve_check(&amp;argv, es, 0, err);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    argv_free(&amp;argv);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   netcmd_semaphore_release();</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    msg(D_TUNTAP_INFO, &quot;End ipconfig commands for register-dn=
s=2E=2E=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> stati=
c void</span><br><span> ip_addr_string_to_array(in_addr_t *dest, unsigned i=
nt *dest_len, const IP_ADDR_STRING *src)</span><br><span> {</span><br><span=
>@@ -5339,54 +5317,6 @@</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-register_dns_service(co=
nst struct tuntap *tt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HANDLE msg_chan=
nel =3D tt-&gt;options=2Emsg_channel;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    ack_message_t ack;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    message_header_t rdns =3D { msg_register_dns, sizeof(message=
_header_t), 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!send_msg_iservice=
(msg_channel, &amp;rdns, sizeof(rdns), &amp;ack, &quot;Register_dns&quot;))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   else if (ack=2Eerror_number !=3D NO_ERROR)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        msg(M_WARN, &quot;Register_dns failed using service: %s [st=
atus=3D0x%x]&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          strerror_win32(ack=2Eerror_number, &amp;gc), ack=2Eerror_number);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
M_INFO, &quot;Register_dns request sent to the service&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-fork_register_dns_action(const struct tuntap *tt)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (tt &amp;&amp; tt-&gt;options=2Eregiste=
r_dns &amp;&amp; tt-&gt;options=2Emsg_channel)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        register_dns_service(tt);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    else if (tt &amp;&amp; tt-&gt;options=2Eregister_dns)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D gc_new();</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer cmd =3D a=
lloc_buf_gc(256, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        const int verb =3D 3;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
buf_printf(&amp;cmd, &quot;openvpn --verb %d --register-dns --rdns-internal=
&quot;, verb);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 fork_to_self(BSTR(&amp;cmd));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> stati=
c uint32_t</span><br><span> dhcp_masq_addr(const in_addr_t local, const in_=
addr_t netmask, const int offset)</span><br><span> {</span><br><span>diff -=
-git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh</span><br><span>index 61fe=
943=2E=2Eb658db2 100644</span><br><span>--- a/src/openvpn/tun=2Eh</span><br=
><span>+++ b/src/openvpn/tun=2Eh</span><br><span>@@ -135,8 +135,6 @@</span>=
<br><span>     bool dhcp_renew;</span><br><span>     bool dhcp_pre_release;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 bool register_dns;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span>     struct in6_addr dns6[N_DHCP_ADDR];</span><br><span>    =
 unsigned int dns6_len;</span><br><span> #if defined(TARGET_ANDROID)</span>=
<br><span>@@ -460,10 +458,6 @@</span><br><span> </span><br><span> bool dhcp=
_renew_by_adapter_index(const DWORD adapter_index);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void fork_register_dns_acti=
on(const struct tuntap *tt);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void ipconfig_=
register_dns(const struct env_set *es);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> void tun_standby_init(struct tuntap *tt=
);</span><br><span> </span><br><span> bool tun_standby(struct tuntap *tt);<=
/span><br><span>diff --git a/src/openvpn/win32=2Eh b/src/openvpn/win32=2Eh<=
/span><br><span>index 39ff7d8=2E=2E5f29ea7 100644</span><br><span>--- a/src=
/openvpn/win32=2Eh</span><br><span>+++ b/src/openvpn/win32=2Eh</span><br><s=
pan>@@ -36,11 +36,10 @@</span><br><span> /* location of executables */</spa=
n><br><span> #define SYS_PATH_ENV_VAR_NAME \</span><br><span>     &quot;Sys=
temRoot&quot; /* environmental variable name that normally contains the sys=
tem path */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define NE=
TSH_PATH_SUFFIX        &quot;\\system32\\netsh=2Eexe&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define WIN_ROUTE_PATH_SUFFIX    &quot=
;\\system32\\route=2Eexe&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define WIN_IPCONFIG_PATH_SUFFIX &quot;\\system32\\ipconfig=2Eexe&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define WIN_NET_=
PATH_SUFFIX      &quot;\\system32\\net=2Eexe&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define POWERSHELL_PATH_SUFFIX   &quot;\\syste=
m32\\WindowsPowerShell\\v1=2E0\\powershell=2Eexe&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define NETSH_PATH_SUFFIX      &quot;\\s=
ystem32\\netsh=2Eexe&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define WIN_ROUTE_PATH_SUFFIX  &quot;\\system32\\route=2Eexe&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define WIN_NET_PATH_=
SUFFIX    &quot;\\system32\\net=2Eexe&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define POWERSHELL_PATH_SUFFIX &quot;\\system32\\Wi=
ndowsPowerShell\\v1=2E0\\powershell=2Eexe&quot;</span><br><span> </span><br=
><span> /*</span><br><span>  * Win32-specific OpenVPN code, targeted at the=
 mingw</span><br><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/o=
penvpnserv/interactive=2Ec</span><br><span>index ed163a4=2E=2Ef4b2d39 10064=
4</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++=
 b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -52,8 +52,6 @@</span>=
<br><span> static SERVICE_STATUS status =3D { =2EdwServiceType =3D SERVICE_=
WIN32_SHARE_PROCESS };</span><br><span> static HANDLE exit_event =3D NULL;<=
/span><br><span> static settings_t settings;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static HANDLE rdns_semaphore =3D NULL;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define RDNS_TIMEOUT 600 /* seconds=
 to wait for the semaphore */</span><br><span> </span><br><span> #define TU=
N_IOCTL_REGISTER_RINGS \</span><br><span>     CTL_CODE(51820U, 0x970U, METH=
OD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)</span><br><span>@@ -926,80 +=
924,6 @@</span><br><span>     return exit_code;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * Entry point for register-dns=
 thread=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-static DWORD WINAPI</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-RegisterDNS(LPVOID unused)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    DWORD err;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    DWORD timeout =3D RDNS_TIMEOUT * 1000; /* in mill=
iseconds */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* path of ipconfig command=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    WCHAR ipcfg[MA=
X_PATH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        WCHAR *argv0;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        WCHAR *cmdline;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        DWORD timeout;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    } cmds[] =3D {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        { ipcfg, L&quot;ipconfig /flushdns&quot;, timeout }=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        { ipcfg, L&q=
uot;ipconfig /registerdns&quot;, timeout },</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    };</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HANDLE wai=
t_handles[2] =3D { rdns_semaphore, exit_event };</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    swprintf(ipcfg, MAX_PATH, L&quot;%ls\\%ls&quot;, get_win_sys_path=
(), L&quot;ipconfig=2Eexe&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (W=
aitForMultipleObjects(2, wait_handles, FALSE, timeout) =3D=3D WAIT_OBJECT_0=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        /* Semaphore locked */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (size_t i =3D 0=
; i &lt; _countof(cmds); ++i)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        ExecCommand(cmds[i]=2Eargv0, cmds[i]=2Ecmdline, cmds[i]=2Etimeout);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        err =3D 0;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (!ReleaseSemaphore(rdns_s=
emaphore, 1, NULL))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            er=
r =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
MsgToEventLog(M_SYSERR, L&quot;RegisterDNS: Failed to release regsiter-dns =
semaphore:&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        MsgToEventLog(M_ERR, L&quot;RegisterDNS: Failed to =
lock register-dns semaphore&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        err =3D ERROR_SEM_TIMEOUT; /* Windows error code 0x79=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return err;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-HandleRegisterD=
NSMessage(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD err;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    HANDLE thread =3D NULL;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* Delegate this job to a sub-thread */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    thread =3D CreateThrea=
d(NULL, 0, RegisterDNS, NULL, 0, NULL);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * We don&#39;=
t add these thread handles to the undo list -- the thread and</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-     * processes it spawns are all =
supposed to terminate or timeout by themselves=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (thread)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
err =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        Clo=
seHandle(thread);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        err =3D GetLastError();</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span=
><br><span>  * Run the command: netsh interface ip $action wins $if_index [=
static] $addr</span><br><span>  * @param  action      &quot;delete&quot;, &=
quot;add&quot; or &quot;set&quot;</span><br><span>@@ -3280,10 +3204,6 @@</s=
pan><br><span>             }</span><br><span>             break;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case m=
sg_register_dns:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       ack=2Eerror_number =3D HandleRegisterDNSMessage();</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         case msg_add_dns=
_cfg:</span><br><span>         case msg_del_dns_cfg:</span><br><span>      =
       ack=2Eerror_number =3D HandleDNSConfigMessage(&amp;msg=2Edns, lists)=
;</span><br><span>@@ -3991,13 +3911,6 @@</span><br><span>         goto out;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    rdns_semaphore =3D CreateSemaphoreW(NULL, 1, 1, NUL=
L);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!rdns_sema=
phore)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        error =3D MsgToEventLog=
(M_SYSERR, L&quot;Could not create semaphore for register-dns&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto out;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span>     error =3D UpdateWaitHandl=
es(&amp;handles, &amp;handle_count, io_event, threads);</span><br><span>   =
  if (error !=3D NO_ERROR)</span><br><span>     {</span><br><span>@@ -4122,=
7 +4035,6 @@</span><br><span>     FreeWaitHandles(handles);</span><br><span=
>     CloseHandleEx(&amp;io_event);</span><br><span>     CloseHandleEx(&amp=
;exit_event);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Clos=
eHandleEx(&amp;rdns_semaphore);</span><br><span> </span><br><span>     stat=
us=2EdwCurrentState =3D SERVICE_STOPPED;</span><br><span>     status=2EdwWi=
n32ExitCode =3D error;</span><br></pre><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2015?usp=3Demail">change 2015</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2015?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I27dce67069=
704b445dd1e59794f435edffb5eb56 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 2015 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@openv=
pn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--HadGp+WkPns=--


--===============5778720716111273663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5778720716111273663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5778720716111273663==--

