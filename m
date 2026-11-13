Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092AE606A32D
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=U+RAmRiT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hTXQERL5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U+QHmU/r;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=O/+Kv4jJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xceqxXvV60xiKykmoDMw94TFqrGl/dnNgvsXxiejmRc=; b=U+RAmRiTgsbAGqppVrf4rzPZTu
	QPE3wph22uD7XXTPNxYwRdG62miMFW24OAKPtcqQ8Gy4yjDloeJDwP4qlDBCSYshIbYsEvMsRMUcK
	zEV8Pf2hdypX2PIcFHh22wsCNj3EzM4V00Bz3JBQy/2ICshXluVk+c2WIhBcdu6jBvMk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRubK-000000001T6-33cq;
	Fri, 13 Nov 2026 16:58:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRubJ-000000001Sv-1hPD
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 16:58:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yGJHJElGPhySVbXE7/SIUYZK5WLXAo3IFGZfibXkv14=; b=hTXQERL5T3wUJbtOt0uvJrND0B
 cmcG6uSn83A8Os7V9O+fIqUnC2/KIM8WVoK8Pr7n+ZI7QssW6ih8Tcgb8sjfl3WF6r0C33FlVTNV/
 x1XPOcvAvdTeHog1btmXWxYgqeEBX8JXIMWDcS8zf9uD7nUTtRdx4Pw+Rx/2kRglDuq4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yGJHJElGPhySVbXE7/SIUYZK5WLXAo3IFGZfibXkv14=; b=U+QHmU/rwVn1miLQus03QCeo1p
 kJ6aIrWHp/7SNEme7gTLkbRJnpV6OsgALvgFsBO1Iat8ZnvZSPhgN1yvKC8IIa8o/FIU96nK5fJx2
 dCtzUfJe5Wqa6lC1YlYvmft5obyXPts/Ot0ZzL2EveGbMl/Jvx+EHZfiyJxaew0AGIzU=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRubH-000000001KU-3G8W for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 16:58:09 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so7888465e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 08:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794589081; x=1795193881; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yGJHJElGPhySVbXE7/SIUYZK5WLXAo3IFGZfibXkv14=;
 b=O/+Kv4jJITzhe2GMY52wcN6XmKIy4sBD3ugWuTl+H3Co29m1NiPjut1l3pAqZSzHNW
 jJLxHReEXlCfvhjG1jTacgrA/LTzRV5UzvUCQFXd6AU1nQXxvjwabc77Z3EjxSlljOyH
 SDhrzyrSwe7ahyFzECnpEP9S5cwD0e6IJrTjqYyTITVIRF4bIsCspLGu9jL+AX1eIeNg
 HP/Oa2G7pMmqFXmSZZgfHr+wetQf7ng8JzaQwkht7gEQzY2zAr71Pn3QQZRgfggVJL6f
 tJ5H+oxzJQv/s3yGvR1Q52VGF8uC+61fDXmzeR2FjlF0AkigUBR815rs8SSFv0bTQIaI
 tNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794589081; x=1795193881;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yGJHJElGPhySVbXE7/SIUYZK5WLXAo3IFGZfibXkv14=;
 b=IjZ/7DzOhckI2cnPFlASSxFflAmVugxsONQl9H/hBA+3vjut0CmMzOgWprRCEqlW8X
 jCrAF6LARhn/ogHgaXRd8oPTwEXlMKz3yv4bovONOwwYQce31t0+kbtGcGYyVVw6U9gD
 xBZW/PIdk39FFnm0wbzJ/fnC3cz7nNsxL+cKQdAYiMsshV2RjOnJVhHxhVNH8FKmgOvl
 rkJka25SgIRG+AZhu7XfBY9FzKfVYCF617yTd9o1II3AhtyKXKMbHy/6pftiv61CC66k
 NuPO0JmTvcGDG07bvHWazAb24wUAx3XQ0FaMT9P1yUV9/aoduaxmTnyHrNLmKSl+ByKC
 260Q==
