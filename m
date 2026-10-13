Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E81CC6B08
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=4aGMReJmOanw6W/3rS1PLdpYO9lUEQrNKWiSYcYtA3E=; b=DUMUUH/WhibpcV
	Ie746e0i20p2hnpe20RjqrjAtWI+BApQJhkKph5dtNFMS2TB6NFQAMy28d015CTqwLEnyfz+XHWoF
	GMpGNuDtIia3aXtStAJ/aOVdPaWj01MgzIyOdBT55pkSWcqatNC/JiEzogd2Y1xehaGc7TntHf9iq
	qso=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGdPr-0005i0-2T;
	Tue, 13 Oct 2026 14:23:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGdPp-0005hQ-9q
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 14:23:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=glRJ/SoyYhu0Egg9OIQDD6u8vU1ZZm6m9TA7QRzKFko=; b=RUHOEmPmRm9kGEQP8StqqKeR/q
 6JdLfwnNeAY6RBbwDwqLnuyUtp22uwYbpwbf32tHjrNnXaCiYUhhpnXlbPkiBxLrbrwU4kme3Xus4
 xOqhnUySEViOUSgVUpS5UbzNgIvy0FXGAQqqpSB1WzacEoVp1QI9DH6CdokdGahFlxbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=glRJ/SoyYhu0Egg9OIQDD6u8vU1ZZm6m9TA7QRzKFko=; b=X
 ypd3OFzDWuN+9ULRdXzybivPB+MlxF3r9t3SLwiOwKZtngSJ1iZazdk6S/aDGBI6P20UDfMNjtRj+
 3wUJq3ZujP4cQHDXUsz4oXw6e+4h36CRLA4M6nh/6lDZ8U0u/gXPA7NDQS3fhJ6A9ku1p2e6qmWs7
 GaQ9JpbUWpUFO8VE=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGdPj-0005kd-N1 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 14:23:41 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so2982040f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791901409; x=1792506209; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=glRJ/SoyYhu0Egg9OIQDD6u8vU1ZZm6m9TA7QRzKFko=;
 b=HS8Fa17oY3xmjq511N7Ew9ILxG64wv0vXPolDTIQr1MefXtxtYxEpwbktnJorTvmRa
 bQBmUSMuT/PJiGiHoNUEPQL71Tr1AGRWNWu9yXarFd1GvSZ/ffpQwkskAAi45XLKICRR
 4B7N8YkMXvzx6dNNqbv0CCGJfUPcxMwaRnPeT6wGND6q3sYnoMAIL+6TFMnqWQChLHxC
 lTkjwsCxKR4337Jc2O+PMhzn9K+nnc2/HMOtxLqQuo9b2bgGoC3U12n9jeAOO+Nvl1vs
 EbNHMm7j0WJMajXWBk3S4ezjsk6CoTh0JwcCEzRTOwTFP5YXiMvZexkKaWhOUqLg9hZu
 4T4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791901409; x=1792506209;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=glRJ/SoyYhu0Egg9OIQDD6u8vU1ZZm6m9TA7QRzKFko=;
 b=mxFlb2KwukV82qjXZXw5eyx8/N5Fhd6ZUBOFGMeZx9zSOtDKx+ozHfLfTXoNlDUdvs
 aueCkCU7DKSTiHSORxTlKNz4oaLi1E76tRgoRtv3fU7TceZm35m+VOm5HCRveCkFHQy+
 7KNEL3V2gx5mHBKr045eH0UoncPatlddMJVBZCNL5dM52fUJyYg+qF+NGU4u0ia//RqJ
 w+P/ZV1Lcn0CvmX7N9GCX4nns6K3b88Xzga7swvXsQDsH1NDP4GfSZK9CUdVXVojRGDu
 ZwDhnITjPXvaierSi0QyN76gM5eexRWUIf/61mjlVejEfabUbStwn6QilC2dkR49Fjdy
 vfPQ==
X-Gm-Message-State: AFq9FYJ0k2NvAJZKMIF+2/HH/7GUjxGubz+wW0w4iHEwx1wUhyTFMHx1
 Wd5fR6atXouF5Elj5qhdzKX3s79z7iJMzakAVkdz2Fx+9VJwtOXYN18PiaQ4Y231mfnaznkqK4E
 NlnlMKhJWCDrFH3IrAGv8yLB4m0WJM2ZM1hc4J3fILrjdXXxaijz4vX1TOjLHxTgG8uryUkwZmH
 m+2mka2Q==
X-Gm-Gg: AYBFou2WV/oRyn79oewAQnjtYRQbTopsCZ54fdnQz30fZsDnGtCDEm7Xx1YV2R/FmBT
 qqbOzzelONcWU6Sgfy4q9VkHLTeYkYTVavNNYVuMdOSwsQlRymIkKNLWDOW9JtYHjitVv9E+wnO
 IyL0pyMlTH5dxyw3kSoC/Su+In36dNYm6rjtktumFH+B/QajRnI9BBede/V5gl+SNeR3rRPSvKB
 yhxzC/v10R+RptG7qRNH1LurXh1jvFTDhYAodcNT/aFdaJbcbxXDj2gTlaf413onl4EYB0psHf7
 T7+wUiKhgUL4dtXAgtKheQW9WfkFvPY4wKrz5Z+q8DUBIilOn+wGmSiXO41aOU2tIDgkXw3zwT2
 B3703p0jArRPXDSsza3n+oj44fJOF6s5dUIBa9kH29CzcbtIMzVp+a82tH92Xqb1uoTMRq8nqhw
 nfkobRJObOg22Abij3nbXNjOuqylL5iEIHIoV47meNw/giJWwvD5kyNFopDT9YDjoZVGUrH7/wv
 aPv0Wa7TaZ4mpjDfeMWWg0G0+CHyCKS33XNBusC17A6TjSXukFZOJjLsLVu/Ylt3kk88Ey/FkPK
 4kcFvFaVO67dcm4TxRHOyVHu56CesZOD7yfwtjO/U2+wmWK3ZTMgMJkCSvTM+rRN+yFJB0k=
X-Received: by 2002:a05:6000:2906:b0:487:27f9:834 with SMTP id
 ffacd0b85a97d-48dbaaed8cbmr22779274f8f.41.1791901408287; 
 Tue, 13 Oct 2026 07:23:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc6ddcsm5423606f8f.52.2026.10.13.07.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:23:27 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 13 Oct 2026 14:23:27 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib1b4a9544e09506e95001609262269ab8154241e
X-Gerrit-Change-Number: 1995
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1995?usp=email>
X-Gerrit-Commit: 1c948a7523747c440884442f55f223b7f8c6ae06
References: <gerrit.1791901394000.Ib1b4a9544e09506e95001609262269ab8154241e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkliMWI0YTk1NDRlMDk1MDZlOTUwMDE2MDkyNjIyNjlhYjgxNTQyNDFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8deff533ffbe6b18f27a3af55cd07eaaf5ae0ca7-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGdPj-0005kd-N1
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace strncpynt
 with strlcpy
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4928830719371018653=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4928830719371018653==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D11OG24K0Vw="; charset=UTF-8

--D11OG24K0Vw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1995?usp=3Demail

to review the following change=2E
=


Change subject: Replace strncpynt with strlcpy
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace strncpynt with strlcpy

Mostl=
y a straight-forward replacement=2E But in a few
places I used the addition=
al return code from strlcpy
instead of duplicating the strlen call=2E

Chan=
ge-Id: Ib1b4a9544e09506e95001609262269ab8154241e
Signed-off-by: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/auth_token=2Ec
M src/ope=
nvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/dns=2Ec
M src/openvp=
n/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/mu=
lti=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/openvpn/openssl_compat=2Eh=

M src/openvpn/options_string=2Ec
M src/openvpn/pkcs11=2Ec
M src/openvpn/ro=
ute=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socks=2Ec
M src/openvpn/ssl=
=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/ssl_verify=2Ec
M src/openv=
pn/ssl_verify_openssl=2Ec
M src/openvpn/tun=2Ec
M src/openvpn/xkey_helper=
=2Ec
M src/openvpnserv/interactive=2Ec
M tests/unit_tests/openvpn/test_auth=
_token=2Ec
M tests/unit_tests/openvpn/test_pkcs11=2Ec
M tests/unit_tests/op=
envpn/test_user_pass=2Ec
25 files changed, 63 insertions(+), 86 deletions(-=
)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/95/=
1995/1

diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2E=
c
index b457b6f=2E=2E969f37f 100644
--- a/src/openvpn/auth_token=2Ec
+++ b/=
src/openvpn/auth_token=2Ec
@@ -464,7 +464,7 @@
 
     struct user_pass up;
=
     CLEAR(up);
-    strncpynt(up=2Eusername, multi->locked_username, sizeo=
f(up=2Eusername));
+    strlcpy(up=2Eusername, multi->locked_username, size=
of(up=2Eusername));
 
     generate_auth_token(&up, multi);
 
diff --git a/=
src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index a90ddae=2E=2Ecc1b300 =
100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -257,9 =
+257,8 @@
     int cap =3D buf_forward_capacity(buf);
     if (cap > 0)
   =
  {
-        strncpynt((char *)ptr, str, cap);
-        *(buf->data + buf->=
capacity - 1) =3D 0; /* windows vsnprintf needs this */
-        buf->len +=
=3D (int)strlen((char *)ptr);
+        int str_len =3D (int)strlcpy((char *=
)ptr, str, cap);
+        buf->len +=3D (str_len < cap) ? str_len : cap - 1=
;
         ret =3D true;
     }
     return ret;
