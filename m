Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB57CCA48B
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5xiFRxTPTeFj413ZIEoux9Syvz2jr+5Aulqv/8+Hzos=; b=FTkGRjsSIhJvTJ9TJMyG+X/oPy
	uAtW70EiZrI7jUN6x1RoxsTGSoV66f+udj/K/Jnd+5Ux57RdCRmttttEcLlhZq6BPdOQ1m+5u4ggD
	/n1hEbSwZhvdlKt2GOqtCV4DJhlCWLlsbasvRzJwgvCQXNLATfx+vOJ8EeglTWU0pgAM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHfTO-0007RA-NR;
	Fri, 16 Oct 2026 10:47:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHfTN-0007R2-Fv
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 10:47:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=t497lrv3oa9hFDqd4L1/6HvYGnTCRDfdqaPflMHlIoA=; b=c8+oDvUlTqTSUjV07owilqqAVF
 EsACT1SzyLqlo7pXr9kxXT3lWnkUv0jrqu66Y/J2wHhi4jRZxKqjhLY/N/Y3kZ+xo29tLN2f2rYaw
 9yoWUBiW0wu3aqp96bYqzBbwTO6q8tFqZPCUj9nhf9ZKM0NgtEV0fkvW1iC+ZIP604UM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=t497lrv3oa9hFDqd4L1/6HvYGnTCRDfdqaPflMHlIoA=; b=K
 Okbvv6vnjjUDK+Y3r3ppsgZrJbStqJcX3DU48R2QU2suAK1oQ5M1gCF82kI9oX3j5lZaR7+zs0kyL
 HwKEeW6H5GTjvgStuQYk7DzgZRX7rzax7YZEky3cZfDBAe1smdjIIbdhkyhiINt9oDt5/FFzEiAPG
 ulFSAsRfaop9BypU=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHfTL-000474-7b for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 10:47:38 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so30113175e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 16 Oct 2026 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792147649; x=1792752449; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t497lrv3oa9hFDqd4L1/6HvYGnTCRDfdqaPflMHlIoA=;
 b=FkkxDg61f+cb6P8sF1e/nINXmhX5B92Jd7J9V33GGNPMQg0E/Bx44aMmZioOfRF+Bf
 x9zNXkhW2fiNAoWNQ9vaoVv3uL7AsP2MNZb4+PmdSl0iADuzM/4N1jYnoWHoFTay3CRB
 8lwU70Z3kxOUQk03TzuJeWzLKSfPRlQ3DczXovgptBIrcQWDTiu9cNXWTpWtMYf/ZUPi
 KhPjhiqUGoxbTn65GC1BUbhVddOoPun4ikXk3yuh27SMrNgO9WNljkxz8a2OP+FpwTY/
 +QbgqE3St34IuDPEj/4xkw0BYx3zVrX5pdDaOj5w2/jffAWrjV4Opk6SyD47abzkYkk1
 uIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792147649; x=1792752449;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=t497lrv3oa9hFDqd4L1/6HvYGnTCRDfdqaPflMHlIoA=;
 b=hDaqXyGMa6/ELfzMRgEBiFsoMGDrP46vtv0TZQlmOTuZJ8AQZ8GS0gNDzOL3ZCOfwc
 CpJxRjj1fOHBKlYIYy30+d6znYK3C0zbLMoA2j19fNQu63/N2wRN+yX1eAQ4FaOUSRMv
 dqkiLILt9QnpedXMDqUuys1vVWZZ1mv5/Vk9lBh/ae/ttcxmcjqi+vUjis+dvSJFaRTv
 UN0Oz2YeiIpb2DLOOstzVd5OGzZHKXqKkKrL+K04fsMj8JFcCiFTkM0SIPSHU/E3SjPK
 E2SWa3i679hlfM738zPvJoHeguS6TFHQEKXJfP5gbkAzbOZe3M0OQnVl2Su3oKa7RdMv
 ZCOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPfAXEt/kop/mJpPrGGnuRyfskQcXcGMKjngYu9KlRYW+YUOKCDyYhfTUV3XtZ+3Quke29EdnMoURFFm+a@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK9otBpqd6z2Y6cqZ9Woh7EmnnURl+9jLh7aj9xPplfFBpUzkJA
 M9Ze3YhdXE3Ch5Ea/YqB2BjwjqmIWcU9yBstXYCeCSyyWHJpsDI8TYjELIRyIAapzODuX7ene/7
 uHRr+I9i541UKROg5qX8p6Lk1+L4VkkNFJXDn343sKg/uWLiwUaNrDasnZNBO7Gx/04fG
