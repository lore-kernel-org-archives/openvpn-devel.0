Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E75606A325
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TItfFRtA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cVJ4m6/h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eAzGsay/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=C7Q8cJbV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FWipFlMCUFlQff1ZAv01qTgEpwRUnECQsAAeA+42JMI=; b=TItfFRtAbbSM5zUqCfYri9uiDw
	EGe6+oHVVC7ETdU6nwGYOewYmNbh2rL+nVl3nCikrHCHGPignbKwFvJ/ZDLQe3u+RRed8azptYZ3+
	c8G1sNxM4ELuRxHAqgWoud7wDRy+Nsl/tBL0sdTGqoRO87JZtW43SmHuWZlVzpz+H48Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTj7h-000000000M7-2As6;
	Wed, 18 Nov 2026 17:07:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTj7f-000000000Lu-3dET
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:07:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sIHC+ZQjhjCfaJvsJmrZd2qB3sMaWTMXxrht4SGM95c=; b=cVJ4m6/hioI0+55t1Dtwjr1iUW
 u1CitXZcJtqaQHl0nphVihvCDvAITgAICK9ymfYBBdkAgctlwm6dEntEWssfewBDPybwHgQBLoewf
 Cto3pnZJ5xmMlhu2q1kNW73d8UTYOrfBPDLofz1nIzyOq/XzHAUbvpsUfT2Xd//ZO7Hs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sIHC+ZQjhjCfaJvsJmrZd2qB3sMaWTMXxrht4SGM95c=; b=eAzGsay/X71zuuqmiGTB+Ke1Nq
 zh3liKjCZXUSU8bKoBQ1zLDmwNwj45XRJoCnqfFMD+8qMGdohm36fwIuvotrxkKGIT2WPWho0sD4P
 j3KLRIwcEnPFIZQ7HdcP0NdiFuID7TNYRJGLFvkYkbNbEq6xgZ7n1HRX7Ld/jCdxEnGY=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTj7d-000000006rJ-1Mc5 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:07:03 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so10942815e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 09:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795021615; x=1795626415; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sIHC+ZQjhjCfaJvsJmrZd2qB3sMaWTMXxrht4SGM95c=;
 b=C7Q8cJbV0BPiO/6SWKaa/rCh17Uh/n1ftIRtkRFceLfddBfriNtKYSFishnin5iixN
 TE27A9rUMYAsFgM38MHRRs6x2xbdI9qS+dZ5gbEeTZzsD6hDN56dvr1FDBGHNACSZGEz
 wH2/8/I7GoU7wB5dKChvbWhfo3OYeam3jra/aWcS/AtnMwiUL3lxpcSbeM1cxvUp7fkw
 Wt86BinRQoQ4TE3dX5i4TSG4idsmXDbsklR2vbdY9EcmtB4R6JNauv2L1RqnKD7fUtME
 gWdfLjc9+aq5FzGchUA1YMOBPkhv+LQrUxIk8Z1BpjuWI36jxwukC7UuxPIkJeOKGuMf
 IAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795021615; x=1795626415;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sIHC+ZQjhjCfaJvsJmrZd2qB3sMaWTMXxrht4SGM95c=;
 b=VaMXYQt/OzZQQAbixTsKQ+zJ1dxspdh4IUNrYysDCINWWPJcCSXDCnMnO/ccuubpkj
 EHG66DUS4InjA3pquFFaLoVzF5KU9v4VgwNJdz8szOlkAgwFRqnd+WIs6Rk7ST5P0XWK
 5iLGjCZyZYN9+2SuaC6dpHOyKAKA69sfqzsGVOJuNQqLdaq0pvlvXKuqUCnOQJoRbuIY
 wC+saAly9lGHKhHMbZIdU2+xOCUp0xBPBGvtGfdlQ9tcWLHkWStIsLw60eN5iuulOK3v
 bmUK5DSJeC33hR2T6QbzZxfBjFS5ErGMKwoqmtikerKcQbWL2tNPOFrNhKX/ORCbvbv2
 34GA==
