Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7E606A323
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ltR3gjO9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WW893fCG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PSO5HA7C;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UiU4uoxu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=P5/u2LB1Gw9Z7gz13QJEIw/m4U2ncMQaVDfMzSjn0Nc=; b=ltR3gjO9MA9oDhVQnEP9+6rk4c
	X8WvDEm1Erp8hDvJO8sfwFmWUu21A7HCd8RBQuxc0uN2n9AW2K6eVxX7Nu5/oFTKH8orJBN1UiWeO
	+5kwO5pfcBKyt8yidAAvVyJPp+e955jPbaRHMWIfDzTT3heuE8Y1mrpnldFcetDFtmrI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRoMU-000000004k6-2WZV;
	Fri, 13 Nov 2026 10:18:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRoMS-000000004jo-1mmH
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 10:18:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=05dBZERfbrQo/qm0KjH5o9ZVdhn+40H2lkz3dJV7J3g=; b=WW893fCGLU+IKStckKJFiNzjeK
 /MqM4zoLfqPQdOIc4JfHGV4GQT2Au5HYbZ5uCsgkJDiFEjn7N9upXVOFbApir4jWCiABc5g4iUcIR
 auVJbKmVoJ+FAjYh2lNvx3iYZ2mW0HUVdtYvUMh0tFQktJEw9wpT8OZstrhNxrTR5pSI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=05dBZERfbrQo/qm0KjH5o9ZVdhn+40H2lkz3dJV7J3g=; b=PSO5HA7Cx+K4O9MKh9LgaANHh0
 LB4K2nFv1q5hhDu68KRicdw5YqNHu5rJCsh6PToEFsqp8+P13JvtR3GwYLQlmdSwmxVHKA3aI3cWB
 mDFCCEYfGm1mYbXMTma9K3qVK3NPbYbyB8GNFohOCHeBWnGq6MTB2T5ZA1mE1ksyKh5s=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRoMP-000000000ra-3Ife for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 10:18:22 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so3465095e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 02:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794565095; x=1795169895; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=05dBZERfbrQo/qm0KjH5o9ZVdhn+40H2lkz3dJV7J3g=;
 b=UiU4uoxu0WAJ6LTiW4QOrj+pG3oA4/mBVRRDYZDMojF5wWibS4XllcPshekHhWF+Th
 udvA53TEUFDGvEFQSxDMjC1lOsQMyS2PyfvOTj14GKcVyZ0UZZvIy8onfQDEyI+SLU4L
 IgHCeku+g/ppIV1rztGM2BD3b5iGwdL1EcifO5RmWUoXPkbm9w7KkKT4kQzdgWmvTpOJ
 mT+CcCeB11V6AC0lZU1YHslVokcaLj+88zBDGO+x7nDOeLUnAjBY/Bp4fPAMYha5oFw9
 kJUd9f2sYR80p/FNpXK3TsNyNV4hOZIrgcb1PaehHL3jfh28t4Covv+LOWNywL+MHKvs
 pYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794565095; x=1795169895;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=05dBZERfbrQo/qm0KjH5o9ZVdhn+40H2lkz3dJV7J3g=;
 b=ZgnFuv6JJigJ3tW38Yb6tbdbwKfABh3enRivOwHQOJU8IDCilA8mbKY+jF7G3xN8uB
 NyRV8wmdcmZ1KKSh99ECfDMBLt9ywfgungO7ThkoACx7rMD+jUcHaVS2a+Nsspkvbnmk
 i8VD9xZV4gVH1mdHU53WZ8LLJLl+NKaizTzI7lGUHejKkvC4DNIQvrHX88kV7QKxdYzc
 4zoQ55etF1lbuj10UFWNTvAIKMN+jOBh2zD3b8MkbQtgW/pvDiQVOlYvi0Pcp2F0+W2T
 yDL4lTkatHZaYKQ68sZsHhLScOAzyGfdgerVkPcF3JCcaqE1wpUGjn46c+/PFOWkb048
 9+8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFPxMpVIy0+RLcPkIw0nwW6p07iwSayxxGpgW3FySPb1ERGpqTMd78QkZTj0TYqc1cL4gb0GJ6B5DkEVl+S@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+2p3T/yy+ndeCsX226Qs/Qb4LiQroy/i/a43FSfqXKrprkjHi6
 AuWf4bMFpAwSIKoa9k54ToDJgjTdVxxpz25KD9roFtFgl8CQyTNZL6xNKOChhgZWewf0l4K7ltK
 fwuAft1+M5l2kAUl2mUeJ9w0vgCl6/8jCG9RFqfgOpP/OfansniRr/o5wJIQJjjwVVw2W
