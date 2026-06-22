Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C42DCD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BQd68Cpd+8Sh/L8I51c5VoKeKw6AAT3L9ZEkeQvUYHc=; b=I0PiWNj2zQ+BnuzKyI/+PjYqxl
	ng7NC+WfZycr9++FA6qsAmonL51KmbWbXoprwSaGxtt3d+EdHxDnW24fX8FjEoisu5ebfK311BxZp
	rxz2fM2D7DBg49ifQHn5M/6SNEaHSBLnjJexPOIGd7G376HvoIcoDT/hEHAo0KgCCPJs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbfr7-0000WH-MP;
	Mon, 22 Jun 2026 14:42:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbfr5-0000WA-NU
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:42:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YtCyc6IJqyXNtsyDckGqHshRpPH2jE2y+E5r877Digg=; b=BzSwT4eBjoKW5wG6eP++UPASNO
 aneUOD05f8hAFwLW6zcw6H+RxAALJ0Kt/6IMqwTSCxI/wxkFaf4ZWg339uWwD1+MxJWzN4s8/0yZ3
 bhNoCoariZIg6iZNQKYDaMNiniHDqIkxHgLaT/TFLtFbFIK7dyVGvfUytMAJys0uJ7LU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YtCyc6IJqyXNtsyDckGqHshRpPH2jE2y+E5r877Digg=; b=S
 TmgpUQ20VDTtQ0W3BXy7/QbLfZ/M/mMpv/0PgNqx7NpjO2GrjPO6PmmtYwn4+3kY6rMLvApd2DZKZ
 HUDY/FHIz4SS6idndzndDyXhQOawf07jyTFKwMuygjA0xIh+XYfee8XqTBR7OcImBuW5JdthdT7Ld
 f1GweU9fSL6eON3c=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbfr1-00054r-2w for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:42:29 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-45ef779c1c2so3476949f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 07:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782139336; x=1782744136; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YtCyc6IJqyXNtsyDckGqHshRpPH2jE2y+E5r877Digg=;
 b=GXkhYl8pHEe/tYxijFGC/+e9tvNjIGH23yow+QS5hZIDivj97ANTnqPQ7ey65uI7VV
 Dxn8DcuIB9W+9srUAXzeTOozi9s23Ygy0YTp1f4TMfsFaS/cnL7Dn/OGZHPHVwPOunBo
 Yeicue14tXtm3JMdrZAbsLCWIUFEJq8cdqOWN5SKgeZi+7D4bTzF9QEikdEk7LDEUS3A
 46mypJT3dORpS+1LlKQlyDbktSzM/IJnukCugeYxf5I1mYA9bvDQELYPqduoGP7sExot
 JIoOGpHBd5FWTdlg4ZQ2xPaUPZkvdNUn5RT3B7NBWlYkSG8jl2qDav9/g4U9V774x7qV
 87NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782139336; x=1782744136;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YtCyc6IJqyXNtsyDckGqHshRpPH2jE2y+E5r877Digg=;
 b=BR7wwdzimSihlkZ84M4YeCz4rRAAtBdUTISoE6HPGUKGtIRO+y8L2gqzwcR2nSDZ80
 7HLituKQ8fmJwG81DKxTta9u113usa4y4DHD7q1gxgeKrcYV/0xd9GzrP1nnGmK6fefF
 OwWmVzrRAfI70o/fp705wcJH/QR43VGeCMrbQiCNAL1IR6dks3hmcaJG3JHwxFa2pOyD
 j1LgyCmb+Oy2k+OPoA5fn75CpNdGs5l1L4iGPAtgMTG/RPMCGo8UeM34HowdD9QBziiy
 VqguLPKeLSZ/YOByJt1gtNYONWobdxG3PZqnZ1vkkvOByF1FrKJL/WhQcMcpSNj6SYOi
 HsTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPEFW+4aXwNh2VXZhrOVMbFaoRBZu3ZbUmNH2bmp0ujCFEpoBZ0VOYvYC6UwItyUrYHgi7TcgrZU9aR/PJ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwPkPY+pZjf1+KkfukN1IVrQoRyH23zy/IwtWvrv/5Qe6ByyLBs
 53JQcZVoYsE8+8GqMOsIpUigLbFdj/4ojE44miEYDmoMi1CZOMNPWplBaEQyiKt8PZkL0CtTdXr
 l/PL4aXVGQ5TFMkAKep3aKU/VomvM8RJAuWsp6KPpVsDbCnUNFMYxl1jvrPQR9nXX+2HPzzBcIG
 kcxtgyxw==
