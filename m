Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94C9CA9EBD
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SXT+Wx53DrgKKgAYeYagnh/0EKdSQet8Rqi27XMye4o=; b=AG/h+wjIshwl6EpWFOdM6v9Kv2
	tEbX1/EK77ScS+O1BVz82BGFvansnColmjttKYD+tORJE91VQvu0ecLvYUYgoO9IL5pp2VlHUGMj7
	Kh3iJDhhJegp+Dy6E1RXqGd1zNFQDZwqWYb/ABiO3QrzzOssd2JSiLZbPCqUI8solVTQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFuQZ-0005my-6H;
	Sun, 11 Oct 2026 14:21:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xFuQX-0005ms-Jo
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 14:21:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dChord3ttv7s8W44VYJfWAkPbhuoLKFhIbweAx6oitU=; b=HfRVt+4yroNBNex4JEW0q8mQEc
 AefHIY4z1VNscO3M2Kk8YE27s8uYtMMJ2QkV5FzLYT1+OxisvRDDjUtJ9lMZU6iY/ZsCLXO0QzjnE
 EEMZQofTY9y1QxoQJ1SDXG3fNxSVnEuOuSfSUHIB0ug4M36hW7Q9efanqPeKXJ87useY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dChord3ttv7s8W44VYJfWAkPbhuoLKFhIbweAx6oitU=; b=f
 FPats6gb+mMSdwcaDJDHsNDN4Xnf+rHDtkj0M4SS8iywhfTaABpmork4gFTqpwwuBsJtpfhOBqTXz
 UELlFs+nJi+R1iq1PNfae+axmUbs6VnBIecZhuWN5f/Xy3F3He5bxZdNM6t4KYiemVpYmK96UWlEf
 OiTYQCHje6t1zZ+g=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFuQT-0003nu-SU for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 14:21:25 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48c4207ac26so1086454f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 07:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791728475; x=1792333275; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dChord3ttv7s8W44VYJfWAkPbhuoLKFhIbweAx6oitU=;
 b=OnrbXRwcoCtvBiiWjt+MjwoD8ps/mBbHOsOvnvRaSsmdqTH9TGQUZtT1UXwQVpSibk
 nOJI50yYnhr7ZyYyyHXLG/YY7aMpCmz62mVExHbHYsAdTaO9f5qX4E4Dh4i1DlXUzwiN
 uQK5ifPAVT0NFSsVUdpDienn1rhfTmEvgO1loaTtczIebOGwhM2WxPmn22Pr1j5wsuq+
 E8pFt1133g3hdAEY5HTzKalsxmPD8bvv6qYxY5KY7mh6FEpMwTG5CsKc6zhu+ZACi6mi
 TKBAZYPnR1hd0ljwDG6AKyHiBhZspUZb9ifJb+K7a8KvW+JNhgCF7uLtiDCEslVleUuv
 J/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791728475; x=1792333275;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dChord3ttv7s8W44VYJfWAkPbhuoLKFhIbweAx6oitU=;
 b=LGJBsUoohFMOPdi2BMImMH5XsYNsGUlWz4IIZNwJXt0A6FhEwKdrenIVhMzDI7sOPU
 J8QuCWOeuBKDSMvqUh8WicVfAW6Z7ZrJQ0bIIEP8u2MpN8mK2iDla+gAOuvaqUkgxdYO
 HtId/gWMhWMuoDtxiPnZEwQ6VdsANH1glbHxtKglzi8ahTz3VWIT/qh5mvpe6gEn2rSr
 KoQ5ngzS7iZS3neZbCi5vXwcER6lytkjIAjK3r3GtWe9yNMlDqTTu8Po/NDY5hiL1+9w
 W+1ntdjsPANFmP/YrbKYYIBqRPGdYv+cZe1EVfdfJnwMzOYoSEzvF8AQbCLG9J/Q+nwV
 Af2g==
X-Gm-Message-State: AFq9FYIJV1HT6W564g5yDWvjgZCH6zxdFcXBGu41XTgKvgh8dQ7l1wgo
 lc3wSWmAai7B0dPW4iSPv5QHKqVs4fXriLVd/AynQ75oH9KCSxCB3xgVVUDZWfSUMutvg30ASXy
 HXxNBnToOmUNFEU0HwEPc+udwy1c+l7eK558ws/5Xj2hgGQUigMNtADVBsGeWYx8BldjalyX22W
 RmzrGXig==
X-Gm-Gg: AYBFou3TsA26INnbImBOzp2BSF4r7aVPHJpUjsa7Cm/w2YuZhdg94knSiwqDeGVzC45
 DGxSuEIWr1vl4serQ4Y9zDEUIJ0qxNgkaxSyqwa4srIo3kksS6XjJ3gGKwuyNpraVXR9s1IiP/3
 P7M4/uxWd4g7GAYci4m1uVr68v3sGU/ri8XrbqF7k/gsdu7FXFZZTRbAg5fy6aCxbIINNNN3UtO
 UUkHizOFkM2/Lim8ReyjsccCGlgyhqt9Z1g1tRp6SRdS47/T4SW/LOG74xACjhCpRGo2R25xzZq
 1OwG1tpmY6PU2OXPwfbKOs85rObxzXu1rYMqZLIRdVbcPd/E2KNdC8ZtONaHnwRTsaAoUZMOhup
 mvKju5zNcicnsFVFROhncQgTPl0C/OyGuftSwi8JQH085au5FXZ3SR75+sOF98UrX64pL1tFPJq
 1fMNSVmh8YwDvNV/sXypgec3dzU3k7WdJrBWW/GhoHecgZQ8zVI2+LPJRJ1ZOAz12BfoMjIdAUV
 kebxMKMQI6nY7dK0iBFLbDEYZEkdcCB88MjJLr/wmoowIop2BXlvE+6JvnDBYOBSe53JrNuvv1W
 NppWyLHHdsS+GKwfvmPoeu3SHaeNRaZ1mRQFWQ5Uvh+l7BgqFj4xqbufb5yz
X-Received: by 2002:a05:6000:4208:b0:48a:eeef:b4a7 with SMTP id
 ffacd0b85a97d-48dbace643emr12275606f8f.48.1791728474076; 
 Sun, 11 Oct 2026 07:21:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abdaa5sm14856014f8f.35.2026.10.11.07.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 07:21:13 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 11 Oct 2026 14:21:09 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 38
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 66f8cdb9fd0b0334b6d79016b9d02cfceb6887d7
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <de90dd07adfdc5c52913e81574a0e1f1c405f70d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xFuQT-0003nu-SU
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6607750794576426327=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6607750794576426327==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zUxR4NHPNJw="; charset=UTF-8

--zUxR4NHPNJw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#38) to the change originally cr=
eated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?=
usp=3Demail )

The following approvals got outdated and were removed:
Code-=
Review+2 by Antonio Quartulli


Change subject: Add lookup of multi session=
 by session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Add lookup of multi session by session id

This refactors the way that we=
 lookup control channel packets for UDP
packets from other peers=2E Instead=
 of looking them up by their source
IP address, we lookup the session ids i=
nstead=2E

It also has the consequence that we can have multiple ongoing
se=
ssions from the same source IP address and the new session will
go through =
all the connect steps like an initial session=2E

The check if the new sess=
ion can take over the old session's IP
is now also the same as for floating=
=2E

This eliminates a whole class of bugs that we currently have that
brea=
k connection if the reconnecting client has different
capabilities as the s=
etup and negotiation is inherited from the
previous client currently=2E Cur=
rently there is at least one bug
regarding the dynamic tls-crypt in this si=
tuation=2E

This also changes the user visible behaviour for clients
reconn=
ecting from the same IP and port=2E They are now almost
behaving like clien=
ts that reconnect from a different IP
address=2E These now do the whole ren=
egotiation and run
connect scripts/plugins and all the things are normally
=
skipped when reconnecting from the same IP and port=2E

The only difference=
 is that duplicate-cn does not
