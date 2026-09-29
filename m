Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57296CA5FA1
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JHjQDw/xFegi/pmm0mm509aNi6viYPmTd3LxAkoT2IU=; b=Bw2J4TLr3kbhpGZWPquHjBouQn
	jurniEUlKkr8pbho5rSG8ZcQTZMAmRp56SApQNzYA7EZpzGJ2WZXNmVJj3D0Ltg3b/jP4+Ds0tNYU
	1pOZzQli8yr+NCMy44EaTphNeYwjnSka6XFC7RWyHGC/cMAS314wllCbwP6zf6bGYokA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhX-0005Sf-1v;
	Tue, 29 Sep 2026 13:16:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXhV-0005SZ-L0
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:16:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=E1j/vZFOOmWTYM+LVEQ2KRqH8gB4v0pu6nBlQR1KFn8=; b=KQAaBsLnMxOuzSn7F00HxW0zXF
 3Y0a2rJMfBDr+gYLDmBFIbZn5C8yyBEbOPhT6+84wNuNscBM+zLhgf0s+SKaSs+JsmLsGHPxOGws1
 W9KZau4KneO0NUq9DwvGlsZMp9c+FprGGjl1mch0npKKGjyZtlgjtJGWHbqMV/iTfNxI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=E1j/vZFOOmWTYM+LVEQ2KRqH8gB4v0pu6nBlQR1KFn8=; b=P
 vTOuBUemQVC+45NxQfoB2Osg9zdFPnFZ5qejHrgGzR5WQLXoRk7jT2IH+PGMFRyYLU/yZX9KspOiy
 y49rqQGFl9zUhb6MWTq7S08vZwnO54RwPxqUFW6j1xJ5UjECBHbD3+fylbF2IwQshhC4+iuGHub0K
 hX89ioHvE4AfbKmo=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXhQ-0001FO-QP for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:16:54 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffed768deso5952565e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687802; x=1791292602; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E1j/vZFOOmWTYM+LVEQ2KRqH8gB4v0pu6nBlQR1KFn8=;
 b=YPXXk2qJYSrHF4pFzLYXQ26Z/g5Bf+CpPSlaiKQMPk67RU6hv7GyoVf6/zacqSnRJn
 2BYaMrLqqcBjpvvutu37XGYQZlY8WQqIrZgG7oXqenQWIk/joBnl9wFriZKH9NzuQPNh
 YxDIGS/Us8Qw+hWvfB+9GhO2+65dqXvAb1a7a6B5cdVU/mokgkaZjAlZhQZhWzuMzOGz
 fkDQ64ttsWJOrQlxFYPcQJj3rIw15lICLA4DZGK16sILTj1Qv0vd9BygDJp/ya1ir/GQ
 jcvq7VAg99bur06zax6XgDZPTZS5ncpcd9YEkzlhzzB0LM+eWj8J1rqgKUAo8Y8WwPKQ
 tl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687802; x=1791292602;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=E1j/vZFOOmWTYM+LVEQ2KRqH8gB4v0pu6nBlQR1KFn8=;
 b=zefLeF4F1u8JX70hO/9xsG4d5EhZ0rQuRzuVfN/3uPsJ56gAEMOh/feUlRbLDmI6Gy
 XPo4ZYsttLb42/BGy+tfq3EwbdjaeYT1tUkA4idAigaNIcbkq3gTa1QQpF3PXAHzH7Zj
 UT1C87WoTLITdddumduP9yXt1xEHbzataxD4yvFA/sYuD7w9RafE0zmVzNhTYKaAaStB
 e1OD9iVfnpjvHRYqCku4RooB0mwMk6kOwtPsDF5sJZNeQ1X99IcmDiK75a97+Z2LQ0mL
 PAGRtXjT43rp5h4qt4sQzg91GSm67xExMZFU8GrlVx6CjkKYauM1lIgjt8NGz2Aa/Oiy
 qK0A==
X-Gm-Message-State: AFuF++kdz+PgjmMar9mOWQxC/qmWyoDJ7Z3nO3ReKR1aSnnhOXz18VsD
 LDOYPjwvsaOjRA+5Z88LZFul6znoYjWgZZpn2Y8yWpC9qHlRKmfmNmaoyjmR+zXk2vESdtO9oyO
 Mk8tlY3Syd+VHWcAD6LOI4Q94dneKjym8AV+VzqT6QxfpEUpUmB0kCBlMbrzU8m7bg3XchsdMgK
 BV2fC06Q==
X-Gm-Gg: AYBFou3kxKKUJws9f7951qpvP7jXnfqkHS1oaaIDUTBvyTQzie2Kwt2LjCwVaUdjPKM
 ndRDDzFmNMxmkMugkI/bdYE2WbT3aYsqu3hpXUNRmhOEBeGwXtYifW0Dkd6dzg3oV2W/JFV9eK/
 oUyAVx5i4ENI5ZmYtg+Jo+9X6UN+3wbc12MEmgALr2mE8FjuKBP8QWhTt9TxHIs/+FESwRNpaEO
 dRsrb9fqjIDgNDpoqbQhKFipNZQXokb0/vfpc2j21mNCYMJFlVKkCxrFY7wTUKPgJjDcVKSl/hZ
 srpTgDHkoakRXmqVtIixYVMn4MmRryZs9HfWS5H1h1p+EDQxSLIdwcI/3fv1Rabvr/D5JqWFtJz
 9SIeLDAHM85j/xpgV19bM+k89kaDLMCPwnsUVzxnK+WRsqIn53mtNLFbR1ird+gy4/9LUxSR7sz
 Uu/b77VmuPHMjA8I/OBum6SJpyVrHJON7E6ioaVfe/fGclQN2PJPNVgLI0cDnruWuH+LbpuDaza
 pPP9GNqpVYDO07Zfu9FGhgUSfPLvWjvwz3HTfzalZp4RiC5py60ocrxbVxq0aWW2vlyTatDB8Iw
 2hLqRN7S2iL6UL9Fhi5P8YNDQoefyID6bdQ6BvY3vxU3YLnGX+rvOS1fIfJK
X-Received: by 2002:a05:600c:37c6:b0:49e:6865:904e with SMTP id
 5b1f17b1804b1-4a00d77037amr41135175e9.12.1790687800667; 
 Tue, 29 Sep 2026 06:16:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfab490sm85952235e9.12.2026.09.29.06.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:16:40 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 842942c1351f98633602bb39d6f0ad183ebcfe36
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f51201faa3346465983fad9e87506ff72f46a3c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXhQ-0001FO-QP
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7208642008286965424=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7208642008286965424==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ohdY7cysx+s="; charset=UTF-8

--ohdY7cysx+s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1741?usp=3Demail

