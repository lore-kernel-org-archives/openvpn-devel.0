Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB9606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MNmyHpJs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kCUWPCVa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VnlUliu2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OAj+npEN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TnXId18I9K6vhnB3KPJYjhPAqZ8GkQUYUUNMmzv4f5k=; b=MNmyHpJsmsyp5uvkIuD8N8fAg9
	IKBOdV2gKfjqTF/uYwwqno4PDw5n70iyVG0eOJ0fTmC8KwlV64PBcBf/Cm6V+YUrdb2jNQKZY5a21
	Ci41oj/0AKexcvdGG85jW5XD37Ewf4crFmY9NTvrSo6H19xxLyCOWwJN9dfwCAvmOkJ8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMs7X-00000000130-0dZ7;
	Fri, 30 Oct 2026 19:18:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMs7W-0000000012q-0Prn
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:18:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sL4ig1Xo5k/DdsPx3Bu5Z8k9wQtVQNDdkya6x5HbwcA=; b=kCUWPCVa5O0V6ru+W8+t3bWkXi
 rw/mD2YT3M8XMh4iKabWTleXVpKmRG4z8VdQRFlwtj0OWtQDdbO3b97Z0IMfS7v3e3liKtLuNLXRK
 7E4WK3axli1VqbN/v0JrBxNQo7NPzFu9wAXp1rxyJYpw5DbAEPL4MIhmqM0OnyjQON6w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sL4ig1Xo5k/DdsPx3Bu5Z8k9wQtVQNDdkya6x5HbwcA=; b=VnlUliu2umBYOOEuqgbjRqlHen
 UqLS/OlnLqZDSLb5wyr8hc3b6S0vQKnosMiXBHF/f9Sw4HIDQbutNvrxqgcf3ld348eqRlv7tzz5z
 RhGFiCrjH/MnJZEBtJaz2XpyOht54qxgxc8o1RiWNJkZVAMfc5EarInVx6njs2m3GJHI=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMs7U-000000006bQ-2VSo for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:18:34 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso539075f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793387906; x=1793992706; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sL4ig1Xo5k/DdsPx3Bu5Z8k9wQtVQNDdkya6x5HbwcA=;
 b=OAj+npEN7oleq8U5RkqgT2MCDSb7u6dVrsbV4BmF//CjzRD3k+Br42TTm8Qckdwdtc
 ahtIfAqtiwHvk1F4PhekkkDju3RaVhuLdvqkU01+nf72LmVq+YRQsivNT3tnswbOaGg4
 QScKf/p09mc/nPCd7r8I9jzzXCSV9UbUKEXFSSmtUMMsHLYIuIpMwMz6o389DbIkdyVw
 asDSlGM9OOTyplNLHbqWPSD0ivawCM6CjD6iRr8GGrmljXfqm4rDnlXfV7mrgkij3F2L
 Z5ZYLF4mhvInft3HP4j/gLd9obZRb+IV5EJhG8T1dzjHqLbiQ712SdRycHcqmRUsK8dn
 GWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793387906; x=1793992706;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sL4ig1Xo5k/DdsPx3Bu5Z8k9wQtVQNDdkya6x5HbwcA=;
 b=bIMc88YA3L6UFluB2TqPAO80DayUvvczR6rTSzNVt1Eetqn+hn2uQ3pspI5niwtJ69
 FHtE+dkKfUJc72K5ipKpeG4/5ibHVPB6jV3SL48BES3N3KkZ9T6cLJz8LzYQ0Rostu20
 zVZ+ydvhMTOXbYPC74JX/TQe8wchnc+fLONSckE/U59l0cGQERagHZU7lFm9+Y0M2avL
 wYoMGjUbeQQxjEzuVv4DJFZNgdCYBOvECOEPMOxyJiSIFbJeBVLR4QRJWWusHR89s8N0
 ynXoaVAwD6M7V/046bBV6yBp4U8j5lfIuqgYS10mNZ5i+YG+aY9y0SJ2FbN5DlMGwWi/
 vTHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLpeeU0vPeiwTb42etP5MSeUE9IgOx/8YcUOER7hbFm34QRJ+sshstnqpCiFSy8wEUFbl3g/Ub0wJR4B+O@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKcwYHxN/57GFeF0cyjvFUsgXzs7OCbyJFTKp/Twi27dlOatlH1
 rcF+soJWMxx8vMcZQjut/E/SSXmkemzY53PSEd6k6joP9qKVU2O46gAchGsuBuCo2LcrcURBzGh
 N1GmaFmQxkJV+n3Efo5eW/VHYzQWWhEE26+wyzdbZONBy/sOZKGW65iQu3TNdyP9D9gi1
