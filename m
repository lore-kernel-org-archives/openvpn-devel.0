Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0802FCCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SuMMdEzK+9qrPgR7GZSSezdEXSMXgGeEWRy3IMMmohc=; b=m01ge5VcPBMjfuj4RPtGMyYTiU
	Y4UtIhxmQlye4ZXCBU7zdVpeI+4DpL1/ICYRmuUQbzq0f41ka8RWI1zDoHfOthEqvkfu7kRbi1CdG
	+cvHKdJDoNzqva/1ntT4Smj7GrmKIeIeBBasBkRVGndmbQ7+rjusn2Stej6gAisNEt6g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIQVQ-0003GU-5s;
	Sun, 18 Oct 2026 13:00:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIQVO-0003GN-N3
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:00:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0PgYHyoUGgJ6ekTpfVLS0iEwFlh9lIwOuQDCyS3tB/w=; b=FCKLcZ36WB5fDZRXoRSUrLdQl9
 WCFfaAxIVQalX6HZKm1XKCOwESte4ltO1DvQwWTqH3UKDzvMHchi/Eekl7CUQrMibq4bXW0SYfWgq
 iDkhFEcUjJ3HSgwNgKQ/ORsNuTXgAmCsx57gRncMtUQUYXENGE8+RQ/o1egAd/05YKkY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0PgYHyoUGgJ6ekTpfVLS0iEwFlh9lIwOuQDCyS3tB/w=; b=E
 ho8QIPy7UzraBP5ITXGNdrNvkdOyJ6XbcjH2yQZSDqdvoP2iqiJDcbZXPOerUYgFjBo5IwPwqVfeM
 VO2wBbMtoX6grnjww+Zfrq9AIdMnJRJDPpZWpW+TMFHDTapB25ScL1TOoSybQDS58oCmjVlpCkPO1
 jLgbntmlwunwdsaQ=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIQVH-0006Ti-OM for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:00:48 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso1028872f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 06:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792328437; x=1792933237; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0PgYHyoUGgJ6ekTpfVLS0iEwFlh9lIwOuQDCyS3tB/w=;
 b=dADyMqCxdbzqIdl9ai7q6e0Yfcl5exJMjMuBKoranNynPryCc8p8bwb2fSsecUtjva
 0xtD49MEKbdf/b8WrSzF3QkWZbPKtQT/tTwVJQjiOVhX+WBOvJ+RmvvO/F/PGUb2gScg
 +ZSLvrFk9MqOP64G67Pfp3s/zZXlqCjZkWqSbN3v4lltJ9+OwmZfqYisZB3erSapWozk
 thsELCmML4fcDFpSUHvj8iTagVtWMXvI3ZSbOKMeOi2+59PjLNE9krm4srmwyHie/38X
 8kFWeV43VmK2RwOH2drioryci3vL14VoskhWE7yiBJDZ2jE3FH87n3cBe7ZCNN+vcbfL
 VFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792328437; x=1792933237;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0PgYHyoUGgJ6ekTpfVLS0iEwFlh9lIwOuQDCyS3tB/w=;
 b=RTJdzA0EiaFtNMfFQ3D0Xmn70sIt0W5RS5uLTG1Wsg/1NSFFMmnH+cO4byBaGD2o81
 XO6v9jwR5nWV+MdRDkATPZkx802S80dolE4YGd3JM00kSjOukjcMWuXv2e3IJpjwTF3Q
 hofiQXmcrIofJVTYonpYriekGIE/n3JkcNK54kyJTkj87N4AOfsN+wBqaQ4MHWH8aPiO
 WGsxfsooM5HlNsCGQsugjx5PO7nAnFIrx5cy+yKBb4djjkxev6L+F/6/ZkaD+PfjKiw2
 jhy3H1yR90Fv0ysUfuhmI+qExKyNp0yp4YeYYWBqGkjE3MXbp91hml+4Sd/FU/OfhSdV
 6G5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsIlR5Kk4Q4J4LodoEcuK2bKnm7iij69YgM1AuWeZShFcXqIyEoIV/aSsK/+ZucIot2CO6OiVaY8P9QLMi@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIXLapW804sl+1WSpa5AhSXsNMbiEV4VVNXS4YYHmH6NnexFYDB
 MEeEIVYMAmQie1zLNOI+tCVWLDqVHT8TooRLOsPUZPvvkoa1G38jESveHT+kxpJJXVjw7jn4K8N
 DmU4Asrt/Cu66O3PwHeGvUMXdsSHkJRx1pZwdCzIU21cyU3o1exoyoEX09Pp/MPrYoGxj
X-Gm-Gg: AYBFou0Pc4roCA7JZb+OgcIwbcHjkpBQ5uC/3B/CFJBCXqa9shSKqR3eD2fQO7HobS/
 3dcLxNt2njIGPqwZoVifib0cWzIejC36qdqDpD7My1HGL011p01DVh4n6vhzXEwiSQ5w7UNr+qO
 tEsQfCvegVeYJXZtWzflDQmNDxR316kc19fKUiOtFR56Wzjx5BZCM1Z41wsW9AxWKUprOx1gGox
 bHrA2Obxf4UP4PSrGVPU94PsRL5vV+mmWnTPngC+J8II/UXEhfLCG0cRkmOfFwOtprJwu2GwgyI
 PxXnoSl2y0Fvk7Nel3cNPG1YU0wMHLhQBbP+ikxpnu2v9RCJhhML1y097pY6YEh1wODEV61tsmR
 +DZB7lw9uoi7y0PZQmy1a1f99GXzn7JD0UaMXxH+Yx7I5q2s05ZF+oZQM4yAH+0GKH3gIjKAlcn
 gNiOiKBqU89wNdSut4lAoVL37z1HcIdQV+sNq85ef7pJ2Vbp7MBkuI3ELf0DWXE1Dw6mbvjbbUP
 CFBYSZViyVFRK8dxlv3sxc3XluCg0anELkAbCnFiqNSB28kvJytXC3aKI0UqBl3EhdmBINECvGn
 g7ecwLIukJtGMl1Z0gE6VX+he7UWwoVdjdtP558r/jTqTZRMWCYxjU/ncEuT
X-Received: by 2002:a05:600c:3155:b0:4a0:251f:a726 with SMTP id
 5b1f17b1804b1-4a1d760dce9mr120994495e9.24.1792328436590; 
 Sun, 18 Oct 2026 06:00:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1dc952d63sm138605435e9.2.2026.10.18.06.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:00:36 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 13:00:35 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib1b4a9544e09506e95001609262269ab8154241e
X-Gerrit-Change-Number: 1995
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1995?usp=email>
X-Gerrit-Commit: 670cc976b2cd497983fdb584a20bd8d1942fadfd
In-Reply-To: <gerrit.1791901394000.Ib1b4a9544e09506e95001609262269ab8154241e@gerrit.openvpn.net>
References: <gerrit.1791901394000.Ib1b4a9544e09506e95001609262269ab8154241e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkliMWI0YTk1NDRlMDk1MDZlOTUwMDE2MDkyNjIyNjlhYjgxNTQyNDFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9ae72788d01fa38328eada979a07c2ee2a635a08-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIQVH-0006Ti-OM
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0570313965553177079=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0570313965553177079==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BlrETPExRXc="; charset=UTF-8

--BlrETPExRXc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1995?usp=3Demail )

Change subject: Replace strncpynt with strl=
cpy
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace=
 strncpynt with strlcpy

Mostly a straight-forward replacement=2E But in a =
few
places I used the additional return code from strlcpy
instead of duplic=
ating the strlen call=2E

Change-Id: Ib1b4a9544e09506e95001609262269ab81542=
41e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1995
Message-Id: <20261017165735=2E14540-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg39944=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/auth_token=2Ec
M src/openvpn/buffer=2Ec
M sr=
c/openvpn/buffer=2Eh
M src/openvpn/dns=2Ec
M src/openvpn/init=2Ec
M src/ope=
nvpn/manage=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/multi=2Ec
M src/openvp=
n/networking_sitnl=2Ec
M src/openvpn/openssl_compat=2Eh
M src/openvpn/optio=
ns_string=2Ec
M src/openvpn/pkcs11=2Ec
M src/openvpn/route=2Ec
M src/openvp=
n/socket=2Ec
M src/openvpn/socks=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ss=
l_openssl=2Ec
M src/openvpn/ssl_verify=2Ec
M src/openvpn/ssl_verify_openssl=
=2Ec
M src/openvpn/tun=2Ec
M src/openvpn/xkey_helper=2Ec
M tests/unit_tests=
/openvpn/test_auth_token=2Ec
M tests/unit_tests/openvpn/test_pkcs11=2Ec
M t=
ests/unit_tests/openvpn/test_user_pass=2Ec
24 files changed, 63 insertions(=
+), 86 deletions(-)




