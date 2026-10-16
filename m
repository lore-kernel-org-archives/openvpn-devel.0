Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98D8CCA464
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jru8xGkmestK21sT+0OqLdPymhcusiIn+T26zUdoB6g=; b=f+kzXp2yB/nWgWbXYDlWwNqyWt
	rCe1sSNfN3Ssi/1H1SxH/mhYmhDIsMsA1VJmdGewfBRD3AYSlCmHNlolhb6gnPuNJRx4vkqI0arh3
	VOkV+0xBcyI7fsYdLLICS9gOfWURA3xborC1BH5P//erdCX0/sMkjVBPDlKssWvy3jjA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHfTQ-0001me-2j;
	Fri, 16 Oct 2026 10:47:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHfTO-0001mX-1m
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 10:47:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=PTqVpOZqTppogNJ+F4U3/fltEkj812Ugnc803lipse4=; b=VlKSGNEtW8R6ZZ9jKxN+nvDIQB
 rkXV6861WnNBPv4unIt8LURtBKZuyxL+BjRqNg1aiX9hXYZ/KJT9iQSwpcBKgg/ce8BIY5QEVx2aj
 ez4A1gG+pLetvqNi3BT2Qhb8W/lYzgB6WAJ4ygQ+BsxnnnRE8kkl3vxCpFjkGQ1fYwAA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PTqVpOZqTppogNJ+F4U3/fltEkj812Ugnc803lipse4=; b=Q
 IT7FYrBWbHmNQZWfrEHUZAkLbSIVcVMX71HJ/nyZDFpSwHkY7Np9f0QQn8Q1rCePsux0DJlFV9tRn
 mkM84taTTnouGTaqJVD+EPhSXIiggQfrkRyF2xNqQtHbsAmUfT7omKqw7xLhBWr7ZVcd1qYEFqTih
 v7khpCc+1ybmfPHA=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHfTJ-000471-4Y for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 10:47:35 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso1307488f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 16 Oct 2026 03:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792147646; x=1792752446; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PTqVpOZqTppogNJ+F4U3/fltEkj812Ugnc803lipse4=;
 b=GRAl+Jt4ObWQl8nKJ/YcJuF4dQdbhYgLm2BnuZaI41jGlw6XQ0FsQJDR8uLqc36/NJ
 +P9Zgx5xX9RQxnosPrDXTRIBPFry6Jpgf3UNchOEk1aLAs38EFdU2zB2vgADAwnV0I2i
 d151BTlptO1p8R+FXeddp8cZckhUgGaYNdpY6f/xLrdgTP/EbZcjOBkKu/CEcXKWcZ7r
 xXDar9Yvy8cm4+WobJ+12lTFxeU5Xdtqkd61WlgW+K5rnOa1UIPo3rX6ckGlLjCs+Moa
 T5yZm0eoScxgfdDKoNvTaAhbarF5F37GcZ7Oq6imVvRv50VBsb5o8YgN/Es0fiMY2rDJ
 gmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792147646; x=1792752446;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PTqVpOZqTppogNJ+F4U3/fltEkj812Ugnc803lipse4=;
 b=TWodd0XCmqEuzBUF3URlyzekYZOzHm/sP9GFDPY472XPHFMtYZmla6H81ebBM/Edtq
 bFJqhU7tRt2DNbKC5uFTkSaNXgiibBQ1CUl4LeDr3MYzDYF7DN8qqZuzSieEgSIGYFqQ
 dBIBzdzSBxKXplLfSkt1sNsxaXef2aAy2QvB/lNCrjILr+JDRJGnOztufcObbTNJg4Ge
 6t2Y5sAGCp7tqW9M6AP2iKK/urlOvOtxGoS28oUfK1WTObKgnK7ZZvU0EEUy/NXU9XIl
 7NwqIQkPr4yrMSbrqj//mHZ7nu31+zyDH1a046A6A1WkZ0NT8lcL+XUH690rQZuEYfkh
 Mrbg==
X-Gm-Message-State: AFq9FYJ06OOXm0Vr79/+fPC8w6w5ldPyy35rLr5kb62kA56HDmKPslRI
 xuYQLTpSBmUB4CSTM1nmO4qfwLfjmDkZ02DkJ+My5Ih726idtRlaLJGLxsE9WzGs3QnT2ZaSGh5
 RUraSPcPpyPY9UR8Q+0dlQkRQdQTnKHov/8GS1qEpFyDe79ZQlGM/bqm2/W9hVIkXHOub
