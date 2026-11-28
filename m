Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8A606A31E
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kvA5DhSA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=At67ejMp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f3xQvx9e;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dv+F3D9/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TX+OCBrOAKaRons71Ax685uID16+H1UhMRcnKahOcBM=; b=kvA5DhSAt4B+NmsqbyrqN1DAXy
	dchl4p5BB7ROO7Y2GKJLalnHBVnAlVxG/TfKJp49Yv772noBr8xoXYhrDhvY2JPBWgx6lavczezOi
	1HIMTJKU6H47wxoABDc3KLGzL4sFquMZdg906bav0gqBixxqcPPjglhoKp6V0xJBsbNo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX6rb-000000002bd-27AG;
	Sat, 28 Nov 2026 01:04:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX6ra-000000002bV-0eep
 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 01:04:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/FNun9EDLwhw7liN01MjgZufn5S0QdBzn9afTH6hLaw=; b=At67ejMpKFWlikdIw/zk83QdaC
 j5hGUTYdSzi6Glrmlo3Z0CGYz7KZm5P/J94Iikzgcf5QFv4UDgUkZKGP97AYoFfk5W3wtdXWm1LG0
 ZeAhpr1bC1FL3cgv0YsfCqfIK27ipHBruUNTY74olROFFW9foDMAOzz5Yj+MQ3ddrMUc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/FNun9EDLwhw7liN01MjgZufn5S0QdBzn9afTH6hLaw=; b=f3xQvx9eU2y/m8FFM2WAJ2Pejr
 0Hm2QLLgD+O+qgnbzOU8knm6lX/CdVR7xbUyEuzPhCZcgLX7103zWVoqlbJ4GIRjOlRMVBveaZM/9
 iws0Fq42nraafsFES1WgAlPR/Z1lOMB0JZolyBIMXzXnxi2c7poENV1xSb91sL6GrgFM=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX6rY-000000007HK-1lqj for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 01:04:25 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso6616759f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 17:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795827858; x=1796432658; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/FNun9EDLwhw7liN01MjgZufn5S0QdBzn9afTH6hLaw=;
 b=dv+F3D9/MwDUXj0UNvfM8KIstQp7Tu88OMfC7GHivW4UAJqHcTwH4rxnjKouaW9rjo
 RhEgQ4U7Qrr0mVja5LvWMy4EjtASR4/2qWoUrVSubcq5JD4JbaImqcGEgTFTtzeb7gZF
 Vu0wf1xr9jBZPXLOqCKWh7gjP40/4qasgrDYcirN5DqJmeSRx7gbT8zaCSgdaxPtNPh2
 XFp++vXRMM0Je2p//B59iTSFT1uH67kuLN+Gs9QhX7lexUaQ9rSpQ8YJv8F18xoEPapv
 2NhwTdXRyZOmjlxqrIzu/6S/Fdm8kCYzHG9NWGgNiTKRWMPy9qFqDO/t6Z0UdaGlNp2h
 fZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795827858; x=1796432658;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/FNun9EDLwhw7liN01MjgZufn5S0QdBzn9afTH6hLaw=;
 b=IN4AVIsh6kJZ+ePu5TfxpCkf/EtXO8IPmGlvorOSyLoTGyEJ52qdzs1+xBYkswmTUW
 yN8+beRG6bMSj0I3cCbENRh8cdEHgVfO+owvwPyWkISgOwxUA6SK/SXb3FYtlKassMv6
 x4MS3sJ1itFYxUtfGEXgFEsHCqzJ57Q2ydH2xYe4h0rxe093OlEbH01v1dO0ZGkAz9yk
 JI4Wavmx0HxmlZvWX6tL2TnUfPlikkI7BcXG2z4JEhX+uvnrAqQ7rOqe/GtppzNMUqdk
 ERNVD0Df+fDKXVr0buQGY3mP/75RYZ/NKIlODGMIwbVJmHTn+C4xOPG96XS8bSQKoPNC
 GTHw==
