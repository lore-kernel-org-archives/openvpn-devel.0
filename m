Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3070606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NmvCnWZW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KjMxACBu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TOwAhAMB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DP6ezgi/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OcntQuKkDdLRoreBjb0XKPkrS4nMQiSLIwDsfogsCIk=; b=NmvCnWZWOUeoXOkKbLwsGoRKyZ
	A3OfygGLfohz7cwgAnP4vtHOwpLiDOZC1bGU3L5A1wB/EcFnsMS27rHQErDTlTreidX7o9q6DIVSl
	XEVkGJekP9O4KdsNsOV34tRjl2dhhdYImEnk8csxc2UKk7Y6s9de2QH19N+C2ztpm4DA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJ9aq-000874-0e;
	Tue, 20 Oct 2026 13:09:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJ9ao-00086s-Lq
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 13:09:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=e/25leHJuNKMEk73jzozwiTCqsWR/csPDXVtfPNzUuA=; b=KjMxACBusu0a080BOtu7+3zSxP
 Gr/WJt83TFE0wkv8eNRpiuR1jf+chAV7RI8ttpeJe2uTdEYYUPMEpNuDVqMqszHmItlQ6czO0/AHB
 MtP4MR3aqmsIb1AKeQvR60+ttveESaqkkIGmJF0baMObLBoAPxMBUQwxhHfDv9/M1cOk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=e/25leHJuNKMEk73jzozwiTCqsWR/csPDXVtfPNzUuA=; b=T
 OwAhAMBLhhE+7zn59pZn9ZE6htSfnYfySJJ9DIHoqC3XKNKyV/GH3yBeTH8wRG4Pba7PsRcpG5xL2
 LZ5vyNt7x0tgtIpNCRwi6fRAXBoZDW/fuyy0R6+NoaU93vMRxkjlVJqm6pjFpBB9+6aL+8qLCSBGI
 tFEZca0gbZ2cS+9E=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJ9ai-0001Qv-M1 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 13:09:27 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so32828325e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792501754; x=1793106554; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e/25leHJuNKMEk73jzozwiTCqsWR/csPDXVtfPNzUuA=;
 b=DP6ezgi/UAwIXqjutZNhGlb8Vi2IJcemHAtF6fb7gPic08tbMUq3flmXBZJCLP4rm+
 yXdkLN8fWfUCNBS0N2AJAIf7Af0MKbgMuzbt9bzwePxVQlxg4BDdg2FvfFNbln93IE/X
 brNId12Ek6CqwiDZYz99v2IiAArbWOVQJTHqVzSitaJ+R3FnOl5YwykDoqVcoMdM8s8h
 QRrOfAdq5R5j2AfDn3hsrcTyJsU29hVHxHdAxrXTZlDZAvBa6e1HM7R2SZtnh/eYndeD
 lsn6vb34irgw6yg/u008ff+7+zPYKrW7OigH8V+KjNyA2mo4pnINvt0b3Dr83XKrL9yl
 cLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792501754; x=1793106554;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e/25leHJuNKMEk73jzozwiTCqsWR/csPDXVtfPNzUuA=;
 b=EZRw91OaJLdqnsyluVUYzlqahBHUa3x4uhGEAhom1E6iRhoiRVaypClRFRrcsNyyHx
 mHY6rb3bIfhs4jrpGxBqiyXjXdmUBT9AzkLtcT+lzKWNH8mhym3E5iE7Pr/v/eKPSeEr
 bJT5tuP7xA5fJoLpZd6CTYcdCk/n3WQQORqsohY+nB/YrUsGD5Oo9uTp/2BdIFgcRrt0
 YDNlimrm199FfkgWogrdHjNzKw3nzVNYue91XEzxLclnE9Mr57dlPZ0au9hXmE7Hf365
 kfxQear2E42WmTYLazWWL5hLg94kGeCxsq6PC7t6DibTSBqZZ63abjlc+ZRBE1Z5tMo9
 Yxgg==
X-Forwarded-Encrypted: i=1;
 AKwUvByv8Zz+Ed9tOim8xjOPfYKvVvSgr/F/pA3+bPNPa3GWA/XCLJrVh0zU/VjK+6cS0XoCmd0Nw52Df27abNti@lists.sourceforge.net
X-Gm-Message-State: AFq9FYILBEVrqcD+9rQXkg9Lp38tYBPuVyiaeGItpURX+fMwm582bMd2
 v+DT5GDCD6Mwm/fsN8D1s8gZfbc3eC3hNi0HeUvN9w1K0+PS/qj8RVZGxHE2S0q0C44zaKvo7Ux
 di+K88xuOksCmdIQFP/AP0s0ZTQ/WlFZ1gXo4l/Ra2pQ1z/qxANvzlwYDcuzw75CoDS5zCx4UmC
 pDfGBG8Q==
X-Gm-Gg: AYBFou0/HsAun4Z4TylGqqZqGG/u+Iv72JoOAlubshxQEZVCNzkILVFsLrXm9KAXB1j
 EsUFovebaf6uM15IE5Smkbi+liGlLZrvTNTcDbJgjXdTCStYc5JqoMe1Iu2lKsYwTRpRwiYCZJG
 LWWJ7rTk9vRYQWxuspGCCgk0b2qTK9F7xX4S/DF/RFen3Kx257wJg+LMg6NEWxwFF163RSoqtqJ
 EWIXKsd7+lCrKrL5IF4PXHsRgyk/3s622GstFnJYjOaQljCIh3D5v7zBzJjB+ZZG8ixpfu0autb
 j9IhXi+eSR6u8bhX7NcK4qFfoVjAxMBG9x6B0MkvrlzAETh1DwtqkY6K/h66F5JCaci0vdpxIDL
 tTn2n3EGmIy2i0ETpuNKtTLqYftTzk6R5Zv3yJJSa/ZuAEEJi8NLw3qUYSdQ+wqT0BN84LD1HPz
 sfJbKCf3Nnb+SeXE6j2UYRp05PZlEt4tPqWgtrY6yD+e3MtM+o8Aznu0yUsyEdq4Ad21H+uuEe2
 nn40C9Sj3pEGH0kf6voHwNoofk8Mh/bWpIEpa2UkZrMR0Y8Pj5c8QL0ZBUB8b0unWwQI3TNuMcf
 SwuJhFabF6PbAru414g3FEGMlB10OJegSkzfIXM2qftfhIhGHfP3vuSkROV2hbkSDgJmpEY=
X-Received: by 2002:a05:600c:6218:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4a1ddaa5803mr217728435e9.15.1792501753278; 
 Tue, 20 Oct 2026 06:09:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8178dbsm6388798f8f.21.2026.10.20.06.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 06:09:11 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 13:09:10 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f
X-Gerrit-Change-Number: 1846
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1846?usp=email>
X-Gerrit-Commit: c83d2f22bbbfc81b4375d366972ccb338cf526a6
In-Reply-To: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
References: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTY4NDk1MDAwLkkxMmJlZjMzMGUyYzhhNWU1YjIxYzJmYTgwNzU4NDMxOWIyYjcxMDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d3538c374284671af97f40dcb6a3b4f3fde0d802-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJ9ai-0001Qv-M1
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Factor out address
 resolve code to a new file resolve.c
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2425705003864944910=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2425705003864944910==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PYWDBaQj0z4="; charset=UTF-8

--PYWDBaQj0z4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1846?usp=3Demail )

Change subject: Factor out address resolve =
code to a new file resolve=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Factor out address resolve code to a new file resolve=
=2Ec

The code was weirdly split between socket=2Ec, socket_util=2Ec,
and o=
ptions=2Ec=2E The new structure makes more sense=2E

While here move some r=
elated string helper code to buffer=2Eh=2E

Change-Id: I12bef330e2c8a5e5b21=
c2fa807584319b2b7101f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846
Message-Id: <20261018152900=2E22=
589-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg40027=2Ehtml
Signed-off-by: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=
=2Eam
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/clina=
t=2Ec
M src/openvpn/dns=2Ec
M src/openvpn/init=2Ec
M src/openvpn/manage=2Ec=

M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/pool=2Ec=

M src/openvpn/ps=2Ec
M src/openvpn/push=2Ec
A src/openvpn/resolve=2Ec
A sr=
c/openvpn/resolve=2Eh
M src/openvpn/route=2Ec
M src/openvpn/socket=2Ec
M sr=
c/openvpn/socket=2Eh
M src/openvpn/socket_util=2Ec
M src/openvpn/socket_uti=
l=2Eh
M src/openvpn/tun=2Ec
21 files changed, 816 insertions(+), 709 deleti=
ons(-)




diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index b85e461=
=2E=2E184a95a 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -578,=
6 +578,8 @@
     src/openvpn/reflect_filter=2Eh
     src/openvpn/reliable=
=2Ec
     src/openvpn/reliable=2Eh
+    src/openvpn/resolve=2Ec
+    src/op=
envpn/resolve=2Eh
     src/openvpn/route=2Ec
     src/openvpn/route=2Eh
   =
  src/openvpn/run_command=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/=
openvpn/Makefile=2Eam
index 9424801=2E=2E8a60a94 100644
--- a/src/openvpn/M=
akefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -128,6 +128,7 @@
 	pushlist=
=2Eh \
 	reflect_filter=2Ec reflect_filter=2Eh \
 	reliable=2Ec reliable=2E=
h \
+	resolve=2Ec resolve=2Eh \
 	route=2Ec route=2Eh \
 	run_command=2Ec r=
un_command=2Eh \
 	schedule=2Ec schedule=2Eh \
diff --git a/src/openvpn/buf=
fer=2Ec b/src/openvpn/buffer=2Ec
index 3599cc9=2E=2Ec683f8e 100644
--- a/sr=
c/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -1083,6 +1083,23 @@
  =
   }
 }
 
+bool
+streqnull(const char *a, const char *b)
+{
+    if (a =3D=
=3D NULL && b =3D=3D NULL)
+    {
+        return true;
+    }
+    else if=
 (a =3D=3D NULL || b =3D=3D NULL)
+    {
+        return false;
+    }
+   =
 else
+    {
+        return streq(a, b);
+    }
+}
+
 char *
 string_subst=
