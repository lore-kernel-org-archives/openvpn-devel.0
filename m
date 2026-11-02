Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E67606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JLPsivZy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WWHZ/iYY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RrC1vAqn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RLS4FZ24
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=rot4YnvPa90Pm/y8xe+i1lO47C8gMkg8PpDERC3rqdQ=; b=JLPsivZyrQWwQ1nbLiyMg18LCQ
	3N2xek0DkS9LKmCuhYRlu2yklpB9p6d9qd1xzwGCzetz4mLvetqdOlh6HrAHLZnu7Ymrp6ffCvmzJ
	2ugY2VT+/3cK5lp5bCEgy94X8hrYJuAj5/EdTydvNY7RTzGmv7e1SngdX8rsQY/p7gIk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrEA-000000008OD-2ph8;
	Mon, 02 Nov 2026 12:33:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNrDu-000000008Mu-4ASH
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:33:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j6U3moof88WPelr4y3uv7ZG8ELiKK0YY+lxjRA3nWXs=; b=WWHZ/iYYz3wX/RcNxBRAf16Men
 OkDsdjHmC2sVfPtobYL/qdeASqX8tw5GNa1QTlm5Nxju0pdWev7NC5/vZuuruFroLTJAF4zJjVoeB
 hhNwgqqhKsHs3Udm0VckZoeRUIgv8NxGT7vb0EcJ6y9H13o6gg8jDZSXzU+Cq8ygK5Lk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j6U3moof88WPelr4y3uv7ZG8ELiKK0YY+lxjRA3nWXs=; b=RrC1vAqno2OQPtG4NhV3NAF1XI
 DWDyJ2L1NUA8Jxo+l6OQI8ezIrleQLja0bIZMDdeQ+kaxqkyg8t8ljfRoyfmmIwV9+EoMxuss+1Hs
 VyI/nkynh+MaGzui+5B/+Uy58/wmwR5rKYCQCzl2csIauVHJDfw2p6FoyBm9/0G2ilkY=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNrDr-0000000070i-3fSX for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:33:13 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so3107110f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 04:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793622785; x=1794227585; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j6U3moof88WPelr4y3uv7ZG8ELiKK0YY+lxjRA3nWXs=;
 b=RLS4FZ241wJjPGmu8P5/7PAX+5Lyjs9jLOire4Kf0GsLlzjJ0FCJipq99IPIadfZdL
 33Mt35rNEoXEAvjuhFmZD/hLUzktm8E5fJ/0B2jEvKmdvUcBSdhS+3RY/DZDZlujZs7C
 HxGW0VptLksgjxVeDkILmI96/VrnPMabP/Ygra/9SZiuUJ5h0Q18GRdfDoMBmnX27YCZ
 GzZBHWcy6wiSP1H3TVXbsz19J4xk5JbuxvEU2+OzNpU3Ad9YNhAnJff/8YgrXSRvBMXO
 iCFmX6nyhIrqIU86cUAZ1vQLFpIUkszxa03rSBxuMlJ0Vb90sgZuA1voKSkfGwxV+Oi+
 7lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793622785; x=1794227585;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j6U3moof88WPelr4y3uv7ZG8ELiKK0YY+lxjRA3nWXs=;
 b=Ds6gAdd8DF1vYSTGxj4nJy6VLw2M5727Ws6aOUaqBP//GiQ0Y24NjdliC3JjTlR2F2
 0tHJ8GqJFzjr9J+3B7d1SZgD/WeJ/GPbBoiW37jhAOrkHk6gL4Qyv762II8qrlwcp1Z4
 +B3esoLxlwZ+M+LYACdhDv8Rzvr/kVzQzuKVRrr5Edhnf/6+FxI55AwquIch6M3WlWTP
 q5oN7EOeS5ECUkJw5fZ6BUJGdcI8b7/qlp8yXVstyzsPRUeU2xXR+Fih87EmKgRboYQ0
 I152iAecN0ftSFsotJWls8uJekUsZjwG4ztcbiPNO20jfCUhWaHPB8k9/tzeZnIqr5LT
 xzQw==
