Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C1E606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YN7eOal8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IdwAWUi6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V3BmzJG6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JtSe1vuo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Zy3NBbuQOprlpwfXCta0Try2yZhjAK1xXscBPWPOTuo=; b=YN7eOal80DaBMqjorRyzaaZtaX
	ZNUuiA6Mwdvb0TSpf/Os0n3QJkRCOLgrTsBu43ShgtVLx6XtQd1Lxv2rbjj+oSqdMzbMBGO3IQWTC
	1s9EjDihc6Dn/2B1QnZTJlmDkOLr2vd2hkhxhItcI05ryN1LejLuVyIxMjduQXOxE60g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGzB-000000006mj-1eyX;
	Tue, 03 Nov 2026 16:03:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOGz9-000000006mZ-25Yd
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:03:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QiNiST6c0vN5cx9WHY3yCk7BQkdsREOzU3T3eXoNOks=; b=IdwAWUi6n07b5rDDiShCvlPNY8
 8/pxXVR2XWOjUW7qYgs31eKcbhkCKlcP5xvQxkiR0Z/ybKPzGItENj7ZVyUkOGr3r3x8Aks2B+U02
 qI5VFIMmqwV4aR9zwD4D0edSaJe/SgyrpP/rkpv9tZM2IQUiXqDKz0I5yZk6GbZj+Gnc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QiNiST6c0vN5cx9WHY3yCk7BQkdsREOzU3T3eXoNOks=; b=V3BmzJG6kCoV3my2vH/N31Mbe3
 axQE2qNC7AawhW2JTjFnZsMXt1ukT3mQuksTx3M45uWQUBMQ7x8q4z9GmSjEqVpC9KM9c7386g/vO
 /Y8MjQTuEUCALCy3yg1CS/itfd0hIAkX/gRkAoh5UanK/pGbnK2u6hW19gYL4E+m0Ufo=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOGz8-000000000Y3-3GLz for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:03:43 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso2222368f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 08:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793721816; x=1794326616; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QiNiST6c0vN5cx9WHY3yCk7BQkdsREOzU3T3eXoNOks=;
 b=JtSe1vuolzPPZGgirbICipOBlR6JouTsIDTgAeUdyWGirIRoI5bgEUgQmeWGCED1ln
 r/u8AySrbbLpxkCvMl8aoEzjgNHzewgKTPTB4R3dBorTRyvX29dDmDFn2QbfQgz8LYNn
 +kZGHf3/5DDfeZJoO1Y8d/s0/b/tkrftFMDw/MvypwbqyjxQdlaOEnCI72VGAGl/GdkH
 Rlkjd0sdFDHFhZNMresfmx61dZ6WoH1DritkjVZY1sxRfW84kFBGF3BjbRLRmgTrg99b
 0WBGSWuGzrfHRP1zhreXxeIJ/AAM38UEVWk57yIyVx3Mc71E/ajtohQ4G647Gbbz2mbM
 bhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793721816; x=1794326616;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QiNiST6c0vN5cx9WHY3yCk7BQkdsREOzU3T3eXoNOks=;
 b=mL+GVnFdwJlNwykvIfWz0TiB7bANDwC76aMa6ru7lFOBjSsVhl1jRHCeTfKeaHGCjr
 jh06ukklLH3aIpS1LC7+asbZHyXGDnHgcyGZ1OYrdJUDBWiVKZggffat+cXIbRabB40i
 t4ahPQ4HoYPASqyZvadqXQsbJ2pvpC5d1tgL8UPUR+OSwTEhirrT1LHM72GhKjZRUO3B
 LPGFSeTAW4HSeteugn31+PjzGt5epFnXpEthAJtKkxVYrMa4AXPuWAWz8Pcf/c3tbqJ3
 O3VKsq0yEfJeGwiCxenRSAP0LpH9PKcSNtcwdvsRGL4+K4nPmQzcK03xmtu/eeFTkW4p
 KZPQ==
