Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA62606A322
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=e+BDaT71;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=K0XmnZ9W;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PFMgAmqa;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Q/mBBtny
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rNOtEEcNBbQz0awfl7YgSPfb6AG0kAXISrPPgZt9avs=; b=e+BDaT71Oiv1qodPYWgnqD2Uoo
	YsI/RIuOt4aVQRhb9q75RSN/AGyQKxzFpbzQTl776AiE5ItWRFyrOHp6KSqfvMP9Aygk4MJ8mj7qY
	UeUuHUNvi6r+j+EsvaU5WGawEbDI3a5jC3cvA6NdBkpvDukQdToVtvIUvlRfBH77RBUo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT1sM-000000007to-2ZMz;
	Mon, 16 Nov 2026 18:56:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT1sL-000000007th-0jql
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 18:56:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HvH1TrFmpmQV+YvfBje4lzxcy76o/fPNoF+vu9ufDMg=; b=K0XmnZ9WEpGpLXaCIIJ/Z/+ktm
 OkWpGsy2sX0z6thebIqSfK/WFr9EybgMKq/fAlwlhBUqjG4aYfNTGaA/oDl5iK36k9d2/U2i1bpG6
 up/pYTUXlwCU1wQbJrLoI0kK1iA34om0f6CnO1gdjub0yPPCZ/VOdQervueWJaiXwUG8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HvH1TrFmpmQV+YvfBje4lzxcy76o/fPNoF+vu9ufDMg=; b=PFMgAmqa3JpwePMyACWjBvABrO
 25e0ZkZyoKGagJxOMMOtB4fLbKRcaRFbJI3OwuDpxXlUtc9OHsUIEvnMGl3osxEhPSgkbBb49tkrs
 uOeE2PRiLYHyX4F3QDVoa1nf4cRqM+qAMo3Ki6gzunh0NCcaOwHqPkvLu7dNPgKGhbQ4=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT1sK-000000006tD-0jXp for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 18:56:21 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso31431465e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 10:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794855373; x=1795460173; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HvH1TrFmpmQV+YvfBje4lzxcy76o/fPNoF+vu9ufDMg=;
 b=Q/mBBtny2eEAzOfTmX2mpb7KnkrCNHiLSlcIoHK7Gw/dXpujVXle3+yBmZ/XjAebHU
 SFdISZtpYnPmH+XrVrR3jLGg9gow5i2ghlHzAn57puvGJKXfmbsnvmMPg+3QTvERe29T
 Xb/ITCZURIjqcNFP/h1zubr0kf4qAFlxFz+vtUmCqWNPiLX9fvjqJuE5ITnOd4Q1VBA6
 HyD+EYFQDBoqzmz/7U8eue2fI1i44TOL63oz2q42ntMtFjm56BMbHHdLUYF9u6mcShix
 KOUWTPZ/X5r/B05BWi0olj6ZVC1/G5l7s+rz9az9HIOfexJlcR3PvY06FhEamWp4MOtF
 jFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794855373; x=1795460173;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HvH1TrFmpmQV+YvfBje4lzxcy76o/fPNoF+vu9ufDMg=;
 b=0lg0ILDuKkiiq5CY6a40oMN1V809rqePGz/krxd4JZaJinBiiHJMvs8u4hqbQkA9ql
 OHmV9Q3cqaNAARCpSRZrHzhvgyjCDQVwC5Y9i5ejq98OwxuT8nR7VM5VYJStu02HS8mx
 m56rp8IN7gF8uo4aOPQKmFMpY4zDGg16MsaP0Fg1NAY738viSKrEEMm8pBIkzt5tfkxB
 EqMuCQPjgX+VYGHqSaQplVvQOw6Q/S3L7V2QrN4EkyVtzF/WRYdVPXdTNbey3ig33d4J
 BqMBLv0952CAjycP/Wxfv/y7D7UxEEUvlTZ2ARtHBLrpO9PhPBx+sJQjovzOENZgkA1Z
 8/Hg==
