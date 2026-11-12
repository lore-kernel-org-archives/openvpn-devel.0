Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47526606A32E
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dc2JMPMg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Y3crjNra;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=I5BRKZMd;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Vnlnllyj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tcOJpPxxjYbY7rvuSk2YQEn01lvlRU3O3ZmMTlZOCvU=; b=dc2JMPMg6vV5WX67kj0Qr4Xsyq
	sHVWW5DmdY5Rpw3iqlkmFRtl2K8+vFnkrSEWpxqKS/GcUnYWGexdZIOpYVES99gQhY0vNCLjS6Oq+
	9DIWFmPtMFd2uAyXGMyNOM87JbGrG0SX0hjjKFLRSgWq2CicibBiuIjiQ9qHLin4ppx4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRZul-000000007WB-4Ani;
	Thu, 12 Nov 2026 18:52:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRZuk-000000007W4-47uC
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:52:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nFrOgs812LoYsUKoWg8wiYISoHgmMkf5ugaIF9ylZ/c=; b=Y3crjNraCe7gW5CdhFHIx7XHLn
 4ihMEIHnajJlOUapenuaoIEGF9cUT2CGme7Up+Tk5jsUFPVu+bansIBesdkbtRllR07yqUr2pK8Vb
 4SD8B4Xqj3Lb2WjSadgSYztk6uJUIYTwPf0TG39YXwQNCC6sRowdA6X/hxbqaqaNUdmY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nFrOgs812LoYsUKoWg8wiYISoHgmMkf5ugaIF9ylZ/c=; b=I5BRKZMdKJbBGYUuko5a88tqAc
 MF6D+vO335163OF+pMjQWTSgPnZMYuvS6eSue5WcPk+sf/oNiPWXpUKgT4W4KmKXEW2VI5Q628S+l
 btVHkmbqxjoHeXVwt+JPiFyAcyxvwrn3CgOelIEARLbqwD1NgjFWPDM/P/zHK8c94nDM=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRZuk-000000001qT-0ztj for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:52:50 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so1086775e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 10:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794509564; x=1795114364; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nFrOgs812LoYsUKoWg8wiYISoHgmMkf5ugaIF9ylZ/c=;
 b=Vnlnllyj/Z4BwcOKevY++FkgJLiviLKLmioU+2yGpGorBf8BCZXFWR1ZhgslFTnGdb
 cxCTr23gdqnOHA00FE5kir8wkxzmkfpP6BL7J1boG10BE7RrarcOs2CFltyjZKdEXgqw
 prM5yZhm/SIckBJUnkWfa5bQhVFK+sJc7MS2+fYXNZn5Ug0ka8cvMjMZykKPpLyk50BM
 X3TY7PdA2fywl4UiA3Cvyv4Ildp5/aLu+w8To4Exog4nVUizMzfCm+ByLMFrQq8L2XQK
 b1UcrR/OBinROne5hWqz/B4jJl3FsbddRH8hPVDyow5KjhqSVpZLCkSv6SOq4EwfXEnA
 earg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794509564; x=1795114364;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nFrOgs812LoYsUKoWg8wiYISoHgmMkf5ugaIF9ylZ/c=;
 b=sA1hvwra6onHsE4OhNZQTodgBcTy0/DSIp9lo8aamKgiZq91Z8mmBXycWg32IXU4yP
 B3r9otmrH/I+8sQchzxauMUUKNZa+lF3GVf9r5MpIjuwiBvyr2MREBtJCv4+wSBOMCFN
 yF7AO8lF6TBQS9tKtkiRsGX/5jIbcjEpbs7gKLz/SDY6LvrKZnoJrGTQK+248o+NDJPh
 68Nq8AUa4HMe55RnU9WA4qi2aqkd5R2NG2NMnx6uRoLqb8WBHu/9UmBNJo4fwNqqihvy
 pu9dWSOIk33bHXeyvXNQyiOwqGAYyDXRXr8qvHb6x+M7huygQOLSHkOOCq65LJGgfRnN
 14Wg==
X-Forwarded-Encrypted: i=1;
 AL+hErELjRYfDnWNzNcVZXFuyONcWYJKzU9ANWgQbY8Y67Z0phgkhA8Ycp0LUJQYH5u9rK5MlTivxPB2/ze5hg5u@lists.sourceforge.net
