Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C5606A32E
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iHRESHH+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m+Jdyw6s;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JjNc/F+T;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=d29nbkou
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gbkAl5MHONzg4ho04LmXYG8MO4TS1QW37B5vPsUrBlo=; b=iHRESHH+01Fh+TqqltZBldGw3l
	QQdWK0roxSTK5casMdFIcIkwEQ1r1c1tnGWQ/cBMwmi1NLSo1YzFMWAI6+lnSvVnUosYr/HO0oj7s
	HZtB4FTNO3qJdAvEZ8s18mtdLrlpkJW/pC/Km4JUWbUV8AfFuXpX7a+Itq7z0/LXrJV4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGSn-000000005xg-0Wis;
	Tue, 03 Nov 2026 15:30:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOGSl-000000005xZ-1g4d
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:30:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UfzPwBv2h7BuGil7DWuopunrpqQsNdWwKXs9CMHAs9Q=; b=m+Jdyw6sZ7E+PHORkzIp+0FBq+
 roj9BBkjo0xMezRb7RPwYfpIqUtf1wVKjfrHLvOdgw2fsuwoPiIokwvYRk1PQGYUyH0KW72n2zmEq
 3UAaUhDie6qJKli736k1TLqWvBqm3J1gPurwQ1vqXtjtWdo0bG3XzmPfd1HshhEvuM8Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UfzPwBv2h7BuGil7DWuopunrpqQsNdWwKXs9CMHAs9Q=; b=JjNc/F+TSdL8FMbDUMHi3WTHFE
 IsBr+Oge/PF6q+dyx88gLDAQHqLvB8Mm0OX518zaAiGTO+gLfaowgkPy6/Qp9BtjpiZrl7uFhwc+m
 qxyDadaJIe8KZEpx/Iy9B4s6Z/dAfShmOCsD2Y4bcHlryWmCbnFd/U5QD/ROGDBPYgo8=;
