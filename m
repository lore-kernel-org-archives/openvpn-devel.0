Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B3CC61DD6
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RMy6Hqm1KEgEdkaGNFTHNPt49F1jgAnuf4AUAhdHcLY=; b=AJldCBoaiVkkaOlyEzP1+V19Qa
	krN4wxN26DG/vIs6IBqaQAnIt2uvrDLFpP5R7iknTY3xMvdQtaOyZFT4aCqfdoPyqiRcc8aVrZ4X5
	D6CuiyVlF8699WNPoYktB+f5eXbmCCzfBEXZAzk4YLlhTKR57odtWVDI8igBA3XI8zoM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1fJZ-0003oS-0i;
	Wed, 02 Sep 2026 07:23:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1fJW-0003oJ-OC
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 07:23:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=T0i+VkWhNu9azAljnSVVSSX1V36CjtQdafoxnF0TIlM=; b=ffBaUk8sJBHyuE3MBpXyRfXRKp
 AAu9pSd89iikqJHS7gkrRmtrPD1H1CRKK+7o5tUcQ3TK3uYprM62JYIu0F5zHMKXXtLkVSmBfFCzB
 QdFDWFr2tt+/KYW7lk+jPPw36sFjdrwo9uAky0xKbkNteY7BpEM/HLbqClwYF2ZJeY9w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=T0i+VkWhNu9azAljnSVVSSX1V36CjtQdafoxnF0TIlM=; b=b
 R6WqPpocpJPmE5qfLuAaBsYtHaEzrYSXOaSt55zh6xRfP/4SL1eyAGdMB3e6QutM7PrtDvBaqdPIl
 v7/zPH7zqTaW0+/jXHKg+CkMRJsUhht0OPuZ0FdY/PG8sRBVRm/32pespUoGpeznFO/mmW2IQJa33
 VDSi8tX8f/35bvE0=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1fJV-0008Gg-I6 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 07:23:19 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4956869750eso4194395e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 00:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788333791; x=1788938591; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T0i+VkWhNu9azAljnSVVSSX1V36CjtQdafoxnF0TIlM=;
 b=XOZX+lhrmRdaob+SlbA4ijdW897sjOXffH0pAW9kgVR/rU22E5gc6rhozRFFBOoJu6
 O5B7uTRa28fuCvQyY7K7Kc6gAYYbU1KuMQfraSWedlvMiWaxt8kydH5ISwWdBR53HR4S
 msWGFvrQzBDBd1VduZdig9strq/UfewG8aY+daT8baOZYHt5xAmS28+Zb0ZOOWe4Yj9C
 ABaeJeC4Ip5Xh8UjmdkrGqFOCOsOih+Rac4KWUTCpBnPLvK8bHh5zhzZ+8axSqklNFok
 AjsjQwHBHNXCjTQvHH8p93gib6cW2pp1ncBihU8WCskJ5jSOseYSlyvdU2oOMMRpsy1A
 OvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788333791; x=1788938591;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=T0i+VkWhNu9azAljnSVVSSX1V36CjtQdafoxnF0TIlM=;
 b=i8CyqUR77FHaW2bMy3TrjlWd84A1bsaJJBFx1vcfEXCEDZ60Ve8nnJSwhfEedUrZpw
 H5ZKUb43YpFMYCoKVhDjBWkMh+qHqOolKSYG4zZeFkHrb2+aWtj2FiLmMDmj9zgFAYPr
 hlrYppZaUvmHD28R/HLJV0Q9FxwLSe+QLz38uVyK2puwTKQfdecsaYgd/pTuFr3yhARq
 KbCaypP9lykXjiR98mgs3xqkqXq6MePQUdI08FEnthryCBIvs4xd4tY4+dkbOn0Ilsbm
 KRngEDz9lXSnfrmmeu7tocWzz7Mt0palzm8O8Gr8a1FtBI1ddRDtG9NANXn9NtFLbwGe
 GgVA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZIkWg6aBqU0M5xgwVX0t5sAjcuADXyohg3t8y2hHuG8Agm9VV8RrA4AXhEWZ/4FCdb1gjf4hcsuPanrJ9@lists.sourceforge.net
