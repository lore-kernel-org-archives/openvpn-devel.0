Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CEE606A32C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W7PjFsaC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lq+rnYZL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Tk7eUnLD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Qg1ItKwo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NMOqMrISi0XdyDACUzdS4WHO9RYvz+lhwqH2BzXV4OI=; b=W7PjFsaCmOn0830bXYG/EhrulN
	6FV2Jh84KhXsaKh6szzCNM45S3KNKNED96GLEWtVzYv0JwXdCnntXo8SIoHrjzDkmi8UcF20+F53C
	n4PDBrQnI5hEZD0X7aOxMf7KNjCx2Rq28YBWqStv/jtGwcy0OQgrJ4GIOJ+wrkKzEa30=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTGdU-000000001R5-1Wua;
	Tue, 17 Nov 2026 10:42:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTGdS-000000001Qx-2yOY
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:41:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TnPmI6bjyNiYC9OcKw/SzkXQAG1EdXL2S3L/h/oyaGk=; b=lq+rnYZLrTBfioVcvx90JFyovM
 5V1pM+HQFaAvtYBisStp5EedrRZqcriubGj3BnNaei0+VFEUPDb5ozm4z3wr/lM5sL2ikM89BeLo0
 vLwAYEjVN1lFsZe8Z+RpFEOOrsyQbZ1jG3To3y8yJIE13c1/ItTIFTYGBEoKN0hj901Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TnPmI6bjyNiYC9OcKw/SzkXQAG1EdXL2S3L/h/oyaGk=; b=Tk7eUnLDk1SSgfaQQKeBI8QaTF
 kRbA5rUrb2MCP3spcalW6HpO95z7It6BxUBHwbfULXejs99FM+9+pXy+apN5zBEdIGoKrs61Ls5e2
 pgN/Fc863rA51YUZsbOjfB72zOr5cr1MfsDtoxOQcWl0Jvp37hpp752n7f8fZ58kYf8Y=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTGdP-000000002Ik-3DPO for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:41:58 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48e47347279so2196579f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 02:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794912109; x=1795516909; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TnPmI6bjyNiYC9OcKw/SzkXQAG1EdXL2S3L/h/oyaGk=;
 b=Qg1ItKwo1p5s+h7b0AFdch1RraUh863aX8rnT8STt1oN7jYprMfmJjicCS8AXhZyv8
 y7z9Kw6oM20bsHBwHFrP4oi/8lTj+fj9oKm4sEegcbvHtp1Pbp8LQgeozhbdxyFmqdT1
 SIQGiUD6OF//aJYDJ//p/iEY/6YRNL1kDfQOuaXZMAVxhoUg8XQMJeoHdMSfGflG/gF4
 E7ng1FYesDYrcCzKABeV2SF0vNMz571b9ptbqV8o7lVoESdetCmyPh+i2rCLupEs8GmV
 BlhbCaVlohYdroBYsU9F0qs9+KgHMaLx2aonZA+h04HbYTdoj29WbXrFaLJDXI3ttPxR
 7bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794912109; x=1795516909;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TnPmI6bjyNiYC9OcKw/SzkXQAG1EdXL2S3L/h/oyaGk=;
 b=C6udnPQ4PEZazgNnMcuT5twbGtEwN6l2s94DCfVWT8USTYdqyWbPD/ymCruJe3gCwZ
 4gupfYj4V4/jSiUN7bYRlW9hw0NpKLL5KKBjgcx4uAmENo6+VH/QEafwAsGSX+FJsjv0
 L3DyXHprmTuIx1AU3FUejn08hYmWCq1RgLzkHUIwmKAfbAxGSQ2YmeB5GXGx2MJ6ac9L
 usT/boyhvvt/nDcJtDGAZhwpX6fDFGEFKCdNWdo9gMD1SUeSswvi2ajTcEZhTpSEb3/z
 11t7Fgpmycrn7dMWi2LSU5wnGOq1eCb47BKchiKoRVZRpNOMQoyK1h6FjVgpt/y6iDq+
 BLQg==
X-Forwarded-Encrypted: i=1;
 AL+hErGWsRM15Bw0qLiyPMCx1vzsWwVlpfHFyedEWpM9rdNQFHUDaYqDN0wi829+OcdSxR/8oB5L+DCoqHSlLy10@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8W600ZYA1vLy51cxPEh1qLlKBaclRD9O7yD2E5A4rpRy2sZAlV
 TuBoZcLTwzAottU9zJY3HiKzBQQeRV31tGyoUfYd3YnxhuJFhBFlbNKNNjlriVhs9iCsYb5vUFS
 nX0hUb/ejrmk9Cz4IC6WJtVripjAc5SdHCtEwoNgw8lVPX0xe/Nosd/CVOezWzYOszMcDOEgri/
 069WCl5Q==