Received: from mail-lj1-f180.google.com ([209.85.208.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOGSd-0000000083h-3kuu for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:30:15 +0000
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-3ac8c03cea4so37174781fa.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 07:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793719801; x=1794324601; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UfzPwBv2h7BuGil7DWuopunrpqQsNdWwKXs9CMHAs9Q=;
 b=d29nbkoumG2m0lSowHdHMV79D3EuTb1i5v6+mTu8ZcNl++hTGzt9h5qmtO4YHfJVv2
 AmpgpNnPo2IAfhtjPGoZhjl2Txocojpt4fwluuCL06a4wvgdnS0G7c+64PPfFlJ8p+5a
 ciBFt5yM05Vy2ZT8uMTHanKd0lwaQ9QIRtR+4ShNPjCZ2+dkH3c+KXwBHdzwx4HUT6bx
 BA93YEgfPUFtGMotlwZV1KsVEVi5FtgYQ8r1xlRtuq+ggkGU8EYSDuvas5tqGjbosd4e
 W32tvhWejavpL5SbjloxhQTuBu4VVZvfDTXn9myxUgVNZNVy2hY3FoAqEAVPoGYLZm56
 93Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793719801; x=1794324601;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UfzPwBv2h7BuGil7DWuopunrpqQsNdWwKXs9CMHAs9Q=;
 b=IxmYSsOSq4sZy9lesv7b4JDUC4TLeu6lO4R2ispc0nIABSLLAj4eTIboCAgEcgweSA
 PnOr7THg8Q43/3FeUFwdza4w8YzE9g3HFOqK0oN69PTN6p264hRbG/iMqDC2VoBuFSN9
 GbDtN9yPlu0AH42FDUUdO2YiRMiShydx96+EAeMhGm5jEnGaLWVU3HOVA2UW3PWf4BE3
 01tPCNz1jCArLxelMB2cB0trJaRnkxPcTNH4AleGHTF8sWkDJZQuJz6VajWNWInBf7Cd
 fw52Cn16iNI7u9yvVmxbvrIY2Mx/3c74J3R29hmvku2eTiUnFUwOYHlTdspAtlL4v7y4
 cs+w==
X-Gm-Message-State: APuU4Z9xE8uX7qigr+9HCurQ4suwdcFzc0lcCChxbRKqvRrsBRzIFZrt
 aJ/56pbe5VTgR5vKbG62q4RF53Legn6EQNRj/f9J6/WY79Ex91rKUUqIg9/7PFNy7MzEOUCjKIg
 /magFXlKjbz1sAZRDxg6VL77UlmBvx1rDVvEyQ9ou9CWgfB4JwPl9QsRCDxMm9gE0ZGxbS56TMi
 f4d6OE5w==
X-Gm-Gg: AYBFou28wmtTnyEeU7Lr/qa2dGkKVQsXitt9DWTt6IaQwDEcUf0PTGLfeXQsUa88d35
 M2ppnCoyMQG7/x1WPD8qcsdd4DJLrBXIGt3KAJElnZ+376zYSzYiDAiIYQgrfkJHeGzR+6YEPbK
 GMd3rtOEFnhbR1Wj/sY36MLGSZn1LN6hBWrVLm33nP9dkB3kRTBd6GXqawNCH1RG/Tk2RIg/JG+
 dWLsPM7v3RO0wgZC+qY7NYgC7fy8O0iv91J4on8Yu6cShmWHw/sH7Sc86KPPM34U+WxLjAw5WuS
 faronot9+qQygsKilCl9kFI3TP6ltkIEHDYw7sjBa+4ajaQHimbpmBtp611Yl02A6JiidmXsnjT
 tHNk2z0PaJcab/MPzrOln0unVc6tqwXLZuUfeO0u/YGvR/oWhOrIOG9fjnin/RjwagV8WCyuO+M
 X8RprvAXJbf0coubg0HPKvB2Ya207gaJ/XYQmhbypburK1Uk8iW9zmmiD/TYP24jhYfB8VlSwbS
 oCVEjCxhZ//JgcgvSJ+XrhZzsI4Voh0+yC7cyXHgBRZkBwRbNG5Yv+asPo8CxKY/HOrzIBsP7AJ
 EC80f99EvqGGqoDDgQJvki1RikjKwvg+nQuxJ1kRkYDnRVYYgTYsz3kKvq4H4HttJM0RMEBiXXY
 k8z84ZFbCAjjZBMLFbwVAQi/LcJLBmVw2iWraV7MjROmMujkzl8cpaVcjjNugkRepAFNs3qAjqz
 Q1CqLFlKBqTkHI/g==
X-Received: by 2002:a05:6512:3056:b0:5b8:f3b2:429b with SMTP id
 2adb3069b0e04-5bfd957d6a9mr4939414e87.52.1793719412343; 
 Tue, 03 Nov 2026 07:23:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm27443142f8f.55.2026.11.03.07.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:23:31 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 15:23:29 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 chugly <charlie.vigue@openvpn.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 28d5ceca04fdb5138b77c81df8e7982a06f49c5f
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <068b8ded6e7c02f271c8d6edab4e8b8c0595b76a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOGSd-0000000083h-3kuu
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2065156662369645338=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2065156662369645338==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Mqa+Z/xrNKg="; charset=UTF-8

--Mqa+Z/xrNKg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#26) to the change originally cr=
eated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?=
usp=3Demail )

The following approvals got outdated and were removed:
Code-=
Review+1 by chugly, Code-Review+2 by R=C4=83zvan Cojocaru


Change subject:=
 Implement sending/receiving app custom control protocol messages
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Implement sending/rece=
iving app custom control protocol messages

This allows openvpn GUI/front-e=
nds and server via management
to use the OpenVPN control channel to pass me=
ssages between each other
while OpenVPN handles the marshalling/unmarshalli=
ng of these and
negotiate the common app custom control protocols=2E

This =
provides an easy to use secure channel that does not depend on
the network =
itself to work and can also be used before fully
authenticating the client=
=2E See the management-notes=2Etxt for more
details how to use this feature=
=2E An upcoming patch will also add
some example python scripts that showca=
se this feature=2E

Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Si=
gned-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1858
Message-Id: <20261030170320=2E6133-1-gert@greenie=2Emuc=2Ede>
URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
40353=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CM=
akeLists=2Etxt
M doc/man-sections/client-options=2Erst
M doc/man-sections/m=
anagement-options=2Erst
M doc/man-sections/script-options=2Erst
M doc/manag=
ement-notes=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/acc=2Ec
A src/o=
penvpn/acc=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/init=2Ec
M src/openv=
pn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/multi=2Ec
M src/openvp=
n/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/push=2Ec
M src/openvp=
n/push=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M tests/unit_=
tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/mock_management=2Ec
=
M tests/unit_tests/openvpn/mock_push_dependencies=2Ec
A tests/unit_tests/op=
envpn/test_acc=2Ec
A tests/unit_tests/openvpn/test_acc=2Eh
M tests/unit_tes=
ts/openvpn/test_common=2Eh
M tests/unit_tests/openvpn/test_ssl=2Ec
26 files=
 changed, 1,547 insertions(+), 23 deletions(-)


  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/58/1858/26

diff --git a/CMakeList=
s=2Etxt b/CMakeLists=2Etxt
index 5eb678b=2E=2E5cf1a30 100644
--- a/CMakeLis=
ts=2Etxt
+++ b/CMakeLists=2Etxt
@@ -434,6 +434,8 @@
     src/compat/compat-=
strlcpy=2Ec
     src/compat/compat-strsep=2Ec
     src/compat/compat-strtok=
_r=2Ec
+    src/openvpn/acc=2Ec
+    src/openvpn/acc=2Eh
     src/openvpn/a=
rgv=2Ec
     src/openvpn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -821,6 +82=
3,8 @@
             tests/unit_tests/openvpn/mock_management=2Ec
          =
   tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
             tests/un=
it_tests/openvpn/mock_win32_execve=2Ec
+            tests/unit_tests/openvp=
n/test_acc=2Ec
+            src/openvpn/acc=2Ec
             src/openvpn/ar=
gv=2Ec
             src/openvpn/base64=2Ec
             src/openvpn/crypto_=
epoch=2Ec
@@ -836,6 +840,7 @@
             src/openvpn/packet_id=2Ec
      =
       src/openvpn/run_command=2Ec
             src/openvpn/ssl_mbedtls=2Ec=

+            src/openvpn/ssl_ncp=2Ec
             src/openvpn/ssl_openssl=
=2Ec
             src/openvpn/ssl_util=2Ec
             src/openvpn/ssl_ver=
ify_mbedtls=2Ec
diff --git a/doc/man-sections/client-options=2Erst b/doc/ma=
n-sections/client-options=2Erst
index 87c138a=2E=2E16309f9 100644
--- a/doc=
/man-sections/client-options=2Erst
+++ b/doc/man-sections/client-options=2E=
rst
@@ -437,6 +437,12 @@
         Additional authentication methods support=
ed by the client=2E
         This may be set by the client UI/GUI using ``-=
-setenv``=2E
 
+  :code:`IV_ACC=3D<max_msg_len>,<flags>,<protocols>`
+     =
   If the option ``--app-custom-control`` is set, the client will
+        =
send the supported max ACC message length, the supported formats
+        a=
s (:code:`A:6`) and the list of configured protocols (e=2Eg=2E
+        :co=
de:`flower:happy:power`)
+
   The following flags depend on which compressi=
on formats are compiled in
   and whether compression is allowed by options=
=2E See `Protocol options`_
   for more details=2E
diff --git a/doc/man-sec=
tions/management-options=2Erst b/doc/man-sections/management-options=2Erst
=
index 8dad52b=2E=2Eba0468b 100644
--- a/doc/man-sections/management-options=
=2Erst
+++ b/doc/man-sections/management-options=2Erst
@@ -134,3 +134,17 @@=

 
 --management-up-down
   Report tunnel up/down events to management inte=
rface=2E
+
+--app-custom-control protocol-list
+  Sets the list of supporte=
d app custom control protocols=2E
+  These protocols are announced to the s=
erver via the IV_ACC peer info
+  variable when this option is used on a cl=
ient=2E
+  If the option is set on a server it will negotiate common protoc=
ols
+  with the client=2E
+
+  The protocol-list is a : separated list of p=
rotocol identifiers=2E Protocol
+  identifiers must consist of alphanumeric=
 characters, :code:`-`, and
+  :code:`_`=2E
+
+  See management-notes=2Etxt=
 in the OpenVPN distribution and the OpenVPN RFC
+  draft for a description=
 of app custom control protocol support=2E
diff --git a/doc/man-sections/sc=
ript-options=2Erst b/doc/man-sections/script-options=2Erst
index f420380f=
=2E=2E474c7fd 100644
--- a/doc/man-sections/script-options=2Erst
+++ b/doc/=
man-sections/script-options=2Erst
@@ -1006,3 +1006,12 @@
        X509_1_L=
=3DBISHKEK
        X509_1_ST=3DNA
        X509_1_C=3DKG
+
+:code:`acc_proto=
cols`
+    If ``--app-custom-control`` is configured and the client support=
s any of the
+    protocols that server also supports, this variable contai=
ns a list of
+    common protocols separated by :=2E
+
+:code:`acc_message_=
len`
+    if :code:`acc_protocols` is set, this variable contains the maxim=
um
+    message length for app custom protocol message=2E
diff --git a/doc/=
management-notes=2Etxt b/doc/management-notes=2Etxt
index b9b367f=2E=2E6c79=
8c0 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etx=
t
@@ -853,6 +853,59 @@
 that is required to continue the connection (unlike=
 MFA or opening a browser)
 this message is not negotiated but can just be =
sent as a gratuitous message=2E
 
+app custom control
+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+If the special string "ACC" is passed=
 as {EXTRA} OpenVPN will determine
+the common app custom protocols between=
 the client and the server and instruct
+the client that the server will se=
nd control messages to the client using
+the ACC protocol=2E
+
+The server =
should then use client-acc-msg command to send app custom
+control messages=
 to the client to facilitate the pending authentication=2E
+
+COMMAND -- cl=
ient-acc-msg (OpenVPN 2=2E8 or higher)
+-----------------------------------=
--------------
+
+On an OpenVPN instance running in server mode this comman=
d sends an
+app custom control message to a client=2E The format of the com=
mand is:
+
+  client-acc-msg {CID} {KID}
+  {protocol}
+  {flags}
+  {messa=
ge}
+  END
+
+CID,KID -- client ID and Key ID=2E See documentation for ">CL=
IENT:"
+notification for more info=2E
+
+protocol -- the ACC protocol ident=
ifier that this message should be
+            tagged with=2E
+
+flags    -=
- a concatenation of letters for the encoding ('A' or '6')
+            and=
 the lette 'F' if the message is a fragment=2E E=2Eg=2E
+            "6F" f=
or a base64 encoded message that is also a fragment
+            and not co=
mplete yet=2E
+
+message  -- The message encoded in the encoding specified =
in flags
+
+
+COMMAND -- acc-msg (OpenVPN 2=2E8 or higher)
+---------------=
---------------------------
+
+When OpenVPN is running in --client mode thi=
s command sends an app
+custom command to the server=2E The format of the c=
ommand is
+
+  acc-msg
+  {protocol}
+  {flags}
+  {message}
+  END
+
+See =
the client-acc-msg command for more details about the format of the
+messag=
e=2E Since a client has only one peer there is no need to specify the
+clie=
nt id and key id=2E
+
+
 COMMAND -- client-deny  (OpenVPN 2=2E1 or higher)
=
 -----------------------------------------------
 
@@ -1327,6 +1380,52 @@
 =
   response=2E Mechanisms that need multiple rounds or more complex answers=

    should implement a different response type than CR_RESPONSE=2E
 
+(6) =
App custom control message
+
+    This message is an application specific p=
ayload message that is transported
+    over the OpenVPN control channel=2E=

+
+    In server mode:
+
+    >CLIENT:ACC,{CID},{KID},{protocol},{fragment=
},{msg_base64}
+
+    In client mode:
+
+    >ACC:{protocol},{fragment},{ms=
g_base64}
+
+    The protocol is a short ascii string identifying the app s=
pecific custom
+    protocol=2E If fragment is set to 1, the message is not=
 complete and the
+    next message should be concatenated to this message =
to form a complete
+    message=2E
+
+    Note that the OpenVPN implementat=
ion operates here with the robustness
+    principle ("be conservative in w=
hat you send, be liberal in what you
+    accept" - RFC 793 and others) and=
 allows receiving messages longer than
+    maximum allowed message length=
=2E Implementations should be prepared to
+    handle messages that are lon=
ger than the maximum allowed message length=2E
+
+    OpenVPN does not veri=
fy that the message is valid base64=2E A peer that
+    sends invalid base6=
4 payload will be passed to the management interface=2E
+    An implementat=
ion should be prepared to handle invalid base64 and
+    handle accordingly=
 (e=2Eg=2E disconnect the client via client-deny or
+    ignore such messag=
es)=2E
+
+(7) App custom control protocol message
+
+   This message inform=
s the client about the common ACC
+   protocols and the maximum message len=
gth for an ACC message=2E
+
+   In client mode:
+
+   >ACC_PROTOCOLS:protoc=
ols=3D{protocol_list},message_len=3D{max_msg_len}
+
+   protocol_list is th=
e list of supported protocols by both server and client=2E
+   For example =
flower:power:sys_info would indicate these three protocols
+   are supporte=
d=2E max_msg_len specifies the maximum message length that the
+   peer sup=
ports=2E
+
+   In server mode these information are available in the acc_pr=
otocols and
+   acc_message_len variables of the client environment=2E
 
 V=
ariables:
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=
=2Eam
index d641d927=2E=2Ebb31053 100644
--- a/src/openvpn/Makefile=2Eam
++=
+ b/src/openvpn/Makefile=2Eam
@@ -45,6 +45,7 @@
 sbin_PROGRAMS =3D openvpn
=
 
 openvpn_SOURCES =3D \
+	acc=2Ec acc=2Eh \
 	argv=2Ec argv=2Eh \
 	auth_t=
oken=2Ec auth_token=2Eh \
 	base64=2Ec base64=2Eh \
@@ -122,7 +123,8 @@
 	p=
roto=2Ec proto=2Eh \
 	proxy=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \
-	push=2Ec p=
ush_util=2Ec push=2Eh \
+	push=2Ec push=2Eh \
+	push_util=2Ec \
 	pushlist=
=2Eh \
 	reflect_filter=2Ec reflect_filter=2Eh \
 	reliable=2Ec reliable=2E=
h \
diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
new file mode 10=
0644
index 0000000=2E=2E455f56d
--- /dev/null
+++ b/src/openvpn/acc=2Ec
@@ =
-0,0 +1,445 @@
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
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
=
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This=
 program is free software; you can redistribute it and/or modify
+ *  it un=
der the terms of the GNU General Public License version 2
+ *  as published=
 by the Free Software Foundation=2E
+ *
+ *  This program is distributed in=
 the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without ev=
en the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ =
*
+ *  You should have received a copy of the GNU General Public License al=
ong
+ *  with this program; if not, write to the Free Software Foundation, =
Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
=
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "sy=
shead=2Eh"
+
+#include <string=2Eh>
+#include "buffer=2Eh"
+#include "error=
=2Eh"
+#include "acc=2Eh"
+#include "forward=2Eh"
+#include "options_util=
=2Eh"
+#include "ssl_util=2Eh"
+#include "ssl_ncp=2Eh"
+#include "multi=2Eh=
"
+
+static void
+log_acc_message(struct context *c, const struct buffer *b=
uf, int payload_len,
+                const char *protocol, int flags)
+{
+=
    bool fragment =3D flags & ACC_MESSAGE_FLAGS_FRAGMENT;
+#ifdef ENABLE_MA=
NAGEMENT
+    struct gc_arena gc =3D gc_new();
+    const char *payload_msg=
 =3D NULL;
+
+    /* For simplicity, we always encode payload to be base64 =
encoded
+     * if not already in base64 format */
+    if (flags & ACC_MES=
SAGE_FLAGS_ASCII)
+    {
+        char *b64out =3D NULL;
+        ASSERT(op=
envpn_base64_encode(CBPTR(buf), payload_len, &b64out) >=3D 0);
+        gc_=
addspecial(b64out, free, &gc);
+        payload_msg =3D b64out;
+    }
+   =
 else
+    {
+        payload_msg =3D CBSTR(buf);
+    }
+
+    if (managem=
ent)
+    {
+        struct tls_session *session =3D &c->c2=2Etls_multi->se=
ssion[TM_ACTIVE];
+
+        if (c->options=2Emode =3D=3D MODE_SERVER)
+   =
     {
+            /* server mode=2E Report client context */
+           =
 struct man_def_auth_context *mda =3D session->opt->mda_context;
+         =
   unsigned int mda_key_id =3D get_primary_key(c->c2=2Etls_multi)->mda_key_=
id;
+            msg(M_CLIENT, ">CLIENT:ACC,%lu,%u,%s,%d,%s",
+            =
    mda->cid, mda_key_id, protocol, fragment, payload_msg);
+        }
+   =
     else
+        {
+            /* Client mode=2E Do not a report a CLIEN=
T id */
+            msg(M_CLIENT, ">ACC:%s,%d,%s", protocol, fragment, pay=
load_msg);
+        }
+    }
+    gc_free(&gc);
+#endif /* ifdef ENABLE_MAN=
AGEMENT */
+    msg(D_PUSH, "Received custom app control message (protocol =
'%s'%s)",
+        protocol, fragment ? ", fragment" : "");
+}
+
+
+int
+pa=
rse_acc_message_flags(const char *flags, const char **err_reason, struct gc=
_arena *gc)
+{
+    int acc_flags =3D 0;
+
+    for (const char *flag =3D f=
lags; *flag !=3D '\0'; flag++)
+    {
+        if (*flag =3D=3D 'A')
+     =
   {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;
+        }
+     =
   else if (*flag =3D=3D '6')
+        {
+            acc_flags |=3D ACC_ME=
SSAGE_FLAGS_BASE64;
+        }
+        else if (*flag =3D=3D 'F')
+       =
 {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_FRAGMENT;
+        }
+    =
    else
+        {
+            *err_reason =3D "Unknown flag in flags";
+=
            return -1;
+        }
+    }
+    /* The message should be enco=
ded with exactly one encoding=2E Ensure that
+     * only one of the flags =
is present */
+    bool asciienc =3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_A=
SCII);
+    bool base64enc =3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_BASE64)=
;
+
+    if (base64enc + asciienc !=3D 1)
+    {
+        char *tmp =3D gc_=
malloc(512, 1, gc);
+        snprintf(tmp, 512, "number of encodings must b=
e exactly one "
+                           "(B64=3D%d, ASCII=3D%d)",
+    =
             base64enc, asciienc);
+        *err_reason =3D tmp;
+        r=
eturn -1;
+    }
+
+    return acc_flags;
+}
+
+/**
+ * Wrapper around pars=
e_acc_message_flags to also include the step of
+ * extracting the flags fr=
om the buffer and forwarding the buffer
+ * beyond the flags field=2E
+ */
=
+static int
+parse_acc_message_flags_buf(struct buffer *buf, const char **e=
rr_reason, struct gc_arena *gc)
+{
+    const char *flags =3D buf_extract_f=
ield(buf, ',', gc);
+
+    if (!flags)
+    {
+        *err_reason =3D "cou=
ld not extract flags field";
+        return -1;
+    }
+    return parse_a=
cc_message_flags(flags, err_reason, gc);
+}
+
+void
+receive_acc_message(st=
ruct context *c, const struct buffer *buffer)
+{
+    struct gc_arena gc =
=3D gc_new();
+    const char *err_reason =3D "";
+
+    /* Example message=
: ACC,muppets,15,A,I am Miss Piggy */
+    struct buffer buf =3D *buffer;
+=

+    const struct tls_multi *multi =3D c->c2=2Etls_multi;
+    if (!multi-=
>acc_negotiated_protocols)
+    {
+        err_reason =3D "ACC not enabled =
or no negotiated protocols";
+        goto err;
+    }
+
+    if (!buf_adva=
nce(&buf, strlen("ACC")) || buf_read_u8(&buf) !=3D ',')
+    {
+        err=
_reason =3D "missing , after ACC";
+        goto err;
+    }
+
+    /* extr=
act protocol, payload length, flags substrings */
+    const char *protocol=
 =3D buf_extract_field(&buf, ',', &gc);
+    if (!protocol)
+    {
+       =
 err_reason =3D "could not extract protocol field";
+        goto err;
+   =
 }
+
+    if (!tls_item_in_cipher_list(protocol, multi->acc_negotiated_prot=
ocols))
+    {
+        struct buffer msg_buf =3D alloc_buf_gc(1024, &gc);
=
+        buf_printf(&msg_buf, "protocol '%s' not in list of negotiated prot=
ocols '%s'",
+                   protocol, multi->acc_negotiated_protocols)=
;
+        err_reason =3D buf_cstr(&msg_buf);
+
+
+        goto err;
+    }=

+
+    /* We do not check the length here=2E We make no promises to suppor=
t
+     * anything larger than our announced message length but according t=
o
+     * the robustness principle
+     * ("be conservative in what you se=
nd, be liberal in what you accept" - RFC 793 and others)
+     * we accept =
also longer messages */
+
+    int payload_len;
+    const char *payload_le=
n_str =3D buf_extract_field(&buf, ',', &gc);
+    if (!payload_len_str
+   =
     || !atoi_constrained(payload_len_str, &payload_len, "acc_payload_len",=
 0, TLS_CHANNEL_BUF_SIZE - 1, D_PUSH_ERRORS))
+    {
+        err_reason =
=3D "could not extract payload length field";
+        goto err;
+    }
+
+=
    int flags =3D parse_acc_message_flags_buf(&buf, &err_reason, &gc);
+
+ =
   if (flags < 0)
+    {
+        goto err;
+    }
+
+    /* We should have=
 a final NUL byte in the control message buffer
+     * and thus the length=
 of the buffer should be payload_len + 1 */
+    if (buf_len(&buf) !=3D pay=
load_len + 1)
+    {
+        char *tmp =3D gc_malloc(512, 1, &gc);
+      =
  snprintf(tmp, 512, "field length %d, payload length %d mismatch",
+      =
           payload_len, buf_len(&buf) - 1);
+        err_reason =3D tmp;
+ =
       goto err;
+    }
+
+
+    log_acc_message(c, &buf, payload_len, prot=
ocol, flags);
+    gc_free(&gc);
+    return;
+
+err:
+    msg(D_PUSH_ERROR=
S, "WARNING: Received malformed custom app control channel "
+             =
          "message (%s): %s",
+        err_reason,
+        format_hex(CBPT=
R(buffer), BLEN(buffer), 80, &gc));
+    gc_free(&gc);
+}
+
+
+bool
+send_a=
cc_message(struct context *c,
+                 struct tls_multi *multi,
+ =
                struct tls_session *session,
+                 const char *=
protocol, bool fragment,
+                 const char *acc_msg_payload, boo=
l base64)
+{
+    /*
+     * length of the protocol string + one ','
+     =
* 2 for the encoding (A or 6), potential F (fragment), and 1 for the ',',
+=
     * 4 for the message size itself and one comma
+     * 1 for the comma =
before the message itself */
+    const size_t max_header_size =3D strlen("=
ACC,") + strlen(protocol) + 1 + 4 + 1 + 2 + 1;
+    size_t len =3D max_head=
er_size + strlen(acc_msg_payload);
+
+    if (len > TLS_CHANNEL_BUF_SIZE)
+=
    {
+        msg(M_CLIENT, "message length (%zu) exceeds maximum possible=
 message length (%d)", len, TLS_CHANNEL_BUF_SIZE);
+        return false;
+=
    }
+
+    if ((int)len > multi->acc_max_message_length)
+    {
+        =
msg(M_CLIENT, "header (%zu) + message size (%zu) length (%zu) exceeds "
+  =
                    "maximum allowed length negotiated with peer (%d)",
+  =
          max_header_size, strlen(acc_msg_payload), len,
+            multi=
->acc_max_message_length);
+        return false;
+    }
+
+    struct gc_a=
rena gc =3D gc_new();
+    /* add 1 for the final \0 */
+    struct buffer =
buf =3D alloc_buf_gc(len + 1, &gc);
+
+    /* Example message: ACC,muppets,=
15,A,I am Miss Piggy */
+    buf_printf(&buf, "ACC,%s,%zu,%s%s,%s", protoco=
l,
+               strlen(acc_msg_payload),
+               base64 ? "6" : =
"A",
+               fragment ? "F" : "",
+               acc_msg_payload);=

+
+    bool ret =3D send_control_channel_string_dowork(session, BSTR(&buf)=
, D_PUSH);
+    reschedule_multi_process(c);
+    gc_free(&gc);
+    return=
 ret;
+}
+
+char *
+parse_acc_parameters(const char *capabilities,
+       =
              const char *delim,
+                     int *max_acc_len,
+ =
                    bool server,
+                     struct gc_arena *gc)=

+{
+    char *tmp_message =3D string_alloc(capabilities, NULL);
+    char =
*tmp_message_orig =3D tmp_message;
+    char *lasts =3D NULL;
+
+    const =
char *token =3D strtok_r(tmp_message, delim, &lasts);
+
+    int p =3D 0;
+=
    int acclen =3D 0;
+    const char *protocols =3D NULL;
+    char *ret =
=3D NULL;
+
+    /* In server mode we allow more capabilities than our own,=
 in client
+     * mode we reject if we should use capabilities that we do =
not support */
+    int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_=
LEN;
+
+    while (token)
+    {
+        if (p =3D=3D 0 && !atoi_constrain=
ed(token, &acclen, "ACC message length", ACC_MIN_MSG_LEN, allowed_acc_len, =
D_PUSH_ERRORS))
+        {
+            goto done;
+        }
+
+        if=
 (p =3D=3D 1 && (!tls_item_in_cipher_list("A", token) || !tls_item_in_ciphe=
r_list("6", token)))
+        {
+            msg(D_PUSH_ERRORS, "App custom=
 control encoding must include base64 and ascii");
+            goto done;
=
+        }
+
+        if (p =3D=3D 1 && !server && strcmp(token, "A:6") && =
strcmp(token, "6:A"))
+        {
+            msg(D_PUSH_ERRORS, "App custo=
m control encoding must be exactly base64 and ascii");
+            goto do=
ne;
+        }
+
+        if (p =3D=3D 2)
+        {
+            protocols=
 =3D token;
+        }
+
+        if (p =3D=3D 3)
+        {
+            m=
sg(D_PUSH_ERRORS, "Too many parameters for INFO ACC message/IV_ACC=2E");
+ =
           goto done;
+        }
+
+        token =3D strtok_r(NULL, delim,=
 &lasts);
+        p++;
+    }
+
+    *max_acc_len =3D min_int(acclen, ACC_=
MAX_MSG_LEN);
+    ret =3D string_alloc(protocols, gc);
+
+done:
+    free(=
tmp_message_orig);
+    return ret;
+}
+
+struct buffer
+get_list_intersect=
ion(struct gc_arena *gc, const char *list1, const char *list2)
+{
+    char=
 *tmp =3D string_alloc(list1, NULL);
+    char *lasts =3D NULL;
+    const =
char *token =3D strtok_r(tmp, ":", &lasts);
+
+    /* The maximum possible =
length is the shorter of the two input lists */
+    size_t max_len =3D min=
_size(strlen(list1), strlen(list2));
+
+    struct buffer common_protocols =
=3D alloc_buf_gc(max_len + 1, gc);
+
+    while (token)
+    {
+        /* =
check for every items is in both lists and not already in the
+         * c=
ommon list */
+        if (tls_item_in_cipher_list(token, list2)
+         =
   && !tls_item_in_cipher_list(token, buf_cstr(&common_protocols)))
+      =
  {
+            if (buf_len(&common_protocols) > 0)
+            {
+      =
          buf_write_u8(&common_protocols, ':');
+            }
+           =
 buf_printf(&common_protocols, "%s", token);
+        }
+        token =3D =
strtok_r(NULL, ":", &lasts);
+    }
+    free(tmp);
+    return common_prot=
ocols;
+}
+
+void
+determine_common_acc_protocols(struct tls_multi *multi, =
struct tls_session *session)
+{
+    if (!multi->opt=2Eacc_protocols)
+    =
{
+        /* No app custom protocols have been configured server-side=2E *=
/
+        return;
+    }
+
+    if (multi->acc_negotiated_protocols)
+    =
{
+        /* We already have determined the common protocols=2E */
+      =
  return;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+    /* example =
IV_ACC: IV_ACC=3D2048,6:A,flower:power */
+    const char *peer_info =3D mu=
lti->peer_info;
+    const char *iv_acc =3D extract_var_peer_info(peer_info=
, "IV_ACC=3D", &gc);
+    if (!iv_acc)
+    {
+        gc_free(&gc);
+     =
   return;
+    }
+
+    int max_acc_len =3D 0;
+    const char *protocols =
=3D parse_acc_parameters(iv_acc, ",", &max_acc_len, true, &gc);
+
+    if (=
!protocols)
+    {
+        gc_free(&gc);
+        msg(D_PUSH_ERRORS, "WARN=
ING: IV_ACC peer info variable of peer is malformed");
+        return;
+  =
  }
+
+    struct buffer common_protocols =3D get_list_intersection(&gc, mu=
lti->opt=2Eacc_protocols, protocols);
+
+    if (buf_len(&common_protocols)=
 =3D=3D 0)
+    {
+        msg(D_PUSH_DEBUG, "WARNING: No common app custom=
 control protocol=2E");
+        gc_free(&gc);
+        return;
+    }
+
+ =
   multi->acc_negotiated_protocols =3D string_alloc(buf_str(&common_protoco=
ls), NULL);
+    multi->acc_max_message_length =3D max_acc_len;
+
+    sete=
nv_str(session->opt->es, "acc_protocols", multi->acc_negotiated_protocols);=

+    setenv_int(session->opt->es, "acc_message_len", multi->acc_max_messag=
e_length);
+
+    gc_free(&gc);
+}
+
+void
+notify_client_acc_protocols(str=
uct tls_multi *multi)
+{
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+  =
  {
+        msg(M_CLIENT, ">ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d"=
,
+            multi->acc_negotiated_protocols, multi->acc_max_message_leng=
th);
+    }
+#endif
+}
diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=
=2Eh
new file mode 100644
index 0000000=2E=2E9c99b11
--- /dev/null
+++ b/sr=
c/openvpn/acc=2Eh
@@ -0,0 +1,130 @@
+/*
+ *  OpenVPN -- An application to s=
ecurely tunnel IP networks
+ *             over a single TCP/UDP port, with=
 support for SSL/TLS-based
+ *             session authentication and key e=
xchange,
+ *             packet encryption, packet authentication, and
+ * =
            packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <=
sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eo=
rg>
+ *
+ *
+ *  This program is free software; you can redistribute it and=
/or modify
+ *  it under the terms of the GNU General Public License versio=
n 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This prog=
ram is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FIT=
NESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License f=
or more details=2E
+ *
+ *  You should have received a copy of the GNU Gene=
ral Public License along
+ *  with this program; if not, write to the Free =
Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, =
MA 02110-1301 USA=2E
+ */
+
+#ifndef ACC_H
+#define ACC_H
+
+#include "open=
vpn=2Eh"
+
+#define ACC_MIN_MSG_LEN 64
+#define ACC_MAX_MSG_LEN 1280
+
+/**=

+ * This method parses an app custom control message and delivers it to th=
e
+ * management interface=2E We leave reassembly of fragmented messages to=
 the
+ * management interface=2E
+ *
+ * @param c            The context st=
ruct
+ * @param buffer       Buffer containing the control message with ACC=

+ */
+void
+receive_acc_message(struct context *c, const struct buffer *bu=
ffer);
+
+bool
+send_acc_message(struct context *c,
+                 struc=
t tls_multi *tls_multi,
+                 struct tls_session *session,
+   =
              const char *protocol, bool fragment,
+                 const =
char *msg, bool base64);
+
+
+/**
+ * Parses an info message from the serve=
r that contains app custom control info
+ * information prior to the PUSH_R=
EPLY to be able to use app custom control
+ * protocols before sending
+ *
=
+ * In client mode only allow what we support ourselves=2E In server mode
+=
 * allow also capabilities that we not support ourselves=2E
+ *
+ * @param =
capabilities      The string to parse
+ * @param delim             The deli=
miter to use when parsing the string=2E
+ *                          IV_ACC=
 uses "," as delimiter while the
+ *                          custom-contro=
l PUSH message uses " " as "," is
+ *                          already used=
 to separate different push directives
+ * @param max_acc_len       Set to =
the maximum ACC message length
+ * @param server            Whether we are =
server or client
+ * @param gc                The gc arena to use for alloc=
ating the resulting string
+ * @return                  The resulting proto=
col string or NULL on error
+ */
+char *
+parse_acc_parameters(const char *=
capabilities,
+                     const char *delim,
+                   =
  int *max_acc_len,
+                     bool server,
+                   =
  struct gc_arena *gc);
+
+/**
+ * Parses the IV_ACC of the peer and sets m=
ulti=2Eacc_negotiated_protocols
+ * to the common protocols of server and c=
lient and
+ * multi=2Eacc_max_message_length  to the maximum length of the =
ACC message
+ * support by both server and client=2E
+ *
+ * If there is no=
 common protocol or the client does not support any app custom
+ * protocol=
 multi=2Eacc_negotiated_protocols will be set to NULL=2E
+ *
+ * @param mul=
ti      the multi instance to use the set the app custom protocols=2E
+ * @=
param session    the session to read the client env from
+ */
+void
+determ=
ine_common_acc_protocols(struct tls_multi *multi, struct tls_session *sessi=
on);
+
+/**
+ * Flags returned by the parse_acc_message_flags method
+ */
+=
enum acc_message_flag
+{
+    ACC_MESSAGE_FLAGS_ASCII =3D 1,
+    ACC_MESSA=
GE_FLAGS_BASE64 =3D 2,
+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,
+};
+
+/**
+ =
*  Parses the flags field of an app control message If there is an
+ *  err=
or parsing the flags field the method returns -1 and
+ *  puts the error re=
ason in err_reason
+ */
+int
+parse_acc_message_flags(const char *flags, co=
nst char **err_reason, struct gc_arena *gc);
+
+/**
+ * Calculates the inte=
rsection of two list that are both separated by :
+ * Items in the result w=
ill have the same ordering as in the list1
+ * parameters
+ * @param gc    =
        Returned buffer will be allocated in this gc
+ * @param list1      =
   First list to intersect
+ * @param list2         Second list to intersec=
t=2E
+ * @return A (potentially empty) buffer containing an intersection li=
st
+ */
+struct buffer
+get_list_intersection(struct gc_arena *gc, const ch=
ar *list1, const char *list2);
+
+/**
+ * Notifies a client via management =
interface of the negotiated app
+ * custom protocols
+ * @param multi the t=
ls_multi instance of the connection
+ */
+void
+notify_client_acc_protocols=
(struct tls_multi *multi);
+#endif
diff --git a/src/openvpn/forward=2Ec b/s=
rc/openvpn/forward=2Ec
index 681210d=2E=2Eeb41d03 100644
--- a/src/openvpn/=
forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -42,6 +42,7 @@
 #include "dco=
=2Eh"
 #include "auth_token=2Eh"
 #include "tun_afunix=2Eh"
+#include "acc=
=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -257,11 +258,11 @@
     }
     else if =
(buf_string_match_head_str(buf, "INFO_PRE"))
     {
-        server_pushed_=
info(buf, 8);
+        peer_pushed_info(c, buf, 8);
     }
     else if (bu=
f_string_match_head_str(buf, "INFO"))
     {
-        server_pushed_info(bu=
f, 4);
+        peer_pushed_info(c, buf, 4);
     }
     else if (buf_strin=
g_match_head_str(buf, "CR_RESPONSE"))
     {
@@ -271,6 +272,10 @@
     {
  =
       receive_auth_pending(c, buf);
     }
+    else if (buf_string_match_=
head_str(buf, "ACC"))
+    {
+        receive_acc_message(c, buf);
+    }
 =
    else if (buf_string_match_head_str(buf, "EXIT"))
     {
         receiv=
e_exit_message(c);
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec=

index 6c87865=2E=2Eff3bfe5 100644
--- a/src/openvpn/init=2Ec
+++ b/src/ope=
nvpn/init=2Ec
@@ -56,6 +56,7 @@
 #include "schedule=2Eh"
 #include "options=
_string=2Eh"
 #include "resolve=2Eh"
+#include "acc=2Eh"
 
 #include "memdb=
g=2Eh"
 
@@ -2283,6 +2284,13 @@
         }
     }
 
+    struct tls_multi *=
multi =3D c->c2=2Etls_multi;
+    if (multi && multi->acc_negotiated_protoc=
ols)
+    {
+        buf_printf(&out, " custom-control %d A:6 %s",
+       =
            multi->acc_max_message_length, multi->acc_negotiated_protocols)=
;
+    }
+
     if (BLENZ(&out) > strlen(header))
     {
         msg(D_HAN=
DSHAKE, "%s", BSTR(&out));
@@ -2526,6 +2534,11 @@
         flags |=3D (OPT_=
P_ROUTE | OPT_P_DHCPDNS);
     }
 
+    if (c->options=2Eacc_protocols)
+  =
  {
+        flags |=3D OPT_P_ACC;
+    }
+
     return flags;
 }
 
@@ -273=
4,6 +2747,18 @@
         frame->tun_mtu =3D min_int(frame->tun_max_mtu, c->=
options=2Ece=2Etun_mtu);
     }
 
+    if (found & OPT_P_ACC && c->options=
=2Epushed_acc_negotiated_protocols)
+    {
+        struct tls_multi *multi=
 =3D c->c2=2Etls_multi;
+        free(multi->acc_negotiated_protocols);
+  =
      multi->acc_negotiated_protocols =3D string_alloc(c->options=2Epushed_=
acc_negotiated_protocols, NULL);
+        multi->acc_max_message_length =3D=
 c->options=2Epushed_acc_max_message_length;
+
+        msg(D_PUSH, "OPTION=
S IMPORT: ACC protocols: %s, msg len: %d",
+            multi->acc_negotiat=
ed_protocols, multi->acc_max_message_length);
+        notify_client_acc_pr=
otocols(multi);
+    }
+
     return true;
 }
 
@@ -3356,6 +3381,7 @@
     =
to=2Everify_hash_depth =3D options->verify_hash_depth;
     to=2Everify_has=
h_no_ca =3D options->verify_hash_no_ca;
     memcpy(to=2Ex509_username_fiel=
d, options->x509_username_field, sizeof(to=2Ex509_username_field));
+    to=
=2Eacc_protocols =3D options->acc_protocols;
     to=2Ees =3D c->c2=2Ees;
 =
    to=2Enet_ctx =3D &c->net_ctx;
 
@@ -4310,6 +4336,24 @@
 }
 #endif /* if=
def TARGET_ANDROID */
 
+static bool
+management_acc_msg(void *arg,
+      =
             struct buffer_list *input) /* ownership transferred */
+{
+   =
 struct context *c =3D arg;
+
+    bool ret =3D false;
+    if (buffer_list=
_defined(input) && c->c2=2Etls_multi)
+    {
+        struct tls_multi *mul=
ti =3D c->c2=2Etls_multi;
+        struct tls_session *session =3D &multi->=
session[TM_ACTIVE];
+
+        ret =3D management_send_acc_message(c, multi=
, session, input);
+    }
+
+    buffer_list_free(input);
+    return ret;
=
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 void
@@ -4326,6 +4370,7 @@
    =
     cb=2Eproxy_cmd =3D management_callback_proxy_cmd;
         cb=2Eremote=
_cmd =3D management_callback_remote_cmd;
         cb=2Esend_cc_message =3D =
management_callback_send_cc_message;
+        cb=2Eacc_msg =3D management_a=
cc_msg;
 #ifdef TARGET_ANDROID
         cb=2Enetwork_change =3D management_=
callback_network_change;
 #endif
diff --git a/src/openvpn/manage=2Ec b/src/=
openvpn/manage=2Ec
index 16864c8=2E=2E987af2da 100644
--- a/src/openvpn/man=
age=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -45,8 +45,10 @@
 #include "push=2Eh=
"
 #include "multi=2Eh"
 #include "resolve=2Eh"
+#include "acc=2Eh"
 
 #inc=
lude "memdbg=2Eh"
+#include "ssl_ncp=2Eh"
 
 #ifdef ENABLE_PKCS11
 #include=
 "pkcs11=2Eh"
@@ -1080,6 +1082,35 @@
             }
             break;
 
+=
        case IEC_CLIENT_ACC_MSG:
+            if (man->persist=2Ecallback=
=2Eclient_acc_msg)
+            {
+                bool status =3D (*man->p=
ersist=2Ecallback=2Eclient_acc_msg)(man->persist=2Ecallback=2Earg,
+       =
                                                               man->connect=
ion=2Ein_extra_cid,
+                                                      =
                man->connection=2Ein_extra_kid,
+                          =
                                            man->connection=2Ein_extra);
+ =
               man->connection=2Ein_extra =3D NULL;
+                report=
_command_status(status, "client-acc-msg");
+            }
+            else=

+            {
+                man_command_unsupported("client-acc-msg");=

+            }
+            break;
+
+        case IEC_ACC_MSG:
+         =
   if (man->persist=2Ecallback=2Eacc_msg)
+            {
+                b=
ool status =3D (*man->persist=2Ecallback=2Eacc_msg)(man->persist=2Ecallback=
=2Earg,
+                                                               man=
->connection=2Ein_extra);
+                man->connection=2Ein_extra =3D N=
ULL;
+                report_command_status(status, "acc-msg");
+          =
  }
+            else
+            {
+                man_command_unsupport=
ed("acc-msg");
+            }
+            break;
         case IEC_PK_SIGN=
:
             man->connection=2Eext_key_state =3D EKS_READY;
             =
buffer_list_free(man->connection=2Eext_key_input);
@@ -1204,6 +1235,29 @@
 =
}
 
 static void
+man_client_acc_msg(struct management *man, const char *ci=
d_str,
+                   const char *kid_str)
+{
+    struct man_connecti=
on *mc =3D &man->connection;
+    mc->in_extra_cid =3D 0;
+    mc->in_extra=
_kid =3D 0;
+    if (parse_cid(cid_str, &mc->in_extra_cid)
+        && pars=
e_uint(kid_str, "KID", &mc->in_extra_kid))
+    {
+        mc->in_extra_cmd=
 =3D IEC_CLIENT_ACC_MSG;
+        in_extra_reset(mc, IER_NEW);
+    }
+}
+
=
+static void
+man_acc_msg(struct management *man)
+{
+    struct man_connec=
tion *mc =3D &man->connection;
+    mc->in_extra_cmd =3D IEC_ACC_MSG;
+    =
in_extra_reset(mc, IER_NEW);
+}
+
+static void
 man_client_auth(struct mana=
gement *man, const char *cid_str, const char *kid_str, const bool extra)
 {=

     struct man_connection *mc =3D &man->connection;
@@ -1758,6 +1812,17 @=
@
             man_client_pending_auth(man, p[1], p[2], p[3], p[4]);
      =
   }
     }
