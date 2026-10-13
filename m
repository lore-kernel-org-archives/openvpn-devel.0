Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAD2CC6B08
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=zdbyLC9w2xrdZAzDKXkqnWv2K6HDmeGOP5G61SOzAIg=; b=YX7350+A+v0nnS
	EYF8QVGcS5x0xegwoCBrRq1mqcQ8MvzQKdHiSeXh0x16V1cQBRVIRVbTaM1Ea/IqVWjfN/mYF1COt
	mPRsB+m1VUeBYTAcwwQv+mAQ+65Szfp9bgerbXrAX+Hog4y1O9Fj93WgXdZubYFbh6sfKQPlGq0VX
	wxU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGdPn-0001j7-Hn;
	Tue, 13 Oct 2026 14:23:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGdPm-0001j1-Rc
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 14:23:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5EUdsJKgt08jz8Zob89QXiUtLRUrF/NMp74ve5n8u4U=; b=F/42ZNdtegZlnqwZnVQBC20sGP
 PAD/Wmbu92VWa1GE1WMwO94dE9vrn2umpnNH1WmHB9tE5zNjAjqwOTGoWiMmvdpA0wqFfSY2gZtYb
 w8XiZA8fafhMlEg05qEd6/fhrt0rNxzY66lpEuhS9V38g37ib9KfcWO+yWcsYR6P734g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5EUdsJKgt08jz8Zob89QXiUtLRUrF/NMp74ve5n8u4U=; b=e
 YHhfimziT+yyQON5yJtOpTyDNCw9cOJlAmVSsAOXQnDIzMQOYHTDAeqPnvaWjpcByFlebswo3WCmB
 VCbAsLzQ08tr1g9/aJjJ43UoEmpbP1h8Ckeze3AWML8WmZvg5yfXzon6aeC8VQMmiBUyISxot7Mx2
 83+MY5oFpWDKj1co=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGdPi-0001Tp-2B for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 14:23:36 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso2179976f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791901407; x=1792506207; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5EUdsJKgt08jz8Zob89QXiUtLRUrF/NMp74ve5n8u4U=;
 b=PnCAwXr1ToDNPXBLwYVBZHVpbmD2vf8bagOkmR1JpwBBesHTvihzmvG6Ckr9w5e3Vz
 iyp0iGYaYL+pGNelWPkhnXRsw34DtE1HF8MAS2V1painO7OdaWbFVMiRdIiniR0wOAvF
 wtDsp6+Q3OkQJNVTQkSbP3Krea0qY1ZiVECX7j/mc85U/ahv+FEwzH8jWSSjRkZ4Vpvd
 CzLNcFzHHYomiU3yqDxQb0AxjjMjjtzbDh40tLujO0u07piXXZxK4I1EVcXW2SJQh5BM
 T5VaaUU656Vj73em0Y6Yh5Z4U09ygfa6uhCdreqCM2SXIpUd61twqxHfeDjU0BRjoyqR
 a2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791901407; x=1792506207;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5EUdsJKgt08jz8Zob89QXiUtLRUrF/NMp74ve5n8u4U=;
 b=mMA+24KNPAyRDPBwUBHrzpSBXmas8Ix4wClCBIajMgS6hZfYrQ7m9sPDsi6LJvFN+K
 +zmPlDitoT3ezlSkKeNh48SZfpdk7NCVFZlxZe7p1YTgycGfJH8DEmCwEKOtmVL6Zlfi
 SMaLlwlGCN0ofxD1On9i4PDeH9TJFv2RGGo5ybSCYGzLuN5iwwSPfbdgG54O/QwsRMNv
 jCMo03suzVSAeuiR7YGQVBiolyEGuTSP24EpfCGj061Yu8QBLDOfVJqtNXr8IcLhmRP2
 mv1zB3YZ/D97SzkYvcqpQMXLa6M6MdFXghADxwkUM5B3rF6ivG4t0mX2eH5VKB98bMI9
 aj2g==
