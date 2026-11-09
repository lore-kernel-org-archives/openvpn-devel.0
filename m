Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081FA606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=S6A9v+6/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JCNYDV81;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DrLFcy+n;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KFLiq1J4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Cbucbfp0vtiYKpuJMww+Jt/2whBWkV6KzcBGhT5rbhQ=; b=S6A9v+6/qwEhc8FvsbKaOg4x3l
	wOA77SnYwPC8EZCk4TqpWcgcyNyYvDoTuEQ3MogT6rtKq/tofSoZ1ZcY7L4RrQGv7oIH82r9JBzqG
	UwmoK1IcUi6M45YyIqu2AUjUD80A70iHtJYpkmIPUcfyc0Q99rhNNZlrjKB+w5f2risg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQQW9-0000000066C-1QAC;
	Mon, 09 Nov 2026 14:38:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQQW7-0000000064Y-3q0L
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 14:38:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8I1LhOIq+kx74nhqSIKmJ1t+3RAVck/vDMehtKIZrTY=; b=JCNYDV81Kw/7UfDhbuLm3cjOgM
 dmHQ90TInW3MEeoPKotH5xlJDsba51tBfNCeLw9U/nzJ9yMZNAuwACTpuG81A9M89cDpCbLfUWNC1
 NoWE2r031ka+0cGDX02HNE8uOb2zVQxIludngMGo3NJLujYk9OI0YmT7bfS0EGt2T60E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8I1LhOIq+kx74nhqSIKmJ1t+3RAVck/vDMehtKIZrTY=; b=DrLFcy+nsaaQpvLkoIlA6+W8Dd
 6x2qIjfdU6sJIUhOLXjrZhj7aedeXiHXK1qHmoeL5tPHvn/MzjTviUCuxd15Qd7LGwx/vyiQlFQsz
 bH8jJFE0kwXua2K7qhw2s1UII0USMtWz56dr7wwwr9bqn2o21+ztPn4VHgDTukCfqmwg=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQQVb-000000007fD-2Wtx for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 14:38:09 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so9913185e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 06:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794235081; x=1794839881; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8I1LhOIq+kx74nhqSIKmJ1t+3RAVck/vDMehtKIZrTY=;
 b=KFLiq1J4tMwiEAa7IZGO/jYXUCjCH3EYWMXiMDEcw54WjaqTOkN5r3xGp5AVBdgYIx
 tITXG/EkjY2M5yf08G2d1jtsWTRO2uSrEmtSr+RjX6RsLUbMaYaNtzmL0Ld9+s6ixRlo
 BUXsoax3n79TQLULEtqMIrL8TEvQJPtLVeVZYR8l6UtvUfkQrsxOpj4XuGNvxACmdm9x
 wSJSsqVsZBZZNoACtpodRlcOfjw9qM2tYu6HWwhc8/RinjPlbL+EC11s5PbmuwsU0rlv
 q01vnWnDA0p4B+R4SV+3wYzTYNuUAjKhkol3GBniAEzo9QmBqO9uglNKRykoDMvaSP4O
 l33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794235081; x=1794839881;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8I1LhOIq+kx74nhqSIKmJ1t+3RAVck/vDMehtKIZrTY=;
 b=u2bQXUulpOzmeeoJOGYrwIvKuTl6F0k6LhSpiJBng7WTubJg2/u7QwJv0V15b/MPb4
 VFtlNbxEARcHqFmWFTZofGfyJYDszHpwdGcd6R9wgfRkwddpfxvy1Kr4DVkf+zrj+kMx
 Kq7KX5mFKDUmrVkrQr0DU4jbS/hDcbZjh1gtr5rL1cnauwBJdshZv28bSR+5UMbbI/7F
 B9/SbBWimApXmCMY0/TNd/oMjrWpe5rv8DZD85uLK/03qsPrKRPZPCFX8unhUlh0fI18
 Ecbm94HFVcgTuoQNdpPrdBLDGGp2KEMKDNdrl1tckKRwziXfPMwih6CbbaERNmrz++kZ
 U6Mg==
X-Gm-Message-State: APuU4Z8kSzYRxhZ+xNuoQmfARO3z4YACbCVIWdXr6x89FE7WRkGfhsxV
 Iqb+uZFJLqxOh1QL1CcgkU344MLwNwJcrTQZraFtDUkf6LWduWfV+5r5mYVIzUi97RbS7eClYcm
 1rk2pFaosPf3UoPbjnZIu3qlcs3IaxqivkapIbI/FMbRFJgtGqdl4NQxGUPbrTCln/FaP
X-Gm-Gg: AYBFou3hIxcmzDt639Ciq4th+gH3vQhCBsd+bATgup6Dq3X5zuEpYhmQOrxV/GVYywJ
 DRPHyTnIOixzNo2G48EOR1MuCbqRMijBKFGq70flhEGW+b9A0Q8OBxtXG1sfacZtp5zH+S5vbEZ
 vYSDyNAIvHEJg5L75PJbbK4BDr+O7gIsuROnI5NKdXZ/blFXMsJJwtyUziQWdW9eKWpGD1bWnjF
 ZXrSj9n7uLu167WuJhELXHgEDbZkMnodJAdw4fovvDbbRJFUIOQIl7STpTaQ3hTjgRgqinA0bk9
 5oeM9u6IeisdvEzXqHk78u5Ed20E2V3hTEz3/QvAD0LZ5I3QIS1qB3IDLYAH4vpZk3NMNBsxiH0
 /vvgyyFkkMed8QKL8VV6rTtLT6vJENx+MNeh2ogvF1X2Pq85WQvGGA6Dn/dwDMghyUgEtDg20Kc
 cMn8zTNXZbD75hiGGbEikJ2MJygkpe/EZBbHdod4YaFUhx+HeeOPVJM0//VAkirk9aaK3Bx0k5U
 vdjdCYZfapZFBr1XxIZziU2MpifnghhzCk1ZmJtNLOPSzwckVS+tK45BhrE2DD0bPfwkdp8HXS9
 aQsyT0S00EYHZQusFyZ2aGzYTpJvTzWES4LT5BfrW926Z7a4qXWvT6T0He+vrTUlMO30kwlgz5u
 L/fgkstqc9a1mtOaGgRd0yETZ++egeJ+pFJspmOo6Q4ZWpajkbNt5DVR+cOjj83n4zoOsWR+6di
 ttWRkw9s2iWhlFzg==
