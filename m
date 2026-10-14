Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96522CC6B2D
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=10EFuljQZLd8Un4o2Rh2y90bXXJAXCczLty1aU00DBQ=; b=ZbNW69vgiBtG3RxZiWKpO8pnmR
	4MJKBzMI1iCY+1xJrdOoL6LSmfVKRLaDe2wWp0w9ijpslXUuoAIQOFLVvyHhlWEZFxU4yWkCjdXIS
	nam6Jyvddb85QfpmNyZ+x8vQ+LAKziyBRNnKhf0ISXF2jrdNe2vBPYLhrEyKP79K9JUI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGxAX-000723-Ro;
	Wed, 14 Oct 2026 11:29:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGxAW-00071v-Dp
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:29:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dPW7TExCr7xHLqvNPRWoNg/gUbMoRK1t1aBK9gnl1Bs=; b=Mfx2gXxbMdvQU8XKQhE/RwqYum
 ATxJ1kOiYcqYBupf/PSo9sCaFBZSmrLspV6huCZzKp1x8FmXyu/vkMxyXKk+LkK+SpZ/bF1lCujBk
 ZZqOLijgy1JZW4KdcRhsR7klCLPZahIx7PtIcG4fJFyIz9o4GujBJJLQ1elQxoUH5COs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dPW7TExCr7xHLqvNPRWoNg/gUbMoRK1t1aBK9gnl1Bs=; b=W
 AhbkV5iCHKweJbQW2sIUfWBlEX8wzR9E3Zjvoym+P31SW+EP+NXDsKJTvY2vsVsc0Zsvlhmwvx/+v
 AdTTMHMTt72WkRD6xEBWq3NwbZeWMtb0gGB18mB9VFb67bKOR+cP4GhDvjAp7sT/gKIUvEAzclmwk
 mcZ7Oo/fIgmsQ7UI=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGxAU-0007MR-QB for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:29:12 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso8476825e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791977344; x=1792582144; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dPW7TExCr7xHLqvNPRWoNg/gUbMoRK1t1aBK9gnl1Bs=;
 b=Hnp6jaM8O+g1SKQfoxdgvvvhU08/+VOzcIduHg13E7cZCdxSEc6aPswMeNMFbgye+N
 PIEUVQfQyRcFS0kpqDdhCHe5X+NycX5T/a7a0no1vPdqe7Rf3LXFwBTbsK6wQvgAMKLS
 hlf38PxXAl0at1YpV8hXqlzq0VacIlFg9unFtklafteDFpgJhpo9NWZXbt24obLgqOcS
 8+Te6LEXg5aco/O2z6Uwq5HE92TsDAvWZhOCxdz38x4AeayM+so0Werqo1oCChh70Pyw
 ZGLdAq98jbfYjF7MFLTvoNqujoV3AZHyz8NH+BMRce5bkuB7hnbo73xb/FThFJ9R7aCc
 maCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791977344; x=1792582144;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dPW7TExCr7xHLqvNPRWoNg/gUbMoRK1t1aBK9gnl1Bs=;
 b=ErLnD3yb5X52Nz1ag/lCSEo+HLUC/So0E0B/0JOulVDKPpyF5dVnZBRs/sJCM2lt9K
 hAgcz2GSVhQxC9GoRon67i90x43M6vyZbBFma9ecdr+XSAjmI0N2xclWrc4//OarRNly
 AK1TLgeBx4jqV/JHpWyol2NyJiLiPZ4RqJY16KNhS7o1GhKiiM3WBkiXy7fVEAa6eCci
 IMIBDzyArf774MQOa0MI0aCSa4ZipOA4txAcIJZszZTVRjPNm/JAKb+RnIDGiQ5re7Uf
 fimDRLBfvATUvTziIZ4XW9O6t0Dz+XrdeeIuBdiZD4kNtKIAtAvyeBBiLvLS06xXQp/V
 O1lg==