to look at the new patch set (#18)=2E

The following app=
rovals got outdated and were removed:
Code-Review-1 by plaisthos


Change s=
ubject: oob: Add control message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add control messa=
ge TLV encoding (P_CONTROL_OOB_V1)

Out-of-band control messages carry cont=
rol data but belong to no
session, so a client can ask a server about itsel=
f before connecting=2E
Reserve opcode 12 for them and add the TLV codecs th=
e probe needs: the
probe request a SERVER_PROBE carries and the probe reply=
 a PROBE_REPLY
carries=2E

A message is just a sequence of TLVs, and the TL=
Vs it carries say what
it is=2E The probe request carries a request_id chos=
en by the client,
which the probe reply echoes=2E

The spec uses the same T=
LV framing for all its control messages, not
just the out-of-band ones, so =
the TLV header and the TLV scan go into
their own control_msg=2Ec/h; oob=2E=
c keeps the OOB TLV types=2E

The scan is strict: a truncated TLV header or=
 value, or an unknown TLV
not marked optional, rejects the whole message=2E=


P_LAST_OPCODE becomes 12=2E tls_pre_decrypt() rejects the OOB opcodes
exp=
licitly: they are not part of the reliable control channel (no
control mess=
age id, no ACK array); the server answers them
statelessly in a follow-up=
=2E

See "Out of band and control data messages" and "[OPCODE ID 12]
CONTRO=
L_OOB_V1" in the wire protocol specification
(openvpn-rfc, openvpn-wire-pro=
tocol=2Exml)=2E

Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Signe=
d-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M src/ope=
nvpn/Makefile=2Eam
A src/openvpn/control_msg=2Ec
A src/openvpn/control_msg=
=2Eh
A src/openvpn/oob=2Ec
A src/openvpn/oob=2Eh
M src/openvpn/ssl=2Ec
M sr=
c/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/=
Makefile=2Eam
A tests/unit_tests/openvpn/test_oob=2Ec
M tests/unit_tests/op=
envpn/test_pkt=2Ec
12 files changed, 803 insertions(+), 6 deletions(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1741/18=


diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 6eb5954=2E=2E72680=
b2 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -445,6 +445,8 @@=

     src/openvpn/console=2Ec
     src/openvpn/console_builtin=2Ec
     src=
/openvpn/console=2Eh
+    src/openvpn/control_msg=2Ec
+    src/openvpn/cont=
rol_msg=2Eh
     src/openvpn/crypto=2Ec
     src/openvpn/crypto=2Eh
     sr=
c/openvpn/crypto_backend=2Eh
@@ -523,6 +525,8 @@
     src/openvpn/multi_io=
=2Ec
     src/openvpn/occ=2Ec
     src/openvpn/occ=2Eh
+    src/openvpn/oob=
=2Ec
+    src/openvpn/oob=2Eh
     src/openvpn/openvpn=2Ec
     src/openvpn=
/openvpn=2Eh
     src/openvpn/openvpn_win32_resources=2Erc
@@ -883,6 +887,9=
 @@
 
     target_sources(test_pkt PRIVATE
         tests/unit_tests/openvp=
n/mock_win32_execve=2Ec
+        tests/unit_tests/openvpn/test_oob=2Ec
+   =
     src/openvpn/control_msg=2Ec
+        src/openvpn/oob=2Ec
         src/=
openvpn/argv=2Ec
         src/openvpn/base64=2Ec
         src/openvpn/crypt=
o_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=
=2Eam
index 7fd12b4=2E=2E5e6b4d9 100644
--- a/src/openvpn/Makefile=2Eam
+++=
 b/src/openvpn/Makefile=2Eam
@@ -53,6 +53,7 @@
 	common=2Eh \
 	comp=2Ec co=
mp=2Eh compstub=2Ec \
 	comp-lz4=2Ec comp-lz4=2Eh \
+	control_msg=2Ec contr=
ol_msg=2Eh \
 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \
 	crypto_openssl=
=2Ec crypto_openssl=2Eh \
 	crypto_mbedtls_legacy=2Ec crypto_mbedtls_legacy=
=2Eh \
@@ -107,6 +108,7 @@
 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \
 	p=
kcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \
+	oob=2Ec oob=2Eh \
 	openvpn=2E=
c openvpn=2Eh \
 	options=2Ec options=2Eh \
 	options_show=2Ec options_show=
=2Eh \
diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=
=2Ec
new file mode 100644
index 0000000=2E=2E4b69a00
--- /dev/null
+++ b/sr=
c/openvpn/control_msg=2Ec
@@ -0,0 +1,93 @@
+/*
+ *  OpenVPN -- An applicati=
on to securely tunnel IP networks
+ *             over a single TCP/UDP por=
t, with support for SSL/TLS-based
+ *             session authentication an=
d key exchange,
+ *             packet encryption, packet authentication, a=
nd
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 O=
penVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; yo=
u can redistribute it and/or modify
+ *  it under the terms of the GNU Gene=
ral Public License version 2
+ *  as published by the Free Software Foundat=
ion=2E
+ *
+ *  This program is distributed in the hope that it will be use=
ful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ =
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU=
 General Public License for more details=2E
+ *
+ *  You should have receiv=
ed a copy of the GNU General Public License along
+ *  with this program; i=
f not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFI=
G_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "c=
ontrol_msg=2Eh"
+
+bool
+ctrl_msg_tlv_write_header(struct buffer *buf, uint=
16_t type, bool optional, uint16_t value_len)
+{
+    uint16_t field =3D ty=
pe & CTRL_MSG_TLV_TYPE_MASK;
+    if (optional)
+    {
+        field |=3D =
CTRL_MSG_TLV_OPTIONAL_FLAG;
+    }
+    return buf_write_u16(buf, field) &&=
 buf_write_u16(buf, value_len);
+}
+
+bool
+ctrl_msg_tlv_read_header(struct=
 buffer *buf, struct ctrl_msg_tlv_header *hdr)
+{
+    int field =3D buf_re=
ad_u16(buf);
+    if (field < 0)
+    {
+        return false;
+    }
+    =
int len =3D buf_read_u16(buf);
+    if (len < 0)
+    {
+        return fal=
se;
+    }
+    hdr->type =3D (uint16_t)(field & CTRL_MSG_TLV_TYPE_MASK);
+=
    hdr->optional =3D (field & CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;
+    hdr=
->value_len =3D (uint16_t)len;
+    return true;
+}
+
+bool
+ctrl_msg_find_=
tlv(struct buffer *payload, uint16_t wanted_type, struct buffer *value)
+{
=
+    struct ctrl_msg_tlv_header hdr;
+    bool found =3D false;
+    while =
(BLEN(payload) > 0)
+    {
+        if (!ctrl_msg_tlv_read_header(payload, =
&hdr))
+        {
+            return false; /* fewer than 4 bytes left: tr=
uncated header */
+        }
+        /* Advance past the value; fails if t=
he payload is shorter than the
+         * header claims=2E */
+        uin=
t8_t *v =3D buf_read_alloc(payload, hdr=2Evalue_len);
+        if (!v)
+   =
     {
+            return false;
+        }
+        if (hdr=2Etype =3D=3D=
 wanted_type)
+        {
+            if (!found)
+            {
+         =
       buf_set_read(value, v, hdr=2Evalue_len);
+                found =3D =
true;
+            }
+        }
+        else if (!hdr=2Eoptional)
+       =
 {
+            return false; /* a mandatory TLV we do not understand, wher=
ever it sits */
+        }
+    }
+    return found;
+}
diff --git a/src/op=
envpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh
new file mode 100644
in=
dex 0000000=2E=2E44b0a1f
--- /dev/null
+++ b/src/openvpn/control_msg=2Eh
@@=
 -0,0 +1,98 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP net=
works
+ *             over a single TCP/UDP port, with support for SSL/TLS-=
based
+ *             session authentication and key exchange,
+ *         =
    packet encryption, packet authentication, and
+ *             packet co=
mpression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2E=
net>
+ *
+ *  This program is free software; you can redistribute it and/or=
 modify
+ *  it under the terms of the GNU General Public License version 2=

+ *  as published by the Free Software Foundation=2E
+ *
+ *  This program=
 is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WA=
RRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNES=
S FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for =
more details=2E
+ *
+ *  You should have received a copy of the GNU General=
 Public License along
+ *  with this program; if not, see <https://www=2Egn=
u=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Framing shared by the TLV-b=
ased control messages of the wire protocol=2E
+ *
+ * Such a message payloa=
d is a sequence of TLV entries=2E Each TLV starts with a
+ * 4-byte header:=
 a 16-bit field whose most significant bit is the "optional"
+ * flag and w=
hose remaining 15 bits are the type, followed by a 16-bit length
+ * giving=
 the size of the value that follows the header=2E
+ *
+ * The TLV-type valu=
es themselves are specific to the message family carried
+ * (out-of-band m=
essages define theirs in oob=2Eh), so only the framing lives
+ * here=2E
+ =
*/
+
+#ifndef CONTROL_MSG_H
+#define CONTROL_MSG_H
+
+#include "buffer=2Eh"=

+
+/* TLV header bit layout of the first 16-bit field */
+#define CTRL_MSG=
_TLV_OPTIONAL_FLAG 0x8000
+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff
+
+/* =
The header every TLV carries: the 15-bit type and optional flag packed into=

+ * the first 16-bit field, then the length of the value that follows=2E *=
/
+struct ctrl_msg_tlv_header
+{
+    uint16_t type;      /**< the 15-bit T=
LV type */
+    bool optional;      /**< value of the optional flag */
+   =
 uint16_t value_len; /**< length of the value following the header */
+};
+=

+/**
+ * Write a TLV header (type + optional flag + value length) to buf=
=2E
+ *
+ * @return true on success, false if buf has insufficient space=2E=

+ */
+bool ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bo=
ol optional,
+                               uint16_t value_len);
+
+/**
+ =
* Read a TLV header from buf, advancing past it=2E
+ *
+ * @param buf  buff=
er positioned at the TLV header
+ * @param hdr  filled with the type, optio=
nal flag and value length on success
+ * @return true on success, false if =
there are not enough bytes for a header=2E
+ */
+bool ctrl_msg_tlv_read_hea=
der(struct buffer *buf, struct ctrl_msg_tlv_header *hdr);
+
+/**
+ * Scan p=
ayload for the TLV of type wanted_type, skipping any other (e=2Eg=2E
+ * fu=
ture) TLV type that is marked optional=2E
+ *
+ * This is for messages that=
 carry exactly one mandatory TLV, which matches the
+ * currently supported=
 OOB messages: any other TLV that is not marked optional
+ * invalidates th=
e message wherever it is present, so the whole sequence is
+ * walked=2E A =
message with several mandatory TLVs would need a scan that knows
+ * all of=
 them=2E
+ *
+ * On success value covers exactly the found TLV's value byte=
s=2E The length from
+ * each TLV header is validated against payload as th=
e scan goes, so the whole
+ * value is guaranteed to be present; a header c=
laiming more bytes than payload
+ * holds is rejected rather than reported =
as found=2E payload is consumed as it is
+ * read=2E
+ *
+ * @param payload=
      buffer positioned at a TLV header
+ * @param wanted_type  the TLV typ=
e to look for
+ * @param value        set to a buffer covering the found TL=
V's value; it points
+ *                     into payload and owns no stora=
ge
+ * @return true if the TLV was found, false if it is not present, a TLV=
 header
+ *         or value is malformed or truncated, or a TLV we do not =
understand is
+ *         not marked optional=2E
+ */
+bool ctrl_msg_find_t=
lv(struct buffer *payload, uint16_t wanted_type, struct buffer *value);
+
+=
#endif /* ifndef CONTROL_MSG_H */
diff --git a/src/openvpn/oob=2Ec b/src/op=
envpn/oob=2Ec
new file mode 100644
index 0000000=2E=2E68d163e
--- /dev/null=

+++ b/src/openvpn/oob=2Ec
@@ -0,0 +1,85 @@
+/*
+ *  OpenVPN -- An applicat=
ion to securely tunnel IP networks
+ *             over a single TCP/UDP po=
rt, with support for SSL/TLS-based
+ *             session authentication a=
nd key exchange,
+ *             packet encryption, packet authentication, =
and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 =
OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; y=
ou can redistribute it and/or modify
+ *  it under the terms of the GNU Gen=
eral Public License version 2
+ *  as published by the Free Software Founda=
tion=2E
+ *
+ *  This program is distributed in the hope that it will be us=
eful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+=
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GN=
U General Public License for more details=2E
+ *
+ *  You should have recei=
ved a copy of the GNU General Public License along
+ *  with this program; =
if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONF=
IG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "=
oob=2Eh"
+#include "control_msg=2Eh"
+
+bool
+oob_probe_request_write(struc=
t buffer *buf, const struct oob_probe_request *r)
+{
+    return ctrl_msg_t=
lv_write_header(buf, OOB_TLV_PROBE_REQUEST, false, OOB_PROBE_REQUEST_LEN)
+=
           && buf_write_u32(buf, r->request_id)
+           && buf_write_u6=
4(buf, r->timestamp)
+           && buf_write_u32(buf, r->flags);
+}
+
+boo=
l
+oob_probe_request_read(struct buffer *buf, struct oob_probe_request *r)
=
+{
+    /* One bounds check covers the whole value: every field read below =
then fits
+     * by construction (OOB_PROBE_REQUEST_LEN is the sum of thei=
r sizes), so
+     * none of them needs its own error handling=2E Trailing =
bytes this version
+     * does not understand are simply left unread=2E */=

