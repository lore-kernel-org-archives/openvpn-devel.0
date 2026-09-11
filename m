Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83AEC88E5A
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 11:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=n8YHZ2nRWNed9ugb88cYq0ElkwK1E8i7LAVoy4GE3d8=; b=ifeiIGVba+/aDK
	oEsUthUKb3jsBc5VcG3J9wzhEW+XiPRdsZUo0i4IOBrHua6b8dT3+CFYW5lWAqENBlBFq5rDgcjSa
	9Wyu1+G643X1ITeFYX9jtQEPaIBnzlVitJvXGVXMurrRFU3MBHlrpFMiNtL7FdDILaxusJ6dMVFn+
	tRY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4zlq-0001nD-6H;
	Fri, 11 Sep 2026 11:50:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4zlR-0001lq-Fe
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 11:49:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NARV08fy51ZlMx1piLN2DM9NOX+97LJ7uWJI+nKvA/M=; b=R8A5+7XEzkyaNgRrnqq11H6B7u
 qN6GoGGbE/pBK5Usi8av5vANWnxWrB2nT+h+vNfIfLDXo1Puzla8JW7uZgRXw6zGkuet70bVrh8TX
 0y/qrXPlDuDMG6KQUZc5li7U2uSJSN+GsRKP1aFlwCZEWKq6mt+ZTh74/uB6NqCT9eIs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NARV08fy51ZlMx1piLN2DM9NOX+97LJ7uWJI+nKvA/M=; b=e
 HwVcA//4QFEMNN0AHiIa+lVp72ZUrcm1Ck6RgOf581UA0pr85JWSy8IjTnRNtwq3DzKrFTRYG7Sdj
 QMi5v2Dj0hqTMq7u3rTJOU2+48JnDTmJAnEPNHeLUiaTE0lfQSIliJvA3JZL4YxI1pRaYh/jbQH5e
 ZgeXLbfzLSsXR6dk=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4zlN-0001O5-6w for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 11:49:53 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so8194795e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 04:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789127383; x=1789732183; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NARV08fy51ZlMx1piLN2DM9NOX+97LJ7uWJI+nKvA/M=;
 b=Mbf8NX8NWJ6llIuyAaCzc4bKBjhdLjM7iS5FRQH90s7jH+96C1J9dRSGejRAP501nX
 B+4CQjn27kSA/ixt0nDwsnS/Lo0fPgCNkl9HO7fbJJhAjajLyYHZ45G2qfddnjExcvtu
 ftBze+oVxCtCrPIhyTIWiI1PXMOkJMTkY0bjKEdKuutRtNGiIH52CZp9917bv63aKXkk
 ejttjwCjHEaUCBy8BD9dQNs+AOPL5Gs92IbdzXjvHUQmiY7JcybsW97drBM3doFakw89
 pCI1PJgNyAJwgAn5kIyAYlyk+q0AzX2n8aq9LUaMeaquRzt5dXEXceEMynYbdcoQE/TI
 B6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789127383; x=1789732183;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NARV08fy51ZlMx1piLN2DM9NOX+97LJ7uWJI+nKvA/M=;
 b=dqws7Ana6viUT4w2C3EVNvwbwRMhrux4uslvV1U+Icv8XX5zTOn0n50QVS1xFk888+
 kZLqXwuREWWMdRuskgqpS0ga1qbqOBxpZbXLhingLDgK3MknsUOOFI0XtndnANTqXnPy
 +bTB8u9OvN5ijZRJddNQeYrWbWm3o49j/ESmHfRo7O8b9+rGItBcJJpO2X4daEDs2tI4
 J++IhFMIRJp1FLg+lO99g0dtm33I/f/Dz2ODSUTwjQs7EzUPn2qFff3e34H8QQRhOTnR
 2sIH4Qa2PNhlxV8U6Mt0B+GLCei/FCGuz04e7yDVOvKZzFKJ4tgZZ72U5mYeRgx9ADfr
 aDKQ==
X-Gm-Message-State: AFuF++lKb00eE+uVceAjoEUWMMmDqRBkwTeY52opZEn9k3OWr1YbTESZ
 JkLmuwOVFVnNDwdKvFJX3aWU0h8/Xmkdfn7kzfhY5FfevgxHqFS79wLJk8Zj6YOq1o8CV8PRG/X
 kgXymmGyFfMgvldQlvEF+cMMJKwMyzaPGy2AqQdOT7EKjm49R7gH2wFxzgP6V7SNNOvQJKSG7YW
 opDW9pCQ==
X-Gm-Gg: AYBFou2+EMWYNOHQsJmY3qJQgPma6aSyG2Bho6zPg5HTMI94j5mM5ycAFBcQz+y2q+m
 iEiXTDIWGcVrru8gX3EE8RPePcEPJ3Gz96rijm8w3DlceBuxHi7jEw/nZMRJX/oiar4TUnhJ8A2
 btXXU+iVwqtbD1mOjvrfZH7aZelcoUciO4kQMejpIixsdSjdFQvXBEZ9t8NAJl7uhO7oc0NcBR4
 o8h8VhZpP0809ck8DoXZ7ORLcV2ZOUWr8ooWJtWk9fOAe0htJG8zFD3rPYMJv8QeFLsDMlUmnTa
 y6xYsBCHFxjzHGJjrL+BO3xHGaF627CgfEiSa03Z+zzxLFfiSnrJMQK77SOcXH/9224Qz27+vis
 2kmSSFx43gXKoJOIQs2RuJGk/oF/NVEWIoki1ndedzKwrxcOyl2rUNCf2YtSUnwCDBvfF/8qL1L
 hRkY5sEyfpPE1rvE0AHrAOaW8LsoEG4r8DwORZWVvIONL3j7qEQLmX4lN26Mf0MdJw/pjr4uhTj
 pBjV0WuAvwX/8neJUXzce8rFmgAw5+7M77jT7LgJF6ofwg5j7x6sbKFDBv2labkSGFb2KMIcB9i
 iO81Ece3FJt/SDRmpZZD3Rvz5TVIaevb9myRqrZRTytUS6G1qn5LSVIf5W4BjA==
