Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3FBCA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m1BIHYidZ53SPZ6PYmyfgymZqT59gUHpJCbQyEOyo9k=; b=JwicPD+0TQkV/TjbGzKscAoe1E
	U49SK+Kj93XDCElqlWv+gG3ZghZGZIcZU+YD3GFJBoEUcaIBznZ6bkUZhzBk8UazB1g3c1dq95WHV
	5pBE3PLb1Nn6r93UXk26W+Qq4YPJ3CgCrQfGh6IWyXaE027Q/cHS7uKt0hmSI5vdiXzQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDIG7-0000Nn-41;
	Sun, 04 Oct 2026 09:11:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDIG5-0000Nf-Eq
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 09:11:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4KQmYhytJ30dDkIdREjWyu2Bk3c4qzIurrXVJ9b8sEU=; b=Ac27MZIUqUjhapUpq+svIbdCH1
 xNn2m0SLz8b/Z1B0RR7ZuASMw8RLL4tRh3fwGDbLCjAaMxUONCdEtXHkxwOhN8H9oQmxmxHQqjBCC
 l0UU3Aodg/3M6YD2i3O5GsBw4XTniqvQcCES4GAWZUFbQopnGTtXvqGJhOABHlI1KGEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4KQmYhytJ30dDkIdREjWyu2Bk3c4qzIurrXVJ9b8sEU=; b=R
 XG+J2tRRluhhVGjCN06CAbwFU1SEYM7oC5iqt7I5ZMb48rnrB3gWQc3v8ryh9Lwxtb6M80qPJQVyc
 xg0gtUdpmmL2Sy7bUo1xOR/TH1cMg4iXM/jRCK2BOYjGnxvxZU/Lzi6vhA/hHiI9GKRmwY0Bb8cAi
 a1GNirWGA0KRJPbU=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDIFz-0005M2-S2 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 09:11:46 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a0977b9c20so13646545e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 02:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791105097; x=1791709897; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4KQmYhytJ30dDkIdREjWyu2Bk3c4qzIurrXVJ9b8sEU=;
 b=OLNzeKjjco25YzHAhO1nSteNoWRroVwYUGy7yB5Ln7lAAU/tvFN1avP6jKS41b8iwT
 WTSD7GBE8DGHSOxQJr12cfg6Uilue6fGsjGz7KADDWa958YCLU93J+0Sp15LZ4EgQiWL
 ZQfYku7HF4tW+rHcLywg23ove9rCdiN1mPfJtXw8EATeboAANyLwNPoxWO0FSzoCpYq7
 8av2dq9schHrKvDIh67TuXNVs+7LA4QwwScEa6OUi4HlEHEdHmag8d1V3+4HD0oa5EhS
 CNcjS9QoA0FyzOJWn99ocZRv8McWK68StYfnmPuwBbxBv/jVT7ZfKZB35iqBUkMSRtW9
 NHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791105097; x=1791709897;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4KQmYhytJ30dDkIdREjWyu2Bk3c4qzIurrXVJ9b8sEU=;
 b=otCTZUUwsobonaEmtY+hNpfjWiP1IHP+I5+voXt+A7qyK+sFpIqSsmJ5GwQ6+agP1N
 7wL6anxA4TCjaSEagNalXX5ojBtQHiSUefsWDwQb56LR6buyGOS658wg7qA73x1c+xEO
 uE+V9GFHuEfwG+O/8JJAety3F/jFCCrthp/ZayxXgXboHcwGNUQ8rT1hgDFuJh8QxPEp
 yznrWkJ3ZO7wiBQIef0uupLK2bS1UIbkPECYj0RzF/y1SAQP+oUh5gxSpsxR+Cg3FexD
 OgFfRU/sSIJvYQDNqdcTVO2MKQ7jq182QPC1JuEWN+9e92DZ47v7DDHPIXjz2lLRZSZN
 1CHQ==
X-Gm-Message-State: AFuF++kx/IU2u9UKLxDFfGdqcWLafmgUDCRV4LCLDOeXtiCsyg7uBR5T
 EWZkxHPM513blAjrZe+c5BH1Bmd3sKmeYckNLaoO5B+E/XXOZHADpFFf+9+7xzCsLsAVp+/oQmU
 XULis1VKx/5s4oN0gy6+m4VinxJR3DbbkDcx1zobkLHTDOv2xfYXXnNb643Z1iT7d53AwnkuAFb
 iH8mnmVg==
X-Gm-Gg: AYBFou0trpTt6twvdUZhz59ZNXoAKGM677uW9JWDmFKTWjA7TGH/1h1xZzLNi/ok2gD
 W7fy36xV/oyHJzxsu8W8dzzyHw4OMMvKX7V74JHzuMhDEIexcEG5XL29mNqEhMy0f3NJiEiz3JA
 x1THJZrx2eTg03r7E01iSos6Uf5/NFGeGocC9jtTNhKfxC+IbcFHBRBb/Sk8OygUf6LkhrErIYj
 U8hYLBYoZx+HnbOrVBxzPBrm0hwi5IgOkcBHR/4ssqoWSiZPiYk+tlt0UcI3tEEMNHZpX8R+dMp
 tM7nmVxL1QOIC4vQS4mxrBXm4L7/y9dT1QyiwMHoclHBKb0wlyrzSq2qWnMXJLEWegV/5SR5617
 aF5efOukJ4txffaxbqGyVTzVeCDCNXtSipsO9dP/KXOxKy2Nd9CsYY79aYic3zEpa0BFU00UAPT
 Nq9WBMH2zni6xwZSy20RwYiwgTsFk/gsDbywZlE7C4sSKXc0Q95kBsZGK9w/mtSTHfh95JUGc6n
 1U0HdScG9aDJ8/fdp2mxVBX4vY98mRyWAWbkhXHXpgLdtHLMnUqR2JhYM6O42FG+AgLcgKLAwAi
 1J/AAxppaBc0Gu2NcrugdZNUG6QHEwFiluwbRfDRoxJsPaatUkNg8DaVudov
X-Received: by 2002:a05:600c:a41:b0:4a1:688d:a43f with SMTP id
 5b1f17b1804b1-4a1688da591mr70619855e9.35.1791105097071; 
 Sun, 04 Oct 2026 02:11:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380f0ab7sm17556963f8f.7.2026.10.04.02.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 02:11:36 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 4 Oct 2026 09:11:35 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I7f910599f0f4005f06a88a93b40417ffa37022a8