diff --git a/src/openvpn/auth_token=2Ec b/src/openv=
pn/auth_token=2Ec
index b457b6f=2E=2E969f37f 100644
--- a/src/openvpn/auth_=
token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -464,7 +464,7 @@
 
     struc=
t user_pass up;
     CLEAR(up);
-    strncpynt(up=2Eusername, multi->locked=
_username, sizeof(up=2Eusername));
+    strlcpy(up=2Eusername, multi->locke=
d_username, sizeof(up=2Eusername));
 
     generate_auth_token(&up, multi);=

 
diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index a90dd=
ae=2E=2Ecc1b300 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffe=
r=2Ec
@@ -257,9 +257,8 @@
     int cap =3D buf_forward_capacity(buf);
     =
if (cap > 0)
     {
-        strncpynt((char *)ptr, str, cap);
-        *(b=
uf->data + buf->capacity - 1) =3D 0; /* windows vsnprintf needs this */
-  =
      buf->len +=3D (int)strlen((char *)ptr);
+        int str_len =3D (int=
)strlcpy((char *)ptr, str, cap);
+        buf->len +=3D (str_len < cap) ? s=
tr_len : cap - 1;
         ret =3D true;
     }
     return ret;
diff --git=
 a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 063a2d4=2E=2E74e16=
6c 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -696=
,27 +696,6 @@
 }
 
 /**
- * Like \c strncpy() but always null-terminates th=
e destination=2E
- *
- * Copies at most \c maxlen - 1 characters from \c sr=
c into \c dest and
- * writes a null terminator at \c dest[\c maxlen - 1]=
=2E  Does nothing if
- * \c maxlen is zero=2E
- *
- * @param dest    Destin=
ation buffer=2E
- * @param src     Source string=2E
- * @param maxlen  Size=
 of the destination buffer in bytes=2E
- */
-static inline void
-strncpynt(=
char *dest, const char *src, size_t maxlen)
-{
-    if (maxlen > 0)
-    {
=
-        strncpy(dest, src, maxlen - 1);
-        dest[maxlen - 1] =3D 0;
-=
    }
-}
-
-/**
  * Return true if the string contains at least one decimal=
 digit=2E
  *
  * @param src   The null-terminated string to scan=2E
diff -=
-git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index 713f41e=2E=2E87c9c5f=
 100644
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -444,7 +444,=
7 @@
         =2Eiface =3D { =2Eindex =3D tt->adapter_index, =2Ename =3D ""=
 },
         =2Eflags =3D server->dnssec =3D=3D DNS_SECURITY_YES ? nrpt_dns=
sec : 0,
     };
-    strncpynt(nrpt=2Eiface=2Ename, tt->actual_name, sizeo=
f(nrpt=2Eiface=2Ename));
+    strlcpy(nrpt=2Eiface=2Ename, tt->actual_name,=
 sizeof(nrpt=2Eiface=2Ename));
 
     for (size_t i =3D 0; i < NRPT_ADDR_NU=
M; ++i)
     {
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
ind=
ex 3c2ebf9=2E=2Ed8fd844 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn=
/init=2Ec
@@ -393,8 +393,8 @@
                     ALLOC_OBJ_CLEAR_GC(rhs, =
struct remote_host_store, &c->options=2Egc);
                     c->option=
s=2Erh_store =3D rhs;
                 }
-                strncpynt(rhs->ho=
st, p[2], RH_HOST_LEN);
-                strncpynt(rhs->port, p[3], RH_PORT=
_LEN);
+                strlcpy(rhs->host, p[2], RH_HOST_LEN);
+           =
     strlcpy(rhs->port, p[3], RH_PORT_LEN);
 
                 ce->remote =
=3D rhs->host;
                 ce->remote_port =3D rhs->port;
diff --git a=
/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index e15d7bd=2E=2E007dd2a=
 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -784,7=
 +784,7 @@
         ASSERT(man->connection=2Eup_query_type);
         if (s=
treq(man->connection=2Eup_query_type, type))
         {
-            strncp=
ynt(dest, string, len);
+            strlcpy(dest, string, len);
          =
   man_up_finalize(man);
             msg(M_CLIENT, "SUCCESS: '%s' %s enter=
ed, but not yet verified", type, prompt);
         }
@@ -2374,7 +2374,7 @@
=
     }
     struct user_pass up;
     CLEAR(up);
-    strncpynt(up=2Euserna=
me, msg, sizeof(up=2Eusername));
+    strlcpy(up=2Eusername, msg, sizeof(up=
=2Eusername));
 
     management_query_user_pass(management, &up, command, =
GET_USER_PASS_NEED_OK, (void *)0);
     return strcmp("ok", up=2Epassword) =
=3D=3D 0;
diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec
index 0e=
4669a=2E=2Ea75bd8f 100644
--- a/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=
=2Ec
@@ -303,7 +303,7 @@
 
                 if (password_buf[0])
          =
       {
-                    strncpynt(up->password, password_buf, USER_PA=
SS_LEN);
+                    strlcpy(up->password, password_buf, USER_PASS=
_LEN);
                 }
                 else
                 {
@@ -364,=
7 +364,7 @@
                     {
                         msg(M_FATAL, "E=
RROR: could not read challenge response from stdin");
                     =
}
-                    strncpynt(up->username, ac->user, USER_PASS_LEN);
+ =
                   strlcpy(up->username, ac->user, USER_PASS_LEN);
        =
             buf_printf(&packed_resp, "CRV1::%s::%s", ac->state_id, respons=
e);
                 }
                 else
@@ -452,7 +452,7 @@
         /=
* Use tag for blank password if we are not prompting for one */
         if=
 (flags & GET_USER_PASS_USERNAME_ONLY)
         {
-            strncpynt(up=
->password, blank_up, sizeof(up->password));
+            strlcpy(up->passw=
ord, blank_up, sizeof(up->password));
         }
 
         string_mod(up->=
username, CC_PRINT, CC_CRLF, 0);
@@ -504,7 +504,7 @@
     if (strlen(token)=
)
     {
         unprotect_user_pass(tk);
-        strncpynt(tk->password,=
 token, USER_PASS_LEN);
+        strlcpy(tk->password, token, USER_PASS_LEN=
);
         tk->token_defined =3D true;
 
         /*
diff --git a/src/open=
vpn/multi=2Ec b/src/openvpn/multi=2Ec
index a2cfdbf=2E=2Ee302a81 100644
---=
 a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -461,7 +461,7 @@
  =
   const char *prefix =3D multi_instance_string(mi, true, &gc);
     if (pr=
efix)
     {
-        strncpynt(mi->msg_prefix, prefix, sizeof(mi->msg_pref=
ix));
+        strlcpy(mi->msg_prefix, prefix, sizeof(mi->msg_prefix));
   =
  }
     else
     {
@@ -2657,7 +2657,7 @@
         {
             struct u=
ser_pass up;
             CLEAR(up);
-            strncpynt(up=2Eusername, =
multi->locked_username, sizeof(up=2Eusername));
+            strlcpy(up=2Eu=
sername, multi->locked_username, sizeof(up=2Eusername));
 
             gen=
erate_auth_token(&up, multi);
         }
diff --git a/src/openvpn/networkin=
g_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index f9596a5=2E=2Ebbdfcb7 1=
00644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_s=
itnl=2Ec
@@ -602,7 +602,7 @@
 
     /* save result in output variables */
 =
    memcpy(best_gw, &res=2Egw, res=2Eaddr_size);
-    strncpynt(best_iface,=
 res=2Eiface, IFNAMSIZ);
+    strlcpy(best_iface, res=2Eiface, IFNAMSIZ);
 =
err:
     return ret;
 }
@@ -1424,7 +1424,7 @@
             return -ENOENT;=

         }
 
-        strncpynt(type, RTA_DATA(tb_link[IFLA_INFO_KIND]), I=
FACE_TYPE_LEN_MAX);
+        strlcpy(type, RTA_DATA(tb_link[IFLA_INFO_KIND]=
), IFACE_TYPE_LEN_MAX);
     }
 
     return 0;
