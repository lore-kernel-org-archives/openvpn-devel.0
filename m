Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86B5C5DF98
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=wnn1HeFe571fM251X87j5wEuHaisMOVr8nCg7sNy/t8=; b=CS1fWhDI0SQ0us
	m2Q6+udhB64ie07+3Gnr/ofHxr0uZqAxC9byu3cKUGbkdnAZsPNvZTDqCeNdDid+hz9XUMt35kSMy
	3qJpEb3i6hdom8wG5rlax8r3GnH5zT3aD6eWAGVGuR7V9xJV2/mA55NoXlE29geG5+X8PRJLvMfX0
	SHM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxRUk-0002FM-HI;
	Fri, 21 Aug 2026 15:49:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxRUi-0002F7-S5
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JQF1zT2QKkN57hTSgXEFBsC/0VPzmhPAukpRhXtG3IU=; b=EwxagcwMuXyMcmeKJF98izsHLa
 nLUfH5jH1acFnnDxVkZqdf81CaXZRWsvfa/996CvD+aEYr7w2YthJ43VSgElR9O1+6k3CzPEVFlp8
 tcOTA2ZYdqh2GN7cZ8n/pWLWl2i6Q33Zq84/VAnX52hRlgffTYRDCaFLSXjI1Vq8gLlo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JQF1zT2QKkN57hTSgXEFBsC/0VPzmhPAukpRhXtG3IU=; b=T
 h4NCrlpxdeUOJzJFRIYmh7U8eHyEfPhf4727OQyz6K2DWzwgev+foTzhjiLeXaN45TNUSlhZjNOO5
 Wy1rWwCEFuB9E2/PyDTkdcGoazFiEiBLoSPKsbPNyV7h9WRBsFiMy0YbOvoua5cOKPn+SuE/qDWrf
 0bu3qqzobrSll5mw=;
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxRUi-000593-WE for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:25 +0000
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso229055966b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787327358; x=1787932158; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JQF1zT2QKkN57hTSgXEFBsC/0VPzmhPAukpRhXtG3IU=;
 b=Q+Iz2G9MCps/kAaBeP0evfJTZBqRCZu97Xroz+uqKe4HGpYDXIZBOQEK2CR4ZwI1bq
 XfK6HU9cVkBO/8G7WoVC1dS7eZqQ96P2J9fhi6ZsbvgXvKshlOI8YWeYNvw2NNlWMu8c
 W/IaXz48G5sCfh7KdPydvqvbk6QyhV2DGeq2Eh51ePfebXIzGsofgqW+22OKXtugUSAC
 KBhk627jg7yIIXbLfFK8aFw3zak1RoHKKeykPpulIydTAMt0RyEDJGP43Jc3ddijDrKN
 bCesYvkZwCOWuatMOZtM40bLqYHVMLEvS338yAt/seXTv5zpfAsaR/IDDV3/gAnbrnc2
 zM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787327358; x=1787932158;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JQF1zT2QKkN57hTSgXEFBsC/0VPzmhPAukpRhXtG3IU=;
 b=rHkKCI3kCEaLWyuLuQAlMkXaSx7w7DW0lbFZ8rmP1TK8qd+OWa8cCMCb8O7GR8OJPX
 tQE7Cl7bsBUgvUbXESc82cr2jSdNPOUwcUSXOPV+THmuugUFTjodbbcF0row6QM/9AGS
 +GtKXi3/tSJIh2tp1WW/h0EKg1GchqyBYR6gUaqcthp0CTI9U0lE0LJukuPOQtnh0N7A
 5j6KMeygTUGInsPSbiOXC3B+pLp+IfNt9V6x4a1vGyrBObPK9+nsuqFpOaEVD2lh4xgy
 X2ytlqMVNTeFFrealvf30adhZH0UegamfXVEFDGO3WjVffi7thuhGUEUkyLfcxCTJFMr
 plOw==
X-Gm-Message-State: AFuF++m85sphOc/i82QUe3y+PS9HKNCtFUenMHhrRGIf6jNY2FiNAO6F
 HvY1NEIOvKHloYTSGgmiY4fvHL6LYp+ilw1X4L52YtprlCxA8r8+G4GT1AUDkNsBW6+i8Jarsqc
 wXMQ0IowPLJ/1DtItrnPrpJbWMd3qBp8oIGX5iAOoX2faqIWxBmd0zDiktwGofHNs7ihK9KNdEZ
 1pU90cKQ==
X-Gm-Gg: AR+sD10qbMWaeCPFjztuN9taZ2qrWvh4Jxzz5OGqCOSc3ljL4p8si7T296Wshbf13Ga
 zXO/Z2EzLjiqRkpY8+c8BIU6CvQYik0DCjWJeRT0nPyRw5Acg8bfq060aVxtrWOjae/KBmwmM1J
 eyVuTae4j9vJFtCL69MJlA1cPC9ILlzMth5LMkTz+RYKTGXgXQYiNNor0MIWNZcODNxUWw9phaR
 m89dF3siuVeS8XPYKlGi7ig/YQX6sxNdTn89LVpJ6aQxyngBRxuVjQzDlDi6w9feKD8g9HYqbby
 EAk0jIRLQUtyYM4YgzWqocohqe8As9YPrBtSTnt0TNO6O6sul8suffofLYXv/KsgLlGsvHL2FrF
 CWYJsCeOUTlVAeiL67I7k9wNYJDPRjTA3Mk9BQIErpcUE+NzcEUzKB7UgusjksOR1EqRmss6cse
 T+aC1aYPxDTF1UuwePQHqvgTlLU2WTMCZ8NfFgCZ4oHMZWYYQf+IIZ2Iha5hflniGRNP+dO2lqO
 qxjFaA9xKl8PbTWy03Xv4+mjkUAtXPf60TVfJvI2dUNwrEIIaIxhLiq1/9RnOA0ke9GrSwhZNMg
 0JmasLSGJfQvjtRe9lTDF/vaHNOeuq2U12vAz6IARkz3pETIkqM=
