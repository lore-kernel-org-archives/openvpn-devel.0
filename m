Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1DAC4451B
	for <openvpn-devel@archiver.kernel.org>; Sat, 18 Jul 2026 15:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=9n74SWcQd2CsOFC88wnj8T2yIqXXTFFx7cpfTpOIZnQ=; b=THNw8GXUHnRYyR
	SnjRZfAdaWoRYlzxap0ZHIa6z9bDnQlYCsNr/Sl7/xSMCzjUnrpQsQAOjL/90VwDDuBJo/vVJQSAK
	7MRpI4jUD4ZuuOk4fis1HHVkZyYghb6Gc6GuVZvjCggcIJDzVfCCIzLBXLkj2TuLiGGhleIps1VSt
	+OA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wl7Ol-0008S7-7D;
	Sat, 18 Jul 2026 15:56:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wl7Ok-0008S0-Hz
 for openvpn-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 15:56:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d3DVFm1RRDd6pPH77Y6UQk7mfoTS4TmXgpvSmZRId/g=; b=AlEwK2V3spre7EDbPxFIlRSw4u
 /sNxNd15l7n1qHMb2poP2H3gTvqZkb3+NR295ywyyySURBpOGUCJt6dc/B8IQ9A1BXDaissnrSM0D
 JFySE8kibWYL3XO4rNEXRYXOwi2iGnupm/uN+CuqwhPbNkg8eY9bKJPQS9fSLb3Ts3ec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=d3DVFm1RRDd6pPH77Y6UQk7mfoTS4TmXgpvSmZRId/g=; b=f
 ngAZdIpOO9QfGplXgdeqpE9WGAWRd1s/kbjsD8HhuXge+w0MfSPa20jNjdvxyPQdjrmXk80X1DX8l
 SRtX/08i+xWjAlVsRxjXTE5Wv4fUOSiRNZiujrBtoL7+NVVx6GtRyJntqWKX9ewjgh6N46W42/wFo
 OUEOwqvUU0hun1mA=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wl7Og-0000zC-H7 for openvpn-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 15:56:16 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47f365afc5aso4003358f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 18 Jul 2026 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784390163; x=1784994963; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d3DVFm1RRDd6pPH77Y6UQk7mfoTS4TmXgpvSmZRId/g=;
 b=NLh4SM+QwdnyWpw2/X+s3PaXIGTLxLU3Y/970wK0jd/Buzh4xZpHbc6gUJJfaMsYZM
 SirGw0F/HttDd+O+HGK1HSAzD8ST6RQzJTRmbk0s1CfIIMT7cxR93kimaGRj++V4/e77
 DmocPjPLu6S6il8KF3mEg/AOD8VbHBrgJfOlVypaaAs/0cTzEt8+mLxI8G/wIcFDjBJz
 Eqb6VBpP3hARe8D1QAjgvX9ydDAAUEQF9cClU83SbChwDlu+pvYXbve4JbmF2MIdkUU7
 mCWyXA7h4Say4jnifTJ0Yyiy9srZHQEbbf/6foGInlUraOcZFTwsOZZNExQTpQxu3aY4
 lqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784390163; x=1784994963;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d3DVFm1RRDd6pPH77Y6UQk7mfoTS4TmXgpvSmZRId/g=;
 b=F5Qazo18n8V0F1FRt3vetZsgcriEiBPzf2ls7NTf8Pnmr6yXIaCPQO8GD1FXnlU/kb
 7TYsL7xBHKK/eNR0l1Vou6BqzRqqaKQgbyT1ePAhSP2oCKe7StMQOCHIcQRMtn1cvFJ8
 DlEEfgQhHCEou6h2zSVxvnmy9kJ5U9VCndSnI8D2NsU3siJz9gWbbJBy3gO5p23QeYmb
 OhOZWe8AtPccXgNXATfL+4J2+Q8l0zxJW+fsJ6Cj2sO6o8QHxAvBbruELdxdQVvtgMJc
 MXuRPIJtB8m4tf7N6BS25CZLSePzluAKxXf4P4ic0ylazxnKa8HA7v4/1Ukf9LiBnN2O
 FEGg==
