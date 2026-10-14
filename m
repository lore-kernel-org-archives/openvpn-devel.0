Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD12CC6B2F
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D2pwVgWWH9XPNUcCJRyTgafbowxn2ds+IwCjcsRse1w=; b=YVNHWGB0poQW3ymV0n6FcSUR0C
	pHyFNuC2i7IyNSwSXrdnwnIP5PGszAxksg6IL87IY76bS856EIwjWM+YEUlpm9i5m/gdVsEcOR2k2
	6yoT8YhqZgPWtk7G8xONFpV00K/VKCx7trdoKvl4M/xCjPF8ObLHNIC19rE8RUsrn4b4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGxAZ-000087-It;
	Wed, 14 Oct 2026 11:29:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGxAV-00007y-Ko
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:29:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=94wzJA/J95hFwpb9kgEY2tPsl3hVm8HBwVEdycJhQYY=; b=UzflFd8oovJ2Avf6Pj7Uw61O0J
 tX5g47SqqT0NpfXzQiWApbm/u8NnVoxFQAJGHDnpgotAONsUdEaurv2N9xNPT2V5wpGUbNeWeVqn2
 OC/yNESuRhNL+2Edz6s3O9dJz9/yetVvLGlrR1UsHNobWQDFptyaJAlLNZCglPUzkFsE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=94wzJA/J95hFwpb9kgEY2tPsl3hVm8HBwVEdycJhQYY=; b=S
 77XtUSNPiQy7tjkoLmFEk9ui4YKs7u7sPO6tBpnw0o6OhS6x8RJz+uASriuB6e1/O473ExNLkLSUT
 NHR5SS3bvq+ye44KRNYWJ1DbIHkj+7NlURs2jjfibctyQ5yU+2nwCXhktwWi/YLlOTwW0fYSS/Nv0
 IF9ds/A4/K90Bu5s=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGxAR-0007MF-Q3 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:29:12 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a16af2a232so31548525e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 04:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791977341; x=1792582141; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=94wzJA/J95hFwpb9kgEY2tPsl3hVm8HBwVEdycJhQYY=;
 b=BmQ/x6wTaKvZL3Hd+2tvqk3sLUHjUIAWbIr9hBLv2SaoSm3i5g9fWcbpb2ZKdFgUl9
 RucFysdDd5RaA9Tt3/acANMU7COqkN02vmo2Hht+Lo7Sr/I6wZgLlUah/5m5itKalym9
 c3RYVLsSPcbqbA1YMdIWFkbPGS4c8j9x5c9G1wtAIo/X/ijvqXGjY9MzH/T+qcsftXuI
 VP2iMlkTa4oEAsvR4kJD2PiBCPKbVF1wNK+3WrrI310BV5kHCNS1VYRx12FB8aTzhhGm
 ZvoIOg6dEdpOrb+XJP7T/wQ529zY09aWClusE/yyYo5HjW0uVNIOy+CK/PtLmrV2rUpA
 IE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791977341; x=1792582141;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=94wzJA/J95hFwpb9kgEY2tPsl3hVm8HBwVEdycJhQYY=;
 b=g36TR3Dy9spxatMr3l9BhyOtyERebwtZ2U7Gk0Zo5/z4NQln8Pc2s/WFSxQVU5Cegc
 1H6/bVf8IKo4x+81iAdsQ3GSUpH/Hu0YD4e4E5eWVu3h3X4rzvJtMQ0fcOp10K+N42kU
 zp31RLGRLbA25loQgK70mptMV4uOCk+2yQ5XXY2NA0GfZZdAnT5Awfy7WJPYzhITD8cr
 qw9YNbVN09Z/9XOb985ySRXNAzpdGOeA4tkr8799EQPDcezL+Rd8dl/n/HpBcCIGqSkV
 61esixt3r33a4gLT/dTPU2lwZ3oxIwnX6jJkxSfyJG4tnEjnARsHFo6g/4wDN/84fgi2
 neiQ==