X-Gm-Message-State: AFq9FYKyMjbvlDM6RfxbXnqUcrS7YyIUvV1CpWje6aoAcviAvenpEnmc
 SrvHxg9nNaQlTHipk47G9AXQZ+yW6jSMO5Q02ftO/m7x5pddk/asXRlbcM1b0V+jav8bg/cZ/z6
 qoaXQO8H0gJLsjLmx4gYnq5X7tF8ZjDb9NHry//aCxotQ99G8XMH7L1zYNvXH5YotoyOn
X-Gm-Gg: AYBFou3EuPwKY/eRqJurMMtLp+nX0AYCetvuSE/puNEQBd5nTS405NMvwslLtVmqXEp
 UYJyv6jrAtuOtomRvBNmsMx/yOjFP6ySnLyRVh581c7v5tFHQz2HiV5nWUxmrhNz+559DBFwd+x
 wBr8FLPtmmT2lGMMXXarJHeDEjJLWwWaVoviDUlUPB6K4wQLHSE/0Bjom6uCblDh/lGdEYHwzOb
 nq6lvWdVhKorPczj8kIICGn+ZJ6+6gF09wi8asxJ/xchgIuriWx7yrZTw/DASVI9fNSubC2mi14
 VIPuh9LsEPBE91cZ6O16yxqmYW1sQOAgI9iOevS/zC0BCc83oSXnrQkKSKcpFcT8PUdED43Hgsu
 eoGB8Pvt2wHRdf4GnxqaabBO1o6+kwmiO8Cj4EaImiGnjMwtJJ8M8rq3rUom2QHgUrveIbjwzkW
 mfu1WsP3Ejzmp8wsplliSkxN71UUdZIQDCB2593j31gANEu++1moPoS0y48y+yAUyzNLIj0BETq
 qhg3wHR6yvdy4fPSojPBdDH4zH7zyK8bf5brb8YgePxvAU7jvqQ7sP3XXOI36/yWD6lz1jMd5Qh
 LERX2VSZdlUBUYzRrE+/EyYZNbuO7XpDCxJ+9h2xf7WEGZpVi0KnRZY5Mtr+
X-Received: by 2002:a05:600c:198c:b0:4a0:1c0e:b136 with SMTP id
 5b1f17b1804b1-4a18e4cdbfbmr321129765e9.29.1791977344080; 
 Wed, 14 Oct 2026 04:29:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b2fc4724sm47587925e9.2.2026.10.14.04.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:29:03 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 11:28:57 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335
X-Gerrit-Change-Number: 1996
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1996?usp=email>
X-Gerrit-Commit: 5fb74caaaf6c7072dd50d05a84275d462e04cf1e
In-Reply-To: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
References: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk2MWUyOWRkMmFmOTMwMmIyNDBjOTM3MzUxNzlkNDNjNzJlMzdiMzM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ef104be25d229e359e6f87ac933f7d7f73e88db9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGxAU-0007MR-QB
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Replace strncat with
 strlcat
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
Content-Type: multipart/mixed; boundary="===============7987417747336803611=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7987417747336803611==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ycrQVR4MWmc="; charset=UTF-8

--ycrQVR4MWmc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1996?usp=3Demail

to look at the new patch set (#2)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review-1 by R=C4=83z=
van Cojocaru


Change subject: Replace strncat with strlcat
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace strncat with strlcat=


Generally much better API=2E Not a straight-forward
replacement in many c=
ases, trying to improve the
code generally=2E

Change-Id: I61e29dd2af9302b2=
40c93735179d43c72e37b335
Signed-off-by: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
---
M src/openvpn/misc=2Ec
M src/openvpn/options_parse=2Ec
M src/o=
penvpn/status=2Ec
M src/openvpn/xkey_helper=2Ec
M src/plugins/auth-pam/util=
s=2Ec
5 files changed, 24 insertions(+), 24 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/96/1996/2

diff --git a/=
src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec
index a75bd8f=2E=2Eb9cc6a2 1006=
44
--- a/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -437,12 +437,11=
 @@
                     }
                     else
                     {=

-                        if (strlen(up->password) + strlen(response) >=3D =
USER_PASS_LEN)
+                        if (strlcat(up->password, response,=
 USER_PASS_LEN) >=3D USER_PASS_LEN)
                         {
            =
                 msg(M_FATAL,
                                 "ERROR: coul=
d not concatenate password/static_response: string too long");
            =
             }
-                        strncat(up->password, response, USE=
R_PASS_LEN - strlen(up->password) - 1);
                     }
            =
     }
 #endif /* ifdef ENABLE_MANAGEMENT */
