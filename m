Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F63606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JkjlmUxQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ez9xV70p;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WSl7ihEO;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KNPZCd/3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=SyOo6DV0M+pbrDrbFEWPuiDxDwv/6IUVkAUjdN4MN64=; b=JkjlmUxQAA9jYDz8Ur6Gu5VvOD
	Mg8H/buo7OLaDy/loJuPw3cgBnPcQTpzm1Rs3ZcXpZAchXRBYeJU4FhgbDoMNkRva7ucbHQuNauKw
	+i+Es8Iy2gSGbbEiD8L9Ee5zeKhmamaODoQVP0KdRIpu0Ou2upYO73tdcrlMwsGoMWAU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVzpX-0000000079z-157m;
	Tue, 24 Nov 2026 23:21:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVzpE-0000000079h-0tsG
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 23:21:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rtzr9Hr9JMLEk24KGbbDHg+CwCF3TjIYXDyVOnfA+RM=; b=Ez9xV70p+D5rflYOFsW2GE6UhG
 gOX2GG0n4COH3DO+RwgHjVhWiCEtVLAXCKpzY19ekuNUlvNKgqAlm84QJ4rmmM0eaMT6VQDNE2rfz
 l8XJi8zPcCGi2moupaBj3a1/hF0BmuuCWVc2vzRFiBLuaJb2e/kltAVfeDdw7Rh7mkAE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rtzr9Hr9JMLEk24KGbbDHg+CwCF3TjIYXDyVOnfA+RM=; b=WSl7ihEOCwVdyAfC6pA+KWNHuK
 NtrNronX//M85tB0KObJfcfKpZF5oWnu+flvBvKym4fnO8pIJZeAjLWRPcNAonOhrOjQ1pub0pcbQ
 l30Ke0wYoC2vQp+rWjOOMuUelzgraX3Xk/zZi0JBhcGbl9Y01ZVdAZfR5/hR1YQz2pUs=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVzpA-000000000g9-3pIt for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 23:21:22 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso3238546f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 15:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795562474; x=1796167274; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Rtzr9Hr9JMLEk24KGbbDHg+CwCF3TjIYXDyVOnfA+RM=;
 b=KNPZCd/3G8FYdvldSURU8CjP3zSI3XsdzXnj/L2fpt4e4mrbDCtlkS5VG631sYGlxq
 Srdkbeu9Yh+w5qglYeMIm69aHlLKQiJ8YE0aF9fk33KxDX3kDfROraNeU7AO5UXxtYFp
 MqvcB9/h7NIIVVSBP/zo9uuWDSy9L4KyoHDazsYwTgrc3VdtBxTSS4zi4unbmYotPgZ3
 vxbsrGVIanNoL7M6Sx+HF96FNtEFJir8JkI8gVWaKGvTW1qGpagYkKAxZSxcr0DJTMPu
 as0o1BWatITWgAvoxpSmgrC3G+o7EvPvbzsHW9fjwW8QANPw9ZV8bLbFGQXYT0gQ+5Bv
 BooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562474; x=1796167274;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rtzr9Hr9JMLEk24KGbbDHg+CwCF3TjIYXDyVOnfA+RM=;
 b=Qkfiry4ZKn7AbXY2npTLSfImgHMQ1fNcGz2UrQ6dAVG+9rw0M9H/EOtPbW6BFEYpC7
 9e56jI45sWDEESYUHPUrGADUSn3Qn4J6d9DDEzfLwqWhxviFHNg805zIvWTJoJqDm749
 gKYmw9KOxHELn9kiq/k9AQyMGaL9j1VcBSxSZyD8NJK6tKqO9fsRi6VtdSxacwoNACtF
 Szk3Lq5cYbAmi+ekk1NCtFInA8n4T0InrGvigqbQ4F1zattOdJgvjDMu5dmvEJHK6YYe
 XUbCPAQqGawdhCiXvcGZf21jRYJwQQ5tv9/Ww+eV5/gesoNMwxetthinlPyOaK6+7WOc
 Ssew==
X-Gm-Message-State: APuU4Z96FxRatoEq5TPLH5oCY3Y4B7j+31GT9q8OmJPwYYI5Ku0i7uqw
 QWK8bZMTKxNfAUCpiENJkjO+FMx9R/msCQP0py6RZL9XUWkewjOwjtSNnfMW58EZ4sUTbjvhT/3
 k8Kl2a0IeUzSotuh7kMlYBImSLADuNf94H3F+QRzlMiW6sIOSAIfSbBhV7eJ1e2BSj8UQPZuMyY
 6878e9dg==