X-Gm-Message-State: AFq9FYJXCxY5r4cRnc7tDxwokPOAGlsakDE5KUMRyVfBZrXjH0oq+JAA
 LMZmxpRiDWoyI/5P3UOjNbD4xeCL10VlKurNwRydKfgUCQWxY45c7BCmpmqqLHau2ebxuV3mHjF
 BsWb7biqnij6hcZmRAvlEm0O5qdzGBSN4UgsQ+mcZjxa0txn11pfN8BFKmPrrZtjh/UoL
X-Gm-Gg: AYBFou113BiKmIlHCvUaT48gnAsJF+NPO8KHMB2AqXU63CnRbTOW3Qao4m8ega1hEQB
 3KFhLSDHicQ0CQ++825TSFBaf8aD5EsQWKsdX+5IsSWb2YI5LTFc1Lb0dm525gdLFqFn4yKyO3Q
 apkAGJ3QmO1yS8m2KnsJVOIA61EsCzbqVD+6aY+CX8lO0Af9KJKa4m7wMlPCv6ZmruN69adeFHY
 jPYyoRZWoctqX3t8GJ63Yh3iy9gQ7SUY+xC7Pgi3rPXEX3xWo5THYZ/zpp31n7U9gN5hosVtPii
 073VtvJLi3jSKskomASHL5VzRlR/Xw795VPTPizxRy5ly+xbWBHf9p4nq2/SL7EAf/KFAfdjmrv
 Yh/Ex22n1nfwuL9rAy7hD5ef/lhgGDkpG7Waj/JLsB7LVo6OVCzrGADP/bq1NR6/7wcMbH/KhFY
 5XlvUewNsqfMQ0mT6k5SjbcKrr/VOVQ10BGViVeInxD6JhEKlCIDGxMUqI+bIP9LvnCuA4I1KIT
 1z2YGXaeOf5BAPnaVrIAkR8XM63eskJuBbcoiogNVinUGO5Y9RJGdHQRBS+dJLxiCbWaactn2kV
 W3C4HlLiTDPGyzVg8DQ3b6Lflu/yjhlS4f3hO5AMHQIjugcWciSOg5yKgcgs
X-Received: by 2002:a05:600c:3e0a:b0:49e:6050:9fbe with SMTP id
 5b1f17b1804b1-4a18e49c52bmr298213575e9.15.1791977340467; 
 Wed, 14 Oct 2026 04:29:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bea0f1csm627937045e9.9.2026.10.14.04.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:29:00 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 11:28:57 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2
X-Gerrit-Change-Number: 1993
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1993?usp=email>
X-Gerrit-Commit: 11b250dbd82023fa9a4f88d55d293046a961600a
In-Reply-To: <gerrit.1791901394000.I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2@gerrit.openvpn.net>
References: <gerrit.1791901394000.I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk1ZWU1OTdmYjNiOWVmYjkzZGJlMTk0NThhZTZlNzU4MGQyN2FlM2QyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <459bf9a2a16257c0c33cc330b7f6580068c1522e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGxAR-0007MF-Q3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Review usage of
 strncpy
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
Content-Type: multipart/mixed; boundary="===============5003105557211125788=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5003105557211125788==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BgW8XoJwE/8="; charset=UTF-8

--BgW8XoJwE/8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1993?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: Review usage of strncpy
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Review usage of strncpy

- Some users wh=
ere re-creating strcpynt
- Some users should have used strcpynt since they
=
  were not handling truncation at all
- Some users where actually using it =
like memcpy
  and so should have used that

Partly based on a commit by Ale=
jandro
Pacheco <alepacheco99@gmail=2Ecom>=2E

Change-Id: I5ee597fb3b9efb93d=
be19458ae6e7580d27ae3d2
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
---
M src/openvpn/dns=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/mi=
sc=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/openvpn/options=2Ec
M src/o=
penvpn/ps=2Ec
M src/openvpn/route=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/o=
penvpn/ssl_verify=2Ec
M src/openvpn/tun=2Ec
M src/openvpnserv/interactive=
=2Ec
M tests/unit_tests/openvpn/test_auth_token=2Ec
M tests/unit_tests/open=
vpn/test_user_pass=2Ec
13 files changed, 19 insertions(+), 34 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/93/199=
3/2

diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index 7f4dde4=
=2E=2E713f41e 100644
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@=
 -110,7 +110,7 @@
         {
             return false;
         }
-       =
 strncpy(addrcopy, addr, copylen);
