Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52508606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Mv/zFbVB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LkQpPlIr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Kxf8LP1S;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KcgMrz26
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Q2fkEgRTUUIMn7359OcWINwnFunF2NleBMYvKcEZlis=; b=Mv/zFbVBlEvWtWCOIA8KMiJt/w
	KOWBWQxPs0b6eExHv6rpUOUg21JdHw40RwIfa9vDlwBhKh+YT//Uoj7BSdxrEnNWpHgj+NdbZ8JoJ
	o8GfWkBGSdVG7ZK9dQXCSI+tZrStCNmrLxDHO9sBAYQko7vrKEmSZ8dTJHJir3HGW6Zw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLgTq-000000000Zi-2ead;
	Tue, 27 Oct 2026 12:40:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLgTo-000000000ZO-3o2Y
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:40:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oHDjXRsBfkJ6NpqtbZQBHEzzwzEZlC83cNOe4qB9Q4A=; b=LkQpPlIrePbOzLK714fK2Vm9il
 onIKLV0ukI1gikF22jtNdH3XCtbaez1LJGU/0RH50tegR9MsADnrYdzqTRJulKkjgVXYhlas5vk/k
 oyWbkVvUaUVwVUWq7CRjHJgruS2myYKY7sJc0YaMlvifKk4EdZiUdOujbsRCwuhd2Lh8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oHDjXRsBfkJ6NpqtbZQBHEzzwzEZlC83cNOe4qB9Q4A=; b=Kxf8LP1S0AB1OS4bmQq6flvV+k
 KsqUE1wRkFmvktoNZoZHbX/uj+GBv+WP4r9bZ1RlNpepTtCfKjycq0Mnhj94zZSiJpQDsmECSmAWn
 w4R1b4UNrdKE94VF4pftXWoUGfePYCY1PQswn5dHhHwTdqloC0GQUqpUyCw5Mbcsw58Q=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLgTL-000000005ZF-44Ji for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:40:18 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso42565155e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 05:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793104805; x=1793709605; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oHDjXRsBfkJ6NpqtbZQBHEzzwzEZlC83cNOe4qB9Q4A=;
 b=KcgMrz26qR0r9M0qRxrd7IYNASHEVCs7s8GyffuhA3SjCjW3K+UKRGbGR41fjNE9hC
 univdZ08Jh9D8cEfjKIJrNkAEUbiigD2ek3VJoSZ2oEQ1rj2ZVu+8WtMMAlA9r+gbvRA
 Sm49+5z3RonmgsGjgcYSXtAR4Rj5gwIhN20DNLIRJ6K+ZoCGgoc3ZEEefKOH+lt/HT2f
 BFZS0/vt1fmfJTLOIFtaGR72zXlGyReoHtWgCeeT1F5HTeWcSxs/UCyDmGu1mW3phTCk
 RgzHzkAkHYc/Fk44EOhHS7dRtAtVBsVFS72kKHwoSQFesYhLt4KaqWgDkq/w1mSkLdvz
 rN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793104805; x=1793709605;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oHDjXRsBfkJ6NpqtbZQBHEzzwzEZlC83cNOe4qB9Q4A=;
 b=AzzDIiUJX0UUdVWyTQbyDYfj4qcNG+cfpq1HTjsWE2t6hil9NiuHqkOq0Mp8//BAr8
 7wwqQ03fheky99zv+zBVTDfqbAK3CmHpGSNUs6/aDQqwgXnrsL0w7mt9BSL3apJbFl8Q
 9AuZmJZuH4+EYz8faq5TN6vXGWeWLhvFTYnF/BXclT3PViMm7dP+PSTHr5RC9KSpUvlH
 cE3PIUNffETHQcWDSBC8s+RmEnytJDZ76YpVpCrmUyslZlTbvR2Cp2Zr6Fyn2Evx6u7w
 QbKFd1Svj13JXbmV+cp6SBtKzoXHdndVhUZTwNXAKJxRttfvXB8sECUdLggo7RFUP42N
 Jhdg==
X-Gm-Message-State: AFq9FYJc+nsL8vCd/C1PNYSy9pX020jcWRBETjhRme6A6adxMD2aor9T
 ZRKUbr7wVWxxHWWhfe9qyIFOIubAwhWBq3jpD+hOuSuXvhsBDpcAKuogDwE6Wf4+9iZmsTdsQDO
 sp9EKZ8YOsEa4FGRW0oCApWT6gK+l8fl59bgsOFToAqyfpHWbA4gFDDYV7LKH+EEBFY69Axbelr
 bHl1C+Kg==
X-Gm-Gg: AYBFou3T588k/sBxOs1h1B+7z87jenvcgMMJr9aw/oFCDddaNiz9fLK5A3adtuzi0nG
 IaZ81dtNU9lwRvrLrUAIodZ9zNrDtAwDGh5kssuUbmucOn/N7e5jBj3SElsTBH6dM2XygS5Ifkf
 eNLArBm00R50sloZiRRduP65IZxOf1t1O60fBU8m44SEA4y44Dg7PZ1wvJREPsw+klMFGCXaWSf
 Misuq86Dw8UX/Vggbz/uB8pVVpAbOBAGFPNkhSkn0H0RsIdUFtG5dEsAcr0+mv1pZubdP5o8z8/
 JYMDl4/WJ+tBewjPXucsQ/3FVobggd8SaVOJpcCBmJzNsIGbuX/yuzh7l8ms5hmdVBBHVRCamxT
 sbDaHZ8D4oVb6pY2NtxarfwjBOASAzwOal80vobisGeoq38OMHKIgF10SeD6L8b2PHXGv8VVmTL
 TJU1P6NJErKHTwz5Ncvh1P4W74F8kHTVM02Cd9vWtLGz1CMCDIP12Ee86Qt1OlmgQOUR98YlLyN
 7aPUBfb0QHtGrsSvRaZNjNEm0FZRGP6mnj+htc5DNCZrVyrdBMhUZcjIGgGooAbwDKdftz2pSBt
 hBrI6jEQj+mxPWQsA5L5tQGpBjvSKhGbQVhEAqBZ+1el3NykyEW8MiRDtnopDfxYiKOEq+2G0gB
 7lrFd8l6mB1Hrsgp1g3SlfoC5H3O5leibIhLJ28Bu6w==
X-Received: by 2002:a05:600c:8b85:b0:4a1:7c7d:8881 with SMTP id
 5b1f17b1804b1-4a35ac965e9mr181217795e9.13.1793104804148; 
 Tue, 27 Oct 2026 05:40:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ad39sm687974725e9.1.2026.10.27.05.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:40:03 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 12:39:55 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 697ff7bdae6b1547f6e389fb0cf45cdbe396f263
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9352308f2bcb4669bff4fa759c1938595c82369d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLgTL-000000005ZF-44Ji
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
Content-Type: multipart/mixed; boundary="===============1102980919464865923=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1102980919464865923==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MoJAN2gCbRo="; charset=UTF-8

--MoJAN2gCbRo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1858?usp=3Demail

to look at the new patch set (#14)=2E


Change subje=
ct: Implement sending/receiving app custom control protocol messages
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Implement sending/r=
eceiving app custom control protocol messages

This allows openvpn GUI/fron=
t-ends and server via management
to use the OpenVPN control channel to pass=
 messages between each other
while OpenVPN handles the marshalling/unmarsha=
lling of these and
negotiate the common app custom control protocols=2E

Th=
is provides an easy to use secure channel that does not depend on
the netwo=
rk itself to work and can also used before fully authenticating
the client=
=2E See the management-notes=2Etxt for more details how to use
this feature=
=2E An upcoming patch will also add some example python
script that showcas=
e this feature=2E

Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Sig=
ned-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M doc/=
man-sections/client-options=2Erst
M doc/man-sections/management-options=2Er=
st
M doc/man-sections/script-options=2Erst
M doc/management-notes=2Etxt
M s=
rc/openvpn/Makefile=2Eam
A src/openvpn/acc=2Ec
A src/openvpn/acc=2Eh
M src/=
openvpn/forward=2Ec
M src/openvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/o=
penvpn/manage=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/options=2Ec
M src/o=
penvpn/options=2Eh
M src/openvpn/push=2Ec
M src/openvpn/push=2Eh
M src/open=
vpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M tests/unit_tests/openvpn/Makefil=
e=2Eam
M tests/unit_tests/openvpn/mock_management=2Ec
A tests/unit_tests/op=
envpn/mock_management=2Eh
M tests/unit_tests/openvpn/mock_push_dependencies=
=2Ec
A tests/unit_tests/openvpn/test_acc=2Ec
A tests/unit_tests/openvpn/tes=
t_acc=2Eh
M tests/unit_tests/openvpn/test_common=2Eh
M tests/unit_tests/ope=
nvpn/test_misc=2Ec
M tests/unit_tests/openvpn/test_ssl=2Ec
28 files changed=
, 1,516 insertions(+), 26 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/58/1858/14

diff --git a/CMakeLists=2Etxt=
 b/CMakeLists=2Etxt
index 184a95a=2E=2E00caa2d 100644
--- a/CMakeLists=2Etx=
t
+++ b/CMakeLists=2Etxt
@@ -435,6 +435,8 @@
     src/compat/compat-strlcpy=
=2Ec
     src/compat/compat-strsep=2Ec
     src/compat/compat-strtok_r=2Ec
=
+    src/openvpn/acc=2Ec
+    src/openvpn/acc=2Eh
     src/openvpn/argv=2Ec=

     src/openvpn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -571,8 +573,8 @@
=
     src/openvpn/ps=2Ec
     src/openvpn/ps=2Eh
     src/openvpn/push=2Ec
-=
    src/openvpn/push_util=2Ec
     src/openvpn/push=2Eh
+    src/openvpn/pu=
sh_util=2Ec
     src/openvpn/pushlist=2Eh
     src/openvpn/reflect_filter=
=2Ec
     src/openvpn/reflect_filter=2Eh
@@ -826,7 +828,10 @@
             =
tests/unit_tests/openvpn/mock_management=2Ec
             tests/unit_tests/=
openvpn/mock_ssl_dependencies=2Ec
             tests/unit_tests/openvpn/moc=
k_win32_execve=2Ec
+            tests/unit_tests/openvpn/test_acc=2Ec
+    =
        src/openvpn/acc=2Ec
             src/openvpn/argv=2Ec
+            =
src/openvpn/auth_token=2Ec
             src/openvpn/base64=2Ec
            =
 src/openvpn/crypto_epoch=2Ec
             src/openvpn/crypto_mbedtls=2Ec
@=
@ -840,8 +845,11 @@
             src/openvpn/options_util=2Ec
             =
src/openvpn/otime=2Ec
             src/openvpn/packet_id=2Ec
+            s=
rc/openvpn/reliable=2Ec
+            src/openvpn/session_id=2Ec
           =
  src/openvpn/run_command=2Ec
             src/openvpn/ssl_mbedtls=2Ec
+   =
         src/openvpn/ssl_ncp=2Ec
             src/openvpn/ssl_openssl=2Ec
 =
            src/openvpn/ssl_util=2Ec
             src/openvpn/ssl_verify_mb=
edtls=2Ec
@@ -858,6 +866,8 @@
     target_sources(test_misc PRIVATE
       =
  tests/unit_tests/openvpn/mock_get_random=2Ec
         tests/unit_tests/op=
envpn/test_schedule=2Ec
+        tests/unit_tests/openvpn/mock_management=
=2Ec
+        src/openvpn/base64=2Ec
         src/openvpn/options_util=2Ec
=
         src/openvpn/otime=2Ec
         src/openvpn/ssl_util=2Ec
diff --git=
 a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-options=
=2Erst
index 87c138a=2E=2Eb204d6a 100644
--- a/doc/man-sections/client-opti=
ons=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -12,6 +12,17 @@
  =
 When this option is set, OpenVPN will not drop incoming tun packets with
 =
  same destination as host=2E
 
+--app-custom-control protocollist
+  Sets =
the list of supported app custom control protocols=2E
+  These protocols ar=
e announced to the server when this option is used
+  as a client=2E If the=
 option is set on a server it will negotiate the
+  common protocols with t=
he client=2E
+
+  The protocollist is a : separated list of protocol identi=
fiers=2E
+
+  See management-notes=2Etxt in the OpenVPN distribution and th=
e OpenVPN RFC
+  draft for a description of app custom control protocol sup=
port=2E
+
 --auth-token token
   This is not an option to be used directly =
in any configuration files,
   but rather push this option from a ``--clien=
t-connect`` script or a
@@ -437,6 +448,12 @@
         Additional authentica=
tion methods supported by the client=2E
         This may be set by the cli=
ent UI/GUI using ``--setenv``=2E
 
+  :code:`IV_ACC=3D<max_msg_len>,<flags>=
,<protocols>`
+        If the option ``--app-custom-control`` is set, the c=
lient will
+        send the supported max ACC message length, the supporte=
d formats
+        as (:code:`A:6`) and the list of configured protocols (e=
=2Eg=2E
+        :code:`flower:happy:power`)
+
   The following flags depen=
d on which compression formats are compiled in
   and whether compression i=
s allowed by options=2E See `Protocol options`_
   for more details=2E
diff=
 --git a/doc/man-sections/management-options=2Erst b/doc/man-sections/manag=
ement-options=2Erst
index e2e0773=2E=2Ef32273f 100644
--- a/doc/man-section=
s/management-options=2Erst
+++ b/doc/man-sections/management-options=2Erst
=
@@ -144,3 +144,9 @@
 
 --management-up-down
   Report tunnel up/down events=
 to management interface=2E
+
+--app-custom-control protocol-list
+  Sets t=
he app custom control protocols that are supported and should be
+  negotia=
ted=2E protocol-list is a list of allowed protocols separated by :
+  A cli=
ent will announce these protocols via the IV_ACC variable and the
+  server=
 will notify the client about the common protocols=2E
diff --git a/doc/man-=
sections/script-options=2Erst b/doc/man-sections/script-options=2Erst
index=
 f420380f=2E=2E9c17c3b 100644
--- a/doc/man-sections/script-options=2Erst
+=
++ b/doc/man-sections/script-options=2Erst
@@ -1006,3 +1006,12 @@
        X=
509_1_L=3DBISHKEK
        X509_1_ST=3DNA
        X509_1_C=3DKG
+
+:code:`ac=
c_protocols`
+    If ``--app-custom-control`` is configured and the client =
supports any of the
+    protocols that server also supports, this variable=
 contains a list of
+    common protocols separated by :=2E
+
+:code:`acc_m=
essage_len`
+    if :code:`acc_protocols` is set, this variable contains th=
e maximum
+    message length for app custom protocol message=2E
\ No newli=
ne at end of file
diff --git a/doc/management-notes=2Etxt b/doc/management-=
notes=2Etxt
index 4d726c4=2E=2E8fffd0c 100644
--- a/doc/management-notes=2E=
txt
+++ b/doc/management-notes=2Etxt
@@ -828,6 +828,59 @@
 that is required=
 to continue the connection (unlike MFA or opening a browser)
 this message=
 is not negotiated but can just be sent as a gratuitous message=2E
 
+app c=
ustom control
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+If t=
he special string "ACC" is passed as {EXTRA} OpenVPN will determine
+the co=
mmon app custom protocols between the client and the server and instruct
+t=
he client that the server will send control messages to the client using
+t=
he ACC protocol=2E
+
+The server should then use acc-msg command to send ap=
p custom control messages
+to the client to facilitate the pending authenti=
cation=2E
+
+COMMAND -- client-acc-msg (OpenVPN 2=2E8 or higher)
+---------=
---------------------------------
+
+On an OpenVPN instance running in serv=
er mode this command sends an
+app custom control message to a client=2E Th=
e format of the command is:
+
+  client-acc-msg {CID} {KID}
+  {protocol}
+=
  {flags}
+  {message}
+  END
+
+CID,KID -- client ID and Key ID=2E See doc=
umentation for ">CLIENT:"
+notification for more info=2E
+
+protocol -- the=
 ACC protocol identifier that this message should be
+            tagged wi=
th=2E
+
+flags    -- a colon separated list of the encoding and the flag if=

+            the message is a fragment=2E E=2Eg=2E "6:F" for a base64 enco=
ded
+            message that is also a fragment and not complete yet=2E
+
=
+message  -- The message encoded in the encoding specified in flags
+
+
+CO=
MMAND -- acc-msg (OpenVPN 2=2E8 or higher)
+-------------------------------=
-----------
+
+When OpenVPN is running in --client mode this command sends =
an app
+custom command to the server=2E The format of the command is
+
+  a=
cc-msg
+  {protocol}
+  {flags}
+  {message}
+  END
+
+See the client-acc-m=
sg command for more details about the format of the
+message=2E Since a cli=
ent has only one peer there is no need to specify the
+client id and key id=
=2E
+
+>>>>>>> fd23ffa35a (Implement sending/receiving app custom control p=
rotocol messages)
+
 COMMAND -- client-deny  (OpenVPN 2=2E1 or higher)
 ---=
--------------------------------------------
 
@@ -1302,6 +1355,39 @@
    r=
esponse=2E Mechanisms that need multiple rounds or more complex answers
   =
 should implement a different response type than CR_RESPONSE=2E
 
+(6) App =
custom control message
+
+    This message is an application specific paylo=
ad message that is transported
+    over the OpenVPN control channel=2E
+
+=
    In server mode:
+
+    >CLIENT:ACC,{CID},{KID},{protocol},{fragment},{m=
sg_base64}
+
+    In client mode:
+
+    >ACC:{protocol},{fragment},{msg_ba=
se64}
+
+    The protocol is a short ascii string identifying the app speci=
fic custom
+    protocol=2E If fragment is set to 1, the message is not com=
plete and the
+    next message should be concatenated to this message to f=
orm a complete
+    message=2E
+
+(7) App custom control protocol message
+=

+   This message informs the client about the common ACC
+   protocols and=
 the maximum message length for an ACC message=2E
+
+   In client mode:
+
+=
   >ACC_PROTOCOLS:protocols=3D{protocol_list},message_len=3D{max_msg_len}
+=

+   protocol_list is a list of supported protocols by the client=2E For ex=
ample
+   flower:power:sys_info would indicate these three protocols to be =
supported=2E
+   max_msg_len specifies the maximum message length that the =
peer supports=2E
+
+   In server mode these are available in the acc_protoc=
ols and
+   acc_message_len variables of the client environment=2E
 
 Varia=
bles:
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
=
index 8a60a94=2E=2Eebc4db6 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src=
/openvpn/Makefile=2Eam
@@ -45,6 +45,7 @@
 sbin_PROGRAMS =3D openvpn
 
 open=
vpn_SOURCES =3D \
+	acc=2Ec acc=2Eh \
 	argv=2Ec argv=2Eh \
 	auth_token=2E=
c auth_token=2Eh \
 	base64=2Ec base64=2Eh \
@@ -124,7 +125,8 @@
 	proto=2E=
c proto=2Eh \
 	proxy=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \
-	push=2Ec push_uti=
l=2Ec push=2Eh \
+	push=2Ec push=2Eh \
+	push_util=2Ec \
 	pushlist=2Eh \
 =
	reflect_filter=2Ec reflect_filter=2Eh \
 	reliable=2Ec reliable=2Eh \
diff=
 --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
new file mode 100644
ind=
ex 0000000=2E=2E5f6daa5
--- /dev/null
+++ b/src/openvpn/acc=2Ec
@@ -0,0 +1,=
413 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ =
*             over a single TCP/UDP port, with support for SSL/TLS-based
+ =
*             session authentication and key exchange,
+ *             pack=
et encryption, packet authentication, and
+ *             packet compressio=
n=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Cop=
yright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program=
 is free software; you can redistribute it and/or modify
+ *  it under the =
terms of the GNU General Public License version 2
+ *  as published by the =
Free Software Foundation=2E
+ *
+ *  This program is distributed in the hop=
e that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the i=
mplied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  Y=
ou should have received a copy of the GNU General Public License along
+ * =
 with this program; if not, write to the Free Software Foundation, Inc=2E,
=
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+=
#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2E=
h"
+
+#include <string=2Eh>
+#include "buffer=2Eh"
+#include "error=2Eh"
+#=
include "acc=2Eh"
+#include "forward=2Eh"
+#include "options_util=2Eh"
+#in=
clude "ssl_util=2Eh"
+#include "ssl_ncp=2Eh"
+#include "multi=2Eh"
+
+enum =
acc_message_flag
+{
+    ACC_MESSAGE_FLAGS_ASCII =3D 1,
+    ACC_MESSAGE_FL=
AGS_BASE64 =3D 2,
+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,
+};
+
+
+static vo=
id
+log_acc_message(struct context *c, const struct buffer *buf, int payloa=
d_len,
+                const char *protocol, int flags)
+{
+    bool fragm=
ent =3D flags & ACC_MESSAGE_FLAGS_FRAGMENT;
+#ifdef ENABLE_MANAGEMENT
+    =
struct gc_arena gc =3D gc_new();
+    const char *payload_msg =3D NULL;
+
+=
    /* For simplicity, we always encode payload to be base64 encoded
+     =
* if not already in base64 format */
+    if (flags & ACC_MESSAGE_FLAGS_ASC=
II)
+    {
+        char *b64out =3D NULL;
+        ASSERT(openvpn_base64_e=
ncode(CBPTR(buf), payload_len, &b64out) >=3D 0);
+        gc_addspecial(b64=
out, free, &gc);
+        payload_msg =3D b64out;
+    }
+    else
+    {
+=
        payload_msg =3D CBSTR(buf);
+    }
+
+    if (management)
+    {
+ =
       struct tls_session *session =3D &c->c2=2Etls_multi->session[TM_ACTIV=
E];
+
+        if (c->options=2Emode =3D=3D MODE_SERVER)
+        {
+      =
      /* server mode=2E Report client context */
+            struct man_de=
f_auth_context *mda =3D session->opt->mda_context;
+            unsigned in=
t mda_key_id =3D get_primary_key(c->c2=2Etls_multi)->mda_key_id;
+         =
   msg(M_CLIENT, ">CLIENT:ACC,%lu,%u,%s,%d,%s",
+                mda->cid, =
mda_key_id, protocol, fragment, payload_msg);
+        }
+        else
+   =
     {
+            /* Client mode=2E Do not a report a CLIENT id */
+     =
       msg(M_CLIENT, ">ACC:%s,%d,%s", protocol, fragment, payload_msg);
+  =
      }
+    }
+    gc_free(&gc);
+#endif /* ifdef ENABLE_MANAGEMENT */
+  =
  msg(D_PUSH, "Received custom app control message (protocol '%s'%s)",
+   =
     protocol, fragment ? ", fragment" : "");
+}
+
+
+/**
+ *  Parses the f=
lags field of an app control message and moves the
+ *  buffer past the fla=
gs string=2E If there is an
+ *  error parsing the flags field the method r=
eturns -1 and
+ *  puts the error reason in err_reason
+ */
+static int
+pa=
rse_acc_message_flags(struct buffer *buf, const char **err_reason, struct g=
c_arena *gc)
+{
+    const char *flags =3D buf_extract_field(buf, ',', gc);=

+
+    if (!flags)
+    {
+        *err_reason =3D "could not extract flag=
s field";
+        return -1;
+    }
+
+
+    int acc_flags =3D 0;
+
+    f=
or (const char *flag =3D flags; *flag !=3D '\0'; flag++)
+    {
+        if=
 (*flag =3D=3D 'A')
+        {
+            acc_flags |=3D ACC_MESSAGE_FLAG=
S_ASCII;
+        }
+        else if (*flag =3D=3D '6')
+        {
+       =
     acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;
+        }
+        else if (=
*flag =3D=3D 'F')
+        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_=
FRAGMENT;
+        }
+        else
+        {
+            *err_reason =3D =
"Unknown flag in flags";
+            return -1;
+        }
+    }
+    /* =
The message should be encoded with exactly one encoding=2E Ensure that
+   =
  * only one of the flags is present */
+    bool asciienc =3D (bool)(acc_f=
lags & ACC_MESSAGE_FLAGS_ASCII);
+    bool base64enc =3D (bool)(acc_flags &=
 ACC_MESSAGE_FLAGS_BASE64);
+
+    if (base64enc + asciienc !=3D 1)
+    {
=
+        char *tmp =3D gc_malloc(512, 1, gc);
+        snprintf(tmp, 512, "=
number of encodings must be exactly one "
+                           "(B64=
=3D%d, ASCII=3D%d)",
+                 base64enc, asciienc);
+        *err_=
reason =3D tmp;
+        return -1;
+    }
+
+    return acc_flags;
+}
+
+
=
+void
+receive_acc_message(struct context *c, const struct buffer *buffer)
=
+{
+    struct gc_arena gc =3D gc_new();
+    const char *err_reason =3D ""=
;
+
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */
+    struc=
t buffer buf =3D *buffer;
+
+    if (!buf_advance(&buf, strlen("ACC")) || b=
uf_read_u8(&buf) !=3D ',')
+    {
+        err_reason =3D "missing , after =
ACC";
+        goto err;
+    }
+
+    /* extract protocol, payload length,=
 flags substrings */
+    const char *protocol =3D buf_extract_field(&buf, =
',', &gc);
+    if (!protocol)
+    {
+        err_reason =3D "could not ex=
tract protocol field";
+        goto err;
+    }
+
+    int payload_len;
+ =
   const char *payload_len_str =3D buf_extract_field(&buf, ',', &gc);
+    =
if (!payload_len_str || !((payload_len =3D atoi(payload_len_str))))
+    {
=
+        err_reason =3D "could not extract payload length field";
+        =
goto err;
+    }
+
+    int flags =3D parse_acc_message_flags(&buf, &err_re=
ason, &gc);
+
+    if (flags < 0)
+    {
+        goto err;
+    }
+
+    /=
* We should have a final NUL byte in the control message buffer
+     * and=
 thus the length of the buffer should be payload_len + 1 */
+    if (buf_le=
n(&buf) !=3D payload_len + 1)
+    {
+        char *tmp =3D gc_malloc(512, =
1, &gc);
+        snprintf(tmp, 512, "field length %d, payload length %d mi=
smatch",
+                 payload_len, buf_len(&buf) - 1);
+        err_re=
ason =3D tmp;
+        goto err;
+    }
+
+
+    log_acc_message(c, &buf, p=
ayload_len, protocol, flags);
+    gc_free(&gc);
+    return;
+
+err:
+    =
msg(D_PUSH_ERRORS, "WARNING: Received malformed custom app control channel =
"
+                       "(%s) message control message: %s",
+        err_=
reason,
+        format_hex(BPTR(&buf), BLEN(&buf), 80, &gc));
+    gc_free=
(&gc);
+}
+
+
+bool
+send_acc_message(struct context *c,
+                 =
struct tls_multi *multi,
+                 struct tls_session *session,
+  =
               const char *protocol, bool fragment,
+                 const=
 char *msg, bool base64)
