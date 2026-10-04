Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE36CA5FCE
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ia2PBkXNhf3f1+cOvE8hqi/6W7Nc0J/OWmbWDPiYAfI=; b=IXlj+kEDxtpoHVEKb8KNUuH54H
	hvykmocXLy+fhOy+w/wROtndUxNgRHRa2CD0n2zqL1ncsJ38JVbQ+nJmR9JOua0oebpxOjF+7bBQk
	nT5ha+kRAnAy4PBf5c9IjT1Clvd/jSAX81j2mzAYkIQP+b3Am+z4XzgEAoYtdNQnnpsA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDIG8-0008Im-R7;
	Sun, 04 Oct 2026 09:11:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDIG7-0008Ie-UA
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 09:11:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qdtYKt+CLV0iN0vXEWa22R/dOGwj0alKcHq4ShCgEWU=; b=lVswRw+kTQr7yjb3xgws2jV11S
 2eJg5awgw8sZTePyEoZiG1uZgg5204r9zIj0UXWzxfJHQfw97FkoVxmdMqsWDG69eFHjwf87IsTUt
 VeYp9IrOg4GOktnwEipsNaja0UA8+gw2N12njZWp2HDDSIxTZMxJ4ibK77e5M7iQExZc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qdtYKt+CLV0iN0vXEWa22R/dOGwj0alKcHq4ShCgEWU=; b=j
 17OUm8BqH5R5mdiJiYBSqwo5qgh2/NPtSF4NuZ4OFMLMs6OQG0WZlOVecwsv6FF+Q6WtDEE2a0DWO
 gm/EsFakOfdeDMnS8yWoP7SwReaKfIahGIMM1GybOLz+nMvPWFIRROjB56fKFk3FMo+rMxJAcFGyZ
 jdd2Pg8JFXNjKTTY=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDIG0-0002pn-Rl for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 09:11:48 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49fe8bf173aso5156345e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791105098; x=1791709898; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qdtYKt+CLV0iN0vXEWa22R/dOGwj0alKcHq4ShCgEWU=;
 b=Z2IjKWmvuBvonJnybogpLi5gqAdwlnpq9tm1gr5IiYLYx8k9c8RgRrde+lhSVqWoxU
 WQ6JSW6fvSj+YixlXwm6uQm2w/h1cKmDe7WjExfl82gRShg7B9twqOvYOtyRcvJtFFaK
 p3WWJU53vtfYEvGmeiSSVAKRHpiDGfgoYhS4I43M93FCFI3dAv9+XqjOVnKCWwYKrdRQ
 aQCHDdJ8cU3hz8FqJkDbO1ymPWOfBWERES15AmIfoE/w7tVrRXQuHzUk46eesQE+tlNR
 uMKpRh2eRCTElXaLG5oEk7MOzh5QnK5/8MqurD3G5nI9svXa7AEN4Omk8ZbCfb9FzXV7
 ENwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791105098; x=1791709898;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qdtYKt+CLV0iN0vXEWa22R/dOGwj0alKcHq4ShCgEWU=;
 b=HaAHMu+8QNxIDHdOF9ILtSeWHwcM4/C9eRGcebotKApQVj/qBj9orLRrbrGL38uH/a
 LuF8G+j2kzMKliGzsve+lESaBbEmOJ5ksoy6N0wkaQ7NZerGOE/J2LX0dTf1mDQ+erpU
 2JDumCTQdtMFO6DPOjvI7F2ZZExj4hJ6pDOm6rAyB+NhDjaRPzar6xvjLEZwH55SckMJ
 ABmwUD1aXR4rmmrmxsyouhHZscEjTpzo9rrDIbBrx5RkvUW7jhU3RSnHQzJIRcw+uQXY
 SG/dlwenTGwfM5zQZueE4iXy1ZUULRUtiq4xVqQU5VcwXoQ8hNTU7shor/lfF0DJ3fKA
 42Cw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjf5SvWB9kQuBogwDUZ53k7uo83w3JZhi2q10WmObWb637IoKOEqlsCBIreCEYpeO553XrDlI1BoJbExEa@lists.sourceforge.net
X-Gm-Message-State: AFuF++m43OR8A7GHiKxWlr5FP14n97Pl85oXqBLH7wcRcdeNCJOw4xD0
 8bvkevTcF8CgPoEq3f/TkgCilXsr/spC+IlRFTa3qEotMvwNpurAxwhJShK8zJlxONH8bPefU3+
 EySbiXgMKnjBQlzt1ogtJDr/TlROdp1Y+mDFgde4Je67k/OyB3jEUt2cco4JaYHleu/hk
X-Gm-Gg: AYBFou0deCUAMoE4ZoxgVBJdeKI33sKfqFUvGMJbGnMqAWzunEKI7DBDr8rTzkDVbx1
 moeTvep7ZpY/w6hrTK67StjZkA7ZhUB89sMV0PZSTBszKy7Bl0feRywnJeuUv1uGDTSdOVA4+HV
 BWhPhjjJe0ooqf1otr4dj5KTPS5fOG83dPhgmowJQ9OGC4eNNo2vIB+F39ykI+iHS3Na8rbEwEs
 u0u1ByoKsggBk1ACVF6cGD3l+iI6lg9p0qw99ZQpYONsc8TKFsws30u+gyzkYyCImcof86R1Yi+
 E0SE2JBqBl05cVSFyiP2yzHxvjM0YkczMfpgBJsuZj8ZqXXSObwSC/rRH5jzJAhXwv44u7GGRG9
 UlXlbjFDKVoPxMi0DyCcMZqmCtZHXAvBGkY5CjUT+yXiRgKAaVP0bJb9aObR050pBVvezh/lsFx
 982O3Wku7I0GnvRUzYO1jrOIScISCX5uUAu4eyrOxIPtAM6Dviw2nqeYKO4WW2ly2Acg0tfPpff
 tB3s6K0rleQcBLWH1pERc6Q6zX5y2j9piOmMSBka0crgYlp87X6vQCYNArA5Y2vx7yzcl7Kgh3g
 OK9HfTmBm/IZ5SNrV1gMCZ33z+Ye+GEqm893UbND7tN+MD6Fl45T7GYL5DLW
X-Received: by 2002:a05:600c:608a:b0:49f:bcce:13f5 with SMTP id
 5b1f17b1804b1-4a02758e6e1mr130134295e9.24.1791105097983; 
 Sun, 04 Oct 2026 02:11:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a16d6295f9sm117484555e9.14.2026.10.04.02.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 02:11:37 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 4 Oct 2026 09:11:37 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I7f910599f0f4005f06a88a93b40417ffa37022a8
