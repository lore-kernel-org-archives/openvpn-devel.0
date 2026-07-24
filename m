Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ACFC531F9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3yrWwmlwxLNljw5nP8SgXefN7hYj36GMqySgOX+x/Nw=; b=SY+tDpScuXTpNBwssFLElMmIbF
	rfb+9dypenyELI71FSNxEoWkkCTvT3FRJQ14idLroTMiXCB7qMF1crXQCcsBoZw815k87gYkMMnvZ
	BlCxjX73CNKbNUgVTIC6KMWG8qaVJKm5o31K07J++fM4OAT74k8SRiNF7+T7VXC3I37s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnEJ7-0005oV-Ad;
	Fri, 24 Jul 2026 11:43:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnEJ5-0005oP-Be
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 11:43:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cJGXAsH2mhC9ahYisXbAe0rjN7wk4fXJGx4S01fmq68=; b=DBF4ry7shpN/uVpSpJt6NT8kTO
 fJNyt4d/QNJVmHbHmYPXPxWzpwqQEviXR7oK+wbsuHA7cpZSU9tybRQoN8Y9vweH4p+uvU5AsvRLF
 8wd7/DchacAa6y2Gnyc+J1y53Qino4xD6u4kC9Lj8Omx1IBpiSoOVqqh1b1u54RlVamQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cJGXAsH2mhC9ahYisXbAe0rjN7wk4fXJGx4S01fmq68=; b=E
 Zi7mrtDEylCv8/15+H+iFQni3FSvM3zudCXaqzs+8PRm9fSm/5ox55RzYzoVLf+SgCyr+g2VqqyC5
 ZuR3seplS4ai5XqF6Jv8rZonllXMlkbrCtprLtWlR05seotX30rOYOkbVb3hYfY5SLQnacnyYh+d6
 xqp/DYMFqbq34UXM=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnEJ6-0004y1-9w for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 11:43:11 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954c0833b4so3108815e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784893382; x=1785498182; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cJGXAsH2mhC9ahYisXbAe0rjN7wk4fXJGx4S01fmq68=;
 b=XqpAF/f3MK2enumq6vs7sXDK3czpmL1j/XXN5lCcS5mIGz7oK1Ddu0GlF/dblTTsCc
 h1JL1jm2+oZdMeXNVjXNczbOtJFbolvXxMazJYt6Bz82PD6ymGlqBCqmFE8PAVjWXhkv
 C4SC/TCtS55RIFrMmKtb/8l7DUS7TnLEcgPbOnh2/hhVbKc/1erFgfuosyM9z8HCGVnY
 6aMFhRK8S1ZvF6eYXLvkFI+Hr2JjEguBgcTeK0e4MkKdnNbeqjhKKofoaZd4x4aTHAKh
 cJDV/lh5nDr+Wwd+xW3baZKv+yvBi9d9t2nPUHvUYmej8UrQBQl0Dbw4159UlBn3cjS0
 KuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784893382; x=1785498182;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cJGXAsH2mhC9ahYisXbAe0rjN7wk4fXJGx4S01fmq68=;
 b=Q245bOeRdEObsk/hw1URT8qh3mNdPgJGrB5q3dbwYKIjuQPwkb94eXj/+z0VdiI3NZ
 SNbwlu6uGwXjYtGKhsPTQFJ/aZ5bHudmevyMUu/SPFFmjJpti//kLPP4iWrNkOiEmUby
 9Dj6l7LUsINyKtxINk+ZBJLjBgOfGxe27FeASJyTWrRZwSstiWG6BD/oA4v6/UTfepCf
 zw7m8HXqmDJC5zyMlrKqxuPdUrIHL/nWyHtjTdLRgduIdtQrTHwnaHLhkw3V4OJq2KQY
 HlYncGEnnn4mh6OfC0eS0i4RNJ0SdRmR7RGwk99fmHz79XqaZSKeOLvH2B/KrfXiWAjx
 5qpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8S60i01m4tGIpWueqbiiDmqg3CdV5MPdJQlgneuIi0F8wXCCsIoL3aSRDaaUnhVz5SXrM9PGyNE8EfI1I@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwMmb3bSYk7iPSBngILXdIPl2sPIKOse4FFUN4KkimQbyvUdIVx
 bjB3PzquhSaRHi3v8fpr+isH8P9ZtCRRauS56PtT6ZFziHAoJdimlJx8tn4S4mVVfca9y1GNUaD
 4SklgrQpn+o4lZFIJN9KwHQPTnWUvA/anBXd0gcdlkku3dMgEy86HVabBhIIi7/YjV8DJ