X-Gm-Message-State: AFq9FYJsGq+PktC2kBwkK0W5cLMYZMImq1Y9xe5Xe0kxpQharS7GEg+Y
 NP/5P6kZEYyb0lXnR3uRtNezCoNlsuIahKAM80dHaHToxBim5E7e5Odrt1oiIu2bSE8oSXID0UL
 /Z1ATiDPt2sva+ZVbX5dZnzHPRFK0ZQjhCnb0+4PsQWeDzAb54S4/dTlyVd4BAuUOcLnq/D9+58
 c7pgenYQ==
X-Gm-Gg: AYBFou2eC3nfPgKEi+/lgo690Scy+U9acb/DYdFllB9hGVVi/DSR1IRuV5AMp21NHbx
 b+T3pUKAK0N/ECvsdHwKNtk56vibJs6SvUhmEWED7MOQlcj0F3E2u7oym9eTbJ+B9Sj6LNEZfUo
 hrs6XzxTVDrgvZU19E2OT+Kf9Ky3yt4m45wg4PKkg+gOaP2ZT678a78OTRaN1KKP19auebdA+uX
 quEb6EByqlO44z9ga+KJFtYtXlJ7Gb908AXxF+grxYCLss6kyxCHNj9TZt7Yynv7rDj/khzSiQa
 IYqzQnt6pIbub7xZCkFE6qVJ6J7sqv7wGqi28+Jw3IfmRoFzbExJ09cJb4wS8RpzWFPffgOQOC2
 +QTASpyhh8I4sFGAwLtggqheygkuZ96YEHRATk/tO9xWshNgAPMXoohdCcO4kw7d4YF1WUCEoDy
 v3GV5YrLcfjbK+2rmROIC9AxmuQIpgQP9GSrkTbEKGZrTxmPW4DGP/xqj3cuQXWS7JmFefcpO/Y
 tld3/TLKFVvTRuMHRLAnmoj14eqEtwWkomo7in2dGk5up+gpcEy74ygLNHkUFox9ddh2aC+STQ5
 FdouICHy2c6yIm9YaBfLsM9WzCUV7C95Aaeppj6Y3SC/86ZfmyYYTHoKqWg2fURZ1DyK0lY=
X-Received: by 2002:a05:600c:548c:b0:4a1:a7f8:c11f with SMTP id
 5b1f17b1804b1-4a1a7f8c1cfmr55384185e9.9.1791901406814; 
 Tue, 13 Oct 2026 07:23:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de3f7f8b8sm3601154f8f.35.2026.10.13.07.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:23:26 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 13 Oct 2026 14:23:25 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2
X-Gerrit-Change-Number: 1993
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1993?usp=email>
X-Gerrit-Commit: 1e3ea6e4c3c6cea0fa18f506ffa28e8e55c2c1ca
References: <gerrit.1791901394000.I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk1ZWU1OTdmYjNiOWVmYjkzZGJlMTk0NThhZTZlNzU4MGQyN2FlM2QyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <25c0b08ad5fa448f3cbe0f98a486cff0314f5b05-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGdPi-0001Tp-2B
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
Content-Type: multipart/mixed; boundary="===============2885453478585795236=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2885453478585795236==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QSrmPgzOZwY="; charset=UTF-8

--QSrmPgzOZwY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1993?usp=3Demail

to review the following change=2E
=


Change subject: Review usage of strncpy
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Review usage of strncpy

- Some users where re=
-creating strcpynt
- Some users should have used strcpynt since they
  were=
 not handling truncation at all
- Some users where actually using it like m=
emcpy
  and so should have used that

Partly based on a commit by Alejandro=

Pacheco <alepacheco99@gmail=2Ecom>=2E

Change-Id: I5ee597fb3b9efb93dbe1945=
8ae6e7580d27ae3d2
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
---
M src/openvpn/dns=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/misc=2Ec=

