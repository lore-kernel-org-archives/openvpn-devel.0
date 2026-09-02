Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEE3C624D4
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4b01zaS+PTumYMy3hO7GNEEu0msgsPE7/T2jK163Plo=; b=lAFXUyr/gkE+Ci3ewB7TWwJbt9
	I62IJG1wav5oWn81KAcLTSlFRCgXkcf4YtJdx3+cf8Y8e0HfBs+EN+RV5R4CcHPMQkYfJhGXuGbJi
	bf8+EVUywNYDN1QBBexBJ4NSQS2OGynPol3KOFzLsW7Q/9OLgqUIj71aDvLBpkFn5A2A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1fJZ-0003ou-Dv;
	Wed, 02 Sep 2026 07:23:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1fJX-0003om-HT
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 07:23:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MHvmC2YtdHsGE/Rs/ULmH1AJHoGqoddvLUXmcs3B25Q=; b=dxdSdR8A50y5L3fkwxwUGT5PrQ
 BDSQP5vQ4EH+I/qpmehBJibyfBu36MGOdjskrGKfT5kiIVFljrtgS7ftJBKvwnebCpax7UGQKS5iD
 eqks8IA3tZsCPXoB1hptZM2iTH8r7HY8wk9Gkwf0ir3a79Wijh6hANCKg2iEDGYJ1ZvM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MHvmC2YtdHsGE/Rs/ULmH1AJHoGqoddvLUXmcs3B25Q=; b=Q
 GlZgSKK+QMBYy483FjXSsHyeZAdDDbAqrDb94I7lX9Lt/MBPGrwHFncVSaEPhndZNYZNbcln/C1Fo
 TR25fx/wQprNgcsEP5v2QHYpyICpxd4t0ZfvQdMciaAKkFs7IFVw0Df2tUe83GmtrJ+kOZfsPVmNs
 jIsDtjRlYeaxcTwI=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1fJU-0008Gf-RZ for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 07:23:19 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso14569675e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 00:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788333790; x=1788938590; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MHvmC2YtdHsGE/Rs/ULmH1AJHoGqoddvLUXmcs3B25Q=;
 b=VE3noY+ON5xZ39UCZUUDtfEzG5kjpRHZEpD7PSndD5pYm6w1eZqbZYAsP+HjsSn7xD
 ic+72CSGxKduxhzLlzgplDOFSojvnTIeRyCHItKK27ncNRyzF1TFmAANOqsCDedHE/6A
 jAxrdP3OtwrxhDmg9GKRuaMTNuvmTG1UYNh5c97Ro0NtJ6KP/hkoh5uIBb979dFLl5P6
 I36x2wMiYHevYB0Wd4RSG+MeGr3QvMk3tF1HFOxZXttUg2yd2XXjeUCSDywCSTr/4etR
 skMcS+yIHhZWyJPNqerP7N8DTm2ZvaCSqWBjCu7wJAn9iPz5qFo0y6nVPa7VDG/v5zkQ
 watg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788333790; x=1788938590;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MHvmC2YtdHsGE/Rs/ULmH1AJHoGqoddvLUXmcs3B25Q=;
 b=j/MTzc+YxFAo/C+ejFTASlRb08qJUsIkICrPjuSiNbrmxvGP/TthKJV2TnfUnhaT6m
 OQIHM5zi2rDhB7QiVljv/toMRoeMwrAAT0UDCwGVnUSZsJ/8eAJvP45R4nMUOSyIJKv2
 F6XYotoPjakG4ry2UTrp/SWa9ZlLGMHQiS+DSFXddKASMjxO0c+etOINuasNqRN3bbJk
 DYAq5AxCQwe2GmT4vo5zIhdjevXyvbwSJaGh0ShQjDcFt53/BwItDjmJbd+M1AVALML4
 c96wHGOnNtlGLtDtH8OgsPKscdBYuUtFA3GtFE+UPQRkPSicYnxNuILwxlAnrZQiWZ5x
 sSOA==