X-Forwarded-Encrypted: i=1;
 AL+hErE70YL+GUsu8o5EkjPytYXXBUCMJE+23Li4Imy50p1X1Qxf+q5Xr5fb6FhyP5k/NvqWDkQ5W5KwZxW05W4R@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8mGvpodR0uG/XvHWd0Hdov/Asilp6gPBl7rksIr8LFbNFWtNIc
 AAC3KQpArgVHlukA5fnmTyM5lEMglq8pwSg+BkZCd6bpDMPnkmOxwQoe4+9yc/K0IScIqm58qNG
 tsUR/Km2GbWn1iPBw1MRvgkRh/fEkk9ZmEJFsvri5Q7fdfP9qsD7MPgwiN+f/0epDk9vf
X-Gm-Gg: AYBFou0yvme2mecqWZDUKHgA7fz8rxoiM0SC6Ov0NyQp6U2pRGSAUyI3no6t0v5eIO6
 dZczZukRgLztiDwxEQrkR9MnY1T5JTiWTv6SikGQWF8xbJjMrMQ71jo0SgIXJGAuli7NOcFQ3H7
 TpPqPBtK6/jO/SR+wuRt+msNZp/TRsCHtfbMVjzeBls3S5JrpXlIt9YiXkcu8iBIYYgue1eR4he
 rVPlTkxxEF+aaOOMyik+JkGmA/vTv9zK8h5jdeAS5ANfHGGWJa+w/svxe6GGstdsNFCCaBRqXJD
 Q8p7aYlfgz8T3wm8Vx1seH8S02+6zZ85tN1DRJNSB0VuRkOnfuSqqGGlyGuta6eZgAWXpSyDA8f
 cEKnhJio6Mz66Hc2VLcgSlEMPvzFf8MyJvvqO95M29kWQ/aeWayjHZQrkYrjeHMC6riM7wpgZUl
 GpTM7eXkaUuHy8t4HXJlEAaJUB46ZLdBv9BPM03VYyxyU/r+GSI9IVfecr+BgLNLHiJXE5S6yIZ
 C2zv0nByf+C9Z8VxfPFlJuML4+M8ueS9pGVvK7/sb7OtCIeII8hW1m98oIM6E0l0VAWvZ0IwuT4
 p4KwnfI+9M7fbp1GxNVAUT0MO5O16vTjIyv3g6spgsSpY/iqf7bxQqlzNtz9Cx62x/se+63rFNm
 wmroHLVBxjvdX0pUuK1dcB0pZMKsQR0qM85x/RDqivDRTTGFJ3+7xZFGKoRtdwb3KwHDTH4gkGJ
 UudYRewROJdNQCH3A=
X-Received: by 2002:a05:600d:2:b0:4ba:761:c0c5 with SMTP id
 5b1f17b1804b1-4bb55a581e6mr53622755e9.5.1794589080909; 
 Fri, 13 Nov 2026 08:58:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f5972a7sm5916376f8f.21.2026.11.13.08.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:58:00 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 16:58:00 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4
X-Gerrit-Change-Number: 2161
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2161?usp=email>
X-Gerrit-Commit: 09c4f4a189c989fe6aa9ba59237b3440d4619af9
In-Reply-To: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
References: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAxNzgyMDAwLkk3ZmZhZTRkYTNiMjk1MjE4NDRhMzFkMjM0ZmU2YTlkZDA4OTU0Y2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1371635bfc048d0170644265043594b6e3a20ff7-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRubH-000000001KU-3G8W
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: only
 remove search domains that were added
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3135438032529928331=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3135438032529928331==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wFGL4nLE82A="; charset=UTF-8

--wFGL4nLE82A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2161?usp=3Demail )

Change subject: openvpnserv: only remove se=
arch domains that were added
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

openvpnserv: only remove search domains that were added

W=
hen AddDnsSearchDomains() failed, SetDnsSearchDomains() still called
Remove=
DnsSearchDomains() with the new domains, which removes matching
domains alr=
eady in the search list, e=2Eg=2E ones configured before the
VPN connected=
=2E Record the undo data first, as done for NRPT rules, and
drop it if addi=
ng the domains fails=2E

