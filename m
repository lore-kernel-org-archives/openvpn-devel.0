Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DC2C88E59
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qv8i8wgJXUaBs6tw5BZS44o3cOqkFe+YBqyrJJR8Fa4=; b=glF+KwzDgyH85xGvv5W/j6RiDG
	OJ+7a1yKNtm7iKI4Sdg3TU9hFLlDckqkVy6v7TbQPbjEDuAbsDTNo8tTZBeG76ctDEfm8TiFlqthS
	5bg+DO0QNVjtjVJ7uLeZx5a+QgVYjZ6MfMQylESJWi/69sWDG3qhQ4SgffHfFYm2kQms=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5ReF-0007ng-VD;
	Sat, 12 Sep 2026 17:36:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5ReE-0007nY-U4
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 17:36:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iwc6wMxMQLkvjAPNljYW7ikNxwEw4LtTft4CSwztFBk=; b=QtzJmFjvi46/BCNzr9Ixmoe6Y4
 FSorBc+CcPr7miDSAB/bxBAUzL0fsM6mWnkfDWP1dDJWNd+whyWPoEd9Y6KxX4+dN3Vd67TSyLaTV
 HmsZ+QXcrrXzS62Ue4ipPbhygEMc8m1+4qO17tagfRyfOkxeaYmVc/TjNnHMad4oVK/Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iwc6wMxMQLkvjAPNljYW7ikNxwEw4LtTft4CSwztFBk=; b=P
 Eyp7sSf2qxb8dZGRHFf2SQGdHwLuE5nmzmzphflU4j4xRgssjZmP6gmAI1zwylJx8E0hvQ4Td83sz
 G+de7DyqWZaLxBoqiE8J3EKdJgtfdCHJP7lO+RZb0oD7QGBUlHTq00VtP5ZXYrTLg+7guFlP9L1VD
 we44Qafopov8v14c=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5Re8-0007VJ-Eg for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 17:36:16 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f62ccdb1so245185f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 12 Sep 2026 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789234566; x=1789839366; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iwc6wMxMQLkvjAPNljYW7ikNxwEw4LtTft4CSwztFBk=;
 b=SmgH1buIjN48QwkGcPTu6iBHIg/UFWm71VT9Xs1+D8zezeW+pkCpmp4QPxzgprAJ/I
 o4geNbaHcbGfWr0q4N4oJdnEln02Sw8NXFD9YMAcPQij7nlHTNgjr9OGraVjtNVp8UrT
 b8Ct4hbRJdriaP1d99J6RhucDRsU/Al+Nj6ZWxReRFKKAhAifWwDkape8lhh5gz0mKZT
 GtEncIxe5ievwIValeMJuJdRS6awYOJGFTI6+DLrEo1yF3Ggp4tpEp5B3gEbSz8cv+AX
 ei3UJTSYUVQcfdlj3msiXx0VRrEMdRZCJ//ERdXOkdr43BLxvfe1NYVBirZBCJuGcVsS
 zjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789234566; x=1789839366;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iwc6wMxMQLkvjAPNljYW7ikNxwEw4LtTft4CSwztFBk=;
 b=gIabwnXXTStkjl5EMzdNl1wBHI6WygEocPgew443o9s9PPogh6ahuznOltVL7s9u3l
 PdxAG105b3wO877gE5Jo5jwyDFRB3V3C8aioL18cib/onH2B0/vIAp8sC3GnfbMR4kBb
 T+zPmxpdF090iI0BiVP3s8EuiITzKsAnndU9N4maoLADvXqCI3I5u+Ki1m3SPAbgmsNU
 ehfF4GI0Qc3UZPdrfArD793UlP9oax5EtQdOqKsg2/oyYOmBEKXs8OiCV6/K3+9xZItk
 KFjWpPVF2YAvFo/OPukEjEZoGkjBZROZUhkP2os5jueBk6QMu1RB+xtAMJdcOu8Tr4VK
 psMA==
X-Gm-Message-State: AFuF++n5aIkbe8qIK/W2w1nE0AjnEKkjepgc0+8uC7K4g23elk6aoI+1
 ZVxfbd2MFyZo4tryYHnhEveQYbnZF4eHh2hG0TJgy7ALG/WATWwlVcBTiLQTrDm2Zv6wU8SBCAA
 AIgn3Qf19UaFpMDyqOqC07/WoXH0I/r2b21+OVo2Rr3bgXZ6wabhLlpdaC6n94kwHl6Qd
X-Gm-Gg: AYBFou1UDSuUmjWRdYlrCNJEDxWtMafVmwD5GdmcbGtPLnJNfo42DxHAIRdV+1KvcG3
 aDShE3lAi2C0HA50tMjJ8ahrqaPsYMcgZQ79PiRg2zFCP8YyKK0og2nobgYeLb1A84NR8OX6v/R
 71KU3W0ITsm66z9B9JK8T74yvIEsMwEyLEB5AuMnUOI1obKL8HinNNApwj1CI0EVYs6wFQj6xvt
 L7mzL3JeMgxyORcB0JLWBBUY48voNxAvbgKrFkoZgm42Yr8oOrm+biwwCFGep1XQ94N513PrZLB
 qeDmdhhRpR6cIdy5kyIMqnKJCVX29fZ6g0etwNfDgRrXNz5xxzTZgqjAAekOryD3c/vnbYV7kh6
 W6S8730MeY9x383wQ9zwwt1ftwPpDf7omd1jhZtIDCFo+WjL4cNcrcqSpDjPk814XbPT8EZ+Af9
 1Ka7MByxQcpTgw7RHHnq5ZNsdFxWuDU/yUk8Kpfohh4/fJc4osQv/KgYcfs5/bY/rn4rK/86G0g
 3mlUPimpDl7phjfOqLJ/6F9s1THv1MtpHoPVKyaS293I7EclC7Bu77rwH3CAQHxru4mlO3mjwjy
 XUxUAjBslS7729/V0bqVocKOfwLzWObgcde789SQtEtXf4kx/XFtk7RG/cI3fw==
X-Received: by 2002:a05:6000:40ce:b0:486:e3bf:606 with SMTP id
 ffacd0b85a97d-486e987f52emr12186525f8f.18.1789234565574; 
 Sat, 12 Sep 2026 10:36:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb360409sm12985135f8f.36.2026.09.12.10.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 10:36:04 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 12 Sep 2026 17:36:03 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf
X-Gerrit-Change-Number: 1912
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1912?usp=email>
X-Gerrit-Commit: cf02cd4f1190acb0ae934e8d6ed8d953fb4b0ddd
In-Reply-To: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
References: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTI3MzY3MDAwLkkwYWM5MzRkYTVlZWVkMDQyNGI1NGVkOWI1MjhhMmJmMmI1NjFmZmRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6a5f62edbf0240580986c18e20aff324438cd65b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5Re8-0007VJ-Eg
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix various function
 parameters shadowing other symbols
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1240090068060119312=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1240090068060119312==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="szItg/0CUC4="; charset=UTF-8

--szItg/0CUC4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: Fix various function parameters shadowing othe=
r symbols
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

F=
ix various function parameters shadowing other symbols

Updated to a newer =
version of cppcheck (2=2E21=2E0) and it
reported a new group of issues wher=
e function parameters
shadow global variables or function names=2E