X-Gm-Gg: AYBFou1u/giYusYzYP/wW+Z449RF/glv65lp1UXlf5s57as4yjT8spNAeHgofE+YF3u
 wW4nuZghIoNW522LKsHsJwmY+nLR4stFbVfTkM1kZ30L5JEcanI4zdGjf6COuEbZQbGLg2ZKesM
 deEauu8Lnad7hEPUj6ZyDdsKcvJT8RwtWa/qVvMaG80umK95G0IHRil+/vxRw1FidXiZmODI5yQ
 4+Bih37K/S/T2df87Z72utDX2MqBLVENgSNwwL62WDC5zmn66y3LhUaOtGkq1I1mksnni+LXKuL
 FiSJWvDYAuf6HhuS9UH+Oi0jFcNIGXhJaT51UfbmpixgmHUAt+tnUF9Jl3Z/YK4kf6HJEuZZSBz
 PxfM91JYGe83i93TFJfP/hBjEgOhPpnIeJybm1MviIrOF5Me1hxLpD+HpWNDyl5R57iW6mbhWzR
 ESn/crB45QNnpxbgswJAK3z97mDVWcSRIh567ZnAwfXhSglM79benyK+qgXCh4egMZkVwnWjpTj
 +bW/yy4ZHV3xYZpMoKWs1c/O6R5aUbXlXfn+T2qz6q3ZCxC/wvGSjQd0XxXpfnE5uFAYzPPSxnE
 IZM8/1bok4Lpuuu/BPBDv4fvyHNs7R8SJgDDrAGzcJjIXcuTXTQZU9k4Scwk/XnkyfASMS8=
X-Received: by 2002:a05:600c:620e:b0:4a1:7c56:d4e2 with SMTP id
 5b1f17b1804b1-4a18e4b2aebmr462503075e9.16.1792147647240; 
 Fri, 16 Oct 2026 03:47:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c10fe9d3sm116554695e9.13.2026.10.16.03.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 03:47:26 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 16 Oct 2026 10:47:26 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2
X-Gerrit-Change-Number: 1993
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1993?usp=email>
X-Gerrit-Commit: 39665ae0965b6a34bd902de864fe41ff23fadce5
In-Reply-To: <gerrit.1791901394000.I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2@gerrit.openvpn.net>
References: <gerrit.1791901394000.I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk1ZWU1OTdmYjNiOWVmYjkzZGJlMTk0NThhZTZlNzU4MGQyN2FlM2QyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <38d0e0f5c04ccf285f9cc7c32e5c0a18281181b0-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHfTL-000474-7b
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5709948031031474171=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5709948031031474171==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UCMwFAxpB18="; charset=UTF-8

--UCMwFAxpB18=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1993?usp=3Demail )

Change subject: Review usage of strncpy
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Review usage of =
strncpy

- Some users were re-creating strcpynt
- Some users should have us=
ed strcpynt since they
  were not handling truncation at all
- Some users w=
ere actually using it like memcpy
  and so should have used that

Partly ba=
sed on a commit by Alejandro
Pacheco <alepacheco99@gmail=2Ecom>=2E

Change-=
Id: I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2
Signed-off-by: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993
Message-Id=
: <20261016084828=2E26818-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39918=2Ehtml
Sig=
ned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/dns=2E=
c
M src/openvpn/manage=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/networking_=
sitnl=2Ec
M src/openvpn/options=2Ec
M src/openvpn/ps=2Ec
M src/openvpn/rout=
e=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/ssl_verify=2Ec
M src/open=
vpn/tun=2Ec
M src/openvpnserv/interactive=2Ec
M tests/unit_tests/openvpn/te=
st_auth_token=2Ec
M tests/unit_tests/openvpn/test_user_pass=2Ec
13 files ch=
anged, 19 insertions(+), 34 deletions(-)




