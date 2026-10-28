Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5616C606A31D
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=U1A1Cz4g;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nJyTXXG0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hOIJ7CT/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ge90jg+l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KGuMxIsoqM79ukpSzpzI2dzb4Vs32YhRbQNZxzxZjCA=; b=U1A1Cz4guJQM1XQoS3od6GUYSd
	dWOjQdPao4kpyxp2T2f5qe8RVfWu984+eeqh4qCh/XKmUFQ1Jy4ymXZAsmIdWRcS/7CtRPxbXv5fx
	uKMBdKSwVRXyMDxZJMiUn0P0NrrnF9roUuC+meWhPKEs46YZHjVkacERDDpZ6F0vWepk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMBbD-000000005LO-2EQN;
	Wed, 28 Oct 2026 21:54:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMBat-000000005Kg-0K4D
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:54:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nFLuGSFwe41YRX/xrhAiy9LiXBuTSrzRm/hx9ripkmc=; b=nJyTXXG08Kbg0u3zFjMlYPTySD
 Zmp5P7xKif5aAG9bOet+Tq+HBgFvxVz7JB/BSzdiRA6dShuslKsqYn0TCqIqQJodAEo3QGJYXdAE0
 /ZnJeHKPV0zMenIwcPZSa+AFZtpQOn4snzn/BW0wasmDopL7d0xw3ETDc34e3XQwinOI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nFLuGSFwe41YRX/xrhAiy9LiXBuTSrzRm/hx9ripkmc=; b=hOIJ7CT/Kmm/o13pCs3Zr+IX0R
 O7FI9Nsxj6990MQa+eB4wFgsvS6C7+AvM9e6GUWqUgSm79qvlwjIml3DELOOBAfYF6zmJ0J7OVxZC
 4DvJtMhWKbzb1eufoJz1Kn8TzC7vpoCyjOyymLvDv4M1Ifqp/UdCh7/KwZFg4/4bTFEM=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMBaa-000000005RK-0Lk4 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:53:51 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so14361915e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 14:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793224417; x=1793829217; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nFLuGSFwe41YRX/xrhAiy9LiXBuTSrzRm/hx9ripkmc=;
 b=Ge90jg+lzlJcLwqC7K2bPjlBSdm5Yj6iVh4oJair3acT3LS9Ph86hF8oQBCvyFaXQh
 R8Gec8CXU+wsf0YQhK8Vh+Nmgm3ywygx2WZ19Q5Li62B0OuKazSI0hlHAHOy15ejBL5M
 gk6qze5fuLlsLJebjd8xMcFqswpvFi+sNnfX8Bv3LaJOQCsDqGu3RMmrIYR5zEStW0gd
 dz4HEyMV+3KjCt0dj5TpqXzESaJRu4bhqQEJPiQrU6vjbB8o8eWK+MYXtffsyVyqTsnL
 4K3NBzjrtu4fB7Jm6lt4td93a5eLiyTIWZGOcpscfUVxQWbi3+sQgEJZjqkL/bJ6OAsX
 kALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793224417; x=1793829217;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nFLuGSFwe41YRX/xrhAiy9LiXBuTSrzRm/hx9ripkmc=;
 b=Xs3SR0eSWpZ413RwnS4PzjyYXoHhMi14MOUj77MCZS1Fn5llcb3J6Gm2HPiORwJF2Q
 Rr8/Fr8S2/RxyzjhhRjfXP8XStuhwn1xTuI3c5K9cJXNIPmn0WXFOOSA+yU/AAhS8NY0
 VBrtQQTmcucor/i+o1qfTqm393U5MH9PN/n3eo8fYZNtpRbwJW/lad2EFCPvPAFuwX/1
 1wJs4W8U1GEaz8/F6NEhYqGCXUqpEUhQXHta19D0zSolmaRU84bndNVP/uvNxD/lSMH9
 GPvvEmX2O8NoCtmN7grN+TlxPz+jOYuNYwIY46JJ/vyQGHu0D8e8HYBTRVCDvzZcCeXJ
 mKLQ==
X-Gm-Message-State: AFq9FYI8CysWk+4rg9mXrFxmQGazh1r0ppZze3SauKrfSzNF/j3mEwSb
 XYV5VRWt7FmAbOwIWh7UOJo/cysxRtg+HCSziAtQ9BGPLtmf+MPISI23We8rRqaj5Q/Zyaep4Av
 fAOIbOnNxMMHMkUvVrwPYMmI4b+yQJ724cYrT3sBWQt/+CqjLzsGdGkpMDrxDhXE+IPQX
X-Gm-Gg: AYBFou1hqYYO1Cf6iz1S2Hs1L+5qbD//PxA/eWxLR4SAaVL5onzySPoYoztufOj24JB
 KP6ohQ6I5Ib9sdu6pb9RnL2/c1CyBcFZVUVjV7MnBRc6uTDvDCcgUG/IhPXUsP87/c1Y4ttMe3r
 zMSbL959XlcLucujLQCbSHqckZuuYCo2+WcKx8sPYAMZkbXl7gv4NuTbKg4Aw0T2wBJOeJcl6wJ
 jHVWVqBJqwTPdUXjLBFUWUDCJZaaaBP2fp1vcBTIh8zrIvurYX7gi6764oM+VDo0csEcMlgmUFL
 pV713DBqUAebZEva/W/LpCudouPMDxYkq6WfDK6N4DGOGbyqbjIqfswsfb2p4a7Lu0aNe+1/Dez
 bYe7HHSV7uAQl/qh05S23PQ37UlhDQZcSlK47QWl1Etk2n7GmC1uQb7mkD91hkVGa0tN1904Hu4
 Zh+s9nh++XJndCtztxY2LsY/6S+tXHU1AnYlT+KvuJMWDVsJwNAbGPgA+s3X6CvkzG9vODK3zek
 YFqoFSv2jYmKUqaKQrt68hJW82ER8QHOsXiQoOuNUjogQrOl8jMLOGMNxUZiJOG0d37Vk+PS64Z
 KxP7DLfP4ZiCFZVH27urRyYWQlCcThf/ygrWBrCcvAP4Did3Cx06GoOj4MNoQp6lzI2Typ12Alg
 lJxBuknaDXS1T8P8ZC03YgoSrf75RU+iWceso+CEOBn7Lr3GRw72W115sMOmdg0CTKTNcs/wJQA
 GgXwKEHxG5jDTSgTs=
X-Received: by 2002:a05:600c:4f89:b0:4a1:d8fc:8165 with SMTP id
 5b1f17b1804b1-4a966f209d9mr81579215e9.20.1793224416380; 
 Wed, 28 Oct 2026 14:53:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a96989ab11sm46516695e9.1.2026.10.28.14.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 14:53:35 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 21:53:33 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: efd3d5c212fef844036b389f8818d6acf9670436
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e4f0dbea802a328cc682b5968bf42d3d6d8c422e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMBaa-000000005RK-0Lk4
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 chugly <charlie.vigue@openvpn.com>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4373918210534674292=="
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4373918210534674292==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jhd8SAUpG2c="; charset=UTF-8

--Jhd8SAUpG2c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd l=
ike you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail

to look at the new patch set (#20)=2E
=

The following approvals got outdated and were removed:
Code-Review-1 by R=
=C4=83zvan Cojocaru


Change subject: Implement sending/receiving app custo=
m control protocol messages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Implement sending/receiving app custom control protocol me=
ssages

This allows openvpn GUI/front-ends and server via management
to use=
 the OpenVPN control channel to pass messages between each other
while Open=
VPN handles the marshalling/unmarshalling of these and
negotiate the common=
 app custom control protocols=2E

This provides an easy to use secure chann=
el that does not depend on
the network itself to work and can also used bef=
ore fully authenticating
the client=2E See the management-notes=2Etxt for m=
ore details how to use
this feature=2E An upcoming patch will also add some=
 example python
script that showcase this feature=2E

Change-Id: I4a6a6ef41=
e15896b8b79d795b2a6de86b8ae4c84
Signed-off-by: Arne Schwabe <arne@rfc2549=
=2Eorg>
---
M CMakeLists=2Etxt
M doc/man-sections/client-options=2Erst
M do=
c/man-sections/management-options=2Erst
M doc/man-sections/script-options=
=2Erst
M doc/management-notes=2Etxt
M src/openvpn/Makefile=2Eam
A src/openv=
pn/acc=2Ec
A src/openvpn/acc=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/in=
it=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/mult=
i=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/pus=
h=2Ec
M src/openvpn/push=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=
=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/mo=
ck_management=2Ec
M tests/unit_tests/openvpn/mock_push_dependencies=2Ec
A t=
ests/unit_tests/openvpn/test_acc=2Ec
A tests/unit_tests/openvpn/test_acc=2E=
h
M tests/unit_tests/openvpn/test_common=2Eh
M tests/unit_tests/openvpn/tes=
t_ssl=2Ec
26 files changed, 1,531 insertions(+), 22 deletions(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1858/20

diff=
 --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 184a95a=2E=2E4deabe7 100=
644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -435,6 +435,8 @@
     =
src/compat/compat-strlcpy=2Ec
     src/compat/compat-strsep=2Ec
     src/co=
mpat/compat-strtok_r=2Ec
+    src/openvpn/acc=2Ec
+    src/openvpn/acc=2Eh
=
     src/openvpn/argv=2Ec
     src/openvpn/argv=2Eh
     src/openvpn/base64=
=2Ec
@@ -826,6 +828,8 @@
             tests/unit_tests/openvpn/mock_managem=
ent=2Ec
             tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
   =
          tests/unit_tests/openvpn/mock_win32_execve=2Ec
+            tests=
/unit_tests/openvpn/test_acc=2Ec
+            src/openvpn/acc=2Ec
         =
    src/openvpn/argv=2Ec
             src/openvpn/base64=2Ec
             s=
rc/openvpn/crypto_epoch=2Ec
@@ -842,6 +846,7 @@
             src/openvpn/pa=
cket_id=2Ec
             src/openvpn/run_command=2Ec
             src/openv=
pn/ssl_mbedtls=2Ec
+            src/openvpn/ssl_ncp=2Ec
             src/op=
envpn/ssl_openssl=2Ec
             src/openvpn/ssl_util=2Ec
             sr=
c/openvpn/ssl_verify_mbedtls=2Ec
diff --git a/doc/man-sections/client-optio=
ns=2Erst b/doc/man-sections/client-options=2Erst
index 87c138a=2E=2E16309f9=
 100644
--- a/doc/man-sections/client-options=2Erst
+++ b/doc/man-sections/=
client-options=2Erst
@@ -437,6 +437,12 @@
         Additional authenticatio=
n methods supported by the client=2E
         This may be set by the client=
 UI/GUI using ``--setenv``=2E
 
+  :code:`IV_ACC=3D<max_msg_len>,<flags>,<p=
rotocols>`
+        If the option ``--app-custom-control`` is set, the clie=
nt will
+        send the supported max ACC message length, the supported f=
ormats
+        as (:code:`A:6`) and the list of configured protocols (e=2E=
g=2E
+        :code:`flower:happy:power`)
+
   The following flags depend o=
n which compression formats are compiled in
   and whether compression is a=
llowed by options=2E See `Protocol options`_
   for more details=2E
diff --=
git a/doc/man-sections/management-options=2Erst b/doc/man-sections/manageme=
nt-options=2Erst
index 2c79d05=2E=2E315e567 100644
--- a/doc/man-sections/m=
anagement-options=2Erst
+++ b/doc/man-sections/management-options=2Erst
@@ =
-144,3 +144,17 @@
 
 --management-up-down
   Report tunnel up/down events t=
o management interface=2E
+
+--app-custom-control protocol-list
+  Sets the=
 list of supported app custom control protocols=2E
+  These protocols are a=
nnounced to the server via the IV_ACC peer info
+  variable when this optio=
n is used on a client=2E
+  If the option is set on a server it will negoti=
ate common protocols
+  with the client=2E
+
+  The protocol-list is a : se=
parated list of protocol identifiers=2E Protocol
+  identifiers must consis=
t of alphanumeric characters, :code:`-`, and
+  :code:`_`=2E
+
+  See manag=
ement-notes=2Etxt in the OpenVPN distribution and the OpenVPN RFC
+  draft =
for a description of app custom control protocol support=2E
diff --git a/do=
c/man-sections/script-options=2Erst b/doc/man-sections/script-options=2Erst=

index f420380f=2E=2E9c17c3b 100644
--- a/doc/man-sections/script-options=
=2Erst
+++ b/doc/man-sections/script-options=2Erst
@@ -1006,3 +1006,12 @@
 =
       X509_1_L=3DBISHKEK
        X509_1_ST=3DNA
        X509_1_C=3DKG
+
+:=
code:`acc_protocols`
+    If ``--app-custom-control`` is configured and the=
 client supports any of the
+    protocols that server also supports, this =
variable contains a list of
+    common protocols separated by :=2E
+
+:cod=
e:`acc_message_len`
+    if :code:`acc_protocols` is set, this variable con=
tains the maximum
+    message length for app custom protocol message=2E
\ =
No newline at end of file
diff --git a/doc/management-notes=2Etxt b/doc/man=
agement-notes=2Etxt
index 4d726c4=2E=2E1a7de8c 100644
--- a/doc/management-=
notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -828,6 +828,58 @@
 that is =
required to continue the connection (unlike MFA or opening a browser)
 this=
 message is not negotiated but can just be sent as a gratuitous message=2E
=
 
+app custom control
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+If the special string "ACC" is passed as {EXTRA} OpenVPN will determin=
e
+the common app custom protocols between the client and the server and in=
struct
+the client that the server will send control messages to the client=
 using
+the ACC protocol=2E
+
+The server should then use client-acc-msg co=
mmand to send app custom
+control messages to the client to facilitate the =
pending authentication=2E
+
+COMMAND -- client-acc-msg (OpenVPN 2=2E8 or hi=
gher)
+-------------------------------------------------
+
+On an OpenVPN i=
nstance running in server mode this command sends an
+app custom control me=
ssage to a client=2E The format of the command is:
+
+  client-acc-msg {CID=
} {KID}
+  {protocol}
+  {flags}
+  {message}
+  END
+
+CID,KID -- client I=
D and Key ID=2E See documentation for ">CLIENT:"
+notification for more inf=
o=2E
+
+protocol -- the ACC protocol identifier that this message should be=

+            tagged with=2E
+
+flags    -- a colon separated list of the e=
ncoding and the flag if
+            the message is a fragment=2E E=2Eg=2E =
"6:F" for a base64 encoded
+            message that is also a fragment and=
 not complete yet=2E
+
+message  -- The message encoded in the encoding spe=
cified in flags
+
+
+COMMAND -- acc-msg (OpenVPN 2=2E8 or higher)
+--------=
----------------------------------
+
+When OpenVPN is running in --client m=
ode this command sends an app
+custom command to the server=2E The format o=
f the command is
+
+  acc-msg
+  {protocol}
+  {flags}
+  {message}
+  END
=
+
+See the client-acc-msg command for more details about the format of the
=
+message=2E Since a client has only one peer there is no need to specify th=
e
+client id and key id=2E
+
+
 COMMAND -- client-deny  (OpenVPN 2=2E1 or h=
igher)
 -----------------------------------------------
 
@@ -1302,6 +1354,=
47 @@
    response=2E Mechanisms that need multiple rounds or more complex =
answers
    should implement a different response type than CR_RESPONSE=2E
=
 
+(6) App custom control message
+
+    This message is an application spe=
cific payload message that is transported
+    over the OpenVPN control cha=
nnel=2E
+
+    In server mode:
+
+    >CLIENT:ACC,{CID},{KID},{protocol},{f=
ragment},{msg_base64}
+
+    In client mode:
+
+    >ACC:{protocol},{fragme=
nt},{msg_base64}
+
+    The protocol is a short ascii string identifying th=
e app specific custom
+    protocol=2E If fragment is set to 1, the message=
 is not complete and the
+    next message should be concatenated to this m=
essage to form a complete
+    message=2E
+
+    Note that the OpenVPN impl=
ementation operates here with the robustness
+    principle ("be conservati=
ve in what you send, be liberal in what you
+    accept" - RFC 793 and othe=
rs) and allows receiving messages longer than
+    maximum allowed message =
length=2E Implementations should be prepared to
+    handle messages that a=
re longer than the maximum allowed message length=2E
+
+
+(7) App custom co=
ntrol protocol message
+
+   This message informs the client about the comm=
on ACC
+   protocols and the maximum message length for an ACC message=2E
+=

+   In client mode:
+
+   >ACC_PROTOCOLS:protocols=3D{protocol_list},messa=
ge_len=3D{max_msg_len}
+
+   protocol_list is the list of supported protoco=
ls by both server and client=2E
+   For example flower:power:sys_info would=
 indicate these three protocols
+   arne supported=2E max_msg_len specifies=
 the maximum message length that the
+   peer supports=2E
+
+   In server m=
ode these information are available in the acc_protocols and
+   acc_messag=
e_len variables of the client environment=2E
 
 Variables:
 
diff --git a/s=
rc/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 8a60a94=2E=2Eebc=
4db6 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam=

@@ -45,6 +45,7 @@
 sbin_PROGRAMS =3D openvpn
 
 openvpn_SOURCES =3D \
+	ac=
c=2Ec acc=2Eh \
 	argv=2Ec argv=2Eh \
 	auth_token=2Ec auth_token=2Eh \
 	b=
ase64=2Ec base64=2Eh \
@@ -124,7 +125,8 @@
 	proto=2Ec proto=2Eh \
 	proxy=
=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \
-	push=2Ec push_util=2Ec push=2Eh \
+	pu=
sh=2Ec push=2Eh \
+	push_util=2Ec \
 	pushlist=2Eh \
 	reflect_filter=2Ec r=
eflect_filter=2Eh \
 	reliable=2Ec reliable=2Eh \
diff --git a/src/openvpn/=
acc=2Ec b/src/openvpn/acc=2Ec
new file mode 100644
index 0000000=2E=2Ee3073=
0b
--- /dev/null
+++ b/src/openvpn/acc=2Ec
@@ -0,0 +1,451 @@
+/*
+ *  OpenV=
PN -- An application to securely tunnel IP networks
+ *             over a =
single TCP/UDP port, with support for SSL/TLS-based
+ *             session=
 authentication and key exchange,
+ *             packet encryption, packet=
 authentication, and
+ *             packet compression=2E
+ *
+ *  Copyrig=
ht (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne =
Schwabe <arne@rfc2549=2Eorg>
+ *
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
f not, write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Stre=
et, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
=
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <strin=
g=2Eh>
+#include "buffer=2Eh"
+#include "error=2Eh"
+#include "acc=2Eh"
+#i=
nclude "forward=2Eh"
+#include "options_util=2Eh"
+#include "ssl_util=2Eh"
=
+#include "ssl_ncp=2Eh"
+#include "multi=2Eh"
+
+enum acc_message_flag
+{
+=
    ACC_MESSAGE_FLAGS_ASCII =3D 1,
+    ACC_MESSAGE_FLAGS_BASE64 =3D 2,
+  =
  ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,
+};
+
+
+static void
+log_acc_message(s=
truct context *c, const struct buffer *buf, int payload_len,
+             =
   const char *protocol, int flags)
+{
+    bool fragment =3D flags & ACC_M=
ESSAGE_FLAGS_FRAGMENT;
+#ifdef ENABLE_MANAGEMENT
+    struct gc_arena gc =
=3D gc_new();
+    const char *payload_msg =3D NULL;
+
+    /* For simplici=
ty, we always encode payload to be base64 encoded
+     * if not already in=
 base64 format */
+    if (flags & ACC_MESSAGE_FLAGS_ASCII)
+    {
+       =
 char *b64out =3D NULL;
+        ASSERT(openvpn_base64_encode(CBPTR(buf), p=
ayload_len, &b64out) >=3D 0);
+        gc_addspecial(b64out, free, &gc);
+ =
       payload_msg =3D b64out;
+    }
+    else
+    {
+        payload_msg=
 =3D CBSTR(buf);
+    }
+
+    if (management)
+    {
+        struct tls_s=
ession *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+        if (=
c->options=2Emode =3D=3D MODE_SERVER)
+        {
+            /* server mod=
e=2E Report client context */
+            struct man_def_auth_context *mda=
 =3D session->opt->mda_context;
+            unsigned int mda_key_id =3D ge=
t_primary_key(c->c2=2Etls_multi)->mda_key_id;
+            msg(M_CLIENT, ">=
CLIENT:ACC,%lu,%u,%s,%d,%s",
+                mda->cid, mda_key_id, protoco=
l, fragment, payload_msg);
+        }
+        else
+        {
+           =
 /* Client mode=2E Do not a report a CLIENT id */
+            msg(M_CLIENT=
, ">ACC:%s,%d,%s", protocol, fragment, payload_msg);
+        }
+    }
+   =
 gc_free(&gc);
+#endif /* ifdef ENABLE_MANAGEMENT */
+    msg(D_PUSH, "Rece=
ived custom app control message (protocol '%s'%s)",
+        protocol, frag=
ment ? ", fragment" : "");
+}
+
+
+/**
+ *  Parses the flags field of an ap=
p control message and moves the
+ *  buffer past the flags string=2E If the=
re is an
+ *  error parsing the flags field the method returns -1 and
+ *  =
puts the error reason in err_reason
+ */
+static int
+parse_acc_message_fla=
gs(struct buffer *buf, const char **err_reason, struct gc_arena *gc)
+{
+  =
  const char *flags =3D buf_extract_field(buf, ',', gc);
+
+    if (!flags)=

+    {
+        *err_reason =3D "could not extract flags field";
+        =
return -1;
+    }
+
+
+    int acc_flags =3D 0;
+
+    for (const char *fla=
g =3D flags; *flag !=3D '\0'; flag++)
+    {
+        if (*flag =3D=3D 'A')=

+        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;
+        }=

+        else if (*flag =3D=3D '6')
+        {
+            acc_flags |=3D=
 ACC_MESSAGE_FLAGS_BASE64;
+        }
+        else if (*flag =3D=3D 'F')
+=
        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_FRAGMENT;
+        =
}
+        else
+        {
+            *err_reason =3D "Unknown flag in fl=
ags";
+            return -1;
+        }
+    }
+    /* The message should =
be encoded with exactly one encoding=2E Ensure that
+     * only one of the=
 flags is present */