diff --git a/src/openvpn/b=
uffer=2Eh b/src/openvpn/buffer=2Eh
index 58e10f0=2E=2Ec66ed1a 100644
--- a/=
src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -696,27 +696,6 @@
 }=

 
 /**
- * Like \c strncpy() but always null-terminates the destination=2E=

- *
- * Copies at most \c maxlen - 1 characters from \c src into \c dest a=
nd
- * writes a null terminator at \c dest[\c maxlen - 1]=2E  Does nothing =
if
- * \c maxlen is zero=2E
- *
- * @param dest    Destination buffer=2E
- =
* @param src     Source string=2E
- * @param maxlen  Size of the destinatio=
n buffer in bytes=2E
- */
-static inline void
-strncpynt(char *dest, const =
char *src, size_t maxlen)
-{
-    if (maxlen > 0)
-    {
-        strncpy(d=
est, src, maxlen - 1);
-        dest[maxlen - 1] =3D 0;
-    }
-}
-
-/**
  =
* Return true if the string contains at least one decimal digit=2E
  *
  * =
@param src   The null-terminated string to scan=2E
diff --git a/src/openvpn=
/dns=2Ec b/src/openvpn/dns=2Ec
index 713f41e=2E=2E87c9c5f 100644
--- a/src/=
openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -444,7 +444,7 @@
         =2Ei=
face =3D { =2Eindex =3D tt->adapter_index, =2Ename =3D "" },
         =2Efl=
ags =3D server->dnssec =3D=3D DNS_SECURITY_YES ? nrpt_dnssec : 0,
     };
-=
    strncpynt(nrpt=2Eiface=2Ename, tt->actual_name, sizeof(nrpt=2Eiface=2En=
ame));
+    strlcpy(nrpt=2Eiface=2Ename, tt->actual_name, sizeof(nrpt=2Eifa=
ce=2Ename));
 
     for (size_t i =3D 0; i < NRPT_ADDR_NUM; ++i)
     {
dif=
f --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 9306a96=2E=2E55=
d985d 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -393,=
8 +393,8 @@
                     ALLOC_OBJ_CLEAR_GC(rhs, struct remote_host=
_store, &c->options=2Egc);
                     c->options=2Erh_store =3D r=
hs;
                 }
-                strncpynt(rhs->host, p[2], RH_HOST_=
LEN);
-                strncpynt(rhs->port, p[3], RH_PORT_LEN);
+          =
      strlcpy(rhs->host, p[2], RH_HOST_LEN);
+                strlcpy(rhs->=
port, p[3], RH_PORT_LEN);
 
                 ce->remote =3D rhs->host;
    =
             ce->remote_port =3D rhs->port;
diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec
index 46339be=2E=2E8a476e6 100644
--- a/src/o=
penvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -784,7 +784,7 @@
        =
 ASSERT(man->connection=2Eup_query_type);
         if (streq(man->connectio=
n=2Eup_query_type, type))
         {
-            strncpynt(dest, string, l=
en);
+            strlcpy(dest, string, len);
             man_up_finalize(=
man);
             msg(M_CLIENT, "SUCCESS: '%s' %s entered, but not yet ver=
ified", type, prompt);
         }
@@ -2374,7 +2374,7 @@
     }
     struct =
user_pass up;
     CLEAR(up);
-    strcpynt(up=2Eusername, msg, sizeof(up=
=2Eusername));
+    strlcpy(up=2Eusername, msg, sizeof(up=2Eusername));
 
 =
    management_query_user_pass(management, &up, command, GET_USER_PASS_NEED=
_OK, (void *)0);
     return strcmp("ok", up=2Epassword) =3D=3D 0;
diff --g=
it a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec
index 0e4669a=2E=2Ea75bd8f=
 100644
--- a/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -303,7 +30=
3,7 @@
 
                 if (password_buf[0])
                 {
-        =
            strncpynt(up->password, password_buf, USER_PASS_LEN);
+        =
            strlcpy(up->password, password_buf, USER_PASS_LEN);
           =
      }
                 else
                 {
@@ -364,7 +364,7 @@
      =
               {
                         msg(M_FATAL, "ERROR: could not re=
ad challenge response from stdin");
                     }
-               =
     strncpynt(up->username, ac->user, USER_PASS_LEN);
+                   =
 strlcpy(up->username, ac->user, USER_PASS_LEN);
                     buf_p=
rintf(&packed_resp, "CRV1::%s::%s", ac->state_id, response);
              =
   }
                 else
@@ -452,7 +452,7 @@
         /* Use tag for blan=
k password if we are not prompting for one */
         if (flags & GET_USER=
_PASS_USERNAME_ONLY)
         {
-            strncpynt(up->password, blank_=
up, sizeof(up->password));
+            strlcpy(up->password, blank_up, siz=
eof(up->password));
         }
 
         string_mod(up->username, CC_PRINT=
, CC_CRLF, 0);
@@ -504,7 +504,7 @@
     if (strlen(token))
     {
         =
unprotect_user_pass(tk);
-        strncpynt(tk->password, token, USER_PASS_=
LEN);
+        strlcpy(tk->password, token, USER_PASS_LEN);
         tk->to=
ken_defined =3D true;
 
         /*
diff --git a/src/openvpn/multi=2Ec b/sr=
c/openvpn/multi=2Ec
index dda9232=2E=2Ea2b4e52 100644
--- a/src/openvpn/mul=
ti=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -461,7 +461,7 @@
     const char *pre=
fix =3D multi_instance_string(mi, true, &gc);
     if (prefix)
     {
-    =
    strncpynt(mi->msg_prefix, prefix, sizeof(mi->msg_prefix));
+        str=
lcpy(mi->msg_prefix, prefix, sizeof(mi->msg_prefix));
     }
     else
    =
 {
@@ -2657,7 +2657,7 @@
         {
             struct user_pass up;
     =
        CLEAR(up);
-            strncpynt(up=2Eusername, multi->locked_user=
name, sizeof(up=2Eusername));
+            strlcpy(up=2Eusername, multi->lo=
cked_username, sizeof(up=2Eusername));
 
             generate_auth_token(&=
up, multi);
         }
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/=
openvpn/networking_sitnl=2Ec
index d6510bb=2E=2E9f1e041 100644
--- a/src/op=
envpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -602,7=
 +602,7 @@
 
     /* save result in output variables */
     memcpy(best_gw=
, &res=2Egw, res=2Eaddr_size);
-    strncpynt(best_iface, res=2Eiface, IFNA=
MSIZ);
+    strlcpy(best_iface, res=2Eiface, IFNAMSIZ);
 err:
     return r=
et;
 }
@@ -1424,7 +1424,7 @@
             return -ENOENT;
         }
 
-   =
     strncpynt(type, RTA_DATA(tb_link[IFLA_INFO_KIND]), IFACE_TYPE_LEN_MAX)=
;
+        strlcpy(type, RTA_DATA(tb_link[IFLA_INFO_KIND]), IFACE_TYPE_LEN_=
MAX);
     }
 
     return 0;
diff --git a/src/openvpn/openssl_compat=2Eh b=
/src/openvpn/openssl_compat=2Eh
index 098bdd5=2E=2E49f2419 100644
--- a/src=
/openvpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -104,10=
 +104,10 @@
         curve =3D "(error fetching curve name)";
     }
 
-   =
 strncpynt(gname, curve, gname_sz);
+    strlcpy(gname, curve, gname_sz);
 =

-    /* strncpynt ensures null termination so just strlen is fine here */
=
-    *gname_len =3D strlen(curve);
+    /* strlcpy ensures null termination=
 so just strlen is fine here */
+    *gname_len =3D strlen(gname);
     ret=
urn 1;
 }
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L && !defined(OP=
ENSSL_NO_EC) */
diff --git a/src/openvpn/options_string=2Ec b/src/openvpn/o=
ptions_string=2Ec
index 88ab798=2E=2Eaa3bb94 100644
--- a/src/openvpn/optio=
ns_string=2Ec
+++ b/src/openvpn/options_string=2Ec
@@ -385,8 +385,8 @@
 con=
st char *
 options_string_version(const char *s, struct gc_arena *gc)
 {
- =
   struct buffer out =3D alloc_buf_gc(4, gc);
-    strncpynt((char *)BPTR(&=
out), s, 3);
+    struct buffer out =3D alloc_buf_gc(3, gc);
+    strlcpy((=
char *)BPTR(&out), s, 3);
     return BSTR(&out);
 }
 
