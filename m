Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF80EC61DBD
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E6nhKJm4rgvP2zDzfHXR3rEwzWEs3s5bp8GWIifpUVc=; b=e5gZdk5CzKVzWJqs5ZQxobxa0t
	ufCDZ7cq0B6TC6k2jzievt4fmcgeeoWYNWICZd8kFDHApIQMsUF+YE0YECoNmc4JzVhxycfeW6OXJ
	940pKvg9/8PnAZqGCPG74+F9FWDCW6aDBFebUE0GD/tacGwqFlFCY4pSrCIwywIGl2tQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wztrY-0006PB-SM;
	Fri, 28 Aug 2026 10:31:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wztrX-0006P5-Rv
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:31:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Aa5n4VNlNp7VUgIG79cMYNOeO2n1DeOui8+WAL3svC4=; b=RLIguu1FjTQydGQQbf1hah4RqN
 L73h2YeiFPMAORgFbRdcTBslZg0CHNVJtX2TNvknveQwBsQs+cLIrNk9cZHWcCjhACF5s5qZNVDhG
 mW5IqZngpz94Y1dc0RxZDduuSsoVzB/fBOz7sWZt74JYw5XkCVlwPuHF2bv9em4jVinA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Aa5n4VNlNp7VUgIG79cMYNOeO2n1DeOui8+WAL3svC4=; b=S
 i7q1YWyAEdHs9BoO1wYpph1eXyGUKHo/k/vowgbMJ0VWMjuJVd9NrdEoAmK4KYqiwatJMbMmgdB6Y
 NKJoTeuOYuWjBmjXyCGKsE4HhHvvcbKUsyaQYa5ek2/SR7dx0Vs2RYNyriQJUtIaEjmwuG4hL5ED8
 FGnp8cF7A86OZ9fg=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wztrX-0001M2-LM for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:31:08 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4956869750eso4971645e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 03:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787913061; x=1788517861; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Aa5n4VNlNp7VUgIG79cMYNOeO2n1DeOui8+WAL3svC4=;
 b=eUrGNuzlIHdcOPsWCBIiDNLQ+dTUtZY0yFbP7jzokR63RBypIm0oZvMHUx//PxxHL4
 N8402aAhWF68R6xEViLIVJJDd30HCB8kMwF6RHhLbszTy1DORECLdIxOCfRS2zPISmS4
 XqPgwepEslBPg6ACycKkkQUxdiFdB8Irw2OpfJK7wYnmh4pF8eO9oVnsdgGs2f5TgN9Z
 C2QfbNtqhXDlnjff4tfKrXyaI0b6EARPpaBowJm8t5W130ecAj1P6DAp7P4jWruda9AV
 s6CJbi2137DYWkCuoamP4XVrHyRYdUcCaZoeIDG/IsjdOvPn/TPMxFtFhNOFg5/7K/1Y
 Q9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787913061; x=1788517861;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Aa5n4VNlNp7VUgIG79cMYNOeO2n1DeOui8+WAL3svC4=;
 b=rtU6E/P2NGab+L6U4PAscIpod7hWoJd9y2JtA42QxH/+zzJaaKKO0bVPxoWTyNzrlA
 VWGmLoDHeldBaFlmt4g2cEiSj2b7cTYRJndzgkrJ17wgnr9R6yfaylLA+WJ2dyjk0PBX
 y8heu32ezbo/gocT7H8D/V4cjhR31cQo4mwPiifiDi8W+ziBzu39JUimQRvsmFve8+3L
 xrFUq7IVmYgqjwd3+/DBVy5+O/evW6zEhgoxk94XjM6YjCi/zx/gP/rVH8Un4BgWQ16L
 mN+Iyd+LwSZf1Vkk38xFQaF96XbZx8AYOW8kLSTeUu2WCemsjFOrE3VaYL/5nGXX4h8p
 5sIQ==
X-Gm-Message-State: AFuF++nyrF1MmZ5PteWLdKVbpqKlPaf3Pk7xPr2ru779jZxGpTx21hmS
 1kArfWPIjP08WULP/gp+HzXDlWOTn71PCWqs7Onx1uFI9698QZKPDcJZm0f65rjw4dRIiCWaQHD
 +BsublOGSEyYCga6kmkpdfRFpQZ/AdV0Ap+bfDun8qHl809Y+TKDKzDTMtIXkqu/gSVIITvJ+ND
 ttrDtr/Q==
X-Gm-Gg: AR+sD11eZt5GNOAe4XprUI0fkQ5ksYFM+cfYD9K2bHQaX0QOenNaF2ZTFUhY/OIMEik
 NV6Hfq4K8XTD7c+axabt4BHBuqFoPj4gI6joVPMXa5RMHe34O9ft9zZUw2YDSDir3i8LEP1ZuXp
 KYEyVbEVvDVqJwI1j7WZdfHw/3ZwZYi5OOkhN/biw2u806PKDmpJVicaxZXuLxKFuu0eJPqFpO1
 oH5hK//jXmbg60PfwInHTrK6eLAgSjRExu6Q+A5eIhXlUEzq3RT4ZdAV+DN4jlMADtYKsC3KhGP
 SDmnWRozzB8ORZJlH35I53xogX3jncs7MFQxTNVl1jR8OSK0/k/wMuUd3DYNSsfC5Z1Kiw+hh8r
 4yRCofEiIHA3i2lCo/xCQQUCQ8UuwxBUu5lJER6m8f+KAs0dFV/OWYehzoZvs64CzI5hNtIZobK
 lc0BVOCazIsZm/GZN68X+YYYZiTQVTICEVrBwkjGXh/OdhVjo/l/JyL9S8Zvu4eIjZz4nfa1hRM
 F9QVzkyZylhLqPmtWS7N8Y+/QbmtlxNSP2orge/bZIkiG/MnpohEMXCiUAM+8RpgjZlmXrYxDrL
 nCp1KydpUVI+/4gdgy+8R7DcK/89oRWoWYAW9DK6C+cLLajO8RYN