diff --git a/src/openvpn/optio=
ns_parse=2Ec b/src/openvpn/options_parse=2Ec
index 12934ab=2E=2E3d893d4 100=
644
--- a/src/openvpn/options_parse=2Ec
+++ b/src/openvpn/options_parse=2Ec=

@@ -244,10 +244,7 @@
     else if (is->type =3D=3D IS_TYPE_BUF)
     {
   =
      bool status =3D buf_parse(is->u=2Emultiline, '\n', line, size);
-    =
    if ((int)strlen(line) + 1 < size)
-        {
-            strcat(line, =
"\n");
-        }
+        strlcat(line, "\n", size);
         return statu=
s;
     }
     else
diff --git a/src/openvpn/status=2Ec b/src/openvpn/statu=
s=2Ec
index c7d375b=2E=2E981bb23 100644
--- a/src/openvpn/status=2Ec
+++ b/=
src/openvpn/status=2Ec
@@ -234,14 +234,11 @@
 
         if (so->fd >=3D 0 &=
& !so->errors)
         {
-            strcat(buf, "\n");
-            ssiz=
e_t len =3D strlen(buf);
-            if (len > 0)
+            size_t len =
=3D strlcat(buf, "\n", sizeof(buf));
+            ASSERT(len < sizeof(buf))=
;
+            if (write(so->fd, buf, (unsigned int)len) !=3D (ssize_t)len)=

             {
-                if (write(so->fd, buf, (unsigned int)len) =
!=3D len)
-                {
-                    so->errors =3D true;
-   =
             }
+                so->errors =3D true;
             }
       =
  }
 
diff --git a/src/openvpn/xkey_helper=2Ec b/src/openvpn/xkey_helper=2E=
c
index 1149c7b=2E=2Ec945d18 100644
--- a/src/openvpn/xkey_helper=2Ec
+++ b=
/src/openvpn/xkey_helper=2Ec
@@ -247,7 +247,10 @@
 
     if (is_message)
  =
   {
-        strncat(alg_str, ",data=3Dmessage", sizeof(alg_str) - strlen(=
alg_str) - 1);
+        if (strlcat(alg_str, ",data=3Dmessage", sizeof(alg_=
str)) >=3D sizeof(alg_str))
+        {
+            return -1;
+        }
 =
    }
 
     dmsg(D_LOW, "xkey management_sign: requesting sig with algorit=
hm <%s>", alg_str);
diff --git a/src/plugins/auth-pam/utils=2Ec b/src/plugi=
ns/auth-pam/utils=2Ec
index a4d2d0b=2E=2E01cc4de 100644
--- a/src/plugins/a=
uth-pam/utils=2Ec
+++ b/src/plugins/auth-pam/utils=2Ec
@@ -47,10 +47,11 @@
=
     }
 
     size_t tosearchlen =3D strlen(tosearch);
+    size_t searchfo=
rlen =3D strlen(searchfor);
     size_t replacewithlen =3D strlen(replacewi=
th);
     size_t templen =3D tosearchlen * replacewithlen;
 
-    if (tosea=
rchlen =3D=3D 0 || strlen(searchfor) =3D=3D 0 || replacewithlen =3D=3D 0)
+=
    if (tosearchlen =3D=3D 0 || searchforlen =3D=3D 0 || replacewithlen =3D=
=3D 0)
     {
         return NULL;
     }
@@ -65,23 +66,26 @@
 
     /* st=
ate: all parameters are valid */
 
-    const char *searching =3D tosearch;=

-
-    char temp[templen + 1];
-    temp[0] =3D 0;
-
-    const char *scra=
tch =3D strstr(searching, searchfor);
+    const char *scratch =3D strstr(t=
osearch, searchfor);
     if (!scratch)
     {
         return strdup(tosea=
rch);
     }
 
