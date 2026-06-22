Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770D9CD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ICuNRpiDmwchVZbnFiLTYZ3tXFv0ateJNU/vcJVjyB8=; b=UAeMh0+sQaub0wHWo93HoxZ8dP
	Q/gWnh2+4lMbOvHkNbaecahF7se7AfbRWztka3mpZPAhd0wiM5wLyLpJWWdj3KPrTS+fnN9FUmMgq
	K3tbogGUCAQAA9lpYpSNx6g+QaK6r1SIvSAKWxA0snKtxGZFm7+H5Vd+lxWrBsujdZsg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgcl-0001XN-Ei;
	Mon, 22 Jun 2026 15:31:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgci-0001XC-Tx
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:31:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=n6V0+Js7s9d9kfuta3k7EDdMyY1F4IiX88zSGhlv6uU=; b=Mw525HmcaXtPcBL08vg6/zGd4b
 VGWIMi9cU5LAVoSJYBpLFvTkADb8WeE56pvq/dZi2k/0KBXjEJgYHKe4CtJwAb+S+Q/XMKZQr8jTM
 uIK1DVQ5yItmQsytftXmRhfHRJfDp2RD/uLCx6X3tJ/NwBpOitxBvqujuiaCUisQUEE4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=n6V0+Js7s9d9kfuta3k7EDdMyY1F4IiX88zSGhlv6uU=; b=Z
 czYJx5quyeLau+FZwvpSeAIYsJphzeWo7cj0oFyx3i2o4fTO9xlziMUeFbO554mSUZBa2WDJEOE19
 9z4zDvpQK2R7KYRenVAuXIQ99cHCltURyiTHmk5oCsskq9ptladF2zxWj1os0UmhEd+1qPTEI1hZp
 5bfKMBxmM0GJm/Y4=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgcc-0007np-PN for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:31:42 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso2730391f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782142288; x=1782747088; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n6V0+Js7s9d9kfuta3k7EDdMyY1F4IiX88zSGhlv6uU=;
 b=NeVi9ZCNxFrgeJqA8A2NAYQh/FQKT7AiBpv6h1+/cMzlfLz504SpAVXsrcaUmmhVna
 L+s83J/2NdpEPmbwmEfngDzUREyjZKRyu/CHteykxesNupFZfTBfkx8GnaH+IifE51WF
 CfKnWIxYg5ozmInvJWaqu/tROBOcfsc+o1rEhJ75vPJvSYTUPF810kOftQCgUXDBH1v3
 +RcIAni2+ow8eZl5pAf2Fja9Dh5KXblQk22py/ab8dsRMiDI25NgLc3J3EG2LrfsPeGB
 W4MaOHvMqU8neI1+Bt+8GJev05Wy7YD+ieoIULvkB4j4gN2fpCYSA/AEN1mCGzxy7jC6
 yj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142288; x=1782747088;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n6V0+Js7s9d9kfuta3k7EDdMyY1F4IiX88zSGhlv6uU=;
 b=emWm650XtrL7V/GQAertAfJ6L+edlSQ9GB/iWplkze68ucQCP5B0l7w4f5E86Q143i
 8Hbu8Lxf4ba+PeG1LbvMI+rVQahY4q4AkWEiO7PEG/t3+9NNkRBl36fqpTiEak6Ew7Cb
 0eYBzsBi02N6hFtwWAS643QSE3Y/2B4RMwqu/NSw/0q8SvwiTe5DY1VKmqP32p+w6zJn
 Z5Oe5cDnx/B8UA8urOZoEn30VvAOjkWGK6/sZGzYHyvU7VYr35c264tURLj2Nxxzc5BB
 ZJl5F4nw5uw4kXnZJ7wI9o/IpVksFr4zLxTDHW2zqUR0/UrYJZMZMwrLK5vKY/BE5u7e
 kSDQ==
X-Gm-Message-State: AOJu0Yxiu4u/SnVi1B0uWRsuGcu2b9PXmh2Dxo5DOohpU/iuUVhd4bEO
 8P2zb2yL3DnAl5HHDacqbOyq5sU+xFizYsDNzOjqLJJ/IGBF1R1kIfiniXkLtTGJUSNx0AevvSY
 4uNt5Ym6Y/VOaGGjKd9glGuVl2EWJ2zAJS//Ercqa159M52HK5pJqjlYBqsteFPQH+bwRGsMnBp
 5avsZOyg==
X-Gm-Gg: AfdE7ckxopZ9rPjizQKz5LJuGUaJnLsC5XJ51barX5dPc9sdKEDMDM445GJOonwnp+Z
 F6VQot/64NAppNS31/rpBRlnTY4MS8kk63cbc7BsUvcOkk3w/pC9O4QCriHUCnQJ6hsoB+cM0Qj
 bo1qu+KhcA0V3GISjFt1YwZww7FytyOeD1ktYFeOGe0zlrfN4JY21ZB3XAUc4CQErplOIuYkRQm
 d20XtezEtjzqzOtGhUZ6/nyL0jMNVzEii/L4xl9YoX2QQ9SxKxHKA6jra67DVp6+w/5858qHPRx
 VLZro8cn/F77KriuYlyKil4OBR2xIHS/QzBorRRwp21QMvzaVtOTJpT+OvCNqNZOTQlTal9gcWd
 eGUyt5WcDCjxS3P36/DtxBsMVTOPZRdYb6cc02/nt5nI+CZZipTyWSn7TzB5P0/H1X/tHBuUtrf
 r5NCkbSaB8tiYEA9vDfL8ciEtq6UqKFiqM3gt/UYFMdtyLIQYd14z6ixNcCS14EUPgKgH3zZNuL
 nuoRtMmzgOM3JTvMJAkYASgHXI3KRZMq6SR2mo8+a1e3mK5jKJrESfRX5sBAjzc7owuHIB9cSNk
 iMU=
X-Received: by 2002:a05:6000:298d:20b0:463:a83f:fc12 with SMTP id
 ffacd0b85a97d-46502bafa75mr18042759f8f.23.1782142286770; 
 Mon, 22 Jun 2026 08:31:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4e93sm29470512f8f.7.2026.06.22.08.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:31:26 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:31:08 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 0fefdd1d70ac3f8183ca1d136e37071853a692c1
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ad763b11d42f06e8a03c37d437b95c4a984ac681-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgcc-0007np-PN
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1637224642800575334=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1637224642800575334==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hMpuXbDDVf4="; charset=UTF-8

--hMpuXbDDVf4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727?usp=3Demail