X-Gm-Message-State: APuU4Z/mKhb+kFx6Y17VKUQxy6uaE9GOZcsbRgAAAIE/YDw0E/l0fbQl
 Zs6Jy63JsfWjDxK+Q6lvXYoY82Uudiagy6EGJtgWBkQ7c2X2U109H/1YcRBynM4YfDulqPAC9+Q
 kZiSPDs44AJfT30Fs0NstFHl9y5RKl1KfSfZBbcet2YfIQXL2HrLyFLweXrD7NGQVzfLvYSqoF5
 1Mz/MWaA==
X-Gm-Gg: AYBFou0SDYCwBe6Z/zDKojIpjnTILTx5PJFodAzASLdUpdYg+VvkNYEptx3eGp0vv6i
 16qZjNHd1XxPRmjdiPw6nI5QAU6D3R4S7w7j+qliGOaLioNCUs6rVa5cKkVfiLQshZjx5xCxAiV
 9BRmd4lwPOoQNe1u7ROoiPqtHUX0uR5tLd3At1g4ZxplGHWi2nmZI1leL7bhhmcxqvhJ7cGhuNu
 xzQjY4lHRcWhv8pgpq+/Yo7dLeHAicWGlrlK48rHMVL8N7Y0ZoRnsAowiRMie95ivB9CqveQB+z
 IS8LlBXJ1gs+/se1N3CiEDpWrzKqr9WltMMSbYxkxXy8nrFGOpocT9TTlXpgNuWasEeXeS0Q2Kq
 N7VZKFAyNg3oUcVK0M6w7ItGK6CJUly8McIoxs2zcdQ0r7jEu+Wbe1rtcGxSHSc+kQYW5NpIPjA
 O6hQnPitFEWuW4ElKITkN1zKMZBWoPM3w1WefejO9g+kNWKyRvOd40gXzI3e392A4v5R/BxlFdL
 xWybxMVz31kqdE7aoPqZ49m/bgAs2MWxfcI2SoENqwOvdZ0ABAmLGhEof5tpHHNzHa5DIsSp0RF
 eXLJ11SYDIlxZGIuLMI0h+uCtIRIHU3rBhTMrbx2zCU3CQkjGSjEUUjoGlLDZe2IsIP3cxXIa4P
 F74xpb9LO6qjAFKjUFzF6JZSKnbOCF4zI90onfTU3ZqWpmrAXdJnOC3M4RQ1TzdB33A3PFwcBMH
 f5I/gMXUQj0icJ6Q==
X-Received: by 2002:a05:6000:46c3:b0:48e:f47:273c with SMTP id
 ffacd0b85a97d-48e6e2bcd97mr15051341f8f.8.1793622785174; 
 Mon, 02 Nov 2026 04:33:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a4csm19619521f8f.23.2026.11.02.04.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:33:04 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 12:33:04 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icf823c286e48726934131af722fadee4a2ef7a56
X-Gerrit-Change-Number: 2088
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2088?usp=email>
X-Gerrit-Commit: d21f51156eb2bcb068cd487e7d2120ec91405754
References: <gerrit.1793622782000.Icf823c286e48726934131af722fadee4a2ef7a56@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjIyNzgyMDAwLkljZjgyM2MyODZlNDg3MjY5MzQxMzFhZjcyMmZhZGVlNGEyZWY3YTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cf39cfd02c9ba656bd961df08029607052055603-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNrDr-0000000070i-3fSX
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5562017156327598228=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5562017156327598228==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x5qloKrgWD4="; charset=UTF-8

--x5qloKrgWD4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2088?usp=3Demail

to review the following change=2E
=


Change subject: ssl: wipe PRF master secret on failure paths
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl: wipe PRF master secr=
et on failure paths

generate_key_expansion_openvpn_prf() returned early wi=
thout wiping
master when either openvpn_PRF() call failed=2E Wipe it at a s=
ingle
exit point=2E