+    if (buf_len(buf) < OOB_PROBE_REQUEST_LEN)
+    {
+        return fals=
e;
+    }
+    r->request_id =3D buf_read_u32(buf, NULL);
+    r->timestamp=
 =3D buf_read_u64(buf, NULL);
+    r->flags =3D buf_read_u32(buf, NULL);
+ =
   return true;
+}
+
+bool
+oob_probe_reply_write(struct buffer *buf, const=
 struct oob_probe_reply *r)
+{
+    return ctrl_msg_tlv_write_header(buf, O=
OB_TLV_PROBE_REPLY, false, OOB_PROBE_REPLY_LEN)
+           && buf_write_u3=
2(buf, r->request_id)
+           && buf_write_u16(buf, r->priority)
+     =
      && buf_write_u16(buf, r->weight)
+           && buf_write_u16(buf, r-=
>max_latency_diff)
+           && buf_write_u16(buf, r->connect_lifetime)
+=
           && buf_write_u16(buf, r->flags);
+}
+
+bool
+oob_probe_reply_rea=
d(struct buffer *buf, struct oob_probe_reply *r)
+{
+    /* One bounds chec=
k for the whole value, as in oob_probe_request_read()=2E */
+    if (buf_le=
n(buf) < OOB_PROBE_REPLY_LEN)
+    {
+        return false;
+    }
+    r->=
request_id =3D buf_read_u32(buf, NULL);
+    r->priority =3D (uint16_t)buf_=
read_u16(buf);
+    r->weight =3D (uint16_t)buf_read_u16(buf);
+    r->max_=
latency_diff =3D (uint16_t)buf_read_u16(buf);
+    r->connect_lifetime =3D =
(uint16_t)buf_read_u16(buf);
+    r->flags =3D (uint16_t)buf_read_u16(buf);=

+    return true;
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2E=
h
new file mode 100644
index 0000000=2E=2Ec13ae17
--- /dev/null
+++ b/src/o=
penvpn/oob=2Eh
@@ -0,0 +1,106 @@
+/*
+ *  OpenVPN -- An application to secu=
rely tunnel IP networks
+ *             over a single TCP/UDP port, with su=
pport for SSL/TLS-based
+ *             session authentication and key exch=
ange,
+ *             packet encryption, packet authentication, and
+ *    =
         packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc=
 <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can redi=
stribute it and/or modify
+ *  it under the terms of the GNU General Public=
 License version 2
+ *  as published by the Free Software Foundation=2E
+ *=

+ *  This program is distributed in the hope that it will be useful,
+ *  =
but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHAN=
TABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General P=
ublic License for more details=2E
+ *
+ *  You should have received a copy =
of the GNU General Public License along
+ *  with this program; if not, see=
 <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Encoding/=
decoding of out-of-band (P_CONTROL_OOB_V1) control messages=2E
+ *
+ * An O=
OB message payload is a sequence of TLV entries; the TLVs it carries say
+ =
* what the message is (a SERVER_PROBE carries a probe request, a PROBE_REPL=
Y a
+ * probe reply)=2E The TLV framing is shared with the other TLV-based =
control
+ * messages of the wire protocol and lives in control_msg=2Eh; thi=
s file defines
+ * the OOB TLV types, their values, and the OOB-specific de=
cisions taken on
+ * them=2E
+ */
+
+#ifndef OOB_H
+#define OOB_H
+
+#inclu=
de "buffer=2Eh"
+#include "session_id=2Eh"
+
+/* TLV types (see the OOB con=
trol message section of the wire protocol spec)=2E
+ * Type 1 is the early =
negotiation TLV of the reset packets=2E */
+#define OOB_TLV_PROBE_REQUEST 0=
x02
+#define OOB_TLV_PROBE_REPLY   0x03
+
+/* Minimum on-wire value length =
(excluding the 4-byte TLV header) of each TLV:
+ * the sizes of its fixed f=
ields in wire order (see the structs below)=2E The
+ * value may be longer =
for forward compatibility; trailing bytes that are not
+ * understood are i=
gnored on read=2E
+ *
+ * probe request: request_id (u32), timestamp (u64),=
 flags (u32)
+ * probe reply: request_id (u32), then priority, weight, max_=
latency_diff,
+ * connect_lifetime and flags (u16 each) */
+#define OOB_PRO=
BE_REQUEST_LEN ((uint16_t)(sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uin=
t32_t)))
+#define OOB_PROBE_REPLY_LEN   ((uint16_t)(sizeof(uint32_t) + 5 * =
sizeof(uint16_t)))
+
+/* probe request TLV (sent by the client in a SERVER_=
PROBE) */
+struct oob_probe_request
+{
+    uint32_t request_id; /**< chose=
n by the client, echoed in the reply */
+    uint64_t timestamp;  /**< clie=
nt clock as a UNIX timestamp */
+    uint32_t flags;      /**< client capab=
ility flags, currently must be 0 */
+};
+
+/* probe reply TLV (sent by the =
server in a PROBE_REPLY) */
+struct oob_probe_reply
+{
+    uint32_t reques=
t_id;       /**< echoes the request_id of the request */
+    uint16_t prio=
rity;         /**< DNS-SRV style priority (lower is preferred) */
+    uint=
16_t weight;           /**< DNS-SRV style weight */
+    uint16_t max_laten=
cy_diff; /**< advertised candidate-band margin in ms;
+                    =
            *   used unless the client configured its own */
+    uint16_t =
connect_lifetime; /**< seconds the reply stays valid as the handshake reset=
 */
+    uint16_t flags;            /**< server behaviour flags */
+};
+
+/=
**
+ * Write a complete probe request TLV (header + value) to buf=2E It is =
the whole
+ * payload of a SERVER_PROBE=2E
+ */
+bool oob_probe_request_wri=
te(struct buffer *buf, const struct oob_probe_request *r);
+
+/**
+ * Read =
a probe request TLV value from buf=2E
+ *
+ * buf must cover exactly the TL=
V's value, as returned by ctrl_msg_find_tlv()=2E
+ * Trailing bytes beyond =
the fields understood here are ignored, so a longer
+ * value from a future=
 version still parses=2E
+ *
+ * @return true on success, false if buf is s=
horter than the mandatory fields=2E
+ */
+bool oob_probe_request_read(struc=
t buffer *buf, struct oob_probe_request *r);
+
+/**
+ * Write a complete pr=
obe reply TLV (header + value) to buf=2E It is the whole
+ * payload of a P=
ROBE_REPLY=2E
+ */
+bool oob_probe_reply_write(struct buffer *buf, const st=
ruct oob_probe_reply *r);
+
+/**
+ * Read a probe reply TLV value from buf=
=2E See oob_probe_request_read() for the
+ * calling convention=2E
+ */
+bo=
ol oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r);
+
+=
#endif /* OOB_H */
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
i=
ndex 76150d4=2E=2E2864661 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvp=
n/ssl=2Ec
@@ -3705,8 +3705,9 @@
     bool new_link =3D false;
     struct s=
ession_id sid; /* remote session ID */
 
-    /* verify legal opcode */
-  =
  if (op < P_FIRST_OPCODE || op > P_LAST_OPCODE)