X-Gm-Gg: AZFdTZdBsTPLUWp8Hi770LFjAxl0AJ9/udT4xoJJt4vABDqcwOa+LHv+1hQL0FlzNyT
 evQkoV6YLWlIqlAVSqfaD7P3vHm/hIJCIcTRU2QCXg5GFef4ofuXVwI6Tew61dW9s3tsW4NTv1q
 9lIIlcsSOLMH8FzKM4SSIurT7srUACOxsDdPHR/cnCp2EejHSoBiwNocYc99THjwlxuasDTIHgU
 ZR/L3d6H4OkIEzdiG/mTXfBTmIs+N9N9/6iSszU56bJXbRDbR0oZWaKamjD8nj/aVm1KU5LES+W
 SUvdYgbSzDENurPaG6ECTH+dXQzwGn0ieDG8gFClUDNPZzDc0Gmyg26EjgAzf8OjYwY9GIeSnjJ
 760L8aAJ5i5mJgNoZEPKzlIH0WzTyvVW7M+TSgNAyUjkkWSIrcxeK+rK3TF6qmZtGmi6FU96s19
 DL4OqbMLSIlLuQpqI+KWmzJ5x8ZOxtoDzjoN7YrOnc95mu2KVhSj0pl2RHuGUWcMLSMUapXHAx6
 nIv8FzxaWFU3BSKXIADh9zDTHxy1WVpiuJgR0FYgizIhUUhIdZPfA2l8k8iUZR1Rjgjs5NBN2+z
 nh8gkDESgYoQwi13yhJWT5uDTQEfO0oj5Gb8n6/+Scas+4pIS3Qoq+mnXbgSEzk5BNXmtuMNe+Y
 q95eQN0RxRfKWMVm+LpaenpFC4Qayf+drG5/fMv7Nzozx86xLSbzgtho0EDYPsXZgk+Y4CpanXe
 MAyWvoknJTHgM4cak=
X-Received: by 2002:a05:6000:29d2:b0:4aa:831a:d0eb with SMTP id
 ffacd0b85a97d-4abb3c37a50mr21654953f8f.9.1795562474050; 
 Tue, 24 Nov 2026 15:21:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad6403fdbbsm22646823f8f.15.2026.11.24.15.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 15:21:13 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 23:21:13 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
X-Gerrit-Change-Number: 2341
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2341?usp=email>
X-Gerrit-Commit: 01aa79f87f54bdbecb8f7a160c6ea0f8965ed29c
References: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYyNDcyMDAwLklkMDVmM2U0ZTMyYWViODA2ZDc2Mjg1OGU3NTRhZGM4MmY0MmQ0MzcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ec4eb6bccff4af5f198d4232ed8933a9499696d7-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVzpA-000000000g9-3pIt
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns-scripts: parse
 dns_vars_file as data instead of sourcing it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Deri Haerudi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: abcderyscreenprinting@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Deri Haerudi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5179330170292466820=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5179330170292466820==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D+TqrwNzBi0="; charset=UTF-8

--D+TqrwNzBi0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2341?usp=3Demail

to review the following change=2E
=


Change subject: dns-scripts: parse dns_vars_file as data instead of sourc=
ing it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dns-=
scripts: parse dns_vars_file as data instead of sourcing it

When --user is=
 used, openvpn forks a privileged runner that executes the
dns-updown scrip=
t as root=2E The unprivileged process writes the DNS
variables to a tempora=
ry file (env_set_write_file(), raw NAME=3Dvalue lines)
and passes its path =
to the runner, and all in-tree dns-updown scripts then
load that file with =
"=2E $dns_vars_file", i=2Ee=2E they execute it as shell code=2E

Today the =
values are restricted by validate_domain() and friends, so this
is not expl=
oitable from the network=2E But the design means (a) the safety
of root cod=
e execution rests entirely on that validation, and (b) the
privilege separa=
tion the runner exists for does not hold: whoever controls
the unprivileged=
 process controls a file root will execute=2E