X-Gm-Message-State: AOJu0YycdVg/BQjcnl8EIOky7EI+ocDYsgRcA8ACLXxyXqmtP2goKYtQ
 br92IwBmAfQ0K7WUT0KsAa82cJUmj9tvb0esG4xof/ls5msUREIoXHDTkiEmS5WXbHI4B/PNXvG
 Sc2O8jgTslERtKx2/up6/Pla/XkkNAWeo3HBRL1S7xp3XcJXTGkPFJlAAKWL4fJ9yQmDotJa0rJ
 ZYKYwjvg==
X-Gm-Gg: AfdE7clDjV4VUw4Mqr8CsHGNF717dzPnzv1KxoxIt99U5rQ3tnpu+O2J44qeggR5cLE
 2Ot9JtGkFactj7kH/XFxEHOQvS40QHmXJ8HuQPTabCtK35JTr67tfNnfPGGlERhmjNv1zFWwF/t
 tWJiUJ1kgfqH+nngWyLkh733uX+NUrewp8MTJkh9z7eOcYPcFOuLjitTk2xzHp8peANCvl5wYoM
 c6fP45HjIyuXBQOw9ySTaOT17a8c+PR5qfG1SCHB7CZLNLSQeRZbYLjW+eGFBHZEuLq/uKVbT6o
 gTbb1Jwds2hiRTvVCRaaWSpWMNfxaGHjwdho/CT3hfCWOqZIyMNnpMhMjzvuA7RN5EhMuvDnlt0
 LsnsIozaV2Dy8ugsMtZUa9MMurDjcMoF0EsChiKH/rzvya84o9RdcgxAm2jg0sSq0bnOSmsVdvr
 aVuRU1S+GJ5Cioz21DSRd96yKvvVCcbXBYRYEva6XuOnY16Vl4FGNxFHqw6w9zYHrSCd51ZxgoW
 EJROx/9kqOytvwwi5GBtbKt1z307KY8m3focGVIg4J4OGdwGG1MIPtjNG0aVc51zecx
X-Received: by 2002:a05:6000:188f:b0:475:f0c2:5afe with SMTP id
 ffacd0b85a97d-47f6233b1c9mr9272657f8f.52.1784390162681; 
 Sat, 18 Jul 2026 08:56:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49500sm13498408f8f.2.2026.07.18.08.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 08:56:02 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 18 Jul 2026 15:56:02 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
X-Gerrit-Change-Number: 1795
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1795?usp=email>
X-Gerrit-Commit: f84c0f18b88dbc9f107d46e283c782be0cfa0cc6
References: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzkwMTU4MDAwLkk0ZDA4ODc4MzliNGExM2E5MmU5MjI1MGQxYjMxNWRlYzk0OTY5OGYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <46b517d9e41ca4aa10f81fef16a9d75354b93747-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wl7Og-0000zC-H7
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco.c: make key
 state desync recoverable
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1887853126728028543=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1887853126728028543==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kcUdGsr9lo4="; charset=UTF-8

--kcUdGsr9lo4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1795?usp=3Demail

to review the following change=2E


Chang=
e subject: dco=2Ec: make key state desync recoverable
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco=2Ec: make key state desync rec=
overable

If installing a DCO key succeeds, always record the slot in the
c=
orresponding key_state=2E The installed-key counter only tracks whether
the=
 number of kernel slots grew, but a successful KEY_NEW still means
that thi=
s key_state is associated with the selected DCO slot=2E

Also replace the a=
ssertion in dco_update_keys() with an error return
when the selected primar=
y key is not marked as installed in DCO=2E This
preserves the invariant che=
ck but lets the existing caller restart the
connection instead of aborting =
the process=2E

Github: https://github=2Ecom/OpenVPN/openvpn-private-issues=
/issues/143
Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
Signed-off=
-by: Ralf Lici <ralf@mandelbit=2Ecom>
---
M src/openvpn/dco=2Ec
1 file chan=
ged, 11 insertions(+), 3 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/95/1795/1

diff --git a/src/openvpn/dco=
=2Ec b/src/openvpn/dco=2Ec
index e944547=2E=2E6f158e3 100644
--- a/src/open=
vpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -73,9 +73,12 @@
 
     int ret =3D=
 dco_new_key(multi->dco, multi->dco_peer_id, ks->key_id, slot, encrypt_key,=
 encrypt_iv,
                           decrypt_key, decrypt_iv, ciphername=
, epoch);
-    if ((ret =3D=3D 0) && (multi->dco_keys_installed < 2))
+    =
if (ret =3D=3D 0)
     {
-        multi->dco_keys_installed++;
+        if =
(multi->dco_keys_installed < 2)
+        {
+            multi->dco_keys_ins=
talled++;
+        }
         ks->dco_status =3D
             (slot =3D=3D =
OVPN_KEY_SLOT_PRIMARY) ? DCO_INSTALLED_PRIMARY : DCO_INSTALLED_SECONDARY;
 =
    }
