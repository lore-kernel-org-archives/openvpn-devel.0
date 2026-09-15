Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941B8C88E7B
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d9PKEk4XWMxyW10iMZzTN1utZzbIyxBaOrT+lD/gp2M=; b=eZJthyvvdujenTOZ8S5rJEmlpo
	7LBFwBgAUAry87ncbTnbm/Blf1PPVU09exCm9tzKyHNErzkkAA51fMYeVAW1HPTjwFVdIoYwoButD
	9sAw8cI6RDYBO/AIjYTx7mRyaB2mdgNizMgfFJl4X2iJuyD/2wDQaeFQmRr50wph3H+w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6SlH-0006kS-Fp;
	Tue, 15 Sep 2026 12:59:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6SlG-0006kM-Bj
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:59:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=t1jOOMuOs5hdJBN1FmCfM6JCYmdILOYqAUY1+BMbt50=; b=GIoquygPWpZ6phlz/YrgEdi2B/
 +wQzkTI3I8ZJzbPz5a0Cax4r37my7FrLhv9mAtTbW+Ngphnxl6j/sFYipALUNg+a9HxsTLhyYOzaK
 u9uCpWAzrMgyujXbFSfDuUvczCqJg6AgjwoCy3PxYO3P3XV6BdFuvAXucicMIXvKSYBs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=t1jOOMuOs5hdJBN1FmCfM6JCYmdILOYqAUY1+BMbt50=; b=J
 Tj7MyYoixt8UzmyrjFz6zokeh1hUcvpCn2eH6d2RgraPZxXRU9xnW5fOIdNjs6j+8SSZG6QDeg4hm
 oa0joExDIyL1paivuGUffmD1b9Vg5rfFFIEWf1fVge5lbqZIpsd5DgedoMr+VlEx8JHJLvOrzTc+Q
 TD/8Wy/FE+D/cTd4=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6Sl4-0007gi-NG for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:59:43 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso21477215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789477168; x=1790081968; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t1jOOMuOs5hdJBN1FmCfM6JCYmdILOYqAUY1+BMbt50=;
 b=M4NMpPU2r2hFebZCeTJZcsXsNMcPMnktL+WRLgf0lwdeOqvSqh5O2/z4dgiDEe0jxJ
 LUyZi6tiGLJcBtkizvHkWpL6Jffr5BoVa485Zeau56UMiq4UCHE1PDgwraq1Ne6eY5gj
 zQ016kkCvP6aMMp3KRZr7z4QK1myr+lhG0e81JZvhEXngH+cwU5+Ihl+NB1t3aXov9Vn
 HU58alnxezty5W/tvT4egEeuHQH4/jdu9QxM/NCAh39ZgiAITW/jsiHgdLjd+vUNLhKa
 awuvlb0VX/htKbCIFWrIqdYmBPSJwX5hQ/Bb5l8J8JxZiqSI00eHF0vmFqvURIViOizn
 N6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789477168; x=1790081968;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=t1jOOMuOs5hdJBN1FmCfM6JCYmdILOYqAUY1+BMbt50=;
 b=ofYHVIXXasqZ1zMXjdW8jPIEeguCwCorjYZcRppRDJNwnBOiQxaaTHSGIllTiDP9Gp
 T/LZsFSWfDGqoiUCqaLdYa/NKfnRBAB1OAUeGfQEEIv8VzgMPxyr3mUhUC4rLcUiuD9N
 0WTeB0mgFaePbccxbMVfXq8EJuGsnd3sbp1P8tG2bI/zPSeO04EMHaMRLmUk/0VIBQ+E
 hqTYK0IBtSVqmnfSUMOpUK2YqTlrV45PdEJ9BmqYbVn5S3c4eZgwIyP45847TAIAqMox
 +JaMnRV686gt3e18r4s+8HsJIHf1UZpWJGIcDB+GsbdB4crSJNNDa61ScL88eq4468Xn
 bwNQ==
X-Gm-Message-State: AFuF++mGYDnkscQ+EzFfy97/t2igq601ydjwNhYp14b2QgnFsRzX8nYn
 6jtFoQvSMq9cK43p/PIhs7RtogemSNlhaeQURrj2Z4cwkdfbAHyG61DlDEILwnRqHNDhGNuEoam
 Wrj38o5eC9G/EoKnG3i67x3ysaSPCurmERXs1poNnilmdbLvnxag0dudp8r0YgUx+q79GUMCoFx
 C5+dzKlw==
X-Gm-Gg: AYBFou0FXvvBPAhdGCmDdXkP5ollYknDcl/ThvHk4u8/KJFLVlQZitWVnX4MKdSwCH2
 ZVtzODH9lacfx2GGba/lUTNS2wXlcqF5oWqEa/0yEwl3hqlQdVJmNv8eIcUN9f3U+ypA9QyhH3v
 qKxHL2M9gFK156wpsxWl3AC/0mUad/GrapXuvrincT5hX7ld/O9LzfrnaR3fKzN/kIzmi8MY1OZ
 JUAO8baLec48a/dSVV/NcEr3YAy+CYcNQqj67nTJqHoYzZjnJxhjU4+kXTBLSz7ev8N9Cu4om/Y
 szFeCEtQ8ydGQxHF+GyuEPiK1ZhictonEE/e86qLd/WmxolX/spDpQXeANfkEqrhlmanwzHHXZp
 gPh5rHgQl26McatfOuHcJr1dsh9wjNTjsofaCRdCD1/M3W4I5pyQrwfyf7PEyFyZFRWRjkXjFi9
 L7z2D/ig7jHkhiybcbA4DRBfcynM/wR2XAL2icf/qBKnnMHV6oS98qRgM9GduS/l0KRedxj3sy4
 cB9FWRz7evWCTjVUw57ekqn/4j8aBYw0o/7CdEveGdALFhJEfZ16xF6c7Jp9Tdvqs5aG72s8tDc
 ZQTjOjnMQm1FRO1EIOWtxDWGv8dlF9LeEk46L3NjfKE6AH2IY8vWXFfIRy8rEw==
X-Received: by 2002:a05:600c:3585:b0:49d:17d4:aff2 with SMTP id
 5b1f17b1804b1-49e7a638783mr186808695e9.1.1789477167306; 
 Tue, 15 Sep 2026 05:59:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7ef2e117sm63517345e9.1.2026.09.15.05.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 05:59:26 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 12:59:19 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 1fe9f18b1c579166380d891ca0027835ccc1996b
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7d79d71f65becfc78c79f162591533c510ff21d4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6Sl4-0007gi-NG
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 --server-probe to order client remotes by probe
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8577224034654491334=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8577224034654491334==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WkFTO3IKQ0M="; charset=UTF-8

--WkFTO3IKQ0M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail

to look a=
t the new patch set (#23)=2E

The following approvals got outdated and were=
 removed:
Code-Review+1 by ralf_lici, Code-Review-1 by plaisthos


Change s=
ubject: oob: Add --server-probe to order client remotes by probe
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add --server-prob=
e to order client remotes by probe

With --server-probe [max-latency-diff],=
 before connecting a client sends
an out-of-band SERVER_PROBE to all config=
ured UDP remotes, collects the
PROBE_REPLYs for one second, and reorders th=
e connection list so
the best-responding server is tried first=2E Unanswere=
d probes are resent
once within that window to ride out packet loss=2E The =
option is off by
default; its optional argument overrides the margin the se=
rver
advertises=2E

The probe phase is self-contained in oob_client=2Ec beh=
ind a single call
from init=2Ec (before next_connection_entry())=2E It open=
s one UDP socket
per address family in use through create_socket_udp_config=
ured(), so a
probe socket is set up and bound like the connection socket it=
 may later
become (--local, --lport, --bind-dev, --mark), fans probes out a=
nd
collects replies on them, matches each reply to its remote by source
add=
ress, and rejects spoofed replies via the session id the server
echoes back=
=2E An address several entries resolve to is probed once and
its reply cred=
ited to each of them=2E Remotes resolve with their own
udp4/udp6 family=2E =
The first remote that can be probed provides the
socket settings; probing i=
s declined when another probed remote binds
differently, since one socket s=
et cannot represent both=2E TCP remotes and
remotes behind a SOCKS proxy ar=
e not probed, and an address family whose
socket cannot be created is skipp=
ed rather than fatal=2E When both
families are bound, the IPv6 probe socket=
 is v6-only so the two do not
collide on the port=2E The reply matching and=
 the per-round address list
are oob_probe_next_target_at() and oob_addr_lis=
t_find() in oob=2Ec, on
the public struct oob_probe_target, with unit tests=
=2E Ranking and
reordering use oob_rank_probe_results()=2E

For now the pro=
be is sent unwrapped, so it only works against a server
without tls-auth/tl=
s-crypt (wrapping is a follow-up); only UDP remotes
are probed; and probing=
 runs once, before the first connection=2E

Change-Id: I5a7e9e13b9f9548b7ff=
717daae2b4a9cde3c06f2
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M=
 CMakeLists=2Etxt
M doc/man-sections/client-options=2Erst
M src/openvpn/Mak=
efile=2Eam
M src/openvpn/init=2Ec
M src/openvpn/oob=2Ec
M src/openvpn/oob=
=2Eh
A src/openvpn/oob_client=2Ec
A src/openvpn/oob_client=2Eh
M src/openvp=
n/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/socket=2Ec
M src/open=
vpn/socket=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
13 files changed, 92=
5 insertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/47/1747/23

diff --git a/CMakeLists=2Etxt b/CMakeL=
ists=2Etxt
index fbc69f0=2E=2Eb87f1ef 100644
--- a/CMakeLists=2Etxt
+++ b/C=
MakeLists=2Etxt
@@ -527,6 +527,8 @@
     src/openvpn/occ=2Eh
     src/openv=
pn/oob=2Ec
     src/openvpn/oob=2Eh
+    src/openvpn/oob_client=2Ec
+    sr=
c/openvpn/oob_client=2Eh
     src/openvpn/openvpn=2Ec
     src/openvpn/open=
vpn=2Eh
     src/openvpn/openvpn_win32_resources=2Erc
diff --git a/doc/man-=
sections/client-options=2Erst b/doc/man-sections/client-options=2Erst
index=
 87c138a=2E=2Ed07f8de 100644
--- a/doc/man-sections/client-options=2Erst
++=
+ b/doc/man-sections/client-options=2Erst
@@ -595,6 +595,46 @@
   seconds f=
or a response before trying the next server=2E The default value
   is :cod=
e:`120`=2E This timeout includes proxy and TCP connect timeouts=2E
 
+--ser=
ver-probe args
+  Before the first connection attempt, probe all configured=
 UDP remotes
+  out-of-band and reorder the connection list based on the re=
plies=2E
+
+  Valid syntaxes::
+
+     server-probe
+     server-probe max-=
latency-diff
+
+  A small probe message is sent to the first resolved addre=
ss of every UDP
+  remote, and each answering server replies with its adver=
tised priority
+  and weight=2E Remotes are then reordered following DNS SR=
V (RFC 2782)
+  semantics: servers that answered are tried before those tha=
t did not,
+  grouped by priority (lowest first); within a priority group, =
servers are
+  picked by weighted-random selection=2E Round-trip time is no=
t yet taken
+  into account, so ``max-latency-diff`` has no effect for now=
=2E
+
+  The probe is currently sent without control-channel wrapping, so i=
t only
+  works against a server configured without ``--tls-auth``,
+  ``--=
tls-crypt`` or ``--tls-crypt-v2``=2E
+
+  Only UDP remotes are probed, and =
only when there are at least two
+  remotes; remotes reached through a SOCK=
S proxy are not probed=2E The
+  probes are sent from one socket per addres=
s family, set up like the
+  connection socket of the first remote that can=
 be probed; all probed
+  remotes must therefore share its local bind setti=
ngs (``--local``,
+  ``--lport``, ``--bind``), otherwise probing is skipped=
 and the
+  configured order is used=2E Remotes that answered are tried fir=
st, in the
+  order described above; all other remotes, including TCP ones,=
 follow in
+  their configured order=2E Probing runs once per process, befo=
re the first
+  connection attempt; a reconnect or a SIGUSR1 restart does n=
ot probe again=2E
+
+  Probing delays the first connection attempt by up to=
 one second, plus
+  the time needed to resolve each remote=2E A server onl=
y answers a probe
+  whose timestamp is within its ``--hand-window`` of its=
 own clock, so a
+  client whose clock is badly wrong receives no replies a=
nd keeps the
+  configured order=2E Ordering by probe replaces any order th=
at
+  ``--remote-random`` produced=2E See ``--server-probe-reply`` for the
=
+  server side=2E
+
 --static-challenge args
   Enable static challenge/res=
ponse protocol
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makef=
ile=2Eam
index 5e6b4d9=2E=2Ef8a5835 100644
--- a/src/openvpn/Makefile=2Eam
=
+++ b/src/openvpn/Makefile=2Eam
@@ -109,6 +109,7 @@
 	pkcs11_openssl=2Ec \
=
 	pkcs11_mbedtls=2Ec \
 	oob=2Ec oob=2Eh \
+	oob_client=2Ec oob_client=2Eh =
\
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh \
 	options_show=2E=
c options_show=2Eh \
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec
index 453ee7e=2E=2E529c5a3 100644
--- a/src/openvpn/init=2Ec
+++ b/src=
/openvpn/init=2Ec
@@ -48,6 +48,7 @@
 #include "ssl_ncp=2Eh"
 #include "tls_=
crypt=2Eh"
 #include "forward=2Eh"
+#include "oob_client=2Eh"
 #include "au=
th_token=2Eh"
 #include "mss=2Eh"
 #include "mudp=2Eh"
@@ -4446,6 +4447,10 =
@@
         }
     }
 
