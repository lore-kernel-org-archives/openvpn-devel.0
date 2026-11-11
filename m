Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C35606A324
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ll6ra/q1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KjcTxxTp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XkR9Pc4X;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OBxzMAxg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Gc08JTtYUwPd1KTAqCSxXTcbL7h/9VpAh36mxKnUYw0=; b=ll6ra/q1JvT7KcwqfTKp1FVA1a
	f6FwwVZrPkSX+yZpBaeJZb40E4V1A1vKwSf9ozxh1hteJiUWA8u7whGHiXbOG395HRp9wpTQCwdmr
	OeLkK9GNjjI2JflCu/rkuvl3G5qwujyQlnU6VvGebBJ5tdRy+OmsxiS5SCAMohUlXxQc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRBvB-000000007ov-1S3V;
	Wed, 11 Nov 2026 17:15:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRBv9-000000007on-3n41
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 17:15:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ePPsOG6Nme6ssHbonZ1gLMaUdDpBVpXqOPEt3vS2xDg=; b=KjcTxxTpqRh3HZo1csENCkjUVs
 P3ut/Y8ybtdJjPQQfc+auqpSzueakK3cXaRviVXMHDPLCA4RoWT/Stgumf6CLAj0b8XCK9u+d5Gor
 Hg3DD6I1EU7akVxUI6YtEOY/VswakeiXc9qfbQb7NEQwxQdGpNUDQSuAmhaKyMd5PLz4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ePPsOG6Nme6ssHbonZ1gLMaUdDpBVpXqOPEt3vS2xDg=; b=XkR9Pc4XAkrQ3jXUi8ooRc43Wh
 CSTgwINmdsRqzH4OwTzcCJTzwyDgz4qZ+uwwzC2Lho6c5/xdn6PdMYmSmr86XhsvEL9E102P5umAa
 nitMg0HfwIx0BSWmTWHLZnHN+bI8fwGHDrwlDgme2sFlrKG5tu/5lLkPHXRi7/nKxrws=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRBv9-000000005vl-0zlY for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 17:15:39 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so523535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794417332; x=1795022132; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ePPsOG6Nme6ssHbonZ1gLMaUdDpBVpXqOPEt3vS2xDg=;
 b=OBxzMAxgc6TiozKivmO/Pgn7Hy0EY+paFf4Rgx+xWRrab00Vj6a0PlA3V6jWCmKWfm
 D1OybOI8De8q8tTchYBMMp9AG/y0TyxsV8h8hW2eHNB5BivMTzg1hofumruz2SmOC2Hb
 IwEmB+LrJgPJVaZonnxqr6nCLeOFboAOKLzIEsIJzSRf/loh6wuuhv1LFJEfYQQ56f/M
 doiV+V/pe8Xb0zsFx4qYeNs82quiKuog1ORI72Oi6UcTiH+GNeBLaBY8KcUV5EsrO7xt
 ROh2J8iGEv8LUhDgn5R31ICyPiU7E/imFMg4M/7zN5OhK0OMb8jQQuEY1loE3t8s2ZNS
 GAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417332; x=1795022132;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ePPsOG6Nme6ssHbonZ1gLMaUdDpBVpXqOPEt3vS2xDg=;
 b=XQAekeX/D5c5lrgaO9V1tqcnp0DDBJo8UCCVfuQ41FeS/+UUsqf3DxuK0t/zVYwMCq
 91IA0L1gKYHqhX776hwhW1rvOH6wa0hYca8h+c0LICmP19GXoaiPFMs6mXw4QSHZYllf
 Q0I8LREKe6LKfecPg5tkGt9BaYpH+gWEdTPjDfTnr8ahzc5P6USWBtcW8TQy9U8hsaCF
 TIaQZGfHNN2VdAxCIJ6j+EH1NJLewyHYEcYCQ6VqyMkEKmaGidboVNNmWfh5DlPaSJMH
 PRH4Y5vpa23qU0r5xvyuSVXqLSFLocxJwNLkWbYqmQVKsBGsS5GF2OYNpwOlXsgBLezU
 dZ1g==