X-Gm-Gg: AfdE7ckq0JBEJy4Uf5rYjCoDCjtSARpw8/iIBiyMy0jmYYLyQKd+jtEaOtWlMdJzKhH
 LVcqtQmZCFnNlQGjGrAWaiYdfHSnDS9C6//xVkb+sFNQZ5hJnnTKIgpbii5YODIwqK1dXq3pQte
 87NkS9tI9i1z5EepkFIVDaaHT6o9mzBtfMR07mBpFA3l/dBYexj/tmHDOVTXqbKzN2sgxXNWZZW
 qkfU2WMsWaVtDdob0fQ2TItCTIT+jBoqpCcTohSxo4lcQskSeqNfaHsBdmm02CIf3qGpvUMjOIt
 cgF+8B6AuOWuWhsL8z6TOLdPeCorScN/Mumi+ihryz2oS60QT/GRYsOyQHwNZgUJRDIOkv97ZRi
 obXfEzFL3sHKuvYJKACorOELg9Aj8hX5M59RsITyZWeC0RYaEGgZhH2Nr5RSk89JoXFRJatDudE
 iGWumbCfTXGZbJp8ez1j9CY6GIJUQPoD2NaUMqltgaAsjADPfn2k2qz4106ypOYHVBGenjf37Ci
 gmQyKhrfBFZ+882vU8zxQgLBXc2speBdxuGQW+xwHcebGFHwggFMuAIU0aX5dTOkF+UNwKf5iRK
 5/Q=
X-Received: by 2002:adf:e5d1:0:b0:441:1e8e:d8fd with SMTP id
 ffacd0b85a97d-465091bbb2fmr20517358f8f.29.1782139335793; 
 Mon, 22 Jun 2026 07:42:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f563dsm24422209f8f.3.2026.06.22.07.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 07:42:15 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 14:42:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
X-Gerrit-Change-Number: 1715
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1715?usp=email>
X-Gerrit-Commit: 97ec63372ab354ad48c89e73d1e37715679370ba
In-Reply-To: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
References: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMDc3MTAzMDAwLkk0OWIzN2I1YTkwNTU0ZmEyZDRhODNjOGZjNTYwOGRhZDJhMzZiODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f2f1d2e1603e7b88d946969b7388bf3914c32a74-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbfr1-00054r-2w
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: fix
 use-after-free of DNS options on client connect
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3974947599389054727=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3974947599389054727==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l4SAxbgA57U="; charset=UTF-8

--l4SAxbgA57U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1715?usp=3Demail )

Change subject: options: fix use-after-free of DNS =
options on client connect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

options: fix use-after-free of DNS options on client connect
=

struct dns_options embeds its own gc_arena=2E When inherit_context_child()=

/inherit_context_top() copy struct options by value, the child shares the
=
parent's DNS arena=2E options_detach() detached o->gc but not
o->dns_option=
s=2Egc, so pre_connect_restore()'s gc_free() (and context
teardown) freed a=
llocations the parent still referenced=2E

With one or more non-pushed --dh=
cp-option directives that yield a DNS
entry, a connecting client triggers t=
his and the server crashes
(use-after-free in setenv_dns_options(), reporte=
d as a double free)=2E

