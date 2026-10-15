Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BE8CC6B33
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w8jaTcD6MIVjDAzZ/USRVGqqpMd5pE1A4VeIr6AkxzU=; b=dZfg1wxltVss1w9Fe6n6lJ0jLM
	vlONSkndIkuD7wB5XtN5BcYSWYIXrbkwOMEJjiTZTXVEGP4CoGUDj3KGh0c2qaiGQKo9N3IgPD/rU
	WPfX5nbVRFOcXTGGD6GiUoCXK/2g8Dctoxij9zlYDJbyiR+lc83r0IsFGWVIsznlcOw0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHNNZ-0002VR-Qw;
	Thu, 15 Oct 2026 15:28:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHNNX-0002VF-7c
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:28:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1LuoN0dNyKpJc9hyhYIU37+sn3Fk+xDnuhrYUsm+bmQ=; b=BEdWtfq127mJ3xiXo4mPxsAjXI
 LgW3WEJ9XllOg1Gg6ZA07aUE4B46ueVblrRohmxccFhtSi4dlymMGwHsjDVThhg+UBlYVrExKqSs/
 SxWhu53EbHcD5KeDI70KOJ3IgOZCfhM2iIZImTnwfVTIpcKD30TpPeVQQ86CJwRtqt2E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1LuoN0dNyKpJc9hyhYIU37+sn3Fk+xDnuhrYUsm+bmQ=; b=A
 H/2vPX0Iz1c+valMalX8D96TS+y+Q0bDAdTtlF/8U/cX229pfFVO9oogzQmgSDlgpDqC3SW2Z/Oq+
 mLqpCxQPe/mdaULM0xXcsWz45OgQ+Aiajmy8EYtP/LoexgHMLObqMQU7YTBgOtcuOYIlp514nE20G
 uONAuyaR7IkgEOwI=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHNNO-00022E-3O for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:28:20 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso39941395e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792078087; x=1792682887; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1LuoN0dNyKpJc9hyhYIU37+sn3Fk+xDnuhrYUsm+bmQ=;
 b=PAWtLxUwxaaT8LjX4SKCHRvvj9am8e1OA1FPDtJEdD0LUERW0TDvvoXidnFBOCscMw
 r4MJA2JC2bL4GvOzPePpLjJCRKPT87QE2R/78vaJHWFt6QM6qliZy96U530OteK0KCsc
 gHCBzK/7n9RGfodZyFWZXb9F4NHduxU39/ig6tclJX0SuT0JbayKy+TVLC+V79sOpgUi
 fsFUIg6TUwICqEVvXlCuET0YptGghoLakeM5KJ3hVfIKDcQein0F4C4ff3zzKCdoadpF
 M4B0UwHmHq6p6G5THKiTURFRK/546CRLWf+xCUfbRqYVG5Sy0TVuoDfcocCPYi8TEtGm
 Pgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792078087; x=1792682887;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1LuoN0dNyKpJc9hyhYIU37+sn3Fk+xDnuhrYUsm+bmQ=;
 b=1ISFN45jpDiBoJUazR6KScjo4qg/qmsPWmBoHFkyHnbkh22PRQ6xhxFH3h/EuZBqfC
 /ihrZeKnecevfgjSFUs9NrlAdorUZb7GII2dWEB3yaAnVrZCxBRuKf6Reh+Eg2HSgrx4
 sa8YcD+8YUnFzAn7Vjj1yBNdjBp3QpegJaLjOYX67bNIY2DyQYSht/CNsJLGVobdqPQ8
 LIeHSQPq9PHe+5STNP21eM3kJBQuXa/8w6AAQNdfgcWjzwC09WBVZNL3R6SHfa+M1Iad
 mpFyrWm3blJ81uJskTT+4Kg3wYfUqAAI8NvPm3e+aI2N90MV+5NaGCAb2UIDkrY8GI7q
 51uw==
X-Forwarded-Encrypted: i=1;
 AKwUvBythbiOKbtTtB+02GD13NtEFF5zBle97XHddKOYyeqi/Fqv1uQM/+aA6xpdJmUssIWc8evZrBzV9/AtuUlk@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIvN6R+WwM2JOJcbtGFlfLy7GxkguaD0d0OkvTsRMdY15HMYPFk
 tZCPapka0eFWxyEA+CrLRAlCEOY9gs+QD8bTTrTmKJKOn0XdmGr1pDjrGt+dlmhZKitTWzgEH9U
 52ILIFWaYGZ6IVN1qureqM97dQhIeZmdkTXAfrpQnvt2NTsWDVnD6548CKj3wXM0cc9aCHC/ghv
 vIDJ5wOg==
X-Gm-Gg: AYBFou1Xl0R929ojkiH7c+TdOAnIZikCcJuLiV9Sz5PC1lvRYgL1AduQ+u5FlnHwcZL
 E9QWrxoZjKK4wenOpay1xlRJYWYqWMwxGobQFRWrlZ9MCTUn4dB8UOdp0yFA2BZh/6Eh3wH2P70
 Vp0CNTRnSjPN63dPbRa0y9Q63xiNlHiROXrDRmS7GeJP0TCmsJMNHxwdrOQIuoe52YzKdS/vmi3
 IaCPSSni5Se2vf11jUSk1ma9tuYh0EXNbPjvcERfV62/h2Kl2ZfHVJWac4X4z+hri5X3Tg4Wgaj
 bRLKydHh6NQB1xxDxOn8DQlcjaFJ5K0VC8DJ6CTcy2wj7UsinmFJIS2uEr4jWza8Bsu2+qY6Dtv
 SaAaJQYjZusVGttKhWHnYWDLSt1ffAFXQa9qRgveJOf4tAFapV95VPbdSPU6FYqS5F+0mk3W2JP
 CUOtv4GBq12ohCAGtXaUC/hTHiIJ0vv9kyeXpMMTPJxxhK7t/o+onOpnXKBgH9n2EcfD3YXXFgU
 W/qQVPKpY6jt1/wkT05FIdtYuyy8XME5S0MbQU6K+rMSBi0CLoQ1hrI/8AWrkNE38iQJcefLPDG
 EpPsivx7PN/WvOL9ocrP+BKJ6JktOUjHqVOq1Wgd2rfZi1ej5VnG+1PwkU2fYg==
X-Received: by 2002:a05:600c:83c9:b0:4a1:70f0:ac2 with SMTP id
 5b1f17b1804b1-4a18e4ce9cfmr394416515e9.24.1792078085252; 
 Thu, 15 Oct 2026 08:28:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd66ab3dsm73202165e9.2.2026.10.15.08.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:28:04 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 15:28:02 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 33
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 571caa34e2fe134029a57769df8182b1c31e33a4
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <89784f00bf167b618ec92088030bbb938be5bf4c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHNNO-00022E-3O
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2269079378324963013=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2269079378324963013==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BirTy59K7JQ="; charset=UTF-8

--BirTy59K7JQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1663?usp=3Demail )

Change subject: Remove instances of constPa=
rameterPointer cppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Remove instances of constParameterPointer cppcheck warn=
ings

This requires a few suppressions since cppcheck
doesn't quite underst=
and the different code-paths
implemented by preprocessor defines=2E

Change=
-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
Signed-off-by: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663
Message=
-Id: <20261015113218=2E24245-1-gert@greenie=2Emuc=2Ede>
URL: https://lore=
=2Ekernel=2Eorg/openvpn-devel/20261015113218=2E24245-1-gert@greenie=2Emuc=
=2Ede/
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M dev-tool=
s/cppcheck-suppressions=2Exml
M sample/sample-plugins/client-connect/sample=
-client-connect=2Ec
M sample/sample-plugins/defer/multi-auth=2Ec
M sample/s=
ample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec
M sr=
c/openvpn/buffer=2Eh
M src/openvpn/clinat=2Ec
M src/openvpn/comp=2Ec
M src/=
openvpn/comp=2Eh
M src/openvpn/crypto=2Ec
M src/openvpn/crypto=2Eh
M src/op=
envpn/dco=2Ec
M src/openvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
M src/ope=
nvpn/dco_internal=2Eh
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_win=2Ec=

M src/openvpn/error=2Ec
M src/openvpn/error=2Eh
M src/openvpn/event=2Ec
M =
src/openvpn/event=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/forward=2Eh
M=
 src/openvpn/init=2Ec
M src/openvpn/init=2Eh
M src/openvpn/interval=2Eh
M s=
rc/openvpn/list=2Ec
M src/openvpn/list=2Eh
M src/openvpn/manage=2Ec
M src/o=
penvpn/manage=2Eh
M src/openvpn/mbuf=2Ec
M src/openvpn/mbuf=2Eh
M src/openv=
pn/mss=2Ec
M src/openvpn/mss=2Eh
M src/openvpn/mtcp=2Ec
M src/openvpn/mtcp=
=2Eh
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh=

M src/openvpn/multi_io=2Ec
M src/openvpn/networking=2Eh
M src/openvpn/netw=
orking_iproute2=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/openvpn/occ=2E=
h
M src/openvpn/openssl_compat=2Eh
M src/openvpn/options=2Ec
M src/openvpn/=
options_parse=2Ec
M src/openvpn/otime=2Ec
M src/openvpn/otime=2Eh
M src/ope=
nvpn/proto=2Eh
M src/openvpn/proxy=2Ec
M src/openvpn/proxy=2Eh
M src/openvp=
n/ps=2Ec
M src/openvpn/ps=2Eh
M src/openvpn/push=2Ec
M src/openvpn/push=2Eh=

M src/openvpn/push_util=2Ec
M src/openvpn/reliable=2Ec
M src/openvpn/relia=
ble=2Eh
M src/openvpn/route=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/sock=
et=2Eh
M src/openvpn/socket_util=2Eh
M src/openvpn/socks=2Ec
M src/openvpn/=
socks=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl=2Eh
M src/openvpn/ssl_bac=
kend=2Eh
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/=
openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M src/openvpn/ssl_verify=2Ec
=
M src/openvpn/ssl_verify=2Eh
M src/openvpn/status=2Ec
M src/openvpn/status=
=2Eh
M src/openvpn/tun=2Ec
M src/openvpn/tun=2Eh
M src/openvpn/tun_afunix=
=2Ec
M src/openvpn/tun_afunix=2Eh
M src/openvpn/vlan=2Ec
M src/openvpn/vlan=
=2Eh
M src/openvpn/win32=2Eh
M src/openvpnmsica/openvpnmsica=2Ec
M src/open=
vpnserv/interactive=2Ec
M tests/unit_tests/openvpn/mock_management=2Ec
M te=
sts/unit_tests/openvpn/siphash_openssl=2Ec
M tests/unit_tests/openvpn/test_=
misc=2Ec
M tests/unit_tests/openvpn/test_user_pass=2Ec
88 files changed, 39=
8 insertions(+), 284 deletions(-)




diff --git a/dev-tools/cppcheck-suppr=
essions=2Exml b/dev-tools/cppcheck-suppressions=2Exml
index 9d8c202=2E=2Ebd=
24c3b 100644
--- a/dev-tools/cppcheck-suppressions=2Exml
+++ b/dev-tools/cp=
pcheck-suppressions=2Exml
@@ -9,9 +9,6 @@
     <id>constParameterCallback</=
id>
   </suppress>
   <suppress>
-    <id>constParameterPointer</id>
-  </s=
uppress>
-  <suppress>
     <id>unusedFunction</id>
   </suppress>
   <supp=
ress>
@@ -65,6 +62,97 @@
     <id>badBitmaskCheck</id>
     <fileName>tests=
/unit_tests/openvpn/test_pkt=2Ec</fileName>
   </suppress>
+  <!-- IGN: we =
use casts to remove const -->
+  <suppress>
+    <id>constParameterPointer<=
/id>
+    <fileName>src/openvpn/buffer=2Eh</fileName>
+    <symbolName>buf<=
/symbolName>
+  </suppress>
+  <!-- FP: const silently removed due to point=
er arithmetic -->
+  <suppress>
+    <id>constParameterPointer</id>
+    <f=
ileName>src/openvpn/buffer=2Ec</fileName>
+    <symbolName>buf</symbolName>=

+  </suppress>
+  <!-- IGN: external -->
+  <suppress>
+    <id>constParam=
eterPointer</id>
+    <fileName>/usr/include/*</fileName>
+  </suppress>
+ =
 <!-- IGN: too many false-positives due to stubs -->
+  <suppress>
+    <id=
>constParameterPointer</id>
+    <fileName>tests/unit_tests/openvpn*/test_*=
</fileName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id=
>
+    <fileName>tests/unit_tests/openvpn/mock_*</fileName>
+  </suppress>
=
+  <!-- IGN: too many false-positives due to library/platform-specific code=
 -->
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/o=
penvpn/crypto*</fileName>
+  </suppress>
+  <suppress>
+    <id>constParame=
terPointer</id>
+    <fileName>src/openvpn/ssl_*</fileName>
+  </suppress>
=
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvp=
n/dco*</fileName>
+  </suppress>
+  <suppress>
+    <id>constParameterPoint=
er</id>
+    <fileName>src/openvpn/socket=2E*</fileName>
+  </suppress>
+  =
<!-- FP: const is only possible on some platforms
+       These might easil=
y hide valid issues but we need to compromise
+       for developer sanity=
=2E
+       Inline suppressions are often too ugly since they need to go in=

+       between our return type line and the function name=2E=2E=2E
+  -->=

+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openv=
pn/dns=2Ec</fileName>
+    <symbolName>duri</symbolName>
+  </suppress>
+  =
<suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/e=
rror=2Ec</fileName>
+    <symbolName>gc</symbolName>
+  </suppress>
+  <sup=
press>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/forwa=
rd=2Ec</fileName>
+    <symbolName>dco</symbolName>
+  </suppress>
+  <supp=
ress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/manage=
=2Ec</fileName>
+    <symbolName>man</symbolName>
+  </suppress>
+  <suppre=
ss>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/misc=2Ec=
</fileName>
+    <symbolName>up</symbolName>
+  </suppress>
+  <suppress>
+=
    <id>constParameterPointer</id>
+    <fileName>src/openvpn/options=2Ec</=
fileName>
+    <symbolName>options</symbolName>
+  </suppress>
+  <suppress=
>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/tun=2Ec</f=
ileName>
+    <symbolName>gc</symbolName>
+  </suppress>
+  <!-- IGN: weird=
 issue with MinGW debug build throwing -Werror=3Dmaybe-uninitialized
+     =
  for no good reason -->
+  <suppress>
+    <id>constParameterPointer</id>
=
+    <fileName>src/openvpn/buffer=2Eh</fileName>
+    <symbolName>p</symbol=
Name>
+  </suppress>
   <!-- FP: cppcheck seems to have wrong signature of =
DeviceIoControl() -->
   <suppress>
     <id>constVariablePointer</id>
diff=
 --git a/sample/sample-plugins/client-connect/sample-client-connect=2Ec b/s=
ample/sample-plugins/client-connect/sample-client-connect=2Ec
index 420de61=
=2E=2Ecbd98e8 100644
--- a/sample/sample-plugins/client-connect/sample-clie=
nt-connect=2Ec
+++ b/sample/sample-plugins/client-connect/sample-client-con=
nect=2Ec
@@ -344,7 +344,7 @@
 }
 
 int
-openvpn_plugin_client_connect(struc=
t plugin_context *context, const char **argv, const char **envp)
+openvpn_p=
lugin_client_connect(const struct plugin_context *context, const char **arg=
v, const char **envp)
 {
     /* log environment variables handed to us by =
OpenVPN, but
      * only if "setenv verb" is 3 or higher (arbitrary number=
)
@@ -465,7 +465,7 @@
 
 int
 openvpn_plugin_client_connect_defer_v2(struct=
 plugin_context *context,
-                                       struct pl=
ugin_per_client_context *pcc,
+                                       const=
 struct plugin_per_client_context *pcc,
                                   =
     struct openvpn_plugin_string_list **return_list)
 {
     time_t time_l=
eft =3D pcc->sleep_until - time(NULL);
diff --git a/sample/sample-plugins/d=
efer/multi-auth=2Ec b/sample/sample-plugins/defer/multi-auth=2Ec
index bacf=
557=2E=2Ecdd616f 100644
--- a/sample/sample-plugins/defer/multi-auth=2Ec
++=
+ b/sample/sample-plugins/defer/multi-auth=2Ec
@@ -255,7 +255,7 @@
 }
 
 st=
atic bool
-do_auth_user_pass(struct plugin_context *context, const char *us=
ername, const char *password)
+do_auth_user_pass(const struct plugin_contex=
t *context, const char *username, const char *password)
 {
     plog(contex=
t, PLOG_NOTE, "expect_user=3D%s, received_user=3D%s, expect_passw=3D%s, rec=
eived_passw=3D%s",
          np(context->test_valid_user), np(username), np=
(context->test_valid_pass), np(password));
@@ -279,7 +279,7 @@
 
 
 static =
int
-auth_user_pass_verify(struct plugin_context *context, struct plugin_pe=
r_client_context *pcc,
+auth_user_pass_verify(const struct plugin_context *=
context, struct plugin_per_client_context *pcc,
                       cons=
t char *argv[], const char *envp[])
 {
     /* get username/password from e=
nvp string array */
diff --git a/sample/sample-plugins/keying-material-expo=
rter-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins/keying-materia=
l-exporter-demo/keyingmaterialexporter=2Ec
index 204374b=2E=2E41c5c4f 10064=
4
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmateriale=
xporter=2Ec
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyin=
gmaterialexporter=2Ec
@@ -187,7 +187,7 @@
 }
 
 static void