Change-Id: Icf823c286e48726934131af722fadee4a2ef7a56
S=
igned-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/ssl=
=2Ec
1 file changed, 7 insertions(+), 4 deletions(-)



  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/88/2088/1

diff --git a/src=
/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 086a6fc=2E=2E03180c6 100644
--=
- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1503,6 +1503,7 @@
 ge=
nerate_key_expansion_openvpn_prf(const struct tls_session *session, struct =
key2 *key2)
 {
     uint8_t master[48] =3D { 0 };
+    bool ret =3D false;
=
 
     const struct key_state *ks =3D &session->key[KS_PRIMARY];
     const=
 struct key_source2 *key_src =3D ks->key_src;
@@ -1521,7 +1522,7 @@
       =
               sizeof(key_src->client=2Erandom1), key_src->server=2Erandom1=
,
                      sizeof(key_src->server=2Erandom1), NULL, NULL, mast=
er, sizeof(master)))
     {
-        return false;
+        goto exit;
    =
 }
 
     /* compute key expansion */
@@ -1530,13 +1531,15 @@
             =
         key_src->server=2Erandom2, sizeof(key_src->server=2Erandom2), clie=
nt_sid,
                      server_sid, (uint8_t *)key2->keys, sizeof(key=
2->keys)))
     {
-        return false;
+        goto exit;
     }
-    se=
cure_memzero(&master, sizeof(master));
 
     key2->n =3D 2;
+    ret =3D t=
rue;
 
-    return true;
+exit:
+    secure_memzero(&master, sizeof(master)=
);
+    return ret;
 }
 
 /*

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2088?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: Icf823c286e48726934131af722fadee4a2ef7a56
Gerrit-Change-Numbe=
r: 2088
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--x5qloKrgWD4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2088?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl: wipe PRF master secret on failure paths<br><br>gen=
erate_key_expansion_openvpn_prf() returned early without wiping<br>master w=
hen either openvpn_PRF() call failed=2E Wipe it at a single<br>exit point=
=2E<br><br>Change-Id: Icf823c286e48726934131af722fadee4a2ef7a56<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvp=
n/ssl=2Ec<br>1 file changed, 7 insertions(+), 4 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/88/2088/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec=
</span><br><span>index 086a6fc=2E=2E03180c6 100644</span><br><span>--- a/sr=
c/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span=
>@@ -1503,6 +1503,7 @@</span><br><span> generate_key_expansion_openvpn_prf(=
const struct tls_session *session, struct key2 *key2)</span><br><span> {</s=
pan><br><span>     uint8_t master[48] =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span> </spa=
n><br><span>     const struct key_state *ks =3D &amp;session-&gt;key[KS_PRI=
MARY];</span><br><span>     const struct key_source2 *key_src =3D ks-&gt;ke=
y_src;</span><br><span>@@ -1521,7 +1522,7 @@</span><br><span>              =
        sizeof(key_src-&gt;client=2Erandom1), key_src-&gt;server=2Erandom1,=
</span><br><span>                      sizeof(key_src-&gt;server=2Erandom1)=
, NULL, NULL, master, sizeof(master)))</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span><br><spa=
n>     }</span><br><span> </span><br><span>     /* compute key expansion */=
</span><br><span>@@ -1530,13 +1531,15 @@</span><br><span>                  =
    key_src-&gt;server=2Erandom2, sizeof(key_src-&gt;server=2Erandom2), cli=
ent_sid,</span><br><span>                      server_sid, (uint8_t *)key2-=
&gt;keys, sizeof(key2-&gt;keys)))</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span><br><span>   =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    secure_memzero=
(&amp;master, sizeof(master));</span><br><span> </span><br><span>     key2-=
&gt;n =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
 =3D true;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+exit:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure=
_memzero(&amp;master, sizeof(master));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return ret;</span><br><span> }</span><br><span> </sp=
an><br><span> /*</span><br></pre><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2088?usp=3Demail">change 2088</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2088?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icf823c286e4872=
6934131af722fadee4a2ef7a56 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 2088 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--x5qloKrgWD4=--


--===============5562017156327598228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5562017156327598228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5562017156327598228==--