@@ -166,7 +169,12 @@
     /* if we have a primary key, it must have b=
een installed already (keys
      * are installed upon generation in the TL=
S code)
      */
-    ASSERT(primary->dco_status !=3D DCO_NOT_INSTALLED);
+=
    if (primary->dco_status =3D=3D DCO_NOT_INSTALLED)
+    {
+        msg(D=
_DCO, "DCO key state mismatch: selected primary key is not installed (peer_=
id=3D%d, key_id=3D%d, dco_keys_installed=3D%d)",
+            multi->dco_pe=
er_id, primary->key_id, multi->dco_keys_installed);
+        return false;
=
+    }
 
     struct key_state *secondary =3D dco_get_secondary_key(multi, =
primary);
     /* if the current primary key was installed as secondary in =
DCO,

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d0887839b4a1=
3a92e92250d1b315dec949698f3
Gerrit-Change-Number: 1795
Gerrit-PatchSet: 1
G=
errit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>=


--kcUdGsr9lo4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ralf_lici would like plaisthos t=
o <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1795?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">dco=2Ec: make key state desync recoverable<br><br>If installing a DCO k=
ey succeeds, always record the slot in the<br>corresponding key_state=2E Th=
e installed-key counter only tracks whether<br>the number of kernel slots g=
rew, but a successful KEY_NEW still means<br>that this key_state is associa=
ted with the selected DCO slot=2E<br><br>Also replace the assertion in dco_=
update_keys() with an error return<br>when the selected primary key is not =
marked as installed in DCO=2E This<br>preserves the invariant check but let=
s the existing caller restart the<br>connection instead of aborting the pro=
cess=2E<br><br>Github: https://github=2Ecom/OpenVPN/openvpn-private-issues/=
issues/143<br>Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3<br>Signe=
d-off-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/dc=
o=2Ec<br>1 file changed, 11 insertions(+), 3 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
95/1795/1</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</s=
pan><br><span>index e944547=2E=2E6f158e3 100644</span><br><span>--- a/src/o=
penvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@=
 -73,9 +73,12 @@</span><br><span> </span><br><span>     int ret =3D dco_new=
_key(multi-&gt;dco, multi-&gt;dco_peer_id, ks-&gt;key_id, slot, encrypt_key=
, encrypt_iv,</span><br><span>                           decrypt_key, decry=
pt_iv, ciphername, epoch);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if ((ret =3D=3D 0) &amp;&amp; (multi-&gt;dco_keys_installed &lt; 2=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret =3D=
=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        multi-&gt;dco_keys_installed++;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (multi-&gt;dco_keys_installed &lt; 2=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;dco_ke=
ys_installed++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span>         ks-&gt;dco_status =3D</span><br><span>      =
       (slot =3D=3D OVPN_KEY_SLOT_PRIMARY) ? DCO_INSTALLED_PRIMARY : DCO_IN=
STALLED_SECONDARY;</span><br><span>     }</span><br><span>@@ -166,7 +169,12=
 @@</span><br><span>     /* if we have a primary key, it must have been ins=
talled already (keys</span><br><span>      * are installed upon generation =
in the TLS code)</span><br><span>      */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ASSERT(primary-&gt;dco_status !=3D DCO_NOT_INSTALLE=
D);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (primary-=
&gt;dco_status =3D=3D DCO_NOT_INSTALLED)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(D_DCO, &quot;DCO key state mismatch: selected primary ke=
y is not installed (peer_id=3D%d, key_id=3D%d, dco_keys_installed=3D%d)&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mult=
i-&gt;dco_peer_id, primary-&gt;key_id, multi-&gt;dco_keys_installed);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> =
</span><br><span>     struct key_state *secondary =3D dco_get_secondary_key=
(multi, primary);</span><br><span>     /* if the current primary key was in=
stalled as secondary in DCO,</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail"=
>change 1795</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I4d0887839b4a13a92e92250d1b315dec949698f3 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1795 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_l=
ici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--kcUdGsr9lo4=--


--===============1887853126728028543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1887853126728028543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1887853126728028543==--

