Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA08CC6B1A
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lXm+rBppTilAei3PXndy7aYzz3oTD2F7V9qq9EgpPgI=; b=mL0Sl6XvVUZnlJkL4h/uacG64o
	M8caG5+YbqAf8LwoMeaqfFtJ4h5agefs7b+a2pGa3s2zE9Rv9zLfR4u9pXcyd5i/bBtigNlQKH0S7
	L5P8gSTDzmp27jxZfcO+b931UAfomhQhtjl4LBR8LxZ+La1dnLOw09xHFude7XbhvNZM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGyss-0007er-9V;
	Wed, 14 Oct 2026 13:19:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGysq-0007ed-RF
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 13:19:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uyuoLEl9X/fhxEPK3xqV42WqzqdNy7dNA1o6serrEnw=; b=ErOiTXZWTtn1g4tjvPrdL5+Ur/
 nMWXT0DL8SRgT7aSTd3o5dhz/7jru+oowksyJbW2rOXay5Ju6679sIg4hbRaeDwvrDlAyCBdouDiO
 pE2FQGtDmiKXsa2pA1UzL8aqere1XxkJi48QixnFc0ouPqooJf4+jyAR4QrSobpM4uiA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uyuoLEl9X/fhxEPK3xqV42WqzqdNy7dNA1o6serrEnw=; b=h
 awGEEGaiClmp5256xyeRpUfvc7lEIFN+g0qdbf1nmJrQsPT0o+XGeGKdGQ3nJtheOCndrt+B5zKz4
 TRzPnjsF3IQ0iIN6pfBoENxT4p/YS89XfMMaAD+DFZEuIT06Jll9xKgdo0KGPmnH1B6/6c5z2wAuu
 0yBzbV/LQMPyE5mg=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGysl-0007HS-G9 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 13:19:05 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so34869195e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 06:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791983933; x=1792588733; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uyuoLEl9X/fhxEPK3xqV42WqzqdNy7dNA1o6serrEnw=;
 b=LuuHBQDfSmC46fjbZHNdrSg4FARGKMoit1tdkZezJ+J2zzamrkPzGFUR5MK/Ln+Aqj
 4we4ZA9uZbm6P5JU9daR4QFzThkIEaji8c7eAQ+nk3r1ByOtTxEVbs9ba1Bssb3yuJdD
 FDLUofJFktrE7ofoUkmrSxztW2Mq0VamBMBv1iV8WwWYGJQ2LDsookdfSwtappj8IfpM
 YebYkoOnPRPBgHfj0/sBB7J/KWQl/N64QUY6yWAZhQ8RK/PaB6m7EEPBQjoXd+y6kJ1D
 Z0UpqNFORuZLhImNyV9XB1a22B37bdrd0+N6RJDEwphnzHKu6y/zBUVFrvX2Pepz29AM
 Dhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791983933; x=1792588733;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uyuoLEl9X/fhxEPK3xqV42WqzqdNy7dNA1o6serrEnw=;
 b=Q8I5CYgzy3qPvFD8grW1fuk/H8QcsmFfnsurt41q9HPeZhICWERaj/eRQHHezoTNpA
 ThDOeeJQGCnq0Z1fR5Rht47AX1dLZcYqKHIGzwhc/3JA4Z0n2XLRSw8FynyZ4S8FgMFO
 eVctI/aYf4swAEJ8T0KsTD1prB/lcLxpMLjh6oefeHdUQurRJtewetT5cCx4HDuHUl+h
 9mNOdobNyqdYX7MQFG1hEU/+3HCNftZkcuGn09lvBJZTSoSBbnjEtpNLR9a7clGWeK3Z
 CCrenqhDjef8k2xRIfeQHHonR5OrhvJSCrbNYHOw2zhP4XN8ii5XDMnTtT4cs1hZlLPR
 kREw==
X-Gm-Message-State: AFq9FYLNpNGWZKwuMGzgfa1k4WpzcG9AX10/rbpon28+zjHf8WBgjt+7
 sxI5h5fpiKCelIERdPLtyXXyLxtJ2aYdk9fuc1e4gbwP+tPTsHKG1irQCOPzioEVxRuHcEeIKz/
 yNs56QPmOV+IjgfvYsfs8Mzto/9gcdVyh3p467ROZnIYPt9GTIRbQPcpOcl3RB1eRL3lCCD81d5
 dqeHr9wQ==
X-Gm-Gg: AYBFou33YfRlSOZ+mtozAW6pAx5QiD7OXIFCMlNg57FwlmyQU/B6eHuURHdVkVpolC3
 8uAOk1XzgLVA0BZ22iLu2jzPXIvyjpcduJx2V9wWX7BwAUgJbel2YZgIv6sAfqTpsbsw8zOwGgy
 NMqqJhKCJD4NA42rTA8K/7srhX2OuoLEVsBiJpdLFZ5tub/DtTAhr0ZTFk2UI4wsgC42IXY00sk
 OW0JZ+OOlUdFsY5XEBpbOPYxZ22VrdvFpFSN6Q6cBzkWMBRdAWiwKzZl8E1mxJOlLLOcDCbfRrb
 GvZe/UFtK+TUAFjEmFvWU/g+Y5LtD/JeptKZSSDfhg+2XiE+gCH9Ab9zziV9NUeBIyUo45iiJyg
 gBx6femE63U0rGU6JhT+4ty7ljHDuLflYrbhLmap7s/sE9hmzy352olWFH7OuUUPSHGDuK00g6Q
 +XyWr2VQ2FzmOswPi+ekOO0qN/PJx1/ZgnoOS+S5fA/FwONCXW+3PdqK5UDOdGaw4L84V+4O3Uf
 WfUISGo+D4sUVrmnWlsjrC2mKeYoNan/pRQkeWqLac9UGCAxWu8RmkhNtdhWrkBLr7Vx23fuv2k
 xidcCJQNgayc3jUPhzbLstAnllgtHddUH9p56/fF4yIrvIwodS3P23/E0gqz
X-Received: by 2002:a05:600c:4e0e:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4a18e4c3f32mr357485755e9.22.1791983931329; 
 Wed, 14 Oct 2026 06:18:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bcf11cb1sm1362405e9.5.2026.10.14.06.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 06:18:50 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 13:18:47 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f
X-Gerrit-Change-Number: 1846
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1846?usp=email>
X-Gerrit-Commit: 27536b037fb0b147d040876515a831b5604f7c10
In-Reply-To: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
References: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTY4NDk1MDAwLkkxMmJlZjMzMGUyYzhhNWU1YjIxYzJmYTgwNzU4NDMxOWIyYjcxMDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8a1eb4519e6f4f9618847c3fda5c43487fa16bed-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGysl-0007HS-G9
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8277539542763393062=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8277539542763393062==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nRnLnmQN1Qc="; charset=UTF-8

--nRnLnmQN1Qc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1846?usp=3Demail

to look at the new patch set (#4)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by R=C4=83z=
van Cojocaru


Change subject: Factor out address resolve code to a new fil=
e resolve=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Factor out address resolve code to a new file resolve=2Ec

The code was w=
eirdly split between socket=2Ec, socket_util=2Ec,
and options=2Ec=2E The ne=
w structure makes more sense=2E

While here move some related string helper=
 code to buffer=2Eh=2E

Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101=
f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M CMakeLis=
ts=2Etxt
M src/openvpn/Makefile=2Eam
M src/openvpn/buffer=2Ec
M src/openvpn=
/buffer=2Eh
M src/openvpn/clinat=2Ec
M src/openvpn/dns=2Ec
M src/openvpn/in=
it=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/options=2Ec
M src/openvpn/opt=
ions=2Eh
M src/openvpn/pool=2Ec
M src/openvpn/ps=2Ec
M src/openvpn/push=2Ec=

A src/openvpn/resolve=2Ec
A src/openvpn/resolve=2Eh
M src/openvpn/route=2E=
c
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M src/openvpn/socket_ut=
il=2Ec
M src/openvpn/socket_util=2Eh
M src/openvpn/tun=2Ec
21 files changed=
, 816 insertions(+), 709 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/46/1846/4

diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt
index bac4dd4=2E=2Eca443ee 100644
--- a/CMakeLists=2Etxt=

+++ b/CMakeLists=2Etxt
@@ -576,6 +576,8 @@
     src/openvpn/reflect_filter=
=2Eh
     src/openvpn/reliable=2Ec
     src/openvpn/reliable=2Eh
+    src/o=
penvpn/resolve=2Ec
+    src/openvpn/resolve=2Eh
     src/openvpn/route=2Ec
=
     src/openvpn/route=2Eh
     src/openvpn/run_command=2Ec
diff --git a/sr=
c/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 7ecddff=2E=2Eae4d=
5ae 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
=
@@ -125,6 +125,7 @@
 	pushlist=2Eh \
 	reflect_filter=2Ec reflect_filter=2E=
h \
 	reliable=2Ec reliable=2Eh \
+	resolve=2Ec resolve=2Eh \
 	route=2Ec r=
oute=2Eh \
 	run_command=2Ec run_command=2Eh \
 	schedule=2Ec schedule=2Eh =
\
diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index a90dda=
e=2E=2E616be73 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=
=2Ec
@@ -1088,6 +1088,23 @@
     }
 }
 
+bool
+streqnull(const char *a, con=
st char *b)
+{
+    if (a =3D=3D NULL && b =3D=3D NULL)
+    {
+        ret=
urn true;
+    }
+    else if (a =3D=3D NULL || b =3D=3D NULL)
+    {
+    =
    return false;
+    }
+    else
+    {
+        return streq(a, b);
+   =
 }
+}
+
 char *
 string_substitute(const char *src, char from, char to, str=
uct gc_arena *gc)
 {
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buff=
er=2Eh
index 58e10f0=2E=2Eafbddf6 100644
--- a/src/openvpn/buffer=2Eh
+++ b=
/src/openvpn/buffer=2Eh
@@ -1830,6 +1830,18 @@
     return 0 =3D=3D strncmp=
(str, prefix, strlen(prefix));
 }
 
+/** helper to work around the semantic=
s of the strcmp() return value
+ * @return true if the strings are equal ac=
cording to strcmp()
+ */
+#define streq(x, y) (!strcmp((x), (y)))
+
+/** co=
mpare two strings which might be NULL
+ * @return true if both strings are =
NULL, or if they are equal according to strcmp()
+ */
+bool streqnull(const=
 char *a, const char *b);
+/** compare two strings which might be NULL, but=
 NULL is never equal
+ * @return true if neither string is NULL and they ar=
e equal according to strcmp()
+ */
 bool string_defined_equal(const char *s=
1, const char *s2);
 char *string_substitute(const char *src, char from, ch=
ar to, struct gc_arena *gc);
 
diff --git a/src/openvpn/clinat=2Ec b/src/op=
envpn/clinat=2Ec
index dcef924=2E=2Ed0d1565 100644
--- a/src/openvpn/clinat=
=2Ec
+++ b/src/openvpn/clinat=2Ec
@@ -30,6 +30,7 @@
 #include "proto=2Eh"
 =
#include "socket_util=2Eh"
 #include "memdbg=2Eh"
+#include "resolve=2Eh"
 =

 static bool
 add_entry(struct client_nat_option_list *dest, const struct =
client_nat_entry *e)
diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec=

index 7f4dde4=2E=2Ea40f3e7 100644
--- a/src/openvpn/dns=2Ec
+++ b/src/open=
vpn/dns=2Ec
@@ -27,7 +27,7 @@
 #include "syshead=2Eh"
 
 #include "dns=2Eh"=

-#include "socket_util=2Eh"
+#include "resolve=2Eh"
 #include "options=2Eh=
"
 #include "run_command=2Eh"
 #include "domain_helper=2Eh"
diff --git a/sr=
c/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 9306a96=2E=2Eeccb814 100644=

--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -55,6 +55,7 @@
 #=
include "tun_afunix=2Eh"
 #include "schedule=2Eh"
 #include "options_string=
=2Eh"
+#include "resolve=2Eh"
 
 #include "memdbg=2Eh"
 
diff --git a/src/o=
penvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 0aef2d4=2E=2E8399fc9 10064=
4
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -44,6 +44,7 =
@@
 #include "dco=2Eh"
 #include "push=2Eh"
 #include "multi=2Eh"
+#include=
 "resolve=2Eh"
 
 #include "memdbg=2Eh"
 
diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec
index 6664c73=2E=2E3bc8ee4 100644
--- a/src/=
openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -64,6 +64,7 @@
 #inclu=
de "domain_helper=2Eh"
 #include "mbuf=2Eh"
 #include "check_file_access=2E=
h"
+#include "resolve=2Eh"
 
 #include <ctype=2Eh>
 
@@ -1044,26 +1045,6 @@=

 
 #endif /* ifndef _WIN32 */
 
-static in_addr_t
-get_ip_addr(const char =
*ip_string, msglvl_t msglevel, bool *error)
-{
-    unsigned int flags =3D =
GETADDR_HOST_ORDER;
-    bool succeeded =3D false;
-    in_addr_t ret;
-
- =
   if (msglevel & M_FATAL)
-    {
-        flags |=3D GETADDR_FATAL;
-    }=

-
-    ret =3D getaddr(flags, ip_string, 0, &succeeded, NULL);
-    if (!s=
ucceeded && error)
-    {
-        *error =3D true;
-    }
-    return ret;=

-}
-
 /**
  * Returns newly allocated string containing address part witho=
ut "/nn"=2E
  *
@@ -1086,13 +1067,6 @@
     }
     return ret;
 }
-
-static=
 bool
-ipv6_addr_safe_hexplusbits(const char *ipv6_prefix_spec)
-{
-    ret=
urn get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WARN);
-}
-
 /**
  * Pars=
es a hexstring and checks if the string has the correct length=2E Return
  =
* a verify_hash_list containing the parsed hash string=2E
@@ -3330,7 +3304,=
7 @@
     options_postprocess_verify(options);
 #ifndef ENABLE_SMALL
     o=
ptions_postprocess_filechecks(options);
-#endif /* !ENABLE_SMALL */
+#endif=

 }
 
 /*
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
in=
dex d347830=2E=2Efc1124a 100644
--- a/src/openvpn/options=2Eh
+++ b/src/ope=
nvpn/options=2Eh
@@ -724,8 +724,6 @@
     unsigned int imported_protocol_fl=
ags;
 };
 
-#define streq(x, y) (!strcmp((x), (y)))
-
 /*
  * Option classe=
s=2E
  */
diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index 63=
fc930=2E=2Efff0e3f 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=
=2Ec
@@ -31,6 +31,7 @@
 #include "error=2Eh"
 #include "socket_util=2Eh"
 #=
include "otime=2Eh"
+#include "resolve=2Eh"
 
 #include "memdbg=2Eh"
 
diff=
 --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index 08c2673=2E=2Edc3465c=
 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -32,6 +32,7 @@=

 #include "socket=2Eh"
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
+#inc=
lude "resolve=2Eh"
 #include "ps=2Eh"
 
 #include "memdbg=2Eh"
