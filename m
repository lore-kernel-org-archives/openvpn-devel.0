Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED40CC88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1tgmP0e/UYfKM5ki3P/Nq/FECjTpSvud7GUxKaWlvDo=; b=DaxeGfK+XHGRjRElMONI/7N9Tu
	o0Ux+tUwUAhTi3O103Adk7bJHA2G/vd4jekx1tmKFwOZHuuOiwSKv6qz7RIvTds/78lAN+99cl5CO
	p7kFK4zkXrvM4hcu4vL/YaetVRjhce+1aSiNuNfsORqDPXlpjD5PozlTgeKKfvhQoQ4Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x516c-0003ZC-8n;
	Fri, 11 Sep 2026 13:15:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x516b-0003Z5-41
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:15:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SC2SK6HRaFP5pq4mqKOTm8zJyB0TybV5LR5vLCSyZBE=; b=VW6X0h1v/GDy0n1sHYxw1axhjZ
 lyq26w03EWxXFX9Uhbl6OIQ3fWDYeKBdJDpz7w1uklxK1OMLCTg378ArgSNYKFhZR71GARz0chr5S
 zwSxRinwaPsyVQMc4Eu4/5Aa6q59zP0IX+L7Rqcs2hjgX5XwT7NG3fR6xDJdG8gcTp7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SC2SK6HRaFP5pq4mqKOTm8zJyB0TybV5LR5vLCSyZBE=; b=a
 co3qmSyDDx/hsSGXJyOeQHc3P45wWwyfzQP3eiSTyPkkzcFHx6QEu9G0V7eBKei14r/MoDJJIDGLg
 4tQkdSMBp7Zhh93mZIUhK7D+ClKTrpuXNIH1Hqy7Pr1rvV5N+Cu9rEy1TLYeSs58aiZGUyVvrmmPf
 tBOJ8di/VnXQmB1Y=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x516Y-0003Rp-LW for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:15:49 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4843e9c5960so831619f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789132540; x=1789737340; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SC2SK6HRaFP5pq4mqKOTm8zJyB0TybV5LR5vLCSyZBE=;
 b=ZYjGhOhuu0QklIbDJbjvJAbFtK1eft9eHie9pOFSYZn5FhxIocptjz/21+CTniVYJX
 302Ye+XVu0ybV315KwjSd1cJOrJZsxznzV6Jvis0cZqjwTcS4vjYcjFREw3zhrglBI5k
 gQ/UuiQA8JIrSVcSF9PDyX6VlYyAnF9h7tZlieI24W9YlTcAxn4VVEtuYhTbAIYn/She
 N5N1vCgwg9X0qoMLZ2wBy0fVqJ0FOHz+Q3Tb7AK0ZfyWNf1sgSs1J1m4O42ki1vGUo04
 1XWUXFT7JcFMQIwWmltjTuy7W7ST8O5XQUKSsFAHKH93HaMH9tohAHruEFxDzmUpqC8U
 iHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789132540; x=1789737340;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SC2SK6HRaFP5pq4mqKOTm8zJyB0TybV5LR5vLCSyZBE=;
 b=arvOu91NQWnv05V0JmFCxUm/y/O5JGa1sdQSSIT51kZ3NJTAn91Ei1tnJgCwiumrei
 yrmtwPFi2dNTJwaIXKBR59bvFvDWsZ8M6khLiPTY4tqa0ldBNTVK8XJzq373g4OoBIDR
 kSLCxj/pAEf/Ij29NtCfiuS/M8IwfxwW0evzVEB2bgxR8kDdIuUN41BbnFqcW4lI5ew0
 votf3r8lLKhpZDfaw2aJwRp1lVheCxAGkMkvYSiptuNOEhwbyYny0yfLj45RDi7dbHPx
 krzXA7sMFH5Ls+zislemgtxKI0oni5lAVTJYkvH05sKioI2I0g51a1W1I6mi2qwDMzIP
 Z5HA==
X-Gm-Message-State: AFuF++mcP7WgCVITW69qa8LyKGHqTqGF+BsJd/59REqQlpzKOiVw1DZZ
 eMC1ZU+NYd88thzG4Yo5kQJ9MBAT5FRs8VO88M+nv3GQDaw9ty2FESH7hT/4vZyYwR3gP0VZP+6
 l+DfOOnn50yr/Ferd3a37hnhWCJK8WVca5it6bmzUvnHQTa9hnpie0InJ3MCOA7FM7FSX