X-Gm-Gg: AYBFou1B0YZhLM3J4wk//Zs9P/6vx/fmtM8jcfcVvpCTjQzHC2yyUcuuUMBRzhwf7jO
 fw0TxUUefwylXcBnODjbLs4hDwd9R2yOVHvNoH1nWWK48qiU8xmJGX74qqw7sstpAs+GYJg5jVO
 CGxw5NqrAGY8XcidMtcjDjd7niSHE38JXTD+lA1Wf/wYSZSvw295okUE6i+SSE462pfwVhbciKf
 YhUVCvt2yoXoCtCLh+BiN3rZ9QcLfKJ6nqGqkghPcoL9/AR88EwzuPLymSWfIGzJ7MRfXRcPh2v
 k0HxfCJ9MkvoAgsQHyyGPuSerM52cK/+8ZLBxfGsBuKgUaW6IZHpwx2bQOwoCPYBPppW72CKLSP
 8cvS24O9cb9hlgOOlw01XxaaqbHGEZ2dpaX0y7MPZr3TvX61Gkq6mQ5Gecm1md3mZmTqgpvCy1C
 oS10TMinFF3+4u/5xpi9AOZPaGnmT96LDFrEF6NpvBSl+TFqEgLqja0rKJ/bcBZyTsM9CLPS1KC
 uM7A3b2vxIWtkyA0uy1ctF7DeA1AtSuovs/EgwndgnKS9oIe5P5Kcbd587SQLle57sDD09RIqE2
 9YvMzhqdRZwrRTwNd7ey4QvfA2UB6umwIMzQ32Cv9fI4q7Q2hVTwuNi9bBmL
X-Received: by 2002:a5d:4b4c:0:b0:48b:f92:1f67 with SMTP id
 ffacd0b85a97d-48dbaae6d3cmr30933361f8f.21.1792147646290; 
 Fri, 16 Oct 2026 03:47:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd5038b8sm4329323f8f.48.2026.10.16.03.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 03:47:25 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 16 Oct 2026 10:47:23 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2
X-Gerrit-Change-Number: 1993
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1993?usp=email>
X-Gerrit-Commit: 39665ae0965b6a34bd902de864fe41ff23fadce5
In-Reply-To: <gerrit.1791901394000.I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2@gerrit.openvpn.net>
References: <gerrit.1791901394000.I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk1ZWU1OTdmYjNiOWVmYjkzZGJlMTk0NThhZTZlNzU4MGQyN2FlM2QyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <38d0e0f5c04ccf285f9cc7c32e5c0a18281181b0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHfTJ-000471-4Y
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5656064603871018807=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5656064603871018807==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IA9jNZAJ2Gk="; charset=UTF-8

--IA9jNZAJ2Gk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
993?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: Review usage of strn=
cpy
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Review =
usage of strncpy

- Some users were re-creating strcpynt
- Some users shoul=
d have used strcpynt since they
  were not handling truncation at all
- Som=
e users were actually using it like memcpy
  and so should have used that

=
Partly based on a commit by Alejandro
Pacheco <alepacheco99@gmail=2Ecom>=2E=


Change-Id: I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2
Signed-off-by: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993
M=
essage-Id: <20261016084828=2E26818-1-gert@greenie=2Emuc=2Ede>
URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39918=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/ope=
nvpn/dns=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/=
networking_sitnl=2Ec
M src/openvpn/options=2Ec
M src/openvpn/ps=2Ec
M src/o=
penvpn/route=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/ssl_verify=2Ec=

M src/openvpn/tun=2Ec
M src/openvpnserv/interactive=2Ec
M tests/unit_tests=
/openvpn/test_auth_token=2Ec
M tests/unit_tests/openvpn/test_user_pass=2Ec
=
13 files changed, 19 insertions(+), 34 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/93/1993/3

diff --git a/src/o=
penvpn/dns=2Ec b/src/openvpn/dns=2Ec
index 7f4dde4=2E=2E713f41e 100644
--- =
a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -110,7 +110,7 @@
       =
  {
             return false;
         }
-        strncpy(addrcopy, addr, =
copylen);
+        memcpy(addrcopy, addr, copylen);
         addr =3D addrc=
opy;
     }
 