Replace the sourcing with a =
small reader that only accepts the variable
names openvpn writes (dns_serve=
r_*, dns_search_domain_*, dev, script_type),
validates the name and assigns=
 the value without evaluating it=2E Also stop
re-evaluating already-collect=
ed search domains in the "domains" loop of
the resolvconf_file, haikuos_fil=
e and systemd scripts=2E

No functional change intended for valid values=2E=
 For the resolvconf_file
and systemd scripts, the resulting resolv=2Econf a=
nd resolvectl arguments
were compared byte for byte before and after the ch=
ange=2E

Signed-off-by: Deri Haerudi <Abcderyscreenprinting@gmail=2Ecom>

C=
hange-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
---
M distro/dns-script=
s/haikuos_file-dns-updown=2Esh
M distro/dns-scripts/macos-dns-updown=2Esh
M=
 distro/dns-scripts/openresolv-dns-updown=2Esh
M distro/dns-scripts/resolvc=
onf_file-dns-updown=2Esh
M distro/dns-scripts/systemd-dns-updown=2Esh
5 fil=
es changed, 136 insertions(+), 8 deletions(-)



  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/41/2341/1

diff --git a/distro/dns=
-scripts/haikuos_file-dns-updown=2Esh b/distro/dns-scripts/haikuos_file-dns=
-updown=2Esh
index e19b2b7=2E=2E9ab4148 100644
--- a/distro/dns-scripts/hai=
kuos_file-dns-updown=2Esh
+++ b/distro/dns-scripts/haikuos_file-dns-updown=
=2Esh
@@ -43,7 +43,32 @@
 
 conf=3D/boot/system/settings/network/resolv=2Ec=
onf
 test -e "$conf" || exit 1
-test -z "${dns_vars_file}" || =2E "${dns_va=
rs_file}"
+# Read the variables that openvpn wrote to $dns_vars_file as dat=
a=2E
+# The file is deliberately NOT sourced: values may originate from opt=
ions
+# pushed by the server, and the file is written by the unprivileged
+=
# openvpn process, so sourcing it would execute shell syntax contained
+# i=
n a value (command substitution, quotes, redirections)=2E
+dns_vars_load() =
{
+    _f=3D$1
+    [ -r "$_f" ] || return 0
+    while IFS=3D read -r _lin=
e || [ -n "$_line" ]; do
+        case $_line in
+            *=3D*) ;;
+  =
          *) continue ;;
+        esac
+        _name=3D${_line%%=3D*}
+   =
     _value=3D${_line#*=3D}
+        case $_name in
+            dns_server=
_* | dns_search_domain_* | dev | script_type) ;;
+            *) continue ;=
;
+        esac
+        case $_name in
+            *[!A-Za-z0-9_]*) conti=
nue ;;
+        esac
+        eval "$_name=3D\"\$_value\""
+    done < "$_f=
"
+}
+test -z "${dns_vars_file}" || dns_vars_load "${dns_vars_file}"
 case =
"${script_type}" in
 dns-up)
     n=3D1
@@ -75,7 +100,8 @@
 
     test -z "=
$dns_search_domain_1" || {
         for i in $(seq 1 6); do
-            ev=
al domains=3D\"$domains\$dns_search_domain_${i} \" || break
+            ev=
al d=3D\"\$dns_search_domain_${i}\" || break
+            domains=3D"$domai=
ns$d "
         done
         text=3D"${text}search $domains\n"
     }
diff=
 --git a/distro/dns-scripts/macos-dns-updown=2Esh b/distro/dns-scripts/maco=
s-dns-updown=2Esh
index fccc6b5=2E=2Ea3ee907 100644
--- a/distro/dns-script=
s/macos-dns-updown=2Esh
+++ b/distro/dns-scripts/macos-dns-updown=2Esh
@@ -=
43,7 +43,32 @@
 done
 trap "/bin/rm -f ${lockfile}" EXIT
 
