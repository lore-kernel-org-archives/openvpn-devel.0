Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A168DCA5FA1
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=xV/IbAV8wSzBYa0acqfbA05A1RJFrVX5ri/9VTqHCx4=; b=U9go1NdokcS/kE
	WnmyDzXwjBkHUKIl94JTlnCRoGpZL5ZsbdcfarWQzSKQYas4th7PF1+L1GrbeBFfNIH6o7Gpam4gl
	n4gbngUzFiW73cNqPZAlSwDsJq6bbKBYUSGDIF2luojQaGrdE5S6ZrPC/+eaCFu4LriwF8zQWCAvK
	qzs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBDZ6-0005Lu-FK;
	Mon, 28 Sep 2026 15:46:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBDZ4-0005Ln-He
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 15:46:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9s106mSHU33SopJCDiwKT5JLvf9hldBGSyIYHGr3V5w=; b=ksCYZ5Jzg+ky3OxZ6TiQIzSEWa
 CMIOX25wnWqrOoO9lVrRBVba8MLyGS6CFNFAbkIu62ZFRdMeAnegPfBjpfAjnwrsOzd/BcAdtvEa7
 DTg/IWdWTfZMJlrHXiBm0tA/3BLb/sp6Zdby8Jat7nT0oWN9zBe6Pltm8IzYlqVNEzbI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9s106mSHU33SopJCDiwKT5JLvf9hldBGSyIYHGr3V5w=; b=m
 izR5hcu+ksz4snBZxUZzzn30rQ5zzOSW1zhN8ZqWhY03iZCzIjxMB44VOiMQvl2EPjvin9kVMC/C5
 FAr4zN0Gjz6BI54FJtoS2KcFK/zDsjSRUaQTxe7PWTqpa6ByT0A3EwQshBuCoauqhXSYLP7ure9+R
 e1Sal81mqOFbKU6I=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBDZ0-00007z-1p for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 15:46:51 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so16738625e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 08:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790610399; x=1791215199; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9s106mSHU33SopJCDiwKT5JLvf9hldBGSyIYHGr3V5w=;
 b=XAyVIMjyLFlLQNGnm9Wg9qfZXIRWC4tOlr2AN1I0yIViunz+k2PLd9Ek5UpMw6Q21p
 SG3mwAfnedUGGYgoFAFXOSFcdre0JKkE0FOiWOa5Fs2AB43jT2sDlcy2yTeaB9PxSRfQ
 ez/lcdFkHK6qAopR0i1yr1n1/maUxASSNX6fw2Sv4keAHZkfxiSFhns2K2VKpFe1xB8E
 6d0UVkyyXrXtJfWLiSqESFUUgbLVuAANNK3MEJ0xrBSkYLYsktcursRdIfDd5/01WL2H
 d4ltyjutQr9uq28D/i9m8ssvJhEaQhruDrB4v6hh4EwbGtYCPxO9dj6ARMp9ac3WOtGG
 cqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790610399; x=1791215199;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9s106mSHU33SopJCDiwKT5JLvf9hldBGSyIYHGr3V5w=;
 b=F3YDlUPGUEzLTcUhqJdxWzrYUocXyEAbfPelzGs/wuuSU8N/k3pD4fvQSKkuAgivKW
 WPojvmt7DsX5GbTBRTLUNir4GW6lj32fQ12ie1Lw/0HrWcGhYybuptQWMPQBXEk6f7fR
 A4BLIrxwOEGRImACxJmlE9CJdBJWKRzjZHZ3jlASeZ2f+HePlRKMZTEqGz5ij909Mfsh
 Ot7TLt9CYde9Aat3vsVBb9TVKmQKOWPWAF+QZywTi4QGRofFrp5bCeBLcbw0HjsqCeem
 jwGEKj7F3Imrdag9uu+rOV0vDDw/K6Tq46Ddh8PD4A9/A3UywVvFiRnwAg/q7VKIS43d
 ewWg==
X-Gm-Message-State: AFuF++kLFbmqT6EGyMWcd8K6gG/f9K16GC/UR4LwpT3Q+dYurQoxgCF0
 +j+71fjhUY0yg2DBuQikvK0YTsOQ1xK+i58drQCaJ94UovK0Xrr1hIaa0D0LeGd+1UM2EGAcE5F
 uCa6wk02lbajZSu7VHYko5lV9ub7CguC8PTjjnrkEop6iy08IFEX6HgDCHQT7W3VUPHNTtrSlze
 l6oBGPNQ==
X-Gm-Gg: AYBFou2c5WFRs+OcScT0VXS9ILO29wc61i24mHLIzjQbJp5dfs3b7qAqQlR2S19dqTL
 9Vjq6Y5gBexECnfKMB6EftHUvsqO+rH+nSznq9im1zq0HbCDO11kZf7DS5q/zM929ztTTR5OJc3
 fys/re3LZZ0SZfTPZ03zO3bZbXygo22BH6TFwu0dL6QHu14XDRw3u1iU9IEk3NYXmQP6hroC3sk
 kLRXp+z0jkecqGrcjambo2Hs7KT/Id85O+h0+JMvVKvN1IlUxpgkGB9uHWiOW5Jn3rXYqPyACTx
 Nw7KtzG6k36LCez2Aw76F5I7PaURC1GVeBJnHteJR0olVUqjWgORdiw663WF++Eyo+MpPwMV2qV
 TfhhQJ/pgdJmkStReF1vtvFtr6Oba8CTlghUjymIekaaU0DcxMGYlku/Yr7bD9R8aDRTGonHGlU
 14gVDzWROHxZy7iKxsO+IomHTr+hVLYi3jDXtKLA3xtqW3EoKQTv2gdc8biqCwEL2M7SAc8nYK+
 qQMhMThN21EGrvFG05xvTke2Oh0qJwCRgNJIRQ8lM3xv6mhchUfWWvbjRyOoF+TdkS9duFWECYr
 +VEXdyjjWel1+IzHfS322VaEk5FVwvZD+9bQbG5MDyoN1JQIUlX08sp3q49P
X-Received: by 2002:a05:600c:8719:b0:49d:15b9:2a2a with SMTP id
 5b1f17b1804b1-49fe66c6373mr255485785e9.10.1790610399069; 
 Mon, 28 Sep 2026 08:46:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfab490sm1066955e9.12.2026.09.28.08.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:46:38 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 15:46:37 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7f910599f0f4005f06a88a93b40417ffa37022a8