+        memcpy(addrcopy, addr, copylen)=
;
         addr =3D addrcopy;
     }
 
@@ -391,7 +391,7 @@
         {
     =
        *(dst + offset++) =3D '=2E';
         }
-        strncpy(dst + offs=
et, src->name, len);
+        memcpy(dst + offset, src->name, len);
       =
  offset +=3D len;
 
         src =3D src->next;
diff --git a/src/openvpn/m=
anage=2Ec b/src/openvpn/manage=2Ec
index 0aef2d4=2E=2E55e8105 100644
--- a/=
src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2374,7 +2374,7 @@
 =
    }
     struct user_pass up;
     CLEAR(up);
-    strncpy(up=2Eusername,=
 msg, sizeof(up=2Eusername) - 1);
+    strncpynt(up=2Eusername, msg, sizeof=
(up=2Eusername));
 
     management_query_user_pass(management, &up, comman=
d, GET_USER_PASS_NEED_OK, (void *)0);
     return strcmp("ok", up=2Epasswor=
d) =3D=3D 0;
diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec
index=
 6e9591f=2E=2E0e4669a 100644
--- a/src/openvpn/misc=2Ec
+++ b/src/openvpn/m=
isc=2Ec
@@ -303,7 +303,7 @@
 
                 if (password_buf[0])
       =
          {
-                    strncpy(up->password, password_buf, USER_P=
ASS_LEN);
+                    strncpynt(up->password, password_buf, USER_P=
ASS_LEN);
                 }
                 else
                 {
@@ -4=
52,7 +452,7 @@
         /* Use tag for blank password if we are not prompti=
ng for one */
         if (flags & GET_USER_PASS_USERNAME_ONLY)
         {
=
-            strncpy(up->password, blank_up, sizeof(up->password));
+      =
      strncpynt(up->password, blank_up, sizeof(up->password));
         }
 =

         string_mod(up->username, CC_PRINT, CC_CRLF, 0);
diff --git a/src/=
openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index 83915=
db=2E=2Ed6510bb 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/ope=
nvpn/networking_sitnl=2Ec
@@ -602,7 +602,7 @@
 
     /* save result in outp=
ut variables */
     memcpy(best_gw, &res=2Egw, res=2Eaddr_size);
-    strn=
cpy(best_iface, res=2Eiface, IFNAMSIZ);
+    strncpynt(best_iface, res=2Eif=
ace, IFNAMSIZ);
 err:
     return ret;
 }
diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec
index 6664c73=2E=2E4385419 100644
--- a/src/=
openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -6310,12 +6310,12 @@
 =
    else if (streq(p[0], "override-username") && p[1] && !p[2])
     {
    =
     VERIFY_PERMISSION(OPT_P_INSTANCE);
-        if (strlen(p[1]) > USER_PA=
SS_LEN)
+        if (strlen(p[1]) >=3D USER_PASS_LEN)
         {
          =
   msg(msglevel,
                 "override-username exceeds the maximum le=
ngth of %d "
                 "characters",
-                USER_PASS_LEN)=
;
+                USER_PASS_LEN - 1);
 
             /* disable the connec=
tion since ignoring the request to
              * set another username mig=
ht cause serious problems */
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/=
ps=2Ec
index 08c2673=2E=2E9a36d12 100644
--- a/src/openvpn/ps=2Ec
+++ b/src=
/openvpn/ps=2Ec
@@ -75,17 +75,6 @@
     char *jfn;
 };
 