@@ -391,7 +391,7 @@
         {
             *(dst + offset++)=
 =3D '=2E';
         }
-        strncpy(dst + offset, src->name, len);
+   =
     memcpy(dst + offset, src->name, len);
         offset +=3D len;
 
    =
     src =3D src->next;
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/m=
anage=2Ec
index 1e74f09=2E=2Ee15d7bd 100644
--- a/src/openvpn/manage=2Ec
++=
+ b/src/openvpn/manage=2Ec
@@ -2374,7 +2374,7 @@
     }
     struct user_pa=
ss up;
     CLEAR(up);
-    strncpy(up=2Eusername, msg, sizeof(up=2Eusernam=
e) - 1);
+    strncpynt(up=2Eusername, msg, sizeof(up=2Eusername));
 
     =
management_query_user_pass(management, &up, command, GET_USER_PASS_NEED_OK,=
 (void *)0);
     return strcmp("ok", up=2Epassword) =3D=3D 0;
diff --git a=
/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec
index 6e9591f=2E=2E0e4669a 100=
644
--- a/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -303,7 +303,7 =
@@
 
                 if (password_buf[0])
                 {
-            =
        strncpy(up->password, password_buf, USER_PASS_LEN);
+              =
      strncpynt(up->password, password_buf, USER_PASS_LEN);
               =
  }
                 else
                 {
@@ -452,7 +452,7 @@
         /=
* Use tag for blank password if we are not prompting for one */
         if=
 (flags & GET_USER_PASS_USERNAME_ONLY)
         {
-            strncpy(up->=
password, blank_up, sizeof(up->password));
+            strncpynt(up->passw=
ord, blank_up, sizeof(up->password));
         }
 
         string_mod(up->=
username, CC_PRINT, CC_CRLF, 0);
diff --git a/src/openvpn/networking_sitnl=
=2Ec b/src/openvpn/networking_sitnl=2Ec
index 49de664=2E=2Ef9596a5 100644
-=
-- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2E=
c
@@ -602,7 +602,7 @@
 
     /* save result in output variables */
     mem=
cpy(best_gw, &res=2Egw, res=2Eaddr_size);
-    strncpy(best_iface, res=2Eif=
ace, IFNAMSIZ);
+    strncpynt(best_iface, res=2Eiface, IFNAMSIZ);
 err:
  =
   return ret;
 }
diff --git a/src/openvpn/options=2Ec b/src/openvpn/option=
s=2Ec
index e7585ad=2E=2E7fc8614 100644
--- a/src/openvpn/options=2Ec
+++ b=
/src/openvpn/options=2Ec
@@ -6310,12 +6310,12 @@
     else if (streq(p[0], =
"override-username") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OP=
T_P_INSTANCE);
-        if (strlen(p[1]) > USER_PASS_LEN)
+        if (strl=
en(p[1]) >=3D USER_PASS_LEN)
         {
             msg(msglevel,
        =
         "override-username exceeds the maximum length of %d "
            =
     "characters",
-                USER_PASS_LEN);
+                USER_P=
ASS_LEN - 1);
 
             /* disable the connection since ignoring the r=
equest to
              * set another username might cause serious problems=
 */
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index 2679c4d5=2E=
=2E3ba983f 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -75,=
17 +75,6 @@
     char *jfn;
 };
 
-#if 0
-static const char *
-headc(const =
struct buffer *buf)
-{
-    static char foo[16];
-    strncpy(foo, BSTR(buf=
), 15);
-    foo[15] =3D 0;
-    return foo;
-}
-#endif
-
 static inline vo=
id
 close_socket_if_defined(const socket_descriptor_t sd)
 {
diff --git a/s=
rc/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 4830a5b=2E=2E9c80f3b 100=
644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -2970,8 +297=
0,7 @@
 
     if (msg=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)
   =
  {
-        strncpy(msg=2Eiface=2Ename, tt->actual_name, sizeof(msg=2Eifac=
e=2Ename));
-        msg=2Eiface=2Ename[sizeof(msg=2Eiface=2Ename) - 1] =3D=
 '\0';
+        strncpynt(msg=2Eiface=2Ename, tt->actual_name, sizeof(msg=
=2Eiface=2Ename));
     }
 
     status =3D do_route_service(add, &msg, siz=
eof(msg), tt->options=2Emsg_channel);
@@ -3749,7 +3748,7 @@
         {
    =
         rgi->gateway=2Eaddr =3D ntohl(((struct sockaddr_in *)route=2Egatew=
ay)->sin_addr=2Es_addr);
             rgi->flags =3D RGI_ADDR_DEFINED | RGI=
_IFACE_DEFINED;
-            strncpy(rgi->iface, interface->ifr_name, sizeo=
f(rgi->iface));
+            strncpynt(rgi->iface, interface->ifr_name, siz=
eof(rgi->iface));
         }
 
         int32 address_size =3D 0;
diff --gi=
t a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 7805d43=
=2E=2Ee0f34cd 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ss=
l_openssl=2Ec
@@ -433,7 +433,7 @@
             len - 1);
     }
 