X-Gm-Message-State: APuU4Z++SkkpH5wGHHUnAiS6Q4w23fSu8B/COaeQF+ZqqS9eed5pryWn
 tmsTG5ozFFG+fbJN/5umGIfxSXGfWp1UVcvlLmacNRVfEmJqCdZzwuox8uR2spsgIvIwFyG/Xw5
 jtLkMQVm2u8p8GCJX+lD3aORdP0dF336oWxaLqbmq/T2a5aptZFB1GqvQCmW5dE20Sr9l
X-Gm-Gg: AYBFou2Zw3gwgeIYs9etfkanPBQIgfwTucYFZELBQOQfSyZjcDBlDg3AYbpjmss+ViN
 zqzs+bv3gX700zxSutLHAzorg9/TohD3/HAQVCm2jvI82ZlN8Sb/hpVKbgzvf79VeLPoTfAC57g
 hWW0aWRxVJA95s2MAKg7CQgGnwn42RKWF52J8Cvnzhv0x3hwjXL/jvsRQpFRpSa0YQAlxwlm2My
 z12Y9ZzZU7P7VHMiMk6Tx3ZzhfoJi9GYIzDrjGyuGKt7ufGEVpUhXKRHQL0BVStAZ282Gfklrfo
 rZW2XdcTRzaTATWsZUHJFtmNq7/lE81gciAbNgxzLsGF/L8T/f4XYhf4OMT54ZZY1zbHTFxRJoU
 w50BzzqqNMS3Fx/Z8Cel7s2vHRyuzT9HekepRETRu0ZwJIZKgkeLlBg/KoPc+XcdJyjKdNY7qrb
 /kFBnTauRgoTmdVJeX5laj3/LNOKYvdHYOoiW1qnq/d/E2EoqAEk+TIVvRu8syRRUxDht/z7KWN
 5yK9lfBrIGMdkhVozKl/oK7X+8+TJ2Nsmkg/cze/2/y0fBFKu3Dn+5nah2lTAoXxTkIu4YtupH2
 vp3g3IyCh4yWibCEcFKC3+p5NGr8GIUXD4kBLRWW+JMXTOKml4LwOcGudaOYAzoFssE6AuaoSq/
 cRqTKNZb26wCrB2KHciDTf+n1e+UGY9L7WKxDdx/2ong+HBx9NbnbctUnqzRPXlflbOz0D193WF
 U6bLOtg1l8IFClpGwY
X-Received: by 2002:a05:600c:870f:b0:4ba:495c:3798 with SMTP id
 5b1f17b1804b1-4bb55af1377mr1827595e9.35.1794509563455; 
 Thu, 12 Nov 2026 10:52:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba09536ebfsm147582145e9.5.2026.11.12.10.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:52:43 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 18:52:42 +0000
To: Ralf Lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
X-Gerrit-Change-Number: 1478
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1478?usp=email>
X-Gerrit-Commit: 95e4fd0f905fea3decfdbdd28caeee901009d250
In-Reply-To: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
References: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4ODQ4MDAzMDAwLkk3MDRjNTYwZmEyM2MwMzIzN2QwZjhhZGMzMDkwOGE2MTcyNjVhNWExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <75ded473194ef7a56cb0539459fad2f788b7e86d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRZuk-000000001qT-0ztj
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tls: reject incoming
 reneg request if primary key is not fully valid
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2399890829721440173=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2399890829721440173==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fN6mrQWQsLc="; charset=UTF-8

--fN6mrQWQsLc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1478?usp=3Demail )

Change subject: tls: reject incoming reneg =
request if primary key is not fully valid
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

tls: reject incoming reneg request if primary =
key is not fully valid

Incoming P_CONTROL_SOFT_RESET_V1 can arrive while t=
he active key is not
yet fully valid for renegotiation=2E This includes the=
 window where we are
still waiting for auth_deferred_expire (derived from h=
andshake/reneg
timing), as well as cases where deferred or mid-session auth=
 later
leaves the key non-authenticated even though state is S_GENERATED_KE=
YS=2E

This patch keeps read_control_auth as the first gate, then rejects t=
he
incoming renegotiation requests unless the primary key is KS_AUTH_TRUE
a=
nd auth_deferred_expire has passed=2E