X-Gm-Gg: AZFdTZc8KFgHE2yPJGc436QygspYfm7Hh5Wk0ZNKdbJcYeBDhtPmkZ27wiuf0Fj8kge
 GM6JwVzPZvPJGCQEE10zEnZWAx5CEcL07rAPUVdso8FkH711TdGRQacPgROznqDMJzJg0gR1IxY
 mcCZE1to0HbjaHdbB71TG1wk99KMzkMbJyu2zz+87KnUaV90XVF1JHaXkIkx9cE600I1deZRQ8W
 Idj7M0NYVVHtQefHpwUImxLsdPSJ/3htL/uhjrVC3VpjRqfZ4mZc5KUPn0pMTetsWwzV5L4CI6z
 TDO3JjBpstm/iEFzs5BTtrEAxD4BaKPcP7iF2qBPeFZlhNJE4L8srWiiZbcfBU8XD/A4ILCuXQz
 1yjdIlMV0M+UXNg375PEjz7iJ5N+l0SE8jtHYwqq3eg+yVq/tFhUJ7g/7z8yKkFxU7nt/xPLrSk
 74U7ZgGpkCHlAFxX0Pg02wyFQ9L5GaXAp6LDcF+YsxYw8OhxVTgJc5oKtixZw/BMLSlwfAWS9Z3
 TA7+e+UvBso4x6oH4T56ZONs5WTXgJqArL2f7Q1s+TIEbWhjskUBbVnZTvZah33Lo3q6HvPR8Sj
 yKocwOdU7s70lB8ovc5IojDW79QyMmS4FPspx/nWC1bNecIohZZNDG0B3wlexeR2SlHIDnIP7pI
 87l9l4NVLR2G2WdubByOWOZAfFh4X4VyLlC4zS/IqgS878mzil+ri6+yPY41JuPvQ7H940DiEv3
 wQv5YHZBmp2Cl58L8=
X-Received: by 2002:a05:6000:4712:b0:48c:4553:790b with SMTP id
 ffacd0b85a97d-49c72f7b189mr27490031f8f.48.1794912108776; 
 Tue, 17 Nov 2026 02:41:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f782396sm27408731f8f.24.2026.11.17.02.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 02:41:48 -0800 (PST)
X-Google-Original-From: "Alejandro (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 10:41:47 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
X-Gerrit-Change-Number: 2002
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2002?usp=email>
X-Gerrit-Commit: f76f976134a1bb257fda97ccde77d6c06ce1b612
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 10:41:47 +0000
In-Reply-To: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
References: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU0MDY4MDAwLkkzNzljMzZlMTU1NzE3OGQyMmQzZWUyN2NkNmVkNTFiNWMzYTJlNzkzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2a40edc0e0b51d58b388a2b2cd36e7382d456123-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.3 (++)
X-Headers-End: 1xTGdP-000000002Ik-3DPO
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Keep the outgoing
 control packet in a buffer owned by tls_multi
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Alejandro \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: alepacheco99@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, antonio@mandelbit.com
Cc: "Alejandro \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1419078845967065011=="
X-Spam-Status: No, score=0.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,MAILING_LIST_MULTI,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1419078845967065011==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nNTUrraDp0o="; charset=UTF-8

--nNTUrraDp0o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru, Steffan Karger=2E

Alejandro has posted comments on this =
change by Alejandro=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?us=
p=3Demail )

Change subject: Keep the outgoing control packet in a buffer o=
wned by tls_multi
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2:

"R=C4=83zvan, Steffan: adding you as reviewers=2E This =
replaces the check_session_buf_not_used() and check_keystate_buf_not_used()=
 guards with one to_link buffer owned by tls_multi, so a freed session or k=
ey state can no longer leave to_link dangling=2E Patch set 2 still applies =
cleanly to current master=2E A review from either of you would be much appr=
eciated=2E Thanks!"


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2002?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
Gerrit-Change-Number: 2002
Gerr=
it-PatchSet: 2
Gerrit-Owner: Alejandro <alepacheco99@gmail=2Ecom>
Gerrit-Re=
viewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Steffan Karge=
r <steffan@karger=2Eme>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Comment-Date: Tue, 17 Nov 2026 10:41:47 +0000
Gerrit-HasCom=
ments: No
Gerrit-Has-Labels: No

--nNTUrraDp0o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
, Steffan Karger=2E </p>
<p>Alejandro has posted comments on this change by=
 Alejandro=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">&quot;R=C4=83zvan, Steffan: adding you as reviewers=2E Th=
is replaces the check_session_buf_not_used() and check_keystate_buf_not_use=
d() guards with one to_link buffer owned by tls_multi, so a freed session o=
r key state can no longer leave to_link dangling=2E Patch set 2 still appli=
es cleanly to current master=2E A review from either of you would be much a=
ppreciated=2E Thanks!&quot;</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2002?usp=3Demail">View Change</a></p><ul style=3D"list-style: =
none; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2002?usp=3Demail">change 2002</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6=
ed51b5c3a2e793 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 20=
02 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Alejandro &lt;alepacheco99@gmail=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt=
;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Kar=
ger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Steffan Karger &lt;steffan@karger=2Eme&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Tue, 17 Nov 2026 10:41:47 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels=
: No </div>

</body></html>
--nNTUrraDp0o=--


--===============1419078845967065011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1419078845967065011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1419078845967065011==--