+    else if (streq(p[0], "client-acc-msg"))
+    {
+        if=
 (man_need(p, 2, 0))
+        {
+            man_client_acc_msg(man, p[1], =
p[2]);
+        }
+    }
+    else if (streq(p[0], "acc-msg"))
+    {
+    =
    man_acc_msg(man);
+    }
     else if (streq(p[0], "rsa-sig"))
     {
 =
        man_pk_sig(man, "rsa-sig");
@@ -2952,7 +3017,9 @@
                 =
                       "bytes_sent=3D",
                                   =
     "bytes_received=3D",
                                        "session_=
id=3D",
-                                       "session_state=3D" };
+    =
                                   "session_state=3D",
+                   =
                    "acc_protocols=3D",
+                                  =
     "acc_message_len=3D" };
 
     if (env_filter_level =3D=3D 0)
     {
@=
@ -3107,6 +3174,7 @@
     }
 }
 
+
 void
 management_connection_established=
(struct management *man, struct man_def_auth_context *mdac,
               =
                    const struct env_set *es)
@@ -4364,6 +4432,58 @@
     }=

 }
 
+bool
+management_send_acc_message(struct context *c, struct tls_mult=
i *multi, struct tls_session *session,
+                            struct =
buffer_list *input)
+{
+    /* also ensures that are enough inputs in the l=
ist to safely call
+     * buffer_list_peek without extra NULL checks */
+ =
   if (!input || input->size < 3)
+    {
+        msg(M_CLIENT, "not enough=
 input lines for sending acc message, "
+                      "missing pro=
tocol, flag and/or messages lines");
+        return false;
+    }
+
+    s=
truct gc_arena gc =3D gc_new();
+
+    const struct buffer *proto_buf =3D b=
uffer_list_peek(input);
+    const char *protocol =3D string_alloc(CBSTR(pr=
oto_buf), &gc);
+    buffer_list_pop(input);
+
+    const struct buffer *en=
coding_buf =3D buffer_list_peek(input);
+
+    const char *acc_err_reason =
=3D NULL;
+    int acc_flags =3D parse_acc_message_flags(buf_cstr(encoding_=
buf), &acc_err_reason, &gc);
+    if (acc_flags < 0)
+    {
+        msg(M_=
CLIENT, "ERROR: parsing acc message flags failed: %s", acc_err_reason);
+  =
      goto error;
+    }
+
+    buffer_list_pop(input);
+
+    buffer_list_=
aggregate_separator(input, 10000, "");
+    const struct buffer *acc_msg_bu=
f =3D buffer_list_peek(input);
+
+    if (!multi->acc_negotiated_protocols
=
+        || !tls_item_in_cipher_list(protocol, multi->acc_negotiated_protoc=
ols))
+    {
+        msg(M_CLIENT, "ERROR: protocol not in the list of neg=
otiated protocols: %s",
+            np(multi->acc_negotiated_protocols));
=
+        goto error;
+    }
+
+    bool ret =3D send_acc_message(c, multi, =
session, protocol,
+                                acc_flags & ACC_MESSAGE=
_FLAGS_FRAGMENT,
+                                buf_cstr(acc_msg_buf),
+ =
                               acc_flags & ACC_MESSAGE_FLAGS_BASE64);
+    =
gc_free(&gc);
+    return ret;
+error:
+    gc_free(&gc);
+    return false=
;
+}
 #else /* ifdef ENABLE_MANAGEMENT */
 
 #include "win32=2Eh"
diff --gi=
t a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index f2c6916=2E=2E82c0=
caa 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -18=
3,12 +183,19 @@
     int (*n_clients)(void *arg);
     bool (*send_cc_messa=
ge)(void *arg, const char *message, const char *parameter);
     bool (*kil=
l_by_cid)(void *arg, const unsigned long cid, const char *kill_msg);
+
    =
 bool (*client_auth)(void *arg, const unsigned long cid, const unsigned int=
 mda_key_id,
                         const bool auth, const char *reason, =
const char *client_reason,
                         struct buffer_list *cc_=
config); /* ownership transferred */
     bool (*client_pending_auth)(void =
*arg, const unsigned long cid, const unsigned int kid,
                    =
             const char *extra, unsigned int timeout);
     char *(*get_pee=
r_info)(void *arg, const unsigned long cid);
+    bool (*client_acc_msg)(vo=
id *arg,
+                           const unsigned long cid,
+            =
               const unsigned int mda_key_id,
+                           s=
truct buffer_list *msg);
+    bool (*acc_msg)(void *arg,
+                 =
   struct buffer_list *msg);
     bool (*proxy_cmd)(void *arg, const char *=
*p);
     bool (*remote_cmd)(void *arg, const char **p);
 #ifdef TARGET_AND=
ROID
@@ -291,13 +298,15 @@
     struct command_line *in;
     struct buffer=
_list *out;
 
-#define IEC_UNDEF       0
-#define IEC_CLIENT_AUTH 1
+#defin=
e IEC_UNDEF          0
+#define IEC_CLIENT_AUTH    1
 /* #define IEC_CLIENT=
_PF   2 *REMOVED FEATURE* */
-#define IEC_RSA_SIGN    3
-#define IEC_CERTIF=
ICATE 4
-#define IEC_PK_SIGN     5
-#define IEC_PASSWORD    6
+#define IEC_=
RSA_SIGN       3
+#define IEC_CERTIFICATE    4
+#define IEC_PK_SIGN        =
5
+#define IEC_PASSWORD       6
+#define IEC_CLIENT_ACC_MSG 7
+#define IEC_=
ACC_MSG        8
     int in_extra_cmd;
     struct buffer_list *in_extra;
=
     unsigned long in_extra_cid;
@@ -499,6 +508,14 @@
 
 void man_persist_c=
lient_stats(struct management *man, struct context *c);
 
+/** Parses the A=
CC message from the input buffer_list and send to the
+ * session identifie=
d by session and multi
+ */
+struct tls_session;
+struct tls_multi;
+bool
+=
management_send_acc_message(struct context *c, struct tls_multi *multi,
+  =
                          struct tls_session *session, struct buffer_list *=
input);
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /**
diff --git a/src/openv=
pn/multi=2Ec b/src/openvpn/multi=2Ec
index 3f82052=2E=2E3f514d6 100644
--- =
a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -53,6 +53,7 @@
 #inc=
lude "ssl_util=2Eh"
 #include "dco=2Eh"
 #include "reflect_filter=2Eh"
+#in=
clude "acc=2Eh"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -4077,6 +4078,26=
 @@
     }
 }
 
+static const char *
+calculate_app_control_extra(struct mu=
lti_instance *mi, struct gc_arena *gc)
+{
+    struct context *c =3D &mi->c=
ontext;
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+
+    if (!mul=
ti->acc_negotiated_protocols)
+    {
+        msg(M_CLIENT, "ACC: No negoti=
ated protocols");
+        return NULL;
+    }
+
+    struct buffer buf =3D=
 alloc_buf_gc(1024, gc);
+
+    buf_printf(&buf, "ACC:%d A:6 %s", multi->ac=
c_max_message_length,
+               multi->acc_negotiated_protocols);
+  =
  return buf_str(&buf);
+}
+
+
 static bool
 management_client_pending_auth=
(void *arg, const unsigned long cid, const unsigned int mda_key_id,
       =
                         const char *extra, unsigned int timeout)
@@ -4087,=
10 +4108,22 @@
     if (mi)
     {
         struct tls_multi *multi =3D mi-=
>context=2Ec2=2Etls_multi;
+
+        struct gc_arena gc =3D gc_new();
+   =
     if (!strcmp(extra, "ACC"))
+        {
+            extra =3D calculate=
_app_control_extra(mi, &gc);
+            if (!extra)
+            {
+     =
           gc_free(&gc);
+                return false;
+            }
+   =
     }
         struct tls_session *session =3D lookup_session_by_mda_key_i=
d(multi, mda_key_id);
 
         if (!session)
         {
+            gc_f=
ree(&gc);
             return false;
         }
 
@@ -4098,6 +4131,7 @@
   =
      bool ret =3D send_auth_pending_messages(multi, session, extra, timeou=
t);
         reschedule_multi_process(&mi->context);
         multi_schedul=
e_context_wakeup(m, mi);
+        gc_free(&gc);
         return ret;
     }=

     return false;
@@ -4141,6 +4175,37 @@
     return ret;
 }
 
+
+static =
bool
+management_client_acc_msg(void *arg,
+                          const=
 unsigned long cid,
+                          const unsigned int mda_key_i=
d,
+                          struct buffer_list *input) /* ownership trans=
ferred */
+{
+    struct multi_context *m =3D (struct multi_context *)arg;
=
+    struct multi_instance *mi =3D lookup_by_cid(m, cid);
+
+    bool ret =
=3D false;
+    if (mi && buffer_list_defined(input))
+    {
+        struc=
t tls_multi *multi =3D mi->context=2Ec2=2Etls_multi;
+        struct tls_se=
ssion *session =3D lookup_session_by_mda_key_id(multi, mda_key_id);
+      =
  if (!session)
+        {
+            msg(M_CLIENT, "client session not f=
ound");
+            buffer_list_free(input);
+            return false;
+ =
       }
+
+        ret =3D management_send_acc_message(&mi->context, multi=
, session, input);
+        multi_schedule_context_wakeup(m, mi);
+    }
+
=
+    buffer_list_free(input);
+    return ret;
+}
+
+
 static char *
 manag=
ement_get_peer_info(void *arg, const unsigned long cid)
 {
@@ -4177,6 +4242=
,7 @@
         cb=2En_clients =3D management_callback_n_clients;
         c=
b=2Ekill_by_cid =3D management_kill_by_cid;
         cb=2Eclient_auth =3D m=
anagement_client_auth;
+        cb=2Eclient_acc_msg =3D management_client_a=
cc_msg;
         cb=2Eclient_pending_auth =3D management_client_pending_aut=
h;
         cb=2Eget_peer_info =3D management_get_peer_info;
         cb=2E=
push_update_broadcast =3D management_callback_send_push_update_broadcast;
d=
iff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 8e0c602=
=2E=2E4dfc719 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/option=
s=2Ec
@@ -35,6 +35,7 @@
 
 #include "syshead=2Eh"
 
+#include "acc=2Eh"
 #i=
nclude "buffer=2Eh"
 #include "error=2Eh"
 #include "common=2Eh"
@@ -2552,6=
 +2553,8 @@
     o->push_option_types_found =3D 0;
     o->push_update_opti=
ons_found =3D 0;
     o->imported_protocol_flags =3D 0;
+    o->pushed_acc_=
max_message_length =3D 0;
+    o->pushed_acc_negotiated_protocols =3D NULL;=

 }
 
 static void
@@ -7098,6 +7101,47 @@
         VERIFY_PERMISSION(OPT_P_=
GENERAL);
         options->force_key_material_export =3D true;
     }
+   =
 else if (streq(p[0], "app-custom-control") && p[1] && !p[2])
+    {
+     =
   VERIFY_PERMISSION(OPT_P_GENERAL);
+        if (!string_class(p[1], CC_AL=
NUM | CC_COLON | CC_UNDERBAR | CC_DASH, 0))
+        {
+            msg(msg=
level, "App custom control protocols must only contain "
+                 =
         "alphanumeric characters, '-', and '_'=2E");
+            goto err=
;
+        }
+        options->acc_protocols =3D p[1];
+    }
+    else if =
(streq(p[0], "custom-control") && p[1] && p[2] && p[3] && !p[4])
+    {
+  =
      VERIFY_PERMISSION(OPT_P_ACC);
+
+        /* check if the list from th=
e server is a real subset of our list */
+        struct gc_arena gc_local =
=3D gc_new();
+        struct buffer common_list =3D get_list_intersection(=
&gc_local, p[3], options->acc_protocols);
+
+        if (buf_len(&common_li=
st) =3D=3D 0 || !streq(p[3], buf_cstr(&common_list)))
+        {
+         =
   msg(msglevel, "App custom control list from server contains "
+         =
                 "unsupported protocols");
+            gc_free(&gc_local);=

+            goto err;
+        }
+        gc_free(&gc_local);
+
+        =
if (!streq(p[2], "6:A") && !streq(p[2], "A:6"))
+        {
+            msg=
(msglevel, "App custom control encoding must be base64 and ascii");
+      =
      goto err;
+        }
+
+        if (!atoi_constrained(p[1], &options-=
>pushed_acc_max_message_length,
+                              "app custom =
message message length", ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))
+    =
    {
+            goto err;
+        }
+        options->pushed_acc_negoti=
ated_protocols =3D p[3];
+    }
     else if (streq(p[0], "prng") && p[1] &=
& !p[3])
     {
         msg(M_WARN, "NOTICE: --prng option ignored (SSL li=
brary PRNG is used)");
diff --git a/src/openvpn/options=2Eh b/src/openvpn/o=
ptions=2Eh
index c58530a=2E=2E73c1354 100644
--- a/src/openvpn/options=2Eh
=
+++ b/src/openvpn/options=2Eh
@@ -713,6 +713,18 @@
     /* force using TLS =
key material export for data channel key generation */
     bool force_key_=
material_export;
 
+    /** The app custom control protocols we should anno=
unce as supported */
+    const char *acc_protocols;
+
+    /** the protoco=
ls that are negotiated with the peer=2E This is a
+     *  a temporary vari=
able since options=2Ec push parser cannot access
+     *  tls multi struct =
*/
+    const char *pushed_acc_negotiated_protocols;
+
+    /** the maximum=
 length of an ACC control channel message via push message
+     * */
+    =
int pushed_acc_max_message_length;
+
     bool vlan_tagging;
     enum vlan=
_acceptable_frames vlan_accept;
     uint16_t vlan_pvid;
@@ -762,8 +774,10 =
@@
 #define OPT_P_INLINE          (1u << 29)
 #define OPT_P_PUSH_MTU       =
 (1u << 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
+#define OPT_P_ACC   =
          (1ull << 32)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_P=
ULL_MODE | OPT_P_PEER_ID | 0x0ull))
+/* Options allowed in the normal confi=
guration file (vs pushed options or in ccd files) */
+#define OPT_P_DEFAULT=
 (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #defi=
ne PULL_DEFINED(opt) ((opt)->pull)
 
diff --git a/src/openvpn/push=2Ec b/sr=
c/openvpn/push=2Ec
index 42259c3=2E=2Ea18f33b 100644
--- a/src/openvpn/push=
=2Ec
+++ b/src/openvpn/push=2Ec
@@ -27,6 +27,8 @@
 #include "syshead=2Eh"
 =

 #include "push=2Eh"
+
+#include "acc=2Eh"
 #include "options=2Eh"
 #inclu=
de "crypto=2Eh"
 #include "ssl=2Eh"
@@ -221,9 +223,56 @@
 #endif
 }
 
+stat=
ic void
+parse_server_pushed_info_acc(struct context *c, struct buffer *buf=
)
+{
+    int max_acc_len =3D 0;
+    struct tls_multi *multi =3D c->c2=2Et=
ls_multi;
+
+    if (multi->acc_negotiated_protocols)
+    {
+        retur=
n;
+    }
+
+    if (!multi->opt=2Eacc_protocols || !c->options=2Epull)
+  =
  {
+        msg(D_PUSH_ERRORS, "Peer tried to push app custom control list=
 "
+                           "without client announcing support for it");=

+        return;
+    }
+
+    /* example string to parse: ACC:1400 A:6 fl=
ower:happy */
+    /* Skip over the ACC: prefix */
+    buf_advance(buf, 4)=
;
+
+    struct gc_arena gc =3D gc_new();
+    const char *protocols =3D pa=
rse_acc_parameters(buf_cstr(buf), " ", &max_acc_len, false, &gc);
+    if (=
!protocols)
+    {
+        msg(D_PUSH_ERRORS, "WARNING: Received ACC info =
command with invalid parameters");
+        gc_free(&gc);
+        return;
=
+    }
+
+    /* check if the list from the server is a real subset of our =
list */
+    struct buffer common_list =3D get_list_intersection(&gc, proto=
cols, multi->opt=2Eacc_protocols);
+
+    if (buf_len(&common_list) =3D=3D =
0 || !streq(protocols, buf_cstr(&common_list)))
+    {
+        msg(D_PUSH_=
ERRORS, "App custom control list from server contains "
+                  =
         "unsupported protocols");
+        gc_free(&gc);
+        return;
=
+    }
+
+    multi->acc_negotiated_protocols =3D string_alloc(protocols, N=
ULL);
+    multi->acc_max_message_length =3D max_acc_len;
+    notify_clien=
t_acc_protocols(multi);
+    gc_free(&gc);
+}
 
 void
-server_pushed_info(c=
onst struct buffer *buffer, const int adv)
+peer_pushed_info(struct context=
 *c, const struct buffer *buffer, const int adv)
 {
     const char *m =3D =
"";
     struct buffer buf =3D *buffer;
@@ -233,6 +282,12 @@
         m =3D=
 BSTR(&buf);
     }
 
+    if (strncmp(m, "ACC:", 4) =3D=3D 0)
+    {
+    =
    parse_server_pushed_info_acc(c, &buf);
+        return;
+    }
+
 #ifde=
f ENABLE_MANAGEMENT
     struct gc_arena gc;
     if (management)
@@ -257,7=
 +312,7 @@
         gc_free(&gc);
     }
 #endif
-    msg(D_PUSH, "Info com=
mand was pushed by server ('%s')", m);
+    msg(D_PUSH, "Info command was p=
ushed by peer ('%s')", m);
 }
 
 void
@@ -285,6 +340,7 @@
     msg(D_PUSH, =
"CR response was sent by client ('%s')", m);
 }
 
+
 /**
  * Parse the keyw=
ord for the AUTH_PENDING request
  * @param buffer                buffer co=
ntaining the keywords, the buffer's
@@ -441,7 +497,6 @@
     const char *co=
nst peer_info =3D tls_multi->peer_info;
     unsigned int proto =3D extract=
_iv_proto(peer_info);
 
-
     /* Calculate the maximum timeout and subtrac=
t the time we already waited */
     unsigned int max_timeout =3D
         =
max_uint(tls_multi->opt=2Erenegotiate_seconds / 2, tls_multi->opt=2Ehandsha=
ke_window);
@@ -732,6 +787,12 @@
                 client_max_mtu, o->ce=2Et=
un_mtu, o->ce=2Etun_mtu);
         }
     }
