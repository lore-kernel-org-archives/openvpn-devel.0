Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10C7C79F99
	for <openvpn-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=zb7KW0FY6uRAHcwH8yVfCx3CGLYtc6CmDD6QgCws70c=; b=bLacuVkHwrm8gj
	wrOUGW1B/eBAXfOPXaTG+vj9oFrTK75iPfnDfZd+Z1EzPA0+SGrONRiWEQidYZ6wIM5OtLk/7vdxy
	K83a2zGLeQhoFh0JoR0v8AU27oqDeM7ruL3LvjWR16GPi1bud94mG0c+Aq1v2R72WmyFByD9NJku/
	Zzc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3yly-0003Qr-Tn;
	Tue, 08 Sep 2026 16:34:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3ylx-0003Qi-9a
 for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 16:34:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pspvLF1n6X8/2GabsfdPeZquXkXfVX2s92DThMNN5po=; b=g9APqyX8pUHobwYKQ1fyJ6ZGJC
 2YCYKpAjoiHkOXz6VW1U9Qg75pX95gfJUq+sn1R1Gx3RW+BYsheQtx6FH98esw+CrUt9AaQrJJWtg
 U620UpJQsvCMBDXyBiMwUSn8wzF9YZd/4Xr84jlxoXgDbUISGUCE2DmyDSB18k+bqhxI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pspvLF1n6X8/2GabsfdPeZquXkXfVX2s92DThMNN5po=; b=c
 be3Y8Wo06exZ1Av7+FRyrjr+QZjKdJ3kls8+wEhyefOziPYHedsjurFA0fwFNBSQkLnivPsI8Ed5o
 a8z03rnCgczaOuzKo/GPWN9N/zJi6Pd7LbkZhXIquBYHhXOjUxxoN3yy3bpkb6+etBX5MFf29Fqbt
 Zw25LVWhv5pEhROQ=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3ylv-0008Tq-OV for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 16:34:13 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so5527265f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 08 Sep 2026 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788885245; x=1789490045; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pspvLF1n6X8/2GabsfdPeZquXkXfVX2s92DThMNN5po=;
 b=abKohxducZt+JthTd6De3QAeIsQMtxAEq+jouRlMgQR7no/g2qaxEDEz5KBo0Sthh1
 QlJB2/HYImlQ3qKbS5XwrMWQzvbUNVDU4N/pKwxsjpVcwcFo62rySDcP3WgX4SfZoDrr
 A6Qfgy3m4cg+/jwYXAl+KgPWO/Q+9xRw3OkhxFm0Hw3HazwzRporIWuuOZH0wecFJANM
 AypWHUkH/1dCKFyaLFBTTIJJK3RDT1AkNyjqMdO6s5R5PAc3kdej7olj42LhaEZXgLgh
 FOTwpJMF2WTzfFsxKShjVqYjHEJyL7GzyaFEERnLtDFA1Il0LRtf8A+gKrQ87tHZeIRT
 VxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788885245; x=1789490045;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pspvLF1n6X8/2GabsfdPeZquXkXfVX2s92DThMNN5po=;
 b=jxRs8G1D8rgHS0PwdLMExWDg3UQvAdUpdAEXNQwo0GGPR0TvL5erKBexpG/+IOZAHx
 8xEniBfk8dyS2KD5PR18ny8UfCjrjxS5iAgKyicj/DM1GvV6NuRUNE88KcbksYggswkp
 uta9oyEZyxcN0oUvNERZE8cBP6qbvw9xSISl2meQTCAzEpPGVFNr7icLD3PU9KmnIcdc
 G3k/wK/Y8iG0xlPCI7DFqjKrTicDPYBeVsjueIJ106ezmWzIrreGAXgGH7e31/i4jQNa
 2Jc5Izn3dWlsvrhGQx9fx8T7ZpCr9iEyt5qyjpw20V3JPPbN5gFj3EFKIWERvZvUk+xA
 n73Q==