diff --git a/src/openvpn/op=
enssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh
index 1a934db=2E=2E4305fe=
a 100644
--- a/src/openvpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_com=
pat=2Eh
@@ -104,10 +104,10 @@
         curve =3D "(error fetching curve nam=
e)";
     }
 
-    strncpynt(gname, curve, gname_sz);
+    strlcpy(gname, c=
urve, gname_sz);
 
-    /* strncpynt ensures null termination so just strle=
n is fine here */
-    *gname_len =3D strlen(curve);
+    /* strlcpy ensure=
s null termination so just strlen is fine here */
+    *gname_len =3D strle=
n(gname);
     return 1;
 }
 #endif /* if OPENSSL_VERSION_NUMBER < 0x300000=
00L && !defined(OPENSSL_NO_EC) */
diff --git a/src/openvpn/options_string=
=2Ec b/src/openvpn/options_string=2Ec
index 88ab798=2E=2Ecfc0595 100644
---=
 a/src/openvpn/options_string=2Ec
+++ b/src/openvpn/options_string=2Ec
@@ -=
385,9 +385,9 @@
 const char *
 options_string_version(const char *s, struct=
 gc_arena *gc)
 {
-    struct buffer out =3D alloc_buf_gc(4, gc);
-    strn=
cpynt((char *)BPTR(&out), s, 3);
-    return BSTR(&out);
+    char *out =3D=
 gc_malloc(3, false, gc);
+    strlcpy(out, s, 3);
+    return out;
 }
 
 #=
if defined(__GNUC__) || defined(__clang__)
diff --git a/src/openvpn/pkcs11=
=2Ec b/src/openvpn/pkcs11=2Ec
index d7dee97=2E=2E09c8996 100644
--- a/src/o=
penvpn/pkcs11=2Ec
+++ b/src/openvpn/pkcs11=2Ec
@@ -224,7 +224,7 @@
     }
 =
    else
     {
-        strncpynt(pin, token_pass=2Epassword, pin_max);
+ =
       strlcpy(pin, token_pass=2Epassword, pin_max);
         purge_user_pa=
ss(&token_pass, true);
 
         if (strlen(pin) =3D=3D 0)
diff --git a/sr=
c/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 9c80f3b=2E=2E8e93404 1006=
44
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -2970,7 +2970=
,7 @@
 
     if (msg=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)
    =
 {
-        strncpynt(msg=2Eiface=2Ename, tt->actual_name, sizeof(msg=2Eifa=
ce=2Ename));
+        strlcpy(msg=2Eiface=2Ename, tt->actual_name, sizeof(m=
sg=2Eiface=2Ename));
     }
 
     status =3D do_route_service(add, &msg, s=
izeof(msg), tt->options=2Emsg_channel);
@@ -3139,7 +3139,7 @@
             =
    addr =3D ntohl(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr=2Es_add=
r);
 
                 /* get interface name */
-                strncpynt(=
ifreq=2Eifr_name, ifr->ifr_name, sizeof(ifreq=2Eifr_name));
+              =
  strlcpy(ifreq=2Eifr_name, ifr->ifr_name, sizeof(ifreq=2Eifr_name));
 
   =
              /* check that the interface is up */
                 if (ioc=
tl(sd, SIOCGIFFLAGS, &ifreq) < 0)
@@ -3192,7 +3192,7 @@
                 }
=
 
                 /* save iface name */
-                strncpynt(rgi->if=
ace, ifreq=2Eifr_name, sizeof(rgi->iface));
+                strlcpy(rgi->i=
face, ifreq=2Eifr_name, sizeof(rgi->iface));
                 rgi->flags |=
=3D RGI_IFACE_DEFINED;
 
                 /* now get the hardware address=
=2E */
@@ -3460,7 +3460,7 @@
 
         CLEAR(ifr);
         ifr=2Eifr_addr=
