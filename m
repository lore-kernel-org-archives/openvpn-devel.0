Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D96A606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aOl5SMKS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=N3KK1AjS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jajvlmeR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dbzHLimp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=tOGT4zxXx+mcnXzD18rYNVa47WOOV6vLrP3nSsV8P8I=; b=aOl5SMKSvhGDcUctjWYO/cjcRh
	9QafIAa6HMwAxjM6bj8UoxjAxS1Yy/aoulwDcaHC+x7258vFDR+ZV6C7sbxn9iaTyETzSCsuSECyl
	G71nihkDl+ctTaHwYXdMuWsgHLjUmfhuSukgjCbFRAsPzGSsk0vRGiL4ZJplCkp0jfbE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWTGZ-0000000006V-3hQV;
	Thu, 26 Nov 2026 06:47:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWTGX-0000000006N-0n17
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 06:47:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sBdz5Et3slLlOsGNC8iKwnfax594TY3lHY1rOrZPlFg=; b=N3KK1AjSamLZcGUsLmFYcbA9tm
 +4MXcaw/tBmPEnciqMILfFRjmSHUDV8bvKAyGmxfkqSYw8YE41E43A3SQ4k/iUnDG/Q1uJFQlcWy3
 y555hDddDGpnVabdUAfyLzQCDbXrUFQKcODGTqRMwAx0Pe2pyolba1roXqcvKmUPvPUE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sBdz5Et3slLlOsGNC8iKwnfax594TY3lHY1rOrZPlFg=; b=jajvlmeRWHg3zZM/UwWMMr43bQ
 8fxLvepvX/HcEG5j2iD7Cm1IRkbx0eQSIsb9V2FGIop5sT/AgC1cLjhoQNfDuV8mo0v11tKNvHy/l
 MV2cikQJPz5Z2/DqxDuZ3sdbdReDfdN9GKdWn4bI2qgimMlcSAcqvDWFbdNeaGDOYMZk=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWTGT-000000003jX-02xe for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 06:47:33 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so45237285e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 22:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795675642; x=1796280442; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sBdz5Et3slLlOsGNC8iKwnfax594TY3lHY1rOrZPlFg=;
 b=dbzHLimpseNV4kjQ2asaAa2c7WP/AqntPUOk5DahQItMAali5EhmDpQjm97hpkxjPm
 adNuvvSKfp0FUBLVbobt+maF4yD8rBn7jENG3x7EdRx/yIhv319gc1p94iqqFvFtyN0V
 qeoiLDRHl9WR4echvbd+TGYpMlU5BCuy1ASn64WqvT7mPhGorHTxFp8JA1tEy0kOzUoM
 siVrk7PuMAR33L+szvj+befDwpR7gC/vaKCIMTn863Ve6aOjZ5mWjyULxVDDhyEoTmic
 X9FX+MAjgJDYFz55LE/SB18KBFo+bNsnwu5P+GDsHGsXm/NLCCPDvKVf5PtggT36LpJr
 lIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795675642; x=1796280442;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sBdz5Et3slLlOsGNC8iKwnfax594TY3lHY1rOrZPlFg=;
 b=vw0KcUs83y/GWWStKQmcftdQ7rumvCxtG+JhWmn4bQ8YBikwhNZsFF0tCv8b+ySOL+
 PqoRgIJFrYv/Q8ZyxrNV6RDf2JKZXMotl/qhvSxgwNyhee1e+rPRueN6fTPKcRjoMJic
 isXNwG5K3diPVOz2E6nuZ1hPNOpb6jN9VyxLt+59/DdhfPyn5qM6/qn6dyR2fAVkf1vZ
 5Dij6515N03oUtz7Fg3Njhk0HDpWJRjUD0JygxF8SYrE7MvjlPgdVzv32J9b59I1cJqw
 xLCqOXrcSXZ18kLcMIcfs2fEvSjhI0scS+lSXAi6eNL1r0nNAff5P+OLYjhxCWmXijvr
 vnyA==