+{
+    /*
+     * length of the protocol string +=
 one ','
+     * 2 for the encoding (A or 6), potential F (fragment), and 1=
 for the ',',
+     * 4 for the message size itself and one comma
+     * 1=
 for the comma before the message itself */
+    const size_t max_header_si=
ze =3D strlen("ACC,") + strlen(protocol) + 1 + 4 + 1 + 2 + 1;
+    size_t l=
en =3D max_header_size + strlen(msg);
+
+    if (len > TLS_CHANNEL_BUF_SIZE=
)
+    {
+        msg(M_CLIENT, "message length (%zu) exceeds maximum possi=
ble message length (%d)", len, TLS_CHANNEL_BUF_SIZE);
+        return false=
;
+    }
+
+    if ((int)len > multi->acc_max_message_length)
+    {
+     =
   msg(M_CLIENT, "header (%zu) + message size (%zu) length (%zu) exceeds "
=
+                      "maximum allowed length negotiated with peer (%d)",
=
+            max_header_size, strlen(msg), len,
+            multi->acc_max=
_message_length);
+        return false;
+    }
+
+    struct gc_arena gc =
=3D gc_new();
+    /* add 1 for the final \0 */
+    struct buffer buf =3D =
alloc_buf_gc(len + 1, &gc);
+
+    /* Example message: ACC,muppets,15,A,I a=
m Miss Piggy */
+    buf_printf(&buf, "ACC,%s,%zu,%s%s,%s", protocol,
+    =
           strlen(msg),
+               base64 ? "6" : "A",
+              =
 fragment ? "F" : "",
+               msg);
+
+    send_control_channel_str=
ing_dowork(session, BSTR(&buf), D_PUSH);
+    reschedule_multi_process(c);
=
+    gc_free(&gc);
+    return true;
+}
+
+char *
+parse_acc_parameters(con=
st char *capabilities,
+                     const char *delim,
+          =
           int *max_acc_len,
+                     bool server,
+          =
           struct gc_arena *gc)
+{
+    char *tmp_message =3D string_alloc(=
capabilities, NULL);
+    char *tmp_message_orig =3D tmp_message;
+    char=
 *lasts =3D NULL;
+
+    const char *token =3D strtok_r(tmp_message, delim,=
 &lasts);
+
+    int p =3D 0;
+    int acclen =3D 0;
+    const char *proto=
cols =3D NULL;
+    char *ret =3D NULL;
+
+    /* In server mode we allow m=
ore capabilities than our own, in client
+     * mode we reject if we shoul=
d use capabilities that we do not support */
+    int allowed_acc_len =3D s=
erver ? INT_MAX : ACC_MAX_MSG_LEN;
+
+    while (token)
+    {
+        if =
(p =3D=3D 0 && !atoi_constrained(token, &acclen, "ACC message length", ACC_=
MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))
+        {
+            goto =
done;
+        }
+
+        if (p =3D=3D 1 && (!tls_item_in_cipher_list("A"=
, token) || !tls_item_in_cipher_list("6", token)))
+        {
+            =
msg(D_PUSH_ERRORS, "App custom control encoding must include base64 and asc=
ii");
+            goto done;
+        }
+
+        if (p =3D=3D 1 && !serv=
er && strcmp(token, "A:6") && strcmp(token, "6:A"))
+        {
+           =
 msg(D_PUSH_ERRORS, "App custom control encoding must exactly base64 and as=
cii");
+            goto done;
+        }
+
+        if (p =3D=3D 2)
+     =
   {
+            protocols =3D token;
+        }
+
+        if (p =3D=3D 3=
)
+        {
+            msg(D_PUSH_ERRORS, "Too many parameters for INFO =
ACC message/IV_ACC=2E");
+            goto done;
+        }
+
+        toke=
n =3D strtok_r(NULL, delim, &lasts);
+        p++;
+    }
+
+    *max_acc_l=
en =3D min_int(acclen, ACC_MAX_MSG_LEN);
+    ret =3D string_alloc(protocol=
s, gc);
+
+done:
+    free(tmp_message_orig);
+    return ret;
+}
+
+struct=
 buffer
+get_list_intersection(struct gc_arena *gc, const char *list1, cons=
t char *list2)
+{
+    char *tmp =3D strdup(list1);
+    char *lasts =3D NU=
LL;
+    const char *token =3D strtok_r(tmp, ":", &lasts);
+
+    /* The ma=
ximum possible length is the shorter of the two input lists */
+    size_t =
max_len =3D min_size(strlen(list1), strlen(list2));
+
+    struct buffer co=
mmon_protocols =3D alloc_buf_gc(max_len + 1, gc);
+
+    while (token)
+   =
 {
+        if (tls_item_in_cipher_list(token, list2))
+        {
+        =
    /* protocol is in both server and client list */
+            if (buf_l=
en(&common_protocols) > 0)
+            {
+                buf_write_u8(&co=
mmon_protocols, ':');
+            }
+            buf_printf(&common_protoc=
ols, "%s", token);
+        }
+        token =3D strtok_r(NULL, ":", &lasts=
);
+    }
+    free(tmp);
+    return common_protocols;
+}
+
+void
+determi=
ne_common_acc_protocols(struct tls_multi *multi, struct tls_session *sessio=
n)
+{
+    if (!multi->opt=2Eacc_protocols)
+    {
+        /* No app custo=
m protocols have been configured server-side=2E */
+        return;
+    }
=
+
+    if (multi->acc_negotiated_protocols)
+    {
+        /* We already h=
ave determined the common protocols=2E Doing this
+         * again would j=
ust add an extra string allocation to options->gc */
+        return;
+    =
}
+
+    struct gc_arena gc =3D gc_new();
+
+    /* example IV_ACC: IV_ACC=
=3D2048,6:A,flower:power */
+    const char *peer_info =3D multi->peer_info=
;
+    const char *iv_acc =3D extract_var_peer_info(peer_info, "IV_ACC=3D",=
 &gc);
+    if (!iv_acc)
+    {
+        gc_free(&gc);
+        return;
+  =
  }
+
+    int max_acc_len =3D 0;
+    char *protocols =3D parse_acc_parame=
ters(iv_acc, ",", &max_acc_len, true, &gc);
+
+    if (!protocols)
+    {
+=
        gc_free(&gc);
+        msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer inf=
o variable of peer is malformed");
+        return;
+    }
+
+    struct bu=
ffer common_protocols =3D get_list_intersection(&gc, session->opt->acc_prot=
ocols, protocols);
+
+    if (buf_len(&common_protocols) =3D=3D 0)
+    {
+=
        msg(D_PUSH_DEBUG, "WARNING: No common app custom control protocol=
=2E");
+        gc_free(&gc);
+        return;
+    }
+
+    multi->acc_neg=
otiated_protocols =3D string_alloc(buf_str(&common_protocols), NULL);
+    =
multi->acc_max_message_length =3D max_acc_len;
+
+    setenv_str(session->o=
pt->es, "acc_protocols", multi->acc_negotiated_protocols);
+    setenv_int(=
session->opt->es, "acc_message_len", multi->acc_max_message_length);
+
+   =
 gc_free(&gc);
+}
diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
ne=
w file mode 100644
index 0000000=2E=2E4a388f7
--- /dev/null
+++ b/src/openv=
pn/acc=2Eh
@@ -0,0 +1,105 @@
+/*
+ *  OpenVPN -- An application to securely=
 tunnel IP networks
+ *             over a single TCP/UDP port, with suppor=
t for SSL/TLS-based
+ *             session authentication and key exchange=
,
+ *             packet encryption, packet authentication, and
+ *        =
     packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@o=
penvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *=

+ *
+ *  This program is free software; you can redistribute it and/or mod=
ify
+ *  it under the terms of the GNU General Public License version 2
+ *=
  as published by the Free Software Foundation=2E
+ *
+ *  This program is =
distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRAN=
TY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FO=
R A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more=
 details=2E
+ *
+ *  You should have received a copy of the GNU General Pub=
lic License along
+ *  with this program; if not, write to the Free Softwar=
e Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 0211=
0-1301 USA=2E
+ */
+
+#ifndef ACC_H
+#define ACC_H
+
+#include "openvpn=2Eh=
"
+
+#define ACC_MIN_MSG_LEN 64
+#define ACC_MAX_MSG_LEN 1280
+
+/**
+ * Th=
is method parses an app custom control message and delivers it to the
+ * m=
anagement interface=2E We leave reassembly of fragmented messages to the
+ =
* management interface=2E
+ *
+ * @param c            The context struct
+ =
* @param buffer       Buffer containing the control message with ACC
+ */
+=
void
+receive_acc_message(struct context *c, const struct buffer *buffer);
=
+
+
+bool
+send_acc_message(struct context *c,
+                 struct tls=
_multi *tls_multi,
+                 struct tls_session *session,
+        =
         const char *protocol, bool fragment,
+                 const char =
*msg, bool base64);
+
+
+/**
+ * Parses an info message from the server tha=
t contains app custom control info
+ * information prior to the PUSH_REPLY =
to be able to use app custom control
+ * protocols before sending
+ *
+ * I=
n client mode only allow what we support ourselves=2E In server mode
+ * al=
low also capabilities that we not support ourselves=2E
+ *
+ * @param capab=
ilities      The string to parse
+ * @param delim             The delimiter=
 to use when parsing the string=2E
+ *                          IV_ACC uses=
 "," as delimiter while the
+ *                          custom-control PUS=
H message uses " " as "," is
+ *                          already used to s=
eparate different push directives
+ * @param max_acc_len       Set to the m=
aximum ACC message length
+ * @param server            Whether we are serve=
r or client
+ * @param gc                The gc arena to use for allocating=
 the resulting string
+ * @return                  The resulting protocol s=
tring or NULL on error
+ */
+char *
+parse_acc_parameters(const char *capab=
ilities,
+                     const char *delim,
+                     int=
 *max_acc_len,
+                     bool server,
+                     str=
uct gc_arena *gc);
+
+/**
+ * Parses the IV_ACC of the peer and sets multi=
=2Eacc_negotiated_protocols
+ * to the common protocols of server and clien=
t and
+ * multi=2Eacc_max_message_length  to the maximum length of the ACC =
message
+ * support by both server and client=2E
+ *
+ * If there is no com=
mon protocol or the client does not support any app custom
+ * protocol mul=
ti=2Eacc_negotiated_protocols will be set to NULL=2E
+ *
+ * @param multi  =
    the multi instance to use the set the app custom protocols=2E
+ * @para=
m session    the session to read the client env from
+ */
+void
+determine_=
common_acc_protocols(struct tls_multi *multi, struct tls_session *session);=

+
+/**
+ * Calculates the intersection of two list that are both separated=
 by :
+ * Items in the result will have the same ordering as in the list1
+=
 * parameters
+ * @param gc            Returned buffer will be allocated in=
 this gc
+ * @param list1         First list to intersect
+ * @param list2 =
        Second list to intersect=2E
+ * @return A (potentially empty) buffe=
r containing an intersection list
+ */
+struct buffer
+get_list_intersectio=
n(struct gc_arena *gc, const char *list1, const char *list2);
+#endif
diff =
--git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 681210d=2E=
=2E7923b5e 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=
=2Ec
@@ -42,6 +42,7 @@
 #include "dco=2Eh"
 #include "auth_token=2Eh"
 #inc=
lude "tun_afunix=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -25=
7,11 +258,11 @@
     }
     else if (buf_string_match_head_str(buf, "INFO_P=
RE"))
     {
-        server_pushed_info(buf, 8);
+        server_pushed_in=
fo(c, buf, 8);
     }
     else if (buf_string_match_head_str(buf, "INFO"))=

     {
-        server_pushed_info(buf, 4);
+        server_pushed_info(c,=
 buf, 4);
     }
     else if (buf_string_match_head_str(buf, "CR_RESPONSE"=
))
     {
@@ -271,6 +272,10 @@
     {
         receive_auth_pending(c, buf)=
;
     }
+    else if (buf_string_match_head_str(buf, "ACC"))
+    {
+     =
   receive_acc_message(c, buf);
+    }
     else if (buf_string_match_head_=
str(buf, "EXIT"))
     {
         receive_exit_message(c);
diff --git a/src=
/openvpn/init=2Ec b/src/openvpn/init=2Ec
index fc100da=2E=2E800295e 100644
=
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2279,6 +2279,13 @=
@
         }
     }
 
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+=
    if (multi->acc_negotiated_protocols)
+    {
+        buf_printf(&out, "=
 custom-control %d,A:6,%s",
+                   multi->acc_max_message_leng=
th, multi->acc_negotiated_protocols);
+    }
+
     if (BLENZ(&out) > strle=
n(header))
     {
         msg(D_HANDSHAKE, "%s", BSTR(&out));
@@ -2522,6 +=
2529,11 @@
         flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);
     }
 
+   =
 if (c->options=2Eacc_protocols)
+    {
+        flags |=3D OPT_P_ACC;
+   =
 }
+
     return flags;
 }
 
@@ -2730,6 +2742,17 @@
         frame->tun_mtu=
 =3D min_int(frame->tun_max_mtu, c->options=2Ece=2Etun_mtu);
     }
 
+    =
if (found & OPT_P_ACC && c->options=2Epushed_acc_negotiated_protocols)
+   =
 {
+        struct tls_multi *multi =3D c->c2=2Etls_multi;
+        free(mu=
lti->acc_negotiated_protocols);
+        multi->acc_negotiated_protocols =
=3D string_alloc(c->options=2Epushed_acc_negotiated_protocols, NULL);
+    =
    multi->acc_max_message_length =3D c->options=2Epushed_acc_max_message_l=
ength;
+
+        msg(D_PUSH, "OPTIONS IMPORT: ACC protocols: %s, msg len: =
%d",
+            multi->acc_negotiated_protocols, multi->acc_max_message_l=
ength);
+    }
+
     return true;
 }
 
@@ -3352,6 +3375,7 @@
     to=2Ever=
ify_hash_depth =3D options->verify_hash_depth;
     to=2Everify_hash_no_ca =
=3D options->verify_hash_no_ca;
     memcpy(to=2Ex509_username_field, optio=
ns->x509_username_field, sizeof(to=2Ex509_username_field));
+    to=2Eacc_p=
rotocols =3D options->acc_protocols;
     to=2Ees =3D c->c2=2Ees;
     to=
=2Enet_ctx =3D &c->net_ctx;
 
@@ -4306,6 +4330,24 @@
 }
 #endif /* ifdef TA=
RGET_ANDROID */
 
+static bool
+management_acc_msg(void *arg,
+            =
       struct buffer_list *input) /* ownership transferred */
+{
+    struc=
t context *c =3D arg;
+
+    bool ret =3D false;
+    if (buffer_list_defin=
ed(input) && c->c2=2Etls_multi)
+    {
+        struct tls_multi *multi =3D=
 c->c2=2Etls_multi;
+        struct tls_session *session =3D &multi->sessio=
n[TM_ACTIVE];
+
+        ret =3D management_send_acc_message(c, multi, sess=
ion, input);
+    }
+
+    buffer_list_free(input);
+    return ret;
+}
 #e=
ndif /* ifdef ENABLE_MANAGEMENT */
 
 void
@@ -4322,6 +4364,7 @@
         c=
b=2Eproxy_cmd =3D management_callback_proxy_cmd;
         cb=2Eremote_cmd =
=3D management_callback_remote_cmd;
         cb=2Esend_cc_message =3D manag=
ement_callback_send_cc_message;
+        cb=2Eacc_msg =3D management_acc_ms=
g;
 #ifdef TARGET_ANDROID
         cb=2Enetwork_change =3D management_callb=
ack_network_change;
 #endif
diff --git a/src/openvpn/manage=2Ec b/src/openv=
pn/manage=2Ec
index ccf66b43=2E=2E86d82ba 100644
--- a/src/openvpn/manage=
=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -45,9 +45,11 @@
 #include "push=2Eh"
 =
#include "multi=2Eh"
 #include "resolve=2Eh"
+#include "acc=2Eh"
 
 #includ=
e "memdbg=2Eh"
 #include "run_command=2Eh"
+#include "ssl_ncp=2Eh"
 
 #ifde=
f ENABLE_PKCS11
 #include "pkcs11=2Eh"
@@ -1082,6 +1084,35 @@
             =
}
             break;
 