diff --git a=
/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 0e281d2=2E=2Eb9da90f 100=
644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -37,6 +37,7 @@=

 #include "memdbg=2Eh"
 #include "ssl_util=2Eh"
 #include "options_util=2E=
h"
+#include "resolve=2Eh"
 
 /*
  * Auth username/password
diff --git a/sr=
c/openvpn/resolve=2Ec b/src/openvpn/resolve=2Ec
new file mode 100644
index =
0000000=2E=2Eb8d9899
--- /dev/null
+++ b/src/openvpn/resolve=2Ec
@@ -0,0 +1=
,665 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+=
 *             over a single TCP/UDP port, with support for SSL/TLS-based
+=
 *             session authentication and key exchange,
+ *             pac=
ket encryption, packet authentication, and
+ *             packet compressi=
on=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ =
*
+ *  This program is free software; you can redistribute it and/or modify=

+ *  it under the terms of the GNU General Public License version 2
+ *  a=
s published by the Free Software Foundation=2E
+ *
+ *  This program is dis=
tributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY;=
 without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A=
 PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more de=
tails=2E
+ *
+ *  You should have received a copy of the GNU General Public=
 License along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg=
/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
=
+
+#include "syshead=2Eh"
+
+#include "buffer=2Eh"
+#include "crypto=2Eh"
+=
#include "manage=2Eh"
+#include "openvpn=2Eh"
+#include "socket=2Eh"
+#incl=
ude "socket_util=2Eh"
+
+#include "resolve=2Eh"
+
+/*
+ * Convert sockflags=
/getaddr_flags into getaddr_flags
+ */
+unsigned int
+sf2gaf(const unsigned=
 int getaddr_flags, const unsigned int sockflags)
+{
+    if (sockflags & S=
F_HOST_RANDOMIZE)
+    {
+        return getaddr_flags | GETADDR_RANDOMIZE;=

+    }
+    else
+    {
+        return getaddr_flags;
+    }
+}
+
+/*
+ *=
 Functions related to the translation of DNS names to IP addresses=2E
+ */
=
+
+/**
+ * Small helper function for openvpn_getaddrinfo to print the addre=
ss
+ * family when resolving fails
+ */
+static const char *
+getaddrinfo_a=
ddr_family_name(int af)
+{
+    switch (af)
+    {
+        case AF_INET:
+=
            return "[AF_INET]";
+
+        case AF_INET6:
+            retu=
rn "[AF_INET6]";
+    }
+    return "";
+}
+
+/*
+ * Prepend a random strin=
g to hostname to prevent DNS caching=2E
+ * For example, foo=2Ebar=2Egov wo=
uld be modified to <random-chars>=2Efoo=2Ebar=2Egov=2E
+ * Of course, this =
requires explicit support in the DNS server (wildcard)=2E
+ */
+static cons=
t char *
+hostname_randomize(const char *hostname, struct gc_arena *gc)
+{
=
+#define n_rnd_bytes 6
+
+    uint8_t rnd_bytes[n_rnd_bytes];
+    const ch=
ar *rnd_str;
+    struct buffer hname =3D alloc_buf_gc(strlen(hostname) + s=
izeof(rnd_bytes) * 2 + 4, gc);
+
+    prng_bytes(rnd_bytes, sizeof(rnd_byte=
s));
+    rnd_str =3D format_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NU=
LL, gc);
+    buf_printf(&hname, "%s=2E%s", rnd_str, hostname);
+    return=
 BSTR(&hname);
+#undef n_rnd_bytes
+}
+
+/*
+ * Translate IPv4/IPv6 addr or=
 hostname into struct addrinfo
+ * If resolve error, try again for resolve_=
retry_seconds seconds=2E
+ */
+int
+openvpn_getaddrinfo(unsigned int flags,=
 const char *hostname, const char *servname,
+                    int resol=
ve_retry_seconds, struct signal_info *sig_info, int ai_family,
+           =
         struct addrinfo **res)
+{
+    struct addrinfo hints;
+    int sta=
tus;
+    struct signal_info sigrec =3D { 0 };
+    msglvl_t msglevel =3D (=
flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
+    struct gc_arena g=
c =3D gc_new();
+    const char *print_hostname;
+    const char *print_ser=
vname;
+
+    ASSERT(res);
+
+    ASSERT(hostname || servname);
+    ASSERT=
(!(flags & GETADDR_HOST_ORDER));
+
+    if (servname)
+    {
+        print=
_servname =3D servname;
+    }
+    else
+    {
+        print_servname =3D=
 "";
+    }
+
+    if (flags & GETADDR_MSG_VIRT_OUT)
+    {
+        msglev=
el |=3D M_MSG_VIRT_OUT;
+    }
+
+    if ((flags & (GETADDR_FATAL_ON_SIGNAL=
 | GETADDR_WARN_ON_SIGNAL)) && !sig_info)
+    {
+        sig_info =3D &sig=
rec;
+    }
+
+    /* try numeric ip addr first */
+    CLEAR(hints);
+    =
hints=2Eai_flags =3D AI_NUMERICHOST;
+
+    if (flags & GETADDR_PASSIVE)
+ =
   {
+        hints=2Eai_flags |=3D AI_PASSIVE;
+    }
+
+    if (flags & G=
ETADDR_DATAGRAM)
+    {
+        hints=2Eai_socktype =3D SOCK_DGRAM;
+    }=

+    else
+    {
+        hints=2Eai_socktype =3D SOCK_STREAM;
+    }
+
+ =
   /* if hostname is not set, we want to bind to 'ANY', with
+     * the co=
rrect address family - v4-only or v6/v6-dual-stack */
+    if (!hostname)
+=
    {
+        hints=2Eai_family =3D ai_family;
+    }
+
+    status =3D ge=
taddrinfo(hostname, servname, &hints, res);
+
+    if (status !=3D 0)      =
                /* parse as numeric address failed? */
+    {
+        cons=
t int fail_wait_interval =3D 5; /* seconds */
+        /* Add +4 to cause i=
nteger division rounding up (1 + 4) =3D 5, (0+4)/5=3D0 */
+        int reso=
lve_retries =3D
+            (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_ret=
ry_seconds + 4) / fail_wait_interval);
+        const char *fmt;
+        m=
sglvl_t level =3D 0;
+
+        /* this is not a numeric IP, therefore forc=
e resolution using the
+         * provided ai_family */
+        hints=2Ea=
i_family =3D ai_family;
+
+        if (hostname && (flags & GETADDR_RANDOMI=
ZE))
+        {
+            hostname =3D hostname_randomize(hostname, &gc)=
;
+        }
+
+        if (hostname)
+        {
+            print_hostnam=
e =3D hostname;
+        }
+        else
+        {
+            print_host=
name =3D "undefined";
+        }
+
+        fmt =3D "RESOLVE: Cannot resolv=
e host address: %s:%s%s (%s)";
+        if ((flags & GETADDR_MENTION_RESOLV=
E_RETRY) && !resolve_retry_seconds)
+        {
+            fmt =3D "RESOLV=
E: Cannot resolve host address: %s:%s%s (%s)"
+                  "(I would =
have retried this name query if you had "
+                  "specified the=
 --resolv-retry option=2E)";
+        }
+
+        if (!(flags & GETADDR_RE=
SOLVE) || status =3D=3D EAI_FAIL)
+        {
+            msg(msglevel, "RE=
SOLVE: Cannot parse IP address: %s:%s (%s)", print_hostname,
+             =
   print_servname, gai_strerror(status));
+            goto done;
+        =
}
+
+#ifdef ENABLE_MANAGEMENT
+        if (flags & GETADDR_UPDATE_MANAGEMEN=
T_STATE)
+        {
+            if (management)
+            {
+          =
      management_set_state(management, OPENVPN_STATE_RESOLVE, NULL, NULL, N=
ULL, NULL,
+                                     NULL);
+            }
+   =
     }
+#endif
+
+        /*
+         * Resolve hostname
+         */
+   =
     while (true)
+        {
+#ifndef _WIN32
+            /* force resolv=
=2Econf reload */
+            res_init();
+#endif
+            /* try host=
name lookup */
+            hints=2Eai_flags &=3D ~AI_NUMERICHOST;
+       =
     dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=3D0x%04x ai_family=3D%d ai_soc=
ktype=3D%d", flags,
+                 hints=2Eai_family, hints=2Eai_socktyp=
e);
+            status =3D getaddrinfo(hostname, servname, &hints, res);
+=

+            if (sig_info)
+            {
+                get_signal(&sig=
_info->signal_received);
+                if (sig_info->signal_received) /*=
 were we interrupted by a signal? */
+                {
+                  =
  /* why are we overwriting SIGUSR1 ? */
+                    if (signal_re=
set(sig_info, SIGUSR1) =3D=3D SIGUSR1) /* ignore SIGUSR1 */
+              =
      {
+                        msg(level, "RESOLVE: Ignored SIGUSR1 signa=
l received during "
+                                   "DNS resolution att=
empt");
+                    }
+                    else
+                 =
   {
+                        /* turn success into failure (interrupted sys=
call) */
+                        if (0 =3D=3D status)
+                   =
     {
+                            ASSERT(res);
+                         =
   freeaddrinfo(*res);
+                            *res =3D NULL;
+       =
                     status =3D EAI_AGAIN; /* =3D temporary failure */
+   =
                         errno =3D EINTR;
+                        }
+     =
                   goto done;
+                    }
+                }
+  =
          }
+
+            /* success? */
+            if (0 =3D=3D status)=

+            {
+                break;
+            }
+
+            /* re=
solve lookup failed, should we
+             * continue or fail? */
+      =
      level =3D msglevel;
+            if (resolve_retries > 0)
+          =
  {
+                level =3D D_RESOLVE_ERRORS;
+            }
+
+        =
    msg(level, fmt, print_hostname, print_servname, getaddrinfo_addr_family=
_name(ai_family),
+                gai_strerror(status));
+
+            if=
 (--resolve_retries <=3D 0)
+            {
+                goto done;
+   =
         }
+
+            management_sleep(fail_wait_interval);
+        }
=
+
+        ASSERT(res);
+
+        /* hostname resolve succeeded */
+
+    =
    /*
+         * Do not choose an IP Addresse by random or change the ord=
er *
+         * of IP addresses, doing so will break RFC 3484 address sele=
ction *
+         */
+    }
+    else
+    {
+        /* IP address parse s=
ucceeded */
+        if (flags & GETADDR_RANDOMIZE)
+        {
+           =
 msg(M_WARN, "WARNING: ignoring --remote-random-hostname because the "
+   =
                     "hostname is an IP address");
+        }
+    }
+
+don=
e:
+    if (sig_info && sig_info->signal_received)
+    {
+        msglvl_t=
 level =3D 0;
+        if (flags & GETADDR_FATAL_ON_SIGNAL)
+        {
+   =
         level =3D M_FATAL;
+        }
+        else if (flags & GETADDR_WA=
RN_ON_SIGNAL)
+        {
+            level =3D M_WARN;
+        }
+       =
 msg(level, "RESOLVE: signal received during DNS resolution attempt");
+   =
 }