+    bool asciienc =3D (bool)(acc_flags & ACC_MESSAGE_=
FLAGS_ASCII);
+    bool base64enc =3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_=
BASE64);
+
+    if (base64enc + asciienc !=3D 1)
+    {
+        char *tmp =
=3D gc_malloc(512, 1, gc);
+        snprintf(tmp, 512, "number of encodings=
 must be exactly one "
+                           "(B64=3D%d, ASCII=3D%d)"=
,
+                 base64enc, asciienc);
+        *err_reason =3D tmp;
+  =
      return -1;
+    }
+
+    return acc_flags;
+}
+
+
+void
+receive_acc_=
message(struct context *c, const struct buffer *buffer)
+{
+    struct gc_a=
rena gc =3D gc_new();
+    const char *err_reason =3D "";
+
+    /* Example=
 message: ACC,muppets,15,A,I am Miss Piggy */
+    struct buffer buf =3D *b=
uffer;
+
+    const struct tls_multi *multi =3D c->c2=2Etls_multi;
+    if =
(!multi->acc_negotiated_protocols)
+    {
+        err_reason =3D "ACC not =
enabled or no negotiated protocols";
+        goto err;
+    }
+
+    if (!=
buf_advance(&buf, strlen("ACC")) || buf_read_u8(&buf) !=3D ',')
+    {
+   =
     err_reason =3D "missing , after ACC";
+        goto err;
+    }
+
+   =
 /* extract protocol, payload length, flags substrings */
+    const char *=
protocol =3D buf_extract_field(&buf, ',', &gc);
+    if (!protocol)
+    {
=
+        err_reason =3D "could not extract protocol field";
+        goto e=
rr;
+    }
+
+    if (!tls_item_in_cipher_list(protocol, multi->acc_negotia=
ted_protocols))
+    {
+        struct buffer msg_buf =3D alloc_buf_gc(1024=
, &gc);
+        buf_printf(&msg_buf, "protocol '%s' not in list of negotia=
ted protocols '%s'",
+                   protocol, multi->acc_negotiated_pr=
otocols);
+        err_reason =3D buf_cstr(&msg_buf);
+
+
+        goto err=
;
+    }
+
+    /* We do not check the length here=2E We make no promises t=
o support
+     * anything larger than our announced message length but acc=
ording to
+     * the robustness principle
+     * ("be conservative in wha=
t you send, be liberal in what you accept" - RFC 793 and others)
+     * we=
 accept also longer messages */
+
+    int payload_len;
+    const char *pa=
yload_len_str =3D buf_extract_field(&buf, ',', &gc);
+    if (!payload_len_=
str
+        || !atoi_constrained(payload_len_str, &payload_len, "acc_paylo=
ad_len", 0, TLS_CHANNEL_BUF_SIZE - 1, D_PUSH_ERRORS))
+    {
+        err_r=
eason =3D "could not extract payload length field";
+        goto err;
+   =
 }
+
+    int flags =3D parse_acc_message_flags(&buf, &err_reason, &gc);
+
=
+    if (flags < 0)
+    {
+        goto err;
+    }
+
+    /* We should ha=
ve a final NUL byte in the control message buffer
+     * and thus the leng=
th of the buffer should be payload_len + 1 */
+    if (buf_len(&buf) !=3D p=
ayload_len + 1)
+    {
+        char *tmp =3D gc_malloc(512, 1, &gc);
+    =
    snprintf(tmp, 512, "field length %d, payload length %d mismatch",
+    =
             payload_len, buf_len(&buf) - 1);
+        err_reason =3D tmp;
=
+        goto err;
+    }
+
+
+    log_acc_message(c, &buf, payload_len, pr=
otocol, flags);
+    gc_free(&gc);
+    return;
+
+err:
+    msg(D_PUSH_ERR=
ORS, "WARNING: Received malformed custom app control channel "
+           =
            "message (%s): %s",
+        err_reason,
+        format_hex(CB=
PTR(buffer), BLEN(buffer), 80, &gc));
+    gc_free(&gc);
+}
+
+
+bool
+send=
_acc_message(struct context *c,
+                 struct tls_multi *multi,
=
+                 struct tls_session *session,
+                 const char=
 *protocol, bool fragment,
+                 const char *msg, bool base64)
=
+{
+    /*
+     * length of the protocol string + one ','
+     * 2 for th=
e encoding (A or 6), potential F (fragment), and 1 for the ',',
+     * 4 f=
or the message size itself and one comma
+     * 1 for the comma before the=
 message itself */
+    const size_t max_header_size =3D strlen("ACC,") + s=
trlen(protocol) + 1 + 4 + 1 + 2 + 1;
+    size_t len =3D max_header_size + =
strlen(msg);
+
+    if (len > TLS_CHANNEL_BUF_SIZE)
+    {
+        msg(M_C=
LIENT, "message length (%zu) exceeds maximum possible message length (%d)",=
 len, TLS_CHANNEL_BUF_SIZE);
+        return false;
+    }
+
+    if ((int)=
len > multi->acc_max_message_length)
+    {
+        msg(M_CLIENT, "header =
(%zu) + message size (%zu) length (%zu) exceeds "
+                      "m=
aximum allowed length negotiated with peer (%d)",
+            max_header_s=
ize, strlen(msg), len,
+            multi->acc_max_message_length);
+      =
  return false;
+    }
+
+    struct gc_arena gc =3D gc_new();
+    /* add =
1 for the final \0 */
+    struct buffer buf =3D alloc_buf_gc(len + 1, &gc)=
;
+
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */
+    buf_p=
rintf(&buf, "ACC,%s,%zu,%s%s,%s", protocol,
+               strlen(msg),
+ =
              base64 ? "6" : "A",
+               fragment ? "F" : "",
+   =
            msg);
+
+    bool ret =3D send_control_channel_string_dowork(se=
ssion, BSTR(&buf), D_PUSH);
+    reschedule_multi_process(c);
+    gc_free(=
&gc);
+    return ret;
+}
+
+char *
+parse_acc_parameters(const char *capab=
ilities,
+                     const char *delim,
+                     int=
 *max_acc_len,
+                     bool server,
+                     str=
uct gc_arena *gc)
+{
+    char *tmp_message =3D string_alloc(capabilities, =
NULL);
+    char *tmp_message_orig =3D tmp_message;
+    char *lasts =3D NU=
LL;
+
+    const char *token =3D strtok_r(tmp_message, delim, &lasts);
+
+ =
   int p =3D 0;
+    int acclen =3D 0;
+    const char *protocols =3D NULL;=

+    char *ret =3D NULL;
+
+    /* In server mode we allow more capabiliti=
es than our own, in client
+     * mode we reject if we should use capabili=
ties that we do not support */
+    int allowed_acc_len =3D server ? INT_MA=
X : ACC_MAX_MSG_LEN;
+
+    while (token)
+    {
+        if (p =3D=3D 0 &&=
 !atoi_constrained(token, &acclen, "ACC message length", ACC_MIN_MSG_LEN, a=
llowed_acc_len, D_PUSH_ERRORS))
+        {
+            goto done;
+       =
 }
+
+        if (p =3D=3D 1 && (!tls_item_in_cipher_list("A", token) || !t=
ls_item_in_cipher_list("6", token)))
+        {
+            msg(D_PUSH_ERR=
ORS, "App custom control encoding must include base64 and ascii");
+       =
     goto done;
+        }
+
+        if (p =3D=3D 1 && !server && strcmp(t=
oken, "A:6") && strcmp(token, "6:A"))
+        {
+            msg(D_PUSH_ER=
RORS, "App custom control encoding must exactly base64 and ascii");
+      =
      goto done;
+        }
+
+        if (p =3D=3D 2)
+        {
+        =
    protocols =3D token;
+        }
+
+        if (p =3D=3D 3)
+        {
+=
            msg(D_PUSH_ERRORS, "Too many parameters for INFO ACC message/IV=
_ACC=2E");
+            goto done;
+        }
+
+        token =3D strtok_r=
(NULL, delim, &lasts);
+        p++;
+    }
+
+    *max_acc_len =3D min_int=
(acclen, ACC_MAX_MSG_LEN);
+    ret =3D string_alloc(protocols, gc);
+
+don=
e:
+    free(tmp_message_orig);
+    return ret;
+}
+
+struct buffer
+get_l=
ist_intersection(struct gc_arena *gc, const char *list1, const char *list2)=

+{
+    char *tmp =3D string_alloc(list1, NULL);
+    char *lasts =3D NULL=
;
+    const char *token =3D strtok_r(tmp, ":", &lasts);
+
+    /* The maxi=
mum possible length is the shorter of the two input lists */
+    size_t ma=
x_len =3D min_size(strlen(list1), strlen(list2));
+
+    struct buffer comm=
on_protocols =3D alloc_buf_gc(max_len + 1, gc);
+
+    while (token)
+    {=

+        /* check for every items is in both lists and not already in the
=
+         * common list */
+        if (tls_item_in_cipher_list(token, list=
2)
+            && !tls_item_in_cipher_list(token, buf_cstr(&common_protoco=
ls)))
+        {
+            if (buf_len(&common_protocols) > 0)
+        =
    {
+                buf_write_u8(&common_protocols, ':');
+            }=

+            buf_printf(&common_protocols, "%s", token);
+        }
+     =
   token =3D strtok_r(NULL, ":", &lasts);
+    }
+    free(tmp);
+    retur=
n common_protocols;
+}
+
+void
+determine_common_acc_protocols(struct tls_m=
ulti *multi, struct tls_session *session)
+{
+    if (!multi->opt=2Eacc_pro=
tocols)
+    {
+        /* No app custom protocols have been configured ser=
ver-side=2E */
+        return;
+    }
+
+    if (multi->acc_negotiated_pro=
tocols)
+    {
+        /* We already have determined the common protocols=
=2E */
+        return;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+ =
   /* example IV_ACC: IV_ACC=3D2048,6:A,flower:power */
+    const char *pe=
er_info =3D multi->peer_info;
+    const char *iv_acc =3D extract_var_peer_=
info(peer_info, "IV_ACC=3D", &gc);
+    if (!iv_acc)
+    {
+        gc_fre=
e(&gc);
+        return;
+    }
+
+    int max_acc_len =3D 0;
+    const ch=
ar *protocols =3D parse_acc_parameters(iv_acc, ",", &max_acc_len, true, &gc=
);
+
+    if (!protocols)
+    {
+        gc_free(&gc);
+        msg(D_PUSH=
_ERRORS, "WARNING: IV_ACC peer info variable of peer is malformed");
+     =
   return;
+    }
+
+    struct buffer common_protocols =3D get_list_inters=
ection(&gc, multi->opt=2Eacc_protocols, protocols);
+
+    if (buf_len(&com=
mon_protocols) =3D=3D 0)
+    {
+        msg(D_PUSH_DEBUG, "WARNING: No com=
mon app custom control protocol=2E");
+        gc_free(&gc);
+        retur=
n;
+    }
+
+    multi->acc_negotiated_protocols =3D string_alloc(buf_str(&=
common_protocols), NULL);
+    multi->acc_max_message_length =3D max_acc_le=
n;
+
+    setenv_str(session->opt->es, "acc_protocols", multi->acc_negotiat=
ed_protocols);
+    setenv_int(session->opt->es, "acc_message_len", multi->=
acc_max_message_length);
+
+    gc_free(&gc);
+}
+
+void
+notify_client_acc=
_protocols(struct tls_multi *multi)
+{
+#ifdef ENABLE_MANAGEMENT
+    if (m=
anagement)
+    {
+        msg(M_CLIENT, ">ACC_PROTOCOLS:protocols=3D%s,mes=
sage_len=3D%d",
+            multi->acc_negotiated_protocols, multi->acc_ma=
x_message_length);
+    }
+#endif
+}
diff --git a/src/openvpn/acc=2Eh b/src=
/openvpn/acc=2Eh
new file mode 100644
index 0000000=2E=2E2fe9efd
--- /dev/n=
ull
+++ b/src/openvpn/acc=2Eh
@@ -0,0 +1,113 @@
+/*
+ *  OpenVPN -- An appl=
ication to securely tunnel IP networks
+ *             over a single TCP/UD=
P port, with support for SSL/TLS-based
+ *             session authenticati=
on and key exchange,
+ *             packet encryption, packet authenticati=
on, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2025 O=
penVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne=
@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can redistr=
ibute it and/or modify
+ *  it under the terms of the GNU General Public Li=
cense version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ =
*  This program is distributed in the hope that it will be useful,
+ *  but=
 WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTAB=
ILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Publ=
ic License for more details=2E
+ *
+ *  You should have received a copy of =
the GNU General Public License along
+ *  with this program; if not, write =
to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Flo=
or, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef ACC_H
+#define ACC_H
+
+#i=
nclude "openvpn=2Eh"
+
+#define ACC_MIN_MSG_LEN 64
+#define ACC_MAX_MSG_LEN=
 1280
+
+/**
+ * This method parses an app custom control message and deliv=
ers it to the
+ * management interface=2E We leave reassembly of fragmented=
 messages to the
+ * management interface=2E
+ *
+ * @param c            Th=
e context struct
+ * @param buffer       Buffer containing the control mess=
age with ACC
+ */
+void
+receive_acc_message(struct context *c, const struc=
t buffer *buffer);
+
+
+bool
+send_acc_message(struct context *c,
+        =
         struct tls_multi *tls_multi,
+                 struct tls_session =
*session,
+                 const char *protocol, bool fragment,
+         =
        const char *msg, bool base64);
+
+
+/**
+ * Parses an info message =
from the server that contains app custom control info
+ * information prior=
 to the PUSH_REPLY to be able to use app custom control
+ * protocols befor=
e sending
+ *
+ * In client mode only allow what we support ourselves=2E In=
 server mode
+ * allow also capabilities that we not support ourselves=2E
+=
 *
+ * @param capabilities      The string to parse
+ * @param delim       =
      The delimiter to use when parsing the string=2E
+ *                  =
        IV_ACC uses "," as delimiter while the
+ *                         =
 custom-control PUSH message uses " " as "," is
+ *                        =
  already used to separate different push directives
+ * @param max_acc_len=
       Set to the maximum ACC message length
+ * @param server            W=
hether we are server or client
+ * @param gc                The gc arena to=
 use for allocating the resulting string
+ * @return                  The r=
esulting protocol string or NULL on error
+ */
+char *
+parse_acc_parameter=
s(const char *capabilities,
+                     const char *delim,
+     =
                int *max_acc_len,
+                     bool server,
+     =
                struct gc_arena *gc);
+
+/**
+ * Parses the IV_ACC of the p=
eer and sets multi=2Eacc_negotiated_protocols
+ * to the common protocols o=
f server and client and
+ * multi=2Eacc_max_message_length  to the maximum =
length of the ACC message
+ * support by both server and client=2E
+ *
+ * =
If there is no common protocol or the client does not support any app custo=
m
+ * protocol multi=2Eacc_negotiated_protocols will be set to NULL=2E
+ *
=
+ * @param multi      the multi instance to use the set the app custom prot=
ocols=2E
+ * @param session    the session to read the client env from
+ */=

+void
+determine_common_acc_protocols(struct tls_multi *multi, struct tls_=
session *session);
+
+/**
+ * Calculates the intersection of two list that =
are both separated by :
+ * Items in the result will have the same ordering=
 as in the list1
+ * parameters
+ * @param gc            Returned buffer wi=
ll be allocated in this gc
+ * @param list1         First list to intersect=

+ * @param list2         Second list to intersect=2E
+ * @return A (potent=
ially empty) buffer containing an intersection list
+ */
+struct buffer
+ge=
t_list_intersection(struct gc_arena *gc, const char *list1, const char *lis=
t2);
+
+/**
+ * Notifies a client via management interface of the negotiate=
d app
+ * custom protocols
+ * @param multi the tls_multi instance of the c=
onnection
+ */
+void
+notify_client_acc_protocols(struct tls_multi *multi);=

+#endif
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
ind=
ex 681210d=2E=2E7923b5e 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/open=
vpn/forward=2Ec
@@ -42,6 +42,7 @@
 #include "dco=2Eh"
 #include "auth_token=
=2Eh"
 #include "tun_afunix=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2E=
h"
 
@@ -257,11 +258,11 @@
     }
     else if (buf_string_match_head_str(b=
uf, "INFO_PRE"))
     {
-        server_pushed_info(buf, 8);
+        serve=
r_pushed_info(c, buf, 8);
     }
     else if (buf_string_match_head_str(bu=
f, "INFO"))
     {
-        server_pushed_info(buf, 4);
+        server_pus=
hed_info(c, buf, 4);
     }
     else if (buf_string_match_head_str(buf, "C=
R_RESPONSE"))
     {
@@ -271,6 +272,10 @@
     {
         receive_auth_pend=
ing(c, buf);
     }
+    else if (buf_string_match_head_str(buf, "ACC"))
+ =
   {
+        receive_acc_message(c, buf);
+    }
     else if (buf_string_=
match_head_str(buf, "EXIT"))
     {
         receive_exit_message(c);
diff =
--git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 1b8b2a5=2E=2Ee0b9=
9a4 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -56,6 +=
56,7 @@
 #include "schedule=2Eh"
 #include "options_string=2Eh"
 #include "=
resolve=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -2279,6 +228=
0,13 @@
         }
     }
 
+    struct tls_multi *multi =3D c->c2=2Etls_mu=
lti;
+    if (multi && multi->acc_negotiated_protocols)
+    {
+        buf=
_printf(&out, " custom-control %d A:6 %s",
+                   multi->acc_m=
ax_message_length, multi->acc_negotiated_protocols);
+    }
+
     if (BLEN=
Z(&out) > strlen(header))
     {
         msg(D_HANDSHAKE, "%s", BSTR(&out)=
);
@@ -2522,6 +2530,11 @@
         flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS)=
;
     }
 
+    if (c->options=2Eacc_protocols)
+    {
+        flags |=3D =
OPT_P_ACC;
+    }
+
     return flags;
 }
 
@@ -2730,6 +2743,18 @@
        =
 frame->tun_mtu =3D min_int(frame->tun_max_mtu, c->options=2Ece=2Etun_mtu);=

     }
 
+    if (found & OPT_P_ACC && c->options=2Epushed_acc_negotiated_=
protocols)
+    {
+        struct tls_multi *multi =3D c->c2=2Etls_multi;
+=
        free(multi->acc_negotiated_protocols);
+        multi->acc_negotiat=
ed_protocols =3D string_alloc(c->options=2Epushed_acc_negotiated_protocols,=
 NULL);
+        multi->acc_max_message_length =3D c->options=2Epushed_acc_=
max_message_length;
+
+        msg(D_PUSH, "OPTIONS IMPORT: ACC protocols: =
%s, msg len: %d",
+            multi->acc_negotiated_protocols, multi->acc_=
max_message_length);
+        notify_client_acc_protocols(multi);
+    }
+
=
     return true;
 }
 
@@ -3352,6 +3377,7 @@
     to=2Everify_hash_depth =
=3D options->verify_hash_depth;
     to=2Everify_hash_no_ca =3D options->ve=
rify_hash_no_ca;
     memcpy(to=2Ex509_username_field, options->x509_userna=
me_field, sizeof(to=2Ex509_username_field));
+    to=2Eacc_protocols =3D op=
tions->acc_protocols;
     to=2Ees =3D c->c2=2Ees;
     to=2Enet_ctx =3D &c=
->net_ctx;
 
@@ -4306,6 +4332,24 @@
 }
 #endif /* ifdef TARGET_ANDROID */
 =

+static bool
+management_acc_msg(void *arg,
+                   struct buf=
fer_list *input) /* ownership transferred */
+{
+    struct context *c =3D =
arg;
+
+    bool ret =3D false;
+    if (buffer_list_defined(input) && c->c=
2=2Etls_multi)
+    {
+        struct tls_multi *multi =3D c->c2=2Etls_mult=
i;
+        struct tls_session *session =3D &multi->session[TM_ACTIVE];
+
+=
        ret =3D management_send_acc_message(c, multi, session, input);
+   =
 }
+
+    buffer_list_free(input);
+    return ret;
+}
 #endif /* ifdef ENA=
BLE_MANAGEMENT */
 
 void
@@ -4322,6 +4366,7 @@
         cb=2Eproxy_cmd =3D=
 management_callback_proxy_cmd;
         cb=2Eremote_cmd =3D management_cal=
lback_remote_cmd;
         cb=2Esend_cc_message =3D management_callback_sen=
d_cc_message;
+        cb=2Eacc_msg =3D management_acc_msg;
 #ifdef TARGET_=
ANDROID
         cb=2Enetwork_change =3D management_callback_network_change=
;
 #endif
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
inde=
x ac3d4b7=2E=2E5e4e416 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvp=
n/manage=2Ec
@@ -45,9 +45,11 @@
 #include "push=2Eh"
 #include "multi=2Eh"
=
 #include "resolve=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 #incl=
ude "run_command=2Eh"
+#include "ssl_ncp=2Eh"
 
 #ifdef ENABLE_PKCS11
 #inc=
lude "pkcs11=2Eh"
@@ -1081,6 +1083,35 @@
             }
             break;=

 