X-Received: by 2002:a05:600c:4fd2:b0:49d:16f1:94a5 with SMTP id
 5b1f17b1804b1-49e619efc21mr47700915e9.25.1789127382158; 
 Fri, 11 Sep 2026 04:49:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60946249sm81114755e9.0.2026.09.11.04.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 04:49:41 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 11:49:40 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf
X-Gerrit-Change-Number: 1912
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1912?usp=email>
X-Gerrit-Commit: 6ac81027afd97865c3c692a5dc8d8a87dd1486d5
References: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTI3MzY3MDAwLkkwYWM5MzRkYTVlZWVkMDQyNGI1NGVkOWI1MjhhMmJmMmI1NjFmZmRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <300366d3e17bc5566574dbe793b535822f33b7d9-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4zlN-0001O5-6w
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
Content-Type: multipart/mixed; boundary="===============0358313735961016908=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0358313735961016908==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2nBGAKd3/KI="; charset=UTF-8

--2nBGAKd3/KI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1912?usp=3Demail

to review the following change=2E


Chang=
e subject: Fix various function parameters shadowing other symbols
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix various functio=
n parameters shadowing other symbols

Updated to a newer version of cppchec=
k (2=2E21=2E0) and it
reported a new group of issues where function paramet=
ers
shadow global variables or function names=2E

Used a variety of differe=
nt solutions depending on context,
either renaming the global variables, th=
e function parameters=2E

In one case I removed the parameter since it only=
 cointained
the global variable anyway=2E

Where applicable I have combined=
 the change with fixing
occurrences of constParameterPointer to reduce conf=
licts
between different cppcheck fix commits=2E

Change-Id: I0ac934da5eeed0=
424b54ed9b528a2bf2b561ffdf
Signed-off-by: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
---
M src/openvpn/gremlin=2Ec
M src/openvpn/manage=2Ec
M src/ope=
nvpn/options_string=2Ec
M src/openvpn/proxy=2Ec
M src/openvpn/ssl=2Ec
M src=
/openvpn/ssl_verify_backend=2Eh
M src/openvpn/ssl_verify_mbedtls=2Ec
M src/=
openvpn/ssl_verify_openssl=2Ec
M src/openvpnserv/interactive=2Ec
M src/open=
vpnserv/validate=2Ec
M tests/unit_tests/openvpn/test_pkcs11=2Ec
M tests/uni=
t_tests/openvpnserv/test_openvpnserv=2Ec
12 files changed, 62 insertions(+)=
, 61 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/12/1912/1

diff --git a/src/openvpn/gremlin=2Ec b/src/openvpn/=
gremlin=2Ec
index 0bd9396=2E=2Ea3efc78 100644
--- a/src/openvpn/gremlin=2Ec=

+++ b/src/openvpn/gremlin=2Ec
@@ -112,9 +112,9 @@
     return ret;
 }
 
-s=
tatic bool initialized; /* GLOBAL */
-static bool up;          /* GLOBAL */=

-static time_t next;      /* GLOBAL */
+static bool gremlin_initialized; /=
* GLOBAL */
+static bool gremlin_up;          /* GLOBAL */
+static time_t g=
remlin_next;      /* GLOBAL */
 
 /*
  * Return false if we should drop a p=
acket=2E
@@ -125,54 +125,54 @@
     const int up_down_level =3D GREMLIN_UP_=
DOWN_LEVEL(flags);
     const int drop_level =3D GREMLIN_DROP_LEVEL(flags);=

 
-    if (!initialized)
+    if (!gremlin_initialized)
     {
-        in=
itialized =3D true;
+        gremlin_initialized =3D true;
 
         if (u=
p_down_level)
         {
-            up =3D false;
+            gremlin_up=
 =3D false;
         }
         else
         {
-            up =3D true;
+=
            gremlin_up =3D true;
         }
 
-        next =3D now;
+     =
   gremlin_next =3D now;
     }
 
     if (up_down_level) /* change up/down=
 state? */
     {
-        if (now >=3D next)
+        if (now >=3D gremlin=
_next)
         {
             int delta;
-            if (up)
+           =
 if (gremlin_up)
             {
                 delta =3D roll(down_low[up=
_down_level - 1], down_high[up_down_level - 1]);
-                up =3D fa=
lse;
+                gremlin_up =3D false;
             }
             els=
e
             {
                 delta =3D roll(up_low[up_down_level - 1],=
 up_high[up_down_level - 1]);
-                up =3D true;
+              =
  gremlin_up =3D true;
             }
 
-            msg(D_GREMLIN, "GREMLI=
N: CONNECTION GOING %s FOR %d SECONDS", (up ? "UP" : "DOWN"),
+            =
msg(D_GREMLIN, "GREMLIN: CONNECTION GOING %s FOR %d SECONDS", (gremlin_up ?=
 "UP" : "DOWN"),
                 delta);
-            next =3D now + delta=
;
+            gremlin_next =3D now + delta;
         }
     }
 
     if (d=
rop_level)
     {
-        if (up && flip(drop_freq[drop_level - 1]))
+    =
    if (gremlin_up && flip(drop_freq[drop_level - 1]))
         {
         =
    dmsg(D_GREMLIN_VERBOSE, "GREMLIN: Random packet drop");
             re=
turn false;
         }
     }
 
-    return up;
+    return gremlin_up;
 }