+
+    if (tls_multi->acc_negot=
iated_protocols)
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "c=
ustom-control %d A:6 %s",
+                        tls_multi->acc_max_messa=
ge_length, tls_multi->acc_negotiated_protocols);
+    }
 }
 
 static bool
d=
iff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index 39302f6=2E=2E=
e08cd66 100644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -52=
,6 +52,7 @@
 
 int process_incoming_push_request(struct context *c);
 
+
 /=
**
  * @brief Handles the receiving of a push-update message and applies up=
dates to the specified
  * options=2E
@@ -92,7 +93,15 @@
 
 void receive_ex=
it_message(struct context *c);
 
-void server_pushed_info(const struct buff=
er *buffer, const int adv);
+/**
+ * This message is called when an INFO or=
 INFO_PRE message is received from
+ * a peer=2E
+ *
+ * @param c         C=
ontext of the peer=2E
+ * @param buffer    Buffer containing the INFO/INFO_=
PRE message=2E
+ * @param adv       number of character to advance past the=
 INFO/INFO_PRE header
+ */
+void peer_pushed_info(struct context *c, const =
struct buffer *buffer, const int adv);
 
 void receive_cr_response(struct c=
ontext *c, const struct buffer *buffer);
 
diff --git a/src/openvpn/ssl=2Ec=
 b/src/openvpn/ssl=2Ec
index ddee3eb=2E=2E5b7a1fa 100644
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
 
@@ -2090,6 +2092,11 =
@@
 #endif
         }
 