+        case IEC_CLIENT_ACC_MSG:
+            if (man->persist=2Ecallba=
ck=2Eclient_acc_msg)
+            {
+                bool status =3D (*man-=
>persist=2Ecallback=2Eclient_acc_msg)(man->persist=2Ecallback=2Earg,
+     =
                                                                 man->conne=
ction=2Ein_extra_cid,
+                                                    =
                  man->connection=2Ein_extra_kid,
+                        =
                                              man->connection=2Ein_extra);
=
+                man->connection=2Ein_extra =3D NULL;
+                repo=
rt_command_status(status, "client-acc-msg");
+            }
+            el=
se
+            {
+                man_command_unsupported("client-acc-msg"=
);
+            }
+            break;
+
+        case IEC_ACC_MSG:
+       =
     if (man->persist=2Ecallback=2Eacc_msg)
+            {
+               =
 bool status =3D (*man->persist=2Ecallback=2Eacc_msg)(man->persist=2Ecallba=
ck=2Earg,
+                                                               m=
an->connection=2Ein_extra);
+                man->connection=2Ein_extra =3D=
 NULL;
+                report_command_status(status, "acc-msg");
+        =
    }
+            else
+            {
+                man_command_unsuppo=
rted("acc-msg");
+            }
+            break;
         case IEC_PK_SI=
GN:
             man->connection=2Eext_key_state =3D EKS_READY;
           =
  buffer_list_free(man->connection=2Eext_key_input);
@@ -1205,6 +1236,29 @@=

 }
 
 static void
+man_client_acc_msg(struct management *man, const char *=
cid_str,
+                   const char *kid_str)
+{
+    struct man_connec=
tion *mc =3D &man->connection;
+    mc->in_extra_cid =3D 0;
+    mc->in_ext=
ra_kid =3D 0;
+    if (parse_cid(cid_str, &mc->in_extra_cid)
+        && pa=
rse_uint(kid_str, "KID", &mc->in_extra_kid))
+    {
+        mc->in_extra_c=
md =3D IEC_CLIENT_ACC_MSG;
+        in_extra_reset(mc, IER_NEW);
+    }
+}
=
+
+static void
+man_acc_msg(struct management *man)
+{
+    struct man_conn=
ection *mc =3D &man->connection;
+    mc->in_extra_cmd =3D IEC_ACC_MSG;
+  =
  in_extra_reset(mc, IER_NEW);
+}
+
+static void
 man_client_auth(struct ma=
nagement *man, const char *cid_str, const char *kid_str, const bool extra)
=
 {
     struct man_connection *mc =3D &man->connection;
@@ -1759,6 +1813,17=
 @@
             man_client_pending_auth(man, p[1], p[2], p[3], p[4]);
    =
     }
     }
+    else if (streq(p[0], "client-acc-msg"))
+    {
+        =
if (man_need(p, 2, 0))
+        {
+            man_client_acc_msg(man, p[1]=
, p[2]);
+        }
+    }
+    else if (streq(p[0], "acc-msg"))
+    {
+  =
      man_acc_msg(man);
+    }
     else if (streq(p[0], "rsa-sig"))
     {=

         man_pk_sig(man, "rsa-sig");
@@ -2975,7 +3040,9 @@
               =
                         "bytes_sent=3D",
                                 =
       "bytes_received=3D",
                                        "sessio=
n_id=3D",
-                                       "session_state=3D" };
+  =
                                     "session_state=3D",
+                 =
                      "acc_protocols=3D",
+                                =
       "acc_message_len=3D" };
 
     if (env_filter_level =3D=3D 0)
     {=

@@ -3130,6 +3197,7 @@
     }
 }
 
+
 void
 management_connection_establish=
ed(struct management *man, struct man_def_auth_context *mdac,
             =
                      const struct env_set *es)
@@ -4372,6 +4440,64 @@
    =
 }
 }
 
+bool
+management_send_acc_message(struct context *c, struct tls_mu=
lti *multi, struct tls_session *session,
+                            struc=
t buffer_list *input)
+{
+    /* also ensures that are enough inputs in the=
 list to safely call
+     * buffer_list_peek without extra NULL checks */
=
+    if (!input || input->size < 3)
+    {
+        msg(M_CLIENT, "not enou=
gh input lines for sending acc message, "
+                      "missing p=
rotocol, flag and/or messages lines");
+        return false;
+    }
+
+   =
 struct gc_arena gc =3D gc_new();
+
+    const struct buffer *proto_buf =3D=
 buffer_list_peek(input);
+    const char *protocol =3D string_alloc(CBSTR(=
proto_buf), &gc);
+    buffer_list_pop(input);
+
+    struct buffer *encodi=
ng_buf =3D buffer_list_peek(input);
+    char *encoding =3D buf_str(encodin=
g_buf);
+    const char *flag =3D NULL;
+    bool b64encoding =3D false;
+ =
   bool fragment =3D false;
+
+    while ((flag =3D strsep(&encoding, ":"))=
)
+    {
+        if (!strcmp(flag, "6"))
+        {
+            b64encodi=
ng =3D true;
+        }
+        else if (!strcmp(flag, "F"))
+        {
+ =
           fragment =3D true;
+        }
+    }
+    buffer_list_pop(input)=
;
+
+    buffer_list_aggregate_separator(input, 10000, "");
+    const stru=
ct buffer *acc_msg_buf =3D buffer_list_peek(input);
+
+    if (!multi->acc_=
negotiated_protocols
+        || !tls_item_in_cipher_list(protocol, multi->=
acc_negotiated_protocols))
+    {
+        msg(M_CLIENT, "protocol not in t=
he list of negotiated protocols: %s",
+            np(multi->acc_negotiated=
_protocols));
+        goto error;
+    }
+
+    bool ret =3D send_acc_mess=
age(c, multi, session, protocol,
+                                fragment,=
 buf_cstr(acc_msg_buf),
+                                b64encoding);
+   =
 gc_free(&gc);
+    return ret;
+error:
+    gc_free(&gc);
+    return fals=
e;
+}
 #else /* ifdef ENABLE_MANAGEMENT */
 
 #include "win32=2Eh"
diff --g=
it a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 157039d=2E=2Ecc9=
c264 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -1=
84,12 +184,19 @@
     int (*n_clients)(void *arg);
     bool (*send_cc_mess=
age)(void *arg, const char *message, const char *parameter);
     bool (*ki=
ll_by_cid)(void *arg, const unsigned long cid, const char *kill_msg);
+
   =
  bool (*client_auth)(void *arg, const unsigned long cid, const unsigned in=
t mda_key_id,
                         const bool auth, const char *reason,=
 const char *client_reason,
                         struct buffer_list *cc=
_config); /* ownership transferred */
     bool (*client_pending_auth)(void=
 *arg, const unsigned long cid, const unsigned int kid,
                   =
              const char *extra, unsigned int timeout);
     char *(*get_pe=
er_info)(void *arg, const unsigned long cid);
+    bool (*client_acc_msg)(v=
oid *arg,
+                           const unsigned long cid,
+           =
                const unsigned int mda_key_id,
+                           =
struct buffer_list *msg);
+    bool (*acc_msg)(void *arg,
+                =
    struct buffer_list *msg);
     bool (*proxy_cmd)(void *arg, const char =
**p);
     bool (*remote_cmd)(void *arg, const char **p);
 #ifdef TARGET_AN=
DROID
@@ -292,13 +299,15 @@
     struct command_line *in;
     struct buffe=
r_list *out;
 
-#define IEC_UNDEF       0
-#define IEC_CLIENT_AUTH 1
+#defi=
ne IEC_UNDEF          0
+#define IEC_CLIENT_AUTH    1
 /* #define IEC_CLIEN=
T_PF   2 *REMOVED FEATURE* */
-#define IEC_RSA_SIGN    3
-#define IEC_CERTI=
FICATE 4
-#define IEC_PK_SIGN     5
-#define IEC_PASSWORD    6
+#define IEC=
_RSA_SIGN       3
+#define IEC_CERTIFICATE    4
+#define IEC_PK_SIGN       =
 5
+#define IEC_PASSWORD       6
+#define IEC_CLIENT_ACC_MSG 7
+#define IEC=
_ACC_MSG        8
     int in_extra_cmd;
     struct buffer_list *in_extra;=

     unsigned long in_extra_cid;
@@ -503,6 +512,14 @@
 
 void man_persist_=
client_stats(struct management *man, struct context *c);
 
+/** Parses the =
ACC message from the input buffer_list and send to the
+ * session identifi=
ed by session and multi
+ */
+struct tls_session;
+struct tls_multi;
+bool
=
+management_send_acc_message(struct context *c, struct tls_multi *multi,
+ =
                           struct tls_session *session, struct buffer_list =
*input);
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /**
diff --git a/src/open=
vpn/multi=2Ec b/src/openvpn/multi=2Ec
index e302a81=2E=2Ea3eb3ca 100644
---=
 a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -53,6 +53,7 @@
 #in=
clude "ssl_util=2Eh"
 #include "dco=2Eh"
 #include "reflect_filter=2Eh"
+#i=
nclude "acc=2Eh"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -4085,6 +4086,2=
6 @@
     }
 }
 
+static const char *
+calculate_app_control_extra(struct m=
ulti_instance *mi, struct gc_arena *gc)
+{
+    struct context *c =3D &mi->=
context;
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+
+    if (!mu=
lti->acc_negotiated_protocols)
+    {
+        msg(M_CLIENT, "ACC: No negot=
iated protocols");
+        return NULL;
+    }
+
+    struct buffer buf =
=3D alloc_buf_gc(1024, gc);
+
+    buf_printf(&buf, "ACC:%d A:6 %s", multi-=
>acc_max_message_length,
+               multi->acc_negotiated_protocols);
=
+    return buf_str(&buf);
+}
+
+
 static bool
 management_client_pending_a=
uth(void *arg, const unsigned long cid, const unsigned int mda_key_id,
    =
                            const char *extra, unsigned int timeout)
@@ -40=
95,10 +4116,22 @@
     if (mi)
     {
         struct tls_multi *multi =3D =
mi->context=2Ec2=2Etls_multi;
+
+        struct gc_arena gc =3D gc_new();
+=
        if (!strcmp(extra, "ACC"))
+        {
+            extra =3D calcul=
ate_app_control_extra(mi, &gc);
+            if (!extra)
+            {
+  =
              gc_free(&gc);
+                return false;
+            }
+=
        }
         struct tls_session *session =3D lookup_session_by_mda_ke=
y_id(multi, mda_key_id);
 
         if (!session)
         {
+            g=
c_free(&gc);
             return false;
         }
 
@@ -4106,6 +4139,7 @@
=
         bool ret =3D send_auth_pending_messages(multi, session, extra, tim=
eout);
         reschedule_multi_process(&mi->context);
         multi_sche=
dule_context_wakeup(m, mi);
+        gc_free(&gc);
         return ret;
   =
  }
     return false;
@@ -4149,6 +4183,37 @@
     return ret;
 }
 
+
+stat=
ic bool
+management_client_acc_msg(void *arg,
+                          co=
nst unsigned long cid,
+                          const unsigned int mda_ke=
y_id,
+                          struct buffer_list *input) /* ownership tr=
ansferred */
+{
+    struct multi_context *m =3D (struct multi_context *)ar=
g;
+    struct multi_instance *mi =3D lookup_by_cid(m, cid);
+
+    bool re=
t =3D false;
+    if (mi && buffer_list_defined(input))
+    {
+        str=
uct tls_multi *multi =3D mi->context=2Ec2=2Etls_multi;
+        struct tls_=
session *session =3D lookup_session_by_mda_key_id(multi, mda_key_id);
+    =
    if (!session)
+        {
+            msg(M_CLIENT, "client session not=
 found");
+            buffer_list_free(input);
+            return false;
=
+        }
+
+        ret =3D management_send_acc_message(&mi->context, mul=
ti, session, input);
+        multi_schedule_context_wakeup(m, mi);
+    }
=
+
+    buffer_list_free(input);
+    return ret;
+}
+
+
 static char *
 man=
agement_get_peer_info(void *arg, const unsigned long cid)
 {
@@ -4185,6 +42=
50,7 @@
         cb=2En_clients =3D management_callback_n_clients;
        =
 cb=2Ekill_by_cid =3D management_kill_by_cid;
         cb=2Eclient_auth =3D=
 management_client_auth;
+        cb=2Eclient_acc_msg =3D management_client=
_acc_msg;
         cb=2Eclient_pending_auth =3D management_client_pending_a=
uth;
         cb=2Eget_peer_info =3D management_get_peer_info;
         cb=
=2Epush_update_broadcast =3D management_callback_send_push_update_broadcast=
;
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index fb31=
9ae=2E=2E4b14e10 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/opt=
ions=2Ec
@@ -35,6 +35,7 @@
 
 #include "syshead=2Eh"
 
+#include "acc=2Eh"
=
 #include "buffer=2Eh"
 #include "error=2Eh"
 #include "common=2Eh"
@@ -255=
2,6 +2553,8 @@
     o->push_option_types_found =3D 0;
     o->push_update_o=
ptions_found =3D 0;
     o->imported_protocol_flags =3D 0;
+    o->pushed_a=
cc_max_message_length =3D 0;
+    o->pushed_acc_negotiated_protocols =3D NU=
LL;
 }
 
 static void
@@ -7107,6 +7110,47 @@
         VERIFY_PERMISSION(OPT=
_P_GENERAL);
         options->force_key_material_export =3D true;
     }
+=
    else if (streq(p[0], "app-custom-control") && p[1] && !p[2])
+    {
+  =
      VERIFY_PERMISSION(OPT_P_GENERAL);
+        if (!string_class(p[1], CC=
_ALNUM | CC_COLON | CC_UNDERBAR | CC_DASH, 0))
+        {
+            msg(=
msglevel, "App custom control protocols must only contain "
+              =
            "alphanumeric characters, '-', and '_'=2E");
+            goto =
err;
+        }
+        options->acc_protocols =3D p[1];
+    }
+    else =
if (streq(p[0], "custom-control") && p[1] && p[2] && p[3] && !p[4])
+    {
=
+        VERIFY_PERMISSION(OPT_P_ACC);
+
+        /* check if the list from=
 the server is a real subset of our list */
+        struct gc_arena gc_loc=
al =3D gc_new();
+        struct buffer common_list =3D get_list_intersecti=
on(&gc_local, p[3], options->acc_protocols);
+
+        if (buf_len(&common=
_list) =3D=3D 0 || !streq(p[3], buf_cstr(&common_list)))
+        {
+      =
      msg(msglevel, "App custom control list from server contains "
+      =
                    "unsupported protocols");
+            gc_free(&gc_loca=
l);
+            goto err;
+        }
+        gc_free(&gc_local);
+
+     =
   if (!streq(p[2], "A:6") && !streq(p[2], "6:A"))
+        {
+            =
msg(msglevel, "App custom control encoding must be base64 and ascii");
+   =
         goto err;
+        }
+
+        if (!atoi_constrained(p[1], &optio=
ns->pushed_acc_max_message_length,
+                              "app cust=
om message message length", ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))
+ =
       {
+            goto err;
+        }
+        options->pushed_acc_neg=
otiated_protocols =3D p[3];
+    }
     else if (streq(p[0], "prng") && p[1=
] && !p[3])
     {
         msg(M_WARN, "NOTICE: --prng option ignored (SSL=
 library PRNG is used)");
diff --git a/src/openvpn/options=2Eh b/src/openvp=
n/options=2Eh
index 6a3bf61=2E=2Eb7945e0 100644
--- a/src/openvpn/options=
=2Eh
+++ b/src/openvpn/options=2Eh
@@ -715,6 +715,18 @@
     /* force using=
 TLS key material export for data channel key generation */
     bool force=
_key_material_export;
 
+    /** The app custom control protocols we should=
 announce as supported */
+    const char *acc_protocols;
+
+    /** the pr=
otocols that are negotiated with the peer=2E This is a
+     *  a temporary=
 variable since options=2Ec push parser cannot access
+     *  tls multi st=
ruct */
+    const char *pushed_acc_negotiated_protocols;
+
+    /** the ma=
ximum length of an ACC control channel message via push message
+     * */
=
+    int pushed_acc_max_message_length;
+
     bool vlan_tagging;
     enum=
 vlan_acceptable_frames vlan_accept;
     uint16_t vlan_pvid;
@@ -764,8 +77=
6,10 @@
 #define OPT_P_INLINE          (1u << 29)
 #define OPT_P_PUSH_MTU  =
      (1u << 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
+#define OPT_P_A=
CC             (1ull << 32)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OP=
T_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))
+/* Options allowed in the normal =
configuration file (vs pushed options or in ccd files) */
+#define OPT_P_DE=
FAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 =
#define PULL_DEFINED(opt) ((opt)->pull)
 
diff --git a/src/openvpn/push=2Ec=
 b/src/openvpn/push=2Ec
index 42259c3=2E=2Edc8c885 100644
--- a/src/openvpn=
/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -27,6 +27,8 @@
 #include "syshead=
=2Eh"
 
 #include "push=2Eh"
+
+#include "acc=2Eh"
 #include "options=2Eh"
=
 #include "crypto=2Eh"
 #include "ssl=2Eh"
@@ -221,9 +223,55 @@
 #endif
 }
=
 
+static void
+parse_server_pushed_info_acc(struct context *c, struct buff=
er *buf)
+{
+    int max_acc_len =3D 0;
+    struct tls_multi *multi =3D c-=
>c2=2Etls_multi;
+
+    if (multi->acc_negotiated_protocols)
+    {
+      =
  return;
+    }
+
+    if (!multi->opt=2Eacc_protocols)
+    {
+        ms=
g(D_PUSH_ERRORS, "Server tried to push app custom control list "
+         =
                  "without client announcing support for it");
+        ret=
urn;
+    }
+
+    /* example string to parse: ACC:1400 A:6 flower:happy */=

+    /* Skip over the ACC: prefix */
+    buf_advance(buf, 4);
+
+    stru=
ct gc_arena gc =3D gc_new();
+    const char *protocols =3D parse_acc_param=
eters(buf_cstr(buf), " ", &max_acc_len, false, &gc);
+    if (!protocols)
+=
    {
+        msg(D_PUSH_ERRORS, "WARNING: Received ACC info command with =
invalid parameters");
+        gc_free(&gc);
+        return;
+    }
+
+   =
 /* check if the list from the server is a real subset of our list */
+    =
struct buffer common_list =3D get_list_intersection(&gc, protocols, multi->=
opt=2Eacc_protocols);
+
+    if (buf_len(&common_list) =3D=3D 0 || !streq(p=
rotocols, buf_cstr(&common_list)))
+    {
+        msg(D_PUSH_ERRORS, "App =
custom control list from server contains "
+                           "uns=
upported protocols");
+        gc_free(&gc);
+        return;
+    }
+
+   =
 multi->acc_negotiated_protocols =3D string_alloc(protocols, NULL);
+    mu=
lti->acc_max_message_length =3D max_acc_len;
+    notify_client_acc_protoco=
ls(multi);
+}
 
 void
-server_pushed_info(const struct buffer *buffer, cons=
t int adv)
+server_pushed_info(struct context *c, const struct buffer *buff=
er, const int adv)
 {
     const char *m =3D "";
     struct buffer buf =3D=
 *buffer;
@@ -233,6 +281,12 @@
         m =3D BSTR(&buf);
     }
 
+    if =
(strncmp(m, "ACC:", 4) =3D=3D 0)
+    {
+        parse_server_pushed_info_a=
cc(c, &buf);
+        return;
+    }
+
 #ifdef ENABLE_MANAGEMENT
     struc=
t gc_arena gc;
     if (management)
@@ -285,6 +339,7 @@
     msg(D_PUSH, "C=
R response was sent by client ('%s')", m);
 }
 
+
 /**
  * Parse the keywor=
d for the AUTH_PENDING request
  * @param buffer                buffer cont=
aining the keywords, the buffer's
@@ -441,7 +496,6 @@
     const char *cons=
t peer_info =3D tls_multi->peer_info;
     unsigned int proto =3D extract_i=
v_proto(peer_info);
 
-
     /* Calculate the maximum timeout and subtract =
the time we already waited */
     unsigned int max_timeout =3D
         ma=
x_uint(tls_multi->opt=2Erenegotiate_seconds / 2, tls_multi->opt=2Ehandshake=
_window);
@@ -732,6 +786,12 @@
                 client_max_mtu, o->ce=2Etun=
_mtu, o->ce=2Etun_mtu);
         }
     }
+
+    if (tls_multi->acc_negotia=
ted_protocols)
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "cus=
tom-control %d A:6 %s",
+                        tls_multi->acc_max_message=
_length, tls_multi->acc_negotiated_protocols);
+    }
 }
 
 static bool