X-Gm-Message-State: APuU4Z9GmZYGzR5/YLBSvxs3DinJCMrMbSgIA0ZcPz9EZ0Ja45snrGLu
 lGx+9ltHdwlpa+2bzzGOUK1YmN4wLhQgsLBcQoN4GTntxCOcxrfT9tenN6Ccz0OMEIBg7RJbVp1
 lh7bc/h8fWAbaoHZDVeV4PFEL7c7nz9ejNrkhdkIHRSN/2MyKgL0n+EPPv9YfKNT3lioq
X-Gm-Gg: AYBFou3JOSbrdWrIpZXCeYXYwsa6CrlQzgT3j9Kq/Ys9MmZjMZPIp0L8PKyHZyNRYD5
 Xqu0OjkiokKob/vDlBbO2jqx1WVAPhvmOUwS8TU55A48C2hacrYuO7Sp8FsN5bWwPTy6TF1WEBg
 I5u7H27X8cjyWZTRSFxb31f1EKa6yovg/IXwETAUwwqN03o24mJLijlqMZ3fi0tpnvGX3y8FPyC
 fwk71d+q6QZRiDg5Zf5tIqBecygDZ0/T6TDq10l1zvMNTmjGJTY4eFHfIeLa4TycOYYYuIvimMX
 /HXM+rKhxlctk7wptVKa1i+BwkwfG+Fq6r33C9JBqtBdlc/vxdhZagrYhUfj4gdw348u3aJjR0h
 pYYYaJ8R4+iQ5QQCiZR3cxh3AccSc/px2ENH+JHArcizu7OsJQynqfFEIfRuuztDTfriiuxGy0f
 QElTl31R9KqbJR+Ve/jBPfiCMxAJyPc79N7hG4fMFxANi1ycTgWN3mm0DJziNXdah450vY4M/eo
 FTGEn6LgtNbcO3M6KNID3RBUGjFLG6NddEWWG4BBji3azLwqutjjfbvVnT4WAZmOBXUqIoPgeUL
 DXvzzVJ89NtlKGBqMtS4h2OZta075reCTctHJcc1DO9ytowofx24jtzTqNuE9kvvymaTMzPiSrL
 kR6o0B/IyXyal+i0CtmGjL+TG6PTvoorRI2z6A0sibR0tXPNwn92OK55Yb8rWLiDP/gfeBW5wSl
 vGHP0QIdmFgzQdoUygwVhrNJjMIfRgaiQTeZEx
X-Received: by 2002:a05:600c:b95:b0:4a2:d99:3171 with SMTP id
 5b1f17b1804b1-4bb55aa3688mr263834775e9.23.1794855373390; 
 Mon, 16 Nov 2026 10:56:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783854cesm13322405e9.1.2026.11.16.10.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:56:13 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 18:56:12 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Idb3c52174e588016240e9c9162a1676e1531c551
X-Gerrit-Change-Number: 2101
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2101?usp=email>
X-Gerrit-Commit: bbc14868ef99a16eda987396b890ec8df6427dcf
In-Reply-To: <gerrit.1793693047000.Idb3c52174e588016240e9c9162a1676e1531c551@gerrit.openvpn.net>
References: <gerrit.1793693047000.Idb3c52174e588016240e9c9162a1676e1531c551@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjkzMDQ3MDAwLklkYjNjNTIxNzRlNTg4MDE2MjQwZTljOTE2MmExNjc2ZTE1MzFjNTUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f59428322a645a2d8cdbc6a7721cbc806b27c653-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT1sK-000000006tD-0jXp
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: check
 ovpn_dco_nlmsg_create() result in new/get peer
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1657167783591756960=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1657167783591756960==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y3MWTkRY9X0="; charset=UTF-8

--y3MWTkRY9X0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2101?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Antonio Quartulli


Change subject: dco_linux: check ovp=
n_dco_nlmsg_create() result in new/get peer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_linux: check ovpn_dco_nlmsg_create() re=
sult in new/get peer

dco_new_peer() and dco_get_peer() passed the result s=
traight to
nla_nest_start() without checking for NULL=2E Return -ENOMEM lik=
e the
other callers=2E