X-Gerrit-Change-Number: 1960
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1960?usp=email>
X-Gerrit-Commit: 4864b83c900e615d2e8e2bd2d73d60474a0a1bae
In-Reply-To: <gerrit.1790610390000.I7f910599f0f4005f06a88a93b40417ffa37022a8@gerrit.openvpn.net>
References: <gerrit.1790610390000.I7f910599f0f4005f06a88a93b40417ffa37022a8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEwMzkwMDAwLkk3ZjkxMDU5OWYwZjQwMDVmMDZhODhhOTNiNDA0MTdmZmEzNzAyMmE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d1ac4d89669f26a2bcb993e19c90fbf18f11f901-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDIG0-0002pn-Rl
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix all occurrences
 of cppcheck invalidPrintfArgType_uint
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
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5051159444413982428=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5051159444413982428==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="syIcf0RDuug="; charset=UTF-8

--syIcf0RDuug=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1960?usp=3Demail )

Change subject: Fix all occurrences of cppc=
heck invalidPrintfArgType_uint
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Fix all occurrences of cppcheck invalidPrintfArgType_ui=
nt

Mostly trivially correct=2E There are some exceptions, though:
- cppche=
ck treats all numerical literals as "signed" even
  though the compilers wo=
uld probably be more intelligent=2E
  Chose different work-arounds for diff=
erent occurrences=2E
- Needed to override PRIx64 again for Windows, since t=
here
  it needs to be "llx", not "lx"=2E

Change-Id: I7f910599f0f4005f06a88=
a93b40417ffa37022a8
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1960
Message-Id: <20261003204151=2E19347-=
1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg39677=2Ehtml
Signed-off-by: Gert Doering <=
gert@greenie=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppressions=2Exml
M dev-=
tools/openvpn-cppcheck-windows=2Ecfg
M src/openvpn/dco_win=2Ec
M src/openvp=
n/dns=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/init=2Ec
M src/openvpn/op=
tions=2Ec
M src/openvpn/platform=2Ec
M src/openvpn/push=2Ec
M src/openvpn/r=
oute=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/tun=2Ec
M src/openvpn/tun=2Eh
=
M src/openvpnmsica/msica_arg=2Ec
M src/openvpnmsica/msiex=2Ec
M src/openvpn=
msica/openvpnmsica=2Ec
M src/openvpnserv/interactive=2Ec
17 files changed, =
36 insertions(+), 36 deletions(-)




diff --git a/dev-tools/cppcheck-suppr=
essions=2Exml b/dev-tools/cppcheck-suppressions=2Exml
index 0d5416a=2E=2E9d=
8c202 100644
--- a/dev-tools/cppcheck-suppressions=2Exml
+++ b/dev-tools/cp=
pcheck-suppressions=2Exml
@@ -12,9 +12,6 @@
     <id>constParameterPointer<=
/id>
   </suppress>
   <suppress>
-    <id>invalidPrintfArgType_uint</id>
-=
  </suppress>
-  <suppress>
     <id>unusedFunction</id>
   </suppress>
   =
<suppress>
diff --git a/dev-tools/openvpn-cppcheck-windows=2Ecfg b/dev-tool=
s/openvpn-cppcheck-windows=2Ecfg
index 9ac7282=2E=2E932d586 100644
--- a/de=
v-tools/openvpn-cppcheck-windows=2Ecfg
+++ b/dev-tools/openvpn-cppcheck-win=
dows=2Ecfg
@@ -7,4 +7,7 @@
        understand our likely()/unlikely() macro=
s=2E -->
   <define name=3D"__builtin_expect(X,Y)" value=3D"(X)" />
   <def=
ine name=3D"__builtin_expect_with_probability(exp,c,probability)" value=3D"=
(exp)" />
+  <!-- cppcheck understands it directly in format string, but no=
t
+       indirectly when the format string is constructed earlier -->
+  <=
define name=3D"PRIx64" value=3D"&quot;llx&quot;" />
 </def>
diff --git a/sr=
c/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index 20d3c27=2E=2Ec230a90 =
100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -835,=
7 +835,7 @@
         struct multi_instance *mi =3D dco->c->multi->instances=
[stat->PeerId];
         if (!mi)
         {
-            msg(M_WARN, "%s: =
received data for a non-existing peer %u", __func__, stat->PeerId);
+      =
      msg(M_WARN, "%s: received data for a non-existing peer %d", __func__,=
 stat->PeerId);
             continue;
         }
 
diff --git a/src/openvp=
n/dns=2Eh b/src/openvpn/dns=2Eh
index 51bc2de=2E=2E2c20b0e 100644
--- a/src=
/openvpn/dns=2Eh
+++ b/src/openvpn/dns=2Eh
@@ -89,7 +89,7 @@
 };
 
 #ifndef=
 N_DHCP_ADDR
-#define N_DHCP_ADDR 4
+#define N_DHCP_ADDR 4u
 #endif
 
 #ifn=
def N_SEARCH_LIST_LEN
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/fo=
rward=2Ec
index e265498=2E=2E1604224 100644
--- a/src/openvpn/forward=2Ec
+=
++ b/src/openvpn/forward=2Ec
@@ -1305,7 +1305,7 @@
             break;
 
  =
       default:
-            msg(D_DCO_DEBUG, "%s: received message of type=
 %u - ignoring", __func__,
+            msg(D_DCO_DEBUG, "%s: received mess=
age of type %d - ignoring", __func__,
                 dco->dco_message_typ=
e);
             return;
     }