X-Gerrit-Change-Number: 1960
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1960?usp=email>
X-Gerrit-Commit: 4864b83c900e615d2e8e2bd2d73d60474a0a1bae
In-Reply-To: <gerrit.1790610390000.I7f910599f0f4005f06a88a93b40417ffa37022a8@gerrit.openvpn.net>
References: <gerrit.1790610390000.I7f910599f0f4005f06a88a93b40417ffa37022a8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEwMzkwMDAwLkk3ZjkxMDU5OWYwZjQwMDVmMDZhODhhOTNiNDA0MTdmZmEzNzAyMmE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d1ac4d89669f26a2bcb993e19c90fbf18f11f901-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDIFz-0005M2-S2
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1925285584852432006=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1925285584852432006==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F+Hd7lYMvEs="; charset=UTF-8

--F+Hd7lYMvEs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
960?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: Fix all occurrences =
of cppcheck invalidPrintfArgType_uint
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Fix all occurrences of cppcheck invalidPrintfArgT=
ype_uint

Mostly trivially correct=2E There are some exceptions, though:
- =
cppcheck treats all numerical literals as "signed" even
  though the compil=
ers would probably be more intelligent=2E
  Chose different work-arounds fo=
r different occurrences=2E
- Needed to override PRIx64 again for Windows, s=
ince there
  it needs to be "llx", not "lx"=2E

Change-Id: I7f910599f0f4005=
f06a88a93b40417ffa37022a8
Signed-off-by: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1960
Message-Id: <20261003204151=2E=
19347-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg39677=2Ehtml
Signed-off-by: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppressions=2Exml
=
M dev-tools/openvpn-cppcheck-windows=2Ecfg
M src/openvpn/dco_win=2Ec
M src/=
openvpn/dns=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/init=2Ec
M src/open=
vpn/options=2Ec
M src/openvpn/platform=2Ec
M src/openvpn/push=2Ec
M src/ope=
nvpn/route=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/tun=2Ec
M src/openvpn/tu=
n=2Eh
M src/openvpnmsica/msica_arg=2Ec
M src/openvpnmsica/msiex=2Ec
M src/o=
penvpnmsica/openvpnmsica=2Ec
M src/openvpnserv/interactive=2Ec
17 files cha=
nged, 36 insertions(+), 36 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/60/1960/4

diff --git a/dev-tools/cppchec=
k-suppressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml
index 0d5416a=
=2E=2E9d8c202 100644
--- a/dev-tools/cppcheck-suppressions=2Exml
+++ b/dev-=
tools/cppcheck-suppressions=2Exml
@@ -12,9 +12,6 @@
     <id>constParameter=
Pointer</id>
   </suppress>
   <suppress>
-    <id>invalidPrintfArgType_uin=
t</id>
-  </suppress>
-  <suppress>
     <id>unusedFunction</id>
   </suppr=
ess>
   <suppress>
diff --git a/dev-tools/openvpn-cppcheck-windows=2Ecfg b/=
dev-tools/openvpn-cppcheck-windows=2Ecfg
index 9ac7282=2E=2E932d586 100644
=
--- a/dev-tools/openvpn-cppcheck-windows=2Ecfg
+++ b/dev-tools/openvpn-cppc=
heck-windows=2Ecfg
@@ -7,4 +7,7 @@
        understand our likely()/unlikely=
() macros=2E -->
   <define name=3D"__builtin_expect(X,Y)" value=3D"(X)" />=

   <define name=3D"__builtin_expect_with_probability(exp,c,probability)" v=
alue=3D"(exp)" />
+  <!-- cppcheck understands it directly in format string=
, but not
+       indirectly when the format string is constructed earlier =
-->
+  <define name=3D"PRIx64" value=3D"&quot;llx&quot;" />
 </def>
diff --=
git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index 20d3c27=2E=2E=
c230a90 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
=
@@ -835,7 +835,7 @@
         struct multi_instance *mi =3D dco->c->multi->i=
nstances[stat->PeerId];
         if (!mi)
         {
-            msg(M_WAR=
N, "%s: received data for a non-existing peer %u", __func__, stat->PeerId);=

+            msg(M_WARN, "%s: received data for a non-existing peer %d", _=
_func__, stat->PeerId);
             continue;
         }
 
diff --git a/sr=
c/openvpn/dns=2Eh b/src/openvpn/dns=2Eh
index 51bc2de=2E=2E2c20b0e 100644
-=
-- a/src/openvpn/dns=2Eh
+++ b/src/openvpn/dns=2Eh
@@ -89,7 +89,7 @@
 };
 
=
 #ifndef N_DHCP_ADDR
-#define N_DHCP_ADDR 4
+#define N_DHCP_ADDR 4u
 #endif=

 
 #ifndef N_SEARCH_LIST_LEN
diff --git a/src/openvpn/forward=2Ec b/src/op=
envpn/forward=2Ec
index e265498=2E=2E1604224 100644
--- a/src/openvpn/forwa=
rd=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -1305,7 +1305,7 @@
             bre=
ak;
 
         default:
-            msg(D_DCO_DEBUG, "%s: received message=
 of type %u - ignoring", __func__,
+            msg(D_DCO_DEBUG, "%s: recei=
ved message of type %d - ignoring", __func__,
                 dco->dco_mes=
sage_type);
             return;
     }
diff --git a/src/openvpn/init=2Ec b=
/src/openvpn/init=2Ec
index 8a449e8=2E=2E9306a96 100644
--- a/src/openvpn/i=
nit=2Ec
+++ b/src/openvpn/init=2Ec
@@ -258,7 +258,7 @@
         gc =3D gc_n=