=2Esa_family =3D AF_INET;
-        strncpynt(ifr=2Eifr_name, rgi->iface, IF=
NAMSIZ);
+        strlcpy(ifr=2Eifr_name, rgi->iface, IFNAMSIZ);
 
        =
 if (ioctl(sockfd, SIOCGIFNETMASK, (char *)&ifr) < 0)
         {
@@ -3489,7=
 +3489,7 @@
         struct ifreq ifreq =3D { 0 };
 
         /* now get th=
e hardware address=2E */
-        strncpynt(ifreq=2Eifr_name, rgi->iface, s=
izeof(ifreq=2Eifr_name));
+        strlcpy(ifreq=2Eifr_name, rgi->iface, si=
zeof(ifreq=2Eifr_name));
         if (ioctl(sockfd, SIOCGIFHWADDR, &ifreq) =
< 0)
         {
             msg(M_WARN, "GDG: SIOCGIFHWADDR(%s) failed", i=
freq=2Eifr_name);
@@ -3748,7 +3748,7 @@
         {
             rgi->gatewa=
y=2Eaddr =3D ntohl(((struct sockaddr_in *)route=2Egateway)->sin_addr=2Es_ad=
dr);
             rgi->flags =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
-   =
         strncpynt(rgi->iface, interface->ifr_name, sizeof(rgi->iface));
+ =
           strlcpy(rgi->iface, interface->ifr_name, sizeof(rgi->iface));
  =
       }
 
         int32 address_size =3D 0;
diff --git a/src/openvpn/sock=
et=2Ec b/src/openvpn/socket=2Ec
index df8e400=2E=2Ef516a14 100644
--- a/src=
/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -3077,7 +3077,7 @@
 soc=
kaddr_unix_init(struct sockaddr_un *local, const char *path)
 {
     local-=
>sun_family =3D PF_UNIX;
-    strncpynt(local->sun_path, path, sizeof(local=
->sun_path));
+    strlcpy(local->sun_path, path, sizeof(local->sun_path));=

 }
 
 void
diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec
inde=
x 0296349=2E=2Ecab9af6 100644
--- a/src/openvpn/socks=2Ec
+++ b/src/openvpn=
/socks=2Ec
@@ -58,12 +58,12 @@
     ASSERT(server);
     ASSERT(port);
 
- =
   strncpynt(p->server, server, sizeof(p->server));
+    strlcpy(p->server,=
 server, sizeof(p->server));
     p->port =3D port;
 
     if (authfile)
  =
   {
-        strncpynt(p->authfile, authfile, sizeof(p->authfile));
+     =
   strlcpy(p->authfile, authfile, sizeof(p->authfile));
     }
     else
  =
   {
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 3594871=
=2E=2E49a9cb6 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@=
 -272,7 +272,7 @@
         /* prompt for password even if --askpass wasn't =
specified */
         pem_password_setup(NULL);
         ASSERT(!passbuf=2E=
protected);
-        strncpynt(buf, passbuf=2Epassword, (size_t)size);
+   =
     strlcpy(buf, passbuf=2Epassword, (size_t)size);
         purge_user_pa=
ss(&passbuf, false);
 
         return (int)strlen(buf);
@@ -2230,7 +2230,7=
 @@
         if (session->opt->pull && up !=3D &auth_token)
         {
    =
         unprotect_user_pass(&auth_token);
-            strncpynt(auth_toke=
n=2Eusername, up->username, USER_PASS_LEN);
+            strlcpy(auth_token=
=2Eusername, up->username, USER_PASS_LEN);
             protect_user_pass(&=
auth_token);
         }
         protect_user_pass(up);
diff --git a/src/op=
envpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index e0f34cd=2E=2Efe2b=
fda 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=
=2Ec
@@ -427,15 +427,14 @@
      * historically used names with - in them=
=2E Silently convert names
      * with - to names with _ to support both
 =
     */
-    if (strlen(ciphers) >=3D (len - 1))
+    size_t ciphers_len =
=3D strlcpy(openssl_ciphers, ciphers, len);
+    if (ciphers_len >=3D len)
=
     {
-        msg(M_FATAL, "Failed to set restricted TLS 1=2E3 cipher lis=
t, too long (>%zd)=2E",
+        msg(M_FATAL, "Failed to set restricted TLS=
 1=2E3 cipher list, too long (>%zu)=2E",
             len - 1);
     }
 
- =
   strncpynt(openssl_ciphers, ciphers, len);
-
-    for (size_t i =3D 0; i =
< strlen(openssl_ciphers); i++)
+    for (size_t i =3D 0; i < ciphers_len; =
i++)
     {
         if (openssl_ciphers[i] =3D=3D '-')
         {
diff --g=
it a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index a744e07=
=2E=2E73e3696 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl=
_verify=2Ec
@@ -1640,7 +1640,7 @@
             "TLS: Replacing client provi=
ded username '%s' with "
             "username from override-user '%s'",
 =
            up->username, multi->locked_username);
-        strncpynt(up->u=
sername, multi->locked_username, sizeof(up->username));
+        strlcpy(up=
->username, multi->locked_username, sizeof(up->username));
     }
 
     /*=

diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_o=
penssl=2Ec
index 6073e4e=2E=2E146a384 100644
--- a/src/openvpn/ssl_verify_o=
penssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -157,14 +157,16 @@
 =
                    if ((ssize_t)strlen(buf) !=3D ASN1_STRING_length(name->=
d=2Erfc822Name))
                     {
                         msg(D_TLS_=
ERRORS, "ASN1 ERROR: string contained terminating zero");
-                =
        OPENSSL_free(buf);
+                    }
+                    else=
 if (strlcpy(out, buf, size) >=3D size)
+                    {
+           =
             msg(D_TLS_ERRORS, "ASN1 ERROR: string too long");
            =
         }
                     else
                     {
-              =
          strncpynt(out, buf, size);
-                        OPENSSL_free(=
buf);
                         retval =3D true;
                     }
+   =
                 OPENSSL_free(buf);
                     break;
 
         =
        default:
@@ -243,9 +245,7 @@
         goto exit;
     }
 
-    strn=
cpynt(out, (char *)buf, size);
-
-    ret =3D (strlen((char *)buf) < size) =
? SUCCESS : FAILURE;
+    ret =3D (strlcpy(out, (char *)buf, size) < size) =
? SUCCESS : FAILURE;
 
 exit:
     OPENSSL_free(buf);
diff --git a/src/open=
vpn/tun=2Ec b/src/openvpn/tun=2Ec
index 2c2766f=2E=2Ea226fc4 100644
--- a/s=
rc/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -127,7 +127,7 @@
 
     if =
(addr=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)
     {
-        str=
ncpynt(addr=2Eiface=2Ename, tt->actual_name, sizeof(addr=2Eiface=2Ename));
=
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
@@ -2121,7 +2121,7 @@
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
@@ -2147,7 +2147,7 @@
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
@@ -2403,7 +2403,7 @@
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
@@ -2471,7 +2471,7 @@
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
@@ -2512,7 +2512,7 @@
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
diff --git a/tests/unit_tests/o=
penvpn/test_auth_token=2Ec b/tests/unit_tests/openvpn/test_auth_token=2Ec
i=
ndex 89c418e=2E=2E3a3bfb4 100644
--- a/tests/unit_tests/openvpn/test_auth_t=
oken=2Ec
+++ b/tests/unit_tests/openvpn/test_auth_token=2Ec
@@ -273,7 +273,=
7 @@
     }
     else if (streq(name, "session_id"))
     {
-        strncp=
ynt(last_session_id_value, value, sizeof(last_session_id_value));
+        =
strlcpy(last_session_id_value, value, sizeof(last_session_id_value));
     =
}
 }
 
diff --git a/tests/unit_tests/openvpn/test_pkcs11=2Ec b/tests/unit_t=
ests/openvpn/test_pkcs11=2Ec
index a54c504=2E=2E3351eac 100644
--- a/tests/=
unit_tests/openvpn/test_pkcs11=2Ec
+++ b/tests/unit_tests/openvpn/test_pkcs=
11=2Ec
@@ -164,7 +164,7 @@
     if (!strcmp(prefix, "pkcs11-id-request") &&=
 flags & GET_USER_PASS_NEED_STR)
     {
         assert_true(pkcs11_id_mana=
gement);
-        strncpynt(up->password, pkcs11_id_current, sizeof(up->pas=
sword));
+        strlcpy(up->password, pkcs11_id_current, sizeof(up->passw=
ord));
     }
     else if (flags & GET_USER_PASS_PASSWORD_ONLY)
     {
dif=
f --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/unit_tests/op=
envpn/test_user_pass=2Ec
index c8c69bf=2E=2Eadcf74a 100644
--- a/tests/unit=
_tests/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests/openvpn/test_user_=
pass=2Ec
@@ -53,7 +53,7 @@
     for (int i =3D 0; i < QUERY_USER_NUMSLOTS &=
& query_user[i]=2Eresponse !=3D NULL; i++)
     {
         check_expected_p=
tr(query_user[i]=2Eprompt);
-        strncpynt(query_user[i]=2Eresponse, mo=
ck_ptr_type(char *), query_user[i]=2Eresponse_len);
+        strlcpy(query_=
user[i]=2Eresponse, mock_ptr_type(char *), query_user[i]=2Eresponse_len);
 =
    }
 
     return mock();

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1995?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: Ib1b4a9544e09506e95001609262269ab8154241e
Gerrit-Change-Number: 199=
5
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--BlrETPExRXc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1995?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Replace strncpynt with strlcpy<br>=
<br>Mostly a straight-forward replacement=2E But in a few<br>places I used =
the additional return code from strlcpy<br>instead of duplicating the strle=
n call=2E<br><br>Change-Id: Ib1b4a9544e09506e95001609262269ab8154241e<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1995<br>Message-Id: &lt;20261017165735=2E14540=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg39944=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/auth_token=
=2Ec<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openv=
pn/dns=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/o=
penvpn/misc=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/networking_sitn=
l=2Ec<br>M src/openvpn/openssl_compat=2Eh<br>M src/openvpn/options_string=
=2Ec<br>M src/openvpn/pkcs11=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvp=
n/socket=2Ec<br>M src/openvpn/socks=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/o=
penvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn/ssl=
_verify_openssl=2Ec<br>M src/openvpn/tun=2Ec<br>M src/openvpn/xkey_helper=
=2Ec<br>M tests/unit_tests/openvpn/test_auth_token=2Ec<br>M tests/unit_test=
s/openvpn/test_pkcs11=2Ec<br>M tests/unit_tests/openvpn/test_user_pass=2Ec<=
br>24 files changed, 63 insertions(+), 86 deletions(-)<br><br></pre>
<pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br=
><span>index b457b6f=2E=2E969f37f 100644</span><br><span>--- a/src/openvpn/=
auth_token=2Ec</span><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><=
span>@@ -464,7 +464,7 @@</span><br><span> </span><br><span>     struct user=
_pass up;</span><br><span>     CLEAR(up);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    strncpynt(up=2Eusername, multi-&gt;locked_username,=
 sizeof(up=2Eusername));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    strlcpy(up=2Eusername, multi-&gt;locked_username, sizeof(up=2Euser=
name));</span><br><span> </span><br><span>     generate_auth_token(&amp;up,=
 multi);</span><br><span> </span><br><span>diff --git a/src/openvpn/buffer=
=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index a90ddae=2E=2Ecc1b300 10=
0644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src=
/openvpn/buffer=2Ec</span><br><span>@@ -257,9 +257,8 @@</span><br><span>   =
  int cap =3D buf_forward_capacity(buf);</span><br><span>     if (cap &gt; =
0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        strncpynt((char *)ptr, str, cap);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        *(buf-&gt;data + buf-&gt;capacity - 1) =3D =
0; /* windows vsnprintf needs this */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        buf-&gt;len +=3D (int)strlen((char *)ptr);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        int str_len =3D (int=
)strlcpy((char *)ptr, str, cap);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        buf-&gt;len +=3D (str_len &lt; cap) ? str_len : cap - =
1;</span><br><span>         ret =3D true;</span><br><span>     }</span><br>=
<span>     return ret;</span><br><span>diff --git a/src/openvpn/buffer=2Eh =
b/src/openvpn/buffer=2Eh</span><br><span>index 063a2d4=2E=2E74e166c 100644<=
/span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/open=
vpn/buffer=2Eh</span><br><span>@@ -696,27 +696,6 @@</span><br><span> }</spa=
n><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * Like \c strncpy() but always null-terminates the destinatio=
n=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * Copies at most \c maxlen - 1 char=
acters from \c src into \c dest and</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * writes a null terminator at \c dest[\c maxlen - 1]=2E  Doe=
s nothing if</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * \c max=
len is zero=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param dest    Destinat=
ion buffer=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @para=
m src     Source string=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * @param maxlen  Size of the destination buffer in bytes=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-strncpynt(char *dest, const char *src, size_t maxlen=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (maxlen &gt; 0)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        strncpy(dest, src, maxlen - 1);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        dest[maxlen - 1] =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span=
><br><span>  * Return true if the string contains at least one decimal digi=
t=2E</span><br><span>  *</span><br><span>  * @param src   The null-terminat=
ed string to scan=2E</span><br><span>diff --git a/src/openvpn/dns=2Ec b/src=
/openvpn/dns=2Ec</span><br><span>index 713f41e=2E=2E87c9c5f 100644</span><b=
r><span>--- a/src/openvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec=
</span><br><span>@@ -444,7 +444,7 @@</span><br><span>         =2Eiface =3D =
{ =2Eindex =3D tt-&gt;adapter_index, =2Ename =3D &quot;&quot; },</span><br>=
<span>         =2Eflags =3D server-&gt;dnssec =3D=3D DNS_SECURITY_YES ? nrp=
t_dnssec : 0,</span><br><span>     };</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    strncpynt(nrpt=2Eiface=2Ename, tt-&gt;actual_name, size=
of(nrpt=2Eiface=2Ename));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    strlcpy(nrpt=2Eiface=2Ename, tt-&gt;actual_name, sizeof(nrpt=2Eif=
ace=2Ename));</span><br><span> </span><br><span>     for (size_t i =3D 0; i=
 &lt; NRPT_ADDR_NUM; ++i)</span><br><span>     {</span><br><span>diff --git=
 a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 3c2ebf=
9=2E=2Ed8fd844 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br>=
<span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -393,8 +393,8 @@</span>=
<br><span>                     ALLOC_OBJ_CLEAR_GC(rhs, struct remote_host_s=
tore, &amp;c-&gt;options=2Egc);</span><br><span>                     c-&gt;=
options=2Erh_store =3D rhs;</span><br><span>                 }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                strncpynt(rhs-&gt;=
host, p[2], RH_HOST_LEN);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                strncpynt(rhs-&gt;port, p[3], RH_PORT_LEN);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                strlcpy(rhs-&gt=
;host, p[2], RH_HOST_LEN);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                strlcpy(rhs-&gt;port, p[3], RH_PORT_LEN);</span><br>=
<span> </span><br><span>                 ce-&gt;remote =3D rhs-&gt;host;</s=
pan><br><span>                 ce-&gt;remote_port =3D rhs-&gt;port;</span><=
br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span=
><br><span>index e15d7bd=2E=2E007dd2a 100644</span><br><span>--- a/src/open=
vpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span=
>@@ -784,7 +784,7 @@</span><br><span>         ASSERT(man-&gt;connection=2Eu=
p_query_type);</span><br><span>         if (streq(man-&gt;connection=2Eup_q=
uery_type, type))</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            strncpynt(dest, string, len);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            strlcpy(dest, stri=
ng, len);</span><br><span>             man_up_finalize(man);</span><br><spa=
n>             msg(M_CLIENT, &quot;SUCCESS: &#39;%s&#39; %s entered, but no=
t yet verified&quot;, type, prompt);</span><br><span>         }</span><br><=
span>@@ -2374,7 +2374,7 @@</span><br><span>     }</span><br><span>     stru=
ct user_pass up;</span><br><span>     CLEAR(up);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    strncpynt(up=2Eusername, msg, sizeof(up=2Eus=
ername));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strlcp=
y(up=2Eusername, msg, sizeof(up=2Eusername));</span><br><span> </span><br><=
span>     management_query_user_pass(management, &amp;up, command, GET_USER=
_PASS_NEED_OK, (void *)0);</span><br><span>     return strcmp(&quot;ok&quot=
;, up=2Epassword) =3D=3D 0;</span><br><span>diff --git a/src/openvpn/misc=
=2Ec b/src/openvpn/misc=2Ec</span><br><span>index 0e4669a=2E=2Ea75bd8f 1006=
44</span><br><span>--- a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/ope=
nvpn/misc=2Ec</span><br><span>@@ -303,7 +303,7 @@</span><br><span> </span><=
br><span>                 if (password_buf[0])</span><br><span>            =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     strncpynt(up-&gt;password, password_buf, USER_PASS_LEN);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    strlcpy(up-&g=
t;password, password_buf, USER_PASS_LEN);</span><br><span>                 =
}</span><br><span>                 else</span><br><span>                 {<=
/span><br><span>@@ -364,7 +364,7 @@</span><br><span>                     {<=
/span><br><span>                         msg(M_FATAL, &quot;ERROR: could no=
t read challenge response from stdin&quot;);</span><br><span>              =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       strncpynt(up-&gt;username, ac-&gt;user, USER_PASS_LEN);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    strlcpy(up-&=
gt;username, ac-&gt;user, USER_PASS_LEN);</span><br><span>                 =
    buf_printf(&amp;packed_resp, &quot;CRV1::%s::%s&quot;, ac-&gt;state_id,=
 response);</span><br><span>                 }</span><br><span>            =
     else</span><br><span>@@ -452,7 +452,7 @@</span><br><span>         /* U=
se tag for blank password if we are not prompting for one */</span><br><spa=
n>         if (flags &amp; GET_USER_PASS_USERNAME_ONLY)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            st=
rncpynt(up-&gt;password, blank_up, sizeof(up-&gt;password));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            strlcpy(up-&gt;passwor=
d, blank_up, sizeof(up-&gt;password));</span><br><span>         }</span><br=
><span> </span><br><span>         string_mod(up-&gt;username, CC_PRINT, CC_=
CRLF, 0);</span><br><span>@@ -504,7 +504,7 @@</span><br><span>     if (strl=
en(token))</span><br><span>     {</span><br><span>         unprotect_user_p=
ass(tk);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strnc=
pynt(tk-&gt;password, token, USER_PASS_LEN);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        strlcpy(tk-&gt;password, token, USER_PASS_=
LEN);</span><br><span>         tk-&gt;token_defined =3D true;</span><br><sp=
an> </span><br><span>         /*</span><br><span>diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec</span><br><span>index a2cfdbf=2E=2Ee302a81=
 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/s=
rc/openvpn/multi=2Ec</span><br><span>@@ -461,7 +461,7 @@</span><br><span>  =
   const char *prefix =3D multi_instance_string(mi, true, &amp;gc);</span><=
br><span>     if (prefix)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        strncpynt(mi-&gt;msg_prefix, prefix, siz=
eof(mi-&gt;msg_prefix));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        strlcpy(mi-&gt;msg_prefix, prefix, sizeof(mi-&gt;msg_prefix));=
</span><br><span>     }</span><br><span>     else</span><br><span>     {</s=
pan><br><span>@@ -2657,7 +2657,7 @@</span><br><span>         {</span><br><s=
pan>             struct user_pass up;</span><br><span>             CLEAR(up=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            strncpy=
nt(up=2Eusername, multi-&gt;locked_username, sizeof(up=2Eusername));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            strlcpy(up=2Eu=
sername, multi-&gt;locked_username, sizeof(up=2Eusername));</span><br><span=
> </span><br><span>             generate_auth_token(&amp;up, multi);</span>=
<br><span>         }</span><br><span>diff --git a/src/openvpn/networking_si=
tnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index f9596a5=2E=
=2Ebbdfcb7 100644</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec</s=
pan><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -60=
2,7 +602,7 @@</span><br><span> </span><br><span>     /* save result in outp=
ut variables */</span><br><span>     memcpy(best_gw, &amp;res=2Egw, res=2Ea=
ddr_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpy=
nt(best_iface, res=2Eiface, IFNAMSIZ);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    strlcpy(best_iface, res=2Eiface, IFNAMSIZ);</span><b=
r><span> err:</span><br><span>     return ret;</span><br><span> }</span><br=
><span>@@ -1424,7 +1424,7 @@</span><br><span>             return -ENOENT;</=
span><br><span>         }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        strncpynt(type, RTA_DATA(tb_link[IFLA_INFO_KI=
ND]), IFACE_TYPE_LEN_MAX);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        strlcpy(type, RTA_DATA(tb_link[IFLA_INFO_KIND]), IFACE_TYPE_=
LEN_MAX);</span><br><span>     }</span><br><span> </span><br><span>     ret=
urn 0;</span><br><span>diff --git a/src/openvpn/openssl_compat=2Eh b/src/op=
envpn/openssl_compat=2Eh</span><br><span>index 1a934db=2E=2E4305fea 100644<=
/span><br><span>--- a/src/openvpn/openssl_compat=2Eh</span><br><span>+++ b/=
src/openvpn/openssl_compat=2Eh</span><br><span>@@ -104,10 +104,10 @@</span>=
<br><span>         curve =3D &quot;(error fetching curve name)&quot;;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    strncpynt(gname, curve, gname_sz);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    strlcpy(gname, curve, gname_sz);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* s=
trncpynt ensures null termination so just strlen is fine here */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    *gname_len =3D strlen(curve)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* strlcpy ens=
ures null termination so just strlen is fine here */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    *gname_len =3D strlen(gname);</span><=
br><span>     return 1;</span><br><span> }</span><br><span> #endif /* if OP=
ENSSL_VERSION_NUMBER &lt; 0x30000000L &amp;&amp; !defined(OPENSSL_NO_EC) */=
</span><br><span>diff --git a/src/openvpn/options_string=2Ec b/src/openvpn/=
options_string=2Ec</span><br><span>index 88ab798=2E=2Ecfc0595 100644</span>=
<br><span>--- a/src/openvpn/options_string=2Ec</span><br><span>+++ b/src/op=
envpn/options_string=2Ec</span><br><span>@@ -385,9 +385,9 @@</span><br><spa=
n> const char *</span><br><span> options_string_version(const char *s, stru=
ct gc_arena *gc)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct buffer out =3D alloc_buf_gc(4, gc);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    strncpynt((char *)BPTR(&amp;out)=
, s, 3);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return BS=
TR(&amp;out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ch=
ar *out =3D gc_malloc(3, false, gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    strlcpy(out, s, 3);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return out;</span><br><span> }</span><br><span> </=
span><br><span> #if defined(__GNUC__) || defined(__clang__)</span><br><span=
>diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec</span><br><sp=
an>index d7dee97=2E=2E09c8996 100644</span><br><span>--- a/src/openvpn/pkcs=
11=2Ec</span><br><span>+++ b/src/openvpn/pkcs11=2Ec</span><br><span>@@ -224=
,7 +224,7 @@</span><br><span>     }</span><br><span>     else</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strn=
cpynt(pin, token_pass=2Epassword, pin_max);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        strlcpy(pin, token_pass=2Epassword, pin_max=
);</span><br><span>         purge_user_pass(&amp;token_pass, true);</span><=
br><span> </span><br><span>         if (strlen(pin) =3D=3D 0)</span><br><sp=
an>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><sp=
an>index 9c80f3b=2E=2E8e93404 100644</span><br><span>--- a/src/openvpn/rout=
e=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -2970,=
7 +2970,7 @@</span><br><span> </span><br><span>     if (msg=2Eiface=2Eindex=
 =3D=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        strncpynt(msg=2Eiface=2Ename, t=
t-&gt;actual_name, sizeof(msg=2Eiface=2Ename));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        strlcpy(msg=2Eiface=2Ename, tt-&gt;actu=
al_name, sizeof(msg=2Eiface=2Ename));</span><br><span>     }</span><br><spa=
n> </span><br><span>     status =3D do_route_service(add, &amp;msg, sizeof(=
msg), tt-&gt;options=2Emsg_channel);</span><br><span>@@ -3139,7 +3139,7 @@<=
/span><br><span>                 addr =3D ntohl(((struct sockaddr_in *)&amp=
;ifr-&gt;ifr_addr)-&gt;sin_addr=2Es_addr);</span><br><span> </span><br><spa=
n>                 /* get interface name */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                strncpynt(ifreq=2Eifr_name, ifr-&gt;i=
fr_name, sizeof(ifreq=2Eifr_name));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                strlcpy(ifreq=2Eifr_name, ifr-&gt;ifr_name,=
 sizeof(ifreq=2Eifr_name));</span><br><span> </span><br><span>             =
    /* check that the interface is up */</span><br><span>                 i=