diff --git a/src/openvpn/dns=
=2Ec b/src/openvpn/dns=2Ec
index 7f4dde4=2E=2E713f41e 100644
--- a/src/open=
vpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -110,7 +110,7 @@
         {
      =
       return false;
         }
-        strncpy(addrcopy, addr, copylen);
=
+        memcpy(addrcopy, addr, copylen);
         addr =3D addrcopy;
     =
}
 
@@ -391,7 +391,7 @@
         {
             *(dst + offset++) =3D '=2E'=
;
         }
-        strncpy(dst + offset, src->name, len);
+        memcp=
y(dst + offset, src->name, len);
         offset +=3D len;
 
         src =
=3D src->next;
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec=

index 1e74f09=2E=2Ee15d7bd 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/o=
penvpn/manage=2Ec
@@ -2374,7 +2374,7 @@
     }
     struct user_pass up;
  =
   CLEAR(up);
-    strncpy(up=2Eusername, msg, sizeof(up=2Eusername) - 1);
=
+    strncpynt(up=2Eusername, msg, sizeof(up=2Eusername));
 
     managemen=
t_query_user_pass(management, &up, command, GET_USER_PASS_NEED_OK, (void *)=
0);
     return strcmp("ok", up=2Epassword) =3D=3D 0;
diff --git a/src/open=
vpn/misc=2Ec b/src/openvpn/misc=2Ec
index 6e9591f=2E=2E0e4669a 100644
--- a=
/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -303,7 +303,7 @@
 
    =
             if (password_buf[0])
                 {
-                    s=
trncpy(up->password, password_buf, USER_PASS_LEN);
+                    str=
ncpynt(up->password, password_buf, USER_PASS_LEN);
                 }
     =
            else
                 {
@@ -452,7 +452,7 @@
         /* Use tag=
 for blank password if we are not prompting for one */
         if (flags &=
 GET_USER_PASS_USERNAME_ONLY)
         {
-            strncpy(up->password,=
 blank_up, sizeof(up->password));
+            strncpynt(up->password, blan=
k_up, sizeof(up->password));
         }
 
         string_mod(up->username,=
 CC_PRINT, CC_CRLF, 0);
diff --git a/src/openvpn/networking_sitnl=2Ec b/src=
/openvpn/networking_sitnl=2Ec
index 49de664=2E=2Ef9596a5 100644
--- a/src/o=
penvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -602,=
7 +602,7 @@
 
     /* save result in output variables */
     memcpy(best_g=
w, &res=2Egw, res=2Eaddr_size);
-    strncpy(best_iface, res=2Eiface, IFNAM=
SIZ);
+    strncpynt(best_iface, res=2Eiface, IFNAMSIZ);
 err:
     return =
ret;
 }
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
inde=
x e7585ad=2E=2E7fc8614 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openv=
pn/options=2Ec
@@ -6310,12 +6310,12 @@
     else if (streq(p[0], "override-=
username") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_INSTAN=
CE);
-        if (strlen(p[1]) > USER_PASS_LEN)
+        if (strlen(p[1]) >=
=3D USER_PASS_LEN)
         {
             msg(msglevel,
                 "=
override-username exceeds the maximum length of %d "
                 "char=
acters",
-                USER_PASS_LEN);
+                USER_PASS_LEN - =
1);
 
             /* disable the connection since ignoring the request to
=
              * set another username might cause serious problems */
diff -=
-git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index 2679c4d5=2E=2E3ba983f =
100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -75,17 +75,6 @@=

     char *jfn;
 };
 
-#if 0
-static const char *
-headc(const struct buff=
er *buf)
-{
-    static char foo[16];
-    strncpy(foo, BSTR(buf), 15);
-  =
  foo[15] =3D 0;
-    return foo;
-}
-#endif
-
 static inline void
 close_s=