ew();
         {
             struct buffer out =3D alloc_buf_gc(256, &gc);=

-            buf_printf(&out, ">PROXY:%u,%s,%s", (l ? l->current : 0) + 1,=

+            buf_printf(&out, ">PROXY:%d,%s,%s", (l ? l->current : 0) + 1,=

                        (proto_is_udp(ce->proto) ? "UDP" : "TCP"), np(ce->=
remote));
             management_notify_generic(BSTR(&out));
             =
management->persist=2Especial_state_msg =3D BSTR(&out);
diff --git a/src/op=
envpn/options=2Ec b/src/openvpn/options=2Ec
index 30e497c=2E=2E3316053 1006=
44
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -5138,7 +=
5138,7 @@
         }
         else
         {
-            msg(msglevel, "a=
rgument to --bind-dev is longer than allowed %u", IFNAMSIZ - 1);
+         =
   msg(msglevel, "argument to --bind-dev is longer than allowed %d", IFNAMS=
IZ - 1);
             goto err;
         }
     }
diff --git a/src/openvpn/=
platform=2Ec b/src/openvpn/platform=2Ec
index 91cc0ad=2E=2E9412eeb 100644
-=
-- a/src/openvpn/platform=2Ec
+++ b/src/openvpn/platform=2Ec
@@ -549,7 +549=
,7 @@
         ++attempts;
 
         if (!checked_snprintf(fname, sizeof(f=
name), fname_fmt, max_prefix_len, prefix,
-                              ge=
t_random(), get_random()))
+                              (uint64_t)get_ran=
dom(), (uint64_t)get_random()))
         {
             msg(M_WARN, "ERROR:=
 temporary filename too long");
             return NULL;
diff --git a/src/=
openvpn/push=2Ec b/src/openvpn/push=2Ec
index acc965d=2E=2E0e281d2 100644
-=
-- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -351,7 +351,7 @@
  =
   parse_auth_pending_keywords(buffer, &server_timeout);
 
     msg(D_PUSH,=

-        "AUTH_PENDING received, extending handshake timeout from %us "
+ =
       "AUTH_PENDING received, extending handshake timeout from %ds "
     =
    "to %us",
         c->options=2Ehandshake_window, min_uint(max_timeout,=
 server_timeout));
 
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=
=2Ec
index ce25cc0=2E=2E33b2387 100644
--- a/src/openvpn/route=2Ec
+++ b/sr=
c/openvpn/route=2Ec
@@ -2818,7 +2818,7 @@
         ret =3D (ack=2Eerror_num=
ber =3D=3D ERROR_OBJECT_ALREADY_EXISTS) ? RTA_EEXIST : RTA_ERROR;
         =
if (ret =3D=3D RTA_ERROR)
         {
-            msg(M_WARN, "ERROR: route=
 %s failed using service: %s [status=3D%u if_index=3D%lu]",
+            ms=
g(M_WARN, "ERROR: route %s failed using service: %s [status=3D%d if_index=
=3D%lu]",
                 (add ? "addition" : "deletion"), strerror_win32(=
ack=2Eerror_number, &gc),
                 ack=2Eerror_number, rt->iface=2E=
index);
         }
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
i=
ndex b6595ab=2E=2Eaeec020 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvp=
n/ssl=2Ec
@@ -1689,7 +1689,7 @@
                                    options=
->ping_rec_timeout, frame->mss_fix);
             if (ret < 0)
            =
 {
-                msg(D_DCO, "Cannot set DCO peer parameters for peer (id=
=3D%u): %s",
+                msg(D_DCO, "Cannot set DCO peer parameters fo=
r peer (id=3D%d): %s",
                     multi->dco_peer_id, strerror(-r=
et));
                 return false;
             }
diff --git a/src/openvp=
n/tun=2Ec b/src/openvpn/tun=2Ec
index 4b92ff7=2E=2E133f670 100644
--- a/src=
/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -153,7 +153,7 @@
 
     if (a=
ck=2Eerror_number !=3D NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s addre=
ss failed using service: %s [status=3D%u if_index=3D%lu]",
+        msg(M_W=
ARN, "TUN: %s address failed using service: %s [status=3D%d if_index=3D%lu]=
",
             (add ? "adding" : "deleting"), strerror_win32(ack=2Eerror_n=
umber, &gc), ack=2Eerror_number,
             addr=2Eiface=2Eindex);
      =
   goto out;
@@ -224,7 +224,7 @@
 
     if (ack=2Eerror_number !=3D NO_ERRO=
R)
     {
-        msg(M_WARN, "TUN: %s DNS domains failed using service: %=
s [status=3D%u if_name=3D%s]",
+        msg(M_WARN, "TUN: %s DNS domains fa=
iled using service: %s [status=3D%d if_name=3D%s]",
             (add ? "ad=
ding" : "deleting"), strerror_win32(ack=2Eerror_number, &gc), ack=2Eerror_n=
umber,
             dns=2Eiface=2Ename);
         goto out;
@@ -294,7 +294,=
7 @@
 
     if (ack=2Eerror_number !=3D NO_ERROR)
     {
-        msg(M_WAR=
N, "TUN: %s %s dns failed using service: %s [status=3D%u if_name=3D%s]",
+ =
       msg(M_WARN, "TUN: %s %s dns failed using service: %s [status=3D%d if=
_name=3D%s]",
             (add ? "adding" : "deleting"), ip_proto_name, st=
rerror_win32(ack=2Eerror_number, &gc),
             ack=2Eerror_number, dns=
=2Eiface=2Ename);
         goto out;
@@ -351,7 +351,7 @@
 
     if (ack=2Ee=
rror_number !=3D NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s WINS failed=
 using service: %s [status=3D%u if_name=3D%s]",
+        msg(M_WARN, "TUN: =
%s WINS failed using service: %s [status=3D%d if_name=3D%s]",
             =
(add ? "adding" : "deleting"), strerror_win32(ack=2Eerror_number, &gc),
   =
          ack=2Eerror_number, wins=2Eiface=2Ename);
         goto out;
@@ -=
389,7 +389,7 @@
 
     if (ack=2Eerror_number !=3D NO_ERROR)
     {
-      =
  msg(M_NONFATAL, "TUN: setting %s mtu using service failed: %s [status=3D%=
u if_index=3D%lu]",
+        msg(M_NONFATAL, "TUN: setting %s mtu using ser=
vice failed: %s [status=3D%d if_index=3D%lu]",
             family_name, st=
rerror_win32(ack=2Eerror_number, &gc), ack=2Eerror_number,
             mtu=
_msg=2Eiface=2Eindex);
     }
@@ -467,7 +467,7 @@
 
     if (ack=2Eerror_nu=
mber !=3D NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: creating %s adapt=
er using service failed: %s [status=3D%u]",
+        msg(M_NONFATAL, "TUN: =
creating %s adapter using service failed: %s [status=3D%d]",
             p=
rint_tun_backend_driver(driver_type), strerror_win32(ack=2Eerror_number, &g=
c),
             ack=2Eerror_number);
     }
@@ -5186,7 +5186,7 @@
 
     i=
f (ack=2Eerror_number !=3D NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: =
enabling dhcp using service failed: %s [status=3D%u if_index=3D%lu]",
+    =
    msg(M_NONFATAL, "TUN: enabling dhcp using service failed: %s [status=3D=
%d if_index=3D%lu]",
             strerror_win32(ack=2Eerror_number, &gc), =
ack=2Eerror_number, dhcp=2Eiface=2Eindex);
     }
     else
@@ -5435,7 +543=
5,7 @@
     {
         msg(M_FATAL,
             "ERROR:  This version of "=
 PACKAGE_NAME
-            " requires a TAP-Windows driver that is at least=
 version %u=2E%u -- If you recently upgraded your " PACKAGE_NAME
+         =
   " requires a TAP-Windows driver that is at least version %d=2E%d -- If y=
ou recently upgraded your " PACKAGE_NAME
             " distribution, a reb=
oot is probably required at this point to get Windows to see the new driver=
=2E",
             TAP_WIN_MIN_MAJOR, TAP_WIN_MIN_MINOR);
     }
diff --git=
 a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh
index 2477560=2E=2E7340e7e 100=
644
--- a/src/openvpn/tun=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -105,7 +105,7 @@=

     uint8_t netbios_node_type; /* NBT 1,2,4,8 (46) */
 
 /* Max # of addr=
esses allowed for  DNS, WINS, etc=2E */
-#define N_DHCP_ADDR 4
+#define N_D=
HCP_ADDR 4u
 
     /* DNS (6) */
     in_addr_t dns[N_DHCP_ADDR];
diff --gi=
t a/src/openvpnmsica/msica_arg=2Ec b/src/openvpnmsica/msica_arg=2Ec
index d=
763d93=2E=2Ec1809f0 100644
--- a/src/openvpnmsica/msica_arg=2Ec
+++ b/src/o=
penvpnmsica/msica_arg=2Ec
@@ -57,7 +57,7 @@
     struct msica_arg *p =3D ma=
lloc(sizeof(struct msica_arg) + argument_size);
     if (p =3D=3D NULL)
   =
  {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__,
+        m=
sg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__,
             sizeof(str=
uct msica_arg) + argument_size);
     }
     memcpy(p->val, argument, argum=
ent_size);
@@ -77,7 +77,7 @@
     struct msica_arg *p =3D malloc(sizeof(str=
uct msica_arg) + argument_size);
     if (p =3D=3D NULL)
     {
-        ms=
g(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__,
+        msg(M_FATAL, "%s=
: malloc(%zu) failed", __FUNCTION__,
             sizeof(struct msica_arg) =
+ argument_size);
     }
     memcpy(p->val, argument, argument_size);
@@ -=
102,7 +102,7 @@
     LPWSTR str =3D malloc(size);
     if (str =3D=3D NULL)=

     {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, size);=

+        msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, size);
     =
    return NULL;
     }
 
diff --git a/src/openvpnmsica/msiex=2Ec b/src/ope=
nvpnmsica/msiex=2Ec
index 4d48f06=2E=2Ec6bc648 100644
--- a/src/openvpnmsic=
a/msiex=2Ec
+++ b/src/openvpnmsica/msiex=2Ec
@@ -51,7 +51,7 @@
         *ps=
zValue =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (*pszVal=
ue =3D=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed=
", __FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: =
malloc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             =
return ERROR_OUTOFMEMORY;
         }
 
@@ -64,7 +64,7 @@
         LPWSTR sz=
BufHeap =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (szBufH=
eap =3D=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) faile=
d", __FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s:=
 malloc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
            =
 return ERROR_OUTOFMEMORY;
         }
 
@@ -107,7 +107,7 @@
         *pszVa=
lue =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (*pszValue =
=3D=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", =
__FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: mal=
loc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             ret=
urn ERROR_OUTOFMEMORY;
         }
 
@@ -120,7 +120,7 @@
         LPWSTR szB=
ufHeap =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (szBufHe=
ap =3D=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed=
", __FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: =
malloc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             =
return ERROR_OUTOFMEMORY;
         }
 
@@ -163,7 +163,7 @@
         *pszVal=
ue =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (*pszValue =
=3D=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", =
__FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: mal=
loc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             ret=
urn ERROR_OUTOFMEMORY;
         }
 
@@ -176,7 +176,7 @@
         LPWSTR szB=
ufHeap =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (szBufHe=
ap =3D=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed=
", __FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: =
malloc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             =
return ERROR_OUTOFMEMORY;
         }
 
diff --git a/src/openvpnmsica/openvp=
nmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index 2a1b875=2E=2E1a17d95 1=
00644
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src/openvpnmsica/openvp=
nmsica=2Ec
@@ -165,7 +165,7 @@
         pAdapterAdresses =3D (PIP_ADAPTER_A=
DDRESSES)malloc(ulAdapterAdressesSize);
         if (pAdapterAdresses =3D=
=3D NULL)
         {
-            msg(M_NONFATAL, "%s: malloc(%u) failed", =
__FUNCTION__, ulAdapterAdressesSize);
+            msg(M_NONFATAL, "%s: mal=
loc(%lu) failed", __FUNCTION__, ulAdapterAdressesSize);
             uiResu=
lt =3D ERROR_OUTOFMEMORY;
             goto cleanup_pAdapterList;
         =
}
@@ -208,7 +208,7 @@
     szAdaptersTail =3D szAdapters;
     if (szAdapte=
rs =3D=3D NULL)
     {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUN=
CTION__,
+        msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__,
    =
         adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeo=
f(WCHAR));
         uiResult =3D ERROR_OUTOFMEMORY;
         goto cleanup_p=
AdapterAdresses;
@@ -220,7 +220,7 @@
     szAdaptersActiveTail =3D szAdapte=
rsActive;
     if (szAdaptersActive =3D=3D NULL)
     {
-        msg(M_FATA=
L, "%s: malloc(%u) failed", __FUNCTION__,
+        msg(M_FATAL, "%s: malloc=
(%zu) failed", __FUNCTION__,
             adapter_count * (38 /*GUID*/ + 1 =
/*separator/terminator*/) * sizeof(WCHAR));
         uiResult =3D ERROR_OUT=
OFMEMORY;
         goto cleanup_szAdapters;
@@ -405,7 +405,7 @@
         sz=
Path =3D (LPWSTR)malloc((++dwPathSize) * sizeof(WCHAR));
         if (szPat=
h =3D=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed"=
, __FUNCTION__, dwPathSize * sizeof(WCHAR));
+            msg(M_FATAL, "%s:=
 malloc(%zu) failed", __FUNCTION__, dwPathSize * sizeof(WCHAR));
          =
   uiResult =3D ERROR_OUTOFMEMORY;
             goto cleanup_MsiCreateRecor=
d;
         }
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnser=
v/interactive=2Ec
index 1d9a5d87=2E=2E9a68bbb 100644
--- a/src/openvpnserv/=
interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -311,7 +311,7 @@
 =
     * Same format as error messages (3 line string) with error =3D 0 in
  =
    * 0x%08x format, PID on line 2 and a description "Process ID" on line 3=

      */
-    swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%ls", 0, pid,=
 msg);
+    swprintf(buf, _countof(buf), L"0x%08x\n0x%08lx\n%ls", 0, pid, m=
sg);
 
     WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, even=
ts);
 }
@@ -380,7 +380,7 @@
     if (!argv)
     {
         swprintf(errmsg=
, capacity,
-                 L"Cannot validate options: CommandLineToArgvW=
 failed with error =3D 0x%08x",
+                 L"Cannot validate options=
: CommandLineToArgvW failed with error =3D 0x%08lx",
                  GetL=
astError());
         goto out;
     }

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1960?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I7f910599f0f4005f06a88a93b40417ffa37022a8
Gerrit-=
Change-Number: 1960
Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--F+Hd7lYMvEs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1960?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Fix all occurrences of cppcheck invalidPrintfArgType_uint<br><br>Mostly=
 trivially correct=2E There are some exceptions, though:<br>- cppcheck trea=
ts all numerical literals as &quot;signed&quot; even<br>  though the compil=
ers would probably be more intelligent=2E<br>  Chose different work-arounds=
 for different occurrences=2E<br>- Needed to override PRIx64 again for Wind=
ows, since there<br>  it needs to be &quot;llx&quot;, not &quot;lx&quot;=2E=
<br><br>Change-Id: I7f910599f0f4005f06a88a93b40417ffa37022a8<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1960<br>Message-Id: &lt;20261003204151=2E19347-1-gert@=
greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-dev=
el@lists=2Esourceforge=2Enet/msg39677=2Ehtml<br>Signed-off-by: Gert Doering=
 &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cppcheck-suppression=
s=2Exml<br>M dev-tools/openvpn-cppcheck-windows=2Ecfg<br>M src/openvpn/dco_=
win=2Ec<br>M src/openvpn/dns=2Eh<br>M src/openvpn/forward=2Ec<br>M src/open=
vpn/init=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/platform=2Ec<br>=
M src/openvpn/push=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvpn/ssl=2Ec<=
br>M src/openvpn/tun=2Ec<br>M src/openvpn/tun=2Eh<br>M src/openvpnmsica/msi=
ca_arg=2Ec<br>M src/openvpnmsica/msiex=2Ec<br>M src/openvpnmsica/openvpnmsi=
ca=2Ec<br>M src/openvpnserv/interactive=2Ec<br>17 files changed, 36 inserti=
ons(+), 36 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/60/1960/4</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev=
-tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml<=
/span><br><span>index 0d5416a=2E=2E9d8c202 100644</span><br><span>--- a/dev=
-tools/cppcheck-suppressions=2Exml</span><br><span>+++ b/dev-tools/cppcheck=
-suppressions=2Exml</span><br><span>@@ -12,9 +12,6 @@</span><br><span>     =
&lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span>   &lt;/suppress=
&gt;</span><br><span>   &lt;suppress&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    &lt;id&gt;invalidPrintfArgType_uint&lt;/id&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/suppress&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;suppress&gt;</span><br>=
<span>     &lt;id&gt;unusedFunction&lt;/id&gt;</span><br><span>   &lt;/supp=
ress&gt;</span><br><span>   &lt;suppress&gt;</span><br><span>diff --git a/d=
ev-tools/openvpn-cppcheck-windows=2Ecfg b/dev-tools/openvpn-cppcheck-window=
s=2Ecfg</span><br><span>index 9ac7282=2E=2E932d586 100644</span><br><span>-=
-- a/dev-tools/openvpn-cppcheck-windows=2Ecfg</span><br><span>+++ b/dev-too=
ls/openvpn-cppcheck-windows=2Ecfg</span><br><span>@@ -7,4 +7,7 @@</span><br=
><span>        understand our likely()/unlikely() macros=2E --&gt;</span><b=
r><span>   &lt;define name=3D&quot;__builtin_expect(X,Y)&quot; value=3D&quo=
t;(X)&quot; /&gt;</span><br><span>   &lt;define name=3D&quot;__builtin_expe=
ct_with_probability(exp,c,probability)&quot; value=3D&quot;(exp)&quot; /&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- cppcheck=
 understands it directly in format string, but not</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+       indirectly when the format string is =
constructed earlier --&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  &lt;define name=3D&quot;PRIx64&quot; value=3D&quot;&amp;quot;llx&a=
mp;quot;&quot; /&gt;</span><br><span> &lt;/def&gt;</span><br><span>diff --g=
it a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>inde=
x 20d3c27=2E=2Ec230a90 100644</span><br><span>--- a/src/openvpn/dco_win=2Ec=
</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -835,7 +8=
35,7 @@</span><br><span>         struct multi_instance *mi =3D dco-&gt;c-&g=
t;multi-&gt;instances[stat-&gt;PeerId];</span><br><span>         if (!mi)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            msg(M_WARN, &quot;%s: received data for a non-existing peer=
 %u&quot;, __func__, stat-&gt;PeerId);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(M_WARN, &quot;%s: received data for a no=
n-existing peer %d&quot;, __func__, stat-&gt;PeerId);</span><br><span>     =
        continue;</span><br><span>         }</span><br><span> </span><br><s=
pan>diff --git a/src/openvpn/dns=2Eh b/src/openvpn/dns=2Eh</span><br><span>=
index 51bc2de=2E=2E2c20b0e 100644</span><br><span>--- a/src/openvpn/dns=2Eh=
</span><br><span>+++ b/src/openvpn/dns=2Eh</span><br><span>@@ -89,7 +89,7 @=
@</span><br><span> };</span><br><span> </span><br><span> #ifndef N_DHCP_ADD=
R</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define N_DHCP_ADDR =
4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define N_DHCP_ADD=
R 4u</span><br><span> #endif</span><br><span> </span><br><span> #ifndef N_S=
EARCH_LIST_LEN</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/o=
penvpn/forward=2Ec</span><br><span>index e265498=2E=2E1604224 100644</span>=
<br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/f=
orward=2Ec</span><br><span>@@ -1305,7 +1305,7 @@</span><br><span>          =
   break;</span><br><span> </span><br><span>         default:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            msg(D_DCO_DEBUG, &quot;=
%s: received message of type %u - ignoring&quot;, __func__,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(D_DCO_DEBUG, &quot;=
%s: received message of type %d - ignoring&quot;, __func__,</span><br><span=
>                 dco-&gt;dco_message_type);</span><br><span>             r=
eturn;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec</span><br><span>index 8a449e8=2E=2E9306a96 1006=
44</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/ope=
nvpn/init=2Ec</span><br><span>@@ -258,7 +258,7 @@</span><br><span>         =
gc =3D gc_new();</span><br><span>         {</span><br><span>             st=
ruct buffer out =3D alloc_buf_gc(256, &amp;gc);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;&gt;PROXY:=
%u,%s,%s&quot;, (l ? l-&gt;current : 0) + 1,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;&gt;PROXY:%=
d,%s,%s&quot;, (l ? l-&gt;current : 0) + 1,</span><br><span>               =
         (proto_is_udp(ce-&gt;proto) ? &quot;UDP&quot; : &quot;TCP&quot;), =
np(ce-&gt;remote));</span><br><span>             management_notify_generic(=
BSTR(&amp;out));</span><br><span>             management-&gt;persist=2Espec=
ial_state_msg =3D BSTR(&amp;out);</span><br><span>diff --git a/src/openvpn/=
options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 30e497c=2E=2E33=
16053 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>=
+++ b/src/openvpn/options=2Ec</span><br><span>@@ -5138,7 +5138,7 @@</span><=
br><span>         }</span><br><span>         else</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msgl=
evel, &quot;argument to --bind-dev is longer than allowed %u&quot;, IFNAMSI=
Z - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(msglevel, &quot;argument to --bind-dev is longer than allowed %d&quot;,=
 IFNAMSIZ - 1);</span><br><span>             goto err;</span><br><span>    =
     }</span><br><span>     }</span><br><span>diff --git a/src/openvpn/plat=