X-Gm-Message-State: APuU4Z+8kconDpmxewehK/quR+gx7AO44/wet6Q3XmWp+GAjbMMMVMef
 dce5blS6cC1eLy0Xv15Nu4X7/nOFftlqdRFcgT9Ptfp+yG46izpp55S/9A/CtmJKWIwCRg5ZuX5
 HO+yLTJGvjsOwHyNSHpZbYCGiJQRS257lQW9zGDAyZ4QnXdnOqbby4YJWihoSbnL/kKt5
X-Gm-Gg: AZFdTZdvbvd1i9G/nisxPuHT91rai/G1oU5aW4+/4tsBUjitMg7QkgmfEvJweg7FOnV
 a80K6zcLP1OWL/3QeFk6xra6Ui8JRvg0o/q7RtsRhlROgy7QJUkCLXz4yrR9o51zLByu3lorsyr
 60y7ldnfZfJIlnmtYb0pnHRko8fdBRDWgR5vPqDDaO1H52hanFZmrLpjNxGIX/cXzAZT0LwfCf3
 mZbrOaV5wON993rolDxt4ugQT4x/gddOZla6tNtjIsRzZ58+WecSeCAFv8RuNQjq5QAXgRQTUpV
 1mk4iNnNUun44Lm4MWVUDfYRhpGCHL5/i1eWnaSD7sJJjzvYGStKxy9hgYzs4oZmWwpl2s5MI2d
 x6LsFKWWJJisUa+tcHSrcll0pIEVseoGGoFCk2yEsnno8g9jTtWqQxAaxBHHXl5frKUTI9Eb/hw
 gQT14Fie7oivp7QdQ6BZxzI+cPrj3gwf1MzYf+uLnv6D70y7Wy/zgX52n3eTNVTDkxV/lpukTcj
 iLCom+E5EWKSkoHGKlCE7dHvGNJH61PbuUkJ3dhvPhOKnc4idY/6ZuwzntPAa3kwkEV+KqWgcDO
 frzBsEFZ7UFKmGdaIgHvqi4awyxXjB/stnzNnho0QWle3DU5A8NnsFiYcXKHmxhV00IEfJ8X4E9
 lbG1a8BMX7gJzCdvp3yUHSIJYZwbN0G7DvaZkz/XTpq0KDOCN8/50nqjjGiMj3t7abPpfaJdtXc
 OzK9uTr7g1TQYqYRM=
X-Received: by 2002:a05:600c:3511:b0:4ba:73f:ef5 with SMTP id
 5b1f17b1804b1-4bb88828304mr553472865e9.34.1795827857574; 
 Fri, 27 Nov 2026 17:04:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884911e3sm898408525e9.6.2026.11.27.17.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 17:04:17 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 28 Nov 2026 01:04:16 +0000
To: Deri Haerudi <abcderyscreenprinting@gmail.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968
X-Gerrit-Change-Number: 2349
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2349?usp=email>
X-Gerrit-Commit: b6bc63f13a9294dfbd40fef75b558999a7627a44
In-Reply-To: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
References: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkk1ODQ3ZDYwMmEwMjQwNDRkOTEwOWY1MjFkZTc4ODVkNTVkMjhhOTY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <12f18e96e8506f94cbba9af1559d3c871322fdad-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX6rY-000000007HK-1lqj
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
Content-Type: multipart/mixed; boundary="===============5448757608217265229=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5448757608217265229==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4vytAEoh5eo="; charset=UTF-8

