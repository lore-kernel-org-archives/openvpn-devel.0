Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BBEC982EA
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=qP6XMKkQ6Td8c7LBPBZsxfpDeDJ9+cmL/KL0OffS4GM=; b=N/w3ZDWQDel34e
	AL38Z1cLK0jcY5aq/FurseqkN6TJGUv81D9Lmyr+DgeGed8HrCP2HKC0cbF+dGdwkelY0QC/3i0ZP
	ojkleu3fzlWZm0ug34ufjKWEtCn6XrWm1Ji5o2fz+KepyLd3ZfNofdIzrhhn58O2ej+3TxiYRGSSR
	7go=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9JDr-0001Rx-HN;
	Wed, 23 Sep 2026 09:25:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9JDq-0001Rq-Oa
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 09:25:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7SDaa8OUO9OFT9zAYh9E0XmwU744X767wsGiPxQqxKY=; b=I+PTnHO+N72C5FwbJ8gRWz/8Il
 0c+YuYRKLj4T7MUARaBouiKZ6F9wJJZlMR9SqTdmz5g18XhSa3cxQ5NruTbTF/sRbEzSSCDiV6KeX
 4H6LGVTZgrhd/elSgQk4C8uiw6nGsgux10JJnsZv2UpRVxx7AMBtlMkovOcZ1pTcxEf0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7SDaa8OUO9OFT9zAYh9E0XmwU744X767wsGiPxQqxKY=; b=i
 iNW3amj1ZZftTj80wBzBR9/6yUfXfLmluJgoUGBBRshqy+HBUVsVlF7FpLCRxLWRM2XYxkq+9wk7P
 FZTvP6hJwFAwemb4YK/EBc0AYi+Jio2L2Cz4z9Jzif/+gS9lrKqcbvLS8xSIFnXUsAhAbifaoUHRx
 Hl3Xi9Bh6iSiameM=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9JDp-0004b8-C4 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 09:25:03 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48442ea8f59so833851f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790155495; x=1790760295; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7SDaa8OUO9OFT9zAYh9E0XmwU744X767wsGiPxQqxKY=;
 b=X6yMdPZKOLpspJSMirWpQfbdVBnYTamXCqXRwBx7nTFQ4qmgZpANb0e0mW6BErhKAt
 hcZiWR3kmd1cLKVqUOH3NxCZ8agT8W6ZqMWUuBzaV4rcHDDOeHBuKLa0nI0u3z/nDSFs
 wI2J0l6a7i+ZodBa/JsYhleMo34wll/E0onKXmyT/O2sQ32jEoB3cXDHUQuOlgjgkYQo
 kxejMr+bd19zB/hYkKu+m36tMUcFsgJkbe0NO7q+11cJkk9c3rRMpNooePmbQYeJfi7s
 Mg7NRO3GRfTt0zZSko3qFExz7e2U/6cttn8Vs626TsiGllx3Akqg7CPZQTXAmoMlTIUg
 oZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790155495; x=1790760295;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7SDaa8OUO9OFT9zAYh9E0XmwU744X767wsGiPxQqxKY=;
 b=lwY/ToLhhnIUMLbP62AAlSiw3Qlpzt3ab2jgKBAwbZkAjPYBH8PIV3ItixrI6Z9Eth
 2YK1Z1a7qRFeWT6USGrqqHDc3nKxy+n1FzEtWDgbp6bg3ALIr/9poCnYiVqV2J7l+NbQ
 +I7x48l0oZH9EPq9WCn8ZFa3XEFKCHulOvSSSbLbF+MGOgawfp7p5BBZ8Aaq0AsUHq1R
 2iL6yOlvl7If46kKJUU3V7NGqAcD8ULAuf0aB81UDtOaEPHgU/Rv6XUHuMVT/qCu6NM4
 z1N0sLKyvbBYSAOOLJLNAcS0E7Ez3D2rbM4y6OBT7G8OBVMBuBrPP8NITBqNIgmoynX0
 fmCw==
X-Gm-Message-State: AFuF++n1GyWtAxdCa5wJ4wmkvZehwWwWmL23xKDT2KsVql/jQFvaQG8m
 v9oFjdEp43DCtZLGfCygEaOrR1XD1xtdSjBwUHkkbNkC74qi4MUtZE2rfoFCJ8S1zBH7yjLuAY4
 JSs0LXatnGt+4uJIB0QpyPniMV58bratvQ9lBH1S75pBiO42PkQUpvyx61cRUtaU0RMjox/gdcO
 43GgpMgQ==
