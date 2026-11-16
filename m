Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E28E606A336
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JTJxATpd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E77Vj+iH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=khqKGUXb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JfG07u5k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=A5vFVkWItH4EqOsnWPs8iOC+w+iqJcUaN+uQ47kxVwg=; b=JTJxATpd8pGXsXLqnnNUHXfdZO
	RheQ6HpISl9RKdBSM4a03NESUtjeAgIfBOsLR4zZbWRAT5IKW9n6X4ETzWi5NyKsV/dZ51j5oX+n1
	KPXqqwxP+BZzTEX7Ep4G2Vap/CFoS8FzF+oOy+wNU83znZQPuwRAKKNkExktUmXL+koE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSsYF-000000004zX-3QVA;
	Mon, 16 Nov 2026 08:58:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSsYB-000000004x6-3YQA
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:58:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/bgod7fT6PTf21TzkS1KR+YmCZfvYfWRwBdnZ7rARJ8=; b=E77Vj+iHXXhO9rfNlvLGYaaigN
 iQNfJ9+anqsYS1XCUuOEubI+stcuTjuZm1VPM0T0RYOIWyUMbfi9i0t4mV1S/Y7ROjWYRWJJDPfIi
 FJoBotkR2/i+5IxLNmt781PTSC2k44HZbmU49ewntu1nh681Ab21o0A+FkEGh405O0/Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/bgod7fT6PTf21TzkS1KR+YmCZfvYfWRwBdnZ7rARJ8=; b=khqKGUXbIpIHPO3d1erKHe04v+
 9FQtYaNaRM9u1e/3uDzwI4ncsV501bTtDC7+h1MASp6JosgwZvDo3RJL8t9ox+Il5kPS4bnWc8SoW
 +sQZ17pkRwkjQ/eMQybgYbGxlZLcm9OxV95AArI4LiBE2dWincculz0l/0QM/odzsAGE=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSsXi-0000000061x-0Tgj for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:58:27 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4bb61185057so11398785e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 00:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794819499; x=1795424299; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/bgod7fT6PTf21TzkS1KR+YmCZfvYfWRwBdnZ7rARJ8=;
 b=JfG07u5k8Gprj3MOsbZ0o15pDQbex9YSAGFqgq1ZaA8L1hGK/Cp9nL7/YXKt56oK8H
 WdFqlptV8aF+H5JwqO0LLal2D9x4ON8sA974K3U9VddkZn+4wTJgdxascVbC2mDEGCld
 bpM/XOd+vTJ76WDWhn0cZ0YXj/6GDr+itAUkW1qa4ddyl5u2CGzBduW7GBlOyEC9mPUP
 eVm6uBWWxNOgG028JC59UZYpHRxAmgtIiwk4OusGInr3HkD8iUc9MouidAo2WCoCpTVj
 zhmKq92f8Xh6Xt2tNWz3J9OddyeLk9Dr1rb8bpj+ZqIZ7/+D4eZ8wmR73lL9XlUACLKm
 /m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794819499; x=1795424299;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/bgod7fT6PTf21TzkS1KR+YmCZfvYfWRwBdnZ7rARJ8=;
 b=21JyyIlG7f6WcOydJKGwK6mXl3E+DKa5mKtZPbELI/gtj6S6FvvpxQW+6kR5UzIWr2
 jj1EGOjqGquKYAvm46yKVhLFUlFEHfR76mG1b1jx/pEw619vKbY0z3aPjtqTwYt/yc/I
 Zc3n/ajbOXxEnLvUaUG57/udxBmP0ScUArXX8bmYsdxZxv/zgwR1NXphU9foemAe1pgH
 7BQiVO//Egg4KwrOZHyhMa90NazJIuxVpcHKIHLgGkMk2xKCY4/7oZ+WmycXNfqM/PPY
 rvtk6P5b0kMXLDuVgm0+91Ep+uEapMj8h5YVAAsr4GUwpwe+c9teU735orZ3Hb8QfRTC
 R8hw==
X-Gm-Message-State: APuU4Z+xjR2xPCE4+1ISDu0NR8Mmypqn86CrbXgPeEo78HSTuZTJrw2x
 gmz2flxEQxOgzrk7+6BMON4klyK/RCGCibbwIKthLx8+Nh3iDAY8XdcLbLvIyYaX6qDETGPP8jE
 eitLeIPqU5Fqv/CTXMuX8mj87joJXCuI7yHpt4wJW5gB1sEFGPN5YJhskqnpzsRBX6Zdf