X-Gm-Message-State: APuU4Z/Pak6NGHIlKB+EVNpidqCUcIRsF4L2wYUCxCQC+4cuGWI85Gk3
 S/Y/Cbn+xw7j5QGar8m9+HnwBG5mCLUsdyeiVTMe7P5qe+1/Mo4Ebp6SDnyQDZxhv7MpJTGltSf
 OHhtptjd0ZX1QMAazFqPXUdEQgwUCnaPEmBpV5pnezb6UzhRbeJdEe9P9ttCaHC8uzCVT
X-Gm-Gg: AYBFou2wROIna0pdJ6YW6dInJWagobS0J+/N88ApC/FyPzS2VqjKlf8lSGBV09sGuTL
 BiLZAfIBQsoIJnJoJg1FxwoLZIhQGBXNDx729WGTkUfpVmzqLZYaSn7pKYJeV98+gQ15xCT9DD9
 EdL0B4a5HcTWgU1CRLXSwJ8j1vc1LT7CAbznNTG++W1MLvbFYsTWG4vmw9/XR+GOFztyzZ5ySvL
 uVSBQkb/+dEDEuX3wy2EYLEeKFVhrGh7LlUHv9siNetsJ/Z6K7s1P1qtASHqVr58ILa+ESuBVlF
 5hbT0JD7dpN8FzaV1stEl+1aw7aYLZP+UhAQHZa2lMzwf52EzbHAMfDs5lAUULUGtF4D5OpZxos
 sCenI2R1XS4P0HgGyN9dAreGdb0tFxj6Cu9jLj8D+R6Bxdl0ciSsrd5jDRBNX5frz5Zcd2Ie1Fv
 /2auUvE3nUipxoMVaO054l5Kl942Cp2DJ2ZAucVHnsd7wBr/QZs9rbXw9nHJ6CltQLKAtkk3brM
 rLJrAB6XV4WDgtj9gsMyOnw2vgJ+hS5D0j2J8Kk4CwbC3ooDZ4j3SC7dVWoI98Razfn0YCkIhD3
 H5YOD75fRsQW4G/QeMydb/QmasFgrinz762v9qsYEMqrgED8XB6fvcR6CR1sZFRTfiwv3mP2fXl
 WMCaMZyl12GJxoOAWAhLOF8h/aqxorfLZzGXxPr2gCAE3D2oHQu0SK8UnqvxUe02rPA+fhTcknz
 R72cmu/FL7B8ZqdqQcY0SIfr9mqH+Iyc9Ty9+X
X-Received: by 2002:a05:600c:1c11:b0:4bb:7757:fe58 with SMTP id
 5b1f17b1804b1-4bb7da238e5mr61110895e9.19.1795021614221; 
 Wed, 18 Nov 2026 09:06:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e580745sm44513375e9.2.2026.11.18.09.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:06:53 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 17:06:52 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3
X-Gerrit-Change-Number: 2196
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2196?usp=email>
X-Gerrit-Commit: ec5dd16a4a97622009da864f9f167a9667005cdd
In-Reply-To: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
References: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM0NjUwMDAwLkllYzg1ZDUzY2UxMDc2NjM5YmQ2Y2VhZjNiYTdkNTNjYzllNzlkN2EzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ef63b765d17f44e9e1ba6b2f3bcc8c6eb7cbacea-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTj7d-000000006rJ-1Mc5
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: drop
 impossible out-of-memory branches
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
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
Content-Type: multipart/mixed; boundary="===============3744275186566676756=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3744275186566676756==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dx68g8uU4vY="; charset=UTF-8

--dx68g8uU4vY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2196?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: options: drop imposs=
ible out-of-memory branches
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

options: drop impossible out-of-memory branches

gc_reallo=
c() aborts via check_malloc_return() and never returns NULL=2E
Remove the N=
ULL handling from alloc_{local,connection,remote}_entry(),
their now unused=
 msglevel parameter, and the callers' checks=2E

Change-Id: Iec85d53ce10766=
39bd6ceaf3ba7d53cc9e79d7a3
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196
Message-Id: <20261117143617=
=2E25095-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg41542=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/options=2Ec
1 file chan=
ged, 12 insertions(+), 57 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/96/2196/3

