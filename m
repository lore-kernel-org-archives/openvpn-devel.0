Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130086082BC7
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Maxu/Wii;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mTOG16+j;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fY/72ksI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RcpNlHDk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=f386r8i/L5KFEynPaXZaKfqN02uBfvYNeuq7KabpdlY=; b=Maxu/WiidJo5wh0hswQBfM9XV7
	Nm45MlOm3Zn+1fG5C/AtsUSw9JQw9Zm8dNh52CuN27Tgb3BlqWk8TX36817HM6XUBCbDq9qNKQOUP
	G5XO9CJRAhlZv/rvAhV3NLM8kipCE9L2G4e4aZZAoIqPJGGk80cgKt4bAOSdgcIttD30=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOCpQ-000000005PJ-36KI;
	Tue, 03 Nov 2026 11:37:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOCpC-000000005P1-1RML
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:37:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=as7my+siNIZI2YRGHsG3hjn58NbNMnlDGBozwXvJXvo=; b=mTOG16+jSLcfpt2DY/cqsc0+PW
 kKHFr3rINjPnQxv4xkpdHe3gkywCfxzHxo2ZyLtm6PVLVmuRq9mcpY1WoIJmaYRwk2u20/Nrrtw9L
 GuYZT7Mg4BE1VJNKkx3Pw3ct1KtwoJaucP8voeVmuKj0x7Byi82Dlchr4y+ALOM7HqpQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=as7my+siNIZI2YRGHsG3hjn58NbNMnlDGBozwXvJXvo=; b=fY/72ksIW2+JXS18ZxKhP7aXHk
 K35A1LvbOzO6DVgF9c3q5ud3T1xIuQGU7XObmMJByhrkZveFFz6jXxdfBAIKbyUsZgUcueLGq4dSE
 Hxo0Uqybw7TJU4LXKThCaj4eNvt6pUXGEBQOUYGGc00Mivrtq2GxsQJ58dPgsL5rJUYw=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOCp3-000000002Ln-3pmM for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:37:08 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so40793015e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 03:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793705815; x=1794310615; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=as7my+siNIZI2YRGHsG3hjn58NbNMnlDGBozwXvJXvo=;
 b=RcpNlHDkLJh7cYgEAlhye0H2w1LFlAD+WsbGdznx0nqI/oRwIgA1VcvylBKr8nZwxD
 mmZPJbtDgaaTMfiOU2ZaRNXFjJ0mY6oggFkRu2anp0OiVPpqWrsHgiKsIupdOfIcuSgs
 I4e7hC24w9RgD7awXon8qdUAgHDIlMeqrdXAxjjUKbN6lMzw2ZUpdJOyNYXgVSkKoCWu
 VvEWV6nbYSHI30l+QwwSqs7qtBg+O6JluAs/1vvw3MVfmcIWj8qeU0J5V3yLITv+FXR5
 3Uv0SRNoJNFag5y2B/uZ+Ck5mWpRMif85GwzOXGmkflpWlUEK34plYvECr+3MSkSHV5i
 VY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793705815; x=1794310615;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=as7my+siNIZI2YRGHsG3hjn58NbNMnlDGBozwXvJXvo=;
 b=j+jGiAlSPwj3LMhhA1lgl9QeWh1nIJh+hHMkBhUdAFjb31l86D5L0TMpNV5dbEtoP/
 9quX2cIxr3eIdJsuxH8cXqcop6FShMhRYPVMkI2hmU34BojjG9RgNt+NfGJtXWXeMs8k
 NAzghrJPQlSTHgvmFyb6mHH5gi0W5V2xoWPTfb6COnj142iVXVu36DLEh1qX9OO9HjW/
 80wWCYuCXLVasGVvvOmtpCxAv2f5P4ltjF0yj0tlLiI1Ndv9vjhkhO26vbh13oo2FpZx
 m9PUVy2p7nxo87MKubzlO9xSRrwaSbNaHIxJTwjuDs5oAkYPKXGcsvk752sucvnVO6Wk
 rp1g==
X-Gm-Message-State: APuU4Z9Lis4A80gYsTG136Zfv0f7ZtYXUcrJKY3YaHTVvbvXXVfVlSZj
 Mtq6yKEuF3vX8mjRc4ZW0c7qu1PCJrdiEwjc+yOpmpN0WMUXGXHyJLcOsIOIXXwrKtxxjBNm2Sr
 U0/d58uTYOV3xK0H5XcmAg7UQNAliLM/gHl9RHyqjDGfxNELbs0mP+ID/p6TtAILwl8RN
X-Gm-Gg: AYBFou2YauBpJgk59eCDi71G8FN/cKTc3bOYRfVZ954MWvEPBjTI5SPw/HnV7Z/IJ4l
 50BbpP8eE9slPw5szV4HQyqnMNkSt52f2FSjukYr5yb8DzOPVquXyehPWsy1nb0VUhybZm9cr49
 1ql6XDnA8NfdTbEZq7TW8TvDstPGMF3rMVziQAvXOEys3nOWEvG5cCgGAuhZ4zaD/9mIkMHVFMb
 1TewHlxZi+Gss0wqzDHJvjiKMQ98udxACQarDIoW4WHUUVMnFlsVgjMu8Y8PbYybckgnvMmdl2W
 9i+w/PcsImRsqD6+E3lJdz1GGMpBYXSIdbz/FG1vuDuUaqDTGC0CcZBiZoAoPQar4deMO9xOgCp
 6wb2eQ/q+s2CT6ZohewAt9VIXGTBVyYJj9w2dv908qUgUDcpO7NOzAr/+FGcbOihyF5NwERzA4V
 mGUeq6tTBy0vnoXJh6zdR278zHTQzrKXO7G/d5XkXj3CuENMDVS5/p18xzaUiSr6bKomATLqgNI
 96kXS7Im5ixtH1yHE0Uxb2OZ+BgHn1So2qDjJkl4A9ZRU2tJ0L3r1/r9Jb0u4AIuU/HlS2upWae
 h00qF/hJ9FEacWmg4sdDfh3bLQ8XTkwFTmneYJcDGm53iJSl6i0KmqJWpRHJJFwoY6KsWu1+x7h
 BqwQ/bahw2StMyoc5HV1MbKWlbL19I5FgF2Lp5k5F+J66lKYSmbavkKVmyF3fOlR9TRyTTZLj0h
 NmHl/cQRikKiv6dg==
X-Received: by 2002:a05:600c:4e44:b0:4a1:7bd4:d07d with SMTP id
 5b1f17b1804b1-4ac1932a2d5mr301267515e9.34.1793705814666; 
 Tue, 03 Nov 2026 03:36:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba53d7sm31258421f8f.53.2026.11.03.03.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:36:54 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 11:36:52 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: e052d4f93e5bdb4a8596bf54d5b88926d14f1a13
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <915346b311d9939253094bff8ea2b08addfe6f83-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOCp3-000000002Ln-3pmM
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 --secret
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0367708277781416311=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0367708277781416311==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="73XDVL6DjSc="; charset=UTF-8

--73XDVL6DjSc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2081?usp=3Demail

to look at the new patch set (#5)=2E

The following =
approvals got outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojoc=
aru


Change subject: Remove support for --secret
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove support for --secret

This has=
 been announced for a long time and good alternatives exist=2E

Change-Id: =
Icadbee50a3af55f0f2069f6d6f1ccc746180f368
Signed-off-by: Arne Schwabe <arne=
@rfc2549=2Eorg>
---
M Changes=2Emd
M INSTALL
M doc/man-sections/generic-opt=
ions=2Erst
M doc/man-sections/protocol-options=2Erst
M doc/man-sections/uns=
upported-options=2Erst
M src/openvpn/check_file_access=2Ec
M src/openvpn/cr=
ypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/helper=2Ec
M src/openvpn/in=
it=2Ec
M src/openvpn/mtu=2Ec
M src/openvpn/options=2Ec
M src/openvpn/option=
s=2Eh
M src/openvpn/options_show=2Ec
M src/openvpn/options_string=2Ec
M src=
/openvpn/options_string=2Eh
M src/openvpn/ssl=2Ec
M tests/unit_tests/openvp=
n/test_crypto=2Ec
M tests/unit_tests/openvpn/test_pkt=2Ec
19 files changed,=
 256 insertions(+), 522 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/81/2081/5

diff --git a/Changes=2Emd b/Chang=
es=2Emd
index b5ae881=2E=2E7f47f77 100644
--- a/Changes=2Emd
+++ b/Changes=
=2Emd
@@ -23,6 +23,13 @@
   the characters mentioned above were already esc=
aped=2E However, the behavior of
   Mbed TLS is slightly different from Ope=
nSSL in that it also escapes "=3D"=2E
 
+* **`secret` has been removed**
+
=
+  Static key mode (non-TLS) is no longer considered "good and secure enoug=
h" for
+  today's requirements=2E Use TLS mode instead=2E If deploying a PK=
I CA is considered
+  "too complicated", using `--peer-fingerprint` makes T=
LS mode about as easy as
+  using `--secret`=2E
+
 ## Maintainer-visible ch=
anges
 
 - The configure-time option `--enable-debug` is no longer  availab=
le
diff --git a/INSTALL b/INSTALL
index 486b1ae=2E=2Ed0ffaf0 100644
--- a/I=
NSTALL
+++ b/INSTALL
@@ -144,8 +144,7 @@
 
 Test Crypto:
 
-=2E/openvpn --g=
enkey secret key
-=2E/openvpn --test-crypto --secret key
+=2E/openvpn --tes=
t-crypto
 
 Test SSL/TLS negotiations (runs for 2 minutes):
 
diff --git a/=
doc/man-sections/generic-options=2Erst b/doc/man-sections/generic-options=
=2Erst
index 6815dc2=2E=2E17e4372 100644
--- a/doc/man-sections/generic-opt=
ions=2Erst
+++ b/doc/man-sections/generic-options=2Erst
@@ -108,7 +108,7 @@=

   For example on Windows, use double backslashes to represent pathnames:
=
   ::
 
-      secret "c:\\OpenVPN\\secret=2Ekey"
+      tls-auth "c:\\Open=
VPN\\secret=2Ekey"
 
 
   For examples of configuration files, see
@@ -119,=
7 +119,7 @@
 
       #
       # Sample OpenVPN configuration file for
-    =
  # using a pre-shared static key=2E
+      # using a p2p connection=2E
   =
    #
       # '#' or ';' may be used to delimit comments=2E
 
@@ -133,8 +1=
33,11 @@
       # 10=2E1=2E0=2E2 is our remote VPN endpoint
       ifconfig=
 10=2E1=2E0=2E1 10=2E1=2E0=2E2
 
-      # Our pre-shared static key
-      =
secret static=2Ekey
+      # Our TLS configuration
+      tls-client
+     =
 key mynode=2Ekey
+      cert mynode=2Ecrt
+      ca myca=2Ecrt
 
 --daemon=
 progname
   Become a daemon after all initialization functions are complet=
ed=2E
diff --git a/doc/man-sections/protocol-options=2Erst b/doc/man-sectio=
ns/protocol-options=2Erst
index 52ce5a8=2E=2Eb785ebe 100644
--- a/doc/man-s=
ections/protocol-options=2Erst
+++ b/doc/man-sections/protocol-options=2Ers=
t
@@ -212,11 +212,6 @@
   have been configured with ``--enable-small``
   (=
typically used on routers or other embedded devices)=2E
 
-
---allow-deprec=
ated-insecure-static-crypto
-   **DEPRECATED** This allow using OpenVPN wit=
hout TLS=2E This is deprecated
-   and will be removed in OpenVPN 2=2E8=2E
=
-
 --tran-window n
   Transition window -- our old key can live this many s=
econds after a new
   a key renegotiation begins (default :code:`3600` seco=
nds)=2E This feature
diff --git a/doc/man-sections/unsupported-options=2Ers=
t b/doc/man-sections/unsupported-options=2Erst
index c273905=2E=2E2794f12 1=
00644
--- a/doc/man-sections/unsupported-options=2Erst
+++ b/doc/man-sectio=
ns/unsupported-options=2Erst
@@ -70,3 +70,12 @@
   Removed in OpenVPN 2=2E8=
=2E This option caused the Mbed TLS 3 random number
   generator to be rese=
eded on every call=2E It has been removed because this
   is excessive=2E
+=

+--secret
+  Removed in OpenVPN 2=2E8=2E Static encryption without a trans=
ient key
+  (generated by DH or ECDH) has been considered problematic for m=
any
+  years=2E Please use ``--peer-fingerprint`` and self-signed certifica=
tes
+  for small setups=2E
+
+--allow-deprecated-insecure-static-crypto
+  =
Removed in OpenVPN 2=2E8 as --secret was also removed=2E
diff --git a/src/o=
penvpn/check_file_access=2Ec b/src/openvpn/check_file_access=2Ec
index 8365=
4b2=2E=2E90dbb4e 100644
--- a/src/openvpn/check_file_access=2Ec
+++ b/src/o=
penvpn/check_file_access=2Ec
@@ -312,10 +312,6 @@
                         =
                 ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
     }
 
-=
    errs |=3D
-        check_file_access_inline(options->shared_secret_file=
_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                                 op=
tions->shared_secret_file, R_OK, "--secret");
-
     errs |=3D check_file_a=
ccess(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet_id_file,
         =
                      R_OK | W_OK, "--replay-persist");
 
diff --git a/src/=
openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index ff17b22=2E=2Ed375273 1006=
44
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -872,7 +872=
,7 @@
  * Build a struct key_type=2E
  */
 void