X-Gerrit-Change-Number: 1960
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1960?usp=email>
X-Gerrit-Commit: 6a89bc19686b283bf1c628cc4b010f4dadcc87eb
References: <gerrit.1790610390000.I7f910599f0f4005f06a88a93b40417ffa37022a8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEwMzkwMDAwLkk3ZjkxMDU5OWYwZjQwMDVmMDZhODhhOTNiNDA0MTdmZmEzNzAyMmE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fe83d5e0720f0072e9ca4700a9099f221aeb468f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBDZ0-00007z-1p
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix all occurrences
 of cppcheck invalidPrintfArgType_uint
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2975665683876173708=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2975665683876173708==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EEilVvYl9pc="; charset=UTF-8

--EEilVvYl9pc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1960?usp=3Demail

to review the following change=2E


Chang=
e subject: Fix all occurrences of cppcheck invalidPrintfArgType_uint
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix all occurrences=
 of cppcheck invalidPrintfArgType_uint

Mostly trivially correct=2E There a=
re some exceptions, though:
- cppcheck treats all numerical literals as "si=
gned" even
  though the compilers would probably be more intelligent=2E
  C=
hose different work-arounds for different occurrences=2E
- Needed to overri=
de PRIx64 again for Windows, since there
  it needs to be "llx", not "lx"=
=2E

Change-Id: I7f910599f0f4005f06a88a93b40417ffa37022a8
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
---
M dev-tools/cppcheck-suppress=
ions=2Exml
M dev-tools/openvpn-cppcheck-windows=2Ecfg
M src/openvpn/dco_win=
=2Ec
M src/openvpn/dns=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/init=2Ec=

M src/openvpn/options=2Ec
M src/openvpn/platform=2Ec
M src/openvpn/push=2E=
c
M src/openvpn/route=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/tun=2Ec
M src=
/openvpn/tun=2Eh
M src/openvpnmsica/msica_arg=2Ec
M src/openvpnmsica/msiex=
=2Ec
M src/openvpnmsica/openvpnmsica=2Ec
M src/openvpnserv/interactive=2Ec
=
17 files changed, 36 insertions(+), 36 deletions(-)



  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/1960/1

diff --git a/dev-=
tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml
i=
ndex 12521e1=2E=2E38de5f2a 100644
--- a/dev-tools/cppcheck-suppressions=2Ex=
ml
+++ b/dev-tools/cppcheck-suppressions=2Exml
@@ -9,9 +9,6 @@
     <id>con=
stParameterCallback</id>
   </suppress>
   <suppress>
-    <id>invalidPrint=
fArgType_uint</id>
-  </suppress>
-  <suppress>
     <id>unusedFunction</id=
>
   </suppress>
   <suppress>
diff --git a/dev-tools/openvpn-cppcheck-wind=
ows=2Ecfg b/dev-tools/openvpn-cppcheck-windows=2Ecfg
index 9ac7282=2E=2E932=
d586 100644
--- a/dev-tools/openvpn-cppcheck-windows=2Ecfg
+++ b/dev-tools/=
openvpn-cppcheck-windows=2Ecfg
@@ -7,4 +7,7 @@
        understand our likel=
y()/unlikely() macros=2E -->
   <define name=3D"__builtin_expect(X,Y)" valu=
e=3D"(X)" />
   <define name=3D"__builtin_expect_with_probability(exp,c,pro=
bability)" value=3D"(exp)" />
+  <!-- cppcheck understands it directly in f=
ormat string, but not
+       indirectly when the format string is construc=
ted earlier -->
+  <define name=3D"PRIx64" value=3D"&quot;llx&quot;" />
 </=
def>
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index c=
01a4e5=2E=2E7abd06b 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/=
dco_win=2Ec
@@ -835,7 +835,7 @@
         struct multi_instance *mi =3D dco-=
>c->multi->instances[stat->PeerId];
         if (!mi)
         {
-         =
   msg(M_WARN, "%s: received data for a non-existing peer %u", __func__, st=
at->PeerId);
+            msg(M_WARN, "%s: received data for a non-existing=
 peer %d", __func__, stat->PeerId);
             continue;
         }
 
dif=
f --git a/src/openvpn/dns=2Eh b/src/openvpn/dns=2Eh
index 51bc2de=2E=2E2c20=
b0e 100644
--- a/src/openvpn/dns=2Eh
+++ b/src/openvpn/dns=2Eh
@@ -89,7 +89=
,7 @@
 };
 
 #ifndef N_DHCP_ADDR
-#define N_DHCP_ADDR 4
+#define N_DHCP_ADD=
R 4u
 #endif
 
 #ifndef N_SEARCH_LIST_LEN
diff --git a/src/openvpn/forward=
=2Ec b/src/openvpn/forward=2Ec
index 146c498=2E=2E204b0b7 100644
--- a/src/=
openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -1288,7 +1288,7 @@
   =
          break;
 
         default:
-            msg(D_DCO_DEBUG, "%s: rec=
eived message of type %u - ignoring", __func__,
+            msg(D_DCO_DEBU=
G, "%s: received message of type %d - ignoring", __func__,
                =
 dco->dco_message_type);
             return;
     }