form=2Ec b/src/openvpn/platform=2Ec</span><br><span>index 91cc0ad=2E=2E9412=
eeb 100644</span><br><span>--- a/src/openvpn/platform=2Ec</span><br><span>+=
++ b/src/openvpn/platform=2Ec</span><br><span>@@ -549,7 +549,7 @@</span><br=
><span>         ++attempts;</span><br><span> </span><br><span>         if (=
!checked_snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len, prefix,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
        get_random(), get_random()))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                              (uint64_t)get_random(), (uin=
t64_t)get_random()))</span><br><span>         {</span><br><span>           =
  msg(M_WARN, &quot;ERROR: temporary filename too long&quot;);</span><br><s=
pan>             return NULL;</span><br><span>diff --git a/src/openvpn/push=
=2Ec b/src/openvpn/push=2Ec</span><br><span>index acc965d=2E=2E0e281d2 1006=
44</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/ope=
nvpn/push=2Ec</span><br><span>@@ -351,7 +351,7 @@</span><br><span>     pars=
e_auth_pending_keywords(buffer, &amp;server_timeout);</span><br><span> </sp=
an><br><span>     msg(D_PUSH,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        &quot;AUTH_PENDING received, extending handshake timeout fr=
om %us &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  &quot;AUTH_PENDING received, extending handshake timeout from %ds &quot;<=
/span><br><span>         &quot;to %us&quot;,</span><br><span>         c-&gt=
;options=2Ehandshake_window, min_uint(max_timeout, server_timeout));</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvp=
n/route=2Ec</span><br><span>index ce25cc0=2E=2E33b2387 100644</span><br><sp=
an>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec<=
/span><br><span>@@ -2818,7 +2818,7 @@</span><br><span>         ret =3D (ack=
=2Eerror_number =3D=3D ERROR_OBJECT_ALREADY_EXISTS) ? RTA_EEXIST : RTA_ERRO=
R;</span><br><span>         if (ret =3D=3D RTA_ERROR)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(=
M_WARN, &quot;ERROR: route %s failed using service: %s [status=3D%u if_inde=
x=3D%lu]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(M_WARN, &quot;ERROR: route %s failed using service: %s [status=
=3D%d if_index=3D%lu]&quot;,</span><br><span>                 (add ? &quot;=
addition&quot; : &quot;deletion&quot;), strerror_win32(ack=2Eerror_number, =
&amp;gc),</span><br><span>                 ack=2Eerror_number, rt-&gt;iface=
=2Eindex);</span><br><span>         }</span><br><span>diff --git a/src/open=
vpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index b6595ab=2E=2Eaeec02=
0 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/sr=
c/openvpn/ssl=2Ec</span><br><span>@@ -1689,7 +1689,7 @@</span><br><span>   =
                                 options-&gt;ping_rec_timeout, frame-&gt;ms=
s_fix);</span><br><span>             if (ret &lt; 0)</span><br><span>      =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   msg(D_DCO, &quot;Cannot set DCO peer parameters for peer (id=3D%u): %s&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  msg(D_DCO, &quot;Cannot set DCO peer parameters for peer (id=3D%d): %s&qu=
ot;,</span><br><span>                     multi-&gt;dco_peer_id, strerror(-=
ret));</span><br><span>                 return false;</span><br><span>     =
        }</span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tu=