X-Received: by 2002:a05:600c:3f1a:b0:4a1:c6fd:4db0 with SMTP id
 5b1f17b1804b1-4b963c87ffdmr78947015e9.19.1794235080785; 
 Mon, 09 Nov 2026 06:38:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7da62ecc1sm223186855e9.2.2026.11.09.06.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:38:00 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 14:37:59 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib7b9f2994ca828ea699bc6e5b08193dd30965926
X-Gerrit-Change-Number: 2144
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2144?usp=email>
X-Gerrit-Commit: a2af48f89c00c1de24770fb4789f7cb5436e98f7
In-Reply-To: <gerrit.1793955802000.Ib7b9f2994ca828ea699bc6e5b08193dd30965926@gerrit.openvpn.net>
References: <gerrit.1793955802000.Ib7b9f2994ca828ea699bc6e5b08193dd30965926@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTU1ODAyMDAwLkliN2I5ZjI5OTRjYTgyOGVhNjk5YmM2ZTViMDgxOTNkZDMwOTY1OTI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <99c219a57bad68d7458846c1cd0bdf1f2d816fd4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQQVb-000000007fD-2Wtx
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: close
 the NRPT base key in HandleDNSConfigNrptMessage()
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
Content-Type: multipart/mixed; boundary="===============7536487228117476285=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7536487228117476285==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VqqD0Yho7J0="; charset=UTF-8

--VqqD0Yho7J0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2144?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: openvpnserv: close t=
he NRPT base key in HandleDNSConfigNrptMessage()
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: close the NRPT base key =
in HandleDNSConfigNrptMessage()

The key opened by OpenNrptBaseKey() was ne=
ver closed, leaking a
registry handle on every NRPT add message=2E Close it=
 at the common
exit, and return directly if opening fails, as the key is no=
t set
then=2E

Broken since 0f3b7d17 ("win: implement --dns option support =
with
NRPT")=2E

Change-Id: Ib7b9f2994ca828ea699bc6e5b08193dd30965926
Signed=
-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2144
Message-Id: <20261106162251=2E2926-1-gert@greenie=2Emuc=2Ede>
=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg40830=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
--=
-
M src/openvpnserv/interactive=2Ec
1 file changed, 2 insertions(+), 1 dele=
tion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/44/2144/2

diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv=
/interactive=2Ec
index 6a83bac=2E=2E81205d6 100644
--- a/src/openvpnserv/in=
teractive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -3014,7 +3014,7 @@
 =
    LSTATUS err =3D OpenNrptBaseKey(&key, &gpol_nrpt);
     if (err)
     {=

-        goto out;
+        return err;
     }
 
     /* Add undo informat=
ion first in case there's no heap left */
@@ -3065,6 +3065,7 @@
     ApplyD=
nsSettings(gpol_nrpt || gpol_list);
 
 out:
+    RegCloseKey(key);
     ret=
urn err;
 }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2144?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
b7b9f2994ca828ea699bc6e5b08193dd30965926
Gerrit-Change-Number: 2144
Gerrit-=
PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>

--VqqD0Yho7J0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2144?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">openvpnserv: close the NRPT base key in HandleDNSConfigNrptMessage()<br=
><br>The key opened by OpenNrptBaseKey() was never closed, leaking a<br>reg=
istry handle on every NRPT add message=2E Close it at the common<br>exit, a=
nd return directly if opening fails, as the key is not set<br>then=2E<br><b=
r>Broken since 0f3b7d17 (&quot;win: implement --dns option support with<br>=
NRPT&quot;)=2E<br><br>Change-Id: Ib7b9f2994ca828ea699bc6e5b08193dd30965926<=
br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2144<br>Message-Id: &lt;20261106162251=
=2E2926-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg40830=2Ehtml<br>Signed-off-b=
y: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv=
/interactive=2Ec<br>1 file changed, 2 insertions(+), 1 deletion(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/44/2144/2</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/s=
rc/openvpnserv/interactive=2Ec</span><br><span>index 6a83bac=2E=2E81205d6 1=
00644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span=
>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -3014,7 +3014,7 @=
@</span><br><span>     LSTATUS err =3D OpenNrptBaseKey(&amp;key, &amp;gpol_=
nrpt);</span><br><span>     if (err)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        goto out;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return err;</span><br><span>   =
  }</span><br><span> </span><br><span>     /* Add undo information first in=
 case there&#39;s no heap left */</span><br><span>@@ -3065,6 +3065,7 @@</sp=
an><br><span>     ApplyDnsSettings(gpol_nrpt || gpol_list);</span><br><span=
> </span><br><span> out:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    RegCloseKey(key);</span><br><span>     return err;</span><br><span=
> }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2144?usp=3Demail">change 2144</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2144?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: Ib7b9f2994ca828ea699bc6e5=
b08193dd30965926 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2144 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--VqqD0Yho7J0=--


--===============7536487228117476285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7536487228117476285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7536487228117476285==--

