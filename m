Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B6606A321
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=I35VOMBW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bR8CQYqb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aimxnqbu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QF+oJ3J0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wqKrqNVB7FBh3PYo8/qb5D8/eQhQep0BYycH9NFoW6c=; b=I35VOMBWtX8BIm10PaHcj3sA8z
	DB5SMI3Rlmwe32LItOXAFSqszFGV+n69Ys/gPvOmp3LzUMtp0WhpPc7I0lL8CxDuCYYB6ba4pwqAa
	CvuyWjHZDKgV2/fXTbyeXPvHwbblVr+ymiJv2ZAIrbLDj5HI7WwV2S8x1kWW/UWiJlXY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQJKr-000000006VU-1TXS;
	Mon, 09 Nov 2026 06:58:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQJKY-000000006VA-1eSL
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 06:58:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TG/h1KlXxhXVvQc8ra5N7dnR+Q2cTYT+Nv52y14T/rM=; b=bR8CQYqblIHmVUTarpC47ticMP
 nIB9LNcj5eFjSWWpR1ofxSzaSXNR2HwFYn02+pwYnJzw6d55d7RSFXtoQ5PRaYeVG+mFji/wsKafC
 XfAzh/Nx4MRUjpcu5JyfzKT0/+D9mXob8oDyNJuFU1cB+x+ypCWtY/kovfilw8885QMg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TG/h1KlXxhXVvQc8ra5N7dnR+Q2cTYT+Nv52y14T/rM=; b=aimxnqbuFTQqHpwIAbuWVCnv9r
 Bw2fYxqtrZEAd1CrBQ5kIdeQX/tYlKPXG1RBDviUO7ZVsDvCmoFSVZG9yUOP7/tz4rwokxrNlx7s2
 0vq5S7KzmmC8m4Gvsmwsv+jXk0gcnLKQ2U8PL67pR18Edm5h++vCk/+Z+DzhF0wCo16k=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQJKO-000000004fu-3ZUr for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 06:58:05 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so5259295e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 22:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794207478; x=1794812278; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TG/h1KlXxhXVvQc8ra5N7dnR+Q2cTYT+Nv52y14T/rM=;
 b=QF+oJ3J0oRdlgRsVnLimOotSSsiNqiEhDkjSyeSoZYSJJ8x348e8gjSL3KdK4P0mTn
 XVwhQN5QshZUd/DJT+Jh4cxVZ1qKmlr7HYoRnJQwCoZDJp84QAsZuKqg1umuUn7uOsNq
 TVwAVEpS88kvcfGWI9W6H9F/R+z6eS3OFQ5E+UViKv78J+yzRJvvaT+kwuqNTRAv1JDH
 rbdWfFowe++MYzpLEm5qojJLO1T18ln3TR7SmUH9vAGc2aggDk6BO5KUTuFJctIEXkES
 ivyAyOQiqb95elTQD3EfGU9/7IhExyYqogqukxOfv8zqs97F1L4gKAcmqGpKuvBdW9GI
 hIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794207478; x=1794812278;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TG/h1KlXxhXVvQc8ra5N7dnR+Q2cTYT+Nv52y14T/rM=;
 b=NUU60+p75ML3P9zyQTyOY2P2/pEneIXhJBZtA/dQI7D62Z7oW2I5TcPsHG2LIX5zyB
 GUgrzFYS32qFsLcSck1MZSf/4bp425L8NGAWmd4cM3xfcGP+NU901EX4CNB+S86phEYy
 xR1RcYMFNpvMEbjAnhoW4xK17lS+zawnGP0qJYOoq6NQChvW4qYEj9kFKurKmBPreoNK
 hihwH1LagklPI/o2+X0gvJoQbgc5kus6xiIwexI7YssujPnlWfYUr3xbuxFbMkCiEATk
 dl4xsYHTOpfIBl9XiLP9K0niHt1P2tZiwx2pzrXAUoNraa4WowRfeI5WeuYZ9z/BPaSj
 rA4g==
X-Forwarded-Encrypted: i=1;
 AL+hErHKz3mvkFpUNB+g5ZkmDuxu9VBqJ8yCVmSa8Hjudh0cDvIbk9K/ZWnhhznC2b4T1MgxfGRlKtXhtpZEcXPa@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9AO3xQ5tr+OWiC4xct6OiW8Am/G8fNlQbRboFVcRdA4p/ZVdpd
 C0D6prFdY7+d2HlfVLV9POkyhhn4NPvWf7L7Zs6eU2lOt52iEI5CbxHfEFbBIjaKq+xFjrcTM+J
 jMqApMCNjpClOxQF9+CAWiOKTSILOjZECxPBtec1QdhGbfHpphybDWsk+IfL2ZUvorOcHN4uh/b
 jLztgMHA==