-    strn=
cpy(openssl_ciphers, ciphers, len);
+    strncpynt(openssl_ciphers, ciphers=
, len);
 
     for (size_t i =3D 0; i < strlen(openssl_ciphers); i++)
     =
{
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
inde=
x 0acba2b=2E=2Ea744e07 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/op=
envpn/ssl_verify=2Ec
@@ -1640,7 +1640,7 @@
             "TLS: Replacing cli=
ent provided username '%s' with "
             "username from override-user=
 '%s'",
             up->username, multi->locked_username);
-        strncp=
y(up->username, multi->locked_username, sizeof(up->username));
+        str=
ncpynt(up->username, multi->locked_username, sizeof(up->username));
     }
=
 
     /*
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index f191=
a6b=2E=2E2c2766f 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec=

@@ -127,8 +127,7 @@
 
     if (addr=2Eiface=2Eindex =3D=3D TUN_ADAPTER_IND=
EX_INVALID)
     {
-        strncpy(addr=2Eiface=2Ename, tt->actual_name, s=
izeof(addr=2Eiface=2Ename));
-        addr=2Eiface=2Ename[sizeof(addr=2Eifa=
ce=2Ename) - 1] =3D '\0';
+        strncpynt(addr=2Eiface=2Ename, tt->actua=
l_name, sizeof(addr=2Eiface=2Ename));
     }
 
     if (addr=2Efamily =3D=
=3D AF_INET)
@@ -212,7 +211,7 @@
         {
             dns=2Edomains[dstl=
en++] =3D ',';
         }
-        strncpy(dns=2Edomains + dstlen, o->domai=
n_search_list[i], srclen + 1);
+        memcpy(dns=2Edomains + dstlen, o->d=
omain_search_list[i], srclen + 1);
     }
 
     msg(D_LOW, "%s DNS domains=
 on '%s' (if_index =3D %lu) using service",
@@ -261,8 +260,7 @@
           =
                    =2Eaddr_len =3D addr_len };
 
     /* interface name is=
 required */
-    strncpy(dns=2Eiface=2Ename, tt->actual_name, sizeof(dns=
=2Eiface=2Ename));
-    dns=2Eiface=2Ename[sizeof(dns=2Eiface=2Ename) - 1] =
=3D '\0';
+    strncpynt(dns=2Eiface=2Ename, tt->actual_name, sizeof(dns=2E=
iface=2Ename));
 
     if (addr_len > _countof(dns=2Eaddr))
     {
@@ -326,=
8 +324,7 @@
                                 =2Eaddr_len =3D addr_len };
 
=
     /* interface name is required */
-    strncpy(wins=2Eiface=2Ename, tt-=
>actual_name, sizeof(wins=2Eiface=2Ename));
-    wins=2Eiface=2Ename[sizeof=
(wins=2Eiface=2Ename) - 1] =3D '\0';
+    strncpynt(wins=2Eiface=2Ename, tt=
->actual_name, sizeof(wins=2Eiface=2Ename));
 
     if (addr_len > _countof=
(wins=2Eaddr))
     {
diff --git a/src/openvpnserv/interactive=2Ec b/src/op=
envpnserv/interactive=2Ec
index d8cf6e1=2E=2Eed163a4 100644
--- a/src/openv=
pnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -1810,7 +18=
10,7 @@
             wide_domains =3D NULL;
             goto out;
        =
 }