-init_key_type(struct key_t=
ype *kt, const char *ciphername, const char *authname, bool tls_mode,
+init=
_key_type(struct key_type *kt, const char *ciphername, const char *authname=
,
               bool warn)
 {
     bool aead_cipher =3D false;
@@ -891,9 +=
891,9 @@
 
         /* check legal cipher mode */
         aead_cipher =3D =
cipher_kt_mode_aead(kt->cipher);
-        if (!(cipher_kt_mode_cbc(kt->ciph=
er) || (tls_mode && aead_cipher)
+        if (!(cipher_kt_mode_cbc(kt->ciph=
er) || aead_cipher
 #ifdef ENABLE_OFB_CFB_MODE
-              || (tls_mode =
&& cipher_kt_mode_ofb_cfb(kt->cipher))
+              || cipher_kt_mode_ofb=
_cfb(kt->cipher)
 #endif
                   ))
         {
diff --git a/src/=
openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index dbe0802=2E=2E203f77b 1006=
44
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -420,11 +42=
0,9 @@
  * @param kt          The struct key_type to initialize
  * @param =
ciphername  The name of the cipher to use
  * @param authname    The name o=
f the HMAC digest to use
- * @param tls_mode    Specifies whether we are ru=
nning in TLS mode, which allows
- *                    more ciphers than st=
atic key mode=2E
  * @param warn        Print warnings when null cipher / a=
uth is used=2E
  */
-void init_key_type(struct key_type *kt, const char *ci=
phername, const char *authname, bool tls_mode,
+void init_key_type(struct k=
ey_type *kt, const char *ciphername, const char *authname,
                =
    bool warn);
 
 /*
diff --git a/src/openvpn/helper=2Ec b/src/openvpn/hel=
per=2Ec
index d29895b=2E=2E6b5fcee6 100644
--- a/src/openvpn/helper=2Ec
+++=
 b/src/openvpn/helper=2Ec
@@ -266,12 +266,6 @@
             msg(M_USAGE, "-=
-server and --server-bridge cannot be used together");
         }
 
-      =
  if (o->shared_secret_file)
-        {
-            msg(M_USAGE,
-        =
        "--server and --secret cannot be used together (you must use SSL/TL=
S keys)");
-        }
-
         if (!(o->server_flags & SF_NOPOOL) && o->i=
fconfig_pool_defined)
         {
             msg(M_USAGE,
@@ -461,12 +455,=
6 @@
                 "--server-bridge already defines an ifconfig-pool, so=
 you can't also specify --ifconfig-pool explicitly");
         }
 
-       =
 if (o->shared_secret_file)
-        {
-            msg(M_USAGE,
-         =
       "--server-bridge and --secret cannot be used together (you must use =
SSL/TLS keys)");
-        }
-
         if (dev !=3D DEV_TYPE_TAP)
         =
{
             msg(M_USAGE, "--server-bridge directive only makes sense wit=
h --dev tap");
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
ind=
ex 6c87865=2E=2Eff00151 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn=
/init=2Ec
@@ -1000,35 +1000,10 @@
         platform_mlockall(true);
     }
=
 
-    /*
-     * We do not want user to use --genkey with --secret=2E In t=
he transistion
-     * phase we for secret=2E
-     */
-    if (options->ge=
nkey && options->genkey_type !=3D GENKEY_SECRET && options->shared_secret_f=
ile)
-    {
-        msg(M_USAGE, "Using --genkey type with --secret filena=
me is "
-                     "not supported=2E  Use --genkey type filename=
 instead=2E");
-    }
     if (options->genkey && options->genkey_type =3D=
=3D GENKEY_SECRET)
     {
         int nbits_written;
         const char *=
genkey_filename =3D options->genkey_filename;
-        if (options->shared_=
secret_file && options->genkey_filename)
-        {
-            msg(M_USAG=
E, "You must provide a filename to either --genkey "
-                     =
    "or --secret, not both");
-        }
-
-        /*
-         * Copy fil=
ename from shared_secret_file to genkey_filename to support
-         * the=
 old --genkey --secret foo=2Efile syntax=2E
-         */
-        if (optio=
ns->shared_secret_file)
-        {
-            msg(M_WARN, "WARNING: Using=
 --genkey --secret filename is "
-                        "DEPRECATED=2E  U=
se --genkey secret filename instead=2E");
-            genkey_filename =3D =
options->shared_secret_file;
-        }
 
         nbits_written =3D write_=
key_file(2, genkey_filename);
         if (nbits_written < 0)
@@ -1037,7 +1=
012,7 @@
         }
 
         msg(D_GENKEY | M_NOPREFIX, "Randomly generat=
ed %d bit key written to %s", nbits_written,
-            options->shared_s=
ecret_file);
+            options->genkey_filename ? options->genkey_filena=
me : "stdout");
         return true;
     }
     else if (options->genkey =
&& options->genkey_type =3D=3D GENKEY_TLS_CRYPTV2_SERVER)
@@ -1083,7 +1058,=
7 @@
     /* sanity check on options for --mktun or --rmtun */
     notnull=
(options->dev, "TUN/TAP device (--dev)");
     if (options->ce=2Eremote || =
options->ifconfig_local || options->ifconfig_remote_netmask
-        || opt=
ions->shared_secret_file || options->tls_server || options->tls_client)
+  =
      || options->tls_server || options->tls_client)
     {
         msg(M_=
FATAL | M_OPTERR,
             "options --mktun or --rmtun should only be u=
sed together with --dev");
@@ -3015,8 +2990,7 @@
     ASSERT(!key_ctx_bi_de=
fined(&c->c1=2Eks=2Estatic_key));
 
     /* Init cipher and hash algorithm =
*/
-    init_key_type(&c->c1=2Eks=2Ekey_type, options->ciphername, options-=
>authname,
-                  options->test_crypto, true);
+    init_key_ty=
pe(&c->c1=2Eks=2Ekey_type, options->ciphername, options->authname, true);
 =

     generate_test_crypto_random_key(&c->c1=2Eks=2Ekey_type, &c->c1=2Eks=
=2Estatic_key,
                                     "test crypto key");
@@ =
-3026,50 +3000,6 @@
 }
 
 /*
- * Static Key Mode (using a pre-shared key)
-=
 */
-static void
-do_init_crypto_static(struct context *c, const unsigned i=
nt flags)
-{
-    const struct options *options =3D &c->options;
-    ASSER=
T(options->shared_secret_file);
-
-    init_crypto_pre(c, flags);
-
-    /*=
 Initialize flags */
-    if (c->options=2Emute_replay_warnings)
-    {
-  =
      c->c2=2Ecrypto_options=2Eflags |=3D CO_MUTE_REPLAY_WARNINGS;
-    }
-=

-    /* Initialize packet ID tracking */
-    packet_id_init(&c->c2=2Ecryp=
to_options=2Epacket_id, options->replay_window, options->replay_time,
-    =
               "STATIC", 0);
-    c->c2=2Ecrypto_options=2Epid_persist =3D =
&c->c1=2Epid_persist;
-    c->c2=2Ecrypto_options=2Eflags |=3D CO_PACKET_ID=
_LONG_FORM;
-    packet_id_persist_load_obj(&c->c1=2Epid_persist, &c->c2=2E=
crypto_options=2Epacket_id);
-
-    if (!key_ctx_bi_defined(&c->c1=2Eks=2Es=
tatic_key))
-    {
-        /* Get cipher & hash algorithms */
-        ini=
t_key_type(&c->c1=2Eks=2Ekey_type, options->ciphername, options->authname,
=
-                      options->test_crypto, true);
-
-        /* Read ciph=
er and hmac keys from shared secret file */
-        crypto_read_openvpn_ke=
y(&c->c1=2Eks=2Ekey_type, &c->c1=2Eks=2Estatic_key,
-                      =
          options->shared_secret_file, options->shared_secret_file_inline,
=
-                                options->key_direction, "Static Key Encryp=
tion", "secret", NULL);
-    }
-    else
-    {
-        msg(M_INFO, "Re-us=
ing pre-shared static key");
-    }
-
-    /* Get key schedule */
-    c->c=
2=2Ecrypto_options=2Ekey_ctx_bi =3D c->c1=2Eks=2Estatic_key;
-}
-
-/*
  * I=
nitialize the tls-auth/crypt key context
  */
 static void
@@ -3208,7 +3138=
,7 @@
 
         /* Do not warn if the cipher is used only in OCC */
      =
   bool warn =3D options->enable_ncp_fallback;
-        init_key_type(&c->c=
1=2Eks=2Ekey_type, ciphername, options->authname, true, warn);
+        ini=
t_key_type(&c->c1=2Eks=2Ekey_type, ciphername, options->authname, warn);
 
=
         /* initialize tls-auth/crypt/crypt-v2 key */
         do_init_tls_=
wrap_key(c);
@@ -3496,41 +3426,6 @@
     }
 }
 
-/*
- * No encryption or au=
thentication=2E
- */
-static void
-do_init_crypto_none(struct context *c)
-=
{
-    ASSERT(!c->options=2Etest_crypto);
-
-    /* Initialise key_type wit=
h auth/cipher "none", so the key_type struct is
-     * valid */
-    init_=
key_type(&c->c1=2Eks=2Ekey_type, "none", "none", c->options=2Etest_crypto, =
true);
-
-    msg(M_WARN, "******* WARNING *******: All encryption and auth=
entication features "
-                "disabled -- All data will be tunnel=
led as clear text and will not be "
-                "protected against man=
-in-the-middle changes=2E "
-                "PLEASE DO RECONSIDER THIS CON=
FIGURATION!");
-}
-
-static void
-do_init_crypto(struct context *c, const u=
nsigned int flags)
-{
-    if (c->options=2Eshared_secret_file)
-    {
-   =
     do_init_crypto_static(c, flags);
-    }
-    else if (c->options=2Etls=
_server || c->options=2Etls_client)
-    {
-        do_init_crypto_tls(c, f=
lags);
-    }
-    else /* no encryption or authentication=2E */
-    {
-  =
      do_init_crypto_none(c);
-    }
-}
-
 static void
 do_init_frame(struc=
t context *c)
 {
@@ -4568,7 +4463,7 @@
         {
             crypto_flags=
 =3D CF_INIT_TLS_MULTI;
         }
-        do_init_crypto(c, crypto_flags)=
;
+        do_init_crypto_tls(c, crypto_flags);
         if (IS_SIG(c) && !=
child)
         {
             goto sig;
diff --git a/src/openvpn/mtu=2Ec b=
/src/openvpn/mtu=2Ec
index f3c2874=2E=2E5ce40c8 100644
--- a/src/openvpn/mt=
u=2Ec
+++ b/src/openvpn/mtu=2Ec
@@ -51,7 +51,6 @@
 unsigned int
 calc_packe=
t_id_size_dc(const struct options *options, const struct key_type *kt)
 {
-=
    bool tlsmode =3D options->tls_server || options->tls_client;
     bool =
epoch =3D options->imported_protocol_flags & CO_EPOCH_DATA_KEY_FORMAT;
 
  =
   /* epoch format uses a 64-bit packet id: 16 bit epoch + 48 bit per-epoch=
 counter */
@@ -60,7 +59,7 @@
         return sizeof(uint64_t);
     }
 
- =
   bool packet_id_long_form =3D !tlsmode || cipher_kt_mode_ofb_cfb(kt->ciph=
er);
+    bool packet_id_long_form =3D cipher_kt_mode_ofb_cfb(kt->cipher);
=
 
     return packet_id_size(packet_id_long_form);
 }
@@ -72,8 +71,6 @@
   =
  /* Sum of all the overhead that reduces the usable packet size */
     si=
ze_t header_size =3D 0;
 
-    bool tlsmode =3D options->tls_server || opti=
ons->tls_client;
-
     /* A socks proxy adds extra header to each packet
 =
     * (we only support Socks with IPv4, this value is different for IPv6) =
*/
     if (options->ce=2Esocks_proxy_server && proto_is_udp(options->ce=2E=
proto))
@@ -88,10 +85,7 @@
     }
 
     /* Add the opcode and peerid */
- =
   if (tlsmode)
-    {
-        header_size +=3D options->use_peer_id ? 4 :=
 1;
-    }
+    header_size +=3D options->use_peer_id ? 4 : 1;
 
     unsig=
ned int pkt_id_size =3D calc_packet_id_size_dc(options, kt);
 
@@ -156,13 +=
150,6 @@
 {
     struct key_type occ_kt;
 
-    /* neither --secret nor TLS=
 mode */
-    if (!o->tls_client && !o->tls_server && !o->shared_secret_fil=
e)
-    {
-        init_key_type(&occ_kt, "none", "none", false, false);
- =
       return frame_calculate_payload_size(frame, o, &occ_kt);
-    }
-
   =
  /* o->ciphername might be BF-CBC even though the underlying SSL library
 =
     * does not support it=2E For this reason we workaround this corner cas=
e
      * by pretending to have no encryption enabled and by manually addin=
g
@@ -184,9 +171,7 @@
         ciphername =3D "none";
     }
 
-    /* We p=
ass tlsmode always true here since as we do not need to check if
-     * th=
e ciphers are actually valid for non tls in occ calucation */
-    init_key=
_type(&occ_kt, ciphername, o->authname, true, false);
+    init_key_type(&o=
cc_kt, ciphername, o->authname, false);
 
     size_t payload =3D frame_cal=
culate_payload_size(frame, o, &occ_kt);
     overhead +=3D frame_calculate_=
protocol_header_size(&occ_kt, o, true);
diff --git a/src/openvpn/options=2E=
c b/src/openvpn/options=2Ec
index 8e0c602=2E=2Ea3c7601 100644
--- a/src/ope=
nvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1587,16 +1587,17 @@
 sta=
tic void
 options_postprocess_verify_ce(const struct options *options, cons=
t struct connection_entry *ce)
 {
+    if (options->test_crypto)
+    {
+  =
      return;
+    }
     struct options defaults;
     int dev =3D DEV_TYP=
E_UNDEF;
     bool pull =3D false;
 
     init_options(&defaults);
 
-    i=
f (!options->test_crypto)
-    {
-        notnull(options->dev, "TUN/TAP de=
vice (--dev)");
-    }
+    notnull(options->dev, "TUN/TAP device (--dev)")=
;
 
     /*
      * Get tun/tap/null device type
@@ -2012,27 +2013,9 @@
   =
  /*
      * SSL/TLS mode sanity checks=2E
      */
-    if (options->tls_s=
erver + options->tls_client + (options->shared_secret_file !=3D NULL) > 1)
=
+    if (options->tls_server =3D=3D options->tls_client)
     {
-        ms=
g(M_USAGE, "specify only one of --tls-server, --tls-client, or --secret");
=
-    }
-
-    if (!options->tls_server && !options->tls_client && !options-=
>test_crypto)
-    {
-        msglvl_t msglevel =3D M_USAGE;
-        if (o=
ptions->allow_deprecated_insecure_static_crypto)
-        {
-            ms=
glevel =3D M_INFO;
-        }
-
-        msg(msglevel, "DEPRECATION: No tls=
-client or tls-server option in "
-                      "configuration det=
ected=2E OpenVPN 2=2E8 will remove the "
-                      "functional=
ity to run a VPN without TLS=2E "
-                      "See the examples =
section in the manual page for "
-                      "examples of a simi=
lar quick setup with peer-fingerprint=2E "
-                      "OpenVPN =
2=2E7 allows using this configuration when using "
-                      "=
--allow-deprecated-insecure-static-crypto but you should move "
-          =
            "to a proper configuration using TLS as soon as possible=2E");
=
+        msg(M_USAGE, "OpenVPN configuration must use either --tls-server o=
r --tls-client");
     }
 
     if (options->ssl_flags & (SSLF_CLIENT_CERT_=
NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL))
@@ -2052,188 +2035,135 @@
      =
   msg(M_USAGE, "--tls-version-min bigger than --tls-version-max");
     }
=
 
-    if (options->tls_server || options->tls_client)
-    {
-        chec=
k_ca_required(options);
+    check_ca_required(options);
 #ifdef ENABLE_PKC=
S11
-        if (!options->pkcs11_providers[0] && options->pkcs11_id)
-    =
    {
-            msg(M_WARN, "Option pkcs11-id is ignored as no pkcs11-pr=
oviders are specified");
-        }
-        else if (!options->pkcs11_prov=
iders[0] && options->pkcs11_id_management)
-        {
-            msg(M_WA=
RN,
-                "Option pkcs11-id-management is ignored as no pkcs11-p=
roviders are specified");
-        }
+    if (!options->pkcs11_providers[0]=
 && options->pkcs11_id)
+    {
+        msg(M_WARN, "Option pkcs11-id is ig=
nored as no pkcs11-providers are specified");
+    }
+    else if (!options=
->pkcs11_providers[0] && options->pkcs11_id_management)
+    {
+        msg=
(M_WARN,
+            "Option pkcs11-id-management is ignored as no pkcs11-=
providers are specified");
+    }
 
-        if (options->pkcs11_providers[=
0])
-        {
-            if (options->pkcs11_id_management && options->p=
kcs11_id !=3D NULL)
-            {
-                msg(M_USAGE,
-         =
           "Parameter --pkcs11-id cannot be used when --pkcs11-id-managemen=
t is also specified=2E");
-            }
-            if (!options->pkcs11_=
id_management && options->pkcs11_id =3D=3D NULL)
-            {
-          =
      msg(M_USAGE,
-                    "Parameter --pkcs11-id or --pkcs11-=
id-management should be specified=2E");
-            }
-            const c=
har use_err[] =3D
-                "Parameter --%s cannot be used when --pk=
cs11-provider is also specified=2E";
-            MUST_BE_UNDEF(cert_file, =
"cert");
-            MUST_BE_UNDEF(priv_key_file, "key");
-            MUS=
T_BE_UNDEF(pkcs12_file, "pkcs12");
-            MUST_BE_FALSE(options->mana=
gement_flags & MF_EXTERNAL_KEY, "management-external-key");
-            MU=
ST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "management-exter=
nal-cert");
-#ifdef ENABLE_CRYPTOAPI
-            MUST_BE_UNDEF(cryptoapi_c=
ert, "cryptoapicert");
-#endif
-        }
-        else
-#endif /* ifdef EN=
ABLE_PKCS11 */
-#ifdef ENABLE_CRYPTOAPI
-            if (options->cryptoapi=
_cert)
-        {
-            const char use_err[] =3D
-                "P=
arameter --%s cannot be used when --cryptoapicert is also specified=2E";
- =
           MUST_BE_UNDEF(cert_file, "cert");
-            MUST_BE_UNDEF(pri=
v_key_file, "key");
-            MUST_BE_UNDEF(pkcs12_file, "pkcs12");
-   =
         MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "manage=
ment-external-key");
-            MUST_BE_FALSE(options->management_flags &=
 MF_EXTERNAL_CERT, "management-external-cert");
-        }
-        else
-#=
endif
-            if (options->pkcs12_file)
-        {
-#ifdef ENABLE_CRYP=
TO_MBEDTLS
-            msg(M_USAGE, "Parameter --pkcs12 cannot be used wit=
h the mbed TLS version of OpenVPN=2E");
-#else
-            const char use_=
err[] =3D "Parameter --%s cannot be used when --pkcs12 is also specified=2E=
";
-            MUST_BE_UNDEF(ca_path, "capath");
-            MUST_BE_UNDE=
F(cert_file, "cert");
-            MUST_BE_UNDEF(priv_key_file, "key");
-  =
          MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "manag=
ement-external-key");
-            MUST_BE_FALSE(options->management_flags =
& MF_EXTERNAL_CERT, "management-external-cert");
-#endif       /* ifdef ENA=
BLE_CRYPTO_MBEDTLS */
-        }
-        else /* cert/key from none of pkc=
s11, pkcs12, cryptoapi */
-        {
-            if ((options->management_=
flags & MF_EXTERNAL_KEY) && options->priv_key_file)
-            {
-       =
         msg(M_USAGE, "--key and --management-external-key are mutually exc=
lusive");
-            }
-            if ((options->management_flags & MF_E=
XTERNAL_CERT))
-            {
-                if (options->cert_file)
-   =
             {
-                    msg(M_USAGE, "--cert and --management-e=
xternal-cert are mutually exclusive");
-                }
-                =
else if (!(options->management_flags & MF_EXTERNAL_KEY))
-                {=

-                    msg(M_USAGE,
-                        "--management-e=
xternal-cert must be used with --management-external-key");
-              =
  }
-            }
-            if (pull)
-            {
-                c=
onst int sum =3D
-                    ((options->cert_file !=3D NULL) || (o=
ptions->management_flags & MF_EXTERNAL_CERT))
-                    + ((opti=
ons->priv_key_file !=3D NULL)
-                       || (options->manageme=
nt_flags & MF_EXTERNAL_KEY));
-
-                if (sum =3D=3D 0)
-       =
         {
-                    if (!options->auth_user_pass_file)
-       =
             {
-                        msg(M_USAGE, "No client-side authen=
tication method is "
-                                     "specified=2E  Y=
ou must use either "
-                                     "--cert/--key, -=
-pkcs12, or "
-                                     "--auth-user-pass");
- =
                   }
-                }
-                else if (sum !=3D =
2)
-                {
-                    msg(M_USAGE, "If you use one of =
--cert or --key, you must use them both");
-                }
-            =
}
-            else
-            {
-                if (!(options->manageme=
nt_flags & MF_EXTERNAL_CERT))
-                {
-                    notnu=
ll(options->cert_file,
-                            "certificate file (--ce=
rt) or PKCS#12 file (--pkcs12)");
-                }
-                if (!=
(options->management_flags & MF_EXTERNAL_KEY))
-                {
-        =
            notnull(options->priv_key_file,
-                            "p=
rivate key file (--key) or PKCS#12 file (--pkcs12)");
-                }
- =
           }
-        }
-        if (ce->tls_auth_file && ce->tls_crypt_fil=
e)
-        {
-            msg(M_USAGE, "--tls-auth and --tls-crypt are mut=
ually exclusive");
-        }
-        if (options->tls_client && ce->tls_c=
rypt_v2_file
-            && (ce->tls_auth_file || ce->tls_crypt_file))
+  =
  if (options->pkcs11_providers[0])
+    {
+        if (options->pkcs11_id_=
management && options->pkcs11_id !=3D NULL)
         {
             msg(M_U=
SAGE,
-                "--tls-crypt-v2, --tls-auth and --tls-crypt are mutu=
ally exclusive in client mode");
+                "Parameter --pkcs11-id ca=
nnot be used when --pkcs11-id-management is also specified=2E");
         }=

-    }
-    else
-    {
-        /*
-         * Make sure user doesn't spe=
cify any TLS options
-         * when in non-TLS mode=2E
-         */
-
-  =
      const char use_err[] =3D "Parameter %s can only be specified in TLS-m=
ode, "
-                               "i=2Ee=2E where --tls-server or --tl=
s-client is also specified=2E";
-
-        MUST_BE_UNDEF(ca_file, "ca");
- =
       MUST_BE_UNDEF(ca_path, "capath");
-        MUST_BE_UNDEF(dh_file, "d=
h");
+        if (!options->pkcs11_id_management && options->pkcs11_id =3D=
=3D NULL)
+        {
+            msg(M_USAGE,
+                "Parameter =
--pkcs11-id or --pkcs11-id-management should be specified=2E");
+        }
=
+        const char use_err[] =3D
+            "Parameter --%s cannot be us=
ed when --pkcs11-provider is also specified=2E";
         MUST_BE_UNDEF(cer=
t_file, "cert");
         MUST_BE_UNDEF(priv_key_file, "key");
-#ifndef ENA=
BLE_CRYPTO_MBEDTLS
         MUST_BE_UNDEF(pkcs12_file, "pkcs12");
+        =
MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "management-exte=
rnal-key");
+        MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_=
CERT, "management-external-cert");
+#ifdef ENABLE_CRYPTOAPI
+        MUST_B=
E_UNDEF(cryptoapi_cert, "cryptoapicert");
 #endif
-        MUST_BE_UNDEF(ci=
pher_list, "tls-cipher");
-        MUST_BE_UNDEF(cipher_list_tls13, "tls-ci=
phersuites");
-        MUST_BE_UNDEF(tls_cert_profile, "tls-cert-profile");=

-        MUST_BE_UNDEF(tls_verify, "tls-verify");
-        MUST_BE_UNDEF(t=
ls_export_peer_cert_dir, "tls-export-cert");
-        MUST_BE_UNDEF(verify_=
x509_name, "verify-x509-name");
-        MUST_BE_UNDEF(tls_timeout, "tls-ti=
meout");
-        MUST_BE_UNDEF(renegotiate_bytes, "reneg-bytes");
-       =
 MUST_BE_UNDEF(renegotiate_packets, "reneg-pkts");
-        MUST_BE_UNDEF(r=
enegotiate_seconds, "reneg-sec");
-        MUST_BE_UNDEF(handshake_window, =
"hand-window");
-        MUST_BE_UNDEF(transition_window, "tran-window");
-=
        MUST_BE_UNDEF(tls_auth_file, "tls-auth");
-        MUST_BE_UNDEF(tl=
s_crypt_file, "tls-crypt");
-        MUST_BE_UNDEF(tls_crypt_v2_file, "tls-=
crypt-v2");
-        MUST_BE_UNDEF(single_session, "single-session");
-    =
    MUST_BE_UNDEF(push_peer_info, "push-peer-info");
-        MUST_BE_UNDEF=
(tls_exit, "tls-exit");
-        MUST_BE_UNDEF(crl_file, "crl-verify");
-  =
      MUST_BE_UNDEF(ns_cert_type, "ns-cert-type");
-        MUST_BE_UNDEF(r=
emote_cert_ku[0], "remote-cert-ku");
-        MUST_BE_UNDEF(remote_cert_eku=
, "remote-cert-eku");
-#ifdef ENABLE_PKCS11
-        MUST_BE_UNDEF(pkcs11_p=
roviders[0], "pkcs11-providers");
-        MUST_BE_UNDEF(pkcs11_private_mod=
e[0], "pkcs11-private-mode");
-        MUST_BE_UNDEF(pkcs11_id, "pkcs11-id"=
);
-        MUST_BE_UNDEF(pkcs11_id_management, "pkcs11-id-management");
+ =
   }
+    else
+#endif /* ifdef ENABLE_PKCS11 */
+#ifdef ENABLE_CRYPTOAPI
+=
        if (options->cryptoapi_cert)
+    {
+        const char use_err[] =
=3D
+            "Parameter --%s cannot be used when --cryptoapicert is als=
o specified=2E";
+        MUST_BE_UNDEF(cert_file, "cert");
+        MUST_B=
E_UNDEF(priv_key_file, "key");
+        MUST_BE_UNDEF(pkcs12_file, "pkcs12"=
);
+        MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "man=
agement-external-key");
+        MUST_BE_FALSE(options->management_flags & =
MF_EXTERNAL_CERT, "management-external-cert");
+    }
+    else
 #endif
-
+=
        if (options->pkcs12_file)
+    {
+#ifdef ENABLE_CRYPTO_MBEDTLS
+   =
     msg(M_USAGE, "Parameter --pkcs12 cannot be used with the mbed TLS vers=
ion of OpenVPN=2E");
+#else
+        const char use_err[] =3D "Parameter --=
%s cannot be used when --pkcs12 is also specified=2E";
+        MUST_BE_UND=
EF(ca_path, "capath");
+        MUST_BE_UNDEF(cert_file, "cert");
+        =
MUST_BE_UNDEF(priv_key_file, "key");
+        MUST_BE_FALSE(options->manage=
ment_flags & MF_EXTERNAL_KEY, "management-external-key");
+        MUST_BE_=
FALSE(options->management_flags & MF_EXTERNAL_CERT, "management-external-ce=
rt");
+#endif   /* ifdef ENABLE_CRYPTO_MBEDTLS */
+    }
+    else /* cert/=
key from none of pkcs11, pkcs12, cryptoapi */
+    {
+        if ((options-=
>management_flags & MF_EXTERNAL_KEY) && options->priv_key_file)
+        {
=
+            msg(M_USAGE, "--key and --management-external-key are mutually=
 exclusive");
+        }
+        if ((options->management_flags & MF_EXTER=
NAL_CERT))
+        {
+            if (options->cert_file)
+            {
+=
                msg(M_USAGE, "--cert and --management-external-cert are mut=
ually exclusive");
+            }
+            else if (!(options->manageme=
nt_flags & MF_EXTERNAL_KEY))
+            {
+                msg(M_USAGE,
+=
                    "--management-external-cert must be used with --managem=
ent-external-key");
+            }
+        }
         if (pull)
         {=

-            msg(M_USAGE, use_err, "--pull");
+            const int sum =
=3D
+                ((options->cert_file !=3D NULL) || (options->managemen=
t_flags & MF_EXTERNAL_CERT))
+                + ((options->priv_key_file !=
=3D NULL)
+                   || (options->management_flags & MF_EXTERNAL_K=
EY));
+
+            if (sum =3D=3D 0)
+            {
+                if (=
!options->auth_user_pass_file)
+                {
+                    msg(=
M_USAGE, "No client-side authentication method is "
+                      =
           "specified=2E  You must use either "
+                          =
       "--cert/--key, --pkcs12, or "
+                                 "--a=
uth-user-pass");
+                }
+            }
+            else if (su=
m !=3D 2)
+            {
+                msg(M_USAGE, "If you use one of -=
-cert or --key, you must use them both");
+            }
+        }
+      =
  else
+        {
+            if (!(options->management_flags & MF_EXTERNA=
L_CERT))
+            {
+                notnull(options->cert_file,
+     =
                   "certificate file (--cert) or PKCS#12 file (--pkcs12)");=

+            }
+            if (!(options->management_flags & MF_EXTERNAL_=
KEY))
+            {
+                notnull(options->priv_key_file,
+    =
                    "private key file (--key) or PKCS#12 file (--pkcs12)");=

+            }
         }
     }
+    if (ce->tls_auth_file && ce->tls_cry=
pt_file)
+    {
+        msg(M_USAGE, "--tls-auth and --tls-crypt are mutua=
lly exclusive");
+    }
+    if (options->tls_client && ce->tls_crypt_v2_fi=
le
+        && (ce->tls_auth_file || ce->tls_crypt_file))
+    {
+        m=
sg(M_USAGE,
+            "--tls-crypt-v2, --tls-auth and --tls-crypt are mu=
tually exclusive in client mode");
+    }
+
+
     if (options->auth_user_p=
ass_file && !options->pull)
     {
         msg(M_USAGE, "--auth-user-pass =
requires --pull");
@@ -6957,32 +6887,6 @@
             goto err;
         }=

     }
-    else if (streq(p[0], "secret") && p[1] && !p[3])
-    {
-     =
   msg(M_WARN, "DEPRECATED OPTION: The option --secret is deprecated=2E");
=
-        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
-        options-=
>shared_secret_file =3D p[1];
-        options->shared_secret_file_inline =
=3D is_inline;
-        if (!is_inline && p[2])
-        {
-            int=
 key_direction;
-
-            key_direction =3D ascii2keydirection(msgleve=
l, p[2]);
-            if (key_direction >=3D 0)
-            {
-          =
      options->key_direction =3D key_direction;
-            }
-           =
 else
-            {
-                goto err;
-            }
-        }
-=
    }
-    else if (streq(p[0], "allow-deprecated-insecure-static-crypto"))=

-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->allow_=
deprecated_insecure_static_crypto =3D true;
-    }
     else if (streq(p[0]=
, "genkey") && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
dif=
f --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index c58530a=
=2E=2E129267f 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/option=
s=2Eh
@@ -569,9 +569,6 @@
     struct static_challenge_info sc_info;
 #endi=
f
     /* Cipher parms */
-    const char *shared_secret_file;
-    bool sh=
ared_secret_file_inline;
-    bool allow_deprecated_insecure_static_crypto;=

     int key_direction;
     const char *ciphername;
     bool enable_ncp_=
fallback; /**< If defined fall back to
diff --git a/src/openvpn/options_sho=
w=2Ec b/src/openvpn/options_show=2Ec
index 80d36f0=2E=2E321a37b 100644
--- =
a/src/openvpn/options_show=2Ec
+++ b/src/openvpn/options_show=2Ec
@@ -491,7=
 +491,6 @@
     }
 #endif
 
-    SHOW_STR_INLINE(shared_secret_file);
     =
SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false, true),=
 "%s");
     SHOW_STR(ciphername);
     SHOW_STR(ncp_ciphers);
diff --git a=
/src/openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec
index cfc0=
595=2E=2E2fd90dd 100644
--- a/src/openvpn/options_string=2Ec
+++ b/src/open=
vpn/options_string=2Ec
@@ -140,83 +140,72 @@
     /*
      * Crypto Options=

      */
-    if (o->shared_secret_file || TLS_CLIENT || TLS_SERVER)
+    =
struct key_type kt;
+
+    ASSERT((TLS_CLIENT =3D=3D true) + (TLS_SERVER =
=3D=3D true) <=3D 1);
+
+    /* Skip resolving BF-CBC to allow SSL librarie=
s without BF-CBC
+     * to work here in the default configuration */
+    =
const char *ciphername =3D o->ciphername;
+    size_t keysize =3D 0;
+
+   =
 if (strcmp(o->ciphername, "BF-CBC") =3D=3D 0)
     {
-        struct key_t=
ype kt;
-
-        ASSERT((o->shared_secret_file !=3D NULL) + (TLS_CLIENT =
=3D=3D true) + (TLS_SERVER =3D=3D true) <=3D 1);
-
-        /* Skip resolvi=
ng BF-CBC to allow SSL libraries without BF-CBC
-         * to work here in=
 the default configuration */
-        const char *ciphername =3D o->cipher=
name;
-        size_t keysize =3D 0;
-
-        if (strcmp(o->ciphername, "=
BF-CBC") =3D=3D 0)
+        init_key_type(&kt, "none", o->authname, false);=

+        keysize =3D 128;
+    }
+    else
+    {
+        init_key_type(&=
kt, o->ciphername, o->authname, false);
+        ciphername =3D cipher_kt_n=
ame(kt=2Ecipher);
+        if (cipher_defined(o->ciphername))
         {
- =
           init_key_type(&kt, "none", o->authname, true, false);
-         =
   keysize =3D 128;
-        }
-        else
-        {
-            init_k=
ey_type(&kt, o->ciphername, o->authname, true, false);
-            ciphern=
ame =3D cipher_kt_name(kt=2Ecipher);
-            if (cipher_defined(o->cip=
hername))
-            {
-                keysize =3D cipher_kt_key_size(kt=
=2Ecipher) * 8;
-            }
-        }
-        /* Only announce the cip=
her to our peer if we are willing to
-         * support it */
-        if =
(p2p_nopull || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
-      =
  {
-            buf_printf(&out, ",cipher %s", ciphername);
-        }
-  =
      buf_printf(&out, ",auth %s", md_kt_name(kt=2Edigest));
-        buf_p=
rintf(&out, ",keysize %zu", keysize);
-        if (o->shared_secret_file)
-=
        {
-            buf_printf(&out, ",secret");
+            keysize =
=3D cipher_kt_key_size(kt=2Ecipher) * 8;
         }
     }
+    /* Only ann=
ounce the cipher to our peer if we are willing to
+     * support it */
+  =
  if (p2p_nopull || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
+ =
   {
+        buf_printf(&out, ",cipher %s", ciphername);
+    }
+    buf_p=
rintf(&out, ",auth %s", md_kt_name(kt=2Edigest));
+    buf_printf(&out, ",k=
eysize %zu", keysize);
 
     /*
      * SSL Options
      */
+    if (o->c=
e=2Etls_auth_file)
     {
-        if (TLS_CLIENT || TLS_SERVER)
-        {=

-            if (o->ce=2Etls_auth_file)
-            {
-                bu=
f_printf(&out, ",tls-auth");
-            }
-            /* Not adding tls-=
crypt here, because we won't reach this code if
-             * tls-auth/tl=
s-crypt does not match=2E  Removing tls-auth here would
-             * bre=
ak stuff, so leaving that in place=2E */
+        buf_printf(&out, ",tls-au=
th");
+    }
+    /* Not adding tls-crypt here, because we won't reach this=
 code if
+     * tls-auth/tls-crypt does not match=2E  Removing tls-auth he=
re would
+     * break stuff, so leaving that in place=2E */
 
-           =
 buf_printf(&out, ",key-method %d", KEY_METHOD_2);
-        }
+    buf_prin=
tf(&out, ",key-method %d", KEY_METHOD_2);
 
-        if (remote)
+
+    if =
(remote)
+    {
+        if (TLS_CLIENT)
         {
-            if (TLS_CL=
IENT)
-            {
-                buf_printf(&out, ",tls-server");
-   =
         }
-            else if (TLS_SERVER)
-            {
-              =
  buf_printf(&out, ",tls-client");
-            }
+            buf_printf(&=
out, ",tls-server");
         }
-        else
+        else if (TLS_SERVER)=

         {
-            if (TLS_CLIENT)
-            {
-                bu=
f_printf(&out, ",tls-client");
-            }
-            else if (TLS_SER=
VER)
-            {
-                buf_printf(&out, ",tls-server");
-    =
        }
+            buf_printf(&out, ",tls-client");
+        }
+    }
+=
    else
+    {
+        if (TLS_CLIENT)
+        {
+            buf_printf=
(&out, ",tls-client");
+        }
+        else if (TLS_SERVER)
+        {
=
+            buf_printf(&out, ",tls-server");
         }
     }
 
diff --gi=
t a/src/openvpn/options_string=2Eh b/src/openvpn/options_string=2Eh
index 0=
2efed3=2E=2E6d5518a 100644
--- a/src/openvpn/options_string=2Eh
+++ b/src/o=
penvpn/options_string=2Eh
@@ -59,7 +59,6 @@
  *
  * --cipher
  * --auth
- *=
 --secret
  *
  * SSL Options:
  *
diff --git a/src/openvpn/ssl=2Ec b/src/o=
penvpn/ssl=2Ec
index ddee3eb=2E=2E55043e5 100644
--- a/src/openvpn/ssl=2Ec
=
+++ b/src/openvpn/ssl=2Ec
@@ -1644,7 +1644,7 @@
         return true;
     =
}
 
-    init_key_type(&session->opt->key_type, options->ciphername, option=
s->authname, true, true);
+    init_key_type(&session->opt->key_type, optio=
ns->ciphername, options->authname, true);
 
     bool packet_id_long_form =
=3D cipher_kt_mode_ofb_cfb(session->opt->key_type=2Ecipher);
     session->=
opt->crypto_flags &=3D ~(CO_PACKET_ID_LONG_FORM);
diff --git a/tests/unit_t=
ests/openvpn/test_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec
ind=
ex 07c54b4=2E=2Ef86aca8 100644
--- a/tests/unit_tests/openvpn/test_crypto=
=2Ec
+++ b/tests/unit_tests/openvpn/test_crypto=2Ec
@@ -237,70 +237,58 @@
 =
    /* common defaults */
     o=2Ece=2Etun_mtu =3D 1400;
     o=2Ece=2Epro=
to =3D PROTO_UDP;
+    o=2Etls_client =3D true;
+    o=2Epull =3D true;
 
-=
    /* No crypto at all */
+    /*  auth none, cipher none */
     o=2Eciph=
ername =3D "none";
     o=2Eauthname =3D "none";
     linkmtu =3D calc_opti=
ons_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1400);
+    ass=
ert_int_equal(linkmtu, 1405);
 
-    /* Static key OCC examples */
-    o=
=2Eshared_secret_file =3D "not null";
-
-    /* secret, auth none, cipher n=
one */
-    o=2Eciphername =3D "none";
-    o=2Eauthname =3D "none";
-    l=
inkmtu =3D calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(link=
mtu, 1408);
-
-    /* secret, cipher AES-128-CBC, auth none */
+    /* ciph=
er AES-128-CBC, auth none */
     o=2Eciphername =3D "AES-128-CBC";
     o=
=2Eauthname =3D "none";
     linkmtu =3D calc_options_string_link_mtu(&o, &=
f);
-    assert_int_equal(linkmtu, 1440);
+    assert_int_equal(linkmtu, 14=
37);
 
-    /* secret, cipher none, auth SHA256 */
+    /* cipher none, aut=
h SHA256 */
     o=2Eciphername =3D "none";
     o=2Eauthname =3D "SHA256";=

     linkmtu =3D calc_options_string_link_mtu(&o, &f);
-    assert_int_equ=
al(linkmtu, 1440);
+    assert_int_equal(linkmtu, 1437);
 
-    /* secret, =
cipher BF-CBC, auth SHA1 */
+    /* cipher BF-CBC, auth SHA1 */
     o=2Eci=
phername =3D "BF-CBC";
     o=2Eauthname =3D "SHA1";
     linkmtu =3D calc_=
options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1444);
+   =
 assert_int_equal(linkmtu, 1441);
 
-    /* secret, cipher BF-CBC, auth SHA=
1, tcp-client */
+    /* cipher BF-CBC, auth SHA1, tcp-client */
     o=2Ec=
e=2Eproto =3D PROTO_TCP_CLIENT;
     linkmtu =3D calc_options_string_link_m=
tu(&o, &f);
-    assert_int_equal(linkmtu, 1446);
+    assert_int_equal(lin=
kmtu, 1443);
 
     o=2Ece=2Eproto =3D PROTO_UDP;
 
 #if defined(USE_COMP)
=
     o=2Ecomp=2Ealg =3D COMP_ALG_LZO;
 
-    /* secret, comp-lzo yes, ciphe=
r BF-CBC, auth SHA1 */
+    /*  comp-lzo yes, cipher BF-CBC, auth SHA1 */
 =
    linkmtu =3D calc_options_string_link_mtu(&o, &f);
-    assert_int_equal=
(linkmtu, 1445);
+    assert_int_equal(linkmtu, 1442);
 
 #if defined(ENABL=
E_FRAGMENT)
-    /* secret, comp-lzo yes, cipher BF-CBC, auth SHA1, fragmen=
t 1200 */
+    /* comp-lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */
=
     o=2Ece=2Efragment =3D 1200;
     linkmtu =3D calc_options_string_link_=
mtu(&o, &f);
-    assert_int_equal(linkmtu, 1449);
+    assert_int_equal(li=
nkmtu, 1446);
     o=2Ece=2Efragment =3D 0;
 #endif
 
     o=2Ecomp=2Ealg =
=3D COMP_ALG_UNDEF;
 #endif
 
-    /* TLS mode */
-    o=2Eshared_secret_fi=
le =3D NULL;
-    o=2Etls_client =3D true;
-    o=2Epull =3D true;
-
     /=
* tls client, cipher AES-128-CBC, auth SHA1, tls-auth */
     o=2Eauthname =
=3D "SHA1";
     o=2Eciphername =3D "AES-128-CBC";
@@ -315,15 +303,8 @@
   =
  linkmtu =3D calc_options_string_link_mtu(&o, &f);
     assert_int_equal(l=
inkmtu, 1457);
 
-    /* tls client, cipher none, auth none */
+    /* tls =
client, auth none, cipher AES-256-GCM */
     o=2Eauthname =3D "none";
-   =
 o=2Eciphername =3D "none";
-
-    linkmtu =3D calc_options_string_link_mtu=
(&o, &f);
-    assert_int_equal(linkmtu, 1405);
-
-    /* tls client, auth =
SHA1, cipher AES-256-GCM */
-    o=2Eauthname =3D "SHA1";
     o=2Ecipherna=
me =3D "AES-256-GCM";
     linkmtu =3D calc_options_string_link_mtu(&o, &f)=
;
     assert_int_equal(linkmtu, 1449);
@@ -332,12 +313,12 @@
 #if defined(=
USE_COMP) && defined(ENABLE_FRAGMENT)
     o=2Ecomp=2Ealg =3D COMP_ALG_LZO;=

 
-    /* tls client, auth SHA1, cipher AES-256-GCM, fragment, comp-lzo ye=
s */
+    /* tls client, auth none, cipher AES-256-GCM, fragment, comp-lzo =
yes */
     o=2Ece=2Efragment =3D 1200;
     linkmtu =3D calc_options_strin=
g_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1454);
 
-    /* tls cli=
ent, auth SHA1, cipher AES-256-GCM, fragment, comp-lzo yes, socks */
+    /=
* tls client, auth none, cipher AES-256-GCM, fragment, comp-lzo yes, socks =
*/
     o=2Ece=2Esocks_proxy_server =3D "socks=2Eexample=2Ecom";
     linkm=
tu =3D calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu,=
 1464);
@@ -358,50 +339,41 @@
     o=2Ece=2Etun_mtu =3D 1400;
     o=2Ece=
=2Emssfix =3D 1000;
     o=2Ece=2Eproto =3D PROTO_UDP;
+    o=2Etls_client =
=3D true;
 
-    /* No crypto at all */
+    /*auth none, cipher none */
  =
   o=2Eciphername =3D "none";
     o=2Eauthname =3D "none";
     struct key=
_type kt;
-    init_key_type(&kt, o=2Eciphername, o=2Eauthname, false, fals=
e);
+    init_key_type(&kt, o=2Eciphername, o=2Eauthname, false);
 
-    /*=
 No encryption, just packet id (8) + TCP payload(20) + IP payload(20) */
+ =
   /* No encryption, just packet id (4) + opcode (1) + TCP payload(20) + IP=
 payload(20) */
     frame_calculate_dynamic(&f, &kt, &o, NULL);
-    asser=
t_int_equal(f=2Emss_fix, 952);
+    assert_int_equal(f=2Emss_fix, 955);
 
-=
    /* Static key OCC examples */
-    o=2Eshared_secret_file =3D "not null=
";
-
-    /* secret, auth none, cipher none */
-    o=2Eciphername =3D "non=
e";
-    o=2Eauthname =3D "none";
-    init_key_type(&kt, o=2Eciphername, o=
=2Eauthname, false, false);
-    frame_calculate_dynamic(&f, &kt, &o, NULL)=
;
-    assert_int_equal(f=2Emss_fix, 952);
-
-    /* secret, cipher AES-128=
-CBC, auth none */
+    /* cipher AES-128-CBC, auth none */
     o=2Ecipher=
name =3D "AES-128-CBC";
     o=2Eauthname =3D "none";
-    init_key_type(&k=
t, o=2Eciphername, o=2Eauthname, false, false);
+    init_key_type(&kt, o=
=2Eciphername, o=2Eauthname, false);
 
-    for (int i =3D 990; i <=3D 1010=
; i++)
+    for (int i =3D 990; i <=3D 1015; i++)
     {
         /* 992 - =
1008 should end up with the same mssfix value all they
-         * all resu=
lt in the same CBC block size/padding and <=3D 991 and >=3D1008
+         *=
 all result in the same CBC block size/padding and <=3D 992 and >=3D1009
  =
        * should be one block less and more respectively */
         o=2Ece=
=2Emssfix =3D i;
         frame_calculate_dynamic(&f, &kt, &o, NULL);
-    =
    if (i <=3D 991)
+        if (i <=3D 992)
         {
-            assert=
_int_equal(f=2Emss_fix, 911);
+            assert_int_equal(f=2Emss_fix, 91=
5);
         }
-        else if (i >=3D 1008)
+        else if (i >=3D 1009=
)
         {
-            assert_int_equal(f=2Emss_fix, 943);
+            =
assert_int_equal(f=2Emss_fix, 947);
         }
         else
         {
-  =
          assert_int_equal(f=2Emss_fix, 927);
+            assert_int_equal=
(f=2Emss_fix, 931);
         }
     }
 #ifdef USE_COMP
@@ -410,36 +382,35 @=
@
     /* Same but with compression added=2E Compression adds one byte extr=
a to the
      * payload so the payload should be reduced by compared to th=
e no
      * compression calculation before */
-    for (int i =3D 990; i <=
=3D 1010; i++)
+    for (int i =3D 990; i <=3D 1015; i++)
     {
         /=
* 992 - 1008 should end up with the same mssfix value all they
-         * =
all result in the same CBC block size/padding and <=3D 991 and >=3D1008
+  =
       * all result in the same CBC block size/padding and <=3D 992 and >=
=3D1009
          * should be one block less and more respectively */
     =
    o=2Ece=2Emssfix =3D i;
         frame_calculate_dynamic(&f, &kt, &o, NU=
LL);
-        if (i <=3D 991)
+        if (i <=3D 992)
         {
-        =
    assert_int_equal(f=2Emss_fix, 910);
+            assert_int_equal(f=2Em=
ss_fix, 914);
         }
-        else if (i >=3D 1008)
+        else if (i=
 >=3D 1009)
         {
-            assert_int_equal(f=2Emss_fix, 942);
+  =
          assert_int_equal(f=2Emss_fix, 946);
         }
         else
    =
     {
-            assert_int_equal(f=2Emss_fix, 926);
+            assert=
_int_equal(f=2Emss_fix, 930);
         }
     }
     o=2Ecomp=2Ealg =3D COM=
P_ALG_UNDEF;
 #endif /* ifdef USE_COMP */
 
-    /* tls client, auth SHA1, =
cipher AES-256-GCM */
+    /*  auth SHA1, cipher AES-256-GCM */
     o=2Eau=
thname =3D "SHA1";
     o=2Eciphername =3D "AES-256-GCM";
-    o=2Etls_clie=
nt =3D true;
     o=2Epeer_id =3D 77;
     o=2Euse_peer_id =3D true;
-    i=
nit_key_type(&kt, o=2Eciphername, o=2Eauthname, true, false);
+    init_key=
_type(&kt, o=2Eciphername, o=2Eauthname, false);
 
     for (int i =3D 900;=
 i <=3D 1200; i++)
     {
@@ -685,7 +656,7 @@
 
     data->gc =3D gc_new();=

 
-    init_key_type(&data->kt, "AES-128-GCM", "none", true, false);
+    =
init_key_type(&data->kt, "AES-128-GCM", "none", false);
 
     /* have an e=
poch key that uses 0x23 for the key for all bytes */
     struct epoch_key =
epoch1send =3D { =2Eepoch =3D 1, =2Eepoch_key =3D { 0x23 } };
@@ -907,7 +87=
8,7 @@
     struct epoch_key e17 =3D { =2Eepoch =3D 17, =2Eepoch_key =3D { =
19, 12 } };
     struct key_type kt =3D { 0 };
     struct key_parameters k=
ey_parameters =3D { 0 };
-    init_key_type(&kt, "AES-192-GCM", "none", tru=
e, false);
+    init_key_type(&kt, "AES-192-GCM", "none", false);
 
 
     =
epoch_data_key_derive(&key_parameters, &e17, &kt);
diff --git a/tests/unit_=
tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index fb=
bb40f=2E=2E49ba833 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b=
/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -173,7 +173,7 @@
     tas=2Etls_w=
rap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);
 
  =
   struct key_type tls_crypt_kt;
-    init_key_type(&tls_crypt_kt, "none", =
"SHA1", true, false);
+    init_key_type(&tls_crypt_kt, "none", "SHA1", fal=
se);
 
     crypto_read_openvpn_key(&tls_crypt_kt, &tas=2Etls_wrap=2Eopt=2E=
key_ctx_bi, static_key, true,
                             key_direction, "=
Control Channel Authentication", "tls-auth", NULL);

-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f=
368
Gerrit-Change-Number: 2081
Gerrit-PatchSet: 5
Gerrit-Owner: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--73XDVL6DjSc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe <strong>uploaded patch set #5</strong> to this change=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">View=
 Change</a></p><p>The following approvals got outdated and were removed:
Co=
de-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">Remove support for --s=
ecret<br><br>This has been announced for a long time and good alternatives =
exist=2E<br><br>Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368<br>Sig=
ned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M Changes=2Em=
d<br>M INSTALL<br>M doc/man-sections/generic-options=2Erst<br>M doc/man-sec=
tions/protocol-options=2Erst<br>M doc/man-sections/unsupported-options=2Ers=
t<br>M src/openvpn/check_file_access=2Ec<br>M src/openvpn/crypto=2Ec<br>M s=
rc/openvpn/crypto=2Eh<br>M src/openvpn/helper=2Ec<br>M src/openvpn/init=2Ec=
<br>M src/openvpn/mtu=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/opt=
ions=2Eh<br>M src/openvpn/options_show=2Ec<br>M src/openvpn/options_string=
=2Ec<br>M src/openvpn/options_string=2Eh<br>M src/openvpn/ssl=2Ec<br>M test=
s/unit_tests/openvpn/test_crypto=2Ec<br>M tests/unit_tests/openvpn/test_pkt=
=2Ec<br>19 files changed, 256 insertions(+), 522 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/81/2081/5</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><s=
pan>index b5ae881=2E=2E7f47f77 100644</span><br><span>--- a/Changes=2Emd</s=
pan><br><span>+++ b/Changes=2Emd</span><br><span>@@ -23,6 +23,13 @@</span><=
br><span>   the characters mentioned above were already escaped=2E However,=
 the behavior of</span><br><span>   Mbed TLS is slightly different from Ope=
nSSL in that it also escapes &quot;=3D&quot;=2E</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+* **`secret` has been removed=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  Static key mode (non-TLS) is no lo=
nger considered &quot;good and secure enough&quot; for</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  today&#39;s requirements=2E Use TLS mo=
de instead=2E If deploying a PKI CA is considered</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &quot;too complicated&quot;, using `--peer-=
fingerprint` makes TLS mode about as easy as</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  using `--secret`=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> ## Maintainer-visible changes<=
/span><br><span> </span><br><span> - The configure-time option `--enable-de=
bug` is no longer  available</span><br><span>diff --git a/INSTALL b/INSTALL=
</span><br><span>index 486b1ae=2E=2Ed0ffaf0 100644</span><br><span>--- a/IN=
STALL</span><br><span>+++ b/INSTALL</span><br><span>@@ -144,8 +144,7 @@</sp=
an><br><span> </span><br><span> Test Crypto:</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-=2E/openvpn --genkey secret key</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-=2E/openvpn --test-crypt=
o --secret key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=2E/o=
penvpn --test-crypto</span><br><span> </span><br><span> Test SSL/TLS negoti=
ations (runs for 2 minutes):</span><br><span> </span><br><span>diff --git a=
/doc/man-sections/generic-options=2Erst b/doc/man-sections/generic-options=
=2Erst</span><br><span>index 6815dc2=2E=2E17e4372 100644</span><br><span>--=
- a/doc/man-sections/generic-options=2Erst</span><br><span>+++ b/doc/man-se=
ctions/generic-options=2Erst</span><br><span>@@ -108,7 +108,7 @@</span><br>=
<span>   For example on Windows, use double backslashes to represent pathna=
mes:</span><br><span>   ::</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-      secret &quot;c:\\OpenVPN\\secret=2Ekey&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      tls-auth &quot;=
c:\\OpenVPN\\secret=2Ekey&quot;</span><br><span> </span><br><span> </span><=
br><span>   For examples of configuration files, see</span><br><span>@@ -11=
9,7 +119,7 @@</span><br><span> </span><br><span>       #</span><br><span>  =
     # Sample OpenVPN configuration file for</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-      # using a pre-shared static key=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+      # using a p2p connection=
=2E</span><br><span>       #</span><br><span>       # &#39;#&#39; or &#39;;=
&#39; may be used to delimit comments=2E</span><br><span> </span><br><span>=
@@ -133,8 +133,11 @@</span><br><span>       # 10=2E1=2E0=2E2 is our remote =
VPN endpoint</span><br><span>       ifconfig 10=2E1=2E0=2E1 10=2E1=2E0=2E2<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
  # Our pre-shared static key</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-      secret static=2Ekey</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      # Our TLS configuration</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      tls-client</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      key mynode=2Ekey</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      cert mynode=2Ecrt</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      ca myca=2Ecrt</span><br><span> </span><br=
><span> --daemon progname</span><br><span>   Become a daemon after all init=
ialization functions are completed=2E</span><br><span>diff --git a/doc/man-=
sections/protocol-options=2Erst b/doc/man-sections/protocol-options=2Erst</=
span><br><span>index 52ce5a8=2E=2Eb785ebe 100644</span><br><span>--- a/doc/=
man-sections/protocol-options=2Erst</span><br><span>+++ b/doc/man-sections/=
protocol-options=2Erst</span><br><span>@@ -212,11 +212,6 @@</span><br><span=
>   have been configured with ``--enable-small``</span><br><span>   (typica=
lly used on routers or other embedded devices)=2E</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>---allow-dep=
recated-insecure-static-crypto</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-   **DEPRECATED** This allow using OpenVPN without TLS=2E This is =
deprecated</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   and will=
 be removed in OpenVPN 2=2E8=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> --tran-window n</span><br><span>   Transition w=
indow -- our old key can live this many seconds after a new</span><br><span=
>   a key renegotiation begins (default :code:`3600` seconds)=2E This featu=
re</span><br><span>diff --git a/doc/man-sections/unsupported-options=2Erst =
b/doc/man-sections/unsupported-options=2Erst</span><br><span>index c273905=
=2E=2E2794f12 100644</span><br><span>--- a/doc/man-sections/unsupported-opt=
ions=2Erst</span><br><span>+++ b/doc/man-sections/unsupported-options=2Erst=
</span><br><span>@@ -70,3 +70,12 @@</span><br><span>   Removed in OpenVPN 2=
=2E8=2E This option caused the Mbed TLS 3 random number</span><br><span>   =
generator to be reseeded on every call=2E It has been removed because this<=
/span><br><span>   is excessive=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--se=
cret</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Removed in Op=
enVPN 2=2E8=2E Static encryption without a transient key</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  (generated by DH or ECDH) has been c=
onsidered problematic for many</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  years=2E Please use ``--peer-fingerprint`` and self-signed cer=
tificates</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  for smal=
l setups=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+--allow-deprecated-insecure=
-static-crypto</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Rem=
oved in OpenVPN 2=2E8 as --secret was also removed=2E</span><br><span>diff =
--git a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file_access=
=2Ec</span><br><span>index 83654b2=2E=2E90dbb4e 100644</span><br><span>--- =
a/src/openvpn/check_file_access=2Ec</span><br><span>+++ b/src/openvpn/check=
_file_access=2Ec</span><br><span>@@ -312,10 +312,6 @@</span><br><span>     =
                                     ce-&gt;tls_crypt_v2_file, R_OK, &quot;=
--tls-crypt-v2&quot;);</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        check_file_access_inline(options-=
&gt;shared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                 opt=
ions-&gt;shared_secret_file, R_OK, &quot;--secret&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     errs |=3D check_f=
ile_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;packet_id_file,</=
span><br><span>                               R_OK | W_OK, &quot;--replay-p=
ersist&quot;);</span><br><span> </span><br><span>diff --git a/src/openvpn/c=
rypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index ff17b22=2E=2Ed3752=
73 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ =
b/src/openvpn/crypto=2Ec</span><br><span>@@ -872,7 +872,7 @@</span><br><spa=
n>  * Build a struct key_type=2E</span><br><span>  */</span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_key_type(struct =
key_type *kt, const char *ciphername, const char *authname, bool tls_mode,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_key_type(struct=
 key_type *kt, const char *ciphername, const char *authname,</span><br><spa=
n>               bool warn)</span><br><span> {</span><br><span>     bool ae=
ad_cipher =3D false;</span><br><span>@@ -891,9 +891,9 @@</span><br><span> <=
/span><br><span>         /* check legal cipher mode */</span><br><span>    =
     aead_cipher =3D cipher_kt_mode_aead(kt-&gt;cipher);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (!(cipher_kt_mode_cbc(kt-&gt;=
cipher) || (tls_mode &amp;&amp; aead_cipher)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (!(cipher_kt_mode_cbc(kt-&gt;cipher) ||=
 aead_cipher</span><br><span> #ifdef ENABLE_OFB_CFB_MODE</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-              || (tls_mode &amp;&amp; ci=
pher_kt_mode_ofb_cfb(kt-&gt;cipher))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+              || cipher_kt_mode_ofb_cfb(kt-&gt;cipher)</sp=
an><br><span> #endif</span><br><span>                   ))</span><br><span>=
         {</span><br><span>diff --git a/src/openvpn/crypto=2Eh b/src/openvp=
n/crypto=2Eh</span><br><span>index dbe0802=2E=2E203f77b 100644</span><br><s=
pan>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/crypto=
=2Eh</span><br><span>@@ -420,11 +420,9 @@</span><br><span>  * @param kt    =
      The struct key_type to initialize</span><br><span>  * @param cipherna=
me  The name of the cipher to use</span><br><span>  * @param authname    Th=
e name of the HMAC digest to use</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @param tls_mode    Specifies whether we are running in TLS mo=
de, which allows</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   =
                 more ciphers than static key mode=2E</span><br><span>  * @=
param warn        Print warnings when null cipher / auth is used=2E</span><=
br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void ini=
t_key_type(struct key_type *kt, const char *ciphername, const char *authnam=
e, bool tls_mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id init_key_type(struct key_type *kt, const char *ciphername, const char *a=
uthname,</span><br><span>                    bool warn);</span><br><span> <=
/span><br><span> /*</span><br><span>diff --git a/src/openvpn/helper=2Ec b/s=
rc/openvpn/helper=2Ec</span><br><span>index d29895b=2E=2E6b5fcee6 100644</s=
pan><br><span>--- a/src/openvpn/helper=2Ec</span><br><span>+++ b/src/openvp=
n/helper=2Ec</span><br><span>@@ -266,12 +266,6 @@</span><br><span>         =
    msg(M_USAGE, &quot;--server and --server-bridge cannot be used together=
&quot;);</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (o-&gt;shared_secret_file)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                &quot;--server and -=
-secret cannot be used together (you must use SSL/TLS keys)&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         if (!(o-&gt;ser=
ver_flags &amp; SF_NOPOOL) &amp;&amp; o-&gt;ifconfig_pool_defined)</span><b=
r><span>         {</span><br><span>             msg(M_USAGE,</span><br><spa=
n>@@ -461,12 +455,6 @@</span><br><span>                 &quot;--server-brid=
ge already defines an ifconfig-pool, so you can&#39;t also specify --ifconf=
ig-pool explicitly&quot;);</span><br><span>         }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (o-&gt;shared_=
secret_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USA=
GE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &q=
uot;--server-bridge and --secret cannot be used together (you must use SSL/=
TLS keys)&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
>         if (dev !=3D DEV_TYPE_TAP)</span><br><span>         {</span><br><=
span>             msg(M_USAGE, &quot;--server-bridge directive only makes s=
ense with --dev tap&quot;);</span><br><span>diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec</span><br><span>index 6c87865=2E=2Eff00151 1006=
44</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/ope=
nvpn/init=2Ec</span><br><span>@@ -1000,35 +1000,10 @@</span><br><span>     =
    platform_mlockall(true);</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-     * We do not want user to use --genkey=
 with --secret=2E In the transistion</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     * phase we for secret=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (options-&gt;genkey &amp;&amp; options-&gt;genkey_type !=3D=
 GENKEY_SECRET &amp;&amp; options-&gt;shared_secret_file)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(M_USAGE, &quot;Using --genkey type with --s=
ecret filename is &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                     &quot;not supported=2E  Use --genkey type filename =
instead=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span>     if (options-&gt;genkey &amp;&amp; options-&gt;genke=
y_type =3D=3D GENKEY_SECRET)</span><br><span>     {</span><br><span>       =
  int nbits_written;</span><br><span>         const char *genkey_filename =
=3D options-&gt;genkey_filename;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (options-&gt;shared_secret_file &amp;&amp; options-&g=
t;genkey_filename)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg=
(M_USAGE, &quot;You must provide a filename to either --genkey &quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                         &q=
uot;or --secret, not both&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-         * Copy filename from sh=
ared_secret_file to genkey_filename to support</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-         * the old --genkey --secret foo=2Efile sy=
ntax=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;=
shared_secret_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ms=
g(M_WARN, &quot;WARNING: Using --genkey --secret filename is &quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        &quot=
;DEPRECATED=2E  Use --genkey secret filename instead=2E&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            genkey_filename =3D o=
ptions-&gt;shared_secret_file;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span> </span><br><span>         nbits_written=
 =3D write_key_file(2, genkey_filename);</span><br><span>         if (nbits=
_written &lt; 0)</span><br><span>@@ -1037,7 +1012,7 @@</span><br><span>    =
     }</span><br><span> </span><br><span>         msg(D_GENKEY | M_NOPREFIX=
, &quot;Randomly generated %d bit key written to %s&quot;, nbits_written,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt=
;shared_secret_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            options-&gt;genkey_filename ? options-&gt;genkey_filename : &=
quot;stdout&quot;);</span><br><span>         return true;</span><br><span> =
    }</span><br><span>     else if (options-&gt;genkey &amp;&amp; options-&=
gt;genkey_type =3D=3D GENKEY_TLS_CRYPTV2_SERVER)</span><br><span>@@ -1083,7=
 +1058,7 @@</span><br><span>     /* sanity check on options for --mktun or =
--rmtun */</span><br><span>     notnull(options-&gt;dev, &quot;TUN/TAP devi=
ce (--dev)&quot;);</span><br><span>     if (options-&gt;ce=2Eremote || opti=
ons-&gt;ifconfig_local || options-&gt;ifconfig_remote_netmask</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        || options-&gt;shared_secre=
t_file || options-&gt;tls_server || options-&gt;tls_client)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        || options-&gt;tls_server |=
| options-&gt;tls_client)</span><br><span>     {</span><br><span>         m=
sg(M_FATAL | M_OPTERR,</span><br><span>             &quot;options --mktun o=
r --rmtun should only be used together with --dev&quot;);</span><br><span>@=
@ -3015,8 +2990,7 @@</span><br><span>     ASSERT(!key_ctx_bi_defined(&amp;c=
-&gt;c1=2Eks=2Estatic_key));</span><br><span> </span><br><span>     /* Init=
 cipher and hash algorithm */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, options-&gt;cipher=
name, options-&gt;authname,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                  options-&gt;test_crypto, true);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;c-&gt;c1=2Eks=2E=
key_type, options-&gt;ciphername, options-&gt;authname, true);</span><br><s=
pan> </span><br><span>     generate_test_crypto_random_key(&amp;c-&gt;c1=2E=
ks=2Ekey_type, &amp;c-&gt;c1=2Eks=2Estatic_key,</span><br><span>           =
                          &quot;test crypto key&quot;);</span><br><span>@@ =
-3026,50 +3000,6 @@</span><br><span> }</span><br><span> </span><br><span> /=
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Static Key Mode (=
using a pre-shared key)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-do_init_crypto_static(stru=
ct context *c, const unsigned int flags)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   const struct options *options =3D &amp;c-&gt;options;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    ASSERT(options-&gt;shared_secret_fil=
e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    init_crypto_pre(c, flags);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* Initialize flags */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (c-&gt;options=2Emute_replay_warnings)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=2Ecrypto_options=2Efl=
ags |=3D CO_MUTE_REPLAY_WARNINGS;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Initialize packet =
ID tracking */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pac=
ket_id_init(&amp;c-&gt;c2=2Ecrypto_options=2Epacket_id, options-&gt;replay_=
window, options-&gt;replay_time,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                   &quot;STATIC&quot;, 0);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Ecrypto_options=2Epid_persist=
 =3D &amp;c-&gt;c1=2Epid_persist;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    c-&gt;c2=2Ecrypto_options=2Eflags |=3D CO_PACKET_ID_LONG_FO=
RM;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_pers=
ist_load_obj(&amp;c-&gt;c1=2Epid_persist, &amp;c-&gt;c2=2Ecrypto_options=2E=
packet_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (!key_ctx_bi_defined(&am=
p;c-&gt;c1=2Eks=2Estatic_key))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 /* Get cipher &amp; hash algorithms */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, opti=
ons-&gt;ciphername, options-&gt;authname,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                      options-&gt;test_crypto, true);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* Read cipher and hmac keys from s=
hared secret file */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       crypto_read_openvpn_key(&amp;c-&gt;c1=2Eks=2Ekey_type, &amp;c-&gt;c1=
=2Eks=2Estatic_key,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                              options-&gt;shared_secret_file, options-&gt;s=
hared_secret_file_inline,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                options-&gt;key_direction, &quot;Static=
 Key Encryption&quot;, &quot;secret&quot;, NULL);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INF=
O, &quot;Re-using pre-shared static key&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Get =
key schedule */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-=
&gt;c2=2Ecrypto_options=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Estatic_key;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-/*</span><br><span>  * Initialize the tls-auth/crypt key context</spa=
n><br><span>  */</span><br><span> static void</span><br><span>@@ -3208,7 +3=
138,7 @@</span><br><span> </span><br><span>         /* Do not warn if the c=
ipher is used only in OCC */</span><br><span>         bool warn =3D options=
-&gt;enable_ncp_fallback;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, ciphername, option=
s-&gt;authname, true, warn);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, ciphername, o=
ptions-&gt;authname, warn);</span><br><span> </span><br><span>         /* i=
nitialize tls-auth/crypt/crypt-v2 key */</span><br><span>         do_init_t=
ls_wrap_key(c);</span><br><span>@@ -3496,41 +3426,6 @@</span><br><span>    =
 }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* No encryption or authentication=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_init_crypt=
o_none(struct context *c)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(!c-&g=
t;options=2Etest_crypto);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Initialise=
 key_type with auth/cipher &quot;none&quot;, so the key_type struct is</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     * valid */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;c-&gt;c1=
=2Eks=2Ekey_type, &quot;none&quot;, &quot;none&quot;, c-&gt;options=2Etest_=
crypto, true);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_WARN, &quot;******=
* WARNING *******: All encryption and authentication features &quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;disabl=
ed -- All data will be tunnelled as clear text and will not be &quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;prote=
cted against man-in-the-middle changes=2E &quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                &quot;PLEASE DO RECONSIDER THIS =
CONFIGURATION!&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-do_init_crypto(struct context *c, const unsigned i=
nt flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;options=2Eshared_s=
ecret_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        do_init_crypto_sta=
tic(c, flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (c-&gt;opti=
ons=2Etls_server || c-&gt;options=2Etls_client)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        do_init_crypto_tls(c, flags);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    else /* no encryption or authentication=2E */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        do_init_crypto_none(c);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> static void</span><br><span> do_init_frame(struct context *c)=
</span><br><span> {</span><br><span>@@ -4568,7 +4463,7 @@</span><br><span> =
        {</span><br><span>             crypto_flags =3D CF_INIT_TLS_MULTI;<=
/span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        do_init_crypto(c, crypto_flags);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        do_init_crypto_tls(c, crypto_flags);</spa=
n><br><span>         if (IS_SIG(c) &amp;&amp; !child)</span><br><span>     =
    {</span><br><span>             goto sig;</span><br><span>diff --git a/s=
rc/openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec</span><br><span>index f3c2874=2E=
=2E5ce40c8 100644</span><br><span>--- a/src/openvpn/mtu=2Ec</span><br><span=
>+++ b/src/openvpn/mtu=2Ec</span><br><span>@@ -51,7 +51,6 @@</span><br><spa=
n> unsigned int</span><br><span> calc_packet_id_size_dc(const struct option=
s *options, const struct key_type *kt)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    bool tlsmode =3D options-&gt;tls_se=
rver || options-&gt;tls_client;</span><br><span>     bool epoch =3D options=
-&gt;imported_protocol_flags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><spa=
n> </span><br><span>     /* epoch format uses a 64-bit packet id: 16 bit ep=
och + 48 bit per-epoch counter */</span><br><span>@@ -60,7 +59,7 @@</span><=
br><span>         return sizeof(uint64_t);</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool pack=
et_id_long_form =3D !tlsmode || cipher_kt_mode_ofb_cfb(kt-&gt;cipher);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool packet_id_long_=
form =3D cipher_kt_mode_ofb_cfb(kt-&gt;cipher);</span><br><span> </span><br=
><span>     return packet_id_size(packet_id_long_form);</span><br><span> }<=
/span><br><span>@@ -72,8 +71,6 @@</span><br><span>     /* Sum of all the ov=
erhead that reduces the usable packet size */</span><br><span>     size_t h=
eader_size =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    bool tlsmode =3D options-&gt;tls_server || options-&gt;tl=
s_client;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span>     /* A socks proxy adds extra header to each packet</span><br><span=
>      * (we only support Socks with IPv4, this value is different for IPv6=
) */</span><br><span>     if (options-&gt;ce=2Esocks_proxy_server &amp;&amp=
; proto_is_udp(options-&gt;ce=2Eproto))</span><br><span>@@ -88,10 +85,7 @@<=
/span><br><span>     }</span><br><span> </span><br><span>     /* Add the op=
code and peerid */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (tlsmode)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        header_size +=3D=
 options-&gt;use_peer_id ? 4 : 1;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  header_size +=3D options-&gt;use_peer_id ? 4 : 1;</span><br><span> </span=
><br><span>     unsigned int pkt_id_size =3D calc_packet_id_size_dc(options=
, kt);</span><br><span> </span><br><span>@@ -156,13 +150,6 @@</span><br><sp=
an> {</span><br><span>     struct key_type occ_kt;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* neither --secret nor =
TLS mode */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!o=
-&gt;tls_client &amp;&amp; !o-&gt;tls_server &amp;&amp; !o-&gt;shared_secre=
t_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        init_key_type(&amp;occ=
_kt, &quot;none&quot;, &quot;none&quot;, false, false);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return frame_calculate_payload_si=
ze(frame, o, &amp;occ_kt);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span>     /* o-&gt;ciphername might be BF-CBC even though the underlying S=
SL library</span><br><span>      * does not support it=2E For this reason w=
e workaround this corner case</span><br><span>      * by pretending to have=
 no encryption enabled and by manually adding</span><br><span>@@ -184,9 +17=
1,7 @@</span><br><span>         ciphername =3D &quot;none&quot;;</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* We pass tlsmode always true here since as we do not need to=
 check if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * the c=
iphers are actually valid for non tls in occ calucation */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;occ_kt, ciphern=
ame, o-&gt;authname, true, false);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    init_key_type(&amp;occ_kt, ciphername, o-&gt;authname, f=
alse);</span><br><span> </span><br><span>     size_t payload =3D frame_calc=
ulate_payload_size(frame, o, &amp;occ_kt);</span><br><span>     overhead +=
=3D frame_calculate_protocol_header_size(&amp;occ_kt, o, true);</span><br><=
span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><=
br><span>index 8e0c602=2E=2Ea3c7601 100644</span><br><span>--- a/src/openvp=
n/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span=
>@@ -1587,16 +1587,17 @@</span><br><span> static void</span><br><span> opti=
ons_postprocess_verify_ce(const struct options *options, const struct conne=
ction_entry *ce)</span><br><span> {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (options-&gt;test_crypto)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span>     struct options defaults;</span><br><s=
pan>     int dev =3D DEV_TYPE_UNDEF;</span><br><span>     bool pull =3D fal=
se;</span><br><span> </span><br><span>     init_options(&amp;defaults);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(!options-&gt;test_crypto)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        not=
null(options-&gt;dev, &quot;TUN/TAP device (--dev)&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    notnull(options-&gt;dev, &quot;TUN/TAP device (-=
-dev)&quot;);</span><br><span> </span><br><span>     /*</span><br><span>   =
   * Get tun/tap/null device type</span><br><span>@@ -2012,27 +2013,9 @@</s=
pan><br><span>     /*</span><br><span>      * SSL/TLS mode sanity checks=2E=
</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (options-&gt;tls_server + options-&gt;tls_client + (options-&gt;=
shared_secret_file !=3D NULL) &gt; 1)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (options-&gt;tls_server =3D=3D options-&gt;tls_cli=
ent)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        msg(M_USAGE, &quot;specify only one of --tls-server, --tls-cl=
ient, or --secret&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (!options-&gt;tls_server &=
amp;&amp; !options-&gt;tls_client &amp;&amp; !options-&gt;test_crypto)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        msglvl_t msglevel =3D M_USAGE;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;a=
llow_deprecated_insecure_static_crypto)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            msglevel =3D M_INFO;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(msgl=
evel, &quot;DEPRECATION: No tls-client or tls-server option in &quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                      &quot=
;configuration detected=2E OpenVPN 2=2E8 will remove the &quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                      &quot;funct=
ionality to run a VPN without TLS=2E &quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                      &quot;See the examples section =
in the manual page for &quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                      &quot;examples of a similar quick setup with =
peer-fingerprint=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                      &quot;OpenVPN 2=2E7 allows using this configurat=
ion when using &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                      &quot;--allow-deprecated-insecure-static-crypto but y=
ou should move &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                      &quot;to a proper configuration using TLS as soon as =
possible=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(M_USAGE, &quot;OpenVPN configuration must use either --tls-serv=
er or --tls-client&quot;);</span><br><span>     }</span><br><span> </span><=
br><span>     if (options-&gt;ssl_flags &amp; (SSLF_CLIENT_CERT_NOT_REQUIRE=
D | SSLF_CLIENT_CERT_OPTIONAL))</span><br><span>@@ -2052,188 +2035,135 @@</=
span><br><span>         msg(M_USAGE, &quot;--tls-version-min bigger than --=
tls-version-max&quot;);</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;tls_server |=
| options-&gt;tls_client)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        chec=
k_ca_required(options);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    check_ca_required(options);</span><br><span> #ifdef ENABLE_PKCS11</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!options-&g=
t;pkcs11_providers[0] &amp;&amp; options-&gt;pkcs11_id)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;Option pkcs11-id is ign=
ored as no pkcs11-providers are specified&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        else if (!options-&gt;pkcs11_providers[0] &amp;&amp=
; options-&gt;pkcs11_id_management)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                &quot;Option pkcs11-id-management is ignored as no pkcs=
11-providers are specified&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!options-&gt;pkcs11_providers[0] &amp;&amp; options-&gt;pkcs11_i=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Optio=
n pkcs11-id is ignored as no pkcs11-providers are specified&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (!options-&gt;pkcs11_provider=
s[0] &amp;&amp; options-&gt;pkcs11_id_management)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(M_WARN,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            &quot;Option pkcs11-id-management is ignored as=
 no pkcs11-providers are specified&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (options-&gt;pkcs11_providers[0])</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            if (options-&gt;pkcs11_id_m=
anagement &amp;&amp; options-&gt;pkcs11_id !=3D NULL)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                msg(M_USAGE,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    &quot;Parameter --pkcs1=
1-id cannot be used when --pkcs11-id-management is also specified=2E&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!options-&gt=
;pkcs11_id_management &amp;&amp; options-&gt;pkcs11_id =3D=3D NULL)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                msg(M_USAGE,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;Para=
meter --pkcs11-id or --pkcs11-id-management should be specified=2E&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            const char use_err=
[] =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 &quot;Parameter --%s cannot be used when --pkcs11-provider is also specifi=
ed=2E&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(priv_key_file, &quot;key=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            M=
UST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(options-&gt;management_f=
lags &amp; MF_EXTERNAL_KEY, &quot;management-external-key&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(optio=
ns-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;management-external-c=
ert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENA=
BLE_CRYPTOAPI</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    MUST_BE_UNDEF(cryptoapi_cert, &quot;cryptoapicert&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif /* ifdef ENABLE_PKCS11 */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            if (options-&gt;cryptoapi_cert)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            const char use_err[] =3D</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                &quot;Parameter -=
-%s cannot be used when --cryptoapicert is also specified=2E&quot;;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(cer=
t_file, &quot;cert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(pkcs12_=
file, &quot;pkcs12&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERN=
AL_KEY, &quot;management-external-key&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(options-&gt;management_fl=
ags &amp; MF_EXTERNAL_CERT, &quot;management-external-cert&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            if (options-&gt;pkcs12_file)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;Parameter --pkcs12 ca=
nnot be used with the mbed TLS version of OpenVPN=2E&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            const char use_err[] =3D &quot;Parameter=
 --%s cannot be used when --pkcs12 is also specified=2E&quot;;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(ca_path,=
 &quot;capath&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(priv_key_file, =
&quot;key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_KEY, &=
quot;management-external-key&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            MUST_BE_FALSE(options-&gt;management_flags &amp;=
 MF_EXTERNAL_CERT, &quot;management-external-cert&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif       /* ifdef ENABLE_CRYPTO_MBE=
DTLS */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        else /* cert/key f=
rom none of pkcs11, pkcs12, cryptoapi */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            if ((options-&gt;management_flags &amp; MF_EXTERNAL_KEY)=
 &amp;&amp; options-&gt;priv_key_file)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                msg(M_USAGE, &quot;--key and --management-external=
-key are mutually exclusive&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if ((options-&gt;management_flags &amp; MF_EXTERNAL_CERT)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                if (options-=
&gt;cert_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         msg(M_USAGE, &quot;--cert and --management-external-cert are mutua=
lly exclusive&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            else if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    msg(M=
_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
          &quot;--management-external-cert must be used with --management-e=
xternal-key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if=
 (pull)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                const =
int sum =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          ((options-&gt;cert_file !=3D NULL) || (options-&gt;management_fla=
gs &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    + ((options-&gt;priv_key_file !=3D NULL)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                       || (opt=
ions-&gt;management_flags &amp; MF_EXTERNAL_KEY));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                if (sum =3D=3D 0)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    if (!options-&gt;auth_user_pass_file)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 msg(M_USAGE, &quot;No client-side authentication method is &quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
       &quot;specified=2E  You must use either &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                     &quot;=
--cert/--key, --pkcs12, or &quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                     &quot;--auth-user-pass&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                else =
if (sum !=3D 2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          msg(M_USAGE, &quot;If you use one of --cert or --key, you must us=
e them both&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (!(optio=
ns-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    notnull(options-&gt;cert_file,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
     &quot;certificate file (--cert) or PKCS#12 file (--pkcs12)&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                if (!(options=
-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    notnull(options-&gt;priv_key_file,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
      &quot;private key file (--key) or PKCS#12 file (--pkcs12)&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (ce-&gt;tls_auth_file &amp;&amp; ce-&g=
t;tls_crypt_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(=
M_USAGE, &quot;--tls-auth and --tls-crypt are mutually exclusive&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;tls_client &=
amp;&amp; ce-&gt;tls_crypt_v2_file</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            &amp;&amp; (ce-&gt;tls_auth_file || ce-&gt;tls_cry=
pt_file))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (op=
tions-&gt;pkcs11_providers[0])</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (options-&gt;pkcs11_id_management &amp;&amp; options-&gt;pkcs11_id =
!=3D NULL)</span><br><span>         {</span><br><span>             msg(M_US=
AGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &=
quot;--tls-crypt-v2, --tls-auth and --tls-crypt are mutually exclusive in c=
lient mode&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               &quot;Parameter --pkcs11-id cannot be used when --pkcs11-id-=
management is also specified=2E&quot;);</span><br><span>         }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * =
Make sure user doesn&#39;t specify any TLS options</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-         * when in non-TLS mode=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        const char use_err[] =3D &quot;Parameter %s can only be =
specified in TLS-mode, &quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                               &quot;i=2Ee=2E where --tls-server or=
 --tls-client is also specified=2E&quot;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       MUST_BE_UNDEF(ca_file, &quot;ca&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(ca_path, &quot;capath&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDE=
F(dh_file, &quot;dh&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!options-&gt;pkcs11_id_management &amp;&amp; options-&g=
t;pkcs11_id =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msg(M_USAGE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                &quot;Parameter --pkcs11-id or --pkcs11-id-management shoul=
d be specified=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    const char use_err[] =3D</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            &quot;Parameter --%s cannot be used when --pkcs11-prov=
ider is also specified=2E&quot;;</span><br><span>         MUST_BE_UNDEF(cer=
t_file, &quot;cert&quot;);</span><br><span>         MUST_BE_UNDEF(priv_key_=
file, &quot;key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span>         MUST_BE_UNDEF(pkcs=
12_file, &quot;pkcs12&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTER=
NAL_KEY, &quot;management-external-key&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(options-&gt;management_fla=
gs &amp; MF_EXTERNAL_CERT, &quot;management-external-cert&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTOAPI</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(cry=
ptoapi_cert, &quot;cryptoapicert&quot;);</span><br><span> #endif</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(cipher_lis=
t, &quot;tls-cipher&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        MUST_BE_UNDEF(cipher_list_tls13, &quot;tls-ciphersuites&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UND=
EF(tls_cert_profile, &quot;tls-cert-profile&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_verify, &quot;tls=
-verify&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  MUST_BE_UNDEF(tls_export_peer_cert_dir, &quot;tls-export-cert&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(ver=
ify_x509_name, &quot;verify-x509-name&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_timeout, &quot;tls-timeou=
t&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST=
_BE_UNDEF(renegotiate_bytes, &quot;reneg-bytes&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(renegotiate_packets,=
 &quot;reneg-pkts&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        MUST_BE_UNDEF(renegotiate_seconds, &quot;reneg-sec&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(hand=
shake_window, &quot;hand-window&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        MUST_BE_UNDEF(transition_window, &quot;tran-windo=
w&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST=
_BE_UNDEF(tls_auth_file, &quot;tls-auth&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_crypt_file, &quot;tls-c=
rypt&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        M=
UST_BE_UNDEF(tls_crypt_v2_file, &quot;tls-crypt-v2&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(single_session, =
&quot;single-session&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        MUST_BE_UNDEF(push_peer_info, &quot;push-peer-info&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(t=
ls_exit, &quot;tls-exit&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        MUST_BE_UNDEF(crl_file, &quot;crl-verify&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(ns_cert_=
type, &quot;ns-cert-type&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        MUST_BE_UNDEF(remote_cert_ku[0], &quot;remote-cert-ku&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_=
UNDEF(remote_cert_eku, &quot;remote-cert-eku&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PKCS11</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(pkcs11_providers[0], =
&quot;pkcs11-providers&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        MUST_BE_UNDEF(pkcs11_private_mode[0], &quot;pkcs11-private=
-mode&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
MUST_BE_UNDEF(pkcs11_id, &quot;pkcs11-id&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(pkcs11_id_management, &quo=
t;pkcs11-id-management&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifde=
f ENABLE_PKCS11 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (options-&gt;cryptoapi_cert)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        const char use_err[] =3D</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &quot;Parameter --%s cannot be used when =
--cryptoapicert is also specified=2E&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(cert_file, &quot;cert&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UND=
EF(priv_key_file, &quot;key&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        MUST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(o=
ptions-&gt;management_flags &amp; MF_EXTERNAL_KEY, &quot;management-externa=
l-key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;=
management-external-cert&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (options-&gt;pkcs12_file)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef=
 ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_USAGE, &quot;Parameter --pkcs12 cannot be used with the mb=
ed TLS version of OpenVPN=2E&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        const char use_err[] =3D &quot;Parameter --%s cannot be used whe=
n --pkcs12 is also specified=2E&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        MUST_BE_UNDEF(ca_path, &quot;capath&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(ce=
rt_file, &quot;cert&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(options-&g=
t;management_flags &amp; MF_EXTERNAL_KEY, &quot;management-external-key&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE=
_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;managemen=
t-external-cert&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif   /* ifdef ENABLE_CRYPTO_MBEDTLS */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else /* cert/key from none of pkcs11, pkcs12, cryptoapi */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if ((options-&gt;manageme=
nt_flags &amp; MF_EXTERNAL_KEY) &amp;&amp; options-&gt;priv_key_file)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(M_USAGE, &quot;--ke=
y and --management-external-key are mutually exclusive&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if ((options-&gt;management_flags=
 &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (options-&gt;cert_file)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                msg(M_USAGE, &quot;--cert and --management-externa=
l-cert are mutually exclusive&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            else if (!(options-&gt;management_flags &amp; MF_EX=
TERNAL_KEY))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   msg(M_USAGE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                &quot;--management-external-cert must be used with --manage=
ment-external-key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span>         if (pull)</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, =
use_err, &quot;--pull&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            const int sum =3D</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                ((options-&gt;cert_file !=3D NULL) || (=
options-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                + ((options-&gt;priv_key_=
file !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
               || (options-&gt;management_flags &amp; MF_EXTERNAL_KEY));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (sum =3D=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                if (!options-&gt;auth=
_user_pass_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               msg(M_USAGE, &quot;No client-side authentication method is &=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                   &quot;specified=2E  You must use either &quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
    &quot;--cert/--key, --pkcs12, or &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                 &quot;--auth-user-=
pass&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            els=
e if (sum !=3D 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        msg(M_USAGE, &quot;If you use one of --cert or --key, you must use =
them both&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (!(options-&gt;manag=
ement_flags &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                notnull(options-&gt;cert_file,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                        &quot;certifi=
cate file (--cert) or PKCS#12 file (--pkcs12)&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (!(options-&gt;management_flags =
&amp; MF_EXTERNAL_KEY))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              notnull(options-&gt;priv_key_file,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        &quot;private key file=
 (--key) or PKCS#12 file (--pkcs12)&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span>         }</span><br>=
<span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(ce-&gt;tls_auth_file &amp;&amp; ce-&gt;tls_crypt_file)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(M_USAGE, &quot;--tls-auth and --tls-crypt=
 are mutually exclusive&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (options-&gt;tls_client &amp;&amp; ce-&gt;tls_crypt_v2_file</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; (ce-&gt;tls=
_auth_file || ce-&gt;tls_crypt_file))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(M_USAGE,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            &quot;--tls-crypt-v2, --tls-auth and --tls-crypt are mutua=
lly exclusive in client mode&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     if (options-&gt;auth_user_pass_file &amp;&amp; !options-&gt;pull)</sp=
an><br><span>     {</span><br><span>         msg(M_USAGE, &quot;--auth-user=
-pass requires --pull&quot;);</span><br><span>@@ -6957,32 +6887,6 @@</span>=
<br><span>             goto err;</span><br><span>         }</span><br><span=
>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (s=
treq(p[0], &quot;secret&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;DEPRECATED OPTION: The=
 option --secret is deprecated=2E&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;=
shared_secret_file =3D p[1];</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        options-&gt;shared_secret_file_inline =3D is_inline;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!is_inline &amp;&=
amp; p[2])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            int key_dir=
ection;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            key_direction =3D ascii=
2keydirection(msglevel, p[2]);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            if (key_direction &gt;=3D 0)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                options-&gt;key_direction =3D key_direc=
tion;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            else</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                goto err;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else if (streq(p[0], &quot;allow-deprecated-insecure-static-crypt=
o&quot;))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        VERIFY_PERMISSION(OP=
T_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
options-&gt;allow_deprecated_insecure_static_crypto =3D true;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     else if =
(streq(p[0], &quot;genkey&quot;) &amp;&amp; !p[4])</span><br><span>     {</=
span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>d=
iff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><sp=
an>index c58530a=2E=2E129267f 100644</span><br><span>--- a/src/openvpn/opti=
ons=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -5=
69,9 +569,6 @@</span><br><span>     struct static_challenge_info sc_info;</=
span><br><span> #endif</span><br><span>     /* Cipher parms */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    const char *shared_secret_file=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool shared_secr=
et_file_inline;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bo=
ol allow_deprecated_insecure_static_crypto;</span><br><span>     int key_di=
rection;</span><br><span>     const char *ciphername;</span><br><span>     =
bool enable_ncp_fallback; /**&lt; If defined fall back to</span><br><span>d=
iff --git a/src/openvpn/options_show=2Ec b/src/openvpn/options_show=2Ec</sp=
an><br><span>index 80d36f0=2E=2E321a37b 100644</span><br><span>--- a/src/op=
envpn/options_show=2Ec</span><br><span>+++ b/src/openvpn/options_show=2Ec</=
span><br><span>@@ -491,7 +491,6 @@</span><br><span>     }</span><br><span> =
#endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    SHOW_STR_INLINE(shared_secret_file);</span><br><span>     SHOW_PARM(=
key_direction, keydirection2ascii(o-&gt;key_direction, false, true), &quot;=
%s&quot;);</span><br><span>     SHOW_STR(ciphername);</span><br><span>     =
SHOW_STR(ncp_ciphers);</span><br><span>diff --git a/src/openvpn/options_str=
ing=2Ec b/src/openvpn/options_string=2Ec</span><br><span>index cfc0595=2E=
=2E2fd90dd 100644</span><br><span>--- a/src/openvpn/options_string=2Ec</spa=
n><br><span>+++ b/src/openvpn/options_string=2Ec</span><br><span>@@ -140,83=
 +140,72 @@</span><br><span>     /*</span><br><span>      * Crypto Options<=
/span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (o-&gt;shared_secret_file || TLS_CLIENT || TLS_SERVER)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct key_type kt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ASSERT((TLS_CLIENT =3D=3D true) + (TLS_SE=
RVER =3D=3D true) &lt;=3D 1);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Sk=
ip resolving BF-CBC to allow SSL libraries without BF-CBC</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * to work here in the default co=
nfiguration */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *ciphername =3D o-&gt;ciphername;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    size_t keysize =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (strcmp(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D 0)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        struct key_type kt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(=
(o-&gt;shared_secret_file !=3D NULL) + (TLS_CLIENT =3D=3D true) + (TLS_SERV=
ER =3D=3D true) &lt;=3D 1);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Skip=
 resolving BF-CBC to allow SSL libraries without BF-CBC</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-         * to work here in the default co=
nfiguration */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 const char *ciphername =3D o-&gt;ciphername;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        size_t keysize =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (strcmp(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        init_key_=
type(&amp;kt, &quot;none&quot;, o-&gt;authname, false);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        keysize =3D 128;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        init_key_type(&amp;kt, o-&gt;ciphername, o-&gt;authname, false);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ciphername =
=3D cipher_kt_name(kt=2Ecipher);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (cipher_defined(o-&gt;ciphername))</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 init_key_type(&amp;kt, &quot;none&quot;, o-&gt;authname, true, false);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            keysize =3D 1=
28;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            init_key_type(&amp;kt, o-&gt;ciphername=
, o-&gt;authname, true, false);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            ciphername =3D cipher_kt_name(kt=2Ecipher);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            if (cipher_defined(=
o-&gt;ciphername))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     keysize =3D cipher_kt_key_size(kt=2Ecipher) * 8;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        /* Only announce the cipher to our peer if we are willi=
ng to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * suppo=
rt it */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p=
2p_nopull || tls_item_in_cipher_list(ciphername, o-&gt;ncp_ciphers))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;,=
cipher %s&quot;, ciphername);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    buf_printf(&amp;out, &quot;,auth %s&quot;, md_kt_name(kt=2Edigest));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;=
out, &quot;,keysize %zu&quot;, keysize);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (o-&gt;shared_secret_file)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;,secret&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            keysi=
ze =3D cipher_kt_key_size(kt=2Ecipher) * 8;</span><br><span>         }</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* Only announce the cipher to our peer if we are willing to</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * support it */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (p2p_nopull || tls_item=
_in_cipher_list(ciphername, o-&gt;ncp_ciphers))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        buf_printf(&amp;out, &quot;,cipher %s&quot;, cipherna=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quo=
t;,auth %s&quot;, md_kt_name(kt=2Edigest));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;,keysize %zu&quot;, =
keysize);</span><br><span> </span><br><span>     /*</span><br><span>      *=
 SSL Options</span><br><span>      */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (o-&gt;ce=2Etls_auth_file)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (TLS_CLIENT=
 || TLS_SERVER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (o-=
&gt;ce=2Etls_auth_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          buf_printf(&amp;out, &quot;,tls-auth&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            /* Not adding tls-crypt here, because =
we won&#39;t reach this code if</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-             * tls-auth/tls-crypt does not match=2E  Removing tls=
-auth here would</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
        * break stuff, so leaving that in place=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;,tls-a=
uth&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Not adding tls-=
crypt here, because we won&#39;t reach this code if</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * tls-auth/tls-crypt does not match=
=2E  Removing tls-auth here would</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * break stuff, so leaving that in place=2E */</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            bu=
f_printf(&amp;out, &quot;,key-method %d&quot;, KEY_METHOD_2);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;,key-method %d=
&quot;, KEY_METHOD_2);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (remote)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (remote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (TLS_CL=
IENT)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (TLS_CLIENT)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                buf_printf(&amp;out, &quot;,tls-server&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            else if (TLS_SERVER)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                buf_printf(&am=
p;out, &quot;,tls-client&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            buf_printf(&amp;out, &quot;,tls-server&quot;);</span><br><=
span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else =
if (TLS_SERVER)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            if (TLS_CLIENT)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                buf_printf(&amp;out, &quot;,tls-client&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else if (TL=
S_SERVER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                buf_=
printf(&amp;out, &quot;,tls-server&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            buf_printf(&amp;out, &quot;,tls-client&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (TLS_CLIENT)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           buf_printf(&amp;out, &quot;,tls-client&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        else if (TLS_SERVER)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;,tls-serv=
er&quot;);</span><br><span>         }</span><br><span>     }</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/options_string=2Eh b/src/openv=
pn/options_string=2Eh</span><br><span>index 02efed3=2E=2E6d5518a 100644</sp=
an><br><span>--- a/src/openvpn/options_string=2Eh</span><br><span>+++ b/src=
/openvpn/options_string=2Eh</span><br><span>@@ -59,7 +59,6 @@</span><br><sp=
an>  *</span><br><span>  * --cipher</span><br><span>  * --auth</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * --secret</span><br><span>  *</s=
pan><br><span>  * SSL Options:</span><br><span>  *</span><br><span>diff --g=
it a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index ddee3e=
b=2E=2E55043e5 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><=
span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1644,7 +1644,7 @@</span>=
<br><span>         return true;</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;s=
ession-&gt;opt-&gt;key_type, options-&gt;ciphername, options-&gt;authname, =
true, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ini=
t_key_type(&amp;session-&gt;opt-&gt;key_type, options-&gt;ciphername, optio=
ns-&gt;authname, true);</span><br><span> </span><br><span>     bool packet_=
id_long_form =3D cipher_kt_mode_ofb_cfb(session-&gt;opt-&gt;key_type=2Eciph=
er);</span><br><span>     session-&gt;opt-&gt;crypto_flags &amp;=3D ~(CO_PA=
CKET_ID_LONG_FORM);</span><br><span>diff --git a/tests/unit_tests/openvpn/t=
est_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span>i=
ndex 07c54b4=2E=2Ef86aca8 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/test_crypto=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_cr=
ypto=2Ec</span><br><span>@@ -237,70 +237,58 @@</span><br><span>     /* comm=
on defaults */</span><br><span>     o=2Ece=2Etun_mtu =3D 1400;</span><br><s=
pan>     o=2Ece=2Eproto =3D PROTO_UDP;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    o=2Etls_client =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    o=2Epull =3D true;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* No crypto at all */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*  auth none, ci=
pher none */</span><br><span>     o=2Eciphername =3D &quot;none&quot;;</spa=
n><br><span>     o=2Eauthname =3D &quot;none&quot;;</span><br><span>     li=
nkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1400);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(lin=
kmtu, 1405);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* Static key OCC examples */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    o=2Eshared_secret_file =3D &quot;not null&quot;;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* secret, auth none, cipher none */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eciphername =3D &=
quot;none&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=
=2Eauthname =3D &quot;none&quot;;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(li=
nkmtu, 1408);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, cipher AES-128=
-CBC, auth none */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* cipher AES-128-CBC, auth none */</span><br><span>     o=2Eciphername =
=3D &quot;AES-128-CBC&quot;;</span><br><span>     o=2Eauthname =3D &quot;no=
ne&quot;;</span><br><span>     linkmtu =3D calc_options_string_link_mtu(&am=
p;o, &amp;f);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asse=
rt_int_equal(linkmtu, 1440);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(linkmtu, 1437);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, cipher none, auth =
SHA256 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* cip=
her none, auth SHA256 */</span><br><span>     o=2Eciphername =3D &quot;none=
&quot;;</span><br><span>     o=2Eauthname =3D &quot;SHA256&quot;;</span><br=
><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmt=
u, 1440);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(linkmtu, 1437);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* secret, cipher BF-CBC, auth SHA1 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* cipher BF-CBC, auth SH=
A1 */</span><br><span>     o=2Eciphername =3D &quot;BF-CBC&quot;;</span><br=
><span>     o=2Eauthname =3D &quot;SHA1&quot;;</span><br><span>     linkmtu=
 =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1444);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(linkmtu,=
 1441);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* secret, cipher BF-CBC, auth SHA1, tcp-client */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* cipher BF-CBC, auth SHA1, tcp=
-client */</span><br><span>     o=2Ece=2Eproto =3D PROTO_TCP_CLIENT;</span>=
<br><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(lin=
kmtu, 1446);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(linkmtu, 1443);</span><br><span> </span><br><span>     o=2Ece=
=2Eproto =3D PROTO_UDP;</span><br><span> </span><br><span> #if defined(USE_=
COMP)</span><br><span>     o=2Ecomp=2Ealg =3D COMP_ALG_LZO;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, comp=
-lzo yes, cipher BF-CBC, auth SHA1 */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /*  comp-lzo yes, cipher BF-CBC, auth SHA1 */</span><=
br><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(link=
mtu, 1445);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(linkmtu, 1442);</span><br><span> </span><br><span> #if defined=
(ENABLE_FRAGMENT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* secret, comp-lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* comp-lzo yes, cipher=
 BF-CBC, auth SHA1, fragment 1200 */</span><br><span>     o=2Ece=2Efragment=
 =3D 1200;</span><br><span>     linkmtu =3D calc_options_string_link_mtu(&a=
mp;o, &amp;f);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ass=
ert_int_equal(linkmtu, 1449);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(linkmtu, 1446);</span><br><span>     o=2Ece=
=2Efragment =3D 0;</span><br><span> #endif</span><br><span> </span><br><spa=
n>     o=2Ecomp=2Ealg =3D COMP_ALG_UNDEF;</span><br><span> #endif</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* TLS mo=
de */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eshared_s=
ecret_file =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   o=2Etls_client =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    o=2Epull =3D true;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>     /* tls client, cipher AES-128-CBC, auth SHA1, =
tls-auth */</span><br><span>     o=2Eauthname =3D &quot;SHA1&quot;;</span><=
br><span>     o=2Eciphername =3D &quot;AES-128-CBC&quot;;</span><br><span>@=
@ -315,15 +303,8 @@</span><br><span>     linkmtu =3D calc_options_string_li=
nk_mtu(&amp;o, &amp;f);</span><br><span>     assert_int_equal(linkmtu, 1457=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* tls client, cipher none, auth none */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* tls client, auth none, cipher AES-256-GCM */=
</span><br><span>     o=2Eauthname =3D &quot;none&quot;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    o=2Eciphername =3D &quot;none&quot;;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    linkmtu =3D calc_options_string_link_m=
tu(&amp;o, &amp;f);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  assert_int_equal(linkmtu, 1405);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* t=
ls client, auth SHA1, cipher AES-256-GCM */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    o=2Eauthname =3D &quot;SHA1&quot;;</span><br><spa=
n>     o=2Eciphername =3D &quot;AES-256-GCM&quot;;</span><br><span>     lin=
kmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span>    =
 assert_int_equal(linkmtu, 1449);</span><br><span>@@ -332,12 +313,12 @@</sp=
an><br><span> #if defined(USE_COMP) &amp;&amp; defined(ENABLE_FRAGMENT)</sp=
an><br><span>     o=2Ecomp=2Ealg =3D COMP_ALG_LZO;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tls client, auth SHA1=
, cipher AES-256-GCM, fragment, comp-lzo yes */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* tls client, auth none, cipher AES-256-GC=
M, fragment, comp-lzo yes */</span><br><span>     o=2Ece=2Efragment =3D 120=
0;</span><br><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &a=
mp;f);</span><br><span>     assert_int_equal(linkmtu, 1454);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tls client,=
 auth SHA1, cipher AES-256-GCM, fragment, comp-lzo yes, socks */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* tls client, auth none, =
cipher AES-256-GCM, fragment, comp-lzo yes, socks */</span><br><span>     o=
=2Ece=2Esocks_proxy_server =3D &quot;socks=2Eexample=2Ecom&quot;;</span><br=
><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span=
><br><span>     assert_int_equal(linkmtu, 1464);</span><br><span>@@ -358,50=
 +339,41 @@</span><br><span>     o=2Ece=2Etun_mtu =3D 1400;</span><br><span=
>     o=2Ece=2Emssfix =3D 1000;</span><br><span>     o=2Ece=2Eproto =3D PRO=
TO_UDP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=2Etls_=
client =3D true;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* No crypto at all */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /*auth none, cipher none */</span><br><span>     o=
=2Eciphername =3D &quot;none&quot;;</span><br><span>     o=2Eauthname =3D &=
quot;none&quot;;</span><br><span>     struct key_type kt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;kt, o=2Ecipherna=
me, o=2Eauthname, false, false);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    init_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, false=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* No encryption, just packet id (8) + TCP payload(20) + IP payload(20) =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* No encrypt=
ion, just packet id (4) + opcode (1) + TCP payload(20) + IP payload(20) */<=
/span><br><span>     frame_calculate_dynamic(&amp;f, &amp;kt, &amp;o, NULL)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal=
(f=2Emss_fix, 952);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(f=2Emss_fix, 955);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* Static key OCC examples */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eshared_secret_file =
=3D &quot;not null&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, au=
th none, cipher none */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    o=2Eciphername =3D &quot;none&quot;;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    o=2Eauthname =3D &quot;none&quot;;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;kt, o=2Ecipher=
name, o=2Eauthname, false, false);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    frame_calculate_dynamic(&amp;f, &amp;kt, &amp;o, NULL);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(f=
=2Emss_fix, 952);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, cipher AES=
-128-CBC, auth none */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* cipher AES-128-CBC, auth none */</span><br><span>     o=2Eciphern=
ame =3D &quot;AES-128-CBC&quot;;</span><br><span>     o=2Eauthname =3D &quo=
t;none&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init=
_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, false, false);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;kt, o=2E=
ciphername, o=2Eauthname, false);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 990; i &lt;=3D 1010; i++=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D=
 990; i &lt;=3D 1015; i++)</span><br><span>     {</span><br><span>         =
/* 992 - 1008 should end up with the same mssfix value all they</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-         * all result in the same=
 CBC block size/padding and &lt;=3D 991 and &gt;=3D1008</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * all result in the same CBC b=
lock size/padding and &lt;=3D 992 and &gt;=3D1009</span><br><span>         =
 * should be one block less and more respectively */</span><br><span>      =
   o=2Ece=2Emssfix =3D i;</span><br><span>         frame_calculate_dynamic(=
&amp;f, &amp;kt, &amp;o, NULL);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (i &lt;=3D 991)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (i &lt;=3D 992)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            assert_int_equ=
al(f=2Emss_fix, 911);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            assert_int_equal(f=2Emss_fix, 915);</span><br><span>         =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (i &=
gt;=3D 1008)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else if (i &gt;=3D 1009)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            assert_int_equal(f=2Emss_fix, 9=
43);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ass=
ert_int_equal(f=2Emss_fix, 947);</span><br><span>         }</span><br><span=
>         else</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            assert_int_equal(f=2Emss_fix, 927);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            assert_int_equa=
l(f=2Emss_fix, 931);</span><br><span>         }</span><br><span>     }</spa=
n><br><span> #ifdef USE_COMP</span><br><span>@@ -410,36 +382,35 @@</span><b=
r><span>     /* Same but with compression added=2E Compression adds one byt=
e extra to the</span><br><span>      * payload so the payload should be red=
uced by compared to the no</span><br><span>      * compression calculation =
before */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int=
 i =3D 990; i &lt;=3D 1010; i++)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int i =3D 990; i &lt;=3D 1015; i++)</span><br><span> =
    {</span><br><span>         /* 992 - 1008 should end up with the same ms=
sfix value all they</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
       * all result in the same CBC block size/padding and &lt;=3D 991 and =
&gt;=3D1008</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * all result in the same CBC block size/padding and &lt;=3D 992 and &gt;=
=3D1009</span><br><span>          * should be one block less and more respe=
ctively */</span><br><span>         o=2Ece=2Emssfix =3D i;</span><br><span>=
         frame_calculate_dynamic(&amp;f, &amp;kt, &amp;o, NULL);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (i &lt;=3D 991)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (i &lt;=3D 992=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            assert_int_equal(f=2Emss_fix, 910);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            assert_int_equal(f=2Emss_fix=
, 914);</span><br><span>         }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        else if (i &gt;=3D 1008)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else if (i &gt;=3D 1009)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 assert_int_equal(f=2Emss_fix, 942);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            assert_int_equal(f=2Emss_fix, 946);</span><br>=
<span>         }</span><br><span>         else</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            assert_int_=
equal(f=2Emss_fix, 926);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            assert_int_equal(f=2Emss_fix, 930);</span><br><span>      =
   }</span><br><span>     }</span><br><span>     o=2Ecomp=2Ealg =3D COMP_AL=
G_UNDEF;</span><br><span> #endif /* ifdef USE_COMP */</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tls client, auth S=
HA1, cipher AES-256-GCM */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /*  auth SHA1, cipher AES-256-GCM */</span><br><span>     o=2Eau=
thname =3D &quot;SHA1&quot;;</span><br><span>     o=2Eciphername =3D &quot;=
AES-256-GCM&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 o=2Etls_client =3D true;</span><br><span>     o=2Epeer_id =3D 77;</span><b=
r><span>     o=2Euse_peer_id =3D true;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    init_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, t=
rue, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ini=
t_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, false);</span><br><span> =
</span><br><span>     for (int i =3D 900; i &lt;=3D 1200; i++)</span><br><s=
pan>     {</span><br><span>@@ -685,7 +656,7 @@</span><br><span> </span><br>=
<span>     data-&gt;gc =3D gc_new();</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;data-&gt;kt, &quot;=
AES-128-GCM&quot;, &quot;none&quot;, true, false);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;data-&gt;kt, &quot;AE=
S-128-GCM&quot;, &quot;none&quot;, false);</span><br><span> </span><br><spa=
n>     /* have an epoch key that uses 0x23 for the key for all bytes */</sp=
an><br><span>     struct epoch_key epoch1send =3D { =2Eepoch =3D 1, =2Eepoc=
h_key =3D { 0x23 } };</span><br><span>@@ -907,7 +878,7 @@</span><br><span> =
    struct epoch_key e17 =3D { =2Eepoch =3D 17, =2Eepoch_key =3D { 19, 12 }=
 };</span><br><span>     struct key_type kt =3D { 0 };</span><br><span>    =
 struct key_parameters key_parameters =3D { 0 };</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    init_key_type(&amp;kt, &quot;AES-192-GCM&quo=
t;, &quot;none&quot;, true, false);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    init_key_type(&amp;kt, &quot;AES-192-GCM&quot;, &quot;n=
one&quot;, false);</span><br><span> </span><br><span> </span><br><span>    =
 epoch_data_key_derive(&amp;key_parameters, &amp;e17, &amp;kt);</span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/=
openvpn/test_pkt=2Ec</span><br><span>index fbbb40f=2E=2E49ba833 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -173,7 +173,7 @=
@</span><br><span>     tas=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_=
ID | CO_PACKET_ID_LONG_FORM);</span><br><span> </span><br><span>     struct=
 key_type tls_crypt_kt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    init_key_type(&amp;tls_crypt_kt, &quot;none&quot;, &quot;SHA1&quot;, =
true, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
it_key_type(&amp;tls_crypt_kt, &quot;none&quot;, &quot;SHA1&quot;, false);<=
/span><br><span> </span><br><span>     crypto_read_openvpn_key(&amp;tls_cry=
pt_kt, &amp;tas=2Etls_wrap=2Eopt=2Ekey_ctx_bi, static_key, true,</span><br>=
<span>                             key_direction, &quot;Control Channel Aut=
hentication&quot;, &quot;tls-auth&quot;, NULL);</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Dema=
il">change 2081</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2081?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2081 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--73XDVL6DjSc=--


--===============0367708277781416311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0367708277781416311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0367708277781416311==--

