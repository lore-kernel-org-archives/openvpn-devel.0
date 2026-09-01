Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7B1C61DD3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=NfPvu45n5MuiKniIyLYmL/r3Pm6YeBL6IkHo0hqGU/I=; b=QVrUq7LWkeTof6
	DkMoh+Fc+I8pJo++99w0k2YRbPrfzGGz/mwibvN6xke/Z+padFm2q40w5UF4BBPl/PnNeDbLJ5gIQ
	KunFlPC2ZsiFqSGti02BemsH+VDL9Bqq/6PJ6+NnMoEsxqmtLDdend4QPu1bnk+V2P2lVt2P237c9
	7LE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1RwG-0003rk-AS;
	Tue, 01 Sep 2026 17:06:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1RwE-0003rd-Rj
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 17:06:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fym3uT+jVzP4a93LuKrIU77bcFXY/SRS8eDvsxBzlnA=; b=bBHEKOLtUnlC0frW6QDKVNNPv1
 sge677wjHm1+2T7Dzn/4D2rMIaChlY+Np25se7RxMtXzK3moi5z7Nuqr5TODqLirp8U76sJp80Dj6
 QndU3ozEjMD/cb8LIf1m/81cgMNJhLugG1LntnIVfpjWMB7lXPV/dnNl+RzWznvpLZeg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Fym3uT+jVzP4a93LuKrIU77bcFXY/SRS8eDvsxBzlnA=; b=H
 LKbgANsZYbxueoTmBSl+7g3JrqrmYDIsLO0AjZ2MpP3JOFqQVJmBrnqwz2e6eJ3YgJ5PzneN9vbzl
 A4u6xY78UEvlxo7aOnS47Bp6SRtUgdQ6bqd0NyFqqGWQ6KRxisWRgAKvJms8fQdeDN1y6OmXX4HRQ
 /ONo1+ew34CLAWQ8=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1RwD-0000DP-Tb for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 17:06:23 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so85381f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788282375; x=1788887175; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Fym3uT+jVzP4a93LuKrIU77bcFXY/SRS8eDvsxBzlnA=;
 b=SIT7Bw7KipRWJKUQ/+AzfkYe3I1ITUSm+mvyp4Ih246N2VRZOD8fBLkFR9tEBpB2xT
 wW9o6aWwWRz4NQ2gHni0xjghL7QUPVkhZ80EpRQc2ir7cjdIk10ZykCRrmhjKuUArqBM
 XgohsFLjG0VdeAusBAcc9CM5l65tbO3JQ2soThTD8Sc7c+me48VzBjZfKPBh+WHNUESM
 eEK0cmP7V9rN9NTvyTVuEupvYDNjtaF178QOCTYdU7W6nC17PNa0Mj2OE17tE3hUw/oc
 8bjGdofzlpJpKjV9uVO58kQ29vQAK+CQ98UEH320xuBxLJfrEKStFu/bb0HKQBAgBUBk
 roDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282375; x=1788887175;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fym3uT+jVzP4a93LuKrIU77bcFXY/SRS8eDvsxBzlnA=;
 b=XOjT2Re18xAf2DPdoCqDlfSJizkMaNXM9dWnC/swYg+O3S7gDrTtyGzmRTTUtXeJRm
 9uHOx7/sct6JP76CV5GdocpBdcaTBIF1/blM/X9YUi3zLzr/bhKK64jp4MkA4tpPNp+H
 kyaqMxWBLoqUlNcX1zuPj62ERX/3NxIrZ3969pTzblweGJdOlj1T/+MpcfqkdOH2ETKj
 EddgXU/YWn6Ub7/oU30LNFGIHXxpG9GzNj9onTYbawTi1CixBn4cobicHBHsdTGl7cBj
 Bex8xFl7fvSpIzvZXzrlEHm37/hQpx+57c5DUrIYoF7U1tKURfcDzs/HFEf8Ly3cc/sd
 vkGQ==