allow both connection=2E

This will also eve=
ntually allow us to get rid of TM_INITIAL
slot as we now do no longer need =
to keep an ongoing and a
new session anymore=2E Currently the p2p mode stil=
l needs
the extra session slot for the new session so we cannot
remove it j=
ust yet=2E

This now allows a multiple pending session from the
same source=
 IP and port=2E Previously a client would need
to use a different ports to =
create multiple pending
session=2E This change does not make it really easi=
er to
exhaust all pending session than before=2E

This makes the theoretica=
lly easier to create more session
on the server since you no longer need di=
stinct source ports
per sessions but using different source ports is not
me=
aningfully harder than using the same source port=2E

This also removes has=
hing TCP connections by their source IP
address=2E We do not look up TCP se=
ssion by their source but rather
just identify by their socket=2E

This als=
o removes the code for the weird edge case from TCP
where connections when =
a new connection from the same IP/port
is connecting=2E This code is pre mu=
lti-socket and it is unclear
if there was ever a way to have a TCP connecti=
on from an
identical IP/port without the old socket being closed first=2E

=
Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Signed-off-by: Arne Sc=
hwabe <arne@rfc2549=2Eorg>
Acked-by: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727
Message=
-Id: <20261009101429=2E10505-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39817=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etx=
t
M doc/man-sections/advanced-options=2Erst
M src/openvpn/Makefile=2Eam
M s=
rc/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/op=
envpn/multi=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
A src/o=
penvpn/sid_hash=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_t=
ests/openvpn/test_misc=2Ec
12 files changed, 279 insertions(+), 52 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/2=
7/1727/38

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 2d9b546=
=2E=2Ebac4dd4 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -862,=
6 +862,7 @@
         src/openvpn/siphash=2Eh
         src/openvpn/siphash=
=2Ec
         src/openvpn/siphash_reference=2Ec