X-Gm-Gg: AYBFou0vO5x0u5g1mm3kV6sVP7zoFM2T0Qhiqz3zET49l9+N+WexqaluBimKdGxwiOa
 Kr29B8hE2GtouI3aKV9FgBPwUsZKfhdQ6PefIvpQIrrG07+WNo/MIAcBhlMeLd0pKxccixax7+X
 2j/4WdQND7YZgSDfOPlXIaSozuHJip2EY/2UjjXI6eWdastE8g1uLhC4drUOC67AA3ivkyNEpRN
 lE1YBPAp/hkYseJ+yMtDNVaKTDcrkBgVZGPb9IOA+ZRiQ2TjEwdgvSAHIgZTebCnzn7Sxdd52Zt
 Npagm4gOBLT71R8qm8ycQUmgeffaVyTJS/lUw9GufDj5gNIiXwO8+HMZvrUsKefioUEBeuvBlFv
 9x/zK+80EdQBIRGXihgEl8jLeiuChk+TyXTYnsVyeC2IZ3syI9qaOUHaGw8CTpD6qCYgEjS1BSW
 yMT2mTHM3umcvVxUiXAvtVQdeT6MMYhcaqMjAl/tKV9TMnvySQFZL3OrL5wkjiFWjFabbNVQaXt
 iNQfBoVlUfREhsZ3ILeInp12WojkDJZrkTUYgC4j8iB4YA2rePhTRBDJrAJN+vTwAURJwARvIri
 cZHgHP1xMl2usin3iHzmm0Fhn5oQF8ztmQ/WC/mDkDd4pYO8262Iub13p4hEl3ZGMHTXDG0jzLm
 iGH0YNo9Hl6C4znLIwnJ/S6ktcsTl5wYzbcLzqKuEAY77/E9xVX3GkXekSLSfSj5acQarIyp04d
 JYYHRsQwoQSH600JU=
X-Received: by 2002:a05:600c:1f96:b0:4a2:150f:1601 with SMTP id
 5b1f17b1804b1-4bb55a4eb97mr207435835e9.12.1794819499341; 
 Mon, 16 Nov 2026 00:58:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7292c04csm56080085e9.11.2026.11.16.00.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 00:58:18 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 08:58:18 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: If903dc58238580ec0680f2d4c908b1f949a27469
X-Gerrit-Change-Number: 2131
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2131?usp=email>
X-Gerrit-Commit: a9256f3631896b1678fd67695a7490161039c962
In-Reply-To: <gerrit.1793795741000.If903dc58238580ec0680f2d4c908b1f949a27469@gerrit.openvpn.net>
References: <gerrit.1793795741000.If903dc58238580ec0680f2d4c908b1f949a27469@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk1NzQxMDAwLklmOTAzZGM1ODIzODU4MGVjMDY4MGYyZDRjOTA4YjFmOTQ5YTI3NDY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d5b5b02df45b6c958009bec31e8bff9b76582d34-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSsXi-0000000061x-0Tgj
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: use
 setenv_int_i()/setenv_str_i() for indexed route env variables
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
Content-Type: multipart/mixed; boundary="===============8666534455739736346=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8666534455739736346==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S+fvgNQe4T4="; charset=UTF-8

--S+fvgNQe4T4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2131?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Arne Schwabe, Code-Review+2 by Frank Lichtenheld


Chang=
e subject: route: use setenv_int_i()/setenv_str_i() for indexed route env v=
ariables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

rout=
e: use setenv_int_i()/setenv_str_i() for indexed route env variables

seten=
v_route() and setenv_route_ipv6() built the route_metric_N and
route_ipv6_*=
_N names by hand=2E Use the env_set helpers instead=2E The
resulting variab=
le names are unchanged=2E