-[ -z "${dns_var=
s_file}" ] || =2E "${dns_vars_file}"
+# Read the variables that openvpn wro=
te to $dns_vars_file as data=2E
+# The file is deliberately NOT sourced: va=
lues may originate from options
+# pushed by the server, and the file is wr=
itten by the unprivileged
+# openvpn process, so sourcing it would execute =
shell syntax contained
+# in a value (command substitution, quotes, redirec=
tions)=2E
+dns_vars_load() {
+    _f=3D$1
+    [ -r "$_f" ] || return 0
+  =
  while IFS=3D read -r _line || [ -n "$_line" ]; do
+        case $_line in=

+            *=3D*) ;;
+            *) continue ;;
+        esac
+        =
_name=3D${_line%%=3D*}
+        _value=3D${_line#*=3D}
+        case $_name=
 in
+            dns_server_* | dns_search_domain_* | dev | script_type) ;;=

+            *) continue ;;
+        esac
+        case $_name in
+       =
     *[!A-Za-z0-9_]*) continue ;;
+        esac
+        eval "$_name=3D\"\=
$_value\""
+    done < "$_f"
+}
+[ -z "${dns_vars_file}" ] || dns_vars_load=
 "${dns_vars_file}"
 
 itf_dns_key=3D"State:/Network/Service/openvpn-${dev}=
/DNS"
 
diff --git a/distro/dns-scripts/openresolv-dns-updown=2Esh b/distro=
/dns-scripts/openresolv-dns-updown=2Esh
index 4aca99f=2E=2Ebf60538 100644
-=
-- a/distro/dns-scripts/openresolv-dns-updown=2Esh
+++ b/distro/dns-scripts=
/openresolv-dns-updown=2Esh
@@ -42,7 +42,32 @@
     done
 }
 
-[ -z "${dns_=
vars_file}" ] || =2E "${dns_vars_file}"
+# Read the variables that openvpn =
wrote to $dns_vars_file as data=2E
+# The file is deliberately NOT sourced:=
 values may originate from options
+# pushed by the server, and the file is=
 written by the unprivileged
+# openvpn process, so sourcing it would execu=
te shell syntax contained
+# in a value (command substitution, quotes, redi=
rections)=2E
+dns_vars_load() {
+    _f=3D$1
+    [ -r "$_f" ] || return 0
=
+    while IFS=3D read -r _line || [ -n "$_line" ]; do
+        case $_line=
 in
+            *=3D*) ;;
+            *) continue ;;
+        esac
+     =
   _name=3D${_line%%=3D*}
+        _value=3D${_line#*=3D}
+        case $_n=
ame in
+            dns_server_* | dns_search_domain_* | dev | script_type)=
 ;;
+            *) continue ;;
+        esac
+        case $_name in
+    =
        *[!A-Za-z0-9_]*) continue ;;
+        esac
+        eval "$_name=3D=
\"\$_value\""
+    done < "$_f"
+}
+[ -z "${dns_vars_file}" ] || dns_vars_l=
oad "${dns_vars_file}"
 : ${script_type:=3Ddns-down}
 case "${script_type}"=
 in
 dns-up)
diff --git a/distro/dns-scripts/resolvconf_file-dns-updown=2Es=
h b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh
index 8d23ed6=2E=2Ed=
5305f1 100644
--- a/distro/dns-scripts/resolvconf_file-dns-updown=2Esh
+++ =
b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh
@@ -43,7 +43,32 @@
 
 =
conf=3D/etc/resolv=2Econf
 test -e "$conf" || exit 1
-test -z "${dns_vars_f=
ile}" || =2E "${dns_vars_file}"
+# Read the variables that openvpn wrote to=
 $dns_vars_file as data=2E
+# The file is deliberately NOT sourced: values =
may originate from options
+# pushed by the server, and the file is written=
 by the unprivileged
+# openvpn process, so sourcing it would execute shell=
 syntax contained
+# in a value (command substitution, quotes, redirections=
)=2E
+dns_vars_load() {
+    _f=3D$1
+    [ -r "$_f" ] || return 0
+    whi=
le IFS=3D read -r _line || [ -n "$_line" ]; do
+        case $_line in
+   =
         *=3D*) ;;
+            *) continue ;;
+        esac
+        _name=
=3D${_line%%=3D*}
+        _value=3D${_line#*=3D}
+        case $_name in
+=
            dns_server_* | dns_search_domain_* | dev | script_type) ;;
+   =
         *) continue ;;
+        esac
+        case $_name in
+            =
*[!A-Za-z0-9_]*) continue ;;
+        esac
+        eval "$_name=3D\"\$_val=
ue\""
+    done < "$_f"
+}
+test -z "${dns_vars_file}" || dns_vars_load "${=
dns_vars_file}"
 case "${script_type}" in
 dns-up)
     n=3D1