+        case IEC_CLIENT_ACC_MSG:
+            if (=
man->persist=2Ecallback=2Eclient_acc_msg)
+            {
+                b=
ool status =3D (*man->persist=2Ecallback=2Eclient_acc_msg)(man->persist=2Ec=
allback=2Earg,
+                                                           =
           man->connection=2Ein_extra_cid,
+                               =
                                       man->connection=2Ein_extra_kid,
+   =
                                                                   man->con=
nection=2Ein_extra);
+                man->connection=2Ein_extra =3D NULL;
=
+                report_command_status(status, "client-acc-msg");
+        =
    }
+            else
+            {
+                man_command_unsuppo=
rted("client-acc-msg");
+            }
+            break;
+
+        case =
IEC_ACC_MSG:
+            if (man->persist=2Ecallback=2Eacc_msg)
+         =
   {
+                bool status =3D (*man->persist=2Ecallback=2Eacc_msg)(=
man->persist=2Ecallback=2Earg,
+                                           =
                    man->connection=2Ein_extra);
+                man->conn=
ection=2Ein_extra =3D NULL;
+                report_command_status(status, =
"acc-msg");
+            }
+            else
+            {
+              =
  man_command_unsupported("acc-msg");
+            }
+            break;
  =
       case IEC_PK_SIGN:
             man->connection=2Eext_key_state =3D E=
KS_READY;
             buffer_list_free(man->connection=2Eext_key_input);
@=
@ -1206,6 +1237,29 @@
 }
 
 static void
+man_client_acc_msg(struct manageme=
nt *man, const char *cid_str,
+                   const char *kid_str)
+{
+=
    struct man_connection *mc =3D &man->connection;
+    mc->in_extra_cid =
=3D 0;
+    mc->in_extra_kid =3D 0;
+    if (parse_cid(cid_str, &mc->in_ext=
ra_cid)
+        && parse_uint(kid_str, "KID", &mc->in_extra_kid))
+    {
+=
        mc->in_extra_cmd =3D IEC_CLIENT_ACC_MSG;
+        in_extra_reset(mc=
, IER_NEW);
+    }
+}
+
+static void
+man_acc_msg(struct management *man)
+=
{
+    struct man_connection *mc =3D &man->connection;
+    mc->in_extra_cm=
d =3D IEC_ACC_MSG;
+    in_extra_reset(mc, IER_NEW);
+}
+
+static void
 man=
_client_auth(struct management *man, const char *cid_str, const char *kid_s=
tr, const bool extra)
 {
     struct man_connection *mc =3D &man->connectio=
n;
@@ -1760,6 +1814,17 @@
             man_client_pending_auth(man, p[1], p=
[2], p[3], p[4]);
         }
     }
+    else if (streq(p[0], "client-acc-m=
sg"))
+    {
+        if (man_need(p, 2, 0))
+        {
+            man_cl=
ient_acc_msg(man, p[1], p[2]);
+        }
+    }
+    else if (streq(p[0], =
"acc-msg"))
+    {
+        man_acc_msg(man);
+    }
     else if (streq(p[=
0], "rsa-sig"))
     {
         man_pk_sig(man, "rsa-sig");
@@ -2978,7 +304=
3,9 @@
                                        "bytes_sent=3D",
           =
                             "bytes_received=3D",
                         =
               "session_id=3D",
-                                       "se=
ssion_state=3D" };
+                                       "session_state=
=3D",
+                                       "acc_protocols=3D",
+        =
                               "acc_message_len=3D" };
 
     if (env_filte=
r_level =3D=3D 0)
     {
@@ -3133,6 +3200,7 @@
     }
 }
 
+
 void
 managem=
ent_connection_established(struct management *man, struct man_def_auth_cont=
ext *mdac,
                                   const struct env_set *es)
@@ =
-4375,6 +4443,64 @@
     }
 }
 
+bool
+management_send_acc_message(struct c=
ontext *c, struct tls_multi *multi, struct tls_session *session,
+         =
                   struct buffer_list *input)
+{
+    /* also ensures that =
are enough inputs in the list to safely call
+     * buffer_list_peek witho=
ut extra NULL checks */
+    if (!input || input->size < 3)
+    {
+       =
 msg(M_CLIENT, "not enough input lines for sending acc message, "
+        =
              "missing protocol, flag and/or messages lines");
+        ret=
urn false;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+    const stru=
ct buffer *proto_buf =3D buffer_list_peek(input);
+    const char *protocol=
 =3D string_alloc(CBSTR(proto_buf), &gc);
+    buffer_list_pop(input);
+
+ =
   struct buffer *encoding_buf =3D buffer_list_peek(input);
+    char *enco=
ding =3D buf_str(encoding_buf);
+    const char *flag =3D NULL;
+    bool b=
64encoding =3D false;
+    bool fragment =3D false;
+
+    while ((flag =3D=
 strsep(&encoding, ":")))
+    {
+        if (!strcmp(flag, "6"))
+        =
{
+            b64encoding =3D true;
+        }
+        else if (!strcmp(f=
lag, "F"))
+        {
+            fragment =3D true;
+        }
+    }
+  =
  buffer_list_pop(input);
+
+    buffer_list_aggregate_separator(input, 100=
00, "");
+    const struct buffer *acc_msg_buf =3D buffer_list_peek(input);=

+
+    if (!multi->acc_negotiated_protocols
+        || !tls_item_in_ciphe=
r_list(protocol, multi->acc_negotiated_protocols))
+    {
+        msg(M_CL=
IENT, "protocol not in the list of negotiated protocols: %s",
+            =
np(multi->acc_negotiated_protocols));
+        goto error;
+    }
+
+    bo=
ol ret =3D send_acc_message(c, multi, session, protocol,
+                 =
               fragment, buf_cstr(acc_msg_buf),
+                          =
      b64encoding);
+    gc_free(&gc);
+    return ret;
+error:
+    gc_fre=
e(&gc);
+    return false;
+}
 #else /* ifdef ENABLE_MANAGEMENT */
 
 #incl=
ude "win32=2Eh"
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2E=
h
index 157039d=2E=2Ecc9c264 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/=
openvpn/manage=2Eh
@@ -184,12 +184,19 @@
     int (*n_clients)(void *arg);
=
     bool (*send_cc_message)(void *arg, const char *message, const char *pa=
rameter);
     bool (*kill_by_cid)(void *arg, const unsigned long cid, cons=
t char *kill_msg);
+
     bool (*client_auth)(void *arg, const unsigned lon=
g cid, const unsigned int mda_key_id,
                         const bool a=
uth, const char *reason, const char *client_reason,
                       =
  struct buffer_list *cc_config); /* ownership transferred */
     bool (*c=
lient_pending_auth)(void *arg, const unsigned long cid, const unsigned int =
kid,
                                 const char *extra, unsigned int timeo=
ut);
     char *(*get_peer_info)(void *arg, const unsigned long cid);
+    =
bool (*client_acc_msg)(void *arg,
+                           const unsigne=
d long cid,
+                           const unsigned int mda_key_id,
+   =
                        struct buffer_list *msg);
+    bool (*acc_msg)(void=
 *arg,
+                    struct buffer_list *msg);
     bool (*proxy_cmd=
)(void *arg, const char **p);
     bool (*remote_cmd)(void *arg, const char=
 **p);
 #ifdef TARGET_ANDROID
@@ -292,13 +299,15 @@
     struct command_lin=
e *in;
     struct buffer_list *out;
 
-#define IEC_UNDEF       0
-#define =
IEC_CLIENT_AUTH 1
+#define IEC_UNDEF          0
+#define IEC_CLIENT_AUTH   =
 1
 /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* */
-#define IEC_RSA_SIGN=
    3
-#define IEC_CERTIFICATE 4
-#define IEC_PK_SIGN     5
-#define IEC_PA=
SSWORD    6
+#define IEC_RSA_SIGN       3
+#define IEC_CERTIFICATE    4
+#d=
efine IEC_PK_SIGN        5
+#define IEC_PASSWORD       6
+#define IEC_CLIEN=
T_ACC_MSG 7
+#define IEC_ACC_MSG        8
     int in_extra_cmd;
     struc=
t buffer_list *in_extra;
     unsigned long in_extra_cid;
@@ -503,6 +512,14=
 @@
 
 void man_persist_client_stats(struct management *man, struct context=
 *c);
 
+/** Parses the ACC message from the input buffer_list and send to =
the
+ * session identified by session and multi
+ */
+struct tls_session;
+=
struct tls_multi;
+bool
+management_send_acc_message(struct context *c, str=
uct tls_multi *multi,
+                            struct tls_session *sess=
ion, struct buffer_list *input);
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /=
**
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index e302a81=
=2E=2E0ae503d 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2E=
c
@@ -53,6 +53,7 @@
 #include "ssl_util=2Eh"
 #include "dco=2Eh"
 #include =
"reflect_filter=2Eh"
+#include "acc=2Eh"
 
 /*#define MULTI_DEBUG_EVENT_LOO=
P*/
 
@@ -1735,8 +1736,9 @@
  * - peer id
  */
 static bool
-multi_client_s=
et_protocol_options(struct context *c)
+multi_client_set_protocol_options(s=
truct multi_instance *mi)
 {
+    struct context *c =3D &mi->context;
     =
struct tls_multi *tls_multi =3D c->c2=2Etls_multi;
     const char *const p=
eer_info =3D tls_multi->peer_info;
     struct options *o =3D &c->options;
=
@@ -2380,7 +2382,7 @@
      * peer must be added before iroutes=2E For othe=
r platforms it doesn't matter=2E */
 
     /* authentication complete, calc=
ulate dynamic client specific options */
-    if (!multi_client_set_protoco=
l_options(&mi->context))
+    if (!multi_client_set_protocol_options(mi))
 =
    {
         mi->context=2Ec2=2Etls_multi->multi_state =3D CAS_FAILED;
  =
   }
@@ -4085,6 +4087,26 @@
     }
 }
 
+static const char *
+calculate_app=
_control_extra(struct multi_instance *mi, struct gc_arena *gc)
+{
+    stru=
ct context *c =3D &mi->context;
+    struct tls_multi *multi =3D c->c2=2Etl=
s_multi;
+
+    if (!multi->acc_negotiated_protocols)
+    {
+        msg(M=
_CLIENT, "ACC: No negotiated protocols");
+        return NULL;
+    }
+
+ =
   struct buffer buf =3D alloc_buf_gc(1024, gc);
+
+    buf_printf(&buf, "A=
CC:%d A:6 %s", multi->acc_max_message_length,
+               multi->acc_ne=
gotiated_protocols);
+    return buf_str(&buf);
+}
+
+
 static bool
 manage=
ment_client_pending_auth(void *arg, const unsigned long cid, const unsigned=
 int mda_key_id,
                                const char *extra, unsigne=
d int timeout)
@@ -4095,10 +4117,22 @@
     if (mi)
     {
         struct =
tls_multi *multi =3D mi->context=2Ec2=2Etls_multi;
+
+        struct gc_are=
na gc =3D gc_new();
+        if (!strcmp(extra, "ACC"))
+        {
+       =
     extra =3D calculate_app_control_extra(mi, &gc);
+            if (!extr=
a)
+            {
+                gc_free(&gc);
+                return fa=
lse;
+            }
+        }
         struct tls_session *session =3D loo=
kup_session_by_mda_key_id(multi, mda_key_id);
 
         if (!session)
    =
     {
+            gc_free(&gc);
             return false;
         }
 
@=
@ -4106,6 +4140,7 @@
         bool ret =3D send_auth_pending_messages(multi=
, session, extra, timeout);
         reschedule_multi_process(&mi->context)=
;
         multi_schedule_context_wakeup(m, mi);
+        gc_free(&gc);
   =
      return ret;
     }
     return false;
@@ -4149,6 +4184,37 @@
     ret=
urn ret;
 }
 
+
+static bool
+management_client_acc_msg(void *arg,
+       =
                   const unsigned long cid,
+                          cons=
t unsigned int mda_key_id,
+                          struct buffer_list *i=
nput) /* ownership transferred */
+{
+    struct multi_context *m =3D (stru=
ct multi_context *)arg;
+    struct multi_instance *mi =3D lookup_by_cid(m,=
 cid);
+
+    bool ret =3D false;
+    if (mi && buffer_list_defined(input)=
)
+    {
+        struct tls_multi *multi =3D mi->context=2Ec2=2Etls_multi;=

+        struct tls_session *session =3D lookup_session_by_mda_key_id(mult=
i, mda_key_id);
+        if (!session)
+        {
+            msg(M_CLIENT=
, "client session not found");
+            buffer_list_free(input);
+     =
       return false;
+        }
+
+        ret =3D management_send_acc_mess=
age(&mi->context, multi, session, input);
+        multi_schedule_context_w=
akeup(m, mi);
+    }
+
+    buffer_list_free(input);
+    return ret;
+}
+
=
+
 static char *
 management_get_peer_info(void *arg, const unsigned long c=
id)
 {
@@ -4185,6 +4251,7 @@
         cb=2En_clients =3D management_callbac=
k_n_clients;
         cb=2Ekill_by_cid =3D management_kill_by_cid;
        =
 cb=2Eclient_auth =3D management_client_auth;
+        cb=2Eclient_acc_msg =
=3D management_client_acc_msg;
         cb=2Eclient_pending_auth =3D manage=
ment_client_pending_auth;
         cb=2Eget_peer_info =3D management_get_pe=
er_info;
         cb=2Epush_update_broadcast =3D management_callback_send_p=
ush_update_broadcast;
diff --git a/src/openvpn/options=2Ec b/src/openvpn/op=
tions=2Ec
index fb319ae=2E=2E04b553e 100644
--- a/src/openvpn/options=2Ec
+=
++ b/src/openvpn/options=2Ec
@@ -35,6 +35,7 @@
 
 #include "syshead=2Eh"
 
=
+#include "acc=2Eh"
 #include "buffer=2Eh"
 #include "error=2Eh"
 #include =
"common=2Eh"
@@ -7107,6 +7108,41 @@
         VERIFY_PERMISSION(OPT_P_GENERA=
L);
         options->force_key_material_export =3D true;
     }
+    else =
if (streq(p[0], "app-custom-control") && p[1] && !p[2])
+    {
+        VER=
IFY_PERMISSION(OPT_P_GENERAL);
+        options->acc_protocols =3D p[1];
+ =
   }
+    else if (streq(p[0], "custom-control") && p[1] && p[2] && p[3] &&=
 !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_ACC);
+
+        /* check i=
f the list from the server is a real subset of our list */
+        struct =
gc_arena gc =3D gc_new();
+        struct buffer common_list =3D get_list_i=
ntersection(&gc, p[3], options->acc_protocols);
+
+        if (buf_len(&com=
mon_list) =3D=3D 0 || !streq(p[3], buf_cstr(&common_list)))
+        {
+   =
         msg(msglevel, "App custom control list from server contains "
+   =
                       "unsupported protocols");
+            gc_free(&gc);=

+            goto err;
+        }
+        gc_free(&gc);
+
+        if (!s=
treq(p[2], "A:6") && !streq(p[2], "6:A"))
+        {
+            msg(msgle=
vel, "App custom control encoding must be base64 and ascii");
+            =
goto err;
+        }
+
+        if (!atoi_constrained(p[1], &options->pushe=
d_acc_max_message_length,
+                              "app custom messag=
e message length", ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))
+        {
=
+            goto err;
+        }
+        options->pushed_acc_negotiated_p=
rotocols =3D p[3];
+    }
     else if (streq(p[0], "prng") && p[1] && !p[3=
])
     {
         msg(M_WARN, "NOTICE: --prng option ignored (SSL library =
PRNG is used)");
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=
=2Eh
index 6a3bf61=2E=2Eb7945e0 100644
--- a/src/openvpn/options=2Eh
+++ b/=
src/openvpn/options=2Eh
@@ -715,6 +715,18 @@
     /* force using TLS key ma=
terial export for data channel key generation */
     bool force_key_materi=
al_export;
 
+    /** The app custom control protocols we should announce a=
s supported */
+    const char *acc_protocols;
+
+    /** the protocols tha=
t are negotiated with the peer=2E This is a
+     *  a temporary variable s=
ince options=2Ec push parser cannot access
+     *  tls multi struct */
+  =
  const char *pushed_acc_negotiated_protocols;
+
+    /** the maximum lengt=
h of an ACC control channel message via push message
+     * */
+    int pu=
shed_acc_max_message_length;
+
     bool vlan_tagging;
     enum vlan_accep=
table_frames vlan_accept;
     uint16_t vlan_pvid;
@@ -764,8 +776,10 @@
 #d=
efine OPT_P_INLINE          (1u << 29)
 #define OPT_P_PUSH_MTU        (1u <=
< 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
+#define OPT_P_ACC         =
    (1ull << 32)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MO=
DE | OPT_P_PEER_ID | 0x0ull))
+/* Options allowed in the normal configurati=
on file (vs pushed options or in ccd files) */
+#define OPT_P_DEFAULT (~(OP=
T_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #define PUL=
L_DEFINED(opt) ((opt)->pull)
 
