Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF895606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l6jz/1s/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HfTqKnmw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ep4L+H+4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RoJo+qe5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CY7QmOWCH1XaC9ZTxqPbxzSHGiYo9y/Mvxz07cqd+RI=; b=l6jz/1s/uViwDv0qmL9jAElLVE
	fRuZZ3hm1aem/fkhPS5/Z/82owurCEIu0I0UJakUF1orsg1F+Kuz8FjVV0PODMcoBD/QuTO1sOMEF
	3i8I0vENfDKNbB+ckcivJtCFY6bIQ9nCWPJ3fKWh6lqeSTwSzxDUm4Nvs74DpaOqPvRk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM5Ij-000000000Ip-2kBK;
	Wed, 28 Oct 2026 15:10:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM5Ii-000000000Ig-2AFX
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:10:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dkYzI13Q5SFB+jYBTZoMV2/T6VVEvRGgswNpozLHmYU=; b=HfTqKnmwnplHWm2ynlxybOh/jG
 wp2McR428o8r/PJ4bZ2Ze2pYxqZBek4nUtMqYp2emGQC4hZYLsbHu5pYFRTNijhvbBFoZfkLii6sk
 ff8MO2Bi1brs/C3D2YpvFul/FYhZmQGyjd83BlbDzYvNPCUFr0cLZn5Ueh3jUHrpbFyA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dkYzI13Q5SFB+jYBTZoMV2/T6VVEvRGgswNpozLHmYU=; b=Ep4L+H+4eAntp8LirYtVF3tZZk
 SUY5enU5H1nZns/Wimf7IoiB6ncdwd8e3yulYcJfUtnrGa56z0hkiNhhmoBDcNwDZ2iqWRD+F4/XU
 GI8j//z/HdkJ4l9loiGHtKDpHvRZOoM+G1R6NaFPNHZW4Dk+aaYCU3hgmnIPpZbvaaDc=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5Ib-000000002N1-3O7r for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:10:52 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so512114f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793200239; x=1793805039; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dkYzI13Q5SFB+jYBTZoMV2/T6VVEvRGgswNpozLHmYU=;
 b=RoJo+qe5Jrg/7D+Sb56EtK8nM5TIdnw5V8e4fYkKr+aEEFKcLXurpZcu8J2u4xY3qC
 OFgGfb1jOU0C/gWU5MlSPG0iHuS72CiQjm9bQw6jZlaLWGg5s5stLTyRJukMsojrADP+
 LraCdfnQQTjo/Im3TQJEfZ4qt+rW8Ctzlc+/c9jX0+Je5OX0ZizVVA80mo5mu7eVhgyY
 xESzuMM//EvdIKJqBe51bqMnoW3ZkTJZtUovmm6kBIHnAeqrglz+rOpigr5BhaMl9o9U
 VWNMI4ujCWrBMOfzZdF74AS/StKNbpLmEeIbEpizIAwtrxgq0Z7ao1K674m4bzZV6Jqx
 kL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793200239; x=1793805039;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dkYzI13Q5SFB+jYBTZoMV2/T6VVEvRGgswNpozLHmYU=;
 b=cN8IewY8bY/6lx8MgaUqAFkxvifaSgh8iGNnzte/chBzNQff1Qwf+4dhqoowW5uT2P
 Es6TCYt2SAgnO9yXZLB/hZBVUeW0+hnKLXnulVofCdCLIzV45PTJOjIXb5FT7+dBT6GX
 6uu8IqkzwrobwwI/pFz5NsDbuK8ljL+a04qEzz5OANo02xni5idywo4/lQMXhwPdK+vD
 OIiTXVUoPMyeMJDUI3k9Mq0TPoAnP31MXtbMrESMC06rB1ZcxnyxDy+fg4FTG1fVPSnU
 h7MMrXCV0fruwQwFuA8IU6Q2Ecc7NAhXUcGaAAeDrAJzoc4zB1FYhFE8pu5ESHhvMWez
 86sA==
X-Gm-Message-State: AFq9FYKmYiWeqT6P+l+D2396b85n/SViDxWcjAALRlDstrN6NdmMMD/U
 n1Ikgce98YD2z/6KrqI7/g3jItvT8pc19EyMYRL3vqac+3PU4LQaAnJAQcMeRXEoVe46esOK4iv
 /bw0cYHBDN/MeKJLcxRfEyMPRrO96YEMHN9np6EJjcIG51Mt5HIIoGWGWOWCj7w33DV3Kmv/XQx
 nlulk7ig==
X-Gm-Gg: AYBFou0D1eUoHtxOdXzxFAZmN406xjF2IdoOGKUwITvQToLF3BQ+uoV1gElV5bctFgQ
 r1o4IQq/CRwD5kHCDKCsbWFjChvhihyf7GV7FK63+geAkryDcQRc605zhGUTvX1pwJiHOZ3P+Sw
 eg7KMT1FMEzuJZbA6MAKVXC0Ifr3cOk51u0ofvvtPEsWM8OtrNYgn7gKjZ0qMKIIC6K2u9xHRT8
 MWVUcoZAsy2l7L8Wl38WKUkTC5PUEU84+D6QkfKN+E/Ole2ysFCeN48scsGiz+52Sg9oe2Hz/R7
 fYhmhC6+ltLEAPiSfQxF0sWqIEiSNt8Of7fNVMFk2+/73+ZFG5xmqrttKl85PX5aC9WWsmHM5Ti
 z/hzCBITZC+wL/mzAP7diYhtZpfqDSla1eLiLRid/SsZCCj+IflAzwhVz1dzLiepLvJqFz/Ywkw
 Psr11IpOyVKxTPdmbsSSCCAwpnOgjC/OUldOQiP8t6YkDPjYkJn41IrML3cYTPSFBKIujWrCJN6
 LZEbvJdkKCIZPnbywRszRj1hv1rEEYroGaDDfW7SwMvQZxq6O5/aK8Jcnraa/hVMGPY13r+KUix
 4pHxk3MOI5N98BM/iLDfT+kJWhLdLMMZQbu+HEo/epGc3GMhDFcIsjHpe/3JKaE/JVnShn1lyFf
 RdWxka09ZuWHOVxu9/nPmPkrvk3Krjun+6iljGxjrCRmIaa0PMnvIHbJkpzu/EM/Mr084a5RjqW
 JJK8EyzCGj1nLz3Cpn
X-Received: by 2002:a05:6000:716:b0:48b:a21:87f7 with SMTP id
 ffacd0b85a97d-48e5d5c9c95mr6197975f8f.44.1793200238068; 
 Wed, 28 Oct 2026 08:10:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb902sm30497499f8f.24.2026.10.28.08.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:10:37 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 15:10:35 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 6d76e0240a1bd038517b7ab46985ba49291a4f91
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6b067179e33373a28a13c483832243f40dd2e1d0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5Ib-000000002N1-3O7r
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
Content-Type: multipart/mixed; boundary="===============2380464604840727021=="
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2380464604840727021==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="491SNW7Wz00="; charset=UTF-8

--491SNW7Wz00=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1858?usp=3Demail

