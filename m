Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89618C5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=//ci9kTirCLPpKBDcMlwMWMkRZMMqTyCx2koofhApx4=; b=J0jr6PXqlg7xFH
	6N22pVcLB0v9i0h79S5snXS3pPu+RCF2gvwf6fA5DHiD2gSktAATMATw3m7qqYHXyTSj5aIq70NBN
	Xi802hRW5hyPMMXVKc5BbESQdiLisB9y77+2NCYrO4cHj3sr5BGx+32cvJylHD2n9atKnHht52XeK
	3nA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvw9k-0002T7-8v;
	Mon, 17 Aug 2026 12:09:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvw9h-0002R1-W3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:09:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nfXLsFbbv5ETCGtWxg9FAgBzDTXkn2wLxume7+0BQ8c=; b=d/E6SBkrOW6xxXbtcON4tTii2Q
 DezDpC4EGlVyJbOeOSJxOY/MnGdDZY6RCKKHv0O9OupGiqp7sFTwLNvVoBaUprE2R4gJsaijdXLQX
 mmK4I1H57kbcqFCpLSLs4OuEObmv3L2A/juLuuRuYb9g/ykQpuaILJm/dcFx+GzY+MIE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nfXLsFbbv5ETCGtWxg9FAgBzDTXkn2wLxume7+0BQ8c=; b=R
 qhy+fymvsVSANtDJTcaQcNOyklb5ZSIygYyIxhAT6P6zZEYNIp53MmybzXAvw0W4hT+54pWUCH6xw
 B01A+YxV8xTO9ucw34COGqXQ1cRLAqbIGcEi0RumRN/KL5cZkDrMRDWqvbzNMwVRZzgT3OPhzVthN
 ig0Za87v4LtmZXLU=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvw9D-0001pl-2a for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:09:05 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso24904275e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786968529; x=1787573329; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nfXLsFbbv5ETCGtWxg9FAgBzDTXkn2wLxume7+0BQ8c=;
 b=OkPj1c56d9W7AdFgSaG2oS3Rvwjw6RCvh4iGIc25xTlqqHpsbmIN5YBBHDKPqXnxOr
 7qEcOqFZQ0+Gq5rpVExKqqMLaMYAPtCqNn74D8iwswt2xxiXpCBGMoiw0ha26cIfAusU
 XBjLxwymJsYtRXiCF91t6x8auBcxt23HJ8NCIPF6tuDA8C1aD6M1adZCKrHK3jFKAUTI
 lBvBVikbuf3im0kdRwE4gndP3T2QM8Y8KeTwm7y7X2oRZAE5UQC5b9x+XteWby8VQ3rQ
 aTN0Gaad82RUHMcGwHwxR7ab8dQ2CDZaKVUSeFBYa1VvEkaCoEZebE1YhmY2KvCGc/r0
 eu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786968529; x=1787573329;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nfXLsFbbv5ETCGtWxg9FAgBzDTXkn2wLxume7+0BQ8c=;
 b=iDvB8ppvUlMT1wP4eoAQ4Yf8cPrg6O9+eOpS8NqCzvImBYuBJkXNjpurV7greTPgBK
 67v+/G6HyKP2CviJdSCNVDnhN0SVZ9sAoK4qTJGmWEWVVgW3Jk4/Kn2ySxMQmCj2aHUX
 sr39H2W4HhhQ5DrwKU58D2uATUxR+hyoi+TPx9xVd6dSZq57ssUZgrxin76irYBK9/Ri
 xZiQkB2huODBLwft4KNK0DWEZfqM2kQty1RO7HhVBSnCgNdRTiThBLtrd7i72YRzrmKi
 /7omzxaA8NUC4wQQIK37OH0dM0Dv5YViTxWI8hy8uxFx2QSRcypakralOQ8MVIOBxyFL
 1OkA==
X-Gm-Message-State: AOJu0YxfUh6Kz4TX7P7OhRBqVFsK+oPvyfTHhjx2wUV6t85gtOTZ2HNI
 ociwwIvl+RPpOQ1qmqWkojBg+v7BSGktV0TXQrBbfpzDAWBR+ayvVDFEX6OFeRw0/7OPffAvWPf
 ibUXU8aaEOJeY1/SLKh71CqnOs/CjHxYXvpCfmBf1Vy0SmfNGU0hdWYXbxUfKtQVHnloLMDff3g
 mIMC/qZg==
X-Gm-Gg: AR+sD13Q2twen7UyQC8eaqqz9mmAG+MLCEh9ckeeWykd84jrYaXsuDymHvuKB7sT/H+
 B9hYwRxOYFFdVmdNl0eVDj8yeeYDr8brUKZlwHw/4wzWwmF4RwadOpJrMMzWLwmlQNUz7bkmnEt
 Wf/0+V98lCJFWQWLAGKMm/z870UcnmbEEs6+ol7trGYsMmi6ZGZ9IP/XE9MEoL8HtRqad1WiyIH
 m5OB1Oot3So3MWc6FiLncmVNbPAMEuodsJLePSHPCufYnm+ztFktxj5bFvCPA0dq9Sqrqw+ia0C
 1/hIR6oXRYS0PHhjRHQgn69hV1mbg3156IgMuiDE2Q+a2tnSfZPPHUFUHDq7KvUqyjYM7+v12+M
 hK5GaxT8Jh80RL1j4OTJN0h4j+N2wEGnW1yKGEKXmjHHr6LhW9rCcUdM4EviKzw6VjJl9U4CJmk
 pS2792OpDXk+blMBdqeUHvMUVA/200jhRVFlPvxK+6KGDp6XM1bo6CFXkFWmiUMAddbwTPsVgDz
 Lb1Yy6KcweiSc/M9HLs1/YnSwVnXvxC8olnNbk/9jwL1itk2UmiKN9gkCY6Hg6PcJyUhYve3RgW
 9tZ7EGoUtBUnzGU3RVECtlTv89tcp/QQdkA46PqWhfP1+vwgMQjMnZG/fHOzdA==
X-Received: by 2002:a05:600c:4f56:b0:499:7312:2d5f with SMTP id
 5b1f17b1804b1-4998799eb7dmr410139955e9.19.1786968527873; 
 Mon, 17 Aug 2026 05:08:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b77f41sm3345979f8f.27.2026.08.17.05.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:08:46 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:08:45 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f
X-Gerrit-Change-Number: 1846
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1846?usp=email>
X-Gerrit-Commit: e2ff0fc4c7e12f0cf70d60bf29f7caf463b9a285
References: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTY4NDk1MDAwLkkxMmJlZjMzMGUyYzhhNWU1YjIxYzJmYTgwNzU4NDMxOWIyYjcxMDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a81cc49f46bc0a7e4d4da24c892a53e62ac2d560-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvw9D-0001pl-2a
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Factor out address
 resolve code to a new file resolve.c
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
Content-Type: multipart/mixed; boundary="===============7687922120464432133=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7687922120464432133==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jVMj5OcQvEI="; charset=UTF-8

--jVMj5OcQvEI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1846?usp=3Demail

to review the following change=2E


Chang=
e subject: Factor out address resolve code to a new file resolve=2Ec
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Factor out address =
resolve code to a new file resolve=2Ec

The code was weirdly split between =
socket=2Ec, socket_util=2Ec,
and options=2Ec=2E The new structure makes mor=
e sense=2E

While here move some related string helper code to buffer=2Eh=
=2E

Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
---
M CMakeLists=2Etxt
M src/open=
vpn/Makefile=2Eam
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/o=
penvpn/clinat=2Ec
M src/openvpn/dns=2Ec
M src/openvpn/init=2Ec
M src/openvp=
n/manage=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/open=
vpn/pool=2Ec
M src/openvpn/ps=2Ec
M src/openvpn/push=2Ec
A src/openvpn/reso=
lve=2Ec
A src/openvpn/resolve=2Eh
M src/openvpn/route=2Ec
M src/openvpn/soc=
ket=2Ec
M src/openvpn/socket=2Eh
M src/openvpn/socket_util=2Ec
M src/openvp=
n/socket_util=2Eh
M src/openvpn/tun=2Ec
21 files changed, 815 insertions(+)=
, 707 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/46/1846/1

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
i=
ndex 6c66ebd=2E=2E52728f1 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2E=
txt
@@ -565,6 +565,8 @@
     src/openvpn/reflect_filter=2Eh
     src/openvp=
n/reliable=2Ec
     src/openvpn/reliable=2Eh
+    src/openvpn/resolve=2Ec
+=
    src/openvpn/resolve=2Eh
     src/openvpn/route=2Ec
     src/openvpn/rou=
te=2Eh
     src/openvpn/run_command=2Ec
diff --git a/src/openvpn/Makefile=
=2Eam b/src/openvpn/Makefile=2Eam
index 182d732=2E=2Ead46ed0 100644
--- a/s=
rc/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -125,6 +125,7 @=
@
 	pushlist=2Eh \
 	reflect_filter=2Ec reflect_filter=2Eh \
 	reliable=2Ec=
 reliable=2Eh \
+	resolve=2Ec resolve=2Eh \
 	route=2Ec route=2Eh \
 	run_c=
ommand=2Ec run_command=2Eh \
 	schedule=2Ec schedule=2Eh \
diff --git a/src=
/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index a004b60=2E=2Eae290ca 100=
644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -1098,6 +1=
098,23 @@
     }
 }
 
+bool
+streqnull(const char *a, const char *b)
+{
+  =
  if (a =3D=3D NULL && b =3D=3D NULL)
+    {
+        return true;
+    }
+=
    else if (a =3D=3D NULL || b =3D=3D NULL)
+    {
+        return false;
=
+    }
+    else
+    {
+        return streq(a, b);
+    }
+}
+
 char *
 s=
tring_substitute(const char *src, char from, char to, struct gc_arena *gc)
=
 {
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index ab8c2=
39=2E=2Efb2cd85 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffe=
r=2Eh
@@ -1766,6 +1766,18 @@
     return 0 =3D=3D strncmp(str, prefix, strl=
en(prefix));
 }
 
+/** helper to work around the semantics of the strcmp() =
return value
+ * @return true if the strings are equal according to strcmp(=
)
+ */
+#define streq(x, y) (!strcmp((x), (y)))
+
+/** compare two strings =
which might be NULL
+ * @return true if both strings are NULL, or if they a=
re equal according to strcmp()
+ */
+bool streqnull(const char *a, const ch=
ar *b);
+/** compare two strings which might be NULL, but NULL is never equ=
al
+ * @return true if neither string is NULL and they are equal according =
to strcmp()
+ */
 bool string_defined_equal(const char *s1, const char *s2)=
;
 char *string_substitute(const char *src, char from, char to, struct gc_a=
rena *gc);
 
diff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec
i=
ndex b465950=2E=2E595566a 100644
--- a/src/openvpn/clinat=2Ec
+++ b/src/ope=
nvpn/clinat=2Ec
@@ -30,6 +30,7 @@
 #include "proto=2Eh"
 #include "socket_u=
til=2Eh"
 #include "memdbg=2Eh"
+#include "resolve=2Eh"
 
 static bool
 add=
_entry(struct client_nat_option_list *dest, const struct client_nat_entry *=
e)
diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index 7f4dde4=2E=
=2Ea40f3e7 100644
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -2=
7,7 +27,7 @@
 #include "syshead=2Eh"
 
 #include "dns=2Eh"
-#include "socke=
t_util=2Eh"
+#include "resolve=2Eh"
 #include "options=2Eh"
 #include "run_=
command=2Eh"
 #include "domain_helper=2Eh"
diff --git a/src/openvpn/init=2E=
c b/src/openvpn/init=2Ec
index 38db7fa=2E=2E223c245 100644
--- a/src/openvp=
n/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -55,6 +55,7 @@
 #include "tun_afun=
ix=2Eh"
 #include "schedule=2Eh"
 #include "options_string=2Eh"
+#include "=
resolve=2Eh"
 
 #include "memdbg=2Eh"
 
diff --git a/src/openvpn/manage=2Ec=
 b/src/openvpn/manage=2Ec
index 17abfd8=2E=2E857e320 100644
--- a/src/openv=
pn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -44,6 +44,7 @@
 #include "dco=
=2Eh"
 #include "push=2Eh"
 #include "multi=2Eh"
+#include "resolve=2Eh"
 
=
 #include "memdbg=2Eh"
 
diff --git a/src/openvpn/options=2Ec b/src/openvpn=
/options=2Ec
index 74b1f25=2E=2E4595266 100644
--- a/src/openvpn/options=2E=
c
+++ b/src/openvpn/options=2Ec
@@ -64,6 +64,7 @@
 #include "domain_helper=
=2Eh"
 #include "mbuf=2Eh"
 #include "check_file_access=2Eh"
+#include "res=
olve=2Eh"
 
 #include <ctype=2Eh>
 
@@ -1055,26 +1056,6 @@
 
 #endif /* ifn=
def _WIN32 */
 
-static in_addr_t
-get_ip_addr(const char *ip_string, msglv=
l_t msglevel, bool *error)
-{
-    unsigned int flags =3D GETADDR_HOST_ORDE=
R;
-    bool succeeded =3D false;
-    in_addr_t ret;
-
-    if (msglevel &=
 M_FATAL)
-    {
-        flags |=3D GETADDR_FATAL;
-    }
-
-    ret =3D g=
etaddr(flags, ip_string, 0, &succeeded, NULL);
-    if (!succeeded && error=
)
-    {
-        *error =3D true;
-    }
-    return ret;
-}
-
 /**
  * Re=
turns newly allocated string containing address part without "/nn"=2E
  *
@=
@ -1097,13 +1078,6 @@
     }
     return ret;
 }
-
-static bool
-ipv6_addr_=
safe_hexplusbits(const char *ipv6_prefix_spec)
-{
-    return get_ipv6_addr=
(ipv6_prefix_spec, NULL, NULL, M_WARN);
-}
-
 /**
  * Parses a hexstring an=
d checks if the string has the correct length=2E Return
  * a verify_hash_l=
ist containing the parsed hash string=2E
@@ -3337,7 +3311,7 @@
     options=
_postprocess_verify(options);
 #ifndef ENABLE_SMALL
     options_postproces=
s_filechecks(options);
-#endif /* !ENABLE_SMALL */
+#endif
 }
 
 /*
diff --=
git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index c23d0b3=2E=2E=
2b68a0e 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
=
@@ -723,8 +723,6 @@
     unsigned int imported_protocol_flags;
 };
 
-#defi=
ne streq(x, y) (!strcmp((x), (y)))
-
 /*
  * Option classes=2E
  */
diff --=
git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index 80dec6c=2E=2E33ff72=
b 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -31,6 +31=
,7 @@
 #include "error=2Eh"
 #include "socket_util=2Eh"
 #include "otime=2E=
h"
+#include "resolve=2Eh"
 
 #include "memdbg=2Eh"
 