X-Gm-Message-State: AFuF++n/qAhFAwH3h53iblx3UrZaUmZcOtjmHGsfFO4qc+G5oAtywmuK
 Hv/wcb8jxp4pDcoCOw8y3Ngba9vtoQFSq+HqUzh7+q0W2/vLXR9xMGGSh+bQm01g9PfQ3xFmVvV
 t9e1/n12REdgMipC6PusGlNZzdpkFG0wbwAR6qURVh/MffXyt1xM0Kmvv1YB1IjsbIb6mV9Ced+
 D3A+Cxfw==
X-Gm-Gg: AYBFou1I6AdJf+TYCDDVUPgEIWUvxzgtkfje2btsOYh1SV6ktMFrySgBSAehUlP6NhY
 OV0mAfPhNvG2fSR6DsyJT/SX536Io/y7h7G1BZ7UiOAz//6E4WIWbl8TiUetyMmbY/cMSgI6D+q
 ydqP802sjl9ynnSWgrV1IReF0FTe/cZJ/lg4OjO1eaOysAjcnGg95v2qkj1lecaOgDHQujo8+Eh
 SMY6O0oXLcsjvJUSBoz2TlE3mlRa1wOAcoju9Oe1SIxPr/93f9DE3+JKiCtkhMae880x9P/Tbjz
 ueO+WVr0bd2SDSRJeezUId3APcWSDItgC2e0rtZPqGxn1rcbhJ+biaRW59O4ZoQsctjqqFYAwiK
 RBPiufjzHk1QKSF6YXv3yfJRAf6fqawhhMCwicYBYF5ec8FCSLUMJZDXVfQORRE7Dx97Q+S6AAK
 xkNkXEIj3IH9hL3m8qPqpI1zlmlaI+aabUtz7yQP9ryB+FM8dzP61J2jY9uDYLQ9nEdrx6ftlzr
 kUn8yx3v7nz1Vph1zZnjAxkImSe1QqZNB96iu0YPmU16/y+b0OfZEXZnRuLfQU6j3FIU1XspnyI
 fqhzSdxXfdScV4B+5V+I+z0jm4/H+7sM1j+sOXJM+oyo43eb3GY=
X-Received: by 2002:a05:600c:3b21:b0:49c:ee01:8c53 with SMTP id
 5b1f17b1804b1-49cf820ab3dmr303461615e9.2.1788885244942; 
 Tue, 08 Sep 2026 09:34:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f912esm503362165e9.4.2026.09.08.09.34.04
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 09:34:04 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 8 Sep 2026 16:34:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
X-Gerrit-Change-Number: 1907
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1907?usp=email>
X-Gerrit-Commit: 6701dba01aa860e64db2c91d4974589921bbcc65
References: <gerrit.1788885240000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MjQwMDAwLkljOTgzYTNiZjFlZThkNGVmOThmMzg4M2Q1ZTVkZGYyMzQ2OTZhMTgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <24ba19ddb21990dcb2edbd3cb67056a2d8b337de-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3ylv-0008Tq-OV
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: openvpnserv:
 harden CheckConfigPath() a bit more
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, openvpn-devel@lists.sourceforge.net
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5099266535168895465=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5099266535168895465==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/bZEMCTCPCo="; charset=UTF-8

--/bZEMCTCPCo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, plaisthos, razvanc=2E

=
MaxF has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1907?usp=3Demail )


Change subject: openvpnserv: harden Check=
ConfigPath() a bit more
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

openvpnserv: harden CheckConfigPath() a bit more

If the config_=
path retrieved from the Registry doesn't end with a path
sepatator, the pre=
fix check could be satisfied by a sibling directory
that starts with the sa=
me substring, e=2Eg=2E "config" vs=2E "configx"=2E While
code in common=2Ec=
 ensures this, that code could disappear in the future
leaving the check vu=
lnerable=2E Instead spend the few CPU cycles to be
absolutely sure, we're d=
oing the right thing here=2E

Discovered and reported by BreachX Zero Day L=
abs, using Typhon AI Mil v2=2E
Contributing Researcher: Vivek Parikh=2E