diff --git a/src/openv=
pn/init=2Ec b/src/openvpn/init=2Ec
index 81890d4=2E=2E3c2ebf9 100644
--- a/=
src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -258,7 +258,7 @@
       =
  gc =3D gc_new();
         {
             struct buffer out =3D alloc_buf_=
gc(256, &gc);
-            buf_printf(&out, ">PROXY:%u,%s,%s", (l ? l->curr=
ent : 0) + 1,
+            buf_printf(&out, ">PROXY:%d,%s,%s", (l ? l->curr=
ent : 0) + 1,
                        (proto_is_udp(ce->proto) ? "UDP" : "T=
CP"), np(ce->remote));
             management_notify_generic(BSTR(&out));
=
             management->persist=2Especial_state_msg =3D BSTR(&out);
diff -=
-git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 95e93da=2E=
=2E5a57c0a 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -5139,7 +5139,7 @@
         }
         else
         {
-           =
 msg(msglevel, "argument to --bind-dev is longer than allowed %u", IFNAMSIZ=
 - 1);
+            msg(msglevel, "argument to --bind-dev is longer than al=
lowed %d", IFNAMSIZ - 1);
             goto err;
         }
     }
diff --g=
it a/src/openvpn/platform=2Ec b/src/openvpn/platform=2Ec
index ab581f4=2E=
=2Eccdd43d 100644
--- a/src/openvpn/platform=2Ec
+++ b/src/openvpn/platform=
=2Ec
@@ -551,7 +551,7 @@
         ++attempts;
 
         if (!checked_snpri=
ntf(fname, sizeof(fname), fname_fmt, max_prefix_len, prefix,
-             =
                 get_random(), get_random()))
+                            =
  (uint64_t)get_random(), (uint64_t)get_random()))
         {
             =
msg(M_WARN, "ERROR: temporary filename too long");
             return NULL=
;
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index d72596e=2E=
=2Ea514d92a 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@=
 -351,7 +351,7 @@
     parse_auth_pending_keywords(buffer, &server_timeout)=
;
 
     msg(D_PUSH,
-        "AUTH_PENDING received, extending handshake t=
imeout from %us "
+        "AUTH_PENDING received, extending handshake time=
out from %ds "
         "to %us",
         c->options=2Ehandshake_window, m=
in_uint(max_timeout, server_timeout));
 
diff --git a/src/openvpn/route=2Ec=
 b/src/openvpn/route=2Ec
index 469edb3=2E=2Eb8bac7a 100644
--- a/src/openvp=
n/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -2822,7 +2822,7 @@
         ret =
=3D (ack=2Eerror_number =3D=3D ERROR_OBJECT_ALREADY_EXISTS) ? RTA_EEXIST : =
RTA_ERROR;
         if (ret =3D=3D RTA_ERROR)
         {
-            msg(M=
_WARN, "ERROR: route %s failed using service: %s [status=3D%u if_index=3D%l=
u]",
+            msg(M_WARN, "ERROR: route %s failed using service: %s [st=
atus=3D%d if_index=3D%lu]",
                 (add ? "addition" : "deletion"=
), strerror_win32(ack=2Eerror_number, &gc),
                 ack=2Eerror_nu=
mber, rt->iface=2Eindex);
         }
diff --git a/src/openvpn/ssl=2Ec b/src=
/openvpn/ssl=2Ec
index 6a8e78e=2E=2E3594871 100644
--- a/src/openvpn/ssl=2E=
c
+++ b/src/openvpn/ssl=2Ec
@@ -1690,7 +1690,7 @@
                         =
           options->ping_rec_timeout, frame->mss_fix);
             if (ret=
 < 0)
             {
-                msg(D_DCO, "Cannot set DCO peer param=
eters for peer (id=3D%u): %s",
+                msg(D_DCO, "Cannot set DCO =
peer parameters for peer (id=3D%d): %s",
                     multi->dco_pe=
er_id, strerror(-ret));
                 return false;
             }
diff =
--git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 2d8f36d=2E=2E85b307=
4 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -153,7 +153=
,7 @@
 
     if (ack=2Eerror_number !=3D NO_ERROR)
     {
-        msg(M_WA=
RN, "TUN: %s address failed using service: %s [status=3D%u if_index=3D%lu]"=
,
+        msg(M_WARN, "TUN: %s address failed using service: %s [status=3D=
%d if_index=3D%lu]",
             (add ? "adding" : "deleting"), strerror_w=
in32(ack=2Eerror_number, &gc), ack=2Eerror_number,
             addr=2Eifac=
e=2Eindex);
         goto out;
@@ -224,7 +224,7 @@
 
     if (ack=2Eerror_n=
umber !=3D NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s DNS domains faile=
d using service: %s [status=3D%u if_name=3D%s]",
+        msg(M_WARN, "TUN:=
 %s DNS domains failed using service: %s [status=3D%d if_name=3D%s]",
     =
        (add ? "adding" : "deleting"), strerror_win32(ack=2Eerror_number, &=
gc), ack=2Eerror_number,
             dns=2Eiface=2Ename);
         goto ou=
t;
@@ -294,7 +294,7 @@
 
     if (ack=2Eerror_number !=3D NO_ERROR)
     {
=
-        msg(M_WARN, "TUN: %s %s dns failed using service: %s [status=3D%u =
if_name=3D%s]",
+        msg(M_WARN, "TUN: %s %s dns failed using service: =
%s [status=3D%d if_name=3D%s]",
             (add ? "adding" : "deleting"),=
 ip_proto_name, strerror_win32(ack=2Eerror_number, &gc),
             ack=
=2Eerror_number, dns=2Eiface=2Ename);
         goto out;
@@ -351,7 +351,7 @=
@
 
     if (ack=2Eerror_number !=3D NO_ERROR)
     {
-        msg(M_WARN, =
"TUN: %s WINS failed using service: %s [status=3D%u if_name=3D%s]",
+      =
  msg(M_WARN, "TUN: %s WINS failed using service: %s [status=3D%d if_name=
=3D%s]",
             (add ? "adding" : "deleting"), strerror_win32(ack=2Ee=
rror_number, &gc),
             ack=2Eerror_number, wins=2Eiface=2Ename);
 =
        goto out;
@@ -389,7 +389,7 @@
 
     if (ack=2Eerror_number !=3D NO=
_ERROR)
     {
-        msg(M_NONFATAL, "TUN: setting %s mtu using service =
failed: %s [status=3D%u if_index=3D%lu]",
+        msg(M_NONFATAL, "TUN: se=
tting %s mtu using service failed: %s [status=3D%d if_index=3D%lu]",
      =
       family_name, strerror_win32(ack=2Eerror_number, &gc), ack=2Eerror_nu=
mber,
             mtu_msg=2Eiface=2Eindex);
     }
@@ -467,7 +467,7 @@
 
 =
    if (ack=2Eerror_number !=3D NO_ERROR)
     {
-        msg(M_NONFATAL, "=
TUN: creating %s adapter using service failed: %s [status=3D%u]",
+        =
msg(M_NONFATAL, "TUN: creating %s adapter using service failed: %s [status=
=3D%d]",
             print_tun_backend_driver(driver_type), strerror_win32=
(ack=2Eerror_number, &gc),
             ack=2Eerror_number);
     }
@@ -519=
2,7 +5192,7 @@
 
     if (ack=2Eerror_number !=3D NO_ERROR)
     {
-       =
 msg(M_NONFATAL, "TUN: enabling dhcp using service failed: %s [status=3D%u =
if_index=3D%lu]",
+        msg(M_NONFATAL, "TUN: enabling dhcp using servic=
e failed: %s [status=3D%d if_index=3D%lu]",
             strerror_win32(ack=
=2Eerror_number, &gc), ack=2Eerror_number, dhcp=2Eiface=2Eindex);
     }
  =
   else
@@ -5441,7 +5441,7 @@
     {
         msg(M_FATAL,
             "ER=
ROR:  This version of " PACKAGE_NAME
-            " requires a TAP-Windows =
driver that is at least version %u=2E%u -- If you recently upgraded your " =
PACKAGE_NAME
+            " requires a TAP-Windows driver that is at least =
version %d=2E%d -- If you recently upgraded your " PACKAGE_NAME
           =
  " distribution, a reboot is probably required at this point to get Window=
s to see the new driver=2E",
             TAP_WIN_MIN_MAJOR, TAP_WIN_MIN_MI=
NOR);
     }
diff --git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh
index 0=
ff2a0b=2E=2E393e856 100644
--- a/src/openvpn/tun=2Eh
+++ b/src/openvpn/tun=
=2Eh
@@ -105,7 +105,7 @@
     uint8_t netbios_node_type; /* NBT 1,2,4,8 (46=
) */
 
 /* Max # of addresses allowed for  DNS, WINS, etc=2E */
-#define N_=
DHCP_ADDR 4
+#define N_DHCP_ADDR 4u
 
     /* DNS (6) */
     in_addr_t dns=
[N_DHCP_ADDR];
diff --git a/src/openvpnmsica/msica_arg=2Ec b/src/openvpnmsi=
ca/msica_arg=2Ec
index d763d93=2E=2Ec1809f0 100644
--- a/src/openvpnmsica/m=
sica_arg=2Ec
+++ b/src/openvpnmsica/msica_arg=2Ec
@@ -57,7 +57,7 @@
     st=
ruct msica_arg *p =3D malloc(sizeof(struct msica_arg) + argument_size);
   =
  if (p =3D=3D NULL)
     {
-        msg(M_FATAL, "%s: malloc(%u) failed", =
__FUNCTION__,
+        msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__,=

             sizeof(struct msica_arg) + argument_size);
     }
     memcpy=
(p->val, argument, argument_size);
@@ -77,7 +77,7 @@
     struct msica_arg =
*p =3D malloc(sizeof(struct msica_arg) + argument_size);
     if (p =3D=3D =
NULL)
     {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__,
+=
        msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__,
             s=
izeof(struct msica_arg) + argument_size);
     }
     memcpy(p->val, argume=
nt, argument_size);
@@ -102,7 +102,7 @@
     LPWSTR str =3D malloc(size);
 =
    if (str =3D=3D NULL)
     {
-        msg(M_FATAL, "%s: malloc(%u) faile=
d", __FUNCTION__, size);
+        msg(M_FATAL, "%s: malloc(%zu) failed", __=
FUNCTION__, size);
         return NULL;
     }
 
diff --git a/src/openvpnm=
sica/msiex=2Ec b/src/openvpnmsica/msiex=2Ec
index 4d48f06=2E=2Ec6bc648 1006=
44
--- a/src/openvpnmsica/msiex=2Ec
+++ b/src/openvpnmsica/msiex=2Ec
@@ -51=
,7 +51,7 @@
         *pszValue =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR=
));
         if (*pszValue =3D=3D NULL)
         {
-            msg(M_FATAL=
, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
+      =
      msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, dwLength * sizeo=
f(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
@@ -64,7 +64=
,7 @@
         LPWSTR szBufHeap =3D (LPWSTR)malloc(++dwLength * sizeof(WCHA=
R));
         if (szBufHeap =3D=3D NULL)
         {
-            msg(M_FATA=
L, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
+     =
       msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, dwLength * size=
of(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
@@ -107,7 +=
107,7 @@
         *pszValue =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));=

         if (*pszValue =3D=3D NULL)
         {
-            msg(M_FATAL, "=
%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
+         =
   msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, dwLength * sizeof(W=
CHAR));
             return ERROR_OUTOFMEMORY;
         }
 
@@ -120,7 +120,=
7 @@
         LPWSTR szBufHeap =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR=
));
         if (szBufHeap =3D=3D NULL)
         {
-            msg(M_FATAL=
, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
+      =
      msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, dwLength * sizeo=
f(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
@@ -163,7 +1=
63,7 @@
         *pszValue =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
=
         if (*pszValue =3D=3D NULL)
         {
-            msg(M_FATAL, "%=
s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
+          =
  msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, dwLength * sizeof(WC=
HAR));
             return ERROR_OUTOFMEMORY;
         }
 
@@ -176,7 +176,7=
 @@
         LPWSTR szBufHeap =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR)=
);
         if (szBufHeap =3D=3D NULL)
         {
-            msg(M_FATAL,=
 "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
+       =
     msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, dwLength * sizeof=
(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
diff --git a/=
src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index=
 e510e4d=2E=2Ed2fd9af 100644
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/=
src/openvpnmsica/openvpnmsica=2Ec
@@ -165,7 +165,7 @@
         pAdapterAdre=
sses =3D (PIP_ADAPTER_ADDRESSES)malloc(ulAdapterAdressesSize);
         if =
(pAdapterAdresses =3D=3D NULL)
         {
-            msg(M_NONFATAL, "%s:=
 malloc(%u) failed", __FUNCTION__, ulAdapterAdressesSize);
+            msg=
(M_NONFATAL, "%s: malloc(%lu) failed", __FUNCTION__, ulAdapterAdressesSize)=
;
             uiResult =3D ERROR_OUTOFMEMORY;
             goto cleanup_pA=
dapterList;
         }
@@ -208,7 +208,7 @@
     szAdaptersTail =3D szAdapte=
rs;
     if (szAdapters =3D=3D NULL)
     {
-        msg(M_FATAL, "%s: mall=
oc(%u) failed", __FUNCTION__,
+        msg(M_FATAL, "%s: malloc(%zu) failed=
", __FUNCTION__,
             adapter_count * (38 /*GUID*/ + 1 /*separator/=
terminator*/) * sizeof(WCHAR));
         uiResult =3D ERROR_OUTOFMEMORY;
  =
       goto cleanup_pAdapterAdresses;
@@ -220,7 +220,7 @@
     szAdaptersAc=
tiveTail =3D szAdaptersActive;
     if (szAdaptersActive =3D=3D NULL)
     =
{
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__,
+        msg=
(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__,
             adapter_coun=
t * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(WCHAR));
         u=
iResult =3D ERROR_OUTOFMEMORY;
         goto cleanup_szAdapters;
@@ -405,7 =
+405,7 @@
         szPath =3D (LPWSTR)malloc((++dwPathSize) * sizeof(WCHAR)=
);
         if (szPath =3D=3D NULL)
         {
-            msg(M_FATAL, "%=
s: malloc(%u) failed", __FUNCTION__, dwPathSize * sizeof(WCHAR));
+        =
    msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, dwPathSize * sizeo=
f(WCHAR));
             uiResult =3D ERROR_OUTOFMEMORY;
             goto c=
leanup_MsiCreateRecord;
         }
diff --git a/src/openvpnserv/interactive=
=2Ec b/src/openvpnserv/interactive=2Ec
index 82b24f4=2E=2E026d5aa 100644
--=
- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@=
@ -311,7 +311,7 @@
      * Same format as error messages (3 line string) wi=
th error =3D 0 in
      * 0x%08x format, PID on line 2 and a description "P=
rocess ID" on line 3
      */
-    swprintf(buf, _countof(buf), L"0x%08x\n0=
x%08x\n%ls", 0, pid, msg);
+    swprintf(buf, _countof(buf), L"0x%08x\n0x%0=
8lx\n%ls", 0, pid, msg);
 
     WritePipeAsync(pipe, buf, (DWORD)(wcslen(bu=
f) * 2), count, events);
 }
@@ -380,7 +380,7 @@
     if (!argv)
     {
    =
     swprintf(errmsg, capacity,
-                 L"Cannot validate options=
: CommandLineToArgvW failed with error =3D 0x%08x",
+                 L"Can=
not validate options: CommandLineToArgvW failed with error =3D 0x%08lx",
  =
                GetLastError());
         goto out;
     }

-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1960?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I7f910599f0f4005f06a88a93b40417ffa3=
7022a8
Gerrit-Change-Number: 1960
Gerrit-PatchSet: 1
Gerrit-Owner: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--EEilVvYl9pc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1960?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Fix all occurrences of cppcheck invalidPrintfArgType_uint<br><br>Mostl=
y trivially correct=2E There are some exceptions, though:<br>- cppcheck tre=
ats all numerical literals as &quot;signed&quot; even<br>  though the compi=
lers would probably be more intelligent=2E<br>  Chose different work-around=
s for different occurrences=2E<br>- Needed to override PRIx64 again for Win=
dows, since there<br>  it needs to be &quot;llx&quot;, not &quot;lx&quot;=
=2E<br><br>Change-Id: I7f910599f0f4005f06a88a93b40417ffa37022a8<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-to=
ols/cppcheck-suppressions=2Exml<br>M dev-tools/openvpn-cppcheck-windows=2Ec=
fg<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/dns=2Eh<br>M src/openvpn/f=
orward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/options=2Ec<br>M src/=
openvpn/platform=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/route=2Ec<b=
r>M src/openvpn/ssl=2Ec<br>M src/openvpn/tun=2Ec<br>M src/openvpn/tun=2Eh<b=
r>M src/openvpnmsica/msica_arg=2Ec<br>M src/openvpnmsica/msiex=2Ec<br>M src=
/openvpnmsica/openvpnmsica=2Ec<br>M src/openvpnserv/interactive=2Ec<br>17 f=
iles changed, 36 insertions(+), 36 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/1960/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/dev-tools/cppcheck-suppressions=2Exml b/dev-tools/cppc=
heck-suppressions=2Exml</span><br><span>index 12521e1=2E=2E38de5f2a 100644<=
/span><br><span>--- a/dev-tools/cppcheck-suppressions=2Exml</span><br><span=
>+++ b/dev-tools/cppcheck-suppressions=2Exml</span><br><span>@@ -9,9 +9,6 @=
@</span><br><span>     &lt;id&gt;constParameterCallback&lt;/id&gt;</span><b=
r><span>   &lt;/suppress&gt;</span><br><span>   &lt;suppress&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;id&gt;invalidPrintfArgTy=
pe_uint&lt;/id&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &=
lt;/suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt=
;suppress&gt;</span><br><span>     &lt;id&gt;unusedFunction&lt;/id&gt;</spa=
n><br><span>   &lt;/suppress&gt;</span><br><span>   &lt;suppress&gt;</span>=
<br><span>diff --git a/dev-tools/openvpn-cppcheck-windows=2Ecfg b/dev-tools=
/openvpn-cppcheck-windows=2Ecfg</span><br><span>index 9ac7282=2E=2E932d586 =
100644</span><br><span>--- a/dev-tools/openvpn-cppcheck-windows=2Ecfg</span=
><br><span>+++ b/dev-tools/openvpn-cppcheck-windows=2Ecfg</span><br><span>@=
@ -7,4 +7,7 @@</span><br><span>        understand our likely()/unlikely() m=
acros=2E --&gt;</span><br><span>   &lt;define name=3D&quot;__builtin_expect=
(X,Y)&quot; value=3D&quot;(X)&quot; /&gt;</span><br><span>   &lt;define nam=
e=3D&quot;__builtin_expect_with_probability(exp,c,probability)&quot; value=
=3D&quot;(exp)&quot; /&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  &lt;!-- cppcheck understands it directly in format string, but not=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       indirectly w=
hen the format string is constructed earlier --&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;define name=3D&quot;PRIx64&quot; va=
lue=3D&quot;&amp;quot;llx&amp;quot;&quot; /&gt;</span><br><span> &lt;/def&g=
t;</span><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_w=
in=2Ec</span><br><span>index c01a4e5=2E=2E7abd06b 100644</span><br><span>--=
- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</=
span><br><span>@@ -835,7 +835,7 @@</span><br><span>         struct multi_in=
stance *mi =3D dco-&gt;c-&gt;multi-&gt;instances[stat-&gt;PeerId];</span><b=
r><span>         if (!mi)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;%s: received =
data for a non-existing peer %u&quot;, __func__, stat-&gt;PeerId);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quo=
t;%s: received data for a non-existing peer %d&quot;, __func__, stat-&gt;Pe=
erId);</span><br><span>             continue;</span><br><span>         }</s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/dns=2Eh b/src/open=
vpn/dns=2Eh</span><br><span>index 51bc2de=2E=2E2c20b0e 100644</span><br><sp=
an>--- a/src/openvpn/dns=2Eh</span><br><span>+++ b/src/openvpn/dns=2Eh</spa=
n><br><span>@@ -89,7 +89,7 @@</span><br><span> };</span><br><span> </span><=
br><span> #ifndef N_DHCP_ADDR</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define N_DHCP_ADDR 4</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define N_DHCP_ADDR 4u</span><br><span> #endif</span><br><span> <=
/span><br><span> #ifndef N_SEARCH_LIST_LEN</span><br><span>diff --git a/src=
/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 146c49=
8=2E=2E204b0b7 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><=
br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -1288,7 +1288,7 @=
@</span><br><span>             break;</span><br><span> </span><br><span>   =
      default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     msg(D_DCO_DEBUG, &quot;%s: received message of type %u - ignoring&quot=
;, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(D_DCO_DEBUG, &quot;%s: received message of type %d - ignoring&quot=
;, __func__,</span><br><span>                 dco-&gt;dco_message_type);</s=
pan><br><span>             return;</span><br><span>     }</span><br><span>d=
iff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>ind=
ex 81890d4=2E=2E3c2ebf9 100644</span><br><span>--- a/src/openvpn/init=2Ec</=
span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -258,7 +258,7 =
@@</span><br><span>         gc =3D gc_new();</span><br><span>         {</sp=
an><br><span>             struct buffer out =3D alloc_buf_gc(256, &amp;gc);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_print=
f(&amp;out, &quot;&gt;PROXY:%u,%s,%s&quot;, (l ? l-&gt;current : 0) + 1,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf=
(&amp;out, &quot;&gt;PROXY:%d,%s,%s&quot;, (l ? l-&gt;current : 0) + 1,</sp=
an><br><span>                        (proto_is_udp(ce-&gt;proto) ? &quot;UD=
P&quot; : &quot;TCP&quot;), np(ce-&gt;remote));</span><br><span>           =
  management_notify_generic(BSTR(&amp;out));</span><br><span>             m=
anagement-&gt;persist=2Especial_state_msg =3D BSTR(&amp;out);</span><br><sp=
an>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br=
><span>index 95e93da=2E=2E5a57c0a 100644</span><br><span>--- a/src/openvpn/=
options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@=
@ -5139,7 +5139,7 @@</span><br><span>         }</span><br><span>         el=
se</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            msg(msglevel, &quot;argument to --bind-dev is longer th=
an allowed %u&quot;, IFNAMSIZ - 1);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(msglevel, &quot;argument to --bind-dev is l=
onger than allowed %d&quot;, IFNAMSIZ - 1);</span><br><span>             go=
to err;</span><br><span>         }</span><br><span>     }</span><br><span>d=
iff --git a/src/openvpn/platform=2Ec b/src/openvpn/platform=2Ec</span><br><=
span>index ab581f4=2E=2Eccdd43d 100644</span><br><span>--- a/src/openvpn/pl=
atform=2Ec</span><br><span>+++ b/src/openvpn/platform=2Ec</span><br><span>@=
@ -551,7 +551,7 @@</span><br><span>         ++attempts;</span><br><span> </=
span><br><span>         if (!checked_snprintf(fname, sizeof(fname), fname_f=
mt, max_prefix_len, prefix,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                              get_random(), get_random()))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
(uint64_t)get_random(), (uint64_t)get_random()))</span><br><span>         {=
</span><br><span>             msg(M_WARN, &quot;ERROR: temporary filename t=
oo long&quot;);</span><br><span>             return NULL;</span><br><span>d=
iff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>ind=
ex d72596e=2E=2Ea514d92a 100644</span><br><span>--- a/src/openvpn/push=2Ec<=
/span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -351,7 +351,7=
 @@</span><br><span>     parse_auth_pending_keywords(buffer, &amp;server_ti=
meout);</span><br><span> </span><br><span>     msg(D_PUSH,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        &quot;AUTH_PENDING received, e=
xtending handshake timeout from %us &quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        &quot;AUTH_PENDING received, extending hands=
hake timeout from %ds &quot;</span><br><span>         &quot;to %us&quot;,</=
span><br><span>         c-&gt;options=2Ehandshake_window, min_uint(max_time=
out, server_timeout));</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 469edb3=2E=
=2Eb8bac7a 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><sp=
an>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -2822,7 +2822,7 @@</span>=
<br><span>         ret =3D (ack=2Eerror_number =3D=3D ERROR_OBJECT_ALREADY_=
EXISTS) ? RTA_EEXIST : RTA_ERROR;</span><br><span>         if (ret =3D=3D R=
TA_ERROR)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            msg(M_WARN, &quot;ERROR: route %s failed using s=
ervice: %s [status=3D%u if_index=3D%lu]&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;ERROR: route %s fa=
iled using service: %s [status=3D%d if_index=3D%lu]&quot;,</span><br><span>=
                 (add ? &quot;addition&quot; : &quot;deletion&quot;), strer=
ror_win32(ack=2Eerror_number, &amp;gc),</span><br><span>                 ac=
k=2Eerror_number, rt-&gt;iface=2Eindex);</span><br><span>         }</span><=
br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><=
span>index 6a8e78e=2E=2E3594871 100644</span><br><span>--- a/src/openvpn/ss=
l=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1690,7 =
+1690,7 @@</span><br><span>                                    options-&gt;=
ping_rec_timeout, frame-&gt;mss_fix);</span><br><span>             if (ret =
&lt; 0)</span><br><span>             {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                msg(D_DCO, &quot;Cannot set DCO peer param=
eters for peer (id=3D%u): %s&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                msg(D_DCO, &quot;Cannot set DCO peer parame=
ters for peer (id=3D%d): %s&quot;,</span><br><span>                     mul=
ti-&gt;dco_peer_id, strerror(-ret));</span><br><span>                 retur=
n false;</span><br><span>             }</span><br><span>diff --git a/src/op=
envpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 2d8f36d=2E=2E85b3=
074 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/=
src/openvpn/tun=2Ec</span><br><span>@@ -153,7 +153,7 @@</span><br><span> </=
span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WA=
RN, &quot;TUN: %s address failed using service: %s [status=3D%u if_index=3D=
%lu]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(M_WARN, &quot;TUN: %s address failed using service: %s [status=3D%d if_=
index=3D%lu]&quot;,</span><br><span>             (add ? &quot;adding&quot; =
: &quot;deleting&quot;), strerror_win32(ack=2Eerror_number, &amp;gc), ack=
=2Eerror_number,</span><br><span>             addr=2Eiface=2Eindex);</span>=
<br><span>         goto out;</span><br><span>@@ -224,7 +224,7 @@</span><br>=
<span> </span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg(M_WARN, &quot;TUN: %s DNS domains failed using service: %s [status=3D%=
u if_name=3D%s]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_WARN, &quot;TUN: %s DNS domains failed using service: %s [=
status=3D%d if_name=3D%s]&quot;,</span><br><span>             (add ? &quot;=
adding&quot; : &quot;deleting&quot;), strerror_win32(ack=2Eerror_number, &a=
mp;gc), ack=2Eerror_number,</span><br><span>             dns=2Eiface=2Ename=
);</span><br><span>         goto out;</span><br><span>@@ -294,7 +294,7 @@</=
span><br><span> </span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(M_WARN, &quot;TUN: %s %s dns failed using service: %s [status=
=3D%u if_name=3D%s]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(M_WARN, &quot;TUN: %s %s dns failed using service: %s [s=
tatus=3D%d if_name=3D%s]&quot;,</span><br><span>             (add ? &quot;a=
dding&quot; : &quot;deleting&quot;), ip_proto_name, strerror_win32(ack=2Eer=
ror_number, &amp;gc),</span><br><span>             ack=2Eerror_number, dns=
=2Eiface=2Ename);</span><br><span>         goto out;</span><br><span>@@ -35=
1,7 +351,7 @@</span><br><span> </span><br><span>     if (ack=2Eerror_number=
 !=3D NO_ERROR)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        msg(M_WARN, &quot;TUN: %s WINS failed using servic=
e: %s [status=3D%u if_name=3D%s]&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_WARN, &quot;TUN: %s WINS failed using ser=
vice: %s [status=3D%d if_name=3D%s]&quot;,</span><br><span>             (ad=
d ? &quot;adding&quot; : &quot;deleting&quot;), strerror_win32(ack=2Eerror_=
number, &amp;gc),</span><br><span>             ack=2Eerror_number, wins=2Ei=
face=2Ename);</span><br><span>         goto out;</span><br><span>@@ -389,7 =
+389,7 @@</span><br><span> </span><br><span>     if (ack=2Eerror_number !=
=3D NO_ERROR)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        msg(M_NONFATAL, &quot;TUN: setting %s mtu using serv=
ice failed: %s [status=3D%u if_index=3D%lu]&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;TUN: setting %=
s mtu using service failed: %s [status=3D%d if_index=3D%lu]&quot;,</span><b=
r><span>             family_name, strerror_win32(ack=2Eerror_number, &amp;g=
c), ack=2Eerror_number,</span><br><span>             mtu_msg=2Eiface=2Einde=
x);</span><br><span>     }</span><br><span>@@ -467,7 +467,7 @@</span><br><s=
pan> </span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
sg(M_NONFATAL, &quot;TUN: creating %s adapter using service failed: %s [sta=
tus=3D%u]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_NONFATAL, &quot;TUN: creating %s adapter using service failed: %=
s [status=3D%d]&quot;,</span><br><span>             print_tun_backend_drive=
r(driver_type), strerror_win32(ack=2Eerror_number, &amp;gc),</span><br><spa=
n>             ack=2Eerror_number);</span><br><span>     }</span><br><span>=
@@ -5192,7 +5192,7 @@</span><br><span> </span><br><span>     if (ack=2Eerro=
r_number !=3D NO_ERROR)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        msg(M_NONFATAL, &quot;TUN: enabling dhcp u=
sing service failed: %s [status=3D%u if_index=3D%lu]&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;TUN: =
enabling dhcp using service failed: %s [status=3D%d if_index=3D%lu]&quot;,<=
/span><br><span>             strerror_win32(ack=2Eerror_number, &amp;gc), a=
ck=2Eerror_number, dhcp=2Eiface=2Eindex);</span><br><span>     }</span><br>=
<span>     else</span><br><span>@@ -5441,7 +5441,7 @@</span><br><span>     =
{</span><br><span>         msg(M_FATAL,</span><br><span>             &quot;=
ERROR:  This version of &quot; PACKAGE_NAME</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            &quot; requires a TAP-Windows driver that=
 is at least version %u=2E%u -- If you recently upgraded your &quot; PACKAG=
E_NAME</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &=
quot; requires a TAP-Windows driver that is at least version %d=2E%d -- If =
you recently upgraded your &quot; PACKAGE_NAME</span><br><span>            =
 &quot; distribution, a reboot is probably required at this point to get Wi=
ndows to see the new driver=2E&quot;,</span><br><span>             TAP_WIN_=
MIN_MAJOR, TAP_WIN_MIN_MINOR);</span><br><span>     }</span><br><span>diff =
--git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh</span><br><span>index 0ff=
2a0b=2E=2E393e856 100644</span><br><span>--- a/src/openvpn/tun=2Eh</span><b=
r><span>+++ b/src/openvpn/tun=2Eh</span><br><span>@@ -105,7 +105,7 @@</span=
><br><span>     uint8_t netbios_node_type; /* NBT 1,2,4,8 (46) */</span><br=
><span> </span><br><span> /* Max # of addresses allowed for  DNS, WINS, etc=
=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define N_DHCP_=
ADDR 4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define N_DHC=
P_ADDR 4u</span><br><span> </span><br><span>     /* DNS (6) */</span><br><s=
pan>     in_addr_t dns[N_DHCP_ADDR];</span><br><span>diff --git a/src/openv=
pnmsica/msica_arg=2Ec b/src/openvpnmsica/msica_arg=2Ec</span><br><span>inde=
x d763d93=2E=2Ec1809f0 100644</span><br><span>--- a/src/openvpnmsica/msica_=
arg=2Ec</span><br><span>+++ b/src/openvpnmsica/msica_arg=2Ec</span><br><spa=
n>@@ -57,7 +57,7 @@</span><br><span>     struct msica_arg *p =3D malloc(siz=
eof(struct msica_arg) + argument_size);</span><br><span>     if (p =3D=3D N=
ULL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL=
, &quot;%s: malloc(%zu) failed&quot;, __FUNCTION__,</span><br><span>       =
      sizeof(struct msica_arg) + argument_size);</span><br><span>     }</sp=
an><br><span>     memcpy(p-&gt;val, argument, argument_size);</span><br><sp=
an>@@ -77,7 +77,7 @@</span><br><span>     struct msica_arg *p =3D malloc(si=
zeof(struct msica_arg) + argument_size);</span><br><span>     if (p =3D=3D =
NULL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATA=
L, &quot;%s: malloc(%zu) failed&quot;, __FUNCTION__,</span><br><span>      =
       sizeof(struct msica_arg) + argument_size);</span><br><span>     }</s=
pan><br><span>     memcpy(p-&gt;val, argument, argument_size);</span><br><s=
pan>@@ -102,7 +102,7 @@</span><br><span>     LPWSTR str =3D malloc(size);</=
span><br><span>     if (str =3D=3D NULL)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;%s: ma=
lloc(%u) failed&quot;, __FUNCTION__, size);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;%s: malloc(%zu) failed&q=
uot;, __FUNCTION__, size);</span><br><span>         return NULL;</span><br>=
<span>     }</span><br><span> </span><br><span>diff --git a/src/openvpnmsic=
a/msiex=2Ec b/src/openvpnmsica/msiex=2Ec</span><br><span>index 4d48f06=2E=
=2Ec6bc648 100644</span><br><span>--- a/src/openvpnmsica/msiex=2Ec</span><b=
r><span>+++ b/src/openvpnmsica/msiex=2Ec</span><br><span>@@ -51,7 +51,7 @@<=
/span><br><span>         *pszValue =3D (LPWSTR)malloc(++dwLength * sizeof(W=
CHAR));</span><br><span>         if (*pszValue =3D=3D NULL)</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__, dwLength * =
sizeof(WCHAR));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(M_FATAL, &quot;%s: malloc(%zu) failed&quot;, __FUNCTION__, dwLe=
ngth * sizeof(WCHAR));</span><br><span>             return ERROR_OUTOFMEMOR=
Y;</span><br><span>         }</span><br><span> </span><br><span>@@ -64,7 +6=
4,7 @@</span><br><span>         LPWSTR szBufHeap =3D (LPWSTR)malloc(++dwLen=
gth * sizeof(WCHAR));</span><br><span>         if (szBufHeap =3D=3D NULL)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION_=
_, dwLength * sizeof(WCHAR));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(M_FATAL, &quot;%s: malloc(%zu) failed&quot;, __FU=
NCTION__, dwLength * sizeof(WCHAR));</span><br><span>             return ER=
ROR_OUTOFMEMORY;</span><br><span>         }</span><br><span> </span><br><sp=
an>@@ -107,7 +107,7 @@</span><br><span>         *pszValue =3D (LPWSTR)mallo=
c(++dwLength * sizeof(WCHAR));</span><br><span>         if (*pszValue =3D=
=3D NULL)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, =
__FUNCTION__, dwLength * sizeof(WCHAR));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(M_FATAL, &quot;%s: malloc(%zu) failed&=
quot;, __FUNCTION__, dwLength * sizeof(WCHAR));</span><br><span>           =
  return ERROR_OUTOFMEMORY;</span><br><span>         }</span><br><span> </s=