n=2Ec</span><br><span>index 4b92ff7=2E=2E133f670 100644</span><br><span>---=
 a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br>=
<span>@@ -153,7 +153,7 @@</span><br><span> </span><br><span>     if (ack=2E=
error_number !=3D NO_ERROR)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;TUN: %s address fail=
ed using service: %s [status=3D%u if_index=3D%lu]&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;TUN: %s addr=
ess failed using service: %s [status=3D%d if_index=3D%lu]&quot;,</span><br>=
<span>             (add ? &quot;adding&quot; : &quot;deleting&quot;), strer=
ror_win32(ack=2Eerror_number, &amp;gc), ack=2Eerror_number,</span><br><span=
>             addr=2Eiface=2Eindex);</span><br><span>         goto out;</sp=
an><br><span>@@ -224,7 +224,7 @@</span><br><span> </span><br><span>     if =
(ack=2Eerror_number !=3D NO_ERROR)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;TUN: %s DNS d=
omains failed using service: %s [status=3D%u if_name=3D%s]&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;TUN=
: %s DNS domains failed using service: %s [status=3D%d if_name=3D%s]&quot;,=
</span><br><span>             (add ? &quot;adding&quot; : &quot;deleting&qu=
ot;), strerror_win32(ack=2Eerror_number, &amp;gc), ack=2Eerror_number,</spa=
n><br><span>             dns=2Eiface=2Ename);</span><br><span>         goto=
 out;</span><br><span>@@ -294,7 +294,7 @@</span><br><span> </span><br><span=