X-Gm-Gg: AYBFou3ZswqjRraeHsZLIEM0ubmqts0j2uLVjVzDRyzsdJ4hHDIdIUTKkJmNfDmIEnx
 CTWMdW+vWG44iaBsm6fdjPOVJjKRgwbZxKbKsBFVDPBhcuYakRCWLDYyCfH1QhuuwvRSqdhzNrH
 zKSGBSY7dcXr7GUvvPsWhe+yZotPY7uTlMmnauZSp8G1LC+MbE+YSAKyo4vX5LXJT8Vjgna+C4z
 3v4ERJHDjMAhJZ5B3pZC7JYClytiTCaP02adOtwu+5+mRGMDuAA4lTEtldmK1qhxfjABOwjBdpt
 318ahTAK1FNLAvA+aZ/nk4bnA9enRj/1N0eigblO771BCLOvWpbrncb/zSOHfktSpyAmhKppJYR
 ozdx84fS+I9uNWs60vL1QNW5hsBC+qglaT2KpQy76u4aKE7uiTZVuPWX4DUFWnC0L1O10PPh7Tw
 tO8hnjh+UgUoI40f4MTe+Zxh2hVo2SnVQlNgkzlJCL+FmwWwu/9X8ew3guXVNarccLOJJ5hWhBn
 xsSiRd2PN1zr+5PEbb2I+OBfNuu5gOSCr2X6ZY8CV3OkNw2cEFcc1xsN6B2/IzVyTV+Sz5zSNBS
 MhE2yKwnMNFI651bpjS93JDfQDJIjpFh252wCPGJXwzRdVeTEDsM1XHnX+hqrMmju0aMdkyzF9l
 mf7Hr88vD/RJ/hA/YnHhwfoed/LS1yDkTAdVXO9I1kqD60HKlHCg2fB7y+IhcSFBFuKhSEMwOWu
 4QT3kjI6P3IObFGoQ=
X-Received: by 2002:a05:600c:4f81:b0:4a1:e7ce:107b with SMTP id
 5b1f17b1804b1-4bb55a25c66mr40601545e9.2.1794565094961; 
 Fri, 13 Nov 2026 02:18:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55a68c65sm52813475e9.2.2026.11.13.02.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 02:18:14 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 10:18:14 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5a827f4c6d169420504a48e13ee6eb28053dbc4c
X-Gerrit-Change-Number: 2167
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2167?usp=email>
X-Gerrit-Commit: c034bee07fecf24cb1e1574d5904f67874a5b022
In-Reply-To: <gerrit.1794320197000.I5a827f4c6d169420504a48e13ee6eb28053dbc4c@gerrit.openvpn.net>
References: <gerrit.1794320197000.I5a827f4c6d169420504a48e13ee6eb28053dbc4c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzIwMTk3MDAwLkk1YTgyN2Y0YzZkMTY5NDIwNTA0YTQ4ZTEzZWU2ZWIyODA1M2RiYzRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9baba940afae764ee6c771d1042ef107b35156fd-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRoMP-000000000ra-3Ife
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: drop dead
 code in inherit_context_child()
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0801989370189217128=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0801989370189217128==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Iykd1U44sdU="; charset=UTF-8

--Iykd1U44sdU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2167?usp=3Demail )

Change subject: init: drop dead code in inh=
erit_context_child()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

init: drop dead code in inherit_context_child()

The ciphername/aut=
hname copies are overwritten by the
dest->options =3D src->options assignme=
nt that follows, and the
trailing IS_SIG() return is a no-op=2E

Change-Id:=
 I5a827f4c6d169420504a48e13ee6eb28053dbc4c