X-Gm-Message-State: AFuF++kqRtcsUdn/UbEqRHqGBsu7LznieVTS+JuiUzjw5t2Mq4m383j7
 MOsbdV3u09auNEccFKpz3zuad2Nr9tPqsgREPZ8XWUc8TXkZXY2Pk832uuXQOO2bttFIG+dOgQy
 OR0HCuEVLFf1Za+xCQqzHNtQgCod9OmAMrqfYmy/u6yOe6ociwDfB9LlGTwPE3nLXmBTJ
X-Gm-Gg: AR+sD1223HE714Fl/dbA9P6dBqkuvvpq+6ZpDTCANkJO98BkDKzJK1+XMCzoNUzMVTj
 8wBakQ3919UXK2D49xoITRNS1oQorXsgtBxyhfeVm/8iYnnXx/8mVA99bF8h4ONZK00Sw8vYqOw
 T2jQjO2R28uoDX37DSXdU/kur7WETpf6z74I/olsb+Ez6bM7qv8Bn135w1Jdr99wFokxWm/Sp8s
 GnvJdy7gWxfiE8/jE1t9BIaUZp6BAXfo50TqDNbmldCTKSqhnEkk4Becr4/2huQazVXNGyO2AKE
 9DRj501bn86f2L94MMf0jEvmhzbagDan8g7JyqB8ZDArd23X3LqLP4y29mfaHfKl9RgVYY4IojU
 zoctD9NssGIcqNCYFCtnGURMr4JwGTLGeBaEWUGP5iztWpOnfe2i8VOPMP1r3ROlMrhPpwBtBOJ
 ZON+tcyyRDNDXbDmBjO0acn89ZMeMziv5tY9lkSFvBRsFlSB88Yoh7pChHDSmVx8UtC581ci4tE
 RC0ZV1d1D1HHnwv29H/GytXj1LIRjqgPloGss6la4C8kNm3t9M69yL85uiEMFzOAMscjeSoU8HG
 pa8FtN7qbaiy7Crtu0i4wfP81swhV0flcxP5+8Y3i5Sff9XXJk4=
X-Received: by 2002:a05:600c:3485:b0:49b:4eb6:6ffd with SMTP id
 5b1f17b1804b1-49ce7c26ecemr16917275e9.5.1788333790051; 
 Wed, 02 Sep 2026 00:23:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce464aa32sm57883715e9.5.2026.09.02.00.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 00:23:09 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 07:23:08 +0000
To: d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>,
 stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I787a7067f6ff040c6a1f43f384321bddf5efc97b
X-Gerrit-Change-Number: 1889
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1889?usp=email>
X-Gerrit-Commit: 23396ac49bdd390d2e559e74fec16e8763650b78
In-Reply-To: <gerrit.1788282372000.I787a7067f6ff040c6a1f43f384321bddf5efc97b@gerrit.openvpn.net>
References: <gerrit.1788282372000.I787a7067f6ff040c6a1f43f384321bddf5efc97b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MjgyMzcyMDAwLkk3ODdhNzA2N2Y2ZmYwNDBjNmExZjQzZjM4NDMyMWJkZGY1ZWZjOTdiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4cb710f5c8210ad263509063cdbdabb663ca4abf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1fJU-0008Gf-RZ
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5313163283561203974=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5313163283561203974==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1wy7nTtAk50="; charset=UTF-8

--1wy7nTtAk50=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello d12fk, plaisthos, stipa, 

I'd like you to reexamine a change=2E Plea=
se visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1889?usp=3Demail