X-Gm-Message-State: AFuF++nRCLuYbWuP/GUTjfn2ohw78HlyRh51pIs3ukaWCLVDviE78X/V
 YCz1w541XD6OqWOAGiHOeztMV4KuI5Y0IpjmF4csbqjjsgE2ygPo1fxXyeqQL8EAmPgzkAXduT/
 3lsBEa9qrVOWhMiMpRy3C/gPxlTcxdJLhtFOvmB5aXilxwsh6dHNSGNm1QsiMImFuwSCk
X-Gm-Gg: AR+sD12IQzzwC1g2e+TuBhgK2yAgjGuD1d8QhJK++vNO1gCGWCD1RPs8mq/s5z6/b+h
 Ko7SoEyqFhYAz7xu+74dcrNWZP49uSXbBjytHIvIdjbRaWOWBrX7kR0ATT58rhktdmGSilAO2o2
 d3fP2kfAspWt6LbzYsOezjCtti7Nt8F48hkkOvI9WVblcEajaP4l/y5ag7IiXIMKrbS2+HArokb
 RijQgNwbJ2yoiqR8oi45EwSR8NcFt2uwyhNINwSctHKOMjkE7CfyoP+F68TIxJihqIMF+0gwRp1
 6FEspEo0pgclprZJu9nkRos1kAJWIhA+/8aGpPiOj24eNlds62HTouTDs5kPcCnI13gjPFClFWF
 Jkr9FbnPUen/ghiCxdibCPN6PyhfAMktjIyeUQ9tmVQNb3+lPWKDzRbvo3X2Fh3n71BJhldKmW9
 5MmKvzUXE19xCJk4On2gOxx9GN9c/G0e+aZMVblbTXcGzkcl0xj9usiJuylInxqbYTPvhCI8T4q
 GEBEbLakoo0BqYD+BiMRBjdzlBFagcK04zNu4Ir0qOqiN0Phf6NLkU4rznvmec9gHvmktr9h9MC
 lTAT1XtAqeQLUNQdB1Yf6FIhw61ZMPYF4UEqhomNNhOblMK1XrY=
X-Received: by 2002:a05:600c:1c27:b0:49c:dcec:bd27 with SMTP id
 5b1f17b1804b1-49ce57fd7bamr42680875e9.8.1788333790884; 
 Wed, 02 Sep 2026 00:23:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4780f0dsm44180775e9.12.2026.09.02.00.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 00:23:10 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 07:23:10 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I787a7067f6ff040c6a1f43f384321bddf5efc97b
X-Gerrit-Change-Number: 1889
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1889?usp=email>
X-Gerrit-Commit: 23396ac49bdd390d2e559e74fec16e8763650b78
In-Reply-To: <gerrit.1788282372000.I787a7067f6ff040c6a1f43f384321bddf5efc97b@gerrit.openvpn.net>
References: <gerrit.1788282372000.I787a7067f6ff040c6a1f43f384321bddf5efc97b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MjgyMzcyMDAwLkk3ODdhNzA2N2Y2ZmYwNDBjNmExZjQzZjM4NDMyMWJkZGY1ZWZjOTdiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4cb710f5c8210ad263509063cdbdabb663ca4abf-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1fJV-0008Gg-I6
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win: don't use NULL
 DACL with system objects
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1750036585727838940=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1750036585727838940==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="61y3jdVKcGQ="; charset=UTF-8

--61y3jdVKcGQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1889?usp=3Demail )

Change subject: win: don't use NULL DACL with syste=
m objects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

w=
in: don't use NULL DACL with system objects

The netsh semaphore used a NUL=
L DACL, which allowed any user on a shared
system to block openvpn from run=
ning=2E Instances would time out and shut
down=2E

Similar with the --servi=
ce exit event=2E Any user could signal it and shut
down the instance if the=
 event name is known or can be retrieved from
the running process=2E

To pr=
event both, the objects are created with a DACL which allows access
to the =
creating user only=2E In case of the netsh semaphore this means that
only t=
he first user running openvpn can run more instances=2E Other
accounts doin=
g so will error out=2E The interactive service can be used to
prevent this =
from happening, since the netsh semaphore is only used when
the openvpn pro=
cess runs privileged operations directly=2E