The rejected request is not counted =
as a TLS error, since soft TLS
errors trigger an instance restart in TCP mo=
de=2E

Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Signed-off-by: =
Ralf Lici <ralf@mandelbit=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478
Messa=
ge-Id: <20261110115827=2E1649-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41068=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
ssl=2Ec
1 file changed, 15 insertions(+), 0 deletions(-)




diff --git a/s=
rc/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index cdb94ed=2E=2Ed13a0d3 100644
=
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3946,6 +3946,21 @@
=
                 goto error;
             }
 
+            /*
+            =
 * Do not allow incoming renegotiation unless our primary key is
+         =
    * fully authenticated and past the deferred-auth/transition gate=2E
+  =
           */
+            time_t auth_deferred_left =3D ks->auth_deferred_=
expire - now;
+            if (ks->authenticated !=3D KS_AUTH_TRUE || auth_=
deferred_left > 0)
+            {
+                msg(D_TLS_ERRORS,
+     =
               "TLS: refusing premature incoming renegotiation request for =
key-id %d: "
+                    "auth=3D%s, auth_deferred_expire in %d se=
conds",
+                    ks->key_id, ks_auth_name(ks->authenticated),
+=
                    auth_deferred_left > 0 ? (int)auth_deferred_left : 0);
=
+                goto done;
+            }
+
             key_state_soft_re=
set(session, NULL);
 
             dmsg(D_TLS_DEBUG, "TLS: received P_CONTR=
OL_SOFT_RESET_V1 s=3D%d sid=3D%s", i,

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1478?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Gerrit-Change-N=
umber: 1478
Gerrit-PatchSet: 7
Gerrit-Owner: Ralf Lici <ralf@mandelbit=2Eco=
m>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: An=
tonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>

--fN6mrQWQsLc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1478?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">tls: reject incoming reneg request=
 if primary key is not fully valid<br><br>Incoming P_CONTROL_SOFT_RESET_V1 =
can arrive while the active key is not<br>yet fully valid for renegotiation=
=2E This includes the window where we are<br>still waiting for auth_deferre=
d_expire (derived from handshake/reneg<br>timing), as well as cases where d=
eferred or mid-session auth later<br>leaves the key non-authenticated even =
though state is S_GENERATED_KEYS=2E<br><br>This patch keeps read_control_au=
th as the first gate, then rejects the<br>incoming renegotiation requests u=
nless the primary key is KS_AUTH_TRUE<br>and auth_deferred_expire has passe=
d=2E<br><br>The rejected request is not counted as a TLS error, since soft =
TLS<br>errors trigger an instance restart in TCP mode=2E<br><br>Change-Id: =
I704c560fa23c03237d0f8adc30908a617265a5a1<br>Signed-off-by: Ralf Lici &lt;r=
alf@mandelbit=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478<b=
r>Message-Id: &lt;20261110115827=2E1649-1-gert@greenie=2Emuc=2Ede&gt;<br>UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg41068=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 15 insertions(+), 0=
 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openv=
pn/ssl=2Ec</span><br><span>index cdb94ed=2E=2Ed13a0d3 100644</span><br><spa=
n>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span=
><br><span>@@ -3946,6 +3946,21 @@</span><br><span>                 goto err=
or;</span><br><span>             }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /*</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             * Do not allow incoming renegotia=
tion unless our primary key is</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+             * fully authenticated and past the deferred-auth/tr=
ansition gate=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     time_t auth_deferred_left =3D ks-&gt;auth_deferred_expire - now;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (ks-&gt;au=
thenticated !=3D KS_AUTH_TRUE || auth_deferred_left &gt; 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(D_TLS_ERRORS,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;T=
LS: refusing premature incoming renegotiation request for key-id %d: &quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 &quot;auth=3D%s, auth_deferred_expire in %d seconds&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    ks-&gt;key_id, =
ks_auth_name(ks-&gt;authenticated),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    auth_deferred_left &gt; 0 ? (int)auth_d=
eferred_left : 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               goto done;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span>             key_state_soft_reset(session, NULL);</span><b=
r><span> </span><br><span>             dmsg(D_TLS_DEBUG, &quot;TLS: receive=
d P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s&quot;, i,</span><br></pre><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=
=3Demail">change 1478</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1478?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1478 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: Antonio Quartulli &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--fN6mrQWQsLc=--


--===============2399890829721440173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2399890829721440173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2399890829721440173==--