-#if 0
-static con=
st char *
-headc(const struct buffer *buf)
-{
-    static char foo[16];
-  =
  strncpy(foo, BSTR(buf), 15);
-    foo[15] =3D 0;
-    return foo;
-}
-#en=
dif
-
 static inline void
 close_socket_if_defined(const socket_descriptor_=
t sd)
 {
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 3=
3b2387=2E=2E9209a76 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/ro=
ute=2Ec
@@ -2968,8 +2968,7 @@
 
     if (msg=2Eiface=2Eindex =3D=3D TUN_ADA=
PTER_INDEX_INVALID)
     {
-        strncpy(msg=2Eiface=2Ename, tt->actual_=
name, sizeof(msg=2Eiface=2Ename));
-        msg=2Eiface=2Ename[sizeof(msg=
=2Eiface=2Ename) - 1] =3D '\0';
+        strncpynt(msg=2Eiface=2Ename, tt->=
actual_name, sizeof(msg=2Eiface=2Ename));
     }
 
     status =3D do_route=
_service(add, &msg, sizeof(msg), tt->options=2Emsg_channel);
@@ -3747,7 +37=
46,7 @@
         {
             rgi->gateway=2Eaddr =3D ntohl(((struct sock=
addr_in *)route=2Egateway)->sin_addr=2Es_addr);
             rgi->flags =3D=
 RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
-            strncpy(rgi->iface, int=
erface->ifr_name, sizeof(rgi->iface));
+            strncpynt(rgi->iface, i=
nterface->ifr_name, sizeof(rgi->iface));
         }
 
         int32 addres=
s_size =3D 0;
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_op=
enssl=2Ec
index 96e90f82=2E=2E02fd556 100644
--- a/src/openvpn/ssl_openssl=
=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -433,7 +433,7 @@
             len=
 - 1);
     }
 
-    strncpy(openssl_ciphers, ciphers, len);
+    strncpynt=
(openssl_ciphers, ciphers, len);
 
     for (size_t i =3D 0; i < strlen(ope=
nssl_ciphers); i++)
     {
diff --git a/src/openvpn/ssl_verify=2Ec b/src/op=
envpn/ssl_verify=2Ec
index 6631718=2E=2E43ed980 100644
--- a/src/openvpn/ss=
l_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1640,7 +1640,7 @@
       =
      "TLS: Replacing client provided username '%s' with "
             "us=
ername from override-user '%s'",
             up->username, multi->locked_u=
sername);
-        strncpy(up->username, multi->locked_username, sizeof(up-=
>username));
+        strncpynt(up->username, multi->locked_username, sizeo=
f(up->username));
     }
 
     /*
diff --git a/src/openvpn/tun=2Ec b/src/o=
penvpn/tun=2Ec
index 133f670=2E=2E9e7e7d7 100644
--- a/src/openvpn/tun=2Ec
=
+++ b/src/openvpn/tun=2Ec
@@ -127,8 +127,7 @@
 
     if (addr=2Eiface=2Eind=
ex =3D=3D TUN_ADAPTER_INDEX_INVALID)
     {
-        strncpy(addr=2Eiface=
=2Ename, tt->actual_name, sizeof(addr=2Eiface=2Ename));
-        addr=2Eifa=
ce=2Ename[sizeof(addr=2Eiface=2Ename) - 1] =3D '\0';
+        strncpynt(add=
r=2Eiface=2Ename, tt->actual_name, sizeof(addr=2Eiface=2Ename));
     }
 
 =
    if (addr=2Efamily =3D=3D AF_INET)
@@ -212,7 +211,7 @@
         {
      =
       dns=2Edomains[dstlen++] =3D ',';
         }
-        strncpy(dns=2Ed=
omains + dstlen, o->domain_search_list[i], srclen + 1);
+        memcpy(dns=
=2Edomains + dstlen, o->domain_search_list[i], srclen + 1);
     }
 
     m=
sg(D_LOW, "%s DNS domains on '%s' (if_index =3D %lu) using service",
@@ -26=
1,8 +260,7 @@
                               =2Eaddr_len =3D addr_len };
 
=
     /* interface name is required */
-    strncpy(dns=2Eiface=2Ename, tt->=
actual_name, sizeof(dns=2Eiface=2Ename));
-    dns=2Eiface=2Ename[sizeof(dn=
s=2Eiface=2Ename) - 1] =3D '\0';
+    strncpynt(dns=2Eiface=2Ename, tt->act=
ual_name, sizeof(dns=2Eiface=2Ename));
 
     if (addr_len > _countof(dns=
=2Eaddr))
     {
@@ -326,8 +324,7 @@
                                 =2Ead=
dr_len =3D addr_len };
 
     /* interface name is required */