Github: OpenVPN/openvpn-privat=
e-issues#167
CVE: 2026-82312
Reported-By: DEBRAJ BASAK <https://in=2Elinked=
in=2Ecom/in/debrajbasak>
Change-Id: I787a7067f6ff040c6a1f43f384321bddf5efc9=
7b
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Lev S=
tipakov <lstipakov@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1889
Message-Id: <20260901202854=2E13746-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg38886=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/win32=2Ec
M src/openvpn/win32=2Eh
2 files changed,=
 107 insertions(+), 3 deletions(-)




diff --git a/src/openvpn/win32=2Ec b=
/src/openvpn/win32=2Ec
index 44b010d=2E=2Edd88a22 100644
--- a/src/openvpn/=
win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -35,6 +35,8 @@
 
 #include <minwin=
def=2Eh>
 #include <winsock2=2Eh>
+#include <accctrl=2Eh>
+#include <aclapi=
=2Eh>
 
 #include "buffer=2Eh"
 #include "error=2Eh"
@@ -146,6 +148,13 @@
 =
    pause_exit_enabled =3D true;
 }
 
+/**
+ * @brief Initializes security =
attributes with a NULL DACL, allowing
+ *        unrestricted access to the=
 resulting object=2E
+ *
+ * @param obj Security attributes structure to in=
itialize=2E
+ * @return true on success, false otherwise=2E
+ */
 bool
 ini=
t_security_attributes_allow_all(struct security_attributes *obj)
 {
@@ -165=
,6 +174,93 @@
     return true;
 }
 
+/**
+ * @brief Initializes security a=
ttributes with a DACL restricted to the
+ *        current process user=2E
=
+ *
+ * The resulting DACL grants GENERIC_ALL access to the calling user on=
ly,
+ * so the created object cannot be opened, signaled or otherwise acces=
sed
+ * by other users on the system=2E The allocated DACL must be released=
 with
+ * free_security_attributes() once the security attributes are no lo=
nger
+ * needed=2E
+ *
+ * @param obj Security attributes structure to init=
ialize=2E
+ * @return true on success, false otherwise=2E
+ */
+static bool=

+init_security_attributes_allow_user(struct security_attributes *obj)
+{
+=
    bool ret =3D false;
+
+    CLEAR(*obj);
+    obj->sa=2EnLength =3D size=
of(SECURITY_ATTRIBUTES);
+    obj->sa=2ElpSecurityDescriptor =3D &obj->sd;
=
+    obj->sa=2EbInheritHandle =3D FALSE;
+
+    if (!InitializeSecurityDesc=
riptor(&obj->sd, SECURITY_DESCRIPTOR_REVISION))
+    {
+        return ret;=

+    }
+
+    HANDLE token =3D NULL;
+    if (!OpenProcessToken(GetCurrent=
Process(), TOKEN_QUERY, &token))
+    {
+        return ret;
+    }
+
+    =
PTOKEN_USER info =3D NULL;
+    DWORD info_len =3D 0;
+    if (!GetTokenInf=
ormation(token, TokenUser, info, info_len, &info_len)
+        && GetLastEr=
ror() !=3D ERROR_INSUFFICIENT_BUFFER)
+    {
+        goto out;
+    }
+
+ =
   info =3D malloc(info_len);
+    if (!info || !GetTokenInformation(token,=
 TokenUser, info, info_len, &info_len))
+    {
+        goto out;
+    }
+
=
+    EXPLICIT_ACCESS ea =3D { 0 };
+    ea=2EgrfAccessPermissions =3D GENER=
IC_ALL;
+    ea=2EgrfAccessMode =3D SET_ACCESS;
+    ea=2EgrfInheritance =
=3D NO_INHERITANCE;
+    ea=2ETrustee=2ETrusteeForm =3D TRUSTEE_IS_SID;
+  =
  ea=2ETrustee=2ETrusteeType =3D TRUSTEE_IS_USER;
+    ea=2ETrustee=2Eptstr=
Name =3D (LPTSTR)info->User=2ESid;
+
+    if (SetEntriesInAcl(1, &ea, NULL,=
 &obj->dacl) !=3D ERROR_SUCCESS)
+    {
+        goto out;
+    }
+
+    if=
 (SetSecurityDescriptorDacl(&obj->sd, TRUE, obj->dacl, FALSE))
+    {
+    =
    ret =3D true;
+    }
+
+out:
+    free(info);
+    CloseHandle(token);
=
+    return ret;
+}
+
+/**
+ * @brief Releases resources allocated by init_=
security_attributes_allow_user()=2E
+ *
+ * @param obj Security attributes =
structure to release=2E
+ */
+static void
+free_security_attributes(struct =
security_attributes *obj)
+{
+    if (obj->dacl)
+    {
+        LocalFree(=
obj->dacl);
+        obj->dacl =3D NULL;
+    }
+}
+
 void
 overlapped_io_i=