>     if (ack=2Eerror_number !=3D NO_ERROR)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;TUN:=
 %s %s dns failed using service: %s [status=3D%u if_name=3D%s]&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot=
;TUN: %s %s dns failed using service: %s [status=3D%d if_name=3D%s]&quot;,<=
/span><br><span>             (add ? &quot;adding&quot; : &quot;deleting&quo=
t;), ip_proto_name, strerror_win32(ack=2Eerror_number, &amp;gc),</span><br>=
<span>             ack=2Eerror_number, dns=2Eiface=2Ename);</span><br><span=
>         goto out;</span><br><span>@@ -351,7 +351,7 @@</span><br><span> </=
span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WA=
RN, &quot;TUN: %s WINS failed using service: %s [status=3D%u if_name=3D%s]&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M=
_WARN, &quot;TUN: %s WINS failed using service: %s [status=3D%d if_name=3D%=
s]&quot;,</span><br><span>             (add ? &quot;adding&quot; : &quot;de=
leting&quot;), strerror_win32(ack=2Eerror_number, &amp;gc),</span><br><span=
>             ack=2Eerror_number, wins=2Eiface=2Ename);</span><br><span>   =
      goto out;</span><br><span>@@ -389,7 +389,7 @@</span><br><span> </span=
><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_NONFAT=
AL, &quot;TUN: setting %s mtu using service failed: %s [status=3D%u if_inde=
x=3D%lu]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_NONFATAL, &quot;TUN: setting %s mtu using service failed: %s [sta=
tus=3D%d if_index=3D%lu]&quot;,</span><br><span>             family_name, s=
trerror_win32(ack=2Eerror_number, &amp;gc), ack=2Eerror_number,</span><br><=
span>             mtu_msg=2Eiface=2Eindex);</span><br><span>     }</span><b=
r><span>@@ -467,7 +467,7 @@</span><br><span> </span><br><span>     if (ack=
=2Eerror_number !=3D NO_ERROR)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_NONFATAL, &quot;TUN: creating=
 %s adapter using service failed: %s [status=3D%u]&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;TUN: cr=