diff --git a/src/openvpn/optio=
ns=2Ec b/src/openvpn/options=2Ec
index 2181076=2E=2E947439d 100644
--- a/sr=
c/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1379,7 +1379,7 @@
 =
}
 
 static struct local_entry *
-alloc_local_entry(struct connection_entry=
 *ce, const msglvl_t msglevel, struct gc_arena *gc)
+alloc_local_entry(stru=
ct connection_entry *ce, struct gc_arena *gc)
 {
     struct local_list *l =
=3D alloc_local_list_if_undef(ce, gc);
     struct local_entry *e;
@@ -1389=
,16 +1389,7 @@
         const int new_cap =3D l->capacity + 1;
         con=
st size_t elem_size =3D sizeof(*l->array);
 
-        struct local_entry **=
new_array =3D gc_realloc(l->array, new_cap * elem_size, gc);
-        if (!=
new_array)
-        {
-            msg(msglevel,
-                "Unable t=
o process more local options: out of memory=2E Number of entries =3D %d",
-=
                l->len);
-            return NULL;
-        }
-
-        l-=
>array =3D new_array;
+        l->array =3D gc_realloc(l->array, new_cap * =
elem_size, gc);
         l->capacity =3D new_cap;
     }
 
@@ -1420,7 +1411=
,7 @@
 }
 
 static struct connection_entry *
-alloc_connection_entry(struct=
 options *options, const msglvl_t msglevel)
+alloc_connection_entry(struct =
options *options)
 {
     struct connection_list *l =3D alloc_connection_li=
st_if_undef(options);
     struct connection_entry *e;
@@ -1428,16 +1419,7 =
@@
     if (l->len =3D=3D l->capacity)
     {
         int capacity =3D l->=
capacity + CONNECTION_LIST_SIZE;
-        struct connection_entry **ce =3D
=
-            gc_realloc(l->array, capacity * sizeof(struct connection_entry=
 *), &options->gc);
-        if (ce =3D=3D NULL)
-        {
-            ms=
g(msglevel,
-                "Unable to process more connection options: ou=
t of memory=2E Number of entries =3D %d",
-                l->len);
-      =
      return NULL;
-        }
-        l->array =3D ce;
+        l->array =
=3D gc_realloc(l->array, capacity * sizeof(struct connection_entry *), &opt=
ions->gc);
         l->capacity =3D capacity;
     }
     ALLOC_OBJ_GC(e, s=
truct connection_entry, &options->gc);
@@ -1456,7 +1438,7 @@
 }
 
 static s=
truct remote_entry *
-alloc_remote_entry(struct options *options, const msg=
lvl_t msglevel)
+alloc_remote_entry(struct options *options)
 {
     struct=
 remote_list *l =3D alloc_remote_list_if_undef(options);
     struct remote=
_entry *e;
@@ -1464,16 +1446,7 @@
     if (l->len =3D=3D l->capacity)
     =
{
         int capacity =3D l->capacity + CONNECTION_LIST_SIZE;
-        st=
ruct remote_entry **re =3D
-            gc_realloc(l->array, capacity * siz=
eof(struct remote_entry *), &options->gc);
-        if (re =3D=3D NULL)
-  =
      {
-            msg(msglevel,
-                "Unable to process more=
 remote options: out of memory=2E Number of entries =3D %d",
-             =
   l->len);
-            return NULL;
-        }
-        l->array =3D re;
=
+        l->array =3D gc_realloc(l->array, capacity * sizeof(struct remote_=
entry *), &options->gc);
         l->capacity =3D capacity;
     }
     ALL=
OC_OBJ_GC(e, struct remote_entry, &options->gc);
@@ -3071,20 +3044,16 @@
  =
       {
             const struct remote_entry *re =3D rl->array[i];
     =
        struct connection_entry ce =3D o->ce;
-            struct connectio=
n_entry *ace;
 
             ASSERT(re->remote);
             connection_en=
try_load_re(&ce, re);
-            ace =3D alloc_connection_entry(o, M_USAG=
E);
-            ASSERT(ace);
+            struct connection_entry *ace =3D=
 alloc_connection_entry(o);
             *ace =3D ce;
         }
     }
   =
  else if (!o->remote_list && !o->connection_list)
     {
-        struct c=
onnection_entry *ace;
-        ace =3D alloc_connection_entry(o, M_USAGE);
=
-        ASSERT(ace);
+        struct connection_entry *ace =3D alloc_conne=
ction_entry(o);
         *ace =3D o->ce;
     }
 