Broken since ae90cbad ("dns: support multiple doma=
ins without DHCP")=2E

Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4=

Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Antonio Q=
uartulli <antonio@mandelbit=2Ecom>
Acked-by: Heiko Hund <heiko@ist=2Eeigent=
lich=2Enet>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161
Mes=
sage-Id: <20261112063232=2E23999-1-gert@greenie=2Emuc=2Ede>
URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41181=2Eh=
tml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn=
serv/interactive=2Ec
1 file changed, 10 insertions(+), 4 deletions(-)




d=
iff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=
=2Ec
index 81205d6=2E=2E5d2abeb 100644
--- a/src/openvpnserv/interactive=2E=
c
+++ b/src/openvpnserv/interactive=2Ec
@@ -1823,13 +1823,19 @@
         st=
rncpy_s(undo_data->itf_name, sizeof(undo_data->itf_name), itf_name, _TRUNCA=
TE);
         undo_data->domains =3D wide_domains;
 
-        if (AddDnsSea=
rchDomains(list_key, have_list, wide_domains) =3D=3D FALSE
-            || =
AddListItem(&(*lists)[undo_domains], undo_data) !=3D NO_ERROR)
+        /* =
Add undo information first in case there's no heap left */
+        if (Add=
ListItem(&(*lists)[undo_domains], undo_data) !=3D NO_ERROR)
         {
-   =
         RemoveDnsSearchDomains(list_key, wide_domains);
             free(=
wide_domains);
             free(undo_data);
-            undo_data =3D NUL=
L;
+            goto out;
+        }
+
+        if (!AddDnsSearchDomains(li=
st_key, have_list, wide_domains))
+        {
+            RemoveListItem(&(=
*lists)[undo_domains], CmpAny, NULL);
+            free(wide_domains);
+   =
         free(undo_data);
             goto out;
         }
     }

-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7ffae4da3b29521844a31d234fe=
6a9dd08954cf4
Gerrit-Change-Number: 2161
Gerrit-PatchSet: 3
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartu=
lli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--wFGL4nLE82A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2161?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: only remove search do=
mains that were added<br><br>When AddDnsSearchDomains() failed, SetDnsSearc=
hDomains() still called<br>RemoveDnsSearchDomains() with the new domains, w=
hich removes matching<br>domains already in the search list, e=2Eg=2E ones =
configured before the<br>VPN connected=2E Record the undo data first, as do=
ne for NRPT rules, and<br>drop it if adding the domains fails=2E<br><br>Bro=
ken since ae90cbad (&quot;dns: support multiple domains without DHCP&quot;)=
=2E<br><br>Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Antonio Q=
uartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Heiko Hund &lt;heiko@=
ist=2Eeigentlich=2Enet&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2161<br>Message-Id: &lt;20261112063232=2E23999-1-gert@greenie=2Em=
uc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg41181=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file=
 changed, 10 insertions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><=
span>index 81205d6=2E=2E5d2abeb 100644</span><br><span>--- a/src/openvpnser=
v/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</sp=
an><br><span>@@ -1823,13 +1823,19 @@</span><br><span>         strncpy_s(und=
o_data-&gt;itf_name, sizeof(undo_data-&gt;itf_name), itf_name, _TRUNCATE);<=
/span><br><span>         undo_data-&gt;domains =3D wide_domains;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (Ad=
dDnsSearchDomains(list_key, have_list, wide_domains) =3D=3D FALSE</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            || AddListItem(&amp=
;(*lists)[undo_domains], undo_data) !=3D NO_ERROR)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* Add undo information first in cas=
e there&#39;s no heap left */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (AddListItem(&amp;(*lists)[undo_domains], undo_data) !=
=3D NO_ERROR)</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            RemoveDnsSearchDomains(list_key, wide_domain=
s);</span><br><span>             free(wide_domains);</span><br><span>      =
       free(undo_data);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            undo_data =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            goto out;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
AddDnsSearchDomains(list_key, have_list, wide_domains))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            RemoveListItem(&amp;(*lists)[undo_dom=
ains], CmpAny, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            free(wide_domains);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            free(undo_data);</span><br><span>             got=
o out;</span><br><span>         }</span><br><span>     }</span><br></pre><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?=
usp=3Demail">change 2161</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2161?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2161 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>

</body></html>
--wFGL4nLE82A=--


--===============3135438032529928331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3135438032529928331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3135438032529928331==--