X-Received: by 2002:a05:600c:a03:b0:499:93b3:91ea with SMTP id
 5b1f17b1804b1-49b91c5096dmr75907845e9.15.1787913061018; 
 Fri, 28 Aug 2026 03:31:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49cc61cfsm129671665e9.6.2026.08.28.03.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:31:00 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 10:30:58 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb438
X-Gerrit-Change-Number: 1854
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1854?usp=email>
X-Gerrit-Commit: e9b9f6c0b61a3aaaa4c696ac3c091c4ee580a305
In-Reply-To: <gerrit.1787327336000.Ib7d9aa61fd878d7e025e9d1050c563dd114eb438@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib7d9aa61fd878d7e025e9d1050c563dd114eb438@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliN2Q5YWE2MWZkODc4ZDdlMDI1ZTlkMTA1MGM1NjNkZDExNGViNDM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d30e366febdd680fe4ab49b86779d5c7f3ac7a70-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wztrX-0001M2-LM
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3475779911167948103=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3475779911167948103==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oWvprg/g57c="; charset=UTF-8

--oWvprg/g57c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#9) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1854?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: Factor out lookup_session_by_mda_key_id into=
 its own method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Factor out lookup_session_by_mda_key_id into its own method

This make=
s the code a bit easier to read and also allows reusing
the function later=
=2E

Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb438
Signed-off-by: Ar=
ne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1854
Mess=
age-Id: <20260826185309=2E18083-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38736=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
multi=2Ec
1 file changed, 20 insertions(+), 10 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/54/1854/9

diff --git=
 a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index d8dd99b=2E=2E46ff1ba=
 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4014,6 =
+4014,24 @@
     }
 }
 
+static struct tls_session *
+lookup_session_by_mda=
_key_id(struct tls_multi *multi,
+                             const unsign=
ed int mda_key_id)
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
@@ -4024,17 +4042,9 @@
     if (mi)
     {
     =
    struct tls_multi *multi =3D mi->context=2Ec2=2Etls_multi;
-        stru=
ct tls_session *session;
+        struct tls_session *session =3D lookup_se=
ssion_by_mda_key_id(multi, mda_key_id);
 
-        if (multi->session[TM_IN=
ITIAL]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_key_id)
-        {
-      =
      session =3D &multi->session[TM_INITIAL];
-        }
-        else if =
(multi->session[TM_ACTIVE]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_key_id=
)
-        {
-            session =3D &multi->session[TM_ACTIVE];
-        =
}
-        else
+        if (!session)
         {
             return false=
;
         }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1854?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib7d=
9aa61fd878d7e025e9d1050c563dd114eb438
Gerrit-Change-Number: 1854
Gerrit-Pat=
chSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--oWvprg/g57c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #9</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1854?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Factor out lookup_se=
ssion_by_mda_key_id into its own method<br><br>This makes the code a bit ea=
sier to read and also allows reusing<br>the function later=2E<br><br>Change=
-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb438<br>Signed-off-by: Arne Schwa=
be &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1854<br>Message-Id: &lt;20260826185309=2E18083-1-gert@greenie=2Emuc=2Ede&g=
t;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefor=
ge=2Enet/msg38736=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file changed, 20 insert=
ions(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/54/1854/9</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index d8dd99b=
=2E=2E46ff1ba 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br>=
<span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -4014,6 +4014,24 @@</s=
pan><br><span>     }</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static struct tls_session *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+lookup_session_by_mda_key_id(=
struct tls_multi *multi,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                             const unsigned int mda_key_id)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (multi-&gt;session[TM_INITIAL]=2Ekey[KS_P=
RIMARY]=2Emda_key_id =3D=3D mda_key_id)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return &amp;multi-&gt;session[TM_INITIAL];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else if (multi-&gt;session[TM_ACTIVE]=2Ekey[KS_P=
RIMARY]=2Emda_key_id =3D=3D mda_key_id)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return &amp;multi-&gt;session[TM_ACTIVE];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static bool</spa=
n><br><span> management_client_pending_auth(void *arg, const unsigned long =
cid, const unsigned int mda_key_id,</span><br><span>                       =
         const char *extra, unsigned int timeout)</span><br><span>@@ -4024,=
17 +4042,9 @@</span><br><span>     if (mi)</span><br><span>     {</span><br=
><span>         struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct tls_s=
ession *session;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct tls_session *session =3D lookup_session_by_mda_key_id(multi, md=
a_key_id);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (multi-&gt;session[TM_INITIAL]=2Ekey[KS_PRIMARY]=2Emda_ke=
y_id =3D=3D mda_key_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  session =3D &amp;multi-&gt;session[TM_INITIAL];</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        else if (multi-&gt;session[TM_ACTIVE]=2Ekey[KS_PRIM=
ARY]=2Emda_key_id =3D=3D mda_key_id)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            session =3D &amp;multi-&gt;session[TM_ACTIVE];</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (!session)</span><br><span>         {</span=
><br><span>             return false;</span><br><span>         }</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1854?usp=3Demail">change 1854</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1854?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Ib7d9aa61fd878d7e025e9d105=
0c563dd114eb438 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
854 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body=
></html>
--oWvprg/g57c=--


--===============3475779911167948103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3475779911167948103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3475779911167948103==--