X-Gm-Message-State: APuU4Z+D2Rx2Rrdcw73ev+D226wKMRLLc7DtJcjFwOVGy1KSQLjCitcH
 RP6sL0+Dqqx6pXeqeDR9CHlyXEAPBLCqh2kmbleod+cMdapxdcwi+wG6Rpr1oJXjLgDiqR/zOXE
 QaRjBJROUdWWqQnTYtETw3Mi1+SQEO2vD/lSU4Yx4Wxcc+VLoxrUjNDbK8BAX2ylgAcDm6rpOSR
 5GXdz8eQ==
X-Gm-Gg: AZFdTZfjpW/fboPER86RhC8v62svwWJX0ldCu1MerQ3NTidgieClNNU7XZBncHL9l4O
 h46hicIT9fNCHArtwXtKnx0FzyZLRnj5tLlzY1MxVdSFgmj7DU6gaw1WpyDEuNOSSksvA2VTDtM
 slaqNRrhvRF2hHd6sHC41H1AoAHwImbttoPPgiPA8Wu/k9aAxn4QnIXXrlCkjT0fw5kVQPMnYKb
 kzlAe+bb85mhpNJgyp5MM2gP1/FFIE3BAcfgaB3P2Kj+ang7fBD1weGL5emil8mnfJLPA5vHb0Q
 /7ay2097YgVg14ctFPgIDh4aCCshnXKMnw+/roowPXVy+utq0Rf+hHtSfc+9KqueH+capCiFPme
 IgCH1n34G45TLOsl5fwsua+9BUkL7PePAis4cbO6CohDAxd7NVTEPJXXjfLQT/1ruEOH9LQWYzf
 vo/IqWSXgPNPscUCEvOnsoccEs0dZ+dkgJa6G75j7PDoRnFh7K4nK/06KAeLCEtktojdYv3v2FY
 xeIcuP1W2xhu+M5aTv4tOWKJmPvKHiXQa26TTVQM8bCcgrx7aKUwSe47IZKhv5Zla2AfqBxfufO
 pm6ERRfvW0WeV5E/E97SLpJAgc5IQ5DAmgvjYR8H4bzkwqzv/oB+dh/vw8uGRwEPUfmHMLYKdzw
 +fmJwa+EAdMWlnhECKtWTQmzBJ6RcrPSxkMXLiPIzD84JzLdr2JX/zr1e0wm00xVkIsmPZXSpd3
 LNGySStJB9C89BqeN8r8k4s4P5TJVSL42yuz4n
X-Received: by 2002:a05:600c:5307:b0:4a3:d327:6ed with SMTP id
 5b1f17b1804b1-4bb888283d8mr391658875e9.17.1795675642318; 
 Wed, 25 Nov 2026 22:47:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm643569805e9.10.2026.11.25.22.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:47:21 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 06:47:21 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968
X-Gerrit-Change-Number: 2349
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2349?usp=email>
X-Gerrit-Commit: efe5454d84dea673f97b84abf0d843ac9d6af63d
References: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkk1ODQ3ZDYwMmEwMjQwNDRkOTEwOWY1MjFkZTc4ODVkNTVkMjhhOTY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f2ce55c5fae222ac6dabf41337316170335d405a-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWTGT-000000003jX-02xe
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
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9071290921271198306=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9071290921271198306==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2EGNFb+0g6o="; charset=UTF-8

--2EGNFb+0g6o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2349?usp=3Demail

to review the following change=2E
=


Change subject: dns: restrict dns var names and values in the updown runn=
er
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dns: restr=
ict dns var names and values in the updown runner

The updown runner hands =
the vars it gets from the unprivileged process
to a root script=2E Only acc=
ept what openvpn itself would send, so that a
compromised process cannot af=
fect the script beyond its DNS settings=2E