-file_store(cha=
r *file, char *content)
+file_store(const char *file, const char *content)
=
 {
     FILE *f;
     if (!(f =3D fopen(file, "w+")))
@@ -203,7 +203,7 @@
 =
server_store(struct openvpn_plugin_args_func_in const *args)
 {
     struct=
 plugin *plugin =3D (struct plugin *)args->handle;
-    struct session *ses=
s =3D (struct session *)args->per_client_context;
+    const struct session=
 *sess =3D args->per_client_context;
 
     char file[MAXPATH];
     snprin=
tf(file, sizeof(file) - 1, "/tmp/openvpn_sso_%s", sess->key);
@@ -215,7 +21=
5,7 @@
 client_store(struct openvpn_plugin_args_func_in const *args)
 {
   =
  struct plugin *plugin =3D (struct plugin *)args->handle;
-    struct sess=
ion *sess =3D (struct session *)args->per_client_context;
+    const struct=
 session *sess =3D args->per_client_context;
 
     char *file =3D "/tmp/op=
envpn_sso_user";
     ovpn_note("app session file: %s", file);
diff --git a=
/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 58e10f0=2E=2E063a2d4=
 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1920,=
7 +1920,7 @@
  * @param a  The arena to test=2E
  */
 static inline bool
-g=
c_defined(struct gc_arena *a)
+gc_defined(const struct gc_arena *a)
 {
    =
 return a->list !=3D NULL;
 }
diff --git a/src/openvpn/clinat=2Ec b/src/ope=
nvpn/clinat=2Ec
index dcef924=2E=2Ed72d42a 100644
--- a/src/openvpn/clinat=
=2Ec
+++ b/src/openvpn/clinat=2Ec
@@ -158,7 +158,7 @@
 #endif
 
 static voi=
d
-print_pkt(struct openvpn_iphdr *iph, const char *prefix, const int direc=
tion, const msglvl_t msglevel)
+print_pkt(const struct openvpn_iphdr *iph, =
const char *prefix, const int direction, const msglvl_t msglevel)
 {
     s=
truct gc_arena gc =3D gc_new();
 
diff --git a/src/openvpn/comp=2Ec b/src/o=
penvpn/comp=2Ec
index b88b79f=2E=2E387a7c4 100644
--- a/src/openvpn/comp=2E=
c
+++ b/src/openvpn/comp=2Ec
@@ -159,7 +159,7 @@
 #endif /* USE_COMP */
 
 =
bool
-check_compression_settings_valid(struct compress_options *info, msglv=
l_t msglevel)
+check_compression_settings_valid(const struct compress_optio=
ns *info, msglvl_t msglevel)
 {
     /*
      * We also allow comp-stub-v2 =
here as it technically allows escaping of
diff --git a/src/openvpn/comp=2Eh=
 b/src/openvpn/comp=2Eh
index 29a90a2=2E=2Ead80243 100644
--- a/src/openvpn=
/comp=2Eh
+++ b/src/openvpn/comp=2Eh
@@ -91,7 +91,7 @@
  * flags of allow-c=
ompression and also the whether algorithms are compiled
  * in
  */
-bool c=
heck_compression_settings_valid(struct compress_options *info, msglvl_t msg=
level);
+bool check_compression_settings_valid(const struct compress_option=
s *info, msglvl_t msglevel);
 
 #ifdef USE_COMP
 #include "buffer=2Eh"
diff=
 --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index 1703d4d=2E=
=2E3d3ab0c 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec=

@@ -1105,7 +1105,7 @@
 }
 
 static bool
-key_is_zero(struct key *key, cons=
t struct key_type *kt)
+key_is_zero(const struct key *key, const struct key=
_type *kt)
 {
     size_t cipher_length =3D cipher_kt_key_size(kt->cipher);=

     for (size_t i =3D 0; i < cipher_length; ++i)
@@ -1123,7 +1123,7 @@
  =
* Make sure that cipher key is a valid key for current key_type=2E
  */
 bo=
ol
-check_key(struct key *key, const struct key_type *kt)
+check_key(const =
struct key *key, const struct key_type *kt)
 {
     if (cipher_defined(kt->=
cipher))
     {
@@ -1196,7 +1196,7 @@
 }
 
 void
-test_crypto(struct crypto=
_options *co, struct frame *frame)
+test_crypto(struct crypto_options *co, =
const struct frame *frame)
 {
     int i, j;
     struct gc_arena gc =3D gc=
_new();
diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index =
ee5b50f=2E=2Ee3c1c6a 100644
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/=
crypto=2Eh
@@ -414,7 +414,7 @@
  */
 int write_key_file(const int nkeys, co=
nst char *filename);
 
-bool check_key(struct key *key, const struct key_ty=
pe *kt);
+bool check_key(const struct key *key, const struct key_type *kt);=

 
 /**
  * Initialize a key_type structure with=2E
@@ -614,7 +614,7 @@
 /*=
* Print a cipher list entry */
 void print_cipher(const char *cipher);
 
-v=
oid test_crypto(struct crypto_options *co, struct frame *f);
+void test_cry=
pto(struct crypto_options *co, const struct frame *f);
 
 
 /* key directio=
n functions */
diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index=
 9fc0e3b=2E=2Ef3b5d44 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dc=
o=2Ec
@@ -573,7 +573,7 @@
 }
 
 static bool
-dco_multi_get_localaddr(struct=
 multi_context *m, struct multi_instance *mi,
+dco_multi_get_localaddr(cons=
t struct multi_context *m, const struct multi_instance *mi,
               =
          struct sockaddr_storage *local)
 {
 #if ENABLE_IP_PKTINFO
@@ -585=
,7 +585,7 @@
         return false;
     }
 
-    struct link_socket_actual=
 *actual =3D &c->c2=2Elink_socket_infos[0]->lsa->actual;
+    const struct =
link_socket_actual *actual =3D &c->c2=2Elink_socket_infos[0]->lsa->actual;
=
 
     switch (actual->dest=2Eaddr=2Esa=2Esa_family)
     {
@@ -623,7 +623,=
7 @@
 }
 
 int
-dco_multi_add_new_peer(struct multi_context *m, struct mult=
i_instance *mi)
+dco_multi_add_new_peer(const struct multi_context *m, stru=
ct multi_instance *mi)
 {
     const struct context *c =3D &mi->context;
 
=
@@ -677,7 +677,7 @@
 }
 
 void
-dco_install_iroute(struct multi_context *m,=
 struct multi_instance *mi, struct mroute_addr *addr)
+dco_install_iroute(s=
truct multi_context *m, struct multi_instance *mi, const struct mroute_addr=
 *addr)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined=
(_WIN32)
     if (!dco_enabled(&m->top=2Eoptions))
diff --git a/src/openvpn=
/dco=2Eh b/src/openvpn/dco=2Eh
index 7ef75fee=2E=2Ec435f8c 100644
--- a/src=
/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -204,7 +204,7 @@
  * @param m=
i        the client instance
  * @return          0 on success or a negativ=
e error code otherwise
  */
-int dco_multi_add_new_peer(struct multi_contex=
t *m, struct multi_instance *mi);
+int dco_multi_add_new_peer(const struct =
multi_context *m, struct multi_instance *mi);
 
 /**
  * Install an iroute =
in DCO, which means adding a route to the system routing
@@ -215,7 +215,7 @=
@
  * @param addr      the route to add
  */
 void dco_install_iroute(struc=
t multi_context *m, struct multi_instance *mi,
-                        str=
uct mroute_addr *addr);
+                        const struct mroute_addr *=
addr);
 
 /**
  * Remove all routes added through the specified client
@@ -=
253,7 +253,7 @@
  * a 64 bit packet counter and AEAD tag at the end=2E
  */=

 bool
-dco_supports_epoch_data(struct context *c);
+dco_supports_epoch_dat=
a(const struct context *c);
 #else  /* if defined(ENABLE_DCO) */
 
 typedef=
 void *dco_context_t;
@@ -350,7 +350,7 @@
 }
 
 static inline int
-dco_mult=
i_add_new_peer(struct multi_context *m, struct multi_instance *mi)
+dco_mul=
ti_add_new_peer(const struct multi_context *m, struct multi_instance *mi)
 =
{
     return 0;
 }
@@ -384,7 +384,7 @@
 }
 
 static inline bool
-dco_suppo=
rts_epoch_data(struct context *c)
+dco_supports_epoch_data(const struct con=
text *c)
 {
     return false;
 }
diff --git a/src/openvpn/dco_freebsd=2Ec =
b/src/openvpn/dco_freebsd=2Ec
index 87eea55=2E=2E3148f10 100644
--- a/src/o=
penvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -929,7 +929,7 @=
@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_epoc=
h_data(const struct context *c)
 {
     return false;
 }
diff --git a/src/o=
penvpn/dco_internal=2Eh b/src/openvpn/dco_internal=2Eh
index fcf8aca=2E=2E1=
022e66 100644
--- a/src/openvpn/dco_internal=2Eh
+++ b/src/openvpn/dco_inte=
rnal=2Eh
@@ -59,8 +59,9 @@
  * They are implemented by dco_linux=2Ec
  */
 =

-int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descript=
or_t sd, struct sockaddr *localaddr,
-                 struct sockaddr *rem=
oteaddr, const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);
=
+int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descripto=
r_t sd,
+                 struct sockaddr *localaddr, struct sockaddr *remo=
teaddr,
+                 const struct in_addr *vpn_ipv4, const struct in6_=
addr *vpn_ipv6);
 
 int dco_del_peer(dco_context_t *dco, unsigned int peeri=
d);
 
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
in=
dex a397fb8=2E=2E4412ad0 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/o=
penvpn/dco_linux=2Ec
@@ -104,7 +104,7 @@
 }
 
 static struct nl_msg *
-ovpn=
_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)
+ovpn_dco_nlmsg_create(c=
onst dco_context_t *dco, uint8_t cmd)
 {
     struct nl_msg *nl_msg =3D nlm=
sg_alloc();
     if (!nl_msg)
@@ -842,7 +842,7 @@
 
 /* libnl < 3=2E11=2E0 =
does not implement nla_get_uint() */
 static uint64_t
-ovpn_nla_get_uint(st=
ruct nlattr *attr)
+ovpn_nla_get_uint(const struct nlattr *attr)
 {
     if=
 (nla_len(attr) =3D=3D sizeof(uint32_t))
     {
@@ -954,7 +954,7 @@
 }
 
 s=
tatic bool
-ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs[])
+o=
vpn_iface_check(const dco_context_t *dco, struct nlattr *attrs[])
 {
     /=
* we must know which interface this message is referring to in order to
   =
   * avoid mixing messages for other instances
@@ -1381,7 +1381,7 @@
 }
 
 =
bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_epoch_data(c=
onst struct context *c)
 {
     return false;
 }
diff --git a/src/openvpn/d=
co_win=2Ec b/src/openvpn/dco_win=2Ec
index 6e5e295=2E=2E12b0666 100644
--- =
a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -1092,7 +1092,7 =
@@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_epo=
ch_data(const struct context *c)
 {
     OVPN_VERSION ver =3D { 0 };
     r=
eturn dco_get_version(&ver) && ((ver=2EMajor =3D=3D 2 && ver=2EMinor >=3D 8=
) || (ver=2EMajor > 2));
diff --git a/src/openvpn/error=2Ec b/src/openvpn/e=
rror=2Ec
index 26d4c7c=2E=2E32d819d 100644
--- a/src/openvpn/error=2Ec
+++ =
b/src/openvpn/error=2Ec
@@ -623,7 +623,7 @@
  * from the OS=2E
  */
 void
-=
x_check_status(ssize_t status, const char *description, struct link_socket =
*sock, struct tuntap *tt)
+x_check_status(ssize_t status, const char *descr=
iption, struct link_socket *sock, const struct tuntap *tt)
 {
     const ch=
ar *extended_msg =3D NULL;
 
diff --git a/src/openvpn/error=2Eh b/src/openv=
pn/error=2Eh
index 9f39572=2E=2E373cbc1 100644
--- a/src/openvpn/error=2Eh
=
+++ b/src/openvpn/error=2Eh
@@ -304,10 +304,10 @@
 void set_check_status(un=
signed int info_level, unsigned int verbose_level);
 
 void x_check_status(=
ssize_t status, const char *description, struct link_socket *sock,
-       =
             struct tuntap *tt);
+                    const struct tuntap *=
tt);
 
 static inline void
-check_status(ssize_t status, const char *descri=
ption, struct link_socket *sock, struct tuntap *tt)
+check_status(ssize_t s=
tatus, const char *description, struct link_socket *sock, const struct tunt=
ap *tt)
 {
     if (status < 0 || check_debug_level(x_cs_verbose_level))
  =
   {
diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=2Ec
index 40894=
01=2E=2E5e17ea1 100644
--- a/src/openvpn/event=2Ec
+++ b/src/openvpn/event=
=2Ec
@@ -1012,7 +1012,7 @@
 }
 
 static int
-se_wait_return(struct se_set *=
ses, fd_set *read, fd_set *write, struct event_set_return *out,
+se_wait_re=
turn(struct se_set *ses, const fd_set *read, const fd_set *write, struct ev=
ent_set_return *out,
                int outlen)
 {
     int i, j =3D 0;
di=
ff --git a/src/openvpn/event=2Eh b/src/openvpn/event=2Eh
index b784dfe=2E=
=2E0940a1d 100644
--- a/src/openvpn/event=2Eh
+++ b/src/openvpn/event=2Eh
@=
@ -204,7 +204,7 @@
 #else /* ifdef _WIN32 */
 
 static inline void
-wait_si=
gnal(struct event_set *es, void *arg)
+wait_signal(const struct event_set *=
es, const void *arg)
 {
 }
 
diff --git a/src/openvpn/forward=2Ec b/src/ope=
nvpn/forward=2Ec
index b97fb7a=2E=2E681210d 100644
--- a/src/openvpn/forwar=
d=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -237,7 +237,7 @@
 }
 
 static void
-=
parse_incoming_control_channel_command(struct context *c, struct buffer *bu=
f)
+parse_incoming_control_channel_command(struct context *c, const struct =
buffer *buf)
 {
     if (buf_string_match_head_str(buf, "AUTH_FAILED"))
   =
  {
@@ -507,7 +507,7 @@
 }
 
 int
-get_server_poll_remaining_time(struct ev=
ent_timeout *server_poll_timeout)
+get_server_poll_remaining_time(const str=
uct event_timeout *server_poll_timeout)
 {
     update_time();
     int rem=
aining =3D event_timeout_remaining(server_poll_timeout);
@@ -621,7 +621,7 @=
@
  * Buffer reallocation, for use with null encryption=2E
  */
 static inl=
ine void
-buffer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub=
, struct buffer *src_stub,
+buffer_turnover(const uint8_t *orig_buf, struct=
 buffer *dest_stub, const struct buffer *src_stub,
                 struct =
buffer *storage)
 {
     if (orig_buf =3D=3D src_stub->data && src_stub->da=
ta !=3D storage->data)
@@ -908,7 +908,7 @@
  */
 
 static inline void
-sock=
s_postprocess_incoming_link(struct context *c, struct link_socket *sock)
+s=
ocks_postprocess_incoming_link(struct context *c, const struct link_socket =
*sock)
 {
     if (sock->socks_proxy && sock->info=2Eproto =3D=3D PROTO_UDP=
)
     {
@@ -1005,7 +1005,7 @@
 }
 
 bool
-process_incoming_link_part1(stru=
ct context *c, struct link_socket_info *lsi, bool floated)
+process_incomin=
g_link_part1(struct context *c, const struct link_socket_info *lsi, bool fl=
oated)
 {
     struct gc_arena gc =3D gc_new();
     bool decrypt_status =
=3D false;
@@ -1555,7 +1555,7 @@
  * @param client    Determines whether to=
 the send packet back via tun or link
  */
 void
-ipv6_send_icmp_unreachabl=
e(struct context *c, struct buffer *buf, bool client)
+ipv6_send_icmp_unrea=
chable(struct context *c, const struct buffer *buf, bool client)
 {
 #defin=
e MAX_ICMPV6LEN 1280
     struct openvpn_icmp6hdr icmp6out;
diff --git a/sr=
c/openvpn/forward=2Eh b/src/openvpn/forward=2Eh
index 0309725=2E=2E375635b =
100644
--- a/src/openvpn/forward=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -126,=
7 +126,7 @@
  */
 void encrypt_sign(struct context *c, bool comp_frag);
 
-=
int get_server_poll_remaining_time(struct event_timeout *server_poll_timeou=
t);
+int get_server_poll_remaining_time(const struct event_timeout *server_=
poll_timeout);
 
 /********************************************************=
**************/
 /**
@@ -177,7 +177,7 @@
  *
  * @return true if packet is =
authenticated, false otherwise=2E
  */
-bool process_incoming_link_part1(st=
ruct context *c, struct link_socket_info *lsi, bool floated);
+bool process=
_incoming_link_part1(struct context *c, const struct link_socket_info *lsi,=
 bool floated);
 
 /**
  * Continues processing a packet read from the exte=
rnal network interface=2E
diff --git a/src/openvpn/init=2Ec b/src/openvpn/i=
nit=2Ec
index 9306a96=2E=2E3c2ebf9 100644
--- a/src/openvpn/init=2Ec
+++ b/=
src/openvpn/init=2Ec
@@ -803,7 +803,7 @@
 }
 
 static void
-init_port_share=
(struct context *c)
+init_port_share(const struct context *c)
 {
     if (!=
port_share && (c->options=2Eport_share_host && c->options=2Eport_share_port=
))
     {
@@ -1245,7 +1245,7 @@
  * prepending to msg() output=2E
  */
 con=
st char *
-format_common_name(struct context *c, struct gc_arena *gc)
+form=
at_common_name(const struct context *c, struct gc_arena *gc)
 {
     struct=
 buffer out =3D alloc_buf_gc(256, gc);
     if (c->c2=2Etls_multi)
@@ -1731=
,7 +1731,7 @@
 
 
 static bool
-can_preserve_tun(struct tuntap *tt)
+can_pr=
eserve_tun(const struct tuntap *tt)
 {
     if (tt && tt->backend_driver =
=3D=3D DRIVER_AFUNIX)
     {
@@ -1753,7 +1753,7 @@
  * @param c pointer to =
the connection context
  */
 static void
-add_wfp_block(struct context *c)
=
+add_wfp_block(const struct context *c)
 {
 #if defined(_WIN32)
     /* For=
tify 'redirect-gateway block-local' with firewall rules? */
@@ -1779,7 +177=
9,7 @@
  * @param adapter_index the VPN adapter index
  */
 static void
-de=
l_wfp_block(struct context *c, unsigned long adapter_index)
+del_wfp_block(=
const struct context *c, unsigned long adapter_index)
 {
 #if defined(_WIN3=
2)
     if (c->options=2Eblock_outside_dns || block_local_needed(c->c1=2Ero=
ute_list))
diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh
index c=
e8f74e=2E=2Ec486158 100644
--- a/src/openvpn/init=2Eh
+++ b/src/openvpn/ini=
t=2Eh
@@ -91,7 +91,7 @@
 
 uint64_t pull_permission_mask(const struct conte=
xt *c);
 
-const char *format_common_name(struct context *c, struct gc_aren=
a *gc);
+const char *format_common_name(const struct context *c, struct gc_=
arena *gc);
 
 void reset_coarse_timers(struct context *c);
 
diff --git a/=
src/openvpn/interval=2Eh b/src/openvpn/interval=2Eh
index 59051bd=2E=2E0cfe=
202 100644
--- a/src/openvpn/interval=2Eh
+++ b/src/openvpn/interval=2Eh
@@=
 -89,7 +89,7 @@
 }
 
 static inline void
-interval_schedule_wakeup(struct i=
nterval *top, interval_t *wakeup)
+interval_schedule_wakeup(const struct in=
terval *top, interval_t *wakeup)
 {
     const time_t local_now =3D now;
  =
   interval_earliest_wakeup(wakeup, top->last_test_true + top->refresh, loc=
al_now);
@@ -214,7 +214,7 @@
  * This function does not check if the timeou=
t is actually valid=2E
  */
 static inline interval_t
-event_timeout_remain=
ing(struct event_timeout *et)
+event_timeout_remaining(const struct event_t=
imeout *et)
 {
     return (interval_t)((et->last + et->n) - now);
 }
diff =
--git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index e51dcd0=2E=2Edcd5=
9d7 100644
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -164,7 =
+164,7 @@
 }
 
 void
-hash_remove_by_value(struct hash *hash, void *value)
=
+hash_remove_by_value(struct hash *hash, const void *value)
 {
     struct =
hash_iterator hi;
     const struct hash_element *he;
diff --git a/src/open=
vpn/list=2Eh b/src/openvpn/list=2Eh
index 55bc3c8=2E=2E23267d0 100644
--- a=
/src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -78,7 +78,7 @@
 
 bool =
hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, const void =
*key, uint64_t hv);
 
-void hash_remove_by_value(struct hash *hash, void *v=
alue);
+void hash_remove_by_value(struct hash *hash, const void *value);
 
=
 struct hash_iterator
 {
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/=
manage=2Ec
index 0aef2d4=2E=2E1e74f09 100644
--- a/src/openvpn/manage=2Ec
+=
++ b/src/openvpn/manage=2Ec
@@ -330,7 +330,7 @@
 }
 
 static void
-man_dele=
te_unix_socket(struct management *man)
+man_delete_unix_socket(const struct=
 management *man)
 {
 #if UNIX_SOCK_SUPPORT
     if ((man->settings=2Eflags=
 & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
@@ -676,7 +6=
76,7 @@
  * for the log and echo commands=2E
  */
 static void
-man_history=
(struct management *man, const char *parm, const char *type, struct log_his=
tory *log,
+man_history(struct management *man, const char *parm, const cha=
r *type, const struct log_history *log,
             bool *realtime, const =
unsigned int lep_flags)
 {
     struct gc_arena gc =3D gc_new();
@@ -852,7 =
+852,7 @@
 }
 
 static void
-man_net(struct management *man)
+man_net(const=
 struct management *man)
 {
     if (man->persist=2Ecallback=2Eshow_net)
  =
   {
@@ -888,7 +888,7 @@
 #ifdef ENABLE_PKCS11
 
 static void
-man_pkcs11_i=
d_count(struct management *man)
+man_pkcs11_id_count(const struct managemen=
t *man)
 {
     msg(M_CLIENT, ">PKCS11ID-COUNT:%d", pkcs11_management_id_co=
unt());
 }
@@ -2366,7 +2366,7 @@
  * the route/ifconfig/open tun command=2E=
   See doc/android=2Etxt for details=2E
  */
 bool
-management_android_cont=
rol(struct management *man, const char *command, const char *msg)
+manageme=
nt_android_control(const struct management *man, const char *command, const=
 char *msg)
 {
     if (!man)
     {
@@ -3013,7 +3013,7 @@
 }
 
 void
-mana=
gement_up_down(struct management *man, const char *updown, const struct env=
_set *es)
+management_up_down(const struct management *man, const char *upd=
own, const struct env_set *es)
 {
     if (man->settings=2Eflags & MF_UP_DO=
WN)
     {
@@ -3208,7 +3208,7 @@
 }
 
 void
-management_auth_failure(struct=
 management *man, const char *type, const char *reason)
+management_auth_fa=
ilure(const struct management *man, const char *type, const char *reason)
 =
{
     if (reason)
     {
diff --git a/src/openvpn/manage=2Eh b/src/openvpn=
/manage=2Eh
index 1e7855d=2E=2Ef2c6916 100644
--- a/src/openvpn/manage=2Eh
=
+++ b/src/openvpn/manage=2Eh
@@ -368,7 +368,7 @@
                          =
       const unsigned int flags, const char *static_challenge);
 
 #ifdef T=
ARGET_ANDROID
-bool management_android_control(struct management *man, cons=
t char *command, const char *msg);
+bool management_android_control(const s=
truct management *man, const char *command, const char *msg);
 
 #define AN=
DROID_KEEP_OLD_TUN      1
 #define ANDROID_OPEN_BEFORE_CLOSE 2
@@ -382,7 +3=
82,7 @@
 
 void management_event_loop_n_seconds(struct management *man, int=
 sec);
 
-void management_up_down(struct management *man, const char *updow=
n, const struct env_set *es);
+void management_up_down(const struct managem=
ent *man, const char *updown, const struct env_set *es);
 
 void management=
_notify(const char *severity, const char *type,
                        con=
st char *text);
@@ -482,7 +482,7 @@
  * OpenVPN calls here to indicate a pa=
ssword failure
  */
 
-void management_auth_failure(struct management *man,=
 const char *type, const char *reason);
+void management_auth_failure(const=
 struct management *man, const char *type, const char *reason);
 
 /*
  * E=
cho an authentication token to management interface
diff --git a/src/openvp=
n/mbuf=2Ec b/src/openvpn/mbuf=2Ec
index 5bb397f=2E=2E163251c 100644
--- a/s=
rc/openvpn/mbuf=2Ec
+++ b/src/openvpn/mbuf=2Ec
@@ -165,7 +165,7 @@
 }
 
 vo=
id
-mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instance *m=
i)
+mbuf_dereference_instance(struct mbuf_set *ms, const struct multi_insta=
nce *mi)
 {
     if (ms)
     {
diff --git a/src/openvpn/mbuf=2Eh b/src/ope=
nvpn/mbuf=2Eh
index cfe698c=2E=2Ee368054 100644
--- a/src/openvpn/mbuf=2Eh
=
+++ b/src/openvpn/mbuf=2Eh
@@ -75,7 +75,7 @@
 
 bool mbuf_extract_item(stru=
ct mbuf_set *ms, struct mbuf_item *item);
 
-void mbuf_dereference_instance=
(struct mbuf_set *ms, struct multi_instance *mi);
+void mbuf_dereference_in=
stance(struct mbuf_set *ms, const struct multi_instance *mi);
 
 static inl=
ine bool
 mbuf_defined(const struct mbuf_set *ms)
diff --git a/src/openvpn/=
mss=2Ec b/src/openvpn/mss=2Ec
index 36bbb43=2E=2E0cfa272d 100644
--- a/src/=
openvpn/mss=2Ec
+++ b/src/openvpn/mss=2Ec
@@ -239,8 +239,8 @@
 }
 
 static =
void
-frame_calculate_fragment(struct frame *frame, struct key_type *kt, co=
nst struct options *options,
-                         struct link_socket_i=
nfo *lsi)
+frame_calculate_fragment(struct frame *frame, const struct key_t=
ype *kt, const struct options *options,
+                         const str=
uct link_socket_info *lsi)
 {
 #if defined(ENABLE_FRAGMENT)
     size_t ove=
rhead;
@@ -269,8 +269,8 @@
 }
 
 static void
-frame_calculate_mssfix(struct=
 frame *frame, struct key_type *kt, const struct options *options,
-       =
                struct link_socket_info *lsi)
+frame_calculate_mssfix(struc=
t frame *frame, const struct key_type *kt, const struct options *options,
+=
                       const struct link_socket_info *lsi)
 {
     if (opti=
ons->ce=2Emssfix_fixed)
     {
@@ -314,8 +314,8 @@
 }
 
 void
-frame_calcul=
ate_dynamic(struct frame *frame, struct key_type *kt, const struct options =
*options,
-                        struct link_socket_info *lsi)
+frame_cal=
culate_dynamic(struct frame *frame, const struct key_type *kt, const struct=
 options *options,
+                        const struct link_socket_info *=
lsi)
 {
     if (options->ce=2Efragment > 0)
     {
diff --git a/src/openvp=
n/mss=2Eh b/src/openvpn/mss=2Eh
index 1d092bb=2E=2E2eab55a 100644
--- a/src=
/openvpn/mss=2Eh
+++ b/src/openvpn/mss=2Eh
@@ -36,8 +36,8 @@
 void mss_fixu=
p_dowork(struct buffer *buf, uint16_t maxmss);
 
 /** Set the --mssfix opti=
on=2E */
-void frame_calculate_dynamic(struct frame *frame, struct key_type=
 *kt,
-                             const struct options *options, struct l=
ink_socket_info *lsi);
+void frame_calculate_dynamic(struct frame *frame, c=
onst struct key_type *kt,
+                             const struct option=
s *options, const struct link_socket_info *lsi);
 
 /**
  * Checks and adju=
sts the fragment and mssfix value according to the
diff --git a/src/openvpn=
/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 4d173c4=2E=2Ec744638 100644
--- a/sr=
c/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -67,7 +67,7 @@
 }
 
 bool
=
-multi_tcp_instance_specific_init(struct multi_context *m, struct multi_ins=
tance *mi)
+multi_tcp_instance_specific_init(const struct multi_context *m,=
 struct multi_instance *mi)
 {
     /* buffer for queued TCP socket output =
packets */
     mi->tcp_link_out_deferred =3D mbuf_init(m->top=2Eoptions=2E=
n_bcast_buf);
diff --git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh
inde=
x 9b7d1d2=2E=2Ebb117fa 100644
--- a/src/openvpn/mtcp=2Eh
+++ b/src/openvpn/=
mtcp=2Eh
@@ -35,7 +35,7 @@
 
 void multi_tcp_dereference_instance(struct mu=
lti_io *multi_io, struct multi_instance *mi);
 
-bool multi_tcp_instance_sp=
ecific_init(struct multi_context *m, struct multi_instance *mi);
+bool mult=
i_tcp_instance_specific_init(const struct multi_context *m, struct multi_in=
stance *mi);
 
 void multi_tcp_instance_specific_free(struct multi_instance=
 *mi);
 
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 69e=
30e5=2E=2E201d756 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=
=2Ec
@@ -54,8 +54,9 @@
  * @param sock    the socket to send the reply on
 =
 */
 static void
-send_standalone_reply(struct multi_context *m, struct buf=
fer *buf, const char *prefix,
-                      const char *detail, st=
ruct link_socket *sock)
+send_standalone_reply(struct multi_context *m, con=
st struct buffer *buf,
+                      const char *prefix, const cha=
r *detail,
+                      struct link_socket *sock)
 {
     struct =
context *c =3D &m->top;
 
@@ -75,7 +76,7 @@
 
 static void
 send_hmac_reset=
_packet(struct multi_context *m, struct tls_pre_decrypt_state *state,
-    =
                   struct tls_auth_standalone *tas, struct session_id *sid,=

+                       const struct tls_auth_standalone *tas, const struc=
t session_id *sid,
                        bool request_resend_wkc, struct =
link_socket *sock)
 {
     reset_packet_id_send(&state->tls_wrap_tmp=2Eopt=
=2Epacket_id=2Esend);
@@ -117,11 +118,11 @@
 
     enum first_packet_verdic=
t verdict;
 
-    struct tls_auth_standalone *tas =3D m->top=2Ec2=2Etls_aut=
h_standalone;
+    const struct tls_auth_standalone *tas =3D m->top=2Ec2=2E=
tls_auth_standalone;
 
     verdict =3D tls_pre_decrypt_lite(tas, state, &m=
->top=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 
-    uint8_t *hmac_key =3D m->top=
=2Ec2=2Esession_id_key;
+    const uint8_t *hmac_key =3D m->top=2Ec2=2Esess=
ion_id_key;
     const struct openvpn_sockaddr *from =3D &m->top=2Ec2=2Efro=
m=2Edest;
     int handwindow =3D m->top=2Eoptions=2Ehandshake_window;
 
@@=
 -240,7 +241,7 @@
 static struct multi_instance *
 handle_connection_attemp=
t(struct multi_context *m,
                           struct link_socket *s=
ock,
-                          struct mroute_addr *real)
+                =
          const struct mroute_addr *real)
 {
     struct gc_arena gc =3D gc=
_new();
 
@@ -308,7 +309,7 @@
  * @return      instance matching the addres=
s, NULL otherwise
  */
 static struct multi_instance *
-multi_get_instance_=
udp_real(struct multi_context *m, struct mroute_addr *real)
+multi_get_inst=
ance_udp_real(struct multi_context *m, const struct mroute_addr *real)
 {
 =
    struct hash *hash =3D m->hash;
     const uint64_t hv =3D hash_value(ha=
sh, real);
@@ -353,7 +354,9 @@
  * maintaining real address hash table atom=
icity=2E
  */
 struct multi_instance *
-multi_get_instance_udp_data(struct =
multi_context *m, bool *floated, struct mroute_addr *real, struct link_sock=
et *sock)
+multi_get_instance_udp_data(struct multi_context *m, bool *float=
ed,
+                            const struct mroute_addr *real,
+         =
                   const struct link_socket *sock)
 {
     struct multi_ins=
tance *mi =3D NULL;
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mult=
i=2Ec
index dda9232=2E=2Ea2cfdbf 100644
--- a/src/openvpn/multi=2Ec
+++ b/s=
rc/openvpn/multi=2Ec
@@ -58,7 +58,7 @@
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
 st=
atic const char *
-id(struct multi_instance *mi)
+id(const struct multi_ins=
tance *mi)
 {
     if (mi)
     {
@@ -1336,7 +1336,7 @@
  * same common nam=
e=2E
  */
 static void
-multi_delete_dup(struct multi_context *m, struct mu=
lti_instance *new_mi)
+multi_delete_dup(struct multi_context *m, const stru=
ct multi_instance *new_mi)
 {
     if (new_mi)
     {
@@ -2281,7 +2281,7 @@=

 }
 
 static bool
-multi_client_setup_dco_initial(struct multi_context *m,=
 struct multi_instance *mi,
+multi_client_setup_dco_initial(const struct mu=
lti_context *m, struct multi_instance *mi,
                                =
struct gc_arena *gc)
 {
     if (!dco_enabled(&mi->context=2Eoptions))
@@ -=
2479,7 +2479,7 @@
 }
 
 static bool
-multi_check_dest_addr_allowed(struct m=
ulti_context *m, struct multi_instance *mi, struct mroute_addr *real);
+mul=
ti_check_dest_addr_allowed(struct multi_context *m, struct multi_instance *=
mi, const struct mroute_addr *real);
 
 /**
  * This sets up the client rea=
l address (outer tunnel addr) in the
@@ -3130,7 +3130,8 @@
  * positive=2E
=
  */
 static bool
-multi_check_dest_addr_allowed(struct multi_context *m, s=
truct multi_instance *mi, struct mroute_addr *real)
+multi_check_dest_addr_=
allowed(struct multi_context *m, struct multi_instance *mi,
+              =
                const struct mroute_addr *real)
 {
     struct hash *hash =
=3D m->hash;
     const uint64_t hv =3D hash_value(hash, real);
@@ -3289,7 =
+3290,7 @@
 
 #if defined(ENABLE_DCO)
 static void
-process_incoming_del_pe=
er(struct multi_context *m, struct multi_instance *mi, dco_context_t *dco)
=
+process_incoming_del_peer(struct multi_context *m, struct multi_instance *=
mi, const dco_context_t *dco)
 {
     const char *reason =3D "ovpn-dco: unk=
nown reason";
     switch (dco->dco_del_peer_reason)
@@ -4342,7 +4343,7 @@
=
 
 /* Searches for the address and deletes it if it is owned by the multi_i=
nstance */
 static void
-multi_unlearn_addr(struct multi_context *m, struct=
 multi_instance *mi, const struct mroute_addr *addr)
+multi_unlearn_addr(st=
ruct multi_context *m, const struct multi_instance *mi, const struct mroute=
_addr *addr)
 {
     struct hash_element *he;
     const uint64_t hv =3D ha=
sh_value(m->vhash, addr);
@@ -4377,7 +4378,7 @@
  * @param a     The new IP=
v4 address in network byte order
  */
 static void
-multi_unlearn_in_addr_t=
(struct multi_context *m, struct multi_instance *mi, in_addr_t a)
+multi_un=
learn_in_addr_t(struct multi_context *m, const struct multi_instance *mi, i=
n_addr_t a)
 {
     struct mroute_addr addr;
     CLEAR(addr);
@@ -4395,7 +=
4396,7 @@
  * @param a6    The new IPv6 address
  */
 static void
-multi_un=
learn_in6_addr(struct multi_context *m, struct multi_instance *mi, struct i=
n6_addr a6)
+multi_unlearn_in6_addr(struct multi_context *m, const struct m=
ulti_instance *mi, struct in6_addr a6)
 {
     struct mroute_addr addr;
   =
  CLEAR(addr);
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
i=
ndex c424ad3=2E=2E5db7147 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/open=
vpn/multi=2Eh
@@ -529,7 +529,7 @@
  */
 
 static inline void
-set_prefix(st=
ruct multi_instance *mi)
+set_prefix(const struct multi_instance *mi)
 {
 #=
ifdef MULTI_DEBUG_EVENT_LOOP
     if (mi->msg_prefix[0])
diff --git a/src/o=
penvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 348e424=2E=2Ebb5dde58 =
100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -15=
9,7 +159,7 @@
  * a point-to-multipoint tunnel=2E
  */
 static unsigned int=

-p2mp_iow_flags(const struct multi_context *m, struct link_socket *sock)
+=
p2mp_iow_flags(const struct multi_context *m, const struct link_socket *soc=
k)
 {
     unsigned int flags =3D IOW_WAIT_SIGNAL;
 
diff --git a/src/openv=
pn/networking=2Eh b/src/openvpn/networking=2Eh
index bce0c19=2E=2E25233c8 1=
00644
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/networking=2Eh
@@ =
-44,7 +44,7 @@
  */
 #if !defined(ENABLE_IPROUTE)
 static inline int
-net_c=
tx_init(struct context *c, openvpn_net_ctx_t *ctx)
+net_ctx_init(const stru=
ct context *c, openvpn_net_ctx_t *ctx)
 {
     (void)c;
     (void)ctx;
@@ =
-75,7 +75,7 @@
  *
  * @return          0 on success, a negative error code=
 otherwise
  */
-int net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx=
);
+int net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx);
 
 /=
**
  * Release resources allocated by the internal garbage collector
@@ -10=
2,7 +102,7 @@
  * @return          0 on success, negative error code on err=
or
  */
 int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_=
t *iface, const char *type,
-                  void *arg);
+               =
   const void *arg);
 
 /**
  * Retrieve the interface type
diff --git a/sr=
c/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec
ind=
ex a1f3525=2E=2Ef091fb3 100644
--- a/src/openvpn/networking_iproute2=2Ec
++=
+ b/src/openvpn/networking_iproute2=2Ec
@@ -36,7 +36,7 @@
 #include <netine=
t/in=2Eh>
 
 int
-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
+=
net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)
 {
     ctx->=
es =3D NULL;
     if (c)
@@ -61,7 +61,7 @@
 }
 
 int
-net_iface_new(openvpn=
_net_ctx_t *ctx, const char *iface, const char *type, void *arg)
+net_iface=
_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, const voi=
d *arg)
 {
     struct argv argv =3D argv_new();
 
diff --git a/src/openvpn=
/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index 83915db=2E=
=2E49de664 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/=
networking_sitnl=2Ec
@@ -1007,7 +1007,7 @@
 }
 
 static int
-sitnl_addr_del=
(sa_family_t af_family, const char *iface, inet_address_t *addr, int prefix=
len)
+sitnl_addr_del(sa_family_t af_family, const char *iface, const inet_a=
ddress_t *addr, int prefixlen)
 {
     int ifindex;
 
@@ -1250,8 +1250,8 @@=

 }
 
 static int
-sitnl_route_del(const char *iface, sa_family_t af_family=
, inet_address_t *dst, int prefixlen,
-                inet_address_t *gw, =
uint32_t table, int metric)
+sitnl_route_del(const char *iface, sa_family_t=
 af_family, const inet_address_t *dst, int prefixlen,
+                cons=
t inet_address_t *gw, uint32_t table, int metric)
 {
     int ifindex =3D 0=
;
 
@@ -1328,7 +1328,7 @@
 
 
 int
-net_iface_new(openvpn_net_ctx_t *ctx, c=
onst char *iface, const char *type, void *arg)
+net_iface_new(openvpn_net_c=
tx_t *ctx, const char *iface, const char *type, const void *arg)
 {
     st=
ruct sitnl_link_req req =3D {};
     int ret =3D -1;
diff --git a/src/openv=
pn/occ=2Eh b/src/openvpn/occ=2Eh
index bda4f18=2E=2E49def4d 100644
--- a/sr=
c/openvpn/occ=2Eh
+++ b/src/openvpn/occ=2Eh
@@ -156,7 +156,7 @@
  * via con=
trol channel=2E
  * @return control channel exit message should be used */
=
 static inline bool
-cc_exit_notify_enabled(struct context *c)
+cc_exit_not=
ify_enabled(const struct context *c)
 {
     /* Check if we have TLS active=
 at all */
     if (!c->c2=2Etls_multi)
diff --git a/src/openvpn/openssl_co=
mpat=2Eh b/src/openvpn/openssl_compat=2Eh
index 098bdd5=2E=2E1a934db 100644=

--- a/src/openvpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
=
@@ -127,7 +127,7 @@
 /* Mimics the functions but only when the default cont=
ext without
  * options is chosen */
 static inline const EVP_CIPHER *
-EVP=
_CIPHER_fetch(void *ctx, const char *algorithm, const char *properties)
+EV=
P_CIPHER_fetch(const void *ctx, const char *algorithm, const char *properti=
es)
 {
     ASSERT(!ctx);
     ASSERT(!properties);
@@ -135,7 +135,7 @@
 }
=
 
 static inline const EVP_MD *
-EVP_MD_fetch(void *ctx, const char *algori=
thm, const char *properties)
+EVP_MD_fetch(const void *ctx, const char *alg=
orithm, const char *properties)
 {
     ASSERT(!ctx);
     ASSERT(!properti=
es);
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 6=
664c73=2E=2Ee7585ad 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/=
options=2Ec
@@ -2429,7 +2429,7 @@
 }
 
 static void
-options_postprocess_mu=
tate_le(struct connection_entry *ce, struct local_entry *le, int mode)
+opt=
ions_postprocess_mutate_le(const struct connection_entry *ce, struct local_=
entry *le, int mode)
 {
     /* use the global port if none is specified */=

     if (!le->port)
@@ -3589,7 +3589,7 @@
 static bool
 verify_permission(=
const char *name, const char *file, int line, const uint64_t type,
        =
           const uint64_t allowed, uint64_t *found, const msglvl_t msglevel=
,
-                  struct options *options, bool is_inline)
+            =
      const struct options *options, bool is_inline)
 {
     if (!(type & a=
llowed))
     {
@@ -3665,7 +3665,7 @@
 }
 
 static inline msglvl_t
-msgleve=
l_forward_compatible(struct options *options, const msglvl_t msglevel)
+msg=
level_forward_compatible(const struct options *options, const msglvl_t msgl=
evel)
 {
     return options->forward_compatible ? M_WARN : msglevel;
 }
@@=
 -4154,7 +4154,7 @@
 }
 
 static void
-show_compression_warning(struct comp=
ress_options *info)
+show_compression_warning(const struct compress_options=
 *info)
 {
     if (comp_non_stub_enabled(info))
     {
diff --git a/src/op=
envpn/options_parse=2Ec b/src/openvpn/options_parse=2Ec
index 12934ab=2E=2E=
79b8098 100644
--- a/src/openvpn/options_parse=2Ec
+++ b/src/openvpn/option=
s_parse=2Ec
@@ -258,7 +258,7 @@
 }
 
 static char *
-read_inline_file(struc=
t in_src *is, const char *close_tag, int *num_lines, struct gc_arena *gc)
+=
read_inline_file(const struct in_src *is, const char *close_tag, int *num_l=
ines, struct gc_arena *gc)
 {
     char line[OPTION_LINE_SIZE];
     struct=
 buffer buf =3D alloc_buf(8 * OPTION_LINE_SIZE);
@@ -302,7 +302,7 @@
 }
 
 =
static int
-check_inline_file(struct in_src *is, char *p[], struct gc_arena=
 *gc)
+check_inline_file(const struct in_src *is, char *p[], struct gc_aren=
a *gc)
 {
     int num_inline_lines =3D 0;
 
diff --git a/src/openvpn/otime=
=2Ec b/src/openvpn/otime=2Ec
index 1608458=2E=2E5d3633c 100644
--- a/src/op=
envpn/otime=2Ec
+++ b/src/openvpn/otime=2Ec
@@ -66,7 +66,7 @@
 }
 
 void
-u=
pdate_now_usec(struct timeval *tv)
+update_now_usec(const struct timeval *t=
v)
 {
     const time_t last =3D now;
     update_now(tv->tv_sec);
diff --g=
it a/src/openvpn/otime=2Eh b/src/openvpn/otime=2Eh
index d14f01e=2E=2E74d21=
ff 100644
--- a/src/openvpn/otime=2Eh
+++ b/src/openvpn/otime=2Eh
@@ -65,7 =
+65,7 @@
 void update_now(const time_t system_time);
 
 extern time_t now_u=
sec;
-void update_now_usec(struct timeval *tv);
+void update_now_usec(const=
 struct timeval *tv);
 
 static inline int
 openvpn_gettimeofday(struct tim=
eval *tv, void *tz)
diff --git a/src/openvpn/proto=2Eh b/src/openvpn/proto=
=2Eh
index 9bb0866=2E=2E1665751 100644
--- a/src/openvpn/proto=2Eh
+++ b/sr=
c/openvpn/proto=2Eh
@@ -248,7 +248,7 @@
  * and offset of IP header (via pa=
rameter)=2E
  */
 static inline int
-get_tun_ip_ver(int tunnel_type, struct=
 buffer *buf, int *ip_hdr_offset)
+get_tun_ip_ver(int tunnel_type, const st=
ruct buffer *buf, int *ip_hdr_offset)
 {
     int ip_ver =3D -1;
 
diff --g=
it a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index 74a6cf9=2E=2Ec3ad7=
de 100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -527,8=
 +527,9 @@
 }
 
 static bool
-add_proxy_headers(struct http_proxy_info *p, =
socket_descriptor_t sd, /* already open to proxy */
-                  cons=
t char *host                                   /* openvpn server remote */
=
+add_proxy_headers(const struct http_proxy_info *p,
+                  sock=
et_descriptor_t sd, /* already open to proxy */
+                  const ch=
ar *host        /* openvpn server remote */
 )
 {
     char buf[512];
@@ -5=
97,8 +598,8 @@
                               socket_descriptor_t sd, /* al=
ready open to proxy */
                               const char *host,    =
   /* openvpn server remote */
                               const char *p=
ort,       /* openvpn server port */
-                              struct =
event_timeout *server_poll_timeout, struct buffer *lookahead,
-            =
                  struct signal_info *sig_info)
+                          =
    const struct event_timeout *server_poll_timeout,
+                     =
         struct buffer *lookahead, struct signal_info *sig_info)
 {
     st=
ruct gc_arena gc =3D gc_new();
     char buf[512];
diff --git a/src/openvpn=
/proxy=2Eh b/src/openvpn/proxy=2Eh
index e662e7d=2E=2Ea2f4e47 100644
--- a/=
src/openvpn/proxy=2Eh
+++ b/src/openvpn/proxy=2Eh
@@ -89,7 +89,7 @@
       =
                             socket_descriptor_t sd, /* already open to pro=
xy */
                                    const char *host,       /* openvp=
n server remote */
                                    const char *port,   =
    /* openvpn server port */
-                                   struct ev=
ent_timeout *server_poll_timeout,
+                                   const=
 struct event_timeout *server_poll_timeout,
                               =
     struct buffer *lookahead, struct signal_info *sig_info);
 
 uint8_t *m=
ake_base64_string2(const uint8_t *str, int str_len, struct gc_arena *gc);
d=
iff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index 08c2673=2E=2E2679=
c4d5 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -334,7 +33=
4,7 @@
  * the proxy can determine true client origin=2E
  */
 static void
=
-journal_add(const char *journal_dir, struct proxy_connection *pc, struct p=
roxy_connection *cp)
+journal_add(const char *journal_dir, const struct pro=
xy_connection *pc, struct proxy_connection *cp)
 {
     struct openvpn_sock=
addr from, to;
 
@@ -412,7 +412,7 @@
 static bool
 proxy_entry_new(struct p=
roxy_connection **list, struct event_set *es,
                 const struct=
 openvpn_sockaddr server_addr, const socket_descriptor_t sd_client,
-      =
          struct buffer *initial_data, const char *journal_dir)
+          =
      const struct buffer *initial_data, const char *journal_dir)
 {
     s=
ocket_descriptor_t sd_server;
     int status;
@@ -1015,7 +1015,7 @@
  * ca=
ll=2E
  */
 void
-port_share_redirect(struct port_share *ps, const struct b=
uffer *head, socket_descriptor_t sd)
+port_share_redirect(const struct port=
_share *ps, const struct buffer *head, socket_descriptor_t sd)
 {
     if (=
ps)
     {
diff --git a/src/openvpn/ps=2Eh b/src/openvpn/ps=2Eh
index 557ec=
f5=2E=2E918ceb6 100644
--- a/src/openvpn/ps=2Eh
+++ b/src/openvpn/ps=2Eh
@@=
 -49,7 +49,7 @@
 
 bool is_openvpn_protocol(const struct buffer *buf);
 
-v=
oid port_share_redirect(struct port_share *ps, const struct buffer *head, s=
ocket_descriptor_t sd);
+void port_share_redirect(const struct port_share *=
ps, const struct buffer *head, socket_descriptor_t sd);
 
 #endif /* if POR=
T_SHARE */
 #endif /* ifndef PS_H */
diff --git a/src/openvpn/push=2Ec b/sr=
c/openvpn/push=2Ec
index 0e281d2=2E=2E8dfe0d5 100644
--- a/src/openvpn/push=
=2Ec
+++ b/src/openvpn/push=2Ec
@@ -430,7 +430,7 @@
 }
 
 bool
-send_auth_p=
ending_messages(struct tls_multi *tls_multi, struct tls_session *session,
+=
send_auth_pending_messages(const struct tls_multi *tls_multi, struct tls_se=
ssion *session,
                            const char *extra, unsigned int=
 timeout)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];
diff =
--git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index dff945f=2E=2E3930=
2f6 100644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -117,7 =
+117,7 @@
  * doc/management-notes=2Etxt under client-pending-auth for
  * =
more details on message format
  */
-bool send_auth_pending_messages(struct=
 tls_multi *tls_multi, struct tls_session *session,
+bool send_auth_pending=
_messages(const struct tls_multi *tls_multi, struct tls_session *session,
 =
                                const char *extra, unsigned int timeout);
 =

 void send_restart(struct context *c, const char *kill_msg);
diff --git a/=
src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index 0213041=2E=2E7f=
a5987 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2E=
c
@@ -222,7 +222,7 @@
 
 /* Return true if the client supports push-update =
*/
 static bool
-support_push_update(struct multi_instance *mi)
+support_pu=
sh_update(const struct multi_instance *mi)
 {
     ASSERT(mi->context=2Ec2=
=2Etls_multi);
     const unsigned int iv_proto_peer =3D extract_iv_proto(m=
i->context=2Ec2=2Etls_multi->peer_info);
diff --git a/src/openvpn/reliable=
=2Ec b/src/openvpn/reliable=2Ec
index c268cce=2E=2E7b5b17c 100644
--- a/src=
/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -59,7 +59,7 @@
 
 /=
* check if a particular packet_id is present in ack */
 static inline bool
=
-reliable_ack_packet_id_present(struct reliable_ack *ack, packet_id_type pi=
d)
+reliable_ack_packet_id_present(const struct reliable_ack *ack, packet_i=
d_type pid)
 {
     for (int i =3D 0; i < ack->len; ++i)
     {
@@ -752,7 +=
752,7 @@
  */
 
 void
-reliable_mark_active_incoming(struct reliable *rel, =
struct buffer *buf, packet_id_type pid,
+reliable_mark_active_incoming(stru=
ct reliable *rel, const struct buffer *buf, packet_id_type pid,
           =
                    int opcode)
 {
     for (int i =3D 0; i < rel->size; ++=
i)
@@ -812,7 +812,7 @@
 
 /* delete a buffer previously activated by reliab=
le_mark_active() */
 void
-reliable_mark_deleted(struct reliable *rel, stru=
ct buffer *buf)
+reliable_mark_deleted(struct reliable *rel, const struct b=
uffer *buf)
 {
     for (int i =3D 0; i < rel->size; ++i)
     {
diff --git=
 a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh
index 534feb3=2E=2E7=
b6fced 100644
--- a/src/openvpn/reliable=2Eh
+++ b/src/openvpn/reliable=2Eh=

@@ -184,7 +184,7 @@
  * @li False, if there are packet IDs to be acknowled=
ged=2E
  */
 static inline bool
-reliable_ack_empty(struct reliable_ack *ac=
k)
+reliable_ack_empty(const struct reliable_ack *ack)
 {
     return !ack-=
>len;
 }
@@ -213,7 +213,7 @@
  * @returns the number of outstanding acks
  =
*/
 static inline int
-reliable_ack_outstanding(struct reliable_ack *ack)
+=
reliable_ack_outstanding(const struct reliable_ack *ack)
 {
     return ack=
->len;
 }
@@ -369,7 +369,7 @@
  * @param pid The packet's packet ID=2E
  * =
@param opcode The packet's opcode=2E
  */
-void reliable_mark_active_incomi=
ng(struct reliable *rel, struct buffer *buf, packet_id_type pid,
+void reli=
able_mark_active_incoming(struct reliable *rel, const struct buffer *buf, p=
acket_id_type pid,
                                    int opcode);
 
 /**
=
@@ -422,7 +422,7 @@
  * @param rel The reliable structure associated with t=
he given buffer=2E
  * @param buf The buffer of the reliable entry which is=
 to be removed=2E
  */
-void reliable_mark_deleted(struct reliable *rel, st=
ruct buffer *buf);
+void reliable_mark_deleted(struct reliable *rel, const =
struct buffer *buf);
 
 /** @} name Functions for extracting incoming packe=
ts */
 
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 33=
b2387=2E=2E4830a5b 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/rou=
te=2Ec
@@ -898,8 +898,9 @@
 }
 
 static bool
-add_bypass_routes(struct rout=
e_bypass *rb, in_addr_t gateway, const struct tuntap *tt,
-                =
  unsigned int flags, const struct route_gateway_info *rgi,
+add_bypass_rou=
tes(const struct route_bypass *rb, in_addr_t gateway,
+                  co=
nst struct tuntap *tt, unsigned int flags,
+                  const struct =
route_gateway_info *rgi,
                   const struct env_set *es, openv=
pn_net_ctx_t *ctx)
 {
     int ret =3D true;
@@ -916,8 +917,9 @@
 }
 
 stat=
ic void
-del_bypass_routes(struct route_bypass *rb, in_addr_t gateway, cons=
t struct tuntap *tt,
-                  unsigned int flags, const struct ro=
ute_gateway_info *rgi,
+del_bypass_routes(const struct route_bypass *rb, in=
_addr_t gateway,
+                  const struct tuntap *tt, unsigned int f=
lags,
+                  const struct route_gateway_info *rgi,
            =
       const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
     int i;
@@ =
-3939,7 +3941,8 @@
 #else  /* if defined(_WIN32) */
 
 static void
-get_byp=
ass_addresses(struct route_bypass *rb, const unsigned int flags) /* PLATFOR=
M-SPECIFIC */
+// cppcheck-suppress constParameterPointer ; stub
+get_bypas=
s_addresses(struct route_bypass *rb, const unsigned int flags)
 {
 }
 
diff=
 --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 33def4e=2E=
=2Edf8e400 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec=

@@ -620,7 +620,7 @@
 }
 
 static void
-bind_local(struct link_socket *sock=
)
+bind_local(const struct link_socket *sock)
 {
     /* bind to local addr=
ess/port */
     if (sock->bind_local)
@@ -916,8 +916,8 @@
 }
 
 void
-sock=
et_bind(socket_descriptor_t sd, struct addrinfo *local, int ai_family, cons=
t char *prefix,
-            bool ipv6only)
+socket_bind(socket_descriptor_=
t sd, const struct addrinfo *local, int ai_family,
+            const char =
*prefix, bool ipv6only)
 {
     struct gc_arena gc =3D gc_new();
 
@@ -1125=
,8 +1125,8 @@
  * such as TCP=2E
  */
 
-static void stream_buf_init(struct=
 stream_buf *sb, struct buffer *buf, const unsigned int sockflags,
-       =
                     const int proto);
+static void stream_buf_init(struct =
stream_buf *sb, const struct buffer *buf,
+                            cons=
t unsigned int sockflags, const int proto);
 
 static void stream_buf_close=
(struct stream_buf *sb);
 
@@ -1479,7 +1479,7 @@
 }
 
 static void
-phase2_=
set_socket_flags(struct link_socket *sock)
+phase2_set_socket_flags(const s=
truct link_socket *sock)
 {
     /* TCP_NODELAY is enabled by default on ev=
ery TCP socket; dco-win is
      * skipped as it manages its own socket */
=
@@ -2075,7 +2075,7 @@
 }
 
 static void
-stream_buf_init(struct stream_buf =
*sb, struct buffer *buf, const unsigned int sockflags,
+stream_buf_init(str=
uct stream_buf *sb, const struct buffer *buf, const unsigned int sockflags,=

                 const int proto)
 {
     sb->buf_init =3D *buf;
@@ -2341,=
7 +2341,7 @@
 #endif
 
 static ssize_t
-link_socket_read_udp_posix_recvmsg(=
struct link_socket *sock, struct buffer *buf,
+link_socket_read_udp_posix_r=
ecvmsg(const struct link_socket *sock, struct buffer *buf,
                =
                    struct link_socket_actual *from, socklen_t *fromlen)
 {=

     struct iovec iov;
@@ -2413,7 +2413,7 @@
 #endif /* if ENABLE_IP_PKTIN=
FO */
 
 ssize_t
-link_socket_read_udp_posix(struct link_socket *sock, stru=
ct buffer *buf,
+link_socket_read_udp_posix(const struct link_socket *sock,=
 struct buffer *buf,
                            struct link_socket_actual =
*from)
 {
     ssize_t recvlen;
@@ -2476,7 +2476,7 @@
 #if ENABLE_IP_PKTINF=
O
 
 ssize_t
-link_socket_write_udp_posix_sendmsg(struct link_socket *sock,=
 struct buffer *buf,
+link_socket_write_udp_posix_sendmsg(const struct link=
_socket *sock, const struct buffer *buf,
                                  =
   struct link_socket_actual *to)
 {
     struct iovec iov;
@@ -2672,7 +267=
2,7 @@
 }
 
 int
-socket_send_queue(struct link_socket *sock, struct buffer=
 *buf, const struct link_socket_actual *to)
+socket_send_queue(struct link_=
socket *sock, const struct buffer *buf, const struct link_socket_actual *to=
)
 {
     if (sock->writes=2Eiostate =3D=3D IOSTATE_INITIAL)
     {
@@ -277=
2,8 +2772,8 @@
     return sock->writes=2Eiostate;
 }
 
-void
-read_sockadd=
r_from_overlapped(struct overlapped_io *io, struct sockaddr *dst, int overl=
apped_ret)
+static void
+read_sockaddr_from_overlapped(const struct overlap=
ped_io *io, struct sockaddr *dst, int overlapped_ret)
 {
     if (overlappe=
d_ret >=3D 0 && io->addr_defined)
     {
diff --git a/src/openvpn/socket=2E=
h b/src/openvpn/socket=2Eh
index 46fa29c=2E=2Ecbcdeef 100644
--- a/src/open=
vpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -268,7 +268,7 @@
 
 int sock=
et_recv_queue(struct link_socket *sock, int maxsize);
 
-int socket_send_qu=
eue(struct link_socket *sock, struct buffer *buf,
+int socket_send_queue(st=
ruct link_socket *sock, const struct buffer *buf,
                       co=
nst struct link_socket_actual *to);
 
 typedef struct
@@ -348,8 +348,8 @@
 =

 struct link_socket *link_socket_new(void);
 
-void socket_bind(socket_des=
criptor_t sd, struct addrinfo *local, int af_family, const char *prefix,
- =
                bool ipv6only);
+void socket_bind(socket_descriptor_t sd, c=
onst struct addrinfo *local, int af_family,
+                 const char *p=
refix, bool ipv6only);
 
 int openvpn_connect(socket_descriptor_t sd, const=
 struct sockaddr *remote, int connect_timeout,
                     volatil=
e int *signal_received);
@@ -496,7 +496,7 @@
 }
 
 static inline bool
-link=
_socket_verify_incoming_addr(struct buffer *buf, const struct link_socket_i=
nfo *info,
+link_socket_verify_incoming_addr(const struct buffer *buf, cons=
t struct link_socket_info *info,
                                  const st=
ruct link_socket_actual *from_addr)
 {
     if (buf->len > 0)
@@ -620,7 +62=
0,7 @@
 
 #else  /* ifdef _WIN32 */
 
-ssize_t link_socket_read_udp_posix(s=
truct link_socket *sock, struct buffer *buf,
+ssize_t link_socket_read_udp_=
posix(const struct link_socket *sock, struct buffer *buf,
                 =
                   struct link_socket_actual *from);
 
 #endif /* ifdef _WI=
N32 */
@@ -706,12 +706,12 @@
 
 #else /* ifdef _WIN32 */
 
-ssize_t link_so=
cket_write_udp_posix_sendmsg(struct link_socket *sock, struct buffer *buf,
=
+ssize_t link_socket_write_udp_posix_sendmsg(const struct link_socket *sock=
, const struct buffer *buf,
                                             st=
ruct link_socket_actual *to);
 
 
 static inline ssize_t
-link_socket_write=
_udp_posix(struct link_socket *sock, struct buffer *buf,
+link_socket_write=
_udp_posix(const struct link_socket *sock, const struct buffer *buf,
      =
                       struct link_socket_actual *to)
 {
 #if ENABLE_IP_PKT=
INFO
@@ -727,7 +727,7 @@
 }
 
 static inline ssize_t
-link_socket_write_tcp=
_posix(struct link_socket *sock, struct buffer *buf)
+link_socket_write_tcp=
_posix(const struct link_socket *sock, const struct buffer *buf)
 {
     re=
turn send(sock->sd, CBPTR(buf), BLENZ(buf), MSG_NOSIGNAL);
 }
@@ -785,7 +78=
5,7 @@
  * from tunnel packet=2E
  */
 static inline void
-link_socket_set_=
tos(struct link_socket *sock)
+link_socket_set_tos(const struct link_socket=
 *sock)
 {
     if (sock && sock->ptos_defined)
     {
diff --git a/src/ope=
nvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh
index 13f5962=2E=2Eadd08=
ba 100644
--- a/src/openvpn/socket_util=2Eh
+++ b/src/openvpn/socket_util=
=2Eh
@@ -439,7 +439,7 @@
 
 
 static inline bool
-addrlist_match_proto(cons=
t struct openvpn_sockaddr *a1, struct addrinfo *addr_list, const int proto)=

+addrlist_match_proto(const struct openvpn_sockaddr *a1, const struct addr=
info *addr_list, const int proto)
 {
     return link_socket_proto_connecti=
on_oriented(proto) ? addrlist_match(a1, addr_list)
                        =
                                 : addrlist_port_match(a1, addr_list);
diff=
 --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec
index b84da24=2E=2E0=
296349 100644
--- a/src/openvpn/socks=2Ec
+++ b/src/openvpn/socks=2Ec
@@ -8=
3,7 +83,7 @@
 
 static bool
 socks_proxy_recv_char(uint8_t *c, const char *=
name, socket_descriptor_t sd,
-                      struct event_timeout *=
server_poll_timeout,
+                      const struct event_timeout *ser=
ver_poll_timeout,
                       volatile int *signal_received)
 {
=
     fd_set reads;
@@ -98,8 +98,8 @@
 }
 
 static bool
-socks_username_pass=
word_auth(struct socks_proxy_info *p, socket_descriptor_t sd,
-            =
                 struct event_timeout *server_poll_timeout,
+socks_username=
_password_auth(const struct socks_proxy_info *p, socket_descriptor_t sd,
+ =
                            const struct event_timeout *server_poll_timeout=
,
                              volatile int *signal_received)
 {
     char=
 to_send[516];
@@ -157,8 +157,8 @@
 }
 
 static bool
-socks_handshake(struc=
t socks_proxy_info *p, socket_descriptor_t sd,
-                struct even=
t_timeout *server_poll_timeout, volatile int *signal_received)
+socks_hands=
hake(const struct socks_proxy_info *p, socket_descriptor_t sd,
+           =
     const struct event_timeout *server_poll_timeout, volatile int *signal_=
received)
 {
     uint8_t buf[2];
     int len =3D 0;
@@ -232,7 +232,7 @@
 =

 static bool
 recv_socks_reply(socket_descriptor_t sd, struct openvpn_sock=
addr *addr,
-                 struct event_timeout *server_poll_timeout, vo=
latile int *signal_received)
+                 const struct event_timeout *=
server_poll_timeout, volatile int *signal_received)
 {
     uint8_t atyp =
=3D 0;
     int alen =3D 0;
@@ -334,11 +334,11 @@
 }
 
 void
-establish_soc=
ks_proxy_passthru(struct socks_proxy_info *p,
+establish_socks_proxy_passth=
ru(const struct socks_proxy_info *p,
                                socket=
_descriptor_t sd, /* already open to proxy */
                             =
   const char *host,       /* openvpn server remote */
                    =
            const char *servname,   /* openvpn server port */
-            =
                   struct event_timeout *server_poll_timeout,
+            =
                   const struct event_timeout *server_poll_timeout,
       =
                         struct signal_info *sig_info)
 {
     char buf[270=
];
@@ -392,10 +392,10 @@
 }
 
 void
-establish_socks_proxy_udpassoc(struct =
socks_proxy_info *p,
+establish_socks_proxy_udpassoc(const struct socks_pro=
xy_info *p,
                                socket_descriptor_t ctrl_sd, /*=
 already open to proxy */
                                struct openvpn_so=
ckaddr *relay_addr,
-                               struct event_timeout *s=
erver_poll_timeout,
+                               const struct event_time=
out *server_poll_timeout,
                                struct signal_inf=
o *sig_info)
 {
     if (!socks_handshake(p, ctrl_sd, server_poll_timeout, =
&sig_info->signal_received))
diff --git a/src/openvpn/socks=2Eh b/src/openv=
pn/socks=2Eh
index caed18c=2E=2E7434bbf 100644
--- a/src/openvpn/socks=2Eh
=
+++ b/src/openvpn/socks=2Eh
@@ -49,17 +49,17 @@
 
 void socks_proxy_close(s=
truct socks_proxy_info *sp);
 
-void establish_socks_proxy_passthru(struct =
socks_proxy_info *p,
+void establish_socks_proxy_passthru(const struct sock=
s_proxy_info *p,
                                     socket_descriptor_t s=
d, /* already open to proxy */
                                     const c=
har *host,       /* openvpn server remote */
                              =
       const char *servname,   /* openvpn server port */
-                 =
                   struct event_timeout *server_poll_timeout,
+            =
                        const struct event_timeout *server_poll_timeout,
  =
                                   struct signal_info *sig_info);
 
-void e=
stablish_socks_proxy_udpassoc(struct socks_proxy_info *p,
+void establish_s=
ocks_proxy_udpassoc(const struct socks_proxy_info *p,
                     =
                socket_descriptor_t ctrl_sd, /* already open to proxy */
  =
                                   struct openvpn_sockaddr *relay_addr,
-  =
                                  struct event_timeout *server_poll_timeout=
,
+                                    const struct event_timeout *server_p=
oll_timeout,
                                     struct signal_info *sig_i=
nfo);
 
 void socks_process_incoming_udp(struct buffer *buf, struct link_so=
cket_actual *from);
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
=
index aeec020=2E=2E3594871 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openv=
pn/ssl=2Ec
@@ -1171,7 +1171,7 @@
 }
 
 struct tls_multi *
-tls_multi_init(s=
truct tls_options *tls_options)
+tls_multi_init(const struct tls_options *t=
ls_options)
 {
     struct tls_multi *ret;
 
@@ -1212,7 +1212,7 @@
  */
 
 =
struct tls_auth_standalone *
-tls_auth_standalone_init(struct tls_options *=
tls_options, struct gc_arena *gc)
+tls_auth_standalone_init(const struct tl=
s_options *tls_options, struct gc_arena *gc)
 {
     struct tls_auth_standa=
lone *tas;
 
@@ -1631,8 +1631,9 @@
 
 bool
 tls_session_update_crypto_param=
s_do_work(struct tls_multi *multi, struct tls_session *session,
-          =
                               struct options *options, struct frame *frame=
,
-                                         struct frame *frame_fragment, s=
truct link_socket_info *lsi,
+                                         cons=
t struct options *options, struct frame *frame,
+                          =
               struct frame *frame_fragment,
+                             =
            const struct link_socket_info *lsi,
                           =
               dco_context_t *dco)
 {
     if (session->key[KS_PRIMARY]=2Ec=
rypto_options=2Ekey_ctx_bi=2Einitialized)
@@ -1704,7 +1705,7 @@
 bool
 tls_=
session_update_crypto_params(struct tls_multi *multi, struct tls_session *s=
ession,
                                  struct options *options, struct f=
rame *frame,
-                                 struct frame *frame_fragment=
, struct link_socket_info *lsi,
+                                 struct fr=
ame *frame_fragment, const struct link_socket_info *lsi,
                  =
                dco_context_t *dco)
 {
     if (!check_session_cipher(sessi=
on, options))
@@ -1920,7 +1921,8 @@
 }
 
 static bool
-push_peer_info_peeri=
d(struct buffer *out, struct tls_multi *multi, struct tls_session *session)=

+push_peer_info_peerid(struct buffer *out, const struct tls_multi *multi,
=
+                      const struct tls_session *session)
 {
     if (multi=
->rx_peer_id =3D=3D MAX_PEER_ID || session->opt->dco_enabled)
     {
@@ -19=
55,7 +1957,7 @@
  * @return          true if no error was encountered
  */
=
 static bool
-push_peer_info(struct buffer *buf, struct tls_multi *multi, s=
truct tls_session *session)
+push_peer_info(struct buffer *buf, const struc=
t tls_multi *multi, struct tls_session *session)
 {
     struct gc_arena gc=
 =3D gc_new();
     bool ret =3D false;
@@ -2599,8 +2601,8 @@
 }
 
 bool
-s=
ession_skip_to_pre_start(struct tls_session *session, struct tls_pre_decryp=
t_state *state,
-                          struct link_socket_actual *from)=

+session_skip_to_pre_start(struct tls_session *session, const struct tls_p=
re_decrypt_state *state,
+                          const struct link_socke=
t_actual *from)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];=

     ks->session_id_remote =3D state->peer_session_id;
@@ -2829,7 +2831,7 =
@@
 
 static bool
 check_outgoing_ciphertext(struct key_state *ks, struct t=
ls_session *session,
-                          struct buffer *to_link, boo=
l *continue_tls_process)
+                          const struct buffer *to=
_link, bool *continue_tls_process)
 {
     if (to_link->len)
     {
@@ -419=
3,7 +4195,7 @@
 }
 
 void
-tls_post_encrypt(struct tls_multi *multi, struct=
 buffer *buf)
+tls_post_encrypt(struct tls_multi *multi, const struct buffe=
r *buf)
 {
     struct key_state *ks =3D multi->save_ks;
     multi->save_k=
s =3D NULL;
@@ -4324,7 +4326,7 @@
  * into a garbage collectable string whi=
ch is returned=2E
  */
 const char *
-protocol_dump(struct buffer *buffer, =
unsigned int flags, struct gc_arena *gc)
+protocol_dump(const struct buffer=
 *buffer, unsigned int flags, struct gc_arena *gc)
 {
     struct buffer ou=
t =3D alloc_buf_gc(256, gc);
     struct buffer buf =3D *buffer;
diff --git=
 a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh
index 5483fbb=2E=2E76c3610 100=
644
--- a/src/openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -166,7 +166,7 @@=

  *
  * @return A newly allocated and initialized \c tls_multi structure=
=2E
  */
-struct tls_multi *tls_multi_init(struct tls_options *tls_options)=
;
+struct tls_multi *tls_multi_init(const struct tls_options *tls_options);=

 
 /**
  * Finalize initialization of a \c tls_multi structure=2E
@@ -187,=
7 +187,7 @@
 /*
  * Initialize a standalone tls-auth verification object=2E=

  */
-struct tls_auth_standalone *tls_auth_standalone_init(struct tls_opti=
ons *tls_options,
+struct tls_auth_standalone *tls_auth_standalone_init(con=
st struct tls_options *tls_options,
                                       =
               struct gc_arena *gc);
 
 /**
@@ -373,7 +373,7 @@
  * @param =
multi - The TLS state for this packet's destination VPN tunnel=2E
  * @para=
m buf - The buffer containing the outgoing packet=2E
  */
-void tls_post_en=
crypt(struct tls_multi *multi, struct buffer *buf);
+void tls_post_encrypt(=
struct tls_multi *multi, const struct buffer *buf);
 
 /** @} name Function=
s for managing security parameter state for data channel packets */
 
@@ -4=
63,7 +463,8 @@
  */
 bool tls_session_update_crypto_params(struct tls_multi=
 *multi, struct tls_session *session,
                                     =
  struct options *options, struct frame *frame,
-                          =
            struct frame *frame_fragment, struct link_socket_info *lsi,
+  =
                                    struct frame *frame_fragment,
+        =
                              const struct link_socket_info *lsi,
         =
                              dco_context_t *dco);
 
 /*
@@ -527,7 +528,7 @=
@
 #define PD_VERBOSE                 (1 << 10)
 #define PD_TLS_CRYPT      =
         (1 << 11)
 
-const char *protocol_dump(struct buffer *buffer, unsi=
gned int flags, struct gc_arena *gc);
+const char *protocol_dump(const stru=
ct buffer *buffer, unsigned int flags, struct gc_arena *gc);
 
 /*
  * debu=
gging code
@@ -566,7 +567,7 @@
 /* Special method to skip the three way han=
dshake RESET stages=2E This is
  * used by the HMAC code when seeing a pack=
et that matches the previous
  * HMAC based stateless server state */
-bool=
 session_skip_to_pre_start(struct tls_session *session, struct tls_pre_decr=
ypt_state *state,
-                               struct link_socket_actual=
 *from);
+bool session_skip_to_pre_start(struct tls_session *session, const=
 struct tls_pre_decrypt_state *state,
+                               const=
 struct link_socket_actual *from);
 
 #endif /* ifndef OPENVPN_SSL_H */
dif=
f --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh
index a=
6d57f2=2E=2E2150d81 100644
--- a/src/openvpn/ssl_backend=2Eh
+++ b/src/open=
vpn/ssl_backend=2Eh
@@ -137,7 +137,7 @@
  *
  * @return      true if the co=
ntext is initialised, false if not=2E
  */
-bool tls_ctx_initialised(struct=
 tls_root_ctx *ctx);
+bool tls_ctx_initialised(const struct tls_root_ctx *c=
tx);
 
 /**
  * Set any library specific options=2E
diff --git a/src/openvp=
n/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 9983742=2E=2E965ecdb =
100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
=
@@ -146,7 +146,7 @@
 }
 
 bool
-tls_ctx_initialised(struct tls_root_ctx *ct=
x)
+tls_ctx_initialised(const struct tls_root_ctx *ctx)
 {
     /* either t=
his should be NULL or should be non-null and then have a
      * valid TLS =
ctx inside as well */
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvp=
n/ssl_openssl=2Ec
index 96e90f82=2E=2E7805d43 100644
--- a/src/openvpn/ssl_=
openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -129,7 +129,7 @@
 }
 
 boo=
l
-tls_ctx_initialised(struct tls_root_ctx *ctx)
+tls_ctx_initialised(const=
 struct tls_root_ctx *ctx)
 {
     /* either this should be NULL or should =
be non-null and then have a
      * valid TLS ctx inside as well */
@@ -202=
5,7 +2025,7 @@
 }
 
 static void
-bio_debug_data(const char *mode, BIO *bio=
, const uint8_t *buf, int len, const char *desc)
+bio_debug_data(const char=
 *mode, const BIO *bio, const uint8_t *buf, int len, const char *desc)
 {
 =
    struct gc_arena gc =3D gc_new();
     if (len > 0)
@@ -2039,7 +2039,7 @=
@
 }
 
 static void
-bio_debug_oc(const char *mode, BIO *bio)
+bio_debug_oc=
(const char *mode, const BIO *bio)
 {
     open_biofp();
     fprintf(biofp=
, "BIO %s time=3D%" PRIi64 " bio=3D" ptr_format "\n", mode, (int64_t)time(N=
ULL),
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index =
e9afda4=2E=2Ef78782f 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn=
/ssl_pkt=2Ec
@@ -119,7 +119,7 @@
  */
 static void
 tls_wrap_control(struct=
 tls_wrap_ctx *ctx, uint8_t header, struct buffer *buf,
-                 s=
truct session_id *session_id)
+                 const struct session_id *se=
ssion_id)
 {
     if (ctx->mode =3D=3D TLS_WRAP_AUTH || ctx->mode =3D=3D TL=
S_WRAP_NONE)
     {
@@ -403,9 +403,9 @@
 
 
 struct buffer
-tls_reset_stand=
alone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-         =
            struct session_id *own_sid, struct session_id *remote_sid, uint=
8_t header,
-                     bool request_resend_wkc)
+tls_reset_stand=
alone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,
+   =
                  const struct session_id *own_sid, const struct session_id=
 *remote_sid,
+                     uint8_t header, bool request_resend_wkc=
)
 {
     /* Copy buffer here to point at the same data but allow tls_wrap_=
control
      * to potentially change buf to point to another buffer withou=
t
@@ -490,7 +490,7 @@
 bool
 check_session_hmac_and_pkt_id(struct tls_pre_d=
ecrypt_state *state,
                               const struct openvpn_so=
ckaddr *from,
-                              uint8_t *key,
+               =
               const uint8_t *key,
                               int handw=
indow,
                               bool pkt_is_ack)
 {
diff --git a/src/=
openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 03e8930=2E=2E8203e4a 10=
0644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -183,7 =
+183,7 @@
  * @return              the expected server session id
  */
 boo=
l check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const =
struct openvpn_sockaddr *from,
-                                   uint8_t =
*key, int handwindow, bool pkt_is_ack);
+                                  =
 const uint8_t *key, int handwindow, bool pkt_is_ack);
 
 /*
  * Write a co=
ntrol channel authentication record=2E
@@ -210,8 +210,9 @@
  * from the tls=
 pre decrypt state=2E
  *
  */
-struct buffer tls_reset_standalone(struct t=
ls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-                       =
            struct session_id *own_sid, struct session_id *remote_sid,
+str=
uct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_=
auth_standalone *tas,
+                                   const struct sess=
ion_id *own_sid,
+                                   const struct session_i=
d *remote_sid,
                                    uint8_t header, bool req=
uest_resend_wkc);
 
 
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn=
/ssl_verify=2Ec
index 6631718=2E=2E0acba2b 100644
--- a/src/openvpn/ssl_ver=
ify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1140,7 +1140,7 @@
  * cache=2E=

  */
 static bool
-tls_authentication_status_use_cache(struct tls_multi *m=
ulti)
+tls_authentication_status_use_cache(const struct tls_multi *multi)
 =
{
     unsigned int idx =3D min_uint(multi->tas_cache_num_updates, SIZE(cac=
he_intervals) - 1);
     time_t latency =3D cache_intervals[idx];
@@ -1284,=
7 +1284,7 @@
  * Check if the script/plugin left a message in the auth fail=
ed message
  * file and relay it to the user */
 static void
-check_for_cli=
ent_reason(struct tls_multi *multi, struct auth_deferred_status *status)
+c=
heck_for_client_reason(struct tls_multi *multi, const struct auth_deferred_=
status *status)
 {
     struct gc_arena gc =3D gc_new();
     const char *m=
sg =3D key_state_check_auth_failed_message_file(status, &gc);
@@ -1553,7 +1=
553,7 @@
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 static bool
-set_verify_u=
ser_pass_env(struct user_pass *up, struct tls_multi *multi, struct tls_sess=
ion *session)
+set_verify_user_pass_env(const struct user_pass *up, struct =
tls_multi *multi, struct tls_session *session)
 {
     /* Is username defin=
ed? */
     if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) ||=
 strlen(up->username))
@@ -1581,7 +1581,7 @@
 }
 
 bool
-ssl_verify_usernam=
e_length(struct tls_session *session, const char *username)
+ssl_verify_use=
rname_length(const struct tls_session *session, const char *username)
 {
  =
   if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
         &&=
 strlen(username) > TLS_USERNAME_LEN)
diff --git a/src/openvpn/ssl_verify=
=2Eh b/src/openvpn/ssl_verify=2Eh
index 3176d76=2E=2Ee77bc4a 100644
--- a/s=
rc/openvpn/ssl_verify=2Eh
+++ b/src/openvpn/ssl_verify=2Eh
@@ -202,7 +202,7=
 @@
  * @return              true if name is under limit or username-as-com=
mon-name
  *                      is not active
  */
-bool ssl_verify_usern=
ame_length(struct tls_session *session, const char *username);
+bool ssl_ve=
rify_username_length(const struct tls_session *session, const char *usernam=
e);
 
 /**
  * Runs the --client-crresponse script if one is defined=2E
@@ =
-275,7 +275,7 @@
 void auth_set_client_reason(struct tls_multi *multi, cons=
t char *client_reason);
 
 static inline const char *
-tls_client_reason(st=
ruct tls_multi *multi)
+tls_client_reason(const struct tls_multi *multi)
 {=

     return multi->client_reason;
 }
diff --git a/src/openvpn/status=2Ec b=
/src/openvpn/status=2Ec
index c7d375b=2E=2Ecfbc38d 100644
--- a/src/openvpn=
/status=2Ec
+++ b/src/openvpn/status=2Ec
@@ -135,7 +135,7 @@
 }
 
 void
-st=
atus_reset(struct status_output *so)
+status_reset(const struct status_outp=
ut *so)
 {
     if (so && so->fd >=3D 0)
     {
diff --git a/src/openvpn/st=
atus=2Eh b/src/openvpn/status=2Eh
index 7953a4e=2E=2E4c01d75 100644
--- a/s=
rc/openvpn/status=2Eh
+++ b/src/openvpn/status=2Eh
@@ -69,7 +69,7 @@
 
 boo=
l status_trigger(struct status_output *so);
 
-void status_reset(struct sta=
tus_output *so);
+void status_reset(const struct status_output *so);
 
 voi=
d status_flush(struct status_output *so);
 
diff --git a/src/openvpn/tun=2E=
c b/src/openvpn/tun=2Ec
index 133f670=2E=2Ef191a6b 100644
--- a/src/openvpn=
/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -835,7 +835,7 @@
          const char=
 *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 IPv6 */
          int =
ifconfig_ipv6_netbits_parm,
          const char *ifconfig_ipv6_remote_parm=
,    /* --ifconfig parm 2 IPv6 */
-         struct addrinfo *local_public, =
struct addrinfo *remote_public, const bool strict_warn,
+         const str=
uct addrinfo *local_public, const struct addrinfo *remote_public, const boo=
l strict_warn,
          struct env_set *es, openvpn_net_ctx_t *ctx, struct=
 tuntap *tt)
 {
     if (!tt)
@@ -978,7 +978,7 @@
  * -> helper function to=
 simplify code below
  */
 static void
-add_route_connected_v6_net(struct t=
untap *tt, const struct env_set *es)
+add_route_connected_v6_net(const stru=
ct tuntap *tt, const struct env_set *es)
 {
     struct route_ipv6 r6;
 
@@=
 -1020,7 +1020,7 @@
  */
 
 in_addr_t
-create_arbitrary_remote(struct tunta=
p *tt)
+create_arbitrary_remote(const struct tuntap *tt)
 {
     in_addr_t =
remote;
 
@@ -1592,7 +1592,7 @@
 }
 
 static void
-undo_ifconfig_ipv4(struc=
t tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv4(const struct tunt=
ap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     int netb=
its =3D netmask_to_netbits2(tt->remote_netmask);
@@ -1627,7 +1627,7 @@
 }
 =

 static void
-undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx=
)
+undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 =
#if defined(TARGET_LINUX)
     if (net_addr_v6_del(ctx, tt->actual_name, &t=
t->local_ipv6, tt->netbits_ipv6) < 0)
@@ -1652,7 +1652,7 @@
 }
 
 void
-und=
o_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig(const =
struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     if (tt->backend_driver !=
=3D DRIVER_NULL && tt->backend_driver !=3D DRIVER_AFUNIX)
     {
@@ -1720,1=
3 +1720,13 @@
 }
 
 static ssize_t
-write_tun_header(struct tuntap *tt, uin=
t8_t *buf, int len)
+write_tun_header(const struct tuntap *tt, const uint8_=
t *buf, int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
         =
u_int32_t type;
         struct iovec iv[2];
-        const struct ip *iph =
=3D (struct ip *)buf;
+        const struct ip *iph =3D (const struct ip *)=
buf;
 
         if (iph->ip_v =3D=3D 6)
         {
@@ -1737,9 +1737,11 @@
 =
            type =3D htonl(AF_INET);
         }
 
+        /* argument to w=
ritev is a pointer to const but we still need to drop
+         * the const=
 from buf pointer here */
         iv[0]=2Eiov_base =3D &type;
         iv[=
0]=2Eiov_len =3D sizeof(type);
-        iv[1]=2Eiov_base =3D buf;
+        =
iv[1]=2Eiov_base =3D (void *)buf;
         iv[1]=2Eiov_len =3D len;
 
     =
    return header_modify_read_write_return(writev(tt->fd, iv, 2));
@@ -1751=
,7 +1753,7 @@
 }
 
 static ssize_t
-read_tun_header(struct tuntap *tt, uint=
8_t *buf, int len)
+read_tun_header(const struct tuntap *tt, uint8_t *buf, =
int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
@@ -1777,13 +1779=
,13 @@
  */
 #if !defined(TARGET_DARWIN)
 ssize_t
-write_tun(struct tuntap =
*tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8=
_t *buf, int len)
 {
     return write_tun_header(tt, buf, len);
 }
 
 ssiz=
e_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const str=
uct tuntap *tt, uint8_t *buf, int len)
 {
     return read_tun_header(tt, b=
uf, len);
 }
@@ -1799,7 +1801,7 @@
 
 #if defined(TARGET_LINUX) || defined(=
TARGET_FREEBSD)
 static bool
-tun_dco_enabled(struct tuntap *tt)
+tun_dco_e=
nabled(const struct tuntap *tt)
 {
     return tt->backend_driver =3D=3D DR=
IVER_DCO;
 }
@@ -2047,13 +2049,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap=
 *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint=
8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t
-r=
ead_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tu=
ntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }
=
@@ -2252,13 +2254,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t=
 *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int=
 len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struc=
t tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uin=
t8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }
@@ -2588,7 +2=
590,7 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)=

+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     s=
truct strbuf sbuf;
     sbuf=2Elen =3D len;
@@ -2597,7 +2599,7 @@
 }
 
 ssi=
ze_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const st=
ruct tuntap *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
     in=
t f =3D 0;
@@ -3095,7 +3097,7 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt=
, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t =
*buf, int len)
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
@@=
 -3108,7 +3110,7 @@
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf=
, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
   =
  if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
@@ -3243,13 +3245,13 @@=

 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_=
tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     return wr=
ite(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *=
buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
=
     return read(tt->fd, buf, len);
 }
@@ -3311,7 +3313,7 @@
 }
 
 int
-tun=
_write_queue(struct tuntap *tt, struct buffer *buf)
+tun_write_queue(struct=
 tuntap *tt, const struct buffer *buf)
 {
     if (tt->writes=2Eiostate =3D=
=3D IOSTATE_INITIAL)
     {
@@ -3365,7 +3367,7 @@
 }
 
 int
-tun_write_win3=
2(struct tuntap *tt, struct buffer *buf)
+tun_write_win32(struct tuntap *tt=
, const struct buffer *buf)
 {
     int err =3D 0;
     int status =3D 0;
@=
@ -5370,7 +5372,7 @@
 }
 
 void
-fork_register_dns_action(struct tuntap *tt=
)
+fork_register_dns_action(const struct tuntap *tt)
 {
     if (tt && tt->=
options=2Eregister_dns && tt->options=2Emsg_channel)
     {
@@ -5460,7 +546=
2,7 @@
 }
 
 static void
-tuntap_get_mtu(struct tuntap *tt)
+tuntap_get_mtu=
(const struct tuntap *tt)
 {
     ULONG mtu =3D 0;
     DWORD len;
@@ -6035=
,7 +6037,7 @@
 }
 
 void
-tun_show_debug(struct tuntap *tt)
+tun_show_debug=
(const struct tuntap *tt)
 {
     if (tt->backend_driver =3D=3D WINDOWS_DRI=
VER_TAP_WINDOWS6)
     {
@@ -6295,13 +6297,13 @@
 }
 
 ssize_t
-write_tun(s=
truct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt=
, const uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 =

 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(con=
st struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, bu=
f, len);
 }
diff --git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh
index 73=
40e7e=2E=2E61fe943 100644
--- a/src/openvpn/tun=2Eh
+++ b/src/openvpn/tun=
=2Eh
@@ -272,9 +272,9 @@
 
 void close_tun_handle(struct tuntap *tt);
 
-ss=
ize_t write_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t write_t=
un(const struct tuntap *tt, const uint8_t *buf, int len);
 
-ssize_t read_t=
un(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t read_tun(const struc=
t tuntap *tt, uint8_t *buf, int len);
 
 #ifdef ENABLE_FEATURE_TUN_PERSIST
=
 void tuncfg(const char *dev, const char *dev_type, const char *dev_node, i=
nt persist_mode,
@@ -293,7 +293,7 @@
                         const char *i=
fconfig_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 */
               =
          int ifconfig_ipv6_netbits_parm,           /* --ifconfig parm 1 / =
bits */
                         const char *ifconfig_ipv6_remote_parm,    =
/* --ifconfig parm 2 / IPv6 */
-                        struct addrinfo *lo=
cal_public, struct addrinfo *remote_public,
+                        const =
struct addrinfo *local_public, const struct addrinfo *remote_public,
      =
                   const bool strict_warn, struct env_set *es, openvpn_net_=
ctx_t *ctx,
                         struct tuntap *tt);
 
@@ -320,7 +320,7=
 @@
  * @param tt    the tuntap interface context
  * @param ctx   the netw=
orking API opaque context
  */
-void undo_ifconfig(struct tuntap *tt, openv=
pn_net_ctx_t *ctx);
+void undo_ifconfig(const struct tuntap *tt, openvpn_ne=
t_ctx_t *ctx);
 
 bool is_dev_type(const char *dev, const char *dev_type, c=
onst char *match_type);
 
@@ -351,7 +351,7 @@
 #define IFCONFIG_DEFAULT IFC=
ONFIG_AFTER_TUN_OPEN
 
 static inline int
-ifconfig_order(struct tuntap *tt=
)
+ifconfig_order(const struct tuntap *tt)
 {
     if (tt->backend_driver =
=3D=3D DRIVER_AFUNIX)
     {
@@ -381,7 +381,7 @@
 #define ROUTE_ORDER_DEFAU=
LT ROUTE_AFTER_TUN
 
 static inline int
-route_order(struct tuntap *tt)
+ro=
ute_order(const struct tuntap *tt)
 {
     if (tt->backend_driver =3D=3D DR=
IVER_AFUNIX)
     {
@@ -454,13 +454,13 @@
 
 const char *tap_win_getinfo(co=
nst struct tuntap *tt, struct gc_arena *gc);
 
-void tun_show_debug(struct =
tuntap *tt);
+void tun_show_debug(const struct tuntap *tt);
 
 bool dhcp_re=
lease_by_adapter_index(const DWORD adapter_index);
 
 bool dhcp_renew_by_ad=
apter_index(const DWORD adapter_index);
 
-void fork_register_dns_action(st=
ruct tuntap *tt);
+void fork_register_dns_action(const struct tuntap *tt);
=
 
 void ipconfig_register_dns(const struct env_set *es);
 
@@ -470,7 +470,7=
 @@
 
 int tun_read_queue(struct tuntap *tt, int maxsize);
 
-int tun_write=
_queue(struct tuntap *tt, struct buffer *buf);
+int tun_write_queue(struct =
tuntap *tt, const struct buffer *buf);
 
 static inline bool
 tuntap_stop(i=
nt status)
@@ -499,7 +499,7 @@
     return false;
 }
 
-int tun_write_win32=
(struct tuntap *tt, struct buffer *buf);
+int tun_write_win32(struct tuntap=
 *tt, const struct buffer *buf);
 
 static inline bool
 is_ip_packet_valid(=
const struct buffer *buf)
@@ -529,19 +529,21 @@
 }
 
 static inline bool
-t=
untap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(const struct tuntap =
*tt)
 {
     return tt && tt->backend_driver =3D=3D DRIVER_DCO;
 }
 
 stati=
c inline bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)=

+tuntap_is_dco_win_timeout(const struct tuntap *tt, ssize_t status)
 {
   =
  return tuntap_is_dco_win(tt) && (status < 0) && (openvpn_errno() =3D=3D E=
RROR_NETNAME_DELETED);
 }
 
 #else  /* ifdef _WIN32 */
 
+// cppcheck-suppr=
ess-begin constParameterPointer ; stubs
+
 static inline bool
 tuntap_stop(=
int status)
 {
@@ -565,19 +567,20 @@
     return true;
 }
 
-
 static inlin=
e bool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(const struc=
t tuntap *tt)
 {
     return false;
 }
 
 static inline bool
-tuntap_is_dco=
_win_timeout(struct tuntap *tt, ssize_t status)
+tuntap_is_dco_win_timeout(=
const struct tuntap *tt, ssize_t status)
 {
     return false;
 }
 
+// cpp=
check-suppress-end constParameterPointer
+
 #endif /* ifdef _WIN32 */
 
 /*=

diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec
index=
 f494d42=2E=2E79d706a 100644
--- a/src/openvpn/tun_afunix=2Ec
+++ b/src/ope=
nvpn/tun_afunix=2Ec
@@ -49,7 +49,7 @@
 
 
 static void
-tun_afunix_exec_chi=
ld(const char *dev_node, struct tuntap *tt, struct env_set *env)
+tun_afuni=
x_exec_child(const char *dev_node, struct tuntap *tt, const struct env_set =
*env)
 {
     const char *msgprefix =3D "ERROR: failure executing process f=
or tun:";
     struct argv argv =3D argv_new();
@@ -74,7 +74,7 @@
 }
 
 voi=
d
-open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struct en=
v_set *orig_env)
+open_tun_afunix(const struct options *o, int mtu, struct =
tuntap *tt, const struct env_set *orig_env)
 {
     struct gc_arena gc =3D =
gc_new();
 
@@ -146,7 +146,7 @@
 }
 
 ssize_t
-write_tun_afunix(struct tunt=
ap *tt, uint8_t *buf, int len)
+write_tun_afunix(struct tuntap *tt, const u=
int8_t *buf, int len)
 {
     const char *msg =3D "ERROR: failure during wr=
ite to AF_UNIX socket: ";
     if (!openvpn_waitpid_check(tt->afunix=2Echil=
dprocess, msg, M_WARN))
@@ -172,8 +172,11 @@
     return read(tt->fd, buf, =
len);
 }
 #else  /* ifndef WIN32 */
+
+// cppcheck-suppress-begin constPara=
meterPointer ; stubs
+
 void
-open_tun_afunix(struct options *o, int mtu, s=
truct tuntap *tt, struct env_set *orig_env)
+open_tun_afunix(const struct o=
ptions *o, int mtu, struct tuntap *tt, const struct env_set *orig_env)
 {
 =
    msg(M_ERR, "AF_UNIX socket support not available on this platform");
 }=

@@ -186,7 +189,7 @@
 }
 
 ssize_t
-write_tun_afunix(struct tuntap *tt, uin=
t8_t *buf, int len)
+write_tun_afunix(struct tuntap *tt, const uint8_t *buf=
, int len)
 {
     /* should never be called as open_tun_afunix always fail=
s */
     ASSERT(0);
@@ -199,4 +202,6 @@
     ASSERT(0);
 }
 
+// cppcheck-=
suppress-end constParameterPointer
+
 #endif /* ifndef WIN32 */
diff --git =
a/src/openvpn/tun_afunix=2Eh b/src/openvpn/tun_afunix=2Eh
index 5b6a8e0=2E=
=2E5307e31 100644
--- a/src/openvpn/tun_afunix=2Eh
+++ b/src/openvpn/tun_af=
unix=2Eh
@@ -31,7 +31,7 @@
  * the user provided taking care of implementin=
g the actual tun
  * device=2E
  */
-void open_tun_afunix(struct options *o=
, int mtu, struct tuntap *tt, struct env_set *env);
+void open_tun_afunix(c=
onst struct options *o, int mtu, struct tuntap *tt, const struct env_set *e=
nv);
 
 
 /**
@@ -43,7 +43,7 @@
 /**
  * Writes a packet to a AF_UNIX based=
 tun device=2E
  */
-ssize_t write_tun_afunix(struct tuntap *tt, uint8_t *b=
uf, int len);
+ssize_t write_tun_afunix(struct tuntap *tt, const uint8_t *b=
uf, int len);
 
 /**
  * Reads a packet from a AF_UNIX based tun device=2E
=
diff --git a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec
index 69ac10d=2E=
=2E04e18d6 100644
--- a/src/openvpn/vlan=2Ec
+++ b/src/openvpn/vlan=2Ec
@@ =
-288,7 +288,7 @@
 }
 
 void
-vlan_process_outgoing_tun(struct multi_context=
 *m, struct multi_instance *mi)
+vlan_process_outgoing_tun(const struct mul=
ti_context *m, struct multi_instance *mi)
 {
     if (!m->top=2Eoptions=2Ev=
lan_tagging)
     {
diff --git a/src/openvpn/vlan=2Eh b/src/openvpn/vlan=2E=
h
index 9389f89=2E=2Ecd2f66f 100644
--- a/src/openvpn/vlan=2Eh
+++ b/src/op=
envpn/vlan=2Eh
@@ -35,6 +35,6 @@
 
 bool vlan_is_tagged(const struct buffer=
 *buf);
 
-void vlan_process_outgoing_tun(struct multi_context *m, struct m=
ulti_instance *mi);
+void vlan_process_outgoing_tun(const struct multi_cont=
ext *m, struct multi_instance *mi);
 
 #endif /* VLAN_H */
diff --git a/src=
/openvpn/win32=2Eh b/src/openvpn/win32=2Eh
index 8be3d96=2E=2E39ff7d8 10064=
4
--- a/src/openvpn/win32=2Eh
+++ b/src/openvpn/win32=2Eh
@@ -227,7 +227,7 =
@@
 void overlapped_io_close(struct overlapped_io *o);
 
 static inline boo=
l
-overlapped_io_active(struct overlapped_io *o)
+overlapped_io_active(cons=
t struct overlapped_io *o)
 {
     return o->iostate =3D=3D IOSTATE_QUEUED =
|| o->iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;
 }
diff --git a/src/openvpnm=
sica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index 1a17d95=2E=
=2Ed2fd9af 100644
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src/openvpn=
msica/openvpnmsica=2Ec
@@ -77,7 +77,7 @@
  * @return ERROR_SUCCESS on succe=
ss; An error code otherwise
  */
 static UINT
-setup_sequence(_In_ MSIHANDL=
E hInstall, _In_z_ LPCWSTR szProperty, _In_ struct msica_arg_seq *seq)
+set=
up_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ const =
struct msica_arg_seq *seq)
 {
     UINT uiResult;
     LPWSTR szSequence =
=3D msica_arg_seq_join(seq);
diff --git a/src/openvpnserv/interactive=2Ec b=
/src/openvpnserv/interactive=2Ec
index 9a68bbb=2E=2Ed8cf6e1 100644
--- a/sr=
c/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -522=
,7 +522,7 @@
 
 
 static SOCKADDR_INET
-sockaddr_inet(short family, inet_ad=
dress_t *addr)
+sockaddr_inet(short family, const inet_address_t *addr)
 {
=
     SOCKADDR_INET sa_inet;
     ZeroMemory(&sa_inet, sizeof(sa_inet));
dif=
f --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/o=
penvpn/mock_management=2Ec
index 77f6ce2=2E=2Efff4c2b 100644
--- a/tests/un=
it_tests/openvpn/mock_management=2Ec
+++ b/tests/unit_tests/openvpn/mock_ma=
nagement=2Ec
@@ -36,7 +36,7 @@
 struct management *management; /* GLOBAL */=

 
 void
-management_auth_failure(struct management *man, const char *type,=
 const char *reason)
+management_auth_failure(const struct management *man,=
 const char *type, const char *reason)
 {
     ASSERT(false);
 }
diff --git=
 a/tests/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/=
siphash_openssl=2Ec
index 52f13b8=2E=2Ee7282b2 100644
--- a/tests/unit_test=
s/openvpn/siphash_openssl=2Ec
+++ b/tests/unit_tests/openvpn/siphash_openss=
l=2Ec
@@ -100,7 +100,7 @@
 }
 
 bool
-siphash_openssl_available(void *sip_c=
ontext)
+siphash_openssl_available(const void *sip_context)
 {
     const s=
truct siphash_context *sip =3D sip_context;
 
@@ -117,6 +117,8 @@
 }
 #else=

 /* Do avoid a lot more ifdefs in the test we put dummy functions here */
=
+// cppcheck-suppress-begin constParameterPointer ; stubs
+
 int
 siphash_o=
penssl(void *sip_context, const void *in, const size_t inlen,
             =
    const void *k, uint8_t *out, const size_t outlen)
@@ -125,7 +127,7 @@
 =
}
 
 bool
-siphash_openssl_available(void *sip_context)
+siphash_openssl_av=
ailable(const void *sip_context)
 {
     return false;
 }
@@ -141,5 +143,6 =
@@
 {
 }
 
+// cppcheck-suppress-end constParameterPointer
 
 #endif /* if =
defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D 0x30000000L *=
/
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/op=
envpn/test_misc=2Ec
index 8d88943=2E=2Eaea40f0 100644
--- a/tests/unit_test=
s/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -14=
6,7 +146,7 @@
 }
 
 static struct hash_element *
-hash_lookup_by_value(stru=
ct hash *hash, void *value)
+hash_lookup_by_value(struct hash *hash, const =
void *value)
 {
     struct hash_iterator hi;
     struct hash_element *he;=

diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/unit_test=
s/openvpn/test_user_pass=2Ec
index c0a0866=2E=2E7636a33 100644
--- a/tests/=
unit_tests/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests/openvpn/test_u=
ser_pass=2Ec
@@ -59,7 +59,7 @@
     return mock();
 }
 void
-management_aut=
h_failure(struct management *man, const char *type, const char *reason)
+ma=
nagement_auth_failure(const struct management *man, const char *type, const=
 char *reason)
 {
     assert_true(0);
 }

-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
Gerrit-Chan=
ge-Number: 1663
Gerrit-PatchSet: 33
Gerrit-Owner: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--BirTy59K7JQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1663?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Remove instances of constParameter=
Pointer cppcheck warnings<br><br>This requires a few suppressions since cpp=
check<br>doesn&#39;t quite understand the different code-paths<br>implement=
ed by preprocessor defines=2E<br><br>Change-Id: I56248cf6d199c2da770774b8fd=
1e5daf2b116f58<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerri=
t URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663<br>Message-Id: &lt;2=
0261015113218=2E24245-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2E=
kernel=2Eorg/openvpn-devel/20261015113218=2E24245-1-gert@greenie=2Emuc=2Ede=
/<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>=
M dev-tools/cppcheck-suppressions=2Exml<br>M sample/sample-plugins/client-c=
onnect/sample-client-connect=2Ec<br>M sample/sample-plugins/defer/multi-aut=
h=2Ec<br>M sample/sample-plugins/keying-material-exporter-demo/keyingmateri=
alexporter=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/clinat=2Ec<br>M=
 src/openvpn/comp=2Ec<br>M src/openvpn/comp=2Eh<br>M src/openvpn/crypto=2Ec=
<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/dco=2Ec<br>M src/openvpn/dco=
=2Eh<br>M src/openvpn/dco_freebsd=2Ec<br>M src/openvpn/dco_internal=2Eh<br>=
M src/openvpn/dco_linux=2Ec<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/e=
rror=2Ec<br>M src/openvpn/error=2Eh<br>M src/openvpn/event=2Ec<br>M src/ope=
nvpn/event=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/forward=2Eh<br=
>M src/openvpn/init=2Ec<br>M src/openvpn/init=2Eh<br>M src/openvpn/interval=
=2Eh<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/m=
anage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/mbuf=2Ec<br>M src/op=
envpn/mbuf=2Eh<br>M src/openvpn/mss=2Ec<br>M src/openvpn/mss=2Eh<br>M src/o=
penvpn/mtcp=2Ec<br>M src/openvpn/mtcp=2Eh<br>M src/openvpn/mudp=2Ec<br>M sr=
c/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/multi_io=2E=
c<br>M src/openvpn/networking=2Eh<br>M src/openvpn/networking_iproute2=2Ec<=
br>M src/openvpn/networking_sitnl=2Ec<br>M src/openvpn/occ=2Eh<br>M src/ope=
nvpn/openssl_compat=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/optio=
ns_parse=2Ec<br>M src/openvpn/otime=2Ec<br>M src/openvpn/otime=2Eh<br>M src=
/openvpn/proto=2Eh<br>M src/openvpn/proxy=2Ec<br>M src/openvpn/proxy=2Eh<br=
>M src/openvpn/ps=2Ec<br>M src/openvpn/ps=2Eh<br>M src/openvpn/push=2Ec<br>=
M src/openvpn/push=2Eh<br>M src/openvpn/push_util=2Ec<br>M src/openvpn/reli=
able=2Ec<br>M src/openvpn/reliable=2Eh<br>M src/openvpn/route=2Ec<br>M src/=
openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M src/openvpn/socket_util=
=2Eh<br>M src/openvpn/socks=2Ec<br>M src/openvpn/socks=2Eh<br>M src/openvpn=
/ssl=2Ec<br>M src/openvpn/ssl=2Eh<br>M src/openvpn/ssl_backend=2Eh<br>M src=
/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn/=
ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M src/openvpn/ssl_verify=2Ec<br=
>M src/openvpn/ssl_verify=2Eh<br>M src/openvpn/status=2Ec<br>M src/openvpn/=
status=2Eh<br>M src/openvpn/tun=2Ec<br>M src/openvpn/tun=2Eh<br>M src/openv=
pn/tun_afunix=2Ec<br>M src/openvpn/tun_afunix=2Eh<br>M src/openvpn/vlan=2Ec=
<br>M src/openvpn/vlan=2Eh<br>M src/openvpn/win32=2Eh<br>M src/openvpnmsica=
/openvpnmsica=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M tests/unit_test=
s/openvpn/mock_management=2Ec<br>M tests/unit_tests/openvpn/siphash_openssl=
=2Ec<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>M tests/unit_tests/open=
vpn/test_user_pass=2Ec<br>88 files changed, 398 insertions(+), 284 deletion=
s(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppressions=2Exml b/=
dev-tools/cppcheck-suppressions=2Exml</span><br><span>index 9d8c202=2E=2Ebd=
24c3b 100644</span><br><span>--- a/dev-tools/cppcheck-suppressions=2Exml</s=
pan><br><span>+++ b/dev-tools/cppcheck-suppressions=2Exml</span><br><span>@=
@ -9,9 +9,6 @@</span><br><span>     &lt;id&gt;constParameterCallback&lt;/id=
&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span>   &lt;suppress&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;id&gt;const=
ParameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  &lt;suppress&gt;</span><br><span>     &lt;id&gt;unusedFunction&lt;/id=
&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span>   &lt;suppress&g=
t;</span><br><span>@@ -65,6 +62,97 @@</span><br><span>     &lt;id&gt;badBit=
maskCheck&lt;/id&gt;</span><br><span>     &lt;fileName&gt;tests/unit_tests/=
openvpn/test_pkt=2Ec&lt;/fileName&gt;</span><br><span>   &lt;/suppress&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: we us=
e casts to remove const --&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/buffer=
=2Eh&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &lt;symbolName&gt;buf&lt;/symbolName&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  &lt;!-- FP: const silently removed due to poin=
ter arithmetic --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/buffer=2Ec&lt;/=
fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt=
;symbolName&gt;buf&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  &lt;!-- IGN: external --&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;=
/usr/include/*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  &lt;!-- IGN: too many false-positives due to stubs --&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParam=
eterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &lt;fileName&gt;tests/unit_tests/openvpn*/test_*&lt;/fileName&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constPara=
meterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &lt;fileName&gt;tests/unit_tests/openvpn/mock_*&lt;/fileName&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: too man=
y false-positives due to library/platform-specific code --&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPoint=
er&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &l=
t;fileName&gt;src/openvpn/crypto*&lt;/fileName&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&g=
t;src/openvpn/ssl_*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/=
dco*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/socket=2E*&lt;/=
fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/=
suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!=
-- FP: const is only possible on some platforms</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+       These might easily hide valid issues but=
 we need to compromise</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+       for developer sanity=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+       Inline suppressions are often too ugly since they need=
 to go in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       bet=
ween our return type line and the function name=2E=2E=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  --&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src=
/openvpn/dns=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &lt;symbolName&gt;duri&lt;/symbolName&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&=
lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;f=
ileName&gt;src/openvpn/error=2Ec&lt;/fileName&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;gc&lt;/symbolName&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constPar=
ameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &lt;fileName&gt;src/openvpn/forward=2Ec&lt;/fileName&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;dco&lt;=
/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &l=
t;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &l=
t;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/manage=2Ec&lt;/fileNa=
me&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbo=
lName&gt;man&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/misc=
=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &lt;symbolName&gt;up&lt;/symbolName&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src=
/openvpn/options=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &lt;symbolName&gt;options&lt;/symbolName&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterP=
ointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &lt;fileName&gt;src/openvpn/tun=2Ec&lt;/fileName&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;gc&lt;/symbolName&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: w=
eird issue with MinGW debug build throwing -Werror=3Dmaybe-uninitialized</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+       for no good rea=
son --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;sup=
press&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id=
&gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/buffer=2Eh&lt;/fileName&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName=
&gt;p&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  &lt;/suppress&gt;</span><br><span>   &lt;!-- FP: cppcheck seems to h=
ave wrong signature of DeviceIoControl() --&gt;</span><br><span>   &lt;supp=
ress&gt;</span><br><span>     &lt;id&gt;constVariablePointer&lt;/id&gt;</sp=
an><br><span>diff --git a/sample/sample-plugins/client-connect/sample-clien=
t-connect=2Ec b/sample/sample-plugins/client-connect/sample-client-connect=
=2Ec</span><br><span>index 420de61=2E=2Ecbd98e8 100644</span><br><span>--- =
a/sample/sample-plugins/client-connect/sample-client-connect=2Ec</span><br>=
<span>+++ b/sample/sample-plugins/client-connect/sample-client-connect=2Ec<=
/span><br><span>@@ -344,7 +344,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ope=
nvpn_plugin_client_connect(struct plugin_context *context, const char **arg=
v, const char **envp)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+openvpn_plugin_client_connect(const struct plugin_context *context, const=
 char **argv, const char **envp)</span><br><span> {</span><br><span>     /*=
 log environment variables handed to us by OpenVPN, but</span><br><span>   =
   * only if &quot;setenv verb&quot; is 3 or higher (arbitrary number)</spa=
n><br><span>@@ -465,7 +465,7 @@</span><br><span> </span><br><span> int</spa=
n><br><span> openvpn_plugin_client_connect_defer_v2(struct plugin_context *=
context,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                          struct plugin_per_client_context *pcc,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
         const struct plugin_per_client_context *pcc,</span><br><span>     =
                                   struct openvpn_plugin_string_list **retu=
rn_list)</span><br><span> {</span><br><span>     time_t time_left =3D pcc-&=
gt;sleep_until - time(NULL);</span><br><span>diff --git a/sample/sample-plu=
gins/defer/multi-auth=2Ec b/sample/sample-plugins/defer/multi-auth=2Ec</spa=
n><br><span>index bacf557=2E=2Ecdd616f 100644</span><br><span>--- a/sample/=
sample-plugins/defer/multi-auth=2Ec</span><br><span>+++ b/sample/sample-plu=
gins/defer/multi-auth=2Ec</span><br><span>@@ -255,7 +255,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-do_auth_user_pass(struct plugin_context *co=
ntext, const char *username, const char *password)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+do_auth_user_pass(const struct plugin_contex=
t *context, const char *username, const char *password)</span><br><span> {<=
/span><br><span>     plog(context, PLOG_NOTE, &quot;expect_user=3D%s, recei=
ved_user=3D%s, expect_passw=3D%s, received_passw=3D%s&quot;,</span><br><spa=
n>          np(context-&gt;test_valid_user), np(username), np(context-&gt;t=
est_valid_pass), np(password));</span><br><span>@@ -279,7 +279,7 @@</span><=
br><span> </span><br><span> </span><br><span> static int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-auth_user_pass_verify(struct plugin_cont=
ext *context, struct plugin_per_client_context *pcc,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+auth_user_pass_verify(const struct plugin=
_context *context, struct plugin_per_client_context *pcc,</span><br><span> =
                      const char *argv[], const char *envp[])</span><br><sp=
an> {</span><br><span>     /* get username/password from envp string array =
*/</span><br><span>diff --git a/sample/sample-plugins/keying-material-expor=
ter-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins/keying-material=
-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>index 204374b=2E=
=2E41c5c4f 100644</span><br><span>--- a/sample/sample-plugins/keying-materi=
al-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>+++ b/sample/sa=
mple-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec</span=
><br><span>@@ -187,7 +187,7 @@</span><br><span> }</span><br><span> </span><=
br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
file_store(char *file, char *content)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+file_store(const char *file, const char *content)</span><=
br><span> {</span><br><span>     FILE *f;</span><br><span>     if (!(f =3D =
fopen(file, &quot;w+&quot;)))</span><br><span>@@ -203,7 +203,7 @@</span><br=
><span> server_store(struct openvpn_plugin_args_func_in const *args)</span>=
<br><span> {</span><br><span>     struct plugin *plugin =3D (struct plugin =
*)args-&gt;handle;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 struct session *sess =3D (struct session *)args-&gt;per_client_context;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct sessi=
on *sess =3D args-&gt;per_client_context;</span><br><span> </span><br><span=
>     char file[MAXPATH];</span><br><span>     snprintf(file, sizeof(file) =
- 1, &quot;/tmp/openvpn_sso_%s&quot;, sess-&gt;key);</span><br><span>@@ -21=
5,7 +215,7 @@</span><br><span> client_store(struct openvpn_plugin_args_func=
_in const *args)</span><br><span> {</span><br><span>     struct plugin *plu=
gin =3D (struct plugin *)args-&gt;handle;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct session *sess =3D (struct session *)args-&gt=
;per_client_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct session *sess =3D args-&gt;per_client_context;</span><br>=
<span> </span><br><span>     char *file =3D &quot;/tmp/openvpn_sso_user&quo=
t;;</span><br><span>     ovpn_note(&quot;app session file: %s&quot;, file);=
</span><br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=
=2Eh</span><br><span>index 58e10f0=2E=2E063a2d4 100644</span><br><span>--- =
a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span=
><br><span>@@ -1920,7 +1920,7 @@</span><br><span>  * @param a  The arena to=
 test=2E</span><br><span>  */</span><br><span> static inline bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-gc_defined(struct gc_arena *a)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+gc_defined(const str=
uct gc_arena *a)</span><br><span> {</span><br><span>     return a-&gt;list =
!=3D NULL;</span><br><span> }</span><br><span>diff --git a/src/openvpn/clin=
at=2Ec b/src/openvpn/clinat=2Ec</span><br><span>index dcef924=2E=2Ed72d42a =
100644</span><br><span>--- a/src/openvpn/clinat=2Ec</span><br><span>+++ b/s=
rc/openvpn/clinat=2Ec</span><br><span>@@ -158,7 +158,7 @@</span><br><span> =
#endif</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-print_pkt(struct openvpn_iphdr *iph, const =
char *prefix, const int direction, const msglvl_t msglevel)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+print_pkt(const struct openvpn_iphd=
r *iph, const char *prefix, const int direction, const msglvl_t msglevel)</=
span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</sp=
an><br><span> </span><br><span>diff --git a/src/openvpn/comp=2Ec b/src/open=
vpn/comp=2Ec</span><br><span>index b88b79f=2E=2E387a7c4 100644</span><br><s=
pan>--- a/src/openvpn/comp=2Ec</span><br><span>+++ b/src/openvpn/comp=2Ec</=
span><br><span>@@ -159,7 +159,7 @@</span><br><span> #endif /* USE_COMP */</=
span><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-check_compression_settings_valid(struct compress_options *=
info, msglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+check_compression_settings_valid(const struct compress_options *info, =
msglvl_t msglevel)</span><br><span> {</span><br><span>     /*</span><br><sp=
an>      * We also allow comp-stub-v2 here as it technically allows escapin=
g of</span><br><span>diff --git a/src/openvpn/comp=2Eh b/src/openvpn/comp=
=2Eh</span><br><span>index 29a90a2=2E=2Ead80243 100644</span><br><span>--- =
a/src/openvpn/comp=2Eh</span><br><span>+++ b/src/openvpn/comp=2Eh</span><br=
><span>@@ -91,7 +91,7 @@</span><br><span>  * flags of allow-compression and=
 also the whether algorithms are compiled</span><br><span>  * in</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool check_=
compression_settings_valid(struct compress_options *info, msglvl_t msglevel=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool check_compre=
ssion_settings_valid(const struct compress_options *info, msglvl_t msglevel=
);</span><br><span> </span><br><span> #ifdef USE_COMP</span><br><span> #inc=
lude &quot;buffer=2Eh&quot;</span><br><span>diff --git a/src/openvpn/crypto=
=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 1703d4d=2E=2E3d3ab0c 10=
0644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src=
/openvpn/crypto=2Ec</span><br><span>@@ -1105,7 +1105,7 @@</span><br><span> =
}</span><br><span> </span><br><span> static bool</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-key_is_zero(struct key *key, const struct key_ty=
pe *kt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+key_is_zero(=
const struct key *key, const struct key_type *kt)</span><br><span> {</span>=
<br><span>     size_t cipher_length =3D cipher_kt_key_size(kt-&gt;cipher);<=
/span><br><span>     for (size_t i =3D 0; i &lt; cipher_length; ++i)</span>=
<br><span>@@ -1123,7 +1123,7 @@</span><br><span>  * Make sure that cipher k=
ey is a valid key for current key_type=2E</span><br><span>  */</span><br><s=
pan> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_key(st=
ruct key *key, const struct key_type *kt)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+check_key(const struct key *key, const struct key_typ=
e *kt)</span><br><span> {</span><br><span>     if (cipher_defined(kt-&gt;ci=
pher))</span><br><span>     {</span><br><span>@@ -1196,7 +1196,7 @@</span><=
br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-test_crypto(struct crypto_options *co, stru=
ct frame *frame)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tes=
t_crypto(struct crypto_options *co, const struct frame *frame)</span><br><s=
pan> {</span><br><span>     int i, j;</span><br><span>     struct gc_arena =
gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/crypto=2Eh b/src/=
openvpn/crypto=2Eh</span><br><span>index ee5b50f=2E=2Ee3c1c6a 100644</span>=
<br><span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/cr=
ypto=2Eh</span><br><span>@@ -414,7 +414,7 @@</span><br><span>  */</span><br=
><span> int write_key_file(const int nkeys, const char *filename);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool check_k=
ey(struct key *key, const struct key_type *kt);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool check_key(const struct key *key, const str=
uct key_type *kt);</span><br><span> </span><br><span> /**</span><br><span> =
 * Initialize a key_type structure with=2E</span><br><span>@@ -614,7 +614,7=
 @@</span><br><span> /** Print a cipher list entry */</span><br><span> void=
 print_cipher(const char *cipher);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void test_crypto(struct crypto_options *co,=
 struct frame *f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid test_crypto(struct crypto_options *co, const struct frame *f);</span><b=
r><span> </span><br><span> </span><br><span> /* key direction functions */<=
/span><br><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</spa=
n><br><span>index 9fc0e3b=2E=2Ef3b5d44 100644</span><br><span>--- a/src/ope=
nvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -=
573,7 +573,7 @@</span><br><span> }</span><br><span> </span><br><span> stati=
c bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_multi_get_l=
ocaladdr(struct multi_context *m, struct multi_instance *mi,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+dco_multi_get_localaddr(const stru=
ct multi_context *m, const struct multi_instance *mi,</span><br><span>     =
                    struct sockaddr_storage *local)</span><br><span> {</spa=
n><br><span> #if ENABLE_IP_PKTINFO</span><br><span>@@ -585,7 +585,7 @@</spa=
n><br><span>         return false;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_socke=
t_actual *actual =3D &amp;c-&gt;c2=2Elink_socket_infos[0]-&gt;lsa-&gt;actua=
l;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct =
link_socket_actual *actual =3D &amp;c-&gt;c2=2Elink_socket_infos[0]-&gt;lsa=
-&gt;actual;</span><br><span> </span><br><span>     switch (actual-&gt;dest=
=2Eaddr=2Esa=2Esa_family)</span><br><span>     {</span><br><span>@@ -623,7 =
+623,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-dco_multi_add_new_peer(struct=
 multi_context *m, struct multi_instance *mi)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+dco_multi_add_new_peer(const struct multi_context=
 *m, struct multi_instance *mi)</span><br><span> {</span><br><span>     con=
st struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span><br><=
span>@@ -677,7 +677,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_install_i=
route(struct multi_context *m, struct multi_instance *mi, struct mroute_add=
r *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_install=
_iroute(struct multi_context *m, struct multi_instance *mi, const struct mr=
oute_addr *addr)</span><br><span> {</span><br><span> #if defined(TARGET_LIN=
UX) || defined(TARGET_FREEBSD) || defined(_WIN32)</span><br><span>     if (=
!dco_enabled(&amp;m-&gt;top=2Eoptions))</span><br><span>diff --git a/src/op=
envpn/dco=2Eh b/src/openvpn/dco=2Eh</span><br><span>index 7ef75fee=2E=2Ec43=
5f8c 100644</span><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b=
/src/openvpn/dco=2Eh</span><br><span>@@ -204,7 +204,7 @@</span><br><span>  =
* @param mi        the client instance</span><br><span>  * @return         =
 0 on success or a negative error code otherwise</span><br><span>  */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-int dco_multi_add_new_peer(=
struct multi_context *m, struct multi_instance *mi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int dco_multi_add_new_peer(const struct m=
ulti_context *m, struct multi_instance *mi);</span><br><span> </span><br><s=
pan> /**</span><br><span>  * Install an iroute in DCO, which means adding a=
 route to the system routing</span><br><span>@@ -215,7 +215,7 @@</span><br>=
<span>  * @param addr      the route to add</span><br><span>  */</span><br>=
<span> void dco_install_iroute(struct multi_context *m, struct multi_instan=
ce *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
          struct mroute_addr *addr);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        const struct mroute_addr *addr);</=
span><br><span> </span><br><span> /**</span><br><span>  * Remove all routes=
 added through the specified client</span><br><span>@@ -253,7 +253,7 @@</sp=
an><br><span>  * a 64 bit packet counter and AEAD tag at the end=2E</span><=
br><span>  */</span><br><span> bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-dco_supports_epoch_data(struct context *c);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct =
context *c);</span><br><span> #else  /* if defined(ENABLE_DCO) */</span><br=
><span> </span><br><span> typedef void *dco_context_t;</span><br><span>@@ -=
350,7 +350,7 @@</span><br><span> }</span><br><span> </span><br><span> stati=
c inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_multi=
_add_new_peer(struct multi_context *m, struct multi_instance *mi)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+dco_multi_add_new_peer(const =
struct multi_context *m, struct multi_instance *mi)</span><br><span> {</spa=
n><br><span>     return 0;</span><br><span> }</span><br><span>@@ -384,7 +38=
4,7 @@</span><br><span> }</span><br><span> </span><br><span> static inline =
bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoc=
h_data(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+dco_supports_epoch_data(const struct context *c)</span><br><span> {</=
span><br><span>     return false;</span><br><span> }</span><br><span>diff -=
-git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br>=
<span>index 87eea55=2E=2E3148f10 100644</span><br><span>--- a/src/openvpn/d=
co_freebsd=2Ec</span><br><span>+++ b/src/openvpn/dco_freebsd=2Ec</span><br>=
<span>@@ -929,7 +929,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports=
_epoch_data(struct context *c)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+dco_supports_epoch_data(const struct context *c)</span><br><span=
> {</span><br><span>     return false;</span><br><span> }</span><br><span>d=
iff --git a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_internal=2Eh</sp=
an><br><span>index fcf8aca=2E=2E1022e66 100644</span><br><span>--- a/src/op=
envpn/dco_internal=2Eh</span><br><span>+++ b/src/openvpn/dco_internal=2Eh</=
span><br><span>@@ -59,8 +59,9 @@</span><br><span>  * They are implemented b=
y dco_linux=2Ec</span><br><span>  */</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-int dco_new_peer(dco_context_t *dco, unsig=
ned int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                 struct socka=
ddr *remoteaddr, const struct in_addr *vpn_ipv4, const struct in6_addr *vpn=
_ipv6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_new_=
peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                 struct s=
ockaddr *localaddr, struct sockaddr *remoteaddr,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                 const struct in_addr *vpn_ipv=
4, const struct in6_addr *vpn_ipv6);</span><br><span> </span><br><span> int=
 dco_del_peer(dco_context_t *dco, unsigned int peerid);</span><br><span> </=
span><br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_lin=
ux=2Ec</span><br><span>index a397fb8=2E=2E4412ad0 100644</span><br><span>--=
- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=
=2Ec</span><br><span>@@ -104,7 +104,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static struct nl_msg *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_nlmsg_crea=
te(const dco_context_t *dco, uint8_t cmd)</span><br><span> {</span><br><spa=
n>     struct nl_msg *nl_msg =3D nlmsg_alloc();</span><br><span>     if (!n=
l_msg)</span><br><span>@@ -842,7 +842,7 @@</span><br><span> </span><br><spa=
n> /* libnl &lt; 3=2E11=2E0 does not implement nla_get_uint() */</span><br>=
<span> static uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-ovpn_nla_get_uint(struct nlattr *attr)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ovpn_nla_get_uint(const struct nlattr *attr)</span><br>=
<span> {</span><br><span>     if (nla_len(attr) =3D=3D sizeof(uint32_t))</s=
pan><br><span>     {</span><br><span>@@ -954,7 +954,7 @@</span><br><span> }=
</span><br><span> </span><br><span> static bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-ovpn_iface_check(dco_context_t *dco, struct nlatt=
r *attrs[])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_ifa=
ce_check(const dco_context_t *dco, struct nlattr *attrs[])</span><br><span>=
 {</span><br><span>     /* we must know which interface this message is ref=
erring to in order to</span><br><span>      * avoid mixing messages for oth=
er instances</span><br><span>@@ -1381,7 +1381,7 @@</span><br><span> }</span=
><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-dco_supports_epoch_data(struct context *c)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct co=
ntext *c)</span><br><span> {</span><br><span>     return false;</span><br><=
span> }</span><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/=
dco_win=2Ec</span><br><span>index 6e5e295=2E=2E12b0666 100644</span><br><sp=
an>--- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=
=2Ec</span><br><span>@@ -1092,7 +1092,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-dco_supports_epoch_data(struct context *c)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct context *c=
)</span><br><span> {</span><br><span>     OVPN_VERSION ver =3D { 0 };</span=
><br><span>     return dco_get_version(&amp;ver) &amp;&amp; ((ver=2EMajor =
=3D=3D 2 &amp;&amp; ver=2EMinor &gt;=3D 8) || (ver=2EMajor &gt; 2));</span>=
<br><span>diff --git a/src/openvpn/error=2Ec b/src/openvpn/error=2Ec</span>=
<br><span>index 26d4c7c=2E=2E32d819d 100644</span><br><span>--- a/src/openv=
pn/error=2Ec</span><br><span>+++ b/src/openvpn/error=2Ec</span><br><span>@@=
 -623,7 +623,7 @@</span><br><span>  * from the OS=2E</span><br><span>  */</=
span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-x=
_check_status(ssize_t status, const char *description, struct link_socket *=
sock, struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+x_check_status(ssize_t status, const char *description, struct link_so=
cket *sock, const struct tuntap *tt)</span><br><span> {</span><br><span>   =
  const char *extended_msg =3D NULL;</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh</span><br><span>inde=
x 9f39572=2E=2E373cbc1 100644</span><br><span>--- a/src/openvpn/error=2Eh</=
span><br><span>+++ b/src/openvpn/error=2Eh</span><br><span>@@ -304,10 +304,=
10 @@</span><br><span> void set_check_status(unsigned int info_level, unsig=
ned int verbose_level);</span><br><span> </span><br><span> void x_check_sta=
tus(ssize_t status, const char *description, struct link_socket *sock,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    struct=
 tuntap *tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              const struct tuntap *tt);</span><br><span> </span><br><span> =
static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-che=
ck_status(ssize_t status, const char *description, struct link_socket *sock=
, struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+check_status(ssize_t status, const char *description, struct link_socket *=
sock, const struct tuntap *tt)</span><br><span> {</span><br><span>     if (=
status &lt; 0 || check_debug_level(x_cs_verbose_level))</span><br><span>   =
  {</span><br><span>diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=
=2Ec</span><br><span>index 4089401=2E=2E5e17ea1 100644</span><br><span>--- =
a/src/openvpn/event=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec</span><=
br><span>@@ -1012,7 +1012,7 @@</span><br><span> }</span><br><span> </span><=
br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
e_wait_return(struct se_set *ses, fd_set *read, fd_set *write, struct event=
_set_return *out,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+se=
_wait_return(struct se_set *ses, const fd_set *read, const fd_set *write, s=
truct event_set_return *out,</span><br><span>                int outlen)</s=
pan><br><span> {</span><br><span>     int i, j =3D 0;</span><br><span>diff =
--git a/src/openvpn/event=2Eh b/src/openvpn/event=2Eh</span><br><span>index=
 b784dfe=2E=2E0940a1d 100644</span><br><span>--- a/src/openvpn/event=2Eh</s=
pan><br><span>+++ b/src/openvpn/event=2Eh</span><br><span>@@ -204,7 +204,7 =
@@</span><br><span> #else /* ifdef _WIN32 */</span><br><span> </span><br><s=
pan> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-wait_signal(struct event_set *es, void *arg)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+wait_signal(const struct event_set *es, const vo=
id *arg)</span><br><span> {</span><br><span> }</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span>=
<br><span>index b97fb7a=2E=2E681210d 100644</span><br><span>--- a/src/openv=
pn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><spa=
n>@@ -237,7 +237,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-parse_inc=
oming_control_channel_command(struct context *c, struct buffer *buf)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+parse_incoming_control_cha=
nnel_command(struct context *c, const struct buffer *buf)</span><br><span> =
{</span><br><span>     if (buf_string_match_head_str(buf, &quot;AUTH_FAILED=
&quot;))</span><br><span>     {</span><br><span>@@ -507,7 +507,7 @@</span><=
br><span> }</span><br><span> </span><br><span> int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-get_server_poll_remaining_time(struct event_ti=
meout *server_poll_timeout)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+get_server_poll_remaining_time(const struct event_timeout *server_p=
oll_timeout)</span><br><span> {</span><br><span>     update_time();</span><=
br><span>     int remaining =3D event_timeout_remaining(server_poll_timeout=
);</span><br><span>@@ -621,7 +621,7 @@</span><br><span>  * Buffer reallocat=
ion, for use with null encryption=2E</span><br><span>  */</span><br><span> =
static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf=
fer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub, struct buff=
er *src_stub,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buffer=
_turnover(const uint8_t *orig_buf, struct buffer *dest_stub, const struct b=
uffer *src_stub,</span><br><span>                 struct buffer *storage)</=
span><br><span> {</span><br><span>     if (orig_buf =3D=3D src_stub-&gt;dat=
a &amp;&amp; src_stub-&gt;data !=3D storage-&gt;data)</span><br><span>@@ -9=
08,7 +908,7 @@</span><br><span>  */</span><br><span> </span><br><span> stat=
ic inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socks_p=
ostprocess_incoming_link(struct context *c, struct link_socket *sock)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+socks_postprocess_incomin=
g_link(struct context *c, const struct link_socket *sock)</span><br><span> =
{</span><br><span>     if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;info=2E=
proto =3D=3D PROTO_UDP)</span><br><span>     {</span><br><span>@@ -1005,7 +=
1005,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-process_incoming_link_part1(=
struct context *c, struct link_socket_info *lsi, bool floated)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+process_incoming_link_part1(stru=
ct context *c, const struct link_socket_info *lsi, bool floated)</span><br>=
<span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><s=
pan>     bool decrypt_status =3D false;</span><br><span>@@ -1555,7 +1555,7 =
@@</span><br><span>  * @param client    Determines whether to the send pack=
et back via tun or link</span><br><span>  */</span><br><span> void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-ipv6_send_icmp_unreachable(str=
uct context *c, struct buffer *buf, bool client)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ipv6_send_icmp_unreachable(struct context *c, =
const struct buffer *buf, bool client)</span><br><span> {</span><br><span> =
#define MAX_ICMPV6LEN 1280</span><br><span>     struct openvpn_icmp6hdr icm=
p6out;</span><br><span>diff --git a/src/openvpn/forward=2Eh b/src/openvpn/f=
orward=2Eh</span><br><span>index 0309725=2E=2E375635b 100644</span><br><spa=
n>--- a/src/openvpn/forward=2Eh</span><br><span>+++ b/src/openvpn/forward=
=2Eh</span><br><span>@@ -126,7 +126,7 @@</span><br><span>  */</span><br><sp=
an> void encrypt_sign(struct context *c, bool comp_frag);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int get_server_poll_r=
emaining_time(struct event_timeout *server_poll_timeout);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+int get_server_poll_remaining_time(co=
nst struct event_timeout *server_poll_timeout);</span><br><span> </span><br=
><span> /******************************************************************=
****/</span><br><span> /**</span><br><span>@@ -177,7 +177,7 @@</span><br><s=
pan>  *</span><br><span>  * @return true if packet is authenticated, false =
otherwise=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-bool process_incoming_link_part1(struct context *c, struct link=
_socket_info *lsi, bool floated);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool process_incoming_link_part1(struct context *c, const str=
uct link_socket_info *lsi, bool floated);</span><br><span> </span><br><span=
> /**</span><br><span>  * Continues processing a packet read from the exter=
nal network interface=2E</span><br><span>diff --git a/src/openvpn/init=2Ec =
b/src/openvpn/init=2Ec</span><br><span>index 9306a96=2E=2E3c2ebf9 100644</s=
pan><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/=
init=2Ec</span><br><span>@@ -803,7 +803,7 @@</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-init_port_share(struct context *c)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+init_port_share(const struct context *c)</span=
><br><span> {</span><br><span>     if (!port_share &amp;&amp; (c-&gt;option=
s=2Eport_share_host &amp;&amp; c-&gt;options=2Eport_share_port))</span><br>=
<span>     {</span><br><span>@@ -1245,7 +1245,7 @@</span><br><span>  * prep=
ending to msg() output=2E</span><br><span>  */</span><br><span> const char =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-format_common_name(s=
truct context *c, struct gc_arena *gc)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+format_common_name(const struct context *c, struct gc_ar=
ena *gc)</span><br><span> {</span><br><span>     struct buffer out =3D allo=
c_buf_gc(256, gc);</span><br><span>     if (c-&gt;c2=2Etls_multi)</span><br=
><span>@@ -1731,7 +1731,7 @@</span><br><span> </span><br><span> </span><br>=
<span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-can=
_preserve_tun(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+can_preserve_tun(const struct tuntap *tt)</span><br><span> {</=
span><br><span>     if (tt &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_A=
FUNIX)</span><br><span>     {</span><br><span>@@ -1753,7 +1753,7 @@</span><=
br><span>  * @param c pointer to the connection context</span><br><span>  *=
/</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-add_wfp_block(struct context *c)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+add_wfp_block(const struct context *c)</span><br><spa=
n> {</span><br><span> #if defined(_WIN32)</span><br><span>     /* Fortify &=
#39;redirect-gateway block-local&#39; with firewall rules? */</span><br><sp=
an>@@ -1779,7 +1779,7 @@</span><br><span>  * @param adapter_index the VPN a=
dapter index</span><br><span>  */</span><br><span> static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-del_wfp_block(struct context *c, u=
nsigned long adapter_index)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+del_wfp_block(const struct context *c, unsigned long adapter_index)=
</span><br><span> {</span><br><span> #if defined(_WIN32)</span><br><span>  =
   if (c-&gt;options=2Eblock_outside_dns || block_local_needed(c-&gt;c1=2Er=
oute_list))</span><br><span>diff --git a/src/openvpn/init=2Eh b/src/openvpn=
/init=2Eh</span><br><span>index ce8f74e=2E=2Ec486158 100644</span><br><span=
>--- a/src/openvpn/init=2Eh</span><br><span>+++ b/src/openvpn/init=2Eh</spa=
n><br><span>@@ -91,7 +91,7 @@</span><br><span> </span><br><span> uint64_t p=
ull_permission_mask(const struct context *c);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-const char *format_common_name(st=
ruct context *c, struct gc_arena *gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+const char *format_common_name(const struct context *c, =
struct gc_arena *gc);</span><br><span> </span><br><span> void reset_coarse_=
timers(struct context *c);</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/interval=2Eh b/src/openvpn/interval=2Eh</span><br><span>index 59=
051bd=2E=2E0cfe202 100644</span><br><span>--- a/src/openvpn/interval=2Eh</s=
pan><br><span>+++ b/src/openvpn/interval=2Eh</span><br><span>@@ -89,7 +89,7=
 @@</span><br><span> }</span><br><span> </span><br><span> static inline voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-interval_schedule_wa=
keup(struct interval *top, interval_t *wakeup)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+interval_schedule_wakeup(const struct interval *=
top, interval_t *wakeup)</span><br><span> {</span><br><span>     const time=
_t local_now =3D now;</span><br><span>     interval_earliest_wakeup(wakeup,=
 top-&gt;last_test_true + top-&gt;refresh, local_now);</span><br><span>@@ -=
214,7 +214,7 @@</span><br><span>  * This function does not check if the tim=
eout is actually valid=2E</span><br><span>  */</span><br><span> static inli=
ne interval_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-event_ti=
meout_remaining(struct event_timeout *et)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+event_timeout_remaining(const struct event_timeout *e=
t)</span><br><span> {</span><br><span>     return (interval_t)((et-&gt;last=
 + et-&gt;n) - now);</span><br><span> }</span><br><span>diff --git a/src/op=
envpn/list=2Ec b/src/openvpn/list=2Ec</span><br><span>index e51dcd0=2E=2Edc=
d59d7 100644</span><br><span>--- a/src/openvpn/list=2Ec</span><br><span>+++=
 b/src/openvpn/list=2Ec</span><br><span>@@ -164,7 +164,7 @@</span><br><span=
> }</span><br><span> </span><br><span> void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-hash_remove_by_value(struct hash *hash, void *value)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_remove_by_value=
(struct hash *hash, const void *value)</span><br><span> {</span><br><span> =
    struct hash_iterator hi;</span><br><span>     const struct hash_element=
 *he;</span><br><span>diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=
=2Eh</span><br><span>index 55bc3c8=2E=2E23267d0 100644</span><br><span>--- =
a/src/openvpn/list=2Eh</span><br><span>+++ b/src/openvpn/list=2Eh</span><br=
><span>@@ -78,7 +78,7 @@</span><br><span> </span><br><span> bool hash_remov=
e_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uint=
64_t hv);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void hash_remove_by_value(struct hash *hash, void *value);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void hash_remove_by_value(stru=
ct hash *hash, const void *value);</span><br><span> </span><br><span> struc=
t hash_iterator</span><br><span> {</span><br><span>diff --git a/src/openvpn=
/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 0aef2d4=2E=2E1e7=
4f09 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>++=
+ b/src/openvpn/manage=2Ec</span><br><span>@@ -330,7 +330,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-man_delete_unix_socket(struct management *m=
an)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_delete_unix_=
socket(const struct management *man)</span><br><span> {</span><br><span> #i=
f UNIX_SOCK_SUPPORT</span><br><span>     if ((man-&gt;settings=2Eflags &amp=
; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><sp=
an>@@ -676,7 +676,7 @@</span><br><span>  * for the log and echo commands=2E=
</span><br><span>  */</span><br><span> static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-man_history(struct management *man, const char=
 *parm, const char *type, struct log_history *log,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+man_history(struct management *man, const ch=
ar *parm, const char *type, const struct log_history *log,</span><br><span>=
             bool *realtime, const unsigned int lep_flags)</span><br><span>=
 {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>@@=
 -852,7 +852,7 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_net(struc=
t management *man)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
an_net(const struct management *man)</span><br><span> {</span><br><span>   =
  if (man-&gt;persist=2Ecallback=2Eshow_net)</span><br><span>     {</span><=
br><span>@@ -888,7 +888,7 @@</span><br><span> #ifdef ENABLE_PKCS11</span><b=
r><span> </span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-man_pkcs11_id_count(struct management *man)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+man_pkcs11_id_count(const struct m=
anagement *man)</span><br><span> {</span><br><span>     msg(M_CLIENT, &quot=
;&gt;PKCS11ID-COUNT:%d&quot;, pkcs11_management_id_count());</span><br><spa=
n> }</span><br><span>@@ -2366,7 +2366,7 @@</span><br><span>  * the route/if=
config/open tun command=2E   See doc/android=2Etxt for details=2E</span><br=
><span>  */</span><br><span> bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-management_android_control(struct management *man, const char *=
command, const char *msg)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+management_android_control(const struct management *man, const char *=
command, const char *msg)</span><br><span> {</span><br><span>     if (!man)=
</span><br><span>     {</span><br><span>@@ -3013,7 +3013,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-management_up_down(struct management *man, const ch=
ar *updown, const struct env_set *es)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+management_up_down(const struct management *man, const ch=
ar *updown, const struct env_set *es)</span><br><span> {</span><br><span>  =
   if (man-&gt;settings=2Eflags &amp; MF_UP_DOWN)</span><br><span>     {</s=
pan><br><span>@@ -3208,7 +3208,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ma=
nagement_auth_failure(struct management *man, const char *type, const char =
*reason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_=
auth_failure(const struct management *man, const char *type, const char *re=
ason)</span><br><span> {</span><br><span>     if (reason)</span><br><span> =
    {</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/man=
age=2Eh</span><br><span>index 1e7855d=2E=2Ef2c6916 100644</span><br><span>-=
-- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</s=
pan><br><span>@@ -368,7 +368,7 @@</span><br><span>                         =
        const unsigned int flags, const char *static_challenge);</span><br>=
<span> </span><br><span> #ifdef TARGET_ANDROID</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-bool management_android_control(struct management =
*man, const char *command, const char *msg);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool management_android_control(const struct manag=
ement *man, const char *command, const char *msg);</span><br><span> </span>=
<br><span> #define ANDROID_KEEP_OLD_TUN      1</span><br><span> #define AND=
ROID_OPEN_BEFORE_CLOSE 2</span><br><span>@@ -382,7 +382,7 @@</span><br><spa=
n> </span><br><span> void management_event_loop_n_seconds(struct management=
 *man, int sec);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void management_up_down(struct management *man, const char *up=
down, const struct env_set *es);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+void management_up_down(const struct management *man, const ch=
ar *updown, const struct env_set *es);</span><br><span> </span><br><span> v=
oid management_notify(const char *severity, const char *type,</span><br><sp=
an>                        const char *text);</span><br><span>@@ -482,7 +48=
2,7 @@</span><br><span>  * OpenVPN calls here to indicate a password failur=
e</span><br><span>  */</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void management_auth_failure(struct management *man, con=
st char *type, const char *reason);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void management_auth_failure(const struct management *man, =
const char *type, const char *reason);</span><br><span> </span><br><span> /=
*</span><br><span>  * Echo an authentication token to management interface<=
/span><br><span>diff --git a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec</s=
pan><br><span>index 5bb397f=2E=2E163251c 100644</span><br><span>--- a/src/o=
penvpn/mbuf=2Ec</span><br><span>+++ b/src/openvpn/mbuf=2Ec</span><br><span>=
@@ -165,7 +165,7 @@</span><br><span> }</span><br><span> </span><br><span> v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbuf_dereference_i=
nstance(struct mbuf_set *ms, struct multi_instance *mi)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+mbuf_dereference_instance(struct mbuf_s=
et *ms, const struct multi_instance *mi)</span><br><span> {</span><br><span=
>     if (ms)</span><br><span>     {</span><br><span>diff --git a/src/openv=
pn/mbuf=2Eh b/src/openvpn/mbuf=2Eh</span><br><span>index cfe698c=2E=2Ee3680=
54 100644</span><br><span>--- a/src/openvpn/mbuf=2Eh</span><br><span>+++ b/=
src/openvpn/mbuf=2Eh</span><br><span>@@ -75,7 +75,7 @@</span><br><span> </s=
pan><br><span> bool mbuf_extract_item(struct mbuf_set *ms, struct mbuf_item=
 *item);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void mbuf_dereference_instance(struct mbuf_set *ms, struct multi_insta=
nce *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void mbuf_=
dereference_instance(struct mbuf_set *ms, const struct multi_instance *mi);=
</span><br><span> </span><br><span> static inline bool</span><br><span> mbu=
f_defined(const struct mbuf_set *ms)</span><br><span>diff --git a/src/openv=
pn/mss=2Ec b/src/openvpn/mss=2Ec</span><br><span>index 36bbb43=2E=2E0cfa272=
d 100644</span><br><span>--- a/src/openvpn/mss=2Ec</span><br><span>+++ b/sr=
c/openvpn/mss=2Ec</span><br><span>@@ -239,8 +239,8 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-frame_calculate_fragment(struct frame *frame, struct=
 key_type *kt, const struct options *options,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                         struct link_socket_info *l=
si)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+frame_calculate_=
fragment(struct frame *frame, const struct key_type *kt, const struct optio=
ns *options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                  const struct link_socket_info *lsi)</span><br><span> {</s=
pan><br><span> #if defined(ENABLE_FRAGMENT)</span><br><span>     size_t ove=
rhead;</span><br><span>@@ -269,8 +269,8 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-frame_calculate_mssfix(struct frame *frame, struct key_type *kt=
, const struct options *options,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                       struct link_socket_info *lsi)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+frame_calculate_mssfix(struct f=
rame *frame, const struct key_type *kt, const struct options *options,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                       c=
onst struct link_socket_info *lsi)</span><br><span> {</span><br><span>     =
if (options-&gt;ce=2Emssfix_fixed)</span><br><span>     {</span><br><span>@=
@ -314,8 +314,8 @@</span><br><span> }</span><br><span> </span><br><span> vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-frame_calculate_dyn=
amic(struct frame *frame, struct key_type *kt, const struct options *option=
s,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
     struct link_socket_info *lsi)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+frame_calculate_dynamic(struct frame *frame, const struct ke=
y_type *kt, const struct options *options,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        const struct link_socket_inf=
o *lsi)</span><br><span> {</span><br><span>     if (options-&gt;ce=2Efragme=
nt &gt; 0)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/=
mss=2Eh b/src/openvpn/mss=2Eh</span><br><span>index 1d092bb=2E=2E2eab55a 10=
0644</span><br><span>--- a/src/openvpn/mss=2Eh</span><br><span>+++ b/src/op=
envpn/mss=2Eh</span><br><span>@@ -36,8 +36,8 @@</span><br><span> void mss_f=
ixup_dowork(struct buffer *buf, uint16_t maxmss);</span><br><span> </span><=
br><span> /** Set the --mssfix option=2E */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void frame_calculate_dynamic(struct frame *frame, str=
uct key_type *kt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                         const struct options *options, struct link_socket_=
info *lsi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void fra=
me_calculate_dynamic(struct frame *frame, const struct key_type *kt,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
   const struct options *options, const struct link_socket_info *lsi);</spa=
n><br><span> </span><br><span> /**</span><br><span>  * Checks and adjusts t=
he fragment and mssfix value according to the</span><br><span>diff --git a/=
src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index 4d173c4=
=2E=2Ec744638 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><=
span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -67,7 +67,7 @@</span><br=
><span> }</span><br><span> </span><br><span> bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-multi_tcp_instance_specific_init(struct multi_c=
ontext *m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+multi_tcp_instance_specific_init(const struct multi_conte=
xt *m, struct multi_instance *mi)</span><br><span> {</span><br><span>     /=
* buffer for queued TCP socket output packets */</span><br><span>     mi-&g=
t;tcp_link_out_deferred =3D mbuf_init(m-&gt;top=2Eoptions=2En_bcast_buf);</=
span><br><span>diff --git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh</sp=
an><br><span>index 9b7d1d2=2E=2Ebb117fa 100644</span><br><span>--- a/src/op=
envpn/mtcp=2Eh</span><br><span>+++ b/src/openvpn/mtcp=2Eh</span><br><span>@=
@ -35,7 +35,7 @@</span><br><span> </span><br><span> void multi_tcp_derefere=
nce_instance(struct multi_io *multi_io, struct multi_instance *mi);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool multi_=
tcp_instance_specific_init(struct multi_context *m, struct multi_instance *=
mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool multi_tcp_=
instance_specific_init(const struct multi_context *m, struct multi_instance=
 *mi);</span><br><span> </span><br><span> void multi_tcp_instance_specific_=
free(struct multi_instance *mi);</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 69e3=
0e5=2E=2E201d756 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><b=
r><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -54,8 +54,9 @@</span>=
<br><span>  * @param sock    the socket to send the reply on</span><br><spa=
n>  */</span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-send_standalone_reply(struct multi_context *m, struct buffer =
*buf, const char *prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                      const char *detail, struct link_socket *sock)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+send_standalone_reply(s=
truct multi_context *m, const struct buffer *buf,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                      const char *prefix, con=
st char *detail,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                   struct link_socket *sock)</span><br><span> {</span><br><=
span>     struct context *c =3D &amp;m-&gt;top;</span><br><span> </span><br=
><span>@@ -75,7 +76,7 @@</span><br><span> </span><br><span> static void</sp=
an><br><span> send_hmac_reset_packet(struct multi_context *m, struct tls_pr=
e_decrypt_state *state,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                       struct tls_auth_standalone *tas, struct session_id=
 *sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
          const struct tls_auth_standalone *tas, const struct session_id *s=
id,</span><br><span>                        bool request_resend_wkc, struct=
 link_socket *sock)</span><br><span> {</span><br><span>     reset_packet_id=
_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);</span><br><spa=
n>@@ -117,11 +118,11 @@</span><br><span> </span><br><span>     enum first_p=
acket_verdict verdict;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct tls_auth_standalone *tas =3D m-&gt;top=2Ec2=
=2Etls_auth_standalone;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const struct tls_auth_standalone *tas =3D m-&gt;top=2Ec2=2Etls_auth=
_standalone;</span><br><span> </span><br><span>     verdict =3D tls_pre_dec=
rypt_lite(tas, state, &amp;m-&gt;top=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2Ebuf=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   uint8_t *hmac_key =3D m-&gt;top=2Ec2=2Esession_id_key;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *hmac_key =3D m-&gt=
;top=2Ec2=2Esession_id_key;</span><br><span>     const struct openvpn_socka=
ddr *from =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</span><br><span>     int h=
andwindow =3D m-&gt;top=2Eoptions=2Ehandshake_window;</span><br><span> </sp=
an><br><span>@@ -240,7 +241,7 @@</span><br><span> static struct multi_insta=
nce *</span><br><span> handle_connection_attempt(struct multi_context *m,</=
span><br><span>                           struct link_socket *sock,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                          str=
uct mroute_addr *real)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                          const struct mroute_addr *real)</span><br><spa=
n> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>=
 </span><br><span>@@ -308,7 +309,7 @@</span><br><span>  * @return      inst=
ance matching the address, NULL otherwise</span><br><span>  */</span><br><s=
pan> static struct multi_instance *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-multi_get_instance_udp_real(struct multi_context *m, struct m=
route_addr *real)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mu=
lti_get_instance_udp_real(struct multi_context *m, const struct mroute_addr=
 *real)</span><br><span> {</span><br><span>     struct hash *hash =3D m-&gt=
;hash;</span><br><span>     const uint64_t hv =3D hash_value(hash, real);</=
span><br><span>@@ -353,7 +354,9 @@</span><br><span>  * maintaining real add=
ress hash table atomicity=2E</span><br><span>  */</span><br><span> struct m=
ulti_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_=
get_instance_udp_data(struct multi_context *m, bool *floated, struct mroute=
_addr *real, struct link_socket *sock)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+multi_get_instance_udp_data(struct multi_context *m, boo=
l *floated,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                    const struct mroute_addr *real,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            const struct =
link_socket *sock)</span><br><span> {</span><br><span>     struct multi_ins=
tance *mi =3D NULL;</span><br><span> </span><br><span>diff --git a/src/open=
vpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index dda9232=2E=2Ea2=
cfdbf 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>++=
+ b/src/openvpn/multi=2Ec</span><br><span>@@ -58,7 +58,7 @@</span><br><span=
> </span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span> static c=
onst char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-id(struct =
multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
id(const struct multi_instance *mi)</span><br><span> {</span><br><span>    =
 if (mi)</span><br><span>     {</span><br><span>@@ -1336,7 +1336,7 @@</span=
><br><span>  * same common name=2E</span><br><span>  */</span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_delete=
_dup(struct multi_context *m, struct multi_instance *new_mi)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+multi_delete_dup(struct multi_cont=
ext *m, const struct multi_instance *new_mi)</span><br><span> {</span><br><=
span>     if (new_mi)</span><br><span>     {</span><br><span>@@ -2281,7 +22=
81,7 @@</span><br><span> }</span><br><span> </span><br><span> static bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_client_setup_dco_=
initial(struct multi_context *m, struct multi_instance *mi,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+multi_client_setup_dco_initial(cons=
t struct multi_context *m, struct multi_instance *mi,</span><br><span>     =
                           struct gc_arena *gc)</span><br><span> {</span><b=
r><span>     if (!dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><sp=
an>@@ -2479,7 +2479,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_=
check_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi,=
 struct mroute_addr *real);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+multi_check_dest_addr_allowed(struct multi_context *m, struct multi=
_instance *mi, const struct mroute_addr *real);</span><br><span> </span><br=
><span> /**</span><br><span>  * This sets up the client real address (outer=
 tunnel addr) in the</span><br><span>@@ -3130,7 +3130,8 @@</span><br><span>=
  * positive=2E</span><br><span>  */</span><br><span> static bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-multi_check_dest_addr_allowed(s=
truct multi_context *m, struct multi_instance *mi, struct mroute_addr *real=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_dest_a=
ddr_allowed(struct multi_context *m, struct multi_instance *mi,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                              c=
onst struct mroute_addr *real)</span><br><span> {</span><br><span>     stru=
ct hash *hash =3D m-&gt;hash;</span><br><span>     const uint64_t hv =3D ha=
sh_value(hash, real);</span><br><span>@@ -3289,7 +3290,7 @@</span><br><span=
> </span><br><span> #if defined(ENABLE_DCO)</span><br><span> static void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-process_incoming_del_pee=
r(struct multi_context *m, struct multi_instance *mi, dco_context_t *dco)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+process_incoming_del_=
peer(struct multi_context *m, struct multi_instance *mi, const dco_context_=
t *dco)</span><br><span> {</span><br><span>     const char *reason =3D &quo=
t;ovpn-dco: unknown reason&quot;;</span><br><span>     switch (dco-&gt;dco_=
del_peer_reason)</span><br><span>@@ -4342,7 +4343,7 @@</span><br><span> </s=
pan><br><span> /* Searches for the address and deletes it if it is owned by=
 the multi_instance */</span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-multi_unlearn_addr(struct multi_context *m,=
 struct multi_instance *mi, const struct mroute_addr *addr)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+multi_unlearn_addr(struct multi_con=
text *m, const struct multi_instance *mi, const struct mroute_addr *addr)</=
span><br><span> {</span><br><span>     struct hash_element *he;</span><br><=
span>     const uint64_t hv =3D hash_value(m-&gt;vhash, addr);</span><br><s=
pan>@@ -4377,7 +4378,7 @@</span><br><span>  * @param a     The new IPv4 add=
ress in network byte order</span><br><span>  */</span><br><span> static voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_unlearn_in_add=
r_t(struct multi_context *m, struct multi_instance *mi, in_addr_t a)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+multi_unlearn_in_addr_t(st=
ruct multi_context *m, const struct multi_instance *mi, in_addr_t a)</span>=
<br><span> {</span><br><span>     struct mroute_addr addr;</span><br><span>=
     CLEAR(addr);</span><br><span>@@ -4395,7 +4396,7 @@</span><br><span>  *=
 @param a6    The new IPv6 address</span><br><span>  */</span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_unlear=
n_in6_addr(struct multi_context *m, struct multi_instance *mi, struct in6_a=
ddr a6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_unlear=
n_in6_addr(struct multi_context *m, const struct multi_instance *mi, struct=
 in6_addr a6)</span><br><span> {</span><br><span>     struct mroute_addr ad=
dr;</span><br><span>     CLEAR(addr);</span><br><span>diff --git a/src/open=
vpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index c424ad3=2E=2E5d=
b7147 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>++=
+ b/src/openvpn/multi=2Eh</span><br><span>@@ -529,7 +529,7 @@</span><br><sp=
an>  */</span><br><span> </span><br><span> static inline void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-set_prefix(struct multi_instance *m=
i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set_prefix(const =
struct multi_instance *mi)</span><br><span> {</span><br><span> #ifdef MULTI=
_DEBUG_EVENT_LOOP</span><br><span>     if (mi-&gt;msg_prefix[0])</span><br>=
<span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</spa=
n><br><span>index 348e424=2E=2Ebb5dde58 100644</span><br><span>--- a/src/op=
envpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br=
><span>@@ -159,7 +159,7 @@</span><br><span>  * a point-to-multipoint tunnel=
=2E</span><br><span>  */</span><br><span> static unsigned int</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-p2mp_iow_flags(const struct multi_c=
ontext *m, struct link_socket *sock)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+p2mp_iow_flags(const struct multi_context *m, const struct=
 link_socket *sock)</span><br><span> {</span><br><span>     unsigned int fl=
ags =3D IOW_WAIT_SIGNAL;</span><br><span> </span><br><span>diff --git a/src=
/openvpn/networking=2Eh b/src/openvpn/networking=2Eh</span><br><span>index =
bce0c19=2E=2E25233c8 100644</span><br><span>--- a/src/openvpn/networking=2E=
h</span><br><span>+++ b/src/openvpn/networking=2Eh</span><br><span>@@ -44,7=
 +44,7 @@</span><br><span>  */</span><br><span> #if !defined(ENABLE_IPROUTE=
)</span><br><span> static inline int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+net_ctx_init(const struc=
t context *c, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>  =
   (void)c;</span><br><span>     (void)ctx;</span><br><span>@@ -75,7 +75,7 =
@@</span><br><span>  *</span><br><span>  * @return          0 on success, a=
 negative error code otherwise</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int net_ctx_init(struct context *c, openvpn=
_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
t net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx);</span><br>=
<span> </span><br><span> /**</span><br><span>  * Release resources allocate=
d by the internal garbage collector</span><br><span>@@ -102,7 +102,7 @@</sp=
an><br><span>  * @return          0 on success, negative error code on erro=
r</span><br><span>  */</span><br><span> int net_iface_new(openvpn_net_ctx_t=
 *ctx, const openvpn_net_iface_t *iface, const char *type,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                  void *arg);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                  const void=
 *arg);</span><br><span> </span><br><span> /**</span><br><span>  * Retrieve=
 the interface type</span><br><span>diff --git a/src/openvpn/networking_ipr=
oute2=2Ec b/src/openvpn/networking_iproute2=2Ec</span><br><span>index a1f35=
25=2E=2Ef091fb3 100644</span><br><span>--- a/src/openvpn/networking_iproute=
2=2Ec</span><br><span>+++ b/src/openvpn/networking_iproute2=2Ec</span><br><=
span>@@ -36,7 +36,7 @@</span><br><span> #include &lt;netinet/in=2Eh&gt;</sp=
an><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+net_ctx_init(const struct=
 context *c, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>   =
  ctx-&gt;es =3D NULL;</span><br><span>     if (c)</span><br><span>@@ -61,7=
 +61,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_new(openvpn_net_ctx=
_t *ctx, const char *iface, const char *type, void *arg)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+net_iface_new(openvpn_net_ctx_t *ctx, =
const char *iface, const char *type, const void *arg)</span><br><span> {</s=
pan><br><span>     struct argv argv =3D argv_new();</span><br><span> </span=
><br><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/netw=
orking_sitnl=2Ec</span><br><span>index 83915db=2E=2E49de664 100644</span><b=
r><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/op=
envpn/networking_sitnl=2Ec</span><br><span>@@ -1007,7 +1007,7 @@</span><br>=
<span> }</span><br><span> </span><br><span> static int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_del(sa_family_t af_family, cons=
t char *iface, inet_address_t *addr, int prefixlen)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_del(sa_family_t af_family, con=
st char *iface, const inet_address_t *addr, int prefixlen)</span><br><span>=
 {</span><br><span>     int ifindex;</span><br><span> </span><br><span>@@ -=
1250,8 +1250,8 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_de=
l(const char *iface, sa_family_t af_family, inet_address_t *dst, int prefix=
len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                i=
net_address_t *gw, uint32_t table, int metric)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+sitnl_route_del(const char *iface, sa_family_t a=
f_family, const inet_address_t *dst, int prefixlen,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                const inet_address_t *gw,=
 uint32_t table, int metric)</span><br><span> {</span><br><span>     int if=
index =3D 0;</span><br><span> </span><br><span>@@ -1328,7 +1328,7 @@</span>=
<br><span> </span><br><span> </span><br><span> int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-net_iface_new(openvpn_net_ctx_t *ctx, const ch=
ar *iface, const char *type, void *arg)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface=
, const char *type, const void *arg)</span><br><span> {</span><br><span>   =
  struct sitnl_link_req req =3D {};</span><br><span>     int ret =3D -1;</s=
pan><br><span>diff --git a/src/openvpn/occ=2Eh b/src/openvpn/occ=2Eh</span>=
<br><span>index bda4f18=2E=2E49def4d 100644</span><br><span>--- a/src/openv=
pn/occ=2Eh</span><br><span>+++ b/src/openvpn/occ=2Eh</span><br><span>@@ -15=
6,7 +156,7 @@</span><br><span>  * via control channel=2E</span><br><span>  =
* @return control channel exit message should be used */</span><br><span> s=
tatic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cc_e=
xit_notify_enabled(struct context *c)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+cc_exit_notify_enabled(const struct context *c)</span><br=
><span> {</span><br><span>     /* Check if we have TLS active at all */</sp=
an><br><span>     if (!c-&gt;c2=2Etls_multi)</span><br><span>diff --git a/s=
rc/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh</span><br><s=
pan>index 098bdd5=2E=2E1a934db 100644</span><br><span>--- a/src/openvpn/ope=
nssl_compat=2Eh</span><br><span>+++ b/src/openvpn/openssl_compat=2Eh</span>=
<br><span>@@ -127,7 +127,7 @@</span><br><span> /* Mimics the functions but =
only when the default context without</span><br><span>  * options is chosen=
 */</span><br><span> static inline const EVP_CIPHER *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-EVP_CIPHER_fetch(void *ctx, const char *alg=
orithm, const char *properties)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+EVP_CIPHER_fetch(const void *ctx, const char *algorithm, const =
char *properties)</span><br><span> {</span><br><span>     ASSERT(!ctx);</sp=
an><br><span>     ASSERT(!properties);</span><br><span>@@ -135,7 +135,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> static inline const E=
VP_MD *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-EVP_MD_fetch(v=
oid *ctx, const char *algorithm, const char *properties)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+EVP_MD_fetch(const void *ctx, const ch=
ar *algorithm, const char *properties)</span><br><span> {</span><br><span> =
    ASSERT(!ctx);</span><br><span>     ASSERT(!properties);</span><br><span=
>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><=
span>index 6664c73=2E=2Ee7585ad 100644</span><br><span>--- a/src/openvpn/op=
tions=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ =
-2429,7 +2429,7 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_post=
process_mutate_le(struct connection_entry *ce, struct local_entry *le, int =
mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_postpr=
ocess_mutate_le(const struct connection_entry *ce, struct local_entry *le, =
int mode)</span><br><span> {</span><br><span>     /* use the global port if=
 none is specified */</span><br><span>     if (!le-&gt;port)</span><br><spa=
n>@@ -3589,7 +3589,7 @@</span><br><span> static bool</span><br><span> verif=
y_permission(const char *name, const char *file, int line, const uint64_t t=
ype,</span><br><span>                   const uint64_t allowed, uint64_t *f=
ound, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                  struct options *options, bool is_inline)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                  const str=
uct options *options, bool is_inline)</span><br><span> {</span><br><span>  =
   if (!(type &amp; allowed))</span><br><span>     {</span><br><span>@@ -36=
65,7 +3665,7 @@</span><br><span> }</span><br><span> </span><br><span> stati=
c inline msglvl_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-msgl=
evel_forward_compatible(struct options *options, const msglvl_t msglevel)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+msglevel_forward_comp=
atible(const struct options *options, const msglvl_t msglevel)</span><br><s=
pan> {</span><br><span>     return options-&gt;forward_compatible ? M_WARN =
: msglevel;</span><br><span> }</span><br><span>@@ -4154,7 +4154,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-show_compression_warning(struct compr=
ess_options *info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
how_compression_warning(const struct compress_options *info)</span><br><spa=
n> {</span><br><span>     if (comp_non_stub_enabled(info))</span><br><span>=
     {</span><br><span>diff --git a/src/openvpn/options_parse=2Ec b/src/ope=
nvpn/options_parse=2Ec</span><br><span>index 12934ab=2E=2E79b8098 100644</s=
pan><br><span>--- a/src/openvpn/options_parse=2Ec</span><br><span>+++ b/src=
/openvpn/options_parse=2Ec</span><br><span>@@ -258,7 +258,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static char *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-read_inline_file(struct in_src *is, const=
 char *close_tag, int *num_lines, struct gc_arena *gc)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+read_inline_file(const struct in_src *is=
, const char *close_tag, int *num_lines, struct gc_arena *gc)</span><br><sp=
an> {</span><br><span>     char line[OPTION_LINE_SIZE];</span><br><span>   =
  struct buffer buf =3D alloc_buf(8 * OPTION_LINE_SIZE);</span><br><span>@@=
 -302,7 +302,7 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_inline_f=
ile(struct in_src *is, char *p[], struct gc_arena *gc)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+check_inline_file(const struct in_src *i=
s, char *p[], struct gc_arena *gc)</span><br><span> {</span><br><span>     =
int num_inline_lines =3D 0;</span><br><span> </span><br><span>diff --git a/=
src/openvpn/otime=2Ec b/src/openvpn/otime=2Ec</span><br><span>index 1608458=
=2E=2E5d3633c 100644</span><br><span>--- a/src/openvpn/otime=2Ec</span><br>=
<span>+++ b/src/openvpn/otime=2Ec</span><br><span>@@ -66,7 +66,7 @@</span><=
br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-update_now_usec(struct timeval *tv)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+update_now_usec(const struc=
t timeval *tv)</span><br><span> {</span><br><span>     const time_t last =
=3D now;</span><br><span>     update_now(tv-&gt;tv_sec);</span><br><span>di=
ff --git a/src/openvpn/otime=2Eh b/src/openvpn/otime=2Eh</span><br><span>in=
dex d14f01e=2E=2E74d21ff 100644</span><br><span>--- a/src/openvpn/otime=2Eh=
</span><br><span>+++ b/src/openvpn/otime=2Eh</span><br><span>@@ -65,7 +65,7=
 @@</span><br><span> void update_now(const time_t system_time);</span><br><=
span> </span><br><span> extern time_t now_usec;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void update_now_usec(struct timeval *tv);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void update_now_usec(const =
struct timeval *tv);</span><br><span> </span><br><span> static inline int</=
span><br><span> openvpn_gettimeofday(struct timeval *tv, void *tz)</span><b=
r><span>diff --git a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh</span><b=
r><span>index 9bb0866=2E=2E1665751 100644</span><br><span>--- a/src/openvpn=
/proto=2Eh</span><br><span>+++ b/src/openvpn/proto=2Eh</span><br><span>@@ -=
248,7 +248,7 @@</span><br><span>  * and offset of IP header (via parameter)=
=2E</span><br><span>  */</span><br><span> static inline int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-get_tun_ip_ver(int tunnel_type, struc=
t buffer *buf, int *ip_hdr_offset)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+get_tun_ip_ver(int tunnel_type, const struct buffer *buf, in=
t *ip_hdr_offset)</span><br><span> {</span><br><span>     int ip_ver =3D -1=
;</span><br><span> </span><br><span>diff --git a/src/openvpn/proxy=2Ec b/sr=
c/openvpn/proxy=2Ec</span><br><span>index 74a6cf9=2E=2Ec3ad7de 100644</span=
><br><span>--- a/src/openvpn/proxy=2Ec</span><br><span>+++ b/src/openvpn/pr=
oxy=2Ec</span><br><span>@@ -527,8 +527,9 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-add_proxy_headers(struct http_proxy_info *p, socket_descriptor=
_t sd, /* already open to proxy */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                  const char *host                            =
       /* openvpn server remote */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+add_proxy_headers(const struct http_proxy_info *p,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                  socket_desc=
riptor_t sd, /* already open to proxy */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                  const char *host        /* openvpn s=
erver remote */</span><br><span> )</span><br><span> {</span><br><span>     =
char buf[512];</span><br><span>@@ -597,8 +598,8 @@</span><br><span>        =
                       socket_descriptor_t sd, /* already open to proxy */<=
/span><br><span>                               const char *host,       /* o=
penvpn server remote */</span><br><span>                               cons=
t char *port,       /* openvpn server port */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                              struct event_timeout =
*server_poll_timeout, struct buffer *lookahead,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                              struct signal_info =
*sig_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                     const struct event_timeout *server_poll_timeout,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
     struct buffer *lookahead, struct signal_info *sig_info)</span><br><spa=
n> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>=
     char buf[512];</span><br><span>diff --git a/src/openvpn/proxy=2Eh b/sr=
c/openvpn/proxy=2Eh</span><br><span>index e662e7d=2E=2Ea2f4e47 100644</span=
><br><span>--- a/src/openvpn/proxy=2Eh</span><br><span>+++ b/src/openvpn/pr=
oxy=2Eh</span><br><span>@@ -89,7 +89,7 @@</span><br><span>                 =
                   socket_descriptor_t sd, /* already open to proxy */</spa=
n><br><span>                                    const char *host,       /* =
openvpn server remote */</span><br><span>                                  =
  const char *port,       /* openvpn server port */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                   struct e=
vent_timeout *server_poll_timeout,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                   const struct event_timeou=
t *server_poll_timeout,</span><br><span>                                   =
 struct buffer *lookahead, struct signal_info *sig_info);</span><br><span> =
</span><br><span> uint8_t *make_base64_string2(const uint8_t *str, int str_=
len, struct gc_arena *gc);</span><br><span>diff --git a/src/openvpn/ps=2Ec =
b/src/openvpn/ps=2Ec</span><br><span>index 08c2673=2E=2E2679c4d5 100644</sp=
an><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=
=2Ec</span><br><span>@@ -334,7 +334,7 @@</span><br><span>  * the proxy can =
determine true client origin=2E</span><br><span>  */</span><br><span> stati=
c void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-journal_add(con=
st char *journal_dir, struct proxy_connection *pc, struct proxy_connection =
*cp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+journal_add(con=
st char *journal_dir, const struct proxy_connection *pc, struct proxy_conne=
ction *cp)</span><br><span> {</span><br><span>     struct openvpn_sockaddr =
from, to;</span><br><span> </span><br><span>@@ -412,7 +412,7 @@</span><br><=
span> static bool</span><br><span> proxy_entry_new(struct proxy_connection =
**list, struct event_set *es,</span><br><span>                 const struct=
 openvpn_sockaddr server_addr, const socket_descriptor_t sd_client,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                struct buffer=
 *initial_data, const char *journal_dir)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                const struct buffer *initial_data, con=
st char *journal_dir)</span><br><span> {</span><br><span>     socket_descri=
ptor_t sd_server;</span><br><span>     int status;</span><br><span>@@ -1015=
,7 +1015,7 @@</span><br><span>  * call=2E</span><br><span>  */</span><br><s=
pan> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-port_share_r=
edirect(struct port_share *ps, const struct buffer *head, socket_descriptor=
_t sd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+port_share_re=
direct(const struct port_share *ps, const struct buffer *head, socket_descr=
iptor_t sd)</span><br><span> {</span><br><span>     if (ps)</span><br><span=
>     {</span><br><span>diff --git a/src/openvpn/ps=2Eh b/src/openvpn/ps=2E=
h</span><br><span>index 557ecf5=2E=2E918ceb6 100644</span><br><span>--- a/s=
rc/openvpn/ps=2Eh</span><br><span>+++ b/src/openvpn/ps=2Eh</span><br><span>=
@@ -49,7 +49,7 @@</span><br><span> </span><br><span> bool is_openvpn_protoc=
ol(const struct buffer *buf);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void port_share_redirect(struct port_share *ps, c=
onst struct buffer *head, socket_descriptor_t sd);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void port_share_redirect(const struct port_s=
hare *ps, const struct buffer *head, socket_descriptor_t sd);</span><br><sp=
an> </span><br><span> #endif /* if PORT_SHARE */</span><br><span> #endif /*=
 ifndef PS_H */</span><br><span>diff --git a/src/openvpn/push=2Ec b/src/ope=
nvpn/push=2Ec</span><br><span>index 0e281d2=2E=2E8dfe0d5 100644</span><br><=
span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec<=
/span><br><span>@@ -430,7 +430,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-se=
nd_auth_pending_messages(struct tls_multi *tls_multi, struct tls_session *s=
ession,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_auth_pe=
nding_messages(const struct tls_multi *tls_multi, struct tls_session *sessi=
on,</span><br><span>                            const char *extra, unsigned=
 int timeout)</span><br><span> {</span><br><span>     struct key_state *ks =
=3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span>diff --git a/src/open=
vpn/push=2Eh b/src/openvpn/push=2Eh</span><br><span>index dff945f=2E=2E3930=
2f6 100644</span><br><span>--- a/src/openvpn/push=2Eh</span><br><span>+++ b=
/src/openvpn/push=2Eh</span><br><span>@@ -117,7 +117,7 @@</span><br><span> =
 * doc/management-notes=2Etxt under client-pending-auth for</span><br><span=
>  * more details on message format</span><br><span>  */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-bool send_auth_pending_messages(struct t=
ls_multi *tls_multi, struct tls_session *session,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool send_auth_pending_messages(const struct =
tls_multi *tls_multi, struct tls_session *session,</span><br><span>        =
                         const char *extra, unsigned int timeout);</span><b=
r><span> </span><br><span> void send_restart(struct context *c, const char =
*kill_msg);</span><br><span>diff --git a/src/openvpn/push_util=2Ec b/src/op=
envpn/push_util=2Ec</span><br><span>index 0213041=2E=2E7fa5987 100644</span=
><br><span>--- a/src/openvpn/push_util=2Ec</span><br><span>+++ b/src/openvp=
n/push_util=2Ec</span><br><span>@@ -222,7 +222,7 @@</span><br><span> </span=
><br><span> /* Return true if the client supports push-update */</span><br>=
<span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sup=
port_push_update(struct multi_instance *mi)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+support_push_update(const struct multi_instance *mi=
)</span><br><span> {</span><br><span>     ASSERT(mi-&gt;context=2Ec2=2Etls_=
multi);</span><br><span>     const unsigned int iv_proto_peer =3D extract_i=
v_proto(mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_info);</span><br><span>dif=
f --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</span><br><sp=
an>index c268cce=2E=2E7b5b17c 100644</span><br><span>--- a/src/openvpn/reli=
able=2Ec</span><br><span>+++ b/src/openvpn/reliable=2Ec</span><br><span>@@ =
-59,7 +59,7 @@</span><br><span> </span><br><span> /* check if a particular =
packet_id is present in ack */</span><br><span> static inline bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-reliable_ack_packet_id_present=
(struct reliable_ack *ack, packet_id_type pid)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+reliable_ack_packet_id_present(const struct reli=
able_ack *ack, packet_id_type pid)</span><br><span> {</span><br><span>     =
for (int i =3D 0; i &lt; ack-&gt;len; ++i)</span><br><span>     {</span><br=
><span>@@ -752,7 +752,7 @@</span><br><span>  */</span><br><span> </span><br=
><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_=
mark_active_incoming(struct reliable *rel, struct buffer *buf, packet_id_ty=
pe pid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_mar=
k_active_incoming(struct reliable *rel, const struct buffer *buf, packet_id=
_type pid,</span><br><span>                               int opcode)</span=
><br><span> {</span><br><span>     for (int i =3D 0; i &lt; rel-&gt;size; +=
+i)</span><br><span>@@ -812,7 +812,7 @@</span><br><span> </span><br><span> =
/* delete a buffer previously activated by reliable_mark_active() */</span>=
<br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliab=
le_mark_deleted(struct reliable *rel, struct buffer *buf)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+reliable_mark_deleted(struct reliable=
 *rel, const struct buffer *buf)</span><br><span> {</span><br><span>     fo=
r (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br>=
<span>diff --git a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh</spa=
n><br><span>index 534feb3=2E=2E7b6fced 100644</span><br><span>--- a/src/ope=
nvpn/reliable=2Eh</span><br><span>+++ b/src/openvpn/reliable=2Eh</span><br>=
<span>@@ -184,7 +184,7 @@</span><br><span>  * @li False, if there are packe=
t IDs to be acknowledged=2E</span><br><span>  */</span><br><span> static in=
line bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_ack=
_empty(struct reliable_ack *ack)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+reliable_ack_empty(const struct reliable_ack *ack)</span><br><=
span> {</span><br><span>     return !ack-&gt;len;</span><br><span> }</span>=
<br><span>@@ -213,7 +213,7 @@</span><br><span>  * @returns the number of ou=
tstanding acks</span><br><span>  */</span><br><span> static inline int</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_ack_outstanding(s=
truct reliable_ack *ack)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+reliable_ack_outstanding(const struct reliable_ack *ack)</span><br><sp=
an> {</span><br><span>     return ack-&gt;len;</span><br><span> }</span><br=
><span>@@ -369,7 +369,7 @@</span><br><span>  * @param pid The packet&#39;s =
packet ID=2E</span><br><span>  * @param opcode The packet&#39;s opcode=2E</=
span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vo=
id reliable_mark_active_incoming(struct reliable *rel, struct buffer *buf, =
packet_id_type pid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void reliable_mark_active_incoming(struct reliable *rel, const struct buffe=
r *buf, packet_id_type pid,</span><br><span>                               =
     int opcode);</span><br><span> </span><br><span> /**</span><br><span>@@=
 -422,7 +422,7 @@</span><br><span>  * @param rel The reliable structure ass=
ociated with the given buffer=2E</span><br><span>  * @param buf The buffer =
of the reliable entry which is to be removed=2E</span><br><span>  */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-void reliable_mark_deleted(s=
truct reliable *rel, struct buffer *buf);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void reliable_mark_deleted(struct reliable *rel, cons=
t struct buffer *buf);</span><br><span> </span><br><span> /** @} name Funct=
ions for extracting incoming packets */</span><br><span> </span><br><span>d=
iff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>i=
ndex 33b2387=2E=2E4830a5b 100644</span><br><span>--- a/src/openvpn/route=2E=
c</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -898,8 +89=
8,9 @@</span><br><span> }</span><br><span> </span><br><span> static bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-add_bypass_routes(struct=
 route_bypass *rb, in_addr_t gateway, const struct tuntap *tt,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                  unsigned int fla=
gs, const struct route_gateway_info *rgi,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+add_bypass_routes(const struct route_bypass *rb, in_a=
ddr_t gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
             const struct tuntap *tt, unsigned int flags,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                  const struct route_=
gateway_info *rgi,</span><br><span>                   const struct env_set =
*es, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>     int re=
t =3D true;</span><br><span>@@ -916,8 +917,9 @@</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-del_bypass_routes(struct route_bypass *rb, in_addr_t gatew=
ay, const struct tuntap *tt,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                  unsigned int flags, const struct route_gateway_inf=
o *rgi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+del_bypass_r=
outes(const struct route_bypass *rb, in_addr_t gateway,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                  const struct tuntap *=
tt, unsigned int flags,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                  const struct route_gateway_info *rgi,</span><br><span=
>                   const struct env_set *es, openvpn_net_ctx_t *ctx)</span=
><br><span> {</span><br><span>     int i;</span><br><span>@@ -3939,7 +3941,=
8 @@</span><br><span> #else  /* if defined(_WIN32) */</span><br><span> </sp=
an><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-get_bypass_addresses(struct route_bypass *rb, const unsigned int flags)=
 /* PLATFORM-SPECIFIC */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+// cppcheck-suppress constParameterPointer ; stub</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+get_bypass_addresses(struct route_bypass=
 *rb, const unsigned int flags)</span><br><span> {</span><br><span> }</span=
><br><span> </span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/open=
vpn/socket=2Ec</span><br><span>index 33def4e=2E=2Edf8e400 100644</span><br>=
<span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=
=2Ec</span><br><span>@@ -620,7 +620,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-bind_local(struct link_socket *sock)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bind_local(const struct link_socket *sock)</span=
><br><span> {</span><br><span>     /* bind to local address/port */</span><=
br><span>     if (sock-&gt;bind_local)</span><br><span>@@ -916,8 +916,8 @@<=
/span><br><span> }</span><br><span> </span><br><span> void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-socket_bind(socket_descriptor_t sd, st=
ruct addrinfo *local, int ai_family, const char *prefix,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            bool ipv6only)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+socket_bind(socket_descriptor_t s=
d, const struct addrinfo *local, int ai_family,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            const char *prefix, bool ipv6only)<=
/span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</s=
pan><br><span> </span><br><span>@@ -1125,8 +1125,8 @@</span><br><span>  * s=
uch as TCP=2E</span><br><span>  */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static void stream_buf_init(struct stream_b=
uf *sb, struct buffer *buf, const unsigned int sockflags,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                            const int p=
roto);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void s=
tream_buf_init(struct stream_buf *sb, const struct buffer *buf,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                            con=
st unsigned int sockflags, const int proto);</span><br><span> </span><br><s=
pan> static void stream_buf_close(struct stream_buf *sb);</span><br><span> =
</span><br><span>@@ -1479,7 +1479,7 @@</span><br><span> }</span><br><span> =
</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-phase2_set_socket_flags(struct link_socket *sock)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+phase2_set_socket_flags(const struct =
link_socket *sock)</span><br><span> {</span><br><span>     /* TCP_NODELAY i=
s enabled by default on every TCP socket; dco-win is</span><br><span>      =
* skipped as it manages its own socket */</span><br><span>@@ -2075,7 +2075,=
7 @@</span><br><span> }</span><br><span> </span><br><span> static void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-stream_buf_init(struct str=
eam_buf *sb, struct buffer *buf, const unsigned int sockflags,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+stream_buf_init(struct stream_bu=
f *sb, const struct buffer *buf, const unsigned int sockflags,</span><br><s=
pan>                 const int proto)</span><br><span> {</span><br><span>  =
   sb-&gt;buf_init =3D *buf;</span><br><span>@@ -2341,7 +2341,7 @@</span><b=
r><span> #endif</span><br><span> </span><br><span> static ssize_t</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_read_udp_posix_recv=
msg(struct link_socket *sock, struct buffer *buf,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+link_socket_read_udp_posix_recvmsg(const stru=
ct link_socket *sock, struct buffer *buf,</span><br><span>                 =
                   struct link_socket_actual *from, socklen_t *fromlen)</sp=
an><br><span> {</span><br><span>     struct iovec iov;</span><br><span>@@ -=
2413,7 +2413,7 @@</span><br><span> #endif /* if ENABLE_IP_PKTINFO */</span>=
<br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-link_socket_read_udp_posix(struct link_socket *sock, struct =
buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_so=
cket_read_udp_posix(const struct link_socket *sock, struct buffer *buf,</sp=
an><br><span>                            struct link_socket_actual *from)</=
span><br><span> {</span><br><span>     ssize_t recvlen;</span><br><span>@@ =
-2476,7 +2476,7 @@</span><br><span> #if ENABLE_IP_PKTINFO</span><br><span> =
</span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-link_socket_write_udp_posix_sendmsg(struct link_socket *sock, struct bu=
ffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_sock=
et_write_udp_posix_sendmsg(const struct link_socket *sock, const struct buf=
fer *buf,</span><br><span>                                     struct link_=
socket_actual *to)</span><br><span> {</span><br><span>     struct iovec iov=
;</span><br><span>@@ -2672,7 +2672,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-socket_send_queue(struct link_socket *sock, struct buffer *buf, const stru=
ct link_socket_actual *to)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+socket_send_queue(struct link_socket *sock, const struct buffer *buf=
, const struct link_socket_actual *to)</span><br><span> {</span><br><span> =
    if (sock-&gt;writes=2Eiostate =3D=3D IOSTATE_INITIAL)</span><br><span> =
    {</span><br><span>@@ -2772,8 +2772,8 @@</span><br><span>     return soc=
k-&gt;writes=2Eiostate;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-read_sockaddr_from_overlapped(struct overlapped_io *i=
o, struct sockaddr *dst, int overlapped_ret)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+read_sockaddr_from_overlapped(const struct overlapped_io *=
io, struct sockaddr *dst, int overlapped_ret)</span><br><span> {</span><br>=
<span>     if (overlapped_ret &gt;=3D 0 &amp;&amp; io-&gt;addr_defined)</sp=
an><br><span>     {</span><br><span>diff --git a/src/openvpn/socket=2Eh b/s=
rc/openvpn/socket=2Eh</span><br><span>index 46fa29c=2E=2Ecbcdeef 100644</sp=
an><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ b/src/openvpn=
/socket=2Eh</span><br><span>@@ -268,7 +268,7 @@</span><br><span> </span><br=
><span> int socket_recv_queue(struct link_socket *sock, int maxsize);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int socke=
t_send_queue(struct link_socket *sock, struct buffer *buf,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+int socket_send_queue(struct link_so=
cket *sock, const struct buffer *buf,</span><br><span>                     =
  const struct link_socket_actual *to);</span><br><span> </span><br><span> =
typedef struct</span><br><span>@@ -348,8 +348,8 @@</span><br><span> </span>=
<br><span> struct link_socket *link_socket_new(void);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void socket_bind(socket_d=
escriptor_t sd, struct addrinfo *local, int af_family, const char *prefix,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 bool =
ipv6only);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void sock=
et_bind(socket_descriptor_t sd, const struct addrinfo *local, int af_family=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 c=
onst char *prefix, bool ipv6only);</span><br><span> </span><br><span> int o=
penvpn_connect(socket_descriptor_t sd, const struct sockaddr *remote, int c=
onnect_timeout,</span><br><span>                     volatile int *signal_r=
eceived);</span><br><span>@@ -496,7 +496,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> static inline bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-link_socket_verify_incoming_addr(struct buffer *buf, =
const struct link_socket_info *info,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+link_socket_verify_incoming_addr(const struct buffer *buf,=
 const struct link_socket_info *info,</span><br><span>                     =
             const struct link_socket_actual *from_addr)</span><br><span> {=
</span><br><span>     if (buf-&gt;len &gt; 0)</span><br><span>@@ -620,7 +62=
0,7 @@</span><br><span> </span><br><span> #else  /* ifdef _WIN32 */</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssize_t lin=
k_socket_read_udp_posix(struct link_socket *sock, struct buffer *buf,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t link_socket_read_=
udp_posix(const struct link_socket *sock, struct buffer *buf,</span><br><sp=
an>                                    struct link_socket_actual *from);</s=
pan><br><span> </span><br><span> #endif /* ifdef _WIN32 */</span><br><span>=
@@ -706,12 +706,12 @@</span><br><span> </span><br><span> #else /* ifdef _WI=
N32 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-ssize_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock, st=
ruct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ss=
ize_t link_socket_write_udp_posix_sendmsg(const struct link_socket *sock, c=
onst struct buffer *buf,</span><br><span>                                  =
           struct link_socket_actual *to);</span><br><span> </span><br><spa=
n> </span><br><span> static inline ssize_t</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-link_socket_write_udp_posix(struct link_socket *sock, =
struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
link_socket_write_udp_posix(const struct link_socket *sock, const struct bu=
ffer *buf,</span><br><span>                             struct link_socket_=
actual *to)</span><br><span> {</span><br><span> #if ENABLE_IP_PKTINFO</span=
><br><span>@@ -727,7 +727,7 @@</span><br><span> }</span><br><span> </span><=
br><span> static inline ssize_t</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-link_socket_write_tcp_posix(struct link_socket *sock, struct buff=
er *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket=
_write_tcp_posix(const struct link_socket *sock, const struct buffer *buf)<=
/span><br><span> {</span><br><span>     return send(sock-&gt;sd, CBPTR(buf)=
, BLENZ(buf), MSG_NOSIGNAL);</span><br><span> }</span><br><span>@@ -785,7 +=
785,7 @@</span><br><span>  * from tunnel packet=2E</span><br><span>  */</sp=
an><br><span> static inline void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-link_socket_set_tos(struct link_socket *sock)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+link_socket_set_tos(const struct link_=
socket *sock)</span><br><span> {</span><br><span>     if (sock &amp;&amp; s=
ock-&gt;ptos_defined)</span><br><span>     {</span><br><span>diff --git a/s=
rc/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh</span><br><span>in=
dex 13f5962=2E=2Eadd08ba 100644</span><br><span>--- a/src/openvpn/socket_ut=
il=2Eh</span><br><span>+++ b/src/openvpn/socket_util=2Eh</span><br><span>@@=
 -439,7 +439,7 @@</span><br><span> </span><br><span> </span><br><span> stat=
ic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-addrlis=
t_match_proto(const struct openvpn_sockaddr *a1, struct addrinfo *addr_list=
, const int proto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+a=
ddrlist_match_proto(const struct openvpn_sockaddr *a1, const struct addrinf=
o *addr_list, const int proto)</span><br><span> {</span><br><span>     retu=
rn link_socket_proto_connection_oriented(proto) ? addrlist_match(a1, addr_l=
ist)</span><br><span>                                                      =
   : addrlist_port_match(a1, addr_list);</span><br><span>diff --git a/src/o=
penvpn/socks=2Ec b/src/openvpn/socks=2Ec</span><br><span>index b84da24=2E=
=2E0296349 100644</span><br><span>--- a/src/openvpn/socks=2Ec</span><br><sp=
an>+++ b/src/openvpn/socks=2Ec</span><br><span>@@ -83,7 +83,7 @@</span><br>=
<span> </span><br><span> static bool</span><br><span> socks_proxy_recv_char=
(uint8_t *c, const char *name, socket_descriptor_t sd,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                      struct event_timeout=
 *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                      const struct event_timeout *server_poll_timeout,</=
span><br><span>                       volatile int *signal_received)</span>=
<br><span> {</span><br><span>     fd_set reads;</span><br><span>@@ -98,8 +9=
8,8 @@</span><br><span> }</span><br><span> </span><br><span> static bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-socks_username_password_=
auth(struct socks_proxy_info *p, socket_descriptor_t sd,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                             struct even=
t_timeout *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+socks_username_password_auth(const struct socks_proxy_info *p, =
socket_descriptor_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                             const struct event_timeout *server_poll_ti=
meout,</span><br><span>                              volatile int *signal_r=
eceived)</span><br><span> {</span><br><span>     char to_send[516];</span><=
br><span>@@ -157,8 +157,8 @@</span><br><span> }</span><br><span> </span><br=
><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-so=
cks_handshake(struct socks_proxy_info *p, socket_descriptor_t sd,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                struct event_ti=
meout *server_poll_timeout, volatile int *signal_received)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+socks_handshake(const struct socks_p=
roxy_info *p, socket_descriptor_t sd,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                const struct event_timeout *server_poll_t=
imeout, volatile int *signal_received)</span><br><span> {</span><br><span> =
    uint8_t buf[2];</span><br><span>     int len =3D 0;</span><br><span>@@ =
-232,7 +232,7 @@</span><br><span> </span><br><span> static bool</span><br><=
span> recv_socks_reply(socket_descriptor_t sd, struct openvpn_sockaddr *add=
r,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 st=
ruct event_timeout *server_poll_timeout, volatile int *signal_received)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const =
struct event_timeout *server_poll_timeout, volatile int *signal_received)</=
span><br><span> {</span><br><span>     uint8_t atyp =3D 0;</span><br><span>=
     int alen =3D 0;</span><br><span>@@ -334,11 +334,11 @@</span><br><span>=
 }</span><br><span> </span><br><span> void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-establish_socks_proxy_passthru(struct socks_proxy_info=
 *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+establish_socks=
_proxy_passthru(const struct socks_proxy_info *p,</span><br><span>         =
                       socket_descriptor_t sd, /* already open to proxy */<=
/span><br><span>                                const char *host,       /* =
openvpn server remote */</span><br><span>                                co=
nst char *servname,   /* openvpn server port */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                               struct event_timeo=
ut *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                               const struct event_timeout *server_poll=
_timeout,</span><br><span>                                struct signal_inf=
o *sig_info)</span><br><span> {</span><br><span>     char buf[270];</span><=
br><span>@@ -392,10 +392,10 @@</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-establi=
sh_socks_proxy_udpassoc(struct socks_proxy_info *p,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+establish_socks_proxy_udpassoc(const stru=
ct socks_proxy_info *p,</span><br><span>                                soc=
ket_descriptor_t ctrl_sd, /* already open to proxy */</span><br><span>     =
                           struct openvpn_sockaddr *relay_addr,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                               st=
ruct event_timeout *server_poll_timeout,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                               const struct event_time=
out *server_poll_timeout,</span><br><span>                                s=
truct signal_info *sig_info)</span><br><span> {</span><br><span>     if (!s=
ocks_handshake(p, ctrl_sd, server_poll_timeout, &amp;sig_info-&gt;signal_re=
ceived))</span><br><span>diff --git a/src/openvpn/socks=2Eh b/src/openvpn/s=
ocks=2Eh</span><br><span>index caed18c=2E=2E7434bbf 100644</span><br><span>=
--- a/src/openvpn/socks=2Eh</span><br><span>+++ b/src/openvpn/socks=2Eh</sp=
an><br><span>@@ -49,17 +49,17 @@</span><br><span> </span><br><span> void so=
cks_proxy_close(struct socks_proxy_info *sp);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void establish_socks_proxy_passth=
ru(struct socks_proxy_info *p,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void establish_socks_proxy_passthru(const struct socks_proxy_inf=
o *p,</span><br><span>                                     socket_descripto=
r_t sd, /* already open to proxy */</span><br><span>                       =
              const char *host,       /* openvpn server remote */</span><br=
><span>                                     const char *servname,   /* open=
vpn server port */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                                 struct event_timeout *server_poll_timeout,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                 const struct event_timeout *server_poll_timeout,</span><br=
><span>                                     struct signal_info *sig_info);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void=
 establish_socks_proxy_udpassoc(struct socks_proxy_info *p,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void establish_socks_proxy_udpassoc=
(const struct socks_proxy_info *p,</span><br><span>                        =
             socket_descriptor_t ctrl_sd, /* already open to proxy */</span=
><br><span>                                     struct openvpn_sockaddr *re=
lay_addr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                        struct event_timeout *server_poll_timeout,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
        const struct event_timeout *server_poll_timeout,</span><br><span>  =
                                   struct signal_info *sig_info);</span><br=
><span> </span><br><span> void socks_process_incoming_udp(struct buffer *bu=
f, struct link_socket_actual *from);</span><br><span>diff --git a/src/openv=
pn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index aeec020=2E=2E3594871=
 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src=
/openvpn/ssl=2Ec</span><br><span>@@ -1171,7 +1171,7 @@</span><br><span> }</=
span><br><span> </span><br><span> struct tls_multi *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tls_multi_init(struct tls_options *tls_opti=
ons)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_multi_init(=
const struct tls_options *tls_options)</span><br><span> {</span><br><span> =
    struct tls_multi *ret;</span><br><span> </span><br><span>@@ -1212,7 +12=
12,7 @@</span><br><span>  */</span><br><span> </span><br><span> struct tls_=
auth_standalone *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_=
auth_standalone_init(struct tls_options *tls_options, struct gc_arena *gc)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_auth_standalone_=
init(const struct tls_options *tls_options, struct gc_arena *gc)</span><br>=
<span> {</span><br><span>     struct tls_auth_standalone *tas;</span><br><s=
pan> </span><br><span>@@ -1631,8 +1631,9 @@</span><br><span> </span><br><sp=
an> bool</span><br><span> tls_session_update_crypto_params_do_work(struct t=
ls_multi *multi, struct tls_session *session,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                         struct opt=
ions *options, struct frame *frame,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                                         struct frame *frame_=
fragment, struct link_socket_info *lsi,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                         const struct o=
ptions *options, struct frame *frame,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                         struct frame *fr=
ame_fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                   const struct link_socket_info *lsi,</spa=
n><br><span>                                          dco_context_t *dco)</=
span><br><span> {</span><br><span>     if (session-&gt;key[KS_PRIMARY]=2Ecr=
ypto_options=2Ekey_ctx_bi=2Einitialized)</span><br><span>@@ -1704,7 +1705,7=
 @@</span><br><span> bool</span><br><span> tls_session_update_crypto_params=
(struct tls_multi *multi, struct tls_session *session,</span><br><span>    =
                              struct options *options, struct frame *frame,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
            struct frame *frame_fragment, struct link_socket_info *lsi,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
          struct frame *frame_fragment, const struct link_socket_info *lsi,=
</span><br><span>                                  dco_context_t *dco)</spa=
n><br><span> {</span><br><span>     if (!check_session_cipher(session, opti=
ons))</span><br><span>@@ -1920,7 +1921,8 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-push_peer_info_peerid(struct buffer *out, struct tls_multi *mu=
lti, struct tls_session *session)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+push_peer_info_peerid(struct buffer *out, const struct tls_mu=
lti *multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
              const struct tls_session *session)</span><br><span> {</span><=
br><span>     if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID || session-&gt;op=
t-&gt;dco_enabled)</span><br><span>     {</span><br><span>@@ -1955,7 +1957,=
7 @@</span><br><span>  * @return          true if no error was encountered<=
/span><br><span>  */</span><br><span> static bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-push_peer_info(struct buffer *buf, struct tls_m=
ulti *multi, struct tls_session *session)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+push_peer_info(struct buffer *buf, const struct tls_m=
ulti *multi, struct tls_session *session)</span><br><span> {</span><br><spa=
n>     struct gc_arena gc =3D gc_new();</span><br><span>     bool ret =3D f=
alse;</span><br><span>@@ -2599,8 +2601,8 @@</span><br><span> }</span><br><s=
pan> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-session_skip_to_pre_start(struct tls_session *session, struct tls_pre=
_decrypt_state *state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                          struct link_socket_actual *from)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+session_skip_to_pre_start(struct tl=
s_session *session, const struct tls_pre_decrypt_state *state,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                          const =
struct link_socket_actual *from)</span><br><span> {</span><br><span>     st=
ruct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span>  =
   ks-&gt;session_id_remote =3D state-&gt;peer_session_id;</span><br><span>=
@@ -2829,7 +2831,7 @@</span><br><span> </span><br><span> static bool</span>=
<br><span> check_outgoing_ciphertext(struct key_state *ks, struct tls_sessi=
on *session,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                 struct buffer *to_link, bool *continue_tls_process)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
const struct buffer *to_link, bool *continue_tls_process)</span><br><span> =
{</span><br><span>     if (to_link-&gt;len)</span><br><span>     {</span><b=
r><span>@@ -4193,7 +4195,7 @@</span><br><span> }</span><br><span> </span><b=
r><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_post=
_encrypt(struct tls_multi *multi, struct buffer *buf)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tls_post_encrypt(struct tls_multi *multi,=
 const struct buffer *buf)</span><br><span> {</span><br><span>     struct k=
ey_state *ks =3D multi-&gt;save_ks;</span><br><span>     multi-&gt;save_ks =
=3D NULL;</span><br><span>@@ -4324,7 +4326,7 @@</span><br><span>  * into a =
garbage collectable string which is returned=2E</span><br><span>  */</span>=
<br><span> const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-protocol_dump(struct buffer *buffer, unsigned int flags, struct gc_arena =
*gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+protocol_dump(c=
onst struct buffer *buffer, unsigned int flags, struct gc_arena *gc)</span>=
<br><span> {</span><br><span>     struct buffer out =3D alloc_buf_gc(256, g=
c);</span><br><span>     struct buffer buf =3D *buffer;</span><br><span>dif=
f --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh</span><br><span>index 5=
483fbb=2E=2E76c3610 100644</span><br><span>--- a/src/openvpn/ssl=2Eh</span>=
<br><span>+++ b/src/openvpn/ssl=2Eh</span><br><span>@@ -166,7 +166,7 @@</sp=
an><br><span>  *</span><br><span>  * @return A newly allocated and initiali=
zed \c tls_multi structure=2E</span><br><span>  */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-struct tls_multi *tls_multi_init(struct tls_op=
tions *tls_options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct tls_multi *tls_multi_init(const struct tls_options *tls_options);</=
span><br><span> </span><br><span> /**</span><br><span>  * Finalize initiali=
zation of a \c tls_multi structure=2E</span><br><span>@@ -187,7 +187,7 @@</=
span><br><span> /*</span><br><span>  * Initialize a standalone tls-auth ver=
ification object=2E</span><br><span>  */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-struct tls_auth_standalone *tls_auth_standalone_init(str=
uct tls_options *tls_options,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+struct tls_auth_standalone *tls_auth_standalone_init(const struct=
 tls_options *tls_options,</span><br><span>                                =
                      struct gc_arena *gc);</span><br><span> </span><br><sp=
an> /**</span><br><span>@@ -373,7 +373,7 @@</span><br><span>  * @param mult=
i - The TLS state for this packet&#39;s destination VPN tunnel=2E</span><br=
><span>  * @param buf - The buffer containing the outgoing packet=2E</span>=
<br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void tl=
s_post_encrypt(struct tls_multi *multi, struct buffer *buf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void tls_post_encrypt(struct tls_m=
ulti *multi, const struct buffer *buf);</span><br><span> </span><br><span> =
/** @} name Functions for managing security parameter state for data channe=
l packets */</span><br><span> </span><br><span>@@ -463,7 +463,8 @@</span><b=
r><span>  */</span><br><span> bool tls_session_update_crypto_params(struct =
tls_multi *multi, struct tls_session *session,</span><br><span>            =
                           struct options *options, struct frame *frame,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
              struct frame *frame_fragment, struct link_socket_info *lsi,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                 struct frame *frame_fragment,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                      const stru=
ct link_socket_info *lsi,</span><br><span>                                 =
      dco_context_t *dco);</span><br><span> </span><br><span> /*</span><br>=
<span>@@ -527,7 +528,7 @@</span><br><span> #define PD_VERBOSE              =
   (1 &lt;&lt; 10)</span><br><span> #define PD_TLS_CRYPT               (1 &=
lt;&lt; 11)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-const char *protocol_dump(struct buffer *buffer, unsigned int flags=
, struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+const char *protocol_dump(const struct buffer *buffer, unsigned int fla=
gs, struct gc_arena *gc);</span><br><span> </span><br><span> /*</span><br><=
span>  * debugging code</span><br><span>@@ -566,7 +567,7 @@</span><br><span=
> /* Special method to skip the three way handshake RESET stages=2E This is=
</span><br><span>  * used by the HMAC code when seeing a packet that matche=
s the previous</span><br><span>  * HMAC based stateless server state */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-bool session_skip_to_pre_=
start(struct tls_session *session, struct tls_pre_decrypt_state *state,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
      struct link_socket_actual *from);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool session_skip_to_pre_start(struct tls_session *sess=
ion, const struct tls_pre_decrypt_state *state,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                               const struct lin=
k_socket_actual *from);</span><br><span> </span><br><span> #endif /* ifndef=
 OPENVPN_SSL_H */</span><br><span>diff --git a/src/openvpn/ssl_backend=2Eh =
b/src/openvpn/ssl_backend=2Eh</span><br><span>index a6d57f2=2E=2E2150d81 10=
0644</span><br><span>--- a/src/openvpn/ssl_backend=2Eh</span><br><span>+++ =
b/src/openvpn/ssl_backend=2Eh</span><br><span>@@ -137,7 +137,7 @@</span><br=
><span>  *</span><br><span>  * @return      true if the context is initiali=
sed, false if not=2E</span><br><span>  */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-bool tls_ctx_initialised(struct tls_root_ctx *ctx);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool tls_ctx_initialise=
d(const struct tls_root_ctx *ctx);</span><br><span> </span><br><span> /**</=
span><br><span>  * Set any library specific options=2E</span><br><span>diff=
 --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><b=
r><span>index 9983742=2E=2E965ecdb 100644</span><br><span>--- a/src/openvpn=
/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><b=
r><span>@@ -146,7 +146,7 @@</span><br><span> }</span><br><span> </span><br>=
<span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_in=
itialised(struct tls_root_ctx *ctx)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+tls_ctx_initialised(const struct tls_root_ctx *ctx)</span><=
br><span> {</span><br><span>     /* either this should be NULL or should be=
 non-null and then have a</span><br><span>      * valid TLS ctx inside as w=
ell */</span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openv=
pn/ssl_openssl=2Ec</span><br><span>index 96e90f82=2E=2E7805d43 100644</span=
><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/open=
vpn/ssl_openssl=2Ec</span><br><span>@@ -129,7 +129,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-tls_ctx_initialised(struct tls_root_ctx *ctx)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_initialised(const struc=
t tls_root_ctx *ctx)</span><br><span> {</span><br><span>     /* either this=
 should be NULL or should be non-null and then have a</span><br><span>     =
 * valid TLS ctx inside as well */</span><br><span>@@ -2025,7 +2025,7 @@</s=
pan><br><span> }</span><br><span> </span><br><span> static void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-bio_debug_data(const char *mode, =
BIO *bio, const uint8_t *buf, int len, const char *desc)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bio_debug_data(const char *mode, const=
 BIO *bio, const uint8_t *buf, int len, const char *desc)</span><br><span> =
{</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>   =
  if (len &gt; 0)</span><br><span>@@ -2039,7 +2039,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-bio_debug_oc(const char *mode, BIO *bio)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bio_debug_oc(const char *mode=
, const BIO *bio)</span><br><span> {</span><br><span>     open_biofp();</sp=
an><br><span>     fprintf(biofp, &quot;BIO %s time=3D%&quot; PRIi64 &quot; =
bio=3D&quot; ptr_format &quot;\n&quot;, mode, (int64_t)time(NULL),</span><b=
r><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</spa=
n><br><span>index e9afda4=2E=2Ef78782f 100644</span><br><span>--- a/src/ope=
nvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><s=
pan>@@ -119,7 +119,7 @@</span><br><span>  */</span><br><span> static void</=
span><br><span> tls_wrap_control(struct tls_wrap_ctx *ctx, uint8_t header, =
struct buffer *buf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
               struct session_id *session_id)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                 const struct session_id *session=
_id)</span><br><span> {</span><br><span>     if (ctx-&gt;mode =3D=3D TLS_WR=
AP_AUTH || ctx-&gt;mode =3D=3D TLS_WRAP_NONE)</span><br><span>     {</span>=
<br><span>@@ -403,9 +403,9 @@</span><br><span> </span><br><span> </span><br=
><span> struct buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *=
tas,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
    struct session_id *own_sid, struct session_id *remote_sid, uint8_t head=
er,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
   bool request_resend_wkc)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_aut=
h_standalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                    const struct session_id *own_sid, const struct session_=
id *remote_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                 uint8_t header, bool request_resend_wkc)</span><br><span> =
{</span><br><span>     /* Copy buffer here to point at the same data but al=
low tls_wrap_control</span><br><span>      * to potentially change buf to p=
oint to another buffer without</span><br><span>@@ -490,7 +490,7 @@</span><b=
r><span> bool</span><br><span> check_session_hmac_and_pkt_id(struct tls_pre=
_decrypt_state *state,</span><br><span>                               const=
 struct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                              uint8_t *key,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                              const uint8=
_t *key,</span><br><span>                               int handwindow,</sp=
an><br><span>                               bool pkt_is_ack)</span><br><spa=
n> {</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl=
_pkt=2Eh</span><br><span>index 03e8930=2E=2E8203e4a 100644</span><br><span>=
--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh=
</span><br><span>@@ -183,7 +183,7 @@</span><br><span>  * @return           =
   the expected server session id</span><br><span>  */</span><br><span> boo=
l check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const =
struct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                   uint8_t *key, int handwindow, b=
ool pkt_is_ack);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                const uint8_t *key, int handwindow, bool pk=
t_is_ack);</span><br><span> </span><br><span> /*</span><br><span>  * Write =
a control channel authentication record=2E</span><br><span>@@ -210,8 +210,9=
 @@</span><br><span>  * from the tls pre decrypt state=2E</span><br><span> =
 *</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_a=
uth_standalone *tas,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                  struct session_id *own_sid, struct sessio=
n_id *remote_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
ruct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls=
_auth_standalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                   const struct session_id *own_sid,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
            const struct session_id *remote_sid,</span><br><span>          =
                          uint8_t header, bool request_resend_wkc);</span><=
br><span> </span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_v=
erify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 6631718=2E=2E0=
acba2b 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><s=
pan>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -1140,7 +1140,7 @@<=
/span><br><span>  * cache=2E</span><br><span>  */</span><br><span> static b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_authentication=
_status_use_cache(struct tls_multi *multi)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+tls_authentication_status_use_cache(const struct tls=
_multi *multi)</span><br><span> {</span><br><span>     unsigned int idx =3D=
 min_uint(multi-&gt;tas_cache_num_updates, SIZE(cache_intervals) - 1);</spa=
n><br><span>     time_t latency =3D cache_intervals[idx];</span><br><span>@=
@ -1284,7 +1284,7 @@</span><br><span>  * Check if the script/plugin left a =
message in the auth failed message</span><br><span>  * file and relay it to=
 the user */</span><br><span> static void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-check_for_client_reason(struct tls_multi *multi, struct=
 auth_deferred_status *status)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+check_for_client_reason(struct tls_multi *multi, const struct au=
th_deferred_status *status)</span><br><span> {</span><br><span>     struct =
gc_arena gc =3D gc_new();</span><br><span>     const char *msg =3D key_stat=
e_check_auth_failed_message_file(status, &amp;gc);</span><br><span>@@ -1553=
,7 +1553,7 @@</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><=
br><span> </span><br><span> static bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-set_verify_user_pass_env(struct user_pass *up, struct tls=
_multi *multi, struct tls_session *session)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+set_verify_user_pass_env(const struct user_pass *up=
, struct tls_multi *multi, struct tls_session *session)</span><br><span> {<=
/span><br><span>     /* Is username defined? */</span><br><span>     if ((s=
ession-&gt;opt-&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(=
up-&gt;username))</span><br><span>@@ -1581,7 +1581,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-ssl_verify_username_length(struct tls_session *session, c=
onst char *username)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ssl_verify_username_length(const struct tls_session *session, const char *=
username)</span><br><span> {</span><br><span>     if ((session-&gt;opt-&gt;=
ssl_flags &amp; SSLF_USERNAME_AS_COMMON_NAME)</span><br><span>         &amp=
;&amp; strlen(username) &gt; TLS_USERNAME_LEN)</span><br><span>diff --git a=
/src/openvpn/ssl_verify=2Eh b/src/openvpn/ssl_verify=2Eh</span><br><span>in=
dex 3176d76=2E=2Ee77bc4a 100644</span><br><span>--- a/src/openvpn/ssl_verif=
y=2Eh</span><br><span>+++ b/src/openvpn/ssl_verify=2Eh</span><br><span>@@ -=
202,7 +202,7 @@</span><br><span>  * @return              true if name is un=
der limit or username-as-common-name</span><br><span>  *                   =
   is not active</span><br><span>  */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-bool ssl_verify_username_length(struct tls_session *session=
, const char *username);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bool ssl_verify_username_length(const struct tls_session *session, con=
st char *username);</span><br><span> </span><br><span> /**</span><br><span>=
  * Runs the --client-crresponse script if one is defined=2E</span><br><spa=
n>@@ -275,7 +275,7 @@</span><br><span> void auth_set_client_reason(struct t=
ls_multi *multi, const char *client_reason);</span><br><span> </span><br><s=
pan> static inline const char *</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-tls_client_reason(struct tls_multi *multi)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tls_client_reason(const struct tls_multi =
*multi)</span><br><span> {</span><br><span>     return multi-&gt;client_rea=
son;</span><br><span> }</span><br><span>diff --git a/src/openvpn/status=2Ec=
 b/src/openvpn/status=2Ec</span><br><span>index c7d375b=2E=2Ecfbc38d 100644=
</span><br><span>--- a/src/openvpn/status=2Ec</span><br><span>+++ b/src/ope=
nvpn/status=2Ec</span><br><span>@@ -135,7 +135,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-status_reset(struct status_output *so)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+status_reset(const struct status_output *=
so)</span><br><span> {</span><br><span>     if (so &amp;&amp; so-&gt;fd &gt=
;=3D 0)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/sta=
tus=2Eh b/src/openvpn/status=2Eh</span><br><span>index 7953a4e=2E=2E4c01d75=
 100644</span><br><span>--- a/src/openvpn/status=2Eh</span><br><span>+++ b/=
src/openvpn/status=2Eh</span><br><span>@@ -69,7 +69,7 @@</span><br><span> <=
/span><br><span> bool status_trigger(struct status_output *so);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void status_res=
et(struct status_output *so);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void status_reset(const struct status_output *so);</span><br><spa=
n> </span><br><span> void status_flush(struct status_output *so);</span><br=
><span> </span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=
=2Ec</span><br><span>index 133f670=2E=2Ef191a6b 100644</span><br><span>--- =
a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><=
span>@@ -835,7 +835,7 @@</span><br><span>          const char *ifconfig_ipv=
6_local_parm,     /* --ifconfig parm 1 IPv6 */</span><br><span>          in=
t ifconfig_ipv6_netbits_parm,</span><br><span>          const char *ifconfi=
g_ipv6_remote_parm,    /* --ifconfig parm 2 IPv6 */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         struct addrinfo *local_public, str=
uct addrinfo *remote_public, const bool strict_warn,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         const struct addrinfo *local_pub=
lic, const struct addrinfo *remote_public, const bool strict_warn,</span><b=
r><span>          struct env_set *es, openvpn_net_ctx_t *ctx, struct tuntap=
 *tt)</span><br><span> {</span><br><span>     if (!tt)</span><br><span>@@ -=
978,7 +978,7 @@</span><br><span>  * -&gt; helper function to simplify code =
below</span><br><span>  */</span><br><span> static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-add_route_connected_v6_net(struct tuntap =
*tt, const struct env_set *es)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+add_route_connected_v6_net(const struct tuntap *tt, const struct=
 env_set *es)</span><br><span> {</span><br><span>     struct route_ipv6 r6;=
</span><br><span> </span><br><span>@@ -1020,7 +1020,7 @@</span><br><span>  =
*/</span><br><span> </span><br><span> in_addr_t</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-create_arbitrary_remote(struct tuntap *tt)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+create_arbitrary_remote(co=
nst struct tuntap *tt)</span><br><span> {</span><br><span>     in_addr_t re=
mote;</span><br><span> </span><br><span>@@ -1592,7 +1592,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ipv4(struct tuntap *tt, openv=
pn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+u=
ndo_ifconfig_ipv4(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><b=
r><span> {</span><br><span> #if defined(TARGET_LINUX)</span><br><span>     =
int netbits =3D netmask_to_netbits2(tt-&gt;remote_netmask);</span><br><span=
>@@ -1627,7 +1627,7 @@</span><br><span> }</span><br><span> </span><br><span=
> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifc=
onfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv6(const struct tuntap *t=
t, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> #if defined(=
TARGET_LINUX)</span><br><span>     if (net_addr_v6_del(ctx, tt-&gt;actual_n=
ame, &amp;tt-&gt;local_ipv6, tt-&gt;netbits_ipv6) &lt; 0)</span><br><span>@=
@ -1652,7 +1652,7 @@</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig(str=
uct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_=
t *ctx)</span><br><span> {</span><br><span>     if (tt-&gt;backend_driver !=
=3D DRIVER_NULL &amp;&amp; tt-&gt;backend_driver !=3D DRIVER_AFUNIX)</span>=
<br><span>     {</span><br><span>@@ -1720,13 +1720,13 @@</span><br><span> }=
</span><br><span> </span><br><span> static ssize_t</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-write_tun_header(struct tuntap *tt, uint8_t *b=
uf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_t=
un_header(const struct tuntap *tt, const uint8_t *buf, int len)</span><br><=
span> {</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br=
><span>     {</span><br><span>         u_int32_t type;</span><br><span>    =
     struct iovec iv[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        const struct ip *iph =3D (struct ip *)buf;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const struct ip *iph =3D (const s=
truct ip *)buf;</span><br><span> </span><br><span>         if (iph-&gt;ip_v=
 =3D=3D 6)</span><br><span>         {</span><br><span>@@ -1737,9 +1737,11 @=
@</span><br><span>             type =3D htonl(AF_INET);</span><br><span>   =
      }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* argument to writev is a pointer to const but we still need=
 to drop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
the const from buf pointer here */</span><br><span>         iv[0]=2Eiov_bas=
e =3D &amp;type;</span><br><span>         iv[0]=2Eiov_len =3D sizeof(type);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[1]=2Eiov_b=
ase =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 iv[1]=2Eiov_base =3D (void *)buf;</span><br><span>         iv[1]=2Eiov_len=
 =3D len;</span><br><span> </span><br><span>         return header_modify_r=
ead_write_return(writev(tt-&gt;fd, iv, 2));</span><br><span>@@ -1751,7 +175=
3,7 @@</span><br><span> }</span><br><span> </span><br><span> static ssize_t=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun_header(struc=
t tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+read_tun_header(const struct tuntap *tt, uint8_t *buf, int=
 len)</span><br><span> {</span><br><span>     if (tt-&gt;type =3D=3D DEV_TY=
PE_TUN)</span><br><span>     {</span><br><span>@@ -1777,13 +1779,13 @@</spa=
n><br><span>  */</span><br><span> #if !defined(TARGET_DARWIN)</span><br><sp=
an> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(=
struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t *buf=
, int len)</span><br><span> {</span><br><span>     return write_tun_header(=
tt, buf, len);</span><br><span> }</span><br><span> </span><br><span> ssize_=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tunt=
ap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int len)</span><=
br><span> {</span><br><span>     return read_tun_header(tt, buf, len);</spa=
n><br><span> }</span><br><span>@@ -1799,7 +1801,7 @@</span><br><span> </spa=
n><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br=
><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tu=
n_dco_enabled(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+tun_dco_enabled(const struct tuntap *tt)</span><br><span> {</s=
pan><br><span>     return tt-&gt;backend_driver =3D=3D DRIVER_DCO;</span><b=
r><span> }</span><br><span>@@ -2047,13 +2049,13 @@</span><br><span> }</span=
><br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tunt=
ap *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><span>   =
  return write(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span> </=
span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t=
 *buf, int len)</span><br><span> {</span><br><span>     return read(tt-&gt;=
fd, buf, len);</span><br><span> }</span><br><span>@@ -2252,13 +2254,13 @@</=
span><br><span> }</span><br><span> </span><br><span> ssize_t</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t=
 *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+writ=
e_tun(const struct tuntap *tt, const uint8_t *buf, int len)</span><br><span=
> {</span><br><span>     return write(tt-&gt;fd, buf, len);</span><br><span=
> }</span><br><span> </span><br><span> ssize_t</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const stru=
ct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>  =
   return read(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span>@@ =
-2588,7 +2590,7 @@</span><br><span> }</span><br><span> </span><br><span> ss=
ize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct=
 tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t *buf, int =
len)</span><br><span> {</span><br><span>     struct strbuf sbuf;</span><br>=
<span>     sbuf=2Elen =3D len;</span><br><span>@@ -2597,7 +2599,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> ssize_t</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf,=
 int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(c=
onst struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br=
><span>     struct strbuf sbuf;</span><br><span>     int f =3D 0;</span><br=
><span>@@ -3095,7 +3097,7 @@</span><br><span> }</span><br><span> </span><br=
><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_=
tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t =
*buf, int len)</span><br><span> {</span><br><span>     if (tt-&gt;backend_d=
river =3D=3D DRIVER_UTUN)</span><br><span>     {</span><br><span>@@ -3108,7=
 +3110,7 @@</span><br><span> }</span><br><span> </span><br><span> ssize_t</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap =
*tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int len)</span><br>=
<span> {</span><br><span>     if (tt-&gt;backend_driver =3D=3D DRIVER_UTUN)=
</span><br><span>     {</span><br><span>@@ -3243,13 +3245,13 @@</span><br><=
span> }</span><br><span> </span><br><span> ssize_t</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int=
 len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(cons=
t struct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</span>=
<br><span>     return write(tt-&gt;fd, buf, len);</span><br><span> }</span>=
<br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap =
*tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     return =
read(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span>@@ -3311,7 +3=
313,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-tun_write_queue(struct tuntap =
*tt, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+tun_write_queue(struct tuntap *tt, const struct buffer *buf)</span><br=
><span> {</span><br><span>     if (tt-&gt;writes=2Eiostate =3D=3D IOSTATE_I=
NITIAL)</span><br><span>     {</span><br><span>@@ -3365,7 +3367,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tun_write_win32(struct tuntap *tt, struct b=
uffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_writ=
e_win32(struct tuntap *tt, const struct buffer *buf)</span><br><span> {</sp=
an><br><span>     int err =3D 0;</span><br><span>     int status =3D 0;</sp=
an><br><span>@@ -5370,7 +5372,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-for=
k_register_dns_action(struct tuntap *tt)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+fork_register_dns_action(const struct tuntap *tt)</spa=
n><br><span> {</span><br><span>     if (tt &amp;&amp; tt-&gt;options=2Eregi=
ster_dns &amp;&amp; tt-&gt;options=2Emsg_channel)</span><br><span>     {</s=
pan><br><span>@@ -5460,7 +5462,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-tuntap_get_mtu(struct tuntap *tt)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+tuntap_get_mtu(const struct tuntap *tt)</span><br><span>=
 {</span><br><span>     ULONG mtu =3D 0;</span><br><span>     DWORD len;</s=
pan><br><span>@@ -6035,7 +6037,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tu=
n_show_debug(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+tun_show_debug(const struct tuntap *tt)</span><br><span> {</spa=
n><br><span>     if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOW=
S6)</span><br><span>     {</span><br><span>@@ -6295,13 +6297,13 @@</span><b=
r><span> }</span><br><span> </span><br><span> ssize_t</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, =
int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(c=
onst struct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</sp=
an><br><span>     return write(tt-&gt;fd, buf, len);</span><br><span> }</sp=
an><br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tunt=
ap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     retu=
rn read(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span>diff --git=
 a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh</span><br><span>index 7340e7e=
=2E=2E61fe943 100644</span><br><span>--- a/src/openvpn/tun=2Eh</span><br><s=
pan>+++ b/src/openvpn/tun=2Eh</span><br><span>@@ -272,9 +272,9 @@</span><br=
><span> </span><br><span> void close_tun_handle(struct tuntap *tt);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssize_t wri=
te_tun(struct tuntap *tt, uint8_t *buf, int len);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ssize_t write_tun(const struct tuntap *tt, co=
nst uint8_t *buf, int len);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-ssize_t read_tun(struct tuntap *tt, uint8_t *buf, i=
nt len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t rea=
d_tun(const struct tuntap *tt, uint8_t *buf, int len);</span><br><span> </s=
pan><br><span> #ifdef ENABLE_FEATURE_TUN_PERSIST</span><br><span> void tunc=
fg(const char *dev, const char *dev_type, const char *dev_node, int persist=
_mode,</span><br><span>@@ -293,7 +293,7 @@</span><br><span>                =
         const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 / I=
Pv6 */</span><br><span>                         int ifconfig_ipv6_netbits_p=
arm,           /* --ifconfig parm 1 / bits */</span><br><span>             =
            const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 =
/ IPv6 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
            struct addrinfo *local_public, struct addrinfo *remote_public,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    const struct addrinfo *local_public, const struct addrinfo *remote_publ=
ic,</span><br><span>                         const bool strict_warn, struct=
 env_set *es, openvpn_net_ctx_t *ctx,</span><br><span>                     =
    struct tuntap *tt);</span><br><span> </span><br><span>@@ -320,7 +320,7 =
@@</span><br><span>  * @param tt    the tuntap interface context</span><br>=
<span>  * @param ctx   the networking API opaque context</span><br><span>  =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void undo_ifconfig(=
struct tuntap *tt, openvpn_net_ctx_t *ctx);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void undo_ifconfig(const struct tuntap *tt, openvpn=
_net_ctx_t *ctx);</span><br><span> </span><br><span> bool is_dev_type(const=
 char *dev, const char *dev_type, const char *match_type);</span><br><span>=
 </span><br><span>@@ -351,7 +351,7 @@</span><br><span> #define IFCONFIG_DEF=
AULT IFCONFIG_AFTER_TUN_OPEN</span><br><span> </span><br><span> static inli=
ne int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_order(=
struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
fconfig_order(const struct tuntap *tt)</span><br><span> {</span><br><span> =
    if (tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {<=
/span><br><span>@@ -381,7 +381,7 @@</span><br><span> #define ROUTE_ORDER_DE=
FAULT ROUTE_AFTER_TUN</span><br><span> </span><br><span> static inline int<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-route_order(struct tun=
tap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+route_order=
(const struct tuntap *tt)</span><br><span> {</span><br><span>     if (tt-&g=
t;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><sp=
an>@@ -454,13 +454,13 @@</span><br><span> </span><br><span> const char *tap=
_win_getinfo(const struct tuntap *tt, struct gc_arena *gc);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void tun_show_debug=
(struct tuntap *tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void tun_show_debug(const struct tuntap *tt);</span><br><span> </span><br>=
<span> bool dhcp_release_by_adapter_index(const DWORD adapter_index);</span=
><br><span> </span><br><span> bool dhcp_renew_by_adapter_index(const DWORD =
adapter_index);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void fork_register_dns_action(struct tuntap *tt);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void fork_register_dns_action(con=
st struct tuntap *tt);</span><br><span> </span><br><span> void ipconfig_reg=
ister_dns(const struct env_set *es);</span><br><span> </span><br><span>@@ -=
470,7 +470,7 @@</span><br><span> </span><br><span> int tun_read_queue(struc=
t tuntap *tt, int maxsize);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-int tun_write_queue(struct tuntap *tt, struct buffe=
r *buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int tun_wri=
te_queue(struct tuntap *tt, const struct buffer *buf);</span><br><span> </s=
pan><br><span> static inline bool</span><br><span> tuntap_stop(int status)<=
/span><br><span>@@ -499,7 +499,7 @@</span><br><span>     return false;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-int tun_write_win32(struct tuntap *tt, struct buffer *buf);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+int tun_write_win32(stru=
ct tuntap *tt, const struct buffer *buf);</span><br><span> </span><br><span=
> static inline bool</span><br><span> is_ip_packet_valid(const struct buffe=
r *buf)</span><br><span>@@ -529,19 +529,21 @@</span><br><span> }</span><br>=
<span> </span><br><span> static inline bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-tuntap_is_dco_win(struct tuntap *tt)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win(const struct tunta=
p *tt)</span><br><span> {</span><br><span>     return tt &amp;&amp; tt-&gt;=
backend_driver =3D=3D DRIVER_DCO;</span><br><span> }</span><br><span> </spa=
n><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeou=
t(const struct tuntap *tt, ssize_t status)</span><br><span> {</span><br><sp=
an>     return tuntap_is_dco_win(tt) &amp;&amp; (status &lt; 0) &amp;&amp; =
(openvpn_errno() =3D=3D ERROR_NETNAME_DELETED);</span><br><span> }</span><b=
r><span> </span><br><span> #else  /* ifdef _WIN32 */</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+// cppcheck-suppress-beg=
in constParameterPointer ; stubs</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> static inline bool</span><br><span> tuntap_s=
top(int status)</span><br><span> {</span><br><span>@@ -565,19 +567,20 @@</s=
pan><br><span>     return true;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inl=
ine bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco=
_win(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+tuntap_is_dco_win(const struct tuntap *tt)</span><br><span> {</span><br=
><span>     return false;</span><br><span> }</span><br><span> </span><br><s=
pan> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(const =
struct tuntap *tt, ssize_t status)</span><br><span> {</span><br><span>     =
return false;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+// cppcheck-suppress-end constParameterPoint=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 #endif /* ifdef _WIN32 */</span><br><span> </span><br><span> /*</span><br>=
<span>diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec<=
/span><br><span>index f494d42=2E=2E79d706a 100644</span><br><span>--- a/src=
/openvpn/tun_afunix=2Ec</span><br><span>+++ b/src/openvpn/tun_afunix=2Ec</s=
pan><br><span>@@ -49,7 +49,7 @@</span><br><span> </span><br><span> </span><=
br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, struct env_s=
et *env)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_afunix_=
exec_child(const char *dev_node, struct tuntap *tt, const struct env_set *e=
nv)</span><br><span> {</span><br><span>     const char *msgprefix =3D &quot=
;ERROR: failure executing process for tun:&quot;;</span><br><span>     stru=
ct argv argv =3D argv_new();</span><br><span>@@ -74,7 +74,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-open_tun_afunix(struct options *o, int mtu, struct=
 tuntap *tt, struct env_set *orig_env)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+open_tun_afunix(const struct options *o, int mtu, struct=
 tuntap *tt, const struct env_set *orig_env)</span><br><span> {</span><br><=
span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><spa=
n>@@ -146,7 +146,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun_afu=
nix(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+write_tun_afunix(struct tuntap *tt, const uint8_t=
 *buf, int len)</span><br><span> {</span><br><span>     const char *msg =3D=
 &quot;ERROR: failure during write to AF_UNIX socket: &quot;;</span><br><sp=
an>     if (!openvpn_waitpid_check(tt-&gt;afunix=2Echildprocess, msg, M_WAR=
N))</span><br><span>@@ -172,8 +172,11 @@</span><br><span>     return read(t=
t-&gt;fd, buf, len);</span><br><span> }</span><br><span> #else  /* ifndef W=
IN32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+// cppcheck-suppress-begin cons=
tParameterPointer ; stubs</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struc=
t env_set *orig_env)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+open_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, const=
 struct env_set *orig_env)</span><br><span> {</span><br><span>     msg(M_ER=
R, &quot;AF_UNIX socket support not available on this platform&quot;);</spa=
n><br><span> }</span><br><span>@@ -186,7 +189,7 @@</span><br><span> }</span=
><br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun_afunix(str=
uct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><=
span>     /* should never be called as open_tun_afunix always fails */</spa=
n><br><span>     ASSERT(0);</span><br><span>@@ -199,4 +202,6 @@</span><br><=
span>     ASSERT(0);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+// cppcheck-suppress-end constParamet=
erPointer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> #endif /* ifndef WIN32 */</span><br><span>diff --git a/src/openvpn/=
tun_afunix=2Eh b/src/openvpn/tun_afunix=2Eh</span><br><span>index 5b6a8e0=
=2E=2E5307e31 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Eh</span=
><br><span>+++ b/src/openvpn/tun_afunix=2Eh</span><br><span>@@ -31,7 +31,7 =
@@</span><br><span>  * the user provided taking care of implementing the ac=
tual tun</span><br><span>  * device=2E</span><br><span>  */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void open_tun_afunix(struct options *=
o, int mtu, struct tuntap *tt, struct env_set *env);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void open_tun_afunix(const struct options=
 *o, int mtu, struct tuntap *tt, const struct env_set *env);</span><br><spa=
n> </span><br><span> </span><br><span> /**</span><br><span>@@ -43,7 +43,7 @=
@</span><br><span> /**</span><br><span>  * Writes a packet to a AF_UNIX bas=
ed tun device=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-ssize_t write_tun_afunix(struct tuntap *tt, uint8_t *buf, i=
nt len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t wri=
te_tun_afunix(struct tuntap *tt, const uint8_t *buf, int len);</span><br><s=
pan> </span><br><span> /**</span><br><span>  * Reads a packet from a AF_UNI=
X based tun device=2E</span><br><span>diff --git a/src/openvpn/vlan=2Ec b/s=
rc/openvpn/vlan=2Ec</span><br><span>index 69ac10d=2E=2E04e18d6 100644</span=
><br><span>--- a/src/openvpn/vlan=2Ec</span><br><span>+++ b/src/openvpn/vla=
n=2Ec</span><br><span>@@ -288,7 +288,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-vlan_process_outgoing_tun(struct multi_context *m, struct multi_instanc=
e *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vlan_process_=
outgoing_tun(const struct multi_context *m, struct multi_instance *mi)</spa=
n><br><span> {</span><br><span>     if (!m-&gt;top=2Eoptions=2Evlan_tagging=
)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/vlan=2Eh =
b/src/openvpn/vlan=2Eh</span><br><span>index 9389f89=2E=2Ecd2f66f 100644</s=
pan><br><span>--- a/src/openvpn/vlan=2Eh</span><br><span>+++ b/src/openvpn/=
vlan=2Eh</span><br><span>@@ -35,6 +35,6 @@</span><br><span> </span><br><spa=
n> bool vlan_is_tagged(const struct buffer *buf);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void vlan_process_outgoing_tu=
n(struct multi_context *m, struct multi_instance *mi);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void vlan_process_outgoing_tun(const str=
uct multi_context *m, struct multi_instance *mi);</span><br><span> </span><=
br><span> #endif /* VLAN_H */</span><br><span>diff --git a/src/openvpn/win3=
2=2Eh b/src/openvpn/win32=2Eh</span><br><span>index 8be3d96=2E=2E39ff7d8 10=
0644</span><br><span>--- a/src/openvpn/win32=2Eh</span><br><span>+++ b/src/=
openvpn/win32=2Eh</span><br><span>@@ -227,7 +227,7 @@</span><br><span> void=
 overlapped_io_close(struct overlapped_io *o);</span><br><span> </span><br>=
<span> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-overlapped_io_active(struct overlapped_io *o)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+overlapped_io_active(const struct overlapped_=
io *o)</span><br><span> {</span><br><span>     return o-&gt;iostate =3D=3D =
IOSTATE_QUEUED || o-&gt;iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;</span><br>=
<span> }</span><br><span>diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/s=
rc/openvpnmsica/openvpnmsica=2Ec</span><br><span>index 1a17d95=2E=2Ed2fd9af=
 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica=2Ec</span><br><=
span>+++ b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>@@ -77,7 +77,7=
 @@</span><br><span>  * @return ERROR_SUCCESS on success; An error code oth=
erwise</span><br><span>  */</span><br><span> static UINT</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-setup_sequence(_In_ MSIHANDLE hInstall, =
_In_z_ LPCWSTR szProperty, _In_ struct msica_arg_seq *seq)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+setup_sequence(_In_ MSIHANDLE hInsta=
ll, _In_z_ LPCWSTR szProperty, _In_ const struct msica_arg_seq *seq)</span>=
<br><span> {</span><br><span>     UINT uiResult;</span><br><span>     LPWST=
R szSequence =3D msica_arg_seq_join(seq);</span><br><span>diff --git a/src/=
openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><sp=
an>index 9a68bbb=2E=2Ed8cf6e1 100644</span><br><span>--- a/src/openvpnserv/=
interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span=
><br><span>@@ -522,7 +522,7 @@</span><br><span> </span><br><span> </span><b=
r><span> static SOCKADDR_INET</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-sockaddr_inet(short family, inet_address_t *addr)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+sockaddr_inet(short family, const ine=
t_address_t *addr)</span><br><span> {</span><br><span>     SOCKADDR_INET sa=
_inet;</span><br><span>     ZeroMemory(&amp;sa_inet, sizeof(sa_inet));</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tes=
ts/unit_tests/openvpn/mock_management=2Ec</span><br><span>index 77f6ce2=2E=
=2Efff4c2b 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_manag=
ement=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2E=
c</span><br><span>@@ -36,7 +36,7 @@</span><br><span> struct management *man=
agement; /* GLOBAL */</span><br><span> </span><br><span> void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-management_auth_failure(struct mana=
gement *man, const char *type, const char *reason)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+management_auth_failure(const struct managem=
ent *man, const char *type, const char *reason)</span><br><span> {</span><b=
r><span>     ASSERT(false);</span><br><span> }</span><br><span>diff --git a=
/tests/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/si=
phash_openssl=2Ec</span><br><span>index 52f13b8=2E=2Ee7282b2 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span=
>+++ b/tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>@@ -100=
,7 +100,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-siphash_openssl_available=
(void *sip_context)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
siphash_openssl_available(const void *sip_context)</span><br><span> {</span=
><br><span>     const struct siphash_context *sip =3D sip_context;</span><b=
r><span> </span><br><span>@@ -117,6 +117,8 @@</span><br><span> }</span><br>=
<span> #else</span><br><span> /* Do avoid a lot more ifdefs in the test we =
put dummy functions here */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+// cppcheck-suppress-begin constParameterPointer ; stubs</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><b=
r><span> siphash_openssl(void *sip_context, const void *in, const size_t in=
len,</span><br><span>                 const void *k, uint8_t *out, const si=
ze_t outlen)</span><br><span>@@ -125,7 +127,7 @@</span><br><span> }</span><=
br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-siphash_openssl_available(void *sip_context)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_available(const void *s=
ip_context)</span><br><span> {</span><br><span>     return false;</span><br=
><span> }</span><br><span>@@ -141,5 +143,6 @@</span><br><span> {</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+// cppcheck-suppress-end constParameterPointer</span><br><span> </sp=
an><br><span> #endif /* if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSS=
L_VERSION_NUMBER &gt;=3D 0x30000000L */</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</=
span><br><span>index 8d88943=2E=2Eaea40f0 100644</span><br><span>--- a/test=
s/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_misc=2Ec</span><br><span>@@ -146,7 +146,7 @@</span><br><span> }=
</span><br><span> </span><br><span> static struct hash_element *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-hash_lookup_by_value(struct hash=
 *hash, void *value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+hash_lookup_by_value(struct hash *hash, const void *value)</span><br><span=
> {</span><br><span>     struct hash_iterator hi;</span><br><span>     stru=
ct hash_element *he;</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br>=
<span>index c0a0866=2E=2E7636a33 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_user_pass=2Ec</span><br><span>+++ b/tests/unit_tests/openv=
pn/test_user_pass=2Ec</span><br><span>@@ -59,7 +59,7 @@</span><br><span>   =
  return mock();</span><br><span> }</span><br><span> void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-management_auth_failure(struct manageme=
nt *man, const char *type, const char *reason)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+management_auth_failure(const struct management =
*man, const char *type, const char *reason)</span><br><span> {</span><br><s=
pan>     assert_true(0);</span><br><span> }</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">=
change 1663</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/166=
3?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1663 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 33 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--BirTy59K7JQ=--


--===============2269079378324963013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2269079378324963013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2269079378324963013==--

