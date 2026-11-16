Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A63606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BEK0ekmC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B05xen/E;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NMq3Zrwf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UF5fMsJK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4/iauL0JO46QSKXPlW1xv1SE5C5LFzyIdKj1BGsxjUU=; b=BEK0ekmCfhl90RWQ59AEIFyk3H
	J8SpGd18GB88zdqiuZjhLFcAJa2Le7c/Y4MR1jprFjM7tocalgpvnVRAAQK14wG736ldJa9DXuB4t
	98RiQe0QMyLIAvTIreueRv8/WpQkAm3u12ghfFrKceReSCpxvLGcidFaPnWwetTO5/UA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSyGr-000000005pO-1Tvh;
	Mon, 16 Nov 2026 15:05:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSyGq-000000005pH-38P3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:05:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TDSvKOX89pgP+xX2B7hcOyUH3td3gwadX5c2wle9Iag=; b=B05xen/EhNW1ICWd5CBmCd50T3
 J/7dlUGvbKU0S3vRfHs5kdm7agz9vfg8KPYZCPZYobYYuvoALP7vaEW00OrQmwWcZjG4VJchfJpOo
 waIdxF+TXUxPe0uZgRjBFYYwiXsmqXY6OTJLe2mFkbv6vhymP7UZiJ7CMMLv6uvK8mfE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TDSvKOX89pgP+xX2B7hcOyUH3td3gwadX5c2wle9Iag=; b=NMq3Zrwf/X7jRTYZSC3olTBGYB
 wsSYElziGzMwIGxtr6Qv+wfmk2CVx7ImGWbIUrxMK3wFjnh70ixJGCG/NSLiSHe1PKRjN6kmQSDFL
 aZeyND89H/UuLQEdN2ttT50QBBXAJc+5WLSN0/GRubP2ZyGnne/FS+eo8v4cORVx39VM=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSyGo-000000006uk-2tns for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:05:24 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso13186525e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 07:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794841516; x=1795446316; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TDSvKOX89pgP+xX2B7hcOyUH3td3gwadX5c2wle9Iag=;
 b=UF5fMsJKV+BT25VX7RRJuWepejQ6yAe8NsDHvAJbOI6WESZzqYsQOS+OCObyaOPjmX
 CSp9puPbmnF2+RvNmzeTVHrCOA8ifGW8a+vM3MBZ++dFhvG7QxA49d/wI5QVpNU6TOKS
 keBwvJCTgRelk7NmNeCKOO/zq4OxRmvtygezrus49B/lqlGXah/sHAJ28EsISkXV/cyn
 WENgT1VN8EHpv/gBzLcLkCtQTe3ljkpKblRkdLFN+PwTX4MMSZb1eFVX26xKaKFqxHYh
 LYEBe10O2d1X85CEdv5rX6nMnvcmNwfmyK2vdAnouxO0+w5vmA8FUKzLUF29KSpbiWs8
 xMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841516; x=1795446316;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TDSvKOX89pgP+xX2B7hcOyUH3td3gwadX5c2wle9Iag=;
 b=SnpOULppD0fNwtf6Vj08Y2Bvj4fittTMUcuJTUGZkjjysXjmwJZBPwqbhy1QBA2k6/
 SMNrWHiDg2mTe/9iY+q1KBR1tolMxqRdYxQQEZAe4+9VxKAT24FbJO6UAmJ9ma03Jxmq
 A6C0m6SVZLFnS08uf7g+oDfNyux1ssCsJiB2gCOBeamV0TOqwXVbLxFQouDBFtuDaAoY
 qkkKBBVBlnpr6QeRIu1PlhPDH9xYsLML4MxdGGPDjtYbnAebEX7wLEyr/5lPnznugN2s
 eHaaJupA5QiRcYDhdAeKHpokUD3GTI1HQDWTBX8nWq8iSbJeVdw25CxPPZZvpp1yZUeI
 pyiw==
X-Forwarded-Encrypted: i=1;
 AL+hErFvzdQ/BJvy8pm6zYJw0sbqxJepV44aoOWZ4h/gyecv60oIhjzkU6zJCJ9QeKrh77GVSstrRBK8G3Ueq/H9@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9Hx6asKWQkfKVgh+lgJOOY8tvMdO6sejDiOKWGv9sIa2P4qPjy
 aM+3TYCJcZ7A2L1+WTVMEvAdJfQ7h+NHDxuSTYv8AdnLZI/3c8nh+DA7XNOogR0YhVnKYYoiMcB
 FfdvrZHwHXGlwi72/0rfVx9dOQ/mh4IMPd+TvGhYHL5Lf34+LrfU5AUCmpVYPer+7QBX7
