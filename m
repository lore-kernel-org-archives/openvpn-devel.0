Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2E606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l5JpFXAL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ty8boYEa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cQ4v9aBu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EZqj/ueH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vzhE6Mnnh7ICcIueeB86NaI0qN2r4e7ByCYn5rXCCfM=; b=l5JpFXALRRd9w7N7RV2+H1Anuo
	RhYgKjw8u4hlNHjtJi1DKtj6rKoitwUTJuMDIYCXjt95YyJYqWplAAVaUuy8Xijnlw97YIZanYyGP
	sVg4UbE1wK3qeB0lOQlFyuqJa4CHoKERsrzUUx+McRKfoV9eqBxEkLC2wU6NCpY+mPKA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR9ix-000000006Rn-1JlM;
	Wed, 11 Nov 2026 14:54:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR9iV-000000006Qc-3Krz
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 14:54:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4uQYvrXxEnXDxve0a9TliRq9UptxpB1/1DB8b+3ycuk=; b=Ty8boYEa9pOfjKUjcI655+ZApT
 lagoRYw3G3C111mmm9JUbjlDJuHTiVZI2/TmDAfAEFmD7m0IKOLW0nv5g4uAyzfPUJAWf7hZUf8QW
 ipu82Eoj6Rx6r3nsCTnV9IpBLvpqgr7G05igIgkF6uxJTsQyior6D+R9oSOiCM11hJZc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4uQYvrXxEnXDxve0a9TliRq9UptxpB1/1DB8b+3ycuk=; b=cQ4v9aBu3D8ZIaZGvH9ZqP3a3v
 iW67snnDpdUimgnNDUnruMoic419WqciLonb5t0Qd8nG5R2flwvWxvss+b8eVesB5IfSTvH58TFSd
 S+TVTNMWRWP+oBfnz3jjIQ/dWy6m1OyMc/Q/940EOZEFlzYvWT/xfk307Z7mbScAkHEI=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR9iI-000000002Wx-14Wo for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 14:54:15 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so24162245e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 06:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794408848; x=1795013648; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4uQYvrXxEnXDxve0a9TliRq9UptxpB1/1DB8b+3ycuk=;
 b=EZqj/ueHIVi9LQVOUAym2c1lP1pS+juDa+e6qgoXZFTCbNgtbF5xZQGLMGRafQJnKG
 WgOnuTrICz2Y7emrWj18z/2Bsn3IntMF2a1Drw0kNef5PVyahTdP6HCxMdyfixLbgFTa
 HqTNBrSkLXs4HDtCoDdNo88NlxWEvkAnkvBVZ8NYaGyUIJTk3ZjgfoVrXG06lRvG8zg3
 lPZ6YsRMinhle+SVGcwL1VAFPPbYvh7UtF+gEZS1ZordYpdheKURpPBp62PW3+ar2UyF
 AwkLrz5csqRIAbfJKXgEK2l1Rbz2icK6p5Eb/hBXmiU3sEhxObAh+hGXulbyklV8r66J
 BJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794408848; x=1795013648;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4uQYvrXxEnXDxve0a9TliRq9UptxpB1/1DB8b+3ycuk=;
 b=Pp1l7OIX9cgx261SyezKV44psVstzrUASrvxGr956iJeV3Y7DOL5afZ5rcOChSfRbc
 Vojpmb29aeVKMnSUGtnwps9gEGFzzJHIIvZmIgVl0oKTWTssSrlzvFGoV5sz8fDPOTe/
 AIzrPQiHcgKq77lB/CnQouDMOQlCyNvA27yTDkvdHEE1/rG8eVE4QMYCWO+MPyUdYBBy
 3NpHGI5VuNVy8kqRbJr9WF6vxUY91EKq4ESLXaTv2Z/h3maGJkEIIlaxngW1PY2dsiIW
 sKkBcp8ZfYWEuyqzPxXKPcF68fcx2sA3MbD9fnb0iqqohin32ZuC7GHJFSyBhX0kfSJE
 16qw==