diff --git a/src/openvpn/init=2Ec b/src/ope=
nvpn/init=2Ec
index 8a449e8=2E=2E9306a96 100644
--- a/src/openvpn/init=2Ec
=
+++ b/src/openvpn/init=2Ec
@@ -258,7 +258,7 @@
         gc =3D gc_new();
  =
       {
             struct buffer out =3D alloc_buf_gc(256, &gc);
-      =
      buf_printf(&out, ">PROXY:%u,%s,%s", (l ? l->current : 0) + 1,
+      =
      buf_printf(&out, ">PROXY:%d,%s,%s", (l ? l->current : 0) + 1,
       =
                 (proto_is_udp(ce->proto) ? "UDP" : "TCP"), np(ce->remote))=
;
             management_notify_generic(BSTR(&out));
             manageme=
nt->persist=2Especial_state_msg =3D BSTR(&out);
diff --git a/src/openvpn/op=
tions=2Ec b/src/openvpn/options=2Ec
index 30e497c=2E=2E3316053 100644
--- a=
/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -5138,7 +5138,7 @=
@
         }
         else
         {
-            msg(msglevel, "argument =
to --bind-dev is longer than allowed %u", IFNAMSIZ - 1);
+            msg(m=
sglevel, "argument to --bind-dev is longer than allowed %d", IFNAMSIZ - 1);=

             goto err;
         }
     }
diff --git a/src/openvpn/platform=
=2Ec b/src/openvpn/platform=2Ec
index 91cc0ad=2E=2E9412eeb 100644
--- a/src=
/openvpn/platform=2Ec
+++ b/src/openvpn/platform=2Ec
@@ -549,7 +549,7 @@
  =
       ++attempts;
 
         if (!checked_snprintf(fname, sizeof(fname), f=
name_fmt, max_prefix_len, prefix,
-                              get_random=
(), get_random()))
+                              (uint64_t)get_random(), (=
uint64_t)get_random()))
         {
             msg(M_WARN, "ERROR: tempora=
ry filename too long");
             return NULL;
diff --git a/src/openvpn/=
push=2Ec b/src/openvpn/push=2Ec
index acc965d=2E=2E0e281d2 100644
--- a/src=
/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -351,7 +351,7 @@
     parse=
_auth_pending_keywords(buffer, &server_timeout);
 
     msg(D_PUSH,
-      =
  "AUTH_PENDING received, extending handshake timeout from %us "
+        "=
AUTH_PENDING received, extending handshake timeout from %ds "
         "to =
%us",
         c->options=2Ehandshake_window, min_uint(max_timeout, server_=
timeout));
 
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
ind=
ex ce25cc0=2E=2E33b2387 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvp=
n/route=2Ec
@@ -2818,7 +2818,7 @@
         ret =3D (ack=2Eerror_number =3D=
=3D ERROR_OBJECT_ALREADY_EXISTS) ? RTA_EEXIST : RTA_ERROR;
         if (ret=
 =3D=3D RTA_ERROR)
         {
-            msg(M_WARN, "ERROR: route %s fai=
led using service: %s [status=3D%u if_index=3D%lu]",
+            msg(M_WAR=
N, "ERROR: route %s failed using service: %s [status=3D%d if_index=3D%lu]",=

                 (add ? "addition" : "deletion"), strerror_win32(ack=2Eerr=
or_number, &gc),
                 ack=2Eerror_number, rt->iface=2Eindex);
 =
        }
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index b659=
5ab=2E=2Eaeec020 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec=

@@ -1689,7 +1689,7 @@
                                    options->ping_re=
c_timeout, frame->mss_fix);
             if (ret < 0)
             {
-     =
           msg(D_DCO, "Cannot set DCO peer parameters for peer (id=3D%u): %=
s",
+                msg(D_DCO, "Cannot set DCO peer parameters for peer (i=
d=3D%d): %s",
                     multi->dco_peer_id, strerror(-ret));
   =
              return false;
             }
diff --git a/src/openvpn/tun=2Ec=
 b/src/openvpn/tun=2Ec
index 4b92ff7=2E=2E133f670 100644
--- a/src/openvpn/=
tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -153,7 +153,7 @@
 
     if (ack=2Eerro=
r_number !=3D NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s address failed=
 using service: %s [status=3D%u if_index=3D%lu]",
+        msg(M_WARN, "TUN=
: %s address failed using service: %s [status=3D%d if_index=3D%lu]",
      =
       (add ? "adding" : "deleting"), strerror_win32(ack=2Eerror_number, &g=
c), ack=2Eerror_number,
             addr=2Eiface=2Eindex);
         goto o=
ut;
@@ -224,7 +224,7 @@
 
     if (ack=2Eerror_number !=3D NO_ERROR)
     {=

-        msg(M_WARN, "TUN: %s DNS domains failed using service: %s [status=
=3D%u if_name=3D%s]",
+        msg(M_WARN, "TUN: %s DNS domains failed usin=
g service: %s [status=3D%d if_name=3D%s]",
             (add ? "adding" : "=
deleting"), strerror_win32(ack=2Eerror_number, &gc), ack=2Eerror_number,
  =
           dns=2Eiface=2Ename);
         goto out;
@@ -294,7 +294,7 @@
 
  =
   if (ack=2Eerror_number !=3D NO_ERROR)
     {
-        msg(M_WARN, "TUN: =
%s %s dns failed using service: %s [status=3D%u if_name=3D%s]",
+        ms=
g(M_WARN, "TUN: %s %s dns failed using service: %s [status=3D%d if_name=3D%=
s]",
             (add ? "adding" : "deleting"), ip_proto_name, strerror_wi=
n32(ack=2Eerror_number, &gc),
             ack=2Eerror_number, dns=2Eiface=
=2Ename);
         goto out;
@@ -351,7 +351,7 @@
 
     if (ack=2Eerror_num=
ber !=3D NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s WINS failed using s=
ervice: %s [status=3D%u if_name=3D%s]",
+        msg(M_WARN, "TUN: %s WINS =
failed using service: %s [status=3D%d if_name=3D%s]",
             (add ? "=
adding" : "deleting"), strerror_win32(ack=2Eerror_number, &gc),
           =
  ack=2Eerror_number, wins=2Eiface=2Ename);
         goto out;
@@ -389,7 +3=
89,7 @@
 
     if (ack=2Eerror_number !=3D NO_ERROR)
     {
-        msg(M_=
NONFATAL, "TUN: setting %s mtu using service failed: %s [status=3D%u if_ind=
ex=3D%lu]",
+        msg(M_NONFATAL, "TUN: setting %s mtu using service fai=
led: %s [status=3D%d if_index=3D%lu]",
             family_name, strerror_w=
in32(ack=2Eerror_number, &gc), ack=2Eerror_number,
             mtu_msg=2Ei=
face=2Eindex);
     }
@@ -467,7 +467,7 @@
 
     if (ack=2Eerror_number !=
=3D NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: creating %s adapter usi=
ng service failed: %s [status=3D%u]",
+        msg(M_NONFATAL, "TUN: creati=
ng %s adapter using service failed: %s [status=3D%d]",
             print_t=
un_backend_driver(driver_type), strerror_win32(ack=2Eerror_number, &gc),
  =
           ack=2Eerror_number);
     }
@@ -5186,7 +5186,7 @@
 
     if (ack=
=2Eerror_number !=3D NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: enabli=
ng dhcp using service failed: %s [status=3D%u if_index=3D%lu]",
+        ms=
g(M_NONFATAL, "TUN: enabling dhcp using service failed: %s [status=3D%d if_=
index=3D%lu]",
             strerror_win32(ack=2Eerror_number, &gc), ack=2E=
error_number, dhcp=2Eiface=2Eindex);
     }
     else
@@ -5435,7 +5435,7 @@=

     {
         msg(M_FATAL,
             "ERROR:  This version of " PACKA=
GE_NAME
-            " requires a TAP-Windows driver that is at least versi=
on %u=2E%u -- If you recently upgraded your " PACKAGE_NAME
+            " r=
equires a TAP-Windows driver that is at least version %d=2E%d -- If you rec=
ently upgraded your " PACKAGE_NAME
             " distribution, a reboot is=
 probably required at this point to get Windows to see the new driver=2E",
=
             TAP_WIN_MIN_MAJOR, TAP_WIN_MIN_MINOR);
     }
diff --git a/src=
/openvpn/tun=2Eh b/src/openvpn/tun=2Eh
index 2477560=2E=2E7340e7e 100644
--=
- a/src/openvpn/tun=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -105,7 +105,7 @@
     =
uint8_t netbios_node_type; /* NBT 1,2,4,8 (46) */
 
 /* Max # of addresses =
allowed for  DNS, WINS, etc=2E */
-#define N_DHCP_ADDR 4
+#define N_DHCP_AD=
DR 4u
 
     /* DNS (6) */
     in_addr_t dns[N_DHCP_ADDR];
diff --git a/sr=
c/openvpnmsica/msica_arg=2Ec b/src/openvpnmsica/msica_arg=2Ec
index d763d93=
=2E=2Ec1809f0 100644
--- a/src/openvpnmsica/msica_arg=2Ec
+++ b/src/openvpn=
msica/msica_arg=2Ec
@@ -57,7 +57,7 @@
     struct msica_arg *p =3D malloc(s=
izeof(struct msica_arg) + argument_size);
     if (p =3D=3D NULL)
     {
- =
       msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__,
+        msg(M_F=
ATAL, "%s: malloc(%zu) failed", __FUNCTION__,
             sizeof(struct ms=
ica_arg) + argument_size);
     }
     memcpy(p->val, argument, argument_si=
ze);
@@ -77,7 +77,7 @@
     struct msica_arg *p =3D malloc(sizeof(struct ms=
ica_arg) + argument_size);
     if (p =3D=3D NULL)
     {
-        msg(M_FA=
TAL, "%s: malloc(%u) failed", __FUNCTION__,
+        msg(M_FATAL, "%s: mall=
oc(%zu) failed", __FUNCTION__,
             sizeof(struct msica_arg) + argu=
ment_size);
     }
     memcpy(p->val, argument, argument_size);
@@ -102,7 =
+102,7 @@
     LPWSTR str =3D malloc(size);
     if (str =3D=3D NULL)
     =
{
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, size);
+    =
    msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, size);
         re=
turn NULL;
     }
 
diff --git a/src/openvpnmsica/msiex=2Ec b/src/openvpnms=
ica/msiex=2Ec
index 4d48f06=2E=2Ec6bc648 100644
--- a/src/openvpnmsica/msie=
x=2Ec
+++ b/src/openvpnmsica/msiex=2Ec
@@ -51,7 +51,7 @@
         *pszValue=
 =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (*pszValue =3D=
=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __F=
UNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: malloc=
(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return=
 ERROR_OUTOFMEMORY;
         }
 
@@ -64,7 +64,7 @@
         LPWSTR szBufHea=
p =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (szBufHeap =
=3D=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", =
__FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: mal=
loc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             ret=
urn ERROR_OUTOFMEMORY;
         }
 
@@ -107,7 +107,7 @@
         *pszValue =
=3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (*pszValue =3D=
=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __F=
UNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: malloc=
(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return=
 ERROR_OUTOFMEMORY;
         }
 
@@ -120,7 +120,7 @@
         LPWSTR szBufH=
eap =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (szBufHeap =
=3D=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", =
__FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: mal=
loc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             ret=
urn ERROR_OUTOFMEMORY;
         }
 
@@ -163,7 +163,7 @@
         *pszValue =
=3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (*pszValue =3D=
=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __F=
UNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: malloc=
(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return=
 ERROR_OUTOFMEMORY;
         }
 
@@ -176,7 +176,7 @@
         LPWSTR szBufH=
eap =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (szBufHeap =
=3D=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", =
__FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: mal=
loc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             ret=
urn ERROR_OUTOFMEMORY;
         }
 
diff --git a/src/openvpnmsica/openvpnms=
ica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index 2a1b875=2E=2E1a17d95 1006=
44
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src/openvpnmsica/openvpnms=
ica=2Ec
@@ -165,7 +165,7 @@
         pAdapterAdresses =3D (PIP_ADAPTER_ADDR=
ESSES)malloc(ulAdapterAdressesSize);
         if (pAdapterAdresses =3D=3D N=
ULL)
         {
-            msg(M_NONFATAL, "%s: malloc(%u) failed", __FUN=
CTION__, ulAdapterAdressesSize);
+            msg(M_NONFATAL, "%s: malloc(%=
lu) failed", __FUNCTION__, ulAdapterAdressesSize);
             uiResult =
=3D ERROR_OUTOFMEMORY;
             goto cleanup_pAdapterList;
         }
@=
@ -208,7 +208,7 @@
     szAdaptersTail =3D szAdapters;
     if (szAdapters =
=3D=3D NULL)
     {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTI=
ON__,
+        msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__,
       =
      adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(W=
CHAR));
         uiResult =3D ERROR_OUTOFMEMORY;
         goto cleanup_pAda=
pterAdresses;
@@ -220,7 +220,7 @@
     szAdaptersActiveTail =3D szAdaptersA=
ctive;
     if (szAdaptersActive =3D=3D NULL)
     {
-        msg(M_FATAL, =
"%s: malloc(%u) failed", __FUNCTION__,
+        msg(M_FATAL, "%s: malloc(%z=
u) failed", __FUNCTION__,
             adapter_count * (38 /*GUID*/ + 1 /*s=
eparator/terminator*/) * sizeof(WCHAR));
         uiResult =3D ERROR_OUTOFM=
EMORY;
         goto cleanup_szAdapters;
@@ -405,7 +405,7 @@
         szPat=
h =3D (LPWSTR)malloc((++dwPathSize) * sizeof(WCHAR));
         if (szPath =
=3D=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", =
__FUNCTION__, dwPathSize * sizeof(WCHAR));
+            msg(M_FATAL, "%s: m=
alloc(%zu) failed", __FUNCTION__, dwPathSize * sizeof(WCHAR));
            =
 uiResult =3D ERROR_OUTOFMEMORY;
             goto cleanup_MsiCreateRecord;=

         }
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/=
interactive=2Ec
index 1d9a5d87=2E=2E9a68bbb 100644
--- a/src/openvpnserv/in=
teractive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -311,7 +311,7 @@
   =
   * Same format as error messages (3 line string) with error =3D 0 in
    =
  * 0x%08x format, PID on line 2 and a description "Process ID" on line 3
 =
     */
-    swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%ls", 0, pid, m=
sg);
+    swprintf(buf, _countof(buf), L"0x%08x\n0x%08lx\n%ls", 0, pid, msg=
);
 
     WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, events=
);
 }
@@ -380,7 +380,7 @@
     if (!argv)
     {
         swprintf(errmsg, =
capacity,
-                 L"Cannot validate options: CommandLineToArgvW f=
ailed with error =3D 0x%08x",
+                 L"Cannot validate options: =
CommandLineToArgvW failed with error =3D 0x%08lx",
                  GetLas=
tError());
         goto out;
     }

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1960?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I7f910599f0f4005f06a88a93b40417ffa37022a8
Gerrit-Change-Nu=
mber: 1960
Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>

--syIcf0RDuug=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1960?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Fix all occurrences of cppcheck in=
validPrintfArgType_uint<br><br>Mostly trivially correct=2E There are some e=
xceptions, though:<br>- cppcheck treats all numerical literals as &quot;sig=
ned&quot; even<br>  though the compilers would probably be more intelligent=
=2E<br>  Chose different work-arounds for different occurrences=2E<br>- Nee=
ded to override PRIx64 again for Windows, since there<br>  it needs to be &=
quot;llx&quot;, not &quot;lx&quot;=2E<br><br>Change-Id: I7f910599f0f4005f06=
a88a93b40417ffa37022a8<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<=
br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1960<br>Message-I=
d: &lt;20261003204151=2E19347-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:/=
/www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39677=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M dev-tools/cppcheck-suppressions=2Exml<br>M dev-tools/openvpn-cppche=
ck-windows=2Ecfg<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/dns=2Eh<br>M=
 src/openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/options=
=2Ec<br>M src/openvpn/platform=2Ec<br>M src/openvpn/push=2Ec<br>M src/openv=
pn/route=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/tun=2Ec<br>M src/ope=
nvpn/tun=2Eh<br>M src/openvpnmsica/msica_arg=2Ec<br>M src/openvpnmsica/msie=
x=2Ec<br>M src/openvpnmsica/openvpnmsica=2Ec<br>M src/openvpnserv/interacti=
ve=2Ec<br>17 files changed, 36 insertions(+), 36 deletions(-)<br><br></pre>=

<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/dev-tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck=
-suppressions=2Exml</span><br><span>index 0d5416a=2E=2E9d8c202 100644</span=
><br><span>--- a/dev-tools/cppcheck-suppressions=2Exml</span><br><span>+++ =
b/dev-tools/cppcheck-suppressions=2Exml</span><br><span>@@ -12,9 +12,6 @@</=
span><br><span>     &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><s=
pan>   &lt;/suppress&gt;</span><br><span>   &lt;suppress&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    &lt;id&gt;invalidPrintfArgType_u=
int&lt;/id&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/=
suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;sup=
press&gt;</span><br><span>     &lt;id&gt;unusedFunction&lt;/id&gt;</span><b=
r><span>   &lt;/suppress&gt;</span><br><span>   &lt;suppress&gt;</span><br>=
<span>diff --git a/dev-tools/openvpn-cppcheck-windows=2Ecfg b/dev-tools/ope=
nvpn-cppcheck-windows=2Ecfg</span><br><span>index 9ac7282=2E=2E932d586 1006=
44</span><br><span>--- a/dev-tools/openvpn-cppcheck-windows=2Ecfg</span><br=
><span>+++ b/dev-tools/openvpn-cppcheck-windows=2Ecfg</span><br><span>@@ -7=
,4 +7,7 @@</span><br><span>        understand our likely()/unlikely() macro=
s=2E --&gt;</span><br><span>   &lt;define name=3D&quot;__builtin_expect(X,Y=
)&quot; value=3D&quot;(X)&quot; /&gt;</span><br><span>   &lt;define name=3D=
&quot;__builtin_expect_with_probability(exp,c,probability)&quot; value=3D&q=
uot;(exp)&quot; /&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  &lt;!-- cppcheck understands it directly in format string, but not</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+       indirectly when t=
he format string is constructed earlier --&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  &lt;define name=3D&quot;PRIx64&quot; value=3D&=
quot;&amp;quot;llx&amp;quot;&quot; /&gt;</span><br><span> &lt;/def&gt;</spa=
n><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec<=
/span><br><span>index 20d3c27=2E=2Ec230a90 100644</span><br><span>--- a/src=
/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span><b=
r><span>@@ -835,7 +835,7 @@</span><br><span>         struct multi_instance =
*mi =3D dco-&gt;c-&gt;multi-&gt;instances[stat-&gt;PeerId];</span><br><span=
>         if (!mi)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;%s: received data for=
 a non-existing peer %u&quot;, __func__, stat-&gt;PeerId);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;%s: re=
ceived data for a non-existing peer %d&quot;, __func__, stat-&gt;PeerId);</=
span><br><span>             continue;</span><br><span>         }</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/dns=2Eh b/src/openvpn/dns=
=2Eh</span><br><span>index 51bc2de=2E=2E2c20b0e 100644</span><br><span>--- =
a/src/openvpn/dns=2Eh</span><br><span>+++ b/src/openvpn/dns=2Eh</span><br><=
span>@@ -89,7 +89,7 @@</span><br><span> };</span><br><span> </span><br><spa=
n> #ifndef N_DHCP_ADDR</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define N_DHCP_ADDR 4</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define N_DHCP_ADDR 4u</span><br><span> #endif</span><br><span> </span><=
br><span> #ifndef N_SEARCH_LIST_LEN</span><br><span>diff --git a/src/openvp=
n/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index e265498=2E=2E=
1604224 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><spa=
n>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -1305,7 +1305,7 @@</span=
><br><span>             break;</span><br><span> </span><br><span>         d=
efault:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ms=
g(D_DCO_DEBUG, &quot;%s: received message of type %u - ignoring&quot;, __fu=
nc__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(D_DCO_DEBUG, &quot;%s: received message of type %d - ignoring&quot;, __fu=
nc__,</span><br><span>                 dco-&gt;dco_message_type);</span><br=
><span>             return;</span><br><span>     }</span><br><span>diff --g=
it a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 8a44=
9e8=2E=2E9306a96 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><b=
r><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -258,7 +258,7 @@</spa=
n><br><span>         gc =3D gc_new();</span><br><span>         {</span><br>=
<span>             struct buffer out =3D alloc_buf_gc(256, &amp;gc);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;=
out, &quot;&gt;PROXY:%u,%s,%s&quot;, (l ? l-&gt;current : 0) + 1,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;o=
ut, &quot;&gt;PROXY:%d,%s,%s&quot;, (l ? l-&gt;current : 0) + 1,</span><br>=
<span>                        (proto_is_udp(ce-&gt;proto) ? &quot;UDP&quot;=
 : &quot;TCP&quot;), np(ce-&gt;remote));</span><br><span>             manag=
ement_notify_generic(BSTR(&amp;out));</span><br><span>             manageme=
nt-&gt;persist=2Especial_state_msg =3D BSTR(&amp;out);</span><br><span>diff=
 --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>=
index 30e497c=2E=2E3316053 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -5138=
,7 +5138,7 @@</span><br><span>         }</span><br><span>         else</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            msg(msglevel, &quot;argument to --bind-dev is longer than allo=
wed %u&quot;, IFNAMSIZ - 1);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msg(msglevel, &quot;argument to --bind-dev is longer t=
han allowed %d&quot;, IFNAMSIZ - 1);</span><br><span>             goto err;=
</span><br><span>         }</span><br><span>     }</span><br><span>diff --g=
it a/src/openvpn/platform=2Ec b/src/openvpn/platform=2Ec</span><br><span>in=
dex 91cc0ad=2E=2E9412eeb 100644</span><br><span>--- a/src/openvpn/platform=
=2Ec</span><br><span>+++ b/src/openvpn/platform=2Ec</span><br><span>@@ -549=
,7 +549,7 @@</span><br><span>         ++attempts;</span><br><span> </span><=
br><span>         if (!checked_snprintf(fname, sizeof(fname), fname_fmt, ma=
x_prefix_len, prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                              get_random(), get_random()))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                              (uint6=
4_t)get_random(), (uint64_t)get_random()))</span><br><span>         {</span=
><br><span>             msg(M_WARN, &quot;ERROR: temporary filename too lon=
g&quot;);</span><br><span>             return NULL;</span><br><span>diff --=
git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index acc=
965d=2E=2E0e281d2 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><=
br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -351,7 +351,7 @@</sp=
an><br><span>     parse_auth_pending_keywords(buffer, &amp;server_timeout);=
</span><br><span> </span><br><span>     msg(D_PUSH,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        &quot;AUTH_PENDING received, extend=
ing handshake timeout from %us &quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        &quot;AUTH_PENDING received, extending handshake =
timeout from %ds &quot;</span><br><span>         &quot;to %us&quot;,</span>=
<br><span>         c-&gt;options=2Ehandshake_window, min_uint(max_timeout, =
server_timeout));</span><br><span> </span><br><span>diff --git a/src/openvp=
n/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index ce25cc0=2E=2E33b2=
387 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ =
b/src/openvpn/route=2Ec</span><br><span>@@ -2818,7 +2818,7 @@</span><br><sp=
an>         ret =3D (ack=2Eerror_number =3D=3D ERROR_OBJECT_ALREADY_EXISTS)=
 ? RTA_EEXIST : RTA_ERROR;</span><br><span>         if (ret =3D=3D RTA_ERRO=
R)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            msg(M_WARN, &quot;ERROR: route %s failed using service:=
 %s [status=3D%u if_index=3D%lu]&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(M_WARN, &quot;ERROR: route %s failed us=
ing service: %s [status=3D%d if_index=3D%lu]&quot;,</span><br><span>       =
          (add ? &quot;addition&quot; : &quot;deletion&quot;), strerror_win=
32(ack=2Eerror_number, &amp;gc),</span><br><span>                 ack=2Eerr=
or_number, rt-&gt;iface=2Eindex);</span><br><span>         }</span><br><spa=
n>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>in=
dex b6595ab=2E=2Eaeec020 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</=
span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1689,7 +1689,7=
 @@</span><br><span>                                    options-&gt;ping_re=
c_timeout, frame-&gt;mss_fix);</span><br><span>             if (ret &lt; 0)=
</span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                msg(D_DCO, &quot;Cannot set DCO peer parameters f=
or peer (id=3D%u): %s&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                msg(D_DCO, &quot;Cannot set DCO peer parameters fo=
r peer (id=3D%d): %s&quot;,</span><br><span>                     multi-&gt;=
dco_peer_id, strerror(-ret));</span><br><span>                 return false=
;</span><br><span>             }</span><br><span>diff --git a/src/openvpn/t=
un=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 4b92ff7=2E=2E133f670 100=
644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/ope=
nvpn/tun=2Ec</span><br><span>@@ -153,7 +153,7 @@</span><br><span> </span><b=
r><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &qu=
ot;TUN: %s address failed using service: %s [status=3D%u if_index=3D%lu]&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_W=
ARN, &quot;TUN: %s address failed using service: %s [status=3D%d if_index=
=3D%lu]&quot;,</span><br><span>             (add ? &quot;adding&quot; : &qu=
ot;deleting&quot;), strerror_win32(ack=2Eerror_number, &amp;gc), ack=2Eerro=
r_number,</span><br><span>             addr=2Eiface=2Eindex);</span><br><sp=
an>         goto out;</span><br><span>@@ -224,7 +224,7 @@</span><br><span> =
</span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_=
WARN, &quot;TUN: %s DNS domains failed using service: %s [status=3D%u if_na=
me=3D%s]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_WARN, &quot;TUN: %s DNS domains failed using service: %s [status=
=3D%d if_name=3D%s]&quot;,</span><br><span>             (add ? &quot;adding=
&quot; : &quot;deleting&quot;), strerror_win32(ack=2Eerror_number, &amp;gc)=
, ack=2Eerror_number,</span><br><span>             dns=2Eiface=2Ename);</sp=
an><br><span>         goto out;</span><br><span>@@ -294,7 +294,7 @@</span><=
br><span> </span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    msg(M_WARN, &quot;TUN: %s %s dns failed using service: %s [status=3D%u =
if_name=3D%s]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(M_WARN, &quot;TUN: %s %s dns failed using service: %s [status=
=3D%d if_name=3D%s]&quot;,</span><br><span>             (add ? &quot;adding=
&quot; : &quot;deleting&quot;), ip_proto_name, strerror_win32(ack=2Eerror_n=
umber, &amp;gc),</span><br><span>             ack=2Eerror_number, dns=2Eifa=
ce=2Ename);</span><br><span>         goto out;</span><br><span>@@ -351,7 +3=
51,7 @@</span><br><span> </span><br><span>     if (ack=2Eerror_number !=3D =
NO_ERROR)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        msg(M_WARN, &quot;TUN: %s WINS failed using service: %s =
[status=3D%u if_name=3D%s]&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(M_WARN, &quot;TUN: %s WINS failed using service: =
%s [status=3D%d if_name=3D%s]&quot;,</span><br><span>             (add ? &q=
uot;adding&quot; : &quot;deleting&quot;), strerror_win32(ack=2Eerror_number=
, &amp;gc),</span><br><span>             ack=2Eerror_number, wins=2Eiface=
=2Ename);</span><br><span>         goto out;</span><br><span>@@ -389,7 +389=
,7 @@</span><br><span> </span><br><span>     if (ack=2Eerror_number !=3D NO=
_ERROR)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(M_NONFATAL, &quot;TUN: setting %s mtu using service fa=
iled: %s [status=3D%u if_index=3D%lu]&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;TUN: setting %s mtu =
using service failed: %s [status=3D%d if_index=3D%lu]&quot;,</span><br><spa=
n>             family_name, strerror_win32(ack=2Eerror_number, &amp;gc), ac=
k=2Eerror_number,</span><br><span>             mtu_msg=2Eiface=2Eindex);</s=
pan><br><span>     }</span><br><span>@@ -467,7 +467,7 @@</span><br><span> <=
/span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_N=
ONFATAL, &quot;TUN: creating %s adapter using service failed: %s [status=3D=
%u]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(M_NONFATAL, &quot;TUN: creating %s adapter using service failed: %s [sta=
tus=3D%d]&quot;,</span><br><span>             print_tun_backend_driver(driv=
er_type), strerror_win32(ack=2Eerror_number, &amp;gc),</span><br><span>    =
         ack=2Eerror_number);</span><br><span>     }</span><br><span>@@ -51=