X-Gm-Message-State: APuU4Z/edCnj2GbN18aLk8InhCWJg+cYJ+Ld0rxqmAByfm/JRPzk0EjE
 UBjnHOlj5dXtMVhL/tcirupi69RNsrPsPEAeYZAhyE+EvvtB8KSNfdGBj4SctUyQsnzcl8plnl7
 wDVb+6XO0YQDoTCTJdUpDqkvzxg61JNes8tpzYCWvjNZy9h3WXGWxfychFrDOScZOYRQm/xwQ16
 u1D79lpQ==
X-Gm-Gg: AYBFou1oV2X6QeXvLjsDiKlqOjsBQFoYK2i7d7oeNRNgOiFOCBCJ5EwHgXM88YVD6dD
 gSwbTN5+JLa8DNt6efU2crqPRUl0uiY+RHa2BxsJCRjRfa6I7yqAYMVF01Rftczxb+IaXc8SARU
 j36T06sSHr7V/aC9fSgyVRu++HxwXICuICgp4X8iPRff0K9JuQGZfWP8yxCZwWLWmW3kVW+qx+I
 IFsoFEcynidaW1ZvkLQ3LQcJucKFG6snh8EO/X7271Iy2kUwg7CgQidO0MvfUWk4XfKqx+jA05L
 VcS3yJ7nKHzcWYYQD1ojOxmx0Bo835mooReZ8hLRyq78oMs6MvmwV78YCf6TU/u4LUnXIqkzuBa
 /0gtlz+EO/0XNc1wBE9KUJAMLRr8CcHCzeZclOjuaNomqleUkQidekGc+HAIhlG7Y3zEjfzE8Xy
 Dv6IK794uaGls20Mc8hNdZge0oGtuMSaD+2a9hPH7KydB3U8u4zbqVeFmSimzbuX6bvzXFs1Ony
 0cuuH5unE+jZPhzoDZKoc+E4cXl0KYpxxAUjtuIC9sjIRcI6dcZbja4l7/Zznu5LYi+1C+Z3dDy
 Pkw7uZD65e8Hi8m8aBBVrZtdfHCktNUBvCpvOIREvhVDPnJ2TSPEEPHE6d9PgX01uN1NQv7zKWm
 p2Lf+NU5BrU+0Lo6dhBdptr/fpCdnbFhbl1jBOw6a87UWnyZ8O06NRb4oHmLlOGQOJOGWEjBNZS
 uRbeZ4IbQLtK9blFo=
X-Received: by 2002:a05:600c:154a:b0:4a2:10f9:37db with SMTP id
 5b1f17b1804b1-4bb4e27a9afmr2753175e9.7.1794417330661; 
 Wed, 11 Nov 2026 09:15:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e26700fsm2371005e9.10.2026.11.11.09.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:15:29 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 17:15:28 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088
X-Gerrit-Change-Number: 2176
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2176?usp=email>
X-Gerrit-Commit: 06f245d36aadd447111cf3c431d60625678e967d
References: <gerrit.1794417322000.Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkllNzIyOGVlOTVjMmI0M2Y5YmUyYmY0YzZhOWE5NTlhZjJmNzI5MDg4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d96553e7a778f84df3309167349c52c42be95e88-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRBv9-000000005vl-0zlY
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: Make
 error_flags unsigned consistently
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3427365479799927676=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3427365479799927676==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AF+/9JtfbsI="; charset=UTF-8

--AF+/9JtfbsI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2176?usp=3Demail

to review the following change=2E
=


Change subject: tun: Make error_flags unsigned consistently
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tun: Make error_flags uns=
igned consistently

Previously both int and unsigned int was used=2E

Chang=
e-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088
Signed-off-by: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/init=2Ec
1 file changed, =
4 insertions(+), 4 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/76/2176/1