M src/openvpn/networking_sitnl=2Ec
M src/openvpn/options=2Ec
M src/openvpn=
/ps=2Ec
M src/openvpn/route=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn=
/ssl_verify=2Ec
M src/openvpn/tun=2Ec
M tests/unit_tests/openvpn/test_auth_=
token=2Ec
M tests/unit_tests/openvpn/test_user_pass=2Ec
12 files changed, 1=
8 insertions(+), 33 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/93/1993/1

diff --git a/src/openvpn/dns=2Ec b/s=
rc/openvpn/dns=2Ec
index 7f4dde4=2E=2E713f41e 100644
--- a/src/openvpn/dns=
=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -110,7 +110,7 @@
         {
             =
return false;
         }
-        strncpy(addrcopy, addr, copylen);
+      =
  memcpy(addrcopy, addr, copylen);
         addr =3D addrcopy;
     }
 
@@ =
-391,7 +391,7 @@
         {
             *(dst + offset++) =3D '=2E';
     =
    }
-        strncpy(dst + offset, src->name, len);
+        memcpy(dst +=
 offset, src->name, len);
         offset +=3D len;
 
         src =3D src-=
>next;
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 0=
aef2d4=2E=2E46339be 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/m=
anage=2Ec
@@ -2374,7 +2374,7 @@
     }
     struct user_pass up;
     CLEAR=
(up);
-    strncpy(up=2Eusername, msg, sizeof(up=2Eusername) - 1);
+    str=
cpynt(up=2Eusername, msg, sizeof(up=2Eusername));
 
     management_query_u=
ser_pass(management, &up, command, GET_USER_PASS_NEED_OK, (void *)0);
     =
return strcmp("ok", up=2Epassword) =3D=3D 0;
diff --git a/src/openvpn/misc=
=2Ec b/src/openvpn/misc=2Ec
index 6e9591f=2E=2E0e4669a 100644
--- a/src/ope=
nvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -303,7 +303,7 @@
 
            =
     if (password_buf[0])
                 {
-                    strncpy(u=
p->password, password_buf, USER_PASS_LEN);
+                    strncpynt(u=
p->password, password_buf, USER_PASS_LEN);
                 }
             =
    else
                 {
@@ -452,7 +452,7 @@
         /* Use tag for bla=
nk password if we are not prompting for one */
         if (flags & GET_USE=
R_PASS_USERNAME_ONLY)
         {
-            strncpy(up->password, blank_u=
p, sizeof(up->password));
+            strncpynt(up->password, blank_up, si=
zeof(up->password));
         }
 
         string_mod(up->username, CC_PRIN=
T, CC_CRLF, 0);
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn=
/networking_sitnl=2Ec
index 83915db=2E=2Ed6510bb 100644
--- a/src/openvpn/n=
etworking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -602,7 +602,7=
 @@
 
     /* save result in output variables */
     memcpy(best_gw, &res=
=2Egw, res=2Eaddr_size);
-    strncpy(best_iface, res=2Eiface, IFNAMSIZ);
+=
    strncpynt(best_iface, res=2Eiface, IFNAMSIZ);
 err:
     return ret;
 }=

diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 6664c=
73=2E=2E4385419 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/opti=
ons=2Ec
@@ -6310,12 +6310,12 @@
     else if (streq(p[0], "override-usernam=
e") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_INSTANCE);
- =
       if (strlen(p[1]) > USER_PASS_LEN)
+        if (strlen(p[1]) >=3D USE=
R_PASS_LEN)
         {
             msg(msglevel,
                 "overrid=
e-username exceeds the maximum length of %d "
                 "characters"=
,
-                USER_PASS_LEN);
+                USER_PASS_LEN - 1);
 
 =
            /* disable the connection since ignoring the request to
       =
       * set another username might cause serious problems */
diff --git a/=
src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index 08c2673=2E=2E9a36d12 100644
-=
-- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -75,17 +75,6 @@
     ch=
ar *jfn;
 };
 
-#if 0
-static const char *
-headc(const struct buffer *buf)=

-{
-    static char foo[16];
-    strncpy(foo, BSTR(buf), 15);
-    foo[15=
] =3D 0;
-    return foo;
-}
-#endif
-
 static inline void
 close_socket_if=
_defined(const socket_descriptor_t sd)
 {
diff --git a/src/openvpn/route=2E=
c b/src/openvpn/route=2Ec
index 33b2387=2E=2E9209a76 100644
--- a/src/openv=
pn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -2968,8 +2968,7 @@
 
     if (m=
sg=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)
     {
-        strncp=
y(msg=2Eiface=2Ename, tt->actual_name, sizeof(msg=2Eiface=2Ename));
-      =
  msg=2Eiface=2Ename[sizeof(msg=2Eiface=2Ename) - 1] =3D '\0';
+        str=
ncpynt(msg=2Eiface=2Ename, tt->actual_name, sizeof(msg=2Eiface=2Ename));
  =
   }
 
     status =3D do_route_service(add, &msg, sizeof(msg), tt->options=
=2Emsg_channel);
@@ -3747,7 +3746,7 @@
         {
             rgi->gateway=
=2Eaddr =3D ntohl(((struct sockaddr_in *)route=2Egateway)->sin_addr=2Es_add=
r);
             rgi->flags =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
-    =
        strncpy(rgi->iface, interface->ifr_name, sizeof(rgi->iface));
+    =
        strncpynt(rgi->iface, interface->ifr_name, sizeof(rgi->iface));
   =
      }
 
         int32 address_size =3D 0;
diff --git a/src/openvpn/ssl_o=
penssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 96e90f82=2E=2E02fd556 100644=

--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -43=
3,7 +433,7 @@
             len - 1);
     }
 
-    strncpy(openssl_ciphers,=
 ciphers, len);
+    strncpynt(openssl_ciphers, ciphers, len);
 
     for (=
size_t i =3D 0; i < strlen(openssl_ciphers); i++)
     {
diff --git a/src/o=
penvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 6631718=2E=2E43ed9=
80 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec=

@@ -1640,7 +1640,7 @@
             "TLS: Replacing client provided usernam=
e '%s' with "
             "username from override-user '%s'",
            =
 up->username, multi->locked_username);
-        strncpy(up->username, mult=
i->locked_username, sizeof(up->username));
+        strncpynt(up->username,=
 multi->locked_username, sizeof(up->username));
     }
 
     /*
diff --git=
 a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 133f670=2E=2E9e7e7d7 100=
644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -127,8 +127,7 @@=

 
     if (addr=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)
     {
-=
        strncpy(addr=2Eiface=2Ename, tt->actual_name, sizeof(addr=2Eiface=
=2Ename));
-        addr=2Eiface=2Ename[sizeof(addr=2Eiface=2Ename) - 1] =
=3D '\0';
+        strncpynt(addr=2Eiface=2Ename, tt->actual_name, sizeof(a=
ddr=2Eiface=2Ename));
     }
 
     if (addr=2Efamily =3D=3D AF_INET)
@@ -2=
12,7 +211,7 @@
         {
             dns=2Edomains[dstlen++] =3D ',';
   =
      }
-        strncpy(dns=2Edomains + dstlen, o->domain_search_list[i], =
srclen + 1);
+        memcpy(dns=2Edomains + dstlen, o->domain_search_list[=
i], srclen + 1);
     }
 
     msg(D_LOW, "%s DNS domains on '%s' (if_index=
 =3D %lu) using service",
@@ -261,8 +260,7 @@
                             =
  =2Eaddr_len =3D addr_len };
 
     /* interface name is required */
-    =
strncpy(dns=2Eiface=2Ename, tt->actual_name, sizeof(dns=2Eiface=2Ename));
-=
    dns=2Eiface=2Ename[sizeof(dns=2Eiface=2Ename) - 1] =3D '\0';