eating %s adapter using service failed: %s [status=3D%d]&quot;,</span><br><=
span>             print_tun_backend_driver(driver_type), strerror_win32(ack=
=2Eerror_number, &amp;gc),</span><br><span>             ack=2Eerror_number)=
;</span><br><span>     }</span><br><span>@@ -5186,7 +5186,7 @@</span><br><s=
pan> </span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
sg(M_NONFATAL, &quot;TUN: enabling dhcp using service failed: %s [status=3D=
%u if_index=3D%lu]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_NONFATAL, &quot;TUN: enabling dhcp using service failed=
: %s [status=3D%d if_index=3D%lu]&quot;,</span><br><span>             strer=
ror_win32(ack=2Eerror_number, &amp;gc), ack=2Eerror_number, dhcp=2Eiface=2E=
index);</span><br><span>     }</span><br><span>     else</span><br><span>@@=
 -5435,7 +5435,7 @@</span><br><span>     {</span><br><span>         msg(M_F=
ATAL,</span><br><span>             &quot;ERROR:  This version of &quot; PAC=
KAGE_NAME</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
&quot; requires a TAP-Windows driver that is at least version %u=2E%u -- If=
 you recently upgraded your &quot; PACKAGE_NAME</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            &quot; requires a TAP-Windows drive=
r that is at least version %d=2E%d -- If you recently upgraded your &quot; =
PACKAGE_NAME</span><br><span>             &quot; distribution, a reboot is =
probably required at this point to get Windows to see the new driver=2E&quo=
t;,</span><br><span>             TAP_WIN_MIN_MAJOR, TAP_WIN_MIN_MINOR);</sp=
an><br><span>     }</span><br><span>diff --git a/src/openvpn/tun=2Eh b/src/=
openvpn/tun=2Eh</span><br><span>index 2477560=2E=2E7340e7e 100644</span><br=
><span>--- a/src/openvpn/tun=2Eh</span><br><span>+++ b/src/openvpn/tun=2Eh<=
/span><br><span>@@ -105,7 +105,7 @@</span><br><span>     uint8_t netbios_no=
de_type; /* NBT 1,2,4,8 (46) */</span><br><span> </span><br><span> /* Max #=
 of addresses allowed for  DNS, WINS, etc=2E */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define N_DHCP_ADDR 4</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define N_DHCP_ADDR 4u</span><br><span> </span>=
<br><span>     /* DNS (6) */</span><br><span>     in_addr_t dns[N_DHCP_ADDR=
];</span><br><span>diff --git a/src/openvpnmsica/msica_arg=2Ec b/src/openvp=
nmsica/msica_arg=2Ec</span><br><span>index d763d93=2E=2Ec1809f0 100644</spa=
n><br><span>--- a/src/openvpnmsica/msica_arg=2Ec</span><br><span>+++ b/src/=
openvpnmsica/msica_arg=2Ec</span><br><span>@@ -57,7 +57,7 @@</span><br><spa=
n>     struct msica_arg *p =3D malloc(sizeof(struct msica_arg) + argument_s=
ize);</span><br><span>     if (p =3D=3D NULL)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;%=
s: malloc(%u) failed&quot;, __FUNCTION__,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(M_FATAL, &quot;%s: malloc(%zu) failed&quo=
t;, __FUNCTION__,</span><br><span>             sizeof(struct msica_arg) + a=
rgument_size);</span><br><span>     }</span><br><span>     memcpy(p-&gt;val=
, argument, argument_size);</span><br><span>@@ -77,7 +77,7 @@</span><br><sp=
an>     struct msica_arg *p =3D malloc(sizeof(struct msica_arg) + argument_=
size);</span><br><span>     if (p =3D=3D NULL)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;=
%s: malloc(%u) failed&quot;, __FUNCTION__,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;%s: malloc(%zu) failed&qu=
ot;, __FUNCTION__,</span><br><span>             sizeof(struct msica_arg) + =
argument_size);</span><br><span>     }</span><br><span>     memcpy(p-&gt;va=
l, argument, argument_size);</span><br><span>@@ -102,7 +102,7 @@</span><br>=
<span>     LPWSTR str =3D malloc(size);</span><br><span>     if (str =3D=3D=
 NULL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION_=
_, size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_FATAL, &quot;%s: malloc(%zu) failed&quot;, __FUNCTION__, size);</span><=
br><span>         return NULL;</span><br><span>     }</span><br><span> </sp=
an><br><span>diff --git a/src/openvpnmsica/msiex=2Ec b/src/openvpnmsica/msi=
ex=2Ec</span><br><span>index 4d48f06=2E=2Ec6bc648 100644</span><br><span>--=
- a/src/openvpnmsica/msiex=2Ec</span><br><span>+++ b/src/openvpnmsica/msiex=
=2Ec</span><br><span>@@ -51,7 +51,7 @@</span><br><span>         *pszValue =
=3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));</span><br><span>         if=
 (*pszValue =3D=3D NULL)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;%s: malloc(%=
u) failed&quot;, __FUNCTION__, dwLength * sizeof(WCHAR));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;%s: ma=
lloc(%zu) failed&quot;, __FUNCTION__, dwLength * sizeof(WCHAR));</span><br>=
<span>             return ERROR_OUTOFMEMORY;</span><br><span>         }</sp=
an><br><span> </span><br><span>@@ -64,7 +64,7 @@</span><br><span>         L=
PWSTR szBufHeap =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));</span><br><=
span>         if (szBufHeap =3D=3D NULL)</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quo=
t;%s: malloc(%u) failed&quot;, __FUNCTION__, dwLength * sizeof(WCHAR));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL=
, &quot;%s: malloc(%zu) failed&quot;, __FUNCTION__, dwLength * sizeof(WCHAR=
));</span><br><span>             return ERROR_OUTOFMEMORY;</span><br><span>=
         }</span><br><span> </span><br><span>@@ -107,7 +107,7 @@</span><br>=