Detach o->dns_options=2Egc as well, mirroring the e=
xisting o->gc handling=2E

Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36=
b835
GitHub: closes openvpn/OpenVPN#1060
Signed-off-by: Antonio Quartulli <=
antonio@mandelbit=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715
Message-Id: <=
20260622120856=2E21586-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37230=2Ehtml
Signed=
-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/options=
=2Ec
1 file changed, 11 insertions(+), 0 deletions(-)




diff --git a/src/=
openvpn/options=2Ec b/src/openvpn/options=2Ec
index 8012192=2E=2Ef414024 10=
0644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1531,7=
 +1531,18 @@
 void
 options_detach(struct options *o)
 {
+    /* The option=
s struct carries two gc_arena's (one generic and one specific
+     * to th=
e DNS settings), which the by-value options
+     * copy in inherit_context=
_child()/inherit_context_top() shares with the
+     * source=2E
+     *
+ =
    * Detach both (i=2Ee=2E re-initialize them), otherwise child's call of
=
+     * gc_free() (or context teardown) would free allocations the source
+=
     * context still references, leading to a use-after-free (and subsequen=
t
+     * double-free)=2E
+     */
     gc_detach(&o->gc);
+    gc_detach(&=
o->dns_options=2Egc);
     o->routes =3D NULL;
     o->client_nat =3D NULL;=

     clone_push_list(o);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1715?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
Gerrit-Change-Number: 1715
Ge=
rrit-PatchSet: 4
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Revie=
wer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--l4SAxbgA57U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1715?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">options: fix use-after-free of DNS options=
 on client connect<br><br>struct dns_options embeds its own gc_arena=2E Whe=
n inherit_context_child()<br>/inherit_context_top() copy struct options by =
value, the child shares the<br>parent&#39;s DNS arena=2E options_detach() d=
etached o-&gt;gc but not<br>o-&gt;dns_options=2Egc, so pre_connect_restore(=
)&#39;s gc_free() (and context<br>teardown) freed allocations the parent st=
ill referenced=2E<br><br>With one or more non-pushed --dhcp-option directiv=
es that yield a DNS<br>entry, a connecting client triggers this and the ser=
ver crashes<br>(use-after-free in setenv_dns_options(), reported as a doubl=
e free)=2E<br><br>Detach o-&gt;dns_options=2Egc as well, mirroring the exis=
ting o-&gt;gc handling=2E<br><br>Change-Id: I49b37b5a90554fa2d4a83c8fc5608d=
ad2a36b835<br>GitHub: closes openvpn/OpenVPN#1060<br>Signed-off-by: Antonio=
 Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1715<br>Message-Id: &lt;20260622120856=2E21586-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg37230=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/options=2Ec<br>1 file cha=
nged, 11 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 8012192=
=2E=2Ef414024 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><b=
r><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -1531,7 +1531,18 @=
@</span><br><span> void</span><br><span> options_detach(struct options *o)<=
/span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* The options struct carries two gc_arena&#39;s (one generic and one sp=
ecific</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * to the=
 DNS settings), which the by-value options</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * copy in inherit_context_child()/inherit_conte=
xt_top() shares with the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * source=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Deta=
ch both (i=2Ee=2E re-initialize them), otherwise child&#39;s call of</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * gc_free() (or conte=
xt teardown) would free allocations the source</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * context still references, leading to a us=
e-after-free (and subsequent</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * double-free)=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     */</span><br><span>     gc_detach(&amp;o-&gt;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    gc_detach(&amp;o-&gt;dns=
_options=2Egc);</span><br><span>     o-&gt;routes =3D NULL;</span><br><span=
>     o-&gt;client_nat =3D NULL;</span><br><span>     clone_push_list(o);</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail">change 1715</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I49b37b5a90554fa2d4a83c=
8fc5608dad2a36b835 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1715 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--l4SAxbgA57U=--


--===============3974947599389054727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3974947599389054727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3974947599389054727==--