@@ -3117,8 +3086,7 @@
   =
  {
         /* if no 'local' directive was specified, convert the global p=
ort
          * setting to a listen entry */
-        struct local_entry *e=
 =3D alloc_local_entry(&o->ce, M_USAGE, &o->gc);
-        ASSERT(e);
+     =
   struct local_entry *e =3D alloc_local_entry(&o->ce, &o->gc);
         e-=
>port =3D o->ce=2Elocal_port;
         e->proto =3D o->ce=2Eproto;
     }
@=
@ -4464,12 +4432,9 @@
     }
     else if (streq(p[0], "local") && p[1] && =
!p[4])
     {
-        struct local_entry *e;
-
         VERIFY_PERMISSION(=
OPT_P_GENERAL | OPT_P_CONNECTION);
 
-        e =3D alloc_local_entry(&opti=
ons->ce, M_USAGE, &options->gc);
-        ASSERT(e);
+        struct local_=
entry *e =3D alloc_local_entry(&options->ce, &options->gc);
 
         /* '=
*' is treated as 'ask the system to get some socket',
          * therefore=
 force binding on a particular address only when
@@ -4500,7 +4465,6 @@
    =
     if (is_inline)
         {
             struct options sub;
-          =
  struct connection_entry *e;
 
             init_options(&sub);
          =
   sub=2Ece =3D options->ce;
@@ -4514,12 +4478,7 @@
                 goto e=
rr;
             }
 
-            e =3D alloc_connection_entry(options, msg=
level);
-            if (!e)
-            {
-                uninit_options=
(&sub);
-                goto err;
-            }
+            struct conne=
ction_entry *e =3D alloc_connection_entry(options);
             *e =3D sub=
=2Ece;
             gc_transfer(&options->gc, &sub=2Egc);
             unin=
it_options(&sub);
@@ -4608,11 +4567,7 @@
         }
         if (permission=
_mask & OPT_P_GENERAL)
         {
-            struct remote_entry *e =3D a=
lloc_remote_entry(options, msglevel);
-            if (!e)
-            {
-=
                goto err;
-            }
+            struct remote_entry *=
e =3D alloc_remote_entry(options);
             *e =3D re;
         }
     =
    else if (permission_mask & OPT_P_CONNECTION)

-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3=

Gerrit-Change-Number: 2196
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--dx68g8uU4vY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2196?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">options: drop impossible out-of-memory branches<br><br>gc_realloc() abo=
rts via check_malloc_return() and never returns NULL=2E<br>Remove the NULL =
handling from alloc_{local,connection,remote}_entry(),<br>their now unused =
msglevel parameter, and the callers&#39; checks=2E<br><br>Change-Id: Iec85d=
53ce1076639bd6ceaf3ba7d53cc9e79d7a3<br>Signed-off-by: Razvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196=
<br>Message-Id: &lt;20261117143617=2E25095-1-gert@greenie=2Emuc=2Ede&gt;<br=
>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg41542=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M src/openvpn/options=2Ec<br>1 file changed, 12 inserti=
ons(+), 57 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/96/2196/3</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 218107=
6=2E=2E947439d 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><=
br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -1379,7 +1379,7 @=
@</span><br><span> }</span><br><span> </span><br><span> static struct local=
_entry *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-alloc_local_e=
ntry(struct connection_entry *ce, const msglvl_t msglevel, struct gc_arena =
*gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+alloc_local_ent=
ry(struct connection_entry *ce, struct gc_arena *gc)</span><br><span> {</sp=
an><br><span>     struct local_list *l =3D alloc_local_list_if_undef(ce, gc=
);</span><br><span>     struct local_entry *e;</span><br><span>@@ -1389,16 =
+1389,7 @@</span><br><span>         const int new_cap =3D l-&gt;capacity + =
1;</span><br><span>         const size_t elem_size =3D sizeof(*l-&gt;array)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      struct local_entry **new_array =3D gc_realloc(l-&gt;array, new_cap * =
elem_size, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (!new_array)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(=
msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    &quot;Unable to process more local options: out of memory=2E Number of =
entries =3D %d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                l-&gt;len);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            return NULL;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        l-&gt;array =3D =
new_array;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        l=
-&gt;array =3D gc_realloc(l-&gt;array, new_cap * elem_size, gc);</span><br>=
<span>         l-&gt;capacity =3D new_cap;</span><br><span>     }</span><br=
><span> </span><br><span>@@ -1420,7 +1411,7 @@</span><br><span> }</span><br=
><span> </span><br><span> static struct connection_entry *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-alloc_connection_entry(struct options =
*options, const msglvl_t msglevel)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+alloc_connection_entry(struct options *options)</span><br><s=
pan> {</span><br><span>     struct connection_list *l =3D alloc_connection_=
list_if_undef(options);</span><br><span>     struct connection_entry *e;</s=
pan><br><span>@@ -1428,16 +1419,7 @@</span><br><span>     if (l-&gt;len =3D=
=3D l-&gt;capacity)</span><br><span>     {</span><br><span>         int cap=
acity =3D l-&gt;capacity + CONNECTION_LIST_SIZE;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        struct connection_entry **ce =3D</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            gc_realloc(l-&gt;=
array, capacity * sizeof(struct connection_entry *), &amp;options-&gt;gc);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ce =3D=3D =
NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;Un=
able to process more connection options: out of memory=2E Number of entries=
 =3D %d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         l-&gt;len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        l-=
&gt;array =3D ce;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      l-&gt;array =3D gc_realloc(l-&gt;array, capacity * sizeof(struct conn=
ection_entry *), &amp;options-&gt;gc);</span><br><span>         l-&gt;capac=
ity =3D capacity;</span><br><span>     }</span><br><span>     ALLOC_OBJ_GC(=
e, struct connection_entry, &amp;options-&gt;gc);</span><br><span>@@ -1456,=
7 +1438,7 @@</span><br><span> }</span><br><span> </span><br><span> static s=
truct remote_entry *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-a=
lloc_remote_entry(struct options *options, const msglvl_t msglevel)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+alloc_remote_entry(struct o=
ptions *options)</span><br><span> {</span><br><span>     struct remote_list=
 *l =3D alloc_remote_list_if_undef(options);</span><br><span>     struct re=
mote_entry *e;</span><br><span>@@ -1464,16 +1446,7 @@</span><br><span>     =
if (l-&gt;len =3D=3D l-&gt;capacity)</span><br><span>     {</span><br><span=
>         int capacity =3D l-&gt;capacity + CONNECTION_LIST_SIZE;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        struct remote_entry **r=
e =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            gc_r=
ealloc(l-&gt;array, capacity * sizeof(struct remote_entry *), &amp;options-=
&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (r=
e =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msg=
level,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 &quot;Unable to process more remote options: out of memory=2E Number of en=
tries =3D %d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              l-&gt;len);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            return NULL;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   l-&gt;array =3D re;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        l-&gt;array =3D gc_realloc(l-&gt;array, capacity * sizeof(struct=
 remote_entry *), &amp;options-&gt;gc);</span><br><span>         l-&gt;capa=
city =3D capacity;</span><br><span>     }</span><br><span>     ALLOC_OBJ_GC=
(e, struct remote_entry, &amp;options-&gt;gc);</span><br><span>@@ -3071,20 =
+3044,16 @@</span><br><span>         {</span><br><span>             const s=
truct remote_entry *re =3D rl-&gt;array[i];</span><br><span>             st=
ruct connection_entry ce =3D o-&gt;ce;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            struct connection_entry *ace;</span><br><span>=
 </span><br><span>             ASSERT(re-&gt;remote);</span><br><span>     =
        connection_entry_load_re(&amp;ce, re);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            ace =3D alloc_connection_entry(o, M_US=
AGE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSE=
RT(ace);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 struct connection_entry *ace =3D alloc_connection_entry(o);</span><br><spa=
n>             *ace =3D ce;</span><br><span>         }</span><br><span>    =
 }</span><br><span>     else if (!o-&gt;remote_list &amp;&amp; !o-&gt;conne=
ction_list)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        struct connection_entry *ace;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        ace =3D alloc_connection_entry(o, M_US=
AGE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(a=
ce);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct =
connection_entry *ace =3D alloc_connection_entry(o);</span><br><span>      =
   *ace =3D o-&gt;ce;</span><br><span>     }</span><br><span> </span><br><s=
pan>@@ -3117,8 +3086,7 @@</span><br><span>     {</span><br><span>         /=
* if no &#39;local&#39; directive was specified, convert the global port</s=
pan><br><span>          * setting to a listen entry */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        struct local_entry *e =3D alloc_lo=
cal_entry(&amp;o-&gt;ce, M_USAGE, &amp;o-&gt;gc);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        ASSERT(e);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        struct local_entry *e =3D alloc_local_en=
try(&amp;o-&gt;ce, &amp;o-&gt;gc);</span><br><span>         e-&gt;port =3D =
o-&gt;ce=2Elocal_port;</span><br><span>         e-&gt;proto =3D o-&gt;ce=2E=
proto;</span><br><span>     }</span><br><span>@@ -4464,12 +4432,9 @@</span>=
<br><span>     }</span><br><span>     else if (streq(p[0], &quot;local&quot=
;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        struct local_entry *e;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         VE=
RIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        e =3D alloc_local_en=
try(&amp;options-&gt;ce, M_USAGE, &amp;options-&gt;gc);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        ASSERT(e);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct local_entry *e =3D alloc_l=
ocal_entry(&amp;options-&gt;ce, &amp;options-&gt;gc);</span><br><span> </sp=
an><br><span>         /* &#39;*&#39; is treated as &#39;ask the system to g=
et some socket&#39;,</span><br><span>          * therefore force binding on=
 a particular address only when</span><br><span>@@ -4500,7 +4465,6 @@</span=
><br><span>         if (is_inline)</span><br><span>         {</span><br><sp=
an>             struct options sub;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            struct connection_entry *e;</span><br><span> </sp=
an><br><span>             init_options(&amp;sub);</span><br><span>         =
    sub=2Ece =3D options-&gt;ce;</span><br><span>@@ -4514,12 +4478,7 @@</sp=
an><br><span>                 goto err;</span><br><span>             }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    e =3D alloc_connection_entry(options, msglevel);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (!e)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                uninit_options(&amp;sub);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                goto err;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            struct connection_ent=
ry *e =3D alloc_connection_entry(options);</span><br><span>             *e =
=3D sub=2Ece;</span><br><span>             gc_transfer(&amp;options-&gt;gc,=
 &amp;sub=2Egc);</span><br><span>             uninit_options(&amp;sub);</sp=
an><br><span>@@ -4608,11 +4567,7 @@</span><br><span>         }</span><br><s=
pan>         if (permission_mask &amp; OPT_P_GENERAL)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            stru=
ct remote_entry *e =3D alloc_remote_entry(options, msglevel);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            if (!e)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                goto err;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            struct remote_entry *e =3D alloc_=
remote_entry(options);</span><br><span>             *e =3D re;</span><br><s=
pan>         }</span><br><span>         else if (permission_mask &amp; OPT_=
P_CONNECTION)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail">change 2196</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iec85d53ce107663=
9bd6ceaf3ba7d53cc9e79d7a3 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2196 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>=

<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bod=
y></html>
--dx68g8uU4vY=--


--===============3744275186566676756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3744275186566676756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3744275186566676756==--