@@ -75,7 +100=
,8 @@
 
     test -z "$dns_search_domain_1" || {
         for i in $(seq 1 =
6); do
-            eval domains=3D\"$domains\$dns_search_domain_${i} \" ||=
 break
+            eval d=3D\"\$dns_search_domain_${i}\" || break
+       =
     domains=3D"$domains$d "
         done
         text=3D"${text}search $=
domains\n"
     }
diff --git a/distro/dns-scripts/systemd-dns-updown=2Esh b=
/distro/dns-scripts/systemd-dns-updown=2Esh
index 553056b=2E=2E1777b51 1006=
44
--- a/distro/dns-scripts/systemd-dns-updown=2Esh
+++ b/distro/dns-script=
s/systemd-dns-updown=2Esh
@@ -34,7 +34,32 @@
 #   dns_server_1_sni dns=2Emy=
corp=2Ein
 #
 
-[ -z "${dns_vars_file}" ] || =2E "${dns_vars_file}"
+# Read=
 the variables that openvpn wrote to $dns_vars_file as data=2E
+# The file =
is deliberately NOT sourced: values may originate from options
+# pushed by=
 the server, and the file is written by the unprivileged
+# openvpn process=
, so sourcing it would execute shell syntax contained
+# in a value (comman=
d substitution, quotes, redirections)=2E
+dns_vars_load() {
+    _f=3D$1
+ =
   [ -r "$_f" ] || return 0
+    while IFS=3D read -r _line || [ -n "$_line=
" ]; do
+        case $_line in
+            *=3D*) ;;
+            *) cont=
inue ;;
+        esac
+        _name=3D${_line%%=3D*}
+        _value=3D${_=
line#*=3D}
+        case $_name in
+            dns_server_* | dns_search_d=
omain_* | dev | script_type) ;;
+            *) continue ;;
+        esac
+=
        case $_name in
+            *[!A-Za-z0-9_]*) continue ;;
+        e=
sac
+        eval "$_name=3D\"\$_value\""
+    done < "$_f"
+}
+[ -z "${dns=
_vars_file}" ] || dns_vars_load "${dns_vars_file}"
 
 function do_resolved_=
servers {
     local sni=3D""
@@ -227,7 +252,8 @@
 
         test -z "$dns_=
search_domain_1" || {
             for i in $(seq 1 6); do
-               =
 eval domains=3D\"$domains\$dns_search_domain_${i} \" || break
+           =
     eval d=3D\"\$dns_search_domain_${i}\" || break
+                domain=
s=3D"$domains$d "
             done
             text=3D"${text}search $dom=
ains\n"
         }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2341?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Id05f3e4e32aeb806d762858e754adc82f42d4371
Gerrit-Change-Number: 2341
Gerr=
it-PatchSet: 1
Gerrit-Owner: Deri Haerudi <abcderyscreenprinting@gmail=2Eco=
m>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>

--D+TqrwNzBi0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Deri Haerudi would like Arne =
Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">dns-scripts: parse dns_vars_file as data instead of sourcing it=
<br><br>When --user is used, openvpn forks a privileged runner that execute=
s the<br>dns-updown script as root=2E The unprivileged process writes the D=
NS<br>variables to a temporary file (env_set_write_file(), raw NAME=3Dvalue=
 lines)<br>and passes its path to the runner, and all in-tree dns-updown sc=
ripts then<br>load that file with &quot;=2E $dns_vars_file&quot;, i=2Ee=2E =
they execute it as shell code=2E<br><br>Today the values are restricted by =
validate_domain() and friends, so this<br>is not exploitable from the netwo=
rk=2E But the design means (a) the safety<br>of root code execution rests e=
ntirely on that validation, and (b) the<br>privilege separation the runner =
exists for does not hold: whoever controls<br>the unprivileged process cont=
rols a file root will execute=2E<br><br>Replace the sourcing with a small r=
eader that only accepts the variable<br>names openvpn writes (dns_server_*,=
 dns_search_domain_*, dev, script_type),<br>validates the name and assigns =