Change-Id: If903dc58238580ec0680f2d4c908b1f949a2=
7469
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2131
Message-Id: <20261104124750=2E18302-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg40712=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/route=2Ec
1 file changed, 4 insertions(+), 1=
5 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/31/2131/2

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=
=2Ec
index 4cbba06=2E=2E9086529 100644
--- a/src/openvpn/route=2Ec
+++ b/sr=
c/openvpn/route=2Ec
@@ -1322,7 +1322,6 @@
 static void
 setenv_route(struct=
 env_set *es, const struct route_ipv4 *r, int i)
 {
-    struct gc_arena gc=
 =3D gc_new();
     if (r->flags & RT_DEFINED)
     {
         setenv_route=
_addr(es, "network", r->network, i);
@@ -1331,12 +1330,9 @@
 
         if (=
r->flags & RT_METRIC_DEFINED)
         {
-            struct buffer name =
=3D alloc_buf_gc(256, &gc);
-            buf_printf(&name, "route_metric_%d=
", i);
-            setenv_int(es, BSTR(&name), r->metric);
+            se=
tenv_int_i(es, "route_metric", r->metric, i);
         }
     }
-    gc_fre=
e(&gc);
 }
 
 void
@@ -1356,22 +1352,15 @@
     struct gc_arena gc =3D gc_n=
ew();
     if (r6->flags & RT_DEFINED)
     {
-        struct buffer name1 =
=3D alloc_buf_gc(256, &gc);
         struct buffer val =3D alloc_buf_gc(256=
, &gc);
-        struct buffer name2 =3D alloc_buf_gc(256, &gc);
 
-       =
 buf_printf(&name1, "route_ipv6_network_%d", i);
         buf_printf(&val, =
"%s/%u", print_in6_addr(r6->network, 0, &gc), r6->netbits);
-        setenv=
_str(es, BSTR(&name1), BSTR(&val));
-
-        buf_printf(&name2, "route_ip=
v6_gateway_%d", i);
-        setenv_str(es, BSTR(&name2), print_in6_addr(r6=
->gateway, 0, &gc));
+        setenv_str_i(es, "route_ipv6_network", BSTR(&=
val), i);
+        setenv_str_i(es, "route_ipv6_gateway", print_in6_addr(r6=
->gateway, 0, &gc), i);
 
         if (r6->flags & RT_METRIC_DEFINED)
     =
    {
-            struct buffer name3 =3D alloc_buf_gc(256, &gc);
-       =
     buf_printf(&name3, "route_ipv6_metric_%d", i);
-            setenv_int=
(es, BSTR(&name3), r6->metric);
+            setenv_int_i(es, "route_ipv6_m=
etric", r6->metric, i);
         }
     }
     gc_free(&gc);

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2131?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: If903dc58238580ec0680f2d4c908=
b1f949a27469
Gerrit-Change-Number: 2131
Gerrit-PatchSet: 2
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--S+fvgNQe4T4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2131?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Arne Schwabe, Code-Review+2 by Fr=
ank Lichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">route: use setenv_int_i()/setenv_str_i() f=
or indexed route env variables<br><br>setenv_route() and setenv_route_ipv6(=
) built the route_metric_N and<br>route_ipv6_*_N names by hand=2E Use the e=
nv_set helpers instead=2E The<br>resulting variable names are unchanged=2E<=
br><br>Change-Id: If903dc58238580ec0680f2d4c908b1f949a27469<br>Signed-off-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2131<br>Message-Id: &lt;20261104124750=2E18302-1-gert@g=
reenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg40712=2Ehtml<br>Signed-off-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file=
 changed, 4 insertions(+), 15 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/2131/2</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><sp=
an>index 4cbba06=2E=2E9086529 100644</span><br><span>--- a/src/openvpn/rout=
e=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -1322,=
7 +1322,6 @@</span><br><span> static void</span><br><span> setenv_route(str=
uct env_set *es, const struct route_ipv4 *r, int i)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D=
 gc_new();</span><br><span>     if (r-&gt;flags &amp; RT_DEFINED)</span><br=
><span>     {</span><br><span>         setenv_route_addr(es, &quot;network&=
quot;, r-&gt;network, i);</span><br><span>@@ -1331,12 +1330,9 @@</span><br>=
<span> </span><br><span>         if (r-&gt;flags &amp; RT_METRIC_DEFINED)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            struct buffer name =3D alloc_buf_gc(256, &amp;gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;na=
me, &quot;route_metric_%d&quot;, i);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            setenv_int(es, BSTR(&amp;name), r-&gt;metric);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            setenv_in=
t_i(es, &quot;route_metric&quot;, r-&gt;metric, i);</span><br><span>       =
  }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span>@@ -1356,22 +1352,15 @@</span><br><span>     str=
uct gc_arena gc =3D gc_new();</span><br><span>     if (r6-&gt;flags &amp; R=
T_DEFINED)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        struct buffer name1 =3D alloc_buf_gc(256, &amp;gc);</sp=
an><br><span>         struct buffer val =3D alloc_buf_gc(256, &amp;gc);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer nam=
e2 =3D alloc_buf_gc(256, &amp;gc);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;name1, &quot;route_=
ipv6_network_%d&quot;, i);</span><br><span>         buf_printf(&amp;val, &q=
uot;%s/%u&quot;, print_in6_addr(r6-&gt;network, 0, &amp;gc), r6-&gt;netbits=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_str(=
es, BSTR(&amp;name1), BSTR(&amp;val));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    buf_printf(&amp;name2, &quot;route_ipv6_gateway_%d&quot;, i);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_str(es, BSTR(&am=
p;name2), print_in6_addr(r6-&gt;gateway, 0, &amp;gc));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        setenv_str_i(es, &quot;route_ipv=
6_network&quot;, BSTR(&amp;val), i);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        setenv_str_i(es, &quot;route_ipv6_gateway&quot;, p=
rint_in6_addr(r6-&gt;gateway, 0, &amp;gc), i);</span><br><span> </span><br>=
<span>         if (r6-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            s=
truct buffer name3 =3D alloc_buf_gc(256, &amp;gc);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;name3, &quot;route=
_ipv6_metric_%d&quot;, i);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            setenv_int(es, BSTR(&amp;name3), r6-&gt;metric);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            setenv_int_i(es, =
&quot;route_ipv6_metric&quot;, r6-&gt;metric, i);</span><br><span>         =
}</span><br><span>     }</span><br><span>     gc_free(&amp;gc);</span><br><=
/pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2131?usp=3Demail">change 2131</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2131?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: If903dc58238580ec0680f2d4c908b1f949a27469=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2131 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>

</body></html>
--S+fvgNQe4T4=--


--===============8666534455739736346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8666534455739736346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8666534455739736346==--