+    strnc=
pynt(dns=2Eiface=2Ename, tt->actual_name, sizeof(dns=2Eiface=2Ename));
 
  =
   if (addr_len > _countof(dns=2Eaddr))
     {
@@ -326,8 +324,7 @@
        =
                         =2Eaddr_len =3D addr_len };
 
     /* interface na=
me is required */
-    strncpy(wins=2Eiface=2Ename, tt->actual_name, sizeof=
(wins=2Eiface=2Ename));
-    wins=2Eiface=2Ename[sizeof(wins=2Eiface=2Ename=
) - 1] =3D '\0';
+    strncpynt(wins=2Eiface=2Ename, tt->actual_name, sizeo=
f(wins=2Eiface=2Ename));
 
     if (addr_len > _countof(wins=2Eaddr))
     =
{
diff --git a/tests/unit_tests/openvpn/test_auth_token=2Ec b/tests/unit_te=
sts/openvpn/test_auth_token=2Ec
index 9e7b5b9=2E=2E89c418e 100644
--- a/tes=
ts/unit_tests/openvpn/test_auth_token=2Ec
+++ b/tests/unit_tests/openvpn/te=
st_auth_token=2Ec
@@ -273,7 +273,7 @@
     }
     else if (streq(name, "ses=
sion_id"))
     {
-        strncpy(last_session_id_value, value, sizeof(las=
t_session_id_value));
+        strncpynt(last_session_id_value, value, size=
of(last_session_id_value));
     }
 }
 
diff --git a/tests/unit_tests/openv=
pn/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec
index c=
0a0866=2E=2E5ad4730 100644
--- a/tests/unit_tests/openvpn/test_user_pass=2E=
c
+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec
@@ -53,7 +53,7 @@
     =
for (int i =3D 0; i < QUERY_USER_NUMSLOTS && query_user[i]=2Eresponse !=3D =
NULL; i++)
     {
         check_expected_ptr(query_user[i]=2Eprompt);
-   =
     strncpy(query_user[i]=2Eresponse, mock_ptr_type(char *), query_user[i]=
=2Eresponse_len);
+        strncpynt(query_user[i]=2Eresponse, mock_ptr_typ=
e(char *), query_user[i]=2Eresponse_len);
     }
 
     return mock();

-- =

To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ee597fb3b9efb93dbe1=
9458ae6e7580d27ae3d2
Gerrit-Change-Number: 1993
Gerrit-PatchSet: 1
Gerrit-O=
wner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>

--QSrmPgzOZwY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">Review usage of strncpy<br><br>- Some users where re-creat=
ing strcpynt<br>- Some users should have used strcpynt since they<br>  were=
 not handling truncation at all<br>- Some users where actually using it lik=
e memcpy<br>  and so should have used that<br><br>Partly based on a commit =
by Alejandro<br>Pacheco &lt;alepacheco99@gmail=2Ecom&gt;=2E<br><br>Change-I=
d: I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/dns=2Ec<br>M =
src/openvpn/manage=2Ec<br>M src/openvpn/misc=2Ec<br>M src/openvpn/networkin=
g_sitnl=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/ps=2Ec<br>M src/o=
penvpn/route=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_veri=
fy=2Ec<br>M src/openvpn/tun=2Ec<br>M tests/unit_tests/openvpn/test_auth_tok=
en=2Ec<br>M tests/unit_tests/openvpn/test_user_pass=2Ec<br>12 files changed=
, 18 insertions(+), 33 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/93/1993/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec</span><br><span>index 7f=
4dde4=2E=2E713f41e 100644</span><br><span>--- a/src/openvpn/dns=2Ec</span><=
br><span>+++ b/src/openvpn/dns=2Ec</span><br><span>@@ -110,7 +110,7 @@</spa=
n><br><span>         {</span><br><span>             return false;</span><br=
><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    strncpy(addrcopy, addr, copylen);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        memcpy(addrcopy, addr, copylen);</span><br><span>=
         addr =3D addrcopy;</span><br><span>     }</span><br><span> </span>=
<br><span>@@ -391,7 +391,7 @@</span><br><span>         {</span><br><span>  =
           *(dst + offset++) =3D &#39;=2E&#39;;</span><br><span>         }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpy(dst + =
offset, src-&gt;name, len);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        memcpy(dst + offset, src-&gt;name, len);</span><br><span>  =
       offset +=3D len;</span><br><span> </span><br><span>         src =3D =
src-&gt;next;</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/ope=
nvpn/manage=2Ec</span><br><span>index 0aef2d4=2E=2E46339be 100644</span><br=
><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manag=
e=2Ec</span><br><span>@@ -2374,7 +2374,7 @@</span><br><span>     }</span><b=
r><span>     struct user_pass up;</span><br><span>     CLEAR(up);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    strncpy(up=2Eusername, msg,=
 sizeof(up=2Eusername) - 1);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    strcpynt(up=2Eusername, msg, sizeof(up=2Eusername));</span><br=