+        if (session->opt->acc_protocols)
+        =
{
+            buf_printf(&out, "IV_ACC=3D%d,A:6,%s\n", ACC_MAX_MSG_LEN, se=
ssion->opt->acc_protocols);
+        }
+
         if (session->opt->push_pe=
er_info_detail > 1)
         {
             struct env_set *es =3D session-=
>opt->es;
@@ -2390,6 +2397,8 @@
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
index 5efddad=2E=
=2E70cf7b2 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/=
unit_tests/openvpn/Makefile=2Eam
@@ -106,10 +106,12 @@
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
@@ -130,6 +132,7 @@
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
index 0000000=2E=2E9364d12
--- /dev/null
+++ b/tests/unit_tests/openv=
pn/test_acc=2Ec
@@ -0,0 +1,353 @@
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
+    gc_free(&gc)=
;
+}
+
+void
+test_acc_common_protocols(void **state)
+{
+    struct multi_=
instance mi =3D { 0 };
+    struct context *c =3D &mi=2Econtext;
+    c->op=
tions=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_multi, struc=
t tls_multi, &c->options=2Egc);
+
+    c->c2=2Etls_multi->peer_info =3D "IV=
_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power";
+    c->options=2Eacc=
_protocols =3D "power:flower:star";
+    struct tls_multi *multi =3D c->c2=
=2Etls_multi;
+    multi->opt=2Eacc_protocols =3D c->options=2Eacc_protocol=
s;
+    multi->session[TM_ACTIVE]=2Eopt =3D &multi->opt;
+    multi->opt=2E=
es =3D env_set_create(&c->options=2Egc);
+
+    determine_common_acc_protoc=
ols(multi, &c->c2=2Etls_multi->session[TM_ACTIVE]);
+
+    assert_int_equal=
(multi->acc_max_message_length, ACC_MAX_MSG_LEN);
+    assert_string_equal(=
multi->acc_negotiated_protocols, "power:flower");
+
+    assert_string_equa=
l(env_set_get(multi->opt=2Ees, "acc_protocols"), "acc_protocols=3Dpower:flo=
wer");
+    assert_string_equal(env_set_get(multi->opt=2Ees, "acc_message_l=
en"), "acc_message_len=3D1280");
+
+    free(multi->acc_negotiated_protocol=
s);
+    gc_free(&c->options=2Egc);
+}
+
+void
+test_acc_send_message(void =
**state)
+{
+    struct multi_instance mi =3D { 0 };
+    struct context *c=
 =3D &mi=2Econtext;
+    c->options=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLE=
AR_GC(c->c2=2Etls_multi, struct tls_multi, &c->options=2Egc);
+    bool ret=
;
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+    c->options=2Eacc=
_protocols =3D "power:flower:emergency";
+    multi->opt=2Eacc_protocols =
=3D c->options=2Eacc_protocols;
+    multi->session[TM_ACTIVE]=2Eopt =3D &m=
ulti->opt;
+    multi->opt=2Ees =3D env_set_create(&c->options=2Egc);
+
+  =
  c->c2=2Etls_multi->peer_info =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flow=
er:emergency:power";
+    determine_common_acc_protocols(multi, &c->c2=2Etl=
s_multi->session[TM_ACTIVE]);
+
+    struct tls_session *session =3D &c->c2=
=2Etls_multi->session[TM_ACTIVE];
+
+    ret =3D send_acc_message(c, c->c2=
=2Etls_multi, session, "emergency", true,
+                           "EMER=
GENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:", false);
+
+    assert_true=
(ret);
+    assert_string_equal(control_channel_message_sent,
+            =
            "ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS NOT =
A DRILL:");
+
+    ret =3D send_acc_message(c, c->c2=2Etls_multi, session, =
"emergency", false,
+                           "THE GOVERNMENT HAS ISSUED =
A RAINBOW COLOURED ALERT FOR YOUR AREA=2E", false);
+    assert_true(ret);
=
+    assert_string_equal(control_channel_message_sent,
+                   =
     "ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT=
 FOR YOUR AREA=2E");
+
+
+    /* test a long message (> 1000) with fragment=
 to get the maximum header size */
+    char long_message[1200] =3D { 0 };
=
+
+    for (int i =3D 0; i < 1024; i++)
+    {
+        long_message[i] =3D=
 (char)(' ' + (i % 95));
+    }
+
+    /* last char of the message is a i a=
nd then a \0 */
+    assert_int_equal(long_message[1023], 'i');
+    assert=
_int_equal(long_message[1024], '\0');
+
+    ret =3D send_acc_message(c, c-=
>c2=2Etls_multi, session, "emergency", true,
+                           lo=
ng_message, false);
+
+    assert_true(ret);
+    size_t cc_len =3D strlen(=
control_channel_message_sent);
+    assert_int_equal(control_channel_messag=
e_sent[cc_len - 1], 'i');
+    const char *expected_start_cc =3D "ACC,emerg=
ency,1024,AF, !\"#$%&'()*+,-=2E/012345";
+    assert_memory_equal(control_c=
hannel_message_sent, expected_start_cc, strlen(expected_start_cc));
+
+    =
free(multi->acc_negotiated_protocols);
+    gc_free(&c->options=2Egc);
+}
+=

+void
+test_list_intersection(void **state)
+{
+    const char *empty =3D =
"";
+    const char *protos =3D "power:flower:emergency";
+
+    struct gc_=
arena gc =3D gc_new();
+
+    struct buffer t1 =3D get_list_intersection(&g=
c, empty, protos);
+    assert_int_equal(buf_len(&t1), 0);
+
+    struct bu=
ffer t2 =3D get_list_intersection(&gc, protos, empty);
+    assert_int_equa=
l(buf_len(&t2), 0);
+
+    struct buffer t3 =3D get_list_intersection(&gc, =
protos, protos);
+    assert_string_equal(buf_cstr(&t3), protos);
+
+    co=
nst char *protos2 =3D "flower:emergency:power:mario";
+    struct buffer t4=
 =3D get_list_intersection(&gc, protos2, protos);
+    assert_string_equal(=
buf_cstr(&t4), "flower:emergency:power");
+
+    const char *protos3 =3D "s=
uper:paper:mario:flower";
+    struct buffer t5 =3D get_list_intersection(&=
gc, protos2, protos3);
+    assert_string_equal(buf_cstr(&t5), "flower:mari=
o");
+
+    const char *proto4 =3D "flower:flower:flower:flower";
+    stru=
ct buffer t6 =3D get_list_intersection(&gc, proto4, "flower");
+    assert_=
string_equal(buf_cstr(&t6), "flower");
+
+
+    gc_free(&gc);
+}
diff --git=
 a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_ac=
c=2Eh
new file mode 100644
index 0000000=2E=2E32421fb
--- /dev/null
+++ b/t=
ests/unit_tests/openvpn/test_acc=2Eh
@@ -0,0 +1,35 @@
+/*
+ *  OpenVPN -- A=
n application to securely tunnel IP networks
+ *             over a single =
UDP port, with support for SSL/TLS-based
+ *             session authentica=
tion and key exchange,
+ *             packet encryption, packet authentica=
tion, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002=
-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free softw=
are; you can redistribute it and/or modify
+ *  it under the terms of the G=
NU General Public License version 2
+ *  as published by the Free Software =
Foundation=2E
+ *
+ *  This program is distributed in the hope that it will=
 be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warrant=
y of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+=
 *  GNU General Public License for more details=2E
+ *
+ *  You should have=
 received a copy of the GNU General Public License along
+ *  with this pro=
gram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+
+#ifndef =
TEST_ACC_H
+#define TEST_ACC_H
+void test_acc_parse_client_messages(void **=
state);
+
+void test_parse_acc_parameters(void **state);
+
+void test_acc_c=
ommon_protocols(void **state);
+
+void test_acc_send_message(void **state);=

+
+void test_list_intersection(void **state);
+#endif
diff --git a/tests/u=
nit_tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_common=2E=
h
index 5dae79b=2E=2E85e099f 100644
--- a/tests/unit_tests/openvpn/test_com=
mon=2Eh
+++ b/tests/unit_tests/openvpn/test_common=2Eh
@@ -43,11 +43,13 @@
=
 #define LargestIntegralType uintmax_t
 #endif
 /* redefine 2=2Ex API in te=
rms of 1=2Ex API */
-#define CMockaValueData             LargestIntegralTyp=
e
-#define check_expected_uint         check_expected
-#define expect_uint_=
value           expect_value
-#define expect_check_data           expect_ch=
eck
-#define cast_ptr_to_cmocka_value(x) (x)
+#define CMockaValueData      =
                 LargestIntegralType
+#define check_expected_uint          =
         check_expected
+#define expect_uint_value                     expe=
ct_value
+#define expect_check_data                     expect_check
+#defi=
ne cast_ptr_to_cmocka_value(x)           (x)
+#define assert_int_in_range(v=
alue, min, max)  assert_in_range((value), (min), (max))
+#define assert_uin=
t_in_range(value, min, max) assert_in_range((value), (min), (max))
 #endif
=
 
 /**
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_test=
s/openvpn/test_ssl=2Ec
index 4baf8cc=2E=2E4987dd0 100644
--- a/tests/unit_t=
ests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -5=
2,6 +52,8 @@
 #include "ssl_verify=2Eh"
 #include "openvpn=2Eh"
 
+#include=
 "test_acc=2Eh"
+
 /* Mock function to be allowed to include win32=2Ec whic=
h is required for
  * getting the temp directory */
 #ifdef _WIN32
@@ -86,6=
 +88,20 @@
 {
     return;
 }
+void
+reschedule_multi_process(struct contex=
t *c)
+{
+}
+
+/* Define a dummy dco cipher option to avoid linking against=
 all the DCO
+ * units */
+#if defined(ENABLE_DCO)
+const char *
+dco_get_s=
upported_ciphers(void)
+{
+    return "AES-192-GCM:AES-128-CBC:AES-256-GCM:=
AES-128-GCM:CHACHA20-POLY1305";
+}
+#endif
 
 /* generated using
  * openss=
l req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \
@@ =
-1111,8 +1127,12 @@
         cmocka_unit_test(ssl_test_extract_last_matchin=
g_field),
         cmocka_unit_test(ssl_test_reject_null_in_cert_subject),
=
         cmocka_unit_test(ssl_test_escape_rfc_2253_chars_in_subject),
-    =
    cmocka_unit_test(ssl_test_extract_peer_info)
-
+        cmocka_unit_tes=
t(ssl_test_extract_peer_info),
+        cmocka_unit_test(test_acc_parse_cli=
ent_messages),
+        cmocka_unit_test(test_parse_acc_parameters),
+     =
   cmocka_unit_test(test_acc_common_protocols),
+        cmocka_unit_test(t=
est_acc_send_message),
+        cmocka_unit_test(test_list_intersection)
  =
   };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Ge=
rrit-Change-Number: 1858
Gerrit-PatchSet: 26
Gerrit-Owner: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Reviewer: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--Mqa+Z/xrNKg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #26</strong> to the change originally created by Arn=
e Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
58?usp=3Demail">View Change</a></p><p>The following approvals got outdated =
and were removed:
Code-Review+1 by chugly, Code-Review+2 by R=C4=83zvan Coj=
ocaru</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Implement sending/receiving app custom control proto=
col messages<br><br>This allows openvpn GUI/front-ends and server via manag=
ement<br>to use the OpenVPN control channel to pass messages between each o=
ther<br>while OpenVPN handles the marshalling/unmarshalling of these and<br=
>negotiate the common app custom control protocols=2E<br><br>This provides =
an easy to use secure channel that does not depend on<br>the network itself=
 to work and can also be used before fully<br>authenticating the client=2E =
See the management-notes=2Etxt for more<br>details how to use this feature=
=2E An upcoming patch will also add<br>some example python scripts that sho=
wcase this feature=2E<br><br>Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8=
ae4c84<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1858<br>Message-Id: &lt;20261030170320=2E61=
33-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg40353=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>=
M doc/man-sections/client-options=2Erst<br>M doc/man-sections/management-op=
tions=2Erst<br>M doc/man-sections/script-options=2Erst<br>M doc/management-=
notes=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/acc=2Ec<br>A sr=
c/openvpn/acc=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br=
>M src/openvpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/mult=
i=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/op=
envpn/push=2Ec<br>M src/openvpn/push=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/=
openvpn/ssl_common=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tes=
ts/unit_tests/openvpn/mock_management=2Ec<br>M tests/unit_tests/openvpn/moc=
k_push_dependencies=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Ec<br>A tes=
ts/unit_tests/openvpn/test_acc=2Eh<br>M tests/unit_tests/openvpn/test_commo=
n=2Eh<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>26 files changed, 1,547=
 insertions(+), 23 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1858/26</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 5eb678b=2E=
=2E5cf1a30 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>++=
+ b/CMakeLists=2Etxt</span><br><span>@@ -434,6 +434,8 @@</span><br><span>  =
   src/compat/compat-strlcpy=2Ec</span><br><span>     src/compat/compat-str=
sep=2Ec</span><br><span>     src/compat/compat-strtok_r=2Ec</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Ec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Eh</span><=
br><span>     src/openvpn/argv=2Ec</span><br><span>     src/openvpn/argv=2E=
h</span><br><span>     src/openvpn/base64=2Ec</span><br><span>@@ -821,6 +82=
3,8 @@</span><br><span>             tests/unit_tests/openvpn/mock_managemen=
t=2Ec</span><br><span>             tests/unit_tests/openvpn/mock_ssl_depend=
encies=2Ec</span><br><span>             tests/unit_tests/openvpn/mock_win32=
_execve=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    tests/unit_tests/openvpn/test_acc=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            src/openvpn/acc=2Ec</span><br><span>     =
        src/openvpn/argv=2Ec</span><br><span>             src/openvpn/base6=
4=2Ec</span><br><span>             src/openvpn/crypto_epoch=2Ec</span><br><=
span>@@ -836,6 +840,7 @@</span><br><span>             src/openvpn/packet_id=
=2Ec</span><br><span>             src/openvpn/run_command=2Ec</span><br><sp=
an>             src/openvpn/ssl_mbedtls=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            src/openvpn/ssl_ncp=2Ec</span><br><span=
>             src/openvpn/ssl_openssl=2Ec</span><br><span>             src/=
openvpn/ssl_util=2Ec</span><br><span>             src/openvpn/ssl_verify_mb=
edtls=2Ec</span><br><span>diff --git a/doc/man-sections/client-options=2Ers=
t b/doc/man-sections/client-options=2Erst</span><br><span>index 87c138a=2E=
=2E16309f9 100644</span><br><span>--- a/doc/man-sections/client-options=2Er=
st</span><br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><s=
pan>@@ -437,6 +437,12 @@</span><br><span>         Additional authentication=
 methods supported by the client=2E</span><br><span>         This may be se=
t by the client UI/GUI using ``--setenv``=2E</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  :code:`IV_ACC=3D&lt;max_msg_le=
n&gt;,&lt;flags&gt;,&lt;protocols&gt;`</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        If the option ``--app-custom-control`` is set, t=
he client will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   send the supported max ACC message length, the supported formats</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        as (:code:`A:6`) an=
d the list of configured protocols (e=2Eg=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        :code:`flower:happy:power`)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   The following =
flags depend on which compression formats are compiled in</span><br><span> =
  and whether compression is allowed by options=2E See `Protocol options`_<=
/span><br><span>   for more details=2E</span><br><span>diff --git a/doc/man=
-sections/management-options=2Erst b/doc/man-sections/management-options=2E=
rst</span><br><span>index 8dad52b=2E=2Eba0468b 100644</span><br><span>--- a=
/doc/man-sections/management-options=2Erst</span><br><span>+++ b/doc/man-se=
ctions/management-options=2Erst</span><br><span>@@ -134,3 +134,17 @@</span>=
<br><span> </span><br><span> --management-up-down</span><br><span>   Report=
 tunnel up/down events to management interface=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+--app-custom-control protocol-list</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  Sets the list of supported app custom control p=
rotocols=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  These =
protocols are announced to the server via the IV_ACC peer info</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  variable when this option is u=
sed on a client=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 If the option is set on a server it will negotiate common protocols</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  with the client=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  The protocol-list is a : separated list of=
 protocol identifiers=2E Protocol</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  identifiers must consist of alphanumeric characters, :code:=
`-`, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`_`=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  See management-notes=2Etxt in the=
 OpenVPN distribution and the OpenVPN RFC</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  draft for a description of app custom control proto=
col support=2E</span><br><span>diff --git a/doc/man-sections/script-options=
=2Erst b/doc/man-sections/script-options=2Erst</span><br><span>index f42038=
0f=2E=2E474c7fd 100644</span><br><span>--- a/doc/man-sections/script-option=
s=2Erst</span><br><span>+++ b/doc/man-sections/script-options=2Erst</span><=
br><span>@@ -1006,3 +1006,12 @@</span><br><span>        X509_1_L=3DBISHKEK<=
/span><br><span>        X509_1_ST=3DNA</span><br><span>        X509_1_C=3DK=
G</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+:code:`acc_protocols`</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    If ``--app-custom-control`` is =
configured and the client supports any of the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    protocols that server also supports, this var=
iable contains a list of</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    common protocols separated by :=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+:code:`acc_message_len`</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if :code:`acc_protocols` is set, this variable contains the ma=
ximum</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    message le=
ngth for app custom protocol message=2E</span><br><span>diff --git a/doc/ma=
nagement-notes=2Etxt b/doc/management-notes=2Etxt</span><br><span>index b9b=
367f=2E=2E6c798c0 100644</span><br><span>--- a/doc/management-notes=2Etxt</=
span><br><span>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -853,6 +=
853,59 @@</span><br><span> that is required to continue the connection (unl=
ike MFA or opening a browser)</span><br><span> this message is not negotiat=
ed but can just be sent as a gratuitous message=2E</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+app custom control</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+If the special string &quot;ACC&quot; is passed as {EXTRA} OpenVPN =
will determine</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the c=
ommon app custom protocols between the client and the server and instruct</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+the client that the s=
erver will send control messages to the client using</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+the ACC protocol=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+The server should then use client-acc-msg command to send ap=
p custom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+control mes=
sages to the client to facilitate the pending authentication=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+COMMAND -- client-acc-msg (OpenVPN 2=2E8 or higher=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+------------------=
-------------------------------</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+On an O=
penVPN instance running in server mode this command sends an</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+app custom control message to a cl=
ient=2E The format of the command is:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 client-acc-msg {CID} {KID}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  {protocol}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  {flags}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {messag=
e}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  END</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+CID,KID -- client ID and Key ID=2E See documentati=
on for &quot;&gt;CLIENT:&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+notification for more info=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+protocol -- the ACC protocol identifier that this message should be</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            tagged with=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+flags    -- a concatenation of lett=
ers for the encoding (&#39;A&#39; or &#39;6&#39;)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            and the lette &#39;F&#39; if the =
message is a fragment=2E E=2Eg=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            &quot;6F&quot; for a base64 encoded message that =
is also a fragment</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           and not complete yet=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mess=
age  -- The message encoded in the encoding specified in flags</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+COMMAND -- acc-msg (OpenVPN 2=2E8 or higher)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+------------------------------------------</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+When OpenVPN is running in --client mode =
this command sends an app</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+custom command to the server=2E The format of the command is</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  acc-msg</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  {protocol}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  {flags}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  {message}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  END</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+See the client-acc-msg command for more =
details about the format of the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+message=2E Since a client has only one peer there is no need to=
 specify the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+client =
id and key id=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> COMM=
AND -- client-deny  (OpenVPN 2=2E1 or higher)</span><br><span> ------------=
-----------------------------------</span><br><span> </span><br><span>@@ -1=
327,6 +1380,52 @@</span><br><span>    response=2E Mechanisms that need mult=
iple rounds or more complex answers</span><br><span>    should implement a =
different response type than CR_RESPONSE=2E</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+(6) App custom control message</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    This message is an application specif=
ic payload message that is transported</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    over the OpenVPN control channel=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    In server mode:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &gt;CLIENT:ACC,{CID},{KID},{protocol},{fragment},{msg_base64}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    In client mode:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &gt;ACC:{protocol},{fragment},{msg_base64}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    The protocol is a short ascii string identifying the a=
pp specific custom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   protocol=2E If fragment is set to 1, the message is not complete and the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    next message sh=
ould be concatenated to this message to form a complete</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    message=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    Note that the OpenVPN implementation operates here with the=
 robustness</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prin=
ciple (&quot;be conservative in what you send, be liberal in what you</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    accept&quot; - RFC 79=
3 and others) and allows receiving messages longer than</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    maximum allowed message length=2E I=
mplementations should be prepared to</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    handle messages that are longer than the maximum allow=
ed message length=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OpenVPN does n=
ot verify that the message is valid base64=2E A peer that</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    sends invalid base64 payload will=
 be passed to the management interface=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    An implementation should be prepared to handle in=
valid base64 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 handle accordingly (e=2Eg=2E disconnect the client via client-deny or</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ignore such messages=
)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+(7) App custom control protocol me=
ssage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+   This message informs the clien=
t about the common ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+   protocols and the maximum message length for an ACC message=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+   In client mode:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+   &gt;ACC_PROTOCOLS:protocols=3D{protocol_list},message_len=3D{m=
ax_msg_len}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+   protocol_list is the lis=
t of supported protocols by both server and client=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   For example flower:power:sys_info woul=
d indicate these three protocols</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+   are supported=2E max_msg_len specifies the maximum message =
length that the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   p=
eer supports=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+   In server mode these=
 information are available in the acc_protocols and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   acc_message_len variables of the clien=
t environment=2E</span><br><span> </span><br><span> Variables:</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/=
Makefile=2Eam</span><br><span>index d641d927=2E=2Ebb31053 100644</span><br>=
<span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Mak=
efile=2Eam</span><br><span>@@ -45,6 +45,7 @@</span><br><span> sbin_PROGRAMS=
 =3D openvpn</span><br><span> </span><br><span> openvpn_SOURCES =3D \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	acc=2Ec acc=2Eh \</span>=
<br><span> 	argv=2Ec argv=2Eh \</span><br><span> 	auth_token=2Ec auth_token=
=2Eh \</span><br><span> 	base64=2Ec base64=2Eh \</span><br><span>@@ -122,7 =
+123,8 @@</span><br><span> 	proto=2Ec proto=2Eh \</span><br><span> 	proxy=
=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	push=2Ec push_util=2Ec push=2Eh \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	push=2Ec push=2Eh \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	push_util=2Ec \</span><br><sp=
an> 	pushlist=2Eh \</span><br><span> 	reflect_filter=2Ec reflect_filter=2Eh=
 \</span><br><span> 	reliable=2Ec reliable=2Eh \</span><br><span>diff --git=
 a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>new file mode =
100644</span><br><span>index 0000000=2E=2E455f56d</span><br><span>--- /dev/=
null</span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -0,0 +1,4=
45 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application t=
o securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             over a single TCP/UDP port, with support for SSL/T=
LS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    session authentication and key exchange,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             packet encryption, packet authentic=
ation, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyr=
ight (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;a=
rne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softwar=
e; you can redistribute it and/or modify</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licen=
se version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as =
published by the Free Software Foundation=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is distributed in the hope that it will be useful,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, write to the Free Software Foundation, Inc=2E,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef H=
AVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;error=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;forward=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_ncp=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+log_acc_message(struct co=
ntext *c, const struct buffer *buf, int payload_len,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                const char *protocol, int=
 flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool fragment =3D flags &a=
mp; ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *payload_msg =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* For simplicity, we always encode p=
ayload to be base64 encoded</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * if not already in base64 format */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (flags &amp; ACC_MESSAGE_FLAGS_ASCII)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        char *b64out =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(openvpn_=
base64_encode(CBPTR(buf), payload_len, &amp;b64out) &gt;=3D 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        gc_addspecial(b64out, f=
ree, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   payload_msg =3D b64out;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        payload_msg =3D CBSTR(bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (management)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct tls_session *session =3D &amp;c-&gt;c2=2Etls_mul=
ti-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
c-&gt;options=2Emode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            /* server mode=2E Report client context */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            struct man_def_au=
th_context *mda =3D session-&gt;opt-&gt;mda_context;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            unsigned int mda_key_id =3D g=
et_primary_key(c-&gt;c2=2Etls_multi)-&gt;mda_key_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;CLIEN=
T:ACC,%lu,%u,%s,%d,%s&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                mda-&gt;cid, mda_key_id, protocol, fragment, paylo=
ad_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            /* Client mode=2E Do not a=
 report a CLIENT id */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(M_CLIENT, &quot;&gt;ACC:%s,%d,%s&quot;, protocol, fragme=
nt, payload_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_M=
ANAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(D_PUSH, &quot;Received custom app control message (protocol &#39;%s&#39;%s=
)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pro=
tocol, fragment ? &quot;, fragment&quot; : &quot;&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+parse_acc_message_flags(const char=
 *flags, const char **err_reason, struct gc_arena *gc)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int acc_flags =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (const char *flag =3D flags; *flag !=3D &#39;\0&#39;; flag++)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (*flag =3D=3D &#39;A&#39;=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=3D A=
CC_MESSAGE_FLAGS_ASCII;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  else if (*flag =3D=3D &#39;6&#39;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        else if (*flag =3D=3D &#39;F&#39;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=3D ACC_M=
ESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            *err_reason =
=3D &quot;Unknown flag in flags&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return -1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* The message should be encoded with exactly one encoding=2E Ensure that=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * only one of =
the flags is present */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool asciienc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_ASCII);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool base64enc =
=3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_BASE64);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (base64enc + asciienc !=3D 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        char *tmp =3D gc_malloc(512, 1, gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tmp, 512, &qu=
ot;number of encodings must be exactly one &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                           &quot;(B64=3D%d, A=
SCII=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
               base64enc, asciienc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        *err_reason =3D tmp;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return -1;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn acc_flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Wrapper around parse_acc_message_flags to also include=
 the step of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * extr=
acting the flags from the buffer and forwarding the buffer</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * beyond the flags field=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+parse_acc_message_flags_buf(struct buffer *buf, co=
nst char **err_reason, struct gc_arena *gc)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *flags =3D buf_extract_field(buf, &#39;,&#39;, gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!flags)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        *err_reason =3D &quot;could not extract flags field=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return parse_acc_messag=
e_flags(flags, err_reason, gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+receive_acc_message(struct context *c, c=
onst struct buffer *buffer)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *err_reason =3D &quot;&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer bu=
f =3D *buffer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct tls_mul=
ti *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_protocols)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        err_reason =3D &quot;ACC not enabled or =
no negotiated protocols&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_advance(&am=
p;buf, strlen(&quot;ACC&quot;)) || buf_read_u8(&amp;buf) !=3D &#39;,&#39;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;missi=
ng , after ACC&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* extract protocol, payload =
length, flags substrings */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *protocol =3D buf_extract_field(&amp;buf, &#39;,&#39=
;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!protocol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D=
 &quot;could not extract protocol field&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!tls_item_in_cipher_list(protocol, multi-&gt;acc_negotiated_protocols))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct buffer msg_buf =3D all=
oc_buf_gc(1024, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        buf_printf(&amp;msg_buf, &quot;protocol &#39;%s&#39; not in l=
ist of negotiated protocols &#39;%s&#39;&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                   protocol, multi-&gt;acc_nego=
tiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       err_reason =3D buf_cstr(&amp;msg_buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto=
 err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* We do not check the length here=2E We ma=
ke no promises to support</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * anything larger than our announced message length but accordin=
g to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the robu=
stness principle</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * (&quot;be conservative in what you send, be liberal in what you accept&=
quot; - RFC 793 and others)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * we accept also longer messages */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int payload_len;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *payload_len_str =3D buf_extract_field(&amp;buf, =
&#39;,&#39;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!payload_len_str</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        || !atoi_constrained(payload_len_str, &amp;payload_len, &qu=
ot;acc_payload_len&quot;, 0, TLS_CHANNEL_BUF_SIZE - 1, D_PUSH_ERRORS))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;could not=
 extract payload length field&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int flags =3D =
parse_acc_message_flags_buf(&amp;buf, &amp;err_reason, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (flags &lt; 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We should have=
 a final NUL byte in the control message buffer</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * and thus the length of the buffer should=
 be payload_len + 1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (buf_len(&amp;buf) !=3D payload_len + 1)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        char *tmp =3D gc_malloc(512, 1, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tmp, 512, &=
quot;field length %d, payload length %d mismatch&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                 payload_len, buf_len(&=
amp;buf) - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   err_reason =3D tmp;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    log_acc_message(c, &amp;buf, payload_len, proto=
col, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    msg(D_PUSH_ERRORS, &quot;WARNING: Received =
malformed custom app control channel &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                       &quot;message (%s): %s&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        format_hex=
(CBPTR(buffer), BLEN(buffer), 80, &amp;gc));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+send_acc_message(struct context *c,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                 struct tls_=
multi *multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
           struct tls_session *session,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                 const char *protocol, bool fragment,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 cons=
t char *acc_msg_payload, bool base64)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * length=
 of the protocol string + one &#39;,&#39;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * 2 for the encoding (A or 6), potential F (frag=
ment), and 1 for the &#39;,&#39;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * 4 for the message size itself and one comma</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * 1 for the comma before =
the message itself */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const size_t max_header_size =3D strlen(&quot;ACC,&quot;) + strlen(pr=
otocol) + 1 + 4 + 1 + 2 + 1;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    size_t len =3D max_header_size + strlen(acc_msg_payload);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (len &gt; TLS_CHANNEL_BUF_SIZE)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;message =
length (%zu) exceeds maximum possible message length (%d)&quot;, len, TLS_C=
HANNEL_BUF_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if ((int)len &gt; multi-&gt;a=
cc_max_message_length)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(M_CLIENT, &quot;header (%zu) + message size (%zu) length (%zu) exceeds &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
      &quot;maximum allowed length negotiated with peer (%d)&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            max_header_size=
, strlen(acc_msg_payload), len,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            multi-&gt;acc_max_message_length);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* add 1 for the final \0 */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_g=
c(len + 1, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Example mes=
sage: ACC,muppets,15,A,I am Miss Piggy */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC,%s,%zu,%s%s,%s&quo=
t;, protocol,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
         strlen(acc_msg_payload),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+               base64 ? &quot;6&quot; : &quot;A&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+               fragment ? =
&quot;F&quot; : &quot;&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+               acc_msg_payload);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool ret =3D send_control_channel_string_dowork(session, BSTR(&amp;=
buf), D_PUSH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eschedule_multi_process(c);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+parse_acc_parameters(const char *capabilitie=
s,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
    const char *delim,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                     int *max_acc_len,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                     bool server,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                     struct gc_arena *g=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_message =3D string_al=
loc(capabilities, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    char *tmp_message_orig =3D tmp_message;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char *token =3D strtok_r(tmp_message, delim, &amp=
;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int p =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int acclen =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char *protocols =3D N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ret =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* In server mode we allo=
w more capabilities than our own, in client</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * mode we reject if we should use capabilities=
 that we do not support */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (token)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (p =3D=3D 0 &amp;&amp; !atoi_constrained(tok=
en, &amp;acclen, &quot;ACC message length&quot;, ACC_MIN_MSG_LEN, allowed_a=
cc_len, D_PUSH_ERRORS))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp=
; (!tls_item_in_cipher_list(&quot;A&quot;, token) || !tls_item_in_cipher_li=
st(&quot;6&quot;, token)))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(D_PUSH_ERRORS, &quot;App custom control encoding must include =
base64 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            goto done;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D =
1 &amp;&amp; !server &amp;&amp; strcmp(token, &quot;A:6&quot;) &amp;&amp; s=
trcmp(token, &quot;6:A&quot;))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(D_PUSH_ERRORS, &quot;App custom control encoding must be e=
xactly base64 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            goto done;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =
=3D=3D 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            protocol=
s =3D token;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 3)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;Too =
many parameters for INFO ACC message/IV_ACC=2E&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        token =3D strtok_r(NULL, delim, &amp;lasts);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        p++;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ret =3D string_alloc(protocols, gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    free(tmp_message_orig);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct =
buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_list_inte=
rsection(struct gc_arena *gc, const char *list1, const char *list2)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    char *tmp =3D string_alloc(list1, NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *token =3D strtok_r(tmp, &quot;:&quot;, &amp;lasts);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* The maximum possible length is the shorter of the two=
 input lists */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
size_t max_len =3D min_size(strlen(list1), strlen(list2));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer common_protocols =3D alloc_buf_gc(max=
_len + 1, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (token)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* check for every items is in b=
oth lists and not already in the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * common list */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (tls_item_in_cipher_list(token, list2)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !tl=
s_item_in_cipher_list(token, buf_cstr(&amp;common_protocols)))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (buf_len(&amp;common_proto=
cols) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    buf_write_u8(&amp;common_protocols, &#39;:&#39;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            buf_printf(&amp;common_protocols, &=
quot;%s&quot;, token);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 token =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    free(tmp);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return common_protocols;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protoco=
ls(struct tls_multi *multi, struct tls_session *session)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!multi-&gt;opt=2Eacc_protocols)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* No app custom protocols have been confi=
gured server-side=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;acc_negotiated_=
protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* We already h=
ave determined the common protocols=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* example IV=
_ACC: IV_ACC=3D2048,6:A,flower:power */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const char *peer_info =3D multi-&gt;peer_info;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc =
=3D extract_var_peer_info(peer_info, &quot;IV_ACC=3D&quot;, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!iv_acc)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int max_acc_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *protocols =3D parse_acc_parameters(iv_acc, &quot;=
,&quot;, &amp;max_acc_len, true, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(D_PUSH_ERRORS, &quot;WARNING: IV_ACC peer info variable of peer is =
malformed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer common_protocols =3D =
get_list_intersection(&amp;gc, multi-&gt;opt=2Eacc_protocols, protocols);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;common_protocols) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_DEBUG=
, &quot;WARNING: No common app custom control protocol=2E&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    multi-&gt;acc_negotiated_protocols =3D string_alloc(buf_=
str(&amp;common_protocols), NULL);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    multi-&gt;acc_max_message_length =3D max_acc_len;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    setenv_str(session-&gt;opt-&gt;es, &quot;=
acc_protocols&quot;, multi-&gt;acc_negotiated_protocols);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    setenv_int(session-&gt;opt-&gt;es=
, &quot;acc_message_len&quot;, multi-&gt;acc_max_message_length);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+notify_client_acc_proto=
cols(struct tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef E=
NABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLI=
ENT, &quot;&gt;ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;acc_n=
egotiated_protocols, multi-&gt;acc_max_message_length);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/a=
cc=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E9c99b11</span><br><span>--- /dev/null</span><br><span>+++ b/src/openv=
pn/acc=2Eh</span><br><span>@@ -0,0 +1,130 @@</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a sing=
le TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *             session authentication and key e=
xchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    packet encryption, packet authentication, and</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@=
openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is free software; you can redistribute it and/or mo=
dify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under th=
e terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distri=
buted in the hope that it will be useful,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  ME=
RCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License fo=
r more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have=
 received a copy of the GNU General Public License along</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write t=
o the Free Software Foundation, Inc=2E,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1=
301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifndef ACC_H</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define ACC_H</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e ACC_MIN_MSG_LEN 64</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define ACC_MAX_MSG_LEN 1280</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This method parses an =
app custom control message and delivers it to the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * management interface=2E We leave reassembl=
y of fragmented messages to the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * management interface=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param c            The context struct</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param buffer       Buffer containing the contro=
l message with ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+receive_acc_message(struct conte=
xt *c, const struct buffer *buffer);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_acc_message(=
struct context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                struct tls_multi *tls_multi,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                 struct tls_session *session,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const c=
har *protocol, bool fragment,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                 const char *msg, bool base64);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parses an inf=
o message from the server that contains app custom control info</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * information prior to the PUS=
H_REPLY to be able to use app custom control</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * protocols before sending</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * In client mode only allow what we support ourselves=2E =
In server mode</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * al=
low also capabilities that we not support ourselves=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param capabilities      The string to parse</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param delim             T=
he delimiter to use when parsing the string=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *                          IV_ACC uses &quot;,&=
quot; as delimiter while the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *                          custom-control PUSH message uses &quot=
; &quot; as &quot;,&quot; is</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *                          already used to separate different pus=
h directives</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am max_acc_len       Set to the maximum ACC message length</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param server            Whether =
we are server or client</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param gc                The gc arena to use for allocating the resu=
lting string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ret=
urn                  The resulting protocol string or NULL on error</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+parse_acc_parameters(const char *capabilities,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     const =
char *delim,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              int *max_acc_len,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     bool server,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     struct gc_arena *gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Parses the IV_ACC of the peer and sets multi=2Eacc_negotia=
ted_protocols</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to =
the common protocols of server and client and</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * multi=2Eacc_max_message_length  to the maximum=
 length of the ACC message</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * support by both server and client=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * If there is no common protocol or the client does not support =
any app custom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * pr=
otocol multi=2Eacc_negotiated_protocols will be set to NULL=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param multi      the multi instance to use th=
e set the app custom protocols=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param session    the session to read the client env from<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+determine_common_acc_protocols(struct tls_multi *mu=
lti, struct tls_session *session);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Flags returned by=
 the parse_acc_message_flags method</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
enum acc_message_flag</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_=
FLAGS_ASCII =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ACC_MESSAGE_FLAGS_BASE64 =3D 2,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Parses the fla=
gs field of an app control message If there is an</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  error parsing the flags field the method =
returns -1 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  p=
uts the error reason in err_reason</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_message=
_flags(const char *flags, const char **err_reason, struct gc_arena *gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Calculates the intersection of two list that are both =
separated by :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * It=
ems in the result will have the same ordering as in the list1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * parameters</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param gc            Returned buffer=
 will be allocated in this gc</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param list1         First list to intersect</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param list2         Second list t=
o intersect=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn A (potentially empty) buffer containing an intersection list</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+struct buffer</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+get_list_intersection(struct gc_arena *gc, const c=
har *list1, const char *list2);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Notifies a client vi=
a management interface of the negotiated app</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * custom protocols</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param multi the tls_multi instance of the conn=
ection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+notify_client_acc_protocols(struct tls_multi=
 *multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec=
</span><br><span>index 681210d=2E=2Eeb41d03 100644</span><br><span>--- a/sr=
c/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><=
br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;dco=2Eh&quot;</s=
pan><br><span> #include &quot;auth_token=2Eh&quot;</span><br><span> #includ=
e &quot;tun_afunix=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br><span> #i=
nclude &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>@@ -257,11 =
+258,11 @@</span><br><span>     }</span><br><span>     else if (buf_string_=
match_head_str(buf, &quot;INFO_PRE&quot;))</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        server_pushed_info(buf,=
 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        peer_pu=
shed_info(c, buf, 8);</span><br><span>     }</span><br><span>     else if (=
buf_string_match_head_str(buf, &quot;INFO&quot;))</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        server_pushed_in=
fo(buf, 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
peer_pushed_info(c, buf, 4);</span><br><span>     }</span><br><span>     el=
se if (buf_string_match_head_str(buf, &quot;CR_RESPONSE&quot;))</span><br><=
span>     {</span><br><span>@@ -271,6 +272,10 @@</span><br><span>     {</sp=
an><br><span>         receive_auth_pending(c, buf);</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (buf_str=
ing_match_head_str(buf, &quot;ACC&quot;))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        receive_acc_message(c, buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (buf_string_mat=
ch_head_str(buf, &quot;EXIT&quot;))</span><br><span>     {</span><br><span>=
         receive_exit_message(c);</span><br><span>diff --git a/src/openvpn/=
init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 6c87865=2E=2Eff3bfe5 =
100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src=
/openvpn/init=2Ec</span><br><span>@@ -56,6 +56,7 @@</span><br><span> #inclu=
de &quot;schedule=2Eh&quot;</span><br><span> #include &quot;options_string=
=2Eh&quot;</span><br><span> #include &quot;resolve=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span=
><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><sp=
an> </span><br><span>@@ -2283,6 +2284,13 @@</span><br><span>         }</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi &amp;&amp;=
 multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        buf_printf(&amp;out, &quot; custom-control %d A:6 %s&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                   multi=
-&gt;acc_max_message_length, multi-&gt;acc_negotiated_protocols);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (BLENZ(&amp;out)=
 &gt; strlen(header))</span><br><span>     {</span><br><span>         msg(D=
_HANDSHAKE, &quot;%s&quot;, BSTR(&amp;out));</span><br><span>@@ -2526,6 +25=
34,11 @@</span><br><span>         flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_protocols)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        flags |=3D OPT_P_ACC;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     return flags;</span><br><span>=
 }</span><br><span> </span><br><span>@@ -2734,6 +2747,18 @@</span><br><span=
>         frame-&gt;tun_mtu =3D min_int(frame-&gt;tun_max_mtu, c-&gt;option=
s=2Ece=2Etun_mtu);</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (found &amp; OPT_P_ACC &amp;=
&amp; c-&gt;options=2Epushed_acc_negotiated_protocols)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        struct tls_multi *multi =3D c-&gt;c2=2Etls_mul=
ti;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(mul=
ti-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        multi-&gt;acc_negotiated_protocols =3D string_alloc(c=
-&gt;options=2Epushed_acc_negotiated_protocols, NULL);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;acc_max_message_length=
 =3D c-&gt;options=2Epushed_acc_max_message_length;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(D_PUSH, &quot;OPTIONS IMPORT: ACC protocols: %s,=
 msg len: %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            multi-&gt;acc_negotiated_protocols, multi-&gt;acc_max_message_l=
ength);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        noti=
fy_client_acc_protocols(multi);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     return true;</span><br><span> }</span><br><span> </span=
><br><span>@@ -3356,6 +3381,7 @@</span><br><span>     to=2Everify_hash_dept=
h =3D options-&gt;verify_hash_depth;</span><br><span>     to=2Everify_hash_=
no_ca =3D options-&gt;verify_hash_no_ca;</span><br><span>     memcpy(to=2Ex=
509_username_field, options-&gt;x509_username_field, sizeof(to=2Ex509_usern=
ame_field));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=
=2Eacc_protocols =3D options-&gt;acc_protocols;</span><br><span>     to=2Ee=
s =3D c-&gt;c2=2Ees;</span><br><span>     to=2Enet_ctx =3D &amp;c-&gt;net_c=
tx;</span><br><span> </span><br><span>@@ -4310,6 +4336,24 @@</span><br><spa=
n> }</span><br><span> #endif /* ifdef TARGET_ANDROID */</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+management_acc_msg(void *arg,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
struct buffer_list *input) /* ownership transferred */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct context *c =3D arg;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (buffer_list_defined(input) &amp;&amp; c-&gt;c2=2Etls_m=
ulti)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *mu=
lti =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct tls_session *session =3D &amp;multi-&gt;session[TM=
_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D management_se=
nd_acc_message(c, multi, session, input);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_=
list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><=
br><span> void</span><br><span>@@ -4326,6 +4370,7 @@</span><br><span>      =
   cb=2Eproxy_cmd =3D management_callback_proxy_cmd;</span><br><span>      =
   cb=2Eremote_cmd =3D management_callback_remote_cmd;</span><br><span>    =
     cb=2Esend_cc_message =3D management_callback_send_cc_message;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cb=2Eacc_msg =3D man=
agement_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</span><br><span>   =
      cb=2Enetwork_change =3D management_callback_network_change;</span><br=
><span> #endif</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/op=
envpn/manage=2Ec</span><br><span>index 16864c8=2E=2E987af2da 100644</span><=
br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/man=
age=2Ec</span><br><span>@@ -45,8 +45,10 @@</span><br><span> #include &quot;=
push=2Eh&quot;</span><br><span> #include &quot;multi=2Eh&quot;</span><br><s=
pan> #include &quot;resolve=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br>=
<span> #include &quot;memdbg=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span> </span=
><br><span> #ifdef ENABLE_PKCS11</span><br><span> #include &quot;pkcs11=2Eh=
&quot;</span><br><span>@@ -1080,6 +1082,35 @@</span><br><span>             =
}</span><br><span>             break;</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        case IEC_CLIENT_ACC_MSG:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;pe=
rsist=2Ecallback=2Eclient_acc_msg)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                bool status =3D (*man-&gt;persist=2Ecallback=2Ecli=
ent_acc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                                =
                      man-&gt;connection=2Ein_extra_cid,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
                                man-&gt;connection=2Ein_extra_kid,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
                                          man-&gt;connection=2Ein_extra);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                man-&=
gt;connection=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                report_command_status(status, &quot;client-a=
cc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                man_=
command_unsupported(&quot;client-acc-msg&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        case IEC_ACC_MSG:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (man-&gt;persist=2Ecallback=2Eacc_msg)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                bool status =3D (*man-=
&gt;persist=2Ecallback=2Eacc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
                                    man-&gt;connection=2Ein_extra);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                man-&gt;con=
nection=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                report_command_status(status, &quot;acc-msg&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                man_command_unsup=
ported(&quot;acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            break;</span><br><span>         case IEC_PK_SIGN:</span><br>=
<span>             man-&gt;connection=2Eext_key_state =3D EKS_READY;</span>=
<br><span>             buffer_list_free(man-&gt;connection=2Eext_key_input)=
;</span><br><span>@@ -1204,6 +1235,29 @@</span><br><span> }</span><br><span=
> </span><br><span> static void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+man_client_acc_msg(struct management *man, const char *cid_str,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
const char *kid_str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct man_co=
nnection *mc =3D &amp;man-&gt;connection;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    mc-&gt;in_extra_cid =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_kid =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (parse_cid(cid_str, &am=
p;mc-&gt;in_extra_cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        &amp;&amp; parse_uint(kid_str, &quot;KID&quot;, &amp;mc-&gt;in_e=
xtra_kid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        mc-&gt;in_extra=
_cmd =3D IEC_CLIENT_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        in_extra_reset(mc, IER_NEW);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+man_acc_msg(struct management *ma=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *mc =3D &=
amp;man-&gt;connection;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    mc-&gt;in_extra_cmd =3D IEC_ACC_MSG;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    in_extra_reset(mc, IER_NEW);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span> man_client_auth(struct management *man, const=
 char *cid_str, const char *kid_str, const bool extra)</span><br><span> {</=
span><br><span>     struct man_connection *mc =3D &amp;man-&gt;connection;<=
/span><br><span>@@ -1758,6 +1812,17 @@</span><br><span>             man_cli=
ent_pending_auth(man, p[1], p[2], p[3], p[4]);</span><br><span>         }</=
span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else if (streq(p[0], &quot;client-acc-msg&quot;))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (man_need(p, 2, 0))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            man_client_acc_msg(man, p[1], p[2]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;acc-msg&quot;))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        man_acc_msg(man);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     =
else if (streq(p[0], &quot;rsa-sig&quot;))</span><br><span>     {</span><br=
><span>         man_pk_sig(man, &quot;rsa-sig&quot;);</span><br><span>@@ -2=
952,7 +3017,9 @@</span><br><span>                                        &q=
uot;bytes_sent=3D&quot;,</span><br><span>                                  =
      &quot;bytes_received=3D&quot;,</span><br><span>                      =
                  &quot;session_id=3D&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                       &quot;session=
_state=3D&quot; };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                      &quot;session_state=3D&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
            &quot;acc_protocols=3D&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                       &quot;acc_mess=
age_len=3D&quot; };</span><br><span> </span><br><span>     if (env_filter_l=
evel =3D=3D 0)</span><br><span>     {</span><br><span>@@ -3107,6 +3174,7 @@=
</span><br><span>     }</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><=
span> management_connection_established(struct management *man, struct man_=
def_auth_context *mdac,</span><br><span>                                   =
const struct env_set *es)</span><br><span>@@ -4364,6 +4432,58 @@</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+management_send_acc_message(struct context *c, struct tls_mu=
lti *multi, struct tls_session *session,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                            struct buffer_list *input)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* also ensures that are enough i=
nputs in the list to safely call</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * buffer_list_peek without extra NULL checks */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!input || input-&gt;s=
ize &lt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, =
&quot;not enough input lines for sending acc message, &quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                      &quot;missin=
g protocol, flag and/or messages lines&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct buffer *proto_buf =3D buffer_list_peek(input);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *protocol =3D string_a=
lloc(CBSTR(proto_buf), &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    buffer_list_pop(input);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const struct buffer *encoding_buf =3D buffer_list_peek(input);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const char *acc_err_reason =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int acc_flags =3D pa=
rse_acc_message_flags(buf_cstr(encoding_buf), &amp;acc_err_reason, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (acc_flags =
&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quo=
t;ERROR: parsing acc message flags failed: %s&quot;, acc_err_reason);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto error;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    buffer_list_pop(input);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    buffer_list_aggregate_separator(input, 10000, &quot;&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer =
*acc_msg_buf =3D buffer_list_peek(input);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!multi-&gt;acc_negotiated_protocols</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        || !tls_item_in_cipher_list(protocol, mu=
lti-&gt;acc_negotiated_protocols))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(M_CLIENT, &quot;ERROR: protocol not in the list of negotiated =
protocols: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            np(multi-&gt;acc_negotiated_protocols));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    bool ret =3D send_acc_message(c, multi, session, protocol,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
 acc_flags &amp; ACC_MESSAGE_FLAGS_FRAGMENT,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                buf_cstr(acc_msg_b=
uf),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                 acc_flags &amp; ACC_MESSAGE_FLAGS_BASE64);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+error:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span> #else /* ifdef ENABLE_MANAGEMEN=
T */</span><br><span> </span><br><span> #include &quot;win32=2Eh&quot;</spa=
n><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</s=
pan><br><span>index f2c6916=2E=2E82c0caa 100644</span><br><span>--- a/src/o=
penvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><s=
pan>@@ -183,12 +183,19 @@</span><br><span>     int (*n_clients)(void *arg);=
</span><br><span>     bool (*send_cc_message)(void *arg, const char *messag=
e, const char *parameter);</span><br><span>     bool (*kill_by_cid)(void *a=
rg, const unsigned long cid, const char *kill_msg);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool (*client_auth)=
(void *arg, const unsigned long cid, const unsigned int mda_key_id,</span><=
br><span>                         const bool auth, const char *reason, cons=
t char *client_reason,</span><br><span>                         struct buff=
er_list *cc_config); /* ownership transferred */</span><br><span>     bool =
(*client_pending_auth)(void *arg, const unsigned long cid, const unsigned i=
nt kid,</span><br><span>                                 const char *extra,=
 unsigned int timeout);</span><br><span>     char *(*get_peer_info)(void *a=
rg, const unsigned long cid);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    bool (*client_acc_msg)(void *arg,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                           const unsigned long =
cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
            const unsigned int mda_key_id,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                           struct buffer_list *msg);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool (*acc_msg)=
(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            struct buffer_list *msg);</span><br><span>     bool (*proxy_cmd=
)(void *arg, const char **p);</span><br><span>     bool (*remote_cmd)(void =
*arg, const char **p);</span><br><span> #ifdef TARGET_ANDROID</span><br><sp=
an>@@ -291,13 +298,15 @@</span><br><span>     struct command_line *in;</spa=
n><br><span>     struct buffer_list *out;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define IEC_UNDEF       0</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CLIENT_AUTH 1</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_UNDEF          =
0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT=
_AUTH    1</span><br><span> /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_RSA_SIG=
N    3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CER=
TIFICATE 4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC=
_PK_SIGN     5</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 IEC_PASSWORD    6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define IEC_RSA_SIGN       3</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define IEC_CERTIFICATE    4</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define IEC_PK_SIGN        5</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define IEC_PASSWORD       6</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_ACC_MSG 7</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_ACC_MSG        8</s=
pan><br><span>     int in_extra_cmd;</span><br><span>     struct buffer_lis=
t *in_extra;</span><br><span>     unsigned long in_extra_cid;</span><br><sp=
an>@@ -499,6 +508,14 @@</span><br><span> </span><br><span> void man_persist=
_client_stats(struct management *man, struct context *c);</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Parses the ACC =
message from the input buffer_list and send to the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * session identified by session and multi</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+struct tls_session;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+struct tls_multi;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+management_send_acc_message(struct context *c, struct =
tls_multi *multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                          struct tls_session *session, struct buffer_list *=
input);</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><sp=
an> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/multi=2E=
c b/src/openvpn/multi=2Ec</span><br><span>index 3f82052=2E=2E3f514d6 100644=
</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/open=
vpn/multi=2Ec</span><br><span>@@ -53,6 +53,7 @@</span><br><span> #include &=
quot;ssl_util=2Eh&quot;</span><br><span> #include &quot;dco=2Eh&quot;</span=
><br><span> #include &quot;reflect_filter=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><s=
pan> </span><br><span> /*#define MULTI_DEBUG_EVENT_LOOP*/</span><br><span> =
</span><br><span>@@ -4077,6 +4078,26 @@</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static const char *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+calculate_app_control_extra(struct multi_instance *mi, struct gc_arena=
 *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;m=
i-&gt;context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!multi-&gt;acc_negotiated_protocols)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ACC: No negotiated protoco=
ls&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(10=
24, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot=
;ACC:%d A:6 %s&quot;, multi-&gt;acc_max_message_length,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+               multi-&gt;acc_negotiated=
_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn buf_str(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static bool</spa=
n><br><span> management_client_pending_auth(void *arg, const unsigned long =
cid, const unsigned int mda_key_id,</span><br><span>                       =
         const char *extra, unsigned int timeout)</span><br><span>@@ -4087,=
10 +4108,22 @@</span><br><span>     if (mi)</span><br><span>     {</span><b=
r><span>         struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_mult=
i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!st=
rcmp(extra, &quot;ACC&quot;))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            extra =3D calculate_app_control_extra(mi, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (!extra)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ret=
urn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span>         struct tls_session *session =3D lookup_session_by_mda_k=
ey_id(multi, mda_key_id);</span><br><span> </span><br><span>         if (!s=
ession)</span><br><span>         {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            gc_free(&amp;gc);</span><br><span>             r=
eturn false;</span><br><span>         }</span><br><span> </span><br><span>@=
@ -4098,6 +4131,7 @@</span><br><span>         bool ret =3D send_auth_pendin=
g_messages(multi, session, extra, timeout);</span><br><span>         resche=
dule_multi_process(&amp;mi-&gt;context);</span><br><span>         multi_sch=
edule_context_wakeup(m, mi);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        gc_free(&amp;gc);</span><br><span>         return ret;</sp=
an><br><span>     }</span><br><span>     return false;</span><br><span>@@ -=
4141,6 +4175,37 @@</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+management_client_acc_msg(void *a=
rg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
          const unsigned long cid,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                          const unsigned int mda_key_id,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
   struct buffer_list *input) /* ownership transferred */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct multi_context *m =3D (struct multi_context *=
)arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mul=
ti_instance *mi =3D lookup_by_cid(m, cid);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (mi &amp;&amp; buffer_list_defined(input))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct tls_multi *multi =3D mi-&gt;context=
=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       struct tls_session *session =3D lookup_session_by_mda_key_id(multi, =
mda_key_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(M_CLIENT, &quot;client session not found&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            buffer_list_free(input);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ret =3D management_send_acc_message(&amp;mi=
-&gt;context, multi, session, input);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        multi_schedule_context_wakeup(m, mi);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    buffer_list_free(input);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> sta=
tic char *</span><br><span> management_get_peer_info(void *arg, const unsig=
ned long cid)</span><br><span> {</span><br><span>@@ -4177,6 +4242,7 @@</spa=
n><br><span>         cb=2En_clients =3D management_callback_n_clients;</spa=
n><br><span>         cb=2Ekill_by_cid =3D management_kill_by_cid;</span><br=
><span>         cb=2Eclient_auth =3D management_client_auth;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cb=2Eclient_acc_msg =3D ma=
nagement_client_acc_msg;</span><br><span>         cb=2Eclient_pending_auth =
=3D management_client_pending_auth;</span><br><span>         cb=2Eget_peer_=
info =3D management_get_peer_info;</span><br><span>         cb=2Epush_updat=
e_broadcast =3D management_callback_send_push_update_broadcast;</span><br><=
span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><=
br><span>index 8e0c602=2E=2E4dfc719 100644</span><br><span>--- a/src/openvp=
n/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span=
>@@ -35,6 +35,7 @@</span><br><span> </span><br><span> #include &quot;syshea=
d=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;buff=
er=2Eh&quot;</span><br><span> #include &quot;error=2Eh&quot;</span><br><spa=
n> #include &quot;common=2Eh&quot;</span><br><span>@@ -2552,6 +2553,8 @@</s=
pan><br><span>     o-&gt;push_option_types_found =3D 0;</span><br><span>   =
  o-&gt;push_update_options_found =3D 0;</span><br><span>     o-&gt;importe=
d_protocol_flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    o-&gt;pushed_acc_max_message_length =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    o-&gt;pushed_acc_negotiated_protocols =
=3D NULL;</span><br><span> }</span><br><span> </span><br><span> static void=
</span><br><span>@@ -7098,6 +7101,47 @@</span><br><span>         VERIFY_PER=
MISSION(OPT_P_GENERAL);</span><br><span>         options-&gt;force_key_mate=
rial_export =3D true;</span><br><span>     }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;app-custom-control&=
quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (!string_class(p[1], CC_ALNUM | CC_=
COLON | CC_UNDERBAR | CC_DASH, 0))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            msg(msglevel, &quot;App custom control protocols must only=
 contain &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                      &quot;alphanumeric characters, &#39;-&#39;, and &#39;=
_&#39;=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        op=
tions-&gt;acc_protocols =3D p[1];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else if (streq(p[0], &quot;custom-control&quot;) &amp;&amp; p[1] &amp;&=
amp; p[2] &amp;&amp; p[3] &amp;&amp; !p[4])</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        VERIFY_PERMISSION(OPT_P_ACC);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* check if the list from the server is a real subset of o=
ur list */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
truct gc_arena gc_local =3D gc_new();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        struct buffer common_list =3D get_list_intersecti=
on(&amp;gc_local, p[3], options-&gt;acc_protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (buf_len(&amp;common_list) =3D=3D 0 || !streq(p[3=
], buf_cstr(&amp;common_list)))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(msglevel, &quot;App custom control list from server conta=
ins &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                 &quot;unsupported protocols&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc_local);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc_local);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (!streq(p[2], &quot;6:A&quot;=
) &amp;&amp; !streq(p[2], &quot;A:6&quot;))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(msglevel, &quot;App custom control encoding m=
ust be base64 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!at=
oi_constrained(p[1], &amp;options-&gt;pushed_acc_max_message_length,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
    &quot;app custom message message length&quot;, ACC_MIN_MSG_LEN, ACC_MAX=
_MSG_LEN, msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&=
gt;pushed_acc_negotiated_protocols =3D p[3];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq(p[0], &q=
uot;prng&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</s=
pan><br><span>         msg(M_WARN, &quot;NOTICE: --prng option ignored (SSL=
 library PRNG is used)&quot;);</span><br><span>diff --git a/src/openvpn/opt=
ions=2Eh b/src/openvpn/options=2Eh</span><br><span>index c58530a=2E=2E73c13=
54 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++=
 b/src/openvpn/options=2Eh</span><br><span>@@ -713,6 +713,18 @@</span><br><=
span>     /* force using TLS key material export for data channel key gener=
ation */</span><br><span>     bool force_key_material_export;</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** The app=
 custom control protocols we should announce as supported */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const char *acc_protocols;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /** the protocols that are negotiated=
 with the peer=2E This is a</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     *  a temporary variable since options=2Ec push parser cannot a=
ccess</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *  tls mu=
lti struct */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *pushed_acc_negotiated_protocols;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /** the maximum length of an ACC control channel message via push m=
essage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int pushed_acc_max_=
message_length;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     bool vlan_tagging;</span><br><span>     enum vlan_accepta=
ble_frames vlan_accept;</span><br><span>     uint16_t vlan_pvid;</span><br>=
<span>@@ -762,8 +774,10 @@</span><br><span> #define OPT_P_INLINE          (=
1u &lt;&lt; 29)</span><br><span> #define OPT_P_PUSH_MTU        (1u &lt;&lt;=
 30)</span><br><span> #define OPT_P_ROUTE_TABLE     (1u &lt;&lt; 31)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_ACC         =
    (1ull &lt;&lt; 32)</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MOD=
E | OPT_P_PEER_ID | 0x0ull))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Options allowed in the normal configuration file (vs pushed opt=
ions or in ccd files) */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER=
_ID | OPT_P_ACC))</span><br><span> </span><br><span> #define PULL_DEFINED(o=
pt) ((opt)-&gt;pull)</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 42259c3=2E=2Ea18=
f33b 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ =
b/src/openvpn/push=2Ec</span><br><span>@@ -27,6 +27,8 @@</span><br><span> #=
include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span> #include=
 &quot;push=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ac=
c=2Eh&quot;</span><br><span> #include &quot;options=2Eh&quot;</span><br><sp=
an> #include &quot;crypto=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh=
&quot;</span><br><span>@@ -221,9 +223,56 @@</span><br><span> #endif</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+parse_server_pushed_info_acc(struct context *c, struct buffer *buf)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int max_acc_len =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-=
&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;a=
cc_negotiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!multi-&gt;opt=2Eacc_protocols || !c-&=
gt;options=2Epull)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_P=
USH_ERRORS, &quot;Peer tried to push app custom control list &quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
&quot;without client announcing support for it&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* example string to parse: ACC:1400 A:6 flower:happy */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* Skip over the ACC: prefix */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(buf,=
 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *p=
rotocols =3D parse_acc_parameters(buf_cstr(buf), &quot; &quot;, &amp;max_ac=
c_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(D_PUSH_ERRORS, &quot;WARNING: Received ACC info command with invalid para=
meters&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* check if the list from the se=
rver is a real subset of our list */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer common_list =3D get_list_intersection(&a=
mp;gc, protocols, multi-&gt;opt=2Eacc_protocols);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (buf_len(&amp;common_list) =3D=3D 0 || !streq(protocols, =
buf_cstr(&amp;common_list)))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(D_PUSH_ERRORS, &quot;App custom control list from server contains &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
            &quot;unsupported protocols&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 multi-&gt;acc_negotiated_protocols =3D string_alloc(protocols, NULL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;acc_max_me=
ssage_length =3D max_acc_len;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    notify_client_acc_protocols(multi);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-server_pushed_info(co=
nst struct buffer *buffer, const int adv)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+peer_pushed_info(struct context *c, const struct buff=
er *buffer, const int adv)</span><br><span> {</span><br><span>     const ch=
ar *m =3D &quot;&quot;;</span><br><span>     struct buffer buf =3D *buffer;=
</span><br><span>@@ -233,6 +282,12 @@</span><br><span>         m =3D BSTR(&=
amp;buf);</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (strncmp(m, &quot;ACC:&quot;, 4) =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        parse_server_pushed=
_info_acc(c, &amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> #ifdef ENABLE_MANAGEMENT</span><br><span>     struct gc_arena gc;</span=
><br><span>     if (management)</span><br><span>@@ -257,7 +312,7 @@</span><=
br><span>         gc_free(&amp;gc);</span><br><span>     }</span><br><span>=
 #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_PUSH=
, &quot;Info command was pushed by server (&#39;%s&#39;)&quot;, m);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH, &quot;Info =
command was pushed by peer (&#39;%s&#39;)&quot;, m);</span><br><span> }</sp=
an><br><span> </span><br><span> void</span><br><span>@@ -285,6 +340,7 @@</s=
pan><br><span>     msg(D_PUSH, &quot;CR response was sent by client (&#39;%=
s&#39;)&quot;, m);</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span> =
 * Parse the keyword for the AUTH_PENDING request</span><br><span>  * @para=
m buffer                buffer containing the keywords, the buffer&#39;s</s=
pan><br><span>@@ -441,7 +497,6 @@</span><br><span>     const char *const pe=
er_info =3D tls_multi-&gt;peer_info;</span><br><span>     unsigned int prot=
o =3D extract_iv_proto(peer_info);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Calculate the maxi=
mum timeout and subtract the time we already waited */</span><br><span>    =
 unsigned int max_timeout =3D</span><br><span>         max_uint(tls_multi-&=
gt;opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2Ehandshake_window);</s=
pan><br><span>@@ -732,6 +787,12 @@</span><br><span>                 client_=
max_mtu, o-&gt;ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</span><br><span>         =
}</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_mu=
lti-&gt;acc_negotiated_protocols)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        push_option_fmt(gc, push_list, M_USAGE, &quot;custom-control %d A:6=
 %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               tls_multi-&gt;acc_max_message_length, tls_multi-&gt;acc_nego=
tiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span> }</span><br><span> </span><br><span> static bool</spa=
n><br><span>diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh</span>=
<br><span>index 39302f6=2E=2Ee08cd66 100644</span><br><span>--- a/src/openv=
pn/push=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh</span><br><span>@@ -=
52,6 +52,7 @@</span><br><span> </span><br><span> int process_incoming_push_=
request(struct context *c);</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * @brief =
Handles the receiving of a push-update message and applies updates to the s=
pecified</span><br><span>  * options=2E</span><br><span>@@ -92,7 +93,15 @@<=
/span><br><span> </span><br><span> void receive_exit_message(struct context=
 *c);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void server_pushed_info(const struct buffer *buffer, const int adv);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * This message is called when an INFO o=
r INFO_PRE message is received from</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * a peer=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m c         Context of the peer=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param buffer    Buffer containing the INFO/INFO_PRE mess=
age=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param adv=
       number of character to advance past the INFO/INFO_PRE header</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void peer_pushed_info(struct context *c, =
const struct buffer *buffer, const int adv);</span><br><span> </span><br><s=
pan> void receive_cr_response(struct context *c, const struct buffer *buffe=
r);</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl=2Ec b/sr=
c/openvpn/ssl=2Ec</span><br><span>index ddee3eb=2E=2E5b7a1fa 100644</span><=
br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2E=
c</span><br><span>@@ -55,6 +55,7 @@</span><br><span> </span><br><span> #inc=
lude &quot;crypto_epoch=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
acc=2Eh&quot;</span><br><span> #include &quot;ssl_verify=2Eh&quot;</span><b=
r><span> #include &quot;ssl_backend=2Eh&quot;</span><br><span> #include &qu=
ot;ssl_ncp=2Eh&quot;</span><br><span>@@ -1279,6 +1280,7 @@</span><br><span>=
     free(multi-&gt;locked_cn);</span><br><span>     free(multi-&gt;locked_=
username);</span><br><span>     free(multi-&gt;locked_original_username);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(multi-&gt;ac=
c_negotiated_protocols);</span><br><span> </span><br><span>     cert_hash_f=
ree(multi-&gt;locked_cert_hash_set);</span><br><span> </span><br><span>@@ -=
2090,6 +2092,11 @@</span><br><span> #endif</span><br><span>         }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (session-&gt;opt-&gt;acc_protocols)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            buf_printf(&amp;out, &quot;IV_ACC=3D%d,A:6,%s\n&quot;=
, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_protocols);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>         if (session-&gt;opt-&gt;=
push_peer_info_detail &gt; 1)</span><br><span>         {</span><br><span>  =
           struct env_set *es =3D session-&gt;opt-&gt;es;</span><br><span>@=
@ -2390,6 +2397,8 @@</span><br><span>         multi-&gt;remote_ciphername =
=3D string_alloc(&quot;none&quot;, NULL);</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    determin=
e_common_acc_protocols(multi, session);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     if (username_len &lt; 0 || passwo=
rd_len &lt; 0)</span><br><span>     {</span><br><span>         msg(D_TLS_ER=
RORS, &quot;TLS Error: Username (%d) or password (%d) too long&quot;, abs(u=
sername_len),</span><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src=
/openvpn/ssl_common=2Eh</span><br><span>index 9a55ead=2E=2E436770b 100644</=
span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/o=
penvpn/ssl_common=2Eh</span><br><span>@@ -457,6 +457,9 @@</span><br><span> =
    size_t ekm_size;</span><br><span> </span><br><span>     bool dco_enable=
d; /**&lt; Whether keys have to be installed in DCO or not */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /** The app custom control protocols we should a=
nnounce as supported */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *acc_protocols;</span><br><span> };</span><br><span> </s=
pan><br><span> /** @addtogroup control_processor</span><br><span>@@ -730,6 =
+733,12 @@</span><br><span>     int dco_peer_id;</span><br><span> </span><b=
r><span>     dco_context_t *dco;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
* the protocols that are negotiated with the peer=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    char *acc_negotiated_protocols;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /** the maximum length of an ACC cont=
rol channel message */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int acc_max_message_length;</span><br><span> };</span><br><span> </s=
pan><br><span> /**  gets an item  of \c key_state objects in the</span><br>=
<span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_test=
s/openvpn/Makefile=2Eam</span><br><span>index 5efddad=2E=2E70cf7b2 100644</=
span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span=
>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -106,10 +1=
06,12 @@</span><br><span> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LD=
FLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span> ssl_test=
driver_SOURCES =3D test_ssl=2Ec \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	test_acc=2Ec test_acc=2Eh \</span><br><span> 	mock_msg=2Ec m=
ock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_management=2Ec \</span=
><br><span> 	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \</span><br><s=
pan> 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/acc=2Ec \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_=
srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvp=
n/buffer=2Ec \</span><br><span>@@ -130,6 +132,7 @@</span><br><span> 	$(top_=
srcdir)/src/openvpn/run_command=2Ec \</span><br><span> 	$(top_srcdir)/src/o=
penvpn/ssl_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_mb=
edtls=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_s=
rcdir)/src/openvpn/ssl_ncp=2Ec \</span><br><span> 	$(top_srcdir)/src/openvp=
n/ssl_util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_verify_mbe=
dtls=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=
=2Ec \</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_managemen=
t=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>index =
fff4c2b=2E=2Ef572dbb 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
mock_management=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_man=
agement=2Ec</span><br><span>@@ -29,6 +29,7 @@</span><br><span> </span><br><=
span> #include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br>=
<span> #include &quot;manage=2Eh&quot;</span><br><span> </span><br><span> #=
ifdef ENABLE_MANAGEMENT</span><br><span>diff --git a/tests/unit_tests/openv=
pn/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependen=
cies=2Ec</span><br><span>index bf2ccf3=2E=2Ef083f89 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>+=
++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>@@=
 -43,7 +43,8 @@</span><br><span>     uint64_t flags =3D OPT_P_UP | OPT_P_RO=
UTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span>              =
        | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PE=
RSIST</span><br><span>                      | OPT_P_MESSAGES | OPT_P_EXPLIC=
IT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P=
_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT=
_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                     | OPT_P_ACC;</span><br><span>   =
  return flags;</span><br><span> }</span><br><span> </span><br><span>diff -=
-git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/tes=
t_acc=2Ec</span><br><span>new file mode 100644</span><br><span>index 000000=
0=2E=2E9364d12</span><br><span>--- /dev/null</span><br><span>+++ b/tests/un=
it_tests/openvpn/test_acc=2Ec</span><br><span>@@ -0,0 +1,353 @@</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel=
 IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
        over a single TCP/UDP port, with support for SSL/TLS-based</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             session authe=
ntication and key exchange,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             packet encryption, packet authentication, and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet comp=
ression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Ope=
nVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  This program is free software; you can redist=
ribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  it under the terms of the GNU General Public License version 2</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the =
Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This =
program is distributed in the hope that it will be useful,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; withou=
t even the implied warranty of</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General =
Public License for more details=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  You should have received a copy of the GNU General Public License along</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program=
; if not, write to the Free Software Foundation, Inc=2E,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, B=
oston, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;test_acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;mock_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;multi=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+char control_channel_message_sent[2048];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Mock functions */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_co=
ntrol_channel_string_dowork(struct tls_session *session,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                   con=
st char *str, unsigned int msglevel)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_in_range(strlen(str), 0, 2047);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    strcpy(control_channel_message_sent, str);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_push_reply_auth_=
token(struct tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+auth_set_client_reason(struct tls_multi *multi, const char =
*reason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define MSG_PAYLOAD &quot;FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM&=
quot;                \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    &quot;r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0c=
F1d60nTS&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 &quot;4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrw=
CP&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           &quot;AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH&quo=
t; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     &quot;QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc&quot; \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &=
quot;ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA&quot; \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;A=
UEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ&quot; \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    &quot;93rQwit=
yP9eKSijXgcQ=3D=3D&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+test_acc_parse_client_message=
s(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_MANAGEM=
ENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    skip();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* ensure that the messages get to=
 mock_msg */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    x_d=
ebug_level =3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  management =3D (void *)0x12345678;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* contains a TLS 1=2E3 ClientHello */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char msg[] =3D &quot;ACC,cc=
k1,384,6,&quot; MSG_PAYLOAD;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer msg_buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct context c =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    c=2Eoptions=2Emode =3D MODE_SERVER;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;sessio=
n[TM_ACTIVE]=2Eopt =3D &amp;c=2Ec2=2Etls_multi-&gt;opt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[TM_A=
CTIVE]=2Eopt-&gt;mda_context =3D &amp;c=2Ec2=2Emda_context;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (voi=
d *)msg, sizeof(msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_=
message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;WARNING: Received ma=
lformed custom app control channel message (ACC not enabled or no negotiate=
d protocols): 4143432c 63636b31 2c333834 2c362c46 674d4241 526b4241 4145564=
1 774e616[more=2E=2E=2E]&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;acc_negotiated=
_protocols =3D &quot;no:common:protocol&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equ=
al(mock_msg_buf, &quot;WARNING: Received malformed custom app control chann=
el message (protocol &#39;cck1&#39; not in list of negotiated protocols &#3=
9;no:common:protocol&#39;): 4143432c 63636b31 2c333834 2c362c46 674d4241 52=
6b4241 41455641 774e616[more=2E=2E=2E]&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quo=
t;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;a=
cc_negotiated_protocols =3D &quot;cck1:flower:power:fortune&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp=
;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_eq=
ual(mock_msg_buf, &quot;Received custom app control message (protocol &#39;=
cck1&#39;)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,cck1,0,=
&quot; MSG_PAYLOAD);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char flo=
wer_msg[] =3D &quot;ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJ=
vZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    buf_set_read(&amp;msg_buf, (void *)flower_msg, sizeof(flower_msg));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_messag=
e(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(mock_msg_buf, &quot;Received custom app contro=
l message (protocol &#39;flower&#39;)&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot=
;&gt;CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=
=3D=3D&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment=
_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r msg_incorrect_len[] =3D &quot;ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeG=
Zm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=3D&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg_in=
correct_len, sizeof(msg_incorrect_len));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *error =3D &=
quot;WARNING: Received malformed custom app control channel &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        &quo=
t;message (field length 62, payload length 64 mismatch): &quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        &quot;4=
143432c 666f7274 756e652c 36322c36 2c496e73 67496d31 &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                        &quot;6c496=
a6f 67496d5[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_string_equal(mock_msg_buf, error);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char msg_frag=
ment[] =3D &quot;ACC,power,12,6F,aGVsbG8gdw=3D=3D&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *=
)msg_fragment, sizeof(msg_fragment));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_m=
sg_buf, &quot;Received custom app control message (protocol &#39;power&#39;=
, fragment)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,power,=
1,aGVsbG8gdw=3D=3D&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mo=
ck_managment_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* check two encoding present */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char flower_msg_two_encs[] =3D &quot;ACC,flower,4=
8,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf,=
 (void *)flower_msg_two_encs, sizeof(flower_msg_two_encs));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &am=
p;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot;WARNING=
: Received malformed custom app control channel message &quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;(number of enc=
odings must be exactly one (B64=3D1, ASCII=3D1)): &quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &quot;4143432c 666c6f77 65=
722c34 382c3641 2c535342 68625341 41494574 &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;6c636d3[more=2E=2E=2E]&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf=
, error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_string_equal(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* no encoding present */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const char flower_msg_no_encs[] =3D &quot;ACC,flowe=
r,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf=
, (void *)flower_msg_no_encs, sizeof(flower_msg_no_encs));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp=
;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot;WARNING:=
 Received malformed custom app control channel message &quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            &quot;(number of enco=
dings must be exactly one (B64=3D0, ASCII=3D0)): &quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            &quot;4143432c 666c6f77 657=
22c34 382c2c53 53426862 53414149 45746c63 &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &quot;6d31706[more=2E=2E=2E]&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_=
equal(mock_msg_buf, error);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(mock_managment_buf, &quot;&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    x_debug_level =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    management =3D NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_parse_acc_parameter=
s(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* parameters to INFO message */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const char *info_acc_msg =3D &quot;4096 A:6 flower:happy&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int max_len =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char *protocols =3D p=
arse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_strin=
g_equal(protocols, &quot;flower:happy&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1280);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* a client does not accept a length longer tha=
n it supports */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_l=
en, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* mes=
sage with lower limit than our, should work for client and server */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot=
;1111 A:6 flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot=
;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_string_equal(protocols, &quot;flower:happy&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(max_len, 1111);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D par=
se_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_=
equal(protocols, &quot;flower:happy&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1111);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* more encodings than supported=2E Server should=
 be okay, client should fail */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    info_acc_msg =3D &quot;1200 A:6:B flower:happy&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_a=
cc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(proto=
cols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_para=
meters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(proto=
cols, &quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(max_len, 1200);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* extra parameter */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    info_acc_msg =3D &quot;1400 A:6 flower:happy 77&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D p=
arse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(=
protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc=
_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protoco=
ls);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char *iv_acc_capabilities =3D &quot;1400,A:=
6,flower:happy:power&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    protocols =3D parse_acc_parameters(iv_acc_capabilities, &quot;,=
&quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_string_equal(protocols, &quot;flower:happy:pow=
er&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* too small protocol le=
ngth */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc=
_msg =3D &quot;32 A:6 flower:happy&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, =
&quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* non-numerical protocol length */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;abff A:6 flow=
er:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_le=
n, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(=
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+test_acc_common_protocols(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct multi_instance mi =3D { 0 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi=2Econ=
text;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;opti=
ons=2Egc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CL=
EAR_GC(c-&gt;c2=2Etls_multi, struct tls_multi, &amp;c-&gt;options=2Egc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;peer_info =
=3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_=
protocols =3D &quot;power:flower:star&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_mul=
ti;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;op=
t=2Eacc_protocols =3D c-&gt;options=2Eacc_protocols;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;session[TM_ACTIVE]=2Eopt =
=3D &amp;multi-&gt;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    multi-&gt;opt=2Ees =3D env_set_create(&amp;c-&gt;options=2Egc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_protocols(multi,=
 &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(multi-&gt;acc_max_message_length, ACC_M=
AX_MSG_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_string_equal(multi-&gt;acc_negotiated_protocols, &quot;power:flower&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(env_set_ge=
t(multi-&gt;opt=2Ees, &quot;acc_protocols&quot;), &quot;acc_protocols=3Dpow=
er:flower&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc_message_len=
&quot;), &quot;acc_message_len=3D1280&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    free(multi-&gt;acc_negotiated_protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt;options=2Egc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_acc_send_message(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct multi_instance mi =3D { 0 };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct context *c =3D &amp;mi=2Econtext;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Egc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c-&gt;c2=2E=
tls_multi, struct tls_multi, &amp;c-&gt;options=2Egc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    bool ret;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls=
_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;op=
tions=2Eacc_protocols =3D &quot;power:flower:emergency&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Eacc_protocols=
 =3D c-&gt;options=2Eacc_protocols;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;multi-&gt;o=
pt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;op=
t=2Ees =3D env_set_create(&amp;c-&gt;options=2Egc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D=
4321\nIV_ACC=3D1400,A:6,flower:emergency:power&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_protocols(multi,=
 &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct tls_session *session =3D &amp;c-&gt;c2=2Etls_mult=
i-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D s=
end_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;emergency&quot;, tr=
ue,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
           &quot;EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:&quot;, =
false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(contr=
ol_channel_message_sent,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        &quot;ACC,emergency,50,AF,EMERGENCY BROADCAST =
MESSAGE - THIS IS NOT A DRILL:&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;emerge=
ncy&quot;, false,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                         &quot;THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED=
 ALERT FOR YOUR AREA=2E&quot;, false);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(ret);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(control_channel_message_sent,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    &quot;ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED A=
LERT FOR YOUR AREA=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* test a long message (=
&gt; 1000) with fragment to get the maximum header size */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    char long_message[1200] =3D { 0 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 1024; i=
++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        long_message[i] =3D (c=
har)(&#39; &#39; + (i % 95));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* last char of the=
 message is a i and then a \0 */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(long_message[1023], &#39;i&#39;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(long_m=
essage[1024], &#39;\0&#39;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;emergency&quot=
;, true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                long_message, false);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    size_t cc_len =3D strlen(control_channel_message_sent);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(control_chann=
el_message_sent[cc_len - 1], &#39;i&#39;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *expected_start_cc =3D &quot;ACC,emer=
gency,1024,AF, !\&quot;#$%&amp;&#39;()*+,-=2E/012345&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(control_cha=
nnel_message_sent, expected_start_cc, strlen(expected_start_cc));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    free(multi-&gt;acc_negotiated_protocols);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt=
;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_list_intersection(void **state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *empty =3D &quot;&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *protos =3D &quot;powe=
r:flower:emergency&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er t1 =3D get_list_intersection(&amp;gc, empty, protos);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_len(&amp;t1),=
 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t2 =3D get_list_=
intersection(&amp;gc, protos, empty);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(buf_len(&amp;t2), 0);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer t3 =3D get_list_intersection(&amp;g=
c, protos, protos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_string_equal(buf_cstr(&amp;t3), protos);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *protos2 =3D &quot;flower:emergency:power:mar=
io&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer t4 =3D get_list_intersection(&amp;gc, protos2, protos);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(buf_cst=
r(&amp;t4), &quot;flower:emergency:power&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *protos3 =3D &quot;super:paper:mario:flower&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t=
5 =3D get_list_intersection(&amp;gc, protos2, protos3);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t=
5), &quot;flower:mario&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *proto4 =3D &quot;flower:flower:flower:flower&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t6 =3D get_list_i=
ntersection(&amp;gc, proto4, &quot;flower&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t6), &q=
uot;flower&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh</sp=
an><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E32421f=
b</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_acc=2Eh</span><br><span>@@ -0,0 +1,35 @@</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a=
 single UDP port, with support for SSL/TLS-based</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             session authentication and key =
exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     packet encryption, packet authentication, and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;=
sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This prog=
ram is free software; you can redistribute it and/or modify</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU G=
eneral Public License version 2</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  as published by the Free Software Foundation=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that=
 it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNE=
SS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  GNU General Public License for more details=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eo=
rg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifndef TEST_ACC_H</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define TEST_ACC_H</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void test_acc_parse_client_messages(void **state);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void test_parse_acc_parameters(void **state)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void test_acc_common_protocols(void *=
*state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_send_message(voi=
d **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void test_list_intersection=
(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span>diff --git a/tests/unit_tests/openvpn/test_common=2Eh b/=
tests/unit_tests/openvpn/test_common=2Eh</span><br><span>index 5dae79b=2E=
=2E85e099f 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_commo=
n=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/test_common=2Eh</span>=
<br><span>@@ -43,11 +43,13 @@</span><br><span> #define LargestIntegralType =
uintmax_t</span><br><span> #endif</span><br><span> /* redefine 2=2Ex API in=
 terms of 1=2Ex API */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define CMockaValueData             LargestIntegralType</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define check_expected_uint         chec=
k_expected</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define exp=
ect_uint_value           expect_value</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define expect_check_data           expect_check</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define cast_ptr_to_cmocka_value=
(x) (x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CMoc=
kaValueData                       LargestIntegralType</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define check_expected_uint              =
     check_expected</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define expect_uint_value                     expect_value</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define expect_check_data           =
          expect_check</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define cast_ptr_to_cmocka_value(x)           (x)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define assert_int_in_range(value, min, m=
ax)  assert_in_range((value), (min), (max))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define assert_uint_in_range(value, min, max) asser=
t_in_range((value), (min), (max))</span><br><span> #endif</span><br><span> =
</span><br><span> /**</span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index=
 4baf8cc=2E=2E4987dd0 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</=
span><br><span>@@ -52,6 +52,8 @@</span><br><span> #include &quot;ssl_verify=
=2Eh&quot;</span><br><span> #include &quot;openvpn=2Eh&quot;</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;t=
est_acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> /* Mock function to be allowed to include win32=2Ec which i=
s required for</span><br><span>  * getting the temp directory */</span><br>=
<span> #ifdef _WIN32</span><br><span>@@ -86,6 +88,20 @@</span><br><span> {<=
/span><br><span>     return;</span><br><span> }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+reschedule_multi_process(struct context *c)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define a dummy =
dco cipher option to avoid linking against all the DCO</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * units */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+const char *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+dco_get_supported_ciphers(void)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return &quot;AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-=
128-GCM:CHACHA20-POLY1305&quot;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span> </span><br><span> /* generated using</span><br><span>  *=
 openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout =
- \</span><br><span>@@ -1111,8 +1127,12 @@</span><br><span>         cmocka_=
unit_test(ssl_test_extract_last_matching_field),</span><br><span>         c=
mocka_unit_test(ssl_test_reject_null_in_cert_subject),</span><br><span>    =
     cmocka_unit_test(ssl_test_escape_rfc_2253_chars_in_subject),</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(ssl_te=
st_extract_peer_info)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit=
_test(ssl_test_extract_peer_info),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_acc_parse_client_messages),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_parse_acc_parameters),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_acc_common_protocols),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_a=
cc_send_message),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_list_intersection)</span><br><span>     };</spa=
n><br><span> </span><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br=
></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858?usp=3Demail">change 1858</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 26 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Mqa+Z/xrNKg=--


--===============2065156662369645338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2065156662369645338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2065156662369645338==--