f (ioctl(sd, SIOCGIFFLAGS, &amp;ifreq) &lt; 0)</span><br><span>@@ -3192,7 +=
3192,7 @@</span><br><span>                 }</span><br><span> </span><br><s=
pan>                 /* save iface name */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                strncpynt(rgi-&gt;iface, ifreq=2Eifr_n=
ame, sizeof(rgi-&gt;iface));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                strlcpy(rgi-&gt;iface, ifreq=2Eifr_name, sizeof(rg=
i-&gt;iface));</span><br><span>                 rgi-&gt;flags |=3D RGI_IFAC=
E_DEFINED;</span><br><span> </span><br><span>                 /* now get th=
e hardware address=2E */</span><br><span>@@ -3460,7 +3460,7 @@</span><br><s=
pan> </span><br><span>         CLEAR(ifr);</span><br><span>         ifr=2Ei=
fr_addr=2Esa_family =3D AF_INET;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        strncpynt(ifr=2Eifr_name, rgi-&gt;iface, IFNAMSIZ);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(ifr=2Eif=
r_name, rgi-&gt;iface, IFNAMSIZ);</span><br><span> </span><br><span>       =
  if (ioctl(sockfd, SIOCGIFNETMASK, (char *)&amp;ifr) &lt; 0)</span><br><sp=