X-Forwarded-Encrypted: i=1;
 AL+hErHkB4fW+wXQGf+kKM+6xA4R+IFfExLGzKnDAfu9QAnXPbYeWWPGiT2moH0KikJMPN+m+pZBImEOHP++8NGl@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+M12irsKnUo3AkLWCpC3OX9JUUiOrT/Gj+ZeqKNU9ZuVvC+mJo
 RN/EvefF628o9b0L0lr9rMHM7R3iu37P/HVJomavwYtGi4SiAx7F+W4F9hqWNukcX1c9WfrVx5t
 kCWd0tsXOXopnZNbJHN1p7pEIqoYD1Ud/MCMvKze+vwBxdvZHqEUKxbGw9rm7IKrXee78OLvISV
 zNhYcwcQ==
X-Gm-Gg: AYBFou1RukbNT2E0Nnf12ZF/iiVaBBafuPBRR3JzoN0xtuanf0g8jtKctwTwuP1RKjm
 Y+PT/5JZIjx8g9tc6gitdm//uCnS8uO2f/16dI1q28Dbn/lpqHz8ly6WqAB7CsNrYfME8s7072C
 FEd1/GXfpisJCHQ7pf9gIjQ+WwM04cdLvJAeNynTrvrU14VpF8DcnuGRCtkqiyRQzk7ep4jPcE5
 tX7UvvebFG6ewOTWK+An/Q2st1+Ix8hrJimy4E6XjeLgrnOH5AslKI0xdJUHcg0GoRuRPBFBucA
 ToXP1/yOxX+v9QD6zvJ/QVeNHBM4C4ScGvo/1JqYM4J7va6me8uvk3eW8auXXCxIlnFpQ1sKl8V
 maGkUoCwQgNQy73kZ04c6gmG/WLM++BVgRHHmrxdIRuNe527TYUMW65/1GFKAycMAYnU0V2oitK
 uS88N9KXRIQ9CCkUhtM7ncEC6Z2N8uvmBUbXew9sTYazXVw11yKY2jmTHscJyK046fBNW8Psl8B
 gcSHKejNJPG3s7YJaX5C61RRyNxUDqOuhwAKSqhaLmbSPAt+4XYb3ixvEEzRUWxAIejv+auWoCL
 /3i6IPfdgYfC45IB9wCH2rnJN0Zn6r+s+opdyJX2WouA9uHPvAXdMzTWDwBYeTnwMoVRyNzzms9
 j8/t1fMvQ0d5yYxfsDa+/j2jCJ1l/8W+gj1K/njqGABfrDTRQPCkhIIsadwdAsLkB1EF9b+8CvK
 JXRVTQpE/3IBJmV6s=
X-Received: by 2002:a05:600c:1d1c:b0:4a1:efba:511 with SMTP id
 5b1f17b1804b1-4ba0938bff5mr46341355e9.35.1794408847254; 
 Wed, 11 Nov 2026 06:54:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08ddbe68sm108298915e9.0.2026.11.11.06.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:54:06 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 14:54:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iea151988f2fa120b1262051572604e3f42ef4b1c
X-Gerrit-Change-Number: 2040
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2040?usp=email>
X-Gerrit-Commit: b88f198569da0953b6e64fcc5886f04d35802f9d
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 14:54:05 +0000
In-Reply-To: <gerrit.1793051829000.Iea151988f2fa120b1262051572604e3f42ef4b1c@gerrit.openvpn.net>
References: <gerrit.1793051829000.Iea151988f2fa120b1262051572604e3f42ef4b1c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDUxODI5MDAwLkllYTE1MTk4OGYyZmExMjBiMTI2MjA1MTU3MjYwNGUzZjQyZWY0YjFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bc0d1624368413ae6a28c47107709b606f509d86-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xR9iI-000000002Wx-14Wo
Subject: [Openvpn-devel] [S] Change in openvpn[master]: p2p: don't report
 WAIT/AUTH for a new session while connected
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0134450522225426281=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0134450522225426281==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kbFZlMoI6yE="; charset=UTF-8