86,7 +5186,7 @@</span><br><span> </span><br><span>     if (ack=2Eerror_numb=
er !=3D NO_ERROR)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        msg(M_NONFATAL, &quot;TUN: enabling dhcp using s=
ervice failed: %s [status=3D%u if_index=3D%lu]&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;TUN: enabli=
ng dhcp using service failed: %s [status=3D%d if_index=3D%lu]&quot;,</span>=
<br><span>             strerror_win32(ack=2Eerror_number, &amp;gc), ack=2Ee=
rror_number, dhcp=2Eiface=2Eindex);</span><br><span>     }</span><br><span>=
     else</span><br><span>@@ -5435,7 +5435,7 @@</span><br><span>     {</spa=
n><br><span>         msg(M_FATAL,</span><br><span>             &quot;ERROR:=
  This version of &quot; PACKAGE_NAME</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            &quot; requires a TAP-Windows driver that is at=
 least version %u=2E%u -- If you recently upgraded your &quot; PACKAGE_NAME=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot; =
requires a TAP-Windows driver that is at least version %d=2E%d -- If you re=
cently upgraded your &quot; PACKAGE_NAME</span><br><span>             &quot=
; distribution, a reboot is probably required at this point to get Windows =
to see the new driver=2E&quot;,</span><br><span>             TAP_WIN_MIN_MA=
JOR, TAP_WIN_MIN_MINOR);</span><br><span>     }</span><br><span>diff --git =
a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh</span><br><span>index 2477560=
=2E=2E7340e7e 100644</span><br><span>--- a/src/openvpn/tun=2Eh</span><br><s=
pan>+++ b/src/openvpn/tun=2Eh</span><br><span>@@ -105,7 +105,7 @@</span><br=
><span>     uint8_t netbios_node_type; /* NBT 1,2,4,8 (46) */</span><br><sp=
an> </span><br><span> /* Max # of addresses allowed for  DNS, WINS, etc=2E =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define N_DHCP_ADDR=
 4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define N_DHCP_AD=
DR 4u</span><br><span> </span><br><span>     /* DNS (6) */</span><br><span>=
     in_addr_t dns[N_DHCP_ADDR];</span><br><span>diff --git a/src/openvpnms=