nit(struct overlapped_io *o, const struct frame *frame, BOOL event_state)
 =
{
@@ -504,7 +600,7 @@
         struct gc_arena gc =3D gc_new();
         co=
nst wchar_t *exit_event_nameW =3D wide_string(exit_event_name, &gc);
 
-   =
     if (!init_security_attributes_allow_all(&sa))
+        if (!init_secur=
ity_attributes_allow_user(&sa))
         {
             msg(M_ERR, "Error: =
win32_signal_open: init SA failed");
         }
@@ -526,6 +622,7 @@
       =
          ws->mode =3D WSO_MODE_SERVICE;
             }
         }
+       =
 free_security_attributes(&sa);
         gc_free(&gc);
     }
     /* set t=
he ctrl handler in both console and service modes */
@@ -751,14 +848,15 @@
=
     s->name =3D name;
     s->hand =3D NULL;
 
-    if (init_security_attr=
ibutes_allow_all(&sa))
+    if (init_security_attributes_allow_user(&sa))
 =
    {
         s->hand =3D CreateSemaphore(&sa=2Esa, 1, 1, name);
     }
+ =
   free_security_attributes(&sa);
 
     if (s->hand =3D=3D NULL)
     {
- =
       msg(M_WARN | M_ERRNO, "WARNING: Cannot create Win32 semaphore '%s'",=
 name);
+        msg(M_ERR, "Cannot create Win32 semaphore '%s'", name);
  =
   }
     else
     {
diff --git a/src/openvpn/win32=2Eh b/src/openvpn/win3=
2=2Eh
index ef32062=2E=2E8be3d96 100644
--- a/src/openvpn/win32=2Eh
+++ b/s=
rc/openvpn/win32=2Eh
@@ -63,6 +63,7 @@
 {
     SECURITY_ATTRIBUTES sa;
    =
 SECURITY_DESCRIPTOR sd;
+    PACL dacl;
 };
 
 #define HANDLE_DEFINED(h) (=
(h) !=3D NULL && (h) !=3D INVALID_HANDLE_VALUE)
@@ -262,6 +263,11 @@
  *
  =
* It seems you can't run more than one instance
  * of netsh on the same ma=
chine at the same time=2E
+ *
+ * Its DACL is restricted to the creating us=
er to prevent an unprivileged
+ * local user from starving it and DoS'ing r=
unning instances=2E This means
+ * different user accounts running OpenVPN =
directly, not via the interactive
+ * service, will make all but the first =
user's instances exit=2E
  */
 
 extern struct semaphore netcmd_semaphore;
=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1889?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I787a7067f6ff040c6a1=
f43f384321bddf5efc97b
Gerrit-Change-Number: 1889
Gerrit-PatchSet: 2
Gerrit-=
Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-C=
C: d12fk <heiko@openvpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>

--61y3jdVKcGQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1889?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">win: don&#39;t use NULL DACL with system o=
bjects<br><br>The netsh semaphore used a NULL DACL, which allowed any user =
on a shared<br>system to block openvpn from running=2E Instances would time=
 out and shut<br>down=2E<br><br>Similar with the --service exit event=2E An=