<span>         *pszValue =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));</s=
pan><br><span>         if (*pszValue =3D=3D NULL)</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_FA=
TAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__, dwLength * sizeof(WCH=
AR));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(M_FATAL, &quot;%s: malloc(%zu) failed&quot;, __FUNCTION__, dwLength * siz=
eof(WCHAR));</span><br><span>             return ERROR_OUTOFMEMORY;</span><=
br><span>         }</span><br><span> </span><br><span>@@ -120,7 +120,7 @@</=
span><br><span>         LPWSTR szBufHeap =3D (LPWSTR)malloc(++dwLength * si=
zeof(WCHAR));</span><br><span>         if (szBufHeap =3D=3D NULL)</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__, dwLen=
gth * sizeof(WCHAR));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(M_FATAL, &quot;%s: malloc(%zu) failed&quot;, __FUNCTION__=
, dwLength * sizeof(WCHAR));</span><br><span>             return ERROR_OUTO=
FMEMORY;</span><br><span>         }</span><br><span> </span><br><span>@@ -1=
63,7 +163,7 @@</span><br><span>         *pszValue =3D (LPWSTR)malloc(++dwLe=
ngth * sizeof(WCHAR));</span><br><span>         if (*pszValue =3D=3D NULL)<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION=
__, dwLength * sizeof(WCHAR));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(M_FATAL, &quot;%s: malloc(%zu) failed&quot;, __F=
UNCTION__, dwLength * sizeof(WCHAR));</span><br><span>             return E=
RROR_OUTOFMEMORY;</span><br><span>         }</span><br><span> </span><br><s=
pan>@@ -176,7 +176,7 @@</span><br><span>         LPWSTR szBufHeap =3D (LPWS=
TR)malloc(++dwLength * sizeof(WCHAR));</span><br><span>         if (szBufHe=
ap =3D=3D NULL)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;%s: malloc(%u) failed&q=
uot;, __FUNCTION__, dwLength * sizeof(WCHAR));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;%s: malloc(%zu) f=
ailed&quot;, __FUNCTION__, dwLength * sizeof(WCHAR));</span><br><span>     =
        return ERROR_OUTOFMEMORY;</span><br><span>         }</span><br><spa=
n> </span><br><span>diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/op=
envpnmsica/openvpnmsica=2Ec</span><br><span>index 2a1b875=2E=2E1a17d95 1006=
44</span><br><span>--- a/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>=
+++ b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>@@ -165,7 +165,7 @@=
</span><br><span>         pAdapterAdresses =3D (PIP_ADAPTER_ADDRESSES)mallo=
c(ulAdapterAdressesSize);</span><br><span>         if (pAdapterAdresses =3D=
=3D NULL)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            msg(M_NONFATAL, &quot;%s: malloc(%u) failed&quot=
;, __FUNCTION__, ulAdapterAdressesSize);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(M_NONFATAL, &quot;%s: malloc(%lu) fail=
ed&quot;, __FUNCTION__, ulAdapterAdressesSize);</span><br><span>           =
  uiResult =3D ERROR_OUTOFMEMORY;</span><br><span>             goto cleanup=
_pAdapterList;</span><br><span>         }</span><br><span>@@ -208,7 +208,7 =
@@</span><br><span>     szAdaptersTail =3D szAdapters;</span><br><span>    =
 if (szAdapters =3D=3D NULL)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;%s: malloc(%u) f=
ailed&quot;, __FUNCTION__,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(M_FATAL, &quot;%s: malloc(%zu) failed&quot;, __FUNCTION_=
_,</span><br><span>             adapter_count * (38 /*GUID*/ + 1 /*separato=
r/terminator*/) * sizeof(WCHAR));</span><br><span>         uiResult =3D ERR=
OR_OUTOFMEMORY;</span><br><span>         goto cleanup_pAdapterAdresses;</sp=
an><br><span>@@ -220,7 +220,7 @@</span><br><span>     szAdaptersActiveTail =
=3D szAdaptersActive;</span><br><span>     if (szAdaptersActive =3D=3D NULL=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &=
quot;%s: malloc(%zu) failed&quot;, __FUNCTION__,</span><br><span>          =
   adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(WCHA=
R));</span><br><span>         uiResult =3D ERROR_OUTOFMEMORY;</span><br><sp=
an>         goto cleanup_szAdapters;</span><br><span>@@ -405,7 +405,7 @@</s=
pan><br><span>         szPath =3D (LPWSTR)malloc((++dwPathSize) * sizeof(WC=
HAR));</span><br><span>         if (szPath =3D=3D NULL)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ms=
g(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__, dwPathSize * si=
zeof(WCHAR));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(M_FATAL, &quot;%s: malloc(%zu) failed&quot;, __FUNCTION__, dwPath=
Size * sizeof(WCHAR));</span><br><span>             uiResult =3D ERROR_OUTO=
FMEMORY;</span><br><span>             goto cleanup_MsiCreateRecord;</span><=
br><span>         }</span><br><span>diff --git a/src/openvpnserv/interactiv=
e=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 1d9a5d87=2E=
=2E9a68bbb 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</sp=
an><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -311,=
7 +311,7 @@</span><br><span>      * Same format as error messages (3 line s=
tring) with error =3D 0 in</span><br><span>      * 0x%08x format, PID on li=
ne 2 and a description &quot;Process ID&quot; on line 3</span><br><span>   =
   */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    swprintf(buf=
, _countof(buf), L&quot;0x%08x\n0x%08x\n%ls&quot;, 0, pid, msg);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    swprintf(buf, _countof(buf=
), L&quot;0x%08x\n0x%08lx\n%ls&quot;, 0, pid, msg);</span><br><span> </span=
><br><span>     WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, =
events);</span><br><span> }</span><br><span>@@ -380,7 +380,7 @@</span><br><=
span>     if (!argv)</span><br><span>     {</span><br><span>         swprin=
tf(errmsg, capacity,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                L&quot;Cannot validate options: CommandLineToArgvW failed w=
ith error =3D 0x%08x&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                 L&quot;Cannot validate options: CommandLineToArgvW=
 failed with error =3D 0x%08lx&quot;,</span><br><span>                  Get=
LastError());</span><br><span>         goto out;</span><br><span>     }</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1960?usp=3Demail">change 1960</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1960?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I7f910599f0f4005f06a88a93b40417ffa3=
7022a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1960 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--F+Hd7lYMvEs=--


--===============1925285584852432006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1925285584852432006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1925285584852432006==--

