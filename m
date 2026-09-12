Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F0AC88E56
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 17:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ju4/PwGYMyfjse1+xFJWcN9fhyhN8vUeOHJloO3O3+U=; b=NEC+urZ9NcCYayHiw0DOhxwy7k
	MXGvibNEmDA9n3qwA87TB6MMRmFYh3+btrpTyo1wKi1tE3Ke4mFq6+IkxtlDlwi/FdftJTwKI/zoI
	OklzZ1IHevaB0YKd72daBU3/3E9ouuIeKfHjwjDeDeFD/HHxGjj/251RQP9FMpS8d9io=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5ReF-0001bC-P9;
	Sat, 12 Sep 2026 17:36:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5ReC-0001ar-K5
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 17:36:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XXZqNSZkNFsJPQSEnjeCUcwFbSC1hFk4ugFl7lYgzR0=; b=epVVT1WYQqHZPHN7Cdx8IAvzxz
 N4+RnL0IK547av8zbGij1q7Ckqk37GyaIEinTqunD1u3wdbteFl1tGXZ7UzttwLTeDW25/0Yz2nX0
 bHYTcUpCkLuq59MUh8RMOOTLo433BLNc6P837OhmNHIzU860kBuQ2CZyKUAZ3Fp57NCI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XXZqNSZkNFsJPQSEnjeCUcwFbSC1hFk4ugFl7lYgzR0=; b=O
 YWplm8eKGv9p4J2WiFhFgY/BoyQ+KPGlKIuaUd09Yii6HQYvEPo1dp6zzFZZT229tfyZCq5vtvWzb
 TNbIEoFdM1gpkOW6U/F6XWbYIoCm8SJx41GQrROL49fgsTYNqrnLI2OdcKDbHfMM1ZWdr66VlqcOU
 iA/VPOL1Is9D04mo=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5Re9-0005E5-H8 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 17:36:17 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso2175145e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 12 Sep 2026 10:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789234567; x=1789839367; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XXZqNSZkNFsJPQSEnjeCUcwFbSC1hFk4ugFl7lYgzR0=;
 b=SxWPPNBs/VDE0vvD+qtSXNn58/qVnfKy6RC6f5hfQyZXpr3lBBcChlw4dTnTPjUbWo
 larii2Wql1GS3/YLgPtUIKfkRdxzc57zGXuK1Y5TmSGotCWoFQeSahz7gYghc4R7QGrq
 5hLW4FiXcr/xpV52XevAgvukK31sQWVgm6B8U1AW0H46z45Fi1kcEmBg9QQRCig2Iaao
 mDSBJQfYKiZKjgYfxrCMgj0b5U6LeaJEgGnypXawDFdR0EJwYtJSqsiVaKWrXtJwruG8
 uzhf3X7zW1Bl8IpEsWdoF7mS16P1l/m8e20erHC/YnLJQJh0c92SZyXwkhXHKBGTh2ZB
 YK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789234567; x=1789839367;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XXZqNSZkNFsJPQSEnjeCUcwFbSC1hFk4ugFl7lYgzR0=;
 b=Cy4VIXoDlVr/lNbx5PiMpSx1H5caOLewVOSynde3z4wQOtA2o49pKd7kNpMslx6DF4
 lRuPbVwUmcg+9yJ20Wk5vJlNC/F39sSBypEMEB5Zc4mA5KRtd+dOF5Kre04hIEyasLvA
 avbxxu3MvbPo/B1HYHnmy9jSGlpkCyf1QWABHfA1hLzFvUrvLYXQQG5qhZLpxfvOG46I
 ILPVcmg4JYNETkUqBGsSJMtK/wDM9xvnRTxQ06TXbd9uluRNUONrSKFXyX7UmQiC54kl
 hLcuIB/dHbNwiSIYZwX/G44ZuSGTwnMD/lACot16ZklQBR5F5Cf+M7Q0A0TDZG7kH4OQ
 inxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+fcN69SEQF+j1XSqKZryRASS5WR/mgISg/J0iUp+4Mkk40ZWF1yr6sVHzcO9/jBUkQ3coeQgyan273h7+@lists.sourceforge.net
X-Gm-Message-State: AFuF++lVWGlyqr+aYGHcqm/UJoQuxcuHRq0YlYmbdXxyqhGHueMcpAs8
 Bw2CoW/goMHLLbaAHUVxHLaw7JJmX/2qONCv24iKOW5fGI3OUOJbs0V4QQOjwu5tvtxH6flmV2I
 K2krKGVefe6IRcEEpGwwwmzmN6VG04TjVSnbXsgJkF1jBMtO5Ey0FBUq/eCZYhXdzBRhx
X-Gm-Gg: AYBFou354TFDIM94IZf4dYCzUTuKerau5S2uvy3jNkqNJSlzl/l15LTSMI9dR6sxPjz
 Pn9yO268xxbucBQBiRa0vKFSuH/4jjSIkaT5WtPk7Lx9Vixi30rm7Xuf55uzcV9nglhQ1WiuYvZ
 lbJNajPg3mRf0pGwUolqScLsH75JijChu5gYO6tJpq/rmKpxkIzC78Q2gdponrQ3VAFaFhCCsLC
 0M2v8Cv3JNnUA2Lx50QspW6wW8SywukNzMYmZ4fIN9U4/Gj1o44apBm1urT1BnGh3vc8XXZ5djo
 oOHlwkSc9IZbzOJXX9++LS/N237o3drnUXzejMRe+DDrWvfFdYwPsKz+OW/8p276x9Wrns1+JUt
 s2VIMyUsM0qhzK54BoKmVI0pgJd9eNsBDDA72oe8odvxyXUt33cT0dyROH+vDVnwLkSkyhlDxf3
 ZaDaHnljXq3G2ZjvT0jjNCligiO1l0puDwJhdBESrrYhXCxxVC94IboYXNxNL8/UCGfvv/1meBA
 6svN9L+wt4sRgbztoCi+irD3CxEMzul2m/hWUxzBGO6S08w1W+awWwZFB3I+TxKS/HtKz1wtBBm
 I0GqwXvZ9c+GDHcoFT8Ly7SIr2Oc09icwOoD4gd0yK2GnElRN5U4wD82sEpL0Q==
X-Received: by 2002:a05:600c:190c:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-49e6cacf772mr30564735e9.14.1789234566579; 
 Sat, 12 Sep 2026 10:36:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60adaeefsm170285765e9.12.2026.09.12.10.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 10:36:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 12 Sep 2026 17:36:05 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf
X-Gerrit-Change-Number: 1912
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1912?usp=email>
X-Gerrit-Commit: cf02cd4f1190acb0ae934e8d6ed8d953fb4b0ddd
In-Reply-To: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
References: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTI3MzY3MDAwLkkwYWM5MzRkYTVlZWVkMDQyNGI1NGVkOWI1MjhhMmJmMmI1NjFmZmRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6a5f62edbf0240580986c18e20aff324438cd65b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5Re9-0005E5-H8
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6881774418216354129=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6881774418216354129==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Wmz4KocoDHY="; charset=UTF-8

--Wmz4KocoDHY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1912?usp=3Demail )

Change subject: Fix various function parameters sha=
dowing other symbols
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Fix various function parameters shadowing other symbols

Updated to=
 a newer version of cppcheck (2=2E21=2E0) and it
reported a new group of is=
sues where function parameters
shadow global variables or function names=2E=


Used a variety of different solutions depending on context,
either renami=
ng the global variables or the function
parameters=2E

In one case I remove=
d the parameter since it only contained
the global variable anyway=2E

Wher=
e applicable I have combined the change with fixing
occurrences of constPar=
ameterPointer to reduce conflicts
between different cppcheck fix commits=2E=


Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf
Signed-off-by: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912
M=
essage-Id: <20260911204411=2E15575-1-gert@greenie=2Emuc=2Ede>
URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39107=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/ope=
nvpn/gremlin=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/op=
envpn/options_string=2Ec
M src/openvpn/proxy=2Ec
M src/openvpn/ssl=2Ec
M sr=
c/openvpn/ssl_verify_backend=2Eh
M src/openvpn/ssl_verify_mbedtls=2Ec
M src=
/openvpn/ssl_verify_openssl=2Ec
M src/openvpnserv/interactive=2Ec
M src/ope=
nvpnserv/validate=2Ec
M tests/unit_tests/openvpn/test_pkcs11=2Ec
M tests/un=
it_tests/openvpnserv/test_openvpnserv=2Ec
13 files changed, 67 insertions(+=
), 66 deletions(-)




diff --git a/src/openvpn/gremlin=2Ec b/src/openvpn/g=
remlin=2Ec
index 0bd9396=2E=2Ea3efc78 100644
--- a/src/openvpn/gremlin=2Ec
=
+++ b/src/openvpn/gremlin=2Ec
@@ -112,9 +112,9 @@
     return ret;
 }
 
-st=
atic bool initialized; /* GLOBAL */
-static bool up;          /* GLOBAL */
=
-static time_t next;      /* GLOBAL */
+static bool gremlin_initialized; /*=
 GLOBAL */
+static bool gremlin_up;          /* GLOBAL */
+static time_t gr=
emlin_next;      /* GLOBAL */
 
 /*
  * Return false if we should drop a pa=
cket=2E
@@ -125,54 +125,54 @@
     const int up_down_level =3D GREMLIN_UP_D=
OWN_LEVEL(flags);
     const int drop_level =3D GREMLIN_DROP_LEVEL(flags);
=
 
-    if (!initialized)
+    if (!gremlin_initialized)
     {
-        ini=
tialized =3D true;
+        gremlin_initialized =3D true;
 
         if (up=
_down_level)
         {
-            up =3D false;
+            gremlin_up =
=3D false;
         }
         else
         {
-            up =3D true;
+ =
           gremlin_up =3D true;
         }
 
-        next =3D now;
+      =
  gremlin_next =3D now;
     }
 
     if (up_down_level) /* change up/down =
state? */
     {
-        if (now >=3D next)
+        if (now >=3D gremlin_=
next)
         {
             int delta;
-            if (up)
+            =
if (gremlin_up)
             {
                 delta =3D roll(down_low[up_=
down_level - 1], down_high[up_down_level - 1]);
-                up =3D fal=
se;
+                gremlin_up =3D false;
             }
             else=

             {
                 delta =3D roll(up_low[up_down_level - 1], =
up_high[up_down_level - 1]);
-                up =3D true;
+               =
 gremlin_up =3D true;
             }
 
-            msg(D_GREMLIN, "GREMLIN=
: CONNECTION GOING %s FOR %d SECONDS", (up ? "UP" : "DOWN"),
+            m=
sg(D_GREMLIN, "GREMLIN: CONNECTION GOING %s FOR %d SECONDS", (gremlin_up ? =
"UP" : "DOWN"),
                 delta);
-            next =3D now + delta;=

+            gremlin_next =3D now + delta;
         }
     }
 
     if (dr=
op_level)
     {
-        if (up && flip(drop_freq[drop_level - 1]))
+     =
   if (gremlin_up && flip(drop_freq[drop_level - 1]))
         {
          =
   dmsg(D_GREMLIN_VERBOSE, "GREMLIN: Random packet drop");
             ret=
urn false;
         }
     }
 
-    return up;
+    return gremlin_up;
 }
 =

 /*
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index c30=
1687=2E=2E3039f24 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/man=
age=2Ec
@@ -3063,7 +3063,7 @@
 }
 
 void
-management_notify_client_needing_=
auth(struct management *management, const unsigned int mda_key_id,
+managem=
ent_notify_client_needing_auth(struct management *man, const unsigned int m=
da_key_id,
                                       struct man_def_auth_conte=
xt *mdac, const struct env_set *es)
 {
     if (!(mdac->flags & DAF_CONNECT=
ION_CLOSED))
@@ -3074,12 +3074,12 @@
             mode =3D "REAUTH";
      =
   }
         msg(M_CLIENT, ">CLIENT:%s,%lu,%u", mode, mdac->cid, mda_key_i=
d);
-        man_output_extra_env(management, "CLIENT");
-        if (manag=
ement->connection=2Eenv_filter_level > 0)
+        man_output_extra_env(man=
, "CLIENT");
+        if (man->connection=2Eenv_filter_level > 0)
         =
{
-            man_output_peer_info_env(management, mdac);
+            man=
_output_peer_info_env(man, mdac);
         }
-        man_output_env(es, tr=
ue, management->connection=2Eenv_filter_level, "CLIENT");
+        man_outp=
ut_env(es, true, man->connection=2Eenv_filter_level, "CLIENT");
         md=
ac->flags |=3D DAF_INITIAL_AUTH;
     }
 }
@@ -3105,23 +3105,24 @@
 }
 
 vo=
id
-management_connection_established(struct management *management, struct=
 man_def_auth_context *mdac,
+management_connection_established(struct mana=
gement *man, struct man_def_auth_context *mdac,
                           =
        const struct env_set *es)
 {
     mdac->flags |=3D DAF_CONNECTION_E=
STABLISHED;
     msg(M_CLIENT, ">CLIENT:ESTABLISHED,%lu", mdac->cid);
-    =
man_output_extra_env(management, "CLIENT");
-    man_output_env(es, true, m=
anagement->connection=2Eenv_filter_level, "CLIENT");
+    man_output_extra_=
env(man, "CLIENT");
+    man_output_env(es, true, man->connection=2Eenv_fil=
ter_level, "CLIENT");
 }
 
 void
-management_notify_client_close(struct man=
agement *management, struct man_def_auth_context *mdac,
+management_notify_=
client_close(const struct management *man,
+                               =
struct man_def_auth_context *mdac,
                                const st=
ruct env_set *es)
 {
     if ((mdac->flags & DAF_INITIAL_AUTH) && !(mdac->f=
lags & DAF_CONNECTION_CLOSED))
     {
         msg(M_CLIENT, ">CLIENT:DISCO=
NNECT,%lu", mdac->cid);
-        man_output_env(es, true, management->conne=
ction=2Eenv_filter_level, "CLIENT");
+        man_output_env(es, true, man-=
>connection=2Eenv_filter_level, "CLIENT");
         mdac->flags |=3D DAF_CO=
NNECTION_CLOSED;
     }
 }
@@ -3981,12 +3982,12 @@
  */
 
 struct command_l=