X-Received: by 2002:a17:906:2481:b0:c1c:2007:298e with SMTP id
 a640c23a62f3a-c246b4c5e33mr603494766b.24.1787327358261; 
 Fri, 21 Aug 2026 08:49:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2459198d59sm478373366b.35.2026.08.21.08.49.16
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:49:17 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 15:49:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb438
X-Gerrit-Change-Number: 1854
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1854?usp=email>
X-Gerrit-Commit: 380231a730737f71fb4adcc3b95ae7367e28b8fc
References: <gerrit.1787327336000.Ib7d9aa61fd878d7e025e9d1050c563dd114eb438@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliN2Q5YWE2MWZkODc4ZDdlMDI1ZTlkMTA1MGM1NjNkZDExNGViNDM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0c41eeaabf78be71e97b3b7f8a2ab1b6090cf6d9-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxRUi-000593-WE
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
Content-Type: multipart/mixed; boundary="===============3664129842198202674=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3664129842198202674==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="V3+c5BlbSHk="; charset=UTF-8

--V3+c5BlbSHk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1854?usp=3Demail )


Change subject: Factor out lookup_s=
ession_by_mda_key_id into its own method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Factor out lookup_session_by_mda_key_id into i=
ts own method

This makes the code a bit easier to read and also allows reu=
sing
the function later=2E

Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114=
eb438
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/mu=
lti=2Ec
1 file changed, 21 insertions(+), 11 deletions(-)



  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/54/1854/1

diff --git =
a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 20b4f14=2E=2Edda5c6b =
100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4014,6 +=
4014,24 @@
     }
 }
 
+static struct tls_session *
+lookup_session_by_mda_=
key_id(struct tls_multi *multi,
+                             const unsigne=
d int mda_key_id)
+{
+    if (multi->session[TM_INITIAL]=2Ekey[KS_PRIMARY]=
=2Emda_key_id =3D=3D mda_key_id)
+    {
+        return &multi->session[TM_=
INITIAL];
+    }
+    else if (multi->session[TM_ACTIVE]=2Ekey[KS_PRIMARY]=
=2Emda_key_id =3D=3D mda_key_id)
+    {
+        return &multi->session[TM_=
ACTIVE];
+    }
+    else
+    {
+        return NULL;
+    }
+}
+
 static =
bool
 management_client_pending_auth(void *arg, const unsigned long cid, co=
nst unsigned int mda_key_id,
                                const char *ex=
tra, unsigned int timeout)
@@ -4024,21 +4042,13 @@
     if (mi)
     {
    =
     struct tls_multi *multi =3D mi->context=2Ec2=2Etls_multi;
-        str=
uct tls_session *session;
+        struct tls_session *session =3D lookup_s=
ession_by_mda_key_id(multi, mda_key_id);
 
-        if (multi->session[TM_I=
NITIAL]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_key_id)
-        {
-     =
       session =3D &multi->session[TM_INITIAL];
-        }
-        else if=
 (multi->session[TM_ACTIVE]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_key_i=
d)
-        {
-            session =3D &multi->session[TM_ACTIVE];
-       =
 }
-        else
+        if (!session)
         {
             return fals=
e;
         }
-
+        
         /* sends INFO_PRE and AUTH_PENDING messa=
ges to client */
         bool ret =3D send_auth_pending_messages(multi, se=
ssion, extra, timeout);
         reschedule_multi_process(&mi->context);

-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1854?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib7d9aa61fd878d7e025e=
9d1050c563dd114eb438
Gerrit-Change-Number: 1854
Gerrit-PatchSet: 1
Gerrit-O=
wner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--V3+c5BlbSHk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1854?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Factor out lookup_session_by_mda_key_id into its own method<br><br=
>This makes the code a bit easier to read and also allows reusing<br>the fu=
nction later=2E<br><br>Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb438=
<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/=
openvpn/multi=2Ec<br>1 file changed, 21 insertions(+), 11 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/54/1854/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/ope=
nvpn/multi=2Ec</span><br><span>index 20b4f14=2E=2Edda5c6b 100644</span><br>=
<span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=
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
nsigned int timeout)</span><br><span>@@ -4024,21 +4042,13 @@</span><br><spa=
n>     if (mi)</span><br><span>     {</span><br><span>         struct tls_m=
ulti *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        struct tls_session *session;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_session *ses=
sion =3D lookup_session_by_mda_key_id(multi, mda_key_id);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (multi-&gt=
;session[TM_INITIAL]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_key_id)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            session =3D &amp;multi-&gt=
;session[TM_INITIAL];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else=
 if (multi-&gt;session[TM_ACTIVE]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda=
_key_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            session =3D &=
amp;multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!session)</span><br><span>         {</span><br><span>             retu=
rn false;</span><br><span>         }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    </span><br><span>         /* sends INFO_PRE and AUTH_PENDING messages t=
o client */</span><br><span>         bool ret =3D send_auth_pending_message=
s(multi, session, extra, timeout);</span><br><span>         reschedule_mult=
i_process(&amp;mi-&gt;context);</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1854?usp=3Dema=
il">change 1854</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
854?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb438 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1854 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>

</body></html>
--V3+c5BlbSHk=--


--===============3664129842198202674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3664129842198202674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3664129842198202674==--