Used a =
variety of different solutions depending on context,
either renaming the gl=
obal variables or the function
parameters=2E

In one case I removed the par=
ameter since it only contained
the global variable anyway=2E

Where applica=
ble I have combined the change with fixing
occurrences of constParameterPoi=
nter to reduce conflicts
between different cppcheck fix commits=2E

Change-=
Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf
Signed-off-by: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912
Message-Id=
: <20260911204411=2E15575-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39107=2Ehtml
Sig=
ned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/gremli=
n=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/optio=
ns_string=2Ec
M src/openvpn/proxy=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/s=
sl_verify_backend=2Eh
M src/openvpn/ssl_verify_mbedtls=2Ec
M src/openvpn/ss=
l_verify_openssl=2Ec
M src/openvpnserv/interactive=2Ec
M src/openvpnserv/va=
lidate=2Ec
M tests/unit_tests/openvpn/test_pkcs11=2Ec
M tests/unit_tests/op=
envpnserv/test_openvpnserv=2Ec
13 files changed, 67 insertions(+), 66 delet=
ions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/12/1912/4

diff --git a/src/openvpn/gremlin=2Ec b/src/openvpn/gremlin=2Ec=

index 0bd9396=2E=2Ea3efc78 100644
--- a/src/openvpn/gremlin=2Ec
+++ b/src/=
openvpn/gremlin=2Ec
@@ -112,9 +112,9 @@
     return ret;
 }
 
-static bool =
initialized; /* GLOBAL */
-static bool up;          /* GLOBAL */
-static ti=
me_t next;      /* GLOBAL */
+static bool gremlin_initialized; /* GLOBAL */=