-        strncpy(undo_data->itf_name, itf_name, sizeof(undo_data->itf_na=
me));
+        strncpy_s(undo_data->itf_name, sizeof(undo_data->itf_name), =
itf_name, _TRUNCATE);
         undo_data->domains =3D wide_domains;
 
     =
    if (AddDnsSearchDomains(list_key, have_list, wide_domains) =3D=3D FALSE=

diff --git a/tests/unit_tests/openvpn/test_auth_token=2Ec b/tests/unit_tes=
ts/openvpn/test_auth_token=2Ec
index 9e7b5b9=2E=2E89c418e 100644
--- a/test=
s/unit_tests/openvpn/test_auth_token=2Ec
+++ b/tests/unit_tests/openvpn/tes=
t_auth_token=2Ec
@@ -273,7 +273,7 @@
     }
     else if (streq(name, "sess=
ion_id"))
     {
-        strncpy(last_session_id_value, value, sizeof(last=
_session_id_value));
+        strncpynt(last_session_id_value, value, sizeo=
f(last_session_id_value));
     }
 }
 
diff --git a/tests/unit_tests/openvp=
n/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec
index 76=
36a33=2E=2Ec8c69bf 100644
--- a/tests/unit_tests/openvpn/test_user_pass=2Ec=

+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec
@@ -53,7 +53,7 @@
     f=
or (int i =3D 0; i < QUERY_USER_NUMSLOTS && query_user[i]=2Eresponse !=3D N=
ULL; i++)
     {
         check_expected_ptr(query_user[i]=2Eprompt);
-    =
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

Gerrit-MessageType: newpatchset
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ee597fb3b9efb93db=
e19458ae6e7580d27ae3d2
Gerrit-Change-Number: 1993
Gerrit-PatchSet: 3
Gerrit=
-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--IA9jNZAJ2Gk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1993?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Review usage of strncpy<br><br>- Some users were re-creating strcpynt<b=
r>- Some users should have used strcpynt since they<br>  were not handling =
truncation at all<br>- Some users were actually using it like memcpy<br>  a=
nd so should have used that<br><br>Partly based on a commit by Alejandro<br=
>Pacheco &lt;alepacheco99@gmail=2Ecom&gt;=2E<br><br>Change-Id: I5ee597fb3b9=
efb93dbe19458ae6e7580d27ae3d2<br>Signed-off-by: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993<br>Me=
ssage-Id: &lt;20261016084828=2E26818-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g39918=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>M src/openvpn/dns=2Ec<br>M src/openvpn/manage=2Ec<br>M src/open=
vpn/misc=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>M src/openvpn/options=
=2Ec<br>M src/openvpn/ps=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvpn/ss=
l_openssl=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn/tun=2Ec<br>M=
 src/openvpnserv/interactive=2Ec<br>M tests/unit_tests/openvpn/test_auth_to=
ken=2Ec<br>M tests/unit_tests/openvpn/test_user_pass=2Ec<br>13 files change=
d, 19 insertions(+), 34 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/93/1993/3</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec</span><br><span>index 7=
f4dde4=2E=2E713f41e 100644</span><br><span>--- a/src/openvpn/dns=2Ec</span>=
<br><span>+++ b/src/openvpn/dns=2Ec</span><br><span>@@ -110,7 +110,7 @@</sp=
an><br><span>         {</span><br><span>             return false;</span><b=
r><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     strncpy(addrcopy, addr, copylen);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        memcpy(addrcopy, addr, copylen);</span><br><span=
>         addr =3D addrcopy;</span><br><span>     }</span><br><span> </span=
><br><span>@@ -391,7 +391,7 @@</span><br><span>         {</span><br><span> =
            *(dst + offset++) =3D &#39;=2E&#39;;</span><br><span>         }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpy(dst +=
 offset, src-&gt;name, len);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        memcpy(dst + offset, src-&gt;name, len);</span><br><span> =
        offset +=3D len;</span><br><span> </span><br><span>         src =3D=
 src-&gt;next;</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/op=
envpn/manage=2Ec</span><br><span>index 1e74f09=2E=2Ee15d7bd 100644</span><b=
r><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/mana=
ge=2Ec</span><br><span>@@ -2374,7 +2374,7 @@</span><br><span>     }</span><=
br><span>     struct user_pass up;</span><br><span>     CLEAR(up);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    strncpy(up=2Eusername, msg=
, sizeof(up=2Eusername) - 1);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    strncpynt(up=2Eusername, msg, sizeof(up=2Eusername));</span><=
br><span> </span><br><span>     management_query_user_pass(management, &amp=
;up, command, GET_USER_PASS_NEED_OK, (void *)0);</span><br><span>     retur=
n strcmp(&quot;ok&quot;, up=2Epassword) =3D=3D 0;</span><br><span>diff --gi=
t a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span><br><span>index 6e959=
1f=2E=2E0e4669a 100644</span><br><span>--- a/src/openvpn/misc=2Ec</span><br=
><span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ -303,7 +303,7 @@</span=
><br><span> </span><br><span>                 if (password_buf[0])</span><b=
r><span>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    strncpy(up-&gt;password, password_buf, USER_PASS_L=
EN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     strncpynt(up-&gt;password, password_buf, USER_PASS_LEN);</span><br><sp=
an>                 }</span><br><span>                 else</span><br><span=
>                 {</span><br><span>@@ -452,7 +452,7 @@</span><br><span>   =
      /* Use tag for blank password if we are not prompting for one */</spa=
n><br><span>         if (flags &amp; GET_USER_PASS_USERNAME_ONLY)</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        strncpy(up-&gt;password, blank_up, sizeof(up-&gt;password));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            strncpynt(up-&=
gt;password, blank_up, sizeof(up-&gt;password));</span><br><span>         }=
</span><br><span> </span><br><span>         string_mod(up-&gt;username, CC_=
PRINT, CC_CRLF, 0);</span><br><span>diff --git a/src/openvpn/networking_sit=
nl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index 49de664=2E=
=2Ef9596a5 100644</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec</s=
pan><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -60=
2,7 +602,7 @@</span><br><span> </span><br><span>     /* save result in outp=
ut variables */</span><br><span>     memcpy(best_gw, &amp;res=2Egw, res=2Ea=
ddr_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpy=
(best_iface, res=2Eiface, IFNAMSIZ);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    strncpynt(best_iface, res=2Eiface, IFNAMSIZ);</span><b=
r><span> err:</span><br><span>     return ret;</span><br><span> }</span><br=
><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span=
><br><span>index e7585ad=2E=2E7fc8614 100644</span><br><span>--- a/src/open=
vpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><sp=
an>@@ -6310,12 +6310,12 @@</span><br><span>     else if (streq(p[0], &quot;=
override-username&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>=
     {</span><br><span>         VERIFY_PERMISSION(OPT_P_INSTANCE);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (strlen(p[1]) &gt; =
USER_PASS_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (strlen(p[1]) &gt;=3D USER_PASS_LEN)</span><br><span>         {</span=
><br><span>             msg(msglevel,</span><br><span>                 &quo=
t;override-username exceeds the maximum length of %d &quot;</span><br><span=
>                 &quot;characters&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                USER_PASS_LEN);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                USER_PASS_LEN - 1);</span=
><br><span> </span><br><span>             /* disable the connection since i=
gnoring the request to</span><br><span>              * set another username=
 might cause serious problems */</span><br><span>diff --git a/src/openvpn/p=
s=2Ec b/src/openvpn/ps=2Ec</span><br><span>index 2679c4d5=2E=2E3ba983f 1006=
44</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/openv=
pn/ps=2Ec</span><br><span>@@ -75,17 +75,6 @@</span><br><span>     char *jfn=
;</span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if 0</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
headc(const struct buffer *buf)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static=
 char foo[16];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
ncpy(foo, BSTR(buf), 15);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    foo[15] =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return foo;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline void</sp=
an><br><span> close_socket_if_defined(const socket_descriptor_t sd)</span><=
br><span> {</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvp=
n/route=2Ec</span><br><span>index 4830a5b=2E=2E9c80f3b 100644</span><br><sp=
an>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec<=
/span><br><span>@@ -2970,8 +2970,7 @@</span><br><span> </span><br><span>   =
  if (msg=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncp=
y(msg=2Eiface=2Ename, tt-&gt;actual_name, sizeof(msg=2Eiface=2Ename));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=2Eiface=2Ename=
[sizeof(msg=2Eiface=2Ename) - 1] =3D &#39;\0&#39;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        strncpynt(msg=2Eiface=2Ename, tt-&gt=
;actual_name, sizeof(msg=2Eiface=2Ename));</span><br><span>     }</span><br=
><span> </span><br><span>     status =3D do_route_service(add, &amp;msg, si=
zeof(msg), tt-&gt;options=2Emsg_channel);</span><br><span>@@ -3749,7 +3748,=
7 @@</span><br><span>         {</span><br><span>             rgi-&gt;gatewa=
y=2Eaddr =3D ntohl(((struct sockaddr_in *)route=2Egateway)-&gt;sin_addr=2Es=
_addr);</span><br><span>             rgi-&gt;flags =3D RGI_ADDR_DEFINED | R=
GI_IFACE_DEFINED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        strncpy(rgi-&gt;iface, interface-&gt;ifr_name, sizeof(rgi-&gt;iface=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            strn=
cpynt(rgi-&gt;iface, interface-&gt;ifr_name, sizeof(rgi-&gt;iface));</span>=
<br><span>         }</span><br><span> </span><br><span>         int32 addre=
ss_size =3D 0;</span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/s=
rc/openvpn/ssl_openssl=2Ec</span><br><span>index 7805d43=2E=2Ee0f34cd 10064=
4</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/s=
rc/openvpn/ssl_openssl=2Ec</span><br><span>@@ -433,7 +433,7 @@</span><br><s=
pan>             len - 1);</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpy(openssl_ciphers, =
ciphers, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
trncpynt(openssl_ciphers, ciphers, len);</span><br><span> </span><br><span>=
     for (size_t i =3D 0; i &lt; strlen(openssl_ciphers); i++)</span><br><s=
pan>     {</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/op=
envpn/ssl_verify=2Ec</span><br><span>index 0acba2b=2E=2Ea744e07 100644</spa=
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
dex f191a6b=2E=2E2c2766f 100644</span><br><span>--- a/src/openvpn/tun=2Ec</=
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
tof(wins=2Eaddr))</span><br><span>     {</span><br><span>diff --git a/src/o=
penvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><spa=
n>index d8cf6e1=2E=2Eed163a4 100644</span><br><span>--- a/src/openvpnserv/i=
nteractive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span>=
<br><span>@@ -1810,7 +1810,7 @@</span><br><span>             wide_domains =
=3D NULL;</span><br><span>             goto out;</span><br><span>         }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpy(undo_=
data-&gt;itf_name, itf_name, sizeof(undo_data-&gt;itf_name));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        strncpy_s(undo_data-&gt;i=
tf_name, sizeof(undo_data-&gt;itf_name), itf_name, _TRUNCATE);</span><br><s=
pan>         undo_data-&gt;domains =3D wide_domains;</span><br><span> </spa=
n><br><span>         if (AddDnsSearchDomains(list_key, have_list, wide_doma=
ins) =3D=3D FALSE</span><br><span>diff --git a/tests/unit_tests/openvpn/tes=
t_auth_token=2Ec b/tests/unit_tests/openvpn/test_auth_token=2Ec</span><br><=
span>index 9e7b5b9=2E=2E89c418e 100644</span><br><span>--- a/tests/unit_tes=
ts/openvpn/test_auth_token=2Ec</span><br><span>+++ b/tests/unit_tests/openv=
pn/test_auth_token=2Ec</span><br><span>@@ -273,7 +273,7 @@</span><br><span>=
     }</span><br><span>     else if (streq(name, &quot;session_id&quot;))</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        strncpy(last_session_id_value, value, sizeof(last_session_id_value)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strncpynt=
(last_session_id_value, value, sizeof(last_session_id_value));</span><br><s=
pan>     }</span><br><span> }</span><br><span> </span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/unit_tests/openvpn/te=
st_user_pass=2Ec</span><br><span>index 7636a33=2E=2Ec8c69bf 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>@@ -53,7 +=
53,7 @@</span><br><span>     for (int i =3D 0; i &lt; QUERY_USER_NUMSLOTS &=
amp;&amp; query_user[i]=2Eresponse !=3D NULL; i++)</span><br><span>     {</=
span><br><span>         check_expected_ptr(query_user[i]=2Eprompt);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpy(query_user[i]=
=2Eresponse, mock_ptr_type(char *), query_user[i]=2Eresponse_len);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        strncpynt(query_user=
[i]=2Eresponse, mock_ptr_type(char *), query_user[i]=2Eresponse_len);</span=
><br><span>     }</span><br><span> </span><br><span>     return mock();</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1993?usp=3Demail">change 1993</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1993?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I5ee597fb3b9efb93dbe19458ae6e7580d2=
7ae3d2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1993 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--IA9jNZAJ2Gk=--


--===============5656064603871018807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5656064603871018807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5656064603871018807==--