=
 
 /*
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 8e=
46470=2E=2Ee6f9574 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/ma=
nage=2Ec
@@ -3060,7 +3060,7 @@
 }
 
 void
-management_notify_client_needing=
_auth(struct management *management, const unsigned int mda_key_id,
+manage=
ment_notify_client_needing_auth(struct management *man, const unsigned int =
mda_key_id,
                                       struct man_def_auth_cont=
ext *mdac, const struct env_set *es)
 {
     if (!(mdac->flags & DAF_CONNEC=
TION_CLOSED))
@@ -3071,12 +3071,12 @@
             mode =3D "REAUTH";
     =
    }
         msg(M_CLIENT, ">CLIENT:%s,%lu,%u", mode, mdac->cid, mda_key_=
id);
-        man_output_extra_env(management, "CLIENT");
-        if (mana=
gement->connection=2Eenv_filter_level > 0)
+        man_output_extra_env(ma=
n, "CLIENT");
+        if (man->connection=2Eenv_filter_level > 0)
        =
 {
-            man_output_peer_info_env(management, mdac);
+            ma=
n_output_peer_info_env(man, mdac);
         }
-        man_output_env(es, t=
rue, management->connection=2Eenv_filter_level, "CLIENT");
+        man_out=
put_env(es, true, man->connection=2Eenv_filter_level, "CLIENT");
         m=
dac->flags |=3D DAF_INITIAL_AUTH;
     }
 }
@@ -3102,23 +3102,24 @@
 }
 
 v=
oid
-management_connection_established(struct management *management, struc=
t man_def_auth_context *mdac,
+management_connection_established(struct man=
agement *man, struct man_def_auth_context *mdac,
                          =
         const struct env_set *es)
 {
     mdac->flags |=3D DAF_CONNECTION_=
ESTABLISHED;
     msg(M_CLIENT, ">CLIENT:ESTABLISHED,%lu", mdac->cid);
-   =
 man_output_extra_env(management, "CLIENT");
+    man_output_extra_env(man,=
 "CLIENT");
     man_output_env(es, true, management->connection=2Eenv_filt=
er_level, "CLIENT");
 }
 
 void
-management_notify_client_close(struct mana=
gement *management, struct man_def_auth_context *mdac,
+management_notify_c=
lient_close(const struct management *man,
+                               s=
truct man_def_auth_context *mdac,
                                const str=
uct env_set *es)
 {
     if ((mdac->flags & DAF_INITIAL_AUTH) && !(mdac->fl=
ags & DAF_CONNECTION_CLOSED))
     {
         msg(M_CLIENT, ">CLIENT:DISCON=
NECT,%lu", mdac->cid);
-        man_output_env(es, true, management->connec=
tion=2Eenv_filter_level, "CLIENT");
+        man_output_env(es, true, man->=
connection=2Eenv_filter_level, "CLIENT");
         mdac->flags |=3D DAF_CON=
NECTION_CLOSED;
     }
 }
@@ -3978,12 +3979,12 @@
  */
 
 struct command_li=
ne *
-command_line_new(const size_t buf_len)
+command_line_new(const size_t=
 len)
 {
     struct command_line *cl;
     ALLOC_OBJ_CLEAR(cl, struct comm=
and_line);
-    cl->buf =3D alloc_buf(buf_len);
-    cl->residual =3D alloc=
_buf(buf_len);
+    cl->buf =3D alloc_buf(len);
+    cl->residual =3D alloc=
_buf(len);
     return cl;
 }
 
diff --git a/src/openvpn/options_string=2Ec=
 b/src/openvpn/options_string=2Ec
index d3b29b8=2E=2E88ab798 100644
--- a/s=
rc/openvpn/options_string=2Ec
+++ b/src/openvpn/options_string=2Ec
@@ -396,=
12 +396,12 @@
 #endif
 
 char *