ocket_if_defined(const socket_descriptor_t sd)
 {
diff --git a/src/openvpn/=
route=2Ec b/src/openvpn/route=2Ec
index 4830a5b=2E=2E9c80f3b 100644
--- a/s=
rc/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -2970,8 +2970,7 @@
 
  =
   if (msg=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)
     {
-      =
  strncpy(msg=2Eiface=2Ename, tt->actual_name, sizeof(msg=2Eiface=2Ename));=

-        msg=2Eiface=2Ename[sizeof(msg=2Eiface=2Ename) - 1] =3D '\0';
+   =
     strncpynt(msg=2Eiface=2Ename, tt->actual_name, sizeof(msg=2Eiface=2Ena=
me));
     }
 
     status =3D do_route_service(add, &msg, sizeof(msg), tt-=
>options=2Emsg_channel);
@@ -3749,7 +3748,7 @@
         {
             rgi-=
>gateway=2Eaddr =3D ntohl(((struct sockaddr_in *)route=2Egateway)->sin_addr=
=2Es_addr);
             rgi->flags =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFINE=
D;
-            strncpy(rgi->iface, interface->ifr_name, sizeof(rgi->iface)=
);
+            strncpynt(rgi->iface, interface->ifr_name, sizeof(rgi->ifac=
e));
         }
 
         int32 address_size =3D 0;
diff --git a/src/openv=
pn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 7805d43=2E=2Ee0f34cd=
 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec=

@@ -433,7 +433,7 @@
             len - 1);
     }
 
-    strncpy(openssl_c=
iphers, ciphers, len);
+    strncpynt(openssl_ciphers, ciphers, len);
 
   =
  for (size_t i =3D 0; i < strlen(openssl_ciphers); i++)
     {
diff --git =
a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 0acba2b=2E=
=2Ea744e07 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_ve=
rify=2Ec
@@ -1640,7 +1640,7 @@
             "TLS: Replacing client provided=
 username '%s' with "
             "username from override-user '%s'",
    =
         up->username, multi->locked_username);
-        strncpy(up->userna=
me, multi->locked_username, sizeof(up->username));
+        strncpynt(up->u=
sername, multi->locked_username, sizeof(up->username));
     }
 
     /*
di=
ff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index f191a6b=2E=2E2c2=
766f 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -127,8 +=
127,7 @@
 
     if (addr=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)
=
     {
-        strncpy(addr=2Eiface=2Ename, tt->actual_name, sizeof(addr=
=2Eiface=2Ename));
-        addr=2Eiface=2Ename[sizeof(addr=2Eiface=2Ename)=
 - 1] =3D '\0';
+        strncpynt(addr=2Eiface=2Ename, tt->actual_name, si=
zeof(addr=2Eiface=2Ename));
     }
 
     if (addr=2Efamily =3D=3D AF_INET)=

@@ -212,7 +211,7 @@
         {
             dns=2Edomains[dstlen++] =3D ',=
';
         }
-        strncpy(dns=2Edomains + dstlen, o->domain_search_lis=
t[i], srclen + 1);
+        memcpy(dns=2Edomains + dstlen, o->domain_search=
_list[i], srclen + 1);
     }
 
     msg(D_LOW, "%s DNS domains on '%s' (if=
_index =3D %lu) using service",
@@ -261,8 +260,7 @@
                       =
        =2Eaddr_len =3D addr_len };
 
     /* interface name is required */=

-    strncpy(dns=2Eiface=2Ename, tt->actual_name, sizeof(dns=2Eiface=2Enam=
e));
-    dns=2Eiface=2Ename[sizeof(dns=2Eiface=2Ename) - 1] =3D '\0';
+   =
 strncpynt(dns=2Eiface=2Ename, tt->actual_name, sizeof(dns=2Eiface=2Ename))=
;
 
     if (addr_len > _countof(dns=2Eaddr))
     {
@@ -326,8 +324,7 @@
  =
                               =2Eaddr_len =3D addr_len };
 
     /* interf=
ace name is required */
-    strncpy(wins=2Eiface=2Ename, tt->actual_name, =
sizeof(wins=2Eiface=2Ename));
-    wins=2Eiface=2Ename[sizeof(wins=2Eiface=
=2Ename) - 1] =3D '\0';
+    strncpynt(wins=2Eiface=2Ename, tt->actual_name=
, sizeof(wins=2Eiface=2Ename));
 
     if (addr_len > _countof(wins=2Eaddr)=
)
     {
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/int=
eractive=2Ec
index d8cf6e1=2E=2Eed163a4 100644
--- a/src/openvpnserv/intera=
ctive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -1810,7 +1810,7 @@
     =
        wide_domains =3D NULL;
             goto out;
         }