diff --git a/src/openvpn/push=2Ec b/src/open=
vpn/push=2Ec
index 42259c3=2E=2E320f89d 100644
--- a/src/openvpn/push=2Ec
+=
++ b/src/openvpn/push=2Ec
@@ -27,6 +27,8 @@
 #include "syshead=2Eh"
 
 #inc=
lude "push=2Eh"
+
+#include "acc=2Eh"
 #include "options=2Eh"
 #include "cr=
ypto=2Eh"
 #include "ssl=2Eh"
@@ -221,9 +223,58 @@
 #endif
 }
 
+static voi=
d
+parse_server_pushed_info_acc(struct context *c, struct buffer *buf)
+{
+=
    int max_acc_len =3D 0;
+    struct tls_multi *multi =3D c->c2=2Etls_mul=
ti;
+
+    if (!multi->opt=2Eacc_protocols)
+    {
+        msg(D_PUSH_ERRO=
RS, "Server tried to push app custom control list"
+                       =
    "without client announcing support for it");
+        return;
+    }
+
=
+    /* example string to parse: ACC:1400 A:6 flower:happy */
+    /* Skip =
over the ACC: prefix */
+    buf_advance(buf, 4);
+
+    struct gc_arena gc=
 =3D gc_new();
+    char *protocols =3D parse_acc_parameters(buf_cstr(buf),=
 " ", &max_acc_len, false, &gc);
+
+    /* check if the list from the serve=
r is a real subset of our list */
+    struct buffer common_list =3D get_li=
st_intersection(&gc, protocols, multi->opt=2Eacc_protocols);
+
+    if (buf=
_len(&common_list) =3D=3D 0 || !streq(protocols, buf_cstr(&common_list)))
+=
    {
+        msg(D_PUSH_ERRORS, "App custom control list from server cont=
ains "
+                           "unsupported protocols");
+        gc_fr=
ee(&gc);
+        return;
+    }
+    gc_free(&gc);
+
+    if (protocols)
+=
    {
+        multi->acc_negotiated_protocols =3D string_alloc(protocols, =
&c->options=2Egc);
+        multi->acc_max_message_length =3D max_acc_len;
=
+
+#ifdef ENABLE_MANAGEMENT
+        if (management)
+        {
+          =
  msg(M_CLIENT, ">ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d", protocols=
, max_acc_len);
+        }
+#endif
+    }
+    else
+    {
+        msg(D_P=
USH_ERRORS, "WARNING: Received ACC info command with invalid parameters");
=
+    }
+}
 
 void
-server_pushed_info(const struct buffer *buffer, const in=
t adv)
+server_pushed_info(struct context *c, const struct buffer *buffer, =
const int adv)
 {
     const char *m =3D "";
     struct buffer buf =3D *bu=
ffer;
@@ -233,6 +284,12 @@
         m =3D BSTR(&buf);
     }
 
+    if (str=
ncmp(m, "ACC:", 4) =3D=3D 0)
+    {
+        parse_server_pushed_info_acc(c=
, &buf);
+        return;
+    }
+
 #ifdef ENABLE_MANAGEMENT
     struct gc=
_arena gc;
     if (management)
@@ -285,6 +342,7 @@
     msg(D_PUSH, "CR re=
sponse was sent by client ('%s')", m);
 }
 
+
 /**
  * Parse the keyword fo=
r the AUTH_PENDING request
  * @param buffer                buffer containi=
ng the keywords, the buffer's
@@ -441,7 +499,6 @@
     const char *const pe=
er_info =3D tls_multi->peer_info;
     unsigned int proto =3D extract_iv_pr=
oto(peer_info);
 
-
     /* Calculate the maximum timeout and subtract the =
time we already waited */
     unsigned int max_timeout =3D
         max_ui=
nt(tls_multi->opt=2Erenegotiate_seconds / 2, tls_multi->opt=2Ehandshake_win=
dow);
@@ -732,6 +789,12 @@
                 client_max_mtu, o->ce=2Etun_mtu=
, o->ce=2Etun_mtu);
         }
     }
+
+    if (tls_multi->acc_negotiated_=
protocols)
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "custom-=
control %d A:6 %s",
+                        tls_multi->acc_max_message_len=
gth, tls_multi->acc_negotiated_protocols);
+    }
 }
 
 static bool
diff --=
git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index 39302f6=2E=2Eb6695b=
c 100644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -52,6 +52=
,7 @@
 
 int process_incoming_push_request(struct context *c);
 
+
 /**
  *=
 @brief Handles the receiving of a push-update message and applies updates =
to the specified
  * options=2E
@@ -92,7 +93,7 @@
 
 void receive_exit_mess=
age(struct context *c);
 
-void server_pushed_info(const struct buffer *buf=
fer, const int adv);
+void server_pushed_info(struct context *c, const stru=
ct buffer *buffer, const int adv);
 
 void receive_cr_response(struct conte=
xt *c, const struct buffer *buffer);
 
diff --git a/src/openvpn/ssl=2Ec b/s=
rc/openvpn/ssl=2Ec
index 086a6fc=2E=2Ee84d32d 100644
--- a/src/openvpn/ssl=
=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -55,6 +55,7 @@
 
 #include "crypto_epoch=
=2Eh"
 #include "ssl=2Eh"
+#include "acc=2Eh"
 #include "ssl_verify=2Eh"
 #=
include "ssl_backend=2Eh"
 #include "ssl_ncp=2Eh"
@@ -1279,6 +1280,7 @@
   =
  free(multi->locked_cn);
     free(multi->locked_username);
     free(mult=
i->locked_original_username);
+    free(multi->acc_negotiated_protocols);
 =

     cert_hash_free(multi->locked_cert_hash_set);
 
@@ -2117,6 +2119,11 @@=

                     }
                 }
             }
+
+            if=
 (session->opt->acc_protocols)
+            {
+                buf_printf(&=
out, "IV_ACC=3D%d,6:A,%s\n", ACC_MAX_MSG_LEN, session->opt->acc_protocols);=

+            }
         }
     }
 
@@ -2398,6 +2405,8 @@
         multi->r=
emote_ciphername =3D string_alloc("none", NULL);
     }
 
+    determine_co=
mmon_acc_protocols(multi, session);
+
     if (username_len < 0 || password=
_len < 0)
     {
         msg(D_TLS_ERRORS, "TLS Error: Username (%d) or pa=
ssword (%d) too long", abs(username_len),
diff --git a/src/openvpn/ssl_comm=
on=2Eh b/src/openvpn/ssl_common=2Eh
index 9a55ead=2E=2E436770b 100644
--- a=
/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -457,6 +457=
,9 @@
     size_t ekm_size;
 
     bool dco_enabled; /**< Whether keys have=
 to be installed in DCO or not */
+
+    /** The app custom control protoco=
ls we should announce as supported */
+    const char *acc_protocols;
 };
 =

 /** @addtogroup control_processor
@@ -730,6 +733,12 @@
     int dco_peer_=
id;
 
     dco_context_t *dco;
+
+    /** the protocols that are negotiated=
 with the peer=2E */
+    char *acc_negotiated_protocols;
+
+    /** the ma=
ximum length of an ACC control channel message */
+    int acc_max_message_=
length;
 };
 
 /**  gets an item  of \c key_state objects in the
diff --git=
 a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefi=
le=2Eam
index 43a6743=2E=2E86326af 100644
--- a/tests/unit_tests/openvpn/Ma=
kefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -107,10 +107,12=
 @@
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_=
CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=2Ec \
+	test_acc=2Ec test=
_acc=2Eh \
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_management=
=2Ec \
 	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \
 	$(top_srcdir)/=
src/compat/compat-strlcpy=2Ec \
+	$(top_srcdir)/src/openvpn/acc=2Ec \
 	$(t=
op_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
=
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -132,6 +134,7 @@
 	$(top_srcdir=
)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec=
 \
 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \
+	$(top_srcdir)/src/openvp=
n/ssl_ncp=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/=
src/openvpn/ssl_verify_mbedtls=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify=
_openssl=2Ec \
@@ -392,9 +395,11 @@
 
 misc_testdriver_SOURCES =3D test_mis=
c=2Ec \
 	test_schedule=2Ec test_schedule=2Eh \
+	mock_management=2Ec mock_=
management=2Eh \
 	mock_msg=2Ec test_common=2Eh  \
 	mock_get_random=2Ec \
=
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
+	$(top_srcdir)/src/openvpn=
/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/=
openvpn/options_util=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
@@ -4=
07,6 +412,7 @@
 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \
 	$(top_=
srcdir)/src/openvpn/session_id=2Ec
 
+
 push_update_msg_testdriver_CFLAGS =
=3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
 	-I$(top_=
srcdir)/tests/unit_tests/openvpn \
diff --git a/tests/unit_tests/openvpn/mo=
ck_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec
index fff4=
c2b=2E=2Ef572dbb 100644
--- a/tests/unit_tests/openvpn/mock_management=2Ec
=
+++ b/tests/unit_tests/openvpn/mock_management=2Ec
@@ -29,6 +29,7 @@
 
 #in=
clude "syshead=2Eh"
 
+#include <stdlib=2Eh>
 #include "manage=2Eh"
 
 #ifd=
ef ENABLE_MANAGEMENT
diff --git a/tests/unit_tests/openvpn/mock_management=
=2Eh b/tests/unit_tests/openvpn/mock_management=2Eh
new file mode 100644
in=
dex 0000000=2E=2E80dcfc2
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_=
management=2Eh
@@ -0,0 +1,29 @@
+/*
+ *  OpenVPN -- An application to secur=
ely tunnel IP networks
+ *             over a single UDP port, with support=
 for SSL/TLS-based
+ *             session authentication and key exchange,=

+ *             packet encryption, packet authentication, and
+ *         =
    packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sal=
es@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistrib=
ute it and/or modify
+ *  it under the terms of the GNU General Public Lice=
nse version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ * =
 This program is distributed in the hope that it will be useful,
+ *  but W=
ITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABIL=
ITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public=
 License for more details=2E
+ *
+ *  You should have received a copy of th=
e GNU General Public License along
+ *  with this program; if not, see <htt=
ps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef MOCK_MANAGEMENT_H
+#defi=
ne MOCK_MANAGEMENT_H
+void init_mock_management(void);
+
+void uninit_mock_=
management(void);
+
+#endif
diff --git a/tests/unit_tests/openvpn/mock_push=
_dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
ind=
ex bf2ccf3=2E=2Ef083f89 100644
--- a/tests/unit_tests/openvpn/mock_push_dep=
endencies=2Ec
+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
@@ =
-43,7 +43,8 @@
     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_=
P_SOCKBUF | OPT_P_SOCKFLAGS
                      | OPT_P_SETENV | OPT_P_SH=
APER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
                      | OPT=
_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-       =
              | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | =
OPT_P_DHCPDNS;
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PU=
SH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS
+                     | OPT_P_ACC;
   =
  return flags;
 }
 
diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/t=
ests/unit_tests/openvpn/test_acc=2Ec
new file mode 100644
index 0000000=2E=
=2E577e34e
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc=2Ec
@@ -0,=
0 +1,334 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networ=
ks
+ *             over a single TCP/UDP port, with support for SSL/TLS-bas=
ed
+ *             session authentication and key exchange,
+ *            =
 packet encryption, packet authentication, and
+ *             packet compr=
ession=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *=
  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This pr=
ogram is free software; you can redistribute it and/or modify
+ *  it under=
 the terms of the GNU General Public License version 2
+ *  as published by=
 the Free Software Foundation=2E
+ *
+ *  This program is distributed in th=
e hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even =
the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PU=
RPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+=
 *  You should have received a copy of the GNU General Public License along=

+ *  with this program; if not, write to the Free Software Foundation, Inc=
=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ *=
/
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshe=
ad=2Eh"
+
+#include <stdio=2Eh>
+#include <stdlib=2Eh>
+#include <stdarg=2E=
h>
+#include <string=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+=
#include "acc=2Eh"
+#include "test_acc=2Eh"
+#include "test_common=2Eh"
+
+=
#include "mock_msg=2Eh"
+#include "multi=2Eh"
+
+char control_channel_mesag=
e_sent[2048];
+
+/* Mock functions */
+bool
+send_control_channel_string_do=
work(struct tls_session *session,
+                                   const=
 char *str, unsigned int msglevel)
+{
+    assert_int_in_range(strlen(str),=
 0, 2048);
+
+    memcpy(control_channel_mesage_sent, str, strlen(str));
+ =
   return true;
+}
+
+void
+send_push_reply_auth_token(struct tls_multi *mu=
lti)
+{
+}
+
+void
+auth_set_client_reason(struct tls_multi *multi, const c=
har *reason)
+{
+}
+
+#define MSG_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9J=
njI3tBM"                \
+                    "r4engpg/cDgS48DMaxyCdbzofNj=
QJU9Y0DD66z/notFT0cF1d60nTS" \
+                    "4md4OJwoQAwEwITAxMBwCz=
AMACfzKnMqMyqwCvALwCewCTAKABrwCP" \
+                    "AJwBnwArAFAA5wAnA=
EwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH" \
+                    "QAXAB4AGQAYA=
QABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc" \
+                    "ICAgaCB=
sIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA" \
+                    "AU=
EAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ" \
+                  =
  "93rQwityP9eKSijXgcQ=3D=3D"
+
+void
+test_acc_parse_client_messages(void =
**state)
+{
+#ifndef ENABLE_MANAGEMENT
+    skip();
+#else
+    /* ensure t=
hat the messages get to mock_msg */
+    x_debug_level =3D 3;
+    manageme=
nt =3D (void *)0x12345678;
+    struct gc_arena gc =3D gc_new();
+
+    /* =
contains a TLS 1=2E3 ClientHello */
+    const char msg[] =3D "ACC,cck1,384=
,6," MSG_PAYLOAD;
+
+    struct buffer msg_buf;
+    struct context c =3D {=
 0 };
+    c=2Eoptions=2Emode =3D MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c=
=2Ec2=2Etls_multi, struct tls_multi, &gc);
+
+    c=2Ec2=2Etls_multi->sessi=
on[TM_ACTIVE]=2Eopt =3D &c=2Ec2=2Etls_multi->opt;
+    c=2Ec2=2Etls_multi->=
session[TM_ACTIVE]=2Eopt->mda_context =3D &c=2Ec2=2Emda_context;
+    buf_s=
et_read(&msg_buf, (void *)msg, sizeof(msg));
+    receive_acc_message(&c, &=
msg_buf);
+
+    assert_string_equal(mock_msg_buf, "Received custom app con=
trol message (protocol 'cck1')");
+    assert_string_equal(mock_managment_b=
uf, ">CLIENT:ACC,0,0,cck1,0," MSG_PAYLOAD);
+
+    const char flower_msg[] =
=3D "ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";=

+    buf_set_read(&msg_buf, (void *)flower_msg, sizeof(flower_msg));
+    =
receive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "=
Received custom app control message (protocol 'flower')");
+    assert_stri=
ng_equal(mock_managment_buf, ">CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD/=
/SB0aGUg77+94oCPZnJvZyEAAA=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    =
const char msg_incorrect_len[] =3D "ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLC=
AAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=3D";
+    buf_set_read(&msg_buf=
, (void *)msg_incorrect_len, sizeof(msg_incorrect_len));
+    receive_acc_m=
essage(&c, &msg_buf);
+    const char *error =3D "WARNING: Received malform=
ed custom app control channel "
+                        "(field length 62,=
 payload length 64 mismatch) message "
+                        "control me=
ssage: 496e7367 496d316c 496a6f67 496d5a79 "
+                        "6232=
6369 4c434141 65475a6d 2f534a7[more=2E=2E=2E]";
+
+    assert_string_equal(=
mock_msg_buf, error);
+    assert_string_equal(mock_managment_buf, "");
+
+=
    CLEAR(mock_managment_buf);
+    const char msg_fragment[] =3D "ACC,powe=
r,12,6F,aGVsbG8gdw=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_fragment=
, sizeof(msg_fragment));
+    receive_acc_message(&c, &msg_buf);
+    asser=
t_string_equal(mock_msg_buf, "Received custom app control message (protocol=
 'power', fragment)");