+    /* Probe configured remotes and reorder them be=
st-first (--server-probe);
+     * no-op otherwise=2E Must run before next_=
connection_entry() picks a remote=2E */
+    client_probe_and_order_remotes=
(c);
+
     /* Resets all values to the initial values from the config wher=
e needed */
     pre_connect_restore(&c->options, &c->c2=2Egc);
 
diff --gi=
t a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index c0c8955=2E=2E20b3a4f 10=
0644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -148,6 +148,33 =
@@
     return oob_timestamp_in_window(param=2Etimestamp, now, window_secs)=
;
 }
 
+int
+oob_probe_next_target_at(const struct openvpn_sockaddr *from, =
const struct oob_probe_target *targets,
+                         const str=
uct oob_probe_result *results, int n, int start)
+{
+    for (int i =3D sta=
rt; i < n; i++)
+    {
+        if (targets[i]=2Esent && !results[i]=2Eresp=
onded && addr_port_match(from, &targets[i]=2Edest))
+        {
+           =
 return i;
+        }
+    }
+    return -1;
+}
+
+int
+oob_addr_list_find(=
const struct openvpn_sockaddr *list, int n, const struct openvpn_sockaddr *=
addr)
+{
+    for (int i =3D 0; i < n; i++)
+    {
+        if (addr_port_m=
atch(&list[i], addr))
+        {
+            return i;
+        }
+    }
+=
    return -1;
+}
+
 /* Base ordering: responders before non-responders, th=
en by priority (lower
  * first), then by RTT (lower first), then by origin=
al index for determinism=2E
  * This groups responders into priority runs p=
re-sorted by RTT, which the
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/=
oob=2Eh
index e637b90=2E=2Ee0016ee 100644
--- a/src/openvpn/oob=2Eh
+++ b/s=
rc/openvpn/oob=2Eh
@@ -37,6 +37,7 @@
 
 #include "buffer=2Eh"
 #include "se=
ssion_id=2Eh"
+#include "socket_util=2Eh"
 
 /* OOB message types: the 16-b=
it value at the start of an OOB payload, before
  * its TLV entries=2E Dist=
inct from the TLV-type space (0x2xx); see the "Messages"
@@ -189,6 +190,37 =
@@
     struct oob_probe_reply reply; /* the values the server advertised *=
/
 };
 
+/* Where the client probed one connection entry=2E */
+struct oob_=
probe_target
+{
+    struct openvpn_sockaddr dest;
+    socklen_t destlen;
=
+    bool sent;
+};
+
+/**
+ * Find the next entry, from index \p start on,=
 that was probed at \p from and
+ * has not answered yet=2E Several entries=
 can resolve to the same address, so a
+ * reply is credited to each of the=
m: call again with the returned index + 1
+ * until it returns -1=2E
+ *
+ =
* @param from     source address of the reply
+ * @param targets  where eac=
h entry was probed
+ * @param results  per-entry results; entries already m=
arked responded are skipped
+ * @param n        number of entries
+ * @para=
m start    first index to consider
+ * @return the entry index, or -1 if no=
ne
+ */
+int oob_probe_next_target_at(const struct openvpn_sockaddr *from,
=
+                             const struct oob_probe_target *targets,
+    =
                         const struct oob_probe_result *results, int n, int=
 start);