the value without evaluating it=2E Also stop<br>re-evaluating already-colle=
cted search domains in the &quot;domains&quot; loop of<br>the resolvconf_fi=
le, haikuos_file and systemd scripts=2E<br><br>No functional change intende=
d for valid values=2E For the resolvconf_file<br>and systemd scripts, the r=
esulting resolv=2Econf and resolvectl arguments<br>were compared byte for b=
yte before and after the change=2E<br><br>Signed-off-by: Deri Haerudi &lt;A=
bcderyscreenprinting@gmail=2Ecom&gt;<br><br>Change-Id: Id05f3e4e32aeb806d76=
2858e754adc82f42d4371<br>---<br>M distro/dns-scripts/haikuos_file-dns-updow=
n=2Esh<br>M distro/dns-scripts/macos-dns-updown=2Esh<br>M distro/dns-script=
s/openresolv-dns-updown=2Esh<br>M distro/dns-scripts/resolvconf_file-dns-up=
down=2Esh<br>M distro/dns-scripts/systemd-dns-updown=2Esh<br>5 files change=
d, 136 insertions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/2341/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/distro/dns-scripts/haikuos_file-dns-updown=2Esh b/distro/dns-scri=
pts/haikuos_file-dns-updown=2Esh</span><br><span>index e19b2b7=2E=2E9ab4148=
 100644</span><br><span>--- a/distro/dns-scripts/haikuos_file-dns-updown=2E=
sh</span><br><span>+++ b/distro/dns-scripts/haikuos_file-dns-updown=2Esh</s=
pan><br><span>@@ -43,7 +43,32 @@</span><br><span> </span><br><span> conf=3D=
/boot/system/settings/network/resolv=2Econf</span><br><span> test -e &quot;=
$conf&quot; || exit 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
test -z &quot;${dns_vars_file}&quot; || =2E &quot;${dns_vars_file}&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# Read the variables t=
hat openvpn wrote to $dns_vars_file as data=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# The file is deliberately NOT sourced: values m=
ay originate from options</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# pushed by the server, and the file is written by the unprivileged</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# openvpn process, so=
 sourcing it would execute shell syntax contained</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# in a value (command substitution, quotes, r=
edirections)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_=
vars_load() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    _f=
=3D$1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    [ -r &quot=
;$_f&quot; ] || return 0</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    while IFS=3D read -r _line || [ -n &quot;$_line&quot; ]; do</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        case $_line in</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            *=3D*) ;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *) contin=
ue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        esac</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        _name=3D${_li=
ne%%=3D*}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        _v=
alue=3D${_line#*=3D}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        case $_name in</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            dns_server_* | dns_search_domain_* | dev | script_type) ;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *) conti=
nue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        esac<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case $_name =
in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *[!A-=
Za-z0-9_]*) continue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     eval &quot;$_name=3D\&quot;\$_value\&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    done &lt; &quot;$_f&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test -z &quot;${dns_vars_file}&quot; || dns_vars_=
load &quot;${dns_vars_file}&quot;</span><br><span> case &quot;${script_type=
}&quot; in</span><br><span> dns-up)</span><br><span>     n=3D1</span><br><s=
pan>@@ -75,7 +100,8 @@</span><br><span> </span><br><span>     test -z &quot=
;$dns_search_domain_1&quot; || {</span><br><span>         for i in $(seq 1 =
6); do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            eva=
l domains=3D\&quot;$domains\$dns_search_domain_${i} \&quot; || break</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            eval d=3D\&quo=
t;\$dns_search_domain_${i}\&quot; || break</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            domains=3D&quot;$domains$d &quot;</span>=
<br><span>         done</span><br><span>         text=3D&quot;${text}search=
 $domains\n&quot;</span><br><span>     }</span><br><span>diff --git a/distr=
o/dns-scripts/macos-dns-updown=2Esh b/distro/dns-scripts/macos-dns-updown=
=2Esh</span><br><span>index fccc6b5=2E=2Ea3ee907 100644</span><br><span>---=
 a/distro/dns-scripts/macos-dns-updown=2Esh</span><br><span>+++ b/distro/dn=