dco_new_peer() unchecked since e34437c2 ("dco: intr=
oduce low-level code
for handling ovpn-dco in the Linux kernel"), dco_get_p=
eer() since
5a8fb55a ("dco-linux: implement dco_get_peer_stats{, multi} API=
")=2E

Change-Id: Idb3c52174e588016240e9c9162a1676e1531c551
Signed-off-by: =
Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Antonio Quartulli <antoni=
o@mandelbit=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
101
Message-Id: <20261116102516=2E14493-1-gert@greenie=2Emuc=2Ede>
URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41=
409=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/=
openvpn/dco_linux=2Ec
1 file changed, 11 insertions(+), 0 deletions(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/01/2101/2
=

diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 6=
0107c4=2E=2E3a55b6e 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvp=
n/dco_linux=2Ec
@@ -239,6 +239,12 @@
     msg(D_DCO_DEBUG, "%s: peer-id %u,=
 fd %d, remote addr: %s", __func__, peerid, sd, remotestr);
 
     struct n=
l_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_NEW);
+    if (!=
nl_msg)
+    {
+        gc_free(&gc);
+        return -ENOMEM;
+    }
+
   =
  struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
     int ret=
 =3D -EMSGSIZE;
 
@@ -1234,6 +1240,11 @@
     msg(D_DCO_DEBUG | M_NOIPREFIX=
, "%s: peer-id %d", __func__, peer_id);
 
     struct nl_msg *nl_msg =3D ov=
pn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);
+    if (!nl_msg)
+    {
+    =
    return -ENOMEM;
+    }
+
     struct nlattr *attr =3D nla_nest_start(nl=
_msg, OVPN_A_PEER);
     int ret =3D -EMSGSIZE;
 

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2101?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: Idb3c52174e588016240e9c9162a1676e1531c55=
1
Gerrit-Change-Number: 2101
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio=
@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--y3MWTkRY9X0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2101?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Antonio Quartulli</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">dco_linux: check ovpn_dco_nlmsg_create() result in new/get peer<br><br>=
dco_new_peer() and dco_get_peer() passed the result straight to<br>nla_nest=
_start() without checking for NULL=2E Return -ENOMEM like the<br>other call=
ers=2E<br><br>dco_new_peer() unchecked since e34437c2 (&quot;dco: introduce=
 low-level code<br>for handling ovpn-dco in the Linux kernel&quot;), dco_ge=
t_peer() since<br>5a8fb55a (&quot;dco-linux: implement dco_get_peer_stats{,=
 multi} API&quot;)=2E<br><br>Change-Id: Idb3c52174e588016240e9c9162a1676e15=
31c551<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>A=
cked-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2101<br>Message-Id: &lt;202611161=
02516=2E14493-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41409=2Ehtml<br>Signed=
-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openv=
pn/dco_linux=2Ec<br>1 file changed, 11 insertions(+), 0 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/01/2101/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/o=
penvpn/dco_linux=2Ec</span><br><span>index 60107c4=2E=2E3a55b6e 100644</spa=
n><br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openv=
pn/dco_linux=2Ec</span><br><span>@@ -239,6 +239,12 @@</span><br><span>     =
msg(D_DCO_DEBUG, &quot;%s: peer-id %u, fd %d, remote addr: %s&quot;, __func=
__, peerid, sd, remotestr);</span><br><span> </span><br><span>     struct n=
l_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_NEW);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!nl_msg)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return -ENOMEM;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>     struct nlattr *attr =3D nla_n=
est_start(nl_msg, OVPN_A_PEER);</span><br><span>     int ret =3D -EMSGSIZE;=
</span><br><span> </span><br><span>@@ -1234,6 +1240,11 @@</span><br><span> =
    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: peer-id %d&quot;, __func__, pe=
er_id);</span><br><span> </span><br><span>     struct nl_msg *nl_msg =3D ov=
pn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!nl_msg)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return -ENOMEM;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_P=
EER);</span><br><span>     int ret =3D -EMSGSIZE;</span><br></pre><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2101?usp=3De=
mail">change 2101</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2101?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Idb3c52174e588016240e9c9162a1676e1531c551 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2101 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>

</body></html>
--y3MWTkRY9X0=--


--===============1657167783591756960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1657167783591756960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1657167783591756960==--