-        s=
trncpy(undo_data->itf_name, itf_name, sizeof(undo_data->itf_name));
+      =
  strncpy_s(undo_data->itf_name, sizeof(undo_data->itf_name), itf_name, _TR=
UNCATE);
         undo_data->domains =3D wide_domains;
 
         if (AddDn=
sSearchDomains(list_key, have_list, wide_domains) =3D=3D FALSE
diff --git a=
/tests/unit_tests/openvpn/test_auth_token=2Ec b/tests/unit_tests/openvpn/te=
st_auth_token=2Ec
index 9e7b5b9=2E=2E89c418e 100644
--- a/tests/unit_tests/=
openvpn/test_auth_token=2Ec
+++ b/tests/unit_tests/openvpn/test_auth_token=
=2Ec
@@ -273,7 +273,7 @@
     }
     else if (streq(name, "session_id"))
  =
   {
-        strncpy(last_session_id_value, value, sizeof(last_session_id_=
value));
+        strncpynt(last_session_id_value, value, sizeof(last_sessi=
on_id_value));
     }
 }
 
diff --git a/tests/unit_tests/openvpn/test_user_=
pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec
index 7636a33=2E=2Ec=
8c69bf 100644
--- a/tests/unit_tests/openvpn/test_user_pass=2Ec
+++ b/tests=
/unit_tests/openvpn/test_user_pass=2Ec
@@ -53,7 +53,7 @@
     for (int i =
=3D 0; i < QUERY_USER_NUMSLOTS && query_user[i]=2Eresponse !=3D NULL; i++)
=
     {
         check_expected_ptr(query_user[i]=2Eprompt);
-        strncp=
y(query_user[i]=2Eresponse, mock_ptr_type(char *), query_user[i]=2Eresponse=
_len);
+        strncpynt(query_user[i]=2Eresponse, mock_ptr_type(char *), =
query_user[i]=2Eresponse_len);
     }
 
     return mock();

-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I5ee597fb3b9efb93dbe19458ae6e7580d2=
7ae3d2
Gerrit-Change-Number: 1993
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--UCMwFAxpB18=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1993?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Review usage of strncpy<br><br>- S=
ome users were re-creating strcpynt<br>- Some users should have used strcpy=
nt since they<br>  were not handling truncation at all<br>- Some users were=
 actually using it like memcpy<br>  and so should have used that<br><br>Par=
tly based on a commit by Alejandro<br>Pacheco &lt;alepacheco99@gmail=2Ecom&=
gt;=2E<br><br>Change-Id: I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2<br>Signe=
d-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Ra=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1993<br>Message-Id: &lt;20261016084828=2E26818=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg39918=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dns=2Ec<br=
>M src/openvpn/manage=2Ec<br>M src/openvpn/misc=2Ec<br>M src/openvpn/networ=
king_sitnl=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/ps=2Ec<br>M sr=
c/openvpn/route=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_v=
erify=2Ec<br>M src/openvpn/tun=2Ec<br>M src/openvpnserv/interactive=2Ec<br>=
M tests/unit_tests/openvpn/test_auth_token=2Ec<br>M tests/unit_tests/openvp=
n/test_user_pass=2Ec<br>13 files changed, 19 insertions(+), 34 deletions(-)=
<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec</s=
pan><br><span>index 7f4dde4=2E=2E713f41e 100644</span><br><span>--- a/src/o=
penvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</span><br><span>@@=
 -110,7 +110,7 @@</span><br><span>         {</span><br><span>             r=
eturn false;</span><br><span>         }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        strncpy(addrcopy, addr, copylen);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        memcpy(addrcopy, addr, copy=
len);</span><br><span>         addr =3D addrcopy;</span><br><span>     }</s=
pan><br><span> </span><br><span>@@ -391,7 +391,7 @@</span><br><span>       =
  {</span><br><span>             *(dst + offset++) =3D &#39;=2E&#39;;</span=
><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        strncpy(dst + offset, src-&gt;name, len);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        memcpy(dst + offset, src-&gt;name, le=
n);</span><br><span>         offset +=3D len;</span><br><span> </span><br><=
span>         src =3D src-&gt;next;</span><br><span>diff --git a/src/openvp=
n/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 1e74f09=2E=2Ee1=
5d7bd 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+=
++ b/src/openvpn/manage=2Ec</span><br><span>@@ -2374,7 +2374,7 @@</span><br=
><span>     }</span><br><span>     struct user_pass up;</span><br><span>   =
  CLEAR(up);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strnc=