+
+    gc_free(&gc);
+    return status;
+}
+
+static int
+get_addr_gene=
ric(sa_family_t af, unsigned int flags, const char *hostname, void *network=
,
+                 unsigned int *netbits, int resolve_retry_seconds, struc=
t signal_info *sig_info,
+                 msglvl_t msglevel)
+{
+    char =
*endp, *sep, *var_host =3D NULL;
+    struct addrinfo *ai =3D NULL;
+    un=
signed long bits;
+    uint8_t max_bits;
+    int ret =3D -1;
+
+    if (!h=
ostname)
+    {
+        msg(M_NONFATAL, "Can't resolve null hostname!");
+=
        goto out;
+    }
+
+    /* assign family specific default values */=

+    switch (af)
+    {
+        case AF_INET:
+            bits =3D 0;
+ =
           max_bits =3D sizeof(in_addr_t) * 8;
+            break;
+
+     =
   case AF_INET6:
+            bits =3D 64;
+            max_bits =3D sizeo=
f(struct in6_addr) * 8;
+            break;
+
+        default:
+          =
  msg(M_WARN, "Unsupported AF family passed to getaddrinfo for %s (%d)", ho=
stname, af);
+            goto out;
+    }
+
+    /* we need to modify the =
hostname received as input, but we don't want to
+     * touch it directly =
as it might be a constant string=2E
+     *
+     * Therefore, we clone the=
 string here and free it at the end of the
+     * function */
+    var_hos=
t =3D strdup(hostname);
+    if (!var_host)
+    {
+        msg(M_NONFATAL =
| M_ERRNO, "Can't allocate hostname buffer for getaddrinfo");
+        goto=
 out;
+    }
+
+    /* check if this hostname has a /bits suffix */
+    se=
p =3D strchr(var_host, '/');
+    if (sep)
+    {
+        bits =3D strtoul=
(sep + 1, &endp, 10);
+        if ((*endp !=3D '\0') || (bits > max_bits))
=
+        {
+            msg(msglevel, "IP prefix '%s': invalid '/bits' spec=
 (%s)", hostname, sep + 1);
+            goto out;
+        }
+        *sep=
 =3D '\0';
+    }
+
+    ret =3D openvpn_getaddrinfo(flags & ~GETADDR_HOST_=
ORDER, var_host, NULL, resolve_retry_seconds,
+                            =
  sig_info, af, &ai);
+    if ((ret =3D=3D 0) && network)
+    {
+        s=
truct in6_addr *ip6;
+        in_addr_t *ip4;
+
+        if (af !=3D ai->ai=
_family)
+        {
+            msg(msglevel, "Can't parse %s as IPv%d add=
ress", var_host, (af =3D=3D AF_INET) ? 4 : 6);
+            ret =3D -1;
+  =
          goto out;
+        }
+
+        switch (af)
+        {
+         =
   case AF_INET:
+                ip4 =3D network;
+                *ip4 =
=3D ((struct sockaddr_in *)ai->ai_addr)->sin_addr=2Es_addr;
+
+            =
    if (flags & GETADDR_HOST_ORDER)
+                {
+                   =
 *ip4 =3D ntohl(*ip4);
+                }
+                break;
+
+      =
      case AF_INET6:
+                ip6 =3D network;
+                *ip=
6 =3D ((struct sockaddr_in6 *)ai->ai_addr)->sin6_addr;
+                bre=
ak;
+
+            default:
+                /* can't get here because 'af'=
 was previously checked */
+                msg(M_WARN, "Unsupported AF fam=
ily for %s (%d)", var_host, af);
+                goto out;
+        }
+   =
 }
+
+    if (netbits)
+    {
+        *netbits =3D (unsigned int)bits;
+  =
  }
+
+    /* restore '/' separator, if any */
+    if (sep)
+    {
+      =
  *sep =3D '/';
+    }
+out:
+    if (ai)
+    {
+        freeaddrinfo(ai);=

+    }
+    free(var_host);
+
+    return ret;
+}
+
+in_addr_t
+getaddr(un=
signed int flags, const char *hostname, int resolve_retry_seconds, bool *su=
cceeded,
+        struct signal_info *sig_info)
+{
+    in_addr_t addr =3D =
{ 0 };
+    int status;
+
+    status =3D get_addr_generic(AF_INET, flags, =
hostname, &addr, NULL, resolve_retry_seconds,
+                            =
  sig_info, M_WARN);
+    if (status =3D=3D 0)
+    {
+        if (succeede=
d)
+        {
+            *succeeded =3D true;
+        }
+        return =
addr;
+    }
+    else
+    {
+        if (succeeded)
+        {
+         =
   *succeeded =3D false;
+        }
+        return 0;
+    }
+}
+
+in_addr=
_t
+get_ip_addr(const char *ip_string, msglvl_t msglevel, bool *error)
+{
+=
    unsigned int flags =3D GETADDR_HOST_ORDER;
+    bool succeeded =3D fals=
e;
+    in_addr_t ret;
+
+    if (msglevel & M_FATAL)
+    {
+        flags=
 |=3D GETADDR_FATAL;
+    }
+
+    ret =3D getaddr(flags, ip_string, 0, &su=
cceeded, NULL);
+    if (!succeeded && error)
+    {
+        *error =3D tr=
ue;
+    }
+    return ret;
+}
+
+bool
+get_ipv6_addr(const char *hostname,=
 struct in6_addr *network, unsigned int *netbits,
+              msglvl_t m=
sglevel)
+{
+    if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, =
network, netbits, 0, NULL, msglevel)
+        < 0)
+    {
+        return f=
alse;
+    }
+
+    return true; /* parsing OK, values set */
+}
+
+/*
+ * =
get_cached_dns_entry return 0 on success and -1
+ * otherwise=2E (like geta=
ddrinfo)
+ */
+int
+get_cached_dns_entry(struct cached_dns_entry *dns_cache=
, const char *hostname, const char *servname,
+                     int ai_=
family, unsigned int resolve_flags, struct addrinfo **ai)
+{
+    struct ca=
ched_dns_entry *ph;
+    unsigned int flags;
+
+    /* Only use flags that =
are relevant for the structure */
+    flags =3D resolve_flags & GETADDR_CA=
CHE_MASK;
+
+    for (ph =3D dns_cache; ph; ph =3D ph->next)
+    {
+      =
  if (streqnull(ph->hostname, hostname) && streqnull(ph->servname, servname=
)
+            && ph->ai_family =3D=3D ai_family && ph->flags =3D=3D flags)=

+        {
+            *ai =3D ph->ai;
+            return 0;
+        }
=
+    }
+    return -1;
+}
+
+
+static int
+do_preresolve_host(struct contex=
t *c, const char *hostname, const char *servname, const int af,
+          =
         const unsigned int flags)
+{
+    struct addrinfo *ai;
+    int st=
atus;
+
+    if (get_cached_dns_entry(c->c1=2Edns_cache, hostname, servname=
, af, flags, &ai) =3D=3D 0)
+    {
+        /* entry already cached, return=
 success */
+        return 0;
+    }
+
+    status =3D openvpn_getaddrinfo=
(flags, hostname, servname, c->options=2Eresolve_retry_seconds, NULL,
+    =
                             af, &ai);
+    if (status =3D=3D 0)
+    {
+  =
      struct cached_dns_entry *ph;
+
+        ALLOC_OBJ_CLEAR_GC(ph, struct=
 cached_dns_entry, &c->gc);
+        ph->ai =3D ai;
+        ph->hostname =
=3D hostname;
+        ph->servname =3D servname;
+        ph->flags =3D fl=
ags & GETADDR_CACHE_MASK;
+
+        if (!c->c1=2Edns_cache)
+        {
+  =
          c->c1=2Edns_cache =3D ph;
+        }
+        else
+        {
+  =
          struct cached_dns_entry *prev =3D c->c1=2Edns_cache;
+           =
 while (prev->next)
+            {
+                prev =3D prev->next;
+ =
           }
+            prev->next =3D ph;
+        }
+
+        gc_addsp=
ecial(ai, &gc_freeaddrinfo_callback, &c->gc);
+    }
+    return status;
+}=

+
+void
+do_preresolve(struct context *c)
+{
+    struct connection_list *=
l =3D c->options=2Econnection_list;
+    const unsigned int preresolve_flag=
s =3D GETADDR_RESOLVE | GETADDR_UPDATE_MANAGEMENT_STATE
+                  =
                        | GETADDR_MENTION_RESOLVE_RETRY | GETADDR_FATAL;
+
=
+
+    for (int i =3D 0; i < l->len; ++i)
+    {
+        int status;
+    =
    const char *remote;
+        unsigned int flags =3D preresolve_flags;
+=

+        struct connection_entry *ce =3D l->array[i];
+
+        if (proto=
_is_dgram(ce->proto))
+        {
+            flags |=3D GETADDR_DATAGRAM;
=
+        }
+
+        if (c->options=2Esockflags & SF_HOST_RANDOMIZE)
+    =
    {
+            flags |=3D GETADDR_RANDOMIZE;
+        }
+
+        if (=
c->options=2Eip_remote_hint)
+        {
+            remote =3D c->options=
=2Eip_remote_hint;
+        }
+        else
+        {
+            remote =
=3D ce->remote;
+        }
+
+        /* HTTP remote hostname does not need=
 to be resolved */
+        if (!ce->http_proxy_options)
+        {
+      =
      status =3D do_preresolve_host(c, remote, ce->remote_port, ce->af, fla=
gs);
+            if (status !=3D 0)
+            {
+                goto e=
rr;
+            }
+        }
+
+        /* Preresolve proxy */
+        if=
 (ce->http_proxy_options)
+        {
+            status =3D do_preresolve_=
host(c, ce->http_proxy_options->server,
+                                  =
      ce->http_proxy_options->port, ce->af, preresolve_flags);
+
+         =
   if (status !=3D 0)
+            {
+                goto err;
+          =
  }
+        }
+
+        if (ce->socks_proxy_server)
+        {
+         =
   status =3D
+                do_preresolve_host(c, ce->socks_proxy_server=
, ce->socks_proxy_port, ce->af, flags);
+            if (status !=3D 0)
+  =
          {
+                goto err;
+            }
+        }
+
+       =
 if (ce->bind_local)
+        {
+            flags |=3D GETADDR_PASSIVE;
+ =
           flags &=3D ~GETADDR_RANDOMIZE;
+
+            for (int j =3D 0; =
j < ce->local_list->len; j++)
+            {
+                const struct =
local_entry *le =3D ce->local_list->array[j];
+
+                if (!le->l=
ocal)
+                {
+                    continue;
+                }
=
+
+                status =3D do_preresolve_host(c, le->local, le->port, ce=
->af, flags);
+                if (status !=3D 0)
+                {
+     =
               goto err;
+                }
+            }
+        }
+    =
}
+    return;
+
+err:
+    throw_signal_soft(SIGHUP, "Preresolving failed"=
);
+}
diff --git a/src/openvpn/resolve=2Eh b/src/openvpn/resolve=2Eh
new fi=
le mode 100644
index 0000000=2E=2E9069af7
--- /dev/null
+++ b/src/openvpn/r=
esolve=2Eh
@@ -0,0 +1,106 @@
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
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sa=
les@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistri=
bute it and/or modify
+ *  it under the terms of the GNU General Public Lic=
ense version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *=
  This program is distributed in the hope that it will be useful,
+ *  but =
WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABI=
LITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Publi=
c License for more details=2E
+ *
+ *  You should have received a copy of t=
he GNU General Public License along
+ *  with this program; if not, see <ht=
tps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * DNS resolutio=
n
+ */
+#ifndef RESOLVE_H
+#define RESOLVE_H
+
+#ifdef HAVE_CONFIG_H
+#incl=
ude "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "sig=2Eh"
+
=
+#define GETADDR_RESOLVE                 (1u << 0)
+#define GETADDR_FATAL  =
                 (1u << 1)
+#define GETADDR_HOST_ORDER              (1u << =
2)
+#define GETADDR_MENTION_RESOLVE_RETRY   (1u << 3)
+#define GETADDR_FATA=
L_ON_SIGNAL         (1u << 4)
+#define GETADDR_WARN_ON_SIGNAL          (1u =
<< 5)
+#define GETADDR_MSG_VIRT_OUT            (1u << 6)
+#define GETADDR_T=
RY_ONCE                (1u << 7)
+#define GETADDR_UPDATE_MANAGEMENT_STATE (=
1u << 8)
+#define GETADDR_RANDOMIZE               (1u << 9)
+#define GETADD=
R_PASSIVE                 (1u << 10)
+#define GETADDR_DATAGRAM             =
   (1u << 11)
+
+#define GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PAS=
SIVE)
+
+/**
+ * Convert sockflags/getaddr_flags into getaddr_flags
+ */
+u=
nsigned int sf2gaf(const unsigned int getaddr_flags, const unsigned int soc=
kflags);
+
+/**
+ * Translate an IPv4 addr or hostname from string form to =
in_addr_t
+ *
+ * In case of resolve error, it will try again for
+ * resol=
ve_retry_seconds seconds=2E
+ */
+in_addr_t getaddr(unsigned int flags, con=
st char *hostname, int resolve_retry_seconds,
+                  bool *succ=
eeded, struct signal_info *sig_info);
+
+in_addr_t get_ip_addr(const char *=
ip_string, msglvl_t msglevel, bool *error);
+
+/**
+ * Translate an IPv6 ad=
dr or hostname from string form to in6_addr
+ */
+bool get_ipv6_addr(const =
char *hostname, struct in6_addr *network, unsigned int *netbits,
+         =
          msglvl_t msglevel);
+
+static inline bool
+ipv6_addr_safe_hexplus=
bits(const char *ipv6_prefix_spec)
+{
+    return get_ipv6_addr(ipv6_prefix=
_spec, NULL, NULL, M_WARN);
+}
+
+int openvpn_getaddrinfo(unsigned int flag=
s, const char *hostname, const char *servname,
+                        int=
 resolve_retry_seconds, struct signal_info *sig_info, int ai_family,
+     =
                   struct addrinfo **res);
+
+void do_preresolve(struct con=
text *c);
+
+/* struct to hold preresolved host names */
+struct cached_dns=
_entry
+{
+    const char *hostname;
+    const char *servname;
+    int ai=
_family;
+    unsigned int flags;
+    struct addrinfo *ai;
+    struct cac=
hed_dns_entry *next;
+};
+
+/**
+ * get_cached_dns_entry return 0 on succes=
s and -1
+ * otherwise=2E (like getaddrinfo())
+ */
+int get_cached_dns_ent=
ry(struct cached_dns_entry *dns_cache, const char *hostname,
+             =
            const char *servname, int ai_family,
+                         =
unsigned int resolve_flags, struct addrinfo **ai);
+
+#endif /* RESOLVE_H *=
/
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 33b2387=
=2E=2E1077e83 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2E=
c
@@ -42,6 +42,7 @@
 #include "options=2Eh"
 #include "networking=2Eh"
 #in=
clude "integer=2Eh"
+#include "resolve=2Eh"
 
 #include "memdbg=2Eh"
 
diff=
 --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 33def4e=2E=
=2E386f395 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec=

@@ -38,6 +38,7 @@
 #include "manage=2Eh"
 #include "openvpn=2Eh"
 #include=
 "forward=2Eh"
+#include "resolve=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -54,36=
6 +55,6 @@
     return false;
 }
 