X-Gm-Message-State: APuU4Z/91sKoLj+99Neax7vOmcOsajuLlcSuS6H4Nj+b0QPrnFmi3lcb
 4IS4W5nYkoglotgeeW99J1fDo5ZAOj3I9+WKfO+1giTkpmyvx4AGFBCAN3rantmnQMMe9Mesyt9
 Rz+bnA8Hohl7DWrbH2WUmqwqwwqbTbvfBkpoixx0UvgVLGiuFpAT6ZB82Xm0XE4pxIeve
X-Gm-Gg: AYBFou3acqpDSlojYXj/hWgor6JCM3dQwK6zBf5dCEQzvacH0vOc0vHPrwa6phgAupz
 sF5NSr9fi1g3yRcIqSIzSkm5nk+ToojPQgo1zAIFD5I1fk13UCqwG6kXEbG3TJrUNUi/m/YF1cO
 ndDKOrZhuPs/TEDjNBvqNomYG77u9mz6LFf7Qn/yBGEU+MVtkMmR6F4sqzo6fUgLZW4n0K3bIi/
 VALnktigBKBiV4m7TaOsSXBRpiSvnjMriZTmoVEbr7nSN8XCNTLU8Fjhj0Z+/dDt5bIRCb3egrr
 XvPs02YtLG9YxcaPPtHxyfXWkxt/GH7exKVwkvGk/wMeBi91edtHJqCc9iuKLaCsZwLZlRzCHbY
 l6yAcE+63+w0pQkFcDd4pzS6SMj1Qx9tdQgouNPGls+av9g0GcJ9wJlwJ4VQmoD6S6OnOTKQ2ch
 g1MRwJykwLV5VrbKQG8TPax0KMasdxJuW9Zw3vrNhfCBbOjiRBlphm+pgmLdk5p0+d1romdTX3o
 Rip2og0sKRS8kNk+EVNi3yTx8oWmqx5dd3HjGeITwH7yscJnN7IcpU8VyTgmweAteRCOdLzBAeS
 Nqri5Ev9EMjujY/5z1D/3MNUo8GxzFJEIw2dr4Sj3P8txbp6Eu6g9lnVKCtINRL++8+uJIrJtRE
 YrcjSeRRC7EJ8w/sN8dwMxJqzBnLOfnUXJSzKZupO6X8uwJ5LntqBfYKNJ3zs6z5KEQiKY6tAuC
 aZlRIsmNUGX+01qg==
X-Received: by 2002:a5d:5f41:0:b0:48b:5e2:52c7 with SMTP id
 ffacd0b85a97d-48e6e2bc057mr31451403f8f.8.1793721815062; 
 Tue, 03 Nov 2026 08:03:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7270asm26310921f8f.11.2026.11.03.08.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:03:34 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 16:03:33 +0000
To: Hansaem Wi <hansaemw@gmail.com>, Steffan Karger <steffan@karger.me>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52
X-Gerrit-Change-Number: 2076
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2076?usp=email>
X-Gerrit-Commit: eb47f700d852cd5c740d549fbf835ed63781bf10
In-Reply-To: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
References: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzU2MDAwLkliNWViMjRiMTU2YWNiNWE5OWM2MTQwNTBmYjFiZDY0ZmU0NmQ4YjUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5ec30d2f0bcfe1ea5df9a77d690bb6e899e3ae5b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOGz8-000000000Y3-3GLz
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth_token: Wipe
 the server secret key after loading it
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, hansaemw@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6786328179887065004=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6786328179887065004==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QJZpSidPmLA="; charset=UTF-8

--QJZpSidPmLA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Hansaem Wi=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by Steffan Karger


Change subject: auth_token: Wipe the server secre=
t key after loading it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

auth_token: Wipe the server secret key after loading it

