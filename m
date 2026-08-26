Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715C3C61DBE
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xUdxRISO/k8h40OX/D60NEc5vSJCGlHj5WAh5AL0R5I=; b=FbT/hZKGN+qq7n0kqHF8uJZdCA
	9Mn00ycu7R/fvviCN2s9Ml0nVZxpIbt1ZvH/96bQfixDVvgGjhY8uwfRHVEW4llDq5bmDYiZGOS2Y
	NkkKzktB85QQ2HXPB4vr6zm2+M3PPCW1ZqqXEQidxd2/whhaCEJSpaho3Nd5t7yL3lZY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzCAs-00029l-8w;
	Wed, 26 Aug 2026 11:52:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzCAl-00029K-Rn
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 11:52:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=M6cLndT74SnAT+UQ3I56ZjKJi7JOG6HVyPpU+Xmfj4A=; b=ZEOQ4v2/j1o7/i4oo29vnbC9zR
 4Zpffqhhge29FJA3Cyzcv5XvR9DNKrpl9aYU7ZCabEV6cZYVkokkGgkIL05a0epUG8VwgdrcHwTk8
 Add8eXUOYH5sWINAFQRxFVyCniOkLGJOyA9D0oCNBuXcrdvYhctIfEwLqg2p3uvjOjAE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M6cLndT74SnAT+UQ3I56ZjKJi7JOG6HVyPpU+Xmfj4A=; b=T
 t7aGwnjM3+4rOFtUnHr9MmwRpRs8EQm+Pfdf921NV0P8UFc77k6CIv23CwNu8U4rJzBdlUzn1o5Gn
 aVc+wlBjinr3FE97bg/qO7iurCkIHCGHfgosy57U9oYaKSX2ZAFW+TJKxlwZv7INCFYmL4BduLeoZ
 ZlIAhYufyJAtPlIU=;
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzCAi-0000yB-FL for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 11:52:01 +0000
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6a17cb94b26so1507014a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 04:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787745114; x=1788349914; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M6cLndT74SnAT+UQ3I56ZjKJi7JOG6HVyPpU+Xmfj4A=;
 b=SDn/RcgZPkcTlktNbxAr1Bjp7S5jnfOEmkIQUnE33Iy7pcfnVH0EtywGEHg8cjm85T
 tihMwN4TfsR+3rv8x5ANzu0nTnHkqLizqc98t7ypnuzlG/5oK6RPFznGwepBhm7FUi4A
 6qb99d/2g2ir48SGABEjN8q676oGK0a3OMZqY2SoJbs1y4gBlInWpqzpkfxHHO5c2opK
 mkHy6AZ8Bi91lRCB1yLQAF3Y8DYkt0FGLys/nM0P2vZELG6SFk7POKILcHPYT2rofEki
 My8BJBWDLqZrNhUorwCSBv6aSmNGT/JJlOcjZ8eqVivolVUnDhmfnBiolAAYBewBPjZo
 lWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787745114; x=1788349914;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M6cLndT74SnAT+UQ3I56ZjKJi7JOG6HVyPpU+Xmfj4A=;
 b=H0PXaXVBvXY61Z74qn3ZvZBiGT6bdVDfWk3yE5N9Ef7Z1rzDfvUtY1X2pih13+oM+N
 z5oedyH+MkPeGvgk82FoxOw3S5S+GF34IxwUO56uw9PgIpYhad4ggT35KsC9AC1pCBjM
 im2EQo5yaICP/MJTlBaTsCU7I082Bba/vb+RU4QCMt08oSyK+wqh/zC8NykXUUeUOmtS
 I4Wco7QaKPhmDlA4ps1RBiYMVoAY3/8wjclcW0cHfcY9TeYXuFdI4phIm5NcZcYc29Ok
 tchP3cE+dr+25EJ757gPkFFwZ2ki/3ePPTgmut4V5rPR2sa5z6b2flTnpLU4qGtxwLlJ
 v/8w==