ica/msica_arg=2Ec b/src/openvpnmsica/msica_arg=2Ec</span><br><span>index d7=
63d93=2E=2Ec1809f0 100644</span><br><span>--- a/src/openvpnmsica/msica_arg=
=2Ec</span><br><span>+++ b/src/openvpnmsica/msica_arg=2Ec</span><br><span>@=
@ -57,7 +57,7 @@</span><br><span>     struct msica_arg *p =3D malloc(sizeof=
(struct msica_arg) + argument_size);</span><br><span>     if (p =3D=3D NULL=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &=
quot;%s: malloc(%zu) failed&quot;, __FUNCTION__,</span><br><span>          =
   sizeof(struct msica_arg) + argument_size);</span><br><span>     }</span>=
<br><span>     memcpy(p-&gt;val, argument, argument_size);</span><br><span>=
@@ -77,7 +77,7 @@</span><br><span>     struct msica_arg *p =3D malloc(sizeo=
f(struct msica_arg) + argument_size);</span><br><span>     if (p =3D=3D NUL=
L)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, =
&quot;%s: malloc(%zu) failed&quot;, __FUNCTION__,</span><br><span>         =
    sizeof(struct msica_arg) + argument_size);</span><br><span>     }</span=
><br><span>     memcpy(p-&gt;val, argument, argument_size);</span><br><span=
>@@ -102,7 +102,7 @@</span><br><span>     LPWSTR str =3D malloc(size);</spa=
n><br><span>     if (str =3D=3D NULL)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;%s: mallo=
c(%u) failed&quot;, __FUNCTION__, size);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(M_FATAL, &quot;%s: malloc(%zu) failed&quot=
;, __FUNCTION__, size);</span><br><span>         return NULL;</span><br><sp=
an>     }</span><br><span> </span><br><span>diff --git a/src/openvpnmsica/m=
siex=2Ec b/src/openvpnmsica/msiex=2Ec</span><br><span>index 4d48f06=2E=2Ec6=
bc648 100644</span><br><span>--- a/src/openvpnmsica/msiex=2Ec</span><br><sp=
an>+++ b/src/openvpnmsica/msiex=2Ec</span><br><span>@@ -51,7 +51,7 @@</span=
><br><span>         *pszValue =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR)=
);</span><br><span>         if (*pszValue =3D=3D NULL)</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg=
(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__, dwLength * sizeo=
f(WCHAR));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_FATAL, &quot;%s: malloc(%zu) failed&quot;, __FUNCTION__, dwLength =
* sizeof(WCHAR));</span><br><span>             return ERROR_OUTOFMEMORY;</s=
pan><br><span>         }</span><br><span> </span><br><span>@@ -64,7 +64,7 @=
@</span><br><span>         LPWSTR szBufHeap =3D (LPWSTR)malloc(++dwLength *=
 sizeof(WCHAR));</span><br><span>         if (szBufHeap =3D=3D NULL)</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__, dw=