py(up=2Eusername, msg, sizeof(up=2Eusername) - 1);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    strncpynt(up=2Eusername, msg, sizeof(up=
=2Eusername));</span><br><span> </span><br><span>     management_query_user=
_pass(management, &amp;up, command, GET_USER_PASS_NEED_OK, (void *)0);</spa=
n><br><span>     return strcmp(&quot;ok&quot;, up=2Epassword) =3D=3D 0;</sp=
an><br><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span=
><br><span>index 6e9591f=2E=2E0e4669a 100644</span><br><span>--- a/src/open=
vpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ =
-303,7 +303,7 @@</span><br><span> </span><br><span>                 if (pas=
sword_buf[0])</span><br><span>                 {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    strncpy(up-&gt;password, pas=
sword_buf, USER_PASS_LEN);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    strncpynt(up-&gt;password, password_buf, USER_PA=
SS_LEN);</span><br><span>                 }</span><br><span>               =
  else</span><br><span>                 {</span><br><span>@@ -452,7 +452,7 =
@@</span><br><span>         /* Use tag for blank password if we are not pro=
mpting for one */</span><br><span>         if (flags &amp; GET_USER_PASS_US=
ERNAME_ONLY)</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            strncpy(up-&gt;password, blank_up, sizeof(up-=
&gt;password));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        strncpynt(up-&gt;password, blank_up, sizeof(up-&gt;password));</spa=
n><br><span>         }</span><br><span> </span><br><span>         string_mo=
d(up-&gt;username, CC_PRINT, CC_CRLF, 0);</span><br><span>diff --git a/src/=
openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><=
span>index 49de664=2E=2Ef9596a5 100644</span><br><span>--- a/src/openvpn/ne=
tworking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</=
span><br><span>@@ -602,7 +602,7 @@</span><br><span> </span><br><span>     /=
* save result in output variables */</span><br><span>     memcpy(best_gw, &=
amp;res=2Egw, res=2Eaddr_size);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    strncpy(best_iface, res=2Eiface, IFNAMSIZ);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    strncpynt(best_iface, res=2Eiface=
, IFNAMSIZ);</span><br><span> err:</span><br><span>     return ret;</span><=
br><span> }</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/open=
vpn/options=2Ec</span><br><span>index e7585ad=2E=2E7fc8614 100644</span><br=
><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/opti=
ons=2Ec</span><br><span>@@ -6310,12 +6310,12 @@</span><br><span>     else i=
f (streq(p[0], &quot;override-username&quot;) &amp;&amp; p[1] &amp;&amp; !p=
[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_=
P_INSTANCE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (strlen(p[1]) &gt; USER_PASS_LEN)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (strlen(p[1]) &gt;=3D USER_PASS_LEN)</span><br><=
span>         {</span><br><span>             msg(msglevel,</span><br><span>=
                 &quot;override-username exceeds the maximum length of %d &=
quot;</span><br><span>                 &quot;characters&quot;,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                USER_PASS_LEN);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                USER_P=
ASS_LEN - 1);</span><br><span> </span><br><span>             /* disable the=
 connection since ignoring the request to</span><br><span>              * s=
et another username might cause serious problems */</span><br><span>diff --=
git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index 2679c4d=
5=2E=2E3ba983f 100644</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><s=
pan>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -75,17 +75,6 @@</span><br><=
span>     char *jfn;</span><br><span> };</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if 0</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static const char *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-headc(const struct buffer *buf)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    static char foo[16];</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    strncpy(foo, BSTR(buf), 15);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    foo[15] =3D 0;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return foo;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> sta=
tic inline void</span><br><span> close_socket_if_defined(const socket_descr=
iptor_t sd)</span><br><span> {</span><br><span>diff --git a/src/openvpn/rou=
te=2Ec b/src/openvpn/route=2Ec</span><br><span>index 4830a5b=2E=2E9c80f3b 1=
00644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src=
/openvpn/route=2Ec</span><br><span>@@ -2970,8 +2970,7 @@</span><br><span> <=
/span><br><span>     if (msg=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVAL=
ID)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        strncpy(msg=2Eiface=2Ename, tt-&gt;actual_name, sizeof(msg=2Ei=
face=2Ename));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg=2Eiface=2Ename[sizeof(msg=2Eiface=2Ename) - 1] =3D &#39;\0&#39;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        strncpynt(msg=2Ei=
face=2Ename, tt-&gt;actual_name, sizeof(msg=2Eiface=2Ename));</span><br><sp=
an>     }</span><br><span> </span><br><span>     status =3D do_route_servic=
e(add, &amp;msg, sizeof(msg), tt-&gt;options=2Emsg_channel);</span><br><spa=
n>@@ -3749,7 +3748,7 @@</span><br><span>         {</span><br><span>        =
     rgi-&gt;gateway=2Eaddr =3D ntohl(((struct sockaddr_in *)route=2Egatewa=
y)-&gt;sin_addr=2Es_addr);</span><br><span>             rgi-&gt;flags =3D R=
GI_ADDR_DEFINED | RGI_IFACE_DEFINED;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            strncpy(rgi-&gt;iface, interface-&gt;ifr_name, s=
izeof(rgi-&gt;iface));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            strncpynt(rgi-&gt;iface, interface-&gt;ifr_name, sizeof(rgi-=
&gt;iface));</span><br><span>         }</span><br><span> </span><br><span> =
        int32 address_size =3D 0;</span><br><span>diff --git a/src/openvpn/=
ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index 7805d43=
=2E=2Ee0f34cd 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</spa=
n><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -433,7 +43=
3,7 @@</span><br><span>             len - 1);</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncp=
y(openssl_ciphers, ciphers, len);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    strncpynt(openssl_ciphers, ciphers, len);</span><br><span=
> </span><br><span>     for (size_t i =3D 0; i &lt; strlen(openssl_ciphers)=
; i++)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/ssl_=
verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 0acba2b=2E=2E=
a744e07 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><=
span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -1640,7 +1640,7 @@=
</span><br><span>             &quot;TLS: Replacing client provided username=
 &#39;%s&#39; with &quot;</span><br><span>             &quot;username from =