--kbFZlMoI6yE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Antonio Quartulli ha=
s posted comments on this change by Antonio Quartulli=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=3Demail )

Change subject: p2p: don't=
 report WAIT/AUTH for a new session while connected
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(3 comments)

File =
doc/management-notes=2Etxt:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/204=
0/comment/65c1d70c_582b3c2f?usp=3Demail :
PS3, Line 430: WAIT          -- (=
Client and point-to-point only) Waiting for
> Client and point-to-point is =
the same=2E [=E2=80=A6]
Acknowledged


File src/openvpn/ssl=2Ec:

https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2040/comment/78ab8451_c7945c24?usp=3Demai=
l :
PS3, Line 2527: tls_multi_established(const struct tls_multi *multi)
> =
If we introduce a new method to check this condition but only use in the ne=
w places but not in the o [=E2=80=A6]
this will go away if we change approa=
ch as per the next comment=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2040/comment/b44687f6_d6b10e80?usp=3Demail :
PS3, Line 2903:             ma=
nagement_set_state(management, OPENVPN_STATE_WAIT, NULL, NULL, NULL, NULL, =
NULL);
> While I can see that this will work I don't think it is is the cor=
rect fix=2E [=E2=80=A6]
fair point=2E=2E=2E
would you prefer if the session=
 code kept reporting WAIT/AUTH as it does today, and instead tls_multi_proc=
ess() re-announced CONNECTED when a TM_INITIAL session fails while TM_ACTIV=
E is still established (the S_ERROR branch that calls reset_session() witho=
ut flagging a hard error)?
This way we keep the per-session reporting untou=
ched and moves the decision to the multi layer=2E
Would that work?



-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iea151988f2fa120b12620515=
72604e3f42ef4b1c
Gerrit-Change-Number: 2040
Gerrit-PatchSet: 3
Gerrit-Owner=
: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Wed, 11 Nov 2026 14:54:05 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>

--kbFZlMoI6yE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli has posted =
comments on this change by Antonio Quartulli=2E</p><p><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=3Demail">View Change</a></p><p>3 =
comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>File doc/management-notes=2Etxt:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2040/comment/65c1d70c_582b3c2f?usp=3Demail">Patch Set #3, Line 43=
0:</a> <code style=3D"font-family:monospace,monospace">WAIT          -- (Cl=
ient and point-to-point only) Waiting for</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Client and =
point-to-point is the same=2E [=E2=80=A6]</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p>=
</li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2040/comment/78ab8451_c7945c24?usp=3Dem=
ail">Patch Set #3, Line 2527:</a> <code style=3D"font-family:monospace,mono=
space">tls_multi_established(const struct tls_multi *multi)</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">If we introduce a new method to check this condition but only use in=
 the new places but not in the o [=E2=80=A6]</blockquote></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">this will go =
away if we change approach as per the next comment=2E</p></li><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2040/comment/b44687f6_d6b10e=
80?usp=3Demail">Patch Set #3, Line 2903:</a> <code style=3D"font-family:mon=
ospace,monospace">            management_set_state(management, OPENVPN_STAT=
E_WAIT, NULL, NULL, NULL, NULL, NULL);</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">While I can se=
e that this will work I don&#39;t think it is is the correct fix=2E [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">fair point=2E=2E=2E<br>would you prefer if the sessio=
n code kept reporting WAIT/AUTH as it does today, and instead tls_multi_pro=
cess() re-announced CONNECTED when a TM_INITIAL session fails while TM_ACTI=
VE is still established (the S_ERROR branch that calls reset_session() with=
out flagging a hard error)?<br>This way we keep the per-session reporting u=
ntouched and moves the decision to the multi layer=2E<br>Would that work?</=
p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2040?usp=3Demail">change 2040</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: Iea151988f2fa120b126205157260=
4e3f42ef4b1c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2040=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbit=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Wed, 11 Nov 2026 14:54:05 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: N=
o </div>
<div style=3D"display:none"> Comment-In-Reply-To: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--kbFZlMoI6yE=--


--===============0134450522225426281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0134450522225426281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0134450522225426281==--