X-Gm-Gg: AYBFou0ZHvklOx/rCeYKSTna33Q2/zVAJ44D2Y7cwJq9344PLpGzJxUzP6gCUHQiiGi
 u5qSFyF7240zaupanRxtGMsItdE4GAHC4up1LHDXQQxvcgtougDUQrD/bMMIJiszY2PA5oPIqiB
 st7tq0chw/naET03yR+npMdpm1TmSzUdpaY0XJSnPY2bwi4/ORG73bz0m9bUq08e44zFHjOQ64J
 NWuu5R5NxErrhBx8fsw8Kl2mK9wI/y0bKY2EAXRVA7Qnid9ugQoUt82TUmVvV8kFzBAoqy4hiBy
 VCRMgxbDqLbI0xT9J5I/WvcwodYLbMw79CL4mmlhocbTQc4q8PDq838TTy8uBgFaQhk10Mxb90H
 Awp6GeAsvzgqzFtyC+AFJNODmtPL8z1QB7xs/A7/fY1vLvkxBauVtxdggnHsLlacjUYUGefTDAe
 bHqneT2A9mZel20pCoetTuCsXD2Cy7FvMUMnEZ8xyOelezD1W1JnqUsaRtHXL3QPI+0A9wOAmMb
 bRhmkxokZccGyNNR0gwdCjZMa7y5vHmAsOBiC+6BzyaCQ5UMWSwIy04KbXlrxce8R8UYcHKRkXR
 3UrbfSClBpzr99l4t7N6UajXwh6v5XZgFo0r28jQfuVP5WJxssd+pPZsVI/FoFJNPuPsyqUKRq6
 SN2JAwQf4oz2WkAR6u4dIyh7bWq0j+MVkEnWlcZ4+lCzJeeWMjwd5e/f30l8yxu89n+ZC8QkpeZ
 cLx5Uw0rVaY0v8Lw==
X-Received: by 2002:a05:600c:4854:b0:4b7:76b8:348f with SMTP id
 5b1f17b1804b1-4b82af6d070mr68158145e9.19.1794207478089; 
 Sun, 08 Nov 2026 22:57:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49592f3a7bdsm6616697f8f.1.2026.11.08.22.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 22:57:57 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 06:57:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Idb22f731a00158ff020a819081a07e1235d8323d
X-Gerrit-Change-Number: 2156
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2156?usp=email>
X-Gerrit-Commit: 990ade4504db620fa7dccb272635518eb4afa654
In-Reply-To: <gerrit.1794139716000.Idb22f731a00158ff020a819081a07e1235d8323d@gerrit.openvpn.net>
References: <gerrit.1794139716000.Idb22f731a00158ff020a819081a07e1235d8323d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MTM5NzE2MDAwLklkYjIyZjczMWEwMDE1OGZmMDIwYTgxOTA4MWEwN2UxMjM1ZDgzMjNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ef3815453ec4402b9335cb7e2045055ec4d7e919-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQJKO-000000004fu-3ZUr
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: clear
 the context, not the pointer, in ovpn_dco_uninit_net...
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0113015289560485903=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0113015289560485903==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pV3a823fnE8="; charset=UTF-8

--pV3a823fnE8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2156?usp=3Demail )

Change subject: dco_linux: clear the contex=
t, not the pointer, in ovpn_dco_uninit_netlink()
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_linux: clear the context, not the=
 pointer, in ovpn_dco_uninit_netlink()

CLEAR(dco) zeroes the local pointer=
 variable instead of the
dco_context_t it points to, so the context keeps t=
he nl_cb and
nl_cb_notify pointers that were just released with nl_cb_put()=
=2E

No functional change today, since close_tun() frees the tuntap right
a=
fter, but use CLEAR(*dco) as intended=2E

GitHub: closes OpenVPN/openvpn#11=
43

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: Idb22f731a00158ff02=
0a819081a07e1235d8323d
Signed-off-by: Alexandre Laroche <larochealexandre@h=
otmail=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156
Message-Id: <20261108122=
630=2E10223-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg40903=2Ehtml
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/dco_linux=2Ec
1 file=
 changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/dco_li=
nux=2Ec b/src/openvpn/dco_linux=2Ec
index 4412ad0=2E=2Ea84e310 100644
--- a=
/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -537,7 +537,7=
 @@
     nl_cb_put(dco->nl_cb);
     nl_cb_put(dco->nl_cb_notify);
 
-    C=
LEAR(dco);
+    CLEAR(*dco);
 }
 
 int

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Idb22f731a00158ff020a819081a07e1235d8323d
Gerrit-Chang=
e-Number: 2156
Gerrit-PatchSet: 2
Gerrit-Owner: Alexandre Laroche
Gerrit-Re=
viewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>

--pV3a823fnE8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2156?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">dco_linux: clear the context, not =
the pointer, in ovpn_dco_uninit_netlink()<br><br>CLEAR(dco) zeroes the loca=
l pointer variable instead of the<br>dco_context_t it points to, so the con=
text keeps the nl_cb and<br>nl_cb_notify pointers that were just released w=
ith nl_cb_put()=2E<br><br>No functional change today, since close_tun() fre=
es the tuntap right<br>after, but use CLEAR(*dco) as intended=2E<br><br>Git=
Hub: closes OpenVPN/openvpn#1143<br><br>Assisted-by: Claude Code:claude-opu=
s-5-5<br>Change-Id: Idb22f731a00158ff020a819081a07e1235d8323d<br>Signed-off=
-by: Alexandre Laroche &lt;larochealexandre@hotmail=2Ecom&gt;<br>Acked-by: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2156<br>Message-Id: &lt;20261108122630=2E102=
23-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg40903=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dco_linu=
x=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><=
span>index 4412ad0=2E=2Ea84e310 100644</span><br><span>--- a/src/openvpn/dc=
o_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><span=
>@@ -537,7 +537,7 @@</span><br><span>     nl_cb_put(dco-&gt;nl_cb);</span><=
br><span>     nl_cb_put(dco-&gt;nl_cb_notify);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(dco);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*dco);</span><br><span> }<=
/span><br><span> </span><br><span> int</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Demail">chang=
e 2156</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Idb22f731a00158ff020a819081a07e1235d8323d </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2156 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Alexandre Lar=
oche </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli=
 &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>

</body></html>
--pV3a823fnE8=--


--===============0113015289560485903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0113015289560485903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0113015289560485903==--