X-Gm-Message-State: AFuF++l+1+rQfbM3ePpJFrldYoLA1EWAhxKnSrBhnSPwGKtZAuMvaJU5
 oqLuLldqAAsZmBJMYuvCnFyqhFNaHkjYa7HqoC3gqPdenZ3crXQedztR9lANK2NfTkRgSHab/fp
 3tYqi8q/zGBqoHm+ZBQiezMwobrgdCGqf4U9VnzVufL39CUcvpmNj1BEFuJ78TZKYhDpzPSl/Zw
 PBPVTULg==
X-Gm-Gg: AYBFou39IyfZ+q7QkU8tGm59TBG2pMwKEMU0R80Z5l4pBJTVgSeWQ+dUaHHxHGmLU3m
 vG7y0f1Oc7ot+fV2lOURg7z03cMlnZg9SO/2Krfg3hkZbfRQbRgnGkTCzvNhb7EcmoYJXizYfxO
 jvhvGqgpALRmW6oHIUwDpIg+JotDVTst6humM7KABUmHSY9oVfTGA3CcXyAGgOXB+85609nkAes
 nX2/OizJYWNE0lBJG14RdEqJy/7c3lBLkmcamUff3v0NghUr5UicwPAYG0itkFa32uhAypHF9Ue
 vdy97QHs+bHxvMcLcsxptl7ggZnT79eCHkTMKe15u/6GY3DHS+N22ebeXqXQVTfoB/inBarsHuO
 Htv4R4alHYabeN5iQOLYZJiuf7DyBSbWj2OU+qubXssAiOyYwbUpl+sKIWWyC6TU6XQPk7AG9P4
 vKicmpdQOAk1MDNGGsdRS/gADBWO8TnOsPjpnywx/bSzVRSBaFucBVx7Fc7CkfxpCT2Z0j0GzOD
 AdmkKNP+Xwr9xxp+8fFeyWt9AK+Zu2iigv7gtA5jhw/7kG9FLTf+F5fwAIZRJmc7rCbKDG/ZEmA
 6kXtTOr22zZK3Gx3SLoWnxvNt59+Dxx0ueF1tX3XpiIycAhWtKo=
X-Received: by 2002:a05:6000:27c6:b0:482:f270:65c5 with SMTP id
 ffacd0b85a97d-48440fe3214mr14061947f8f.9.1788282374976; 
 Tue, 01 Sep 2026 10:06:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eeae34sm311025f8f.32.2026.09.01.10.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:06:14 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 17:06:14 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I787a7067f6ff040c6a1f43f384321bddf5efc97b
X-Gerrit-Change-Number: 1889
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1889?usp=email>
X-Gerrit-Commit: 395f0a0e0661e4acc76432a71735c45d5cd657a2
References: <gerrit.1788282372000.I787a7067f6ff040c6a1f43f384321bddf5efc97b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MjgyMzcyMDAwLkk3ODdhNzA2N2Y2ZmYwNDBjNmExZjQzZjM4NDMyMWJkZGY1ZWZjOTdiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0c150614fa6225d81b699bc518098d897a3366e9-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1RwD-0000DP-Tb
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1440367797640784351=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1440367797640784351==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AgN+ZPg/bfE="; charset=UTF-8

--AgN+ZPg/bfE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos=2E

Hello plaisthos,=


I'd like you to do a code review=2E
Please visit

    http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1889?usp=3Demail

to review the following change=2E
=


Change subject: win: don't use NULL DACL with system objects
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

win: don't use NULL DACL =
with system objects

The netsh semaphore used a NULL DACL, which allowed an=
y user on a shared
system to block openvpn from running=2E Instances would =
time out and shut
down=2E

Similar with the --service exit event=2E Any use=
r could signal it and shut
down the instance if the event name is known or =
can be retrieved from
the running process=2E

To prevent both, the objects =
are created with a DACL which allows access
to the creating user only=2E In=
 case of the netsh semaphore this means that
only the first user running op=
envpn can run more instances=2E Other
accounts doing so will error out=2E T=
he interactive service can be used to
prevent this from happening, since th=
e netsh semaphore is only used when
the openvpn process runs privileged ope=
rations directly=2E