+        src/openvpn/sessio=
n_id=2Ec
     )
 
     target_sources(test_ncp PRIVATE
diff --git a/doc/man=
-sections/advanced-options=2Erst b/doc/man-sections/advanced-options=2Erst
=
index 3eff3085=2E=2E32008d5 100644
--- a/doc/man-sections/advanced-options=
=2Erst
+++ b/doc/man-sections/advanced-options=2Erst
@@ -34,11 +34,15 @@
  =
 Valid syntax:
   ::
 
-     hash-size r v
+     hash-size r v [s]
 
-  By =
default, both tables are sized at 4 times ``--max-clients`` buckets=2E
+  B=
y default, all three tables are sized at 4 times ``--max-clients`` buckets=
=2E
   With the default of 1024 of ``--max-clients`` this gives 4096 bucket=
s=2E
 
+  If ``s`` is specified, the size of session id hash table is set
+=
  to ``s``=2E Otherwise the session id hash table will be set to the same
+=
  value as ``r``=2E
+
 --bcast-buffers n
   Allocate ``n`` buffers for broa=
dcast datagrams (default :code:`256`)=2E
 
diff --git a/src/openvpn/Makefil=
e=2Eam b/src/openvpn/Makefile=2Eam
index 7fd12b4=2E=2E7ecddff 100644
--- a/=
src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -130,6 +130,7 =
@@
 	schedule=2Ec schedule=2Eh \
 	session_id=2Ec session_id=2Eh \
 	shaper=
=2Ec shaper=2Eh \
+	sid_hash=2Eh \
 	sig=2Ec sig=2Eh \
 	siphash_reference=
=2Ec \
 	siphash=2Ec siphash=2Eh \
diff --git a/src/openvpn/mtcp=2Ec b/src/=
openvpn/mtcp=2Ec
index b0125f1=2E=2E4d173c4 100644
--- a/src/openvpn/mtcp=
=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -42,36 +42,12 @@
 {
     struct gc_arena=
 gc =3D gc_new();
     struct multi_instance *mi =3D NULL;
-    struct hash=
 *hash =3D m->hash;
 
     mi =3D multi_create_instance(m, NULL, sock);
   =
  if (mi)
     {
         mi->real=2Eproto =3D sock->info=2Eproto;
-       =
 struct hash_element *he;
-        const uint64_t hv =3D hash_value(hash, &=
mi->real);
-        struct hash_bucket *bucket =3D hash_bucket(hash, hv);
-=

         multi_assign_peer_id(m, mi);
-
-        he =3D hash_lookup_fast(h=
ash, bucket, &mi->real, hv);
-
-        if (he)
-        {
-            str=
uct multi_instance *oldmi =3D (struct multi_instance *)he->value;
-        =
    msg(D_MULTI_LOW,
-                "MULTI TCP: new incoming client addre=
ss matches existing client address -- new client takes precedence");
-     =
       oldmi->did_real_hash =3D false;
-            multi_close_instance(m,=
 oldmi, false);
-            he->key =3D &mi->real;
-            he->value =
=3D mi;
-        }
-        else
-        {
-            hash_add_fast(hash=
, bucket, &mi->real, hv, mi);
-        }
-
-        mi->did_real_hash =3D t=
rue;
     }
 
 #ifndef ENABLE_SMALL
diff --git a/src/openvpn/mudp=2Ec b/src=
/openvpn/mudp=2Ec
index 94e03d6=2E=2E69e30e5 100644
--- a/src/openvpn/mudp=
=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -32,6 +32,7 @@
 
 #include "memdbg=2Eh"
=
 #include "ssl_pkt=2Eh"
+#include "sid_hash=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY=
_H
 #include <sys/inotify=2Eh>
@@ -214,7 +215,7 @@
         }
         else=

         {
-            msg(D_MULTI_DEBUG,
+            msg(D_MULTI_MEDIUM=
,
                 "Valid packet (%s) with HMAC challenge from peer (%s), "=

                 "accepting new connection=2E",
                 packet_op=
code_name(op), peer);
@@ -253,7 +254,6 @@
         return NULL;
     }
 
- =
   struct hash *hash =3D m->hash;
     struct tls_pre_decrypt_state state =
=3D { 0 };
     struct multi_instance *mi =3D NULL;
 
@@ -275,11 +275,6 @@
=
             mi =3D multi_create_instance(m, real, sock);
             if (=
mi)
             {
-                const uint64_t hv =3D hash_value(hash, =
real);
-                struct hash_bucket *bucket =3D hash_bucket(hash, hv=
);
-                hash_add_fast(hash, bucket, &mi->real, hv, mi);
-
-    =
            mi->did_real_hash =3D true;
                 multi_assign_peer_=
id(m, mi);
 
                 struct tls_session *session =3D
@@ -287,11 +2=
82,11 @@
 
                 if (verdict =3D=3D PRE_DECRYPT_CREATE_SESSION_S=
KIP)
                 {
-                    /* This verdict is only possib=
le if we have a peer session ID */
                     ASSERT(session_id_d=
efined(&state=2Epeer_session_id));
                     mi->context=2Ec2=2E=
tls_multi->n_sessions++;
                     session_skip_to_pre_start(ses=
sion, &state, &m->top=2Ec2=2Efrom);
                 }
+                mul=
ti_hash_sid_add(m, &state=2Epeer_session_id, mi);
             }
         }=

         else
@@ -326,15 +321,27 @@
     return NULL;
 }
 
-struct multi_i=
nstance *
-multi_get_instance_udp_control(struct multi_context *m, struct l=
ink_socket *sock)
-{
-    struct mroute_addr real =3D { 0 };
-    real=2Epr=
oto =3D sock->info=2Eproto;
 
-    if (mroute_extract_openvpn_sockaddr(&rea=
l, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
+stati=
c struct multi_instance *
+multi_get_instance_udp_control(struct multi_cont=
ext *m)
+{
+    /* Copy buffer, to a tmp buffer, so that reading the sessio=
n does not
+     * modify the internal pointers */
+    struct buffer tmp =
=3D m->top=2Ec2=2Ebuf;
+
+    ASSERT(buf_len(&tmp) >=3D (int)(1 + SID_SIZE)=
);
+
+    /* op code */
+    buf_advance(&tmp, 1);
+
+    struct session_id=
 sid =3D { 0 };
+    session_id_read(&sid, &tmp);
+
+    const struct hash_=
element *he_sid =3D multi_hash_sid_lookup(m, &sid);
+
+    if (he_sid)
    =
 {
-        return multi_get_instance_udp_real(m, &real);
+        return h=
e_sid->value;
     }
 
     return NULL;
@@ -420,7 +427,14 @@
     }
     e=
lse
     {
-        mi =3D multi_get_instance_udp_control(m, sock);
+      =
  if (m->top=2Ec2=2Ebuf=2Elen < (int)SID_SIZE + 1)
+        {
+            =
/* control packets must be at least the opcode byte + session id
+         =
    * (8 byte) long, otherwise they are not valid packets */
+            r=
eturn NULL;
+        }
+
+        mi =3D multi_get_instance_udp_control(m);=

 
         /* we have no existing multi instance for this connection, cont=
rol
          * packets can create a session=2E Data packets cannot */
diff=
 --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 1cf2a21=2E=2Ed=
da9232 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4=
2,6 +42,7 @@
 #include "vlan=2Eh"
 #include "auth_token=2Eh"
 #include "rou=
te=2Eh"
+#include "sid_hash=2Eh"
 #include <inttypes=2Eh>
 #include <string=
=2Eh>
 
@@ -271,8 +272,8 @@
     struct multi_context *m =3D t->multi;
    =
 int dev =3D DEV_TYPE_UNDEF;
 
-    msg(D_MULTI_LOW, "MULTI: multi_init cal=
led, r=3D%u v=3D%u", t->options=2Ereal_hash_size,
-        t->options=2Evir=
tual_hash_size);
+    msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D%" PR=
Iu32 " v=3D%" PRIu32 " s=3D%" PRIu32,
+        t->options=2Ereal_hash_size,=
 t->options=2Evirtual_hash_size, t->options=2Esid_hash_size);
 
     /*
   =
   * Get tun/tap/null device type
@@ -300,6 +301,12 @@
     m->vhash =3D ha=
sh_init(t->options=2Evirtual_hash_size,
                          mroute_ad=
dr_hash_function, mroute_addr_compare_function);
 
+    /*
+     * Peer ses=
sion id hash table=2E Used to lookup a session by the session
+     * id of=
 one of its active sessions */
+    m->sid_hash =3D hash_init(t->options=2E=
sid_hash_size,
+                            session_id_hash_function, sessi=
on_id_hash_equal);
+
 #ifdef ENABLE_MANAGEMENT
     m->cid_hash =3D hash_in=
it(t->options=2Ereal_hash_size, cid_hash_function, cid_compare_function);
 =
#endif
@@ -427,8 +434,11 @@
             buf_printf(&out, "%s/", cn);
     =
    }
         buf_printf(&out, "%s", mroute_addr_print(&mi->real, gc));
- =
       if (mi->context=2Ec2=2Etls_multi && check_debug_level(D_DCO_DEBUG)
-=
            && dco_enabled(&mi->context=2Eoptions))
+
+        bool debug_r=
x_pid =3D (check_debug_level(D_DCO_DEBUG) && dco_enabled(&mi->context=2Eopt=
ions))
+                            || check_debug_level(D_MULTI_DEBUG);
+
=
+        if (mi->context=2Ec2=2Etls_multi && debug_rx_pid)
         {
     =
        buf_printf(&out, " rx-peer-id=3D%u", mi->context=2Ec2=2Etls_multi->=
rx_peer_id);
         }
@@ -595,6 +605,12 @@
         }
 #endif
 
+
+      =
  if (session_id_defined(&mi->sid_hashed_value))
+        {
+            mu=
lti_hash_sid_remove(m, &mi->sid_hashed_value);
+        }
+
         if (mi=
->context=2Ec2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
       =
      m->instances[mi->context=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
@@ -=
675,6 +691,7 @@
 
         hash_free(m->hash);
         hash_free(m->vhash)=
;
+        hash_free(m->sid_hash);
 #ifdef ENABLE_MANAGEMENT
         hash_=
free(m->cid_hash);
 #endif
@@ -2461,6 +2478,34 @@
     multi_client_connect=
_setenv(mi);
 }
 
+static bool
+multi_check_dest_addr_allowed(struct multi_=
context *m, struct multi_instance *mi, struct mroute_addr *real);
+
+/**
+ =
* This sets up the client real address (outer tunnel addr) in the
+ * hash =
map for data channel packet=2E If the address is already taken
+ * this ste=
ps fails
+ */
+static enum client_connect_return
+multi_client_connect_real=
_addr(struct multi_context *m, struct multi_instance *mi,
+                =
               bool deferred, uint64_t *option_types_found)
+{
+    /* If t=
he address is already taken up by another client we fail the new
+     * co=
nnection */
+    if (!multi_check_dest_addr_allowed(m, mi, &mi->real))
+   =
 {
+        msg(D_MULTI_ERRORS,
+            "MULTI: client IP address and =
port already assigned to another "
+            "client, terminating connec=
tion");
+        return CC_RET_FAILED;
+    }
+
+    ASSERT(!mi->did_real_h=
ash);
+    ASSERT(hash_add(m->hash, &mi->real, mi, false));
+    mi->did_re=
al_hash =3D true;
+    return CC_RET_SUCCEEDED;
+}
+
 /**
  *  Do the neces=
sary modification for doing the compress migrate=2E This is
  *  implemente=
d as a connect handler as it fits the modify config for a client
@@ -2555,6=
 +2600,7 @@
     uint64_t *option_types_found);
 
 static const multi_clien=
t_connect_handler client_connect_handlers[] =3D {
+    multi_client_connect=
_real_addr,
     multi_client_connect_compress_migrate,
     multi_client_c=
onnect_source_ccd,
     multi_client_connect_call_plugin_v1,
@@ -2623,6 +26=
69,7 @@
     }
     return true;
 }
+
 /*
  * Called as soon as the SSL/TLS=
 connection is authenticated=2E
  *
@@ -3109,7 +3156,7 @@
     /* do not al=
low if target address is taken by client with another cert */
     if (!cer=
t_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
     {
=
-        msg(D_MULTI_LOW, "Disallow float to an address taken by another cl=
ient %s",
+        msg(D_MULTI_LOW, "Disallow float/connect to an address t=
aken by another client %s",
             multi_instance_string(ex_mi, false=
, &gc));
 
         mi->context=2Ec2=2Ebuf=2Elen =3D 0;
@@ -3122,7 +3169,7 =
@@
         if (!m1->locked_username || !m2->locked_username
             |=
| strcmp(m1->locked_username, m2->locked_username) !=3D 0)
         {
-    =
        msg(D_MULTI_LOW, "Disallow float to an address taken by another cli=
ent %s",
+            msg(D_MULTI_LOW, "Disallow float/connect to an addres=
s taken by another client %s",
                 multi_instance_string(ex_mi=
, false, &gc));
             goto done;
         }
diff --git a/src/openvpn=
/multi=2Eh b/src/openvpn/multi=2Eh
index 7115b34=2E=2Ec424ad3 100644
--- a/=
src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -131,7 +131,15 @@
    =
 in_addr_t reporting_addr;            /* IP address shown in status listing=
 */
     struct in6_addr reporting_addr_ipv6; /* IPv6 address in status lis=
ting */
 
+    /** Indicates that the real address/port of the client is ha=
shed in
+     * the multi_context m->hash table=2E */
     bool did_real_ha=
sh;
+
+    /** If this is multi_instance is hashed in the sid lookup table =
the session
+     * id here is a non-null session id and the hash map's key=
 pointer points
+     * to this field (the value pointer points to the whol=
e struct) */
+    struct session_id sid_hashed_value;
+
 #ifdef ENABLE_MANA=
GEMENT
     bool did_cid_hash;
     struct buffer_list *cc_config;
@@ -170,=
6 +178,12 @@
                                         *   address of the re=
mote peer=2E */
     struct hash *vhash;                /**< VPN tunnel ins=
tances indexed by
                                         *   virtual addr=
ess of remote hosts=2E */
+    struct hash *sid_hash;             /**< TLS =
sessions indexed by the peer's
+                                           =
 session id=2E We do not care about
+                                      =
      collisions here as clients should
+                                  =
          have unique ids and supporting
+                                 =
           clients with identical SIDs
+                                   =
         is not needed */
     struct schedule *schedule;
     struct mbuf_=
set *mbuf;             /**< Set of buffers for passing data
               =
                          *   channel packets between VPN tunnel
diff --git=
 a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 5d10390=2E=2E60c=
2f5a 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ =
-3117,6 +3117,10 @@
     {
         o->virtual_hash_size =3D 4 * o->max_cli=
ents;
     }
+    if (!o->sid_hash_size)
+    {
+        o->sid_hash_size =
=3D o->real_hash_size;
+    }
 }
 
 static void
@@ -5955,7 +5959,7 @@
     =
    options->ifconfig_ipv6_pool_base =3D network;
         options->ifconfi=
g_ipv6_pool_netbits =3D netbits;
     }
-    else if (streq(p[0], "hash-siz=
e") && p[1] && p[2] && !p[3])
+    else if (streq(p[0], "hash-size") && p[1=
] && p[2] && !p[4])
     {
         int real, virtual;
 
@@ -5967,6 +5971,1=
6 @@
         }
         options->real_hash_size =3D (uint32_t)real;
      =
   options->virtual_hash_size =3D (uint32_t)virtual;
+
+        if (p[3])
+=
        {
+            int sid;
+            if (!atoi_constrained(p[3], &s=
id, "hash-size sid", 1, INT_MAX, msglevel))
+            {
+               =
 goto err;
+            }
+            options->sid_hash_size =3D (uint32_t=
)sid;
+        }
     }
     else if (streq(p[0], "connect-freq") && p[1] &=
& p[2] && !p[3])
     {
diff --git a/src/openvpn/options=2Eh b/src/openvpn/=
options=2Eh
index 31ae17b=2E=2Ed347830 100644
--- a/src/openvpn/options=2Eh=

+++ b/src/openvpn/options=2Eh
@@ -498,6 +498,7 @@
 
     uint32_t real_has=
h_size;
     uint32_t virtual_hash_size;
+    uint32_t sid_hash_size;
     =
const char *client_connect_script;
     const char *client_disconnect_scrip=
t;
     const char *learn_address_script;
diff --git a/src/openvpn/sid_hash=
=2Eh b/src/openvpn/sid_hash=2Eh
new file mode 100644
index 0000000=2E=2E528=
5ba4
--- /dev/null
+++ b/src/openvpn/sid_hash=2Eh
@@ -0,0 +1,94 @@
+/*
+ * =
 OpenVPN -- An application to securely tunnel IP networks
+ *             o=
ver a single TCP/UDP port, with support for SSL/TLS-based
+ *             s=
ession authentication and key exchange,
+ *             packet encryption, =
packet authentication, and
+ *             packet compression=2E
+ *
+ *  C=
opyright (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2026=
 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free softwa=
re; you can redistribute it and/or modify
+ *  it under the terms of the GN=
U General Public License version 2
+ *  as published by the Free Software F=
oundation=2E
+ *
+ *  This program is distributed in the hope that it will =
be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty=
 of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ =
*  GNU General Public License for more details=2E
+ *
+ *  You should have =
received a copy of the GNU General Public License along
+ *  with this prog=
ram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef SID=
_HASH_H
+#define SID_HASH_H
+
+#include "session_id=2Eh"
+#include "multi=
=2Eh"
+#include "list=2Eh"
+#include "siphash=2Eh"
+
+inline static void
+m=
ulti_hash_sid_add(struct multi_context *m, const struct session_id *sid,
+ =
                  struct multi_instance *mi)
+{
+    /* This must only be c=
alled if the multi instance is not already present
+     * in the hash tabl=
e */
+    ASSERT(!session_id_defined(&mi->sid_hashed_value));
+
+    mi->si=
d_hashed_value =3D *sid;
+
+    const uint64_t hv =3D hash_value(m->sid_has=
h, &mi->sid_hashed_value);
+    struct hash_bucket *bucket =3D hash_bucket(=
m->sid_hash, hv);
+    hash_add_fast(m->sid_hash, bucket, &mi->sid_hashed_v=
alue, hv, mi);
+    multi_instance_inc_refcount(mi);
+}
+
+static inline st=
ruct hash_element *
+multi_hash_sid_lookup(struct multi_context *m, const s=
truct session_id *sid)
+{
+    const uint64_t sid_hv =3D hash_value(m->sid_=
hash, sid);
+    struct hash_bucket *sid_bucket =3D hash_bucket(m->sid_hash=
, sid_hv);
+    struct hash_element *he_sid =3D hash_lookup_fast(m->sid_has=
h, sid_bucket, sid, sid_hv);
+    return he_sid;
+}
+
+inline static bool
+=
multi_hash_sid_remove(struct multi_context *m, const struct session_id *sid=
)
+{
+    const uint64_t sid_hv =3D hash_value(m->sid_hash, sid);
+    stru=
ct hash_bucket *sid_bucket =3D hash_bucket(m->sid_hash, sid_hv);
+    struc=
t hash_element *he_sid =3D hash_lookup_fast(m->sid_hash, sid_bucket, sid, s=
id_hv);
+    if (he_sid)
+    {
+        struct multi_instance *mi =3D he_s=
id->value;
+        ASSERT(hash_remove_fast(m->sid_hash, sid_bucket, sid, s=
id_hv));
+        CLEAR(mi->sid_hashed_value);
+        multi_instance_dec_=
refcount(mi);
+        return true;
+    }
+    else
+    {
+        return=
 false;
+    }
+}
+
+/* hashing the session=2E As the struct is just an 8 b=
yte array
+ * hashing is straight forward */
+static inline uint64_t
+sessi=
on_id_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
=
+{
+    return siphash_hash_func(key, sizeof(struct session_id), hash_key);=

+}
+
+/* wrapper for session_id_equal to have the void* arguments that the=

+ * hash map requires */
+static inline bool
+session_id_hash_equal(const =
void *sid1, const void *sid2)
+{
+    return session_id_equal((struct sessi=
on_id *)sid1, (struct session_id *)sid2);
+}
+
+#endif
diff --git a/tests/u=
nit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
in=
dex 5954902=2E=2E5430ecb 100644
--- a/tests/unit_tests/openvpn/Makefile=2Ea=
m
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -386,7 +386,8 @@
 	$(top_=
srcdir)/src/openvpn/otime=2Ec \
 	$(top_srcdir)/src/openvpn/schedule=2Ec \
=
 	$(top_srcdir)/src/openvpn/siphash=2Ec \
-	$(top_srcdir)/src/openvpn/sipha=
sh_reference=2Ec
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \
+	$(to=
p_srcdir)/src/openvpn/session_id=2Ec
 
 push_update_msg_testdriver_CFLAGS =
=3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git=
 a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_m=
isc=2Ec
index a41c27b=2E=2E052dea8 100644
--- a/tests/unit_tests/openvpn/te=
st_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -40,12 +40,12 @=
@
 #include "list=2Eh"
 #include "mock_msg=2Eh"
 #include "crypto=2Eh"
+#in=
clude "sid_hash=2Eh"
 #ifdef _WIN32
 #include "win32-util=2Eh"
 #endif
 #in=
clude "test_schedule=2Eh"
 
-
 static void
 test_compat_lzo_string(void **s=
tate)
 {
@@ -475,6 +475,65 @@
 }
 #endif /* _WIN32 */
 
+
+static void
+tes=
t_sid_hash_list(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+   =
 /* very simple tests to ensure the basic hash functions work */
+
+    str=
uct multi_context m =3D { 0 };
+    m=2Esid_hash =3D hash_init(2048, sessio=
n_id_hash_function, session_id_hash_equal);
+
+    struct session_id sid1;
=
+    struct session_id sid2;
+    struct session_id sid3;
+
+    struct mul=
ti_instance *m1, *m3;
+
+    /* multi_hash_sid_remove will call gc_free on =
the gc of a mi and
+     * free on the mi itself */
+    ALLOC_OBJ_CLEAR(m1=
, struct multi_instance);
+    ALLOC_OBJ_CLEAR(m3, struct multi_instance);
=
+
+    m1->gc =3D gc_new();
+    m3->gc =3D gc_new();
+
+    session_id_ran=
dom(&sid1);
+    session_id_random(&sid2);
+    session_id_random(&sid3);
+=

+    multi_hash_sid_add(&m, &sid1, m1);
+    multi_hash_sid_add(&m, &sid3,=
 m3);
+
+
+    /* sid2 is not added and should not be returned */
+    stru=
ct hash_element *he_sid =3D multi_hash_sid_lookup(&m, &sid2);
+    assert_n=
ull(he_sid);
+
+    he_sid =3D multi_hash_sid_lookup(&m, &sid1);
+    asser=
t_non_null(he_sid);
+    assert_ptr_equal(he_sid->value, m1);
+
+    /* Try=
 removing elements, only that are in the map should return true */
+    ass=
ert_true(multi_hash_sid_remove(&m, &sid1));
+    assert_false(multi_hash_si=
d_remove(&m, &sid2));
+    assert_false(multi_hash_sid_remove(&m, &sid1));
=
+
+    /* should no longer find the element */
+    he_sid =3D multi_hash_s=
id_lookup(&m, &sid1);
+    assert_null(he_sid);
+
+    /* this element shou=
ld still be in the hash table */
+    he_sid =3D multi_hash_sid_lookup(&m, =
&sid3);
+    assert_ptr_equal(he_sid->value, m3);
+
+    assert_true(multi_=
hash_sid_remove(&m, &sid3));
+
+    hash_free(m=2Esid_hash);
+    gc_free(&=
gc);
+}
+
 const struct CMUnitTest misc_tests[] =3D {
 #ifdef _WIN32
     c=
mocka_unit_test(test_win_path_in_dir),
@@ -485,7 +544,8 @@
     cmocka_unit=
_test(test_auth_fail_temp_flags_msg),
     cmocka_unit_test(test_list),
   =
  cmocka_unit_test(test_atoi_variants),
-    cmocka_unit_test(schedule_test=
)
+    cmocka_unit_test(schedule_test),
+    cmocka_unit_test(test_sid_hash=
_list)
 };
 
 int

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1727?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Number: 1727
Ger=
rit-PatchSet: 38
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--zUxR4NHPNJw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #38</strong> to the change originally created by Arn=
e Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
27?usp=3Demail">View Change</a></p><p>The following approvals got outdated =
and were removed:
Code-Review+2 by Antonio Quartulli</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Add l=
ookup of multi session by session id<br><br>This refactors the way that we =
lookup control channel packets for UDP<br>packets from other peers=2E Inste=
ad of looking them up by their source<br>IP address, we lookup the session =
ids instead=2E<br><br>It also has the consequence that we can have multiple=
 ongoing<br>sessions from the same source IP address and the new session wi=
ll<br>go through all the connect steps like an initial session=2E<br><br>Th=
e check if the new session can take over the old session&#39;s IP<br>is now=
 also the same as for floating=2E<br><br>This eliminates a whole class of b=
ugs that we currently have that<br>break connection if the reconnecting cli=
ent has different<br>capabilities as the setup and negotiation is inherited=
 from the<br>previous client currently=2E Currently there is at least one b=
ug<br>regarding the dynamic tls-crypt in this situation=2E<br><br>This also=
 changes the user visible behaviour for clients<br>reconnecting from the sa=
me IP and port=2E They are now almost<br>behaving like clients that reconne=
ct from a different IP<br>address=2E These now do the whole renegotiation a=
nd run<br>connect scripts/plugins and all the things are normally<br>skippe=
d when reconnecting from the same IP and port=2E<br><br>The only difference=
 is that duplicate-cn does not<br>allow both connection=2E<br><br>This will=
 also eventually allow us to get rid of TM_INITIAL<br>slot as we now do no =
longer need to keep an ongoing and a<br>new session anymore=2E Currently th=
e p2p mode still needs<br>the extra session slot for the new session so we =
cannot<br>remove it just yet=2E<br><br>This now allows a multiple pending s=
ession from the<br>same source IP and port=2E Previously a client would nee=
d<br>to use a different ports to create multiple pending<br>session=2E This=
 change does not make it really easier to<br>exhaust all pending session th=
an before=2E<br><br>This makes the theoretically easier to create more sess=
ion<br>on the server since you no longer need distinct source ports<br>per =
sessions but using different source ports is not<br>meaningfully harder tha=
n using the same source port=2E<br><br>This also removes hashing TCP connec=
tions by their source IP<br>address=2E We do not look up TCP session by the=
ir source but rather<br>just identify by their socket=2E<br><br>This also r=
emoves the code for the weird edge case from TCP<br>where connections when =
a new connection from the same IP/port<br>is connecting=2E This code is pre=
 multi-socket and it is unclear<br>if there was ever a way to have a TCP co=
nnection from an<br>identical IP/port without the old socket being closed f=
irst=2E<br><br>Change-Id: Idb59ecd119331b198792ad1379bec8600211651b<br>Sign=
ed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Antonio Qua=
rtulli &lt;antonio@mandelbit=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1727<br>Message-Id: &lt;20261009101429=2E10505-1-gert=
@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg39817=2Ehtml<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man=
-sections/advanced-options=2Erst<br>M src/openvpn/Makefile=2Eam<br>M src/op=
envpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M sr=
c/openvpn/multi=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=
=2Eh<br>A src/openvpn/sid_hash=2Eh<br>M tests/unit_tests/openvpn/Makefile=
=2Eam<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>12 files changed, 279 =
insertions(+), 52 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/1727/38</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 2d9b546=2E=
=2Ebac4dd4 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>++=
+ b/CMakeLists=2Etxt</span><br><span>@@ -862,6 +862,7 @@</span><br><span>  =
       src/openvpn/siphash=2Eh</span><br><span>         src/openvpn/siphash=
=2Ec</span><br><span>         src/openvpn/siphash_reference=2Ec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/session_id=
=2Ec</span><br><span>     )</span><br><span> </span><br><span>     target_s=
ources(test_ncp PRIVATE</span><br><span>diff --git a/doc/man-sections/advan=
ced-options=2Erst b/doc/man-sections/advanced-options=2Erst</span><br><span=
>index 3eff3085=2E=2E32008d5 100644</span><br><span>--- a/doc/man-sections/=
advanced-options=2Erst</span><br><span>+++ b/doc/man-sections/advanced-opti=
ons=2Erst</span><br><span>@@ -34,11 +34,15 @@</span><br><span>   Valid synt=
ax:</span><br><span>   ::</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-     hash-size r v</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     hash-size r v [s]</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  By default, both tables are sized=
 at 4 times ``--max-clients`` buckets=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  By default, all three tables are sized at 4 times ``=
--max-clients`` buckets=2E</span><br><span>   With the default of 1024 of `=
`--max-clients`` this gives 4096 buckets=2E</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  If ``s`` is specified, the size=
 of session id hash table is set</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  to ``s``=2E Otherwise the session id hash table will be set =
to the same</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  value =
as ``r``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> --bcast-buffers n</span><br><span>   Allocate ``n`` buffers for b=
roadcast datagrams (default :code:`256`)=2E</span><br><span> </span><br><sp=
an>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span=
><br><span>index 7fd12b4=2E=2E7ecddff 100644</span><br><span>--- a/src/open=
vpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br=
><span>@@ -130,6 +130,7 @@</span><br><span> 	schedule=2Ec schedule=2Eh \</s=
pan><br><span> 	session_id=2Ec session_id=2Eh \</span><br><span> 	shaper=2E=
c shaper=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	sid_=
hash=2Eh \</span><br><span> 	sig=2Ec sig=2Eh \</span><br><span> 	siphash_re=
ference=2Ec \</span><br><span> 	siphash=2Ec siphash=2Eh \</span><br><span>d=
iff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>ind=
ex b0125f1=2E=2E4d173c4 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</=
span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -42,36 +42,12 =
@@</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();=
</span><br><span>     struct multi_instance *mi =3D NULL;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</=
span><br><span> </span><br><span>     mi =3D multi_create_instance(m, NULL,=
 sock);</span><br><span>     if (mi)</span><br><span>     {</span><br><span=
>         mi-&gt;real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        struct hash_element *he;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        const uint64_t hv =3D=
 hash_value(hash, &amp;mi-&gt;real);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        struct hash_bucket *bucket =3D hash_bucket(hash, hv)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>   =
      multi_assign_peer_id(m, mi);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
he =3D hash_lookup_fast(hash, bucket, &amp;mi-&gt;real, hv);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (he)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            struct multi_instance *oldmi =3D (struct multi_instance *)he-&g=
t;value;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
sg(D_MULTI_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          &quot;MULTI TCP: new incoming client address matches existing cli=
ent address -- new client takes precedence&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            oldmi-&gt;did_real_hash =3D false;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_clo=
se_instance(m, oldmi, false);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            he-&gt;key =3D &amp;mi-&gt;real;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            he-&gt;value =3D mi;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        mi-&gt;did_real_hash =3D true;</span><br><sp=
an>     }</span><br><span> </span><br><span> #ifndef ENABLE_SMALL</span><br=
><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><=
span>index 94e03d6=2E=2E69e30e5 100644</span><br><span>--- a/src/openvpn/mu=
dp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -32,6 =
+32,7 @@</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;=
</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;sid_hash=2Eh&quot;</span><br>=
<span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><span> #includ=
e &lt;sys/inotify=2Eh&gt;</span><br><span>@@ -214,7 +215,7 @@</span><br><sp=
an>         }</span><br><span>         else</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI_DE=
BUG,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(D_MULTI_MEDIUM,</span><br><span>                 &quot;Valid packet (%s) w=
ith HMAC challenge from peer (%s), &quot;</span><br><span>                 =
&quot;accepting new connection=2E&quot;,</span><br><span>                 p=
acket_opcode_name(op), peer);</span><br><span>@@ -253,7 +254,6 @@</span><br=
><span>         return NULL;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =3D m=
-&gt;hash;</span><br><span>     struct tls_pre_decrypt_state state =3D { 0 =
};</span><br><span>     struct multi_instance *mi =3D NULL;</span><br><span=
> </span><br><span>@@ -275,11 +275,6 @@</span><br><span>             mi =3D=
 multi_create_instance(m, real, sock);</span><br><span>             if (mi)=
</span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                const uint64_t hv =3D hash_value(hash, real);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                struct ha=
sh_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                hash_add_fast(hash, bucket, &amp;mi-=
&gt;real, hv, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                mi-&gt;d=
id_real_hash =3D true;</span><br><span>                 multi_assign_peer_i=
d(m, mi);</span><br><span> </span><br><span>                 struct tls_ses=
sion *session =3D</span><br><span>@@ -287,11 +282,11 @@</span><br><span> </=
span><br><span>                 if (verdict =3D=3D PRE_DECRYPT_CREATE_SESSI=
ON_SKIP)</span><br><span>                 {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    /* This verdict is only possible =
if we have a peer session ID */</span><br><span>                     ASSERT=
(session_id_defined(&amp;state=2Epeer_session_id));</span><br><span>       =
              mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions++;</span><br><=
span>                     session_skip_to_pre_start(session, &amp;state, &a=
mp;m-&gt;top=2Ec2=2Efrom);</span><br><span>                 }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                multi_hash_sid_ad=
d(m, &amp;state=2Epeer_session_id, mi);</span><br><span>             }</spa=
n><br><span>         }</span><br><span>         else</span><br><span>@@ -32=
6,15 +321,27 @@</span><br><span>     return NULL;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct mul=
ti_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_ge=
t_instance_udp_control(struct multi_context *m, struct link_socket *sock)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct mroute_addr real =3D { 0 };</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    real=2Eproto =3D sock-=
&gt;info=2Eproto;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt=
;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct mult=
i_instance *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_g=
et_instance_udp_control(struct multi_context *m)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* Copy buffer, to a tmp buffer, so that reading the session=
 does not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * mod=
ify the internal pointers */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer tmp =3D m-&gt;top=2Ec2=2Ebuf;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ASSERT(buf_len(&amp;tmp) &gt;=3D (int)(1 + SID_SIZE))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* op code */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    buf_advance(&amp;tmp, 1);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct session_id sid =3D { 0 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    session_id_read(&amp;sid, &=
amp;tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const struct hash_element=
 *he_sid =3D multi_hash_sid_lookup(m, &amp;sid);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (he_sid)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return multi_get_instance_udp_real(m, &a=
mp;real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn he_sid-&gt;value;</span><br><span>     }</span><br><span> </span><br><=
span>     return NULL;</span><br><span>@@ -420,7 +427,14 @@</span><br><span=
>     }</span><br><span>     else</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        mi =3D multi_get_instance_udp_co=
ntrol(m, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (m-&gt;top=2Ec2=2Ebuf=2Elen &lt; (int)SID_SIZE + 1)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            /* control packets must be at leas=
t the opcode byte + session id</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+             * (8 byte) long, otherwise they are not valid packe=
ts */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        mi =3D multi_get_instance_udp_=
control(m);</span><br><span> </span><br><span>         /* we have no existi=
ng multi instance for this connection, control</span><br><span>          * =
packets can create a session=2E Data packets cannot */</span><br><span>diff=
 --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>inde=
x 1cf2a21=2E=2Edda9232 100644</span><br><span>--- a/src/openvpn/multi=2Ec</=
span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -42,6 +42,7 @=
@</span><br><span> #include &quot;vlan=2Eh&quot;</span><br><span> #include =
&quot;auth_token=2Eh&quot;</span><br><span> #include &quot;route=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sid_h=
ash=2Eh&quot;</span><br><span> #include &lt;inttypes=2Eh&gt;</span><br><spa=
n> #include &lt;string=2Eh&gt;</span><br><span> </span><br><span>@@ -271,8 =
+272,8 @@</span><br><span>     struct multi_context *m =3D t-&gt;multi;</sp=
an><br><span>     int dev =3D DEV_TYPE_UNDEF;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_MULTI_LOW, &quot;MULTI:=
 multi_init called, r=3D%u v=3D%u&quot;, t-&gt;options=2Ereal_hash_size,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        t-&gt;options=2E=
virtual_hash_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    msg(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%&quot; PRIu32 &qu=
ot; v=3D%&quot; PRIu32 &quot; s=3D%&quot; PRIu32,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        t-&gt;options=2Ereal_hash_size, t-&gt=
;options=2Evirtual_hash_size, t-&gt;options=2Esid_hash_size);</span><br><sp=
an> </span><br><span>     /*</span><br><span>      * Get tun/tap/null devic=
e type</span><br><span>@@ -300,6 +301,12 @@</span><br><span>     m-&gt;vhas=
h =3D hash_init(t-&gt;options=2Evirtual_hash_size,</span><br><span>        =
                  mroute_addr_hash_function, mroute_addr_compare_function);=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Peer se=
ssion id hash table=2E Used to lookup a session by the session</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * id of one of its active s=
essions */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt=
;sid_hash =3D hash_init(t-&gt;options=2Esid_hash_size,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                            session_id_h=
ash_function, session_id_hash_equal);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><spa=
n>     m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_size, cid_has=
h_function, cid_compare_function);</span><br><span> #endif</span><br><span>=
@@ -427,8 +434,11 @@</span><br><span>             buf_printf(&amp;out, &quo=
t;%s/&quot;, cn);</span><br><span>         }</span><br><span>         buf_p=
rintf(&amp;out, &quot;%s&quot;, mroute_addr_print(&amp;mi-&gt;real, gc));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;cont=
ext=2Ec2=2Etls_multi &amp;&amp; check_debug_level(D_DCO_DEBUG)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; dco_enabled=
(&amp;mi-&gt;context=2Eoptions))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  bool debug_rx_pid =3D (check_debug_level(D_DCO_DEBUG) &amp;&amp; dco_enab=
led(&amp;mi-&gt;context=2Eoptions))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                            || check_debug_level(D_MULTI_DE=
BUG);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (mi-&gt;context=2Ec2=
=2Etls_multi &amp;&amp; debug_rx_pid)</span><br><span>         {</span><br>=
<span>             buf_printf(&amp;out, &quot; rx-peer-id=3D%u&quot;, mi-&g=
t;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span>         }</spa=
n><br><span>@@ -595,6 +605,12 @@</span><br><span>         }</span><br><span=
> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
session_id_defined(&amp;mi-&gt;sid_hashed_value))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            multi_hash_sid_remove(m, &amp;mi-&gt;sid_ha=
shed_value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
         if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_I=
D)</span><br><span>         {</span><br><span>             m-&gt;instances[=
mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NULL;</span><br><span>@=
@ -675,6 +691,7 @@</span><br><span> </span><br><span>         hash_free(m-&=
gt;hash);</span><br><span>         hash_free(m-&gt;vhash);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        hash_free(m-&gt;sid_hash);</=
span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>         hash_free=
(m-&gt;cid_hash);</span><br><span> #endif</span><br><span>@@ -2461,6 +2478,=
34 @@</span><br><span>     multi_client_connect_setenv(mi);</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_=
check_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi,=
 struct mroute_addr *real);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * This sets up the client =
real address (outer tunnel addr) in the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * hash map for data channel packet=2E If the address i=
s already taken</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * t=
his steps fails</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static enum client_c=
onnect_return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_=
client_connect_real_addr(struct multi_context *m, struct multi_instance *mi=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
             bool deferred, uint64_t *option_types_found)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* If the address is already taken up by another cl=
ient we fail the new</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * connection */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!multi_check_dest_addr_allowed(m, mi, &amp;mi-&gt;real))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_ERRORS,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            &quot;MULTI: client I=
P address and port already assigned to another &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;client, terminating con=
nection&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return CC_RET_FAILED;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!mi-&gt;did_real=
_hash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(h=
ash_add(m-&gt;hash, &amp;mi-&gt;real, mi, false));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    mi-&gt;did_real_hash =3D true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return CC_RET_SUCCEEDED;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>=
  *  Do the necessary modification for doing the compress migrate=2E This i=
s</span><br><span>  *  implemented as a connect handler as it fits the modi=
fy config for a client</span><br><span>@@ -2555,6 +2600,7 @@</span><br><spa=
n>     uint64_t *option_types_found);</span><br><span> </span><br><span> st=
atic const multi_client_connect_handler client_connect_handlers[] =3D {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_client_connec=
t_real_addr,</span><br><span>     multi_client_connect_compress_migrate,</s=
pan><br><span>     multi_client_connect_source_ccd,</span><br><span>     mu=
lti_client_connect_call_plugin_v1,</span><br><span>@@ -2623,6 +2669,7 @@</s=
pan><br><span>     }</span><br><span>     return true;</span><br><span> }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*<=
/span><br><span>  * Called as soon as the SSL/TLS connection is authenticat=
ed=2E</span><br><span>  *</span><br><span>@@ -3109,7 +3156,7 @@</span><br><=
span>     /* do not allow if target address is taken by client with another=
 cert */</span><br><span>     if (!cert_hash_compare(m1-&gt;locked_cert_has=
h_set, m2-&gt;locked_cert_hash_set))</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_LOW, &quot;Disall=
ow float to an address taken by another client %s&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;Disallo=
w float/connect to an address taken by another client %s&quot;,</span><br><=
span>             multi_instance_string(ex_mi, false, &amp;gc));</span><br>=
<span> </span><br><span>         mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</sp=
an><br><span>@@ -3122,7 +3169,7 @@</span><br><span>         if (!m1-&gt;loc=
ked_username || !m2-&gt;locked_username</span><br><span>             || str=
cmp(m1-&gt;locked_username, m2-&gt;locked_username) !=3D 0)</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(D_MULTI_LOW, &quot;Disallow float to an address taken by another clie=
nt %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(D_MULTI_LOW, &quot;Disallow float/connect to an address taken by a=
nother client %s&quot;,</span><br><span>                 multi_instance_str=
ing(ex_mi, false, &amp;gc));</span><br><span>             goto done;</span>=
<br><span>         }</span><br><span>diff --git a/src/openvpn/multi=2Eh b/s=
rc/openvpn/multi=2Eh</span><br><span>index 7115b34=2E=2Ec424ad3 100644</spa=
n><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/m=
ulti=2Eh</span><br><span>@@ -131,7 +131,15 @@</span><br><span>     in_addr_=
t reporting_addr;            /* IP address shown in status listing */</span=
><br><span>     struct in6_addr reporting_addr_ipv6; /* IPv6 address in sta=
tus listing */</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /** Indicates that the real address/port of the client is =
hashed in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the=
 multi_context m-&gt;hash table=2E */</span><br><span>     bool did_real_ha=
sh;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /** If this is multi_instance i=
s hashed in the sid lookup table the session</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * id here is a non-null session id and the ha=
sh map&#39;s key pointer points</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * to this field (the value pointer points to the whole str=
uct) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct s=
ession_id sid_hashed_value;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     boo=
l did_cid_hash;</span><br><span>     struct buffer_list *cc_config;</span><=
br><span>@@ -170,6 +178,12 @@</span><br><span>                             =
            *   address of the remote peer=2E */</span><br><span>     struc=
t hash *vhash;                /**&lt; VPN tunnel instances indexed by</span=
><br><span>                                         *   virtual address of =
remote hosts=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct hash *sid_hash;             /**&lt; TLS sessions indexed by the p=
eer&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                  session id=2E We do not care about</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
                  collisions here as clients should</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
   have unique ids and supporting</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                            clients with iden=
tical SIDs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                   is not needed */</span><br><span>     st=
ruct schedule *schedule;</span><br><span>     struct mbuf_set *mbuf;       =
      /**&lt; Set of buffers for passing data</span><br><span>             =
                            *   channel packets between VPN tunnel</span><b=
r><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</spa=
n><br><span>index 5d10390=2E=2E60c2f5a 100644</span><br><span>--- a/src/ope=
nvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><s=
pan>@@ -3117,6 +3117,10 @@</span><br><span>     {</span><br><span>         =
o-&gt;virtual_hash_size =3D 4 * o-&gt;max_clients;</span><br><span>     }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;sid_ha=
sh_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;sid_hash_si=
ze =3D o-&gt;real_hash_size;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span> }</span><br><span> </span><br><span> static=
 void</span><br><span>@@ -5955,7 +5959,7 @@</span><br><span>         option=
s-&gt;ifconfig_ipv6_pool_base =3D network;</span><br><span>         options=
-&gt;ifconfig_ipv6_pool_netbits =3D netbits;</span><br><span>     }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quo=
t;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &=
quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</sp=
an><br><span>     {</span><br><span>         int real, virtual;</span><br><=
span> </span><br><span>@@ -5967,6 +5971,16 @@</span><br><span>         }</s=
pan><br><span>         options-&gt;real_hash_size =3D (uint32_t)real;</span=
><br><span>         options-&gt;virtual_hash_size =3D (uint32_t)virtual;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (p[3])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            int sid;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (!atoi_constrained(p[3], &amp;sid, =
&quot;hash-size sid&quot;, 1, INT_MAX, msglevel))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                goto err;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            options-&gt;sid_hash_size =3D (uint32_t=
)sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span>     }</span><br><span>     else if (streq(p[0], &quot;connect-=
freq&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><sp=
an>     {</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvp=
n/options=2Eh</span><br><span>index 31ae17b=2E=2Ed347830 100644</span><br><=
span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/option=
s=2Eh</span><br><span>@@ -498,6 +498,7 @@</span><br><span> </span><br><span=
>     uint32_t real_hash_size;</span><br><span>     uint32_t virtual_hash_s=
ize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t si=
d_hash_size;</span><br><span>     const char *client_connect_script;</span>=
<br><span>     const char *client_disconnect_script;</span><br><span>     c=
onst char *learn_address_script;</span><br><span>diff --git a/src/openvpn/s=
id_hash=2Eh b/src/openvpn/sid_hash=2Eh</span><br><span>new file mode 100644=
</span><br><span>index 0000000=2E=2E5285ba4</span><br><span>--- /dev/null</=
span><br><span>+++ b/src/openvpn/sid_hash=2Eh</span><br><span>@@ -0,0 +1,94=
 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to =
securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             over a single TCP/UDP port, with support for SSL/TLS=
-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  session authentication and key exchange,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             packet encryption, packet authenticat=
ion, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrig=
ht (C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;a=
rne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softwar=
e; you can redistribute it and/or modify</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licen=
se version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as =
published by the Free Software Foundation=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is distributed in the hope that it will be useful,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef SID_HASH_H</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define SID_HASH_H</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;session_id=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;list=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+inline static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_add(struct multi_context *=
m, const struct session_id *sid,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                   struct multi_instance *mi)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* This must only be called if the multi instance =
is not already present</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * in the hash table */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ASSERT(!session_id_defined(&amp;mi-&gt;sid_hashed_value));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;sid_hashed_value =3D *sid;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(m-&g=
t;sid_hash, &amp;mi-&gt;sid_hashed_value);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct hash_bucket *bucket =3D hash_bucket(m-&gt=
;sid_hash, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
hash_add_fast(m-&gt;sid_hash, bucket, &amp;mi-&gt;sid_hashed_value, hv, mi)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_instance=
_inc_refcount(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static inline struct hash_element *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_lookup(=
struct multi_context *m, const struct session_id *sid)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const uint64_t sid_hv =3D hash_value(m-&gt;sid_hash, s=
id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash=
_bucket *sid_bucket =3D hash_bucket(m-&gt;sid_hash, sid_hv);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *he_sid =
=3D hash_lookup_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return he_sid;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+inline static bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+multi_hash_sid_remove(struct multi_context *m, const struct session_id =
*sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t sid_hv =3D ha=
sh_value(m-&gt;sid_hash, sid);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct hash_bucket *sid_bucket =3D hash_bucket(m-&gt;sid_has=
h, sid_hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct hash_element *he_sid =3D hash_lookup_fast(m-&gt;sid_hash, sid_bucket, si=
d, sid_hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
he_sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct multi_insta=
nce *mi =3D he_sid-&gt;value;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        ASSERT(hash_remove_fast(m-&gt;sid_hash, sid_bucket, sid, =
sid_hv));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CL=
EAR(mi-&gt;sid_hashed_value);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        multi_instance_dec_refcount(mi);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* hashing the session=2E As the struct is just an 8 b=
yte array</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hashing=
 is straight forward */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static inline uint64_t</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+session_id_hash_function(const void *key, const uint8_t hash_key[HAS=
H_KEY_LEN])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return siphash_hash_fu=
nc(key, sizeof(struct session_id), hash_key);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* wrapper =
for session_id_equal to have the void* arguments that the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * hash map requires */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+session_id_hash_equal(const void *=
sid1, const void *sid2)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ses=
sion_id_equal((struct session_id *)sid1, (struct session_id *)sid2);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_tests/openvpn/Ma=
kefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index =
5954902=2E=2E5430ecb 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam<=
/span><br><span>@@ -386,7 +386,8 @@</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/otime=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/schedule=2Ec \=
</span><br><span> 	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/siphash_ref=
erence=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_sr=
cdir)/src/openvpn/siphash_reference=2Ec \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/session_id=2Ec</span><br><=
span> </span><br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdi=
r)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \</span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests=
/openvpn/test_misc=2Ec</span><br><span>index a41c27b=2E=2E052dea8 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -40,12 +40,=
12 @@</span><br><span> #include &quot;list=2Eh&quot;</span><br><span> #incl=
ude &quot;mock_msg=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;si=
d_hash=2Eh&quot;</span><br><span> #ifdef _WIN32</span><br><span> #include &=
quot;win32-util=2Eh&quot;</span><br><span> #endif</span><br><span> #include=
 &quot;test_schedule=2Eh&quot;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> t=
est_compat_lzo_string(void **state)</span><br><span> {</span><br><span>@@ -=
475,6 +475,65 @@</span><br><span> }</span><br><span> #endif /* _WIN32 */</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+test_sid_hash_list(void **state=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* very simple =
tests to ensure the basic hash functions work */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct multi_context m =3D { 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    m=2Esid_hash =3D hash_init(2048, session_id=
_hash_function, session_id_hash_equal);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct session_id sid1;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct session_id sid2;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct session_id sid3;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct multi_instance *m1, *m3;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* multi_hash_sid_remove will call gc_free on the gc of a mi and</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * free on the mi i=
tself */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_O=
BJ_CLEAR(m1, struct multi_instance);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ALLOC_OBJ_CLEAR(m3, struct multi_instance);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    m1-&gt;gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    m3-&gt;gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    session_id_random(&amp;sid1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&amp;sid2);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&a=
mp;sid3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    multi_hash_sid_add(&amp;m=
, &amp;sid1, m1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  multi_hash_sid_add(&amp;m, &amp;sid3, m3);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* sid2 i=
s not added and should not be returned */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct hash_element *he_sid =3D multi_hash_sid_lo=
okup(&amp;m, &amp;sid2);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_null(he_sid);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    he_si=
d =3D multi_hash_sid_lookup(&amp;m, &amp;sid1);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_non_null(he_sid);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(he_sid-&gt;value,=
 m1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* Try removing elements, onl=
y that are in the map should return true */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(multi_hash_sid_remove(&amp;m, &amp;=
sid1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_f=
alse(multi_hash_sid_remove(&amp;m, &amp;sid2));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_false(multi_hash_sid_remove(&amp;m, =
&amp;sid1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* should no longer fi=
nd the element */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_null(he_sid);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* this element should still be in the hash table =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    he_sid =3D mu=
lti_hash_sid_lookup(&amp;m, &amp;sid3);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_ptr_equal(he_sid-&gt;value, m3);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(multi_hash_sid_remove(&amp;m, &amp=
;sid3));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    hash_free(m=2Esid_hash);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const struct CMUnit=
Test misc_tests[] =3D {</span><br><span> #ifdef _WIN32</span><br><span>    =
 cmocka_unit_test(test_win_path_in_dir),</span><br><span>@@ -485,7 +544,8 @=
@</span><br><span>     cmocka_unit_test(test_auth_fail_temp_flags_msg),</sp=
an><br><span>     cmocka_unit_test(test_list),</span><br><span>     cmocka_=
unit_test(test_atoi_variants),</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    cmocka_unit_test(schedule_test)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    cmocka_unit_test(schedule_test),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_sid_has=
h_list)</span><br><span> };</span><br><span> </span><br><span> int</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1727?usp=3Demail">change 1727</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec86002116=
51b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1727 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 38 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;anto=
nio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--zUxR4NHPNJw=--


--===============6607750794576426327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6607750794576426327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6607750794576426327==--