diff --git a/src/open=
vpn/ps=2Ec b/src/openvpn/ps=2Ec
index 0e581e5=2E=2E5b705ee 100644
--- a/src=
/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -32,6 +32,7 @@
 #include "socke=
t=2Eh"
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
+#include "resolve=2Eh=
"
 #include "ps=2Eh"
 
 #include "memdbg=2Eh"
diff --git a/src/openvpn/push=
=2Ec b/src/openvpn/push=2Ec
index c2c1914=2E=2E3005a2d 100644
--- a/src/ope=
nvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -37,6 +37,7 @@
 #include "memdb=
g=2Eh"
 #include "ssl_util=2Eh"
 #include "options_util=2Eh"
+#include "res=
olve=2Eh"
 
 /*
  * Auth username/password
diff --git a/src/openvpn/resolve=
=2Ec b/src/openvpn/resolve=2Ec
new file mode 100644
index 0000000=2E=2Eb8d9=
899
--- /dev/null
+++ b/src/openvpn/resolve=2Ec
@@ -0,0 +1,665 @@
+/*
+ *  =
OpenVPN -- An application to securely tunnel IP networks
+ *             ov=
er a single TCP/UDP port, with support for SSL/TLS-based
+ *             se=
ssion authentication and key exchange,
+ *             packet encryption, p=
acket authentication, and
+ *             packet compression=2E
+ *
+ *  Co=
pyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This progr=
am is free software; you can redistribute it and/or modify
+ *  it under th=
e terms of the GNU General Public License version 2
+ *  as published by th=
e Free Software Foundation=2E
+ *
+ *  This program is distributed in the h=
ope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the=
 implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ * =
 You should have received a copy of the GNU General Public License along
+ =
*  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ =
*/
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "sysh=
ead=2Eh"
+
+#include "buffer=2Eh"
+#include "crypto=2Eh"
+#include "manage=
=2Eh"
+#include "openvpn=2Eh"
+#include "socket=2Eh"
+#include "socket_util=
=2Eh"
+
+#include "resolve=2Eh"
+
+/*
+ * Convert sockflags/getaddr_flags i=
nto getaddr_flags
+ */
+unsigned int
+sf2gaf(const unsigned int getaddr_fla=
gs, const unsigned int sockflags)
+{
+    if (sockflags & SF_HOST_RANDOMIZE=
)
+    {
+        return getaddr_flags | GETADDR_RANDOMIZE;
+    }
+    els=
e
+    {
+        return getaddr_flags;
+    }
+}
+
+/*
+ * Functions relat=
ed to the translation of DNS names to IP addresses=2E
+ */
+
+/**
+ * Small=
 helper function for openvpn_getaddrinfo to print the address
+ * family wh=
en resolving fails
+ */
+static const char *
+getaddrinfo_addr_family_name(=
int af)
+{
+    switch (af)
+    {
+        case AF_INET:
+            retu=
rn "[AF_INET]";
+
+        case AF_INET6:
+            return "[AF_INET6]";=

+    }
+    return "";
+}
+
+/*
+ * Prepend a random string to hostname to=
 prevent DNS caching=2E
+ * For example, foo=2Ebar=2Egov would be modified =
to <random-chars>=2Efoo=2Ebar=2Egov=2E
+ * Of course, this requires explici=
t support in the DNS server (wildcard)=2E
+ */
+static const char *
+hostna=
me_randomize(const char *hostname, struct gc_arena *gc)
+{
+#define n_rnd_b=
ytes 6
+
+    uint8_t rnd_bytes[n_rnd_bytes];
+    const char *rnd_str;
+  =
  struct buffer hname =3D alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes)=
 * 2 + 4, gc);
+
+    prng_bytes(rnd_bytes, sizeof(rnd_bytes));
+    rnd_st=
r =3D format_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);
+    bu=
f_printf(&hname, "%s=2E%s", rnd_str, hostname);
+    return BSTR(&hname);
+=
#undef n_rnd_bytes
+}
+
+/*
+ * Translate IPv4/IPv6 addr or hostname into s=
truct addrinfo
+ * If resolve error, try again for resolve_retry_seconds se=
conds=2E
+ */
+int
+openvpn_getaddrinfo(unsigned int flags, const char *hos=
tname, const char *servname,
+                    int resolve_retry_seconds=
, struct signal_info *sig_info, int ai_family,
+                    struct =
addrinfo **res)
+{
+    struct addrinfo hints;
+    int status;
+    struct=
 signal_info sigrec =3D { 0 };
+    msglvl_t msglevel =3D (flags & GETADDR_=
FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
+    struct gc_arena gc =3D gc_new();
=
+    const char *print_hostname;
+    const char *print_servname;
+
+    AS=
SERT(res);
+
+    ASSERT(hostname || servname);
+    ASSERT(!(flags & GETAD=
DR_HOST_ORDER));
+
+    if (servname)
+    {
+        print_servname =3D se=
rvname;
+    }
+    else
+    {
+        print_servname =3D "";
+    }
+
+ =
   if (flags & GETADDR_MSG_VIRT_OUT)
+    {
+        msglevel |=3D M_MSG_VI=
RT_OUT;
+    }
+
+    if ((flags & (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_=
ON_SIGNAL)) && !sig_info)
+    {
+        sig_info =3D &sigrec;
+    }
+
+ =
   /* try numeric ip addr first */
+    CLEAR(hints);
+    hints=2Eai_flags=
 =3D AI_NUMERICHOST;
+
+    if (flags & GETADDR_PASSIVE)
+    {
+        hi=
nts=2Eai_flags |=3D AI_PASSIVE;
+    }
+
+    if (flags & GETADDR_DATAGRAM)=

+    {
+        hints=2Eai_socktype =3D SOCK_DGRAM;
+    }
+    else
+    =
{
+        hints=2Eai_socktype =3D SOCK_STREAM;
+    }
+
+    /* if hostnam=
e is not set, we want to bind to 'ANY', with
+     * the correct address fa=
mily - v4-only or v6/v6-dual-stack */
+    if (!hostname)
+    {
+        h=
ints=2Eai_family =3D ai_family;
+    }
+
+    status =3D getaddrinfo(hostna=
me, servname, &hints, res);
+
+    if (status !=3D 0)                      =
/* parse as numeric address failed? */
+    {
+        const int fail_wait_=
interval =3D 5; /* seconds */
+        /* Add +4 to cause integer division =
rounding up (1 + 4) =3D 5, (0+4)/5=3D0 */
+        int resolve_retries =3D
=
+            (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) =
/ fail_wait_interval);
+        const char *fmt;
+        msglvl_t level =
=3D 0;
+
+        /* this is not a numeric IP, therefore force resolution u=
sing the
+         * provided ai_family */
+        hints=2Eai_family =3D a=
i_family;
+
+        if (hostname && (flags & GETADDR_RANDOMIZE))
+        =
{
+            hostname =3D hostname_randomize(hostname, &gc);
+        }
+=

+        if (hostname)
+        {
+            print_hostname =3D hostname=
;
+        }
+        else
+        {
+            print_hostname =3D "unde=
fined";
+        }
+
+        fmt =3D "RESOLVE: Cannot resolve host address=
: %s:%s%s (%s)";
+        if ((flags & GETADDR_MENTION_RESOLVE_RETRY) && !r=
esolve_retry_seconds)
+        {
+            fmt =3D "RESOLVE: Cannot reso=
lve host address: %s:%s%s (%s)"
+                  "(I would have retried t=
his name query if you had "
+                  "specified the --resolv-retr=
y option=2E)";
+        }
+
+        if (!(flags & GETADDR_RESOLVE) || stat=
us =3D=3D EAI_FAIL)
+        {
+            msg(msglevel, "RESOLVE: Cannot =
parse IP address: %s:%s (%s)", print_hostname,
+                print_servn=
ame, gai_strerror(status));
+            goto done;
+        }
+
+#ifdef EN=
ABLE_MANAGEMENT
+        if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
+    =
    {
+            if (management)
+            {
+                manageme=
nt_set_state(management, OPENVPN_STATE_RESOLVE, NULL, NULL, NULL, NULL,
+  =
                                   NULL);
+            }
+        }
+#endif=

+
+        /*
+         * Resolve hostname
+         */
+        while (tr=
ue)
+        {
+#ifndef _WIN32
+            /* force resolv=2Econf reload *=
/
+            res_init();
+#endif
+            /* try hostname lookup */
+=
            hints=2Eai_flags &=3D ~AI_NUMERICHOST;
+            dmsg(D_SOCK=
ET_DEBUG, "GETADDRINFO flags=3D0x%04x ai_family=3D%d ai_socktype=3D%d", fla=
gs,
+                 hints=2Eai_family, hints=2Eai_socktype);
+           =
 status =3D getaddrinfo(hostname, servname, &hints, res);
+
+            if=
 (sig_info)
+            {
+                get_signal(&sig_info->signal_re=
ceived);
+                if (sig_info->signal_received) /* were we interru=
pted by a signal? */
+                {
+                    /* why are we =
overwriting SIGUSR1 ? */
+                    if (signal_reset(sig_info, SI=
GUSR1) =3D=3D SIGUSR1) /* ignore SIGUSR1 */
+                    {
+       =
                 msg(level, "RESOLVE: Ignored SIGUSR1 signal received durin=
g "
+                                   "DNS resolution attempt");
+       =
             }
+                    else
+                    {
+          =
              /* turn success into failure (interrupted syscall) */
+      =
                  if (0 =3D=3D status)
+                        {
+        =
                    ASSERT(res);
+                            freeaddrinfo(=
*res);
+                            *res =3D NULL;
+                       =
     status =3D EAI_AGAIN; /* =3D temporary failure */
+                   =
         errno =3D EINTR;
+                        }
+                     =
   goto done;
+                    }
+                }
+            }
+
+ =
           /* success? */
+            if (0 =3D=3D status)
+            {
=
+                break;
+            }
+
+            /* resolve lookup fai=
led, should we
+             * continue or fail? */
+            level =3D =
msglevel;
+            if (resolve_retries > 0)
+            {
+           =
     level =3D D_RESOLVE_ERRORS;
+            }
+
+            msg(level, f=
mt, print_hostname, print_servname, getaddrinfo_addr_family_name(ai_family)=
,
+                gai_strerror(status));
+
+            if (--resolve_retr=
ies <=3D 0)
+            {
+                goto done;
+            }
+
+  =
          management_sleep(fail_wait_interval);
+        }
+
+        ASSER=
T(res);
+
+        /* hostname resolve succeeded */
+
+        /*
+        =
 * Do not choose an IP Addresse by random or change the order *
+         *=
 of IP addresses, doing so will break RFC 3484 address selection *
+       =
  */
+    }
+    else
+    {
+        /* IP address parse succeeded */
+   =
     if (flags & GETADDR_RANDOMIZE)
+        {
+            msg(M_WARN, "WA=
RNING: ignoring --remote-random-hostname because the "
+                   =
     "hostname is an IP address");
+        }
+    }
+
+done:
+    if (sig_=
info && sig_info->signal_received)
+    {
+        msglvl_t level =3D 0;
+ =
       if (flags & GETADDR_FATAL_ON_SIGNAL)
+        {
+            level =
=3D M_FATAL;
+        }
+        else if (flags & GETADDR_WARN_ON_SIGNAL)
+=
        {
+            level =3D M_WARN;
+        }
+        msg(level, "RE=
SOLVE: signal received during DNS resolution attempt");
+    }
+
+    gc_fr=
ee(&gc);
+    return status;
+}
+
+static int
+get_addr_generic(sa_family_t=
 af, unsigned int flags, const char *hostname, void *network,
+            =
     unsigned int *netbits, int resolve_retry_seconds, struct signal_info *=
sig_info,
+                 msglvl_t msglevel)
+{
+    char *endp, *sep, *v=
ar_host =3D NULL;
+    struct addrinfo *ai =3D NULL;
+    unsigned long bit=
s;
+    uint8_t max_bits;
+    int ret =3D -1;
+
+    if (!hostname)
+    {=

+        msg(M_NONFATAL, "Can't resolve null hostname!");
+        goto ou=
t;
+    }
+
+    /* assign family specific default values */
+    switch (a=
f)
+    {
+        case AF_INET:
+            bits =3D 0;
+            max_=
bits =3D sizeof(in_addr_t) * 8;
+            break;
+
+        case AF_INET=
6:
+            bits =3D 64;
+            max_bits =3D sizeof(struct in6_ad=
dr) * 8;
+            break;
+
+        default:
+            msg(M_WARN, "=
Unsupported AF family passed to getaddrinfo for %s (%d)", hostname, af);
+ =
           goto out;
+    }
+
+    /* we need to modify the hostname receiv=
ed as input, but we don't want to
+     * touch it directly as it might be =
a constant string=2E
+     *
+     * Therefore, we clone the string here an=
d free it at the end of the
+     * function */
+    var_host =3D strdup(ho=
stname);
+    if (!var_host)
+    {
+        msg(M_NONFATAL | M_ERRNO, "Can=
't allocate hostname buffer for getaddrinfo");
+        goto out;
+    }
+
=
+    /* check if this hostname has a /bits suffix */
+    sep =3D strchr(va=
r_host, '/');
+    if (sep)
+    {
+        bits =3D strtoul(sep + 1, &endp=
, 10);
+        if ((*endp !=3D '\0') || (bits > max_bits))
+        {
+   =
         msg(msglevel, "IP prefix '%s': invalid '/bits' spec (%s)", hostnam=
e, sep + 1);
+            goto out;
+        }
+        *sep =3D '\0';
+   =
 }
+
+    ret =3D openvpn_getaddrinfo(flags & ~GETADDR_HOST_ORDER, var_host=
, NULL, resolve_retry_seconds,
+                              sig_info, af,=
 &ai);
+    if ((ret =3D=3D 0) && network)
+    {
+        struct in6_addr =
*ip6;
+        in_addr_t *ip4;
+
+        if (af !=3D ai->ai_family)
+     =
   {
+            msg(msglevel, "Can't parse %s as IPv%d address", var_host=
, (af =3D=3D AF_INET) ? 4 : 6);
+            ret =3D -1;
+            goto =
out;
+        }
+
+        switch (af)
+        {
+            case AF_INET=
:
+                ip4 =3D network;
+                *ip4 =3D ((struct sock=
addr_in *)ai->ai_addr)->sin_addr=2Es_addr;
+
+                if (flags & G=
ETADDR_HOST_ORDER)
+                {
+                    *ip4 =3D ntohl(*=
ip4);
+                }
+                break;
+
+            case AF_INE=
T6:
+                ip6 =3D network;
+                *ip6 =3D ((struct so=
ckaddr_in6 *)ai->ai_addr)->sin6_addr;
+                break;
+
+          =
  default:
+                /* can't get here because 'af' was previously c=
hecked */
+                msg(M_WARN, "Unsupported AF family for %s (%d)",=
 var_host, af);
+                goto out;
+        }
+    }
+
+    if (net=
bits)
+    {
+        *netbits =3D (unsigned int)bits;
+    }
+
+    /* res=
tore '/' separator, if any */
+    if (sep)
+    {
+        *sep =3D '/';
+=
    }
+out:
+    if (ai)
+    {
+        freeaddrinfo(ai);
+    }
+    free=
(var_host);
+
+    return ret;
+}
+
+in_addr_t
+getaddr(unsigned int flags,=
 const char *hostname, int resolve_retry_seconds, bool *succeeded,
+       =
 struct signal_info *sig_info)
+{
+    in_addr_t addr =3D { 0 };
+    int s=
tatus;
+
+    status =3D get_addr_generic(AF_INET, flags, hostname, &addr, =
NULL, resolve_retry_seconds,
+                              sig_info, M_WAR=
N);
+    if (status =3D=3D 0)
+    {
+        if (succeeded)
+        {
+  =
          *succeeded =3D true;
+        }
+        return addr;
+    }
+   =
 else
+    {
+        if (succeeded)
+        {
+            *succeeded =3D=
 false;
+        }
+        return 0;
+    }
+}
+
+in_addr_t
+get_ip_addr(c=
onst char *ip_string, msglvl_t msglevel, bool *error)
+{
+    unsigned int =
flags =3D GETADDR_HOST_ORDER;
+    bool succeeded =3D false;
+    in_addr_t=
 ret;
+
+    if (msglevel & M_FATAL)
+    {
+        flags |=3D GETADDR_FAT=
AL;
+    }
+
+    ret =3D getaddr(flags, ip_string, 0, &succeeded, NULL);
+=
    if (!succeeded && error)
+    {
+        *error =3D true;
+    }
+    r=
eturn ret;
+}
+
+bool
+get_ipv6_addr(const char *hostname, struct in6_addr =
*network, unsigned int *netbits,
+              msglvl_t msglevel)
+{
+    =
if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, netbits,=
 0, NULL, msglevel)
+        < 0)
+    {
+        return false;
+    }
+
+ =
   return true; /* parsing OK, values set */
+}
+
+/*
+ * get_cached_dns_en=
try return 0 on success and -1
+ * otherwise=2E (like getaddrinfo)
+ */
+in=
t
+get_cached_dns_entry(struct cached_dns_entry *dns_cache, const char *hos=
tname, const char *servname,
+                     int ai_family, unsigned =
int resolve_flags, struct addrinfo **ai)
+{
+    struct cached_dns_entry *p=
h;
+    unsigned int flags;
+
+    /* Only use flags that are relevant for =
the structure */
+    flags =3D resolve_flags & GETADDR_CACHE_MASK;
+
+    =
for (ph =3D dns_cache; ph; ph =3D ph->next)
+    {
+        if (streqnull(p=
h->hostname, hostname) && streqnull(ph->servname, servname)
+            &&=
 ph->ai_family =3D=3D ai_family && ph->flags =3D=3D flags)
+        {
+    =
        *ai =3D ph->ai;
+            return 0;
+        }
+    }
+    retur=
n -1;
+}
+
+
+static int
+do_preresolve_host(struct context *c, const char =
*hostname, const char *servname, const int af,
+                   const un=
signed int flags)
+{
+    struct addrinfo *ai;
+    int status;
+
+    if (=
get_cached_dns_entry(c->c1=2Edns_cache, hostname, servname, af, flags, &ai)=
 =3D=3D 0)
+    {
+        /* entry already cached, return success */
+    =
    return 0;
+    }
+
+    status =3D openvpn_getaddrinfo(flags, hostname,=
 servname, c->options=2Eresolve_retry_seconds, NULL,
+                     =
            af, &ai);
+    if (status =3D=3D 0)
+    {
+        struct cach=
ed_dns_entry *ph;
+
+        ALLOC_OBJ_CLEAR_GC(ph, struct cached_dns_entry=
, &c->gc);
+        ph->ai =3D ai;
+        ph->hostname =3D hostname;
+   =
     ph->servname =3D servname;
+        ph->flags =3D flags & GETADDR_CACH=
E_MASK;
+
+        if (!c->c1=2Edns_cache)
+        {
+            c->c1=2E=
dns_cache =3D ph;
+        }
+        else
+        {
+            struct c=
ached_dns_entry *prev =3D c->c1=2Edns_cache;
+            while (prev->next=
)
+            {
+                prev =3D prev->next;
+            }
+    =
        prev->next =3D ph;
+        }
+
+        gc_addspecial(ai, &gc_free=
addrinfo_callback, &c->gc);
+    }
+    return status;
+}
+
+void
+do_prere=
solve(struct context *c)
+{
+    struct connection_list *l =3D c->options=
=2Econnection_list;
+    const unsigned int preresolve_flags =3D GETADDR_RE=
SOLVE | GETADDR_UPDATE_MANAGEMENT_STATE
+                                  =
        | GETADDR_MENTION_RESOLVE_RETRY | GETADDR_FATAL;
+
+
+    for (int =
i =3D 0; i < l->len; ++i)
+    {
+        int status;
+        const char *=
remote;
+        unsigned int flags =3D preresolve_flags;
+
+        struct=
 connection_entry *ce =3D l->array[i];
+
+        if (proto_is_dgram(ce->pr=
oto))
+        {
+            flags |=3D GETADDR_DATAGRAM;
+        }
+
+  =
      if (c->options=2Esockflags & SF_HOST_RANDOMIZE)
+        {
+         =
   flags |=3D GETADDR_RANDOMIZE;
+        }
+
+        if (c->options=2Eip_=
remote_hint)
+        {
+            remote =3D c->options=2Eip_remote_hint=
;
+        }
+        else
+        {
+            remote =3D ce->remote;
+=
        }
+
+        /* HTTP remote hostname does not need to be resolved *=
/
+        if (!ce->http_proxy_options)
+        {
+            status =3D =
do_preresolve_host(c, remote, ce->remote_port, ce->af, flags);
+           =
 if (status !=3D 0)
+            {
+                goto err;
+            =
}
+        }
+
+        /* Preresolve proxy */
+        if (ce->http_proxy_=
options)
+        {
+            status =3D do_preresolve_host(c, ce->http_=
proxy_options->server,
+                                        ce->http_pr=
oxy_options->port, ce->af, preresolve_flags);
+
+            if (status !=
=3D 0)
+            {
+                goto err;
+            }
+        }
=
+
+        if (ce->socks_proxy_server)
+        {
+            status =3D
+=
                do_preresolve_host(c, ce->socks_proxy_server, ce->socks_pro=
xy_port, ce->af, flags);
+            if (status !=3D 0)
+            {
+  =
              goto err;
+            }
+        }
+
+        if (ce->bind_l=
ocal)
+        {
+            flags |=3D GETADDR_PASSIVE;
+            flag=
s &=3D ~GETADDR_RANDOMIZE;
+
+            for (int j =3D 0; j < ce->local_l=
ist->len; j++)
+            {
+                const struct local_entry *le=
 =3D ce->local_list->array[j];
+
+                if (!le->local)
+        =
        {
+                    continue;
+                }
+
+            =
    status =3D do_preresolve_host(c, le->local, le->port, ce->af, flags);
+=
                if (status !=3D 0)
+                {
+                    =
goto err;
+                }
+            }
+        }
+    }
+    return;
=
+
+err:
+    throw_signal_soft(SIGHUP, "Preresolving failed");
+}
diff --gi=
t a/src/openvpn/resolve=2Eh b/src/openvpn/resolve=2Eh
new file mode 100644
=
index 0000000=2E=2E9069af7
--- /dev/null
+++ b/src/openvpn/resolve=2Eh
@@ -=
0,0 +1,106 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP netw=
orks
+ *             over a single TCP/UDP port, with support for SSL/TLS-b=
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
+/**
+ * @file
+ * DNS resolution
+ */
+#ifndef=
 RESOLVE_H
