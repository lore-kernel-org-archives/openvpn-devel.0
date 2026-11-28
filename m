Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7B606A31E
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W9+4PScV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GGvD3g4u;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UYkwkXwo;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GbFmHFKW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XTRYhQvFjQq41ic/+4RfZclyxY3JmuU/V2dI/oLbfrY=; b=W9+4PScVwKmdJiCAA0lBR1XfJA
	M6SNIu5EA2tWy2j9Ig8yHhYUD+bO/2eUBtPdh+1LVXQyQZOXDfZsHwG7IXK5r0ybpaZUU80KGXreI
	AHkGWS38BMyVo6bJEchTisIqopi/uxRqPPQc7U7KWQKOdKQphyO8p/I932cGT2HFXR3c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX6ZK-000000003h3-1kHu;
	Sat, 28 Nov 2026 00:45:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX6ZJ-000000003gw-0Ktq
 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 00:45:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7B3QIDpwVGl2Kys7sVTsGkflz9eVoPt97FBt0wc3yXU=; b=GGvD3g4uR9D21mlc1ArQW/QENm
 KT0NfOh7etWM8xhPvAMo8IW/zzkqMWKfMAxE/LCcqj+PS0W+o/q/SWS8MOZMpqJssOG8irXXYmvUT
 qHWkC448iQ8d6Er0T63aNMe/YGpCUuyaSEVQYpYmUyLoFjKv5biB5ztREcwK2U9GTVmg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7B3QIDpwVGl2Kys7sVTsGkflz9eVoPt97FBt0wc3yXU=; b=UYkwkXwos1oEE7LmXpZzCk8HDl
 d67y6Gr3OF9QbxBoXkuq/SB4a5gHMu4digiyywZokJ/a9XoBKbjrWJKCW+JI8y3ohXvXZQsbJkKZ9
 w/MbtS0Ao7W4kpC7etPeBQErVSbxvOqEuQ0Ot0U+iRwvIC1/XbATuBzSJvAVP6lDEJzE=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX6ZG-000000006by-2M5j for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 00:45:33 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bba60271d7so30642675e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 16:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795826724; x=1796431524; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7B3QIDpwVGl2Kys7sVTsGkflz9eVoPt97FBt0wc3yXU=;
 b=GbFmHFKWQOKFUVNwgTIDdtH/zpO78C0TAtuQT2Ooejf7C59BhWlyNodF9SpyI2CCux
 r9UmIGDExDKn6VI+nfo72Yt3g8TyJyFlZM5+JRsR1cOf0pkEFaRy5+M0YT0hJZeqCmcF
 QezhsJ5Xz1QGvDxLSosXTq2aygJ3pcYjFq0brAKkgs2fszPy5bV0WXFgXeiI3DxEOp6u
 HbH2LP0xmaIUSj4sydhCAjE53gkhoB2cmZU8IW9wXt4unqMF9w7MBMRHjMT4uvxVqjHD
 tpQ91CPQjb91Oedan56c5bvIsQfvwifGIZNACxhDskQaJFDkOo2b46QJ5CzxgtOymW6O
 vS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795826724; x=1796431524;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7B3QIDpwVGl2Kys7sVTsGkflz9eVoPt97FBt0wc3yXU=;
 b=TSLkrAJ+QO+Sm8VxPNYuMHa7hraaLgvXq5pcT26Rp1nT3DHYmg3ZBXFdoezCsY854Y
 RwFMOx1qI+qsK6o6eZWGvikJRWTlj/BOtAzIjCTy7+WmcxWjK6rcDfqtgwSWZ1ySbYJL
 Of9RZXBdbk3tRcigZCiURwgEY5o8Bg/1wnY2VMLEbbXKqM1i2w2QPOdbE0WBmA8BvBzE
 QO/MKABekhJOZOFwiAEIFYSlJ8DwWI9ocsc1WpWfkHWQQMn+zBCp83kpLVHaIyZq3CyF
 1gKzQrb4U2DZVfLPkOd74kIDQFzD8A0iwxGR6VqB4P+lr2kaeuhtLxw6p2vRbzQr/bvX
 K2rA==