X-Gm-Gg: AYBFou1v6XJ4Pv2OvIn2d0NRcrAkzrGngr+yborw16ZUzB/cPpaQwbfL37rX/MAh5Zr
 s8Ssj0fjkMqnXnFvcNkEieTR2us/jcPrlSzK7Y9uLG9jlOnjarhkgc6de85rvhxfz8PYB8L4yY/
 00i47Rx7iAcaTS4h32L5n/Dtx2yncC9vWzvaXFjgSGYXRvlJD3SUewzA2/ZlMOtBpSZp9oESoyi
 IWIf/Nw54j4hDpx8Pswntiffdm7ADh6OFfz0NhRHxxssQlHxlKFjLIXuO+mpTh0uuj71TOaIN91
 0KLI3Zj/WqN/8swC9N81YT2lIYWHBxPTWGf1GUyqcZ8mpsQD6hkYX5oDTa9yRPj+Z2wEnhTK/Ax
 aR0gbKX9Mcel2pw6A31zy6itGNYhX8CupW9IduDrhd+myPNkoaMhiWuMFiAvwkrE64xcVOKsuYg
 pl9cjve1paMT6IfP5gEjFXaAgPKRU//FmaImfrkfH+02zbw4EULlxLVVDzxD6aZAsvpe/3OWurN
 PCdp/4Y3961KP6kbjtuXWMd0A1KtL3Uzk+G+DZCTEF3PmGHzYMgMrT1cMHtzx7PpASTjLgPd58m
 4ZfrovhcYWHeJXPllxSk3SQ7RIrA6Biz0ZmO6rNXZ2QgKIRIp5H4Os6ELnSUQZ1G1Ec8I2gn2sr
 bsyzi02wVaYcvZALdgIana2zxL5eMzGIw6UTkgCU8FuVTT5HMJxvEtYuPb0RwK/85ZZvkhgHtRO
 e4GyqCqHYHEmkBZzrZ2vG4HSLVFlZOLEk/jwiM
X-Received: by 2002:a05:600c:3b16:b0:4a2:1960:6fa with SMTP id
 5b1f17b1804b1-4bb55a6116bmr236742185e9.4.1794841515865; 
 Mon, 16 Nov 2026 07:05:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55acdfebsm272013665e9.7.2026.11.16.07.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:05:15 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 15:05:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 3a1321674127756e760c096a18b7d8e0cc463112
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 15:05:12 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <57dce614c914d001e7d04b6b4981c5d49bb43afa-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xSyGo-000000006uk-2tns
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add
 P_CONTROL_V2 and the probe request and reply TLVs
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3059183962306587309=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3059183962306587309==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GLYQXS1DePM="; charset=UTF-8

--GLYQXS1DePM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Ralf=
 Lici=2E

Lev Stipakov has posted comments on this change by Lev Stipakov=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail )

Change=
 subject: control_msg: Add P_CONTROL_V2 and the probe request and reply TLV=
s
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 26:

(2 comments)

File src/openvpn/probe=2Eh:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741/comment/e0ed0659_14c6a5f8?usp=3Demail :
PS23, Line =
53:  * connect_lifetime and flags (u16 each) */
> WIthout having the size o=
f priority, weight and max_leatency here in the header, the 5 is basically =
 [=E2=80=A6]
Moved both length macros below the structs, so the five u16 fi=
elds are now the
lines right above PROBE_REPLY_LEN=2E

Spelling the sum out=
 per field needs an ugly one-liner, since clang-format joins
multi-line def=
ines=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/7b497dd6_=
fe070c48?usp=3Demail :
PS23, Line 69: /* the other addresses of this remote=
 are distinct servers, so probe them too */
> Maybe use doxygen style here?=

Done=2E Left "/* probe reply flags */" plain, since as /** doxygen would a=
ttach it
to RESEND_WKC, which has its own comment=2E



-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be3694373882=
68
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 26
Gerrit-Owner: Lev Stipako=
v <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: chugly <charlie=2E=
vigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Atte=
ntion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 16 Nov 2026 1=
5:05:12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Repl=
y-To: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--GLYQXS1DePM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Ralf Lici=2E </p>
<p=
>Lev Stipakov has posted comments on this change by Lev Stipakov=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View=
 Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/probe=2Eh:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1741/comment/e0ed0659_14c6a5f8?usp=3Demail">Patch =
Set #23, Line 53:</a> <code style=3D"font-family:monospace,monospace"> * co=
nnect_lifetime and flags (u16 each) */</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">WIthout having=
 the size of priority, weight and max_leatency here in the header, the 5 is=
 basically  [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Moved both length macros below the=
 structs, so the five u16 fields are now the<br>lines right above PROBE_REP=
LY_LEN=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Spelling the sum out per field needs an ugly one-liner, since=
 clang-format joins<br>multi-line defines=2E</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/7b497dd6_fe070c48?usp=3Dem=
ail">Patch Set #23, Line 69:</a> <code style=3D"font-family:monospace,monos=
pace">/* the other addresses of this remote are distinct servers, so probe =
them too */</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">Maybe use doxygen style here?</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done=2E Left &quot;/* probe reply flags */&quot; plain, since as /** =
doxygen would attach it<br>to RESEND_WKC, which has its own comment=2E</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be3694=
37388268 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1741 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 26 </div>
<div style=3D"d=
isplay:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: chugly &lt;charlie=2Evigue@openvpn=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Mon, 16 Nov 2026 15:05:12 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></ht=
ml>
--GLYQXS1DePM=--


--===============3059183962306587309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3059183962306587309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3059183962306587309==--