+static bool gremlin_up;          /* GLOBAL */
+static time_t gremlin_next=
;      /* GLOBAL */
 
 /*
  * Return false if we should drop a packet=2E
@@=
 -125,54 +125,54 @@
     const int up_down_level =3D GREMLIN_UP_DOWN_LEVEL(=
flags);
     const int drop_level =3D GREMLIN_DROP_LEVEL(flags);
 
-    if =
(!initialized)
+    if (!gremlin_initialized)
     {
-        initialized =
=3D true;
+        gremlin_initialized =3D true;
 
         if (up_down_lev=
el)
         {
-            up =3D false;
+            gremlin_up =3D false=
;
         }
         else
         {
-            up =3D true;
+          =
  gremlin_up =3D true;
         }
 
-        next =3D now;
+        gremlin=
_next =3D now;
     }
 
     if (up_down_level) /* change up/down state? */=

     {
-        if (now >=3D next)
+        if (now >=3D gremlin_next)
   =
      {
             int delta;
-            if (up)
+            if (greml=
in_up)
             {
                 delta =3D roll(down_low[up_down_leve=
l - 1], down_high[up_down_level - 1]);
-                up =3D false;
+    =
            gremlin_up =3D false;
             }
             else
        =
     {
                 delta =3D roll(up_low[up_down_level - 1], up_high[u=
p_down_level - 1]);
-                up =3D true;
+                gremlin_=
up =3D true;
             }
 
-            msg(D_GREMLIN, "GREMLIN: CONNECT=
ION GOING %s FOR %d SECONDS", (up ? "UP" : "DOWN"),
+            msg(D_GREM=
LIN, "GREMLIN: CONNECTION GOING %s FOR %d SECONDS", (gremlin_up ? "UP" : "D=
OWN"),
                 delta);
-            next =3D now + delta;
+       =
     gremlin_next =3D now + delta;
         }
     }
 
     if (drop_level)=

     {
-        if (up && flip(drop_freq[drop_level - 1]))
+        if (gr=
emlin_up && flip(drop_freq[drop_level - 1]))
         {
             dmsg(D=
_GREMLIN_VERBOSE, "GREMLIN: Random packet drop");
             return false=
;
         }
     }
 
-    return up;
+    return gremlin_up;
 }
 
 /*
diff=
 --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index c301687=2E=
=2E3039f24 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec=

@@ -3063,7 +3063,7 @@
 }
 
 void
-management_notify_client_needing_auth(st=
ruct management *management, const unsigned int mda_key_id,
+management_not=
ify_client_needing_auth(struct management *man, const unsigned int mda_key_=
id,
                                       struct man_def_auth_context *mda=
c, const struct env_set *es)
 {
     if (!(mdac->flags & DAF_CONNECTION_CLO=
SED))
@@ -3074,12 +3074,12 @@
             mode =3D "REAUTH";
         }
  =
       msg(M_CLIENT, ">CLIENT:%s,%lu,%u", mode, mdac->cid, mda_key_id);
-  =
      man_output_extra_env(management, "CLIENT");
-        if (management->=
connection=2Eenv_filter_level > 0)
+        man_output_extra_env(man, "CLIE=
NT");
+        if (man->connection=2Eenv_filter_level > 0)
         {
-    =
        man_output_peer_info_env(management, mdac);
+            man_output=
_peer_info_env(man, mdac);
         }
-        man_output_env(es, true, man=
agement->connection=2Eenv_filter_level, "CLIENT");
+        man_output_env(=
es, true, man->connection=2Eenv_filter_level, "CLIENT");
         mdac->fla=
gs |=3D DAF_INITIAL_AUTH;
     }
 }
@@ -3105,23 +3105,24 @@
 }
 
 void
-man=
agement_connection_established(struct management *management, struct man_de=
f_auth_context *mdac,
+management_connection_established(struct management =
*man, struct man_def_auth_context *mdac,
                                  =
 const struct env_set *es)
 {
     mdac->flags |=3D DAF_CONNECTION_ESTABLIS=
HED;
     msg(M_CLIENT, ">CLIENT:ESTABLISHED,%lu", mdac->cid);
-    man_out=
put_extra_env(management, "CLIENT");
-    man_output_env(es, true, manageme=
nt->connection=2Eenv_filter_level, "CLIENT");
+    man_output_extra_env(man=
, "CLIENT");
+    man_output_env(es, true, man->connection=2Eenv_filter_lev=
el, "CLIENT");
 }
 
 void
-management_notify_client_close(struct management=
 *management, struct man_def_auth_context *mdac,
+management_notify_client_=
close(const struct management *man,
+                               struct =
man_def_auth_context *mdac,
                                const struct en=
v_set *es)
 {
     if ((mdac->flags & DAF_INITIAL_AUTH) && !(mdac->flags & =
DAF_CONNECTION_CLOSED))
     {
         msg(M_CLIENT, ">CLIENT:DISCONNECT,%=
lu", mdac->cid);
-        man_output_env(es, true, management->connection=
=2Eenv_filter_level, "CLIENT");
+        man_output_env(es, true, man->conn=
ection=2Eenv_filter_level, "CLIENT");
         mdac->flags |=3D DAF_CONNECT=
ION_CLOSED;
     }
 }
@@ -3981,12 +3982,12 @@
  */
 
 struct command_line *=

-command_line_new(const size_t buf_len)
+command_line_new(const size_t len=
)
 {
     struct command_line *cl;
     ALLOC_OBJ_CLEAR(cl, struct command_=
line);
-    cl->buf =3D alloc_buf(buf_len);
-    cl->residual =3D alloc_buf=
(buf_len);
+    cl->buf =3D alloc_buf(len);
+    cl->residual =3D alloc_buf=
(len);
     return cl;
 }
 
diff --git a/src/openvpn/manage=2Eh b/src/openv=
pn/manage=2Eh
index 3ab937c=2E=2E1e7855d 100644
--- a/src/openvpn/manage=2E=
h
+++ b/src/openvpn/manage=2Eh
@@ -389,15 +389,15 @@
 
 void management_not=
ify_generic(const char *str);
 
-void management_notify_client_needing_auth=
(struct management *management,
+void management_notify_client_needing_auth=
(struct management *man,
                                            const =
unsigned int auth_id,
                                            struct ma=
n_def_auth_context *mdac,
                                            const=
 struct env_set *es);
 
-void management_connection_established(struct mana=
gement *management,
+void management_connection_established(struct manageme=
nt *man,
                                        struct man_def_auth_contex=
t *mdac, const struct env_set *es);
 
-void management_notify_client_close(=
struct management *management,
+void management_notify_client_close(const s=
truct management *man,
                                     struct man_def_=
auth_context *mdac, const struct env_set *es);
 
 void management_learn_add=
r(struct man_def_auth_context *mdac,
diff --git a/src/openvpn/options_strin=
g=2Ec b/src/openvpn/options_string=2Ec
index d3b29b8=2E=2E88ab798 100644
--=
- a/src/openvpn/options_string=2Ec
+++ b/src/openvpn/options_string=2Ec
@@ =
-396,12 +396,12 @@
 #endif
 
 char *
-options_string_extract_option(const c=
har *options_string, const char *opt_name, struct gc_arena *gc)
+options_st=
ring_extract_option(const char *option_string, const char *opt_name, struct=
 gc_arena *gc)
 {
     char *ret =3D NULL;
     const size_t opt_name_len =
=3D strlen(opt_name);
 
-    const char *p =3D options_string;
+    const c=
har *p =3D option_string;
     while (p)
     {
         if (0 =3D=3D strnc=
mp(p, opt_name, opt_name_len) && strlen(p) > (opt_name_len + 1)
diff --git =
a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index e0700aa=2E=2E74a6cf9 =
100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -184,10 +=
184,10 @@
 }
 
 bool
-proxy_send(socket_descriptor_t sd, const void *buf, s=
ize_t buf_len)
+proxy_send(socket_descriptor_t sd, const void *buf, size_t =
len)
 {
-    const ssize_t size =3D openvpn_send(sd, buf, buf_len, MSG_NOSI=
GNAL);
-    if (size !=3D (ssize_t)buf_len)
+    const ssize_t size =3D ope=
nvpn_send(sd, buf, len, MSG_NOSIGNAL);
+    if (size !=3D (ssize_t)len)
   =
  {
         msg(D_LINK_ERRORS | M_ERRNO, "proxy_send: TCP port write faile=
d on send()");
         return false;
diff --git a/src/openvpn/ssl=2Ec b/sr=
c/openvpn/ssl=2Ec
index 48508e5=2E=2E76150d4 100644
--- a/src/openvpn/ssl=
=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1360,7 +1360,7 @@
 
 static void
 init_e=
poch_keys(struct key_state *ks, struct tls_multi *multi, const struct key_t=
ype *key_type,
-                bool server, struct key2 *key2)
+          =
      bool server, const struct key2 *key2)
 {
     /* For now we hardcode =
this to be 4 for the software based data channel
      * DCO based implemen=
tations/HW implementation might adjust this number
@@ -1403,14 +1403,14 @@
=
 
 static void
 init_key_contexts(struct key_state *ks, struct tls_multi *m=
ulti, const struct key_type *key_type,
-                  bool server, stru=
ct key2 *key2, bool dco_enabled)
+                  bool server, const stru=
ct key2 *key2, bool dco)
 {
     struct key_ctx_bi *key =3D &ks->crypto_opt=
ions=2Ekey_ctx_bi;
 
     /* Initialize key contexts */
     int key_direct=
ion =3D server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;
 
-    if (d=
co_enabled)
+    if (dco)
     {
         if (key->encrypt=2Ehmac)
        =
 {
diff --git a/src/openvpn/ssl_verify_backend=2Eh b/src/openvpn/ssl_verify=
_backend=2Eh
index 9272cae=2E=2E46720d6 100644
--- a/src/openvpn/ssl_verify=
_backend=2Eh
+++ b/src/openvpn/ssl_verify_backend=2Eh
@@ -220,14 +220,14 @@=

  * Check X=2E509 Netscape certificate type field, if available=2E
  *
  *=
 @param cert          Certificate to check=2E
- * @param usage         One =
of \c NS_CERT_CHECK_CLIENT, \c NS_CERT_CHECK_SERVER,
+ * @param cert_type  =
   One of \c NS_CERT_CHECK_CLIENT, \c NS_CERT_CHECK_SERVER,
  *            =
          or \c NS_CERT_CHECK_NONE=2E
  *
  * @return              \c SUCCE=
SS if NS_CERT_CHECK_NONE or if the certificate has
  *                     =
 the expected bit set=2E \c FAILURE if the certificate does
  *            =
          not have NS cert type verification or the wrong bit set=2E
  */
-=
result_t x509_verify_ns_cert_type(openvpn_x509_cert_t *cert, const int usag=
e);
+result_t x509_verify_ns_cert_type(openvpn_x509_cert_t *cert, const int=
 cert_type);
 
 /*
  * Verify X=2E509 key usage extension field=2E
diff --g=
it a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2E=
c
index 9f676ed=2E=2Ec4bae40 100644
--- a/src/openvpn/ssl_verify_mbedtls=2E=
c
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -753,9 +753,9 @@
 /* Dummy fu=
nction because Netscape certificate types are not supported in OpenVPN with=
 mbedtls=2E
  * Returns SUCCESS if usage is NS_CERT_CHECK_NONE, FAILURE oth=
erwise=2E */
 result_t
-x509_verify_ns_cert_type(mbedtls_x509_crt *cert, co=
nst int usage)
+x509_verify_ns_cert_type(mbedtls_x509_crt *cert, const int =
cert_type)
 {
-    if (usage =3D=3D NS_CERT_CHECK_NONE)
+    if (cert_type =
=3D=3D NS_CERT_CHECK_NONE)
     {
         return SUCCESS;
     }
diff --gi=
t a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec=

index a6307f6=2E=2E6073e4e 100644
--- a/src/openvpn/ssl_verify_openssl=2Ec=

+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -629,13 +629,13 @@
 }
 
 resul=
t_t
-x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_cert, const int usa=
ge)
+x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_cert, const int cer=
t_type)
 {
-    if (usage =3D=3D NS_CERT_CHECK_NONE)
+    if (cert_type =3D=
=3D NS_CERT_CHECK_NONE)
     {
         return SUCCESS;
     }
-    if (usa=
ge =3D=3D NS_CERT_CHECK_CLIENT)
+    if (cert_type =3D=3D NS_CERT_CHECK_CLI=
ENT)
     {
         /*
          * Unfortunately, X509_check_purpose() bef=
ore OpenSSL 4=2E0 does some weird thing that
@@ -668,7 +668,7 @@
         }=

         return result;
     }
-    if (usage =3D=3D NS_CERT_CHECK_SERVER)=

+    if (cert_type =3D=3D NS_CERT_CHECK_SERVER)
     {
         /*
       =
   * Unfortunately, X509_check_purpose() before OpenSSL 4=2E0 does some wei=
rd thing that
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnser=
v/interactive=2Ec
index d2288b9=2E=2E7819f5a 100644
--- a/src/openvpnserv/i=
nteractive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -3848,8 +3848,8 @@
=
 
 
 static DWORD
-UpdateWaitHandles(LPHANDLE *handles_ptr, LPDWORD count, =
HANDLE io_event, HANDLE exit_event,
-                  list_item_t *threads=
)
+UpdateWaitHandles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE io_event,=

+                  const list_item_t *threads)
 {
     static DWORD size =
=3D 10;
     static LPHANDLE handles =3D NULL;
@@ -3998,7 +3998,7 @@
      =
   goto out;
     }
 
-    error =3D UpdateWaitHandles(&handles, &handle_co=
unt, io_event, exit_event, threads);
+    error =3D UpdateWaitHandles(&hand=
les, &handle_count, io_event, threads);
     if (error !=3D NO_ERROR)
     =
{
         goto out;
@@ -4065,7 +4065,7 @@
                 if (!error)
   =
              {
                     error =3D
-                        Upd=
ateWaitHandles(&handles, &handle_count, io_event, exit_event, threads);
+  =
                      UpdateWaitHandles(&handles, &handle_count, io_event, =
threads);
                 }
                 if (error)
                 {=

@@ -4073,7 +4073,7 @@
                                 &exit_event);
     =
                /* Update wait handles again after removing the last worker=
 thread */
                     RemoveListItem(&threads, CmpHandle, thread)=
;
-                    UpdateWaitHandles(&handles, &handle_count, io_event,=
 exit_event, threads);
+                    UpdateWaitHandles(&handles, &ha=
ndle_count, io_event, threads);
                     TerminateThread(thread=
, 1);
                     CloseHandleEx(&thread);
                     Clo=
seHandleEx(&pipe);
@@ -4113,7 +4113,7 @@
 
             /* Worker thread en=
ded */
             HANDLE thread =3D RemoveListItem(&threads, CmpHandle, h=
andles[error]);
-            UpdateWaitHandles(&handles, &handle_count, io_=
event, exit_event, threads);
+            UpdateWaitHandles(&handles, &hand=
le_count, io_event, threads);
             CloseHandleEx(&thread);
        =
 }
     }
diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/valid=
ate=2Ec
index 8e529b9=2E=2E6a13a06 100644
--- a/src/openvpnserv/validate=2E=
c
+++ b/src/openvpnserv/validate=2Ec
@@ -27,7 +27,7 @@
 #include <pathcch=
=2Eh>
 #include <lm=2Eh>
 
-static const WCHAR *white_list[] =3D {
+static =
const WCHAR *global_white_list[] =3D {
     L"auth-retry",
     L"config",
=
     L"log",
@@ -335,7 +335,7 @@
     }
 
     /* option name starts at 2 c=
haracters from argv[i] */
-    if (OptionLookup(argv[0] + 2, white_list) =
=3D=3D -1) /* not found */
+    if (OptionLookup(argv[0] + 2, global_white_=
list) =3D=3D -1) /* not found */
     {
         return FALSE;
     }
diff =
--git a/tests/unit_tests/openvpn/test_pkcs11=2Ec b/tests/unit_tests/openvpn=
/test_pkcs11=2Ec
index 042bd8b=2E=2Ea54c504 100644
--- a/tests/unit_tests/o=
penvpn/test_pkcs11=2Ec
+++ b/tests/unit_tests/openvpn/test_pkcs11=2Ec
@@ -1=
37,7 +137,7 @@
 static char softhsm2_conf_path[] =3D "softhsm2_conf_XXXXXX"=
;
 int num_certs;
 static const char *pkcs11_id_current;
-struct env_set *e=
s;
+struct env_set *test_set;
 
 /* Fill-in certs[] array */
 void
@@ -218,=
15 +218,15 @@
 
     /* environment */
     setenv("SOFTHSM2_CONF", softhsm=
2_conf_path, 1);
-    es =3D env_set_create(NULL);
-    setenv_str(es, "SOF=
THSM2_CONF", softhsm2_conf_path);
-    setenv_str(es, "GNUTLS_PIN", PIN);
+=
    test_set =3D env_set_create(NULL);
+    setenv_str(test_set, "SOFTHSM2_=
CONF", softhsm2_conf_path);
+    setenv_str(test_set, "GNUTLS_PIN", PIN);
 =

     /* init the token using the temporary location as storage */
     str=
uct argv a =3D argv_new();
     argv_printf(&a, "%s --init-token --free --l=
abel \"%s\" --so-pin %s --pin %s",
                 SOFTHSM2_UTIL_PATH, tok=
en_name, PIN, PIN);
-    assert_true(openvpn_execve_check(&a, es, 0, "Faile=
d to initialize token"));
+    assert_true(openvpn_execve_check(&a, test_se=
t, 0, "Failed to initialize token"));
 
     /* Import certificates and key=
s in our test database into the token */
     char cert[] =3D "cert_XXXXXX"=
;
@@ -263,14 +263,14 @@
         argv_printf(
             &a, "%s --provid=
er %s --load-certificate %s --label \"%s\" --id %08x --login --write",
    =
         P11TOOL_PATH, SOFTHSM2_MODULE_PATH, cert, c->friendly_name, num_ce=
rts + 1);
-        assert_true(openvpn_execve_check(&a, es, 0, "Failed to u=
pload certificate into token"));
+        assert_true(openvpn_execve_check(=
&a, test_set, 0, "Failed to upload certificate into token"));
 
         ar=
gv_free(&a);
         a =3D argv_new();
         argv_printf(&a,
          =
           "%s --provider %s --load-privkey %s --label \"%s\" --id %08x --l=
ogin --write",
                     P11TOOL_PATH, SOFTHSM2_MODULE_PATH, key=
, c->friendly_name, num_certs + 1);
-        assert_true(openvpn_execve_che=
ck(&a, es, 0, "Failed to upload key into token"));
+        assert_true(ope=
nvpn_execve_check(&a, test_set, 0, "Failed to upload key into token"));
 
 =
        assert_int_equal(ftruncate(cert_fd, 0), 0);
         assert_int_equ=
al(ftruncate(key_fd, 0), 0);
@@ -294,7 +294,7 @@
     struct argv a =3D arg=
v_new();
 
     argv_printf(&a, "%s --delete-token --token \"%s\"", SOFTHSM=
2_UTIL_PATH, token_name);
-    assert_true(openvpn_execve_check(&a, es, 0, =
"Failed to delete token"));
+    assert_true(openvpn_execve_check(&a, test_=
set, 0, "Failed to delete token"));
     argv_free(&a);
 
     rmdir(sofths=
m2_tokens_path); /* this must be empty after delete token */
@@ -304,7 +304=
,7 @@
         free(c->p11_id);
         c->p11_id =3D NULL;
     }
-    en=
v_set_destroy(es);
+    env_set_destroy(test_set);
     return 0;
 }
 
diff=
 --git a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec b/tests/unit_tes=
ts/openvpnserv/test_openvpnserv=2Ec
index e01b0e3=2E=2E4ca715b 100644
--- a=
/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
+++ b/tests/unit_tests/o=
penvpnserv/test_openvpnserv=2Ec
@@ -35,7 +35,7 @@
 #include "interactive=2E=
c"
 
 BOOL
-ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STAT=
US *status)
+ReportStatusToSCMgr(SERVICE_STATUS_HANDLE svc_handle, SERVICE_=
STATUS *svc_status)
 {
     return TRUE;
 }

-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf
Gerrit=
-Change-Number: 1912
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>

--szItg/0CUC4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">Fix various function par=
ameters shadowing other symbols<br><br>Updated to a newer version of cppche=
ck (2=2E21=2E0) and it<br>reported a new group of issues where function par=
ameters<br>shadow global variables or function names=2E<br><br>Used a varie=
ty of different solutions depending on context,<br>either renaming the glob=
al variables or the function<br>parameters=2E<br><br>In one case I removed =
the parameter since it only contained<br>the global variable anyway=2E<br><=
br>Where applicable I have combined the change with fixing<br>occurrences o=
f constParameterPointer to reduce conflicts<br>between different cppcheck f=
ix commits=2E<br><br>Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked=
-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1912<br>Message-Id: &lt;20260911204411=2E=
15575-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg39107=2Ehtml<br>Signed-off-by:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/greml=
in=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/ope=
nvpn/options_string=2Ec<br>M src/openvpn/proxy=2Ec<br>M src/openvpn/ssl=2Ec=
<br>M src/openvpn/ssl_verify_backend=2Eh<br>M src/openvpn/ssl_verify_mbedtl=
s=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br>M src/openvpnserv/interact=
ive=2Ec<br>M src/openvpnserv/validate=2Ec<br>M tests/unit_tests/openvpn/tes=
t_pkcs11=2Ec<br>M tests/unit_tests/openvpnserv/test_openvpnserv=2Ec<br>13 f=
iles changed, 67 insertions(+), 66 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/12/1912/4<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/gremlin=2Ec b/src/openvpn/gremlin=2Ec</spa=
n><br><span>index 0bd9396=2E=2Ea3efc78 100644</span><br><span>--- a/src/ope=
nvpn/gremlin=2Ec</span><br><span>+++ b/src/openvpn/gremlin=2Ec</span><br><s=
pan>@@ -112,9 +112,9 @@</span><br><span>     return ret;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic bool initialized; /* GLOBAL */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static bool up;          /* GLOBAL */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static time_t next;      /* GLOBAL */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static bool gremlin_initiali=
zed; /* GLOBAL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic bool gremlin_up;          /* GLOBAL */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static time_t gremlin_next;      /* GLOBAL */</span=
><br><span> </span><br><span> /*</span><br><span>  * Return false if we sho=
uld drop a packet=2E</span><br><span>@@ -125,54 +125,54 @@</span><br><span>=
     const int up_down_level =3D GREMLIN_UP_DOWN_LEVEL(flags);</span><br><s=
pan>     const int drop_level =3D GREMLIN_DROP_LEVEL(flags);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!initializ=
ed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!gremlin=
_initialized)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        initialized =3D true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        gremlin_initialized =3D true;</span><br><s=
pan> </span><br><span>         if (up_down_level)</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            up =3D f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gr=
emlin_up =3D false;</span><br><span>         }</span><br><span>         els=
e</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            up =3D true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            gremlin_up =3D true;</span><br><span>         }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 next =3D now;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   gremlin_next =3D now;</span><br><span>     }</span><br><span> </span><br=
><span>     if (up_down_level) /* change up/down state? */</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (now=
 &gt;=3D next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (now &gt;=3D gremlin_next)</span><br><span>         {</span><br><span=
>             int delta;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            if (up)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (gremlin_up)</span><br><span>             {</span><br><sp=
an>                 delta =3D roll(down_low[up_down_level - 1], down_high[u=
p_down_level - 1]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              up =3D false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                gremlin_up =3D false;</span><br><span>             =
}</span><br><span>             else</span><br><span>             {</span><b=
r><span>                 delta =3D roll(up_low[up_down_level - 1], up_high[=
up_down_level - 1]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               up =3D true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                gremlin_up =3D true;</span><br><span>             }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         msg(D_GREMLIN, &quot;GREMLIN: CONNECTION GOING %s FOR %d SECONDS&q=
uot;, (up ? &quot;UP&quot; : &quot;DOWN&quot;),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(D_GREMLIN, &quot;GREMLIN: CONNE=
CTION GOING %s FOR %d SECONDS&quot;, (gremlin_up ? &quot;UP&quot; : &quot;D=
OWN&quot;),</span><br><span>                 delta);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            next =3D now + delta;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            gremlin_next =3D =
now + delta;</span><br><span>         }</span><br><span>     }</span><br><s=
pan> </span><br><span>     if (drop_level)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (up &amp;&amp; flip(=
drop_freq[drop_level - 1]))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (gremlin_up &amp;&amp; flip(drop_freq[drop_level - 1]))<=
/span><br><span>         {</span><br><span>             dmsg(D_GREMLIN_VERB=
OSE, &quot;GREMLIN: Random packet drop&quot;);</span><br><span>            =
 return false;</span><br><span>         }</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return up;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return gremlin_=
up;</span><br><span> }</span><br><span> </span><br><span> /*</span><br><spa=
n>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><s=
pan>index c301687=2E=2E3039f24 100644</span><br><span>--- a/src/openvpn/man=
age=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -30=
63,7 +3063,7 @@</span><br><span> }</span><br><span> </span><br><span> void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_notify_clie=
nt_needing_auth(struct management *management, const unsigned int mda_key_i=
d,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_notify=
_client_needing_auth(struct management *man, const unsigned int mda_key_id,=
</span><br><span>                                       struct man_def_auth=
_context *mdac, const struct env_set *es)</span><br><span> {</span><br><spa=
n>     if (!(mdac-&gt;flags &amp; DAF_CONNECTION_CLOSED))</span><br><span>@=
@ -3074,12 +3074,12 @@</span><br><span>             mode =3D &quot;REAUTH&q=
uot;;</span><br><span>         }</span><br><span>         msg(M_CLIENT, &qu=
ot;&gt;CLIENT:%s,%lu,%u&quot;, mode, mdac-&gt;cid, mda_key_id);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        man_output_extra_env(mana=
gement, &quot;CLIENT&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (management-&gt;connection=2Eenv_filter_level &gt; 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        man_output_extr=
a_env(man, &quot;CLIENT&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (man-&gt;connection=2Eenv_filter_level &gt; 0)</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            man_output_peer_info_env(management, mdac);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            man_output_peer_info_env(ma=
n, mdac);</span><br><span>         }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        man_output_env(es, true, management-&gt;connection=
=2Eenv_filter_level, &quot;CLIENT&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        man_output_env(es, true, man-&gt;connection=
=2Eenv_filter_level, &quot;CLIENT&quot;);</span><br><span>         mdac-&gt=
;flags |=3D DAF_INITIAL_AUTH;</span><br><span>     }</span><br><span> }</sp=
an><br><span>@@ -3105,23 +3105,24 @@</span><br><span> }</span><br><span> </=
span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-m=
anagement_connection_established(struct management *management, struct man_=
def_auth_context *mdac,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+management_connection_established(struct management *man, struct man_de=
f_auth_context *mdac,</span><br><span>                                   co=
nst struct env_set *es)</span><br><span> {</span><br><span>     mdac-&gt;fl=
ags |=3D DAF_CONNECTION_ESTABLISHED;</span><br><span>     msg(M_CLIENT, &qu=
ot;&gt;CLIENT:ESTABLISHED,%lu&quot;, mdac-&gt;cid);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    man_output_extra_env(management, &quot;=
CLIENT&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    man=
_output_env(es, true, management-&gt;connection=2Eenv_filter_level, &quot;C=
LIENT&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ma=
n_output_extra_env(man, &quot;CLIENT&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    man_output_env(es, true, man-&gt;connection=2E=
env_filter_level, &quot;CLIENT&quot;);</span><br><span> }</span><br><span> =
</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-management_notify_client_close(struct management *management, struct man_d=
ef_auth_context *mdac,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+management_notify_client_close(const struct management *man,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
struct man_def_auth_context *mdac,</span><br><span>                        =
        const struct env_set *es)</span><br><span> {</span><br><span>     i=
f ((mdac-&gt;flags &amp; DAF_INITIAL_AUTH) &amp;&amp; !(mdac-&gt;flags &amp=
; DAF_CONNECTION_CLOSED))</span><br><span>     {</span><br><span>         m=
sg(M_CLIENT, &quot;&gt;CLIENT:DISCONNECT,%lu&quot;, mdac-&gt;cid);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        man_output_env(es, tru=
e, management-&gt;connection=2Eenv_filter_level, &quot;CLIENT&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        man_output_env(es=
, true, man-&gt;connection=2Eenv_filter_level, &quot;CLIENT&quot;);</span><=
br><span>         mdac-&gt;flags |=3D DAF_CONNECTION_CLOSED;</span><br><spa=
n>     }</span><br><span> }</span><br><span>@@ -3981,12 +3982,12 @@</span><=
br><span>  */</span><br><span> </span><br><span> struct command_line *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-command_line_new(const siz=
e_t buf_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+command=
_line_new(const size_t len)</span><br><span> {</span><br><span>     struct =
command_line *cl;</span><br><span>     ALLOC_OBJ_CLEAR(cl, struct command_l=
ine);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cl-&gt;buf =
=3D alloc_buf(buf_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    cl-&gt;residual =3D alloc_buf(buf_len);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    cl-&gt;buf =3D alloc_buf(len);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    cl-&gt;residual =3D alloc_buf(=
len);</span><br><span>     return cl;</span><br><span> }</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2E=
h</span><br><span>index 3ab937c=2E=2E1e7855d 100644</span><br><span>--- a/s=
rc/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span><b=
r><span>@@ -389,15 +389,15 @@</span><br><span> </span><br><span> void manag=
ement_notify_generic(const char *str);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void management_notify_client_needing_au=
th(struct management *management,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+void management_notify_client_needing_auth(struct management =
*man,</span><br><span>                                            const uns=
igned int auth_id,</span><br><span>                                        =
    struct man_def_auth_context *mdac,</span><br><span>                    =
                        const struct env_set *es);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-void management_connection_e=
stablished(struct management *management,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void management_connection_established(struct managem=
ent *man,</span><br><span>                                        struct ma=
n_def_auth_context *mdac, const struct env_set *es);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void management_notify_cli=
ent_close(struct management *management,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void management_notify_client_close(const struct manag=
ement *man,</span><br><span>                                     struct man=
_def_auth_context *mdac, const struct env_set *es);</span><br><span> </span=
><br><span> void management_learn_addr(struct man_def_auth_context *mdac,</=
span><br><span>diff --git a/src/openvpn/options_string=2Ec b/src/openvpn/op=
tions_string=2Ec</span><br><span>index d3b29b8=2E=2E88ab798 100644</span><b=
r><span>--- a/src/openvpn/options_string=2Ec</span><br><span>+++ b/src/open=
vpn/options_string=2Ec</span><br><span>@@ -396,12 +396,12 @@</span><br><spa=
n> #endif</span><br><span> </span><br><span> char *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-options_string_extract_option(const char *o=
ptions_string, const char *opt_name, struct gc_arena *gc)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+options_string_extract_option(const c=
har *option_string, const char *opt_name, struct gc_arena *gc)</span><br><s=
pan> {</span><br><span>     char *ret =3D NULL;</span><br><span>     const =
size_t opt_name_len =3D strlen(opt_name);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    const char *p =3D options_string;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *p =
=3D option_string;</span><br><span>     while (p)</span><br><span>     {</s=
pan><br><span>         if (0 =3D=3D strncmp(p, opt_name, opt_name_len) &amp=
;&amp; strlen(p) &gt; (opt_name_len + 1)</span><br><span>diff --git a/src/o=
penvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><span>index e0700aa=2E=
=2E74a6cf9 100644</span><br><span>--- a/src/openvpn/proxy=2Ec</span><br><sp=
an>+++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -184,10 +184,10 @@</span>=
<br><span> }</span><br><span> </span><br><span> bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-proxy_send(socket_descriptor_t sd, const vo=
id *buf, size_t buf_len)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+proxy_send(socket_descriptor_t sd, const void *buf, size_t len)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 ssize_t size =3D openvpn_send(sd, buf, buf_len, MSG_NOSIGNAL);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (size !=3D (ssize_t)buf_le=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ssize_t=
 size =3D openvpn_send(sd, buf, len, MSG_NOSIGNAL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (size !=3D (ssize_t)len)</span><br=
><span>     {</span><br><span>         msg(D_LINK_ERRORS | M_ERRNO, &quot;p=
roxy_send: TCP port write failed on send()&quot;);</span><br><span>        =
 return false;</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openv=
pn/ssl=2Ec</span><br><span>index 48508e5=2E=2E76150d4 100644</span><br><spa=
n>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span=
><br><span>@@ -1360,7 +1360,7 @@</span><br><span> </span><br><span> static =
void</span><br><span> init_epoch_keys(struct key_state *ks, struct tls_mult=
i *multi, const struct key_type *key_type,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                bool server, struct key2 *key2)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                bool serve=
r, const struct key2 *key2)</span><br><span> {</span><br><span>     /* For =
now we hardcode this to be 4 for the software based data channel</span><br>=
<span>      * DCO based implementations/HW implementation might adjust this=
 number</span><br><span>@@ -1403,14 +1403,14 @@</span><br><span> </span><br=
><span> static void</span><br><span> init_key_contexts(struct key_state *ks=
, struct tls_multi *multi, const struct key_type *key_type,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                  bool server, struct=
 key2 *key2, bool dco_enabled)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                  bool server, const struct key2 *key2, bool dco=
)</span><br><span> {</span><br><span>     struct key_ctx_bi *key =3D &amp;k=
s-&gt;crypto_options=2Ekey_ctx_bi;</span><br><span> </span><br><span>     /=
* Initialize key contexts */</span><br><span>     int key_direction =3D ser=
ver ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco_enabled)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco)</span><br><sp=
an>     {</span><br><span>         if (key-&gt;encrypt=2Ehmac)</span><br><s=
pan>         {</span><br><span>diff --git a/src/openvpn/ssl_verify_backend=
=2Eh b/src/openvpn/ssl_verify_backend=2Eh</span><br><span>index 9272cae=2E=
=2E46720d6 100644</span><br><span>--- a/src/openvpn/ssl_verify_backend=2Eh<=
/span><br><span>+++ b/src/openvpn/ssl_verify_backend=2Eh</span><br><span>@@=
 -220,14 +220,14 @@</span><br><span>  * Check X=2E509 Netscape certificate =
type field, if available=2E</span><br><span>  *</span><br><span>  * @param =
cert          Certificate to check=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @param usage         One of \c NS_CERT_CHECK_CLIENT, \c =
NS_CERT_CHECK_SERVER,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param cert_type     One of \c NS_CERT_CHECK_CLIENT, \c NS_CERT_CHECK_=
SERVER,</span><br><span>  *                      or \c NS_CERT_CHECK_NONE=
=2E</span><br><span>  *</span><br><span>  * @return              \c SUCCESS=
 if NS_CERT_CHECK_NONE or if the certificate has</span><br><span>  *       =
               the expected bit set=2E \c FAILURE if the certificate does</=
span><br><span>  *                      not have NS cert type verification =
or the wrong bit set=2E</span><br><span>  */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-result_t x509_verify_ns_cert_type(openvpn_x509_cert_=
t *cert, const int usage);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+result_t x509_verify_ns_cert_type(openvpn_x509_cert_t *cert, const i=
nt cert_type);</span><br><span> </span><br><span> /*</span><br><span>  * Ve=
rify X=2E509 key usage extension field=2E</span><br><span>diff --git a/src/=
openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec</span><=
br><span>index 9f676ed=2E=2Ec4bae40 100644</span><br><span>--- a/src/openvp=
n/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_mbedt=
ls=2Ec</span><br><span>@@ -753,9 +753,9 @@</span><br><span> /* Dummy functi=
on because Netscape certificate types are not supported in OpenVPN with mbe=
dtls=2E</span><br><span>  * Returns SUCCESS if usage is NS_CERT_CHECK_NONE,=
 FAILURE otherwise=2E */</span><br><span> result_t</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-x509_verify_ns_cert_type(mbedtls_x509_crt *cer=
t, const int usage)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
x509_verify_ns_cert_type(mbedtls_x509_crt *cert, const int cert_type)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
usage =3D=3D NS_CERT_CHECK_NONE)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (cert_type =3D=3D NS_CERT_CHECK_NONE)</span><br><span> =
    {</span><br><span>         return SUCCESS;</span><br><span>     }</span=
><br><span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ss=
l_verify_openssl=2Ec</span><br><span>index a6307f6=2E=2E6073e4e 100644</spa=
n><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>+++ b/=
src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@ -629,13 +629,13 @@</s=
pan><br><span> }</span><br><span> </span><br><span> result_t</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-x509_verify_ns_cert_type(openvpn_x50=
9_cert_t *peer_cert, const int usage)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_cert, =
const int cert_type)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (usage =3D=3D NS_CERT_CHECK_NONE)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (cert_type =3D=3D NS_CERT_CHE=
CK_NONE)</span><br><span>     {</span><br><span>         return SUCCESS;</s=
pan><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (usage =3D=3D NS_CERT_CHECK_CLIENT)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (cert_type =3D=3D NS_CERT_CHECK_CLIENT)</span>=
<br><span>     {</span><br><span>         /*</span><br><span>          * Un=
fortunately, X509_check_purpose() before OpenSSL 4=2E0 does some weird thin=
g that</span><br><span>@@ -668,7 +668,7 @@</span><br><span>         }</span=
><br><span>         return result;</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (usage =3D=3D NS_CERT_CHECK_SERV=
ER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cert_typ=
e =3D=3D NS_CERT_CHECK_SERVER)</span><br><span>     {</span><br><span>     =
    /*</span><br><span>          * Unfortunately, X509_check_purpose() befo=
re OpenSSL 4=2E0 does some weird thing that</span><br><span>diff --git a/sr=
c/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><=
span>index d2288b9=2E=2E7819f5a 100644</span><br><span>--- a/src/openvpnser=
v/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</sp=
an><br><span>@@ -3848,8 +3848,8 @@</span><br><span> </span><br><span> </spa=
n><br><span> static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-UpdateWaitHandles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE io_event=
, HANDLE exit_event,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                 list_item_t *threads)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+UpdateWaitHandles(LPHANDLE *handles_ptr, LPDWORD count, =
HANDLE io_event,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
               const list_item_t *threads)</span><br><span> {</span><br><sp=
an>     static DWORD size =3D 10;</span><br><span>     static LPHANDLE hand=
les =3D NULL;</span><br><span>@@ -3998,7 +3998,7 @@</span><br><span>       =
  goto out;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    error =3D UpdateWaitHandles(&amp;handle=
s, &amp;handle_count, io_event, exit_event, threads);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    error =3D UpdateWaitHandles(&amp;hand=
les, &amp;handle_count, io_event, threads);</span><br><span>     if (error =
!=3D NO_ERROR)</span><br><span>     {</span><br><span>         goto out;</s=
pan><br><span>@@ -4065,7 +4065,7 @@</span><br><span>                 if (!e=
rror)</span><br><span>                 {</span><br><span>                  =
   error =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
               UpdateWaitHandles(&amp;handles, &amp;handle_count, io_event,=
 exit_event, threads);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        UpdateWaitHandles(&amp;handles, &amp;handle_coun=
t, io_event, threads);</span><br><span>                 }</span><br><span> =
                if (error)</span><br><span>                 {</span><br><sp=
an>@@ -4073,7 +4073,7 @@</span><br><span>                                 &=
amp;exit_event);</span><br><span>                     /* Update wait handle=
s again after removing the last worker thread */</span><br><span>          =
           RemoveListItem(&amp;threads, CmpHandle, thread);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    UpdateWaitHandles=
(&amp;handles, &amp;handle_count, io_event, exit_event, threads);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    UpdateWai=
tHandles(&amp;handles, &amp;handle_count, io_event, threads);</span><br><sp=
an>                     TerminateThread(thread, 1);</span><br><span>       =
              CloseHandleEx(&amp;thread);</span><br><span>                 =
    CloseHandleEx(&amp;pipe);</span><br><span>@@ -4113,7 +4113,7 @@</span><=
br><span> </span><br><span>             /* Worker thread ended */</span><br=
><span>             HANDLE thread =3D RemoveListItem(&amp;threads, CmpHandl=
e, handles[error]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          UpdateWaitHandles(&amp;handles, &amp;handle_count, io_event, exit=
_event, threads);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          UpdateWaitHandles(&amp;handles, &amp;handle_count, io_event, thre=
ads);</span><br><span>             CloseHandleEx(&amp;thread);</span><br><s=
pan>         }</span><br><span>     }</span><br><span>diff --git a/src/open=
vpnserv/validate=2Ec b/src/openvpnserv/validate=2Ec</span><br><span>index 8=
e529b9=2E=2E6a13a06 100644</span><br><span>--- a/src/openvpnserv/validate=
=2Ec</span><br><span>+++ b/src/openvpnserv/validate=2Ec</span><br><span>@@ =
-27,7 +27,7 @@</span><br><span> #include &lt;pathcch=2Eh&gt;</span><br><spa=
n> #include &lt;lm=2Eh&gt;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static const WCHAR *white_list[] =3D {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static const WCHAR *global_white_=
list[] =3D {</span><br><span>     L&quot;auth-retry&quot;,</span><br><span>=
     L&quot;config&quot;,</span><br><span>     L&quot;log&quot;,</span><br>=
<span>@@ -335,7 +335,7 @@</span><br><span>     }</span><br><span> </span><b=
r><span>     /* option name starts at 2 characters from argv[i] */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (OptionLookup(argv[0] +=
 2, white_list) =3D=3D -1) /* not found */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (OptionLookup(argv[0] + 2, global_white_list)=
 =3D=3D -1) /* not found */</span><br><span>     {</span><br><span>        =
 return FALSE;</span><br><span>     }</span><br><span>diff --git a/tests/un=
it_tests/openvpn/test_pkcs11=2Ec b/tests/unit_tests/openvpn/test_pkcs11=2Ec=
</span><br><span>index 042bd8b=2E=2Ea54c504 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span>+++ b/tests/unit_tes=
ts/openvpn/test_pkcs11=2Ec</span><br><span>@@ -137,7 +137,7 @@</span><br><s=
pan> static char softhsm2_conf_path[] =3D &quot;softhsm2_conf_XXXXXX&quot;;=
</span><br><span> int num_certs;</span><br><span> static const char *pkcs11=
_id_current;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct en=
v_set *es;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct en=
v_set *test_set;</span><br><span> </span><br><span> /* Fill-in certs[] arra=
y */</span><br><span> void</span><br><span>@@ -218,15 +218,15 @@</span><br>=
<span> </span><br><span>     /* environment */</span><br><span>     setenv(=
&quot;SOFTHSM2_CONF&quot;, softhsm2_conf_path, 1);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    es =3D env_set_create(NULL);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    setenv_str(es, &quot;SOFTHSM2_C=
ONF&quot;, softhsm2_conf_path);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    setenv_str(es, &quot;GNUTLS_PIN&quot;, PIN);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    test_set =3D env_set_create(NULL=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(te=
st_set, &quot;SOFTHSM2_CONF&quot;, softhsm2_conf_path);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    setenv_str(test_set, &quot;GNUTLS_P=
IN&quot;, PIN);</span><br><span> </span><br><span>     /* init the token us=
ing the temporary location as storage */</span><br><span>     struct argv a=
 =3D argv_new();</span><br><span>     argv_printf(&amp;a, &quot;%s --init-t=
oken --free --label \&quot;%s\&quot; --so-pin %s --pin %s&quot;,</span><br>=
<span>                 SOFTHSM2_UTIL_PATH, token_name, PIN, PIN);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(openvpn_execve_=
check(&amp;a, es, 0, &quot;Failed to initialize token&quot;));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(openvpn_execve_c=
heck(&amp;a, test_set, 0, &quot;Failed to initialize token&quot;));</span><=
br><span> </span><br><span>     /* Import certificates and keys in our test=
 database into the token */</span><br><span>     char cert[] =3D &quot;cert=
_XXXXXX&quot;;</span><br><span>@@ -263,14 +263,14 @@</span><br><span>      =
   argv_printf(</span><br><span>             &amp;a, &quot;%s --provider %s=
 --load-certificate %s --label \&quot;%s\&quot; --id %08x --login --write&q=
uot;,</span><br><span>             P11TOOL_PATH, SOFTHSM2_MODULE_PATH, cert=
, c-&gt;friendly_name, num_certs + 1);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        assert_true(openvpn_execve_check(&amp;a, es, 0, &q=
uot;Failed to upload certificate into token&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_true(openvpn_execve_check(=
&amp;a, test_set, 0, &quot;Failed to upload certificate into token&quot;));=
</span><br><span> </span><br><span>         argv_free(&amp;a);</span><br><s=
pan>         a =3D argv_new();</span><br><span>         argv_printf(&amp;a,=
</span><br><span>                     &quot;%s --provider %s --load-privkey=
 %s --label \&quot;%s\&quot; --id %08x --login --write&quot;,</span><br><sp=
an>                     P11TOOL_PATH, SOFTHSM2_MODULE_PATH, key, c-&gt;frie=
ndly_name, num_certs + 1);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        assert_true(openvpn_execve_check(&amp;a, es, 0, &quot;Failed t=
o upload key into token&quot;));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        assert_true(openvpn_execve_check(&amp;a, test_set, 0, =
&quot;Failed to upload key into token&quot;));</span><br><span> </span><br>=
<span>         assert_int_equal(ftruncate(cert_fd, 0), 0);</span><br><span>=
         assert_int_equal(ftruncate(key_fd, 0), 0);</span><br><span>@@ -294=
,7 +294,7 @@</span><br><span>     struct argv a =3D argv_new();</span><br><=
span> </span><br><span>     argv_printf(&amp;a, &quot;%s --delete-token --t=
oken \&quot;%s\&quot;&quot;, SOFTHSM2_UTIL_PATH, token_name);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    assert_true(openvpn_execve_chec=
k(&amp;a, es, 0, &quot;Failed to delete token&quot;));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(openvpn_execve_check(&am=
p;a, test_set, 0, &quot;Failed to delete token&quot;));</span><br><span>   =
  argv_free(&amp;a);</span><br><span> </span><br><span>     rmdir(softhsm2_=
tokens_path); /* this must be empty after delete token */</span><br><span>@=
@ -304,7 +304,7 @@</span><br><span>         free(c-&gt;p11_id);</span><br><=
span>         c-&gt;p11_id =3D NULL;</span><br><span>     }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    env_set_destroy(es);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    env_set_destroy(test_set);</=
span><br><span>     return 0;</span><br><span> }</span><br><span> </span><b=
r><span>diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec b/te=
sts/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>index e01b0=
e3=2E=2E4ca715b 100644</span><br><span>--- a/tests/unit_tests/openvpnserv/t=
est_openvpnserv=2Ec</span><br><span>+++ b/tests/unit_tests/openvpnserv/test=
_openvpnserv=2Ec</span><br><span>@@ -35,7 +35,7 @@</span><br><span> #includ=
e &quot;interactive=2Ec&quot;</span><br><span> </span><br><span> BOOL</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-ReportStatusToSCMgr(SERVICE=
_STATUS_HANDLE service, SERVICE_STATUS *status)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ReportStatusToSCMgr(SERVICE_STATUS_HANDLE svc_h=
andle, SERVICE_STATUS *svc_status)</span><br><span> {</span><br><span>     =
return TRUE;</span><br><span> }</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Dema=
il">change 1912</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
912?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1912 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--szItg/0CUC4=--


--===============1240090068060119312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1240090068060119312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1240090068060119312==--