diff --git a/src/ope=
nvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec
index d7dee97=2E=2E09c8996 100644
=
--- a/src/openvpn/pkcs11=2Ec
+++ b/src/openvpn/pkcs11=2Ec
@@ -224,7 +224,7 =
@@
     }
     else
     {
-        strncpynt(pin, token_pass=2Epassword, p=
in_max);
+        strlcpy(pin, token_pass=2Epassword, pin_max);
         pu=
rge_user_pass(&token_pass, true);
 
         if (strlen(pin) =3D=3D 0)
diff=
 --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 9209a76=2E=2E6=
0a1f5b 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -2=
968,7 +2968,7 @@
 
     if (msg=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_IN=
VALID)
     {
-        strncpynt(msg=2Eiface=2Ename, tt->actual_name, sizeo=
f(msg=2Eiface=2Ename));
+        strlcpy(msg=2Eiface=2Ename, tt->actual_nam=
e, sizeof(msg=2Eiface=2Ename));
     }
 
     status =3D do_route_service(a=
dd, &msg, sizeof(msg), tt->options=2Emsg_channel);
@@ -3137,7 +3137,7 @@
  =
               addr =3D ntohl(((struct sockaddr_in *)&ifr->ifr_addr)->sin_a=
ddr=2Es_addr);
 
                 /* get interface name */
-               =
 strncpynt(ifreq=2Eifr_name, ifr->ifr_name, sizeof(ifreq=2Eifr_name));
+   =
             strlcpy(ifreq=2Eifr_name, ifr->ifr_name, sizeof(ifreq=2Eifr_na=
me));
 
                 /* check that the interface is up */
             =
    if (ioctl(sd, SIOCGIFFLAGS, &ifreq) < 0)
@@ -3190,7 +3190,7 @@
        =
         }
 
                 /* save iface name */
-                strncp=
ynt(rgi->iface, ifreq=2Eifr_name, sizeof(rgi->iface));
+                str=
lcpy(rgi->iface, ifreq=2Eifr_name, sizeof(rgi->iface));
                 rg=
i->flags |=3D RGI_IFACE_DEFINED;
 
                 /* now get the hardware=
 address=2E */
@@ -3458,7 +3458,7 @@
 
         CLEAR(ifr);
         ifr=2E=
ifr_addr=2Esa_family =3D AF_INET;
-        strncpynt(ifr=2Eifr_name, rgi->i=
face, IFNAMSIZ);
+        strlcpy(ifr=2Eifr_name, rgi->iface, IFNAMSIZ);
 