><span> </span><br><span>     management_query_user_pass(management, &amp;u=
p, command, GET_USER_PASS_NEED_OK, (void *)0);</span><br><span>     return =
strcmp(&quot;ok&quot;, up=2Epassword) =3D=3D 0;</span><br><span>diff --git =
a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span><br><span>index 6e9591f=
=2E=2E0e4669a 100644</span><br><span>--- a/src/openvpn/misc=2Ec</span><br><=
span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ -303,7 +303,7 @@</span><=
br><span> </span><br><span>                 if (password_buf[0])</span><br>=
<span>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    strncpy(up-&gt;password, password_buf, USER_PASS_LEN=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   strncpynt(up-&gt;password, password_buf, USER_PASS_LEN);</span><br><span=
>                 }</span><br><span>                 else</span><br><span> =
                {</span><br><span>@@ -452,7 +452,7 @@</span><br><span>     =
    /* Use tag for blank password if we are not prompting for one */</span>=
<br><span>         if (flags &amp; GET_USER_PASS_USERNAME_ONLY)</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      strncpy(up-&gt;password, blank_up, sizeof(up-&gt;password));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            strncpynt(up-&gt=
;password, blank_up, sizeof(up-&gt;password));</span><br><span>         }</=
span><br><span> </span><br><span>         string_mod(up-&gt;username, CC_PR=
INT, CC_CRLF, 0);</span><br><span>diff --git a/src/openvpn/networking_sitnl=
=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index 83915db=2E=2E=
d6510bb 100644</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span=
><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -602,7=
 +602,7 @@</span><br><span> </span><br><span>     /* save result in output =
variables */</span><br><span>     memcpy(best_gw, &amp;res=2Egw, res=2Eaddr=
_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpy(be=
st_iface, res=2Eiface, IFNAMSIZ);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    strncpynt(best_iface, res=2Eiface, IFNAMSIZ);</span><br><=
span> err:</span><br><span>     return ret;</span><br><span> }</span><br><s=
pan>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><b=
r><span>index 6664c73=2E=2E4385419 100644</span><br><span>--- a/src/openvpn=
/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>=
@@ -6310,12 +6310,12 @@</span><br><span>     else if (streq(p[0], &quot;ove=
rride-username&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>   =
  {</span><br><span>         VERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (strlen(p[1]) &gt; USE=
R_PASS_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (strlen(p[1]) &gt;=3D USER_PASS_LEN)</span><br><span>         {</span><b=
r><span>             msg(msglevel,</span><br><span>                 &quot;o=
verride-username exceeds the maximum length of %d &quot;</span><br><span>  =
               &quot;characters&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                USER_PASS_LEN);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                USER_PASS_LEN - 1);</span><br>=
<span> </span><br><span>             /* disable the connection since ignori=
ng the request to</span><br><span>              * set another username migh=
t cause serious problems */</span><br><span>diff --git a/src/openvpn/ps=2Ec=
 b/src/openvpn/ps=2Ec</span><br><span>index 08c2673=2E=2E9a36d12 100644</sp=
an><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=
=2Ec</span><br><span>@@ -75,17 +75,6 @@</span><br><span>     char *jfn;</sp=
an><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-headc=
(const struct buffer *buf)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static char=
 foo[16];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpy(=
foo, BSTR(buf), 15);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   foo[15] =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return foo;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline void</span>=
<br><span> close_socket_if_defined(const socket_descriptor_t sd)</span><br>=
<span> {</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/r=
oute=2Ec</span><br><span>index 33b2387=2E=2E9209a76 100644</span><br><span>=
--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</sp=
an><br><span>@@ -2968,8 +2968,7 @@</span><br><span> </span><br><span>     i=
f (msg=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpy(m=
sg=2Eiface=2Ename, tt-&gt;actual_name, sizeof(msg=2Eiface=2Ename));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=2Eiface=2Ename[si=
zeof(msg=2Eiface=2Ename) - 1] =3D &#39;\0&#39;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        strncpynt(msg=2Eiface=2Ename, tt-&gt;ac=
tual_name, sizeof(msg=2Eiface=2Ename));</span><br><span>     }</span><br><s=
pan> </span><br><span>     status =3D do_route_service(add, &amp;msg, sizeo=
f(msg), tt-&gt;options=2Emsg_channel);</span><br><span>@@ -3747,7 +3746,7 @=
@</span><br><span>         {</span><br><span>             rgi-&gt;gateway=
=2Eaddr =3D ntohl(((struct sockaddr_in *)route=2Egateway)-&gt;sin_addr=2Es_=
addr);</span><br><span>             rgi-&gt;flags =3D RGI_ADDR_DEFINED | RG=
I_IFACE_DEFINED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       strncpy(rgi-&gt;iface, interface-&gt;ifr_name, sizeof(rgi-&gt;iface)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            strnc=
pynt(rgi-&gt;iface, interface-&gt;ifr_name, sizeof(rgi-&gt;iface));</span><=
br><span>         }</span><br><span> </span><br><span>         int32 addres=
s_size =3D 0;</span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/sr=
c/openvpn/ssl_openssl=2Ec</span><br><span>index 96e90f82=2E=2E02fd556 10064=
4</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/s=
rc/openvpn/ssl_openssl=2Ec</span><br><span>@@ -433,7 +433,7 @@</span><br><s=
pan>             len - 1);</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpy(openssl_ciphers, =
ciphers, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
trncpynt(openssl_ciphers, ciphers, len);</span><br><span> </span><br><span>=
     for (size_t i =3D 0; i &lt; strlen(openssl_ciphers); i++)</span><br><s=
pan>     {</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/op=
envpn/ssl_verify=2Ec</span><br><span>index 6631718=2E=2E43ed980 100644</spa=
n><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/open=
vpn/ssl_verify=2Ec</span><br><span>@@ -1640,7 +1640,7 @@</span><br><span>  =
           &quot;TLS: Replacing client provided username &#39;%s&#39; with =
&quot;</span><br><span>             &quot;username from override-user &#39;=
%s&#39;&quot;,</span><br><span>             up-&gt;username, multi-&gt;lock=
ed_username);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
strncpy(up-&gt;username, multi-&gt;locked_username, sizeof(up-&gt;username)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strncpynt=
(up-&gt;username, multi-&gt;locked_username, sizeof(up-&gt;username));</spa=
n><br><span>     }</span><br><span> </span><br><span>     /*</span><br><spa=
n>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>in=
dex 133f670=2E=2E9e7e7d7 100644</span><br><span>--- a/src/openvpn/tun=2Ec</=
span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -127,8 +127,7 @=
@</span><br><span> </span><br><span>     if (addr=2Eiface=2Eindex =3D=3D TU=
N_ADAPTER_INDEX_INVALID)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        strncpy(addr=2Eiface=2Ename, tt-&gt;actua=
l_name, sizeof(addr=2Eiface=2Ename));</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        addr=2Eiface=2Ename[sizeof(addr=2Eiface=2Ename) - 1=
] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        strncpynt(addr=2Eiface=2Ename, tt-&gt;actual_name, sizeof(addr=2Eif=
ace=2Ename));</span><br><span>     }</span><br><span> </span><br><span>    =
 if (addr=2Efamily =3D=3D AF_INET)</span><br><span>@@ -212,7 +211,7 @@</spa=
n><br><span>         {</span><br><span>             dns=2Edomains[dstlen++]=
 =3D &#39;,&#39;;</span><br><span>         }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        strncpy(dns=2Edomains + dstlen, o-&gt;domain=
_search_list[i], srclen + 1);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        memcpy(dns=2Edomains + dstlen, o-&gt;domain_search_list[i=
], srclen + 1);</span><br><span>     }</span><br><span> </span><br><span>  =
   msg(D_LOW, &quot;%s DNS domains on &#39;%s&#39; (if_index =3D %lu) using=
 service&quot;,</span><br><span>@@ -261,8 +260,7 @@</span><br><span>       =
                        =2Eaddr_len =3D addr_len };</span><br><span> </span=
><br><span>     /* interface name is required */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    strncpy(dns=2Eiface=2Ename, tt-&gt;actual_na=
me, sizeof(dns=2Eiface=2Ename));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    dns=2Eiface=2Ename[sizeof(dns=2Eiface=2Ename) - 1] =3D &#39;=
\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strncpy=
nt(dns=2Eiface=2Ename, tt-&gt;actual_name, sizeof(dns=2Eiface=2Ename));</sp=
an><br><span> </span><br><span>     if (addr_len &gt; _countof(dns=2Eaddr))=
</span><br><span>     {</span><br><span>@@ -326,8 +324,7 @@</span><br><span=
>                                 =2Eaddr_len =3D addr_len };</span><br><sp=
an> </span><br><span>     /* interface name is required */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    strncpy(wins=2Eiface=2Ename, tt-&g=
t;actual_name, sizeof(wins=2Eiface=2Ename));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    wins=2Eiface=2Ename[sizeof(wins=2Eiface=2Ename) =
- 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    strncpynt(wins=2Eiface=2Ename, tt-&gt;actual_name, sizeof(wins=2Eifa=
ce=2Ename));</span><br><span> </span><br><span>     if (addr_len &gt; _coun=
tof(wins=2Eaddr))</span><br><span>     {</span><br><span>diff --git a/tests=
/unit_tests/openvpn/test_auth_token=2Ec b/tests/unit_tests/openvpn/test_aut=
h_token=2Ec</span><br><span>index 9e7b5b9=2E=2E89c418e 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/test_auth_token=2Ec</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_auth_token=2Ec</span><br><span>@@ -273,7 +27=
3,7 @@</span><br><span>     }</span><br><span>     else if (streq(name, &qu=
ot;session_id&quot;))</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        strncpy(last_session_id_value, value, sizeof=
(last_session_id_value));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        strncpynt(last_session_id_value, value, sizeof(last_session_i=
d_value));</span><br><span>     }</span><br><span> }</span><br><span> </spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/test=
s/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>index c0a0866=2E=2E=
5ad4730 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_user_pas=
s=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec</sp=
an><br><span>@@ -53,7 +53,7 @@</span><br><span>     for (int i =3D 0; i &lt=
; QUERY_USER_NUMSLOTS &amp;&amp; query_user[i]=2Eresponse !=3D NULL; i++)</=
span><br><span>     {</span><br><span>         check_expected_ptr(query_use=
r[i]=2Eprompt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  strncpy(query_user[i]=2Eresponse, mock_ptr_type(char *), query_user[i]=2E=
response_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
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
y:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ee597fb3b9ef=
b93dbe19458ae6e7580d27ae3d2 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1993 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--QSrmPgzOZwY=--


--===============2885453478585795236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2885453478585795236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2885453478585795236==--