X-Gm-Gg: AYBFou0fzM7V9w5CBLdc34UkhqKEnWWfU9QxiJ6VciLHA5DVBJWc6YxNBKiyT5tK9V+
 2iIAnf26jEQwdpgabItnweHpmMTJ8ikhOTTBhZRU3n6Z1xvODqYebpIAF2FvBGzHBtZxEXM9qib
 BvFHhDsr9Pf4DK7buJuf81dn74hNqoUylemXp5vYup8rEk4RpFRYxJBgMIV97ReBxHxJ4qrYbld
 lvO8PZr2bR5UKqXZFMTh1WqB3ExiN3WANJT2GD0B5XvirK7GOEnKQ6LrsdaPtZhe4LOGhq1IdOs
 mxYpEJvIosNeMNcWfySoEdeaEeF6M1MZ38WFTHQN9CvQA1IVRAVEBhQ1FpjgXXCLrf/f1iR5V3S
 kgoDJRmzgWIE28R5cnMc0GQbiMzhplr2kaJ2V8xpUgb7bdvDlr852Tozl+bGgG+hLWi5Bt8vfR0
 nzJ9G0285Hy4sxkf9D1Lgr030IqTf4PqnCzf1GLf3AnrG9CYfVtqXCKIm8PYdE0hf6elBDfGnA8
 zjQulXni8q+UsmMheauxrnURDrcXVkAXB+8gKW2Qz9ffvcXsjVvHxImTmhS6SjMECE79U4t18Rw
 /yXqHkDj7s31q0KdlEUsQ4Ym30G38DtqWzG1zZva5OJkNha4m9PYdJtUK8MH
X-Received: by 2002:a05:6000:481c:b0:486:fcf2:fdf7 with SMTP id
 ffacd0b85a97d-48860fd5354mr8741555f8f.14.1790155494436; 
 Wed, 23 Sep 2026 02:24:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488687791cdsm5076940f8f.22.2026.09.23.02.24.53
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 02:24:53 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 09:24:53 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I98f33343d35453219e43b8730cc10bcef119ea20
X-Gerrit-Change-Number: 1944
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1944?usp=email>
X-Gerrit-Commit: ab8bbcb4c70a4f775cae0c445e2a654109c9d701
References: <gerrit.1790155491000.I98f33343d35453219e43b8730cc10bcef119ea20@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMTU1NDkxMDAwLkk5OGYzMzM0M2QzNTQ1MzIxOWU0M2I4NzMwY2MxMGJjZWYxMTllYTIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <496ec1743d9efdd254f4ddc272b3571a69119092-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9JDp-0004b8-C4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Inline ret
 definition in dco_linux.c
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7373753913158559241=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7373753913158559241==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cZCFJAGyZZU="; charset=UTF-8

--cZCFJAGyZZU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1944?usp=3Demail )


Change subject: Inline ret definiti=
on in dco_linux=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Inline ret definition in dco_linux=2Ec

These are never read and th=
en directly overwritten by the return
value of the send function=2E Inline =
these to make the code a bit
cleaner=2E

Found by cppcheck=2E

Change-Id: I=
98f33343d35453219e43b8730cc10bcef119ea20
Signed-off-by: Arne Schwabe <arne@=
rfc2549=2Eorg>
---
M src/openvpn/dco_linux=2Ec
1 file changed, 9 insertions=
(+), 17 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/44/1944/1

diff --git a/src/openvpn/dco_linux=2Ec b/src/ope=
nvpn/dco_linux=2Ec
index 56f6259=2E=2E8f5f26a 100644
--- a/src/openvpn/dco_=
linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -235,7 +235,6 @@
 
     struct=
 nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_NEW);
     str=
uct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
-    int ret =3D =
-EMSGSIZE;
 
     NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);
     NLA_PUT=
_U32(nl_msg, OVPN_A_PEER_SOCKET, sd);
@@ -289,7 +288,7 @@
     }
     nla_n=
est_end(nl_msg, attr);
 
-    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func_=
_);
+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_fa=
ilure:
     nlmsg_free(nl_msg);
@@ -545,11 +544,10 @@
     }
 
     struct =
nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);
-    int ret =3D -=
EMSGSIZE;
     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);
     nl=
a_nest_end(nl_msg, attr);
 
-    ret =3D ovpn_nl_msg_send(dco, nl_msg, __fu=
nc__);
+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put=
_failure:
     nlmsg_free(nl_msg);
@@ -569,11 +567,11 @@
     }
 
     stru=
ct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
-    int ret =3D -=
EMSGSIZE;
+
     NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);
     nla_nest=
_end(nl_msg, attr);
 
-    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);=

+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failu=
re:
     nlmsg_free(nl_msg);