s-scripts/macos-dns-updown=2Esh</span><br><span>@@ -43,7 +43,32 @@</span><b=
r><span> done</span><br><span> trap &quot;/bin/rm -f ${lockfile}&quot; EXIT=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-[ -=
z &quot;${dns_vars_file}&quot; ] || =2E &quot;${dns_vars_file}&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# Read the variables that =
openvpn wrote to $dns_vars_file as data=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# The file is deliberately NOT sourced: values may o=
riginate from options</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# pushed by the server, and the file is written by the unprivileged</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# openvpn process, so sou=
rcing it would execute shell syntax contained</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# in a value (command substitution, quotes, redir=
ections)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_vars=
_load() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    _f=3D$=
1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    [ -r &quot;$_f=
&quot; ] || return 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    while IFS=3D read -r _line || [ -n &quot;$_line&quot; ]; do</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        case $_line in</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            *=3D*) ;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            *) continue ;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        esac</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        _name=3D${_line%%=
=3D*}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        _value=
=3D${_line#*=3D}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     case $_name in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            dns_server_* | dns_search_domain_* | dev | script_type) ;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            *) continue =
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        esac</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        case $_name in</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *[!A-Za-z=
0-9_]*) continue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 eval &quot;$_name=3D\&quot;\$_value\&quot;&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    done &lt; &quot;$_f&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+[ -z &quot;${dns_vars_file}&quot; ] || dns_vars_load =
&quot;${dns_vars_file}&quot;</span><br><span> </span><br><span> itf_dns_key=
=3D&quot;State:/Network/Service/openvpn-${dev}/DNS&quot;</span><br><span> <=
/span><br><span>diff --git a/distro/dns-scripts/openresolv-dns-updown=2Esh =
b/distro/dns-scripts/openresolv-dns-updown=2Esh</span><br><span>index 4aca9=
9f=2E=2Ebf60538 100644</span><br><span>--- a/distro/dns-scripts/openresolv-=
dns-updown=2Esh</span><br><span>+++ b/distro/dns-scripts/openresolv-dns-upd=
own=2Esh</span><br><span>@@ -42,7 +42,32 @@</span><br><span>     done</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-[ -z &quot;${dns_vars_file}&quot; ] || =2E &quot;${dns_vars_file}=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Read the va=
riables that openvpn wrote to $dns_vars_file as data=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# The file is deliberately NOT sourced:=
 values may originate from options</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# pushed by the server, and the file is written by the unpri=
vileged</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# openvpn pr=
ocess, so sourcing it would execute shell syntax contained</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# in a value (command substitution, =
quotes, redirections)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+dns_vars_load() {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    _f=3D$1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    [=
 -r &quot;$_f&quot; ] || return 0</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    while IFS=3D read -r _line || [ -n &quot;$_line&quot; ]; =
do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case $_li=
ne in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *=
=3D*) ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 *) continue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        _na=
me=3D${_line%%=3D*}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        _value=3D${_line#*=3D}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        case $_name in</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            dns_server_* | dns_search_domain_* | dev | script=
_type) ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  *) continue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ca=
se $_name in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     *[!A-Za-z0-9_]*) continue ;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        esac</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        eval &quot;$_name=3D\&quot;\$_value\&quot;&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    done &lt; &quot;$_f&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+[ -z &quot;${dns_vars_file}&quot; ] || =
dns_vars_load &quot;${dns_vars_file}&quot;</span><br><span> : ${script_type=
:=3Ddns-down}</span><br><span> case &quot;${script_type}&quot; in</span><br=
><span> dns-up)</span><br><span>diff --git a/distro/dns-scripts/resolvconf_=
file-dns-updown=2Esh b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh</=
span><br><span>index 8d23ed6=2E=2Ed5305f1 100644</span><br><span>--- a/dist=
ro/dns-scripts/resolvconf_file-dns-updown=2Esh</span><br><span>+++ b/distro=
/dns-scripts/resolvconf_file-dns-updown=2Esh</span><br><span>@@ -43,7 +43,3=
2 @@</span><br><span> </span><br><span> conf=3D/etc/resolv=2Econf</span><br=
><span> test -e &quot;$conf&quot; || exit 1</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-test -z &quot;${dns_vars_file}&quot; || =2E &quot;${d=
ns_vars_file}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# Read the variables that openvpn wrote to $dns_vars_file as data=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# The file is deliberately=
 NOT sourced: values may originate from options</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# pushed by the server, and the file is written=
 by the unprivileged</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# openvpn process, so sourcing it would execute shell syntax contained</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# in a value (command s=