ine *
-command_line_new(const size_t buf_len)
+command_line_new(const size_=
t len)
 {
     struct command_line *cl;
     ALLOC_OBJ_CLEAR(cl, struct com=
mand_line);
-    cl->buf =3D alloc_buf(buf_len);
-    cl->residual =3D allo=
c_buf(buf_len);
+    cl->buf =3D alloc_buf(len);
+    cl->residual =3D allo=
c_buf(len);
     return cl;
 }
 
diff --git a/src/openvpn/manage=2Eh b/src/=
openvpn/manage=2Eh
index 3ab937c=2E=2E1e7855d 100644
--- a/src/openvpn/mana=
ge=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -389,15 +389,15 @@
 
 void managemen=
t_notify_generic(const char *str);
 
-void management_notify_client_needing=
_auth(struct management *management,
+void management_notify_client_needing=
_auth(struct management *man,
                                            c=
onst unsigned int auth_id,
                                            stru=
ct man_def_auth_context *mdac,
                                            =
const struct env_set *es);
 
-void management_connection_established(struct=
 management *management,
+void management_connection_established(struct man=
agement *man,
                                        struct man_def_auth_c=
ontext *mdac, const struct env_set *es);
 
-void management_notify_client_c=
lose(struct management *management,
+void management_notify_client_close(co=
nst struct management *man,
                                     struct man=
_def_auth_context *mdac, const struct env_set *es);
 
 void management_lear=
n_addr(struct man_def_auth_context *mdac,
diff --git a/src/openvpn/options_=
string=2Ec b/src/openvpn/options_string=2Ec
index d3b29b8=2E=2E88ab798 1006=
44
--- a/src/openvpn/options_string=2Ec
+++ b/src/openvpn/options_string=2E=
c
@@ -396,12 +396,12 @@
 #endif
 
 char *
-options_string_extract_option(co=
nst char *options_string, const char *opt_name, struct gc_arena *gc)
+optio=
ns_string_extract_option(const char *option_string, const char *opt_name, s=
truct gc_arena *gc)
 {
     char *ret =3D NULL;
     const size_t opt_name_=
len =3D strlen(opt_name);
 
-    const char *p =3D options_string;
+    con=
st char *p =3D option_string;
     while (p)
     {
         if (0 =3D=3D s=
trncmp(p, opt_name, opt_name_len) && strlen(p) > (opt_name_len + 1)
diff --=
git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index e0700aa=2E=2E74a6=
cf9 100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -184,=
10 +184,10 @@
 }
 
 bool
-proxy_send(socket_descriptor_t sd, const void *bu=
f, size_t buf_len)
+proxy_send(socket_descriptor_t sd, const void *buf, siz=
e_t len)
 {
-    const ssize_t size =3D openvpn_send(sd, buf, buf_len, MSG_=
NOSIGNAL);
-    if (size !=3D (ssize_t)buf_len)
+    const ssize_t size =3D=
 openvpn_send(sd, buf, len, MSG_NOSIGNAL);
+    if (size !=3D (ssize_t)len)=

     {
         msg(D_LINK_ERRORS | M_ERRNO, "proxy_send: TCP port write f=
ailed on send()");
         return false;
diff --git a/src/openvpn/ssl=2Ec =
b/src/openvpn/ssl=2Ec
index 48508e5=2E=2E76150d4 100644
--- a/src/openvpn/s=
sl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1360,7 +1360,7 @@
 
 static void
 init=
_epoch_keys(struct key_state *ks, struct tls_multi *multi, const struct key=
_type *key_type,
-                bool server, struct key2 *key2)
+        =
        bool server, const struct key2 *key2)
 {
     /* For now we hardcod=
e this to be 4 for the software based data channel
      * DCO based implem=
entations/HW implementation might adjust this number
@@ -1403,14 +1403,14 @=
@
 
 static void
 init_key_contexts(struct key_state *ks, struct tls_multi =
*multi, const struct key_type *key_type,
-                  bool server, st=
ruct key2 *key2, bool dco_enabled)
+                  bool server, const st=
ruct key2 *key2, bool dco)
 {
     struct key_ctx_bi *key =3D &ks->crypto_o=
ptions=2Ekey_ctx_bi;
 
     /* Initialize key contexts */
     int key_dire=
ction =3D server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;
 
-    if =
(dco_enabled)
+    if (dco)
     {
         if (key->encrypt=2Ehmac)
      =
   {
diff --git a/src/openvpn/ssl_verify_backend=2Eh b/src/openvpn/ssl_veri=
fy_backend=2Eh
index 9272cae=2E=2E46720d6 100644
--- a/src/openvpn/ssl_veri=
fy_backend=2Eh
+++ b/src/openvpn/ssl_verify_backend=2Eh
@@ -220,14 +220,14 =
@@
  * Check X=2E509 Netscape certificate type field, if available=2E
  *
 =
 * @param cert          Certificate to check=2E
- * @param usage         On=
e of \c NS_CERT_CHECK_CLIENT, \c NS_CERT_CHECK_SERVER,
+ * @param cert_type=
     One of \c NS_CERT_CHECK_CLIENT, \c NS_CERT_CHECK_SERVER,
  *          =
            or \c NS_CERT_CHECK_NONE=2E
  *
  * @return              \c SUC=
CESS if NS_CERT_CHECK_NONE or if the certificate has
  *                   =
   the expected bit set=2E \c FAILURE if the certificate does
  *          =
            not have NS cert type verification or the wrong bit set=2E
  */=

-result_t x509_verify_ns_cert_type(openvpn_x509_cert_t *cert, const int us=
age);
+result_t x509_verify_ns_cert_type(openvpn_x509_cert_t *cert, const i=
nt cert_type);
 
 /*
  * Verify X=2E509 key usage extension field=2E
diff -=
-git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=
=2Ec
index 9f676ed=2E=2Ec4bae40 100644
--- a/src/openvpn/ssl_verify_mbedtls=
=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -753,9 +753,9 @@
 /* Dummy=
 function because Netscape certificate types are not supported in OpenVPN w=
ith mbedtls=2E
  * Returns SUCCESS if usage is NS_CERT_CHECK_NONE, FAILURE =
otherwise=2E */
 result_t
-x509_verify_ns_cert_type(mbedtls_x509_crt *cert,=
 const int usage)
+x509_verify_ns_cert_type(mbedtls_x509_crt *cert, const i=
nt cert_type)
 {
-    if (usage =3D=3D NS_CERT_CHECK_NONE)
+    if (cert_ty=
pe =3D=3D NS_CERT_CHECK_NONE)
     {
         return SUCCESS;
     }
diff -=
-git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=
=2Ec
index a6307f6=2E=2E6073e4e 100644
--- a/src/openvpn/ssl_verify_openssl=
=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -629,13 +629,13 @@
 }
 
 r=
esult_t
-x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_cert, const int=
 usage)
+x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_cert, const int=
 cert_type)
 {
-    if (usage =3D=3D NS_CERT_CHECK_NONE)
+    if (cert_type=
 =3D=3D NS_CERT_CHECK_NONE)
     {
         return SUCCESS;
     }
-    if =
(usage =3D=3D NS_CERT_CHECK_CLIENT)
+    if (cert_type =3D=3D NS_CERT_CHECK=
_CLIENT)
     {
         /*
          * Unfortunately, X509_check_purpose()=
 before OpenSSL 4=2E0 does some weird thing that
@@ -668,7 +668,7 @@
      =
   }
         return result;
     }
-    if (usage =3D=3D NS_CERT_CHECK_SER=
VER)
+    if (cert_type =3D=3D NS_CERT_CHECK_SERVER)
     {
         /*
   =
       * Unfortunately, X509_check_purpose() before OpenSSL 4=2E0 does some=
 weird thing that
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvp=
nserv/interactive=2Ec
index d2288b9=2E=2E7819f5a 100644
--- a/src/openvpnse=
rv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -3848,8 +3848,8=
 @@
 
 
 static DWORD
-UpdateWaitHandles(LPHANDLE *handles_ptr, LPDWORD cou=
nt, HANDLE io_event, HANDLE exit_event,
-                  list_item_t *thr=
eads)
+UpdateWaitHandles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE io_ev=
ent,
+                  const list_item_t *threads)
 {
     static DWORD si=
ze =3D 10;
     static LPHANDLE handles =3D NULL;
@@ -3998,7 +3998,7 @@
   =
      goto out;
     }
 
-    error =3D UpdateWaitHandles(&handles, &handle=
_count, io_event, exit_event, threads);
+    error =3D UpdateWaitHandles(&h=
andles, &handle_count, io_event, threads);
     if (error !=3D NO_ERROR)
  =
   {
         goto out;
@@ -4065,7 +4065,7 @@
                 if (!error)
=
                 {
                     error =3D
-                        =
UpdateWaitHandles(&handles, &handle_count, io_event, exit_event, threads);
=
+                        UpdateWaitHandles(&handles, &handle_count, io_even=
t, threads);
                 }
                 if (error)
               =
  {
@@ -4073,7 +4073,7 @@
                                 &exit_event);
  =
                   /* Update wait handles again after removing the last wor=
ker thread */
                     RemoveListItem(&threads, CmpHandle, thre=
ad);
-                    UpdateWaitHandles(&handles, &handle_count, io_eve=
nt, exit_event, threads);
+                    UpdateWaitHandles(&handles, =
&handle_count, io_event, threads);
                     TerminateThread(thr=
ead, 1);
                     CloseHandleEx(&thread);
                     =
CloseHandleEx(&pipe);
@@ -4113,7 +4113,7 @@
 
             /* Worker thread=
 ended */
             HANDLE thread =3D RemoveListItem(&threads, CmpHandle=
, handles[error]);
-            UpdateWaitHandles(&handles, &handle_count, =
io_event, exit_event, threads);
+            UpdateWaitHandles(&handles, &h=
andle_count, io_event, threads);
             CloseHandleEx(&thread);
     =
    }
     }
diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/va=
lidate=2Ec
index 8e529b9=2E=2E6a13a06 100644
--- a/src/openvpnserv/validate=
=2Ec
+++ b/src/openvpnserv/validate=2Ec
@@ -27,7 +27,7 @@
 #include <pathcc=
h=2Eh>
 #include <lm=2Eh>
 
-static const WCHAR *white_list[] =3D {
+static=
 const WCHAR *global_white_list[] =3D {
     L"auth-retry",
     L"config",=

     L"log",
@@ -335,7 +335,7 @@
     }
 
     /* option name starts at 2 =
characters from argv[i] */
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf
Gerrit-Chan=
ge-Number: 1912
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--Wmz4KocoDHY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1912?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Fix various function parameters shadowing =
other symbols<br><br>Updated to a newer version of cppcheck (2=2E21=2E0) an=
d it<br>reported a new group of issues where function parameters<br>shadow =
global variables or function names=2E<br><br>Used a variety of different so=
lutions depending on context,<br>either renaming the global variables or th=
e function<br>parameters=2E<br><br>In one case I removed the parameter sinc=
e it only contained<br>the global variable anyway=2E<br><br>Where applicabl=
e I have combined the change with fixing<br>occurrences of constParameterPo=
inter to reduce conflicts<br>between different cppcheck fix commits=2E<br><=
br>Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1912<br>Message-Id: &lt;20260911204411=2E15575-1-gert@green=
ie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg39107=2Ehtml<br>Signed-off-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/gremlin=2Ec<br>M src/op=
envpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/options_strin=
g=2Ec<br>M src/openvpn/proxy=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/=
ssl_verify_backend=2Eh<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>M src/ope=
nvpn/ssl_verify_openssl=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M src/o=
penvpnserv/validate=2Ec<br>M tests/unit_tests/openvpn/test_pkcs11=2Ec<br>M =
tests/unit_tests/openvpnserv/test_openvpnserv=2Ec<br>13 files changed, 67 i=
nsertions(+), 66 deletions(-)<br><br></pre>
<pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/gre=
mlin=2Ec b/src/openvpn/gremlin=2Ec</span><br><span>index 0bd9396=2E=2Ea3efc=
78 100644</span><br><span>--- a/src/openvpn/gremlin=2Ec</span><br><span>+++=
 b/src/openvpn/gremlin=2Ec</span><br><span>@@ -112,9 +112,9 @@</span><br><s=
pan>     return ret;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static bool initialized; /* GLOBAL */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool up;        =
  /* GLOBAL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
time_t next;      /* GLOBAL */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static bool gremlin_initialized; /* GLOBAL */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static bool gremlin_up;          /* GL=
OBAL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static time_=
t gremlin_next;      /* GLOBAL */</span><br><span> </span><br><span> /*</sp=
an><br><span>  * Return false if we should drop a packet=2E</span><br><span=
>@@ -125,54 +125,54 @@</span><br><span>     const int up_down_level =3D GRE=
MLIN_UP_DOWN_LEVEL(flags);</span><br><span>     const int drop_level =3D GR=
EMLIN_DROP_LEVEL(flags);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (!initialized)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!gremlin_initialized)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        initialized =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gr=
emlin_initialized =3D true;</span><br><span> </span><br><span>         if (=
up_down_level)</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            up =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            gremlin_up =3D false;</span><br><span=
>         }</span><br><span>         else</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            up =3D true;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            gremlin_up =
=3D true;</span><br><span>         }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        next =3D now;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        gremlin_next =3D now;</span><br>=
<span>     }</span><br><span> </span><br><span>     if (up_down_level) /* c=
hange up/down state? */</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (now &gt;=3D next)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (now &gt;=3D gremlin_next)</s=
pan><br><span>         {</span><br><span>             int delta;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            if (up)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (gremlin_up)</spa=
n><br><span>             {</span><br><span>                 delta =3D roll(=
down_low[up_down_level - 1], down_high[up_down_level - 1]);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                up =3D false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                gremlin_up =
=3D false;</span><br><span>             }</span><br><span>             else=
</span><br><span>             {</span><br><span>                 delta =3D =
roll(up_low[up_down_level - 1], up_high[up_down_level - 1]);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                up =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                gremlin_up =
=3D true;</span><br><span>             }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            msg(D_GREMLIN, &quot;GREML=
IN: CONNECTION GOING %s FOR %d SECONDS&quot;, (up ? &quot;UP&quot; : &quot;=
DOWN&quot;),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(D_GREMLIN, &quot;GREMLIN: CONNECTION GOING %s FOR %d SECONDS&quot;=
, (gremlin_up ? &quot;UP&quot; : &quot;DOWN&quot;),</span><br><span>       =
          delta);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        next =3D now + delta;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            gremlin_next =3D now + delta;</span><br><span>       =
  }</span><br><span>     }</span><br><span> </span><br><span>     if (drop_=
level)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (up &amp;&amp; flip(drop_freq[drop_level - 1]))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (gremlin_up &amp;=
&amp; flip(drop_freq[drop_level - 1]))</span><br><span>         {</span><br=
><span>             dmsg(D_GREMLIN_VERBOSE, &quot;GREMLIN: Random packet dr=
op&quot;);</span><br><span>             return false;</span><br><span>     =
    }</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    return up;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return gremlin_up;</span><br><span> }</span><br><sp=
an> </span><br><span> /*</span><br><span>diff --git a/src/openvpn/manage=2E=
c b/src/openvpn/manage=2Ec</span><br><span>index c301687=2E=2E3039f24 10064=
4</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/op=
envpn/manage=2Ec</span><br><span>@@ -3063,7 +3063,7 @@</span><br><span> }</=
span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-management_notify_client_needing_auth(struct management *m=
anagement, const unsigned int mda_key_id,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+management_notify_client_needing_auth(struct manageme=
nt *man, const unsigned int mda_key_id,</span><br><span>                   =
                    struct man_def_auth_context *mdac, const struct env_set=
 *es)</span><br><span> {</span><br><span>     if (!(mdac-&gt;flags &amp; DA=
F_CONNECTION_CLOSED))</span><br><span>@@ -3074,12 +3074,12 @@</span><br><sp=
an>             mode =3D &quot;REAUTH&quot;;</span><br><span>         }</sp=
an><br><span>         msg(M_CLIENT, &quot;&gt;CLIENT:%s,%lu,%u&quot;, mode,=
 mdac-&gt;cid, mda_key_id);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        man_output_extra_env(management, &quot;CLIENT&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (management-&gt;co=
nnection=2Eenv_filter_level &gt; 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        man_output_extra_env(man, &quot;CLIENT&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt;conn=
ection=2Eenv_filter_level &gt; 0)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            man_output_peer_info_env=
(management, mdac);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            man_output_peer_info_env(man, mdac);</span><br><span>         }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        man_output_en=
v(es, true, management-&gt;connection=2Eenv_filter_level, &quot;CLIENT&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        man_outp=
ut_env(es, true, man-&gt;connection=2Eenv_filter_level, &quot;CLIENT&quot;)=
;</span><br><span>         mdac-&gt;flags |=3D DAF_INITIAL_AUTH;</span><br>=
<span>     }</span><br><span> }</span><br><span>@@ -3105,23 +3105,24 @@</sp=
an><br><span> }</span><br><span> </span><br><span> void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-management_connection_established(struct =
management *management, struct man_def_auth_context *mdac,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+management_connection_established(st=
ruct management *man, struct man_def_auth_context *mdac,</span><br><span>  =
                                 const struct env_set *es)</span><br><span>=
 {</span><br><span>     mdac-&gt;flags |=3D DAF_CONNECTION_ESTABLISHED;</sp=
an><br><span>     msg(M_CLIENT, &quot;&gt;CLIENT:ESTABLISHED,%lu&quot;, mda=
c-&gt;cid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    man_ou=
tput_extra_env(management, &quot;CLIENT&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    man_output_env(es, true, management-&gt;conne=
ction=2Eenv_filter_level, &quot;CLIENT&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    man_output_extra_env(man, &quot;CLIENT&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    man_output_en=
v(es, true, man-&gt;connection=2Eenv_filter_level, &quot;CLIENT&quot;);</sp=
an><br><span> }</span><br><span> </span><br><span> void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-management_notify_client_close(struct man=
agement *management, struct man_def_auth_context *mdac,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+management_notify_client_close(const st=
ruct management *man,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                               struct man_def_auth_context *mdac,</span><=
br><span>                                const struct env_set *es)</span><b=
r><span> {</span><br><span>     if ((mdac-&gt;flags &amp; DAF_INITIAL_AUTH)=
 &amp;&amp; !(mdac-&gt;flags &amp; DAF_CONNECTION_CLOSED))</span><br><span>=
     {</span><br><span>         msg(M_CLIENT, &quot;&gt;CLIENT:DISCONNECT,%=
lu&quot;, mdac-&gt;cid);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        man_output_env(es, true, management-&gt;connection=2Eenv_filter_=
level, &quot;CLIENT&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        man_output_env(es, true, man-&gt;connection=2Eenv_filter_le=
vel, &quot;CLIENT&quot;);</span><br><span>         mdac-&gt;flags |=3D DAF_=
CONNECTION_CLOSED;</span><br><span>     }</span><br><span> }</span><br><spa=
n>@@ -3981,12 +3982,12 @@</span><br><span>  */</span><br><span> </span><br>=
<span> struct command_line *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-command_line_new(const size_t buf_len)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+command_line_new(const size_t len)</span><br><spa=
n> {</span><br><span>     struct command_line *cl;</span><br><span>     ALL=
OC_OBJ_CLEAR(cl, struct command_line);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    cl-&gt;buf =3D alloc_buf(buf_len);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    cl-&gt;residual =3D alloc_buf(buf_len=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cl-&gt;buf =
=3D alloc_buf(len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    cl-&gt;residual =3D alloc_buf(len);</span><br><span>     return cl;</sp=
an><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/=
manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>index 3ab937c=2E=2E1e78=
55d 100644</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++=
 b/src/openvpn/manage=2Eh</span><br><span>@@ -389,15 +389,15 @@</span><br><=
span> </span><br><span> void management_notify_generic(const char *str);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void m=
anagement_notify_client_needing_auth(struct management *management,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void management_notify_clie=
nt_needing_auth(struct management *man,</span><br><span>                   =
                         const unsigned int auth_id,</span><br><span>      =
                                      struct man_def_auth_context *mdac,</s=
pan><br><span>                                            const struct env_=
set *es);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void management_connection_established(struct management *management,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void management_con=
nection_established(struct management *man,</span><br><span>               =
                         struct man_def_auth_context *mdac, const struct en=
v_set *es);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-void management_notify_client_close(struct management *management,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void management_noti=
fy_client_close(const struct management *man,</span><br><span>             =
                        struct man_def_auth_context *mdac, const struct env=
_set *es);</span><br><span> </span><br><span> void management_learn_addr(st=
ruct man_def_auth_context *mdac,</span><br><span>diff --git a/src/openvpn/o=
ptions_string=2Ec b/src/openvpn/options_string=2Ec</span><br><span>index d3=
b29b8=2E=2E88ab798 100644</span><br><span>--- a/src/openvpn/options_string=
=2Ec</span><br><span>+++ b/src/openvpn/options_string=2Ec</span><br><span>@=
@ -396,12 +396,12 @@</span><br><span> #endif</span><br><span> </span><br><s=
pan> char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_st=
ring_extract_option(const char *options_string, const char *opt_name, struc=
t gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+opti=
ons_string_extract_option(const char *option_string, const char *opt_name, =
struct gc_arena *gc)</span><br><span> {</span><br><span>     char *ret =3D =
NULL;</span><br><span>     const size_t opt_name_len =3D strlen(opt_name);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
const char *p =3D options_string;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char *p =3D option_string;</span><br><span>     whi=
le (p)</span><br><span>     {</span><br><span>         if (0 =3D=3D strncmp=
(p, opt_name, opt_name_len) &amp;&amp; strlen(p) &gt; (opt_name_len + 1)</s=
pan><br><span>diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</s=
pan><br><span>index e0700aa=2E=2E74a6cf9 100644</span><br><span>--- a/src/o=
penvpn/proxy=2Ec</span><br><span>+++ b/src/openvpn/proxy=2Ec</span><br><spa=
n>@@ -184,10 +184,10 @@</span><br><span> }</span><br><span> </span><br><spa=
n> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-proxy_send(soc=
ket_descriptor_t sd, const void *buf, size_t buf_len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+proxy_send(socket_descriptor_t sd, const =
void *buf, size_t len)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const ssize_t size =3D openvpn_send(sd, buf, buf_le=
n, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (size !=3D (ssize_t)buf_len)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const ssize_t size =3D openvpn_send(sd, buf, len, MSG_NOSIG=
NAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (size !=
=3D (ssize_t)len)</span><br><span>     {</span><br><span>         msg(D_LIN=
K_ERRORS | M_ERRNO, &quot;proxy_send: TCP port write failed on send()&quot;=
);</span><br><span>         return false;</span><br><span>diff --git a/src/=
openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 48508e5=2E=2E76=
150d4 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ =
b/src/openvpn/ssl=2Ec</span><br><span>@@ -1360,7 +1360,7 @@</span><br><span=
> </span><br><span> static void</span><br><span> init_epoch_keys(struct key=
_state *ks, struct tls_multi *multi, const struct key_type *key_type,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                bool server=
, struct key2 *key2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                bool server, const struct key2 *key2)</span><br><span> {</=
span><br><span>     /* For now we hardcode this to be 4 for the software ba=
sed data channel</span><br><span>      * DCO based implementations/HW imple=
mentation might adjust this number</span><br><span>@@ -1403,14 +1403,14 @@<=
/span><br><span> </span><br><span> static void</span><br><span> init_key_co=
ntexts(struct key_state *ks, struct tls_multi *multi, const struct key_type=
 *key_type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
        bool server, struct key2 *key2, bool dco_enabled)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                  bool server, const =
struct key2 *key2, bool dco)</span><br><span> {</span><br><span>     struct=
 key_ctx_bi *key =3D &amp;ks-&gt;crypto_options=2Ekey_ctx_bi;</span><br><sp=
an> </span><br><span>     /* Initialize key contexts */</span><br><span>   =
  int key_direction =3D server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORM=
AL;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (dco_enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (dco)</span><br><span>     {</span><br><span>         if (key-&gt;e=
ncrypt=2Ehmac)</span><br><span>         {</span><br><span>diff --git a/src/=
openvpn/ssl_verify_backend=2Eh b/src/openvpn/ssl_verify_backend=2Eh</span><=
br><span>index 9272cae=2E=2E46720d6 100644</span><br><span>--- a/src/openvp=
n/ssl_verify_backend=2Eh</span><br><span>+++ b/src/openvpn/ssl_verify_backe=
nd=2Eh</span><br><span>@@ -220,14 +220,14 @@</span><br><span>  * Check X=2E=
509 Netscape certificate type field, if available=2E</span><br><span>  *</s=
pan><br><span>  * @param cert          Certificate to check=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @param usage         One of \c =
NS_CERT_CHECK_CLIENT, \c NS_CERT_CHECK_SERVER,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param cert_type     One of \c NS_CERT_CHECK_=
CLIENT, \c NS_CERT_CHECK_SERVER,</span><br><span>  *                      o=
r \c NS_CERT_CHECK_NONE=2E</span><br><span>  *</span><br><span>  * @return =
             \c SUCCESS if NS_CERT_CHECK_NONE or if the certificate has</sp=
an><br><span>  *                      the expected bit set=2E \c FAILURE if=
 the certificate does</span><br><span>  *                      not have NS =
cert type verification or the wrong bit set=2E</span><br><span>  */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-result_t x509_verify_ns_cert_=
type(openvpn_x509_cert_t *cert, const int usage);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+result_t x509_verify_ns_cert_type(openvpn_x50=
9_cert_t *cert, const int cert_type);</span><br><span> </span><br><span> /*=
</span><br><span>  * Verify X=2E509 key usage extension field=2E</span><br>=
<span>diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_ver=
ify_mbedtls=2Ec</span><br><span>index 9f676ed=2E=2Ec4bae40 100644</span><br=
><span>--- a/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src/o=
penvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -753,9 +753,9 @@</span><br=
><span> /* Dummy function because Netscape certificate types are not suppor=
ted in OpenVPN with mbedtls=2E</span><br><span>  * Returns SUCCESS if usage=
 is NS_CERT_CHECK_NONE, FAILURE otherwise=2E */</span><br><span> result_t</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-x509_verify_ns_cert_typ=
e(mbedtls_x509_crt *cert, const int usage)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+x509_verify_ns_cert_type(mbedtls_x509_crt *cert, con=
st int cert_type)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (usage =3D=3D NS_CERT_CHECK_NONE)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (cert_type =3D=3D NS_CERT_CHECK_=
NONE)</span><br><span>     {</span><br><span>         return SUCCESS;</span=
><br><span>     }</span><br><span>diff --git a/src/openvpn/ssl_verify_opens=
sl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>index a6307f6=
=2E=2E6073e4e 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><sp=
an>@@ -629,13 +629,13 @@</span><br><span> }</span><br><span> </span><br><sp=
an> result_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-x509_veri=
fy_ns_cert_type(openvpn_x509_cert_t *peer_cert, const int usage)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+x509_verify_ns_cert_type(openv=
pn_x509_cert_t *peer_cert, const int cert_type)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (usage =3D=3D NS_CERT_C=
HECK_NONE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c=
ert_type =3D=3D NS_CERT_CHECK_NONE)</span><br><span>     {</span><br><span>=
         return SUCCESS;</span><br><span>     }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (usage =3D=3D NS_CERT_CHECK_CLIENT)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cert_type =3D=3D N=
S_CERT_CHECK_CLIENT)</span><br><span>     {</span><br><span>         /*</sp=
an><br><span>          * Unfortunately, X509_check_purpose() before OpenSSL=
 4=2E0 does some weird thing that</span><br><span>@@ -668,7 +668,7 @@</span=
><br><span>         }</span><br><span>         return result;</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (usag=
e =3D=3D NS_CERT_CHECK_SERVER)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (cert_type =3D=3D NS_CERT_CHECK_SERVER)</span><br><span> =
    {</span><br><span>         /*</span><br><span>          * Unfortunately=
, X509_check_purpose() before OpenSSL 4=2E0 does some weird thing that</spa=
n><br><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/=
interactive=2Ec</span><br><span>index d2288b9=2E=2E7819f5a 100644</span><br=
><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/open=
vpnserv/interactive=2Ec</span><br><span>@@ -3848,8 +3848,8 @@</span><br><sp=
an> </span><br><span> </span><br><span> static DWORD</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-UpdateWaitHandles(LPHANDLE *handles_ptr, LP=
DWORD count, HANDLE io_event, HANDLE exit_event,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                  list_item_t *threads)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+UpdateWaitHandles(LPHANDLE *=
handles_ptr, LPDWORD count, HANDLE io_event,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                  const list_item_t *threads)</spa=
n><br><span> {</span><br><span>     static DWORD size =3D 10;</span><br><sp=
an>     static LPHANDLE handles =3D NULL;</span><br><span>@@ -3998,7 +3998,=
7 @@</span><br><span>         goto out;</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    error =3D Up=
dateWaitHandles(&amp;handles, &amp;handle_count, io_event, exit_event, thre=
ads);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D =
UpdateWaitHandles(&amp;handles, &amp;handle_count, io_event, threads);</spa=
n><br><span>     if (error !=3D NO_ERROR)</span><br><span>     {</span><br>=
<span>         goto out;</span><br><span>@@ -4065,7 +4065,7 @@</span><br><s=
pan>                 if (!error)</span><br><span>                 {</span><=
br><span>                     error =3D</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                        UpdateWaitHandles(&amp;handles, &=
amp;handle_count, io_event, exit_event, threads);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        UpdateWaitHandles(&am=
p;handles, &amp;handle_count, io_event, threads);</span><br><span>         =
        }</span><br><span>                 if (error)</span><br><span>     =
            {</span><br><span>@@ -4073,7 +4073,7 @@</span><br><span>       =
                          &amp;exit_event);</span><br><span>               =
      /* Update wait handles again after removing the last worker thread */=
</span><br><span>                     RemoveListItem(&amp;threads, CmpHandl=
e, thread);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          UpdateWaitHandles(&amp;handles, &amp;handle_count, io_event, exit=
_event, threads);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  UpdateWaitHandles(&amp;handles, &amp;handle_count, io_eve=
nt, threads);</span><br><span>                     TerminateThread(thread, =
1);</span><br><span>                     CloseHandleEx(&amp;thread);</span>=
<br><span>                     CloseHandleEx(&amp;pipe);</span><br><span>@@=
 -4113,7 +4113,7 @@</span><br><span> </span><br><span>             /* Worke=
r thread ended */</span><br><span>             HANDLE thread =3D RemoveList=
Item(&amp;threads, CmpHandle, handles[error]);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            UpdateWaitHandles(&amp;handles, &amp;h=
andle_count, io_event, exit_event, threads);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            UpdateWaitHandles(&amp;handles, &amp;h=
andle_count, io_event, threads);</span><br><span>             CloseHandleEx=
(&amp;thread);</span><br><span>         }</span><br><span>     }</span><br>=
<span>diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/validate=
=2Ec</span><br><span>index 8e529b9=2E=2E6a13a06 100644</span><br><span>--- =
a/src/openvpnserv/validate=2Ec</span><br><span>+++ b/src/openvpnserv/valida=
te=2Ec</span><br><span>@@ -27,7 +27,7 @@</span><br><span> #include &lt;path=
cch=2Eh&gt;</span><br><span> #include &lt;lm=2Eh&gt;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static const WCHAR *white_=
list[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
const WCHAR *global_white_list[] =3D {</span><br><span>     L&quot;auth-ret=
ry&quot;,</span><br><span>     L&quot;config&quot;,</span><br><span>     L&=
quot;log&quot;,</span><br><span>@@ -335,7 +335,7 @@</span><br><span>     }<=
/span><br><span> </span><br><span>     /* option name starts at 2 character=
s from argv[i] */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (OptionLookup(argv[0] + 2, white_list) =3D=3D -1) /* not found */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (OptionLookup(argv[=
0] + 2, global_white_list) =3D=3D -1) /* not found */</span><br><span>     =
{</span><br><span>         return FALSE;</span><br><span>     }</span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_pkcs11=2Ec b/tests/unit_tes=
ts/openvpn/test_pkcs11=2Ec</span><br><span>index 042bd8b=2E=2Ea54c504 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br>=
<span>+++ b/tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span>@@ -13=
7,7 +137,7 @@</span><br><span> static char softhsm2_conf_path[] =3D &quot;s=
ofthsm2_conf_XXXXXX&quot;;</span><br><span> int num_certs;</span><br><span>=
 static const char *pkcs11_id_current;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-struct env_set *es;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+struct env_set *test_set;</span><br><span> </span><br><spa=
n> /* Fill-in certs[] array */</span><br><span> void</span><br><span>@@ -21=
8,15 +218,15 @@</span><br><span> </span><br><span>     /* environment */</s=
pan><br><span>     setenv(&quot;SOFTHSM2_CONF&quot;, softhsm2_conf_path, 1)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    es =3D env_set_c=
reate(NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    seten=
v_str(es, &quot;SOFTHSM2_CONF&quot;, softhsm2_conf_path);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    setenv_str(es, &quot;GNUTLS_PIN&quo=
t;, PIN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    test_s=
et =3D env_set_create(NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    setenv_str(test_set, &quot;SOFTHSM2_CONF&quot;, softhsm2_conf_=
path);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_st=
r(test_set, &quot;GNUTLS_PIN&quot;, PIN);</span><br><span> </span><br><span=
>     /* init the token using the temporary location as storage */</span><b=
r><span>     struct argv a =3D argv_new();</span><br><span>     argv_printf=
(&amp;a, &quot;%s --init-token --free --label \&quot;%s\&quot; --so-pin %s =
--pin %s&quot;,</span><br><span>                 SOFTHSM2_UTIL_PATH, token_=
name, PIN, PIN);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a=
ssert_true(openvpn_execve_check(&amp;a, es, 0, &quot;Failed to initialize t=
oken&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(openvpn_execve_check(&amp;a, test_set, 0, &quot;Failed to initial=
ize token&quot;));</span><br><span> </span><br><span>     /* Import certifi=
cates and keys in our test database into the token */</span><br><span>     =
char cert[] =3D &quot;cert_XXXXXX&quot;;</span><br><span>@@ -263,14 +263,14=
 @@</span><br><span>         argv_printf(</span><br><span>             &amp=
;a, &quot;%s --provider %s --load-certificate %s --label \&quot;%s\&quot; -=
-id %08x --login --write&quot;,</span><br><span>             P11TOOL_PATH, =
SOFTHSM2_MODULE_PATH, cert, c-&gt;friendly_name, num_certs + 1);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        assert_true(openvpn_exec=
ve_check(&amp;a, es, 0, &quot;Failed to upload certificate into token&quot;=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_t=
rue(openvpn_execve_check(&amp;a, test_set, 0, &quot;Failed to upload certif=
icate into token&quot;));</span><br><span> </span><br><span>         argv_f=
ree(&amp;a);</span><br><span>         a =3D argv_new();</span><br><span>   =
      argv_printf(&amp;a,</span><br><span>                     &quot;%s --p=
rovider %s --load-privkey %s --label \&quot;%s\&quot; --id %08x --login --w=
rite&quot;,</span><br><span>                     P11TOOL_PATH, SOFTHSM2_MOD=
ULE_PATH, key, c-&gt;friendly_name, num_certs + 1);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        assert_true(openvpn_execve_check(&a=
mp;a, es, 0, &quot;Failed to upload key into token&quot;));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        assert_true(openvpn_execve_=
check(&amp;a, test_set, 0, &quot;Failed to upload key into token&quot;));</=
span><br><span> </span><br><span>         assert_int_equal(ftruncate(cert_f=
d, 0), 0);</span><br><span>         assert_int_equal(ftruncate(key_fd, 0), =
0);</span><br><span>@@ -294,7 +294,7 @@</span><br><span>     struct argv a =
=3D argv_new();</span><br><span> </span><br><span>     argv_printf(&amp;a, =
&quot;%s --delete-token --token \&quot;%s\&quot;&quot;, SOFTHSM2_UTIL_PATH,=
 token_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asse=
rt_true(openvpn_execve_check(&amp;a, es, 0, &quot;Failed to delete token&qu=
ot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(openvpn_execve_check(&amp;a, test_set, 0, &quot;Failed to delete token&q=
uot;));</span><br><span>     argv_free(&amp;a);</span><br><span> </span><br=
><span>     rmdir(softhsm2_tokens_path); /* this must be empty after delete=
 token */</span><br><span>@@ -304,7 +304,7 @@</span><br><span>         free=
(c-&gt;p11_id);</span><br><span>         c-&gt;p11_id =3D NULL;</span><br><=
span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    env_se=
t_destroy(es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
nv_set_destroy(test_set);</span><br><span>     return 0;</span><br><span> }=
</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpnser=
v/test_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec<=
/span><br><span>index e01b0e3=2E=2E4ca715b 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>@@ -35,7 +35,7 =
@@</span><br><span> #include &quot;interactive=2Ec&quot;</span><br><span> <=
/span><br><span> BOOL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ReportStatusToSCMgr(=
SERVICE_STATUS_HANDLE svc_handle, SERVICE_STATUS *svc_status)</span><br><sp=
an> {</span><br><span>     return TRUE;</span><br><span> }</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1912?usp=3Demail">change 1912</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1912?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561f=
fdf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1912 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--Wmz4KocoDHY=--


--===============6881774418216354129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6881774418216354129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6881774418216354129==--