pan><br><span>@@ -120,7 +120,7 @@</span><br><span>         LPWSTR szBufHeap=
 =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));</span><br><span>         i=
f (szBufHeap =3D=3D NULL)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;%s: malloc(%=
u) failed&quot;, __FUNCTION__, dwLength * sizeof(WCHAR));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;%s: ma=
lloc(%zu) failed&quot;, __FUNCTION__, dwLength * sizeof(WCHAR));</span><br>=
<span>             return ERROR_OUTOFMEMORY;</span><br><span>         }</sp=
an><br><span> </span><br><span>@@ -163,7 +163,7 @@</span><br><span>        =
 *pszValue =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));</span><br><span>=
         if (*pszValue =3D=3D NULL)</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;%s:=
 malloc(%u) failed&quot;, __FUNCTION__, dwLength * sizeof(WCHAR));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &qu=
ot;%s: malloc(%zu) failed&quot;, __FUNCTION__, dwLength * sizeof(WCHAR));</=
span><br><span>             return ERROR_OUTOFMEMORY;</span><br><span>     =
    }</span><br><span> </span><br><span>@@ -176,7 +176,7 @@</span><br><span=
>         LPWSTR szBufHeap =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));<=
/span><br><span>         if (szBufHeap =3D=3D NULL)</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_=
FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__, dwLength * sizeof(W=
CHAR));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(M_FATAL, &quot;%s: malloc(%zu) failed&quot;, __FUNCTION__, dwLength * s=
izeof(WCHAR));</span><br><span>             return ERROR_OUTOFMEMORY;</span=
><br><span>         }</span><br><span> </span><br><span>diff --git a/src/op=
envpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec</span><br><=
span>index e510e4d=2E=2Ed2fd9af 100644</span><br><span>--- a/src/openvpnmsi=
ca/openvpnmsica=2Ec</span><br><span>+++ b/src/openvpnmsica/openvpnmsica=2Ec=
</span><br><span>@@ -165,7 +165,7 @@</span><br><span>         pAdapterAdres=
ses =3D (PIP_ADAPTER_ADDRESSES)malloc(ulAdapterAdressesSize);</span><br><sp=
an>         if (pAdapterAdresses =3D=3D NULL)</span><br><span>         {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_NONFAT=
AL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__, ulAdapterAdressesSize)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_=
NONFATAL, &quot;%s: malloc(%lu) failed&quot;, __FUNCTION__, ulAdapterAdress=
esSize);</span><br><span>             uiResult =3D ERROR_OUTOFMEMORY;</span=
><br><span>             goto cleanup_pAdapterList;</span><br><span>        =
 }</span><br><span>@@ -208,7 +208,7 @@</span><br><span>     szAdaptersTail =