to look at the new patch set (#18)=2E

The following=
 approvals got outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojo=
caru


Change subject: Implement sending/receiving app custom control proto=
col messages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Implement sending/receiving app custom control protocol messages

This al=
lows openvpn GUI/front-ends and server via management
to use the OpenVPN co=
ntrol channel to pass messages between each other
while OpenVPN handles the=
 marshalling/unmarshalling of these and
negotiate the common app custom con=
trol protocols=2E

This provides an easy to use secure channel that does no=
t depend on
the network itself to work and can also used before fully authe=
nticating
the client=2E See the management-notes=2Etxt for more details how=
 to use
this feature=2E An upcoming patch will also add some example python=

script that showcase this feature=2E

Change-Id: I4a6a6ef41e15896b8b79d795=
b2a6de86b8ae4c84
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMa=
keLists=2Etxt
M doc/man-sections/client-options=2Erst
M doc/man-sections/ma=
nagement-options=2Erst
M doc/man-sections/script-options=2Erst
M doc/manage=
ment-notes=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/acc=2Ec
A src/op=
envpn/acc=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/init=2Ec
M src/openvp=
n/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/multi=2Ec
M src/openvpn=
/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/push=2Ec
M src/openvpn=
/push=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M tests/unit_t=
ests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/mock_management=2Ec
M=
 tests/unit_tests/openvpn/mock_push_dependencies=2Ec
A tests/unit_tests/ope=
nvpn/test_acc=2Ec
A tests/unit_tests/openvpn/test_acc=2Eh
M tests/unit_test=
s/openvpn/test_common=2Eh
M tests/unit_tests/openvpn/test_ssl=2Ec
26 files =
changed, 1,515 insertions(+), 23 deletions(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/58/1858/18

diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt
index 184a95a=2E=2E13bd1f0 100644
--- a/CMakeList=
s=2Etxt
+++ b/CMakeLists=2Etxt
@@ -435,6 +435,8 @@
     src/compat/compat-s=
trlcpy=2Ec
     src/compat/compat-strsep=2Ec
     src/compat/compat-strtok_=
r=2Ec
+    src/openvpn/acc=2Ec
+    src/openvpn/acc=2Eh
     src/openvpn/ar=
gv=2Ec
     src/openvpn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -571,8 +573=
,8 @@
     src/openvpn/ps=2Ec
     src/openvpn/ps=2Eh
     src/openvpn/push=
=2Ec
-    src/openvpn/push_util=2Ec
     src/openvpn/push=2Eh
+    src/open=
vpn/push_util=2Ec
     src/openvpn/pushlist=2Eh
     src/openvpn/reflect_fi=
lter=2Ec
     src/openvpn/reflect_filter=2Eh
@@ -826,7 +828,10 @@
         =
    tests/unit_tests/openvpn/mock_management=2Ec
             tests/unit_te=
sts/openvpn/mock_ssl_dependencies=2Ec
             tests/unit_tests/openvpn=
/mock_win32_execve=2Ec
+            tests/unit_tests/openvpn/test_acc=2Ec
+=
            src/openvpn/acc=2Ec
             src/openvpn/argv=2Ec
+        =
    src/openvpn/auth_token=2Ec
             src/openvpn/base64=2Ec
        =
     src/openvpn/crypto_epoch=2Ec
             src/openvpn/crypto_mbedtls=
=2Ec
@@ -840,8 +845,11 @@
             src/openvpn/options_util=2Ec
       =
      src/openvpn/otime=2Ec
             src/openvpn/packet_id=2Ec
+       =
     src/openvpn/reliable=2Ec
+            src/openvpn/session_id=2Ec
     =
        src/openvpn/run_command=2Ec
             src/openvpn/ssl_mbedtls=2E=
c
+            src/openvpn/ssl_ncp=2Ec
             src/openvpn/ssl_openssl=
=2Ec
             src/openvpn/ssl_util=2Ec
             src/openvpn/ssl_ver=
ify_mbedtls=2Ec
diff --git a/doc/man-sections/client-options=2Erst b/doc/ma=
n-sections/client-options=2Erst
index 87c138a=2E=2Eb204d6a 100644
--- a/doc=
/man-sections/client-options=2Erst
+++ b/doc/man-sections/client-options=2E=
rst
@@ -12,6 +12,17 @@
   When this option is set, OpenVPN will not drop in=
coming tun packets with
   same destination as host=2E
 
+--app-custom-cont=
rol protocollist
+  Sets the list of supported app custom control protocols=
=2E
+  These protocols are announced to the server when this option is used=

+  as a client=2E If the option is set on a server it will negotiate the
+=
  common protocols with the client=2E
+
+  The protocollist is a : separate=
d list of protocol identifiers=2E
+
+  See management-notes=2Etxt in the Op=
enVPN distribution and the OpenVPN RFC
+  draft for a description of app cu=
stom control protocol support=2E
+
 --auth-token token
   This is not an op=
tion to be used directly in any configuration files,
   but rather push thi=
s option from a ``--client-connect`` script or a
@@ -437,6 +448,12 @@
     =
    Additional authentication methods supported by the client=2E
         T=
his may be set by the client UI/GUI using ``--setenv``=2E
 
+  :code:`IV_AC=
C=3D<max_msg_len>,<flags>,<protocols>`
+        If the option ``--app-custo=
m-control`` is set, the client will
+        send the supported max ACC mes=
sage length, the supported formats
+        as (:code:`A:6`) and the list o=
f configured protocols (e=2Eg=2E
+        :code:`flower:happy:power`)
+
   =
The following flags depend on which compression formats are compiled in
   =
and whether compression is allowed by options=2E See `Protocol options`_
  =
 for more details=2E
diff --git a/doc/man-sections/management-options=2Erst=
 b/doc/man-sections/management-options=2Erst
index 2c79d05=2E=2Ea7f7ead 100=
644
--- a/doc/man-sections/management-options=2Erst
+++ b/doc/man-sections/=
management-options=2Erst
@@ -144,3 +144,9 @@
 
 --management-up-down
   Rep=
ort tunnel up/down events to management interface=2E
+
+--app-custom-contro=
l protocol-list
+  Sets the app custom control protocols that are supported=
 and should be
+  negotiated=2E protocol-list is a list of allowed protocol=
s separated by :
+  A client will announce these protocols via the IV_ACC v=
ariable and the
+  server will notify the client about the common protocols=
=2E
diff --git a/doc/man-sections/script-options=2Erst b/doc/man-sections/s=
cript-options=2Erst
index f420380f=2E=2E9c17c3b 100644
--- a/doc/man-sectio=
ns/script-options=2Erst
+++ b/doc/man-sections/script-options=2Erst
@@ -100=
6,3 +1006,12 @@
        X509_1_L=3DBISHKEK
        X509_1_ST=3DNA
        X=
509_1_C=3DKG
+
+:code:`acc_protocols`
+    If ``--app-custom-control`` is c=
onfigured and the client supports any of the
+    protocols that server als=
o supports, this variable contains a list of
+    common protocols separate=
d by :=2E
+
+:code:`acc_message_len`
+    if :code:`acc_protocols` is set, =
this variable contains the maximum
+    message length for app custom proto=
col message=2E
\ No newline at end of file
diff --git a/doc/management-note=
s=2Etxt b/doc/management-notes=2Etxt
index 4d726c4=2E=2Ec255d1d 100644
--- =
a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -828,6 +82=
8,58 @@
 that is required to continue the connection (unlike MFA or opening=
 a browser)
 this message is not negotiated but can just be sent as a gratu=
itous message=2E
 
+app custom control
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+If the special string "ACC" is passed as {EXTRA} Ope=
nVPN will determine
+the common app custom protocols between the client and=
 the server and instruct
+the client that the server will send control mess=
ages to the client using
+the ACC protocol=2E
+
+The server should then use=
 client-acc-msg command to send app custom
+control messages to the client =
to facilitate the pending authentication=2E
+
+COMMAND -- client-acc-msg (O=
penVPN 2=2E8 or higher)
+------------------------------------------
+
+On a=
n OpenVPN instance running in server mode this command sends an
+app custom=
 control message to a client=2E The format of the command is:
+
+  client-a=
cc-msg {CID} {KID}
+  {protocol}
+  {flags}
+  {message}
+  END
+
+CID,KID =
-- client ID and Key ID=2E See documentation for ">CLIENT:"
+notification f=
or more info=2E
+
+protocol -- the ACC protocol identifier that this messag=
e should be
+            tagged with=2E
+
+flags    -- a colon separated li=
st of the encoding and the flag if
+            the message is a fragment=
=2E E=2Eg=2E "6:F" for a base64 encoded
+            message that is also a=
 fragment and not complete yet=2E
+
+message  -- The message encoded in the=
 encoding specified in flags
+
+
+COMMAND -- acc-msg (OpenVPN 2=2E8 or high=
er)
+------------------------------------------
+
+When OpenVPN is running =
in --client mode this command sends an app
+custom command to the server=2E=
 The format of the command is
+
+  acc-msg
+  {protocol}
+  {flags}
+  {mes=
sage}
+  END
+
+See the client-acc-msg command for more details about the f=
ormat of the
+message=2E Since a client has only one peer there is no need =
to specify the
+client id and key id=2E
+
+
 COMMAND -- client-deny  (OpenV=
PN 2=2E1 or higher)
 -----------------------------------------------
 
@@ -=
1302,6 +1354,46 @@
    response=2E Mechanisms that need multiple rounds or =
more complex answers
    should implement a different response type than CR=
_RESPONSE=2E
 
+(6) App custom control message
+
+    This message is an ap=
plication specific payload message that is transported
+    over the OpenVP=
N control channel=2E
+
+    In server mode:
+
+    >CLIENT:ACC,{CID},{KID},=
{protocol},{fragment},{msg_base64}
+
+    In client mode:
+
+    >ACC:{prot=
ocol},{fragment},{msg_base64}
+
+    The protocol is a short ascii string i=
dentifying the app specific custom
+    protocol=2E If fragment is set to 1=
, the message is not complete and the
+    next message should be concatena=
ted to this message to form a complete
+    message=2E
+
+    Note that the=
 OpenVPN implementation operates here with the robustness
+    principle ("=
be conservative in what you send, be liberal in what you
+    accept" - RFC=
 793 and others) and allows receiving messages longer than
+    maximum all=
owed message length=2E Implementations should be prepared to
+    handle me=
ssages that are longer than the maximum allowed message length=2E
+
+
+(7) =
App custom control protocol message
+
+   This message informs the client a=
bout the common ACC
+   protocols and the maximum message length for an ACC=
 message=2E
+
+   In client mode:
+
+   >ACC_PROTOCOLS:protocols=3D{protoco=
l_list},message_len=3D{max_msg_len}
+
+   protocol_list is a list of suppor=
ted protocols by the client=2E For example
+   flower:power:sys_info would =
indicate these three protocols to be supported=2E
+   max_msg_len specifies=
 the maximum message length that the peer supports=2E
+
+   In server mode =
these are available in the acc_protocols and
+   acc_message_len variables =
of the client environment=2E
 
 Variables:
 
diff --git a/src/openvpn/Makef=
ile=2Eam b/src/openvpn/Makefile=2Eam
index 8a60a94=2E=2Eebc4db6 100644
--- =
a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -45,6 +45,7 =
@@
 sbin_PROGRAMS =3D openvpn
 
 openvpn_SOURCES =3D \
+	acc=2Ec acc=2Eh \
=
 	argv=2Ec argv=2Eh \
 	auth_token=2Ec auth_token=2Eh \
 	base64=2Ec base64=
=2Eh \
@@ -124,7 +125,8 @@
 	proto=2Ec proto=2Eh \
 	proxy=2Ec proxy=2Eh \
=
 	ps=2Ec ps=2Eh \
-	push=2Ec push_util=2Ec push=2Eh \
+	push=2Ec push=2Eh \=

+	push_util=2Ec \
 	pushlist=2Eh \
 	reflect_filter=2Ec reflect_filter=2Eh=
 \
 	reliable=2Ec reliable=2Eh \
diff --git a/src/openvpn/acc=2Ec b/src/ope=
nvpn/acc=2Ec
new file mode 100644
index 0000000=2E=2Efe080e5
--- /dev/null
=
+++ b/src/openvpn/acc=2Ec
@@ -0,0 +1,438 @@
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
+ *  Copyright (C) 2025 OpenV=
PN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc=
2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can redistribut=
e it and/or modify
+ *  it under the terms of the GNU General Public Licens=
e version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  T=
his program is distributed in the hope that it will be useful,
+ *  but WIT=
HOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILIT=
Y or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public L=
icense for more details=2E
+ *
+ *  You should have received a copy of the =
GNU General Public License along
+ *  with this program; if not, write to t=
he Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, =
Boston, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=
=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <string=2Eh>
+#include =
"buffer=2Eh"
+#include "error=2Eh"
+#include "acc=2Eh"
+#include "forward=
=2Eh"
+#include "options_util=2Eh"
+#include "ssl_util=2Eh"
+#include "ssl_=
ncp=2Eh"
+#include "multi=2Eh"
+
+enum acc_message_flag
+{
+    ACC_MESSAGE=
_FLAGS_ASCII =3D 1,
+    ACC_MESSAGE_FLAGS_BASE64 =3D 2,
+    ACC_MESSAGE_F=
LAGS_FRAGMENT =3D 4,
+};
+
+
+static void
+log_acc_message(struct context *=
c, const struct buffer *buf, int payload_len,
+                const char *=
protocol, int flags)
+{
+    bool fragment =3D flags & ACC_MESSAGE_FLAGS_FR=
AGMENT;
+#ifdef ENABLE_MANAGEMENT
+    struct gc_arena gc =3D gc_new();
+  =
  const char *payload_msg =3D NULL;
+
+    /* For simplicity, we always enc=
ode payload to be base64 encoded
+     * if not already in base64 format */=

+    if (flags & ACC_MESSAGE_FLAGS_ASCII)
+    {
+        char *b64out =3D=
 NULL;
+        ASSERT(openvpn_base64_encode(CBPTR(buf), payload_len, &b64o=
ut) >=3D 0);
+        gc_addspecial(b64out, free, &gc);
+        payload_ms=
g =3D b64out;
+    }
+    else
+    {
+        payload_msg =3D CBSTR(buf);
=
+    }
+
+    if (management)
+    {
+        struct tls_session *session =
=3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+        if (c->options=2Emod=
e =3D=3D MODE_SERVER)
+        {
+            /* server mode=2E Report clie=
nt context */
+            struct man_def_auth_context *mda =3D session->op=
t->mda_context;
+            unsigned int mda_key_id =3D get_primary_key(c-=
>c2=2Etls_multi)->mda_key_id;
+            msg(M_CLIENT, ">CLIENT:ACC,%lu,%=
u,%s,%d,%s",
+                mda->cid, mda_key_id, protocol, fragment, pay=
load_msg);
+        }
+        else
+        {
+            /* Client mode=
=2E Do not a report a CLIENT id */
+            msg(M_CLIENT, ">ACC:%s,%d,%=
s", protocol, fragment, payload_msg);
+        }
+    }
+    gc_free(&gc);
=
+#endif /* ifdef ENABLE_MANAGEMENT */
+    msg(D_PUSH, "Received custom app=
 control message (protocol '%s'%s)",
+        protocol, fragment ? ", fragm=
ent" : "");
+}
+
+
+/**
+ *  Parses the flags field of an app control messa=
ge and moves the
+ *  buffer past the flags string=2E If there is an
+ *  e=
rror parsing the flags field the method returns -1 and
+ *  puts the error =
reason in err_reason
+ */
+static int
+parse_acc_message_flags(struct buffe=
r *buf, const char **err_reason, struct gc_arena *gc)
+{
+    const char *f=
lags =3D buf_extract_field(buf, ',', gc);
+
+    if (!flags)
+    {
+      =
  *err_reason =3D "could not extract flags field";
+        return -1;
+   =
 }
+
+
+    int acc_flags =3D 0;
+
+    for (const char *flag =3D flags; *f=
lag !=3D '\0'; flag++)
+    {
+        if (*flag =3D=3D 'A')
+        {
+  =
          acc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;
+        }
+        else =
if (*flag =3D=3D '6')
+        {
+            acc_flags |=3D ACC_MESSAGE_FL=
AGS_BASE64;
+        }
+        else if (*flag =3D=3D 'F')
+        {
+    =
        acc_flags |=3D ACC_MESSAGE_FLAGS_FRAGMENT;
+        }
+        else=

+        {
+            *err_reason =3D "Unknown flag in flags";
+        =
    return -1;
+        }
+    }
+    /* The message should be encoded with=
 exactly one encoding=2E Ensure that
+     * only one of the flags is prese=
nt */
+    bool asciienc =3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_ASCII);
+=
    bool base64enc =3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_BASE64);
+
+   =
 if (base64enc + asciienc !=3D 1)
+    {
+        char *tmp =3D gc_malloc(5=
12, 1, gc);
+        snprintf(tmp, 512, "number of encodings must be exactl=
y one "
+                           "(B64=3D%d, ASCII=3D%d)",
+            =
     base64enc, asciienc);
+        *err_reason =3D tmp;
+        return -1=
;
+    }
+
+    return acc_flags;
+}
+
+
+void
+receive_acc_message(struct =
context *c, const struct buffer *buffer)
+{
+    struct gc_arena gc =3D gc_=
new();
+    const char *err_reason =3D "";
+
+    /* Example message: ACC,m=
uppets,15,A,I am Miss Piggy */
+    struct buffer buf =3D *buffer;
+
+    c=
onst struct tls_multi *multi =3D c->c2=2Etls_multi;
+    if (!multi->acc_ne=
gotiated_protocols)
+    {
+        err_reason =3D "ACC not enabled or no n=
egotiated protocols";
+        goto err;
+    }
+
+    if (!buf_advance(&bu=
f, strlen("ACC")) || buf_read_u8(&buf) !=3D ',')
+    {
+        err_reason=
 =3D "missing , after ACC";
+        goto err;
+    }
+
+    /* extract pro=
tocol, payload length, flags substrings */
+    const char *protocol =3D bu=
f_extract_field(&buf, ',', &gc);
+    if (!protocol)
+    {
+        err_re=
ason =3D "could not extract protocol field";
+        goto err;
+    }
+
+ =
   if (!tls_item_in_cipher_list(protocol, multi->acc_negotiated_protocols))=

+    {
+        struct buffer msg_buf =3D alloc_buf_gc(1024, &gc);
+      =
  buf_printf(&msg_buf, "protocol '%s' not in list of negotiated protocols '=
%s'",
+                   protocol, multi->acc_negotiated_protocols);
+    =
    err_reason =3D buf_cstr(&msg_buf);
+
+
+        goto err;
+    }
+
+   =
 /* We do not check the length here=2E We make no promises to support
+    =
 * anything larger than our announced message length but according to
+    =
 * the robustness principle
+     * ("be conservative in what you send, be =
liberal in what you accept" - RFC 793 and others)
+     * we accept also lo=
nger messages */
+
+    int payload_len;
+    const char *payload_len_str =
=3D buf_extract_field(&buf, ',', &gc);
+    if (!payload_len_str || !((payl=
oad_len =3D atoi(payload_len_str))))
+    {
+        err_reason =3D "could =
not extract payload length field";
+        goto err;
+    }
+
+    int fla=
gs =3D parse_acc_message_flags(&buf, &err_reason, &gc);
+
+    if (flags < =
0)
+    {
+        goto err;
+    }
+
+    /* We should have a final NUL by=
te in the control message buffer
+     * and thus the length of the buffer =
should be payload_len + 1 */
+    if (buf_len(&buf) !=3D payload_len + 1)
+=
    {
+        char *tmp =3D gc_malloc(512, 1, &gc);
+        snprintf(tmp,=
 512, "field length %d, payload length %d mismatch",
+                 payl=
oad_len, buf_len(&buf) - 1);
+        err_reason =3D tmp;
+        goto err=
;
+    }
+
+
+    log_acc_message(c, &buf, payload_len, protocol, flags);
+=
    gc_free(&gc);
+    return;
+
+err:
+    msg(D_PUSH_ERRORS, "WARNING: Re=
ceived malformed custom app control channel "
+                       "mess=
age (%s): %s",
+        err_reason,
+        format_hex(BPTR(&buf), BLEN(&b=
uf), 80, &gc));
+    gc_free(&gc);
+}
+
+
+bool
+send_acc_message(struct co=
ntext *c,
+                 struct tls_multi *multi,
+                 stru=
ct tls_session *session,
+                 const char *protocol, bool fragm=
ent,
+                 const char *msg, bool base64)
+{
+    /*
+     * len=
gth of the protocol string + one ','
+     * 2 for the encoding (A or 6), p=
otential F (fragment), and 1 for the ',',
+     * 4 for the message size it=
self and one comma
+     * 1 for the comma before the message itself */
+  =
  const size_t max_header_size =3D strlen("ACC,") + strlen(protocol) + 1 + =
4 + 1 + 2 + 1;
+    size_t len =3D max_header_size + strlen(msg);
+
+    if=
 (len > TLS_CHANNEL_BUF_SIZE)
+    {
+        msg(M_CLIENT, "message length=
 (%zu) exceeds maximum possible message length (%d)", len, TLS_CHANNEL_BUF_=
SIZE);
+        return false;
+    }
+
+    if ((int)len > multi->acc_max_m=
essage_length)
+    {
+        msg(M_CLIENT, "header (%zu) + message size (=
%zu) length (%zu) exceeds "
+                      "maximum allowed length =
negotiated with peer (%d)",
+            max_header_size, strlen(msg), len,=

+            multi->acc_max_message_length);
+        return false;
+    }=

+
+    struct gc_arena gc =3D gc_new();
+    /* add 1 for the final \0 */
=
+    struct buffer buf =3D alloc_buf_gc(len + 1, &gc);
+
+    /* Example me=
ssage: ACC,muppets,15,A,I am Miss Piggy */
+    buf_printf(&buf, "ACC,%s,%z=
u,%s%s,%s", protocol,
+               strlen(msg),
+               base64 ?=
 "6" : "A",
+               fragment ? "F" : "",
+               msg);
+
+ =
   send_control_channel_string_dowork(session, BSTR(&buf), D_PUSH);
+    re=
schedule_multi_process(c);
+    gc_free(&gc);
+    return true;
+}
+
+char =
*
+parse_acc_parameters(const char *capabilities,
+                     con=
st char *delim,
+                     int *max_acc_len,
+                  =
   bool server,
+                     struct gc_arena *gc)
+{
+    char *tm=
p_message =3D string_alloc(capabilities, NULL);
+    char *tmp_message_orig=
 =3D tmp_message;
+    char *lasts =3D NULL;
+
+    const char *token =3D s=
trtok_r(tmp_message, delim, &lasts);
+
+    int p =3D 0;
+    int acclen =
=3D 0;
+    const char *protocols =3D NULL;
+    char *ret =3D NULL;
+
+   =
 /* In server mode we allow more capabilities than our own, in client
+    =
 * mode we reject if we should use capabilities that we do not support */
+=
    int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;
+
+    whil=
e (token)
+    {
+        if (p =3D=3D 0 && !atoi_constrained(token, &accle=
n, "ACC message length", ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))
=
+        {
+            goto done;
+        }
+
+        if (p =3D=3D 1 && =
(!tls_item_in_cipher_list("A", token) || !tls_item_in_cipher_list("6", toke=
n)))
+        {
+            msg(D_PUSH_ERRORS, "App custom control encodin=
g must include base64 and ascii");
+            goto done;
+        }
+
+  =
      if (p =3D=3D 1 && !server && strcmp(token, "A:6") && strcmp(token, "6=
:A"))
+        {
+            msg(D_PUSH_ERRORS, "App custom control encodi=
ng must exactly base64 and ascii");
+            goto done;
+        }
+
+ =
       if (p =3D=3D 2)
+        {
+            protocols =3D token;
+      =
  }
+
+        if (p =3D=3D 3)
+        {
+            msg(D_PUSH_ERRORS, "=
Too many parameters for INFO ACC message/IV_ACC=2E");
+            goto don=
e;
+        }
+
+        token =3D strtok_r(NULL, delim, &lasts);
+        =
p++;
+    }
+
+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);
+    =
ret =3D string_alloc(protocols, gc);
+
+done:
+    free(tmp_message_orig);
=
+    return ret;
+}
+
+struct buffer
+get_list_intersection(struct gc_arena=
 *gc, const char *list1, const char *list2)
+{
+    char *tmp =3D strdup(li=
st1);
+    char *lasts =3D NULL;
+    const char *token =3D strtok_r(tmp, "=
:", &lasts);
+
+    /* The maximum possible length is the shorter of the tw=
o input lists */
+    size_t max_len =3D min_size(strlen(list1), strlen(lis=
t2));
+
+    struct buffer common_protocols =3D alloc_buf_gc(max_len + 1, g=
c);
+
+    while (token)
+    {
+        /* check for every items is in bot=
h lists and not already in the
+         * common list */
+        if (tls_=
item_in_cipher_list(token, list2)
+            && !tls_item_in_cipher_list(=
token, buf_cstr(&common_protocols)))
+        {
+            if (buf_len(&c=
ommon_protocols) > 0)
+            {
+                buf_write_u8(&common_=
protocols, ':');
+            }
+            buf_printf(&common_protocols, =
"%s", token);
+        }
+        token =3D strtok_r(NULL, ":", &lasts);
+ =
   }
+    free(tmp);
+    return common_protocols;
+}
+
+void
+determine_co=
mmon_acc_protocols(struct tls_multi *multi, struct tls_session *session)
+{=

+    if (!multi->opt=2Eacc_protocols)
+    {
+        /* No app custom pro=
tocols have been configured server-side=2E */
+        return;
+    }
+
+  =
  if (multi->acc_negotiated_protocols)
+    {
+        /* We already have d=
etermined the common protocols=2E */
+        return;
+    }
+
+    struct =
gc_arena gc =3D gc_new();
+
+    /* example IV_ACC: IV_ACC=3D2048,6:A,flowe=
r:power */
+    const char *peer_info =3D multi->peer_info;
+    const char=
 *iv_acc =3D extract_var_peer_info(peer_info, "IV_ACC=3D", &gc);
+    if (!=
iv_acc)
+    {
+        gc_free(&gc);
+        return;
+    }
+
+    int ma=
x_acc_len =3D 0;
+    const char *protocols =3D parse_acc_parameters(iv_acc=
, ",", &max_acc_len, true, &gc);
+
+    if (!protocols)
+    {
+        gc_=
free(&gc);
+        msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer info variable =
of peer is malformed");
+        return;
+    }
+
+    struct buffer common=
_protocols =3D get_list_intersection(&gc, session->opt->acc_protocols, prot=
ocols);
+
+    if (buf_len(&common_protocols) =3D=3D 0)
+    {
+        msg=
(D_PUSH_DEBUG, "WARNING: No common app custom control protocol=2E");
+     =
   gc_free(&gc);
+        return;
+    }
+
+    multi->acc_negotiated_proto=
cols =3D string_alloc(buf_str(&common_protocols), NULL);
+    multi->acc_ma=
x_message_length =3D max_acc_len;
+
+    setenv_str(session->opt->es, "acc_=
protocols", multi->acc_negotiated_protocols);
+    setenv_int(session->opt-=
>es, "acc_message_len", multi->acc_max_message_length);
+
+    gc_free(&gc)=
;
+}
diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
new file mode 1=
00644
index 0000000=2E=2E4a388f7
--- /dev/null
+++ b/src/openvpn/acc=2Eh
@@=
 -0,0 +1,105 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP ne=
tworks
+ *             over a single TCP/UDP port, with support for SSL/TLS=
-based
+ *             session authentication and key exchange,
+ *        =
     packet encryption, packet authentication, and
+ *             packet c=
ompression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>=

+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  Thi=
s program is free software; you can redistribute it and/or modify
+ *  it u=
nder the terms of the GNU General Public License version 2
+ *  as publishe=
d by the Free Software Foundation=2E
+ *
+ *  This program is distributed i=
n the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without e=
ven the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULA=
R PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+=
 *
+ *  You should have received a copy of the GNU General Public License a=
long
+ *  with this program; if not, write to the Free Software Foundation,=
 Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E=

+ */
+
+#ifndef ACC_H
+#define ACC_H
+
+#include "openvpn=2Eh"
+
+#define =
ACC_MIN_MSG_LEN 64
+#define ACC_MAX_MSG_LEN 1280
+
+/**
+ * This method par=
ses an app custom control message and delivers it to the
+ * management int=
erface=2E We leave reassembly of fragmented messages to the
+ * management =
interface=2E
+ *
+ * @param c            The context struct
+ * @param buff=
er       Buffer containing the control message with ACC
+ */
+void
+receive=
_acc_message(struct context *c, const struct buffer *buffer);
+
+
+bool
+se=
nd_acc_message(struct context *c,
+                 struct tls_multi *tls_m=
ulti,
+                 struct tls_session *session,
+                 cons=
t char *protocol, bool fragment,
+                 const char *msg, bool ba=
se64);
+
+
+/**
+ * Parses an info message from the server that contains ap=
p custom control info
+ * information prior to the PUSH_REPLY to be able to=
 use app custom control
+ * protocols before sending
+ *
+ * In client mode=
 only allow what we support ourselves=2E In server mode
+ * allow also capa=
bilities that we not support ourselves=2E
+ *
+ * @param capabilities      =
The string to parse
+ * @param delim             The delimiter to use when =
parsing the string=2E
+ *                          IV_ACC uses "," as delim=
iter while the
+ *                          custom-control PUSH message use=
s " " as "," is
+ *                          already used to separate diffe=
rent push directives
+ * @param max_acc_len       Set to the maximum ACC me=
ssage length
+ * @param server            Whether we are server or client
+=
 * @param gc                The gc arena to use for allocating the resultin=
g string
+ * @return                  The resulting protocol string or NULL=
 on error
+ */
+char *
+parse_acc_parameters(const char *capabilities,
+   =
                  const char *delim,
+                     int *max_acc_len=
,
+                     bool server,
+                     struct gc_arena =
*gc);
+
+/**
+ * Parses the IV_ACC of the peer and sets multi=2Eacc_negotia=
ted_protocols
+ * to the common protocols of server and client and
+ * mult=
i=2Eacc_max_message_length  to the maximum length of the ACC message
+ * su=
pport by both server and client=2E
+ *
+ * If there is no common protocol o=
r the client does not support any app custom
+ * protocol multi=2Eacc_negot=
iated_protocols will be set to NULL=2E
+ *
+ * @param multi      the multi =
instance to use the set the app custom protocols=2E
+ * @param session    t=
he session to read the client env from
+ */
+void
+determine_common_acc_pro=
tocols(struct tls_multi *multi, struct tls_session *session);
+
+/**
+ * Ca=
lculates the intersection of two list that are both separated by :
+ * Item=
s in the result will have the same ordering as in the list1
+ * parameters
=
+ * @param gc            Returned buffer will be allocated in this gc
+ * @=
param list1         First list to intersect
+ * @param list2         Second=
 list to intersect=2E
+ * @return A (potentially empty) buffer containing a=
n intersection list
+ */
+struct buffer
+get_list_intersection(struct gc_ar=
ena *gc, const char *list1, const char *list2);
+#endif
diff --git a/src/op=
envpn/forward=2Ec b/src/openvpn/forward=2Ec
index 681210d=2E=2E7923b5e 1006=
44
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -42,6 +42=
,7 @@
 #include "dco=2Eh"
 #include "auth_token=2Eh"
 #include "tun_afunix=
=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -257,11 +258,11 @@
=
     }
     else if (buf_string_match_head_str(buf, "INFO_PRE"))
     {
-  =
      server_pushed_info(buf, 8);
+        server_pushed_info(c, buf, 8);
 =
    }
     else if (buf_string_match_head_str(buf, "INFO"))
     {
-       =
 server_pushed_info(buf, 4);
+        server_pushed_info(c, buf, 4);
     }=

     else if (buf_string_match_head_str(buf, "CR_RESPONSE"))
     {
@@ -27=
1,6 +272,10 @@
     {
         receive_auth_pending(c, buf);
     }
+    el=
se if (buf_string_match_head_str(buf, "ACC"))
+    {
+        receive_acc_m=
essage(c, buf);
+    }
     else if (buf_string_match_head_str(buf, "EXIT")=
)
     {
         receive_exit_message(c);
diff --git a/src/openvpn/init=2E=
c b/src/openvpn/init=2Ec
index 1b8b2a5=2E=2Ecfcd5b7 100644
--- a/src/openvp=
n/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2279,6 +2279,13 @@
         }
   =
  }
 
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+    if (multi &&=
 multi->acc_negotiated_protocols)
+    {
+        buf_printf(&out, " custom=
-control %d,A:6,%s",
+                   multi->acc_max_message_length, mul=
ti->acc_negotiated_protocols);
+    }
+
     if (BLENZ(&out) > strlen(heade=
r))
     {
         msg(D_HANDSHAKE, "%s", BSTR(&out));
@@ -2522,6 +2529,11=
 @@
         flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);
     }
 
+    if (c-=
>options=2Eacc_protocols)
+    {
+        flags |=3D OPT_P_ACC;
+    }
+
  =
   return flags;
 }
 
@@ -2730,6 +2742,17 @@
         frame->tun_mtu =3D mi=
n_int(frame->tun_max_mtu, c->options=2Ece=2Etun_mtu);
     }
 
+    if (fou=
nd & OPT_P_ACC && c->options=2Epushed_acc_negotiated_protocols)
+    {
+   =
     struct tls_multi *multi =3D c->c2=2Etls_multi;
+        free(multi->ac=
c_negotiated_protocols);
+        multi->acc_negotiated_protocols =3D strin=
g_alloc(c->options=2Epushed_acc_negotiated_protocols, NULL);
+        multi=
->acc_max_message_length =3D c->options=2Epushed_acc_max_message_length;
+
=
+        msg(D_PUSH, "OPTIONS IMPORT: ACC protocols: %s, msg len: %d",
+   =
         multi->acc_negotiated_protocols, multi->acc_max_message_length);
+=
    }
+
     return true;
 }
 
@@ -3352,6 +3375,7 @@
     to=2Everify_hash_=
depth =3D options->verify_hash_depth;
     to=2Everify_hash_no_ca =3D optio=
ns->verify_hash_no_ca;
     memcpy(to=2Ex509_username_field, options->x509_=
username_field, sizeof(to=2Ex509_username_field));
+    to=2Eacc_protocols =
=3D options->acc_protocols;
     to=2Ees =3D c->c2=2Ees;
     to=2Enet_ctx =
=3D &c->net_ctx;
 
@@ -4306,6 +4330,24 @@
 }
 #endif /* ifdef TARGET_ANDROI=
D */
 
+static bool
+management_acc_msg(void *arg,
+                   stru=
ct buffer_list *input) /* ownership transferred */
+{
+    struct context *=
c =3D arg;
+
+    bool ret =3D false;
+    if (buffer_list_defined(input) &=
& c->c2=2Etls_multi)
+    {
+        struct tls_multi *multi =3D c->c2=2Etl=
s_multi;
+        struct tls_session *session =3D &multi->session[TM_ACTIVE=
];
+
+        ret =3D management_send_acc_message(c, multi, session, input)=
;
+    }
+
+    buffer_list_free(input);
+    return ret;
+}
 #endif /* ifd=
ef ENABLE_MANAGEMENT */
 
 void
@@ -4322,6 +4364,7 @@
         cb=2Eproxy_c=
md =3D management_callback_proxy_cmd;
         cb=2Eremote_cmd =3D manageme=
nt_callback_remote_cmd;
         cb=2Esend_cc_message =3D management_callba=
ck_send_cc_message;
+        cb=2Eacc_msg =3D management_acc_msg;
 #ifdef T=
ARGET_ANDROID
         cb=2Enetwork_change =3D management_callback_network_=
change;
 #endif
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2E=
c
index ac3d4b7=2E=2E5e4e416 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/=
openvpn/manage=2Ec
@@ -45,9 +45,11 @@
 #include "push=2Eh"
 #include "multi=
=2Eh"
 #include "resolve=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
=
 #include "run_command=2Eh"
+#include "ssl_ncp=2Eh"
 
 #ifdef ENABLE_PKCS11=

 #include "pkcs11=2Eh"
@@ -1081,6 +1083,35 @@
             }
             =