Length * sizeof(WCHAR));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            msg(M_FATAL, &quot;%s: malloc(%zu) failed&quot;, __FUNCTIO=
N__, dwLength * sizeof(WCHAR));</span><br><span>             return ERROR_O=
UTOFMEMORY;</span><br><span>         }</span><br><span> </span><br><span>@@=
 -107,7 +107,7 @@</span><br><span>         *pszValue =3D (LPWSTR)malloc(++d=
wLength * sizeof(WCHAR));</span><br><span>         if (*pszValue =3D=3D NUL=
L)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCT=
ION__, dwLength * sizeof(WCHAR));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(M_FATAL, &quot;%s: malloc(%zu) failed&quot;, =
__FUNCTION__, dwLength * sizeof(WCHAR));</span><br><span>             retur=
n ERROR_OUTOFMEMORY;</span><br><span>         }</span><br><span> </span><br=
><span>@@ -120,7 +120,7 @@</span><br><span>         LPWSTR szBufHeap =3D (L=
PWSTR)malloc(++dwLength * sizeof(WCHAR));</span><br><span>         if (szBu=
fHeap =3D=3D NULL)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;%s: malloc(%u) faile=
d&quot;, __FUNCTION__, dwLength * sizeof(WCHAR));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;%s: malloc(%zu=
) failed&quot;, __FUNCTION__, dwLength * sizeof(WCHAR));</span><br><span>  =
           return ERROR_OUTOFMEMORY;</span><br><span>         }</span><br><=
