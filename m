Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA47606EE88
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KUZM8JUt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DJ7iDX7b;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nI2wYzh+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UmKR4GbC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wp80HSzOX2e+ToNa2dyRwjqQm6UUMYwuEeMPsFcfK5I=; b=KUZM8JUt+SnjlSMq5G1rppBEs3
	P16JgF+aLrRmGyEvnzBvsTp+xDMXJrttI9AybfauUzBHK9sNBlHmauhUE+G/lNh4ttFE4k3F22Uk9
	xedg5/N/+Gc+gH5nUmkzU9/JpMEpKnVZvTTKRj0SZCI1uAkv98yARKWxAbdM1Q1L+q0A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOH7i-000000008U5-3Pfe;
	Tue, 03 Nov 2026 16:12:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOH7f-000000008To-2MUy
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:12:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kgupIWF/rhuKjsIklEEpnQP1I+Jpmf/v3/0TzwquwSk=; b=DJ7iDX7bjBRvw2+tPTIiCpB7Jy
 cdepzj9A9dHRXTQ0DG01XO8I6yn6zbk2vjuulr5UdCbaVhYAJLwE0vjMuevqM4X0xPxWdXtxfHh5l
 6o6DysZGoXdX4+g5fgawNzZGlh0gvrsqGgD+VPA5tv2UXy91XByvwlSr8wtTjA+D7Qiw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kgupIWF/rhuKjsIklEEpnQP1I+Jpmf/v3/0TzwquwSk=; b=nI2wYzh+mF9TMPRte9xfknmMdO
 8PoFcB8J9Sw+pS9Zg69yaQxLEYY9aCuEhEOO/AXHuKxBHATrByTa/Aj/O3OsoC8QLsQUO4de3q6WC
 GkdMhNXKpGV0d9h0xk5yYzv9SsB6YgG+kN5sh/BVmIHHDxGaDHBKBcjryiA2RbbhVuqM=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOH7R-000000000sC-0IDn for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:12:18 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48e04773687so1421817f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 08:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793722330; x=1794327130; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kgupIWF/rhuKjsIklEEpnQP1I+Jpmf/v3/0TzwquwSk=;
 b=UmKR4GbCsgNAZFhfkX2aaG9X7UXeYZAx35sTfXf/IwS8oZykQh7KpnlHXmTtG3T7Vb
 q7vUosmDUcwGYntLtKCjWF06nxzufWMWQBl53twW2a1UCjV/avWXUeUaYhg8t26v2iRf
 Ic+i3QN+iHWlo5yH6XzKITzJ9rf1P9TE+ikDF+McBYg0CQDRctJFcGJIksiXD/bJGbxd
 iYlIp8xp8g3DpB0dEY+J+2hoiQTAGbYagpDwFGsfUJD/8/wC6gwJujjV7C+4DFagDpnK
 CSXE0+Swgcn/DBKciSOGP8iSwyqXt6GKSQTgaKiiiUbjL/LNDbe3F4oUv/hsUnnyHqYA
 pqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722330; x=1794327130;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kgupIWF/rhuKjsIklEEpnQP1I+Jpmf/v3/0TzwquwSk=;
 b=AsLs0D3USCbf8O5TX5FmYSS2BWh1DOOlpN3kCck/rp67UcRv3wnF03mISkUpBeH/bb
 M8N5GmvwmQPy3eeXPJInaxI6Of9JNr+0+eCZCiiahi7D2VkCNvnm+zoxWUr3VCOX6tET
 C7bTcTyDC/7N/0SlSyd8YxNOrWEJRF41OtuQePthfhYKYfnkH24ym/T/Bj3knuokXR+n
 zuP/ItOalvntT1W474CV0aMvV5Ak29H8r7EL2SEmevhXyIGa7ZSxuSeG94MHm4gr19NP
 x7vJ2zOHc7nFdcQK1fx1xuQNiA4n8DBzD7sI3L4WpO1XJIpTZoLSgFTG3G6AlK+K2o+Y
 KvPg==
X-Gm-Message-State: APuU4Z+2z9/kIMxH6LM//tuPVvumOmXuL2nwmfYx7pCUAKYQvOD+DMJY
 fgGlFW6bQ644ouiWQoWzz+Q/FwXueoizC/GOOc0Fc2Y08XRpmMDEaGj99vMrnkJ8PhlAJbSNXkd
 0ijAcn032f6AuvFgFdHQ8psJz5RdZJzNN0TVf0jT44jjemFiDCjhEv2tm0dl55pNSMPn9