dif=
f --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index 39302f6=2E=2Eb6=
695bc 100644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -52,6=
 +52,7 @@
 
 int process_incoming_push_request(struct context *c);
 
+
 /**=

  * @brief Handles the receiving of a push-update message and applies upda=
tes to the specified
  * options=2E
@@ -92,7 +93,7 @@
 
 void receive_exit_=
message(struct context *c);
 
-void server_pushed_info(const struct buffer =
*buffer, const int adv);
+void server_pushed_info(struct context *c, const =
struct buffer *buffer, const int adv);
 
 void receive_cr_response(struct c=
ontext *c, const struct buffer *buffer);
 
diff --git a/src/openvpn/ssl=2Ec=
 b/src/openvpn/ssl=2Ec
index 086a6fc=2E=2E0a25149 100644
--- a/src/openvpn/=
ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -55,6 +55,7 @@
 
 #include "crypto_epo=
ch=2Eh"
 #include "ssl=2Eh"
+#include "acc=2Eh"
 #include "ssl_verify=2Eh"
=
 #include "ssl_backend=2Eh"
 #include "ssl_ncp=2Eh"
@@ -1279,6 +1280,7 @@
 =
    free(multi->locked_cn);
     free(multi->locked_username);
     free(mu=
lti->locked_original_username);
+    free(multi->acc_negotiated_protocols);=

 
     cert_hash_free(multi->locked_cert_hash_set);
 
@@ -2098,6 +2100,11 =
@@
 #endif
         }
 
+        if (session->opt->acc_protocols)
+        =
{
+            buf_printf(&out, "IV_ACC=3D%d,6:A,%s\n", ACC_MAX_MSG_LEN, se=
ssion->opt->acc_protocols);
+        }
+
         if (session->opt->push_pe=
er_info_detail > 1)
         {
             struct env_set *es =3D session-=
>opt->es;
@@ -2398,6 +2405,8 @@
         multi->remote_ciphername =3D strin=
g_alloc("none", NULL);
     }
 
+    determine_common_acc_protocols(multi, =
session);
+
     if (username_len < 0 || password_len < 0)
     {
         =
msg(D_TLS_ERRORS, "TLS Error: Username (%d) or password (%d) too long", abs=
(username_len),
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_c=
ommon=2Eh
index 9a55ead=2E=2E436770b 100644
--- a/src/openvpn/ssl_common=2E=
h
+++ b/src/openvpn/ssl_common=2Eh
@@ -457,6 +457,9 @@
     size_t ekm_size=
;
 
     bool dco_enabled; /**< Whether keys have to be installed in DCO or=
 not */
+
+    /** The app custom control protocols we should announce as s=
upported */
+    const char *acc_protocols;
 };
 
 /** @addtogroup control_=
processor
@@ -730,6 +733,12 @@
     int dco_peer_id;
 
     dco_context_t *=
dco;
+
+    /** the protocols that are negotiated with the peer=2E */
+    =
char *acc_negotiated_protocols;
+
+    /** the maximum length of an ACC con=
trol channel message */
+    int acc_max_message_length;
 };
 
 /**  gets a=
n item  of \c key_state objects in the
diff --git a/tests/unit_tests/openvp=
n/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 43a6743=2E=
=2E6a73e1e 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/=
unit_tests/openvpn/Makefile=2Eam
@@ -107,10 +107,12 @@
 	@TEST_CFLAGS@
 ssl=
_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdr=
iver_SOURCES =3D test_ssl=2Ec \
+	test_acc=2Ec test_acc=2Eh \
 	mock_msg=2E=
c mock_msg=2Eh test_common=2Eh \
 	mock_management=2Ec \
 	mock_ssl_depende=
ncies=2Ec mock_win32_execve=2Ec \
 	$(top_srcdir)/src/compat/compat-strlcpy=
=2Ec \
+	$(top_srcdir)/src/openvpn/acc=2Ec \
 	$(top_srcdir)/src/openvpn/ar=
gv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openv=
pn/buffer=2Ec \
@@ -132,6 +134,7 @@
 	$(top_srcdir)/src/openvpn/run_command=
=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \
 	$(top_srcdir)/src/op=
envpn/ssl_mbedtls=2Ec \
+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \
 	$(top_s=
rcdir)/src/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_mb=
edtls=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \
diff --git=
 a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/openvpn/=
mock_management=2Ec
index fff4c2b=2E=2Ef572dbb 100644
--- a/tests/unit_test=
s/openvpn/mock_management=2Ec
+++ b/tests/unit_tests/openvpn/mock_managemen=
t=2Ec
@@ -29,6 +29,7 @@
 
 #include "syshead=2Eh"
 
+#include <stdlib=2Eh>
=
 #include "manage=2Eh"
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/tests/unit_=
tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn/mock_pu=
sh_dependencies=2Ec
index bf2ccf3=2E=2Ef083f89 100644
--- a/tests/unit_test=
s/openvpn/mock_push_dependencies=2Ec
+++ b/tests/unit_tests/openvpn/mock_pu=
sh_dependencies=2Ec
@@ -43,7 +43,8 @@
     uint64_t flags =3D OPT_P_UP | OP=
T_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
                      | =
OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
    =
                  | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | O=
PT_P_PULL_MODE
-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PU=
SH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+                     | OPT_P_PEER_ID=
 | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS
+              =
       | OPT_P_ACC;
     return flags;
 }
 
diff --git a/tests/unit_tests/o=
penvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec
new file mode 1=
00644
index 0000000=2E=2Edde1ad8
--- /dev/null
+++ b/tests/unit_tests/openv=
pn/test_acc=2Ec
@@ -0,0 +1,358 @@
+/*
+ *  OpenVPN -- An application to sec=
urely tunnel IP networks
+ *             over a single TCP/UDP port, with s=
upport for SSL/TLS-based
+ *             session authentication and key exc=
hange,
+ *             packet encryption, packet authentication, and
+ *   =
          packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sa=
les@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg=
>
+ *
+ *
+ *  This program is free software; you can redistribute it and/o=
r modify
+ *  it under the terms of the GNU General Public License version =
2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This progra=
m is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY W=
ARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNE=
SS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for=
 more details=2E
+ *
+ *  You should have received a copy of the GNU Genera=
l Public License along
+ *  with this program; if not, write to the Free So=
ftware Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA=
 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#en=
dif
+
+#include "syshead=2Eh"
+
+#include <stdio=2Eh>
+#include <stdlib=2Eh=
>
+#include <stdarg=2Eh>
+#include <string=2Eh>
+#include <setjmp=2Eh>
+#in=
clude <cmocka=2Eh>
+
+#include "acc=2Eh"
+#include "test_acc=2Eh"
+#include=
 "test_common=2Eh"
+
+#include "mock_msg=2Eh"
+#include "multi=2Eh"
+
+char=
 control_channel_message_sent[2048];
+
+/* Mock functions */
+bool
+send_co=
ntrol_channel_string_dowork(struct tls_session *session,
+                 =
                  const char *str, unsigned int msglevel)
+{
+    assert_in=
t_in_range(strlen(str), 0, 2047);
+
+    strcpy(control_channel_message_sen=
t, str);
+    return true;
+}
+
+void
+send_push_reply_auth_token(struct tl=
s_multi *multi)
+{
+}
+
+void
+auth_set_client_reason(struct tls_multi *mul=
ti, const char *reason)
+{
+}
+
+#define MSG_PAYLOAD "FgMBARkBAAEVAwNanUalk=
EDDxLBpZw9JnjI3tBM"                \
+                    "r4engpg/cDgS48DM=
axyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS" \
+                    "4md4OJwoQAw=
EwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP" \
+                    "AJwBnw=
ArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH" \
+                    "Q=
AXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc" \
+                 =
   "ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA" \
+            =
        "AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ" \
+       =
             "93rQwityP9eKSijXgcQ=3D=3D"
+
+void
+test_acc_parse_client_mes=
sages(void **state)
+{
+#ifndef ENABLE_MANAGEMENT
+    skip();
+#else
+    =
/* ensure that the messages get to mock_msg */
+    x_debug_level =3D 3;
+ =
   management =3D (void *)0x12345678;
+    struct gc_arena gc =3D gc_new();=

+
+    /* contains a TLS 1=2E3 ClientHello */
+    const char msg[] =3D "A=
CC,cck1,384,6," MSG_PAYLOAD;
+
+    struct buffer msg_buf;
+    struct cont=
ext c =3D { 0 };
+    c=2Eoptions=2Emode =3D MODE_SERVER;
+
+    ALLOC_OBJ_=
CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &gc);
+
+    c=2Ec2=2Etls_mu=
lti->session[TM_ACTIVE]=2Eopt =3D &c=2Ec2=2Etls_multi->opt;
+    c=2Ec2=2Et=
ls_multi->session[TM_ACTIVE]=2Eopt->mda_context =3D &c=2Ec2=2Emda_context;
=
+    buf_set_read(&msg_buf, (void *)msg, sizeof(msg));
+
+    receive_acc_m=
essage(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "WARNING: Rece=
ived malformed custom app control channel message (ACC not enabled or no ne=
gotiated protocols): 4143432c 63636b31 2c333834 2c362c46 674d4241 526b4241 =
41455641 774e616[more=2E=2E=2E]");
+    assert_string_equal(mock_managment_=
buf, "");
+
+    c=2Ec2=2Etls_multi->acc_negotiated_protocols =3D "no:commo=
n:protocol";
+    receive_acc_message(&c, &msg_buf);
+    assert_string_equ=
al(mock_msg_buf, "WARNING: Received malformed custom app control channel me=
ssage (protocol 'cck1' not in list of negotiated protocols 'no:common:proto=
col'): 4143432c 63636b31 2c333834 2c362c46 674d4241 526b4241 41455641 774e6=
16[more=2E=2E=2E]");
+    assert_string_equal(mock_managment_buf, "");
+
+ =
   c=2Ec2=2Etls_multi->acc_negotiated_protocols =3D "cck1:flower:power:fort=
une";
+    receive_acc_message(&c, &msg_buf);
+
+    assert_string_equal(mo=
ck_msg_buf, "Received custom app control message (protocol 'cck1')");
+    =
assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,cck1,0," MSG_PAYLO=
AD);
+
+    const char flower_msg[] =3D "ACC,flower,48,6,SSBhbSAAIEtlcm1pdC=
D//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)fl=
ower_msg, sizeof(flower_msg));
+    receive_acc_message(&c, &msg_buf);
+   =
 assert_string_equal(mock_msg_buf, "Received custom app control message (pr=
otocol 'flower')");
+    assert_string_equal(mock_managment_buf, ">CLIENT:A=
CC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D");
+
+=
    CLEAR(mock_managment_buf);
+    const char msg_incorrect_len[] =3D "ACC=
,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9I=
g=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_incorrect_len, sizeof(msg=
_incorrect_len));
+    receive_acc_message(&c, &msg_buf);
+    const char *=
error =3D "WARNING: Received malformed custom app control channel "
+      =
                  "message (field length 62, payload length 64 mismatch): "=

+                        "4143432c 666f7274 756e652c 36322c36 2c496e73 674=
96d31 "
+                        "6c496a6f 67496d5[more=2E=2E=2E]";
+
+    =
assert_string_equal(mock_msg_buf, error);
+    assert_string_equal(mock_man=
agment_buf, "");
+
+    CLEAR(mock_managment_buf);
+    const char msg_frag=
ment[] =3D "ACC,power,12,6F,aGVsbG8gdw=3D=3D";
+    buf_set_read(&msg_buf, =
(void *)msg_fragment, sizeof(msg_fragment));
+    receive_acc_message(&c, &=
msg_buf);
+    assert_string_equal(mock_msg_buf, "Received custom app contr=
ol message (protocol 'power', fragment)");
+    assert_string_equal(mock_ma=
nagment_buf, ">CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D");
+
+    CLEAR(mock=
_managment_buf);
+    /* check two encoding present */
+    const char flow=
er_msg_two_encs[] =3D "ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oC=
PZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)flower_msg_two_encs=
, sizeof(flower_msg_two_encs));
+    receive_acc_message(&c, &msg_buf);
+
+=
    error =3D "WARNING: Received malformed custom app control channel messa=
ge "
+            "(number of encodings must be exactly one (B64=3D1, ASCII=
=3D1)): "
+            "4143432c 666c6f77 65722c34 382c3641 2c535342 686253=
41 41494574 "
+            "6c636d3[more=2E=2E=2E]";
+
+    assert_string_e=
qual(mock_msg_buf, error);
+    assert_string_equal(mock_managment_buf, "")=
;
+
+    /* no encoding present */
+    const char flower_msg_no_encs[] =3D=
 "ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+  =
  buf_set_read(&msg_buf, (void *)flower_msg_no_encs, sizeof(flower_msg_no_e=
ncs));
+    receive_acc_message(&c, &msg_buf);
+
+    error =3D "WARNING: R=
eceived malformed custom app control channel message "
+            "(numbe=
r of encodings must be exactly one (B64=3D0, ASCII=3D0)): "
+            "4=
143432c 666c6f77 65722c34 382c2c53 53426862 53414149 45746c63 "
+          =
  "6d31706[more=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
=
+    assert_string_equal(mock_managment_buf, "");
+
+    x_debug_level =3D =
0;
+    management =3D NULL;
+    gc_free(&gc);
+#endif
+}
+
+void
+test_pa=
rse_acc_parameters(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+=
    /* parameters to INFO message */
+    const char *info_acc_msg =3D "409=
6 A:6 flower:happy";
+
+    int max_len =3D 0;
+    const char *protocols =
=3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    asse=
rt_string_equal(protocols, "flower:happy");
+    assert_int_equal(max_len, =
1280);
+
+    /* a client does not accept a length longer than it supports =
*/
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, fal=
se, &gc);
+    assert_null(protocols);
+
+    /* message with lower limit t=
han our, should work for client and server */
+    info_acc_msg =3D "1111 A=
:6 flower:happy";
+    protocols =3D parse_acc_parameters(info_acc_msg, " "=
, &max_len, false, &gc);
+    assert_string_equal(protocols, "flower:happy"=
);
+    assert_int_equal(max_len, 1111);
+
+    protocols =3D parse_acc_par=
ameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(p=
rotocols, "flower:happy");
+    assert_int_equal(max_len, 1111);
+
+    /* =
more encodings than supported=2E Server should be okay, client should fail =
*/
+    info_acc_msg =3D "1200 A:6:B flower:happy";
+    protocols =3D pars=
e_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null=
(protocols);
+
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &=
max_len, true, &gc);
+    assert_string_equal(protocols, "flower:happy");
+=
    assert_int_equal(max_len, 1200);
+
+    /* extra parameter */
+    info=
_acc_msg =3D "1400 A:6 flower:happy 77";
+    protocols =3D parse_acc_param=
eters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_null(protocols);=

+
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, fal=
se, &gc);
+    assert_null(protocols);
+
+
+    const char *iv_acc_capabili=
ties =3D "1400,A:6,flower:happy:power";
+    protocols =3D parse_acc_parame=
ters(iv_acc_capabilities, ",", &max_len, true, &gc);
+    assert_string_equ=
al(protocols, "flower:happy:power");
+
+    /* too small protocol length */=