--4vytAEoh5eo=
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
ch set (#4)=2E

The following approvals got outdated and were removed:
Code=
-Review+1 by Deri Haerudi


Change subject: dns: restrict dns var names and=
 values in the updown runner
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

dns: restrict dns var names and values in the updown runne=
r

The updown runner hands the vars it gets from the unprivileged process
t=
o a root script=2E Only accept what openvpn itself would send, so that a
co=
mpromised process cannot affect the script beyond its DNS settings=2E

Chan=
ge-Id: I5847d602a024044d9109f521de7885d55d28a968
Signed-off-by: Heiko Hund =
<heiko@ist=2Eeigentlich=2Enet>
---
M src/openvpn/dns=2Ec
1 file changed, 15=
5 insertions(+), 3 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/49/2349/4

diff --git a/src/openvpn/dns=2Ec b/src=
/openvpn/dns=2Ec
index 1bd6c85=2E=2E6acef62 100644
--- a/src/openvpn/dns=2E=
c
+++ b/src/openvpn/dns=2Ec
@@ -591,10 +591,161 @@
 #define DNS_VARS_MAX_SI=
ZE (64 * 1024)
 
 /**
+ * Check if a dns var name equals a given name
+ *
+=
 * @param  name     variable name, not NUL terminated
+ * @param  size     =
size of the name in bytes
+ * @param  expected NUL terminated name to compa=
re with
+ *
+ * @return bool to indicate if the names are equal
+ */
+stati=
c bool
+dns_var_name_is(const char *name, size_t size, const char *expected=
)
+{
+    return size =3D=3D strlen(expected) && memcmp(name, expected, siz=
e) =3D=3D 0;
+}
+
+/**
+ * Check if a dns var name is allowed
+ *
+ * Besid=
es dev and script_type, only names starting with dns_ and made of
+ * lower=
case letters, digits and underscores are allowed=2E dns_vars_file is
+ * re=
jected, since older dns-updown scripts source the file it names=2E
+ *
+ * =
@param  name     variable name, not NUL terminated
+ * @param  size     siz=
e of the name in bytes
+ *
+ * @return bool to indicate if the name is vali=
d
+ */
+static bool
+dns_var_name_valid(const char *name, size_t size)
+{
+=
    const char prefix[] =3D "dns_";
+
+    if (dns_var_name_is(name, size, =
"dev") || dns_var_name_is(name, size, "script_type"))
+    {
+        retur=
n true;
+    }
+
+    if (dns_var_name_is(name, size, "dns_vars_file"))
+  =
  {
+        return false;
+    }
+
+    if (size < sizeof(prefix) || strnc=
mp(name, prefix, sizeof(prefix) - 1) !=3D 0)
+    {
+        return false;
=
+    }
+
+    for (size_t i =3D 0; i < size; ++i)
+    {
+        const cha=
r c =3D name[i];
+        if (!((c >=3D 'a' && c <=3D 'z') || (c >=3D '0' &=
& c <=3D '9') || c =3D=3D '_'))
+        {
+            return false;
+    =
    }
+    }
+
+    return true;
+}
+
+/**
+ * Check if a dns var value con=
tains only allowed characters
+ *
+ * Values are domain names, IP addresses=
, port numbers or keywords, so
+ * domain name characters and colons are al=
lowed=2E A value must not start
+ * with a dash, so that it cannot be taken=
 for an option=2E
+ *
+ * @param  value    variable value, not NUL terminat=
ed
+ * @param  size     size of the value in bytes
+ *
+ * @return bool to =
indicate if the value is valid
+ */
+static bool
+dns_var_value_valid(const=
 char *value, size_t size)
+{
+    if (size > 0 && value[0] =3D=3D '-')
+  =
  {
+        return false;
+    }
+
+    for (size_t i =3D 0; i < size; ++i=
)
+    {
+        const unsigned char c =3D (unsigned char)value[i];
+     =
   if (!is_allowed_domain_ascii(c) && c !=3D ':')
+        {
+            r=
eturn false;
+        }
+    }
+
+    return true;
+}
+
+/**
+ * Check if a=
 dev value contains only allowed characters
+ *
+ * Interface names may con=
tain more than domain name characters, so a few
+ * characters without spec=
ial meaning to the shell are allowed as well=2E A
+ * name must not start w=
ith a dash, so that it cannot be taken for an option=2E
+ *
+ * @param  val=
ue    interface name, not NUL terminated
+ * @param  size     size of the n=
ame in bytes
+ *
+ * @return bool to indicate if the value is valid
+ */
+s=
tatic bool
+dns_var_dev_valid(const char *value, size_t size)
+{
+    const=
 char extra[] =3D "+@%,=3D";
+
+    if (size =3D=3D 0 || size >=3D IFNAMSIZ=
 || value[0] =3D=3D '-')
+    {
+        return false;
+    }
+
+    for (s=
ize_t i =3D 0; i < size; ++i)
+    {
+        const unsigned char c =3D (un=
signed char)value[i];
+        if (!is_allowed_domain_ascii(c) && !memchr(e=
xtra, c, sizeof(extra) - 1))
+        {
+            return false;
+       =
 }
+    }
+
+    return true;
+}
+
+/**
+ * Check if a dns var has an allow=
ed name and value
+ *
+ * @param  name         variable name, not NUL termi=
nated
+ * @param  name_size    size of the name in bytes
+ * @param  value =
       variable value, not NUL terminated
+ * @param  value_size   size of =
the value in bytes
+ *
+ * @return bool to indicate if the var is valid
+ *=
/
+static bool
+dns_var_valid(const char *name, size_t name_size, const cha=
r *value, size_t value_size)
+{
+    if (!dns_var_name_valid(name, name_siz=
e))
+    {
+        return false;
+    }
+
+    if (dns_var_name_is(name, n=
ame_size, "dev"))
+    {
+        return dns_var_dev_valid(value, value_siz=
e);
+    }
+
+    return dns_var_value_valid(value, value_size);
+}
+
+/**
=
  * Add dns vars received by the updown runner to an env set
  *
- * Every =
var must be a name=3Dvalue pair=2E If anything is invalid, the vars
- * are=
 rejected as a whole=2E
+ * Every var must be a name=3Dvalue pair with a va=
lid name and value=2E If
+ * anything is invalid, the vars are rejected as =
a whole=2E
  *
  * @param  vars     NUL terminated name=3Dvalue strings, mo=
dified in place
  * @param  size     size of @p vars in bytes
@@ -617,7 +76=
8,8 @@
         const size_t var_size =3D strlen(var);
         char *next =
=3D var + var_size + 1;
         char *eq =3D memchr(var, '=3D', var_size);=

-        if (!eq)
+        if (!eq
+            || !dns_var_valid(var, (si=
ze_t)(eq - var), eq + 1, var_size - (size_t)(eq - var) - 1))
         {
   =
          return false;
         }

-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2349?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968
Gerrit-Change=
-Number: 2349
Gerrit-PatchSet: 4
Gerrit-Owner: Heiko Hund <heiko@ist=2Eeige=
ntlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Deri Haerudi <=
abcderyscreenprinting@gmail=2Ecom>
Gerrit-Attention: Heiko Hund <heiko@ist=
=2Eeigentlich=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--4vytAEoh5eo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Deri Haerudi, Heiko Hund, R=C4=83zvan C=
ojocaru=2E </p>
<p>Heiko Hund <strong>uploaded patch set #4</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/234=
9?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+1 by Deri Haerudi</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">dns: restri=
ct dns var names and values in the updown runner<br><br>The updown runner h=
ands the vars it gets from the unprivileged process<br>to a root script=2E =
Only accept what openvpn itself would send, so that a<br>compromised proces=
s cannot affect the script beyond its DNS settings=2E<br><br>Change-Id: I58=
47d602a024044d9109f521de7885d55d28a968<br>Signed-off-by: Heiko Hund &lt;hei=
ko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M src/openvpn/dns=2Ec<br>1 file cha=
nged, 155 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/2349/4</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec</span><br><span>inde=
x 1bd6c85=2E=2E6acef62 100644</span><br><span>--- a/src/openvpn/dns=2Ec</sp=
an><br><span>+++ b/src/openvpn/dns=2Ec</span><br><span>@@ -591,10 +591,161 =
@@</span><br><span> #define DNS_VARS_MAX_SIZE (64 * 1024)</span><br><span> =
</span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Check if a dns var name equals a given name</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param  name     variable name, not NUL terminated</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  size     size of t=
he name in bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param  expected NUL terminated name to compare with</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return bool to indicate if the names are equal</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+dns_var_name_is(const char *name, size_t size, co=
nst char *expected)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return size =
=3D=3D strlen(expected) &amp;&amp; memcmp(name, expected, size) =3D=3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Check if a dns var name is allowed</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Besides dev and script_type, only names starting with dns_ and made of=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * lowercase letter=
s, digits and underscores are allowed=2E dns_vars_file is</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * rejected, since older dns-updown s=
cripts source the file it names=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param  name     variable name, not NUL terminated</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param  size     size of the name in b=
ytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return bool to indicate if t=
he name is valid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+dns_var_name_valid(const ch=
ar *name, size_t size)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char =
prefix[] =3D &quot;dns_&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
dns_var_name_is(name, size, &quot;dev&quot;) || dns_var_name_is(name, size,=
 &quot;script_type&quot;))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (dns_var_name_is(name, size, &qu=
ot;dns_vars_file&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (size &lt; sizeof(prefix) || strn=
cmp(name, prefix, sizeof(prefix) - 1) !=3D 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =
=3D 0; i &lt; size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst char c =3D name[i];</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (!((c &gt;=3D &#39;a&#39; &amp;&amp; c &lt;=3D &#39;z&#39;)=
 || (c &gt;=3D &#39;0&#39; &amp;&amp; c &lt;=3D &#39;9&#39;) || c =3D=3D &#=
39;_&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Check if a dns var value contains=
 only allowed characters</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Values ar=
e domain names, IP addresses, port numbers or keywords, so</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * domain name characters and colons=
 are allowed=2E A value must not start</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * with a dash, so that it cannot be taken for an option=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param  value    variable valu=
e, not NUL terminated</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param  size     size of the value in bytes</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @return bool to indicate if the value is valid</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dns_var_value_valid(const char *value, size_t size)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (size &gt; 0 &amp;&amp; value[0] =
=3D=3D &#39;-&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; size; ++i)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const unsigned char c =3D (u=
nsigned char)value[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (!is_allowed_domain_ascii(c) &amp;&amp; c !=3D &#39;:&#39;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Check if a dev value contains only allowed cha=
racters</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Interface names may contai=
n more than domain name characters, so a few</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * characters without special meaning to the shell=
 are allowed as well=2E A</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * name must not start with a dash, so that it cannot be taken for an=
 option=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  value    interf=
ace name, not NUL terminated</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param  size     size of the name in bytes</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @return bool to indicate if the value is valid</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+dns_var_dev_valid(const char *value, size_t size)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char extra[] =3D &quot;+@%,=
=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (size =3D=3D 0 || siz=
e &gt;=3D IFNAMSIZ || value[0] =3D=3D &#39;-&#39;)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_=
t i =3D 0; i &lt; size; ++i)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   const unsigned char c =3D (unsigned char)value[i];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!is_allowed_domain_ascii(c) &=
amp;&amp; !memchr(extra, c, sizeof(extra) - 1))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Check if a dns var has an allowed name and value</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param  name         variable name, not NUL terminated<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  name_size=
    size of the name in bytes</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param  value        variable value, not NUL terminated</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  value_size   si=
ze of the value in bytes</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return b=
ool to indicate if the var is valid</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_var_=
valid(const char *name, size_t name_size, const char *value, size_t value_s=
ize)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!dns_var_name_valid(name,=
 name_size))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (dns_var_name_is(name, name_size, &quot;dev&q=
uot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return dns_var_dev_=
valid(value, value_size);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return dns_var_value_va=
lid(value, value_size);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Add dns v=
ars received by the updown runner to an env set</span><br><span>  *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * Every var must be a name=
=3Dvalue pair=2E If anything is invalid, the vars</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * are rejected as a whole=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Every var must be a name=3Dvalue p=
air with a valid name and value=2E If</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * anything is invalid, the vars are rejected as a whole=
=2E</span><br><span>  *</span><br><span>  * @param  vars     NUL terminated=
 name=3Dvalue strings, modified in place</span><br><span>  * @param  size  =
   size of @p vars in bytes</span><br><span>@@ -617,7 +768,8 @@</span><br><=
span>         const size_t var_size =3D strlen(var);</span><br><span>      =
   char *next =3D var + var_size + 1;</span><br><span>         char *eq =3D=
 memchr(var, &#39;=3D&#39;, var_size);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (!eq)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (!eq</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            || !dns_var_valid(var, (size_t)(eq - var), eq + 1, va=
r_size - (size_t)(eq - var) - 1))</span><br><span>         {</span><br><spa=
n>             return false;</span><br><span>         }</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?u=
sp=3Demail">change 2349</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2349?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2349 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Deri Haerud=
i &lt;abcderyscreenprinting@gmail=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Deri Haerudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeig=
entlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>

</body></html>
--4vytAEoh5eo=--


--===============5448757608217265229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5448757608217265229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5448757608217265229==--