itute(const char *src, char from, char to, struct gc_arena *gc)
 {
diff --g=
it a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 74233c57=2E=2E7a=
f4444 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -=
1807,6 +1807,18 @@
     return 0 =3D=3D strncmp(str, prefix, strlen(prefix)=
);
 }
 
+/** helper to work around the semantics of the strcmp() return val=
ue
+ * @return true if the strings are equal according to strcmp()
+ */
+#d=
efine streq(x, y) (!strcmp((x), (y)))
+
+/** compare two strings which migh=
t be NULL
+ * @return true if both strings are NULL, or if they are equal a=
ccording to strcmp()
+ */
+bool streqnull(const char *a, const char *b);
+/=
** compare two strings which might be NULL, but NULL is never equal
+ * @re=
turn true if neither string is NULL and they are equal according to strcmp(=
)
+ */
 bool string_defined_equal(const char *s1, const char *s2);
 char *s=
tring_substitute(const char *src, char from, char to, struct gc_arena *gc);=

 
diff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec
index d72d4=
2a=2E=2Efc4acef 100644
--- a/src/openvpn/clinat=2Ec
+++ b/src/openvpn/clina=
t=2Ec
@@ -30,6 +30,7 @@
 #include "proto=2Eh"
 #include "socket_util=2Eh"
 =
#include "memdbg=2Eh"
+#include "resolve=2Eh"
 
 static bool
 add_entry(str=
uct client_nat_option_list *dest, const struct client_nat_entry *e)
diff --=
git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index 87c9c5f=2E=2Ee5ed1bc =
100644
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -27,7 +27,7 @=
@
 #include "syshead=2Eh"
 
 #include "dns=2Eh"
-#include "socket_util=2Eh"=

+#include "resolve=2Eh"
 #include "options=2Eh"
 #include "run_command=2Eh=
"
 #include "domain_helper=2Eh"
diff --git a/src/openvpn/init=2Ec b/src/ope=
nvpn/init=2Ec
index ddcfaf4=2E=2E24cf532 100644
--- a/src/openvpn/init=2Ec
=
+++ b/src/openvpn/init=2Ec
@@ -55,6 +55,7 @@
 #include "tun_afunix=2Eh"
 #i=
nclude "schedule=2Eh"
 #include "options_string=2Eh"
+#include "resolve=2Eh=
"
 
 #include "memdbg=2Eh"
 
diff --git a/src/openvpn/manage=2Ec b/src/open=
vpn/manage=2Ec
index 007dd2a=2E=2E0fc9ee2 100644
--- a/src/openvpn/manage=
=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -44,6 +44,7 @@
 #include "dco=2Eh"
 #i=
nclude "push=2Eh"
 #include "multi=2Eh"
+#include "resolve=2Eh"
 
 #include=
 "memdbg=2Eh"
 
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec
index 1630731=2E=2E8e0c602 100644
--- a/src/openvpn/options=2Ec
+++ b/=
src/openvpn/options=2Ec
@@ -64,6 +64,7 @@
 #include "domain_helper=2Eh"
 #i=
nclude "mbuf=2Eh"
 #include "check_file_access=2Eh"
+#include "resolve=2Eh"=

 
 #include <ctype=2Eh>
 
@@ -1044,26 +1045,6 @@
 
 #endif /* ifndef _WIN3=
2 */
 
-static in_addr_t
-get_ip_addr(const char *ip_string, msglvl_t msgle=
vel, bool *error)
-{
-    unsigned int flags =3D GETADDR_HOST_ORDER;
-    b=
ool succeeded =3D false;
-    in_addr_t ret;
-
-    if (msglevel & M_FATAL)=

-    {
-        flags |=3D GETADDR_FATAL;
-    }
-
-    ret =3D getaddr(fl=
ags, ip_string, 0, &succeeded, NULL);
-    if (!succeeded && error)
-    {
=
-        *error =3D true;
-    }
-    return ret;
-}
-
 /**
  * Returns new=
ly allocated string containing address part without "/nn"=2E
  *
@@ -1086,1=
3 +1067,6 @@
     }
     return ret;
 }
-
-static bool
-ipv6_addr_safe_hexp=
lusbits(const char *ipv6_prefix_spec)
-{
-    return get_ipv6_addr(ipv6_pre=
fix_spec, NULL, NULL, M_WARN);
-}
-
 /**
  * Parses a hexstring and checks =
if the string has the correct length=2E Return
  * a verify_hash_list conta=
ining the parsed hash string=2E
@@ -3330,7 +3304,7 @@
     options_postproc=
ess_verify(options);
 #ifndef ENABLE_SMALL
     options_postprocess_fileche=
cks(options);
-#endif /* !ENABLE_SMALL */
+#endif
 }
 
 /*
diff --git a/src=
/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 693d9cf=2E=2Ec58530a 1=
00644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -727,8=
 +727,6 @@
     unsigned int imported_protocol_flags;
 };
 
-#define streq(=
x, y) (!strcmp((x), (y)))
-
 /*
  * Option classes=2E
  */
diff --git a/src=
/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index 63fc930=2E=2Efff0e3f 100644
=
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -31,6 +31,7 @@
 #i=
nclude "error=2Eh"
 #include "socket_util=2Eh"
 #include "otime=2Eh"
+#incl=
ude "resolve=2Eh"
 
 #include "memdbg=2Eh"
 
diff --git a/src/openvpn/ps=2E=
c b/src/openvpn/ps=2Ec
index 3ba983f=2E=2E03c6f48 100644
--- a/src/openvpn/=
ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -32,6 +32,7 @@
 #include "socket=2Eh"
 #=
include "fdmisc=2Eh"
 #include "crypto=2Eh"
+#include "resolve=2Eh"
 #inclu=
de "ps=2Eh"
 
 #include "memdbg=2Eh"
diff --git a/src/openvpn/push=2Ec b/sr=
c/openvpn/push=2Ec
index ad95a0f=2E=2E42259c3 100644
--- a/src/openvpn/push=
=2Ec
+++ b/src/openvpn/push=2Ec
@@ -37,6 +37,7 @@
 #include "memdbg=2Eh"
 #=
include "ssl_util=2Eh"
 #include "options_util=2Eh"
+#include "resolve=2Eh"=

 
 /*
  * Auth username/password
diff --git a/src/openvpn/resolve=2Ec b/sr=
c/openvpn/resolve=2Ec
new file mode 100644
index 0000000=2E=2Eb8d9899
--- /=
dev/null
+++ b/src/openvpn/resolve=2Ec
@@ -0,0 +1,665 @@
+/*
+ *  OpenVPN -=
- An application to securely tunnel IP networks
+ *             over a sing=
le TCP/UDP port, with support for SSL/TLS-based
+ *             session aut=
hentication and key exchange,
+ *             packet encryption, packet aut=
hentication, and
+ *             packet compression=2E
+ *
+ *  Copyright (=
C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is fre=
e software; you can redistribute it and/or modify
+ *  it under the terms o=
f the GNU General Public License version 2
+ *  as published by the Free So=
ftware Foundation=2E
+ *
+ *  This program is distributed in the hope that =
it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied =
warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  Se=
e the
+ *  GNU General Public License for more details=2E
+ *
+ *  You shou=
ld have received a copy of the GNU General Public License along
+ *  with t=
his program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#if=
def HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
=
+
+#include "buffer=2Eh"
+#include "crypto=2Eh"
+#include "manage=2Eh"
+#in=
clude "openvpn=2Eh"
+#include "socket=2Eh"
+#include "socket_util=2Eh"
+
+#=
include "resolve=2Eh"
+
+/*
+ * Convert sockflags/getaddr_flags into getadd=
r_flags
+ */
+unsigned int
+sf2gaf(const unsigned int getaddr_flags, const =
unsigned int sockflags)
+{
+    if (sockflags & SF_HOST_RANDOMIZE)
+    {
+=
        return getaddr_flags | GETADDR_RANDOMIZE;
+    }
+    else
+    {
+=
        return getaddr_flags;
+    }
+}
+
+/*
+ * Functions related to the =
translation of DNS names to IP addresses=2E
+ */
+
+/**
+ * Small helper fu=
nction for openvpn_getaddrinfo to print the address
+ * family when resolvi=
ng fails
+ */
+static const char *
+getaddrinfo_addr_family_name(int af)
+{=

+    switch (af)
+    {
+        case AF_INET:
+            return "[AF_IN=
ET]";
+
+        case AF_INET6:
+            return "[AF_INET6]";
+    }
+ =
   return "";
+}
+
+/*
+ * Prepend a random string to hostname to prevent D=
NS caching=2E
+ * For example, foo=2Ebar=2Egov would be modified to <random=
-chars>=2Efoo=2Ebar=2Egov=2E
+ * Of course, this requires explicit support =
in the DNS server (wildcard)=2E
+ */
+static const char *
+hostname_randomi=
ze(const char *hostname, struct gc_arena *gc)
+{
+#define n_rnd_bytes 6
+
+=
    uint8_t rnd_bytes[n_rnd_bytes];
+    const char *rnd_str;
+    struct b=
uffer hname =3D alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes) * 2 + 4, =
gc);
+
+    prng_bytes(rnd_bytes, sizeof(rnd_bytes));
+    rnd_str =3D form=
at_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);
+    buf_printf(&=
hname, "%s=2E%s", rnd_str, hostname);
+    return BSTR(&hname);
+#undef n_r=
nd_bytes
+}
+
+/*
+ * Translate IPv4/IPv6 addr or hostname into struct addr=
info
+ * If resolve error, try again for resolve_retry_seconds seconds=2E
+=
 */