-    strncpy=
(wins=2Eiface=2Ename, tt->actual_name, sizeof(wins=2Eiface=2Ename));
-    w=
ins=2Eiface=2Ename[sizeof(wins=2Eiface=2Ename) - 1] =3D '\0';
+    strncpyn=
t(wins=2Eiface=2Ename, tt->actual_name, sizeof(wins=2Eiface=2Ename));
 
   =
  if (addr_len > _countof(wins=2Eaddr))
     {
diff --git a/src/openvpnserv=
/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 9a68bbb=2E=2E33151=
cb 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/inter=
active=2Ec
@@ -1810,7 +1810,7 @@
             wide_domains =3D NULL;
      =
       goto out;
         }
-        strncpy(undo_data->itf_name, itf_name,=
 sizeof(undo_data->itf_name));
+        strncpy_s(undo_data->itf_name, size=
of(undo_data->itf_name), itf_name, _TRUNCATE);
         undo_data->domains =
=3D wide_domains;
 
         if (AddDnsSearchDomains(list_key, have_list, w=
ide_domains) =3D=3D FALSE
diff --git a/tests/unit_tests/openvpn/test_auth_t=
oken=2Ec b/tests/unit_tests/openvpn/test_auth_token=2Ec
index 9e7b5b9=2E=2E=
89c418e 100644
--- a/tests/unit_tests/openvpn/test_auth_token=2Ec
+++ b/tes=
ts/unit_tests/openvpn/test_auth_token=2Ec
@@ -273,7 +273,7 @@
     }
     e=
lse if (streq(name, "session_id"))
     {
-        strncpy(last_session_id_=
value, value, sizeof(last_session_id_value));
+        strncpynt(last_sessi=
on_id_value, value, sizeof(last_session_id_value));
     }
 }
 
diff --git =
a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/unit_tests/openvpn/te=
st_user_pass=2Ec
index c0a0866=2E=2E5ad4730 100644
--- a/tests/unit_tests/o=
penvpn/test_user_pass=2Ec
+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec=

@@ -53,7 +53,7 @@
     for (int i =3D 0; i < QUERY_USER_NUMSLOTS && query_=
user[i]=2Eresponse !=3D NULL; i++)
     {
         check_expected_ptr(query=
_user[i]=2Eprompt);
-        strncpy(query_user[i]=2Eresponse, mock_ptr_typ=
e(char *), query_user[i]=2Eresponse_len);
+        strncpynt(query_user[i]=
=2Eresponse, mock_ptr_type(char *), query_user[i]=2Eresponse_len);
     }
 =

     return mock();

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1993?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2
Gerrit-Change-Number: 1993
=
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>

--BgW8XoJwE/8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1993?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">Review usage of strncpy<br><br>- Some users where re-creating strcpy=
nt<br>- Some users should have used strcpynt since they<br>  were not handl=
ing truncation at all<br>- Some users where actually using it like memcpy<b=
r>  and so should have used that<br><br>Partly based on a commit by Alejand=
ro<br>Pacheco &lt;alepacheco99@gmail=2Ecom&gt;=2E<br><br>Change-Id: I5ee597=
fb3b9efb93dbe19458ae6e7580d27ae3d2<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/dns=2Ec<br>M src/openvp=
n/manage=2Ec<br>M src/openvpn/misc=2Ec<br>M src/openvpn/networking_sitnl=2E=
c<br>M src/openvpn/options=2Ec<br>M src/openvpn/ps=2Ec<br>M src/openvpn/rou=
te=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>=
M src/openvpn/tun=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M tests/unit_=
tests/openvpn/test_auth_token=2Ec<br>M tests/unit_tests/openvpn/test_user_p=
ass=2Ec<br>13 files changed, 19 insertions(+), 34 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/93/1993/2</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=
=2Ec</span><br><span>index 7f4dde4=2E=2E713f41e 100644</span><br><span>--- =
a/src/openvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</span><br><=
span>@@ -110,7 +110,7 @@</span><br><span>         {</span><br><span>       =
      return false;</span><br><span>         }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        strncpy(addrcopy, addr, copylen);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(addrcopy, add=
r, copylen);</span><br><span>         addr =3D addrcopy;</span><br><span>  =
   }</span><br><span> </span><br><span>@@ -391,7 +391,7 @@</span><br><span>=
         {</span><br><span>             *(dst + offset++) =3D &#39;=2E&#39;=
;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        strncpy(dst + offset, src-&gt;name, len);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        memcpy(dst + offset, src-&gt;n=
ame, len);</span><br><span>         offset +=3D len;</span><br><span> </spa=
n><br><span>         src =3D src-&gt;next;</span><br><span>diff --git a/src=
/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 0aef2d4=
=2E=2E55e8105 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br=
><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -2374,7 +2374,7 @@</=
span><br><span>     }</span><br><span>     struct user_pass up;</span><br><=
span>     CLEAR(up);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   strncpy(up=2Eusername, msg, sizeof(up=2Eusername) - 1);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    strncpynt(up=2Eusername, msg, si=
zeof(up=2Eusername));</span><br><span> </span><br><span>     management_que=
ry_user_pass(management, &amp;up, command, GET_USER_PASS_NEED_OK, (void *)0=
);</span><br><span>     return strcmp(&quot;ok&quot;, up=2Epassword) =3D=3D=
 0;</span><br><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2E=