X-Gm-Gg: AYBFou1MTdNqSzhqV5jL1C1SZisRXo/xJxacBNXQpjdMtAPpQw5R9Pu0j52Sra1Vpk/
 Rj+7rHy4hsJ0itAT5qjsSaHkay+Kjx9uvT7g4UUrMc9co6ICaN28uqL/xx8zNdQsLotap8Y5hkH
 ZWo2GbZZdwdxAtmL9Z6NYBHCioQz4Q5yxLILFMCeyUnFAtVw+Sini4tatmVjO2IptuEFE8xBmGX
 1q/8xbivfkbzTNQ20k95vPnL0m0CWtXSe0V6BMm/q54mws0xEmi1p5Ul+AIETQdAj5ovE2cAEPj
 6SdfetbiXjkfv3CyIxyypiJ3MqcXSzQ1M6kLiBtvvGkqkjHx6w+G8O6CJXod3IsWUtnsL1IpQLr
 pigJ0lztUw3nkiK5cNNCThXboCHBiO9UzvQ1dRKUXLXPziF/SlPLKHDBcYLRQkZStvD2J4xVQBX
 tPvwvi5pNecr7/pqB01tFWpR/dOKRSAVETxvcH9TwSIQbFfA5g1WMOS6PbDqQb5X/EtY9gt4Ufv
 QqxZjlE2/z6WxlB/P0icpgsd7JXk8qyGOH4YxJDlLQRE6y3TK2hsdriz12lCxqV/oRF1JLBtNFH
 znVt0JsYbditToRgtWcrfDKJrCuZrvpxDRzkTkU5djA6YRIRNcXeuSZtdFSMn+d2I5vfLHeE4QN
 lduXcEiuhl8d+gL8XmXhjlO7/RU+4axuSYh2QY8UdFxHMzWOxGZMTi483MNIBnOlC5vcjVVk//5
 znuom2Xyu/cAoz9hU=
X-Received: by 2002:a05:600c:4e50:b0:4a1:7d9b:d4ae with SMTP id
 5b1f17b1804b1-4ac16fa3523mr73649385e9.5.1793387905885; 
 Fri, 30 Oct 2026 12:18:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf751c2d2sm86047045e9.15.2026.10.30.12.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:18:25 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 19:18:25 +0000
To: Heiko Hund <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ifa4497963989c2d6ba68d75942d368c112ac6f67
X-Gerrit-Change-Number: 2038
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2038?usp=email>
X-Gerrit-Commit: 2509ba899f8753f7f1d74812214f2847f9e7daaa
In-Reply-To: <gerrit.1793045668000.Ifa4497963989c2d6ba68d75942d368c112ac6f67@gerrit.openvpn.net>
References: <gerrit.1793045668000.Ifa4497963989c2d6ba68d75942d368c112ac6f67@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQ1NjY4MDAwLklmYTQ0OTc5NjM5ODljMmQ2YmE2OGQ3NTk0MmQzNjhjMTEyYWM2ZjY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d78813ae485bde4af9d4084e743932958d3bb632-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMs7U-000000006bQ-2VSo
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: win32: pass the
 buffer size in bytes to get_openvpn_reg_value()
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7447517239072792987=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7447517239072792987==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6tt+iuKEp9E="; charset=UTF-8

--6tt+iuKEp9E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2038?usp=3Demail )

Change subject: win32: pass the buffer size=
 in bytes to get_openvpn_reg_value()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

win32: pass the buffer size in bytes to get_openv=
pn_reg_value()

get_openvpn_reg_value() expects the size of the value buffe=
r in bytes,
as documented and as RegGetValueW() expects it=2E All callers p=
assed the
number of characters instead, so only half of the buffer was used=
=2E

Pass sizeof() of the buffers instead of _countof()=2E

Change-Id: Ifa4=
497963989c2d6ba68d75942d368c112ac6f67
Signed-off-by: Heiko Hund <heiko@ist=
=2Eeigentlich=2Enet>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2038
Message-Id: <20=
261027130054=2E2283-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40198=2Ehtml
Signed-of=
f-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/win32=2Ec
1 =
file changed, 3 insertions(+), 3 deletions(-)