+    /* verify legal opcod=
e=2E An out-of-band packet has no control message id and
+     * no ACK arr=
ay, which is what we parse next=2E */
+    if (op < P_FIRST_OPCODE || op > =
P_LAST_OPCODE || opcode_is_oob(op))
     {
         if (op =3D=3D P_CONTROL=
_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)
        =
 {
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 90b=
2aec=2E=2E7f9ce1d27 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/=
ssl_pkt=2Ec
@@ -168,6 +168,8 @@
 {
     ASSERT(ks->key_id >=3D 0 && ks->key=
_id <=3D P_KEY_ID_MASK);
     ASSERT(opcode >=3D 0 && opcode <=3D P_LAST_OP=
CODE);
+    /* OOB packets carry no message id or ACK array */
+    ASSERT(=
!opcode_is_oob(opcode));
     uint8_t header =3D (uint8_t)(ks->key_id | (op=
code << P_OPCODE_SHIFT));
 
     /* Workaround for Softether servers=2E Sof=
tether has a bug that it only
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/op=
envpn/ssl_pkt=2Eh
index 03e8930=2E=2Ed4fad04 100644
--- a/src/openvpn/ssl_p=
kt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -58,11 +58,23 @@
  * like P_CONTROL=
_HARD_RESET_CLIENT_V3 */
 #define P_CONTROL_WKC_V1 11
 
-/* define the rang=
e of legal opcodes
+/* Out-of-band control message, e=2Eg=2E a server probe=
=2E Not part of the reliable
+ * control channel: no control message id and=
 no ACK array, just a message
+ * header and TLVs after the session id; nev=
er handled by tls_pre_decrypt()=2E */
+#define P_CONTROL_OOB_V1 12
+
+/* de=
fine the range of defined opcodes, in- and out-of-band
  * Since we do no l=
onger support key-method 1 we consider
  * the v1 op codes invalid */
 #def=
ine P_FIRST_OPCODE 3
-#define P_LAST_OPCODE  11
+#define P_LAST_OPCODE  12
=
+
+/* Is op one of the out-of-band opcodes? */
+static inline bool
+opcode_=
is_oob(int op)
+{
+    return op =3D=3D P_CONTROL_OOB_V1;
+}
 
 /*
  * Defi=
ne number of buffers for send and receive in the reliability layer=2E
@@ -2=
56,6 +268,9 @@
         case P_CONTROL_WKC_V1:
             return "P_CONTR=
OL_WKC_V1";
 
+        case P_CONTROL_OOB_V1:
+            return "P_CONTRO=
L_OOB_V1";
+
         case P_ACK_V1:
             return "P_ACK_V1";
 
diff=
 --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/=
Makefile=2Eam
index 5954902=2E=2Ee6c8fb5 100644
--- a/tests/unit_tests/open=
vpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -157,10 +=
157,13 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcd=
ir)/src/openvpn \
 	@TEST_CFLAGS@
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS=
@
-pkt_testdriver_SOURCES =3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_w=
in32_execve=2Ec test_common=2Eh \
+pkt_testdriver_SOURCES =3D test_pkt=2Ec =
test_oob=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \
+	test_commo=
n=2Eh \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/=
base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/o=
penvpn/control_msg=2Ec \
+	$(top_srcdir)/src/openvpn/oob=2Ec \
 	$(top_srcd=
ir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \=

 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
diff --git a/tests/unit_t=
ests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
new file =
mode 100644
index 0000000=2E=2E656cb21
--- /dev/null
+++ b/tests/unit_tests=
/openvpn/test_oob=2Ec
@@ -0,0 +1,381 @@
+/*
+ *  OpenVPN -- An application =
to securely tunnel IP networks
+ *             over a single TCP/UDP port, =
with support for SSL/TLS-based
+ *             session authentication and k=
ey exchange,
+ *             packet encryption, packet authentication, and
=
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 Open=
VPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you c=
an redistribute it and/or modify
+ *  it under the terms of the GNU General=
 Public License version 2
+ *  as published by the Free Software Foundation=
=2E
+ *
+ *  This program is distributed in the hope that it will be useful=
,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Ge=
neral Public License for more details=2E
+ *
+ *  You should have received =
a copy of the GNU General Public License along
+ *  with this program; if n=
ot, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H=

+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stda=
rg=2Eh>
+#include <stddef=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh=
>
+
+#include "control_msg=2Eh"
+#include "oob=2Eh"
+#include "test_common=
=2Eh"
+
+/* Write a probe request TLV and read it back; fields must survive=
 the round
+ * trip and the whole buffer must be consumed=2E */
+static voi=
d
+test_probe_request_roundtrip(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    con=
st struct oob_probe_request in =3D {
+        =2Erequest_id =3D 0xdeadbeef,=

+        =2Etimestamp =3D 0x0123456789abcdefULL,
+        =2Eflags =3D 0,
=
+    };
+    assert_true(oob_probe_request_write(&buf, &in));
+    /* heade=
r (4) + value (16) */
+    assert_int_equal(BLEN(&buf), 4 + OOB_PROBE_REQUE=
ST_LEN);
+
+    /* the header codec, read from a copy so the scan below sti=
ll sees it */
+    struct buffer peek =3D buf;
+    struct ctrl_msg_tlv_hea=
der hdr;
+    assert_true(ctrl_msg_tlv_read_header(&peek, &hdr));
+    asse=
rt_int_equal(hdr=2Etype, OOB_TLV_PROBE_REQUEST);
+    assert_false(hdr=2Eop=
tional);
+    assert_int_equal(hdr=2Evalue_len, OOB_PROBE_REQUEST_LEN);
+
+=
    struct buffer value;
+    assert_true(ctrl_msg_find_tlv(&buf, OOB_TLV_P=
ROBE_REQUEST, &value));
+    assert_int_equal(BLEN(&value), OOB_PROBE_REQUE=
ST_LEN);
+
+    struct oob_probe_request out =3D { 0 };
+    assert_true(oo=
b_probe_request_read(&value, &out));
+    assert_int_equal(in=2Erequest_id,=
 out=2Erequest_id);
+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp)=
;
+    assert_int_equal(in=2Eflags, out=2Eflags);
+    /* the scan consumed=
 header and value alike */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_=
free(&gc);
+}
+
+/* The probe request wire format is locked to the spec's f=
ield order
+ * (request_id, timestamp, flags), big-endian=2E */
+static voi=
d
+test_probe_request_wire_format(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    con=
st struct oob_probe_request in =3D {
+        =2Erequest_id =3D 0x11223344,=

+        =2Etimestamp =3D 0x0102030405060708ULL,
+        =2Eflags =3D 0,
=
+    };
+    assert_true(oob_probe_request_write(&buf, &in));
+
+    const =
uint8_t expected[] =3D {
+        0x00,
+        0x02, /* TLV type 2 (not o=
ptional) */
+        0x00,
+        0x10, /* TLV value length =3D 16 */
+  =
      0x11,
+        0x22,
+        0x33,
+        0x44, /* request_id */
+=
        0x01,
+        0x02,
+        0x03,
+        0x04,
+        0x05,
+=
        0x06,
+        0x07,
+        0x08, /* timestamp */
+        0x00,
=
+        0x00,
+        0x00,
+        0x00, /* flags */
+    };
+    asser=
t_int_equal(BLEN(&buf), sizeof(expected));
+    assert_memory_equal(BPTR(&b=
uf), expected, sizeof(expected));
+
+    gc_free(&gc);
+}
+
+/* Write a pro=
be reply TLV and read it back=2E */
+static void
+test_probe_reply_roundtri=
p(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer=
 buf =3D alloc_buf_gc(128, &gc);
+
+    struct oob_probe_reply in =3D {
+  =
      =2Erequest_id =3D 0x11223344,
+        =2Epriority =3D 10,
+        =
=2Eweight =3D 100,
+        =2Econnect_lifetime =3D 30,
+        =2Eflags =
=3D 1,
+        =2Emax_latency_diff =3D 25,
+    };
+
+    assert_true(oob_=
probe_reply_write(&buf, &in));
+    assert_int_equal(BLEN(&buf), 4 + OOB_PR=
OBE_REPLY_LEN);
+
+    struct buffer peek =3D buf;
+    struct ctrl_msg_tlv=
_header hdr;
+    assert_true(ctrl_msg_tlv_read_header(&peek, &hdr));
+    =
assert_int_equal(hdr=2Etype, OOB_TLV_PROBE_REPLY);
+    assert_int_equal(hd=
r=2Evalue_len, OOB_PROBE_REPLY_LEN);
+
+    struct buffer value;
+    asser=
t_true(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_REPLY, &value));
+
+    struct=
 oob_probe_reply out =3D { 0 };
+    assert_true(oob_probe_reply_read(&valu=
e, &out));
+    assert_int_equal(in=2Erequest_id, out=2Erequest_id);
+    a=
ssert_int_equal(in=2Epriority, out=2Epriority);
+    assert_int_equal(in=2E=
weight, out=2Eweight);
+    assert_int_equal(in=2Econnect_lifetime, out=2Ec=
onnect_lifetime);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+    asse=
rt_int_equal(in=2Emax_latency_diff, out=2Emax_latency_diff);
+    assert_in=
t_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* The probe reply wire =
format is locked to the spec's field order (request_id,
+ * priority, weigh=
t, max_latency_diff, connect_lifetime, flags), big-endian=2E */
+static voi=
d
+test_probe_reply_wire_format(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    str=
uct oob_probe_reply in =3D {
+        =2Erequest_id =3D 0x11223344,
+      =
  =2Epriority =3D 10,
+        =2Eweight =3D 100,
+        =2Econnect_lifet=
ime =3D 30,
+        =2Eflags =3D 1,
+        =2Emax_latency_diff =3D 25,
+=
    };
+
+    assert_true(oob_probe_reply_write(&buf, &in));
+
+    const u=
int8_t expected[] =3D {
+        0x00,
+        0x03, /* TLV type 3 (not op=
tional) */
+        0x00,
+        0x0e, /* TLV value length =3D 14 */
+   =
     0x11,
+        0x22,
+        0x33,
+        0x44, /* request_id */
+ =
       0x00,
+        0x0a, /* priority =3D 10 */
+        0x00,
+        0=
x64, /* weight =3D 100 */
+        0x00,
+        0x19, /* max_latency_diff=
 =3D 25 */
+        0x00,
+        0x1e, /* connect_lifetime =3D 30 */
+   =
     0x00,
+        0x01, /* flags =3D 1 */
+    };
+    assert_int_equal(B=
LEN(&buf), sizeof(expected));
+    assert_memory_equal(BPTR(&buf), expected=
, sizeof(expected));
+
+    gc_free(&gc);
+}
+
+/* A TLV with a longer-than=
-known value must still parse: the known fields are
+ * read and the traili=
ng bytes are skipped (forward compatibility)=2E */
+static void
+test_probe=
_request_forward_compat(void **state)
+{
+    struct gc_arena gc =3D gc_new=
();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint16_=
t extended_len =3D OOB_PROBE_REQUEST_LEN + 4;
+    assert_true(ctrl_msg_tlv=
_write_header(&buf, OOB_TLV_PROBE_REQUEST, false, extended_len));
+    asse=
rt_true(buf_write_u32(&buf, 7));          /* request_id */
+    assert_true=
(buf_write_u32(&buf, 0));          /* timestamp high */
+    assert_true(bu=
f_write_u32(&buf, 0xdeadbeef)); /* timestamp low */
+    assert_true(buf_wr=
ite_u32(&buf, 0));          /* flags */
+    assert_true(buf_write_u32(&buf=
, 0x11223344)); /* unknown trailing field */
+
+    struct buffer value;
+ =
   assert_true(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_REQUEST, &value));
+  =
  assert_int_equal(BLEN(&value), extended_len);
+
+    struct oob_probe_req=
uest out =3D { 0 };
+    assert_true(oob_probe_request_read(&value, &out));=

+    assert_int_equal(out=2Erequest_id, 7);
+    assert_true(out=2Etimesta=
mp =3D=3D 0xdeadbeefULL);
+    assert_int_equal(out=2Eflags, 0);
+    /* th=
e unknown trailing field must have been consumed from the payload */
+    a=
ssert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A value short=
er than the mandatory fields must be rejected, even when it
+ * holds enoug=
h bytes for some of the individual fields to read successfully=2E */
+stati=
c void
+test_probe_request_too_short(void **state)
+{
+    struct gc_arena =
gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    =
/* 4 of the 16 mandatory value bytes: enough for the request_id alone */
+ =
   assert_true(buf_write_u32(&buf, 0xdeadbeef));
+
+    struct oob_probe_re=
quest out =3D { 0 };
+    assert_false(oob_probe_request_read(&buf, &out));=

+
+    gc_free(&gc);
+}
+
+/* A TLV header claiming more value bytes than =
the payload holds must be
+ * rejected by the scan rather than reported as =
found -- for the TLV being
+ * looked for as much as for one that would mer=
ely be skipped=2E */
+static void
+test_find_tlv_value_truncated(void **sta=
te)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer value;
+
+ =
   /* the wanted TLV declares 12 value bytes, only 4 are present */
+    st=
ruct buffer buf =3D alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_w=
rite_header(&buf, OOB_TLV_PROBE_REQUEST, false,
+                          =
                OOB_PROBE_REQUEST_LEN));