+    assert_string_equal(mock_managment_buf, ">CLIEN=
T:ACC,0,0,power,1,aGVsbG8gdw=3D=3D");
+
+    CLEAR(mock_managment_buf);
+  =
  /* check two encoding present */
+    const char flower_msg_two_encs[] =
=3D "ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D"=
;
+    buf_set_read(&msg_buf, (void *)flower_msg_two_encs, sizeof(flower_ms=
g_two_encs));
+    receive_acc_message(&c, &msg_buf);
+
+    error =3D "WAR=
NING: Received malformed custom app control channel (number of "
+         =
   "encodings must be exactly one (B64=3D1, ASCII=3D1)) message control "
+=
            "message: 53534268 62534141 4945746c 636d3170 6443442f 2f534230=
 "
+            "61475567 37372b3[more=2E=2E=2E]";
+    assert_string_equal=
(mock_msg_buf, error);
+    assert_string_equal(mock_managment_buf, "");
+
=
+    /* no encoding present */
+    const char flower_msg_no_encs[] =3D "AC=
C,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    bu=
f_set_read(&msg_buf, (void *)flower_msg_no_encs, sizeof(flower_msg_no_encs)=
);
+    receive_acc_message(&c, &msg_buf);
+
+    error =3D "WARNING: Recei=
ved malformed custom app control channel (number of "
+            "encodin=
gs must be exactly one (B64=3D0, ASCII=3D0)) message control "
+           =
 "message: 53534268 62534141 4945746c 636d3170 6443442f 2f534230 "
+       =
     "61475567 37372b3[more=2E=2E=2E]";
+    assert_string_equal(mock_msg_b=
uf, error);
+    assert_string_equal(mock_managment_buf, "");
+
+    x_debu=
g_level =3D 0;
+    management =3D NULL;
+    gc_free(&gc);
+#endif
+}
+
+v=
oid
+test_parse_acc_parameters(void **state)
+{
+    struct gc_arena gc =3D=
 gc_new();
+    /* parameters to INFO message */
+    const char *info_acc_=
msg =3D "4096 A:6 flower:happy";
+
+    int max_len =3D 0;
+    const char =
*protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc)=
;
+    assert_string_equal(protocols, "flower:happy");
+    assert_int_equa=
l(max_len, 1280);
+
+    /* a client does not accept a length longer than i=
t supports */
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &m=
ax_len, false, &gc);
+    assert_null(protocols);
+
+    /* message with lo=
wer limit than our, should work for client and server */
+    info_acc_msg =
=3D "1111 A:6 flower:happy";
+    protocols =3D parse_acc_parameters(info_a=
cc_msg, " ", &max_len, false, &gc);
+    assert_string_equal(protocols, "fl=
ower:happy");
+    assert_int_equal(max_len, 1111);
+
+    protocols =3D pa=
rse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_str=
ing_equal(protocols, "flower:happy");
+    assert_int_equal(max_len, 1111);=

+
+    /* more encodings than supported=2E Server should be okay, client s=
hould fail */
+    info_acc_msg =3D "1200 A:6:B flower:happy";
+    protoco=
ls =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    =
assert_null(protocols);
+
+    protocols =3D parse_acc_parameters(info_acc_=
msg, " ", &max_len, true, &gc);
+    assert_string_equal(protocols, "flower=
:happy");
+    assert_int_equal(max_len, 1200);
+
+    /* extra parameter *=
/
+    info_acc_msg =3D "1400 A:6 flower:happy 77";
+    protocols =3D pars=
e_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_null(=
protocols);
+
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &m=
ax_len, false, &gc);
+    assert_null(protocols);
+
+
+    const char *iv_a=
cc_capabilities =3D "1400,A:6,flower:happy:power";
+    protocols =3D parse=
_acc_parameters(iv_acc_capabilities, ",", &max_len, true, &gc);
+    assert=
_string_equal(protocols, "flower:happy:power");
+
+    /* too small protoco=
l length */
+    info_acc_msg =3D "32 A:6 flower:happy";
+    protocols =3D=
 parse_acc_parameters(info_acc_msg, ",", &max_len, true, &gc);
+    assert_=
null(protocols);
+
+    /* non-numerical protocol length */
+    info_acc_m=
sg =3D "abff A:6 flower:happy 77";
+    protocols =3D parse_acc_parameters(=
info_acc_msg, ",", &max_len, true, &gc);
+    assert_null(protocols);
+
+  =
  /* non-numerical protocol length */
+    info_acc_msg =3D "abff A:6 flowe=
r:happy 77";
+    protocols =3D parse_acc_parameters(info_acc_msg, ",", &ma=
x_len, true, &gc);
+    assert_null(protocols);
+
+    gc_free(&gc);
+}
+
+=
void
+test_acc_common_protocols(void **state)
+{
+    struct multi_instance=
 mi =3D { 0 };
+    struct context *c =3D &mi=2Econtext;
+    c->options=2E=
gc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_multi, struct tls_mu=
lti, &c->options=2Egc);
+
+    c->c2=2Etls_multi->peer_info =3D "IV_PROTO=
=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power";
+    c->options=2Eacc_proto=
cols =3D "power:flower:star";
+    struct tls_multi *multi =3D c->c2=2Etls_=
multi;
+    multi->opt=2Eacc_protocols =3D c->options=2Eacc_protocols;
+
+ =
   determine_common_acc_protocols(multi, &c->c2=2Etls_multi->session[TM_ACT=
IVE]);
+
+    assert_int_equal(multi->acc_max_message_length, ACC_MAX_MSG_L=
EN);
+    assert_string_equal(multi->acc_negotiated_protocols, "power:flowe=
r");
+
+    gc_free(&c->options=2Egc);
+}
+
+void
+test_acc_send_message(vo=
id **state)
+{
+    struct multi_instance mi =3D { 0 };
+    struct context=
 *c =3D &mi=2Econtext;
+    c->options=2Egc =3D gc_new();
+
+    ALLOC_OBJ_=
CLEAR_GC(c->c2=2Etls_multi, struct tls_multi, &c->options=2Egc);
+    bool =
ret;
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+    c->options=2E=
acc_protocols =3D "power:flower:emergency";
+    multi->opt=2Eacc_protocols=
 =3D c->options=2Eacc_protocols;
+
+
+    c->c2=2Etls_multi->peer_info =3D =
"IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:power";
+    determine=
_common_acc_protocols(multi, &c->c2=2Etls_multi->session[TM_ACTIVE]);
+
+
+=
    struct tls_session *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];=

+
+    ret =3D send_acc_message(c, c->c2=2Etls_multi, session, "emergency"=
, true,
+                           "EMERGENCY BROADCAST MESSAGE - THIS IS =
NOT A DRILL:", false);
+
+    assert_true(ret);
+    assert_string_equal(co=
ntrol_channel_mesage_sent,
+                        "ACC,emergency,50,AF,EM=
ERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:");
+
+    ret =3D send_acc=
_message(c, c->c2=2Etls_multi, session, "emergency", false,
+              =
             "THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR A=
REA=2E", false);
+    assert_true(ret);
+    assert_string_equal(control_ch=
annel_mesage_sent,
+                        "ACC,emergency,65,A,THE GOVERNM=
ENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E");
+
+
+    /* tes=
t a long message (> 1000) with fragment to get the maximum header size */
+=
    char long_message[1200] =3D { 0 };
+
+    for (int i =3D 0; i < 1024; i=
++)
+    {
+        long_message[i] =3D (char)(' ' + (i % 95));
+    }
+
+ =
   /* last char of the message is a i and then a \0 */
+    assert_int_equa=
l(long_message[1023], 'i');
+    assert_int_equal(long_message[1024], '\0')=
;
+
+    ret =3D send_acc_message(c, c->c2=2Etls_multi, session, "emergency=
", true,
+                           long_message, false);
+
+    assert_tr=
ue(ret);
+    size_t cc_len =3D strlen(control_channel_mesage_sent);
+    a=
ssert_int_equal(control_channel_mesage_sent[cc_len - 1], 'i');
+    const c=
har *expected_start_cc =3D "ACC,emergency,1024,AF, !\"#$%&'()*+,-=2E/012345=
";
+    assert_memory_equal(control_channel_mesage_sent, expected_start_cc,=
 sizeof(expected_start_cc));
+
+    gc_free(&c->options=2Egc);
+}
+
+void
+=
test_list_intersection(void **state)
+{
+    const char *empty =3D "";
+   =
 const char *protos =3D "power:flower:emergency";
+
+    struct gc_arena gc=
 =3D gc_new();
+
+    struct buffer t1 =3D get_list_intersection(&gc, empty=
, protos);
+    assert_int_equal(buf_len(&t1), 0);
+
+    struct buffer t2 =
=3D get_list_intersection(&gc, protos, empty);
+    assert_int_equal(buf_le=
n(&t2), 0);
+
+    struct buffer t3 =3D get_list_intersection(&gc, protos, =
protos);
+    assert_string_equal(buf_cstr(&t3), protos);
+
+    const char=
 *protos2 =3D "flower:emergency:power:mario";
+    struct buffer t4 =3D get=
_list_intersection(&gc, protos2, protos);
+    assert_string_equal(buf_cstr=
(&t4), "flower:emergency:power");
+
+    const char *protos3 =3D "super:pap=
er:mario:flower";
+    struct buffer t5 =3D get_list_intersection(&gc, prot=
os2, protos3);
+    assert_string_equal(buf_cstr(&t5), "flower:mario");
+
+=
    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_acc=2Eh b/t=
ests/unit_tests/openvpn/test_acc=2Eh
new file mode 100644
index 0000000=2E=
=2E32421fb
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc=2Eh
@@ -0,=
0 +1,35 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP network=
s
+ *             over a single UDP port, with support for SSL/TLS-based
+ =
*             session authentication and key exchange,
+ *             pack=
et encryption, packet authentication, and
+ *             packet compressio=
n=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *=

+ *  This program is free software; you can redistribute it and/or modify
=
+ *  it under the terms of the GNU General Public License version 2
+ *  as=
 published by the Free Software Foundation=2E
+ *
+ *  This program is dist=
ributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; =
without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A =
PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more det=
ails=2E
+ *
+ *  You should have received a copy of the GNU General Public =
License along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/=
licenses/>=2E
+ */
+
+
+#ifndef TEST_ACC_H
+#define TEST_ACC_H
+void test_a=
cc_parse_client_messages(void **state);
+
+void test_parse_acc_parameters(v=
oid **state);
+
+void test_acc_common_protocols(void **state);
+
+void test=
_acc_send_message(void **state);
+
+void test_list_intersection(void **stat=
e);
+#endif
diff --git a/tests/unit_tests/openvpn/test_common=2Eh b/tests/u=
nit_tests/openvpn/test_common=2Eh
index 8db4ea6=2E=2Ec865142 100644
--- a/t=
ests/unit_tests/openvpn/test_common=2Eh
+++ b/tests/unit_tests/openvpn/test=
_common=2Eh
@@ -43,11 +43,13 @@
 #define LargestIntegralType uintmax_t
 #en=
dif
 /* redefine 2=2Ex API in terms of 1=2Ex API */
-#define CMockaValueDat=
a             LargestIntegralType
-#define check_expected_uint         chec=
k_expected
-#define expect_uint_value           expect_value
-#define expec=
t_check_data           expect_check
-#define cast_ptr_to_cmocka_value(x) (x=
)
+#define CMockaValueData                       LargestIntegralType
+#defi=
ne check_expected_uint                   check_expected
+#define expect_uin=
t_value                     expect_value
+#define expect_check_data        =
             expect_check
+#define cast_ptr_to_cmocka_value(x)           (x=
)
+#define assert_int_in_range(value, min, max)  assert_in_range((value), (=
min), (max))
+#define assert_uint_in_range(value, min, max) assert_in_range=
((value), (min), (max))
 #endif
 
 /**
diff --git a/tests/unit_tests/openvp=
n/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index aea40f0=2E=
=2E7405198 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/=
unit_tests/openvpn/test_misc=2Ec
@@ -41,10 +41,34 @@
 #include "mock_msg=2E=
h"
 #include "crypto=2Eh"
 #include "sid_hash=2Eh"
+#include "test_schedule=
=2Eh"
+#include "multi=2Eh"
+
 #ifdef _WIN32
 #include "win32-util=2Eh"
 #e=
ndif
-#include "test_schedule=2Eh"
+
+/* extra mocks */
+bool
+apply_push_o=
ptions(struct context *c, struct options *options, struct buffer *buf,
+   =
                uint64_t permission_mask, uint64_t *option_types_found,
+  =
                 struct env_set *es, bool is_update)
+{
+    return true;
+=
}
+
+bool
+send_control_channel_string(struct context *c, const char *str, =
msglvl_t msglevel)
+{
+    check_expected_ptr(str);
+    return true;
+}
+
=
+struct multi_instance *
+lookup_by_cid(struct multi_context *m, const unsi=
gned long cid)
+{
+    return *(m->instances);
+}
 
 static void
 test_comp=
at_lzo_string(void **state)
diff --git a/tests/unit_tests/openvpn/test_ssl=
=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index 4baf8cc=2E=2E4987dd0 100=
644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/open=
vpn/test_ssl=2Ec
@@ -52,6 +52,8 @@
 #include "ssl_verify=2Eh"
 #include "op=
envpn=2Eh"
 
+#include "test_acc=2Eh"
+
 /* Mock function to be allowed to =
include win32=2Ec which is required for
  * getting the temp directory */
 =
#ifdef _WIN32
@@ -86,6 +88,20 @@
 {
     return;
 }
+void
+reschedule_multi=
_process(struct context *c)
+{
+}
+
+/* Define a dummy dco cipher option to=
 avoid linking against all the DCO
+ * units */
+#if defined(ENABLE_DCO)
+c=
onst char *
+dco_get_supported_ciphers(void)
+{
+    return "AES-192-GCM:AE=
S-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+}
+#endif
 
 /* gene=
rated using
  * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:sec=
p384r1 -keyout - \
@@ -1111,8 +1127,12 @@
         cmocka_unit_test(ssl_tes=
t_extract_last_matching_field),
         cmocka_unit_test(ssl_test_reject_n=
ull_in_cert_subject),
         cmocka_unit_test(ssl_test_escape_rfc_2253_ch=
ars_in_subject),
-        cmocka_unit_test(ssl_test_extract_peer_info)
-
+ =
       cmocka_unit_test(ssl_test_extract_peer_info),
+        cmocka_unit_t=
est(test_acc_parse_client_messages),
+        cmocka_unit_test(test_parse_a=
cc_parameters),
+        cmocka_unit_test(test_acc_common_protocols),
+    =
    cmocka_unit_test(test_acc_send_message),
+        cmocka_unit_test(test=
_list_intersection)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d79=
5b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: 14
Gerrit-Own=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>

--MoJAN2gCbRo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe <strong>uploaded patch set #14</strong> to this change=2E</p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vie=
w Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Implement sending/receiving app custom contro=
l protocol messages<br><br>This allows openvpn GUI/front-ends and server vi=
a management<br>to use the OpenVPN control channel to pass messages between=
 each other<br>while OpenVPN handles the marshalling/unmarshalling of these=
 and<br>negotiate the common app custom control protocols=2E<br><br>This pr=
ovides an easy to use secure channel that does not depend on<br>the network=
 itself to work and can also used before fully authenticating<br>the client=
=2E See the management-notes=2Etxt for more details how to use<br>this feat=
ure=2E An upcoming patch will also add some example python<br>script that s=
howcase this feature=2E<br><br>Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86=
b8ae4c84<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<b=
r>M CMakeLists=2Etxt<br>M doc/man-sections/client-options=2Erst<br>M doc/ma=
n-sections/management-options=2Erst<br>M doc/man-sections/script-options=2E=
rst<br>M doc/management-notes=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src=
/openvpn/acc=2Ec<br>A src/openvpn/acc=2Eh<br>M src/openvpn/forward=2Ec<br>M=
 src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/manage=
=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M src/openv=
pn/options=2Eh<br>M src/openvpn/push=2Ec<br>M src/openvpn/push=2Eh<br>M src=
/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M tests/unit_tests/open=
vpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/mock_management=2Ec<br>A te=
sts/unit_tests/openvpn/mock_management=2Eh<br>M tests/unit_tests/openvpn/mo=
ck_push_dependencies=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Ec<br>A te=
sts/unit_tests/openvpn/test_acc=2Eh<br>M tests/unit_tests/openvpn/test_comm=
on=2Eh<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>M tests/unit_tests/op=
envpn/test_ssl=2Ec<br>28 files changed, 1,516 insertions(+), 26 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/58/1858/14</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMake=
Lists=2Etxt</span><br><span>index 184a95a=2E=2E00caa2d 100644</span><br><sp=
an>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br>=
<span>@@ -435,6 +435,8 @@</span><br><span>     src/compat/compat-strlcpy=2E=
c</span><br><span>     src/compat/compat-strsep=2Ec</span><br><span>     sr=
c/compat/compat-strtok_r=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    src/openvpn/acc=2Ec</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    src/openvpn/acc=2Eh</span><br><span>     src/openvpn/argv=
=2Ec</span><br><span>     src/openvpn/argv=2Eh</span><br><span>     src/ope=
nvpn/base64=2Ec</span><br><span>@@ -571,8 +573,8 @@</span><br><span>     sr=
c/openvpn/ps=2Ec</span><br><span>     src/openvpn/ps=2Eh</span><br><span>  =
   src/openvpn/push=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    src/openvpn/push_util=2Ec</span><br><span>     src/openvpn/push=2Eh</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/push_=
util=2Ec</span><br><span>     src/openvpn/pushlist=2Eh</span><br><span>    =
 src/openvpn/reflect_filter=2Ec</span><br><span>     src/openvpn/reflect_fi=
lter=2Eh</span><br><span>@@ -826,7 +828,10 @@</span><br><span>             =
tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>             t=
ests/unit_tests/openvpn/mock_ssl_dependencies=2Ec</span><br><span>         =
    tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/test_ac=
c=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sr=
c/openvpn/acc=2Ec</span><br><span>             src/openvpn/argv=2Ec</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/aut=
h_token=2Ec</span><br><span>             src/openvpn/base64=2Ec</span><br><=
span>             src/openvpn/crypto_epoch=2Ec</span><br><span>            =
 src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -840,8 +845,11 @@</span>=
<br><span>             src/openvpn/options_util=2Ec</span><br><span>       =
      src/openvpn/otime=2Ec</span><br><span>             src/openvpn/packet=
_id=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
src/openvpn/reliable=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            src/openvpn/session_id=2Ec</span><br><span>             sr=
c/openvpn/run_command=2Ec</span><br><span>             src/openvpn/ssl_mbed=
tls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
src/openvpn/ssl_ncp=2Ec</span><br><span>             src/openvpn/ssl_openss=
l=2Ec</span><br><span>             src/openvpn/ssl_util=2Ec</span><br><span=
>             src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -858,6 =
+866,8 @@</span><br><span>     target_sources(test_misc PRIVATE</span><br><=
span>         tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span>=
         tests/unit_tests/openvpn/test_schedule=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_man=
agement=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
src/openvpn/base64=2Ec</span><br><span>         src/openvpn/options_util=2E=
c</span><br><span>         src/openvpn/otime=2Ec</span><br><span>         s=
rc/openvpn/ssl_util=2Ec</span><br><span>diff --git a/doc/man-sections/clien=
t-options=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>ind=
ex 87c138a=2E=2Eb204d6a 100644</span><br><span>--- a/doc/man-sections/clien=
t-options=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2Erst=
</span><br><span>@@ -12,6 +12,17 @@</span><br><span>   When this option is =
set, OpenVPN will not drop incoming tun packets with</span><br><span>   sam=
e destination as host=2E</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+--app-custom-control protocollist</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  Sets the list of supported app custo=
m control protocols=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  These protocols are announced to the server when this option is used</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  as a client=2E If t=
he option is set on a server it will negotiate the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  common protocols with the client=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  The protocollist is a : separated list of p=
rotocol identifiers=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  See management=
-notes=2Etxt in the OpenVPN distribution and the OpenVPN RFC</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  draft for a description of app c=
ustom control protocol support=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> --auth-token token</span><br><span>   This =
is not an option to be used directly in any configuration files,</span><br>=
<span>   but rather push this option from a ``--client-connect`` script or =
a</span><br><span>@@ -437,6 +448,12 @@</span><br><span>         Additional =
authentication methods supported by the client=2E</span><br><span>         =
This may be set by the client UI/GUI using ``--setenv``=2E</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`IV_ACC=3D=
&lt;max_msg_len&gt;,&lt;flags&gt;,&lt;protocols&gt;`</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        If the option ``--app-custom-cont=
rol`` is set, the client will</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        send the supported max ACC message length, the supported =
formats</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        as (=
:code:`A:6`) and the list of configured protocols (e=2Eg=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        :code:`flower:happy:power`)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
 The following flags depend on which compression formats are compiled in</s=
pan><br><span>   and whether compression is allowed by options=2E See `Prot=
ocol options`_</span><br><span>   for more details=2E</span><br><span>diff =
--git a/doc/man-sections/management-options=2Erst b/doc/man-sections/manage=
ment-options=2Erst</span><br><span>index e2e0773=2E=2Ef32273f 100644</span>=
<br><span>--- a/doc/man-sections/management-options=2Erst</span><br><span>+=
++ b/doc/man-sections/management-options=2Erst</span><br><span>@@ -144,3 +1=
44,9 @@</span><br><span> </span><br><span> --management-up-down</span><br><=
span>   Report tunnel up/down events to management interface=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+--app-custom-control protocol-list</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Sets the app custom control proto=
cols that are supported and should be</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  negotiated=2E protocol-list is a list of allowed protoc=
ols separated by :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 A client will announce these protocols via the IV_ACC variable and the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  server will notify th=
e client about the common protocols=2E</span><br><span>diff --git a/doc/man=
-sections/script-options=2Erst b/doc/man-sections/script-options=2Erst</spa=
n><br><span>index f420380f=2E=2E9c17c3b 100644</span><br><span>--- a/doc/ma=
n-sections/script-options=2Erst</span><br><span>+++ b/doc/man-sections/scri=
pt-options=2Erst</span><br><span>@@ -1006,3 +1006,12 @@</span><br><span>   =
     X509_1_L=3DBISHKEK</span><br><span>        X509_1_ST=3DNA</span><br><s=
pan>        X509_1_C=3DKG</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+:code:`acc_pr=
otocols`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    If ``--=
app-custom-control`` is configured and the client supports any of the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols that server=
 also supports, this variable contains a list of</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    common protocols separated by :=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+:code:`acc_message_len`</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if :code:`acc_protocols` is set, this=
 variable contains the maximum</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    message length for app custom protocol message=2E</span><br>=
<span>\ No newline at end of file</span><br><span>diff --git a/doc/manageme=
nt-notes=2Etxt b/doc/management-notes=2Etxt</span><br><span>index 4d726c4=
=2E=2E8fffd0c 100644</span><br><span>--- a/doc/management-notes=2Etxt</span=
><br><span>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -828,6 +828,=
59 @@</span><br><span> that is required to continue the connection (unlike =
MFA or opening a browser)</span><br><span> this message is not negotiated b=
ut can just be sent as a gratuitous message=2E</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+app custom control</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+If the special string &quot;ACC&quot; is passed as {EXTRA} OpenVPN wil=
l determine</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the comm=
on app custom protocols between the client and the server and instruct</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+the client that the serv=
er will send control messages to the client using</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+the ACC protocol=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+The server should then use acc-msg command to send app custom co=
ntrol messages</span><br><span style=3D"color: hsl(120, 100%, 40%);">+to th=
e client to facilitate the pending authentication=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+COMMAND -- client-acc-msg (OpenVPN 2=2E8 or higher)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+----------------------------=
--------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+On an OpenVPN instance r=
unning in server mode this command sends an</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+app custom control message to a client=2E The forma=
t of the command is:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  client-acc-msg {=
CID} {KID}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {protoc=
ol}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {flags}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  {message}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  END</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+CID,KID -- client ID and Key ID=2E See documentation for &quot;&gt;=
CLIENT:&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+notifi=
cation for more info=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+protocol -- the=
 ACC protocol identifier that this message should be</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            tagged with=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+flags    -- a colon separated list of the encoding an=
d the flag if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      the message is a fragment=2E E=2Eg=2E &quot;6:F&quot; for a base64 en=
coded</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            me=
ssage that is also a fragment and not complete yet=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+message  -- The message encoded in the encoding specified in=
 flags</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+COMMAND -- acc-msg (OpenVPN 2=2E8 or higher)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+--------------------------=
----------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+When OpenVPN is runnin=
g in --client mode this command sends an app</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+custom command to the server=2E The format of the =
command is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  acc-msg</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  {protocol}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  {flags}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  {message}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+See the client-acc-ms=
g command for more details about the format of the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+message=2E Since a client has only one peer =
there is no need to specify the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+client id and key id=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&gt=
;&gt;&gt;&gt;&gt;&gt;&gt; fd23ffa35a (Implement sending/receiving app custo=
m control protocol messages)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> COMMAND -- client-deny  (OpenVPN 2=2E1 or higher=
)</span><br><span> -----------------------------------------------</span><b=
r><span> </span><br><span>@@ -1302,6 +1355,39 @@</span><br><span>    respon=
se=2E Mechanisms that need multiple rounds or more complex answers</span><b=
r><span>    should implement a different response type than CR_RESPONSE=2E<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+(6=
) App custom control message</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    This m=
essage is an application specific payload message that is transported</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    over the OpenVPN cont=
rol channel=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    In server mode:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &gt;CLIENT:ACC,{CID},{KID},{protocol}=
,{fragment},{msg_base64}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    In client =
mode:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &gt;ACC:{protocol},{fragment}=
,{msg_base64}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    The protocol is a sho=
rt ascii string identifying the app specific custom</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    protocol=2E If fragment is set to 1, =
the message is not complete and the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    next message should be concatenated to this message to =
form a complete</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
message=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+(7) App custom control proto=
col message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+   This message informs the=
 client about the common ACC</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+   protocols and the maximum message length for an ACC message=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+   In client mode:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+   &gt;ACC_PROTOCOLS:protocols=3D{protocol_list},message_le=
n=3D{max_msg_len}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+   protocol_list is a=
 list of supported protocols by the client=2E For example</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+   flower:power:sys_info would indica=
te these three protocols to be supported=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+   max_msg_len specifies the maximum message length=
 that the peer supports=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   In server=
 mode these are available in the acc_protocols and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+   acc_message_len variables of the client e=
nvironment=2E</span><br><span> </span><br><span> Variables:</span><br><span=
> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Mak=
efile=2Eam</span><br><span>index 8a60a94=2E=2Eebc4db6 100644</span><br><spa=
n>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefil=
e=2Eam</span><br><span>@@ -45,6 +45,7 @@</span><br><span> sbin_PROGRAMS =3D=
 openvpn</span><br><span> </span><br><span> openvpn_SOURCES =3D \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	acc=2Ec acc=2Eh \</span><br>=
<span> 	argv=2Ec argv=2Eh \</span><br><span> 	auth_token=2Ec auth_token=2Eh=
 \</span><br><span> 	base64=2Ec base64=2Eh \</span><br><span>@@ -124,7 +125=
,8 @@</span><br><span> 	proto=2Ec proto=2Eh \</span><br><span> 	proxy=2Ec p=
roxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	push=2Ec push_util=2Ec push=2Eh \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	push=2Ec push=2Eh \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	push_util=2Ec \</span><br><span> 	p=
ushlist=2Eh \</span><br><span> 	reflect_filter=2Ec reflect_filter=2Eh \</sp=
an><br><span> 	reliable=2Ec reliable=2Eh \</span><br><span>diff --git a/src=
/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>new file mode 100644=
</span><br><span>index 0000000=2E=2E5f6daa5</span><br><span>--- /dev/null</=
span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -0,0 +1,413 @@<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to secu=
rely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             over a single TCP/UDP port, with support for SSL/TLS-bas=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             se=
ssion authentication and key exchange,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet encryption, packet authentication,=
 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (=
C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rf=
c2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you=
 can redistribute it and/or modify</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  it under the terms of the GNU General Public License ver=
sion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publis=
hed by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  This program is distributed in the hope that it will be useful,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRA=
NTY; without even the implied warranty of</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  G=
NU General Public License for more details=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  You should have received a copy of the GNU General Public Lice=
nse along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with t=
his program; if not, write to the Free Software Foundation, Inc=2E,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fif=
th Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONF=
IG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
br><span style=3D"color: hsl(120, 100%, 40%);">+    int payload_len;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *payload_le=
n_str =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!payload_len_str || !((pay=
load_len =3D atoi(payload_len_str))))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        err_reason =3D &quot;could not extract payload length field&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int flags =3D parse_acc_message_flags(&amp;buf,=
 &amp;err_reason, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (fla=
gs &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* We should have a final NUL byte in the control mess=
age buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * an=
d thus the length of the buffer should be payload_len + 1 */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;buf) !=3D pay=
load_len + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *tmp =
=3D gc_malloc(512, 1, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        snprintf(tmp, 512, &quot;field length %d, payload lengt=
h %d mismatch&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                 payload_len, buf_len(&amp;buf) - 1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D tmp;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    log_acc=
_message(c, &amp;buf, payload_len, protocol, flags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ms=
g(D_PUSH_ERRORS, &quot;WARNING: Received malformed custom app control chann=
el &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
             &quot;(%s) message control message: %s&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        err_reason,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        format_hex(BPTR(&amp;buf), B=
LEN(&amp;buf), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+send_acc_message(struct context *c,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 struct tls_multi *multi,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 st=
ruct tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                 const char *protocol, bool fragment,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 const char *msg, =
bool base64)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * length of the protocol string +=
 one &#39;,&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * 2 for the encoding (A or 6), potential F (fragment), and 1 for the &#39=
;,&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 4 fo=
r the message size itself and one comma</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * 1 for the comma before the message itself */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t max_he=
ader_size =3D strlen(&quot;ACC,&quot;) + strlen(protocol) + 1 + 4 + 1 + 2 +=
 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t len =
=3D max_header_size + strlen(msg);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (len &gt; TLS_CHANNEL_BUF_SIZE)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(M_CLIENT, &quot;message length (%zu) exceeds maximum possible =
message length (%d)&quot;, len, TLS_CHANNEL_BUF_SIZE);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if ((int)len &gt; multi-&gt;acc_max_message_length)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;header (%zu) + messag=
e size (%zu) length (%zu) exceeds &quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                      &quot;maximum allowed length neg=
otiated with peer (%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            max_header_size, strlen(msg), len,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;acc_max_message_=
length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* add 1 for the fin=
al \0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer buf =3D alloc_buf_gc(len + 1, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &q=
uot;ACC,%s,%zu,%s%s,%s&quot;, protocol,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+               strlen(msg),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+               base64 ? &quot;6&quot; : &quot;A=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
   fragment ? &quot;F&quot; : &quot;&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+               msg);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    send_control_channel_string_dowork(session, BSTR(&amp;buf), D_PUS=
H);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reschedule_m=
ulti_process(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+parse_acc_parameters(const char *capabilities,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     const =
char *delim,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              int *max_acc_len,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     bool server,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     struct gc_arena *gc)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    char *tmp_message =3D string_alloc(capabi=
lities, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
har *tmp_message_orig =3D tmp_message;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *token =3D strtok_r(tmp_message, delim, &amp;lasts);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int p =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int acclen =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *protocols =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* In server mode we allow more ca=
pabilities than our own, in client</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * mode we reject if we should use capabilities that we =
do not support */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    while (token)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (p =3D=3D 0 &amp;&amp; !atoi_constrained(token, &amp;accl=
en, &quot;ACC message length&quot;, ACC_MIN_MSG_LEN, allowed_acc_len, D_PUS=
H_ERRORS))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto do=
ne;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp; (!tls_item_=
in_cipher_list(&quot;A&quot;, token) || !tls_item_in_cipher_list(&quot;6&qu=
ot;, token)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(=
D_PUSH_ERRORS, &quot;App custom control encoding must include base64 and as=
cii&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp; =
!server &amp;&amp; strcmp(token, &quot;A:6&quot;) &amp;&amp; strcmp(token, =
&quot;6:A&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(D_PUSH_ERRORS, &quot;App custom control encoding must exactly base64 an=
d ascii&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 2)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            protocols =3D token;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (p =3D=3D 3)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;Too many parameters f=
or INFO ACC message/IV_ACC=2E&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            goto done;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
token =3D strtok_r(NULL, delim, &amp;lasts);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        p++;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *max_acc_le=
n =3D min_int(acclen, ACC_MAX_MSG_LEN);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ret =3D string_alloc(protocols, gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+done:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    free(tmp_message_orig);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+get_list_intersection(struct gc=
_arena *gc, const char *list1, const char *list2)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    char *tmp =3D strdup(list1);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *token =3D strtok_r(tmp, &quo=
t;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The maxi=
mum possible length is the shorter of the two input lists */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    size_t max_len =3D min_size(st=
rlen(list1), strlen(list2));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer common_protocols =3D alloc_buf_gc(max_len + 1, gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    while (token)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (tls_item_in_cipher_list(token, list2))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            /* protocol is in both server and cli=
ent list */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    if (buf_len(&amp;common_protocols) &gt; 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                buf_write_u8(&amp;common_protocols, &#=
39;:&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bu=
f_printf(&amp;common_protocols, &quot;%s&quot;, token);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        token =3D strtok_r(NULL, &quot;:&quot;, &=
amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(tmp);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return common_protocols=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+determine_common_acc_protocols(struct tls_multi *multi, struct tls_ses=
sion *session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;opt=
=2Eacc_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* No ap=
p custom protocols have been configured server-side=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* We already have determined the common protocols=2E Do=
ing this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
again would just add an extra string allocation to options-&gt;gc */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* example IV_ACC: IV_ACC=3D2048,6:A,flower:power */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *peer_info =
=3D multi-&gt;peer_info;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const char *iv_acc =3D extract_var_peer_info(peer_info, &quot;IV_A=
CC=3D&quot;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!iv_acc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int max_acc_len =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    char *protocols =3D parse_acc_para=
meters(iv_acc, &quot;,&quot;, &amp;max_acc_len, true, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!protocols)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;WARNING: IV_ACC peer info=
 variable of peer is malformed&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
common_protocols =3D get_list_intersection(&amp;gc, session-&gt;opt-&gt;acc=
_protocols, protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len=
(&amp;common_protocols) =3D=3D 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(D_PUSH_DEBUG, &quot;WARNING: No common app custom control proto=
col=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;acc_negotiated_protoco=
ls =3D string_alloc(buf_str(&amp;common_protocols), NULL);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;acc_max_message_length=
 =3D max_acc_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(sessio=
n-&gt;opt-&gt;es, &quot;acc_protocols&quot;, multi-&gt;acc_negotiated_proto=
cols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_in=
t(session-&gt;opt-&gt;es, &quot;acc_message_len&quot;, multi-&gt;acc_max_me=
ssage_length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff=
 --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span><br><span>new file=
 mode 100644</span><br><span>index 0000000=2E=2E4a388f7</span><br><span>---=
 /dev/null</span><br><span>+++ b/src/openvpn/acc=2Eh</span><br><span>@@ -0,=
0 +1,105 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applica=
tion to securely tunnel IP networks</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             over a single TCP/UDP port, with support for=
 SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          session authentication and key exchange,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet aut=
hentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            packet compression=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe=
 &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
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
>+ *  with this program; if not, write to the Free Software Foundation, Inc=
=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin=
 Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define AC=
C_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define ACC_MIN_MSG_LEN 64</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define ACC_MAX_MSG_LEN 1280</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * This method parses an app custom control message and deli=
vers it to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ma=
nagement interface=2E We leave reassembly of fragmented messages to the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * management interface=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param c            The contex=
t struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param b=
uffer       Buffer containing the control message with ACC</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+receive_acc_message(struct context *c, const struct buffer *buffer)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+send_acc_message(struct context *c,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                 struct tls_multi *tls_multi,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                 struct tls_s=
ession *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
              const char *protocol, bool fragment,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                 const char *msg, bool base6=
4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Parses an info message from the server that contains app custom con=
trol info</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * informa=
tion prior to the PUSH_REPLY to be able to use app custom control</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * protocols before sending</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * In client mode only allow what we s=
upport ourselves=2E In server mode</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * allow also capabilities that we not support ourselves=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param capabilities      The strin=
g to parse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 delim             The delimiter to use when parsing the string=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *                          =
IV_ACC uses &quot;,&quot; as delimiter while the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *                          custom-control PUS=
H message uses &quot; &quot; as &quot;,&quot; is</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *                          already used to se=
parate different push directives</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param max_acc_len       Set to the maximum ACC message len=
gth</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param server=
            Whether we are server or client</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param gc                The gc arena to use for=
 allocating the resulting string</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return                  The resulting protocol string or N=
ULL on error</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+parse_acc_parameters(const char *cap=
abilities,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
            const char *delim,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                     int *max_acc_len,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                     bool server,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                     struct gc_=
arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Parses the IV_ACC of the peer and sets=
 multi=2Eacc_negotiated_protocols</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * to the common protocols of server and client and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * multi=2Eacc_max_message_le=
ngth  to the maximum length of the ACC message</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * support by both server and client=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * If there is no common protocol or the clie=
nt does not support any app custom</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * protocol multi=2Eacc_negotiated_protocols will be set to =
NULL=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param multi      the mult=
i instance to use the set the app custom protocols=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param session    the session to read =
the client env from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protocols(=
struct tls_multi *multi, struct tls_session *session);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Calculates the intersection of two list that are both separated by :</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Items in the result =
will have the same ordering as in the list1</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * parameters</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param gc            Returned buffer will be allocated=
 in this gc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m list1         First list to intersect</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param list2         Second list to intersect=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return A (potential=
ly empty) buffer containing an intersection list</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+struct buffer</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+get_list_intersection(struct gc_arena *gc, const char *list1, const =
char *list2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=
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
/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index fc100da=2E=
=2E800295e 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><spa=
n>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2279,6 +2279,13 @@</span><=
br><span>         }</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-=
&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        buf_printf(&amp;out, &quot; custom-control %d,A:6,%s&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
  multi-&gt;acc_max_message_length, multi-&gt;acc_negotiated_protocols);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (BLENZ(&amp=
;out) &gt; strlen(header))</span><br><span>     {</span><br><span>         =
msg(D_HANDSHAKE, &quot;%s&quot;, BSTR(&amp;out));</span><br><span>@@ -2522,=
6 +2529,11 @@</span><br><span>         flags |=3D (OPT_P_ROUTE | OPT_P_DHCP=
DNS);</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_protocols)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        flags |=3D OPT_P_ACC;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     return flags;</span><br=
><span> }</span><br><span> </span><br><span>@@ -2730,6 +2742,17 @@</span><b=
r><span>         frame-&gt;tun_mtu =3D min_int(frame-&gt;tun_max_mtu, c-&gt=
;options=2Ece=2Etun_mtu);</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (found &amp; OPT_P_AC=
C &amp;&amp; c-&gt;options=2Epushed_acc_negotiated_protocols)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct tls_multi *multi =3D c-&gt;c2=2E=
tls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f=
ree(multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        multi-&gt;acc_negotiated_protocols =3D string_=
alloc(c-&gt;options=2Epushed_acc_negotiated_protocols, NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;acc_max_message=
_length =3D c-&gt;options=2Epushed_acc_max_message_length;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(D_PUSH, &quot;OPTIONS IMPORT: ACC protocols=
: %s, msg len: %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            multi-&gt;acc_negotiated_protocols, multi-&gt;acc_max_mess=
age_length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
 return true;</span><br><span> }</span><br><span> </span><br><span>@@ -3352=
,6 +3375,7 @@</span><br><span>     to=2Everify_hash_depth =3D options-&gt;v=
erify_hash_depth;</span><br><span>     to=2Everify_hash_no_ca =3D options-&=
gt;verify_hash_no_ca;</span><br><span>     memcpy(to=2Ex509_username_field,=
 options-&gt;x509_username_field, sizeof(to=2Ex509_username_field));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2Eacc_protocols =3D=
 options-&gt;acc_protocols;</span><br><span>     to=2Ees =3D c-&gt;c2=2Ees;=
</span><br><span>     to=2Enet_ctx =3D &amp;c-&gt;net_ctx;</span><br><span>=
 </span><br><span>@@ -4306,6 +4330,24 @@</span><br><span> }</span><br><span=
> #endif /* ifdef TARGET_ANDROID */</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+management_acc_msg(void *arg,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                   struct buffer_list *=
input) /* ownership transferred */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct context *c =3D arg;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool re=
t =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(buffer_list_defined(input) &amp;&amp; c-&gt;c2=2Etls_multi)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        struct tls_multi *multi =3D c-&gt;c2=2Et=
ls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct tls_session *session =3D &amp;multi-&gt;session[TM_ACTIVE];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        ret =3D management_send_acc_message(c, mu=
lti, session, input);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_free(input);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #endif =
/* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><span> void</span=
><br><span>@@ -4322,6 +4364,7 @@</span><br><span>         cb=2Eproxy_cmd =
=3D management_callback_proxy_cmd;</span><br><span>         cb=2Eremote_cmd=
 =3D management_callback_remote_cmd;</span><br><span>         cb=2Esend_cc_=
message =3D management_callback_send_cc_message;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cb=2Eacc_msg =3D management_acc_msg;</=
span><br><span> #ifdef TARGET_ANDROID</span><br><span>         cb=2Enetwork=
_change =3D management_callback_network_change;</span><br><span> #endif</sp=
an><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</=
span><br><span>index ccf66b43=2E=2E86d82ba 100644</span><br><span>--- a/src=
/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br>=
<span>@@ -45,9 +45,11 @@</span><br><span> #include &quot;push=2Eh&quot;</sp=
an><br><span> #include &quot;multi=2Eh&quot;</span><br><span> #include &quo=
t;resolve=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;acc=2Eh&quot;</span><br><span> </span><br><span> #include &q=
uot;memdbg=2Eh&quot;</span><br><span> #include &quot;run_command=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_n=
cp=2Eh&quot;</span><br><span> </span><br><span> #ifdef ENABLE_PKCS11</span>=
<br><span> #include &quot;pkcs11=2Eh&quot;</span><br><span>@@ -1082,6 +1084=
,35 @@</span><br><span>             }</span><br><span>             break;</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     case IEC_CLIENT_ACC_MSG:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (man-&gt;persist=2Ecallback=2Eclient_acc_msg)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                bool status =
=3D (*man-&gt;persist=2Ecallback=2Eclient_acc_msg)(man-&gt;persist=2Ecallba=
ck=2Earg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                                            man-&gt;connect=
ion=2Ein_extra_cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                                                      man-&=
gt;connection=2Ein_extra_kid,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                                                 =
     man-&gt;connection=2Ein_extra);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                man-&gt;connection=2Ein_extra =3D NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                report=
_command_status(status, &quot;client-acc-msg&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                man_command_unsupported(&quot;client-acc=
-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            b=
reak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        case IEC_ACC_MSG:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;per=
sist=2Ecallback=2Eacc_msg)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                bool status =3D (*man-&gt;persist=2Ecallback=2Eacc_msg)(ma=
n-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                                               =
man-&gt;connection=2Ein_extra);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                man-&gt;connection=2Ein_extra =3D NULL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                report_comm=
and_status(status, &quot;acc-msg&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                man_command_unsupported(&quot;acc-msg&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><spa=
n>         case IEC_PK_SIGN:</span><br><span>             man-&gt;connectio=
n=2Eext_key_state =3D EKS_READY;</span><br><span>             buffer_list_f=
ree(man-&gt;connection=2Eext_key_input);</span><br><span>@@ -1206,6 +1237,2=
9 @@</span><br><span> }</span><br><span> </span><br><span> static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+man_client_acc_msg(struc=
t management *man, const char *cid_str,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                   const char *kid_str)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct man_connection *mc =3D &amp;man-&gt;connec=
tion;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_=
extra_cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 mc-&gt;in_extra_kid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (parse_cid(cid_str, &amp;mc-&gt;in_extra_cid)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; parse_uint(kid_=
str, &quot;KID&quot;, &amp;mc-&gt;in_extra_kid))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        mc-&gt;in_extra_cmd =3D IEC_CLIENT_ACC_MSG;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        in_extra_reset(mc, I=
ER_NEW);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+man_acc_msg(struct management *man)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct man_connection *mc =3D &amp;man-&gt;connection;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_cmd =3D IEC=
_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_ext=
ra_reset(mc, IER_NEW);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> man_c=
lient_auth(struct management *man, const char *cid_str, const char *kid_str=
, const bool extra)</span><br><span> {</span><br><span>     struct man_conn=
ection *mc =3D &amp;man-&gt;connection;</span><br><span>@@ -1760,6 +1814,17=
 @@</span><br><span>             man_client_pending_auth(man, p[1], p[2], p=
[3], p[4]);</span><br><span>         }</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;cl=
ient-acc-msg&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (m=
an_need(p, 2, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
man_client_acc_msg(man, p[1], p[2]);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e if (streq(p[0], &quot;acc-msg&quot;))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        man_acc_msg(man);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;rsa-sig&q=
uot;))</span><br><span>     {</span><br><span>         man_pk_sig(man, &quo=
t;rsa-sig&quot;);</span><br><span>@@ -2978,7 +3043,9 @@</span><br><span>   =
                                     &quot;bytes_sent=3D&quot;,</span><br><=
span>                                        &quot;bytes_received=3D&quot;,=
</span><br><span>                                        &quot;session_id=
=3D&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                            &quot;session_state=3D&quot; };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
    &quot;session_state=3D&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                       &quot;acc_protocols=3D=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                           &quot;acc_message_len=3D&quot; };</span><br><spa=
n> </span><br><span>     if (env_filter_level =3D=3D 0)</span><br><span>   =
  {</span><br><span>@@ -3133,6 +3200,7 @@</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> void</span><br><span> management_connection_establ=
ished(struct management *man, struct man_def_auth_context *mdac,</span><br>=
<span>                                   const struct env_set *es)</span><b=
r><span>@@ -4375,6 +4443,64 @@</span><br><span>     }</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_send_acc=
_message(struct context *c, struct tls_multi *multi, struct tls_session *se=
ssion,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
               struct buffer_list *input)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* also ensures that are enough inputs in the list to safely call</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * buffer_list_pe=
ek without extra NULL checks */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!input || input-&gt;size &lt; 3)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_CLIENT, &quot;not enough input lines for =
sending acc message, &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                      &quot;missing protocol, flag and/or messages =
lines&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *proto_buf =3D =
buffer_list_peek(input);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const char *protocol =3D string_alloc(CBSTR(proto_buf), &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_pop(=
input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer *encoding_buf=
 =3D buffer_list_peek(input);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    char *encoding =3D buf_str(encoding_buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *flag =3D NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    bool b64encoding =3D fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool fragmen=
t =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    while ((flag =3D strse=
p(&amp;encoding, &quot;:&quot;)))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!strcmp(flag, &quot;6&quot;))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            b64encoding =3D true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        else if (!strcmp(flag, &quot;F&quot;))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            fragment =3D true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buffer_list_pop(input);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buffer_list_aggregate_separator(input, 10000, &quot;&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buf=
fer *acc_msg_buf =3D buffer_list_peek(input);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!multi-&gt;acc_negotiated_protocols</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        || !tls_item_in_cipher_list(protocol=
, multi-&gt;acc_negotiated_protocols))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(M_CLIENT, &quot;protocol not in the list of negotiated pro=
tocols: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          np(multi-&gt;acc_negotiated_protocols));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  bool ret =3D send_acc_message(c, multi, session, protocol,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                fr=
agment, buf_cstr(acc_msg_buf),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                b64encoding);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+error:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span> #else /* ifdef ENABLE_MANAGEMENT *=
/</span><br><span> </span><br><span> #include &quot;win32=2Eh&quot;</span><=
br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span=
><br><span>index 157039d=2E=2Ecc9c264 100644</span><br><span>--- a/src/open=
vpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span=
>@@ -184,12 +184,19 @@</span><br><span>     int (*n_clients)(void *arg);</s=
pan><br><span>     bool (*send_cc_message)(void *arg, const char *message, =
const char *parameter);</span><br><span>     bool (*kill_by_cid)(void *arg,=
 const unsigned long cid, const char *kill_msg);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     bool (*client_auth)(void=
 *arg, const unsigned long cid, const unsigned int mda_key_id,</span><br><s=
pan>                         const bool auth, const char *reason, const cha=
r *client_reason,</span><br><span>                         struct buffer_li=
st *cc_config); /* ownership transferred */</span><br><span>     bool (*cli=
ent_pending_auth)(void *arg, const unsigned long cid, const unsigned int ki=
d,</span><br><span>                                 const char *extra, unsi=
gned int timeout);</span><br><span>     char *(*get_peer_info)(void *arg, c=
onst unsigned long cid);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool (*client_acc_msg)(void *arg,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                           const unsigned long cid,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
       const unsigned int mda_key_id,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                           struct buffer_list *msg);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool (*acc_msg)(void=
 *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       struct buffer_list *msg);</span><br><span>     bool (*proxy_cmd)(voi=
d *arg, const char **p);</span><br><span>     bool (*remote_cmd)(void *arg,=
 const char **p);</span><br><span> #ifdef TARGET_ANDROID</span><br><span>@@=
 -292,13 +299,15 @@</span><br><span>     struct command_line *in;</span><br=
><span>     struct buffer_list *out;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define IEC_UNDEF       0</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CLIENT_AUTH 1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define IEC_UNDEF          0</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_AUTH=
    1</span><br><span> /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_RSA_SIGN    =
3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CERTIFIC=
ATE 4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_PK_S=
IGN     5</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_=
PASSWORD    6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e IEC_RSA_SIGN       3</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define IEC_CERTIFICATE    4</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define IEC_PK_SIGN        5</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define IEC_PASSWORD       6</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_ACC_MSG 7</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define IEC_ACC_MSG        8</span><=
br><span>     int in_extra_cmd;</span><br><span>     struct buffer_list *in=
_extra;</span><br><span>     unsigned long in_extra_cid;</span><br><span>@@=
 -503,6 +512,14 @@</span><br><span> </span><br><span> void man_persist_clie=
nt_stats(struct management *man, struct context *c);</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Parses the ACC messa=
ge from the input buffer_list and send to the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * session identified by session and multi</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct tls_session;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct tls_multi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+management_send_acc_message(struct context *c, struct tl=
s_multi *multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                        struct tls_session *session, struct buffer_list *in=
put);</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span=
> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/multi=2Ec =
b/src/openvpn/multi=2Ec</span><br><span>index e302a81=2E=2E0ae503d 100644</=
span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvp=
n/multi=2Ec</span><br><span>@@ -53,6 +53,7 @@</span><br><span> #include &qu=
ot;ssl_util=2Eh&quot;</span><br><span> #include &quot;dco=2Eh&quot;</span><=
br><span> #include &quot;reflect_filter=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span>=
 </span><br><span> /*#define MULTI_DEBUG_EVENT_LOOP*/</span><br><span> </sp=
an><br><span>@@ -1735,8 +1736,9 @@</span><br><span>  * - peer id</span><br>=
<span>  */</span><br><span> static bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-multi_client_set_protocol_options(struct context *c)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_client_set_protoco=
l_options(struct multi_instance *mi)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi-&gt;c=
ontext;</span><br><span>     struct tls_multi *tls_multi =3D c-&gt;c2=2Etls=
_multi;</span><br><span>     const char *const peer_info =3D tls_multi-&gt;=
peer_info;</span><br><span>     struct options *o =3D &amp;c-&gt;options;</=
span><br><span>@@ -2380,7 +2382,7 @@</span><br><span>      * peer must be a=
dded before iroutes=2E For other platforms it doesn&#39;t matter=2E */</spa=
n><br><span> </span><br><span>     /* authentication complete, calculate dy=
namic client specific options */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!multi_client_set_protocol_options(&amp;mi-&gt;context))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi_clie=
nt_set_protocol_options(mi))</span><br><span>     {</span><br><span>       =
  mi-&gt;context=2Ec2=2Etls_multi-&gt;multi_state =3D CAS_FAILED;</span><br=
><span>     }</span><br><span>@@ -4085,6 +4087,26 @@</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static const char *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+calculate_app_control_extra(struct multi_instance *mi, st=
ruct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context =
*c =3D &amp;mi-&gt;context;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_protocols)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ACC: No negot=
iated protocols&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D al=
loc_buf_gc(1024, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&a=
mp;buf, &quot;ACC:%d A:6 %s&quot;, multi-&gt;acc_max_message_length,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+               multi-&gt;a=
cc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return buf_str(&amp;buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> sta=
tic bool</span><br><span> management_client_pending_auth(void *arg, const u=
nsigned long cid, const unsigned int mda_key_id,</span><br><span>          =
                      const char *extra, unsigned int timeout)</span><br><s=
pan>@@ -4095,10 +4117,22 @@</span><br><span>     if (mi)</span><br><span>  =
   {</span><br><span>         struct tls_multi *multi =3D mi-&gt;context=2E=
c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (!strcmp(extra, &quot;ACC&quot;))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            extra =3D calculate_app_control_extra(mi, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!e=
xtra)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span>         struct tls_session *session =3D lookup_ses=
sion_by_mda_key_id(multi, mda_key_id);</span><br><span> </span><br><span>  =
       if (!session)</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span> =
            return false;</span><br><span>         }</span><br><span> </spa=
n><br><span>@@ -4106,6 +4140,7 @@</span><br><span>         bool ret =3D sen=
d_auth_pending_messages(multi, session, extra, timeout);</span><br><span>  =
       reschedule_multi_process(&amp;mi-&gt;context);</span><br><span>     =
    multi_schedule_context_wakeup(m, mi);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span>         re=
turn ret;</span><br><span>     }</span><br><span>     return false;</span><=
br><span>@@ -4149,6 +4184,37 @@</span><br><span>     return ret;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_client_ac=
c_msg(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                       const unsigned long cid,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                          const unsigned int md=
a_key_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                struct buffer_list *input) /* ownership transferred */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D (struct m=
ulti_context *)arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct multi_instance *mi =3D lookup_by_cid(m, cid);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (mi &amp;&amp; buffer_list_defined(input))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *multi =3D m=
i-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct tls_session *session =3D lookup_session_by_mda_k=
ey_id(multi, mda_key_id);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (!session)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          msg(M_CLIENT, &quot;client session not found&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            buffer_list_free(inp=
ut);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret=
urn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        ret =3D management_send_acc_me=
ssage(&amp;mi-&gt;context, multi, session, input);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        multi_schedule_context_wakeup(m, mi)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buffer_list_free(input);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> static char *</span><br><span> management_get_peer_info(void *ar=
g, const unsigned long cid)</span><br><span> {</span><br><span>@@ -4185,6 +=
4251,7 @@</span><br><span>         cb=2En_clients =3D management_callback_n=
_clients;</span><br><span>         cb=2Ekill_by_cid =3D management_kill_by_=
cid;</span><br><span>         cb=2Eclient_auth =3D management_client_auth;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cb=2Eclient_=
acc_msg =3D management_client_acc_msg;</span><br><span>         cb=2Eclient=
_pending_auth =3D management_client_pending_auth;</span><br><span>         =
cb=2Eget_peer_info =3D management_get_peer_info;</span><br><span>         c=
b=2Epush_update_broadcast =3D management_callback_send_push_update_broadcas=
t;</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/optio=
ns=2Ec</span><br><span>index fb319ae=2E=2E04b553e 100644</span><br><span>--=
- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</=
span><br><span>@@ -35,6 +35,7 @@</span><br><span> </span><br><span> #includ=
e &quot;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #incl=
ude &quot;buffer=2Eh&quot;</span><br><span> #include &quot;error=2Eh&quot;<=
/span><br><span> #include &quot;common=2Eh&quot;</span><br><span>@@ -7107,6=
 +7108,41 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</sp=
an><br><span>         options-&gt;force_key_material_export =3D true;</span=
><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else if (streq(p[0], &quot;app-custom-control&quot;) &amp;&amp; p[1] &amp=
;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMI=
SSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        options-&gt;acc_protocols =3D p[1];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (streq(p[0], &quot;custom-control&quot;) &amp;&amp;=
 p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; !p[4])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ACC);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /* check if the list from the server is a real=
 subset of our list */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct buffer common_list =3D get_list_inte=
rsection(&amp;gc, p[3], options-&gt;acc_protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (buf_len(&amp;common_list) =3D=3D 0 || !streq(p[3=
], buf_cstr(&amp;common_list)))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(msglevel, &quot;App custom control list from server conta=
ins &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                 &quot;unsupported protocols&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!streq(p[2], &quot;A:6&quot;) &amp;&amp;=
 !streq(p[2], &quot;6:A&quot;))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(msglevel, &quot;App custom control encoding must be base6=
4 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constrain=
ed(p[1], &amp;options-&gt;pushed_acc_max_message_length,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                              &quot;ap=
p custom message message length&quot;, ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, ms=
glevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;pushed_ac=
c_negotiated_protocols =3D p[3];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;prng&quo=
t;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><spa=
n>         msg(M_WARN, &quot;NOTICE: --prng option ignored (SSL library PRN=
G is used)&quot;);</span><br><span>diff --git a/src/openvpn/options=2Eh b/s=
rc/openvpn/options=2Eh</span><br><span>index 6a3bf61=2E=2Eb7945e0 100644</s=
pan><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openv=
pn/options=2Eh</span><br><span>@@ -715,6 +715,18 @@</span><br><span>     /*=
 force using TLS key material export for data channel key generation */</sp=
an><br><span>     bool force_key_material_export;</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /** The app custom cont=
rol protocols we should announce as supported */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *acc_protocols;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /** the protocols that are negotiated with the pee=
r=2E This is a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
*  a temporary variable since options=2Ec push parser cannot access</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     *  tls multi struct */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *pus=
hed_acc_negotiated_protocols;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** t=
he maximum length of an ACC control channel message via push message</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int pushed_acc_max_message_lengt=
h;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
     bool vlan_tagging;</span><br><span>     enum vlan_acceptable_frames vl=
an_accept;</span><br><span>     uint16_t vlan_pvid;</span><br><span>@@ -764=
,8 +776,10 @@</span><br><span> #define OPT_P_INLINE          (1u &lt;&lt; 2=
9)</span><br><span> #define OPT_P_PUSH_MTU        (1u &lt;&lt; 30)</span><b=
r><span> #define OPT_P_ROUTE_TABLE     (1u &lt;&lt; 31)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_ACC             (1ull &lt=
;&lt; 32)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEE=
R_ID | 0x0ull))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* O=
ptions allowed in the normal configuration file (vs pushed options or in cc=
d files) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_A=
CC))</span><br><span> </span><br><span> #define PULL_DEFINED(opt) ((opt)-&g=
t;pull)</span><br><span> </span><br><span>diff --git a/src/openvpn/push=2Ec=
 b/src/openvpn/push=2Ec</span><br><span>index 42259c3=2E=2E320f89d 100644</=
span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn=
/push=2Ec</span><br><span>@@ -27,6 +27,8 @@</span><br><span> #include &quot=
;syshead=2Eh&quot;</span><br><span> </span><br><span> #include &quot;push=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;=
</span><br><span> #include &quot;options=2Eh&quot;</span><br><span> #includ=
e &quot;crypto=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</spa=
n><br><span>@@ -221,9 +223,58 @@</span><br><span> #endif</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_ser=
ver_pushed_info_acc(struct context *c, struct buffer *buf)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int max_acc_len =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_=
multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;opt=2Eacc_pro=
tocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS,=
 &quot;Server tried to push app custom control list&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                           &quot;with=
out client announcing support for it&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* examp=
le string to parse: ACC:1400 A:6 flower:happy */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* Skip over the ACC: prefix */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(buf, 4);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    char *protocols =3D par=
se_acc_parameters(buf_cstr(buf), &quot; &quot;, &amp;max_acc_len, false, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* check if the list from t=
he server is a real subset of our list */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer common_list =3D get_list_intersecti=
on(&amp;gc, protocols, multi-&gt;opt=2Eacc_protocols);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (buf_len(&amp;common_list) =3D=3D 0 || !streq(protoc=
ols, buf_cstr(&amp;common_list)))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(D_PUSH_ERRORS, &quot;App custom control list from server contai=
ns &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                 &quot;unsupported protocols&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mu=
lti-&gt;acc_negotiated_protocols =3D string_alloc(protocols, &amp;c-&gt;opt=
ions=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
multi-&gt;acc_max_message_length =3D max_acc_len;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (management)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(M_CLIENT, &quot;&gt;ACC_PROTOCOLS:protocols=3D%s,=
message_len=3D%d&quot;, protocols, max_acc_len);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;=
WARNING: Received ACC info command with invalid parameters&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-server_pushed_info(co=
nst struct buffer *buffer, const int adv)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+server_pushed_info(struct context *c, const struct bu=
ffer *buffer, const int adv)</span><br><span> {</span><br><span>     const =
char *m =3D &quot;&quot;;</span><br><span>     struct buffer buf =3D *buffe=
r;</span><br><span>@@ -233,6 +284,12 @@</span><br><span>         m =3D BSTR=
(&amp;buf);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (strncmp(m, &quot;ACC:&quot;, 4) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        parse_server_pus=
hed_info_acc(c, &amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> #ifdef ENABLE_MANAGEMENT</span><br><span>     struct gc_arena gc;</s=
pan><br><span>     if (management)</span><br><span>@@ -285,6 +342,7 @@</spa=
n><br><span>     msg(D_PUSH, &quot;CR response was sent by client (&#39;%s&=
#39;)&quot;, m);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 Parse the keyword for the AUTH_PENDING request</span><br><span>  * @param =
buffer                buffer containing the keywords, the buffer&#39;s</spa=
n><br><span>@@ -441,7 +499,6 @@</span><br><span>     const char *const peer=
_info =3D tls_multi-&gt;peer_info;</span><br><span>     unsigned int proto =
=3D extract_iv_proto(peer_info);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Calculate the maximum=
 timeout and subtract the time we already waited */</span><br><span>     un=
signed int max_timeout =3D</span><br><span>         max_uint(tls_multi-&gt;=
opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2Ehandshake_window);</span=
><br><span>@@ -732,6 +789,12 @@</span><br><span>                 client_max=
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
pn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 086a6fc=2E=2Ee84d32d=
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
><br><span>@@ -2117,6 +2119,11 @@</span><br><span>                     }</s=
pan><br><span>                 }</span><br><span>             }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (session-&gt;opt-&gt;acc_protocols)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_print=
f(&amp;out, &quot;IV_ACC=3D%d,6:A,%s\n&quot;, ACC_MAX_MSG_LEN, session-&gt;=
opt-&gt;acc_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span>         }</span><br><span>     }</span><=
br><span> </span><br><span>@@ -2398,6 +2405,8 @@</span><br><span>         m=
ulti-&gt;remote_ciphername =3D string_alloc(&quot;none&quot;, NULL);</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    determine_common_acc_protocols(multi, session);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (us=
ername_len &lt; 0 || password_len &lt; 0)</span><br><span>     {</span><br>=
<span>         msg(D_TLS_ERRORS, &quot;TLS Error: Username (%d) or password=
 (%d) too long&quot;, abs(username_len),</span><br><span>diff --git a/src/o=
penvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index 9a=
55ead=2E=2E436770b 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh<=
/span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -457,6 =
+457,9 @@</span><br><span>     size_t ekm_size;</span><br><span> </span><br=
><span>     bool dco_enabled; /**&lt; Whether keys have to be installed in =
DCO or not */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** The app custom co=
ntrol protocols we should announce as supported */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *acc_protocols;</span><br><sp=
an> };</span><br><span> </span><br><span> /** @addtogroup control_processor=
</span><br><span>@@ -730,6 +733,12 @@</span><br><span>     int dco_peer_id;=
</span><br><span> </span><br><span>     dco_context_t *dco;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /** the protocols that are negotiated with the pee=
r=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ac=
c_negotiated_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the max=
imum length of an ACC control channel message */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int acc_max_message_length;</span><br><spa=
n> };</span><br><span> </span><br><span> /**  gets an item  of \c key_state=
 objects in the</span><br><span>diff --git a/tests/unit_tests/openvpn/Makef=
ile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 43a=
6743=2E=2E86326af 100644</span><br><span>--- a/tests/unit_tests/openvpn/Mak=
efile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</sp=
an><br><span>@@ -107,10 +107,12 @@</span><br><span> 	@TEST_CFLAGS@</span><b=
r><span> ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)=
</span><br><span> ssl_testdriver_SOURCES =3D test_ssl=2Ec \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	test_acc=2Ec test_acc=2Eh \</span>=
<br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	m=
ock_management=2Ec \</span><br><span> 	mock_ssl_dependencies=2Ec mock_win32=
_execve=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/sr=
c/openvpn/acc=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	=
$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -132,6 +134,7 @@<=
/span><br><span> 	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/ssl_mbedtls=2Ec \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \</span><br><span> 	=
$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span> 	$(top_srcdir)/sr=
c/openvpn/ssl_verify_mbedtls=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/ssl_verify_openssl=2Ec \</span><br><span>@@ -392,9 +395,11 @@</span><br=
><span> </span><br><span> misc_testdriver_SOURCES =3D test_misc=2Ec \</span=
><br><span> 	test_schedule=2Ec test_schedule=2Eh \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	mock_management=2Ec mock_management=2Eh \</=
span><br><span> 	mock_msg=2Ec test_common=2Eh  \</span><br><span> 	mock_get=
_random=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/sr=
c/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/options_util=2Ec \</span=
><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span>@@ -4=
07,6 +412,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/siphash_referenc=
e=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/session_id=2Ec</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \=
</span><br><span> 	-I$(top_srcdir)/src/compat \</span><br><span> 	-I$(top_s=
rcdir)/tests/unit_tests/openvpn \</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_management=
=2Ec</span><br><span>index fff4c2b=2E=2Ef572dbb 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/mock_management=2Ec</span><br><span>@@ -29,6 +29,7 @@</s=
pan><br><span> </span><br><span> #include &quot;syshead=2Eh&quot;</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;stdlib=2Eh&gt;</span><br><span> #include &quot;manage=2Eh&quot;</span><br=
><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/mock_management=2Eh b/tests/unit_tests/openvp=
n/mock_management=2Eh</span><br><span>new file mode 100644</span><br><span>=
index 0000000=2E=2E80dcfc2</span><br><span>--- /dev/null</span><br><span>++=
+ b/tests/unit_tests/openvpn/mock_management=2Eh</span><br><span>@@ -0,0 +1=
,29 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application =
to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             over a single UDP port, with support for SSL/TLS-=
based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 session authentication and key exchange,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             packet encryption, packet authenticati=
on, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrigh=
t (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  This program is free software; you can redistribute =
it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 it under the terms of the GNU General Public License version 2</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free So=
ftware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program=
 is distributed in the hope that it will be useful,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publi=
c License for more details=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You=
 should have received a copy of the GNU General Public License along</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifndef MOCK_MANAGEMENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define MOCK_MANAGEMENT_H</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void init_mock_management(void);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void uninit_mock_management(void);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_push_dep=
endencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><=
br><span>index bf2ccf3=2E=2Ef083f89 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>+++ b/tests/unit_=
tests/openvpn/mock_push_dependencies=2Ec</span><br><span>@@ -43,7 +43,8 @@<=
/span><br><span>     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT=
_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span>                      | OPT_P_=
SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br>=
<span>                      | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_=
P_ECHO | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_=
P_ROUTE | OPT_P_DHCPDNS;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OP=
T_P_ROUTE | OPT_P_DHCPDNS</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                     | OPT_P_ACC;</span><br><span>     return flags;<=
/span><br><span> }</span><br><span> </span><br><span>diff --git a/tests/uni=
t_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec</span>=
<br><span>new file mode 100644</span><br><span>index 0000000=2E=2E577e34e</=
span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn=
/test_acc=2Ec</span><br><span>@@ -0,0 +1,334 @@</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a s=
ingle TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             session authentication and ke=
y exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
       packet encryption, packet authentication, and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sa=
les@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  This program is free software; you can redistribute it and/o=
r modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it unde=
r the terms of the GNU General Public License version 2</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software F=
oundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is dist=
ributed in the hope that it will be useful,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the impl=
ied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License =
for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should ha=
ve received a copy of the GNU General Public License along</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write=
 to the Free Software Foundation, Inc=2E,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110=
-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_acc=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
mock_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char cont=
rol_channel_mesage_sent[2048];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Mock =
functions */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_s=
tring_dowork(struct tls_session *session,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                   const char *str, u=
nsigned int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_i=
n_range(strlen(str), 0, 2048);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memc=
py(control_channel_mesage_sent, str, strlen(str));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+send_push_reply_auth_tok=
en(struct tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+auth_set_client_reason(struct tls_multi *multi, const char *re=
ason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define MSG_PAYLOAD &quot;FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM&quo=
t;                \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    &quot;r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d=
60nTS&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              &quot;4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP&=
quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        &quot;AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH&quot; =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  &quot;QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc&quot; \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quo=
t;ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA&quot; \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;AUEA=
wQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ&quot; \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    &quot;93rQwityP9=
eKSijXgcQ=3D=3D&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+test_acc_parse_client_messages(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_MANAGEMENT=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    skip();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* ensure that the messages get to mo=
ck_msg */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    x_debu=
g_level =3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
anagement =3D (void *)0x12345678;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* contains a TLS 1=2E3 ClientHello */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char msg[] =3D &quot;ACC,cck1,=
384,6,&quot; MSG_PAYLOAD;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer msg_buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct context c =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    c=2Eoptions=2Emode =3D MODE_SERVER;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[T=
M_ACTIVE]=2Eopt =3D &amp;c=2Ec2=2Etls_multi-&gt;opt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACT=
IVE]=2Eopt-&gt;mda_context =3D &amp;c=2Ec2=2Emda_context;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void =
*)msg, sizeof(msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_string_equal(mock_msg_buf, &quot;Received custom app co=
ntrol message (protocol &#39;cck1&#39;)&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &qu=
ot;&gt;CLIENT:ACC,0,0,cck1,0,&quot; MSG_PAYLOAD);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char flower_msg[] =3D &quot;ACC,flower,48,6,SSBhbSAAIE=
tlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower=
_msg, sizeof(flower_msg));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &qu=
ot;Received custom app control message (protocol &#39;flower&#39;)&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_eq=
ual(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pd=
CD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    CLEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char msg_incorrect_len[] =3D &quot;ACC,fortune,62=
,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=3D&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read=
(&amp;msg_buf, (void *)msg_incorrect_len, sizeof(msg_incorrect_len));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&=
amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *error =3D &quot;WARNING: Received malformed custom app co=
ntrol channel &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        &quot;(field length 62, payload length 64 mismatch=
) message &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     &quot;control message: 496e7367 496d316c 496a6f67 496d=
5a79 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                &quot;62326369 4c434141 65475a6d 2f534a7[more=2E=2E=2E]&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_bu=
f, error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_string_equal(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char msg_fragment[] =3D &quot;ACC,power,12,=
6F,aGVsbG8gdw=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    buf_set_read(&amp;msg_buf, (void *)msg_fragment, sizeof(msg_frag=
ment));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_=
acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Received custom =
app control message (protocol &#39;power&#39;, fragment)&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_m=
anagment_buf, &quot;&gt;CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* check two encoding pres=
ent */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r flower_msg_two_encs[] =3D &quot;ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0=
aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg_two_encs,=
 sizeof(flower_msg_two_encs));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    error =3D &quot;WARNING: Received malformed custom a=
pp control channel (number of &quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &quot;encodings must be exactly one (B64=3D1, =
ASCII=3D1)) message control &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &quot;message: 53534268 62534141 4945746c 636d31=
70 6443442f 2f534230 &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            &quot;61475567 37372b3[more=2E=2E=2E]&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_m=
sg_buf, error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_string_equal(mock_managment_buf, &quot;&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* no encoding present */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char flower_msg_no_encs[] =3D &quot;ACC=
,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;m=
sg_buf, (void *)flower_msg_no_encs, sizeof(flower_msg_no_encs));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c=
, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot;WA=
RNING: Received malformed custom app control channel (number of &quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;encodi=
ngs must be exactly one (B64=3D0, ASCII=3D0)) message control &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;message:=
 53534268 62534141 4945746c 636d3170 6443442f 2f534230 &quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            &quot;61475567 37372b=
3[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_string_equal(mock_msg_buf, error);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &=
quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    x_debug_level =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    management =3D N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tes=
t_parse_acc_parameters(void **state)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* parameters to INFO message */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *info_acc_msg =3D &quot;40=
96 A:6 flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_=
len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 char *protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp=
;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_le=
n, 1280);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* a client does not acce=
pt a length longer than it supports */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &qu=
ot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* message with lower limit than our, should work for clien=
t and server */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
info_acc_msg =3D &quot;1111 A:6 flower:happy&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(in=
fo_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &q=
uot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(max_len, 1111);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp=
;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_le=
n, 1111);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* more encodings than su=
pported=2E Server should be okay, client should fail */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1200 A:6:B f=
lower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max=
_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prot=
ocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, t=
rue, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_string_equal(protocols, &quot;flower:happy&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1200);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* extra parameter */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1400 A:=
6 flower:happy 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &a=
mp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_null(protocols);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_l=
en, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc_capabi=
lities =3D &quot;1400,A:6,flower:happy:power&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(iv=
_acc_capabilities, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protoco=
ls, &quot;flower:happy:power&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* too small protocol length */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    info_acc_msg =3D &quot;32 A:6 flower:happy&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc=
_parameters(info_acc_msg, &quot;,&quot;, &amp;max_len, true, &amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocol=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* non-numerical protocol lengt=
h */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_ms=
g =3D &quot;abff A:6 flower:happy 77&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg=
, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* non-numerical protocol length */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;abff A:6 flo=
wer:happy 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    protocols =3D parse_acc_parameters(info_acc_msg, &quot;,&quot;, &amp;ma=
x_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_acc_common_protocols(void **state)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct multi_instance mi =3D { 0 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi=
=2Econtext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&g=
t;options=2Egc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_=
OBJ_CLEAR_GC(c-&gt;c2=2Etls_multi, struct tls_multi, &amp;c-&gt;options=2Eg=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;peer_i=
nfo =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2E=
acc_protocols =3D &quot;power:flower:star&quot;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls=
_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&g=
t;opt=2Eacc_protocols =3D c-&gt;options=2Eacc_protocols;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    determine_common_acc_protocols(multi, &amp;c-&gt;c2=
=2Etls_multi-&gt;session[TM_ACTIVE]);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(multi-&gt;acc_max_message_length, ACC_MAX_MSG_LEN);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal=
(multi-&gt;acc_negotiated_protocols, &quot;power:flower&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt;options=2Egc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_acc_=
send_message(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
multi_instance mi =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct context *c =3D &amp;mi=2Econtext;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Egc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c-&gt;c2=2Etls_mul=
ti, struct tls_multi, &amp;c-&gt;options=2Egc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    bool ret;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=
=2Eacc_protocols =3D &quot;power:flower:emergency&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Eacc_protocols =3D =
c-&gt;options=2Eacc_protocols;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&g=
t;peer_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:p=
ower&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dete=
rmine_common_acc_protocols(multi, &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_=
ACTIVE]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct tls_session *session =3D &amp;c-&gt;c=
2=2Etls_multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;emergen=
cy&quot;, true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                       &quot;EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DR=
ILL:&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string=
_equal(control_channel_mesage_sent,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        &quot;ACC,emergency,50,AF,EMERGENCY=
 BROADCAST MESSAGE - THIS IS NOT A DRILL:&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &=
quot;emergency&quot;, false,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                           &quot;THE GOVERNMENT HAS ISSUED A RAINB=
OW COLOURED ALERT FOR YOUR AREA=2E&quot;, false);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(ret);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(control_channel_m=
esage_sent,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                &quot;ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBO=
W COLOURED ALERT FOR YOUR AREA=2E&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* test a lo=
ng message (&gt; 1000) with fragment to get the maximum header size */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    char long_message[12=
00] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i =
&lt; 1024; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        long_messa=
ge[i] =3D (char)(&#39; &#39; + (i % 95));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* last=
 char of the message is a i and then a \0 */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(long_message[1023], &#39;i&#3=
9;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(long_message[1024], &#39;\0&#39;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;emer=
gency&quot;, true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                          long_message, false);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(ret);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    size_t cc_len =3D strlen(control_channel_mesage_sent);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(cont=
rol_channel_mesage_sent[cc_len - 1], &#39;i&#39;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *expected_start_cc =3D &quot;=
ACC,emergency,1024,AF, !\&quot;#$%&amp;&#39;()*+,-=2E/012345&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(con=
trol_channel_mesage_sent, expected_start_cc, sizeof(expected_start_cc));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt;options=2Egc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_list_intersection(void **state)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const char *empty =3D &quot;&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *protos =3D &quot;power:flower:emergency&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t1 =3D get_list_=
intersection(&amp;gc, empty, protos);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(buf_len(&amp;t1), 0);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer t2 =3D get_list_intersection(&amp;g=
c, protos, empty);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(buf_len(&amp;t2), 0);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer t3 =3D get_list_intersection(&amp;gc, protos, protos);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(buf_cstr(&amp;t3), protos);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *protos2 =3D &quot;flower:emergency:power:mario&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t4 =3D get_li=
st_intersection(&amp;gc, protos2, protos);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t4), &quot;flo=
wer:emergency:power&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *protos3 =3D &quot;super:paper:mario:flower&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer t5 =3D get_list_inters=
ection(&amp;gc, protos2, protos3);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t5), &quot;flower:mari=
o&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_a=
cc=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E32421fb</span><br><span>--- /dev/null</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_acc=2Eh</span><br><span>@@ -0,0 +1,35 @@</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel I=
P networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      over a single UDP port, with support for SSL/TLS-based</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *             session authenticat=
ion and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             packet encryption, packet authentication, and</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             packet compressio=
n=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 Open=
VPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is free software; you can redistribute it and/or modify</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms =
of the GNU General Public License version 2</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in t=
he hope that it will be useful,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty=
 of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABIL=
ITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more d=
etails=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have receive=
d a copy of the GNU General Public License along</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:/=
/www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_ACC_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define TEST_ACC_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void test_acc_parse_client_messages(void =
**state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void test_parse_acc_parameter=
s(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_common_p=
rotocols(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_s=
end_message(void **state);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_li=
st_intersection(void **state);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_tests/openvpn/tes=
t_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>ind=
ex 8db4ea6=2E=2Ec865142 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/test_common=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/test_comm=
on=2Eh</span><br><span>@@ -43,11 +43,13 @@</span><br><span> #define Largest=
IntegralType uintmax_t</span><br><span> #endif</span><br><span> /* redefine=
 2=2Ex API in terms of 1=2Ex API */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define CMockaValueData             LargestIntegralType</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define check_expected_uint=
         check_expected</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define expect_uint_value           expect_value</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define expect_check_data           expect_che=
ck</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define cast_ptr_to=
_cmocka_value(x) (x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define CMockaValueData                       LargestIntegralType</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define check_expected_uint =
                  check_expected</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define expect_uint_value                     expect_value</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define expect_check_da=
ta                     expect_check</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define cast_ptr_to_cmocka_value(x)           (x)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define assert_int_in_range(v=
alue, min, max)  assert_in_range((value), (min), (max))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define assert_uint_in_range(value, min=
, max) assert_in_range((value), (min), (max))</span><br><span> #endif</span=
><br><span> </span><br><span> /**</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><=
br><span>index aea40f0=2E=2E7405198 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn=
/test_misc=2Ec</span><br><span>@@ -41,10 +41,34 @@</span><br><span> #includ=
e &quot;mock_msg=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;=
</span><br><span> #include &quot;sid_hash=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_schedule=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> #ifdef _WIN32</span><br><span> #include &quot;win32-util=2Eh&quot;=
</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#include &quot;test_schedule=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* extra mocks */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+apply_push_opt=
ions(struct context *c, struct options *options, struct buffer *buf,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                   uint64_=
t permission_mask, uint64_t *option_types_found,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                   struct env_set *es, bool is=
_update)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_cont=
rol_channel_string(struct context *c, const char *str, msglvl_t msglevel)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    check_expected_ptr(str);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+struct multi_instance *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+lookup_by_cid(struct multi_context *m, const unsigned long cid)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return *(m-&gt;instances);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br=
><span> static void</span><br><span> test_compat_lzo_string(void **state)</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/u=
nit_tests/openvpn/test_ssl=2Ec</span><br><span>index 4baf8cc=2E=2E4987dd0 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br=
><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -52,6=
 +52,8 @@</span><br><span> #include &quot;ssl_verify=2Eh&quot;</span><br><s=
pan> #include &quot;openvpn=2Eh&quot;</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Mock=
 function to be allowed to include win32=2Ec which is required for</span><b=
r><span>  * getting the temp directory */</span><br><span> #ifdef _WIN32</s=
pan><br><span>@@ -86,6 +88,20 @@</span><br><span> {</span><br><span>     re=
turn;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reschedule=
_multi_process(struct context *c)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
"> Gerrit-PatchSet: 14 </div>
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
t-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</bo=
dy></html>
--MoJAN2gCbRo=--


--===============1102980919464865923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1102980919464865923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1102980919464865923==--