-/*
- * Convert sockflags/getaddr_flags =
into getaddr_flags
- */
-static unsigned int
-sf2gaf(const unsigned int get=
addr_flags, const unsigned int sockflags)
-{
-    if (sockflags & SF_HOST_R=
ANDOMIZE)
-    {
-        return getaddr_flags | GETADDR_RANDOMIZE;
-    }
=
-    else
-    {
-        return getaddr_flags;
-    }
-}
-
-/*
- * Functio=
ns related to the translation of DNS names to IP addresses=2E
- */
-static =
int
-get_addr_generic(sa_family_t af, unsigned int flags, const char *hostn=
ame, void *network,
-                 unsigned int *netbits, int resolve_re=
try_seconds, struct signal_info *sig_info,
-                 msglvl_t msgle=
vel)
-{
-    char *endp, *sep, *var_host =3D NULL;
-    struct addrinfo *ai=
 =3D NULL;
-    unsigned long bits;
-    uint8_t max_bits;
-    int ret =3D=
 -1;
-
-    if (!hostname)
-    {
-        msg(M_NONFATAL, "Can't resolve n=
ull hostname!");
-        goto out;
-    }
-
-    /* assign family specific=
 default values */
-    switch (af)
-    {
-        case AF_INET:
-        =
    bits =3D 0;
-            max_bits =3D sizeof(in_addr_t) * 8;
-         =
   break;
-
-        case AF_INET6:
-            bits =3D 64;
-            =
max_bits =3D sizeof(struct in6_addr) * 8;
-            break;
-
-        de=
fault:
-            msg(M_WARN, "Unsupported AF family passed to getaddrinf=
o for %s (%d)", hostname, af);
-            goto out;
-    }
-
-    /* we n=
eed to modify the hostname received as input, but we don't want to
-     * =
touch it directly as it might be a constant string=2E
-     *
-     * There=
fore, we clone the string here and free it at the end of the
-     * functi=
on */
-    var_host =3D strdup(hostname);
-    if (!var_host)
-    {
-     =
   msg(M_NONFATAL | M_ERRNO, "Can't allocate hostname buffer for getaddrinf=
o");
-        goto out;
-    }
-
-    /* check if this hostname has a /bits=
 suffix */
-    sep =3D strchr(var_host, '/');
-    if (sep)
-    {
-      =
  bits =3D strtoul(sep + 1, &endp, 10);
-        if ((*endp !=3D '\0') || (=
bits > max_bits))
-        {
-            msg(msglevel, "IP prefix '%s': in=
valid '/bits' spec (%s)", hostname, sep + 1);
-            goto out;
-     =
   }
-        *sep =3D '\0';
-    }
-
-    ret =3D openvpn_getaddrinfo(flag=
s & ~GETADDR_HOST_ORDER, var_host, NULL, resolve_retry_seconds,
-          =
                    sig_info, af, &ai);
-    if ((ret =3D=3D 0) && network)=

-    {
-        struct in6_addr *ip6;
-        in_addr_t *ip4;
-
-        =
if (af !=3D ai->ai_family)
-        {
-            msg(msglevel, "Can't par=
se %s as IPv%d address", var_host, (af =3D=3D AF_INET) ? 4 : 6);
-         =
   ret =3D -1;
-            goto out;
-        }
-
-        switch (af)
-  =
      {
-            case AF_INET:
-                ip4 =3D network;
-     =
           *ip4 =3D ((struct sockaddr_in *)ai->ai_addr)->sin_addr=2Es_addr;=

-
-                if (flags & GETADDR_HOST_ORDER)
-                {
-   =
                 *ip4 =3D ntohl(*ip4);
-                }
-                =
break;
-
-            case AF_INET6:
-                ip6 =3D network;
-   =
             *ip6 =3D ((struct sockaddr_in6 *)ai->ai_addr)->sin6_addr;
-   =
             break;
-
-            default:
-                /* can't get h=
ere because 'af' was previously checked */
-                msg(M_WARN, "Un=
supported AF family for %s (%d)", var_host, af);
-                goto out;=

-        }
-    }
-
-    if (netbits)
-    {
-        *netbits =3D (unsign=
ed int)bits;
-    }
-
-    /* restore '/' separator, if any */
-    if (sep=
)
-    {
-        *sep =3D '/';
-    }
-out:
-    if (ai)
-    {
-        f=
reeaddrinfo(ai);
-    }
-    free(var_host);
-
-    return ret;
-}
-
-in_ad=
dr_t
-getaddr(unsigned int flags, const char *hostname, int resolve_retry_s=
econds, bool *succeeded,
-        struct signal_info *sig_info)
-{
-    in_=
addr_t addr =3D { 0 };
-    int status;
-
-    status =3D get_addr_generic(=
AF_INET, flags, hostname, &addr, NULL, resolve_retry_seconds,
-            =
                  sig_info, M_WARN);
-    if (status =3D=3D 0)
-    {
-    =
    if (succeeded)
-        {
-            *succeeded =3D true;
-        }
=
-        return addr;
-    }
-    else
-    {
-        if (succeeded)
-    =
    {
-            *succeeded =3D false;
-        }
-        return 0;
-   =
 }
-}
-
-bool
-get_ipv6_addr(const char *hostname, struct in6_addr *network=
, unsigned int *netbits,
-              msglvl_t msglevel)
-{
-    if (get_=
addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, netbits, 0, NULL=
, msglevel)
-        < 0)
-    {
-        return false;
-    }
-
-    retur=
n true; /* parsing OK, values set */
-}
-
-static inline bool
-streqnull(co=
nst char *a, const char *b)
-{
-    if (a =3D=3D NULL && b =3D=3D NULL)
-  =
  {
-        return true;
-    }
-    else if (a =3D=3D NULL || b =3D=3D NU=
LL)
-    {
-        return false;
-    }
-    else
-    {
-        return s=
treq(a, b);
-    }
-}
-
-/*
- * get_cached_dns_entry return 0 on success an=
d -1
- * otherwise=2E (like getaddrinfo)
- */
-static int
-get_cached_dns_e=
ntry(struct cached_dns_entry *dns_cache, const char *hostname, const char *=
servname,
-                     int ai_family, unsigned int resolve_flags, =
struct addrinfo **ai)
-{
-    struct cached_dns_entry *ph;
-    unsigned in=
t flags;
-
-    /* Only use flags that are relevant for the structure */
- =
   flags =3D resolve_flags & GETADDR_CACHE_MASK;
-
-    for (ph =3D dns_cac=
he; ph; ph =3D ph->next)
-    {
-        if (streqnull(ph->hostname, hostna=
me) && streqnull(ph->servname, servname)
-            && ph->ai_family =3D=
=3D ai_family && ph->flags =3D=3D flags)
-        {
-            *ai =3D ph=
->ai;
-            return 0;
-        }
-    }
-    return -1;
-}
-
-
-stat=
ic int
-do_preresolve_host(struct context *c, const char *hostname, const c=
har *servname, const int af,
-                   const unsigned int flags)
=
-{
-    struct addrinfo *ai;
-    int status;
-
-    if (get_cached_dns_ent=
ry(c->c1=2Edns_cache, hostname, servname, af, flags, &ai) =3D=3D 0)
-    {
=
-        /* entry already cached, return success */
-        return 0;
-   =
 }
-
-    status =3D openvpn_getaddrinfo(flags, hostname, servname, c->opti=
ons=2Eresolve_retry_seconds, NULL,
-                                 af, &a=
i);
-    if (status =3D=3D 0)
-    {
-        struct cached_dns_entry *ph;
=
-
-        ALLOC_OBJ_CLEAR_GC(ph, struct cached_dns_entry, &c->gc);
-      =
  ph->ai =3D ai;
-        ph->hostname =3D hostname;
-        ph->servname =
=3D servname;
-        ph->flags =3D flags & GETADDR_CACHE_MASK;
-
-       =
 if (!c->c1=2Edns_cache)
-        {
-            c->c1=2Edns_cache =3D ph;
=
-        }
-        else
-        {
-            struct cached_dns_entry *p=
rev =3D c->c1=2Edns_cache;
-            while (prev->next)
-            {
-=
                prev =3D prev->next;
-            }
-            prev->next=
 =3D ph;
-        }
-
-        gc_addspecial(ai, &gc_freeaddrinfo_callback,=
 &c->gc);
-    }
-    return status;
-}
-
-void
-do_preresolve(struct conte=
xt *c)
-{
-    struct connection_list *l =3D c->options=2Econnection_list;
=
-    const unsigned int preresolve_flags =3D GETADDR_RESOLVE | GETADDR_UPDA=
TE_MANAGEMENT_STATE
-                                          | GETADDR_ME=
NTION_RESOLVE_RETRY | GETADDR_FATAL;
-
-
-    for (int i =3D 0; i < l->len;=
 ++i)
-    {
-        int status;
-        const char *remote;
-        uns=
igned int flags =3D preresolve_flags;
-
-        struct connection_entry *c=
e =3D l->array[i];
-
-        if (proto_is_dgram(ce->proto))
-        {
-  =
          flags |=3D GETADDR_DATAGRAM;
-        }
-
-        if (c->options=
=2Esockflags & SF_HOST_RANDOMIZE)
-        {
-            flags |=3D GETADD=
R_RANDOMIZE;
-        }
-
-        if (c->options=2Eip_remote_hint)
-      =
  {
-            remote =3D c->options=2Eip_remote_hint;
-        }
-      =
  else
-        {
-            remote =3D ce->remote;
-        }
-
-       =
 /* HTTP remote hostname does not need to be resolved */
-        if (!ce->=
http_proxy_options)
-        {
-            status =3D do_preresolve_host(c=
, remote, ce->remote_port, ce->af, flags);
-            if (status !=3D 0)
=
-            {
-                goto err;
-            }
-        }
-
-    =
    /* Preresolve proxy */
-        if (ce->http_proxy_options)
-        {
=
-            status =3D do_preresolve_host(c, ce->http_proxy_options->serve=
r,
-                                        ce->http_proxy_options->port, c=
e->af, preresolve_flags);
-
-            if (status !=3D 0)
-            {
=
-                goto err;
-            }
-        }
-
-        if (ce->soc=
ks_proxy_server)
-        {
-            status =3D
-                do_pre=
resolve_host(c, ce->socks_proxy_server, ce->socks_proxy_port, ce->af, flags=
);
-            if (status !=3D 0)
-            {
-                goto err=
;
-            }
-        }
-
-        if (ce->bind_local)
-        {
-    =
        flags |=3D GETADDR_PASSIVE;
-            flags &=3D ~GETADDR_RANDOM=
IZE;
-
-            for (int j =3D 0; j < ce->local_list->len; j++)
-      =
      {
-                const struct local_entry *le =3D ce->local_list->a=
rray[j];
-
-                if (!le->local)
-                {
-           =
         continue;
-                }
-
-                status =3D do_prer=
esolve_host(c, le->local, le->port, ce->af, flags);
-                if (st=
atus !=3D 0)
-                {
-                    goto err;
-           =
     }
-            }
-        }
-    }
-    return;
-
-err:
-    throw_sig=
nal_soft(SIGHUP, "Preresolving failed");
-}
-
 static int
 socket_get_sndbu=
f(socket_descriptor_t sd)
 {
diff --git a/src/openvpn/socket=2Eh b/src/open=
vpn/socket=2Eh
index 46fa29c=2E=2Ebef228c 100644
--- a/src/openvpn/socket=
=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -62,17 +62,6 @@
 /* convert a packet_s=
ize_type from network to host order */
 #define ntohps(x) ntohs(x)
 
-/* st=
ruct to hold preresolved host names */
-struct cached_dns_entry
-{
-    con=
st char *hostname;
-    const char *servname;
-    int ai_family;
-    unsi=
gned int flags;
-    struct addrinfo *ai;
-    struct cached_dns_entry *nex=
t;
-};
-
 /* IP addresses which are persistent across SIGUSR1s */
 struct l=
ink_socket_addr
 {
@@ -362,8 +351,6 @@
 
 void link_socket_init_phase2(stru=
ct context *c, struct link_socket *sock);
 
-void do_preresolve(struct cont=
ext *c);
-
 void link_socket_close(struct link_socket *sock);
 
 #ifdef ENA=
BLE_MANAGEMENT
diff --git a/src/openvpn/socket_util=2Ec b/src/openvpn/socke=
t_util=2Ec
index 913ac69=2E=2E879be73 100644
--- a/src/openvpn/socket_util=
=2Ec
+++ b/src/openvpn/socket_util=2Ec
@@ -490,271 +490,6 @@
     return ""=
; /* Make the compiler happy */
 }
 
-/**
- * Small helper function for ope=
nvpn_getaddrinfo to print the address
- * family when resolving fails
- */
=
-static const char *
-getaddrinfo_addr_family_name(int af)
-{
-    switch (=
af)
-    {
-        case AF_INET:
-            return "[AF_INET]";
-
-     =
   case AF_INET6:
-            return "[AF_INET6]";
-    }
-    return "";
=
-}
-
-/*
- * Prepend a random string to hostname to prevent DNS caching=2E
=
- * For example, foo=2Ebar=2Egov would be modified to <random-chars>=2Efoo=
=2Ebar=2Egov=2E
- * Of course, this requires explicit support in the DNS se=
rver (wildcard)=2E
- */
-static const char *
-hostname_randomize(const char=
 *hostname, struct gc_arena *gc)
-{
-#define n_rnd_bytes 6
-
-    uint8_t r=
nd_bytes[n_rnd_bytes];
-    const char *rnd_str;
-    struct buffer hname =
=3D alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes) * 2 + 4, gc);
-
-    =
prng_bytes(rnd_bytes, sizeof(rnd_bytes));
-    rnd_str =3D format_hex_ex(rn=
d_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);
-    buf_printf(&hname, "%s=
=2E%s", rnd_str, hostname);
-    return BSTR(&hname);
-#undef n_rnd_bytes
-=
}
-
-/*
- * Translate IPv4/IPv6 addr or hostname into struct addrinfo
- * I=
f resolve error, try again for resolve_retry_seconds seconds=2E
- */
-int
-=
openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char *s=
ervname,
-                    int resolve_retry_seconds, struct signal_info=
 *sig_info, int ai_family,
-                    struct addrinfo **res)
-{
-=
    struct addrinfo hints;
-    int status;
-    struct signal_info sigrec =
=3D { 0 };
-    msglvl_t msglevel =3D (flags & GETADDR_FATAL) ? M_FATAL : D=
_RESOLVE_ERRORS;
-    struct gc_arena gc =3D gc_new();
-    const char *pri=
nt_hostname;
-    const char *print_servname;
-
-    ASSERT(res);
-
-    AS=
SERT(hostname || servname);
-    ASSERT(!(flags & GETADDR_HOST_ORDER));
-
-=
    if (servname)
-    {
-        print_servname =3D servname;
-    }
-    =
else
-    {
-        print_servname =3D "";
-    }
-
-    if (flags & GETAD=
DR_MSG_VIRT_OUT)
-    {
-        msglevel |=3D M_MSG_VIRT_OUT;
-    }
-
-  =
  if ((flags & (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) && !sig_=
info)
-    {
-        sig_info =3D &sigrec;
-    }
-
-    /* try numeric ip=
 addr first */
-    CLEAR(hints);
-    hints=2Eai_flags =3D AI_NUMERICHOST;=

-
-    if (flags & GETADDR_PASSIVE)
-    {
-        hints=2Eai_flags |=3D =
AI_PASSIVE;
-    }
-
-    if (flags & GETADDR_DATAGRAM)
-    {
-        hin=
ts=2Eai_socktype =3D SOCK_DGRAM;
-    }
-    else
-    {
-        hints=2Ea=
i_socktype =3D SOCK_STREAM;
-    }
-
-    /* if hostname is not set, we wan=
t to bind to 'ANY', with
-     * the correct address family - v4-only or v6=
/v6-dual-stack */
-    if (!hostname)
-    {
-        hints=2Eai_family =3D=
 ai_family;
-    }
-
-    status =3D getaddrinfo(hostname, servname, &hints=
, res);
-
-    if (status !=3D 0)                      /* parse as numeric =
address failed? */
-    {
-        const int fail_wait_interval =3D 5; /* s=
econds */
-        /* Add +4 to cause integer division rounding up (1 + 4) =
=3D 5, (0+4)/5=3D0 */
-        int resolve_retries =3D
-            (flags =
& GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval=
);
-        const char *fmt;
-        msglvl_t level =3D 0;
-
-        /* t=
his is not a numeric IP, therefore force resolution using the
-         * p=
rovided ai_family */
-        hints=2Eai_family =3D ai_family;
-
-        i=
f (hostname && (flags & GETADDR_RANDOMIZE))
-        {
-            hostnam=
e =3D hostname_randomize(hostname, &gc);
-        }
-
-        if (hostname=
)
-        {
-            print_hostname =3D hostname;
-        }
-        =
else
-        {
-            print_hostname =3D "undefined";
-        }
-
-=
        fmt =3D "RESOLVE: Cannot resolve host address: %s:%s%s (%s)";
-    =
    if ((flags & GETADDR_MENTION_RESOLVE_RETRY) && !resolve_retry_seconds)
=
-        {
-            fmt =3D "RESOLVE: Cannot resolve host address: %s:%=
s%s (%s)"
-                  "(I would have retried this name query if you =
had "
-                  "specified the --resolv-retry option=2E)";
-      =
  }
-
-        if (!(flags & GETADDR_RESOLVE) || status =3D=3D EAI_FAIL)
- =
       {
-            msg(msglevel, "RESOLVE: Cannot parse IP address: %s:%=
s (%s)", print_hostname,
-                print_servname, gai_strerror(stat=
us));
-            goto done;
-        }
-
-#ifdef ENABLE_MANAGEMENT
-     =
   if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
-        {
-            if =
(management)
-            {
-                management_set_state(managemen=
t, OPENVPN_STATE_RESOLVE, NULL, NULL, NULL, NULL,
-                        =
             NULL);
-            }
-        }
-#endif
-
-        /*
-      =
   * Resolve hostname
-         */
-        while (true)
-        {
-#ifnde=
f _WIN32
-            /* force resolv=2Econf reload */
-            res_ini=
t();
-#endif
-            /* try hostname lookup */
-            hints=2Eai=
_flags &=3D ~AI_NUMERICHOST;
-            dmsg(D_SOCKET_DEBUG, "GETADDRINFO=
 flags=3D0x%04x ai_family=3D%d ai_socktype=3D%d", flags,
-                 =
hints=2Eai_family, hints=2Eai_socktype);
-            status =3D getaddrinf=
o(hostname, servname, &hints, res);
-
-            if (sig_info)
-         =
   {
-                get_signal(&sig_info->signal_received);
-            =
    if (sig_info->signal_received) /* were we interrupted by a signal? */
-=
                {
-                    /* why are we overwriting SIGUSR1 ? =
*/
-                    if (signal_reset(sig_info, SIGUSR1) =3D=3D SIGUSR1)=
 /* ignore SIGUSR1 */
-                    {
-                        msg(l=
evel, "RESOLVE: Ignored SIGUSR1 signal received during "
-                 =
                  "DNS resolution attempt");
-                    }
-      =
              else
-                    {
-                        /* turn =
success into failure (interrupted syscall) */
-                        if (=
0 =3D=3D status)
-                        {
-                            AS=
SERT(res);
-                            freeaddrinfo(*res);
-              =
              *res =3D NULL;
-                            status =3D EAI_AG=
AIN; /* =3D temporary failure */
-                            errno =3D EIN=
TR;
-                        }
-                        goto done;
-       =
             }
-                }
-            }
-
-            /* success?=
 */
-            if (0 =3D=3D status)
-            {
-                break=
;
-            }
-
-            /* resolve lookup failed, should we
-      =
       * continue or fail? */
-            level =3D msglevel;
-           =
 if (resolve_retries > 0)
-            {
-                level =3D D_RESOL=
VE_ERRORS;
-            }
-
-            msg(level, fmt, print_hostname, pr=
int_servname, getaddrinfo_addr_family_name(ai_family),
-                gai=
_strerror(status));
-
-            if (--resolve_retries <=3D 0)
-         =
   {
-                goto done;
-            }
-
-            management_s=
leep(fail_wait_interval);
-        }
-
-        ASSERT(res);
-
-        /* =
hostname resolve succeeded */
-
-        /*
-         * Do not choose an IP=
 Addresse by random or change the order *
-         * of IP addresses, doin=
g so will break RFC 3484 address selection *
-         */
-    }
-    else
=
-    {
-        /* IP address parse succeeded */
-        if (flags & GETAD=
DR_RANDOMIZE)
-        {
-            msg(M_WARN, "WARNING: ignoring --remo=
te-random-hostname because the "
-                        "hostname is an I=
P address");
-        }
-    }
-
-done:
-    if (sig_info && sig_info->sign=
al_received)
-    {
-        msglvl_t level =3D 0;
-        if (flags & GET=
ADDR_FATAL_ON_SIGNAL)
-        {
-            level =3D M_FATAL;
-        }=

-        else if (flags & GETADDR_WARN_ON_SIGNAL)
-        {
-            =
level =3D M_WARN;
-        }
-        msg(level, "RESOLVE: signal received =
during DNS resolution attempt");
-    }
-
-    gc_free(&gc);
-    return st=
atus;
-}
-
 /*
  * We do our own inet_aton because the glibc function
  * i=
sn't very good about error checking=2E
diff --git a/src/openvpn/socket_util=
=2Eh b/src/openvpn/socket_util=2Eh
index 13f5962=2E=2E038ec36 100644
--- a/=
src/openvpn/socket_util=2Eh
+++ b/src/openvpn/socket_util=2Eh
@@ -110,44 +1=
10,6 @@
 void setenv_link_socket_actual(struct env_set *es, const char *nam=
e_prefix,
                                const struct link_socket_actual *=
act, const unsigned int flags);
 
-/*
- * DNS resolution
- */
-
-#define GE=
TADDR_RESOLVE                 (1u << 0)
-#define GETADDR_FATAL             =
      (1u << 1)
-#define GETADDR_HOST_ORDER              (1u << 2)
-#define=
 GETADDR_MENTION_RESOLVE_RETRY   (1u << 3)
-#define GETADDR_FATAL_ON_SIGNAL=
         (1u << 4)
-#define GETADDR_WARN_ON_SIGNAL          (1u << 5)
-#def=
ine GETADDR_MSG_VIRT_OUT            (1u << 6)
-#define GETADDR_TRY_ONCE    =
            (1u << 7)
-#define GETADDR_UPDATE_MANAGEMENT_STATE (1u << 8)
-#=
define GETADDR_RANDOMIZE               (1u << 9)
-#define GETADDR_PASSIVE  =
               (1u << 10)
-#define GETADDR_DATAGRAM                (1u << 1=
1)
-
-#define GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)
-
-/*=
*
- * Translate an IPv4 addr or hostname from string form to in_addr_t
- *
=
- * In case of resolve error, it will try again for
- * resolve_retry_secon=
ds seconds=2E
- */
-in_addr_t getaddr(unsigned int flags, const char *hostn=
ame, int resolve_retry_seconds,
-                  bool *succeeded, struct =
signal_info *sig_info);
-
-/**
- * Translate an IPv6 addr or hostname from =
string form to in6_addr
- */
-bool get_ipv6_addr(const char *hostname, stru=
ct in6_addr *network, unsigned int *netbits,
-                   msglvl_t m=
sglevel);
-
-int openvpn_getaddrinfo(unsigned int flags, const char *hostna=
me, const char *servname,
-                        int resolve_retry_second=
s, struct signal_info *sig_info, int ai_family,
-                        st=
ruct addrinfo **res);
-
 /* return values of openvpn_inet_aton */
 #define =
OIA_HOSTNAME 0
 #define OIA_IP       1
@@ -301,7 +263,7 @@
 }
 #endif
 
-/*=

+/**
  * Overhead added to packets by various protocols=2E
  */
 static in=
line int
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 133f6=
70=2E=2Efcde7fc 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
=
@@ -39,7 +39,7 @@
 #include "fdmisc=2Eh"
 #include "common=2Eh"
 #include "=
run_command=2Eh"
-#include "socket_util=2Eh"
+#include "resolve=2Eh"
 #incl=
ude "manage=2Eh"
 #include "route=2Eh"
 #include "win32=2Eh"

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa80758=
4319b2b7101f
Gerrit-Change-Number: 1846
Gerrit-PatchSet: 4
Gerrit-Owner: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>

--nRnLnmQN1Qc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #4</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/184=
6?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Fac=
tor out address resolve code to a new file resolve=2Ec<br><br>The code was =
weirdly split between socket=2Ec, socket_util=2Ec,<br>and options=2Ec=2E Th=
e new structure makes more sense=2E<br><br>While here move some related str=
ing helper code to buffer=2Eh=2E<br><br>Change-Id: I12bef330e2c8a5e5b21c2fa=
807584319b2b7101f<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M=
 src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/clinat=
=2Ec<br>M src/openvpn/dns=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/ma=
nage=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src=
/openvpn/pool=2Ec<br>M src/openvpn/ps=2Ec<br>M src/openvpn/push=2Ec<br>A sr=
c/openvpn/resolve=2Ec<br>A src/openvpn/resolve=2Eh<br>M src/openvpn/route=
=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M src/openv=
pn/socket_util=2Ec<br>M src/openvpn/socket_util=2Eh<br>M src/openvpn/tun=2E=
c<br>21 files changed, 816 insertions(+), 709 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/46/1846/4</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><=
br><span>index bac4dd4=2E=2Eca443ee 100644</span><br><span>--- a/CMakeLists=
=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -576,6 +57=
6,8 @@</span><br><span>     src/openvpn/reflect_filter=2Eh</span><br><span>=
     src/openvpn/reliable=2Ec</span><br><span>     src/openvpn/reliable=2Eh=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/res=
olve=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/ope=
nvpn/resolve=2Eh</span><br><span>     src/openvpn/route=2Ec</span><br><span=
>     src/openvpn/route=2Eh</span><br><span>     src/openvpn/run_command=2E=
c</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Make=
file=2Eam</span><br><span>index 7ecddff=2E=2Eae4d5ae 100644</span><br><span=
>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=
=2Eam</span><br><span>@@ -125,6 +125,7 @@</span><br><span> 	pushlist=2Eh \<=
/span><br><span> 	reflect_filter=2Ec reflect_filter=2Eh \</span><br><span> =
	reliable=2Ec reliable=2Eh \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	resolve=2Ec resolve=2Eh \</span><br><span> 	route=2Ec route=2Eh \=
</span><br><span> 	run_command=2Ec run_command=2Eh \</span><br><span> 	sche=
dule=2Ec schedule=2Eh \</span><br><span>diff --git a/src/openvpn/buffer=2Ec=
 b/src/openvpn/buffer=2Ec</span><br><span>index a90ddae=2E=2E616be73 100644=
</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/ope=
nvpn/buffer=2Ec</span><br><span>@@ -1088,6 +1088,23 @@</span><br><span>    =
 }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+streqnull(const char *a, const char *b)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (a =3D=3D NULL &amp;&amp; b =3D=3D NULL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    else if (a =3D=3D NULL || b =3D=3D NULL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return st=
req(a, b);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> char *</span><br><span>=
 string_substitute(const char *src, char from, char to, struct gc_arena *gc=
)</span><br><span> {</span><br><span>diff --git a/src/openvpn/buffer=2Eh b/=
src/openvpn/buffer=2Eh</span><br><span>index 58e10f0=2E=2Eafbddf6 100644</s=
pan><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvp=
n/buffer=2Eh</span><br><span>@@ -1830,6 +1830,18 @@</span><br><span>     re=
turn 0 =3D=3D strncmp(str, prefix, strlen(prefix));</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** he=
lper to work around the semantics of the strcmp() return value</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the strings a=
re equal according to strcmp()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne streq(x, y) (!strcmp((x), (y)))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** =
compare two strings which might be NULL</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return true if both strings are NULL, or if they ar=
e equal according to strcmp()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool s=
treqnull(const char *a, const char *b);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/** compare two strings which might be NULL, but NULL i=
s never equal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn true if neither string is NULL and they are equal according to strcmp(=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n> bool string_defined_equal(const char *s1, const char *s2);</span><br><sp=
an> char *string_substitute(const char *src, char from, char to, struct gc_=
arena *gc);</span><br><span> </span><br><span>diff --git a/src/openvpn/clin=
at=2Ec b/src/openvpn/clinat=2Ec</span><br><span>index dcef924=2E=2Ed0d1565 =
100644</span><br><span>--- a/src/openvpn/clinat=2Ec</span><br><span>+++ b/s=
rc/openvpn/clinat=2Ec</span><br><span>@@ -30,6 +30,7 @@</span><br><span> #i=
nclude &quot;proto=2Eh&quot;</span><br><span> #include &quot;socket_util=2E=
h&quot;</span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span=
><br><span> </span><br><span> static bool</span><br><span> add_entry(struct=
 client_nat_option_list *dest, const struct client_nat_entry *e)</span><br>=
<span>diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec</span><br><spa=
n>index 7f4dde4=2E=2Ea40f3e7 100644</span><br><span>--- a/src/openvpn/dns=
=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</span><br><span>@@ -27,7 +27=
,7 @@</span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> </=
span><br><span> #include &quot;dns=2Eh&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#include &quot;socket_util=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</s=
pan><br><span> #include &quot;options=2Eh&quot;</span><br><span> #include &=
quot;run_command=2Eh&quot;</span><br><span> #include &quot;domain_helper=2E=
h&quot;</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/ini=
t=2Ec</span><br><span>index 9306a96=2E=2Eeccb814 100644</span><br><span>---=
 a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><b=
r><span>@@ -55,6 +55,7 @@</span><br><span> #include &quot;tun_afunix=2Eh&qu=
ot;</span><br><span> #include &quot;schedule=2Eh&quot;</span><br><span> #in=
clude &quot;options_string=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><br><span> </span><=
br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span=
>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><sp=
an>index 0aef2d4=2E=2E8399fc9 100644</span><br><span>--- a/src/openvpn/mana=
ge=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -44,=
6 +44,7 @@</span><br><span> #include &quot;dco=2Eh&quot;</span><br><span> #=
include &quot;push=2Eh&quot;</span><br><span> #include &quot;multi=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;res=
olve=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh=
&quot;</span><br><span> </span><br><span>diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec</span><br><span>index 6664c73=2E=2E3bc8ee4 1=
00644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/s=
rc/openvpn/options=2Ec</span><br><span>@@ -64,6 +64,7 @@</span><br><span> #=
include &quot;domain_helper=2Eh&quot;</span><br><span> #include &quot;mbuf=
=2Eh&quot;</span><br><span> #include &quot;check_file_access=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;resolve=
=2Eh&quot;</span><br><span> </span><br><span> #include &lt;ctype=2Eh&gt;</s=
pan><br><span> </span><br><span>@@ -1044,26 +1045,6 @@</span><br><span> </s=
pan><br><span> #endif /* ifndef _WIN32 */</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static in_addr_t</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-get_ip_addr(const char *ip_string, msglvl_=
t msglevel, bool *error)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int =
flags =3D GETADDR_HOST_ORDER;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    bool succeeded =3D false;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    in_addr_t ret;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
msglevel &amp; M_FATAL)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        flags =
|=3D GETADDR_FATAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ret =3D getaddr(flags, ip_string, 0=
, &amp;succeeded, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (!succeeded &amp;&amp; error)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        *error =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span=
>  * Returns newly allocated string containing address part without &quot;/=
nn&quot;=2E</span><br><span>  *</span><br><span>@@ -1086,13 +1067,6 @@</spa=
n><br><span>     }</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-ipv6_addr_safe_hexplusbits(const char *ipv6_prefix_spec)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return get_ipv6_addr(ipv6_prefix_spec,=
 NULL, NULL, M_WARN);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*=
*</span><br><span>  * Parses a hexstring and checks if the string has the c=
orrect length=2E Return</span><br><span>  * a verify_hash_list containing t=
he parsed hash string=2E</span><br><span>@@ -3330,7 +3304,7 @@</span><br><s=
pan>     options_postprocess_verify(options);</span><br><span> #ifndef ENAB=
LE_SMALL</span><br><span>     options_postprocess_filechecks(options);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* !ENABLE_SMALL */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan> }</span><br><span> </span><br><span> /*</span><br><span>diff --git a/s=
rc/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index d347=
830=2E=2Efc1124a 100644</span><br><span>--- a/src/openvpn/options=2Eh</span=
><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -724,8 +724,6 @=
@</span><br><span>     unsigned int imported_protocol_flags;</span><br><spa=
n> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define streq(x, y) (!strcmp((x), (y)))</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Option classes=
=2E</span><br><span>  */</span><br><span>diff --git a/src/openvpn/pool=2Ec =
b/src/openvpn/pool=2Ec</span><br><span>index 63fc930=2E=2Efff0e3f 100644</s=
pan><br><span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b/src/openvpn/=
pool=2Ec</span><br><span>@@ -31,6 +31,7 @@</span><br><span> #include &quot;=
error=2Eh&quot;</span><br><span> #include &quot;socket_util=2Eh&quot;</span=
><br><span> #include &quot;otime=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><br><span> </=
span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br=
><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span=
>index 08c2673=2E=2Edc3465c 100644</span><br><span>--- a/src/openvpn/ps=2Ec=
</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -32,6 +32,7 @@=
</span><br><span> #include &quot;socket=2Eh&quot;</span><br><span> #include=
 &quot;fdmisc=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;resolve=
=2Eh&quot;</span><br><span> #include &quot;ps=2Eh&quot;</span><br><span> </=
span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span>diff --git =
a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 0e281d2=
=2E=2Eb9da90f 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><=
span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -37,6 +37,7 @@</span><br=
><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl=
_util=2Eh&quot;</span><br><span> #include &quot;options_util=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;resolve=
=2Eh&quot;</span><br><span> </span><br><span> /*</span><br><span>  * Auth u=
sername/password</span><br><span>diff --git a/src/openvpn/resolve=2Ec b/src=
/openvpn/resolve=2Ec</span><br><span>new file mode 100644</span><br><span>i=
ndex 0000000=2E=2Eb8d9899</span><br><span>--- /dev/null</span><br><span>+++=
 b/src/openvpn/resolve=2Ec</span><br><span>@@ -0,0 +1,665 @@</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP=
 networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     over a single TCP/UDP port, with support for SSL/TLS-based</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             session authenti=
cation and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             packet encryption, packet authentication, and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compres=
sion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 O=
penVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  This program is free software; you can redistribute it and/or modify<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the ter=
ms of the GNU General Public License version 2</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed i=
n the hope that it will be useful,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTA=
BILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more =
details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have receiv=
ed a copy of the GNU General Public License along</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:=
//www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;conf=
ig=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;manage=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;socket=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;socket_util=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Conve=
rt sockflags/getaddr_flags into getaddr_flags</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+sf2gaf(const unsigned int getaddr_flags, const unsigned int sockflags)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (sockflags &amp; SF_HOST_RANDOMI=
ZE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return getaddr_flags |=
 GETADDR_RANDOMIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return getaddr_flags;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Functions related=
 to the translation of DNS names to IP addresses=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Small helper f=
unction for openvpn_getaddrinfo to print the address</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * family when resolving fails</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static const char *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+getaddrinfo_addr_family_name(int af)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    switch (af)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        case AF_INET:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return &quot;[AF_INET]&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        case AF_INET6:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return &quot;[AF_INET6]&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return &quot;&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Prepend a random =
string to hostname to prevent DNS caching=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * For example, foo=2Ebar=2Egov would be modified =
to &lt;random-chars&gt;=2Efoo=2Ebar=2Egov=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Of course, this requires explicit support in th=
e DNS server (wildcard)=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static co=
nst char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hostname_=
randomize(const char *hostname, struct gc_arena *gc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define n_rnd_bytes 6</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint8_t rnd_bytes[n_rnd_bytes];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *rnd_str;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer hname =3D alloc_buf_gc(strlen(hostnam=
e) + sizeof(rnd_bytes) * 2 + 4, gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  prng_bytes(rnd_bytes, sizeof(rnd_bytes));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    rnd_str =3D format_hex_ex(rnd_bytes, sizeof(rnd=
_bytes), 40, 0, NULL, gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    buf_printf(&amp;hname, &quot;%s=2E%s&quot;, rnd_str, hostname);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return BSTR(&amp=
;hname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef n_rn=
d_bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Translate IPv4/IPv6 addr or hostname into struct addrinfo</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If resolve error, try =
again for resolve_retry_seconds seconds=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_g=
etaddrinfo(unsigned int flags, const char *hostname, const char *servname,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
int resolve_retry_seconds, struct signal_info *sig_info, int ai_family,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    str=
uct addrinfo **res)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct addrinf=
o hints;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int sta=
tus;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sign=
al_info sigrec =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    msglvl_t msglevel =3D (flags &amp; GETADDR_FATAL) ? M_FATAL : D_R=
ESOLVE_ERRORS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const char *print_hostname;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const char *print_servname;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ASSERT(res);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    A=
SSERT(hostname || servname);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ASSERT(!(flags &amp; GETADDR_HOST_ORDER));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (servname)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        print_servname =3D servname;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        print_servnam=
e =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; GETADDR_MSG_V=
IRT_OUT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msglevel |=3D M_M=
SG_VIRT_OUT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if ((flags &amp; (GETADDR_FATAL_ON_S=
IGNAL | GETADDR_WARN_ON_SIGNAL)) &amp;&amp; !sig_info)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        sig_info =3D &amp;sigrec;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* try numeric ip addr first */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    CLEAR(hints);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    hints=2Eai_flags =3D AI_NUMERICHOST;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (flags &amp; GETADDR_PASSIVE)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        hints=2Eai_flags |=3D AI_PASSIVE;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (flags &amp; GETADDR_DATAGRAM)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        hints=2Eai_socktype =3D SOCK_DGRAM;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       hints=2Eai_socktype =3D SOCK_STREAM;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* if=
 hostname is not set, we want to bind to &#39;ANY&#39;, with</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * the correct address family =
- v4-only or v6/v6-dual-stack */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!hostname)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      hints=2Eai_family =3D ai_family;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D=
 getaddrinfo(hostname, servname, &amp;hints, res);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (status !=3D 0)                      /* parse as numeric=
 address failed? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
int fail_wait_interval =3D 5; /* seconds */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* Add +4 to cause integer division roundin=
g up (1 + 4) =3D 5, (0+4)/5=3D0 */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        int resolve_retries =3D</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            (flags &amp; GETADDR_TRY_ONCE) ? 1 :=
 ((resolve_retry_seconds + 4) / fail_wait_interval);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const char *fmt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msglvl_t level =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* this is not a numeric IP, therefor=
e force resolution using the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * provided ai_family */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        hints=2Eai_family =3D ai_family;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (hostname &amp;&amp; (flags &amp; GETADD=
R_RANDOMIZE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            host=
name =3D hostname_randomize(hostname, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (hostname)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   print_hostname =3D hostname;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pri=
nt_hostname =3D &quot;undefined&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fm=
t =3D &quot;RESOLVE: Cannot resolve host address: %s:%s%s (%s)&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((flags &amp; =
GETADDR_MENTION_RESOLVE_RETRY) &amp;&amp; !resolve_retry_seconds)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            fmt =3D &quot;RESOLVE: Cann=
ot resolve host address: %s:%s%s (%s)&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                  &quot;(I would have retried this =
name query if you had &quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                  &quot;specified the --resolv-retry option=2E)&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (!(flags &amp; GETADDR_RESOLVE) |=
| status =3D=3D EAI_FAIL)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(msglevel, &quot;RESOLVE: Cannot parse IP address: %s:%s (%s)&qu=
ot;, print_hostname,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                print_servname, gai_strerror(status));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (flags &amp; GETADDR_UPDATE_MANAGEMENT_STATE)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (management)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                management_set_=
state(management, OPENVPN_STATE_RESOLVE, NULL, NULL, NULL, NULL,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
       NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /*</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * Resolve hostname</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        while (true)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          /* force resolv=2Econf reload */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            res_init();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            /* try hostname lookup */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            hints=2Eai_flags &amp;=3D ~AI=
_NUMERICHOST;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      dmsg(D_SOCKET_DEBUG, &quot;GETADDRINFO flags=3D0x%04x ai_family=3D%d =
ai_socktype=3D%d&quot;, flags,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                 hints=2Eai_family, hints=2Eai_socktype);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            status =3D get=
addrinfo(hostname, servname, &amp;hints, res);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (sig_info)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                get_signal(&amp;sig_info-&gt;signal_received);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (sig_=
info-&gt;signal_received) /* were we interrupted by a signal? */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    /* why are w=
e overwriting SIGUSR1 ? */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    if (signal_reset(sig_info, SIGUSR1) =3D=3D SIGUS=
R1) /* ignore SIGUSR1 */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        msg(level, &quot;RESOLVE: Ignored SIGUSR1 si=
gnal received during &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                   &quot;DNS resolution attempt&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  /* turn success into failure (interrupted syscall) */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 if (0 =3D=3D status)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                            ASSERT(res);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                            freeaddrinfo(*res)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
          *res =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                            status =3D EAI_AGAIN; /* =3D temporary fai=
lure */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                errno =3D EINTR;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        goto done;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            /* success? */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (0 =3D=3D status)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                break;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* resolve lookup failed, should we</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             * continue or fail? */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            level =3D msglevel=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (re=
solve_retries &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            level =3D D_RESOLVE_ERRORS;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msg(level, fmt, print_hostname, print_servname, getaddrinfo_addr_fam=
ily_name(ai_family),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                gai_strerror(status));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (--resolve_retries &lt;=3D 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                goto done;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            management_sleep(fail_wait_interval);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        ASSERT(res);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* ho=
stname resolve succeeded */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * Do not ch=
oose an IP Addresse by random or change the order *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * of IP addresses, doing so will=
 break RFC 3484 address selection *</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+         */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* IP address parse suc=
ceeded */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (flags &amp; GETADDR_RANDOMIZE)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(M_WARN, &quot;WARNING: ignoring --remote-random-hostname=
 because the &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        &quot;hostname is an IP address&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sig_i=
nfo &amp;&amp; sig_info-&gt;signal_received)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        msglvl_t level =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (flags &amp; GETADDR_FATAL_ON_SIGNAL)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            level =3D M_FATAL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        else if (flags &amp; GETAD=
DR_WARN_ON_SIGNAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 level =3D M_WARN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(level, &quot;RESOLVE: signal received during DNS resolution attempt&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return status;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_addr_generic(sa_f=
amily_t af, unsigned int flags, const char *hostname, void *network,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                 unsigned =
int *netbits, int resolve_retry_seconds, struct signal_info *sig_info,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                 msglvl_=
t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    char *endp, *sep, *var=
_host =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct addrinfo *ai =3D NULL;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    unsigned long bits;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    uint8_t max_bits;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int ret =3D -1;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!hostname)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONF=
ATAL, &quot;Can&#39;t resolve null hostname!&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* assign family specific default values */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    switch (af)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        case AF_INET:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            bits =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            max_bits =3D sizeof(in_addr_t) * 8;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        case AF_INET6:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            bits =3D 64;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            max_bits =3D sizeof(struct in=
6_addr) * 8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        default:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;=
Unsupported AF family passed to getaddrinfo for %s (%d)&quot;, hostname, af=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto =
out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* we need to modify the hostname received a=
s input, but we don&#39;t want to</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * touch it directly as it might be a constant string=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * Therefore, we clone the st=
ring here and free it at the end of the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * function */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    var_host =3D strdup(hostname);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!var_host)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_NONFATAL | M_ERRNO, &quot;Can&#39;t alloc=
ate hostname buffer for getaddrinfo&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* chec=
k if this hostname has a /bits suffix */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    sep =3D strchr(var_host, &#39;/&#39;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (sep)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        bits =3D strtoul(sep + 1, &amp;endp, 10);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((*endp !=
=3D &#39;\0&#39;) || (bits &gt; max_bits))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(msglevel, &quot;IP prefix &#39;%s&#39;: invali=
d &#39;/bits&#39; spec (%s)&quot;, hostname, sep + 1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            goto out;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        *sep =3D &#39;\0&#39;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ret =3D openvpn_getaddrinfo(flags &amp; ~GETADDR_HOST_ORDER, var_h=
ost, NULL, resolve_retry_seconds,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                              sig_info, af, &amp;ai);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((ret =3D=3D 0) &amp=
;&amp; network)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct in6=
_addr *ip6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
in_addr_t *ip4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (af !=3D ai-=
&gt;ai_family)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(msglevel, &quot;Can&#39;t parse %s as IPv%d address&quot;, var_host, (af =
=3D=3D AF_INET) ? 4 : 6);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            goto out;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        switch (a=
f)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            case AF_INET:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ip4 =
=3D network;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         *ip4 =3D ((struct sockaddr_in *)ai-&gt;ai_addr)-&gt;sin_addr=2Es_a=
ddr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                if (flags &amp; GE=
TADDR_HOST_ORDER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                *ip4 =3D ntohl(*ip4);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                break;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            case AF_INET6:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                ip6 =3D network;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                *ip6 =3D ((struct sockaddr_in6 *)ai-&gt=
;ai_addr)-&gt;sin6_addr;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                break;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 default:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      /* can&#39;t get here because &#39;af&#39; was previously checked */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(=
M_WARN, &quot;Unsupported AF family for %s (%d)&quot;, var_host, af);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                goto out;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (netbits)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      *netbits =3D (unsigned int)bits;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* restore=
 &#39;/&#39; separator, if any */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (sep)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 *sep =3D &#39;/&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+out:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ai)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        freeaddrinfo(ai);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    free(var_host);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+in_addr_t</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+getaddr(unsigned int flags, const char *hostname, =
int resolve_retry_seconds, bool *succeeded,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct signal_info *sig_info)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    in_addr_t addr =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int status;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    status =3D get_addr_generic(AF_INET, flags, hostname, &amp;a=
ddr, NULL, resolve_retry_seconds,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                              sig_info, M_WARN);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (status =3D=3D 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (succeeded)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            *succeeded =3D true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return addr;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (succeeded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *su=
cceeded =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+in_addr_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+get_ip_addr(const char *ip_string, msglvl_t msglevel, bool *error)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    unsigned int flags =3D GETADDR_HOST_ORDER=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool succeeded=
 =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_a=
ddr_t ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (msglevel &amp; M_FAT=
AL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D GETADDR_FAT=
AL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ret =3D getaddr(flags, ip_string, 0, &amp;suc=
ceeded, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!succeeded &amp;&amp; error)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      *error =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+get_ipv6_addr(const char *hostname, struct in6_addr *network, unsig=
ned int *netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
            msglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, netbits, 0,=
 NULL, msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return true; /* parsing OK, values set */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ge=
t_cached_dns_entry return 0 on success and -1</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * otherwise=2E (like getaddrinfo)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+get_cached_dns_entry(struct cached_dns_entry *dns_cache, const cha=
r *hostname, const char *servname,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                     int ai_family, unsigned int resolve_fla=
gs, struct addrinfo **ai)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct c=
ached_dns_entry *ph;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    unsigned int flags;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Only us=
e flags that are relevant for the structure */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    flags =3D resolve_flags &amp; GETADDR_CACHE_=
MASK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    for (ph =3D dns_cache; ph; ph=
 =3D ph-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (stre=
qnull(ph-&gt;hostname, hostname) &amp;&amp; streqnull(ph-&gt;servname, serv=
name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &a=
mp;&amp; ph-&gt;ai_family =3D=3D ai_family &amp;&amp; ph-&gt;flags =3D=3D f=
lags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            *ai =3D ph-&=
gt;ai;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+do_preresolve_host(struct cont=
ext *c, const char *hostname, const char *servname, const int af,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                   const unsi=
gned int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *a=
i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int status;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (get_cached_dns_entry(c-&gt;c1=2E=
dns_cache, hostname, servname, af, flags, &amp;ai) =3D=3D 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* entry already cached, return success =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    status =3D openvpn_getaddrinfo(flags, hostname, =
servname, c-&gt;options=2Eresolve_retry_seconds, NULL,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                 af, &am=
p;ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (statu=
s =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct cached_=
dns_entry *ph;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_CLEAR_=
GC(ph, struct cached_dns_entry, &amp;c-&gt;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        ph-&gt;ai =3D ai;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ph-&gt;hostname =3D hostname;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ph-&gt;servname=
 =3D servname;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   ph-&gt;flags =3D flags &amp; GETADDR_CACHE_MASK;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!c-&gt;c1=2Edns_cache)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            c-&gt;c1=2Edns_cache =3D ph;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            struct cached_dns_entry *prev =3D c-&gt;c1=2Edns_=
cache;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            w=
hile (prev-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           prev =3D prev-&gt;next;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            prev-&gt;next =3D ph;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  gc_addspecial(ai, &amp;gc_freeaddrinfo_callback, &amp;c-&gt;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return status;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_preresolve(stru=
ct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct connection_l=
ist *l =3D c-&gt;options=2Econnection_list;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const unsigned int preresolve_flags =3D GETADDR=
_RESOLVE | GETADDR_UPDATE_MANAGEMENT_STATE</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                          | GETADDR_=
MENTION_RESOLVE_RETRY | GETADDR_FATAL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D =
0; i &lt; l-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
int status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
const char *remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        unsigned int flags =3D preresolve_flags;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct connection_entry *ce =3D l-&gt;array[i];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (proto_is_dgram(ce-&gt;proto))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            flags |=3D GETADDR_DATAG=
RAM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (c-&gt;options=2Esockflags &amp; =
SF_HOST_RANDOMIZE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 flags |=3D GETADDR_RANDOMIZE;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;=
options=2Eip_remote_hint)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        remote =3D c-&gt;options=2Eip_remote_hint;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            remote =3D ce-&gt;remote;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* HTTP remote hostname does not need to be resolved */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (!ce-&gt;http_proxy_options=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            status =3D do_pr=
eresolve_host(c, remote, ce-&gt;remote_port, ce-&gt;af, flags);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (status !=3D 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                goto err;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* Preresolve proxy */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (ce-&gt;http_proxy_options)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            status =3D do_preresolv=
e_host(c, ce-&gt;http_proxy_options-&gt;server,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                        ce-&gt;=
http_proxy_options-&gt;port, ce-&gt;af, preresolve_flags);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (status !=3D 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                goto err;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (ce-&gt;socks_proxy_server)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            status =3D</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                do_preresolve_host(c, ce-&gt;socks_proxy_server, ce=
-&gt;socks_proxy_port, ce-&gt;af, flags);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if (status !=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (ce-&gt;bind_local)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            flags |=3D GETADDR_PASSIVE;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            flags &amp;=3D ~GETADDR_RANDOMIZE;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            for (int j =3D 0; j &lt; ce-&gt;loc=
al_list-&gt;len; j++)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            const struct local_entry *le =3D ce-&gt;local_list-&gt;array[j]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                if (!le-&gt;local)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    cont=
inue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                status =3D do_prere=
solve_host(c, le-&gt;local, le-&gt;port, ce-&gt;af, flags);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                if (status !=3D 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    go=
to err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    throw_s=
ignal_soft(SIGHUP, &quot;Preresolving failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvp=
n/resolve=2Eh b/src/openvpn/resolve=2Eh</span><br><span>new file mode 10064=
4</span><br><span>index 0000000=2E=2E9069af7</span><br><span>--- /dev/null<=
/span><br><span>+++ b/src/openvpn/resolve=2Eh</span><br><span>@@ -0,0 +1,10=
6 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to=
 securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             over a single TCP/UDP port, with support for SSL/TL=
S-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   session authentication and key exchange,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             packet encryption, packet authentica=
tion, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyri=
ght (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is free software; you can redistribut=
e it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  it under the terms of the GNU General Public License version 2</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free =
Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This progr=
am is distributed in the hope that it will be useful,</span><br><span style=
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
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * DNS resolution</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#ifndef RESOLVE_H</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define RESOLVE_H</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sig=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_RESOLVE     =
            (1u &lt;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define GETADDR_FATAL                   (1u &lt;&lt; 1)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_HOST_ORDER     =
         (1u &lt;&lt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define GETADDR_MENTION_RESOLVE_RETRY   (1u &lt;&lt; 3)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_FATAL_ON_SIGNAL   =
      (1u &lt;&lt; 4)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define GETADDR_WARN_ON_SIGNAL          (1u &lt;&lt; 5)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_MSG_VIRT_OUT         =
   (1u &lt;&lt; 6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define GETADDR_TRY_ONCE                (1u &lt;&lt; 7)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_UPDATE_MANAGEMENT_STATE =
(1u &lt;&lt; 8)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine GETADDR_RANDOMIZE               (1u &lt;&lt; 9)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_PASSIVE                 (=
1u &lt;&lt; 10)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine GETADDR_DATAGRAM                (1u &lt;&lt; 11)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSI=
VE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Convert sockflags/getaddr_flags into getaddr_fla=
gs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+unsigned int sf2gaf(const unsigne=
d int getaddr_flags, const unsigned int sockflags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Translate an IPv4 addr or hostname from string form to in_addr_t</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * In case of resolve error, it will try agai=
n for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * resolve_ret=
ry_seconds seconds=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in_addr_t geta=
ddr(unsigned int flags, const char *hostname, int resolve_retry_seconds,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                  bool=
 *succeeded, struct signal_info *sig_info);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+in_addr_t get_ip_addr(const char *ip_string, msglvl_t msglevel, bool *=
error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Translate an IPv6 addr or hostname from stri=
ng form to in6_addr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool get_ipv6_ad=
dr(const char *hostname, struct in6_addr *network, unsigned int *netbits,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   ms=
glvl_t msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ipv6_addr_safe_hexplus=
bits(const char *ipv6_prefix_spec)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WARN);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+int openvpn_getaddrinfo(unsigned int flags, const char *hostname, const=
 char *servname,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     int resolve_retry_seconds, struct signal_info *sig_inf=
o, int ai_family,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      struct addrinfo **res);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void do_preresolve(struct context *c);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* struct to hold preresolved host names */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+struct cached_dns_entry</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const char *hostname;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *servname;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int ai_family;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    unsigned int flags;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *ai;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct cached_dns_entry *next;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * get_cached_dns_entry return 0 on success and -1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * otherwise=2E (like getaddrinfo())</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+int get_cached_dns_entry(struct cached_d=
ns_entry *dns_cache, const char *hostname,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                         const char *servname, int a=
i_family,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
               unsigned int resolve_flags, struct addrinfo **ai);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif /* RESOLVE_H */</span><br><span>diff --gi=
t a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 33b=
2387=2E=2E1077e83 100644</span><br><span>--- a/src/openvpn/route=2Ec</span>=
<br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -42,6 +42,7 @@</sp=
an><br><span> #include &quot;options=2Eh&quot;</span><br><span> #include &q=
uot;networking=2Eh&quot;</span><br><span> #include &quot;integer=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;resol=
ve=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&q=
uot;</span><br><span> </span><br><span>diff --git a/src/openvpn/socket=2Ec =
b/src/openvpn/socket=2Ec</span><br><span>index 33def4e=2E=2E386f395 100644<=
/span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/open=
vpn/socket=2Ec</span><br><span>@@ -38,6 +38,7 @@</span><br><span> #include =
&quot;manage=2Eh&quot;</span><br><span> #include &quot;openvpn=2Eh&quot;</s=
pan><br><span> #include &quot;forward=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><br><spa=
n> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </spa=
n><br><span>@@ -54,366 +55,6 @@</span><br><span>     return false;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Convert s=
ockflags/getaddr_flags into getaddr_flags</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static unsigned int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
sf2gaf(const unsigned int getaddr_flags, const unsigned int sockflags)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (sockflags &amp; SF_HOST_RANDOMIZE)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return getaddr_flags | GETADDR_RA=
NDOMIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return getaddr_flags;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Functions related to the translation of DNS name=
s to IP addresses=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-get_addr_generic(sa_family_t a=
f, unsigned int flags, const char *hostname, void *network,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                 unsigned int *netbit=
s, int resolve_retry_seconds, struct signal_info *sig_info,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                 msglvl_t msglevel)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    char *endp, *sep, *var_host =3D NULL;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct addrinfo *ai=
 =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigne=
d long bits;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8=
_t max_bits;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int r=
et =3D -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!hostname)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        msg(M_NONFATAL, &quot;Can&#39;t resolve nul=
l hostname!&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      goto out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* assign family specific default value=
s */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (af)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        case AF_INET:</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            bits =3D 0;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            max_bits =3D sizeof(in_ad=
dr_t) * 8;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET6:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            bits =3D 64;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            max_bits =3D sizeof=
(struct in6_addr) * 8;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        default:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quo=
t;Unsupported AF family passed to getaddrinfo for %s (%d)&quot;, hostname, =
af);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto =
out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* we need to modify the hostname received as inpu=
t, but we don&#39;t want to</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-     * touch it directly as it might be a constant string=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * Therefore, we clone the string here =
and free it at the end of the</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-     * function */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    var_host =3D strdup(hostname);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (!var_host)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       msg(M_NONFATAL | M_ERRNO, &quot;Can&#39;t allocate hostname buffer f=
or getaddrinfo&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        goto out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* check if this hostname has a /bit=
s suffix */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sep =
=3D strchr(var_host, &#39;/&#39;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (sep)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bits=
 =3D strtoul(sep + 1, &amp;endp, 10);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if ((*endp !=3D &#39;\0&#39;) || (bits &gt; max_bit=
s))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quo=
t;IP prefix &#39;%s&#39;: invalid &#39;/bits&#39; spec (%s)&quot;, hostname=
, sep + 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  goto out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *sep =3D &#39;=
\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    ret =3D openvpn_getaddrinfo(flags &amp; ~GETAD=
DR_HOST_ORDER, var_host, NULL, resolve_retry_seconds,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                              sig_info, af,=
 &amp;ai);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((re=
t =3D=3D 0) &amp;&amp; network)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  struct in6_addr *ip6;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        in_addr_t *ip4;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (af !=
=3D ai-&gt;ai_family)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
msg(msglevel, &quot;Can&#39;t parse %s as IPv%d address&quot;, var_host, (a=
f =3D=3D AF_INET) ? 4 : 6);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            ret =3D -1;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            goto out;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        switch (af)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            case AF_INET:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                ip4 =3D network;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                *ip4 =3D=
 ((struct sockaddr_in *)ai-&gt;ai_addr)-&gt;sin_addr=2Es_addr;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                if (flags &amp; GETADDR_HOST_ORDER)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    *ip4 =3D =
ntohl(*ip4);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            case AF_INET6:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                ip6 =3D netw=
ork;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                *=
ip6 =3D ((struct sockaddr_in6 *)ai-&gt;ai_addr)-&gt;sin6_addr;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                break;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            default:</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                /* can&#39;t get here because &#39;af&#=
39; was previously checked */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                msg(M_WARN, &quot;Unsupported AF family for %s (%d)=
&quot;, var_host, af);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                goto out;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (netbits)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        *netbits =3D (unsigned int)bits;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* restore &#39;/&#39; separator, if any */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (sep)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    *sep =3D &#39;/&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-out:</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ai)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        freeaddrinfo(ai);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    free(var_host);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-in_addr_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-getaddr(unsigned int flags, const char *hostname, int resolve_retry_second=
s, bool *succeeded,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      struct signal_info *sig_info)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
_addr_t addr =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D get_addr_g=
eneric(AF_INET, flags, hostname, &amp;addr, NULL, resolve_retry_seconds,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
      sig_info, M_WARN);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (status =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (succeeded)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *succeede=
d =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return addr;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (succeeded)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        *succeeded =3D false;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_ip=
v6_addr(const char *hostname, struct in6_addr *network, unsigned int *netbi=
ts,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              msgl=
vl_t msglevel)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (get_addr_generic(AF=
_INET6, GETADDR_RESOLVE, hostname, network, netbits, 0, NULL, msglevel)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        &lt; 0)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n true; /* parsing OK, values set */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-streqnull(const char *a, cons=
t char *b)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (a =3D=3D NULL &amp;&amp=
; b =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return true;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    else if (a =3D=3D NULL || b =3D=3D=
 NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return streq(a, b);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * get_cached_dns_entry return 0 on success and -1</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * otherwise=2E (like getaddrinfo)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-get_cached_dns_entry(struct cached_dns_entry *dns_cache, c=
onst char *hostname, const char *servname,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                     int ai_family, unsigned int resol=
ve_flags, struct addrinfo **ai)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 cached_dns_entry *ph;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    unsigned int flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Only use fl=
ags that are relevant for the structure */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    flags =3D resolve_flags &amp; GETADDR_CACHE_MASK;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    for (ph =3D dns_cache; ph; ph =3D ph-&g=
t;next)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (streqnull(ph-&gt;h=
ostname, hostname) &amp;&amp; streqnull(ph-&gt;servname, servname)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; ph-&gt;=
ai_family =3D=3D ai_family &amp;&amp; ph-&gt;flags =3D=3D flags)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            *ai =3D ph-&gt;ai;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            return 0;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return -1;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-do_preresolve_host(struct context *c, const char *hostname, const c=
har *servname, const int af,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                   const unsigned int flags)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct addrinfo *ai;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int status;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (get_=
cached_dns_entry(c-&gt;c1=2Edns_cache, hostname, servname, af, flags, &amp;=
ai) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* entry already=
 cached, return success */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    status =3D openvpn_getaddrinfo(f=
lags, hostname, servname, c-&gt;options=2Eresolve_retry_seconds, NULL,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
       af, &amp;ai);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (status =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct=
 cached_dns_entry *ph;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ALLOC_OBJ_CL=
EAR_GC(ph, struct cached_dns_entry, &amp;c-&gt;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ph-&gt;ai =3D ai;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        ph-&gt;hostname =3D hostname;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ph-&gt;servname=
 =3D servname;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 ph-&gt;flags =3D flags &amp; GETADDR_CACHE_MASK;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (!c-&gt;c1=2Edns_cache)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            c-&gt;c1=2Edns_cache =3D ph;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      struct cached_dns_entry *prev =3D c-&gt;c1=2Edns_cache;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            while (prev-&gt;next)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                prev =3D prev-&=
gt;next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            prev-&gt;=
next =3D ph;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        gc_addspecial(ai, &amp;gc_freeaddr=
info_callback, &amp;c-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-do_preresolve(struct context *c)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct connection_list *l =3D c-&gt;options=2Econnection_list;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const unsigned int preresolv=
e_flags =3D GETADDR_RESOLVE | GETADDR_UPDATE_MANAGEMENT_STATE</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                   =
       | GETADDR_MENTION_RESOLVE_RETRY | GETADDR_FATAL;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for =
(int i =3D 0; i &lt; l-&gt;len; ++i)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       int status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     const char *remote;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        unsigned int flags =3D preresolve_flags;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        struct connection_entry *ce =3D l-&gt;array[i];</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (proto_is_dgram(ce-&gt;proto))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            flags |=3D GETADDR_DATAGRAM;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (c-&gt;options=2Esockflags &amp; SF_HOST_RANDO=
MIZE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            flags |=3D GETAD=
DR_RANDOMIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;options=2Eip_remote_hin=
t)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            remote =3D c-&gt;op=
tions=2Eip_remote_hint;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            remote =3D ce-&gt;r=
emote;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /* HTTP remote hostname does not need to=
 be resolved */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (!ce-&gt;http_proxy_options)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            status =3D do_preresolve_host(c, remote, ce-&gt;remote_port, ce=
-&gt;af, flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       if (status !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            goto err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        /* Preresolve proxy */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (ce-&gt;http_proxy_op=
tions)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            status =3D do_p=
reresolve_host(c, ce-&gt;http_proxy_options-&gt;server,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                                        c=
e-&gt;http_proxy_options-&gt;port, ce-&gt;af, preresolve_flags);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            if (status !=3D 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                goto err;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c=
e-&gt;socks_proxy_server)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    status =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         do_preresolve_host(c, ce-&gt;socks_proxy_server, ce-&gt;socks_prox=
y_port, ce-&gt;af, flags);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            if (status !=3D 0)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                goto err;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (ce-&gt;bind_local)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            flags |=3D GETADDR_PAS=
SIVE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            flag=
s &amp;=3D ~GETADDR_RANDOMIZE;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
for (int j =3D 0; j &lt; ce-&gt;local_list-&gt;len; j++)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                const struct local_entry *le =3D=
 ce-&gt;local_list-&gt;array[j];</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      if (!le-&gt;local)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   continue;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                st=
atus =3D do_preresolve_host(c, le-&gt;local, le-&gt;port, ce-&gt;af, flags)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (=
status !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         goto err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-err:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    throw_signal=
_soft(SIGHUP, &quot;Preresolving failed&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> static int</span><br><span> socket_get_sndbuf(socke=
t_descriptor_t sd)</span><br><span> {</span><br><span>diff --git a/src/open=
vpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 46fa29c=2E=2E=
bef228c 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span=
>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -62,17 +62,6 @@</span><br>=
<span> /* convert a packet_size_type from network to host order */</span><b=
r><span> #define ntohps(x) ntohs(x)</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* struct to hold preresolved host names */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct cached_dns_ent=
ry</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const char *hostname;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    const char *servname;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int ai_family;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    unsigned int flags;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct addrinfo *ai;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct cached_dns_entry *=
next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* IP addresses w=
hich are persistent across SIGUSR1s */</span><br><span> struct link_socket_=
addr</span><br><span> {</span><br><span>@@ -362,8 +351,6 @@</span><br><span=
> </span><br><span> void link_socket_init_phase2(struct context *c, struct =
link_socket *sock);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-void do_preresolve(struct context *c);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void link_socket_close(s=
truct link_socket *sock);</span><br><span> </span><br><span> #ifdef ENABLE_=
MANAGEMENT</span><br><span>diff --git a/src/openvpn/socket_util=2Ec b/src/o=
penvpn/socket_util=2Ec</span><br><span>index 913ac69=2E=2E879be73 100644</s=
pan><br><span>--- a/src/openvpn/socket_util=2Ec</span><br><span>+++ b/src/o=
penvpn/socket_util=2Ec</span><br><span>@@ -490,271 +490,6 @@</span><br><spa=
n>     return &quot;&quot;; /* Make the compiler happy */</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*=
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Small helper func=
tion for openvpn_getaddrinfo to print the address</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * family when resolving fails</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static const char *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-getaddrinfo_addr_family_name(int af)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    switch (af)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ca=
se AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  return &quot;[AF_INET]&quot;;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cas=
e AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  return &quot;[AF_INET6]&quot;;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn &quot;&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * Prepend a random string to hostname to prevent DNS caching=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * For example, fo=
o=2Ebar=2Egov would be modified to &lt;random-chars&gt;=2Efoo=2Ebar=2Egov=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Of course, this=
 requires explicit support in the DNS server (wildcard)=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static const char *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-hostname_randomize(const char *hostname, struct gc_arena *=
gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define n_rnd_bytes 6</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    uint8_t rnd_bytes[n_rnd_bytes];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const char *rnd_str;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct buffer hname =3D alloc_buf_gc=
(strlen(hostname) + sizeof(rnd_bytes) * 2 + 4, gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    prng_bytes(rnd_bytes, sizeof(rnd_bytes));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    rnd_str =3D format_hex_ex(rnd_bytes,=
 sizeof(rnd_bytes), 40, 0, NULL, gc);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    buf_printf(&amp;hname, &quot;%s=2E%s&quot;, rnd_str, ho=
stname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return BS=
TR(&amp;hname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef=
 n_rnd_bytes</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * Translate IPv4/IPv6 addr or hostname into struct addrinfo</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * If resolve error, try again=
 for resolve_retry_seconds seconds=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn_getaddrinfo(=
unsigned int flags, const char *hostname, const char *servname,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    int resolve_r=
etry_seconds, struct signal_info *sig_info, int ai_family,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    struct addrinfo **=
res)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct addrinfo hints;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int status;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct signal_info sigrec =3D { 0 =
};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msglvl_t msglev=
el =3D (flags &amp; GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *p=
rint_hostname;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st char *print_servname;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(res);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(hostname || servname);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(!(flags &amp; GETADD=
R_HOST_ORDER));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (servname)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        print_servname =3D servname;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      print_servname =3D &quot;&quot;;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (flags &amp; =
GETADDR_MSG_VIRT_OUT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msglevel=
 |=3D M_MSG_VIRT_OUT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if ((flags &amp; (GETADDR_FATAL_O=
N_SIGNAL | GETADDR_WARN_ON_SIGNAL)) &amp;&amp; !sig_info)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        sig_info =3D &amp;sigrec;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* try numeric ip addr first */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    CLEAR(hints);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    hints=2Eai_flags =3D AI_NUMERICHOST;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (flags &amp; GETADDR_PASSIVE)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        hints=2Eai_flags |=3D AI_PASSIVE;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (flags &=
amp; GETADDR_DATAGRAM)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        hints=
=2Eai_socktype =3D SOCK_DGRAM;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        hints=2Eai_socktype =3D SOCK=
_STREAM;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* if hostname is not set, we want to bind to =
&#39;ANY&#39;, with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   * the correct address family - v4-only or v6/v6-dual-stack */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!hostname)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        hints=2Eai_family =3D ai_family;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    status =3D getaddrinfo(hostname, servname, &amp;hints, res);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (status !=3D 0)                      /* =
parse as numeric address failed? */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      const int fail_wait_interval =3D 5; /* seconds */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        /* Add +4 to cause integer divisi=
on rounding up (1 + 4) =3D 5, (0+4)/5=3D0 */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        int resolve_retries =3D</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            (flags &amp; GETADDR_TRY_ONCE)=
 ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        const char *fmt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        msglvl_t level =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /* this is not a numeric IP, therefore f=
orce resolution using the</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-         * provided ai_family */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        hints=2Eai_family =3D ai_family;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (hostname &amp;&amp; (flags &amp; GETADDR_RANDOMIZE=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            hostname =3D hostna=
me_randomize(hostname, &amp;gc);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (hostname)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            print_hostname =3D hos=
tname;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            print_hostname =3D &quot;undefined&q=
uot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        fmt =3D &quot;RESOLVE: Cannot resolve hos=
t address: %s:%s%s (%s)&quot;;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if ((flags &amp; GETADDR_MENTION_RESOLVE_RETRY) &amp;&amp;=
 !resolve_retry_seconds)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   fmt =3D &quot;RESOLVE: Cannot resolve host address: %s:%s%s (%s)&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  &quot=
;(I would have retried this name query if you had &quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                  &quot;specified the --=
resolv-retry option=2E)&quot;;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!(flags &amp=
; GETADDR_RESOLVE) || status =3D=3D EAI_FAIL)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            msg(msglevel, &quot;RESOLVE: Cannot parse IP addres=
s: %s:%s (%s)&quot;, print_hostname,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                print_servname, gai_strerror(status));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto done;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (flags &amp; GETADDR_UPDATE_MANAGEMENT_STATE)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            if (management)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                management_set_stat=
e(management, OPENVPN_STATE_RESOLVE, NULL, NULL, NULL, NULL,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                    =
 NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
   * Resolve hostname</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        wh=
ile (true)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef _WIN32</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            /* force resolv=2E=
conf reload */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     res_init();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* try h=
ostname lookup */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        hints=2Eai_flags &amp;=3D ~AI_NUMERICHOST;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            dmsg(D_SOCKET_DEBUG, &quot;GETADDR=
INFO flags=3D0x%04x ai_family=3D%d ai_socktype=3D%d&quot;, flags,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                 hints=2Eai_fam=
ily, hints=2Eai_socktype);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            status =3D getaddrinfo(hostname, servname, &amp;hints, res=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if (sig_info)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                get_signal(&amp;sig_info-&g=
t;signal_received);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              if (sig_info-&gt;signal_received) /* were we interrupted by a=
 signal? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      /* why are we overwriting SIGUSR1 ? */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    if (signal_reset(sig_info, SIGUS=
R1) =3D=3D SIGUSR1) /* ignore SIGUSR1 */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                        msg(level, &quot;RESOLVE: Ignore=
d SIGUSR1 signal received during &quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                   &quot;DNS resolution a=
ttempt&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    /* turn success into failure (interrupted syscall) */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 if (0 =3D=3D status)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                            ASSERT(res);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                            freeaddrinfo(*res);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
  *res =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                       status =3D EAI_AGAIN; /* =3D temporary failure */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
    errno =3D EINTR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        goto done;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* su=
ccess? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
if (0 =3D=3D status)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            /* resolve lookup failed,=
 should we</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
  * continue or fail? */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            level =3D msglevel;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            if (resolve_retries &gt; 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                level =3D D_RESOLVE_ERRORS;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            msg(level, fmt, print_hostname, print_servname=
, getaddrinfo_addr_family_name(ai_family),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                gai_strerror(status));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            if (--resolve_retries &lt;=3D 0)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                goto done;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            management_sleep(fail_wait_interval);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        ASSERT(res);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* hostname=
 resolve succeeded */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-         * Do not choose an IP A=
ddresse by random or change the order *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-         * of IP addresses, doing so will break RFC 3484 =
address selection *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
       */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        /* IP address parse succeeded */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (flags &amp; GETADDR_RANDOM=
IZE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot=
;WARNING: ignoring --remote-random-hostname because the &quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        &quot;host=
name is an IP address&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-done:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (sig_info &amp;&amp; sig_info-&gt;signal_received)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msglvl_t level =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (flags &amp; GETAD=
DR_FATAL_ON_SIGNAL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            le=
vel =3D M_FATAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (=
flags &amp; GETADDR_WARN_ON_SIGNAL)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            level =3D M_WARN;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      msg(level, &quot;RESOLVE: signal received during DNS resolution attem=
pt&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return status;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> /*</span><br><span>  * We do our own inet_aton becaus=
e the glibc function</span><br><span>  * isn&#39;t very good about error ch=
ecking=2E</span><br><span>diff --git a/src/openvpn/socket_util=2Eh b/src/op=
envpn/socket_util=2Eh</span><br><span>index 13f5962=2E=2E038ec36 100644</sp=
an><br><span>--- a/src/openvpn/socket_util=2Eh</span><br><span>+++ b/src/op=
envpn/socket_util=2Eh</span><br><span>@@ -110,44 +110,6 @@</span><br><span>=
 void setenv_link_socket_actual(struct env_set *es, const char *name_prefix=
,</span><br><span>                                const struct link_socket_=
actual *act, const unsigned int flags);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * DNS resolution</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_RESOLVE   =
              (1u &lt;&lt; 0)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define GETADDR_FATAL                   (1u &lt;&lt; 1)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_HOST_ORDER       =
       (1u &lt;&lt; 2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define GETADDR_MENTION_RESOLVE_RETRY   (1u &lt;&lt; 3)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_FATAL_ON_SIGNAL         =
(1u &lt;&lt; 4)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e GETADDR_WARN_ON_SIGNAL          (1u &lt;&lt; 5)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define GETADDR_MSG_VIRT_OUT            (1u &lt=
;&lt; 6)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETAD=
DR_TRY_ONCE                (1u &lt;&lt; 7)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define GETADDR_UPDATE_MANAGEMENT_STATE (1u &lt;&lt; 8=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_RAND=
OMIZE               (1u &lt;&lt; 9)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define GETADDR_PASSIVE                 (1u &lt;&lt; 10)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_DATAGRAM  =
              (1u &lt;&lt; 11)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETA=
DDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Tran=
slate an IPv4 addr or hostname from string form to in_addr_t</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * In case of resolve error, it will try again for</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * resolve_retry_seconds s=
econds=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-in_addr_t getaddr(unsigned int=
 flags, const char *hostname, int resolve_retry_seconds,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                  bool *succeeded, struc=
t signal_info *sig_info);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * Translate an IPv6 addr or hostna=
me from string form to in6_addr</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool get=
_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int *ne=
tbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
    msglvl_t msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int openvpn_getaddr=
info(unsigned int flags, const char *hostname, const char *servname,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        int =
resolve_retry_seconds, struct signal_info *sig_info, int ai_family,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        struc=
t addrinfo **res);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> /* return values of openvpn_inet_aton */</span><br><span> #d=
efine OIA_HOSTNAME 0</span><br><span> #define OIA_IP       1</span><br><spa=
n>@@ -301,7 +263,7 @@</span><br><span> }</span><br><span> #endif</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Overhea=
d added to packets by various protocols=2E</span><br><span>  */</span><br><=
span> static inline int</span><br><span>diff --git a/src/openvpn/tun=2Ec b/=
src/openvpn/tun=2Ec</span><br><span>index 133f670=2E=2Efcde7fc 100644</span=
><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=
=2Ec</span><br><span>@@ -39,7 +39,7 @@</span><br><span> #include &quot;fdmi=
sc=2Eh&quot;</span><br><span> #include &quot;common=2Eh&quot;</span><br><sp=
an> #include &quot;run_command=2Eh&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#include &quot;socket_util=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span>=
<br><span> #include &quot;manage=2Eh&quot;</span><br><span> #include &quot;=
route=2Eh&quot;</span><br><span> #include &quot;win32=2Eh&quot;</span><br><=
/pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1846?usp=3Demail">change 1846</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1846?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1846 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>

</body></html>
--nRnLnmQN1Qc=--


--===============8277539542763393062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8277539542763393062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8277539542763393062==--