-options_string_extract_option(const char *=
options_string, const char *opt_name, struct gc_arena *gc)
+options_string_=
extract_option(const char *option_string, const char *opt_name, struct gc_a=
rena *gc)
 {
     char *ret =3D NULL;
     const size_t opt_name_len =3D st=
rlen(opt_name);
 
-    const char *p =3D options_string;
+    const char *p=
 =3D option_string;
     while (p)
     {
         if (0 =3D=3D strncmp(p, =
opt_name, opt_name_len) && strlen(p) > (opt_name_len + 1)
diff --git a/src/=
openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index e0700aa=2E=2E74a6cf9 100644=

--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -184,10 +184,10=
 @@
 }
 
 bool
-proxy_send(socket_descriptor_t sd, const void *buf, size_t =
buf_len)
+proxy_send(socket_descriptor_t sd, const void *buf, size_t len)
 =
{
-    const ssize_t size =3D openvpn_send(sd, buf, buf_len, MSG_NOSIGNAL);=

-    if (size !=3D (ssize_t)buf_len)
+    const ssize_t size =3D openvpn_s=
end(sd, buf, len, MSG_NOSIGNAL);
+    if (size !=3D (ssize_t)len)
     {
  =
       msg(D_LINK_ERRORS | M_ERRNO, "proxy_send: TCP port write failed on s=
end()");
         return false;
diff --git a/src/openvpn/ssl=2Ec b/src/open=
vpn/ssl=2Ec
index 48508e5=2E=2E58f0f28 100644
--- a/src/openvpn/ssl=2Ec
+++=
 b/src/openvpn/ssl=2Ec
@@ -1403,14 +1403,14 @@
 
 static void
 init_key_con=
texts(struct key_state *ks, struct tls_multi *multi, const struct key_type =
*key_type,
-                  bool server, struct key2 *key2, bool dco_enab=
led)
+                  bool server, const struct key2 *key2, bool dco)
 {
=
     struct key_ctx_bi *key =3D &ks->crypto_options=2Ekey_ctx_bi;
 
     /*=
 Initialize key contexts */
     int key_direction =3D server ? KEY_DIRECTI=
ON_INVERSE : KEY_DIRECTION_NORMAL;
 
-    if (dco_enabled)
+    if (dco)
  =
   {
         if (key->encrypt=2Ehmac)
         {
diff --git a/src/openvpn/=
ssl_verify_backend=2Eh b/src/openvpn/ssl_verify_backend=2Eh
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

Gerrit-MessageType: newc=
hange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0ac9=
34da5eeed0424b54ed9b528a2bf2b561ffdf
Gerrit-Change-Number: 1912
Gerrit-Patc=
hSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn=
@rfc2549=2Eorg>

--2nBGAKd3/KI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Fix various function parameters shadowing other symbols<br><br>Updated=
 to a newer version of cppcheck (2=2E21=2E0) and it<br>reported a new group=
 of issues where function parameters<br>shadow global variables or function=
 names=2E<br><br>Used a variety of different solutions depending on context=
,<br>either renaming the global variables, the function parameters=2E<br><b=
r>In one case I removed the parameter since it only cointained<br>the globa=
l variable anyway=2E<br><br>Where applicable I have combined the change wit=
h fixing<br>occurrences of constParameterPointer to reduce conflicts<br>bet=
ween different cppcheck fix commits=2E<br><br>Change-Id: I0ac934da5eeed0424=
b54ed9b528a2bf2b561ffdf<br>Signed-off-by: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt;<br>---<br>M src/openvpn/gremlin=2Ec<br>M src/openvpn/manag=
e=2Ec<br>M src/openvpn/options_string=2Ec<br>M src/openvpn/proxy=2Ec<br>M s=
rc/openvpn/ssl=2Ec<br>M src/openvpn/ssl_verify_backend=2Eh<br>M src/openvpn=
/ssl_verify_mbedtls=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br>M src/op=
envpnserv/interactive=2Ec<br>M src/openvpnserv/validate=2Ec<br>M tests/unit=
_tests/openvpn/test_pkcs11=2Ec<br>M tests/unit_tests/openvpnserv/test_openv=
pnserv=2Ec<br>12 files changed, 62 insertions(+), 61 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/12/1912/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/gremlin=2Ec b/src/openvp=
n/gremlin=2Ec</span><br><span>index 0bd9396=2E=2Ea3efc78 100644</span><br><=
span>--- a/src/openvpn/gremlin=2Ec</span><br><span>+++ b/src/openvpn/gremli=
n=2Ec</span><br><span>@@ -112,9 +112,9 @@</span><br><span>     return ret;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static bool initialized; /* GLOBAL */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static bool up;          /* GLOBAL */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static time_t next;      /*=
 GLOBAL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bo=
ol gremlin_initialized; /* GLOBAL */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static bool gremlin_up;          /* GLOBAL */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static time_t gremlin_next;     =
 /* GLOBAL */</span><br><span> </span><br><span> /*</span><br><span>  * Ret=
urn false if we should drop a packet=2E</span><br><span>@@ -125,54 +125,54 =
@@</span><br><span>     const int up_down_level =3D GREMLIN_UP_DOWN_LEVEL(f=
lags);</span><br><span>     const int drop_level =3D GREMLIN_DROP_LEVEL(fla=
gs);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (!initialized)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!gremlin_initialized)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        initialized =3D true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        gremlin_initialized =3D=
 true;</span><br><span> </span><br><span>         if (up_down_level)</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           up =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            gremlin_up =3D false;</span><br><span>         }</span><br=
><span>         else</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            up =3D true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            gremlin_up =3D true;</span><br><=
span>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        next =3D now;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        gremlin_next =3D now;</span><br><span>     }</span><b=
r><span> </span><br><span>     if (up_down_level) /* change up/down state? =
*/</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (now &gt;=3D next)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (now &gt;=3D gremlin_next)</span><br><span>       =
  {</span><br><span>             int delta;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            if (up)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if (gremlin_up)</span><br><span>         =
    {</span><br><span>                 delta =3D roll(down_low[up_down_leve=
l - 1], down_high[up_down_level - 1]);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                up =3D false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                gremlin_up =3D false;</span><br>=
<span>             }</span><br><span>             else</span><br><span>    =
         {</span><br><span>                 delta =3D roll(up_low[up_down_l=
evel - 1], up_high[up_down_level - 1]);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                up =3D true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                gremlin_up =3D true;</span><br><=
span>             }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            msg(D_GREMLIN, &quot;GREMLIN: CONNECTION GOING =
%s FOR %d SECONDS&quot;, (up ? &quot;UP&quot; : &quot;DOWN&quot;),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_GREMLIN, &=
quot;GREMLIN: CONNECTION GOING %s FOR %d SECONDS&quot;, (gremlin_up ? &quot=
;UP&quot; : &quot;DOWN&quot;),</span><br><span>                 delta);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            next =3D now =
+ delta;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 gremlin_next =3D now + delta;</span><br><span>         }</span><br><span> =
    }</span><br><span> </span><br><span>     if (drop_level)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (u=
p &amp;&amp; flip(drop_freq[drop_level - 1]))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (gremlin_up &amp;&amp; flip(drop_freq[=
drop_level - 1]))</span><br><span>         {</span><br><span>             d=
msg(D_GREMLIN_VERBOSE, &quot;GREMLIN: Random packet drop&quot;);</span><br>=
<span>             return false;</span><br><span>         }</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return up;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return gremlin_up;</span><br><span> }</span><br><span> </span><br><span>=
 /*</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manag=
e=2Ec</span><br><span>index 8e46470=2E=2Ee6f9574 100644</span><br><span>---=
 a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</spa=
n><br><span>@@ -3060,7 +3060,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mana=
gement_notify_client_needing_auth(struct management *management, const unsi=
gned int mda_key_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+management_notify_client_needing_auth(struct management *man, const unsign=
ed int mda_key_id,</span><br><span>                                       s=
truct man_def_auth_context *mdac, const struct env_set *es)</span><br><span=
> {</span><br><span>     if (!(mdac-&gt;flags &amp; DAF_CONNECTION_CLOSED))=
</span><br><span>@@ -3071,12 +3071,12 @@</span><br><span>             mode =
=3D &quot;REAUTH&quot;;</span><br><span>         }</span><br><span>        =
 msg(M_CLIENT, &quot;&gt;CLIENT:%s,%lu,%u&quot;, mode, mdac-&gt;cid, mda_ke=
y_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        man_out=
put_extra_env(management, &quot;CLIENT&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (management-&gt;connection=2Eenv_filter=
_level &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   man_output_extra_env(man, &quot;CLIENT&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (man-&gt;connection=2Eenv_filter_l=
evel &gt; 0)</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            man_output_peer_info_env(management, mdac);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            man_outpu=
t_peer_info_env(man, mdac);</span><br><span>         }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        man_output_env(es, true, managemen=
t-&gt;connection=2Eenv_filter_level, &quot;CLIENT&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        man_output_env(es, true, man-=
&gt;connection=2Eenv_filter_level, &quot;CLIENT&quot;);</span><br><span>   =
      mdac-&gt;flags |=3D DAF_INITIAL_AUTH;</span><br><span>     }</span><b=
r><span> }</span><br><span>@@ -3102,23 +3102,24 @@</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-management_connection_established(struct management *managemen=
t, struct man_def_auth_context *mdac,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+management_connection_established(struct management *man,=
 struct man_def_auth_context *mdac,</span><br><span>                       =
            const struct env_set *es)</span><br><span> {</span><br><span>  =
   mdac-&gt;flags |=3D DAF_CONNECTION_ESTABLISHED;</span><br><span>     msg=
(M_CLIENT, &quot;&gt;CLIENT:ESTABLISHED,%lu&quot;, mdac-&gt;cid);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    man_output_extra_env(manage=
ment, &quot;CLIENT&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    man_output_extra_env(man, &quot;CLIENT&quot;);</span><br><span> =
    man_output_env(es, true, management-&gt;connection=2Eenv_filter_level, =
&quot;CLIENT&quot;);</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_notify=
_client_close(struct management *management, struct man_def_auth_context *m=
dac,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_noti=
fy_client_close(const struct management *man,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                               struct man_def_aut=
h_context *mdac,</span><br><span>                                const stru=
ct env_set *es)</span><br><span> {</span><br><span>     if ((mdac-&gt;flags=
 &amp; DAF_INITIAL_AUTH) &amp;&amp; !(mdac-&gt;flags &amp; DAF_CONNECTION_C=
LOSED))</span><br><span>     {</span><br><span>         msg(M_CLIENT, &quot=
;&gt;CLIENT:DISCONNECT,%lu&quot;, mdac-&gt;cid);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        man_output_env(es, true, management-&gt;=
connection=2Eenv_filter_level, &quot;CLIENT&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        man_output_env(es, true, man-&gt;=
connection=2Eenv_filter_level, &quot;CLIENT&quot;);</span><br><span>       =
  mdac-&gt;flags |=3D DAF_CONNECTION_CLOSED;</span><br><span>     }</span><=
br><span> }</span><br><span>@@ -3978,12 +3979,12 @@</span><br><span>  */</s=
pan><br><span> </span><br><span> struct command_line *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-command_line_new(const size_t buf_len)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+command_line_new(const =
size_t len)</span><br><span> {</span><br><span>     struct command_line *cl=
;</span><br><span>     ALLOC_OBJ_CLEAR(cl, struct command_line);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    cl-&gt;buf =3D alloc_buf(buf=
_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cl-&gt;resi=
dual =3D alloc_buf(buf_len);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    cl-&gt;buf =3D alloc_buf(len);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    cl-&gt;residual =3D alloc_buf(len);</span><br><=
span>     return cl;</span><br><span> }</span><br><span> </span><br><span>d=
iff --git a/src/openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec=
</span><br><span>index d3b29b8=2E=2E88ab798 100644</span><br><span>--- a/sr=
c/openvpn/options_string=2Ec</span><br><span>+++ b/src/openvpn/options_stri=
ng=2Ec</span><br><span>@@ -396,12 +396,12 @@</span><br><span> #endif</span>=
<br><span> </span><br><span> char *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-options_string_extract_option(const char *options_string, con=
st char *opt_name, struct gc_arena *gc)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+options_string_extract_option(const char *option_string=
, const char *opt_name, struct gc_arena *gc)</span><br><span> {</span><br><=
span>     char *ret =3D NULL;</span><br><span>     const size_t opt_name_le=
n =3D strlen(opt_name);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const char *p =3D options_string;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *p =3D option_string;<=
/span><br><span>     while (p)</span><br><span>     {</span><br><span>     =
    if (0 =3D=3D strncmp(p, opt_name, opt_name_len) &amp;&amp; strlen(p) &g=
t; (opt_name_len + 1)</span><br><span>diff --git a/src/openvpn/proxy=2Ec b/=
src/openvpn/proxy=2Ec</span><br><span>index e0700aa=2E=2E74a6cf9 100644</sp=
an><br><span>--- a/src/openvpn/proxy=2Ec</span><br><span>+++ b/src/openvpn/=
proxy=2Ec</span><br><span>@@ -184,10 +184,10 @@</span><br><span> }</span><b=
r><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-proxy_send(socket_descriptor_t sd, const void *buf, size_t buf_le=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+proxy_send(socket=
_descriptor_t sd, const void *buf, size_t len)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    const ssize_t size =3D open=
vpn_send(sd, buf, buf_len, MSG_NOSIGNAL);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (size !=3D (ssize_t)buf_len)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const ssize_t size =3D openvpn_send=
(sd, buf, len, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (size !=3D (ssize_t)len)</span><br><span>     {</span><br>=
<span>         msg(D_LINK_ERRORS | M_ERRNO, &quot;proxy_send: TCP port writ=
e failed on send()&quot;);</span><br><span>         return false;</span><br=
><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><sp=
an>index 48508e5=2E=2E58f0f28 100644</span><br><span>--- a/src/openvpn/ssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1403,14 =
+1403,14 @@</span><br><span> </span><br><span> static void</span><br><span>=
 init_key_contexts(struct key_state *ks, struct tls_multi *multi, const str=
uct key_type *key_type,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                  bool server, struct key2 *key2, bool dco_enabled)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                  bool se=
rver, const struct key2 *key2, bool dco)</span><br><span> {</span><br><span=
>     struct key_ctx_bi *key =3D &amp;ks-&gt;crypto_options=2Ekey_ctx_bi;</=
span><br><span> </span><br><span>     /* Initialize key contexts */</span><=
br><span>     int key_direction =3D server ? KEY_DIRECTION_INVERSE : KEY_DI=
RECTION_NORMAL;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (dco_enabled)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (dco)</span><br><span>     {</span><br><span>         i=
f (key-&gt;encrypt=2Ehmac)</span><br><span>         {</span><br><span>diff =
--git a/src/openvpn/ssl_verify_backend=2Eh b/src/openvpn/ssl_verify_backend=
=2Eh</span><br><span>index 9272cae=2E=2E46720d6 100644</span><br><span>--- =
a/src/openvpn/ssl_verify_backend=2Eh</span><br><span>+++ b/src/openvpn/ssl_=
verify_backend=2Eh</span><br><span>@@ -220,14 +220,14 @@</span><br><span>  =
* Check X=2E509 Netscape certificate type field, if available=2E</span><br>=
<span>  *</span><br><span>  * @param cert          Certificate to check=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param usage       =
  One of \c NS_CERT_CHECK_CLIENT, \c NS_CERT_CHECK_SERVER,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param cert_type     One of \c NS=
_CERT_CHECK_CLIENT, \c NS_CERT_CHECK_SERVER,</span><br><span>  *           =
           or \c NS_CERT_CHECK_NONE=2E</span><br><span>  *</span><br><span>=
  * @return              \c SUCCESS if NS_CERT_CHECK_NONE or if the certifi=
cate has</span><br><span>  *                      the expected bit set=2E \=
c FAILURE if the certificate does</span><br><span>  *                      =
not have NS cert type verification or the wrong bit set=2E</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-result_t x509_ver=
ify_ns_cert_type(openvpn_x509_cert_t *cert, const int usage);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+result_t x509_verify_ns_cert_type=
(openvpn_x509_cert_t *cert, const int cert_type);</span><br><span> </span><=
br><span> /*</span><br><span>  * Verify X=2E509 key usage extension field=
=2E</span><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/o=
penvpn/ssl_verify_mbedtls=2Ec</span><br><span>index 9f676ed=2E=2Ec4bae40 10=
0644</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><sp=
an>+++ b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -753,9 +753,=
9 @@</span><br><span> /* Dummy function because Netscape certificate types =
are not supported in OpenVPN with mbedtls=2E</span><br><span>  * Returns SU=
CCESS if usage is NS_CERT_CHECK_NONE, FAILURE otherwise=2E */</span><br><sp=
an> result_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-x509_veri=
fy_ns_cert_type(mbedtls_x509_crt *cert, const int usage)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+x509_verify_ns_cert_type(mbedtls_x509_=
crt *cert, const int cert_type)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (usage =3D=3D NS_CERT_CHECK_NONE)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cert_type =3D=3D =
NS_CERT_CHECK_NONE)</span><br><span>     {</span><br><span>         return =
SUCCESS;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/ss=
l_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>i=
ndex a6307f6=2E=2E6073e4e 100644</span><br><span>--- a/src/openvpn/ssl_veri=
fy_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</sp=
an><br><span>@@ -629,13 +629,13 @@</span><br><span> }</span><br><span> </sp=
an><br><span> result_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_cert, const int usage)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+x509_verify_ns_cert_=
type(openvpn_x509_cert_t *peer_cert, const int cert_type)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (usage =3D=3D=
 NS_CERT_CHECK_NONE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (cert_type =3D=3D NS_CERT_CHECK_NONE)</span><br><span>     {</span>=
<br><span>         return SUCCESS;</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (usage =3D=3D NS_CERT_CHECK_CLIE=
NT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cert_typ=
e =3D=3D NS_CERT_CHECK_CLIENT)</span><br><span>     {</span><br><span>     =
    /*</span><br><span>          * Unfortunately, X509_check_purpose() befo=
re OpenSSL 4=2E0 does some weird thing that</span><br><span>@@ -668,7 +668,=
7 @@</span><br><span>         }</span><br><span>         return result;</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (usage =3D=3D NS_CERT_CHECK_SERVER)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (cert_type =3D=3D NS_CERT_CHECK_SERVER)</span><=
br><span>     {</span><br><span>         /*</span><br><span>          * Unf=
ortunately, X509_check_purpose() before OpenSSL 4=2E0 does some weird thing=
 that</span><br><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/op=
envpnserv/interactive=2Ec</span><br><span>index d2288b9=2E=2E7819f5a 100644=
</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ =
b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -3848,8 +3848,8 @@</sp=
an><br><span> </span><br><span> </span><br><span> static DWORD</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-UpdateWaitHandles(LPHANDLE *handle=
s_ptr, LPDWORD count, HANDLE io_event, HANDLE exit_event,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                  list_item_t *threads)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+UpdateWaitHandles(L=
PHANDLE *handles_ptr, LPDWORD count, HANDLE io_event,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  const list_item_t *thre=
ads)</span><br><span> {</span><br><span>     static DWORD size =3D 10;</spa=
n><br><span>     static LPHANDLE handles =3D NULL;</span><br><span>@@ -3998=
,7 +3998,7 @@</span><br><span>         goto out;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    err=
or =3D UpdateWaitHandles(&amp;handles, &amp;handle_count, io_event, exit_ev=
ent, threads);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
rror =3D UpdateWaitHandles(&amp;handles, &amp;handle_count, io_event, threa=
ds);</span><br><span>     if (error !=3D NO_ERROR)</span><br><span>     {</=
span><br><span>         goto out;</span><br><span>@@ -4065,7 +4065,7 @@</sp=
an><br><span>                 if (!error)</span><br><span>                 =
{</span><br><span>                     error =3D</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        UpdateWaitHandles(&amp;h=
andles, &amp;handle_count, io_event, exit_event, threads);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        UpdateWaitHa=
ndles(&amp;handles, &amp;handle_count, io_event, threads);</span><br><span>=
                 }</span><br><span>                 if (error)</span><br><s=
pan>                 {</span><br><span>@@ -4073,7 +4073,7 @@</span><br><spa=
n>                                 &amp;exit_event);</span><br><span>      =
               /* Update wait handles again after removing the last worker =
thread */</span><br><span>                     RemoveListItem(&amp;threads,=
 CmpHandle, thread);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   UpdateWaitHandles(&amp;handles, &amp;handle_count, io_ev=
ent, exit_event, threads);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    UpdateWaitHandles(&amp;handles, &amp;handle_coun=
t, io_event, threads);</span><br><span>                     TerminateThread=
(thread, 1);</span><br><span>                     CloseHandleEx(&amp;thread=
);</span><br><span>                     CloseHandleEx(&amp;pipe);</span><br=
><span>@@ -4113,7 +4113,7 @@</span><br><span> </span><br><span>            =
 /* Worker thread ended */</span><br><span>             HANDLE thread =3D R=
emoveListItem(&amp;threads, CmpHandle, handles[error]);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            UpdateWaitHandles(&amp;handle=
s, &amp;handle_count, io_event, exit_event, threads);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            UpdateWaitHandles(&amp;handle=
s, &amp;handle_count, io_event, threads);</span><br><span>             Clos=
eHandleEx(&amp;thread);</span><br><span>         }</span><br><span>     }</=
span><br><span>diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/=
validate=2Ec</span><br><span>index 8e529b9=2E=2E6a13a06 100644</span><br><s=
pan>--- a/src/openvpnserv/validate=2Ec</span><br><span>+++ b/src/openvpnser=
v/validate=2Ec</span><br><span>@@ -27,7 +27,7 @@</span><br><span> #include =
&lt;pathcch=2Eh&gt;</span><br><span> #include &lt;lm=2Eh&gt;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const WCHAR=
 *white_list[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static const WCHAR *global_white_list[] =3D {</span><br><span>     L&quot;=
auth-retry&quot;,</span><br><span>     L&quot;config&quot;,</span><br><span=
>     L&quot;log&quot;,</span><br><span>@@ -335,7 +335,7 @@</span><br><span=
>     }</span><br><span> </span><br><span>     /* option name starts at 2 c=
haracters from argv[i] */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (OptionLookup(argv[0] + 2, white_list) =3D=3D -1) /* not found *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (OptionLook=
up(argv[0] + 2, global_white_list) =3D=3D -1) /* not found */</span><br><sp=
an>     {</span><br><span>         return FALSE;</span><br><span>     }</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_pkcs11=2Ec b/tests/=
unit_tests/openvpn/test_pkcs11=2Ec</span><br><span>index 042bd8b=2E=2Ea54c5=
04 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkcs11=2Ec</s=
pan><br><span>+++ b/tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><spa=
n>@@ -137,7 +137,7 @@</span><br><span> static char softhsm2_conf_path[] =3D=
 &quot;softhsm2_conf_XXXXXX&quot;;</span><br><span> int num_certs;</span><b=
r><span> static const char *pkcs11_id_current;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-struct env_set *es;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+struct env_set *test_set;</span><br><span> </span>=
<br><span> /* Fill-in certs[] array */</span><br><span> void</span><br><spa=
n>@@ -218,15 +218,15 @@</span><br><span> </span><br><span>     /* environme=
nt */</span><br><span>     setenv(&quot;SOFTHSM2_CONF&quot;, softhsm2_conf_=
path, 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    es =3D e=
nv_set_create(NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   setenv_str(es, &quot;SOFTHSM2_CONF&quot;, softhsm2_conf_path);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_str(es, &quot;GNUTLS=
_PIN&quot;, PIN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  test_set =3D env_set_create(NULL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    setenv_str(test_set, &quot;SOFTHSM2_CONF&quot;, sofths=
m2_conf_path);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
etenv_str(test_set, &quot;GNUTLS_PIN&quot;, PIN);</span><br><span> </span><=
br><span>     /* init the token using the temporary location as storage */<=
/span><br><span>     struct argv a =3D argv_new();</span><br><span>     arg=
v_printf(&amp;a, &quot;%s --init-token --free --label \&quot;%s\&quot; --so=
-pin %s --pin %s&quot;,</span><br><span>                 SOFTHSM2_UTIL_PATH=
, token_name, PIN, PIN);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    assert_true(openvpn_execve_check(&amp;a, es, 0, &quot;Failed to init=
ialize token&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(openvpn_execve_check(&amp;a, test_set, 0, &quot;Failed to=
 initialize token&quot;));</span><br><span> </span><br><span>     /* Import=
 certificates and keys in our test database into the token */</span><br><sp=
an>     char cert[] =3D &quot;cert_XXXXXX&quot;;</span><br><span>@@ -263,14=
 +263,14 @@</span><br><span>         argv_printf(</span><br><span>         =
    &amp;a, &quot;%s --provider %s --load-certificate %s --label \&quot;%s\=
&quot; --id %08x --login --write&quot;,</span><br><span>             P11TOO=
L_PATH, SOFTHSM2_MODULE_PATH, cert, c-&gt;friendly_name, num_certs + 1);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        assert_true(open=
vpn_execve_check(&amp;a, es, 0, &quot;Failed to upload certificate into tok=
en&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
assert_true(openvpn_execve_check(&amp;a, test_set, 0, &quot;Failed to uploa=
d certificate into token&quot;));</span><br><span> </span><br><span>       =
  argv_free(&amp;a);</span><br><span>         a =3D argv_new();</span><br><=
span>         argv_printf(&amp;a,</span><br><span>                     &quo=
t;%s --provider %s --load-privkey %s --label \&quot;%s\&quot; --id %08x --l=
ogin --write&quot;,</span><br><span>                     P11TOOL_PATH, SOFT=
HSM2_MODULE_PATH, key, c-&gt;friendly_name, num_certs + 1);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        assert_true(openvpn_execve_ch=
eck(&amp;a, es, 0, &quot;Failed to upload key into token&quot;));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(openvpn_e=
xecve_check(&amp;a, test_set, 0, &quot;Failed to upload key into token&quot=
;));</span><br><span> </span><br><span>         assert_int_equal(ftruncate(=
cert_fd, 0), 0);</span><br><span>         assert_int_equal(ftruncate(key_fd=
, 0), 0);</span><br><span>@@ -294,7 +294,7 @@</span><br><span>     struct a=
rgv a =3D argv_new();</span><br><span> </span><br><span>     argv_printf(&a=
mp;a, &quot;%s --delete-token --token \&quot;%s\&quot;&quot;, SOFTHSM2_UTIL=
_PATH, token_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  assert_true(openvpn_execve_check(&amp;a, es, 0, &quot;Failed to delete to=
ken&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(openvpn_execve_check(&amp;a, test_set, 0, &quot;Failed to delete t=
oken&quot;));</span><br><span>     argv_free(&amp;a);</span><br><span> </sp=
an><br><span>     rmdir(softhsm2_tokens_path); /* this must be empty after =
delete token */</span><br><span>@@ -304,7 +304,7 @@</span><br><span>       =
  free(c-&gt;p11_id);</span><br><span>         c-&gt;p11_id =3D NULL;</span=
><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
env_set_destroy(es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    env_set_destroy(test_set);</span><br><span>     return 0;</span><br><s=
pan> }</span><br><span> </span><br><span>diff --git a/tests/unit_tests/open=
vpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/test_openvpnser=
v=2Ec</span><br><span>index e01b0e3=2E=2E4ca715b 100644</span><br><span>---=
 a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>+++ b/=
tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>@@ -35,7 =
+35,7 @@</span><br><span> #include &quot;interactive=2Ec&quot;</span><br><s=
pan> </span><br><span> BOOL</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *st=
atus)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ReportStatusTo=
SCMgr(SERVICE_STATUS_HANDLE svc_handle, SERVICE_STATUS *svc_status)</span><=
br><span> {</span><br><span>     return TRUE;</span><br><span> }</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1912?usp=3Demail">change 1912</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528=
a2bf2b561ffdf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 191=
2 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--2nBGAKd3/KI=--


--===============0358313735961016908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0358313735961016908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0358313735961016908==--