override-user &#39;%s&#39;&quot;,</span><br><span>             up-&gt;usern=
ame, multi-&gt;locked_username);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        strncpy(up-&gt;username, multi-&gt;locked_username, size=
of(up-&gt;username));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        strncpynt(up-&gt;username, multi-&gt;locked_username, sizeof(up-&=
gt;username));</span><br><span>     }</span><br><span> </span><br><span>   =
  /*</span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec=
</span><br><span>index f191a6b=2E=2E2c2766f 100644</span><br><span>--- a/sr=
c/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span=
>@@ -127,8 +127,7 @@</span><br><span> </span><br><span>     if (addr=2Eifac=
e=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        strncpy(addr=2Eiface=
=2Ename, tt-&gt;actual_name, sizeof(addr=2Eiface=2Ename));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        addr=2Eiface=2Ename[sizeof(add=
r=2Eiface=2Ename) - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        strncpynt(addr=2Eiface=2Ename, tt-&gt;actual_n=
ame, sizeof(addr=2Eiface=2Ename));</span><br><span>     }</span><br><span> =
</span><br><span>     if (addr=2Efamily =3D=3D AF_INET)</span><br><span>@@ =
-212,7 +211,7 @@</span><br><span>         {</span><br><span>             dn=
s=2Edomains[dstlen++] =3D &#39;,&#39;;</span><br><span>         }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        strncpy(dns=2Edomains +=
 dstlen, o-&gt;domain_search_list[i], srclen + 1);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        memcpy(dns=2Edomains + dstlen, o-&gt=
;domain_search_list[i], srclen + 1);</span><br><span>     }</span><br><span=
> </span><br><span>     msg(D_LOW, &quot;%s DNS domains on &#39;%s&#39; (if=
_index =3D %lu) using service&quot;,</span><br><span>@@ -261,8 +260,7 @@</s=
pan><br><span>                               =2Eaddr_len =3D addr_len };</s=
pan><br><span> </span><br><span>     /* interface name is required */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpy(dns=2Eiface=2En=
ame, tt-&gt;actual_name, sizeof(dns=2Eiface=2Ename));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    dns=2Eiface=2Ename[sizeof(dns=2Eiface=
=2Ename) - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    strncpynt(dns=2Eiface=2Ename, tt-&gt;actual_name, sizeof(dn=
s=2Eiface=2Ename));</span><br><span> </span><br><span>     if (addr_len &gt=
; _countof(dns=2Eaddr))</span><br><span>     {</span><br><span>@@ -326,8 +3=
24,7 @@</span><br><span>                                 =2Eaddr_len =3D ad=
dr_len };</span><br><span> </span><br><span>     /* interface name is requi=
red */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpy(win=
s=2Eiface=2Ename, tt-&gt;actual_name, sizeof(wins=2Eiface=2Ename));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    wins=2Eiface=2Ename[sizeo=
f(wins=2Eiface=2Ename) - 1] =3D &#39;\0&#39;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    strncpynt(wins=2Eiface=2Ename, tt-&gt;actual_=
name, sizeof(wins=2Eiface=2Ename));</span><br><span> </span><br><span>     =
if (addr_len &gt; _countof(wins=2Eaddr))</span><br><span>     {</span><br><=
span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interac=
tive=2Ec</span><br><span>index d8cf6e1=2E=2Eed163a4 100644</span><br><span>=
--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv=
/interactive=2Ec</span><br><span>@@ -1810,7 +1810,7 @@</span><br><span>    =
         wide_domains =3D NULL;</span><br><span>             goto out;</spa=
n><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        strncpy(undo_data-&gt;itf_name, itf_name, sizeof(undo_data-&gt;itf=
_name));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        str=
ncpy_s(undo_data-&gt;itf_name, sizeof(undo_data-&gt;itf_name), itf_name, _T=
RUNCATE);</span><br><span>         undo_data-&gt;domains =3D wide_domains;<=
/span><br><span> </span><br><span>         if (AddDnsSearchDomains(list_key=
, have_list, wide_domains) =3D=3D FALSE</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_auth_token=2Ec b/tests/unit_tests/openvpn/test_auth=
_token=2Ec</span><br><span>index 9e7b5b9=2E=2E89c418e 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_auth_token=2Ec</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_auth_token=2Ec</span><br><span>@@ -273,7 +273=
,7 @@</span><br><span>     }</span><br><span>     else if (streq(name, &quo=
t;session_id&quot;))</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        strncpy(last_session_id_value, value, sizeof(=
last_session_id_value));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        strncpynt(last_session_id_value, value, sizeof(last_session_id=
_value));</span><br><span>     }</span><br><span> }</span><br><span> </span=
><br><span>diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests=
/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>index 7636a33=2E=2Ec=
8c69bf 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_user_pass=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec</spa=
n><br><span>@@ -53,7 +53,7 @@</span><br><span>     for (int i =3D 0; i &lt;=
 QUERY_USER_NUMSLOTS &amp;&amp; query_user[i]=2Eresponse !=3D NULL; i++)</s=
pan><br><span>     {</span><br><span>         check_expected_ptr(query_user=
[i]=2Eprompt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 strncpy(query_user[i]=2Eresponse, mock_ptr_type(char *), query_user[i]=2Er=
esponse_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  strncpynt(query_user[i]=2Eresponse, mock_ptr_type(char *), query_user[i]=
=2Eresponse_len);</span><br><span>     }</span><br><span> </span><br><span>=
     return mock();</span><br></pre><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1993?usp=3Demail">change 1993</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ee597fb3b9efb93=
dbe19458ae6e7580d27ae3d2 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1993 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--UCMwFAxpB18=--


--===============5709948031031474171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5709948031031474171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5709948031031474171==--