t=
o look at the new patch set (#2)=2E

The following approvals got outdated a=
nd were removed:
Code-Review+2 by stipa


Change subject: win: don't use NU=
LL DACL with system objects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

win: don't use NULL DACL with system objects

The netsh se=
maphore used a NULL DACL, which allowed any user on a shared
system to bloc=
k openvpn from running=2E Instances would time out and shut
down=2E

Simila=
r with the --service exit event=2E Any user could signal it and shut
down t=
he instance if the event name is known or can be retrieved from
the running=
 process=2E

To prevent both, the objects are created with a DACL which all=
ows access
to the creating user only=2E In case of the netsh semaphore this=
 means that
only the first user running openvpn can run more instances=2E O=
ther
accounts doing so will error out=2E The interactive service can be use=
d to
prevent this from happening, since the netsh semaphore is only used wh=
en
the openvpn process runs privileged operations directly=2E

Github: Open=
VPN/openvpn-private-issues#167
CVE: 2026-82312
Reported-By: DEBRAJ BASAK <h=
ttps://in=2Elinkedin=2Ecom/in/debrajbasak>
Change-Id: I787a7067f6ff040c6a1f=
43f384321bddf5efc97b
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Ene=
t>
Acked-by: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1889
Message-Id: <20260901202854=2E13746-1-ge=
rt@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@=
lists=2Esourceforge=2Enet/msg38886=2Ehtml
Signed-off-by: Gert Doering <gert=
@greenie=2Emuc=2Ede>
---
M src/openvpn/win32=2Ec
M src/openvpn/win32=2Eh
2 =
files changed, 107 insertions(+), 3 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/1889/2

diff --git a/src/ope=
nvpn/win32=2Ec b/src/openvpn/win32=2Ec
index 44b010d=2E=2Edd88a22 100644
--=
- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -35,6 +35,8 @@
 
 =
#include <minwindef=2Eh>
 #include <winsock2=2Eh>
+#include <accctrl=2Eh>
+=
#include <aclapi=2Eh>
 
 #include "buffer=2Eh"
 #include "error=2Eh"
@@ -14=
6,6 +148,13 @@
     pause_exit_enabled =3D true;
 }
 
+/**
+ * @brief Initi=
alizes security attributes with a NULL DACL, allowing
+ *        unrestrict=
ed access to the resulting object=2E
+ *
+ * @param obj Security attributes=
 structure to initialize=2E
+ * @return true on success, false otherwise=2E=

+ */
 bool
 init_security_attributes_allow_all(struct security_attributes =
*obj)
 {
@@ -165,6 +174,93 @@
     return true;
 }
 
+/**
+ * @brief Initia=
lizes security attributes with a DACL restricted to the
+ *        current =
process user=2E
+ *
+ * The resulting DACL grants GENERIC_ALL access to the=
 calling user only,
+ * so the created object cannot be opened, signaled or=
 otherwise accessed
+ * by other users on the system=2E The allocated DACL =
must be released with
+ * free_security_attributes() once the security attr=
ibutes are no longer
+ * needed=2E
+ *
+ * @param obj Security attributes s=
tructure to initialize=2E
+ * @return true on success, false otherwise=2E
+=
 */
+static bool
+init_security_attributes_allow_user(struct security_attri=
butes *obj)
+{
+    bool ret =3D false;
+
+    CLEAR(*obj);
+    obj->sa=2E=
nLength =3D sizeof(SECURITY_ATTRIBUTES);
+    obj->sa=2ElpSecurityDescripto=
r =3D &obj->sd;
+    obj->sa=2EbInheritHandle =3D FALSE;
+
+    if (!Initia=
lizeSecurityDescriptor(&obj->sd, SECURITY_DESCRIPTOR_REVISION))
+    {
+   =
     return ret;
+    }
+
+    HANDLE token =3D NULL;
+    if (!OpenProcess=
Token(GetCurrentProcess(), TOKEN_QUERY, &token))
+    {
+        return ret=
;
+    }
+
+    PTOKEN_USER info =3D NULL;
+    DWORD info_len =3D 0;
+    =
if (!GetTokenInformation(token, TokenUser, info, info_len, &info_len)
+    =
    && GetLastError() !=3D ERROR_INSUFFICIENT_BUFFER)
+    {
+        goto =
out;
+    }
+
+    info =3D malloc(info_len);
+    if (!info || !GetTokenIn=
formation(token, TokenUser, info, info_len, &info_len))
+    {
+        got=
o out;
+    }
+
+    EXPLICIT_ACCESS ea =3D { 0 };
+    ea=2EgrfAccessPermi=
ssions =3D GENERIC_ALL;
+    ea=2EgrfAccessMode =3D SET_ACCESS;
+    ea=2Eg=
rfInheritance =3D NO_INHERITANCE;
+    ea=2ETrustee=2ETrusteeForm =3D TRUST=
EE_IS_SID;
+    ea=2ETrustee=2ETrusteeType =3D TRUSTEE_IS_USER;
+    ea=2ET=
rustee=2EptstrName =3D (LPTSTR)info->User=2ESid;
+
+    if (SetEntriesInAcl=
(1, &ea, NULL, &obj->dacl) !=3D ERROR_SUCCESS)
+    {
+        goto out;
+ =
   }
+
+    if (SetSecurityDescriptorDacl(&obj->sd, TRUE, obj->dacl, FALSE)=
)
+    {
+        ret =3D true;
+    }
+
+out:
+    free(info);
+    CloseH=
andle(token);
+    return ret;
+}
+
+/**
+ * @brief Releases resources allo=
cated by init_security_attributes_allow_user()=2E
+ *
+ * @param obj Securi=
ty attributes structure to release=2E
+ */
+static void
+free_security_attr=
ibutes(struct security_attributes *obj)
+{
+    if (obj->dacl)
+    {
+    =
    LocalFree(obj->dacl);
+        obj->dacl =3D NULL;
+    }
+}
+
 void
 o=