to look at the new patch set (#2=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Add lookup of multi session by session id=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add lookup=
 of multi session by session id

This refactors the way that we lookup cont=
rol channel packets for UDP
packets from other peers=2E Instead of looking =
them up by their source
IP address, we lookup the session ids instead=2E

I=
t also has the consequence that we can have multiple ongoing
sessions from =
the same source IP address and the new session will
go through all the conn=
ect steps like an initial session=2E

The check if the new session can take=
 over the old session's IP
is now also the same as for floating=2E

This el=
iminates a whole class of bugs that we currently have that
break connection=
 if the reconnecting client has different
capabilities as the setup and neg=
otiation is inherited from the
previous client currently=2E Currently there=
 is at least one bug
regarding the dynamic tls-crypt in this situation=2E

=
This also changes the user visible behaviour for clients
reconnecting from =
the same IP and port=2E They are now almost
behaving like clients that reco=
nnect from a different IP
address=2E These now do the whole renegotiation a=
nd run
connect scripts/plugins and all the things are normally
skipped when=
 reconnecting from the same IP and port=2E

The only difference is that dup=
licate-cn does not
allow both connection=2E

This will also eventually allo=
w us to get rid of TM_INITIAL
slot as we now do no longer need to keep an o=
ngoing and a
new session anymore=2E Currently the p2p mode still needs
the =
extra session slot for the new session so we cannot
remove it just yet=2E

=
This now allows a multiple pending session from the
same source IP and port=
=2E Previously a client would need
to use a different ports to create multi=
ple pending
session=2E This change does not make it really easier to
exhaus=
t all pending session than before=2E

Change-Id: Idb59ecd119331b198792ad137=
9bec8600211651b
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMak=
eLists=2Etxt
M doc/man-sections/advanced-options=2Erst
M src/openvpn/mtcp=
=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh=

M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
A src/openvpn/sid_hash=
=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/te=
st_misc=2Ec
11 files changed, 257 insertions(+), 59 deletions(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/1727/2

diff =
--git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 412fa06=2E=2E0a04fcb 1006=
44
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -832,6 +832,7 @@
      =
   src/openvpn/siphash=2Ec
         src/openvpn/siphash_reference=2Ec
     =
    src/openvpn/siphash_openssl=2Ec
+        src/openvpn/session_id=2Ec
   =
  )
 
     target_sources(test_ncp PRIVATE
diff --git a/doc/man-sections/ad=
vanced-options=2Erst b/doc/man-sections/advanced-options=2Erst
index 3eff30=
85=2E=2E21a0191 100644
--- a/doc/man-sections/advanced-options=2Erst
+++ b/=
doc/man-sections/advanced-options=2Erst
@@ -29,16 +29,18 @@
 
 --hash-size =
args
   Set the size of the real address hash table to ``r`` and the virtua=
l
-  address table to ``v``=2E
+  address table to ``v``=2E And if specifie=
d the session id hash table to
+  ``s``=2E Otherwise ``s`` be set to the sa=
me value as ``r``=2E
 
   Valid syntax:
   ::
 
-     hash-size r v
+     h=
ash-size r v [s]
 
-  By default, both tables are sized at 4 times ``--max-=
clients`` buckets=2E
+  By default, all three tables are sized at 4 times `=
`--max-clients`` buckets=2E
   With the default of 1024 of ``--max-clients`=
` this gives 4096 buckets=2E
 
+
 --bcast-buffers n
   Allocate ``n`` buffe=
rs for broadcast datagrams (default :code:`256`)=2E
 
diff --git a/src/open=
vpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index f000283=2E=2Eeb4e944 100644
--- a=
/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -42,36 +42,12 @@
 {
   =
  struct gc_arena gc =3D gc_new();
     struct multi_instance *mi =3D NULL;=

-    struct hash *hash =3D m->hash;
 
     mi =3D multi_create_instance(m,=
 NULL, sock);
     if (mi)
     {
         mi->real=2Eproto =3D sock->info=
=2Eproto;
-        struct hash_element *he;
-        const uint64_t hv =3D =
hash_value(hash, &mi->real);
-        struct hash_bucket *bucket =3D hash_b=
ucket(hash, hv);
-
         multi_assign_peer_id(m, mi);
-
-        he =3D =
hash_lookup_fast(hash, bucket, &mi->real, hv);
-
-        if (he)
-        =
{
-            struct multi_instance *oldmi =3D (struct multi_instance *)he=
->value;
-            msg(D_MULTI_LOW,
-                "MULTI TCP: new inc=
oming client address matches existing client address -- new client takes pr=
ecedence");
-            oldmi->did_real_hash =3D false;
-            multi=
_close_instance(m, oldmi, false);
-            he->key =3D &mi->real;
-    =
        he->value =3D mi;
-        }
-        else
-        {
-            =
hash_add_fast(hash, bucket, &mi->real, hv, mi);
-        }
-
-        mi->d=
id_real_hash =3D true;
     }
 
 #ifdef ENABLE_DEBUG
diff --git a/src/openv=
pn/mudp=2Ec b/src/openvpn/mudp=2Ec
index aa7defe=2E=2E611005a 100644
--- a/=
src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -32,6 +32,7 @@
 
 #inclu=
de "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
+#include "sid_hash=2Eh"
 
 #ifdef =
HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>
@@ -180,7 +181,7 @@
        =
 }
         else
         {
-            msg(D_MULTI_DEBUG,
+            ms=
g(D_MULTI_MEDIUM,
                 "Valid packet (%s) with HMAC challenge f=
rom peer (%s), "
                 "accepting new connection=2E",
          =
       packet_opcode_name(op), peer);
@@ -194,12 +195,12 @@
     return fal=
se;
 }
 
+
 struct multi_instance *
 handle_connection_attempt(struct multi=
_context *m,
                           struct link_socket *sock,
         =
                  struct mroute_addr *real)
 {
-    struct hash *hash =3D m=
->hash;
     struct tls_pre_decrypt_state state =3D { 0 };
     struct mult=
i_instance *mi =3D NULL;
     struct gc_arena gc =3D gc_new();
@@ -227,11 +=
228,6 @@
             mi =3D multi_create_instance(m, real, sock);
        =
     if (mi)
             {
-                const uint64_t hv =3D hash_val=
ue(hash, real);
-                struct hash_bucket *bucket =3D hash_bucket=
(hash, hv);
-                hash_add_fast(hash, bucket, &mi->real, hv, mi)=
;
-
-                mi->did_real_hash =3D true;
                 multi_ass=
ign_peer_id(m, mi);
 
                 /* If we have a session id already, =
ensure that the
@@ -243,6 +239,7 @@
                     struct tls_session=
 *session =3D
                         &mi->context=2Ec2=2Etls_multi->sessi=
on[TM_INITIAL];
                     session_skip_to_pre_start(session, &st=
ate, &m->top=2Ec2=2Efrom);
+                    multi_hash_sid_add(m, &stat=
e=2Epeer_session_id, mi);
                 }
             }
         }
@@ -=
265,7 +262,7 @@
  * @return      instance matching the NULL otherwise
  */
=
 struct multi_instance *
-multi_get_instance_real_udp_real(struct multi_con=
text *m, struct mroute_addr *real)
+multi_get_instance_real_udp_real(struct=
 multi_context *m,struct mroute_addr *real)
 {
     struct hash *hash =3D m=
->hash;
     struct hash_element *he;
@@ -279,15 +276,26 @@
     return NUL=
L;
 }
 
-struct multi_instance *
-multi_get_instance_udp_control(struct mul=
ti_context *m, struct link_socket *sock)
-{
-    struct mroute_addr real =
=3D { 0 };
-    real=2Eproto =3D sock->info=2Eproto;
 
-    if (mroute_extr=
act_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec=
2=2Ebuf=2Elen > 0)
+static struct multi_instance *
+multi_get_instance_udp_=
control(struct multi_context *m)
+{
+    /* Copy buffer, to a tmp buffer, s=
o that reading the sesison does not
+     * modify the internal pointers */=

+    struct buffer tmp =3D m->top=2Ec2=2Ebuf;
+
+    /* op code */
+    ui=
nt8_t op =3D (uint8_t)buf_read_u8(&tmp) >> P_OPCODE_SHIFT;
+    (void)op;
+=

+    struct session_id sid =3D { 0 };
+    session_id_read(&sid, &tmp);
+
=
+    struct hash_element *he_sid =3D multi_hash_sid_lookup(m, &sid);
+
+   =
 if (he_sid)
     {
-        return multi_get_instance_real_udp_real(m, &re=
al);
+        return he_sid->value;
     }
 
     return NULL;
@@ -366,7 +3=
74,14 @@
     }
     else
     {
-        mi =3D multi_get_instance_udp_con=
trol(m, sock);
+        if (m->top=2Ec2=2Ebuf=2Elen < 9)
+        {
+      =
      /* control packets must be at least the opcode byte + session id
+   =
          * (8 byte) long, otherwise they are not valid packets */
+       =
     return NULL;
+        }
+
+        mi =3D multi_get_instance_udp_contr=
ol(m);
 
         /* we have no existing multi instance for this connection=
, control
          * packets can create a session=2E Data packets cannot *=
/
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 53e1cf8=
=2E=2Ed0f44e4 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2E=
c
@@ -23,6 +23,7 @@
 #ifdef HAVE_CONFIG_H
 #include "config=2Eh"
 #endif
+#=
include "sid_hash=2Eh"
 #include "siphash=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H=

@@ -272,8 +273,8 @@
     struct multi_context *m =3D t->multi;
     int de=
v =3D DEV_TYPE_UNDEF;
 
-    msg(D_MULTI_LOW, "MULTI: multi_init called, r=
=3D%d v=3D%d", t->options=2Ereal_hash_size,
-        t->options=2Evirtual_h=
ash_size);
+    msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D%d v=3D%d s=
=3D%d", t->options=2Ereal_hash_size,
+        t->options=2Evirtual_hash_siz=
e, t->options=2Esid_hash_size);
 
     /*
      * Get tun/tap/null device t=
ype
@@ -301,6 +302,12 @@
     m->vhash =3D hash_init(t->options=2Evirtual_h=
ash_size, siphash_new_context(), siphash_free_context,
                    =
      mroute_addr_hash_function, mroute_addr_compare_function);
 
+    /*
+=
     * Peer session id hash table=2E Used to lookup a session by the sessio=
n
+     * id of one of its active sessions */
+    m->sid_hash =3D hash_ini=
t(t->options=2Esid_hash_size, siphash_new_context(), siphash_free_context,
=
+                            session_id_hash_function, session_id_hash_equa=
l);
+
 #ifdef ENABLE_MANAGEMENT
     m->cid_hash =3D hash_init(t->options=
=2Ereal_hash_size, NULL, free, cid_hash_function, cid_compare_function);
 #=
endif
@@ -428,8 +435,7 @@
             buf_printf(&out, "%s/", cn);
       =
  }
         buf_printf(&out, "%s", mroute_addr_print(&mi->real, gc));
-   =
     if (mi->context=2Ec2=2Etls_multi && check_debug_level(D_DCO_DEBUG)
-  =
          && dco_enabled(&mi->context=2Eoptions))
+        if (mi->context=
=2Ec2=2Etls_multi && true)
         {
             buf_printf(&out, " rx-pe=
er-id=3D%d", mi->context=2Ec2=2Etls_multi->rx_peer_id);
         }
@@ -599,=
6 +605,12 @@
         }
 #endif
 
+
+        if (session_id_defined(&mi->si=
d_hashed_value))
+        {
+            multi_hash_sid_remove(m, &mi->sid_=
hashed_value);
+        }
+
         if (mi->context=2Ec2=2Etls_multi->rx_p=
eer_id !=3D MAX_PEER_ID)
         {
             m->instances[mi->context=
=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
@@ -673,6 +685,7 @@
 
         has=
h_free(m->hash);
         hash_free(m->vhash);
+        hash_free(m->sid_ha=
sh);
 #ifdef ENABLE_MANAGEMENT
         hash_free(m->cid_hash);
 #endif
@@ =
-2493,6 +2506,34 @@
     multi_client_connect_setenv(mi);
 }
 
+static bool=

+multi_check_dest_addr_allowed(struct multi_context *m, struct multi_insta=
nce *mi, struct mroute_addr *real);
+
+/**
+ * This sets up the client real=
 address (outer tunnel addr) in the
+ * hash map for data channel packet=2E=
 If the address is already taken
+ * this steps fails
+ */
+static enum cli=
ent_connect_return
+multi_client_connect_real_addr(struct multi_context *m,=
 struct multi_instance *mi,
+                               bool deferred, =
uint64_t *option_types_found)
+{
+    /* If the address is already taken up=
 by another client we fail the new
+     * connection */
+    if (!multi_ch=
eck_dest_addr_allowed(m, mi, &mi->real))
+    {
+        msg(D_MULTI_ERRORS=
,
+            "MULTI: client IP address and port already assigned to anoth=
er "
+            "client, terminating connection");
+        return CC_RET=
_FAILED;
+    }
+
+    ASSERT(!mi->did_real_hash);
+    ASSERT(hash_add(m->=
hash, &mi->real, mi, false));
+    mi->did_real_hash =3D true;
+    return =
CC_RET_SUCCEEDED;
+}
+
 /**
  *  Do the necessary modification for doing th=
e compress migrate=2E This is
  *  implemented as a connect handler as it f=
its the modify config for a client
@@ -2587,6 +2628,7 @@
     uint64_t *opt=
ion_types_found);
 
 static const multi_client_connect_handler client_conne=
ct_handlers[] =3D {
+    multi_client_connect_real_addr,
     multi_client_=
connect_compress_migrate,
     multi_client_connect_source_ccd,
     multi_=
client_connect_call_plugin_v1,
@@ -2655,6 +2697,7 @@
     }
     return tru=
e;
 }
+
 /*
  * Called as soon as the SSL/TLS connection is authenticated=
=2E
  *
@@ -3131,7 +3174,7 @@
     /* do not allow if target address is tak=
en by client with another cert */
     if (!cert_hash_compare(m1->locked_ce=
rt_hash_set, m2->locked_cert_hash_set))
     {
-        msg(D_MULTI_LOW, "D=
isallow float to an address taken by another client %s",
+        msg(D_MUL=
TI_LOW, "Disallow float/connect to an address taken by another client %s",
=
             multi_instance_string(ex_mi, false, &gc));
 
         mi->cont=
ext=2Ec2=2Ebuf=2Elen =3D 0;
@@ -3144,8 +3187,9 @@
         if (!m1->locked_=
username || !m2->locked_username
             || strcmp(m1->locked_username=
, m2->locked_username) !=3D 0)
         {
-            msg(D_MULTI_LOW, "Di=
sallow float to an address taken by another client %s",
+            msg(D_=
MULTI_LOW, "Disallow float/connect to an address taken by another client %s=
",
                 multi_instance_string(ex_mi, false, &gc));
+           =
 goto done;
         }
     }
 
diff --git a/src/openvpn/multi=2Eh b/src/op=
envpn/multi=2Eh
index 8b837fa=2E=2E10af816 100644
--- a/src/openvpn/multi=
=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -134,6 +134,10 @@
     bool did_real_ha=
sh;
 #ifdef ENABLE_MANAGEMENT
     bool did_cid_hash;
+    /* If this is mu=
lti_insance is hashed in the sid lookup table the session
+     * id here i=
s non-null and the hash map's key pointer uses is pointing
+     * here */
=
+    struct session_id sid_hashed_value;
     struct buffer_list *cc_config=
;
 #endif
     bool did_iroutes;
@@ -170,6 +174,11 @@
                     =
                    *   address of the remote peer=2E */
     struct hash *=
vhash;                /**< VPN tunnel instances indexed by
                =
                         *   virtual address of remote hosts=2E */
+    str=
uct hash *sid_hash;             /**< TLS sessions indexed by the peer's
+  =
                                          session id=2E We do not care coll=
isions here
+                                            as clients should =
have unique ids and
+                                            supporting=
 clients with identical SIDs
+                                            i=
s not needed */
     struct schedule *schedule;
     struct mbuf_set *mbuf;=
             /**< Set of buffers for passing data
                         =
                *   channel packets between VPN tunnel
diff --git a/src/ope=
nvpn/options=2Ec b/src/openvpn/options=2Ec
index aededdf=2E=2Eb9ffd0d 10064=
4
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3754,6 +3=
754,10 @@
     {
         o->virtual_hash_size =3D 4 * o->max_clients;
    =
 }
+    if (!o->sid_hash_size)
+    {
+        o->sid_hash_size =3D o->real=
_hash_size;
+    }
 }
 
 static void
@@ -7355,7 +7359,7 @@
         options=
->ifconfig_ipv6_pool_base =3D network;
         options->ifconfig_ipv6_pool=
_netbits =3D netbits;
     }
-    else if (streq(p[0], "hash-size") && p[1]=
 && p[2] && !p[3])
+    else if (streq(p[0], "hash-size") && p[1] && p[2] &=
& !p[4])
     {
         int real, virtual;
 
@@ -7367,6 +7371,16 @@
      =
   }
         options->real_hash_size =3D (uint32_t)real;
         options-=
>virtual_hash_size =3D (uint32_t)virtual;
+
+        if (p[3])
+        {
+=
            int sid;
+            if (!atoi_constrained(p[3], &sid, "hash-s=
ize sid", 1, INT_MAX, msglevel))
+            {
+                goto err;
=
+            }
+            options->sid_hash_size =3D (uint32_t)sid;
+    =
    }
     }
     else if (streq(p[0], "connect-freq") && p[1] && p[2] && !=
p[3])
     {
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh=

index a111cf8=2E=2E7207701 100644
--- a/src/openvpn/options=2Eh
+++ b/src/=
openvpn/options=2Eh
@@ -496,6 +496,7 @@
 
     uint32_t real_hash_size;
   =
  uint32_t virtual_hash_size;
+    uint32_t sid_hash_size;
     const char =
*client_connect_script;
     const char *client_disconnect_script;
     con=
st char *learn_address_script;
diff --git a/src/openvpn/sid_hash=2Eh b/src/=
openvpn/sid_hash=2Eh
new file mode 100644
index 0000000=2E=2Ee817e07
--- /d=
ev/null
+++ b/src/openvpn/sid_hash=2Eh
@@ -0,0 +1,90 @@
+/*
+ *  OpenVPN --=
 An application to securely tunnel IP networks
+ *             over a singl=
e TCP/UDP port, with support for SSL/TLS-based
+ *             session auth=
entication and key exchange,
+ *             packet encryption, packet auth=
entication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C=
) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2026 Arne Schwa=
be <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can=
 redistribute it and/or modify
+ *  it under the terms of the GNU General P=
ublic License version 2
+ *  as published by the Free Software Foundation=
=2E
+ *
+ *  This program is distributed in the hope that it will be useful=
,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Ge=
neral Public License for more details=2E
+ *
+ *  You should have received =
a copy of the GNU General Public License along
+ *  with this program; if n=
ot, write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street,=
 Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#include "session_id=2Eh=
"
+#include "multi=2Eh"
+#include "list=2Eh"
+#include "siphash=2Eh"
+
+inl=
ine static void
+multi_hash_sid_add(struct multi_context *m, struct session=
_id *sid,
+                   struct multi_instance *mi)
+{
+    /* This on=
ly be called if the multi instance is not already present
+     * in the ha=
sh table */
+    ASSERT(!session_id_defined(&mi->sid_hashed_value));
+
+   =
 mi->sid_hashed_value =3D *sid;
+
+    const uint64_t hv =3D hash_value(m->=
sid_hash, &mi->sid_hashed_value);
+    struct hash_bucket *bucket =3D hash_=
bucket(m->sid_hash, hv);
+    hash_add_fast(m->sid_hash, bucket, &mi->sid_h=
ashed_value, hv, mi);
+    multi_instance_inc_refcount(mi);
+}
+
+inline st=
atic bool
+multi_hash_sid_remove(struct multi_context *m, const struct sess=
ion_id *sid)
+{
+    const uint64_t hv =3D hash_value(m->sid_hash, sid);
+ =
   struct hash_bucket *bucket =3D hash_bucket(m->sid_hash, hv);
+    struct=
 hash_element *he =3D hash_lookup_fast(m->sid_hash, bucket, sid, hv);
+    =
if (he)
+    {
+        struct multi_instance *mi =3D he->value;
+        A=
SSERT(hash_remove_fast(m->sid_hash, bucket, sid, hv));
+        CLEAR(mi->s=
id_hashed_value);
+        multi_instance_dec_refcount(mi);
+        return=
 true;
+    }
+    else
+    {
+        return false;
+    }
+}
+
+static i=
nline struct hash_element *
+multi_hash_sid_lookup(struct multi_context *m,=
 struct session_id *sid)
+{
+    const uint64_t sid_hv =3D hash_value(m->si=
d_hash, sid);
+    struct hash_bucket *sid_bucket =3D hash_bucket(m->sid_ha=
sh, sid_hv);
+    struct hash_element *he_sid =3D hash_lookup_fast(m->sid_h=
ash, sid_bucket, sid, sid_hv);
+    return he_sid;
+}
+
+/* hashing the ses=
sion=2E As the struct is just an 8 byte array
+ * hashing is straight forwa=
rd */
+static inline uint64_t
+session_id_hash_function(const void *key, vo=
id *ctx)
+{
+    return siphash_hash_func(key, sizeof(struct session_id), c=
tx);
+}
+
+/* wrapper for session_id_equal to have the void* arguments that=
 the
+ * hash map requires */
+static inline bool
+session_id_hash_equal(co=
nst void *sid1, const void *sid2)
+{
+    return session_id_equal((struct s=
ession_id *)sid1, (struct session_id *)sid2);
+}
diff --git a/tests/unit_te=
sts/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 5f=
7f692=2E=2E2c8b6d4 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ =
b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -382,7 +382,8 @@
 	$(top_srcdir=
)/src/openvpn/list=2Ec \
 	$(top_srcdir)/src/openvpn/siphash=2Ec \
 	$(top_=
srcdir)/src/openvpn/siphash_openssl=2Ec \
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
index 576630d=2E=2E52f98c3 100644
--- a/tests/unit_tests/openvpn/te=
st_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -39,6 +39,7 @@
=
 #include "test_common=2Eh"
 #include "list=2Eh"
 #include "mock_msg=2Eh"
+=
#include "sid_hash=2Eh"
 
 static void
 test_compat_lzo_string(void **state=
)
@@ -139,13 +140,6 @@
     return strcmp((const char *)key1, (const char *=
)key2) =3D=3D 0;
 }
 
-static uint32_t
-get_random(void)
-{
-    /* rand() =
is not very random, but it's C99 and this is just for testing */
-    retur=
n (uint32_t)rand();
-}
-
 static struct hash_element *
 hash_lookup_by_valu=
e(struct hash *hash, void *value)
 {
@@ -445,12 +439,63 @@
     mock_set_de=
bug_level(saved_log_level);
 }
 
+static void
+test_sid_hash_list(void **st=
ate)
+{
+    /* very simple tests to ensure the basic hash functions work *=
/
+
+    struct multi_context m =3D { 0 };
+    m=2Esid_hash =3D hash_init(=
2048, siphash_new_context(), siphash_free_context, session_id_hash_function=
, session_id_hash_equal);
+
+    struct session_id sid1;
+    struct sessio=
n_id sid2;
+    struct session_id sid3;
+
+    struct multi_instance *m1, *=
m3;
+
+    /* multi_hash_sid_remove will call gc_free on the gc of a mi and=

+     * free on the mi itself */
+    ALLOC_OBJ(m1, struct multi_instance)=
;
+    ALLOC_OBJ(m3, struct multi_instance);
+
+    m1->gc =3D gc_new();
+ =
   m3->gc =3D gc_new();
+
+    session_id_random(&sid1);
+    session_id_ra=
ndom(&sid2);
+    session_id_random(&sid3);
+
+    multi_hash_sid_add(&m, &=
sid1, m1);
+    multi_hash_sid_add(&m, &sid3, m3);
+
+
+    /* sid2 is not =
added and should not be returned */
+    struct hash_element *he_sid =3D mu=
lti_hash_sid_lookup(&m, &sid2);
+    assert_null(he_sid);
+
+    he_sid =3D=
 multi_hash_sid_lookup(&m, &sid1);
+    assert_non_null(he_sid);
+    asser=
t_ptr_equal(he_sid->value, m1);
+
+    /* Try removing elements, only that =
are in the map should return true */
+    assert_true(multi_hash_sid_remove=
(&m, &sid1));
+    assert_false(multi_hash_sid_remove(&m, &sid2));
+    ass=
ert_false(multi_hash_sid_remove(&m, &sid1));
+
+    /* should no longer fin=
d the element */
+    he_sid =3D multi_hash_sid_lookup(&m, &sid1);
+    ass=
ert_null(he_sid);
+
+    hash_free(m=2Esid_hash);
+}
+
 const struct CMUnit=
Test misc_tests[] =3D { cmocka_unit_test(test_compat_lzo_string),
         =
                                 cmocka_unit_test(test_auth_fail_temp_no_fl=
ags),
                                          cmocka_unit_test(test_auth_=
fail_temp_flags),
                                          cmocka_unit_tes=
t(test_auth_fail_temp_flags_msg),
                                         =
 cmocka_unit_test(test_list),
-                                         cmo=
cka_unit_test(test_atoi_variants) };
+                                     =
    cmocka_unit_test(test_atoi_variants),
+                                =
         cmocka_unit_test(test_sid_hash_list) };
 
 int
 main(void)

-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb59ecd119331b198792ad1=
379bec8600211651b
Gerrit-Change-Number: 1727
Gerrit-PatchSet: 2
Gerrit-Owne=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--hMpuXbDDVf4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add lookup of multi session by session id<br><br>This refacto=
rs the way that we lookup control channel packets for UDP<br>packets from o=
ther peers=2E Instead of looking them up by their source<br>IP address, we =
lookup the session ids instead=2E<br><br>It also has the consequence that w=
e can have multiple ongoing<br>sessions from the same source IP address and=
 the new session will<br>go through all the connect steps like an initial s=
ession=2E<br><br>The check if the new session can take over the old session=
&#39;s IP<br>is now also the same as for floating=2E<br><br>This eliminates=
 a whole class of bugs that we currently have that<br>break connection if t=
he reconnecting client has different<br>capabilities as the setup and negot=
iation is inherited from the<br>previous client currently=2E Currently ther=
e is at least one bug<br>regarding the dynamic tls-crypt in this situation=
=2E<br><br>This also changes the user visible behaviour for clients<br>reco=
nnecting from the same IP and port=2E They are now almost<br>behaving like =
clients that reconnect from a different IP<br>address=2E These now do the w=
hole renegotiation and run<br>connect scripts/plugins and all the things ar=
e normally<br>skipped when reconnecting from the same IP and port=2E<br><br=
>The only difference is that duplicate-cn does not<br>allow both connection=
=2E<br><br>This will also eventually allow us to get rid of TM_INITIAL<br>s=
lot as we now do no longer need to keep an ongoing and a<br>new session any=
more=2E Currently the p2p mode still needs<br>the extra session slot for th=
e new session so we cannot<br>remove it just yet=2E<br><br>This now allows =
a multiple pending session from the<br>same source IP and port=2E Previousl=
y a client would need<br>to use a different ports to create multiple pendin=
g<br>session=2E This change does not make it really easier to<br>exhaust al=
l pending session than before=2E<br><br>Change-Id: Idb59ecd119331b198792ad1=
379bec8600211651b<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;=
<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/advanced-options=2Erst<=
br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=
=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/options=2Ec<br>M src/openv=
pn/options=2Eh<br>A src/openvpn/sid_hash=2Eh<br>M tests/unit_tests/openvpn/=
Makefile=2Eam<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>11 files chang=
ed, 257 insertions(+), 59 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/1727/2</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 412fa=
06=2E=2E0a04fcb 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><sp=
an>+++ b/CMakeLists=2Etxt</span><br><span>@@ -832,6 +832,7 @@</span><br><sp=
an>         src/openvpn/siphash=2Ec</span><br><span>         src/openvpn/si=
phash_reference=2Ec</span><br><span>         src/openvpn/siphash_openssl=2E=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvp=
n/session_id=2Ec</span><br><span>     )</span><br><span> </span><br><span> =
    target_sources(test_ncp PRIVATE</span><br><span>diff --git a/doc/man-se=
ctions/advanced-options=2Erst b/doc/man-sections/advanced-options=2Erst</sp=
an><br><span>index 3eff3085=2E=2E21a0191 100644</span><br><span>--- a/doc/m=
an-sections/advanced-options=2Erst</span><br><span>+++ b/doc/man-sections/a=
dvanced-options=2Erst</span><br><span>@@ -29,16 +29,18 @@</span><br><span> =
</span><br><span> --hash-size args</span><br><span>   Set the size of the r=
eal address hash table to ``r`` and the virtual</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  address table to ``v``=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  address table to ``v``=2E And if specif=
ied the session id hash table to</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  ``s``=2E Otherwise ``s`` be set to the same value as ``r``=
=2E</span><br><span> </span><br><span>   Valid syntax:</span><br><span>   :=
:</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   hash-size r v</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  hash-size r v [s]</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  By default, both tables are sized at 4 times ``--max-clie=
nts`` buckets=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  B=
y default, all three tables are sized at 4 times ``--max-clients`` buckets=
=2E</span><br><span>   With the default of 1024 of ``--max-clients`` this g=
ives 4096 buckets=2E</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> --bcast-buffers n</span><br><span>   A=
llocate ``n`` buffers for broadcast datagrams (default :code:`256`)=2E</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openv=
pn/mtcp=2Ec</span><br><span>index f000283=2E=2Eeb4e944 100644</span><br><sp=
an>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</s=
pan><br><span>@@ -42,36 +42,12 @@</span><br><span> {</span><br><span>     s=
truct gc_arena gc =3D gc_new();</span><br><span>     struct multi_instance =
*mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct hash *hash =3D m-&gt;hash;</span><br><span> </span><br><span>     mi =3D=
 multi_create_instance(m, NULL, sock);</span><br><span>     if (mi)</span><=
br><span>     {</span><br><span>         mi-&gt;real=2Eproto =3D sock-&gt;i=
nfo=2Eproto;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
truct hash_element *he;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        const uint64_t hv =3D hash_value(hash, &amp;mi-&gt;real);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        struct hash_bucket *b=
ucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span>         multi_assign_peer_id(m, mi);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        he =3D hash_lookup_fast(hash, bucket, &amp;m=
i-&gt;real, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (he)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            struct multi_instance *oldmi =
=3D (struct multi_instance *)he-&gt;value;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                &quot;MULTI TCP: new incoming c=
lient address matches existing client address -- new client takes precedenc=
e&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
oldmi-&gt;did_real_hash =3D false;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            multi_close_instance(m, oldmi, false);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            he-&gt;key =3D &amp;m=
i-&gt;real;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  he-&gt;value =3D mi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            hash_add_fast(hash, =
bucket, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;did_r=
eal_hash =3D true;</span><br><span>     }</span><br><span> </span><br><span=
> #ifdef ENABLE_DEBUG</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/s=
rc/openvpn/mudp=2Ec</span><br><span>index aa7defe=2E=2E611005a 100644</span=
><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mud=
p=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> </span><br><span> =
#include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;sid_hash=2Eh&quot;</span><br><span> </span><br><span> #ifdef HAVE_SYS_INO=
TIFY_H</span><br><span> #include &lt;sys/inotify=2Eh&gt;</span><br><span>@@=
 -180,7 +181,7 @@</span><br><span>         }</span><br><span>         else<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            msg(D_MULTI_DEBUG,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(D_MULTI_MEDIUM,</span><br><span>           =
      &quot;Valid packet (%s) with HMAC challenge from peer (%s), &quot;</s=
pan><br><span>                 &quot;accepting new connection=2E&quot;,</sp=
an><br><span>                 packet_opcode_name(op), peer);</span><br><spa=
n>@@ -194,12 +195,12 @@</span><br><span>     return false;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> struct multi_instance *</span><br><span> handle_connecti=
on_attempt(struct multi_context *m,</span><br><span>                       =
    struct link_socket *sock,</span><br><span>                           st=
ruct mroute_addr *real)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span><br><span>=
     struct tls_pre_decrypt_state state =3D { 0 };</span><br><span>     str=
uct multi_instance *mi =3D NULL;</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>@@ -227,11 +228,6 @@</span><br><span>        =
     mi =3D multi_create_instance(m, real, sock);</span><br><span>         =
    if (mi)</span><br><span>             {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                const uint64_t hv =3D hash_value(hash,=
 real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                hash_add_fast(hash, bucke=
t, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   mi-&gt;did_real_hash =3D true;</span><br><span>                 multi_as=
sign_peer_id(m, mi);</span><br><span> </span><br><span>                 /* =
If we have a session id already, ensure that the</span><br><span>@@ -243,6 =
+239,7 @@</span><br><span>                     struct tls_session *session =
=3D</span><br><span>                         &amp;mi-&gt;context=2Ec2=2Etls=
_multi-&gt;session[TM_INITIAL];</span><br><span>                     sessio=
n_skip_to_pre_start(session, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    multi=
_hash_sid_add(m, &amp;state=2Epeer_session_id, mi);</span><br><span>       =
          }</span><br><span>             }</span><br><span>         }</span=
><br><span>@@ -265,7 +262,7 @@</span><br><span>  * @return      instance ma=
tching the NULL otherwise</span><br><span>  */</span><br><span> struct mult=
i_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_get=
_instance_real_udp_real(struct multi_context *m, struct mroute_addr *real)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_r=
eal_udp_real(struct multi_context *m,struct mroute_addr *real)</span><br><s=
pan> {</span><br><span>     struct hash *hash =3D m-&gt;hash;</span><br><sp=
an>     struct hash_element *he;</span><br><span>@@ -279,15 +276,26 @@</spa=
n><br><span>     return NULL;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-struct multi_instance *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-multi_get_instance_udp_contr=
ol(struct multi_context *m, struct link_socket *sock)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct mroute_addr real =3D { 0 };</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    real=2Eproto =3D sock-&gt;info=2Eproto;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Ed=
est, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static struct multi_instance *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_udp_cont=
rol(struct multi_context *m)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Co=
py buffer, to a tmp buffer, so that reading the sesison does not</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * modify the internal poi=
nters */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer tmp =3D m-&gt;top=2Ec2=2Ebuf;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* op code */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
uint8_t op =3D (uint8_t)buf_read_u8(&amp;tmp) &gt;&gt; P_OPCODE_SHIFT;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void)op;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct session_id sid =3D { 0 };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    session_id_read(&amp;sid, &a=
mp;tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *he_si=
d =3D multi_hash_sid_lookup(m, &amp;sid);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (he_sid)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return multi_get_instance_real_udp_real(m, &amp=
;real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn he_sid-&gt;value;</span><br><span>     }</span><br><span> </span><br><sp=
an>     return NULL;</span><br><span>@@ -366,7 +374,14 @@</span><br><span> =
    }</span><br><span>     else</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        mi =3D multi_get_instance_udp_cont=
rol(m, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (m-&gt;top=2Ec2=2Ebuf=2Elen &lt; 9)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            /* control packets must be at least the opcode byte =
+ session id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
      * (8 byte) long, otherwise they are not valid packets */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return NULL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        mi =3D multi_get_instance_udp_control(m);</span>=
<br><span> </span><br><span>         /* we have no existing multi instance =
for this connection, control</span><br><span>          * packets can create=
 a session=2E Data packets cannot */</span><br><span>diff --git a/src/openv=
pn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 53e1cf8=2E=2Ed0f=
44e4 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++=
 b/src/openvpn/multi=2Ec</span><br><span>@@ -23,6 +23,7 @@</span><br><span>=
 #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config=2Eh&quot;</spa=
n><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;sid_hash=2Eh&quot;</span><br><span> #include &quot;siphash=
=2Eh&quot;</span><br><span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</sp=
an><br><span>@@ -272,8 +273,8 @@</span><br><span>     struct multi_context =
*m =3D t-&gt;multi;</span><br><span>     int dev =3D DEV_TYPE_UNDEF;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_=
MULTI_LOW, &quot;MULTI: multi_init called, r=3D%d v=3D%d&quot;, t-&gt;optio=
ns=2Ereal_hash_size,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       t-&gt;options=2Evirtual_hash_size);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    msg(D_MULTI_LOW, &quot;MULTI: multi_init called,=
 r=3D%d v=3D%d s=3D%d&quot;, t-&gt;options=2Ereal_hash_size,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;options=2Evirtual_ha=
sh_size, t-&gt;options=2Esid_hash_size);</span><br><span> </span><br><span>=
     /*</span><br><span>      * Get tun/tap/null device type</span><br><spa=
n>@@ -301,6 +302,12 @@</span><br><span>     m-&gt;vhash =3D hash_init(t-&gt=
;options=2Evirtual_hash_size, siphash_new_context(), siphash_free_context,<=
/span><br><span>                          mroute_addr_hash_function, mroute=
_addr_compare_function);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * Peer session id hash table=2E Used to lookup a session by =
the session</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * i=
d of one of its active sessions */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    m-&gt;sid_hash =3D hash_init(t-&gt;options=2Esid_hash_si=
ze, siphash_new_context(), siphash_free_context,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                            session_id_hash_fu=
nction, session_id_hash_equal);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>    =
 m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_size, NULL, free, c=
id_hash_function, cid_compare_function);</span><br><span> #endif</span><br>=
<span>@@ -428,8 +435,7 @@</span><br><span>             buf_printf(&amp;out,=
 &quot;%s/&quot;, cn);</span><br><span>         }</span><br><span>         =
buf_printf(&amp;out, &quot;%s&quot;, mroute_addr_print(&amp;mi-&gt;real, gc=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt=
;context=2Ec2=2Etls_multi &amp;&amp; check_debug_level(D_DCO_DEBUG)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; dco_en=
abled(&amp;mi-&gt;context=2Eoptions))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (mi-&gt;context=2Ec2=2Etls_multi &amp;&amp; tr=
ue)</span><br><span>         {</span><br><span>             buf_printf(&amp=
;out, &quot; rx-peer-id=3D%d&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_=
peer_id);</span><br><span>         }</span><br><span>@@ -599,6 +605,12 @@</=
span><br><span>         }</span><br><span> #endif</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (session_id_defined(&amp;mi-&gt;sid=
_hashed_value))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mu=
lti_hash_sid_remove(m, &amp;mi-&gt;sid_hashed_value);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>         if (mi-&gt;context=2Ec2=
=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><span>         {</s=
pan><br><span>             m-&gt;instances[mi-&gt;context=2Ec2=2Etls_multi-=
&gt;rx_peer_id] =3D NULL;</span><br><span>@@ -673,6 +685,7 @@</span><br><sp=
an> </span><br><span>         hash_free(m-&gt;hash);</span><br><span>      =
   hash_free(m-&gt;vhash);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        hash_free(m-&gt;sid_hash);</span><br><span> #ifdef ENABLE_MA=
NAGEMENT</span><br><span>         hash_free(m-&gt;cid_hash);</span><br><spa=
n> #endif</span><br><span>@@ -2493,6 +2506,34 @@</span><br><span>     multi=
_client_connect_setenv(mi);</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+multi_check_dest_addr_allowed(struct m=
ulti_context *m, struct multi_instance *mi, struct mroute_addr *real);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * This sets up the client real address (outer tunnel add=
r) in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hash ma=
p for data channel packet=2E If the address is already taken</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * this steps fails</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static enum client_connect_return</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+multi_client_connect_real_addr(struc=
t multi_context *m, struct multi_instance *mi,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                               bool deferred, ui=
nt64_t *option_types_found)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If =
the address is already taken up by another client we fail the new</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * connection */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi_check_dest_ad=
dr_allowed(m, mi, &amp;mi-&gt;real))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(D_MULTI_ERRORS,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            &quot;MULTI: client IP address and port already assi=
gned to another &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &quot;client, terminating connection&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return CC_RET_FAILED;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ASSERT(!mi-&gt;did_real_hash);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(hash_add(m-&gt;hash, &amp;mi-&=
gt;real, mi, false));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    mi-&gt;did_real_hash =3D true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return CC_RET_SUCCEEDED;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> /**</span><br><span>  *  Do the necessary modific=
ation for doing the compress migrate=2E This is</span><br><span>  *  implem=
ented as a connect handler as it fits the modify config for a client</span>=
<br><span>@@ -2587,6 +2628,7 @@</span><br><span>     uint64_t *option_types=
_found);</span><br><span> </span><br><span> static const multi_client_conne=
ct_handler client_connect_handlers[] =3D {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    multi_client_connect_real_addr,</span><br><span>=
     multi_client_connect_compress_migrate,</span><br><span>     multi_clie=
nt_connect_source_ccd,</span><br><span>     multi_client_connect_call_plugi=
n_v1,</span><br><span>@@ -2655,6 +2697,7 @@</span><br><span>     }</span><b=
r><span>     return true;</span><br><span> }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Called as=
 soon as the SSL/TLS connection is authenticated=2E</span><br><span>  *</sp=
an><br><span>@@ -3131,7 +3174,7 @@</span><br><span>     /* do not allow if =
target address is taken by client with another cert */</span><br><span>    =
 if (!cert_hash_compare(m1-&gt;locked_cert_hash_set, m2-&gt;locked_cert_has=
h_set))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(D_MULTI_LOW, &quot;Disallow float to an address taken =
by another client %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(D_MULTI_LOW, &quot;Disallow float/connect to an address=
 taken by another client %s&quot;,</span><br><span>             multi_insta=
nce_string(ex_mi, false, &amp;gc));</span><br><span> </span><br><span>     =
    mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br><span>@@ -3144,8 +3187=
,9 @@</span><br><span>         if (!m1-&gt;locked_username || !m2-&gt;locke=
d_username</span><br><span>             || strcmp(m1-&gt;locked_username, m=
2-&gt;locked_username) !=3D 0)</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW, &quot;Disa=
llow float to an address taken by another client %s&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MULTI_LOW, &quot;D=
isallow float/connect to an address taken by another client %s&quot;,</span=
><br><span>                 multi_instance_string(ex_mi, false, &amp;gc));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto don=
e;</span><br><span>         }</span><br><span>     }</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</spa=
n><br><span>index 8b837fa=2E=2E10af816 100644</span><br><span>--- a/src/ope=
nvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><span>=
@@ -134,6 +134,10 @@</span><br><span>     bool did_real_hash;</span><br><sp=
an> #ifdef ENABLE_MANAGEMENT</span><br><span>     bool did_cid_hash;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If this is multi_in=
sance is hashed in the sid lookup table the session</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * id here is non-null and the hash m=
ap&#39;s key pointer uses is pointing</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * here */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct session_id sid_hashed_value;</span><br><span>     s=
truct buffer_list *cc_config;</span><br><span> #endif</span><br><span>     =
bool did_iroutes;</span><br><span>@@ -170,6 +174,11 @@</span><br><span>    =
                                     *   address of the remote peer=2E */</=
span><br><span>     struct hash *vhash;                /**&lt; VPN tunnel i=
nstances indexed by</span><br><span>                                       =
  *   virtual address of remote hosts=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct hash *sid_hash;             /**&lt; TLS =
sessions indexed by the peer&#39;s</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                            session id=2E We=
 do not care collisions here</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                            as clients should have=
 unique ids and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                                        supporting clients with identical S=
IDs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                            is not needed */</span><br><span>     struct sc=
hedule *schedule;</span><br><span>     struct mbuf_set *mbuf;             /=
**&lt; Set of buffers for passing data</span><br><span>                    =
                     *   channel packets between VPN tunnel</span><br><span=
>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><=
span>index aededdf=2E=2Eb9ffd0d 100644</span><br><span>--- a/src/openvpn/op=
tions=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ =
-3754,6 +3754,10 @@</span><br><span>     {</span><br><span>         o-&gt;v=
irtual_hash_size =3D 4 * o-&gt;max_clients;</span><br><span>     }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;sid_hash_size=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;sid_hash_size =3D =
o-&gt;real_hash_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span> }</span><br><span> </span><br><span> static void</=
span><br><span>@@ -7355,7 +7359,7 @@</span><br><span>         options-&gt;i=
fconfig_ipv6_pool_base =3D network;</span><br><span>         options-&gt;if=
config_ipv6_pool_netbits =3D netbits;</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;hash-=
size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;ha=
sh-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br>=
<span>     {</span><br><span>         int real, virtual;</span><br><span> <=
/span><br><span>@@ -7367,6 +7371,16 @@</span><br><span>         }</span><br=
><span>         options-&gt;real_hash_size =3D (uint32_t)real;</span><br><s=
pan>         options-&gt;virtual_hash_size =3D (uint32_t)virtual;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (p[3])</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            int sid;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (!atoi_constrained(p[3], &amp;sid, &quot;has=
h-size sid&quot;, 1, INT_MAX, msglevel))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                goto err;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            options-&gt;sid_hash_size =3D (uint32_t)sid;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an>     }</span><br><span>     else if (streq(p[0], &quot;connect-freq&quot=
;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>     {=
</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=
=2Eh</span><br><span>index a111cf8=2E=2E7207701 100644</span><br><span>--- =
a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</sp=
an><br><span>@@ -496,6 +496,7 @@</span><br><span> </span><br><span>     uin=
t32_t real_hash_size;</span><br><span>     uint32_t virtual_hash_size;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t sid_hash_si=
ze;</span><br><span>     const char *client_connect_script;</span><br><span=
>     const char *client_disconnect_script;</span><br><span>     const char=
 *learn_address_script;</span><br><span>diff --git a/src/openvpn/sid_hash=
=2Eh b/src/openvpn/sid_hash=2Eh</span><br><span>new file mode 100644</span>=
<br><span>index 0000000=2E=2Ee817e07</span><br><span>--- /dev/null</span><b=
r><span>+++ b/src/openvpn/sid_hash=2Eh</span><br><span>@@ -0,0 +1,90 @@</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securel=
y tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             over a single TCP/UDP port, with support for SSL/TLS-based<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessi=
on authentication and key exchange,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet encryption, packet authentication, an=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pac=
ket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) =
2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;arne@rfc25=
49=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is distributed in the hope that it will be useful,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, write to the Free Software Foundation, Inc=2E,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth=
 Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ses=
sion_id=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;list=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+inline static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+multi_hash_sid_add(struct multi_context *m, struct session_id=
 *sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
      struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* This only be called if the multi instance is not already present</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * in the hash table */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!session_=
id_defined(&amp;mi-&gt;sid_hashed_value));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    mi-&gt;sid_hashed_value =3D *sid;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const uint64_t hv =3D hash_value(m-&gt;sid_hash, &amp;mi-&gt;sid_has=
hed_value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct hash_bucket *bucket =3D hash_bucket(m-&gt;sid_hash, hv);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    hash_add_fast(m-&gt;sid_hash, b=
ucket, &amp;mi-&gt;sid_hashed_value, hv, mi);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    multi_instance_inc_refcount(mi);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+inline static bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+multi_hash_sid_remove(struct multi_context *m, const struct session_id=
 *sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_=
value(m-&gt;sid_hash, sid);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct hash_bucket *bucket =3D hash_bucket(m-&gt;sid_hash, hv);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_ele=
ment *he =3D hash_lookup_fast(m-&gt;sid_hash, bucket, sid, hv);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (he)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct multi_instance *mi =3D he-&gt;value;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(hash_r=
emove_fast(m-&gt;sid_hash, bucket, sid, hv));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        CLEAR(mi-&gt;sid_hashed_value);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        multi_instance_dec_re=
fcount(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline struct=
 hash_element *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mult=
i_hash_sid_lookup(struct multi_context *m, struct session_id *sid)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const uint64_t sid_hv =3D hash_value(m-&gt=
;sid_hash, sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct hash_bucket *sid_bucket =3D hash_bucket(m-&gt;sid_hash, sid_hv);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_elemen=
t *he_sid =3D hash_lookup_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return he_sid;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* hashing the session=2E As the struct is just an 8 byte ar=
ray</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hashing is st=
raight forward */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic inline uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+session_id_hash_function(const void *key, void *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return siphash_hash_func(key, sizeof(struct session_id)=
, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* wrapper for session_id_equal to have the void*=
 arguments that the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * hash map requires */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+session_id_hash_equal(const void *sid1, const void *sid2)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return session_id_equal((struct session_id *)sid=
1, (struct session_id *)sid2);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=
=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 5f7f69=
2=2E=2E2c8b6d4 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefi=
le=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span>=
<br><span>@@ -382,7 +382,8 @@</span><br><span> 	$(top_srcdir)/src/openvpn/l=
ist=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/siphash_openssl=2Ec \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/siphash_ref=
erence=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_sr=
cdir)/src/openvpn/siphash_reference=2Ec \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/session_id=2Ec</span><br><=
span> </span><br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdi=
r)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \</span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests=
/openvpn/test_misc=2Ec</span><br><span>index 576630d=2E=2E52f98c3 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -39,6 +39,7=
 @@</span><br><span> #include &quot;test_common=2Eh&quot;</span><br><span> =
#include &quot;list=2Eh&quot;</span><br><span> #include &quot;mock_msg=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;sid_hash=2Eh&quot;</span><br><span> </span><br><span> static void</span><b=
r><span> test_compat_lzo_string(void **state)</span><br><span>@@ -139,13 +1=
40,6 @@</span><br><span>     return strcmp((const char *)key1, (const char =
*)key2) =3D=3D 0;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static uint32_t</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-get_random(void)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    /* rand() is not very random, but it&#39;s C99 and this is just for t=
esting */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (=
uint32_t)rand();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static =
struct hash_element *</span><br><span> hash_lookup_by_value(struct hash *ha=
sh, void *value)</span><br><span> {</span><br><span>@@ -445,12 +439,63 @@</=
span><br><span>     mock_set_debug_level(saved_log_level);</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_si=
d_hash_list(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* very =
simple tests to ensure the basic hash functions work */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct multi_context m =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    m=2Esid_hash =3D hash_init(2048, sip=
hash_new_context(), siphash_free_context, session_id_hash_function, session=
_id_hash_equal);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id =
sid1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ses=
sion_id sid2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct session_id sid3;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_=
instance *m1, *m3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* multi_hash_si=
d_remove will call gc_free on the gc of a mi and</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * free on the mi itself */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ(m1, struct multi_ins=
tance);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OB=
J(m3, struct multi_instance);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m1-&g=
t;gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   m3-&gt;gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session_=
id_random(&amp;sid1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    session_id_random(&amp;sid2);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    session_id_random(&amp;sid3);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    multi_hash_sid_add(&amp;m, &amp;sid1, m1);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    multi_hash_sid_add(&amp;m, &amp;s=
id3, m3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* sid2 is not added and should not be retur=
ned */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ha=
sh_element *he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid2);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(he_sid);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    he_sid =3D multi_hash_sid_lookup(&amp;m,=
 &amp;sid1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_non_null(he_sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_ptr_equal(he_sid-&gt;value, m1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Try removing elements, only that are in the map should return=
 true */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(multi_hash_sid_remove(&amp;m, &amp;sid1));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_false(multi_hash_sid_remove(&amp;m, =
&amp;sid2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_false(multi_hash_sid_remove(&amp;m, &amp;sid1));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* should no longer find the element */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    he_sid =3D multi_hash_sid_lookup=
(&amp;m, &amp;sid1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_null(he_sid);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hash_free=
(m=2Esid_hash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> cons=
t struct CMUnitTest misc_tests[] =3D { cmocka_unit_test(test_compat_lzo_str=
ing),</span><br><span>                                          cmocka_unit=
_test(test_auth_fail_temp_no_flags),</span><br><span>                      =
                    cmocka_unit_test(test_auth_fail_temp_flags),</span><br>=
<span>                                          cmocka_unit_test(test_auth_=
fail_temp_flags_msg),</span><br><span>                                     =
     cmocka_unit_test(test_list),</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                         cmocka_unit_test(test_=
atoi_variants) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                       cmocka_unit_test(test_atoi_variants)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                       cmocka_unit_test(test_sid_hash_list) };</span><br><s=
pan> </span><br><span> int</span><br><span> main(void)</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1727?usp=3Demail">change 1727</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec86002=
11651b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1727 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>

</body></html>
--hMpuXbDDVf4=--


--===============1637224642800575334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1637224642800575334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1637224642800575334==--