+    info_acc_msg =3D "32 A:6 flower:happy";
+    protocols =3D parse_acc_=
parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_null(protoc=
ols);
+
+    /* non-numerical protocol length */
+    info_acc_msg =3D "abf=
f A:6 flower:happy";
+    protocols =3D parse_acc_parameters(info_acc_msg, =
" ", &max_len, true, &gc);
+    assert_null(protocols);
+
+    /* extra par=
ameter */
+    info_acc_msg =3D "1400 A:6 flower:happy 77";
+    protocols =
=3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    asse=
rt_null(protocols);
+
+    gc_free(&gc);
+}
+
+void
+test_acc_common_protoc=
ols(void **state)
+{
+    struct multi_instance mi =3D { 0 };
+    struct c=
ontext *c =3D &mi=2Econtext;
+    c->options=2Egc =3D gc_new();
+
+    ALLO=
C_OBJ_CLEAR_GC(c->c2=2Etls_multi, struct tls_multi, &c->options=2Egc);
+
+ =
   c->c2=2Etls_multi->peer_info =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flo=
wer:happy:power";
+    c->options=2Eacc_protocols =3D "power:flower:star";
=
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+    multi->opt=2Eacc_p=
rotocols =3D c->options=2Eacc_protocols;
+    multi->session[TM_ACTIVE]=2Eo=
pt =3D &multi->opt;
+    multi->opt=2Ees =3D env_set_create(&c->options=2Eg=
c);
+
+    determine_common_acc_protocols(multi, &c->c2=2Etls_multi->sessio=
n[TM_ACTIVE]);
+
+    assert_int_equal(multi->acc_max_message_length, ACC_M=
AX_MSG_LEN);
+    assert_string_equal(multi->acc_negotiated_protocols, "pow=
er:flower");
+
+    assert_string_equal(env_set_get(multi->opt=2Ees, "acc_p=
rotocols"), "acc_protocols=3Dpower:flower");
+    assert_string_equal(env_s=
et_get(multi->opt=2Ees, "acc_message_len"), "acc_message_len=3D1280");
+
+ =
   free(multi->acc_negotiated_protocols);
+    gc_free(&c->options=2Egc);
+=
}
+
+void
+test_acc_send_message(void **state)
+{
+    struct multi_instanc=
e mi =3D { 0 };
+    struct context *c =3D &mi=2Econtext;
+    c->options=
=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_multi, struct tls=
_multi, &c->options=2Egc);
+    bool ret;
+    struct tls_multi *multi =3D =
c->c2=2Etls_multi;
+    c->options=2Eacc_protocols =3D "power:flower:emerge=
ncy";
+    multi->opt=2Eacc_protocols =3D c->options=2Eacc_protocols;
+    =
multi->session[TM_ACTIVE]=2Eopt =3D &multi->opt;
+    multi->opt=2Ees =3D e=
nv_set_create(&c->options=2Egc);
+
+    c->c2=2Etls_multi->peer_info =3D "I=
V_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:power";
+    determine_c=
ommon_acc_protocols(multi, &c->c2=2Etls_multi->session[TM_ACTIVE]);
+
+    =
struct tls_session *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+=
    ret =3D send_acc_message(c, c->c2=2Etls_multi, session, "emergency", tr=
ue,
+                           "EMERGENCY BROADCAST MESSAGE - THIS IS NOT =
A DRILL:", false);
+
+    assert_true(ret);
+    assert_string_equal(contro=
l_channel_message_sent,
+                        "ACC,emergency,50,AF,EMERG=
ENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:");
+
+    ret =3D send_acc_me=
ssage(c, c->c2=2Etls_multi, session, "emergency", false,
+                 =
          "THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=
=2E", false);
+    assert_true(ret);
+    assert_string_equal(control_chann=
el_message_sent,
+                        "ACC,emergency,65,A,THE GOVERNMEN=
T HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E");
+
+
+    /* test =
a long message (> 1000) with fragment to get the maximum header size */
+  =
  char long_message[1200] =3D { 0 };
+
+    for (int i =3D 0; i < 1024; i++=
)
+    {
+        long_message[i] =3D (char)(' ' + (i % 95));
+    }
+
+   =
 /* last char of the message is a i and then a \0 */
+    assert_int_equal(=
long_message[1023], 'i');
+    assert_int_equal(long_message[1024], '\0');
=
+
+    ret =3D send_acc_message(c, c->c2=2Etls_multi, session, "emergency",=
 true,
+                           long_message, false);
+
+    assert_true=
(ret);
+    size_t cc_len =3D strlen(control_channel_message_sent);
+    as=
sert_int_equal(control_channel_message_sent[cc_len - 1], 'i');
+    const c=
har *expected_start_cc =3D "ACC,emergency,1024,AF, !\"#$%&'()*+,-=2E/012345=
";
+    assert_memory_equal(control_channel_message_sent, expected_start_cc=
, strlen(expected_start_cc));
+
+    free(multi->acc_negotiated_protocols);=

+    gc_free(&c->options=2Egc);
+}
+
+void
+test_list_intersection(void **=
state)
+{
+    const char *empty =3D "";
+    const char *protos =3D "power=
:flower:emergency";
+
+    struct gc_arena gc =3D gc_new();
+
+    struct b=
uffer t1 =3D get_list_intersection(&gc, empty, protos);
+    assert_int_equ=
al(buf_len(&t1), 0);
+
+    struct buffer t2 =3D get_list_intersection(&gc,=
 protos, empty);
+    assert_int_equal(buf_len(&t2), 0);
+
+    struct buff=
er t3 =3D get_list_intersection(&gc, protos, protos);
+    assert_string_eq=
ual(buf_cstr(&t3), protos);
+
+    const char *protos2 =3D "flower:emergenc=
y:power:mario";
+    struct buffer t4 =3D get_list_intersection(&gc, protos=
2, protos);
+    assert_string_equal(buf_cstr(&t4), "flower:emergency:power=
");
+
+    const char *protos3 =3D "super:paper:mario:flower";
+    struct =
buffer t5 =3D get_list_intersection(&gc, protos2, protos3);
+    assert_str=
ing_equal(buf_cstr(&t5), "flower:mario");
+
+    const char *proto4 =3D "fl=
ower:flower:flower:flower";
+    struct buffer t6 =3D get_list_intersection=
(&gc, proto4, "flower");
+    assert_string_equal(buf_cstr(&t6), "flower");=

+
+
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_acc=
=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh
new file mode 100644
index 000=
0000=2E=2E32421fb
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc=2Eh=

@@ -0,0 +1,35 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP =
networks
+ *             over a single UDP port, with support for SSL/TLS-b=
ased
+ *             session authentication and key exchange,
+ *          =
   packet encryption, packet authentication, and
+ *             packet com=
pression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2En=
et>
+ *
+ *  This program is free software; you can redistribute it and/or =
modify
+ *  it under the terms of the GNU General Public License version 2
=
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This program =
is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WAR=
RANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS=
 FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for m=
ore details=2E
+ *
+ *  You should have received a copy of the GNU General =
Public License along
+ *  with this program; if not, see <https://www=2Egnu=
=2Eorg/licenses/>=2E
+ */
+
+
+#ifndef TEST_ACC_H
+#define TEST_ACC_H
+void=
 test_acc_parse_client_messages(void **state);
+
+void test_parse_acc_param=
eters(void **state);
+
+void test_acc_common_protocols(void **state);
+
+vo=
id test_acc_send_message(void **state);
+
+void test_list_intersection(void=
 **state);
+#endif
diff --git a/tests/unit_tests/openvpn/test_common=2Eh b/=
tests/unit_tests/openvpn/test_common=2Eh
index 8db4ea6=2E=2Ec865142 100644
=
--- a/tests/unit_tests/openvpn/test_common=2Eh
+++ b/tests/unit_tests/openv=
pn/test_common=2Eh
@@ -43,11 +43,13 @@
 #define LargestIntegralType uintmax=
_t
 #endif
 /* redefine 2=2Ex API in terms of 1=2Ex API */
-#define CMockaV=
alueData             LargestIntegralType
-#define check_expected_uint      =
   check_expected
-#define expect_uint_value           expect_value
-#defin=
e expect_check_data           expect_check
-#define cast_ptr_to_cmocka_valu=
e(x) (x)
+#define CMockaValueData                       LargestIntegralType=

+#define check_expected_uint                   check_expected
+#define exp=
ect_uint_value                     expect_value
+#define expect_check_data =
                    expect_check
+#define cast_ptr_to_cmocka_value(x)      =
     (x)
+#define assert_int_in_range(value, min, max)  assert_in_range((va=
lue), (min), (max))
+#define assert_uint_in_range(value, min, max) assert_i=
n_range((value), (min), (max))
 #endif
 
 /**
diff --git a/tests/unit_tests=
/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index 4baf8cc=
=2E=2E4987dd0 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/test=
s/unit_tests/openvpn/test_ssl=2Ec
@@ -52,6 +52,8 @@
 #include "ssl_verify=
=2Eh"
 #include "openvpn=2Eh"
 
+#include "test_acc=2Eh"
+
 /* Mock functio=
n to be allowed to include win32=2Ec which is required for
  * getting the =
temp directory */
 #ifdef _WIN32
@@ -86,6 +88,20 @@
 {
     return;
 }
+voi=
d
+reschedule_multi_process(struct context *c)
+{
+}
+
+/* Define a dummy d=
co cipher option to avoid linking against all the DCO
+ * units */
+#if def=
ined(ENABLE_DCO)
+const char *
+dco_get_supported_ciphers(void)
+{
+    ret=
urn "AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+}=

+#endif
 
 /* generated using
  * openssl req -x509 -newkey ec -pkeyopt ec=
_paramgen_curve:secp384r1 -keyout - \
@@ -1111,8 +1127,12 @@
         cmock=
a_unit_test(ssl_test_extract_last_matching_field),
         cmocka_unit_tes=
t(ssl_test_reject_null_in_cert_subject),
         cmocka_unit_test(ssl_test=
_escape_rfc_2253_chars_in_subject),
-        cmocka_unit_test(ssl_test_extr=
act_peer_info)
-
+        cmocka_unit_test(ssl_test_extract_peer_info),
+  =
      cmocka_unit_test(test_acc_parse_client_messages),
+        cmocka_uni=
t_test(test_parse_acc_parameters),
+        cmocka_unit_test(test_acc_commo=
n_protocols),
+        cmocka_unit_test(test_acc_send_message),
+        cm=
ocka_unit_test(test_list_intersection)
     };
 
 #if defined(ENABLE_CRYPTO=
_OPENSSL)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
58?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpat=
chset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a=
6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-Patc=
hSet: 20
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Rev=
iewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue@op=
envpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>

--Jhd8SAUpG2c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #20</strong> to this ch=
ange=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?us=
p=3Demail">View Change</a></p><p>The following approvals got outdated and w=
ere removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Impleme=
nt sending/receiving app custom control protocol messages<br><br>This allow=
s openvpn GUI/front-ends and server via management<br>to use the OpenVPN co=
ntrol channel to pass messages between each other<br>while OpenVPN handles =
the marshalling/unmarshalling of these and<br>negotiate the common app cust=
om control protocols=2E<br><br>This provides an easy to use secure channel =
that does not depend on<br>the network itself to work and can also used bef=
ore fully authenticating<br>the client=2E See the management-notes=2Etxt fo=
r more details how to use<br>this feature=2E An upcoming patch will also ad=
d some example python<br>script that showcase this feature=2E<br><br>Change=
-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84<br>Signed-off-by: Arne Schwa=
be &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sec=
tions/client-options=2Erst<br>M doc/man-sections/management-options=2Erst<b=
r>M doc/man-sections/script-options=2Erst<br>M doc/management-notes=2Etxt<b=
r>M src/openvpn/Makefile=2Eam<br>A src/openvpn/acc=2Ec<br>A src/openvpn/acc=
=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvp=
n/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/multi=2Ec<br>M sr=
c/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/push=2E=
c<br>M src/openvpn/push=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_c=
ommon=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests=
/openvpn/mock_management=2Ec<br>M tests/unit_tests/openvpn/mock_push_depend=
encies=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Ec<br>A tests/unit_tests=
/openvpn/test_acc=2Eh<br>M tests/unit_tests/openvpn/test_common=2Eh<br>M te=
sts/unit_tests/openvpn/test_ssl=2Ec<br>26 files changed, 1,531 insertions(+=
), 22 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/58/1858/20</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLi=
sts=2Etxt b/CMakeLists=2Etxt</span><br><span>index 184a95a=2E=2E4deabe7 100=
644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -435,6 +435,8 @@</span><br><span>     src/compat/=
compat-strlcpy=2Ec</span><br><span>     src/compat/compat-strsep=2Ec</span>=
<br><span>     src/compat/compat-strtok_r=2Ec</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Ec</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Eh</span><br><span>     =
src/openvpn/argv=2Ec</span><br><span>     src/openvpn/argv=2Eh</span><br><s=
pan>     src/openvpn/base64=2Ec</span><br><span>@@ -826,6 +828,8 @@</span><=
br><span>             tests/unit_tests/openvpn/mock_management=2Ec</span><b=
r><span>             tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec</sp=
an><br><span>             tests/unit_tests/openvpn/mock_win32_execve=2Ec</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            tests/unit=
_tests/openvpn/test_acc=2Ec</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            src/openvpn/acc=2Ec</span><br><span>             src/op=
envpn/argv=2Ec</span><br><span>             src/openvpn/base64=2Ec</span><b=
r><span>             src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -842,6=
 +846,7 @@</span><br><span>             src/openvpn/packet_id=2Ec</span><br=
><span>             src/openvpn/run_command=2Ec</span><br><span>           =
  src/openvpn/ssl_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            src/openvpn/ssl_ncp=2Ec</span><br><span>             =
src/openvpn/ssl_openssl=2Ec</span><br><span>             src/openvpn/ssl_ut=
il=2Ec</span><br><span>             src/openvpn/ssl_verify_mbedtls=2Ec</spa=
n><br><span>diff --git a/doc/man-sections/client-options=2Erst b/doc/man-se=
ctions/client-options=2Erst</span><br><span>index 87c138a=2E=2E16309f9 1006=
44</span><br><span>--- a/doc/man-sections/client-options=2Erst</span><br><s=
pan>+++ b/doc/man-sections/client-options=2Erst</span><br><span>@@ -437,6 +=
437,12 @@</span><br><span>         Additional authentication methods suppor=
ted by the client=2E</span><br><span>         This may be set by the client=
 UI/GUI using ``--setenv``=2E</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  :code:`IV_ACC=3D&lt;max_msg_len&gt;,&lt;flags=
&gt;,&lt;protocols&gt;`</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        If the option ``--app-custom-control`` is set, the client will<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        send the sup=
ported max ACC message length, the supported formats</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        as (:code:`A:6`) and the list of =
configured protocols (e=2Eg=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        :code:`flower:happy:power`)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>   The following flags depend o=
n which compression formats are compiled in</span><br><span>   and whether =
compression is allowed by options=2E See `Protocol options`_</span><br><spa=
n>   for more details=2E</span><br><span>diff --git a/doc/man-sections/mana=
gement-options=2Erst b/doc/man-sections/management-options=2Erst</span><br>=
<span>index 2c79d05=2E=2E315e567 100644</span><br><span>--- a/doc/man-secti=
ons/management-options=2Erst</span><br><span>+++ b/doc/man-sections/managem=
ent-options=2Erst</span><br><span>@@ -144,3 +144,17 @@</span><br><span> </s=
pan><br><span> --management-up-down</span><br><span>   Report tunnel up/dow=
n events to management interface=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--a=
pp-custom-control protocol-list</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  Sets the list of supported app custom control protocols=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  These protocols are =
announced to the server via the IV_ACC peer info</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  variable when this option is used on a clien=
t=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  If the option=
 is set on a server it will negotiate common protocols</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  with the client=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  The protocol-list is a : separated list of protocol iden=
tifiers=2E Protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  identifiers must consist of alphanumeric characters, :code:`-`, and</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`_`=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  See management-notes=2Etxt in the OpenVPN distr=
ibution and the OpenVPN RFC</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  draft for a description of app custom control protocol support=2E=
</span><br><span>diff --git a/doc/man-sections/script-options=2Erst b/doc/m=
an-sections/script-options=2Erst</span><br><span>index f420380f=2E=2E9c17c3=
b 100644</span><br><span>--- a/doc/man-sections/script-options=2Erst</span>=
<br><span>+++ b/doc/man-sections/script-options=2Erst</span><br><span>@@ -1=
006,3 +1006,12 @@</span><br><span>        X509_1_L=3DBISHKEK</span><br><spa=
n>        X509_1_ST=3DNA</span><br><span>        X509_1_C=3DKG</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+:code:`acc_protocols`</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    If ``--app-custom-control`` is configured and=
 the client supports any of the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    protocols that server also supports, this variable contains=
 a list of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    commo=
n protocols separated by :=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+:code:`ac=
c_message_len`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f :code:`acc_protocols` is set, this variable contains the maximum</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    message length for app c=
ustom protocol message=2E</span><br><span>\ No newline at end of file</span=
><br><span>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=
=2Etxt</span><br><span>index 4d726c4=2E=2E1a7de8c 100644</span><br><span>--=
- a/doc/management-notes=2Etxt</span><br><span>+++ b/doc/management-notes=
=2Etxt</span><br><span>@@ -828,6 +828,58 @@</span><br><span> that is requir=
ed to continue the connection (unlike MFA or opening a browser)</span><br><=
span> this message is not negotiated but can just be sent as a gratuitous m=
essage=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+app custom control</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+If the special string &quot;ACC&q=
uot; is passed as {EXTRA} OpenVPN will determine</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+the common app custom protocols between the cl=
ient and the server and instruct</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+the client that the server will send control messages to the c=
lient using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the ACC =
protocol=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+The server should then use =
client-acc-msg command to send app custom</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+control messages to the client to facilitate the pend=
ing authentication=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+COMMAND -- client=
-acc-msg (OpenVPN 2=2E8 or higher)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+-------------------------------------------------</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+On an OpenVPN instance running in server mode thi=
s command sends an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+a=
pp custom control message to a client=2E The format of the command is:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  client-acc-msg {CID} {KID}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  {protocol}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  {flags}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  {message}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  END</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CID,KID -- clie=
nt ID and Key ID=2E See documentation for &quot;&gt;CLIENT:&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+notification for more info=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+protocol -- the ACC protocol identifie=
r that this message should be</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            tagged with=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fl=
ags    -- a colon separated list of the encoding and the flag if</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            the message is a f=
ragment=2E E=2Eg=2E &quot;6:F&quot; for a base64 encoded</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            message that is also a fra=
gment and not complete yet=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+message  =
-- The message encoded in the encoding specified in flags</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
COMMAND -- acc-msg (OpenVPN 2=2E8 or higher)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+------------------------------------------</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+When OpenVPN is running in --client mode this =
command sends an app</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+custom command to the server=2E The format of the command is</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  acc-msg</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  {protocol}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  {flags}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {m=
essage}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  END</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+See the client-acc-msg command for more detai=
ls about the format of the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+message=2E Since a client has only one peer there is no need to spec=
ify the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+client id an=
d key id=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> COMMAND -=
- client-deny  (OpenVPN 2=2E1 or higher)</span><br><span> -----------------=
------------------------------</span><br><span> </span><br><span>@@ -1302,6=
 +1354,47 @@</span><br><span>    response=2E Mechanisms that need multiple =
rounds or more complex answers</span><br><span>    should implement a diffe=
rent response type than CR_RESPONSE=2E</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+(6) App custom control message</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    This message is an application specific pa=
yload message that is transported</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    over the OpenVPN control channel=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    In server mode:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&gt;CLIENT:ACC,{CID},{KID},{protocol},{fragment},{msg_base64}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    In client mode:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &gt;ACC:{protocol},{fragment},{msg_base64}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    The protocol is a short ascii string identifying the app sp=
ecific custom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pr=
otocol=2E If fragment is set to 1, the message is not complete and the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    next message should =
be concatenated to this message to form a complete</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    message=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    Note that the OpenVPN implementation operates here with the robu=
stness</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    principle=
 (&quot;be conservative in what you send, be liberal in what you</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    accept&quot; - RFC 793 and=
 others) and allows receiving messages longer than</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    maximum allowed message length=2E Implem=
entations should be prepared to</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    handle messages that are longer than the maximum allowed me=
ssage length=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+(7) App custom control protocol message</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+   This message informs the client about=
 the common ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   p=
rotocols and the maximum message length for an ACC message=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+   In client mode:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+   &gt;ACC_PROTOCOLS:protocols=3D{protocol_list},message_len=3D{max_msg_=
len}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+   protocol_list is the list of su=
pported protocols by both server and client=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+   For example flower:power:sys_info would indic=
ate these three protocols</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+   arne supported=2E max_msg_len specifies the maximum message length=
 that the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   peer su=
pports=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+   In server mode these infor=
mation are available in the acc_protocols and</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+   acc_message_len variables of the client enviro=
nment=2E</span><br><span> </span><br><span> Variables:</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=
=2Eam</span><br><span>index 8a60a94=2E=2Eebc4db6 100644</span><br><span>---=
 a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Ea=
m</span><br><span>@@ -45,6 +45,7 @@</span><br><span> sbin_PROGRAMS =3D open=
vpn</span><br><span> </span><br><span> openvpn_SOURCES =3D \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	acc=2Ec acc=2Eh \</span><br><span=
> 	argv=2Ec argv=2Eh \</span><br><span> 	auth_token=2Ec auth_token=2Eh \</s=
pan><br><span> 	base64=2Ec base64=2Eh \</span><br><span>@@ -124,7 +125,8 @@=
</span><br><span> 	proto=2Ec proto=2Eh \</span><br><span> 	proxy=2Ec proxy=
=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	push=2Ec push_util=2Ec push=2Eh \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	push=2Ec push=2Eh \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	push_util=2Ec \</span><br><span> 	pushl=
ist=2Eh \</span><br><span> 	reflect_filter=2Ec reflect_filter=2Eh \</span><=
br><span> 	reliable=2Ec reliable=2Eh \</span><br><span>diff --git a/src/ope=
nvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>new file mode 100644</sp=
an><br><span>index 0000000=2E=2Ee30730b</span><br><span>--- /dev/null</span=
><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -0,0 +1,451 @@</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             over a single TCP/UDP port, with support for SSL/TLS-based</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessio=
n authentication and key exchange,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet encryption, packet authentication, and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pack=
et compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2=
025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc254=
9=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is distributed in the hope that it will be useful,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, write to the Free Software Foundation, Inc=2E,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth=
 Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG=
_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;co=
nfig=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;error=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;forward=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;options_util=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_ncp=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mu=
lti=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+enum acc_message_flag</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_ASCII =3D 1,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_BASE=
64 =3D 2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_ME=
SSAGE_FLAGS_FRAGMENT =3D 4,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+log_acc_message(struct context *c, const struct buffer =
*buf, int payload_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                const char *protocol, int flags)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bool fragment =3D flags &amp; ACC_MESSAGE_FLAGS_FRAGMEN=
T;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MAN=
AGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const char *payload_msg =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* For simplicity, we always encode payload to be base64 encoded</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * if not already =
in base64 format */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (flags &amp; ACC_MESSAGE_FLAGS_ASCII)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        char *b64out =3D NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        ASSERT(openvpn_base64_encode(CBPTR(buf), payl=
oad_len, &amp;b64out) &gt;=3D 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        gc_addspecial(b64out, free, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        payload_msg =3D b64out;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        payload_msg =3D CBSTR(buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls=
_session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;options=2Emode =3D=3D M=
ODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* ser=
ver mode=2E Report client context */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            struct man_def_auth_context *mda =3D session-&=
gt;opt-&gt;mda_context;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            unsigned int mda_key_id =3D get_primary_key(c-&gt;c2=2Etls_=
multi)-&gt;mda_key_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(M_CLIENT, &quot;&gt;CLIENT:ACC,%lu,%u,%s,%d,%s&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                mda-&g=
t;cid, mda_key_id, protocol, fragment, payload_msg);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            /* Client mode=2E Do not a report a CLIENT id */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &=
quot;&gt;ACC:%s,%d,%s&quot;, protocol, fragment, payload_msg);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH, &quot;Received custo=
m app control message (protocol &#39;%s&#39;%s)&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        protocol, fragment ? &quot;, fra=
gment&quot; : &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  Parses the flags field of an app control message and moves =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  buffer past =
the flags string=2E If there is an</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  error parsing the flags field the method returns -1 and<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  puts the error r=
eason in err_reason</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_message_flags(s=
truct buffer *buf, const char **err_reason, struct gc_arena *gc)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *flags =3D buf_extract_field(buf,=
 &#39;,&#39;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!flags)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        *err_reason =3D &quot;could no=
t extract flags field&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return -1;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int acc_flags =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for (const char *flag =3D flags; *flag !=3D &#39;\0&#3=
9;; flag++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (*flag =3D=
=3D &#39;A&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            a=
cc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else if (*flag =3D=3D &#39;6&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        else if (*flag =3D=
=3D &#39;F&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            a=
cc_flags |=3D ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       *err_reason =3D &quot;Unknown flag in flags&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return -1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* The message should be encoded with exactly one enco=
ding=2E Ensure that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * only one of the flags is present */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bool asciienc =3D (bool)(acc_flags &amp; ACC_MES=
SAGE_FLAGS_ASCII);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool base64enc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_BASE64);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (base64enc + asciienc !=3D 1)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        char *tmp =3D gc_malloc(512, 1=
, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        snpri=
ntf(tmp, 512, &quot;number of encodings must be exactly one &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                           &=
quot;(B64=3D%d, ASCII=3D%d)&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                 base64enc, asciienc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        *err_reason =3D tmp;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return acc_flags;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+receive_acc_message(struct context *c, const struct buffer *=
buffer)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *err_reason =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Example message: ACC,muppets,15,A,I am Miss Piggy */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D *buffer;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const struct tls_multi *multi =3D c-&gt;c=
2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        err_reason =3D &quot;ACC not enabled or no negotiated protoco=
ls&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        go=
to err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!buf_advance(&amp;buf, strlen(&quot;A=
CC&quot;)) || buf_read_u8(&amp;buf) !=3D &#39;,&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        err_reason =3D &quot;missing , after ACC&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* extract protocol, payload length, flags substri=
ngs */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *protocol =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!protocol)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;could not ex=
tract protocol field&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tls_item_in_cipher=
_list(protocol, multi-&gt;acc_negotiated_protocols))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct buffer msg_buf =3D alloc_buf_gc(1024, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_=
printf(&amp;msg_buf, &quot;protocol &#39;%s&#39; not in list of negotiated =
protocols &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                   protocol, multi-&gt;acc_negotiated_protocols);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =
=3D buf_cstr(&amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* We do not check the length here=2E We make no promises to =
support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * anyth=
ing larger than our announced message length but according to</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * the robustness principle</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (&quot;be cons=
ervative in what you send, be liberal in what you accept&quot; - RFC 793 an=
d others)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * we =
accept also longer messages */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
payload_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *payload_len_str =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!payloa=
d_len_str</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ||=
 !atoi_constrained(payload_len_str, &amp;payload_len, &quot;acc_payload_len=
&quot;, 0, TLS_CHANNEL_BUF_SIZE - 1, D_PUSH_ERRORS))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        err_reason =3D &quot;could not extract payload =
length field&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    int flags =3D parse_acc_message=
_flags(&amp;buf, &amp;err_reason, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (flags &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* We should have a final NUL byte in=
 the control message buffer</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * and thus the length of the buffer should be payload_len + 1 =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&=
amp;buf) !=3D payload_len + 1)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     char *tmp =3D gc_malloc(512, 1, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        snprintf(tmp, 512, &quot;field length %d=
, payload length %d mismatch&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                 payload_len, buf_len(&amp;buf) - 1);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D tm=
p;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    log_acc_message(c, &amp;buf, payload_len, protocol, flags);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msg(D_PUSH_ERRORS, &quot;WARNING: Received malformed custom app=
 control channel &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                       &quot;message (%s): %s&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        err_reason,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        format_hex(CBPTR(buffer), BLEN=
(buffer), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+send_acc_message(struct context *c,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                 struct tls_multi *multi,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                 struct tl=
s_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                 const char *protocol, bool fragment,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 const char *msg, bool ba=
se64)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * length of the protocol string + one &#=
39;,&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 2 f=
or the encoding (A or 6), potential F (fragment), and 1 for the &#39;,&#39;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 4 for the m=
essage size itself and one comma</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * 1 for the comma before the message itself */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const size_t max_header_si=
ze =3D strlen(&quot;ACC,&quot;) + strlen(protocol) + 1 + 4 + 1 + 2 + 1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D max_=
header_size + strlen(msg);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len =
&gt; TLS_CHANNEL_BUF_SIZE)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(M_CLIENT, &quot;message length (%zu) exceeds maximum possible message =
length (%d)&quot;, len, TLS_CHANNEL_BUF_SIZE);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if ((int)len &gt; multi-&gt;acc_max_message_length)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_CLIENT, &quot;header (%zu) + message size=
 (%zu) length (%zu) exceeds &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                      &quot;maximum allowed length negotiate=
d with peer (%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            max_header_size, strlen(msg), len,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            multi-&gt;acc_max_message_length=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* add 1 for the final \0 *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
buf =3D alloc_buf_gc(len + 1, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC=
,%s,%zu,%s%s,%s&quot;, protocol,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+               strlen(msg),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+               base64 ? &quot;6&quot; : &quot;A&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               frag=
ment ? &quot;F&quot; : &quot;&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+               msg);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool ret =3D send_control_channel_string_dowork(session, BSTR(&amp;buf),=
 D_PUSH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    resche=
dule_multi_process(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+parse_acc_parameters(const char *capabilities,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                     c=
onst char *delim,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                   int *max_acc_len,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                     bool server,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                     struct gc_arena *gc)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    char *tmp_message =3D string_alloc(c=
apabilities, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    char *tmp_message_orig =3D tmp_message;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *token =3D strtok_r(tmp_message, delim, &amp;last=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    int p =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int acclen =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const char *protocols =3D NULL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D NU=
LL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* In server mode we allow more=
 capabilities than our own, in client</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * mode we reject if we should use capabilities that =
we do not support */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    while (token)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (p =3D=3D 0 &amp;&amp; !atoi_constrained(token, &amp;a=
cclen, &quot;ACC message length&quot;, ACC_MIN_MSG_LEN, allowed_acc_len, D_=
PUSH_ERRORS))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto=
 done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp; (!tls_i=
tem_in_cipher_list(&quot;A&quot;, token) || !tls_item_in_cipher_list(&quot;=
6&quot;, token)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(D_PUSH_ERRORS, &quot;App custom control encoding must include base64 an=
d ascii&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&a=
mp; !server &amp;&amp; strcmp(token, &quot;A:6&quot;) &amp;&amp; strcmp(tok=
en, &quot;6:A&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(D_PUSH_ERRORS, &quot;App custom control encoding must exactly base6=
4 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 2)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            protocols =3D token;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (p =3D=3D 3)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;Too many paramete=
rs for INFO ACC message/IV_ACC=2E&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            goto done;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    token =3D strtok_r(NULL, delim, &amp;lasts);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        p++;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *max_ac=
c_len =3D min_int(acclen, ACC_MAX_MSG_LEN);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ret =3D string_alloc(protocols, gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    free(tmp_message_orig);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+get_list_intersection(struc=
t gc_arena *gc, const char *list1, const char *list2)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    char *tmp =3D string_alloc(list1, NULL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *token =3D st=
rtok_r(tmp, &quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* The maximum possible length is the shorter of the two input lists *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t max_len=
 =3D min_size(strlen(list1), strlen(list2));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer common_protocols =3D alloc_buf_gc(max_len + 1, gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    while (token)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /* check for every items is in both lists and =
not already in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * common list */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (tls_item_in_cipher_list(token, list2)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !tls_item_in_ciph=
er_list(token, buf_cstr(&amp;common_protocols)))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (buf_len(&amp;common_protocols) &gt; 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_write_u=
8(&amp;common_protocols, &#39;:&#39;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            buf_printf(&amp;common_protocols, &quot;%s&quot;, =
token);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        token =3D strt=
ok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    free(tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return common_protocols;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protocols(struct tls=
_multi *multi, struct tls_session *session)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!multi-&gt;opt=2Eacc_protocols)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* No app custom protocols have been configured server-=
side=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (multi-&gt;acc_negotiated_protocols)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* We already have determine=
d the common protocols=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* example IV_ACC: IV_ACC=
=3D2048,6:A,flower:power */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *peer_info =3D multi-&gt;peer_info;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc =3D extract_v=
ar_peer_info(peer_info, &quot;IV_ACC=3D&quot;, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!iv_acc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max=
_acc_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char *protocols =3D parse_acc_parameters(iv_acc, &quot;,&quot;, &amp;=
max_acc_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!p=
rotocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH=
_ERRORS, &quot;WARNING: IV_ACC peer info variable of peer is malformed&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer common_protocols =3D get_list_inter=
section(&amp;gc, multi-&gt;opt=2Eacc_protocols, protocols);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (buf_len(&amp;common_protocols) =3D=3D 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_DEBUG, &quot;WARNING=
: No common app custom control protocol=2E&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    multi-&gt;acc_negotiated_protocols =3D string_alloc(buf_str(&amp;commo=
n_protocols), NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    multi-&gt;acc_max_message_length =3D max_acc_len;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    setenv_str(session-&gt;opt-&gt;es, &quot;acc_protocols&=
quot;, multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    setenv_int(session-&gt;opt-&gt;es, &quot;acc_me=
ssage_len&quot;, multi-&gt;acc_max_message_length);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+notify_client_acc_protocols(struct =
tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGE=
MENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (managem=
ent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;&=
gt;ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;acc_negotiated_pr=
otocols, multi-&gt;acc_max_message_length);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span=
><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E2fe9efd<=
/span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Eh</sp=
an><br><span>@@ -0,0 +1,113 @@</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Op=
enVPN -- An application to securely tunnel IP networks</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP por=
t, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             session authentication and key exchange,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet enc=
ryption, packet authentication, and</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (=
C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Th=
is program is free software; you can redistribute it and/or modify</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of th=
e GNU General Public License version 2</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, write to the Free Sof=
tware Foundation, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef ACC_H</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ACC_MIN_MSG_=
LEN 64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ACC_M=
AX_MSG_LEN 1280</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * This method parses an app custom con=
trol message and delivers it to the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * management interface=2E We leave reassembly of fragmente=
d messages to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 management interface=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c =
           The context struct</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param buffer       Buffer containing the control message with=
 ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+receive_acc_message(struct context *c, const s=
truct buffer *buffer);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+send_acc_message(struct context *c,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 struct tls_multi =
*tls_multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
         struct tls_session *session,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                 const char *protocol, bool fragment,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const =
char *msg, bool base64);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Parses an info message from the server that co=
ntains app custom control info</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * information prior to the PUSH_REPLY to be able to use app cus=
tom control</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * proto=
cols before sending</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * In client mode=
 only allow what we support ourselves=2E In server mode</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * allow also capabilities that we not =
support ourselves=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param capabi=
lities      The string to parse</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param delim             The delimiter to use when parsing t=
he string=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
                     IV_ACC uses &quot;,&quot; as delimiter while the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                       =
   custom-control PUSH message uses &quot; &quot; as &quot;,&quot; is</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                       =
   already used to separate different push directives</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param max_acc_len       Set to the ma=
ximum ACC message length</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param server            Whether we are server or client</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc                Th=
e gc arena to use for allocating the resulting string</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return                  The resulting=
 protocol string or NULL on error</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ch=
ar *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_param=
eters(const char *capabilities,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     const char *delim,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     int *max_acc_len,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                     b=
ool server,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
             struct gc_arena *gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parses the IV_ACC=
 of the peer and sets multi=2Eacc_negotiated_protocols</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * to the common protocols of server and=
 client and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * multi=
=2Eacc_max_message_length  to the maximum length of the ACC message</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * support by both server a=
nd client=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If there is no common=
 protocol or the client does not support any app custom</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * protocol multi=2Eacc_negotiated_prot=
ocols will be set to NULL=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m multi      the multi instance to use the set the app custom protocols=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param session   =
 the session to read the client env from</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+determine_=
common_acc_protocols(struct tls_multi *multi, struct tls_session *session);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Calculates the intersection of two list that are bo=
th separated by :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Items in the result will have the same ordering as in the list1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * parameters</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param gc            Returned buf=
fer will be allocated in this gc</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param list1         First list to intersect</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param list2         Second lis=
t to intersect=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return A (potentially empty) buffer containing an intersection list</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct buffer</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+get_list_intersection(struct gc_arena *gc, cons=
t char *list1, const char *list2);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Notifies a client=
 via management interface of the negotiated app</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * custom protocols</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param multi the tls_multi instance of the c=
onnection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+notify_client_acc_protocols(struct tls_mu=
lti *multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=
=2Ec</span><br><span>index 681210d=2E=2E7923b5e 100644</span><br><span>--- =
a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</sp=
an><br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;dco=2Eh&quot=
;</span><br><span> #include &quot;auth_token=2Eh&quot;</span><br><span> #in=
clude &quot;tun_afunix=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br><span=
> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>@@ -257=
,11 +258,11 @@</span><br><span>     }</span><br><span>     else if (buf_str=
ing_match_head_str(buf, &quot;INFO_PRE&quot;))</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        server_pushed_info(=
buf, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ser=
ver_pushed_info(c, buf, 8);</span><br><span>     }</span><br><span>     els=
e if (buf_string_match_head_str(buf, &quot;INFO&quot;))</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        server_pus=
hed_info(buf, 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      server_pushed_info(c, buf, 4);</span><br><span>     }</span><br><span=
>     else if (buf_string_match_head_str(buf, &quot;CR_RESPONSE&quot;))</sp=
an><br><span>     {</span><br><span>@@ -271,6 +272,10 @@</span><br><span>  =
   {</span><br><span>         receive_auth_pending(c, buf);</span><br><span=
>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if =
(buf_string_match_head_str(buf, &quot;ACC&quot;))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        receive_acc_message(c, buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (buf_s=
tring_match_head_str(buf, &quot;EXIT&quot;))</span><br><span>     {</span><=
br><span>         receive_exit_message(c);</span><br><span>diff --git a/src=
/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 1b8b2a5=2E=
=2Ee0b99a4 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><spa=
n>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -56,6 +56,7 @@</span><br><s=
pan> #include &quot;schedule=2Eh&quot;</span><br><span> #include &quot;opti=
ons_string=2Eh&quot;</span><br><span> #include &quot;resolve=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&q=
uot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</sp=
an><br><span> </span><br><span>@@ -2279,6 +2280,13 @@</span><br><span>     =
    }</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_m=
ulti;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi =
&amp;&amp; multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        buf_printf(&amp;out, &quot; custom-control %d A:6 %s&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
     multi-&gt;acc_max_message_length, multi-&gt;acc_negotiated_protocols);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (BLENZ(&=
amp;out) &gt; strlen(header))</span><br><span>     {</span><br><span>      =
   msg(D_HANDSHAKE, &quot;%s&quot;, BSTR(&amp;out));</span><br><span>@@ -25=
22,6 +2530,11 @@</span><br><span>         flags |=3D (OPT_P_ROUTE | OPT_P_D=
HCPDNS);</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_protocols)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        flags |=3D OPT_P_ACC;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>     return flags;</span><b=
r><span> }</span><br><span> </span><br><span>@@ -2730,6 +2743,18 @@</span><=
br><span>         frame-&gt;tun_mtu =3D min_int(frame-&gt;tun_max_mtu, c-&g=
t;options=2Ece=2Etun_mtu);</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (found &amp; OPT_P_A=
CC &amp;&amp; c-&gt;options=2Epushed_acc_negotiated_protocols)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        struct tls_multi *multi =3D c-&gt;c2=
=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  free(multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        multi-&gt;acc_negotiated_protocols =3D stri=
ng_alloc(c-&gt;options=2Epushed_acc_negotiated_protocols, NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;acc_max_mess=
age_length =3D c-&gt;options=2Epushed_acc_max_message_length;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(D_PUSH, &quot;OPTIONS IMPORT: ACC protoc=
ols: %s, msg len: %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            multi-&gt;acc_negotiated_protocols, multi-&gt;acc_max_m=
essage_length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    notify_client_acc_protocols(multi);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>     return true;</span><br><span> }</span><br><span=
> </span><br><span>@@ -3352,6 +3377,7 @@</span><br><span>     to=2Everify_h=
ash_depth =3D options-&gt;verify_hash_depth;</span><br><span>     to=2Everi=
fy_hash_no_ca =3D options-&gt;verify_hash_no_ca;</span><br><span>     memcp=
y(to=2Ex509_username_field, options-&gt;x509_username_field, sizeof(to=2Ex5=
09_username_field));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    to=2Eacc_protocols =3D options-&gt;acc_protocols;</span><br><span>    =
 to=2Ees =3D c-&gt;c2=2Ees;</span><br><span>     to=2Enet_ctx =3D &amp;c-&g=
t;net_ctx;</span><br><span> </span><br><span>@@ -4306,6 +4332,24 @@</span><=
br><span> }</span><br><span> #endif /* ifdef TARGET_ANDROID */</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+management_acc_msg(voi=
d *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
       struct buffer_list *input) /* ownership transferred */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct context *c =3D arg;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (buffer_list_defined(input) &amp;&amp; c-&gt;c2=
=2Etls_multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_m=
ulti *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        struct tls_session *session =3D &amp;multi-&gt;se=
ssion[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D manag=
ement_send_acc_message(c, multi, session, input);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 buffer_list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> =
</span><br><span> void</span><br><span>@@ -4322,6 +4366,7 @@</span><br><spa=
n>         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;</span><br><spa=
n>         cb=2Eremote_cmd =3D management_callback_remote_cmd;</span><br><s=
pan>         cb=2Esend_cc_message =3D management_callback_send_cc_message;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cb=2Eacc_msg=
 =3D management_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</span><br><=
span>         cb=2Enetwork_change =3D management_callback_network_change;</=
span><br><span> #endif</span><br><span>diff --git a/src/openvpn/manage=2Ec =
b/src/openvpn/manage=2Ec</span><br><span>index ac3d4b7=2E=2E5e4e416 100644<=
/span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/open=
vpn/manage=2Ec</span><br><span>@@ -45,9 +45,11 @@</span><br><span> #include=
 &quot;push=2Eh&quot;</span><br><span> #include &quot;multi=2Eh&quot;</span=
><br><span> #include &quot;resolve=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </sp=
an><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &qu=
ot;run_command=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span> </span><br><span> #i=
fdef ENABLE_PKCS11</span><br><span> #include &quot;pkcs11=2Eh&quot;</span><=
br><span>@@ -1081,6 +1083,35 @@</span><br><span>             }</span><br><s=
pan>             break;</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        case IEC_CLIENT_ACC_MSG:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;persist=2Ecallba=
ck=2Eclient_acc_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           bool status =3D (*man-&gt;persist=2Ecallback=2Eclient_acc_msg)(m=
an-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                                              =
        man-&gt;connection=2Ein_extra_cid,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                                    =
                  man-&gt;connection=2Ein_extra_kid,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
                             man-&gt;connection=2Ein_extra);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                man-&gt;connection=
=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                report_command_status(status, &quot;client-acc-msg&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                man_command_unsup=
ported(&quot;client-acc-msg&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ca=
se IEC_ACC_MSG:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (man-&gt;persist=2Ecallback=2Eacc_msg)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                bool status =3D (*man-&gt;persist=
=2Ecallback=2Eacc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
                         man-&gt;connection=2Ein_extra);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                man-&gt;connection=2Ei=
n_extra =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              report_command_status(status, &quot;acc-msg&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                man_command_unsupported(&quo=
t;acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    break;</span><br><span>         case IEC_PK_SIGN:</span><br><span>     =
        man-&gt;connection=2Eext_key_state =3D EKS_READY;</span><br><span> =
            buffer_list_free(man-&gt;connection=2Eext_key_input);</span><br=
><span>@@ -1205,6 +1236,29 @@</span><br><span> }</span><br><span> </span><b=
r><span> static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+man_client_acc_msg(struct management *man, const char *cid_str,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                   const char =
*kid_str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *m=
c =3D &amp;man-&gt;connection;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    mc-&gt;in_extra_cid =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    mc-&gt;in_extra_kid =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (parse_cid(cid_str, &amp;mc-&gt;in=
_extra_cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
&amp;&amp; parse_uint(kid_str, &quot;KID&quot;, &amp;mc-&gt;in_extra_kid))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        mc-&gt;in_extra_cmd =3D IE=
C_CLIENT_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      in_extra_reset(mc, IER_NEW);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+man_acc_msg(struct management *man)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct man_connection *mc =3D &amp;man-&gt=
;connection;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mc-=
&gt;in_extra_cmd =3D IEC_ACC_MSG;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    in_extra_reset(mc, IER_NEW);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span> man_client_auth(struct management *man, const char *cid_=
str, const char *kid_str, const bool extra)</span><br><span> {</span><br><s=
pan>     struct man_connection *mc =3D &amp;man-&gt;connection;</span><br><=
span>@@ -1759,6 +1813,17 @@</span><br><span>             man_client_pending=
_auth(man, p[1], p[2], p[3], p[4]);</span><br><span>         }</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else =
if (streq(p[0], &quot;client-acc-msg&quot;))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (man_need(p, 2, 0))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            man_client_acc_msg(man, p[1], p[2]);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else if (streq(p[0], &quot;acc-msg&quot;))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        man_acc_msg(man);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (str=
eq(p[0], &quot;rsa-sig&quot;))</span><br><span>     {</span><br><span>     =
    man_pk_sig(man, &quot;rsa-sig&quot;);</span><br><span>@@ -2975,7 +3040,=
9 @@</span><br><span>                                        &quot;bytes_se=
nt=3D&quot;,</span><br><span>                                        &quot;=
bytes_received=3D&quot;,</span><br><span>                                  =
      &quot;session_id=3D&quot;,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                       &quot;session_state=3D&qu=
ot; };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                          &quot;session_state=3D&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
&quot;acc_protocols=3D&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                       &quot;acc_message_len=3D&q=
uot; };</span><br><span> </span><br><span>     if (env_filter_level =3D=3D =
0)</span><br><span>     {</span><br><span>@@ -3130,6 +3197,7 @@</span><br><=
span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> manage=
ment_connection_established(struct management *man, struct man_def_auth_con=
text *mdac,</span><br><span>                                   const struct=
 env_set *es)</span><br><span>@@ -4372,6 +4440,64 @@</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+management_send_acc_message(struct context *c, struct tls_multi *multi, =
struct tls_session *session,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                            struct buffer_list *input)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* also ensures that are enough inputs in the=
 list to safely call</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * buffer_list_peek without extra NULL checks */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!input || input-&gt;size &lt; 3)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;not en=
ough input lines for sending acc message, &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                      &quot;missing protocol, =
flag and/or messages lines&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct b=
uffer *proto_buf =3D buffer_list_peek(input);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *protocol =3D string_alloc(CBSTR(p=
roto_buf), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    buffer_list_pop(input);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer *encoding_buf =3D buffer_list_peek(input);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    char *encoding =3D buf_str(encoding_buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *fl=
ag =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    boo=
l b64encoding =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool fragment =3D false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
hile ((flag =3D strsep(&amp;encoding, &quot;:&quot;)))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (!strcmp(flag, &quot;6&quot;))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            b64encoding =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        else if (!strcmp(flag, &quot;=
F&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fragment=
 =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_pop(input);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    buffer_list_aggregate_separator(input, 1=
0000, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct buffer *acc_msg_buf =3D buffer_list_peek(input);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_protocols</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        || !tls_item_in=
_cipher_list(protocol, multi-&gt;acc_negotiated_protocols))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;protocol not in the l=
ist of negotiated protocols: %s&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            np(multi-&gt;acc_negotiated_protocols));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto error;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    bool ret =3D send_acc_message(c, multi, session, pro=
tocol,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                   fragment, buf_cstr(acc_msg_buf),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                b64encodi=
ng);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return re=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+error:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #else /* if=
def ENABLE_MANAGEMENT */</span><br><span> </span><br><span> #include &quot;=
win32=2Eh&quot;</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/o=
penvpn/manage=2Eh</span><br><span>index 157039d=2E=2Ecc9c264 100644</span><=
br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/man=
age=2Eh</span><br><span>@@ -184,12 +184,19 @@</span><br><span>     int (*n_=
clients)(void *arg);</span><br><span>     bool (*send_cc_message)(void *arg=
, const char *message, const char *parameter);</span><br><span>     bool (*=
kill_by_cid)(void *arg, const unsigned long cid, const char *kill_msg);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     b=
ool (*client_auth)(void *arg, const unsigned long cid, const unsigned int m=
da_key_id,</span><br><span>                         const bool auth, const =
char *reason, const char *client_reason,</span><br><span>                  =
       struct buffer_list *cc_config); /* ownership transferred */</span><b=
r><span>     bool (*client_pending_auth)(void *arg, const unsigned long cid=
, const unsigned int kid,</span><br><span>                                 =
const char *extra, unsigned int timeout);</span><br><span>     char *(*get_=
peer_info)(void *arg, const unsigned long cid);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    bool (*client_acc_msg)(void *arg,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                           co=
nst unsigned long cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                           const unsigned int mda_key_id,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                           struct =
buffer_list *msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool (*acc_msg)(void *arg,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    struct buffer_list *msg);</span><br><span>   =
  bool (*proxy_cmd)(void *arg, const char **p);</span><br><span>     bool (=
*remote_cmd)(void *arg, const char **p);</span><br><span> #ifdef TARGET_AND=
ROID</span><br><span>@@ -292,13 +299,15 @@</span><br><span>     struct comm=
and_line *in;</span><br><span>     struct buffer_list *out;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_UNDEF  =
     0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CLI=
ENT_AUTH 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define I=
EC_UNDEF          0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define IEC_CLIENT_AUTH    1</span><br><span> /* #define IEC_CLIENT_PF   2 =
*REMOVED FEATURE* */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define IEC_RSA_SIGN    3</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define IEC_CERTIFICATE 4</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define IEC_PK_SIGN     5</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define IEC_PASSWORD    6</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define IEC_RSA_SIGN       3</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define IEC_CERTIFICATE    4</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define IEC_PK_SIGN        5</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_PASSWORD       6</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_ACC=
_MSG 7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_A=
CC_MSG        8</span><br><span>     int in_extra_cmd;</span><br><span>    =
 struct buffer_list *in_extra;</span><br><span>     unsigned long in_extra_=
cid;</span><br><span>@@ -503,6 +512,14 @@</span><br><span> </span><br><span=
> void man_persist_client_stats(struct management *man, struct context *c);=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
** Parses the ACC message from the input buffer_list and send to the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * session identified by s=
ession and multi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_session;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_multi;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+management_send_acc_message(struct c=
ontext *c, struct tls_multi *multi,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                            struct tls_session *session, st=
ruct buffer_list *input);</span><br><span> #endif /* ifdef ENABLE_MANAGEMEN=
T */</span><br><span> </span><br><span> /**</span><br><span>diff --git a/sr=
c/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e302a81=
=2E=2Ea3eb3ca 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br>=
<span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -53,6 +53,7 @@</span><=
br><span> #include &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot=
;dco=2Eh&quot;</span><br><span> #include &quot;reflect_filter=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&=
quot;</span><br><span> </span><br><span> /*#define MULTI_DEBUG_EVENT_LOOP*/=
</span><br><span> </span><br><span>@@ -4085,6 +4086,26 @@</span><br><span> =
    }</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static const char *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+calculate_app_control_extra(struct multi_instance *m=
i, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct con=
text *c =3D &amp;mi-&gt;context;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_protocols)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ACC: No =
negotiated protocols&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(1024, gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_pri=
ntf(&amp;buf, &quot;ACC:%d A:6 %s&quot;, multi-&gt;acc_max_message_length,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+               multi=
-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return buf_str(&amp;buf);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> static bool</span><br><span> management_client_pending_auth(void *arg, c=
onst unsigned long cid, const unsigned int mda_key_id,</span><br><span>    =
                            const char *extra, unsigned int timeout)</span>=
<br><span>@@ -4095,10 +4116,22 @@</span><br><span>     if (mi)</span><br><s=
pan>     {</span><br><span>         struct tls_multi *multi =3D mi-&gt;cont=
ext=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (!strcmp(extra, &quot;ACC&quot;))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            extra =3D calculate_app_control_extra(mi, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (!extra)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span>         struct tls_session *session =3D look=
up_session_by_mda_key_id(multi, mda_key_id);</span><br><span> </span><br><s=
pan>         if (!session)</span><br><span>         {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><=
span>             return false;</span><br><span>         }</span><br><span>=
 </span><br><span>@@ -4106,6 +4139,7 @@</span><br><span>         bool ret =
=3D send_auth_pending_messages(multi, session, extra, timeout);</span><br><=
span>         reschedule_multi_process(&amp;mi-&gt;context);</span><br><spa=
n>         multi_schedule_context_wakeup(m, mi);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span>    =
     return ret;</span><br><span>     }</span><br><span>     return false;<=
/span><br><span>@@ -4149,6 +4183,37 @@</span><br><span>     return ret;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_cl=
ient_acc_msg(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                          const unsigned long cid,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                          const unsigned=
 int mda_key_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                       struct buffer_list *input) /* ownership transferred =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D (st=
ruct multi_context *)arg;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct multi_instance *mi =3D lookup_by_cid(m, cid);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (mi &amp;&amp; buffer_list_defined(input=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *multi=
 =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        struct tls_session *session =3D lookup_session_by=
_mda_key_id(multi, mda_key_id);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!session)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            msg(M_CLIENT, &quot;client session not found&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            buffer_list_fr=
ee(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        ret =3D management_send_=
acc_message(&amp;mi-&gt;context, multi, session, input);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        multi_schedule_context_wakeup(=
m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    buffer_list_free(input);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> static char *</span><br><span> management_get_peer_info(voi=
d *arg, const unsigned long cid)</span><br><span> {</span><br><span>@@ -418=
5,6 +4250,7 @@</span><br><span>         cb=2En_clients =3D management_callb=
ack_n_clients;</span><br><span>         cb=2Ekill_by_cid =3D management_kil=
l_by_cid;</span><br><span>         cb=2Eclient_auth =3D management_client_a=
uth;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cb=2Ecl=
ient_acc_msg =3D management_client_acc_msg;</span><br><span>         cb=2Ec=
lient_pending_auth =3D management_client_pending_auth;</span><br><span>    =
     cb=2Eget_peer_info =3D management_get_peer_info;</span><br><span>     =
    cb=2Epush_update_broadcast =3D management_callback_send_push_update_bro=
adcast;</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/=
options=2Ec</span><br><span>index fb319ae=2E=2E4b14e10 100644</span><br><sp=
an>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=
=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><span> </span><br><span> #=
include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span>=
 #include &quot;buffer=2Eh&quot;</span><br><span> #include &quot;error=2Eh&=
quot;</span><br><span> #include &quot;common=2Eh&quot;</span><br><span>@@ -=
2552,6 +2553,8 @@</span><br><span>     o-&gt;push_option_types_found =3D 0;=
</span><br><span>     o-&gt;push_update_options_found =3D 0;</span><br><spa=
n>     o-&gt;imported_protocol_flags =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    o-&gt;pushed_acc_max_message_length =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;pushed_acc_neg=
otiated_protocols =3D NULL;</span><br><span> }</span><br><span> </span><br>=
<span> static void</span><br><span>@@ -7107,6 +7110,47 @@</span><br><span> =
        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         options-=
&gt;force_key_material_export =3D true;</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;a=
pp-custom-control&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!string_class(p[=
1], CC_ALNUM | CC_COLON | CC_UNDERBAR | CC_DASH, 0))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App custom control =
protocols must only contain &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                          &quot;alphanumeric characters, &#3=
9;-&#39;, and &#39;_&#39;=2E&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        options-&gt;acc_protocols =3D p[1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (streq(p[0], &quot;custom-control&quot;) &a=
mp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; !p[4])</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ACC);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* check if the list from the server i=
s a real subset of our list */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct gc_arena gc_local =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct buffer common_list =3D=
 get_list_intersection(&amp;gc_local, p[3], options-&gt;acc_protocols);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (buf_len(&amp;common_list) =3D=
=3D 0 || !streq(p[3], buf_cstr(&amp;common_list)))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(msglevel, &quot;App custom control lis=
t from server contains &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                          &quot;unsupported protocols&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&am=
p;gc_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free=
(&amp;gc_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!streq(p[2=
], &quot;A:6&quot;) &amp;&amp; !streq(p[2], &quot;6:A&quot;))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App custo=
m control encoding must be base64 and ascii&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (!atoi_constrained(p[1], &amp;options-&gt;pushed_acc_max_=
message_length,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                          &quot;app custom message message length&quot;, AC=
C_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        options-&gt;pushed_acc_negotiated_protocols =3D p[3];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     e=
lse if (streq(p[0], &quot;prng&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</sp=
an><br><span>     {</span><br><span>         msg(M_WARN, &quot;NOTICE: --pr=
ng option ignored (SSL library PRNG is used)&quot;);</span><br><span>diff -=
-git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>in=
dex 6a3bf61=2E=2Eb7945e0 100644</span><br><span>--- a/src/openvpn/options=
=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -715,=
6 +715,18 @@</span><br><span>     /* force using TLS key material export fo=
r data channel key generation */</span><br><span>     bool force_key_materi=
al_export;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /** The app custom control protocols we should announce as sup=
ported */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char *acc_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the protoc=
ols that are negotiated with the peer=2E This is a</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     *  a temporary variable since options=
=2Ec push parser cannot access</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     *  tls multi struct */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *pushed_acc_negotiated_protocols;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /** the maximum length of an ACC control c=
hannel message via push message</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int pushed_acc_max_message_length;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     bool vlan_tagging;</span><br><sp=
an>     enum vlan_acceptable_frames vlan_accept;</span><br><span>     uint1=
6_t vlan_pvid;</span><br><span>@@ -764,8 +776,10 @@</span><br><span> #defin=
e OPT_P_INLINE          (1u &lt;&lt; 29)</span><br><span> #define OPT_P_PUS=
H_MTU        (1u &lt;&lt; 30)</span><br><span> #define OPT_P_ROUTE_TABLE   =
  (1u &lt;&lt; 31)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define OPT_P_ACC             (1ull &lt;&lt; 32)</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_DEFAULT (~(OPT_P_=
INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Options allowed in the normal configur=
ation file (vs pushed options or in ccd files) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT=
_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))</span><br><span> </span><br><spa=
n> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><span> </span><br><=
span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><sp=
an>index 42259c3=2E=2Edc8c885 100644</span><br><span>--- a/src/openvpn/push=
=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -27,6 +2=
7,8 @@</span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> <=
/span><br><span> #include &quot;push=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;option=
s=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><spa=
n> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -221,9 +223,55 @@</span>=
<br><span> #endif</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+parse_server_pushed_info_acc(struct context *c, =
struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_acc_le=
n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;opt=
=2Eacc_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PU=
SH_ERRORS, &quot;Server tried to push app custom control list &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
 &quot;without client announcing support for it&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* example string to parse: ACC:1400 A:6 flower:happy */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* Skip over the ACC: prefix =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(b=
uf, 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *protocols =3D parse_acc_parameters(buf_cstr(buf), &quot; &quot;, &amp;max=
_acc_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!protocols)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(D_PUSH_ERRORS, &quot;WARNING: Received ACC info command with invalid p=
arameters&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* check if the list from the=
 server is a real subset of our list */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer common_list =3D get_list_intersection=
(&amp;gc, protocols, multi-&gt;opt=2Eacc_protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (buf_len(&amp;common_list) =3D=3D 0 || !streq(protoco=
ls, buf_cstr(&amp;common_list)))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(D_PUSH_ERRORS, &quot;App custom control list from server contain=
s &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                &quot;unsupported protocols&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    multi-&gt;acc_negotiated_protocols =3D string_alloc(protocols, NULL)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;acc_=
max_message_length =3D max_acc_len;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    notify_client_acc_protocols(multi);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-server_pushed_info(=
const struct buffer *buffer, const int adv)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+server_pushed_info(struct context *c, const struct =
buffer *buffer, const int adv)</span><br><span> {</span><br><span>     cons=
t char *m =3D &quot;&quot;;</span><br><span>     struct buffer buf =3D *buf=
fer;</span><br><span>@@ -233,6 +281,12 @@</span><br><span>         m =3D BS=
TR(&amp;buf);</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (strncmp(m, &quot;ACC:&quot;, 4) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        parse_server_pus=
hed_info_acc(c, &amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> #ifdef ENABLE_MANAGEMENT</span><br><span>     struct gc_arena gc;</s=
pan><br><span>     if (management)</span><br><span>@@ -285,6 +339,7 @@</spa=
n><br><span>     msg(D_PUSH, &quot;CR response was sent by client (&#39;%s&=
#39;)&quot;, m);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 Parse the keyword for the AUTH_PENDING request</span><br><span>  * @param =
buffer                buffer containing the keywords, the buffer&#39;s</spa=
n><br><span>@@ -441,7 +496,6 @@</span><br><span>     const char *const peer=
_info =3D tls_multi-&gt;peer_info;</span><br><span>     unsigned int proto =
=3D extract_iv_proto(peer_info);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Calculate the maximum=
 timeout and subtract the time we already waited */</span><br><span>     un=
signed int max_timeout =3D</span><br><span>         max_uint(tls_multi-&gt;=
opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2Ehandshake_window);</span=
><br><span>@@ -732,6 +786,12 @@</span><br><span>                 client_max=
_mtu, o-&gt;ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</span><br><span>         }</=
span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_multi=
-&gt;acc_negotiated_protocols)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     push_option_fmt(gc, push_list, M_USAGE, &quot;custom-control %d A:6 %s=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            tls_multi-&gt;acc_max_message_length, tls_multi-&gt;acc_negotia=
ted_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span> }</span><br><span> </span><br><span> static bool</span><=
br><span>diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh</span><br=
><span>index 39302f6=2E=2Eb6695bc 100644</span><br><span>--- a/src/openvpn/=
push=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh</span><br><span>@@ -52,=
6 +52,7 @@</span><br><span> </span><br><span> int process_incoming_push_req=
uest(struct context *c);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * @brief Han=
dles the receiving of a push-update message and applies updates to the spec=
ified</span><br><span>  * options=2E</span><br><span>@@ -92,7 +93,7 @@</spa=
n><br><span> </span><br><span> void receive_exit_message(struct context *c)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-vo=
id server_pushed_info(const struct buffer *buffer, const int adv);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void server_pushed_info(stru=
ct context *c, const struct buffer *buffer, const int adv);</span><br><span=
> </span><br><span> void receive_cr_response(struct context *c, const struc=
t buffer *buffer);</span><br><span> </span><br><span>diff --git a/src/openv=
pn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 086a6fc=2E=2E0a25149=
 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src=
/openvpn/ssl=2Ec</span><br><span>@@ -55,6 +55,7 @@</span><br><span> </span>=
<br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br><span> #include =
&quot;ssl=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;ssl_verify=2Eh=
&quot;</span><br><span> #include &quot;ssl_backend=2Eh&quot;</span><br><spa=
n> #include &quot;ssl_ncp=2Eh&quot;</span><br><span>@@ -1279,6 +1280,7 @@</=
span><br><span>     free(multi-&gt;locked_cn);</span><br><span>     free(mu=
lti-&gt;locked_username);</span><br><span>     free(multi-&gt;locked_origin=
al_username);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fr=
ee(multi-&gt;acc_negotiated_protocols);</span><br><span> </span><br><span> =
    cert_hash_free(multi-&gt;locked_cert_hash_set);</span><br><span> </span=
><br><span>@@ -2098,6 +2100,11 @@</span><br><span> #endif</span><br><span> =
        }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (session-&gt;opt-&gt;acc_protocols)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;IV_ACC=3D%d=
,6:A,%s\n&quot;, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_protocols);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (sessi=
on-&gt;opt-&gt;push_peer_info_detail &gt; 1)</span><br><span>         {</sp=
an><br><span>             struct env_set *es =3D session-&gt;opt-&gt;es;</s=
pan><br><span>@@ -2398,6 +2405,8 @@</span><br><span>         multi-&gt;remo=
te_ciphername =3D string_alloc(&quot;none&quot;, NULL);</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    determine_common_acc_protocols(multi, session);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (username_len &l=
t; 0 || password_len &lt; 0)</span><br><span>     {</span><br><span>       =
  msg(D_TLS_ERRORS, &quot;TLS Error: Username (%d) or password (%d) too lon=
g&quot;, abs(username_len),</span><br><span>diff --git a/src/openvpn/ssl_co=
mmon=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index 9a55ead=2E=2E43=
6770b 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><sp=
an>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -457,6 +457,9 @@</sp=
an><br><span>     size_t ekm_size;</span><br><span> </span><br><span>     b=
ool dco_enabled; /**&lt; Whether keys have to be installed in DCO or not */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /** The app custom control protoco=
ls we should announce as supported */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *acc_protocols;</span><br><span> };</span>=
<br><span> </span><br><span> /** @addtogroup control_processor</span><br><s=
pan>@@ -730,6 +733,12 @@</span><br><span>     int dco_peer_id;</span><br><s=
pan> </span><br><span>     dco_context_t *dco;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /** the protocols that are negotiated with the peer=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *acc_negotiated_=
protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /** the maximum length o=
f an ACC control channel message */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int acc_max_message_length;</span><br><span> };</span><=
br><span> </span><br><span> /**  gets an item  of \c key_state objects in t=
he</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/te=
sts/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 43a6743=2E=2E6a7=
3e1e 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</s=
pan><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>=
@@ -107,10 +107,12 @@</span><br><span> 	@TEST_CFLAGS@</span><br><span> ssl_=
testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><s=
pan> ssl_testdriver_SOURCES =3D test_ssl=2Ec \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	test_acc=2Ec test_acc=2Eh \</span><br><span> 	m=
ock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_managemen=
t=2Ec \</span><br><span> 	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \=
</span><br><span> 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/acc=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/buffer=2Ec \</span><br><span>@@ -132,6 +134,7 @@</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/ssl_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/ssl_mbedtls=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/ssl_util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl=
_verify_mbedtls=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_verif=
y_openssl=2Ec \</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_=
management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec</span><br><sp=
an>index fff4c2b=2E=2Ef572dbb 100644</span><br><span>--- a/tests/unit_tests=
/openvpn/mock_management=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn=
/mock_management=2Ec</span><br><span>@@ -29,6 +29,7 @@</span><br><span> </s=
pan><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</=
span><br><span> #include &quot;manage=2Eh&quot;</span><br><span> </span><br=
><span> #ifdef ENABLE_MANAGEMENT</span><br><span>diff --git a/tests/unit_te=
sts/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn/mock_push=
_dependencies=2Ec</span><br><span>index bf2ccf3=2E=2Ef083f89 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><b=
r><span>+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br=
><span>@@ -43,7 +43,8 @@</span><br><span>     uint64_t flags =3D OPT_P_UP |=
 OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span>     =
                 | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP |=
 OPT_P_PERSIST</span><br><span>                      | OPT_P_MESSAGES | OPT=
_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                     | OPT_P_PEER_ID | OPT_P_NC=
P | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                     | OPT_P_PEER_ID | OPT_P_=
NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                     | OPT_P_ACC;</span><br>=
<span>     return flags;</span><br><span> }</span><br><span> </span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/op=
envpn/test_acc=2Ec</span><br><span>new file mode 100644</span><br><span>ind=
ex 0000000=2E=2Edde1ad8</span><br><span>--- /dev/null</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>@@ -0,0 +1,358 @@</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to secure=
ly tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             over a single TCP/UDP port, with support for SSL/TLS-based=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sess=
ion authentication and key exchange,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             packet encryption, packet authentication, a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C)=
 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2=
549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you c=
an redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  it under the terms of the GNU General Public License versi=
on 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publishe=
d by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is distributed in the hope that it will be useful,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANT=
Y; without even the implied warranty of</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, write to the Free Software Foundation, Inc=2E,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth=
 Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG=
_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;co=
nfig=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;strin=
g=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;test_acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+char control_channel_message_sent[2048];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Mock functions */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+send_control_channel_string_dowork(struct tls_session *session,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
       const char *str, unsigned int msglevel)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_in_range(strlen(str), 0, 2047);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    strcpy(control_channel_message_sent, str);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_push_r=
eply_auth_token(struct tls_multi *multi)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+auth_set_client_reason(struct tls_multi *multi, c=
onst char *reason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define MSG_PAYLOAD &quot;FgMBARkBAAEVAwNanUalkEDDxLBpZw=
9JnjI3tBM&quot;                \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    &quot;r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD6=
6z/notFT0cF1d60nTS&quot; \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    &quot;4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwC=
ewCTAKABrwCP&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    &quot;AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgA=
WABQAH&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               &quot;QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc=
&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         &quot;ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA&quot;=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   &quot;AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ&quot; \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &qu=
ot;93rQwityP9eKSijXgcQ=3D=3D&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_acc_parse_clie=
nt_messages(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENAB=
LE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sk=
ip();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* ensure that the messa=
ges get to mock_msg */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    x_debug_level =3D 3;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    management =3D (void *)0x12345678;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* contains a TLS 1=2E3 ClientHello */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char msg[] =3D &q=
uot;ACC,cck1,384,6,&quot; MSG_PAYLOAD;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer msg_buf;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct context c =3D { 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    c=2Eoptions=2Emode =3D MODE_SERVER;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_m=
ulti, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-=
&gt;session[TM_ACTIVE]=2Eopt =3D &amp;c=2Ec2=2Etls_multi-&gt;opt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;se=
ssion[TM_ACTIVE]=2Eopt-&gt;mda_context =3D &amp;c=2Ec2=2Emda_context;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg=
_buf, (void *)msg, sizeof(msg));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
ceive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;WARNING: R=
eceived malformed custom app control channel message (ACC not enabled or no=
 negotiated protocols): 4143432c 63636b31 2c333834 2c362c46 674d4241 526b42=
41 41455641 774e616[more=2E=2E=2E]&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;acc_n=
egotiated_protocols =3D &quot;no:common:protocol&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;ms=
g_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_s=
tring_equal(mock_msg_buf, &quot;WARNING: Received malformed custom app cont=
rol channel message (protocol &#39;cck1&#39; not in list of negotiated prot=
ocols &#39;no:common:protocol&#39;): 4143432c 63636b31 2c333834 2c362c46 67=
4d4241 526b4241 41455641 774e616[more=2E=2E=2E]&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_=
buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_mu=
lti-&gt;acc_negotiated_protocols =3D &quot;cck1:flower:power:fortune&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_mes=
sage(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(mock_msg_buf, &quot;Received custom app control message (proto=
col &#39;cck1&#39;)&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,=
0,cck1,0,&quot; MSG_PAYLOAD);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 char flower_msg[] =3D &quot;ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77=
+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg, sizeof(flower_=
msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_a=
cc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Received custom a=
pp control message (protocol &#39;flower&#39;)&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_b=
uf, &quot;&gt;CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZ=
nJvZyEAAA=3D=3D&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_=
managment_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char msg_incorrect_len[] =3D &quot;ACC,fortune,62,6,InsgIm1lIjogImZyb=
2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=3D&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void=
 *)msg_incorrect_len, sizeof(msg_incorrect_len));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *er=
ror =3D &quot;WARNING: Received malformed custom app control channel &quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     &quot;message (field length 62, payload length 64 mismatch): &quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  &quot;4143432c 666f7274 756e652c 36322c36 2c496e73 67496d31 &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        &q=
uot;6c496a6f 67496d5[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_string_equal(mock_msg_buf, error);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &=
quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 msg_fragment[] =3D &quot;ACC,power,12,6F,aGVsbG8gdw=3D=3D&quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf=
, (void *)msg_fragment, sizeof(msg_fragment));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equ=
al(mock_msg_buf, &quot;Received custom app control message (protocol &#39;p=
ower&#39;, fragment)&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0=
,0,power,1,aGVsbG8gdw=3D=3D&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 CLEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* check two encoding present */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const char flower_msg_two_encs[] =3D &quot;ACC=
,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp=
;msg_buf, (void *)flower_msg_two_encs, sizeof(flower_msg_two_encs));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&a=
mp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D &quo=
t;WARNING: Received malformed custom app control channel message &quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;(numb=
er of encodings must be exactly one (B64=3D1, ASCII=3D1)): &quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;4143432c 66=
6c6f77 65722c34 382c3641 2c535342 68625341 41494574 &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &quot;6c636d3[more=2E=2E=
=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(moc=
k_msg_buf, error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(mock_managment_buf, &quot;&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* no encoding present */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char flower_msg_no_encs[] =3D &quot;=
ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&am=
p;msg_buf, (void *)flower_msg_no_encs, sizeof(flower_msg_no_encs));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&am=
p;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot=
;WARNING: Received malformed custom app control channel message &quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;(numbe=
r of encodings must be exactly one (B64=3D0, ASCII=3D0)): &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &quot;4143432c 666=
c6f77 65722c34 382c2c53 53426862 53414149 45746c63 &quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &quot;6d31706[more=2E=2E=
=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_string_equal(mock_msg_buf, error);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    x_debug_level =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    management =3D NULL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_parse_acc_=
parameters(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* parameters to INFO message */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *info_acc_msg =3D &quot;4096 A:6 flower=
:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_len =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *protoc=
ols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, tru=
e, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_string_equal(protocols, &quot;flower:happy&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1280);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* a client does not accept a length =
longer than it supports */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, =
&amp;max_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_null(protocols);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* message with lower limit than our, should work for client and server=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg=
 =3D &quot;1111 A:6 flower:happy&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &q=
uot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flower:hap=
py&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(max_len, 1111);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protoco=
ls =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_string_equal(protocols, &quot;flower:happy&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1111);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* more encodings than supported=2E S=
erver should be okay, client should fail */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1200 A:6:B flower:happy&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols=
 =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D pa=
rse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string=
_equal(protocols, &quot;flower:happy&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1200);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* extra parameter */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1400 A:6 flower:hap=
py 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pro=
tocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, =
true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =
=3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc_capabilities =3D =
&quot;1400,A:6,flower:happy:power&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(iv_acc_capabili=
ties, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flo=
wer:happy:power&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* too smal=
l protocol length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    info_acc_msg =3D &quot;32 A:6 flower:happy&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(i=
nfo_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* non-numerical protocol length */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;a=
bff A:6 flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;,=
 &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_null(protocols);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* extra parameter */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    info_acc_msg =3D &quot;1400 A:6 flower:happy 77&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_pa=
rameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_acc_comm=
on_protocols(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
multi_instance mi =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct context *c =3D &amp;mi=2Econtext;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Egc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c-&gt;c2=2Etls_mul=
ti, struct tls_multi, &amp;c-&gt;options=2Egc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    c-&gt;c2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\n=
IV_ACC=3D1400,A:6,flower:happy:power&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_protocols =3D &quot;power:f=
lower:star&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Eacc_protocols =3D c-&=
gt;options=2Eacc_protocols;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;multi-&gt;opt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Ees =
=3D env_set_create(&amp;c-&gt;options=2Egc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    determine_common_acc_protocols(multi, &amp;c-&gt;c2=2Etls_multi-&=
gt;session[TM_ACTIVE]);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(multi-&gt;acc_max_message_length, ACC_MAX_MSG_LEN);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(multi-&gt;acc=
_negotiated_protocols, &quot;power:flower&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_string_equal(env_set_get(multi-&gt;opt=2Ees, &quot;ac=
c_protocols&quot;), &quot;acc_protocols=3Dpower:flower&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(env_set_=
get(multi-&gt;opt=2Ees, &quot;acc_message_len&quot;), &quot;acc_message_len=
=3D1280&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(multi-&gt;acc_=
negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+test_acc_send_message(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance mi =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct co=
ntext *c =3D &amp;mi=2Econtext;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    c-&gt;options=2Egc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ALLOC_OBJ_CLEAR_GC(c-&gt;c2=2Etls_multi, struct tls_multi, &a=
mp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_protocols =3D &qu=
ot;power:flower:emergency&quot;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    multi-&gt;opt=2Eacc_protocols =3D c-&gt;options=2Eacc_prot=
ocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt=
;session[TM_ACTIVE]=2Eopt =3D &amp;multi-&gt;opt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Ees =3D env_set_create(&am=
p;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Et=
ls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:=
emergency:power&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    determine_common_acc_protocols(multi, &amp;c-&gt;c2=2Etls_multi-&gt;=
session[TM_ACTIVE]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_ses=
sion *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ret =3D send_acc_message(c, c-&gt;c2=2Etls=
_multi, session, &quot;emergency&quot;, true,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                           &quot;EMERGENCY BROADC=
AST MESSAGE - THIS IS NOT A DRILL:&quot;, false);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(ret);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_string_equal(control_channel_message_sent,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        &quo=
t;ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_message(c, c=
-&gt;c2=2Etls_multi, session, &quot;emergency&quot;, false,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                           &quot;TH=
E GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E&quot;, fa=
lse);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_s=
tring_equal(control_channel_message_sent,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        &quot;ACC,emergency,65,A,THE =
GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* test a long message (&gt; 1000) with fragment to get =
the maximum header size */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    char long_message[1200] =3D { 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (int i =3D 0; i &lt; 1024; i++)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        long_message[i] =3D (char)(&#39; &#39; + (i % 95));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* last char of the message is a i and then a \0 */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(long_message[1023], &#39;i&#39;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(long_message[1024], &#39;\0&#39;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_message(c, c-&gt;c2=
=2Etls_multi, session, &quot;emergency&quot;, true,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           long_message, =
false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    size_t cc_len =3D strlen(=
control_channel_message_sent);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(control_channel_message_sent[cc_len - 1], &=
#39;i&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *expected_start_cc =3D &quot;ACC,emergency,1024,AF, !\&quot;#$%&amp=
;&#39;()*+,-=2E/012345&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_memory_equal(control_channel_message_sent, expected_st=
art_cc, strlen(expected_start_cc));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 free(multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt;options=2Egc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_list_i=
ntersection(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ch=
ar *empty =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *protos =3D &quot;power:flower:emergency&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer t1 =3D get_list_interse=
ction(&amp;gc, empty, protos);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(buf_len(&amp;t1), 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer t2 =3D get_list_intersection(&amp;gc, prot=
os, empty);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(buf_len(&amp;t2), 0);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer t3 =3D get_list_intersection(&amp;gc, protos, protos);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(bu=
f_cstr(&amp;t3), protos);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *protos2 =3D &quot;flower:emergency:power:mario&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer t4 =3D get_list_inte=
rsection(&amp;gc, protos2, protos);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t4), &quot;flower:eme=
rgency:power&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *pr=
otos3 =3D &quot;super:paper:mario:flower&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer t5 =3D get_list_intersection(=
&amp;gc, protos2, protos3);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(buf_cstr(&amp;t5), &quot;flower:mario&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const char *proto4 =3D &quot;flo=
wer:flower:flower:flower&quot;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer t6 =3D get_list_intersection(&amp;gc, proto4,=
 &quot;flower&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_string_equal(buf_cstr(&amp;t6), &quot;flower&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test_acc=
=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh</span><br><span>new file mode =
100644</span><br><span>index 0000000=2E=2E32421fb</span><br><span>--- /dev/=
null</span><br><span>+++ b/tests/unit_tests/openvpn/test_acc=2Eh</span><br>=
<span>@@ -0,0 +1,35 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN --=
 An application to securely tunnel IP networks</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             over a single UDP port, with supp=
ort for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             session authentication and key exchange,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pac=
ket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             packet compression=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you c=
an redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  it under the terms of the GNU General Public License versi=
on 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publishe=
d by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is distributed in the hope that it will be useful,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANT=
Y; without even the implied warranty of</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def TEST_ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne TEST_ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void t=
est_acc_parse_client_messages(void **state);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void test_parse_acc_parameters(void **state);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void test_acc_common_protocols(void **state);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void test_acc_send_message(void **state);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void test_list_intersection(void **state);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/openvp=
n/test_common=2Eh</span><br><span>index 8db4ea6=2E=2Ec865142 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>@@ -43,11 +43,1=
3 @@</span><br><span> #define LargestIntegralType uintmax_t</span><br><span=
> #endif</span><br><span> /* redefine 2=2Ex API in terms of 1=2Ex API */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CMockaValueData =
            LargestIntegralType</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define check_expected_uint         check_expected</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define expect_uint_value           =
expect_value</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define e=
xpect_check_data           expect_check</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define cast_ptr_to_cmocka_value(x) (x)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define CMockaValueData              =
         LargestIntegralType</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define check_expected_uint                   check_expected</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define expect_uint_value=
                     expect_value</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define expect_check_data                     expect_check</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define cast_ptr_to_cm=
ocka_value(x)           (x)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define assert_int_in_range(value, min, max)  assert_in_range((valu=
e), (min), (max))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine assert_uint_in_range(value, min, max) assert_in_range((value), (min),=
 (max))</span><br><span> #endif</span><br><span> </span><br><span> /**</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit=
_tests/openvpn/test_ssl=2Ec</span><br><span>index 4baf8cc=2E=2E4987dd0 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><s=
pan>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -52,6 +5=
2,8 @@</span><br><span> #include &quot;ssl_verify=2Eh&quot;</span><br><span=
> #include &quot;openvpn=2Eh&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Mock f=
unction to be allowed to include win32=2Ec which is required for</span><br>=
<span>  * getting the temp directory */</span><br><span> #ifdef _WIN32</spa=
n><br><span>@@ -86,6 +88,20 @@</span><br><span> {</span><br><span>     retu=
rn;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reschedule_m=
ulti_process(struct context *c)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Define a dummy dco cipher option to av=
oid linking against all the DCO</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * units */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(ENABLE_DCO)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dco_get_supported_ciphers(void)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn &quot;AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY13=
05&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </sp=
an><br><span> /* generated using</span><br><span>  * openssl req -x509 -new=
key ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \</span><br><span>@@ =
-1111,8 +1127,12 @@</span><br><span>         cmocka_unit_test(ssl_test_extr=
act_last_matching_field),</span><br><span>         cmocka_unit_test(ssl_tes=
t_reject_null_in_cert_subject),</span><br><span>         cmocka_unit_test(s=
sl_test_escape_rfc_2253_chars_in_subject),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        cmocka_unit_test(ssl_test_extract_peer_info)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(ssl_test_extract=
_peer_info),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmocka_unit_test(test_acc_parse_client_messages),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_parse_acc_para=
meters),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_acc_common_protocols),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_send_message),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(test_list_intersection)</span><br><span>     };</span><br><span> </span><b=
r><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">=
change 1858</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
8?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>

</body></html>
--Jhd8SAUpG2c=--


--===============4373918210534674292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4373918210534674292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4373918210534674292==--