verlapped_io_init(struct overlapped_io *o, const struct frame *frame, BOOL =
event_state)
 {
@@ -504,7 +600,7 @@
         struct gc_arena gc =3D gc_new(=
);
         const wchar_t *exit_event_nameW =3D wide_string(exit_event_name=
, &gc);
 
-        if (!init_security_attributes_allow_all(&sa))
+        i=
f (!init_security_attributes_allow_user(&sa))
         {
             msg(M=
_ERR, "Error: win32_signal_open: init SA failed");
         }
@@ -526,6 +62=
2,7 @@
                 ws->mode =3D WSO_MODE_SERVICE;
             }
     =
    }
+        free_security_attributes(&sa);
         gc_free(&gc);
     }=

     /* set the ctrl handler in both console and service modes */
@@ -751,=
14 +848,15 @@
     s->name =3D name;
     s->hand =3D NULL;
 
-    if (init=
_security_attributes_allow_all(&sa))
+    if (init_security_attributes_allo=
w_user(&sa))
     {
         s->hand =3D CreateSemaphore(&sa=2Esa, 1, 1, na=
me);
     }
+    free_security_attributes(&sa);
 
     if (s->hand =3D=3D N=
ULL)
     {
-        msg(M_WARN | M_ERRNO, "WARNING: Cannot create Win32 se=
maphore '%s'", name);
+        msg(M_ERR, "Cannot create Win32 semaphore '%=
s'", name);
     }
     else
     {
diff --git a/src/openvpn/win32=2Eh b/sr=
c/openvpn/win32=2Eh
index ef32062=2E=2E8be3d96 100644
--- a/src/openvpn/win=
32=2Eh
+++ b/src/openvpn/win32=2Eh
@@ -63,6 +63,7 @@
 {
     SECURITY_ATTRI=
BUTES sa;
     SECURITY_DESCRIPTOR sd;
+    PACL dacl;
 };
 
 #define HANDL=
E_DEFINED(h) ((h) !=3D NULL && (h) !=3D INVALID_HANDLE_VALUE)
@@ -262,6 +26=
3,11 @@
  *
  * It seems you can't run more than one instance
  * of netsh =
on the same machine at the same time=2E
+ *
+ * Its DACL is restricted to t=
he creating user to prevent an unprivileged
+ * local user from starving it=
 and DoS'ing running instances=2E This means
+ * different user accounts ru=
nning OpenVPN directly, not via the interactive
+ * service, will make all =
but the first user's instances exit=2E
  */
 
 extern struct semaphore netc=
md_semaphore;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1889?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I78=
7a7067f6ff040c6a1f43f384321bddf5efc97b
Gerrit-Change-Number: 1889
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gmai=
l=2Ecom>
Gerrit-CC: d12fk <heiko@openvpn=2Enet>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>

--1wy7nTtAk50=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1889?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by stipa</p=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">win: don&#39;t use NULL DACL with system objects<br><br>The =
netsh semaphore used a NULL DACL, which allowed any user on a shared<br>sys=
tem to block openvpn from running=2E Instances would time out and shut<br>d=
own=2E<br><br>Similar with the --service exit event=2E Any user could signa=
l it and shut<br>down the instance if the event name is known or can be ret=
rieved from<br>the running process=2E<br><br>To prevent both, the objects a=
re created with a DACL which allows access<br>to the creating user only=2E =
In case of the netsh semaphore this means that<br>only the first user runni=
ng openvpn can run more instances=2E Other<br>accounts doing so will error =
out=2E The interactive service can be used to<br>prevent this from happenin=
g, since the netsh semaphore is only used when<br>the openvpn process runs =
privileged operations directly=2E<br><br>Github: OpenVPN/openvpn-private-is=
sues#167<br>CVE: 2026-82312<br>Reported-By: DEBRAJ BASAK &lt;https://in=2El=
inkedin=2Ecom/in/debrajbasak&gt;<br>Change-Id: I787a7067f6ff040c6a1f43f3843=
21bddf5efc97b<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet=
&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1889<br>Message-Id: &lt;2026090=
1202854=2E13746-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38886=2Ehtml<br>Sign=
ed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/ope=
nvpn/win32=2Ec<br>M src/openvpn/win32=2Eh<br>2 files changed, 107 insertion=
s(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/89/1889/2</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index 44b010d=2E=2E=
dd88a22 100644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br><span>=
+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -35,6 +35,8 @@</span><br><sp=
an> </span><br><span> #include &lt;minwindef=2Eh&gt;</span><br><span> #incl=
ude &lt;winsock2=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;accctrl=2Eh&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &lt;aclapi=2Eh&gt;</span><br><span> </span><br><span=
> #include &quot;buffer=2Eh&quot;</span><br><span> #include &quot;error=2Eh=
&quot;</span><br><span>@@ -146,6 +148,13 @@</span><br><span>     pause_exit=
_enabled =3D true;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @brief Initializes security attributes with a NULL D=
ACL, allowing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
    unrestricted access to the resulting object=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param obj Security attributes structure to initialize=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on s=
uccess, false otherwise=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span> bool</span><br><span> init_security_attributes_=
allow_all(struct security_attributes *obj)</span><br><span> {</span><br><sp=
an>@@ -165,6 +174,93 @@</span><br><span>     return true;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Initia=
lizes security attributes with a DACL restricted to the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *        current process user=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * The resulting DACL grants GENERIC_ALL =
access to the calling user only,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * so the created object cannot be opened, signaled or otherwi=
se accessed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * by ot=
her users on the system=2E The allocated DACL must be released with</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * free_security_attributes=
() once the security attributes are no longer</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * needed=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param obj Security attributes structure to initialize=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, fals=
e otherwise=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+init_security_attributes_allo=
w_user(struct security_attributes *obj)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*ob=
j);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    obj-&gt;sa=
=2EnLength =3D sizeof(SECURITY_ATTRIBUTES);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    obj-&gt;sa=2ElpSecurityDescriptor =3D &amp;obj-=
&gt;sd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    obj-&gt;=
sa=2EbInheritHandle =3D FALSE;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!InitializeSecurityDescriptor(&amp;obj-&gt;sd, SECURITY_DESCRIPTOR_REVISION=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return ret;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    HANDLE token =3D NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!OpenProcessToken(GetCurrentProcess(), TOKEN_QUER=
Y, &amp;token))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return ret=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    PTOKEN_USER info =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    DWORD info_len =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!GetTokenInformation(token=
, TokenUser, info, info_len, &amp;info_len)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        &amp;&amp; GetLastError() !=3D ERROR_INSUFF=
ICIENT_BUFFER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    info =3D malloc(info_len);</span><br><span style=
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


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I787a7067f6ff040c6a1f43f384321bddf5efc97b </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1889 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2=
 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@openvpn=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--1wy7nTtAk50=--


--===============5313163283561203974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5313163283561203974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5313163283561203974==--