+    const char *searching =3D tosearch;
+    char temp[temp=
len + 1];
+    memset(temp, 0, sizeof(temp));
+    char *target =3D temp;
+=

     while (scratch)
     {
-        strncat(temp, searching, (size_t)(scr=
atch - searching));
-        strcat(temp, replacewith);
+        size_t ski=
pped =3D (size_t)(scratch - searching);
+        memcpy(target, searching, =
skipped);
+        target +=3D skipped;
+        memcpy(target, replacewith=
, replacewithlen);
+        target +=3D replacewithlen;
 
-        searchin=
g =3D scratch + strlen(searchfor);
+        searching =3D scratch + searchf=
orlen;
         scratch =3D strstr(searching, searchfor);
     }
     retur=
n strdup(temp);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1996?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I61e29dd2af9302b240c93735179d43c72e37b335
Gerrit-Change-Number: 1996
Gerri=
t-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--ycrQVR4MWmc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #2</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/199=
6?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Rep=
lace strncat with strlcat<br><br>Generally much better API=2E Not a straigh=
t-forward<br>replacement in many cases, trying to improve the<br>code gener=
ally=2E<br><br>Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M sr=
c/openvpn/misc=2Ec<br>M src/openvpn/options_parse=2Ec<br>M src/openvpn/stat=
us=2Ec<br>M src/openvpn/xkey_helper=2Ec<br>M src/plugins/auth-pam/utils=2Ec=
<br>5 files changed, 24 insertions(+), 24 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/96/=
1996/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</sp=
an><br><span>index a75bd8f=2E=2Eb9cc6a2 100644</span><br><span>--- a/src/op=
envpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><span>@=
@ -437,12 +437,11 @@</span><br><span>                     }</span><br><span=
>                     else</span><br><span>                     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        if (str=
len(up-&gt;password) + strlen(response) &gt;=3D USER_PASS_LEN)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        if (strl=
cat(up-&gt;password, response, USER_PASS_LEN) &gt;=3D USER_PASS_LEN)</span>=
<br><span>                         {</span><br><span>                      =
       msg(M_FATAL,</span><br><span>                                 &quot;=
ERROR: could not concatenate password/static_response: string too long&quot=
;);</span><br><span>                         }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                        strncat(up-&gt;password, r=
esponse, USER_PASS_LEN - strlen(up-&gt;password) - 1);</span><br><span>    =
                 }</span><br><span>                 }</span><br><span> #end=
if /* ifdef ENABLE_MANAGEMENT */</span><br><span>diff --git a/src/openvpn/o=
ptions_parse=2Ec b/src/openvpn/options_parse=2Ec</span><br><span>index 1293=
4ab=2E=2E3d893d4 100644</span><br><span>--- a/src/openvpn/options_parse=2Ec=
</span><br><span>+++ b/src/openvpn/options_parse=2Ec</span><br><span>@@ -24=
4,10 +244,7 @@</span><br><span>     else if (is-&gt;type =3D=3D IS_TYPE_BUF=
)</span><br><span>     {</span><br><span>         bool status =3D buf_parse=
(is-&gt;u=2Emultiline, &#39;\n&#39;, line, size);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if ((int)strlen(line) + 1 &lt; size)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            strcat(line, &quot;\n&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcat(line, &quo=
t;\n&quot;, size);</span><br><span>         return status;</span><br><span>=
     }</span><br><span>     else</span><br><span>diff --git a/src/openvpn/s=