=
         if (ioctl(sockfd, SIOCGIFNETMASK, (char *)&ifr) < 0)
         {
@@=
 -3487,7 +3487,7 @@
         struct ifreq ifreq =3D { 0 };
 
         /* no=
w get the hardware address=2E */
-        strncpynt(ifreq=2Eifr_name, rgi->=
iface, sizeof(ifreq=2Eifr_name));
+        strlcpy(ifreq=2Eifr_name, rgi->i=
face, sizeof(ifreq=2Eifr_name));
         if (ioctl(sockfd, SIOCGIFHWADDR, =
&ifreq) < 0)
         {
             msg(M_WARN, "GDG: SIOCGIFHWADDR(%s) fa=
iled", ifreq=2Eifr_name);
@@ -3746,7 +3746,7 @@
         {
             rgi=
->gateway=2Eaddr =3D ntohl(((struct sockaddr_in *)route=2Egateway)->sin_add=
r=2Es_addr);
             rgi->flags =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFIN=
ED;
-            strncpynt(rgi->iface, interface->ifr_name, sizeof(rgi->ifa=
ce));
+            strlcpy(rgi->iface, interface->ifr_name, sizeof(rgi->ifa=
ce));
         }
 
         int32 address_size =3D 0;
diff --git a/src/open=
vpn/socket=2Ec b/src/openvpn/socket=2Ec
index 33def4e=2E=2E0c585ad 100644
-=
-- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -3077,7 +3077,7=
 @@
 sockaddr_unix_init(struct sockaddr_un *local, const char *path)
 {
   =
  local->sun_family =3D PF_UNIX;
-    strncpynt(local->sun_path, path, size=
of(local->sun_path));
+    strlcpy(local->sun_path, path, sizeof(local->sun=
_path));
 }
 
 void
diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=
=2Ec
index b84da24=2E=2E781a5d9 100644
--- a/src/openvpn/socks=2Ec
+++ b/sr=
c/openvpn/socks=2Ec
@@ -58,12 +58,12 @@
     ASSERT(server);
     ASSERT(po=
rt);
 
-    strncpynt(p->server, server, sizeof(p->server));
+    strlcpy(p=
->server, server, sizeof(p->server));
     p->port =3D port;
 
     if (aut=
hfile)
     {
-        strncpynt(p->authfile, authfile, sizeof(p->authfile)=
);
+        strlcpy(p->authfile, authfile, sizeof(p->authfile));
     }
   =
  else
     {
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index =
aeec020=2E=2E7b61725 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=
=2Ec
@@ -272,7 +272,7 @@
         /* prompt for password even if --askpass =
wasn't specified */
         pem_password_setup(NULL);
         ASSERT(!pas=
sbuf=2Eprotected);
-        strncpynt(buf, passbuf=2Epassword, (size_t)size=
);
+        strlcpy(buf, passbuf=2Epassword, (size_t)size);
         purge_=
user_pass(&passbuf, false);
 
         return (int)strlen(buf);
@@ -2228,7 =
+2228,7 @@
         if (session->opt->pull && up !=3D &auth_token)
        =
 {
             unprotect_user_pass(&auth_token);
-            strncpynt(au=
th_token=2Eusername, up->username, USER_PASS_LEN);
+            strlcpy(aut=
h_token=2Eusername, up->username, USER_PASS_LEN);
             protect_user=
_pass(&auth_token);
         }
         protect_user_pass(up);
diff --git a=
/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 02fd556=2E=
=2E2d0be92 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_o=
penssl=2Ec
@@ -427,15 +427,14 @@
      * historically used names with - in =
them=2E Silently convert names
      * with - to names with _ to support bo=
th
      */
-    if (strlen(ciphers) >=3D (len - 1))
+    size_t ciphers_le=
n =3D strlcpy(openssl_ciphers, ciphers, len);
+    if (ciphers_len >=3D len=
)
     {
-        msg(M_FATAL, "Failed to set restricted TLS 1=2E3 cipher l=
ist, too long (>%zd)=2E",
+        msg(M_FATAL, "Failed to set restricted T=
LS 1=2E3 cipher list, too long (>%zu)=2E",
             len - 1);
     }
 
=
-    strncpynt(openssl_ciphers, ciphers, len);
-
-    for (size_t i =3D 0; =
i < strlen(openssl_ciphers); i++)
+    for (size_t i =3D 0; i < ciphers_len=
; i++)
     {
         if (openssl_ciphers[i] =3D=3D '-')
         {
diff -=
-git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 43ed98=
0=2E=2Ebdcb8fc 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ss=
l_verify=2Ec
@@ -1640,7 +1640,7 @@
             "TLS: Replacing client prov=
ided username '%s' with "
             "username from override-user '%s'",
=
             up->username, multi->locked_username);
-        strncpynt(up->=
username, multi->locked_username, sizeof(up->username));
+        strlcpy(u=
p->username, multi->locked_username, sizeof(up->username));
     }
 
     /=
*
diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_=
openssl=2Ec
index 6073e4e=2E=2E146a384 100644
--- a/src/openvpn/ssl_verify_=
openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -157,14 +157,16 @@
=
                     if ((ssize_t)strlen(buf) !=3D ASN1_STRING_length(name-=
>d=2Erfc822Name))
                     {
                         msg(D_TLS=
_ERRORS, "ASN1 ERROR: string contained terminating zero");
-               =
         OPENSSL_free(buf);
+                    }
+                    els=
e if (strlcpy(out, buf, size) >=3D size)
+                    {
+          =
              msg(D_TLS_ERRORS, "ASN1 ERROR: string too long");
           =
          }
                     else
                     {
-             =
           strncpynt(out, buf, size);
-                        OPENSSL_free=
(buf);
                         retval =3D true;
                     }
+  =
                  OPENSSL_free(buf);
                     break;
 
        =
         default:
@@ -243,9 +245,7 @@
         goto exit;
     }
 
-    str=
ncpynt(out, (char *)buf, size);
-
-    ret =3D (strlen((char *)buf) < size)=
 ? SUCCESS : FAILURE;
+    ret =3D (strlcpy(out, (char *)buf, size) < size)=
 ? SUCCESS : FAILURE;
 
 exit:
     OPENSSL_free(buf);
diff --git a/src/ope=
nvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 9e7e7d7=2E=2E478c109 100644
--- a/=
src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -127,7 +127,7 @@
 
     if=
 (addr=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)
     {
-        st=
rncpynt(addr=2Eiface=2Ename, tt->actual_name, sizeof(addr=2Eiface=2Ename));=

+        strlcpy(addr=2Eiface=2Ename, tt->actual_name, sizeof(addr=2Eiface=
=2Ename));
     }
 
     if (addr=2Efamily =3D=3D AF_INET)
@@ -188,12 +188,=
12 @@
     };
 
     /* interface name is required */
-    strncpynt(dns=2E=
iface=2Ename, tt->actual_name, sizeof(dns=2Eiface=2Ename));
+    strlcpy(dn=
s=2Eiface=2Ename, tt->actual_name, sizeof(dns=2Eiface=2Ename));
 
     /* o=
nly use domain when there are no search domains */
     if (o->domain && !o=
->domain_search_list[0])
     {
-        strncpynt(dns=2Edomains, o->domain=
, sizeof(dns=2Edomains));
+        strlcpy(dns=2Edomains, o->domain, sizeof=
(dns=2Edomains));
     }
 
     /* Create a comma separated list of search =
domains */
@@ -260,7 +260,7 @@
                               =2Eaddr_len =
=3D addr_len };
 
     /* interface name is required */
-    strncpynt(dns=
=2Eiface=2Ename, tt->actual_name, sizeof(dns=2Eiface=2Ename));
+    strlcpy=
(dns=2Eiface=2Ename, tt->actual_name, sizeof(dns=2Eiface=2Ename));
 
     i=
f (addr_len > _countof(dns=2Eaddr))
     {
@@ -324,7 +324,7 @@
            =
                     =2Eaddr_len =3D addr_len };
 
     /* interface name i=
s required */
-    strncpynt(wins=2Eiface=2Ename, tt->actual_name, sizeof(w=
ins=2Eiface=2Ename));
+    strlcpy(wins=2Eiface=2Ename, tt->actual_name, si=
zeof(wins=2Eiface=2Ename));
 
     if (addr_len > _countof(wins=2Eaddr))
  =
   {
@@ -372,7 +372,7 @@
                                   =2Eiface =3D { =
=2Eindex =3D tt->adapter_index },
                                   =2Emtu=
 =3D mtu,
                                   =2Efamily =3D family };
-    s=
trncpynt(mtu_msg=2Eiface=2Ename, tt->actual_name, sizeof(mtu_msg=2Eiface=2E=
name));
+    strlcpy(mtu_msg=2Eiface=2Ename, tt->actual_name, sizeof(mtu_ms=
g=2Eiface=2Ename));
     if (family =3D=3D AF_INET6 && mtu < 1280)
     {
 =
        msg(M_INFO,
@@ -2119,7 +2119,7 @@
          */
         if (strcmp(=
dev, "tun") && strcmp(dev, "tap"))
         {
-            strncpynt(ifr=2E=
ifr_name, dev, IFNAMSIZ);
+            strlcpy(ifr=2Eifr_name, dev, IFNAMSI=
Z);
         }
 
         /*
@@ -2145,7 +2145,7 @@
             if ((ctl_fd=
 =3D socket(AF_INET, SOCK_DGRAM, 0)) >=3D 0)
             {
               =
  CLEAR(netifr);
-                strncpynt(netifr=2Eifr_name, ifr=2Eifr_na=
me, IFNAMSIZ);
+                strlcpy(netifr=2Eifr_name, ifr=2Eifr_name, =
IFNAMSIZ);
                 netifr=2Eifr_qlen =3D tt->options=2Etxqueuelen;=

                 if (ioctl(ctl_fd, SIOCSIFTXQLEN, (void *)&netifr) >=3D 0)=

                 {
@@ -2401,7 +2401,7 @@
         {
             msg(M_ERR=
, "Can't get flags");
         }
-        strncpynt(ifr=2Elifr_name, tt->ac=
tual_name, sizeof(ifr=2Elifr_name));
+        strlcpy(ifr=2Elifr_name, tt->=
actual_name, sizeof(ifr=2Elifr_name));
         ifr=2Elifr_ppa =3D ppa;
   =
      /* Assign ppa according to the unit number returned by tun device */
=
         if (ioctl(if_fd, SIOCSLIFNAME, &ifr) < 0)
@@ -2469,7 +2469,7 @@
  =
   }
 
     CLEAR(ifr);
-    strncpynt(ifr=2Elifr_name, tt->actual_name, si=
zeof(ifr=2Elifr_name));
+    strlcpy(ifr=2Elifr_name, tt->actual_name, size=
of(ifr=2Elifr_name));
     ifr=2Elifr_ip_muxid =3D ip_muxid;
     if (tt->t=
ype =3D=3D DEV_TYPE_TAP)
     {
@@ -2510,7 +2510,7 @@
     {
         struc=
t lifreq ifr;
         CLEAR(ifr);
-        strncpynt(ifr=2Elifr_name, tt->=
actual_name, sizeof(ifr=2Elifr_name));
+        strlcpy(ifr=2Elifr_name, tt=
->actual_name, sizeof(ifr=2Elifr_name));
 
         if (ioctl(tt->ip_fd, SI=
OCGLIFFLAGS, &ifr) < 0)
         {
diff --git a/src/openvpn/xkey_helper=2Ec=
 b/src/openvpn/xkey_helper=2Ec
index 69be67a=2E=2E1149c7b 100644
--- a/src/=
openvpn/xkey_helper=2Ec
+++ b/src/openvpn/xkey_helper=2Ec
@@ -198,7 +198,7 =
@@
     {
         if (!strcmp(alg=2Eop, "Sign"))
         {
-            s=
trncpynt(alg_str, "ECDSA", sizeof(alg_str));
+            strlcpy(alg_str, =
"ECDSA", sizeof(alg_str));
         }
         else
         {
@@ -207,7 +2=
07,7 @@
     }
     else if (!strcmp(alg=2Ekeytype, "ED448") || !strcmp(alg=
=2Ekeytype, "ED25519"))
     {
-        strncpynt(alg_str, alg=2Ekeytype, s=
izeof(alg_str));
+        strlcpy(alg_str, alg=2Ekeytype, sizeof(alg_str));=

     }
     /* else assume RSA key */
     else if (!strcmp(alg=2Epadmode,=
 "pkcs1") && (flags & MF_EXTERNAL_KEY_PKCS1PAD))
@@ -221,7 +221,7 @@
      =
       }
             tbs =3D enc;
             tbslen =3D enc_len;
-      =
      strncpynt(alg_str, "RSA_PKCS1_PADDING", sizeof(alg_str));
+          =
  strlcpy(alg_str, "RSA_PKCS1_PADDING", sizeof(alg_str));
         }
      =
   /* For undigested message, add hashalg=3Ddigest parameter */
         el=
se
@@ -232,7 +232,7 @@
     else if (!strcmp(alg=2Epadmode, "none") && (fla=
gs & MF_EXTERNAL_KEY_NOPADDING)
              && !strcmp(alg=2Eop, "Sign"))=
 /* NO_PADDING requires digested data */
     {
-        strncpynt(alg_str,=
 "RSA_NO_PADDING", sizeof(alg_str));
+        strlcpy(alg_str, "RSA_NO_PADD=
ING", sizeof(alg_str));
     }
     else if (!strcmp(alg=2Epadmode, "pss") =
&& (flags & MF_EXTERNAL_KEY_PSSPAD))
     {
diff --git a/src/openvpnserv/in=
teractive=2Ec b/src/openvpnserv/interactive=2Ec
index 9a68bbb=2E=2Ee0fb976 =
100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interact=
ive=2Ec
@@ -1810,7 +1810,7 @@
             wide_domains =3D NULL;
         =
    goto out;
         }
-        strncpy(undo_data->itf_name, itf_name, si=
zeof(undo_data->itf_name));
+        strlcpy(undo_data->itf_name, itf_name,=
 sizeof(undo_data->itf_name));
         undo_data->domains =3D wide_domains=
;
 
         if (AddDnsSearchDomains(list_key, have_list, wide_domains) =3D=
=3D FALSE
diff --git a/tests/unit_tests/openvpn/test_auth_token=2Ec b/tests=
/unit_tests/openvpn/test_auth_token=2Ec
index 89c418e=2E=2E3a3bfb4 100644
-=
-- a/tests/unit_tests/openvpn/test_auth_token=2Ec
+++ b/tests/unit_tests/op=
envpn/test_auth_token=2Ec
@@ -273,7 +273,7 @@
     }
     else if (streq(na=
me, "session_id"))
     {
-        strncpynt(last_session_id_value, value, =
sizeof(last_session_id_value));
+        strlcpy(last_session_id_value, val=
ue, sizeof(last_session_id_value));
     }
 }
 
diff --git a/tests/unit_tes=
ts/openvpn/test_pkcs11=2Ec b/tests/unit_tests/openvpn/test_pkcs11=2Ec
index=
 a54c504=2E=2E3351eac 100644
--- a/tests/unit_tests/openvpn/test_pkcs11=2Ec=

+++ b/tests/unit_tests/openvpn/test_pkcs11=2Ec
@@ -164,7 +164,7 @@
     if=
 (!strcmp(prefix, "pkcs11-id-request") && flags & GET_USER_PASS_NEED_STR)
 =
    {
         assert_true(pkcs11_id_management);
-        strncpynt(up->pa=
ssword, pkcs11_id_current, sizeof(up->password));
+        strlcpy(up->pass=
word, pkcs11_id_current, sizeof(up->password));
     }
     else if (flags =
& GET_USER_PASS_PASSWORD_ONLY)
     {
diff --git a/tests/unit_tests/openvpn=
/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec
index 5ad=
4730=2E=2Ed1b4c97 100644
--- a/tests/unit_tests/openvpn/test_user_pass=2Ec
=
+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec
@@ -53,7 +53,7 @@
     fo=
r (int i =3D 0; i < QUERY_USER_NUMSLOTS && query_user[i]=2Eresponse !=3D NU=
LL; i++)
     {
         check_expected_ptr(query_user[i]=2Eprompt);
-     =
   strncpynt(query_user[i]=2Eresponse, mock_ptr_type(char *), query_user[i]=
=2Eresponse_len);
+        strlcpy(query_user[i]=2Eresponse, mock_ptr_type(=
char *), query_user[i]=2Eresponse_len);
     }
 
     return mock();

-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1995?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib1b4a9544e09506e950016=
09262269ab8154241e
Gerrit-Change-Number: 1995
Gerrit-PatchSet: 1
Gerrit-Own=
er: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>

--D11OG24K0Vw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1995?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">Replace strncpynt with strlcpy<br><br>Mostly a straight-fo=
rward replacement=2E But in a few<br>places I used the additional return co=
de from strlcpy<br>instead of duplicating the strlen call=2E<br><br>Change-=
Id: Ib1b4a9544e09506e95001609262269ab8154241e<br>Signed-off-by: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/auth_token=
=2Ec<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openv=
pn/dns=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/o=
penvpn/misc=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/networking_sitn=
l=2Ec<br>M src/openvpn/openssl_compat=2Eh<br>M src/openvpn/options_string=
=2Ec<br>M src/openvpn/pkcs11=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvp=
n/socket=2Ec<br>M src/openvpn/socks=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/o=
penvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn/ssl=
_verify_openssl=2Ec<br>M src/openvpn/tun=2Ec<br>M src/openvpn/xkey_helper=
=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M tests/unit_tests/openvpn/tes=
t_auth_token=2Ec<br>M tests/unit_tests/openvpn/test_pkcs11=2Ec<br>M tests/u=
nit_tests/openvpn/test_user_pass=2Ec<br>25 files changed, 63 insertions(+),=
 86 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/95/1995/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index b457b6f=
=2E=2E969f37f 100644</span><br><span>--- a/src/openvpn/auth_token=2Ec</span=
><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -464,7 +464,=
7 @@</span><br><span> </span><br><span>     struct user_pass up;</span><br>=
<span>     CLEAR(up);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    strncpynt(up=2Eusername, multi-&gt;locked_username, sizeof(up=2Eusernam=
e));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strlcpy(up=
=2Eusername, multi-&gt;locked_username, sizeof(up=2Eusername));</span><br><=
span> </span><br><span>     generate_auth_token(&amp;up, multi);</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/b=
uffer=2Ec</span><br><span>index a90ddae=2E=2Ecc1b300 100644</span><br><span=
>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec<=
/span><br><span>@@ -257,9 +257,8 @@</span><br><span>     int cap =3D buf_fo=
rward_capacity(buf);</span><br><span>     if (cap &gt; 0)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpyn=
t((char *)ptr, str, cap);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        *(buf-&gt;data + buf-&gt;capacity - 1) =3D 0; /* windows vsnpri=
ntf needs this */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    buf-&gt;len +=3D (int)strlen((char *)ptr);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        int str_len =3D (int)strlcpy((char *)ptr=
, str, cap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 buf-&gt;len +=3D (str_len &lt; cap) ? str_len : cap - 1;</span><br><span> =
        ret =3D true;</span><br><span>     }</span><br><span>     return re=
t;</span><br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=
=2Eh</span><br><span>index 58e10f0=2E=2Ec66ed1a 100644</span><br><span>--- =
a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span=
><br><span>@@ -696,27 +696,6 @@</span><br><span> }</span><br><span> </span>=
<br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Like=
 \c strncpy() but always null-terminates the destination=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * Copies at most \c maxlen - 1 characters from \c src i=
nto \c dest and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * wri=
tes a null terminator at \c dest[\c maxlen - 1]=2E  Does nothing if</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * \c maxlen is zero=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * @param dest    Destination buffer=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * @param src     Source str=
ing=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param maxle=
n  Size of the destination buffer in bytes=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-strncpynt(char *dest, const char *src, size_t maxlen)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (maxlen &gt; 0)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        strncpy(dest, src, maxlen - 1);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        dest[maxlen - 1] =3D 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span>  * Retur=
n true if the string contains at least one decimal digit=2E</span><br><span=
>  *</span><br><span>  * @param src   The null-terminated string to scan=2E=
</span><br><span>diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec</sp=
an><br><span>index 713f41e=2E=2E87c9c5f 100644</span><br><span>--- a/src/op=
envpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</span><br><span>@@ =
-444,7 +444,7 @@</span><br><span>         =2Eiface =3D { =2Eindex =3D tt-&g=
t;adapter_index, =2Ename =3D &quot;&quot; },</span><br><span>         =2Efl=
ags =3D server-&gt;dnssec =3D=3D DNS_SECURITY_YES ? nrpt_dnssec : 0,</span>=
<br><span>     };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
strncpynt(nrpt=2Eiface=2Ename, tt-&gt;actual_name, sizeof(nrpt=2Eiface=2Ena=
me));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strlcpy(nr=
pt=2Eiface=2Ename, tt-&gt;actual_name, sizeof(nrpt=2Eiface=2Ename));</span>=
<br><span> </span><br><span>     for (size_t i =3D 0; i &lt; NRPT_ADDR_NUM;=
 ++i)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec</span><br><span>index 9306a96=2E=2E55d985d 1006=
44</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/ope=
nvpn/init=2Ec</span><br><span>@@ -393,8 +393,8 @@</span><br><span>         =
            ALLOC_OBJ_CLEAR_GC(rhs, struct remote_host_store, &amp;c-&gt;op=
tions=2Egc);</span><br><span>                     c-&gt;options=2Erh_store =
=3D rhs;</span><br><span>                 }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                strncpynt(rhs-&gt;host, p[2], RH_HOST=
_LEN);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 strncpynt(rhs-&gt;port, p[3], RH_PORT_LEN);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                strlcpy(rhs-&gt;host, p[2], RH_HOS=
T_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    strlcpy(rhs-&gt;port, p[3], RH_PORT_LEN);</span><br><span> </span><br><=
span>                 ce-&gt;remote =3D rhs-&gt;host;</span><br><span>     =
            ce-&gt;remote_port =3D rhs-&gt;port;</span><br><span>diff --git=
 a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 46=
339be=2E=2E8a476e6 100644</span><br><span>--- a/src/openvpn/manage=2Ec</spa=
n><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -784,7 +784,7 @=
@</span><br><span>         ASSERT(man-&gt;connection=2Eup_query_type);</spa=
n><br><span>         if (streq(man-&gt;connection=2Eup_query_type, type))</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            strncpynt(dest, string, len);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            strlcpy(dest, string, len);</span><br=
><span>             man_up_finalize(man);</span><br><span>             msg(=
M_CLIENT, &quot;SUCCESS: &#39;%s&#39; %s entered, but not yet verified&quot=
;, type, prompt);</span><br><span>         }</span><br><span>@@ -2374,7 +23=
74,7 @@</span><br><span>     }</span><br><span>     struct user_pass up;</s=
pan><br><span>     CLEAR(up);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    strcpynt(up=2Eusername, msg, sizeof(up=2Eusername));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    strlcpy(up=2Eusername, msg=
, sizeof(up=2Eusername));</span><br><span> </span><br><span>     management=
_query_user_pass(management, &amp;up, command, GET_USER_PASS_NEED_OK, (void=
 *)0);</span><br><span>     return strcmp(&quot;ok&quot;, up=2Epassword) =
=3D=3D 0;</span><br><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/m=
isc=2Ec</span><br><span>index 0e4669a=2E=2Ea75bd8f 100644</span><br><span>-=
-- a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span>=
<br><span>@@ -303,7 +303,7 @@</span><br><span> </span><br><span>           =
      if (password_buf[0])</span><br><span>                 {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    strncpynt(up-&g=
t;password, password_buf, USER_PASS_LEN);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    strlcpy(up-&gt;password, password=
_buf, USER_PASS_LEN);</span><br><span>                 }</span><br><span>  =
               else</span><br><span>                 {</span><br><span>@@ -=
364,7 +364,7 @@</span><br><span>                     {</span><br><span>    =
                     msg(M_FATAL, &quot;ERROR: could not read challenge res=
ponse from stdin&quot;);</span><br><span>                     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    strncpynt(up-=
&gt;username, ac-&gt;user, USER_PASS_LEN);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    strlcpy(up-&gt;username, ac-&gt;=
user, USER_PASS_LEN);</span><br><span>                     buf_printf(&amp;=
packed_resp, &quot;CRV1::%s::%s&quot;, ac-&gt;state_id, response);</span><b=
r><span>                 }</span><br><span>                 else</span><br>=
<span>@@ -452,7 +452,7 @@</span><br><span>         /* Use tag for blank pas=
sword if we are not prompting for one */</span><br><span>         if (flags=
 &amp; GET_USER_PASS_USERNAME_ONLY)</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            strncpynt(up-&gt;passw=
ord, blank_up, sizeof(up-&gt;password));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            strlcpy(up-&gt;password, blank_up, sizeof(=
up-&gt;password));</span><br><span>         }</span><br><span> </span><br><=
span>         string_mod(up-&gt;username, CC_PRINT, CC_CRLF, 0);</span><br>=
<span>@@ -504,7 +504,7 @@</span><br><span>     if (strlen(token))</span><br=
><span>     {</span><br><span>         unprotect_user_pass(tk);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(tk-&gt;password=
, token, USER_PASS_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        strlcpy(tk-&gt;password, token, USER_PASS_LEN);</span><br><spa=
n>         tk-&gt;token_defined =3D true;</span><br><span> </span><br><span=
>         /*</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openv=
pn/multi=2Ec</span><br><span>index dda9232=2E=2Ea2b4e52 100644</span><br><s=
pan>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec=
</span><br><span>@@ -461,7 +461,7 @@</span><br><span>     const char *prefi=
x =3D multi_instance_string(mi, true, &amp;gc);</span><br><span>     if (pr=
efix)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        strncpynt(mi-&gt;msg_prefix, prefix, sizeof(mi-&gt;msg_prefi=
x));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy=
(mi-&gt;msg_prefix, prefix, sizeof(mi-&gt;msg_prefix));</span><br><span>   =
  }</span><br><span>     else</span><br><span>     {</span><br><span>@@ -26=
57,7 +2657,7 @@</span><br><span>         {</span><br><span>             str=
uct user_pass up;</span><br><span>             CLEAR(up);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            strncpynt(up=2Eusername, mu=
lti-&gt;locked_username, sizeof(up=2Eusername));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            strlcpy(up=2Eusername, multi-&gt;l=
ocked_username, sizeof(up=2Eusername));</span><br><span> </span><br><span> =
            generate_auth_token(&amp;up, multi);</span><br><span>         }=
</span><br><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvp=
n/networking_sitnl=2Ec</span><br><span>index d6510bb=2E=2E9f1e041 100644</s=
pan><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/=
src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -602,7 +602,7 @@</span>=
<br><span> </span><br><span>     /* save result in output variables */</spa=
n><br><span>     memcpy(best_gw, &amp;res=2Egw, res=2Eaddr_size);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(best_iface, res=
=2Eiface, IFNAMSIZ);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    strlcpy(best_iface, res=2Eiface, IFNAMSIZ);</span><br><span> err:</spa=
n><br><span>     return ret;</span><br><span> }</span><br><span>@@ -1424,7 =
+1424,7 @@</span><br><span>             return -ENOENT;</span><br><span>   =
      }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        strncpynt(type, RTA_DATA(tb_link[IFLA_INFO_KIND]), IFACE_TYPE_L=
EN_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        str=
lcpy(type, RTA_DATA(tb_link[IFLA_INFO_KIND]), IFACE_TYPE_LEN_MAX);</span><b=
r><span>     }</span><br><span> </span><br><span>     return 0;</span><br><=
span>diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_comp=
at=2Eh</span><br><span>index 098bdd5=2E=2E49f2419 100644</span><br><span>--=
- a/src/openvpn/openssl_compat=2Eh</span><br><span>+++ b/src/openvpn/openss=
l_compat=2Eh</span><br><span>@@ -104,10 +104,10 @@</span><br><span>        =
 curve =3D &quot;(error fetching curve name)&quot;;</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
strncpynt(gname, curve, gname_sz);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    strlcpy(gname, curve, gname_sz);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* strncpynt ensures nu=
ll termination so just strlen is fine here */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    *gname_len =3D strlen(curve);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* strlcpy ensures null terminati=
on so just strlen is fine here */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    *gname_len =3D strlen(gname);</span><br><span>     return=
 1;</span><br><span> }</span><br><span> #endif /* if OPENSSL_VERSION_NUMBER=
 &lt; 0x30000000L &amp;&amp; !defined(OPENSSL_NO_EC) */</span><br><span>dif=
f --git a/src/openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec</=
span><br><span>index 88ab798=2E=2Eaa3bb94 100644</span><br><span>--- a/src/=
openvpn/options_string=2Ec</span><br><span>+++ b/src/openvpn/options_string=
=2Ec</span><br><span>@@ -385,8 +385,8 @@</span><br><span> const char *</spa=
n><br><span> options_string_version(const char *s, struct gc_arena *gc)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct buffer out =3D alloc_buf_gc(4, gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    strncpynt((char *)BPTR(&amp;out), s, 3);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer out =3D alloc=
_buf_gc(3, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
strlcpy((char *)BPTR(&amp;out), s, 3);</span><br><span>     return BSTR(&am=
p;out);</span><br><span> }</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec</span><br><span>index d7dee9=
7=2E=2E09c8996 100644</span><br><span>--- a/src/openvpn/pkcs11=2Ec</span><b=
r><span>+++ b/src/openvpn/pkcs11=2Ec</span><br><span>@@ -224,7 +224,7 @@</s=
pan><br><span>     }</span><br><span>     else</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(pin, toke=
n_pass=2Epassword, pin_max);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        strlcpy(pin, token_pass=2Epassword, pin_max);</span><br><s=
pan>         purge_user_pass(&amp;token_pass, true);</span><br><span> </spa=
n><br><span>         if (strlen(pin) =3D=3D 0)</span><br><span>diff --git a=
/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 9209a7=
6=2E=2E60a1f5b 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br=
><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -2968,7 +2968,7 @@</s=
pan><br><span> </span><br><span>     if (msg=2Eiface=2Eindex =3D=3D TUN_ADA=
PTER_INDEX_INVALID)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        strncpynt(msg=2Eiface=2Ename, tt-&gt;actual_na=
me, sizeof(msg=2Eiface=2Ename));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        strlcpy(msg=2Eiface=2Ename, tt-&gt;actual_name, sizeof=
(msg=2Eiface=2Ename));</span><br><span>     }</span><br><span> </span><br><=
span>     status =3D do_route_service(add, &amp;msg, sizeof(msg), tt-&gt;op=
tions=2Emsg_channel);</span><br><span>@@ -3137,7 +3137,7 @@</span><br><span=
>                 addr =3D ntohl(((struct sockaddr_in *)&amp;ifr-&gt;ifr_ad=
dr)-&gt;sin_addr=2Es_addr);</span><br><span> </span><br><span>             =
    /* get interface name */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                strncpynt(ifreq=2Eifr_name, ifr-&gt;ifr_name, sizeof=
(ifreq=2Eifr_name));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                strlcpy(ifreq=2Eifr_name, ifr-&gt;ifr_name, sizeof(ifreq=
=2Eifr_name));</span><br><span> </span><br><span>                 /* check =
that the interface is up */</span><br><span>                 if (ioctl(sd, =
SIOCGIFFLAGS, &amp;ifreq) &lt; 0)</span><br><span>@@ -3190,7 +3190,7 @@</sp=
an><br><span>                 }</span><br><span> </span><br><span>         =
        /* save iface name */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                strncpynt(rgi-&gt;iface, ifreq=2Eifr_name, sizeof(r=
gi-&gt;iface));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            strlcpy(rgi-&gt;iface, ifreq=2Eifr_name, sizeof(rgi-&gt;iface))=
;</span><br><span>                 rgi-&gt;flags |=3D RGI_IFACE_DEFINED;</s=
pan><br><span> </span><br><span>                 /* now get the hardware ad=
dress=2E */</span><br><span>@@ -3458,7 +3458,7 @@</span><br><span> </span><=
br><span>         CLEAR(ifr);</span><br><span>         ifr=2Eifr_addr=2Esa_=
family =3D AF_INET;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      strncpynt(ifr=2Eifr_name, rgi-&gt;iface, IFNAMSIZ);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        strlcpy(ifr=2Eifr_name, rgi-&=
gt;iface, IFNAMSIZ);</span><br><span> </span><br><span>         if (ioctl(s=
ockfd, SIOCGIFNETMASK, (char *)&amp;ifr) &lt; 0)</span><br><span>         {=
</span><br><span>@@ -3487,7 +3487,7 @@</span><br><span>         struct ifre=
q ifreq =3D { 0 };</span><br><span> </span><br><span>         /* now get th=
e hardware address=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        strncpynt(ifreq=2Eifr_name, rgi-&gt;iface, sizeof(ifreq=2Eifr_na=
me));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcp=
y(ifreq=2Eifr_name, rgi-&gt;iface, sizeof(ifreq=2Eifr_name));</span><br><sp=
an>         if (ioctl(sockfd, SIOCGIFHWADDR, &amp;ifreq) &lt; 0)</span><br>=
<span>         {</span><br><span>             msg(M_WARN, &quot;GDG: SIOCGI=
FHWADDR(%s) failed&quot;, ifreq=2Eifr_name);</span><br><span>@@ -3746,7 +37=
46,7 @@</span><br><span>         {</span><br><span>             rgi-&gt;gat=
eway=2Eaddr =3D ntohl(((struct sockaddr_in *)route=2Egateway)-&gt;sin_addr=
=2Es_addr);</span><br><span>             rgi-&gt;flags =3D RGI_ADDR_DEFINED=
 | RGI_IFACE_DEFINED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            strncpynt(rgi-&gt;iface, interface-&gt;ifr_name, sizeof(rgi-&gt=
;iface));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  strlcpy(rgi-&gt;iface, interface-&gt;ifr_name, sizeof(rgi-&gt;iface));</s=
pan><br><span>         }</span><br><span> </span><br><span>         int32 a=
ddress_size =3D 0;</span><br><span>diff --git a/src/openvpn/socket=2Ec b/sr=
c/openvpn/socket=2Ec</span><br><span>index 33def4e=2E=2E0c585ad 100644</spa=
n><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/=
socket=2Ec</span><br><span>@@ -3077,7 +3077,7 @@</span><br><span> sockaddr_=
unix_init(struct sockaddr_un *local, const char *path)</span><br><span> {</=
span><br><span>     local-&gt;sun_family =3D PF_UNIX;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    strncpynt(local-&gt;sun_path, path, siz=
eof(local-&gt;sun_path));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    strlcpy(local-&gt;sun_path, path, sizeof(local-&gt;sun_path));</s=
pan><br><span> }</span><br><span> </span><br><span> void</span><br><span>di=
ff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec</span><br><span>in=
dex b84da24=2E=2E781a5d9 100644</span><br><span>--- a/src/openvpn/socks=2Ec=
</span><br><span>+++ b/src/openvpn/socks=2Ec</span><br><span>@@ -58,12 +58,=
12 @@</span><br><span>     ASSERT(server);</span><br><span>     ASSERT(port=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   strncpynt(p-&gt;server, server, sizeof(p-&gt;server));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    strlcpy(p-&gt;server, server, siz=
eof(p-&gt;server));</span><br><span>     p-&gt;port =3D port;</span><br><sp=
an> </span><br><span>     if (authfile)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(p-&gt;authfile, =
authfile, sizeof(p-&gt;authfile));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        strlcpy(p-&gt;authfile, authfile, sizeof(p-&gt;authf=
ile));</span><br><span>     }</span><br><span>     else</span><br><span>   =
  {</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec<=
/span><br><span>index aeec020=2E=2E7b61725 100644</span><br><span>--- a/src=
/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>=
@@ -272,7 +272,7 @@</span><br><span>         /* prompt for password even if=
 --askpass wasn&#39;t specified */</span><br><span>         pem_password_se=
tup(NULL);</span><br><span>         ASSERT(!passbuf=2Eprotected);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(buf, passbuf=
=2Epassword, (size_t)size);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        strlcpy(buf, passbuf=2Epassword, (size_t)size);</span><br><=
span>         purge_user_pass(&amp;passbuf, false);</span><br><span> </span=
><br><span>         return (int)strlen(buf);</span><br><span>@@ -2228,7 +22=
28,7 @@</span><br><span>         if (session-&gt;opt-&gt;pull &amp;&amp; up=
 !=3D &amp;auth_token)</span><br><span>         {</span><br><span>         =
    unprotect_user_pass(&amp;auth_token);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            strncpynt(auth_token=2Eusername, up-&gt;use=
rname, USER_PASS_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            strlcpy(auth_token=2Eusername, up-&gt;username, USER_PASS_LE=
N);</span><br><span>             protect_user_pass(&amp;auth_token);</span>=
<br><span>         }</span><br><span>         protect_user_pass(up);</span>=
<br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openss=
l=2Ec</span><br><span>index 02fd556=2E=2E2d0be92 100644</span><br><span>---=
 a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openss=
l=2Ec</span><br><span>@@ -427,15 +427,14 @@</span><br><span>      * histori=
cally used names with - in them=2E Silently convert names</span><br><span> =
     * with - to names with _ to support both</span><br><span>      */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (strlen(ciphers) &g=
t;=3D (len - 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 size_t ciphers_len =3D strlcpy(openssl_ciphers, ciphers, len);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (ciphers_len &gt;=3D len=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(M_FATAL, &quot;Failed to set restricted TLS 1=2E3 cipher lis=
t, too long (&gt;%zd)=2E&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_FATAL, &quot;Failed to set restricted TLS 1=2E3 c=
ipher list, too long (&gt;%zu)=2E&quot;,</span><br><span>             len -=
 1);</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    strncpynt(openssl_ciphers, ciphers, len);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    for (size_t i =3D 0; i &lt; strlen(openssl_c=
iphers); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r (size_t i =3D 0; i &lt; ciphers_len; i++)</span><br><span>     {</span><b=
r><span>         if (openssl_ciphers[i] =3D=3D &#39;-&#39;)</span><br><span=
>         {</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/o=
penvpn/ssl_verify=2Ec</span><br><span>index 43ed980=2E=2Ebdcb8fc 100644</sp=
an><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/ope=
nvpn/ssl_verify=2Ec</span><br><span>@@ -1640,7 +1640,7 @@</span><br><span> =
            &quot;TLS: Replacing client provided username &#39;%s&#39; with=
 &quot;</span><br><span>             &quot;username from override-user &#39=
;%s&#39;&quot;,</span><br><span>             up-&gt;username, multi-&gt;loc=
ked_username);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 strncpynt(up-&gt;username, multi-&gt;locked_username, sizeof(up-&gt;userna=
me));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcp=
y(up-&gt;username, multi-&gt;locked_username, sizeof(up-&gt;username));</sp=
an><br><span>     }</span><br><span> </span><br><span>     /*</span><br><sp=
an>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify=
_openssl=2Ec</span><br><span>index 6073e4e=2E=2E146a384 100644</span><br><s=
pan>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>+++ b/src/open=
vpn/ssl_verify_openssl=2Ec</span><br><span>@@ -157,14 +157,16 @@</span><br>=
<span>                     if ((ssize_t)strlen(buf) !=3D ASN1_STRING_length=
(name-&gt;d=2Erfc822Name))</span><br><span>                     {</span><br=
><span>                         msg(D_TLS_ERRORS, &quot;ASN1 ERROR: string =
contained terminating zero&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        OPENSSL_free(buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    else if (strlcpy(=
out, buf, size) &gt;=3D size)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        msg(D_TLS_ERRORS, &quot;ASN1 ERROR: str=
ing too long&quot;);</span><br><span>                     }</span><br><span=
>                     else</span><br><span>                     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        strncpy=
nt(out, buf, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                      OPENSSL_free(buf);</span><br><span>                  =
       retval =3D true;</span><br><span>                     }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    OPENSSL_free=
(buf);</span><br><span>                     break;</span><br><span> </span>=
<br><span>                 default:</span><br><span>@@ -243,9 +245,7 @@</sp=
an><br><span>         goto exit;</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(out, (cha=
r *)buf, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D (strlen((char *=
)buf) &lt; size) ? SUCCESS : FAILURE;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ret =3D (strlcpy(out, (char *)buf, size) &lt; size) ?=
 SUCCESS : FAILURE;</span><br><span> </span><br><span> exit:</span><br><spa=
n>     OPENSSL_free(buf);</span><br><span>diff --git a/src/openvpn/tun=2Ec =
b/src/openvpn/tun=2Ec</span><br><span>index 9e7e7d7=2E=2E478c109 100644</sp=
an><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tu=
n=2Ec</span><br><span>@@ -127,7 +127,7 @@</span><br><span> </span><br><span=
>     if (addr=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
trncpynt(addr=2Eiface=2Ename, tt-&gt;actual_name, sizeof(addr=2Eiface=2Enam=
e));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy=
(addr=2Eiface=2Ename, tt-&gt;actual_name, sizeof(addr=2Eiface=2Ename));</sp=
an><br><span>     }</span><br><span> </span><br><span>     if (addr=2Efamil=
y =3D=3D AF_INET)</span><br><span>@@ -188,12 +188,12 @@</span><br><span>   =
  };</span><br><span> </span><br><span>     /* interface name is required *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(dns=2E=
iface=2Ename, tt-&gt;actual_name, sizeof(dns=2Eiface=2Ename));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    strlcpy(dns=2Eiface=2Ename, =
tt-&gt;actual_name, sizeof(dns=2Eiface=2Ename));</span><br><span> </span><b=
r><span>     /* only use domain when there are no search domains */</span><=
br><span>     if (o-&gt;domain &amp;&amp; !o-&gt;domain_search_list[0])</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      strncpynt(dns=2Edomains, o-&gt;domain, sizeof(dns=2Edomains));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(dns=2Edoma=
ins, o-&gt;domain, sizeof(dns=2Edomains));</span><br><span>     }</span><br=
><span> </span><br><span>     /* Create a comma separated list of search do=
mains */</span><br><span>@@ -260,7 +260,7 @@</span><br><span>              =
                 =2Eaddr_len =3D addr_len };</span><br><span> </span><br><s=
pan>     /* interface name is required */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    strncpynt(dns=2Eiface=2Ename, tt-&gt;actual_name, s=
izeof(dns=2Eiface=2Ename));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    strlcpy(dns=2Eiface=2Ename, tt-&gt;actual_name, sizeof(dns=2Eif=
ace=2Ename));</span><br><span> </span><br><span>     if (addr_len &gt; _cou=
ntof(dns=2Eaddr))</span><br><span>     {</span><br><span>@@ -324,7 +324,7 @=
@</span><br><span>                                 =2Eaddr_len =3D addr_len=
 };</span><br><span> </span><br><span>     /* interface name is required */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(wins=2E=
iface=2Ename, tt-&gt;actual_name, sizeof(wins=2Eiface=2Ename));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    strlcpy(wins=2Eiface=2Ename=
, tt-&gt;actual_name, sizeof(wins=2Eiface=2Ename));</span><br><span> </span=
><br><span>     if (addr_len &gt; _countof(wins=2Eaddr))</span><br><span>  =
   {</span><br><span>@@ -372,7 +372,7 @@</span><br><span>                  =
                 =2Eiface =3D { =2Eindex =3D tt-&gt;adapter_index },</span>=
<br><span>                                   =2Emtu =3D mtu,</span><br><spa=
n>                                   =2Efamily =3D family };</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(mtu_msg=2Eiface=2Ename=
, tt-&gt;actual_name, sizeof(mtu_msg=2Eiface=2Ename));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    strlcpy(mtu_msg=2Eiface=2Ename, tt-&=
gt;actual_name, sizeof(mtu_msg=2Eiface=2Ename));</span><br><span>     if (f=
amily =3D=3D AF_INET6 &amp;&amp; mtu &lt; 1280)</span><br><span>     {</spa=
n><br><span>         msg(M_INFO,</span><br><span>@@ -2119,7 +2119,7 @@</spa=
n><br><span>          */</span><br><span>         if (strcmp(dev, &quot;tun=
&quot;) &amp;&amp; strcmp(dev, &quot;tap&quot;))</span><br><span>         {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            strncpynt=
(ifr=2Eifr_name, dev, IFNAMSIZ);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            strlcpy(ifr=2Eifr_name, dev, IFNAMSIZ);</span><br>=
<span>         }</span><br><span> </span><br><span>         /*</span><br><s=
pan>@@ -2145,7 +2145,7 @@</span><br><span>             if ((ctl_fd =3D sock=
et(AF_INET, SOCK_DGRAM, 0)) &gt;=3D 0)</span><br><span>             {</span=
><br><span>                 CLEAR(netifr);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                strncpynt(netifr=2Eifr_name, ifr=2Eifr=
_name, IFNAMSIZ);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              strlcpy(netifr=2Eifr_name, ifr=2Eifr_name, IFNAMSIZ);</span><=
br><span>                 netifr=2Eifr_qlen =3D tt-&gt;options=2Etxqueuelen=
;</span><br><span>                 if (ioctl(ctl_fd, SIOCSIFTXQLEN, (void *=
)&amp;netifr) &gt;=3D 0)</span><br><span>                 {</span><br><span=
>@@ -2401,7 +2401,7 @@</span><br><span>         {</span><br><span>         =
    msg(M_ERR, &quot;Can&#39;t get flags&quot;);</span><br><span>         }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(ifr=
=2Elifr_name, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(ifr=2Elifr_name, tt=
-&gt;actual_name, sizeof(ifr=2Elifr_name));</span><br><span>         ifr=2E=
lifr_ppa =3D ppa;</span><br><span>         /* Assign ppa according to the u=
nit number returned by tun device */</span><br><span>         if (ioctl(if_=
fd, SIOCSLIFNAME, &amp;ifr) &lt; 0)</span><br><span>@@ -2469,7 +2469,7 @@</=
span><br><span>     }</span><br><span> </span><br><span>     CLEAR(ifr);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(ifr=2Elifr=
_name, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    strlcpy(ifr=2Elifr_name, tt-&gt;actua=
l_name, sizeof(ifr=2Elifr_name));</span><br><span>     ifr=2Elifr_ip_muxid =
=3D ip_muxid;</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TAP)</sp=
an><br><span>     {</span><br><span>@@ -2510,7 +2510,7 @@</span><br><span> =
    {</span><br><span>         struct lifreq ifr;</span><br><span>         =
CLEAR(ifr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        st=
rncpynt(ifr=2Elifr_name, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(ifr=2Eli=
fr_name, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));</span><br><span> </s=
pan><br><span>         if (ioctl(tt-&gt;ip_fd, SIOCGLIFFLAGS, &amp;ifr) &lt=
; 0)</span><br><span>         {</span><br><span>diff --git a/src/openvpn/xk=
ey_helper=2Ec b/src/openvpn/xkey_helper=2Ec</span><br><span>index 69be67a=
=2E=2E1149c7b 100644</span><br><span>--- a/src/openvpn/xkey_helper=2Ec</spa=
n><br><span>+++ b/src/openvpn/xkey_helper=2Ec</span><br><span>@@ -198,7 +19=
8,7 @@</span><br><span>     {</span><br><span>         if (!strcmp(alg=2Eop=
, &quot;Sign&quot;))</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            strncpynt(alg_str, &quot;ECDSA&quot;,=
 sizeof(alg_str));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           strlcpy(alg_str, &quot;ECDSA&quot;, sizeof(alg_str));</span><br>=
<span>         }</span><br><span>         else</span><br><span>         {</=
span><br><span>@@ -207,7 +207,7 @@</span><br><span>     }</span><br><span> =
    else if (!strcmp(alg=2Ekeytype, &quot;ED448&quot;) || !strcmp(alg=2Ekey=
type, &quot;ED25519&quot;))</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        strncpynt(alg_str, alg=2Ekeytype, size=
of(alg_str));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  strlcpy(alg_str, alg=2Ekeytype, sizeof(alg_str));</span><br><span>     }<=
/span><br><span>     /* else assume RSA key */</span><br><span>     else if=
 (!strcmp(alg=2Epadmode, &quot;pkcs1&quot;) &amp;&amp; (flags &amp; MF_EXTE=
RNAL_KEY_PKCS1PAD))</span><br><span>@@ -221,7 +221,7 @@</span><br><span>   =
          }</span><br><span>             tbs =3D enc;</span><br><span>     =
        tbslen =3D enc_len;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            strncpynt(alg_str, &quot;RSA_PKCS1_PADDING&quot;, sizeof(=
alg_str));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   strlcpy(alg_str, &quot;RSA_PKCS1_PADDING&quot;, sizeof(alg_str));</span>=
<br><span>         }</span><br><span>         /* For undigested message, ad=
d hashalg=3Ddigest parameter */</span><br><span>         else</span><br><sp=
an>@@ -232,7 +232,7 @@</span><br><span>     else if (!strcmp(alg=2Epadmode,=
 &quot;none&quot;) &amp;&amp; (flags &amp; MF_EXTERNAL_KEY_NOPADDING)</span=
><br><span>              &amp;&amp; !strcmp(alg=2Eop, &quot;Sign&quot;)) /*=
 NO_PADDING requires digested data */</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(alg_str, &quot;RSA=
_NO_PADDING&quot;, sizeof(alg_str));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        strlcpy(alg_str, &quot;RSA_NO_PADDING&quot;, sizeo=
f(alg_str));</span><br><span>     }</span><br><span>     else if (!strcmp(a=
lg=2Epadmode, &quot;pss&quot;) &amp;&amp; (flags &amp; MF_EXTERNAL_KEY_PSSP=
AD))</span><br><span>     {</span><br><span>diff --git a/src/openvpnserv/in=
teractive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 9a68b=
bb=2E=2Ee0fb976 100644</span><br><span>--- a/src/openvpnserv/interactive=2E=
c</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ =
-1810,7 +1810,7 @@</span><br><span>             wide_domains =3D NULL;</spa=
n><br><span>             goto out;</span><br><span>         }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        strncpy(undo_data-&gt;itf_n=
ame, itf_name, sizeof(undo_data-&gt;itf_name));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        strlcpy(undo_data-&gt;itf_name, itf_nam=
e, sizeof(undo_data-&gt;itf_name));</span><br><span>         undo_data-&gt;=
domains =3D wide_domains;</span><br><span> </span><br><span>         if (Ad=
dDnsSearchDomains(list_key, have_list, wide_domains) =3D=3D FALSE</span><br=
><span>diff --git a/tests/unit_tests/openvpn/test_auth_token=2Ec b/tests/un=
it_tests/openvpn/test_auth_token=2Ec</span><br><span>index 89c418e=2E=2E3a3=
bfb4 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_auth_token=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_auth_token=2Ec</sp=
an><br><span>@@ -273,7 +273,7 @@</span><br><span>     }</span><br><span>   =
  else if (streq(name, &quot;session_id&quot;))</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(last_ses=
sion_id_value, value, sizeof(last_session_id_value));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        strlcpy(last_session_id_value, va=
lue, sizeof(last_session_id_value));</span><br><span>     }</span><br><span=
> }</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_pkcs11=2Ec b/tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span=
>index a54c504=2E=2E3351eac 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_pkcs11=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
pkcs11=2Ec</span><br><span>@@ -164,7 +164,7 @@</span><br><span>     if (!st=
rcmp(prefix, &quot;pkcs11-id-request&quot;) &amp;&amp; flags &amp; GET_USER=
_PASS_NEED_STR)</span><br><span>     {</span><br><span>         assert_true=
(pkcs11_id_management);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        strncpynt(up-&gt;password, pkcs11_id_current, sizeof(up-&gt;passw=
ord));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlc=
py(up-&gt;password, pkcs11_id_current, sizeof(up-&gt;password));</span><br>=
<span>     }</span><br><span>     else if (flags &amp; GET_USER_PASS_PASSWO=
RD_ONLY)</span><br><span>     {</span><br><span>diff --git a/tests/unit_tes=
ts/openvpn/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec=
</span><br><span>index 5ad4730=2E=2Ed1b4c97 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>+++ b/tests/unit_=
tests/openvpn/test_user_pass=2Ec</span><br><span>@@ -53,7 +53,7 @@</span><b=
r><span>     for (int i =3D 0; i &lt; QUERY_USER_NUMSLOTS &amp;&amp; query_=
user[i]=2Eresponse !=3D NULL; i++)</span><br><span>     {</span><br><span> =
        check_expected_ptr(query_user[i]=2Eprompt);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        strncpynt(query_user[i]=2Eresponse,=
 mock_ptr_type(char *), query_user[i]=2Eresponse_len);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        strlcpy(query_user[i]=2Eresponse=
, mock_ptr_type(char *), query_user[i]=2Eresponse_len);</span><br><span>   =
  }</span><br><span> </span><br><span>     return mock();</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1995=
?usp=3Demail">change 1995</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1995?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchang=
e </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: Ib1b4a9544e09506e95001609262269ab8154241e </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1995 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--D11OG24K0Vw=--


--===============4928830719371018653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4928830719371018653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4928830719371018653==--

