Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817BFC88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MLx+v28/9nyqaxyD/Lzt/nW65o/brxnQama5N1Idxpo=; b=P4BIXADdm59IXLqtkZmtvqkv5g
	uVTsfg34ZTeWQDFjydA4oiR91Q/9lmhRlUE9LLFKpypWmhUoqo8aTILW4AKCIY9H1qNHYYCRfR7uZ
	JXrxhKIiA/dYAklQOMyI3uRrARRXYTSUXQm6ZjxJECwR/CnQQYtxBPqKnHOz1JJpLes0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x52sY-0007U8-Pz;
	Fri, 11 Sep 2026 15:09:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x52sM-0007Tv-NN
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:09:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=A1pikUntRAJhrhhi7lUrmRpew6UuQwAk8EUV0Pto7OU=; b=WDHnhNLj2nDahpwQYgsjpqlNdv
 Dnu/3vd0860geefb8KAurKzYQcbVq0gNRWcB+pYpYLj+eHvToqiyuG5bSOyDVnASoE2hRrjvXeeA1
 XjSiqSPQfonllT00uBAqWHvrDkCw3EZdVtLP1uzSdxwEW4N9xoDyalKjFwUvezKAVJb0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A1pikUntRAJhrhhi7lUrmRpew6UuQwAk8EUV0Pto7OU=; b=B
 o1lMaLuEtzYsk3qKnbdH8X5siUQWHNqWSXlvqoFEi5VK1pPyTTXGB18kUYfRQo4Zjo+u1fGfzJ8jZ
 8iGaHxPrWtmYyqltbdd88oEiYCT2aGICqShQiLGFnW/ZVCPPLwDD8a3u0z744CZtrtlUtEM0otKa+
 jfrFK08JJM+SzOV0=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x52sH-0007A2-Kv for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:09:12 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso10853245e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789139343; x=1789744143; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A1pikUntRAJhrhhi7lUrmRpew6UuQwAk8EUV0Pto7OU=;
 b=LyyMm4+a801zaUftDoVm2DltNSaI52TvytxcIr0AzrxUQ2t5/99oWAjYD+64jnFEne
 Tj5IYRZ6h6tnUyFMDzykX2ID15PjpKqrnpXUtNxAutCR9Iw1mi98dpvOpJJKKiDbethn
 gAbPkX2SbD8yj78w+YzIonVVnVE+ruEPHcj8nOOwLmB+hPOJQy/kpH78VAyXH0mr9HDr
 OBs+xI/qS1nqFvtR36+qRsQiDai+cp/Edwt5favwS2C3E6Vc5036Nze2mvtfjx0t12bk
 N7/vr79OMXvM4JdhqJD6OATbcxUbTWJLsII9NyuDR/fT7SqFIE3xQo2kEBqd9kZQ3w34
 FJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789139343; x=1789744143;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=A1pikUntRAJhrhhi7lUrmRpew6UuQwAk8EUV0Pto7OU=;
 b=GzUO3LNxZnaPjXqUHsVno4flyAQ3te0SLPOWCX3E0zIberUSEP0ezk/LFT6pA9fyuI
 4NSYI3MrzTpD1eDo7eNKJLM0L+MLFdGJtriy5t1FTfOKCn0qGrx+vcznvxfdefFVJVRa
 9dbjzoRpfz5dYCwCx5Z1Do8VrEj+kzc8wtRv7Xc22PXF8uZE+2869H98sDhPeUKzrr9/
 Z+7wsBj772HzelOv9cJSbJtTacVbKezIYj9zGrS9VUnoWeASlzpO7mI0eL1W/OmqMOJP
 1AJyXYLeG7GTs8KvDkldPbr7/OQtsyNqSBz9AxTs7afEiJDPW2ncp2XWYsvCX+8krgq4
 hXcw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbunzzFGMmbgEWZ0BNfvLu5OzM3imBmOsL8V45iBWZcPsA0xfIUxhOtdgEm0h6i7T2/sxhKnTBXpFO66MN@lists.sourceforge.net
X-Gm-Message-State: AFuF++mzPUCLzPv/6liV8QulTLkTTh9vpgQhA3kQOKRYZeFkoikidPjK
 GOfTwVuJVb0l5RwRBNNzNjH4BtjLk1A3/3YtKAvacvnVIlDPxXbOzmA1Ly5h2vgTwKX7p0K0gte
 AYINbgPpfK9owxyneZEHojCWPuXBMLRXVOoAE1rG2JX2jZZmHLQmuPm0VjQK0FBYLmQEF
X-Gm-Gg: AYBFou0c9fhhiZ0WkyjxjJsNWdbX5dQvmHsEF7nMf4h473DHoeEZ2AcSkkCIa9v/met
 tYYhHu838sTmoYGldRrD++0/R6ilnHJCsCxc8jycKSqJYeh3SeGUjK8Bc12yinESqYIDbi/EvxY
 t12VehJure7ARTOfRihMPXcJUVsSiRc6YaiijDC94xKRp9sXUponjulhGpxNqYpqeC2wlap3Gv0
 /LXN1M+2Xzy4vEl7i5D1gmsmdc7ponJ/iwGnPZhaf6axLyam8V7ZAtoFSHYeAMFts0BIL0N5q3O
 0SN5ldztR+j/QMgJGliciYjyOK3eM6o6jFl+49SgUI7h4A83KxG5yflcA61sd7X75Fqrr1JRuxg
 Zb25hsnCWmh6LecnzgDddZNeo5z6SSn4/l2nUnx8EsldQ6fv83gFq1pjncUVW9HvfHrkv4idhNj
 hdVw9sRrJjI7fMnaC1L3chFsNes3JYrW9n61GkzcKMFeiZ/SNsgRgm6GZ8CTuF8FbCskFZsbYas
 TyGZnuzvLxfriDATCqqoH5yhqnZDquREQIfJ8ecy3/zRP4BZ/XWyxA6bZv2kumiSzU1EjFu4UB9
 elCZ3b6wV9ZgH+NzLHHgEnU06XJQwrI32gUSiH/7W67d3bMBGMsNIRlO2WqcyQ==
X-Received: by 2002:a05:600c:c48f:b0:499:bf0e:95c8 with SMTP id
 5b1f17b1804b1-49e619831b6mr61821645e9.1.1789139342626; 
 Fri, 11 Sep 2026 08:09:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6687a1basm37341125e9.12.2026.09.11.08.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:09:02 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:08:59 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf
X-Gerrit-Change-Number: 1912
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1912?usp=email>
X-Gerrit-Commit: b32e3b58e898f1e19c1c5d49019db566c749b810
In-Reply-To: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
References: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTI3MzY3MDAwLkkwYWM5MzRkYTVlZWVkMDQyNGI1NGVkOWI1MjhhMmJmMmI1NjFmZmRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7c911973da9493bde488b643f04d87ba10bb23ee-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x52sH-0007A2-Kv
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6018338093599961975=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6018338093599961975==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+PynDzby130="; charset=UTF-8

--+PynDzby130=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail

to look at the new patch=
 set (#3)=2E


Change subject: Fix various function parameters shadowing ot=
her symbols
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
---
M src/openvpn/gremlin=2Ec
M src/openvpn/m=
anage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/options_string=2Ec
M src/o=
penvpn/proxy=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_verify_backend=2Eh=

M src/openvpn/ssl_verify_mbedtls=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
=
M src/openvpnserv/interactive=2Ec
M src/openvpnserv/validate=2Ec
M tests/un=
it_tests/openvpn/test_pkcs11=2Ec
M tests/unit_tests/openvpnserv/test_openvp=
nserv=2Ec
13 files changed, 67 insertions(+), 66 deletions(-)


  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/12/1912/3

diff --g=
it a/src/openvpn/gremlin=2Ec b/src/openvpn/gremlin=2Ec
index 0bd9396=2E=2Ea=
3efc78 100644
--- a/src/openvpn/gremlin=2Ec
+++ b/src/openvpn/gremlin=2Ec
@=
@ -112,9 +112,9 @@
     return ret;
 }
 
-static bool initialized; /* GLOBA=
L */
-static bool up;          /* GLOBAL */
-static time_t next;      /* GL=
OBAL */
+static bool gremlin_initialized; /* GLOBAL */
+static bool gremlin=
_up;          /* GLOBAL */
+static time_t gremlin_next;      /* GLOBAL */
 =

 /*
  * Return false if we should drop a packet=2E
@@ -125,54 +125,54 @@
 =
    const int up_down_level =3D GREMLIN_UP_DOWN_LEVEL(flags);
     const in=
t drop_level =3D GREMLIN_DROP_LEVEL(flags);
 
-    if (!initialized)
+    i=
f (!gremlin_initialized)
     {
-        initialized =3D true;
+        gre=
mlin_initialized =3D true;
 
         if (up_down_level)
         {
-      =
      up =3D false;
+            gremlin_up =3D false;
         }
         =
else
         {
-            up =3D true;
+            gremlin_up =3D true;=

         }
 
-        next =3D now;
+        gremlin_next =3D now;
     }
=
 
     if (up_down_level) /* change up/down state? */
     {
-        if (n=
ow >=3D next)
+        if (now >=3D gremlin_next)
         {
             i=
nt delta;
-            if (up)
+            if (gremlin_up)
             {
=
                 delta =3D roll(down_low[up_down_level - 1], down_high[up_d=
own_level - 1]);
-                up =3D false;
+                gremlin_up=
 =3D false;
             }
             else
             {
               =
  delta =3D roll(up_low[up_down_level - 1], up_high[up_down_level - 1]);
- =
               up =3D true;
+                gremlin_up =3D true;
         =
    }
 
-            msg(D_GREMLIN, "GREMLIN: CONNECTION GOING %s FOR %d SE=
CONDS", (up ? "UP" : "DOWN"),
+            msg(D_GREMLIN, "GREMLIN: CONNECT=
ION GOING %s FOR %d SECONDS", (gremlin_up ? "UP" : "DOWN"),
               =
  delta);
-            next =3D now + delta;
+            gremlin_next =3D =
now + delta;
         }
     }
 
     if (drop_level)
     {
-        if (u=
p && flip(drop_freq[drop_level - 1]))
+        if (gremlin_up && flip(drop_=
freq[drop_level - 1]))
         {
             dmsg(D_GREMLIN_VERBOSE, "GRE=
MLIN: Random packet drop");
             return false;
         }
     }
 
=
-    return up;
+    return gremlin_up;
 }
 
 /*
diff --git a/src/openvpn/m=
anage=2Ec b/src/openvpn/manage=2Ec
index d57339d=2E=2Ee121b38 100644
--- a/=
src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3062,7 +3062,7 @@
 =
}
 
 void
-management_notify_client_needing_auth(struct management *managem=
ent, const unsigned int mda_key_id,
+management_notify_client_needing_auth(=
struct management *man, const unsigned int mda_key_id,
                    =
                   struct man_def_auth_context *mdac, const struct env_set =
*es)
 {
     if (!(mdac->flags & DAF_CONNECTION_CLOSED))
@@ -3073,12 +3073,=
12 @@
             mode =3D "REAUTH";
         }
         msg(M_CLIENT, ">C=
LIENT:%s,%lu,%u", mode, mdac->cid, mda_key_id);
-        man_output_extra_e=
nv(management, "CLIENT");
-        if (management->connection=2Eenv_filter_=
level > 0)
+        man_output_extra_env(man, "CLIENT");
+        if (man->=
connection=2Eenv_filter_level > 0)
         {
-            man_output_peer_=
info_env(management, mdac);
+            man_output_peer_info_env(man, mdac=
);
         }
-        man_output_env(es, true, management->connection=2Een=
v_filter_level, "CLIENT");
+        man_output_env(es, true, man->connectio=
n=2Eenv_filter_level, "CLIENT");
         mdac->flags |=3D DAF_INITIAL_AUTH=
;
     }
 }
@@ -3104,23 +3104,24 @@
 }
 
 void
-management_connection_estab=
lished(struct management *management, struct man_def_auth_context *mdac,
+m=
anagement_connection_established(struct management *man, struct man_def_aut=
h_context *mdac,
                                   const struct env_set *e=
s)
 {
     mdac->flags |=3D DAF_CONNECTION_ESTABLISHED;
     msg(M_CLIENT, =
">CLIENT:ESTABLISHED,%lu", mdac->cid);
-    man_output_extra_env(management=
, "CLIENT");
-    man_output_env(es, true, management->connection=2Eenv_fil=
ter_level, "CLIENT");
+    man_output_extra_env(man, "CLIENT");
+    man_ou=
tput_env(es, true, man->connection=2Eenv_filter_level, "CLIENT");
 }
 
 voi=
d
-management_notify_client_close(struct management *management, struct man=
_def_auth_context *mdac,
+management_notify_client_close(const struct manag=
ement *man,
+                               struct man_def_auth_context *md=
ac,
                                const struct env_set *es)
 {
     if ((=
mdac->flags & DAF_INITIAL_AUTH) && !(mdac->flags & DAF_CONNECTION_CLOSED))
=
     {
         msg(M_CLIENT, ">CLIENT:DISCONNECT,%lu", mdac->cid);
-      =
  man_output_env(es, true, management->connection=2Eenv_filter_level, "CLIE=
NT");
+        man_output_env(es, true, man->connection=2Eenv_filter_level,=
 "CLIENT");
         mdac->flags |=3D DAF_CONNECTION_CLOSED;
     }
 }
@@ -=
3980,12 +3981,12 @@
  */
 
 struct command_line *
-command_line_new(const s=
ize_t buf_len)
+command_line_new(const size_t len)
 {
     struct command_l=
ine *cl;
     ALLOC_OBJ_CLEAR(cl, struct command_line);
-    cl->buf =3D al=
loc_buf(buf_len);
-    cl->residual =3D alloc_buf(buf_len);
+    cl->buf =
=3D alloc_buf(len);
+    cl->residual =3D alloc_buf(len);
     return cl;
 =
}
 
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 3ab9=
37c=2E=2E1e7855d 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/mana=
ge=2Eh
@@ -389,15 +389,15 @@
 
 void management_notify_generic(const char *=
str);
 
-void management_notify_client_needing_auth(struct management *mana=
gement,
+void management_notify_client_needing_auth(struct management *man,=

                                            const unsigned int auth_id,
  =
                                          struct man_def_auth_context *mdac=
,
                                            const struct env_set *es);
 
=
-void management_connection_established(struct management *management,
+voi=
d management_connection_established(struct management *man,
               =
                         struct man_def_auth_context *mdac, const struct en=
v_set *es);
 
-void management_notify_client_close(struct management *manag=
ement,
+void management_notify_client_close(const struct management *man,
 =
                                    struct man_def_auth_context *mdac, cons=
t struct env_set *es);
 
 void management_learn_addr(struct man_def_auth_co=
ntext *mdac,
diff --git a/src/openvpn/options_string=2Ec b/src/openvpn/opti=
ons_string=2Ec
index d3b29b8=2E=2E88ab798 100644
--- a/src/openvpn/options_=
string=2Ec
+++ b/src/openvpn/options_string=2Ec
@@ -396,12 +396,12 @@
 #end=
if
 
 char *
-options_string_extract_option(const char *options_string, con=
st char *opt_name, struct gc_arena *gc)
+options_string_extract_option(cons=
t char *option_string, const char *opt_name, struct gc_arena *gc)
 {
     c=
har *ret =3D NULL;
     const size_t opt_name_len =3D strlen(opt_name);
 
-=
    const char *p =3D options_string;
+    const char *p =3D option_string;=

     while (p)
     {
         if (0 =3D=3D strncmp(p, opt_name, opt_name_=
len) && strlen(p) > (opt_name_len + 1)
diff --git a/src/openvpn/proxy=2Ec b=
/src/openvpn/proxy=2Ec
index e0700aa=2E=2E74a6cf9 100644
--- a/src/openvpn/=
proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -184,10 +184,10 @@
 }
 
 bool
-pro=
xy_send(socket_descriptor_t sd, const void *buf, size_t buf_len)
+proxy_sen=
d(socket_descriptor_t sd, const void *buf, size_t len)
 {
-    const ssize_=
t size =3D openvpn_send(sd, buf, buf_len, MSG_NOSIGNAL);
-    if (size !=3D=
 (ssize_t)buf_len)
+    const ssize_t size =3D openvpn_send(sd, buf, len, M=
SG_NOSIGNAL);
+    if (size !=3D (ssize_t)len)
     {
         msg(D_LINK_E=
RRORS | M_ERRNO, "proxy_send: TCP port write failed on send()");
         r=
eturn false;
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 4=
8508e5=2E=2E76150d4 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=
=2Ec
@@ -1360,7 +1360,7 @@
 
 static void
 init_epoch_keys(struct key_state=
 *ks, struct tls_multi *multi, const struct key_type *key_type,
-          =
      bool server, struct key2 *key2)
+                bool server, const s=
truct key2 *key2)
 {
     /* For now we hardcode this to be 4 for the softw=
are based data channel
      * DCO based implementations/HW implementation =
might adjust this number
@@ -1403,14 +1403,14 @@
 
 static void
 init_key_c=
ontexts(struct key_state *ks, struct tls_multi *multi, const struct key_typ=
e *key_type,
-                  bool server, struct key2 *key2, bool dco_en=
abled)
+                  bool server, const struct key2 *key2, bool dco)
 =
{
     struct key_ctx_bi *key =3D &ks->crypto_options=2Ekey_ctx_bi;
 
     =
/* Initialize key contexts */
     int key_direction =3D server ? KEY_DIREC=
TION_INVERSE : KEY_DIRECTION_NORMAL;
 
-    if (dco_enabled)
+    if (dco)
=
     {
         if (key->encrypt=2Ehmac)
         {
diff --git a/src/openvp=
n/ssl_verify_backend=2Eh b/src/openvpn/ssl_verify_backend=2Eh
index 9272cae=
=2E=2E46720d6 100644
--- a/src/openvpn/ssl_verify_backend=2Eh
+++ b/src/ope=
nvpn/ssl_verify_backend=2Eh
@@ -220,14 +220,14 @@
  * Check X=2E509 Netscap=
e certificate type field, if available=2E
  *
  * @param cert          Cert=
ificate to check=2E
- * @param usage         One of \c NS_CERT_CHECK_CLIENT=
, \c NS_CERT_CHECK_SERVER,
+ * @param cert_type     One of \c NS_CERT_CHECK=
_CLIENT, \c NS_CERT_CHECK_SERVER,
  *                      or \c NS_CERT_CH=
ECK_NONE=2E
  *
  * @return              \c SUCCESS if NS_CERT_CHECK_NONE o=
r if the certificate has
  *                      the expected bit set=2E \=
c FAILURE if the certificate does
  *                      not have NS cert=
 type verification or the wrong bit set=2E
  */
-result_t x509_verify_ns_ce=
rt_type(openvpn_x509_cert_t *cert, const int usage);
+result_t x509_verify_=
ns_cert_type(openvpn_x509_cert_t *cert, const int cert_type);
 
 /*
  * Ver=
ify X=2E509 key usage extension field=2E
diff --git a/src/openvpn/ssl_verif=
y_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index 9f676ed=2E=2Ec4bae=
40 100644
--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/src/openvpn/ssl_ve=
rify_mbedtls=2Ec
@@ -753,9 +753,9 @@
 /* Dummy function because Netscape ce=
rtificate types are not supported in OpenVPN with mbedtls=2E
  * Returns SU=
CCESS if usage is NS_CERT_CHECK_NONE, FAILURE otherwise=2E */
 result_t
-x5=
09_verify_ns_cert_type(mbedtls_x509_crt *cert, const int usage)
+x509_verif=
y_ns_cert_type(mbedtls_x509_crt *cert, const int cert_type)
 {
-    if (usa=
ge =3D=3D NS_CERT_CHECK_NONE)
+    if (cert_type =3D=3D NS_CERT_CHECK_NONE)=

     {
         return SUCCESS;
     }
diff --git a/src/openvpn/ssl_verify=
_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec
index a6307f6=2E=2E6073e4=
e 100644
--- a/src/openvpn/ssl_verify_openssl=2Ec
+++ b/src/openvpn/ssl_ver=
ify_openssl=2Ec
@@ -629,13 +629,13 @@
 }
 
 result_t
-x509_verify_ns_cert_t=
ype(openvpn_x509_cert_t *peer_cert, const int usage)
+x509_verify_ns_cert_t=
ype(openvpn_x509_cert_t *peer_cert, const int cert_type)
 {
-    if (usage =
=3D=3D NS_CERT_CHECK_NONE)
+    if (cert_type =3D=3D NS_CERT_CHECK_NONE)
  =
   {
         return SUCCESS;
     }
-    if (usage =3D=3D NS_CERT_CHECK_CL=
IENT)
+    if (cert_type =3D=3D NS_CERT_CHECK_CLIENT)
     {
         /*
  =
        * Unfortunately, X509_check_purpose() before OpenSSL 4=2E0 does som=
e weird thing that
@@ -668,7 +668,7 @@
         }
         return result;
 =
    }
-    if (usage =3D=3D NS_CERT_CHECK_SERVER)
+    if (cert_type =3D=3D=
 NS_CERT_CHECK_SERVER)
     {
         /*
          * Unfortunately, X509_c=
heck_purpose() before OpenSSL 4=2E0 does some weird thing that
diff --git a=
/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index d2=
288b9=2E=2E7819f5a 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/o=
penvpnserv/interactive=2Ec
@@ -3848,8 +3848,8 @@
 
 
 static DWORD
-UpdateW=
aitHandles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE io_event, HANDLE ex=
it_event,
-                  list_item_t *threads)
+UpdateWaitHandles(LPHAN=
DLE *handles_ptr, LPDWORD count, HANDLE io_event,
+                  const =
list_item_t *threads)
 {
     static DWORD size =3D 10;
     static LPHANDL=
E handles =3D NULL;
@@ -3998,7 +3998,7 @@
         goto out;
     }
 
-    =
error =3D UpdateWaitHandles(&handles, &handle_count, io_event, exit_event, =
threads);
+    error =3D UpdateWaitHandles(&handles, &handle_count, io_even=
t, threads);
     if (error !=3D NO_ERROR)
     {
         goto out;
@@ -40=
65,7 +4065,7 @@
                 if (!error)
                 {
           =
          error =3D
-                        UpdateWaitHandles(&handles, &h=
andle_count, io_event, exit_event, threads);
+                        Updat=
eWaitHandles(&handles, &handle_count, io_event, threads);
                 =
}
                 if (error)
                 {
@@ -4073,7 +4073,7 @@
    =
                             &exit_event);
                     /* Update w=
ait handles again after removing the last worker thread */
                =
     RemoveListItem(&threads, CmpHandle, thread);
-                    Upda=
teWaitHandles(&handles, &handle_count, io_event, exit_event, threads);
+   =
                 UpdateWaitHandles(&handles, &handle_count, io_event, threa=
ds);
                     TerminateThread(thread, 1);
                     =
CloseHandleEx(&thread);
                     CloseHandleEx(&pipe);
@@ -4113=
,7 +4113,7 @@
 
             /* Worker thread ended */
             HANDLE =
thread =3D RemoveListItem(&threads, CmpHandle, handles[error]);
-          =
  UpdateWaitHandles(&handles, &handle_count, io_event, exit_event, threads)=
;
+            UpdateWaitHandles(&handles, &handle_count, io_event, threads=
);
             CloseHandleEx(&thread);
         }
     }
diff --git a/src/=
openvpnserv/validate=2Ec b/src/openvpnserv/validate=2Ec
index 8e529b9=2E=2E=
6a13a06 100644
--- a/src/openvpnserv/validate=2Ec
+++ b/src/openvpnserv/val=
idate=2Ec
@@ -27,7 +27,7 @@
 #include <pathcch=2Eh>
 #include <lm=2Eh>
 
-s=
tatic const WCHAR *white_list[] =3D {
+static const WCHAR *global_white_lis=
t[] =3D {
     L"auth-retry",
     L"config",
     L"log",
@@ -335,7 +335,7=
 @@
     }
 
     /* option name starts at 2 characters from argv[i] */
-  =
  if (OptionLookup(argv[0] + 2, white_list) =3D=3D -1) /* not found */
+   =
 if (OptionLookup(argv[0] + 2, global_white_list) =3D=3D -1) /* not found *=
/
     {
         return FALSE;
     }
diff --git a/tests/unit_tests/openvp=
n/test_pkcs11=2Ec b/tests/unit_tests/openvpn/test_pkcs11=2Ec
index 042bd8b=
=2E=2Ea54c504 100644
--- a/tests/unit_tests/openvpn/test_pkcs11=2Ec
+++ b/t=
ests/unit_tests/openvpn/test_pkcs11=2Ec
@@ -137,7 +137,7 @@
 static char so=
fthsm2_conf_path[] =3D "softhsm2_conf_XXXXXX";
 int num_certs;
 static cons=
t char *pkcs11_id_current;
-struct env_set *es;
+struct env_set *test_set;
=
 
 /* Fill-in certs[] array */
 void
@@ -218,15 +218,15 @@
 
     /* enviro=
nment */
     setenv("SOFTHSM2_CONF", softhsm2_conf_path, 1);
-    es =3D e=
nv_set_create(NULL);
-    setenv_str(es, "SOFTHSM2_CONF", softhsm2_conf_pat=
h);
-    setenv_str(es, "GNUTLS_PIN", PIN);
+    test_set =3D env_set_creat=
e(NULL);
+    setenv_str(test_set, "SOFTHSM2_CONF", softhsm2_conf_path);
+ =
   setenv_str(test_set, "GNUTLS_PIN", PIN);
 
     /* init the token using =
the temporary location as storage */
     struct argv a =3D argv_new();
   =
  argv_printf(&a, "%s --init-token --free --label \"%s\" --so-pin %s --pin =
%s",
                 SOFTHSM2_UTIL_PATH, token_name, PIN, PIN);
-    asser=
t_true(openvpn_execve_check(&a, es, 0, "Failed to initialize token"));
+   =
 assert_true(openvpn_execve_check(&a, test_set, 0, "Failed to initialize to=
ken"));
 
     /* Import certificates and keys in our test database into th=
e token */
     char cert[] =3D "cert_XXXXXX";
@@ -263,14 +263,14 @@
      =
   argv_printf(
             &a, "%s --provider %s --load-certificate %s --=
label \"%s\" --id %08x --login --write",
             P11TOOL_PATH, SOFTHSM=
2_MODULE_PATH, cert, c->friendly_name, num_certs + 1);
-        assert_true=
(openvpn_execve_check(&a, es, 0, "Failed to upload certificate into token")=
);
+        assert_true(openvpn_execve_check(&a, test_set, 0, "Failed to up=
load certificate into token"));
 
         argv_free(&a);
         a =3D ar=
gv_new();
         argv_printf(&a,
                     "%s --provider %s -=
-load-privkey %s --label \"%s\" --id %08x --login --write",
               =
      P11TOOL_PATH, SOFTHSM2_MODULE_PATH, key, c->friendly_name, num_certs =
+ 1);
-        assert_true(openvpn_execve_check(&a, es, 0, "Failed to uploa=
d key into token"));
+        assert_true(openvpn_execve_check(&a, test_set=
, 0, "Failed to upload key into token"));
 
         assert_int_equal(ftrun=
cate(cert_fd, 0), 0);
         assert_int_equal(ftruncate(key_fd, 0), 0);
@=
@ -294,7 +294,7 @@
     struct argv a =3D argv_new();
 
     argv_printf(&a=
, "%s --delete-token --token \"%s\"", SOFTHSM2_UTIL_PATH, token_name);
-   =
 assert_true(openvpn_execve_check(&a, es, 0, "Failed to delete token"));
+ =
   assert_true(openvpn_execve_check(&a, test_set, 0, "Failed to delete toke=
n"));
     argv_free(&a);
 
     rmdir(softhsm2_tokens_path); /* this must =
be empty after delete token */
@@ -304,7 +304,7 @@
         free(c->p11_id)=
;
         c->p11_id =3D NULL;
     }
-    env_set_destroy(es);
+    env_se=
t_destroy(test_set);
     return 0;
 }
 
diff --git a/tests/unit_tests/open=
vpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/test_openvpnser=
v=2Ec
index e01b0e3=2E=2E4ca715b 100644
--- a/tests/unit_tests/openvpnserv/=
test_openvpnserv=2Ec
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2E=
c
@@ -35,7 +35,7 @@
 #include "interactive=2Ec"
 
 BOOL
-ReportStatusToSCMg=
r(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status)
+ReportStatusToSCM=
gr(SERVICE_STATUS_HANDLE svc_handle, SERVICE_STATUS *svc_status)
 {
     re=
turn TRUE;
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1912?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a=
c934da5eeed0424b54ed9b528a2bf2b561ffdf
Gerrit-Change-Number: 1912
Gerrit-Pa=
tchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eo=
rg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: flichtenheld <frank@lichtenheld=2Ecom>

--+PynDzby130=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">Fix various function parameters shadowing other symbols<br><br>=
Updated to a newer version of cppcheck (2=2E21=2E0) and it<br>reported a ne=
w group of issues where function parameters<br>shadow global variables or f=
unction names=2E<br><br>Used a variety of different solutions depending on =
context,<br>either renaming the global variables or the function<br>paramet=
ers=2E<br><br>In one case I removed the parameter since it only contained<b=
r>the global variable anyway=2E<br><br>Where applicable I have combined the=
 change with fixing<br>occurrences of constParameterPointer to reduce confl=
icts<br>between different cppcheck fix commits=2E<br><br>Change-Id: I0ac934=
da5eeed0424b54ed9b528a2bf2b561ffdf<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/gremlin=2Ec<br>M src/op=
envpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/options_strin=
g=2Ec<br>M src/openvpn/proxy=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/=
ssl_verify_backend=2Eh<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>M src/ope=
nvpn/ssl_verify_openssl=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M src/o=
penvpnserv/validate=2Ec<br>M tests/unit_tests/openvpn/test_pkcs11=2Ec<br>M =
tests/unit_tests/openvpnserv/test_openvpnserv=2Ec<br>13 files changed, 67 i=
nsertions(+), 66 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/12/1912/3</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/gremlin=2Ec b/src/openvpn/gremlin=2Ec</span><br><span>index =
0bd9396=2E=2Ea3efc78 100644</span><br><span>--- a/src/openvpn/gremlin=2Ec</=
span><br><span>+++ b/src/openvpn/gremlin=2Ec</span><br><span>@@ -112,9 +112=
,9 @@</span><br><span>     return ret;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool initializ=
ed; /* GLOBAL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c bool up;          /* GLOBAL */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static time_t next;      /* GLOBAL */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static bool gremlin_initialized; /* GLOBAL */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool gremlin_=
up;          /* GLOBAL */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static time_t gremlin_next;      /* GLOBAL */</span><br><span> </span=
><br><span> /*</span><br><span>  * Return false if we should drop a packet=
=2E</span><br><span>@@ -125,54 +125,54 @@</span><br><span>     const int up=
_down_level =3D GREMLIN_UP_DOWN_LEVEL(flags);</span><br><span>     const in=
t drop_level =3D GREMLIN_DROP_LEVEL(flags);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!initialized)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!gremlin_initialized)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      initialized =3D true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        gremlin_initialized =3D true;</span><br><span> </span><br><=
span>         if (up_down_level)</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            up =3D false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            gremlin_up =3D fals=
e;</span><br><span>         }</span><br><span>         else</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  up =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       gremlin_up =3D true;</span><br><span>         }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        next =3D now;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        gremlin_next =
=3D now;</span><br><span>     }</span><br><span> </span><br><span>     if (=
up_down_level) /* change up/down state? */</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (now &gt;=3D next)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (now &gt;=
=3D gremlin_next)</span><br><span>         {</span><br><span>             i=
nt delta;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
if (up)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (gremlin_up)</span><br><span>             {</span><br><span>            =
     delta =3D roll(down_low[up_down_level - 1], down_high[up_down_level - =
1]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                u=
p =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         gremlin_up =3D false;</span><br><span>             }</span><br><sp=
an>             else</span><br><span>             {</span><br><span>       =
          delta =3D roll(up_low[up_down_level - 1], up_high[up_down_level -=
 1]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
up =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         gremlin_up =3D true;</span><br><span>             }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_=
GREMLIN, &quot;GREMLIN: CONNECTION GOING %s FOR %d SECONDS&quot;, (up ? &qu=
ot;UP&quot; : &quot;DOWN&quot;),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(D_GREMLIN, &quot;GREMLIN: CONNECTION GOING %s =
FOR %d SECONDS&quot;, (gremlin_up ? &quot;UP&quot; : &quot;DOWN&quot;),</sp=
an><br><span>                 delta);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            next =3D now + delta;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            gremlin_next =3D now + delta;</sp=
an><br><span>         }</span><br><span>     }</span><br><span> </span><br>=
<span>     if (drop_level)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (up &amp;&amp; flip(drop_freq[drop_l=
evel - 1]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (gremlin_up &amp;&amp; flip(drop_freq[drop_level - 1]))</span><br><span>=
         {</span><br><span>             dmsg(D_GREMLIN_VERBOSE, &quot;GREML=
IN: Random packet drop&quot;);</span><br><span>             return false;</=
span><br><span>         }</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return up;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return gremlin_up;</span><br><s=
pan> }</span><br><span> </span><br><span> /*</span><br><span>diff --git a/s=
rc/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index d57339=
d=2E=2Ee121b38 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><b=
r><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3062,7 +3062,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-management_notify_client_needing_auth(=
struct management *management, const unsigned int mda_key_id,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+management_notify_client_needing_=
auth(struct management *man, const unsigned int mda_key_id,</span><br><span=
>                                       struct man_def_auth_context *mdac, =
const struct env_set *es)</span><br><span> {</span><br><span>     if (!(mda=
c-&gt;flags &amp; DAF_CONNECTION_CLOSED))</span><br><span>@@ -3073,12 +3073=
,12 @@</span><br><span>             mode =3D &quot;REAUTH&quot;;</span><br>=
<span>         }</span><br><span>         msg(M_CLIENT, &quot;&gt;CLIENT:%s=
,%lu,%u&quot;, mode, mdac-&gt;cid, mda_key_id);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        man_output_extra_env(management, &quot;CL=
IENT&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (management-&gt;connection=2Eenv_filter_level &gt; 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        man_output_extra_env(man, &quot=
;CLIENT&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (man-&gt;connection=2Eenv_filter_level &gt; 0)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            man_=
output_peer_info_env(management, mdac);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            man_output_peer_info_env(man, mdac);</span>=
<br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       man_output_env(es, true, management-&gt;connection=2Eenv_filter_leve=
l, &quot;CLIENT&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        man_output_env(es, true, man-&gt;connection=2Eenv_filter_level,=
 &quot;CLIENT&quot;);</span><br><span>         mdac-&gt;flags |=3D DAF_INIT=
IAL_AUTH;</span><br><span>     }</span><br><span> }</span><br><span>@@ -310=
4,23 +3104,24 @@</span><br><span> }</span><br><span> </span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_connection=
_established(struct management *management, struct man_def_auth_context *md=
ac,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_conne=
ction_established(struct management *man, struct man_def_auth_context *mdac=
,</span><br><span>                                   const struct env_set *=
es)</span><br><span> {</span><br><span>     mdac-&gt;flags |=3D DAF_CONNECT=
ION_ESTABLISHED;</span><br><span>     msg(M_CLIENT, &quot;&gt;CLIENT:ESTABL=
ISHED,%lu&quot;, mdac-&gt;cid);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    man_output_extra_env(management, &quot;CLIENT&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    man_output_env(es, true, =
management-&gt;connection=2Eenv_filter_level, &quot;CLIENT&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    man_output_extra_env(man=
, &quot;CLIENT&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    man_output_env(es, true, man-&gt;connection=2Eenv_filter_level, &quo=
t;CLIENT&quot;);</span><br><span> }</span><br><span> </span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_notify_cli=
ent_close(struct management *management, struct man_def_auth_context *mdac,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_notify_c=
lient_close(const struct management *man,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                               struct man_def_auth_co=
ntext *mdac,</span><br><span>                                const struct e=
nv_set *es)</span><br><span> {</span><br><span>     if ((mdac-&gt;flags &am=
p; DAF_INITIAL_AUTH) &amp;&amp; !(mdac-&gt;flags &amp; DAF_CONNECTION_CLOSE=
D))</span><br><span>     {</span><br><span>         msg(M_CLIENT, &quot;&gt=
;CLIENT:DISCONNECT,%lu&quot;, mdac-&gt;cid);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        man_output_env(es, true, management-&gt;conn=
ection=2Eenv_filter_level, &quot;CLIENT&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        man_output_env(es, true, man-&gt;connec=
tion=2Eenv_filter_level, &quot;CLIENT&quot;);</span><br><span>         mdac=
-&gt;flags |=3D DAF_CONNECTION_CLOSED;</span><br><span>     }</span><br><sp=
an> }</span><br><span>@@ -3980,12 +3981,12 @@</span><br><span>  */</span><b=
r><span> </span><br><span> struct command_line *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-command_line_new(const size_t buf_len)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+command_line_new(const size_t=
 len)</span><br><span> {</span><br><span>     struct command_line *cl;</spa=
n><br><span>     ALLOC_OBJ_CLEAR(cl, struct command_line);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    cl-&gt;buf =3D alloc_buf(buf_len);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cl-&gt;residual =
=3D alloc_buf(buf_len);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    cl-&gt;buf =3D alloc_buf(len);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    cl-&gt;residual =3D alloc_buf(len);</span><br><span>=
     return cl;</span><br><span> }</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>inde=
x 3ab937c=2E=2E1e7855d 100644</span><br><span>--- a/src/openvpn/manage=2Eh<=
/span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -389,15 +38=
9,15 @@</span><br><span> </span><br><span> void management_notify_generic(c=
onst char *str);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void management_notify_client_needing_auth(struct management *=
management,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void man=
agement_notify_client_needing_auth(struct management *man,</span><br><span>=
                                            const unsigned int auth_id,</sp=
an><br><span>                                            struct man_def_aut=
h_context *mdac,</span><br><span>                                          =
  const struct env_set *es);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void management_connection_established(struct mana=
gement *management,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void management_connection_established(struct management *man,</span><br><s=
pan>                                        struct man_def_auth_context *md=
ac, const struct env_set *es);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void management_notify_client_close(struct manag=
ement *management,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid management_notify_client_close(const struct management *man,</span><br>=
<span>                                     struct man_def_auth_context *mda=
c, const struct env_set *es);</span><br><span> </span><br><span> void manag=
ement_learn_addr(struct man_def_auth_context *mdac,</span><br><span>diff --=
git a/src/openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec</span=
><br><span>index d3b29b8=2E=2E88ab798 100644</span><br><span>--- a/src/open=
vpn/options_string=2Ec</span><br><span>+++ b/src/openvpn/options_string=2Ec=
</span><br><span>@@ -396,12 +396,12 @@</span><br><span> #endif</span><br><s=
pan> </span><br><span> char *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-options_string_extract_option(const char *options_string, const cha=
r *opt_name, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+options_string_extract_option(const char *option_string, cons=
t char *opt_name, struct gc_arena *gc)</span><br><span> {</span><br><span> =
    char *ret =3D NULL;</span><br><span>     const size_t opt_name_len =3D =
strlen(opt_name);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    const char *p =3D options_string;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *p =3D option_string;</spa=
n><br><span>     while (p)</span><br><span>     {</span><br><span>         =
if (0 =3D=3D strncmp(p, opt_name, opt_name_len) &amp;&amp; strlen(p) &gt; (=
opt_name_len + 1)</span><br><span>diff --git a/src/openvpn/proxy=2Ec b/src/=
openvpn/proxy=2Ec</span><br><span>index e0700aa=2E=2E74a6cf9 100644</span><=
br><span>--- a/src/openvpn/proxy=2Ec</span><br><span>+++ b/src/openvpn/prox=
y=2Ec</span><br><span>@@ -184,10 +184,10 @@</span><br><span> }</span><br><s=
pan> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-proxy_send(socket_descriptor_t sd, const void *buf, size_t buf_len)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+proxy_send(socket_des=
criptor_t sd, const void *buf, size_t len)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    const ssize_t size =3D openvpn_=
send(sd, buf, buf_len, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (size !=3D (ssize_t)buf_len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const ssize_t size =3D openvpn_send(s=
d, buf, len, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (size !=3D (ssize_t)len)</span><br><span>     {</span><br><s=
pan>         msg(D_LINK_ERRORS | M_ERRNO, &quot;proxy_send: TCP port write =
failed on send()&quot;);</span><br><span>         return false;</span><br><=
span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span=
>index 48508e5=2E=2E76150d4 100644</span><br><span>--- a/src/openvpn/ssl=2E=
c</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1360,7 +136=
0,7 @@</span><br><span> </span><br><span> static void</span><br><span> init=
_epoch_keys(struct key_state *ks, struct tls_multi *multi, const struct key=
_type *key_type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           bool server, struct key2 *key2)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                bool server, const struct key2 *key2=
)</span><br><span> {</span><br><span>     /* For now we hardcode this to be=
 4 for the software based data channel</span><br><span>      * DCO based im=
plementations/HW implementation might adjust this number</span><br><span>@@=
 -1403,14 +1403,14 @@</span><br><span> </span><br><span> static void</span>=
<br><span> init_key_contexts(struct key_state *ks, struct tls_multi *multi,=
 const struct key_type *key_type,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                  bool server, struct key2 *key2, bool dco_enab=
led)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
   bool server, const struct key2 *key2, bool dco)</span><br><span> {</span=
><br><span>     struct key_ctx_bi *key =3D &amp;ks-&gt;crypto_options=2Ekey=
_ctx_bi;</span><br><span> </span><br><span>     /* Initialize key contexts =
*/</span><br><span>     int key_direction =3D server ? KEY_DIRECTION_INVERS=
E : KEY_DIRECTION_NORMAL;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (dco_enabled)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (dco)</span><br><span>     {</span><br><span>=
         if (key-&gt;encrypt=2Ehmac)</span><br><span>         {</span><br><=
span>diff --git a/src/openvpn/ssl_verify_backend=2Eh b/src/openvpn/ssl_veri=
fy_backend=2Eh</span><br><span>index 9272cae=2E=2E46720d6 100644</span><br>=
<span>--- a/src/openvpn/ssl_verify_backend=2Eh</span><br><span>+++ b/src/op=
envpn/ssl_verify_backend=2Eh</span><br><span>@@ -220,14 +220,14 @@</span><b=
r><span>  * Check X=2E509 Netscape certificate type field, if available=2E<=
/span><br><span>  *</span><br><span>  * @param cert          Certificate to=
 check=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param us=
age         One of \c NS_CERT_CHECK_CLIENT, \c NS_CERT_CHECK_SERVER,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param cert_type     On=
e of \c NS_CERT_CHECK_CLIENT, \c NS_CERT_CHECK_SERVER,</span><br><span>  * =
                     or \c NS_CERT_CHECK_NONE=2E</span><br><span>  *</span>=
<br><span>  * @return              \c SUCCESS if NS_CERT_CHECK_NONE or if t=
he certificate has</span><br><span>  *                      the expected bi=
t set=2E \c FAILURE if the certificate does</span><br><span>  *            =
          not have NS cert type verification or the wrong bit set=2E</span>=
<br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-result_=
t x509_verify_ns_cert_type(openvpn_x509_cert_t *cert, const int usage);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+result_t x509_verify_ns=
_cert_type(openvpn_x509_cert_t *cert, const int cert_type);</span><br><span=
> </span><br><span> /*</span><br><span>  * Verify X=2E509 key usage extensi=
on field=2E</span><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec=
 b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>index 9f676ed=2E=2Ec4=
bae40 100644</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls=2Ec</span=
><br><span>+++ b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -753=
,9 +753,9 @@</span><br><span> /* Dummy function because Netscape certificat=
e types are not supported in OpenVPN with mbedtls=2E</span><br><span>  * Re=
turns SUCCESS if usage is NS_CERT_CHECK_NONE, FAILURE otherwise=2E */</span=
><br><span> result_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-x=
509_verify_ns_cert_type(mbedtls_x509_crt *cert, const int usage)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+x509_verify_ns_cert_type(mbedt=
ls_x509_crt *cert, const int cert_type)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (usage =3D=3D NS_CERT_CHECK_NON=
E)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cert_type=
 =3D=3D NS_CERT_CHECK_NONE)</span><br><span>     {</span><br><span>        =
 return SUCCESS;</span><br><span>     }</span><br><span>diff --git a/src/op=
envpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec</span><br=
><span>index a6307f6=2E=2E6073e4e 100644</span><br><span>--- a/src/openvpn/=
ssl_verify_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_openssl=
=2Ec</span><br><span>@@ -629,13 +629,13 @@</span><br><span> }</span><br><sp=
an> </span><br><span> result_t</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_cert, const int=
 usage)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+x509_verify_=
ns_cert_type(openvpn_x509_cert_t *peer_cert, const int cert_type)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (usag=
e =3D=3D NS_CERT_CHECK_NONE)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (cert_type =3D=3D NS_CERT_CHECK_NONE)</span><br><span>     =
{</span><br><span>         return SUCCESS;</span><br><span>     }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (usage =3D=3D NS_CERT_CH=
ECK_CLIENT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
cert_type =3D=3D NS_CERT_CHECK_CLIENT)</span><br><span>     {</span><br><sp=
an>         /*</span><br><span>          * Unfortunately, X509_check_purpos=
e() before OpenSSL 4=2E0 does some weird thing that</span><br><span>@@ -668=
,7 +668,7 @@</span><br><span>         }</span><br><span>         return res=
ult;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (usage =3D=3D NS_CERT_CHECK_SERVER)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (cert_type =3D=3D NS_CERT_CHECK_SERVER)=
</span><br><span>     {</span><br><span>         /*</span><br><span>       =
   * Unfortunately, X509_check_purpose() before OpenSSL 4=2E0 does some wei=
rd thing that</span><br><span>diff --git a/src/openvpnserv/interactive=2Ec =
b/src/openvpnserv/interactive=2Ec</span><br><span>index d2288b9=2E=2E7819f5=
a 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><s=
pan>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -3848,8 +3848,=
8 @@</span><br><span> </span><br><span> </span><br><span> static DWORD</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-UpdateWaitHandles(LPHANDLE=
 *handles_ptr, LPDWORD count, HANDLE io_event, HANDLE exit_event,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                  list_item_t *=
threads)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+UpdateWaitH=
andles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE io_event,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                  const list_item=
_t *threads)</span><br><span> {</span><br><span>     static DWORD size =3D =
10;</span><br><span>     static LPHANDLE handles =3D NULL;</span><br><span>=
@@ -3998,7 +3998,7 @@</span><br><span>         goto out;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    error =3D UpdateWaitHandles(&amp;handles, &amp;handle_count, io_event,=
 exit_event, threads);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    error =3D UpdateWaitHandles(&amp;handles, &amp;handle_count, io_even=
t, threads);</span><br><span>     if (error !=3D NO_ERROR)</span><br><span>=
     {</span><br><span>         goto out;</span><br><span>@@ -4065,7 +4065,=
7 @@</span><br><span>                 if (!error)</span><br><span>         =
        {</span><br><span>                     error =3D</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                        UpdateWaitHandle=
s(&amp;handles, &amp;handle_count, io_event, exit_event, threads);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        Upda=
teWaitHandles(&amp;handles, &amp;handle_count, io_event, threads);</span><b=
r><span>                 }</span><br><span>                 if (error)</spa=
n><br><span>                 {</span><br><span>@@ -4073,7 +4073,7 @@</span>=
<br><span>                                 &amp;exit_event);</span><br><spa=
n>                     /* Update wait handles again after removing the last=
 worker thread */</span><br><span>                     RemoveListItem(&amp;=
threads, CmpHandle, thread);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    UpdateWaitHandles(&amp;handles, &amp;handle_coun=
t, io_event, exit_event, threads);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    UpdateWaitHandles(&amp;handles, &amp;han=
dle_count, io_event, threads);</span><br><span>                     Termina=
teThread(thread, 1);</span><br><span>                     CloseHandleEx(&am=
p;thread);</span><br><span>                     CloseHandleEx(&amp;pipe);</=
span><br><span>@@ -4113,7 +4113,7 @@</span><br><span> </span><br><span>    =
         /* Worker thread ended */</span><br><span>             HANDLE thre=
ad =3D RemoveListItem(&amp;threads, CmpHandle, handles[error]);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            UpdateWaitHandles(&am=
p;handles, &amp;handle_count, io_event, exit_event, threads);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            UpdateWaitHandles(&am=
p;handles, &amp;handle_count, io_event, threads);</span><br><span>         =
    CloseHandleEx(&amp;thread);</span><br><span>         }</span><br><span>=
     }</span><br><span>diff --git a/src/openvpnserv/validate=2Ec b/src/open=
vpnserv/validate=2Ec</span><br><span>index 8e529b9=2E=2E6a13a06 100644</spa=
n><br><span>--- a/src/openvpnserv/validate=2Ec</span><br><span>+++ b/src/op=
envpnserv/validate=2Ec</span><br><span>@@ -27,7 +27,7 @@</span><br><span> #=
include &lt;pathcch=2Eh&gt;</span><br><span> #include &lt;lm=2Eh&gt;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static con=
st WCHAR *white_list[] =3D {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static const WCHAR *global_white_list[] =3D {</span><br><span>    =
 L&quot;auth-retry&quot;,</span><br><span>     L&quot;config&quot;,</span><=
br><span>     L&quot;log&quot;,</span><br><span>@@ -335,7 +335,7 @@</span><=
br><span>     }</span><br><span> </span><br><span>     /* option name start=
s at 2 characters from argv[i] */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (OptionLookup(argv[0] + 2, white_list) =3D=3D -1) /* not=
 found */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (Op=
tionLookup(argv[0] + 2, global_white_list) =3D=3D -1) /* not found */</span=
><br><span>     {</span><br><span>         return FALSE;</span><br><span>  =
   }</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkcs11=2Ec =
b/tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span>index 042bd8b=2E=
=2Ea54c504 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkcs1=
1=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkcs11=2Ec</span>=
<br><span>@@ -137,7 +137,7 @@</span><br><span> static char softhsm2_conf_pa=
th[] =3D &quot;softhsm2_conf_XXXXXX&quot;;</span><br><span> int num_certs;<=
/span><br><span> static const char *pkcs11_id_current;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-struct env_set *es;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct env_set *test_set;</span><br><span=
> </span><br><span> /* Fill-in certs[] array */</span><br><span> void</span=
><br><span>@@ -218,15 +218,15 @@</span><br><span> </span><br><span>     /* =
environment */</span><br><span>     setenv(&quot;SOFTHSM2_CONF&quot;, softh=
sm2_conf_path, 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 es =3D env_set_create(NULL);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    setenv_str(es, &quot;SOFTHSM2_CONF&quot;, softhsm2_conf_path);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_str(es, &qu=
ot;GNUTLS_PIN&quot;, PIN);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    test_set =3D env_set_create(NULL);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    setenv_str(test_set, &quot;SOFTHSM2_CONF&quot=
;, softhsm2_conf_path);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    setenv_str(test_set, &quot;GNUTLS_PIN&quot;, PIN);</span><br><span>=
 </span><br><span>     /* init the token using the temporary location as st=
orage */</span><br><span>     struct argv a =3D argv_new();</span><br><span=
>     argv_printf(&amp;a, &quot;%s --init-token --free --label \&quot;%s\&q=
uot; --so-pin %s --pin %s&quot;,</span><br><span>                 SOFTHSM2_=
UTIL_PATH, token_name, PIN, PIN);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    assert_true(openvpn_execve_check(&amp;a, es, 0, &quot;Faile=
d to initialize token&quot;));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(openvpn_execve_check(&amp;a, test_set, 0, &quot;=
Failed to initialize token&quot;));</span><br><span> </span><br><span>     =
/* Import certificates and keys in our test database into the token */</spa=
n><br><span>     char cert[] =3D &quot;cert_XXXXXX&quot;;</span><br><span>@=
@ -263,14 +263,14 @@</span><br><span>         argv_printf(</span><br><span>=
             &amp;a, &quot;%s --provider %s --load-certificate %s --label \=
&quot;%s\&quot; --id %08x --login --write&quot;,</span><br><span>          =
   P11TOOL_PATH, SOFTHSM2_MODULE_PATH, cert, c-&gt;friendly_name, num_certs=
 + 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        assert_=
true(openvpn_execve_check(&amp;a, es, 0, &quot;Failed to upload certificate=
 into token&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        assert_true(openvpn_execve_check(&amp;a, test_set, 0, &quot;Failed=
 to upload certificate into token&quot;));</span><br><span> </span><br><spa=
n>         argv_free(&amp;a);</span><br><span>         a =3D argv_new();</s=
pan><br><span>         argv_printf(&amp;a,</span><br><span>                =
     &quot;%s --provider %s --load-privkey %s --label \&quot;%s\&quot; --id=
 %08x --login --write&quot;,</span><br><span>                     P11TOOL_P=
ATH, SOFTHSM2_MODULE_PATH, key, c-&gt;friendly_name, num_certs + 1);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        assert_true(openvpn_=
execve_check(&amp;a, es, 0, &quot;Failed to upload key into token&quot;));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(=
openvpn_execve_check(&amp;a, test_set, 0, &quot;Failed to upload key into t=
oken&quot;));</span><br><span> </span><br><span>         assert_int_equal(f=
truncate(cert_fd, 0), 0);</span><br><span>         assert_int_equal(ftrunca=
te(key_fd, 0), 0);</span><br><span>@@ -294,7 +294,7 @@</span><br><span>    =
 struct argv a =3D argv_new();</span><br><span> </span><br><span>     argv_=
printf(&amp;a, &quot;%s --delete-token --token \&quot;%s\&quot;&quot;, SOFT=
HSM2_UTIL_PATH, token_name);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    assert_true(openvpn_execve_check(&amp;a, es, 0, &quot;Failed to =
delete token&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(openvpn_execve_check(&amp;a, test_set, 0, &quot;Failed to=
 delete token&quot;));</span><br><span>     argv_free(&amp;a);</span><br><s=
pan> </span><br><span>     rmdir(softhsm2_tokens_path); /* this must be emp=
ty after delete token */</span><br><span>@@ -304,7 +304,7 @@</span><br><spa=
n>         free(c-&gt;p11_id);</span><br><span>         c-&gt;p11_id =3D NU=
LL;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    env_set_destroy(es);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    env_set_destroy(test_set);</span><br><span>     return 0;</sp=
an><br><span> }</span><br><span> </span><br><span>diff --git a/tests/unit_t=
ests/openvpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/test_o=
penvpnserv=2Ec</span><br><span>index e01b0e3=2E=2E4ca715b 100644</span><br>=
<span>--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><sp=
an>+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>=
@@ -35,7 +35,7 @@</span><br><span> #include &quot;interactive=2Ec&quot;</sp=
an><br><span> </span><br><span> BOOL</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_S=
TATUS *status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Repor=
tStatusToSCMgr(SERVICE_STATUS_HANDLE svc_handle, SERVICE_STATUS *svc_status=
)</span><br><span> {</span><br><span>     return TRUE;</span><br><span> }</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail">change 1912</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0ac934da5eeed0424=
b54ed9b528a2bf2b561ffdf </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1912 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--+PynDzby130=--


--===============6018338093599961975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6018338093599961975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6018338093599961975==--