break;
 
+        case IEC_CLIENT_ACC_MSG:
+            if (man->persist=2E=
callback=2Eclient_acc_msg)
+            {
+                bool status =3D =
(*man->persist=2Ecallback=2Eclient_acc_msg)(man->persist=2Ecallback=2Earg,
=
+                                                                      man-=
>connection=2Ein_extra_cid,
+                                              =
                        man->connection=2Ein_extra_kid,
+                  =
                                                    man->connection=2Ein_ex=
tra);
+                man->connection=2Ein_extra =3D NULL;
+              =
  report_command_status(status, "client-acc-msg");
+            }
+        =
    else
+            {
+                man_command_unsupported("client-ac=
c-msg");
+            }
+            break;
+
+        case IEC_ACC_MSG:
+ =
           if (man->persist=2Ecallback=2Eacc_msg)
+            {
+         =
       bool status =3D (*man->persist=2Ecallback=2Eacc_msg)(man->persist=2E=
callback=2Earg,
+                                                          =
     man->connection=2Ein_extra);
+                man->connection=2Ein_ext=
ra =3D NULL;
+                report_command_status(status, "acc-msg");
+  =
          }
+            else
+            {
+                man_command_u=
nsupported("acc-msg");
+            }
+            break;
         case IEC=
_PK_SIGN:
             man->connection=2Eext_key_state =3D EKS_READY;
     =
        buffer_list_free(man->connection=2Eext_key_input);
@@ -1205,6 +1236=
,29 @@
 }
 
 static void
+man_client_acc_msg(struct management *man, const =
char *cid_str,
+                   const char *kid_str)
+{
+    struct man_=
connection *mc =3D &man->connection;
+    mc->in_extra_cid =3D 0;
+    mc->=
in_extra_kid =3D 0;
+    if (parse_cid(cid_str, &mc->in_extra_cid)
+       =
 && parse_uint(kid_str, "KID", &mc->in_extra_kid))
+    {
+        mc->in_e=
xtra_cmd =3D IEC_CLIENT_ACC_MSG;
+        in_extra_reset(mc, IER_NEW);
+   =
 }
+}
+
+static void
+man_acc_msg(struct management *man)
+{
+    struct ma=
n_connection *mc =3D &man->connection;
+    mc->in_extra_cmd =3D IEC_ACC_MS=
G;
+    in_extra_reset(mc, IER_NEW);
+}
+
+static void
 man_client_auth(str=
uct management *man, const char *cid_str, const char *kid_str, const bool e=
xtra)
 {
     struct man_connection *mc =3D &man->connection;
@@ -1759,6 +1=
813,17 @@
             man_client_pending_auth(man, p[1], p[2], p[3], p[4])=
;
         }
     }
+    else if (streq(p[0], "client-acc-msg"))
+    {
+  =
      if (man_need(p, 2, 0))
+        {
+            man_client_acc_msg(man=
, p[1], p[2]);
+        }
+    }
+    else if (streq(p[0], "acc-msg"))
+   =
 {
+        man_acc_msg(man);
+    }
     else if (streq(p[0], "rsa-sig"))
=
     {
         man_pk_sig(man, "rsa-sig");
@@ -2975,7 +3040,9 @@
         =
                               "bytes_sent=3D",
                           =
             "bytes_received=3D",
                                        "=
session_id=3D",
-                                       "session_state=3D" =
};
+                                       "session_state=3D",
+           =
                            "acc_protocols=3D",
+                          =
             "acc_message_len=3D" };
 
     if (env_filter_level =3D=3D 0)
=
     {
@@ -3130,6 +3197,7 @@
     }
 }
 
+
 void
 management_connection_est=
ablished(struct management *man, struct man_def_auth_context *mdac,
       =
                            const struct env_set *es)
@@ -4372,6 +4440,64 @=
@
     }
 }
 
+bool
+management_send_acc_message(struct context *c, struct =
tls_multi *multi, struct tls_session *session,
+                           =
 struct buffer_list *input)