+int
+openvpn_getaddrinfo(unsigned int flags, const char *hostname, con=
st char *servname,
+                    int resolve_retry_seconds, struct s=
ignal_info *sig_info, int ai_family,
+                    struct addrinfo *=
*res)
+{
+    struct addrinfo hints;
+    int status;
+    struct signal_in=
fo sigrec =3D { 0 };
+    msglvl_t msglevel =3D (flags & GETADDR_FATAL) ? M=
_FATAL : D_RESOLVE_ERRORS;
+    struct gc_arena gc =3D gc_new();
+    const=
 char *print_hostname;
+    const char *print_servname;
+
+    ASSERT(res);=

+
+    ASSERT(hostname || servname);
+    ASSERT(!(flags & GETADDR_HOST_OR=
DER));
+
+    if (servname)
+    {
+        print_servname =3D servname;
+ =
   }
+    else
+    {
+        print_servname =3D "";
+    }
+
+    if (fla=
gs & GETADDR_MSG_VIRT_OUT)
+    {
+        msglevel |=3D M_MSG_VIRT_OUT;
+ =
   }
+
+    if ((flags & (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)=
) && !sig_info)
+    {
+        sig_info =3D &sigrec;
+    }
+
+    /* try =
numeric ip addr first */
+    CLEAR(hints);
+    hints=2Eai_flags =3D AI_NU=
MERICHOST;
+
+    if (flags & GETADDR_PASSIVE)
+    {
+        hints=2Eai_f=
lags |=3D AI_PASSIVE;
+    }
+
+    if (flags & GETADDR_DATAGRAM)
+    {
+ =
       hints=2Eai_socktype =3D SOCK_DGRAM;
+    }
+    else
+    {
+       =
 hints=2Eai_socktype =3D SOCK_STREAM;
+    }
+
+    /* if hostname is not s=
et, we want to bind to 'ANY', with
+     * the correct address family - v4-=
only or v6/v6-dual-stack */
+    if (!hostname)
+    {
+        hints=2Eai_=
family =3D ai_family;
+    }
+
+    status =3D getaddrinfo(hostname, servna=
me, &hints, res);
+
+    if (status !=3D 0)                      /* parse a=
s numeric address failed? */
+    {
+        const int fail_wait_interval =
=3D 5; /* seconds */
+        /* Add +4 to cause integer division rounding =
up (1 + 4) =3D 5, (0+4)/5=3D0 */
+        int resolve_retries =3D
+        =
    (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wa=
it_interval);
+        const char *fmt;
+        msglvl_t level =3D 0;
+
+ =
       /* this is not a numeric IP, therefore force resolution using the
+ =
        * provided ai_family */
+        hints=2Eai_family =3D ai_family;
+=

+        if (hostname && (flags & GETADDR_RANDOMIZE))
+        {
+        =
    hostname =3D hostname_randomize(hostname, &gc);
+        }
+
+        i=
f (hostname)
+        {
+            print_hostname =3D hostname;
+        =
}
+        else
+        {
+            print_hostname =3D "undefined";
+  =
      }
+
+        fmt =3D "RESOLVE: Cannot resolve host address: %s:%s%s (=
%s)";
+        if ((flags & GETADDR_MENTION_RESOLVE_RETRY) && !resolve_retr=
y_seconds)
+        {
+            fmt =3D "RESOLVE: Cannot resolve host ad=
dress: %s:%s%s (%s)"
+                  "(I would have retried this name qu=
ery if you had "
+                  "specified the --resolv-retry option=2E=
)";
+        }
+
+        if (!(flags & GETADDR_RESOLVE) || status =3D=3D E=
AI_FAIL)
+        {
+            msg(msglevel, "RESOLVE: Cannot parse IP ad=
dress: %s:%s (%s)", print_hostname,
+                print_servname, gai_st=
rerror(status));
+            goto done;
+        }
+
+#ifdef ENABLE_MANAGE=
MENT
+        if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
+        {
+    =
        if (management)
+            {
+                management_set_stat=
e(management, OPENVPN_STATE_RESOLVE, NULL, NULL, NULL, NULL,
+             =
                        NULL);
+            }
+        }
+#endif
+
+       =
 /*
+         * Resolve hostname
+         */
+        while (true)
+      =
  {
+#ifndef _WIN32
+            /* force resolv=2Econf reload */
+        =
    res_init();
+#endif
+            /* try hostname lookup */
+           =
 hints=2Eai_flags &=3D ~AI_NUMERICHOST;
+            dmsg(D_SOCKET_DEBUG, "=
GETADDRINFO flags=3D0x%04x ai_family=3D%d ai_socktype=3D%d", flags,
+      =
           hints=2Eai_family, hints=2Eai_socktype);
+            status =3D=
 getaddrinfo(hostname, servname, &hints, res);
+
+            if (sig_info)=

+            {
+                get_signal(&sig_info->signal_received);
+ =
               if (sig_info->signal_received) /* were we interrupted by a s=
ignal? */
+                {
+                    /* why are we overwriting=
 SIGUSR1 ? */
+                    if (signal_reset(sig_info, SIGUSR1) =3D=
=3D SIGUSR1) /* ignore SIGUSR1 */
+                    {
+                 =
       msg(level, "RESOLVE: Ignored SIGUSR1 signal received during "
+     =
                              "DNS resolution attempt");
+                 =
   }
+                    else
+                    {
+                    =
    /* turn success into failure (interrupted syscall) */
+                =
        if (0 =3D=3D status)
+                        {
+                  =
          ASSERT(res);
+                            freeaddrinfo(*res);
+  =
                          *res =3D NULL;
+                            statu=
s =3D EAI_AGAIN; /* =3D temporary failure */
+                            e=
rrno =3D EINTR;
+                        }
+                        goto do=
ne;
+                    }
+                }
+            }
+
+           =
 /* success? */
+            if (0 =3D=3D status)
+            {
+         =
       break;
+            }
+
+            /* resolve lookup failed, shoul=
d we
+             * continue or fail? */
+            level =3D msglevel;
=
+            if (resolve_retries > 0)
+            {
+                level=
 =3D D_RESOLVE_ERRORS;
+            }
+
+            msg(level, fmt, print_=
hostname, print_servname, getaddrinfo_addr_family_name(ai_family),
+       =
         gai_strerror(status));
+
+            if (--resolve_retries <=3D 0=
)
+            {
+                goto done;
+            }
+
+            =
management_sleep(fail_wait_interval);
+        }
+
+        ASSERT(res);
+
=
+        /* hostname resolve succeeded */
+
+        /*
+         * Do not =
choose an IP Addresse by random or change the order *
+         * of IP add=
resses, doing so will break RFC 3484 address selection *
+         */
+    =
}
+    else
+    {
+        /* IP address parse succeeded */
+        if (f=
lags & GETADDR_RANDOMIZE)
+        {
+            msg(M_WARN, "WARNING: ign=
oring --remote-random-hostname because the "
+                        "host=
name is an IP address");
+        }
+    }
+
+done:
+    if (sig_info && si=
g_info->signal_received)
+    {
+        msglvl_t level =3D 0;
+        if =
(flags & GETADDR_FATAL_ON_SIGNAL)
+        {
+            level =3D M_FATAL=
;
+        }
+        else if (flags & GETADDR_WARN_ON_SIGNAL)
+        {
+=
            level =3D M_WARN;
+        }
+        msg(level, "RESOLVE: sign=
al received during DNS resolution attempt");
+    }
+
+    gc_free(&gc);
+ =
   return status;
+}
+
+static int
+get_addr_generic(sa_family_t af, unsign=
ed int flags, const char *hostname, void *network,
+                 unsign=
ed int *netbits, int resolve_retry_seconds, struct signal_info *sig_info,
+=
                 msglvl_t msglevel)
+{
+    char *endp, *sep, *var_host =3D=
 NULL;
+    struct addrinfo *ai =3D NULL;
+    unsigned long bits;
+    uin=
t8_t max_bits;
+    int ret =3D -1;
+
+    if (!hostname)
+    {
+        m=
sg(M_NONFATAL, "Can't resolve null hostname!");
+        goto out;
+    }
+=

+    /* assign family specific default values */
+    switch (af)
+    {
+=
        case AF_INET:
+            bits =3D 0;
+            max_bits =3D si=
zeof(in_addr_t) * 8;
+            break;
+
+        case AF_INET6:
+       =
     bits =3D 64;
+            max_bits =3D sizeof(struct in6_addr) * 8;
+ =
           break;
+
+        default:
+            msg(M_WARN, "Unsupported=
 AF family passed to getaddrinfo for %s (%d)", hostname, af);
+            =
goto out;
+    }
+
+    /* we need to modify the hostname received as input=
, but we don't want to
+     * touch it directly as it might be a constant =
string=2E
+     *
+     * Therefore, we clone the string here and free it a=
t the end of the
+     * function */
+    var_host =3D strdup(hostname);
+ =
   if (!var_host)
+    {
+        msg(M_NONFATAL | M_ERRNO, "Can't allocate=
 hostname buffer for getaddrinfo");
+        goto out;
+    }
+
+    /* che=
ck if this hostname has a /bits suffix */
+    sep =3D strchr(var_host, '/'=
);
+    if (sep)
+    {
+        bits =3D strtoul(sep + 1, &endp, 10);
+   =
     if ((*endp !=3D '\0') || (bits > max_bits))
+        {
+            ms=
g(msglevel, "IP prefix '%s': invalid '/bits' spec (%s)", hostname, sep + 1)=
;
+            goto out;
+        }
+        *sep =3D '\0';
+    }
+
+    r=
et =3D openvpn_getaddrinfo(flags & ~GETADDR_HOST_ORDER, var_host, NULL, res=
olve_retry_seconds,
+                              sig_info, af, &ai);
+   =
 if ((ret =3D=3D 0) && network)
+    {
+        struct in6_addr *ip6;
+    =
    in_addr_t *ip4;
+
+        if (af !=3D ai->ai_family)
+        {
+     =
       msg(msglevel, "Can't parse %s as IPv%d address", var_host, (af =3D=
=3D AF_INET) ? 4 : 6);
+            ret =3D -1;
+            goto out;
+   =
     }
+
+        switch (af)
+        {
+            case AF_INET:
+      =
          ip4 =3D network;
+                *ip4 =3D ((struct sockaddr_in *=
)ai->ai_addr)->sin_addr=2Es_addr;
+
+                if (flags & GETADDR_HO=
ST_ORDER)
+                {
+                    *ip4 =3D ntohl(*ip4);
+  =
              }
+                break;
+
+            case AF_INET6:
+    =
            ip6 =3D network;
+                *ip6 =3D ((struct sockaddr_in=
6 *)ai->ai_addr)->sin6_addr;
+                break;
+
+            default=
:
+                /* can't get here because 'af' was previously checked */=

+                msg(M_WARN, "Unsupported AF family for %s (%d)", var_host=
, af);
+                goto out;
+        }
+    }
+
+    if (netbits)
+  =
  {
+        *netbits =3D (unsigned int)bits;
+    }
+
+    /* restore '/' =
separator, if any */
+    if (sep)
+    {
+        *sep =3D '/';
+    }
+ou=
t:
+    if (ai)
+    {
+        freeaddrinfo(ai);
+    }
+    free(var_host=
);
+
+    return ret;
+}
+
+in_addr_t
+getaddr(unsigned int flags, const ch=
ar *hostname, int resolve_retry_seconds, bool *succeeded,
+        struct s=
ignal_info *sig_info)
+{
+    in_addr_t addr =3D { 0 };
+    int status;
+
=
+    status =3D get_addr_generic(AF_INET, flags, hostname, &addr, NULL, res=
olve_retry_seconds,
+                              sig_info, M_WARN);
+    =
if (status =3D=3D 0)
+    {
+        if (succeeded)
+        {
+           =
 *succeeded =3D true;
+        }
+        return addr;
+    }
+    else
+  =
  {
+        if (succeeded)
+        {
+            *succeeded =3D false;
+=
        }
+        return 0;
+    }
+}
+
+in_addr_t
+get_ip_addr(const char=
 *ip_string, msglvl_t msglevel, bool *error)
+{
+    unsigned int flags =3D=
 GETADDR_HOST_ORDER;
+    bool succeeded =3D false;
+    in_addr_t ret;
+
+=
    if (msglevel & M_FATAL)
+    {
+        flags |=3D GETADDR_FATAL;
+    =
}
+
+    ret =3D getaddr(flags, ip_string, 0, &succeeded, NULL);
+    if (!=
succeeded && error)
+    {
+        *error =3D true;
+    }
+    return ret=
;
+}
+
+bool
+get_ipv6_addr(const char *hostname, struct in6_addr *network,=
 unsigned int *netbits,
+              msglvl_t msglevel)
+{
+    if (get_a=
ddr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, netbits, 0, NULL,=
 msglevel)
+        < 0)
+    {
+        return false;
+    }
+
+    return=
 true; /* parsing OK, values set */
+}
+
+/*
+ * get_cached_dns_entry retur=
n 0 on success and -1
+ * otherwise=2E (like getaddrinfo)
+ */
+int
+get_ca=
ched_dns_entry(struct cached_dns_entry *dns_cache, const char *hostname, co=
nst char *servname,
+                     int ai_family, unsigned int resol=
ve_flags, struct addrinfo **ai)
+{
+    struct cached_dns_entry *ph;
+    u=
nsigned int flags;
+
+    /* Only use flags that are relevant for the struc=
ture */
+    flags =3D resolve_flags & GETADDR_CACHE_MASK;
+
+    for (ph =
=3D dns_cache; ph; ph =3D ph->next)
+    {
+        if (streqnull(ph->hostn=
ame, hostname) && streqnull(ph->servname, servname)
+            && ph->ai_=
family =3D=3D ai_family && ph->flags =3D=3D flags)
+        {
+            =
*ai =3D ph->ai;
+            return 0;
+        }
+    }
+    return -1;
+}=

+
+
+static int
+do_preresolve_host(struct context *c, const char *hostnam=
e, const char *servname, const int af,
+                   const unsigned i=
nt flags)
+{
+    struct addrinfo *ai;
+    int status;
+
+    if (get_cach=
ed_dns_entry(c->c1=2Edns_cache, hostname, servname, af, flags, &ai) =3D=3D =
0)
+    {
+        /* entry already cached, return success */
+        retu=
rn 0;
+    }
+
+    status =3D openvpn_getaddrinfo(flags, hostname, servnam=
e, c->options=2Eresolve_retry_seconds, NULL,
+                             =
    af, &ai);
+    if (status =3D=3D 0)
+    {
+        struct cached_dns_e=
ntry *ph;
+
+        ALLOC_OBJ_CLEAR_GC(ph, struct cached_dns_entry, &c->gc=
);
+        ph->ai =3D ai;
+        ph->hostname =3D hostname;
+        ph-=
>servname =3D servname;
+        ph->flags =3D flags & GETADDR_CACHE_MASK;
=
+
+        if (!c->c1=2Edns_cache)
+        {
+            c->c1=2Edns_cach=
e =3D ph;
+        }
+        else
+        {
+            struct cached_dn=
s_entry *prev =3D c->c1=2Edns_cache;
+            while (prev->next)
+     =
       {
+                prev =3D prev->next;
+            }
+            =
prev->next =3D ph;
+        }
+
+        gc_addspecial(ai, &gc_freeaddrinfo=
_callback, &c->gc);
+    }
+    return status;
+}
+
+void
+do_preresolve(st=
ruct context *c)
+{
+    struct connection_list *l =3D c->options=2Econnect=
ion_list;
+    const unsigned int preresolve_flags =3D GETADDR_RESOLVE | GE=
TADDR_UPDATE_MANAGEMENT_STATE
+                                          | =
GETADDR_MENTION_RESOLVE_RETRY | GETADDR_FATAL;
+
+
+    for (int i =3D 0; i=
 < l->len; ++i)
+    {
+        int status;
+        const char *remote;
+ =
       unsigned int flags =3D preresolve_flags;
+
+        struct connectio=
n_entry *ce =3D l->array[i];
+
+        if (proto_is_dgram(ce->proto))
+   =
     {
+            flags |=3D GETADDR_DATAGRAM;
+        }
+
+        if (=
c->options=2Esockflags & SF_HOST_RANDOMIZE)
+        {
+            flags |=
=3D GETADDR_RANDOMIZE;
+        }
+
+        if (c->options=2Eip_remote_hin=
t)
+        {
+            remote =3D c->options=2Eip_remote_hint;
+       =
 }
+        else
+        {
+            remote =3D ce->remote;
+        }
=
+
+        /* HTTP remote hostname does not need to be resolved */
+       =
 if (!ce->http_proxy_options)
+        {
+            status =3D do_prereso=
lve_host(c, remote, ce->remote_port, ce->af, flags);
+            if (statu=
s !=3D 0)
+            {
+                goto err;
+            }
+       =
 }
+
+        /* Preresolve proxy */
+        if (ce->http_proxy_options)
+=
        {
+            status =3D do_preresolve_host(c, ce->http_proxy_opti=
ons->server,
+                                        ce->http_proxy_option=
s->port, ce->af, preresolve_flags);
+
+            if (status !=3D 0)
+    =
        {
+                goto err;
+            }
+        }
+
+        i=
f (ce->socks_proxy_server)
+        {
+            status =3D
+            =
    do_preresolve_host(c, ce->socks_proxy_server, ce->socks_proxy_port, ce-=
>af, flags);
+            if (status !=3D 0)
+            {
+              =
  goto err;
+            }
+        }
+
+        if (ce->bind_local)
+     =
   {
+            flags |=3D GETADDR_PASSIVE;
+            flags &=3D ~GETA=
DDR_RANDOMIZE;
+
+            for (int j =3D 0; j < ce->local_list->len; j+=
+)
+            {
+                const struct local_entry *le =3D ce->loc=
al_list->array[j];
+
+                if (!le->local)
+                {
+ =
                   continue;
+                }
+
+                status =
=3D do_preresolve_host(c, le->local, le->port, ce->af, flags);
+           =
     if (status !=3D 0)
+                {
+                    goto err;
+=
                }
+            }
+        }
+    }
+    return;
+
+err:
+  =
  throw_signal_soft(SIGHUP, "Preresolving failed");
+}
diff --git a/src/ope=
nvpn/resolve=2Eh b/src/openvpn/resolve=2Eh
new file mode 100644
index 00000=
00=2E=2E9069af7
--- /dev/null
+++ b/src/openvpn/resolve=2Eh
@@ -0,0 +1,106 =
@@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *   =
          over a single TCP/UDP port, with support for SSL/TLS-based
+ *   =
          session authentication and key exchange,
+ *             packet e=
ncryption, packet authentication, and
+ *             packet compression=2E=

+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *=
  This program is free software; you can redistribute it and/or modify
+ * =
 it under the terms of the GNU General Public License version 2
+ *  as pub=
lished by the Free Software Foundation=2E
+ *
+ *  This program is distribu=
ted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; with=
out even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=
=2E
+ *
+ *  You should have received a copy of the GNU General Public Lice=
nse along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/lice=
nses/>=2E
+ */
+
+/**
+ * @file
+ * DNS resolution
+ */
+#ifndef RESOLVE_H
=
+#define RESOLVE_H
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+=

+#include "syshead=2Eh"
+
+#include "sig=2Eh"
+
+#define GETADDR_RESOLVE  =
               (1u << 0)
+#define GETADDR_FATAL                   (1u << 1)=

+#define GETADDR_HOST_ORDER              (1u << 2)
+#define GETADDR_MENTIO=
N_RESOLVE_RETRY   (1u << 3)
+#define GETADDR_FATAL_ON_SIGNAL         (1u <<=
 4)
+#define GETADDR_WARN_ON_SIGNAL          (1u << 5)
+#define GETADDR_MSG=
_VIRT_OUT            (1u << 6)
+#define GETADDR_TRY_ONCE                (1u=
 << 7)