X-Gm-Gg: AYBFou1NndIuggRwjEqrawSo8Qz7yW3gxDn715ohRCT+RS29kstHrvm9NN1+RRhH153
 ohtsNMyEb6n6jh+phQNhzrF9HvPsvq1xCwwsgB6ZTBxdK+mG+daJU6pUe+4VYRRGefzi3+d6uQ4
 cvNxrr4QhP18rIvkQmnlQp67yohaLAsWgGccwYs95pnkom2yxeUUcJgLIq5OQbdwg+1G7yjaZ0V
 TRf8jMi7CPfBUM1RPY7ETeIiLck/GQZqJnlknlQTFt3NFq66U11WEUW5sjrJOsasDs7IRAKhh6r
 C+vclM6bQefUmjd4ySLNAYsDbs8mdKknQICPWmyKmvpxebJRbDFyS8y07Ox4+HC8X4AljbsCJ6f
 hg/HnZi+oQARN/cc31jCwio4ZvRLgb4AiQYKcDj5BTzpzs78Twm4N02DUSXHybRyNnxd47ZuNIA
 tPQhkGdTdrxV05Eb5Y8k4IOIOJaTuHSEMplFus0AZvYs2PBVbLKHumb85SCONGK2RZ8rIhHznxW
 Vtv0nsPjSCdyy6FVhZ/+1T/KUTNXgBX5Q/u8j2MLaFbbaRn5GiKK3Ts/7kogdzTyFyh+JNO+p6z
 7bTlMFYwyRWtIRt3IhAZILE252oIyywK7p8rH3CsV9JgRQ2k9WGwGxDuEWxL21kAmgOh335w4Sv
 BZTv2mKVdx5I9eFikQzhuDsw0u7qGP0LxLbPktTk5aT+odWnsfn/3eP5OFo4x2fUuaBCI3IYV45
 FtxiF5+1/zT9UUUw==
X-Received: by 2002:a05:600d:6508:b0:4b0:bc65:b9b5 with SMTP id
 5b1f17b1804b1-4b0bc65ba2bmr133236935e9.35.1793722330024; 
 Tue, 03 Nov 2026 08:12:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab010a66sm96641455e9.13.2026.11.03.08.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:12:09 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 16:12:08 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Steffan Karger <steffan@karger.me>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Icf823c286e48726934131af722fadee4a2ef7a56
X-Gerrit-Change-Number: 2088
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2088?usp=email>
X-Gerrit-Commit: ccdcfa9df2cfafe0d6f4f04c0facbc46ee807ef3
In-Reply-To: <gerrit.1793622782000.Icf823c286e48726934131af722fadee4a2ef7a56@gerrit.openvpn.net>
References: <gerrit.1793622782000.Icf823c286e48726934131af722fadee4a2ef7a56@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjIyNzgyMDAwLkljZjgyM2MyODZlNDg3MjY5MzQxMzFhZjcyMmZhZGVlNGEyZWY3YTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c155a96d9853af5d51f1861416c9b14ca0966a3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOH7R-000000000sC-0IDn
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: wipe PRF master
 secret on failure paths
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1425649259303314163=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1425649259303314163==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jyY+0vVIBGU="; charset=UTF-8

--jyY+0vVIBGU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2088?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Steffan Karger


Change subject: ssl: wipe PRF master se=
cret on failure paths
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

ssl: wipe PRF master secret on failure paths

generate_key_expan=
sion_openvpn_prf() returned early without wiping
master when either openvpn=
_PRF() call failed=2E Wipe it at a single
exit point=2E

Change-Id: Icf823c=
286e48726934131af722fadee4a2ef7a56
Signed-off-by: Razvan Cojocaru <razvanc@=
mailbox=2Eorg>
Acked-by: Steffan Karger <steffan@karger=2Eme>
Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2088
Message-Id: <20261102141538=
=2E29830-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg40471=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl=2Ec
1 file changed,=
 7 insertions(+), 4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/88/2088/3