=3D szAdapters;</span><br><span>     if (szAdapters =3D=3D NULL)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
sg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;%s: mal=
loc(%zu) failed&quot;, __FUNCTION__,</span><br><span>             adapter_c=
ount * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(WCHAR));</span><=
br><span>         uiResult =3D ERROR_OUTOFMEMORY;</span><br><span>         =
goto cleanup_pAdapterAdresses;</span><br><span>@@ -220,7 +220,7 @@</span><b=
r><span>     szAdaptersActiveTail =3D szAdaptersActive;</span><br><span>   =
  if (szAdaptersActive =3D=3D NULL)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;%s: malloc(=
%u) failed&quot;, __FUNCTION__,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_FATAL, &quot;%s: malloc(%zu) failed&quot;, __FUNC=
TION__,</span><br><span>             adapter_count * (38 /*GUID*/ + 1 /*sep=
arator/terminator*/) * sizeof(WCHAR));</span><br><span>         uiResult =
=3D ERROR_OUTOFMEMORY;</span><br><span>         goto cleanup_szAdapters;</s=
pan><br><span>@@ -405,7 +405,7 @@</span><br><span>         szPath =3D (LPWS=
TR)malloc((++dwPathSize) * sizeof(WCHAR));</span><br><span>         if (szP=
ath =3D=3D NULL)</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;%s: malloc(%u) failed&=
quot;, __FUNCTION__, dwPathSize * sizeof(WCHAR));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;%s: malloc(%zu=
) failed&quot;, __FUNCTION__, dwPathSize * sizeof(WCHAR));</span><br><span>=
             uiResult =3D ERROR_OUTOFMEMORY;</span><br><span>             g=