an>         {</span><br><span>@@ -3489,7 +3489,7 @@</span><br><span>       =
  struct ifreq ifreq =3D { 0 };</span><br><span> </span><br><span>         =
/* now get the hardware address=2E */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        strncpynt(ifreq=2Eifr_name, rgi-&gt;iface, sizeof(i=
freq=2Eifr_name));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       strlcpy(ifreq=2Eifr_name, rgi-&gt;iface, sizeof(ifreq=2Eifr_name));<=
/span><br><span>         if (ioctl(sockfd, SIOCGIFHWADDR, &amp;ifreq) &lt; =
0)</span><br><span>         {</span><br><span>             msg(M_WARN, &quo=
t;GDG: SIOCGIFHWADDR(%s) failed&quot;, ifreq=2Eifr_name);</span><br><span>@=
@ -3748,7 +3748,7 @@</span><br><span>         {</span><br><span>           =
  rgi-&gt;gateway=2Eaddr =3D ntohl(((struct sockaddr_in *)route=2Egateway)-=
&gt;sin_addr=2Es_addr);</span><br><span>             rgi-&gt;flags =3D RGI_=
ADDR_DEFINED | RGI_IFACE_DEFINED;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            strncpynt(rgi-&gt;iface, interface-&gt;ifr_name, si=
zeof(rgi-&gt;iface));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            strlcpy(rgi-&gt;iface, interface-&gt;ifr_name, sizeof(rgi-&gt=
;iface));</span><br><span>         }</span><br><span> </span><br><span>    =
     int32 address_size =3D 0;</span><br><span>diff --git a/src/openvpn/soc=
ket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index df8e400=2E=2Ef516a14=
 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/=
src/openvpn/socket=2Ec</span><br><span>@@ -3077,7 +3077,7 @@</span><br><spa=
n> sockaddr_unix_init(struct sockaddr_un *local, const char *path)</span><b=
r><span> {</span><br><span>     local-&gt;sun_family =3D PF_UNIX;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(local-&gt;sun_pat=
h, path, sizeof(local-&gt;sun_path));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    strlcpy(local-&gt;sun_path, path, sizeof(local-&gt;su=
n_path));</span><br><span> }</span><br><span> </span><br><span> void</span>=
<br><span>diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec</span>=
<br><span>index 0296349=2E=2Ecab9af6 100644</span><br><span>--- a/src/openv=
pn/socks=2Ec</span><br><span>+++ b/src/openvpn/socks=2Ec</span><br><span>@@=
 -58,12 +58,12 @@</span><br><span>     ASSERT(server);</span><br><span>    =
 ASSERT(port);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    strncpynt(p-&gt;server, server, sizeof(p-&gt;server));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    strlcpy(p-&gt;server,=
 server, sizeof(p-&gt;server));</span><br><span>     p-&gt;port =3D port;</=
span><br><span> </span><br><span>     if (authfile)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(p-&g=
t;authfile, authfile, sizeof(p-&gt;authfile));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        strlcpy(p-&gt;authfile, authfile, sizeof=
(p-&gt;authfile));</span><br><span>     }</span><br><span>     else</span><=
br><span>     {</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/open=
vpn/ssl=2Ec</span><br><span>index 3594871=2E=2E49a9cb6 100644</span><br><sp=
an>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</spa=
n><br><span>@@ -272,7 +272,7 @@</span><br><span>         /* prompt for pass=
word even if --askpass wasn&#39;t specified */</span><br><span>         pem=
_password_setup(NULL);</span><br><span>         ASSERT(!passbuf=2Eprotected=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(b=
uf, passbuf=2Epassword, (size_t)size);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        strlcpy(buf, passbuf=2Epassword, (size_t)size);<=
/span><br><span>         purge_user_pass(&amp;passbuf, false);</span><br><s=
pan> </span><br><span>         return (int)strlen(buf);</span><br><span>@@ =
-2230,7 +2230,7 @@</span><br><span>         if (session-&gt;opt-&gt;pull &a=
mp;&amp; up !=3D &amp;auth_token)</span><br><span>         {</span><br><spa=
n>             unprotect_user_pass(&amp;auth_token);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            strncpynt(auth_token=2Eusername=
, up-&gt;username, USER_PASS_LEN);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            strlcpy(auth_token=2Eusername, up-&gt;username, =
USER_PASS_LEN);</span><br><span>             protect_user_pass(&amp;auth_to=
ken);</span><br><span>         }</span><br><span>         protect_user_pass=
(up);</span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvp=
n/ssl_openssl=2Ec</span><br><span>index e0f34cd=2E=2Efe2bfda 100644</span><=
br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvp=
n/ssl_openssl=2Ec</span><br><span>@@ -427,15 +427,14 @@</span><br><span>   =
   * historically used names with - in them=2E Silently convert names</span=
><br><span>      * with - to names with _ to support both</span><br><span> =
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (strlen=
(ciphers) &gt;=3D (len - 1))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    size_t ciphers_len =3D strlcpy(openssl_ciphers, ciphers, len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ciphers_len=
 &gt;=3D len)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        msg(M_FATAL, &quot;Failed to set restricted TLS 1=2E=
3 cipher list, too long (&gt;%zd)=2E&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;Failed to set restricted=
 TLS 1=2E3 cipher list, too long (&gt;%zu)=2E&quot;,</span><br><span>      =
       len - 1);</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    strncpynt(openssl_ciphers, ciphers,=
 len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    for (size_t i =3D 0; i &lt; strl=
en(openssl_ciphers); i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (size_t i =3D 0; i &lt; ciphers_len; i++)</span><br><span>   =
  {</span><br><span>         if (openssl_ciphers[i] =3D=3D &#39;-&#39;)</sp=
an><br><span>         {</span><br><span>diff --git a/src/openvpn/ssl_verify=
=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index a744e07=2E=2E73e369=
6 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+=
++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -1640,7 +1640,7 @@</span=
><br><span>             &quot;TLS: Replacing client provided username &#39;=
%s&#39; with &quot;</span><br><span>             &quot;username from overri=
de-user &#39;%s&#39;&quot;,</span><br><span>             up-&gt;username, m=
ulti-&gt;locked_username);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        strncpynt(up-&gt;username, multi-&gt;locked_username, sizeof(u=
p-&gt;username));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      strlcpy(up-&gt;username, multi-&gt;locked_username, sizeof(up-&gt;use=
rname));</span><br><span>     }</span><br><span> </span><br><span>     /*</=
span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvp=
n/ssl_verify_openssl=2Ec</span><br><span>index 6073e4e=2E=2E146a384 100644<=
/span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>++=
+ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@ -157,14 +157,16 @=
@</span><br><span>                     if ((ssize_t)strlen(buf) !=3D ASN1_S=
TRING_length(name-&gt;d=2Erfc822Name))</span><br><span>                    =
 {</span><br><span>                         msg(D_TLS_ERRORS, &quot;ASN1 ER=
ROR: string contained terminating zero&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                        OPENSSL_free(buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    else =
if (strlcpy(out, buf, size) &gt;=3D size)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        msg(D_TLS_ERRORS, &quot;ASN=
1 ERROR: string too long&quot;);</span><br><span>                     }</sp=
an><br><span>                     else</span><br><span>                    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
     strncpynt(out, buf, size);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                        OPENSSL_free(buf);</span><br><span>      =
                   retval =3D true;</span><br><span>                     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
OPENSSL_free(buf);</span><br><span>                     break;</span><br><s=
pan> </span><br><span>                 default:</span><br><span>@@ -243,9 +=
245,7 @@</span><br><span>         goto exit;</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpy=
nt(out, (char *)buf, size);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D (st=
rlen((char *)buf) &lt; size) ? SUCCESS : FAILURE;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ret =3D (strlcpy(out, (char *)buf, size) =
&lt; size) ? SUCCESS : FAILURE;</span><br><span> </span><br><span> exit:</s=
pan><br><span>     OPENSSL_free(buf);</span><br><span>diff --git a/src/open=
vpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 2c2766f=2E=2Ea226fc=
4 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/sr=
c/openvpn/tun=2Ec</span><br><span>@@ -127,7 +127,7 @@</span><br><span> </sp=
an><br><span>     if (addr=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        strncpynt(addr=2Eiface=2Ename, tt-&gt;actual_name, sizeof(addr=
=2Eiface=2Ename));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       strlcpy(addr=2Eiface=2Ename, tt-&gt;actual_name, sizeof(addr=2Eiface=
=2Ename));</span><br><span>     }</span><br><span> </span><br><span>     if=
 (addr=2Efamily =3D=3D AF_INET)</span><br><span>@@ -188,12 +188,12 @@</span=
><br><span>     };</span><br><span> </span><br><span>     /* interface name=
 is required */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
rncpynt(dns=2Eiface=2Ename, tt-&gt;actual_name, sizeof(dns=2Eiface=2Ename))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strlcpy(dns=2E=
iface=2Ename, tt-&gt;actual_name, sizeof(dns=2Eiface=2Ename));</span><br><s=
pan> </span><br><span>     /* only use domain when there are no search doma=
ins */</span><br><span>     if (o-&gt;domain &amp;&amp; !o-&gt;domain_searc=
h_list[0])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        strncpynt(dns=2Edomains, o-&gt;domain, sizeof(dns=2Edom=
ains));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strl=
cpy(dns=2Edomains, o-&gt;domain, sizeof(dns=2Edomains));</span><br><span>  =
   }</span><br><span> </span><br><span>     /* Create a comma separated lis=
t of search domains */</span><br><span>@@ -260,7 +260,7 @@</span><br><span>=
                               =2Eaddr_len =3D addr_len };</span><br><span>=
 </span><br><span>     /* interface name is required */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    strncpynt(dns=2Eiface=2Ename, tt-&gt;=
actual_name, sizeof(dns=2Eiface=2Ename));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    strlcpy(dns=2Eiface=2Ename, tt-&gt;actual_name, s=
izeof(dns=2Eiface=2Ename));</span><br><span> </span><br><span>     if (addr=
_len &gt; _countof(dns=2Eaddr))</span><br><span>     {</span><br><span>@@ -=
324,7 +324,7 @@</span><br><span>                                 =2Eaddr_le=
n =3D addr_len };</span><br><span> </span><br><span>     /* interface name =
is required */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
ncpynt(wins=2Eiface=2Ename, tt-&gt;actual_name, sizeof(wins=2Eiface=2Ename)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strlcpy(wins=
=2Eiface=2Ename, tt-&gt;actual_name, sizeof(wins=2Eiface=2Ename));</span><b=
r><span> </span><br><span>     if (addr_len &gt; _countof(wins=2Eaddr))</sp=
an><br><span>     {</span><br><span>@@ -372,7 +372,7 @@</span><br><span>   =
                                =2Eiface =3D { =2Eindex =3D tt-&gt;adapter_=
index },</span><br><span>                                   =2Emtu =3D mtu,=
</span><br><span>                                   =2Efamily =3D family };=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(mtu_msg=
=2Eiface=2Ename, tt-&gt;actual_name, sizeof(mtu_msg=2Eiface=2Ename));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    strlcpy(mtu_msg=2Eifa=
ce=2Ename, tt-&gt;actual_name, sizeof(mtu_msg=2Eiface=2Ename));</span><br><=
span>     if (family =3D=3D AF_INET6 &amp;&amp; mtu &lt; 1280)</span><br><s=
pan>     {</span><br><span>         msg(M_INFO,</span><br><span>@@ -2121,7 =
+2121,7 @@</span><br><span>          */</span><br><span>         if (strcmp=
(dev, &quot;tun&quot;) &amp;&amp; strcmp(dev, &quot;tap&quot;))</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      strncpynt(ifr=2Eifr_name, dev, IFNAMSIZ);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            strlcpy(ifr=2Eifr_name, dev, IFNAMS=
IZ);</span><br><span>         }</span><br><span> </span><br><span>         =
/*</span><br><span>@@ -2147,7 +2147,7 @@</span><br><span>             if ((=
ctl_fd =3D socket(AF_INET, SOCK_DGRAM, 0)) &gt;=3D 0)</span><br><span>     =
        {</span><br><span>                 CLEAR(netifr);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                strncpynt(netifr=2Eifr_=
name, ifr=2Eifr_name, IFNAMSIZ);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                strlcpy(netifr=2Eifr_name, ifr=2Eifr_name, IFN=
AMSIZ);</span><br><span>                 netifr=2Eifr_qlen =3D tt-&gt;optio=
ns=2Etxqueuelen;</span><br><span>                 if (ioctl(ctl_fd, SIOCSIF=
TXQLEN, (void *)&amp;netifr) &gt;=3D 0)</span><br><span>                 {<=
/span><br><span>@@ -2403,7 +2403,7 @@</span><br><span>         {</span><br>=
<span>             msg(M_ERR, &quot;Can&#39;t get flags&quot;);</span><br><=
span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  strncpynt(ifr=2Elifr_name, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(ifr=
=2Elifr_name, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));</span><br><span=
>         ifr=2Elifr_ppa =3D ppa;</span><br><span>         /* Assign ppa ac=
cording to the unit number returned by tun device */</span><br><span>      =
   if (ioctl(if_fd, SIOCSLIFNAME, &amp;ifr) &lt; 0)</span><br><span>@@ -247=
1,7 +2471,7 @@</span><br><span>     }</span><br><span> </span><br><span>   =
  CLEAR(ifr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strn=
cpynt(ifr=2Elifr_name, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    strlcpy(ifr=2Elifr_nam=
e, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));</span><br><span>     ifr=
=2Elifr_ip_muxid =3D ip_muxid;</span><br><span>     if (tt-&gt;type =3D=3D =
DEV_TYPE_TAP)</span><br><span>     {</span><br><span>@@ -2512,7 +2512,7 @@<=
/span><br><span>     {</span><br><span>         struct lifreq ifr;</span><b=
r><span>         CLEAR(ifr);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        strncpynt(ifr=2Elifr_name, tt-&gt;actual_name, sizeof(ifr=2E=
lifr_name));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 strlcpy(ifr=2Elifr_name, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));</sp=
an><br><span> </span><br><span>         if (ioctl(tt-&gt;ip_fd, SIOCGLIFFLA=
GS, &amp;ifr) &lt; 0)</span><br><span>         {</span><br><span>diff --git=
 a/src/openvpn/xkey_helper=2Ec b/src/openvpn/xkey_helper=2Ec</span><br><spa=
n>index 69be67a=2E=2E1149c7b 100644</span><br><span>--- a/src/openvpn/xkey_=
helper=2Ec</span><br><span>+++ b/src/openvpn/xkey_helper=2Ec</span><br><spa=
n>@@ -198,7 +198,7 @@</span><br><span>     {</span><br><span>         if (!=
strcmp(alg=2Eop, &quot;Sign&quot;))</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            strncpynt(alg_str, &qu=
ot;ECDSA&quot;, sizeof(alg_str));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            strlcpy(alg_str, &quot;ECDSA&quot;, sizeof(alg_st=
r));</span><br><span>         }</span><br><span>         else</span><br><sp=
an>         {</span><br><span>@@ -207,7 +207,7 @@</span><br><span>     }</s=
pan><br><span>     else if (!strcmp(alg=2Ekeytype, &quot;ED448&quot;) || !s=
trcmp(alg=2Ekeytype, &quot;ED25519&quot;))</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(alg_str, alg=
=2Ekeytype, sizeof(alg_str));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        strlcpy(alg_str, alg=2Ekeytype, sizeof(alg_str));</span><=
br><span>     }</span><br><span>     /* else assume RSA key */</span><br><s=
pan>     else if (!strcmp(alg=2Epadmode, &quot;pkcs1&quot;) &amp;&amp; (fla=
gs &amp; MF_EXTERNAL_KEY_PKCS1PAD))</span><br><span>@@ -221,7 +221,7 @@</sp=
an><br><span>             }</span><br><span>             tbs =3D enc;</span=
><br><span>             tbslen =3D enc_len;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            strncpynt(alg_str, &quot;RSA_PKCS1_PADDIN=
G&quot;, sizeof(alg_str));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            strlcpy(alg_str, &quot;RSA_PKCS1_PADDING&quot;, sizeof(a=
lg_str));</span><br><span>         }</span><br><span>         /* For undige=
sted message, add hashalg=3Ddigest parameter */</span><br><span>         el=
se</span><br><span>@@ -232,7 +232,7 @@</span><br><span>     else if (!strcm=
p(alg=2Epadmode, &quot;none&quot;) &amp;&amp; (flags &amp; MF_EXTERNAL_KEY_=
NOPADDING)</span><br><span>              &amp;&amp; !strcmp(alg=2Eop, &quot=
;Sign&quot;)) /* NO_PADDING requires digested data */</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(al=
g_str, &quot;RSA_NO_PADDING&quot;, sizeof(alg_str));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        strlcpy(alg_str, &quot;RSA_NO_PAD=
DING&quot;, sizeof(alg_str));</span><br><span>     }</span><br><span>     e=
lse if (!strcmp(alg=2Epadmode, &quot;pss&quot;) &amp;&amp; (flags &amp; MF_=
EXTERNAL_KEY_PSSPAD))</span><br><span>     {</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_auth_token=2Ec b/tests/unit_tests/openvpn/test=
_auth_token=2Ec</span><br><span>index 89c418e=2E=2E3a3bfb4 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/test_auth_token=2Ec</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_auth_token=2Ec</span><br><span>@@ -273,7=
 +273,7 @@</span><br><span>     }</span><br><span>     else if (streq(name,=
 &quot;session_id&quot;))</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        strncpynt(last_session_id_value, value, =
sizeof(last_session_id_value));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        strlcpy(last_session_id_value, value, sizeof(last_sessi=
on_id_value));</span><br><span>     }</span><br><span> }</span><br><span> <=
/span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkcs11=2Ec b/tes=
ts/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span>index a54c504=2E=2E33=
51eac 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkcs11=2Ec=
</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><=
span>@@ -164,7 +164,7 @@</span><br><span>     if (!strcmp(prefix, &quot;pkc=
s11-id-request&quot;) &amp;&amp; flags &amp; GET_USER_PASS_NEED_STR)</span>=
<br><span>     {</span><br><span>         assert_true(pkcs11_id_management)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(up=
-&gt;password, pkcs11_id_current, sizeof(up-&gt;password));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(up-&gt;password, pk=
cs11_id_current, sizeof(up-&gt;password));</span><br><span>     }</span><br=
><span>     else if (flags &amp; GET_USER_PASS_PASSWORD_ONLY)</span><br><sp=
an>     {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_user_p=
ass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>index=
 c8c69bf=2E=2Eadcf74a 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/test_user_pass=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_use=
r_pass=2Ec</span><br><span>@@ -53,7 +53,7 @@</span><br><span>     for (int =
i =3D 0; i &lt; QUERY_USER_NUMSLOTS &amp;&amp; query_user[i]=2Eresponse !=
=3D NULL; i++)</span><br><span>     {</span><br><span>         check_expect=
ed_ptr(query_user[i]=2Eprompt);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        strncpynt(query_user[i]=2Eresponse, mock_ptr_type(char *)=
, query_user[i]=2Eresponse_len);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        strlcpy(query_user[i]=2Eresponse, mock_ptr_type(char *=
), query_user[i]=2Eresponse_len);</span><br><span>     }</span><br><span> <=
/span><br><span>     return mock();</span><br></pre><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1995?usp=3Demail">change 1=
995</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1995?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Ib1b4a9544e09506e95001609262269ab8154241e </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 1995 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--BlrETPExRXc=--


--===============0570313965553177079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0570313965553177079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0570313965553177079==--