diff --git a/src/openvpn/=
win32=2Ec b/src/openvpn/win32=2Ec
index fde6412=2E=2E3af58ed 100644
--- a/s=
rc/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1491,7 +1491,7 @@
 set=
_openssl_env_vars(void)
 {
     WCHAR install_path[MAX_PATH] =3D { 0 };
-  =
  if (!get_openvpn_reg_value(NULL, install_path, _countof(install_path)))
+=
    if (!get_openvpn_reg_value(NULL, install_path, sizeof(install_path)))
 =
    {
         const WCHAR *ssl_fallback_dir =3D L"C:\\Windows\\System32";
=
         /* if we cannot find installation path from the registry,
@@ -1585=
,8 +1585,8 @@
 
     /* Attempt to retrieve the trusted plugin directory pa=
th from the registry,
      * using installation path as a fallback */
-   =
 if (!get_openvpn_reg_value(L"plugin_dir", plugin_dir, _countof(plugin_dir)=
)
-        && !get_openvpn_reg_value(NULL, plugin_dir, _countof(plugin_dir)=
))
+    if (!get_openvpn_reg_value(L"plugin_dir", plugin_dir, sizeof(plugin=
_dir))
+        && !get_openvpn_reg_value(NULL, plugin_dir, sizeof(plugin_d=
ir)))
     {
         msg(M_WARN, "Installation path could not be determine=
d=2E");
     }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2038?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: m=
erged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifa44=
97963989c2d6ba68d75942d368c112ac6f67
Gerrit-Change-Number: 2038
Gerrit-Patc=
hSet: 2
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ec=
om>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--6tt+iuKEp9E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2038?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">win32: pass the buffer size in byt=
es to get_openvpn_reg_value()<br><br>get_openvpn_reg_value() expects the si=
ze of the value buffer in bytes,<br>as documented and as RegGetValueW() exp=
ects it=2E All callers passed the<br>number of characters instead, so only =
half of the buffer was used=2E<br><br>Pass sizeof() of the buffers instead =
of _countof()=2E<br><br>Change-Id: Ifa4497963989c2d6ba68d75942d368c112ac6f6=
7<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acke=
d-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2038<br>Message-Id: &lt;202610271300=
54=2E2283-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40198=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
win32=2Ec<br>1 file changed, 3 insertions(+), 3 deletions(-)<br><br></pre>
=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><sp=
an>index fde6412=2E=2E3af58ed 100644</span><br><span>--- a/src/openvpn/win3=
2=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -1491,=
7 +1491,7 @@</span><br><span> set_openssl_env_vars(void)</span><br><span> {=
</span><br><span>     WCHAR install_path[MAX_PATH] =3D { 0 };</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!get_openvpn_reg_value(NULL=
, install_path, _countof(install_path)))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!get_openvpn_reg_value(NULL, install_path, siz=
eof(install_path)))</span><br><span>     {</span><br><span>         const W=
CHAR *ssl_fallback_dir =3D L&quot;C:\\Windows\\System32&quot;;</span><br><s=
pan>         /* if we cannot find installation path from the registry,</spa=
n><br><span>@@ -1585,8 +1585,8 @@</span><br><span> </span><br><span>     /*=
 Attempt to retrieve the trusted plugin directory path from the registry,</=
span><br><span>      * using installation path as a fallback */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (!get_openvpn_reg_value(L&=
quot;plugin_dir&quot;, plugin_dir, _countof(plugin_dir))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; !get_openvpn_reg_valu=
e(NULL, plugin_dir, _countof(plugin_dir)))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!get_openvpn_reg_value(L&quot;plugin_dir&quo=
t;, plugin_dir, sizeof(plugin_dir))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        &amp;&amp; !get_openvpn_reg_value(NULL, plugin_dir,=
 sizeof(plugin_dir)))</span><br><span>     {</span><br><span>         msg(M=
_WARN, &quot;Installation path could not be determined=2E&quot;);</span><br=
><span>     }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2038?usp=3Demail">change 2038</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2038?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifa4497963989c2d6ba68=
d75942d368c112ac6f67 </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 2038 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@openvpn=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--6tt+iuKEp9E=--


--===============7447517239072792987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7447517239072792987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7447517239072792987==--