X-Gm-Message-State: APuU4Z+9IUaJR/+VgOFJl4awvB9uLk4jkJ8mV/A3EAoBZMh4wBAwWDNg
 pSTTJSMX/6TdHY+tszhf4fRRVk7wd0kchOaFYlgksq2lB08qwyPHsaXv2yPaGrOEwffykn4R0c8
 HoNN8E+AwsVciATW2LSQ++OT4eReyU4whoM+Ue8xrhaPaV7TwA2NGcb+/Y31oVQr9nr2M
X-Gm-Gg: AZFdTZeZuwXxu2SdRRaiKc1WfIa7Ls+WmEGr22PIg+cKihq0a2ZwwRDbGpPJCLvM4WF
 8LGNU4857trr62q2LqS94G8uJ/TgvqY23VhfCa15jzJSdS+esIOYt4+aRmPPlve5T3yPxN0FH2E
 ch4esKUD2fJ235SPCMBQbQPnLKjrTx8XM0KHDxqY7Cu8JJzN/JFzmlGb1213ja4V/6Grzk30DxJ
 t8FUfSeqyUsCDbORsxWyVeMKmkzr+uyR8JILN5jIN8jIzYK6Sd4s+TPZR72/0GAUG/+7iyjYOsj
 VFt9Mko+/f9+nkNLbG/4/9T2nf3diSNrENWfR/euzIp3pYJ6sHoU32ATBS//ZN2DeekXS3Y7RQh
 eiVXdVtBEwhGit/ycZlvfx4+YOsc3E6UMsXfbCSa6mudYfRpTifg0l6tKqVJqVrFqb7Dtb2WP0a
 v2ojqYuI29/WWmWvaCRffFGTKA6T6IsMBZiz4cjY6+H191qQY22sv4D7G224Omoq5M9lWjvRPYL
 XBiW//4OUVw1OLkF4+nGTJxilKet9rwG5yQRJxn+sHzU/WIqGRq2LcEhR/0jiUGTr2tRmY4j8zi
 7e87FYa08XMi+56hfiKDPdHAhV14zWIEULDcfllk3n6qe08fqdH1u9uerqZABeZ6LR898vejREZ
 rJlMfrMU8SbUqy3R5sRUi93nfssPpQ3+4hGnNZ4Se85l5FuVFgWhkZEcq4mWinMM0IaoA7XHplH
 JG4LUfpLjlGqmC604=
X-Received: by 2002:a05:600c:3ba3:b0:4bb:7571:5743 with SMTP id
 5b1f17b1804b1-4bb88813444mr602676695e9.27.1795826723789; 
 Fri, 27 Nov 2026 16:45:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906640a2sm426012785e9.0.2026.11.27.16.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 16:45:23 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 28 Nov 2026 00:45:20 +0000
To: Deri Haerudi <abcderyscreenprinting@gmail.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968
X-Gerrit-Change-Number: 2349
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2349?usp=email>
X-Gerrit-Commit: 674feefac7d74f2a9fd4b0f38d763f77bd958f27
In-Reply-To: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
References: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkk1ODQ3ZDYwMmEwMjQwNDRkOTEwOWY1MjFkZTc4ODVkNTVkMjhhOTY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f5ff8acd434690d060728e35ff56be024073f92a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX6ZG-000000006by-2M5j
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns: restrict dns
 var names and values in the updown runner
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 abcderyscreenprinting@gmail.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0009315312202247108=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0009315312202247108==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="veWpxSt3PbE="; charset=UTF-8

--veWpxSt3PbE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Deri Haerudi, Heiko Hun=
d, R=C4=83zvan Cojocaru=2E

Hello Arne Schwabe, Deri Haerudi, R=C4=83zvan C=
ojocaru, 

I'd like you to reexamine a change=2E Please visit

    https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail

to look at the new pat=
ch set (#3)=2E

The following approvals got outdated and were removed:
Code=
-Review+1 by Deri Haerudi, Code-Review+2 by R=C4=83zvan Cojocaru

The chang=
e is no longer submittable: Code-Review and checks~ChecksSubmitRule are uns=
atisfied now=2E


Change subject: dns: restrict dns var names and values in=
 the updown runner
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

dns: restrict dns var names and values in the updown runner

The up=
down runner hands the vars it gets from the unprivileged process
to a root =
script=2E Only accept what openvpn itself would send, so that a
compromised=
 process cannot affect the script beyond its DNS settings=2E

Change-Id: I5=
847d602a024044d9109f521de7885d55d28a968
Signed-off-by: Heiko Hund <heiko@is=
t=2Eeigentlich=2Enet>
---
M src/openvpn/dns=2Ec
1 file changed, 149 inserti=
ons(+), 3 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/49/2349/3

diff --git a/src/openvpn/dns=2Ec b/src/openvpn/=
dns=2Ec
index 1bd6c85=2E=2Ed00165a1 100644
--- a/src/openvpn/dns=2Ec
+++ b/=
src/openvpn/dns=2Ec
@@ -591,10 +591,155 @@
 #define DNS_VARS_MAX_SIZE (64 *=
 1024)
 
 /**
+ * Check if a dns var name equals a given name
+ *
+ * @para=
m  name     variable name, not NUL terminated
+ * @param  size     size of =
the name in bytes
+ * @param  expected NUL terminated name to compare with
=
+ *
+ * @return bool to indicate if the names are equal
+ */
+static bool
+=
dns_var_name_is(const char *name, size_t size, const char *expected)
+{
+  =
  return size =3D=3D strlen(expected) && memcmp(name, expected, size) =3D=
=3D 0;
+}
+
+/**
+ * Check if a dns var name is allowed
+ *
+ * Besides dev=
 and script_type, only names starting with dns_ and made of
+ * lowercase l=
etters, digits and underscores are allowed=2E
+ *
+ * @param  name     vari=
able name, not NUL terminated
+ * @param  size     size of the name in byte=
s
+ *
+ * @return bool to indicate if the name is valid
+ */
+static bool
+=
dns_var_name_valid(const char *name, size_t size)
+{
+    const char prefix=
[] =3D "dns_";
+
+    if (dns_var_name_is(name, size, "dev") || dns_var_nam=
e_is(name, size, "script_type"))
+    {
+        return true;
+    }
+
+   =
 if (size < sizeof(prefix) || strncmp(name, prefix, sizeof(prefix) - 1) !=
=3D 0)
+    {
+        return false;
+    }
+
+    for (size_t i =3D 0; i <=
 size; ++i)
+    {
+        const char c =3D name[i];
+        if (!((c >=
=3D 'a' && c <=3D 'z') || (c >=3D '0' && c <=3D '9') || c =3D=3D '_'))
+   =
     {
+            return false;
+        }
+    }
+
+    return true;
+}
=
+
+/**
+ * Check if a dns var value contains only allowed characters
+ *
+ =
* Values are domain names, IP addresses, port numbers or keywords, so
+ * d=
omain name characters and colons are allowed=2E A value must not start
+ * =
with a dash, so that it cannot be taken for an option=2E
+ *
+ * @param  va=
lue    variable value, not NUL terminated
+ * @param  size     size of the =
value in bytes
+ *
+ * @return bool to indicate if the value is valid
+ */
=
+static bool
+dns_var_value_valid(const char *value, size_t size)
+{
+    i=
f (size > 0 && value[0] =3D=3D '-')
+    {
+        return false;
+    }
+
=
+    for (size_t i =3D 0; i < size; ++i)
+    {
+        const unsigned cha=
r c =3D (unsigned char)value[i];
+        if (!is_allowed_domain_ascii(c) &=
& c !=3D ':')
+        {
+            return false;
+        }
+    }
+
+  =
  return true;
+}
+
+/**
+ * Check if a dev value contains only allowed cha=
racters
+ *
+ * Interface names may contain more than domain name character=
s, so a few
+ * characters without special meaning to the shell are allowed=
 as well=2E A
+ * name must not start with a dash, so that it cannot be tak=
en for an option=2E
+ *
+ * @param  value    interface name, not NUL termin=
ated
+ * @param  size     size of the name in bytes
+ *
+ * @return bool to=
 indicate if the value is valid
+ */
+static bool
+dns_var_dev_valid(const =
char *value, size_t size)
+{
+    const char extra[] =3D "+@%,=3D";
+
+    =
if (size =3D=3D 0 || size >=3D IFNAMSIZ || value[0] =3D=3D '-')
+    {
+   =
     return false;
+    }
+
+    for (size_t i =3D 0; i < size; ++i)
+    {=

+        const unsigned char c =3D (unsigned char)value[i];
+        if (!=
is_allowed_domain_ascii(c) && !memchr(extra, c, sizeof(extra) - 1))
+      =
  {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+=
/**
+ * Check if a dns var has an allowed name and value
+ *
+ * @param  na=
me         variable name, not NUL terminated
+ * @param  name_size    size =
of the name in bytes
+ * @param  value        variable value, not NUL termi=
nated
+ * @param  value_size   size of the value in bytes
+ *
+ * @return b=
ool to indicate if the var is valid
+ */
+static bool
+dns_var_valid(const =
char *name, size_t name_size, const char *value, size_t value_size)
+{
+   =
 if (!dns_var_name_valid(name, name_size))
+    {
+        return false;
+ =
   }
+
+    if (dns_var_name_is(name, name_size, "dev"))
+    {
+        re=
turn dns_var_dev_valid(value, value_size);
+    }
+
+    return dns_var_val=
ue_valid(value, value_size);
+}
+
+/**
  * Add dns vars received by the upd=
own runner to an env set
  *
- * Every var must be a name=3Dvalue pair=2E I=
f anything is invalid, the vars
- * are rejected as a whole=2E
+ * Every va=
r must be a name=3Dvalue pair with a valid name and value=2E If
+ * anythin=
g is invalid, the vars are rejected as a whole=2E
  *
  * @param  vars     =
NUL terminated name=3Dvalue strings, modified in place
  * @param  size    =
 size of @p vars in bytes
@@ -617,7 +762,8 @@
         const size_t var_siz=
e =3D strlen(var);
         char *next =3D var + var_size + 1;
         cha=
r *eq =3D memchr(var, '=3D', var_size);
-        if (!eq)
+        if (!eq
=
+            || !dns_var_valid(var, (size_t)(eq - var), eq + 1, var_size - =
(size_t)(eq - var) - 1))
         {
             return false;
         }

=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5847d602a02404=
4d9109f521de7885d55d28a968
Gerrit-Change-Number: 2349
Gerrit-PatchSet: 3
Ge=
rrit-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Deri Haerudi <abcder=
yscreenprinting@gmail=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
=
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attentio=
n: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>

--veWpxSt3PbE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Deri Haerudi, Heiko Hund, R=C4=83zvan C=
ojocaru=2E </p>
<p>Heiko Hund <strong>uploaded patch set #3</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/234=
9?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+1 by Deri Haerudi, Code-Review+2 by R=C4=83zva=
n Cojocaru</p><p>The change is no longer submittable: Code-Review and check=
s~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">dns: restrict dn=
s var names and values in the updown runner<br><br>The updown runner hands =
the vars it gets from the unprivileged process<br>to a root script=2E Only =
accept what openvpn itself would send, so that a<br>compromised process can=
not affect the script beyond its DNS settings=2E<br><br>Change-Id: I5847d60=
2a024044d9109f521de7885d55d28a968<br>Signed-off-by: Heiko Hund &lt;heiko@is=
t=2Eeigentlich=2Enet&gt;<br>---<br>M src/openvpn/dns=2Ec<br>1 file changed,=
 149 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/2349/3</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec</span><br><span>index 1bd=
6c85=2E=2Ed00165a1 100644</span><br><span>--- a/src/openvpn/dns=2Ec</span><=
br><span>+++ b/src/openvpn/dns=2Ec</span><br><span>@@ -591,10 +591,155 @@</=
span><br><span> #define DNS_VARS_MAX_SIZE (64 * 1024)</span><br><span> </sp=
an><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Check if a dns var name equals a given name</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param  name     variable name, not NUL terminated</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param  size     size of the n=
ame in bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am  expected NUL terminated name to compare with</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @return bool to indicate if the names are equal</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+dns_var_name_is(const char *name, size_t size, const cha=
r *expected)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return size =3D=3D st=
rlen(expected) &amp;&amp; memcmp(name, expected, size) =3D=3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check=
 if a dns var name is allowed</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Besi=
des dev and script_type, only names starting with dns_ and made of</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * lowercase letters, digits=
 and underscores are allowed=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram  name     variable name, not NUL terminated</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param  size     size of the name in bytes<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return bool to indicate if the na=
me is valid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+dns_var_name_valid(const char *n=
ame, size_t size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char prefi=
x[] =3D &quot;dns_&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dns_v=
ar_name_is(name, size, &quot;dev&quot;) || dns_var_name_is(name, size, &quo=
t;script_type&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (size &lt; sizeof(prefix) || strncmp(=
name, prefix, sizeof(prefix) - 1) !=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0=
; i &lt; size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
char c =3D name[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!((c &gt;=3D &#39;a&#39; &amp;&amp; c &lt;=3D &#39;z&#39;) || (=
c &gt;=3D &#39;0&#39; &amp;&amp; c &lt;=3D &#39;9&#39;) || c =3D=3D &#39;_&=
#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Check if a dns var value contains only=
 allowed characters</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Values are dom=
ain names, IP addresses, port numbers or keywords, so</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * domain name characters and colons are =
allowed=2E A value must not start</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * with a dash, so that it cannot be taken for an option=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param  value    variable value, no=
t NUL terminated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param  size     size of the value in bytes</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return bool to indicate if the value is valid</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+dns_var_value_valid(const char *value, size_t size)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (size &gt; 0 &amp;&amp; value[0] =3D=3D &=
#39;-&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; size; ++i)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        const unsigned char c =3D (unsigned =
char)value[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!is_allowed_domain_ascii(c) &amp;&amp; c !=3D &#39;:&#39;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Check if a dev value contains only allowed character=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Interface names may contain more=
 than domain name characters, so a few</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * characters without special meaning to the shell are a=
llowed as well=2E A</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * name must not start with a dash, so that it cannot be taken for an optio=
n=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param  value    interface na=
me, not NUL terminated</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param  size     size of the name in bytes</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @return bool to indicate if the value is valid</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dns_var_dev_valid(const char *value, size_t size)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const char extra[] =3D &quot;+@%,=3D&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (size =3D=3D 0 || size &gt;=
=3D IFNAMSIZ || value[0] =3D=3D &#39;-&#39;)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =
=3D 0; i &lt; size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst unsigned char c =3D (unsigned char)value[i];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (!is_allowed_domain_ascii(c) &amp;=
&amp; !memchr(extra, c, sizeof(extra) - 1))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            return false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * C=
heck if a dns var has an allowed name and value</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param  name         variable name, not NUL terminated</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  name_size    si=
ze of the name in bytes</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param  value        variable value, not NUL terminated</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param  value_size   size of =
the value in bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return bool to=
 indicate if the var is valid</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_var_valid(=
const char *name, size_t name_size, const char *value, size_t value_size)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!dns_var_name_valid(name, name_=
size))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (dns_var_name_is(name, name_size, &quot;dev&quot;))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return dns_var_dev_valid(=
value, value_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return dns_var_value_valid(va=
lue, value_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Add dns vars re=
ceived by the updown runner to an env set</span><br><span>  *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * Every var must be a name=3Dvalue=
 pair=2E If anything is invalid, the vars</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * are rejected as a whole=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Every var must be a name=3Dvalue pair with=
 a valid name and value=2E If</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * anything is invalid, the vars are rejected as a whole=2E</span=
><br><span>  *</span><br><span>  * @param  vars     NUL terminated name=3Dv=
alue strings, modified in place</span><br><span>  * @param  size     size o=
f @p vars in bytes</span><br><span>@@ -617,7 +762,8 @@</span><br><span>    =
     const size_t var_size =3D strlen(var);</span><br><span>         char *=
next =3D var + var_size + 1;</span><br><span>         char *eq =3D memchr(v=
ar, &#39;=3D&#39;, var_size);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (!eq)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (!eq</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            || !dns_var_valid(var, (size_t)(eq - var), eq + 1, var_size - =
(size_t)(eq - var) - 1))</span><br><span>         {</span><br><span>       =
      return false;</span><br><span>         }</span><br></pre><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demai=
l">change 2349</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2349?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2349 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Deri Haerudi &lt;abcde=
ryscreenprinting@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Deri Haerudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Co=
jocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--veWpxSt3PbE=--


--===============0009315312202247108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0009315312202247108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0009315312202247108==--