span> </span><br><span>@@ -163,7 +163,7 @@</span><br><span>         *pszVal=
ue =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));</span><br><span>        =
 if (*pszValue =3D=3D NULL)</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;%s: malloc(=
%u) failed&quot;, __FUNCTION__, dwLength * sizeof(WCHAR));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;%s: m=
alloc(%zu) failed&quot;, __FUNCTION__, dwLength * sizeof(WCHAR));</span><br=
><span>             return ERROR_OUTOFMEMORY;</span><br><span>         }</s=
pan><br><span> </span><br><span>@@ -176,7 +176,7 @@</span><br><span>       =
  LPWSTR szBufHeap =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));</span><b=
r><span>         if (szBufHeap =3D=3D NULL)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL, &=
quot;%s: malloc(%u) failed&quot;, __FUNCTION__, dwLength * sizeof(WCHAR));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FA=
TAL, &quot;%s: malloc(%zu) failed&quot;, __FUNCTION__, dwLength * sizeof(WC=
HAR));</span><br><span>             return ERROR_OUTOFMEMORY;</span><br><sp=
an>         }</span><br><span> </span><br><span>diff --git a/src/openvpnmsi=
ca/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>ind=
ex 2a1b875=2E=2E1a17d95 100644</span><br><span>--- a/src/openvpnmsica/openv=
pnmsica=2Ec</span><br><span>+++ b/src/openvpnmsica/openvpnmsica=2Ec</span><=
br><span>@@ -165,7 +165,7 @@</span><br><span>         pAdapterAdresses =3D =
(PIP_ADAPTER_ADDRESSES)malloc(ulAdapterAdressesSize);</span><br><span>     =
    if (pAdapterAdresses =3D=3D NULL)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_NONFATAL, &quo=