X-Gm-Gg: AYBFou2c8Nya4EOWVNDtcbqXqlkAG1JAGtuVIo+8xdLCqeATYfR7OMhx564d7pjxlg7
 v+MET0VuNYqSrh22WcnbRBgR75Cjmyh3tmRyIoqR+g8uACSsZLm3tWU/ZUwRXep2j1Aob/us+3F
 uRC2E7k7ERwrXwXKYFyRE036T1+Cqd0WXZZj2JcKPylv2AVGkRxZB2b8xJhHobpvlchCKs8kjsF
 apJHGisYUXzQogPGqey1IhVZWYRKaHC47xqKKYU5RdgvGZu8Cy7c1NL141+ic3PV1pWuMhZV63N
 5yH0l97m1UJ2bsXHROZhtkuy624emhtl14/kUwof3vID2Y8QwayW2K9kjGEsKBiaShWBSLMxcKz
 q0L7chJx+X3I7lRxK2WayIBhgNah0LTbPQ3QeKMQNxV/fBNp+KGgqlyVOEhSS4WpDy+vj4gzadF
 Cy5bifiKGnZy6LCWpJV1u1zKfqEqyT5nLlP9S9vFYiGr1CSbrhPLghcPm+Sr7nr9tPfw8iJC3gh
 hZEpyN5KbjBTlqaKCtnpHuFvIc2F2LvVIxP+Qc7r221M9QJRYQrKhnxIVtDaEhe0UY42aJBcwMn
 cMowrB3b82kP8AtuaRBplJwFI9F0iv1xnmkn8WgpSKObBtZKBQp7RtpH9a0NOQ==
X-Received: by 2002:a5d:5188:0:b0:485:8c16:5ef3 with SMTP id
 ffacd0b85a97d-486eb308c81mr3491319f8f.45.1789132539711; 
 Fri, 11 Sep 2026 06:15:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee5csm6047851f8f.20.2026.09.11.06.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 06:15:39 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 13:15:34 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf
X-Gerrit-Change-Number: 1912
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1912?usp=email>
X-Gerrit-Commit: c674d3c37f1d589451feb45c760b2b63f4bae94a
In-Reply-To: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
References: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTI3MzY3MDAwLkkwYWM5MzRkYTVlZWVkMDQyNGI1NGVkOWI1MjhhMmJmMmI1NjFmZmRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b8606d63ac20b6e9405048e9f8cd733afd93b5d3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x516Y-0003Rp-LW
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6009215305978505109=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6009215305978505109==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7ly5jtaI7Wk="; charset=UTF-8

--7ly5jtaI7Wk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1912?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: Fix various function parameters shadowing other symbols
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix various f=
unction parameters shadowing other symbols

Updated to a newer version of c=
ppcheck (2=2E21=2E0) and it
reported a new group of issues where function p=
arameters
shadow global variables or function names=2E

Used a variety of d=
ifferent solutions depending on context,
either renaming the global variabl=
es, the function parameters=2E

In one case I removed the parameter since i=
t only cointained
the global variable anyway=2E

Where applicable I have co=
mbined the change with fixing
occurrences of constParameterPointer to reduc=
e conflicts
between different cppcheck fix commits=2E

Change-Id: I0ac934da=
5eeed0424b54ed9b528a2bf2b561ffdf
Signed-off-by: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
---
M src/openvpn/gremlin=2Ec
M src/openvpn/manage=2Ec
M s=
rc/openvpn/manage=2Eh
M src/openvpn/options_string=2Ec
M src/openvpn/proxy=
=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_verify_backend=2Eh
M src/openv=
pn/ssl_verify_mbedtls=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
M src/openvp=
nserv/interactive=2Ec
M src/openvpnserv/validate=2Ec
M tests/unit_tests/ope=
nvpn/test_pkcs11=2Ec
M tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
13=
 files changed, 66 insertions(+), 65 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/12/1912/2

diff --git a/src/ope=
nvpn/gremlin=2Ec b/src/openvpn/gremlin=2Ec
index 0bd9396=2E=2Ea3efc78 10064=
4
--- a/src/openvpn/gremlin=2Ec
+++ b/src/openvpn/gremlin=2Ec
@@ -112,9 +11=
2,9 @@
     return ret;
 }
 
-static bool initialized; /* GLOBAL */
-static=
 bool up;          /* GLOBAL */
-static time_t next;      /* GLOBAL */
+sta=
tic bool gremlin_initialized; /* GLOBAL */
+static bool gremlin_up;        =
  /* GLOBAL */