X-Gm-Gg: AR+sD12ULzvdx1a4+tPJaLAf2L+tqVAEOs1CB4RCpfvJifyAS+TyCTaoSRJEBUPYTiK
 SqXUizZzv2SXW8biiI2K8DtV/9rtIrxFxuVPvIqw/X/Wi8VKXDJsPnLJCuGqKB+0wGB3LALdNKE
 0H/qDVJUwhE050JMSy+IvuLJb8ZbUw0YH0stUmJFjWpATfEDG1CeYI8OSOzt1A8USVvRldLaL9k
 KLs9mPUorranouiLqje4PKPeY6NRrXkgQDUA3Il4QFyNsBzzH4qbMtxeGAagAGBORVGGH8sJ1tz
 M/qnMFYT4xP/1JXR6Acb02F/S3seu9QxMUjFRNLDfyxFcE1f/U9ZOJpIHp9UirMoX9Z9GSvp0Xc
 g/82a/ND0FKIvpOm6nYOeS2oAXcfHLWztgJ3rn5itxczznlsledBnl0+eKDDSPuwy9RycMoqluY
 wWXUddweIWH1kFBKM2ldHpwyhEecyaXpkTKlvKChJqs0HRGi/esxYk8gfy1cktbYpMTZxkuy2lh
 VY3Uedq7KtU55FGlFlEqoB+nHd4E+Yu6JQbmkPsSGEBxM0JP3fbfj4+WOId4XonDXG7
X-Received: by 2002:a05:600c:1394:b0:493:b6ee:fcb7 with SMTP id
 5b1f17b1804b1-49573cd41f4mr82307295e9.14.1784893381980; 
 Fri, 24 Jul 2026 04:43:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9b8b67sm27837085e9.4.2026.07.24.04.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 04:43:01 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 11:43:01 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
X-Gerrit-Change-Number: 1795
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1795?usp=email>
X-Gerrit-Commit: ea3bb67e2b1e130c90cd2b28ec5e31a455d60164
In-Reply-To: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
References: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzkwMTU4MDAwLkk0ZDA4ODc4MzliNGExM2E5MmU5MjI1MGQxYjMxNWRlYzk0OTY5OGYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d3be64111d4f553750dd986807ead316df296b4-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnEJ6-0004y1-9w
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: make key state
 desync recoverable
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3897971965926375201=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3897971965926375201==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RTYXqU/ixE4="; charset=UTF-8

--RTYXqU/ixE4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1795?usp=3Demail )

Change subject: dco: make key state desync recovera=
ble
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: ma=
ke key state desync recoverable

If installing a DCO key succeeds, always r=
ecord the slot in the
corresponding key_state=2E The installed-key counter =
only tracks whether
the number of kernel slots grew, but a successful KEY_N=
EW still means
that this key_state is associated with the selected DCO slot=
=2E

Also replace DCO key-state assertions in dco_update_keys() with error
=
returns=2E This preserves the invariant checks but lets the existing
caller=
 restart the connection instead of aborting the process if
userspace ever d=
etects inconsistent DCO key state=2E

Github: OpenVPN/openvpn-private-issue=
s#143
Reported-By: Hcamael
Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 (www=2E=
aipyaipy=2Ecom)
Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
Signed=
-off-by: Ralf Lici <ralf@mandelbit=2Ecom>
Acked-by: Antonio Quartulli <anto=
nio@mandelbit=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1795
Message-Id: <20260721203807=2E5813-1-gert@greenie=2Emuc=2Ede>
URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3=
7732=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src=
/openvpn/dco=2Ec
1 file changed, 20 insertions(+), 4 deletions(-)