+    assert_true(buf_write_u32(&bu=
f, 0xdeadbeef));
+    assert_false(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_RE=
QUEST, &value));
+
+    /* same defect on a TLV that would be skipped: the =
scan must not walk past
+     * the end of the payload looking for the next=
 header */
+    struct buffer buf2 =3D alloc_buf_gc(128, &gc);
+    assert_=
true(ctrl_msg_tlv_write_header(&buf2, 0x7ff, false, 64));
+    assert_true(=
buf_write_u32(&buf2, 0));
+    assert_false(ctrl_msg_find_tlv(&buf2, OOB_TL=
V_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
+}
+
+/* Bytes left over af=
ter the last TLV that are too few for a header make the
+ * message malform=
ed, even when the wanted TLV was already found=2E */
+static void
+test_fin=
d_tlv_trailing_bytes(void **state)
+{
+    struct gc_arena gc =3D gc_new();=

+    struct buffer value;
+
+    /* 1 to 3 bytes: less than a 4-byte TLV h=
eader */
+    for (int trailing =3D 1; trailing <=3D 3; trailing++)
+    {
=
+        struct buffer buf =3D alloc_buf_gc(128, &gc);
+        const struc=
t oob_probe_request in =3D { =2Etimestamp =3D 1, =2Eflags =3D 0 };
+       =
 assert_true(oob_probe_request_write(&buf, &in));
+        for (int i =3D 0=
; i < trailing; i++)
+        {
+            assert_true(buf_write_u8(&buf,=
 0));
+        }
+        assert_false(ctrl_msg_find_tlv(&buf, OOB_TLV_PROB=
E_REQUEST, &value));
+    }
+
+    gc_free(&gc);
+}
+
+/* An unknown TLV ma=
rked optional after the wanted one is skipped, and the
+ * wanted value is =
still the one returned=2E */
+static void
+test_find_tlv_skips_optional_aft=
er_wanted(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struc=
t buffer buf =3D alloc_buf_gc(128, &gc);
+    struct buffer value;
+
+    c=
onst struct oob_probe_request in =3D { =2Etimestamp =3D 7, =2Eflags =3D 0 }=
;
+    assert_true(oob_probe_request_write(&buf, &in));
+    assert_true(ct=
rl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_=
u32(&buf, 0));
+
+    assert_true(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_REQ=
UEST, &value));
+    assert_int_equal(BLEN(&value), OOB_PROBE_REQUEST_LEN);=

+    struct oob_probe_request out =3D { 0 };
+    assert_true(oob_probe_re=
quest_read(&value, &out));
+    assert_true(out=2Etimestamp =3D=3D 7);
+
+ =
   gc_free(&gc);
+}
+
+/* An empty payload holds no TLV=2E */
+static void
=
+test_find_tlv_empty_payload(void **state)
+{
+    struct gc_arena gc =3D g=
c_new();
+    struct buffer buf =3D alloc_buf_gc(16, &gc);
+    struct buff=
er value;
+
+    assert_false(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_REQUEST=
, &value));
+
+    gc_free(&gc);
+}
+
+/* Reading a TLV header must fail wh=
en the buffer holds less data than a
+ * complete 4-byte header (empty, or =
only the type field), rather than read
+ * past the available data=2E */
+s=
tatic void
+test_tlv_header_truncated(void **state)
+{
+    struct gc_arena=
 gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+   =
 struct ctrl_msg_tlv_header hdr;
+
+    /* empty buffer */
+    assert_fals=
e(ctrl_msg_tlv_read_header(&buf, &hdr));
+
+    /* only the type field pres=
ent, no length */
+    assert_true(buf_write_u16(&buf, OOB_TLV_PROBE_REQUES=
T));
+    assert_false(ctrl_msg_tlv_read_header(&buf, &hdr));
+
+    gc_fre=
e(&gc);
+}
+
+/* The OOB tests run as a second group of pkt_testdriver; see=
 test_pkt=2Ec=2E */
+int
+run_oob_tests(void)
+{
+    const struct CMUnitTe=
st tests[] =3D {
+        cmocka_unit_test(test_probe_request_roundtrip),
+=
        cmocka_unit_test(test_probe_request_wire_format),
+        cmocka_u=
nit_test(test_probe_reply_roundtrip),
+        cmocka_unit_test(test_probe_=
reply_wire_format),
+        cmocka_unit_test(test_probe_request_forward_co=
mpat),
+        cmocka_unit_test(test_probe_request_too_short),
+        cm=
ocka_unit_test(test_find_tlv_value_truncated),
+        cmocka_unit_test(te=
st_find_tlv_trailing_bytes),
+        cmocka_unit_test(test_find_tlv_skips_=
optional_after_wanted),
+        cmocka_unit_test(test_find_tlv_empty_paylo=
ad),
+        cmocka_unit_test(test_tlv_header_truncated),
+    };
+
+    r=
eturn cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);
+}
diff =
--git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/te=
st_pkt=2Ec
index a732c2b=2E=2E390b3f6 100644
--- a/tests/unit_tests/openvpn=
/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -44,6 +44,8 @@=

 #include "reliable=2Eh"
 #include "siphash=2Eh"
 
+int run_oob_tests(void=
); /* test_oob=2Ec */
+
 int
 parse_line(const char *line, char **p, const =
int n, const char *file, const int line_num,
            msglvl_t msglevel,=
 struct gc_arena *gc)
@@ -748,5 +750,7 @@
         cmocka_unit_test(test_ex=
tract_control_message)
     };
 