Github: OpenVPN/openvpn-private-issues#167
CVE: 2026-8=
2312
Reported-By: DEBRAJ BASAK <https://in=2Elinkedin=2Ecom/in/debrajbasak>=

Change-Id: I787a7067f6ff040c6a1f43f384321bddf5efc97b
Signed-off-by: Heiko =
Hund <heiko@ist=2Eeigentlich=2Enet>
---
M src/openvpn/win32=2Ec
M src/openv=
pn/win32=2Eh
2 files changed, 107 insertions(+), 3 deletions(-)



  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/1889/1

diff =
--git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index 44b010d=2E=2Edd=
88a22 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -35=
,6 +35,8 @@
 
 #include <minwindef=2Eh>
 #include <winsock2=2Eh>
+#include =
<accctrl=2Eh>
+#include <aclapi=2Eh>
 
 #include "buffer=2Eh"
 #include "er=
ror=2Eh"
@@ -146,6 +148,13 @@
     pause_exit_enabled =3D true;
 }
 
+/**
+=
 * @brief Initializes security attributes with a NULL DACL, allowing
+ *   =
     unrestricted access to the resulting object=2E
+ *
+ * @param obj Secu=
rity attributes structure to initialize=2E
+ * @return true on success, fal=
se otherwise=2E
+ */
 bool
 init_security_attributes_allow_all(struct secur=
ity_attributes *obj)
 {
@@ -165,6 +174,93 @@
     return true;
 }
 
+/**
+ =
* @brief Initializes security attributes with a DACL restricted to the
+ * =
       current process user=2E
+ *
+ * The resulting DACL grants GENERIC_AL=
L access to the calling user only,
+ * so the created object cannot be open=
ed, signaled or otherwise accessed
+ * by other users on the system=2E The =
allocated DACL must be released with
+ * free_security_attributes() once th=
e security attributes are no longer
+ * needed=2E
+ *
+ * @param obj Securi=
ty attributes structure to initialize=2E
+ * @return true on success, false=
 otherwise=2E
+ */
+static bool
+init_security_attributes_allow_user(struct=
 security_attributes *obj)
+{
+    bool ret =3D false;
+
+    CLEAR(*obj);
=
+    obj->sa=2EnLength =3D sizeof(SECURITY_ATTRIBUTES);
+    obj->sa=2ElpSe=
curityDescriptor =3D &obj->sd;
+    obj->sa=2EbInheritHandle =3D FALSE;
+
+=
    if (!InitializeSecurityDescriptor(&obj->sd, SECURITY_DESCRIPTOR_REVISIO=
N))
+    {
+        return ret;
+    }
+
+    HANDLE token =3D NULL;
+    i=
f (!OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, &token))
+    {
+   =
     return ret;
+    }
+
+    PTOKEN_USER info =3D NULL;
+    DWORD info_l=
en =3D 0;
+    if (!GetTokenInformation(token, TokenUser, info, info_len, &=
info_len)
+        && GetLastError() !=3D ERROR_INSUFFICIENT_BUFFER)
+    {=

+        goto out;
+    }
+
+    info =3D malloc(info_len);
+    if (!info=
 || !GetTokenInformation(token, TokenUser, info, info_len, &info_len))
+   =
 {
+        goto out;
+    }
+
+    EXPLICIT_ACCESS ea =3D { 0 };
+    ea=
=2EgrfAccessPermissions =3D GENERIC_ALL;
+    ea=2EgrfAccessMode =3D SET_AC=
CESS;
+    ea=2EgrfInheritance =3D NO_INHERITANCE;
+    ea=2ETrustee=2ETrus=
teeForm =3D TRUSTEE_IS_SID;
+    ea=2ETrustee=2ETrusteeType =3D TRUSTEE_IS_=
USER;
+    ea=2ETrustee=2EptstrName =3D (LPTSTR)info->User=2ESid;
+
+    if=
 (SetEntriesInAcl(1, &ea, NULL, &obj->dacl) !=3D ERROR_SUCCESS)