c</span><br><span>index 6e9591f=2E=2E0e4669a 100644</span><br><span>--- a/s=
rc/openvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><s=
pan>@@ -303,7 +303,7 @@</span><br><span> </span><br><span>                 =
if (password_buf[0])</span><br><span>                 {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    strncpy(up-&gt;passwo=
rd, password_buf, USER_PASS_LEN);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    strncpynt(up-&gt;password, password_buf, =
USER_PASS_LEN);</span><br><span>                 }</span><br><span>        =
         else</span><br><span>                 {</span><br><span>@@ -452,7 =
+452,7 @@</span><br><span>         /* Use tag for blank password if we are =
not prompting for one */</span><br><span>         if (flags &amp; GET_USER_=
PASS_USERNAME_ONLY)</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            strncpy(up-&gt;password, blank_up, siz=
eof(up-&gt;password));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            strncpynt(up-&gt;password, blank_up, sizeof(up-&gt;password)=
);</span><br><span>         }</span><br><span> </span><br><span>         st=
ring_mod(up-&gt;username, CC_PRINT, CC_CRLF, 0);</span><br><span>diff --git=
 a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</spa=
n><br><span>index 83915db=2E=2Ed6510bb 100644</span><br><span>--- a/src/ope=
nvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitn=
l=2Ec</span><br><span>@@ -602,7 +602,7 @@</span><br><span> </span><br><span=
>     /* save result in output variables */</span><br><span>     memcpy(bes=
t_gw, &amp;res=2Egw, res=2Eaddr_size);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    strncpy(best_iface, res=2Eiface, IFNAMSIZ);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    strncpynt(best_iface, res=
=2Eiface, IFNAMSIZ);</span><br><span> err:</span><br><span>     return ret;=
</span><br><span> }</span><br><span>diff --git a/src/openvpn/options=2Ec b/=
src/openvpn/options=2Ec</span><br><span>index 6664c73=2E=2E4385419 100644</=
span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/open=
vpn/options=2Ec</span><br><span>@@ -6310,12 +6310,12 @@</span><br><span>   =
  else if (streq(p[0], &quot;override-username&quot;) &amp;&amp; p[1] &amp;=
&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISS=
ION(OPT_P_INSTANCE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (strlen(p[1]) &gt; USER_PASS_LEN)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (strlen(p[1]) &gt;=3D USER_PASS_LEN)</sp=
an><br><span>         {</span><br><span>             msg(msglevel,</span><b=
r><span>                 &quot;override-username exceeds the maximum length=
 of %d &quot;</span><br><span>                 &quot;characters&quot;,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                USER_PASS_=
LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  USER_PASS_LEN - 1);</span><br><span> </span><br><span>             /* dis=
able the connection since ignoring the request to</span><br><span>         =
     * set another username might cause serious problems */</span><br><span=
>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index=
 08c2673=2E=2E9a36d12 100644</span><br><span>--- a/src/openvpn/ps=2Ec</span=
><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -75,17 +75,6 @@</spa=
n><br><span>     char *jfn;</span><br><span> };</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if 0</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static const char *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-headc(const struct buffer *buf)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    static char foo[16];</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    strncpy(foo, BSTR(buf), 15);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    foo[15] =3D 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return foo;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> static inline void</span><br><span> close_socket_if_defined(const soc=
ket_descriptor_t sd)</span><br><span> {</span><br><span>diff --git a/src/op=
envpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 33b2387=2E=2E=
9209a76 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>=
+++ b/src/openvpn/route=2Ec</span><br><span>@@ -2968,8 +2968,7 @@</span><br=
><span> </span><br><span>     if (msg=2Eiface=2Eindex =3D=3D TUN_ADAPTER_IN=
DEX_INVALID)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        strncpy(msg=2Eiface=2Ename, tt-&gt;actual_name, sizeo=
f(msg=2Eiface=2Ename));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg=2Eiface=2Ename[sizeof(msg=2Eiface=2Ename) - 1] =3D &#39;\0&#3=
9;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strncpyn=
t(msg=2Eiface=2Ename, tt-&gt;actual_name, sizeof(msg=2Eiface=2Ename));</spa=
n><br><span>     }</span><br><span> </span><br><span>     status =3D do_rou=
te_service(add, &amp;msg, sizeof(msg), tt-&gt;options=2Emsg_channel);</span=
><br><span>@@ -3747,7 +3746,7 @@</span><br><span>         {</span><br><span=
>             rgi-&gt;gateway=2Eaddr =3D ntohl(((struct sockaddr_in *)route=
=2Egateway)-&gt;sin_addr=2Es_addr);</span><br><span>             rgi-&gt;fl=
ags =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            strncpy(rgi-&gt;iface, interface-&gt;if=
r_name, sizeof(rgi-&gt;iface));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            strncpynt(rgi-&gt;iface, interface-&gt;ifr_name, si=
zeof(rgi-&gt;iface));</span><br><span>         }</span><br><span> </span><b=
r><span>         int32 address_size =3D 0;</span><br><span>diff --git a/src=
/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>inde=
x 96e90f82=2E=2E02fd556 100644</span><br><span>--- a/src/openvpn/ssl_openss=
l=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ =
-433,7 +433,7 @@</span><br><span>             len - 1);</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    strncpy(openssl_ciphers, ciphers, len);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    strncpynt(openssl_ciphers, ciphers, len);</span=
><br><span> </span><br><span>     for (size_t i =3D 0; i &lt; strlen(openss=
l_ciphers); i++)</span><br><span>     {</span><br><span>diff --git a/src/op=
envpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 663=
1718=2E=2E43ed980 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</=
span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -1640,7 =
+1640,7 @@</span><br><span>             &quot;TLS: Replacing client provide=
d username &#39;%s&#39; with &quot;</span><br><span>             &quot;user=
name from override-user &#39;%s&#39;&quot;,</span><br><span>             up=
-&gt;username, multi-&gt;locked_username);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        strncpy(up-&gt;username, multi-&gt;locked_user=
name, sizeof(up-&gt;username));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        strncpynt(up-&gt;username, multi-&gt;locked_username, s=
izeof(up-&gt;username));</span><br><span>     }</span><br><span> </span><br=
><span>     /*</span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openv=
pn/tun=2Ec</span><br><span>index 133f670=2E=2E9e7e7d7 100644</span><br><spa=
n>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span=
><br><span>@@ -127,8 +127,7 @@</span><br><span> </span><br><span>     if (a=
ddr=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpy(addr=
=2Eiface=2Ename, tt-&gt;actual_name, sizeof(addr=2Eiface=2Ename));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        addr=2Eiface=2Ename[si=
zeof(addr=2Eiface=2Ename) - 1] =3D &#39;\0&#39;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        strncpynt(addr=2Eiface=2Ename, tt-&gt;=
actual_name, sizeof(addr=2Eiface=2Ename));</span><br><span>     }</span><br=
><span> </span><br><span>     if (addr=2Efamily =3D=3D AF_INET)</span><br><=
span>@@ -212,7 +211,7 @@</span><br><span>         {</span><br><span>       =
      dns=2Edomains[dstlen++] =3D &#39;,&#39;;</span><br><span>         }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpy(dns=2Ed=
omains + dstlen, o-&gt;domain_search_list[i], srclen + 1);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        memcpy(dns=2Edomains + dstle=
n, o-&gt;domain_search_list[i], srclen + 1);</span><br><span>     }</span><=
br><span> </span><br><span>     msg(D_LOW, &quot;%s DNS domains on &#39;%s&=
#39; (if_index =3D %lu) using service&quot;,</span><br><span>@@ -261,8 +260=
,7 @@</span><br><span>                               =2Eaddr_len =3D addr_l=
en };</span><br><span> </span><br><span>     /* interface name is required =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpy(dns=2Ei=
face=2Ename, tt-&gt;actual_name, sizeof(dns=2Eiface=2Ename));</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    dns=2Eiface=2Ename[sizeof(dns=
=2Eiface=2Ename) - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    strncpynt(dns=2Eiface=2Ename, tt-&gt;actual_name, s=
izeof(dns=2Eiface=2Ename));</span><br><span> </span><br><span>     if (addr=
_len &gt; _countof(dns=2Eaddr))</span><br><span>     {</span><br><span>@@ -=
326,8 +324,7 @@</span><br><span>                                 =2Eaddr_le=
n =3D addr_len };</span><br><span> </span><br><span>     /* interface name =
is required */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
ncpy(wins=2Eiface=2Ename, tt-&gt;actual_name, sizeof(wins=2Eiface=2Ename));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wins=2Eiface=2Ena=
me[sizeof(wins=2Eiface=2Ename) - 1] =3D &#39;\0&#39;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    strncpynt(wins=2Eiface=2Ename, tt-&gt=
;actual_name, sizeof(wins=2Eiface=2Ename));</span><br><span> </span><br><sp=
an>     if (addr_len &gt; _countof(wins=2Eaddr))</span><br><span>     {</sp=
an><br><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv=
/interactive=2Ec</span><br><span>index 9a68bbb=2E=2E33151cb 100644</span><b=
r><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/ope=
nvpnserv/interactive=2Ec</span><br><span>@@ -1810,7 +1810,7 @@</span><br><s=
pan>             wide_domains =3D NULL;</span><br><span>             goto o=
ut;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        strncpy(undo_data-&gt;itf_name, itf_name, sizeof(undo_data=
-&gt;itf_name));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     strncpy_s(undo_data-&gt;itf_name, sizeof(undo_data-&gt;itf_name), itf_=
name, _TRUNCATE);</span><br><span>         undo_data-&gt;domains =3D wide_d=
omains;</span><br><span> </span><br><span>         if (AddDnsSearchDomains(=
list_key, have_list, wide_domains) =3D=3D FALSE</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_auth_token=2Ec b/tests/unit_tests/openvpn/t=
est_auth_token=2Ec</span><br><span>index 9e7b5b9=2E=2E89c418e 100644</span>=
<br><span>--- a/tests/unit_tests/openvpn/test_auth_token=2Ec</span><br><spa=
n>+++ b/tests/unit_tests/openvpn/test_auth_token=2Ec</span><br><span>@@ -27=
3,7 +273,7 @@</span><br><span>     }</span><br><span>     else if (streq(na=
me, &quot;session_id&quot;))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        strncpy(last_session_id_value, valu=
e, sizeof(last_session_id_value));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        strncpynt(last_session_id_value, value, sizeof(last_=
session_id_value));</span><br><span>     }</span><br><span> }</span><br><sp=
an> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_user_pass=
=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>index c0=
a0866=2E=2E5ad4730 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_user_pass=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_p=
ass=2Ec</span><br><span>@@ -53,7 +53,7 @@</span><br><span>     for (int i =
=3D 0; i &lt; QUERY_USER_NUMSLOTS &amp;&amp; query_user[i]=2Eresponse !=3D =
NULL; i++)</span><br><span>     {</span><br><span>         check_expected_p=
tr(query_user[i]=2Eprompt);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        strncpy(query_user[i]=2Eresponse, mock_ptr_type(char *), quer=
y_user[i]=2Eresponse_len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        strncpynt(query_user[i]=2Eresponse, mock_ptr_type(char *), q=
uery_user[i]=2Eresponse_len);</span><br><span>     }</span><br><span> </spa=
n><br><span>     return mock();</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993?usp=3Demail">change 199=
3</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 1993 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--BgW8XoJwE/8=--


--===============5003105557211125788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5003105557211125788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5003105557211125788==--