y user could signal it and shut<br>down the instance if the event name is k=
nown or can be retrieved from<br>the running process=2E<br><br>To prevent b=
oth, the objects are created with a DACL which allows access<br>to the crea=
ting user only=2E In case of the netsh semaphore this means that<br>only th=
e first user running openvpn can run more instances=2E Other<br>accounts do=
ing so will error out=2E The interactive service can be used to<br>prevent =
this from happening, since the netsh semaphore is only used when<br>the ope=
nvpn process runs privileged operations directly=2E<br><br>Github: OpenVPN/=
openvpn-private-issues#167<br>CVE: 2026-82312<br>Reported-By: DEBRAJ BASAK =
&lt;https://in=2Elinkedin=2Ecom/in/debrajbasak&gt;<br>Change-Id: I787a7067f=
6ff040c6a1f43f384321bddf5efc97b<br>Signed-off-by: Heiko Hund &lt;heiko@ist=
=2Eeigentlich=2Enet&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom=
&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1889<br>Mess=
age-Id: &lt;20260901202854=2E13746-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3=
8886=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M src/openvpn/win32=2Ec<br>M src/openvpn/win32=2Eh<br>2 files cha=
nged, 107 insertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index 44b010d=2E=
=2Edd88a22 100644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br><sp=
an>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -35,6 +35,8 @@</span><br>=
<span> </span><br><span> #include &lt;minwindef=2Eh&gt;</span><br><span> #i=
nclude &lt;winsock2=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &lt;accctrl=2Eh&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &lt;aclapi=2Eh&gt;</span><br><span> </span><br><s=
pan> #include &quot;buffer=2Eh&quot;</span><br><span> #include &quot;error=
=2Eh&quot;</span><br><span>@@ -146,6 +148,13 @@</span><br><span>     pause_=
exit_enabled =3D true;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @brief Initializes security attributes with a NU=
LL DACL, allowing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
        unrestricted access to the resulting object=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param obj Security attributes structure to initialize=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true =