Signed-off-by: Razvan Cojocaru <=
razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167
Message-Id: <=
20261110150100=2E17824-1-gert@greenie=2Emuc=2Ede>
URL: https://lore=2Ekerne=
l=2Eorg/openvpn-devel/20261110150100=2E17824-1-gert@greenie=2Emuc=2Ede
Sign=
ed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/init=2E=
c
1 file changed, 0 insertions(+), 7 deletions(-)




diff --git a/src/open=
vpn/init=2Ec b/src/openvpn/init=2Ec
index aef2f14=2E=2E25521f3 100644
--- a=
/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -4737,9 +4737,6 @@
    =
 dest->c1=2Eks=2Etls_wrap_key =3D src->c1=2Eks=2Etls_wrap_key;
     dest->c=
1=2Eks=2Etls_auth_key_type =3D src->c1=2Eks=2Etls_auth_key_type;
     dest-=
>c1=2Eks=2Etls_crypt_v2_server_key =3D src->c1=2Eks=2Etls_crypt_v2_server_k=
ey;
-    /* inherit pre-NCP ciphers */
-    dest->options=2Eciphername =3D =
src->options=2Eciphername;
-    dest->options=2Eauthname =3D src->options=
=2Eauthname;
 
     /* inherit auth-token */
     dest->c1=2Eks=2Eauth_toke=
n_key =3D src->c1=2Eks=2Eauth_token_key;
@@ -4796,10 +4793,6 @@
     }
 
  =
   init_instance(dest, src->c2=2Ees, CC_NO_CLOSE | CC_USR1_TO_HUP);
-    if=
 (IS_SIG(dest))
-    {
-        return;
-    }
 }
 
 void

-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I5a827f4c6d169420504a48e13ee6eb28053d=
bc4c
Gerrit-Change-Number: 2167
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Iykd1U44sdU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2167?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">init: drop dead code in inherit_co=
ntext_child()<br><br>The ciphername/authname copies are overwritten by the<=
br>dest-&gt;options =3D src-&gt;options assignment that follows, and the<br=
>trailing IS_SIG() return is a no-op=2E<br><br>Change-Id: I5a827f4c6d169420=
504a48e13ee6eb28053dbc4c<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167<br>Message=
-Id: &lt;20261110150100=2E17824-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://lore=2Ekernel=2Eorg/openvpn-devel/20261110150100=2E17824-1-gert@greenie=
=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M src/openvpn/init=2Ec<br>1 file changed, 0 insertions(+), 7 dele=
tions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/i=
nit=2Ec</span><br><span>index aef2f14=2E=2E25521f3 100644</span><br><span>-=
-- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span>=
<br><span>@@ -4737,9 +4737,6 @@</span><br><span>     dest-&gt;c1=2Eks=2Etls=
_wrap_key =3D src-&gt;c1=2Eks=2Etls_wrap_key;</span><br><span>     dest-&gt=
;c1=2Eks=2Etls_auth_key_type =3D src-&gt;c1=2Eks=2Etls_auth_key_type;</span=
><br><span>     dest-&gt;c1=2Eks=2Etls_crypt_v2_server_key =3D src-&gt;c1=
=2Eks=2Etls_crypt_v2_server_key;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* inherit pre-NCP ciphers */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    dest-&gt;options=2Eciphername =3D src-&gt;option=
s=2Eciphername;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    de=
st-&gt;options=2Eauthname =3D src-&gt;options=2Eauthname;</span><br><span> =
</span><br><span>     /* inherit auth-token */</span><br><span>     dest-&g=
t;c1=2Eks=2Eauth_token_key =3D src-&gt;c1=2Eks=2Eauth_token_key;</span><br>=
<span>@@ -4796,10 +4793,6 @@</span><br><span>     }</span><br><span> </span=
><br><span>     init_instance(dest, src-&gt;c2=2Ees, CC_NO_CLOSE | CC_USR1_=
TO_HUP);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (IS_SI=
G(dest))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br></pre><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167?usp=3Demail">change 2167</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5a82=
7f4c6d169420504a48e13ee6eb28053dbc4c </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 2167 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Iykd1U44sdU=--


--===============0801989370189217128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0801989370189217128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0801989370189217128==--