+{
+    /* also ensures that are enough inputs =
in the list to safely call
+     * buffer_list_peek without extra NULL chec=
ks */
+    if (!input || input->size < 3)
+    {
+        msg(M_CLIENT, "no=
t enough input lines for sending acc message, "
+                      "mis=
sing protocol, flag and/or messages lines");
+        return false;
+    }
=
+
+    struct gc_arena gc =3D gc_new();
+
+    const struct buffer *proto_b=
uf =3D buffer_list_peek(input);
+    const char *protocol =3D string_alloc(=
CBSTR(proto_buf), &gc);
+    buffer_list_pop(input);
+
+    struct buffer *=
encoding_buf =3D buffer_list_peek(input);
+    char *encoding =3D buf_str(e=
ncoding_buf);
+    const char *flag =3D NULL;
+    bool b64encoding =3D fal=
se;
+    bool fragment =3D false;
+
+    while ((flag =3D strsep(&encoding,=
 ":")))
+    {
+        if (!strcmp(flag, "6"))
+        {
+            b64=
encoding =3D true;
+        }
+        else if (!strcmp(flag, "F"))
+      =
  {
+            fragment =3D true;
+        }
+    }
+    buffer_list_pop(=
input);
+
+    buffer_list_aggregate_separator(input, 10000, "");
+    cons=
t struct buffer *acc_msg_buf =3D buffer_list_peek(input);
+
+    if (!multi=
->acc_negotiated_protocols
+        || !tls_item_in_cipher_list(protocol, m=
ulti->acc_negotiated_protocols))
+    {
+        msg(M_CLIENT, "protocol no=
t in the list of negotiated protocols: %s",
+            np(multi->acc_nego=
tiated_protocols));
+        goto error;
+    }
+
+    bool ret =3D send_ac=
c_message(c, multi, session, protocol,
+                                fra=
gment, buf_cstr(acc_msg_buf),
+                                b64encoding)=
;
+    gc_free(&gc);
+    return ret;
+error:
+    gc_free(&gc);
+    retur=
n false;
+}
 #else /* ifdef ENABLE_MANAGEMENT */
 
 #include "win32=2Eh"
di=
ff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 157039d=2E=
=2Ecc9c264 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh=

@@ -184,12 +184,19 @@
     int (*n_clients)(void *arg);
     bool (*send_c=
c_message)(void *arg, const char *message, const char *parameter);
     boo=
l (*kill_by_cid)(void *arg, const unsigned long cid, const char *kill_msg);=

+
     bool (*client_auth)(void *arg, const unsigned long cid, const unsig=
ned int mda_key_id,
                         const bool auth, const char *r=
eason, const char *client_reason,
                         struct buffer_li=
st *cc_config); /* ownership transferred */
     bool (*client_pending_auth=
)(void *arg, const unsigned long cid, const unsigned int kid,
             =
                    const char *extra, unsigned int timeout);
     char *(*=
get_peer_info)(void *arg, const unsigned long cid);
+    bool (*client_acc_=
msg)(void *arg,
+                           const unsigned long cid,
+     =
                      const unsigned int mda_key_id,
+                     =
      struct buffer_list *msg);
+    bool (*acc_msg)(void *arg,
+          =
          struct buffer_list *msg);
     bool (*proxy_cmd)(void *arg, const=
 char **p);
     bool (*remote_cmd)(void *arg, const char **p);
 #ifdef TAR=
GET_ANDROID
@@ -292,13 +299,15 @@
     struct command_line *in;
     struct=
 buffer_list *out;
 
-#define IEC_UNDEF       0
-#define IEC_CLIENT_AUTH 1
=
+#define IEC_UNDEF          0
+#define IEC_CLIENT_AUTH    1
 /* #define IEC=
_CLIENT_PF   2 *REMOVED FEATURE* */
-#define IEC_RSA_SIGN    3
-#define IEC=
_CERTIFICATE 4
-#define IEC_PK_SIGN     5
-#define IEC_PASSWORD    6
+#defi=
ne IEC_RSA_SIGN       3
+#define IEC_CERTIFICATE    4
+#define IEC_PK_SIGN =
       5
+#define IEC_PASSWORD       6
+#define IEC_CLIENT_ACC_MSG 7
+#defi=
ne IEC_ACC_MSG        8
     int in_extra_cmd;
     struct buffer_list *in_=
extra;
     unsigned long in_extra_cid;
@@ -503,6 +512,14 @@
 
 void man_pe=
rsist_client_stats(struct management *man, struct context *c);
 
+/** Parse=
s the ACC message from the input buffer_list and send to the
+ * session id=
entified by session and multi
+ */
+struct tls_session;
+struct tls_multi;
=
+bool
+management_send_acc_message(struct context *c, struct tls_multi *mul=
ti,
+                            struct tls_session *session, struct buffer=
_list *input);
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /**
diff --git a/sr=
c/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index e302a81=2E=2Ea3eb3ca 1006=
44
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -53,6 +53,7 @=
@
 #include "ssl_util=2Eh"
 #include "dco=2Eh"
 #include "reflect_filter=2E=
h"
+#include "acc=2Eh"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -4085,6 +=
4086,26 @@
     }
 }
 
+static const char *
+calculate_app_control_extra(st=
ruct multi_instance *mi, struct gc_arena *gc)
+{
+    struct context *c =3D=
 &mi->context;
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+
+    i=
f (!multi->acc_negotiated_protocols)
+    {
+        msg(M_CLIENT, "ACC: No=
 negotiated protocols");
+        return NULL;
+    }
+
+    struct buffer =
buf =3D alloc_buf_gc(1024, gc);
+
+    buf_printf(&buf, "ACC:%d A:6 %s", mu=
lti->acc_max_message_length,
+               multi->acc_negotiated_protocol=
s);
+    return buf_str(&buf);
+}
+
+
 static bool
 management_client_pendi=
ng_auth(void *arg, const unsigned long cid, const unsigned int mda_key_id,
=
                                const char *extra, unsigned int timeout)
@@=
 -4095,10 +4116,22 @@
     if (mi)
     {
         struct tls_multi *multi =
=3D mi->context=2Ec2=2Etls_multi;
+
+        struct gc_arena gc =3D gc_new(=
);
+        if (!strcmp(extra, "ACC"))
+        {
+            extra =3D ca=
lculate_app_control_extra(mi, &gc);
+            if (!extra)
+            {=

+                gc_free(&gc);
+                return false;
+           =
 }
+        }
         struct tls_session *session =3D lookup_session_by_md=
a_key_id(multi, mda_key_id);
 
         if (!session)
         {
+         =
   gc_free(&gc);
             return false;
         }
 
@@ -4106,6 +4139,7=
 @@
         bool ret =3D send_auth_pending_messages(multi, session, extra,=
 timeout);
         reschedule_multi_process(&mi->context);
         multi_=
schedule_context_wakeup(m, mi);
+        gc_free(&gc);
         return ret;=

     }
     return false;
@@ -4149,6 +4183,37 @@
     return ret;
 }
 
+
+=
static bool
+management_client_acc_msg(void *arg,
+                        =
  const unsigned long cid,
+                          const unsigned int md=
a_key_id,
+                          struct buffer_list *input) /* ownershi=
p transferred */
+{
+    struct multi_context *m =3D (struct multi_context =
*)arg;
+    struct multi_instance *mi =3D lookup_by_cid(m, cid);
+
+    boo=
l ret =3D false;
+    if (mi && buffer_list_defined(input))
+    {
+       =
 struct tls_multi *multi =3D mi->context=2Ec2=2Etls_multi;
+        struct =
tls_session *session =3D lookup_session_by_mda_key_id(multi, mda_key_id);
+=
        if (!session)
+        {
+            msg(M_CLIENT, "client session=
 not found");
+            buffer_list_free(input);
+            return fal=
se;
+        }
+
+        ret =3D management_send_acc_message(&mi->context,=
 multi, session, input);
+        multi_schedule_context_wakeup(m, mi);
+  =
  }
+
+    buffer_list_free(input);
+    return ret;
+}
+
+
 static char *
=
 management_get_peer_info(void *arg, const unsigned long cid)
 {
@@ -4185,6=
 +4250,7 @@
         cb=2En_clients =3D management_callback_n_clients;
    =
     cb=2Ekill_by_cid =3D management_kill_by_cid;
         cb=2Eclient_auth=
 =3D management_client_auth;
+        cb=2Eclient_acc_msg =3D management_cl=
ient_acc_msg;
         cb=2Eclient_pending_auth =3D management_client_pendi=
ng_auth;
         cb=2Eget_peer_info =3D management_get_peer_info;
        =
 cb=2Epush_update_broadcast =3D management_callback_send_push_update_broadc=
ast;
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index f=
b319ae=2E=2Ebb854da 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/=
options=2Ec
@@ -35,6 +35,7 @@
 
 #include "syshead=2Eh"
 
+#include "acc=2E=
h"
 #include "buffer=2Eh"
 #include "error=2Eh"
 #include "common=2Eh"
@@ -=
7107,6 +7108,41 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         opti=
ons->force_key_material_export =3D true;
     }
+    else if (streq(p[0], "=
app-custom-control") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OP=
T_P_GENERAL);
+        options->acc_protocols =3D p[1];
+    }
+    else if=
 (streq(p[0], "custom-control") && p[1] && p[2] && p[3] && !p[4])
+    {
+ =
       VERIFY_PERMISSION(OPT_P_ACC);
+
+        /* check if the list from t=
he server is a real subset of our list */
+        struct gc_arena gc_local=
 =3D gc_new();
+        struct buffer common_list =3D get_list_intersection=
(&gc_local, p[3], options->acc_protocols);
+
+        if (buf_len(&common_l=
ist) =3D=3D 0 || !streq(p[3], buf_cstr(&common_list)))
+        {
+        =
    msg(msglevel, "App custom control list from server contains "
+        =
                  "unsupported protocols");
+            gc_free(&gc_local)=
;
+            goto err;
+        }
+        gc_free(&gc_local);
+
+       =
 if (!streq(p[2], "A:6") && !streq(p[2], "6:A"))
+        {
+            ms=
g(msglevel, "App custom control encoding must be base64 and ascii");
+     =
       goto err;
+        }
+
+        if (!atoi_constrained(p[1], &options=
->pushed_acc_max_message_length,
+                              "app custom=
 message message length", ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))
+   =
     {
+            goto err;
+        }
+        options->pushed_acc_negot=
iated_protocols =3D p[3];
+    }
     else if (streq(p[0], "prng") && p[1] =
&& !p[3])
     {
         msg(M_WARN, "NOTICE: --prng option ignored (SSL l=
ibrary PRNG is used)");
diff --git a/src/openvpn/options=2Eh b/src/openvpn/=
options=2Eh
index 6a3bf61=2E=2Eb7945e0 100644
--- a/src/openvpn/options=2Eh=

+++ b/src/openvpn/options=2Eh
@@ -715,6 +715,18 @@
     /* force using TLS=
 key material export for data channel key generation */
     bool force_key=
_material_export;
 
+    /** The app custom control protocols we should ann=
ounce as supported */
+    const char *acc_protocols;
+
+    /** the protoc=
ols that are negotiated with the peer=2E This is a
+     *  a temporary var=
iable since options=2Ec push parser cannot access
+     *  tls multi struct=
 */
+    const char *pushed_acc_negotiated_protocols;
+
+    /** the maximu=
m length of an ACC control channel message via push message
+     * */
+   =
 int pushed_acc_max_message_length;
+
     bool vlan_tagging;
     enum vla=
n_acceptable_frames vlan_accept;
     uint16_t vlan_pvid;
@@ -764,8 +776,10=
 @@
 #define OPT_P_INLINE          (1u << 29)
 #define OPT_P_PUSH_MTU      =
  (1u << 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
+#define OPT_P_ACC  =
           (1ull << 32)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_=
PULL_MODE | OPT_P_PEER_ID | 0x0ull))
+/* Options allowed in the normal conf=
iguration file (vs pushed options or in ccd files) */
+#define OPT_P_DEFAUL=
T (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #def=
ine PULL_DEFINED(opt) ((opt)->pull)
 
diff --git a/src/openvpn/push=2Ec b/s=
rc/openvpn/push=2Ec
index 42259c3=2E=2Ec4c4cd4 100644
--- a/src/openvpn/pus=
h=2Ec
+++ b/src/openvpn/push=2Ec
@@ -27,6 +27,8 @@
 #include "syshead=2Eh"
=
 
 #include "push=2Eh"
+
+#include "acc=2Eh"
 #include "options=2Eh"
 #incl=
ude "crypto=2Eh"
 #include "ssl=2Eh"
@@ -221,9 +223,61 @@
 #endif
 }
 
+sta=
tic void
+parse_server_pushed_info_acc(struct context *c, struct buffer *bu=
f)
+{
+    int max_acc_len =3D 0;
+    struct tls_multi *multi =3D c->c2=2E=
tls_multi;
+
+    if (multi->acc_negotiated_protocols)
+    {
+        retu=
rn;
+    }
+
+    if (!multi->opt=2Eacc_protocols)
+    {
+        msg(D_PU=
SH_ERRORS, "Server tried to push app custom control list "
+               =
            "without client announcing support for it");
+        return;
+=
    }
+
+    /* example string to parse: ACC:1400 A:6 flower:happy */
+    =
/* Skip over the ACC: prefix */
+    buf_advance(buf, 4);
+
+    struct gc_=
arena gc =3D gc_new();
+    const char *protocols =3D parse_acc_parameters(=
buf_cstr(buf), " ", &max_acc_len, false, &gc);
+    if (!protocols)
+    {
=
+        msg(D_PUSH_ERRORS, "WARNING: Received ACC info command with invali=
d parameters");
+        return;
+    }
+
+    /* check if the list from th=
e server is a real subset of our list */
+    struct buffer common_list =3D=
 get_list_intersection(&gc, protocols, multi->opt=2Eacc_protocols);
+
+    =
if (buf_len(&common_list) =3D=3D 0 || !streq(protocols, buf_cstr(&common_li=
st)))
+    {
+        msg(D_PUSH_ERRORS, "App custom control list from serv=
er contains "
+                           "unsupported protocols");
+      =
  gc_free(&gc);
+        return;
+    }
+
+    multi->acc_negotiated_protoc=
ols =3D string_alloc(protocols, NULL);
+    multi->acc_max_message_length =
=3D max_acc_len;
+
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+ =
       msg(M_CLIENT, ">ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d", prot=
ocols, max_acc_len);
+    }
+#endif
+    gc_free(&gc);
+}
 
 void
-server_p=
ushed_info(const struct buffer *buffer, const int adv)
+server_pushed_info(=
struct context *c, const struct buffer *buffer, const int adv)
 {
     cons=
t char *m =3D "";
     struct buffer buf =3D *buffer;
@@ -233,6 +287,12 @@
=
         m =3D BSTR(&buf);
     }
 
+    if (strncmp(m, "ACC:", 4) =3D=3D 0=
)
+    {
+        parse_server_pushed_info_acc(c, &buf);
+        return;
+=
    }
+
 #ifdef ENABLE_MANAGEMENT
     struct gc_arena gc;
     if (managem=
ent)
@@ -285,6 +345,7 @@
     msg(D_PUSH, "CR response was sent by client (=
'%s')", m);
 }
 
+
 /**
  * Parse the keyword for the AUTH_PENDING request
=
  * @param buffer                buffer containing the keywords, the buffer=
's
@@ -441,7 +502,6 @@
     const char *const peer_info =3D tls_multi->peer=
_info;
     unsigned int proto =3D extract_iv_proto(peer_info);
 
-
     /*=
 Calculate the maximum timeout and subtract the time we already waited */
 =
    unsigned int max_timeout =3D
         max_uint(tls_multi->opt=2Erenegot=
iate_seconds / 2, tls_multi->opt=2Ehandshake_window);
@@ -732,6 +792,12 @@
=
                 client_max_mtu, o->ce=2Etun_mtu, o->ce=2Etun_mtu);
       =
  }
     }
+
+    if (tls_multi->acc_negotiated_protocols)
+    {
+        =
push_option_fmt(gc, push_list, M_USAGE, "custom-control %d A:6 %s",
+      =
                  tls_multi->acc_max_message_length, tls_multi->acc_negotia=
ted_protocols);
+    }
 }
 
 static bool
diff --git a/src/openvpn/push=2Eh =
b/src/openvpn/push=2Eh
index 39302f6=2E=2Eb6695bc 100644
--- a/src/openvpn/=
push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -52,6 +52,7 @@
 
 int process_incomi=
ng_push_request(struct context *c);
 
+
 /**
  * @brief Handles the receivi=
ng of a push-update message and applies updates to the specified
  * option=
s=2E
@@ -92,7 +93,7 @@
 
 void receive_exit_message(struct context *c);
 
-=
void server_pushed_info(const struct buffer *buffer, const int adv);
+void =
server_pushed_info(struct context *c, const struct buffer *buffer, const in=
t adv);
 
 void receive_cr_response(struct context *c, const struct buffer =
*buffer);
 
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 08=
6a6fc=2E=2Ee84d32d 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=
=2Ec
@@ -55,6 +55,7 @@
 
 #include "crypto_epoch=2Eh"
 #include "ssl=2Eh"
+=
#include "acc=2Eh"
 #include "ssl_verify=2Eh"
 #include "ssl_backend=2Eh"
 =
#include "ssl_ncp=2Eh"
@@ -1279,6 +1280,7 @@
     free(multi->locked_cn);
 =
    free(multi->locked_username);
     free(multi->locked_original_username=
);
+    free(multi->acc_negotiated_protocols);
 
     cert_hash_free(multi-=
>locked_cert_hash_set);
 
@@ -2117,6 +2119,11 @@
                     }
   =
              }
             }
+
+            if (session->opt->acc_protoco=
ls)
+            {
+                buf_printf(&out, "IV_ACC=3D%d,6:A,%s\n"=
, ACC_MAX_MSG_LEN, session->opt->acc_protocols);
+            }
         }
=
     }
 
@@ -2398,6 +2405,8 @@
         multi->remote_ciphername =3D string=
_alloc("none", NULL);
     }
 
+    determine_common_acc_protocols(multi, s=
ession);
+
     if (username_len < 0 || password_len < 0)
     {
         m=
sg(D_TLS_ERRORS, "TLS Error: Username (%d) or password (%d) too long", abs(=
username_len),
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_co=
mmon=2Eh
index 9a55ead=2E=2E436770b 100644
--- a/src/openvpn/ssl_common=2Eh=

+++ b/src/openvpn/ssl_common=2Eh
@@ -457,6 +457,9 @@
     size_t ekm_size;=

 
     bool dco_enabled; /**< Whether keys have to be installed in DCO or =
not */
+
+    /** The app custom control protocols we should announce as su=
pported */
+    const char *acc_protocols;
 };
 
 /** @addtogroup control_p=
rocessor
@@ -730,6 +733,12 @@
     int dco_peer_id;
 
     dco_context_t *d=
co;
+
+    /** the protocols that are negotiated with the peer=2E */
+    c=
har *acc_negotiated_protocols;
+
+    /** the maximum length of an ACC cont=
rol channel message */
+    int acc_max_message_length;
 };
 
 /**  gets an=
 item  of \c key_state objects in the
diff --git a/tests/unit_tests/openvpn=
/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 43a6743=2E=2E=
f827a4c 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/uni=
t_tests/openvpn/Makefile=2Eam
@@ -107,10 +107,12 @@
 	@TEST_CFLAGS@
 ssl_te=
stdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdrive=
r_SOURCES =3D test_ssl=2Ec \
+	test_acc=2Ec test_acc=2Eh \
 	mock_msg=2Ec m=
ock_msg=2Eh test_common=2Eh \
 	mock_management=2Ec \
 	mock_ssl_dependenci=
es=2Ec mock_win32_execve=2Ec \
 	$(top_srcdir)/src/compat/compat-strlcpy=2E=
c \
+	$(top_srcdir)/src/openvpn/acc=2Ec \
 	$(top_srcdir)/src/openvpn/argv=
=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn=
/buffer=2Ec \
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
@@ -392,9 =
+395,11 @@
 
 misc_testdriver_SOURCES =3D test_misc=2Ec \
 	test_schedule=
=2Ec test_schedule=2Eh \
+	mock_management=2Ec \
 	mock_msg=2Ec test_common=
=2Eh  \
 	mock_get_random=2Ec \
 	$(top_srcdir)/src/compat/compat-strlcpy=
=2Ec \
+	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn=
/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \
 	$(top_srcdir=
)/src/openvpn/ssl_util=2Ec \
@@ -407,6 +412,7 @@
 	$(top_srcdir)/src/openvp=
n/siphash_reference=2Ec \
 	$(top_srcdir)/src/openvpn/session_id=2Ec
 
+
 p=
ush_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(to=
p_srcdir)/src/compat \
 	-I$(top_srcdir)/tests/unit_tests/openvpn \
diff --=
git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/openv=
pn/mock_management=2Ec
index fff4c2b=2E=2Ef572dbb 100644
--- a/tests/unit_t=
ests/openvpn/mock_management=2Ec
+++ b/tests/unit_tests/openvpn/mock_manage=
ment=2Ec
@@ -29,6 +29,7 @@
 
 #include "syshead=2Eh"
 
+#include <stdlib=2E=
h>
 #include "manage=2Eh"
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/tests/un=
it_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn/mock=
_push_dependencies=2Ec
index bf2ccf3=2E=2Ef083f89 100644
--- a/tests/unit_t=
ests/openvpn/mock_push_dependencies=2Ec
+++ b/tests/unit_tests/openvpn/mock=
_push_dependencies=2Ec
@@ -43,7 +43,8 @@
     uint64_t flags =3D OPT_P_UP |=
 OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
                     =
 | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
 =
                     | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO =
| OPT_P_PULL_MODE
-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P=
_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+                     | OPT_P_PEER=
_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS
+           =
          | OPT_P_ACC;
     return flags;
 }
 
diff --git a/tests/unit_test=
s/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec
new file mod=
e 100644
index 0000000=2E=2Ef1b97d5
--- /dev/null
+++ b/tests/unit_tests/op=
envpn/test_acc=2Ec
@@ -0,0 +1,358 @@
+/*
+ *  OpenVPN -- An application to =
securely tunnel IP networks
+ *             over a single TCP/UDP port, wit=
h support for SSL/TLS-based
+ *             session authentication and key =
exchange,
+ *             packet encryption, packet authentication, and
+ *=
             packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc =
<sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2E=
org>
+ *
+ *
+ *  This program is free software; you can redistribute it an=
d/or modify
+ *  it under the terms of the GNU General Public License versi=
on 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This pro=
gram is distributed in the hope that it will be useful,
+ *  but WITHOUT AN=
Y WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FI=
TNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License =
for more details=2E
+ *
+ *  You should have received a copy of the GNU Gen=
eral Public License along
+ *  with this program; if not, write to the Free=
 Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston,=
 MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+=
#endif
+
+#include "syshead=2Eh"
+
+#include <stdio=2Eh>
+#include <stdlib=
=2Eh>
+#include <stdarg=2Eh>
+#include <string=2Eh>
+#include <setjmp=2Eh>
=
+#include <cmocka=2Eh>
+
+#include "acc=2Eh"
+#include "test_acc=2Eh"
+#inc=
lude "test_common=2Eh"
+
+#include "mock_msg=2Eh"
+#include "multi=2Eh"
+
+=
char control_channel_mesage_sent[2048];
+
+/* Mock functions */
+bool
+send=
_control_channel_string_dowork(struct tls_session *session,
+              =
                     const char *str, unsigned int msglevel)
+{
+    assert=
_int_in_range(strlen(str), 0, 2048);
+
+    memcpy(control_channel_mesage_s=
ent, str, strlen(str));
+    return true;
+}
+
+void
+send_push_reply_auth_=
token(struct tls_multi *multi)
+{
+}
+
+void
+auth_set_client_reason(struct=
 tls_multi *multi, const char *reason)
+{
+}
+
+#define MSG_PAYLOAD "FgMBAR=
kBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"                \
+                    "r=
4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS" \
+                 =
   "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP" \
+            =
        "AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH" \
+       =
             "QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc" \
+  =
                  "ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA" =
\
+                    "AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/=
NyJ" \
+                    "93rQwityP9eKSijXgcQ=3D=3D"
+
+void
+test_acc_p=
arse_client_messages(void **state)
+{
+#ifndef ENABLE_MANAGEMENT
+    skip(=
);
+#else
+    /* ensure that the messages get to mock_msg */
+    x_debug_=
level =3D 3;
+    management =3D (void *)0x12345678;
+    struct gc_arena g=
c =3D gc_new();
+
+    /* contains a TLS 1=2E3 ClientHello */
+    const ch=
ar msg[] =3D "ACC,cck1,384,6," MSG_PAYLOAD;
+
+    struct buffer msg_buf;
+=
    struct context c =3D { 0 };
+    c=2Eoptions=2Emode =3D MODE_SERVER;
+
=
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &gc);
+
+    =
c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt =3D &c=2Ec2=2Etls_multi->opt;
=
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt->mda_context =3D &c=2Ec2=
=2Emda_context;
+    buf_set_read(&msg_buf, (void *)msg, sizeof(msg));
+
+ =
   receive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf=