t;%s: malloc(%u) failed&quot;, __FUNCTION__, ulAdapterAdressesSize);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_NONFATAL=
, &quot;%s: malloc(%lu) failed&quot;, __FUNCTION__, ulAdapterAdressesSize);=
</span><br><span>             uiResult =3D ERROR_OUTOFMEMORY;</span><br><sp=
an>             goto cleanup_pAdapterList;</span><br><span>         }</span=
><br><span>@@ -208,7 +208,7 @@</span><br><span>     szAdaptersTail =3D szAd=
apters;</span><br><span>     if (szAdapters =3D=3D NULL)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FAT=
AL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;%s: malloc(%zu=
) failed&quot;, __FUNCTION__,</span><br><span>             adapter_count * =
(38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(WCHAR));</span><br><spa=
n>         uiResult =3D ERROR_OUTOFMEMORY;</span><br><span>         goto cl=
eanup_pAdapterAdresses;</span><br><span>@@ -220,7 +220,7 @@</span><br><span=
>     szAdaptersActiveTail =3D szAdaptersActive;</span><br><span>     if (s=
zAdaptersActive =3D=3D NULL)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;%s: malloc(%u) f=
ailed&quot;, __FUNCTION__,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(M_FATAL, &quot;%s: malloc(%zu) failed&quot;, __FUNCTION_=
_,</span><br><span>             adapter_count * (38 /*GUID*/ + 1 /*separato=
r/terminator*/) * sizeof(WCHAR));</span><br><span>         uiResult =3D ERR=
OR_OUTOFMEMORY;</span><br><span>         goto cleanup_szAdapters;</span><br=
><span>@@ -405,7 +405,7 @@</span><br><span>         szPath =3D (LPWSTR)mall=
oc((++dwPathSize) * sizeof(WCHAR));</span><br><span>         if (szPath =3D=
=3D NULL)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, =
__FUNCTION__, dwPathSize * sizeof(WCHAR));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;%s: malloc(%zu) faile=
d&quot;, __FUNCTION__, dwPathSize * sizeof(WCHAR));</span><br><span>       =
      uiResult =3D ERROR_OUTOFMEMORY;</span><br><span>             goto cle=
anup_MsiCreateRecord;</span><br><span>         }</span><br><span>diff --git=
 a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span>=
<br><span>index 1d9a5d87=2E=2E9a68bbb 100644</span><br><span>--- a/src/open=
vpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=
=2Ec</span><br><span>@@ -311,7 +311,7 @@</span><br><span>      * Same forma=
t as error messages (3 line string) with error =3D 0 in</span><br><span>   =
   * 0x%08x format, PID on line 2 and a description &quot;Process ID&quot; =
on line 3</span><br><span>      */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    swprintf(buf, _countof(buf), L&quot;0x%08x\n0x%08x\n%ls&qu=
ot;, 0, pid, msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   swprintf(buf, _countof(buf), L&quot;0x%08x\n0x%08lx\n%ls&quot;, 0, pid, =
msg);</span><br><span> </span><br><span>     WritePipeAsync(pipe, buf, (DWO=
RD)(wcslen(buf) * 2), count, events);</span><br><span> }</span><br><span>@@=
 -380,7 +380,7 @@</span><br><span>     if (!argv)</span><br><span>     {</s=
pan><br><span>         swprintf(errmsg, capacity,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                 L&quot;Cannot validate options=
: CommandLineToArgvW failed with error =3D 0x%08x&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                 L&quot;Cannot validat=
e options: CommandLineToArgvW failed with error =3D 0x%08lx&quot;,</span><b=
r><span>                  GetLastError());</span><br><span>         goto ou=
t;</span><br><span>     }</span><br></pre><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1960?usp=3Demail">change 1960</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1960?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7f910599f=
0f4005f06a88a93b40417ffa37022a8 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1960 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 =
</div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--syIcf0RDuug=--


--===============5051159444413982428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5051159444413982428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5051159444413982428==--