+#define GETADDR_UPDATE_MANAGEMENT_STATE (1u << 8)
+#define GETADDR_=
RANDOMIZE               (1u << 9)
+#define GETADDR_PASSIVE                 =
(1u << 10)
+#define GETADDR_DATAGRAM                (1u << 11)
+
+#define G=
ETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)
+
+/**
+ * Convert s=
ockflags/getaddr_flags into getaddr_flags
+ */
+unsigned int sf2gaf(const u=
nsigned int getaddr_flags, const unsigned int sockflags);
+
+/**
+ * Transl=
ate an IPv4 addr or hostname from string form to in_addr_t
+ *
+ * In case =
of resolve error, it will try again for
+ * resolve_retry_seconds seconds=
=2E
+ */
+in_addr_t getaddr(unsigned int flags, const char *hostname, int r=
esolve_retry_seconds,
+                  bool *succeeded, struct signal_inf=
o *sig_info);
+
+in_addr_t get_ip_addr(const char *ip_string, msglvl_t msgl=
evel, bool *error);
+
+/**
+ * Translate an IPv6 addr or hostname from stri=
ng form to in6_addr
+ */
+bool get_ipv6_addr(const char *hostname, struct i=
n6_addr *network, unsigned int *netbits,
+                   msglvl_t msgle=
vel);
+
+static inline bool
+ipv6_addr_safe_hexplusbits(const char *ipv6_pr=
efix_spec)
+{
+    return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WAR=
N);
+}
+
+int openvpn_getaddrinfo(unsigned int flags, const char *hostname,=
 const char *servname,
+                        int resolve_retry_seconds, =
struct signal_info *sig_info, int ai_family,
+                        struc=
t addrinfo **res);
+
+void do_preresolve(struct context *c);
+
+/* struct t=
o hold preresolved host names */
+struct cached_dns_entry
+{
+    const cha=
r *hostname;
+    const char *servname;
+    int ai_family;
+    unsigned i=
nt flags;
+    struct addrinfo *ai;
+    struct cached_dns_entry *next;
+};=