auth_to=
ken_init_secret() reads the auth-token server key into a 2048
byte buffer, =
copies it into a struct key on the stack, converts that
into a struct key_p=
arameters on the stack and frees the buffer with
free_buf(), so all three c=
opies of the key stay in memory=2E
tls_crypt_v2_init_server_key() already w=
ipes its struct key after
init_key_ctx(); do the same here for the struct k=
ey and the struct
key_parameters, and clear the buffer before freeing it=2E=


Found by scanning freed heap blocks for the key from test_auth_token=2E

=
Assisted-by: Claude Code:claude-opus-5-5
Change-Id: Ib5eb24b156acb5a99c6140=
50fb1bd64fe46d8b52
Signed-off-by: Hansaem Wi <hansaemw@gmail=2Ecom>
Acked-b=
y: Steffan Karger <steffan@karger=2Eme>
Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2076
Message-Id: <20261102090635=2E24906-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg40478=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/auth_token=2Ec
1 file changed, 3 insertions(=
+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/76/2076/3

diff --git a/src/openvpn/auth_token=2Ec b/src/openv=
pn/auth_token=2Ec
index 969f37f=2E=2E84558af 100644
--- a/src/openvpn/auth_=
token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -172,6 +172,9 @@
     key_par=
ameters_from_key(&key_params, &key);
     init_key_ctx(key_ctx, &key_params=
, &kt, false, "auth-token secret");
 
+    secure_memzero(&key, sizeof(key)=
);
+    secure_memzero(&key_params, sizeof(key_params));
+    buf_clear(&se=
rver_secret_key);
     free_buf(&server_secret_key);
 }
 

-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64=
fe46d8b52
Gerrit-Change-Number: 2076
Gerrit-PatchSet: 3
Gerrit-Owner: Hansa=
em Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit=
-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>

--QJZpSidPmLA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Hans=
aem Wi=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by Steffan Karger</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">auth_token:=
 Wipe the server secret key after loading it<br><br>auth_token_init_secret(=
) reads the auth-token server key into a 2048<br>byte buffer, copies it int=
o a struct key on the stack, converts that<br>into a struct key_parameters =
on the stack and frees the buffer with<br>free_buf(), so all three copies o=
f the key stay in memory=2E<br>tls_crypt_v2_init_server_key() already wipes=
 its struct key after<br>init_key_ctx(); do the same here for the struct ke=
y and the struct<br>key_parameters, and clear the buffer before freeing it=
=2E<br><br>Found by scanning freed heap blocks for the key from test_auth_t=
oken=2E<br><br>Assisted-by: Claude Code:claude-opus-5-5<br>Change-Id: Ib5eb=
24b156acb5a99c614050fb1bd64fe46d8b52<br>Signed-off-by: Hansaem Wi &lt;hansa=
emw@gmail=2Ecom&gt;<br>Acked-by: Steffan Karger &lt;steffan@karger=2Eme&gt;=
<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076<br>Message-=
Id: &lt;20261102090635=2E24906-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40478=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/auth_token=2Ec<br>1 file changed, 3 insertions(+), 0 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/76/2076/3</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/auth=
_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index 969f37f=2E=2E=
84558af 100644</span><br><span>--- a/src/openvpn/auth_token=2Ec</span><br><=
span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -172,6 +172,9 @@</=
span><br><span>     key_parameters_from_key(&amp;key_params, &amp;key);</sp=
an><br><span>     init_key_ctx(key_ctx, &amp;key_params, &amp;kt, false, &q=
uot;auth-token secret&quot;);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    secure_memzero(&amp;key, sizeof(key));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(&amp;=
key_params, sizeof(key_params));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    buf_clear(&amp;server_secret_key);</span><br><span>     fr=
ee_buf(&amp;server_secret_key);</span><br><span> }</span><br></pre><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3D=
email">change 2076</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2076?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2076 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ste=
ffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--QJZpSidPmLA=--


--===============6786328179887065004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6786328179887065004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6786328179887065004==--