tatus=2Ec b/src/openvpn/status=2Ec</span><br><span>index c7d375b=2E=2E981bb=
23 100644</span><br><span>--- a/src/openvpn/status=2Ec</span><br><span>+++ =
b/src/openvpn/status=2Ec</span><br><span>@@ -234,14 +234,11 @@</span><br><s=
pan> </span><br><span>         if (so-&gt;fd &gt;=3D 0 &amp;&amp; !so-&gt;e=
rrors)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            strcat(buf, &quot;\n&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            ssize_t len =3D strlen(buf);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (len &gt;=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            size=
_t len =3D strlcat(buf, &quot;\n&quot;, sizeof(buf));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ASSERT(len &lt; sizeof(buf));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (wri=
te(so-&gt;fd, buf, (unsigned int)len) !=3D (ssize_t)len)</span><br><span>  =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       if (write(so-&gt;fd, buf, (unsigned int)len) !=3D len)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    so-&gt;errors =3D t=
rue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                so-=
&gt;errors =3D true;</span><br><span>             }</span><br><span>       =
  }</span><br><span> </span><br><span>diff --git a/src/openvpn/xkey_helper=
=2Ec b/src/openvpn/xkey_helper=2Ec</span><br><span>index 1149c7b=2E=2Ec945d=
18 100644</span><br><span>--- a/src/openvpn/xkey_helper=2Ec</span><br><span=
>+++ b/src/openvpn/xkey_helper=2Ec</span><br><span>@@ -247,7 +247,10 @@</sp=
an><br><span> </span><br><span>     if (is_message)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncat(alg_st=
r, &quot;,data=3Dmessage&quot;, sizeof(alg_str) - strlen(alg_str) - 1);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strlcat(alg=
_str, &quot;,data=3Dmessage&quot;, sizeof(alg_str)) &gt;=3D sizeof(alg_str)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return -1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
>     }</span><br><span> </span><br><span>     dmsg(D_LOW, &quot;xkey manag=
ement_sign: requesting sig with algorithm &lt;%s&gt;&quot;, alg_str);</span=
><br><span>diff --git a/src/plugins/auth-pam/utils=2Ec b/src/plugins/auth-p=
am/utils=2Ec</span><br><span>index a4d2d0b=2E=2E01cc4de 100644</span><br><s=
pan>--- a/src/plugins/auth-pam/utils=2Ec</span><br><span>+++ b/src/plugins/=
auth-pam/utils=2Ec</span><br><span>@@ -47,10 +47,11 @@</span><br><span>    =
 }</span><br><span> </span><br><span>     size_t tosearchlen =3D strlen(tos=
earch);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t s=
earchforlen =3D strlen(searchfor);</span><br><span>     size_t replacewithl=
en =3D strlen(replacewith);</span><br><span>     size_t templen =3D tosearc=
hlen * replacewithlen;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (tosearchlen =3D=3D 0 || strlen(searchfor) =3D=3D=
 0 || replacewithlen =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (tosearchlen =3D=3D 0 || searchforlen =3D=3D 0 || replace=
withlen =3D=3D 0)</span><br><span>     {</span><br><span>         return NU=
LL;</span><br><span>     }</span><br><span>@@ -65,23 +66,26 @@</span><br><s=
pan> </span><br><span>     /* state: all parameters are valid */</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char=
 *searching =3D tosearch;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char temp[tem=
plen + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    temp[0]=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    const char *scratch =3D strstr(=
searching, searchfor);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *scratch =3D strstr(tosearch, searchfor);</span><br><span=
>     if (!scratch)</span><br><span>     {</span><br><span>         return =
strdup(tosearch);</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const char *searching =3D tosear=
ch;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char temp[te=
mplen + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mems=
et(temp, 0, sizeof(temp));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    char *target =3D temp;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     while (scratch)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncat(temp, =
searching, (size_t)(scratch - searching));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        strcat(temp, replacewith);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        size_t skipped =3D (size_t)(scr=
atch - searching);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       memcpy(target, searching, skipped);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        target +=3D skipped;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        memcpy(target, replacewith, repla=
cewithlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
target +=3D replacewithlen;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        searching =3D scratch + strlen(searchfor);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        searching =
=3D scratch + searchforlen;</span><br><span>         scratch =3D strstr(sea=
rching, searchfor);</span><br><span>     }</span><br><span>     return strd=
up(temp);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1996?usp=3Demail">change 1996</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I61e29dd2af9302b240c93=
735179d43c72e37b335 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1996 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--ycrQVR4MWmc=--


--===============7987417747336803611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7987417747336803611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7987417747336803611==--