diff --git a/src/openvpn/ssl=2Ec b/sr=
c/openvpn/ssl=2Ec
index 5b7a1fa=2E=2E12b6119 100644
--- a/src/openvpn/ssl=
=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1505,6 +1505,7 @@
 generate_key_expansio=
n_openvpn_prf(const struct tls_session *session, struct key2 *key2)
 {
    =
 uint8_t master[48] =3D { 0 };
+    bool ret =3D false;
 
     const struct=
 key_state *ks =3D &session->key[KS_PRIMARY];
     const struct key_source2=
 *key_src =3D ks->key_src;
@@ -1523,7 +1524,7 @@
                      size=
of(key_src->client=2Erandom1), key_src->server=2Erandom1,
                 =
     sizeof(key_src->server=2Erandom1), NULL, NULL, master, sizeof(master))=
)
     {
-        return false;
+        goto exit;
     }
 
     /* comput=
e key expansion */
@@ -1532,13 +1533,15 @@
                      key_src->s=
erver=2Erandom2, sizeof(key_src->server=2Erandom2), client_sid,
           =
           server_sid, (uint8_t *)key2->keys, sizeof(key2->keys)))
     {
-=
        return false;
+        goto exit;
     }
-    secure_memzero(&maste=
r, sizeof(master));
 
     key2->n =3D 2;
+    ret =3D true;
 
-    return =
true;
+exit:
+    secure_memzero(&master, sizeof(master));
+    return ret;=

 }
 
 /*

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
88?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpat=
chset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icf82=
3c286e48726934131af722fadee4a2ef7a56
Gerrit-Change-Number: 2088
Gerrit-Patc=
hSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-R=
eviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Steffan=
 Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--jyY+0vVIBGU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2088?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Steffan Karger</p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">s=
sl: wipe PRF master secret on failure paths<br><br>generate_key_expansion_o=
penvpn_prf() returned early without wiping<br>master when either openvpn_PR=
F() call failed=2E Wipe it at a single<br>exit point=2E<br><br>Change-Id: I=
cf823c286e48726934131af722fadee4a2ef7a56<br>Signed-off-by: Razvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Steffan Karger &lt;steffan@karge=
r=2Eme&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2088<b=
r>Message-Id: &lt;20261102141538=2E29830-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg40471=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 7 insertions(+), 4=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/88/2088/3</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/s=
sl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 5b7a1fa=2E=2E12b6119 100=
644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/ope=
nvpn/ssl=2Ec</span><br><span>@@ -1505,6 +1505,7 @@</span><br><span> generat=
e_key_expansion_openvpn_prf(const struct tls_session *session, struct key2 =
*key2)</span><br><span> {</span><br><span>     uint8_t master[48] =3D { 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D f=
alse;</span><br><span> </span><br><span>     const struct key_state *ks =3D=
 &amp;session-&gt;key[KS_PRIMARY];</span><br><span>     const struct key_so=
urce2 *key_src =3D ks-&gt;key_src;</span><br><span>@@ -1523,7 +1524,7 @@</s=
pan><br><span>                      sizeof(key_src-&gt;client=2Erandom1), k=
ey_src-&gt;server=2Erandom1,</span><br><span>                      sizeof(k=
ey_src-&gt;server=2Erandom1), NULL, NULL, master, sizeof(master)))</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   goto exit;</span><br><span>     }</span><br><span> </span><br><span>    =
 /* compute key expansion */</span><br><span>@@ -1532,13 +1533,15 @@</span>=
<br><span>                      key_src-&gt;server=2Erandom2, sizeof(key_sr=
c-&gt;server=2Erandom2), client_sid,</span><br><span>                      =
server_sid, (uint8_t *)key2-&gt;keys, sizeof(key2-&gt;keys)))</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        go=
to exit;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    secure_memzero(&amp;master, sizeof(master));</span><br><span>=
 </span><br><span>     key2-&gt;n =3D 2;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ret =3D true;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+exit:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    secure_memzero(&amp;master, sizeof(master));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br>=
<span> }</span><br><span> </span><br><span> /*</span><br></pre><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2088?usp=3Demai=
l">change 2088</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2088?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: Icf823c286e48726934131af722fadee4a2ef7a56 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2088 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;=
steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></=
html>
--jyY+0vVIBGU=--


--===============1425649259303314163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1425649259303314163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1425649259303314163==--