, "WARNING: Received malformed custom app control channel message (ACC not =
enabled or no negotiated protocols): 4143432c 63636b31 2c333834 2c362c46 67=
4d4241 526b4241 41455641 774e616[more=2E=2E=2E]");
+    assert_string_equal=
(mock_managment_buf, "");
+
+    c=2Ec2=2Etls_multi->acc_negotiated_protoco=
ls =3D "no:common:protocol";
+    receive_acc_message(&c, &msg_buf);
+    a=
ssert_string_equal(mock_msg_buf, "WARNING: Received malformed custom app co=
ntrol channel message (protocol 'cck1' not in list of negotiated protocols =
'no:common:protocol'): 3338342c 362c4667 4d424152 6b424141 45564177 4e616e5=
5 616c6b45 4444784[more=2E=2E=2E]");
+    assert_string_equal(mock_managmen=
t_buf, "");
+
+    c=2Ec2=2Etls_multi->acc_negotiated_protocols =3D "cck1:f=
lower:power:fortune";
+    receive_acc_message(&c, &msg_buf);
+
+    assert=
_string_equal(mock_msg_buf, "Received custom app control message (protocol =
'cck1')");
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,cc=
k1,0," MSG_PAYLOAD);
+
+    const char flower_msg[] =3D "ACC,flower,48,6,SS=
BhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg=
_buf, (void *)flower_msg, sizeof(flower_msg));
+    receive_acc_message(&c,=
 &msg_buf);
+    assert_string_equal(mock_msg_buf, "Received custom app con=
trol message (protocol 'flower')");
+    assert_string_equal(mock_managment=
_buf, ">CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyE=
AAA=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    const char msg_incorrec=
t_len[] =3D "ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhb=
SAAS2VybWl0IiB9Ig=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_incorrect=
_len, sizeof(msg_incorrect_len));
+    receive_acc_message(&c, &msg_buf);
+=
    const char *error =3D "WARNING: Received malformed custom app control c=
hannel "
+                        "message (field length 62, payload length=
 64 mismatch): "
+                        "496e7367 496d316c 496a6f67 496d5=
a79 62326369 4c434141 "
+                        "65475a6d 2f534a7[more=2E=
=2E=2E]";
+
+    assert_string_equal(mock_msg_buf, error);
+    assert_stri=
ng_equal(mock_managment_buf, "");
+
+    CLEAR(mock_managment_buf);
+    co=
nst char msg_fragment[] =3D "ACC,power,12,6F,aGVsbG8gdw=3D=3D";
+    buf_se=
t_read(&msg_buf, (void *)msg_fragment, sizeof(msg_fragment));
+    receive_=
acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "Received=
 custom app control message (protocol 'power', fragment)");
+    assert_str=
ing_equal(mock_managment_buf, ">CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D");
=
+
+    CLEAR(mock_managment_buf);
+    /* check two encoding present */
+  =
  const char flower_msg_two_encs[] =3D "ACC,flower,48,6A,SSBhbSAAIEtlcm1pdC=
D//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)fl=
ower_msg_two_encs, sizeof(flower_msg_two_encs));
+    receive_acc_message(&=
c, &msg_buf);
+
+    error =3D "WARNING: Received malformed custom app cont=
rol channel message "
+            "(number of encodings must be exactly on=
e (B64=3D1, ASCII=3D1)): "
+            "53534268 62534141 4945746c 636d317=
0 6443442f 2f534230 "
+            "61475567 37372b3[more=2E=2E=2E]";
+
+  =
  assert_string_equal(mock_msg_buf, error);
+    assert_string_equal(mock_m=
anagment_buf, "");
+
+    /* no encoding present */
+    const char flower_=
msg_no_encs[] =3D "ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZ=
yEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)flower_msg_no_encs, sizeo=
f(flower_msg_no_encs));
+    receive_acc_message(&c, &msg_buf);
+
+    erro=
r =3D "WARNING: Received malformed custom app control channel message "
+  =
          "(number of encodings must be exactly one (B64=3D0, ASCII=3D0)): =
"
+            "53534268 62534141 4945746c 636d3170 6443442f 2f534230 "
+  =
          "61475567 37372b3[more=2E=2E=2E]";
+    assert_string_equal(mock_=
msg_buf, error);
+    assert_string_equal(mock_managment_buf, "");
+
+    x=
_debug_level =3D 0;
+    management =3D NULL;
+    gc_free(&gc);
+#endif
+}=

+
+void
+test_parse_acc_parameters(void **state)
+{
+    struct gc_arena g=
c =3D gc_new();
+    /* parameters to INFO message */
+    const char *info=
_acc_msg =3D "4096 A:6 flower:happy";
+
+    int max_len =3D 0;
+    const =
char *protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, true,=
 &gc);
+    assert_string_equal(protocols, "flower:happy");
+    assert_int=
_equal(max_len, 1280);
+
+    /* a client does not accept a length longer t=
han it supports */
+    protocols =3D parse_acc_parameters(info_acc_msg, " =
", &max_len, false, &gc);
+    assert_null(protocols);
+
+    /* message wi=
th lower limit than our, should work for client and server */
+    info_acc=
_msg =3D "1111 A:6 flower:happy";
+    protocols =3D parse_acc_parameters(i=
nfo_acc_msg, " ", &max_len, false, &gc);
+    assert_string_equal(protocols=
, "flower:happy");
+    assert_int_equal(max_len, 1111);
+
+    protocols =
=3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    asse=
rt_string_equal(protocols, "flower:happy");
+    assert_int_equal(max_len, =
1111);
+
+    /* more encodings than supported=2E Server should be okay, cl=
ient should fail */
+    info_acc_msg =3D "1200 A:6:B flower:happy";
+    p=
rotocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);=

+    assert_null(protocols);
+
+    protocols =3D parse_acc_parameters(inf=
o_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(protocols, "=
flower:happy");
+    assert_int_equal(max_len, 1200);
+
+    /* extra param=
eter */
+    info_acc_msg =3D "1400 A:6 flower:happy 77";
+    protocols =
=3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    asse=
rt_null(protocols);
+
+    protocols =3D parse_acc_parameters(info_acc_msg,=
 " ", &max_len, false, &gc);
+    assert_null(protocols);
+
+
+    const ch=
ar *iv_acc_capabilities =3D "1400,A:6,flower:happy:power";
+    protocols =
=3D parse_acc_parameters(iv_acc_capabilities, ",", &max_len, true, &gc);
+ =
   assert_string_equal(protocols, "flower:happy:power");
+
+    /* too smal=
l protocol length */
+    info_acc_msg =3D "32 A:6 flower:happy";
+    prot=
ocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+  =
  assert_null(protocols);
+
+    /* non-numerical protocol length */
+    i=
nfo_acc_msg =3D "abff A:6 flower:happy";
+    protocols =3D parse_acc_param=
eters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_null(protocols);=

+
+    /* extra parameter */
+    info_acc_msg =3D "1400 A:6 flower:happy =
77";
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, t=
rue, &gc);
+    assert_null(protocols);
+
+    gc_free(&gc);
+}
+
+void
+te=
st_acc_common_protocols(void **state)
+{
+    struct multi_instance mi =3D =
{ 0 };
+    struct context *c =3D &mi=2Econtext;
+    c->options=2Egc =3D g=
c_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_multi, struct tls_multi, &c-=
>options=2Egc);
+
+    c->c2=2Etls_multi->peer_info =3D "IV_PROTO=3D4321\nI=
V_ACC=3D1400,A:6,flower:happy:power";
+    c->options=2Eacc_protocols =3D "=
power:flower:star";
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+  =
  multi->opt=2Eacc_protocols =3D c->options=2Eacc_protocols;