@@ -584,7 +582,6 @@
 int
 dco_del_key(dco_cont=
ext_t *dco, unsigned int peerid, dco_key_slot_t slot)
 {
-    int ret =3D -=
EMSGSIZE;
     msg(D_DCO_DEBUG, "%s: peer-id %d, slot %d", __func__, peerid=
, slot);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_C=
MD_KEY_DEL);
@@ -598,7 +595,7 @@
     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SL=
OT, slot);
     nla_nest_end(nl_msg, keyconf);
 
-    ret =3D ovpn_nl_msg_s=
end(dco, nl_msg, __func__);
+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, =
__func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -625,8 +622,6 @@=

 
     dco_cipher_t dco_cipher =3D dco_get_cipher(ciphername);
 
-    int =
ret =3D -EMSGSIZE;
-
     struct nlattr *key_conf =3D nla_nest_start(nl_msg=
, OVPN_A_KEYCONF);
     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid)=
;
     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT, slot);
@@ -652,7 +647,7 @@
=
     nla_nest_end(nl_msg, key_conf);
 
 
-    ret =3D ovpn_nl_msg_send(dco,=
 nl_msg, __func__);
+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__=
);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -673,13 +668,12 @@
     =
}
 
     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
-    =
int ret =3D -EMSGSIZE;
     NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);
  =
   NLA_PUT_U32(nl_msg, OVPN_A_PEER_KEEPALIVE_INTERVAL, keepalive_interval);=

     NLA_PUT_U32(nl_msg, OVPN_A_PEER_KEEPALIVE_TIMEOUT, keepalive_timeout)=
;
     nla_nest_end(nl_msg, attr);
 
-    ret =3D ovpn_nl_msg_send(dco, nl_=
msg, __func__);
+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);
 =

 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -754,10 +748,9 @@
 
     gen=
lmsg_put(nl_msg, 0, 0, dco->ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);
 
-    in=
t ret =3D -EMSGSIZE;
     NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY_NAME, OVP=
N_FAMILY_NAME);
 
-    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);
+  =
  int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
=
     nlmsg_free(nl_msg);
@@ -1192,7 +1185,6 @@
 
     struct nl_msg *nl_msg=
 =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);
     struct nlattr *att=
r =3D nla_nest_start(nl_msg, OVPN_A_PEER);
-    int ret =3D -EMSGSIZE;
 
  =
   if (peer_id !=3D -1)
     {
@@ -1204,7 +1196,7 @@
     }
     nla_nest_e=
nd(nl_msg, attr);
 
-    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);
+=
    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure=
:
     nlmsg_free(nl_msg);

-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1944?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I98f33343d35453219e43b8730cc10bcef119ea20
Gerrit-Change-Number: 194=
4
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--cZCFJAGyZZU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1944?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Inline ret definition in dco_linux=2Ec<br><br>These are never read=
 and then directly overwritten by the return<br>value of the send function=
=2E Inline these to make the code a bit<br>cleaner=2E<br><br>Found by cppch=
eck=2E<br><br>Change-Id: I98f33343d35453219e43b8730cc10bcef119ea20<br>Signe=
d-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/d=
co_linux=2Ec<br>1 file changed, 9 insertions(+), 17 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/44/1944/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openv=
pn/dco_linux=2Ec</span><br><span>index 56f6259=2E=2E8f5f26a 100644</span><b=
r><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/d=
co_linux=2Ec</span><br><span>@@ -235,7 +235,6 @@</span><br><span> </span><b=
r><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_=
PEER_NEW);</span><br><span>     struct nlattr *attr =3D nla_nest_start(nl_m=
sg, OVPN_A_PEER);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int ret =3D -EMSGSIZE;</span><br><span> </span><br><span>     NLA_PUT_U32(n=
l_msg, OVPN_A_PEER_ID, peerid);</span><br><span>     NLA_PUT_U32(nl_msg, OV=
PN_A_PEER_SOCKET, sd);</span><br><span>@@ -289,7 +288,7 @@</span><br><span>=
     }</span><br><span>     nla_nest_end(nl_msg, attr);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg=