diff =
--git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index e944547=2E=2E258436=
8 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -73,9 +73,1=
2 @@
 
     int ret =3D dco_new_key(multi->dco, multi->dco_peer_id, ks->key=
_id, slot, encrypt_key, encrypt_iv,
                           decrypt_key,=
 decrypt_iv, ciphername, epoch);
-    if ((ret =3D=3D 0) && (multi->dco_key=
s_installed < 2))
+    if (ret =3D=3D 0)
     {
-        multi->dco_keys_in=
stalled++;
+        if (multi->dco_keys_installed < 2)
+        {
+        =
    multi->dco_keys_installed++;
+        }
         ks->dco_status =3D
   =
          (slot =3D=3D OVPN_KEY_SLOT_PRIMARY) ? DCO_INSTALLED_PRIMARY : DCO=
_INSTALLED_SECONDARY;
     }
@@ -166,7 +169,13 @@
     /* if we have a prim=
ary key, it must have been installed already (keys
      * are installed up=
on generation in the TLS code)
      */
-    ASSERT(primary->dco_status !=
=3D DCO_NOT_INSTALLED);
+    if (primary->dco_status =3D=3D DCO_NOT_INSTALL=
ED)
+    {
+        msg(D_DCO, "DCO key state mismatch: selected primary ke=
y is not installed "
+                   "(peer_id=3D%d, key_id=3D%d, dco_k=
eys_installed=3D%d)",
+            multi->dco_peer_id, primary->key_id, mul=
ti->dco_keys_installed);
+        return false;
+    }
 
     struct key_st=