Re=
ported-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Tested-by: Vivek Pari=
kh <vivek=2Eparikh@breachx=2Eai>
CVE: 2026-78043
Change-Id: Ic983a3bf1ee8d4=
ef98f3883d5e5ddf234696a182
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlic=
h=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Arne S=
chwabe <arne@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1886
Message-Id: <20260831184709=2E3359-1-gert@greenie=2Emuc=2Ede>
=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg38854=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
(c=
herry picked from commit 588af513aac1d2d774fd3fde1716384e3501a5a1)
---
M sr=
c/openvpnserv/validate=2Ec
1 file changed, 5 insertions(+), 0 deletions(-)
=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/07/19=
07/1

diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/validate=
=2Ec
index a59f9b1=2E=2Ebd89205 100644
--- a/src/openvpnserv/validate=2Ec
+=
++ b/src/openvpnserv/validate=2Ec
@@ -67,6 +67,11 @@
     const WCHAR *conf=
ig_file =3D NULL;
     const WCHAR *config_dir =3D NULL;
 
+    /* config_d=
ir must end with a '\' or the prefix check below could be satisfied by a si=
bling directory */
+    if (config_dir_len =3D=3D 0 || s->config_dir[config=
_dir_len - 1] !=3D L'\\')
+    {
+        return FALSE;
+    }
     /* fnam=
e =3D stdin is special: do not treat it as a relative path */
     if (wcsc=
mp(fname, L"stdin") =3D=3D 0)
     {

-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1907?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release=
/2=2E6
Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
Gerrit-C=
hange-Number: 1907
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=
=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: d=
12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Attention: d12fk <heiko@openvpn=2Enet>
Gerrit-Attention: razv=
anc <razvanc@mailbox=2Eorg>

--/bZEMCTCPCo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, d12fk, plaisthos, razvanc=2E </p>
<p>MaxF has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">openvpnserv: harden CheckConfigPath() a bit more<br><br>If the =
config_path retrieved from the Registry doesn&#39;t end with a path<br>sepa=
tator, the prefix check could be satisfied by a sibling directory<br>that s=
tarts with the same substring, e=2Eg=2E &quot;config&quot; vs=2E &quot;conf=
igx&quot;=2E While<br>code in common=2Ec ensures this, that code could disa=
ppear in the future<br>leaving the check vulnerable=2E Instead spend the fe=
w CPU cycles to be<br>absolutely sure, we&#39;re doing the right thing here=
=2E<br><br>Discovered and reported by BreachX Zero Day Labs, using Typhon A=
I Mil v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>Reported-by:=
 Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Tested-by: Vivek Parik=
h &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>CVE: 2026-78043<br>Change-Id: Ic98=
3a3bf1ee8d4ef98f3883d5e5ddf234696a182<br>Signed-off-by: Heiko Hund &lt;heik=
o@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1886<br>Message-Id: &lt;20=
260831184709=2E3359-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38854=2Ehtml<br>=
Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>(cherry pick=
ed from commit 588af513aac1d2d774fd3fde1716384e3501a5a1)<br>---<br>M src/op=
envpnserv/validate=2Ec<br>1 file changed, 5 insertions(+), 0 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/07/1907/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/validate=2Ec=
 b/src/openvpnserv/validate=2Ec</span><br><span>index a59f9b1=2E=2Ebd89205 =
100644</span><br><span>--- a/src/openvpnserv/validate=2Ec</span><br><span>+=
++ b/src/openvpnserv/validate=2Ec</span><br><span>@@ -67,6 +67,11 @@</span>=
<br><span>     const WCHAR *config_file =3D NULL;</span><br><span>     cons=
t WCHAR *config_dir =3D NULL;</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* config_dir must end with a &#39;\&#39; o=
r the prefix check below could be satisfied by a sibling directory */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (config_dir_len =
=3D=3D 0 || s-&gt;config_dir[config_dir_len - 1] !=3D L&#39;\\&#39;)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     /* fname =
=3D stdin is special: do not treat it as a relative path */</span><br><span=
>     if (wcscmp(fname, L&quot;stdin&quot;) =3D=3D 0)</span><br><span>     =
{</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Demail">change 1907</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: re=
lease/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic983a3bf=
1ee8d4ef98f3883d5e5ddf234696a182 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1907 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-filling=
er=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt=
;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@=
openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: raz=
vanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--/bZEMCTCPCo=--


--===============5099266535168895465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5099266535168895465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5099266535168895465==--