+
+/**
+ * get_cached_dns_entry return 0 on success and -1
+ * otherwise=
=2E (like getaddrinfo())
+ */
+int get_cached_dns_entry(struct cached_dns_e=
ntry *dns_cache, const char *hostname,
+                         const char=
 *servname, int ai_family,
+                         unsigned int resolve_f=
lags, struct addrinfo **ai);
+
+#endif /* RESOLVE_H */
diff --git a/src/ope=
nvpn/route=2Ec b/src/openvpn/route=2Ec
index 0b1634c=2E=2E0bce966 100644
--=
- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -42,6 +42,7 @@
 #i=
nclude "options=2Eh"
 #include "networking=2Eh"
 #include "integer=2Eh"
+#i=
nclude "resolve=2Eh"
 
 #include "memdbg=2Eh"
 
diff --git a/src/openvpn/so=
cket=2Ec b/src/openvpn/socket=2Ec
index f516a14=2E=2E307b5c6 100644
--- a/s=
rc/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -38,6 +38,7 @@
 #incl=
ude "manage=2Eh"
 #include "openvpn=2Eh"
 #include "forward=2Eh"
+#include =
"resolve=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -54,366 +55,6 @@
     return fa=
lse;
 }
 
-/*
- * Convert sockflags/getaddr_flags into getaddr_flags
- */
-=
static unsigned int
-sf2gaf(const unsigned int getaddr_flags, const unsigne=
d int sockflags)
-{
-    if (sockflags & SF_HOST_RANDOMIZE)
-    {
-       =
 return getaddr_flags | GETADDR_RANDOMIZE;
-    }
-    else
-    {
-       =
 return getaddr_flags;
-    }
-}
-
-/*
- * Functions related to the transla=
tion of DNS names to IP addresses=2E
- */
-static int
-get_addr_generic(sa_=
family_t af, unsigned int flags, const char *hostname, void *network,
-    =
             unsigned int *netbits, int resolve_retry_seconds, struct signa=
l_info *sig_info,
-                 msglvl_t msglevel)
-{
-    char *endp, =
*sep, *var_host =3D NULL;
-    struct addrinfo *ai =3D NULL;
-    unsigned =
long bits;
-    uint8_t max_bits;
-    int ret =3D -1;
-
-    if (!hostname=
)
-    {
-        msg(M_NONFATAL, "Can't resolve null hostname!");
-       =
 goto out;
-    }
-
-    /* assign family specific default values */
-    s=
witch (af)
-    {
-        case AF_INET:
-            bits =3D 0;
-        =
    max_bits =3D sizeof(in_addr_t) * 8;
-            break;
-
-        case=
 AF_INET6:
-            bits =3D 64;
-            max_bits =3D sizeof(struc=
t in6_addr) * 8;
-            break;
-
-        default:
-            msg(M=
_WARN, "Unsupported AF family passed to getaddrinfo for %s (%d)", hostname,=
 af);
-            goto out;
-    }
-
-    /* we need to modify the hostnam=
e received as input, but we don't want to
-     * touch it directly as it m=
ight be a constant string=2E
-     *
-     * Therefore, we clone the string=
 here and free it at the end of the
-     * function */
-    var_host =3D s=
trdup(hostname);
-    if (!var_host)
-    {
-        msg(M_NONFATAL | M_ERR=
NO, "Can't allocate hostname buffer for getaddrinfo");
-        goto out;
-=
    }
-
-    /* check if this hostname has a /bits suffix */
-    sep =3D s=
trchr(var_host, '/');
-    if (sep)
-    {
-        bits =3D strtoul(sep + =
1, &endp, 10);
-        if ((*endp !=3D '\0') || (bits > max_bits))
-      =
  {
-            msg(msglevel, "IP prefix '%s': invalid '/bits' spec (%s)",=
 hostname, sep + 1);
-            goto out;
-        }
-        *sep =3D '\=
0';
-    }
-
-    ret =3D openvpn_getaddrinfo(flags & ~GETADDR_HOST_ORDER, =
var_host, NULL, resolve_retry_seconds,
-                              sig_i=
nfo, af, &ai);
-    if ((ret =3D=3D 0) && network)
-    {
-        struct i=
n6_addr *ip6;
-        in_addr_t *ip4;
-
-        if (af !=3D ai->ai_family=
)
-        {
-            msg(msglevel, "Can't parse %s as IPv%d address", =
var_host, (af =3D=3D AF_INET) ? 4 : 6);
-            ret =3D -1;
-         =
   goto out;
-        }
-
-        switch (af)
-        {
-            case=
 AF_INET:
-                ip4 =3D network;
-                *ip4 =3D ((str=
uct sockaddr_in *)ai->ai_addr)->sin_addr=2Es_addr;
-
-                if (f=
lags & GETADDR_HOST_ORDER)
-                {
-                    *ip4 =3D=
 ntohl(*ip4);
-                }
-                break;
-
-            cas=
e AF_INET6:
-                ip6 =3D network;
-                *ip6 =3D ((s=
truct sockaddr_in6 *)ai->ai_addr)->sin6_addr;
-                break;
-
-  =
          default:
-                /* can't get here because 'af' was prev=
iously checked */
-                msg(M_WARN, "Unsupported AF family for %=
s (%d)", var_host, af);
-                goto out;
-        }
-    }
-
-   =
 if (netbits)
-    {
-        *netbits =3D (unsigned int)bits;
-    }
-
-  =
  /* restore '/' separator, if any */
-    if (sep)
-    {
-        *sep =
=3D '/';
-    }
-out:
-    if (ai)
-    {
-        freeaddrinfo(ai);
-    }=

-    free(var_host);
-
-    return ret;
-}
-
-in_addr_t
-getaddr(unsigned =
int flags, const char *hostname, int resolve_retry_seconds, bool *succeeded=
,
-        struct signal_info *sig_info)
-{
-    in_addr_t addr =3D { 0 };
=
-    int status;
-
-    status =3D get_addr_generic(AF_INET, flags, hostnam=
e, &addr, NULL, resolve_retry_seconds,
-                              sig_i=
nfo, M_WARN);
-    if (status =3D=3D 0)
-    {
-        if (succeeded)
-   =
     {
-            *succeeded =3D true;
-        }
-        return addr;
-=
    }
-    else
-    {
-        if (succeeded)
-        {
-            *suc=
ceeded =3D false;
-        }
-        return 0;
-    }
-}
-
-bool
-get_ipv6=
_addr(const char *hostname, struct in6_addr *network, unsigned int *netbits=
,
-              msglvl_t msglevel)
-{
-    if (get_addr_generic(AF_INET6, =
GETADDR_RESOLVE, hostname, network, netbits, 0, NULL, msglevel)
-        < =
0)
-    {
-        return false;
-    }
-
-    return true; /* parsing OK, =
values set */
-}
-
-static inline bool
-streqnull(const char *a, const char=
 *b)
-{
-    if (a =3D=3D NULL && b =3D=3D NULL)
-    {
-        return tru=
e;
-    }
-    else if (a =3D=3D NULL || b =3D=3D NULL)
-    {
-        ret=
urn false;
-    }
-    else
-    {
-        return streq(a, b);
-    }
-}
-=

-/*
- * get_cached_dns_entry return 0 on success and -1
- * otherwise=2E (=
like getaddrinfo)
- */
-static int
-get_cached_dns_entry(struct cached_dns_=
entry *dns_cache, const char *hostname, const char *servname,
-            =
         int ai_family, unsigned int resolve_flags, struct addrinfo **ai)
-=
{
-    struct cached_dns_entry *ph;
-    unsigned int flags;
-
-    /* Only=
 use flags that are relevant for the structure */
-    flags =3D resolve_fl=
ags & GETADDR_CACHE_MASK;
-
-    for (ph =3D dns_cache; ph; ph =3D ph->next=
)
-    {
-        if (streqnull(ph->hostname, hostname) && streqnull(ph->se=
rvname, servname)
-            && ph->ai_family =3D=3D ai_family && ph->fla=
gs =3D=3D flags)
-        {
-            *ai =3D ph->ai;
-            retur=
n 0;
-        }
-    }
-    return -1;
-}
-
-
-static int
-do_preresolve_ho=
st(struct context *c, const char *hostname, const char *servname, const int=
 af,
-                   const unsigned int flags)
-{
-    struct addrinfo =
*ai;
-    int status;
-
-    if (get_cached_dns_entry(c->c1=2Edns_cache, ho=
stname, servname, af, flags, &ai) =3D=3D 0)
-    {
-        /* entry alread=
y cached, return success */
-        return 0;
-    }
-
-    status =3D ope=
nvpn_getaddrinfo(flags, hostname, servname, c->options=2Eresolve_retry_seco=
nds, NULL,
-                                 af, &ai);
-    if (status =3D=
=3D 0)
-    {
-        struct cached_dns_entry *ph;
-
-        ALLOC_OBJ_CL=
EAR_GC(ph, struct cached_dns_entry, &c->gc);
-        ph->ai =3D ai;
-     =
   ph->hostname =3D hostname;
-        ph->servname =3D servname;
-        =
ph->flags =3D flags & GETADDR_CACHE_MASK;
-
-        if (!c->c1=2Edns_cache=
)
-        {
-            c->c1=2Edns_cache =3D ph;
-        }
-        els=
e
-        {
-            struct cached_dns_entry *prev =3D c->c1=2Edns_cac=
he;
-            while (prev->next)
-            {
-                prev =
=3D prev->next;
-            }
-            prev->next =3D ph;
-        }
-=

-        gc_addspecial(ai, &gc_freeaddrinfo_callback, &c->gc);
-    }
-   =
 return status;
-}
-
-void
-do_preresolve(struct context *c)
-{
-    struct=
 connection_list *l =3D c->options=2Econnection_list;
-    const unsigned i=
nt preresolve_flags =3D GETADDR_RESOLVE | GETADDR_UPDATE_MANAGEMENT_STATE
-=
                                          | GETADDR_MENTION_RESOLVE_RETRY |=
 GETADDR_FATAL;
-
-
-    for (int i =3D 0; i < l->len; ++i)
-    {
-       =
 int status;
-        const char *remote;
-        unsigned int flags =3D p=
reresolve_flags;
-
-        struct connection_entry *ce =3D l->array[i];
-
=
-        if (proto_is_dgram(ce->proto))
-        {
-            flags |=3D =
GETADDR_DATAGRAM;
-        }
-
-        if (c->options=2Esockflags & SF_HOS=
T_RANDOMIZE)
-        {
-            flags |=3D GETADDR_RANDOMIZE;
-       =
 }
-
-        if (c->options=2Eip_remote_hint)
-        {
-            remo=
te =3D c->options=2Eip_remote_hint;
-        }
-        else
-        {
-  =
          remote =3D ce->remote;
-        }
-
-        /* HTTP remote hostn=
ame does not need to be resolved */
-        if (!ce->http_proxy_options)
-=
        {
-            status =3D do_preresolve_host(c, remote, ce->remote_=
port, ce->af, flags);
-            if (status !=3D 0)
-            {
-     =
           goto err;
-            }
-        }
-
-        /* Preresolve pro=
xy */
-        if (ce->http_proxy_options)
-        {
-            status =
=3D do_preresolve_host(c, ce->http_proxy_options->server,
-                =
                        ce->http_proxy_options->port, ce->af, preresolve_fl=
ags);
-
-            if (status !=3D 0)
-            {
-                got=
o err;
-            }
-        }
-
-        if (ce->socks_proxy_server)
-  =
      {
-            status =3D
-                do_preresolve_host(c, ce->=
socks_proxy_server, ce->socks_proxy_port, ce->af, flags);
-            if (=
status !=3D 0)
-            {
-                goto err;
-            }
-  =
      }
-
-        if (ce->bind_local)
-        {
-            flags |=3D G=
ETADDR_PASSIVE;
-            flags &=3D ~GETADDR_RANDOMIZE;
-
-            =
for (int j =3D 0; j < ce->local_list->len; j++)
-            {
-           =
     const struct local_entry *le =3D ce->local_list->array[j];
-
-        =
        if (!le->local)
-                {
-                    continue;
-=
                }
-
-                status =3D do_preresolve_host(c, le->l=
ocal, le->port, ce->af, flags);
-                if (status !=3D 0)
-      =
          {
-                    goto err;
-                }
-            =
}
-        }
-    }
-    return;
-
-err:
-    throw_signal_soft(SIGHUP, "Pr=
eresolving failed");
-}
-
 static int
 socket_get_sndbuf(socket_descriptor_=
t sd)
 {
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index=
 cbcdeef=2E=2E52e09c9 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn=
/socket=2Eh
@@ -62,17 +62,6 @@
 /* convert a packet_size_type from network =
to host order */
 #define ntohps(x) ntohs(x)
 
-/* struct to hold preresolv=
ed host names */
-struct cached_dns_entry
-{
-    const char *hostname;
-  =
  const char *servname;
-    int ai_family;
-    unsigned int flags;
-    s=
truct addrinfo *ai;
-    struct cached_dns_entry *next;
-};
-
 /* IP addres=
ses which are persistent across SIGUSR1s */
 struct link_socket_addr
 {
@@ =
-362,8 +351,6 @@
 
 void link_socket_init_phase2(struct context *c, struct =
link_socket *sock);
 
-void do_preresolve(struct context *c);
-
 void link_=
socket_close(struct link_socket *sock);
 
 #ifdef ENABLE_MANAGEMENT
diff --=
git a/src/openvpn/socket_util=2Ec b/src/openvpn/socket_util=2Ec
index 913ac=
69=2E=2E879be73 100644
--- a/src/openvpn/socket_util=2Ec
+++ b/src/openvpn/=
socket_util=2Ec
@@ -490,271 +490,6 @@
     return ""; /* Make the compiler =
happy */
 }
 
-/**
- * Small helper function for openvpn_getaddrinfo to pri=
nt the address
- * family when resolving fails
- */
-static const char *
-g=
etaddrinfo_addr_family_name(int af)
-{
-    switch (af)
-    {
-        cas=
e AF_INET:
-            return "[AF_INET]";
-
-        case AF_INET6:
-    =
        return "[AF_INET6]";
-    }
-    return "";
-}
-
-/*
- * Prepend a =
random string to hostname to prevent DNS caching=2E
- * For example, foo=2E=
bar=2Egov would be modified to <random-chars>=2Efoo=2Ebar=2Egov=2E
- * Of c=
ourse, this requires explicit support in the DNS server (wildcard)=2E
- */
=
-static const char *
-hostname_randomize(const char *hostname, struct gc_ar=
ena *gc)
-{
-#define n_rnd_bytes 6
-
-    uint8_t rnd_bytes[n_rnd_bytes];
-=
    const char *rnd_str;
-    struct buffer hname =3D alloc_buf_gc(strlen(h=
ostname) + sizeof(rnd_bytes) * 2 + 4, gc);
-
-    prng_bytes(rnd_bytes, siz=
eof(rnd_bytes));
-    rnd_str =3D format_hex_ex(rnd_bytes, sizeof(rnd_bytes=
), 40, 0, NULL, gc);
-    buf_printf(&hname, "%s=2E%s", rnd_str, hostname);=

-    return BSTR(&hname);
-#undef n_rnd_bytes
-}
-
-/*
- * Translate IPv4/=
IPv6 addr or hostname into struct addrinfo
- * If resolve error, try again =
for resolve_retry_seconds seconds=2E
- */
-int
-openvpn_getaddrinfo(unsigne=
d int flags, const char *hostname, const char *servname,
-                 =
   int resolve_retry_seconds, struct signal_info *sig_info, int ai_family,
=
-                    struct addrinfo **res)
-{
-    struct addrinfo hints;
=
-    int status;
-    struct signal_info sigrec =3D { 0 };
-    msglvl_t ms=
glevel =3D (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
-    struc=
t gc_arena gc =3D gc_new();
-    const char *print_hostname;
-    const cha=
r *print_servname;
-
-    ASSERT(res);
-
-    ASSERT(hostname || servname);=

-    ASSERT(!(flags & GETADDR_HOST_ORDER));
-
-    if (servname)
-    {
- =
       print_servname =3D servname;
-    }
-    else
-    {
-        print_=
servname =3D "";
-    }
-
-    if (flags & GETADDR_MSG_VIRT_OUT)
-    {
-  =
      msglevel |=3D M_MSG_VIRT_OUT;
-    }
-
-    if ((flags & (GETADDR_FAT=
AL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) && !sig_info)
-    {
-        sig_i=
nfo =3D &sigrec;
-    }
-
-    /* try numeric ip addr first */
-    CLEAR(h=
ints);
-    hints=2Eai_flags =3D AI_NUMERICHOST;
-
-    if (flags & GETADDR=
_PASSIVE)
-    {
-        hints=2Eai_flags |=3D AI_PASSIVE;
-    }
-
-    i=
f (flags & GETADDR_DATAGRAM)
-    {
-        hints=2Eai_socktype =3D SOCK_D=
GRAM;
-    }
-    else
-    {
-        hints=2Eai_socktype =3D SOCK_STREAM;=

-    }
-
-    /* if hostname is not set, we want to bind to 'ANY', with
- =
    * the correct address family - v4-only or v6/v6-dual-stack */
-    if (=
!hostname)
-    {
-        hints=2Eai_family =3D ai_family;
-    }
-
-    s=
tatus =3D getaddrinfo(hostname, servname, &hints, res);
-
-    if (status !=
=3D 0)                      /* parse as numeric address failed? */
-    {
-=
        const int fail_wait_interval =3D 5; /* seconds */
-        /* Add +=
4 to cause integer division rounding up (1 + 4) =3D 5, (0+4)/5=3D0 */
-    =
    int resolve_retries =3D
-            (flags & GETADDR_TRY_ONCE) ? 1 : (=
(resolve_retry_seconds + 4) / fail_wait_interval);
-        const char *fmt=
;
-        msglvl_t level =3D 0;
-
-        /* this is not a numeric IP, th=
erefore force resolution using the
-         * provided ai_family */
-     =
   hints=2Eai_family =3D ai_family;
-
-        if (hostname && (flags & GET=
ADDR_RANDOMIZE))
-        {
-            hostname =3D hostname_randomize(ho=
stname, &gc);
-        }
-
-        if (hostname)
-        {
-            p=
rint_hostname =3D hostname;
-        }
-        else
-        {
-          =
  print_hostname =3D "undefined";
-        }
-
-        fmt =3D "RESOLVE: C=
annot resolve host address: %s:%s%s (%s)";
-        if ((flags & GETADDR_ME=
NTION_RESOLVE_RETRY) && !resolve_retry_seconds)
-        {
-            fmt=
 =3D "RESOLVE: Cannot resolve host address: %s:%s%s (%s)"
-                =
  "(I would have retried this name query if you had "
-                  "s=
pecified the --resolv-retry option=2E)";
-        }
-
-        if (!(flags =
& GETADDR_RESOLVE) || status =3D=3D EAI_FAIL)
-        {
-            msg(m=
sglevel, "RESOLVE: Cannot parse IP address: %s:%s (%s)", print_hostname,
- =
               print_servname, gai_strerror(status));
-            goto don=
e;
-        }
-
-#ifdef ENABLE_MANAGEMENT
-        if (flags & GETADDR_UPDA=
TE_MANAGEMENT_STATE)
-        {
-            if (management)
-            {=

-                management_set_state(management, OPENVPN_STATE_RESOLVE, N=
ULL, NULL, NULL, NULL,
-                                     NULL);
-      =
      }
-        }
-#endif
-
-        /*
-         * Resolve hostname
-    =
     */
-        while (true)
-        {
-#ifndef _WIN32
-            /* fo=
rce resolv=2Econf reload */
-            res_init();
-#endif
-            /=
* try hostname lookup */
-            hints=2Eai_flags &=3D ~AI_NUMERICHOST=
;
-            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=3D0x%04x ai_family=
=3D%d ai_socktype=3D%d", flags,
-                 hints=2Eai_family, hints=
=2Eai_socktype);
-            status =3D getaddrinfo(hostname, servname, &h=
ints, res);
-
-            if (sig_info)
-            {
-                ge=
t_signal(&sig_info->signal_received);
-                if (sig_info->signal=
_received) /* were we interrupted by a signal? */
-                {
-     =
               /* why are we overwriting SIGUSR1 ? */
-                    =
if (signal_reset(sig_info, SIGUSR1) =3D=3D SIGUSR1) /* ignore SIGUSR1 */
- =
                   {
-                        msg(level, "RESOLVE: Ignored =
SIGUSR1 signal received during "
-                                   "DNS r=
esolution attempt");
-                    }
-                    else
-    =
                {
-                        /* turn success into failure (in=
terrupted syscall) */
-                        if (0 =3D=3D status)
-      =
                  {
-                            ASSERT(res);
-            =
                freeaddrinfo(*res);
-                            *res =3D N=
ULL;
-                            status =3D EAI_AGAIN; /* =3D temporary fa=
ilure */
-                            errno =3D EINTR;
-                   =
     }
-                        goto done;
-                    }
-        =
        }
-            }
-
-            /* success? */
-            if (0 =
=3D=3D status)
-            {
-                break;
-            }
-
-   =
         /* resolve lookup failed, should we
-             * continue or fa=
il? */
-            level =3D msglevel;
-            if (resolve_retries > =
0)
-            {
-                level =3D D_RESOLVE_ERRORS;
-           =
 }
-
-            msg(level, fmt, print_hostname, print_servname, getaddrin=
fo_addr_family_name(ai_family),
-                gai_strerror(status));
-
-=
            if (--resolve_retries <=3D 0)
-            {
-                g=
oto done;
-            }
-
-            management_sleep(fail_wait_interval=
);
-        }
-
-        ASSERT(res);
-
-        /* hostname resolve succee=
ded */
-
-        /*
-         * Do not choose an IP Addresse by random or =
change the order *
-         * of IP addresses, doing so will break RFC 348=
4 address selection *
-         */
-    }
-    else
-    {
-        /* IP a=
ddress parse succeeded */
-        if (flags & GETADDR_RANDOMIZE)
-        =
{
-            msg(M_WARN, "WARNING: ignoring --remote-random-hostname beca=
use the "
-                        "hostname is an IP address");
-        }=

-    }
-
-done:
-    if (sig_info && sig_info->signal_received)
-    {
-  =
      msglvl_t level =3D 0;
-        if (flags & GETADDR_FATAL_ON_SIGNAL)
-=
        {
-            level =3D M_FATAL;
-        }
-        else if (flag=
s & GETADDR_WARN_ON_SIGNAL)
-        {
-            level =3D M_WARN;
-    =
    }
-        msg(level, "RESOLVE: signal received during DNS resolution a=
ttempt");
-    }
-
-    gc_free(&gc);
-    return status;
-}
-
 /*
  * We d=
o our own inet_aton because the glibc function
  * isn't very good about er=
ror checking=2E
diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/sock=
et_util=2Eh
index add08ba=2E=2Ea1a61af 100644
--- a/src/openvpn/socket_util=
=2Eh
+++ b/src/openvpn/socket_util=2Eh
@@ -110,44 +110,6 @@
 void setenv_li=
nk_socket_actual(struct env_set *es, const char *name_prefix,
             =
                   const struct link_socket_actual *act, const unsigned int=
 flags);
 
-/*
- * DNS resolution
- */
-
-#define GETADDR_RESOLVE          =
       (1u << 0)
-#define GETADDR_FATAL                   (1u << 1)
-#defin=
e GETADDR_HOST_ORDER              (1u << 2)
-#define GETADDR_MENTION_RESOLV=
E_RETRY   (1u << 3)
-#define GETADDR_FATAL_ON_SIGNAL         (1u << 4)
-#de=
fine GETADDR_WARN_ON_SIGNAL          (1u << 5)
-#define GETADDR_MSG_VIRT_OU=
T            (1u << 6)
-#define GETADDR_TRY_ONCE                (1u << 7)
-=
#define GETADDR_UPDATE_MANAGEMENT_STATE (1u << 8)
-#define GETADDR_RANDOMIZ=
E               (1u << 9)
-#define GETADDR_PASSIVE                 (1u << 1=
0)
-#define GETADDR_DATAGRAM                (1u << 11)
-
-#define GETADDR_C=
ACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)
-
-/**
- * Translate an IPv4=
 addr or hostname from string form to in_addr_t
- *
- * In case of resolve =
error, it will try again for
- * resolve_retry_seconds seconds=2E
- */
-in_=
addr_t getaddr(unsigned int flags, const char *hostname, int resolve_retry_=
seconds,
-                  bool *succeeded, struct signal_info *sig_info);=

-
-/**
- * Translate an IPv6 addr or hostname from string form to in6_addr=

- */
-bool get_ipv6_addr(const char *hostname, struct in6_addr *network, u=
nsigned int *netbits,
-                   msglvl_t msglevel);
-
-int openvp=
n_getaddrinfo(unsigned int flags, const char *hostname, const char *servnam=
e,
-                        int resolve_retry_seconds, struct signal_info *=
sig_info, int ai_family,
-                        struct addrinfo **res);
-=

 /* return values of openvpn_inet_aton */
 #define OIA_HOSTNAME 0
 #define=
 OIA_IP       1
@@ -301,7 +263,7 @@
 }
 #endif
 
-/*
+/**
  * Overhead adde=
d to packets by various protocols=2E
  */
 static inline int
diff --git a/s=
rc/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 18c1cff=2E=2Efdd13ae 100644
=
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -39,7 +39,7 @@
 #inc=
lude "fdmisc=2Eh"
 #include "common=2Eh"
 #include "run_command=2Eh"
-#incl=
ude "socket_util=2Eh"
+#include "resolve=2Eh"
 #include "manage=2Eh"
 #incl=
ude "route=2Eh"
 #include "win32=2Eh"

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1846?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f
Gerrit-Change-N=
umber: 1846
Gerrit-PatchSet: 5
Gerrit-Owner: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--PYWDBaQj0z4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1846?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Factor out address resolve code to=
 a new file resolve=2Ec<br><br>The code was weirdly split between socket=2E=
c, socket_util=2Ec,<br>and options=2Ec=2E The new structure makes more sens=
e=2E<br><br>While here move some related string helper code to buffer=2Eh=
=2E<br><br>Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1846<br>Message-Id: &lt;20261018152900=2E22589-1-ge=
rt@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg40027=2Ehtml<br>Signed-off-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/o=
penvpn/Makefile=2Eam<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2E=
h<br>M src/openvpn/clinat=2Ec<br>M src/openvpn/dns=2Ec<br>M src/openvpn/ini=
t=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/options=2Ec<br>M src/ope=
nvpn/options=2Eh<br>M src/openvpn/pool=2Ec<br>M src/openvpn/ps=2Ec<br>M src=
/openvpn/push=2Ec<br>A src/openvpn/resolve=2Ec<br>A src/openvpn/resolve=2Eh=
<br>M src/openvpn/route=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/so=
cket=2Eh<br>M src/openvpn/socket_util=2Ec<br>M src/openvpn/socket_util=2Eh<=
br>M src/openvpn/tun=2Ec<br>21 files changed, 816 insertions(+), 709 deleti=
ons(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</s=
pan><br><span>index b85e461=2E=2E184a95a 100644</span><br><span>--- a/CMake=
Lists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -578,=
6 +578,8 @@</span><br><span>     src/openvpn/reflect_filter=2Eh</span><br><=
span>     src/openvpn/reliable=2Ec</span><br><span>     src/openvpn/reliabl=
e=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvp=
n/resolve=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sr=
c/openvpn/resolve=2Eh</span><br><span>     src/openvpn/route=2Ec</span><br>=
<span>     src/openvpn/route=2Eh</span><br><span>     src/openvpn/run_comma=
nd=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn=
/Makefile=2Eam</span><br><span>index 9424801=2E=2E8a60a94 100644</span><br>=
<span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Mak=
efile=2Eam</span><br><span>@@ -128,6 +128,7 @@</span><br><span> 	pushlist=
=2Eh \</span><br><span> 	reflect_filter=2Ec reflect_filter=2Eh \</span><br>=
<span> 	reliable=2Ec reliable=2Eh \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	resolve=2Ec resolve=2Eh \</span><br><span> 	route=2Ec rout=
e=2Eh \</span><br><span> 	run_command=2Ec run_command=2Eh \</span><br><span=
> 	schedule=2Ec schedule=2Eh \</span><br><span>diff --git a/src/openvpn/buf=
fer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 3599cc9=2E=2Ec683f8e=
 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/=
src/openvpn/buffer=2Ec</span><br><span>@@ -1083,6 +1083,23 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+streqnull(const char *a, const char *b)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (a =3D=3D NULL &amp;&amp; b =3D=3D NULL)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else if (a =3D=3D NULL || b =3D=3D NULL)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn streq(a, b);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> char *</span><b=
r><span> string_substitute(const char *src, char from, char to, struct gc_a=
rena *gc)</span><br><span> {</span><br><span>diff --git a/src/openvpn/buffe=
r=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index 74233c57=2E=2E7af4444 =
100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/s=
rc/openvpn/buffer=2Eh</span><br><span>@@ -1807,6 +1807,18 @@</span><br><spa=
n>     return 0 =3D=3D strncmp(str, prefix, strlen(prefix));</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/** helper to work around the semantics of the strcmp() return value</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the =
strings are equal according to strcmp()</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define streq(x, y) (!strcmp((x), (y)))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/** compare two strings which might be NULL</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @return true if both strings are NULL, or i=
f they are equal according to strcmp()</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool streqnull(const char *a, const char *b);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/** compare two strings which might be NULL, b=
ut NULL is never equal</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @return true if neither string is NULL and they are equal according t=
o strcmp()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span> bool string_defined_equal(const char *s1, const char *s2);</spa=
n><br><span> char *string_substitute(const char *src, char from, char to, s=
truct gc_arena *gc);</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/clinat=2Ec b/src/openvpn/clinat=2Ec</span><br><span>index d72d42a=2E=
=2Efc4acef 100644</span><br><span>--- a/src/openvpn/clinat=2Ec</span><br><s=
pan>+++ b/src/openvpn/clinat=2Ec</span><br><span>@@ -30,6 +30,7 @@</span><b=
r><span> #include &quot;proto=2Eh&quot;</span><br><span> #include &quot;soc=
ket_util=2Eh&quot;</span><br><span> #include &quot;memdbg=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh&=
quot;</span><br><span> </span><br><span> static bool</span><br><span> add_e=
ntry(struct client_nat_option_list *dest, const struct client_nat_entry *e)=
</span><br><span>diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec</sp=
an><br><span>index 87c9c5f=2E=2Ee5ed1bc 100644</span><br><span>--- a/src/op=
envpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</span><br><span>@@ =
-27,7 +27,7 @@</span><br><span> #include &quot;syshead=2Eh&quot;</span><br>=
<span> </span><br><span> #include &quot;dns=2Eh&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &quot;socket_util=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh=
&quot;</span><br><span> #include &quot;options=2Eh&quot;</span><br><span> #=
include &quot;run_command=2Eh&quot;</span><br><span> #include &quot;domain_=
helper=2Eh&quot;</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/op=
envpn/init=2Ec</span><br><span>index ddcfaf4=2E=2E24cf532 100644</span><br>=
<span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec=
</span><br><span>@@ -55,6 +55,7 @@</span><br><span> #include &quot;tun_afun=
ix=2Eh&quot;</span><br><span> #include &quot;schedule=2Eh&quot;</span><br><=
span> #include &quot;options_string=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><br><span>=
 </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span>=
<br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</spa=
n><br><span>index 007dd2a=2E=2E0fc9ee2 100644</span><br><span>--- a/src/ope=
nvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><spa=
n>@@ -44,6 +44,7 @@</span><br><span> #include &quot;dco=2Eh&quot;</span><br=
><span> #include &quot;push=2Eh&quot;</span><br><span> #include &quot;multi=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;resolve=2Eh&quot;</span><br><span> </span><br><span> #include &quot;m=
emdbg=2Eh&quot;</span><br><span> </span><br><span>diff --git a/src/openvpn/=
options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 1630731=2E=2E8e=
0c602 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>=
+++ b/src/openvpn/options=2Ec</span><br><span>@@ -64,6 +64,7 @@</span><br><=
span> #include &quot;domain_helper=2Eh&quot;</span><br><span> #include &quo=
t;mbuf=2Eh&quot;</span><br><span> #include &quot;check_file_access=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;res=
olve=2Eh&quot;</span><br><span> </span><br><span> #include &lt;ctype=2Eh&gt=
;</span><br><span> </span><br><span>@@ -1044,26 +1045,6 @@</span><br><span>=
 </span><br><span> #endif /* ifndef _WIN32 */</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static in_addr_t</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-get_ip_addr(const char *ip_string, msg=
lvl_t msglevel, bool *error)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned =
int flags =3D GETADDR_HOST_ORDER;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    bool succeeded =3D false;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    in_addr_t ret;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (msglevel &amp; M_FATAL)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fl=
ags |=3D GETADDR_FATAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ret =3D getaddr(flags, ip_strin=
g, 0, &amp;succeeded, NULL);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (!succeeded &amp;&amp; error)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        *error =3D true;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><=
span>  * Returns newly allocated string containing address part without &qu=
ot;/nn&quot;=2E</span><br><span>  *</span><br><span>@@ -1086,13 +1067,6 @@<=
/span><br><span>     }</span><br><span>     return ret;</span><br><span> }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-ipv6_addr_safe_hexplusbits(const char *ipv6_prefix_sp=
ec)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return get_ipv6_addr(ipv6_prefix_s=
pec, NULL, NULL, M_WARN);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> /**</span><br><span>  * Parses a hexstring and checks if the string has t=
he correct length=2E Return</span><br><span>  * a verify_hash_list containi=
ng the parsed hash string=2E</span><br><span>@@ -3330,7 +3304,7 @@</span><b=
r><span>     options_postprocess_verify(options);</span><br><span> #ifndef =
ENABLE_SMALL</span><br><span>     options_postprocess_filechecks(options);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* !ENABLE_SMAL=
L */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span> }</span><br><span> </span><br><span> /*</span><br><span>diff --git=
 a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index =
693d9cf=2E=2Ec58530a 100644</span><br><span>--- a/src/openvpn/options=2Eh</=
span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -727,8 +727=
,6 @@</span><br><span>     unsigned int imported_protocol_flags;</span><br>=
<span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define streq(x, y) (!strcmp((x), (y)))</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Option cla=
sses=2E</span><br><span>  */</span><br><span>diff --git a/src/openvpn/pool=
=2Ec b/src/openvpn/pool=2Ec</span><br><span>index 63fc930=2E=2Efff0e3f 1006=
44</span><br><span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b/src/ope=
nvpn/pool=2Ec</span><br><span>@@ -31,6 +31,7 @@</span><br><span> #include &=
quot;error=2Eh&quot;</span><br><span> #include &quot;socket_util=2Eh&quot;<=
/span><br><span> #include &quot;otime=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><br><spa=
n> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br>=
<span>index 3ba983f=2E=2E03c6f48 100644</span><br><span>--- a/src/openvpn/p=
s=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -32,6 +32=
,7 @@</span><br><span> #include &quot;socket=2Eh&quot;</span><br><span> #in=
clude &quot;fdmisc=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;re=
solve=2Eh&quot;</span><br><span> #include &quot;ps=2Eh&quot;</span><br><spa=
n> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span>diff -=
-git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index ad=
95a0f=2E=2E42259c3 100644</span><br><span>--- a/src/openvpn/push=2Ec</span>=
<br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -37,6 +37,7 @@</spa=
n><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quo=
t;ssl_util=2Eh&quot;</span><br><span> #include &quot;options_util=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;reso=
lve=2Eh&quot;</span><br><span> </span><br><span> /*</span><br><span>  * Aut=
h username/password</span><br><span>diff --git a/src/openvpn/resolve=2Ec b/=
src/openvpn/resolve=2Ec</span><br><span>new file mode 100644</span><br><spa=
n>index 0000000=2E=2Eb8d9899</span><br><span>--- /dev/null</span><br><span>=
+++ b/src/openvpn/resolve=2Ec</span><br><span>@@ -0,0 +1,665 @@</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel=
 IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
        over a single TCP/UDP port, with support for SSL/TLS-based</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             session authe=
ntication and key exchange,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             packet encryption, packet authentication, and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet comp=
ression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-202=
6 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  This program is free software; you can redistribute it and/or modi=
fy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the =
terms of the GNU General Public License version 2</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundat=
ion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distribute=
d in the hope that it will be useful,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied wa=
rranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHA=
NTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for mo=
re details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have rec=
eived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONF=
IG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ma=
nage=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;socket=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;socket_util=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Co=
nvert sockflags/getaddr_flags into getaddr_flags</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+sf2gaf(const unsigned int getaddr_flags, const unsigned int sockflags=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (sockflags &amp; SF_HOST_RAND=
OMIZE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return getaddr_flag=
s | GETADDR_RANDOMIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return getaddr_flags;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Functions relate=
d to the translation of DNS names to IP addresses=2E</span><br><span style=
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
t a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 0b1=
634c=2E=2E0bce966 100644</span><br><span>--- a/src/openvpn/route=2Ec</span>=
<br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -42,6 +42,7 @@</sp=
an><br><span> #include &quot;options=2Eh&quot;</span><br><span> #include &q=
uot;networking=2Eh&quot;</span><br><span> #include &quot;integer=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;resol=
ve=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&q=
uot;</span><br><span> </span><br><span>diff --git a/src/openvpn/socket=2Ec =
b/src/openvpn/socket=2Ec</span><br><span>index f516a14=2E=2E307b5c6 100644<=
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
vpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index cbcdeef=2E=2E=
52e09c9 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span=
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
envpn/socket_util=2Eh</span><br><span>index add08ba=2E=2Ea1a61af 100644</sp=
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
src/openvpn/tun=2Ec</span><br><span>index 18c1cff=2E=2Efdd13ae 100644</span=
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
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1846 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> =
Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--PYWDBaQj0z4=--


--===============2425705003864944910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2425705003864944910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2425705003864944910==--