ubstitution, quotes, redirections)=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dns_vars_load() {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    _f=3D$1</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    [ -r &quot;$_f&quot; ] || return 0</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    while IFS=3D read -r _line || [ -n &quot;$_l=
ine&quot; ]; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    case $_line in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           *=3D*) ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            *) continue ;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        _name=3D${_line%%=3D*}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        _value=3D${_line#*=3D}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        case $_name in</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            dns_server_* | dns_search_domain_* | =
dev | script_type) ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            *) continue ;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        esac</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        case $_name in</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            *[!A-Za-z0-9_]*) continue ;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        esac</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        eval &quot;$_name=3D\&quot;\$_value\&quot;&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    done &lt; &quot=
;$_f&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test -z &quot;${dns_vars_fi=
le}&quot; || dns_vars_load &quot;${dns_vars_file}&quot;</span><br><span> ca=
se &quot;${script_type}&quot; in</span><br><span> dns-up)</span><br><span> =
    n=3D1</span><br><span>@@ -75,7 +100,8 @@</span><br><span> </span><br><s=
pan>     test -z &quot;$dns_search_domain_1&quot; || {</span><br><span>    =
     for i in $(seq 1 6); do</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            eval domains=3D\&quot;$domains\$dns_search_domain_${i} \=
&quot; || break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        eval d=3D\&quot;\$dns_search_domain_${i}\&quot; || break</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            domains=3D&quot;$d=
omains$d &quot;</span><br><span>         done</span><br><span>         text=
=3D&quot;${text}search $domains\n&quot;</span><br><span>     }</span><br><s=
pan>diff --git a/distro/dns-scripts/systemd-dns-updown=2Esh b/distro/dns-sc=
ripts/systemd-dns-updown=2Esh</span><br><span>index 553056b=2E=2E1777b51 10=
0644</span><br><span>--- a/distro/dns-scripts/systemd-dns-updown=2Esh</span=
><br><span>+++ b/distro/dns-scripts/systemd-dns-updown=2Esh</span><br><span=
>@@ -34,7 +34,32 @@</span><br><span> #   dns_server_1_sni dns=2Emycorp=2Ein=
</span><br><span> #</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-[ -z &quot;${dns_vars_file}&quot; ] || =2E &quot;${dns_vars=
_file}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Read =
the variables that openvpn wrote to $dns_vars_file as data=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# The file is deliberately NOT so=
urced: values may originate from options</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# pushed by the server, and the file is written by the=
 unprivileged</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# open=
vpn process, so sourcing it would execute shell syntax contained</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# in a value (command substitu=
tion, quotes, redirections)=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+dns_vars_load() {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    _f=3D$1</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    [ -r &quot;$_f&quot; ] || return 0</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    while IFS=3D read -r _line || [ -n &quot;$_line&quo=
t; ]; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cas=
e $_line in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    *=3D*) ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      *) continue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  _name=3D${_line%%=3D*}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        _value=3D${_line#*=3D}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        case $_name in</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            dns_server_* | dns_search_domain_* | dev | s=
cript_type) ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       *) continue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   case $_name in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          *[!A-Za-z0-9_]*) continue ;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        esac</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        eval &quot;$_name=3D\&quot;\$_value\&quot;&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    done &lt; &quot;$_f&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+[ -z &quot;${dns_vars_file}&quot; =
] || dns_vars_load &quot;${dns_vars_file}&quot;</span><br><span> </span><br=
><span> function do_resolved_servers {</span><br><span>     local sni=3D&qu=
ot;&quot;</span><br><span>@@ -227,7 +252,8 @@</span><br><span> </span><br><=
span>         test -z &quot;$dns_search_domain_1&quot; || {</span><br><span=
>             for i in $(seq 1 6); do</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                eval domains=3D\&quot;$domains\$dns_search_=
domain_${i} \&quot; || break</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                eval d=3D\&quot;\$dns_search_domain_${i}\&quot; ||=
 break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   domains=3D&quot;$domains$d &quot;</span><br><span>             done</spa=
n><br><span>             text=3D&quot;${text}search $domains\n&quot;</span>=
<br><span>         }</span><br></pre><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">change 2341</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id05f3e4e32ae=
b806d762858e754adc82f42d4371 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2341 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Deri Haerudi &lt;abcderyscre=
enprinting@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--D+TqrwNzBi0=--


--===============5179330170292466820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5179330170292466820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5179330170292466820==--