X-Gm-Message-State: AFuF++n1bngGwkCyDLoayZ2uIwkVyq69RoyPHKq4rCRDU0Whue60L9gm
 CLlmf3I/iEasW4vKJZdBLbOohr1EaMF1/RYlqkuBqetFDp0qkd0z1VE/WEly9wl6sAzm75gf7cQ
 GPIDF+yjZ40zDIbOvLxImab/187PdHNoQQkjnVFAAy2a0lGJsxdVEG1tyJWXWegvuVv/mkD7JQo
 +EmngY+A==
X-Gm-Gg: AR+sD137cY/muaxar2Zsn1jZcAyZyzwQVH5r9OpMd9M3HOpNpMvZEo8HTJjq4EvBE0n
 g/SNS0cMurhS8sUI+bom1lZA9/EdyFmgfF+200v8deXgkwgjpIT4QHOEwRyYjPPW/FaD3pOaIht
 lRFzee7RIPOaQzheN7DPRz3i5EkoOzmDep9aaJLoqyKoarOX1V62H8AZVJAxqVOrhz89VWP1JAG
 tsXtQJ0zuRgHh6KGkYYEESJk5j2V4sRNeh992+PMDYczJoNtLIVLimSqs22EfeYz5fmcW8+XSOL
 qp4PhH2R0mtp0hdpSPwSjCtMXcWj4nv8r9H+c/C/azK4bi/VEumNgu0O6aOWbkbaguIDOXTCUuD
 NzfLiqwgBjLQnJyFtSPfOrknr92KgvTMENXDoVcClhNZuUMZ/0nqTSHvblc7JogXPh9lnT68VQR
 QIXA9DUxpHd0oc1kEqEKg/xqPT/8R7E+FWHOmx2a3ZRHpeF9OMjhW9bjU6ksXe93IbPI99tY5Jj
 zPvW2MOxHqQCw5KuM7H1LYVQ2jCCY+rtPJ7nGsiE7sEXXyT89gnnfNVrBz7rPjPXt8tSug+MVKJ
 DyA5m7UiJc+6IQFGKBIJIIin6WyNcchZfBLjv6Ucq5OC017U52k=
X-Received: by 2002:a17:906:9f87:b0:c21:1b58:fa96 with SMTP id
 a640c23a62f3a-c250bbbf179mr881788366b.3.1787745113743; 
 Wed, 26 Aug 2026 04:51:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac7fsm592239066b.30.2026.08.26.04.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:51:52 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 11:51:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb438
X-Gerrit-Change-Number: 1854
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1854?usp=email>
X-Gerrit-Commit: e0339c7bc904dcd9782670a7c6fcf4342234f582
In-Reply-To: <gerrit.1787327336000.Ib7d9aa61fd878d7e025e9d1050c563dd114eb438@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib7d9aa61fd878d7e025e9d1050c563dd114eb438@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliN2Q5YWE2MWZkODc4ZDdlMDI1ZTlkMTA1MGM1NjNkZDExNGViNDM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <234b861cca9e13b3e546ad2c3b0c8fa542583b36-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzCAi-0000yB-FL
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Factor out
 lookup_session_by_mda_key_id into its own method
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
Content-Type: multipart/mixed; boundary="===============4000029130150450633=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4000029130150450633==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YqIjrnrtIyg="; charset=UTF-8

--YqIjrnrtIyg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#6)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1854?usp=3Demail )


Change subject: Factor out lookup_sess=
ion_by_mda_key_id into its own method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Factor out lookup_session_by_mda_key_id into its =
own method

This makes the code a bit easier to read and also allows reusin=
g
the function later=2E

Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb4=
38
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/multi=
=2Ec
1 file changed, 20 insertions(+), 10 deletions(-)


  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/54/1854/6