_send(dco, nl_msg, __func__);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><b=
r><span> </span><br><span> nla_put_failure:</span><br><span>     nlmsg_free=
(nl_msg);</span><br><span>@@ -545,11 +544,10 @@</span><br><span>     }</spa=
n><br><span> </span><br><span>     struct nlattr *attr =3D nla_nest_start(n=
l_msg, OVPN_A_KEYCONF);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int ret =3D -EMSGSIZE;</span><br><span>     NLA_PUT_U32(nl_msg, OVPN_=
A_KEYCONF_PEER_ID, peerid);</span><br><span>     nla_nest_end(nl_msg, attr)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int ret =3D ovpn_nl_msg_send(dco, nl_msg=
, __func__);</span><br><span> </span><br><span> nla_put_failure:</span><br>=
<span>     nlmsg_free(nl_msg);</span><br><span>@@ -569,11 +567,11 @@</span>=
<br><span>     }</span><br><span> </span><br><span>     struct nlattr *attr=
 =3D nla_nest_start(nl_msg, OVPN_A_PEER);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int ret =3D -EMSGSIZE;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>     NLA_PUT_U32(nl_msg, OVPN_A=
_PEER_ID, peerid);</span><br><span>     nla_nest_end(nl_msg, attr);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D=
 ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func_=
_);</span><br><span> </span><br><span> nla_put_failure:</span><br><span>   =
  nlmsg_free(nl_msg);</span><br><span>@@ -584,7 +582,6 @@</span><br><span> =
int</span><br><span> dco_del_key(dco_context_t *dco, unsigned int peerid, d=
co_key_slot_t slot)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int ret =3D -EMSGSIZE;</span><br><span>     msg(D_DCO_=
DEBUG, &quot;%s: peer-id %d, slot %d&quot;, __func__, peerid, slot);</span>=
<br><span> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_c=
reate(dco, OVPN_CMD_KEY_DEL);</span><br><span>@@ -598,7 +595,7 @@</span><br=
><span>     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT, slot);</span><br><span=
>     nla_nest_end(nl_msg, keyconf);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, =
__func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int r=
et =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span> </span><br=
><span> nla_put_failure:</span><br><span>     nlmsg_free(nl_msg);</span><br=
><span>@@ -625,8 +622,6 @@</span><br><span> </span><br><span>     dco_ciphe=
r_t dco_cipher =3D dco_get_cipher(ciphername);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D -EMSGSIZE;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     struc=
t nlattr *key_conf =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);</span><br><s=
pan>     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);</span><br><sp=
an>     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT, slot);</span><br><span>@@ =
-652,7 +647,7 @@</span><br><span>     nla_nest_end(nl_msg, key_conf);</span=
><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D ovpn_nl_msg_send(=
dco, nl_msg, __func__);</span><br><span> </span><br><span> nla_put_failure:=
</span><br><span>     nlmsg_free(nl_msg);</span><br><span>@@ -673,13 +668,1=
2 @@</span><br><span>     }</span><br><span> </span><br><span>     struct n=
lattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ret =3D -EMSGSIZE;</span><br><span>=
     NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);</span><br><span>     NLA_=
PUT_U32(nl_msg, OVPN_A_PEER_KEEPALIVE_INTERVAL, keepalive_interval);</span>=
<br><span>     NLA_PUT_U32(nl_msg, OVPN_A_PEER_KEEPALIVE_TIMEOUT, keepalive=
_timeout);</span><br><span>     nla_nest_end(nl_msg, attr);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl=
_msg_send(dco, nl_msg, __func__);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</spa=
n><br><span> </span><br><span> nla_put_failure:</span><br><span>     nlmsg_=
free(nl_msg);</span><br><span>@@ -754,10 +748,9 @@</span><br><span> </span>=
<br><span>     genlmsg_put(nl_msg, 0, 0, dco-&gt;ctrlid, 0, 0, CTRL_CMD_GET=
FAMILY, 0);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int ret =3D -EMSGSIZE;</span><br><span>     NLA_PUT_STRING(nl_m=
sg, CTRL_ATTR_FAMILY_NAME, OVPN_FAMILY_NAME);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco,=
 nl_msg, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span> <=
/span><br><span> nla_put_failure:</span><br><span>     nlmsg_free(nl_msg);<=
/span><br><span>@@ -1192,7 +1185,6 @@</span><br><span> </span><br><span>   =
  struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);<=
/span><br><span>     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_=
PEER);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D=
 -EMSGSIZE;</span><br><span> </span><br><span>     if (peer_id !=3D -1)</sp=
an><br><span>     {</span><br><span>@@ -1204,7 +1196,7 @@</span><br><span> =
    }</span><br><span>     nla_nest_end(nl_msg, attr);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_=
send(dco, nl_msg, __func__);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br=
><span> </span><br><span> nla_put_failure:</span><br><span>     nlmsg_free(=
nl_msg);</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1944?usp=3Demail">change 1944</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1944?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I98f33343d35453219e43b8730=
cc10bcef119ea20 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
944 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--cZCFJAGyZZU=--


--===============7373753913158559241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7373753913158559241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7373753913158559241==--