+
+/**
+ * Index of \p addr (address and port) in \p list, or -1 i=
f it is not there=2E
+ */
+int oob_addr_list_find(const struct openvpn_sock=
addr *list, int n,
+                       const struct openvpn_sockaddr *a=
ddr);
+
 /**
  * Order results best-first, in place, per the server-probe s=
election policy:
  *   - remotes that responded rank before those that did =
not (non-responders keep
diff --git a/src/openvpn/oob_client=2Ec b/src/open=
vpn/oob_client=2Ec
new file mode 100644
index 0000000=2E=2E16217c7
--- /dev=
/null
+++ b/src/openvpn/oob_client=2Ec
@@ -0,0 +1,659 @@
+/*
+ *  OpenVPN -=
- An application to securely tunnel IP networks
+ *             over a sing=
le TCP/UDP port, with support for SSL/TLS-based
+ *             session aut=
hentication and key exchange,
+ *             packet encryption, packet aut=
hentication, and
+ *             packet compression=2E
+ *
+ *  Copyright (=
C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is fre=
e software; you can redistribute it and/or modify
+ *  it under the terms o=
f the GNU General Public License version 2
+ *  as published by the Free So=
ftware Foundation=2E
+ *
+ *  This program is distributed in the hope that =
it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied =
warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  Se=
e the
+ *  GNU General Public License for more details=2E
+ *
+ *  You shou=
ld have received a copy of the GNU General Public License along
+ *  with t=
his program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#if=
def HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
=
+
+#include "oob_client=2Eh"
+#include "openvpn=2Eh"
+#include "oob=2Eh"
+#=
include "ssl_pkt=2Eh"
+#include "session_id=2Eh"
+#include "socket=2Eh"
+#i=
nclude "socket_util=2Eh"
+#include "otime=2Eh"
+#include "fdmisc=2Eh"
+#inc=
lude "crypto=2Eh"
+#include "error=2Eh"
+
+#include "memdbg=2Eh"
+
+/* Tota=
l time we wait for probe replies before giving up and connecting=2E */
+#de=
fine OOB_PROBE_WINDOW_MS 1000
+
+/* Number of times an unanswered probe is =
resent within the window, to ride out
+ * UDP packet loss=2E With this set =
to 1, each remote is probed up to 2 times,
+ * which removes the single-pac=
ket-loss false negative; further retries give
+ * sharply diminishing retur=
ns for a low-stakes selection=2E */
+#define OOB_PROBE_RETRIES 1
+
+/* The =
probe uses one socket per address family, each set up and bound like the
+ =
* connection socket, so every remote is probed on a socket of its own famil=
y and
+ * the winning remote's socket can be reused as its connection socke=
t, presenting
+ * the same source IP+port the server bound its handshake co=
okie to=2E */
+#define PROBE_AF_V4    0
+#define PROBE_AF_V6    1
+#define =
PROBE_AF_COUNT 2
+
+struct probe_ctx
+{
+    socket_descriptor_t sd[PROBE_A=
F_COUNT]; /* SOCKET_UNDEFINED if that AF is unavailable */
+    /* Addresse=
s probed so far in the current send round: an address several
+     * entri=
es resolve to is probed once, and its reply is credited to each=2E */
+    =
struct openvpn_sockaddr *probed;
+    int n_probed;
+#ifdef TARGET_ANDROID
=
+    bool fd_protected[PROBE_AF_COUNT]; /* VPNService protect(), once per s=
ocket */
+#endif
+};
+
+/* af is an int (not sa_family_t) so callers can pa=
ss addrinfo::ai_family
+ * directly without a narrowing conversion (-Werror=
=3Dconversion)=2E */
+static int
+probe_af_index(int af)
+{
+    return (af=
 =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;
+}
+
+/* Build a plaintext S=
ERVER_PROBE packet:
+ *   [opcode | key_id=3D0] [client session id] [SERVER=
_PROBE message]
+ * This is the unauthenticated OOB wire format; adding tls=
-auth/tls-crypt
+ * wrapping for the probe is a follow-up (it only works ag=
ainst a server with
+ * no control-channel wrapping for now)=2E */
+static =
bool
+oob_probe_build_packet(struct buffer *buf, const struct session_id *c=
lient_sid)
+{
+    const struct oob_probe_parameter param =3D {
+        =
=2Etimestamp =3D (uint64_t)now,
+        =2Eflags =3D 0,
+    };
+    uint8=
_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
+    return bu=
f_write_u8(buf, header) && session_id_write(client_sid, buf)
+           &&=
 oob_server_probe_write(buf, &param);
+}
+
+/* The local address and port c=
e's connection socket binds: its first --local,
+ * with --lport taking pre=
cedence in client mode, as link_socket_init_phase1()
+ * picks them for soc=
ket 0=2E */
+static void
+oob_probe_bind_target(const struct connection_ent=
ry *ce, const struct options *o,
+                      const char **host, =
const char **port)
+{
+    *host =3D NULL;
+    *port =3D ce->local_port;
+=
    if (ce->local_list && ce->local_list->len)
+    {
+        *host =3D ce=
->local_list->array[0]->local;
+        *port =3D ce->local_list->array[0]-=
>port;
+    }
+    if (o->mode =3D=3D MODE_POINT_TO_POINT && ce->local_port=
_defined)
+    {
+        *port =3D ce->local_port;
+    }
+}
+
+/* Equal s=
trings, or both absent=2E */
+static bool
+str_equal_or_both_null(const cha=
r *a, const char *b)
+{
+    return (!a && !b) || (a && b && strcmp(a, b) =
=3D=3D 0);
+}
+
+/* Can this entry be probed at all? Only a direct UDP remo=
te can answer and
+ * hand its socket to the connection=2E */
+static bool
=
+oob_probe_eligible(const struct connection_entry *ce)
+{
+    /* CE_DISABL=
ED entries are skipped by next_connection_entry(), so probing
+     * them =
would rank a remote we are never going to use=2E */
+    return ce->remote =
&& proto_is_udp(ce->proto) && !ce->socks_proxy_server
+           && !(ce->=
flags & CE_DISABLED);
+}
+
+/* Do a and b bind their connection socket the =
same way (--bind/--nobind,
+ * --local, --lport, --bind ipv6only)? One prob=
e socket set serves all probed
+ * remotes, so each must agree with the fir=
st of them, whose socket is adopted=2E */
+static bool
+oob_probe_same_bind=
(const struct connection_entry *a, const struct connection_entry *b,
+     =
               const struct options *o)
+{
+    if (a->bind_local !=3D b->b=
ind_local)
+    {
+        return false;
+    }
+    if (!a->bind_local)
+ =
   {
+        return true;
+    }
+    const char *host_a, *port_a, *host_b=
, *port_b;
+    oob_probe_bind_target(a, o, &host_a, &port_a);
+    oob_pro=
be_bind_target(b, o, &host_b, &port_b);
+    return a->bind_ipv6_only =3D=
=3D b->bind_ipv6_only && str_equal_or_both_null(host_a, host_b)
+          =
 && str_equal_or_both_null(port_a, port_b);
+}
+
+/* Resolve the local bind=
 address of ce's connection socket; NULL with --nobind=2E
+ * Fatal on fail=
ure, like the link socket=2E */
+static struct addrinfo *
+oob_probe_bind_a=
ddrinfo(const struct connection_entry *ce, const struct options *o)
+{
+   =
 if (!ce->bind_local)
+    {
+        return NULL;
+    }
+    const char *=
host, *port;
+    oob_probe_bind_target(ce, o, &host, &port);
+
+    struct=
 addrinfo *ai =3D NULL;
+    const unsigned int flags =3D GETADDR_RESOLVE |=
 GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL
+                               | G=
ETADDR_PASSIVE | GETADDR_DATAGRAM;
+    openvpn_getaddrinfo(flags, host, po=
rt, 0, NULL, AF_UNSPEC, &ai); /* fatal on failure */
+    return ai;
+}
+
+=
/* Does the address list hold an entry of family af? */
+static bool
+addri=
nfo_has_family(const struct addrinfo *ai, int af)
+{
+    for (; ai; ai =3D=
 ai->ai_next)
+    {
+        if (ai->ai_family =3D=3D af)
+        {
+    =
        return true;
+        }
+    }
+    return false;
+}
+
+/* Open the=
 probe socket of each address family in use, set up and bound exactly
+ * a=
s the connection socket (create_socket_udp_configured()), so the winner's
+=
 * socket can become that connection socket unchanged=2E A family with no -=
-local
+ * address to bind is left SOCKET_UNDEFINED and its remotes are not=
 probed, as the
+ * connection could not reach them either=2E Returns the n=
umber of sockets opened=2E */
+static int
+oob_probe_sockets_open(struct pr=
obe_ctx *pc, const bool need[PROBE_AF_COUNT],
+                       struc=
t addrinfo *bind_local, const struct connection_entry *ce,
+               =
        const struct options *o)
+{
+    static const int families[PROBE_AF=
_COUNT] =3D { AF_INET, AF_INET6 };
+    const struct socket_buffer_size sbs=
 =3D { =2Ercvbuf =3D o->rcvbuf, =2Esndbuf =3D o->sndbuf };
+    int opened =
=3D 0;
+
+    for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+    {
+        if=
 (!need[i])
+        {
+            continue;
+        }
+        if (bind_=
local && !addrinfo_has_family(bind_local, families[i]))
+        {
+       =
     msg(D_LOW, "server-probe: no %s address to bind, not probing %s remote=
s",
+                addr_family_name(families[i]), addr_family_name(famili=
es[i]));
+            continue;
+        }
+        /* Both probe sockets b=
ind the same port, and a dual-stack IPv6 wildcard
+         * collides with=
 the IPv4 one; the connection socket never has this
+         * problem as =
it binds one family only=2E */
+        const bool v6only =3D ce->bind_ipv6=
_only
+                            || (bind_local && families[i] =3D=3D AF_=
INET6
+                                && pc->sd[PROBE_AF_V4] !=3D SOCKET_U=
NDEFINED);
+        pc->sd[i] =3D create_socket_udp_configured((sa_family_t=
)families[i], o->sockflags, &sbs,
+                                        =
         o->mark, o->bind_dev, bind_local, v6only, true);
+        if (pc->=
sd[i] =3D=3D SOCKET_UNDEFINED)
+        {
+            msg(D_LOW, "server-p=
robe: no usable %s socket, not probing %s remotes",
+                addr_f=
amily_name(families[i]), addr_family_name(families[i]));
+            conti=
nue;
+        }
+        opened++;
+    }
+    return opened;
+}
+
+static =
void
+oob_probe_sockets_close(struct probe_ctx *pc)
+{
+    for (int i =3D =
0; i < PROBE_AF_COUNT; i++)
+    {
+        if (pc->sd[i] !=3D SOCKET_UNDEF=
INED)
+        {
+            openvpn_close_socket(pc->sd[i]);
+           =
 pc->sd[i] =3D SOCKET_UNDEFINED;
+        }
+    }
+}
+
+/* Parse one recei=
ved datagram as a PROBE_REPLY and, if valid and matching one
+ * of the pro=
bes we sent, record the reply in results=2E */
+static void
+oob_probe_hand=
le_reply(const uint8_t *data, int len, const struct session_id *client_sid,=

+                       const struct openvpn_sockaddr *from, const struct =
oob_probe_target *targets,
+                       struct oob_probe_result =
*results, int n)
+{
+    /* Need at least the opcode byte and the session i=
d=2E */
+    if (len < 1 + (int)SID_SIZE || (data[0] >> P_OPCODE_SHIFT) !=
=3D P_CONTROL_OOB_V1)
+    {
+        return;
+    }
+
+    struct buffer b=
uf;
+    buf_set_read(&buf, data, (size_t)len);
+    buf_advance(&buf, 1 + =
SID_SIZE); /* skip opcode + server session id */
+
+    struct oob_probe_re=
ply reply;
+    if (!oob_client_reply_read(&buf, &reply))
+    {
+        r=
eturn;
+    }
+
+    /* Reject spoofed replies: the reply must echo our pro=
be's session id=2E */
+    if (!session_id_equal(&reply=2Epeer_session_id, =
client_sid))
+    {
+        return;
+    }
+
+    /* Credit the reply to e=
very still-unanswered remote probed at its source
+     * address: several =
entries can resolve to the same address, and each takes
+     * the first r=
eply for it=2E */
+    int i =3D oob_probe_next_target_at(from, targets, re=
sults, n, 0);
+    while (i >=3D 0)
+    {
+        results[i]=2Eresponded =
=3D true;
+        results[i]=2Ereply =3D reply;
+
+        i =3D oob_probe=
_next_target_at(from, targets, results, n, i + 1);
+    }
+}
+
+/* Count ho=
w many of the probes we sent have been answered so far=2E */
+static int
+o=
ob_count_answered(const struct oob_probe_target *targets, const struct oob_=
probe_result *results,
+                   int n)
+{
+    int answered =3D =
0;
+    for (int i =3D 0; i < n; i++)
+    {
+        answered +=3D (target=
s[i]=2Esent && results[i]=2Eresponded) ? 1 : 0;
+    }
+    return answered=
;
+}
+
+/* Receive replies for one time slice (until deadline), recording e=
ach that
+ * matches a probe we sent=2E Returns true if every sent probe ha=
s been answered=2E */
+static bool
+oob_probe_receive_slice(const struct pr=
obe_ctx *pc, const struct timeval *deadline,
+                        const=
 struct session_id *client_sid, const struct oob_probe_target *targets,
+  =
                      struct oob_probe_result *results, int n, int outstand=
ing)
+{
+    while (true)
+    {
+        struct timeval tnow, timeout;
+  =
      openvpn_gettimeofday(&tnow, NULL);
+        timeout=2Etv_sec =3D dead=
line->tv_sec - tnow=2Etv_sec;
+        timeout=2Etv_usec =3D deadline->tv_u=
sec - tnow=2Etv_usec;
+        if (timeout=2Etv_usec < 0)
+        {
+     =
       timeout=2Etv_sec -=3D 1;
+            timeout=2Etv_usec +=3D 1000000=
;
+        }
+        if (timeout=2Etv_sec < 0)
+        {
+            ret=
urn false; /* slice elapsed */
+        }
+
+        fd_set readfds;
+     =
   FD_ZERO(&readfds);
+        socket_descriptor_t maxsd =3D 0;
+        fo=
r (int i =3D 0; i < PROBE_AF_COUNT; i++)
+        {
+            if (pc->sd=
[i] !=3D SOCKET_UNDEFINED)
+            {
+                openvpn_fd_set(p=
c->sd[i], &readfds);
+                if (pc->sd[i] > maxsd)
+             =
   {
+                    maxsd =3D pc->sd[i];
+                }
+        =
    }
+        }
+        if (openvpn_select(maxsd + 1, &readfds, NULL, NUL=
L, &timeout) <=3D 0)
+        {
+            return false; /* slice timed o=
ut, or error */
+        }
+
+        for (int i =3D 0; i < PROBE_AF_COUNT;=
 i++)
+        {
+            if (pc->sd[i] =3D=3D SOCKET_UNDEFINED || !FD_=
ISSET(pc->sd[i], &readfds))
+            {
+                continue;
+    =
        }
+            uint8_t data[256];
+            struct openvpn_socka=
ddr from;
+            socklen_t fromlen =3D sizeof(from);
+            int=
 len =3D (int)recvfrom(pc->sd[i], (char *)data, (int)sizeof(data), 0,
+    =
                                (struct sockaddr *)&from, &fromlen);
+     =
       if (len > 0)
+            {
+                oob_probe_handle_reply(=
data, len, client_sid, &from, targets, results, n);
+            }
+       =
 }
+        if (oob_count_answered(targets, results, n) >=3D outstanding)
+=
        {
+            return true; /* every probe we sent has been answere=
d */
+        }
+    }
+}
+
+/* Resend the probe to every remote that we pr=
obed but that has not answered=2E */
+static void
+oob_probe_resend_unanswe=
red(struct probe_ctx *pc, const struct buffer *probe,
+                    =
        const struct oob_probe_target *targets,
+                          =
  const struct oob_probe_result *results, int n)
+{
+    pc->n_probed =3D 0=
; /* a new round: probe each unanswered address once again */
+    for (int=
 i =3D 0; i < n; i++)
+    {
+        if (!targets[i]=2Esent || results[i]=
=2Eresponded
+            || oob_addr_list_find(pc->probed, pc->n_probed, &=
targets[i]=2Edest) >=3D 0)
+        {
+            continue;
+        }
+  =
      socket_descriptor_t sd =3D pc->sd[probe_af_index(targets[i]=2Edest=2E=
addr=2Esa=2Esa_family)];
+        if (sd !=3D SOCKET_UNDEFINED
+           =
 && sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,
+          =
            (const struct sockaddr *)&targets[i]=2Edest, targets[i]=2Edestl=
en)
+                   >=3D 0)
+        {
+            pc->probed[pc->n_pr=
obed++] =3D targets[i]=2Edest;
+        }
+    }
+}
+
+/* Collect replies o=
ver the probe window, resending unanswered probes up to
+ * OOB_PROBE_RETRI=
ES times (UDP is lossy and a probe carries no retransmission
+ * of its own=
)=2E The window is split into equal slices, one per send round; after
+ * e=
ach slice but the last we resend to whoever has not answered yet=2E Returns=

+ * once the window elapses or every sent probe has been answered=2E */
+s=
tatic void
+oob_probe_collect(struct probe_ctx *pc, const struct buffer *pr=
obe,
+                  const struct session_id *client_sid, const struct o=
ob_probe_target *targets,
+                  struct oob_probe_result *resul=
ts, int n,
+                  const struct signal_info *sig)
+{
+    /* num=
ber of probes we actually sent: stop early once they all answer */
+    int=
 want =3D 0;
+    for (int i =3D 0; i < n; i++)
+    {
+        want +=3D t=
argets[i]=2Esent ? 1 : 0;
+    }
+
+    const int slices =3D 1 + OOB_PROBE_=
RETRIES;
+    const long slice_ms =3D OOB_PROBE_WINDOW_MS / slices;
+
+    =
for (int slice =3D 0; slice < slices; slice++)
+    {
+        struct timev=
al deadline;
+        openvpn_gettimeofday(&deadline, NULL);
+        deadl=
ine=2Etv_sec +=3D slice_ms / 1000;
+        deadline=2Etv_usec +=3D (slice_=
ms % 1000) * 1000;
+        if (deadline=2Etv_usec >=3D 1000000)
+        {=

+            deadline=2Etv_sec +=3D 1;
+            deadline=2Etv_usec -=
=3D 1000000;
+        }
+
+        if (oob_probe_receive_slice(pc, &deadlin=
e, client_sid, targets, results, n, want)
+            || sig->signal_recei=
ved)
+        {
+            return; /* all answered, or we are being told =
to stop */
+        }
+
+        if (slice + 1 < slices)
+        {
+      =
      oob_probe_resend_unanswered(pc, probe, targets, results, n);
+       =
 }
+    }
+}
+
+/* Permute the connection list so entries appear in ranked =
order=2E */
+static void
+oob_apply_order(struct connection_list *l, const =
struct oob_probe_result *ranked,
+                struct gc_arena *gc)
+{
+=
    struct connection_entry **reordered =3D gc_malloc(sizeof(*reordered) * =
l->len, false, gc);
+    for (int i =3D 0; i < l->len; i++)
+    {
+       =
 reordered[i] =3D l->array[ranked[i]=2Eindex];
+    }
+    memcpy(l->array,=
 reordered, sizeof(*l->array) * l->len);
+}
+
+void
+client_probe_and_order=
_remotes(struct context *c)
+{
+    /* Probe only once, before the first co=
nnection attempt=2E */
+    if (!c->options=2Eserver_probe || !c->first_tim=
e)
+    {
+        return;
+    }
+
+    struct connection_list *l =3D c->o=
ptions=2Econnection_list;
+    if (!l || l->len <=3D 1)
+    {
+        ret=
urn; /* nothing to choose between */
+    }
+
+    struct gc_arena gc =3D g=
c_new();
+
+    /* A single random session id identifies all of our probes;=
 servers echo it
+     * back in the reply's peer_session_id, letting us re=
ject spoofed replies=2E */
+    struct session_id client_sid;
+    session_=
id_random(&client_sid);
+
+    /* The probe sockets are set up like the con=
nection socket of the first
+     * remote we can probe, whose socket the w=
inner adopts; probing cannot serve
+     * remotes that bind differently=2E=
 */
+    const struct connection_entry *tmpl =3D NULL;
+    for (int i =3D =
0; i < l->len; i++)
+    {
+        const struct connection_entry *ce =3D l=
->array[i];
+        if (!oob_probe_eligible(ce))
+        {
+            c=
ontinue;
+        }
+        if (!tmpl)
+        {
+            tmpl =3D ce=
;
+            continue;
+        }
+        if (!oob_probe_same_bind(tmpl,=
 ce, &c->options))
+        {
+            msg(D_LOW, "server-probe: %s:%s =
binds differently from %s:%s;"
+                       " not probing, using=
 configured order",
+                ce->remote, ce->remote_port, tmpl->rem=
ote, tmpl->remote_port);
+            gc_free(&gc);
+            return;
+ =
       }
+    }
+    if (!tmpl)
+    {
+        msg(D_LOW, "server-probe: n=
o remote can be probed; using configured order");
+        gc_free(&gc);
+ =
       return;
+    }
+
+    struct probe_ctx pc =3D { =2Esd =3D { SOCKET_U=
NDEFINED, SOCKET_UNDEFINED } };
+    struct oob_probe_target *targets =3D g=
c_malloc(sizeof(*targets) * l->len, true, &gc);
+    struct oob_probe_resul=
t *results =3D gc_malloc(sizeof(*results) * l->len, true, &gc);
+
+    stru=
ct buffer probe =3D alloc_buf_gc(256, &gc);
+    if (!oob_probe_build_packe=
t(&probe, &client_sid))
+    {
+        msg(D_LOW, "server-probe: could not=
 build probe packet; using configured order");
+        oob_probe_sockets_c=
lose(&pc);
+        gc_free(&gc);
+        return;
+    }
+
+    msg(D_LOW,=
 "server-probe: probing %d remote(s) with a %d ms window", l->len,
+       =
 OOB_PROBE_WINDOW_MS);
+
+    /* Resolve every remote first, so only the ad=
dress families actually in use
+     * get a probe socket=2E */
+    bool n=
eed_af[PROBE_AF_COUNT] =3D { false, false };
+    for (int i =3D 0; i < l->=
len; i++)
+    {
+        results[i]=2Eindex =3D i;
+        results[i]=2Er=
esponded =3D false;
+
+        const struct connection_entry *ce =3D l->arr=
ay[i];
+        if (!oob_probe_eligible(ce))
+        {
+            if (ce=
->remote)
+            {
+                msg(D_LOW, "server-probe: %s:%s: =
skipping (not a direct UDP remote)", ce->remote,
+                    ce->r=
emote_port);
+            }
+            continue;
+        }
+
+        /*=
 ce->af honours a udp4/udp6 remote, as the connection does */
+        stru=
ct addrinfo *ai =3D NULL;
+        int status =3D openvpn_getaddrinfo(GETAD=
DR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_DATAGRAM,
+                        =
                 ce->remote, ce->remote_port, 0, NULL, ce->af, &ai);
+     =
   if (status !=3D 0 || !ai)
+        {
+            msg(D_LOW, "server-pro=
be: %s:%s: could not resolve", ce->remote, ce->remote_port);
+            c=
ontinue;
+        }
+
+        /* Store the first resolved address natively=
 (no IPv4-mapping); it is
+         * later probed on its family's socket=
=2E */
+        memcpy(&targets[i]=2Edest, ai->ai_addr, ai->ai_addrlen);
+ =
       targets[i]=2Edestlen =3D (socklen_t)ai->ai_addrlen;
+        need_af=
[probe_af_index(ai->ai_family)] =3D true;
+        freeaddrinfo(ai);
+    }=

+
+    struct addrinfo *bind_local =3D oob_probe_bind_addrinfo(tmpl, &c->o=
ptions);
+    if (oob_probe_sockets_open(&pc, need_af, bind_local, tmpl, &c=
->options) =3D=3D 0)
+    {
+        msg(D_LOW, "server-probe: nothing to p=
robe; using configured order");
+        if (bind_local)
+        {
+      =
      freeaddrinfo(bind_local);
+        }
+        gc_free(&gc);
+        =
return;
+    }
+
+    /* Send a probe to each resolved remote, on the socke=
t of its address family=2E
+     * An address several entries resolve to is=
 probed once; its reply is
+     * credited to each of them=2E */
+    pc=
=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * l->len, false, &gc);
+    pc=
=2En_probed =3D 0;
+
+    int sent_count =3D 0;
+    for (int i =3D 0; i < =
l->len; i++)
+    {
+        const struct connection_entry *ce =3D l->array=
[i];
+        if (!targets[i]=2Edestlen)
+        {
+            continue;
=
+        }
+        const int af =3D probe_af_index(targets[i]=2Edest=2Eadd=
r=2Esa=2Esa_family);
+        socket_descriptor_t sd =3D pc=2Esd[af];
+    =
    if (sd =3D=3D SOCKET_UNDEFINED)
+        {
+            continue; /* fa=
mily not probed, see oob_probe_sockets_open() */
+        }
+#ifdef TARGET_=
ANDROID
+        /* Keep the probe out of an active tunnel, as the connecti=
on socket is=2E
+         * protect_fd_nonlocal() declines a local peer, so=
 only a non-local one
+         * actually protects the socket and may latc=
h the flag=2E */
+        if (!pc=2Efd_protected[af] && !addr_local(&target=
s[i]=2Edest=2Eaddr=2Esa))
+        {
+            protect_fd_nonlocal(sd, &=
targets[i]=2Edest=2Eaddr=2Esa);
+            pc=2Efd_protected[af] =3D true=
;
+        }
+#endif
+        if (oob_addr_list_find(pc=2Eprobed, pc=2En_pr=
obed, &targets[i]=2Edest) < 0)
+        {
+            if (sendto(sd, (cons=
t char *)BPTR(&probe), (int)BLEN(&probe), 0,
+                       (struc=
t sockaddr *)&targets[i]=2Edest, targets[i]=2Edestlen)
+                < 0=
)
+            {
+                msg(D_LOW, "server-probe: %s:%s: probe se=
nd failed", ce->remote, ce->remote_port);
+                continue;
+     =
       }
+            pc=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;
+=
        }
+        targets[i]=2Esent =3D true;
+        sent_count++;
+    =
}
+
+    if (sent_count > 0)
+    {
+        oob_probe_collect(&pc, &probe,=
 &client_sid, targets, results, l->len,
+                          c->sig);=

+    }
+    oob_probe_sockets_close(&pc);
+    if (bind_local)
+    {
+   =
     freeaddrinfo(bind_local);
+    }
+
+    /* Log each remote's outcome w=
hile results[i] still maps to array[i]=2E */
+    int responded =3D 0;
+   =
 for (int i =3D 0; i < l->len; i++)
+    {
+        const struct connection=
_entry *ce =3D l->array[i];
+        if (results[i]=2Eresponded)
+        {=

+            responded++;
+            msg(D_LOW, "server-probe: %s:%s ans=
wered (priority %d, weight %d)", ce->remote,
+                ce->remote_po=
rt, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight);
+        }=

+        else
+        {
+            msg(D_LOW, "server-probe: %s:%s did =
not answer", ce->remote, ce->remote_port);
+        }
+    }
+
+    /* Rank=
 best-first and reorder the connection list accordingly=2E */
+    oob_rank=
_probe_results(results, l->len, c->options=2Eserver_probe_latency_margin, g=
et_random, &gc);
+    oob_apply_order(l, results, &gc);
+
+    msg(D_LOW, "=
server-probe: connecting in this order:");
+    for (int i =3D 0; i < l->le=
n; i++)
+    {
+        msg(D_LOW, "server-probe:   %d=2E %s:%s", i + 1, l-=
>array[i]->remote,
+            l->array[i]->remote_port);
+    }
+
+    ms=
g(M_INFO, "server-probe: %d of %d probed remote(s) answered; connecting bes=
t-first",
+        responded, sent_count);
+
+    gc_free(&gc);
+}
diff --g=
it a/src/openvpn/oob_client=2Eh b/src/openvpn/oob_client=2Eh
new file mode =
100644
index 0000000=2E=2Eac44cdb
--- /dev/null
+++ b/src/openvpn/oob_clien=
t=2Eh
@@ -0,0 +1,44 @@
+/*
+ *  OpenVPN -- An application to securely tunne=
l IP networks
+ *             over a single TCP/UDP port, with support for =
SSL/TLS-based
+ *             session authentication and key exchange,
+ * =
            packet encryption, packet authentication, and
+ *             p=
acket compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@op=
envpn=2Enet>
+ *
+ *  This program is free software; you can redistribute i=
t and/or modify
+ *  it under the terms of the GNU General Public License v=
ersion 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This=
 program is distributed in the hope that it will be useful,
+ *  but WITHOU=
T ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Lice=
nse for more details=2E
+ *
+ *  You should have received a copy of the GNU=
 General Public License along
+ *  with this program; if not, see <https://=
www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Client-side server-=
probe phase: before connecting, optionally probe all
+ * configured remotes=
 with an out-of-band SERVER_PROBE and order them
+ * best-first, so the con=
nection loop tries the most suitable server first=2E
+ */
+
+#ifndef OOB_CL=
IENT_H
+#define OOB_CLIENT_H
+
+struct context;
+
+/**
+ * Probe all config=
ured remotes and reorder the connection list best-first=2E
+ *
+ * Does not=
hing unless --server-probe is enabled=2E On any failure (or if no
+ * serve=
r answers), the configured remote order is left unchanged and the
+ * norma=
l connection sequence proceeds=2E
+ */
+void client_probe_and_order_remotes=
(struct context *c);
+
+#endif /* OOB_CLIENT_H */
diff --git a/src/openvpn/=
options=2Ec b/src/openvpn/options=2Ec
index e3cd527=2E=2E35ef2af 100644
---=
 a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -150,6 +150,9 @=
@
     "                      udp6, tcp6-server, tcp6-client\n"
     "--pro=
to-force p : only consider protocol p in list of connection profiles=2E\n"
=
     "                  p =3D udp or tcp\n"
+    "--server-probe [n] : For =
client, probe all UDP remotes before connecting and\n"
+    "              =
    try them best-first; n overrides the latency margin (ms)\n"
+    "     =
             the server advertises=2E\n"
     "--connect-retry n [m] : For =
client, number of seconds to wait between\n"
     "                  connec=
tion retries (default=3D%d)=2E On repeated retries\n"
     "               =
   the wait time is exponentially increased to a maximum of m\n"
@@ -809,6 =
+812,11 @@
     o->topology =3D TOP_UNDEF;
     o->ce=2Eproto =3D PROTO_UDP=
;
     o->ce=2Eaf =3D AF_UNSPEC;
+
+    /* The client latency margin is -1 =
=3D "not set": the client's value is
+     * authoritative when given, othe=
rwise each server's advertised margin (or
+     * the built-in default) app=
lies=2E */
+    o->server_probe_latency_margin =3D -1;
     o->ce=2Ebind_ip=
v6_only =3D false;
     o->ce=2Econnect_retry_seconds =3D 1;
     o->ce=2Ec=
onnect_retry_seconds_max =3D 300;
@@ -5082,6 +5090,21 @@
         VERIFY_PE=
RMISSION(OPT_P_GENERAL);
         options->mtu_test =3D true;
     }
+    e=
lse if (streq(p[0], "server-probe") && !p[2])
+    {
+        VERIFY_PERMIS=
SION(OPT_P_GENERAL);
+        options->server_probe =3D true;
+        if (=
p[1])
+        {
+            int margin =3D positive_atoi(p[1], msglevel);=

+            if (margin > 0xffff)
+            {
+                msg(msgl=
evel, "--server-probe: max-latency-diff must be 0 to 65535 ms");
+         =
       goto err;
+            }
+            options->server_probe_latency_=
margin =3D margin;
+        }
+    }
     else if (streq(p[0], "nice") && p=
[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/s=
rc/openvpn/options=2Eh b/src/openvpn/options=2Eh
index f472676=2E=2Ec2cde60=
 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -337=
,6 +337,11 @@
 
     bool mtu_test;
 
+    bool server_probe; /* client: pr=
obe remotes (--server-probe) and connect best-first */
+    /* client: defa=
ult candidate-band margin in ms (--server-probe [max-latency-diff]):
+     =
* servers within this RTT of the fastest are treated as equally fast */
+  =
  int server_probe_latency_margin;
+
     bool mlock;
 
     int keepalive_=
ping; /* a proxy for ping/ping-restart */
diff --git a/src/openvpn/socket=
=2Ec b/src/openvpn/socket=2Ec
index 4c0aab5=2E=2Ee7acabc 100644
--- a/src/o=
penvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -733,7 +733,7 @@
 }
 
 #i=
fdef TARGET_ANDROID
-static void
+void
 protect_fd_nonlocal(int fd, const s=
truct sockaddr *addr)
 {
     if (!management)
diff --git a/src/openvpn/soc=
ket=2Eh b/src/openvpn/socket=2Eh
index 4db3f3b=2E=2Ef60b031 100644
--- a/sr=
c/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -408,6 +408,15 @@
 
 s=
ocket_descriptor_t create_socket_tcp(struct addrinfo *);
 
+#ifdef TARGET_A=
NDROID
+/**
+ * Hand \p fd to the VPNService API as a protected socket, so =
its traffic is not
+ * routed back into a tunnel=2E \p addr is the intended=
 peer; a local one is left
+ * unprotected=2E
+ */
+void protect_fd_nonloca=
l(int fd, const struct sockaddr *addr);
+#endif
+
 /**
  * Create a UDP soc=
ket for \p af set up the way a link socket is: --sndbuf/--rcvbuf,
  * --mar=
k, --bind-dev and, when \p bind_addr is given, the local bind (IPV6_V6ONLY
=
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openv=
pn/test_oob=2Ec
index 0b0ce96=2E=2E56b5018 100644
--- a/tests/unit_tests/op=
envpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -508,6 +5=
08,80 @@
     gc_free(&gc);
 }
 
+static struct openvpn_sockaddr
+v4_addr(u=
int32_t addr, uint16_t port)
+{
+    struct openvpn_sockaddr sa =3D { 0 };
=
+    sa=2Eaddr=2Ein4=2Esin_family =3D AF_INET;
+    sa=2Eaddr=2Ein4=2Esin_a=
ddr=2Es_addr =3D htonl(addr);
+    sa=2Eaddr=2Ein4=2Esin_port =3D htons(por=
t);
+    return sa;
+}
+
+static struct oob_probe_target
+probe_target(stru=
ct openvpn_sockaddr dest, bool sent)
+{
+    return (struct oob_probe_targe=
t){ =2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ein4), =2Esent =3D=
 sent };
+}
+
+/* Two entries resolve to the same address=2E The first repl=
y from it is
+ * credited to both entries; a second reply is ignored=2E */
=
+static void
+test_probe_reply_credits_every_entry_at_address(void **state)=

+{
+    struct openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);
+    stru=
ct oob_probe_target targets[2] =3D { probe_target(a, true), probe_target(a,=
 true) };
+    struct oob_probe_result results[2] =3D { 0 };
+
+    int i =
=3D oob_probe_next_target_at(&a, targets, results, 2, 0);
+    assert_int_e=
qual(i, 0);
+    results[i]=2Eresponded =3D true;
+    i =3D oob_probe_next=
_target_at(&a, targets, results, 2, i + 1);
+    assert_int_equal(i, 1);
+ =
   results[i]=2Eresponded =3D true;
+    assert_int_equal(oob_probe_next_ta=
rget_at(&a, targets, results, 2, i + 1), -1);
+
+    /* the server's second=
 reply finds nothing left to credit */
+    assert_int_equal(oob_probe_next=
_target_at(&a, targets, results, 2, 0), -1);
+}
+
+/* A reply only matches =
entries probed at its address, and only those actually
+ * sent; a differen=
t port is a different address=2E */
+static void
+test_probe_reply_matches_=
only_its_address(void **state)
+{
+    struct openvpn_sockaddr a =3D v4_add=
r(0x7f000001, 1194);
+    struct openvpn_sockaddr b =3D v4_addr(0x7f000002,=
 1194);
+    struct openvpn_sockaddr a_other_port =3D v4_addr(0x7f000001, 1=
195);
+    struct oob_probe_target targets[3] =3D {
+        probe_target(a=
, true),
+        probe_target(b, true),
+        probe_target(a, false), /=
* resolved but never sent */
+    };
+    struct oob_probe_result results[3=
] =3D { 0 };
+
+    assert_int_equal(oob_probe_next_target_at(&b, targets, =
results, 3, 0), 1);
+    assert_int_equal(oob_probe_next_target_at(&b, targ=
ets, results, 3, 2), -1);
+    assert_int_equal(oob_probe_next_target_at(&a=
, targets, results, 3, 0), 0);
+    assert_int_equal(oob_probe_next_target_=
at(&a, targets, results, 3, 1), -1);
+    assert_int_equal(oob_probe_next_t=
arget_at(&a_other_port, targets, results, 3, 0), -1);
+}
+
+/* The per-roun=
d list of probed addresses compares address and port=2E */
+static void
+te=
st_addr_list_find(void **state)
+{
+    struct openvpn_sockaddr list[2] =3D=
 { v4_addr(0x7f000001, 1194), v4_addr(0x7f000002, 1194) };
+    struct open=
vpn_sockaddr same =3D v4_addr(0x7f000002, 1194);
+    struct openvpn_sockad=
dr other_port =3D v4_addr(0x7f000002, 1195);
+    struct openvpn_sockaddr o=
ther_host =3D v4_addr(0x7f000003, 1194);
+
+    assert_int_equal(oob_addr_l=
ist_find(list, 2, &same), 1);
+    assert_int_equal(oob_addr_list_find(list=
, 2, &other_port), -1);
+    assert_int_equal(oob_addr_list_find(list, 2, &=
other_host), -1);
+    assert_int_equal(oob_addr_list_find(list, 0, &same),=
 -1);
+}
+
 /* A PROBE_REPLY carrying a probe_reply is found by the client =
scan, with all
  * fields surviving=2E */
 static void
@@ -896,6 +970,9 @@
=
         cmocka_unit_test(test_server_probe_accept_valid),
         cmocka_=
unit_test(test_server_probe_accept_stale),
         cmocka_unit_test(test_s=
erver_probe_accept_no_parameter),
+        cmocka_unit_test(test_probe_repl=
y_credits_every_entry_at_address),
+        cmocka_unit_test(test_probe_rep=
ly_matches_only_its_address),
+        cmocka_unit_test(test_addr_list_find=
),
         cmocka_unit_test(test_client_reply_read_finds_reply),
         =
cmocka_unit_test(test_client_reply_read_skips_unknown),
         cmocka_uni=
t_test(test_client_reply_read_rejects_unknown_mandatory),

-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cd=
e3c06f2
Gerrit-Change-Number: 1747
Gerrit-PatchSet: 23
Gerrit-Owner: stipa =
<lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2E=
com>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--WkFTO3IKQ0M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #23</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review+1 by ralf=
_lici, Code-Review-1 by plaisthos</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">oob: Add --server-probe =
to order client remotes by probe<br><br>With --server-probe [max-latency-di=
ff], before connecting a client sends<br>an out-of-band SERVER_PROBE to all=
 configured UDP remotes, collects the<br>PROBE_REPLYs for one second, and r=
eorders the connection list so<br>the best-responding server is tried first=
=2E Unanswered probes are resent<br>once within that window to ride out pac=
ket loss=2E The option is off by<br>default; its optional argument override=
s the margin the server<br>advertises=2E<br><br>The probe phase is self-con=
tained in oob_client=2Ec behind a single call<br>from init=2Ec (before next=
_connection_entry())=2E It opens one UDP socket<br>per address family in us=
e through create_socket_udp_configured(), so a<br>probe socket is set up an=
d bound like the connection socket it may later<br>become (--local, --lport=
, --bind-dev, --mark), fans probes out and<br>collects replies on them, mat=
ches each reply to its remote by source<br>address, and rejects spoofed rep=
lies via the session id the server<br>echoes back=2E An address several ent=
ries resolve to is probed once and<br>its reply credited to each of them=2E=
 Remotes resolve with their own<br>udp4/udp6 family=2E The first remote tha=
t can be probed provides the<br>socket settings; probing is declined when a=
nother probed remote binds<br>differently, since one socket set cannot repr=
esent both=2E TCP remotes and<br>remotes behind a SOCKS proxy are not probe=
d, and an address family whose<br>socket cannot be created is skipped rathe=
r than fatal=2E When both<br>families are bound, the IPv6 probe socket is v=
6-only so the two do not<br>collide on the port=2E The reply matching and t=
he per-round address list<br>are oob_probe_next_target_at() and oob_addr_li=
st_find() in oob=2Ec, on<br>the public struct oob_probe_target, with unit t=
ests=2E Ranking and<br>reordering use oob_rank_probe_results()=2E<br><br>Fo=
r now the probe is sent unwrapped, so it only works against a server<br>wit=
hout tls-auth/tls-crypt (wrapping is a follow-up); only UDP remotes<br>are =
probed; and probing runs once, before the first connection=2E<br><br>Change=
-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2<br>Signed-off-by: Lev Stipak=
ov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sect=
ions/client-options=2Erst<br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/i=
nit=2Ec<br>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>A src/openvpn/=
oob_client=2Ec<br>A src/openvpn/oob_client=2Eh<br>M src/openvpn/options=2Ec=
<br>M src/openvpn/options=2Eh<br>M src/openvpn/socket=2Ec<br>M src/openvpn/=
socket=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<br>13 files changed, =
925 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/1747/23</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index fbc69f0=
=2E=2Eb87f1ef 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span=
>+++ b/CMakeLists=2Etxt</span><br><span>@@ -527,6 +527,8 @@</span><br><span=
>     src/openvpn/occ=2Eh</span><br><span>     src/openvpn/oob=2Ec</span><b=
r><span>     src/openvpn/oob=2Eh</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    src/openvpn/oob_client=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    src/openvpn/oob_client=2Eh</span><br><span>    =
 src/openvpn/openvpn=2Ec</span><br><span>     src/openvpn/openvpn=2Eh</span=
><br><span>     src/openvpn/openvpn_win32_resources=2Erc</span><br><span>di=
ff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-=
options=2Erst</span><br><span>index 87c138a=2E=2Ed07f8de 100644</span><br><=
span>--- a/doc/man-sections/client-options=2Erst</span><br><span>+++ b/doc/=
man-sections/client-options=2Erst</span><br><span>@@ -595,6 +595,46 @@</spa=
n><br><span>   seconds for a response before trying the next server=2E The =
default value</span><br><span>   is :code:`120`=2E This timeout includes pr=
oxy and TCP connect timeouts=2E</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+--server-probe args</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  Before the first connection attempt, probe =
all configured UDP remotes</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  out-of-band and reorder the connection list based on the replies=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Valid syntaxes::</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     server-probe</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     server-probe max-latency-diff</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  A small probe message is sent to the first resolved addres=
s of every UDP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  rem=
ote, and each answering server replies with its advertised priority</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  and weight=2E Remotes are=
 then reordered following DNS SRV (RFC 2782)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  semantics: servers that answered are tried befor=
e those that did not,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  grouped by priority (lowest first); within a priority group, servers ar=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  picked by weight=
ed-random selection=2E Round-trip time is not yet taken</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  into account, so ``max-latency-diff``=
 has no effect for now=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The probe i=
s currently sent without control-channel wrapping, so it only</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  works against a server configur=
ed without ``--tls-auth``,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  ``--tls-crypt`` or ``--tls-crypt-v2``=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  Only UDP remotes are probed, and only when there are at least =
two</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  remotes; remot=
es reached through a SOCKS proxy are not probed=2E The</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  probes are sent from one socket per ad=
dress family, set up like the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  connection socket of the first remote that can be probed; all p=
robed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  remotes must=
 therefore share its local bind settings (``--local``,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  ``--lport``, ``--bind``), otherwise pr=
obing is skipped and the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  configured order is used=2E Remotes that answered are tried first, i=
n the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  order descri=
bed above; all other remotes, including TCP ones, follow in</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  their configured order=2E Probing=
 runs once per process, before the first</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  connection attempt; a reconnect or a SIGUSR1 restart=
 does not probe again=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Probing dela=
ys the first connection attempt by up to one second, plus</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  the time needed to resolve each rem=
ote=2E A server only answers a probe</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  whose timestamp is within its ``--hand-window`` of its o=
wn clock, so a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  cli=
ent whose clock is badly wrong receives no replies and keeps the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  configured order=2E Ordering=
 by probe replaces any order that</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  ``--remote-random`` produced=2E See ``--server-probe-reply`=
` for the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  server s=
ide=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> --static-challenge args</span><br><span>   Enable static challenge/res=
ponse protocol</span><br><span> </span><br><span>diff --git a/src/openvpn/M=
akefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 5e6b4d9=2E=
=2Ef8a5835 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br=
><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -109,6 +109,7 @@<=
/span><br><span> 	pkcs11_openssl=2Ec \</span><br><span> 	pkcs11_mbedtls=2Ec=
 \</span><br><span> 	oob=2Ec oob=2Eh \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	oob_client=2Ec oob_client=2Eh \</span><br><span> 	openv=
pn=2Ec openvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \</span><br>=
<span> 	options_show=2Ec options_show=2Eh \</span><br><span>diff --git a/sr=
c/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 453ee7e=2E=
=2E529c5a3 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><spa=
n>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -48,6 +48,7 @@</span><br><s=
pan> #include &quot;ssl_ncp=2Eh&quot;</span><br><span> #include &quot;tls_c=
rypt=2Eh&quot;</span><br><span> #include &quot;forward=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob_client=2Eh&=
quot;</span><br><span> #include &quot;auth_token=2Eh&quot;</span><br><span>=
 #include &quot;mss=2Eh&quot;</span><br><span> #include &quot;mudp=2Eh&quot=
;</span><br><span>@@ -4446,6 +4447,10 @@</span><br><span>         }</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* Probe configured remotes and reorder them best-first (=
--server-probe);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * no-op otherwise=2E Must run before next_connection_entry() picks a remo=
te=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    client_=
probe_and_order_remotes(c);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     /* Resets all values to the initial values fr=
om the config where needed */</span><br><span>     pre_connect_restore(&amp=
;c-&gt;options, &amp;c-&gt;c2=2Egc);</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>index c0=
c8955=2E=2E20b3a4f 100644</span><br><span>--- a/src/openvpn/oob=2Ec</span><=
br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -148,6 +148,33 @@</sp=
an><br><span>     return oob_timestamp_in_window(param=2Etimestamp, now, wi=
ndow_secs);</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+oob_probe_next_target_at(const struct openvpn_sockaddr *from, =
const struct oob_probe_target *targets,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                         const struct oob_probe_result =
*results, int n, int start)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i=
nt i =3D start; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (targets[i]=2Esent &amp;&amp; !results[i]=2Eresponded &amp;&amp; ad=
dr_port_match(from, &amp;targets[i]=2Edest))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            return i;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+oob_addr_list_find(const struct openvpn_sockaddr *list, int n, co=
nst struct openvpn_sockaddr *addr)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (int i =3D 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (addr_port_match(&amp;list[i], addr))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return i;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Base =
ordering: responders before non-responders, then by priority (lower</span><=
br><span>  * first), then by RTT (lower first), then by original index for =
determinism=2E</span><br><span>  * This groups responders into priority run=
s pre-sorted by RTT, which the</span><br><span>diff --git a/src/openvpn/oob=
=2Eh b/src/openvpn/oob=2Eh</span><br><span>index e637b90=2E=2Ee0016ee 10064=
4</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openv=
pn/oob=2Eh</span><br><span>@@ -37,6 +37,7 @@</span><br><span> </span><br><s=
pan> #include &quot;buffer=2Eh&quot;</span><br><span> #include &quot;sessio=
n_id=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;socket_util=2Eh&quot;</span><br><span> </span><br><span> /* OOB m=
essage types: the 16-bit value at the start of an OOB payload, before</span=
><br><span>  * its TLV entries=2E Distinct from the TLV-type space (0x2xx);=
 see the &quot;Messages&quot;</span><br><span>@@ -189,6 +190,37 @@</span><b=
r><span>     struct oob_probe_reply reply; /* the values the server adverti=
sed */</span><br><span> };</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Where the client probed one connection entry=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct oob_probe=
_target</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr de=
st;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socklen_t de=
stlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool sent=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Find the next entry, from index \p start on, that was probed at \p =
from and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * has not =
answered yet=2E Several entries can resolve to the same address, so a</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reply is credited to e=
ach of them: call again with the returned index + 1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * until it returns -1=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param from     source address of the reply</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param targets  where =
each entry was probed</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param results  per-entry results; entries already marked responded ar=
e skipped</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
n        number of entries</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param start    first index to consider</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return the entry index, or -1 if none</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+int oob_probe_next_target_at(const stru=
ct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                             const struct oob_probe_target *targets,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
          const struct oob_probe_result *results, int n, int start);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Index of \p addr (address and port) in \p list, or -1 if i=
t is not there=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int oob_addr_list_=
find(const struct openvpn_sockaddr *list, int n,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                       const struct openvpn_so=
ckaddr *addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> /**</span><br><span>  * Order results best-first, in place, pe=
r the server-probe selection policy:</span><br><span>  *   - remotes that r=
esponded rank before those that did not (non-responders keep</span><br><spa=
n>diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</spa=
n><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E16217c7=
</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob_client=
=2Ec</span><br><span>@@ -0,0 +1,659 @@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP=
/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             session authentication and key exchang=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket encryption, packet authentication, and</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@o=
penvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is =
free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lic=
enses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;oob_client=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_pkt=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
session_id=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;socket=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;socket_util=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;otime=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;fdmisc=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;me=
mdbg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Total time we wait fo=
r probe replies before giving up and connecting=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_WINDOW_MS 1000</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Number of times an unanswered probe is resen=
t within the window, to ride out</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * UDP packet loss=2E With this set to 1, each remote is probe=
d up to 2 times,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
which removes the single-packet-loss false negative; further retries give</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sharply diminishin=
g returns for a low-stakes selection=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define OOB_PROBE_RETRIES 1</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* The probe uses one socket per address family, each set up an=
d bound like the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
connection socket, so every remote is probed on a socket of its own family =
and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the winning r=
emote&#39;s socket can be reused as its connection socket, presenting</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the same source IP+por=
t the server bound its handshake cookie to=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define PROBE_AF_V4    0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define PROBE_AF_V6    1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_AF_COUNT 2</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+struct probe_ctx</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    socket_descriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if that=
 AF is unavailable */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Addresses probed so far in the current send round: an address seve=
ral</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * entries r=
esolve to is probed once, and its reply is credited to each=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr *=
probed;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n_pr=
obed;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_=
ANDROID</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool fd_=
protected[PROBE_AF_COUNT]; /* VPNService protect(), once per socket */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* af is an int (not sa_family_t) so callers can pass addrinfo::ai_family=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * directly without=
 a narrowing conversion (-Werror=3Dconversion)=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+probe_af_index(int af)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Build a plaintext SERVER_PROBE packet:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *   [opcode | key_id=3D0] [client ses=
sion id] [SERVER_PROBE message]</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * This is the unauthenticated OOB wire format; adding tls-auth=
/tls-crypt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * wrappi=
ng for the probe is a follow-up (it only works against a server with</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * no control-channel wrap=
ping for now)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_prob=
e_build_packet(struct buffer *buf, const struct session_id *client_sid)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter para=
m =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Et=
imestamp =3D (uint64_t)now,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_write=
_u8(buf, header) &amp;&amp; session_id_write(client_sid, buf)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; oob_server_=
probe_write(buf, &amp;param);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* The local address and po=
rt ce&#39;s connection socket binds: its first --local,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * with --lport taking precedence in cl=
ient mode, as link_socket_init_phase1()</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * picks them for socket 0=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+oob_probe_bind_target(const struct connection_ent=
ry *ce, const struct options *o,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                      const char **host, const char **port)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    *host =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    *port =3D ce-&gt;local_port;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;local_list &=
amp;&amp; ce-&gt;local_list-&gt;len)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        *host =3D ce-&gt;local_list-&gt;array[0]-&gt;local;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        *port =3D ce-&gt;local_l=
ist-&gt;array[0]-&gt;port;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(o-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; ce-&gt;local_port_defined=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        *port =3D ce-&gt;local_p=
ort;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Equal strings, or both absent=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+str_equal_or_both_null(const char *a, const char *b)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return (!a &amp;&amp; !b) || (a &amp=
;&amp; b &amp;&amp; strcmp(a, b) =3D=3D 0);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Can this e=
ntry be probed at all? Only a direct UDP remote can answer and</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * hand its socket to the connec=
tion=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_eligibl=
e(const struct connection_entry *ce)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* CE_DISABLED entries are skipped by next_connection_entry(), so probin=
g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * them would =
rank a remote we are never going to use=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return ce-&gt;remote &amp;&amp; proto_is_udp(=
ce-&gt;proto) &amp;&amp; !ce-&gt;socks_proxy_server</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; !(ce-&gt;flags &amp=
; CE_DISABLED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Do a and b bind their connection socke=
t the same way (--bind/--nobind,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * --local, --lport, --bind ipv6only)? One probe socket set se=
rves all probed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * r=
emotes, so each must agree with the first of them, whose socket is adopted=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_same_bind(c=
onst struct connection_entry *a, const struct connection_entry *b,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    const st=
ruct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (a-&gt;bind_lo=
cal !=3D b-&gt;bind_local)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!a-&gt;bind=
_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *host_a, *port_a, *host_=
b, *port_b;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_=
probe_bind_target(a, o, &amp;host_a, &amp;port_a);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    oob_probe_bind_target(b, o, &amp;host_b,=
 &amp;port_b);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn a-&gt;bind_ipv6_only =3D=3D b-&gt;bind_ipv6_only &amp;&amp; str_equal=
_or_both_null(host_a, host_b)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+           &amp;&amp; str_equal_or_both_null(port_a, port_b);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Resolve the local bind address of ce&#39;s connection soc=
ket; NULL with --nobind=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Fatal on failure, like the link socket=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static struct addrinfo *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+oob_probe_bind_addrinfo(const struc=
t connection_entry *ce, const struct options *o)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!ce-&gt;bind_local)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *host, *port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    oob_probe_bind_target(ce, o, &amp;host, &amp;port);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct addrinfo *ai =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const unsigned int flags =3D GETADDR_=
RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                               | GETADDR_PASSI=
VE | GETADDR_DATAGRAM;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    openvpn_getaddrinfo(flags, host, port, 0, NULL, AF_UNSPEC, &amp;ai);=
 /* fatal on failure */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return ai;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Does the address list hold an entry=
 of family af? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+addrinfo_h=
as_family(const struct addrinfo *ai, int af)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (; ai; ai =3D ai-&gt;ai_next)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (ai-&gt;ai_family =3D=3D af)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            return true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Open the probe socket of each addr=
ess family in use, set up and bound exactly</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * as the connection socket (create_socket_udp_conf=
igured()), so the winner&#39;s</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * socket can become that connection socket unchanged=2E A famil=
y with no --local</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 address to bind is left SOCKET_UNDEFINED and its remotes are not probed, a=
s the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * connection =
could not reach them either=2E Returns the number of sockets opened=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_sockets_open(struct =
probe_ctx *pc, const bool need[PROBE_AF_COUNT],</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                       struct addrinfo *bind_lo=
cal, const struct connection_entry *ce,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                       const struct options *o)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    static const int families[PROBE_AF_COUNT]=
 =3D { AF_INET, AF_INET6 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const struct socket_buffer_size sbs =3D { =2Ercvbuf =3D o-&gt;r=
cvbuf, =2Esndbuf =3D o-&gt;sndbuf };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int opened =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (int i =3D 0; i &lt; PROBE_AF_COUNT; i++)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (!need[i])</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            continue;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (bind_local &amp;&amp; !addrinfo_has_family(bind_local, families=
[i]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &=
quot;server-probe: no %s address to bind, not probing %s remotes&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                addr_fa=
mily_name(families[i]), addr_family_name(families[i]));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* Both probe sockets bind the same por=
t, and a dual-stack IPv6 wildcard</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * collides with the IPv4 one; the connection socket =
never has this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    * problem as it binds one family only=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        const bool v6only =3D ce-&gt;bind_ipv6_=
only</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
             || (bind_local &amp;&amp; families[i] =3D=3D AF_INET6</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
    &amp;&amp; pc-&gt;sd[PROBE_AF_V4] !=3D SOCKET_UNDEFINED);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        pc-&gt;sd[i] =3D create_s=
ocket_udp_configured((sa_family_t)families[i], o-&gt;sockflags, &amp;sbs,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                            o-&gt;mark, o-&gt;bind_dev, bind_local, v6only,=
 true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
pc-&gt;sd[i] =3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(D_LOW, &quot;server-probe: no usable %s socket, not=
 probing %s remotes&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                addr_family_name(families[i]), addr_family_name(fami=
lies[i]));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opened++;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return opened;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_=
probe_sockets_close(struct probe_ctx *pc)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (int i =3D 0; i &lt; PROBE_AF_COUNT; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (pc-&gt;sd[i] !=3D SOCKET_UNDEFINED)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            openvpn_close_socket(pc-&=
gt;sd[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   pc-&gt;sd[i] =3D SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Parse one received datagram as a PROBE=
_REPLY and, if valid and matching one</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * of the probes we sent, record the reply in results=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_handle_reply(co=
nst uint8_t *data, int len, const struct session_id *client_sid,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                       const s=
truct openvpn_sockaddr *from, const struct oob_probe_target *targets,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                       st=
ruct oob_probe_result *results, int n)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Need at least the opcode byte and the session id=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 1 + (int)SID_SI=
ZE || (data[0] &gt;&gt; P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct buffer buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
uf_set_read(&amp;buf, data, (size_t)len);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    buf_advance(&amp;buf, 1 + SID_SIZE); /* skip opco=
de + server session id */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oo=
b_probe_reply reply;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!oob_client_reply_read(&amp;buf, &amp;reply))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Reject sp=
oofed replies: the reply must echo our probe&#39;s session id=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!session_id_equal(&=
amp;reply=2Epeer_session_id, client_sid))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Credit the reply to ev=
ery still-unanswered remote probed at its source</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * address: several entries can resolve to=
 the same address, and each takes</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * the first reply for it=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int i =3D oob_probe_next_target_at(from, =
targets, results, n, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    while (i &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   results[i]=2Eresponded =3D true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        results[i]=2Ereply =3D reply;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        i =3D oob_probe_next_target_at(from, targets, result=
s, n, i + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Count how many of the probes we sent have been answere=
d so far=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_count_answ=
ered(const struct oob_probe_target *targets, const struct oob_probe_result =
*results,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
         int n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int answered =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D=
 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        answere=
d +=3D (targets[i]=2Esent &amp;&amp; results[i]=2Eresponded) ? 1 : 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return answered;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* Receive replies for one time slice (until deadline), recording each that=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * matches a probe =
we sent=2E Returns true if every sent probe has been answered=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+oob_probe_receive_slice(const struc=
t probe_ctx *pc, const struct timeval *deadline,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        const struct session_i=
d *client_sid, const struct oob_probe_target *targets,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        struct oob_probe=
_result *results, int n, int outstanding)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    while (true)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struc=
t timeval tnow, timeout;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        openvpn_gettimeofday(&amp;tnow, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        timeout=2Etv_sec =3D deadline-&gt=
;tv_sec - tnow=2Etv_sec;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        timeout=2Etv_usec =3D deadline-&gt;tv_usec - tnow=2Etv_usec;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (timeout=
=2Etv_usec &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 timeout=2Etv_sec -=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            timeout=2Etv_usec +=3D 1000000;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (timeout=2Etv_sec &lt; 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return false; /* slice elapsed */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        fd_set readfds;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        FD_ZERO(&amp;readfds);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        socket_descriptor_t maxsd =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (=
int i =3D 0; i &lt; PROBE_AF_COUNT; i++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (pc-&gt;sd[i] !=3D SOCKET_UNDEFINED)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                openvpn_fd_set(pc-&gt;=
sd[i], &amp;readfds);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                if (pc-&gt;sd[i] &gt; maxsd)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    maxsd =3D pc-&gt;sd[i];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (openvpn_select(maxsd + 1, &amp;r=
eadfds, NULL, NULL, &amp;timeout) &lt;=3D 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            return false; /* slice timed out, or error */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; PROBE_AF_COUNT; i+=
+)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (pc-&gt;sd[i=
] =3D=3D SOCKET_UNDEFINED || !FD_ISSET(pc-&gt;sd[i], &amp;readfds))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                continue;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            uint8_t data[256];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct ope=
nvpn_sockaddr from;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            socklen_t fromlen =3D sizeof(from);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            int len =3D (int)recvfrom(pc-&gt;sd=
[i], (char *)data, (int)sizeof(data), 0,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                    (struct sockaddr *=
)&amp;from, &amp;fromlen);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (len &gt; 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                oob_probe_handle_reply(data, len, client_sid, &amp=
;from, targets, results, n);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (oob_count_answered(targets, results, n) &gt;=3D outstanding)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            return true; /* every probe=
 we sent has been answered */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Resend the probe to every remote that we probed =
but that has not answered=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+oob_probe_resend_unanswered(struct probe_ctx *pc, const struct buffer *=
probe,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
               const struct oob_probe_target *targets,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                            const struct=
 oob_probe_result *results, int n)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 pc-&gt;n_probed =3D 0; /* a new round: probe each unanswered address once =
again */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (in=
t i =3D 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!targets[i]=2Esent || results[i]=2Eresponded</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            || oob_addr_list_find(pc-&gt;probe=
d, pc-&gt;n_probed, &amp;targets[i]=2Edest) &gt;=3D 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        socket_descriptor_t sd =3D pc-&gt;sd[probe_af_inde=
x(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (sd !=3D SOCKET_UNDEFINED</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; sendto(s=
d, (const char *)CBPTR(probe), (int)BLEN(probe), 0,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                      (const struct socka=
ddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   &gt;=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            pc-&gt;probed[pc-&gt;n_probed=
++] =3D targets[i]=2Edest;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* Collect replies over the probe window, resending un=
answered probes up to</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * OOB_PROBE_RETRIES times (UDP is lossy and a probe carries no retransmi=
ssion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * of its own)=
=2E The window is split into equal slices, one per send round; after</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * each slice but the last=
 we resend to whoever has not answered yet=2E Returns</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * once the window elapses or every sent =
probe has been answered=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+oob_probe_collect(struct probe_ctx *pc, const struct buffer *probe,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                  const s=
truct session_id *client_sid, const struct oob_probe_target *targets,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                  struct =
oob_probe_result *results, int n,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                  const struct signal_info *sig)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* number of probes we actually sent: stop ear=
ly once they all answer */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int want =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (int i =3D 0; i &lt; n; i++)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        want +=3D targets[i]=2Esent ? 1 : 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const int slices =3D 1 + OOB_PROBE_RETRIES;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const long slice_ms =3D OOB_PROBE_WINDOW_=
MS / slices;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int slice =3D 0; =
slice &lt; slices; slice++)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  struct timeval deadline;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        openvpn_gettimeofday(&amp;deadline, NULL);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        deadline=2Etv_sec +=3D slice_=
ms / 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d=
eadline=2Etv_usec +=3D (slice_ms % 1000) * 1000;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (deadline=2Etv_usec &gt;=3D 1000000=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            deadline=2Etv_se=
c +=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  deadline=2Etv_usec -=3D 1000000;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (oo=
b_probe_receive_slice(pc, &amp;deadline, client_sid, targets, results, n, w=
ant)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            || =
sig-&gt;signal_received)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       return; /* all answered, or we are being told to stop */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (slice + 1 &lt; slices)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            oob_probe_resend_unanswered(pc, probe, targ=
ets, results, n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Permute the connection list so entries appear in ranked orde=
r=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_apply_order(stru=
ct connection_list *l, const struct oob_probe_result *ranked,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                struct gc_arena *=
gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct connection_entry **reor=
dered =3D gc_malloc(sizeof(*reordered) * l-&gt;len, false, gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-=
&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        reordered[i]=
 =3D l-&gt;array[ranked[i]=2Eindex];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    memcpy(l-&gt;array, reordered, sizeof(*l-&gt;array) * l-&gt;len);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+client_probe_and_order_remotes(struct context *c)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* Probe only once, before the first connection attempt=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;o=
ptions=2Eserver_probe || !c-&gt;first_time)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct connection_list =
*l =3D c-&gt;options=2Econnection_list;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!l || l-&gt;len &lt;=3D 1)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return; /* nothing to choose between */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* A single random session id identifies all of our prob=
es; servers echo it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * back in the reply&#39;s peer_session_id, letting us reject spoofed r=
eplies=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct session_id client_sid;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    session_id_random(&amp;client_sid);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* The probe sockets are set up like the connection socket of t=
he first</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * remo=
te we can probe, whose socket the winner adopts; probing cannot serve</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * remotes that bind =
differently=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const struct connection_entry *tmpl =3D NULL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const struct connection_entr=
y *ce =3D l-&gt;array[i];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (!oob_probe_eligible(ce))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            continue;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (!tmpl)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      tmpl =3D ce;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (!oob_probe_same_bind(tmpl, ce, &amp;c-&gt;options))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s b=
inds differently from %s:%s;&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                       &quot; not probing, using configured =
order&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         ce-&gt;remote, ce-&gt;remote_port, tmpl-&gt;remote, tmpl-&gt;remot=
e_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tmpl)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: no re=
mote can be probed; using configured order&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct probe_ctx pc =3D { =2Esd =3D { SOCKET_UNDEFINED, SOCKET_UNDEFIN=
ED } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct o=
ob_probe_target *targets =3D gc_malloc(sizeof(*targets) * l-&gt;len, true, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 oob_probe_result *results =3D gc_malloc(sizeof(*results) * l-&gt;len, true=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer probe =3D=
 alloc_buf_gc(256, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!oob_probe_build_packet(&amp;probe, &amp;client_sid))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe:=
 could not build probe packet; using configured order&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_sockets_close(&=
amp;pc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: probin=
g %d remote(s) with a %d ms window&quot;, l-&gt;len,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        OOB_PROBE_WINDOW_MS);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* Resolve every remote first, so only the add=
ress families actually in use</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * get a probe socket=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    bool need_af[PROBE_AF_COUNT] =3D { false, false }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D=
 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 results[i]=2Eindex =3D i;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        results[i]=2Eresponded =3D false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        const struct connection_entry *ce =3D l-&gt;array[i];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!oob_probe_=
eligible(ce))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (=
ce-&gt;remote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     msg(D_LOW, &quot;server-probe: %s:%s: skipping (not a direct UDP remot=
e)&quot;, ce-&gt;remote,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    ce-&gt;remote_port);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            continue;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* ce-&gt;af honours a udp4/udp6 remote, as the connection does */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        struct addrinfo *ai=
 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
nt status =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETA=
DDR_DATAGRAM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                   ce-&gt;remote, ce-&gt;remote_port, 0, NU=
LL, ce-&gt;af, &amp;ai);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (status !=3D 0 || !ai)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s: could not resolv=
e&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* Store the first resolved address natively (no IPv4-mapping); it is=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * later pr=
obed on its family&#39;s socket=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        memcpy(&amp;targets[i]=2Edest, ai-&gt;ai_addr, ai=
-&gt;ai_addrlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      targets[i]=2Edestlen =3D (socklen_t)ai-&gt;ai_addrlen;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        need_af[probe_af_index(ai-=
&gt;ai_family)] =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        freeaddrinfo(ai);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *=
bind_local =3D oob_probe_bind_addrinfo(tmpl, &amp;c-&gt;options);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (oob_probe_sockets_ope=
n(&amp;pc, need_af, bind_local, tmpl, &amp;c-&gt;options) =3D=3D 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: no=
thing to probe; using configured order&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (bind_local)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            freeaddrinfo(bind_local);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* Send a probe to each resolved remote, on the socket of its address fam=
ily=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * An add=
ress several entries resolve to is probed once; its reply is</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * credited to each of them=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc=2Eprobed =
=3D gc_malloc(sizeof(*pc=2Eprobed) * l-&gt;len, false, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    pc=2En_probed =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int sent_count =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len=
; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct connec=
tion_entry *ce =3D l-&gt;array[i];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!targets[i]=2Edestlen)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            continue;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        const int af =3D probe_af_index(targets[i]=2Edest=2Eadd=
r=2Esa=2Esa_family);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        socket_descriptor_t sd =3D pc=2Esd[af];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (sd =3D=3D SOCKET_UNDEFINED)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            continue; /* family not =
probed, see oob_probe_sockets_open() */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifdef TARGET_ANDROID</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* Keep the probe out of an active tunnel, as the conne=
ction socket is=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * protect_fd_nonlocal() declines a local peer, so only a non-local =
one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * actua=
lly protects the socket and may latch the flag=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!pc=2Efd_protected[af] &amp;&=
amp; !addr_local(&amp;targets[i]=2Edest=2Eaddr=2Esa))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            protect_fd_nonlocal(sd, &amp;targets[i]=
=2Edest=2Eaddr=2Esa);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            pc=2Efd_protected[af] =3D true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (oob_addr_list_find(pc=2Eprobed, pc=2En_probed, &amp;targets[=
i]=2Edest) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (sendto(sd, (const char *)BPTR(&amp;probe), (int)BLEN(&amp;probe), 0,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
  (struct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                &lt; 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_LOW, &qu=
ot;server-probe: %s:%s: probe send failed&quot;, ce-&gt;remote, ce-&gt;remo=
te_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  pc=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        targets[i]=2Esent =3D true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        sent_count++;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (sent_count &gt; 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        oob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, targets, =
results, l-&gt;len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                          c-&gt;sig);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    oob_probe_sockets_close(&amp;pc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (bind_local)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        freeaddrinfo(bind_local);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Log =
each remote&#39;s outcome while results[i] still maps to array[i]=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int responded =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D=
 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 const struct connection_entry *ce =3D l-&gt;array[i];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (results[i]=2Eresponded)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            responded++;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;=
server-probe: %s:%s answered (priority %d, weight %d)&quot;, ce-&gt;remote,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ce-=
&gt;remote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: %=
s:%s did not answer&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Rank best-first and reorder the connection list accordingly=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_re=
sults(results, l-&gt;len, c-&gt;options=2Eserver_probe_latency_margin, get_=
random, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  oob_apply_order(l, results, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    msg(D_LOW, &quot;server-probe: connecting in this order:&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &=
lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_=
LOW, &quot;server-probe:   %d=2E %s:%s&quot;, i + 1, l-&gt;array[i]-&gt;rem=
ote,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            l-&=
gt;array[i]-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO, &quot;s=
erver-probe: %d of %d probed remote(s) answered; connecting best-first&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        responded=
, sent_count);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff=
 --git a/src/openvpn/oob_client=2Eh b/src/openvpn/oob_client=2Eh</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2Eac44cdb</span=
><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob_client=2Eh</=
span><br><span>@@ -0,0 +1,44 @@</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  O=
penVPN -- An application to securely tunnel IP networks</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP po=
rt, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             session authentication and key exchange,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet en=
cryption, packet authentication, and</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public=
 License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  as published by the Free Software Foundation=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Client-side server-probe phase: before connecting, optionally probe all<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * configured remote=
s with an out-of-band SERVER_PROBE and order them</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * best-first, so the connection loop tries t=
he most suitable server first=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OOB_CLIENT_H</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_CLIENT_H<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+struct context;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Probe all configured remotes and reorder the connection list best-first=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Does nothing unless --server-p=
robe is enabled=2E On any failure (or if no</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * server answers), the configured remote order is =
left unchanged and the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * normal connection sequence proceeds=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void client_probe_and_order_remotes(struct context *c);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif /* OOB_CLIENT_H */</span><br><span>diff --=
git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>ind=
ex e3cd527=2E=2E35ef2af 100644</span><br><span>--- a/src/openvpn/options=2E=
c</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -150,6 +=
150,9 @@</span><br><span>     &quot;                      udp6, tcp6-server=
, tcp6-client\n&quot;</span><br><span>     &quot;--proto-force p : only con=
sider protocol p in list of connection profiles=2E\n&quot;</span><br><span>=
     &quot;                  p =3D udp or tcp\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;--server-probe [n] : For client=
, probe all UDP remotes before connecting and\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;                  try them best=
-first; n overrides the latency margin (ms)\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;                  the server ad=
vertises=2E\n&quot;</span><br><span>     &quot;--connect-retry n [m] : For =
client, number of seconds to wait between\n&quot;</span><br><span>     &quo=
t;                  connection retries (default=3D%d)=2E On repeated retrie=
s\n&quot;</span><br><span>     &quot;                  the wait time is exp=
onentially increased to a maximum of m\n&quot;</span><br><span>@@ -809,6 +8=
12,11 @@</span><br><span>     o-&gt;topology =3D TOP_UNDEF;</span><br><span=
>     o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt;ce=2Eaf =
=3D AF_UNSPEC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The client latenc=
y margin is -1 =3D &quot;not set&quot;: the client&#39;s value is</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * authoritative when giv=
en, otherwise each server&#39;s advertised margin (or</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * the built-in default) applies=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_p=
robe_latency_margin =3D -1;</span><br><span>     o-&gt;ce=2Ebind_ipv6_only =
=3D false;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds =3D 1;</sp=
an><br><span>     o-&gt;ce=2Econnect_retry_seconds_max =3D 300;</span><br><=
span>@@ -5082,6 +5090,21 @@</span><br><span>         VERIFY_PERMISSION(OPT_=
P_GENERAL);</span><br><span>         options-&gt;mtu_test =3D true;</span><=
br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (streq(p[0], &quot;server-probe&quot;) &amp;&amp; !p[2])</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;se=
rver_probe =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (p[1])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 int margin =3D positive_atoi(p[1], msglevel);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (margin &gt; 0xffff)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--=
server-probe: max-latency-diff must be 0 to 65535 ms&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                goto err;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;server_pro=
be_latency_margin =3D margin;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span>     else if (streq(p[0], &quot;nice&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VE=
RIFY_PERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/openvpn/optio=
ns=2Eh b/src/openvpn/options=2Eh</span><br><span>index f472676=2E=2Ec2cde60=
 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b=
/src/openvpn/options=2Eh</span><br><span>@@ -337,6 +337,11 @@</span><br><sp=
an> </span><br><span>     bool mtu_test;</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    bool server_probe; /* client: pr=
obe remotes (--server-probe) and connect best-first */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* client: default candidate-band ma=
rgin in ms (--server-probe [max-latency-diff]):</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * servers within this RTT of the fastest a=
re treated as equally fast */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int server_probe_latency_margin;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>     bool mlock;</span><br><spa=
n> </span><br><span>     int keepalive_ping; /* a proxy for ping/ping-resta=
rt */</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/soc=
ket=2Ec</span><br><span>index 4c0aab5=2E=2Ee7acabc 100644</span><br><span>-=
-- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</s=
pan><br><span>@@ -733,7 +733,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> #ifdef TARGET_ANDROID</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span> protect_fd_nonlocal(int fd, const struct sockadd=
r *addr)</span><br><span> {</span><br><span>     if (!management)</span><br=
><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><=
br><span>index 4db3f3b=2E=2Ef60b031 100644</span><br><span>--- a/src/openvp=
n/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@=
@ -408,6 +408,15 @@</span><br><span> </span><br><span> socket_descriptor_t =
create_socket_tcp(struct addrinfo *);</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_ANDROID</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Hand \p fd to the VPNService API as a protected so=
cket, so its traffic is not</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * routed back into a tunnel=2E \p addr is the intended peer; a loc=
al one is left</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * un=
protected=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void protect_fd_nonloca=
l(int fd, const struct sockaddr *addr);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> /**</span><br><span>  * Create a UDP socket for \p=
 af set up the way a link socket is: --sndbuf/--rcvbuf,</span><br><span>  *=
 --mark, --bind-dev and, when \p bind_addr is given, the local bind (IPV6_V=
6ONLY</span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/=
tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index 0b0ce96=2E=2E56=
b5018 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</s=
pan><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@=
@ -508,6 +508,80 @@</span><br><span>     gc_free(&amp;gc);</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static struct openvpn_sockaddr</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+v4_addr(uint32_t addr, uint16_t port)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct openvpn_sockaddr sa =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sa=2Eaddr=2Ein4=2Esin_family =3D AF_I=
NET;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sa=2Eaddr=
=2Ein4=2Esin_addr=2Es_addr =3D htonl(addr);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    sa=2Eaddr=2Ein4=2Esin_port =3D htons(port);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sa;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static struct oob_probe_target</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+probe_target(struct openvpn_sockaddr dest, bool sent)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return (struct oob_probe_target){ =
=2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ein4), =2Esent =3D sen=
t };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* Two entries resolve to the same address=2E The fi=
rst reply from it is</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * credited to both entries; a second reply is ignored=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_credits_every_entry_at_a=
ddress(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvp=
n_sockaddr a =3D v4_addr(0x7f000001, 1194);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct oob_probe_target targets[2] =3D { probe_=
target(a, true), probe_target(a, true) };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct oob_probe_result results[2] =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int i =3D oob_probe_next_target_at(&a=
mp;a, targets, results, 2, 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(i, 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    results[i]=2Eresponded =3D true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    i =3D oob_probe_next_target_at(&amp=
;a, targets, results, 2, i + 1);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(i, 1);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    results[i]=2Eresponded =3D true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_t=
arget_at(&amp;a, targets, results, 2, i + 1), -1);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* the server&#39;s second reply finds nothing left to cred=
it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(oob_probe_next_target_at(&amp;a, targets, results, 2, 0), -1);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* A reply only matches entries probed at its address, and o=
nly those actually</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* sent; a different port is a different address=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_probe_reply_matches_only_its_address(void **=
state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr a =
=3D v4_addr(0x7f000001, 1194);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sock=
addr a_other_port =3D v4_addr(0x7f000001, 1195);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct oob_probe_target targets[3] =3D {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        probe_target(=
a, true),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pr=
obe_target(b, true),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        probe_target(a, false), /* resolved but never sent */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct oob_probe_result results[3] =3D { =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_nex=
t_target_at(&amp;b, targets, results, 3, 0), 1);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(=
&amp;b, targets, results, 3, 2), -1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(&amp;a, tar=
gets, results, 3, 0), 0);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(oob_probe_next_target_at(&amp;a, targets, result=
s, 3, 1), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(oob_probe_next_target_at(&amp;a_other_port, targets, result=
s, 3, 0), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* The per-round list of probed addresses=
 compares address and port=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+test_addr_list_find(void **state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct openvpn_sockaddr list[2] =3D { v4_addr(0x7f000001, 1194), v4_ad=
dr(0x7f000002, 1194) };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct openvpn_sockaddr same =3D v4_addr(0x7f000002, 1194);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr=
 other_port =3D v4_addr(0x7f000002, 1195);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct openvpn_sockaddr other_host =3D v4_addr(0=
x7f000003, 1194);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
oob_addr_list_find(list, 2, &amp;same), 1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(oob_addr_list_find(list, 2, &a=
mp;other_port), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(oob_addr_list_find(list, 2, &amp;other_host), -1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(o=
ob_addr_list_find(list, 0, &amp;same), -1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /* A PROBE_REPLY carrying a probe_reply is found by=
 the client scan, with all</span><br><span>  * fields surviving=2E */</span=
><br><span> static void</span><br><span>@@ -896,6 +970,9 @@</span><br><span=
>         cmocka_unit_test(test_server_probe_accept_valid),</span><br><span=
>         cmocka_unit_test(test_server_probe_accept_stale),</span><br><span=
>         cmocka_unit_test(test_server_probe_accept_no_parameter),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(tes=
t_probe_reply_credits_every_entry_at_address),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_matche=
s_only_its_address),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(test_addr_list_find),</span><br><span>         cm=
ocka_unit_test(test_client_reply_read_finds_reply),</span><br><span>       =
  cmocka_unit_test(test_client_reply_read_skips_unknown),</span><br><span> =
        cmocka_unit_test(test_client_reply_read_rejects_unknown_mandatory),=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">change 1747</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5a7e9e13b9f9548b=
7ff717daae2b4a9cde3c06f2 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 23 </div>=

<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body=
></html>
--WkFTO3IKQ0M=--


--===============8577224034654491334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8577224034654491334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8577224034654491334==--