ate *secondary =3D dco_get_secondary_key(multi, primary);
     /* if the cu=
rrent primary key was installed as secondary in DCO,
@@ -190,6 +199,14 @@
 =
                primary->key_id);
         }
 
+        if (secondary && se=
condary->dco_status !=3D DCO_INSTALLED_PRIMARY)
+        {
+            msg=
(D_DCO, "DCO key state mismatch: expected old primary key is not installed =
as DCO primary before swap "
+                       "(peer_id=3D%d, new_pr=
imary_key_id=3D%d, old_primary_key_id=3D%d, old_primary_dco_status=3D%d, dc=
o_keys_installed=3D%d)",
+                multi->dco_peer_id, primary->key_=
id, secondary->key_id, secondary->dco_status, multi->dco_keys_installed);
+=
            return false;
+        }
+
         int ret =3D dco_swap_keys(d=
co, multi->dco_peer_id);
         if (ret < 0)
         {
@@ -200,7 +217,6 =
@@
         primary->dco_status =3D DCO_INSTALLED_PRIMARY;
         if (sec=
ondary)
         {
-            ASSERT(secondary->dco_status =3D=3D DCO_INS=
TALLED_PRIMARY);
             secondary->dco_status =3D DCO_INSTALLED_SECON=
DARY;
         }
     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1795?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I4d0887839b4a13a92e92250d1b315dec949698f3
Gerrit-Change-Number: 1795
Gerr=
it-PatchSet: 4
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Review=
er: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--RTYXqU/ixE4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1795?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">dco: make key state desync recoverable<br>=
<br>If installing a DCO key succeeds, always record the slot in the<br>corr=
esponding key_state=2E The installed-key counter only tracks whether<br>the=
 number of kernel slots grew, but a successful KEY_NEW still means<br>that =
this key_state is associated with the selected DCO slot=2E<br><br>Also repl=
ace DCO key-state assertions in dco_update_keys() with error<br>returns=2E =
This preserves the invariant checks but lets the existing<br>caller restart=
 the connection instead of aborting the process if<br>userspace ever detect=
s inconsistent DCO key state=2E<br><br>Github: OpenVPN/openvpn-private-issu=
es#143<br>Reported-By: Hcamael<br>Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 =
(www=2Eaipyaipy=2Ecom)<br>Change-Id: I4d0887839b4a13a92e92250d1b315dec94969=
8f3<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;<br>Acked-by: A=
ntonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1795<br>Message-Id: &lt;20260721203807=2E58=
13-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg37732=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dco=2Ec<=
br>1 file changed, 20 insertions(+), 4 deletions(-)<br><br></pre>
<pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index e944=
547=2E=2E2584368 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br=
><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -73,9 +73,12 @@</span><=
br><span> </span><br><span>     int ret =3D dco_new_key(multi-&gt;dco, mult=
i-&gt;dco_peer_id, ks-&gt;key_id, slot, encrypt_key, encrypt_iv,</span><br>=
<span>                           decrypt_key, decrypt_iv, ciphername, epoch=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((ret =3D=3D=
 0) &amp;&amp; (multi-&gt;dco_keys_installed &lt; 2))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ret =3D=3D 0)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;=
dco_keys_installed++;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (multi-&gt;dco_keys_installed &lt; 2)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            multi-&gt;dco_keys_installed++;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>    =
     ks-&gt;dco_status =3D</span><br><span>             (slot =3D=3D OVPN_K=
EY_SLOT_PRIMARY) ? DCO_INSTALLED_PRIMARY : DCO_INSTALLED_SECONDARY;</span><=
br><span>     }</span><br><span>@@ -166,7 +169,13 @@</span><br><span>     /=
* if we have a primary key, it must have been installed already (keys</span=
><br><span>      * are installed upon generation in the TLS code)</span><br=
><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    AS=
SERT(primary-&gt;dco_status !=3D DCO_NOT_INSTALLED);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (primary-&gt;dco_status =3D=3D DCO=
_NOT_INSTALLED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO,=
 &quot;DCO key state mismatch: selected primary key is not installed &quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
&quot;(peer_id=3D%d, key_id=3D%d, dco_keys_installed=3D%d)&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;dco_pee=
r_id, primary-&gt;key_id, multi-&gt;dco_keys_installed);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><s=
pan>     struct key_state *secondary =3D dco_get_secondary_key(multi, prima=
ry);</span><br><span>     /* if the current primary key was installed as se=
condary in DCO,</span><br><span>@@ -190,6 +199,14 @@</span><br><span>      =
           primary-&gt;key_id);</span><br><span>         }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (second=
ary &amp;&amp; secondary-&gt;dco_status !=3D DCO_INSTALLED_PRIMARY)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(D_DCO, &quot;DCO key =
state mismatch: expected old primary key is not installed as DCO primary be=
fore swap &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                    &quot;(peer_id=3D%d, new_primary_key_id=3D%d, old_prima=
ry_key_id=3D%d, old_primary_dco_status=3D%d, dco_keys_installed=3D%d)&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                mu=
lti-&gt;dco_peer_id, primary-&gt;key_id, secondary-&gt;key_id, secondary-&g=
t;dco_status, multi-&gt;dco_keys_installed);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            return false;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>         int ret =3D dco_swap_keys(dc=
o, multi-&gt;dco_peer_id);</span><br><span>         if (ret &lt; 0)</span><=
br><span>         {</span><br><span>@@ -200,7 +217,6 @@</span><br><span>   =
      primary-&gt;dco_status =3D DCO_INSTALLED_PRIMARY;</span><br><span>   =
      if (secondary)</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            ASSERT(secondary-&gt;dco_status =3D=
=3D DCO_INSTALLED_PRIMARY);</span><br><span>             secondary-&gt;dco_=
status =3D DCO_INSTALLED_SECONDARY;</span><br><span>         }</span><br><s=
pan>     }</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail">change 1795</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d0887839=
b4a13a92e92250d1b315dec949698f3 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1795 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 =
</div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &l=
t;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>

</body></html>
--RTYXqU/ixE4=--


--===============3897971965926375201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3897971965926375201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3897971965926375201==--