-    return cmocka_run_group_tests_name("p=
kt tests", tests, NULL, NULL);
+    int failed =3D cmocka_run_group_tests_n=
ame("pkt tests", tests, NULL, NULL);
+    failed +=3D run_oob_tests();
+   =
 return failed ? 1 : 0;
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Change-Number: 1=
741
Gerrit-PatchSet: 18
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-=
Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <ls=
tipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--ohdY7cysx+s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #18</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view-1 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">oob: Add control message TLV encoding =
(P_CONTROL_OOB_V1)<br><br>Out-of-band control messages carry control data b=
ut belong to no<br>session, so a client can ask a server about itself befor=
e connecting=2E<br>Reserve opcode 12 for them and add the TLV codecs the pr=
obe needs: the<br>probe request a SERVER_PROBE carries and the probe reply =
a PROBE_REPLY<br>carries=2E<br><br>A message is just a sequence of TLVs, an=
d the TLVs it carries say what<br>it is=2E The probe request carries a requ=
est_id chosen by the client,<br>which the probe reply echoes=2E<br><br>The =
spec uses the same TLV framing for all its control messages, not<br>just th=
e out-of-band ones, so the TLV header and the TLV scan go into<br>their own=
 control_msg=2Ec/h; oob=2Ec keeps the OOB TLV types=2E<br><br>The scan is s=
trict: a truncated TLV header or value, or an unknown TLV<br>not marked opt=
ional, rejects the whole message=2E<br><br>P_LAST_OPCODE becomes 12=2E tls_=
pre_decrypt() rejects the OOB opcodes<br>explicitly: they are not part of t=
he reliable control channel (no<br>control message id, no ACK array); the s=
erver answers them<br>statelessly in a follow-up=2E<br><br>See &quot;Out of=
 band and control data messages&quot; and &quot;[OPCODE ID 12]<br>CONTROL_O=
OB_V1&quot; in the wire protocol specification<br>(openvpn-rfc, openvpn-wir=
e-protocol=2Exml)=2E<br><br>Change-Id: I1c8d302ac57c5603d622a7be14be3694373=
88268<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M =
CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/control_ms=
g=2Ec<br>A src/openvpn/control_msg=2Eh<br>A src/openvpn/oob=2Ec<br>A src/op=
envpn/oob=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M sr=
c/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A test=
s/unit_tests/openvpn/test_oob=2Ec<br>M tests/unit_tests/openvpn/test_pkt=2E=
c<br>12 files changed, 803 insertions(+), 6 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/4=
1/1741/18</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><b=
r><span>index 6eb5954=2E=2E72680b2 100644</span><br><span>--- a/CMakeLists=
=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -445,6 +44=
5,8 @@</span><br><span>     src/openvpn/console=2Ec</span><br><span>     sr=
c/openvpn/console_builtin=2Ec</span><br><span>     src/openvpn/console=2Eh<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/cont=
rol_msg=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/=
openvpn/control_msg=2Eh</span><br><span>     src/openvpn/crypto=2Ec</span><=
br><span>     src/openvpn/crypto=2Eh</span><br><span>     src/openvpn/crypt=
o_backend=2Eh</span><br><span>@@ -523,6 +525,8 @@</span><br><span>     src/=
openvpn/multi_io=2Ec</span><br><span>     src/openvpn/occ=2Ec</span><br><sp=
an>     src/openvpn/occ=2Eh</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    src/openvpn/oob=2Ec</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    src/openvpn/oob=2Eh</span><br><span>     src/openvpn/openvp=
n=2Ec</span><br><span>     src/openvpn/openvpn=2Eh</span><br><span>     src=
/openvpn/openvpn_win32_resources=2Erc</span><br><span>@@ -883,6 +887,9 @@</=
span><br><span> </span><br><span>     target_sources(test_pkt PRIVATE</span=
><br><span>         tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/ope=
nvpn/test_oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      src/openvpn/control_msg=2Ec</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        src/openvpn/oob=2Ec</span><br><span>         src/open=
vpn/argv=2Ec</span><br><span>         src/openvpn/base64=2Ec</span><br><spa=
n>         src/openvpn/crypto_epoch=2Ec</span><br><span>diff --git a/src/op=
envpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 7fd12=
b4=2E=2E5e6b4d9 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</spa=
n><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -53,6 +53,7 =
@@</span><br><span> 	common=2Eh \</span><br><span> 	comp=2Ec comp=2Eh comps=
tub=2Ec \</span><br><span> 	comp-lz4=2Ec comp-lz4=2Eh \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	control_msg=2Ec control_msg=2Eh \</spa=
n><br><span> 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \</span><br><span> 	=
crypto_openssl=2Ec crypto_openssl=2Eh \</span><br><span> 	crypto_mbedtls_le=
gacy=2Ec crypto_mbedtls_legacy=2Eh \</span><br><span>@@ -107,6 +108,7 @@</s=
pan><br><span> 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \</span><br><span>=
 	pkcs11_openssl=2Ec \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	oob=2Ec oob=2Eh \</span><br><spa=
n> 	openvpn=2Ec openvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \</=
span><br><span> 	options_show=2Ec options_show=2Eh \</span><br><span>diff -=
-git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2E4b69a00</span=
><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=2Ec<=
/span><br><span>@@ -0,0 +1,93 @@</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
OpenVPN -- An application to securely tunnel IP networks</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP p=
ort, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             session authentication and key exchange,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet e=
ncryption, packet authentication, and</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             packet compression=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
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
or: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_wr=
ite_header(struct buffer *buf, uint16_t type, bool optional, uint16_t value=
_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    uint16_t field =3D type &amp=
; CTRL_MSG_TLV_TYPE_MASK;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (optional)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi=
eld |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return buf_write_u16(buf, field) &amp;&amp; buf_write_u16(buf, value=
_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_=
header *hdr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int field =3D buf_rea=
d_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
field &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int len =3D buf_read_u16(buf=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;type =3D (uint16_t)(field &am=
p; CTRL_MSG_TLV_TYPE_MASK);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    hdr-&gt;optional =3D (field &amp; CTRL_MSG_TLV_OPTIONAL_FLAG) !=
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;v=
alue_len =3D (uint16_t)len;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ctrl_msg_find_tlv(struct buffer *payload, uint1=
6_t wanted_type, struct buffer *value)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    bool found =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    while (BLEN(payload) &gt; 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (!ctrl_msg_tlv_read_header(payload, &amp;h=
dr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return false;=
 /* fewer than 4 bytes left: truncated header */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        /* Advance past the value; fails if the payload =
is shorter than the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         * header claims=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        uint8_t *v =3D buf_read_alloc(payload, hdr=2Evalue_len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!v)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (hdr=2Etype =3D=3D wanted_=
type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!found)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_set_re=
ad(value, v, hdr=2Evalue_len);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                found =3D true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        else if (!hdr=2Eoptional)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return false; /* a mandatory TLV we do not understan=
d, wherever it sits */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return found;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff =
--git a/src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh</span><br=
><span>new file mode 100644</span><br><span>index 0000000=2E=2E44b0a1f</spa=
n><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=2Eh=
</span><br><span>@@ -0,0 +1,98 @@</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 OpenVPN -- An application to securely tunnel IP networks</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP =
port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             session authentication and key exchange,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
encryption, packet authentication, and</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet compression=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvp=
n=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free =
software; you can redistribute it and/or modify</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Publi=
c License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  as published by the Free Software Foundation=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is distributed in the hope that it will b=
e useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WI=
THOUT ANY WARRANTY; without even the implied warranty of</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  GNU General Public License for more details=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/license=
s/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Framing shared by the TLV-based control messages of the wire protocol=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Such a message payload is a se=
quence of TLV entries=2E Each TLV starts with a</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * 4-byte header: a 16-bit field whose most sig=
nificant bit is the &quot;optional&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * flag and whose remaining 15 bits are the type, foll=
owed by a 16-bit length</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * giving the size of the value that follows the header=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * The TLV-type values themselves are specific to=
 the message family carried</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * (out-of-band messages define theirs in oob=2Eh), so only the fra=
ming lives</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * here=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef CONTROL_MSG_H</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define CONTROL_MSG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* TLV header bit layout of the first 16-bit field */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x80=
00</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MSG_=
TLV_TYPE_MASK     0x7fff</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The header =
every TLV carries: the 15-bit type and optional flag packed into</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * the first 16-bit field, the=
n the length of the value that follows=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+struct ctrl_msg_tlv_header</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    uint16_t type;      /**&lt; the 15-bit TLV type */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool optional;      =
/**&lt; value of the optional flag */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint16_t value_len; /**&lt; length of the value follo=
wing the header */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Write a TLV header (type + optional flag + value l=
ength) to buf=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on s=
uccess, false if buf has insufficient space=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type=
, bool optional,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                            uint16_t value_len);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Rea=
d a TLV header from buf, advancing past it=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param buf  buffer positioned at the TLV header</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param hdr  filled with the type=
, optional flag and value length on success</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return true on success, false if there are not =
enough bytes for a header=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ct=
rl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Scan payload for the TLV of type wanted_type, skip=
ping any other (e=2Eg=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * future) TLV type that is marked optional=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * This is for messages that carry exactly one mandatory T=
LV, which matches the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * currently supported OOB messages: any other TLV that is not marked opt=
ional</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * invalidates=
 the message wherever it is present, so the whole sequence is</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * walked=2E A message with sever=
al mandatory TLVs would need a scan that knows</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * all of them=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * On success value covers exactly the found TLV&#39;s value bytes=
=2E The length from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * each TLV header is validated against payload as the scan goes, so the wh=
ole</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * value is guar=
anteed to be present; a header claiming more bytes than payload</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * holds is rejected rather tha=
n reported as found=2E payload is consumed as it is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * read=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param payload      buffer positioned at a TLV header</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param wanted_type  the TLV=
 type to look for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param value        set to a buffer covering the found TLV&#39;s value; it=
 points</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
           into payload and owns no storage</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return true if the TLV was found, false if it i=
s not present, a TLV header</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *         or value is malformed or truncated, or a TLV we do not u=
nderstand is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
    not marked optional=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl=
_msg_find_tlv(struct buffer *payload, uint16_t wanted_type, struct buffer *=
value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef CONTROL_MSG_H =
*/</span><br><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</=
span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E68d1=
63e</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob=2Ec=
</span><br><span>@@ -0,0 +1,85 @@</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 OpenVPN -- An application to securely tunnel IP networks</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP =
port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             session authentication and key exchange,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
encryption, packet authentication, and</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet compression=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvp=
n=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free =
software; you can redistribute it and/or modify</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Publi=
c License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  as published by the Free Software Foundation=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is distributed in the hope that it will b=
e useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WI=
THOUT ANY WARRANTY; without even the implied warranty of</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  GNU General Public License for more details=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/license=
s/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;oob=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob=
_probe_request_write(struct buffer *buf, const struct oob_probe_request *r)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_header(=
buf, OOB_TLV_PROBE_REQUEST, false, OOB_PROBE_REQUEST_LEN)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(b=
uf, r-&gt;request_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+           &amp;&amp; buf_write_u64(buf, r-&gt;timestamp)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32=
(buf, r-&gt;flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+oob_probe_request_read(struct buffer *buf, struct oo=
b_probe_request *r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* One bounds =
check covers the whole value: every field read below then fits</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * by construction (OOB_PROB=
E_REQUEST_LEN is the sum of their sizes), so</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * none of them needs its own error handling=
=2E Trailing bytes this version</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * does not understand are simply left unread=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(buf) &lt; O=
OB_PROBE_REQUEST_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;request_id =3D=
 buf_read_u32(buf, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    r-&gt;timestamp =3D buf_read_u64(buf, NULL);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    r-&gt;flags =3D buf_read_u32(buf, NU=
LL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+oob_probe_reply_write(struct buffer *buf, const struct oob_probe_reply=
 *r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_hea=
der(buf, OOB_TLV_PROBE_REPLY, false, OOB_PROBE_REPLY_LEN)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(b=
uf, r-&gt;request_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+           &amp;&amp; buf_write_u16(buf, r-&gt;priority)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(=
buf, r-&gt;weight)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
          &amp;&amp; buf_write_u16(buf, r-&gt;max_latency_diff)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write=
_u16(buf, r-&gt;connect_lifetime)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;flags);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob=
_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* One bounds check for the whole value, as =
in oob_probe_request_read()=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (buf_len(buf) &lt; OOB_PROBE_REPLY_LEN)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    r-&gt;request_id =3D buf_read_u32(buf, NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;priority =3D (uint16=
_t)buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    r-&gt;weight =3D (uint16_t)buf_read_u16(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    r-&gt;max_latency_diff =3D (uint16_t)=
buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   r-&gt;connect_lifetime =3D (uint16_t)buf_read_u16(buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;flags =3D (uint16_t)buf_re=
ad_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000=2E=2Ec13ae17</span><=
br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br>=
<span>@@ -0,0 +1,106 @@</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -=
- An application to securely tunnel IP networks</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with=
 support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *             session authentication and key exchange,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption=
, packet authentication, and</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             packet compression=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; =
you can redistribute it and/or modify</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  it under the terms of the GNU General Public License =
version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as pub=
lished by the Free Software Foundation=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  This program is distributed in the hope that it will be useful,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WA=
RRANTY; without even the implied warranty of</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PU=
RPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  GNU General Public License for more details=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  You should have received a copy of the GNU General Public L=
icense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wit=
h this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Encodi=
ng/decoding of out-of-band (P_CONTROL_OOB_V1) control messages=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * An OOB message payload is a sequence of TLV=
 entries; the TLVs it carries say</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * what the message is (a SERVER_PROBE carries a probe reques=
t, a PROBE_REPLY a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* probe reply)=2E The TLV framing is shared with the other TLV-based contro=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * messages of the=
 wire protocol and lives in control_msg=2Eh; this file defines</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * the OOB TLV types, their valu=
es, and the OOB-specific decisions taken on</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * them=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OOB_H</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_H</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;session_id=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* TLV types (see the OOB control message=
 section of the wire protocol spec)=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Type 1 is the early negotiation TLV of the reset pack=
ets=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OO=
B_TLV_PROBE_REQUEST 0x02</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define OOB_TLV_PROBE_REPLY   0x03</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* Minimum on-wire value length (excluding the 4-byte TLV header) of each =
TLV:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the sizes of=
 its fixed fields in wire order (see the structs below)=2E The</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * value may be longer for forwa=
rd compatibility; trailing bytes that are not</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * understood are ignored on read=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * probe request: request_id (u32), timestamp (u6=
4), flags (u32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * p=
robe reply: request_id (u32), then priority, weight, max_latency_diff,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * connect_lifetime and =
flags (u16 each) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define OOB_PROBE_REQUEST_LEN ((uint16_t)(sizeof(uint32_t) + sizeof(uint64_=
t) + sizeof(uint32_t)))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define OOB_PROBE_REPLY_LEN   ((uint16_t)(sizeof(uint32_t) + 5 * sizeof=
(uint16_t)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* probe request TLV (sent=
 by the client in a SERVER_PROBE) */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+struct oob_probe_request</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    uint32_t request_id; /**&lt; chosen by the client, echoed in the re=
ply */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t =
timestamp;  /**&lt; client clock as a UNIX timestamp */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    uint32_t flags;      /**&lt; client=
 capability flags, currently must be 0 */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* probe reply=
 TLV (sent by the server in a PROBE_REPLY) */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+struct oob_probe_reply</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    uint32_t request_id;       /**&lt; echoes the request_id of =
the request */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int16_t priority;         /**&lt; DNS-SRV style priority (lower is preferre=
d) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t w=
eight;           /**&lt; DNS-SRV style weight */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    uint16_t max_latency_diff; /**&lt; adverti=
sed candidate-band margin in ms;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                *   used unless the client con=
figured its own */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint16_t connect_lifetime; /**&lt; seconds the reply stays valid as the =
handshake reset */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint16_t flags;            /**&lt; server behaviour flags */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write=
 a complete probe request TLV (header + value) to buf=2E It is the whole</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * payload of a SERVER=
_PROBE=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_request_wri=
te(struct buffer *buf, const struct oob_probe_request *r);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Read a probe request TLV value from buf=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * buf must cover exactly the TLV&#39;s value, as returned by =
ctrl_msg_find_tlv()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Trailing bytes beyond the fields understood here are ignored, so a lo=
nger</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * value from a=
 future version still parses=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn true on success, false if buf is shorter than the mandatory fields=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_request_read(struct =
buffer *buf, struct oob_probe_request *r);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a c=
omplete probe reply TLV (header + value) to buf=2E It is the whole</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * payload of a PROBE_REPLY=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_reply_write(struc=
t buffer *buf, const struct oob_probe_reply *r);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Rea=
d a probe reply TLV value from buf=2E See oob_probe_request_read() for the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * calling conventio=
n=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_reply_read(struc=
t buffer *buf, struct oob_probe_reply *r);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif /* OOB_H */</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/s=
rc/openvpn/ssl=2Ec</span><br><span>index 76150d4=2E=2E2864661 100644</span>=
<br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=
=2Ec</span><br><span>@@ -3705,8 +3705,9 @@</span><br><span>     bool new_li=
nk =3D false;</span><br><span>     struct session_id sid; /* remote session=
 ID */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* verify legal opcode */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (op &lt; P_FIRST_OPCODE || op &gt; P_LAST_OPCODE)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* verify legal opcode=
=2E An out-of-band packet has no control message id and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * no ACK array, which is what we p=
arse next=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (op &lt; P_FIRST_OPCODE || op &gt; P_LAST_OPCODE || opcode_is_oob(op))</=
span><br><span>     {</span><br><span>         if (op =3D=3D P_CONTROL_HARD=
_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)</span><br><sp=
an>         {</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/op=
envpn/ssl_pkt=2Ec</span><br><span>index 90b2aec=2E=2E7f9ce1d27 100644</span=
><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/=
ssl_pkt=2Ec</span><br><span>@@ -168,6 +168,8 @@</span><br><span> {</span><b=
r><span>     ASSERT(ks-&gt;key_id &gt;=3D 0 &amp;&amp; ks-&gt;key_id &lt;=
=3D P_KEY_ID_MASK);</span><br><span>     ASSERT(opcode &gt;=3D 0 &amp;&amp;=
 opcode &lt;=3D P_LAST_OPCODE);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* OOB packets carry no message id or ACK array */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!opcode_is_oob(op=
code));</span><br><span>     uint8_t header =3D (uint8_t)(ks-&gt;key_id | (=
opcode &lt;&lt; P_OPCODE_SHIFT));</span><br><span> </span><br><span>     /*=
 Workaround for Softether servers=2E Softether has a bug that it only</span=
><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</=
span><br><span>index 03e8930=2E=2Ed4fad04 100644</span><br><span>--- a/src/=
openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br=
><span>@@ -58,11 +58,23 @@</span><br><span>  * like P_CONTROL_HARD_RESET_CL=
IENT_V3 */</span><br><span> #define P_CONTROL_WKC_V1 11</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* define the range of =
legal opcodes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Out=
-of-band control message, e=2Eg=2E a server probe=2E Not part of the reliab=
le</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * control channe=
l: no control message id and no ACK array, just a message</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * header and TLVs after the session =
id; never handled by tls_pre_decrypt()=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define P_CONTROL_OOB_V1 12</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* define the range of defined opcodes, in- and out-of-band<=
/span><br><span>  * Since we do no longer support key-method 1 we consider<=
/span><br><span>  * the v1 op codes invalid */</span><br><span> #define P_F=
IRST_OPCODE 3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
P_LAST_OPCODE  11</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine P_LAST_OPCODE  12</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Is op one of=
 the out-of-band opcodes? */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static inline bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+opcode_is_oob(int op)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn op =3D=3D P_CONTROL_OOB_V1;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span> </span><br><span> /*</span><br><span>  * Defi=
ne number of buffers for send and receive in the reliability layer=2E</span=
><br><span>@@ -256,6 +268,9 @@</span><br><span>         case P_CONTROL_WKC_=
V1:</span><br><span>             return &quot;P_CONTROL_WKC_V1&quot;;</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 case P_CONTROL_OOB_V1:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            return &quot;P_CONTROL_OOB_V1&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         case P_ACK_V1:<=
/span><br><span>             return &quot;P_ACK_V1&quot;;</span><br><span> =
</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/test=
s/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 5954902=2E=2Ee6c8f=
b5 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@=
 -157,10 +157,13 @@</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdi=
r)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span> 	@TEST_CFLAGS@=
</span><br><span> pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-pkt_testdriver_SOURCES =3D test_pkt=
=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec test_common=2Eh \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+pkt_testdriver_SOURCES =
=3D test_pkt=2Ec test_oob=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	test_common=
=2Eh \</span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	$(top_srcdir)/src/openvpn/control_msg=2Ec \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/oob=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_s=
rcdir)/src/openvpn/crypto_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/o=
penvpn/crypto_mbedtls=2Ec \</span><br><span>diff --git a/tests/unit_tests/o=
penvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span=
>new file mode 100644</span><br><span>index 0000000=2E=2E656cb21</span><br>=
<span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=
=2Ec</span><br><span>@@ -0,0 +1,381 @@</span><br><span style=3D"color: hsl(=
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
 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Write a probe request TLV=
 and read it back; fields must survive the round</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * trip and the whole buffer must be consumed=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_ro=
undtrip(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const struct oob_probe_request in =3D {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0xdeadbee=
f,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimest=
amp =3D 0x0123456789abcdefULL,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(oob_probe_request_write(&amp;buf, &amp;in));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* header (4) + value (16) *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(BLEN(&amp;buf), 4 + OOB_PROBE_REQUEST_LEN);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* the header codec, read from a copy so the scan below still s=
ees it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer peek =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(ctrl_msg_tlv_read_header(&amp;peek, &amp;=
hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(hdr=2Etype, OOB_TLV_PROBE_REQUEST);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_false(hdr=2Eoptional);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Evalue_len,=
 OOB_PROBE_REQUEST_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buf=
fer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_REQUEST, &amp;value));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BL=
EN(&amp;value), OOB_PROBE_REQUEST_LEN);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct oob_probe_request out =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_read(&amp;value,=
 &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(in=2Erequest_id, out=2Erequest_id);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(in=2Etimestamp =3D=3D out=2Et=
imestamp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(in=2Eflags, out=2Eflags);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* the scan consumed header and value alike */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(=
&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* The probe request wire format is locked to the spec&#39;=
s field order</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (re=
quest_id, timestamp, flags), big-endian=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+test_probe_request_wire_format(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_b=
uf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct o=
ob_probe_request in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        =2Erequest_id =3D 0x11223344,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x0102030405060708ULL,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 0,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reques=
t_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
uint8_t expected[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       0x02, /* TLV type 2 (not optional) */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        0x00,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        0x10, /* TLV value length =3D 16 */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        0x11,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        0x22,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        0x33,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        0x44, /* request_id */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        0x01,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        0x02,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        0x03,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        0x04,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        0x05,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        0x06,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        0x07,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  0x08, /* timestamp */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00, =
/* flags */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
BLEN(&amp;buf), sizeof(expected));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected, sizeof(exp=
ected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Write a probe reply TLV and read it back=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_roundtrip(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
 =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct oob_probe_reply in =3D {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        =2Erequest_id =3D 0x11223344,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        =2Epriority =3D 10,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        =2Eweight =3D 100,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        =2Econnect_lifetime =3D =
30,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags=
 =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Em=
ax_latency_diff =3D 25,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_re=
ply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 4 + OOB_PROBE_REPLY_LEN);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer peek =3D buf;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_head=
er hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(ctrl_msg_tlv_read_header(&amp;peek, &amp;hdr));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, OOB_TLV_=
PROBE_REPLY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(hdr=2Evalue_len, OOB_PROBE_REPLY_LEN);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer value;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PRO=
BE_REPLY, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_=
probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(oob_probe_reply_read(&amp;value, &amp;out));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Er=
equest_id, out=2Erequest_id);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(in=2Epriority, out=2Epriority);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eweight=
, out=2Eweight);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(in=2Econnect_lifetime, out=2Econnect_lifetime);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Efla=
gs, out=2Eflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(in=2Emax_latency_diff, out=2Emax_latency_diff);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&a=
mp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* The probe reply wire format is locked to the spec&#39;s f=
ield order (request_id,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * priority, weight, max_latency_diff, connect_lifetime, flags), big-en=
dian=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_=
wire_format(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct oob_probe_reply in =3D {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0x11223344,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Epriority =
=3D 10,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Ew=
eight =3D 100,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   =2Econnect_lifetime =3D 30,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        =2Eflags =3D 1,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        =2Emax_latency_diff =3D 25,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const uint8_t expected[] =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        0x03, /* TLV type 3 (not optional) */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        0x0e, /* TLV value =
length =3D 14 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     0x11,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0=
x22,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x33,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x44, /* requ=
est_id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x=
00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x0a, /*=
 priority =3D 10 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  0x64, /* weight =3D 100 */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        0x19, /* max_latency_diff =3D 25 */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        0x00,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        0x1e, /* connect_lifetime =3D 30 */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        0x01, /* flags =3D 1 */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), =
sizeof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_memory_equal(BPTR(&amp;buf), expected, sizeof(expected));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A T=
LV with a longer-than-known value must still parse: the known fields are</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * read and the traili=
ng bytes are skipped (forward compatibility)=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_probe_request_forward_compat(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st uint16_t extended_len =3D OOB_PROBE_REQUEST_LEN + 4;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_head=
er(&amp;buf, OOB_TLV_PROBE_REQUEST, false, extended_len));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;b=
uf, 7));          /* request_id */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));          /* tim=
estamp high */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(buf_write_u32(&amp;buf, 0xdeadbeef)); /* timestamp low */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_=
u32(&amp;buf, 0));          /* flags */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0x11223344)); /=
* unknown trailing field */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_REQUEST, &amp;value));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(BLEN(&amp;value), extended_len);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct oob_probe_request out =3D { 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(oob_probe_request_read(&amp;value, &amp;=
out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(out=2Erequest_id, 7);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Efla=
gs, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the u=
nknown trailing field must have been consumed from the payload */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&am=
p;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* A value shorter than the mandatory fields must be rejecte=
d, even when it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * h=
olds enough bytes for some of the individual fields to read successfully=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_too_s=
hort(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* 4 of the 16 mandatory value bytes: enough for the req=
uest_id alone */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(buf_write_u32(&amp;buf, 0xdeadbeef));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct oob_probe_request out =3D { 0 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_probe_request_read=
(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* A TLV header claiming more value bytes than the =
payload holds must be</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * rejected by the scan rather than reported as found -- for the TLV bein=
g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * looked for as m=
uch as for one that would merely be skipped=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_find_tlv_value_truncated(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* the wanted TLV declares 12 value byte=
s, only 4 are present */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_h=
eader(&amp;buf, OOB_TLV_PROBE_REQUEST, false,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                          OOB_PRO=
BE_REQUEST_LEN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(buf_write_u32(&amp;buf, 0xdeadbeef));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(&amp;b=
uf, OOB_TLV_PROBE_REQUEST, &amp;value));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* same defect on a TLV that would be skipped: the scan must not walk=
 past</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the end=
 of the payload looking for the next header */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct buffer buf2 =3D alloc_buf_gc(128, &am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(ctrl_msg_tlv_write_header(&amp;buf2, 0x7ff, false, 64));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;=
buf2, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_false(ctrl_msg_find_tlv(&amp;buf2, OOB_TLV_PROBE_REQUEST, &amp;value));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* Bytes left over after the last TLV that are too few for a header make th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * message malform=
ed, even when the wanted TLV was already found=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_find_tlv_trailing_bytes(void **state)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* 1 to 3 bytes: less than a 4-byte T=
LV header */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for=
 (int trailing =3D 1; trailing &lt;=3D 3; trailing++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct buffer buf =3D alloc_buf_gc(128, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const str=
uct oob_probe_request in =3D { =2Etimestamp =3D 1, =2Eflags =3D 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(oob_pr=
obe_request_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        for (int i =3D 0; i &lt; trailing; i++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            assert_true(buf_write_u8(&=
amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_f=
alse(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_REQUEST, &amp;value));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* An unknown TLV =
marked optional after the wanted one is skipped, and the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * wanted value is still the one retur=
ned=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_skip=
s_optional_after_wanted(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_request in =
=3D { =2Etimestamp =3D 7, =2Eflags =3D 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_write(&amp;buf, &=
amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;=
buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find=
_tlv(&amp;buf, OOB_TLV_PROBE_REQUEST, &amp;value));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), OO=
B_PROBE_REQUEST_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct oob_probe_request out =3D { 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_read(&amp;value=
, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(out=2Etimestamp =3D=3D 7);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* An empty payload holds no TLV=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_empty_payloa=
d(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_R=
EQUEST, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* Reading a TLV header must fail when the buffer ho=
lds less data than a</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * complete 4-byte header (empty, or only the type field), rather than rea=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * past the availa=
ble data=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_head=
er_truncated(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* empty buffer */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_read_header(&amp;buf, &a=
mp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* only the type field pr=
esent, no length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(buf_write_u16(&amp;buf, OOB_TLV_PROBE_REQUEST));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_=
read_header(&amp;buf, &amp;hdr));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* The OOB tests run as a second group o=
f pkt_testdriver; see test_pkt=2Ec=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+run_oob_tests(void)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const str=
uct CMUnitTest tests[] =3D {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_probe_request_roundtrip),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_=
probe_request_wire_format),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_probe_reply_roundtrip),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_pro=
be_reply_wire_format),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_probe_request_forward_compat),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_p=
robe_request_too_short),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_find_tlv_value_truncated),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_fin=
d_tlv_trailing_bytes),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_find_tlv_skips_optional_after_wanted),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_tes=
t(test_find_tlv_empty_payload),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cmocka_unit_test(test_tlv_header_truncated),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return cmocka_run_group_tests_name(&quot;oob tests&quot;=
, tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/te=
sts/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index a732c2b=2E=2E390b=
3f6 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ =
-44,6 +44,8 @@</span><br><span> #include &quot;reliable=2Eh&quot;</span><br=
><span> #include &quot;siphash=2Eh&quot;</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+int run_oob_tests(void); /* test_oob=
=2Ec */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> int</span><br><span> parse_line(const char *line, char **p, const int=
 n, const char *file, const int line_num,</span><br><span>            msglv=
l_t msglevel, struct gc_arena *gc)</span><br><span>@@ -748,5 +750,7 @@</spa=
n><br><span>         cmocka_unit_test(test_extract_control_message)</span><=
br><span>     };</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return cmocka_run_group_tests_name(&quot;pkt tests&quot;, =
tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int failed =3D cmocka_run_group_tests_name(&quot;pkt tests&quot;, tests=
, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
ailed +=3D run_oob_tests();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return failed ? 1 : 0;</span><br><span> }</span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=
=3Demail">change 1741</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 18 </div>
<div style=3D"display:none"> Gerrit-O=
wner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici=
 &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>

</body></html>
--ohdY7cysx+s=--


--===============7208642008286965424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7208642008286965424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7208642008286965424==--