+static time_t gremlin_next;      /* GLOBAL */
 
 /*
  * Ret=
urn false if we should drop a packet=2E
@@ -125,54 +125,54 @@
     const in=
t up_down_level =3D GREMLIN_UP_DOWN_LEVEL(flags);
     const int drop_level=
 =3D GREMLIN_DROP_LEVEL(flags);
 
-    if (!initialized)
+    if (!gremlin_=
initialized)
     {
-        initialized =3D true;
+        gremlin_initial=
ized =3D true;
 
         if (up_down_level)
         {
-            up =3D=
 false;
+            gremlin_up =3D false;
         }
         else
       =
  {
-            up =3D true;
+            gremlin_up =3D true;
         }
=
 
-        next =3D now;
+        gremlin_next =3D now;
     }
 
     if (u=
p_down_level) /* change up/down state? */
     {
-        if (now >=3D next=
)
+        if (now >=3D gremlin_next)
         {
             int delta;
- =
           if (up)
+            if (gremlin_up)
             {
            =
     delta =3D roll(down_low[up_down_level - 1], down_high[up_down_level - =
1]);
-                up =3D false;
+                gremlin_up =3D false;
=
             }
             else
             {
                 delta =3D =
roll(up_low[up_down_level - 1], up_high[up_down_level - 1]);
-             =
   up =3D true;
+                gremlin_up =3D true;
             }
 
-   =
         msg(D_GREMLIN, "GREMLIN: CONNECTION GOING %s FOR %d SECONDS", (up =
? "UP" : "DOWN"),
+            msg(D_GREMLIN, "GREMLIN: CONNECTION GOING %s=
 FOR %d SECONDS", (gremlin_up ? "UP" : "DOWN"),
                 delta);
- =
           next =3D now + delta;
+            gremlin_next =3D now + delta;=

         }
     }
 
     if (drop_level)
     {
-        if (up && flip(dr=
op_freq[drop_level - 1]))
+        if (gremlin_up && flip(drop_freq[drop_le=
vel - 1]))
         {
             dmsg(D_GREMLIN_VERBOSE, "GREMLIN: Random=
 packet drop");
             return false;
         }
     }
 
-    return =
up;
+    return gremlin_up;
 }
 
 /*
diff --git a/src/openvpn/manage=2Ec b/=
src/openvpn/manage=2Ec
index d57339d=2E=2E0751a19 100644
--- a/src/openvpn/=
manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3062,7 +3062,7 @@
 }
 
 void
-m=
anagement_notify_client_needing_auth(struct management *management, const u=
nsigned int mda_key_id,
+management_notify_client_needing_auth(struct manag=
ement *man, const unsigned int mda_key_id,
                                =
       struct man_def_auth_context *mdac, const struct env_set *es)
 {
    =
 if (!(mdac->flags & DAF_CONNECTION_CLOSED))
@@ -3073,12 +3073,12 @@
      =
       mode =3D "REAUTH";
         }
         msg(M_CLIENT, ">CLIENT:%s,%lu=
,%u", mode, mdac->cid, mda_key_id);
-        man_output_extra_env(managemen=
t, "CLIENT");
-        if (management->connection=2Eenv_filter_level > 0)
+=
        man_output_extra_env(man, "CLIENT");
+        if (man->connection=
=2Eenv_filter_level > 0)
         {
-            man_output_peer_info_env(m=
anagement, mdac);
+            man_output_peer_info_env(man, mdac);
       =
  }
-        man_output_env(es, true, management->connection=2Eenv_filter_l=
evel, "CLIENT");
+        man_output_env(es, true, man->connection=2Eenv_fi=
lter_level, "CLIENT");
         mdac->flags |=3D DAF_INITIAL_AUTH;
     }
 =
}
@@ -3104,23 +3104,24 @@
 }
 
 void
-management_connection_established(str=
uct management *management, struct man_def_auth_context *mdac,
+management_=
connection_established(struct management *man, struct man_def_auth_context =
*mdac,
                                   const struct env_set *es)
 {
    =
 mdac->flags |=3D DAF_CONNECTION_ESTABLISHED;
     msg(M_CLIENT, ">CLIENT:E=
STABLISHED,%lu", mdac->cid);
-    man_output_extra_env(management, "CLIENT"=
);
+    man_output_extra_env(man, "CLIENT");
     man_output_env(es, true, =
management->connection=2Eenv_filter_level, "CLIENT");
 }
 
 void
-managemen=
t_notify_client_close(struct management *management, struct man_def_auth_co=
ntext *mdac,
+management_notify_client_close(const struct management *man,
=
+                               struct man_def_auth_context *mdac,
        =
                        const struct env_set *es)
 {
     if ((mdac->flags =
& DAF_INITIAL_AUTH) && !(mdac->flags & DAF_CONNECTION_CLOSED))
     {
     =
    msg(M_CLIENT, ">CLIENT:DISCONNECT,%lu", mdac->cid);
-        man_output=
_env(es, true, management->connection=2Eenv_filter_level, "CLIENT");
+     =
   man_output_env(es, true, man->connection=2Eenv_filter_level, "CLIENT");
=
         mdac->flags |=3D DAF_CONNECTION_CLOSED;
     }
 }
@@ -3980,12 +398=
1,12 @@
  */
 
 struct command_line *
-command_line_new(const size_t buf_le=
n)
+command_line_new(const size_t len)
 {
     struct command_line *cl;
   =
  ALLOC_OBJ_CLEAR(cl, struct command_line);
-    cl->buf =3D alloc_buf(buf_=
len);
-    cl->residual =3D alloc_buf(buf_len);
+    cl->buf =3D alloc_buf(=
len);
+    cl->residual =3D alloc_buf(len);
     return cl;
 }
 
diff --git=
 a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 3ab937c=2E=2E1e785=
5d 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -389=
,15 +389,15 @@
 
 void management_notify_generic(const char *str);
 
-void =
management_notify_client_needing_auth(struct management *management,
+void =
management_notify_client_needing_auth(struct management *man,
             =
                               const unsigned int auth_id,
                =
                            struct man_def_auth_context *mdac,
            =
                                const struct env_set *es);
 
-void manageme=
nt_connection_established(struct management *management,
+void management_c=
onnection_established(struct management *man,
                             =
           struct man_def_auth_context *mdac, const struct env_set *es);
 
=
-void management_notify_client_close(struct management *management,
+void m=
anagement_notify_client_close(const struct management *man,
               =
                      struct man_def_auth_context *mdac, const struct env_s=
et *es);
 
 void management_learn_addr(struct man_def_auth_context *mdac,
d=
iff --git a/src/openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec=

index d3b29b8=2E=2E88ab798 100644
--- a/src/openvpn/options_string=2Ec
+++=
 b/src/openvpn/options_string=2Ec
@@ -396,12 +396,12 @@
 #endif
 
 char *
-=
options_string_extract_option(const char *options_string, const char *opt_n=
ame, struct gc_arena *gc)
+options_string_extract_option(const char *option=
_string, const char *opt_name, struct gc_arena *gc)
 {
     char *ret =3D N=
ULL;
     const size_t opt_name_len =3D strlen(opt_name);
 
-    const char=
 *p =3D options_string;
+    const char *p =3D option_string;
     while (p=
)
     {
         if (0 =3D=3D strncmp(p, opt_name, opt_name_len) && strlen=
(p) > (opt_name_len + 1)
diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/p=
roxy=2Ec
index e0700aa=2E=2E74a6cf9 100644
--- a/src/openvpn/proxy=2Ec
+++ =
b/src/openvpn/proxy=2Ec
@@ -184,10 +184,10 @@
 }
 
 bool
-proxy_send(socket=
_descriptor_t sd, const void *buf, size_t buf_len)
+proxy_send(socket_descr=
iptor_t sd, const void *buf, size_t len)
 {
-    const ssize_t size =3D ope=
nvpn_send(sd, buf, buf_len, MSG_NOSIGNAL);
-    if (size !=3D (ssize_t)buf_=
len)
+    const ssize_t size =3D openvpn_send(sd, buf, len, MSG_NOSIGNAL);
=
+    if (size !=3D (ssize_t)len)
     {
         msg(D_LINK_ERRORS | M_ERRN=
O, "proxy_send: TCP port write failed on send()");
         return false;
d=
iff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 48508e5=2E=2E76=
150d4 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1360,7=
 +1360,7 @@
 
 static void
 init_epoch_keys(struct key_state *ks, struct tl=
s_multi *multi, const struct key_type *key_type,
-                bool serv=
er, struct key2 *key2)
+                bool server, const struct key2 *key=
2)
 {
     /* For now we hardcode this to be 4 for the software based data =
channel
      * DCO based implementations/HW implementation might adjust th=
is number
@@ -1403,14 +1403,14 @@
 
 static void
 init_key_contexts(struct =
key_state *ks, struct tls_multi *multi, const struct key_type *key_type,
- =
                 bool server, struct key2 *key2, bool dco_enabled)
+       =
           bool server, const struct key2 *key2, bool dco)
 {
     struct k=
ey_ctx_bi *key =3D &ks->crypto_options=2Ekey_ctx_bi;
 
     /* Initialize k=
ey contexts */
     int key_direction =3D server ? KEY_DIRECTION_INVERSE : =
KEY_DIRECTION_NORMAL;
 
-    if (dco_enabled)
+    if (dco)
     {
        =
 if (key->encrypt=2Ehmac)
         {
diff --git a/src/openvpn/ssl_verify_ba=
ckend=2Eh b/src/openvpn/ssl_verify_backend=2Eh
index 9272cae=2E=2E46720d6 1=
00644
--- a/src/openvpn/ssl_verify_backend=2Eh
+++ b/src/openvpn/ssl_verify=
_backend=2Eh
@@ -220,14 +220,14 @@
  * Check X=2E509 Netscape certificate t=
ype field, if available=2E
  *
  * @param cert          Certificate to chec=
k=2E
- * @param usage         One of \c NS_CERT_CHECK_CLIENT, \c NS_CERT_CH=
ECK_SERVER,
+ * @param cert_type     One of \c NS_CERT_CHECK_CLIENT, \c NS_=
CERT_CHECK_SERVER,
  *                      or \c NS_CERT_CHECK_NONE=2E
  *=

  * @return              \c SUCCESS if NS_CERT_CHECK_NONE or if the certif=
icate has
  *                      the expected bit set=2E \c FAILURE if th=
e certificate does
  *                      not have NS cert type verificat=
ion or the wrong bit set=2E
  */
-result_t x509_verify_ns_cert_type(openvpn=
_x509_cert_t *cert, const int usage);
+result_t x509_verify_ns_cert_type(op=
envpn_x509_cert_t *cert, const int cert_type);
 
 /*
  * Verify X=2E509 key=
 usage extension field=2E
diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b=
/src/openvpn/ssl_verify_mbedtls=2Ec
index 9f676ed=2E=2Ec4bae40 100644
--- a=
/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=2E=
c
@@ -753,9 +753,9 @@
 /* Dummy function because Netscape certificate types=
 are not supported in OpenVPN with mbedtls=2E
  * Returns SUCCESS if usage =
is NS_CERT_CHECK_NONE, FAILURE otherwise=2E */
 result_t
-x509_verify_ns_ce=
rt_type(mbedtls_x509_crt *cert, const int usage)
+x509_verify_ns_cert_type(=
mbedtls_x509_crt *cert, const int cert_type)
 {
-    if (usage =3D=3D NS_CE=
RT_CHECK_NONE)
+    if (cert_type =3D=3D NS_CERT_CHECK_NONE)
     {
       =
  return SUCCESS;
     }
diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/=
src/openvpn/ssl_verify_openssl=2Ec
index a6307f6=2E=2E6073e4e 100644
--- a/=
src/openvpn/ssl_verify_openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec=

@@ -629,13 +629,13 @@
 }
 
 result_t
-x509_verify_ns_cert_type(openvpn_x50=
9_cert_t *peer_cert, const int usage)
+x509_verify_ns_cert_type(openvpn_x50=
9_cert_t *peer_cert, const int cert_type)
 {
-    if (usage =3D=3D NS_CERT_=
CHECK_NONE)
+    if (cert_type =3D=3D NS_CERT_CHECK_NONE)
     {
         r=
eturn SUCCESS;
     }
-    if (usage =3D=3D NS_CERT_CHECK_CLIENT)
+    if (=
cert_type =3D=3D NS_CERT_CHECK_CLIENT)
     {
         /*
          * Unfor=
tunately, X509_check_purpose() before OpenSSL 4=2E0 does some weird thing t=
hat
@@ -668,7 +668,7 @@
         }
         return result;
     }
-    if (=
usage =3D=3D NS_CERT_CHECK_SERVER)
+    if (cert_type =3D=3D NS_CERT_CHECK_=
SERVER)
     {
         /*
          * Unfortunately, X509_check_purpose() =
before OpenSSL 4=2E0 does some weird thing that
diff --git a/src/openvpnser=
v/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index d2288b9=2E=2E7819=
f5a 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/inte=
ractive=2Ec
@@ -3848,8 +3848,8 @@
 
 
 static DWORD
-UpdateWaitHandles(LPHA=
NDLE *handles_ptr, LPDWORD count, HANDLE io_event, HANDLE exit_event,
-    =
              list_item_t *threads)
+UpdateWaitHandles(LPHANDLE *handles_pt=
r, LPDWORD count, HANDLE io_event,
+                  const list_item_t *th=
reads)
 {
     static DWORD size =3D 10;
     static LPHANDLE handles =3D N=
ULL;
@@ -3998,7 +3998,7 @@
         goto out;
     }
 
-    error =3D Updat=
eWaitHandles(&handles, &handle_count, io_event, exit_event, threads);
+    =
error =3D UpdateWaitHandles(&handles, &handle_count, io_event, threads);
  =
   if (error !=3D NO_ERROR)
     {
         goto out;
@@ -4065,7 +4065,7 @@=

                 if (!error)
                 {
                     error=
 =3D
-                        UpdateWaitHandles(&handles, &handle_count, io=
_event, exit_event, threads);
+                        UpdateWaitHandles(&h=
andles, &handle_count, io_event, threads);
                 }
             =
    if (error)
                 {
@@ -4073,7 +4073,7 @@
                   =
              &exit_event);
                     /* Update wait handles aga=
in after removing the last worker thread */
                     RemoveList=
Item(&threads, CmpHandle, thread);
-                    UpdateWaitHandles(&=
handles, &handle_count, io_event, exit_event, threads);
+                  =
  UpdateWaitHandles(&handles, &handle_count, io_event, threads);
          =
           TerminateThread(thread, 1);
                     CloseHandleEx(&=
thread);
                     CloseHandleEx(&pipe);
@@ -4113,7 +4113,7 @@
 =

             /* Worker thread ended */
             HANDLE thread =3D Remo=
veListItem(&threads, CmpHandle, handles[error]);
-            UpdateWaitHan=
dles(&handles, &handle_count, io_event, exit_event, threads);
+            =
UpdateWaitHandles(&handles, &handle_count, io_event, threads);
            =
 CloseHandleEx(&thread);
         }
     }
diff --git a/src/openvpnserv/val=
idate=2Ec b/src/openvpnserv/validate=2Ec
index 8e529b9=2E=2E6a13a06 100644
=
--- a/src/openvpnserv/validate=2Ec
+++ b/src/openvpnserv/validate=2Ec
@@ -2=
7,7 +27,7 @@
 #include <pathcch=2Eh>
 #include <lm=2Eh>
 
-static const WCH=
AR *white_list[] =3D {
+static const WCHAR *global_white_list[] =3D {
     =
L"auth-retry",
     L"config",
     L"log",
@@ -335,7 +335,7 @@
     }
 
  =
   /* option name starts at 2 characters from argv[i] */
-    if (OptionLoo=
kup(argv[0] + 2, white_list) =3D=3D -1) /* not found */
+    if (OptionLook=
up(argv[0] + 2, global_white_list) =3D=3D -1) /* not found */
     {
      =
   return FALSE;
     }
diff --git a/tests/unit_tests/openvpn/test_pkcs11=
=2Ec b/tests/unit_tests/openvpn/test_pkcs11=2Ec
index 042bd8b=2E=2Ea54c504 =
100644
--- a/tests/unit_tests/openvpn/test_pkcs11=2Ec
+++ b/tests/unit_test=
s/openvpn/test_pkcs11=2Ec
@@ -137,7 +137,7 @@
 static char softhsm2_conf_pa=
th[] =3D "softhsm2_conf_XXXXXX";
 int num_certs;
 static const char *pkcs11=
_id_current;
-struct env_set *es;
+struct env_set *test_set;
 
 /* Fill-in =
certs[] array */
 void
@@ -218,15 +218,15 @@
 
     /* environment */
     =
setenv("SOFTHSM2_CONF", softhsm2_conf_path, 1);
-    es =3D env_set_create(=
NULL);
-    setenv_str(es, "SOFTHSM2_CONF", softhsm2_conf_path);
-    seten=
v_str(es, "GNUTLS_PIN", PIN);
+    test_set =3D env_set_create(NULL);
+    =
setenv_str(test_set, "SOFTHSM2_CONF", softhsm2_conf_path);
+    setenv_str(=
test_set, "GNUTLS_PIN", PIN);
 
     /* init the token using the temporary =
location as storage */
     struct argv a =3D argv_new();
     argv_printf(=
&a, "%s --init-token --free --label \"%s\" --so-pin %s --pin %s",
         =
        SOFTHSM2_UTIL_PATH, token_name, PIN, PIN);
-    assert_true(openvpn=
_execve_check(&a, es, 0, "Failed to initialize token"));
+    assert_true(o=
penvpn_execve_check(&a, test_set, 0, "Failed to initialize token"));
 
    =
 /* Import certificates and keys in our test database into the token */
   =
  char cert[] =3D "cert_XXXXXX";
@@ -263,14 +263,14 @@
         argv_printf=
(
             &a, "%s --provider %s --load-certificate %s --label \"%s\" -=
-id %08x --login --write",
             P11TOOL_PATH, SOFTHSM2_MODULE_PATH,=
 cert, c->friendly_name, num_certs + 1);
-        assert_true(openvpn_execv=
e_check(&a, es, 0, "Failed to upload certificate into token"));
+        as=
sert_true(openvpn_execve_check(&a, test_set, 0, "Failed to upload certifica=
te into token"));
 
         argv_free(&a);
         a =3D argv_new();
    =
     argv_printf(&a,
                     "%s --provider %s --load-privkey =
%s --label \"%s\" --id %08x --login --write",
                     P11TOOL_=
PATH, SOFTHSM2_MODULE_PATH, key, c->friendly_name, num_certs + 1);
-       =
 assert_true(openvpn_execve_check(&a, es, 0, "Failed to upload key into tok=
en"));
+        assert_true(openvpn_execve_check(&a, test_set, 0, "Failed t=
o upload key into token"));
 
         assert_int_equal(ftruncate(cert_fd, =
0), 0);
         assert_int_equal(ftruncate(key_fd, 0), 0);
@@ -294,7 +294,=
7 @@
     struct argv a =3D argv_new();
 
     argv_printf(&a, "%s --delete=
-token --token \"%s\"", SOFTHSM2_UTIL_PATH, token_name);
-    assert_true(o=
penvpn_execve_check(&a, es, 0, "Failed to delete token"));
+    assert_true=
(openvpn_execve_check(&a, test_set, 0, "Failed to delete token"));
     arg=
v_free(&a);
 
     rmdir(softhsm2_tokens_path); /* this must be empty after=
 delete token */
@@ -304,7 +304,7 @@
         free(c->p11_id);
         c->=
p11_id =3D NULL;
     }
-    env_set_destroy(es);
+    env_set_destroy(test=
_set);
     return 0;
 }
 
diff --git a/tests/unit_tests/openvpnserv/test_o=
penvpnserv=2Ec b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
index e0=
1b0e3=2E=2E4ca715b 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnse=
rv=2Ec
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
@@ -35,7 +35=
,7 @@
 #include "interactive=2Ec"
 
 BOOL
-ReportStatusToSCMgr(SERVICE_STAT=
US_HANDLE service, SERVICE_STATUS *status)
+ReportStatusToSCMgr(SERVICE_STA=
TUS_HANDLE svc_handle, SERVICE_STATUS *svc_status)
 {
     return TRUE;
 }
=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0ac934da5eeed0=
424b54ed9b528a2bf2b561ffdf
Gerrit-Change-Number: 1912
Gerrit-PatchSet: 2
Ge=
rrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--7ly5jtaI7Wk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1912?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Fi=
x various function parameters shadowing other symbols<br><br>Updated to a n=
ewer version of cppcheck (2=2E21=2E0) and it<br>reported a new group of iss=
ues where function parameters<br>shadow global variables or function names=
=2E<br><br>Used a variety of different solutions depending on context,<br>e=
ither renaming the global variables, the function parameters=2E<br><br>In o=
ne case I removed the parameter since it only cointained<br>the global vari=
able anyway=2E<br><br>Where applicable I have combined the change with fixi=
ng<br>occurrences of constParameterPointer to reduce conflicts<br>between d=
ifferent cppcheck fix commits=2E<br><br>Change-Id: I0ac934da5eeed0424b54ed9=
b528a2bf2b561ffdf<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>---<br>M src/openvpn/gremlin=2Ec<br>M src/openvpn/manage=2Ec<=
br>M src/openvpn/manage=2Eh<br>M src/openvpn/options_string=2Ec<br>M src/op=
envpn/proxy=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_verify_backen=
d=2Eh<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>M src/openvpn/ssl_verify_o=
penssl=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M src/openvpnserv/valida=
te=2Ec<br>M tests/unit_tests/openvpn/test_pkcs11=2Ec<br>M tests/unit_tests/=
openvpnserv/test_openvpnserv=2Ec<br>13 files changed, 66 insertions(+), 65 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/12/1912/2</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/gr=
emlin=2Ec b/src/openvpn/gremlin=2Ec</span><br><span>index 0bd9396=2E=2Ea3ef=
c78 100644</span><br><span>--- a/src/openvpn/gremlin=2Ec</span><br><span>++=
+ b/src/openvpn/gremlin=2Ec</span><br><span>@@ -112,9 +112,9 @@</span><br><=
span>     return ret;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static bool initialized; /* GLOBAL */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool up;       =
   /* GLOBAL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 time_t next;      /* GLOBAL */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static bool gremlin_initialized; /* GLOBAL */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static bool gremlin_up;          /* G=
LOBAL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static time=
_t gremlin_next;      /* GLOBAL */</span><br><span> </span><br><span> /*</s=
pan><br><span>  * Return false if we should drop a packet=2E</span><br><spa=
n>@@ -125,54 +125,54 @@</span><br><span>     const int up_down_level =3D GR=
EMLIN_UP_DOWN_LEVEL(flags);</span><br><span>     const int drop_level =3D G=
REMLIN_DROP_LEVEL(flags);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!initialized)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!gremlin_initialized)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        initialized =
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
c b/src/openvpn/manage=2Ec</span><br><span>index d57339d=2E=2E0751a19 10064=
4</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/op=
envpn/manage=2Ec</span><br><span>@@ -3062,7 +3062,7 @@</span><br><span> }</=
span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-management_notify_client_needing_auth(struct management *m=
anagement, const unsigned int mda_key_id,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+management_notify_client_needing_auth(struct manageme=
nt *man, const unsigned int mda_key_id,</span><br><span>                   =
                    struct man_def_auth_context *mdac, const struct env_set=
 *es)</span><br><span> {</span><br><span>     if (!(mdac-&gt;flags &amp; DA=
F_CONNECTION_CLOSED))</span><br><span>@@ -3073,12 +3073,12 @@</span><br><sp=
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
<span>     }</span><br><span> }</span><br><span>@@ -3104,23 +3104,24 @@</sp=
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
lor: hsl(120, 100%, 40%);">+    man_output_extra_env(man, &quot;CLIENT&quot=
;);</span><br><span>     man_output_env(es, true, management-&gt;connection=
=2Eenv_filter_level, &quot;CLIENT&quot;);</span><br><span> }</span><br><spa=
n> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-management_notify_client_close(struct management *management, struct ma=
n_def_auth_context *mdac,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+management_notify_client_close(const struct management *man,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
   struct man_def_auth_context *mdac,</span><br><span>                     =
           const struct env_set *es)</span><br><span> {</span><br><span>   =
  if ((mdac-&gt;flags &amp; DAF_INITIAL_AUTH) &amp;&amp; !(mdac-&gt;flags &=
amp; DAF_CONNECTION_CLOSED))</span><br><span>     {</span><br><span>       =
  msg(M_CLIENT, &quot;&gt;CLIENT:DISCONNECT,%lu&quot;, mdac-&gt;cid);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        man_output_env(es, =
true, management-&gt;connection=2Eenv_filter_level, &quot;CLIENT&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        man_output_env=
(es, true, man-&gt;connection=2Eenv_filter_level, &quot;CLIENT&quot;);</spa=
n><br><span>         mdac-&gt;flags |=3D DAF_CONNECTION_CLOSED;</span><br><=
span>     }</span><br><span> }</span><br><span>@@ -3980,12 +3981,12 @@</spa=
n><br><span>  */</span><br><span> </span><br><span> struct command_line *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-command_line_new(const =
size_t buf_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+comm=
and_line_new(const size_t len)</span><br><span> {</span><br><span>     stru=
ct command_line *cl;</span><br><span>     ALLOC_OBJ_CLEAR(cl, struct comman=
d_line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cl-&gt;bu=
f =3D alloc_buf(buf_len);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    cl-&gt;residual =3D alloc_buf(buf_len);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    cl-&gt;buf =3D alloc_buf(len);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    cl-&gt;residual =3D alloc_bu=
f(len);</span><br><span>     return cl;</span><br><span> }</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=
=2Eh</span><br><span>index 3ab937c=2E=2E1e7855d 100644</span><br><span>--- =
a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span=
><br><span>@@ -389,15 +389,15 @@</span><br><span> </span><br><span> void ma=
nagement_notify_generic(const char *str);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void management_notify_client_needing=
_auth(struct management *management,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void management_notify_client_needing_auth(struct manageme=
nt *man,</span><br><span>                                            const =
unsigned int auth_id,</span><br><span>                                     =
       struct man_def_auth_context *mdac,</span><br><span>                 =
                           const struct env_set *es);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void management_connectio=
n_established(struct management *management,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void management_connection_established(struct mana=
gement *man,</span><br><span>                                        struct=
 man_def_auth_context *mdac, const struct env_set *es);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-void management_notify_=
client_close(struct management *management,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void management_notify_client_close(const struct ma=
nagement *man,</span><br><span>                                     struct =
man_def_auth_context *mdac, const struct env_set *es);</span><br><span> </s=
pan><br><span> void management_learn_addr(struct man_def_auth_context *mdac=
,</span><br><span>diff --git a/src/openvpn/options_string=2Ec b/src/openvpn=
/options_string=2Ec</span><br><span>index d3b29b8=2E=2E88ab798 100644</span=
><br><span>--- a/src/openvpn/options_string=2Ec</span><br><span>+++ b/src/o=
penvpn/options_string=2Ec</span><br><span>@@ -396,12 +396,12 @@</span><br><=
span> #endif</span><br><span> </span><br><span> char *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-options_string_extract_option(const char *=
options_string, const char *opt_name, struct gc_arena *gc)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+options_string_extract_option(const =
char *option_string, const char *opt_name, struct gc_arena *gc)</span><br><=
span> {</span><br><span>     char *ret =3D NULL;</span><br><span>     const=
 size_t opt_name_len =3D strlen(opt_name);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const char *p =3D options_string=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *p =
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
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--7ly5jtaI7Wk=--


--===============6009215305978505109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6009215305978505109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6009215305978505109==--