+    multi->se=
ssion[TM_ACTIVE]=2Eopt =3D &multi->opt;
+    multi->opt=2Ees =3D env_set_cr=
eate(&c->options=2Egc);
+
+    determine_common_acc_protocols(multi, &c->c2=
=2Etls_multi->session[TM_ACTIVE]);
+
+    assert_int_equal(multi->acc_max_m=
essage_length, ACC_MAX_MSG_LEN);
+    assert_string_equal(multi->acc_negoti=
ated_protocols, "power:flower");
+
+    assert_string_equal(env_set_get(mul=
ti->opt=2Ees, "acc_protocols"), "acc_protocols=3Dpower:flower");
+    asser=
t_string_equal(env_set_get(multi->opt=2Ees, "acc_message_len"), "acc_messag=
e_len=3D1280");
+
+    free(multi->acc_negotiated_protocols);
+    gc_free(=
&c->options=2Egc);
+}
+
+void
+test_acc_send_message(void **state)
+{
+    =
struct multi_instance mi =3D { 0 };
+    struct context *c =3D &mi=2Econtex=
t;
+    c->options=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls=
_multi, struct tls_multi, &c->options=2Egc);
+    bool ret;
+    struct tls=
_multi *multi =3D c->c2=2Etls_multi;
+    c->options=2Eacc_protocols =3D "p=
ower:flower:emergency";
+    multi->opt=2Eacc_protocols =3D c->options=2Eac=
c_protocols;
+    multi->session[TM_ACTIVE]=2Eopt =3D &multi->opt;
+    mul=
ti->opt=2Ees =3D env_set_create(&c->options=2Egc);
+
+    c->c2=2Etls_multi=
->peer_info =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:power"=
;
+    determine_common_acc_protocols(multi, &c->c2=2Etls_multi->session[TM=
_ACTIVE]);
+
+    struct tls_session *session =3D &c->c2=2Etls_multi->sessi=
on[TM_ACTIVE];
+
+    ret =3D send_acc_message(c, c->c2=2Etls_multi, sessio=
n, "emergency", true,
+                           "EMERGENCY BROADCAST MESS=
AGE - THIS IS NOT A DRILL:", false);
+
+    assert_true(ret);
+    assert_s=
tring_equal(control_channel_mesage_sent,
+                        "ACC,emer=
gency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:");
+
+    re=
t =3D send_acc_message(c, c->c2=2Etls_multi, session, "emergency", false,
+=
                           "THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED AL=
ERT FOR YOUR AREA=2E", false);
+    assert_true(ret);
+    assert_string_eq=
ual(control_channel_mesage_sent,
+                        "ACC,emergency,65=
,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E");
+=

+
+    /* test a long message (> 1000) with fragment to get the maximum he=
ader size */
+    char long_message[1200] =3D { 0 };
+
+    for (int i =3D =
0; i < 1024; i++)
+    {
+        long_message[i] =3D (char)(' ' + (i % 95)=
);
+    }
+
+    /* last char of the message is a i and then a \0 */
+    a=
ssert_int_equal(long_message[1023], 'i');
+    assert_int_equal(long_messag=
e[1024], '\0');
+
+    ret =3D send_acc_message(c, c->c2=2Etls_multi, sessi=
on, "emergency", true,
+                           long_message, false);
+
=
+    assert_true(ret);
+    size_t cc_len =3D strlen(control_channel_mesage=
_sent);
+    assert_int_equal(control_channel_mesage_sent[cc_len - 1], 'i')=
;
+    const char *expected_start_cc =3D "ACC,emergency,1024,AF, !\"#$%&'()=
*+,-=2E/012345";
+    assert_memory_equal(control_channel_mesage_sent, expe=
cted_start_cc, strlen(expected_start_cc));
+
+    free(multi->acc_negotiate=
d_protocols);
+    gc_free(&c->options=2Egc);
+}
+
+void
+test_list_interse=
ction(void **state)
+{
+    const char *empty =3D "";
+    const char *prot=
os =3D "power:flower:emergency";
+
+    struct gc_arena gc =3D gc_new();
+
=
+    struct buffer t1 =3D get_list_intersection(&gc, empty, protos);
+    a=
ssert_int_equal(buf_len(&t1), 0);
+
+    struct buffer t2 =3D get_list_inte=
rsection(&gc, protos, empty);
+    assert_int_equal(buf_len(&t2), 0);
+
+  =
  struct buffer t3 =3D get_list_intersection(&gc, protos, protos);
+    ass=
ert_string_equal(buf_cstr(&t3), protos);
+
+    const char *protos2 =3D "fl=
ower:emergency:power:mario";
+    struct buffer t4 =3D get_list_intersectio=
n(&gc, protos2, protos);
+    assert_string_equal(buf_cstr(&t4), "flower:em=
ergency:power");
+
+    const char *protos3 =3D "super:paper:mario:flower";=

+    struct buffer t5 =3D get_list_intersection(&gc, protos2, protos3);
+ =
   assert_string_equal(buf_cstr(&t5), "flower:mario");
+
+    const char *p=
roto4 =3D "flower:flower:flower:flower";
+    struct buffer t6 =3D get_list=
_intersection(&gc, proto4, "flower");
+    assert_string_equal(buf_cstr(&t6=
), "flower");
+
+
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openv=
pn/test_acc=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh
new file mode 10064=
4
index 0000000=2E=2E32421fb
--- /dev/null
+++ b/tests/unit_tests/openvpn/t=
est_acc=2Eh
@@ -0,0 +1,35 @@
+/*
+ *  OpenVPN -- An application to securely=
 tunnel IP networks
+ *             over a single UDP port, with support fo=
r SSL/TLS-based
+ *             session authentication and key exchange,
+ =
*             packet encryption, packet authentication, and
+ *            =
 packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@=
openvpn=2Enet>
+ *
+ *  This program is free software; you can redistribute=
 it and/or modify
+ *  it under the terms of the GNU General Public License=
 version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  Th=
is program is distributed in the hope that it will be useful,
+ *  but WITH=
OUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY=
 or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Li=
cense for more details=2E
+ *
+ *  You should have received a copy of the G=
NU General Public License along
+ *  with this program; if not, see <https:=
//www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+
+#ifndef TEST_ACC_H
+#define TEST_=
ACC_H
+void test_acc_parse_client_messages(void **state);
+
+void test_pars=
e_acc_parameters(void **state);
+
+void test_acc_common_protocols(void **st=
ate);
+
+void test_acc_send_message(void **state);
+
+void test_list_inters=
ection(void **state);
+#endif
diff --git a/tests/unit_tests/openvpn/test_co=
mmon=2Eh b/tests/unit_tests/openvpn/test_common=2Eh
index 8db4ea6=2E=2Ec865=
142 100644
--- a/tests/unit_tests/openvpn/test_common=2Eh
+++ b/tests/unit_=
tests/openvpn/test_common=2Eh
@@ -43,11 +43,13 @@
 #define LargestIntegralT=
ype uintmax_t
 #endif
 /* redefine 2=2Ex API in terms of 1=2Ex API */
-#def=
ine CMockaValueData             LargestIntegralType
-#define check_expected=
_uint         check_expected
-#define expect_uint_value           expect_va=
lue
-#define expect_check_data           expect_check
-#define cast_ptr_to_=
cmocka_value(x) (x)
+#define CMockaValueData                       LargestI=
ntegralType
+#define check_expected_uint                   check_expected
+=
#define expect_uint_value                     expect_value
+#define expect_=
check_data                     expect_check
+#define cast_ptr_to_cmocka_val=
ue(x)           (x)
+#define assert_int_in_range(value, min, max)  assert_i=
n_range((value), (min), (max))
+#define assert_uint_in_range(value, min, ma=
x) assert_in_range((value), (min), (max))
 #endif
 
 /**
diff --git a/tests=
/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
in=
dex 4baf8cc=2E=2E4987dd0 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec=

+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -52,6 +52,8 @@
 #include "s=
sl_verify=2Eh"
 #include "openvpn=2Eh"
 
+#include "test_acc=2Eh"
+
 /* Moc=
k function to be allowed to include win32=2Ec which is required for
  * get=
ting the temp directory */
 #ifdef _WIN32
@@ -86,6 +88,20 @@
 {
     return=
;
 }
+void
+reschedule_multi_process(struct context *c)
+{
+}
+
+/* Define =
a dummy dco cipher option to avoid linking against all the DCO
+ * units */=

+#if defined(ENABLE_DCO)
+const char *
+dco_get_supported_ciphers(void)
+{=

+    return "AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY=
1305";
+}
+#endif
 
 /* generated using
  * openssl req -x509 -newkey ec -p=
keyopt ec_paramgen_curve:secp384r1 -keyout - \
@@ -1111,8 +1127,12 @@
     =
    cmocka_unit_test(ssl_test_extract_last_matching_field),
         cmocka=
_unit_test(ssl_test_reject_null_in_cert_subject),
         cmocka_unit_test=
(ssl_test_escape_rfc_2253_chars_in_subject),
-        cmocka_unit_test(ssl_=
test_extract_peer_info)
-
+        cmocka_unit_test(ssl_test_extract_peer_i=
nfo),
+        cmocka_unit_test(test_acc_parse_client_messages),
+        c=
mocka_unit_test(test_parse_acc_parameters),
+        cmocka_unit_test(test_=
acc_common_protocols),
+        cmocka_unit_test(test_acc_send_message),
+ =
       cmocka_unit_test(test_list_intersection)
     };
 
 #if defined(ENAB=
LE_CRYPTO_OPENSSL)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1858?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Ge=
rrit-PatchSet: 18
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=
=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--491SNW7Wz00=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe <strong>uploaded patch set #18</strong> to this change=2E</p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vie=
w Change</a></p><p>The following approvals got outdated and were removed:
C=
ode-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">Implement sending/rec=
eiving app custom control protocol messages<br><br>This allows openvpn GUI/=
front-ends and server via management<br>to use the OpenVPN control channel =
to pass messages between each other<br>while OpenVPN handles the marshallin=
g/unmarshalling of these and<br>negotiate the common app custom control pro=
tocols=2E<br><br>This provides an easy to use secure channel that does not =
depend on<br>the network itself to work and can also used before fully auth=
enticating<br>the client=2E See the management-notes=2Etxt for more details=
 how to use<br>this feature=2E An upcoming patch will also add some example=
 python<br>script that showcase this feature=2E<br><br>Change-Id: I4a6a6ef4=
1e15896b8b79d795b2a6de86b8ae4c84<br>Signed-off-by: Arne Schwabe &lt;arne@rf=
c2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/client-o=
ptions=2Erst<br>M doc/man-sections/management-options=2Erst<br>M doc/man-se=
ctions/script-options=2Erst<br>M doc/management-notes=2Etxt<br>M src/openvp=
n/Makefile=2Eam<br>A src/openvpn/acc=2Ec<br>A src/openvpn/acc=2Eh<br>M src/=
openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<b=
r>M src/openvpn/manage=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/opti=
ons=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/push=2Ec<br>M src/ope=
nvpn/push=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M=
 tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/mock_=
management=2Ec<br>M tests/unit_tests/openvpn/mock_push_dependencies=2Ec<br>=
A tests/unit_tests/openvpn/test_acc=2Ec<br>A tests/unit_tests/openvpn/test_=
acc=2Eh<br>M tests/unit_tests/openvpn/test_common=2Eh<br>M tests/unit_tests=
/openvpn/test_ssl=2Ec<br>26 files changed, 1,515 insertions(+), 23 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/58/1858/18</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CM=
akeLists=2Etxt</span><br><span>index 184a95a=2E=2E13bd1f0 100644</span><br>=
<span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><=
br><span>@@ -435,6 +435,8 @@</span><br><span>     src/compat/compat-strlcpy=
=2Ec</span><br><span>     src/compat/compat-strsep=2Ec</span><br><span>    =
 src/compat/compat-strtok_r=2Ec</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    src/openvpn/acc=2Ec</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    src/openvpn/acc=2Eh</span><br><span>     src/openvpn/ar=
gv=2Ec</span><br><span>     src/openvpn/argv=2Eh</span><br><span>     src/o=
penvpn/base64=2Ec</span><br><span>@@ -571,8 +573,8 @@</span><br><span>     =
src/openvpn/ps=2Ec</span><br><span>     src/openvpn/ps=2Eh</span><br><span>=
     src/openvpn/push=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    src/openvpn/push_util=2Ec</span><br><span>     src/openvpn/push=2Eh=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/pus=
h_util=2Ec</span><br><span>     src/openvpn/pushlist=2Eh</span><br><span>  =
   src/openvpn/reflect_filter=2Ec</span><br><span>     src/openvpn/reflect_=
filter=2Eh</span><br><span>@@ -826,7 +828,10 @@</span><br><span>           =
  tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>            =
 tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec</span><br><span>       =
      tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/test=
_acc=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 src/openvpn/acc=2Ec</span><br><span>             src/openvpn/argv=2Ec</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/=
auth_token=2Ec</span><br><span>             src/openvpn/base64=2Ec</span><b=
r><span>             src/openvpn/crypto_epoch=2Ec</span><br><span>         =
    src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -840,8 +845,11 @@</sp=
an><br><span>             src/openvpn/options_util=2Ec</span><br><span>    =
         src/openvpn/otime=2Ec</span><br><span>             src/openvpn/pac=
ket_id=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   src/openvpn/reliable=2Ec</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            src/openvpn/session_id=2Ec</span><br><span>            =
 src/openvpn/run_command=2Ec</span><br><span>             src/openvpn/ssl_m=
bedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   src/openvpn/ssl_ncp=2Ec</span><br><span>             src/openvpn/ssl_ope=
nssl=2Ec</span><br><span>             src/openvpn/ssl_util=2Ec</span><br><s=
pan>             src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>diff --=
git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-optio=
ns=2Erst</span><br><span>index 87c138a=2E=2Eb204d6a 100644</span><br><span>=
--- a/doc/man-sections/client-options=2Erst</span><br><span>+++ b/doc/man-s=
ections/client-options=2Erst</span><br><span>@@ -12,6 +12,17 @@</span><br><=
span>   When this option is set, OpenVPN will not drop incoming tun packets=
 with</span><br><span>   same destination as host=2E</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+--app-custom-control pro=
tocollist</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Sets the=
 list of supported app custom control protocols=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  These protocols are announced to the serve=
r when this option is used</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  as a client=2E If the option is set on a server it will negotiate =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  common protoco=
ls with the client=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The protocollis=
t is a : separated list of protocol identifiers=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  See management-notes=2Etxt in the OpenVPN distribution and th=
e OpenVPN RFC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  draf=
t for a description of app custom control protocol support=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --auth-token to=
ken</span><br><span>   This is not an option to be used directly in any con=
figuration files,</span><br><span>   but rather push this option from a ``-=
-client-connect`` script or a</span><br><span>@@ -437,6 +448,12 @@</span><b=
r><span>         Additional authentication methods supported by the client=
=2E</span><br><span>         This may be set by the client UI/GUI using ``-=
-setenv``=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  :code:`IV_ACC=3D&lt;max_msg_len&gt;,&lt;flags&gt;,&lt;protocol=
s&gt;`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        If th=
e option ``--app-custom-control`` is set, the client will</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        send the supported max ACC me=
ssage length, the supported formats</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        as (:code:`A:6`) and the list of configured protoco=
ls (e=2Eg=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 :code:`flower:happy:power`)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>   The following flags depend on which compressio=
n formats are compiled in</span><br><span>   and whether compression is all=
owed by options=2E See `Protocol options`_</span><br><span>   for more deta=
ils=2E</span><br><span>diff --git a/doc/man-sections/management-options=2Er=
st b/doc/man-sections/management-options=2Erst</span><br><span>index 2c79d0=
5=2E=2Ea7f7ead 100644</span><br><span>--- a/doc/man-sections/management-opt=
ions=2Erst</span><br><span>+++ b/doc/man-sections/management-options=2Erst<=
/span><br><span>@@ -144,3 +144,9 @@</span><br><span> </span><br><span> --ma=
nagement-up-down</span><br><span>   Report tunnel up/down events to managem=
ent interface=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+--app-custom-control p=
rotocol-list</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Sets =
the app custom control protocols that are supported and should be</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  negotiated=2E protocol-list=
 is a list of allowed protocols separated by :</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  A client will announce these protocols via the=
 IV_ACC variable and the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  server will notify the client about the common protocols=2E</span><b=
r><span>diff --git a/doc/man-sections/script-options=2Erst b/doc/man-sectio=
ns/script-options=2Erst</span><br><span>index f420380f=2E=2E9c17c3b 100644<=
/span><br><span>--- a/doc/man-sections/script-options=2Erst</span><br><span=
>+++ b/doc/man-sections/script-options=2Erst</span><br><span>@@ -1006,3 +10=
06,12 @@</span><br><span>        X509_1_L=3DBISHKEK</span><br><span>       =
 X509_1_ST=3DNA</span><br><span>        X509_1_C=3DKG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+:code:`acc_protocols`</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    If ``--app-custom-control`` is configured and the clie=
nt supports any of the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    protocols that server also supports, this variable contains a list o=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    common protoco=
ls separated by :=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+:code:`acc_message=
_len`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if :code:`=
acc_protocols` is set, this variable contains the maximum</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    message length for app custom pro=
tocol message=2E</span><br><span>\ No newline at end of file</span><br><spa=
n>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</spa=
n><br><span>index 4d726c4=2E=2Ec255d1d 100644</span><br><span>--- a/doc/man=
agement-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</span>=
<br><span>@@ -828,6 +828,58 @@</span><br><span> that is required to continu=
e the connection (unlike MFA or opening a browser)</span><br><span> this me=
ssage is not negotiated but can just be sent as a gratuitous message=2E</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+app c=
ustom control</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+If the special string &quot;ACC&quot; is passe=
d as {EXTRA} OpenVPN will determine</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+the common app custom protocols between the client and the =
server and instruct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
the client that the server will send control messages to the client using</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+the ACC protocol=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+The server should then use client-acc-ms=
g command to send app custom</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+control messages to the client to facilitate the pending authentic=
ation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+COMMAND -- client-acc-msg (Ope=
nVPN 2=2E8 or higher)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+------------------------------------------</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+On an OpenVPN instance running in server mode this command sends an</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+app custom control me=
ssage to a client=2E The format of the command is:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  client-acc-msg {CID} {KID}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  {protocol}</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  {flags}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  {message}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  EN=
D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+CID,KID -- client ID and Key ID=2E Se=
e documentation for &quot;&gt;CLIENT:&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+notification for more info=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+protocol -- the ACC protocol identifier that this message sh=
ould be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
tagged with=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+flags    -- a colon sepa=
rated list of the encoding and the flag if</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            the message is a fragment=2E E=2Eg=2E &q=
uot;6:F&quot; for a base64 encoded</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            message that is also a fragment and not complete=
 yet=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+message  -- The message encoded=
 in the encoding specified in flags</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+COMMAND -- acc-msg (Op=
enVPN 2=2E8 or higher)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+------------------------------------------</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+When OpenVPN is running in --client mode this command sends an app</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+custom command to the=
 server=2E The format of the command is</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  acc-msg</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {protoc=
ol}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {flags}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  {message}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  END</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+See the client-acc-msg command for more details about the format of=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+message=2E Sinc=
e a client has only one peer there is no need to specify the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+client id and key id=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> COMMAND -- client-deny  (OpenVP=
N 2=2E1 or higher)</span><br><span> ---------------------------------------=
--------</span><br><span> </span><br><span>@@ -1302,6 +1354,46 @@</span><br=
><span>    response=2E Mechanisms that need multiple rounds or more complex=
 answers</span><br><span>    should implement a different response type tha=
n CR_RESPONSE=2E</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+(6) App custom control message</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    This message is an application specific payload message that is =
transported</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    over=
 the OpenVPN control channel=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    In =
server mode:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;CLIENT:ACC,{CID},{=
KID},{protocol},{fragment},{msg_base64}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    In client mode:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;ACC:{proto=
col},{fragment},{msg_base64}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    The pr=
otocol is a short ascii string identifying the app specific custom</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    protocol=2E If fragment =
is set to 1, the message is not complete and the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    next message should be concatenated to thi=
s message to form a complete</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    message=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Note that t=
he OpenVPN implementation operates here with the robustness</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    principle (&quot;be conservativ=
e in what you send, be liberal in what you</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    accept&quot; - RFC 793 and others) and allows re=
ceiving messages longer than</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    maximum allowed message length=2E Implementations should be pr=
epared to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    handle=
 messages that are longer than the maximum allowed message length=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+(7) App custom control protocol message</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+   This message informs the client about the common ACC</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+   protocols and the maximu=
m message length for an ACC message=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
   In client mode:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+   &gt;ACC_PROTOCOLS=
:protocols=3D{protocol_list},message_len=3D{max_msg_len}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+   protocol_list is a list of supported protocols by the =
client=2E For example</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+   flower:power:sys_info would indicate these three protocols to be suppo=
rted=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   max_msg_l=
en specifies the maximum message length that the peer supports=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+   In server mode these are available in the acc=
_protocols and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   ac=
c_message_len variables of the client environment=2E</span><br><span> </spa=
n><br><span> Variables:</span><br><span> </span><br><span>diff --git a/src/=
openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 8a6=
0a94=2E=2Eebc4db6 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</s=
pan><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -45,6 +45,=
7 @@</span><br><span> sbin_PROGRAMS =3D openvpn</span><br><span> </span><br=
><span> openvpn_SOURCES =3D \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	acc=2Ec acc=2Eh \</span><br><span> 	argv=2Ec argv=2Eh \</span><b=
r><span> 	auth_token=2Ec auth_token=2Eh \</span><br><span> 	base64=2Ec base=
64=2Eh \</span><br><span>@@ -124,7 +125,8 @@</span><br><span> 	proto=2Ec pr=
oto=2Eh \</span><br><span> 	proxy=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec =
ps=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	push=2Ec pus=
h_util=2Ec push=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	push=2Ec push=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	push_util=2Ec \</span><br><span> 	pushlist=2Eh \</span><br><span> 	refl=
ect_filter=2Ec reflect_filter=2Eh \</span><br><span> 	reliable=2Ec reliable=
=2Eh \</span><br><span>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=
=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2Efe080e5</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/=
acc=2Ec</span><br><span>@@ -0,0 +1,438 @@</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single =
TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             session authentication and key exch=
ange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet encryption, packet authentication, and</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@ope=
nvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  C=
opyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  This program is free software; you can redistribute it and/or modif=
y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the t=
erms of the GNU General Public License version 2</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundati=
on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed=
 in the hope that it will be useful,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied war=
ranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHAN=
TABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for mor=
e details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have rece=
ived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to t=
he Free Software Foundation, Inc=2E,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301=
 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;forward=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;opti=
ons_util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;ssl_util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+enum acc_message_flag</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ACC_MESSAGE_FLAGS_ASCII =3D 1,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ACC_MESSAGE_FLAGS_BASE64 =3D 2,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+log_acc_mes=
sage(struct context *c, const struct buffer *buf, int payload_len,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                const char *=
protocol, int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool fragment=
 =3D flags &amp; ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *payload_msg =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* For simplicity, we alw=
ays encode payload to be base64 encoded</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * if not already in base64 format */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; ACC_MESSAGE_F=
LAGS_ASCII)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *b64out =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        AS=
SERT(openvpn_base64_encode(CBPTR(buf), payload_len, &amp;b64out) &gt;=3D 0)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_addspec=
ial(b64out, free, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        payload_msg =3D b64out;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        payload_msg=
 =3D CBSTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (management)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct tls_session *session =3D &amp;c-&gt=
;c2=2Etls_multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (c-&gt;options=2Emode =3D=3D MODE_SERVER)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* server mode=2E Report client context=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            stru=
ct man_def_auth_context *mda =3D session-&gt;opt-&gt;mda_context;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            unsigned int mda_=
key_id =3D get_primary_key(c-&gt;c2=2Etls_multi)-&gt;mda_key_id;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quo=
t;&gt;CLIENT:ACC,%lu,%u,%s,%d,%s&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                mda-&gt;cid, mda_key_id, protocol, frag=
ment, payload_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Client mode=
=2E Do not a report a CLIENT id */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;ACC:%s,%d,%s&quot;, prot=
ocol, fragment, payload_msg);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if=
def ENABLE_MANAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    msg(D_PUSH, &quot;Received custom app control message (protocol &#=
39;%s&#39;%s)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        protocol, fragment ? &quot;, fragment&quot; : &quot;&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Parses the flags=
 field of an app control message and moves the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  buffer past the flags string=2E If there is =
an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  error parsing=
 the flags field the method returns -1 and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  puts the error reason in err_reason</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+parse_acc_message_flags(struct buffer *buf, const char **=
err_reason, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *flags =3D buf_extract_field(buf, &#39;,&#39;, gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!flags)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        *err_reason =3D &quot;could not extract flags field&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int acc_flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const =
char *flag =3D flags; *flag !=3D &#39;\0&#39;; flag++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (*flag =3D=3D &#39;A&#39;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_A=
SCII;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (*flag =
=3D=3D &#39;6&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        else if (*flag =3D=3D &#39;F&#39;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_FRAG=
MENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            *err_reason =3D &quot;Unknown=
 flag in flags&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The message =
should be encoded with exactly one encoding=2E Ensure that</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * only one of the flags is pres=
ent */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool asci=
ienc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_ASCII);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    bool base64enc =3D (bool)(acc_fla=
gs &amp; ACC_MESSAGE_FLAGS_BASE64);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (base64enc + asciienc !=3D 1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        char *tmp =3D gc_malloc(512, 1, gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        snprintf(tmp, 512, &quot;number of encodin=
gs must be exactly one &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                           &quot;(B64=3D%d, ASCII=3D%d)&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                 base6=
4enc, asciienc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     *err_reason =3D tmp;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return acc_flags;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+receive_acc_message(st=
ruct context *c, const struct buffer *buffer)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const char *err_reason =3D &quot;&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* Example message: ACC,muppets,15,A,I a=
m Miss Piggy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer buf =3D *buffer;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_protoco=
ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;A=
CC not enabled or no negotiated protocols&quot;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!buf_advance(&amp;buf, strlen(&quot;ACC&quot;)) || buf_read_u8(&amp;buf) =
!=3D &#39;,&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reas=
on =3D &quot;missing , after ACC&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* extract =
protocol, payload length, flags substrings */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *protocol =3D buf_extract_field(&a=
mp;buf, &#39;,&#39;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!protocol)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    err_reason =3D &quot;could not extract protocol field&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!tls_item_in_cipher_list(protocol, multi-&gt;acc_negotiat=
ed_protocols))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buff=
er msg_buf =3D alloc_buf_gc(1024, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        buf_printf(&amp;msg_buf, &quot;protocol &#3=
9;%s&#39; not in list of negotiated protocols &#39;%s&#39;&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                   protocol, =
multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        err_reason =3D buf_cstr(&amp;msg_buf);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* We do not check the le=
ngth here=2E We make no promises to support</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * anything larger than our announced message l=
ength but according to</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * the robustness principle</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * (&quot;be conservative in what you send, be liberal i=
n what you accept&quot; - RFC 793 and others)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * we accept also longer messages */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int payload_len;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *payload_len_str =3D buf_extrac=
t_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!payload_len_str || !((payload_len =3D atoi(pa=
yload_len_str))))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reas=
on =3D &quot;could not extract payload length field&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int flags =3D parse_acc_message_flags(&amp;buf, &amp;err_reason, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &lt; 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* We should have a final NUL byte in the control message buffer</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and thus the lengt=
h of the buffer should be payload_len + 1 */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (buf_len(&amp;buf) !=3D payload_len + 1)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        char *tmp =3D gc_malloc(512,=
 1, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  snprintf(tmp, 512, &quot;field length %d, payload length %d mismatch&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
payload_len, buf_len(&amp;buf) - 1);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        err_reason =3D tmp;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    log_acc_message(c, &amp;b=
uf, payload_len, protocol, flags);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+err:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH_ERRORS, &q=
uot;WARNING: Received malformed custom app control channel &quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                       &quot;=
message (%s): %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        err_reason,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        format_hex(BPTR(&amp;buf), BLEN(&amp;buf), 80, &amp;gc));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_acc_message(st=
ruct context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
              struct tls_multi *multi,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                 struct tls_session *session,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                 const char *p=
rotocol, bool fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                 const char *msg, bool base64)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * length of the protocol string + one &#39;,&#39;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * 2 for the encoding (A or 6), pote=
ntial F (fragment), and 1 for the &#39;,&#39;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * 4 for the message size itself and one com=
ma</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 1 for the =
comma before the message itself */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const size_t max_header_size =3D strlen(&quot;ACC,&quot;=
) + strlen(protocol) + 1 + 4 + 1 + 2 + 1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    size_t len =3D max_header_size + strlen(msg);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
, strlen(msg), len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            multi-&gt;acc_max_message_length);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* add 1 for the final \0 */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(len + 1, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* Example message: ACC,mu=
ppets,15,A,I am Miss Piggy */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buf_printf(&amp;buf, &quot;ACC,%s,%zu,%s%s,%s&quot;, protocol=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               str=
len(msg),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
     base64 ? &quot;6&quot; : &quot;A&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+               fragment ? &quot;F&quot; : &quot;&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
 msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    send_control_channel_string_=
dowork(session, BSTR(&amp;buf), D_PUSH);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    reschedule_multi_process(c);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cha=
r *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_parame=
ters(const char *capabilities,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                     const char *delim,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                     int *max_acc_len,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                     bool=
 server,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
          struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cha=
r *tmp_message =3D string_alloc(capabilities, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char *tmp_message_orig =3D tmp_messag=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char *token =3D str=
tok_r(tmp_message, delim, &amp;lasts);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int p =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int acclen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const char *protocols =3D NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char *ret =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* In server mode we allow more capabilities than our own, in client</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * mode we reject =
if we should use capabilities that we do not support */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int allowed_acc_len =3D server ? IN=
T_MAX : ACC_MAX_MSG_LEN;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (tok=
en)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 0 &amp;&a=
mp; !atoi_constrained(token, &amp;acclen, &quot;ACC message length&quot;, A=
CC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            goto done;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (p =3D=3D 1 &amp;&amp; (!tls_item_in_cipher_list(&quot;A&quot;, token) =
|| !tls_item_in_cipher_list(&quot;6&quot;, token)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;App custom con=
trol encoding must include base64 and ascii&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (p =3D=3D 1 &amp;&amp; !server &amp;&amp; strcmp(token, =
&quot;A:6&quot;) &amp;&amp; strcmp(token, &quot;6:A&quot;))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;App cust=
om control encoding must exactly base64 and ascii&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (p =3D=3D 2)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            protocols =3D token;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (p =3D=3D 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(=
D_PUSH_ERRORS, &quot;Too many parameters for INFO ACC message/IV_ACC=2E&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            got=
o done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        token =3D strtok_r(NULL, delim, &=
amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
p++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG=
_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D s=
tring_alloc(protocols, gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+done:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(tmp_message_orig=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+struct buffer</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+get_list_intersection(struct gc_arena *gc, const char *list1, co=
nst char *list2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *tmp =3D str=
dup(list1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char=
 *lasts =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *token =3D strtok_r(tmp, &quot;:&quot;, &amp;lasts);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* The maximum possible length is the shorte=
r of the two input lists */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    size_t max_len =3D min_size(strlen(list1), strlen(list2));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer common_protocols =3D al=
loc_buf_gc(max_len + 1, gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while =
(token)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* check for every=
 items is in both lists and not already in the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * common list */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (tls_item_in_cipher_list(token=
, list2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 &amp;&amp; !tls_item_in_cipher_list(token, buf_cstr(&amp;common_protocols)=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (buf_len(&am=
p;common_protocols) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                buf_write_u8(&amp;common_protocols, &#39;:&#39;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;commo=
n_protocols, &quot;%s&quot;, token);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        token =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free(tmp);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return common_protocols;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+determine_comm=
on_acc_protocols(struct tls_multi *multi, struct tls_session *session)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;opt=2Eacc_protocols)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* No app custom protocols =
have been configured server-side=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;=
acc_negotiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* We already have determined the common protocols=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* example IV_ACC: IV_ACC=3D2048,6:A,flower:power */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *peer_info =3D multi-&gt=
;peer_info;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *iv_acc =3D extract_var_peer_info(peer_info, &quot;IV_ACC=3D&quot;, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!i=
v_acc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int max_acc_len =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const char *protocols =3D parse_acc_parameters(=
iv_acc, &quot;,&quot;, &amp;max_acc_len, true, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!protocols)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(D_PUSH_ERRORS, &quot;WARNING: IV_ACC peer info variab=
le of peer is malformed&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer common_=
protocols =3D get_list_intersection(&amp;gc, session-&gt;opt-&gt;acc_protoc=
ols, protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;c=
ommon_protocols) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(D_PUSH_DEBUG, &quot;WARNING: No common app custom control protocol=2E&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;acc_negotiated_protocols =
=3D string_alloc(buf_str(&amp;common_protocols), NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;acc_max_message_length =
=3D max_acc_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(session=
-&gt;opt-&gt;es, &quot;acc_protocols&quot;, multi-&gt;acc_negotiated_protoc=
ols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_int=
(session-&gt;opt-&gt;es, &quot;acc_message_len&quot;, multi-&gt;acc_max_mes=
sage_length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff =
--git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span><br><span>new file =
mode 100644</span><br><span>index 0000000=2E=2E4a388f7</span><br><span>--- =
/dev/null</span><br><span>+++ b/src/openvpn/acc=2Eh</span><br><span>@@ -0,0=
 +1,105 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applicat=
ion to securely tunnel IP networks</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             over a single TCP/UDP port, with support for =
SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         session authentication and key exchange,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             packet encryption, packet auth=
entication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
           packet compression=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe =
&lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free so=
ftware; you can redistribute it and/or modify</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public =
License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  as published by the Free Software Foundation=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  This program is distributed in the hope that it will be us=
eful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOU=
T ANY WARRANTY; without even the implied warranty of</span><br><span style=
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
/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 1b8b2a5=2E=
=2Ecfcd5b7 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><spa=
n>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2279,6 +2279,13 @@</span><=
br><span>         }</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-=
&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (multi &amp;&amp; multi-&gt;acc_negotiated_protocols)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot; custom-contr=
ol %d,A:6,%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                   multi-&gt;acc_max_message_length, multi-&gt;acc_negotiat=
ed_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   if (BLENZ(&amp;out) &gt; strlen(header))</span><br><span>     {</span><b=
r><span>         msg(D_HANDSHAKE, &quot;%s&quot;, BSTR(&amp;out));</span><b=
r><span>@@ -2522,6 +2529,11 @@</span><br><span>         flags |=3D (OPT_P_R=
OUTE | OPT_P_DHCPDNS);</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_pro=
tocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D OPT_P_A=
CC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return f=
lags;</span><br><span> }</span><br><span> </span><br><span>@@ -2730,6 +2742=
,17 @@</span><br><span>         frame-&gt;tun_mtu =3D min_int(frame-&gt;tun=
_max_mtu, c-&gt;options=2Ece=2Etun_mtu);</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (found=
 &amp; OPT_P_ACC &amp;&amp; c-&gt;options=2Epushed_acc_negotiated_protocols=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *multi =
=3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        free(multi-&gt;acc_negotiated_protocols);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;acc_negotiated_protoc=
ols =3D string_alloc(c-&gt;options=2Epushed_acc_negotiated_protocols, NULL)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;=
acc_max_message_length =3D c-&gt;options=2Epushed_acc_max_message_length;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH, &quot;OPTIONS IMPORT=
: ACC protocols: %s, msg len: %d&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            multi-&gt;acc_negotiated_protocols, multi-&=
gt;acc_max_message_length);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     return true;</span><br><span> }</span><br><span> </span><br=
><span>@@ -3352,6 +3375,7 @@</span><br><span>     to=2Everify_hash_depth =
=3D options-&gt;verify_hash_depth;</span><br><span>     to=2Everify_hash_no=
_ca =3D options-&gt;verify_hash_no_ca;</span><br><span>     memcpy(to=2Ex50=
9_username_field, options-&gt;x509_username_field, sizeof(to=2Ex509_usernam=
e_field));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2E=
acc_protocols =3D options-&gt;acc_protocols;</span><br><span>     to=2Ees =
=3D c-&gt;c2=2Ees;</span><br><span>     to=2Enet_ctx =3D &amp;c-&gt;net_ctx=
;</span><br><span> </span><br><span>@@ -4306,6 +4330,24 @@</span><br><span>=
 }</span><br><span> #endif /* ifdef TARGET_ANDROID */</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+management_acc_msg(void *arg,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   st=
ruct buffer_list *input) /* ownership transferred */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct context *c =3D arg;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (buffer_list_defined(input) &amp;&amp; c-&gt;c2=2Etls_mu=
lti)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *mul=
ti =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        struct tls_session *session =3D &amp;multi-&gt;session[TM_=
ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D management_sen=
d_acc_message(c, multi, session, input);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_l=
ist_free(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><b=
r><span> void</span><br><span>@@ -4322,6 +4364,7 @@</span><br><span>       =
  cb=2Eproxy_cmd =3D management_callback_proxy_cmd;</span><br><span>       =
  cb=2Eremote_cmd =3D management_callback_remote_cmd;</span><br><span>     =
    cb=2Esend_cc_message =3D management_callback_send_cc_message;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cb=2Eacc_msg =3D mana=
gement_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</span><br><span>    =
     cb=2Enetwork_change =3D management_callback_network_change;</span><br>=
<span> #endif</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/ope=
nvpn/manage=2Ec</span><br><span>index ac3d4b7=2E=2E5e4e416 100644</span><br=
><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manag=
e=2Ec</span><br><span>@@ -45,9 +45,11 @@</span><br><span> #include &quot;pu=
sh=2Eh&quot;</span><br><span> #include &quot;multi=2Eh&quot;</span><br><spa=
n> #include &quot;resolve=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br><s=
pan> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;run_co=
mmand=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;ssl_ncp=2Eh&quot;</span><br><span> </span><br><span> #ifdef ENAB=
LE_PKCS11</span><br><span> #include &quot;pkcs11=2Eh&quot;</span><br><span>=
@@ -1081,6 +1083,35 @@</span><br><span>             }</span><br><span>     =
        break;</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        case IEC_CLIENT_ACC_MSG:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            if (man-&gt;persist=2Ecallback=2Eclie=
nt_acc_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  bool status =3D (*man-&gt;persist=2Ecallback=2Eclient_acc_msg)(man-&gt;pe=
rsist=2Ecallback=2Earg,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                                                      m=
an-&gt;connection=2Ein_extra_cid,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                                             =
         man-&gt;connection=2Ein_extra_kid,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                                   =
                   man-&gt;connection=2Ein_extra);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                man-&gt;connection=2Ein_extr=
a =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        report_command_status(status, &quot;client-acc-msg&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                man_command_unsupported(&=
quot;client-acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case IEC_A=
CC_MSG:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (man-&gt;persist=2Ecallback=2Eacc_msg)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                bool status =3D (*man-&gt;persist=2Ecallbac=
k=2Eacc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                                =
               man-&gt;connection=2Ein_extra);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                man-&gt;connection=2Ein_extra =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      report_command_status(status, &quot;acc-msg&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                man_command_unsupported(&quot;acc-=
msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            br=
eak;</span><br><span>         case IEC_PK_SIGN:</span><br><span>           =
  man-&gt;connection=2Eext_key_state =3D EKS_READY;</span><br><span>       =
      buffer_list_free(man-&gt;connection=2Eext_key_input);</span><br><span=
>@@ -1205,6 +1236,29 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_c=
lient_acc_msg(struct management *man, const char *cid_str,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                   const char *kid_s=
tr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *mc =3D =
&amp;man-&gt;connection;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    mc-&gt;in_extra_cid =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    mc-&gt;in_extra_kid =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (parse_cid(cid_str, &amp;mc-&gt;in_extra_=
cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&a=
mp; parse_uint(kid_str, &quot;KID&quot;, &amp;mc-&gt;in_extra_kid))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        mc-&gt;in_extra_cmd =3D IEC_CLIEN=
T_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
n_extra_reset(mc, IER_NEW);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+man_acc_msg(struct management *man)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct man_connection *mc =3D &amp;man-&gt;conn=
ection;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;i=
n_extra_cmd =3D IEC_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    in_extra_reset(mc, IER_NEW);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span> man_client_auth(struct management *man, const char *cid_str, =
const char *kid_str, const bool extra)</span><br><span> {</span><br><span> =
    struct man_connection *mc =3D &amp;man-&gt;connection;</span><br><span>=
@@ -1759,6 +1813,17 @@</span><br><span>             man_client_pending_auth=
(man, p[1], p[2], p[3], p[4]);</span><br><span>         }</span><br><span> =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (s=
treq(p[0], &quot;client-acc-msg&quot;))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (man_need(p, 2, 0))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            man_client_acc_msg(man, p[1], p[2]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (streq(p[0], &quot;acc-msg&quot;))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        man_acc_msg(man);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq(p[=
0], &quot;rsa-sig&quot;))</span><br><span>     {</span><br><span>         m=
an_pk_sig(man, &quot;rsa-sig&quot;);</span><br><span>@@ -2975,7 +3040,9 @@<=
/span><br><span>                                        &quot;bytes_sent=3D=
&quot;,</span><br><span>                                        &quot;bytes=
_received=3D&quot;,</span><br><span>                                       =
 &quot;session_id=3D&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                       &quot;session_state=3D&quot; }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                     &quot;session_state=3D&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                       &quot=
;acc_protocols=3D&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                       &quot;acc_message_len=3D&quot; =
};</span><br><span> </span><br><span>     if (env_filter_level =3D=3D 0)</s=
pan><br><span>     {</span><br><span>@@ -3130,6 +3197,7 @@</span><br><span>=
     }</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> management_=
connection_established(struct management *man, struct man_def_auth_context =
*mdac,</span><br><span>                                   const struct env_=
set *es)</span><br><span>@@ -4372,6 +4440,64 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ma=
nagement_send_acc_message(struct context *c, struct tls_multi *multi, struc=
t tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                            struct buffer_list *input)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* also ensures that are enough inputs in the list=
 to safely call</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * buffer_list_peek without extra NULL checks */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!input || input-&gt;size &lt; 3)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;not enough =
input lines for sending acc message, &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                      &quot;missing protocol, flag =
and/or messages lines&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer=
 *proto_buf =3D buffer_list_peek(input);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *protocol =3D string_alloc(CBSTR(proto_=
buf), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
buffer_list_pop(input);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er *encoding_buf =3D buffer_list_peek(input);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    char *encoding =3D buf_str(encoding_buf);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *flag =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool b=
64encoding =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool fragment =3D false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    whil=
e ((flag =3D strsep(&amp;encoding, &quot;:&quot;)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!strcmp(flag, &quot;6&quot;))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
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
options=2Ec</span><br><span>index fb319ae=2E=2Ebb854da 100644</span><br><sp=
an>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=
=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><span> </span><br><span> #=
include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span>=
 #include &quot;buffer=2Eh&quot;</span><br><span> #include &quot;error=2Eh&=
quot;</span><br><span> #include &quot;common=2Eh&quot;</span><br><span>@@ -=
7107,6 +7108,41 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL=
);</span><br><span>         options-&gt;force_key_material_export =3D true;=
</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else if (streq(p[0], &quot;app-custom-control&quot;) &amp;&amp; p[1=
] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY=
_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, =
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
an>index 42259c3=2E=2Ec4c4cd4 100644</span><br><span>--- a/src/openvpn/push=
=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -27,6 +2=
7,8 @@</span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> <=
/span><br><span> #include &quot;push=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;option=
s=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><spa=
n> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -221,9 +223,61 @@</span>=
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
      return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* check if the list from the serve=
r is a real subset of our list */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct buffer common_list =3D get_list_intersection(&amp;=
gc, protocols, multi-&gt;opt=2Eacc_protocols);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (buf_len(&amp;common_list) =3D=3D 0 || !streq(protocols, buf=
_cstr(&amp;common_list)))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(D_PUSH_ERRORS, &quot;App custom control list from server contains &quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
         &quot;unsupported protocols&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mu=
lti-&gt;acc_negotiated_protocols =3D string_alloc(protocols, NULL);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;acc_max_messa=
ge_length =3D max_acc_len;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABL=
E_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT,=
 &quot;&gt;ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d&quot;, protocols, =
max_acc_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><=
span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-server_push=
ed_info(const struct buffer *buffer, const int adv)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+server_pushed_info(struct context *c, con=
st struct buffer *buffer, const int adv)</span><br><span> {</span><br><span=
>     const char *m =3D &quot;&quot;;</span><br><span>     struct buffer bu=
f =3D *buffer;</span><br><span>@@ -233,6 +287,12 @@</span><br><span>       =
  m =3D BSTR(&amp;buf);</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (strncmp(m, &quot;ACC:&=
quot;, 4) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        parse_=
server_pushed_info_acc(c, &amp;buf);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     struct gc_ar=
ena gc;</span><br><span>     if (management)</span><br><span>@@ -285,6 +345=
,7 @@</span><br><span>     msg(D_PUSH, &quot;CR response was sent by client=
 (&#39;%s&#39;)&quot;, m);</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br=
><span>  * Parse the keyword for the AUTH_PENDING request</span><br><span> =
 * @param buffer                buffer containing the keywords, the buffer&=
#39;s</span><br><span>@@ -441,7 +502,6 @@</span><br><span>     const char *=
const peer_info =3D tls_multi-&gt;peer_info;</span><br><span>     unsigned =
int proto =3D extract_iv_proto(peer_info);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Calculate t=
he maximum timeout and subtract the time we already waited */</span><br><sp=
an>     unsigned int max_timeout =3D</span><br><span>         max_uint(tls_=
multi-&gt;opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2Ehandshake_wind=
ow);</span><br><span>@@ -732,6 +792,12 @@</span><br><span>                 =
client_max_mtu, o-&gt;ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</span><br><span>  =
       }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(tls_multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        push_option_fmt(gc, push_list, M_USAGE, &quot;custom-control=
 %d A:6 %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      tls_multi-&gt;acc_max_message_length, tls_multi-&gt;a=
cc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span> }</span><br><span> </span><br><span> static bo=
ol</span><br><span>diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh=
</span><br><span>index 39302f6=2E=2Eb6695bc 100644</span><br><span>--- a/sr=
c/openvpn/push=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh</span><br><sp=
an>@@ -52,6 +52,7 @@</span><br><span> </span><br><span> int process_incomin=
g_push_request(struct context *c);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 @brief Handles the receiving of a push-update message and applies updates =
to the specified</span><br><span>  * options=2E</span><br><span>@@ -92,7 +9=
3,7 @@</span><br><span> </span><br><span> void receive_exit_message(struct =
context *c);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void server_pushed_info(const struct buffer *buffer, const int adv=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void server_pushe=
d_info(struct context *c, const struct buffer *buffer, const int adv);</spa=
n><br><span> </span><br><span> void receive_cr_response(struct context *c, =
const struct buffer *buffer);</span><br><span> </span><br><span>diff --git =
a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 086a6fc=
=2E=2Ee84d32d 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><s=
pan>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -55,6 +55,7 @@</span><br><=
span> </span><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br><sp=
an> #include &quot;ssl=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;s=
sl_verify=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh&quot;</=
span><br><span> #include &quot;ssl_ncp=2Eh&quot;</span><br><span>@@ -1279,6=
 +1280,7 @@</span><br><span>     free(multi-&gt;locked_cn);</span><br><span=
>     free(multi-&gt;locked_username);</span><br><span>     free(multi-&gt;=
locked_original_username);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    free(multi-&gt;acc_negotiated_protocols);</span><br><span> </spa=
n><br><span>     cert_hash_free(multi-&gt;locked_cert_hash_set);</span><br>=
<span> </span><br><span>@@ -2117,6 +2119,11 @@</span><br><span>            =
         }</span><br><span>                 }</span><br><span>             =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (session-&gt;opt-&gt;a=
cc_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    buf_printf(&amp;out, &quot;IV_ACC=3D%d,6:A,%s\n&quot;, ACC_MAX_MSG_LEN,=
 session-&gt;opt-&gt;acc_protocols);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            }</span><br><span>         }</span><br><span> =
    }</span><br><span> </span><br><span>@@ -2398,6 +2405,8 @@</span><br><sp=
an>         multi-&gt;remote_ciphername =3D string_alloc(&quot;none&quot;, =
NULL);</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    determine_common_acc_protocols(multi, sessi=
on);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>     if (username_len &lt; 0 || password_len &lt; 0)</span><br><span>    =
 {</span><br><span>         msg(D_TLS_ERRORS, &quot;TLS Error: Username (%d=
) or password (%d) too long&quot;, abs(username_len),</span><br><span>diff =
--git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><=
span>index 9a55ead=2E=2E436770b 100644</span><br><span>--- a/src/openvpn/ss=
l_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><sp=
an>@@ -457,6 +457,9 @@</span><br><span>     size_t ekm_size;</span><br><spa=
n> </span><br><span>     bool dco_enabled; /**&lt; Whether keys have to be =
installed in DCO or not */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** The =
app custom control protocols we should announce as supported */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char *acc_protocols;<=
/span><br><span> };</span><br><span> </span><br><span> /** @addtogroup cont=
rol_processor</span><br><span>@@ -730,6 +733,12 @@</span><br><span>     int=
 dco_peer_id;</span><br><span> </span><br><span>     dco_context_t *dco;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /** the protocols that are negotiated=
 with the peer=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    char *acc_negotiated_protocols;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /** the maximum length of an ACC control channel message */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int acc_max_message_length;</=
span><br><span> };</span><br><span> </span><br><span> /**  gets an item  of=
 \c key_state objects in the</span><br><span>diff --git a/tests/unit_tests/=
openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><s=
pan>index 43a6743=2E=2Ef827a4c 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Make=
file=2Eam</span><br><span>@@ -107,10 +107,12 @@</span><br><span> 	@TEST_CFL=
AGS@</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL=
_CRYPTO_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D test_ssl=2Ec \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	test_acc=2Ec test_acc=
=2Eh \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span>=
<br><span> 	mock_management=2Ec \</span><br><span> 	mock_ssl_dependencies=
=2Ec mock_win32_execve=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/com=
pat-strlcpy=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$=
(top_srcdir)/src/openvpn/acc=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -1=
32,6 +134,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/run_command=2Ec =
\</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \</span><br><=
span> 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span> 	$=
(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \</span><br><span> 	$(top_s=
rcdir)/src/openvpn/ssl_verify_openssl=2Ec \</span><br><span>@@ -392,9 +395,=
11 @@</span><br><span> </span><br><span> misc_testdriver_SOURCES =3D test_m=
isc=2Ec \</span><br><span> 	test_schedule=2Ec test_schedule=2Eh \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	mock_management=2Ec \</span>=
<br><span> 	mock_msg=2Ec test_common=2Eh  \</span><br><span> 	mock_get_rand=
om=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/ope=
nvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/options_util=2Ec \</span><br><s=
pan> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span>@@ -407,6 +4=
12,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \=
</span><br><span> 	$(top_srcdir)/src/openvpn/session_id=2Ec</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span>=
<br><span> 	-I$(top_srcdir)/src/compat \</span><br><span> 	-I$(top_srcdir)/=
tests/unit_tests/openvpn \</span><br><span>diff --git a/tests/unit_tests/op=
envpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec</s=
pan><br><span>index fff4c2b=2E=2Ef572dbb 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/mock_management=2Ec</span><br><span>+++ b/tests/unit_te=
sts/openvpn/mock_management=2Ec</span><br><span>@@ -29,6 +29,7 @@</span><br=
><span> </span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdli=
b=2Eh&gt;</span><br><span> #include &quot;manage=2Eh&quot;</span><br><span>=
 </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>diff --git a/te=
sts/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvp=
n/mock_push_dependencies=2Ec</span><br><span>index bf2ccf3=2E=2Ef083f89 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/mock_push_dependencies=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_push_dependencies=
=2Ec</span><br><span>@@ -43,7 +43,8 @@</span><br><span>     uint64_t flags =
=3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><=
br><span>                      | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER =
| OPT_P_COMP | OPT_P_PERSIST</span><br><span>                      | OPT_P_=
MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                     | OPT_P_PEER=
_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_PE=
ER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_A=
CC;</span><br><span>     return flags;</span><br><span> }</span><br><span> =
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests=
/unit_tests/openvpn/test_acc=2Ec</span><br><span>new file mode 100644</span=
><br><span>index 0000000=2E=2Ef1b97d5</span><br><span>--- /dev/null</span><=
br><span>+++ b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>@@ -0,=
0 +1,358 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span=
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
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifd=
ef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;test_acc=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+char control_channel_mesage_sent[2048];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Mock functions */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+send_control_channel_string_dowork(struct tls_session *sess=
ion,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                    const char *str, unsigned int msglevel)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_in_range(strlen(str), 0, 2048);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    memcpy(control_channel_mesage_sent, str, =
strlen(str));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+send_push_reply_auth_token(struct tls_multi *multi)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+auth_set_client_reason(s=
truct tls_multi *multi, const char *reason)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define MSG_PAYLOAD &quot;FgMBA=
RkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM&quot;                \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    &quot;r4engpg/cDg=
S48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS&quot; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;4md4OJwoQAwEwIT=
AxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP&quot; \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    &quot;AJwBnwArAFAA5wAnAEwAz=
AQAAnP8BAAEAAAsABAMAAQIACgAWABQAH&quot; \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    &quot;QAXAB4AGQAYAQABAQECAQMBBAAW=
AAAAFwAAAA0AMAAuBAMFAwYDCAc&quot; \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    &quot;ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEG=
AQMDAwEDAgQCBQIGAgArA&quot; \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    &quot;AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2=
FsxOfOIV4gn/NyJ&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    &quot;93rQwityP9eKSijXgcQ=3D=3D&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_acc_parse_client_messages(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifndef ENABLE_MANAGEMENT</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    skip();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* ensure that the messages get to mock_msg */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    x_debug_level =3D 3;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    management =3D (void *)0x12345678;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* contains a TLS =
1=2E3 ClientHello */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char msg[] =3D &quot;ACC,cck1,384,6,&quot; MSG_PAYLOAD;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer msg_buf;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct context c =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Eoptions=2Emode =3D M=
ODE_SERVER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2E=
c2=2Etls_multi, struct tls_multi, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;c=2Ec2=2E=
tls_multi-&gt;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt-&gt;mda_context =3D &amp=
;c=2Ec2=2Emda_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    buf_set_read(&amp;msg_buf, (void *)msg, sizeof(msg));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mo=
ck_msg_buf, &quot;WARNING: Received malformed custom app control channel me=
ssage (ACC not enabled or no negotiated protocols): 4143432c 63636b31 2c333=
834 2c362c46 674d4241 526b4241 41455641 774e616[more=2E=2E=2E]&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(=
mock_managment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
c=2Ec2=2Etls_multi-&gt;acc_negotiated_protocols =3D &quot;no:common:protoco=
l&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive=
_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;WARNING: Receiv=
ed malformed custom app control channel message (protocol &#39;cck1&#39; no=
t in list of negotiated protocols &#39;no:common:protocol&#39;): 3338342c 3=
62c4667 4d424152 6b424141 45564177 4e616e55 616c6b45 4444784[more=2E=2E=2E]=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    c=2Ec2=2Etls_multi-&gt;acc_negotiated_protocols =3D &quot;cck1=
:flower:power:fortune&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Received custo=
m app control message (protocol &#39;cck1&#39;)&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_=
buf, &quot;&gt;CLIENT:ACC,0,0,cck1,0,&quot; MSG_PAYLOAD);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char flower_msg[] =3D &quot;ACC,flower,48,6,SS=
BhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void =
*)flower_msg, sizeof(flower_msg));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_=
buf, &quot;Received custom app control message (protocol &#39;flower&#39;)&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_s=
tring_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,flower,0,SSBhbSAAI=
Etlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char msg_incorrect_len[] =3D &quot;ACC,=
fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=
=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_set_read(&amp;msg_buf, (void *)msg_incorrect_len, sizeof(msg_incorrect_le=
n));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc=
_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const char *error =3D &quot;WARNING: Received malformed cus=
tom app control channel &quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        &quot;message (field length 62, payload =
length 64 mismatch): &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        &quot;496e7367 496d316c 496a6f67 496d5a79 6=
2326369 4c434141 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        &quot;65475a6d 2f534a7[more=2E=2E=2E]&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, err=
or);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_stri=
ng_equal(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    CLEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char msg_fragment[] =3D &quot;ACC,power,12,6F,aGV=
sbG8gdw=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    buf_set_read(&amp;msg_buf, (void *)msg_fragment, sizeof(msg_fragment))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_me=
ssage(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_string_equal(mock_msg_buf, &quot;Received custom app co=
ntrol message (protocol &#39;power&#39;, fragment)&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managme=
nt_buf, &quot;&gt;CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* check two encoding present */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char flowe=
r_msg_two_encs[] =3D &quot;ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+=
94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg_two_encs, sizeof=
(flower_msg_two_encs));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    error =3D &quot;WARNING: Received malformed custom app cont=
rol channel message &quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            &quot;(number of encodings must be exactly one (B64=3D1,=
 ASCII=3D1)): &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            &quot;53534268 62534141 4945746c 636d3170 6443442f 2f534230 &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &qu=
ot;61475567 37372b3[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_string_equal(mock_msg_buf, error);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &q=
uot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* no encoding present=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char f=
lower_msg_no_encs[] =3D &quot;ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77=
+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg_no_encs, sizeof=
(flower_msg_no_encs));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    error =3D &quot;WARNING: Received malformed custom app contr=
ol channel message &quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            &quot;(number of encodings must be exactly one (B64=3D0, =
ASCII=3D0)): &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &quot;53534268 62534141 4945746c 636d3170 6443442f 2f534230 &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;61475567 37372b3[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, error);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock=
_managment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    x_de=
bug_level =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 management =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_parse_acc_parameters(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* parameters to INFO message */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *info_acc=
_msg =3D &quot;4096 A:6 flower:happy&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int max_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *protocols =3D parse_acc_parameters(info_acc_msg, &q=
uot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flower:happ=
y&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(max_len, 1280);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a cli=
ent does not accept a length longer than it supports */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(=
info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* message with lower limit than our, shou=
ld work for client and server */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    info_acc_msg =3D &quot;1111 A:6 flower:happy&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_ac=
c_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(protocols, &quot;flower:happy&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(max_len, 1111);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quo=
t; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flower:happy&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(max_len, 1111);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* more en=
codings than supported=2E Server should be okay, client should fail */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &qu=
ot;1200 A:6:B flower:happy&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &=
quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, =
&amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ma=
x_len, 1200);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* extra parameter */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =
=3D &quot;1400 A:6 flower:happy 77&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, =
&quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; =
&quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *iv_acc_capabilities =3D &quot;1400,A:6,flower:happy:power&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_a=
cc_parameters(iv_acc_capabilities, &quot;,&quot;, &amp;max_len, true, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_stri=
ng_equal(protocols, &quot;flower:happy:power&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* too small protocol length */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;32 A:6 flower:hap=
py&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protoc=
ols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, tru=
e, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* non-numeric=
al protocol length */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    info_acc_msg =3D &quot;abff A:6 flower:happy&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameter=
s(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* extra parameter */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1400 A:6 flo=
wer:happy 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;ma=
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
yle=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;session[TM_ACTIVE]=2Eopt=
 =3D &amp;multi-&gt;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    multi-&gt;opt=2Ees =3D env_set_create(&amp;c-&gt;options=2Egc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
ol_channel_mesage_sent,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        &quot;ACC,emergency,50,AF,EMERGENCY BROADCAST M=
ESSAGE - THIS IS NOT A DRILL:&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;emergen=
cy&quot;, false,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                        &quot;THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED =
ALERT FOR YOUR AREA=2E&quot;, false);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(ret);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_string_equal(control_channel_mesage_sent,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  &quot;ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALE=
RT FOR YOUR AREA=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* test a long message (&g=
t; 1000) with fragment to get the maximum header size */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    char long_message[1200] =3D { 0 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 1024; i++=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        long_message[i] =3D (cha=
r)(&#39; &#39; + (i % 95));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* last char of the m=
essage is a i and then a \0 */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(long_message[1023], &#39;i&#39;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(long_mes=
sage[1024], &#39;\0&#39;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D =
send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;emergency&quot;, t=
rue,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
            long_message, false);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 size_t cc_len =3D strlen(control_channel_mesage_sent);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(control_channel_me=
sage_sent[cc_len - 1], &#39;i&#39;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const char *expected_start_cc =3D &quot;ACC,emergency,=
1024,AF, !\&quot;#$%&amp;&#39;()*+,-=2E/012345&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(control_channel_m=
esage_sent, expected_start_cc, strlen(expected_start_cc));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    free(multi-&gt;acc_negotiated_protocols);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt;option=
s=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+test_list_intersection(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *empty =3D &quot;&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *protos =3D &quot;power:flowe=
r:emergency&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t1 =
=3D get_list_intersection(&amp;gc, empty, protos);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_len(&amp;t1), 0);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer t2 =3D get_list_inters=
ection(&amp;gc, protos, empty);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(buf_len(&amp;t2), 0);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct buffer t3 =3D get_list_intersection(&amp;gc, pro=
tos, protos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_string_equal(buf_cstr(&amp;t3), protos);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *protos2 =3D &quot;flower:emergency:power:mario&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
t4 =3D get_list_intersection(&amp;gc, protos2, protos);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t=
4), &quot;flower:emergency:power&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *protos3 =3D &quot;super:paper:mario:flower&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t5 =3D ge=
t_list_intersection(&amp;gc, protos2, protos3);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t5), &quo=
t;flower:mario&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
proto4 =3D &quot;flower:flower:flower:flower&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer t6 =3D get_list_interse=
ction(&amp;gc, proto4, &quot;flower&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t6), &quot;fl=
ower&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit=
_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh</span><=
br><span>new file mode 100644</span><br><span>index 0000000=2E=2E32421fb</s=
pan><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/=
test_acc=2Eh</span><br><span>@@ -0,0 +1,35 @@</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a sin=
gle UDP port, with support for SSL/TLS-based</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             session authentication and key exch=
ange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet encryption, packet authentication, and</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sale=
s@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program =
is free software; you can redistribute it and/or modify</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Gener=
al Public License version 2</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  as published by the Free Software Foundation=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that it =
will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS F=
OR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  GNU General Public License for more details=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GN=
U General Public License along</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/l=
icenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef TEST_ACC_H</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define TEST_ACC_H</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void test_acc_parse_client_messages(void **state);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void test_parse_acc_parameters(void **state);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void test_acc_common_protocols(void **sta=
te);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void test_acc_send_message(void **=
state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void test_list_intersection(voi=
d **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_common=2Eh b/test=
s/unit_tests/openvpn/test_common=2Eh</span><br><span>index 8db4ea6=2E=2Ec86=
5142 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_common=2Eh<=
/span><br><span>+++ b/tests/unit_tests/openvpn/test_common=2Eh</span><br><s=
pan>@@ -43,11 +43,13 @@</span><br><span> #define LargestIntegralType uintma=
x_t</span><br><span> #endif</span><br><span> /* redefine 2=2Ex API in terms=
 of 1=2Ex API */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne CMockaValueData             LargestIntegralType</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define check_expected_uint         check_expe=
cted</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define expect_ui=
nt_value           expect_value</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define expect_check_data           expect_check</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define cast_ptr_to_cmocka_value(x) (x=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CMockaValu=
eData                       LargestIntegralType</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define check_expected_uint                   c=
heck_expected</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e expect_uint_value                     expect_value</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define expect_check_data                =
     expect_check</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine cast_ptr_to_cmocka_value(x)           (x)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define assert_int_in_range(value, min, max)  a=
ssert_in_range((value), (min), (max))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define assert_uint_in_range(value, min, max) assert_in_r=
ange((value), (min), (max))</span><br><span> #endif</span><br><span> </span=
><br><span> /**</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index 4baf8=
cc=2E=2E4987dd0 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><=
br><span>@@ -52,6 +52,8 @@</span><br><span> #include &quot;ssl_verify=2Eh&q=
uot;</span><br><span> #include &quot;openvpn=2Eh&quot;</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_ac=
c=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> /* Mock function to be allowed to include win32=2Ec which is requ=
ired for</span><br><span>  * getting the temp directory */</span><br><span>=
 #ifdef _WIN32</span><br><span>@@ -86,6 +88,20 @@</span><br><span> {</span>=
<br><span>     return;</span><br><span> }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+reschedule_multi_process(struct context *c)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define a dummy dco ci=
pher option to avoid linking against all the DCO</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * units */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(ENABLE_DCO)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+const char *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dco_get_supported_ciphers(void)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return &quot;AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GC=
M:CHACHA20-POLY1305&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span> </span><br><span> /* generated using</span><br><span>  * opens=
sl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \</s=
pan><br><span>@@ -1111,8 +1127,12 @@</span><br><span>         cmocka_unit_t=
est(ssl_test_extract_last_matching_field),</span><br><span>         cmocka_=
unit_test(ssl_test_reject_null_in_cert_subject),</span><br><span>         c=
mocka_unit_test(ssl_test_escape_rfc_2253_chars_in_subject),</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(ssl_test_ext=
ract_peer_info)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(=
ssl_test_extract_peer_info),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_acc_parse_client_messages),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(tes=
t_parse_acc_parameters),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_acc_common_protocols),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_sen=
d_message),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_list_intersection)</span><br><span>     };</span><br>=
<span> </span><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br></pre=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
58?usp=3Demail">change 1858</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 18 </div>
<div style=3D"display:none"> =
Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>

</body></html>
--491SNW7Wz00=--


--===============2380464604840727021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2380464604840727021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2380464604840727021==--