diff --git a/src/openvpn/init=2Ec b/s=
rc/openvpn/init=2Ec
index 0bb5390=2E=2Ea92967e 100644
--- a/src/openvpn/ini=
t=2Ec
+++ b/src/openvpn/init=2Ec
@@ -1835,7 +1835,7 @@
 
 
 static bool
-do=
_open_tun(struct context *c, int *error_flags)
+do_open_tun(struct context =
*c, unsigned int *error_flags)
 {
     struct gc_arena gc =3D gc_new();
   =
  bool ret =3D false;
@@ -2337,7 +2337,7 @@
 bool
 do_up(struct context *c,=
 bool pulled_options, uint64_t option_types_found)
 {
-    int error_flags =
=3D 0;
+    unsigned int error_flags =3D 0;
     if (!c->c2=2Edo_up_ran)
  =
   {
         reset_coarse_timers(c);
@@ -2496,7 +2496,7 @@
     do_close_t=
un(c, true);
 
     management_sleep(1);
-    int error_flags =3D 0;
+    u=
nsigned int error_flags =3D 0;
     c->c2=2Edid_open_tun =3D do_open_tun(c,=
 &error_flags);
     update_time();
 
@@ -4663,7 +4663,7 @@
      * open tu=
n/tap device, ifconfig, run up script, etc=2E */
     if (!(options->up_del=
ay || PULL_DEFINED(options)) && (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM=
_TOP))
     {
-        int error_flags =3D 0;
+        unsigned int error_f=
lags =3D 0;
         c->c2=2Edid_open_tun =3D do_open_tun(c, &error_flags);=

     }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
76?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newcha=
nge
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie7228e=
e95c2b43f9be2bf4c6a9a959af2f729088
Gerrit-Change-Number: 2176
Gerrit-PatchS=
et: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>

--AF+/9JtfbsI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2176?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">tun: Make error_flags unsigned consistently<br><br>Previou=
sly both int and unsigned int was used=2E<br><br>Change-Id: Ie7228ee95c2b43=
f9be2bf4c6a9a959af2f729088<br>Signed-off-by: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt;<br>---<br>M src/openvpn/init=2Ec<br>1 file changed, 4 i=
nsertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/76/2176/1</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 0bb5390=
=2E=2Ea92967e 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><=
span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -1835,7 +1835,7 @@</span=
><br><span> </span><br><span> </span><br><span> static bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-do_open_tun(struct context *c, int *e=
rror_flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_open_=
tun(struct context *c, unsigned int *error_flags)</span><br><span> {</span>=
<br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     bool r=
et =3D false;</span><br><span>@@ -2337,7 +2337,7 @@</span><br><span> bool</=
span><br><span> do_up(struct context *c, bool pulled_options, uint64_t opti=
on_types_found)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int error_flags =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    unsigned int error_flags =3D 0;</span><br><span>   =
  if (!c-&gt;c2=2Edo_up_ran)</span><br><span>     {</span><br><span>       =
  reset_coarse_timers(c);</span><br><span>@@ -2496,7 +2496,7 @@</span><br><=
span>     do_close_tun(c, true);</span><br><span> </span><br><span>     man=
agement_sleep(1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int error_flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    unsigned int error_flags =3D 0;</span><br><span>     c-&gt;c2=2Edid_=
open_tun =3D do_open_tun(c, &amp;error_flags);</span><br><span>     update_=
time();</span><br><span> </span><br><span>@@ -4663,7 +4663,7 @@</span><br><=
span>      * open tun/tap device, ifconfig, run up script, etc=2E */</span>=
<br><span>     if (!(options-&gt;up_delay || PULL_DEFINED(options)) &amp;&a=
mp; (c-&gt;mode =3D=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP))</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int er=
ror_flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     unsigned int error_flags =3D 0;</span><br><span>         c-&gt;c2=2Edi=
d_open_tun =3D do_open_tun(c, &amp;error_flags);</span><br><span>     }</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2176?usp=3Demail">change 2176</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2176?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af2f72=
9088 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2176 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--AF+/9JtfbsI=--


--===============3427365479799927676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3427365479799927676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3427365479799927676==--