+    {
+   =
     goto out;
+    }
+
+    if (SetSecurityDescriptorDacl(&obj->sd, TRUE, =
obj->dacl, FALSE))
+    {
+        ret =3D true;
+    }
+
+out:
+    free(i=
nfo);
+    CloseHandle(token);
+    return ret;
+}
+
+/**
+ * @brief Releas=
es resources allocated by init_security_attributes_allow_user()=2E
+ *
+ * =
@param obj Security attributes structure to release=2E
+ */
+static void
+f=
ree_security_attributes(struct security_attributes *obj)
+{
+    if (obj->d=
acl)
+    {
+        LocalFree(obj->dacl);
+        obj->dacl =3D NULL;
+  =
  }
+}
+
 void
 overlapped_io_init(struct overlapped_io *o, const struct fr=
ame *frame, BOOL event_state)
 {
@@ -504,7 +600,7 @@
         struct gc_are=
na gc =3D gc_new();
         const wchar_t *exit_event_nameW =3D wide_strin=
g(exit_event_name, &gc);
 
-        if (!init_security_attributes_allow_all=
(&sa))
+        if (!init_security_attributes_allow_user(&sa))
         {
 =
            msg(M_ERR, "Error: win32_signal_open: init SA failed");
       =
  }
@@ -526,6 +622,7 @@
                 ws->mode =3D WSO_MODE_SERVICE;
   =
          }
         }
+        free_security_attributes(&sa);
         gc_=
free(&gc);
     }
     /* set the ctrl handler in both console and service =
modes */
@@ -751,14 +848,15 @@
     s->name =3D name;
     s->hand =3D NULL=
;
 
-    if (init_security_attributes_allow_all(&sa))
+    if (init_securit=
y_attributes_allow_user(&sa))
     {
         s->hand =3D CreateSemaphore(&=
sa=2Esa, 1, 1, name);
     }
+    free_security_attributes(&sa);
 
     if =