+#define RESOLVE_H
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh=
"
+#endif
+
+#include "syshead=2Eh"
+
+#include "sig=2Eh"
+
+#define GETADD=
R_RESOLVE                 (1u << 0)
+#define GETADDR_FATAL                 =
  (1u << 1)
+#define GETADDR_HOST_ORDER              (1u << 2)
+#define GET=
ADDR_MENTION_RESOLVE_RETRY   (1u << 3)
+#define GETADDR_FATAL_ON_SIGNAL    =
     (1u << 4)
+#define GETADDR_WARN_ON_SIGNAL          (1u << 5)
+#define =
GETADDR_MSG_VIRT_OUT            (1u << 6)
+#define GETADDR_TRY_ONCE        =
        (1u << 7)
+#define GETADDR_UPDATE_MANAGEMENT_STATE (1u << 8)
+#defi=
ne GETADDR_RANDOMIZE               (1u << 9)
+#define GETADDR_PASSIVE      =
           (1u << 10)
+#define GETADDR_DATAGRAM                (1u << 11)
+=

+#define GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)
+
+/**
+ =
* Convert sockflags/getaddr_flags into getaddr_flags
+ */
+unsigned int sf2=
gaf(const unsigned int getaddr_flags, const unsigned int sockflags);
+
+/**=

+ * Translate an IPv4 addr or hostname from string form to in_addr_t
+ *
+=
 * In case of resolve error, it will try again for
+ * resolve_retry_second=
s seconds=2E
+ */
+in_addr_t getaddr(unsigned int flags, const char *hostna=
me, int resolve_retry_seconds,
+                  bool *succeeded, struct s=
ignal_info *sig_info);
+
+in_addr_t get_ip_addr(const char *ip_string, msgl=
vl_t msglevel, bool *error);
+
+/**
+ * Translate an IPv6 addr or hostname =
from string form to in6_addr
+ */
+bool get_ipv6_addr(const char *hostname,=
 struct in6_addr *network, unsigned int *netbits,
+                   msglv=
l_t msglevel);
+
+static inline bool
+ipv6_addr_safe_hexplusbits(const char=
 *ipv6_prefix_spec)
+{
+    return get_ipv6_addr(ipv6_prefix_spec, NULL, NU=
LL, M_WARN);
+}
+
+int openvpn_getaddrinfo(unsigned int flags, const char *=
hostname, const char *servname,
+                        int resolve_retry_=
seconds, struct signal_info *sig_info, int ai_family,
+                    =
    struct addrinfo **res);
+
+void do_preresolve(struct context *c);
+
+/*=
 struct to hold preresolved host names */
+struct cached_dns_entry
+{
+    =
const char *hostname;
+    const char *servname;
+    int ai_family;
+    u=
nsigned int flags;
+    struct addrinfo *ai;
+    struct cached_dns_entry *=
next;
+};
+
+/**
+ * get_cached_dns_entry return 0 on success and -1
+ * ot=
herwise=2E (like getaddrinfo())
+ */
+int get_cached_dns_entry(struct cache=
d_dns_entry *dns_cache, const char *hostname,
+                         con=
st char *servname, int ai_family,
+                         unsigned int re=
solve_flags, struct addrinfo **ai);
+
+#endif /* RESOLVE_H */
diff --git a/=
src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 078bb7e=2E=2E5d70472 10=
0644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -42,6 +42,7=
 @@
 #include "options=2Eh"
 #include "networking=2Eh"
 #include "integer=
=2Eh"
+#include "resolve=2Eh"
 
 #include "memdbg=2Eh"
 
diff --git a/src/o=
penvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 6684350=2E=2E663a2b4 10064=
4
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -38,6 +38,7 =
@@
 #include "manage=2Eh"
 #include "openvpn=2Eh"
 #include "forward=2Eh"
+=
#include "resolve=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -54,366 +55,6 @@
     =
return false;
 }
 