oto cleanup_MsiCreateRecord;</span><br><span>         }</span><br><span>dif=
f --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec=
</span><br><span>index 82b24f4=2E=2E026d5aa 100644</span><br><span>--- a/sr=
c/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interac=
tive=2Ec</span><br><span>@@ -311,7 +311,7 @@</span><br><span>      * Same f=
ormat as error messages (3 line string) with error =3D 0 in</span><br><span=
>      * 0x%08x format, PID on line 2 and a description &quot;Process ID&qu=
ot; on line 3</span><br><span>      */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    swprintf(buf, _countof(buf), L&quot;0x%08x\n0x%08x\n%l=
s&quot;, 0, pid, msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    swprintf(buf, _countof(buf), L&quot;0x%08x\n0x%08lx\n%ls&quot;, 0, p=
id, msg);</span><br><span> </span><br><span>     WritePipeAsync(pipe, buf, =
(DWORD)(wcslen(buf) * 2), count, events);</span><br><span> }</span><br><spa=
n>@@ -380,7 +380,7 @@</span><br><span>     if (!argv)</span><br><span>     =
{</span><br><span>         swprintf(errmsg, capacity,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                 L&quot;Cannot validate opt=
ions: CommandLineToArgvW failed with error =3D 0x%08x&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 L&quot;Cannot val=
idate options: CommandLineToArgvW failed with error =3D 0x%08lx&quot;,</spa=
n><br><span>                  GetLastError());</span><br><span>         got=
o out;</span><br><span>     }</span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1960?usp=3Demail">change 1960</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1960?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7f9105=
99f0f4005f06a88a93b40417ffa37022a8 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1960 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--EEilVvYl9pc=--


--===============2975665683876173708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2975665683876173708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2975665683876173708==--