(s->hand =3D=3D NULL)
     {
-        msg(M_WARN | M_ERRNO, "WARNING: Canno=
t create Win32 semaphore '%s'", name);
+        msg(M_ERR, "Cannot create W=
in32 semaphore '%s'", name);
     }
     else
     {
diff --git a/src/openv=
pn/win32=2Eh b/src/openvpn/win32=2Eh
index ef32062=2E=2E8be3d96 100644
--- =
a/src/openvpn/win32=2Eh
+++ b/src/openvpn/win32=2Eh
@@ -63,6 +63,7 @@
 {
  =
   SECURITY_ATTRIBUTES sa;
     SECURITY_DESCRIPTOR sd;
+    PACL dacl;
 };=

 
 #define HANDLE_DEFINED(h) ((h) !=3D NULL && (h) !=3D INVALID_HANDLE_VAL=
UE)
@@ -262,6 +263,11 @@
  *
  * It seems you can't run more than one insta=
nce
  * of netsh on the same machine at the same time=2E
+ *
+ * Its DACL i=
s restricted to the creating user to prevent an unprivileged
+ * local user=
 from starving it and DoS'ing running instances=2E This means
+ * different=
 user accounts running OpenVPN directly, not via the interactive
+ * servic=
e, will make all but the first user's instances exit=2E
  */
 
 extern stru=
ct semaphore netcmd_semaphore;

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1889?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I787a7067f6ff040c6a1f43f384321bddf5efc97b
Gerrit-Change-Number=
: 1889
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Ger=
rit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: d12fk <heiko@openvpn=2Enet>

--AgN+ZPg/bfE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos=2E </p>
<p>cron2 would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1889?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">win: don&#39;t use NULL DACL with system objects<br><br>The netsh sema=
phore used a NULL DACL, which allowed any user on a shared<br>system to blo=
ck openvpn from running=2E Instances would time out and shut<br>down=2E<br>=
<br>Similar with the --service exit event=2E Any user could signal it and s=
hut<br>down the instance if the event name is known or can be retrieved fro=
m<br>the running process=2E<br><br>To prevent both, the objects are created=
 with a DACL which allows access<br>to the creating user only=2E In case of=
 the netsh semaphore this means that<br>only the first user running openvpn=
 can run more instances=2E Other<br>accounts doing so will error out=2E The=
 interactive service can be used to<br>prevent this from happening, since t=
he netsh semaphore is only used when<br>the openvpn process runs privileged=
 operations directly=2E<br><br>Github: OpenVPN/openvpn-private-issues#167<b=
r>CVE: 2026-82312<br>Reported-By: DEBRAJ BASAK &lt;https://in=2Elinkedin=2E=
com/in/debrajbasak&gt;<br>Change-Id: I787a7067f6ff040c6a1f43f384321bddf5efc=
97b<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>--=
-<br>M src/openvpn/win32=2Ec<br>M src/openvpn/win32=2Eh<br>2 files changed,=
 107 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/1889/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index=
 44b010d=2E=2Edd88a22 100644</span><br><span>--- a/src/openvpn/win32=2Ec</s=
pan><br><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -35,6 +35,8 @@=
</span><br><span> </span><br><span> #include &lt;minwindef=2Eh&gt;</span><b=
r><span> #include &lt;winsock2=2Eh&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &lt;accctrl=2Eh&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &lt;aclapi=2Eh&gt;</span><br><span> </=
span><br><span> #include &quot;buffer=2Eh&quot;</span><br><span> #include &=
quot;error=2Eh&quot;</span><br><span>@@ -146,6 +148,13 @@</span><br><span> =
    pause_exit_enabled =3D true;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @brief Initializes security attributes=
 with a NULL DACL, allowing</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *        unrestricted access to the resulting object=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param obj Security attributes structure to =
initialize=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn true on success, false otherwise=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span> bool</span><br><span> init_securi=
ty_attributes_allow_all(struct security_attributes *obj)</span><br><span> {=
</span><br><span>@@ -165,6 +174,93 @@</span><br><span>     return true;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @brief Initializes security attributes with a DACL restricted to the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        current process=
 user=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * The resulting DACL grants=
 GENERIC_ALL access to the calling user only,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * so the created object cannot be opened, signal=
ed or otherwise accessed</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * by other users on the system=2E The allocated DACL must be released=
 with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * free_securi=
ty_attributes() once the security attributes are no longer</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * needed=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param obj Security attributes structure to initialize=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true =
on success, false otherwise=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_security=
_attributes_allow_user(struct security_attributes *obj)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    CLEAR(*obj);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    obj-&gt;sa=2EnLength =3D sizeof(SECURITY_ATTRIBUTES);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    obj-&gt;sa=2ElpSecurityDescriptor=
 =3D &amp;obj-&gt;sd;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    obj-&gt;sa=2EbInheritHandle =3D FALSE;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!InitializeSecurityDescriptor(&amp;obj-&gt;sd, SECURITY_DESCR=
IPTOR_REVISION))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return re=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    HANDLE token =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!OpenProcessToken(GetCurrentProce=
ss(), TOKEN_QUERY, &amp;token))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    PTOKEN_USER info =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD info_len =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!GetTokenI=
nformation(token, TokenUser, info, info_len, &amp;info_len)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; GetLastError() !=
=3D ERROR_INSUFFICIENT_BUFFER)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    info =3D malloc(info_len);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!info || !GetTokenI=
nformation(token, TokenUser, info, info_len, &amp;info_len))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EXPL=
ICIT_ACCESS ea =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ea=2EgrfAccessPermissions =3D GENERIC_ALL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ea=2EgrfAccessMode =3D SET_ACCESS;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ea=2EgrfInheritanc=
e =3D NO_INHERITANCE;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ea=2ETrustee=2ETrusteeForm =3D TRUSTEE_IS_SID;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ea=2ETrustee=2ETrusteeType =3D TRUSTE=
E_IS_USER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ea=2E=
Trustee=2EptstrName =3D (LPTSTR)info-&gt;User=2ESid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (SetEntriesInAcl(1, &amp;ea, NULL, &amp;obj-&gt;dacl)=
 !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto =
out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (SetSecurityDescriptorDacl(&amp;obj-&gt;s=
d, TRUE, obj-&gt;dacl, FALSE))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     ret =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    free(info);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    CloseHandle(token);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Releases resources al=
located by init_security_attributes_allow_user()=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param obj Security attributes structure to release=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+free_security_attributes(struct security_att=
ributes *obj)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (obj-&gt;dacl)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        LocalFree(obj-&gt;dacl);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        obj-&gt;dacl =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> o=
verlapped_io_init(struct overlapped_io *o, const struct frame *frame, BOOL =
event_state)</span><br><span> {</span><br><span>@@ -504,7 +600,7 @@</span><=
br><span>         struct gc_arena gc =3D gc_new();</span><br><span>        =
 const wchar_t *exit_event_nameW =3D wide_string(exit_event_name, &amp;gc);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (!init_security_attributes_allow_all(&amp;sa))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (!init_security_attributes_al=
low_user(&amp;sa))</span><br><span>         {</span><br><span>             =
msg(M_ERR, &quot;Error: win32_signal_open: init SA failed&quot;);</span><br=
><span>         }</span><br><span>@@ -526,6 +622,7 @@</span><br><span>     =
            ws-&gt;mode =3D WSO_MODE_SERVICE;</span><br><span>             =
}</span><br><span>         }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        free_security_attributes(&amp;sa);</span><br><span>       =
  gc_free(&amp;gc);</span><br><span>     }</span><br><span>     /* set the =
ctrl handler in both console and service modes */</span><br><span>@@ -751,1=
4 +848,15 @@</span><br><span>     s-&gt;name =3D name;</span><br><span>    =
 s-&gt;hand =3D NULL;</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (init_security_attributes_allow_all(&amp;sa))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (init_security_at=
tributes_allow_user(&amp;sa))</span><br><span>     {</span><br><span>      =
   s-&gt;hand =3D CreateSemaphore(&amp;sa=2Esa, 1, 1, name);</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_se=
curity_attributes(&amp;sa);</span><br><span> </span><br><span>     if (s-&g=
t;hand =3D=3D NULL)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        msg(M_WARN | M_ERRNO, &quot;WARNING: Cannot cr=
eate Win32 semaphore &#39;%s&#39;&quot;, name);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_ERR, &quot;Cannot create Win32 se=
maphore &#39;%s&#39;&quot;, name);</span><br><span>     }</span><br><span> =
    else</span><br><span>     {</span><br><span>diff --git a/src/openvpn/wi=
n32=2Eh b/src/openvpn/win32=2Eh</span><br><span>index ef32062=2E=2E8be3d96 =
100644</span><br><span>--- a/src/openvpn/win32=2Eh</span><br><span>+++ b/sr=
c/openvpn/win32=2Eh</span><br><span>@@ -63,6 +63,7 @@</span><br><span> {</s=
pan><br><span>     SECURITY_ATTRIBUTES sa;</span><br><span>     SECURITY_DE=
SCRIPTOR sd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PAC=
L dacl;</span><br><span> };</span><br><span> </span><br><span> #define HAND=
LE_DEFINED(h) ((h) !=3D NULL &amp;&amp; (h) !=3D INVALID_HANDLE_VALUE)</spa=
n><br><span>@@ -262,6 +263,11 @@</span><br><span>  *</span><br><span>  * It=
 seems you can&#39;t run more than one instance</span><br><span>  * of nets=
h on the same machine at the same time=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Its DACL is restricted to the creating user to prevent an unprivile=
ged</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * local user fr=
om starving it and DoS&#39;ing running instances=2E This means</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * different user accounts runni=
ng OpenVPN directly, not via the interactive</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * service, will make all but the first user&#39;s=
 instances exit=2E</span><br><span>  */</span><br><span> </span><br><span> =
extern struct semaphore netcmd_semaphore;</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1889=
?usp=3Demail">change 1889</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1889?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I787a7067f6ff040c6a1f43f384321bddf5efc97b </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1889 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-=
Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@openvpn=2Enet&gt=
; </div>

</body></html>
--AgN+ZPg/bfE=--


--===============1440367797640784351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1440367797640784351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1440367797640784351==--