diff --git a/sr=
c/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 60a5148=2E=2Eb28cf80 1006=
44
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4014,6 +4014=
,24 @@
     }
 }
 
+static struct tls_session *
+lookup_session_by_mda_key_=
id(struct tls_multi *multi,
+                             const unsigned in=
t mda_key_id)
+{
+    if (multi->session[TM_INITIAL]=2Ekey[KS_PRIMARY]=2Emd=
a_key_id =3D=3D mda_key_id)
+    {
+        return &multi->session[TM_INITI=
AL];
+    }
+    else if (multi->session[TM_ACTIVE]=2Ekey[KS_PRIMARY]=2Emda=
_key_id =3D=3D mda_key_id)
+    {
+        return &multi->session[TM_ACTIVE=
];
+    }
+    else
+    {
+        return NULL;
+    }
+}
+
 static bool
 =
management_client_pending_auth(void *arg, const unsigned long cid, const un=
signed int mda_key_id,
                                const char *extra, u=
nsigned int timeout)
@@ -4024,17 +4042,9 @@
     if (mi)
     {
         st=
ruct tls_multi *multi =3D mi->context=2Ec2=2Etls_multi;
-        struct tls=
_session *session;
+        struct tls_session *session =3D lookup_session_=
by_mda_key_id(multi, mda_key_id);
 
-        if (multi->session[TM_INITIAL]=
=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_key_id)
-        {
-            =
session =3D &multi->session[TM_INITIAL];
-        }
-        else if (multi=
->session[TM_ACTIVE]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_key_id)
-   =
     {
-            session =3D &multi->session[TM_ACTIVE];
-        }
-   =
     else
+        if (!session)
         {
             return false;
    =
     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1854?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib7d9aa61f=
d878d7e025e9d1050c563dd114eb438
Gerrit-Change-Number: 1854
Gerrit-PatchSet:=
 6
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>

--YqIjrnrtIyg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #6</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1854?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Factor out lookup_session_by_mda_key_id into its own method<br><b=
r>This makes the code a bit easier to read and also allows reusing<br>the f=
unction later=2E<br><br>Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb43=
8<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src=
/openvpn/multi=2Ec<br>1 file changed, 20 insertions(+), 10 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/54/1854/6</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/op=
envpn/multi=2Ec</span><br><span>index 60a5148=2E=2Eb28cf80 100644</span><br=
><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=
=2Ec</span><br><span>@@ -4014,6 +4014,24 @@</span><br><span>     }</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static struct tls_session *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+lookup_session_by_mda_key_id(struct tls_multi *multi,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
     const unsigned int mda_key_id)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (multi-&gt;session[TM_INITIAL]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D m=
da_key_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return &amp;mul=
ti-&gt;session[TM_INITIAL];</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se if (multi-&gt;session[TM_ACTIVE]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D m=
da_key_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return &amp;mul=
ti-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> static bool</span><br><span> management_clien=
t_pending_auth(void *arg, const unsigned long cid, const unsigned int mda_k=
ey_id,</span><br><span>                                const char *extra, u=
nsigned int timeout)</span><br><span>@@ -4024,17 +4042,9 @@</span><br><span=
>     if (mi)</span><br><span>     {</span><br><span>         struct tls_mu=
lti *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        struct tls_session *session;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct tls_session *sess=
ion =3D lookup_session_by_mda_key_id(multi, mda_key_id);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (multi-&gt;=
session[TM_INITIAL]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_key_id)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            session =3D &amp;multi-&gt;=
session[TM_INITIAL];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else =
if (multi-&gt;session[TM_ACTIVE]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_=
key_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            session =3D &a=
mp;multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!session)</span><br><span>         {</span><br><span>             retur=
n false;</span><br><span>         }</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1854?usp=
=3Demail">change 1854</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1854?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb438 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1854 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--YqIjrnrtIyg=--


--===============4000029130150450633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4000029130150450633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4000029130150450633==--