Change-Id: I5847d602a024044d910=
9f521de7885d55d28a968
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2En=
et>
---
M src/openvpn/dns=2Ec
1 file changed, 149 insertions(+), 3 deletion=
s(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
49/2349/1

diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index 1bd=
6c85=2E=2Ed00165a1 100644
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=
=2Ec
@@ -591,10 +591,155 @@
 #define DNS_VARS_MAX_SIZE (64 * 1024)
 
 /**
+=
 * Check if a dns var name equals a given name
+ *
+ * @param  name     var=
iable name, not NUL terminated
+ * @param  size     size of the name in byt=
es
+ * @param  expected NUL terminated name to compare with
+ *
+ * @return=
 bool to indicate if the names are equal
+ */
+static bool
+dns_var_name_is=
(const char *name, size_t size, const char *expected)
+{
+    return size =
=3D=3D strlen(expected) && memcmp(name, expected, size) =3D=3D 0;
+}
+
+/**=

+ * Check if a dns var name is allowed
+ *
+ * Besides dev and script_type=
, only names starting with dns_ and made of
+ * lowercase letters, digits a=
nd underscores are allowed=2E
+ *
+ * @param  name     variable name, not N=
UL terminated
+ * @param  size     size of the name in bytes
+ *
+ * @retur=
n bool to indicate if the name is valid
+ */
+static bool
+dns_var_name_val=
id(const char *name, size_t size)
+{
+    const char prefix[] =3D "dns_";
+=

+    if (dns_var_name_is(name, size, "dev") || dns_var_name_is(name, size,=
 "script_type"))
+    {
+        return true;
+    }
+
+    if (size < size=
of(prefix) || strncmp(name, prefix, sizeof(prefix) - 1) !=3D 0)
+    {
+   =
     return false;
+    }
+
+    for (size_t i =3D 0; i < size; ++i)
+    {=

+        const char c =3D name[i];
+        if (!((c >=3D 'a' && c <=3D 'z=
') || (c >=3D '0' && c <=3D '9') || c =3D=3D '_'))
+        {
+            =
return false;
+        }
+    }
+
+    return true;
+}
+
+/**
+ * Check if =
a dns var value contains only allowed characters
+ *
+ * Values are domain =
names, IP addresses, port numbers or keywords, so
+ * domain name character=
s and colons are allowed=2E A value must not start
+ * with a dash, so that=
 it cannot be taken for an option=2E
+ *
+ * @param  value    variable valu=
e, not NUL terminated
+ * @param  size     size of the value in bytes
+ *
+=
 * @return bool to indicate if the value is valid
+ */
+static bool
+dns_va=
r_value_valid(const char *value, size_t size)
+{
+    if (size > 0 && value=
[0] =3D=3D '-')
+    {
+        return false;
+    }
+
+    for (size_t i =
=3D 0; i < size; ++i)
+    {
+        const unsigned char c =3D (unsigned c=
har)value[i];
+        if (!is_allowed_domain_ascii(c) && c !=3D ':')
+    =
    {
+            return false;
+        }
+    }
+
+    return true;
+}
+=

+/**
+ * Check if a dev value contains only allowed characters
+ *
+ * Int=
erface names may contain more than domain name characters, so a few
+ * cha=
racters without special meaning to the shell are allowed as well=2E A
+ * n=
ame must not start with a dash, so that it cannot be taken for an option=2E=

+ *
+ * @param  value    interface name, not NUL terminated
+ * @param  si=
ze     size of the name in bytes
+ *
+ * @return bool to indicate if the va=
lue is valid
+ */
+static bool
+dns_var_dev_valid(const char *value, size_t=
 size)
+{
+    const char extra[] =3D "+@%,=3D";
+
+    if (size =3D=3D 0 |=
| size >=3D IFNAMSIZ || value[0] =3D=3D '-')
+    {
+        return false;
=
+    }
+
+    for (size_t i =3D 0; i < size; ++i)
+    {
+        const uns=
igned char c =3D (unsigned char)value[i];
+        if (!is_allowed_domain_a=
scii(c) && !memchr(extra, c, sizeof(extra) - 1))
+        {
+            re=
turn false;
+        }
+    }
+
+    return true;
+}
+
+/**
+ * Check if a =
dns var has an allowed name and value
+ *
+ * @param  name         variable=
 name, not NUL terminated
+ * @param  name_size    size of the name in byte=
s
+ * @param  value        variable value, not NUL terminated
+ * @param  v=
alue_size   size of the value in bytes
+ *
+ * @return bool to indicate if =
the var is valid
+ */
+static bool
+dns_var_valid(const char *name, size_t =
name_size, const char *value, size_t value_size)
+{
+    if (!dns_var_name_=
valid(name, name_size))
+    {
+        return false;
+    }
+
+    if (dns=
_var_name_is(name, name_size, "dev"))
+    {
+        return dns_var_dev_va=
lid(value, value_size);
+    }
+
+    return dns_var_value_valid(value, val=
ue_size);
+}
+
+/**
  * Add dns vars received by the updown runner to an en=
v set
  *
- * Every var must be a name=3Dvalue pair=2E If anything is inval=
id, the vars
- * are rejected as a whole=2E
+ * Every var must be a name=3D=
value pair with a valid name and value=2E If
+ * anything is invalid, the v=
ars are rejected as a whole=2E
  *
  * @param  vars     NUL terminated name=
=3Dvalue strings, modified in place
  * @param  size     size of @p vars in=
 bytes
@@ -617,7 +762,8 @@
         const size_t var_size =3D strlen(var);
=
         char *next =3D var + var_size + 1;
         char *eq =3D memchr(va=
r, '=3D', var_size);
-        if (!eq)
+        if (!eq
+            || !dn=
s_var_valid(var, (size_t)(eq - var), eq + 1, var_size - (size_t)(eq - var) =
- 1))
         {
             return false;
         }

-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28=
a968
Gerrit-Change-Number: 2349
Gerrit-PatchSet: 1
Gerrit-Owner: Heiko Hund=
 <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--2EGNFb+0g6o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">dns: restrict dns var names and values in the updown runner<br><b=
r>The updown runner hands the vars it gets from the unprivileged process<br=
>to a root script=2E Only accept what openvpn itself would send, so that a<=
br>compromised process cannot affect the script beyond its DNS settings=2E<=
br><br>Change-Id: I5847d602a024044d9109f521de7885d55d28a968<br>Signed-off-b=
y: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M src/openvpn/=
dns=2Ec<br>1 file changed, 149 insertions(+), 3 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/49/2349/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec=
</span><br><span>index 1bd6c85=2E=2Ed00165a1 100644</span><br><span>--- a/s=
rc/openvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</span><br><spa=
n>@@ -591,10 +591,155 @@</span><br><span> #define DNS_VARS_MAX_SIZE (64 * 1=
024)</span><br><span> </span><br><span> /**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Check if a dns var name equals a given name</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param  name     variable name, not NU=
L terminated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am  size     size of the name in bytes</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param  expected NUL terminated name to compare with<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return bool to indicate if the na=
mes are equal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dns_var_name_is(const char *na=
me, size_t size, const char *expected)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return size =3D=3D strlen(expected) &amp;&amp; memcmp(name, expected, =
size) =3D=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Check if a dns var name is allowed</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Besides dev and script_type, only names starting with=
 dns_ and made of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 lowercase letters, digits and underscores are allowed=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param  name     variable name, not NUL terminated<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  size     =
size of the name in bytes</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
bool to indicate if the name is valid</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_va=
r_name_valid(const char *name, size_t size)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char prefix[] =3D &quot;dns_&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (dns_var_name_is(name, size, &quot;dev&quot;) || dns_=
var_name_is(name, size, &quot;script_type&quot;))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (size &lt=
; sizeof(prefix) || strncmp(name, prefix, sizeof(prefix) - 1) !=3D 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    for (size_t i =3D 0; i &lt; size; ++i)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const char c =3D name[i];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (!((c &gt;=3D &#39;a&#39; &amp;&amp;=
 c &lt;=3D &#39;z&#39;) || (c &gt;=3D &#39;0&#39; &amp;&amp; c &lt;=3D &#39=
;9&#39;) || c =3D=3D &#39;_&#39;))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check if a=
 dns var value contains only allowed characters</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Values are domain names, IP addresses, port numbers or keywor=
ds, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * domain nam=
e characters and colons are allowed=2E A value must not start</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * with a dash, so that it cannot=
 be taken for an option=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
 value    variable value, not NUL terminated</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param  size     size of the value in bytes</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @return bool to indicate if the value=
 is valid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+dns_var_value_valid(const char *va=
lue, size_t size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (size &gt; 0 =
&amp;&amp; value[0] =3D=3D &#39;-&#39;)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; =
i &lt; size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const un=
signed char c =3D (unsigned char)value[i];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!is_allowed_domain_ascii(c) &amp;&amp; c=
 !=3D &#39;:&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Check if a dev value conta=
ins only allowed characters</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Interf=
ace names may contain more than domain name characters, so a few</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * characters without special =
meaning to the shell are allowed as well=2E A</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * name must not start with a dash, so that it ca=
nnot be taken for an option=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram  value    interface name, not NUL terminated</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param  size     size of the name in bytes<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return bool to indicate if the va=
lue is valid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+dns_var_dev_valid(const char *v=
alue, size_t size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char extr=
a[] =3D &quot;+@%,=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (si=
ze =3D=3D 0 || size &gt;=3D IFNAMSIZ || value[0] =3D=3D &#39;-&#39;)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (size_t i =3D 0; i &lt; size; ++i)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        const unsigned char c =3D (unsigned char)value[i];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!is_allowed=
_domain_ascii(c) &amp;&amp; !memchr(extra, c, sizeof(extra) - 1))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Check if a dns var has an allowed name and value</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param  name         variable name, n=
ot NUL terminated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param  name_size    size of the name in bytes</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param  value        variable value, not NUL=
 terminated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m  value_size   size of the value in bytes</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @return bool to indicate if the var is valid</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+dns_var_valid(const char *name, size_t name_size, const char *val=
ue, size_t value_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dns_va=
r_name_valid(name, name_size))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (dns_var_name_is(name, name=
_size, &quot;dev&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn dns_var_dev_valid(value, value_size);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n dns_var_value_valid(value, value_size);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span>  * Add dns vars received by the updown runner to an env set</span><br=
><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Every va=
r must be a name=3Dvalue pair=2E If anything is invalid, the vars</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * are rejected as a whole=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Every var must be =
a name=3Dvalue pair with a valid name and value=2E If</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * anything is invalid, the vars are reje=
cted as a whole=2E</span><br><span>  *</span><br><span>  * @param  vars    =
 NUL terminated name=3Dvalue strings, modified in place</span><br><span>  *=
 @param  size     size of @p vars in bytes</span><br><span>@@ -617,7 +762,8=
 @@</span><br><span>         const size_t var_size =3D strlen(var);</span><=
br><span>         char *next =3D var + var_size + 1;</span><br><span>      =
   char *eq =3D memchr(var, &#39;=3D&#39;, var_size);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!eq)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (!eq</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            || !dns_var_valid(var, (size_t)(eq - v=
ar), eq + 1, var_size - (size_t)(eq - var) - 1))</span><br><span>         {=
</span><br><span>             return false;</span><br><span>         }</spa=
n><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2349?usp=3Demail">change 2349</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2349?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28=
a968 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2349 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--2EGNFb+0g6o=--


--===============9071290921271198306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9071290921271198306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9071290921271198306==--