on success, false otherwise=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span> bool</span><br><span> init_security_attribu=
tes_allow_all(struct security_attributes *obj)</span><br><span> {</span><br=
><span>@@ -165,6 +174,93 @@</span><br><span>     return true;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief In=
itializes security attributes with a DACL restricted to the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *        current process user=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * The resulting DACL grants GENERIC_A=
LL access to the calling user only,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * so the created object cannot be opened, signaled or othe=
rwise accessed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * by=
 other users on the system=2E The allocated DACL must be released with</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * free_security_attribu=
tes() once the security attributes are no longer</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * needed=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param obj Security attributes structure to initialize=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, f=
alse otherwise=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+init_security_attributes_a=
llow_user(struct security_attributes *obj)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(=
*obj);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    obj-&gt;s=
a=2EnLength =3D sizeof(SECURITY_ATTRIBUTES);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    obj-&gt;sa=2ElpSecurityDescriptor =3D &amp;obj=
-&gt;sd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    obj-&gt=
;sa=2EbInheritHandle =3D FALSE;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!InitializeSecurityDescriptor(&amp;obj-&gt;sd, SECURITY_DESCRIPTOR_REVISIO=
N))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return ret;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    HANDLE token =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!OpenProcessToken(GetCurrentProcess(), TOKEN_QUE=
RY, &amp;token))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return re=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    PTOKEN_USER info =3D NULL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    DWORD info_len =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!GetTokenInformation(toke=
n, TokenUser, info, info_len, &amp;info_len)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        &amp;&amp; GetLastError() !=3D ERROR_INSUF=
FICIENT_BUFFER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    info =3D malloc(info_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!info || !GetTokenInformation(tok=
en, TokenUser, info, info_len, &amp;info_len))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    EXPLICIT_ACCESS ea=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ea=
=2EgrfAccessPermissions =3D GENERIC_ALL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ea=2EgrfAccessMode =3D SET_ACCESS;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ea=2EgrfInheritance =3D NO_INHE=
RITANCE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ea=2ETr=
ustee=2ETrusteeForm =3D TRUSTEE_IS_SID;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ea=2ETrustee=2ETrusteeType =3D TRUSTEE_IS_USER;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ea=2ETrustee=2Eptst=
rName =3D (LPTSTR)info-&gt;User=2ESid;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (SetEntriesInAcl(1, &amp;ea, NULL, &amp;obj-&gt;dacl) !=3D ERROR_SUC=
CESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (SetSecurityDescriptorDacl(&amp;obj-&gt;sd, TRUE, obj-&g=
t;dacl, FALSE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+out:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    free(info);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    CloseHandle(token);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @brief Releases resources allocated by init=
_security_attributes_allow_user()=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param obj Security attributes structure to release=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+free_security_attributes(struct security_attributes *obj)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (obj-&gt;dacl)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        LocalFree(obj-&gt;dacl);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        obj-&gt;dacl =3D NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> void</span><br><span> overlapped_io_init(=
struct overlapped_io *o, const struct frame *frame, BOOL event_state)</span=
><br><span> {</span><br><span>@@ -504,7 +600,7 @@</span><br><span>         =
struct gc_arena gc =3D gc_new();</span><br><span>         const wchar_t *ex=
it_event_nameW =3D wide_string(exit_event_name, &amp;gc);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!init_sec=
urity_attributes_allow_all(&amp;sa))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (!init_security_attributes_allow_user(&amp;sa))=
</span><br><span>         {</span><br><span>             msg(M_ERR, &quot;E=
rror: win32_signal_open: init SA failed&quot;);</span><br><span>         }<=
/span><br><span>@@ -526,6 +622,7 @@</span><br><span>                 ws-&gt=
;mode =3D WSO_MODE_SERVICE;</span><br><span>             }</span><br><span>=
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f=
ree_security_attributes(&amp;sa);</span><br><span>         gc_free(&amp;gc)=
;</span><br><span>     }</span><br><span>     /* set the ctrl handler in bo=
th console and service modes */</span><br><span>@@ -751,14 +848,15 @@</span=
><br><span>     s-&gt;name =3D name;</span><br><span>     s-&gt;hand =3D NU=
LL;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (init_security_attributes_allow_all(&amp;sa))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (init_security_attributes_allow_us=
er(&amp;sa))</span><br><span>     {</span><br><span>         s-&gt;hand =3D=
 CreateSemaphore(&amp;sa=2Esa, 1, 1, name);</span><br><span>     }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    free_security_attributes=
(&amp;sa);</span><br><span> </span><br><span>     if (s-&gt;hand =3D=3D NUL=
L)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        msg(M_WARN | M_ERRNO, &quot;WARNING: Cannot create Win32 semaph=
ore &#39;%s&#39;&quot;, name);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        msg(M_ERR, &quot;Cannot create Win32 semaphore &#39;%s&#=
39;&quot;, name);</span><br><span>     }</span><br><span>     else</span><b=
r><span>     {</span><br><span>diff --git a/src/openvpn/win32=2Eh b/src/ope=
nvpn/win32=2Eh</span><br><span>index ef32062=2E=2E8be3d96 100644</span><br>=
<span>--- a/src/openvpn/win32=2Eh</span><br><span>+++ b/src/openvpn/win32=
=2Eh</span><br><span>@@ -63,6 +63,7 @@</span><br><span> {</span><br><span> =
    SECURITY_ATTRIBUTES sa;</span><br><span>     SECURITY_DESCRIPTOR sd;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    PACL dacl;</span><=
br><span> };</span><br><span> </span><br><span> #define HANDLE_DEFINED(h) (=
(h) !=3D NULL &amp;&amp; (h) !=3D INVALID_HANDLE_VALUE)</span><br><span>@@ =
-262,6 +263,11 @@</span><br><span>  *</span><br><span>  * It seems you can&=
#39;t run more than one instance</span><br><span>  * of netsh on the same m=
achine at the same time=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Its DAC=
L is restricted to the creating user to prevent an unprivileged</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * local user from starving it =
and DoS&#39;ing running instances=2E This means</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * different user accounts running OpenVPN dire=
ctly, not via the interactive</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * service, will make all but the first user&#39;s instances exit=
=2E</span><br><span>  */</span><br><span> </span><br><span> extern struct s=
emaphore netcmd_semaphore;</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1889?usp=3Demail">c=
hange 1889</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1889?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I787a7067f6ff040c6a1f43f384321bddf5efc97b </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1889 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@openvpn=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--61y3jdVKcGQ=--


--===============1750036585727838940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1750036585727838940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1750036585727838940==--