-/*
- * Convert sockflags/getaddr_flags into getaddr_fla=
gs
- */
-static unsigned int
-sf2gaf(const unsigned int getaddr_flags, cons=
t unsigned int sockflags)
-{
-    if (sockflags & SF_HOST_RANDOMIZE)
-    {=

-        return getaddr_flags | GETADDR_RANDOMIZE;
-    }
-    else
-    {=

-        return getaddr_flags;
-    }
-}
-
-/*
- * Functions related to th=
e translation of DNS names to IP addresses=2E
- */
-static int
-get_addr_ge=
neric(sa_family_t af, unsigned int flags, const char *hostname, void *netwo=
rk,
-                 unsigned int *netbits, int resolve_retry_seconds, str=
uct signal_info *sig_info,
-                 msglvl_t msglevel)
-{
-    cha=
r *endp, *sep, *var_host =3D NULL;
-    struct addrinfo *ai =3D NULL;
-    =
unsigned long bits;
-    uint8_t max_bits;
-    int ret =3D -1;
-
-    if (=
!hostname)
-    {
-        msg(M_NONFATAL, "Can't resolve null hostname!");=

-        goto out;
-    }
-
-    /* assign family specific default values =
*/
-    switch (af)
-    {
-        case AF_INET:
-            bits =3D 0;
=
-            max_bits =3D sizeof(in_addr_t) * 8;
-            break;
-
-   =
     case AF_INET6:
-            bits =3D 64;
-            max_bits =3D siz=
eof(struct in6_addr) * 8;
-            break;
-
-        default:
-        =
    msg(M_WARN, "Unsupported AF family passed to getaddrinfo for %s (%d)", =
hostname, af);
-            goto out;
-    }
-
-    /* we need to modify th=
e hostname received as input, but we don't want to
-     * touch it directl=
y as it might be a constant string=2E
-     *
-     * Therefore, we clone t=
he string here and free it at the end of the
-     * function */
-    var_h=
ost =3D strdup(hostname);
-    if (!var_host)
-    {
-        msg(M_NONFATA=
L | M_ERRNO, "Can't allocate hostname buffer for getaddrinfo");
-        go=
to out;
-    }
-
-    /* check if this hostname has a /bits suffix */
-    =
sep =3D strchr(var_host, '/');
-    if (sep)
-    {
-        bits =3D strto=
ul(sep + 1, &endp, 10);
-        if ((*endp !=3D '\0') || (bits > max_bits)=
)
-        {
-            msg(msglevel, "IP prefix '%s': invalid '/bits' sp=
ec (%s)", hostname, sep + 1);
-            goto out;
-        }
-        *s=
ep =3D '\0';
-    }
-
-    ret =3D openvpn_getaddrinfo(flags & ~GETADDR_HOS=
T_ORDER, var_host, NULL, resolve_retry_seconds,
-                          =
    sig_info, af, &ai);
-    if ((ret =3D=3D 0) && network)
-    {
-       =
 struct in6_addr *ip6;
-        in_addr_t *ip4;
-
-        if (af !=3D ai->=
ai_family)
-        {
-            msg(msglevel, "Can't parse %s as IPv%d a=
ddress", var_host, (af =3D=3D AF_INET) ? 4 : 6);
-            ret =3D -1;
-=
            goto out;
-        }
-
-        switch (af)
-        {
-       =
     case AF_INET:
-                ip4 =3D network;
-                *ip4 =
=3D ((struct sockaddr_in *)ai->ai_addr)->sin_addr=2Es_addr;
-
-            =
    if (flags & GETADDR_HOST_ORDER)
-                {
-                   =
 *ip4 =3D ntohl(*ip4);
-                }
-                break;
-
-      =
      case AF_INET6:
-                ip6 =3D network;
-                *ip=
6 =3D ((struct sockaddr_in6 *)ai->ai_addr)->sin6_addr;
-                bre=
ak;
-
-            default:
-                /* can't get here because 'af'=
 was previously checked */
-                msg(M_WARN, "Unsupported AF fam=
ily for %s (%d)", var_host, af);
-                goto out;
-        }
-   =
 }
-
-    if (netbits)
-    {
-        *netbits =3D (unsigned int)bits;
-  =
  }
-
-    /* restore '/' separator, if any */
-    if (sep)
-    {
-      =
  *sep =3D '/';
-    }
-out:
-    if (ai)
-    {
-        freeaddrinfo(ai);=

-    }
-    free(var_host);
-
-    return ret;
-}
-
-in_addr_t
-getaddr(un=
signed int flags, const char *hostname, int resolve_retry_seconds, bool *su=
cceeded,
-        struct signal_info *sig_info)
-{
-    in_addr_t addr =3D =
{ 0 };
-    int status;
-
-    status =3D get_addr_generic(AF_INET, flags, =
hostname, &addr, NULL, resolve_retry_seconds,
-                            =
  sig_info, M_WARN);
-    if (status =3D=3D 0)
-    {
-        if (succeede=
d)
-        {
-            *succeeded =3D true;
-        }
-        return =
addr;
-    }
-    else
-    {
-        if (succeeded)
-        {
-         =
   *succeeded =3D false;
-        }
-        return 0;
-    }
-}
-
-bool
-g=
et_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int *=
netbits,
-              msglvl_t msglevel)
-{
-    if (get_addr_generic(AF_=
INET6, GETADDR_RESOLVE, hostname, network, netbits, 0, NULL, msglevel)
-   =
     < 0)
-    {
-        return false;
-    }
-
-    return true; /* parsi=
ng OK, values set */
-}
-
-static inline bool
-streqnull(const char *a, con=
st char *b)
-{
-    if (a =3D=3D NULL && b =3D=3D NULL)
-    {
-        ret=
urn true;
-    }
-    else if (a =3D=3D NULL || b =3D=3D NULL)
-    {
-    =
    return false;
-    }
-    else
-    {
-        return streq(a, b);
-   =
 }
-}
-
-/*
- * get_cached_dns_entry return 0 on success and -1
- * otherwi=
se=2E (like getaddrinfo)
- */
-static int
-get_cached_dns_entry(struct cach=
ed_dns_entry *dns_cache, const char *hostname, const char *servname,
-     =
                int ai_family, unsigned int resolve_flags, struct addrinfo =
**ai)
-{
-    struct cached_dns_entry *ph;
-    unsigned int flags;
-
-    =
/* Only use flags that are relevant for the structure */
-    flags =3D res=
olve_flags & GETADDR_CACHE_MASK;
-
-    for (ph =3D dns_cache; ph; ph =3D p=
h->next)
-    {
-        if (streqnull(ph->hostname, hostname) && streqnull=
(ph->servname, servname)
-            && ph->ai_family =3D=3D ai_family && =
ph->flags =3D=3D flags)
-        {
-            *ai =3D ph->ai;
-          =
  return 0;
-        }
-    }
-    return -1;
-}
-
-
-static int
-do_preres=
olve_host(struct context *c, const char *hostname, const char *servname, co=
nst int af,
-                   const unsigned int flags)
-{
-    struct ad=
drinfo *ai;
-    int status;
-
-    if (get_cached_dns_entry(c->c1=2Edns_ca=
che, hostname, servname, af, flags, &ai) =3D=3D 0)
-    {
-        /* entry=
 already cached, return success */
-        return 0;
-    }
-
-    status =
=3D openvpn_getaddrinfo(flags, hostname, servname, c->options=2Eresolve_ret=
ry_seconds, NULL,
-                                 af, &ai);
-    if (stat=
us =3D=3D 0)
-    {
-        struct cached_dns_entry *ph;
-
-        ALLOC_=
OBJ_CLEAR_GC(ph, struct cached_dns_entry, &c->gc);
-        ph->ai =3D ai;
=
-        ph->hostname =3D hostname;
-        ph->servname =3D servname;
-  =
      ph->flags =3D flags & GETADDR_CACHE_MASK;
-
-        if (!c->c1=2Edns=
_cache)
-        {
-            c->c1=2Edns_cache =3D ph;
-        }
-     =
   else
-        {
-            struct cached_dns_entry *prev =3D c->c1=2Ed=
ns_cache;
-            while (prev->next)
-            {
-                p=
rev =3D prev->next;
-            }
-            prev->next =3D ph;
-       =
 }
-
-        gc_addspecial(ai, &gc_freeaddrinfo_callback, &c->gc);
-    }
=
-    return status;
-}
-
-void
-do_preresolve(struct context *c)
-{
-    st=
ruct connection_list *l =3D c->options=2Econnection_list;
-    const unsign=
ed int preresolve_flags =3D GETADDR_RESOLVE | GETADDR_UPDATE_MANAGEMENT_STA=
TE
-                                          | GETADDR_MENTION_RESOLVE_RET=
RY | GETADDR_FATAL;
-
-
-    for (int i =3D 0; i < l->len; ++i)
-    {
-   =
     int status;
-        const char *remote;
-        unsigned int flags =
=3D preresolve_flags;
-
-        struct connection_entry *ce =3D l->array[i=
];
-
-        if (proto_is_dgram(ce->proto))
-        {
-            flags =
|=3D GETADDR_DATAGRAM;
-        }
-
-        if (c->options=2Esockflags & S=
F_HOST_RANDOMIZE)
-        {
-            flags |=3D GETADDR_RANDOMIZE;
-  =
      }
-
-        if (c->options=2Eip_remote_hint)
-        {
-           =
 remote =3D c->options=2Eip_remote_hint;
-        }
-        else
-        =
{
-            remote =3D ce->remote;
-        }
-
-        /* HTTP remote =
hostname does not need to be resolved */
-        if (!ce->http_proxy_optio=
ns)
-        {
-            status =3D do_preresolve_host(c, remote, ce->re=
mote_port, ce->af, flags);
-            if (status !=3D 0)
-            {
-=
                goto err;
-            }
-        }
-
-        /* Preresolv=
e proxy */
-        if (ce->http_proxy_options)
-        {
-            sta=
tus =3D do_preresolve_host(c, ce->http_proxy_options->server,
-            =
                            ce->http_proxy_options->port, ce->af, preresolv=
e_flags);
-
-            if (status !=3D 0)
-            {
-               =
 goto err;
-            }
-        }
-
-        if (ce->socks_proxy_server)=

-        {
-            status =3D
-                do_preresolve_host(c, =
ce->socks_proxy_server, ce->socks_proxy_port, ce->af, flags);
-            =
if (status !=3D 0)
-            {
-                goto err;
-            }=

-        }
-
-        if (ce->bind_local)
-        {
-            flags |=
=3D GETADDR_PASSIVE;
-            flags &=3D ~GETADDR_RANDOMIZE;
-
-       =
     for (int j =3D 0; j < ce->local_list->len; j++)
-            {
-      =
          const struct local_entry *le =3D ce->local_list->array[j];
-
-   =
             if (!le->local)
-                {
-                    contin=
ue;
-                }
-
-                status =3D do_preresolve_host(c, =
le->local, le->port, ce->af, flags);
-                if (status !=3D 0)
- =
               {
-                    goto err;
-                }
-       =
     }
-        }
-    }
-    return;
-
-err:
-    throw_signal_soft(SIGHUP=
, "Preresolving failed");
-}
-
 static int
 socket_get_sndbuf(socket_descri=
ptor_t sd)
 {
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
=
index c6bcd86=2E=2Ee8335d3 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/op=
envpn/socket=2Eh
@@ -62,17 +62,6 @@
 /* convert a packet_size_type from net=
work to host order */
 #define ntohps(x) ntohs(x)
 
-/* struct to hold prer=
esolved host names */
-struct cached_dns_entry
-{
-    const char *hostname=
;
-    const char *servname;
-    int ai_family;
-    unsigned int flags;
-=
    struct addrinfo *ai;
-    struct cached_dns_entry *next;
-};
-
 /* IP a=
ddresses which are persistent across SIGUSR1s */
 struct link_socket_addr
 =
{
@@ -362,8 +351,6 @@
 
 void link_socket_init_phase2(struct context *c, st=
ruct link_socket *sock);
 
-void do_preresolve(struct context *c);
-
 void =
link_socket_close(struct link_socket *sock);
 
 #ifdef ENABLE_MANAGEMENT
di=
ff --git a/src/openvpn/socket_util=2Ec b/src/openvpn/socket_util=2Ec
index =
0194f38=2E=2E5d405ac 100644
--- a/src/openvpn/socket_util=2Ec
+++ b/src/ope=
nvpn/socket_util=2Ec
@@ -490,271 +490,6 @@
     return ""; /* Make the comp=
iler happy */
 }
 
-/**
- * Small helper function for openvpn_getaddrinfo t=
o print the address
- * family when resolving fails
- */
-static const char=
 *
-getaddrinfo_addr_family_name(int af)
-{
-    switch (af)
-    {
-      =
  case AF_INET:
-            return "[AF_INET]";
-
-        case AF_INET6:
=
-            return "[AF_INET6]";
-    }
-    return "";
-}
-
-/*
- * Prepe=
nd a random string to hostname to prevent DNS caching=2E
- * For example, f=
oo=2Ebar=2Egov would be modified to <random-chars>=2Efoo=2Ebar=2Egov=2E
- *=
 Of course, this requires explicit support in the DNS server (wildcard)=2E
=
- */
-static const char *
-hostname_randomize(const char *hostname, struct =
gc_arena *gc)
-{
-#define n_rnd_bytes 6
-
-    uint8_t rnd_bytes[n_rnd_byte=
s];
-    const char *rnd_str;
-    struct buffer hname =3D alloc_buf_gc(str=
len(hostname) + sizeof(rnd_bytes) * 2 + 4, gc);
-
-    prng_bytes(rnd_bytes=
, sizeof(rnd_bytes));
-    rnd_str =3D format_hex_ex(rnd_bytes, sizeof(rnd_=
bytes), 40, 0, NULL, gc);
-    buf_printf(&hname, "%s=2E%s", rnd_str, hostn=
ame);
-    return BSTR(&hname);
-#undef n_rnd_bytes
-}
-
-/*
- * Translate =
IPv4/IPv6 addr or hostname into struct addrinfo
- * If resolve error, try a=
gain for resolve_retry_seconds seconds=2E
- */
-int
-openvpn_getaddrinfo(un=
signed int flags, const char *hostname, const char *servname,
-            =
        int resolve_retry_seconds, struct signal_info *sig_info, int ai_fam=
ily,
-                    struct addrinfo **res)
-{
-    struct addrinfo hi=
nts;
-    int status;
-    struct signal_info sigrec =3D { 0 };
-    msglvl=
_t msglevel =3D (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
-    =
struct gc_arena gc =3D gc_new();
-    const char *print_hostname;
-    cons=
t char *print_servname;
-
-    ASSERT(res);
-
-    ASSERT(hostname || servn=
ame);
-    ASSERT(!(flags & GETADDR_HOST_ORDER));
-
-    if (servname)
-   =
 {
-        print_servname =3D servname;
-    }
-    else
-    {
-        p=
rint_servname =3D "";
-    }
-
-    if (flags & GETADDR_MSG_VIRT_OUT)
-    =
{
-        msglevel |=3D M_MSG_VIRT_OUT;
-    }
-
-    if ((flags & (GETADD=
R_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) && !sig_info)
-    {
-        =
sig_info =3D &sigrec;
-    }
-
-    /* try numeric ip addr first */
-    CL=
EAR(hints);
-    hints=2Eai_flags =3D AI_NUMERICHOST;
-
-    if (flags & GE=
TADDR_PASSIVE)
-    {
-        hints=2Eai_flags |=3D AI_PASSIVE;
-    }
-
-=
    if (flags & GETADDR_DATAGRAM)
-    {
-        hints=2Eai_socktype =3D S=
OCK_DGRAM;
-    }
-    else
-    {
-        hints=2Eai_socktype =3D SOCK_ST=
REAM;
-    }
-
-    /* if hostname is not set, we want to bind to 'ANY', wi=
th
-     * the correct address family - v4-only or v6/v6-dual-stack */
-   =
 if (!hostname)
-    {
-        hints=2Eai_family =3D ai_family;
-    }
-
-=
    status =3D getaddrinfo(hostname, servname, &hints, res);
-
-    if (sta=
tus !=3D 0)                      /* parse as numeric address failed? */
-  =
  {
-        const int fail_wait_interval =3D 5; /* seconds */
-        /* =
Add +4 to cause integer division rounding up (1 + 4) =3D 5, (0+4)/5=3D0 */
=
-        int resolve_retries =3D
-            (flags & GETADDR_TRY_ONCE) ? =
1 : ((resolve_retry_seconds + 4) / fail_wait_interval);
-        const char=
 *fmt;
-        msglvl_t level =3D 0;
-
-        /* this is not a numeric I=
P, therefore force resolution using the
-         * provided ai_family */
-=
        hints=2Eai_family =3D ai_family;
-
-        if (hostname && (flags =
& GETADDR_RANDOMIZE))
-        {
-            hostname =3D hostname_randomi=
ze(hostname, &gc);
-        }
-
-        if (hostname)
-        {
-        =
    print_hostname =3D hostname;
-        }
-        else
-        {
-     =
       print_hostname =3D "undefined";
-        }
-
-        fmt =3D "RESOL=
VE: Cannot resolve host address: %s:%s%s (%s)";
-        if ((flags & GETAD=
DR_MENTION_RESOLVE_RETRY) && !resolve_retry_seconds)
-        {
-          =
  fmt =3D "RESOLVE: Cannot resolve host address: %s:%s%s (%s)"
-           =
       "(I would have retried this name query if you had "
-               =
   "specified the --resolv-retry option=2E)";
-        }
-
-        if (!(f=
lags & GETADDR_RESOLVE) || status =3D=3D EAI_FAIL)
-        {
-            =
msg(msglevel, "RESOLVE: Cannot parse IP address: %s:%s (%s)", print_hostnam=
e,
-                print_servname, gai_strerror(status));
-            got=
o done;
-        }
-
-#ifdef ENABLE_MANAGEMENT
-        if (flags & GETADDR=
_UPDATE_MANAGEMENT_STATE)
-        {
-            if (management)
-        =
    {
-                management_set_state(management, OPENVPN_STATE_RESOL=
VE, NULL, NULL, NULL, NULL,
-                                     NULL);
- =
           }
-        }
-#endif
-
-        /*
-         * Resolve hostname
=
-         */
-        while (true)
-        {
-#ifndef _WIN32
-            =
/* force resolv=2Econf reload */
-            res_init();
-#endif
-        =
    /* try hostname lookup */
-            hints=2Eai_flags &=3D ~AI_NUMERI=
CHOST;
-            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=3D0x%04x ai_fam=
ily=3D%d ai_socktype=3D%d", flags,
-                 hints=2Eai_family, hin=
ts=2Eai_socktype);
-            status =3D getaddrinfo(hostname, servname, =
&hints, res);
-
-            if (sig_info)
-            {
-                =
get_signal(&sig_info->signal_received);
-                if (sig_info->sign=
al_received) /* were we interrupted by a signal? */
-                {
-   =
                 /* why are we overwriting SIGUSR1 ? */
-                  =
  if (signal_reset(sig_info, SIGUSR1) =3D=3D SIGUSR1) /* ignore SIGUSR1 */
=
-                    {
-                        msg(level, "RESOLVE: Ignore=
d SIGUSR1 signal received during "
-                                   "DNS=
 resolution attempt");
-                    }
-                    else
-  =
                  {
-                        /* turn success into failure (=
interrupted syscall) */
-                        if (0 =3D=3D status)
-    =
                    {
-                            ASSERT(res);
-          =
                  freeaddrinfo(*res);
-                            *res =3D=
 NULL;
-                            status =3D EAI_AGAIN; /* =3D temporary =
failure */
-                            errno =3D EINTR;
-                 =
       }
-                        goto done;
-                    }
-      =
          }
-            }
-
-            /* success? */
-            if (0=
 =3D=3D status)
-            {
-                break;
-            }
-
-  =
          /* resolve lookup failed, should we
-             * continue or f=
ail? */
-            level =3D msglevel;
-            if (resolve_retries >=
 0)
-            {
-                level =3D D_RESOLVE_ERRORS;
-          =
  }
-
-            msg(level, fmt, print_hostname, print_servname, getaddri=
nfo_addr_family_name(ai_family),
-                gai_strerror(status));
-
=
-            if (--resolve_retries <=3D 0)
-            {
-                =
goto done;
-            }
-
-            management_sleep(fail_wait_interva=
l);
-        }
-
-        ASSERT(res);
-
-        /* hostname resolve succe=
eded */
-
-        /*
-         * Do not choose an IP Addresse by random or=
 change the order *
-         * of IP addresses, doing so will break RFC 34=
84 address selection *
-         */
-    }
-    else
-    {
-        /* IP =
address parse succeeded */
-        if (flags & GETADDR_RANDOMIZE)
-       =
 {
-            msg(M_WARN, "WARNING: ignoring --remote-random-hostname bec=
ause the "
-                        "hostname is an IP address");
-        =
}
-    }
-
-done:
-    if (sig_info && sig_info->signal_received)
-    {
- =
       msglvl_t level =3D 0;
-        if (flags & GETADDR_FATAL_ON_SIGNAL)
=
-        {
-            level =3D M_FATAL;
-        }
-        else if (fla=
gs & GETADDR_WARN_ON_SIGNAL)
-        {
-            level =3D M_WARN;
-   =
     }
-        msg(level, "RESOLVE: signal received during DNS resolution =
attempt");
-    }
-
-    gc_free(&gc);
-    return status;
-}
-
 /*
  * We =
do our own inet_aton because the glibc function
  * isn't very good about e=
rror checking=2E
diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/soc=
ket_util=2Eh
index add08ba=2E=2Ec0dcfb07 100644
--- a/src/openvpn/socket_ut=
il=2Eh
+++ b/src/openvpn/socket_util=2Eh
@@ -110,43 +110,6 @@
 void setenv_=
link_socket_actual(struct env_set *es, const char *name_prefix,
           =
                     const struct link_socket_actual *act, const unsigned i=
nt flags);
 
-/*
- * DNS resolution
- */
-
-#define GETADDR_RESOLVE        =
         (1u << 0)
-#define GETADDR_FATAL                   (1u << 1)
-#def=
ine GETADDR_HOST_ORDER              (1u << 2)
-#define GETADDR_MENTION_RESO=
LVE_RETRY   (1u << 3)
-#define GETADDR_FATAL_ON_SIGNAL         (1u << 4)
-#=
define GETADDR_WARN_ON_SIGNAL          (1u << 5)
-#define GETADDR_MSG_VIRT_=
OUT            (1u << 6)
-#define GETADDR_TRY_ONCE                (1u << 7)=

-#define GETADDR_UPDATE_MANAGEMENT_STATE (1u << 8)
-#define GETADDR_RANDOM=
IZE               (1u << 9)
-#define GETADDR_PASSIVE                 (1u <<=
 10)
-#define GETADDR_DATAGRAM                (1u << 11)
-
-#define GETADDR=
_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)
-
-/**
- * Translate an IP=
v4 addr or hostname from string form to in_addr_t
- *
- * In case of resolv=
e error, it will try again for
- * resolve_retry_seconds seconds=2E
- */
-i=
n_addr_t getaddr(unsigned int flags, const char *hostname, int resolve_retr=
y_seconds,
-                  bool *succeeded, struct signal_info *sig_info=
);
-
-/**
- * Translate an IPv6 addr or hostname from string form to in6_ad=
dr
- */
-bool get_ipv6_addr(const char *hostname, struct in6_addr *network,=
 unsigned int *netbits,
-                   msglvl_t msglevel);
-
-int open=
vpn_getaddrinfo(unsigned int flags, const char *hostname, const char *servn=
ame,
-                        int resolve_retry_seconds, struct signal_info=
 *sig_info, int ai_family,
-                        struct addrinfo **res);=

 
 /* return values of openvpn_inet_aton */
 #define OIA_HOSTNAME 0
diff -=
-git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index abb46af=2E=2E5bc201d=
 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -39,7 +39,7 =
@@
 #include "fdmisc=2Eh"
 #include "common=2Eh"
 #include "run_command=2Eh=
"
-#include "socket_util=2Eh"
+#include "resolve=2Eh"
 #include "manage=2Eh=
"
 #include "route=2Eh"
 #include "win32=2Eh"

-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f
Gerr=
it-Change-Number: 1846
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--jVMj5OcQvEI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Factor out address resolve code to a new file resolve=2Ec<br><br>The c=
ode was weirdly split between socket=2Ec, socket_util=2Ec,<br>and options=
=2Ec=2E The new structure makes more sense=2E<br><br>While here move some r=
elated string helper code to buffer=2Eh=2E<br><br>Change-Id: I12bef330e2c8a=
5e5b21c2fa807584319b2b7101f<br>Signed-off-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=
=2Eam<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/open=
vpn/clinat=2Ec<br>M src/openvpn/dns=2Ec<br>M src/openvpn/init=2Ec<br>M src/=
openvpn/manage=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2E=
h<br>M src/openvpn/pool=2Ec<br>M src/openvpn/ps=2Ec<br>M src/openvpn/push=
=2Ec<br>A src/openvpn/resolve=2Ec<br>A src/openvpn/resolve=2Eh<br>M src/ope=
nvpn/route=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M=
 src/openvpn/socket_util=2Ec<br>M src/openvpn/socket_util=2Eh<br>M src/open=
vpn/tun=2Ec<br>21 files changed, 815 insertions(+), 707 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/46/1846/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Et=
xt</span><br><span>index 6c66ebd=2E=2E52728f1 100644</span><br><span>--- a/=
CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ =
-565,6 +565,8 @@</span><br><span>     src/openvpn/reflect_filter=2Eh</span>=
<br><span>     src/openvpn/reliable=2Ec</span><br><span>     src/openvpn/re=
liable=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/o=
penvpn/resolve=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   src/openvpn/resolve=2Eh</span><br><span>     src/openvpn/route=2Ec</span=
><br><span>     src/openvpn/route=2Eh</span><br><span>     src/openvpn/run_=
command=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/op=
envpn/Makefile=2Eam</span><br><span>index 182d732=2E=2Ead46ed0 100644</span=
><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvp=
n/Makefile=2Eam</span><br><span>@@ -125,6 +125,7 @@</span><br><span> 	pushl=
ist=2Eh \</span><br><span> 	reflect_filter=2Ec reflect_filter=2Eh \</span><=
br><span> 	reliable=2Ec reliable=2Eh \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	resolve=2Ec resolve=2Eh \</span><br><span> 	route=2Ec r=
oute=2Eh \</span><br><span> 	run_command=2Ec run_command=2Eh \</span><br><s=
pan> 	schedule=2Ec schedule=2Eh \</span><br><span>diff --git a/src/openvpn/=
buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index a004b60=2E=2Eae29=
0ca 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++=
 b/src/openvpn/buffer=2Ec</span><br><span>@@ -1098,6 +1098,23 @@</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+streqnull(const char *a, const char *b)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (a =3D=3D NULL &amp;&amp; b =3D=3D NULL)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (a =3D=3D NULL || b =3D=3D NULL)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return streq(a, b);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> char *</spa=
n><br><span> string_substitute(const char *src, char from, char to, struct =
gc_arena *gc)</span><br><span> {</span><br><span>diff --git a/src/openvpn/b=
uffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index ab8c239=2E=2Efb2cd=
85 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ =
b/src/openvpn/buffer=2Eh</span><br><span>@@ -1766,6 +1766,18 @@</span><br><=
span>     return 0 =3D=3D strncmp(str, prefix, strlen(prefix));</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/** helper to work around the semantics of the strcmp() return value<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if t=
he strings are equal according to strcmp()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define streq(x, y) (!strcmp((x), (y)))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/** compare two strings which might be NULL</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return true if both strings are NULL,=
 or if they are equal according to strcmp()</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool streqnull(const char *a, const char *b);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/** compare two strings which might be NU=
LL, but NULL is never equal</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @return true if neither string is NULL and they are equal accord=
ing to strcmp()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span> bool string_defined_equal(const char *s1, const char *s2);=
</span><br><span> char *string_substitute(const char *src, char from, char =
to, struct gc_arena *gc);</span><br><span> </span><br><span>diff --git a/sr=
c/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec</span><br><span>index b465950=
=2E=2E595566a 100644</span><br><span>--- a/src/openvpn/clinat=2Ec</span><br=
><span>+++ b/src/openvpn/clinat=2Ec</span><br><span>@@ -30,6 +30,7 @@</span=
><br><span> #include &quot;proto=2Eh&quot;</span><br><span> #include &quot;=
socket_util=2Eh&quot;</span><br><span> #include &quot;memdbg=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;resolve=
=2Eh&quot;</span><br><span> </span><br><span> static bool</span><br><span> =
add_entry(struct client_nat_option_list *dest, const struct client_nat_entr=
y *e)</span><br><span>diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2E=
c</span><br><span>index 7f4dde4=2E=2Ea40f3e7 100644</span><br><span>--- a/s=
rc/openvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</span><br><spa=
n>@@ -27,7 +27,7 @@</span><br><span> #include &quot;syshead=2Eh&quot;</span=
><br><span> </span><br><span> #include &quot;dns=2Eh&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#include &quot;socket_util=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;resolv=
e=2Eh&quot;</span><br><span> #include &quot;options=2Eh&quot;</span><br><sp=
an> #include &quot;run_command=2Eh&quot;</span><br><span> #include &quot;do=
main_helper=2Eh&quot;</span><br><span>diff --git a/src/openvpn/init=2Ec b/s=
rc/openvpn/init=2Ec</span><br><span>index 38db7fa=2E=2E223c245 100644</span=
><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/ini=
t=2Ec</span><br><span>@@ -55,6 +55,7 @@</span><br><span> #include &quot;tun=
_afunix=2Eh&quot;</span><br><span> #include &quot;schedule=2Eh&quot;</span>=
<br><span> #include &quot;options_string=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><br><=
span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </=
span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec=
</span><br><span>index 17abfd8=2E=2E857e320 100644</span><br><span>--- a/sr=
c/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br=
><span>@@ -44,6 +44,7 @@</span><br><span> #include &quot;dco=2Eh&quot;</spa=
n><br><span> #include &quot;push=2Eh&quot;</span><br><span> #include &quot;=
multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;resolve=2Eh&quot;</span><br><span> </span><br><span> #include &q=
uot;memdbg=2Eh&quot;</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 74b1f25=2E=
=2E4595266 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><=
span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -64,6 +64,7 @@</span>=
<br><span> #include &quot;domain_helper=2Eh&quot;</span><br><span> #include=
 &quot;mbuf=2Eh&quot;</span><br><span> #include &quot;check_file_access=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;resolve=2Eh&quot;</span><br><span> </span><br><span> #include &lt;ctype=
=2Eh&gt;</span><br><span> </span><br><span>@@ -1055,26 +1056,6 @@</span><br=
><span> </span><br><span> #endif /* ifndef _WIN32 */</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static in_addr_t</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-get_ip_addr(const char *ip_stri=
ng, msglvl_t msglevel, bool *error)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    un=
signed int flags =3D GETADDR_HOST_ORDER;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    bool succeeded =3D false;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    in_addr_t ret;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (msglevel &amp; M_FATAL)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     flags |=3D GETADDR_FATAL;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D getaddr(flags, i=
p_string, 0, &amp;succeeded, NULL);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (!succeeded &amp;&amp; error)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        *error =3D true;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</spa=
n><br><span>  * Returns newly allocated string containing address part with=
out &quot;/nn&quot;=2E</span><br><span>  *</span><br><span>@@ -1097,13 +107=
8,6 @@</span><br><span>     }</span><br><span>     return ret;</span><br><s=
pan> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-ipv6_addr_safe_hexplusbits(const char *ipv6_pr=
efix_spec)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    return get_ipv6_addr(ipv6_p=
refix_spec, NULL, NULL, M_WARN);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> /**</span><br><span>  * Parses a hexstring and checks if the strin=
g has the correct length=2E Return</span><br><span>  * a verify_hash_list c=
ontaining the parsed hash string=2E</span><br><span>@@ -3337,7 +3311,7 @@</=
span><br><span>     options_postprocess_verify(options);</span><br><span> #=
ifndef ENABLE_SMALL</span><br><span>     options_postprocess_filechecks(opt=
ions);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* !ENAB=
LE_SMALL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span> }</span><br><span> </span><br><span> /*</span><br><span>dif=
f --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span=
>index c23d0b3=2E=2E2b68a0e 100644</span><br><span>--- a/src/openvpn/option=
s=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -723=
,8 +723,6 @@</span><br><span>     unsigned int imported_protocol_flags;</sp=
an><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define streq(x, y) (!strcmp((x), (y)))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Op=
tion classes=2E</span><br><span>  */</span><br><span>diff --git a/src/openv=
pn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><span>index 80dec6c=2E=2E33ff7=
2b 100644</span><br><span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b/=
src/openvpn/pool=2Ec</span><br><span>@@ -31,6 +31,7 @@</span><br><span> #in=
clude &quot;error=2Eh&quot;</span><br><span> #include &quot;socket_util=2Eh=
&quot;</span><br><span> #include &quot;otime=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><=
br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span=
> </span><br><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</sp=
an><br><span>index 0e581e5=2E=2E5b705ee 100644</span><br><span>--- a/src/op=
envpn/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -3=
2,6 +32,7 @@</span><br><span> #include &quot;socket=2Eh&quot;</span><br><sp=
an> #include &quot;fdmisc=2Eh&quot;</span><br><span> #include &quot;crypto=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;resolve=2Eh&quot;</span><br><span> #include &quot;ps=2Eh&quot;</span>=
<br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><spa=
n>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>=
index c2c1914=2E=2E3005a2d 100644</span><br><span>--- a/src/openvpn/push=2E=
c</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -37,6 +37,7=
 @@</span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #incl=
ude &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot;options_util=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;resolve=2Eh&quot;</span><br><span> </span><br><span> /*</span><br><sp=
an>  * Auth username/password</span><br><span>diff --git a/src/openvpn/reso=
lve=2Ec b/src/openvpn/resolve=2Ec</span><br><span>new file mode 100644</spa=
n><br><span>index 0000000=2E=2Eb8d9899</span><br><span>--- /dev/null</span>=
<br><span>+++ b/src/openvpn/resolve=2Ec</span><br><span>@@ -0,0 +1,665 @@</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to secur=
ely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             over a single TCP/UDP port, with support for SSL/TLS-base=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ses=
sion authentication and key exchange,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             packet encryption, packet authentication, =
and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             p=
acket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C=
) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is free software; you can redistribute it=
 and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  i=
t under the terms of the GNU General Public License version 2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Soft=
ware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s distributed in the hope that it will be useful,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Li=
cense for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not,=
 see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;c=
rypto=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;manage=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;openvpn=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;socket=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket_util=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Convert sockflags/getaddr_flags into getaddr_flags</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+unsigned int</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+sf2gaf(const unsigned int getaddr_flags, const unsign=
ed int sockflags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sockflags &a=
mp; SF_HOST_RANDOMIZE)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn getaddr_flags | GETADDR_RANDOMIZE;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return getad=
dr_flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Functions related to the translation of DNS names to IP addresses=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Small helper function for openvpn_getaddrinfo to print the address</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * family when resolving f=
ails</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static const char *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+getaddrinfo_addr_family_name(in=
t af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    switch (af)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        case AF_INET:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return &quot;[AF_INET]&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        case AF_INET6:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return &quot;[AF_INET6]&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return &quot;&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Pre=
pend a random string to hostname to prevent DNS caching=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * For example, foo=2Ebar=2Egov woul=
d be modified to &lt;random-chars&gt;=2Efoo=2Ebar=2Egov=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Of course, this requires explicit=
 support in the DNS server (wildcard)=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static const char *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+hostname_randomize(const char *hostname, struct gc_arena *gc)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define n_rnd_bytes 6</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    uint8_t rnd_bytes[n_rnd_bytes];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const char *rnd_str;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer hname =3D alloc_buf_gc(=
strlen(hostname) + sizeof(rnd_bytes) * 2 + 4, gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    prng_bytes(rnd_bytes, sizeof(rnd_bytes));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    rnd_str =3D format_hex_ex(rnd_byt=
es, sizeof(rnd_bytes), 40, 0, NULL, gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf_printf(&amp;hname, &quot;%s=2E%s&quot;, rnd_st=
r, hostname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn BSTR(&amp;hname);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#undef n_rnd_bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Translate IPv4/IPv6 addr or hostname into struct =
addrinfo</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If resol=
ve error, try again for resolve_retry_seconds seconds=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+openvpn_getaddrinfo(unsigned int flags, const char *hostname, const ch=
ar *servname,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              int resolve_retry_seconds, struct signal_info *sig_info, int =
ai_family,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           struct addrinfo **res)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct addrinfo hints;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct signal_info sigrec =3D { 0 };</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    msglvl_t msglevel =3D (flags &amp; GETADDR_FATAL) ?=
 M_FATAL : D_RESOLVE_ERRORS;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *print_hostname;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *print_servname;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ASSERT(res);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ASSERT(hostname || servname);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ASSERT(!(flags &amp; GETADDR_HOST_ORDER));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (servname)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        print_servname =3D servname;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   print_servname =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &am=
p; GETADDR_MSG_VIRT_OUT)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sglevel |=3D M_MSG_VIRT_OUT;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((flags &amp; (GE=
TADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) &amp;&amp; !sig_info)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        sig_info =3D &amp;sigrec;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* try numeric ip addr first */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(hints);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    hints=2Eai_flags =3D AI_NUMERICHOST;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; GETADDR_PASSIVE)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        hints=2Eai_flags |=3D AI_PAS=
SIVE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (flags &amp; GETADDR_DATAGRAM)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        hints=2Eai_socktype =3D SOCK_DGRA=
M;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        hints=2Eai_socktype =3D SOCK_STREAM;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* if hostname is not set, we want to bind to &#39;ANY&#39;=
, with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the co=
rrect address family - v4-only or v6/v6-dual-stack */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!hostname)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        hints=2Eai_family =3D ai_family;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    status =3D getaddrinfo(hostname, servname, &amp;hints, res);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (status !=3D 0)                   =
   /* parse as numeric address failed? */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        const int fail_wait_interval =3D 5; /* seconds */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        /* Add +4 to cause in=
teger division rounding up (1 + 4) =3D 5, (0+4)/5=3D0 */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        int resolve_retries =3D</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            (flags &amp; G=
ETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *=
fmt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msglvl_=
t level =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* this is not a=
 numeric IP, therefore force resolution using the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         * provided ai_family */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        hints=2Eai_family =3D ai=
_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (hostname &amp;&amp=
; (flags &amp; GETADDR_RANDOMIZE))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            hostname =3D hostname_randomize(hostname, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (hostname)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            print_hostname =3D hostname;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            print_hostname =3D &quot;undefined&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        fmt =3D &quot;RESOLVE: Cannot resolve host address: %s:=
%s%s (%s)&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if ((flags &amp; GETADDR_MENTION_RESOLVE_RETRY) &amp;&amp; !resolve_re=
try_seconds)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fmt =
=3D &quot;RESOLVE: Cannot resolve host address: %s:%s%s (%s)&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                  &quot;(I w=
ould have retried this name query if you had &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  &quot;specified the --r=
esolv-retry option=2E)&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(flags=
 &amp; GETADDR_RESOLVE) || status =3D=3D EAI_FAIL)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(msglevel, &quot;RESOLVE: Cannot parse =
IP address: %s:%s (%s)&quot;, print_hostname,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                print_servname, gai_strerror(stat=
us));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            go=
to done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp; GETADDR_UPD=
ATE_MANAGEMENT_STATE)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    if (management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          management_set_state(management, OPENVPN_STATE_RESOLVE, NULL, NUL=
L, NULL, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                NULL);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * Resolve hostname</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        while (true)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            /* force resolv=2Econf reload */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            res_init();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            /* try hostname lookup *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            hints=
=2Eai_flags &amp;=3D ~AI_NUMERICHOST;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            dmsg(D_SOCKET_DEBUG, &quot;GETADDRINFO flags=
=3D0x%04x ai_family=3D%d ai_socktype=3D%d&quot;, flags,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                 hints=2Eai_family, hin=
ts=2Eai_socktype);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           status =3D getaddrinfo(hostname, servname, &amp;hints, res);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (sig_info)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                get_signal(&amp;sig_info-=
&gt;signal_received);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                if (sig_info-&gt;signal_received) /* were we interrupted =
by a signal? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              /* why are we overwriting SIGUSR1 ? */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    if (signal_reset(sig_=
info, SIGUSR1) =3D=3D SIGUSR1) /* ignore SIGUSR1 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        msg(level, &quo=
t;RESOLVE: Ignored SIGUSR1 signal received during &quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                   &qu=
ot;DNS resolution attempt&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        /* turn success into failure=
 (interrupted syscall) */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        if (0 =3D=3D status)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                            ASSERT(res=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
           freeaddrinfo(*res);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                            *res =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            status =3D EA=
I_AGAIN; /* =3D temporary failure */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                            errno =3D EINTR;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                        got=
o done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* success? */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (0 =3D=3D statu=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                break;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            /* resolve lookup failed, should =
we</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * co=
ntinue or fail? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           level =3D msglevel;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (resolve_retries &gt; 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                level =3D D_RESOLVE_ERRORS;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(level, fmt, print_hostname, print_s=
ervname, getaddrinfo_addr_family_name(ai_family),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                gai_strerror(status));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (--resolve_retries &lt;=3D 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                goto done;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            management_sleep(fail_wait_inter=
val);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ASSERT(res);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* hostname resolve succeeded */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * Do not choose an IP Addresse by random or change the or=
der *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * of =
IP addresses, doing so will break RFC 3484 address selection *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* IP address parse succeeded */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (flags &amp; GETADDR_RANDOMIZE)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;WARNING: ignori=
ng --remote-random-hostname because the &quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        &quot;hostname is an IP =
address&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (sig_info &amp;&amp; sig_info-&gt;signal_received)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msglvl_t level =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp; GET=
ADDR_FATAL_ON_SIGNAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    level =3D M_FATAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else if (flags &amp; GETADDR_WARN_ON_SIGNAL)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            level =3D M_WARN;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(level, &quot;RESOLVE: signal received during DN=
S resolution attempt&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return status;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+get_addr_generic(sa_family_t af, unsigned int flags, const char *host=
name, void *network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                 unsigned int *netbits, int resolve_retry_seconds, struct =
signal_info *sig_info,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                 msglvl_t msglevel)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    char *endp, *sep, *var_host =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct addrinfo *ai =3D NULL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    unsigned long bits;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    uint8_t max_bits;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!hostname)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(M_NONFATAL, &quot;Can&#39;t resolve null hostname!&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto ou=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* assign family specific default values */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (af)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        case AF_INET:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            bits =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            max_bits =3D sizeof(in=
_addr_t) * 8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET6:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            bits =3D 64=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            max_bi=
ts =3D sizeof(struct in6_addr) * 8;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    default:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(M_WARN, &quot;Unsupported AF family passed to getaddrinfo for %s (=
%d)&quot;, hostname, af);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            goto out;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we need to modify =
the hostname received as input, but we don&#39;t want to</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * touch it directly as it might b=
e a constant string=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * The=
refore, we clone the string here and free it at the end of the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * function */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    var_host =3D strdup(hostname)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!var_host)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONFATAL | M_ERRNO,=
 &quot;Can&#39;t allocate hostname buffer for getaddrinfo&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* check if this hostname has a /bits suffix */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    sep =3D strchr(var_host, &#3=
9;/&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (s=
ep)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        bits =3D strtoul(sep +=
 1, &amp;endp, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if ((*endp !=3D &#39;\0&#39;) || (bits &gt; max_bits))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;IP prefix=
 &#39;%s&#39;: invalid &#39;/bits&#39; spec (%s)&quot;, hostname, sep + 1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto ou=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        *sep =3D &#39;\0&#3=
9;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ret =3D openvpn_getaddrinfo(flags &amp; ~GETA=
DDR_HOST_ORDER, var_host, NULL, resolve_retry_seconds,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                              sig_info, =
af, &amp;ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 ((ret =3D=3D 0) &amp;&amp; network)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        struct in6_addr *ip6;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        in_addr_t *ip4;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (af !=3D ai-&gt;ai_family)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(msglevel, &quot;Can&#39;t parse %s as IPv%d address&q=
uot;, var_host, (af =3D=3D AF_INET) ? 4 : 6);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            ret =3D -1;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            goto out;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        switch (af)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       case AF_INET:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                ip4 =3D network;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                *ip4 =3D ((struct sockaddr_in *)ai-&gt;ai_add=
r)-&gt;sin_addr=2Es_addr;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   if (flags &amp; GETADDR_HOST_ORDER)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    *ip4 =3D ntohl(*ip4);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            case AF_INET6:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                ip6 =3D network;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                *ip6 =3D ((struct =
sockaddr_in6 *)ai-&gt;ai_addr)-&gt;sin6_addr;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                break;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            default:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                /* can&#39;t get here because &#39;af&#39; was p=
reviously checked */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                msg(M_WARN, &quot;Unsupported AF family for %s (%d)&quot;,=
 var_host, af);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (netbits)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        *netbits =3D (unsigned int)bits;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* restore &#39;/&#39; separator, if any */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (sep)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        *sep =3D &#39;/&#39;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+out:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (ai)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        freeaddrinfo(ai);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    free(var_host);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+in_addr_t</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+getaddr(unsigned int flags, con=
st char *hostname, int resolve_retry_seconds, bool *succeeded,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct signal_info *sig_=
info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t addr =3D { 0 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int status;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    status =3D get_addr_generic(AF_INET, flag=
s, hostname, &amp;addr, NULL, resolve_retry_seconds,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                              sig_info, M=
_WARN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (stat=
us =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (succeeded=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            *succeeded =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return addr;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (succeeded)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            *succeeded =3D false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+in_addr_t</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+get_ip_addr(const char *ip_string, msglvl_t msglevel, =
bool *error)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =
=3D GETADDR_HOST_ORDER;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool succeeded =3D false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    in_addr_t ret;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (msglevel &amp; M_FATAL)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
flags |=3D GETADDR_FATAL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D getaddr(flags, =
ip_string, 0, &amp;succeeded, NULL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!succeeded &amp;&amp; error)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        *error =3D true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+get_ipv6_addr(const char *hostname, struct in=
6_addr *network, unsigned int *netbits,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+              msglvl_t msglevel)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostnam=
e, network, netbits, 0, NULL, msglevel)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        &lt; 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return true; /* parsing O=
K, values set */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * get_cached_dns_entry return 0 on success and -1</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * otherwise=2E (like geta=
ddrinfo)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+get_cached_dns_entry(struct cached_dns_en=
try *dns_cache, const char *hostname, const char *servname,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     int ai_family,=
 unsigned int resolve_flags, struct addrinfo **ai)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct cached_dns_entry *ph;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    unsigned int flags;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* Only use flags that are relevant for the structure */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    flags =3D resolve_f=
lags &amp; GETADDR_CACHE_MASK;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for =
(ph =3D dns_cache; ph; ph =3D ph-&gt;next)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (streqnull(ph-&gt;hostname, hostname) &amp;&amp; streqn=
ull(ph-&gt;servname, servname)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            &amp;&amp; ph-&gt;ai_family =3D=3D ai_family &amp;&a=
mp; ph-&gt;flags =3D=3D flags)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            *ai =3D ph-&gt;ai;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_pr=
eresolve_host(struct context *c, const char *hostname, const char *servname=
, const int af,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
               const unsigned int flags)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct addrinfo *ai;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int status;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (get_cac=
hed_dns_entry(c-&gt;c1=2Edns_cache, hostname, servname, af, flags, &amp;ai)=
 =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* entry alread=
y cached, return success */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D openvpn_geta=
ddrinfo(flags, hostname, servname, c-&gt;options=2Eresolve_retry_seconds, N=
ULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                  af, &amp;ai);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (status =3D=3D 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        struct cached_dns_entry *ph;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        ALLOC_OBJ_CLEAR_GC(ph, struct cached_dns_entry, &amp;c-&gt;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        ph-&gt;ai =3D =
ai;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ph-&gt;h=
ostname =3D hostname;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        ph-&gt;servname =3D servname;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        ph-&gt;flags =3D flags &amp; GETADDR_CACHE_MASK=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (!c-&gt;c1=2Edns_cache)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c1=2Edns_cache=
 =3D ph;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            struct cached_dns_entry *p=
rev =3D c-&gt;c1=2Edns_cache;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            while (prev-&gt;next)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                prev =3D prev-&gt;next;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            prev-&gt;next =3D ph;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        gc_addspecial(ai, &amp;gc_freeaddrinfo_callback,=
 &amp;c-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return status=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+do_preresolve(struct context *c)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct connection_list *l =3D c-&gt;options=2Econnection_list;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned int prere=
solve_flags =3D GETADDR_RESOLVE | GETADDR_UPDATE_MANAGEMENT_STATE</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
             | GETADDR_MENTION_RESOLVE_RETRY | GETADDR_FATAL;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (int i =3D 0; i &lt; l-&gt;len; ++i)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        int status;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const char *remote;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        unsigned int flags =3D preresolve_flags;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct connection_entry *ce =3D l=
-&gt;array[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (proto_is_dgr=
am(ce-&gt;proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
flags |=3D GETADDR_DATAGRAM;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;op=
tions=2Esockflags &amp; SF_HOST_RANDOMIZE)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            flags |=3D GETADDR_RANDOMIZE;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (c-&gt;options=2Eip_remote_hint)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            remote =3D c-&gt;options=2Eip_remote_hint;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            remote =3D ce-&gt;remote;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* HTTP remote hostname does not need to be resolv=
ed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!c=
e-&gt;http_proxy_options)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        status =3D do_preresolve_host(c, remote, ce-&gt;remote_port, ce-&gt=
;af, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (status !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* Preresolve proxy */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ce-&gt;h=
ttp_proxy_options)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 status =3D do_preresolve_host(c, ce-&gt;http_proxy_options-&gt;server,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
                 ce-&gt;http_proxy_options-&gt;port, ce-&gt;af, preresolve_=
flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (status !=3D 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                goto err;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (ce-&gt;socks_proxy_server)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            status =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                do_preresolve_host(c, ce-=
&gt;socks_proxy_server, ce-&gt;socks_proxy_port, ce-&gt;af, flags);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (status !=3D=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                goto e=
rr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (ce-&gt;bind_local)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            flags |=3D GETADDR_PASSIVE;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            flags &amp;=3D ~GE=
TADDR_RANDOMIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            for (int j=
 =3D 0; j &lt; ce-&gt;local_list-&gt;len; j++)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                const struct local_entry *le =3D ce-&g=
t;local_list-&gt;array[j];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    if (!le-&gt;local)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    continue;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      status =3D do_preresolve_host(c, le-&gt;local, le-&gt;port, ce-&gt;af=
, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      if (status !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    goto err;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    throw_signal_soft(SIGHUP, &quot;Preresolving failed&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
>diff --git a/src/openvpn/resolve=2Eh b/src/openvpn/resolve=2Eh</span><br><=
span>new file mode 100644</span><br><span>index 0000000=2E=2E9069af7</span>=
<br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/resolve=2Eh</span=
><br><span>@@ -0,0 +1,106 @@</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Open=
VPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
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
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * DNS resolution</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef RESOLVE_H<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RESOLVE_H</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;sig=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define GETADDR_RESOLVE                 (1u &lt;&lt; 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_FATAL                   =
(1u &lt;&lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine GETADDR_HOST_ORDER              (1u &lt;&lt; 2)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_MENTION_RESOLVE_RETRY   (=
1u &lt;&lt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne GETADDR_FATAL_ON_SIGNAL         (1u &lt;&lt; 4)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define GETADDR_WARN_ON_SIGNAL          (1u =
&lt;&lt; 5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
GETADDR_MSG_VIRT_OUT            (1u &lt;&lt; 6)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define GETADDR_TRY_ONCE                (1u &lt=
;&lt; 7)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GET=
ADDR_UPDATE_MANAGEMENT_STATE (1u &lt;&lt; 8)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define GETADDR_RANDOMIZE               (1u &lt;&l=
t; 9)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADD=
R_PASSIVE                 (1u &lt;&lt; 10)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define GETADDR_DATAGRAM                (1u &lt;&lt;=
 11)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_CACHE_MASK (GETADD=
R_DATAGRAM | GETADDR_PASSIVE)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Convert sockflags/geta=
ddr_flags into getaddr_flags</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigne=
d int sf2gaf(const unsigned int getaddr_flags, const unsigned int sockflags=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Translate an IPv4 addr or hostname from string fo=
rm to in_addr_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * In case of resolve=
 error, it will try again for</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * resolve_retry_seconds seconds=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+in_addr_t getaddr(unsigned int flags, const char *hostname, int r=
esolve_retry_seconds,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                  bool *succeeded, struct signal_info *sig_info);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+in_addr_t get_ip_addr(const char *ip_string, m=
sglvl_t msglevel, bool *error);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Translate an IPv6 ad=
dr or hostname from string form to in6_addr</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool get_ipv6_addr(const char *hostname, struct in6_addr *network, =
unsigned int *netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                   msglvl_t msglevel);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ipv6_addr_safe_hexplusbits(const char *ipv6_prefix_spec)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL,=
 M_WARN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+int openvpn_getaddrinfo(unsigned int flags, con=
st char *hostname, const char *servname,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        int resolve_retry_seconds, str=
uct signal_info *sig_info, int ai_family,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        struct addrinfo **res);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void do_preresolve(struct context *c);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* struct to hold preresolved host names */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct cached_dns_en=
try</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const char *hostname;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *servname;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ai_family;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo=
 *ai;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct cac=
hed_dns_entry *next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * get_cached_dns_entry return 0 on success and -1<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * otherwise=2E (lik=
e getaddrinfo())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int get_cached_dns_=
entry(struct cached_dns_entry *dns_cache, const char *hostname,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                         const =
char *servname, int ai_family,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                         unsigned int resolve_flags, struct addr=
info **ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* RESOLVE_H */</spa=
n><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</spa=
n><br><span>index 078bb7e=2E=2E5d70472 100644</span><br><span>--- a/src/ope=
nvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>=
@@ -42,6 +42,7 @@</span><br><span> #include &quot;options=2Eh&quot;</span><=
br><span> #include &quot;networking=2Eh&quot;</span><br><span> #include &qu=
ot;integer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;resolve=2Eh&quot;</span><br><span> </span><br><span> #inclu=
de &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>diff --git a/sr=
c/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 6684350=
=2E=2E663a2b4 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br=
><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -38,6 +38,7 @@</span=
><br><span> #include &quot;manage=2Eh&quot;</span><br><span> #include &quot=
;openvpn=2Eh&quot;</span><br><span> #include &quot;forward=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh=
&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</=
span><br><span> </span><br><span>@@ -54,366 +55,6 @@</span><br><span>     r=
eturn false;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Convert sockflags/getaddr_flags into getaddr_flags</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static unsigned int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-sf2gaf(const unsigned int getaddr_flags, const unsigne=
d int sockflags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sockflags &amp; S=
F_HOST_RANDOMIZE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return getad=
dr_flags | GETADDR_RANDOMIZE;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        return getaddr_flags;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * Functions related to the =
translation of DNS names to IP addresses=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_add=
r_generic(sa_family_t af, unsigned int flags, const char *hostname, void *n=
etwork,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
   unsigned int *netbits, int resolve_retry_seconds, struct signal_info *si=
g_info,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
   msglvl_t msglevel)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *endp, *sep=
, *var_host =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct addrinfo *ai =3D NULL;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    unsigned long bits;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    uint8_t max_bits;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int ret =3D -1;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
hostname)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_NONFATAL, &quo=
t;Can&#39;t resolve null hostname!&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        goto out;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* assign family=
 specific default values */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    switch (af)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_=
INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            bits=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ma=
x_bits =3D sizeof(in_addr_t) * 8;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case=
 AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 bits =3D 64;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    max_bits =3D sizeof(struct in6_addr) * 8;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       msg(M_WARN, &quot;Unsupported AF family passed to getaddrinfo for %s=
 (%d)&quot;, hostname, af);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            goto out;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* we need to modify the ho=
stname received as input, but we don&#39;t want to</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     * touch it directly as it might be a cons=
tant string=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Therefore, we c=
lone the string here and free it at the end of the</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     * function */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    var_host =3D strdup(hostname);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (!var_host)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(M_NONFATAL | M_ERRNO, &quot;Can&#39;t alloc=
ate hostname buffer for getaddrinfo&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        goto out;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* check if thi=
s hostname has a /bits suffix */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    sep =3D strchr(var_host, &#39;/&#39;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (sep)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        bits =3D strtoul(sep + 1, &amp;endp, 10);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if ((*endp !=3D &#39;\0&#39;) ||=
 (bits &gt; max_bits))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 msg(msglevel, &quot;IP prefix &#39;%s&#39;: invalid &#39;/bits&#39; spec (=
%s)&quot;, hostname, sep + 1);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            goto out;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     *sep =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D openvpn_getaddrinfo=
(flags &amp; ~GETADDR_HOST_ORDER, var_host, NULL, resolve_retry_seconds,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
      sig_info, af, &amp;ai);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if ((ret =3D=3D 0) &amp;&amp; network)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        struct in6_addr *ip6;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        in_addr_t *ip4;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (af !=3D ai-&gt;ai_family)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            msg(msglevel, &quot;Can&#39;t parse %s as IPv%d address&q=
uot;, var_host, (af =3D=3D AF_INET) ? 4 : 6);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            ret =3D -1;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            goto out;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 switch (af)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            case AF_I=
NET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                i=
p4 =3D network;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          *ip4 =3D ((struct sockaddr_in *)ai-&gt;ai_addr)-&gt;sin_addr=2Es_=
addr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                if (flags &amp; GETAD=
DR_HOST_ORDER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         *ip4 =3D ntohl(*ip4);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                break;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            cas=
e AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      ip6 =3D network;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                *ip6 =3D ((struct sockaddr_in6 *)ai-&gt;ai_addr)-&gt;sin6_=
addr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            default:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                /* can&#39;t get here=
 because &#39;af&#39; was previously checked */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                msg(M_WARN, &quot;Unsupported AF =
family for %s (%d)&quot;, var_host, af);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                goto out;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (netbits)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        *netbits =3D (unsigned int)bits;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* restore &#39;/&#39; separator, if any */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (sep)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        *sep =3D &#39;/&#39;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-out:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ai)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        freeaddrinfo(ai);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    free(var_host);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-in_addr_t</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-getaddr(unsigned int flags, const char *hostname, int reso=
lve_retry_seconds, bool *succeeded,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        struct signal_info *sig_info)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    in_addr_t addr =3D { 0 };</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int status;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sta=
tus =3D get_addr_generic(AF_INET, flags, hostname, &amp;addr, NULL, resolve=
_retry_seconds,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                        sig_info, M_WARN);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (status =3D=3D 0)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (succeeded)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         *succeeded =3D true;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return addr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (succeeded)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            *succeeded =3D false;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-get_ipv6_addr(const char *hostname, struct in6_addr *network, un=
signed int *netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
             msglvl_t msglevel)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ge=
t_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, netbits, 0, NU=
LL, msglevel)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
&lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return true; /* parsing OK, values set */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static in=
line bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-streqnull(co=
nst char *a, const char *b)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (a =3D=
=3D NULL &amp;&amp; b =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (a =3D=
=3D NULL || b =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        return streq(a, b);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * get_cached_dns_entry return 0 on success and -1<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * otherwise=2E (like =
getaddrinfo)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-get_cached_dns_entry(struct cached_dns=
_entry *dns_cache, const char *hostname, const char *servname,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                     int ai_family=
, unsigned int resolve_flags, struct addrinfo **ai)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct cached_dns_entry *ph;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    unsigned int flags;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* Only use flags that are relevant for the structure */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    flags =3D resolve_flags &amp=
; GETADDR_CACHE_MASK;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (ph =3D dns_c=
ache; ph; ph =3D ph-&gt;next)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (streqnull(ph-&gt;hostname, hostname) &amp;&amp; streqnull(ph-&gt;servna=
me, servname)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    &amp;&amp; ph-&gt;ai_family =3D=3D ai_family &amp;&amp; ph-&gt;flags =
=3D=3D flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *ai =3D =
ph-&gt;ai;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return -1;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-do_preresolve_host(struct context *c, const=
 char *hostname, const char *servname, const int af,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                   const unsigned int flags=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct addrinfo *ai;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int status;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (get_cached_dns_entry(c-&gt;c1=2Edns_cache, hostname, ser=
vname, af, flags, &amp;ai) =3D=3D 0)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       /* entry already cached, return success */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =
=3D openvpn_getaddrinfo(flags, hostname, servname, c-&gt;options=2Eresolve_=
retry_seconds, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                af, &amp;ai);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (status =3D=3D 0)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        struct cached_dns_entry *ph;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        ALLOC_OBJ_CLEAR_GC(ph, struct cached_dns_entry, &amp;c-&gt;gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ph-&gt;ai =
=3D ai;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ph-&gt=
;hostname =3D hostname;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        ph-&gt;servname =3D servname;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        ph-&gt;flags =3D flags &amp; GETADDR_CACHE_MASK;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!c-&gt;c1=2Edns_cache)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            c-&gt;c1=2Edns_cache =3D ph;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            struct cached_dns_entry *prev =3D c-&gt;c1=
=2Edns_cache;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    while (prev-&gt;next)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            prev =3D prev-&gt;next;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            prev-&gt;next =3D ph;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        gc_adds=
pecial(ai, &amp;gc_freeaddrinfo_callback, &amp;c-&gt;gc);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return status;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-do_preresolve(struct context *c)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct connection_list *l =3D c-&gt;options=2E=
connection_list;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
onst unsigned int preresolve_flags =3D GETADDR_RESOLVE | GETADDR_UPDATE_MAN=
AGEMENT_STATE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                                  | GETADDR_MENTION_RESOLVE_RETRY | GETADDR=
_FATAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    for (int i =3D 0; i &lt; l-&gt;len; ++i)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        int status;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        const char *remote;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        unsigned int flags =3D preresolve_f=
lags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        struct connection_entry *ce =
=3D l-&gt;array[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (proto_is_dg=
ram(ce-&gt;proto))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            fla=
gs |=3D GETADDR_DATAGRAM;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;options=2Es=
ockflags &amp; SF_HOST_RANDOMIZE)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            flags |=3D GETADDR_RANDOMIZE;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c=
-&gt;options=2Eip_remote_hint)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         remote =3D c-&gt;options=2Eip_remote_hint;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           remote =3D ce-&gt;remote;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* HTTP re=
mote hostname does not need to be resolved */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (!ce-&gt;http_proxy_options)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            status =3D do_preresolve_host(c=
, remote, ce-&gt;remote_port, ce-&gt;af, flags);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (status !=3D 0)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                goto err;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* Preresolve proxy */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (ce-&gt;http_proxy_options)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            status =3D do_preresolve_host(c, ce-&gt;http_proxy_options=
-&gt;server,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                               ce-&gt;http_proxy_options-&gt;port, ce-&gt;a=
f, preresolve_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (statu=
s !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                goto=
 err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (ce-&gt;socks_proxy_server)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            status =3D</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                do_preresolve_host(c, ce-&gt;socks_=
proxy_server, ce-&gt;socks_proxy_port, ce-&gt;af, flags);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            if (status !=3D 0)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                goto err;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (ce-&gt;bind_local)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         flags |=3D GETADDR_PASSIVE;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            flags &amp;=3D ~GETADDR_RANDOMIZE;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            for (int j =3D 0; j &lt; ce-&gt;local_list-&=
gt;len; j++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                c=
onst struct local_entry *le =3D ce-&gt;local_list-&gt;array[j];</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                if (!le-&gt;local)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    continue;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                status =3D do_preresolve_host(c, le-&gt;loca=
l, le-&gt;port, ce-&gt;af, flags);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                if (status !=3D 0)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    goto err;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-err:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    throw_signal_soft(SIGHUP, &quot;Preresolving failed&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static int</span=
><br><span> socket_get_sndbuf(socket_descriptor_t sd)</span><br><span> {</s=
pan><br><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh<=
/span><br><span>index c6bcd86=2E=2Ee8335d3 100644</span><br><span>--- a/src=
/openvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br>=
<span>@@ -62,17 +62,6 @@</span><br><span> /* convert a packet_size_type fro=
m network to host order */</span><br><span> #define ntohps(x) ntohs(x)</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* struc=
t to hold preresolved host names */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-struct cached_dns_entry</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
const char *hostname;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    const char *servname;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int ai_family;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    unsigned int flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct addrinfo *ai;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct cached_dns_entry *next;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> /* IP addresses which are persistent across SIGUSR1s */</=
span><br><span> struct link_socket_addr</span><br><span> {</span><br><span>=
@@ -362,8 +351,6 @@</span><br><span> </span><br><span> void link_socket_ini=
t_phase2(struct context *c, struct link_socket *sock);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void do_preresolve(struc=
t context *c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> void link_socket_close(struct link_socket *sock);</span><br><spa=
n> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>diff --git a/=
src/openvpn/socket_util=2Ec b/src/openvpn/socket_util=2Ec</span><br><span>i=
ndex 0194f38=2E=2E5d405ac 100644</span><br><span>--- a/src/openvpn/socket_u=
til=2Ec</span><br><span>+++ b/src/openvpn/socket_util=2Ec</span><br><span>@=
@ -490,271 +490,6 @@</span><br><span>     return &quot;&quot;; /* Make the =
compiler happy */</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * Small helper function for openvpn_getaddrinfo to print th=
e address</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * family wh=
en resolving fails</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const char *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-getaddrinfo_addr_family=
_name(int af)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (af)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        case AF_INET:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            return &quot;[AF_INET]&quot;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        case AF_INET6:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            return &quot;[AF_INET6]&quot;;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return &quot;&quot;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * Prepend a random strin=
g to hostname to prevent DNS caching=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * For example, foo=2Ebar=2Egov would be modified to &lt;=
random-chars&gt;=2Efoo=2Ebar=2Egov=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * Of course, this requires explicit support in the DNS ser=
ver (wildcard)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const char *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-hostname_randomize(const=
 char *hostname, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine n_rnd_bytes 6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t rnd_bytes[n_r=
nd_bytes];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const c=
har *rnd_str;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct buffer hname =3D alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes) * 2 +=
 4, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    prng_bytes(rnd_bytes, sizeof(r=
nd_bytes));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rnd_st=
r =3D format_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;hname, &q=
uot;%s=2E%s&quot;, rnd_str, hostname);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return BSTR(&amp;hname);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#undef n_rnd_bytes</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * Translate IPv4/IPv6 addr or hostname=
 into struct addrinfo</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * If resolve error, try again for resolve_retry_seconds seconds=2E</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-openvpn_getaddrinfo(unsigned int flags, const char *hostname, con=
st char *servname,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 int resolve_retry_seconds, struct signal_info *sig_info, i=
nt ai_family,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            struct addrinfo **res)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
uct addrinfo hints;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct signal_info sigrec =3D { 0 };</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    msglvl_t msglevel =3D (flags &amp; GETADDR_FATAL) ? M_FATAL =
: D_RESOLVE_ERRORS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    const char *print_hostname;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    const char *print_servname;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ASSERT(res);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(hos=
tname || servname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  ASSERT(!(flags &amp; GETADDR_HOST_ORDER));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (servname)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        print_serv=
name =3D servname;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        print_servname =3D &quot;&quot;;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (flags &amp; GETADDR_MSG_VIRT_OUT)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msglevel |=3D M_MSG_VIRT_OUT;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f ((flags &amp; (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) &amp;&a=
mp; !sig_info)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sig_info =3D &a=
mp;sigrec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* try numeric ip addr first */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(hints);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    hints=2Eai_flags =3D AI_NUMERICHOS=
T;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (flags &amp; GETADDR_PASSIVE)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        hints=2Eai_flags |=3D AI_PASSIVE;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (flags &amp; GETADDR_DATAGRAM)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        hints=2Eai_socktype =3D SOCK_DGRAM;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  hints=2Eai_socktype =3D SOCK_STREAM;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* if hostname i=
s not set, we want to bind to &#39;ANY&#39;, with</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     * the correct address family - v4-only or =
v6/v6-dual-stack */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (!hostname)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        hints=2Eai_fa=
mily =3D ai_family;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    status =3D getaddrinfo(hostname, se=
rvname, &amp;hints, res);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (status !=
=3D 0)                      /* parse as numeric address failed? */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        const int fail_wait_interval =3D 5; /*=
 seconds */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*=
 Add +4 to cause integer division rounding up (1 + 4) =3D 5, (0+4)/5=3D0 */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int resolve_r=
etries =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 (flags &amp; GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_w=
ait_interval);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 const char *fmt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    msglvl_t level =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* this i=
s not a numeric IP, therefore force resolution using the</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-         * provided ai_family */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        hints=2Eai_family =3D=
 ai_family;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (hostname &amp;&amp;=
 (flags &amp; GETADDR_RANDOMIZE))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            hostname =3D hostname_randomize(hostname, &amp;gc);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (hostname)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           print_hostname =3D hostname;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            pri=
nt_hostname =3D &quot;undefined&quot;;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fmt =3D =
&quot;RESOLVE: Cannot resolve host address: %s:%s%s (%s)&quot;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if ((flags &amp; GETADDR_=
MENTION_RESOLVE_RETRY) &amp;&amp; !resolve_retry_seconds)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            fmt =3D &quot;RESOLVE: Cannot resolve h=
ost address: %s:%s%s (%s)&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                  &quot;(I would have retried this name query if =
you had &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
           &quot;specified the --resolv-retry option=2E)&quot;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (!(flags &amp; GETADDR_RESOLVE) || status =3D=3D EAI_=
FAIL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &q=
uot;RESOLVE: Cannot parse IP address: %s:%s (%s)&quot;, print_hostname,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                print_ser=
vname, gai_strerror(status));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            goto done;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (flags &am=
p; GETADDR_UPDATE_MANAGEMENT_STATE)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            if (management)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                management_set_state(management, OPENVPN_STATE_RESOLVE, NUL=
L, NULL, NULL, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                    NULL);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-         * Resolve hostname</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        while (true)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifndef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            /* force resolv=2Econf reload */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            res_init();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            /* try hostname lookup */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            hints=2Eai_flags &amp;=3D ~AI_=
NUMERICHOST;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   dmsg(D_SOCKET_DEBUG, &quot;GETADDRINFO flags=3D0x%04x ai_family=3D%d ai_=
socktype=3D%d&quot;, flags,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                 hints=2Eai_family, hints=2Eai_socktype);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            status =3D getaddrinf=
o(hostname, servname, &amp;hints, res);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         if (sig_info)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         get_signal(&amp;sig_info-&gt;signal_received);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                if (sig_info-&gt;signal_r=
eceived) /* were we interrupted by a signal? */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    /* why are we overwriting SIGUSR1=
 ? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    if (signal_reset(sig_info, SIGUSR1) =3D=3D SIGUSR1) /* ignore SIGUSR1 *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
    msg(level, &quot;RESOLVE: Ignored SIGUSR1 signal received during &quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
              &quot;DNS resolution attempt&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        /* turn success int=
o failure (interrupted syscall) */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        if (0 =3D=3D status)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                        {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                            ASSERT(=
res);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
            freeaddrinfo(*res);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                            *res =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                            status =3D EAI_=
AGAIN; /* =3D temporary failure */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                            errno =3D EINTR;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        goto done;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            /* success? */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            if (0 =3D=3D status)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                break;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            /* resolve lookup failed, should we</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-             * continue or fail? */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            level =3D msglevel;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (resolve_r=
etries &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 level =3D D_RESOLVE_ERRORS;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(level,=
 fmt, print_hostname, print_servname, getaddrinfo_addr_family_name(ai_famil=
y),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ga=
i_strerror(status));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (--reso=
lve_retries &lt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         goto done;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            management_sleep(fa=
il_wait_interval);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(res);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        /* hostname resolve succeeded */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-         * Do not choose an IP Addresse by random or change the order *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * of IP addr=
esses, doing so will break RFC 3484 address selection *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* IP address=
 parse succeeded */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (flags &amp; GETADDR_RANDOMIZE)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(M_WARN, &quot;WARNING: ignoring --remote-random-host=
name because the &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        &quot;hostname is an IP address&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-done:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sig_info &amp=
;&amp; sig_info-&gt;signal_received)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       msglvl_t level =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (flags &amp; GETADDR_FATAL_ON_SIGNAL)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            level =3D M_FATAL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else if (flags &amp; GETADDR_WARN_ON_SIGNAL)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            level =3D M_WARN;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        msg(level, &quot;RESOLVE: signal=
 received during DNS resolution attempt&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><sp=
an>  * We do our own inet_aton because the glibc function</span><br><span> =
 * isn&#39;t very good about error checking=2E</span><br><span>diff --git a=
/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh</span><br><span>=
index add08ba=2E=2Ec0dcfb07 100644</span><br><span>--- a/src/openvpn/socket=
_util=2Eh</span><br><span>+++ b/src/openvpn/socket_util=2Eh</span><br><span=
>@@ -110,43 +110,6 @@</span><br><span> void setenv_link_socket_actual(struc=
t env_set *es, const char *name_prefix,</span><br><span>                   =
             const struct link_socket_actual *act, const unsigned int flags=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * DNS resolution</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define GETADDR_RESOLVE                 (1u &lt;&lt; 0)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_FATAL        =
           (1u &lt;&lt; 1)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define GETADDR_HOST_ORDER              (1u &lt;&lt; 2)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_MENTION_RESOLVE_RETR=
Y   (1u &lt;&lt; 3)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine GETADDR_FATAL_ON_SIGNAL         (1u &lt;&lt; 4)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_WARN_ON_SIGNAL          (1u=
 &lt;&lt; 5)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define G=
ETADDR_MSG_VIRT_OUT            (1u &lt;&lt; 6)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define GETADDR_TRY_ONCE                (1u &lt;&l=
t; 7)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_=
UPDATE_MANAGEMENT_STATE (1u &lt;&lt; 8)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define GETADDR_RANDOMIZE               (1u &lt;&lt; 9)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_PASSIVE=
                 (1u &lt;&lt; 10)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define GETADDR_DATAGRAM                (1u &lt;&lt; 11)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GE=
TADDR_PASSIVE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * Translate an IPv4 addr or hostname from str=
ing form to in_addr_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * In case of resol=
ve error, it will try again for</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * resolve_retry_seconds seconds=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-in_addr_t getaddr(unsigned int flags, const char *hostname, int resol=
ve_retry_seconds,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
              bool *succeeded, struct signal_info *sig_info);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * Translate an IPv6 addr or hostname from string form to in6_addr</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-bool get_ipv6_addr(const char *hostname, struct=
 in6_addr *network, unsigned int *netbits,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                   msglvl_t msglevel);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-int openvpn_getaddrinfo(unsigned int flags, const char *ho=
stname, const char *servname,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                        int resolve_retry_seconds, struct signal_in=
fo *sig_info, int ai_family,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                        struct addrinfo **res);</span><br><span> </s=
pan><br><span> /* return values of openvpn_inet_aton */</span><br><span> #d=
efine OIA_HOSTNAME 0</span><br><span>diff --git a/src/openvpn/tun=2Ec b/src=
/openvpn/tun=2Ec</span><br><span>index abb46af=2E=2E5bc201d 100644</span><b=
r><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec=
</span><br><span>@@ -39,7 +39,7 @@</span><br><span> #include &quot;fdmisc=
=2Eh&quot;</span><br><span> #include &quot;common=2Eh&quot;</span><br><span=
> #include &quot;run_command=2Eh&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#include &quot;socket_util=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><b=
r><span> #include &quot;manage=2Eh&quot;</span><br><span> #include &quot;ro=
ute=2Eh&quot;</span><br><span> #include &quot;win32=2Eh&quot;</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1846?usp=3Demail">change 1846</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319=
b2b7101f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1846 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>

</body></html>
--jVMj5OcQvEI=--


--===============7687922120464432133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7687922120464432133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7687922120464432133==--

